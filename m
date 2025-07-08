Return-Path: <netdev+bounces-205020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE9AFCE09
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB3F1625A8
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F62E0B5E;
	Tue,  8 Jul 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU9z71tU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB0A2E090D;
	Tue,  8 Jul 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985744; cv=none; b=HKZMOgm3F7egEqJ1fUTg/VRUaIrhoQF29YTjm4dbvjTQLsNlOBZBVRqIKq88rGMjXQufXyNKsKwdr6EraJX6RTfN7vx0msLyDQWHoelK1QRNJDcsgw0dWpdZkBuWGU1lv7AVnBfUcFDTP8EqDMSQbsh1lPZxSbFQdXmdjm1M2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985744; c=relaxed/simple;
	bh=IFH/gTrs9FaiWA1Bh44A1FAet3DfzeFB+jW6pttiIiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHrOiRcEK6H1TU1KiHdQ0SbnVPP4JqLXeiMuvRg34Z/4S2DqCzS4CGnOBG9IgirnocQUGt7C3vRhYZksIqlciUQGK0SbxjAdd1MQ9OQqrG5jk3UwEXl0Z3N3knh3Qt0vuRjrTB3fWQWVZsPjTYTckkW+QRMW2V9XNtI8OClys/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU9z71tU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e1d710d8so58816785ad.1;
        Tue, 08 Jul 2025 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985742; x=1752590542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eb4SCLyW8aPTvGZMV/AD0x8iJb7grZBVH4VOwlfaNVc=;
        b=AU9z71tUTtMXRDo8OCrXn/hM8V86Z+3GqzDIvTySvacMRN9AQ492fGJrXmCPYBApYM
         jF1o5iHz+fCpxpLecQkiXv1+dA48PjDOVIDfLIiY1n830E9GiWcczoSIceT1fudKqc4O
         3MPcl16jOgRedd3V5IUlGEoX2zPwG331IB6NsDjCySDX8KB5dfy0I4XeQRmSk5LUdHtX
         AqqE5Z0VxgJARzuNdeOn6EJ5JU1EVfja6J5AuxgEXyAVpFyF2C/1h6/ybj/yZYZJN2to
         xXAsbqbkxIWKIYaDJdNlzeRkMQQUHEPbbfPkvLU8ZIQF5M0CUzJLUu2+XoqxUJQuMurx
         7CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985742; x=1752590542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb4SCLyW8aPTvGZMV/AD0x8iJb7grZBVH4VOwlfaNVc=;
        b=EtJlpA/NKP+aFO4ZnCPAtqEMHIsgoZfuyvhL2G6txIfawQUjCUBKZuCBm8Zp1k9/fc
         dkT3MTPXwckqAl5nW5GI6fMhi15ue0ZJklu9va/HZvttDHU/YdCSGLswCGMTwwLmnOJF
         s41BG7azo+YLqfETLrzCQEkqbI0AUdOx7VyduTV1YQiU1LqpbeBNqynPGuQ63sIskbcx
         yDCgcowaL62g1JIxQrj31s69P1/lj2op8btH/y422zU1gh7Wzw7i1xeYj7n2FWeuINAQ
         nl+jAOhjk9aV91N4jR8nDm+6Zv1uQBgMiJq81Ol6IoaG6Ql2QXT8AzovjG/WSVoPISfw
         kEcw==
X-Forwarded-Encrypted: i=1; AJvYcCUnrc7WMVorURjd3wMvxV4jc9Ik/6GgsVs8ccyZ6rxM1qNztTuI6ffKFykG8P5axfLkCl2fwWtYm1hnqxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowKAiPPwzM9ZC7c9Z6utcCjvz0R6U0TZzVgQnDRWdvfZUB9mw
	vYJOF3doCZp0SVEuY1hSrPRY3JwECw11nYTNpzrMUMGlmaekeOTmIZyR6gCpKA==
X-Gm-Gg: ASbGncuJE7bpXJz8M1L+rlbppaUiBvEfG60KyD2xBOHLBzFt006EaFbFdRVIJW+3noF
	dyJKBbn/fxGBY07HPh4+aGjbEinIK3UitxOqT7gwLS9s6Mi1+36ZKrg1+OnxCM82rZ4SU3xpueS
	EA2i9m+VtSpWvdggEt5WDw5RKkiOg95G8KVlT2ZrRaz6v2TLBoj1mZhhOHOQBMz9gdAieZSpaKK
	71COKQ/a/7CW8JLHee48RweygL3hcbXl9SbMWCqldggfAzrLVixOTinuJlY2nmr/GwCxDNjoh96
	QhIYLcJGZnKgoXg5M7MTBN6L1WPN8rIGAxncWyLkGibQAnQeifUHrDZ+ZEK9XX/rwT8ygIPqe62
	U+9ec6F/3gcZz
X-Google-Smtp-Source: AGHT+IH4sb/aC/QjC8Tg4KB/qPw7RdDAtp0xh3aetEQCl3CP8ba0jcWTkWAXh4nikC7m1hLrstXLWg==
X-Received: by 2002:a17:903:28f:b0:234:986c:66d4 with SMTP id d9443c01a7336-23dd1d3024emr38937115ad.26.1751985742188;
        Tue, 08 Jul 2025 07:42:22 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23c8457e673sm120061945ad.174.2025.07.08.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:42:21 -0700 (PDT)
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
Subject: [PATCH net v2] virtio-net: fix received length check in big packets
Date: Tue,  8 Jul 2025 21:42:06 +0700
Message-ID: <20250708144206.95091-1-minhquangbui99@gmail.com>
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
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5d674eb9a0f2..3a7f435c95ae 100644
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
@@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
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
 		return NULL;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
-- 
2.43.0


