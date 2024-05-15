Return-Path: <netdev+bounces-96462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3778C6095
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371F31F217AF
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8633D966;
	Wed, 15 May 2024 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mb1OwGo5"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3683BBCE;
	Wed, 15 May 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753055; cv=none; b=grNrud17VM7qAGUrn9m8Gs01yq240fo9wW8/vc7KKnyJxOk/0KKMs9ZtbIZgrJusfG166NpQVdvqftNgrNqUxrcuMgGhYznyc1magOnPPXQo5MydS9fr1az2hO2UpP7O+nbcbuVgOtkihIvE/ycgzZpWf8BOGt0V+11kcOvRHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753055; c=relaxed/simple;
	bh=Y6X+gC+9gvqm0WAG7CM1zByLsWvY6PUvWeSdHEDc8qU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuaL2vOHUcCsQ8peALPqK4rQaVcBe97gSK+lKvwiLcU9gwirD+iJe72eOx8+QJmWX1bBU1aNFajEpAkmULzyR2qPSBHqd2uTw8gMMis8hQAPrnffr2XyreA9H1+RE5EU+e/YmjJN7dvZ/168htUVgS6dVeaghG/AFhDW4UGqBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mb1OwGo5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F63Qqd007930;
	Wed, 15 May 2024 01:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715753006;
	bh=C/P3WTOn79e9TPL1+KKvtCqTzZNEP2j8S8JWHHgwbTA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Mb1OwGo5YaNt7g6e75Jkj4sJRINZd73J7+uEecbLZQ+utGgl8FfIPFO52bu79o8qj
	 GismL1L5OYCTZfqoEIkW3RYCR3+JCNxiCzqM0TR+DRiyGssqtRruR2dP2oyhAg99w6
	 LVetb0xACqxqVRHS1YCDdyHD/fs0PeaeJv+rDC/Y=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F63QGR022649
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 01:03:26 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 01:03:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 01:03:26 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F63QwL071302;
	Wed, 15 May 2024 01:03:26 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44F63PbV021287;
	Wed, 15 May 2024 01:03:26 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        Simon Horman
	<horms@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo
	<diogo.ivo@siemens.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next v4 1/3] net: ti: icssg-prueth: Add helper functions to configure FDB
Date: Wed, 15 May 2024 11:33:18 +0530
Message-ID: <20240515060320.2783244-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515060320.2783244-1-danishanwar@ti.com>
References: <20240515060320.2783244-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Introduce helper functions to configure firmware FDB tables, VLAN tables
and Port VLAN ID settings to aid adding Switch mode support.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 170 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_config.h |  19 +++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  12 ++
 3 files changed, 201 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 15f2235bf90f..2213374d4d45 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -477,3 +477,173 @@ void icssg_config_set_speed(struct prueth_emac *emac)
 
 	writeb(fw_speed, emac->dram.va + PORT_LINK_SPEED_OFFSET);
 }
+
+int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp)
+{
+	struct prueth *prueth = emac->prueth;
+	int slice = prueth_emac_slice(emac);
+	int addr, ret;
+
+	addr = icssg_queue_pop(prueth, slice == 0 ?
+			       ICSSG_CMD_POP_SLICE0 : ICSSG_CMD_POP_SLICE1);
+	if (addr < 0)
+		return addr;
+
+	/* First 4 bytes have FW owned buffer linking info which should
+	 * not be touched
+	 */
+	memcpy_toio(prueth->shram.va + addr + 4, cmd, sizeof(*cmd));
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_CMD_PUSH_SLICE0 : ICSSG_CMD_PUSH_SLICE1, addr);
+	ret = read_poll_timeout(icssg_queue_pop, addr, addr >= 0,
+				2000, 20000000, false, prueth, slice == 0 ?
+				ICSSG_RSP_POP_SLICE0 : ICSSG_RSP_POP_SLICE1);
+	if (ret) {
+		netdev_err(emac->ndev, "Timedout sending HWQ message\n");
+		return ret;
+	}
+
+	memcpy_fromio(rsp, prueth->shram.va + addr, sizeof(*rsp));
+	/* Return buffer back for to pool */
+	icssg_queue_push(prueth, slice == 0 ?
+			 ICSSG_RSP_PUSH_SLICE0 : ICSSG_RSP_PUSH_SLICE1, addr);
+
+	return 0;
+}
+
+static void icssg_fdb_setup(struct prueth_emac *emac, struct mgmt_cmd *fdb_cmd,
+			    const unsigned char *addr, u8 fid, int cmd)
+{
+	int slice = prueth_emac_slice(emac);
+	u8 mac_fid[ETH_ALEN + 2];
+	u16 fdb_slot;
+
+	ether_addr_copy(mac_fid, addr);
+
+	/* 1-1 VID-FID mapping is already setup */
+	mac_fid[ETH_ALEN] = fid;
+	mac_fid[ETH_ALEN + 1] = 0;
+
+	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
+
+	fdb_cmd->header = ICSSG_FW_MGMT_CMD_HEADER;
+	fdb_cmd->type   = ICSSG_FW_MGMT_FDB_CMD_TYPE;
+	fdb_cmd->seqnum = ++(emac->prueth->icssg_hwcmdseq);
+	fdb_cmd->param  = cmd;
+	fdb_cmd->param |= (slice << 4);
+
+	memcpy(&fdb_cmd->cmd_args[0], addr, 4);
+	memcpy(&fdb_cmd->cmd_args[1], &addr[4], 2);
+	fdb_cmd->cmd_args[2] = fdb_slot;
+
+	netdev_dbg(emac->ndev, "MAC %pM slot %X FID %X\n", addr, fdb_slot, fid);
+}
+
+int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
+		      u8 vid, u8 fid_c2, bool add)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	struct mgmt_cmd fdb_cmd = { 0 };
+	u8 fid = vid;
+	int ret;
+
+	icssg_fdb_setup(emac, &fdb_cmd, addr, fid, add ? ICSS_CMD_ADD_FDB : ICSS_CMD_DEL_FDB);
+
+	fid_c2 |= ICSSG_FDB_ENTRY_VALID;
+	fdb_cmd.cmd_args[1] |= ((fid << 16) | (fid_c2 << 24));
+
+	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
+	if (ret)
+		return ret;
+
+	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
+	if (fdb_cmd_rsp.status == 1)
+		return 0;
+
+	return -EINVAL;
+}
+
+int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
+		     u8 vid)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	struct mgmt_cmd fdb_cmd = { 0 };
+	struct prueth_fdb_slot *slot;
+	u8 fid = vid;
+	int ret, i;
+
+	icssg_fdb_setup(emac, &fdb_cmd, addr, fid, ICSS_CMD_GET_FDB_SLOT);
+
+	fdb_cmd.cmd_args[1] |= fid << 16;
+
+	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
+	if (ret)
+		return ret;
+
+	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
+
+	slot = (struct prueth_fdb_slot __force *)(emac->dram.va + FDB_CMD_BUFFER);
+	for (i = 0; i < 4; i++) {
+		if (ether_addr_equal(addr, slot->mac) && vid == slot->fid)
+			return (slot->fid_c2 & ~ICSSG_FDB_ENTRY_VALID);
+		slot++;
+	}
+
+	return 0;
+}
+
+void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
+		       u8 untag_mask, bool add)
+{
+	struct prueth *prueth = emac->prueth;
+	struct prueth_vlan_tbl *tbl;
+	u8 fid_c1;
+
+	tbl = prueth->vlan_tbl;
+	fid_c1 = tbl[vid].fid_c1;
+
+	/* FID_C1: bit0..2 port membership mask,
+	 * bit3..5 tagging mask for each port
+	 * bit6 Stream VID (not handled currently)
+	 * bit7 MC flood (not handled currently)
+	 */
+	if (add) {
+		fid_c1 |= (port_mask | port_mask << 3);
+		fid_c1 &= ~(untag_mask << 3);
+	} else {
+		fid_c1 &= ~(port_mask | port_mask << 3);
+	}
+
+	tbl[vid].fid_c1 = fid_c1;
+}
+
+u16 icssg_get_pvid(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	u32 pvid;
+
+	if (emac->port_id == PRUETH_PORT_MII0)
+		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
+	else
+		pvid = readl(prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
+
+	pvid = pvid >> 24;
+
+	return pvid;
+}
+
+void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
+{
+	u32 pvid;
+
+	/* only 256 VLANs are supported */
+	pvid = (u32 __force)cpu_to_be32((ETH_P_8021Q << 16) | (vid & 0xff));
+
+	if (port == PRUETH_PORT_MII0)
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT1_DEFAULT_VLAN_OFFSET);
+	else if (port == PRUETH_PORT_MII1)
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET);
+	else
+		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index cf2ea4bd22a2..9d8558bd0f15 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -35,6 +35,8 @@ struct icssg_flow_cfg {
 	(2 * (PRUETH_EMAC_BUF_POOL_SIZE * PRUETH_NUM_BUF_POOLS + \
 	 PRUETH_EMAC_RX_CTX_BUF_SIZE * 2))
 
+#define PRUETH_SWITCH_FDB_MASK ((SIZE_OF_FDB / NUMBER_OF_FDB_BUCKET_ENTRIES) - 1)
+
 struct icssg_rxq_ctx {
 	__le32 start[3];
 	__le32 end;
@@ -202,6 +204,23 @@ struct icssg_setclock_desc {
 #define ICSSG_TS_PUSH_SLICE0	40
 #define ICSSG_TS_PUSH_SLICE1	41
 
+struct mgmt_cmd {
+	u8 param;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
+struct mgmt_cmd_rsp {
+	u32 reserved;
+	u8 status;
+	u8 seqnum;
+	u8 type;
+	u8 header;
+	u32 cmd_args[3];
+} __packed;
+
 /* FDB FID_C2 flag definitions */
 /* Indicates host port membership.*/
 #define ICSSG_FDB_ENTRY_P0_MEMBERSHIP         BIT(0)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 82e38ef5635b..b1c6a034b682 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -223,6 +223,7 @@ struct icssg_firmwares {
  * @emacs_initialized: num of EMACs/ext ports that are up/running
  * @iep0: pointer to IEP0 device
  * @iep1: pointer to IEP1 device
+ * @vlan_tbl: VLAN-FID table pointer
  */
 struct prueth {
 	struct device *dev;
@@ -247,6 +248,7 @@ struct prueth {
 	int emacs_initialized;
 	struct icss_iep *iep0;
 	struct icss_iep *iep1;
+	struct prueth_vlan_tbl *vlan_tbl;
 };
 
 struct emac_tx_ts_response {
@@ -304,6 +306,16 @@ int icssg_queue_pop(struct prueth *prueth, u8 queue);
 void icssg_queue_push(struct prueth *prueth, int queue, u16 addr);
 u32 icssg_queue_level(struct prueth *prueth, int queue);
 
+int icssg_send_fdb_msg(struct prueth_emac *emac, struct mgmt_cmd *cmd,
+		       struct mgmt_cmd_rsp *rsp);
+int icssg_fdb_add_del(struct prueth_emac *emac,  const unsigned char *addr,
+		      u8 vid, u8 fid_c2, bool add);
+int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
+		     u8 vid);
+void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
+		       u8 untag_mask, bool add);
+u16 icssg_get_pvid(struct prueth_emac *emac);
+void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
 
-- 
2.34.1


