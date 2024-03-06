Return-Path: <netdev+bounces-78004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D150873B7E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE821C218B9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2CB135A63;
	Wed,  6 Mar 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+B1p/0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6413C9D4
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740865; cv=none; b=ejWoriKfl+lo8LIdkZE4a0keu9H2Sz1KbbOc6H+8IX1inf9ri5oBKE5H+bxLppExWZRicHYekNWYhIbgt2DV2V03dpgGx+bADK9E/HvjSCs+cuGifUiLjiTiqnk0pcOo9Icb3xIZonXxd3/sh/gR8kIvUc9ntEGlAOX9D5ggha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740865; c=relaxed/simple;
	bh=Q/XwijER6R+qYN0p3vjy3asKZUPyJXODtTyK+3FMed8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vs2tcAXzc4Ddu9n2fVj4m1UlTXN+Z6Ck7PB68SSH0rD4bHR1zBdqtyi3iG3R1kTq+ZDEeWyUCf+/17WEG+g98Lxsu2s4Z6HjXB8HR+UsJJCxwa63D8mB3OuQYdrsNsXNU4uuJsg7LHbn2KyJfn8s4t23hu0ChdjgwCYXNCnG/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+B1p/0T; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so8729549276.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740863; x=1710345663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2Hgk8n9p4LCBmuuj6kS57w+CBqwKZ1lZeYV+GA9Ymk=;
        b=v+B1p/0TWSOsfn9ITqgXPAO+dCUKEmJqbFes6hyE20lTA520FlKyh+J7szZaTqv4LY
         KRgcLR5lumEV9cCpUp6cw+Iovi25IeWu0rUB6yO7gXVzaQWrtpq2VbgXnpSiIhdx0q9C
         zUYoCRBiDtqJ4JIb7x0XqCr4m+2e9WtfPdrPHkJwCrKX85lidPOuDrTs+ptDJibFnyWg
         93X2tUbdOpdsDL9I72CQuJgy7eCS9GORlSH0HSr+r+SGW3TyUAMfPd/SHnIW7jnuGd8+
         3fOauaL2RZOtcqLPPOSNR7nh39tV0NoBsMaz3LcqK/eO4wZxHeE9OmED4hvMwqJ8ophi
         Fqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740863; x=1710345663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2Hgk8n9p4LCBmuuj6kS57w+CBqwKZ1lZeYV+GA9Ymk=;
        b=Ek6FT0JExDLWreLIsmm75Knih+8NcjszDUmPxxQ15u2FCIYFoET4cnyDQT58ZzolVN
         4TdJTP/dRIHTB7coDiFP1rlozZ2f/ws9iBXO7hHVkiFJpICLGCRK9uGRuv+KTvBdt9Ml
         Nj12FwtZIMkIl2tpYhLnLQbd0GSWuzX9jPMt3kVsJwxAaa+Ezj5IKjtaKEifSLk3aP2B
         INWywUZRMn6H4UAEa9Fsjp5YF9GlbB8f1x5kCzUu0xEoHvjt/TTl/K55X6AtyvzRTiFj
         FEoD+RudVSy/X/niJvY5MoHIZ08sDKYTJvPgLkVm2h7aLqQqMQcntEYdO4pcgYqlseO+
         lW8g==
X-Forwarded-Encrypted: i=1; AJvYcCXcYy0Vhf3dvjdYTozdp0yx2EpXCeTIzSD0HWvBUfYokIFenBbtpmlUIOo9U/DUPF0SQ8ynDvjHN5A+qgPqQreXw+KnW5yo
X-Gm-Message-State: AOJu0Ywf4zSs2pxTey5HNP9WcdoTFwHa8Tv7RMXo2FCuIwuSepmouwOs
	oP937rkb9kKEDLAeG86IADtSnEKUV4pDBeiB1xXOV/AQSDUbBRbyPE6E/j6rEJ3vdFFols9wAj7
	+bumw0VANyg==
X-Google-Smtp-Source: AGHT+IHJvE9nu91L/pxhHEbqxOImZdVvS7nvzs7hXXkOYhLmeBH5bxxqceQtLH7XvYLPITzotwZXRvq5IwUebQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1148:b0:dc6:b813:5813 with SMTP
 id p8-20020a056902114800b00dc6b8135813mr501260ybu.9.1709740863022; Wed, 06
 Mar 2024 08:01:03 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:26 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/18] inet: move tcp_protocol and udp_protocol to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are read in rx path, move them to net_hotdata
for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h |  2 ++
 net/ipv4/af_inet.c    | 30 +++++++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 03d758d25c02864b00e0a557603b64dc9d749b9c..87215f7ac200f2ba34de9b52841bc0c9e4849857 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -11,7 +11,9 @@ struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
 	struct net_offload	tcpv4_offload;
+	struct net_protocol	tcp_protocol;
 	struct net_offload 	udpv4_offload;
+	struct net_protocol	udp_protocol;
 	struct packet_offload	ipv6_packet_offload;
 	struct net_offload	tcpv6_offload;
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 08dda6955562ea6b89e02b8299b03ab52b342f27..6f1cfd176e7b84f23d8a5e505bf8e13b2b755f06 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1751,19 +1751,6 @@ static const struct net_protocol igmp_protocol = {
 };
 #endif
 
-static const struct net_protocol tcp_protocol = {
-	.handler	=	tcp_v4_rcv,
-	.err_handler	=	tcp_v4_err,
-	.no_policy	=	1,
-	.icmp_strict_tag_validation = 1,
-};
-
-static const struct net_protocol udp_protocol = {
-	.handler =	udp_rcv,
-	.err_handler =	udp_err,
-	.no_policy =	1,
-};
-
 static const struct net_protocol icmp_protocol = {
 	.handler =	icmp_rcv,
 	.err_handler =	icmp_err,
@@ -1992,9 +1979,22 @@ static int __init inet_init(void)
 
 	if (inet_add_protocol(&icmp_protocol, IPPROTO_ICMP) < 0)
 		pr_crit("%s: Cannot add ICMP protocol\n", __func__);
-	if (inet_add_protocol(&udp_protocol, IPPROTO_UDP) < 0)
+
+	net_hotdata.udp_protocol = (struct net_protocol) {
+		.handler =	udp_rcv,
+		.err_handler =	udp_err,
+		.no_policy =	1,
+	};
+	if (inet_add_protocol(&net_hotdata.udp_protocol, IPPROTO_UDP) < 0)
 		pr_crit("%s: Cannot add UDP protocol\n", __func__);
-	if (inet_add_protocol(&tcp_protocol, IPPROTO_TCP) < 0)
+
+	net_hotdata.tcp_protocol = (struct net_protocol) {
+		.handler	=	tcp_v4_rcv,
+		.err_handler	=	tcp_v4_err,
+		.no_policy	=	1,
+		.icmp_strict_tag_validation = 1,
+	};
+	if (inet_add_protocol(&net_hotdata.tcp_protocol, IPPROTO_TCP) < 0)
 		pr_crit("%s: Cannot add TCP protocol\n", __func__);
 #ifdef CONFIG_IP_MULTICAST
 	if (inet_add_protocol(&igmp_protocol, IPPROTO_IGMP) < 0)
-- 
2.44.0.278.ge034bb2e1d-goog


