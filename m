Return-Path: <netdev+bounces-162759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F10A27DE2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29E73A39C4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633921B199;
	Tue,  4 Feb 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Yl6wdaHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26521A45D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706188; cv=none; b=un2RLRaBZEnP2J4HWN0YQCNBsgrAHL954axGHK6+IZ+l6A//nhzZSpRVhPdD4lSOqxlbjpEY74IUIBfGoR4Kmm86CBAtup+PBb/QN9iGXJDPi04uHdadb3K4DWZ/VWCyU55/lvwyRFlgCfRcghlHdyqMKo/cw9XOpVZxdJRnt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706188; c=relaxed/simple;
	bh=mSP3ZSk0F+wwuNsw721XLyIhCV2GBg4EmkZNpJfy49U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB/jklL7XInsDwcTmjRvBmm371bPWREqycI0sbWqkGpzrmzqY+oYeh/wimT1qP7KtCsztVt7mFHZtqgxQMWnzHOrkcV/5N4mD79BjR1v3HWnvCfRAhWPfYVA78HMcR4MUgJfC2m7OqmzYFc6iN0Q2gov+lNV0iIN6CpgQPER8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Yl6wdaHz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso113905275ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706187; x=1739310987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjzFvEiohlFPJGTO3QTgBTUqYxbIV4/U/lISI94SKuM=;
        b=Yl6wdaHz3TjY9x2lUM5/1/sOqYgceB0fanQu5R9U8Fa7jgrMTehdcv4euRAgSXrn7f
         fK5J9I9WdGVa2vIOQl2WwBhNs60H66H0DRe5z+HH+jrCGfOInLZ+Qr+E/WQs68HQqUMl
         sc9xPJ7eNiSrogk90StVz287gdwvz+xCm28Q/WP4hcTyhAdiD9hFYDYjOMbWU31O0ELv
         laPQFc9OY5S2HaX44iZn1qYsEKbXaZ1gaDre4IBgDZwbFLqzyreIoFrrFG9fHT39Xzrs
         rrcADUMVisc8LJTlITq8nfjDI4lg3DlgO8JBuJVdWAGGURXTqHRA6cTj8lULK3CpG8bb
         E1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706187; x=1739310987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjzFvEiohlFPJGTO3QTgBTUqYxbIV4/U/lISI94SKuM=;
        b=pEqQM54IeAQ3n7cDTg7XzcmcwXTXl9z0lPPmlpjdcukefxvQ5HDcNIfgJoMrClcT7p
         q/a7YxSMhx5nQStNZpDRPLFxf5XZYArJZ5R4uy7t+KJ3hKJy2Ntk6klAc0tmjzCJUNzh
         1xfbei2F0jRUZe5vp4X7z7mtuymrMTjKZ/ZVntYu2fbcl3izIG5F99AvwzEbnbwx4gSN
         pOfqxKR+RLxvMi6wAmPdIJtXARgL4n6PNnV1qKX5FB3Na5CUW1qdE++wdponxUecafH2
         hM4d22awE1Cib1v3+ijt/dxMWYR6UZz6tXFuwiLdwl4AtBQwILcFgytGU27hjf7F0iBk
         f4kA==
X-Gm-Message-State: AOJu0YxxdR+HoEHMFA7orUYu2mq5MOPVV1RYBp0g0CJ0Vnx2pp4nDQBd
	tQ5Bs1a2AK4IFdO0P7rIQ9IwtSqb2OpR89jrcG4FWDhyR9otrIoWV+3YYK5BjI77JlY8TcVCNjs
	B
X-Gm-Gg: ASbGncsMfcRlmdlutzh/r931ovuhoaZLtV4NNJdCXZY/2In6SpMEkdoJHj9OrpKJwSz
	oFSr2caMsie9gU31GQiMsE0/q8bH4pUCYhvO3cr39kKI8wahR8RcOYYkVnJb6mtpyCXfFtUZbGb
	hLki0vRLVRm2j1GJT3q0bcZSZvgCKoDmdmmG+2k97ScAZkqz2wwwoTlSNUJW+YQCxvdhehIapXp
	o12Ecl0RtwemUfBaKpfwCls9aMaSPSWgxA0ZyrdfTr9Y+W65e1tDmNJH62e0GHLJVK2VbLIfsTd
X-Google-Smtp-Source: AGHT+IErs6IioWuin52tx/BOqoeSaD3Nh2foCw6UP+aufNH2K5DrmS5KTnQz17mFHcvOoPB3S3MbGg==
X-Received: by 2002:a17:902:ef43:b0:216:73a5:ea16 with SMTP id d9443c01a7336-21f17e4e7d7mr7729945ad.21.1738706186337;
        Tue, 04 Feb 2025 13:56:26 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33007e6sm101739485ad.173.2025.02.04.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:26 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH net-next v13 02/10] net: prefix devmem specific helpers
Date: Tue,  4 Feb 2025 13:56:13 -0800
Message-ID: <20250204215622.695511-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250204215622.695511-1-dw@davidwei.uk>
References: <20250204215622.695511-1-dw@davidwei.uk>
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
index 3bba3f018df0..66cd1ab9224f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -94,7 +94,7 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
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


