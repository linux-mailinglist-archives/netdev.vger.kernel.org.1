Return-Path: <netdev+bounces-77584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB34872396
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F10B1C22B9C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153C128830;
	Tue,  5 Mar 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIs46S5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38ED128385
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654668; cv=none; b=rO98WTnBEAl7tkVIEB/DrYK2gDFW1Mk0rqIWBGzUkSA3uSW2k+c0dNH6hzaGgJ+oBfgyDchd0e0VyuZfplwEGHAIMl0Fyk+sMX1AuWnX1GShZHLnFutsF+OdDmNejvJ+03QJaUldFVWjy/3CnnfpcH8s70AcjlNqxEEMBIAhLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654668; c=relaxed/simple;
	bh=1TqMyKP5wpIwmazXaRPJbac3u4QVLvg8OenG8Op8gLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r/6tu0fbleL/HAkB2lHtCfbqgpAT3UagkTx5KyYp+3rK/CW+boiO6kvyKSfO0epdGTwee9p/bZYL0JgGVpQzpdJnAArEdmS4+VGYJgfy/Lde9GFz8ulgFHgSgtjvsXkn/lQ8nE9sfTfIMcsGitX9jnOn/r1cJjseMJ6XmfG4V/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIs46S5v; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so7154389276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654666; x=1710259466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsoBf0bFuUIa9NPM7+ThGlhD8PUNm3GCIAPGt/l5R2g=;
        b=MIs46S5vLWm4zB7AVw3Ge91n6CRtPE7fYMrBMBmWE5W/wK0tPQhWPLj/zz4rCDBjxL
         ERSxmDXT+Pt92uXlOWdU/BxS+QQh56xvcz+bSVj6dV1nkoc93cVPs4goRrhJ3Mje9ABn
         afKYFTJjbm8tx8eE2+i27g5E0K+mLhuBztFKXHLrzWVIBVw41993s9+UoBz9qG6rf6hu
         Q+3gsBSdHaVCkiyRgrA9G6gfDl7fzVtkr/AQbwfPE3BDYfzVngCmFc2CUZgHeUy2Q3RJ
         /21xe0ZBfbd2AEjlugVcOZJuEd51Fs/AjAT2img+KuBciFxPFbxnoC7/JhJ5USNAraF/
         D9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654666; x=1710259466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsoBf0bFuUIa9NPM7+ThGlhD8PUNm3GCIAPGt/l5R2g=;
        b=fWDPqpYCQdK1m6VIGeVh+k7nZVIQksZQZ/jIEqqAu6Zl2GeBh0tfCUaR+T60ANCRq6
         gJPxCtgUmsZqb1Da4NQYQCUCcZWFhhv5ajzvpizTdvSDfXXag8B7eG/ELbI/bsKk4G5N
         UZgOcK5fyRbsK+y5td9kIw/fNzXp9QUz0ZglALfMP6h7H1UTdNOhGSd+Cs5FH9bfT4ul
         ZoVHzORajIXIKTFv8sd8G/l1DigPd1dd3uAzTAruT8uoe0LdkKbPjqBqWZbnThDfXWdl
         AOBULUT5sn4uk//Pt7cR6Qsotd2KiG/0D8SodQlOtSBOWtJJLeD9phmWZ7dL4My4jewY
         mQDg==
X-Gm-Message-State: AOJu0Yz3oc2BwyYaBpiaFXQO2wT6+rBGpWZoavzgEl1LJz4qY2Jrpfrp
	iRwBSdAc2iMO5KFZ/qpp1elUCUXqyGYLfNen+assZE+czQWk3Ky8pDhZYK5KpXwWa2u91O0uPxb
	ZUzVRH1L2/A==
X-Google-Smtp-Source: AGHT+IEV9qcXtUrAahx863zMFezlkGq4pLsUazJp6xCIaJC6ovEapmfICwve/gGwzrllzUfw5t+Ef1hzp3jbwg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP
 id w9-20020a056902100900b00dbe387da8efmr416755ybt.1.1709654666018; Tue, 05
 Mar 2024 08:04:26 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:02 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-8-edumazet@google.com>
Subject: [PATCH net-next 07/18] net: move tcpv4_offload and tcpv6_offload to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These are used in TCP fast paths.

Move them into net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h    |  3 +++
 net/ipv4/tcp_offload.c   | 17 ++++++++---------
 net/ipv6/tcpv6_offload.c | 16 ++++++++--------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index ec752d234c5ed4b9c110c9e61c143fe8fc27089e..a4a8df3bc0dea1b4c9589bd70f7ac457ebc5b634 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -4,14 +4,17 @@
 
 #include <linux/types.h>
 #include <linux/netdevice.h>
+#include <net/protocol.h>
 
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
+	struct net_offload	tcpv4_offload;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct packet_offload	ipv6_packet_offload;
+	struct net_offload	tcpv6_offload;
 #endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b955ab3b236d965a38054efa004fe12f03074c70..ebe4722bb0204433936e69724879779141288789 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -345,15 +345,14 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 	return 0;
 }
 
-static const struct net_offload tcpv4_offload = {
-	.callbacks = {
-		.gso_segment	=	tcp4_gso_segment,
-		.gro_receive	=	tcp4_gro_receive,
-		.gro_complete	=	tcp4_gro_complete,
-	},
-};
-
 int __init tcpv4_offload_init(void)
 {
-	return inet_add_offload(&tcpv4_offload, IPPROTO_TCP);
+	net_hotdata.tcpv4_offload = (struct net_offload) {
+		.callbacks = {
+			.gso_segment	=	tcp4_gso_segment,
+			.gro_receive	=	tcp4_gro_receive,
+			.gro_complete	=	tcp4_gro_complete,
+		},
+	};
+	return inet_add_offload(&net_hotdata.tcpv4_offload, IPPROTO_TCP);
 }
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index bf0c957e4b5eaaabc0ac3a7e55c7de6608cec156..4b07d1e6c952957419924c83c5d3ac0e9d0b2565 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -66,15 +66,15 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 
 	return tcp_gso_segment(skb, features);
 }
-static const struct net_offload tcpv6_offload = {
-	.callbacks = {
-		.gso_segment	=	tcp6_gso_segment,
-		.gro_receive	=	tcp6_gro_receive,
-		.gro_complete	=	tcp6_gro_complete,
-	},
-};
 
 int __init tcpv6_offload_init(void)
 {
-	return inet6_add_offload(&tcpv6_offload, IPPROTO_TCP);
+	net_hotdata.tcpv6_offload = (struct net_offload) {
+		.callbacks = {
+			.gso_segment	=	tcp6_gso_segment,
+			.gro_receive	=	tcp6_gro_receive,
+			.gro_complete	=	tcp6_gro_complete,
+		},
+	};
+	return inet6_add_offload(&net_hotdata.tcpv6_offload, IPPROTO_TCP);
 }
-- 
2.44.0.278.ge034bb2e1d-goog


