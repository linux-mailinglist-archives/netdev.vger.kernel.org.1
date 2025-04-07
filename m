Return-Path: <netdev+bounces-179623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAFA7DDD2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8204C3A6ED2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688E24F5A5;
	Mon,  7 Apr 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Oycb19f6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02740244EAB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029442; cv=none; b=XWsHorUcX3y9ENoasaYQOWYo7LFSAaqkvjkBO2YEuL0CILulFm6RSEitZjgr9DwoLKBQsLhHFvAq0ybMmqYeBaF+j4/pX++NeY4k8j8DnOWnCquOCxnxhig3MV1tBl3UYq93/FUjzFfjQ6VEjJgsCVgVPglkCTNe0M5VAcPQuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029442; c=relaxed/simple;
	bh=8KBRkSvUHlDN7T2obQXkXij4Jqau8z2GKUl3MezZnxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=IhMbJ5FKPUK1LKvClSulCtcyqeSpN5oSIvdLAOCh/TzjEF/bRym3K+MULd56caivlSRY2BqWwRCKqm5GtkUDRS6vyYiC1LLVyGYrm08FZVvtchH2It5xsQXUh28q8/7dtTCTfm2830Ok8crjVn7M0XcmBPpOakkV1UIdEbyTUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Oycb19f6; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6efe4e3d698so36335367b3.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744029440; x=1744634240;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trgvy9GTSGogGCZdfDcgDmfNiW583yZjnxh1kXgKLxA=;
        b=J2O+UdcX+2hruRKbC5m2f9AIU+750gJfY9y8pMw0Dt6q4+Owt5rA0/ikN09qzHHy/o
         TXVrOaNXY7Rp+ekah1LKOMgRRhMSC5CPVIFcWO0yz4rQVJE6HU54v0iV63+5cysrhGah
         phWXs4qtbVd6xOQ2aki2PVBbsGHz4C7gT9Z+uME2abyQAjhsPob4F0rOcAAozTyyfUlb
         B1CeA+452KTpCUPH43RRYz+WIqvNUxktGLMkaVmRDX3rel8OEeAwM/3FtseaEGRfXME6
         LsvFVFr+CCUMQsP62RAIR3NaClH2h5YOrItYz5j+Jq9wgrMLft2pqNRnV9wq1tF54cE0
         x9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyxPPwrsz4AolxvOtSPmxA71ucXUMZiqXIDHi6c4NAML4rTPidiAViXRKOCvrzsqgSWynnzBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOp0hZjvyXDDAtDMWDdPbqwX8POZkDpK0v3bwUIAGxZrGBygRZ
	2B4KeRQRyIFdPrFv9BsJhrHbiZxTbo7wcfEFBdJXd2WThApQS+OFBd/vfsO19gRkH4JTE9T5unc
	FqlMvBBxhBK0qOFoIED5jMKXfoicThA==
X-Gm-Gg: ASbGncsa/Vn0ARTgjXazyg1I5V6BpUNtud3cjMxX9QOsjYcdvhoS95OUlTlPBgHLD5O
	tKYtZYUxCFafxo0YXovBrXAyJQDCwd8Kmvz1laYVVkXvUM7zd2sy8HlsDUXieSCBGJEZjMNaSNT
	F3sCdHI5YWl0LT0uwBxdrAoPZh3LAjwYOzhe0rMzWcbsP5RAPXGLqnPxvCikfAinEnTdhebkH3c
	vRaFlrYN87FbTcXJLVSVqb7GrN+kyKov//Zb3fAX5yr2J53KrO9j+nHp/ta2rHoXhMJzsxiNUuv
	eONGlbMOLifLGVchxjTKTp5FFo0=
X-Google-Smtp-Source: AGHT+IE+hzviWhN6B0jWB5QM/z49QcOQQ2Yro+qHcz4urLr6lrNbJexRdmOvEMe55nbtS4Vx+x0TJ+wyDeYK
X-Received: by 2002:a05:690c:700c:b0:703:d0b5:7abc with SMTP id 00721157ae682-703e313e2f6mr203015537b3.9.1744029439891;
        Mon, 07 Apr 2025 05:37:19 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-703d1e8238asm9016807b3.39.2025.04.07.05.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:37:19 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744029438;
	bh=Trgvy9GTSGogGCZdfDcgDmfNiW583yZjnxh1kXgKLxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oycb19f6Bi4C5MrT2AQjPil4ELQBt6HQceZ5HE13kolKKMtyTKdfxXt0OxSEFxFoD
	 +TRl7QefdMkOQ/w41zvyDTJTDj7mALuN8mIXvOurDs/EivQS9wMDUAht660sf1Nt2G
	 M0nNr/d+z1j19rHU1z0GVVLBh3Qyh6K8SZis7Ix6zqirc2QbgOdgm+cZnIx2WOmLS7
	 ql0PsRQ5elnuxrbUbt03A4MiR9oiY6hBstfIyy1C5qc76fOKLBpiEShK1EYCCPOGyz
	 TzqvHH8PEXcWkXT9Q09iP4wBA9BiQCaFa7j2sVZylNyYwamHKmBdoEKavkrEaSfZ9k
	 slFyLTUGsRpPg==
Received: from mpazdan-home-zvfkk.localdomain (pinkesh-itest-2-us285.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id D090210023B;
	Mon,  7 Apr 2025 12:37:18 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id C8B8B40B16; Mon,  7 Apr 2025 12:37:18 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Marek Pazdan <mpazdan@arista.com>
Subject: [PATCH 2/2] ice: add qsfp transceiver reset and presence pin control
Date: Mon,  7 Apr 2025 12:35:38 +0000
Message-ID: <20250407123714.21646-2-mpazdan@arista.com>
In-Reply-To: <20250407123714.21646-1-mpazdan@arista.com>
References: <20250407123714.21646-1-mpazdan@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Commit f3c1c896f5a8 ("ethtool: transceiver reset and presence pin control")
adds ioctl API extension for get/set-phy-tunable so that transceiver
reset and presence pin control is enabled.
This commit adds functionality to utilize the API in ice driver.
According to E810 datasheet QSFP reset and presence pins are being
connected to SDP0 and SDP2 pins on controller host. Those pins can
be accessed using AQ commands for GPIO get/set.[O

Signed-off-by: Marek Pazdan <mpazdan@arista.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  2 +
 drivers/net/ethernet/intel/ice/ice_common.c  | 21 ++++++
 drivers/net/ethernet/intel/ice/ice_common.h  |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 72 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h    |  2 +
 6 files changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index fd083647c14a..2dbbcb20decf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -106,6 +106,8 @@
 #define ICE_Q_WAIT_MAX_RETRY	(5 * ICE_Q_WAIT_RETRY_LIMIT)
 #define ICE_MAX_LG_RSS_QS	256
 #define ICE_INVAL_Q_INDEX	0xffff
+#define ICE_GPIO_QSFP0_RESET	0
+#define ICE_GPIO_QSFP0_PRESENT	2
 
 #define ICE_MAX_RXQS_PER_TC		256	/* Used when setting VSI context per TC Rx queues */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 59df31c2c83f..2d643a7cc90f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6096,3 +6096,24 @@ u32 ice_get_link_speed(u16 index)
 
 	return ice_aq_to_link_speed[index];
 }
+
+/**
+ * ice_set_has_gpios - Sets availability of SDP GPIO pins.
+ * @hw: pointer to the HW structure
+ *
+ * This function sets availability of GPIO software defined pins
+ * (SDP) which are connected to transceiver slots and are used
+ * for transceiver control.
+ */
+bool ice_set_has_gpios(struct ice_hw *hw)
+{
+	if (hw->vendor_id != PCI_VENDOR_ID_INTEL)
+		return false;
+
+	switch (hw->device_id) {
+	case ICE_DEV_ID_E810C_QSFP:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9b00aa0ddf10..b64629b1d60d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -304,4 +304,5 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle);
 int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
+bool ice_set_has_gpios(struct ice_hw *hw);
 #endif /* _ICE_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 7c2dc347e4e5..20727c582ad5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4765,6 +4765,76 @@ static int ice_repr_ethtool_reset(struct net_device *dev, u32 *flags)
 	return ice_reset_vf(vf, ICE_VF_RESET_VFLR | ICE_VF_RESET_LOCK);
 }
 
+static int ice_get_phy_tunable(struct net_device *netdev,
+			       const struct ethtool_tunable *tuna, void *data)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	u16 gpio_handle = 0; /* SOC/on-chip GPIO */
+	u8 *enabled = data;
+	bool value;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_MODULE_RESET:
+		if (!hw->has_gpios)
+			return -EOPNOTSUPP;
+
+		if (ice_aq_get_gpio(hw, gpio_handle, ICE_GPIO_QSFP0_PRESENT,
+				    &value, NULL))
+			return -EIO;
+		if (!value) {
+			*enabled = ETHTOOL_PHY_MODULE_RESET_NA;
+		} else {
+			if (ice_aq_get_gpio(hw, gpio_handle, ICE_GPIO_QSFP0_RESET,
+					    &value, NULL))
+				return -EIO;
+			*enabled = value ? ETHTOOL_PHY_MODULE_RESET_ON :
+						ETHTOOL_PHY_FAST_LINK_DOWN_OFF;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ice_set_phy_tunable(struct net_device *netdev,
+			       const struct ethtool_tunable *tuna, const void *data)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	u16 gpio_handle = 0; /* SOC/on-chip GPIO */
+	const u8 *enable = data;
+	bool value;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_MODULE_RESET:
+		if (!hw->has_gpios)
+			return -EOPNOTSUPP;
+
+		if (*enable == ETHTOOL_PHY_MODULE_RESET_ON)
+			value = true;
+		else if (*enable == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
+			value = false;
+		else
+			return -EINVAL;
+
+		if (ice_aq_set_gpio(hw, gpio_handle, ICE_GPIO_QSFP0_RESET,
+				    value, NULL))
+			return -EIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4815,6 +4885,8 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_fecparam		= ice_set_fecparam,
 	.get_module_info	= ice_get_module_info,
 	.get_module_eeprom	= ice_get_module_eeprom,
+	.get_phy_tunable	= ice_get_phy_tunable,
+	.set_phy_tunable	= ice_set_phy_tunable,
 };
 
 static const struct ethtool_ops ice_ethtool_safe_mode_ops = {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 049edeb60104..fa18fc965649 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5294,6 +5294,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	hw->port_info = NULL;
 	hw->vendor_id = pdev->vendor;
 	hw->device_id = pdev->device;
+	hw->has_gpios = ice_set_has_gpios(hw);
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id);
 	hw->subsystem_vendor_id = pdev->subsystem_vendor;
 	hw->subsystem_device_id = pdev->subsystem_device;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 0aab21113cc4..ff758b4b7070 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -896,6 +896,8 @@ struct ice_hw {
 	u64 debug_mask;		/* bitmap for debug mask */
 	enum ice_mac_type mac_type;
 
+	bool has_gpios;
+
 	u16 fd_ctr_base;	/* FD counter base index */
 
 	/* pci info */
-- 
2.47.0


