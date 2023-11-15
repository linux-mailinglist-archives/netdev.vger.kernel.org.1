Return-Path: <netdev+bounces-47981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D327EC21E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EA1C20B8C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAB1A735;
	Wed, 15 Nov 2023 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VPKktwqC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFF1946A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01011F
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flqCrYoXxqsC8vkfb+EkhsJThgGB6h5z5bW10qVaT9kUeNPqODS712jPoo0UWyMlLFNA9dM9KOi3kk4PvVQBZr1T1oEKs56fvBDKEEqIKeDThI+lynNPtf/w/nqEE730TaNyjfM1D236ZnNJ09jf6RaRRnXOqlRSzuAH5ZU0wV9nYSRLWBCfZhmqY3wOChdVMrI2mpUaNadVR7JIhLqABgFDgweFwiaCq+Yv4/eIlK6R9NPgpmXUYE1Aa37KDqICasC37mpc/yyDbo58ep+Kb4Q3QXRnq/y/q7pfH01dtN+2qgGq3eqKSzBp/zt56YQoRT6TXN2uU2O+lAp2BhJpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMjyc6EVXP6jy1I3qDY81C9XGwH+uxylc5iRSAa+cpo=;
 b=hjOj6eFoi4rXD7mFr5UO7aIewL1EXaWi5hBAT+VFApZxA0JqZ1rJQgUgxD/mWifSyxIVpF91cYf8cJR12i0E1OX2VB3FMG7Zhoi+zipXd8AcqvYdyzhj95R/VzPCEJpH8NicBE9SfcWfeLwdY+ToevnkFFyBSGVmXgfY8jir8LT81iy/lk9BC2I1EhKZ0a10uaIIJ8FKLuTQ4iebS3TmXAc4t2IXZRphDdJbBsZhxjBoJ2NsIZ3r8cqdg7r6J+g9Bk8RxQ40nKUNZNxIb8swd994tZmRbeTNiVdvC6vvCr8UL29nQZgKSWC8S1Gvn04URF7gNvOuWkA3yWxty2HStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMjyc6EVXP6jy1I3qDY81C9XGwH+uxylc5iRSAa+cpo=;
 b=VPKktwqCzWkGxWTAEkF3uRv21xDOij72eNpcebEtT1YLZ6K8rlnIZ7JRSvLmnGbCT4AKt3ZJOCLL3lO1Zb+VouNZ5LWr1kLib5QM4UhTxGens/MDzsmaUWHcqbJziJdyeYDfeMhMnTdXizBtuv5vXIvXvwSmkp6LbIaNjhqsxgOhDrxK83APErUeCDC0kRmH05IWtXlftM3LvbToWkLMFl3lD6HkLgz6kafOTo3KYDb6U7n6lYGAN0lHJ2Yr/QXF4nPbJ0Un4cZrAkjjOqAcxvnD7rHfEOyGz3bEkpVTPcSYC8uGVVZpqIZ9jS8b2e3+YxfFtB5ZPzCUiKtx6BhwtQ==
Received: from BYAPR06CA0017.namprd06.prod.outlook.com (2603:10b6:a03:d4::30)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 12:20:11 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::2f) by BYAPR06CA0017.outlook.office365.com
 (2603:10b6:a03:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:58 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 12/14] mlxsw: pci: Add support for new reset flow
Date: Wed, 15 Nov 2023 13:17:21 +0100
Message-ID: <2b6629170e815abed5dfc7f560a69a1accaeb1f2.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e6f9c2-798b-4991-abf8-08dbe5d5368a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vr15i2pUTkHdlL9fntyvC/SW+Z0Ccch2hS4Qw8D+zdGEtD0tRpl1xg/lX6tNclrPLAMx/GarQaBW72oOGEagj49EUsleo64XjwBA1zCgfSsRN9AnVT5KgbACB3J1ngh9sM+KQoRG2qGyIksL0eRjRMEcN5ZM5MrH9sxVUG5hCy61Czoord4hi1Xz7rulPOp+b+yfrs982n9BE3OdLZAIhCBdnbKrkpa8QlAUmHjAeLYnjlvdUWAVbquU3mVitAA9h4JKF0wnB4EJomxaNcsxx3gCBezVQNx4txEkpzsVD4338nl1b9ma7Z3BE9AUFKh2d/QvYpZ8FFr4/37IWZZ4A8VMJj7QHK8z8fdvkzZpvRpAPVvb/472/+HC7eh/qky3rvhJ3sKzn+LDgkTSfw1MJE5XRCsKFIQ8TYCgya3mRQt+UgsfInW98YEvd8QlGGydTVJ2GOjBOCXRFyMNugrUh4PIu9XB/SrSDwyyivmL2A93OebyUZ6TkFufzbdYkByEYHHYVbbnxvvAU2skftj/DP6nVAyJdiFXIB7XKw8arHVnbfARtt6otu3Rne5fTjpYtGqDghpyQW8OB7bfN5cCR0C3IcXeloC+bakfHftHgTYV8PfsAvGagPjtworLEgftF0UhzZCAv1POJwYuSG4aud3qz00nCjJXgL3ioPJBkbH79i/RAA8e/BwcLlTRNb+0wP1sQrIXNWVC4Y6oooG7yJz9p1CjczcSv3G4iH2DB46Izulz+/r+g01KKi0/dU/S
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(41300700001)(47076005)(4326008)(8676002)(8936002)(36860700001)(316002)(26005)(336012)(426003)(36756003)(83380400001)(40480700001)(107886003)(16526019)(82740400003)(356005)(7636003)(2616005)(6666004)(40460700003)(478600001)(2906002)(5660300002)(110136005)(70206006)(70586007)(54906003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:10.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e6f9c2-798b-4991-abf8-08dbe5d5368a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218

From: Ido Schimmel <idosch@nvidia.com>

The driver resets the device during probe and during a devlink reload.
The current reset method reloads the current firmware version or a
pending one, if one was previously flashed using devlink. However, the
current reset method does not result in a PCI hot reset, preventing the
PCI firmware from being upgraded, unless the system is rebooted.

To solve this problem, a new reset command (6) was implemented in the
firmware. Unlike the current command (1), after issuing the new command
the device will not start the reset immediately, but only after a PCI
hot reset.

Implement the new reset method by first verifying that it is supported
by the current firmware version by querying the Management Capabilities
Mask (MCAM) register. If supported, issue the new reset command (6) via
MRSR register followed by a PCI reset by calling
__pci_reset_function_locked().

Once the PCI firmware is operational, go back to the regular reset flow
and wait for the entire device to become ready. That is, repeatedly read
the "system_status" register from the BAR until a value of "FW_READY"
(0x5E) appears.

Tested:

 # for i in $(seq 1 10); do devlink dev reload pci/0000:01:00.0; done

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 44 ++++++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlxsw/reg.h |  2 ++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 080881c94c5a..726ed707e27b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1476,6 +1476,33 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 	return -EBUSY;
 }
 
+static int mlxsw_pci_reset_at_pci_disable(struct mlxsw_pci *mlxsw_pci)
+{
+	struct pci_dev *pdev = mlxsw_pci->pdev;
+	char mrsr_pl[MLXSW_REG_MRSR_LEN];
+	int err;
+
+	mlxsw_reg_mrsr_pack(mrsr_pl,
+			    MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE);
+	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
+	if (err)
+		return err;
+
+	device_lock_assert(&pdev->dev);
+
+	pci_cfg_access_lock(pdev);
+	pci_save_state(pdev);
+
+	err = __pci_reset_function_locked(pdev);
+	if (err)
+		pci_err(pdev, "PCI function reset failed with %d\n", err);
+
+	pci_restore_state(pdev);
+	pci_cfg_access_unlock(pdev);
+
+	return err;
+}
+
 static int mlxsw_pci_reset_sw(struct mlxsw_pci *mlxsw_pci)
 {
 	char mrsr_pl[MLXSW_REG_MRSR_LEN];
@@ -1488,6 +1515,8 @@ static int
 mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
+	char mcam_pl[MLXSW_REG_MCAM_LEN];
+	bool pci_reset_supported;
 	u32 sys_status;
 	int err;
 
@@ -1498,10 +1527,23 @@ mlxsw_pci_reset(struct mlxsw_pci *mlxsw_pci, const struct pci_device_id *id)
 		return err;
 	}
 
-	err = mlxsw_pci_reset_sw(mlxsw_pci);
+	mlxsw_reg_mcam_pack(mcam_pl,
+			    MLXSW_REG_MCAM_FEATURE_GROUP_ENHANCED_FEATURES);
+	err = mlxsw_reg_query(mlxsw_pci->core, MLXSW_REG(mcam), mcam_pl);
 	if (err)
 		return err;
 
+	mlxsw_reg_mcam_unpack(mcam_pl, MLXSW_REG_MCAM_PCI_RESET,
+			      &pci_reset_supported);
+
+	if (pci_reset_supported) {
+		pci_dbg(pdev, "Starting PCI reset flow\n");
+		err = mlxsw_pci_reset_at_pci_disable(mlxsw_pci);
+	} else {
+		pci_dbg(pdev, "Starting software reset flow\n");
+		err = mlxsw_pci_reset_sw(mlxsw_pci);
+	}
+
 	err = mlxsw_pci_sys_ready_wait(mlxsw_pci, id, &sys_status);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to reach system ready status after reset. Status is 0x%x\n",
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 13c0ff994537..e26e9d06bd72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10594,6 +10594,8 @@ MLXSW_ITEM32(reg, mcam, feature_group, 0x00, 16, 8);
 enum mlxsw_reg_mcam_mng_feature_cap_mask_bits {
 	/* If set, MCIA supports 128 bytes payloads. Otherwise, 48 bytes. */
 	MLXSW_REG_MCAM_MCIA_128B = 34,
+	/* If set, MRSR.command=6 is supported. */
+	MLXSW_REG_MCAM_PCI_RESET = 48,
 };
 
 #define MLXSW_REG_BYTES_PER_DWORD 0x4
-- 
2.41.0


