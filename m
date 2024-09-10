Return-Path: <netdev+bounces-126894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05D972D0B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D931C24641
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F2E187560;
	Tue, 10 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhQmyfSS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D2187876;
	Tue, 10 Sep 2024 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959480; cv=fail; b=AoT+zVD2MfuYdXeWujUL9LAYj97eGkzYREnOgXaAgF1Eaf3Pvs9m80wH6MtMfH8/LjNTam2YMPV7UhIx80N/Z3Cjd+g1lQEtQNZFK+344Xc3bpyKk3lVFzFRW/4pVwcUO2cJdlEJdXdmyz4ByL7xfLgBCjIfLrafurNUtnT915A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959480; c=relaxed/simple;
	bh=j2C1rmnjawSywxJAGlFR7N6wD1TlCSIR1bay9ML+AI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hOdRjK6v+hcH3H2cfkj/bylkBzuoCGj0DFRlwjjyyFlXb7nHUGrCmsgipu+lnFrD8CFrBGINZer9RzbXqnnKG+haA2XBx5TeN3/6423CmOmeDQL6ldtLD3FCaWRBm2mFoe22VhSL801FcVJR+JukbqigJcHgMaP58vFyCwdBd1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhQmyfSS; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRBK0LS9uD6QThxS6pzbTeNQDaIIgMLoBaLqii5TbUKARog4Gm03f40swonhwLuW73m1eS47McmeOIqLyb3LrXnmXouZe4CTjvr27EftwHTSr684i56BPIKLq1S4Z0yXp/twoR+1lOYhiehhtvGMzJT3wU1iXuBnNgQc/jptiDHrSzMxDYoxdZkG5i3LzW2ivVLmqZ9Ge6l9NAoUr2mSGwbcR0fM1IBN8qNIiMpi0oPqOQE4XRKEU+TGJw+xfPVlKSeUFKQ+Imy9qXruCLeZvjmBxCfTNaed6srIdsX6zr35n2TXVyxwWYMOcFX9xNJXILA6TKGYMDmL9MUro6SKfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XGubKMgXlwmyITRPgIZg14+e0xYTRE+TP9hYnhNnkw=;
 b=nuU8OJjcNajYv1hzwZc7aDRPbKHLR6Cr8TLvWy6zNChpPuKf7R2hu32oWOYdYDgtm55CKFFXqiyuq/PIlv/fw5yXTWP2hhuF2cUmmsgIVsnqCkyzDINEfZLvt/oDNXkudj+VnDxJFSJ87qvu2mtJXvecXYX60eQrR72XuTy/LRdOaz7Y/HF/Hc5EKmYxCaZ/fJYK3tGznPQbcM3PRkh1lklizwaMWCzzqdCDUL7lQPED5GNLzHGFSWGie1HANVi6vEI3XFKRy9dm45czLQRlqPkN9+JPVSmdwtZn4z02SDShhTUu4WA7cHD3ozyqxQGG6Pig5gAt+gF+Yuq1f/+cFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XGubKMgXlwmyITRPgIZg14+e0xYTRE+TP9hYnhNnkw=;
 b=JhQmyfSSfJ6IlPx6PFKMITMxkbxg+b7gRYsEQrDCfEfOFxwxkaQBj82HeYjIZAdLHEfJbI816SHr9/0msbhUujbCmKqTxqegvoKfTrIAfK/m3GZPfeAn5NNF1uIDaxjEggvKgCkb6aE9NbjpC2esQUZUz9FvlxC2GwK7/Y9mBePr+RcecG424qZj6Rp37pL4XGp/9a8d+tvxCYcxV1RvMyHeUIT6+F2ALEnVkdT+xbwEH9ft271ELpgwuy6eTTdzo+KdPPfa1EQLB7DbYxQl37nTpPw0BuLe4RUgo7iPzGAUH76VeeV1XYbx6QNbdWDvj35XNV8sS+LehLhzBM+img==
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 09:11:14 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::47) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 09:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 09:11:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Sep
 2024 02:10:58 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 10 Sep 2024 02:10:56 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<danieller@nvidia.com>
Subject: [PATCH net-next] net: ethtool: Enhance error messages sent to user space
Date: Tue, 10 Sep 2024 12:10:44 +0300
Message-ID: <20240910091044.3044568-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 81902cd8-ef58-4903-ad4a-08dcd1788521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RHadP+8L4jY5mu9frtzbb5i+crw0AWJomqeCEM1bNtgzW+cClptgYEvYRtmD?=
 =?us-ascii?Q?ACPHOBUFLhyWbJ5oq5ZXOZQwMvfCd6M4ugRfEMRtB6GQcG30tCR+BkX0+a6p?=
 =?us-ascii?Q?97Vn7RM1VNjLuEx0cfTYTomd9jRZyM55CbAWdDsTErrWhM0Ix03VfY6By4N4?=
 =?us-ascii?Q?uAWdNi9xs/+T8Q0rhddDAOdDiITSDNgDYIn+WpD0XintnSTQD7axCeucVm6L?=
 =?us-ascii?Q?emkNTd8nG8jTYV9HseBdNZE6mtkmADg+njIvuO2wD+R+/zhcRINXb3cunQXO?=
 =?us-ascii?Q?HaQk/IbzGeyV3Myf12sN/KbVbenaiMloJSgRm4PfH8brgE3JcJSi2p+LEuup?=
 =?us-ascii?Q?PDwEgjMJFOYYF060d+veCS21XkoGNKkDmVxmhvIPc3FULqYnXYvpZpqN9110?=
 =?us-ascii?Q?wCAUrKbaAbHrPbmQ9FFhoUOjOSRqyhIEeo/AbYFdNSQ9YY87jD9t/BwlJE8Q?=
 =?us-ascii?Q?ahslsTA16PwFvD/yUqM8lvm3XSFOPtcRCniAd4AomM7pWA7JSnJQEY4FMdao?=
 =?us-ascii?Q?1Wxezip55B63STTRhCJietf0ey5vzTNreZqjuzVHHb2IK9DfXiHTdnztWZOH?=
 =?us-ascii?Q?bppqQfl4R/v5D0xy1CQsZjWT1yfUXfGicSosA80/Nze07SmZAttIb+061REF?=
 =?us-ascii?Q?5E1CbCG2ibfzczWzmS+/y1a8CiRCXUmU96xcuDrwsbtFw5RQpxMkozybekI1?=
 =?us-ascii?Q?JUR90COKDMgt4TVgQDMeyfVRZeivHmng18Toajqv4RdCtZKZBm1caTQfbEqh?=
 =?us-ascii?Q?TU36yXLQt+PXKs5/2emhuaZmxdq4SxzCG20pB74run/28KUi4zU6mgfGLCSh?=
 =?us-ascii?Q?aus3znr3jiF1KzhzHRzK2EOcQnkETzGNlU7/v+XvyG4ITQU7BdTTQD5bJOH/?=
 =?us-ascii?Q?fav5sWTzNq6PlPCFzT0ql2x47W+bIadw7rHW4aR4NHaOvzIUj5ZGYUG6JyfP?=
 =?us-ascii?Q?v43bEWaw4L6HB+JPhDGWL5r8wjXBCwpadEZXgcNbVq5oiHEjmTkRaO3vz92b?=
 =?us-ascii?Q?Wq/1BYZTWZCPQo4Gs0gqq3+0IwRQ4Kk3vLXVUE6mmltR7dLSca4JJJq0j9sA?=
 =?us-ascii?Q?yeFPLEVqlEVqDmoWKWOgTvz7bF9MaY65CRfwHhe481q+nTgDFwk/b4P6XcpL?=
 =?us-ascii?Q?73CLtjZP+iOqSAyGJwSw/6QPpjUN8k3bDGLoIwPDpsqJXv1SoCLb6m3SnPwZ?=
 =?us-ascii?Q?94m3FEGjLzv1wr85VAaPdzSzxZkPExHGYjw9uZuijVAeUVJNVq//sCJ4a1X7?=
 =?us-ascii?Q?nQLy9CMj+6PG/jpc0TOBkNA+v/Kn0oVa3HlhF47JA3BL6W4mNRQmuv0UPD2J?=
 =?us-ascii?Q?6I48hEBx928T2K3UVL+fIhPbyay8oQ7xl0xN2S28jBIdAP8FYFj5IX7DG1c2?=
 =?us-ascii?Q?ExU5+EZjNbR/IzQKSsKze/+h35vaDJd+cSxc/WdI9xDQtsq3hiz7Hvk1qq/9?=
 =?us-ascii?Q?yO1N56aQEJJrZ+1wGiTlYgebBZQtJ8ZD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 09:11:13.8375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81902cd8-ef58-4903-ad4a-08dcd1788521
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328

During the firmware flashing process, notifications are sent to user
space to provide progress updates. When an error occurs, an error
message is sent to indicate what went wrong.

In some cases, appropriate error messages are missing.

Add relevant error messages where applicable, allowing user space to better
understand the issues encountered.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/ethtool/cmis_cdb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index e27cad17505e..d159dc121bde 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -116,7 +116,8 @@ static u8 cmis_cdb_advert_rpl_inst_supported(struct cmis_cdb_advert_rpl *rpl)
 }
 
 static int cmis_cdb_advertisement_get(struct ethtool_cmis_cdb *cdb,
-				      struct net_device *dev)
+				      struct net_device *dev,
+				      struct ethnl_module_fw_flash_ntf_params *ntf_params)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_module_eeprom page_data = {};
@@ -135,8 +136,12 @@ static int cmis_cdb_advertisement_get(struct ethtool_cmis_cdb *cdb,
 		return err;
 	}
 
-	if (!cmis_cdb_advert_rpl_inst_supported(&rpl))
+	if (!cmis_cdb_advert_rpl_inst_supported(&rpl)) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "CDB functionality is not supported",
+					      NULL);
 		return -EOPNOTSUPP;
+	}
 
 	cdb->read_write_len_ext = rpl.read_write_len_ext;
 
@@ -299,7 +304,7 @@ ethtool_cmis_cdb_init(struct net_device *dev,
 		goto err;
 	}
 
-	err = cmis_cdb_advertisement_get(cdb, dev);
+	err = cmis_cdb_advertisement_get(cdb, dev, ntf_params);
 	if (err < 0)
 		goto err;
 
@@ -461,6 +466,9 @@ static void cmis_cdb_status_fail_msg_get(u8 status, char **err_msg)
 	case 0b01000101:
 		*err_msg = "CDB status failed: CdbChkCode error";
 		break;
+	case 0b01000110:
+		*err_msg = "CDB status failed: Password error";
+		break;
 	default:
 		*err_msg = "Unknown failure reason";
 	}
-- 
2.45.0


