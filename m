Return-Path: <netdev+bounces-102436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C8902F23
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFA8B20F0F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8A5FEE4;
	Tue, 11 Jun 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HagoDYnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF22A1C0
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076748; cv=none; b=TPPlbYGKMnRFdB3WWrxOE+zsByEnSFqF0xX87Uz8TkJvJ7cpx8GN7G3bcTP2a8fMKx82t3RsI/TVxGVAP5mMbmMDauraCdAtWJu9R6fSEkGsx6iakTmW55myAceG2tcvBGDbQ/zDndx0QLJtrkskz/8/hvooDjvSs3hM0rM5I8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076748; c=relaxed/simple;
	bh=2QO5z4OcBxKUrfhrCLE652n/xmEu/8KzBWTmvbZbBCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YKYA1ab4GJb/wH0HJpQ0DFie+RGxgn2nekFJ0PfkqCbAo1m1VGKGFxJnKLdJM1XfEGa4EqOa/iUsRdYh9DAKdxEIj9MTN2OTE6fMG2NftOOBD+klvE6yX9ya9fjsFE+fBxSFJIvYAMduoRBxBbvzl1L64ued5lSD3WonUqpP/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HagoDYnw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so38485225ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718076745; x=1718681545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uI6Ut9gIbD/ucRCwl/DrjGu7HYdx7Zy6RpemUZL8aY8=;
        b=HagoDYnwJxbLyAxGgB1VKWWcW8gkPXI+VH4sw9JlhrUZdqMIik4zrkand8klF9VeTi
         v9eV9PrVcG2gHGzomcMn9dgxSz/OJWcSsqDh8ZPmxKVNJUTKYpcb9Qr3WYGt+MFJihEU
         LlOKRLkmAx4HR15MZPc/Uy+zl3MB/lNkII/rvsCzOMUk/VAxdqWpnS9j9a18bUd9zV5W
         W1x9Yv5p4YUmJOtZgibzqB6rmMRcvUZvj46wwqnEphLi5kqnvcHn7y7xwvSompxNiRhz
         YRtt+p1ABtnbkab+x8xj4bNRb2GsDblcr2RaMl0vm4GVnD5XcfPHqYUovLIyDppelnaF
         hHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718076745; x=1718681545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI6Ut9gIbD/ucRCwl/DrjGu7HYdx7Zy6RpemUZL8aY8=;
        b=RGtUpD9VtY/78tMKJLsFI44Nb19cemfTF9pHWWr43Xx+b62LI61hiijF1+5zzK35hL
         QKOkPMb+T9Igq001HaW6JQtTgVCp++BfUY7k1dM2V7aqvxOV1JXa9duDZBFnkEV0Frde
         dmJom/7c23ZtUfzdiB4wqWNeofiPGp8M81Qx/5devkB0dNXXPAeG9L+lJqP3os16zVLl
         t+0eZv2LnYs+xK2SY7R3J/VOiJxyNzfYngWm1Y4g5tkOs5DNp/t3HkPO8MT0emz3eTca
         h1Bqih4UUInL47LcrvVTh9zXWXQOYAVLaJPPf3lNcoRoIUk7E+0eJMUv/Q5mSG9DE0bw
         Xi0g==
X-Gm-Message-State: AOJu0Yzp4Czk0sELWSzs553YuyTBfI1q+mER7sGqDG2SEV61kWGjNjzt
	Qqqhx45YnczYFnCoaN141Cv0EOJ8n5AccE/xnxZtpr2gj/wncmpo
X-Google-Smtp-Source: AGHT+IGqZ5gZtgM7t367LdXN9Xu1POTY4+j8oePK2xJEjjVeRhSou0gJNdiFxpMfNq+R9vFTYIok9A==
X-Received: by 2002:a17:902:cec9:b0:1f6:f298:e6b with SMTP id d9443c01a7336-1f7287a763amr21940445ad.13.1718076745331;
        Mon, 10 Jun 2024 20:32:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccd20sm90081465ad.141.2024.06.10.20.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 20:32:24 -0700 (PDT)
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
Subject: [PATCH net-next v2] net: dqs: introduce IFF_NO_BQL private flag for non-BQL drivers
Date: Tue, 11 Jun 2024 11:32:03 +0800
Message-Id: <20240611033203.54845-1-kerneljasonxing@gmail.com>
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
which should also be limited in netdev_uses_bql(). Let me give it a
try first.

I decided to introduce a NO_BQL bit because:
1) it can help us limit virtio-net driver for now.
2) if we found another non-BQL driver, we can take it into account.
3) we can replace all the driver meeting those two statements in
netdev_uses_bql() in future.

For now, I would like to make the first step to use this new bit for dqs
use instead of replacing/applying all the non-BQL drivers in one go.

As Jakub said, "netdev_uses_bql() is best effort", I think, we can add
new non-BQL drivers as soon as we find one.

After this patch, there is no byte_queue_limits directory in virtio-net
driver.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20240609131732.73156-1-kerneljasonxing@gmail.com/
1. chose to add the new bit into enum netdev_priv_flags() instead of
breaking the room of device feature.
---
 drivers/net/virtio_net.c  | 2 +-
 include/linux/netdevice.h | 4 ++++
 net/core/net-sysfs.c      | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..728f4b9844cc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5631,7 +5631,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	/* Set up network device as normal. */
 	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE |
-			   IFF_TX_SKB_NO_LINEAR;
+			   IFF_TX_SKB_NO_LINEAR | IFF_NO_BQL;
 	dev->netdev_ops = &virtnet_netdev;
 	dev->stat_ops = &virtnet_stat_ops;
 	dev->features = NETIF_F_HIGHDMA;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..6d379858d11f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1649,6 +1649,9 @@ struct net_device_ops {
  * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
  *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
+ * @IFF_NO_BQL: driver doesn't use BQL for flow control for now. It's used
+ *	to check if we should create byte_queue_limits directory in dqs
+ *	(see netdev_uses_bql())
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1685,6 +1688,7 @@ enum netdev_priv_flags {
 	IFF_TX_SKB_NO_LINEAR		= BIT_ULL(31),
 	IFF_CHANGE_PROTO_DOWN		= BIT_ULL(32),
 	IFF_SEE_ALL_HWTSTAMP_REQUESTS	= BIT_ULL(33),
+	IFF_NO_BQL			= BIT_ULL(34),
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 4c27a360c294..7d99fbbad6af 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1765,7 +1765,7 @@ static const struct kobj_type netdev_queue_ktype = {
 static bool netdev_uses_bql(const struct net_device *dev)
 {
 	if (dev->features & NETIF_F_LLTX ||
-	    dev->priv_flags & IFF_NO_QUEUE)
+	    dev->priv_flags & (IFF_NO_QUEUE | IFF_NO_BQL))
 		return false;
 
 	return IS_ENABLED(CONFIG_BQL);
-- 
2.37.3


