Return-Path: <netdev+bounces-146478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF329D3903
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ECE282F10
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E841A08CA;
	Wed, 20 Nov 2024 11:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C218EFC1;
	Wed, 20 Nov 2024 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100531; cv=none; b=ZI20q4ITKMeOkxXYAlmoINszsp8bJZOLWvtnoss8p+c15XrnTT4S5I9ZldL2B5/vU1chdf7ZRELesshYLiZwAOHPF1Diu8of+maOZ/dFNLFR871u2GoJQen87qyu8TcPLew03apF41a8e6IrDUQUsG/yx3Z0vSc+EaUmBbTUuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100531; c=relaxed/simple;
	bh=tebh3YRQVaceDXcwR566Ls+FobOp/37/NbdCwioUDN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSgng5rRg4EaWUEYOeTx9TfZS3ORO7ZbejvQcp9M4kjx/TphNdqHVhU918Wm8KaWXZaR7U4jIlVRWrQmgun8cYnqJHL7qziVrjTLt3iF6nImI5eWxF3Y9UoV3umpLgYno+/LkV6iwgzr41PxOD5tM+sJqpsrMrRPdM7Wk9EyYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppdf_1732100206 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:46 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 15/21] motorcomm:yt6801: Implement pci_driver suspend and resume
Date: Wed, 20 Nov 2024 18:56:19 +0800
Message-Id: <20241120105625.22508-16-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the pci_driver suspend function to enable the device to sleep,
and implement the resume function to enable the device to resume operation.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 118 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    |  28 +++++
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  61 +++++++++
 3 files changed, 207 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
index bd3036625..25411f2dd 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -2424,6 +2424,56 @@ static void fxgmac_config_dma_bus(struct fxgmac_pdata *pdata)
 	wr32_mac(pdata, val, DMA_SBMR);
 }
 
+static int fxgmac_pre_powerdown(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+	int ret;
+
+	fxgmac_disable_rx(pdata);
+
+	yt_dbg(pdata, "%s, phy and mac status update\n", __func__);
+
+	if (device_may_wakeup(pdata->dev)) {
+		val = rd32_mem(pdata, EPHY_CTRL);
+		if (val & EPHY_CTRL_STA_LINKUP) {
+			ret = phy_speed_down(pdata->phydev, true);
+			if (ret < 0) {
+				yt_err(pdata, "%s, phy_speed_down err:%d\n", __func__, ret);
+				return ret;
+			}
+
+			ret = phy_read_status(pdata->phydev);
+			if (ret < 0) {
+				yt_err(pdata, "%s, phy_read_status err:%d\n",
+				       __func__, ret);
+				return ret;
+			}
+
+			pdata->phy_speed = pdata->phydev->speed;
+			pdata->phy_duplex = pdata->phydev->duplex;
+			yt_dbg(pdata, "%s, speed :%d, duplex :%d\n", __func__,
+			       pdata->phy_speed, pdata->phy_duplex);
+
+			fxgmac_config_mac_speed(pdata);
+		} else {
+			yt_dbg(pdata, "%s link down, do nothing\n", __func__);
+		}
+	}
+
+	/* After enable OOB_WOL from efuse, mac will loopcheck phy status,
+	 * and lead to panic sometimes. So we should disable it from powerup,
+	 * enable it from power down.
+	 */
+	val = rd32_mem(pdata, OOB_WOL_CTRL);
+	fxgmac_set_bits(&val, OOB_WOL_CTRL_DIS_POS, OOB_WOL_CTRL_DIS_LEN, 0);
+	wr32_mem(pdata, val, OOB_WOL_CTRL);
+	fsleep(2000);
+
+	fxgmac_set_mac_address(pdata, pdata->mac_addr);
+
+	return 0;
+}
+
 static int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
 {
 	u32 stats_pre, stats;
@@ -2458,6 +2508,70 @@ static int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
 	return  -ETIMEDOUT;
 }
 
+static void fxgmac_config_powerdown(struct fxgmac_pdata *pdata,
+				    bool wol)
+{
+	u32 val = 0;
+
+	/* Use default arp offloading feature */
+	fxgmac_update_aoe_ipv4addr(pdata, (u8 *)NULL);
+	fxgmac_enable_arp_offload(pdata);
+	fxgmac_update_ns_offload_ipv6addr(pdata, FXGMAC_NS_IFA_GLOBAL_UNICAST);
+	fxgmac_update_ns_offload_ipv6addr(pdata, FXGMAC_NS_IFA_LOCAL_LINK);
+	fxgmac_enable_ns_offload(pdata);
+	fxgmac_enable_wake_packet_indication(pdata, 1);
+
+	/* Enable MAC Rx TX */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+
+	val = rd32_mem(pdata, LPW_CTRL);
+	fxgmac_set_bits(&val, LPW_CTRL_ASPM_LPW_EN_POS,
+			LPW_CTRL_ASPM_LPW_EN_LEN, 1);
+	wr32_mem(pdata, val, LPW_CTRL);
+
+	/* Set gmac power down */
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_PWRDWN_POS, MAC_PMT_STA_PWRDWN_LEN,
+			1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, MGMT_SIGDET);
+	fxgmac_set_bits(&val, MGMT_SIGDET_POS, MGMT_SIGDET_LEN,
+			MGMT_SIGDET_55MV);
+	wr32_mem(pdata, val, MGMT_SIGDET);
+	fxgmac_phy_clear_interrupt(pdata);
+}
+
+static void fxgmac_config_powerup(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	/* After enable OOB_WOL from efuse, mac will loopcheck phy status,
+	 * and lead to panic sometimes.
+	 * So we should disable it from powerup, enable it from power down.
+	 */
+	val = rd32_mem(pdata, OOB_WOL_CTRL);
+	fxgmac_set_bits(&val, OOB_WOL_CTRL_DIS_POS, OOB_WOL_CTRL_DIS_LEN, 1);
+	wr32_mem(pdata, val, OOB_WOL_CTRL);
+
+	/* Clear wpi mode whether or not waked by WOL, write reset value */
+	val = rd32_mem(pdata, MGMT_WPI_CTRL0);
+	fxgmac_set_bits(&val, MGMT_WPI_CTRL0_WPI_MODE_POS,
+			MGMT_WPI_CTRL0_WPI_MODE_LEN, 0);
+	wr32_mem(pdata, val, MGMT_WPI_CTRL0);
+
+	/* Read pmt_status register to De-assert the pmt_intr_o */
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	/* whether or not waked up by WOL, write reset value */
+	fxgmac_set_bits(&val, MAC_PMT_STA_PWRDWN_POS, MAC_PMT_STA_PWRDWN_LEN,
+			0);
+	/* Write register to synchronized always-on block */
+	wr32_mac(pdata, val, MAC_PMT_STA);
+}
+
 #define FXGMAC_WOL_WAIT_2_MS 2
 
 static void fxgmac_config_wol_wait_time(struct fxgmac_pdata *pdata)
@@ -3262,4 +3376,8 @@ void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
 	hw_ops->enable_wake_pattern = fxgmac_enable_wake_pattern;
 	hw_ops->disable_wake_pattern = fxgmac_disable_wake_pattern;
 
+	/* Power Management */
+	hw_ops->pre_power_down = fxgmac_pre_powerdown;
+	hw_ops->config_power_down = fxgmac_config_powerdown;
+	hw_ops->config_power_up = fxgmac_config_powerup;
 }
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 6a3d1073c..10c103e95 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -986,6 +986,34 @@ static void fxgmac_restart_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
+int fxgmac_net_powerup(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	int ret;
+
+	/* Signal that we are up now */
+	pdata->powerstate = 0;
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_UP, &pdata->powerstate))
+		return 0; /* do nothing if already up */
+
+	ret = fxgmac_start(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s: fxgmac_start err: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Must call it after fxgmac_start,because it will be
+	 * enable in fxgmac_start
+	 */
+	hw_ops->disable_arp_offload(pdata);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, powerstate :%ld.\n", __func__,
+		       pdata->powerstate);
+
+	return 0;
+}
+
 int fxgmac_config_wol(struct fxgmac_pdata *pdata, bool en)
 {
 	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
index b2cd75b5c..860b79d13 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -104,6 +104,62 @@ static void fxgmac_shutdown(struct pci_dev *pcidev)
 		(system_state == SYSTEM_POWER_OFF) ? 1 : 0);
 }
 
+static int fxgmac_suspend(struct device *device)
+{
+	struct fxgmac_pdata *pdata = dev_get_drvdata(device);
+	struct net_device *netdev = pdata->netdev;
+	int ret = 0;
+
+	mutex_lock(&pdata->mutex);
+	if (pdata->dev_state != FXGMAC_DEV_START)
+		goto unlock;
+
+	if (netif_running(netdev)) {
+		ret = __fxgmac_shutdown(to_pci_dev(device), NULL);
+		if (ret < 0)
+			goto unlock;
+	}
+
+	pdata->dev_state = FXGMAC_DEV_SUSPEND;
+unlock:
+	mutex_unlock(&pdata->mutex);
+
+	return ret;
+}
+
+static int fxgmac_resume(struct device *device)
+{
+	struct fxgmac_pdata *pdata = dev_get_drvdata(device);
+	struct net_device *netdev = pdata->netdev;
+	int ret = 0;
+
+	mutex_lock(&pdata->mutex);
+	if (pdata->dev_state != FXGMAC_DEV_SUSPEND)
+		goto unlock;
+
+	pdata->dev_state = FXGMAC_DEV_RESUME;
+	__clear_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate);
+
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		ret = fxgmac_net_powerup(pdata);
+		if (ret < 0) {
+			dev_err(device, "%s, fxgmac_net_powerup err:%d\n",
+				__func__, ret);
+			goto unlock;
+		}
+	}
+
+	netif_device_attach(netdev);
+	rtnl_unlock();
+
+	dev_dbg(device, "%s ok\n", __func__);
+unlock:
+	mutex_unlock(&pdata->mutex);
+
+	return ret;
+}
+
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -114,11 +170,16 @@ static const struct pci_device_id fxgmac_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
 
+static const struct dev_pm_ops fxgmac_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(fxgmac_suspend, fxgmac_resume)
+};
+
 static struct pci_driver fxgmac_pci_driver = {
 	.name		= FXGMAC_DRV_NAME,
 	.id_table	= fxgmac_pci_tbl,
 	.probe		= fxgmac_probe,
 	.remove		= fxgmac_remove,
+	.driver.pm	= pm_ptr(&fxgmac_pm_ops),
 	.shutdown	= fxgmac_shutdown,
 };
 
-- 
2.34.1


