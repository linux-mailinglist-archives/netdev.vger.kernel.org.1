Return-Path: <netdev+bounces-156457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988BA067D0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0445167A88
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA8204C09;
	Wed,  8 Jan 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="ORlG1huc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482222046B0
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374028; cv=none; b=tyuofoc3hFrYlN/1YgWGEhZFLV3F5CEI1A9KAAm7gV+z3acXVebACH09fJWI07g9pfeDbVeo6xbjAV6HwJgrc8CPKBAcN9LWkz337tcb7mWFKITgpBCKKJ77OksP1W2P2k+ZnUGmkjlMZ/qs/TOyXorxk2xZf+esjsXbcDCQ6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374028; c=relaxed/simple;
	bh=1iGhFb5yYmlt+N/E7uhnersaFVha+jc84E0nut9lM44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnr99XRsnPYGpKbQ1pzgv4BD83C7a+kFuwZjKZON5+SruW14G03rWZEVISxxYx+/ibCBcAbW8IPFXeNkEbL0/0pPQHOnS8zdAtdtJ6zZrZ5BQ/Xn6Bx0cJp4uRW9rgqHV4MqKtnTU3gclWUuQ9TnPTE4eo1gaafwdS3v7s/LzgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=ORlG1huc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso394936a91.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374026; x=1736978826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls7TIJmWbtjH6cQ+zvuFtI+oK15m0KZtEVTJMdgXvRQ=;
        b=ORlG1huc0fXUqqZCeOknixAKVInrzH5ZhZc6jr2haLHq9YjRbrlCRbgijmh4ghw6Ut
         81DwukMX5J1ABeUmZumEOIv1G7C5OOBze6HZmtZwtGXSUn3r7vjoRN936FVAi6BhoCkW
         e/zm2JSEbmxiCw3FHhcs7VLOfu4fFcD1CMDMPrTdy6jwuMet4oY6J+HsHijnHWv7v+SX
         Ca50Ujp7yKkl9qZc1zUQytosycfIPF03HlhOSaqTLjQokLntEAGN+tO8tKlFGrwZBZew
         1LiEqsPnWH+VCxGV0mpWIFtyTzAd2SpWWHhMMTsebxCx7/bf/Zv20c0MiWXJnxcpHUuP
         PCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374026; x=1736978826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls7TIJmWbtjH6cQ+zvuFtI+oK15m0KZtEVTJMdgXvRQ=;
        b=WUOOZptJSB+oQG5d0dNxJcZPkfA0CH6QWjCtQiDdd3remTQO5qMmgWh+vHZ82EdzIN
         5oO6TWerSqjN06aQkFNoWd0SfUlmNI9H6HWs1CnGFqHMKtnbSY89fSpqrpAs6NUuuQQR
         gKPRGZu3dfxzyJqhs3tzN/+4OLL/TCZZfTXt5iWMZ1iRHqtY9BJUBjr0mt1fE6JblW/U
         AfhNF2HIZXLjuT1Hdc1j+pmmj57yBA6mIMgoUSUy9ZXLyYT/eFjuBr3krbtGMt8lm3EV
         dzTrqHrsQIEPO3qevzjfoP9R9lFOG5BVTwyluoM5bzVB7NpToFzjW37UDpUHwG02/VHy
         HPtA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgJX8WS6PSuzEsczUZKwRiXCwpeIkBfCTi0CJJ3rSHbD9mrEKfk7GUMQWyGqtqB98U217eV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/4hQ9iJ2C6y8LM8PWfgZ1YLu5kIMrcwm2omIXknSikmfG23R
	gK3xtLC7dxrgProkm8eASqiveaSz/62hGThebpWDiFLDhaSsr1oCL3sWsysAgEk=
X-Gm-Gg: ASbGncuNMoDCnqNbBVbIJz0FNhp6824UtORWlG/BZ3XRwp/FB9EwbVWlUieelb9A8g4
	3xyoJKdyOfjjezxkzDddeo6Eqme0MVDHR2n9DUFBPFITnV8afupE8m84DmAoh6PFXUoT7gGuS2j
	v8qNc/ouQbSvmKaMTgnt63gogtD+8MJeRacSe1ksuvP4HyN/GB2vgU87KmuyCYh+P4sa9orJe9m
	iWBMVFE2JS1XXURtKuwl7hUUtxXJ4toNVlKQ0AKCg==
X-Google-Smtp-Source: AGHT+IH9IqSP8v5T7l2QXuQWImU55frwdai+9V8O6x8Vau+rR90vz8gGxOPpZEwrAVkkqcQS0BinDw==
X-Received: by 2002:a17:90b:1a8a:b0:2ef:ad27:7c1a with SMTP id 98e67ed59e1d1-2f5543d2d98mr1325814a91.2.1736374026649;
        Wed, 08 Jan 2025 14:07:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:12::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2d9168sm2118353a91.39.2025.01.08.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:06 -0800 (PST)
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
Subject: [PATCH net-next v10 03/22] net: prefix devmem specific helpers
Date: Wed,  8 Jan 2025 14:06:24 -0800
Message-ID: <20250108220644.3528845-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108220644.3528845-1-dw@davidwei.uk>
References: <20250108220644.3528845-1-dw@davidwei.uk>
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


