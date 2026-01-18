Return-Path: <netdev+bounces-250838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34164D394DD
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D22306216F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C632B989;
	Sun, 18 Jan 2026 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFZK12uV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491632B98E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738199; cv=none; b=C7f2IN1deypfUaRQPRnz6itXOwY1+bTJ+YACcZTTZs5N8x9PfQvkr2smNAmqOCuWAz7M9w+4QPkvPNYqPUoe3QvanvUloxseQEPMACR77zpjKPzIbyis8FfutSiLkzIv7G419LMpy08nQ83zz8T+AEKfL+h1+xb1yv0sIXF2Eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738199; c=relaxed/simple;
	bh=hjP6L/XQKWvMQgY4uYKAMsXrmG+RNpjdL5M/l3wgAvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3UVf/7Lxj39gJjVcVtbUoTyCa7ZK6Mb6wySx7Ku8wCnpoh9Qc7kFvmZBhxTvICkZuz5ZSva/TP1viArSRkd0onRsUDPTZx08uu0lyLRI4+fgBwPivko/toXano6hb6jIuCAcEkd177qaTq7FFLtKIlTyuMnPeG0jkb0pPeGyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFZK12uV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso22322635e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738191; x=1769342991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6M4GdVcc0onBFZmKSw0N1uzgLv84XPmgy7pOdhOiFk=;
        b=DFZK12uV0ZubAxI5PiZ6Cz+422U4DYxAJ0MRxLyAR2Xk+wck9/Iqc1y8+dvo+kfCjD
         S3/XbNnQjteZiV26n/dzxshJvA+sgsUsygo4fXBKgPA2K1E7Vr4pCCaiudZxMsv208YK
         PLbd7a+8i2sp9cLyFo262gFsouwxg2QZdtXQp8BlUOmalJYqCugW8QPn2lE96SbLAXIJ
         5me0lw8wEvr9EAC1yloEK8J5zaLNcwVI4wa/yT/VWEYboqhYpbCYQ08DrYldCKnvQDB7
         54KX3pXyHPN9ZroFyyoYBBLj174xYkv2WPVDnk9b6m9Mc2ysA8xXZb/eM7Kw2Mxfu7Uw
         4YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738191; x=1769342991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6M4GdVcc0onBFZmKSw0N1uzgLv84XPmgy7pOdhOiFk=;
        b=ulj9Yeq5uBL4abfMgcCqeoMuC5drJtDEmZD8WZ7ojNl4YwWXBQF5hy5UaYInpeUzAD
         7ZKFp9v6q+3oon0YghhuWpLFe0kxSMNcJiPQkzTpztZ01SqThZs+wKdHHJRcZwOkvyQ0
         wD9B2p9f1PaTfzA70L4VTCD97iGo1wuXBV/XaiNVnQeOftkLAi0dtzJI7xxoVqxAj/uX
         HvJFcCgEcok6JB1zx5ouxj5S8CLL9iYba4q//U0EoFIczMSIG7MzOnasozY38v2fhC2w
         jwetYqrqpozm3Aw1EWOWUoWW/2fTHd9TIm+Hj2XfqC/cy7W4ErwtnK+0pFuFdDLKPw93
         dbBA==
X-Gm-Message-State: AOJu0Ywhn+e3F5pwYmdHDAnkkTdDuFN4t3Gzh/sU2z5x6RUDytzUFMI3
	sVq+2mbUudWVBe+XljuPRudZzbrFYA1DlGn4mpF4KJc1+Mwm9RE4QJVN
X-Gm-Gg: AY/fxX77WeQGIUhYcFQuWlvKvg1I+lexSCPrbC2cp1eyqoDgPTtDh3WXb2v4F48dYmj
	5s99mKdsrW/7LUluYQydm8bQL56aFnXOq54PQwgGagIDJHAjxLvrzZ8nD4G3NPXolwgQ3jujY9P
	cg4VlLnd/5yCnsEs1ZMH9PzoiEmZ1YY/R6eycmmwqwI8KeXwvSdfOWXdsMpkeOeE4RrSxw45LHm
	tChy8ns+x35WKB7JPv4wCKSQRrzGsJoYfu4OcJTaNWP346QOav70sl9fCp2cWKrQSw0cWNQNWF9
	ZVqPad9Acp+Kl+WeGEj83JzjmEVCMNFHi/zAeibRuAHHTnGAydbPViTq2EqK7IU/7DaC1CZ75zK
	omC1K4LfREMuaPR8VxGSotz2YWyI397Q6a7y3nWmmCRinLZOH5G6iXdUCT5uFNeQfIIQcOOWGaX
	nzEfIu/eO48rrG3l1dVxsMzfLC
X-Received: by 2002:a05:600c:3486:b0:480:29f1:120d with SMTP id 5b1f17b1804b1-48029f11458mr44090385e9.11.1768738191100;
        Sun, 18 Jan 2026 04:09:51 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm138661265e9.8.2026.01.18.04.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:09:50 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH net-next v2 2/3] net/micrel: Fix typos in micrel driver code comments
Date: Sun, 18 Jan 2026 12:10:00 +0000
Message-ID: <20260118121001.136806-3-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118121001.136806-1-yiconghui@gmail.com>
References: <20260118121001.136806-1-yiconghui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various typos and misspellings in code comments in the
drivers/net/ethernet/micrel directory

Signed-off-by: Yicong Hui <yiconghui@gmail.com>
---
 drivers/net/ethernet/micrel/ks8842.c        | 4 ++--
 drivers/net/ethernet/micrel/ks8851_common.c | 2 +-
 drivers/net/ethernet/micrel/ks8851_spi.c    | 4 ++--
 drivers/net/ethernet/micrel/ksz884x.c       | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index 541c41a9077a..b7cf2ee9115f 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -242,7 +242,7 @@ static void ks8842_reset(struct ks8842_adapter *adapter)
 		msleep(10);
 		iowrite16(0, adapter->hw_addr + REG_GRR);
 	} else {
-		/* The KS8842 goes haywire when doing softare reset
+		/* The KS8842 goes haywire when doing software reset
 		* a work around in the timberdale IP is implemented to
 		* do a hardware reset instead
 		ks8842_write16(adapter, 3, 1, REG_GRR);
@@ -312,7 +312,7 @@ static void ks8842_reset_hw(struct ks8842_adapter *adapter)
 	/* aggressive back off in half duplex */
 	ks8842_enable_bits(adapter, 32, 1 << 8, REG_SGCR1);
 
-	/* enable no excessive collison drop */
+	/* enable no excessive collision drop */
 	ks8842_enable_bits(adapter, 32, 1 << 3, REG_SGCR2);
 
 	/* Enable port 1 force flow control / back pressure / transmit / recv */
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index bb5138806c3f..8048770958d6 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -480,7 +480,7 @@ static int ks8851_net_open(struct net_device *dev)
  * ks8851_net_stop - close network device
  * @dev: The device being closed.
  *
- * Called to close down a network device which has been active. Cancell any
+ * Called to close down a network device which has been active. Cancel any
  * work, shutdown the RX and TX process and then place the chip into a low
  * power state whilst it is not being used.
  */
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index c862b13b447a..a161ae45743a 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -39,7 +39,7 @@ static int msg_enable;
  *
  * The @lock ensures that the chip is protected when certain operations are
  * in progress. When the read or write packet transfer is in progress, most
- * of the chip registers are not ccessible until the transfer is finished and
+ * of the chip registers are not accessible until the transfer is finished and
  * the DMA has been de-asserted.
  */
 struct ks8851_net_spi {
@@ -298,7 +298,7 @@ static unsigned int calc_txlen(unsigned int len)
 
 /**
  * ks8851_tx_work - process tx packet(s)
- * @work: The work strucutre what was scheduled.
+ * @work: The work structure what was scheduled.
  *
  * This is called when a number of packets have been scheduled for
  * transmission and need to be sent to the device.
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index cdde19b8edc4..60223f03482d 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -1166,7 +1166,7 @@ struct ksz_port_info {
  * @tx_cfg:		Cached transmit control settings.
  * @rx_cfg:		Cached receive control settings.
  * @intr_mask:		Current interrupt mask.
- * @intr_set:		Current interrup set.
+ * @intr_set:		Current interrupt set.
  * @intr_blocked:	Interrupt blocked.
  * @rx_desc_info:	Receive descriptor information.
  * @tx_desc_info:	Transmit descriptor information.
@@ -2096,7 +2096,7 @@ static void sw_dis_prio_rate(struct ksz_hw *hw, int port)
 }
 
 /**
- * sw_init_prio_rate - initialize switch prioirty rate
+ * sw_init_prio_rate - initialize switch priority rate
  * @hw: 	The hardware instance.
  *
  * This routine initializes the priority rate function of the switch.
-- 
2.52.0


