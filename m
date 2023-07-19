Return-Path: <netdev+bounces-18815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE63758BA6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 04:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DEB281758
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 02:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EBA17D1;
	Wed, 19 Jul 2023 02:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC417C4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 02:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE68C433C7;
	Wed, 19 Jul 2023 02:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689735508;
	bh=D6w6EeYtNDLWbQlw/yP+9AleWHyemKxx0ltn0aIqius=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sWcU+iZQs3Ox31kZv4QQmp8MUgq1weM87kotu6Q3oyurJyGlZ7xdJ81CFTMkXfZXh
	 uL4gePmvjrAboUQ2Chf+Z5iCQNUvNc9bfWn/GO4ViWWCLwfHieGGNATid1/xgfzk3w
	 EUpNU7JfnVkqI4Sy7mrIt4bsXQ0Y3b1/WW4e3Hl6w9UKKb9XYPV67W5iAaMkjczF8k
	 cCPQWZzDY85wWkLEUJJQd4OTBV8DAfElP0GbWXh9NogjjeEkK8PLM3Ef7oVEKroNg9
	 /4GTXF1JrIxnAl2oZ5x15BUKbrfgm+NTswyk1M0UXqLrCiocijxuRQMCTNiV1tr0W8
	 vi0zphRMFfnbw==
Date: Tue, 18 Jul 2023 19:58:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 dev@openvswitch.org, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar
 <pshelar@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Davide Caratti <dcaratti@redhat.com>,
 Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: handle the exp removal problem with
 ovs upcall properly
Message-ID: <20230718195827.4c1db980@kernel.org>
In-Reply-To: <cover.1689541664.git.lucien.xin@gmail.com>
References: <cover.1689541664.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Jul 2023 17:09:16 -0400 Xin Long wrote:
> With the OVS upcall, the original ct in the skb will be dropped, and when
> the skb comes back from userspace it has to create a new ct again through
> nf_conntrack_in() in either OVS __ovs_ct_lookup() or TC tcf_ct_act().
> 
> However, the new ct will not be able to have the exp as the original ct
> has taken it away from the hash table in nf_ct_find_expectation(). This
> will cause some flow never to be matched, like:
> 
>   'ip,ct_state=-trk,in_port=1 actions=ct(zone=1)'
>   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=1)'
>   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=2),normal'
> 
> if the 2nd flow triggers the OVS upcall, the 3rd flow will never get
> matched.
> 
> OVS conntrack works around this by adding its own exp lookup function to
> not remove the exp from the hash table and saving the exp and its master
> info to the flow keys instead of create a real ct. But this way doesn't
> work for TC act_ct.
> 
> The patch 1/3 allows nf_ct_find_expectation() not to remove the exp from
> the hash table if tmpl is set with IPS_CONFIRMED when doing lookup. This
> allows both OVS conntrack and TC act_ct to have a simple and clear fix
> for this problem in the patch 2/3 and 3/3.

Florian, Pablo, any opinion on these? 
Would you prefer to take them via netfilter?

