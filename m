Return-Path: <netdev+bounces-247616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14049CFC543
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9BD3014A30
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC642505AA;
	Wed,  7 Jan 2026 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js4DezRo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B9155C97
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770649; cv=none; b=E+qiBjEEF4xQvjlyrvSVHkYKhqKGLoJuESJXbm/DK8T6oJgpHp0iakx2OmdIzSPPC99UtOrjFm+EwaY79VZ9srn6JDN2gBe62KYajmOAUYbpIeuHcwOZlZ7+sfYlohmuXjpxHv07FuPiBMtskGWs4eAZdFEVGSEXmdRhldXJoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770649; c=relaxed/simple;
	bh=5dP2+iwx8rVmgry+XzEPlq/1BvsYAvrv2zohd9FiF3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgnHszZdXUZg+b5h19qsAeDgYOsLARcD/NSlFlZhR9K13HKijjfZM25pGTQInexCst/7PtrmrJRxSYXuDAqwEWdsIoiAG5FxTMp29t2ZLF8M7v9wM/aHSXoDZBUXi3woetk8PN+yqnmeLieMlrOOnWh4MNi+GJmAJgnd1OKyUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Js4DezRo; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-11f3e3f0cacso1456363c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767770646; x=1768375446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMJksMeWEMNDkEUjoTDixVItJ2+0zlEAIWm0TJkG2Y8=;
        b=Js4DezRoNJgp90XB0ebN40zxBv008A8sxm/IYGSLRv7FtKYTEu5vBKZFbN8R2hQSM0
         Y65BDDkBTK2IxcISdKXShBukspHHMTDy5vpTuqpC8CqSz/kAxpBeOImeIpC1OwMPzWEO
         3JT+AkeNhUZIDeDRZQqJfaP2rdREgXTsKrhbgskUAjRE9D/Zss1GG5a2dQjduT3nvsl9
         9gZ0v9FXk3wdazzihK8tROzuQer+j3V8idx1oT3JqY0KprcbKt0QBZMWwiPtcJ+L3Hfb
         6HV9GzjUpBjZyVmR5YdBt57+3CC6zOJMSKu9dKvgQBoIVylpT41BWSTq8WhhR68k+BaR
         65Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770646; x=1768375446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMJksMeWEMNDkEUjoTDixVItJ2+0zlEAIWm0TJkG2Y8=;
        b=EBZc5500yXdJokdEl0pCm4fB3XmlpV8yxaoMoYQuG1G9YUKyA5gPnrXW8Kc599cH0U
         y9LiFHqkU97L/MUzCcz+hPYYIPLxeSjmFf+RsqyVS9OhVr02Hz3itKB0+OeKAzufCihP
         dtDi+4nfhyMcx3Y1J1RgAf2xPxoXlUboKd/ZF7RbqiTU4HaaKczSqYRYlJBXsePTfXlE
         L094eMD0EtRAXwDfHwDhBl5O1/UIspG60UrRRHj3VMJLbsmBgRqbGJu/LEmhPpT7MPNj
         AmiXEvQFVhn09GVQidoSvbKzueWSPF0f+fQVWdu8Fk5yp3QPUiEuko9+f1pzZczZeiQU
         Me5g==
X-Gm-Message-State: AOJu0YzYCfuAot6hFtU6u23BuDAKJUXDsjMQqNugIf32T35wIlAGKESP
	jMbseOWSLMT1iMrpmNG7DbMnxGA4VV3ohcT1YYBnqTaD2PQis+McchtQOPekudvG
X-Gm-Gg: AY/fxX6HknUd7rlFMf4ZBdrtDE6+WzGaR9K3VNKKaEKgEos1p1Pg2CLMchWWzGWAGT/
	fHP9ZAy0l1rd1iRGt2DjydzoZFLhlaH7UxvDj+61BXIg6GXxd0yEVNBqp+WwxWEftx63eGG7A7S
	22+71d+G+MNR9RWKoyZuDYRl2h0oyS1XvDF8d+jPCoNBzU1BqTIoJZ11OUymtRNzeIW7yB5MQWp
	lcCyCWIOaPYhfDjDKEmEfrWE/lwKer+D4vrxVMcFxOxbquW+tI/rlJGU2I9ixhXjbPnatZKh0P1
	PgGUuCFN60U9lypHu7biaKRRsP5ybCgPP8IOhQWso/q1SskS8ZpqhyjED/DU0Dn0LSejI8Zzw9k
	to4kkZaYSQO9cd0POMcafvDh1qf3tzJuMwbA8c4qnc4OwwEoWbw9eRuNXiYvbKDlrMB9mEkyx+h
	WrrJ0FqiTyiNinDTuRwcFyt3gdHz2qxbQ0atpTjjtImGsKRJFJ+C/ckMD0PPJYzACwYrSairLUS
	JzdIYlaT9Bz5+QmOTcQgty/r22mP3doVE0uxtXBtPE635j13oghlVICWVOfXXwVWwuswVW0DjTo
	Mf1v
X-Google-Smtp-Source: AGHT+IFaukRmiCLL80qqHQMKRDdc1LZ3wTNWR8Gz0oRvxn3H0Lwi8ZEo57lVoca9bbN8o3QUOlqOnQ==
X-Received: by 2002:a05:7022:41a7:b0:11b:9386:8254 with SMTP id a92af1059eb24-121f8b65e84mr1453818c88.41.1767770645866;
        Tue, 06 Jan 2026 23:24:05 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c16fsm9243123c88.10.2026.01.06.23.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:24:05 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] net: ethernet: tehuti: remove function tracing macros
Date: Tue,  6 Jan 2026 23:24:01 -0800
Message-ID: <20260107072401.36434-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These function tracing macros clutter the code and provide
no value over ftrace. Remove them.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/tehuti/tehuti.c | 103 +++++++--------------------
 drivers/net/ethernet/tehuti/tehuti.h |  13 ----
 2 files changed, 26 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
index 2cee1f05ac47..c23a328bfcdc 100644
--- a/drivers/net/ethernet/tehuti/tehuti.c
+++ b/drivers/net/ethernet/tehuti/tehuti.c
@@ -161,7 +161,7 @@ bdx_fifo_init(struct bdx_priv *priv, struct fifo *f, int fsz_type,
 				   &f->da, GFP_ATOMIC);
 	if (!f->va) {
 		pr_err("dma_alloc_coherent failed\n");
-		RET(-ENOMEM);
+		return -ENOMEM;
 	}
 	f->reg_CFG0 = reg_CFG0;
 	f->reg_CFG1 = reg_CFG1;
@@ -174,7 +174,7 @@ bdx_fifo_init(struct bdx_priv *priv, struct fifo *f, int fsz_type,
 	WRITE_REG(priv, reg_CFG0, (u32) ((f->da & TX_RX_CFG0_BASE) | fsz_type));
 	WRITE_REG(priv, reg_CFG1, H32_64(f->da));
 
-	RET(0);
+	return 0;
 }
 
 /**
@@ -184,13 +184,11 @@ bdx_fifo_init(struct bdx_priv *priv, struct fifo *f, int fsz_type,
  */
 static void bdx_fifo_free(struct bdx_priv *priv, struct fifo *f)
 {
-	ENTER;
 	if (f->va) {
 		dma_free_coherent(&priv->pdev->dev,
 				  f->memsz + FIFO_EXTRA_SPACE, f->va, f->da);
 		f->va = NULL;
 	}
-	RET();
 }
 
 /**
@@ -254,7 +252,6 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 	struct bdx_priv *priv = netdev_priv(ndev);
 	u32 isr;
 
-	ENTER;
 	isr = (READ_REG(priv, regISR) & IR_RUN);
 	if (unlikely(!isr)) {
 		bdx_enable_interrupts(priv);
@@ -267,7 +264,7 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 	if (isr & (IR_RX_DESC_0 | IR_TX_FREE_0)) {
 		if (likely(napi_schedule_prep(&priv->napi))) {
 			__napi_schedule(&priv->napi);
-			RET(IRQ_HANDLED);
+			return IRQ_HANDLED;
 		} else {
 			/* NOTE: we get here if intr has slipped into window
 			 * between these lines in bdx_poll:
@@ -283,7 +280,7 @@ static irqreturn_t bdx_isr_napi(int irq, void *dev)
 	}
 
 	bdx_enable_interrupts(priv);
-	RET(IRQ_HANDLED);
+	return IRQ_HANDLED;
 }
 
 static int bdx_poll(struct napi_struct *napi, int budget)
@@ -291,7 +288,6 @@ static int bdx_poll(struct napi_struct *napi, int budget)
 	struct bdx_priv *priv = container_of(napi, struct bdx_priv, napi);
 	int work_done;
 
-	ENTER;
 	bdx_tx_cleanup(priv);
 	work_done = bdx_rx_receive(priv, &priv->rxd_fifo0, budget);
 	if ((work_done < budget) ||
@@ -324,7 +320,6 @@ static int bdx_fw_load(struct bdx_priv *priv)
 	int master, i;
 	int rc;
 
-	ENTER;
 	master = READ_REG(priv, regINIT_SEMAPHORE);
 	if (!READ_REG(priv, regINIT_STATUS) && master) {
 		rc = request_firmware(&fw, "tehuti/bdx.bin", &priv->pdev->dev);
@@ -354,10 +349,10 @@ static int bdx_fw_load(struct bdx_priv *priv)
 			    READ_REG(priv, regVPC),
 			    READ_REG(priv, regVIC),
 			    READ_REG(priv, regINIT_STATUS), i);
-		RET(rc);
+		return rc;
 	} else {
 		DBG("%s: firmware loading success\n", priv->ndev->name);
-		RET(0);
+		return 0;
 	}
 }
 
@@ -365,7 +360,6 @@ static void bdx_restore_mac(struct net_device *ndev, struct bdx_priv *priv)
 {
 	u32 val;
 
-	ENTER;
 	DBG("mac0=%x mac1=%x mac2=%x\n",
 	    READ_REG(priv, regUNC_MAC0_A),
 	    READ_REG(priv, regUNC_MAC1_A), READ_REG(priv, regUNC_MAC2_A));
@@ -380,7 +374,6 @@ static void bdx_restore_mac(struct net_device *ndev, struct bdx_priv *priv)
 	DBG("mac0=%x mac1=%x mac2=%x\n",
 	    READ_REG(priv, regUNC_MAC0_A),
 	    READ_REG(priv, regUNC_MAC1_A), READ_REG(priv, regUNC_MAC2_A));
-	RET();
 }
 
 /**
@@ -392,7 +385,6 @@ static int bdx_hw_start(struct bdx_priv *priv)
 	int rc = -EIO;
 	struct net_device *ndev = priv->ndev;
 
-	ENTER;
 	bdx_link_changed(priv);
 
 	/* 10G overall max length (vlan, eth&ip header, ip payload, crc) */
@@ -431,28 +423,24 @@ static int bdx_hw_start(struct bdx_priv *priv)
 		goto err_irq;
 	bdx_enable_interrupts(priv);
 
-	RET(0);
+	return 0;
 
 err_irq:
-	RET(rc);
+	return rc;
 }
 
 static void bdx_hw_stop(struct bdx_priv *priv)
 {
-	ENTER;
 	bdx_disable_interrupts(priv);
 	free_irq(priv->pdev->irq, priv->ndev);
 
 	netif_carrier_off(priv->ndev);
 	netif_stop_queue(priv->ndev);
-
-	RET();
 }
 
 static int bdx_hw_reset_direct(void __iomem *regs)
 {
 	u32 val, i;
-	ENTER;
 
 	/* reset sequences: read, write 1, read, write 0 */
 	val = readl(regs + regCLKPLL);
@@ -475,7 +463,6 @@ static int bdx_hw_reset_direct(void __iomem *regs)
 static int bdx_hw_reset(struct bdx_priv *priv)
 {
 	u32 val, i;
-	ENTER;
 
 	if (priv->port == 0) {
 		/* reset sequences: read, write 1, read, write 0 */
@@ -500,7 +487,6 @@ static int bdx_sw_reset(struct bdx_priv *priv)
 {
 	int i;
 
-	ENTER;
 	/* 1. load MAC (obsolete) */
 	/* 2. disable Rx (and Tx) */
 	WRITE_REG(priv, regGMAC_RXF_A, 0);
@@ -547,16 +533,15 @@ static int bdx_sw_reset(struct bdx_priv *priv)
 	for (i = regTXD_WPTR_0; i <= regTXF_RPTR_3; i += 0x10)
 		DBG("%x = %x\n", i, READ_REG(priv, i) & TXF_WPTR_WR_PTR);
 
-	RET(0);
+	return 0;
 }
 
 /* bdx_reset - performs right type of reset depending on hw type */
 static int bdx_reset(struct bdx_priv *priv)
 {
-	ENTER;
-	RET((priv->pdev->device == 0x3009)
+	return (priv->pdev->device == 0x3009)
 	    ? bdx_hw_reset(priv)
-	    : bdx_sw_reset(priv));
+	    : bdx_sw_reset(priv);
 }
 
 /**
@@ -574,7 +559,6 @@ static int bdx_close(struct net_device *ndev)
 {
 	struct bdx_priv *priv = NULL;
 
-	ENTER;
 	priv = netdev_priv(ndev);
 
 	napi_disable(&priv->napi);
@@ -583,7 +567,7 @@ static int bdx_close(struct net_device *ndev)
 	bdx_hw_stop(priv);
 	bdx_rx_free(priv);
 	bdx_tx_free(priv);
-	RET(0);
+	return 0;
 }
 
 /**
@@ -603,7 +587,6 @@ static int bdx_open(struct net_device *ndev)
 	struct bdx_priv *priv;
 	int rc;
 
-	ENTER;
 	priv = netdev_priv(ndev);
 	bdx_reset(priv);
 	if (netif_running(ndev))
@@ -624,11 +607,11 @@ static int bdx_open(struct net_device *ndev)
 
 	print_fw_id(priv->nic);
 
-	RET(0);
+	return 0;
 
 err:
 	bdx_close(ndev);
-	RET(rc);
+	return rc;
 }
 
 static int bdx_range_check(struct bdx_priv *priv, u32 offset)
@@ -644,14 +627,12 @@ static int bdx_siocdevprivate(struct net_device *ndev, struct ifreq *ifr,
 	u32 data[3];
 	int error;
 
-	ENTER;
-
 	DBG("jiffies=%ld cmd=%d\n", jiffies, cmd);
 	if (cmd != SIOCDEVPRIVATE) {
 		error = copy_from_user(data, udata, sizeof(data));
 		if (error) {
 			pr_err("can't copy from user\n");
-			RET(-EFAULT);
+			return -EFAULT;
 		}
 		DBG("%d 0x%x 0x%x\n", data[0], data[1], data[2]);
 	} else {
@@ -672,7 +653,7 @@ static int bdx_siocdevprivate(struct net_device *ndev, struct ifreq *ifr,
 		    data[2]);
 		error = copy_to_user(udata, data, sizeof(data));
 		if (error)
-			RET(-EFAULT);
+			return -EFAULT;
 		break;
 
 	case BDX_OP_WRITE:
@@ -684,7 +665,7 @@ static int bdx_siocdevprivate(struct net_device *ndev, struct ifreq *ifr,
 		break;
 
 	default:
-		RET(-EOPNOTSUPP);
+		return -EOPNOTSUPP;
 	}
 	return 0;
 }
@@ -702,11 +683,10 @@ static void __bdx_vlan_rx_vid(struct net_device *ndev, uint16_t vid, int enable)
 	struct bdx_priv *priv = netdev_priv(ndev);
 	u32 reg, bit, val;
 
-	ENTER;
 	DBG2("vid=%d value=%d\n", (int)vid, enable);
 	if (unlikely(vid >= 4096)) {
 		pr_err("invalid VID: %u (> 4096)\n", vid);
-		RET();
+		return;
 	}
 	reg = regVLAN_0 + (vid / 32) * 4;
 	bit = 1 << vid % 32;
@@ -718,7 +698,6 @@ static void __bdx_vlan_rx_vid(struct net_device *ndev, uint16_t vid, int enable)
 		val &= ~bit;
 	DBG2("new val %x\n", val);
 	WRITE_REG(priv, reg, val);
-	RET();
 }
 
 /**
@@ -754,14 +733,13 @@ static int bdx_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vid)
  */
 static int bdx_change_mtu(struct net_device *ndev, int new_mtu)
 {
-	ENTER;
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 	if (netif_running(ndev)) {
 		bdx_close(ndev);
 		bdx_open(ndev);
 	}
-	RET(0);
+	return 0;
 }
 
 static void bdx_setmulti(struct net_device *ndev)
@@ -772,7 +750,6 @@ static void bdx_setmulti(struct net_device *ndev)
 	    GMAC_RX_FILTER_AM | GMAC_RX_FILTER_AB | GMAC_RX_FILTER_OSEN;
 	int i;
 
-	ENTER;
 	/* IMF - imperfect (hash) rx multicat filter */
 	/* PMF - perfect rx multicat filter */
 
@@ -819,7 +796,6 @@ static void bdx_setmulti(struct net_device *ndev)
 	WRITE_REG(priv, regGMAC_RXF_A, rxf_val);
 	/* enable RX */
 	/* FIXME: RXE(ON) */
-	RET();
 }
 
 static int bdx_set_mac(struct net_device *ndev, void *p)
@@ -827,21 +803,19 @@ static int bdx_set_mac(struct net_device *ndev, void *p)
 	struct bdx_priv *priv = netdev_priv(ndev);
 	struct sockaddr *addr = p;
 
-	ENTER;
 	/*
 	   if (netif_running(dev))
 	   return -EBUSY
 	 */
 	eth_hw_addr_set(ndev, addr->sa_data);
 	bdx_restore_mac(ndev, priv);
-	RET(0);
+	return 0;
 }
 
 static int bdx_read_mac(struct bdx_priv *priv)
 {
 	u16 macAddress[3], i;
 	u8 addr[ETH_ALEN];
-	ENTER;
 
 	macAddress[2] = READ_REG(priv, regUNC_MAC0_A);
 	macAddress[2] = READ_REG(priv, regUNC_MAC0_A);
@@ -854,7 +828,7 @@ static int bdx_read_mac(struct bdx_priv *priv)
 		addr[i * 2] = macAddress[i] >> 8;
 	}
 	eth_hw_addr_set(priv->ndev, addr);
-	RET(0);
+	return 0;
 }
 
 static u64 bdx_read_l2stat(struct bdx_priv *priv, int reg)
@@ -987,7 +961,6 @@ static inline void bdx_rxdb_free_elem(struct rxdb *db, int n)
 
 static int bdx_rx_init(struct bdx_priv *priv)
 {
-	ENTER;
 
 	if (bdx_fifo_init(priv, &priv->rxd_fifo0.m, priv->rxd_size,
 			  regRXD_CFG0_0, regRXD_CFG1_0,
@@ -1021,7 +994,6 @@ static void bdx_rx_free_skbs(struct bdx_priv *priv, struct rxf_fifo *f)
 	struct rxdb *db = priv->rxdb;
 	u16 i;
 
-	ENTER;
 	DBG("total=%d free=%d busy=%d\n", db->nelem, bdx_rxdb_available(db),
 	    db->nelem - bdx_rxdb_available(db));
 	while (bdx_rxdb_available(db) > 0) {
@@ -1047,7 +1019,6 @@ static void bdx_rx_free_skbs(struct bdx_priv *priv, struct rxf_fifo *f)
  */
 static void bdx_rx_free(struct bdx_priv *priv)
 {
-	ENTER;
 	if (priv->rxdb) {
 		bdx_rx_free_skbs(priv, &priv->rxf_fifo0);
 		bdx_rxdb_destroy(priv->rxdb);
@@ -1055,8 +1026,6 @@ static void bdx_rx_free(struct bdx_priv *priv)
 	}
 	bdx_fifo_free(priv, &priv->rxf_fifo0.m);
 	bdx_fifo_free(priv, &priv->rxd_fifo0.m);
-
-	RET();
 }
 
 /*************************************************************************
@@ -1084,7 +1053,6 @@ static void bdx_rx_alloc_skbs(struct bdx_priv *priv, struct rxf_fifo *f)
 	int dno, delta, idx;
 	struct rxdb *db = priv->rxdb;
 
-	ENTER;
 	dno = bdx_rxdb_available(db) - 1;
 	while (dno > 0) {
 		skb = netdev_alloc_skb(priv->ndev, f->m.pktsz + NET_IP_ALIGN);
@@ -1119,14 +1087,12 @@ static void bdx_rx_alloc_skbs(struct bdx_priv *priv, struct rxf_fifo *f)
 	}
 	/*TBD: to do - delayed rxf wptr like in txd */
 	WRITE_REG(priv, f->m.reg_WPTR, f->m.wptr & TXF_WPTR_WR_PTR);
-	RET();
 }
 
 static inline void
 NETIF_RX_MUX(struct bdx_priv *priv, u32 rxd_val1, u16 rxd_vlan,
 	     struct sk_buff *skb)
 {
-	ENTER;
 	DBG("rxdd->flags.bits.vtag=%d\n", GET_RXD_VTAG(rxd_val1));
 	if (GET_RXD_VTAG(rxd_val1)) {
 		DBG("%s: vlan rcv vlan '%x' vtag '%x'\n",
@@ -1146,7 +1112,6 @@ static void bdx_recycle_skb(struct bdx_priv *priv, struct rxd_desc *rxdd)
 	struct rxdb *db;
 	int delta;
 
-	ENTER;
 	DBG("priv=%p rxdd=%p\n", priv, rxdd);
 	f = &priv->rxf_fifo0;
 	db = priv->rxdb;
@@ -1170,7 +1135,6 @@ static void bdx_recycle_skb(struct bdx_priv *priv, struct rxd_desc *rxdd)
 			DBG("wrapped descriptor\n");
 		}
 	}
-	RET();
 }
 
 /**
@@ -1202,7 +1166,6 @@ static int bdx_rx_receive(struct bdx_priv *priv, struct rxd_fifo *f, int budget)
 	u16 len;
 	u16 rxd_vlan;
 
-	ENTER;
 	max_done = budget;
 
 	f->m.wptr = READ_REG(priv, f->m.reg_WPTR) & TXF_WPTR_WR_PTR;
@@ -1292,7 +1255,7 @@ static int bdx_rx_receive(struct bdx_priv *priv, struct rxd_fifo *f, int budget)
 
 	bdx_rx_alloc_skbs(priv, &priv->rxf_fifo0);
 
-	RET(done);
+	return done;
 }
 
 /*************************************************************************
@@ -1597,7 +1560,6 @@ static netdev_tx_t bdx_tx_transmit(struct sk_buff *skb,
 	int len;
 	unsigned long flags;
 
-	ENTER;
 	local_irq_save(flags);
 	spin_lock(&priv->tx_lock);
 
@@ -1699,7 +1661,6 @@ static void bdx_tx_cleanup(struct bdx_priv *priv)
 	struct txdb *db = &priv->txdb;
 	int tx_level = 0;
 
-	ENTER;
 	f->m.wptr = READ_REG(priv, f->m.reg_WPTR) & TXF_WPTR_MASK;
 	BDX_ASSERT(f->m.rptr >= f->m.memsz);	/* started with valid rptr */
 
@@ -1760,7 +1721,6 @@ static void bdx_tx_free_skbs(struct bdx_priv *priv)
 {
 	struct txdb *db = &priv->txdb;
 
-	ENTER;
 	while (db->rptr != db->wptr) {
 		if (likely(db->rptr->len))
 			dma_unmap_page(&priv->pdev->dev, db->rptr->addr.dma,
@@ -1769,13 +1729,11 @@ static void bdx_tx_free_skbs(struct bdx_priv *priv)
 			dev_kfree_skb(db->rptr->addr.skb);
 		bdx_tx_db_inc_rptr(db);
 	}
-	RET();
 }
 
 /* bdx_tx_free - frees all Tx resources */
 static void bdx_tx_free(struct bdx_priv *priv)
 {
-	ENTER;
 	bdx_tx_free_skbs(priv);
 	bdx_fifo_free(priv, &priv->txd_fifo0.m);
 	bdx_fifo_free(priv, &priv->txf_fifo0.m);
@@ -1824,7 +1782,6 @@ static void bdx_tx_push_desc(struct bdx_priv *priv, void *data, int size)
 static void bdx_tx_push_desc_safe(struct bdx_priv *priv, void *data, int size)
 {
 	int timer = 0;
-	ENTER;
 
 	while (size > 0) {
 		/* we substruct 8 because when fifo is full rptr == wptr
@@ -1846,7 +1803,6 @@ static void bdx_tx_push_desc_safe(struct bdx_priv *priv, void *data, int size)
 		size -= avail;
 		data += avail;
 	}
-	RET();
 }
 
 static const struct net_device_ops bdx_netdev_ops = {
@@ -1889,11 +1845,9 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct pci_nic *nic;
 	int err, port;
 
-	ENTER;
-
 	nic = vmalloc(sizeof(*nic));
 	if (!nic)
-		RET(-ENOMEM);
+		return -ENOMEM;
 
     /************** pci *****************/
 	err = pci_enable_device(pdev);
@@ -2044,7 +1998,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		print_eth_id(ndev);
 	}
-	RET(0);
+	return 0;
 
 err_out_free:
 	free_netdev(ndev);
@@ -2057,7 +2011,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_pci:
 	vfree(nic);
 
-	RET(err);
+	return err;
 }
 
 /****************** Ethtool interface *********************/
@@ -2412,8 +2366,6 @@ static void bdx_remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	vfree(nic);
-
-	RET();
 }
 
 static struct pci_driver bdx_pci_driver = {
@@ -2434,19 +2386,16 @@ static void __init print_driver_id(void)
 
 static int __init bdx_module_init(void)
 {
-	ENTER;
 	init_txd_sizes();
 	print_driver_id();
-	RET(pci_register_driver(&bdx_pci_driver));
+	return pci_register_driver(&bdx_pci_driver);
 }
 
 module_init(bdx_module_init);
 
 static void __exit bdx_module_exit(void)
 {
-	ENTER;
 	pci_unregister_driver(&bdx_pci_driver);
-	RET();
 }
 
 module_exit(bdx_module_exit);
diff --git a/drivers/net/ethernet/tehuti/tehuti.h b/drivers/net/ethernet/tehuti/tehuti.h
index 47a2d3e5f8ed..030a7a0f1479 100644
--- a/drivers/net/ethernet/tehuti/tehuti.h
+++ b/drivers/net/ethernet/tehuti/tehuti.h
@@ -534,22 +534,9 @@ struct txd_desc {
 
 #ifdef DEBUG
 
-#define ENTER						\
-do {							\
-	pr_err("%s:%-5d: ENTER\n", __func__, __LINE__); \
-} while (0)
-
-#define RET(args...)					 \
-do {							 \
-	pr_err("%s:%-5d: RETURN\n", __func__, __LINE__); \
-	return args;					 \
-} while (0)
-
 #define DBG(fmt, args...)					\
 	pr_err("%s:%-5d: " fmt, __func__, __LINE__, ## args)
 #else
-#define ENTER do {  } while (0)
-#define RET(args...)   return args
 #define DBG(fmt, args...)			\
 do {						\
 	if (0)					\
-- 
2.43.0


