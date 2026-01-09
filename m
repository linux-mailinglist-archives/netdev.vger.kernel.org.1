Return-Path: <netdev+bounces-248429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D869D08683
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F01302727E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F633A01E;
	Fri,  9 Jan 2026 10:02:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB3336EF1;
	Fri,  9 Jan 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952978; cv=none; b=gMm73z26auRd2nVpC9SFrcPpxZkscKvbfWDdkxQlY8A/hCcf2drpftb4KBVjsdu970rEvsPteQHARgm4YChm+/uAbqClfP2zRLR7R2u8UYWeYNmMDLmX1YVSlEsPa9VESZ840mly1LYcgSLb91A2IW6TGxLpeGKulHcaWALnwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952978; c=relaxed/simple;
	bh=eX6mKcUIZpmOx+E6OSkty/H4iAvlcidYZr4N/BqaKrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrYmVirooQF2yWFHOISbALz/lRg2jE4MnymfZRRDnDh7//TV117RY76GeHaaCivbhBCLwJcwAnIcLBhiO/b0loBZ+lZ1APtasUzcBCWszal322eQeRyy56UFxDG79sjCX7JnQyA9+fYDoPe94Sh2oH+rhvvGiidrmAYuPefAODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAhj_1767952953 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:34 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 06/15] net/nebula-matrix: add resource layer definitions and implementation
Date: Fri,  9 Jan 2026 18:01:24 +0800
Message-ID: <20260109100146.63569-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Resource layer processes the entries/data of various modules within
the processing chip to accomplish specific entry management operations,
this describes the module business capabilities of the chip and the data
it manages.
The resource layer comprises the following sub-modules: common, adminq,
interrupt, txrx, flow, queue, and vsi.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   3 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   7 +
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.c     | 110 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.h     | 160 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 319 ++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 998 ++++++++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |  13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 427 ++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   | 860 +++++++++++++++
 .../nbl/nbl_include/nbl_def_common.h          |  19 +
 .../nbl/nbl_include/nbl_def_hw.h              |  17 +-
 .../nbl/nbl_include/nbl_def_resource.h        | 183 ++++
 .../nbl/nbl_include/nbl_include.h             | 189 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  11 +-
 14 files changed, 3312 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index db04128977d5..977544cd1b95 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -7,7 +7,10 @@ obj-$(CONFIG_NBL_CORE) := nbl_core.o
 nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
+				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_adminq.o \
 				nbl_main.o
 
 # Provide include files
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index fe83bd9f524c..6c7e2549ff8b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -11,6 +11,7 @@
 #include "nbl_product_base.h"
 #include "nbl_def_channel.h"
 #include "nbl_def_hw.h"
+#include "nbl_def_resource.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAP_TO_PDEV(adapter)		((adapter)->pdev)
@@ -19,10 +20,15 @@
 #define NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
 
 #define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
+#define NBL_ADAP_TO_RES_MGT(adapter) ((adapter)->core.res_mgt)
 #define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)
 #define NBL_ADAP_TO_HW_OPS_TBL(adapter) ((adapter)->intf.hw_ops_tbl)
+#define NBL_ADAP_TO_RES_OPS_TBL(adapter) ((adapter)->intf.resource_ops_tbl)
 #define NBL_ADAP_TO_CHAN_OPS_TBL(adapter) ((adapter)->intf.channel_ops_tbl)
 
+#define NBL_ADAPTER_TO_RES_PT_OPS(adapter) \
+	(&(NBL_ADAP_TO_SERV_OPS_TBL(adapter)->pt_ops))
+
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -43,6 +49,7 @@ enum {
 
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_resource_ops_tbl *resource_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
new file mode 100644
index 000000000000..2db160a92256
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_adminq.h"
+
+static int nbl_res_aq_set_sfp_state(void *priv, u8 eth_id, u8 state)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	int param_len = 0;
+	u64 data = 0;
+	u64 key = 0;
+	int ret;
+
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+	key = NBL_PORT_KEY_MODULE_SWITCH;
+	if (state)
+		data = NBL_PORT_SFP_ON + (key << NBL_PORT_KEY_KEY_SHIFT);
+	else
+		data = NBL_PORT_SFP_OFF + (key << NBL_PORT_KEY_KEY_SHIFT);
+
+	memset(param, 0, param_len);
+	param->id = eth_id;
+	param->subop = NBL_PORT_SUBOP_WRITE;
+	param->data[0] = data;
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+		      param_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, sfp %s\n",
+			ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			eth_info->logic_eth_id[eth_id], state ? "on" : "off");
+		kfree(param);
+		return ret;
+	}
+
+	kfree(param);
+	return 0;
+}
+
+int nbl_res_open_sfp(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	return nbl_res_aq_set_sfp_state(res_mgt, eth_id, NBL_SFP_MODULE_ON);
+}
+
+static int nbl_res_aq_get_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	u64 data = 0, key = 0, result = 0;
+	int param_len = 0, i, ret;
+	u8 reverse_mac[ETH_ALEN];
+
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+	key = NBL_PORT_KEY_MAC_ADDRESS;
+
+	data += (key << NBL_PORT_KEY_KEY_SHIFT);
+
+	memset(param, 0, param_len);
+	param->id = eth_id;
+	param->subop = NBL_PORT_SUBOP_READ;
+	param->data[0] = data;
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+		      param_len, &result, sizeof(result), 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d\n",
+			ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			eth_info->logic_eth_id[eth_id]);
+		kfree(param);
+		return ret;
+	}
+
+	memcpy(reverse_mac, &result, ETH_ALEN);
+
+	/*convert mac address*/
+	for (i = 0; i < ETH_ALEN; i++)
+		mac[i] = reverse_mac[ETH_ALEN - 1 - i];
+
+	kfree(param);
+	return 0;
+}
+
+int nbl_res_get_eth_mac(struct nbl_resource_mgt *res_mgt, u8 *mac, u8 eth_id)
+{
+	return nbl_res_aq_get_eth_mac_addr(res_mgt, mac, eth_id);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.h
new file mode 100644
index 000000000000..f4a214856d99
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_ADMINQ_H_
+#define _NBL_ADMINQ_H_
+
+#include "nbl_resource.h"
+
+/* SPI Bank Index */
+#define	BANKID_DESC_BANK		0xA0
+#define	BANKID_BOOT_BANK		0xA1
+#define	BANKID_SR_BANK0			0xA2
+#define	BANKID_SR_BANK1			0xA3
+#define	BANKID_OSI_BANK0		0xA4
+#define	BANKID_OSI_BANK1		0xA5
+#define	BANKID_FSI_BANK0		0xA6
+#define	BANKID_FSI_BANK1		0xA7
+#define	BANKID_HW_BANK			0xA8
+#define	BANKID_NVM_BANK0		0xA9
+#define	BANKID_NVM_BANK1		0xAA
+#define	BANKID_LOG_BANK			0xAB
+
+#define NBL_ADMINQ_IDX_LEN		4096
+
+#define NBL_MAX_HW_I2C_RESP_SIZE	128
+
+#define I2C_DEV_ADDR_A0			0x50
+#define I2C_DEV_ADDR_A2			0x51
+
+/* SFF moudle register addresses: 8 bit valid */
+#define SFF_8472_IDENTIFIER 0x0
+#define SFF_8472_10GB_CAPABILITY 0x3 /* check sff-8472 table 5-3 */
+#define SFF_8472_1GB_CAPABILITY 0x6 /* check sff-8472 table 5-3 */
+#define SFF_8472_CABLE_TECHNOLOGY 0x8 /* check sff-8472 table 5-3 */
+#define SFF_8472_EXTENDED_CAPA 0x24 /* check sff-8024 table 4-4 */
+#define SFF_8472_CABLE_SPEC_COMP 0x3C
+#define SFF_8472_DIAGNOSTIC \
+	0x5C /* digital diagnostic monitoring, relates to A2 */
+#define SFF_8472_COMPLIANCE 0x5E /* the specification revision version */
+#define SFF_8472_VENDOR_NAME 0x14
+#define SFF_8472_VENDOR_NAME_LEN \
+	16 /* 16 bytes, from offset 0x14 to offset 0x23 */
+#define SFF_8472_VENDOR_PN 0x28
+#define SFF_8472_VENDOR_PN_LEN 16
+#define SFF_8472_VENDOR_OUI 0x25 /* name and oui cannot all be empty */
+#define SFF_8472_VENDOR_OUI_LEN 3
+#define SFF_8472_SIGNALING_RATE 0xC
+#define SFF_8472_SIGNALING_RATE_MAX 0x42
+#define SFF_8472_SIGNALING_RATE_MIN 0x43
+/* optional status/control bits: soft rate select and tx disable */
+#define SFF_8472_OSCB			0x6E
+/* extended status/control bits */
+#define SFF_8472_ESCB			0x76
+#define SFF8636_DEVICE_TECH_OFFSET	0x93
+
+#define SFF_8636_VENDOR_ENCODING	0x8B
+#define SFF_8636_ENCODING_PAM4		0x8
+
+/* SFF status code */
+#define SFF_IDENTIFIER_SFP		0x3
+#define SFF_IDENTIFIER_QSFP28		0x11
+#define SFF_IDENTIFIER_PAM4		0x1E
+#define SFF_PASSIVE_CABLE		0x4
+#define SFF_ACTIVE_CABLE		0x8
+#define SFF_8472_ADDRESSING_MODE	0x4
+#define SFF_8472_UNSUPPORTED		0x00
+#define SFF_8472_10G_SR_BIT		4  /* 850nm, short reach */
+#define SFF_8472_10G_LR_BIT		5  /* 1310nm, long reach */
+#define SFF_8472_10G_LRM_BIT		6  /* 1310nm, long reach multimode */
+#define SFF_8472_10G_ER_BIT		7  /* 1550nm, extended reach */
+#define SFF_8472_1G_SX_BIT		0
+#define SFF_8472_1G_LX_BIT		1
+#define SFF_8472_1G_CX_BIT		2
+#define SFF_8472_1G_T_BIT		3
+#define SFF_8472_SOFT_TX_DISABLE	6
+#define SFF_8472_SOFT_RATE_SELECT	4
+#define SFF_8472_EMPTY_ASCII		20
+#define SFF_DDM_IMPLEMENTED		0x40
+#define SFF_COPPER_UNSPECIFIED		0
+#define SFF_COPPER_8431_APPENDIX_E	1
+#define SFF_COPPER_8431_LIMITING	4
+#define SFF_8636_TURNPAGE_ADDR		(127)
+#define SFF_8638_PAGESIZE		(128U)
+#define SFF_8638_PAGE0_SIZE		(256U)
+
+#define SFF_8636_TEMP			(0x60)
+#define SFF_8636_TEMP_MAX		(0x4)
+#define SFF_8636_TEMP_CIRT		(0x0)
+
+#define SFF_8636_QSFP28_TEMP		(0x16)
+#define SFF_8636_QSFP28_TEMP_MAX	(0x204)
+#define SFF_8636_QSFP28_TEMP_CIRT	(0x200)
+
+#define SFF8636_TRANSMIT_FIBER_850nm_VCSEL	(0x0)
+#define SFF8636_TRANSMIT_FIBER_1310nm_VCSEL	(0x1)
+#define SFF8636_TRANSMIT_FIBER_1550nm_VCSEL	(0x2)
+#define SFF8636_TRANSMIT_FIBER_1310nm_FP	(0x3)
+#define SFF8636_TRANSMIT_FIBER_1310nm_DFB	(0x4)
+#define SFF8636_TRANSMIT_FIBER_1550nm_DFB	(0x5)
+#define SFF8636_TRANSMIT_FIBER_1310nm_EML	(0x6)
+#define SFF8636_TRANSMIT_FIBER_1550nm_EML	(0x7)
+#define SFF8636_TRANSMIT_FIBER_OTHER		(0x8)
+#define SFF8636_TRANSMIT_FIBER_1490nm_DFB	(0x9)
+#define SFF8636_TRANSMIT_COPPER_UNEQUA		(0xa)
+#define SFF8636_TRANSMIT_COPPER_PASSIVE_EQUALIZED	(0xb)
+#define SFF8636_TRANSMIT_COPPER_NEAR_FAR_END		(0xc)
+#define SFF8636_TRANSMIT_COPPER_FAR_END			(0xd)
+#define SFF8636_TRANSMIT_COPPER_NEAR_END		(0xe)
+#define SFF8636_TRANSMIT_COPPER_LINEAR_ACTIVE		(0xf)
+
+#define NBL_ADMINQ_ETH_WOL_REG_OFFSET	(0x1604000 + 0x500)
+
+/* VSI fixed number of queues*/
+#define NBL_VSI_PF_LEGAL_QUEUE_NUM(num) ((num) + NBL_DEFAULT_REP_HW_QUEUE_NUM)
+#define NBL_VSI_PF_MAX_QUEUE_NUM(num) \
+	(((num) * 2) + NBL_DEFAULT_REP_HW_QUEUE_NUM)
+#define NBL_VSI_VF_REAL_QUEUE_NUM(num)		(num)
+
+#define	NBL_ADMINQ_RESID_FSI_SECTION_HBC	(0x3000)
+#define	NBL_ADMINQ_RESID_FSI_TLV_SERIAL_NUMBER	(0x3801)
+#define NBL_ADMINQ_PFA_TLV_VF_NUM		(0x5804)
+#define NBL_ADMINQ_PFA_TLV_NET_RING_NUM		(0x5805)
+
+struct nbl_port_key {
+	u32 id; /* port id */
+	u32 subop; /* 1: read, 2: write */
+	u64 data[]; /* [47:0]: data, [55:48]: rsvd, [63:56]: key */
+};
+
+#define NBL_PORT_KEY_ILLEGAL 0x0
+#define NBL_PORT_KEY_CAPABILITIES 0x1
+#define NBL_PORT_KEY_ENABLE 0x2 /* BIT(0): NBL_PORT_FLAG_ENABLE_NOTIFY */
+#define NBL_PORT_KEY_DISABLE 0x3
+#define NBL_PORT_KEY_ADVERT 0x4
+#define NBL_PORT_KEY_LOOPBACK \
+	0x5 /* 0: disable eth loopback, 1: enable eth loopback */
+#define NBL_PORT_KEY_MODULE_SWITCH 0x6 /* 0: sfp off, 1: sfp on */
+#define NBL_PORT_KEY_MAC_ADDRESS 0x7
+#define NBL_PORT_KEY_LED_BLINK 0x8
+#define NBL_PORT_KEY_RESTORE_DEFAULTE_CFG 11
+#define NBL_PORT_KEY_SET_PFC_CFG 12
+#define NBL_PORT_KEY_GET_LINK_STATUS_OPCODE 17
+
+enum {
+	NBL_PORT_SUBOP_READ = 1,
+	NBL_PORT_SUBOP_WRITE = 2,
+};
+
+#define NBL_PORT_FLAG_ENABLE_NOTIFY	BIT(0)
+#define NBL_PORT_ENABLE_LOOPBACK	1
+#define NBL_PORT_DISABLE_LOOPBCK	0
+#define NBL_PORT_SFP_ON			1
+#define NBL_PORT_SFP_OFF		0
+#define NBL_PORT_KEY_KEY_SHIFT		56
+#define NBL_PORT_KEY_DATA_MASK		0xFFFFFFFFFFFF
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index bf7c95ea33da..57cae6baaafd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -5,6 +5,19 @@
  */
 
 #include "nbl_hw_leonis.h"
+static u32 nbl_hw_get_quirks(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = priv;
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, (u8 *)&quirks,
+			     sizeof(u32));
+
+	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
+		return 0;
+
+	return quirks;
+}
 
 static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr,
 						 u8 txrx)
@@ -110,6 +123,71 @@ static u32 nbl_hw_get_host_pf_mask(void *priv)
 	return data;
 }
 
+static u32 nbl_hw_get_host_pf_fid(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 data;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_PCIE_HOST_K_PF_FID(func_id), (u8 *)&data,
+		       sizeof(data));
+	return data;
+}
+
+static u32 nbl_hw_get_real_bus(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 data;
+
+	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);
+	return data >> 5;
+}
+
+static u64 nbl_hw_get_pf_bar_addr(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u64 addr;
+	u32 val;
+	u32 selector;
+
+	selector = NBL_LB_PF_CONFIGSPACE_SELECT_OFFSET +
+		   func_id * NBL_LB_PF_CONFIGSPACE_SELECT_STRIDE;
+	nbl_hw_wr32(hw_mgt, NBL_LB_PCIEX16_TOP_AHB, selector);
+
+	val = nbl_hw_rd32(hw_mgt,
+			  NBL_LB_PF_CONFIGSPACE_BASE_ADDR + PCI_BASE_ADDRESS_0);
+	addr = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+
+	val = nbl_hw_rd32(hw_mgt, NBL_LB_PF_CONFIGSPACE_BASE_ADDR +
+					  PCI_BASE_ADDRESS_0 + 4);
+	addr |= ((u64)val << 32);
+
+	return addr;
+}
+
+static u64 nbl_hw_get_vf_bar_addr(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u64 addr;
+	u32 val;
+	u32 selector;
+
+	selector = NBL_LB_PF_CONFIGSPACE_SELECT_OFFSET +
+		   func_id * NBL_LB_PF_CONFIGSPACE_SELECT_STRIDE;
+	nbl_hw_wr32(hw_mgt, NBL_LB_PCIEX16_TOP_AHB, selector);
+
+	val = nbl_hw_rd32(hw_mgt, NBL_LB_PF_CONFIGSPACE_BASE_ADDR +
+					  NBL_SRIOV_CAPS_OFFSET +
+					  PCI_SRIOV_BAR);
+	addr = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+
+	val = nbl_hw_rd32(hw_mgt, NBL_LB_PF_CONFIGSPACE_BASE_ADDR +
+					  NBL_SRIOV_CAPS_OFFSET +
+					  PCI_SRIOV_BAR + 4);
+	addr |= ((u64)val << 32);
+
+	return addr;
+}
+
 static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 				     u16 devid, u16 function)
 {
@@ -230,6 +308,234 @@ static bool nbl_hw_check_adminq_dma_err(void *priv, bool tx)
 	return false;
 }
 
+static u8 __iomem *nbl_hw_get_hw_addr(void *priv, size_t *size)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	if (size)
+		*size = (size_t)hw_mgt->hw_size;
+	return hw_mgt->hw_addr;
+}
+
+static void nbl_hw_set_fw_ping(void *priv, u32 ping)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_FW_HEARTBEAT_PING, (u8 *)&ping,
+			      sizeof(ping));
+}
+
+static u32 nbl_hw_get_fw_pong(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 pong;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_FW_HEARTBEAT_PONG, (u8 *)&pong,
+		       sizeof(pong));
+
+	return pong;
+}
+
+static void nbl_hw_set_fw_pong(void *priv, u32 pong)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FW_HEARTBEAT_PONG, (u8 *)&pong,
+		       sizeof(pong));
+}
+
+static int nbl_hw_process_abnormal_queue(struct nbl_hw_mgt *hw_mgt,
+					 u16 queue_id, int type,
+					 struct nbl_abnormal_details *detail)
+{
+	struct nbl_ipro_queue_tbl ipro_queue_tbl = { 0 };
+	struct nbl_host_vnet_qinfo host_vnet_qinfo = { 0 };
+	u32 qinfo_id = type == NBL_ABNORMAL_EVENT_DVN ?
+			       NBL_PAIR_ID_GET_TX(queue_id) :
+			       NBL_PAIR_ID_GET_RX(queue_id);
+
+	if (type >= NBL_ABNORMAL_EVENT_MAX)
+		return -EINVAL;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_IPRO_QUEUE_TBL(queue_id),
+		       (u8 *)&ipro_queue_tbl, sizeof(ipro_queue_tbl));
+
+	detail->abnormal = true;
+	detail->qid = queue_id;
+	detail->vsi_id = ipro_queue_tbl.vsi_id;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(qinfo_id),
+		       (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+	host_vnet_qinfo.valid = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(qinfo_id),
+		       (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+
+	return 0;
+}
+
+static int
+nbl_hw_process_abnormal_event(void *priv,
+			      struct nbl_abnormal_event_info *abnomal_info)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct device *dev = NBL_HW_MGT_TO_DEV(hw_mgt);
+	struct dvn_desc_dif_err_info desc_err_info = { 0 };
+	struct dvn_pkt_dif_err_info pkt_dif_err_info = { 0 };
+	struct dvn_err_queue_id_get err_queue_id_get = { 0 };
+	struct uvn_queue_err_info queue_err_info = { 0 };
+	struct nbl_abnormal_details *detail;
+	u32 int_status = 0, rdma_other_abn = 0, tlp_out_drop_cnt = 0;
+	u32 desc_dif_err_cnt = 0, pkt_dif_err_cnt = 0;
+	u32 queue_err_cnt;
+	int ret = 0;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_INT_STATUS, (u8 *)&int_status,
+		       sizeof(u32));
+	if (int_status == U32_MAX)
+		dev_info(dev, "dvn int_status:0x%x", int_status);
+
+	if (int_status && int_status != U32_MAX) {
+		if (int_status & BIT(NBL_DVN_INT_DESC_DIF_ERR)) {
+			nbl_hw_rd_regs(hw_mgt, NBL_DVN_DESC_DIF_ERR_CNT,
+				       (u8 *)&desc_dif_err_cnt, sizeof(u32));
+			nbl_hw_rd_regs(hw_mgt, NBL_DVN_DESC_DIF_ERR_INFO,
+				       (u8 *)&desc_err_info,
+				       sizeof(struct dvn_desc_dif_err_info));
+			dev_info(dev, "dvn int_status:0x%x, desc_dif_mf_cnt:%d, queue_id:%d\n",
+				 int_status, desc_dif_err_cnt,
+				 desc_err_info.queue_id);
+			detail = &abnomal_info->details[NBL_ABNORMAL_EVENT_DVN];
+			nbl_hw_process_abnormal_queue(hw_mgt,
+						      desc_err_info.queue_id,
+						      NBL_ABNORMAL_EVENT_DVN,
+						      detail);
+
+			ret |= BIT(NBL_ABNORMAL_EVENT_DVN);
+		}
+
+		if (int_status & BIT(NBL_DVN_INT_PKT_DIF_ERR)) {
+			nbl_hw_rd_regs(hw_mgt, NBL_DVN_PKT_DIF_ERR_CNT,
+				       (u8 *)&pkt_dif_err_cnt, sizeof(u32));
+			nbl_hw_rd_regs(hw_mgt, NBL_DVN_PKT_DIF_ERR_INFO,
+				       (u8 *)&pkt_dif_err_info,
+				       sizeof(struct dvn_pkt_dif_err_info));
+			dev_info(dev, "dvn int_status:0x%x, pkt_dif_mf_cnt:%d, queue_id:%d\n",
+				 int_status, pkt_dif_err_cnt,
+				 pkt_dif_err_info.queue_id);
+		}
+
+		/* clear dvn abnormal irq */
+		nbl_hw_wr_regs(hw_mgt, NBL_DVN_INT_STATUS, (u8 *)&int_status,
+			       sizeof(int_status));
+
+		/* enable new queue error irq */
+		err_queue_id_get.desc_flag = 1;
+		err_queue_id_get.pkt_flag = 1;
+		nbl_hw_wr_regs(hw_mgt, NBL_DVN_ERR_QUEUE_ID_GET,
+			       (u8 *)&err_queue_id_get,
+			       sizeof(err_queue_id_get));
+	}
+
+	int_status = 0;
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_INT_STATUS, (u8 *)&int_status,
+		       sizeof(u32));
+	if (int_status == U32_MAX)
+		dev_info(dev, "uvn int_status:0x%x", int_status);
+	if (int_status && int_status != U32_MAX) {
+		nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_CNT,
+			       (u8 *)&queue_err_cnt, sizeof(u32));
+		nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_INFO,
+			       (u8 *)&queue_err_info,
+			       sizeof(struct uvn_queue_err_info));
+		dev_info(dev,
+			 "uvn int_status:%x queue_err_cnt: 0x%x qid 0x%x\n",
+			 int_status, queue_err_cnt, queue_err_info.queue_id);
+
+		if (int_status & BIT(NBL_UVN_INT_QUEUE_ERR)) {
+			detail = &abnomal_info->details[NBL_ABNORMAL_EVENT_UVN];
+			nbl_hw_process_abnormal_queue(hw_mgt,
+						      queue_err_info.queue_id,
+						      NBL_ABNORMAL_EVENT_UVN,
+						      detail);
+
+			ret |= BIT(NBL_ABNORMAL_EVENT_UVN);
+		}
+
+		/* clear uvn abnormal irq */
+		nbl_hw_wr_regs(hw_mgt, NBL_UVN_INT_STATUS, (u8 *)&int_status,
+			       sizeof(int_status));
+	}
+
+	int_status = 0;
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_INT_STATUS, (u8 *)&int_status,
+		       sizeof(u32));
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_RDMA_OTHER_ABN, (u8 *)&rdma_other_abn,
+		       sizeof(u32));
+	if (int_status == U32_MAX)
+		dev_info(dev, "dsch int_status:0x%x", int_status);
+	if (int_status && int_status != U32_MAX &&
+	    (int_status != NBL_DSCH_RDMA_OTHER_ABN_BIT ||
+	     rdma_other_abn != NBL_DSCH_RDMA_DPQM_DB_LOST)) {
+		dev_info(dev, "dsch int_status:%x\n", int_status);
+
+		/* clear dsch abnormal irq */
+		nbl_hw_wr_regs(hw_mgt, NBL_DSCH_INT_STATUS, (u8 *)&int_status,
+			       sizeof(int_status));
+	}
+
+	int_status = 0;
+	nbl_hw_rd_regs(hw_mgt, NBL_PCOMPLETER_INT_STATUS, (u8 *)&int_status,
+		       sizeof(u32));
+	if (int_status == U32_MAX)
+		dev_info(dev, "pcomleter int_status:0x%x", int_status);
+	if (int_status && int_status != U32_MAX) {
+		nbl_hw_rd_regs(hw_mgt, NBL_PCOMPLETER_TLP_OUT_DROP_CNT,
+			       (u8 *)&tlp_out_drop_cnt, sizeof(u32));
+		dev_info(dev,
+			 "pcomleter int_status:0x%x tlp_out_drop_cnt 0x%x\n",
+			 int_status, tlp_out_drop_cnt);
+
+		/* clear pcomleter abnormal irq */
+		nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_INT_STATUS,
+			       (u8 *)&int_status, sizeof(int_status));
+	}
+
+	return ret;
+}
+
+static void nbl_hw_get_board_info(void *priv,
+				  struct nbl_board_port_info *board_info)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	board_info->eth_num = dw3.info.port_num;
+	board_info->eth_speed = dw3.info.port_speed;
+	board_info->p4_version = dw3.info.p4_version;
+}
+
+static u32 nbl_hw_get_fw_eth_num(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	return dw3.info.port_num;
+}
+
+static u32 nbl_hw_get_fw_eth_map(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw6 dw6 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, (u8 *)&dw6,
+			     sizeof(dw6));
+	return dw6.info.eth_bitmap;
+}
+
 static void nbl_hw_set_hw_status(void *priv, enum nbl_hw_status hw_status)
 {
 	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
@@ -253,6 +559,10 @@ static struct nbl_hw_ops hw_ops = {
 	.get_mailbox_rx_tail_ptr = nbl_hw_get_mailbox_rx_tail_ptr,
 	.check_mailbox_dma_err = nbl_hw_check_mailbox_dma_err,
 	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.get_host_pf_fid = nbl_hw_get_host_pf_fid,
+	.get_real_bus = nbl_hw_get_real_bus,
+	.get_pf_bar_addr = nbl_hw_get_pf_bar_addr,
+	.get_vf_bar_addr = nbl_hw_get_vf_bar_addr,
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
 
 	.config_adminq_rxq = nbl_hw_config_adminq_rxq,
@@ -263,6 +573,15 @@ static struct nbl_hw_ops hw_ops = {
 	.update_adminq_queue_tail_ptr = nbl_hw_update_adminq_queue_tail_ptr,
 	.check_adminq_dma_err = nbl_hw_check_adminq_dma_err,
 
+	.get_hw_addr = nbl_hw_get_hw_addr,
+	.set_fw_ping = nbl_hw_set_fw_ping,
+	.get_fw_pong = nbl_hw_get_fw_pong,
+	.set_fw_pong = nbl_hw_set_fw_pong,
+	.process_abnormal_event = nbl_hw_process_abnormal_event,
+	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
+	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
+	.get_board_info = nbl_hw_get_board_info,
+	.get_quirks = nbl_hw_get_quirks,
 	.set_hw_status = nbl_hw_set_hw_status,
 	.get_hw_status = nbl_hw_get_hw_status,
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
new file mode 100644
index 000000000000..ea5c83b1ab76
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -0,0 +1,998 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+
+#include "nbl_resource_leonis.h"
+static int nbl_res_get_queue_num(void *priv, u16 func_id, u16 *tx_queue_num,
+				 u16 *rx_queue_num);
+
+static void nbl_res_setup_common_ops(struct nbl_resource_mgt *res_mgt)
+{
+	res_mgt->common_ops.get_queue_num = nbl_res_get_queue_num;
+}
+
+static int nbl_res_pf_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 pf_id)
+{
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	if (pf_id >= NBL_MAX_PF)
+		return 0;
+
+	return eth_info->eth_id[pf_id];
+}
+
+static u32 nbl_res_get_pfvf_queue_num(struct nbl_resource_mgt *res_mgt,
+				      int pfid, int vfid)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info = &res_info->net_ring_num_info;
+	u16 func_id = nbl_res_pfvfid_to_func_id(res_mgt, pfid, vfid);
+	u32 queue_num = 0;
+
+	if (vfid >= 0) {
+		if (num_info->net_max_qp_num[func_id] != 0)
+			queue_num = num_info->net_max_qp_num[func_id];
+		else
+			queue_num = num_info->vf_def_max_net_qp_num;
+	} else {
+		if (num_info->net_max_qp_num[func_id] != 0)
+			queue_num = num_info->net_max_qp_num[func_id];
+		else
+			queue_num = num_info->pf_def_max_net_qp_num;
+	}
+
+	if (queue_num > NBL_MAX_TXRX_QUEUE_PER_FUNC) {
+		nbl_warn(NBL_RES_MGT_TO_COMMON(res_mgt),
+			 "Invalid queue num %u for func %d, use default",
+			 queue_num, func_id);
+		queue_num = vfid >= 0 ? NBL_DEFAULT_VF_HW_QUEUE_NUM :
+					NBL_DEFAULT_PF_HW_QUEUE_NUM;
+	}
+
+	return queue_num;
+}
+
+static void nbl_res_get_rep_queue_info(void *priv, u16 *queue_num,
+				       u16 *queue_size)
+{
+	*queue_size = NBL_DEFAULT_DESC_NUM;
+	*queue_num = NBL_DEFAULT_REP_HW_QUEUE_NUM;
+}
+
+static int nbl_res_get_queue_num(void *priv, u16 func_id, u16 *tx_queue_num,
+				 u16 *rx_queue_num)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)(priv);
+	int pfid, vfid;
+
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	*tx_queue_num = nbl_res_get_pfvf_queue_num(res_mgt, pfid, vfid);
+	*rx_queue_num = nbl_res_get_pfvf_queue_num(res_mgt, pfid, vfid);
+
+	return 0;
+}
+
+static int
+nbl_res_save_vf_bar_info(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			 struct nbl_register_net_param *register_param)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u64 pf_bar_start;
+	u64 vf_bar_start;
+	u16 pf_bdf;
+	u64 vf_bar_size;
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+
+	if (func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt)) {
+		pf_bar_start = hw_ops->get_pf_bar_addr(p, func_id);
+		sriov_info->pf_bar_start = pf_bar_start;
+		dev_dbg(dev, "sriov_info, pf_bar_start:%llx\n",
+			sriov_info->pf_bar_start);
+	}
+
+	pf_bdf = (u16)sriov_info->bdf;
+	vf_bar_size = register_param->vf_bar_size;
+	total_vfs = register_param->total_vfs;
+	offset = register_param->offset;
+	stride = register_param->stride;
+
+	if (total_vfs) {
+		sriov_info->offset = offset;
+		sriov_info->stride = stride;
+		vf_bar_start = hw_ops->get_vf_bar_addr(p, func_id);
+		sriov_info->vf_bar_start = vf_bar_start;
+		sriov_info->vf_bar_len = vf_bar_size / total_vfs;
+
+		dev_info(dev,
+			 "sriov_info, bdf:%x:%x.%x, num_vfs:%d, start_vf_func_id:%d,",
+			 PCI_BUS_NUM(pf_bdf), PCI_SLOT(pf_bdf & 0xff),
+			 PCI_FUNC(pf_bdf & 0xff), sriov_info->num_vfs,
+			 sriov_info->start_vf_func_id);
+		dev_info(dev, "offset:%d, stride:%d, vf_bar_start: %llx",
+			 offset, stride, sriov_info->vf_bar_start);
+	}
+
+	return 0;
+}
+
+static int
+nbl_res_prepare_vf_chan(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			struct nbl_register_net_param *register_param)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+	u8 pf_bus;
+	u8 pf_devfn;
+	u16 vf_id;
+	u8 bus;
+	u8 devfn;
+	u8 devid;
+	u8 function;
+	u16 vf_func_id;
+
+	total_vfs = register_param->total_vfs;
+	offset = register_param->offset;
+	stride = register_param->stride;
+
+	if (total_vfs) {
+		/* Configure mailbox qinfo_map_table for the pf's all vf,
+		 * so vf's mailbox is ready, vf can use mailbox.
+		 */
+		pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+		pf_devfn = sriov_info->bdf & 0xff;
+		for (vf_id = 0; vf_id < sriov_info->num_vfs; vf_id++) {
+			vf_func_id = sriov_info->start_vf_func_id + vf_id;
+
+			bus = pf_bus +
+			      ((pf_devfn + offset + stride * vf_id) >> 8);
+			devfn = (pf_devfn + offset + stride * vf_id) & 0xff;
+			devid = PCI_SLOT(devfn);
+			function = PCI_FUNC(devfn);
+
+			hw_ops->cfg_mailbox_qinfo(p, vf_func_id, bus, devid,
+						  function);
+		}
+	}
+
+	return 0;
+}
+
+static int nbl_res_update_active_vf_num(struct nbl_resource_mgt *res_mgt,
+					u16 func_id, bool add_flag)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_resource_info *resource_info = res_mgt->resource_info;
+	struct nbl_sriov_info *sriov_info = res_mgt->resource_info->sriov_info;
+	int pfid = 0;
+	int vfid = 0;
+	int ret;
+
+	ret = nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+	if (ret) {
+		nbl_err(common, "convert func id to pfvfid failed\n");
+		return ret;
+	}
+
+	if (vfid == U32_MAX)
+		return 0;
+
+	if (add_flag) {
+		if (!test_bit(func_id, resource_info->func_bitmap)) {
+			sriov_info[pfid].active_vf_num++;
+			set_bit(func_id, resource_info->func_bitmap);
+		}
+	} else if (sriov_info[pfid].active_vf_num) {
+		if (test_bit(func_id, resource_info->func_bitmap)) {
+			sriov_info[pfid].active_vf_num--;
+			clear_bit(func_id, resource_info->func_bitmap);
+		}
+	}
+
+	return 0;
+}
+
+static u32 nbl_res_get_quirks(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->get_quirks(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+}
+
+static int nbl_res_register_net(void *priv, u16 func_id,
+				struct nbl_register_net_param *register_param,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	netdev_features_t csumo_features = 0;
+	netdev_features_t tso_features = 0;
+	netdev_features_t pf_features = 0;
+	netdev_features_t vlano_features = 0;
+	u16 tx_queue_num, rx_queue_num;
+	u8 mac[ETH_ALEN] = {0};
+	u32 quirks;
+	int ret = 0;
+
+	if (func_id < NBL_MAX_PF) {
+		nbl_res_get_eth_mac(res_mgt, mac,
+				    nbl_res_pf_to_eth_id(res_mgt, func_id));
+		pf_features = NBL_FEATURE(NETIF_F_NTUPLE);
+		register_result->trusted = 1;
+	} else {
+		ether_addr_copy(mac, vsi_info->mac_info[func_id].mac);
+		register_result->trusted = vsi_info->mac_info[func_id].trusted;
+	}
+	ether_addr_copy(register_result->mac, mac);
+
+	quirks = nbl_res_get_quirks(res_mgt);
+	if (!(quirks & BIT(NBL_QUIRKS_NO_TOE))) {
+		csumo_features = NBL_FEATURE(NETIF_F_RXCSUM) |
+				 NBL_FEATURE(NETIF_F_IP_CSUM) |
+				 NBL_FEATURE(NETIF_F_IPV6_CSUM);
+		tso_features = NBL_FEATURE(NETIF_F_TSO) |
+			       NBL_FEATURE(NETIF_F_TSO6) |
+			       NBL_FEATURE(NETIF_F_GSO_UDP_L4);
+	}
+
+	if (func_id < NBL_MAX_PF) /* vf unsupport */
+		vlano_features = NBL_FEATURE(NETIF_F_HW_VLAN_CTAG_TX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_CTAG_RX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_STAG_TX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_STAG_RX);
+
+	register_result->hw_features |=
+		pf_features | csumo_features | tso_features | vlano_features |
+		NBL_FEATURE(NETIF_F_SG) | NBL_FEATURE(NETIF_F_RXHASH);
+
+	register_result->features |= register_result->hw_features |
+				     NBL_FEATURE(NETIF_F_HW_VLAN_CTAG_FILTER) |
+				     NBL_FEATURE(NETIF_F_HW_VLAN_STAG_FILTER);
+
+	register_result->vlan_features = register_result->features;
+
+	register_result->max_mtu = NBL_MAX_JUMBO_FRAME_SIZE - NBL_PKT_HDR_PAD;
+
+	register_result->vlan_proto = vsi_info->mac_info[func_id].vlan_proto;
+	register_result->vlan_tci = vsi_info->mac_info[func_id].vlan_tci;
+	register_result->rate = vsi_info->mac_info[func_id].rate;
+
+	nbl_res_get_queue_num(res_mgt, func_id, &tx_queue_num, &rx_queue_num);
+	register_result->tx_queue_num = tx_queue_num;
+	register_result->rx_queue_num = rx_queue_num;
+	register_result->queue_size = NBL_DEFAULT_DESC_NUM;
+
+	ret = nbl_res_update_active_vf_num(res_mgt, func_id, 1);
+	if (ret) {
+		nbl_err(common, "change active vf num failed with ret: %d\n",
+			ret);
+		goto update_active_vf_fail;
+	}
+
+	if (func_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt))
+		return 0;
+
+	ret = nbl_res_save_vf_bar_info(res_mgt, func_id, register_param);
+	if (ret)
+		goto save_vf_bar_info_fail;
+
+	ret = nbl_res_prepare_vf_chan(res_mgt, func_id, register_param);
+	if (ret)
+		goto prepare_vf_chan_fail;
+
+	nbl_res_open_sfp(res_mgt, nbl_res_pf_to_eth_id(res_mgt, func_id));
+
+	return ret;
+
+prepare_vf_chan_fail:
+save_vf_bar_info_fail:
+update_active_vf_fail:
+	return ret;
+}
+
+static int nbl_res_unregister_net(void *priv, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_update_active_vf_num(res_mgt, func_id, 0);
+}
+
+static u16 nbl_res_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+static void nbl_res_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			       u8 *logic_eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	*eth_mode = eth_info->eth_num;
+	if (pf_id < eth_info->eth_num) {
+		*eth_id = eth_info->eth_id[pf_id];
+		*logic_eth_id = pf_id;
+	/* if pf_id > eth_num, use eth_id 0 */
+	} else {
+		*eth_id = eth_info->eth_id[0];
+		*logic_eth_id = 0;
+	}
+}
+
+static u8 __iomem *nbl_res_get_hw_addr(void *priv, size_t *size)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->get_hw_addr(NBL_RES_MGT_TO_HW_PRIV(res_mgt), size);
+}
+
+static u16 nbl_res_get_function_id(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+}
+
+static void nbl_res_get_real_bdf(void *priv, u16 vsi_id, u8 *bus, u8 *dev,
+				 u8 *function)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	nbl_res_func_id_to_bdf(res_mgt, func_id, bus, dev, function);
+}
+
+static int
+nbl_res_process_abnormal_event(void *priv,
+			       struct nbl_abnormal_event_info *abnomal_info)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->process_abnormal_event(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					      abnomal_info);
+}
+
+static void nbl_res_flr_clear_net(void *priv, u16 vf_id)
+{
+	u16 func_id = vf_id + NBL_MAX_PF;
+
+	if (nbl_res_vf_is_active(priv, func_id))
+		nbl_res_unregister_net(priv, func_id);
+}
+
+static u16 nbl_res_covert_vfid_to_vsi_id(void *priv, u16 vf_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = vf_id + NBL_MAX_PF;
+
+	return nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					 NBL_VSI_SERV_VF_DATA_TYPE);
+}
+
+static bool nbl_res_check_vf_is_active(void *priv, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_vf_is_active(res_mgt, func_id);
+}
+
+static int
+nbl_res_get_ustore_total_pkt_drop_stats(void *priv, u8 eth_id,
+					struct nbl_ustore_stats *stat)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_ustore_stats *ustore_stats =
+		NBL_RES_MGT_TO_USTORE_STATS(res_mgt);
+
+	stat->rx_drop_packets =
+		ustore_stats[eth_id].rx_drop_packets;
+	stat->rx_trun_packets =
+		ustore_stats[eth_id].rx_trun_packets;
+	return 0;
+}
+
+static int nbl_res_get_board_id(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+
+	return NBL_COMMON_TO_BOARD_ID(common);
+}
+
+static void nbl_res_register_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info =
+		NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	u32 pf_id;
+
+	pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+	WARN_ON(pf_id >= NBL_MAX_PF);
+	strscpy(resource_info->pf_name_list[pf_id], name, IFNAMSIZ);
+	nbl_info(NBL_RES_MGT_TO_COMMON(res_mgt),
+		 "vsi:%u-pf:%u register a pf_name->%s", vsi_id, pf_id, name);
+}
+
+static void nbl_res_get_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info =
+		NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	int pf_id, vf_id;
+	u16 func_id;
+	int name_len;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pf_id, &vf_id);
+	WARN_ON(pf_id >= NBL_MAX_PF);
+	name_len = snprintf(name, IFNAMSIZ, "%sv%d",
+			    resource_info->pf_name_list[pf_id], vf_id);
+	if (name_len >= IFNAMSIZ)
+		nbl_err(NBL_RES_MGT_TO_COMMON(res_mgt),
+			"vsi:%u-pf%uvf%u get name over length", vsi_id, pf_id,
+			vf_id);
+
+	nbl_debug(NBL_RES_MGT_TO_COMMON(res_mgt),
+		  "vsi:%u-pf%uvf%u get a pf_name->%s", vsi_id, pf_id, vf_id,
+		  name);
+}
+
+static struct nbl_resource_ops res_ops = {
+	.register_net = nbl_res_register_net,
+	.unregister_net = nbl_res_unregister_net,
+	.get_vsi_id = nbl_res_get_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
+
+	.get_rep_queue_info = nbl_res_get_rep_queue_info,
+
+	.get_hw_addr = nbl_res_get_hw_addr,
+	.get_function_id = nbl_res_get_function_id,
+	.get_real_bdf = nbl_res_get_real_bdf,
+	.get_product_fix_cap = nbl_res_get_fix_capability,
+
+	.flr_clear_net = nbl_res_flr_clear_net,
+	.covert_vfid_to_vsi_id = nbl_res_covert_vfid_to_vsi_id,
+	.check_vf_is_active = nbl_res_check_vf_is_active,
+
+	.get_ustore_total_pkt_drop_stats =
+		nbl_res_get_ustore_total_pkt_drop_stats,
+
+	.process_abnormal_event = nbl_res_process_abnormal_event,
+
+	.get_board_id = nbl_res_get_board_id,
+
+	.set_hw_status = nbl_res_set_hw_status,
+	.register_dev_name = nbl_res_register_dev_name,
+	.get_dev_name = nbl_res_get_dev_name,
+};
+
+static struct nbl_res_product_ops product_ops = {
+};
+
+static int
+nbl_res_setup_res_mgt(struct nbl_common_info *common,
+		      struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	struct device *dev;
+	struct nbl_resource_info *resource_info;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*res_mgt_leonis = devm_kzalloc(dev,
+				       sizeof(struct nbl_resource_mgt_leonis),
+				       GFP_KERNEL);
+	if (!*res_mgt_leonis)
+		return -ENOMEM;
+	NBL_RES_MGT_TO_COMMON(&(*res_mgt_leonis)->res_mgt) = common;
+
+	resource_info =
+		devm_kzalloc(dev, sizeof(struct nbl_resource_info), GFP_KERNEL);
+	if (!resource_info)
+		return -ENOMEM;
+	NBL_RES_MGT_TO_RES_INFO(&(*res_mgt_leonis)->res_mgt) = resource_info;
+
+	return 0;
+}
+
+static void
+nbl_res_remove_res_mgt(struct nbl_common_info *common,
+		       struct nbl_resource_mgt_leonis **res_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, NBL_RES_MGT_TO_RES_INFO(&(*res_mgt_leonis)->res_mgt));
+	devm_kfree(dev, *res_mgt_leonis);
+	*res_mgt_leonis = NULL;
+}
+
+static void nbl_res_remove_ops(struct device *dev,
+			       struct nbl_resource_ops_tbl **res_ops_tbl)
+{
+	devm_kfree(dev, *res_ops_tbl);
+	*res_ops_tbl = NULL;
+}
+
+static int nbl_res_setup_ops(struct device *dev,
+			     struct nbl_resource_ops_tbl **res_ops_tbl,
+			     struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	*res_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_resource_ops_tbl),
+				    GFP_KERNEL);
+	if (!*res_ops_tbl)
+		return -ENOMEM;
+
+	(*res_ops_tbl)->ops = &res_ops;
+	(*res_ops_tbl)->priv = res_mgt_leonis;
+
+	return 0;
+}
+
+static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_eth_info *eth_info;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 eth_num = 0;
+	u32 eth_bitmap, eth_id;
+	int i;
+
+	eth_info = devm_kzalloc(dev, sizeof(struct nbl_eth_info), GFP_KERNEL);
+	if (!eth_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->eth_info = eth_info;
+
+	eth_info->eth_num =
+		(u8)hw_ops->get_fw_eth_num(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	eth_bitmap = hw_ops->get_fw_eth_map(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	/* for 2 eth port board, the eth_id is 0, 2 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if ((1 << i) & eth_bitmap) {
+			set_bit(i, eth_info->eth_bitmap);
+			eth_info->eth_id[eth_num] = i;
+			eth_info->logic_eth_id[i] = eth_num;
+			eth_num++;
+		}
+	}
+
+	for (i = 0; i < NBL_RES_MGT_TO_PF_NUM(res_mgt); i++) {
+		/* if pf_id <= eth_num, the pf relate corresponding eth_id*/
+		if (i < eth_num) {
+			eth_id = eth_info->eth_id[i];
+			eth_info->pf_bitmap[eth_id] |= BIT(i);
+		}
+		/* if pf_id > eth_num, the pf relate eth 0*/
+		else
+			eth_info->pf_bitmap[0] |= BIT(i);
+	}
+
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_remove_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_eth_info **eth_info = &NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	if (*eth_info) {
+		devm_kfree(dev, *eth_info);
+		*eth_info = NULL;
+	}
+}
+
+static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	u32 vf_fid, vf_startid, vf_endid = NBL_MAX_VF;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 func_id;
+	u16 function;
+
+	sriov_info = devm_kcalloc(dev, NBL_RES_MGT_TO_PF_NUM(res_mgt),
+				  sizeof(struct nbl_sriov_info), GFP_KERNEL);
+	if (!sriov_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->sriov_info = sriov_info;
+
+	for (func_id = 0; func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt); func_id++) {
+		sriov_info = &NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+		function = NBL_COMMON_TO_PCI_FUNC_ID(common) + func_id;
+
+		common->hw_bus = (u8)hw_ops->get_real_bus(p);
+		sriov_info->bdf = PCI_DEVID(common->hw_bus,
+					    PCI_DEVFN(common->devid, function));
+		vf_fid = hw_ops->get_host_pf_fid(p, func_id);
+		vf_startid = vf_fid & 0xFFFF;
+		vf_endid = (vf_fid >> 16) & 0xFFFF;
+		sriov_info->start_vf_func_id = vf_startid + NBL_MAX_PF_LEONIS;
+		sriov_info->num_vfs = vf_endid - vf_startid;
+	}
+
+	res_info->max_vf_num = vf_endid;
+
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_sriov_info_remove(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_sriov_info **sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt);
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+
+	if (!(*sriov_info))
+		return;
+
+	devm_kfree(dev, *sriov_info);
+	*sriov_info = NULL;
+}
+
+static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_vsi_info *vsi_info;
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+
+	vsi_info = devm_kcalloc(dev, NBL_RES_MGT_TO_PF_NUM(res_mgt),
+				sizeof(struct nbl_vsi_info), GFP_KERNEL);
+	if (!vsi_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->vsi_info = vsi_info;
+	/*
+	 * case 1 two port(2pf)
+	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
+	 * pf0,pf1(NBL_VSI_SERV_PF_CTLR_TYPE) vsi is 1,513
+	 * pf0,pf1(NBL_VSI_SERV_PF_USER_TYPE) vsi is 2,514
+	 * pf0,pf1(NBL_VSI_SERV_PF_XDP_TYPE) vsi is 3,515
+	 * pf0.vf0-pf0.vf255(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 4-259
+	 * pf1.vf0-pf1.vf255(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 516-771
+	 * pf2-pf7(NBL_VSI_SERV_PF_EXTRA_TYPE) vsi 260-265(if exist)
+	 * case 2 four port(4pf)
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_CTLR_TYPE) vsi is 1,257,513,769
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_USER_TYPE) vsi is 2,258,514,770
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_XDP_TYPE) vsi is 3,259,515,771
+	 * pf0.vf0-pf0.vf127(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 4-131
+	 * pf1.vf0-pf1.vf127(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 260-387
+	 * pf2.vf0-pf2.vf127(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 516-643
+	 * pf3.vf0-pf3.vf127(NBL_VSI_SERV_VF_DATA_TYPE) vsi is 772-899
+	 * pf4-pf7(NBL_VSI_SERV_PF_EXTRA_TYPE) vsi 132-135(if exist)
+	 */
+
+	vsi_info->num = eth_info->eth_num;
+	for (i = 0; i < vsi_info->num; i++) {
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
+			i * NBL_VSI_ID_GAP(vsi_info->num);
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_CTLR_TYPE].base_id =
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE]
+				.base_id +
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_CTLR_TYPE].num = 1;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_USER_TYPE].base_id =
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_CTLR_TYPE]
+				.base_id +
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_CTLR_TYPE].num;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_USER_TYPE].num = 1;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_XDP_TYPE].base_id =
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_USER_TYPE]
+				.base_id +
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_USER_TYPE].num;
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_XDP_TYPE].num = 1;
+		vsi_info->serv_info[i][NBL_VSI_SERV_VF_DATA_TYPE].base_id =
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_XDP_TYPE]
+				.base_id +
+			vsi_info->serv_info[i][NBL_VSI_SERV_PF_XDP_TYPE].num;
+		sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + i;
+		vsi_info->serv_info[i][NBL_VSI_SERV_VF_DATA_TYPE].num =
+			sriov_info->num_vfs;
+	}
+
+	/* pf_id >= eth_num, it belong pf0's switch */
+	vsi_info->serv_info[0][NBL_VSI_SERV_PF_EXTRA_TYPE].base_id =
+		vsi_info->serv_info[0][NBL_VSI_SERV_VF_DATA_TYPE].base_id +
+		vsi_info->serv_info[0][NBL_VSI_SERV_VF_DATA_TYPE].num;
+	vsi_info->serv_info[0][NBL_VSI_SERV_PF_EXTRA_TYPE].num =
+		NBL_RES_MGT_TO_PF_NUM(res_mgt) - vsi_info->num;
+
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_remove_vsi_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_vsi_info **vsi_info = &NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (!(*vsi_info))
+		return;
+
+	devm_kfree(dev, *vsi_info);
+	*vsi_info = NULL;
+}
+
+static int nbl_res_ring_num_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_resource_info *resource_info =
+		NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info =
+		&resource_info->net_ring_num_info;
+
+	num_info->pf_def_max_net_qp_num = NBL_DEFAULT_PF_HW_QUEUE_NUM;
+	num_info->vf_def_max_net_qp_num = NBL_DEFAULT_VF_HW_QUEUE_NUM;
+
+	return 0;
+}
+
+static int nbl_res_ctrl_dev_ustore_stats_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_ustore_stats *ustore_stats;
+
+	ustore_stats = devm_kcalloc(dev, NBL_MAX_ETHERNET,
+				    sizeof(struct nbl_ustore_stats),
+				    GFP_KERNEL);
+	if (!ustore_stats)
+		return -ENOMEM;
+
+	res_mgt->resource_info->ustore_stats = ustore_stats;
+
+	return 0;
+}
+
+static void
+nbl_res_ctrl_dev_ustore_stats_remove(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_ustore_stats **ustore_stats =
+		&NBL_RES_MGT_TO_USTORE_STATS(res_mgt);
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+
+	if (!(*ustore_stats))
+		return;
+
+	devm_kfree(dev, *ustore_stats);
+	*ustore_stats = NULL;
+}
+
+static int nbl_res_check_fw_working(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	unsigned long fw_pong_current;
+	unsigned long seconds_current = 0;
+	unsigned long timeout_us = 500 * USEC_PER_MSEC;
+	unsigned long sleep_us = USEC_PER_MSEC;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us);
+	bool sleep_before_read = false;
+
+	seconds_current = (unsigned long)ktime_get_real_seconds();
+	hw_ops->set_fw_pong(p, seconds_current - 1);
+	hw_ops->set_fw_ping(p, seconds_current);
+
+	might_sleep_if(sleep_us != 0);
+	if (sleep_before_read && sleep_us)
+		usleep_range((sleep_us >> 2) + 1, sleep_us);
+	for (;;) {
+		fw_pong_current =
+			hw_ops->get_fw_pong(p);
+		if (fw_pong_current == seconds_current)
+			break;
+		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
+			fw_pong_current = hw_ops->get_fw_pong(p);
+			break;
+		}
+		if (sleep_us)
+			usleep_range((sleep_us >> 2) + 1, sleep_us);
+	}
+	return (fw_pong_current == seconds_current) ? 0 : -ETIMEDOUT;
+}
+
+static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 pf_mask;
+	u32 pf_num = 0;
+	int i;
+
+	pf_mask = hw_ops->get_host_pf_mask(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	for (i = 0; i < NBL_MAX_PF_LEONIS; i++) {
+		if (!(pf_mask & (1 << i)))
+			pf_num++;
+		else
+			break;
+	}
+
+	res_mgt->resource_info->max_pf = pf_num;
+
+	if (!pf_num)
+		return -1;
+
+	return 0;
+}
+
+static void nbl_res_init_board_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->get_board_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+			       &res_mgt->resource_info->board_info);
+}
+
+static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+
+	nbl_res_ctrl_dev_ustore_stats_remove(res_mgt);
+	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
+	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
+	nbl_res_ctrl_dev_sriov_info_remove(res_mgt);
+}
+
+static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
+			 struct nbl_func_caps caps)
+{
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+
+	u32 quirks;
+	int ret = 0;
+
+	if (caps.has_ctrl) {
+		ret = nbl_res_check_fw_working(res_mgt);
+		if (ret) {
+			nbl_err(common, "fw is not working");
+			return ret;
+		}
+
+		nbl_res_init_board_info(res_mgt);
+
+		ret = nbl_res_init_pf_num(res_mgt);
+		if (ret) {
+			nbl_err(common, "pf number is illegal");
+			return ret;
+		}
+
+		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
+		if (ret) {
+			nbl_err(common, "Failed to init sr_iov info");
+			return ret;
+		}
+
+		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ring_num_info_init(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ctrl_dev_ustore_stats_init(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_FW_HB_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_FW_RESET_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_CLEAN_ADMINDQ_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_RESTOOL_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_ADAPT_DESC_GOTHER);
+		nbl_res_set_fix_capability(res_mgt, NBL_PROCESS_FLR_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_RESET_CTRL_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_NEED_DESTROY_CHIP);
+	}
+
+	nbl_res_set_fix_capability(res_mgt, NBL_TASK_CLEAN_MAILBOX_CAP);
+
+	nbl_res_set_fix_capability(res_mgt, NBL_TASK_RESET_CAP);
+
+	quirks = nbl_res_get_quirks(res_mgt);
+	if (quirks & BIT(NBL_QUIRKS_NO_TOE)) {
+		nbl_res_set_fix_capability(res_mgt, NBL_TASK_KEEP_ALIVE);
+		if (caps.has_ctrl)
+			nbl_res_set_fix_capability(res_mgt,
+						   NBL_RECOVERY_ABN_STATUS);
+	}
+
+	return 0;
+
+start_fail:
+	nbl_res_stop(res_mgt_leonis);
+	return ret;
+}
+
+int nbl_res_init_leonis(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_resource_mgt_leonis **mgt;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret = 0;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	mgt =
+		(struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
+	res_ops_tbl = &NBL_ADAP_TO_RES_OPS_TBL(adap);
+	hw_ops_tbl = NBL_ADAP_TO_HW_OPS_TBL(adap);
+	chan_ops_tbl = NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	ret = nbl_res_setup_res_mgt(common, mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	nbl_res_setup_common_ops(&(*mgt)->res_mgt);
+	(&(*mgt)->res_mgt)->chan_ops_tbl = chan_ops_tbl;
+	(&(*mgt)->res_mgt)->hw_ops_tbl = hw_ops_tbl;
+
+	(&(*mgt)->res_mgt)->product_ops = &product_ops;
+
+	ret = nbl_res_start(*mgt, param->caps);
+	if (ret)
+		goto start_fail;
+
+	ret = nbl_res_setup_ops(dev, res_ops_tbl, *mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_res_stop(*mgt);
+start_fail:
+	nbl_res_remove_res_mgt(common, mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_res_remove_leonis(void *p)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_resource_mgt_leonis **mgt;
+	struct nbl_resource_ops_tbl **res_ops_tbl;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	mgt = (struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
+	res_ops_tbl = &NBL_ADAP_TO_RES_OPS_TBL(adap);
+
+	nbl_res_remove_ops(dev, res_ops_tbl);
+	nbl_res_stop(*mgt);
+	nbl_res_remove_res_mgt(common, mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
new file mode 100644
index 000000000000..a0a25a2b71ee
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_RESOURCE_LEONIS_H_
+#define _NBL_RESOURCE_LEONIS_H_
+
+#include "nbl_resource.h"
+
+#define NBL_MAX_PF_LEONIS			8
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 000000000000..22205e055100
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_resource.h"
+
+static u16 pfvfid_to_vsi_id(void *p, int pfid, int vfid, u16 type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	u16 vsi_id = U16_MAX;
+	int diff;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (vfid == U32_MAX || vfid == U16_MAX) {
+		if (diff < vsi_info->num) {
+			nbl_res_pf_dev_vsi_type_to_hw_vsi_type(type, &dst_type);
+			vsi_id = vsi_info->serv_info[diff][dst_type].base_id;
+		} else {
+			vsi_id = vsi_info->serv_info[0]
+						    [NBL_VSI_SERV_PF_EXTRA_TYPE]
+							    .base_id +
+				 (diff - vsi_info->num);
+		}
+	} else {
+		vsi_id = vsi_info->serv_info[diff][NBL_VSI_SERV_VF_DATA_TYPE]
+				 .base_id +
+			 vfid;
+	}
+
+	if (vsi_id == U16_MAX)
+		pr_err("convert pfid-vfid %d-%d to vsi_id(%d) failed!\n", pfid,
+		       vfid, type);
+
+	return vsi_id;
+}
+
+static u16 func_id_to_vsi_id(void *p, u16 func_id, u16 type)
+{
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+
+	nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid);
+	return nbl_res_pfvfid_to_vsi_id(p, pfid, vfid, type);
+}
+
+static u16 vsi_id_to_func_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	int i, j;
+	u16 func_id = U16_MAX;
+	bool vsi_find = false;
+
+	for (i = 0; i < vsi_info->num; i++) {
+		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++) {
+			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+			    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					      vsi_info->serv_info[i][j].num)) {
+				vsi_find = true;
+				break;
+			}
+		}
+
+		if (vsi_find)
+			break;
+	}
+
+	if (vsi_find) {
+		/* if pf_id < eth_num */
+		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
+		    j <= NBL_VSI_SERV_PF_USER_TYPE)
+			func_id = i + NBL_COMMON_TO_MGT_PF(common);
+		/* if vf */
+		else if (j == NBL_VSI_SERV_VF_DATA_TYPE) {
+			sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + i;
+			func_id =
+				sriov_info->start_vf_func_id +
+				(vsi_id -
+				 vsi_info->serv_info[i]
+						    [NBL_VSI_SERV_VF_DATA_TYPE]
+							    .base_id);
+			/* if extra pf */
+		} else {
+			func_id =
+				vsi_info->num +
+				(vsi_id -
+				 vsi_info->serv_info[i]
+						    [NBL_VSI_SERV_PF_EXTRA_TYPE]
+							    .base_id);
+		}
+	}
+
+	if (func_id == U16_MAX)
+		pr_err("convert vsi_id %d to func_id failed!\n", vsi_id);
+
+	return func_id;
+}
+
+static int vsi_id_to_pf_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	u32 pf_id = U32_MAX;
+	bool vsi_find = false;
+	int i, j;
+
+	for (i = 0; i < vsi_info->num; i++) {
+		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++)
+			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+			    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					      vsi_info->serv_info[i][j].num)) {
+				vsi_find = true;
+				break;
+			}
+
+		if (vsi_find)
+			break;
+	}
+
+	if (vsi_find) {
+		/* if pf_id < eth_num */
+		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
+		    j <= NBL_VSI_SERV_VF_DATA_TYPE)
+			pf_id = i + NBL_COMMON_TO_MGT_PF(common);
+		/* if extra pf */
+		else if (j == NBL_VSI_SERV_PF_EXTRA_TYPE)
+			pf_id = vsi_info->num +
+				(vsi_id -
+				 vsi_info->serv_info[i]
+						    [NBL_VSI_SERV_PF_EXTRA_TYPE]
+							    .base_id);
+	}
+
+	return pf_id;
+}
+
+static int func_id_to_pfvfid(void *p, u16 func_id, int *pfid, int *vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	int pf_id_tmp;
+	int diff;
+
+	if (func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt)) {
+		*pfid = func_id;
+		*vfid = U32_MAX;
+		return 0;
+	}
+
+	for (pf_id_tmp = 0; pf_id_tmp < NBL_RES_MGT_TO_PF_NUM(res_mgt);
+	     pf_id_tmp++) {
+		diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pf_id_tmp);
+		sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+		if (func_id >= sriov_info->start_vf_func_id &&
+		    func_id < sriov_info->start_vf_func_id +
+				      sriov_info->num_vfs) {
+			*pfid = pf_id_tmp;
+			*vfid = func_id - sriov_info->start_vf_func_id;
+			return 0;
+		}
+	}
+
+	return U32_MAX;
+}
+
+static int func_id_to_bdf(void *p, u16 func_id, u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	int diff;
+	u8 pf_bus, pf_devfn, devfn;
+
+	if (nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid))
+		return U32_MAX;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+	pf_devfn = sriov_info->bdf & 0xff;
+
+	if (vfid != U32_MAX) {
+		*bus = pf_bus + ((pf_devfn + sriov_info->offset +
+				  sriov_info->stride * vfid) >>
+				 8);
+		devfn = (pf_devfn + sriov_info->offset +
+			 sriov_info->stride * vfid) &
+			0xff;
+	} else {
+		*bus = pf_bus;
+		devfn = pf_devfn;
+	}
+
+	*dev = PCI_SLOT(devfn);
+	*function = PCI_FUNC(devfn);
+	return 0;
+}
+
+static u16 pfvfid_to_func_id(void *p, int pfid, int vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	int diff;
+
+	if (vfid == U32_MAX)
+		return pfid;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+
+	return sriov_info->start_vf_func_id + vfid;
+}
+
+static u64 get_func_bar_base_addr(void *p, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	u64 base_addr = 0;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	int diff;
+
+	if (nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid))
+		return 0;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+	if (!sriov_info->pf_bar_start) {
+		nbl_err(common,
+			"Try to get bar addr for func %d, but PF_%d sriov not init",
+			func_id, pfid);
+		return 0;
+	}
+
+	if (vfid == U32_MAX)
+		base_addr = sriov_info->pf_bar_start;
+	else
+		base_addr = sriov_info->vf_bar_start +
+			    sriov_info->vf_bar_len * vfid;
+
+	nbl_debug(common, "pfid %d vfid %d base_addr %llx\n", pfid, vfid,
+		  base_addr);
+	return base_addr;
+}
+
+static u8 vsi_id_to_eth_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	if (eth_info)
+		return eth_info
+			->eth_id[nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id)];
+	else
+		return 0;
+}
+
+static u8 eth_id_to_pf_id(void *p, u8 eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+	u8 pf_id_offset = 0;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		if (i == eth_id)
+			break;
+		pf_id_offset++;
+	}
+
+	return pf_id_offset + NBL_COMMON_TO_MGT_PF(common);
+}
+
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid)
+{
+	if (!res_mgt->common_ops.func_id_to_pfvfid)
+		return func_id_to_pfvfid(res_mgt, func_id, pfid, vfid);
+
+	return res_mgt->common_ops.func_id_to_pfvfid(res_mgt, func_id, pfid,
+						     vfid);
+}
+
+u16 nbl_res_pfvfid_to_func_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			      int vfid)
+{
+	if (!res_mgt->common_ops.pfvfid_to_func_id)
+		return pfvfid_to_func_id(res_mgt, pfid, vfid);
+
+	return res_mgt->common_ops.pfvfid_to_func_id(res_mgt, pfid, vfid);
+}
+
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type)
+{
+	if (!res_mgt->common_ops.pfvfid_to_vsi_id)
+		return pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+
+	return res_mgt->common_ops.pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+}
+
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	if (!res_mgt->common_ops.func_id_to_bdf)
+		return func_id_to_bdf(res_mgt, func_id, bus, dev, function);
+
+	return res_mgt->common_ops.func_id_to_bdf(res_mgt, func_id, bus, dev,
+						  function);
+}
+
+u16 nbl_res_vsi_id_to_func_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_func_id)
+		return vsi_id_to_func_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_func_id(res_mgt, vsi_id);
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_pf_id)
+		return vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_pf_id(res_mgt, vsi_id);
+}
+
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type)
+{
+	if (!res_mgt->common_ops.func_id_to_vsi_id)
+		return func_id_to_vsi_id(res_mgt, func_id, type);
+
+	return res_mgt->common_ops.func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id)
+{
+	if (!res_mgt->common_ops.get_func_bar_base_addr)
+		return get_func_bar_base_addr(res_mgt, func_id);
+
+	return res_mgt->common_ops.get_func_bar_base_addr(res_mgt, func_id);
+}
+
+u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_eth_id)
+		return vsi_id_to_eth_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_eth_id(res_mgt, vsi_id);
+}
+
+u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	if (!res_mgt->common_ops.eth_id_to_pf_id)
+		return eth_id_to_pf_id(res_mgt, eth_id);
+
+	return res_mgt->common_ops.eth_id_to_pf_id(res_mgt, eth_id);
+}
+
+bool nbl_res_get_fix_capability(void *priv, enum nbl_fix_cap_type cap_type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return test_bit(cap_type, res_mgt->fix_capability);
+}
+
+void nbl_res_set_fix_capability(struct nbl_resource_mgt *res_mgt,
+				enum nbl_fix_cap_type cap_type)
+{
+	set_bit(cap_type, res_mgt->fix_capability);
+}
+
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type)
+{
+	if (src_type == NBL_VSI_DATA)
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	else if (src_type == NBL_VSI_CTRL)
+		*dst_type = NBL_VSI_SERV_PF_CTLR_TYPE;
+}
+
+bool nbl_res_vf_is_active(void *priv, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info = res_mgt->resource_info;
+
+	return test_bit(func_id, resource_info->func_bitmap);
+}
+
+void nbl_res_set_hw_status(void *priv, enum nbl_hw_status hw_status)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->set_hw_status(NBL_RES_MGT_TO_HW_PRIV(res_mgt), hw_status);
+}
+
+int nbl_res_get_pf_vf_num(void *priv, u16 pf_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_sriov_info *sriov_info;
+
+	if (pf_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt))
+		return -1;
+
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + pf_id;
+	if (!sriov_info->num_vfs)
+		return -1;
+
+	return sriov_info->num_vfs;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
new file mode 100644
index 000000000000..e90d25e6bc20
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -0,0 +1,860 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_RESOURCE_H_
+#define _NBL_RESOURCE_H_
+
+#include "nbl_core.h"
+#include "nbl_hw.h"
+
+#define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
+#define NBL_RES_MGT_TO_COMMON_OPS(res_mgt)	(&((res_mgt)->common_ops))
+#define NBL_RES_MGT_TO_DEV(res_mgt) \
+	NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
+#define NBL_RES_MGT_TO_DMA_DEV(res_mgt)		\
+	NBL_COMMON_TO_DMA_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
+#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
+#define NBL_RES_MGT_TO_QUEUE_MGT(res_mgt)	((res_mgt)->queue_mgt)
+#define NBL_RES_MGT_TO_TXRX_MGT(res_mgt)	((res_mgt)->txrx_mgt)
+#define NBL_RES_MGT_TO_FLOW_MGT(res_mgt)	((res_mgt)->flow_mgt)
+#define NBL_RES_MGT_TO_VSI_MGT(res_mgt)		((res_mgt)->vsi_mgt)
+#define NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt)	((res_mgt)->adminq_mgt)
+#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
+#define NBL_RES_MGT_TO_PROD_OPS(res_mgt)	((res_mgt)->product_ops)
+#define NBL_RES_MGT_TO_RES_INFO(res_mgt)	((res_mgt)->resource_info)
+#define NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->sriov_info)
+#define NBL_RES_MGT_TO_ETH_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->eth_info)
+#define NBL_RES_MGT_TO_VSI_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->vsi_info)
+#define NBL_RES_MGT_TO_PF_NUM(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->max_pf)
+#define NBL_RES_MGT_TO_USTORE_STATS(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->ustore_stats)
+
+#define NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt) ((res_mgt)->hw_ops_tbl)
+#define NBL_RES_MGT_TO_HW_OPS(res_mgt) (NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_HW_PRIV(res_mgt) \
+	(NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt) ((res_mgt)->chan_ops_tbl)
+#define NBL_RES_MGT_TO_CHAN_OPS(res_mgt) \
+	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->ops)
+#define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt) \
+	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_TX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->tx_rings[(index)])
+#define NBL_RES_MGT_TO_RX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->rx_rings[(index)])
+#define NBL_RES_MGT_TO_VECTOR(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->vectors[(index)])
+
+#define NBL_RES_BASE_QID(res_mgt) NBL_RES_MGT_TO_RES_INFO(res_mgt)->base_qid
+#define NBL_RES_NOFITY_QID(res_mgt, local_qid) \
+	(NBL_RES_BASE_QID(res_mgt) * 2 + (local_qid))
+
+#define NBL_MAX_NET_ID				NBL_MAX_FUNC
+#define NBL_MAX_JUMBO_FRAME_SIZE		(9600)
+#define NBL_PKT_HDR_PAD		(ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
+
+#define NBL_TPID_PORT_NUM			(1031)
+#define NBL_VLAN_TPYE				(0)
+#define NBL_QINQ_TPYE				(1)
+
+/* --------- QUEUE ---------- */
+#define NBL_MAX_TXRX_QUEUE			(2048)
+#define NBL_DEFAULT_DESC_NUM			(1024)
+#define NBL_MAX_TXRX_QUEUE_PER_FUNC		(256)
+
+#define NBL_DEFAULT_REP_HW_QUEUE_NUM		(16)
+#define NBL_DEFAULT_PF_HW_QUEUE_NUM		(16)
+#define NBL_DEFAULT_USER_HW_QUEUE_NUM		(16)
+#define NBL_DEFAULT_VF_HW_QUEUE_NUM		(2)
+#define NBL_VSI_PF_LEGACY_QUEUE_NUM_MAX \
+	(NBL_MAX_TXRX_QUEUE_PER_FUNC - NBL_DEFAULT_REP_HW_QUEUE_NUM)
+
+#define NBL_SPECIFIC_VSI_NET_ID_OFFSET		(4)
+#define NBL_MAX_CACHE_SIZE			(256)
+#define NBL_MAX_BATCH_DESC			(64)
+
+enum nbl_qid_map_table_type {
+	NBL_MASTER_QID_MAP_TABLE,
+	NBL_SLAVE_QID_MAP_TABLE,
+	NBL_QID_MAP_TABLE_MAX
+};
+
+struct nbl_queue_vsi_info {
+	u32 curr_qps;
+	u16 curr_qps_static; /* This will not be reset when netdev down */
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 rss_ret_base;
+	u16 rss_entry_size;
+	u16 net_id;
+	u16 queue_offset;
+	u16 queue_num;
+	bool rss_vld;
+	bool vld;
+};
+
+struct nbl_queue_info {
+	struct nbl_queue_vsi_info vsi_info[NBL_VSI_MAX];
+	u64 notify_addr;
+	u32 qid_map_index;
+	u16 num_txrx_queues;
+	u16 rss_ret_base;
+	u16 *txrx_queues;
+	u16 *queues_context;
+	u32 *uvn_stat_pkt_drop;
+	u16 rss_entry_size;
+	u16 split;
+	u32 curr_qps;
+	u16 queue_size;
+};
+
+struct nbl_adapt_desc_gother {
+	u16 level;
+	u32 uvn_desc_rd_entry;
+	u64 get_desc_stats_jiffies;
+};
+
+struct nbl_queue_mgt {
+	DECLARE_BITMAP(txrx_queue_bitmap, NBL_MAX_TXRX_QUEUE);
+	DECLARE_BITMAP(rss_ret_bitmap, NBL_EPRO_RSS_RET_TBL_DEPTH);
+	struct nbl_qid_map_table qid_map_table[NBL_QID_MAP_TABLE_ENTRIES];
+	struct nbl_queue_info queue_info[NBL_MAX_FUNC];
+	u16 net_id_ref_vsinum[NBL_MAX_NET_ID];
+	u32 total_qid_map_entries;
+	int qid_map_select;
+	bool qid_map_ready;
+	u32 qid_map_tail[NBL_QID_MAP_TABLE_MAX];
+	struct nbl_adapt_desc_gother adapt_desc_gother;
+};
+
+/* --------- INTERRUPT ---------- */
+#define NBL_MAX_OTHER_INTERRUPT			1024
+#define NBL_MAX_NET_INTERRUPT			4096
+
+struct nbl_msix_map {
+	u16 valid:1;
+	u16 global_msix_index:13;
+	u16 rsv:2;
+};
+
+struct nbl_msix_map_table {
+	struct nbl_msix_map *base_addr;
+	dma_addr_t dma;
+	size_t size;
+};
+
+struct nbl_func_interrupt_resource_mng {
+	u16 num_interrupts;
+	u16 num_net_interrupts;
+	u16 msix_base;
+	u16 msix_max;
+	u16 *interrupts;
+	struct nbl_msix_map_table msix_map_table;
+};
+
+struct nbl_interrupt_mgt {
+	DECLARE_BITMAP(interrupt_net_bitmap, NBL_MAX_NET_INTERRUPT);
+	DECLARE_BITMAP(interrupt_others_bitmap, NBL_MAX_OTHER_INTERRUPT);
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
+};
+
+/* --------- TXRX ---------- */
+struct nbl_txrx_vsi_info {
+	u16 ring_offset;
+	u16 ring_num;
+};
+
+struct nbl_ring_desc {
+	/* buffer address */
+	__le64 addr;
+	/* buffer length */
+	__le32 len;
+	/* buffer ID */
+	__le16 id;
+	/* the flags depending on descriptor type */
+	__le16 flags;
+};
+
+struct nbl_tx_buffer {
+	struct nbl_ring_desc *next_to_watch;
+	union {
+		struct sk_buff *skb;
+	};
+	dma_addr_t dma;
+	u32 len;
+
+	unsigned int bytecount;
+	unsigned short gso_segs;
+	bool page;
+	u32 tx_flags;
+};
+
+struct nbl_dma_info {
+	dma_addr_t addr;
+	struct page *page;
+	u32 size;
+};
+
+struct nbl_page_cache {
+	u32 head;
+	u32 tail;
+	struct nbl_dma_info page_cache[NBL_MAX_CACHE_SIZE];
+};
+
+struct nbl_rx_buffer {
+	struct nbl_dma_info *di;
+	u16 offset;
+	u16 rx_pad;
+	u16 size;
+	bool last_in_page;
+	bool first_in_page;
+};
+
+struct nbl_res_vector {
+	struct nbl_napi_struct nbl_napi;
+	struct nbl_res_tx_ring *tx_ring;
+	struct nbl_res_rx_ring *rx_ring;
+	u8 __iomem *irq_enable_base;
+	u32 irq_data;
+	bool started;
+	bool net_msix_mask_en;
+};
+
+struct nbl_res_tx_ring {
+	/*data path*/
+	struct nbl_ring_desc *desc;
+	struct nbl_tx_buffer *tx_bufs;
+	struct device *dma_dev;
+	struct net_device *netdev;
+	u8 __iomem *notify_addr;
+	struct nbl_queue_stats stats;
+	struct u64_stats_sync syncp;
+	struct nbl_tx_queue_stats tx_stats;
+	enum nbl_product_type product_type;
+	u16 queue_index;
+	u16 desc_num;
+	u16 notify_qid;
+	u16 avail_used_flags;
+	/* device ring wrap counter */
+	bool used_wrap_counter;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 tail_ptr;
+	u16 mode;
+	u16 vlan_tci;
+	u16 vlan_proto;
+	u8 eth_id;
+	u8 extheader_tx_len;
+
+	/* control path */
+	// dma for desc[]
+	dma_addr_t dma;
+	// size for desc[]
+	unsigned int size;
+	bool valid;
+
+	struct nbl_txrx_vsi_info *vsi_info;
+} ____cacheline_internodealigned_in_smp;
+
+struct nbl_res_rx_ring {
+	/* data path */
+	struct nbl_ring_desc *desc;
+	struct nbl_rx_buffer *rx_bufs;
+	struct nbl_dma_info *di;
+	struct device *dma_dev;
+	struct net_device *netdev;
+	struct page_pool *page_pool;
+	struct nbl_queue_stats stats;
+	struct nbl_rx_queue_stats rx_stats;
+	struct u64_stats_sync syncp;
+	struct nbl_page_cache page_cache;
+
+	enum nbl_product_type product_type;
+	u32 buf_len;
+	u16 avail_used_flags;
+	bool used_wrap_counter;
+	u8 nid;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 tail_ptr;
+	u16 mode;
+	u16 desc_num;
+	u16 queue_index;
+	u16 vlan_tci;
+	u16 vlan_proto;
+	bool linear_skb;
+
+	/* control path */
+	struct nbl_common_info *common;
+	void *txrx_mgt;
+	// dma for desc[]
+	dma_addr_t dma;
+	// size for desc[]
+	unsigned int size;
+	bool valid;
+	u16 notify_qid;
+
+	u16 frags_num_per_page;
+} ____cacheline_internodealigned_in_smp;
+
+struct nbl_txrx_mgt {
+	struct nbl_res_vector **vectors;
+	struct nbl_res_tx_ring **tx_rings;
+	struct nbl_res_rx_ring **rx_rings;
+	struct nbl_txrx_vsi_info vsi_info[NBL_VSI_MAX];
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+};
+
+struct nbl_vsi_mgt {
+};
+
+struct nbl_adminq_mgt {
+	u32 fw_last_hb_seq;
+	unsigned long fw_last_hb_time;
+	struct work_struct eth_task;
+	struct nbl_resource_mgt *res_mgt;
+	u8 module_inplace_changed[NBL_MAX_ETHERNET];
+	u8 link_state_changed[NBL_MAX_ETHERNET];
+	bool fw_resetting;
+	struct wait_queue_head wait_queue;
+	struct mutex eth_lock; /* To prevent link_state_changed mismodified. */
+	void *cmd_filter;
+};
+
+/* --------- FLOW ---------- */
+#define NBL_FEM_HT_PP0_LEN				(2 * 1024)
+#define NBL_MACVLAN_TABLE_LEN				(4096 * 2)
+
+enum nbl_next_stg_id_e {
+	NBL_NEXT_STG_PA		= 1,
+	NBL_NEXT_STG_IPRO	= 2,
+	NBL_NEXT_STG_PP0_S0	= 3,
+	NBL_NEXT_STG_PP0_S1	= 4,
+	NBL_NEXT_STG_PP1_S0	= 5,
+	NBL_NEXT_STG_PP1_S1	= 6,
+	NBL_NEXT_STG_PP2_S0	= 7,
+	NBL_NEXT_STG_PP2_S1	= 8,
+	NBL_NEXT_STG_MCC	= 9,
+	NBL_NEXT_STG_ACL_S0	= 10,
+	NBL_NEXT_STG_ACL_S1	= 11,
+	NBL_NEXT_STG_EPRO	= 12,
+	NBL_NEXT_STG_BYPASS	= 0xf,
+};
+
+enum {
+	NBL_FLOW_UP_TNL,
+	NBL_FLOW_UP,
+	NBL_FLOW_DOWN,
+	NBL_FLOW_MACVLAN_MAX,
+	NBL_FLOW_LLDP_LACP_UP = NBL_FLOW_MACVLAN_MAX,
+	NBL_FLOW_L2_UP_MULTI_MCAST,
+	NBL_FLOW_L3_UP_MULTI_MCAST,
+	NBL_FLOW_UP_MULTI_MCAST_END,
+	NBL_FLOW_L2_DOWN_MULTI_MCAST = NBL_FLOW_UP_MULTI_MCAST_END,
+	NBL_FLOW_L3_DOWN_MULTI_MCAST,
+	NBL_FLOW_DOWN_MULTI_MCAST_END,
+	NBL_FLOW_TYPE_MAX = NBL_FLOW_DOWN_MULTI_MCAST_END,
+};
+
+struct nbl_flow_ht_key {
+	u16 vid;
+	u16 ht_other_index;
+	u32 kt_index;
+};
+
+struct nbl_flow_ht_tbl {
+	struct nbl_flow_ht_key key[4];
+	u32 ref_cnt;
+};
+
+struct nbl_flow_ht_mng {
+	struct nbl_flow_ht_tbl *hash_map[NBL_FEM_HT_PP0_LEN];
+};
+
+struct nbl_flow_fem_entry {
+	s32 type;
+	u16 flow_id;
+	u16 ht0_hash;
+	u16 ht1_hash;
+	u16 hash_table;
+	u16 hash_bucket;
+	u16 tcam_index;
+	u8 tcam_flag;
+	u8 flow_type;
+};
+
+struct nbl_flow_mcc_node {
+	struct list_head node;
+	u16 data;
+	u16 mcc_id;
+	u16 mcc_action;
+	bool mcc_head;
+	u8 type;
+};
+
+struct nbl_flow_mcc_group {
+	struct list_head group_node;
+	/* list_head for mcc_node_list */
+	struct list_head mcc_node;
+	struct list_head mcc_head;
+	unsigned long *vsi_bitmap;
+	u32 nbits;
+	u32 vsi_base;
+	u32 vsi_num;
+	u32 ref_cnt;
+	u16 up_mcc_id;
+	u16 down_mcc_id;
+	bool multi;
+};
+
+struct nbl_flow_switch_res {
+	void *mac_hash_tbl;
+	unsigned long *vf_bitmap;
+	struct list_head allmulti_head;
+	struct list_head allmulti_list;
+	struct list_head mcc_group_head;
+	struct nbl_flow_fem_entry allmulti_up[2];
+	struct nbl_flow_fem_entry allmulti_down[2];
+	u16 vld;
+	u16 network_status;
+	u16 pfc_mode;
+	u16 bp_mode;
+	u16 allmulti_first_mcc;
+	u16 num_vfs;
+	u16 active_vfs;
+	u8 ether_id;
+};
+
+struct nbl_flow_lacp_rule {
+	struct nbl_flow_fem_entry entry;
+	struct list_head node;
+	u16 vsi;
+};
+
+struct nbl_flow_lldp_rule {
+	struct nbl_flow_fem_entry entry;
+	struct list_head node;
+	u16 vsi;
+};
+
+#define NBL_FLOW_PMD_ND_UPCALL_NA (0)
+#define NBL_FLOW_PMD_ND_UPCALL_NS (1)
+#define NBL_FLOW_PMD_ND_UPCALL_FLOW_NUM (2)
+
+struct nbl_flow_mgt {
+	unsigned long *flow_id_bitmap;
+	unsigned long *mcc_id_bitmap;
+	DECLARE_BITMAP(tcam_id, NBL_TCAM_TABLE_LEN);
+	struct nbl_flow_ht_mng pp0_ht0_mng;
+	struct nbl_flow_ht_mng pp0_ht1_mng;
+	struct nbl_flow_switch_res switch_res[NBL_MAX_ETHERNET];
+	struct list_head lldp_list;
+	struct list_head lacp_list;
+	struct list_head ul4s_head;
+	struct list_head dprbac_head;
+	u32 pp_tcam_count;
+	u32 flow_id_cnt;
+	u16 vsi_max_per_switch;
+};
+
+#define NBL_FLOW_INIT_BIT				BIT(1)
+#define NBL_FLOW_AVAILABLE_BIT				BIT(2)
+#define NBL_ALL_PROFILE_NUM				(64)
+#define NBL_ASSOC_PROFILE_GRAPH_NUM			(32)
+#define NBL_ASSOC_PROFILE_NUM				(16)
+#define NBL_ASSOC_PROFILE_STAGE_NUM			(8)
+#define NBL_PROFILE_KEY_MAX_NUM				(32)
+#define NBL_FLOW_KEY_NAME_SIZE				(32)
+#define NBL_FLOW_INDEX_LEN				131072
+#define NBL_FLOW_TABLE_NUM				(64 * 1024)
+
+#define NBL_AT_MAX_NUM					8
+#define NBL_MAX_ACTION_NUM				16
+#define NBL_ACT_BYTE_LEN				32
+
+enum nbl_flow_key_type {
+	NBL_FLOW_KEY_TYPE_PID,		// profile id
+	NBL_FLOW_KEY_TYPE_ACTION,	// AT action data, in 22 bits
+	NBL_FLOW_KEY_TYPE_PHV,		// keys: PHV fields, inport, tab_index
+					// and other extracted 16 bits actions
+	NBL_FLOW_KEY_TYPE_MASK,		// mask 4 bits
+	NBL_FLOW_KEY_TYPE_BTS		// bit setter
+};
+
+#define NBL_PP0_KT_NUM				(0)
+#define NBL_PP1_KT_NUM				(24 * 1024)
+#define NBL_PP2_KT_NUM				(96 * 1024)
+#define NBL_PP0_KT_OFFSET			(120 * 1024)
+#define NBL_PP1_KT_OFFSET			(96 * 1024)
+#define NBL_FEM_HT_PP0_LEN			(2 * 1024)
+#define NBL_FEM_HT_PP1_LEN			(6 * 1024)
+#define NBL_FEM_HT_PP2_LEN			(16 * 1024)
+#define NBL_FEM_HT_PP0_DEPTH			(2 * 1024)
+#define NBL_FEM_HT_PP1_DEPTH			(6 * 1024)
+#define NBL_FEM_HT_PP2_DEPTH			(0) /* 16K, treat as zero */
+#define NBL_FEM_AT_PP1_LEN			(12 * 1024)
+#define NBL_FEM_AT2_PP1_LEN			(4  * 1024)
+#define NBL_FEM_AT_PP2_LEN			(64 * 1024)
+#define NBL_FEM_AT2_PP2_LEN			(16 * 1024)
+#define NBL_TC_MCC_TBL_DEPTH			(4096)
+#define NBL_TC_ENCAP_TBL_DEPTH			(4 * 1024)
+
+struct nbl_flow_key_info {
+	bool valid;
+	enum nbl_flow_key_type key_type;
+	u16 offset;
+	u16 length;
+	u8 key_id;
+	char name[NBL_FLOW_KEY_NAME_SIZE];
+};
+
+struct nbl_profile_msg {
+	bool valid;
+	// pp loopback or not
+	bool pp_mode;
+	bool key_full;
+	bool pt_cmd;
+	bool from_start;
+	bool to_end;
+	bool need_upcall;
+
+	// id in range of 0 to 2
+	u8 pp_id;
+
+	// id in range of 0 to 15
+	u8 profile_id;
+
+	// id in range of 0 to 47
+	u8 g_profile_id;
+
+	// count of valid profile keys in the flow_keys list
+	u8 key_count;
+	u16 key_len;
+	u64 key_flag;
+	u8 act_count;
+	u8 pre_assoc_profile_id[NBL_ASSOC_PROFILE_NUM];
+	u8 next_assoc_profile_id[NBL_ASSOC_PROFILE_NUM];
+	// store all profile key info
+	struct nbl_flow_key_info flow_keys[NBL_PROFILE_KEY_MAX_NUM];
+};
+
+/* --------- INFO ---------- */
+#define NBL_MAX_VF			(NBL_MAX_FUNC - NBL_MAX_PF)
+
+struct nbl_sriov_info {
+	unsigned int bdf;
+	unsigned int num_vfs;
+	unsigned int start_vf_func_id;
+	unsigned short offset;
+	unsigned short stride;
+	unsigned short active_vf_num;
+	u64 vf_bar_start;
+	u64 vf_bar_len;
+	u64 pf_bar_start;
+};
+
+struct nbl_eth_info {
+	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
+	u64 port_caps[NBL_MAX_ETHERNET];
+	u64 port_advertising[NBL_MAX_ETHERNET];
+	u64 port_lp_advertising[NBL_MAX_ETHERNET];
+	u32 link_speed[NBL_MAX_ETHERNET]; /* in Mbps units */
+	u8 active_fc[NBL_MAX_ETHERNET];
+	u8 active_fec[NBL_MAX_ETHERNET];
+	u8 link_state[NBL_MAX_ETHERNET];
+	u8 module_inplace[NBL_MAX_ETHERNET];
+	u8 port_type[NBL_MAX_ETHERNET]; /* enum nbl_port_type */
+	u8 port_max_rate[NBL_MAX_ETHERNET]; /* enum nbl_port_max_rate */
+	u8 module_repluged[NBL_MAX_ETHERNET];
+
+	u8 pf_bitmap[NBL_MAX_ETHERNET];
+	u8 eth_num;
+	u8 resv[3];
+	u8 eth_id[NBL_MAX_PF];
+	u8 logic_eth_id[NBL_MAX_PF];
+	u64 link_down_count[NBL_MAX_ETHERNET];
+};
+
+enum nbl_vsi_serv_type {
+	NBL_VSI_SERV_PF_DATA_TYPE,
+	NBL_VSI_SERV_PF_CTLR_TYPE,
+	NBL_VSI_SERV_PF_USER_TYPE,
+	NBL_VSI_SERV_PF_XDP_TYPE,
+	NBL_VSI_SERV_VF_DATA_TYPE,
+	/* use for pf_num > eth_num, the extra pf belong pf0's switch */
+	NBL_VSI_SERV_PF_EXTRA_TYPE,
+	NBL_VSI_SERV_MAX_TYPE,
+};
+
+struct nbl_vsi_serv_info {
+	u16 base_id;
+	u16 num;
+};
+
+struct nbl_vsi_mac_info {
+	u16 vlan_proto;
+	u16 vlan_tci;
+	int rate;
+	u8 mac[ETH_ALEN];
+	bool trusted;
+};
+
+struct nbl_vsi_info {
+	u16 num;
+	struct nbl_vsi_serv_info serv_info[NBL_MAX_ETHERNET]
+					  [NBL_VSI_SERV_MAX_TYPE];
+	struct nbl_vsi_mac_info mac_info[NBL_MAX_FUNC];
+};
+
+struct nbl_net_ring_num_info {
+	u16 pf_def_max_net_qp_num;
+	u16 vf_def_max_net_qp_num;
+	u16 net_max_qp_num[NBL_MAX_FUNC];
+};
+
+/* Host Board Configuration */
+/* 256 Byte */
+struct nbl_host_board_config {
+	/* dw0/1 */
+	u8 version;
+	char magic[7];
+
+	/* dw2 */
+	u8 board_id;
+	u8 def_tlv_index;
+	u8 spi_flash_type;
+	u8 dw2_rsv_zero;		// 0x00
+
+	/* dw3 -bits */
+	u32 port_type: 1;		// 0: optical, 1: electrical
+	u32 port_number: 7;
+	u32 port_speed: 2;
+	u32 port_module_type: 3;	// 0: SFP, 1: QSFP, 2: PHY
+	u32 upper_config: 1;	// 0: lower, 1: upper
+	u32 dw3_bits_rsv1: 1;
+	u32 i2c_mdio: 1;		// 0: i2c, 1: mdio
+	u32 mdio_pin: 1;		// 0: N to N, 1: 1 to N
+	u32 pam4_supported: 1;	// 0: no, 1: yes
+	u32 dual_bc_supported: 1;	// 0: no, 1: yes
+	u32 bc_index: 1;
+	u32 disable_crypto: 1;	// 0: no, 1: yes
+	u32 ocp_card: 1;		// 0: no, 1: yes
+	u32 oem: 1;		// 0: no, 1: yes
+	u32 dw3_bits_rsv2: 9;	// 0
+
+	/* dw4 - bits */
+	u32 dw4_bits_rsv;		// 0
+
+	/* dw5 */
+	u8 pcie_pf_mask;		// bitmap
+	u8 pcie_vpd_mask;		// bitmap
+	u8 pcie_lanes;		// valid value: 1/2/4/8/16
+	u8 pcie_speed;		// valid value: 1/2/3/4
+
+	/* dw6 */
+	u8 eth_lane_mask;		// bitmap
+	u8 eth_mac_mask;		// bitmap
+	u8 phy_type;
+	u8 board_version;
+
+	/* dw7 */
+	u8 ncsi_package_id;
+	u8 fru_eeprom_i2c_addr;
+	u8 ext_gpio_i2c_addr0;
+	u8 ext_gpio_i2c_addr1;
+
+	/* dw8 */
+	u8 phy_mdio_addr[4];
+
+	/* dw9~12 */
+	u16 pcie_vendor_id;	// 0x1F0F
+	u16 pcie_device_id;
+	u32 pcie_class_rev;	// 0x02000000
+	u16 pcie_sub_vendor_id;	// 0x1F0F
+	u16 pcie_sub_device_id;	// 0x0001
+	u16 pcie_vf_device_id;	// 0x340D
+	u16 pcie_vf_sub_device_id;	// 0x0001
+
+	/* dw13 */
+	u16 pf_max_vfs;
+	u16 device_max_qps;	// 2048
+
+	/* dw14 */
+	u16 smbus_addr0;
+	u16 smbus_addr1;
+
+	/* dw15 */
+	u32 temp_i2c_addr: 8;	// onboard temperature sensor
+	u32 temp_type: 5;
+	u32 temp_port_index: 3;
+	u32 voltage_i2c_addr: 8;	// onboard voltage sensor
+	u32 voltage_type: 5;
+	u32 voltage_port_index: 3;
+
+	/* dw16~44 */
+	u64 port_capability[2];	// dw16~19
+	u8 port_gpio[4][16];	// dw20~35
+	u8 misc_gpio[16];		// dw36~39
+
+	/* dw40~49 */
+	char controller_part_no[8];	// dw40/41
+	char board_pn[12];		// dw42~44
+	char product_name[20];		// dw45~49
+
+	/* dw50~59 */
+	u32 reserved_zero0;	// 0x00
+	u32 reserved_zero1;
+	u32 reserved_zero2;
+	u32 reserved_zero3;
+	u32 reserved_zero4;
+	u32 reserved_zero5;
+	u32 reserved_zero6;
+	u32 reserved_zero7;
+	u32 reserved_zero8;
+	u32 reserved_zero9;
+
+	/* dw60~63 */
+	u32 reserved_one0;		// 0xFF
+	u32 reserved_one1;
+	u32 reserved_one2;
+	u32 reserved_one3;
+};
+
+struct nbl_serial_number_info {
+	u8 len;
+	char sn[128];
+};
+
+struct nbl_resource_info {
+	/* ctrl-dev owned pfs */
+	DECLARE_BITMAP(func_bitmap, NBL_MAX_FUNC);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info;
+	struct nbl_vsi_info *vsi_info;
+	u32 base_qid;
+	u32 max_vf_num;
+
+	struct nbl_net_ring_num_info net_ring_num_info;
+
+	/* for af use */
+	u16 eth_mode;
+	u8 max_pf;
+	struct nbl_board_port_info board_info;
+	/* store all pf names for vf/rep device name use */
+	char pf_name_list[NBL_MAX_PF][IFNAMSIZ];
+
+	u8 link_forced_info[NBL_MAX_FUNC];
+	struct nbl_mtu_entry mtu_list[NBL_MAX_MTU_NUM];
+
+	struct nbl_ustore_stats *ustore_stats;
+};
+
+struct nbl_resource_common_ops {
+	u16 (*vsi_id_to_func_id)(void *res_mgt, u16 vsi_id);
+	int (*vsi_id_to_pf_id)(void *res_mgt, u16 vsi_id);
+	u16 (*vsi_id_to_vf_id)(void *res_mgt, u16 vsi_id);
+	u16 (*pfvfid_to_func_id)(void *res_mgt, int pfid, int vfid);
+	u16 (*pfvfid_to_vsi_id)(void *res_mgt, int pfid, int vfid, u16 type);
+	u16 (*func_id_to_vsi_id)(void *res_mgt, u16 func_id, u16 type);
+	int (*func_id_to_pfvfid)(void *res_mgt, u16 func_id, int *pfid,
+				 int *vfid);
+	int (*func_id_to_bdf)(void *res_mgt, u16 func_id, u8 *bus, u8 *dev,
+			      u8 *function);
+	u64 (*get_func_bar_base_addr)(void *res_mgt, u16 func_id);
+	u16 (*get_particular_queue_id)(void *res_mgt, u16 vsi_id);
+	u8 (*vsi_id_to_eth_id)(void *res_mgt, u16 vsi_id);
+	u8 (*eth_id_to_pf_id)(void *res_mgt, u8 eth_id);
+	u8 (*eth_id_to_lag_id)(void *res_mgt, u8 eth_id);
+	bool (*check_func_active_by_queue)(void *res_mgt, u16 func_id);
+	int (*get_queue_num)(void *res_mgt, u16 func_id, u16 *tx_queue_num,
+			     u16 *rx_queue_num);
+};
+
+struct nbl_res_product_ops {
+	/* for queue */
+	void (*queue_mgt_init)(struct nbl_queue_mgt *queue_mgt);
+	int (*setup_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id, u64 notify_addr);
+	void (*remove_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				     u16 func_id);
+	int (*init_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				  struct nbl_queue_mgt *queue_mgt,
+				  struct nbl_hw_ops *hw_ops);
+
+	/* for intr */
+	void (*nbl_intr_mgt_init)(struct nbl_resource_mgt *res_mgt);
+};
+
+struct nbl_resource_mgt {
+	struct nbl_resource_common_ops common_ops;
+	struct nbl_common_info *common;
+	struct nbl_resource_info *resource_info;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_queue_mgt *queue_mgt;
+	struct nbl_interrupt_mgt *intr_mgt;
+	struct nbl_txrx_mgt *txrx_mgt;
+	struct nbl_flow_mgt *flow_mgt;
+	struct nbl_vsi_mgt *vsi_mgt;
+	struct nbl_adminq_mgt *adminq_mgt;
+	struct nbl_res_product_ops *product_ops;
+	DECLARE_BITMAP(fix_capability, NBL_FIX_CAP_NBITS);
+};
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member, and
+ * contains its unique data structure in the reset of it.
+ */
+struct nbl_resource_mgt_leonis {
+	struct nbl_resource_mgt res_mgt;
+};
+
+#define NBL_RES_FW_CMD_FILTER_MAX		8
+struct nbl_res_fw_cmd_filter {
+	int (*in)(struct nbl_resource_mgt *res_mgt, void *in, u16 in_len);
+	int (*out)(struct nbl_resource_mgt *res_mgt, void *in, u16 in_len,
+		   void *out, u16 out_len);
+};
+
+u16 nbl_res_vsi_id_to_func_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+u16 nbl_res_pfvfid_to_func_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			      int vfid);
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type);
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type);
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid);
+u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id);
+u8 nbl_res_eth_id_to_lag_id(struct nbl_resource_mgt *res_mgt, u8 eth_id);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
+u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id);
+u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+
+int nbl_adminq_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_adminq_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_adminq_setup_ops(struct nbl_resource_ops *resource_ops);
+bool nbl_res_get_fix_capability(void *priv, enum nbl_fix_cap_type cap_type);
+void nbl_res_set_fix_capability(struct nbl_resource_mgt *res_mgt,
+				enum nbl_fix_cap_type cap_type);
+
+int nbl_res_open_sfp(struct nbl_resource_mgt *res_mgt, u8 eth_id);
+int nbl_res_get_eth_mac(struct nbl_resource_mgt *res_mgt, u8 *mac, u8 eth_id);
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type);
+bool nbl_res_vf_is_active(void *priv, u16 func_id);
+void nbl_res_set_hw_status(void *priv, enum nbl_hw_status hw_status);
+int nbl_res_get_pf_vf_num(void *priv, u16 pf_id);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 57d88ef0fb6d..853bb3022e51 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -77,6 +77,25 @@ do {									\
 #define NBL_COMMON_TO_BOARD_ID(common)		((common)->board_id)
 #define NBL_COMMON_TO_LOGIC_ETH_ID(common)	((common)->logic_eth_id)
 
+#define NBL_ONE_ETHERNET_PORT			(1)
+#define NBL_TWO_ETHERNET_PORT			(2)
+#define NBL_FOUR_ETHERNET_PORT			(4)
+#define NBL_DEFAULT_VSI_ID_GAP			(1024)
+#define NBL_TWO_ETHERNET_VSI_ID_GAP		(512)
+#define NBL_FOUR_ETHERNET_VSI_ID_GAP		(256)
+
+#define NBL_VSI_ID_GAP(m)					\
+	({							\
+		typeof(m) _m = (m);				\
+		_m == NBL_FOUR_ETHERNET_PORT ?			\
+			NBL_FOUR_ETHERNET_VSI_ID_GAP :		\
+			(_m == NBL_TWO_ETHERNET_PORT ?		\
+				 NBL_TWO_ETHERNET_VSI_ID_GAP :	\
+				 NBL_DEFAULT_VSI_ID_GAP);	\
+	})
+
+#define NBL_INVALID_QUEUE_ID			(0xFFFF)
+
 struct nbl_common_info {
 	struct pci_dev *pdev;
 	struct device *dev;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 1096feea5ce6..243869883801 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -21,7 +21,10 @@ struct nbl_hw_ops {
 	u16 (*get_mailbox_rx_tail_ptr)(void *priv);
 	bool (*check_mailbox_dma_err)(void *priv, bool tx);
 	u32 (*get_host_pf_mask)(void *priv);
-
+	u32 (*get_host_pf_fid)(void *priv, u16 func_id);
+	u32 (*get_real_bus)(void *priv);
+	u64 (*get_pf_bar_addr)(void *priv, u16 func_id);
+	u64 (*get_vf_bar_addr)(void *priv, u16 func_id);
 	void (*cfg_mailbox_qinfo)(void *priv, u16 func_id, u16 bus, u16 devid,
 				  u16 function);
 	void (*config_adminq_rxq)(void *priv, dma_addr_t dma_addr,
@@ -34,9 +37,19 @@ struct nbl_hw_ops {
 	void (*update_adminq_queue_tail_ptr)(void *priv, u16 tail_ptr, u8 txrx);
 	bool (*check_adminq_dma_err)(void *priv, bool tx);
 
+	u8 __iomem *(*get_hw_addr)(void *priv, size_t *size);
 	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
 	enum nbl_hw_status (*get_hw_status)(void *priv);
-
+	void (*set_fw_ping)(void *priv, u32 ping);
+	u32 (*get_fw_pong)(void *priv);
+	void (*set_fw_pong)(void *priv, u32 pong);
+	int (*process_abnormal_event)(void *priv,
+				      struct nbl_abnormal_event_info *info);
+	/* for board cfg */
+	u32 (*get_fw_eth_num)(void *priv);
+	u32 (*get_fw_eth_map)(void *priv);
+	void (*get_board_info)(void *priv, struct nbl_board_port_info *board);
+	u32 (*get_quirks)(void *priv);
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
new file mode 100644
index 000000000000..b0cc6ac973f4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_RESOURCE_H_
+#define _NBL_DEF_RESOURCE_H_
+
+#include "nbl_include.h"
+
+struct nbl_resource_pt_ops {
+	netdev_tx_t (*start_xmit)(struct sk_buff *skb,
+				  struct net_device *netdev);
+	int (*napi_poll)(struct napi_struct *napi, int budget);
+};
+
+struct nbl_resource_ops {
+	int (*init_chip_module)(void *priv);
+	void (*deinit_chip_module)(void *priv);
+	void (*get_resource_pt_ops)(void *priv,
+				    struct nbl_resource_pt_ops *pt_ops);
+	int (*queue_init)(void *priv);
+	int (*vsi_init)(void *priv);
+	int (*init_vf_msix_map)(void *priv, u16 func_id, bool enable);
+	int (*configure_msix_map)(void *priv, u16 func_id, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv, u16 func_id);
+	int (*enable_mailbox_irq)(void *priv, u16 func_id, u16 vector_id,
+				  bool enable_msix);
+	int (*enable_abnormal_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_adminq_irq)(void *p, u16 vector_id, bool enable_msix);
+	u16 (*get_global_vector)(void *priv, u16 vsi_id, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 vsi_id, u16 local_vec_id);
+	int (*get_mbx_irq_num)(void *priv);
+	int (*get_adminq_irq_num)(void *priv);
+	int (*get_abnormal_irq_num)(void *priv);
+
+	int (*alloc_rings)(void *priv, struct net_device *netdev,
+			   struct nbl_ring_param *param);
+	void (*remove_rings)(void *priv);
+	dma_addr_t (*start_tx_ring)(void *priv, u8 ring_index);
+	void (*stop_tx_ring)(void *priv, u8 ring_index);
+	dma_addr_t (*start_rx_ring)(void *priv, u8 ring_index, bool use_napi);
+	void (*stop_rx_ring)(void *priv, u8 ring_index);
+	void (*update_rx_ring)(void *priv, u16 index);
+	void (*kick_rx_ring)(void *priv, u16 index);
+	struct nbl_napi_struct *(*get_vector_napi)(void *priv, u16 index);
+	void (*set_vector_info)(void *priv, u8 __iomem *irq_enable_base,
+				u32 irq_data, u16 index, bool mask_en);
+	void (*register_vsi_ring)(void *priv, u16 vsi_index, u16 ring_offset,
+				  u16 ring_num);
+	int (*register_net)(void *priv, u16 func_id,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv, u16 func_id);
+	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*free_txrx_queues)(void *priv, u16 vsi_id);
+	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
+			      u16 queue_offset, u16 queue_num);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*setup_queue)(void *priv, struct nbl_txrx_queue_param *param,
+			   bool is_tx);
+	void (*remove_all_queues)(void *priv, u16 vsi_id);
+	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps,
+			 bool rss_indir_set);
+	void (*remove_cqs)(void *priv, u16 vsi_id);
+	void (*clear_queues)(void *priv, u16 vsi_id);
+
+	u16 (*get_local_queue_id)(void *priv, u16 vsi_id, u16 global_queue_id);
+	u16 (*get_global_queue_id)(void *priv, u16 vsi_id, u16 local_queue_id);
+
+	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
+						u32 *irq_data);
+
+	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan, u16 vsi);
+	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan, u16 vsi);
+	int (*add_lldp_flow)(void *priv, u16 vsi);
+	void (*del_lldp_flow)(void *priv, u16 vsi);
+	int (*add_multi_rule)(void *priv, u16 vsi);
+	void (*del_multi_rule)(void *priv, u16 vsi);
+	int (*add_multi_mcast)(void *priv, u16 vsi);
+	void (*del_multi_mcast)(void *priv, u16 vsi);
+	int (*setup_multi_group)(void *priv);
+	void (*remove_multi_group)(void *priv);
+
+	void (*clear_flow)(void *priv, u16 vsi_id);
+
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			   u8 *logic_eth_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	u32 (*get_tx_headroom)(void *priv);
+
+	void (*get_rep_queue_info)(void *priv, u16 *queue_num, u16 *queue_size);
+	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
+	int (*get_max_mtu)(void *priv);
+	void (*get_net_stats)(void *priv, struct nbl_stats *queue_stats);
+	void (*get_rxfh_indir_size)(void *priv, u16 vsi_id,
+				    u32 *rxfh_indir_size);
+	int (*set_rxfh_indir)(void *priv, u16 vsi_id, const u32 *indir,
+			      u32 indir_size);
+	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto,
+			      u8 vsi_index);
+
+	u8 __iomem *(*get_hw_addr)(void *priv, size_t *size);
+	u16 (*get_function_id)(void *priv, u16 vsi_id);
+	void (*get_real_bdf)(void *priv, u16 vsi_id, u8 *bus, u8 *dev,
+			     u8 *function);
+
+	int (*get_port_attributes)(void *priv);
+	int (*update_ring_num)(void *priv);
+	int (*set_ring_num)(void *priv,
+			    struct nbl_cmd_net_ring_num *param);
+	int (*get_part_number)(void *priv, char *part_number);
+	int (*get_serial_number)(void *priv, char *serial_number);
+	int (*enable_port)(void *priv, bool enable);
+
+	void (*recv_port_notify)(void *priv, void *data);
+	int (*get_link_state)(void *priv, u8 eth_id,
+			      struct nbl_eth_link_info *eth_link_info);
+	int (*set_eth_mac_addr)(void *priv, u8 *mac, u8 eth_id);
+	int (*process_abnormal_event)(void *priv,
+				      struct nbl_abnormal_event_info *info);
+	int (*set_wol)(void *priv, u8 eth_id, bool enable);
+	void (*adapt_desc_gother)(void *priv);
+	void (*flr_clear_net)(void *priv, u16 vfid);
+	void (*flr_clear_queues)(void *priv, u16 vfid);
+	void (*flr_clear_flows)(void *priv, u16 vfid);
+	void (*flr_clear_interrupt)(void *priv, u16 vfid);
+	u16 (*covert_vfid_to_vsi_id)(void *priv, u16 vfid);
+	void (*unmask_all_interrupts)(void *priv);
+	u16 (*get_vf_function_id)(void *priv, u16 vsi_id, int vf_id);
+	u16 (*get_vf_vsi_id)(void *priv, u16 vsi_id, int vf_id);
+	bool (*check_vf_is_active)(void *priv, u16 func_id);
+	int (*get_ustore_total_pkt_drop_stats)(void *priv, u8 eth_id,
+					       struct nbl_ustore_stats *stat);
+
+	bool (*check_fw_heartbeat)(void *priv);
+	bool (*check_fw_reset)(void *priv);
+	int (*set_sfp_state)(void *priv, u8 eth_id, u8 state);
+	int (*passthrough_fw_cmd)(void *priv,
+				  struct nbl_passthrough_fw_cmd *param,
+				  struct nbl_passthrough_fw_cmd *result);
+	int (*get_board_id)(void *priv);
+
+	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
+
+	dma_addr_t (*restore_abnormal_ring)(void *priv, int ring_index,
+					    int type);
+	int (*restart_abnormal_ring)(void *priv, int ring_index, int type);
+	int (*stop_abnormal_sw_queue)(void *priv, u16 local_queue_id, int type);
+	int (*stop_abnormal_hw_queue)(void *priv, u16 vsi_id,
+				      u16 local_queue_id, int type);
+	int (*get_link_forced)(void *priv, u16 vsi_id);
+	int (*set_tx_rate)(void *priv, u16 func_id, int tx_rate, int burst);
+	int (*set_rx_rate)(void *priv, u16 func_id, int rx_rate, int burst);
+
+	u16 (*get_vsi_global_queue_id)(void *priv, u16 vsi_id, u16 local_qid);
+
+	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
+	void (*get_active_func_bitmaps)(void *priv, unsigned long *bitmap,
+					int max_func);
+
+	void (*register_dev_name)(void *priv, u16 vsi_id, char *name);
+	void (*get_dev_name)(void *priv, u16 vsi_id, char *name);
+
+	int (*check_flow_table_spec)(void *priv, u16 vlan_cnt, u16 unicast_cnt,
+				     u16 multicast_cnt);
+};
+
+struct nbl_resource_ops_tbl {
+	struct nbl_resource_ops *ops;
+	void *priv;
+};
+
+int nbl_res_init_leonis(void *p, struct nbl_init_param *param);
+void nbl_res_remove_leonis(void *p);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 64ac886f0ba2..8759ba3d478c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -12,6 +12,9 @@
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 
+#define NBL_PAIR_ID_GET_TX(id)				((id) * 2 + 1)
+#define NBL_PAIR_ID_GET_RX(id)				((id) * 2)
+
 #define NBL_MAX_PF					8
 
 #define NBL_NEXT_ID(id, max)				\
@@ -20,11 +23,41 @@
 		((_id) == (max) ? 0 : (_id) + 1);	\
 	})
 
+#define NBL_MAX_FUNC					(520)
+#define NBL_MAX_MTU_NUM					15
+
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
 };
 
+enum nbl_fix_cap_type {
+	NBL_TASK_FW_HB_CAP,
+	NBL_TASK_FW_RESET_CAP,
+	NBL_TASK_CLEAN_ADMINDQ_CAP,
+	NBL_TASK_CLEAN_MAILBOX_CAP,
+	NBL_RESTOOL_CAP,
+	NBL_TASK_ADAPT_DESC_GOTHER,
+	NBL_PROCESS_FLR_CAP,
+	NBL_RECOVERY_ABN_STATUS,
+	NBL_TASK_KEEP_ALIVE,
+	NBL_TASK_RESET_CAP,
+	NBL_TASK_RESET_CTRL_CAP,
+	NBL_NEED_DESTROY_CHIP,
+	NBL_FIX_CAP_NBITS
+};
+
+enum nbl_sfp_module_state {
+	NBL_SFP_MODULE_OFF,
+	NBL_SFP_MODULE_ON,
+};
+
+enum {
+	NBL_VSI_DATA = 0,/* default vsi in kernel or independent dpdk */
+	NBL_VSI_CTRL,
+	NBL_VSI_MAX,
+};
+
 enum nbl_hw_status {
 	NBL_HW_NOMAL,
 	/* Most hw module is not work nomal exclude pcie/emp */
@@ -102,6 +135,78 @@ struct nbl_queue_cfg_param {
 	u16 half_offload_en;
 };
 
+struct nbl_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 descs;
+};
+
+struct nbl_tx_queue_stats {
+	u64 tso_packets;
+	u64 tso_bytes;
+	u64 tx_csum_packets;
+	u64 tx_busy;
+	u64 tx_dma_busy;
+	u64 tx_multicast_packets;
+	u64 tx_unicast_packets;
+	u64 tx_skb_free;
+	u64 tx_desc_addr_err_cnt;
+	u64 tx_desc_len_err_cnt;
+};
+
+struct nbl_rx_queue_stats {
+	u64 rx_csum_packets;
+	u64 rx_csum_errors;
+	u64 rx_multicast_packets;
+	u64 rx_unicast_packets;
+	u64 rx_desc_addr_err_cnt;
+	u64 rx_alloc_buf_err_cnt;
+	u64 rx_cache_reuse;
+	u64 rx_cache_full;
+	u64 rx_cache_empty;
+	u64 rx_cache_busy;
+	u64 rx_cache_waive;
+};
+
+struct nbl_stats {
+	/* for toe stats */
+	u64 tso_packets;
+	u64 tso_bytes;
+	u64 tx_csum_packets;
+	u64 rx_csum_packets;
+	u64 rx_csum_errors;
+	u64 tx_busy;
+	u64 tx_dma_busy;
+	u64 tx_multicast_packets;
+	u64 tx_unicast_packets;
+	u64 rx_multicast_packets;
+	u64 rx_unicast_packets;
+	u64 tx_skb_free;
+	u64 tx_desc_addr_err_cnt;
+	u64 tx_desc_len_err_cnt;
+	u64 rx_desc_addr_err_cnt;
+	u64 rx_alloc_buf_err_cnt;
+	u64 rx_cache_reuse;
+	u64 rx_cache_full;
+	u64 rx_cache_empty;
+	u64 rx_cache_busy;
+	u64 rx_cache_waive;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 rx_packets;
+	u64 rx_bytes;
+};
+
+struct nbl_ustore_stats {
+	u64 rx_drop_packets;
+	u64 rx_trun_packets;
+};
+
+struct nbl_hw_stats {
+	u64 *total_uvn_stat_pkt_drop;
+	struct nbl_ustore_stats start_ustore_stats;
+};
+
 enum nbl_fw_port_speed {
 	NBL_FW_PORT_SPEED_10G,
 	NBL_FW_PORT_SPEED_25G,
@@ -109,8 +214,92 @@ enum nbl_fw_port_speed {
 	NBL_FW_PORT_SPEED_100G,
 };
 
+#define PASSTHROUGH_FW_CMD_DATA_LEN			(3072)
+struct nbl_passthrough_fw_cmd {
+	u16 opcode;
+	u16 errcode;
+	u16 in_size;
+	u16 out_size;
+	u8 data[PASSTHROUGH_FW_CMD_DATA_LEN];
+};
+
+#define NBL_NET_RING_NUM_CMD_LEN				(520)
+struct nbl_cmd_net_ring_num {
+	u16 pf_def_max_net_qp_num;
+	u16 vf_def_max_net_qp_num;
+	u16 net_max_qp_num[NBL_NET_RING_NUM_CMD_LEN];
+};
+
+enum {
+	NBL_NETIF_F_SG_BIT,			/* Scatter/gather IO. */
+	NBL_NETIF_F_IP_CSUM_BIT,		/* csum TCP/UDP over IPv4 */
+	NBL_NETIF_F_HW_CSUM_BIT,		/* csum all the packets. */
+	NBL_NETIF_F_IPV6_CSUM_BIT,		/* csum TCP/UDP over IPV6 */
+	NBL_NETIF_F_HIGHDMA_BIT,		/* DMA to high memory. */
+	NBL_NETIF_F_HW_VLAN_CTAG_TX_BIT,	/* Tx VLAN CTAG HW accel */
+	NBL_NETIF_F_HW_VLAN_CTAG_RX_BIT,	/* Rx VLAN CTAG HW accel */
+	NBL_NETIF_F_HW_VLAN_CTAG_FILTER_BIT,	/* Rx filtering on VLAN CTAG */
+	NBL_NETIF_F_TSO_BIT,			/* TCPv4 segmentation */
+	NBL_NETIF_F_GSO_ROBUST_BIT,		/* SKB_GSO_DODGY */
+	NBL_NETIF_F_TSO6_BIT,			/* TCPv6 segmentation */
+	NBL_NETIF_F_GSO_GRE_BIT,		/* GRE with TSO */
+	NBL_NETIF_F_GSO_GRE_CSUM_BIT,		/* GRE with csum with TSO */
+	NBL_NETIF_F_GSO_UDP_TUNNEL_BIT,		/* UDP TUNNEL with TSO */
+	NBL_NETIF_F_GSO_UDP_TUNNEL_CSUM_BIT,	/* UDP TUNNEL with TSO & CSUM */
+	NBL_NETIF_F_GSO_PARTIAL_BIT,		/* Only segment inner-most L4
+						 * in hardware and all other
+						 * headers in software.
+						 */
+	NBL_NETIF_F_GSO_UDP_L4_BIT,		/* UDP payload GSO (not UFO) */
+	NBL_NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
+	NBL_NETIF_F_NTUPLE_BIT,			/* N-tuple filters supported */
+	NBL_NETIF_F_RXHASH_BIT,			/* Rx hashing offload */
+	NBL_NETIF_F_RXCSUM_BIT,			/* Rx checksumming offload */
+	NBL_NETIF_F_HW_VLAN_STAG_TX_BIT,	/* Tx VLAN STAG HW accel */
+	NBL_NETIF_F_HW_VLAN_STAG_RX_BIT,	/* Rx VLAN STAG HW accel */
+	NBL_NETIF_F_HW_VLAN_STAG_FILTER_BIT,	/* Rx filtering on VLAN STAG */
+	NBL_NETIF_F_HW_TC_BIT,			/* Offload TC infrastructure */
+	NBL_FEATURES_COUNT
+};
+
+#define NBL_FEATURE(name)			(1 << (NBL_##name##_BIT))
+
+enum nbl_abnormal_event_module {
+	NBL_ABNORMAL_EVENT_DVN = 0,
+	NBL_ABNORMAL_EVENT_UVN,
+	NBL_ABNORMAL_EVENT_MAX,
+};
+
+struct nbl_abnormal_details {
+	bool abnormal;
+	u16 qid;
+	u16 vsi_id;
+};
+
+struct nbl_abnormal_event_info {
+	struct nbl_abnormal_details details[NBL_ABNORMAL_EVENT_MAX];
+	u32 other_abnormal_info;
+};
+
 enum nbl_performance_mode {
 	NBL_QUIRKS_NO_TOE,
 	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
 };
+
+struct nbl_ring_param {
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+	u16 queue_size;
+};
+
+struct nbl_mtu_entry {
+	u32 ref_count;
+	u16 mtu_value;
+};
+
+struct nbl_napi_struct {
+	struct napi_struct napi;
+	atomic_t is_irq;
+};
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 3276dd2936ae..9cee11498e9f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -11,8 +11,8 @@ static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	{
 		.hw_init	= nbl_hw_init_leonis,
 		.hw_remove	= nbl_hw_remove_leonis,
-		.res_init	= NULL,
-		.res_remove	= NULL,
+		.res_init	= nbl_res_init_leonis,
+		.res_remove	= nbl_res_remove_leonis,
 		.chan_init	= nbl_chan_init_common,
 		.chan_remove	= nbl_chan_remove_common,
 	},
@@ -72,7 +72,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = product_base_ops->chan_init(adapter, param);
 	if (ret)
 		goto chan_init_fail;
+
+	ret = product_base_ops->res_init(adapter, param);
+	if (ret)
+		goto res_init_fail;
 	return adapter;
+res_init_fail:
+	product_base_ops->chan_remove(adapter);
 chan_init_fail:
 	product_base_ops->hw_remove(adapter);
 hw_init_fail:
@@ -87,6 +93,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAP_TO_DEV(adapter);
 	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
+	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
 	product_base_ops->hw_remove(adapter);
 	devm_kfree(dev, adapter);
-- 
2.47.3


