Return-Path: <netdev+bounces-95822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF508C38F2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 00:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809EA28123D
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 22:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143D5476B;
	Sun, 12 May 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3szn+1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EF42A8B
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551615; cv=none; b=RFxEvxVtQEb6t3HFCh3ay4VwpHP+u8icUP1ZY29/cl9ORozFQNqDCK3PNC7vw6l0KlVUd0jcSvGjt0jAzrNNaeBuI6sjh5YD9O/+Rrzex0sWQXCKiyj1mTp18q8LiUo/aaFfSWk8p2oTzA6R1r6mbK0T3RhZCCx22BYgrv+K3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551615; c=relaxed/simple;
	bh=ttfN6FeGWHdEoMQZv1ZhJrw+xAJZJl6VblIRW+HOE2U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HvJ9ZFwkTQ6qT7+IfyNKJmBslPKUC1quO+V7tqmtdKQrmUYqT0feoQVF0rvFMkPK6brqFEuLtywWEyDWIDR1noG1d8zC59Z/RQNFXArjQE4g0aScyAo13T8cLMDtbU7sSeNo9i8thC8z+HOa1U/sOSpwGSoCyrBW8SRFrdo12W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3szn+1y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso1533415e9.0
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715551612; x=1716156412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDmXCQLxpbbPKH+gwgNLbt2UwtvU7u5iknn1DtwWHDM=;
        b=G3szn+1yiouEfxjtwIinfSHq7y4tUC4bgWAm7shhqZVGo2Ca8CFuVLtGdtkaFTf2f4
         o2XVsVfkB4ZUkyqKsjG7mX800TSyReHZhXZB4j9LQik683O66ioXUsRyNZ8rUDwsNzKt
         fbZ1Bdk2L475y1eJxhboHNQ5rSCOjiuUUngAHtyk6rSWbI9uxfBJdP1EThlCxogPECpb
         jA/5q213yGr0Lurezz7KYr67JCDMGx/ebOeldUWa6PYBXKP3hUBwjMamtzYCQarkd8GX
         AfXMmLmoR/N8uQKhwlqKqFx5ixFuFrNHVvQk0JGMf29ti2nqAIt1W/9hTS1xtF1Uzz1E
         m+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715551612; x=1716156412;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hDmXCQLxpbbPKH+gwgNLbt2UwtvU7u5iknn1DtwWHDM=;
        b=NEc+IzxEtbzQipRmdr2h7/Ow597ywIteeeqEQO53jcNfQQZyGq3Ig4QOThHVVKHE3I
         S3EkAuWeD4d2UTpeeJCMnrvLGmmshb9Z96z9kRKRcDSyedtfUJdLiAxG99vDo1l1InoF
         HopvGt1ZO3JyJngXojZbp/Fz1gW7R1er5IyL6f3GFXwclIFphZcI8s27fCaYnRyKKUME
         ynqVXF8DHIrKLWYzrA/0mRHZG9PTDuOVDOYcVTWYs4QOkcM3kfjcaWddL30MbymIT2DO
         b5FT2eQtqcTT2wKCxHSASqqvpiaK6TCLOoRNCuhgW31tWxNJUXvGrru7rOeopPUP3ZXQ
         oZ1A==
X-Gm-Message-State: AOJu0YwH6gdECqg+H6PHzdz6LZJexL0eP4I42E6xqb1Uryg40OIVYyX3
	D1NdgbmFvElPFcPANvpylbgSaG8t2JOSnMpIYw5Z4haWjzPIfXNqYNc7zZ+G
X-Google-Smtp-Source: AGHT+IFzRGrite4rvZXYzxWAcb2/k3bMi0kT13uOBeHsFCvwKNV/Y6OcBkaKnz7oAv7DEU8vuUU+JA==
X-Received: by 2002:a05:600c:4286:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-41feaa397f7mr55393215e9.11.1715551611998;
        Sun, 12 May 2024 15:06:51 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf08sm9599605f8f.96.2024.05.12.15.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 15:06:51 -0700 (PDT)
Message-ID: <7ea34300-7d55-4411-8ce9-fcc769e05647@gmail.com>
Date: Sun, 12 May 2024 23:06:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
Subject: r8169: RTL8125 timer experimentation
To: netdev@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have been experimenting with the "interrupt moderation" timer on the RTL8125, based largely on reading the NetBSD "rge" driver source.
This doesn't seem like much of an improvement over a software timer, but the BSD driver as well as the Realtek-supplied r8125 driver both make use of it.

Despite using 32-bit registers it appears that the timer is 16-bit, and runs at 125 MHz.
The default timeout interval used by the aforementioned drivers is 0x2600 which equates to about 78 us.
This interval maybe seems a bit long, but I note that both drivers use a ring buffer size of 1024 vs only 256 in the r8169 driver.

The patch below is just for interest. It modifies r8169 to use the timer when enabling interrupts from rtl8169_poll, following any Tx or Rx work having been done.
The timer interval can be adjusted via a module parameter.



diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 6e34177..1fc470c 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -329,6 +329,8 @@ enum rtl8168_registers {
 enum rtl8125_registers {
 	IntrMask_8125		= 0x38,
 	IntrStatus_8125		= 0x3c,
+	TimerCnt0_8125		= 0x48,
+	TimerInt0_8125		= 0x58,
 	TxPoll_8125		= 0x90,
 	MAC0_BKP		= 0x19e0,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
@@ -660,6 +662,9 @@ MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 
+static u16 rtl8125_timer_interval __read_mostly = 0x2600;
+module_param(rtl8125_timer_interval, ushort, 0644);
+
 static inline struct device *tp_to_dev(struct rtl8169_private *tp)
 {
 	return &tp->pci_dev->dev;
@@ -1324,6 +1329,26 @@ u8 rtl8168d_efuse_read(struct rtl8169_private *tp, int reg_addr)
 		RTL_R32(tp, EFUSEAR) & EFUSEAR_DATA_MASK : ~0;
 }
 
+static void rtl8125_hard_irq_enable(struct rtl8169_private *tp)
+{
+	u32 mask = tp->irq_mask & ~PCSTimeout;
+
+	RTL_W32(tp, TimerInt0_8125, 0);
+	RTL_W32(tp, IntrMask_8125, mask);
+}
+
+static void rtl8125_timer_irq_enable(struct rtl8169_private *tp)
+{
+	u16 interval = READ_ONCE(rtl8125_timer_interval);
+
+	if (interval) {
+		RTL_W32(tp, TimerInt0_8125, interval);
+		RTL_W32(tp, TimerCnt0_8125, 1);
+		RTL_W32(tp, IntrMask_8125, PCSTimeout);
+	} else
+		rtl8125_hard_irq_enable(tp);
+}
+
 static u32 rtl_get_events(struct rtl8169_private *tp)
 {
 	if (rtl_is_8125(tp))
@@ -1351,7 +1376,7 @@ static void rtl_irq_disable(struct rtl8169_private *tp)
 static void rtl_irq_enable(struct rtl8169_private *tp)
 {
 	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+		rtl8125_hard_irq_enable(tp);
 	else
 		RTL_W16(tp, IntrMask, tp->irq_mask);
 }
@@ -4430,7 +4455,7 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 }
 
-static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
+static bool rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		   int budget)
 {
 	unsigned int dirty_tx, bytes_compl = 0, pkts_compl = 0;
@@ -4481,6 +4506,9 @@ static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		 */
 		if (READ_ONCE(tp->cur_tx) != dirty_tx && skb)
 			rtl8169_doorbell(tp);
+		return true;
+	} else {
+		return false;
 	}
 }
 
@@ -4654,13 +4682,18 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	struct rtl8169_private *tp = container_of(napi, struct rtl8169_private, napi);
 	struct net_device *dev = tp->dev;
 	int work_done;
+	bool tx_done;
 
-	rtl_tx(dev, tp, budget);
+	tx_done = rtl_tx(dev, tp, budget);
 
 	work_done = rtl_rx(dev, tp, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
-		rtl_irq_enable(tp);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		if (rtl_is_8125(tp) && (work_done || tx_done))
+			rtl8125_timer_irq_enable(tp);
+		else
+			rtl_irq_enable(tp);
+	}
 
 	return work_done;
 }
@@ -5031,6 +5064,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 		tp->irq_mask |= RxFIFOOver;
 	else
 		tp->irq_mask |= RxOverflow;
+
+	if (rtl_is_8125(tp))
+		tp->irq_mask |= PCSTimeout;
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)

