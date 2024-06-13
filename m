Return-Path: <netdev+bounces-103068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C10906204
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A261C20B0A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519615F860;
	Thu, 13 Jun 2024 02:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZkkqp/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493D1756A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246161; cv=none; b=o1SJKC/KA5DhclEEP/x8yhZAt4mCR05OrBx5veeBkNLvTnsXkZlL2rmayYBhm43ChMRTUU8k4ar0nXd2n/pqn8AZDqQiwan1dn9Fcfqa275jApfDiB9fq7qOcoPmX610hzMHt+wKhDrMlkUc3j8v6ccRCTm/yqQChdsJ8Q5TqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246161; c=relaxed/simple;
	bh=7IvopvrQ856VjPcaL4SjjBBt/o7nGpCjD/nOdnbk1/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYLebDJzplnNYi/ashsNT89/DudmGAk89C8ruPFgBNTnrzGm6GkenYY+7Tzf91wHmqfK/88NzmYm0HOgk7DVuhwR+MP6fzqM2QZgnxZUazFS6kCXn9zdxOKY+hl0jXIY2VcdQ0wAixqA0ymmaIDM9X0eNQIAhz9UOOJWD6CVVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZkkqp/e; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9bbso335709a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718246159; x=1718850959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NsItoW+Rf2vM4YujSHXnlEy8/6JHPe+xopJjssFdL1I=;
        b=QZkkqp/eikT+ig2FRqrAukaoYOBGFZPAVZevuCWohcXVh0Y9I8npaWrXMDfi32Peh/
         DUKL8F7Os+3pqIorQSynka0nkkTG71Af3wAXILrVkD8L67360nLv6ekEhMDd+40g03EN
         gWVc4s6gYSmTknlZuZIzqeuBnifggEhzdDa3CLrdMepBmz8OfkRKp37w12Mt5Ky/kd1Z
         XMbrUrhjyfWaaY05R04RV2LVXuyeA//UyS0szamTWyK6ZA+rxDZk1rzMuKGX97u2Uc7O
         1vUaZzo56/T++M4cJXroOP9h6cAUFOtmv6iHCHv7bYXAuvsN5d16Golzyf1Tjkltqj0B
         xYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718246159; x=1718850959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsItoW+Rf2vM4YujSHXnlEy8/6JHPe+xopJjssFdL1I=;
        b=dHqwPftGRdbyqGutLtc/DWv5ZXwX+gsc7WYqBW7GOe3KyBORdm2odRmY3VUOj1ZMvk
         gEz9qBban3aC/yxbl6+bbT0EhlAGM4lJKTI9U1LE8zu4WrL5MAKINeJSHojIahDdizsT
         dKeTlSfVCGQPpLcTngJpMt/5QIbssUobsVWF6B6OKlkNj27+fkEd1hWSZWFB07uipDn9
         iBuNf2bTJI/kTNGyBk0DdPkSxQ3F7ZeNYCic4LaVK3lEwKTh4JjwIo9sWY5CPgNdzugI
         4oJq2rHw2pbPLiIrH9rVFJzjP3ExvgbHBOuxjA0rkvH9dT10ctiNMCYkpSMMKUc2SFYZ
         NQLw==
X-Gm-Message-State: AOJu0YxmI7zfhjeLDBFOhonTKEA8QUG7ieX7Zh4/4J86dhg7x0W50PqA
	ojxUSKEOQHdE8fyn+qUQNF1HyHInmj72dtnAnR3pUwSZmciNnS/t
X-Google-Smtp-Source: AGHT+IEzLgf5Kumdyani9zdfun/JbobTzvd41WL8SNMxxPbY5BlXrOgD7m9LnFemusDWfdb/0Cn/BQ==
X-Received: by 2002:a17:90b:3544:b0:2c2:fab7:38b9 with SMTP id 98e67ed59e1d1-2c4a763df58mr3775123a91.25.1718246159058;
        Wed, 12 Jun 2024 19:35:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c2d58123sm422225a91.10.2024.06.12.19.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 19:35:58 -0700 (PDT)
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
Subject: [PATCH net-next v3] net: dqs: introduce IFF_NO_BQL private flag for non-BQL drivers
Date: Thu, 13 Jun 2024 10:35:49 +0800
Message-Id: <20240613023549.15213-1-kerneljasonxing@gmail.com>
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
v3
Link: https://lore.kernel.org/all/20240611033203.54845-1-kerneljasonxing@gmail.com/
1. revise the comment as suggested by Jakub.

v2
Link: https://lore.kernel.org/all/20240609131732.73156-1-kerneljasonxing@gmail.com/
1. chose to add the new bit into enum netdev_priv_flags() instead of
breaking the room of device feature.
---
 drivers/net/virtio_net.c  | 2 +-
 include/linux/netdevice.h | 3 +++
 net/core/net-sysfs.c      | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

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
index f148a01dd1d1..d371c2b425ca 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1649,6 +1649,8 @@ struct net_device_ops {
  * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
  *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
  *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
+ * @IFF_NO_BQL: driver doesn't support BQL, don't create "byte_queue_limits"
+ *	directories in sysfs.
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1685,6 +1687,7 @@ enum netdev_priv_flags {
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


