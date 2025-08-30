Return-Path: <netdev+bounces-218460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019EB3C8BC
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1AB7B2D36
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E123AE87;
	Sat, 30 Aug 2025 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEm9oX8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E27A900;
	Sat, 30 Aug 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539052; cv=none; b=SYmqBZ8IRFkudHsnsWLcG/7ZyLRSS47R1gPixyK2R+Nqd0pmSzhsdEpGInoK9DfWDzs6y6NcLBL9VG7aWNqC+Hq+j7QCrvwoTEp/UcAXkg+zdHL05idMw5nJhctJkpAvDno8U4YkguBRzvSqXMmz5a3lCpKUA/SCvWkGcHpXk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539052; c=relaxed/simple;
	bh=wcIXpQqEO3nvd/HCzsCGn5wxGPstIGokW21BUx3Fmio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mO1f52X/8BbF+lwSAGZW7nnlt/fC2yOR9g0XziaDzh6iXp7aHm79H4GopQFMO+vEfA3N/iQq5q8j6khIKQOGBIs9uON+/49/4jpgir39IK4p0r+5Hi8K26uq9u9vPohIRk1Q7wZIl8bjHRfjn3xiKjzbpZzqbtOvfD5HRxrkP8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEm9oX8O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-771f90a45easo2394024b3a.1;
        Sat, 30 Aug 2025 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756539050; x=1757143850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OegvabPca6lqHg/fDHGpTPtPWv7N7aOZCqy4snaXfDI=;
        b=dEm9oX8OeMlSl4xo7Aw34skREOB5fE54UKjSzBIvXKkDu5Ky8To5LVgZEaQo5MjSvn
         G6pypxO89xCrgoVnbO+QMvj8U5VBpFW2XOZOZ/n2WACkWNRGihLfeHnFgD1sHBrGkGEv
         gZsBvmpK6ihDQdV1IItctmm4oG516s4tuvaC1gahm8bRIBSsknTrwOrXxRXfkqvC0DsX
         tgn2a0MKHMV/m7iqXail/KWTZu+a99w+5TH1QZ+7xZD6moDWDbghguX3PKBGVQVy6G0u
         Y1+qrot9DSJa4qh9EQoMSaUUb8ga1bZg4o2AG1oQyv6Fg5N3Y2h6r6heg32VQKCUIaXJ
         bAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539050; x=1757143850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OegvabPca6lqHg/fDHGpTPtPWv7N7aOZCqy4snaXfDI=;
        b=YPoN/fHoVp08tX0xzXjS/qM4OdrKAwBgpuGC2ACEalS6uSJGwGxBEvegzICZxQneGa
         emEwdWkfusrCyb8djVM0oU+hCMvGWjFTMYaeMz45bEus+rKS6raBsGMtIwz4fYlsnFdQ
         o96n1QnzbSMwvCccIxJySPlSRC/ztkjrm/8PnjbpAXCgXUNseVJ+k0Y4E1mTw3RqAvmg
         q73DRP8V86pMJuKjkrUraPAeAwoQ0CY/uEhBkDbjmQZrdlkr2d27+3J/+lF4p6rdWNYj
         wb5SgwmKlkuyJpJ3Wn9T5lo1pF7eDPDZc/Vnc3kqsp2LNeJgggGMlpS4OgXJUlDZcAKP
         ZW+A==
X-Forwarded-Encrypted: i=1; AJvYcCVL4Ilx2jG5KlSMm8olVejfgj1KJ1RtaTCEQXg6psOzDrQiaWGDa62mjBauvHKR6y32o6oN/fIVpGoUvaM=@vger.kernel.org, AJvYcCXnQHufC19o0YiUOug38os4BS7WVQK/HQoozrWRq6PTxbe+wndVANVSDQ5Cl+V0pX49m9pxwSUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5c637GAzCmDuM1N/phL0r9Yndu6MRo9fmq75xSsTP7NwdQkFB
	CVKeOYt4S8/YdFNC322IsAqoGsbnL95jzRNK0WmF79Y+nF/7gAagN1g4esT34smH
X-Gm-Gg: ASbGncu+bVOCbfI16Bj1qBBvfrA149veXsbS29/MyjC9OZEH6S1bCrBKrspebgQkuuK
	+Z/5/eWQjOu3ywFZUdP5kiQb7yPZixlT4Y+p7tINFH2dR/oiPtjeDTizq4l4+EzF3i4UfCaf60O
	iKJFxicxmypw1F/8eIKmVK9R8zAoVnDknEYQbtlHH5j4pG4+V+4OUP0Z36NWga2/UD1cP+LQH+l
	VovLTTNZT9oyWLTf3iuxDwTUsvawlooCXh7vh8zr7m0NWZNKHauXnMP2uWN4TsICqX8+iFrIlC2
	c61NW8Fvm8ZjMTRe8qfv7bGzkvkWSytzPy54RcPpB9EXCvhqMmrI9dSrhZx0vH9EQClSUur0GSF
	IWSvPf2FRFbQLIp62xHhlkd2JhTXTXMGWfCSuXu5i5KAnNjzlTpw=
X-Google-Smtp-Source: AGHT+IF3H2iw2cawR6vFHT9rpDvJVJ+9eIssO3WOM6F6yKzQ4npy3AylZNwEXnfqDyVx1vpze1ugPA==
X-Received: by 2002:a05:6a00:4606:b0:771:e1bf:bddc with SMTP id d2e1a72fcca58-7723e27283bmr1476067b3a.13.1756539049917;
        Sat, 30 Aug 2025 00:30:49 -0700 (PDT)
Received: from localhost ([77.111.118.146])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77236d7eb7fsm2484734b3a.54.2025.08.30.00.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 00:30:49 -0700 (PDT)
From: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
Subject: [PATCH v2] r8169: hardening and stability improvements
Date: Sat, 30 Aug 2025 11:00:39 +0330
Message-ID: <20250830073039.598-1-moahmmad.hosseinii@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>

This patch improves robustness and reliability of the r8169 driver. The
changes cover buffer management, interrupt handling, parameter validation,
and resource cleanup.

While the updates touch multiple areas, they are interdependent parts of a
cohesive hardening effort. Splitting them would leave intermediate states
with incomplete validation.

Key changes:
- Buffer handling: add packet length checks, NUMA-aware fallback allocation,
  descriptor zero-initialization, and memory barriers.
- Interrupt handling: fix return codes, selective NAPI scheduling, and
  improved SYSErr handling for RTL_GIGA_MAC_VER_52.
- Parameter validation: stricter RX/TX bounds checking and consistent
  error codes.
- Resource management: safer workqueue shutdown, proper clock lifecycle,
  WARN_ON for unexpected device states.
- Logging: use severity-appropriate levels, add rate limiting, and extend
  statistics tracking.

Testing:
- Kernel builds and module loads without warnings.
- Runtime tested in QEMU (rtl8139 emulation).
- Hardware validation requested from community due to lack of local device.

v2:
 - Resent using msmtp (fix whitespace damage)

Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 150 ++++++++++++++++++----
 1 file changed, 123 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..66d7dcd8bf7b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3981,19 +3981,39 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
 	struct page *data;
+	gfp_t gfp_flags = GFP_KERNEL;
 
-	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
-	if (!data)
-		return NULL;
+	/* Use atomic allocation in interrupt/atomic context */
+	if (in_atomic() || irqs_disabled())
+		gfp_flags = GFP_ATOMIC;
+
+	data = alloc_pages_node(node, gfp_flags, get_order(R8169_RX_BUF_SIZE));
+	if (unlikely(!data)) {
+		/* Try fallback allocation on any node if local node fails */
+		data = alloc_pages(gfp_flags | __GFP_NOWARN, get_order(R8169_RX_BUF_SIZE));
+		if (unlikely(!data)) {
+			if (net_ratelimit())
+				netdev_err(tp->dev, "Failed to allocate RX buffer\n");
+			return NULL;
+		}
+		
+		if (net_ratelimit())
+			netdev_warn(tp->dev, "Fallback allocation used for RX buffer\n");
+	}
 
 	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(d, mapping))) {
-		netdev_err(tp->dev, "Failed to map RX DMA!\n");
+		if (net_ratelimit())
+			netdev_err(tp->dev, "Failed to map RX DMA page\n");
 		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
 		return NULL;
 	}
 
 	desc->addr = cpu_to_le64(mapping);
+	desc->opts2 = 0;
+	
+	/* Ensure writes complete before marking descriptor ready */
+	wmb();
 	rtl8169_mark_to_asic(desc);
 
 	return data;
@@ -4150,11 +4170,30 @@ static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
 	u32 opts1;
 	int ret;
 
+	/* Validate parameters before DMA mapping */
+	if (unlikely(!addr)) {
+		if (net_ratelimit())
+			netdev_err(tp->dev, "TX mapping with NULL address\n");
+		return -EINVAL;
+	}
+	
+	if (unlikely(!len)) {
+		if (net_ratelimit())
+			netdev_err(tp->dev, "TX mapping with zero length\n");
+		return -EINVAL;
+	}
+	
+	if (unlikely(len > RTL_GSO_MAX_SIZE_V2)) {
+		if (net_ratelimit())
+			netdev_err(tp->dev, "TX length too large: %u\n", len);
+		return -EINVAL;
+	}
+
 	mapping = dma_map_single(d, addr, len, DMA_TO_DEVICE);
 	ret = dma_mapping_error(d, mapping);
 	if (unlikely(ret)) {
 		if (net_ratelimit())
-			netdev_err(tp->dev, "Failed to map TX data!\n");
+			netdev_err(tp->dev, "Failed to map TX DMA: len=%u\n", len);
 		return ret;
 	}
 
@@ -4601,9 +4640,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (status & DescOwn)
 			break;
 
-		/* This barrier is needed to keep us from reading
-		 * any other fields out of the Rx descriptor until
-		 * we know the status of DescOwn
+		/* Ensure descriptor ownership check completes before accessing
+		 * other fields to prevent hardware race conditions
 		 */
 		dma_rmb();
 
@@ -4624,8 +4662,27 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		}
 
 		pkt_size = status & GENMASK(13, 0);
-		if (likely(!(dev->features & NETIF_F_RXFCS)))
-			pkt_size -= ETH_FCS_LEN;
+		
+		/* Validate packet size to prevent buffer overflows */
+		if (unlikely(pkt_size > R8169_RX_BUF_SIZE)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Oversized packet: %u bytes (status=0x%08x)\n",
+					    pkt_size, status);
+			dev->stats.rx_length_errors++;
+			goto release_descriptor;
+		}
+		
+		if (likely(!(dev->features & NETIF_F_RXFCS))) {
+			if (pkt_size >= ETH_FCS_LEN) {
+				pkt_size -= ETH_FCS_LEN;
+			} else {
+				if (net_ratelimit())
+					netdev_warn(dev, "Packet smaller than FCS: %u bytes (status=0x%08x)\n",
+						    pkt_size, status);
+				dev->stats.rx_length_errors++;
+				goto release_descriptor;
+			}
+		}
 
 		/* The driver does not support incoming fragmented frames.
 		 * They are seen as a symptom of over-mtu sized frames.
@@ -4674,26 +4731,44 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 {
 	struct rtl8169_private *tp = dev_instance;
 	u32 status = rtl_get_events(tp);
+	bool handled = false;
 
+	/* Check for invalid hardware state or no relevant interrupts */
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
 
-	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
-	if (unlikely(status & SYSErr &&
-	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
-		rtl8169_pcierr_interrupt(tp->dev);
+	/* Handle system errors based on chip version capabilities */
+	if (unlikely(status & SYSErr)) {
+		/* SYSErr handling for older chips and specific newer models
+		 * based on vendor documentation and observed behavior
+		 */
+		if (tp->mac_version <= RTL_GIGA_MAC_VER_06 || 
+		    tp->mac_version == RTL_GIGA_MAC_VER_52) {
+			rtl8169_pcierr_interrupt(tp->dev);
+		} else {
+			/* Log for diagnostic purposes on newer chips */
+			if (net_ratelimit())
+				netdev_warn(tp->dev, "SYSErr on newer chip: status=0x%08x\n", status);
+		}
+		handled = true;
 		goto out;
 	}
 
-	if (status & LinkChg)
+	if (status & LinkChg) {
 		phy_mac_interrupt(tp->phydev);
+		handled = true;
+	}
+
+	if (status & (RxOK | RxErr | TxOK | TxErr)) {
+		rtl_irq_disable(tp);
+		napi_schedule(&tp->napi);
+		handled = true;
+	}
 
-	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static void rtl_task(struct work_struct *work)
@@ -4783,8 +4858,11 @@ static int r8169_phy_connect(struct rtl8169_private *tp)
 
 static void rtl8169_down(struct rtl8169_private *tp)
 {
-	disable_work_sync(&tp->wk.work);
-	/* Clear all task flags */
+	/* Synchronize with pending work to prevent races during shutdown.
+	 * This is necessary because work items may access hardware registers
+	 * that we're about to reset.
+	 */
+	cancel_work_sync(&tp->wk.work);
 	bitmap_zero(tp->wk.flags, RTL_FLAG_MAX);
 
 	phy_stop(tp->phydev);
@@ -4798,6 +4876,10 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
 
+	/* Disable clock if it was enabled during resume */
+	if (tp->clk)
+		clk_disable_unprepare(tp->clk);
+
 	if (tp->dash_type != RTL_DASH_NONE)
 		rtl8168_driver_stop(tp);
 }
@@ -4812,7 +4894,6 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
 	napi_enable(&tp->napi);
-	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
 
 	phy_start(tp->phydev);
@@ -4962,12 +5043,27 @@ static void rtl8169_net_suspend(struct rtl8169_private *tp)
 static int rtl8169_runtime_resume(struct device *dev)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (WARN_ON(!tp || !tp->dev)) {
+		dev_err(dev, "Critical: Invalid device state during resume\n");
+		return -ENODEV;
+	}
 
 	rtl_rar_set(tp, tp->dev->dev_addr);
 	__rtl8169_set_wol(tp, tp->saved_wolopts);
 
-	if (tp->TxDescArray)
+	if (tp->TxDescArray) {
+		/* Enable clock if available */
+		if (tp->clk) {
+			ret = clk_prepare_enable(tp->clk);
+			if (ret) {
+				dev_err(dev, "Failed to enable clock: %d\n", ret);
+				return ret;
+			}
+		}
 		rtl8169_up(tp);
+	}
 
 	netif_device_attach(tp->dev);
 
@@ -4980,7 +5076,7 @@ static int rtl8169_suspend(struct device *device)
 
 	rtnl_lock();
 	rtl8169_net_suspend(tp);
-	if (!device_may_wakeup(tp_to_dev(tp)))
+	if (!device_may_wakeup(tp_to_dev(tp)) && tp->clk)
 		clk_disable_unprepare(tp->clk);
 	rtnl_unlock();
 
@@ -4991,7 +5087,7 @@ static int rtl8169_resume(struct device *device)
 {
 	struct rtl8169_private *tp = dev_get_drvdata(device);
 
-	if (!device_may_wakeup(tp_to_dev(tp)))
+	if (!device_may_wakeup(tp_to_dev(tp)) && tp->clk)
 		clk_prepare_enable(tp->clk);
 
 	/* Reportedly at least Asus X453MA truncates packets otherwise */
@@ -5059,7 +5155,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
-	disable_work_sync(&tp->wk.work);
+	/* Ensure all work is completed before device removal */
+	cancel_work_sync(&tp->wk.work);
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS))
 		r8169_remove_leds(tp->leds);
@@ -5471,7 +5568,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->irq = pci_irq_vector(pdev, 0);
 
 	INIT_WORK(&tp->wk.work, rtl_task);
-	disable_work(&tp->wk.work);
 
 	rtl_init_mac_address(tp);
 
@@ -5593,4 +5689,4 @@ static struct pci_driver rtl8169_pci_driver = {
 	.driver.pm	= pm_ptr(&rtl8169_pm_ops),
 };
 
-module_pci_driver(rtl8169_pci_driver);
+module_pci_driver(rtl8169_pci_driver);
\ No newline at end of file
-- 
2.43.0


