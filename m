Return-Path: <netdev+bounces-19056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99601759722
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544E028193F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33214002;
	Wed, 19 Jul 2023 13:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6313FEF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 13:31:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E84119
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689773469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DzDOWCMRDvW/x+kyLxYTwazId0MHyuavP1AnFdCryKQ=;
	b=INEzMU5ZEr/DRHWKfx4o6/6DmfpcsWy+e4BqyF6R1aB8vjG7hAdNvGtBu26bgH39HVnG/+
	iCa9S1VaSLmf/l1rwaApIE3IOfWwpFiwrVcRS71MHuqQQrj9nWtoC5cZxoD7jU9XlxOs9n
	EhKbjG0eOctxYRcNW5N1R+4fZwnQh8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-GyhrAPnqPym9xCBAOyq1lw-1; Wed, 19 Jul 2023 09:31:06 -0400
X-MC-Unique: GyhrAPnqPym9xCBAOyq1lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0E52936D38;
	Wed, 19 Jul 2023 13:31:03 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B41207B315;
	Wed, 19 Jul 2023 13:31:02 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  davem@davemloft.net,  kuba@kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B Shelar
 <pshelar@ovn.org>,  Jamal Hadi Salim <jhs@mojatatu.com>,  Cong Wang
 <xiyou.wangcong@gmail.com>,  Jiri Pirko <jiri@resnulli.us>,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Florian Westphal <fw@strlen.de>,  Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>,  Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 0/3] net: handle the exp removal problem with
 ovs upcall properly
References: <cover.1689541664.git.lucien.xin@gmail.com>
Date: Wed, 19 Jul 2023 09:31:02 -0400
In-Reply-To: <cover.1689541664.git.lucien.xin@gmail.com> (Xin Long's message
	of "Sun, 16 Jul 2023 17:09:16 -0400")
Message-ID: <f7tedl46nah.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> writes:

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
>
> Xin Long (3):
>   netfilter: allow exp not to be removed in nf_ct_find_expectation
>   net: sched: set IPS_CONFIRMED in tmpl status only when commit is set
>     in act_ct
>   openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set
>     in conntrack
>
>  include/net/netfilter/nf_conntrack_expect.h |  2 +-
>  net/netfilter/nf_conntrack_core.c           |  2 +-
>  net/netfilter/nf_conntrack_expect.c         |  4 +-
>  net/netfilter/nft_ct.c                      |  2 +
>  net/openvswitch/conntrack.c                 | 78 +++------------------
>  net/sched/act_ct.c                          |  3 +-
>  6 files changed, 18 insertions(+), 73 deletions(-)

Hi Xin,

The changes look okay to me, and I don't see anything that immediately
jumps out.  I would like to test it today / tomorrow with the ovs
check-kernel testsuite if you haven't done so already.

-Aaron


