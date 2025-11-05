Return-Path: <netdev+bounces-235972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978BEC37975
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071D91A21C0F
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423D934405D;
	Wed,  5 Nov 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFA7022b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C5344051
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372617; cv=none; b=HhBbQiisXhL0V0PJfiI2wO2oB9zNjlpH/CxrFOgnrJ1Pq7WhYCh42KBLVFDm3JxTkpf+dodJuoOeiMROx5DDtTSQ13sWVp0hr5u6GQyoEbqnAbz1/dK4bH7NhKEc0SbDiOdDyBqE5LgnBvwE2Wot9KrALDKE+d6r6ekUvr7EXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372617; c=relaxed/simple;
	bh=D9tEbvqucCvXOROJVgc7K0nfkr5nvxlh9U/6ef0alic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fxwG6KJEhFiFB5piBhWJZcKNaqPS7ZUmIF3FdeW+UPbk67F9GnS3g9FElQQWqqWQ8jwgLmaGGddF7PWGHoPjeWn+wnCyUH4ASMup00Wgz3IhXyjp5j6cUImwlIw/4AfVu3Cm7oN2d068gwUmZr3a5cavLKq5LQPjDVCcOBNAKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFA7022b; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2955623e6faso2286455ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372615; x=1762977415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbWTgusNc6BWzyopKKK9VOQsz0h9knpbKQuEH/YbUN8=;
        b=IFA7022bbricJSlq+ek89uPvdT6JrF3oNnk4bl0ODeSuA/atD2KpKiNoxVTP9ajya8
         hB4gB+gRopyZBdUmtgZPHDsVRfiEamYLO9zDZ+2opZVtI8b6qE8aMEmZcr33y33no/JI
         +okD2f/9Nb2jfLNLlOmwJ05Qb3utrod0WiDCgVvUACIQdsQ1YdUSb0pDB6HClwqfvFgF
         a5L0+hU22lZL0C0p+dB+WUnKuf7AEKKqRQKRNZ9EDssYzpQaaMN7UYQv6TEEc+QTvdAQ
         rOIFmQqmol3sRvVS9u9ikLJJSNeqZemPkbXGHvxAlmfbZz1F/D4p+qr0Nr6n2cA0J/6l
         p+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372615; x=1762977415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbWTgusNc6BWzyopKKK9VOQsz0h9knpbKQuEH/YbUN8=;
        b=Q1DtMpLPaKxPPyVuu4XDsa3rN1upvBIKU9aJacYmE0hMOROOCGmkqKKdqJ7q/cxlGD
         YBmIApJcbbvWcwQFoC1RORWebwvFbMK0wxzq97GPJdtW+2HstI1VFZNB33965CBVHeOa
         9HgTIzOmtGkNus+e93gdUGI80hEsThXbIjY0cdAhjecgcBN0/Fvkbs5IYgudKO2+kqi7
         NVs9ym5yaBoevNbPqxA2Hf85oI53INDiaPJCmlzdM0PpWIi0taa+uboakuaSC+mAzhzU
         N26VRk6ZTDyIwFTrmVAa96qwCwwyqMPUmUD0fvqV0Q48vKrcUdA74oVYZYyU4AzyPqLB
         SEDA==
X-Gm-Message-State: AOJu0YwGe34DiiXvOYlpcxkgQxMd2VF5x+oXEB72lTxaLXBVTRphiwNm
	YOF31WpG6z3hCa7mp5BxySB6dla/XqEfzm/3RZiFR9GenP/iopZqhY24PZYcw6js1rI=
X-Gm-Gg: ASbGncsFqyBXmYgLy+PwnkiMtDsrbjkAxZ4E65JG87SmqD92VIRzSMN3Jw1pqhDtuOW
	GHV/vt7EmAHV6WbPwWFXWMrNkFdX8KppxNpm4Hg+pC68umvP4abLXblPK7xQP1UmmPgE97J9Vzf
	8SZSxtAbjLmH4mIrG0bwf9t+NjdKfk0YnlxrCm2OGDHpTGeQS6SR0ddhiPTQXLjoGiwL+K9X5uF
	WuOaOphFf2tuEt+CbDhFLnRmWUinHR23HHI0y/J0J5KSVQdQAx3HtroNBOFIIPVMkxuSVQPg2GL
	pEdmJ/sZ2D5VDaOgKPrB7/wYWMlHQbiVjs4HyKT2NQ7l9NmdtVzUJKCsQOa0gLOuabR8QtevpRY
	Qek41WXxl1RRJCc6wAFRt2w1iTTuCET3E3iz4J02ykI8mk5gouo1CkfUB+8s44zeASIN40smg4v
	Z86JLo7/NaC0zHCjepwPJhDWGOKmpeDFLC3A==
X-Google-Smtp-Source: AGHT+IHy57e0NBAg1bsbOb2A5Etvn+xczr00qIWP9YriyOvktiXQZ2baK8RnEWfoUhGi2UtRTc3uUQ==
X-Received: by 2002:a17:902:e805:b0:27c:56af:88ea with SMTP id d9443c01a7336-2962ae93ffbmr52193145ad.60.1762372614774;
        Wed, 05 Nov 2025 11:56:54 -0800 (PST)
Received: from localhost.localdomain ([157.50.7.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1c86sm3464525ad.91.2025.11.05.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:56:54 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH v3] usb: rtl8150: Initialize buffers to fix KMSAN uninit-value in rtl8150_open
Date: Wed,  5 Nov 2025 19:56:26 +0000
Message-ID: <20251105195626.4285-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported an uninitialized value use in rtl8150_open().
Initialize rx_skb->data and intr_buff before submitting URBs to
ensure memory is in a defined state.

Changes in v3:
 - Fixed whitespace and indentation (checkpatch clean)
 - Corrected syzbot tag
 - Corrected syzbot hash and tag

Reported-by: syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/net/usb/rtl8150.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index f1a868f0032e..a7116d03c3d3 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -735,33 +735,30 @@ static int rtl8150_open(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	int res;
 
-	if (dev->rx_skb == NULL)
-		dev->rx_skb = pull_skb(dev);
-	if (!dev->rx_skb)
-		return -ENOMEM;
-
 	set_registers(dev, IDR, 6, netdev->dev_addr);
 
 	/* Fix: initialize memory before using it (KMSAN uninit-value) */
 	memset(dev->rx_skb->data, 0, RTL8150_MTU);
 	memset(dev->intr_buff, 0, INTBUFSIZE);
 
-	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
-	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
+	usb_fill_bulk_urb(dev->rx_urb, dev->udev,
+			  usb_rcvbulkpipe(dev->udev, 1),
+			  dev->rx_skb->data, RTL8150_MTU,
+			  read_bulk_callback, dev);
+
+	res = usb_submit_urb(dev->rx_urb, GFP_KERNEL);
+	if (res) {
 		dev_warn(&netdev->dev, "rx_urb submit failed: %d\n", res);
 		return res;
 	}
 
-	usb_fill_int_urb(dev->intr_urb, dev->udev, usb_rcvintpipe(dev->udev, 3),
-		     dev->intr_buff, INTBUFSIZE, intr_callback,
-		     dev, dev->intr_interval);
-	if ((res = usb_submit_urb(dev->intr_urb, GFP_KERNEL))) {
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
-		dev_warn(&netdev->dev, "intr_urb submit failed: %d\n", res);
+	usb_fill_int_urb(dev->intr_urb, dev->udev,
+			 usb_rcvintpipe(dev->udev, 3),
+			 dev->intr_buff, INTBUFSIZE,
+			 intr_callback, dev, dev->intr_interval);
+
+	res = usb_submit_urb(dev->intr_urb, GFP_KERNEL);
+	if (res) {
 		usb_kill_urb(dev->rx_urb);
 		return res;
 	}
@@ -769,8 +766,7 @@ static int rtl8150_open(struct net_device *netdev)
 	enable_net_traffic(dev);
 	set_carrier(netdev);
 	netif_start_queue(netdev);
-
-	return res;
+	return 0;
 }
 
 static int rtl8150_close(struct net_device *netdev)
-- 
2.43.0


