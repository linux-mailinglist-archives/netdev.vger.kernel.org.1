Return-Path: <netdev+bounces-72565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C074858880
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CA31F258C9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DF148307;
	Fri, 16 Feb 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="33fl6Aho"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377B1419A2
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122620; cv=fail; b=O5RMfSrUIpIO5ebJ//9b+4W2A33Hn5LwDj2xvJD38Agvg0qF2A4SjUFIOcFYx7bvuJUEUdSeEfIsrGjV1bQcQq8BFvuNbgcOhOTrA2h26e6vCRzzvJtvW+o/07uO8y/+34DKslZzSYrtkSG1HY1ZT4M+dx331SCBrbFjn6qNRcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122620; c=relaxed/simple;
	bh=BnTcy6xLoXV2rMFeJw8mfgSRWRJ/1ArvQ6xNCNFbM44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rff4BNx1SoH8Q7ZCSRYp//QNGFrS9c0hmgfLNzukfKHObpedgy8gbj43mQO0sD8r/uvoEaK/ZP4A0EuxtiLOlGGEYW8DyZ8mV2iQSJlJoef1ASpNGzauhrOFVY3qpvF3JC5HecbvyqhdwYRxn6ZNjtGSCo+Bu8lBbnLaE/PbF10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=33fl6Aho; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpHsj0Rh8N/Vwyn+R8jHbHyjgEvWVNjDxaZAGODLzrIBJBwOv0l1/3pzL2daaM0amx5+8EtAiULKCr7RKitTixIR837jDqFP32kxWyfLhM3z7zqM11jZ03AL60FXE5OWMJkPz8V2gSaQCAtDeufVGSqf8/3qgoPv/Q0RN6uSuYrXdIQ3Y7ve4Uqj2kB/o49MmdeaBYKbiGVMHQX7mN3gPsT7ASsR7CTSEEqrF26InIObH3p90wh/rLSDkEckTUtLSO2yYC7ZYyQnUjwjDpMwxlZkw+DnJCdVO82tGPbVJ0PG49JA+HcTVHptcXxjRpWJOcr5ElGLBrrD4a9smbUF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXlY++1h3cx+kUUTibPDhrkD/6e911+Sk5WWTPfZCTQ=;
 b=lwVm2XMtq+fqJfeNoqwrUJGaWIOwQ8qHw8kNhkonOdcZ4ZTMh8HL+M2u5HVlvrf7pE0YBIgXngb0y4iyN7RRfD7djiKrEoeq2B0+VK3W3D2LHnfeeilczj77WR9513Kf5MIvYIMoFmhBRjcafT1lguNEkNF3SKctgfYNyZ+dghyMhNjtcCxjxzJUzzMXSBMM6OxM6rGP3Sw9QzsMSkDzDzXdmGXgLM11QAYsqI7gQKY+2/ilz/wcqjoEPxp4yqbIJfm1AbbOG1TD9YbuGkAGe+ddsgVZiTi9nDFvVs1YzE8OyhH8avzq6tE++6Dn/GKOXvhNkKuWKsnVJMh2uuXt7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXlY++1h3cx+kUUTibPDhrkD/6e911+Sk5WWTPfZCTQ=;
 b=33fl6AhoXRhil8FCIQnJ2Q7Mg6TmfWWHhft2vR94yLknFoXx5JNGWbYrjWEyD8SvKy03I6jj3W3ZY3s1MgEZaN0+Go89XUEIQ5KuCMZlQZVowm/Ga06Swd36LkWlnyoDqjfSxFmIPbcMiAWFqWWQ31BS+/G7yA2hqjDQwGc3XOQ=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 22:30:16 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::86) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 22:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:30:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:30:14 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/3] pds_core: delete VF dev on reset
Date: Fri, 16 Feb 2024 14:29:51 -0800
Message-ID: <20240216222952.72400-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216222952.72400-1-shannon.nelson@amd.com>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: a461c47f-06c7-4809-cebe-08dc2f3ed964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/4vPQoP8jRXy/6bhktZbzcVb4M1JKmvxgZJy7Flj52Kh6qXat4D+Gg7PTPKUyryZ6LMCPnkREMPRdeiaDi0FCG3wMD+954QQbVVUyQfM5S5SxM2EwbQON6nhpgQg2awkuxpC/z4AkWhPAV/tji829eOhd1OLAe5DTvP4XxgGXjry5HAdmhScVsLvxi7hFl/olZcKbwU1dw62dGVQP3oPMG9IZYQ0Lfj35Xw25ksnIk/miY6BPo5pZDHHRI1obmqZLSaH0+Np1d6K4thC0JR0NzXBo/FSR5OtLB1HXnUuR3G7nL2y4v98ugy4RlHqvdKSUE8eIHausrSFRh6RNtNjm3Y12w8ZqGBoYo4AUs0OpbWpmEYHhiCmbQn7ZbTikCYR8B2Jsf/H9dxuC9DzpzBYeUrP2V2u4Fhs+pAd72hWBMazTyKdNA+oVekHvm1iBVP88DZigWKhSUJJOdd3UUdlUYlYtMX8v659QoXs0C0ldhtngwJfkh/HiOW9uloRQTff4QBuynjVBmVRhtJQgLZzKriZKxE4ssMyP8BJ38W8bN9YGgwG+kPPGR5EcEbDpnHU0ljXNc9HYUvCvRoSlszGTHE/x62Hqmgxg0qgGxpcjetWHPDWa5pcFjXgmXK2P8HV1hBRlF7MSuKwHVX8IP+7EXe19s72SqJhgKdJRVkOqcE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(36860700004)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(86362001)(54906003)(36756003)(110136005)(6666004)(316002)(356005)(81166007)(82740400003)(2906002)(44832011)(5660300002)(8676002)(4326008)(8936002)(70206006)(70586007)(2616005)(1076003)(83380400001)(16526019)(478600001)(26005)(41300700001)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:30:15.9789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a461c47f-06c7-4809-cebe-08dc2f3ed964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585

When the VF is hit with a reset, remove the aux device in
the prepare for reset and try to restore it after the reset.
The userland mechanics will need to recover and rebuild whatever
uses the device afterwards.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 18 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c   | 16 ++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172..a3c79848a69a 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -184,6 +184,9 @@ int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
 	struct pds_auxiliary_dev *padev;
 	int err = 0;
 
+	if (!cf)
+		return -ENODEV;
+
 	mutex_lock(&pf->config_lock);
 
 	padev = pf->vfs[cf->vf_id].padev;
@@ -202,14 +205,27 @@ int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
 int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 {
 	struct pds_auxiliary_dev *padev;
-	enum pds_core_vif_types vt;
 	char devname[PDS_DEVNAME_LEN];
+	enum pds_core_vif_types vt;
+	unsigned long mask;
 	u16 vt_support;
 	int client_id;
 	int err = 0;
 
+	if (!cf)
+		return -ENODEV;
+
 	mutex_lock(&pf->config_lock);
 
+	mask = BIT_ULL(PDSC_S_FW_DEAD) |
+	       BIT_ULL(PDSC_S_STOPPING_DRIVER);
+	if (cf->state & mask) {
+		dev_err(pf->dev, "%s: can't add dev, VF client in bad state %#lx\n",
+			__func__, cf->state);
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
 	/* We only support vDPA so far, so it is the only one to
 	 * be verified that it is available in the Core device and
 	 * enabled in the devlink param.  In the future this might
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index e10451a5a89b..82901a847306 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -476,6 +476,14 @@ void pdsc_reset_prepare(struct pci_dev *pdev)
 	pdsc_stop_health_thread(pdsc);
 	pdsc_fw_down(pdsc);
 
+	if (pdev->is_virtfn) {
+		struct pdsc *pf;
+
+		pf = pdsc_get_pf_struct(pdsc->pdev);
+		if (!IS_ERR(pf))
+			pdsc_auxbus_dev_del(pdsc, pf);
+	}
+
 	pdsc_unmap_bars(pdsc);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -511,6 +519,14 @@ void pdsc_reset_done(struct pci_dev *pdev)
 
 	pdsc_fw_up(pdsc);
 	pdsc_restart_health_thread(pdsc);
+
+	if (pdev->is_virtfn) {
+		struct pdsc *pf;
+
+		pf = pdsc_get_pf_struct(pdsc->pdev);
+		if (!IS_ERR(pf))
+			pdsc_auxbus_dev_add(pdsc, pf);
+	}
 }
 
 static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
-- 
2.17.1


