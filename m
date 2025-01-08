Return-Path: <netdev+bounces-156256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E642A05B94
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952F03A7C3C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EA1F941E;
	Wed,  8 Jan 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="recvbAwJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646411F940C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339160; cv=none; b=rePfbNB0PcWO60gIexp/VgU5vxplCPKxWY8Uh7waw5Z37R9Tn+jhCIjF9JqcJ+MgSXYuuyJ2/fW573scsAeUpPtX6l9LEdLStetSKb9hNKd38gRsEGuwIT2w8EdULGl2CUpE88VL6/lY7NIsDm8V5C/GqL6vAEr8mS8XfiqpPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339160; c=relaxed/simple;
	bh=Mn/N1huDYdu6nv9STv5yEWdR6DZaFixVxNS5qTBzKJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apCDL7mykFBqIvDzMwPKHS9Sc6/LSLp+z8AgleN6yUAeI6YWuqAF3MAUtESa2rBH3Cu7ZFzjTfC88r+X0TGpVwY1nF3x1Vu6i3m3H9ThF05TK7wwzjxBs/Q8EJhc10UioJXYNuJIeiObpul7bQlLOXn7tPRVKh+R18eYxlRBwGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=recvbAwJ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736339162; x=1767875162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nSB8bQwLp1yB6/uQAaKV9iOr0cu9cQYER2yc+/u2YHs=;
  b=recvbAwJzc3cJRdH0iFAL3pGPJWZZw+KG/F9E1X0g+BG85aCZu0pGiir
   Ez17tGiBrf6QoQEtmxutVgpoYZ2cxGv77m7fWQQ02HmxHYVmAQmPDeFpt
   UZciuxNzHVA5PcZBQLpT06lh4NjkpBY4ibriGMQygC5HJpX3cTkc5uva5
   4=;
X-IronPort-AV: E=Sophos;i="6.12,298,1728950400"; 
   d="scan'208";a="789611142"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 12:25:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:17962]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.146:2525] with esmtp (Farcaster)
 id 432aca10-f766-42de-9999-8742901e1ead; Wed, 8 Jan 2025 12:25:52 +0000 (UTC)
X-Farcaster-Flow-ID: 432aca10-f766-42de-9999-8742901e1ead
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 12:25:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 12:25:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<laforge@gnumonks.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<pablo@netfilter.org>, <shaw.leon@gmail.com>
Subject: Re: [PATCH v1 net 1/3] gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
Date: Wed, 8 Jan 2025 21:25:36 +0900
Message-ID: <20250108122536.51089-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250108104040.GA7706@kernel.org>
References: <20250108104040.GA7706@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Wed, 8 Jan 2025 10:40:40 +0000
> On Wed, Jan 08, 2025 at 03:28:32PM +0900, Kuniyuki Iwashima wrote:
> > gtp_newlink() links the gtp device to a list in dev_net(dev).
> > 
> > However, even after the gtp device is moved to another netns,
> > it stays on the list but should be invisible.
> > 
> > Let's use for_each_netdev_rcu() for netdev traversal in
> > gtp_genl_dump_pdp().
> > 
> > Note that gtp_dev_list is no longer used under RCU, so list
> > helpers are converted to the non-RCU variant.
> > 
> > Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> > Reported-by: Xiao Liang <shaw.leon@gmail.com>
> > Closes: https://lore.kernel.org/netdev/CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Harald Welte <laforge@gnumonks.org>
> 
> ...
> 
> > @@ -2280,7 +2281,10 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
> >  		return 0;
> >  
> >  	rcu_read_lock();
> > -	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
> > +	for_each_netdev_rcu(net, dev) {
> > +		if (dev->rtnl_link_ops != &gtp_link_ops)
> > +			continue;
> > +
> >  		if (last_gtp && last_gtp != gtp)
> >  			continue;
> >  		else
> 
> Hi Iwashima-san,
> 
> With this change gtp seems to be uninitialised here.
> And, also, it looks like gn is now set but otherwise unused in this function.
> 
> Flagged by W=1 builds with clang-19.

Ah, thank you for catching these !

I'll squash this to v2.

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b905b7bc46cb..0d03e150efc6 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2298,9 +2298,6 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct net *net = sock_net(skb->sk);
 	struct net_device *dev;
 	struct pdp_ctx *pctx;
-	struct gtp_net *gn;
-
-	gn = net_generic(net, gtp_net_id);
 
 	if (cb->args[4])
 		return 0;
@@ -2310,6 +2307,8 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 		if (dev->rtnl_link_ops != &gtp_link_ops)
 			continue;
 
+		gtp = netdev_priv(dev);
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
---8<---

