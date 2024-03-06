Return-Path: <netdev+bounces-77996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE96873B75
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAFC1C22B72
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408A137936;
	Wed,  6 Mar 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M01EJlU4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D994136998
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740852; cv=none; b=WusJf6Iub+7aMMBI6bVE2/EqdvwVMwVT/xu56cAXM6d7LzxwONcEROoVuk47v9Xl4X+d+QmTofUghHCFzsuKLwQV3AHSC55Qtq24X7fvIB6seGtF8s08cRWDyiRuvSJ3dbjrOODI6I1ofrk1G1WnzuCWj20QntTxxmHsz2+TjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740852; c=relaxed/simple;
	bh=MgQ7bW4+E3Jxaoa83pBNP1QjdJSImfMpuDEUph0mqO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3yr9OzW4418NrSiGWR4hobNxZO87cYBz2suzjE1Vm4FV/GcVS/BbSPfiTXgrsfhTbkq9La+PwMv6Y6fLa9Bo1Gsag2Pu4Q6F1FbQcsYrDGQp9pYIBywf7p23NK+rl/9K7C47fJTx6LPGEi6F8gRNnlgdqAyzJXnQCnXmciKcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M01EJlU4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso12045239276.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740850; x=1710345650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WLpVDXMV6KhDn8Nv4o048oZYVIssSOAdchwz6e7oWZ8=;
        b=M01EJlU4tv5SP6TpFbxdMV+1V+xpO5akHJMUeXEDc4cUnObnuKAS+kq5bhGIHB52sg
         XTTZaJgE0tadvpgDnOxntJ0z7be2z1uBOUz5InAsj3gerOU4FgzZp2Faq/7C23bx6llp
         UULP+3KM6pl8U0XJ2GqIgmPuAGnqj8mtQK5RKqeBpBxMYeAn3ulPiHU7a/1lzQW0vPpn
         aPtka0BPMUbwrSLSnR7cEoSXffWwl8CDrVWPwlwvHI2IYIu9tNOeLAX/vPisGJAYgF87
         1BOieMZglfgEItAF7ne+PKwGAlBU97WieQtICVzPU0pr1mUdKncMM56lSERhzk5p15CP
         C6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740850; x=1710345650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLpVDXMV6KhDn8Nv4o048oZYVIssSOAdchwz6e7oWZ8=;
        b=FKjULk8j1yx9IF7pA7k9wIJpbmHCnm39ejJu/Pl7BY8LFwPzCGUG5IieHl14M+VUg6
         sIMeE+fAnqSGp2IN7AbhMn52fsHGcyIERSSjHGCWBzypg81pmFv7jPxYKqjhCtM1/b71
         Jl+j2aESw7cixqoDEkNooKXCmW0q4gEC83+HWfjdeMynWDilqX93xmfSHqIvHK0uRsCL
         flvGfHZrKPPggkB/4MbgWodvz3mZzXI8UY3HmnKqnRAEAzLsAWuhhDH7lwMpWFxrlW2T
         aY5BNm5p5Y+6JkfudwBf1SHDOFpK5DoZ3qtowiEFLp5cQhrcoQWyI0WGWIVM3YYlrqwS
         D39g==
X-Forwarded-Encrypted: i=1; AJvYcCXkc5QE88LPMiFA6fYjMCba6HQogCach2UC0HpYJBUNCX8U1fO/+10VuF+jWK7lmjai6UAfx60SuaM2VCDD50oNNh7Q6kUk
X-Gm-Message-State: AOJu0YzJR1RbOV0oAT0Ce7hxP53wyA7LCcToR0n+APm4mKZ/xLWSnoSY
	6kKMjsurY8sLNqjktDR08N2U7xSP7+V8JN6AJIgdoOvC8WPOG9thZNeMZb1yA570u7zMj6K7Wlg
	gZEym4gd0Vg==
X-Google-Smtp-Source: AGHT+IGNs/PstXwFgoaPvgLhkFIkV3YgK1l/zuuLccrJ1SFL4jnauHdDA6HNCl94MTwf7a6UIeGZ5/rWaKlyEw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f0d:b0:dcd:4286:4498 with SMTP
 id et13-20020a0569020f0d00b00dcd42864498mr531916ybb.6.1709740850487; Wed, 06
 Mar 2024 08:00:50 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:19 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/18] net: move ip_packet_offload and
 ipv6_packet_offload to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are used in GRO and GSO paths.

v2: ipv6_packet_offload definition depends on CONFIG_INET

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h  |  5 +++++
 net/ipv4/af_inet.c     | 18 +++++++++---------
 net/ipv6/ip6_offload.c | 18 +++++++++---------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index dc50b200a94b6b935cd79d8e0406a61209fdc68e..d8ce20d3215d3cf13a23fa81619a1c52627f2913 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -3,9 +3,14 @@
 #define _NET_HOTDATA_H
 
 #include <linux/types.h>
+#include <linux/netdevice.h>
 
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
+#if IS_ENABLED(CONFIG_INET)
+	struct packet_offload	ip_packet_offload;
+	struct packet_offload	ipv6_packet_offload;
+#endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
 	int			gro_normal_batch;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 5daebdcbca326aa1fc042e1e1ff1e82a18bd283d..08dda6955562ea6b89e02b8299b03ab52b342f27 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1904,14 +1904,6 @@ static int ipv4_proc_init(void);
  *	IP protocol layer initialiser
  */
 
-static struct packet_offload ip_packet_offload __read_mostly = {
-	.type = cpu_to_be16(ETH_P_IP),
-	.callbacks = {
-		.gso_segment = inet_gso_segment,
-		.gro_receive = inet_gro_receive,
-		.gro_complete = inet_gro_complete,
-	},
-};
 
 static const struct net_offload ipip_offload = {
 	.callbacks = {
@@ -1938,7 +1930,15 @@ static int __init ipv4_offload_init(void)
 	if (ipip_offload_init() < 0)
 		pr_crit("%s: Cannot add IPIP protocol offload\n", __func__);
 
-	dev_add_offload(&ip_packet_offload);
+	net_hotdata.ip_packet_offload = (struct packet_offload) {
+		.type = cpu_to_be16(ETH_P_IP),
+		.callbacks = {
+			.gso_segment = inet_gso_segment,
+			.gro_receive = inet_gro_receive,
+			.gro_complete = inet_gro_complete,
+		},
+	};
+	dev_add_offload(&net_hotdata.ip_packet_offload);
 	return 0;
 }
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index cca64c7809bee9a0360cbfab6a645d3f8d2ffea3..b41e35af69ea2835aa47d6ca01d9b109d4092462 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -419,14 +419,6 @@ static int ip4ip6_gro_complete(struct sk_buff *skb, int nhoff)
 	return inet_gro_complete(skb, nhoff);
 }
 
-static struct packet_offload ipv6_packet_offload __read_mostly = {
-	.type = cpu_to_be16(ETH_P_IPV6),
-	.callbacks = {
-		.gso_segment = ipv6_gso_segment,
-		.gro_receive = ipv6_gro_receive,
-		.gro_complete = ipv6_gro_complete,
-	},
-};
 
 static struct sk_buff *sit_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
@@ -486,7 +478,15 @@ static int __init ipv6_offload_init(void)
 	if (ipv6_exthdrs_offload_init() < 0)
 		pr_crit("%s: Cannot add EXTHDRS protocol offload\n", __func__);
 
-	dev_add_offload(&ipv6_packet_offload);
+	net_hotdata.ipv6_packet_offload = (struct packet_offload) {
+		.type = cpu_to_be16(ETH_P_IPV6),
+		.callbacks = {
+			.gso_segment = ipv6_gso_segment,
+			.gro_receive = ipv6_gro_receive,
+			.gro_complete = ipv6_gro_complete,
+		},
+	};
+	dev_add_offload(&net_hotdata.ipv6_packet_offload);
 
 	inet_add_offload(&sit_offload, IPPROTO_IPV6);
 	inet6_add_offload(&ip6ip6_offload, IPPROTO_IPV6);
-- 
2.44.0.278.ge034bb2e1d-goog


