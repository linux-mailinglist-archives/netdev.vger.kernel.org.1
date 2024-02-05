Return-Path: <netdev+bounces-69131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A792B849B13
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9B61C21C2E
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1144BA88;
	Mon,  5 Feb 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5gI1Dlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3C4A99C
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137302; cv=none; b=Zy65LAlBr1t/0NiWmGulzFnA6pJtNYKFs7P1plu15uqy8hA/PtUB0TQMYl0gp4IfJthL1t/Awo35sm2pqqqx+DzA4KGVdvr8fmMVhQIhpnLk6V9yb1MaaukJPh/YXunJ7VvziOTMXyMqAu9TKn7qv5vqajzDpr4achw912sR3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137302; c=relaxed/simple;
	bh=afDTocX9HTf1tIIvfSktyFH7qBPDfUBT64uZT3gumqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ps3U5j1iNHHMSgrZ/ml1YfS0Jsrf8VxiRun/tObaSEYFVClwnIbGzhTu3gM2htFK62RTL4wjKrpJ9d/2nurIXYh1EW3jDrNMHNOZEyGzWWMcihFhiztTejfNhBxC6hFMfD021rRfbH+tSi0EgypNOiMESAZmETXT9iu5pnIY6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5gI1Dlo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so7275926276.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137299; x=1707742099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=s5gI1Dlo6KjgxBb8JKMRMDvf4rrmhIz3uzifTvttI2dgTxR3lPyHZ+SpiCqd026ccZ
         rR2QaQMgCiv1Ua9Udf5uGt9ymb34MjrrQizcvU39tWJcCka6IuEnWFVTmZwiI/fyQxyf
         T1IynJxRFCWLEDt98gCjCCDVxL7Zz5CrMjj1l0gD58izFwcThwSlDANo94sgv/7YPQbY
         SN9ynvBEjhoqvzqhDihU4wrkixq8nKbiUoq5HFea3Dn0WkRdxPr/HMHQUwC8djCwC9Tc
         2BHxGYvAY5f8qrFgxnMOWxamEz4zEbXgr5slWdMh/fVK0YzVDjDD40bjnvoSdib7gGUi
         31bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137299; x=1707742099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=Bue59FR0il7vlcrNt5aN8SUBZ2Vd14ICx1bjbsQJSsobc1IBz/UPqyHTBINpm2XsYb
         nM0OG2JPAnh2nZNSSB3AbDppqJmAakvPdtmm4jTd8LV3juU2dtGzI04KCJ0WQNuMf1xg
         TzaK8Y0D94Vfx4ALA1pScEnWZUNK/Tyct8ukd4YAI9IO4i1LTd9tVKsBW+5lq4J+VSZr
         UIIx0GXO0G4op8maUeL3K5nFPa8E9aOBvvyjEwW/vmbfiqvLP+RHZhjzMUFEk65YtLkt
         1X5BVAsXfuI2rqx50VsESWDPbHgzT6bVRgqRnpZLyDdwliT3hkroV2hsySk2yA3XYDCI
         Ar1A==
X-Gm-Message-State: AOJu0Yzh2eoEvBZk895YL3l6ZVP6P/N+LW/YzLp5HzNB9E1uXFYlq+Jc
	f/tOOIk669xXvb0b67cSmiiChciuG88udENLLbCzNczqM5cODMhYo3vWErK/HU+69ZxHJmIItH4
	wUn0HO5u/pA==
X-Google-Smtp-Source: AGHT+IE+UTnSFHiX+DRxVzuWboOTqytBe696l3Iu6f+rqwfrb/xeRiCjaBex8zDGasapskJCYngRJ/zJiK4ZHQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2509:b0:dc2:4fff:75e9 with SMTP
 id dt9-20020a056902250900b00dc24fff75e9mr2907774ybb.8.1707137299365; Mon, 05
 Feb 2024 04:48:19 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:50 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-14-edumazet@google.com>
Subject: [PATCH v3 net-next 13/15] ip_tunnel: use exit_batch_rtnl() method
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


