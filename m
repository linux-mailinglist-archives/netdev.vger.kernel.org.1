Return-Path: <netdev+bounces-148389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7909E1444
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE74167449
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138791DB54C;
	Tue,  3 Dec 2024 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="C3Xzh+5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986019CC3A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211077; cv=none; b=JeFxPg4Nrbilj0UWaj3uUw4bURoa5WUSGOmiDVd3ROEhaliMoyKeBvIRR6xwlJb1U7Nawwm/+SFbABDUB7eY5t/Wy3j57x8+62jvBSSeo9L/hjtRznj9tNodvtZLSglWE2W2mZd3Lv0E2ZGuB36+O44eQ6LFE1DwVBY9nCwwUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211077; c=relaxed/simple;
	bh=Hk5ke9nzypkJaxk8bCoKEHSofdwMIA0X2l10CVp/tS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8/ZyxvIppFPKDw65aqwrHRc1OdYa9Gkn2UD701aw3RoViJlEMvEdlpsRRuG6LzRgT01vfeucvm2O10doytKWL//ODBRTWY+F14+JFTEjRnDEbSaCWvwuBYDiC9SxIhS/SbuSDe1yVGQNdYkP81ARsXE8q+AY+Jo9qcCPxw8r7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=C3Xzh+5c; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 351AA3F84C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211073;
	bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=C3Xzh+5cpzLeAi6lG7ybJMSWsp5dzoQkCzf849O+aduNhIk2dM5EFSvI3fSumTC6D
	 I7+Ym/Z9xKubRQbT5hGSgzVvOVTndqqbh+CpnOSu2R8f/V0O9o+E5+kNhoC4vjXm9N
	 k5WeYn5iYmOZzN72l50Lz4fDwyb637xf1RlQoD5nPcXLn1NpnSHTzC6nRzaoWeBVBw
	 mF2we6PCvdR0nJAUoK3Hy3cKYQohxIssz8vz7MXqxHxFuoTpcUewN24z1iq7hd31Bx
	 aLUmfMd0kFDPZ8GwqjNtuivX6InY7VyBdbyQxQEh4jXItSo5XSOsT+4k+Ck8baJsyl
	 K/BPuc+yzf9pA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7250863ae6dso5077904b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 23:31:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211071; x=1733815871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP1rcV8yFT6KeAKHqqLHhUue0tX/F8YDnxUvKh8M2mo=;
        b=mgT9yoh6Xwy1s77FYJYoOcWnldUjvkbB8UZsKNXKUOE4ZSS8diUOByJgdMdp7FBRRr
         0UvchHdj9oiU25CMKZt367YRhTJCOvUTjcxO+SukjvBQBV/ycGNOo/rFj0tF4k+8GZQZ
         VElPI5xqvZ2G0q4avDzY4t2c3AFBfJfPRpYm20lrYh5c7BQwi8Hd2pNA2J88SXQilmI/
         5j3nE4DLHB5JHB1g+fWPRCogEPEMoM0v93Yq34vFu/bJexuuebI8lyqVK7DQcHkLUhce
         odkpxpJFMAQcgQTyM4eyTF072tnakQRsJyj4xNTPga3L87D3hvlQAMx7mVLodtW/erY2
         Ov/A==
X-Forwarded-Encrypted: i=1; AJvYcCUtOCW1OqbjnH2kBMqgUAVaxUT0f7raunLb7f6lMQtrnHwcpO73zxrueUgu1y1T0ysWwMB4GRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC09MfN7Miuh+nhWRTc/YvNuOwxMwyMpU+BnZOA0PJ1vpqFBbL
	1pEeMHfPP7ctaaxgkLMnfRtQ9zlaEEtEX8q0nhk/vAEuVe5Fx6cyfFAahRCISRm+OFBFKJv2UoX
	BVjaOr0O+qWpYl78Iy9gMyZzjXFe2nbcBJfyRVysyThP6jDxYw+r50SDQ7xLhRNluhetIhQ==
X-Gm-Gg: ASbGncuZdH7NI8DSlPG7vZHF8jRhkNGDxo9MWiPOYmmpPgzjoPc/qT0z8TPEmZ99Opk
	Rlz6rwpsRetxd4/sGtKdmcNjq/TUMh+0IlXeuvFk1hoborZtGut5B5JrEXN5lc9ydcGHWQy5WJK
	mIpZ2nGfVg4hs74t0V2VlJ408duMI3dS4/w5lJDVBY4vA95YMGnaxzsUZY6uitpC1xAVhayFTDM
	2upHKQLUtZq60uNUmedJZz8dCk2ZJGp1ChXoTBySrwN4Ryh2R5Ys84CFI34G5ol7d1s
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393885ad.15.1733211070592;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEND0UzhbAQRYul9CwlhlE8NsG8OZop+RaB8RyNyzhSiQjfU17kWK9qXqZeOdr2+snjte5ZcQ==
X-Received: by 2002:a17:902:e88b:b0:215:6816:6333 with SMTP id d9443c01a7336-215bd1c4a4cmr18393625ad.15.1733211070289;
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:10 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 5/5] virtio_net: add missing netdev_tx_reset_queue to virtnet_sq_bind_xsk_pool()
Date: Tue,  3 Dec 2024 16:30:25 +0900
Message-ID: <20241203073025.67065-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d5240a03b7d6..27d58fb47b07 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5749,6 +5749,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
 	}
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	sq->xsk_pool = pool;
 
-- 
2.43.0


