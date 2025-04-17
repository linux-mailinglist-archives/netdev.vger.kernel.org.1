Return-Path: <netdev+bounces-183967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D885BA92DE9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B78B8A0428
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724C922259A;
	Thu, 17 Apr 2025 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dz7gatTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A09221F1C
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931748; cv=none; b=k4YcPWVe5X+S1A79nucjnBN0LpzYdyUY114oHepJWV2t45HXa2W8Q2kRJemKgmLNsQT/dWM7E1fyQG7gRgfepc87J9zMsGQ22v6GT2b0SrmVMZTf9/adKlTqqZGhAKcv0Ua0f4+5QDdMIPEVGEf0gz7hs3vvrHarsvpap1AmxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931748; c=relaxed/simple;
	bh=PxUi6PMnLLjyTGTj+svoqP26/eSAQtm8kaSii0Qle9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KdQ/rf22xj4qbe/XGJTFijez6GBaoj2VXFLhS6vJHLibivFtXiUuRm4hPKBqNMkdtVK+LXmbdrq3OKxjw9YKe9QPLIm0yXBPZZSn80srb7ZgpK+SSlp6bWTIdAxQUoO2QbTANVufdunyTnnzcAXp6GCJ6DeY8Kbj2CqiHDZywEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dz7gatTo; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2cc760e316dso830171fac.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931745; x=1745536545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5104Ofe9FKOPF1WtDB1Sgb/hE4K8EHHAmPkusRmzhtE=;
        b=dz7gatToHLnZmHiKH0vabB3re5gTshFo+KD9uo5e+diX8L6TerG/15Lh4IATYtJTNx
         6H7Xn3PaRKY/3Ofokyn9TXM+GblA6BVgN4xoQpB1cCnuP6nnHpTtD5W+M9he6Uqx3tZj
         PmSissMbJnYLO4JCoq0VH62P6kwSdoEgOobFdQs5pLy9ZybMJGH6+Wbzd2qHCigqFxmg
         0Jw3UlHseD7XoWUgG3GMdf+zhItey41nicJEpBnCXveGpElxEIt7Yug5ATVL1H9HnqsV
         2uxaAnic40c1KH22KCQ0EPo4rWyC9y9QVg8vyjNbtHEthZHZw75Rr7HkrrWFuuzMkgw8
         6n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931745; x=1745536545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5104Ofe9FKOPF1WtDB1Sgb/hE4K8EHHAmPkusRmzhtE=;
        b=IcxQy+MVg+X0eEtQtVq3Ah3wTjAl8RXoO97I9YyOKx6r+o4aH3oMjCzFTbFpI2dsT1
         nlNNJMJp4HE5KN2GjW1DRJuANckG3FH6hNvXzE1x6KgeKFkF5I8xLeyKRtMHzAtvFxFx
         iGLBQzQ+OL6MSS0pcG/XIFF6ttmNCMNHklZzX5rydO5Bv6adFr36j7RGItmGsbmPpWWB
         8MAE9N2IFvLNhddZy20rYJGqVAexQSAlPF09STp4SSf73alYuCUbp3O50gyUdat9v1M1
         6kIM3KAiQFG2qDTF3eIYj3YVHR7wL/A97c+7RXDc37z1vxNufC+s0Lw2zw+xQEoALCTM
         UC7w==
X-Gm-Message-State: AOJu0YxnufijrTxphMagznd5bo6FMf9Ml3XL0BNegRvKa2WZYfvgqtUd
	AzPkSCz+fnVzCWElWEXSLUcMDBzWqsqdtO0JS60IsFbYeBZsMfo618GbbN5cZnHXywPysNHmWER
	xkOvje0+exQNxdE3bRnT+RYPBVwrozdeI30uAyBVHJHxumI3OHlhhPZvX3xkjL0IUKGbqlTtMqY
	7vzQObcoYP+ngw8Hb6PKbrTIbqYpvhDEUx+yS9fu1iPbnU+DNxoDiTTrDJvYE=
X-Google-Smtp-Source: AGHT+IEMqL9YOVOmk+jyRPo0f1di937KXmsXcGEDfTc+n7gctIS6OyoI5UKywgc4XZvX4lCMTpokjhEqxuCoIrGZyg==
X-Received: from oabvp23.prod.google.com ([2002:a05:6871:a017:b0:2b8:1fa:4ac5])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:6216:b0:2c2:b85b:71ff with SMTP id 586e51a60fabf-2d526973eafmr406639fac.8.1744931744709;
 Thu, 17 Apr 2025 16:15:44 -0700 (PDT)
Date: Thu, 17 Apr 2025 23:15:32 +0000
In-Reply-To: <20250417231540.2780723-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417231540.2780723-2-almasrymina@google.com>
Subject: [PATCH net-next v9 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Later patches in the series adds TX net_iovs where there is no pp
associated, so we can't rely on niov->pp->mp_ops to tell what is the
type of the net_iov.

Add a type enum to the net_iov which tells us the net_iov type.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v8:
- Since io_uring zcrx is now in net-next, update io_uring net_iov type
  setting and remove the NET_IOV_UNSPECIFIED type

v7:
- New patch


fix iouring

---
 include/net/netmem.h | 11 ++++++++++-
 io_uring/zcrx.c      |  1 +
 net/core/devmem.c    |  3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index c61d5b21e7b4..64af9a288c80 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -20,8 +20,17 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
  */
 #define NET_IOV 0x01UL
 
+enum net_iov_type {
+	NET_IOV_DMABUF,
+	NET_IOV_IOURING,
+
+	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
+	 */
+	NET_IOV_MAX = ULONG_MAX,
+};
+
 struct net_iov {
-	unsigned long __unused_padding;
+	enum net_iov_type type;
 	unsigned long pp_magic;
 	struct page_pool *pp;
 	struct net_iov_area *owner;
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0f46e0404c04..17a54e74ed5d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -247,6 +247,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		niov->owner = &area->nia;
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
+		niov->type = NET_IOV_IOURING;
 	}
 
 	area->free_count = nr_iovs;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6e27a47d0493..f5c3a7e6dbb7 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -30,7 +30,7 @@ static const struct memory_provider_ops dmabuf_devmem_ops;
 
 bool net_is_devmem_iov(struct net_iov *niov)
 {
-	return niov->pp->mp_ops == &dmabuf_devmem_ops;
+	return niov->type == NET_IOV_DMABUF;
 }
 
 static void net_devmem_dmabuf_free_chunk_owner(struct gen_pool *genpool,
@@ -266,6 +266,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
 
 		for (i = 0; i < owner->area.num_niovs; i++) {
 			niov = &owner->area.niovs[i];
+			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-- 
2.49.0.805.g082f7c87e0-goog


