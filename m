Return-Path: <netdev+bounces-185385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB8A99FD2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFB65A7DB9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327521C863D;
	Thu, 24 Apr 2025 04:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKMe452M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF419A
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745467388; cv=none; b=XH1rqEtMyMVwfM6gLWi4EgVNm9+GKi8OsXICDRao0+Negvv58wWtnu/djNg/Z2ZCR+F2vVH9jSP18Auh1Bn4muJJ5FaDdZqiWKDFEdvewDIa+8QDDFEwrM90Z+xhRfcwIbqp4agdl4klIWvCfiBdg9WpF/gmDDcfu6MyvtvAQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745467388; c=relaxed/simple;
	bh=4G6PWQVuDvN75y22hCzNOaMSSVueFKJQsuXjCZZMx9k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOAipRO7QrZx4VRffzJ2VJanxdEnxF/sVetRpSzWtFCoqlVLgcES/h8iQrUGXmUy3Ur7o57Kk1a/FZYEtdSypshf5QjuBtMvkuHSRXuwNthGrk96asxtP2RgOQt6GuW2yzD5vsTxPBfaLxjvakIu8l9IfJ0/2YS/1mxxfY8MABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKMe452M; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229170fbe74so4976925ad.2
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 21:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745467386; x=1746072186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8selbbQToSUa/Bg+HZMawzfuX6zEarAEcQjX78fl4Q=;
        b=mKMe452M8tpvDtkg8JDyU8VOeFgrOvcB9QckwWpCnOOTapfcUuL/JN3QeRXg4p7SJ9
         naOYFLg2oSrT5Kj7OfD7MyxSjXKn+ABO+TnQ+N7fxqjofKNlS+cVRDuy5YQcxRYjRiEg
         QTp0M7XMjuDrfe2DDYa9r8N825L6W1Ky5HMSwiwg0vCVYyIcgrHpBC0xzz5hAXbbFwJ5
         Zij2gmMlgKjc7Vr6ffzQoSSWkbrUZrxx6hpkt87IVL0X8wsIU5viw17F8IQcX6Z11jP6
         Aebv06ZWYyh83lfK9WDUMCvHSgKl5C/GCwlAWgO8Gn2t5kfj5WZZq1SakmGuvOIEZL2X
         Ir8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745467386; x=1746072186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8selbbQToSUa/Bg+HZMawzfuX6zEarAEcQjX78fl4Q=;
        b=sA/O2LBt9tISgoZOJOmw7mb4MK1FwIq0QjE7tHbPxR2qHOgwaxvl9YoHLvuXhnuJ/A
         DOccmrJhv6NWINnoXO3jYbAPOjhroXiGPUS1Tz1Po6Scuh9iYT7ZaZTcMw758CjJG8m7
         z76dyyyW4yldsPYK5ejzjwWKhRdOn9pSZLE38QrBadMD+OtOJBf3oQ0dfknVnu+SY6vR
         rcL4JY3rjSPhtH16Zdqev25r6LKR+KkwsZP9yeDpllMIXio8Xc0NHGIUjEgn44IFpmOj
         jzpFDIGs8dJiPR31KrEuGIJ/VD+zb6v6dcBLYf+lK7Y2J5lPMefkRa5MAeJLtaisWLGW
         8SYw==
X-Gm-Message-State: AOJu0YzWwNu34P3eIMktfsHHfoXTjdbMVfeX3Pc0aNNYIWI+JF1/1SqJ
	D7pncnaQU7xVlVMJ9m227oHcEqvqTbf0zbAQggmgYq3sNUXl5YikqSZyx+RdCCCIJ4npD74h+X7
	WXBWTA/fX3fMgOo/E7lXVKouaXwuk4tnJDbhpYNCaxyH6YDNdzRghrGcuhENZmTZhZDpP9AlqDO
	Y77F2t4/VoJtUoJUIUv1YV1i1TvoR2cFHABLaX4+SD+DNcg2hR/ezV0rSmLVE=
X-Google-Smtp-Source: AGHT+IGK7UYRkqxJlzG4egQUL0etMs/8hnfBJu3kSoKaPIbND5acRDwRmuLJDjQ8rd9K1P4hPANpxbQRx4HCkhuwpw==
X-Received: from pjbqo4.prod.google.com ([2002:a17:90b:3dc4:b0:2fa:1fac:2695])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:28c:b0:21f:bd66:cafa with SMTP id d9443c01a7336-22db3c0d5f1mr15899025ad.17.1745467384900;
 Wed, 23 Apr 2025 21:03:04 -0700 (PDT)
Date: Thu, 24 Apr 2025 04:02:53 +0000
In-Reply-To: <20250424040301.2480876-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424040301.2480876-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424040301.2480876-2-almasrymina@google.com>
Subject: [PATCH net-next v11 1/8] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, sdf@fomichev.me, dw@davidwei.uk, 
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
index c61d5b21e7b42..64af9a288c80c 100644
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
index 0f46e0404c045..17a54e74ed5d5 100644
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
index 6e27a47d04935..f5c3a7e6dbb7b 100644
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


