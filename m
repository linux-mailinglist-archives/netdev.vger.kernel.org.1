Return-Path: <netdev+bounces-262487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOgUCJAWpWmL2QUAu9opvQ
	(envelope-from <netdev+bounces-262487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:48:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A001D2FFE
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3739F30131C4
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488A29994B;
	Mon,  2 Mar 2026 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4+5qDZ73"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D2430BB6;
	Mon,  2 Mar 2026 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772426849; cv=fail; b=m6jtBz0/bqmvK3XxpYR5LNdwFvGw3LkkOHF1w2h7w7WyLmTQx/PEnvnkoYvJ/rGgS8BUtakgHYfY0TzhF5x+OvdciMYBdSC7sWNLY4mR16AtwXfRQ/mp7U7wg0mNDexmn7zv2s2swlxyjbU40pvhUf/r2HJx0ab1tR9JUhGx/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772426849; c=relaxed/simple;
	bh=OqILv4CcQkoRKQ7f8QQy0Y1oewgf2qYXr3pIgr3uehc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF/qq9o8oDcmCTli9S21AZVw3LW4UwHDYktZU3Tnu26zEwfH+H4SV78TmJl8RM2W6LE/Ae0Xl8gsSmxTXvB2AOsvSyB5RtYU867RFaw92EaSs5hrdBUfxcqEugrc6WBU60lfWZtCluPeDLIos/MKAq8aftrpVxxZGvPEBbXq9NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4+5qDZ73; arc=fail smtp.client-ip=52.101.193.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI6Um7CfybalVSUxS6d5PpN9XBdFeo23+FmQOTFoSp51v2+wVHsmlHa87H915edvoK73ryog/xIf76Lk39gAk8AlCK1j2BcmZwj5HhI19WDoJkZDWcfbnZWPBmg2plgKy9+8oRred/KM4smmqONy7xNFDPEyrJPGVkPYGgHdgvuPwjajNjwPC/R7M/wjMLHygtm0OttWjbVzNw34TV3bks5p9YSw8Xi9sH/xCOGvWcrgsbrncUEO9FnchXbRaHdKZZfrqHtsazNebEAWX+IRpKJpRxU05iMayya3qe+7aR96W6Bj938LfWjkiWfvWTl6yHmAvC/Wd4HRcQsdWtKoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXtt67k0Vd69QtMyDPMX9QhrGMn/KZDn5RtcFJMuvcc=;
 b=SckyIe1va6lVcSAMqCOyVETMqzx+IEfA/GRW+MJyGr05K1utdikTstshXO7+Uws+71EvJ9D7eqqRyQdd+u5H1tUykY2AT0Eu20A8qvhAagfe7tFXWkdFATR3MSde8qUajL3A6/ccWNUgme+7v6G5duhT1x9EWUMCsEXNgWlbRR6et1TOryEPlPQRVVKO6AQG7BW22CJeAjmtbU3iwxJpbNbDXwwYfxfwt0xjESj/GBbpcybJlq6ylmYOHwnbAOR6cMPqX/pYysO/nAq5bwFU5BMU9ClVWNomQry1PkdnObqMgYsY2sP3W5q1m6XC9ZSzMk8tBhVl6pMOm9zuTTQ4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXtt67k0Vd69QtMyDPMX9QhrGMn/KZDn5RtcFJMuvcc=;
 b=4+5qDZ73BAQxxl2X3X+002/OSplhXxcZkc18PfaDIWymYzG16uTak/cyHhrJix3Sx9IMDeCiJC9lYkFO7T2pWTdcguo/hARbXjFZXBZUU5bh3d9bF5xZlu7ZQzq+YqjLDUHXOhD9GHCcBl/ORT/yYXmtEm9fdR7qSdudUiDfiXY=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Mon, 2 Mar
 2026 04:47:24 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::ef) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 04:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 04:47:23 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Mar
 2026 22:47:19 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 2/2] amd-xgbe: add support for P100a platform
Date: Mon, 2 Mar 2026 10:16:34 +0530
Message-ID: <20260302044634.1388661-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302044634.1388661-1-Raju.Rangoju@amd.com>
References: <20260302044634.1388661-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 08472567-ce26-4939-4297-08de7816cbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	BPzGSkTqwYUCHnPnSspsMjV8EQesq9VtdAnrbhDMp1i9OjpgqC91B/q6fcKn6YBnO+HYenYHiixwldtTzgrQxm6In9P0GHCiaLHfyg8GR0Povoi8RntASx8piuGv2dc8W0AC8EqiZ7fMQ9wCET7g7rP2c4xCONbLxzTyEbNvoOrVRfBwQ0liq4A6x8c+1IBrIqWoxdgXKpUEkz0Wvhvo++UzOLB6Z3auXb5jrMdsC2LkoAtXqWSxGqq1qWUEZxpS05s008MIHUfPqUzF8+XlzmxkMoV7L8GtB3mNd8YoLNszjk2WWPs6aXqmNB6c4vWImYy3buoj3KuSAxN51MgWF9eOtHWB/NVyBJDuS4PlrEFRyq/E763/21TDrLEgzCU84+eJrGkmbOtUwO88AMt/i7yjnWhgSzFUhC48YaRjNClR5uEOC6OvydJ94aehFzx2QUfug4LYqepO8LPjKHc0ODwXAERQ77aeIfhjhvu9m6neipRuYQqr7wF7cPVXGIaJ1x7CAVDptBp/eK1RFRlA53gpcjhaltqkIBlRk/8NhpY2X33gn7OiNymUIFZIGEBP0LNUimoVdvNrXGZxBe54UA6Vguip/SC5+81raodGfBut2/GZyxdGXhFCORtYWiKxQs8k3XkSNf+UX/0Pn5qL+L423PsmQo6ID7l+X+LJK5M2TZ9EvwUyEPSWHpQn0KvypB4tCU8LAi1GlZzOzt0TNj/QklKRsDpwSX5aYwTaca/PLRVLihjQUIuAOv+LjvRJMMkHOmlekCPXtT5pwrA133X7VTGZXkNnWQzI3vCiGQ+guiE3Ti50u66jVzcfJ3MgWBRWzNrNQJXnJ9IClPEJdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pNz4J7Qk1zkSDq6NugRzbMqb9YKtglqAOFiZE0ueqNN5Zr17hijfb4jcwFxi8UaCXhIfWvzh+Hi03eLUIhN/3FZyOQIN5QpTc8KmgAp6VaYrSdP3wcgx21EN3MnPDaQL330/mQ8UqVmyj/imXSTS6tk/tCX0XONg/6znV7tOGDeOCh4xMmbenA1//mHAVxryklTqmV2V25ReYgQfkbsdsDwCNFI6X+wYB/omy4/AA9v1+bN11/D/zEen8ACCpBTw9UeeW1CFgxgMmVCaBlpbxQTQV2mxKErtRQd2e12E/ve2O7xeQqQYoByVqRPOjqDh7xxS1TKVRqGRC7HpYjPXJMOTHUBxa9BzHkiig/YNiMWUB0Yf1KeMXIzNb+SiJdF3H7dFgnNEVCyZQL01QzMrDPDzgoW+KjJKgnXbNU67WfpKjkI0Dk+Qt5Nza62LKWrW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 04:47:23.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08472567-ce26-4939-4297-08de7816cbd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262487-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91A001D2FFE
X-Rspamd-Action: no action

Add hardware support for the AMD P100a platform featuring the ethernet
controller PCI device ID 0x1122.

Platform-specific changes include:

1. PCI device ID and register configuration:
   - Add XGBE_P100a_PCI_DEVICE_ID (0x1122) for recognition
   - Configure platform-specific XPCS window registers
   - Disable CDR workaround and RRC for this platform

2. XPCS window offset calculation fix:
   The P100a platform uses a different memory mapping scheme for XPCS
   register access. The offset calculation differs between platforms:

   - Older platforms (YC): offset = base + (addr & mask)
     The address is masked first, then added to the window base.

   - P100a: offset = (base + addr) & mask
     The full address is added to base first, then masked.

   This is critical because using the wrong calculation causes register
   reads/writes to access incorrect addresses, leading to incorrect
   behaviour.

3. 2.5G speed mode handling:
   P100a uses XGMII mode (ss=0x06) for 2.5G instead of GMII mode
   (ss=0x02) used by older platforms. The MAC version check determines
   which mode to use.

4. Port speed bits extended:
   Extend XP_PROP_0_PORT_SPEEDS from 5 bits to 6 bits to support the
   additional 5G speed capability.

5. Rx adaptation disabled:
   Rx adaptation is disabled for P100a (MAC version 0x33) as this
   feature requires further development for this platform.

6. Rate change command for 2.5G:
   Use XGBE_MB_SUBCMD_2_5G_KX subcommand for 2.5G mode on P100a
   instead of XGBE_MB_SUBCMD_NONE used on older platforms.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  4 ++-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 33 +++++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  8 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 22 ++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 +++-
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 711f295eb777..57cd8d2e1ad7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -832,6 +832,8 @@
 #define PCS_V2_YC_WINDOW_SELECT		0x18064
 #define PCS_V3_RN_WINDOW_DEF		0xf8078
 #define PCS_V3_RN_WINDOW_SELECT		0xf807c
+#define PCS_P100a_WINDOW_DEF		0x8060
+#define PCS_P100a_WINDOW_SELECT		0x8080
 
 #define PCS_RN_SMN_BASE_ADDR		0x11e00000
 #define PCS_RN_PORT_ADDR_SIZE		0x100000
@@ -968,7 +970,7 @@
 #define XP_PROP_0_PORT_MODE_INDEX		8
 #define XP_PROP_0_PORT_MODE_WIDTH		4
 #define XP_PROP_0_PORT_SPEEDS_INDEX		22
-#define XP_PROP_0_PORT_SPEEDS_WIDTH		5
+#define XP_PROP_0_PORT_SPEEDS_WIDTH		6
 #define XP_PROP_1_MAX_RX_DMA_INDEX		24
 #define XP_PROP_1_MAX_RX_DMA_WIDTH		5
 #define XP_PROP_1_MAX_RX_QUEUES_INDEX		8
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 1a91ec455bee..f1357619097e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -718,7 +718,7 @@ static void xgbe_disable_ecc_sec(struct xgbe_prv_data *pdata,
 
 static int xgbe_set_speed(struct xgbe_prv_data *pdata, int speed)
 {
-	unsigned int ss;
+	unsigned int ss, ver;
 
 	switch (speed) {
 	case SPEED_10:
@@ -728,7 +728,12 @@ static int xgbe_set_speed(struct xgbe_prv_data *pdata, int speed)
 		ss = XGBE_MAC_SS_1G;
 		break;
 	case SPEED_2500:
-		ss = XGBE_MAC_SS_2_5G_GMII;
+		/* P100a uses XGMII mode for 2.5G, older platforms use GMII */
+		ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
+		if (ver == XGBE_MAC_VER_33)
+			ss = XGBE_MAC_SS_2_5G_XGMII;
+		else
+			ss = XGBE_MAC_SS_2_5G_GMII;
 		break;
 	case SPEED_10000:
 		ss = XGBE_MAC_SS_10G;
@@ -1070,6 +1075,8 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 					  unsigned int *index,
 					  unsigned int *offset)
 {
+	unsigned int ver;
+
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1081,7 +1088,27 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 	 */
 	mmd_address <<= 1;
 	*index = mmd_address & ~pdata->xpcs_window_mask;
-	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+
+	ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
+
+	/* The P100a platform uses a different memory mapping scheme for XPCS
+	 * register access. The offset calculation differs between platforms:
+	 *
+	 * For P100a platforms: The offset is calculated by adding the
+	 * mmd_address to the xpcs_window and then applying the xpcs_window_mask
+	 * For older platforms: The offset is calculated by applying the
+	 * xpcs_window_mask to the mmd_address and then adding it to the
+	 * xpcs_window.
+	 *
+	 * This is critical because using the wrong calculation causes register
+	 * accesses to target the wrong registers, leading to incorrect behavior
+	 */
+	if (ver == XGBE_MAC_VER_33)
+		*offset = (pdata->xpcs_window + mmd_address) &
+			  pdata->xpcs_window_mask;
+	else
+		*offset = pdata->xpcs_window +
+			  (mmd_address & pdata->xpcs_window_mask);
 }
 
 static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index e3e1dca9856a..f54a5040a493 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -168,6 +168,14 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
 		switch (rdev->device) {
+		case XGBE_P100a_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_P100a_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_P100a_WINDOW_SELECT;
+
+			/* P100a devices do not need rrc and cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+			pdata->vdata->enable_rrc = 0;
+			break;
 		case XGBE_RV_PCI_DEVICE_ID:
 			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
 			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index c63ddb12237e..1dbfa9d4360d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2132,7 +2132,11 @@ static bool enable_rx_adap(struct xgbe_prv_data *pdata, enum xgbe_mode mode)
 
 	/* Rx-Adaptation is not supported on older platforms(< 0x30H) */
 	ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
-	if (ver < 0x30)
+	if (ver < XGBE_MAC_VER_30)
+		return false;
+
+	/* Rx adaptation not yet supported on P100a */
+	if (ver == XGBE_MAC_VER_33)
 		return false;
 
 	/* Re-driver models 4223 && 4227 do not support Rx-Adaptation */
@@ -2258,12 +2262,24 @@ static void xgbe_phy_kr_mode(struct xgbe_prv_data *pdata)
 
 static void xgbe_phy_kx_2500_mode(struct xgbe_prv_data *pdata)
 {
+	unsigned int ver;
+
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
 
 	xgbe_phy_set_redrv_mode(pdata);
 
-	/* 2.5G/KX */
-	xgbe_phy_perform_ratechange(pdata, XGBE_MB_CMD_SET_2_5G, XGBE_MB_SUBCMD_NONE);
+	ver = XGMAC_GET_BITS(pdata->hw_feat.version, MAC_VR, SNPSVER);
+
+	/*
+	 * P100a uses XGMII mode for 2.5G which requires the 2.5G_KX subcommand.
+	 * Older platforms use GMII mode.
+	 */
+	if (ver == XGBE_MAC_VER_33)
+		xgbe_phy_perform_ratechange(pdata, XGBE_MB_CMD_SET_2_5G,
+					    XGBE_MB_SUBCMD_2_5G_KX);
+	else
+		xgbe_phy_perform_ratechange(pdata, XGBE_MB_CMD_SET_2_5G,
+					    XGBE_MB_SUBCMD_NONE);
 
 	phy_data->cur_mode = XGBE_MODE_KX_2500;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 32cab96e013c..f1b2954017e6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -262,6 +262,7 @@
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
 #define XGBE_RN_PCI_DEVICE_ID	0x1630
+#define XGBE_P100a_PCI_DEVICE_ID	0x1122
 
  /* Generic low and high masks */
 #define XGBE_GEN_HI_MASK	GENMASK(31, 16)
@@ -577,7 +578,10 @@ enum xgbe_mb_subcmd {
 	XGBE_MB_SUBCMD_10MBITS = 0,
 	XGBE_MB_SUBCMD_100MBITS,
 	XGBE_MB_SUBCMD_1G_SGMII,
-	XGBE_MB_SUBCMD_1G_KX
+	XGBE_MB_SUBCMD_1G_KX,
+
+	/* 2.5GbE Mode subcommands */
+	XGBE_MB_SUBCMD_2_5G_KX = 1
 };
 
 struct xgbe_phy {
-- 
2.34.1


