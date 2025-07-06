Return-Path: <netdev+bounces-204417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8124AFA5B4
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2693BAD15
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723C2868B3;
	Sun,  6 Jul 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWWolZew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F12135A0;
	Sun,  6 Jul 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751811146; cv=none; b=QFr0WmFCHdI75WzBFhngKVAHJAOFrG23MxaIuNThkEFcrPAWwoRT9rjC3pEpZF6+DWM5/SG6HoaxvEqN4E4IbfUZlEauWeLaZ12a6aadbpdZRQwfU1VNN4dKt1hIdD8p9jWEOE+RNgVy5wMomEZsPQTg1AvS4qs/eG3gNfbBrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751811146; c=relaxed/simple;
	bh=YMQPaIuYUDFDFSVv86DN3Q/5Wjot7/hA7gBZ/qS/vLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qpsQZuHPhUjWQPM1ws66p7Qz4iw4vH/1YItfGwttSN+MsQud03acLV/mMULDEJnyyMnEwWcmqQmi3QROhAcLBHfdrLRIfM6GDXyRQwtFJyCDz2RbgHGF5gc1gY5DIan0dusO6TS+YwkqEw8uSAROxdo6ZlYb7G51GTUWslaE5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWWolZew; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a71d9208so1381894a12.3;
        Sun, 06 Jul 2025 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751811144; x=1752415944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmty3UwjQYxMt9/q+nVVzFNRCrwm25KzPNS6GD2HyFE=;
        b=eWWolZew9Eve/E/R+giw+lKeJOC25h9bt4fsJOvmD0CPUM1rchWVfesN7aW9lnTcgG
         umyIQoFT1gSheOeF0z2oGckj6CLSt18v7bR1UYFJJMkCt8k4QWmcAtNT3Qghubx2XYQ+
         rkUaBdez3CHuId7A8W2Y8VP+UqbyFMb2CzQXuXBKKSfPvh58wJ759FO4rhUNPXKSeUwD
         6WCUEmA21VIcz8KXrp4Rh21iSzWU9E9z7v0LPY+NLYqlTpSHhm0ool7caUV4k1TJNOGq
         SHWxdD6c7nlkAPPhINPeSlpTZjihFjIOCOPmO7WUpqar9pI+mcbr+R+xJuojHjqkUKDM
         KTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751811144; x=1752415944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmty3UwjQYxMt9/q+nVVzFNRCrwm25KzPNS6GD2HyFE=;
        b=s49svi97kL8+BeSBza74O8XZC4OH9eEyHcrjkmWuGMexVZDxXfjbSpzpEXCPIsL6FI
         VC5q9WcTvYhM4j4O/pez2Yfnj58Houdzg2Aahv62cteIgPjYiKxz7F68ikeNk+pEtVC7
         gCb3wqvRSw0ZiMsrfFTq8qraGZJ491B05PAXuTaetGcUf9jGCPpJj+w/MbPQ49bOpQks
         NHwOVeQNzUuxoMl4/FpsLCr7/pixpwo0ldyVpar0L80gzdqn3HbCgCQjmIWUl+1qV6g+
         gQ4mAoBE7oUbJL99HRzHGJ+KP3nMUH2aheY9SgvdLlOMTAgkeyrYKIxT12CtWnm+zi3o
         VrxA==
X-Forwarded-Encrypted: i=1; AJvYcCWv1X7wfQaOVTKsGTK+FdUEdp8iQYGux5WVbn2A1UqjP/W49M0N0nFpppB4Pf8ZIf/mhmScqU2RLv/HWnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oDAK2PxyQ9cks23NBpvuCEyeKaorira4vXzdEss/r3EWq9l2
	FDpLP2dtXtLBX66pR9BzVxXNJrrSQsXM4WSkbE7K36iIvjGFFVNxxXBupiHTeg==
X-Gm-Gg: ASbGnctqIas6+oyv3htl6+VRD01B/KStECZY+C0EjHUzrxoOnTCT6Tzm6G7Sl3z09kD
	JpI8RgjsPbm4Uz6xEf47KAMPKl6F4tQBLatCapYBNwtTPf3P5TdVke5fifNJF8n1X0Q4ZViDBDy
	zpjqWKpJqyFp2IRMwCV4gTrKPyUjU/13vyF6vNlfCENFfSRho66GBG0AzD3e2I2Jn2fP1tvaT29
	iDvHijivYIDYTqTTGIE3ETKQA9JYEUDkLFEUXxXKdxMiT77fGAO22lW+MQnGSzWQZAHvecpmkX0
	qGP42DyR25Gx/5NtDsSnuUDYbFvsibGe1AA16hd5JAWgcIFPcbUWqW2AiMNhq/wORuIhVfE0cVr
	W73j/JC1+xeU=
X-Google-Smtp-Source: AGHT+IHkMY/lRn+VrFKknoTqwsdTVy0zZpH8pPEV8VEaNmKPItjhky43HQDZRy1FJjpVkZPUnxbrIQ==
X-Received: by 2002:a17:90a:d64c:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-31aadcf9664mr14554793a91.7.1751811144042;
        Sun, 06 Jul 2025 07:12:24 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:4ccf:d06a:bc2:ae04])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8457e6d8sm66407425ad.155.2025.07.06.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:12:23 -0700 (PDT)
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
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net] virtio-net: fix received length check in big packets
Date: Sun,  6 Jul 2025 21:11:50 +0700
Message-ID: <20250706141150.25344-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), the allocated size for big packets is not
MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
number of allocated frags for big packets is stored in
vi->big_packets_num_skbfrags. This commit fixes the received length
check corresponding to that change. The current incorrect check can lead
to NULL page pointer dereference in the below while loop when erroneous
length is received.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..ead1cd2fb8af 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	BUG_ON(offset >= PAGE_SIZE);
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
 		dev_kfree_skb(skb);
+		give_pages(rq, page);
 		return NULL;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
-- 
2.43.0


