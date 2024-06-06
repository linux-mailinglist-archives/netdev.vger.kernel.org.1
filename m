Return-Path: <netdev+bounces-101591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385F8FF833
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E001F23CC9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4744D9E9;
	Thu,  6 Jun 2024 23:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="s7MyJRqf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F717C68
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716804; cv=none; b=l/IgWrf8V37WWCtIvzm1adnNGMMSK3O237N5lNosxhAkuZMnwLCDNFOqPG2whBRdV7VWlp8TqA6bYT4U9PaX2R5PulJvRtGLSnAUR0nAIvhQltU9P2wU0v3c/MfjSQJq2iz7Qpcdfx+S43Z7brCbIK2wT11Jj6xrquvMAUKP9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716804; c=relaxed/simple;
	bh=f4C9zDMY76hXQmvr501SUyMdwcW+tUxmEjc3S1vqn7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNTZPlxmhZQnbkxjl0qFqdhoGJkHNoySoZEXYCu1nnB1AInJIwPpofH/O8giKXvIlmNq/HIdWVRp8b9ryYRuPipB/BVXfga4999rKlfYNKjNAlUlekC3gWELS2jRQYIOLr9go1a489qxISD6ozwGTcEOkPPs7CpFy/9xFWZZY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=s7MyJRqf; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717716803; x=1749252803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSQU1F5HIIh2INAncAKQAnXqwpzSLHav/b8BrB/6qDo=;
  b=s7MyJRqfZPMGq6Hgrd20Nk/B1aQi5j9RnGcK+jUmyAwsTqFmgswPrW72
   Resn0JT+fV2UP0f3XTRYuhFSQF7h0/jS4IACAE5bCk/Mu7dly+a/4MOg8
   4Hd4JsiU4VGfxav4TBcbrBPbZ4pOuzcRM6NdBhDHfAsrYMPiocfuncHhu
   M=;
X-IronPort-AV: E=Sophos;i="6.08,219,1712620800"; 
   d="scan'208";a="348986780"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 23:33:16 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:39463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.111:2525] with esmtp (Farcaster)
 id ddbd1c1a-9059-44ea-ae6c-c61405f0601f; Thu, 6 Jun 2024 23:33:15 +0000 (UTC)
X-Farcaster-Flow-ID: ddbd1c1a-9059-44ea-ae6c-c61405f0601f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 23:33:14 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 6 Jun 2024 23:33:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@gmail.com>, <edumazet@google.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: move rtnl_lock handling out of af_netlink
Date: Thu, 6 Jun 2024 16:33:03 -0700
Message-ID: <20240606233303.37245-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240606192906.1941189-2-kuba@kernel.org>
References: <20240606192906.1941189-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu,  6 Jun 2024 12:29:05 -0700
> Now that we have an intermediate layer of code for handling
> rtnl-level netlink dump quirks, we can move the rtnl_lock
> taking there.
> 
> For dump handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE we can
> avoid taking rtnl_lock just to generate NLM_DONE, once again.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/rtnetlink.c     | 9 +++++++--
>  net/netlink/af_netlink.c | 2 --
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 4668d6718040..eabfc8290f5e 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -6486,6 +6486,7 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  
>  static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  {
> +	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
>  	rtnl_dumpit_func dumpit = cb->data;
>  	int err;
>  
> @@ -6495,7 +6496,11 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>  	if (!dumpit)
>  		return 0;
>  
> +	if (needs_lock)
> +		rtnl_lock();
>  	err = dumpit(skb, cb);
> +	if (needs_lock)
> +		rtnl_unlock();

This calls netdev_run_todo() now, is this change intended ?

Other parts look good to me.


>  
>  	/* Old dump handlers used to send NLM_DONE as in a separate recvmsg().
>  	 * Some applications which parse netlink manually depend on this.
> @@ -6515,7 +6520,8 @@ static int rtnetlink_dump_start(struct sock *ssk, struct sk_buff *skb,
>  				const struct nlmsghdr *nlh,
>  				struct netlink_dump_control *control)
>  {
> -	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
> +	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE ||
> +	    !(control->flags & RTNL_FLAG_DUMP_UNLOCKED)) {
>  		WARN_ON(control->data);
>  		control->data = control->dump;
>  		control->dump = rtnl_dumpit;
> @@ -6703,7 +6709,6 @@ static int __net_init rtnetlink_net_init(struct net *net)
>  	struct netlink_kernel_cfg cfg = {
>  		.groups		= RTNLGRP_MAX,
>  		.input		= rtnetlink_rcv,
> -		.cb_mutex	= &rtnl_mutex,
>  		.flags		= NL_CFG_F_NONROOT_RECV,
>  		.bind		= rtnetlink_bind,
>  	};
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index fa9c090cf629..8bbbe75e75db 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2330,8 +2330,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
>  
>  		cb->extack = &extack;
>  
> -		if (cb->flags & RTNL_FLAG_DUMP_UNLOCKED)
> -			extra_mutex = NULL;
>  		if (extra_mutex)
>  			mutex_lock(extra_mutex);
>  		nlk->dump_done_errno = cb->dump(skb, cb);
> -- 
> 2.45.2

