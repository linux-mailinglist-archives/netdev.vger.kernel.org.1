Return-Path: <netdev+bounces-234451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52841C20B42
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B69189867B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2B0279792;
	Thu, 30 Oct 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf7svA81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763737A3D1
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835491; cv=none; b=AdlCNUPfSbqg8eOd9VGbKlylFACDwdi1x2rDe+X16RlvLviuBNwCZTAoetxiQlLlQ1U63mRBkb9YoOfMlYPWDMERTgN9s1gBtT8nJ8HhsQiiPRcgm4xL71x29WfQ9UX/0bs2bXNczk9yEsZA/ykl1vIgSpM4A/ndJB2J4HnONXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835491; c=relaxed/simple;
	bh=gG6Rxpv+5xwuYbGpv4ZcUhGKoTxFro2YHfn3sG0/O64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIHptaWnt5cjIamwm/VfXc1lKco2vCmevYi4Xnau5a62VhHb4/HIUf6/lIPNy1W62ePTOWa8qFNkNMJDd/H33EjurEoK6BkajveeVhCZk9kwkqHdhe4iyYSlimfZ4ICj7hMm4nM1g6fvmdEloA8yU7DENAHI2WxQc0Bff6BA95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf7svA81; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29470bc80ceso13042775ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761835489; x=1762440289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=Qf7svA81zLPS7Jgqp38A8OMu2G0BSDFtQzbsnBoOeD2ObEGs1xD7+KI15v2TA/8cCm
         LXH5UurH5x0l44hLTK972xKIVAiWoFyBo5JMAl3xCESXpcezRSvbHgHR3iFJHxJmLzEy
         6XMgzqU3JDOWJiAVyr+DNvUvfpdCpRwvUx+gWhGaG1EqAVgR0jglWx4qJnUQ5P4nctRO
         D1/Mwc84QjL+psDRRLKQThFp8UqQ5n/f+zR4op5Jl/nW00eeTw4zNwXnWx0Q+TuwXv8a
         tKVnK1yLWOeU3K72tFwzqWHkdmyrrwYMs9oREKsZWtpy/xQzBdK/9aUnfLdlOnMdyyV3
         E5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835489; x=1762440289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i0KSYhBekRhZe3f+zVYiMKfUdeY1w53Ec33PFErQRM=;
        b=IbUKhbh6TCWXEuX+cYkCx8i4nxGZv+Bx9QCDBldo6H2voUjhUlUYpHlxS+S5bgie+S
         xmGJzajiT4AFDgP78LZ9rxMx/BPluTqeihwxoPLoi+hgGWFtSIIRK5mA7wx5Wlq9FMUq
         hRQJx2ySkxTB6AXTL5OWJt0iVV41W0yLL2nl/bGwqW+WqsZTSG23Kje9xSHOtsWwIzLZ
         cSjb2iHKQiMBNzU5J7hZaU0Ac/swPgWmqFdW/q0QxBGdXnXZHHhnbQqOnWvMtD44ngdl
         4I9K2jcIybvQVUb97WsfsEQk+fsd+HaWZ0/2XzQW8ruE4iZHdywkmIkTEhxw9T+d6lov
         QIJQ==
X-Gm-Message-State: AOJu0YxkYxjdIMd6oOjBjilxetfZwCCAVXISG9gIILz5HSzM0brE6Ar4
	OHTVxekO3jOodoD2nwGdeNLx9KqiOmaKJLLKBHnUg8HEyOf/WIB6L2bTbbbG8A==
X-Gm-Gg: ASbGncvfVRhdL9MzbBHcSXN0a1Msqgv5/vsALarj4zQgUga+PPDFdvoVb5kSonWKZvl
	3TaXXR1mFjZvzHT87/xzbPoBhMULi0qlIcy6qfiLqbYc4JbPaaG51KyYeUju6ZTghrcp60DzkdI
	FoXuQN+5wQ0dG7u5T9AFm6eflsCFFKQakUQvsdeF6OMJsKBcBB5hYyYeCoKufn752otgDPNHvrN
	0hKVqvQF/2N7ySluHNbEFMEbA1x9WbvCkbYbXZvEGh6hutYyIsXvg9XQS8+5kl6NMfh90U23lzX
	AJIAmtKyqn0V8/pNL9YhD7bIn0uKEDBzfMK2AcfBzFOA92GaIw6AQnr4WSTmS+qcCxfpin+RnHL
	NBaTqJ6pmyvQcjmz5ZhwGKmo22Jjf2d+ikgmq0vHw9t8EGC92ZpiDYxCvIqNy38OJRwb/Z1vHHQ
	Vvuq6gNRnNSgj1Jw==
X-Google-Smtp-Source: AGHT+IFKdzh5PqIDW+UtJroUaPTVHXn8ZahZ8UZQ7XX0MsdR/YUksfFQ5V7KobNywlg1F1FyaLwELg==
X-Received: by 2002:a17:903:247:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294ed098015mr40411365ad.7.1761835488722;
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:f227:4662:b8d4:840c])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e41159sm188520295ad.91.2025.10.30.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:44:48 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v7] virtio-net: fix received length check in big packets
Date: Thu, 30 Oct 2025 21:44:38 +0700
Message-ID: <20251030144438.7582-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), when guest gso is off, the allocated size for big
packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
negotiated MTU. The number of allocated frags for big packets is stored
in vi->big_packets_num_skbfrags.

Because the host announced buffer length can be malicious (e.g. the host
vhost_net driver's get_rx_bufs is modified to announce incorrect
length), we need a check in virtio_net receive path. Currently, the
check is not adapted to the new change which can lead to NULL page
pointer dereference in the below while loop when receiving length that
is larger than the allocated one.

This commit fixes the received length check corresponding to the new
change.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v7:
- Fix typos
- Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minhquangbui99@gmail.com/
Changes in v6:
- Fix the length check
- Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
Changes in v5:
- Move the length check to receive_big
- Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
Changes in v4:
- Remove unrelated changes, add more comments
- Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
- Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
Changes in v2:
- Remove incorrect give_pages call
- Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..421b9aa190a0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		goto ok;
 	}
 
-	/*
-	 * Verify that we can indeed put this data into a skb.
-	 * This is here to handle cases when the device erroneously
-	 * tries to receive more than is possible. This is usually
-	 * the case of a broken device.
-	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
-		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
-	}
 	BUG_ON(offset >= PAGE_SIZE);
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
@@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
-	struct sk_buff *skb =
-		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
+	struct sk_buff *skb;
+
+	/* Make sure that len does not exceed the size allocated in
+	 * add_recvbuf_big.
+	 */
+	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
+			 dev->name, len,
+			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+		goto err;
+	}
 
+	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
-- 
2.43.0


