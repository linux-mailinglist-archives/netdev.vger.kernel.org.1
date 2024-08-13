Return-Path: <netdev+bounces-118159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2434D950CAD
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B5B1F23DEE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7301A7047;
	Tue, 13 Aug 2024 18:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9A1A3BDC
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575521; cv=none; b=YqIY/0v1iDgs8Jj3neUor2I4+RrU2sq/367joUsmH7btCrUmfsE1i8+Lqjf6q1ExgDY+2eC4vpAv7eymiJT7/7rZT92VvL6XHyOP/JrWk7BxCH/BgHuDSoAxn/ucCUsBpkjTQDzvkLXESqTCHQv2SSQ1yRb+ceCeLT/NNhaq5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575521; c=relaxed/simple;
	bh=GjP0NE8jN/694JNItDU+k0EcDObtnocqc8zuTIuRfTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq4uw0VvQIbTmt2wOUhg5UoLIvC9tN2CGNrKypIsnmr1iVHYeFFo7G+c0PjFxJPjFrioSYWeB8EihFThSha7OqL3ecSu74qvM5Tqu9Yj+zMXYWekWIkbN04jF/yLrpzl1yUqsrMANlQk3b8mayvae047HLLvD895tzpKns3LMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdwj3-000410-SS; Tue, 13 Aug 2024 20:58:33 +0200
Date: Tue, 13 Aug 2024 20:58:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, dev@openvswitch.org,
	ovs-dev@openvswitch.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCHv2 net-next] openvswitch: switch to per-action label
 counting in conntrack
Message-ID: <20240813185833.GA15353@breakpoint.cc>
References: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9347d5c1a0b364e88d900b29a616c3f8e5b1ca.1723483073.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> Similar to commit 70f06c115bcc ("sched: act_ct: switch to per-action
> label counting"), we should also switch to per-action label counting
> in openvswitch conntrack, as Florian suggested.
> 
> The difference is that nf_connlabels_get() is called unconditionally
> when creating an ct action in ovs_ct_copy_action(). As with these
> flows:
> 
>   table=0,ip,actions=ct(commit,table=1)
>   table=1,ip,actions=ct(commit,exec(set_field:0xac->ct_label),table=2)
> 
> it needs to make sure the label ext is created in the 1st flow before
> the ct is committed in ovs_ct_commit(). Otherwise, the warning in
> nf_ct_ext_add() when creating the label ext in the 2nd flow will
> be triggered:

With this and https://patchwork.ozlabs.org/project/netfilter-devel/patch/7380c37e2d58a93164b7f2212c90cd23f9d910f8.1721268584.git.lucien.xin@gmail.com/
applied new netns doesn't have conntrack enabled anymore, so

Acked-by: Florian Westphal <fw@strlen.de>

Thanks Xinlong!

