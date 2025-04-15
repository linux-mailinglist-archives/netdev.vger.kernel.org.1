Return-Path: <netdev+bounces-183030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B0A8AB64
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7881902A26
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA92C2AB8;
	Tue, 15 Apr 2025 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2FBz7nl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D202C2AA0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 22:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757281; cv=none; b=VoOgabZiRKCKrk7e2Yg2ayRBNoBNgPgqdfBVV9EuFfCDn76xi5M4lLb0VU4WLBsXY9k/YAwj7RXZiroGI0u2Xz9hWMjD7zPq212EnNJoUGNya62RDKkFA6Ckgt90+owkGIGr4r86kBnUdcfnTUfX7pbqZBtPaJ95KDcDINBgyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757281; c=relaxed/simple;
	bh=cQDqckBf0hmDXK4g9ynIco3ZrZkTnIyGRhG/+zQ4Cws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NyEbZknFs5g9HXkMlmfuXFH+5HF5A7TtCheNKZ/OrCUM7VKLUyWTYXIRsCq8F8yx5MzsUR9AfG5HQ6ntx+tvP4FphsPHjnmGOCC/YNwHotYguAUQZ1KhgRIL6YjGdWV5GSK13LCZhQbqiXjI4KPUXBWarmmRxc/WuLzBh2e6ykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2FBz7nl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso5199982a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744757279; x=1745362079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMYJ9mghgsGT04ywh+6f5ef6ONFOD7mnlTWJ6KE3E4s=;
        b=M2FBz7nl4UOv92RVPhhWKzQ0mN1gxfbODCdjY+Oh8I3r6H4I6QlxB65PViyWBS4vRR
         HIufQoxN8+5fJgBepnPXHJPN41n0RAPn5JJ2zmpHmXib8wQx8i1kqUobcidDD+XnyLNh
         OeWEGBuw7C/DOeBTPNAP/QbfAqN2jYWWjOFhj7IAKBlz6G6ezdi4nUiv6M+FVURdNImH
         eM/oWjujagj8d0cvBqSD3FKsZoTAZBqQbynvNu694MMvdGJ+Qmh+QSkThWA60cAIIFKe
         FGggpmuw2Zb3gOBb6se5/3Eyfi0j/ptAVnbim0KPhPmsNC8pd+oMS3b5YLz1TeDt9zsY
         MvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757279; x=1745362079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMYJ9mghgsGT04ywh+6f5ef6ONFOD7mnlTWJ6KE3E4s=;
        b=FwJcrlGihgyPllbc8GYKULXAvo3E/9OHMbOo8QNFaV9NyL/Ge58daq/L58kbWYQEQI
         F3AtgtkfhgL6HYatCOR85504znL4Fckk2hBFQZJY7oECyp7JkzrXEukfKhorsWjqH5A/
         WT76oGCT2y4M8GObJqmexmO8kPYJ2GSqBHC3qHSHw08LbbMrq9LSNx6vXMMFg7dqgJiE
         dtaqm1FUmI+ycmlzNhRvfGMQUpNnvkbjrTPUlqho6I+OU/STsNgSgT9HnRhHeEw5ttM+
         ykvzpbZNzQkyUw46v7SK0mu/vI91Le70yh7fFo3y++Hyv8N1MlhUA0+yfSkCzXQZQD0D
         07YA==
X-Gm-Message-State: AOJu0YwFFHyrrm8VflwxXZ15Jq+bbuh1rZg4vodE4Bq68TMdKH+ZtG7G
	0LHtJo8ubALfT+OWXADECp//WBSi2wHw0tBXEDpW4ZHUlNTuY/qGUPCv6a4OOTRw6Xfuy7Iq8AO
	PBulV9cSmuLKgl0J9mBXqY3daRHOQsisRGzxnPPTvugLRPSnTX09IAE+nbNHtUcipg+/jE79ZDc
	FYRl23AAz+c9uPdM65xAb8UCmp3FxepckczHoMmdowphsaiJOPMo52UQrDLCQ=
X-Google-Smtp-Source: AGHT+IGJWEyQPog40oxrMqoGsHI/uR3lYwzFocZD/EUJPpg1Ph4n4p94UxN7V/pG7QlDhDYzCI99CzW4KOsDU+Dcvw==
X-Received: from pjbso12.prod.google.com ([2002:a17:90b:1f8c:b0:2fc:13d6:b4cb])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c8a:b0:308:5273:4dee with SMTP id 98e67ed59e1d1-3085ef200bemr1637324a91.15.1744757278334;
 Tue, 15 Apr 2025 15:47:58 -0700 (PDT)
Date: Tue, 15 Apr 2025 22:47:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250415224756.152002-1-almasrymina@google.com>
Subject: [PATCH net-next v8 1/9] netmem: add niov->type attribute to
 distinguish different net_iov types
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
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
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>
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

base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.49.0.777.g153de2bbd5-goog


