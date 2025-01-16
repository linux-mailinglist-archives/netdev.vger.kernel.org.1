Return-Path: <netdev+bounces-158772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3BA132CE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBA16873E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E219644B;
	Thu, 16 Jan 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dw8RHrEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E5192D6B
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006810; cv=none; b=jnaonWE/3FqToMpDKD2AiWevBCuw5hIX53Maea6JvT4QdpY5R2l1NAf5UJMJGEsjiJAHU0rO9UnS3RwPyYP6FStxIxfH54B3gpPmfaYHR/4xXdWXU3a8gyMjlu5806lIFOVpvbFLLtaz45qJCAjxGV8pV9IG3d9wRSng1mI+9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006810; c=relaxed/simple;
	bh=QoUuXeDBulZSbVMdrI5zM6Eg9lCr5hgBtBOzJbP8zEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bSvqQK8klwM8cSbuALtCT4Is21Aq+Lat21U2nDsTsgrFGDoNKqMsf4dFtlNWQgnZX5LFeYo9ocrI2hTzAR3l4YyUE28sUkWDfsfiuHXAn+1fJdBb9HNV7du6IzFbkZ5WUXpqfdpewyAj27yRgDuGV86bG0nYvZdyqGN1una54Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dw8RHrEd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165cb60719so7982205ad.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 21:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006808; x=1737611608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=dw8RHrEdUovecLojkSYU0FDKWuo5lb5WfTa5yS4l8Ukj5oB4lpnP04O2ffPlMrzy8Z
         +WLpiQlIG6aTHxyyK9svYt4wvh0lp5p/W77/gRBM7yYyAKBJPEcA2qkUKfbl5Dh1Mppt
         HIfSkH1OVTGWN4srag4QtRSjF/+7FD/ASS+VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006808; x=1737611608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=r7db/OUMyzcR9p17w1yEFeOZnrEteuBMGSqjBEAwDRHxfUhAxyeVak6sKjIDBxBoeh
         pxEmUmWTB1+1gCwiMn9ZDEKC17ur/l8EhKyBTX/qoMfBftc0AweGAulS7KhTI4IxxV5R
         usqy3uJQiKIqx3lqAKSD64HmmwJJXca0hjwVW3rukJBEPgzILPnM/+7IK4v7HFhtAbBM
         W8hSEudSGXbOtIN9B3fFH8WDXVrhG7Q0pgQmrVlE3+Q4ROyB9Yz9UefaMAs80Q5yHKsE
         wfuiapbbLD8d4JWPbpsY2yIUnMJJufxjRf02FxL+hiZfUvAAkG8FIVdDH0VAnku+64Uo
         ws/g==
X-Gm-Message-State: AOJu0Yy4WQiDTxXhxK3eWTqXz+seV2E/N2Jbh91C7OlAfNGg3jSt4mXz
	mX1SZvaMBEoTM1dmS0itO/O4tO9elGy2yoK4jUOMEo5Bkil32mFn76/eaIWCnoyPaXvcVrKUDml
	3OVfBwyhxu75NNFsa9x2HNe8tKuwDJ9Rr17nJMxXcL0ggiN83CNlG4FJ4c8O1r+PEKGsR5g+cpl
	uJroRUkpXVZlvQ4NqqcoXC3tie5MFJ8v40J/Y=
X-Gm-Gg: ASbGncsJMt/75ZziIc8ceIe3lRwxl+co5qub1KZiaDsrKxBH6jrkmjCOkLYksJKB0M7
	AHanIVgiKqnipNaAJDg6DnImnZ0JfeEbxRZMhfe8WvdD6JkZgMRG7oX1XqWxsNFoq9X/MiaMZJy
	vvpeG4oZdtN4f6NHWG9LtDGDhehm9fnRFqXEKR97XXR//QumbukupUEUimiTtM9Y/Rk4js3QUtx
	96A1nre8i9VG1dyQYgNXjP7sPZGoKn0jppL7Qezr8imnLMpldAAJTSZ8eOVB1Bi
X-Google-Smtp-Source: AGHT+IEJCssTOUws+b72W8uZUvjCTPp85OZ9h1VVGxQI7rHP+zFi1sj5ShlGmZbXcEUCTdHWY7Z3FA==
X-Received: by 2002:a17:902:9a09:b0:21a:8dec:e596 with SMTP id d9443c01a7336-21a8dece7e5mr344365815ad.35.1737006807678;
        Wed, 15 Jan 2025 21:53:27 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:27 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 2/4] virtio_net: Prepare for NAPI to queue mapping
Date: Thu, 16 Jan 2025 05:52:57 +0000
Message-Id: <20250116055302.14308-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slight refactor to prepare the code for NAPI to queue mapping. No
functional changes.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 v2:
   - Previously patch 1 in the v1.
   - Added Reviewed-by and Tested-by tags to commit message. No
     functional changes.

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..cff18c66b54a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_do_enable(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
-- 
2.25.1


