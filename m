Return-Path: <netdev+bounces-183103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5989A8AE1F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459FF1900FBD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6299167DB7;
	Wed, 16 Apr 2025 02:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JILhoxSn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346413AD05
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770075; cv=none; b=WehTKr9q0U/LmTgmswRWcdo8tum14mgQlaweAq2CG970D2g4O7YFA/Lzn6KUOT1S/KUEgF0hP9Dbat8ay18AFnDHeBsFqmsUV47s57FQSSnNsfTDwE0bjxNKT5jaJeCUIwMjC98rgG/zz2vT8p3GtttqHgefKv7DxEIaM+N/wHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770075; c=relaxed/simple;
	bh=1EGqXlfmEioyziBCfFnjP6LHTcq95go9UhArpx1unS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ0uzbVSKe9SJipR8AsXR0aYTGE8u/ibyv+iLS9OQ2mtbr46+gac0ZsCQKd6clrP3kuTb4hl9AihQxZmzoFnmmnhxgX12TGFG9mVfyUG19VN4Ws0H3vgU1raR3zhnQh84ebzioW8CQM6JTB6yGvojfmI0FylatYSOkhzvGWQDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JILhoxSn; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744770074; x=1776306074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gmzt+APjrUj5rs2Uwi9ygQzdRerUJvvngUEd3BcHLVs=;
  b=JILhoxSn4s+bHHkairdcJm/n8REDaV9PdbQwPX00eVmpQmihnnQ+wu7B
   6vW5TK0usfKhLwMuzFrQvS82eGZQR9/Kx9GnzBWKCsPJOqueTeddjxyds
   Y7eGKRmaFW/k3cbkMlJ0EG1NPnB44BkvbGOY6SdMnypc3n23F+AlAILt8
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="84033184"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 02:21:12 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:28263]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 39fe3f70-2a67-4170-9699-aac3b55ff330; Wed, 16 Apr 2025 02:21:11 +0000 (UTC)
X-Farcaster-Flow-ID: 39fe3f70-2a67-4170-9699-aac3b55ff330
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:21:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 02:21:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 3/3] ppp: Split ppp_exit_net() to ->exit_rtnl().
Date: Tue, 15 Apr 2025 19:20:27 -0700
Message-ID: <20250416022059.40422-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415022258.11491-4-kuniyu@amazon.com>
References: <20250415022258.11491-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 14 Apr 2025 19:22:01 -0700
> ppp_exit_net() unregisters devices related to the netns under
> RTNL and destroys lists and IDR.
> 
> Let's use ->exit_rtnl() for the device unregistration part to
> save RTNL dances for each netns.
> 
> Note that we delegate the for_each_netdev_safe() part to
> default_device_exit_batch() and replace unregister_netdevice_queue()
> with ppp_nl_dellink() to align with bond, geneve, gtp, and pfcp.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  drivers/net/ppp/ppp_generic.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 53463767cc43..8cc293e5a585 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -1146,28 +1146,20 @@ static __net_init int ppp_init_net(struct net *net)
>  	return 0;
>  }
>  
> -static __net_exit void ppp_exit_net(struct net *net)
> +static __net_exit void ppp_exit_rtnl_net(struct net *net,
> +					 struct list_head *dev_to_kill)
>  {
>  	struct ppp_net *pn = net_generic(net, ppp_net_id);
> -	struct net_device *dev;
> -	struct net_device *aux;
>  	struct ppp *ppp;
> -	LIST_HEAD(list);
>  	int id;
>  
> -	rtnl_lock();
> -	for_each_netdev_safe(net, dev, aux) {
> -		if (dev->netdev_ops == &ppp_netdev_ops)
> -			unregister_netdevice_queue(dev, &list);
> -	}
> -
>  	idr_for_each_entry(&pn->units_idr, ppp, id)
> -		/* Skip devices already unregistered by previous loop */
> -		if (!net_eq(dev_net(ppp->dev), net))
> -			unregister_netdevice_queue(ppp->dev, &list);
> +		ppp_nl_dellink(ppp->dev, dev_to_kill);

Sorry, this line broke the build, will fix in v2.

pw-bot: cr

