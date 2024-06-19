Return-Path: <netdev+bounces-104849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E190EAC4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A42814A4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF139149C43;
	Wed, 19 Jun 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RR6tVAfv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39D14372C;
	Wed, 19 Jun 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799488; cv=fail; b=ANfNFo7MQTEVvU9PIiFQcBpgoo70lJRkbjNdc7lsAIvMQKh/n0xbc5tFEDGpC9vVptjTAmvcRtki1Jpopb/zIRYAgaBXskT2wTlPPbYbZ8buiVXJFt9lRihGQuztsg/xUZ+ulL7FF5yVHT7MNTx6v+vD9pUqW03AkyiC1UeY/m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799488; c=relaxed/simple;
	bh=4ck3w7VM+1Kxpcl2D5+3CgPPGLJkcar1wVWrPkbHjF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPeBjAh1OTbPeFfQw9DHD135IStS4spZDUxqbbXIGcYm5OcEJzgRSjdtMrTnlYyRVivZ+MTYET2WADjlSvoy1Ploa/Cb+h8cdCYSErpHlJOTE5KD99W4Ewen4BkW63jJLo5rBOZzz7xqKBMueJOVjVgWbQoHN7GF5/p+5XpR8pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RR6tVAfv; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH4sMffxqIbl9UZQYgb66JF4ZQfX0yorx2GQzq0VBZE5mzS2K4ynGEqxZkY6mXlS01lqokv+686A5cBPmLl/hoNmdv/QldV6lKXbEYrot4X8KS5hrTaHq6dv9/Njpg7S3ofSUSj7aWi9IFtswzfvMPPSefQcNl0jodhMT5haqmpWQFTbyOV3IAgZsno4nK+upphe390Uuqyt/mjw6935EB1Cu9mwcHyk3djw+OWBowu/KEpFXfOHgvrPtsTyt3w7/hXssJB7o+31bvTu1vo4uAWPnusz4XPJaFUEUBnpq0mUlKy4eWFtbY0VX7kIAOtqFluGcBG8sQv4MKVKw6fJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErS8hdpJoxO4q0KydJ7PQ2tO81x/w5HONh4RKs9DBpA=;
 b=Ve5s70Bci4suP0MlbuMi7ef3/Puu/QDvXlDwaX8TksEDSV1BmpPdJ6M94AhygParVrCosDOs+2M+/9nFC/jJfeuCieaiZ5bUIyfEUMba0di6xsYW84gCIy88Ho3QxXolsh7vAQJr4wC8lm+ggEPm+TSmJJ46MSDbyw9dPImrK1MO3RsXwjLV44ZLMkmPvnWB94ia7482w1wgodUtx8s6PJA4yWSXKMaJ2+hWYkv0abWFsGBiLJh9pjwUNfIWCiqmIC0WbfHAv7cf0yQKsNnZxGFWVnvPmgs906b+b1Q5wwPdVtGfO0j2oktehf7f+88DzsUPePhtRhPQi/cyRNtjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErS8hdpJoxO4q0KydJ7PQ2tO81x/w5HONh4RKs9DBpA=;
 b=RR6tVAfvYfzyInzHwEEFTht7Lyi3AwdDMVnXu0lkiLzlpOEh/YOjbVcTppB43fSY0eZbNwO1Z7yX8k8qSlxCZu2W6BCEjR6zliyqjn7fT7Rw5EyzkST+7YvbGaIx28iJk9s7tgWKqwB4YCw9GmkRdjfWL8sXGpAdd07k+YkWJT3fC+U3KxI6FrJRkC6GO1k1xEakktq1d9IxEtJ3XB0//bghX2WG5W+0T5KqiWsH+3m23teZJqvqDCS6lkrVCsvPpCftjBfx/BXYhuBxT/4JwfCjYX3DKEruEmutwDPE/sMrOxEpSAUiwaJfQmGDKE0WHcMTkE+9gsNvmpVKBG3UEA==
Received: from SJ0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:a03:2c2::15)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Wed, 19 Jun
 2024 12:18:03 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::d5) by SJ0PR13CA0040.outlook.office365.com
 (2603:10b6:a03:2c2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:17:52 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:17:46 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v6 1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Wed, 19 Jun 2024 15:17:19 +0300
Message-ID: <20240619121727.3643161-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c88b5c-8a69-4623-955f-08dc9059de6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|7416011|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HguY/kvWo59CxhGBIC4eLRPcvULkyJgc/fg5zEjpO+bwM6LdMqkHWG3661LG?=
 =?us-ascii?Q?hZyyRZKamFx6nlvB+nUutgcOTrtzD3p5Gx82qWxFq+xImvqUwQ6nHTG8nbTd?=
 =?us-ascii?Q?KdMJkomnj52iHijAvY9LTHwVJSboyjd6NKtExCBo0OCaqS0IgZaSmQwJ54QH?=
 =?us-ascii?Q?4DvTmVoUrWVTionjIQmnaG89cOd8jqKV13lsbiOK3FXSA4zZaVkJYR/x5+TY?=
 =?us-ascii?Q?0DP1IKPWEAntIliY5cpxM2NUC4Kx/GUP7TOy6HH2uHy0MWpgBScN0tG3N2Ct?=
 =?us-ascii?Q?e+GPTO+GRURPOqiiDDePehVgFyZGaux16WNSGvd02wQ27f7FM1ZS0oLCLpcY?=
 =?us-ascii?Q?CdDnvuOm0rBoTY0sSFtU1xFEUMwngOsrhXmuONJIDwG7DhAN5jHKJHwhqOJ6?=
 =?us-ascii?Q?TY79jbk8TmViPwk8Adb/wfhh/xogjmWRCiCACQeKZYW5MxHO96BKsdvASCfb?=
 =?us-ascii?Q?r6qRynfHSbCEXddQZDYNOSFl8j4/7cb8WiopJsUnuBceuN618D/uojz4X5i7?=
 =?us-ascii?Q?BQXkejJ72OmKGIy/KrPkOgmo9YHulTuhb9IV72o2hBqboBRyp8GrO5YHwGCb?=
 =?us-ascii?Q?aw1fFNf4GdFlwQMiNcA5UfL59ue3WuCX0yOTgXrf+Ps9bQOL7YU3S2zx5EvZ?=
 =?us-ascii?Q?Xo6V49wMGg45bP8lm06h2SQ7FQ55OkYT2zhweG/Igqyw8E2qWYSw8MCsjbrY?=
 =?us-ascii?Q?nF7CXBjoeVQnFzNwi3m1K5tsIsHc8P4rETS1SmCHXAytLALPTiJEiSCUCRjI?=
 =?us-ascii?Q?6FIGYwblvc5RJhTTVH0lrAljyo0cjwPgOrx84DeJcpY85OLnmI0jFO2v1bYQ?=
 =?us-ascii?Q?pSTFeUGr8Jas0L1gxrjqUoDENok4d4Fln/ZiTQ21kKTub2QUMD2AaUErASH5?=
 =?us-ascii?Q?Z4c2RvGGYogDuC2S5Hc64gzk/CSoeCfheC8xnfydffJIv8uIE6GWPlRYUwWy?=
 =?us-ascii?Q?H1Y1VYick9k3P3z320sMIiqao2Nzg7T42gNElljgj8/7E3PMqfZljgxNB7h0?=
 =?us-ascii?Q?YijRjz4ILSaRScFcdL5D5w3L4Am7lhbVdvkrQG1v3nkJiqBDZJTVRc049IIz?=
 =?us-ascii?Q?IwXESpc8MNHqnBtCeG4PPG8NKCvB3xI5xmzQkNIJ+9jkGjKK+60zh9Itu27i?=
 =?us-ascii?Q?hdaG4I8QAGxo97Uu7iSx96tjuUn42gk3MDGceXRdJF8I8SSi/ky18X0BWJU5?=
 =?us-ascii?Q?1rJwLGwtAsyaGNwKsp7c3Yjn7hwyXGyx8w34LOf34jjtUMbZrzH79yyLxBnJ?=
 =?us-ascii?Q?pAxt4VJrS3shMzV/3CskDfRPhmG47nFTMxQILUpcaEEIYwxCD5EquPew5Fvk?=
 =?us-ascii?Q?fVOJ0JlQzJhyGd0vGTJq3AjnY13i4MHo4ypzktbAgRj2NmqTUsARl95Kjcgj?=
 =?us-ascii?Q?0Hg4DzHXzZgPCEbuvDq27ULWZcM7hpXB1QJFdeS/SqJg0DvmrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(7416011)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:03.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c88b5c-8a69-4623-955f-08dc9059de6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937

From: Ido Schimmel <idosch@nvidia.com>

Ethtool can already retrieve information from a transceiver module
EEPROM by invoking the ethtool_ops::get_module_eeprom_by_page operation.
Add a corresponding operation that allows ethtool to write to a
transceiver module EEPROM.

The new write operation is purely an in-kernel API and is not exposed to
user space.

The purpose of this operation is not to enable arbitrary read / write
access, but to allow the kernel to write to specific addresses as part
of transceiver module firmware flashing. In the future, more
functionality can be implemented on top of these read / write
operations.

Adjust the comments of the 'ethtool_module_eeprom' structure as it is
no longer used only for read access.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/linux/ethtool.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..fa1a5d0e3213 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -504,17 +504,16 @@ struct ethtool_ts_stats {
 #define ETH_MODULE_MAX_I2C_ADDRESS	0x7f
 
 /**
- * struct ethtool_module_eeprom - EEPROM dump from specified page
- * @offset: Offset within the specified EEPROM page to begin read, in bytes.
- * @length: Number of bytes to read.
- * @page: Page number to read from.
- * @bank: Page bank number to read from, if applicable by EEPROM spec.
+ * struct ethtool_module_eeprom - plug-in module EEPROM read / write parameters
+ * @offset: When @offset is 0-127, it is used as an address to the Lower Memory
+ *	(@page must be 0). Otherwise, it is used as an address to the
+ *	Upper Memory.
+ * @length: Number of bytes to read / write.
+ * @page: Page number.
+ * @bank: Bank number, if supported by EEPROM spec.
  * @i2c_address: I2C address of a page. Value less than 0x7f expected. Most
  *	EEPROMs use 0x50 or 0x51.
  * @data: Pointer to buffer with EEPROM data of @length size.
- *
- * This can be used to manage pages during EEPROM dump in ethtool and pass
- * required information to the driver.
  */
 struct ethtool_module_eeprom {
 	u32	offset;
@@ -822,6 +821,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM,
+ *	from kernel space only. Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -956,6 +957,9 @@ struct ethtool_ops {
 	int	(*get_module_eeprom_by_page)(struct net_device *dev,
 					     const struct ethtool_module_eeprom *page,
 					     struct netlink_ext_ack *extack);
+	int	(*set_module_eeprom_by_page)(struct net_device *dev,
+					     const struct ethtool_module_eeprom *page,
+					     struct netlink_ext_ack *extack);
 	void	(*get_eth_phy_stats)(struct net_device *dev,
 				     struct ethtool_eth_phy_stats *phy_stats);
 	void	(*get_eth_mac_stats)(struct net_device *dev,
-- 
2.45.0


