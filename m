Return-Path: <netdev+bounces-77998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BDD873B77
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D15E2888CD
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85113B2BC;
	Wed,  6 Mar 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mM70KzMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3213958B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740854; cv=none; b=cew00Rec6KFlSpnT7mLLzJ32B5/ka7FEOLGkO3fPcodvvvJPkIopl8+CtGxCEHQpdsyljiQ5oBwZ+mgvIXW6B4exFOIxDBM9nTKeD/507oKQNvZpFDs/1Qn9LecGdobPNQoCUeZWiyYJ+ACzR6ioeCUO/ej8hnuMBhZmvYzexcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740854; c=relaxed/simple;
	bh=w/U3P7HNxanK+riwfp1V2MV0wWbB1aJEPUSWyHW4dcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jFvWKpiZd4XJl47Lau3xO5a13HPsiDM+ywTnd9AkGAtJ4HMvh2zsH6+4rZ1ErQocCSNJ+BF9kAVEsDTaTlK37t60qajWv++dvvzK/Z5tVFcAkJNpsJ4RQ5H4E4ph7nFcDrr5x6Eb5octOw8rqSuQa73gKZCt/5oU5hU24TJHjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mM70KzMw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so8533966276.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740852; x=1710345652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTG84diJudvJTDGXkuZrR7YIFKVcaeJvr+RXcEnoJTM=;
        b=mM70KzMwMCc0C/+fK9Rxd4S2i0wjfUdMkmUT7gPKXq0v5COLZtGVcG9PVLFoY+ayXb
         MHacAaGj0PbeeFoFT9UEr8kB8f9Vd+s54cd8B8F2tKt42/5aYzfx1jDK6RhTe3I12/z4
         2El+uvyDotS85BsR3O99oRV1OhN4aQRMyjDTp5hhK4iwgvUr5GNFdFdijHtx0qfRBAa7
         SoNmIo32HLxU2jX7V3ZCXptFXT28Cpo2Bfb9PCm+cfJsDz9TC7tBGvGGDSBvXWOy/28V
         uj0BFwrexW0EqlfazyE/ZZTGI0hQSlMCul9tzuMcpfqcC8q+i2wKeRs5JNwd0zaFSr/Q
         01YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740852; x=1710345652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTG84diJudvJTDGXkuZrR7YIFKVcaeJvr+RXcEnoJTM=;
        b=bPvK+09oJal4dhFS6IG6N9K4FumODQPBz24ScEbB4B7eFlPWU+X1XLme5lklkmW0JS
         y2bu5j+QKNTjfVrWtvuFjy2uMxqo23nZMuGjmqxlmOWuWY4Fo+laMVONUmvTU6THZccp
         lPXRk7mf5B2n0QXogyxqsvTZyyo352LaySkOunRs59NFDCPp6uQO60c9kcj5nGPFIpjm
         32jGQJ5tim6mX3HTbU3gUIyqEr63+H+LQJ+XkGbHSmyVNj0nk7cAylEMwi8QMyrq1KHY
         gNifGFh1R9bD8iuCFRQWJ6IhEsMarOSJBnzxkEQ1fAflPkMe0DGfyi6+Wx9U7R+beAJl
         oZ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWlegv/jHicCx5ZHWCnK5EsfmBVAenUoQbVysTW1dITdJw36Raicosia2yge9Kc6HzzHjNCNX0BbABmkxKb6+O35ku91cO9
X-Gm-Message-State: AOJu0YxuSOcVG00vX7JWCr5ZBKdTvDEu+Frh+Pl0jLmGZts0zM/lb02G
	lnqQuwgRyOnPjZeX/4KBnxpBa3Zdcpdb/7QeNVDFuGWGfQc0R+Dvo3qS94iY1VCZ0mbND/ZQRDX
	WpjiqgPZdLw==
X-Google-Smtp-Source: AGHT+IH8mEjNOcCjJDuOYlyzram7GEY3P9EBfZSanCbuiID+kKXNkvDoSlkfI5DtFcp0Fuj3TpLApVjg6lnySw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1549:b0:dc6:e647:3fae with SMTP
 id r9-20020a056902154900b00dc6e6473faemr653390ybu.2.1709740852064; Wed, 06
 Mar 2024 08:00:52 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:20 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/18] net: move tcpv4_offload and tcpv6_offload
 to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These are used in TCP fast paths.

Move them into net_hotdata for better cache locality.

v2: tcpv6_offload definition depends on CONFIG_INET

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h    |  3 +++
 net/ipv4/tcp_offload.c   | 17 ++++++++---------
 net/ipv6/tcpv6_offload.c | 16 ++++++++--------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index d8ce20d3215d3cf13a23fa81619a1c52627f2913..d86d02f156fc350d508531d23b4fe06b2a27aca2 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -4,12 +4,15 @@
 
 #include <linux/types.h>
 #include <linux/netdevice.h>
+#include <net/protocol.h>
 
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
+	struct net_offload	tcpv4_offload;
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


