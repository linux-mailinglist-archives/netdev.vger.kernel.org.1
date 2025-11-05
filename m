Return-Path: <netdev+bounces-235969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22402C37888
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC601A205AB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6833DECA;
	Wed,  5 Nov 2025 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd6vQHkv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48594276058
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372056; cv=none; b=KP4a7qW6MmtztfXgqUJzdB+K9xXhGqmsrQBC1tCkYHUQ/IAOPHH7yK9atDsFJ9RfYBYLv7N197fUTkBIX+RBXs4lj+K+2p3hPZpq3Agfbq54MAV01TrjVMB3Wm/qHFln2qcTb4haNhXntFYL3vcUVqS21G7I9g6MidILAIO7zVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372056; c=relaxed/simple;
	bh=YNlyk3L+J5C+s+XKkHVgo/Wr2fGJFKUz94e2clMbd50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=na6f3Yo8RF41SbHJRCKk0/ljpgSKbJTTcxv+7bL1Qmib1u0BnySYBHA5Vi1LtWx6jRPtOBtZzaou306x5l7J+E4NHyjturj8UBe2dvIdacfQ45cmdGGM2U18USKYydIDusSZOhmNK2sKEwlx0PDEGVlk1HAD3cGeg2qM1O2qRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd6vQHkv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so240631b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372054; x=1762976854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc0FN+/I3AZzMO/MbuUc282ojIxRA6xlQUdIwWUfgfw=;
        b=Gd6vQHkvFwNpP7I+OfAlz/QvcpAMNSPZJ/UE2k2k7p66pXKS7zBmVQA2oqVUUNXBi1
         tU5jegO9hZ8dXCGUw4L51/UQiUUaVEiHNPSM5/tQ+yKtQV4ANGm7hVoR9MMaxLOpvtHM
         Kxb3aQWoq0qHsxa6l3+539AEit2fjmTItdxwkLOzP2FtGv7m5ADjrDsY0Uc3gQpquq/k
         /OCXIPFy4zxoWz4f8bdG2xNOQl7iOU0xeVzOwjrmfV/OjNPb6UTdjl7dl9deaTZNcM8u
         qrQIw0rOzrN0prJr7eLthN+xshrK730AnzR9modlJ75Gd6TQJlJEzdcRJlGoaLxNsUU9
         FpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372054; x=1762976854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc0FN+/I3AZzMO/MbuUc282ojIxRA6xlQUdIwWUfgfw=;
        b=l+RWQJEvB6ML3va7vFLulb1bYCNRHe1/F70bIbl6M6WxzZDzljGFd0o8NBNFcAAuoA
         QZN4Sc/+bMMm5GxSBGojmZIBlUyy4kW6vdCJveM/YHbabGHkSSwmvbj+qdDBBATEbIov
         TxnyhjCzkaMAci5TgHEJpVsJ+SMcP7c9+C60uruXLh3BJWYZVlA20QyQGkWJeJoj7WoH
         PVVkHg7xxGJnV8Kq/0tLBPA+QRK/banMhlwm+S4KctOYN4/D//n91aaRAGbSqs7KPFPl
         au/YxhH2xkJmVTvH8HfDjkM2a+mgna5u3K8FMT0iOSwAshuXrr1foXXXPYUZGPHVNUTE
         oKhg==
X-Gm-Message-State: AOJu0YzZScUvXVUvEawHqQ+eO80AR3rRowHXieXdQAZw/v0R+fL/NB/x
	5b0dRKrd3Fk/T2vJhPMYqmnJd+c1iVaSj21L7aXxTkOa8/E8K85KOo31Bv4OWecYR4U=
X-Gm-Gg: ASbGnctqNF+nCjb/a9qUu9jIUqTHwRb6ueJ1eh4aT4FIstawr1Vutd61ZcvSUJJSpfI
	zm7gzkoI00b0FXf6Y6EgufFXNOu83EZ6rQXinhR7L1QMk8MpPsZQGqBXHjD3sOQ8A90j9Qp0leN
	FHRVfM9In7g9V5j3PwJ+vjoIa7CRNN/SnEgKLGTQ2csT0AfWho1auWR62ssL6I1JEfk1kq2Mbsu
	d3gihODdbQM9Z7bxvPbd32/Pbw0nEXXxudPK/QFagae1H4mD7h8G4XBnwgBJDnhIWDzrahCcCvE
	ZUY8i9Tn/FZtxuPAC6Fix+Mi2PG1+11OuWqxHqfbfeNu7atvCqX6iWcr8cTwUzb/iIHOdoopjHz
	rRT+NjSRehtyoKwMyIKpLFHo0AveT209sjQD5qILCDZwhkZr9PCZuJNFAb5Q/pCPrKdqIPk8NT5
	HYR+HhCqgHgoVS3DPTvnHzA4SZOFqnkbpxKg==
X-Google-Smtp-Source: AGHT+IHJpP9bapYPglMlfmm6IXmUqTnI5kVgW0ucw6cjGqKTOT0Vhmqm015lIYvwtPjQlOKQ2Izyeg==
X-Received: by 2002:a05:6a00:179a:b0:772:6856:e663 with SMTP id d2e1a72fcca58-7af705c8325mr788080b3a.8.1762372054297;
        Wed, 05 Nov 2025 11:47:34 -0800 (PST)
Received: from localhost.localdomain ([157.50.7.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f84fc12sm237777b3a.2.2025.11.05.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:47:33 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH v2] usb: rtl8150: Initialize buffers to fix KMSAN uninit-value in rtl8150_open
Date: Wed,  5 Nov 2025 19:47:05 +0000
Message-ID: <20251105194705.2123-1-dharanitharan725@gmail.com>
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

Changes in v2:
 - Fixed whitespace and indentation (checkpatch clean)
 - Corrected syzbot tag

Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
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


