Return-Path: <netdev+bounces-173963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A02A5CA48
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA607AE3F7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC6225FA32;
	Tue, 11 Mar 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN6FhU9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB725E825;
	Tue, 11 Mar 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709203; cv=none; b=tRdkfYfyaQc/o+yxb35ug0m9eLRM+SU951sw/YXT33o7aWYuhB/pdhfJ5ORsj4g36LVx8HiRqn1xDR/7m62+SOaG/4YOfGF2dXNZiMa4ER+Emu3RHFmaVgakUwx11E5oZdlWD8l6oLf4Tsf8MAY/kdVQl8vhZyKLytYUntTzz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709203; c=relaxed/simple;
	bh=PycIzShDrvW+MYh47pwMsDglZXLkEXX+gYjlWlgOuo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsn5KUjuDOxmTdP8C4M8dOOClDCzTxPpem2oHaVTwVsWFSA8GzYeCbTTjdvO+QeEtnAE4Uqh8Ebst+6da2Zp1whs3+LegtS0IZ6nyDf09UFpwDVK7oUKdHy0uRuLHr4M/O8+XRO/2hdU5y71ZhClRxyNruWXhzx4cfNKgKxBCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN6FhU9e; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22580c9ee0aso34986595ad.2;
        Tue, 11 Mar 2025 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741709200; x=1742314000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r1TiB2cIwExQKHJgSUFiCJuhIYPtkSlVWWhMfWxdcps=;
        b=hN6FhU9eKBkI1WjtDhXOVPk9RuaBa5U8aEHvGQdwg66zGT6uONfrZPHLhojG8P+eaw
         SOmmh9ciSMhcb2aiGwZHOSK2weWEdhtKFewwvuELGAvzq2wNfOeq0kNnWb9JewkzcTvX
         HXxisF2bOjw0yqfTBE2hLEsMDQLDy5IEbY3gUBcscj9cBFU1DSowA0fvj5KKZ05610TR
         9bDroGWf0qQcWMdeDjv9OjPJ1PB8IjrQq/QIcKGWxAb1Q2nC37RQWCKwwz4HtNKfWuB2
         12wbgpKOOCKCsZuhgnL1ckiwLPJZEDghPPzlA6w/g7md7VefyudjOhlbkJOZ3XqRhEqB
         OvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709200; x=1742314000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1TiB2cIwExQKHJgSUFiCJuhIYPtkSlVWWhMfWxdcps=;
        b=Ld1+r5ebQOLV67vR/tB+04Rx58YMcW0x9llHOQml9jVVAyjW9Ts67+lSHfjmtq2QOH
         6sc+UZYKzhUWhz0v+ZPhcTB0pIq2zPtYVithPZUFKAYFCxYnWy6vvjXk+3mThUCj+5Pm
         V/gbajOduHeC2Fd65kMpSsOg3UMgn3l0Tc5NCRCDGlQGMaw/Y715NEGBQdLz7MqRnhmb
         XQBZuLstJhTjwONFjvTf+P68OZysb+cGQdFvV7RVKIffhLuGQBKetTp80PtB8LFcntND
         vmNP4b+5gSGgNcUuwEQc9SU/vFwJjlR6DV8CqEtNftyOwC/htSvqelFC9yVeWBg7HF/r
         q+fw==
X-Forwarded-Encrypted: i=1; AJvYcCU/4u4yKf3XzYI5HG54yr8/Z0ml3xhgTuzP+7Gz8M88sLAVv5sIvVqwv6M5A37PiucYl8p95BAJ@vger.kernel.org, AJvYcCVYsDwJ4q4U+JFETwCWSGnKYCfGdcEOGajJRbq/Yw8ViD39iglv06OLNdkZaVFbUW9vmjAO4RuEuG4AFQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlYjn4UZezSlPsuglMILc5s+ZbiH2n+Ib+CJOAEK3iK2eMfH+
	ayTNNG9AMzrBei4D9VdsPTjwUCcRFusN5Dx+6hH4AhAlbVS52OCa
X-Gm-Gg: ASbGncsIzuth9FrBGT1AQUYPZE619ha7XRLFAIIOm9fKkPZeIeMd/NxKHt5Z8q4GCn8
	0eKibDv7UERE/Mwe5VdWAbRnNtydE+wbSplIqjUo+UQk0k7lHGFuLqGck6h2TmUXXW0ntpCv4fO
	bx0TcxS0vB1cA5I1gPa4kVmmnHnxfMnxjoaQh6rgQYuFkBvSKk6jcie28/XjOBwHNVM+wewNq07
	JgwRSxndFxtpvLhB3S/O+m5GAk2jhw9qd4NZZozSHqZotRuRwNRPUTdRcVzyb/SRDJbg0iUbj8P
	vMm0F/WFksFZ4htTTTtQkB7bvYzqo+R9ta6jTdewdq1td79SLb9j9xlI8DGaFaM0q2JMje6sZAh
	zhgV+ZRGnsAlYjltT66VflkFy5eiNb8xLmuxXD6Txk/BDXkS/
X-Google-Smtp-Source: AGHT+IE7eWEl/nFpwgH7cC9oR0R3GFfUz4SxYZLPLO2vfKj7RKiBeOmYW6JKFORYzfuBteGpfPQKbA==
X-Received: by 2002:a17:902:d488:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2242887eb5cmr292364525ad.5.1741709200356;
        Tue, 11 Mar 2025 09:06:40 -0700 (PDT)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698243ef6sm10936197b3a.61.2025.03.11.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:06:40 -0700 (PDT)
From: Suraj Patil <surajpatil522@gmail.com>
To: isdn@linux-pingi.de
Cc: kuba@kernel.org,
	quic_jjohnson@quicinc.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH 2/2] isdn: mISDN: Fix typo 'intervall' to 'interval' in hfcsusb.c
Date: Tue, 11 Mar 2025 16:06:37 +0000
Message-ID: <20250311160637.467759-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..ebe57c190476 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1063,7 +1063,7 @@ rx_iso_complete(struct urb *urb)
 
 		fill_isoc_urb(urb, fifo->hw->dev, fifo->pipe,
 			      context_iso_urb->buffer, num_isoc_packets,
-			      fifo->usb_packet_maxlen, fifo->intervall,
+			      fifo->usb_packet_maxlen, fifo->interval,
 			      (usb_complete_t)rx_iso_complete, urb->context);
 		errcode = usb_submit_urb(urb, GFP_ATOMIC);
 		if (errcode < 0) {
@@ -1225,7 +1225,7 @@ tx_iso_complete(struct urb *urb)
 			sink = (threshbit) ? SINK_MIN : SINK_MAX;
 		fill_isoc_urb(urb, fifo->hw->dev, fifo->pipe,
 			      context_iso_urb->buffer, num_isoc_packets,
-			      fifo->usb_packet_maxlen, fifo->intervall,
+			      fifo->usb_packet_maxlen, fifo->interval,
 			      (usb_complete_t)tx_iso_complete, urb->context);
 		memset(context_iso_urb->buffer, 0,
 		       sizeof(context_iso_urb->buffer));
@@ -1355,7 +1355,7 @@ tx_iso_complete(struct urb *urb)
 		/*
 		 * abuse DChannel tx iso completion to trigger NT mode state
 		 * changes tx_iso_complete is assumed to be called every
-		 * fifo->intervall (ms)
+		 * fifo->interval (ms)
 		 */
 		if ((fifon == HFCUSB_D_TX) && (hw->protocol == ISDN_P_NT_S0)
 		    && (hw->timers & NT_ACTIVATION_TIMER)) {
@@ -1411,7 +1411,7 @@ start_isoc_chain(struct usb_fifo *fifo, int num_packets_per_urb,
 					      fifo->iso[i].buffer,
 					      num_packets_per_urb,
 					      fifo->usb_packet_maxlen,
-					      fifo->intervall, complete,
+					      fifo->interval, complete,
 					      &fifo->iso[i]);
 				memset(fifo->iso[i].buffer, 0,
 				       sizeof(fifo->iso[i].buffer));
@@ -1510,7 +1510,7 @@ start_int_fifo(struct usb_fifo *fifo)
 	}
 	usb_fill_int_urb(fifo->urb, fifo->hw->dev, fifo->pipe,
 			 fifo->buffer, fifo->usb_packet_maxlen,
-			 (usb_complete_t)rx_int_complete, fifo, fifo->intervall);
+			 (usb_complete_t)rx_int_complete, fifo, fifo->interval);
 	fifo->active = 1;
 	fifo->stop_gracefull = 0;
 	errcode = usb_submit_urb(fifo->urb, GFP_KERNEL);
@@ -1596,7 +1596,7 @@ reset_hfcsusb(struct hfcsusb *hw)
 	handle_led(hw, LED_POWER_ON);
 }
 
-/* start USB data pipes dependand on device's endpoint configuration */
+/* start USB data pipes dependent on device's endpoint configuration */
 static void
 hfcsusb_start_endpoint(struct hfcsusb *hw, int channel)
 {
@@ -1664,7 +1664,7 @@ hfcsusb_start_endpoint(struct hfcsusb *hw, int channel)
 	}
 }
 
-/* stop USB data pipes dependand on device's endpoint configuration */
+/* stop USB data pipes dependent on device's endpoint configuration */
 static void
 hfcsusb_stop_endpoint(struct hfcsusb *hw, int channel)
 {
@@ -2077,7 +2077,7 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 			f->hw = hw;
 			f->usb_packet_maxlen =
 				le16_to_cpu(ep->desc.wMaxPacketSize);
-			f->intervall = ep->desc.bInterval;
+			f->interval = ep->desc.bInterval;
 		}
 		ep++;
 	}
-- 
2.43.0


