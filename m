Return-Path: <netdev+bounces-111753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCF932732
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B85B21BD9
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76B19ADA3;
	Tue, 16 Jul 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pUeOQinQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1919AD5B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135516; cv=fail; b=WsXmDl61mMhHLLkW3Ji43AxvMkYFwkdfBmEvpvB5F3/05AmGwH10bs0Wikf7mDRL2P6r77xhAb/WBY1BDLuPxLrCkEwGGXTEqMrvaq5e3qThpLXL2BMzzC2mYHfEbWdC9TRm0E5PWK3gktykmz4ni7MzIVoPlHqoDW5ihl5j/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135516; c=relaxed/simple;
	bh=ypvifXDD6K+3EHUJ6OuNtvvPC7HxBCEQ0quwT1CtscE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUg0gh/zufxCSnmnAPLxfehPCjWdx1zvGfVoT5CdNrPR8FoZPVYJZCUw1Dl4EvFyVzwxRRphoM4ATDFdpgdcAgu3EsHUVwzT3cXzFQWj4J5qT5kKe9vSEX0olmUBB+vuasaplY6Gudv8hZwEcyo39IoOavkOEF6p5WgepKQxbcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pUeOQinQ; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5kzfQWOk9Se6n7rfy38qBjXup7f4GqaFnGgfEbbpkmRpFuKPFrcXDNLuik/zkul9zW241FoGmtky7UMKu3GpJ9yqUoAXwvSLharlrKLI3mLhsUg32J3f5aZjfvAqnsffmLLvcoh+srCBAufuyv9natgQSgPQte89oPhA+ihQ+ZZRcVNYrtzOICMxvPgYacRX5XLzhUqylSjMxHdZzm4yl4XKZ/TbmhgfBe+qBfj7vHD9j4DieVC3Q2WRD5IOGAp1NSrxWNJRpqY27i2LtBjwQppbwkkI7uFlr20tJGEbVeTRxlNwvY7sQvH/ltwR5UtTIUWJvO2HCv6uTbr0KBjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DICkl5y956lOBp5s5ApQVIfhzAOcm+r59oMg5hEwjE=;
 b=czwT/CMconmPwCD5JNHAXKpFgKviRvQpuw4MMfVXPf7aWThW4kNzT2yY1Mlp9aL9HF6SF+dw08I+LQ6rXUDu1K4F4obanymf/82VvxkLGfvRJPySobtJu2R0fqrCrv75OMXB+F5mPqj31ToaDZ01Kes6geveqVL78Jcgwk/VVJ6vZ/d/zHWML5cZtZPKyc1quYlXv3qqOkH5Fm/cjhrtWLHaD2TMnbBmJXY65J1Xam1oWYXQKVii6R7nHXnyQbOM68D+H6oViZCuD4aADmm/6nCLxYXPnBMFuCqM089c+SN1CHfLuJNss65j+5jbvXYaJsodAcw+9mObynstIfBzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DICkl5y956lOBp5s5ApQVIfhzAOcm+r59oMg5hEwjE=;
 b=pUeOQinQwdqFhi49Qvm1wdvHv2JRlU6ni2RVaCBjN/CxhOpiOS+CRr4qQm5Uze12eYkh32rnCv5po3VwTjuPYyEd6qPkPnQCIm4y1R3KhZVtmlzh/jAwuIiiFOro7r1KUaZQ9YRiMqaXsIoWkXLJeCdWf24/W775BUl9EjqnOMdC6zjOBhn1LB4FuNfEsU9jK8twO1DNI2eqXCxikY5Zj6Ogd2fxsIZNZgYbLAwykLqqeOfBTXMk3bCJ/FytaWz5bfFsRgY1dQFUSGLzAK/clrINhy/4/2LNMgejUxioPb3i5sBbT9aSrdIay5qYM96Jyb9FFur7hw+A45OWqhrWHQ==
Received: from DM6PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:40::22) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Tue, 16 Jul 2024 13:11:47 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::6e) by DM6PR03CA0009.outlook.office365.com
 (2603:10b6:5:40::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Tue, 16 Jul 2024 13:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:11:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 06:11:31 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 06:11:28 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH ethtool-next 2/4] cmis: Print CDB messaging support advertisement
Date: Tue, 16 Jul 2024 16:11:10 +0300
Message-ID: <20240716131112.2634572-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240716131112.2634572-1-danieller@nvidia.com>
References: <20240716131112.2634572-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e025253-ee89-4613-b2c6-08dca598d85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPxb2HX91U17Jt3336esX4+ZGuK8cDGrg85QNFfByUembpnty2dHj/so05m4?=
 =?us-ascii?Q?xfGfybxTJfffo92JRHRt/2Ct2YNEjU/SB1dhmdu84b89Yy7WRZhVx7+zWQ+C?=
 =?us-ascii?Q?ZUPf/50mh2ObHOA8KfVquSu7UAwh6EHfgVM2bK3H+/qVzGS05SSblc/wPHKi?=
 =?us-ascii?Q?mmWmn7aGiZTAojWvXU5FZhW/2Wy/PuUl9Nl/p97dBz1ihjL8F6OUlShfu1M6?=
 =?us-ascii?Q?sE5clWc0iWE2vCsWkTiL+Ak8dkRixO7YGiv5bTFCRMkRWcHn6kROoIpaWKue?=
 =?us-ascii?Q?g2TNgtdbPE0JvGZPPgJwcx2kX54RnN2mWKja2vNQqXXYdtnBTh4K2Nebm3s1?=
 =?us-ascii?Q?0bE3Q+oa5mcfKnUNB0gmAioSV8uLgiBptSSP7TNftqbUvNrK8itVD0KUVMSW?=
 =?us-ascii?Q?W61HaSX5ADJzOTJslz/UXfUf761raWFPhIcB0vaNG6xOU3yt2w/B6cZSPpMC?=
 =?us-ascii?Q?K6yzv8u2iljTJw2zSyfozMeW7g8fU4YhSlOKhmwKPHj1teUIty5Qf3em3PrD?=
 =?us-ascii?Q?aYWkgAtr+rLWe9Z1+rvy63NRrO2FUU5sanZx2LRY40imY7MqRd2TwRXmJgMV?=
 =?us-ascii?Q?+lPhOa5PdzHNiFblmF8va0+PrBtQQVcRLc0oIS6jq/n9u07T56sNxTWbMNzU?=
 =?us-ascii?Q?DUfq8O8CsshuijreSOXJhgbKZGu7rZaSlWOQ+CdYbIEGkOJW7qD3OAKErN0Z?=
 =?us-ascii?Q?0s17vOea66KCbyTJmEaU1JsVJJxP432hSo9ihLJQFLGTkulo2Ow9yYm5ff4y?=
 =?us-ascii?Q?EHXP7WggUHBumlT/0mKY2JglBa8jqCSa4ltS2AWqhW145DDldm8cRZi41s6u?=
 =?us-ascii?Q?xiqLOwkQfxlGO0FnVqBJIm2WFemrZNggtz3g+5PrfUb+WByjFeVEw5X81+d7?=
 =?us-ascii?Q?AN/ypywIAwHlcl7tFB4LzS4kJsbdCrDuhLadJ+R0MAyvfduO3nyzz6Yv9SdC?=
 =?us-ascii?Q?lZDat+TWV4izXGRp51T9DpbcOp5WZfz6wVdgzpRq05D4zFuv48by7DOPgVmJ?=
 =?us-ascii?Q?4bphyet64W9QWS3F0GEmNmhtPcBnDOxjUla/ibj3Rqds0jSkzp8xw+3BoxKo?=
 =?us-ascii?Q?NuoRa6QA2t/duw6c1nvQ/4v4QBHagZbJdke5kDV+A/TLDCCx6isF4aLVhDcl?=
 =?us-ascii?Q?bvp63A5rqoqjZCNFNuey2Tjr/hlOcSX9z3AIN2iPZ+IBOTysuaAOuzQ1u3pI?=
 =?us-ascii?Q?IEaHlTQO7dveoKKcQszLcN5hQY56XaYFxfbki0Opqkuych083eBp16nGyjuW?=
 =?us-ascii?Q?PGauPJRsiCKLFYFtzTs/oGKxCdy9QyAYV1FNbfjvBYYWsgsMvIjkwstxgCJ/?=
 =?us-ascii?Q?6vXSffPKM8Nqj69hLtpRid9Nwvg5lGJS1Y/ePsyMjWTF091QRCufwx6V6zZt?=
 =?us-ascii?Q?adohIUsofKfICBWtcqou+1us73tgtCbRbbdSsjXb/44w6FWEIPsSunxRiFwH?=
 =?us-ascii?Q?y/XuBBgUHkZ39P6YfacXfgvD51DFhx5u?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:11:46.2280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e025253-ee89-4613-b2c6-08dca598d85f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638

From: Ido Schimmel <idosch@nvidia.com>

Parse and print CDB messaging support advertisement information to aid
in debugging CDB related problems. Example output:

 # ethtool -m swp23
 Identifier                                : 0x18 (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))
 [...]
 CDB instances                             : 1
 CDB background mode                       : Supported
 CDB EPL pages                             : 0
 CDB Maximum EPL RW length                 : 128
 CDB Maximum LPL RW length                 : 128
 CDB trigger method                        : Single write

Fields that are not used by the CDB code in the kernel are not printed,
but can be added in the future, when needed.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 cmis.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmis.h | 11 ++++++++
 2 files changed, 91 insertions(+)

diff --git a/cmis.c b/cmis.c
index bbbbb47..6fe5dfb 100644
--- a/cmis.c
+++ b/cmis.c
@@ -928,6 +928,85 @@ static void cmis_show_fw_version(const struct cmis_memory_map *map)
 	cmis_show_fw_inactive_version(map);
 }
 
+static u8 cmis_cdb_instances_get(const struct cmis_memory_map *map)
+{
+	return (map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+		CMIS_CDB_ADVER_INSTANCES_MASK) >> 6;
+}
+
+static bool cmis_cdb_is_supported(const struct cmis_memory_map *map)
+{
+	__u8 cdb_instances = cmis_cdb_instances_get(map);
+
+	/* Up to two CDB instances are supported. */
+	return cdb_instances == 1 || cdb_instances == 2;
+}
+
+static void cmis_show_cdb_instances(const struct cmis_memory_map *map)
+{
+	__u8 cdb_instances = cmis_cdb_instances_get(map);
+
+	printf("\t%-41s : %u\n", "CDB instances", cdb_instances);
+}
+
+static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
+{
+	__u8 mode = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+		    CMIS_CDB_ADVER_MODE_MASK;
+
+	printf("\t%-41s : %s\n", "CDB background mode",
+	       mode ? "Supported" : "Not supported");
+}
+
+static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
+{
+	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+			 CMIS_CDB_ADVER_EPL_MASK;
+
+	printf("\t%-41s : %u\n", "CDB EPL pages", epl_pages);
+}
+
+static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
+{
+	__u16 rw_len = map->page_01h[CMIS_CDB_ADVER_RW_LEN_OFFSET];
+
+	/* Maximum read / write length for CDB EPL pages and the LPL page in
+	 * units of 8 bytes, in addition to the minimum 8 bytes.
+	 */
+	rw_len = (rw_len + 1) * 8;
+	printf("\t%-41s : %u\n", "CDB Maximum EPL RW length", rw_len);
+	printf("\t%-41s : %u\n", "CDB Maximum LPL RW length",
+	       rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len);
+}
+
+static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
+{
+	__u8 trigger = map->page_01h[CMIS_CDB_ADVER_TRIGGER_OFFSET] &
+		       CMIS_CDB_ADVER_TRIGGER_MASK;
+
+	/* Whether a CDB command can be triggered in a single write to the LPL
+	 * page, or by multiple writes ending with the writing of the CDB
+	 * Command Code (CMDID).
+	 */
+	printf("\t%-41s : %s\n", "CDB trigger method",
+	       trigger ? "Single write" : "Multiple writes");
+}
+
+/* Print CDB messaging support advertisement. Relevant documents:
+ * [1] CMIS Rev. 5, page 133, section 8.4.11
+ */
+static void cmis_show_cdb_adver(const struct cmis_memory_map *map)
+{
+	if (!map->page_01h || !cmis_cdb_is_supported(map))
+		return;
+
+	cmis_show_cdb_instances(map);
+	cmis_show_cdb_mode(map);
+	cmis_show_cdb_epl_pages(map);
+	cmis_show_cdb_rw_len(map);
+	cmis_show_cdb_trigger(map);
+}
+
 static void cmis_show_all_common(const struct cmis_memory_map *map)
 {
 	cmis_show_identifier(map);
@@ -945,6 +1024,7 @@ static void cmis_show_all_common(const struct cmis_memory_map *map)
 	cmis_show_mod_lvl_controls(map);
 	cmis_show_dom(map);
 	cmis_show_fw_version(map);
+	cmis_show_cdb_adver(map);
 }
 
 static void cmis_memory_map_init_buf(struct cmis_memory_map *map,
diff --git a/cmis.h b/cmis.h
index 3015c54..cee2a38 100644
--- a/cmis.h
+++ b/cmis.h
@@ -191,6 +191,17 @@
 #define CMIS_SIG_INTEG_TX_OFFSET		0xA1
 #define CMIS_SIG_INTEG_RX_OFFSET		0xA2
 
+/* CDB Messaging Support Advertisement */
+#define CMIS_CDB_ADVER_OFFSET			0xA3
+#define CMIS_CDB_ADVER_INSTANCES_MASK		0xC0
+#define CMIS_CDB_ADVER_MODE_MASK		0x20
+#define CMIS_CDB_ADVER_EPL_MASK			0x0F
+
+#define CMIS_CDB_ADVER_RW_LEN_OFFSET		0xA4
+
+#define CMIS_CDB_ADVER_TRIGGER_OFFSET		0xA5
+#define CMIS_CDB_ADVER_TRIGGER_MASK		0x80
+
 /*-----------------------------------------------------------------------
  * Upper Memory Page 0x02: Optional Page that informs about module-defined
  * thresholds for module-level and lane-specific threshold crossing monitors.
-- 
2.45.0


