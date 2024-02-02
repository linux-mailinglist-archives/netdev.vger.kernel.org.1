Return-Path: <netdev+bounces-68627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C21847664
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8DC1C24ADC
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6D150998;
	Fri,  2 Feb 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cj66Uc5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08F14AD31
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895631; cv=none; b=FugMtnn9qmvw9B4GJZJPNK5jU9wFX3kCoabyqFij2tFByjvaRocHyHabq46tk3e5k4Ew3rMl3M7qPgPfRAq3U4P75W27DuJ9tQEdflCZvWbXNxznaq9wmn11fvtJEmijkqGPxi/yeva1f+DaSplZaPRZ9l0Uh2WDZnqQPlvemg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895631; c=relaxed/simple;
	bh=afDTocX9HTf1tIIvfSktyFH7qBPDfUBT64uZT3gumqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DAmLJPX6aYiol7wvlyvNX2quAVTNe3v+521h3S0RcO604kcDXoAqQrymcU8wbz7ZBZ0fIhu0FRd1eMuTeC3FAI9BN2ZBiAKObCjIS88GQ4UYGVbilN3IjQeHlFEKmWwPdUkylHKmtQJKl67iQRqkUeQ2f4v9P/nu3vZmZFcP/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cj66Uc5p; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6bea4c8b9so3185177276.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895628; x=1707500428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=Cj66Uc5p5Hs7zAQuivwq+3erKmKkT1mSOZvx85gUoew7bu5y8j32wa7fWTrfocFX3F
         vgLv9+v4RCMabXboqW2lwzsAZzVjzwPMTDJZRS22cgBsojZN+ndtz1eQh9fjgEjlbQEX
         dyURv/F/5evPRJo94FgK5wi0BxEyW3LFDmCoYD8BH2pb2hwFwBCAHBfmubhkZ2rGFC3C
         6iE+O7MGyBbKalPAL7HsoWZFqVng/UL+KUyuGUE4kvekp1CuqN2X0vOkYDyno0zLA1Pc
         zXbM7aL8u441XbnHEJAjveItLszHipgawBYlM/Gd9Ik7jkoDBVu9OZ+qlhBL9RHsQv7i
         10eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895628; x=1707500428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pXtlylLvcDONUOD50Ep4x04tWDTEn5b5/uJw7/Q9v0=;
        b=g3oigH64/JwrbN0PyLELePLUoSVjVZGufKyrYReFX5n1LDhBk+IPk6nqxR/o5VDLlC
         mp4lDhvWgd8i5nr8wyRBh09y0rnmApujWg5wyG33R5otFrtzSAmbo33GpkWo7OE/msmz
         0v+on8VGGkQBAB09H51qgc9WwThEyA6c752EXQxk3ircSMxEiMgTpx+5cd/i5fx9SNgT
         SjRL/0UOWv23aY14bTQ1v7j5J14zJV3/ovKAdpDTqN7L2ibjEsJWDOV+Lrjmv4WMWX70
         p9hpE1G+Nq1+8h/tDaVSSQqF6IeJ6Vi/wz/alpqm0a30HOF+AARiXOnuy3Q1HEvCNHig
         MThQ==
X-Gm-Message-State: AOJu0Yws6NDDohfqg7FcYoQnT+Nopz0eSINomTyR0mRAj20liLnFNoB/
	CWhNwvK7sWJlh10Hxqbx60SHJttbs6Lutqt57/jHGbr0DYLd+1TtMvfLDPDOn0ua3+f30SJ8dk8
	NKJPDcUhBnA==
X-Google-Smtp-Source: AGHT+IHNVQsDQKib9kosug2EninK4FeCftDtsiGrOz/msbbBHqCOnnUvU+SitTT/u70ULsSUvTjRf5EaoOp93g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2306:b0:dc2:5130:198f with SMTP
 id do6-20020a056902230600b00dc25130198fmr144169ybb.5.1706895628525; Fri, 02
 Feb 2024 09:40:28 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:59 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/16] ip_tunnel: use exit_batch_rtnl() method
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


