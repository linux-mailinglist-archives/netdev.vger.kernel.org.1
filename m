Return-Path: <netdev+bounces-224573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C53B864B8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DD5165076
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4131AF09;
	Thu, 18 Sep 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j/hXBbFz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFBA31D371
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217221; cv=none; b=sW/GBKe4dbv2DDki6ebfb72X01en43h4nPxR/pdz8YpvycTLXSOIVrBp3C+z8HcWjK2jFavvh0uiNk/kcLQB5Fs+nqOPUiRF2/xoWt1xfIn5+/a7SVXXowg5+3BeJkHMnfeBEmd6bbgv4VwdcFsd8U5fKcrwIf2vMgqiEoh5GD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217221; c=relaxed/simple;
	bh=SMKi8vRtZISjSaAItusaJyXWMyw6yJxt8M3ybGbtwXI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hNiGPQ1P1/GmYG3sFzybZV63GOEG5Ys9QgJQu+TxRbbRaZFBT+6waymSf186LKwPxok0IVWiIVLkCm/XhvJB1dwjFXpxJzy5PN4/c9Wb7ad69kYKTq00DaGiNEqFI5PSdomjCe2sJHpNRgp4hpxpcsG0NZ4r7Uju8ARWZNwoS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j/hXBbFz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dSg+h9q1Zmhb5qxd6CBB7i7uUIwEdLYd7aQ0wjteasA=; b=j/hXBbFziGeRYsQ+1O9ieOpBoC
	YrDQmRAl5AqTu9g5IPB0pmHl+TpjzwtInsjbqF2hTQdrQaesmGbarBsj9EWXuYgrZDtDYn4pCUnCU
	GkE8BkZkTshHzSK+lyRFHKCcjr5Gdf0gMxfJ5uC0yYvpWPR8jA4Wr6S/c9K1bMwtAdi0ohrl1FdZf
	ytGC3V0ZyeH4BJdAhEd99QsisSoI8RR0IkW5WW8fhGguCw9yvtxB8lTMdNDgRvqXpY7oQvusMTdo6
	kzQObFWHF89bDYaLlNNOw84eBXxC6hygdSfoLT8lljnuJgiysHvJQWboMni8elOkcNkLcz6haMYIH
	o4sOtsgQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46312 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIcA-000000001da-1yQN;
	Thu, 18 Sep 2025 18:40:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIc9-00000006n0l-34jZ;
	Thu, 18 Sep 2025 18:40:13 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 16/20] net: dsa: mv88e6xxx: add beginnings of
 generic Marvell PTP ts layer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIc9-00000006n0l-34jZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:13 +0100

Initialise the generic Marvell PTP per-port timestamping layer, and
use it to provide the get_ts_info() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c     |   4 +
 drivers/net/dsa/mv88e6xxx/chip.h     |   2 +
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 188 ++++++++++++++++++++++++---
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |   6 +
 4 files changed, 182 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ed170a6b0672..fcb7b542bb27 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4113,6 +4113,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 		err = mv88e6xxx_ptp_setup_unlocked(chip);
 		if (err)
 			goto out_hwtstamp;
+
+		err = mv88e6xxx_hwtstamp_setup_unlocked(chip);
+		if (err)
+			goto out_hwtstamp;
 	}
 
 	/* Have to be called without holding the register lock, since
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 29543f9312bd..a297b8867225 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -424,6 +424,8 @@ struct mv88e6xxx_chip {
 
 	/* Per-port timestamping resources. */
 	struct mv88e6xxx_port_hwtstamp port_hwtstamp[DSA_MAX_PORTS];
+	struct marvell_ts ptp_ts[DSA_MAX_PORTS];
+	struct marvell_ts_caps ptp_caps;
 
 	/* Array of port structures. */
 	struct mv88e6xxx_port ports[DSA_MAX_PORTS];
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index dc92381d5c07..3e6a0481fc19 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -21,21 +21,37 @@
 static int mv88e6xxx_port_ptp_read(struct mv88e6xxx_chip *chip, int port,
 				   int addr, u16 *data, int len)
 {
+	int err;
+
 	if (!chip->info->ops->avb_ops->port_ptp_read)
 		return -EOPNOTSUPP;
 
-	return chip->info->ops->avb_ops->port_ptp_read(chip, port, addr,
+	err = chip->info->ops->avb_ops->port_ptp_read(chip, port, addr,
 						       data, len);
+
+	dev_printk(KERN_DEBUG,
+		   chip->dev, "%s: port=%d addr=%d, data[0]=%04x len=%d (%d)\n",
+		 __func__, port, addr, data[0], len, err);
+
+	return err;
 }
 
 static int mv88e6xxx_port_ptp_write(struct mv88e6xxx_chip *chip, int port,
 				    int addr, u16 data)
 {
+	int err;
+
 	if (!chip->info->ops->avb_ops->port_ptp_write)
 		return -EOPNOTSUPP;
 
-	return chip->info->ops->avb_ops->port_ptp_write(chip, port, addr,
+	err = chip->info->ops->avb_ops->port_ptp_write(chip, port, addr,
 							data);
+
+	dev_printk(KERN_DEBUG,
+		   chip->dev, "%s: port=%d addr=%d data=%04x (%d)\n",
+		 __func__, port, addr, data, err);
+
+	return err;
 }
 
 static int mv88e6xxx_ptp_write(struct mv88e6xxx_chip *chip, int addr,
@@ -66,24 +82,14 @@ static int mv88e6xxx_ptp_read(struct mv88e6xxx_chip *chip, int addr,
 int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info)
 {
-	const struct mv88e6xxx_ptp_ops *ptp_ops;
 	struct mv88e6xxx_chip *chip;
 
 	chip = ds->priv;
-	ptp_ops = chip->info->ops->ptp_ops;
 
 	if (!chip->info->ptp_support)
 		return -EOPNOTSUPP;
 
-	info->so_timestamping =
-		SOF_TIMESTAMPING_TX_HARDWARE |
-		SOF_TIMESTAMPING_RX_HARDWARE |
-		SOF_TIMESTAMPING_RAW_HARDWARE;
-	info->phc_index = marvell_tai_ptp_clock_index(chip->tai);
-	info->tx_types =
-		(1 << HWTSTAMP_TX_OFF) |
-		(1 << HWTSTAMP_TX_ON);
-	info->rx_filters = ptp_ops->rx_filters;
+	marvell_ts_info(&chip->ptp_ts[port], info);
 
 	return 0;
 }
@@ -439,20 +445,31 @@ long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip)
 {
 	struct dsa_switch *ds = chip->ds;
 	struct mv88e6xxx_port_hwtstamp *ps;
-	int i, restart = 0;
+	long ret, delay = -1;
+	int i;
 
 	for (i = 0; i < ds->num_ports; i++) {
 		if (!dsa_is_user_port(ds, i))
 			continue;
 
 		ps = &chip->port_hwtstamp[i];
-		if (test_bit(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state))
-			restart |= mv88e6xxx_txtstamp_work(chip, ps);
+		if (test_bit(MV88E6XXX_HWTSTAMP_TX_IN_PROGRESS, &ps->state) &&
+		    mv88e6xxx_txtstamp_work(chip, ps))
+			delay = 1;
 
 		mv88e6xxx_rxtstamp_work(chip, ps);
 	}
 
-	return restart ? 1 : -1;
+	for (i = 0; i < ds->num_ports; i++) {
+		if (!dsa_is_user_port(ds, i))
+			continue;
+
+		ret = marvell_ts_aux_work(&chip->ptp_ts[i]);
+		if (ret >= 0 && (delay == -1 || delay > ret))
+			delay = ret;
+	}
+
+	return delay;
 }
 
 void mv88e6xxx_port_txtstamp(struct dsa_switch *ds, int port,
@@ -551,18 +568,129 @@ static int mv88e6xxx_ts_global_write(struct device *dev, u8 reg, u16 val)
 	return chip->info->ops->avb_ops->ptp_write(chip, reg, val);
 }
 
+/* The device differences are:
+ * ts_reg		MV88E6165			Others
+ * TS_ARR0	MV88E6165_PORT_PTP_ARR0_STS	MV88E6XXX_PORT_PTP_ARR0_STS
+ * TS_ARR1	MV88E6165_PORT_PTP_ARR1_STS	MV88E6XXX_PORT_PTP_ARR1_STS
+ * TS_DEP	MV88E6165_PORT_PTP_DEP_STS	MV88E6XXX_PORT_PTP_DEP_STS
+ */
+static int mv88e6xxx_ts_port_read_ts(struct device *dev,
+				     struct marvell_hwts *hwts, u8 port,
+				     enum marvell_ts_reg ts_reg)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	u16 data[4];
+	u16 reg;
+	int ret;
+
+	switch (ts_reg) {
+	case MARVELL_TS_ARR0:
+		reg = chip->info->ops->ptp_ops->arr0_sts_reg;
+		break;
+	case MARVELL_TS_ARR1:
+		reg = chip->info->ops->ptp_ops->arr1_sts_reg;
+		break;
+	case MARVELL_TS_DEP:
+		reg = chip->info->ops->ptp_ops->dep_sts_reg;
+		break;
+	}
+
+	mv88e6xxx_reg_lock(chip);
+	/* Read the status, time and sequence registers. If there's a valid
+	 * timestamp, immediately clear the status.
+	 */
+	ret = mv88e6xxx_port_ptp_read(chip, port, reg, data, ARRAY_SIZE(data));
+	if (ret == 0 && data[0] & MV_STATUS_VALID)
+		ret = mv88e6xxx_port_ptp_write(chip, port, reg, 0);
+	mv88e6xxx_reg_unlock(chip);
+
+	if (ret == 0) {
+		hwts->stat = data[0];
+		hwts->time = data[1] | data[2] << 16;
+		hwts->seq = data[3];
+
+		ret = !!(hwts->stat & MV_STATUS_VALID);
+	}
+
+	return ret;
+}
+
+/* PTP_PORT_CONFIG_0 is MV88E6XXX_PORT_PTP_CFG0
+ * PTP_PORT_CONFIG_1 is MV88E6XXX_PORT_PTP_CFG1
+ *   note: nothing sets this register in this driver
+ * PTP_PORT_CONFIG_2 is MV88E6XXX_PORT_PTP_CFG2
+ *   note: nothing sets this register in this driver
+ * MV88E6XXX_PORT_PTP_LED_CFG has no equivalent
+ *   note: nothing sets this register in this driver
+ * mv88e6165 doesn't have these registers
+ */
+static int mv88e6xxx_ts_port_write(struct device *dev, u8 port, u8 reg, u16 val)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_avb_ops *avb_ops;
+	u16 old;
+	int err;
+
+	avb_ops = chip->info->ops->avb_ops;
+
+	mv88e6xxx_reg_lock(chip);
+	err = avb_ops->port_ptp_read(chip, port, reg, &old, 1);
+	err = avb_ops->port_ptp_write(chip, port, reg, val);
+	mv88e6xxx_reg_unlock(chip);
+
+	dev_printk(KERN_DEBUG,
+		   dev, "%s: port=%u reg=%u val=%04x, old=%04x (%d)\n",
+		 __func__, port, reg, val, old, err);
+
+	return err;
+}
+
+static int mv88e6xxx_ts_port_modify(struct device *dev, u8 port, u8 reg,
+				    u16 mask, u16 val)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+	const struct mv88e6xxx_avb_ops *avb_ops;
+	u16 old, data;
+	int err;
+
+	avb_ops = chip->info->ops->avb_ops;
+
+	mv88e6xxx_reg_lock(chip);
+	err = avb_ops->port_ptp_read(chip, port, reg, &old, 1);
+	if (err)
+		goto out;
+
+	data = (old & ~mask) | val;
+	err = avb_ops->port_ptp_write(chip, port, reg, data);
+
+	dev_printk(KERN_DEBUG,
+		   dev, "%s: port=%u reg=%u mask=%04x val=%04x, 0x%04x -> 0x%04x (%d)\n",
+		 __func__, port, reg, mask, val, old, data, err);
+
+out:
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
 static const struct marvell_ts_ops mv88e6xxx_ts_ops = {
 	.ts_global_write = mv88e6xxx_ts_global_write,
+	.ts_port_read_ts = mv88e6xxx_ts_port_read_ts,
+	.ts_port_write = mv88e6xxx_ts_port_write,
+	.ts_port_modify = mv88e6xxx_ts_port_modify,
 };
 
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
+	unsigned int n_ports = mv88e6xxx_num_ports(chip);
 	int err;
 	int i;
 
+	chip->ptp_caps.rx_filters = ptp_ops->rx_filters;
+
 	/* Disable timestamping on all ports. */
-	for (i = 0; i < mv88e6xxx_num_ports(chip); ++i) {
+	for (i = 0; i < n_ports; ++i) {
 		err = mv88e6xxx_hwtstamp_port_setup(chip, i);
 		if (err)
 			return err;
@@ -611,6 +739,30 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+int mv88e6xxx_hwtstamp_setup_unlocked(struct mv88e6xxx_chip *chip)
+{
+	unsigned int n_ports = mv88e6xxx_num_ports(chip);
+	int i, err;
+
+	for (i = err = 0; i < n_ports; ++i) {
+		err = marvell_ts_probe(&chip->ptp_ts[i], chip->dev, chip->tai,
+				       &chip->ptp_caps, &mv88e6xxx_ts_ops, i);
+		if (err)
+			break;
+	}
+
+	if (err)
+		while (i--)
+			marvell_ts_remove(&chip->ptp_ts[i]);
+
+	return err;
+}
+
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip)
 {
+	unsigned int n_ports = mv88e6xxx_num_ports(chip);
+	int i;
+
+	for (i = 0; i < n_ports; i++)
+		marvell_ts_remove(&chip->ptp_ts[i]);
 }
diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.h b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
index 747351d59921..f82383764653 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.h
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.h
@@ -125,6 +125,7 @@ int mv88e6xxx_get_ts_info(struct dsa_switch *ds, int port,
 			  struct kernel_ethtool_ts_info *info);
 
 long mv88e6xxx_hwtstamp_work(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_hwtstamp_setup_unlocked(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip);
 int mv88e6352_hwtstamp_port_enable(struct mv88e6xxx_chip *chip, int port);
@@ -172,6 +173,11 @@ static inline int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static inline int mv88e6xxx_hwtstamp_setup_unlocked(struct mv88e6xxx_chip *chip)
+{
+	return 0;
+}
+
 static inline void mv88e6xxx_hwtstamp_free(struct mv88e6xxx_chip *chip)
 {
 }
-- 
2.47.3


