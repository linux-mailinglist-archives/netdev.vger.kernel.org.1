Return-Path: <netdev+bounces-107313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553591A8B7
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168EB1F273DF
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718219753F;
	Thu, 27 Jun 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SBosy8yu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7479196D9D;
	Thu, 27 Jun 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497390; cv=fail; b=c2b5uznQbC+jYvbuwpyCaS31ib3XzMGvMWWEMx46j6o+88MJKJIU7N2hDhzFWhcHQE4AsM245aSmuJyNBDZPTuvFSDYmw0UHdi/lqjUMMfSkP7hzsIxXKjQ4/AeeR8i7K2OrZCtdOiHgjU1yUwgs5Bz5c3MXjHKSSgEy9Gmswz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497390; c=relaxed/simple;
	bh=xq2IlELI39WkbT4ZlceNLx0o79YafrNxSgO2OHvEV5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fH5TrVfu1ADRHeEOXmEGtYj0UxioXWNSNuP/Y4nOvkFZ0CDqzqbuUyZ6tAPKMGFiEP+iu0FWPbH1iF6fy9Yd0v7vhqwk4xR3D8fnt/MxbjkrPQvI9G1pFgfyWF646hv/pXovphdZKl2MI+Yh8XhAIGq0gJndPW5vzguVMiEu4To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SBosy8yu; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKZmtj7Fw+b61CCJtPUKXL388A2o19goXW7g5gCqlyhhWt2/74fkZXV2z6BI1dzmsWiLf8s/BqyPUsugKsHj0ffpOuCXFJI72mzOwgrxIocTefTT1XBxg2KJlCp4sDl4jaHz2hKe8Gg7HG1iR4+S7zcz1QTlJy/uruc17CFE0j8kPI5NhpzrDmHDOw6LD5vK+pHFm7c7/yYcYmIMm3Xja+9KWsPG/tA9ay8BB5N7X7jwFv8zED39gyUFx1mNRfXUXZSwzatxn3MR+DgZW2zO6GTRw2PLpDxZVP2f1Nf4vl4nJ8wPJLk4BmjXbQHSjICSkr+gXV8+gXNVwXEJUZmOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEbNdoS07WybWIYLeIO+mt7P5wkAS4qQiIrfelFW6R0=;
 b=PWyUn789qcrJ40lQBY7lNAZ9H4/lDg9wkRR4JPlA3WKXXSjcsnEpUkzCW5TX9ZFf+yW8kTfVVP1bu0fROiSp8W66FFbbXnkL7RPBwieGPx0UAb5e/O+S4lkP+h+D9mRzpS2WqrO3kAUrZHKTA4P/V6V7eGxpDAuoX+LjTPbihSaQSQn1xz30BYFjdDo6QnitG7mmqYfa3t1OZ4Qi8WvNKaiWqZZ+Zpc3jGD9r9ta39RhPDsk2khnRpTuEGq89Hct+TDxuNa5UZu0K7gxkrDZY/h5LxloT0UnVe5JiJMLv5GxplhmPj4ro0nvM1Fr3DAeLTGDnXXUsvTEhUx/FQwIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEbNdoS07WybWIYLeIO+mt7P5wkAS4qQiIrfelFW6R0=;
 b=SBosy8yuxsGppqSB8sJERLEzB0CpqLjWJzVsSXQmBopiY11uvyVf1EqIXJJGoYWkD/hx9iAWDYMV3ZflTt9uZM0Sv5ZBDGOWWBSNRvs05TuQN5JxQ7vv04A2cOoon6THTaSmIW4B+iSN1ZhvPx7c5awQ1JGTCg3yl1Ix47sePTtjFrpH4VQ2i137zeJucRqD66yot+O+AImJ6HDoMCW6sIN0Fok33lk8oIbF064EYiCmqegWQJnIx4k+psxjFxnUNyzN6bQpPBQrRu5kgbQZwahiuk7wdqM20Xamea7GpxWSS0sKorLPqH2VgbGyrqShi3yeKyyjTEXHIFTc9ubWIw==
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:09:44 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::60) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:09:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:09:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:26 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:20 -0700
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
Subject: [PATCH net-next v8 1/9] ethtool: Add ethtool operation to write to a transceiver module EEPROM
Date: Thu, 27 Jun 2024 17:08:48 +0300
Message-ID: <20240627140857.1398100-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da95a3f-21ac-48bd-b390-08dc96b2c8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vJZDVB+sxojWlD6h13YBKMnq3/4KMCk9jlnOn1mSYPHzY4XkrdlyP6SoOEs?=
 =?us-ascii?Q?WDbZ5dFLofd02mqd00tz4BYELoRXR/nigwPzw7LSKaKsYAn6KX51Bumj5ZNQ?=
 =?us-ascii?Q?hiDZm+sPslZMBi+C98R1oSLdiX96Ocv/3gpFUyz5bkk6XFYlaRBCKnwslGBe?=
 =?us-ascii?Q?ZK7dCt4R3cWmFwz0UqGmg7E2MaQ/++cQckzPkb8iJ1dQZfrcbJmodQo0vWWh?=
 =?us-ascii?Q?kLFFtkKWwE/wraKJ11Ajd9vct48iWJOQebU5grjpr9zPd0tcEcqOu9QNyJ+x?=
 =?us-ascii?Q?vXKSAa1RTXfMw7RuUCfhhJ5Sx+cQPxFGHtXxiWqaUcztLXryUxlSkaTxenhg?=
 =?us-ascii?Q?3rtQWVcejpShZGcQqp8wKk6t9ASrz6a6gX+POc2IpikTBUAjSWH7935GGEZr?=
 =?us-ascii?Q?7jETcGsJ1A5E1MkadfnihkT+kmtqRJxC39M0smNjKUuHsOlN1pBIpnBMTXD1?=
 =?us-ascii?Q?zQvDijlY6wvTxFaTBd6+wRSnfIYz/Y8AQbHIkJV7IZjfiJgbj+agdPA+h2Ys?=
 =?us-ascii?Q?kogdEV71SLzkVwiar/IVGG3zLRG9t/ydD/mEjMrhKPrHhsgHmgCBx2xcuogi?=
 =?us-ascii?Q?6+jVMrsRlkFITuQ6VV30bzL3NDEhOUVQ6n9UQJUSdX70RxVVP4sJSHc3zvYx?=
 =?us-ascii?Q?uI0B6GG+7ezeXYGDClwdvCzblZmoX6+tyLvdfcEGg3L9/DUifP8sQ1IRoygO?=
 =?us-ascii?Q?4KmRM0UY1JuBgjwH6lcrfyAA3VPvcy7KagWEOyBM+imOVXlj7KrnsauWyL/P?=
 =?us-ascii?Q?UDIpdSsQunCbMYNshWTdMGPMRG3xaFWb4C68qOGj1fFAPAzgZAtvpZGgCvrH?=
 =?us-ascii?Q?MXF+E7/UzCzxozjza+8wfBWxiQsXtOj2+gnw5ImZzeOy8gk+LvQpQ9IdoQKI?=
 =?us-ascii?Q?87NjM8fc4s+89NAJQlWjadqe2uwJCrWe2a2XHzqIgVxmBwRATQge3FVGHBqD?=
 =?us-ascii?Q?FYRmw4wzeQC+Z4usag6jvTsnZtsX0xTax1XaM3GnZVcnEbcELHSspVlZkL7Y?=
 =?us-ascii?Q?xQZ1jHR9IVbQhESbkOSGMQDc3tOR/AWqUYBDMh+tSpW+RR3buse/034+Urv4?=
 =?us-ascii?Q?AVjC9TvhP+5yYLKehAi2YceYcb6RlApxy0OVesVA97VXiAmUPMOPPlYq4VrW?=
 =?us-ascii?Q?GYYiuYe6eCddDb6WP+YPQEIxuPRSXg05/+ghAh16c9NQwoOcEy/gtfZa/3aV?=
 =?us-ascii?Q?A0VPjMl/yIyVaHKT3OaRbxSW7UqZf4IVLaW5YE5Ih4Mjr8Lj63mGD5ona8Q2?=
 =?us-ascii?Q?VTitHhI7X1cMx86V7MN1P7EP5OOJGDgsRzTOaHRQLk0QjK73vX8sRkpw0pQc?=
 =?us-ascii?Q?wnby6uqaH68HLOlAmq8qmpCh14LyWkSrNgYAzmdTQFiYszQk/m+3Gr3XXWL9?=
 =?us-ascii?Q?nk+pTI+x1tXd7vllfME8oLn5LAbeZrS9TjWTe55b+EAgmLBfA/fpx0ju0ST5?=
 =?us-ascii?Q?AdgoaqfhllqLhH4BJFtRHS5IbLUIvB07?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:09:39.8907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da95a3f-21ac-48bd-b390-08dc96b2c8ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/ethtool.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 959196af7f5a..c7f6f2bc9cac 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -506,17 +506,16 @@ struct ethtool_ts_stats {
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
@@ -824,6 +823,8 @@ struct ethtool_rxfh_param {
  * @get_module_eeprom_by_page: Get a region of plug-in module EEPROM data from
  *	specified page. Returns a negative error code or the amount of bytes
  *	read.
+ * @set_module_eeprom_by_page: Write to a region of plug-in module EEPROM,
+ *	from kernel space only. Returns a negative error code or zero.
  * @get_eth_phy_stats: Query some of the IEEE 802.3 PHY statistics.
  * @get_eth_mac_stats: Query some of the IEEE 802.3 MAC statistics.
  * @get_eth_ctrl_stats: Query some of the IEEE 802.3 MAC Ctrl statistics.
@@ -958,6 +959,9 @@ struct ethtool_ops {
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


