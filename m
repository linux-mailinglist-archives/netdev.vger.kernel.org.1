Return-Path: <netdev+bounces-49774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDCE7F36B8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D202820CA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4115B1ED;
	Tue, 21 Nov 2023 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0dsHyfb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2391
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU6sBxvYnPgRCgtriW5Ysc2APjG0TUZdTCJx2SqoSyc2t9sCpwJPhhA6f+zXJR8r+NeiIDNJ/SucE19cMvO6vFtY05Ttw1EKHs3/CfpfSLgPYApfnzEco7W7tXb/fiUrwsCxQmYNb8zSv49233n7WJvS1f12rcs7z9jFKZhaFxLLpgS10WITfYFOEVvlqWbDxNnDIx+2xWWjZoFLn9h67laET0zx8Ca1aZxhdFpJT5JeU01uH8N1e+mYami988An8R0hoL7HTchUmS4mJZLAjDOHEFD1tMzkUIjbux083+SCtf1r2hCKq0ZlL+ZF+BIoaAC6R3gQnhhjIxYAdOdl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VouiCzJk54vILe4YBARIRXkzpdja0FO4XHkZDuPVrmw=;
 b=oOm38SflMRSUFCOyO6+zZYEU8h63/HOj84GCj3I/M29OfTvhyCcn8jqi9RH2cJ3c/+cu0BFYb0kMNfjRUpqywMnbb2jQo1B2Vlm/IUI4dPTpUTkvN+GoVcH2K8fuzbJ0dysMnkE83TtsKLQRzOnrh7a9ecK60Jcp0mACT/z/NRjMe2/dy9a2KZAPsX6OVuitCAiTX96e/VjVxeaZ+cKHK9tC0W2GNUHJguDPqCIw/P5mUdlPSlPn9TVd8Z3XB2p9MHPgLVvbNGPLRQ7pRPcActLT4hdJ2ZAj49XYGeU9aomuhbwJaFc5a59SaNUUhenXnCrUkVyrT+v9xs4zoGN+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VouiCzJk54vILe4YBARIRXkzpdja0FO4XHkZDuPVrmw=;
 b=J0dsHyfb6Yf4TxSDrNrIZBdr59tDOP+2lldHWe/RxkTlXxXxKtAnS50p4wBk8TZ4Wv1oNtuGU/p5sxAaIYiyAGHcOZeQaL2s3UE+jflfTEaQQ/xzQbJLJ4N2THu0zgB1rMhkMGPUo3WtLBStDndwyNiY2jeabvAXHS8CXj1S0eo=
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 19:15:23 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c2) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 19:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 19:15:23 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 13:15:20 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 2/3] amd-xgbe: handle the corner-case during tx completion
Date: Wed, 22 Nov 2023 00:44:34 +0530
Message-ID: <20231121191435.4049995-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2f24b8-9741-4fa6-743e-08dbeac6361e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lmpLRI8ms1oKC5seBt3P3kGVAq9ESvVrrsUZ7nf3y7qcVP6FHMLitmD9XJHeKBXI3epzRn1Qjeyrjiig7Ij1tnlrtQVBfNHtLnldLAj6k5ptePzjQppq0euHS/8ECLya4GnIkhByvwjv6P1NZub7urs8cydSQL/Y3IxME6XTiMKMFUXPw6NOosTFfkpG2OkeO2UR7qOrsUn4rGFs8/n+DACG4zIVYaF/uAf+KN1zPa2P903IRy5bvnqFDU+kL3OULsIEDDnkrHzXj2DlPtSWAioiXa30W/EQl74Ob1GOkcJL/ap9ocF1GcWsX3F70RhHZNnZyYmYY3kt3003XzJFqBpRwnYbXgPzlKWTltX/HBv63S5h97EY1t+gbiErKXiWnZq04YBTm+KjzTfuoxiDGyJmfqItZZwQxeB+dSq3W4Xwd2gMQw9uNIRUYE8uPs5PQq1n2MgkqfWndxYzEo/1EbeRCgPehrox8w7eoZJADBnRQCMiaGvuAypLH0JsqQ8z/FGTHF1V1uNV5zgCp9pCaycsBdWW0IdlY5Sr5OwvSA4QxtqyI+ia0QaKZ02gKcNW4g/LSXQ+hY4MSShMKI5mqlJhxtwgye8WlayqctNLjQZhvG8+RWwqqvuR2wrb7aI5uizVwkuvOWMmKM68q7043UXaLy8XF+X8QDgtdQxKvkUHnbZsZiZlPKH54owfgNFjY92NyrwmYtn+sel2NGQY0iTW6Q6cmO0FDxaRAjJFMda7qu0B2JKSCwyjQSgyUQRUaS1lGnu9JcQucHu1+g7Kzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(36860700001)(40460700003)(70206006)(70586007)(54906003)(36756003)(82740400003)(356005)(81166007)(86362001)(6666004)(16526019)(83380400001)(26005)(336012)(1076003)(426003)(2616005)(7696005)(2906002)(478600001)(6916009)(316002)(8676002)(4326008)(5660300002)(47076005)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 19:15:23.4353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2f24b8-9741-4fa6-743e-08dbeac6361e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

The existing implementation uses software logic to accumulate tx
completions until the specified time (1ms) is met and then poll them.
However, there exists a tiny gap which leads to a race between
resetting and checking the tx_activate flag. Due to this the tx
completions are not reported to upper layer and tx queue timeout
kicks-in restarting the device.

To address this, introduce a tx cleanup mechanism as part of the
periodic maintenance process.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 614c0278419b..6b73648b3779 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -682,10 +682,24 @@ static void xgbe_service(struct work_struct *work)
 static void xgbe_service_timer(struct timer_list *t)
 {
 	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
+	struct xgbe_channel *channel;
+	unsigned int i;
 
 	queue_work(pdata->dev_workqueue, &pdata->service_work);
 
 	mod_timer(&pdata->service_timer, jiffies + HZ);
+
+	if (!pdata->tx_usecs)
+		return;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		channel = pdata->channel[i];
+		if (!channel->tx_ring || channel->tx_timer_active)
+			break;
+		channel->tx_timer_active = 1;
+		mod_timer(&channel->tx_timer,
+			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
+	}
 }
 
 static void xgbe_init_timers(struct xgbe_prv_data *pdata)
-- 
2.25.1


