Return-Path: <netdev+bounces-149090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E719E428B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C3E281C3E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D652139BF;
	Wed,  4 Dec 2024 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="dsxAUX8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA120DD71
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332965; cv=none; b=stCXzMsyUhBk+k7UaImHb/aGkxj+Ouu4qnWUklc+U4fXqzNR4YxHWzJjavIBF5ygJJxLMGYtGQpgJybP71ZYo9Rww6b3sf0KLzODY8D4RsGBKaz4Th/uZDl6WdNF0U9UhLRb0ql5cdnSuax6C5ZFzk2QyIy+ZmEFqewRHIOF3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332965; c=relaxed/simple;
	bh=XvRdkvazrDmZ1Kd7Oyb1j/+3ssBezOG7u0Y2B0T4Z0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csdaEUAqbak6yjORG6Zaj7cmqNMPdO6pcEGJXkKDZfox3mAj9HeId3YE/N72YGbYpI00cQ4aY7l/2N7f1oWAxBJRycF0P4k+AsPkBQf2C8Kmo1IfxkOxnUBcKdRK/ZeRfqnBBttLenzY7PQHb2T6xwXiVeHX1B/aqRvhbhE3Kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=dsxAUX8d; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7258ed68cedso57354b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733332963; x=1733937763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED4HczsmESLV9aByZwZf3sriAwBjJXMtxojVRAGQXDk=;
        b=dsxAUX8djduAXYOfg4kS1D9X94hWuXRFNGGxdVuHI5cuSNfQkHllV/7Fq3qRWd6vpt
         0wFVQxe5njrA5RBGB4Lbli8katkygN1NloUZTSmGiu5ZId6BpntkckGdXDZPLmEtANfw
         KsArPglTwMRD6vSrGJeB5Ath0tjSQzMelMSbsRNqu5XHaOtyfLFFyvgYMqz1U5ZL29v/
         YQj+ESnwwH74n/I4nn9H/MswZvFdyIbIhjYL8AYMxubJuT3aaFfWu5BgqelvgGgQOuHe
         7ZooZ9vEPJ2YJx639dziHyLBG2K4WNfyx53ajfcTZrbvwurmDvG1CRfVW2JCgRzFuKPQ
         KwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332963; x=1733937763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED4HczsmESLV9aByZwZf3sriAwBjJXMtxojVRAGQXDk=;
        b=f718co7hBuFeFZtfBCVddNGZmeeio9yP8Kgfy4M2GtDuBqFXA5Jwt00fH+/GQR4Lcn
         nRTbpLbRUe3sm0VuwzItH4u2sNeMq10kyDl0UXj5jzqXdu/VS5dAZnRUESJjmpImceI7
         LXnuW2/G7b9baHDgAZn1U0pPV0ADcghAaG1C5Iv2HwVIkOl2rkZUXIIQL1LqDWrbKsG6
         yEx03PcEX49ZDwP9XLz6o8wqvqvgOpENBq0JpiBc3eduE0qYA5+aOnALzPKgbPNQPr2l
         fqfRCBf6DbfGShonPwOk64iXkz+Uiv2qC46VXjHi9ylN4/UjV8B9LzMtSinBVOagb0nH
         KPqA==
X-Forwarded-Encrypted: i=1; AJvYcCVvzJOYCNXakUbteGIErpPPlBC+loTgzZkwjqmOBwNLdYyzpqn8Ld6F/rJ3Sz82BmgyZHRpy+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0fgAV8juv9jme9u0Efi0UxUwChctZ+dF7JJGqLro7YK4vae7
	eJ9jEI5fOGv+vfKykvAAhQXHvVzv/pjo64alxt4p+kgoZMmtmalWrxmeRpeOdgM=
X-Gm-Gg: ASbGncs2RJFE1DVsb3dTtqoeVAXzTFqXt0rSmzY9DKbmCvrVhWksE7Vdp/IprPWvQ6O
	U8VvXYwBpm2qJAGKird6p/TYGE9qP/Aw3OiTbPcbfsNqV/LuNECEtRvzxY/3/cPenitegiw1sh7
	tloxI9StLYA4ZPOQf1JQJrZvSVlSvy2t5RtGQOfwvvzWDm/wsS8/gHMlB5eeSwBpzD5kmmy49px
	GHD6Oq0VSg6m6ZGHd5l3sOGB54fbd6AUg==
X-Google-Smtp-Source: AGHT+IGVbPmbB7ozafq1v0+R5E2YCOhtJ/A0zSt3AergeaNjiTx9OBuin0TzWvA0ObY/YTRvSiBMqg==
X-Received: by 2002:a17:902:d504:b0:215:620f:8de4 with SMTP id d9443c01a7336-215bd1b4700mr96159175ad.2.1733332962844;
        Wed, 04 Dec 2024 09:22:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2158b08969bsm59633955ad.265.2024.12.04.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:22:42 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v8 01/17] net: prefix devmem specific helpers
Date: Wed,  4 Dec 2024 09:21:40 -0800
Message-ID: <20241204172204.4180482-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204172204.4180482-1-dw@davidwei.uk>
References: <20241204172204.4180482-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

Add prefixes to all helpers that are specific to devmem TCP, i.e.
net_iov_binding[_id].

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c |  2 +-
 net/core/devmem.h | 14 +++++++-------
 net/ipv4/tcp.c    |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..858982858f81 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -93,7 +93,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 void net_devmem_free_dmabuf(struct net_iov *niov)
 {
-	struct net_devmem_dmabuf_binding *binding = net_iov_binding(niov);
+	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
 
 	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 76099ef9c482..99782ddeca40 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -86,11 +86,16 @@ static inline unsigned int net_iov_idx(const struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_iov_binding(const struct net_iov *niov)
+net_devmem_iov_binding(const struct net_iov *niov)
 {
 	return net_iov_owner(niov)->binding;
 }
 
+static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
+{
+	return net_devmem_iov_binding(niov)->id;
+}
+
 static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 {
 	struct dmabuf_genpool_chunk_owner *owner = net_iov_owner(niov);
@@ -99,11 +104,6 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
 }
 
-static inline u32 net_iov_binding_id(const struct net_iov *niov)
-{
-	return net_iov_owner(niov)->binding->id;
-}
-
 static inline void
 net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
 {
@@ -171,7 +171,7 @@ static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 	return 0;
 }
 
-static inline u32 net_iov_binding_id(const struct net_iov *niov)
+static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..b872de9a8271 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2494,7 +2494,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 
 				/* Will perform the exchange later */
 				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
-				dmabuf_cmsg.dmabuf_id = net_iov_binding_id(niov);
+				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
 				remaining_len -= copy;
-- 
2.43.5


