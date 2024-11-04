Return-Path: <netdev+bounces-141440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8139BAED0
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D64DB22C2F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7081AF0DE;
	Mon,  4 Nov 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hf1Vjy6z"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D51AC426;
	Mon,  4 Nov 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710634; cv=none; b=dh212pa7WFeIu1c7jO9+3Dt5em/3hKOPkHGYMVoUzP5OJt+A2rqQoRzftgBSxZ4Lr4I7ur19eWFLF3hduQ9SjliYgaVxbXJyW95KGnPGwJp+v3WM0n5TiU2xilOT/UgqePsD/oNOpSPk2l7uwvEW66BHPhVgMQC3chE7wRzaFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710634; c=relaxed/simple;
	bh=H+Kb/WkAETIdc84OuTGYc48oTSovUvu0YJ3duL228nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLaBd1jUedXx0hRVbEfhLT8Lvy6OMNkN6IzwAwL8lTVOwfa/6cUvVaN6wUz+9kp0tueaBj2VGoWp33Z50fl4LGz74CQHdS8aFeOQMnxGIKx7hvZEdjOnLVQ1o13Jjwrawh23Mhc3BGCNdfnxIVLzNvYyCZGCIkkoL6DKshjCUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hf1Vjy6z; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710629; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=S6xipXYqiw2sk5/DhjvVsqYQcmoqyDDYvIqZsy7wfSA=;
	b=Hf1Vjy6ziJUTanUVv4g5jLUIoDRrCVUt1YpXoX9WxrFxqLB+GXMIhk461Ps/Q0zLLMKrSB/hMc1gtAkJD0pGZpyKmEB4fYjcoimzfD4sWlA04UKlFBfOXOmpeOlpSWxi9BCSWNKzMbdtAIbkX10Cr2snhNOtzKZlBnLklP15CrM=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIdoIeF_1730710628 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:57:09 +0800
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
Subject: [PATCH net 2/4] virtio_net: Add hash_key_length check
Date: Mon,  4 Nov 2024 16:57:04 +0800
Message-Id: <20241104085706.13872-3-lulie@linux.alibaba.com>
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

Add hash_key_length check in virtnet_probe() to avoid possible out of
bound errors when setting/reading the hash key.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 75c1ff4efd13..acc3e5dc112e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6451,6 +6451,12 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
+		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
+			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds the limit %u.\n",
+				vi->rss_key_size, VIRTIO_NET_RSS_MAX_KEY_SIZE);
+			err = -EINVAL;
+			goto free;
+		}
 
 		vi->rss_hash_types_supported =
 		    virtio_cread32(vdev, offsetof(struct virtio_net_config, supported_hash_types));
-- 
2.32.0.3.g01195cf9f


