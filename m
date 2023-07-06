Return-Path: <netdev+bounces-15916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410D74A56A
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 23:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6506F1C20ED7
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 21:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A1F14AA5;
	Thu,  6 Jul 2023 20:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523863BA
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 20:59:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::607])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FA1999
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 13:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzdbbsKnP37WkTItJOFe/t255trkvAG64l93AIV0aqkb2iz+OBqoOp0ycOoyEs0XhSsrCf6IYbkD4a3Hm2mOAxEkiDmswLUq7DYhJ8s6eSziFErzTgUY4PQkbbVdUN0fEkkbr6+x9RdbhdsUm9pbobcHiypirO4ZmnbWEnTjYtCZmGBqahKWaVtzEzksnyQRDxMg34aXwxqsZnR2O9/sfKXk/pXErTso44MQrYLLkNQ8o89jKhuMwmALQJH/yszfVRss0gDZQZYO64FR/fmkX6IOawOHUIzVUpNh7gx/gMqEnwVOozquILE5HKXrgn6y1P7hxFChK5PpZSVCBEej3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwtbGqUrVFZ9VBQIRORabm2DJNT/qMErwqLxdSXSNfU=;
 b=Cb0Ffvhb/FxyOr3I1pifWETSVyx/bpyZLtiK4eeQ38Tt7/pmDyvzTTz6nZrC0nE0+1In2zrTQnXbVqkle+tLd39MDSJXTp7jbmcKyqhkVIux3oq5gly0wC7BypUaD1v2i3PMmfnT5daH7WUUbkV49snupVH2UnoMP05sXD5yAywQzlUQxxdHm3vmTYdlH2y01mu6mXkQHqTkufyru7hPlYy8BqYaWy/8Wb6fL9VneExVUR5ZDzIVLOyVqTTqZwC9ZLksmzZr4yvMpLsH9Dh1Pj5A4E03yFMQTLQWrl2TV48JYfuj+7tJDkU+A3fQvoptsWD2HXjSLyOY1TMQZ6PzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwtbGqUrVFZ9VBQIRORabm2DJNT/qMErwqLxdSXSNfU=;
 b=Ro2afdBQbdIZlfSDMHVaF4acK5nqfHbc/gkSkQ9GQ9NxnmdmV0bPeeULiucFCqMbNRPFX8w5W/PSc5cDQja5ZivtKoOC7B5zkB4GrO5NvTErtbUDKu08qzAFa0Q068NSs2j7wSkQRxuYqnZIqz8rGz6wPglki3zzam2oAdKIC84=
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 20:59:48 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::6f) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13 via Frontend
 Transport; Thu, 6 Jul 2023 20:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 20:59:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 6 Jul
 2023 15:59:45 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net] ionic: remove dead device fail path
Date: Thu, 6 Jul 2023 13:59:24 -0700
Message-ID: <20230706205924.58103-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eaa649e-e7c2-4118-5add-08db7e63ee73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z57jtfXmVG/nrZabzq0vaz9DoZcgRrDLs010qcpsUAYmTidCl8AZt10vLH8366t5IwSaCfa9qoWrGnYkoT55kFEPJ9+7ADacB8eqJmVX8Q2APr3QfUxURLOWrRjrxVxTDlI1XV+M9VzRZT80g8xQ5QpLFJi6cmQwvUTNcQKTVSQtPF1PC9QzV5lrPbDB93A16rWUv4VYJ/Zkg0u5dWZFlbzCLZXAX6FWF56cYQHZjEfIgq8GuYvHNa3uTQaA1ibzWGA1nP0T3kBJuaF4CaoaYe301rcwNnC3yIDVspIDYcOr8Dlqh+BoDqVKl6wjeQis2fi81l6QLWLfqPge0WHU/6J2zpLviiasS8DDID0CbMOC+19UNzLP4OBUYZhgB5Tv9Dwu4GyFhsfa/3+EpyzA7bBBQb2bSX/XnoNQERnkIQEAQ/j35Y15uvKhx2Na1D00qIK3PyCxxag2XvRvDG+iywmlnZrhMfO+3MKXMWnTCtUNrtsZNsL80JtwthMU8dDz4Yoi8R28X92v+03ScODg/viMf9395uDF196tEgoTCAtC9XXZrj9ezYvlBsZZQumBCHe8T97gnl4kJr2rkielCQG+U1knXuSwH6aef/35FxMenx3K4qCcl+UNqUtuNe0hIRpUtWJKYvnYyT8eUYWhS09hBGPt6vAgsWawPgbogmHAeK18EDX6sTtkIvHTv846XQpwJ2IFc/Vu51cx/fvednjv11qQI5hgIYcPS/2jaKrh7Og9ZXgBVU9n8cmY8Ehh8zd9oQkfthkUQJBHd2di0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(70586007)(4326008)(70206006)(2616005)(81166007)(47076005)(356005)(82740400003)(82310400005)(86362001)(186003)(1076003)(36860700001)(16526019)(26005)(83380400001)(426003)(336012)(478600001)(6666004)(54906003)(40480700001)(110136005)(41300700001)(36756003)(8936002)(44832011)(8676002)(5660300002)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 20:59:46.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eaa649e-e7c2-4118-5add-08db7e63ee73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the probe error path code that leaves the driver bound
to the device, but with essentially a dead device.  This was
useful maybe twice early in the driver's life and no longer
makes sense to keep.

Fixes: 30a1e6d0f8e2 ("ionic: keep ionic dev on lif init fail")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b8678da1cce5..ab7d217b98b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -353,12 +353,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
-	pci_clear_master(pdev);
-	/* Don't fail the probe for these errors, keep
-	 * the hw interface around for inspection
-	 */
-	return 0;
-
 err_out_unmap_bars:
 	ionic_unmap_bars(ionic);
 err_out_pci_release_regions:
-- 
2.17.1


