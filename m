Return-Path: <netdev+bounces-102089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31875901631
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FC82817F3
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CB3CF65;
	Sun,  9 Jun 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrNfhBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B317E9
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939064; cv=none; b=FuysCnl4XqutvIKfrrBFNcDKLYFAlbpnEEOdGPuNjYcJ6tjXmWS8gpe1iP9CAeuXSr2Pi3vxmKM3t+eQ6y7rRLElC36CV4dF4Q9SEN+FZdhd5j9trsWx4fWQCfUCauMihroexpLrolL8CjG5njLLlh1CQ9pqBOla6r74YbA0fh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939064; c=relaxed/simple;
	bh=skmwMXi8kAEMyCrhhGcH/OZjY7wPIsNpAHXSx8oGsww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABuXZ07TcdaZHX40LH2Dq+YDOwLjDDHO95IAj0qYq+RGQBHATMdvjCFgoJE7P/Mz4xdbR3wNJcTqV+qpxoH+2X4SQivK6Qjn3xcMp98Ar31V/Wbjr8sJKXxEUi04rnJqa2xdO32681x946UrK/IAMxcwQFXeMzS6QDKwq8AYmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJrNfhBV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-704189f1225so1488873b3a.0
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717939063; x=1718543863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjxt4NWAvaamGZW7AUUoaTNwwiKOEAfHLcMVlnfmIVE=;
        b=KJrNfhBVjA+gv8f1Bvquu60tcbH3JUIT8NhXnb4NrJ0emPtnoRlIvovoFsovnvyipl
         DEDS7chJ7gdegLDM1J4i46WG+3pDLLnVvWoKELOo4OKDfXE01ZKhXqg8ptyPDm+NY7eQ
         y3EZPozoX6vZT274efF/9lepgC/CepkJk+vhsU7tcaqxHBOCmXYPWYrUkKhgUn/p2Jib
         AczG+8hs8cshmUGugl0+VwI+HKqOhC6nPwxFXBQ4Ky5naaBOgAthiaPhME/RSDeqnBOo
         M9VR6LiXm26TS3ZE4m2IqDOYR1mX/gz8AFrqA1fEeSmZTAQD1gvhHseV9Zz3icR7MJhB
         mp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939063; x=1718543863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjxt4NWAvaamGZW7AUUoaTNwwiKOEAfHLcMVlnfmIVE=;
        b=tZGk7uwc+9OiwEz5gpnvxcHMj22pBqot7Q+fmOZbTBvS9isVzqrEEJt0KX+or9TPj9
         PvAKQTSRi2khMihf5NEYIejuOKJzYMpdM2EwK395vdmSOtfm7LLs0yyvnRUjcEnKc+ac
         tKylKCI9RXJDyk2Azztqm2CtK0g6nWEoSwJXolgFGngBAXIo+TAdSU0vujG126lr6iU+
         YekLI8fjtudoZlhME8k4mGLjE6xh2ZAcF0hOHLIQonYR/rdPCqkqpqBep6yA71PAXp6a
         034MBCEHKbyIS3Rm6RHWa9oTUABOXQagz+qgyCwz7lhSgg0S9gS80IHAt1L5YzWlMLp7
         76Yg==
X-Gm-Message-State: AOJu0Yznx0UVRCNmG1PQsil2jrlLPm3F5VtGwDDu8jk29gohKO1FJ3h4
	XwpUqYN5p5+8t+SaDzfCxyjzJ5WjBLl8U6GEIQf6XDmrKd8djP15
X-Google-Smtp-Source: AGHT+IFvZ9ARLcJIdJ1NTa5flp5NbsdqX9gcFA3fPPID/tVQPWlWixhgOgxKp7lpw/oCjaaKoQuzDw==
X-Received: by 2002:a05:6a00:2e05:b0:702:7cf0:e1a1 with SMTP id d2e1a72fcca58-7040c7489b5mr8203716b3a.32.1717939062534;
        Sun, 09 Jun 2024 06:17:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50beb6sm5412109b3a.176.2024.06.09.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:17:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	leitao@debian.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: dqs: introduce NETIF_F_NO_BQL device feature
Date: Sun,  9 Jun 2024 21:17:32 +0800
Message-Id: <20240609131732.73156-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since commit 74293ea1c4db6 ("net: sysfs: Do not create sysfs for non
BQL device") limits the non-BQL driver not creating byte_queue_limits
directory, I found there is one exception, namely, virtio-net driver,
which should also be limited in netdev_uses_bql().

I decided to introduce a NO_BQL bit in device feature because
1) it can help us limit virtio-net driver for now.
2) if we found another non-BQL driver, we can take it into account.
3) we can replace all the driver meeting those two statements in
netdev_uses_bql() in future.

For now, I would like to make the first step to use this new bit for dqs
use instead of replacing/applying all the non-BQL drivers.

After this patch, 1) there is no byte_queue_limits directory in virtio-net
driver. 2) running ethtool -k eth1 shows "no-bql: on [fixed]".

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/virtio_net.c        | 2 +-
 include/linux/netdev_features.h | 3 ++-
 net/core/net-sysfs.c            | 2 +-
 net/ethtool/common.c            | 1 +
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..619908fed14b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5634,7 +5634,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			   IFF_TX_SKB_NO_LINEAR;
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
-	dev->features = NETIF_F_HIGHDMA;
+	dev->features = NETIF_F_HIGHDMA | NETIF_F_NO_BQL;
 
 	dev->ethtool_ops = &virtnet_ethtool_ops;
 	SET_NETDEV_DEV(dev, &vdev->dev);
diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..9bc603bb4227 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
@@ -91,6 +90,7 @@ enum {
 	NETIF_F_HW_HSR_FWD_BIT,		/* Offload HSR forwarding */
 	NETIF_F_HW_HSR_DUP_BIT,		/* Offload HSR duplication */
 
+	NETIF_F_NO_BQL_BIT,		/* non-BQL driver */
 	/*
 	 * Add your fresh new feature above and remember to update
 	 * netdev_features_strings[] in net/ethtool/common.c and maybe
@@ -168,6 +168,7 @@ enum {
 #define NETIF_F_HW_HSR_TAG_RM	__NETIF_F(HW_HSR_TAG_RM)
 #define NETIF_F_HW_HSR_FWD	__NETIF_F(HW_HSR_FWD)
 #define NETIF_F_HW_HSR_DUP	__NETIF_F(HW_HSR_DUP)
+#define NETIF_F_NO_BQL		__NETIF_F(NO_BQL)
 
 /* Finds the next feature with the highest number of the range of start-1 till 0.
  */
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4c27a360c294..ff397a76f1fe 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1764,7 +1764,7 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
-	if (dev->features & NETIF_F_LLTX ||
+	if (dev->features & (NETIF_F_LLTX | NETIF_F_NO_BQL) ||
 	    dev->priv_flags & IFF_NO_QUEUE)
 		return false;
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..efa7ac4158ce 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -74,6 +74,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_HW_HSR_TAG_RM_BIT] =	 "hsr-tag-rm-offload",
 	[NETIF_F_HW_HSR_FWD_BIT] =	 "hsr-fwd-offload",
 	[NETIF_F_HW_HSR_DUP_BIT] =	 "hsr-dup-offload",
+	[NETIF_F_NO_BQL_BIT] =		 "no-bql",
 };
 
 const char
-- 
2.37.3


