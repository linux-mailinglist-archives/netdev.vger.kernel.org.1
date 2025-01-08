Return-Path: <netdev+bounces-156464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE4A067DE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0CE1888B5C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC4204F65;
	Wed,  8 Jan 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mqAecmdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7439A204F8D
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374038; cv=none; b=nhSFUVlGWEheLALjNhRJbU8DdOpegg/MQad1Krp692mqmGRLeVT+ykMe2R09yXDRWIbUgitTOwxxXEoDNBRBr8pmcYwVwVcrvQUso3e58GdDHywl0xDxoDKVxpBy17a4BszskcmR5JOfTn1iXWV7L9F/V9rTh0lsh509mvw3UPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374038; c=relaxed/simple;
	bh=Bd0rHranX1tldtf5eS5ic1T+HB/zykxgLBff110E+Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmQhv0d4j7s613cIPuhTqxviNUx/JgQ+cb86ridDC9qGjAo5HXnRwIIGrXEblYyHIWJJ8NF3CMpAhYVGX6I+kDTKnMpJ6OVe3uZW6gO2dVucAYctDUi/77olJT/jG1t5chLLpHioVYF+7Zd1nLdFp1+QcMe9CQ6hYEbVMyZXqHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mqAecmdf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b1f05caso3364215ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1736374036; x=1736978836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iXcgdxDm1mzjOKK5nUQi77bzCX5UD7reUTrJiMtg6k=;
        b=mqAecmdfJtA0qCZk8yIIe4uo40IiwYIraz+RzxxSAjeOjL9THEJljoVM6KxOOTlJxL
         DfRA2uteIoGdfbt74i2a0ATMJkdYd6bnuMSrcH0OxSq0lddyyqRWsweqaqjvNjBsNBfv
         lCU54VhRcgKlbXfpESjctE7RZGOcM+tLEsqgu5tuWU30HpSslYoJMtD970vvBLEqGID+
         bCz8hpUVFjfOR3rR5wl2ol4/2au5b0dmEHA7RCgzYkJSYj1PNKzjwfh/MA+78yI0hHUZ
         I2mBRrWlAVoA7Lj7ZKubM6jDRZb1xbGjqNqA1mRSOrbTHWiuWHM5XiD8DduBaUNV5+Jy
         cQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736374036; x=1736978836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iXcgdxDm1mzjOKK5nUQi77bzCX5UD7reUTrJiMtg6k=;
        b=W9iOjKq6GZqzf74ckf2t+lBNoiEc5tODUHl4MnVfRDm4jGYpepIVM5Q13cxRV63vjD
         QitlUgeQhXiz+ucPYaI6HpzZ/dWiNhgFAHCcDtSRNTKEnMB1O3gN0yKTIA1oyE8DlkiY
         DypmMXWRE/eBFaV5BzSJEcyt+4AjaDRySAIJlDbPzypidFDfMwfxtvRWIDfi6W5AjUGL
         VYH8d5QQiEvsSUvX/LW0raMheDlO6dA28OmsFSvZyOj86QdaCEfVYmgVqD9neNV2YkBp
         8W1iUGqPB2xPKM7ZJn52C0OMfowdri7I/maoYXfVMaIeK/EZZDgO95qSPxmC/VISxu6y
         CS4A==
X-Forwarded-Encrypted: i=1; AJvYcCUgFvnf6NwzgcYXeYvfgnj9+STjr4XWGM64ioxdg0du9yvOKaTwq+yeEoSlRTdHubgg4YSga2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjkK5PytU9GoLT2tIP3hUCsv7QfmUNW25En5eeun97t/m0gGD
	lECwR3REPpjBNWyX15mdLY1W7oms1/b4cTEfTW7F8zfsMccp7mSn00ezwo0TL3M=
X-Gm-Gg: ASbGncsK3Q32gfvrQGj4tlpuVk+WTS+Tqe5GdJDV1FbKviJ263QHrU9cMKh1tnOoGC+
	h85XH1ioxkBYSDG2eYE1OqLqwRtnx9zvHAmf0d3ZjOBFi0vv75pHh7ZgW2+XMHy+L/W9JJ0+X7h
	dnImJ9soJlG/+xwDIez3GY0wG44aWMqMg9wtjtv2jofE6/7NebkvaQF4wxqFzb+6HA4DUxAflta
	LeQtDTVaypC6jeuSoD7pal34/geuSOSSa7ElI1EEQ==
X-Google-Smtp-Source: AGHT+IEhULlhi05aHg7h595uBywuyU3yAhGRtdIPLo8jQjGgQZgTPBEXackKna6YQgxV88TWSVehMg==
X-Received: by 2002:a17:902:ea08:b0:216:3876:2cff with SMTP id d9443c01a7336-21a83fe4cb5mr58816885ad.54.1736374035821;
        Wed, 08 Jan 2025 14:07:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f44sm33318215a12.15.2025.01.08.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:07:15 -0800 (PST)
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
Subject: [PATCH net-next v10 10/22] net: prepare for non devmem TCP memory providers
Date: Wed,  8 Jan 2025 14:06:31 -0800
Message-ID: <20250108220644.3528845-11-dw@davidwei.uk>
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

There is a good bunch of places in generic paths assuming that the only
page pool memory provider is devmem TCP. As we want to reuse the net_iov
and provider infrastructure, we need to patch it up and explicitly check
the provider type when we branch into devmem TCP code.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c | 5 +++++
 net/core/devmem.h | 7 +++++++
 net/ipv4/tcp.c    | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6f46286d45a9..8fcb0c7b63be 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -29,6 +29,11 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
+bool net_is_devmem_iov(struct net_iov *niov)
+{
+	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+}
+
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
 					       struct gen_pool_chunk *chunk,
 					       void *not_used)
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8e999fe2ae67..7fc158d52729 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -115,6 +115,8 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+bool net_is_devmem_iov(struct net_iov *niov);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -163,6 +165,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline bool net_is_devmem_iov(struct net_iov *niov)
+{
+	return false;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b872de9a8271..7f43d31c9400 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2476,6 +2476,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			}
 
 			niov = skb_frag_net_iov(frag);
+			if (!net_is_devmem_iov(niov)) {
+				err = -ENODEV;
+				goto out;
+			}
+
 			end = start + skb_frag_size(frag);
 			copy = end - offset;
 
-- 
2.43.5


