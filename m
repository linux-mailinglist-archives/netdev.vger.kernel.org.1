Return-Path: <netdev+bounces-78002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58B873B7C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F71F26A30
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8DB13BAFB;
	Wed,  6 Mar 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7SLnKSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753813BAF1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740861; cv=none; b=mC45e+pJrc3ejwx4IY6aMrLzhJiIfr5pb+Ro6jwpMB+xBtDNoqMFNd0oAQoNUtpemBbwemh7hRWXPGCQRRDg7TxO/oiwxspQ/oiZXZgiZ8yxKgBitqtWypO45F6LoWM7Y/JVCLvY1K2Sj9yhY+F6Q7DS2Sd3zjcYT3XdA9U/9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740861; c=relaxed/simple;
	bh=7Zc5yfv2/wmmgPY9sB4q+JazwB9o4N2yz/Dr0gPHVv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPYujCUQletmKaDVLzYNkbjcBF60CUvOz7q/d3vm3e/9NjSSV7Qx/xN8jk1MVPIZLGp39Xu/JXzNU5a45Hqhq8nOf3EqgMD0RncuZ4QVskxMYsK8Mb7bGkhGornq+P+DpyCFdGbSGxNjfJlOrXdwLrTpNMHTMp/7nEiruGQ3nCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7SLnKSb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so105807267b3.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740859; x=1710345659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kNlWSDSik5lU/4gINrhMuZfSkjaQaOOEbDG3yphfEDE=;
        b=Q7SLnKSbndOnwnuaDK2IHaQa7cXxXCQKyth0Lydhz85TyHGK3pbnV518j/OdHMBUIq
         YMxzx0q5B6tYz94VEKMDAVzAhScmi5mZrb6YcKEn4n53U1YbZvipUCCt1EfQpQPEmCCK
         SHNK8SgiPGtKGB2CN/G6U3hmbcftr6aBg5aGTAwn0FiIv8IQv4YzPssD79VSD4NAsX2/
         oAY7qigj38CbkilD0eXZkkbi2ryIyrwjV+6xM9Pk+k+8SwuarJTN5JXvMMihMY60XxG1
         hdJT4R4PRSzBzYEwWtYsgBd1ZSeJWYHZIFUFQ1ekH3gQXAFWjmmzqkRoxpjjXBSKisVJ
         LH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740859; x=1710345659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNlWSDSik5lU/4gINrhMuZfSkjaQaOOEbDG3yphfEDE=;
        b=qrH0dUu/l+7lOi7Ba/hUA2IG9qCWNKl2MXAMByyQ/WEDFPB3Gs5TtZLI76AdNH9i9W
         jtV7tSgRLh1ZgXYPft9NNAQ8/g3sxnSnlq8hdYG1DBO8VgdXl7fKIUgtLjQUoSU/+WPI
         kZQINHpHxA7yX+5C1lwKh59xdDC79ZkKZs/J1t8rV1zKhvVoJUrTH7vpuB/UoaGzd0oU
         eIYeOgjSggqPHmx22dJfXY1+oHfQwYafkQGK6le58gH9uuQR4nnx1qO1Z+MkgFWaSCwB
         d8PDnBVpskrwX8adv7L46NlZvr3ZCZU2igXLIxMOGDfgYv3YrU2d7qQQsFG0+ysiZ8KF
         eEgg==
X-Forwarded-Encrypted: i=1; AJvYcCXKnWEHmrCiVi2v9MkW4Z8Xf014i86TpcOPpwgMO6x/B1DHTaD+MBKVLERFomviyHddqAk5IYNonmhfRyeCMW0fqxdifpys
X-Gm-Message-State: AOJu0YxRK4gLUnPUNGa31+B0OHU+QCqVocABKbFc7ctzbFdR8xV/hiUF
	84ypoU0kI0mQojK9QdpBw1kHFrPdQG9e7ig/b8RrrShIJlqOKveqsarT+8iPrVmw8wRv/q/w5lx
	5eN7Mt8Xk3Q==
X-Google-Smtp-Source: AGHT+IF6TIS0obR2vkHg66SBGzY49ZzRQAfo5G73OZDyg7+ddJZ028clMiosmkgBSnzarFfrIp35ANFzUCp13A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c794:0:b0:dcb:c2c0:b319 with SMTP id
 w142-20020a25c794000000b00dcbc2c0b319mr645844ybe.9.1709740859013; Wed, 06 Mar
 2024 08:00:59 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:24 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-12-edumazet@google.com>
Subject: [PATCH v2 net-next 11/18] udp: move udpv4_offload and udpv6_offload
 to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are used in GRO and GSO paths.
Move them to net_hodata for better cache locality.

v2: udpv6_offload definition depends on CONFIG_INET=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h  |  2 ++
 net/ipv4/udp_offload.c | 17 ++++++++---------
 net/ipv6/udp_offload.c | 21 ++++++++++-----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index a8f7e5e826fb749965573a5bcf13825a973c16ae..daeee8ce8084e885984716113779750ca7b72147 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -11,8 +11,10 @@ struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
 	struct packet_offload	ip_packet_offload;
 	struct net_offload	tcpv4_offload;
+	struct net_offload 	udpv4_offload;
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


