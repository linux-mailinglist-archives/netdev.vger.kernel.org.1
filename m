Return-Path: <netdev+bounces-235528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F9C320FE
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947634FA585
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F88331A77;
	Tue,  4 Nov 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIQxwXLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51125228D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273674; cv=none; b=E4lz9jCS+Msh/FpSX8tRhOmsFzgtX1tLX+KTWUHF16H/SmRfsK8uOr68/67CFH6Zbs+2fBT9i4GP6UgpfjsciVMmc4RJk9QtMQsXWQuubrdMyOvfPSUleZTZZgE5WeMmeQ33SYYqB7beoCfkiGs5Ago4uKeudPr1FqMDBJaml0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273674; c=relaxed/simple;
	bh=Iayg8NfZD5P8SOlhFmx2l5GOCKjidJK2z3fPfNqfG/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhc45hSoZTrQzXyJeOAVvfMcYfLr+mFPYLs4aDUW4XH7tVaea3MFVkpCPpsVuar8Ya6gHRSpKqvgidJAbYJHDemvxLouxSuguQMWfLy+IbwFHbC6kCY02CAbWePMf3M/VqW0Teo8zkBBMWrCGPoHKHmyOMG/0fM1qqGNNC7faq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIQxwXLH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295ceaf8dacso22365105ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 08:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762273672; x=1762878472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVQvxU3MtJVRDiiE8O+W/LOs2kVr8LBYlBC4MjCsxUQ=;
        b=BIQxwXLHjD6IwwIVs5NgzVhvLxz1g8zHJps6/koWDz1Pj+WaOu3Z6ntlV1Q6rOgwT3
         B7gtQFjkE9JIdMG95hVH3XhTrYXtM9V6tZ/wMsKgJdgZTyu4AnbTtcDOFEYJnKhkQ+Ep
         B8DzhsLFeQwWTy4uad1pAjJNuQ0rhqDw+t15x0TzgYDmt+PYfEbHZTXqtTxgvXloyVOE
         m1tfYHHGtCQZ6kwiPCFUuTnMNPeXyTQnG1OgOLLtFlbGgTT8J7FeS95mTSbchtjKNMa2
         uiiJnkn2IMLYm/ZBJak0x3DuECeP75M9e2QTvWtWtoijaa2EhDXU/RRej+/fla1UjvzE
         1Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273672; x=1762878472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVQvxU3MtJVRDiiE8O+W/LOs2kVr8LBYlBC4MjCsxUQ=;
        b=c3Fjj3VEZg745MpCdHwv8yZobayQIwqbbKB7skHJK0oOoFRwktLQaKCfySCXgZKCw0
         QpKJ88tiOB/71Jh4+opeP3BH3yT3/8MfVJOjOKdOciedCtu/zfeWxnJfcNCyuGvjI5gB
         K5p7Q/qR/2GcDI+c8JeLtVLOKe6lVFOurmXFq1uHsKAMQvUsj5Om04ZMFQOF/5tUocA2
         NoYKDFHY90ikCyr5gcqvuY+CbZjt744B9qPVPDfWhsOxHM/BwBneOuQWOp0lkXRhZZyZ
         7eHUMjCR6Ae0fBHW6ohUWsZB2RpxhIvP8KoWKw9DjPMyGXTv38R5fC4c2NZHBWW9ipRd
         buXw==
X-Gm-Message-State: AOJu0YwfxYJ6JUEDDrd62HSxPAOvGD0Oiylao2Wg4bj2xTfQN3r6z9eh
	BUDuEHKF05XKKTO6C6HGzK4g3WMlyIE+lAezBtBS5rO7wN3M15++FIaY3+TdTSwVIUg=
X-Gm-Gg: ASbGncuYoY2mNGFKlqDYO9B6Y1m/StctZfoHnFJ88Cxt+yOMICgh3V8Z1YXyBxw6GaH
	vJOQe6jX8xEoZF2oqJ/cGc8oGT1kXGGyZpjCf/4L3OF4js/3ytvd+xCwc9Q10Lz4rVxFl/yCsgz
	7HLvT1AwyZK+wZPglooPc/myS81j8sPcdWKrx7uAMmHFWyjsbnV5VulW3Pw10Jxuf5VGOlZ3eaH
	2cA3OsGfAXBdH91OqHtdylfhhDVxhJklAFoGpArYwh7l2BocFKly+/37zJPCnH8H9N2G6g+tcBL
	ydhtbkfCwEJEwcCtqOe52aClWlnEHHQ5bVrmT4dmJnzanTHtXa0VTOKqHOt9UtfKooy6IZZZNnl
	M96Itp1+x+g2bfLCtRbsJ7U6/P2lE4vUFaVInK8FtaOMjsQZNfWddyMcKaP/mBD5/4fy/IxZ6iD
	yFVQALUoUZWupUgmoqluRtvcXaa0BojMeiNQ==
X-Google-Smtp-Source: AGHT+IE+tm1Pucm5/HGHWovZCnFRu/Y24vGAaw/VJW9NpEiTU4uV1PLWEQs8K0DVb5/KKD1CgTDVoA==
X-Received: by 2002:a17:903:2346:b0:295:7806:1d64 with SMTP id d9443c01a7336-2962ad3f167mr2644105ad.25.1762273672106;
        Tue, 04 Nov 2025 08:27:52 -0800 (PST)
Received: from localhost.localdomain ([157.51.49.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d181sm32380845ad.85.2025.11.04.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:27:51 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN uninit-value in rtl8150_open
Date: Tue,  4 Nov 2025 16:27:16 +0000
Message-ID: <20251104162717.17785-1-dharanitharan725@gmail.com>
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

Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/net/usb/rtl8150.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 278e6cb6f4d9..f1a868f0032e 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -719,14 +719,15 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 
 static void set_carrier(struct net_device *netdev)
 {
-	rtl8150_t *dev = netdev_priv(netdev);
-	short tmp;
+    rtl8150_t *dev = netdev_priv(netdev);
+    short tmp;
 
-	get_registers(dev, CSCR, 2, &tmp);
-	if (tmp & CSCR_LINK_STATUS)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
+    /* Only use tmp if get_registers() succeeds */
+    if (!get_registers(dev, CSCR, 2, &tmp) &&
+        (tmp & CSCR_LINK_STATUS))
+        netif_carrier_on(netdev);
+    else
+        netif_carrier_off(netdev);
 }
 
 static int rtl8150_open(struct net_device *netdev)
@@ -741,6 +742,10 @@ static int rtl8150_open(struct net_device *netdev)
 
 	set_registers(dev, IDR, 6, netdev->dev_addr);
 
+	/* Fix: initialize memory before using it (KMSAN uninit-value) */
+	memset(dev->rx_skb->data, 0, RTL8150_MTU);
+	memset(dev->intr_buff, 0, INTBUFSIZE);
+
 	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
 		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
 	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
@@ -749,6 +754,7 @@ static int rtl8150_open(struct net_device *netdev)
 		dev_warn(&netdev->dev, "rx_urb submit failed: %d\n", res);
 		return res;
 	}
+
 	usb_fill_int_urb(dev->intr_urb, dev->udev, usb_rcvintpipe(dev->udev, 3),
 		     dev->intr_buff, INTBUFSIZE, intr_callback,
 		     dev, dev->intr_interval);
@@ -759,6 +765,7 @@ static int rtl8150_open(struct net_device *netdev)
 		usb_kill_urb(dev->rx_urb);
 		return res;
 	}
+
 	enable_net_traffic(dev);
 	set_carrier(netdev);
 	netif_start_queue(netdev);
-- 
2.43.0


