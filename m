Return-Path: <netdev+bounces-23344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68E76BA26
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD32C1C20FEC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E82214E9;
	Tue,  1 Aug 2023 16:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6901ADE8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:58:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4275DA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 09:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNzfAOmt8ZfIsuOUNr7lbxcDknpA+OItXR+32+ZY2UhHcMGN025YSsHh9jWhzMuKyxq9GWbIyKfY1VoddLluX/+g37tkPSPh2rPk7Q3a7BRBkDKo3gAosiwBH6X43lcBrSr/b/3PHzPPAiFlwmwPUYndbkyteqVefOJRGGnPuYQ724Eod9NiTcrS0vMQtViLIfjPA37OqXCQ9hiSLFvoZs6kOE+6ePn5m6ykz7Tk2QyTVkXkTA9vV7wgwIk04lq1kOsEM3/endutuIv0HTJpw3uKugKzSpcuGuQGHPGfLRsolAn+eYTOVsAkzilGeGEO6vtoKQvMyVk4zfeCdeLO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5wK+qryuOr6q5BYj3uT5Ebgr+vpv5yPu2opLy4lYIY=;
 b=KTuJwMWSxFl9lievD28DuoiKQig5lWaFuBE2G5jwyasjMXiaVhHBmaR4CLx0qkfzSq3Z6nD7aHbQK9gtsIpAtqfGNSZBEPtvXlLL1vAJdzmnP+Eo/aKU56vTSQF4Mt3Q7Vr3U11rKtHakysamYv2lN/iOZUk920d91FXN9sr9jdmQJWzaDlsteBQChdE5gNSZzuK5L2fCMuoGsZYdRAoohRAmWEcnUG7BvkCRRSdTr/YQYvA5MikqofZwwQg3pUv8N9iCu08Yrq8Za/7z4M/94jGdyy7NWTYLF3ntfdtqoPc7SgL5fStHs2d2qMZIjbLjnNWr3E81GYDDcwENHxucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5wK+qryuOr6q5BYj3uT5Ebgr+vpv5yPu2opLy4lYIY=;
 b=3TVHW7V4J/fjJSxOb/lK0DpzHqezhtYK0b3V9QJY6KEqnipKkapS6w1Yk8FacS6lIgpoKIo+nmlfGqA/qG7Ql+6t19GH9UhruKuYDSsnp1DIqavUlr6VH4ody0EPP80Xht43RxlzkZpzxOYJtmeK3rGYWjcPJ8RlGiHo77fXf2s=
Received: from CYZPR14CA0034.namprd14.prod.outlook.com (2603:10b6:930:a0::19)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 16:58:46 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:a0:cafe::66) by CYZPR14CA0034.outlook.office365.com
 (2603:10b6:930:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 16:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 1 Aug 2023 16:58:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 11:58:43 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <kuba@kernel.org>, <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: <alex.williamson@redhat.com>, <brett.creeley@amd.com>,
	<shannon.nelson@amd.com>
Subject: [PATCH net-next] pds_core: Fix documentation for pds_client_register
Date: Tue, 1 Aug 2023 09:58:33 -0700
Message-ID: <20230801165833.1622-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: b70c55e3-3ddf-4d0a-1088-08db92b091f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wr52JYmvbbqLI4OUtnxhW16R+XOFg8Gd/ELSeRcpvcK4wTR3w8b0IcLYnEyxH0xU8Yk/adJ1k2wUTklreg+Vca33SRiF7v1ovNm52+qabfMJpJ4jEN11TBu+wIVFSLTWTk97LiuGjP17/VlH41GCU+5oV3Xm76yxRwE97UquP9M+7oB7D19cMrZXTS2ouJNo3KUvxeOZzPffaynPh3GKgq7J9nBylW5BmXlKUQh4rebMdKpiNZBYSHX68pwvmjyxUQkRv3EbC112SVrpyCXsYx8lv84BpvtdEdRA1Bp8Z8Ew1B4DGcRe1qsrvjlmDEysMAcf2co2wnoTGwWF6x1ndrnWmivuvBq5QBHo+8t2Zesp5lMh1RkCtnGsLgmc6905oy7EHJMZ3ikXuiKf2VT4uqZeT0eO9llBfydripd6HBDR+uwyvtlz4MvMweZOpKj5U4LjQUSkmCQ+Suu1pL0LDPCGI02WoPOLqmucdaKdbIJfxbKBEEqo89Oj7yVU7h4UVkl9l5otq4XRIAmmncQqch5KAa0bba0JnJJCEO6vaX+4bHblraOvC95kp2k67TWm3Vn2ndtBzXb/5IWXmMYYBe7ZI7ESRigZ0AyE1UrH3EfS4ox+/RMwzA3iuDD66vzH356j5A1YR+x1prmUCUvIMTw0eyTGqUzzOyimj9IGucv7cVib4Hd75VcFIBbI82vh1CxNrLtLux/KcZwwE15Hu7ejEuU2yKXBifGyecGWQONaZGaVMvlscEPFs8/vhyrdS1wz+n6tbDwz5RcyDR0ZzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36860700001)(70206006)(426003)(2616005)(47076005)(83380400001)(4744005)(4326008)(40480700001)(70586007)(6666004)(110136005)(316002)(478600001)(54906003)(186003)(16526019)(336012)(1076003)(26005)(44832011)(2906002)(86362001)(81166007)(36756003)(40460700003)(41300700001)(82740400003)(356005)(8676002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 16:58:45.1591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70c55e3-3ddf-4d0a-1088-08db92b091f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The documentation above pds_client_register states that it returns 0 on
success and negative on error. However, it actually returns a positive
client ID on success and negative on error. Fix the documentation to
state exactly that.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 561af8e5b3ea..6787a5fae908 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -11,7 +11,7 @@
  * @pf_pdev:	ptr to the PF driver struct
  * @devname:	name that includes service into, e.g. pds_core.vDPA
  *
- * Return: 0 on success, or
+ * Return: positive client ID (ci) on success, or
  *         negative for error
  */
 int pds_client_register(struct pci_dev *pf_pdev, char *devname)
-- 
2.17.1


