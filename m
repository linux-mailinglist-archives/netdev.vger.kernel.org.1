Return-Path: <netdev+bounces-77588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC0487239E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715D9287E59
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFD12A173;
	Tue,  5 Mar 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfWNw97Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A512A16B
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654686; cv=none; b=JAsdZY26qsrfRgPIkhTHUC5wREidGzRXoHbauctbJcqSXUiimQZpBXG5VIeaJ0RBcTG8fls9ZNDC7j6ZMgYoGKTauiGMVzGKXzuvTWCe/Lpp7x2RtgA7j8tT0b6VwMslsoWHITDdIR7Q0rKsg2wATI6kIjHQZkx3/tYaXB7HbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654686; c=relaxed/simple;
	bh=DYBb33Z/UVRcDZcDfSjIuQmUv3x7A0LmtslLfcKZ4z8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XTybyGk6N5B3UNF866200lyw8cySoEZHDPlB2ncGWn2BPN0uETadnguovrdjFq7bt6vk+leJVZCHopWjtbmBF0n3uUylowMbfPvTVUj69Fj5840XY7Ytvub/x0rtTqtqzaZ00sqrL3V//tvVTp3yL8T0trUBlxFWyxR2n0kmO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfWNw97Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso10674395276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654672; x=1710259472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml+T6Ku/RpBJ6TPqtwbz51dgmo/A7GQ9j0i5zvMTCTc=;
        b=EfWNw97Y8GzqyiKaEvHN2Bz4IdIqqJdw9/hsS1PV2iyhlp5fGu8W+ZCzm78cCTHN5r
         hj9QgmqtAUq7eObH+lKduEjTtO0bX23ubK7zjNhOvusR9VM1VNBc4z7zFLROSPkzSH5i
         n1dRJpJkIwu77OwOroU38ZgEzpeXzU0zTpbRd4kk7B3pUC4Hu4LFO2VYM0oQKOEttydD
         PtHQallGPoLQoUL1Hg/7eUC6MHsT+AG+YmK6LRQqWDCqW/QS3DCUzVlmWo7gy4+a4+2i
         LSi/d/VT/y48i9r3gK617WfpPkS7b2j3vPSyxuv0uUGJN4G6284Op73QI9gt2E6lu17F
         Bmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654672; x=1710259472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml+T6Ku/RpBJ6TPqtwbz51dgmo/A7GQ9j0i5zvMTCTc=;
        b=Yjnoxt98Oa0x/IWWk2+G4XWd85Kkrk63esu7akemnagktWxMdIN0qWkTFf3SgumlE7
         L480FcMPBqJAUFkhrtbJ3L9j+NrDMj10YTtgzePwgd6zNzMXSMr5kI0TbuyafGOWi5n8
         B+yCtJJFhSSyPFB42lwvI8HUm8MjTxn6W/A4Xq7be2SYpAhSX1zPwYTImS/7a/sdOm4B
         8njdGPjReP7zXElrARRgKQTQjWdhwfwAYoMigQxMd2lnaN8wO7KgQM/yMgYN86uAMkFW
         +j9qqvF2iS5r3sXLJnXxLzDMjVaojaZWHXZEs+MkAsjzWb3dvSgj8x4tRdEl8/KiyZqZ
         FI+w==
X-Gm-Message-State: AOJu0Yy0GNFwdKLYz3XQqZyClPW2clQ0OoWzyFY3mmcHTXVULlqnv2eE
	aSiATQqxVkUxxDvAa3JbSb/EXkgp06RLzIOoEuVzkocMgRnb3yf3vxObEaNA64NED3EmDp1QqaC
	CnMcGtP/VKA==
X-Google-Smtp-Source: AGHT+IEhDi5G8bUSHeErNh+sj84jAoNG7jvaaXga2zkZ02i8ofaTj+I/DZTU5ouyWHqdRNjLNXhbvF0eRqc88A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1004:b0:dc7:42:ecd with SMTP id
 w4-20020a056902100400b00dc700420ecdmr3125522ybt.6.1709654672270; Tue, 05 Mar
 2024 08:04:32 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:06 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-12-edumazet@google.com>
Subject: [PATCH net-next 11/18] udp: move udpv4_offload and udpv6_offload to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are used in GRO and GSO paths.
Move them to net_hodata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h  |  2 ++
 net/ipv4/udp_offload.c | 17 ++++++++---------
 net/ipv6/udp_offload.c | 21 ++++++++++-----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 728aee1cf07c8f0d85873d912248a99e148f84b1..086114e4d3bcc9184304b024ed93c9024888fcf1 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -11,10 +11,12 @@ struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
 	struct net_offload	tcpv4_offload;
+	struct net_offload 	udpv4_offload;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	struct packet_offload	ipv6_packet_offload;
 	struct net_offload	tcpv6_offload;
+	struct net_offload	udpv6_offload;
 #endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6c95d28d0c4a7e56d587a986113b3711f8de964c..b9880743765c6c24c28bea095f16f0cf091664ce 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -737,15 +737,14 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 	return udp_gro_complete(skb, nhoff, udp4_lib_lookup_skb);
 }
 
-static const struct net_offload udpv4_offload = {
-	.callbacks = {
-		.gso_segment = udp4_ufo_fragment,
-		.gro_receive  =	udp4_gro_receive,
-		.gro_complete =	udp4_gro_complete,
-	},
-};
-
 int __init udpv4_offload_init(void)
 {
-	return inet_add_offload(&udpv4_offload, IPPROTO_UDP);
+	net_hotdata.udpv4_offload = (struct net_offload) {
+		.callbacks = {
+			.gso_segment = udp4_ufo_fragment,
+			.gro_receive  =	udp4_gro_receive,
+			.gro_complete =	udp4_gro_complete,
+		},
+	};
+	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
 }
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 6b95ba241ebe2af7e5f2760d8a9c1d78f08579c5..312bcaeea96fb78ac488124cf7795aa834392c64 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -192,20 +192,19 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 	return udp_gro_complete(skb, nhoff, udp6_lib_lookup_skb);
 }
 
-static const struct net_offload udpv6_offload = {
-	.callbacks = {
-		.gso_segment	=	udp6_ufo_fragment,
-		.gro_receive	=	udp6_gro_receive,
-		.gro_complete	=	udp6_gro_complete,
-	},
-};
-
-int udpv6_offload_init(void)
+int __init udpv6_offload_init(void)
 {
-	return inet6_add_offload(&udpv6_offload, IPPROTO_UDP);
+	net_hotdata.udpv6_offload = (struct net_offload) {
+		.callbacks = {
+			.gso_segment	=	udp6_ufo_fragment,
+			.gro_receive	=	udp6_gro_receive,
+			.gro_complete	=	udp6_gro_complete,
+		},
+	};
+	return inet6_add_offload(&net_hotdata.udpv6_offload, IPPROTO_UDP);
 }
 
 int udpv6_offload_exit(void)
 {
-	return inet6_del_offload(&udpv6_offload, IPPROTO_UDP);
+	return inet6_del_offload(&net_hotdata.udpv6_offload, IPPROTO_UDP);
 }
-- 
2.44.0.278.ge034bb2e1d-goog


