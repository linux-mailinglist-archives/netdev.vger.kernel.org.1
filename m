Return-Path: <netdev+bounces-296128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ezZIIdnJGoV6AEAu9opvQ
	(envelope-from <netdev+bounces-296128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4364E07B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296128-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA6F3023524
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229393B6C1C;
	Sat,  6 Jun 2026 18:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963483B71A9
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:21:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770085; cv=none; b=gAJC46mwgS9WIL6Z4FbqC5Q3co3Da1k1G05sBTCtfo37oaue3mA1FzH5NXhepTl6446zor7b02Qm+07o3wLMgBCdbDJQXcaRYSE/1LZ7x6sTC95IEW+H2KOn9EQWD0VKWypwnWF9yzjlutJUAMSsAMRKiJkCAzDZRrvMvFfcjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770085; c=relaxed/simple;
	bh=FSOGI+9hwG7WFGcfy0lRm4CAE/L7TyNwEGTRM+4k5hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxtjmU+DQ9YG37hR1VJu6z2zjNIKpKd4PxBXoPcd0Y0SMxlY6D5LM/TMpIVTXcnntkBemoxnxuHAl5uxKiuBNcRrdcfHuP8zMv9XU+juEEaMIbeeNsj2Fi/76/Gpak97I10dOHwe4z/Ywq0JgQnBqGmFTqbA98y6l7taX3XylQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGI029679;
	Sat, 6 Jun 2026 11:21:06 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 08/10] cxgb4: Update driver lifecycle and peripherals for T7
Date: Sat,  6 Jun 2026 23:52:18 -0400
Message-Id: <20260607035220.528439-9-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.54 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296128-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7A4364E07B
X-Spam: Yes

Adapt primary driver entry points and peripheral sub-modules like MPS,
PTP, and ethtool to handle high-speed link profiles and telemetry
changes required by T7 adapters.

Integrate T7 parameters into main driver and peripheral workflows:
 - Update driver description string and export global MODULE_FIRMWARE
   tags for T7 firmware images, while adding support for 200G/400G link
   modes and modern media modules.
 - Implement modular workqueue management helpers, transition port
   selection logic to use logical port references lport, and fix DCB
   channels for T7 channel maps.
 - Add dynamic tracking wrappers inside the MPS layer to manage
   encapsulated MAC filters alongside logical index reference counting.
 - Upgrade PTP telemetry to parse 64-bit hardware timestamps from the
   dedicated T7 port register tracks.
 - Expand ethtool interface to support SFP56/QSFP56 configurations,
   redirect EEPROM routines through systemic PCI wrappers, and add full
   RSS hash key get and set configurations.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |   71 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 1059 ++++++++---------
 .../net/ethernet/chelsio/cxgb4/cxgb4_mps.c    |   52 +
 .../net/ethernet/chelsio/cxgb4/cxgb4_ptp.c    |   25 +-
 4 files changed, 617 insertions(+), 590 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 0092bc16f887..283cc065471e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -14,6 +14,7 @@
 #include "cxgb4_tc_flower.h"
 
 #define EEPROM_MAGIC 0x38E2F10C
+#define RSS_HASH_KEY_SIZE 40
 
 static u32 get_msglevel(struct net_device *dev)
 {
@@ -358,7 +359,7 @@ static void get_stats(struct net_device *dev, struct ethtool_stats *stats,
 	int i;
 	u64 *p0;
 
-	t4_get_port_stats_offset(adapter, pi->tx_chan,
+	t4_get_port_stats_offset(adapter, pi->lport,
 				 (struct port_stats *)data,
 				 &pi->stats_base);
 
@@ -440,10 +441,13 @@ static int from_fw_port_mod_type(enum fw_port_type port_type,
 		   port_type == FW_PORT_TYPE_CR4_QSFP ||
 		   port_type == FW_PORT_TYPE_CR_QSFP ||
 		   port_type == FW_PORT_TYPE_CR2_QSFP ||
-		   port_type == FW_PORT_TYPE_SFP28) {
+		   port_type == FW_PORT_TYPE_SFP28 ||
+		   port_type == FW_PORT_TYPE_SFP56 ||
+		   port_type == FW_PORT_TYPE_QSFP56) {
 		if (mod_type == FW_PORT_MOD_TYPE_LR ||
 		    mod_type == FW_PORT_MOD_TYPE_SR ||
 		    mod_type == FW_PORT_MOD_TYPE_ER ||
+		    mod_type == FW_PORT_MOD_TYPE_DR ||
 		    mod_type == FW_PORT_MOD_TYPE_LRM)
 			return PORT_FIBRE;
 		else if (mod_type == FW_PORT_MOD_TYPE_TWINAX_PASSIVE ||
@@ -597,6 +601,20 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
 		break;
 
+	case FW_PORT_TYPE_SFP56:
+		SET_LMM(FIBRE);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
+		break;
+
+	case FW_PORT_TYPE_QSFP56:
+		SET_LMM(FIBRE);
+		FW_CAPS_TO_LMM(SPEED_200G, 200000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_100G, 100000baseCR4_Full);
+		FW_CAPS_TO_LMM(SPEED_50G, 50000baseSR2_Full);
+		FW_CAPS_TO_LMM(SPEED_25G, 25000baseCR_Full);
+		break;
+
 	case FW_PORT_TYPE_KR4_100G:
 	case FW_PORT_TYPE_CR4_QSFP:
 		SET_LMM(FIBRE);
@@ -1193,7 +1211,7 @@ static int eeprom_rd_phys(struct adapter *adap, unsigned int phys_addr, u32 *v)
 	int vaddr = t4_eeprom_ptov(phys_addr, adap->pf, EEPROMPFSIZE);
 
 	if (vaddr >= 0)
-		vaddr = pci_read_vpd(adap->pdev, vaddr, sizeof(u32), v);
+		vaddr = cxgb4_pci_read_vpd(adap, vaddr, sizeof(u32), v);
 	return vaddr < 0 ? vaddr : 0;
 }
 
@@ -1202,7 +1220,7 @@ static int eeprom_wr_phys(struct adapter *adap, unsigned int phys_addr, u32 v)
 	int vaddr = t4_eeprom_ptov(phys_addr, adap->pf, EEPROMPFSIZE);
 
 	if (vaddr >= 0)
-		vaddr = pci_write_vpd(adap->pdev, vaddr, sizeof(u32), &v);
+		vaddr = cxgb4_pci_write_vpd(adap, vaddr, sizeof(u32), &v);
 	return vaddr < 0 ? vaddr : 0;
 }
 
@@ -1576,6 +1594,11 @@ static int get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *ts
 	return 0;
 }
 
+static u32 get_rss_key_size(struct net_device *dev)
+{
+	return RSS_HASH_KEY_SIZE;
+}
+
 static u32 get_rss_table_size(struct net_device *dev)
 {
 	const struct port_info *pi = netdev_priv(dev);
@@ -1592,6 +1615,17 @@ static int get_rss_table(struct net_device *dev,
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 	if (!rxfh->indir)
 		return 0;
+
+	if (rxfh->key) {
+		u32 key[10];
+
+		t4_read_rss_key(pi->adapter, key, true);
+
+		/* RSS hash keys are read in order TP_RSS_SECRET_KEY9..0 */
+		for (int i = 0; i < 10; i++)
+			((u32 *)rxfh->key)[i] = be32_to_cpu(key[9 - i]);
+	}
+
 	while (n--)
 		rxfh->indir[n] = pi->rss[n];
 	return 0;
@@ -1607,10 +1641,19 @@ static int set_rss_table(struct net_device *dev,
 	/* We require at least one supported parameter to be changed and no
 	 * change in any of the unsupported parameters
 	 */
-	if (rxfh->key ||
-	    (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
-	     rxfh->hfunc != ETH_RSS_HASH_TOP))
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
+
+	if (rxfh->key) {
+		u32 key[10];
+
+		/* RSS hash keys are written in order TP_RSS_SECRET_KEY9..0 */
+		for (int i = 0; i < 10; i++)
+			key[i] = cpu_to_be32(((u32 *)rxfh->key)[9 - i]);
+		t4_write_rss_key(pi->adapter, key, -1, true);
+	}
+
 	if (!rxfh->indir)
 		return 0;
 
@@ -1629,7 +1672,6 @@ static struct filter_entry *cxgb4_get_filter_entry(struct adapter *adap,
 						   u32 ftid)
 {
 	struct tid_info *t = &adap->tids;
-
 	if (ftid >= t->hpftid_base && ftid < t->hpftid_base + t->nhpftids)
 		return &t->hpftid_tab[ftid - t->hpftid_base];
 
@@ -2022,12 +2064,12 @@ static int cxgb4_get_module_info(struct net_device *dev,
 	case FW_PORT_TYPE_SFP:
 	case FW_PORT_TYPE_QSA:
 	case FW_PORT_TYPE_SFP28:
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFF_8472_COMP_ADDR,
 				SFF_8472_COMP_LEN, &sff8472_comp);
 		if (ret)
 			return ret;
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFP_DIAG_TYPE_ADDR,
 				SFP_DIAG_TYPE_LEN, &sff_diag_type);
 		if (ret)
@@ -2050,7 +2092,7 @@ static int cxgb4_get_module_info(struct net_device *dev,
 	case FW_PORT_TYPE_CR_QSFP:
 	case FW_PORT_TYPE_CR2_QSFP:
 	case FW_PORT_TYPE_CR4_QSFP:
-		ret = t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret = t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				I2C_DEV_ADDR_A0, SFF_REV_ADDR,
 				SFF_REV_LEN, &sff_rev);
 		/* For QSFP type ports, revision value >= 3
@@ -2083,14 +2125,14 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
 
 	memset(data, 0, eprom->len);
 	if (offset + len <= I2C_PAGE_SIZE)
-		return t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		return t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				 I2C_DEV_ADDR_A0, offset, len, data);
 
 	/* offset + len spans 0xa0 and 0xa1 pages */
 	if (offset <= I2C_PAGE_SIZE) {
 		/* read 0xa0 page */
 		len = I2C_PAGE_SIZE - offset;
-		ret =  t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan,
+		ret =  t4_i2c_rd(adapter, adapter->mbox, pi->lport,
 				 I2C_DEV_ADDR_A0, offset, len, data);
 		if (ret)
 			return ret;
@@ -2101,7 +2143,7 @@ static int cxgb4_get_module_eeprom(struct net_device *dev,
 		len = eprom->len - len;
 	}
 	/* Read additional optical diagnostics from page 0xa2 if supported */
-	return t4_i2c_rd(adapter, adapter->mbox, pi->tx_chan, I2C_DEV_ADDR_A2,
+	return t4_i2c_rd(adapter, adapter->mbox, pi->lport, I2C_DEV_ADDR_A2,
 			 offset, len, &data[eprom->len - len]);
 }
 
@@ -2205,6 +2247,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_rxnfc         = get_rxnfc,
 	.set_rxnfc         = set_rxnfc,
 	.get_rx_ring_count = get_rx_ring_count,
+	.get_rxfh_key_size = get_rss_key_size,
 	.get_rxfh_indir_size = get_rss_table_size,
 	.get_rxfh	   = get_rss_table,
 	.set_rxfh	   = set_rss_table,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 6df98fca932f..18f2a7e20b62 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -92,40 +92,20 @@
 
 char cxgb4_driver_name[] = KBUILD_MODNAME;
 
-#define DRV_DESC "Chelsio T4/T5/T6 Network Driver"
+#define DRV_DESC "Chelsio T4/T5/T6/T7 Network Driver"
 
 #define DFLT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK | \
 			 NETIF_MSG_TIMER | NETIF_MSG_IFDOWN | NETIF_MSG_IFUP |\
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
-/* Macros needed to support the PCI Device ID Table ...
- */
-#define CH_PCI_DEVICE_ID_TABLE_DEFINE_BEGIN \
-	static const struct pci_device_id cxgb4_pci_tbl[] = {
-#define CXGB4_UNIFIED_PF 0x4
-
-#define CH_PCI_DEVICE_ID_FUNCTION CXGB4_UNIFIED_PF
-
-/* Include PCI Device IDs for both PF4 and PF0-3 so our PCI probe() routine is
- * called for both.
- */
-#define CH_PCI_DEVICE_ID_FUNCTION2 0x0
-
-#define CH_PCI_ID_TABLE_ENTRY(devid) \
-		{ PCI_VDEVICE(CHELSIO, (devid)), .driver_data = CXGB4_UNIFIED_PF }
-
-#define CH_PCI_DEVICE_ID_TABLE_DEFINE_END \
-		{ } \
-	}
-
-#include "t4_pci_id_tbl.h"
-
 #define FW4_FNAME "cxgb4/t4fw.bin"
 #define FW5_FNAME "cxgb4/t5fw.bin"
 #define FW6_FNAME "cxgb4/t6fw.bin"
+#define FW7_FNAME "cxgb4/t7fw.bin"
 #define FW4_CFNAME "cxgb4/t4-config.txt"
 #define FW5_CFNAME "cxgb4/t5-config.txt"
 #define FW6_CFNAME "cxgb4/t6-config.txt"
+#define FW7_CFNAME "cxgb4/t7-config.txt"
 #define PHY_AQ1202_FIRMWARE "cxgb4/aq1202_fw.cld"
 #define PHY_BCM84834_FIRMWARE "cxgb4/bcm8483.bin"
 #define PHY_AQ1202_DEVICEID 0x4409
@@ -134,10 +114,10 @@ char cxgb4_driver_name[] = KBUILD_MODNAME;
 MODULE_DESCRIPTION(DRV_DESC);
 MODULE_AUTHOR("Chelsio Communications");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DEVICE_TABLE(pci, cxgb4_pci_tbl);
 MODULE_FIRMWARE(FW4_FNAME);
 MODULE_FIRMWARE(FW5_FNAME);
 MODULE_FIRMWARE(FW6_FNAME);
+MODULE_FIRMWARE(FW7_FNAME);
 
 /*
  * The driver uses the best interrupt scheme available on a platform in the
@@ -171,18 +151,20 @@ static int rx_dma_offset = 2;
  * queue. Select between the kernel provided function (select_queue=0) or user
  * cxgb_select_queue function (select_queue=1)
  *
- * Default: select_queue=0
+ * Default: select_queue=1
  */
-static int select_queue;
+static int select_queue = 1;
 module_param(select_queue, int, 0644);
 MODULE_PARM_DESC(select_queue,
 		 "Select between kernel provided method of selecting or driver method of selecting TX queue. Default is kernel method.");
 
 static struct dentry *cxgb4_debugfs_root;
+static const struct net_device_ops cxgb4_netdev_ops;
 
 LIST_HEAD(adapter_list);
 DEFINE_MUTEX(uld_mutex);
 LIST_HEAD(uld_list);
+struct cxgb4_uld_info cxgb4_ulds[CXGB4_ULD_MAX];
 
 static int cfg_queues(struct adapter *adap);
 
@@ -218,6 +200,12 @@ static void link_report(struct net_device *dev)
 		case 100000:
 			s = "100Gbps";
 			break;
+		case 200000:
+			s = "200Gbps";
+			break;
+		case 400000:
+			s = "400Gbps";
+			break;
 		default:
 			pr_info("%s: unsupported speed: %d\n",
 				dev->name, p->link_cfg.speed);
@@ -305,7 +293,8 @@ void t4_os_link_changed(struct adapter *adapter, int port_id, int link_stat)
 void t4_os_portmod_changed(struct adapter *adap, int port_id)
 {
 	static const char *mod_str[] = {
-		NULL, "LR", "SR", "ER", "passive DA", "active DA", "LRM"
+		NULL, "LR", "SR", "ER", "passive DA", "active DA", "LRM",
+		"LR_SIMPLEX", "DR"
 	};
 
 	struct net_device *dev = adap->port[port_id];
@@ -333,6 +322,40 @@ void t4_os_portmod_changed(struct adapter *adap, int port_id)
 	pi->link_cfg.redo_l1cfg = netif_running(dev);
 }
 
+void cxgb4_work_queue(struct workqueue_struct *workq, struct work_struct *work)
+{
+	if (!workq)
+		return;
+
+	queue_work(workq, work);
+}
+
+void cxgb4_work_cancel(struct workqueue_struct *workq, struct work_struct *work)
+{
+	if (!workq)
+		return;
+
+	cancel_work_sync(work);
+}
+
+static void cxgb4_workqueues_destroy(struct adapter *adap)
+{
+	if (adap->workq) {
+		flush_workqueue(adap->workq);
+		destroy_workqueue(adap->workq);
+		adap->workq = NULL;
+	}
+}
+
+static int cxgb4_workqueues_create(struct adapter *adap)
+{
+	adap->workq = create_singlethread_workqueue("cxgb4");
+	if (!adap->workq)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int dbfifo_int_thresh = 10; /* 10 == 640 entry threshold */
 module_param(dbfifo_int_thresh, int, 0644);
 MODULE_PARM_DESC(dbfifo_int_thresh, "doorbell fifo interrupt threshold");
@@ -517,7 +540,7 @@ static int link_start(struct net_device *dev)
 		ret = cxgb4_update_mac_filt(pi, pi->viid, &pi->xact_addr_filt,
 					    dev->dev_addr, true, &pi->smt_idx);
 	if (ret == 0)
-		ret = t4_link_l1cfg(pi->adapter, mb, pi->tx_chan,
+		ret = t4_link_l1cfg(pi->adapter, mb, pi->lport,
 				    &pi->link_cfg);
 	if (ret == 0) {
 		local_bh_disable();
@@ -534,9 +557,17 @@ static int link_start(struct net_device *dev)
 static void dcb_rpl(struct adapter *adap, const struct fw_port_cmd *pcmd)
 {
 	int port = FW_PORT_CMD_PORTID_G(ntohl(pcmd->op_to_portid));
-	struct net_device *dev = adap->port[adap->chan_map[port]];
-	int old_dcb_enabled = cxgb4_dcb_enabled(dev);
-	int new_dcb_enabled;
+	int old_dcb_enabled, new_dcb_enabled;
+	struct net_device *dev;
+
+	dev = cxgb4_port_chan_to_netdev(adap, port);
+	if (!dev) {
+		dev_warn(adap->pdev_dev,
+			 "Could not get netdevice for handling dcb_rpl for port %d\n", port);
+		return;
+	}
+
+	old_dcb_enabled = cxgb4_dcb_enabled(dev);
 
 	cxgb4_dcb_handle_fw_update(adap, pcmd);
 	new_dcb_enabled = cxgb4_dcb_enabled(dev);
@@ -579,7 +610,6 @@ static int fwevtq_handler(struct sge_rspq *q, const __be64 *rsp,
 		struct sge_txq *txq;
 
 		txq = q->adap->sge.egr_map[qid - q->adap->sge.egr_start];
-		txq->restarts++;
 		if (txq->q_type == CXGB4_TXQ_ETH) {
 			struct sge_eth_txq *eq;
 
@@ -588,6 +618,7 @@ static int fwevtq_handler(struct sge_rspq *q, const __be64 *rsp,
 		} else {
 			struct sge_uld_txq *oq;
 
+			txq->restarts++;
 			oq = container_of(txq, struct sge_uld_txq, q);
 			tasklet_schedule(&oq->qresume_tsk);
 		}
@@ -608,7 +639,7 @@ static int fwevtq_handler(struct sge_rspq *q, const __be64 *rsp,
 			struct net_device *dev;
 			int dcbxdis, state_input;
 
-			dev = q->adap->port[q->adap->chan_map[port]];
+			dev = cxgb4_port_chan_to_netdev(q->adap, port);
 			dcbxdis = (action == FW_PORT_ACTION_GET_PORT_INFO
 			  ? !!(pcmd->u.info.dcbxdis_pkd & FW_PORT_CMD_DCBXDIS_F)
 			  : !!(be32_to_cpu(pcmd->u.info32.lstatus32_to_cbllen32)
@@ -959,7 +990,7 @@ void cxgb4_enable_rx(struct adapter *adap, struct sge_rspq *q)
 	/* 0-increment GTS to start the timer and enable interrupts */
 	t4_write_reg(adap, MYPF_REG(SGE_PF_GTS_A),
 		     SEINTARM_V(q->intr_params) |
-		     INGRESSQID_V(q->cntxt_id));
+		     INGRESSQID_V(q->cntxt_id) | CIDXINC_V(0));
 }
 
 /*
@@ -1047,7 +1078,7 @@ static int setup_sge_queues(struct adapter *adap)
 	struct sge_uld_rxq_info *rxq_info = NULL;
 	struct sge *s = &adap->sge;
 	unsigned int cmplqid = 0;
-	int err, i, j, msix = 0;
+	int err, i, j, k, msix = 0;
 
 	if (is_uld(adap))
 		rxq_info = s->uld_rxq_info[CXGB4_ULD_RDMA];
@@ -1079,8 +1110,7 @@ static int setup_sge_queues(struct adapter *adap)
 					       msix, &q->fl,
 					       t4_ethrx_handler,
 					       NULL,
-					       t4_get_tp_ch_map(adap,
-								pi->tx_chan));
+					       t4_get_tp_ch_map(adap, pi->lport));
 			if (err)
 				goto freeout;
 			q->rspq.idx = j;
@@ -1092,7 +1122,7 @@ static int setup_sge_queues(struct adapter *adap)
 			err = t4_sge_alloc_eth_txq(adap, t, dev,
 					netdev_get_tx_queue(dev, j),
 					q->rspq.cntxt_id,
-					!!(adap->flags & CXGB4_SGE_DBQ_TIMER));
+					!!(adap->flags & CXGB4_SGE_DBQ_TIMER), j);
 			if (err)
 				goto freeout;
 		}
@@ -1105,25 +1135,26 @@ static int setup_sge_queues(struct adapter *adap)
 		if (rxq_info)
 			cmplqid	= rxq_info->uldrxq[i].rspq.cntxt_id;
 
-		err = t4_sge_alloc_ctrl_txq(adap, &s->ctrlq[i], adap->port[i],
-					    s->fw_evtq.cntxt_id, cmplqid);
-		if (err)
-			goto freeout;
+		/* Allocate at least num_up_cores control queues per port */
+		j = i * adap->params.num_up_cores;
+		for (k = 0; k < adap->params.num_up_cores; k++, j++) {
+			err = t4_sge_alloc_ctrl_txq(adap, &s->ctrlq[j], adap->port[i],
+						    s->fw_evtq.cntxt_id, cmplqid, k);
+			if (err)
+				goto freeout;
+		}
 	}
 
 	if (!is_t4(adap->params.chip)) {
 		err = t4_sge_alloc_eth_txq(adap, &s->ptptxq, adap->port[0],
 					   netdev_get_tx_queue(adap->port[0], 0)
-					   , s->fw_evtq.cntxt_id, false);
+					   , s->fw_evtq.cntxt_id, false, 0);
 		if (err)
 			goto freeout;
 	}
 
-	t4_write_reg(adap, is_t4(adap->params.chip) ?
-				MPS_TRC_RSS_CONTROL_A :
-				MPS_T5_TRC_RSS_CONTROL_A,
-		     RSSCONTROL_V(netdev2pinfo(adap->port[0])->tx_chan) |
-		     QUEUENUMBER_V(s->ethrxq[0].rspq.abs_id));
+	t4_set_trace_rss_control(adap, netdev2pinfo(adap->port[0])->tx_chan,
+				 s->ethrxq[0].rspq.abs_id);
 	return 0;
 freeout:
 	dev_err(adap->pdev_dev, "Can't allocate queues, err=%d\n", -err);
@@ -1286,17 +1317,6 @@ static int cxgb_set_features(struct net_device *dev, netdev_features_t features)
 	return err;
 }
 
-static int setup_debugfs(struct adapter *adap)
-{
-	if (IS_ERR_OR_NULL(adap->debugfs_root))
-		return -1;
-
-#ifdef CONFIG_DEBUG_FS
-	t4_setup_debugfs(adap);
-#endif
-	return 0;
-}
-
 static void cxgb4_port_mirror_free_rxq(struct adapter *adap,
 				       struct sge_eth_rxq *mirror_rxq)
 {
@@ -2118,14 +2138,28 @@ EXPORT_SYMBOL(cxgb4_best_aligned_mtu);
  *	cxgb4_port_chan - get the HW channel of a port
  *	@dev: the net device for the port
  *
- *	Return the HW Tx channel of the given port.
+ *	Return the HW channel of the given port.
  */
 unsigned int cxgb4_port_chan(const struct net_device *dev)
 {
-	return netdev2pinfo(dev)->tx_chan;
+	return netdev2pinfo(dev)->lport;
 }
 EXPORT_SYMBOL(cxgb4_port_chan);
 
+struct net_device *cxgb4_port_chan_to_netdev(struct adapter *adap, u8 chan)
+{
+	struct port_info *pi;
+	u8 i;
+
+	for_each_port(adap, i) {
+		pi = adap2pinfo(adap, i);
+		if (pi->lport == chan)
+			return adap->port[pi->port_id];
+	}
+
+	return NULL;
+}
+
 /**
  *      cxgb4_port_e2cchan - get the HW c-channel of a port
  *      @dev: the net device for the port
@@ -2252,70 +2286,26 @@ EXPORT_SYMBOL(cxgb4_sync_txq_pidx);
 
 int cxgb4_read_tpte(struct net_device *dev, u32 stag, __be32 *tpte)
 {
-	u32 edc0_size, edc1_size, mc0_size, mc1_size, size;
-	u32 edc0_end, edc1_end, mc0_end, mc1_end;
-	u32 offset, memtype, memaddr;
-	struct adapter *adap;
-	u32 hma_size = 0;
+	struct adapter *adap = netdev2adap(dev);
+	unsigned long mtype = 0;
+	u32 params[7], val[7];
+	u32 offset;
 	int ret;
 
-	adap = netdev2adap(dev);
-
 	offset = ((stag >> 8) * 32) + adap->vres.stag.start;
+	if (offset >= (adap->vres.stag.start + adap->vres.stag.size))
+		goto err;
 
-	/* Figure out where the offset lands in the Memory Type/Address scheme.
-	 * This code assumes that the memory is laid out starting at offset 0
-	 * with no breaks as: EDC0, EDC1, MC0, MC1. All cards have both EDC0
-	 * and EDC1.  Some cards will have neither MC0 nor MC1, most cards have
-	 * MC0, and some have both MC0 and MC1.
-	 */
-	size = t4_read_reg(adap, MA_EDRAM0_BAR_A);
-	edc0_size = EDRAM0_SIZE_G(size) << 20;
-	size = t4_read_reg(adap, MA_EDRAM1_BAR_A);
-	edc1_size = EDRAM1_SIZE_G(size) << 20;
-	size = t4_read_reg(adap, MA_EXT_MEMORY0_BAR_A);
-	mc0_size = EXT_MEM0_SIZE_G(size) << 20;
-
-	if (t4_read_reg(adap, MA_TARGET_MEM_ENABLE_A) & HMA_MUX_F) {
-		size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
-		hma_size = EXT_MEM1_SIZE_G(size) << 20;
-	}
-	edc0_end = edc0_size;
-	edc1_end = edc0_end + edc1_size;
-	mc0_end = edc1_end + mc0_size;
-
-	if (offset < edc0_end) {
-		memtype = MEM_EDC0;
-		memaddr = offset;
-	} else if (offset < edc1_end) {
-		memtype = MEM_EDC1;
-		memaddr = offset - edc0_end;
-	} else {
-		if (hma_size && (offset < (edc1_end + hma_size))) {
-			memtype = MEM_HMA;
-			memaddr = offset - edc1_end;
-		} else if (offset < mc0_end) {
-			memtype = MEM_MC0;
-			memaddr = offset - edc1_end;
-		} else if (is_t5(adap->params.chip)) {
-			size = t4_read_reg(adap, MA_EXT_MEMORY1_BAR_A);
-			mc1_size = EXT_MEM1_SIZE_G(size) << 20;
-			mc1_end = mc0_end + mc1_size;
-			if (offset < mc1_end) {
-				memtype = MEM_MC1;
-				memaddr = offset - mc0_end;
-			} else {
-				/* offset beyond the end of any memory */
-				goto err;
-			}
-		} else {
-			/* T4/T6 only has a single memory channel */
-			goto err;
-		}
-	}
+	params[0] = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
+			FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_CF));
+	ret = t4_query_params(adap, adap->mbox, adap->pf, 0, 1, params, val);
+	if (ret != 0)
+		goto err;
+
+	mtype = FW_PARAMS_PARAM_Y_G(val[0]);
 
 	spin_lock(&adap->win0_lock);
-	ret = t4_memory_rw(adap, 0, memtype, memaddr, 32, tpte, T4_MEMORY_READ);
+	ret = t4_memory_rw(adap, MEMWIN_NIC, mtype, offset, 32, tpte, T4_MEMORY_READ);
 	spin_unlock(&adap->win0_lock);
 	return ret;
 
@@ -2357,8 +2347,6 @@ int cxgb4_bar2_sge_qregs(struct net_device *dev,
 }
 EXPORT_SYMBOL(cxgb4_bar2_sge_qregs);
 
-static struct pci_driver cxgb4_driver;
-
 static void check_neigh_update(struct neighbour *neigh)
 {
 	const struct device *parent;
@@ -2367,7 +2355,7 @@ static void check_neigh_update(struct neighbour *neigh)
 	if (is_vlan_dev(netdev))
 		netdev = vlan_dev_real_dev(netdev);
 	parent = netdev->dev.parent;
-	if (parent && parent->driver == &cxgb4_driver.driver)
+	if (parent && netdev->netdev_ops == &cxgb4_netdev_ops)
 		t4_l2t_update(dev_get_drvdata(parent), neigh);
 }
 
@@ -2393,7 +2381,6 @@ static struct notifier_block cxgb4_netevent_nb = {
 static void drain_db_fifo(struct adapter *adap, int usecs)
 {
 	u32 v1, v2, lp_count, hp_count;
-
 	do {
 		v1 = t4_read_reg(adap, SGE_DBFIFO_STATUS_A);
 		v2 = t4_read_reg(adap, SGE_DBFIFO_STATUS2_A);
@@ -2608,7 +2595,7 @@ void t4_db_full(struct adapter *adap)
 		notify_rdma_uld(adap, CXGB4_CONTROL_DB_FULL);
 		t4_set_reg_field(adap, SGE_INT_ENABLE3_A,
 				 DBFIFO_HP_INT_F | DBFIFO_LP_INT_F, 0);
-		queue_work(adap->workq, &adap->db_full_task);
+		cxgb4_work_queue(adap->workq, &adap->db_full_task);
 	}
 }
 
@@ -2618,7 +2605,7 @@ void t4_db_dropped(struct adapter *adap)
 		disable_dbs(adap);
 		notify_rdma_uld(adap, CXGB4_CONTROL_DB_FULL);
 	}
-	queue_work(adap->workq, &adap->db_drop_task);
+	cxgb4_work_queue(adap->workq, &adap->db_drop_task);
 }
 
 void t4_register_netevent_notifier(void)
@@ -2639,10 +2626,14 @@ static void detach_ulds(struct adapter *adap)
 	mutex_lock(&uld_mutex);
 	list_del(&adap->list_node);
 
-	for (i = 0; i < CXGB4_ULD_MAX; i++)
-		if (adap->uld && adap->uld[i].handle)
+	for (i = 0; i < CXGB4_ULD_MAX; i++) {
+		mutex_lock(&adap->uld_mutex);
+		if (adap->uld[i].handle) {
 			adap->uld[i].state_change(adap->uld[i].handle,
-					     CXGB4_STATE_DETACH);
+						  CXGB4_STATE_DETACH);
+		}
+		mutex_unlock(&adap->uld_mutex);
+	}
 
 	if (netevent_registered && list_empty(&adapter_list)) {
 		unregister_netevent_notifier(&cxgb4_netevent_nb);
@@ -2655,12 +2646,12 @@ static void notify_ulds(struct adapter *adap, enum cxgb4_state new_state)
 {
 	unsigned int i;
 
-	mutex_lock(&uld_mutex);
-	for (i = 0; i < CXGB4_ULD_MAX; i++)
+	for (i = 0; i < CXGB4_ULD_MAX; i++) {
+		mutex_lock(&adap->uld_mutex);
 		if (adap->uld && adap->uld[i].handle)
-			adap->uld[i].state_change(adap->uld[i].handle,
-						  new_state);
-	mutex_unlock(&uld_mutex);
+			adap->uld[i].state_change(adap->uld[i].handle, new_state);
+		mutex_unlock(&adap->uld_mutex);
+	}
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2669,7 +2660,6 @@ static int cxgb4_inet6addr_handler(struct notifier_block *this,
 {
 	struct inet6_ifaddr *ifa = data;
 	struct net_device *event_dev = ifa->idev->dev;
-	const struct device *parent = NULL;
 #if IS_ENABLED(CONFIG_BONDING)
 	struct adapter *adap;
 #endif
@@ -2695,10 +2685,7 @@ static int cxgb4_inet6addr_handler(struct notifier_block *this,
 	}
 #endif
 
-	if (event_dev)
-		parent = event_dev->dev.parent;
-
-	if (parent && parent->driver == &cxgb4_driver.driver) {
+	if (event_dev && event_dev->netdev_ops == &cxgb4_netdev_ops) {
 		switch (event) {
 		case NETDEV_UP:
 			cxgb4_clip_get(event_dev, (const u32 *)ifa, 1);
@@ -2768,7 +2755,6 @@ static int cxgb_up(struct adapter *adap)
 			err = -ENOMEM;
 			goto irq_err;
 		}
-
 		err = request_irq(adap->msix_info[s->nd_msix_idx].vec,
 				  t4_nondata_intr, 0,
 				  adap->msix_info[s->nd_msix_idx].desc, adap);
@@ -2779,10 +2765,13 @@ static int cxgb_up(struct adapter *adap)
 		if (err)
 			goto irq_err_free_nd_msix;
 	} else {
+		unsigned long flags = 0;
+
+		if (!cxgb4_msix_enabled(adap) && !cxgb4_msi_enabled(adap))
+			flags = IRQF_SHARED;
+
 		err = request_irq(adap->pdev->irq, t4_intr_handler(adap),
-				  (adap->flags & CXGB4_USING_MSI) ? 0
-								  : IRQF_SHARED,
-				  adap->port[0]->name, adap);
+				  flags, adap->port[0]->name, adap);
 		if (err)
 			goto irq_err;
 	}
@@ -2812,9 +2801,9 @@ static int cxgb_up(struct adapter *adap)
 
 static void cxgb_down(struct adapter *adapter)
 {
-	cancel_work_sync(&adapter->tid_release_task);
-	cancel_work_sync(&adapter->db_full_task);
-	cancel_work_sync(&adapter->db_drop_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->tid_release_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->db_full_task);
+	cxgb4_work_cancel(adapter->workq, &adapter->db_drop_task);
 	adapter->tid_release_task_busy = false;
 	adapter->tid_release_head = NULL;
 
@@ -3008,7 +2997,7 @@ static void cxgb_get_stats(struct net_device *dev,
 		spin_unlock(&adapter->stats_lock);
 		return;
 	}
-	t4_get_port_stats_offset(adapter, p->tx_chan, &stats,
+	t4_get_port_stats_offset(adapter, p->lport, &stats,
 				 &p->stats_base);
 	spin_unlock(&adapter->stats_lock);
 
@@ -3347,7 +3336,7 @@ static int cxgb4_mgmt_set_vf_rate(struct net_device *dev, int vf,
 			      SCHED_CLASS_MODE_CLASS,
 			      SCHED_CLASS_RATEUNIT_BITS,
 			      SCHED_CLASS_RATEMODE_ABS,
-			      pi->tx_chan, class_id, 0,
+			      pi->lport, class_id, 0,
 			      max_tx_rate * 1000, 0, pktsize, 0);
 	if (ret) {
 		dev_err(adap->pdev_dev, "Err %d for Traffic Class config\n",
@@ -3731,16 +3720,21 @@ static int cxgb_udp_tunnel_unset_port(struct net_device *netdev,
 	struct port_info *pi = netdev_priv(netdev);
 	struct adapter *adapter = pi->adapter;
 	u8 match_all_mac[] = { 0, 0, 0, 0, 0, 0 };
+	u32 chip_ver, reg;
 	int ret = 0, i;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
 	switch (ti->type) {
 	case UDP_TUNNEL_TYPE_VXLAN:
 		adapter->vxlan_port = 0;
-		t4_write_reg(adapter, MPS_RX_VXLAN_TYPE_A, 0);
+		reg = chip_ver >= CHELSIO_T7 ?
+			T7_MPS_RX_VXLAN_TYPE_A : MPS_RX_VXLAN_TYPE_A;
 		break;
 	case UDP_TUNNEL_TYPE_GENEVE:
 		adapter->geneve_port = 0;
-		t4_write_reg(adapter, MPS_RX_GENEVE_TYPE_A, 0);
+		reg = chip_ver >= CHELSIO_T7 ? T7_MPS_RX_GENEVE_TYPE_A :
+					       MPS_RX_GENEVE_TYPE_A;
 		break;
 	default:
 		return -EINVAL;
@@ -3757,13 +3751,13 @@ static int cxgb_udp_tunnel_unset_port(struct net_device *netdev,
 					   match_all_mac, match_all_mac,
 					   adapter->rawf_start + pi->port_id,
 					   1, pi->port_id, false);
-		if (ret < 0) {
-			netdev_info(netdev, "Failed to free mac filter entry, for port %d\n",
-				    i);
-			return ret;
-		}
+		if (ret < 0)
+			netdev_info(netdev,
+				    "RAW MAC Filter free failed for port %d, UDP port %u, ret: %d\n",
+				    i, be16_to_cpu(ti->port), ret);
 	}
 
+	t4_write_reg(adapter, reg, 0);
 	return 0;
 }
 
@@ -3774,18 +3768,26 @@ static int cxgb_udp_tunnel_set_port(struct net_device *netdev,
 	struct port_info *pi = netdev_priv(netdev);
 	struct adapter *adapter = pi->adapter;
 	u8 match_all_mac[] = { 0, 0, 0, 0, 0, 0 };
+	u32 chip_ver, reg, val;
+	__be16 *port_save;
 	int i, ret;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
+
 	switch (ti->type) {
 	case UDP_TUNNEL_TYPE_VXLAN:
 		adapter->vxlan_port = ti->port;
-		t4_write_reg(adapter, MPS_RX_VXLAN_TYPE_A,
-			     VXLAN_V(be16_to_cpu(ti->port)) | VXLAN_EN_F);
+		port_save = &adapter->vxlan_port;
+		reg = chip_ver >= CHELSIO_T7 ? T7_MPS_RX_VXLAN_TYPE_A :
+					       MPS_RX_VXLAN_TYPE_A;
+		val = VXLAN_V(be16_to_cpu(ti->port)) | VXLAN_EN_F;
 		break;
 	case UDP_TUNNEL_TYPE_GENEVE:
 		adapter->geneve_port = ti->port;
-		t4_write_reg(adapter, MPS_RX_GENEVE_TYPE_A,
-			     GENEVE_V(be16_to_cpu(ti->port)) | GENEVE_EN_F);
+		port_save = &adapter->geneve_port;
+		reg = chip_ver >= CHELSIO_T7 ?
+			T7_MPS_RX_GENEVE_TYPE_A : MPS_RX_GENEVE_TYPE_A;
+		val = GENEVE_V(be16_to_cpu(ti->port)) | GENEVE_EN_F;
 		break;
 	default:
 		return -EINVAL;
@@ -3806,13 +3808,27 @@ static int cxgb_udp_tunnel_set_port(struct net_device *netdev,
 					    adapter->rawf_start + pi->port_id,
 					    1, pi->port_id, false);
 		if (ret < 0) {
-			netdev_info(netdev, "Failed to allocate a mac filter entry, not adding port %d\n",
-				    be16_to_cpu(ti->port));
-			return ret;
+			netdev_info(netdev,
+				    "RAW MAC Filter alloc failed for port %d, UDP port %u, ret: %d\n",
+				    i, be16_to_cpu(ti->port), ret);
+			goto out_free;
 		}
 	}
 
+	*port_save = ti->port;
+	t4_write_reg(adapter, reg, val);
 	return 0;
+
+out_free:
+	while (i-- > 0) {
+		pi = adap2pinfo(adapter, i);
+		t4_free_raw_mac_filt(adapter, pi->viid, match_all_mac,
+				     match_all_mac,
+				     adapter->rawf_start + pi->port_id,
+				     1, pi->port_id, false);
+	}
+
+	return ret;
 }
 
 static const struct udp_tunnel_nic_info cxgb_udp_tunnels = {
@@ -3853,30 +3869,30 @@ static netdev_features_t cxgb_fix_features(struct net_device *dev,
 }
 
 static const struct net_device_ops cxgb4_netdev_ops = {
-	.ndo_open             = cxgb_open,
-	.ndo_stop             = cxgb_close,
-	.ndo_start_xmit       = t4_start_xmit,
-	.ndo_select_queue     =	cxgb_select_queue,
-	.ndo_get_stats64      = cxgb_get_stats,
-	.ndo_set_rx_mode      = cxgb_set_rxmode,
-	.ndo_set_mac_address  = cxgb_set_mac_addr,
-	.ndo_set_features     = cxgb_set_features,
-	.ndo_validate_addr    = eth_validate_addr,
-	.ndo_eth_ioctl         = cxgb_ioctl,
-	.ndo_change_mtu       = cxgb_change_mtu,
+	.ndo_open = cxgb_open,
+	.ndo_stop = cxgb_close,
+	.ndo_start_xmit = t4_start_xmit,
+	.ndo_select_queue = cxgb_select_queue,
+	.ndo_get_stats64 = cxgb_get_stats,
+	.ndo_set_rx_mode = cxgb_set_rxmode,
+	.ndo_set_mac_address = cxgb_set_mac_addr,
+	.ndo_set_features = cxgb_set_features,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_eth_ioctl = cxgb_ioctl,
+	.ndo_change_mtu = cxgb_change_mtu,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller  = cxgb_netpoll,
+	.ndo_poll_controller = cxgb_netpoll,
 #endif
 #ifdef CONFIG_CHELSIO_T4_FCOE
-	.ndo_fcoe_enable      = cxgb_fcoe_enable,
-	.ndo_fcoe_disable     = cxgb_fcoe_disable,
+	.ndo_fcoe_enable = cxgb_fcoe_enable,
+	.ndo_fcoe_disable = cxgb_fcoe_disable,
 #endif /* CONFIG_CHELSIO_T4_FCOE */
-	.ndo_set_tx_maxrate   = cxgb_set_tx_maxrate,
-	.ndo_setup_tc         = cxgb_setup_tc,
-	.ndo_features_check   = cxgb_features_check,
-	.ndo_fix_features     = cxgb_fix_features,
-	.ndo_hwtstamp_get     = cxgb_hwtstamp_get,
-	.ndo_hwtstamp_set     = cxgb_hwtstamp_set,
+	.ndo_set_tx_maxrate = cxgb_set_tx_maxrate,
+	.ndo_setup_tc = cxgb_setup_tc,
+	.ndo_features_check = cxgb_features_check,
+	.ndo_fix_features = cxgb_fix_features,
+	.ndo_hwtstamp_get = cxgb_hwtstamp_get,
+	.ndo_hwtstamp_set = cxgb_hwtstamp_set,
 };
 
 #ifdef CONFIG_PCI_IOV
@@ -3937,35 +3953,7 @@ void t4_fatal_err(struct adapter *adap)
 		netif_carrier_off(dev);
 	}
 	dev_alert(adap->pdev_dev, "encountered fatal error, adapter stopped\n");
-	queue_work(adap->workq, &adap->fatal_err_notify_task);
-}
-
-static void setup_memwin(struct adapter *adap)
-{
-	u32 nic_win_base = t4_get_util_window(adap);
-
-	t4_setup_memwin(adap, nic_win_base, MEMWIN_NIC);
-}
-
-static void setup_memwin_rdma(struct adapter *adap)
-{
-	if (adap->vres.ocq.size) {
-		u32 start;
-		unsigned int sz_kb;
-
-		start = t4_read_pcie_cfg4(adap, PCI_BASE_ADDRESS_2);
-		start &= PCI_BASE_ADDRESS_MEM_MASK;
-		start += OCQ_WIN_OFFSET(adap->pdev, &adap->vres);
-		sz_kb = roundup_pow_of_two(adap->vres.ocq.size) >> 10;
-		t4_write_reg(adap,
-			     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_BASE_WIN_A, 3),
-			     start | BIR_V(1) | WINDOW_V(ilog2(sz_kb)));
-		t4_write_reg(adap,
-			     PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, 3),
-			     adap->vres.ocq.start);
-		t4_read_reg(adap,
-			    PCIE_MEM_ACCESS_REG(PCIE_MEM_ACCESS_OFFSET_A, 3));
-	}
+	cxgb4_work_queue(adap->workq, &adap->fatal_err_notify_task);
 }
 
 /* HMA Definitions */
@@ -3975,6 +3963,9 @@ static void setup_memwin_rdma(struct adapter *adap)
 
 #define HMA_PAGE_SIZE		PAGE_SIZE
 
+/* HW supports max 16M page size */
+#define HMA_MAX_PAGE_SIZE      (16UL << 20)
+
 #define HMA_MAX_NO_FW_ADDRESS	(16 << 10)  /* FW supports 16K addresses */
 
 #define HMA_PAGE_ORDER					\
@@ -4025,7 +4016,9 @@ static int adap_config_hma(struct adapter *adapter)
 	unsigned int i, j, k;
 	u32 param, hma_size;
 	unsigned int ncmds;
+	unsigned int nents;
 	size_t page_size;
+	u32 best_page_size;
 	u32 page_order;
 	int node, ret;
 
@@ -4097,16 +4090,33 @@ static int adap_config_hma(struct adapter *adapter)
 	}
 	adapter->hma.flags |= HMA_DMA_MAPPED_FLAG;
 
-	adapter->hma.phy_addr = kzalloc_objs(dma_addr_t, sgt->nents);
+	best_page_size = HMA_MAX_PAGE_SIZE;
+	for_each_sg(sgl, iter, sgt->nents, i) {
+		if (!is_power_of_2(sg_dma_len(iter))) {
+			best_page_size =
+				min(page_size << page_order, HMA_MAX_PAGE_SIZE);
+			break;
+		}
+
+		if (sg_dma_len(iter) < best_page_size)
+			best_page_size = sg_dma_len(iter);
+	}
+
+	nents = (hma_size << 20) / best_page_size;
+	adapter->hma.phy_addr = kcalloc(nents, sizeof(dma_addr_t), GFP_KERNEL);
 	if (unlikely(!adapter->hma.phy_addr))
 		goto free_hma;
 
+	k = 0;
 	for_each_sg(sgl, iter, sgt->nents, i) {
-		newpage = sg_page(iter);
-		adapter->hma.phy_addr[i] = sg_dma_address(iter);
+		u32 npages = sg_dma_len(iter) / best_page_size;
+
+		for (j = 0; j < npages; j++)
+			adapter->hma.phy_addr[k++] =
+				sg_dma_address(iter) + (j * best_page_size);
 	}
 
-	ncmds = DIV_ROUND_UP(sgt->nents, HMA_MAX_ADDR_IN_CMD);
+	ncmds = DIV_ROUND_UP(nents, HMA_MAX_ADDR_IN_CMD);
 	/* Pass on the addresses to firmware */
 	for (i = 0, k = 0; i < ncmds; i++, k += HMA_MAX_ADDR_IN_CMD) {
 		struct fw_hma_cmd hma_cmd;
@@ -4121,7 +4131,7 @@ static int adap_config_hma(struct adapter *adapter)
 		 * addresses
 		 */
 		if (i == ncmds - 1) {
-			naddr = sgt->nents % HMA_MAX_ADDR_IN_CMD;
+			naddr = nents % HMA_MAX_ADDR_IN_CMD;
 			naddr = naddr ? naddr : HMA_MAX_ADDR_IN_CMD;
 		}
 		memset(&hma_cmd, 0, sizeof(hma_cmd));
@@ -4140,8 +4150,7 @@ static int adap_config_hma(struct adapter *adapter)
 
 		/* Total Page size specified in units of 4K */
 		hma_cmd.addr_size_pkd =
-			htonl(FW_HMA_CMD_ADDR_SIZE_V
-				((page_size << page_order) >> 12));
+			htonl(FW_HMA_CMD_ADDR_SIZE_V(best_page_size >> 12));
 
 		/* Fill the 5 addresses */
 		for (j = 0; j < naddr; j++) {
@@ -4285,7 +4294,7 @@ static int adap_init0_tweaks(struct adapter *adapter)
 	 * Process module parameters which affect early initialization.
 	 */
 	if (rx_dma_offset != 2 && rx_dma_offset != 0) {
-		dev_err(&adapter->pdev->dev,
+		dev_err(adapter->pdev_dev,
 			"Ignoring illegal rx_dma_offset=%d, using 2\n",
 			rx_dma_offset);
 		rx_dma_offset = 2;
@@ -4356,9 +4365,9 @@ static struct info_10gbt_phy_fw {
 	{ 0, NULL, NULL },
 };
 
-static struct info_10gbt_phy_fw *find_phy_info(int devid)
+static struct info_10gbt_phy_fw *find_phy_info(struct adapter *adap)
 {
-	int i;
+	int i, devid = cxgb4_pci_device_id(adap);
 
 	for (i = 0; i < ARRAY_SIZE(phy_info_array); i++) {
 		if (phy_info_array[i].phy_fw_id == devid)
@@ -4374,13 +4383,13 @@ static struct info_10gbt_phy_fw *find_phy_info(int devid)
  */
 static int adap_init0_phy(struct adapter *adap)
 {
+	struct info_10gbt_phy_fw *phy_info;
 	const struct firmware *phyf;
 	int ret;
-	struct info_10gbt_phy_fw *phy_info;
 
 	/* Use the device ID to determine which PHY file to flash.
 	 */
-	phy_info = find_phy_info(adap->pdev->device);
+	phy_info = find_phy_info(adap);
 	if (!phy_info) {
 		dev_warn(adap->pdev_dev,
 			 "No PHY Firmware file found for this PHY\n");
@@ -4444,14 +4453,15 @@ static int adap_init0_phy(struct adapter *adap)
  */
 static int adap_init0_config(struct adapter *adapter, int reset)
 {
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	char *fw_config_file, fw_config_file_path[256];
 	u32 finiver, finicsum, cfcsum, param, val;
 	struct fw_caps_config_cmd caps_cmd;
 	unsigned long mtype = 0, maddr = 0;
 	const struct firmware *cf;
 	char *config_name = NULL;
-	int config_issued = 0;
-	int ret;
+	int ret, config_issued = 0;
+	int devid = 0;
 
 	/*
 	 * Reset device if necessary.
@@ -4468,7 +4478,8 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	 * to be performed after any global adapter RESET above since some
 	 * PHYs only have local RAM copies of the PHY firmware.
 	 */
-	if (is_10gbt_device(adapter->pdev->device)) {
+	devid = cxgb4_pci_device_id(adapter);
+	if (is_10gbt_device(devid)) {
 		ret = adap_init0_phy(adapter);
 		if (ret < 0)
 			goto bye;
@@ -4478,7 +4489,7 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	 * then use that.  Otherwise, use the configuration file stored
 	 * in the adapter flash ...
 	 */
-	switch (CHELSIO_CHIP_VERSION(adapter->params.chip)) {
+	switch (chip_ver) {
 	case CHELSIO_T4:
 		fw_config_file = FW4_CFNAME;
 		break;
@@ -4488,9 +4499,12 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 	case CHELSIO_T6:
 		fw_config_file = FW6_CFNAME;
 		break;
+	case CHELSIO_T7:
+		fw_config_file = FW7_CFNAME;
+		break;
 	default:
 		dev_err(adapter->pdev_dev, "Device %d is not supported\n",
-		       adapter->pdev->device);
+		       devid);
 		ret = -EINVAL;
 		goto bye;
 	}
@@ -4507,9 +4521,10 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 			"/lib/firmware/%s", fw_config_file);
 		config_name = fw_config_file_path;
 
-		if (cf->size >= FLASH_CFG_MAX_SIZE)
+		ret = t4_flash_location_size(adapter, FLASH_LOC_CFG);
+		if (ret < 0 || cf->size >= ret) {
 			ret = -ENOMEM;
-		else {
+		} else {
 			params[0] = (FW_PARAMS_MNEM_V(FW_PARAMS_MNEM_DEV) |
 			     FW_PARAMS_PARAM_X_V(FW_PARAMS_PARAM_DEV_CF));
 			ret = t4_query_params(adapter, adapter->mbox,
@@ -4653,7 +4668,7 @@ static int adap_init0_config(struct adapter *adapter, int reset)
 		dev_err(adapter->pdev_dev,
 			"HMA configuration failed with error %d\n", ret);
 
-	if (is_t6(adapter->params.chip)) {
+	if (chip_ver >= CHELSIO_T6) {
 		adap_config_hpfilter(adapter);
 		ret = setup_ppod_edram(adapter);
 		if (!ret)
@@ -4731,7 +4746,23 @@ static struct fw_info fw_info_array[] = {
 			.intfver_iscsi = FW_INTFVER(T6, ISCSI),
 			.intfver_fcoepdu = FW_INTFVER(T6, FCOEPDU),
 			.intfver_fcoe = FW_INTFVER(T6, FCOE),
-		},
+			},
+	}, {
+		.chip = CHELSIO_T7,
+		.fs_name = FW7_CFNAME,
+		.fw_mod_name = FW7_FNAME,
+		.fw_hdr = {
+			.chip = FW_HDR_CHIP_T7,
+			.fw_ver = __cpu_to_be32(FW_VERSION(T7)),
+			.intfver_nic = FW_INTFVER(T7, NIC),
+			.intfver_vnic = FW_INTFVER(T7, VNIC),
+			.intfver_ofld = FW_INTFVER(T7, OFLD),
+			.intfver_ri = FW_INTFVER(T7, RI),
+			.intfver_iscsipdu = FW_INTFVER(T7, ISCSIPDU),
+			.intfver_iscsi = FW_INTFVER(T7, ISCSI),
+			.intfver_fcoepdu = FW_INTFVER(T7, FCOEPDU),
+			.intfver_fcoe = FW_INTFVER(T7, FCOE),
+			},
 	}
 
 };
@@ -4752,12 +4783,11 @@ static struct fw_info *find_fw_info(int chip)
  */
 static int adap_init0(struct adapter *adap, int vpd_skip)
 {
+	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	struct fw_caps_config_cmd caps_cmd;
-	u32 params[7], val[7];
+	u32 port_vec, v, params[7], val[7];
 	enum dev_state state;
-	u32 v, port_vec;
-	int reset = 1;
-	int ret;
+	int ret, reset;
 
 	/* Grab Firmware Device Log parameters as early as possible so we have
 	 * access to it for debugging, etc.
@@ -4766,14 +4796,10 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	if (ret < 0)
 		return ret;
 
-	/* Contact FW, advertising Master capability */
-	ret = t4_fw_hello(adap, adap->mbox, adap->mbox,
-			  is_kdump_kernel() ? MASTER_MUST : MASTER_MAY, &state);
-	if (ret < 0) {
-		dev_err(adap->pdev_dev, "could not connect to FW, error %d\n",
-			ret);
+	ret = cxgb4_pci_fw_init(adap, &state);
+	if (ret < 0)
 		return ret;
-	}
+
 	if (ret == adap->mbox)
 		adap->flags |= CXGB4_MASTER_PF;
 
@@ -4791,20 +4817,20 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	if (ret)
 		state = DEV_STATE_UNINIT;
 	if ((adap->flags & CXGB4_MASTER_PF) && state != DEV_STATE_INIT) {
-		struct fw_info *fw_info;
-		struct fw_hdr *card_fw;
 		const struct firmware *fw;
 		const u8 *fw_data = NULL;
 		unsigned int fw_size = 0;
+		struct fw_info *fw_info;
+		struct fw_hdr *card_fw;
 
 		/* This is the firmware whose headers the driver was compiled
 		 * against
 		 */
-		fw_info = find_fw_info(CHELSIO_CHIP_VERSION(adap->params.chip));
+		fw_info = find_fw_info(chip_ver);
 		if (fw_info == NULL) {
 			dev_err(adap->pdev_dev,
 				"unable to get firmware info for chip %d.\n",
-				CHELSIO_CHIP_VERSION(adap->params.chip));
+				chip_ver);
 			return -EINVAL;
 		}
 
@@ -4958,7 +4984,7 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	if (!ret)
 		adap->flags |= CXGB4_SGE_DBQ_TIMER;
 
-	if (is_bypass_device(adap->pdev->device))
+	if (is_bypass_device(cxgb4_pci_device_id(adap)))
 		adap->params.bypass = 1;
 
 	/*
@@ -5003,8 +5029,6 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 			adap->rawf_cnt = val[1] - val[0] + 1;
 		}
 
-		adap->tids.tid_base =
-			t4_read_reg(adap, LE_DB_ACTIVE_TABLE_START_INDEX_A);
 	}
 
 	/* qids (ingress/egress) returned from firmware can be anywhere
@@ -5021,14 +5045,21 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	adap->sge.egr_sz = val[0] - adap->sge.egr_start + 1;
 	adap->sge.ingr_sz = val[1] - adap->sge.ingr_start + 1;
 
-	adap->sge.egr_map = kzalloc_objs(*adap->sge.egr_map, adap->sge.egr_sz);
+	adap->sge.egr_map = kcalloc(adap->sge.egr_sz,
+				    sizeof(*adap->sge.egr_map), GFP_KERNEL);
 	if (!adap->sge.egr_map) {
 		ret = -ENOMEM;
 		goto bye;
 	}
 
+	adap->sge.txq_maperr = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
+	if (!adap->sge.txq_maperr) {
+		ret = -ENOMEM;
+		goto bye;
+	}
+
 	adap->sge.ingr_map = kzalloc_objs(*adap->sge.ingr_map,
-					  adap->sge.ingr_sz);
+			adap->sge.ingr_sz);
 	if (!adap->sge.ingr_map) {
 		ret = -ENOMEM;
 		goto bye;
@@ -5043,12 +5074,6 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 		goto bye;
 	}
 
-	adap->sge.txq_maperr = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
-	if (!adap->sge.txq_maperr) {
-		ret = -ENOMEM;
-		goto bye;
-	}
-
 #ifdef CONFIG_DEBUG_FS
 	adap->sge.blocked_fl = bitmap_zalloc(adap->sge.egr_sz, GFP_KERNEL);
 	if (!adap->sge.blocked_fl) {
@@ -5409,14 +5434,14 @@ static int adap_init0(struct adapter *adap, int vpd_skip)
 	bitmap_free(adap->sge.blocked_fl);
 #endif
 	if (ret != -ETIMEDOUT && ret != -EIO)
-		t4_fw_bye(adap, adap->mbox);
+		cxgb4_pci_fw_free(adap);
 	return ret;
 }
 
 /* EEH callbacks */
 
-static pci_ers_result_t eeh_err_detected(struct pci_dev *pdev,
-					 pci_channel_state_t state)
+pci_ers_result_t cxgb4_pci_eeh_err_detected(struct pci_dev *pdev,
+					    pci_channel_state_t state)
 {
 	int i;
 	struct adapter *adap = pci_get_drvdata(pdev);
@@ -5448,7 +5473,7 @@ out:	return state == pci_channel_io_perm_failure ?
 		PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_NEED_RESET;
 }
 
-static pci_ers_result_t eeh_slot_reset(struct pci_dev *pdev)
+pci_ers_result_t cxgb4_pci_eeh_slot_reset(struct pci_dev *pdev)
 {
 	int i, ret;
 	struct fw_caps_config_cmd c;
@@ -5483,7 +5508,7 @@ static pci_ers_result_t eeh_slot_reset(struct pci_dev *pdev)
 		struct port_info *pi = adap2pinfo(adap, i);
 		u8 vivld = 0, vin = 0;
 
-		ret = t4_alloc_vi(adap, adap->mbox, pi->tx_chan, adap->pf, 0, 1,
+		ret = t4_alloc_vi(adap, adap->mbox, pi->lport, adap->pf, 0, 1,
 				  NULL, NULL, &vivld, &vin);
 		if (ret < 0)
 			return PCI_ERS_RESULT_DISCONNECT;
@@ -5504,13 +5529,13 @@ static pci_ers_result_t eeh_slot_reset(struct pci_dev *pdev)
 
 	t4_load_mtus(adap, adap->params.mtus, adap->params.a_wnd,
 		     adap->params.b_wnd);
-	setup_memwin(adap);
+	cxgb4_pci_setup_memwin(adap);
 	if (cxgb_up(adap))
 		return PCI_ERS_RESULT_DISCONNECT;
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-static void eeh_resume(struct pci_dev *pdev)
+void cxgb4_pci_eeh_resume(struct pci_dev *pdev)
 {
 	int i;
 	struct adapter *adap = pci_get_drvdata(pdev);
@@ -5532,7 +5557,7 @@ static void eeh_resume(struct pci_dev *pdev)
 	rtnl_unlock();
 }
 
-static void eeh_reset_prepare(struct pci_dev *pdev)
+void cxgb4_pci_eeh_reset_prepare(struct pci_dev *pdev)
 {
 	struct adapter *adapter = pci_get_drvdata(pdev);
 	int i;
@@ -5557,7 +5582,7 @@ static void eeh_reset_prepare(struct pci_dev *pdev)
 		cxgb_down(adapter);
 }
 
-static void eeh_reset_done(struct pci_dev *pdev)
+void cxgb4_pci_eeh_reset_done(struct pci_dev *pdev)
 {
 	struct adapter *adapter = pci_get_drvdata(pdev);
 	int err, i;
@@ -5572,7 +5597,7 @@ static void eeh_reset_done(struct pci_dev *pdev)
 		return;
 	}
 
-	setup_memwin(adapter);
+	cxgb4_pci_setup_memwin(adapter);
 
 	err = adap_init0(adapter, 1);
 	if (err) {
@@ -5581,7 +5606,7 @@ static void eeh_reset_done(struct pci_dev *pdev)
 		return;
 	}
 
-	setup_memwin_rdma(adapter);
+	cxgb4_pci_setup_memwin_rdma(adapter);
 
 	if (adapter->flags & CXGB4_FW_OK) {
 		err = t4_port_init(adapter, adapter->pf, adapter->pf, 0);
@@ -5613,14 +5638,6 @@ static void eeh_reset_done(struct pci_dev *pdev)
 			cxgb_open(adapter->port[i]);
 }
 
-static const struct pci_error_handlers cxgb4_eeh = {
-	.error_detected = eeh_err_detected,
-	.slot_reset     = eeh_slot_reset,
-	.resume         = eeh_resume,
-	.reset_prepare  = eeh_reset_prepare,
-	.reset_done     = eeh_reset_done,
-};
-
 /* Return true if the Link Configuration supports "High Speeds" (those greater
  * than 1Gb/s).
  */
@@ -5751,6 +5768,17 @@ static int cfg_queues(struct adapter *adap)
 			s->ofldqsets = avail_uld_qsets;
 		}
 
+		/*
+		 * 1. num_of_cores should not be less than one for tensilica
+		 * 2. num of ofld queues per port should not be less than num cores
+		 */
+
+		if (adap->params.tid_qid_sel_mask &&
+		    s->ofldqsets <
+			    adap->params.num_up_cores * adap->params.nports)
+			s->ofldqsets =
+				adap->params.num_up_cores * adap->params.nports;
+
 		avail_qsets -= num_ulds * s->ofldqsets;
 	}
 
@@ -5802,6 +5830,26 @@ static int cfg_queues(struct adapter *adap)
 	return 0;
 }
 
+bool cxgb4_msix_enabled(struct adapter *adap)
+{
+	return cxgb4_pci_msix_enabled(adap);
+}
+
+bool cxgb4_msi_enabled(struct adapter *adap)
+{
+	return cxgb4_pci_msi_enabled(adap);
+}
+
+#ifdef CONFIG_CHELSIO_T4_OFFLOAD
+
+int cxgb4_filter_field_shift(const struct net_device *dev, int filter_sel)
+{
+	return t4_filter_field_shift(netdev2adap(dev), filter_sel);
+}
+EXPORT_SYMBOL(cxgb4_filter_field_shift);
+
+#endif /* CONFIG_CHELSIO_T4_OFFLOAD */
+
 /*
  * Reduce the number of Ethernet queues across all ports to at most n.
  * n provides at least one queue per port.
@@ -5894,7 +5942,7 @@ static int enable_msix(struct adapter *adap)
 {
 	u32 eth_need, uld_need = 0, ethofld_need = 0, mirror_need = 0;
 	u32 ethqsets = 0, ofldqsets = 0, eoqsets = 0, mirrorqsets = 0;
-	u8 num_uld = 0, nchan = adap->params.nports;
+	u8 nchan = adap->params.nports;
 	u32 i, want, need, num_vec;
 	struct sge *s = &adap->sge;
 	struct msix_entry *entries;
@@ -5912,9 +5960,8 @@ static int enable_msix(struct adapter *adap)
 #endif
 	eth_need = need;
 	if (is_uld(adap)) {
-		num_uld = adap->num_ofld_uld + adap->num_uld;
-		want += num_uld * s->ofldqsets;
-		uld_need = num_uld * nchan;
+		want += s->ofldqsets;
+		uld_need = adap->params.num_up_cores * nchan;
 		need += uld_need;
 	}
 
@@ -5956,6 +6003,7 @@ static int enable_msix(struct adapter *adap)
 			goto out_free;
 		}
 
+		adap->flags |= CXGB4_USING_MSI;
 		dev_info(adap->pdev_dev,
 			 "Disabling offload due to insufficient MSI-X vectors\n");
 		adap->params.offload = 0;
@@ -5967,6 +6015,8 @@ static int enable_msix(struct adapter *adap)
 		uld_need = 0;
 		ethofld_need = 0;
 		mirror_need = 0;
+	} else {
+		adap->flags |= CXGB4_USING_MSIX;
 	}
 
 	num_vec = allocated;
@@ -6066,16 +6116,24 @@ static int enable_msix(struct adapter *adap)
 		adap->msix_info[i].idx = i;
 	}
 
+	if (cxgb4_msix_enabled(adap))
+		dev_info(adap->pdev_dev, "%d MSI-X vectors allocated, ",
+			 allocated);
+	else if (cxgb4_msi_enabled(adap))
+		dev_info(adap->pdev_dev, "%d MSI vectors allocated, ",
+			 allocated);
+	else
+		dev_info(adap->pdev_dev, "%d Legacy vectors allocated, ",
+			 allocated);
+
 	dev_info(adap->pdev_dev,
-		 "%d MSI-X vectors allocated, nic %d eoqsets %d per uld %d mirrorqsets %d\n",
-		 allocated, s->max_ethqsets, s->eoqsets, s->nqs_per_uld,
-		 s->mirrorqsets);
+		 "nic %d eoqsets %d per uld %d mirrorqsets %d\n",
+		 s->max_ethqsets, s->eoqsets, s->nqs_per_uld, s->mirrorqsets);
 
-	kfree(entries);
 	return 0;
 
 out_disable_msix:
-	pci_disable_msix(adap->pdev);
+	disable_msi(adap);
 
 out_free:
 	kfree(entries);
@@ -6111,10 +6169,10 @@ static void print_adapter_info(struct adapter *adapter)
 
 	/* Software/Hardware configuration */
 	dev_info(adapter->pdev_dev, "Configuration: %sNIC %s, %s capable\n",
-		 is_offload(adapter) ? "R" : "",
-		 ((adapter->flags & CXGB4_USING_MSIX) ? "MSI-X" :
-		  (adapter->flags & CXGB4_USING_MSI) ? "MSI" : ""),
-		 is_offload(adapter) ? "Offload" : "non-Offload");
+		 is_uld(adapter) ? "R" : "",
+		 cxgb4_msix_enabled(adapter) ? "MSI-X" :
+		 (cxgb4_msi_enabled(adapter) ? "MSI" : ""),
+		 is_uld(adapter) ? "Offload" : "non-Offload");
 }
 
 static void print_port_info(const struct net_device *dev)
@@ -6190,7 +6248,7 @@ static void free_some_resources(struct adapter *adapter)
 			free_netdev(adapter->port[i]);
 		}
 	if (adapter->flags & CXGB4_FW_OK)
-		t4_fw_bye(adapter, adapter->pf);
+		cxgb4_pci_fw_free(adapter);
 }
 
 #define TSO_FLAGS (NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_TSO_ECN | \
@@ -6199,23 +6257,6 @@ static void free_some_resources(struct adapter *adapter)
 		   NETIF_F_GRO | NETIF_F_IPV6_CSUM | NETIF_F_HIGHDMA)
 #define SEGMENT_SIZE 128
 
-static int t4_get_chip_type(struct adapter *adap, int ver)
-{
-	u32 pl_rev = REV_G(t4_read_reg(adap, PL_REV_A));
-
-	switch (ver) {
-	case CHELSIO_T4:
-		return CHELSIO_CHIP_CODE(CHELSIO_T4, pl_rev);
-	case CHELSIO_T5:
-		return CHELSIO_CHIP_CODE(CHELSIO_T5, pl_rev);
-	case CHELSIO_T6:
-		return CHELSIO_CHIP_CODE(CHELSIO_T6, pl_rev);
-	default:
-		break;
-	}
-	return -EINVAL;
-}
-
 #ifdef CONFIG_PCI_IOV
 static void cxgb4_mgmt_setup(struct net_device *dev)
 {
@@ -6232,7 +6273,7 @@ static void cxgb4_mgmt_setup(struct net_device *dev)
 	dev->ethtool_ops = &cxgb4_mgmt_ethtool_ops;
 }
 
-static int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
+int cxgb4_iov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct adapter *adap = pci_get_drvdata(pdev);
 	int err = 0;
@@ -6568,109 +6609,81 @@ static const struct xfrmdev_ops cxgb4_xfrmdev_ops = {
 
 #endif /* CONFIG_CHELSIO_IPSEC_INLINE */
 
-static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int cxgb4_primary_pf(struct adapter *adapter)
+{
+	return adapter->primary_pf;
+}
+
+int cxgb4_is_primary_pf(struct adapter *adapter)
+{
+	return adapter->pf == cxgb4_primary_pf(adapter);
+}
+
+struct adapter *cxgb4_adap_alloc(struct device *dev)
+{
+	return devm_kzalloc(dev, sizeof(struct adapter), GFP_KERNEL);
+}
+
+int cxgb4_mbox_log_init(struct adapter *adap)
+{
+	adap->mbox_log =
+		kzalloc(sizeof(struct mbox_cmd_log) +
+				(sizeof(struct mbox_cmd) * T4_OS_LOG_MBOX_CMDS),
+			GFP_KERNEL);
+	if (!adap->mbox_log)
+		return -ENOMEM;
+
+	t4_os_lock_init(&adap->mbox_lock);
+	INIT_LIST_HEAD(&adap->mlist.list);
+	adap->mbox_log->size = T4_OS_LOG_MBOX_CMDS;
+	return 0;
+}
+
+void cxgb4_mbox_log_free(struct adapter *adap)
+{
+	kfree(adap->mbox_log);
+}
+
+int cxgb4_adap_probe(struct adapter *adapter)
 {
 	struct net_device *netdev;
-	struct adapter *adapter;
 	static int adap_idx = 1;
-	int s_qpp, qpp, num_seg;
 	struct port_info *pi;
-	enum chip_type chip;
-	void __iomem *regs;
-	int func, chip_ver;
-	u16 device_id;
+	int chip_ver;
 	int i, err;
-	u32 whoami;
 
-	err = pci_request_regions(pdev, KBUILD_MODNAME);
-	if (err) {
-		/* Just info, some other driver may have claimed the device. */
-		dev_info(&pdev->dev, "cannot obtain PCI resources\n");
+	err = cxgb4_pci_resource_init(adapter);
+	if (err < 0)
 		return err;
-	}
-
-	err = pci_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "cannot enable PCI device\n");
-		goto out_release_regions;
-	}
-
-	regs = pci_ioremap_bar(pdev, 0);
-	if (!regs) {
-		dev_err(&pdev->dev, "cannot map device registers\n");
-		err = -ENOMEM;
-		goto out_disable_device;
-	}
 
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter) {
-		err = -ENOMEM;
-		goto out_unmap_bar0;
-	}
-
-	adapter->regs = regs;
-	err = t4_wait_dev_ready(regs);
+	err = t4_wait_dev_ready(adapter->regs);
 	if (err < 0)
-		goto out_free_adapter;
-
-	/* We control everything through one PF */
-	whoami = t4_read_reg(adapter, PL_WHOAMI_A);
-	pci_read_config_word(pdev, PCI_DEVICE_ID, &device_id);
-	chip = t4_get_chip_type(adapter, CHELSIO_PCI_ID_VER(device_id));
-	if ((int)chip < 0) {
-		dev_err(&pdev->dev, "Device %d is not supported\n", device_id);
-		err = chip;
-		goto out_free_adapter;
-	}
-	chip_ver = CHELSIO_CHIP_VERSION(chip);
-	func = chip_ver <= CHELSIO_T5 ?
-	       SOURCEPF_G(whoami) : T6_SOURCEPF_G(whoami);
+		goto out_free_resources;
 
-	adapter->pdev = pdev;
-	adapter->pdev_dev = &pdev->dev;
-	adapter->name = pci_name(pdev);
-	adapter->mbox = func;
-	adapter->pf = func;
-	adapter->params.chip = chip;
 	adapter->adap_idx = adap_idx;
-	adapter->msg_enable = DFLT_MSG_ENABLE;
-	adapter->mbox_log = kzalloc(sizeof(*adapter->mbox_log) +
-				    (sizeof(struct mbox_cmd) *
-				     T4_OS_LOG_MBOX_CMDS),
-				    GFP_KERNEL);
-	if (!adapter->mbox_log) {
-		err = -ENOMEM;
-		goto out_free_adapter;
-	}
-	spin_lock_init(&adapter->mbox_lock);
-	INIT_LIST_HEAD(&adapter->mlist.list);
-	adapter->mbox_log->size = T4_OS_LOG_MBOX_CMDS;
-	pci_set_drvdata(pdev, adapter);
+	err = cxgb4_pci_chip_init(adapter);
+	if (err < 0)
+		goto out_free_resources;
 
-	if (func != ent->driver_data) {
-		pci_disable_device(pdev);
-		pci_save_state(pdev);        /* to restore SR-IOV later */
+	if (!cxgb4_is_primary_pf(adapter))
 		return 0;
-	}
-
-	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_err(&pdev->dev, "no usable DMA configuration\n");
-		goto out_free_adapter;
-	}
 
-	pci_set_master(pdev);
-	pci_save_state(pdev);
-	adap_idx++;
-	adapter->workq = create_singlethread_workqueue("cxgb4");
-	if (!adapter->workq) {
-		err = -ENOMEM;
-		goto out_free_adapter;
-	}
+	/* Everything from here down is now the Primary Physical Function!
+	 */
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 
 	/* PCI device has been enabled */
 	adapter->flags |= CXGB4_DEV_ENABLED;
 	memset(adapter->chan_map, 0xff, sizeof(adapter->chan_map));
+	adap_idx++;
+	/* Default message set for the interfaces. This can be changed later
+	 * via "ethtool -s ethX msglvl N".
+	 */
+	adapter->msg_enable = DFLT_MSG_ENABLE;
+
+	err = cxgb4_workqueues_create(adapter);
+	if (err < 0)
+		goto out_free_adapter;
 
 	/* If possible, we use PCIe Relaxed Ordering Attribute to deliver
 	 * Ingress Packet Data to Free List Buffers in order to allow for
@@ -6686,7 +6699,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * PCIe configuration space to see if it's flagged with advice against
 	 * using Relaxed Ordering.
 	 */
-	if (!pcie_relaxed_ordering_enabled(pdev))
+	if (!pcie_relaxed_ordering_enabled(adapter->pdev))
 		adapter->flags |= CXGB4_ROOT_NO_RELAXED_ORDERING;
 
 	spin_lock_init(&adapter->stats_lock);
@@ -6713,46 +6726,14 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	if (!is_t4(adapter->params.chip)) {
-		s_qpp = (QUEUESPERPAGEPF0_S +
-			(QUEUESPERPAGEPF1_S - QUEUESPERPAGEPF0_S) *
-			adapter->pf);
-		qpp = 1 << QUEUESPERPAGEPF0_G(t4_read_reg(adapter,
-		      SGE_EGRESS_QUEUES_PER_PAGE_PF_A) >> s_qpp);
-		num_seg = PAGE_SIZE / SEGMENT_SIZE;
-
-		/* Each segment size is 128B. Write coalescing is enabled only
-		 * when SGE_EGRESS_QUEUES_PER_PAGE_PF reg value for the
-		 * queue is less no of segments that can be accommodated in
-		 * a page size.
-		 */
-		if (qpp > num_seg) {
-			dev_err(&pdev->dev,
-				"Incorrect number of egress queues per page\n");
-			err = -EINVAL;
-			goto out_free_adapter;
-		}
-		adapter->bar2 = ioremap_wc(pci_resource_start(pdev, 2),
-		pci_resource_len(pdev, 2));
-		if (!adapter->bar2) {
-			dev_err(&pdev->dev, "cannot map device bar2 region\n");
-			err = -ENOMEM;
-			goto out_free_adapter;
-		}
-	}
-
-	setup_memwin(adapter);
+	cxgb4_pci_setup_memwin(adapter);
 	err = adap_init0(adapter, 0);
 	if (err)
-		goto out_unmap_bar;
-
-	setup_memwin_rdma(adapter);
+		dev_err(adapter->pdev_dev,
+			"Adapter initialization failed, error %d. Continuing in debug mode\n",
+			-err);
 
-	/* configure SGE_STAT_CFG_A to read WC stats */
-	if (!is_t4(adapter->params.chip))
-		t4_write_reg(adapter, SGE_STAT_CFG_A, STATSOURCE_T5_V(7) |
-			     (is_t5(adapter->params.chip) ? STATMODE_V(0) :
-			      T6_STATMODE_V(0)));
+	cxgb4_pci_setup_memwin_rdma(adapter);
 
 	/* Initialize hash mac addr list */
 	INIT_LIST_HEAD(&adapter->mac_hlist);
@@ -6765,20 +6746,20 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * know the actual # of EOTIDs supported.
 		 */
 		netdev = alloc_etherdev_mq(sizeof(struct port_info),
-					   MAX_ETH_QSETS + MAX_ATIDS);
+					   MAX_ETH_QSETS + CXGB4_MAX_ATIDS);
 		if (!netdev) {
 			err = -ENOMEM;
 			goto out_free_dev;
 		}
 
-		SET_NETDEV_DEV(netdev, &pdev->dev);
+		SET_NETDEV_DEV(netdev, adapter->pdev_dev);
 
 		adapter->port[i] = netdev;
 		pi = netdev_priv(netdev);
 		pi->adapter = adapter;
 		pi->xact_addr_filt = -1;
 		pi->port_id = i;
-		netdev->irq = pdev->irq;
+		netdev->irq = adapter->pdev->irq;
 
 		netdev->hw_features = NETIF_F_SG | TSO_FLAGS |
 			NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
@@ -6812,13 +6793,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			refcount_set(&pi->adapter->chcr_ktls.ktls_refcount, 0);
 		}
 #endif /* CONFIG_CHELSIO_TLS_DEVICE */
-#if IS_ENABLED(CONFIG_CHELSIO_IPSEC_INLINE)
-		if (pi->adapter->params.crypto & FW_CAPS_CONFIG_IPSEC_INLINE) {
-			netdev->hw_enc_features |= NETIF_F_HW_ESP;
-			netdev->features |= NETIF_F_HW_ESP;
-			netdev->xfrmdev_ops = &cxgb4_xfrmdev_ops;
-		}
-#endif /* CONFIG_CHELSIO_IPSEC_INLINE */
 
 		netdev->priv_flags |= IFF_UNICAST_FLT;
 
@@ -6837,10 +6811,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	cxgb4_init_ethtool_dump(adapter);
 
-	pci_set_drvdata(pdev, adapter);
-
 	if (adapter->flags & CXGB4_FW_OK) {
-		err = t4_port_init(adapter, func, func, 0);
+		err = t4_port_init(adapter, adapter->mbox, adapter->pf, 0);
 		if (err)
 			goto out_free_dev;
 	} else if (adapter->params.nports == 1) {
@@ -6859,6 +6831,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					      hex2val(na[2 * i + 1]));
 			t4_set_hw_addr(adapter, 0, hw_addr);
 		}
+
+		adapter->tids.tid_base = t4_read_reg(adapter, LE_DB_ACTIVE_TABLE_START_INDEX_A);
 	}
 
 	if (!(adapter->flags & CXGB4_FW_OK))
@@ -6874,13 +6848,13 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->smt = t4_init_smt();
 	if (!adapter->smt) {
 		/* We tolerate a lack of SMT, giving up some functionality */
-		dev_warn(&pdev->dev, "could not allocate SMT, continuing\n");
+		dev_warn(adapter->pdev_dev, "could not allocate SMT, continuing\n");
 	}
 
 	adapter->l2t = t4_init_l2t(adapter->l2t_start, adapter->l2t_end);
 	if (!adapter->l2t) {
 		/* We tolerate a lack of L2T, giving up some functionality */
-		dev_warn(&pdev->dev, "could not allocate L2T, continuing\n");
+		dev_warn(adapter->pdev_dev, "could not allocate L2T, continuing\n");
 		adapter->params.offload = 0;
 	}
 
@@ -6890,9 +6864,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* CLIP functionality is not present in hardware,
 		 * hence disable all offload features
 		 */
-		dev_warn(&pdev->dev,
+		dev_warn(adapter->pdev_dev,
 			 "CLIP not enabled in hardware, continuing\n");
-		adapter->params.offload = 0;
 	} else {
 		adapter->clipt = t4_init_clip_tbl(adapter->clipt_start,
 						  adapter->clipt_end);
@@ -6900,9 +6873,8 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			/* We tolerate a lack of clip_table, giving up
 			 * some functionality
 			 */
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not allocate Clip table, continuing\n");
-			adapter->params.offload = 0;
 		}
 	}
 #endif
@@ -6911,73 +6883,46 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pi = adap2pinfo(adapter, i);
 		pi->sched_tbl = t4_init_sched(adapter->params.nsched_cls);
 		if (!pi->sched_tbl)
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not activate scheduling on port %d\n",
 				 i);
 	}
 
-	if (is_offload(adapter) || is_hashfilter(adapter)) {
-		if (t4_read_reg(adapter, LE_DB_CONFIG_A) & HASHEN_F) {
-			u32 v;
-
-			v = t4_read_reg(adapter, LE_DB_HASH_CONFIG_A);
-			if (chip_ver <= CHELSIO_T5) {
-				adapter->tids.nhash = 1 << HASHTIDSIZE_G(v);
-				v = t4_read_reg(adapter, LE_DB_TID_HASHBASE_A);
-				adapter->tids.hash_base = v / 4;
-			} else {
-				adapter->tids.nhash = HASHTBLSIZE_G(v) << 3;
-				v = t4_read_reg(adapter,
-						T6_LE_DB_HASH_TID_BASE_A);
-				adapter->tids.hash_base = v;
-			}
-		}
-	}
-
 	if (tid_init(&adapter->tids) < 0) {
-		dev_warn(&pdev->dev, "could not allocate TID table, "
+		dev_warn(adapter->pdev_dev, "could not allocate TID table, "
 			 "continuing\n");
 		adapter->params.offload = 0;
 	} else {
 		adapter->tc_u32 = cxgb4_init_tc_u32(adapter);
 		if (!adapter->tc_u32)
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc u32, continuing\n");
 
 		if (cxgb4_init_tc_flower(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc flower, continuing\n");
 
 		if (cxgb4_init_tc_mqprio(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc mqprio, continuing\n");
 
 		if (cxgb4_init_tc_matchall(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not offload tc matchall, continuing\n");
 		if (cxgb4_init_ethtool_filters(adapter))
-			dev_warn(&pdev->dev,
+			dev_warn(adapter->pdev_dev,
 				 "could not initialize ethtool filters, continuing\n");
 	}
 
-	/* See what interrupts we'll be using */
-	if (msi > 1 && enable_msix(adapter) == 0)
-		adapter->flags |= CXGB4_USING_MSIX;
-	else if (msi > 0 && pci_enable_msi(pdev) == 0) {
-		adapter->flags |= CXGB4_USING_MSI;
-		if (msi > 1)
-			free_msix_info(adapter);
-	}
-
-	/* check for PCI Express bandwidth capabiltites */
-	pcie_print_link_status(pdev);
-
-	cxgb4_init_mps_ref_entries(adapter);
-
 	err = init_rss(adapter);
 	if (err)
 		goto out_free_dev;
 
+	/* See what interrupts we'll be using */
+	err = enable_msix(adapter);
+	if (err)
+		goto out_disable_interrupts;
+
 	err = setup_non_data_intr(adapter);
 	if (err) {
 		dev_err(adapter->pdev_dev,
@@ -6993,6 +6938,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 fw_attach_fail:
+	cxgb4_init_mps_ref_entries(adapter);
 	/*
 	 * The card is now ready to go.  If any errors occur during device
 	 * registration we do not fail the whole card but rather proceed only
@@ -7010,26 +6956,40 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = register_netdev(adapter->port[i]);
 		if (err)
 			break;
-		adapter->chan_map[pi->tx_chan] = i;
+
+		u8 idx, nchan;
+
+		switch (adapter->params.tp.lb_mode) {
+		case 1:
+			nchan = 4;
+			break;
+		case 2:
+			nchan = 2;
+			break;
+		default:
+			nchan = 1;
+			break;
+		}
+
+		for (idx = 0; idx < nchan; idx++)
+			adapter->chan_map[pi->lport * nchan + idx] = i;
 		print_port_info(adapter->port[i]);
 	}
 	if (i == 0) {
-		dev_err(&pdev->dev, "could not register any net devices\n");
+		dev_err(adapter->pdev_dev, "could not register any net devices\n");
 		goto out_free_dev;
 	}
 	if (err) {
-		dev_warn(&pdev->dev, "only %d net devices registered\n", i);
+		dev_warn(adapter->pdev_dev, "only %d net devices registered\n", i);
 		err = 0;
 	}
 
 	if (cxgb4_debugfs_root) {
-		adapter->debugfs_root = debugfs_create_dir(pci_name(pdev),
-							   cxgb4_debugfs_root);
-		setup_debugfs(adapter);
-	}
+		const char *dir_name = pci_name(adapter->pdev);
 
-	/* PCIe EEH recovery on powerpc platforms needs fundamental reset */
-	pdev->needs_freset = 1;
+		adapter->debugfs_root = debugfs_create_dir(dir_name, cxgb4_debugfs_root);
+		cxgb4_setup_debugfs(adapter);
+	}
 
 	if (is_uld(adapter))
 		cxgb4_uld_enable(adapter);
@@ -7044,40 +7004,31 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	print_adapter_info(adapter);
 	return 0;
 
- out_free_dev:
+out_disable_interrupts:
+	disable_msi(adapter);
+
+out_free_dev:
 	t4_free_sge_resources(adapter);
 	free_some_resources(adapter);
 	if (adapter->flags & CXGB4_USING_MSIX)
 		free_msix_info(adapter);
 	if (adapter->num_uld || adapter->num_ofld_uld)
 		t4_uld_mem_free(adapter);
- out_unmap_bar:
-	if (!is_t4(adapter->params.chip))
-		iounmap(adapter->bar2);
- out_free_adapter:
-	if (adapter->workq)
-		destroy_workqueue(adapter->workq);
-
-	kfree(adapter->mbox_log);
-	kfree(adapter);
- out_unmap_bar0:
-	iounmap(regs);
- out_disable_device:
-	pci_disable_device(pdev);
- out_release_regions:
-	pci_release_regions(pdev);
+out_free_adapter:
+	cxgb4_workqueues_destroy(adapter);
+	cxgb4_pci_chip_free(adapter);
+
+out_free_resources:
+	cxgb4_pci_resource_free(adapter);
 	return err;
 }
 
-static void remove_one(struct pci_dev *pdev)
+void cxgb4_adap_remove(struct adapter *adapter)
 {
-	struct adapter *adapter = pci_get_drvdata(pdev);
 	struct hash_mac_addr *entry, *tmp;
 
-	if (!adapter) {
-		pci_release_regions(pdev);
+	if (!adapter)
 		return;
-	}
 
 	/* If we allocated filters, free up state associated with any
 	 * valid filters ...
@@ -7086,26 +7037,26 @@ static void remove_one(struct pci_dev *pdev)
 
 	adapter->flags |= CXGB4_SHUTTING_DOWN;
 
-	if (adapter->pf == 4) {
+	if (cxgb4_is_primary_pf(adapter)) {
 		int i;
 
 		/* Tear down per-adapter Work Queue first since it can contain
 		 * references to our adapter data structure.
 		 */
-		destroy_workqueue(adapter->workq);
+		cxgb4_workqueues_destroy(adapter);
 
-		detach_ulds(adapter);
+		if (is_uld(adapter)) {
+			if (!list_empty(&adapter->list_node))
+				detach_ulds(adapter);
+			t4_uld_clean_up(adapter);
+		}
+		adap_free_hma_mem(adapter);
+		disable_interrupts(adapter);
 
 		for_each_port(adapter, i)
 			if (adapter->port[i]->reg_state == NETREG_REGISTERED)
 				unregister_netdev(adapter->port[i]);
 
-		t4_uld_clean_up(adapter);
-
-		adap_free_hma_mem(adapter);
-
-		disable_interrupts(adapter);
-
 		cxgb4_free_mps_ref_entries(adapter);
 
 		debugfs_remove_recursive(adapter->debugfs_root);
@@ -7122,6 +7073,7 @@ static void remove_one(struct pci_dev *pdev)
 			free_msix_info(adapter);
 		if (adapter->num_uld || adapter->num_ofld_uld)
 			t4_uld_mem_free(adapter);
+
 		free_some_resources(adapter);
 		list_for_each_entry_safe(entry, tmp, &adapter->mac_hlist,
 					 list) {
@@ -7132,23 +7084,16 @@ static void remove_one(struct pci_dev *pdev)
 #if IS_ENABLED(CONFIG_IPV6)
 		t4_cleanup_clip_tbl(adapter);
 #endif
-		if (!is_t4(adapter->params.chip))
-			iounmap(adapter->bar2);
 	}
 #ifdef CONFIG_PCI_IOV
 	else {
-		cxgb4_iov_configure(adapter->pdev, 0);
+		cxgb4_pci_iov_configure(adapter, 0);
 	}
 #endif
-	iounmap(adapter->regs);
-	if ((adapter->flags & CXGB4_DEV_ENABLED)) {
-		pci_disable_device(pdev);
-		adapter->flags &= ~CXGB4_DEV_ENABLED;
-	}
-	pci_release_regions(pdev);
-	kfree(adapter->mbox_log);
+	cxgb4_pci_chip_free(adapter);
+	cxgb4_pci_resource_free(adapter);
+	adapter->flags &= ~CXGB4_DEV_ENABLED;
 	synchronize_rcu();
-	kfree(adapter);
 }
 
 /* "Shutdown" quiesces the device, stopping Ingress Packet and Interrupt
@@ -7156,22 +7101,18 @@ static void remove_one(struct pci_dev *pdev)
  * function where we do the minimal amount of work necessary to shutdown any
  * further activity.
  */
-static void shutdown_one(struct pci_dev *pdev)
+void cxgb4_adap_shutdown(struct adapter *adapter)
 {
-	struct adapter *adapter = pci_get_drvdata(pdev);
-
 	/* As with remove_one() above (see extended comment), we only want do
 	 * do cleanup on PCI Devices which went all the way through init_one()
 	 * ...
 	 */
-	if (!adapter) {
-		pci_release_regions(pdev);
+	if (!adapter)
 		return;
-	}
 
 	adapter->flags |= CXGB4_SHUTTING_DOWN;
 
-	if (adapter->pf == 4) {
+	if (cxgb4_is_primary_pf(adapter)) {
 		int i;
 
 		for_each_port(adapter, i)
@@ -7192,37 +7133,25 @@ static void shutdown_one(struct pci_dev *pdev)
 
 		t4_sge_stop(adapter);
 		if (adapter->flags & CXGB4_FW_OK)
-			t4_fw_bye(adapter, adapter->mbox);
+			cxgb4_pci_fw_free(adapter);
 	}
 }
 
-static struct pci_driver cxgb4_driver = {
-	.name     = KBUILD_MODNAME,
-	.id_table = cxgb4_pci_tbl,
-	.probe    = init_one,
-	.remove   = remove_one,
-	.shutdown = shutdown_one,
-#ifdef CONFIG_PCI_IOV
-	.sriov_configure = cxgb4_iov_configure,
-#endif
-	.err_handler = &cxgb4_eeh,
-};
-
 static int __init cxgb4_init_module(void)
 {
 	int ret;
 
 	cxgb4_debugfs_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	ret = pci_register_driver(&cxgb4_driver);
+	ret = cxgb4_pci_driver_register();
 	if (ret < 0)
-		goto err_pci;
+		goto out_err;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!inet6addr_registered) {
 		ret = register_inet6addr_notifier(&cxgb4_inet6addr_notifier);
 		if (ret)
-			pci_unregister_driver(&cxgb4_driver);
+			cxgb4_pci_driver_unregister();
 		else
 			inet6addr_registered = true;
 	}
@@ -7230,10 +7159,8 @@ static int __init cxgb4_init_module(void)
 
 	if (ret == 0)
 		return ret;
-
-err_pci:
+out_err:
 	debugfs_remove(cxgb4_debugfs_root);
-
 	return ret;
 }
 
@@ -7245,7 +7172,7 @@ static void __exit cxgb4_cleanup_module(void)
 		inet6addr_registered = false;
 	}
 #endif
-	pci_unregister_driver(&cxgb4_driver);
+	cxgb4_pci_driver_unregister();
 	debugfs_remove(cxgb4_debugfs_root);  /* NULL ok */
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
index 94c8ce39310b..ef514fe53b95 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_mps.c
@@ -28,6 +28,28 @@ static int cxgb4_mps_ref_dec_by_mac(struct adapter *adap,
 	return ret;
 }
 
+static int cxgb4_mps_ref_dec(struct adapter *adap, u16 idx)
+{
+	struct mps_entries_ref *mps_entry, *tmp;
+	int ret = -EINVAL;
+
+	spin_lock(&adap->mps_ref_lock);
+	list_for_each_entry_safe(mps_entry, tmp, &adap->mps_ref, list) {
+		if (mps_entry->idx == idx) {
+			if (!refcount_dec_and_test(&mps_entry->refcnt)) {
+				spin_unlock(&adap->mps_ref_lock);
+				return -EBUSY;
+			}
+			list_del(&mps_entry->list);
+			kfree(mps_entry);
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock(&adap->mps_ref_lock);
+	return ret;
+}
+
 static int cxgb4_mps_ref_inc(struct adapter *adap, const u8 *mac_addr,
 			     u16 idx, const u8 *mask)
 {
@@ -119,6 +141,36 @@ int cxgb4_update_mac_filt(struct port_info *pi, unsigned int viid,
 	return ret;
 }
 
+int cxgb4_free_encap_mac_filt(struct adapter *adap, unsigned int viid,
+			      int idx, bool sleep_ok)
+{
+	int ret = 0;
+
+	if (!cxgb4_mps_ref_dec(adap, idx))
+		ret = t4_free_encap_mac_filt(adap, viid, idx, sleep_ok);
+
+	return ret;
+}
+
+int cxgb4_alloc_encap_mac_filt(struct adapter *adap, unsigned int viid,
+			       const u8 *addr, const u8 *mask,
+			       unsigned int vni, unsigned int vni_mask,
+			       u8 dip_hit, u8 lookup_type, bool sleep_ok)
+{
+	int ret;
+
+	ret = t4_alloc_encap_mac_filt(adap, viid, addr, mask, vni, vni_mask,
+				      dip_hit, lookup_type, sleep_ok);
+	if (ret < 0)
+		return ret;
+
+	if (cxgb4_mps_ref_inc(adap, addr, ret, mask)) {
+		ret = -ENOMEM;
+		t4_free_encap_mac_filt(adap, viid, ret, sleep_ok);
+	}
+	return ret;
+}
+
 int cxgb4_init_mps_ref_entries(struct adapter *adap)
 {
 	spin_lock_init(&adap->mps_ref_lock);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
index cbd06d9b95d4..6b19b439ad92 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ptp.c
@@ -103,12 +103,14 @@ void cxgb4_ptp_read_hwstamp(struct adapter *adapter, struct port_info *pi)
 
 	skb_ts = skb_hwtstamps(adapter->ptp_tx_skb);
 
-	tx_ts = t4_read_reg(adapter,
-			    T5_PORT_REG(pi->port_id, MAC_PORT_TX_TS_VAL_LO));
-
-	tx_ts |= (u64)t4_read_reg(adapter,
-				  T5_PORT_REG(pi->port_id,
-					      MAC_PORT_TX_TS_VAL_HI)) << 32;
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7)
+		tx_ts = t4_read_reg64(adapter,
+				      T7_PORT_REG(pi->port_id,
+						  T7_MAC_PORT_TX_TS_VAL_LO));
+	else
+		tx_ts = t4_read_reg64(adapter,
+				      T5_PORT_REG(pi->port_id,
+						  MAC_PORT_TX_TS_VAL_LO));
 	skb_ts->hwtstamp = ns_to_ktime(tx_ts);
 	skb_tstamp_tx(adapter->ptp_tx_skb, skb_ts);
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
@@ -319,9 +321,12 @@ static int cxgb4_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 					       ptp_clock_info);
 	u64 ns;
 
-	ns = t4_read_reg(adapter, T5_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
-	ns |= (u64)t4_read_reg(adapter,
-			       T5_PORT_REG(0, MAC_PORT_PTP_SUM_HI_A)) << 32;
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7)
+		ns = t4_read_reg64(adapter,
+				   T7_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
+	else
+		ns = t4_read_reg64(adapter,
+				   T5_PORT_REG(0, MAC_PORT_PTP_SUM_LO_A));
 
 	/* convert to timespec*/
 	*ts = ns_to_timespec64(ns);
@@ -432,7 +437,7 @@ void cxgb4_ptp_init(struct adapter *adapter)
 	spin_lock_init(&adapter->ptp_lock);
 
 	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_clock_info,
-						&adapter->pdev->dev);
+						adapter->pdev_dev);
 	if (IS_ERR_OR_NULL(adapter->ptp_clock)) {
 		adapter->ptp_clock = NULL;
 		dev_err(adapter->pdev_dev,
-- 
2.39.1


