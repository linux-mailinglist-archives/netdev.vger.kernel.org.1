Return-Path: <netdev+bounces-176679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F01A6B4A2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867913B2DB5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BD1EC01F;
	Fri, 21 Mar 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="BJdeg3rK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C81EC018
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539755; cv=none; b=Fx473KUaue138Qgu/SUjZ/oe/Eb2pSJi1znMDvowC3qwBTqRzhIP8PFALqqUVX2f10bPYvlsPQPd33YR81PAjMdsDa9ks+Y95R1fQFgt3Ea2fP5uaRJYomvLcEnLuvdanIL6xi1++fEqFg7dHI1rPqd8Duz+R994MjjSWrdic5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539755; c=relaxed/simple;
	bh=Z2Y9O3eqhn1rvYaihC/gieVlbnv+PDXtqqJuzacNaoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCANo7o7dGt5/d2pVz4QSOxlUPgsyh6YNU4S3yO6O5RdA+fshCMahq3/e35quxfz+i6FWD5w/yR3A+zy/9dnLb7L6q29b8PWjUZjPm/p8MPs/V/ibPvnNcS9RL6Ox90xroeeZ49WWNX7UXaJ3jqKVGpHB4aftWIcYFISMSQN5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=BJdeg3rK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso31582145ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539753; x=1743144553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzn3T+nuCYQGYh/wLolPV7n3f3AMHuiTROhjSuXNiYA=;
        b=BJdeg3rK29RVMXBiH9JwHZYIVUBt82d1/nJUNKg4wKwnntg6nsS6OCBgB5sf07+vhj
         7gLOjUXETStV1HF+LiQTroe8/LFVJ3J4ldiVJk7UyGGlULn5X7MaM6WRErcadDv0cwve
         85TTiaY8afMLKfIigEOql10sM2RbJ+QRxOH2wLwh+hEcDiwqquZXHv+q9nCT+ShLkX2e
         pOhHd5q1DqAytWKzS0Ed4Gdb8NHHL2j+9C5bzpxIcsXgbRAtah/FCOnkCiph/hj8JWGI
         FnMzVDYubDzFULVLnJ9VrS1WZYitHPO7SBFH4l0ktAnQAewwMW1lYKGom4kTcqSTnAqh
         FCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539753; x=1743144553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzn3T+nuCYQGYh/wLolPV7n3f3AMHuiTROhjSuXNiYA=;
        b=tFB2o3a5pyVr4buI52UQuZ5mo0tEH/7sPcCGlfLhm9pk3xG7b6JhFR5mLve0B1LNir
         iS7EFjZSa8n9gblENMaA8XweembI179Ln3IbYIOITSV6OmLNJjC1YqTe/BFvyqHpquye
         kK0HsFq4QruVtdBxRNktzlEl8vvKN9Yk1/+V7vWxzuigHmhDP6E5ZtyXygH3n+KUoI23
         ckaZgFyp/dQmylyXevNeIwQbGFSwTQ4cSxda1z0yhKKFCwJUnoWS/sIQzmxRbbZpJOvR
         pxQ38h083ftxneyN1RCL/iSwjbjMIrTDVgL4kxe6wGX6AUO2cI4VjQR3cmtRZfpscLk8
         oEVA==
X-Forwarded-Encrypted: i=1; AJvYcCVfJnGcq88O5r1V8Bv4GpyAmJ3G99Pd9asPjhsJmQGT16eKjQqUarAlLGUuUMLzOng75ByJZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNvgZv4Hvd9x5ogAtDWSgcV861CU9+2K+VBJnDySddChWzGwa
	y00sSPmNWsT25BBtXGyvmC45HoLG64BGhZdmTv9MC1hMwk9Nhq+YFx8wgv2l+GM=
X-Gm-Gg: ASbGncsU5OP+GHFUCmw7lPxlW5IadQCdz9v+MKbNehq1B2z3gJlIOew7clSJYukgKva
	mTOfUP3tfqiw/pPs60y6G483RMg3nWLGSR8WilNDdX4PEDI+EMAjRyNt0q6H4Cad4zuwddXdPZX
	u01KXKawnkVm+1kzC3mGE7S4YUzAEIr23hK6cjhgCWm6H7XN6uiq+03uB8+l7ZRsO/dNJBwt5Ax
	QqzYb5XS0WMtZ4hTlo1K1+Ncx8cRURTKYBNCQB8fZKeGwlfRpS/JMXun9nCJlB0Hfn6H3aq8PxU
	9mXLSjD70scKdxbDKrbPvuf/2HgtOxkJ5Vix51pQJlXl+vFg
X-Google-Smtp-Source: AGHT+IG8dBmG9jS+xEQ6Ng0OGzGrq0W4LvqVBYyQ/bWMu3It8TGgG3Ug4znLWd6q2IeFKq2SAqukNg==
X-Received: by 2002:a17:902:ec87:b0:216:393b:23d4 with SMTP id d9443c01a7336-22780c68a0fmr31888685ad.11.1742539752424;
        Thu, 20 Mar 2025 23:49:12 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811d9f0dsm9039095ad.165.2025.03.20.23.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:34 +0900
Subject: [PATCH net-next v2 3/4] virtio_net: Use new RSS config structs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-3-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

The new RSS configuration structures allow easily constructing data for
VIRTIO_NET_CTRL_MQ_RSS_CONFIG as they strictly follow the order of data
for the command.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 117 +++++++++++++++++------------------------------
 1 file changed, 43 insertions(+), 74 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d1ed544ba03a..570f77534dfb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -360,24 +360,7 @@ struct receive_queue {
 	struct xdp_buff **xsk_buffs;
 };
 
-/* This structure can contain rss message with maximum settings for indirection table and keysize
- * Note, that default structure that describes RSS configuration virtio_net_rss_config
- * contains same info but can't handle table values.
- * In any case, structure would be passed to virtio hw through sg_buf split by parts
- * because table sizes may be differ according to the device configuration.
- */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-struct virtio_net_ctrl_rss {
-	__le32 hash_types;
-	__le16 indirection_table_mask;
-	__le16 unclassified_queue;
-	__le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
-	__le16 max_tx_vq;
-	u8 hash_key_length;
-	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
-
-	__le16 *indirection_table;
-};
 
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
@@ -421,7 +404,9 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
-	struct virtio_net_ctrl_rss rss;
+	struct virtio_net_rss_config_hdr *rss_hdr;
+	struct virtio_net_rss_config_trailer rss_trailer;
+	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -523,23 +508,16 @@ enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_XSK,
 };
 
-static int rss_indirection_table_alloc(struct virtio_net_ctrl_rss *rss, u16 indir_table_size)
+static size_t virtnet_rss_hdr_size(const struct virtnet_info *vi)
 {
-	if (!indir_table_size) {
-		rss->indirection_table = NULL;
-		return 0;
-	}
+	u16 indir_table_size = vi->has_rss ? vi->rss_indir_table_size : 1;
 
-	rss->indirection_table = kmalloc_array(indir_table_size, sizeof(u16), GFP_KERNEL);
-	if (!rss->indirection_table)
-		return -ENOMEM;
-
-	return 0;
+	return struct_size(vi->rss_hdr, indirection_table, indir_table_size);
 }
 
-static void rss_indirection_table_free(struct virtio_net_ctrl_rss *rss)
+static size_t virtnet_rss_trailer_size(const struct virtnet_info *vi)
 {
-	kfree(rss->indirection_table);
+	return struct_size(&vi->rss_trailer, hash_key_data, vi->rss_key_size);
 }
 
 /* We use the last two bits of the pointer to distinguish the xmit type. */
@@ -3576,15 +3554,16 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
 
 	for (; i < vi->rss_indir_table_size; ++i) {
 		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
-		vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
+		vi->rss_hdr->indirection_table[i] = cpu_to_le16(indir_val);
 	}
-	vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
+	vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
 }
 
 static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
 	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
-	struct virtio_net_ctrl_rss old_rss;
+	struct virtio_net_rss_config_hdr *old_rss_hdr;
+	struct virtio_net_rss_config_trailer old_rss_trailer;
 	struct net_device *dev = vi->dev;
 	struct scatterlist sg;
 
@@ -3599,24 +3578,28 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	 * update (VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET below) and return directly.
 	 */
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
-		memcpy(&old_rss, &vi->rss, sizeof(old_rss));
-		if (rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size)) {
-			vi->rss.indirection_table = old_rss.indirection_table;
+		old_rss_hdr = vi->rss_hdr;
+		old_rss_trailer = vi->rss_trailer;
+		vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		if (!vi->rss_hdr) {
+			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
 		}
 
+		*vi->rss_hdr = *old_rss_hdr;
 		virtnet_rss_update_by_qpairs(vi, queue_pairs);
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			rss_indirection_table_free(&vi->rss);
-			memcpy(&vi->rss, &old_rss, sizeof(old_rss));
+			kfree(vi->rss_hdr);
+			vi->rss_hdr = old_rss_hdr;
+			vi->rss_trailer = old_rss_trailer;
 
 			dev_warn(&dev->dev, "Fail to set num of queue pairs to %d, because committing RSS failed\n",
 				 queue_pairs);
 			return -EINVAL;
 		}
-		rss_indirection_table_free(&old_rss);
+		kfree(old_rss_hdr);
 		goto succ;
 	}
 
@@ -4059,28 +4042,12 @@ static int virtnet_set_ringparam(struct net_device *dev,
 static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 {
 	struct net_device *dev = vi->dev;
-	struct scatterlist sgs[4];
-	unsigned int sg_buf_size;
+	struct scatterlist sgs[2];
 
 	/* prepare sgs */
-	sg_init_table(sgs, 4);
-
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, hash_cfg_reserved);
-	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
-
-	if (vi->has_rss) {
-		sg_buf_size = sizeof(uint16_t) * vi->rss_indir_table_size;
-		sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
-	} else {
-		sg_set_buf(&sgs[1], &vi->rss.hash_cfg_reserved, sizeof(uint16_t));
-	}
-
-	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
-			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
-	sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
-
-	sg_buf_size = vi->rss_key_size;
-	sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
+	sg_init_table(sgs, 2);
+	sg_set_buf(&sgs[0], vi->rss_hdr, virtnet_rss_hdr_size(vi));
+	sg_set_buf(&sgs[1], &vi->rss_trailer, virtnet_rss_trailer_size(vi));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
@@ -4097,17 +4064,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
 {
-	vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_supported);
+	vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_supported);
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
-	vi->rss.indirection_table_mask = vi->rss_indir_table_size
+	vi->rss_hdr->indirection_table_mask = vi->rss_indir_table_size
 						? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
-	vi->rss.unclassified_queue = 0;
+	vi->rss_hdr->unclassified_queue = 0;
 
 	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
 
-	vi->rss.hash_key_length = vi->rss_key_size;
+	vi->rss_trailer.hash_key_length = vi->rss_key_size;
 
-	netdev_rss_key_fill(vi->rss.key, vi->rss_key_size);
+	netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
 }
 
 static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
@@ -4218,7 +4185,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
+		vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -5398,11 +5365,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = le16_to_cpu(vi->rss.indirection_table[i]);
+			rxfh->indir[i] = le16_to_cpu(vi->rss_hdr->indirection_table[i]);
 	}
 
 	if (rxfh->key)
-		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
+		memcpy(rxfh->key, vi->rss_hash_key_data, vi->rss_key_size);
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -5426,7 +5393,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->rss.indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
+			vi->rss_hdr->indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
 		update = true;
 	}
 
@@ -5438,7 +5405,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		if (!vi->has_rss && !vi->has_rss_hash_report)
 			return -EOPNOTSUPP;
 
-		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss_hash_key_data, rxfh->key, vi->rss_key_size);
 		update = true;
 	}
 
@@ -6044,9 +6011,9 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
+			vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		else
-			vi->rss.hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
+			vi->rss_hdr->hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
 
 		if (!virtnet_commit_rss_command(vi))
 			return -EINVAL;
@@ -6735,9 +6702,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	err = rss_indirection_table_alloc(&vi->rss, vi->rss_indir_table_size);
-	if (err)
+	vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	if (!vi->rss_hdr) {
+		err = -ENOMEM;
 		goto free;
+	}
 
 	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
@@ -7016,7 +6985,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	rss_indirection_table_free(&vi->rss);
+	kfree(vi->rss_hdr);
 
 	free_netdev(vi->dev);
 }

-- 
2.48.1


