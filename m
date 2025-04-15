Return-Path: <netdev+bounces-183045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D31A8ABEA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA803BF490
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BAD2D8DDF;
	Tue, 15 Apr 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QDjzpmI4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD92D8DB7;
	Tue, 15 Apr 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758825; cv=fail; b=FFIbRhXqTfNQJelN+DtWUXaeWSfOJjyM9A5Oj3MtBB56HCts0rIvixKEmgZUDOSvyHCUuUDRGJH9yN6cRUncvzPoRfDOnuGK0XitYfWJzHXn/GcyIXSTyhXegnlj/6RBSLuIfndXovT9BKoHJr+X3M/+6O5GAjn58q+iOJL/h6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758825; c=relaxed/simple;
	bh=TYZgse2Ta/6NRXzM3GGor4kAaSiKEhQKiwIMShq9dG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdcoMzBqnVqMLpMz0LdTrn+5k8vEU+r/NFGRBmL1fHEnqeEjJ2ostErM16UqvEeQcwKdSp+WBC9OOWXKLtwcRTWT2/iiPFUFaNNpUDKkBmt/7tEqkPJ/JpxJ5p829xrfL/Hi3TBON+iIVdv1vrKKMrcQlHRP1WHt/m8u+vF4Dkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QDjzpmI4; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq8AO1qr2MUEy3+6c2I0CCrUjfmGqPQaXESdLLaUw6e3M3cwlZqShjlwBhqb3Nj4EqFCyk3FAt3MayxZmmBxBN0aE1lZb1RevqcvEgCS35w053aFZB/C683YGgsU9/3pEBs5xWaFRrCHNEYpVBz/KD8+wsgJmPJ6KaQJ9NtfVyX5nnNnfDPqeY8473fbNUG4RKjDZVkRfmXAUCz2Bw2jmeaNGVJ0UhZRW3tavuQUg1uPY+Jpe5onay4xX9GCbv+cLN3pyOBmUwb2wV7ZJpzB1g5MuDecuhfXpM6gzBRCEu0nLZ1qORQ+JhWOtJmAjdXcKov42fgxa7iJS65t+BBRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMZPXy5wmXUI6oq9sehRK3Gf+3qqkYLk4Sx+tWbEsn0=;
 b=oJToK0Keth6AB+/MvOv7ouphkVV1GM/jLg3VAWF4VJowG3F/3esv+fGg+auiTESD4AvV0v3ihQmv4QtXod8eGHb9//DgM6xERp7NDzkqWmZdbblCK8Zct98dta5Bu5oUaVzY+cj8VKFl0K4UYg2EFMFu339Svh7tOQgcsViRZo1PVWeXGem70niElpvGmFmxDINJFMFEZEd9FoXD+OQjVH6HuiR1inmz8laUXFbR5P2DH7rey1pm0LC4dwho7CIAoE00U1xchsnGvy6JN17JBQm8Y/jWdWJteqZAn+w8x4PeaGwLdADiAvmBK0hL0YHBI1iBJBY638RtMWX9Wi5v1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMZPXy5wmXUI6oq9sehRK3Gf+3qqkYLk4Sx+tWbEsn0=;
 b=QDjzpmI4oSZGRLfdJPWVgFKpHweFrSjdhqZBTrjdD9bb9LG5uurqqHABQmip9b/26/IwHbxcqwC8oezUm4R7L9MlN2jVyJB5N1xqMOAonjx3URNAZY14SIOSNIHc57W1mdD0cWrb+xAme/auy+U3SDG7lmWYLcQJSl4Z58Pc1os=
Received: from SN6PR04CA0082.namprd04.prod.outlook.com (2603:10b6:805:f2::23)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Tue, 15 Apr
 2025 23:13:38 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::b) by SN6PR04CA0082.outlook.office365.com
 (2603:10b6:805:f2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.30 via Frontend Transport; Tue,
 15 Apr 2025 23:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:13:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:13:37 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 2/3] ionic: support ethtool get_module_eeprom_by_page
Date: Tue, 15 Apr 2025 16:13:15 -0700
Message-ID: <20250415231317.40616-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415231317.40616-1-shannon.nelson@amd.com>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d18666-aa96-4340-9fcb-08dd7c73278c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EC2T9k4/tmOFkQc9QZw/RzGx+xPEVGX4wE06onXHdvkoWqZZXiaMUKoMbXqc?=
 =?us-ascii?Q?ZjD9DDlbMpArTMbM45FPR1YAZMFXdV9plnaTp3wDJ6g7fVdqHPKV3knJpwET?=
 =?us-ascii?Q?+FzzBI4TrudfUhT4WXoze5AqmL8Y3uR8prXBSKU0JO0fvieE7P3F8oZlg+YK?=
 =?us-ascii?Q?boPq2v4ab4l8jeWXT8AocWY0VAuPCksFDIBJDprFAL5tqhmgioNLuziY0/T9?=
 =?us-ascii?Q?trg3wUetdh26SAz0kknzVgw2NNWwjDznpGNG8aB+3Q3XPKcEuM3xGZgKiblM?=
 =?us-ascii?Q?Q3MfjFqeB3NxG+EkHbVcPazaC29nN94xN1+49DR+0T3s4OrtfQX2zA9G+cVW?=
 =?us-ascii?Q?+Q+wpscXIVUulA0H47mMqH3rakp4VfyDwTUp5kn0d3I5Mo2G91wrre0KaNS1?=
 =?us-ascii?Q?v6psRo1MIXHNsQgtoFotWrKbPpnEmVUpO126S/12kv+BSDn8XGAvxE882x6X?=
 =?us-ascii?Q?XaqaR0uYjGA1vi1MtYWnUAJKscTqya0ctvLERMWxGb5l9cSzngQGzJkehzuv?=
 =?us-ascii?Q?1iGubZhoA7UrrSSPcqPYRbB4ds9DnyMTW2WsBFo1flXdi90riEtWWtcgfK8W?=
 =?us-ascii?Q?ikGXYAbTuDTlFMOfhQjth3L21iArqfMkrial3bshjnITvcEpTsdal2PjFP8t?=
 =?us-ascii?Q?IQgETTkJ3nPN53MZfvohSuAfzeICZXqd/TmJ5fwYtFZ0u/JbzeRKgOhZ2rv6?=
 =?us-ascii?Q?4dzB+zY7vmbANacBba5nqEDNBNibihnlHn7leoc+CjdJyBXHcL1Q9NO2kVOD?=
 =?us-ascii?Q?KIXi8KOjIcpAy4boLpu+aYoNEWTFiYxq3f5rRkzK9MQppycspBITj0K1lok6?=
 =?us-ascii?Q?AX2AcWcZV+RsR9G4qF25dZ4CGsEctmxZsOpSItAv4md43reHnNlRVn/DpBgX?=
 =?us-ascii?Q?cEJNEO9RPbIgdlYvHB0u88ocGORXIMTclAbnlbhitmgUMIaJJPmZhL3jfTMg?=
 =?us-ascii?Q?Uqp8FRakqmSIIqu6LttBLV+it+WMeECFzydapl4ceo8MZDrmxuv9kLhIqkj0?=
 =?us-ascii?Q?Skgdv+P27lMltP/Z6ibUpfXnMNnYnyvOpZ0ALzy5zXkQO5SykBXoCOf1QfwG?=
 =?us-ascii?Q?WwTpYENp6ePpqd1EyQoNnVxEXKCodOv8rGLtbec5hBydmeQuqbU0GxqO85zT?=
 =?us-ascii?Q?0pxHwBMqZpcvKMuySaiq8MW0oCPqPWeN1ojZYiGLYGxfZiTjnoV9l4afpncI?=
 =?us-ascii?Q?vEBPcHTVIyA5KStEXM/pscHJBbvgwtcTrhX1YD1fUKsAaDhYspLXX4l1qwEg?=
 =?us-ascii?Q?b9KoXCVJ6OrcSoH8UjECySlo7dFaBSuS4QZi0yce3IpPXBcQ1VXSwlSVG0x1?=
 =?us-ascii?Q?zzHw0d9inQX2rxqk35Dg9bhTAPtVBkGv9Tdz0GPYkj3FuEWFXmTJC6SXocy5?=
 =?us-ascii?Q?lW1MHkq4GFRevcqnpyl7k4TFV69uGm6lw8sa5hsta30MlRjVHQbHREPQtKkk?=
 =?us-ascii?Q?3CHWW1ccy8jSIJ2GgQU+Qpgg/LR4vrQA+zUutVb2k0HZQLHwiVmdattASYmv?=
 =?us-ascii?Q?xPXHyoWL0uoFR+m9bG5qsZBGnr3F66dNtu7h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:13:38.2464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d18666-aa96-4340-9fcb-08dd7c73278c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

Add support for the newer get_module_eeprom_by_page interface.
Only the upper half of the 256 byte page is available for
reading, and the firmware puts the two sections into the
extended sprom buffer, so a union is used over the extended
sprom buffer to make clear which page is to be accessed.

With get_module_eeprom_by_page implemented there is no need
for the older get_module_info or git_module_eeprom interfaces,
so remove them.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 96 ++++++-------------
 .../net/ethernet/pensando/ionic/ionic_if.h    | 12 ++-
 2 files changed, 37 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 66f172e28f8b..0d2ef808237b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -948,44 +948,6 @@ static int ionic_get_tunable(struct net_device *netdev,
 	return 0;
 }
 
-static int ionic_get_module_info(struct net_device *netdev,
-				 struct ethtool_modinfo *modinfo)
-
-{
-	struct ionic_lif *lif = netdev_priv(netdev);
-	struct ionic_dev *idev = &lif->ionic->idev;
-	struct ionic_xcvr_status *xcvr;
-	struct sfp_eeprom_base *sfp;
-
-	xcvr = &idev->port_info->status.xcvr;
-	sfp = (struct sfp_eeprom_base *) xcvr->sprom;
-
-	/* report the module data type and length */
-	switch (sfp->phys_id) {
-	case SFF8024_ID_SFP:
-		modinfo->type = ETH_MODULE_SFF_8079;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
-		break;
-	case SFF8024_ID_QSFP_8436_8636:
-	case SFF8024_ID_QSFP28_8636:
-		modinfo->type = ETH_MODULE_SFF_8436;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
-		break;
-	case SFF8024_ID_QSFP_PLUS_CMIS:
-		modinfo->type = ETH_MODULE_SFF_8472;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
-		break;
-	default:
-		netdev_info(netdev, "unknown xcvr type 0x%02x\n",
-			    xcvr->sprom[0]);
-		modinfo->type = 0;
-		modinfo->eeprom_len = ETH_MODULE_SFF_8079_LEN;
-		break;
-	}
-
-	return 0;
-}
-
 static int ionic_do_module_copy(u8 *dst, u8 *src, u32 len)
 {
 	char tbuf[sizeof_field(struct ionic_xcvr_status, sprom)];
@@ -1010,46 +972,43 @@ static int ionic_do_module_copy(u8 *dst, u8 *src, u32 len)
 	return 0;
 }
 
-static int ionic_get_module_eeprom(struct net_device *netdev,
-				   struct ethtool_eeprom *ee,
-				   u8 *data)
+static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
+					   const struct ethtool_module_eeprom *page_data,
+					   struct netlink_ext_ack *extack)
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 	struct ionic_dev *idev = &lif->ionic->idev;
-	u32 start = ee->offset;
 	u32 err = -EINVAL;
-	u32 size = 0;
 	u8 *src;
 
-	if (start < ETH_MODULE_SFF_8079_LEN) {
-		if (start + ee->len > ETH_MODULE_SFF_8079_LEN)
-			size = ETH_MODULE_SFF_8079_LEN - start;
-		else
-			size = ee->len;
-
-		src = &idev->port_info->status.xcvr.sprom[start];
-		err = ionic_do_module_copy(data, src, size);
-		if (err)
-			return err;
+	if (!page_data->length)
+		return -EINVAL;
 
-		data += size;
-		start += size;
+	if (page_data->bank != 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Only bank 0 is supported");
+		return -EINVAL;
 	}
 
-	if (start >= ETH_MODULE_SFF_8079_LEN &&
-	    start < ETH_MODULE_SFF_8472_LEN) {
-		size = ee->len - size;
-		if (start + size > ETH_MODULE_SFF_8472_LEN)
-			size = ETH_MODULE_SFF_8472_LEN - start;
-
-		start -= ETH_MODULE_SFF_8079_LEN;
-		src = &idev->port_info->sprom_epage[start];
-		err = ionic_do_module_copy(data, src, size);
-		if (err)
-			return err;
+	switch (page_data->page) {
+	case 0:
+		src = &idev->port_info->status.xcvr.sprom[page_data->offset];
+		break;
+	case 1:
+		src = &idev->port_info->sprom_page1[page_data->offset - 128];
+		break;
+	case 2:
+		src = &idev->port_info->sprom_page2[page_data->offset - 128];
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	return err;
+	memset(page_data->data, 0, page_data->length);
+	err = ionic_do_module_copy(page_data->data, src, page_data->length);
+	if (err)
+		return err;
+
+	return page_data->length;
 }
 
 static int ionic_get_ts_info(struct net_device *netdev,
@@ -1197,8 +1156,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.set_rxfh		= ionic_set_rxfh,
 	.get_tunable		= ionic_get_tunable,
 	.set_tunable		= ionic_set_tunable,
-	.get_module_info	= ionic_get_module_info,
-	.get_module_eeprom	= ionic_get_module_eeprom,
+	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
 	.get_fecparam		= ionic_get_fecparam,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 4943ebb27ab3..23218208b711 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2839,7 +2839,9 @@ union ionic_port_identity {
  * @status:          Port status data
  * @stats:           Port statistics data
  * @mgmt_stats:      Port management statistics data
- * @sprom_epage:     Extended Transceiver sprom, high page 1 and 2
+ * @sprom_epage:     Extended Transceiver sprom
+ * @sprom_page1:     Extended Transceiver sprom, page 1
+ * @sprom_page2:     Extended Transceiver sprom, page 2
  * @rsvd:            reserved byte(s)
  * @pb_stats:        uplink pb drop stats
  */
@@ -2850,7 +2852,13 @@ struct ionic_port_info {
 		struct ionic_port_stats      stats;
 		struct ionic_mgmt_port_stats mgmt_stats;
 	};
-	u8     sprom_epage[256];
+	union {
+		u8     sprom_epage[256];
+		struct {
+			u8 sprom_page1[128];
+			u8 sprom_page2[128];
+		};
+	};
 	u8     rsvd[504];
 
 	/* pb_stats must start at 2k offset */
-- 
2.17.1


