Return-Path: <netdev+bounces-106219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136399155DB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971511F23806
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857419FA6F;
	Mon, 24 Jun 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZAYw0Vok"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7019E822;
	Mon, 24 Jun 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251567; cv=fail; b=Jxvo2zYM8EeWoNAXUpPiPrpxpbAvZDTVG6Jo5jmCIAPUSFSp/uXJ2vvRBc8w2GsLRE1Ru+booMYGCbJpwJmMit4ZdfneA2FOCepc4bV/NqovdDxqE4DQrloA3Vix/Fa+N5vH5EkqMUuYqXLSL5aBPL/+W09NJOz1wCyk8GZyCeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251567; c=relaxed/simple;
	bh=4ck3w7VM+1Kxpcl2D5+3CgPPGLJkcar1wVWrPkbHjF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z13hNOAGRidMu0l5XEbEzfWAIixIreqY/UEt7z5PfIvf8dUiNBWblxGWlxhjS3aRC3nLh/1YAO5Rt6oGSqOGmoNw4Ylc4VzYIT8jB8UuHqZDxWIeZPWbJCGjAnR3YE1k2uy6qoPoHQ1Die7WNk8ZBuCmBKlTHPWmGx4sgDkrHNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZAYw0Vok; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g46TyivW0A4LBgtVS3X9rxSuiMUvL3DEbgjOizqu0AXECzuKXjiPd6zooo/6tHyfmbwXMyi8MNRQSDo9gGksiGfAWoFbbfYNrUlcAuyibroGwHexnGAzAKiSHjW0JY3y1/zFUhHJtR/mkm1EdE4pIrY56lWBZ/105Hdad3aujBZ0ga+baNOy4aVx2NX98xCPqnw7k1A5qcU2skBuZxxVoMfE/pBitoapLO5p9Z1VRq2zziiox80ZsbUldN6Y6utFFi1pj/LAcW3zuSFYBtAJl5taXaVUY2XQ3Hw3SZN8soprwX2jWzBMAntJiNJgVnCHLyMSA0hD+Aj6yFklCKr7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErS8hdpJoxO4q0KydJ7PQ2tO81x/w5HONh4RKs9DBpA=;
 b=PoUUgcjmer0XZEKf9aaBCiibVqI6JYoStIUohW7oT7T0T9ZmAzbbdhXVJIKqLdz2UHAJMprsp7pyrBz/TMwZaqfEyKqPNQZZfirlyIvubK+LlZ2Thi2GHhEreLA71I3iOFVw4OsZR7I4uP2KFTZnTvO9RDO4sT6Nm29yCZbir3qT8i27FrplymPGn9Tj2Kjw5T7rUJAawpCyFwedmFOKk8f4fB7RLBR+Dzs9PuNkMD0j4WIPL6wH5BE25+pvzM9L3sEEWzNMsr1H56FMgR9+QGr0nB1vL0oYIZLXfvrJE6J3F8jMYkpWATo61wnJpY/2Ghr27exBkVYK8sIL3fGSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErS8hdpJoxO4q0KydJ7PQ2tO81x/w5HONh4RKs9DBpA=;
 b=ZAYw0VokGoIJlrk7nu0+eK3QLxdk5AoytI42ZOsCXlGIuVvxEb0eqq2yTs6t/wqUt4O8s+b/ybsxaT3oBp4Go1P/ICXOlQM0KdOuA5BtIFq0Zj97QX5tCaO5ua1fwUXZ3K1eKMD423uUTDj7LdREzabHSMrRnas7IorkpVe7Eewwlz5gqdXOIXdbRjHLx/Ogj3RjPuGrcdpW1etL7GQ4/QOUHoKok9QYUDk6MpdJikngla6mXzeBI2pzpjii9znh34V85ixi2gSMGfAV84P2RK7GZqBMpC/SFDJ3CM0LWdhXjllMpLzgZD4YoX0pGfA/Ex/b8HtM3pAHU/nYV026Sw==
Received: from BYAPR11CA0084.namprd11.prod.outlook.com (2603:10b6:a03:f4::25)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 17:52:42 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1d) by BYAPR11CA0084.outlook.office365.com
 (2603:10b6:a03:f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:52:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:27 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:21 -0700
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
Subject: [PATCH net-next v7 1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Mon, 24 Jun 2024 20:51:51 +0300
Message-ID: <20240624175201.130522-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c629c5-9936-44e9-0038-08dc9476723a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|82310400023|376011|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?foO/kHciKIF65/nk1Ppv8Pv+fTbxtOH8zT/4Co6ucUCQpdmVPMTVCCxRNsHo?=
 =?us-ascii?Q?/0qyoyP6AuCfOjofIuGnvPGLJKXmORPTFR5koR7zq8kBaNl46NYywCI61t9r?=
 =?us-ascii?Q?mSzNx27YbJshRQMCxIFEG4NIoaSd9glfFhtmM6U7ZI11+QCOvNKmMoEEiHH5?=
 =?us-ascii?Q?q7AvJlLBgvSXQ4xpfYlxDSQl6u+MfbOq9lMJq41m/ZjP46mn4UaQLQjpCDvR?=
 =?us-ascii?Q?yqlV/izct4sav0hmJeRtZ6mCdZhGd8sNMXXNgKOV3DgDR2EvoWU4pPkRIidV?=
 =?us-ascii?Q?kchy/ymwPDFyAB+vG3J6/GmkW7LiB6dwDJiScr1CxJ341mJ7389f165IAt17?=
 =?us-ascii?Q?u9p9R42EJwUWFX2S5yLsIP3fzj09OdRS6CyiKv8YTVTRooP4nrQt75TmbG2A?=
 =?us-ascii?Q?PlHf+nLs0BeSlPv9gUohmloMbyED/s1XFO5AxiTRl5UTKJry4LDopOhmJdZv?=
 =?us-ascii?Q?wsQ8uzVeF55edaJHhcwW6eDRlEBUHPo70Y1IEmtcsD+9Gv6jr49hpdNlSmuF?=
 =?us-ascii?Q?6OtIuXe/Jofj53kF03gcWgXQ9eMB2n7tNkaL3aJoO2BMyHXW7QlZWGW72BcJ?=
 =?us-ascii?Q?DgZq7L+jLnobrdlNiEwGkZFiaIkQ1eyBz+VxwNiAUEv4fJNC7ILJmwgXrbhk?=
 =?us-ascii?Q?1xJNokoSE727kY+1kLJDUSkDlG4WjrNYnVgY/kNv3c0VvOralJMRBGsDIXLc?=
 =?us-ascii?Q?ISjEjPU2h59JEGsEeRQHq9YedJzRksNEyg04A+WnvDTQi70/x34ZswT3zwd6?=
 =?us-ascii?Q?+C+M5kxqXC4dmsr3/7eq5KYxkSTP8B3r2ycZz/waSYEx6e5tUBfT1qvNsSrY?=
 =?us-ascii?Q?UlL9Uai/0RiSMdS1e1405P+uDmg9cIUhaCAskAILFpSIWoWjOCfVuWr86XCH?=
 =?us-ascii?Q?PoB/ZoCyvcNWEfmYqG/5rXo/MZaC8L/9SzvTIrFNmzTdhg3K0FrhnFTfhS6h?=
 =?us-ascii?Q?bNU/Dax2EorX8W9WB3PCO18cOi7+7ppFNIs1VIh05zne+gNrikqBjVlJY+Gh?=
 =?us-ascii?Q?wyIWQ1Uncj8Km7iD/ZaM/L8FCIAmz8y03a74L0PJgR6oD782i/YvTYPc/cmF?=
 =?us-ascii?Q?CuUK1gfkecVGO5X6gJk21zvMIomxC+NQgvx4iONcz+ZUPR3UMpBPGHKuaqy0?=
 =?us-ascii?Q?Wfxa7iCu3zDE6o+ipN2tmZ0IrY2vpjSwYbdWfgrkg/g8YIze5bTVIzOyC8t9?=
 =?us-ascii?Q?iePXOeQqECfTzRW0OUdmTRyfA8LpV+fUyXlpWhcLWVKCfdW0kQRCwVFYxvs+?=
 =?us-ascii?Q?M37gy/CXc0OghRwUCwSGVbzMCnLKF/IQ1hMvYduhlQPHcmL4BfkKwsxfuwyd?=
 =?us-ascii?Q?vmkZPrA73a3gVNvf6B7iSYYwdWR4dTZTDtqDpFUFa6FWmo8r/qTvMXLmSnRH?=
 =?us-ascii?Q?RoiCW7VuQcI/vQgS1ijct49BqvibvyNnPnE+Myn5t9N9QAA+gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(82310400023)(376011)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:52:42.2910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c629c5-9936-44e9-0038-08dc9476723a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

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


