Return-Path: <netdev+bounces-69520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C184B832
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C161F22D40
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE1132C1C;
	Tue,  6 Feb 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22khMYF4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC42133436
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230624; cv=none; b=iQYxGHxsv5XTUWLdcyAhwqLGRE/aa8TGwGW9lhdxi0FNOjKxb1FgC23pRfiTZ2HEnT6kKLmy+vDGqcu3JHnsTIPiEO4eFSlVrV93AfGP9U2gVmPoF36VY5UtwOzL161DXc71ZluiilRY6aS/V7T0ja1nefUNMla/dB1NHPcFnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230624; c=relaxed/simple;
	bh=afDTocX9HTf1tIIvfSktyFH7qBPDfUBT64uZT3gumqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nWl3d4A2Pk6zhKmcmtPq8Z6J9hxoqc15AubD5lsnR5b9GZFY5uSMCrhNx/Skip3ngnnaNINT82YVtzLarCmqtUJU5iBol5yOki5OlFQ7o+0Mjwp12YGDr5MwMoScBYg5faRe49hme1o6ZBz+cz4gFYr8GDhJ4CQijAHTQ2JhOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22khMYF4; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42c25ba5aa1so26363331cf.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230621; x=1707835421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=22khMYF4CsTaz0pi8UMTBUr6qxgprg3lM0YRKHAoUBx/T6l+dwb27Mkk2MCfyA615f
         Xpst/8NolBqlhvm6igOyU7Ll+eS1dY5cSnrrRLm7jYWA5RNzIeGMUFAoH0aF01aMqcmU
         1D5WSj2BqNm6eCRyh2XsUIa7+sBbqP4lpDxtkrBHVesATHTEM5iwHx3Qmy4PIT6Umbbv
         6p9zuHP1UVwc78kbsrvxo/7eBnpG0ShnTNTOR2vgqAdPO2fjMTzSbPndaD3VWMHJ2Nj3
         oSSrhCJZcbh7m419MgikWusix6KPrlLwJvjsOtgzONYIUcavHLQx4Yegem43wtZ/Esgt
         L61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230621; x=1707835421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=LdT3nN0HBu7z1wMSd20I9gkIp6n7qxoY1i3fSipCWeYl0XElqwMgyONpi0ZOSP3T57
         xWbIjGp7dB5936qFIr2P5cXr0fr/sQohedliCuNSLZAQGfmSCgE+bESNvKN0P9pYbSh7
         1Z07BoXk27sU2DbwxwkYGGSYyuWu7b7fJ7PrbSsaM9HvDbyO7ben4Sf0lFfNqi9shHu9
         cY1r6IL8o2pFQ/hqLLbpVtTNpXqs6isKEfG5XIpKyfN5XNpi5gngvmAD2mR5UXE4v7Z1
         wSTfz8/OSRC3M9Qg8HI8U1gYYG3i34HZK9UTQwaH+y3iZ76a71aPXjG8tdoOr1jTcIQh
         XxzA==
X-Gm-Message-State: AOJu0YzwbztUc84cHMgozqVCLeZeTt3HiJ4yuehlspg37lMGhN27XtQu
	Wo0mrf7zgMEGyCp8NfSCsB0bxdFeD+D0qt9JqzJ7c76n/o2H0NG9R8sOzZNU1kEutgWp+PlLBCM
	E6FpoISul8w==
X-Google-Smtp-Source: AGHT+IG35WEQqd2WbvtB17ipyDkzjCNcenARjeKi/r3QOthmQTLpIBiZyHyiw/8O3BL09sjOOS4tAaS7+H7k4g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:5a93:0:b0:42c:1f1c:b240 with SMTP id
 c19-20020ac85a93000000b0042c1f1cb240mr122265qtc.8.1707230621375; Tue, 06 Feb
 2024 06:43:41 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:10 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-15-edumazet@google.com>
Subject: [PATCH v4 net-next 13/15] ip_tunnel: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

This patch takes care of ipip, ip_vti, and ip_gre tunnels.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip_tunnels.h |  3 ++-
 net/ipv4/ip_gre.c        | 24 +++++++++++++++---------
 net/ipv4/ip_tunnel.c     | 10 ++++------
 net/ipv4/ip_vti.c        |  8 +++++---
 net/ipv4/ipip.c          |  8 +++++---
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 2d746f4c9a0a4792bc16971c107d598190897433..5cd64bb2104df389250fb3c518ba00a3826c53f7 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -284,7 +284,8 @@ int ip_tunnel_init_net(struct net *net, unsigned int ip_tnl_net_id,
 		       struct rtnl_link_ops *ops, char *devname);
 
 void ip_tunnel_delete_nets(struct list_head *list_net, unsigned int id,
-			   struct rtnl_link_ops *ops);
+			   struct rtnl_link_ops *ops,
+			   struct list_head *dev_to_kill);
 
 void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		    const struct iphdr *tnl_params, const u8 protocol);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5169c3c72cffe49cef613e69889d139db867ff74..aad5125b7a65ecc770f1b962ac5b417bd931e3ba 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1025,14 +1025,16 @@ static int __net_init ipgre_init_net(struct net *net)
 	return ip_tunnel_init_net(net, ipgre_net_id, &ipgre_link_ops, NULL);
 }
 
-static void __net_exit ipgre_exit_batch_net(struct list_head *list_net)
+static void __net_exit ipgre_exit_batch_rtnl(struct list_head *list_net,
+					     struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, ipgre_net_id, &ipgre_link_ops);
+	ip_tunnel_delete_nets(list_net, ipgre_net_id, &ipgre_link_ops,
+			      dev_to_kill);
 }
 
 static struct pernet_operations ipgre_net_ops = {
 	.init = ipgre_init_net,
-	.exit_batch = ipgre_exit_batch_net,
+	.exit_batch_rtnl = ipgre_exit_batch_rtnl,
 	.id   = &ipgre_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
@@ -1697,14 +1699,16 @@ static int __net_init ipgre_tap_init_net(struct net *net)
 	return ip_tunnel_init_net(net, gre_tap_net_id, &ipgre_tap_ops, "gretap0");
 }
 
-static void __net_exit ipgre_tap_exit_batch_net(struct list_head *list_net)
+static void __net_exit ipgre_tap_exit_batch_rtnl(struct list_head *list_net,
+						 struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, gre_tap_net_id, &ipgre_tap_ops);
+	ip_tunnel_delete_nets(list_net, gre_tap_net_id, &ipgre_tap_ops,
+			      dev_to_kill);
 }
 
 static struct pernet_operations ipgre_tap_net_ops = {
 	.init = ipgre_tap_init_net,
-	.exit_batch = ipgre_tap_exit_batch_net,
+	.exit_batch_rtnl = ipgre_tap_exit_batch_rtnl,
 	.id   = &gre_tap_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
@@ -1715,14 +1719,16 @@ static int __net_init erspan_init_net(struct net *net)
 				  &erspan_link_ops, "erspan0");
 }
 
-static void __net_exit erspan_exit_batch_net(struct list_head *net_list)
+static void __net_exit erspan_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(net_list, erspan_net_id, &erspan_link_ops);
+	ip_tunnel_delete_nets(net_list, erspan_net_id, &erspan_link_ops,
+			      dev_to_kill);
 }
 
 static struct pernet_operations erspan_net_ops = {
 	.init = erspan_init_net,
-	.exit_batch = erspan_exit_batch_net,
+	.exit_batch_rtnl = erspan_exit_batch_rtnl,
 	.id   = &erspan_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index beeae624c412d752bd5ee5d459a88f57640445e9..00da0b80320fb514bca58de7cd13894ab49a2ca6 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1130,19 +1130,17 @@ static void ip_tunnel_destroy(struct net *net, struct ip_tunnel_net *itn,
 }
 
 void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
-			   struct rtnl_link_ops *ops)
+			   struct rtnl_link_ops *ops,
+			   struct list_head *dev_to_kill)
 {
 	struct ip_tunnel_net *itn;
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		itn = net_generic(net, id);
-		ip_tunnel_destroy(net, itn, &list, ops);
+		ip_tunnel_destroy(net, itn, dev_to_kill, ops);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 9ab9b3ebe0cd1a9e95f489d98c5a3d89c7c0edf6..fb1f52d2131128a39ab5bf0482359b7b75989fb6 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -510,14 +510,16 @@ static int __net_init vti_init_net(struct net *net)
 	return 0;
 }
 
-static void __net_exit vti_exit_batch_net(struct list_head *list_net)
+static void __net_exit vti_exit_batch_rtnl(struct list_head *list_net,
+					   struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, vti_net_id, &vti_link_ops);
+	ip_tunnel_delete_nets(list_net, vti_net_id, &vti_link_ops,
+			      dev_to_kill);
 }
 
 static struct pernet_operations vti_net_ops = {
 	.init = vti_init_net,
-	.exit_batch = vti_exit_batch_net,
+	.exit_batch_rtnl = vti_exit_batch_rtnl,
 	.id   = &vti_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 27b8f83c6ea200314f41a29ecfea494b9ddef2ca..0151eea06cc50bec4ae64f08ca6a7161e3cbf9ae 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -592,14 +592,16 @@ static int __net_init ipip_init_net(struct net *net)
 	return ip_tunnel_init_net(net, ipip_net_id, &ipip_link_ops, "tunl0");
 }
 
-static void __net_exit ipip_exit_batch_net(struct list_head *list_net)
+static void __net_exit ipip_exit_batch_rtnl(struct list_head *list_net,
+					    struct list_head *dev_to_kill)
 {
-	ip_tunnel_delete_nets(list_net, ipip_net_id, &ipip_link_ops);
+	ip_tunnel_delete_nets(list_net, ipip_net_id, &ipip_link_ops,
+			      dev_to_kill);
 }
 
 static struct pernet_operations ipip_net_ops = {
 	.init = ipip_init_net,
-	.exit_batch = ipip_exit_batch_net,
+	.exit_batch_rtnl = ipip_exit_batch_rtnl,
 	.id   = &ipip_net_id,
 	.size = sizeof(struct ip_tunnel_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


