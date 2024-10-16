Return-Path: <netdev+bounces-136239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E39A11E6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE327283823
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654A212F14;
	Wed, 16 Oct 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nwDyXkEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9E18D655
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104783; cv=none; b=pWEavGFxUiKx8c6SXtw9Z018PaX2vKpr7QQ4QjVRcyNvti8CBrTjwaZz+GXJO7bjTF6eKcf90XGUAJ2A/PqfEb9QqUxroHU6dCVvDer31GauV+o28oteqi7PP2UumyIbQImnb4gPODQKJEWE6gS6uG6Zx/RTeoWHvaTjELQ/z2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104783; c=relaxed/simple;
	bh=GmYXYqS56Q71ym4lYvVibSD//+mv9JJ8nnPgR9ssbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iq9DEqFoYWGb6ELwGc5RX7ot5sbv1WGYXC7olfsGGVk6Kd5ETMG/8mfJNXkorqCphQODa6s3PPaz5D9qqg4ESlRe2HAR+jzK8a7TxA7C7eqaET+2ujrKKJh1IjqUVMr+Emaw6eVElPFSQyIte5ZkMS2rnRpxx6eKLhzsoPJ4IkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nwDyXkEy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-207115e3056so1058505ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1729104782; x=1729709582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2iyOiGEHYMsmcUpYi5USfAzSVTmDt+usnXuma/ITEc=;
        b=nwDyXkEyTNMbAmqs6v6tfzIbqaheMJAJpi0ajXUAG5JW0CLYNTmLBkE2AvpSNEKjW8
         EDSz8r/EUtbTLZ4mNNb27jlPuS1VBPAyQ7RlXyNJDd2Nc6I2Ax9gNTEk3poV6G6SheoK
         w8zmW3tbVs5j999AKXdSnbxI/e9DKbFFw52QbrMvh2SHrxoJH+WkTWbX6vyzkkRBm5D7
         BQAZb980QG1D2Q/jtRQZ8yMGvnPB7C/W8f7tOLJadUGfDqqZ7rV/QyaHr48vcgRmDqcf
         yaXmgwk1KtF4dpNY5q0pMf55om2yPaUGWasvAWzXb89pJz/jCXqgH9bICahVZpZNebKn
         U79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104782; x=1729709582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2iyOiGEHYMsmcUpYi5USfAzSVTmDt+usnXuma/ITEc=;
        b=uejxzjR2W2gct6lHNVGvuF0Kr7T9oUpP0Q9IA53st5VMrerPdLlJFPaZxzp4wEe2MC
         lH4W042+d3D0VGD9WB9ZyHxVUKpBA+4sEbM0pasCoIXlIlz1nfRf9Aovaobut4NLP8Ne
         jwPMIdrZJaJ3UKe3G3i+Pt9urftUPlfY80IBuX/zsbYmzl3cskUpTwXWhbsv8vuWE0bg
         pnN34gUmM+n+tmfAuPDCJ3PaOtmKAV6wFFwF0gP6ClwShBniRPhSOk5f6ZRbI8oyt47/
         thfJMD2ZDsRDVnW/qn9Wzpx6I+eMe1B5n8Q+cSSfv/uzZN+9K6K7FBD0qTe+SWljdCu2
         Vt+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKUTLf6cCAuiZeAii/D8sebEDDWakj8p5xrsmvNYo20ryVXETAAeZFibsqV9tdTyGbrtaju+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gu3IQwXXsK42SeLeuANledO/L62G2Uq1fWZ9v8dGxJzXW40u
	RpX9OUlFvT2I+FN7+FTe09R58hgavdjj7D3N0wYIbZbgCPYkV78ZLeYEbM+gRfA=
X-Google-Smtp-Source: AGHT+IFupie1j7/PvDtA9AJslm4f3oJrkkuMXhlztk4BbvClCKLlGfJYl1Rs/KJTpJSdBts6nRHr4Q==
X-Received: by 2002:a17:902:ecd0:b0:20c:cccd:17a3 with SMTP id d9443c01a7336-20d27f20bacmr63453165ad.46.1729104781779;
        Wed, 16 Oct 2024 11:53:01 -0700 (PDT)
Received: from localhost (fwdproxy-prn-006.fbsv.net. [2a03:2880:ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c17csm31816735ad.227.2024.10.16.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:53:01 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: [PATCH v6 01/15] net: prefix devmem specific helpers
Date: Wed, 16 Oct 2024 11:52:38 -0700
Message-ID: <20241016185252.3746190-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241016185252.3746190-1-dw@davidwei.uk>
References: <20241016185252.3746190-1-dw@davidwei.uk>
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
index 82cc4a5633ce..e928efc22f80 100644
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


