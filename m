Return-Path: <netdev+bounces-175661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF14FA6708F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A411899642
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FE1E51F9;
	Tue, 18 Mar 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="oXLIOhHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919C20969A
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291843; cv=none; b=oPncv2s5G3CjjBAE0rapvxHxdbogim11cwR/0lQBilZk7ACC+ZVDJkJEmK9hAB6On3ShShaOXM5XIK4WR15j/lDtFloR4uppTzwfk0oQxmLoyaJPsRX1fWzgBzSox2ObIads+vpQwoCmqWMMrOJo22PzjaoReIUWIemb+2p0B14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291843; c=relaxed/simple;
	bh=PTPRleizS1Yo/Zj2lCHknRUrDScXS7LpuAGSZt5GrG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bff/+1zX1RRLHV7q6fY8xi1oaFZjyfp0QfsTCcSFLMLyfynJdCRDvFupEAyc7HlO5dGnR8ke2KYlYVY2U9NkraPoGAqFyhL3WWJUKi37ZVQqE/2vligoo3AIYfnC2abETyL4BZY65RhbPkjU/xxyu0DzCcj6xOQcRDZiWB9IbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=oXLIOhHA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2241053582dso2594385ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291840; x=1742896640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=oXLIOhHAhV10Z2A570QWtBlOh7NEPNDR9tLgewiBfnLklZBhn56079pbqUAsBCuIif
         wHvc7bHlPoSYzgOjJUbIrFeWpozstExJZjVE0pe47dYPgu2OfaDeBm12i3r2KPCDN+UT
         JU2bVcqNvc5XRyliWGntIdVNpq6qlvNVCNfO5j/7kDCJdlksyWCR5chnDgmQKl2QkZ7F
         8WBqX1W3KOXORw0h0xE1YZiiYc5Mk2KfbGNl1AmAs/dcFaV03uspdjCDuZCtaqoSv6mE
         M1GpKNp2mI2huLCMX9HFITIz4+MbbKnTUrMblvI+SF4dyQt3WzRfkrfQioIsQJN3MhGQ
         +mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291840; x=1742896640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp+TkaR3KA/C/LJhQd39jSgt/1NvtxrTDAfmjY+x69o=;
        b=hI+dOqF+XZJkM1qdjET+atYUr4KqOPKvsBpsLQX+YT8hrXsMhRPY6nAWNHnAuTHTLs
         nJUafqP4h80UEMgU68ZXX2swzjzFmdg/qjO5NG7I9kIdh4ayv2xrpQIUVq2sOY4i+ylk
         VPvlAHYFcqhggw2g5YZftNuzPd3570YtJV+64eil56+IdUKzjZ9EmWJbrXN/hpGQ0wlk
         eFeupREOl49WiRxybFxf501pkrM1sMRNRNprd8qzlNsohL50e0d+KuAs36IqfWs82OsQ
         mFHb/YLD5Q/DIbN2zHE0XaSQqLvFz7udVHzBa9X7GPRE+c+2VstsJfAfFg+HC3w9U3sQ
         vx8w==
X-Forwarded-Encrypted: i=1; AJvYcCUDP+DsblskxR8zOj0Iedxsz8wWhbrQvZKIiHQubXjlyX29XjZt2lWnldJlRHOWmymHR8f+xWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5Zdb+kv6I7iR9sPywMPn3HVVHDvQ1ghfux8fa3Q3JV0NbYgB
	tsKZWiw1Bx+QpD1sMtzuBvPDFF3Xi0bnDSSHYLDw+z0tvUvo1x4O2nFP75AFa8A=
X-Gm-Gg: ASbGnctMngIrBv6GpJqF2j95TX+FjK4vdEEvqkAuXlJv7rvm46E2EG0osWl22R2dLAU
	MzjyGySxNo5TebXmo78Yr7G8zyOWRs8xihNIiqdX+hVp3ofm/k3i/+hNiiyS8xaa91kizYqfzH+
	NzwijHXKNe/F0l7d7zvzqsZi2bYHjjoHsXhWYEGg6uxrSKGigO+v19UmzVar5FOxCAaO9kb3wf4
	LiBdK/+dfzmAFUOPh8fbHNk7y/OAKeqXX8Nmg8bbvL62ERBGX2avwJ9fpl/NpUEXy75h+5FgCB/
	J+K3ay6pUUL21Xt+IEI5ZotN12VS3HI/WxaPbDBUYuCTM+DQ
X-Google-Smtp-Source: AGHT+IEau+wjrdRHJMlS5nyOT1rvXp0wuHKf/Prbu5sQ6Jh/4b7CF8c7TS8qmvF6EWe5N8kKungcAQ==
X-Received: by 2002:a05:6a00:b91:b0:736:42a8:a742 with SMTP id d2e1a72fcca58-737223b9098mr15931032b3a.11.1742291840607;
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737116b0ec4sm9074760b3a.159.2025.03.18.02.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:54 +0900
Subject: [PATCH net-next 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-4-344caf336ddd@daynix.com>
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

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4153a0a5f278..6cbeba65a4a4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kmalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3591,7 +3591,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			kfree(vi->rss_hdr);
+			devm_kfree(&dev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3599,7 +3599,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		kfree(old_rss_hdr);
+		devm_kfree(&dev->dev, old_rss_hdr);
 		goto succ;
 	}
 
@@ -6702,7 +6702,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	vi->rss_hdr = kmalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kmalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 	if (!vi->rss_hdr) {
 		err = -ENOMEM;
 		goto free;
@@ -6985,8 +6985,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	kfree(vi->rss_hdr);
-
 	free_netdev(vi->dev);
 }
 

-- 
2.48.1


