Return-Path: <netdev+bounces-141441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B647B9BAED7
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 414D4B22F5F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BE81B0F26;
	Mon,  4 Nov 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NDKidl4S"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527871ADFED;
	Mon,  4 Nov 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710636; cv=none; b=qobO7u1AM2j4E8qO6WyRQ77wszc2uFOSneVnDUZLKPw9dab4dKgD1+XZY2Uc73DA4/f+SeStLjemD9YRFHCh91xIIm1/8yor+egeQ73LIkzueG94FwFMXUWk9FR+O9x1ougGrnyfYeGxBAzddlNzegnrihuXZ7jN2Eny3rPVmic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710636; c=relaxed/simple;
	bh=H6yHwJnr5I9WACLPbA2nIDJeFDG5RYB1kTlYYEzwjr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkcE1yDgPnYN43GYu6NPFJztaDWw5Jwk9vdHlxG4f44s5HMvozyVZImNTMMB1afp8gGsdSeWKIlx35La0ivzeU4RuGeLrFneya6rdT5q+Kr0gW08gM0dYeAiRB+sUKdsFMbBLZjA9ldLdWIS8XyWiv6pubEujuUyyzuMuusFFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NDKidl4S; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710631; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j4q+2xl5QIuovJmp0bbeDKW+/xZT6XbC8TzvWc9Gvvo=;
	b=NDKidl4S+bRT5N/0Cd0Njt5z/cOGTWx153OTNy50lakuFLJtuCZiRYlLvt2oBeJ0lijEyqrltzHiUATt7Q06/CIxvmgbcFwWTv/1xl3x08HX4qrbQK/XttTjSgXSJFo+EbAcztq/itOViiNw86OaBHhOYiY+68ujqSFOgA9FXaE=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIdoIel_1730710629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:57:10 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@daynix.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] virtio_net: Sync rss config to device when virtnet_probe
Date: Mon,  4 Nov 2024 16:57:05 +0800
Message-Id: <20241104085706.13872-4-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241104085706.13872-1-lulie@linux.alibaba.com>
References: <20241104085706.13872-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During virtnet_probe, default rss configuration is initialized, but was
not committed to the device. This patch fix this by sending rss command
after device ready in virtnet_probe. Otherwise, the actual rss
configuration used by device can be different with that read by user
from driver, which may confuse the user.

If the command committing fails, driver rss will be disabled.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index acc3e5dc112e..59d9fdf562e0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6584,6 +6584,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	if (vi->has_rss || vi->has_rss_hash_report) {
+		if (!virtnet_commit_rss_command(vi)) {
+			dev_warn(&vdev->dev, "RSS disabled because committing failed.\n");
+			dev->hw_features &= ~NETIF_F_RXHASH;
+			vi->has_rss_hash_report = false;
+			vi->has_rss = false;
+		}
+	}
+
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
-- 
2.32.0.3.g01195cf9f


