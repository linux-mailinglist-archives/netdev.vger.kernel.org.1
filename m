Return-Path: <netdev+bounces-137553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072BF9A6E5C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFF91C229B6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461751C3F2F;
	Mon, 21 Oct 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ydb0uuoX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AB1C3F04;
	Mon, 21 Oct 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525128; cv=fail; b=YHkwZjtWEBUZDvfeCCjaD/Pyxrtp09gyNhe8rC2GMpztiWo7TJYdI7rcrU04D64Vz3PFtxt61oneCx09yh1FL2xB1/eVpXIa27g+wjYN/7BGVry92qeLPKfLBq/ZrB7sW2dbmLrtIkhu5v1sWmT+sYpX4nKVTDvjP+9f6dtGivU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525128; c=relaxed/simple;
	bh=bmMo/WwssY9VPEMhQRl7DyYzDOFY+fARG557iHd5QFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QctgAuDAzYvZkNds9DMIYrdIlwefvbTKZU2dLzYUjzHh61fVG/mEhowiKMdlbA+hth1brjZAIE4/CcnMxslr+fmBy38A45TK4HuByskt0jWOshkugCQh20vwBTAX5Tr4tOsS0boTvsWJsaWDrxX8K+YA9gyBxGQ+4/R2ZCNziJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ydb0uuoX; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTSAQvITDMDlLgYzIaF4rbF0ygY/SHeFBw9B40GoibOWb4gQRJX/33N6YHkk9YPTzOeBKF7rTgQABBdzigfEnmNdujrUecTLPee0QC9d3scRo5bKo0WeSx7IjuGGj5zJII2V4H7lNC4CPJkfzrG8HdtcmS8AtvAbcyGsaCUhEP7GXVxuKQtdYwBCJx7gW4nmuaHmssO/notG1duoUcXzhgu96Er75AftWmzfEgNaZ9gVXjo/DBrr4fKL0oFTDC6TqxHTOGRYyABTuzgi8kENh25WsTt889P2BIHKdXY/U3hHQglC9rRB4F3w6TeFdKFd9SCMv+EL11YxqXA5EbWdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vymOa0AVPibzDaSwui/HpdAq0FjPYO888VY3BViZRyY=;
 b=Twg9emj3NMGM63cui6GsrxlAgrJjJJvwiExTX+b+n9mnRlmGwieTaTjnY38TjKy/aB33qNRcbM+NMj99F92QCs+Wh+Ra0uI7by0PSPzu1BF24EoyiwaVNm6gUC4kxuhqut6l3mRJER8I5jwHFhhtrkkLRyY71MVYJWRUs6ty6XyE207BEtF5edY4PaBhGjpcCgkg4vvxlOIzrE4L4VUpvjzAoZrSZzHLTgQaUYNSALuOHPlbMHe1/DHZkvEQGqhPM2KPJMPlGZCUDxvphWRt3Aq+lw6+5/I6AxTWn/TVpnvZeNsuuAs7V39IgnpFaAyNFl3upYlbqS7GLwSRLNFQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vymOa0AVPibzDaSwui/HpdAq0FjPYO888VY3BViZRyY=;
 b=Ydb0uuoXOkbDapMR6mxTwoXGcXDNOkQ5xvaRqfS1l0fSoIHuXZ8MVTMDq5jp3T5tGIM9PPxVVJrjG2GIRyMdgOfzPYuv5CcEn9QlN3vq5jcEPwJ/wV0oub3VYub5ccmKcif78ExiL5EeAKz1sXaJBl4958OBoSVk+MddjJCC2cw=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 15:38:38 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::e6) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Mon, 21 Oct 2024 15:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 15:38:37 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 10:38:35 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH net-next] net: amd8111e: Remove duplicate definition of PCI_VENDOR_ID_AMD
Date: Mon, 21 Oct 2024 15:38:25 +0000
Message-ID: <20241021153825.2536819-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 982b1628-0be0-4889-7f2f-08dcf1e66e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBf4sDlpAick4p4uLdYKY221y/Uqj7et75YFdZOx45ZnHxKGXYO8eEfAAZnX?=
 =?us-ascii?Q?H5demwNivA87gQ8ohZiXlCN48VAy7tk0402jOsloo/Qb5txlnCmmeu/t4I6d?=
 =?us-ascii?Q?T+CsCyKpgcXnquWJNftU0gM0bwU4Rp2qkoq7JVe4faer0Xl+2U59jQnv5dSX?=
 =?us-ascii?Q?CRcjUHA3ugtb62bb6Qdt0D7k9VYtWzrP09qx+aotJ70aHbzppzsh4qaWooFb?=
 =?us-ascii?Q?bNoegQjB8c9vSHMwsSl8j5MK+zmfLrwfM6cg/uEeNr+OIUgS4/0zJzEjqABN?=
 =?us-ascii?Q?yADwlW9xKvXxa92NGvhaJnhsf+zT3H3dUlg7Oe3jYGQBUXEWBkAP6gtVtaMS?=
 =?us-ascii?Q?FKaf6QTLQ+blsD/GN0l8Ll3s1b4+IFVC+A0AvAdqqkJFpwjdcLKecyDmOkxA?=
 =?us-ascii?Q?Wt9V1yc4kIJb9FFr33vU3AS7WdmWyNAscKEqYGj8+6gIpMQTI5W5/gNssnk8?=
 =?us-ascii?Q?L+ueTRkMmyuCLUwXKL5/uFIQnTv4BVEVN3Zq3Wu4mSIOuu6jSTo7Qeebq7u6?=
 =?us-ascii?Q?zArfoOZtqlJWPDY4QwwTbMzI2jA7RezIaIHgTUmcDqoDT2HbY/59OejZEZ7y?=
 =?us-ascii?Q?dSoy7ezkcQowlNxxw3DgZ4NYqSyq2T1EJ8lQWVv6bn/xJC5FwdI5BvqkDehD?=
 =?us-ascii?Q?umzDU/xwO7ME3ZDi7XoCfB9sYBcyJs4U+NdoFlBCZiUpNPnfqCV2LiwLIXb2?=
 =?us-ascii?Q?tlnS3Ra8G04wT91pnzaEamoiuNsXeBOxWD/4EoiQyXH+YRAn4SGAUrZnUvUN?=
 =?us-ascii?Q?Wluuk4XYJvCSeBW6OKB5WPJRU8dpBXDTaKUd1F6fWG98JWh3FndaB8y4MZO8?=
 =?us-ascii?Q?m6/xUPpoBttQU2lXroasTHL72ogDusJ1NL9O67tUrk85+B4/P2+uximvzDDl?=
 =?us-ascii?Q?5xlcu25AVLAYJU+AMOFua3QXqBY+pxr6Nih4/BS75mrgFsGVxP0dpB7bCt0U?=
 =?us-ascii?Q?W8UpvJIZGhL0557D6j75jfDPUoIzH8pClo4d/z38jkJYMWwfcN1W2086Q+8m?=
 =?us-ascii?Q?ydCD5u44Yz508XPsB0CwvNUeq/2sc8nN8fhtJSajRT1fpnrt7EGTexjHv33o?=
 =?us-ascii?Q?ZBrpmb5oFcVWkRhjS6KyxjFi/K+w9cH3aYxKXPTbEUAG4+WIOKr/j0W04wk0?=
 =?us-ascii?Q?GmH6FsqRj04LBSign1pB7M4CNJrl/KgRKKNhGWMnshPxs6/swna9X9MtOMZv?=
 =?us-ascii?Q?TdWkaioSG3ri5USXwJFnJ4tqee84ZigsK9WxW/37Txq+jrbkEXu3X4O41ran?=
 =?us-ascii?Q?JKmiozjJEAPCqZ8CQc+koDsTsJNEOoYE2Kn1BcXY77144ovub3T4YNLkt+4p?=
 =?us-ascii?Q?u/oS8tglFlZvTOUBPr1wafvTGgBok5XIF3v15H6/GySi1Yg+DhurF5RPnViY?=
 =?us-ascii?Q?4YPClj8ywN0xbFVTXdoNyW8ks9QpqfKzFbHw/Lc6SF5QA0USKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:38:37.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982b1628-0be0-4889-7f2f-08dcf1e66e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421

The AMD PCI vendor ID is already defined in <linux/pci_ids.h>.

Remove this local definition as it is not needed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/net/ethernet/amd/amd8111e.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/amd8111e.h b/drivers/net/ethernet/amd/amd8111e.h
index 305232f5476d..e4ee4c28800c 100644
--- a/drivers/net/ethernet/amd/amd8111e.h
+++ b/drivers/net/ethernet/amd/amd8111e.h
@@ -550,7 +550,6 @@ typedef enum {
 
 /* Driver definitions */
 
-#define	 PCI_VENDOR_ID_AMD		0x1022
 #define  PCI_DEVICE_ID_AMD8111E_7462	0x7462
 
 #define MAX_UNITS			8 /* Maximum number of devices possible */
-- 
2.43.0


