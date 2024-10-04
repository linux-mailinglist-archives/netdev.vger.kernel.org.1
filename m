Return-Path: <netdev+bounces-131940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D315699001A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BDAB243AD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034A155306;
	Fri,  4 Oct 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wnl81IXK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AB15531A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034903; cv=none; b=q0g+PENQPHexqNBqkvGz+Km6+yrvwo/Edb+wutZ1D5+xsBFWvsb59Ap4lU2CE5ywISXG6smGwr+5eKCw8II5xaupErw6SHcoF+uKpfrN5Nv8WO05NthDSST+4KSJ1DG99HLONl8+iHhmaiOfSovgrI0LJclGfyUVSjztD9MUMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034903; c=relaxed/simple;
	bh=zpd26k1P+QnupDOHznzUbsl9phnqQioLls4J4OLmKKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6DUevgelYd4I8J5w7+kKs9pm/rtQkmUk5myEo70baHRnCoHRKG5H5gEYcYlEbl/g8SS/VBoPBrRfxykQSQ4AlIBFTWP6zuo7y88sKNMMmobBDfdRDLIHUx/whu4jT6qJugsBD+83xJcdtnluMEyUZNpSrgfr38bJ2z+EXDbtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wnl81IXK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034901; x=1759570901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zpd26k1P+QnupDOHznzUbsl9phnqQioLls4J4OLmKKE=;
  b=Wnl81IXKfynGtEFvuiss5iN5BtQ4fz7x9U4Cw/tbd+osc5oF+CNojNCf
   7IsWAxdj2kQIPa29WBaUOal3DE2ZtltDk8zQ4HZOPbalrLic3vuhWWfC/
   9sk63M4dW8iLmCFvmr++6l6kfg503PnU4rAdqe4etXBcqhoNX6WEOxI3L
   ItA4NQ0T2JKmBppLlQF9nWX9XYv9NZ0NuI6yIAIJQqW/AHYcKbITv+hOh
   Vn9Of6EWdOWWX4LdnM5GRftRBlddKWhf5KLunHNAgHdRCY9q+D3L51aQD
   2dLyB+B/09bKRft9/ckFTLRDFr7c4Ig+k+eQ5vSt7qK8D2il8zIqu4Ar2
   Q==;
X-CSE-ConnectionGUID: 3P0zDalOSESgmgK5SGiJpA==
X-CSE-MsgGUID: Ea93zHFXSXCVhe/oGEqZ2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656259"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656259"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:40 -0700
X-CSE-ConnectionGUID: JS6/8aV/QnCOkzbQCd+mpA==
X-CSE-MsgGUID: XU6yk/IZSjGyHaa9LIDq7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975095"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:38 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id EFACF120C57;
	Fri,  4 Oct 2024 12:41:33 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoX-000Tch-37;
	Fri, 04 Oct 2024 12:41:33 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH 30/51] net: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:33 +0300
Message-Id: <20241004094133.113861-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/net/ethernet/cadence/macb_main.c    | 10 +--
 drivers/net/ethernet/freescale/fec_main.c   | 16 ++---
 drivers/net/ethernet/renesas/ravb_main.c    |  8 +--
 drivers/net/ethernet/ti/davinci_mdio.c      | 14 ++--
 drivers/net/ipa/ipa_interrupt.c             |  2 +-
 drivers/net/ipa/ipa_main.c                  |  2 +-
 drivers/net/ipa/ipa_modem.c                 |  8 +--
 drivers/net/ipa/ipa_smp2p.c                 |  4 +-
 drivers/net/ipa/ipa_uc.c                    |  4 +-
 drivers/net/wireless/ath/wil6210/pm.c       |  2 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c    |  6 +-
 drivers/net/wireless/ti/wlcore/cmd.c        |  2 +-
 drivers/net/wireless/ti/wlcore/debugfs.c    | 22 +++----
 drivers/net/wireless/ti/wlcore/main.c       | 72 ++++++++++-----------
 drivers/net/wireless/ti/wlcore/scan.c       |  2 +-
 drivers/net/wireless/ti/wlcore/sysfs.c      |  2 +-
 drivers/net/wireless/ti/wlcore/testmode.c   |  4 +-
 drivers/net/wireless/ti/wlcore/tx.c         |  2 +-
 drivers/net/wireless/ti/wlcore/vendor_cmd.c |  6 +-
 drivers/net/wwan/qcom_bam_dmux.c            |  4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c      |  6 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c  |  6 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c  |  4 +-
 23 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f06babec04a0..929ac771d5c3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -364,7 +364,7 @@ static int macb_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 
 mdio_read_exit:
 	pm_runtime_mark_last_busy(&bp->pdev->dev);
-	pm_runtime_put_autosuspend(&bp->pdev->dev);
+	__pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
 }
@@ -410,7 +410,7 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int mii_id, int devad,
 
 mdio_read_exit:
 	pm_runtime_mark_last_busy(&bp->pdev->dev);
-	pm_runtime_put_autosuspend(&bp->pdev->dev);
+	__pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
 }
@@ -442,7 +442,7 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 
 mdio_write_exit:
 	pm_runtime_mark_last_busy(&bp->pdev->dev);
-	pm_runtime_put_autosuspend(&bp->pdev->dev);
+	__pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
 }
@@ -488,7 +488,7 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 
 mdio_write_exit:
 	pm_runtime_mark_last_busy(&bp->pdev->dev);
-	pm_runtime_put_autosuspend(&bp->pdev->dev);
+	__pm_runtime_put_autosuspend(&bp->pdev->dev);
 mdio_pm_exit:
 	return status;
 }
@@ -5180,7 +5180,7 @@ static int macb_probe(struct platform_device *pdev)
 		    dev->base_addr, dev->irq, dev->dev_addr);
 
 	pm_runtime_mark_last_busy(&bp->pdev->dev);
-	pm_runtime_put_autosuspend(&bp->pdev->dev);
+	__pm_runtime_put_autosuspend(&bp->pdev->dev);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 31ebf6a4f973..493bfc7e44ee 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2166,7 +2166,7 @@ static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 
 out:
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -2215,7 +2215,7 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
 
 out:
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -2247,7 +2247,7 @@ static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 		netdev_err(fep->netdev, "MDIO write timeout\n");
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -2291,7 +2291,7 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
 
 out:
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -2773,7 +2773,7 @@ static void fec_enet_get_regs(struct net_device *ndev,
 	}
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 }
 
 static int fec_enet_get_ts_info(struct net_device *ndev,
@@ -3557,7 +3557,7 @@ fec_enet_open(struct net_device *ndev)
 	fec_enet_clk_enable(ndev, false);
 clk_enable:
 	pm_runtime_mark_last_busy(&fep->pdev->dev);
-	pm_runtime_put_autosuspend(&fep->pdev->dev);
+	__pm_runtime_put_autosuspend(&fep->pdev->dev);
 	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
 	return ret;
 }
@@ -3588,7 +3588,7 @@ fec_enet_close(struct net_device *ndev)
 
 	pinctrl_pm_select_sleep_state(&fep->pdev->dev);
 	pm_runtime_mark_last_busy(&fep->pdev->dev);
-	pm_runtime_put_autosuspend(&fep->pdev->dev);
+	__pm_runtime_put_autosuspend(&fep->pdev->dev);
 
 	fec_enet_free_buffers(ndev);
 
@@ -4535,7 +4535,7 @@ fec_probe(struct platform_device *pdev)
 	INIT_WORK(&fep->tx_timeout_work, fec_enet_timeout_work);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d2a6518532f3..14c4c2070c2c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1981,7 +1981,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
 out_rpm_put:
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 out_napi_off:
 	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
@@ -2378,7 +2378,7 @@ static int ravb_close(struct net_device *ndev)
 		return error;
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -3081,7 +3081,7 @@ static int ravb_probe(struct platform_device *pdev)
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
@@ -3260,7 +3260,7 @@ static int ravb_resume(struct device *dev)
 out_rpm_put:
 	if (!priv->wol_enabled) {
 		pm_runtime_mark_last_busy(dev);
-		pm_runtime_put_autosuspend(dev);
+		__pm_runtime_put_autosuspend(dev);
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 8e07d4a1b6ba..77893fc41a76 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -235,7 +235,7 @@ static int davinci_mdiobb_read_c22(struct mii_bus *bus, int phy, int reg)
 	ret = mdiobb_read_c22(bus, phy, reg);
 
 	pm_runtime_mark_last_busy(bus->parent);
-	pm_runtime_put_autosuspend(bus->parent);
+	__pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
 }
@@ -252,7 +252,7 @@ static int davinci_mdiobb_write_c22(struct mii_bus *bus, int phy, int reg,
 	ret = mdiobb_write_c22(bus, phy, reg, val);
 
 	pm_runtime_mark_last_busy(bus->parent);
-	pm_runtime_put_autosuspend(bus->parent);
+	__pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
 }
@@ -269,7 +269,7 @@ static int davinci_mdiobb_read_c45(struct mii_bus *bus, int phy, int devad,
 	ret = mdiobb_read_c45(bus, phy, devad, reg);
 
 	pm_runtime_mark_last_busy(bus->parent);
-	pm_runtime_put_autosuspend(bus->parent);
+	__pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
 }
@@ -286,7 +286,7 @@ static int davinci_mdiobb_write_c45(struct mii_bus *bus, int phy, int devad,
 	ret = mdiobb_write_c45(bus, phy, devad, reg, val);
 
 	pm_runtime_mark_last_busy(bus->parent);
-	pm_runtime_put_autosuspend(bus->parent);
+	__pm_runtime_put_autosuspend(bus->parent);
 
 	return ret;
 }
@@ -333,7 +333,7 @@ static int davinci_mdio_common_reset(struct davinci_mdio_data *data)
 
 done:
 	pm_runtime_mark_last_busy(data->dev);
-	pm_runtime_put_autosuspend(data->dev);
+	__pm_runtime_put_autosuspend(data->dev);
 
 	return 0;
 }
@@ -442,7 +442,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 	}
 
 	pm_runtime_mark_last_busy(data->dev);
-	pm_runtime_put_autosuspend(data->dev);
+	__pm_runtime_put_autosuspend(data->dev);
 	return ret;
 }
 
@@ -479,7 +479,7 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 	}
 
 	pm_runtime_mark_last_busy(data->dev);
-	pm_runtime_put_autosuspend(data->dev);
+	__pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
 }
diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 245a06997055..737ffff14770 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -150,7 +150,7 @@ static irqreturn_t ipa_isr_thread(int irq, void *dev_id)
 	}
 out_power_put:
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 5f3dd5a2dcf4..bdb5e7b6cf29 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -912,7 +912,7 @@ static int ipa_probe(struct platform_device *pdev)
 		goto err_deconfig;
 done:
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/drivers/net/ipa/ipa_modem.c b/drivers/net/ipa/ipa_modem.c
index 8fe0d0e1a00f..17187676edae 100644
--- a/drivers/net/ipa/ipa_modem.c
+++ b/drivers/net/ipa/ipa_modem.c
@@ -72,7 +72,7 @@ static int ipa_open(struct net_device *netdev)
 	netif_start_queue(netdev);
 
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
@@ -103,7 +103,7 @@ static int ipa_stop(struct net_device *netdev)
 	ipa_endpoint_disable_one(priv->tx);
 out_power_put:
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -176,7 +176,7 @@ ipa_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ret = ipa_endpoint_skb_tx(endpoint, skb);
 
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	if (ret) {
 		if (ret != -E2BIG)
@@ -433,7 +433,7 @@ static void ipa_modem_crashed(struct ipa *ipa)
 
 out_power_put:
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 }
 
 static int ipa_modem_notify(struct notifier_block *nb, unsigned long action,
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index fcaadd111a8a..6339a1b580f2 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -172,7 +172,7 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 
 out_power_put:
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 
 	return IRQ_HANDLED;
 }
@@ -214,7 +214,7 @@ static void ipa_smp2p_power_release(struct ipa *ipa)
 		return;
 
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 	ipa->smp2p->power_on = false;
 }
 
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
index 2963db83ab6b..256e6bad66c4 100644
--- a/drivers/net/ipa/ipa_uc.c
+++ b/drivers/net/ipa/ipa_uc.c
@@ -159,7 +159,7 @@ static void ipa_uc_response_hdlr(struct ipa *ipa)
 			ipa->uc_loaded = true;
 			ipa_power_retention(ipa, true);
 			pm_runtime_mark_last_busy(dev);
-			(void)pm_runtime_put_autosuspend(dev);
+			(void) __pm_runtime_put_autosuspend(dev);
 			ipa->uc_powered = false;
 		} else {
 			dev_warn(dev, "unexpected init_completed response\n");
@@ -204,7 +204,7 @@ void ipa_uc_deconfig(struct ipa *ipa)
 		return;
 
 	pm_runtime_mark_last_busy(dev);
-	(void)pm_runtime_put_autosuspend(dev);
+	(void) __pm_runtime_put_autosuspend(dev);
 }
 
 /* Take a proxy power reference for the microcontroller */
diff --git a/drivers/net/wireless/ath/wil6210/pm.c b/drivers/net/wireless/ath/wil6210/pm.c
index f521af575e9b..eecafeb2ba90 100644
--- a/drivers/net/wireless/ath/wil6210/pm.c
+++ b/drivers/net/wireless/ath/wil6210/pm.c
@@ -459,5 +459,5 @@ void wil_pm_runtime_put(struct wil6210_priv *wil)
 	struct device *dev = wil_to_dev(wil);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 }
diff --git a/drivers/net/wireless/ti/wl18xx/debugfs.c b/drivers/net/wireless/ti/wl18xx/debugfs.c
index 80fbf740fe6d..33b780cd153a 100644
--- a/drivers/net/wireless/ti/wl18xx/debugfs.c
+++ b/drivers/net/wireless/ti/wl18xx/debugfs.c
@@ -273,7 +273,7 @@ static ssize_t radar_detection_write(struct file *file,
 		count = ret;
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -313,7 +313,7 @@ static ssize_t dynamic_fw_traces_write(struct file *file,
 		count = ret;
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -375,7 +375,7 @@ static ssize_t radar_debug_mode_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index cd8ad0fe59cc..1a1444fc0ff0 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -214,7 +214,7 @@ int wlcore_cmd_wait_for_event_or_timeout(struct wl1271 *wl,
 
 out:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 free_vector:
 	kfree(events_vector);
 	return ret;
diff --git a/drivers/net/wireless/ti/wlcore/debugfs.c b/drivers/net/wireless/ti/wlcore/debugfs.c
index eb3d3f0e0b4d..4e7444066dd0 100644
--- a/drivers/net/wireless/ti/wlcore/debugfs.c
+++ b/drivers/net/wireless/ti/wlcore/debugfs.c
@@ -64,7 +64,7 @@ void wl1271_debugfs_update_stats(struct wl1271 *wl)
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -114,7 +114,7 @@ static void chip_op_handler(struct wl1271 *wl, unsigned long value,
 	chip_op(wl);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 }
 
 #define WL12XX_CONF_DEBUGFS(param, conf_sub_struct,			\
@@ -288,7 +288,7 @@ static ssize_t dynamic_ps_timeout_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -358,7 +358,7 @@ static ssize_t forced_ps_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -831,7 +831,7 @@ static ssize_t rx_streaming_interval_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -887,7 +887,7 @@ static ssize_t rx_streaming_always_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -935,7 +935,7 @@ static ssize_t beacon_filtering_write(struct file *file,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -1016,7 +1016,7 @@ static ssize_t sleep_auth_write(struct file *file,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return count;
@@ -1091,7 +1091,7 @@ static ssize_t dev_mem_read(struct file *file,
 
 part_err:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 skip_read:
 	mutex_unlock(&wl->mutex);
@@ -1173,7 +1173,7 @@ static ssize_t dev_mem_write(struct file *file, const char __user *user_buf,
 
 part_err:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 skip_write:
 	mutex_unlock(&wl->mutex);
@@ -1248,7 +1248,7 @@ static ssize_t fw_logger_write(struct file *file,
 	ret = wl12xx_cmd_config_fwlog(wl);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 0c77b8524160..09f311dee27f 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -155,7 +155,7 @@ static void wl1271_rx_streaming_enable_work(struct work_struct *work)
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -182,7 +182,7 @@ static void wl1271_rx_streaming_disable_work(struct work_struct *work)
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -234,7 +234,7 @@ static void wlcore_rc_update_work(struct work_struct *work)
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -711,7 +711,7 @@ static int wlcore_irq_locked(struct wl1271 *wl)
 
 err_ret:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	return ret;
@@ -1047,7 +1047,7 @@ static void wl1271_recovery_work(struct work_struct *work)
 
 	wlcore_op_stop_locked(wl);
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 	ieee80211_restart_hw(wl->hw);
 
@@ -1943,7 +1943,7 @@ static int __maybe_unused wl1271_op_resume(struct ieee80211_hw *hw)
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	wl->wow_enabled = false;
@@ -2131,7 +2131,7 @@ static void wlcore_channel_switch_work(struct work_struct *work)
 	wl12xx_cmd_stop_channel_switch(wl, wlvif);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -2201,7 +2201,7 @@ static void wlcore_pending_auth_complete_work(struct work_struct *work)
 	wlcore_update_inconn_sta(wl, wlvif, NULL, false);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -2694,7 +2694,7 @@ static int wl1271_op_add_interface(struct ieee80211_hw *hw,
 		wl->sta_count++;
 out:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out_unlock:
 	mutex_unlock(&wl->mutex);
 
@@ -2774,7 +2774,7 @@ static void __wl1271_op_remove_interface(struct wl1271 *wl,
 		}
 
 		pm_runtime_mark_last_busy(wl->dev);
-		pm_runtime_put_autosuspend(wl->dev);
+		__pm_runtime_put_autosuspend(wl->dev);
 	}
 deinit:
 	wl12xx_tx_reset_wlvif(wl, wlvif);
@@ -3200,7 +3200,7 @@ static int wl1271_op_config(struct ieee80211_hw *hw, u32 changed)
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -3315,7 +3315,7 @@ static void wl1271_op_configure_filter(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -3531,7 +3531,7 @@ static int wlcore_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	ret = wlcore_hw_set_key(wl, cmd, vif, sta, key_conf);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out_wake_queues:
 	if (might_change_spare)
@@ -3695,7 +3695,7 @@ static void wl1271_op_set_default_key_idx(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out_unlock:
 	mutex_unlock(&wl->mutex);
@@ -3724,7 +3724,7 @@ void wlcore_regdomain_config(struct wl1271 *wl)
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -3772,7 +3772,7 @@ static int wl1271_op_hw_scan(struct ieee80211_hw *hw,
 	ret = wlcore_scan(hw->priv, vif, ssid, len, req);
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -3823,7 +3823,7 @@ static void wl1271_op_cancel_hw_scan(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -3860,7 +3860,7 @@ static int wl1271_op_sched_scan_start(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return ret;
@@ -3887,7 +3887,7 @@ static int wl1271_op_sched_scan_stop(struct ieee80211_hw *hw,
 	wl->ops->sched_scan_stop(wl, wlvif);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -3915,7 +3915,7 @@ static int wl1271_op_set_frag_threshold(struct ieee80211_hw *hw, u32 value)
 		wl1271_warning("wl1271_op_set_frag_threshold failed: %d", ret);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -3946,7 +3946,7 @@ static int wl1271_op_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 			wl1271_warning("set rts threshold failed: %d", ret);
 	}
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -4712,7 +4712,7 @@ static void wl1271_op_bss_info_changed(struct ieee80211_hw *hw,
 		wl1271_bss_info_changed_sta(wl, vif, bss_conf, changed);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -4777,7 +4777,7 @@ static void wlcore_op_change_chanctx(struct ieee80211_hw *hw,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -4826,7 +4826,7 @@ static int wlcore_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -4869,7 +4869,7 @@ static void wlcore_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -4939,7 +4939,7 @@ wlcore_op_switch_vif_chanctx(struct ieee80211_hw *hw,
 	}
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -4993,7 +4993,7 @@ static int wl1271_op_conf_tx(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -5027,7 +5027,7 @@ static u64 wl1271_op_get_tsf(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -5340,7 +5340,7 @@ static int wl12xx_op_sta_state(struct ieee80211_hw *hw,
 	ret = wl12xx_update_sta_state(wl, wlvif, sta, old_state, new_state);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	if (new_state < old_state)
@@ -5465,7 +5465,7 @@ static int wl1271_op_ampdu_action(struct ieee80211_hw *hw,
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -5509,7 +5509,7 @@ static int wl12xx_set_bitrate_mask(struct ieee80211_hw *hw,
 		ret = wl1271_acx_sta_rate_policies(wl, wlvif);
 
 		pm_runtime_mark_last_busy(wl->dev);
-		pm_runtime_put_autosuspend(wl->dev);
+		__pm_runtime_put_autosuspend(wl->dev);
 	}
 out:
 	mutex_unlock(&wl->mutex);
@@ -5564,7 +5564,7 @@ static void wl12xx_op_channel_switch(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
@@ -5643,7 +5643,7 @@ static void wlcore_op_channel_switch_beacon(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
@@ -5697,7 +5697,7 @@ static int wlcore_op_remain_on_channel(struct ieee80211_hw *hw,
 				     msecs_to_jiffies(duration));
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 	return ret;
@@ -5746,7 +5746,7 @@ static int wlcore_roc_completed(struct wl1271 *wl)
 	ret = __wlcore_roc_completed(wl);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -5836,7 +5836,7 @@ static void wlcore_op_sta_statistics(struct ieee80211_hw *hw,
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/scan.c b/drivers/net/wireless/ti/wlcore/scan.c
index b414305acc32..ee16dc1c7da3 100644
--- a/drivers/net/wireless/ti/wlcore/scan.c
+++ b/drivers/net/wireless/ti/wlcore/scan.c
@@ -70,7 +70,7 @@ void wl1271_scan_complete_work(struct work_struct *work)
 	wlcore_cmd_regdomain_config_locked(wl);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
 	ieee80211_scan_completed(wl->hw, &info);
 
diff --git a/drivers/net/wireless/ti/wlcore/sysfs.c b/drivers/net/wireless/ti/wlcore/sysfs.c
index c07acfcbbd9c..52fa40b5b8e7 100644
--- a/drivers/net/wireless/ti/wlcore/sysfs.c
+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
@@ -59,7 +59,7 @@ static ssize_t bt_coex_state_store(struct device *dev,
 
 	wl1271_acx_sg_enable(wl, wl->sg_enabled);
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 
  out:
 	mutex_unlock(&wl->mutex);
diff --git a/drivers/net/wireless/ti/wlcore/testmode.c b/drivers/net/wireless/ti/wlcore/testmode.c
index 3f338b8096c7..9b2c5ae7aef3 100644
--- a/drivers/net/wireless/ti/wlcore/testmode.c
+++ b/drivers/net/wireless/ti/wlcore/testmode.c
@@ -128,7 +128,7 @@ static int wl1271_tm_cmd_test(struct wl1271 *wl, struct nlattr *tb[])
 
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -193,7 +193,7 @@ static int wl1271_tm_cmd_interrogate(struct wl1271 *wl, struct nlattr *tb[])
 	kfree(cmd);
 out_sleep:
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 464587d16ab2..8151818722d7 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -864,7 +864,7 @@ void wl1271_tx_work(struct work_struct *work)
 	}
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 }
diff --git a/drivers/net/wireless/ti/wlcore/vendor_cmd.c b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
index e4269e2b0098..f9bdbf2f387b 100644
--- a/drivers/net/wireless/ti/wlcore/vendor_cmd.c
+++ b/drivers/net/wireless/ti/wlcore/vendor_cmd.c
@@ -61,7 +61,7 @@ wlcore_vendor_cmd_smart_config_start(struct wiphy *wiphy,
 			nla_get_u32(tb[WLCORE_VENDOR_ATTR_GROUP_ID]));
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -93,7 +93,7 @@ wlcore_vendor_cmd_smart_config_stop(struct wiphy *wiphy,
 	ret = wlcore_smart_config_stop(wl);
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
@@ -141,7 +141,7 @@ wlcore_vendor_cmd_smart_config_set_group_key(struct wiphy *wiphy,
 			nla_data(tb[WLCORE_VENDOR_ATTR_GROUP_KEY]));
 
 	pm_runtime_mark_last_busy(wl->dev);
-	pm_runtime_put_autosuspend(wl->dev);
+	__pm_runtime_put_autosuspend(wl->dev);
 out:
 	mutex_unlock(&wl->mutex);
 
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index 5dcb9a84a12e..59f6cacf2280 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -163,7 +163,7 @@ static void bam_dmux_tx_done(struct bam_dmux_skb_dma *skb_dma)
 	unsigned long flags;
 
 	pm_runtime_mark_last_busy(dmux->dev);
-	pm_runtime_put_autosuspend(dmux->dev);
+	__pm_runtime_put_autosuspend(dmux->dev);
 
 	if (skb_dma->addr)
 		bam_dmux_skb_dma_unmap(skb_dma, DMA_TO_DEVICE);
@@ -398,7 +398,7 @@ static void bam_dmux_tx_wakeup_work(struct work_struct *work)
 
 out:
 	pm_runtime_mark_last_busy(dmux->dev);
-	pm_runtime_put_autosuspend(dmux->dev);
+	__pm_runtime_put_autosuspend(dmux->dev);
 }
 
 static const struct net_device_ops bam_dmux_ops = {
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index 97163e1e5783..16f0708c8c54 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -251,7 +251,7 @@ static void t7xx_cldma_rx_done(struct work_struct *work)
 	t7xx_cldma_hw_irq_en_txrx(&md_ctrl->hw_info, queue->index, MTK_RX);
 	t7xx_cldma_hw_irq_en_eq(&md_ctrl->hw_info, queue->index, MTK_RX);
 	pm_runtime_mark_last_busy(md_ctrl->dev);
-	pm_runtime_put_autosuspend(md_ctrl->dev);
+	__pm_runtime_put_autosuspend(md_ctrl->dev);
 }
 
 static int t7xx_cldma_gpd_tx_collect(struct cldma_queue *queue)
@@ -363,7 +363,7 @@ static void t7xx_cldma_tx_done(struct work_struct *work)
 	spin_unlock_irqrestore(&md_ctrl->cldma_lock, flags);
 
 	pm_runtime_mark_last_busy(md_ctrl->dev);
-	pm_runtime_put_autosuspend(md_ctrl->dev);
+	__pm_runtime_put_autosuspend(md_ctrl->dev);
 }
 
 static void t7xx_cldma_ring_free(struct cldma_ctrl *md_ctrl,
@@ -988,7 +988,7 @@ int t7xx_cldma_send_skb(struct cldma_ctrl *md_ctrl, int qno, struct sk_buff *skb
 allow_sleep:
 	t7xx_pci_enable_sleep(md_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(md_ctrl->dev);
-	pm_runtime_put_autosuspend(md_ctrl->dev);
+	__pm_runtime_put_autosuspend(md_ctrl->dev);
 	return ret;
 }
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 210d84c67ef9..9329d7a04814 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -840,7 +840,7 @@ int t7xx_dpmaif_napi_rx_poll(struct napi_struct *napi, const int budget)
 
 	if (!rxq->que_started) {
 		atomic_set(&rxq->rx_processing, 0);
-		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
+		__pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
 		dev_err(rxq->dpmaif_ctrl->dev, "Work RXQ: %d has not been started\n", rxq->index);
 		return work_done;
 	}
@@ -877,7 +877,7 @@ int t7xx_dpmaif_napi_rx_poll(struct napi_struct *napi, const int budget)
 		t7xx_dpmaif_dlq_unmask_rx_done(&rxq->dpmaif_ctrl->hw_info, rxq->index);
 		t7xx_pci_enable_sleep(rxq->dpmaif_ctrl->t7xx_dev);
 		pm_runtime_mark_last_busy(rxq->dpmaif_ctrl->dev);
-		pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
+		__pm_runtime_put_autosuspend(rxq->dpmaif_ctrl->dev);
 		atomic_set(&rxq->rx_processing, 0);
 	} else {
 		t7xx_dpmaif_clr_ip_busy_sts(&rxq->dpmaif_ctrl->hw_info);
@@ -1078,7 +1078,7 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
 
 	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
-	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+	__pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
 
 int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 8dab025a088a..de8f4284ee28 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -186,7 +186,7 @@ static void t7xx_dpmaif_tx_done(struct work_struct *work)
 
 	t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 	pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
-	pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+	__pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 }
 
 static void t7xx_setup_msg_drb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int q_num,
@@ -469,7 +469,7 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 		t7xx_do_tx_hw_push(dpmaif_ctrl);
 		t7xx_pci_enable_sleep(dpmaif_ctrl->t7xx_dev);
 		pm_runtime_mark_last_busy(dpmaif_ctrl->dev);
-		pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
+		__pm_runtime_put_autosuspend(dpmaif_ctrl->dev);
 	}
 
 	return 0;
-- 
2.39.5


