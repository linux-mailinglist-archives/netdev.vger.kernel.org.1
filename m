Return-Path: <netdev+bounces-204515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FEAAFAF71
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29ECE4A0079
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B62900A8;
	Mon,  7 Jul 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMSU6SML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0E28D8C9
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879799; cv=none; b=IZbyk+Ss3wHLSNfZMipOimcAB65Yroq+BbMCmrhhpNZ92On6yMbWlke0MdKUwEzTBH3WyjLPALL742jZpDXRiuvqbLA3gp2/hT8nu8TeVDNHo7iUolKsPk37IAtIJjnb/nQx/bdnDWyJttGyOFlYwGBuhti1nIdHjvA2lu1572k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879799; c=relaxed/simple;
	bh=YlmNLEqX1lWlnBBlURn4NnXwmZjQoPjZCaPQjOL/ctg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IDVbzUbfi7mgxAyAk34fkLZe6hLVOC1z9xX0OjJQS+zIurNmp+A7l3+g9ctOkoD6B26CW5EHe5So04NEdPBDaJXYX/9pP1j8EpCdEkZZ7eRfXxO8hG4xanMh4IN3oDkGGifn67tXDV7dWIDwCg97vFfpDFifoAZ1ro9JPHuzfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMSU6SML; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6ff81086f57so28731646d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751879796; x=1752484596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+x2D0M7JvWYQsTE3x+pSo4iAW+pNxNO6kBhqYVqFIgA=;
        b=fMSU6SML3EYi7utkigaD8pQgsk9klOSkzsoqsG9qlW8fRvJwBs9xfLYZcaqrVDV1t/
         77Ce4l9l9QUDZyVZh93OAv7in0jwHM5OmVJyPqCNYSDEu9LSYeOKu+ezqwWjhO22G+Rr
         GZhcotcMQBNhLRb59vSIBrHSaqVGs6C0s3J55F5PDdqGD41Vb9lSqAPyCRPid66ZYZz6
         iLXQDd0Ld85cNkZFoUQn4rmcqkoLTxlCEN0Mk19PPUXbLdCjGb3txKw2PTonRHh15rPU
         PY7y+KAIKHEMXMGW6TA8FKJQu4XSnfD3QLK5iy6nLa6/jIDHCQYAnVKgLIql69P0lDXX
         2QMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879796; x=1752484596;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+x2D0M7JvWYQsTE3x+pSo4iAW+pNxNO6kBhqYVqFIgA=;
        b=k1EhVGvO+IfuByB5AQjiOCYmcdxCyuL9VWdajiTtAEXTsm0cqTk3unSRnUauKjF3yZ
         1S/UDwBXUKaIsvX4tJw8pWLBW0BC68odQeJ+IPaUu+g/a8QZ07lvRzy4I9vdwqeAXnzw
         ypmLP05eQjlhB5SITtF4GM8ybE6Yphdnm9hbKWpUJZt/fmfg+oIkCs1wa98bg9JkWQJS
         BIelwJaEwtcFb8zH1lnQgplZrtB6Ha94drxj/OHOUtPsktMal8Ayi5oxmgjw3/DXGwEE
         Ove3IiQr+oOCT7wNhGqU2BSxvS/BdOdHpQVKSgNbDauVniOQMGkA+fys24eVCMAEajvn
         b7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUx1B9F/SBQ/QVaydp79RdRWPvXpuGgFdLqteX9OZ0SFJ1Y5SGCFB77Rf5PJ38NuD88bpR9aUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydv4JGRsV4I3ZLAMfwVRnZ2BRBu9fbxvr5wJUDDf5f9ob1Ibk3
	EIzjhdUqU3Zcdl2pEQj2pZSCYerhImlUBZzsrVy6ZAN3ULUteRUWZ3kSQ5e2ZHIbgCTu+/NIZ5s
	1y6FBYOXTR+64aw==
X-Google-Smtp-Source: AGHT+IGE/9wKrc73WpHMyHdgxSxeM/5oM1BrAuhjDqq3erwhYT3glzcDdFf5f4KSH+zxrRPZzCeuI4JxxKujnA==
X-Received: from qvbrb24.prod.google.com ([2002:a05:6214:4e18:b0:702:da74:3342])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5c42:b0:700:c179:f57c with SMTP id 6a1803df08f44-702c8ce64camr198461256d6.38.1751879796519;
 Mon, 07 Jul 2025 02:16:36 -0700 (PDT)
Date: Mon,  7 Jul 2025 09:16:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707091634.311974-1-edumazet@google.com>
Subject: [PATCH net-next] udp: remove udp_tunnel_gro_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use DEFINE_MUTEX() to initialize udp_tunnel_gro_type_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_offload.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 85b5aa82d7d74a945d9139f7f94042d2c0f937bc..75c489edc4388176a798bfdf0c3cc4160e34052d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -44,7 +44,7 @@ struct udp_tunnel_type_entry {
 
 DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
 static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
-static struct mutex udp_tunnel_gro_type_lock;
+static DEFINE_MUTEX(udp_tunnel_gro_type_lock);
 static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
 static unsigned int udp_tunnel_gro_type_nr;
 static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
@@ -144,11 +144,6 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_update_gro_rcv);
 
-static void udp_tunnel_gro_init(void)
-{
-	mutex_init(&udp_tunnel_gro_type_lock);
-}
-
 static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
@@ -165,8 +160,6 @@ static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
 
 #else
 
-static void udp_tunnel_gro_init(void) {}
-
 static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
@@ -1000,6 +993,5 @@ int __init udpv4_offload_init(void)
 		},
 	};
 
-	udp_tunnel_gro_init();
 	return inet_add_offload(&net_hotdata.udpv4_offload, IPPROTO_UDP);
 }
-- 
2.50.0.727.gbf7dc18ff4-goog


