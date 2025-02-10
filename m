Return-Path: <netdev+bounces-164752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52FA2EF5C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59213A6E2E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E63235365;
	Mon, 10 Feb 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bp1bHjE2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DF23313D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196632; cv=none; b=lsZuKWE+Z9fMnlfsEqkA1mYemktIDIa5viSoVAO9LEF6JHXlTrWd0rko5n6UGL1XEJesXZ6hM4jRw3b4UyXExn0452UE5hD0Mtfd8BfKkeXx91pMX8yfB1P8y3mhQQH3MLxSQaxIbApGZcIPjfzSlDJ0bSikpTBQQeCqAJJUfdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196632; c=relaxed/simple;
	bh=B5Wl0asnVYwaiT18jKtPr8S6EHLVgSc7XerVfSTBbko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUXj38uNjaEyWqOzFNdmczBqLtli5MnQbbmsuY44wutm3vO4bxv/seXgH/X+mD6drRyD6yfdQJ2UK4zYjbL0X497ytSi7P/Q1jvn6xiMjkR+GUbUvfD2NPtCQs99m6xZC3i6X3mAMxBwAwAVhphbq8Hwmtbsgpj8eO3bfb/lhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bp1bHjE2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196631; x=1770732631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5Wl0asnVYwaiT18jKtPr8S6EHLVgSc7XerVfSTBbko=;
  b=bp1bHjE2PnCTL0b6auabIOaGmUGqH0UFonk8C4vaWEWjJJ6T5FNWuJ+T
   SLRZTZb278rcgEjl2fWSUBSoiZ367RsBnodXruN8Y3+nQNnTCybGw1NlA
   IUoCnuukGD4bvE/7xtg8Q4srKe113CSUbzD4jaRvm2O5lSVJOTm+gGGRk
   HUalycFTqj6JCo8U0IKasWewPiChrsheZz4oJ8xX5neYzHF+2k9J+acPT
   m0SobpJue/ziBypMf0VgrEmfk2x6ed7Xx14V6eFas076DyRG/1QeqliYm
   wP32eCV18miaieS3tKTBTtFl6Goz21+N2yWcMg91YJG4GDLH2b4za1QsI
   w==;
X-CSE-ConnectionGUID: ORc4rpFhQP2hoKS9eforyg==
X-CSE-MsgGUID: QZrqEeEWTwm5+YENr/51Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57190391"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57190391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:10:31 -0800
X-CSE-ConnectionGUID: n1bqT8uyT0CfJs4F1iz7kA==
X-CSE-MsgGUID: IhfPuBIWRHKBPpCt10+2Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="111964203"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 10 Feb 2025 06:10:28 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v2 05/13] ixgbe: read the netlist version information
Date: Mon, 10 Feb 2025 14:56:31 +0100
Message-Id: <20250210135639.68674-6-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
References: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>

Add functions reading the netlist version info and use them
as a part of the setting NVM info procedure.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 112 ++++++++++++++++++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  33 ++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 236c804f03c6..e49e699fb141 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2579,6 +2579,33 @@ static int ixgbe_read_nvm_module(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_read_netlist_module - Read data from the netlist module area
+ * @hw: pointer to the HW structure
+ * @bank: whether to read from the active or inactive module
+ * @offset: offset into the netlist to read from
+ * @data: storage for returned word value
+ *
+ * Read a word from the specified netlist bank.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_read_netlist_module(struct ixgbe_hw *hw,
+				     enum ixgbe_bank_select bank,
+				     u32 offset, u16 *data)
+{
+	__le16 data_local;
+	int err;
+
+	err = ixgbe_read_flash_module(hw, bank, IXGBE_E610_SR_NETLIST_BANK_PTR,
+				      offset * sizeof(data_local),
+				      (u8 *)&data_local, sizeof(data_local));
+	if (!err)
+		*data = le16_to_cpu(data_local);
+
+	return err;
+}
+
 /**
  * ixgbe_read_orom_module - Read from the active Option ROM module
  * @hw: pointer to the HW structure
@@ -2884,6 +2911,86 @@ static int ixgbe_get_nvm_ver_info(struct ixgbe_hw *hw,
 	return 0;
 }
 
+/**
+ * ixgbe_get_netlist_info - Read the netlist version information
+ * @hw: pointer to the HW struct
+ * @bank: whether to read from the active or inactive flash bank
+ * @netlist: pointer to netlist version info structure
+ *
+ * Get the netlist version information from the requested bank. Reads the Link
+ * Topology section to find the Netlist ID block and extract the relevant
+ * information into the netlist version structure.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_netlist_info(struct ixgbe_hw *hw,
+				  enum ixgbe_bank_select bank,
+				  struct ixgbe_netlist_info *netlist)
+{
+	u16 module_id, length, node_count, i;
+	u16 *id_blk;
+	int err;
+
+	err = ixgbe_read_netlist_module(hw, bank, IXGBE_NETLIST_TYPE_OFFSET,
+					&module_id);
+	if (err)
+		return err;
+
+	if (module_id != IXGBE_NETLIST_LINK_TOPO_MOD_ID)
+		return -EIO;
+
+	err = ixgbe_read_netlist_module(hw, bank, IXGBE_LINK_TOPO_MODULE_LEN,
+					&length);
+	if (err)
+		return err;
+
+	/* Sanity check that we have at least enough words to store the
+	 * netlist ID block.
+	 */
+	if (length < IXGBE_NETLIST_ID_BLK_SIZE)
+		return -EIO;
+
+	err = ixgbe_read_netlist_module(hw, bank, IXGBE_LINK_TOPO_NODE_COUNT,
+					&node_count);
+	if (err)
+		return err;
+
+	node_count &= IXGBE_LINK_TOPO_NODE_COUNT_M;
+
+	id_blk = kcalloc(IXGBE_NETLIST_ID_BLK_SIZE, sizeof(*id_blk), GFP_KERNEL);
+	if (!id_blk)
+		return -ENOMEM;
+
+	/* Read out the entire Netlist ID Block at once. */
+	err = ixgbe_read_flash_module(hw, bank, IXGBE_E610_SR_NETLIST_BANK_PTR,
+				      IXGBE_NETLIST_ID_BLK_OFFSET(node_count) *
+				      sizeof(*id_blk), (u8 *)id_blk,
+				      IXGBE_NETLIST_ID_BLK_SIZE *
+				      sizeof(*id_blk));
+	if (err)
+		goto free_id_blk;
+
+	for (i = 0; i < IXGBE_NETLIST_ID_BLK_SIZE; i++)
+		id_blk[i] = le16_to_cpu(((__le16 *)id_blk)[i]);
+
+	netlist->major = id_blk[IXGBE_NETLIST_ID_BLK_MAJOR_VER_HIGH] << 16 |
+			 id_blk[IXGBE_NETLIST_ID_BLK_MAJOR_VER_LOW];
+	netlist->minor = id_blk[IXGBE_NETLIST_ID_BLK_MINOR_VER_HIGH] << 16 |
+			 id_blk[IXGBE_NETLIST_ID_BLK_MINOR_VER_LOW];
+	netlist->type = id_blk[IXGBE_NETLIST_ID_BLK_TYPE_HIGH] << 16 |
+			id_blk[IXGBE_NETLIST_ID_BLK_TYPE_LOW];
+	netlist->rev = id_blk[IXGBE_NETLIST_ID_BLK_REV_HIGH] << 16 |
+		       id_blk[IXGBE_NETLIST_ID_BLK_REV_LOW];
+	netlist->cust_ver = id_blk[IXGBE_NETLIST_ID_BLK_CUST_VER];
+	/* Read the left most 4 bytes of SHA */
+	netlist->hash = id_blk[IXGBE_NETLIST_ID_BLK_SHA_HASH_WORD(15)] << 16 |
+			id_blk[IXGBE_NETLIST_ID_BLK_SHA_HASH_WORD(14)];
+
+free_id_blk:
+	kfree(id_blk);
+	return err;
+}
+
 /**
  * ixgbe_get_flash_data - get flash data
  * @hw: pointer to the HW struct
@@ -2936,6 +3043,11 @@ int ixgbe_get_flash_data(struct ixgbe_hw *hw)
 
 	err = ixgbe_get_orom_ver_info(hw, IXGBE_ACTIVE_FLASH_BANK,
 				      &flash->orom);
+	if (err)
+		return err;
+
+	err = ixgbe_get_netlist_info(hw, IXGBE_ACTIVE_FLASH_BANK,
+				     &flash->netlist);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 9b04075edd4a..a1c963cf7127 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -45,6 +45,39 @@
 /* Shadow RAM related */
 #define IXGBE_SR_WORDS_IN_1KB	512
 
+/* The Netlist ID Block is located after all of the Link Topology nodes. */
+#define IXGBE_NETLIST_ID_BLK_SIZE		0x30
+#define IXGBE_NETLIST_ID_BLK_OFFSET(n)		IXGBE_NETLIST_LINK_TOPO_OFFSET(0x0004 + 2 * (n))
+
+/* netlist ID block field offsets (word offsets) */
+#define IXGBE_NETLIST_ID_BLK_MAJOR_VER_LOW	0x02
+#define IXGBE_NETLIST_ID_BLK_MAJOR_VER_HIGH	0x03
+#define IXGBE_NETLIST_ID_BLK_MINOR_VER_LOW	0x04
+#define IXGBE_NETLIST_ID_BLK_MINOR_VER_HIGH	0x05
+#define IXGBE_NETLIST_ID_BLK_TYPE_LOW		0x06
+#define IXGBE_NETLIST_ID_BLK_TYPE_HIGH		0x07
+#define IXGBE_NETLIST_ID_BLK_REV_LOW		0x08
+#define IXGBE_NETLIST_ID_BLK_REV_HIGH		0x09
+#define IXGBE_NETLIST_ID_BLK_SHA_HASH_WORD(n)	(0x0A + (n))
+#define IXGBE_NETLIST_ID_BLK_CUST_VER		0x2F
+
+/* The Link Topology Netlist section is stored as a series of words. It is
+ * stored in the NVM as a TLV, with the first two words containing the type
+ * and length.
+ */
+#define IXGBE_NETLIST_LINK_TOPO_MOD_ID		0x011B
+#define IXGBE_NETLIST_TYPE_OFFSET		0x0000
+#define IXGBE_NETLIST_LEN_OFFSET		0x0001
+
+/* The Link Topology section follows the TLV header. When reading the netlist
+ * using ixgbe_read_netlist_module, we need to account for the 2-word TLV
+ * header.
+ */
+#define IXGBE_NETLIST_LINK_TOPO_OFFSET(n)	((n) + 2)
+#define IXGBE_LINK_TOPO_MODULE_LEN	IXGBE_NETLIST_LINK_TOPO_OFFSET(0x0000)
+#define IXGBE_LINK_TOPO_NODE_COUNT	IXGBE_NETLIST_LINK_TOPO_OFFSET(0x0001)
+#define IXGBE_LINK_TOPO_NODE_COUNT_M		GENMASK_ULL(9, 0)
+
 /* Firmware Status Register (GL_FWSTS) */
 #define GL_FWSTS		0x00083048 /* Reset Source: POR */
 #define GL_FWSTS_EP_PF0		BIT(24)
-- 
2.31.1


