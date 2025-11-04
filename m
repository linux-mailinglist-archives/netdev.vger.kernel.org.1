Return-Path: <netdev+bounces-235532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C66C32215
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B23BD30D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA033372E;
	Tue,  4 Nov 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOBqWljJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2E280023
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274952; cv=none; b=pIKT/SYuO19WdcLeAPnpDSKGzkbHHpQ7SVZwJar1eEgveYjeuT8axVtORoR+balDm3yGZCgL8QjQiQUy2gMlWi2l2O8c0eEA2xrZk1i9Oc3t8wcByl0De8zGILk3vv74/AY3nloMcaWHXaO/3QdPaxqaEBZ2dytnxaH+XsEFlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274952; c=relaxed/simple;
	bh=Iayg8NfZD5P8SOlhFmx2l5GOCKjidJK2z3fPfNqfG/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUS3jjL+6XErxi4ytYEEawAbyMngf8ZlzYcGDYdpgDzLd/pvlemhRkdKTPOudTjavOLevc4232LB4ssjxum4yHHlCo88luPmbLAf42/ZEfbdMe6ExN9crFN5zvlkpBustOv09gCSsHV5Kv/J+sn1HRuiXJgApD8ytFyaB2VuURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOBqWljJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7110334b3a.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274950; x=1762879750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVQvxU3MtJVRDiiE8O+W/LOs2kVr8LBYlBC4MjCsxUQ=;
        b=bOBqWljJ4/h6wgp4rGUnlsx3R5ZkihhbF/E+8jpnXFWrbrqMfb6CrpAjc4soBZkcZJ
         RLKkTxzKCrj63IxOgY4+2jqiR2XbcFdom18PDrMPcxPtknCHDYGmSqHi6qJdpJK/pTnw
         A5+8HUFaUV7ivz46wZD6e4yq3HQ1kNlPU3RfhfC0oYbe7g/KYHD26J7o6cVkFZFxPzng
         N53cB50/mHx2ZX9jFvrWFrWws+zG91d/F768jbGgKt8vT2wYrjLdP5v9SnJdl6YgS8nw
         ontWbsdrvacg9TZR8jZc+KKFu90Rc83QCQIS6bg2sEid11a7ZrMz5gtfD50FyXqwKABn
         ebqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274950; x=1762879750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVQvxU3MtJVRDiiE8O+W/LOs2kVr8LBYlBC4MjCsxUQ=;
        b=XZE/SPiDx774BMnOtB9M8yI8k+czP1U1RgsNE2V4v+EDFEOaZlUEc9yQzc2OFded1L
         7AZqy++tw6YLerary56MhUqyB4gvwhUbbu4Dav22G3CTdAPnytYxmETlpnXbU4JOgsYr
         7kf5IuE6Q0rybR6/ZWo+w2wOaDKZQ3XcLKLz5i200OmTw2RAYT3VzBklBYl8mzf4yj8R
         s+Wp9oaPCBa21Z+yyyU9trIg5YYnytZh4n/4dUBjGQd6pHaBXRJFVYDNCqQplMFXdqnF
         DVrU8wq3gia7VRLoYC/7QOfnkQnObAzU5FM+M+hiNJKdLBoJFOosTE3RbTh6BpkX2IAU
         uWhg==
X-Gm-Message-State: AOJu0YwSLER3sQ2xNp90PohevyAKzuZhFYHlCF/cg31Q811liitLups7
	212b41s7Tq1gl5nHrC2QPDpqvs7ZXH1mCeB1KBZbMvk8ftYE2qAKa6Kw29eNFH+OUpY=
X-Gm-Gg: ASbGncu7HrM4C8hgEZUqSWpnvlSZBwX/8LMTlrRtLnmAySZ2Zf8I1wbyFVqih+RTmWI
	OBa6a3ymAXV+GqiyJk8fHGkHfiF85dGtnuOn0Rq/kw3NaiTUxTIRXL9KleTWgk3P2t2bnt1JtR8
	7EvOKlyOx2BWVvVlj48k1WUo9uwYKHL8HNX6XuWjBYt0Ph22mUqDhqadVvCQitu3mJD4gKINZQ5
	Pp/kisTOjuuirRihoHEIFxGASeRGh2XvlLQAGmCPCMsIIcHHn9jHrg1oRJ5M77g6eeaux06RQ5S
	YHfnIGvmvNtv3Te6tFc6yMIduyH23Ag5dVzHJ0SJ+SV3UktWdi36wQYxzkfrDBTyvdcQ4mA5N95
	ek2W3GAGs/ZPyN5a2zmBQUqGropoBCwvF7t1rsTUBf50FjuS4QQQ+zvBYWrklMQBD3mvmrBoKG3
	3HfWDjascH6LeVmViFqEQaSvQ=
X-Google-Smtp-Source: AGHT+IG8EtSNccEfEHoN5wPq1nif+fDSJNpx9FhAwF6GN3xbTpgq1XKsfZyuQ7gXmi1x7mHezjbmJQ==
X-Received: by 2002:a05:6a00:3d10:b0:7aa:bc48:abbb with SMTP id d2e1a72fcca58-7aabc57f860mr10347708b3a.3.1762274949789;
        Tue, 04 Nov 2025 08:49:09 -0800 (PST)
Received: from localhost.localdomain ([157.51.50.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd38299b8sm3508686b3a.20.2025.11.04.08.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:49:09 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzbot+b4d5d8faea6996fd55e3@syzkaller.appspotmail.com,
	Dharanitharan R <dharanitharan725@gmail.com>,
	syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
Subject: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN uninit-value in rtl8150_open
Date: Tue,  4 Nov 2025 16:48:37 +0000
Message-ID: <20251104164838.17846-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202508272322.b4d5d8faea6996fd@syzkaller.appspotmail.com>
References: <202508272322.b4d5d8faea6996fd@syzkaller.appspotmail.com>
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


