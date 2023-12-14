Return-Path: <netdev+bounces-57425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47E3813136
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A13C1F221AB
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097855775;
	Thu, 14 Dec 2023 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKEjlE0o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74E116
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7z5rXq/4mPKwh9/2tIlFnsEcUX+x8KhTUbjWwcAYE55z8vtKdCbf1QItqOQdUa2vVfvgqfmBwmG8ysLii8oElymRsJtfyXcAKwYeenEujo9OL9jRbTWz32vwFfHKc2bIbeQqJ5+O2ZfcndWiVtOmuRrw1I/vMK6oX+f+xGQwAS1tIxynQUFZ67t4pkTAIb5sT/rN1wSQSQdsqAOHgtGCjiNfbUKSvDIzWl3mdgm3yMw/0NWxcPte2KGilIgPYjjUwshYxxARCRrvXJzx+LRb+X9vSCbe1wgNNBVJQ8LDDdsa6xkRG2nMmldDwjIrWW6WS6Csd8WAfN6azbro3cOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1rFWVmzKDuumcW6HqHiCkczcDyX5LXkmL7y/hqfZYo=;
 b=epY+AyfJfJEUpvtuw4AlFgwfK7/BVL+JiZO3RxoZmGLYZiQZe5Ta6t6t8XGI0siOM/Y0J/XK0eeWHssnfuyCU/cffjMlWfTBteiVz1j9k7JQTfnmueeqV3rzq8YaKJuSNWNDySFhInGEBIPugz4v08Q8OhgXjE8HOrlxkwAh6DH+/38GQpOAwimQOJPJGaf/+NQZHuTyObWjGcut7pWAid0+BayySeWfL5nYVajl0wmP/vK2axFUAyeaDguMLAIi084cKx+dEd+imM7aCpm9A7PA8Tz+ggkkamOFEMmMsy5U7fdn0WIedAeLf1yhifDMCVSuYyd6t0aFn/0JEx1Tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1rFWVmzKDuumcW6HqHiCkczcDyX5LXkmL7y/hqfZYo=;
 b=gKEjlE0oeiBum3ACyJFTJmaKbPlzvVkmPocodtsiZmwtOyZiObHXnJzO+Qr46bkX4QhhkYJZ2i3oDwCcklK0QUTqB9SijLomYVwdFrMxL7/ASb9VVqqgFhoUARTYnIemraqRSQWljaybZ1XbawHFDJohi4gmujHsKSJ7N2VMl1LuyzqmsGri0UlwJCW0AUaityrohieKZwC8aNEb3rnUQh+zqL+kZ82poCrl+YTcClUTlO50hSWa3BBQHljxLTcWCS7Xzm2riyd8BreDhl53NYopLobq4umIOrmpynCBgBl6okxsxiVJXMJcl5kwrXbM8aaILKlo2jiYNxKMNC0REw==
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 13:19:44 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::4d) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 13:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 13:19:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:31 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/3] mlxsw: reg: Add nve_flood_prf_id field to SFMR
Date: Thu, 14 Dec 2023 14:19:05 +0100
Message-ID: <5f0354ee624195c394c57860802f61ebe43440a9.1702557104.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1702557104.git.petrm@nvidia.com>
References: <cover.1702557104.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: c879131b-c178-4eb1-a84a-08dbfca7562f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kNf8p8UPcSb9n5j43Rr4yw8FA0z/M7nbX/c4jyJaQlDsMowO+6zAR1VDTFzsqTkvBeefVOnMWlMKDF6bPnHABfn9lVJxnPi7/7LlaM6SW6rA+BrFDIYe0PNib+q1O2n4LvkW6Urs3GnP6JU1G2WEZIQcPtHgrWbCGEsiRspcbjhY9vHqaXBMpfNOf4KZcj9aD3mHis8cO+22EeYmPBpfee9WMTxfxQkU6LDzruwKq2Wt3Sh5+gboXpf9vtc9wM/UzE06XdtBtzUlfRGSXs2HPfLVeZ/2+vVgIdeW0pkIRKP/BW21rleWNDSO5mxGh6V0lelyFWSDqbUOOmG+U/5jagkdLP6oX5UYIiMtI3uHKrTgal3XiDpvCUqjT6mTL/HMfdEmSzE5alUObN20VIyJhGZgdx6m6uwmgf3WgCFbXjRoU+ERdjElC8oo33POMPi+EcrKNp+DuMFegOV3mvfyXdt4riuOr7GnUOk2H7qjm+U6m19ZGKvhyjO1H2E+dClfCLKOiZZRB59VI4IKBBfbmcN2LS8oABzSMvY4i5srtL2m4/VUTVCVBsYKpZO7BSytA1eCV7lAm21vO8Po5oZYcGS7sZlwQCrN72XN+PvSQcKm65n6KRoWgaZgSQsPWKX79WGdeGJn7KLhvA85MOQyiCBmPO8gQBcv+rz+CQnIgHEUezG1hknkI2MkweuJp61g1N1aOizLYl3U7fbbKz3/gLY7XfzDESiNLGDNNQaqpUe5NmE1autjwL1oxcs4xhp3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(36860700001)(2906002)(5660300002)(41300700001)(86362001)(36756003)(82740400003)(7636003)(107886003)(478600001)(16526019)(26005)(6666004)(2616005)(4326008)(8936002)(8676002)(70206006)(83380400001)(426003)(70586007)(336012)(110136005)(54906003)(356005)(316002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:19:43.7821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c879131b-c178-4eb1-a84a-08dbfca7562f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460

The field is used for setting a flood profile for lookup of KVD entry for
NVE underlay. As the other uses of flood profile, this references a traffic
type-to-offset mapping, except here it is not applied to PGT offsets, but
KVD offsets.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 3aae4467e431..8892654c685f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1954,6 +1954,15 @@ MLXSW_ITEM32(reg, sfmr, irif, 0x14, 0, 16);
  */
 MLXSW_ITEM32(reg, sfmr, cff_mid_base, 0x20, 0, 16);
 
+/* reg_sfmr_nve_flood_prf_id
+ * FID flooding profile_id for NVE Encap
+ * Range 0..(max_cap_nve_flood_prf-1)
+ * Access: RW
+ *
+ * Note: Reserved when SwitchX/-2 and Spectrum-1
+ */
+MLXSW_ITEM32(reg, sfmr, nve_flood_prf_id, 0x24, 8, 2);
+
 /* reg_sfmr_cff_prf_id
  * Compressed Fid Flooding profile_id
  * Range 0..(max_cap_nve_flood_prf-1)
-- 
2.41.0


