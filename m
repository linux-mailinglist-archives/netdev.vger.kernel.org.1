Return-Path: <netdev+bounces-68134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94282845E34
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E581F243F3
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA716086D;
	Thu,  1 Feb 2024 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LnP2I4Q+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121E160880
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807401; cv=none; b=AXMbfdk382Oq7PtNvKXfTbiUyCMK+BMNjf/RrZZhHSaArG1jwyEvYg6jePeAYlXvNIhMrmPQBEG4YxlAfhzmWRq3KoxG6mWUSm7ZKbquK0S4lzFiyZ2/g0Rkg32pO5taY7CkcT8Bnne5kSpMoKEa5N3pmDuvf5yJcXoKvX68cRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807401; c=relaxed/simple;
	bh=FOxReezdazBmvEjAJeKZdSJ1BUPrjF2JunNblGdihhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXaDMc4SoSbL5BdWp7+m/R05+rTmquQpqg4m5+8eazKt8FG2xj2TXtbKAvo1RntWScxvkbnIuEvpMh0IukhuQbNMx6q3GMDImBP3B8J9vKZEfSoE8mXoY7cYUWSFRtHQDTSDL21wfQHOBhcW436x2K824zycNDDVmni6gCP3qTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LnP2I4Q+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso1950601276.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807398; x=1707412198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PFaOlv58zEocA8NBHCAn/m9vvL2PSKA3vlyhgv0n1k=;
        b=LnP2I4Q+STjj26TyipXpZ0+W3mxo/1Z3HolExRX8gJ/0GPSP0ZV2S3lyCREvp4Y+DL
         gd/5itbgSNOcSeGGrV6AlIPnWTXHh798c/MrdWyVQw5VfbvkwXBTdwIG6izeCMb/JJP9
         4dY84dFTg9gHSvrMjoqY+ERf5FPv0c0sbT2LE56gdOCbpfZIDRK0Uo1B3ER5CDS77v3n
         vpUaWiqdD4Ec6RGMqIdndJPHIEXtHxA//T9Nt3esswzfWSlz3koOxxrDvtB8ip2SIPzy
         501hFwA6sQtqFLpcohvrrcKG2h5t6zxRw7C19px3Fsc+onxm/BpeyPh3Z7W5fUN+4Vuf
         t1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807398; x=1707412198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PFaOlv58zEocA8NBHCAn/m9vvL2PSKA3vlyhgv0n1k=;
        b=lBND+vt2WYY/BH8vEVgX/kqnGSY5rEGqD6B0pNXAnd/rB3Ms6OK3/nXzgEGDoIhNxG
         EQUUNTkDpGxTe+vE1i2jb+4T82ac9WN3ThOG73icy+imDoxtkmxlcAWjI3vVo3R+mkA1
         MWlSyi2qHjbHJLI5lGPBoEvy3svoeZ85x341tjFx5ZxbSd3P2gd99rdthnkmbqlR4SJf
         7q94lD2oTk3rjPs+S4oejExYcgrsM5D9d/1sNzQ7GjR2QODBqQ6dZSqpzNdD9x/E22YP
         aPmD0mlg0znTqPVhQCiLKMgToc8My2qP0dCZ3hKXdN1EeyVI3IctcDlUu+S8uyxFSxRG
         2Klg==
X-Gm-Message-State: AOJu0YxPC0vu6XESxVKObk5+VQIb/8D2gxBkyimRMs0mBdAlzdtUeh1U
	692zdyO4ULePlZeQGQNP+weQxW5HkHNbSmnwyekMzBLKjDBiJegb5JKiXLM7vyMZw8uYHnC0vx7
	OMZBWEInavw==
X-Google-Smtp-Source: AGHT+IGiA7Rta1tXqZt93uH5KkilFngr37YNS9bKD3EiiqZHQeDh9tOs9QiUp9ufxFl88wxY7AUc7UDOir7R1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1a47:b0:dc2:23d8:722d with SMTP
 id cy7-20020a0569021a4700b00dc223d8722dmr1344563ybb.13.1706807398256; Thu, 01
 Feb 2024 09:09:58 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:35 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-15-edumazet@google.com>
Subject: [PATCH net-next 14/16] ip_tunnel: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
2.43.0.429.g432eaa2c6b-goog


