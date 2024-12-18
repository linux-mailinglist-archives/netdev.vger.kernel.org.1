Return-Path: <netdev+bounces-152760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4F9F5BC2
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE31882056
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861E74C08;
	Wed, 18 Dec 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="iapC7qnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB570817
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482287; cv=none; b=RERkozl1at9Ai19NU12ZyEtqhMngji8aCaDs2AeM3ozf8JbDAb+rrvbEWZO/tpLkU6fJGSrJxMRXmdbhMYZ5zgOE43LWE238liW3zAEEZC9GuB1DtBQbLSJ5XkiPAE95PRV6Y0eEeQ7S+FSa567DoUm/Tt6t4+MMHpFYt4u1seM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482287; c=relaxed/simple;
	bh=u8mGZDNB9Qjmsc/UlJUfk9+yqa87F2hF6bBOxlT29Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7UNSJJY9kIeE3lcCkfon0Dg70HsrAe07i0k2MHf4/PxD4cRVovxBBd+U8+YX4JLqy6CNdvDrRakj/OR2YbLwmIe1aYEU0ufAYcp3RAWu+wLttVV7+Q0LIeJCcaXjT7U/LRfc0PIr9OllvtWOfalCbRBiCxgBYQHzQHxUICtZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=iapC7qnD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725ed193c9eso5080640b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482285; x=1735087085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfBsLg62G3udJQ4BEA3v9yLwP4UTZUhvXQSSmczl4Gc=;
        b=iapC7qnD2h0gLbJPs1WER5FSAbdMJFxKlO3u1aOFSy+Vv+XKbEv5XLrmtgsGEAtn0E
         cbBaaa4jR8erxBnNhM2WMY05e+BdAklpPlfXcdu+THbrrllZU2PnQ2WwCKuuMYZ4woIz
         Us3IhF9XnYhWw7uMRAgKWKrU4OfnRVznKjbAqqxKdpZvOQrhEX31n0EoTPIdR+7DdEYv
         u1vBYdjqxsAwQ/hzSjtok8+DLkupU7Ekg/HDjrVram45tNQxG3T4qbDTl2YBqRU1e/fs
         zTj+q97WEUa5fy5sz/JZQMv74KOcqTqnp8pFlLY3m396Lg7aRTNT7gTLRGBORZh7ll9K
         yZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482285; x=1735087085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfBsLg62G3udJQ4BEA3v9yLwP4UTZUhvXQSSmczl4Gc=;
        b=YQLNRRGmVyTft+aMB0xoRHCuJXOUNyS/rhUCl7bQ6BF0Kd/JWzJQwaX0J3N7KOVTmi
         +4dQQ0sJBII+EhGIMiF1vKn0xAjEPFdxle/760kXDi5DeA0wJHczZUswbtNrY9g2PSIk
         tU/UuDUZ2vfORumGhvaWsjKK75XbprUDRf8gL5i8kNn3d6sdYmeYf7m/DIAir+AFHYmd
         kaYfGYtwVGp9AAdwJ0k3aicin1Xd4ixpNe9XgGZbb1pApl7oQqAC6ObRu8ZQBOgbpB2K
         Nn52AS/UELFWsbkRvU/xxa3A3oHYK+w3TSyHtV37yo4riyq8IhJK3GCHRnSCxgpy9MOR
         Jc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWLEK+6srRVktvbQhy2Urs+oOGIP7GTqJeVnzO9jJchdrsHN5Wm0Z2vk7GofK1AySaTCqwHZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0boJ2NqtnPpwrJkLpmxMSQ3MOVpjlQIntEPqcAQPgUNu2i1oU
	96PxYd8Td845ubFrDgzWRx4ntuhm/5C2JpGOpMQ7PefEt8aIFn8g3Y+qs499l+0=
X-Gm-Gg: ASbGncvrGjr9UR06ZepJCbBCaqRMwf/cHVTm08jN3xO2BvAR2t+J9RAWow+HKVvvXhm
	EAql+51tjVslVduFX5kfnSx69WN5IzZZTwxuwZOhuUrL/47EHp6C8jXp3q+0b9jOjqPYCinYbJf
	usepTfALOaIZxqVS7kDwmFRpGxH0ksvCsvphPD49Xmy3pUYdJc+xaaZQwZdhYqy90TxfRc3jlXc
	1Oq3w17xZkl/JVOSVh/wCoYzmz11BilLqx8adIBdQ==
X-Google-Smtp-Source: AGHT+IEw9r6pYaV+WZpZxDFOXvkhuSj4oVM1TjX5jqIldm+QJwQg57nxRHAvaycdcT0mPs5JISR8Fg==
X-Received: by 2002:a05:6a20:8408:b0:1e1:c26d:d7fd with SMTP id adf61e73a8af0-1e5b48a0f20mr1498011637.37.1734482283788;
        Tue, 17 Dec 2024 16:38:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ad1db8sm6414671a12.44.2024.12.17.16.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:03 -0800 (PST)
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
Subject: [PATCH net-next v9 07/20] net: prepare for non devmem TCP memory providers
Date: Tue, 17 Dec 2024 16:37:33 -0800
Message-ID: <20241218003748.796939-8-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
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
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/core/devmem.c | 5 +++++
 net/core/devmem.h | 8 ++++++++
 net/ipv4/tcp.c    | 5 +++++
 3 files changed, 18 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 4ef67b63ea74..fd2be02564dc 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -28,6 +28,11 @@ static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
 
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
index 8e999fe2ae67..5ecc1b2877e4 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -115,6 +115,8 @@ struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
 
+bool net_is_devmem_iov(struct net_iov *niov);
+
 #else
 struct net_devmem_dmabuf_binding;
 
@@ -163,6 +165,12 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 {
 	return 0;
 }
+
+static inline bool
+bool net_is_devmem_iov(struct net_iov *niov)
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


