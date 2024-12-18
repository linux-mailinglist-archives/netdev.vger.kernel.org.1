Return-Path: <netdev+bounces-152748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275519F5BA3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622A91624E2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4935966;
	Wed, 18 Dec 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="V6ybPA68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD36233998
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482163; cv=none; b=h/acGhXwPqwrm42zC9YR1DVexZxfbLE2RFiib2MLakNfQTBEDMv2qHQKHmuU0bTLs5aImZPREtrSCl61ATKM3SgDHrUKTnAIT8aeS1146tIuWROnDqpWi6pmK2s5zD5Ufb045SnMOG35hQlYCEbVTxxVf+3rskRd6Xm6SEBdk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482163; c=relaxed/simple;
	bh=kokGPXOtKmJ8NMnDjbo7lcERhIq+pUTFKWNlFSMMVJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbKdhCJRMKRsfh0kaD1NNAD9l4ztt1hXgqXeeL3S3B9gW/TaiILpYpiExmtXYgoF0Abz7WgkufKjv+CTbZ4wEGz8XjuixkYDbXAZmfYu1DqTxDsHl0q/J6+k99B1Ca6Q4HwQ6LGswea752wlwesBrSJ+GLl8UeTFvnXdj5Y850U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=V6ybPA68; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725ecc42d43so5025268b3a.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482161; x=1735086961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysSCaIB4GXTEiUBi/fqYnu5BV5g5/6ElTQwwBF3xc+Y=;
        b=V6ybPA68ijZ1VQDl8IpmS1yl4jKYPZL3XuBgLPVZ6nRDG0uaT3cjQLPRz2UDnbOsFf
         5KQJxypQnu9kGtkPt52xNld/J9v9ANskQ5cJVfD7sDKOlMg1hxZP+RbNNnFZCMQGZZog
         TW1LX5h7GRYbb0xo/0BCU5y8Q6zaaCZ2j/Rd0W43C6Vj/NvVWCAACHbX+EcwtmcLQOQF
         LZWKZAcSHxIesrkR6irOszsudw2bDh6ic9WlrB0jKox7A2+/ylkYgvU+IOu7IVGMgjCa
         w40pUl4NShpKWS5M8zP3pN8xNDVNN2gPBRdMbdmWNbRrqys5589GVnPPaC/AU4YrHRr6
         88Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482161; x=1735086961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysSCaIB4GXTEiUBi/fqYnu5BV5g5/6ElTQwwBF3xc+Y=;
        b=Xs0o2myv+Use4nV3p5vfu0dCT59+HGOCcYT+j0r/uyiXup0jpspTXgJ8ixLVW/ZseW
         6lClK5cdXHFdzKa/BaoS+XamxS49w7lv8bWD+MQedJvdaBzW1LZzynCTWbkf2K4eWWwY
         5YnBU+OExGRPd0e6B6shsDsil+fAX1kXJPJqYpWsoW1fsPrpo85EVvQ6iH286ZcQD10q
         qLA+O7VK8rLDxuUoJxReTqoqQfgb9Ea57ZQSKdvTYf99HMhyLnkv8nBw5gpjfuFyp6Az
         aAo1Zmp+FLivUSfwTobZnQiRbn6xE1rHTovz5vjavBxD+S9QYACi5sGQirnZhQiz4ErO
         ZvKw==
X-Forwarded-Encrypted: i=1; AJvYcCXsTmzP4Q4b/gJFIcjVn48vuHLiS6QzII8hh+QPitCadnXbfIEas7oRH9adApMYRUnJ3frUxgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfP2KXyDJq+bgZDFPor5yentcz3EtriYRb9RwkLKr9aH3TWJ1Q
	RU5TnppSfXQeXh9jmerMX7zxZGQpt81xP+KGwcbdORy7Zlvl8+9Q3SmhT51F+4A=
X-Gm-Gg: ASbGncsaYp/NHHe+k5TzHPfhz4gRYeoTXGqNqynHnNIVNTKKlfIXCjD1vYcKWVzeQo3
	ZoN38iErlq43Yt74wcv1HGlbCokJvWIaZ5Em6haYr0ImkktX7hK48pPklILvmB3KWFZivzDGnIq
	4HiE2dTtayvoO8US0Xf/lGk4YQKWcGGqxD2PMZIecgNuiISWVtrXew5loPoDFPcvo2uMWBacbjI
	nF688ru+wbpK4hsz7+Jve8KV6N53Hw+G3x93/om
X-Google-Smtp-Source: AGHT+IHK6RI0g4RndMxzssu5s+vJ3eAoHV4b2tI6m6aTkW2JbWD2HemNCOpu054vZvqLojVx6HHW/Q==
X-Received: by 2002:a05:6a00:1807:b0:725:4615:a778 with SMTP id d2e1a72fcca58-72a8d225a2bmr1336107b3a.7.1734482161021;
        Tue, 17 Dec 2024 16:36:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad658esm7268702b3a.50.2024.12.17.16.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:36:00 -0800 (PST)
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
Subject: [--bla-- 02/20] net: prefix devmem specific helpers
Date: Tue, 17 Dec 2024 16:35:30 -0800
Message-ID: <20241218003549.786301-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003549.786301-1-dw@davidwei.uk>
References: <20241218003549.786301-1-dw@davidwei.uk>
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

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c |  2 +-
 net/core/devmem.h | 14 +++++++-------
 net/ipv4/tcp.c    |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 0b6ed7525b22..5e1a05082ab8 100644
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


