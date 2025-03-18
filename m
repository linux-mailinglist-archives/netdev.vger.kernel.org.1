Return-Path: <netdev+bounces-175659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B853BA6708C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689793AA73D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31333207A04;
	Tue, 18 Mar 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fLxEUmBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DE2080CF
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291832; cv=none; b=Osq29db+DOGcnpc37rJN1Lg/xJ7tOArkR55AZm5cfU9Nol7DoqAZBEN54pQrbm00UTZ9QwlBbXBdtlGmzI0wwhnLIim9T7lHXefPLC8Zea3LsFflhOtUbNCCi6mFyuRxtivKDPRI8kZoui16U7np3DQkV7A5TkcpyVbdPgbdw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291832; c=relaxed/simple;
	bh=kvpzrCPZKG6u1vfeN24Aw1Y9W52FSdUnKV0z3nPYKzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9kkB02/mI/YMGnn+mYALNNaHyDiw61M7T6CmcNuweyAzW3fsRFFbk8s5wFQgav6oCzDJUzgDMi0Xnwc1T0J2rLsmEGA+KAZHRbi83d5hvfT7QvIjL+9r2mSOIm5t4AsMG2VQiOGwLoEXB0idmE9xGEt0FHLsy0cS29XROjaUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=fLxEUmBr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22409077c06so134716095ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291830; x=1742896630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKto7h723Ki7kYMKjnEf4R385v5d75BQEmZfS9JmO3c=;
        b=fLxEUmBr+h3tUmGwIdtNmxkXe6zYr6+BzanNT6lvAsuSxCf7//IEN4Njfx7htY6x90
         hem8HCO8zNdjXhBGQ6B5/vT5ZCqqo87Ge3L8ot0jgiszKq0zPvdN3TwELLkThKNllLnN
         Qj5CgCjXnJ6SwQ1YYO18bAwxnBWZO4S07ujKHKgu6CsyYHNEQO+EIYHNoOQlrcu5/jOe
         dm9g6kqImRkgXCjA5OBaOhudJbWKjNpGj4NrclPK4HXxf3nLrc8DoUz0TJWkXsddBJlq
         tbqcWwYYTecWTXwoXbG6wz7RrMD6tklYp+YPwLZoQxRQrlQOmdFmofCo0l6cdsL5+SPU
         SQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291830; x=1742896630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKto7h723Ki7kYMKjnEf4R385v5d75BQEmZfS9JmO3c=;
        b=ubCDk6rXGq83puwaw+6CJpD3Y2P9MMsyS7mc6fja7D9fh+ZJynLaKUlYC/FkHtHFdK
         JtRlLwDjubVx+GFN4xIPAND0Y+xPJmXRj47oy9fzvawrEoTtCh/E7iZUACG8C/In70uV
         6mLhZ8A07zwj2q/h7NieRbNisB/1c5ThPJW7QUWSUMdTlKqxdGNi6ACpB06guZisWND+
         4jPyqhybN8lQyUlGyl/EoZ49yYAa1deUYgrT4GGEXt2hSDskHpA5G2YYkp+t6CXlbgir
         h83jwvOyzWgonBmjKT3TkX0Cg6LVV9PitSS63NdiaXxafJ8gSz1/osk6YZWkrlduVy1f
         yW6A==
X-Forwarded-Encrypted: i=1; AJvYcCXE45MwG0KAS+ALfWbU/roRi9uA4sMj1IVMaE+9vfXW81c9aVCoSYjk340SZMgb6o9gHljPRIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyDpgf3hB55t+tmtbS3GMFOVa+vCNiFlA2FOpisXnPHrFlTg9
	1fUZZhL6wW3n4F7WUxaJ5KF2WK189yDSwbscNpy3qROXlTX8YmNS7FOEQiSH6Dw=
X-Gm-Gg: ASbGnctvKR8XOeSXgoYPQ+TdoW0dsRLlHSH4lF2B6/mHQwzSZmD/biY4MIzlNwQF9Fa
	67S8dlrML0COiZJlAeFu3Ms7go42RdawGK8PHTD8HcjxqUrrw16Iloz/Yn7w7BBOK3timX1J78g
	/E0ByEamd56WTw2thgz2Ouus0SYtz1cp0OCa/12iuORzX/xgFe2xy9xqBNFpxgfaZoO5FeM415A
	VTpEaRgosWG7I1l+ODpHwhD/blv+VWw+7y4bLsWCPl6lnPaJg0Km5xqa3EKo0uEiNJ+3iQ4iqTa
	/HaalbAwOxQJEiiVHQNmjOhj/JqJxAflCsKHnRKjpkx+IsdE
X-Google-Smtp-Source: AGHT+IE2MIs+V39ucomf0brjofhjxyDBLUBR6ChaUUJySbvQir92UJ3hGg5A3YxoOe1UF+ZtBdVpWQ==
X-Received: by 2002:a17:903:2308:b0:224:fa0:36da with SMTP id d9443c01a7336-225e0a537c8mr210649515ad.18.1742291829794;
        Tue, 18 Mar 2025 02:57:09 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6ba6a38sm89927275ad.108.2025.03.18.02.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:52 +0900
Subject: [PATCH net-next 2/4] virtio_net: Fix endian with
 virtio_net_ctrl_rss
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-2-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Mark the fields of struct virtio_net_ctrl_rss as little endian as
they are in struct virtio_net_rss_config, which it follows.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..d1ed544ba03a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -368,15 +368,15 @@ struct receive_queue {
  */
 #define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
 struct virtio_net_ctrl_rss {
-	u32 hash_types;
-	u16 indirection_table_mask;
-	u16 unclassified_queue;
-	u16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
-	u16 max_tx_vq;
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 hash_cfg_reserved; /* for HASH_CONFIG (see virtio_net_hash_config for details) */
+	__le16 max_tx_vq;
 	u8 hash_key_length;
 	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
 
-	u16 *indirection_table;
+	__le16 *indirection_table;
 };
 
 /* Control VQ buffers: protected by the rtnl lock */
@@ -3576,9 +3576,9 @@ static void virtnet_rss_update_by_qpairs(struct virtnet_info *vi, u16 queue_pair
 
 	for (; i < vi->rss_indir_table_size; ++i) {
 		indir_val = ethtool_rxfh_indir_default(i, queue_pairs);
-		vi->rss.indirection_table[i] = indir_val;
+		vi->rss.indirection_table[i] = cpu_to_le16(indir_val);
 	}
-	vi->rss.max_tx_vq = queue_pairs;
+	vi->rss.max_tx_vq = cpu_to_le16(queue_pairs);
 }
 
 static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
@@ -4097,10 +4097,10 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
 {
-	vi->rss.hash_types = vi->rss_hash_types_supported;
+	vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_supported);
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
 	vi->rss.indirection_table_mask = vi->rss_indir_table_size
-						? vi->rss_indir_table_size - 1 : 0;
+						? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
 	vi->rss.unclassified_queue = 0;
 
 	virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
@@ -4218,7 +4218,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->rss.hash_types = vi->rss_hash_types_saved;
+		vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -5398,7 +5398,7 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = vi->rss.indirection_table[i];
+			rxfh->indir[i] = le16_to_cpu(vi->rss.indirection_table[i]);
 	}
 
 	if (rxfh->key)
@@ -5426,7 +5426,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = cpu_to_le16(rxfh->indir[i]);
 		update = true;
 	}
 
@@ -6044,9 +6044,9 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->rss.hash_types = vi->rss_hash_types_saved;
+			vi->rss.hash_types = cpu_to_le32(vi->rss_hash_types_saved);
 		else
-			vi->rss.hash_types = VIRTIO_NET_HASH_REPORT_NONE;
+			vi->rss.hash_types = cpu_to_le32(VIRTIO_NET_HASH_REPORT_NONE);
 
 		if (!virtnet_commit_rss_command(vi))
 			return -EINVAL;

-- 
2.48.1


