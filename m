Return-Path: <netdev+bounces-37456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91E7B56DD
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 56B5AB20D03
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C891D539;
	Mon,  2 Oct 2023 15:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C01CFB1
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:45:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7EFD7
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXXwrPyFLFAJ7zhY6356HNHOffpeJEfo5cI1Ou4jzBaD2QFiFbrEhvEeIII4jQrhzA7AaaN09FJGX2OuUUnJTlkADCRNQ9iZW74jlXRVPoNEw/CxS724BzChZqfT7Fr16YZio1sXY0kTl0OFwmnWbeH3olA8lDtOuK9CoW4YMSMACqu/Ib4B7gvLXH5myLAzZoAYO5LAG4eY4aDnUbA2CQrBsH8qFeTe0kLNYxboXKdW9T6fB+2lEltJXkVbe550OufWYo2MP9h7kEzGwpNGvEFdhloUZ5wz+pnpsfQZWYarmmOwyfFqF2vNBIavOUWmdt6SHXLpIwCiQp7g2F+onQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5DAjSOY17WUdOmUPxr3hoZP87K1+hN/zKiK0eR0Oag=;
 b=ClTeHHn130A8rQ1JtcxfJv7Gchlx/e7y1s774Zqlu9u4YqfEWjpwOa/P6Sfakn3Ejtm7GMfLnnytVWJdLmw3nlO392tmMqn6CH5pR2Vvsnfs5cfkW3mli84AdYME/RVeZN77OPA4dPZ8uVzWoTcCMwMsMRHDQcjDbsi8vaeyxBu56pOQweETYo+wM0p191PJkPUY1Wp9DQRy6S8StRyGKXYtPlGq7Ar2O4eFaPSkUtAKeKEcz5tSQx7KYqeFHHm7N3JP0wyH0/G2HF12S1Tw46AGbnYcKHh3/EGvZ2zbjYsGE+IRT+V3psZKK6X6FX0K19JH8vysGFz9we9+m4IdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5DAjSOY17WUdOmUPxr3hoZP87K1+hN/zKiK0eR0Oag=;
 b=nnKIvMVJ/WdCbkE9XXM+2gxx1FuDIQwnD3dLuDC0PvAzJISEohySwDJaNClQE7jcTjJyUicfi8vSPHw3+Ieq6iMuJ81jAcTIKYC9S1BW37qjL7Fus3h0loUKVHCEixsypZJYbjE68tEPujoRAdzBvGA8pPh22ZrrdLpQSn2jmL8=
Received: from DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 15:45:47 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::e6) by DM6PR14CA0064.outlook.office365.com
 (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 15:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 15:45:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:45 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:44 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 2/4] sfc: offload foreign RHS rules without an encap match
Date: Mon, 2 Oct 2023 16:44:42 +0100
Message-ID: <b54a1756ec5c64580aadc68f191b59c9280b6dd8.1696261222.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1696261222.git.ecree.xilinx@gmail.com>
References: <cover.1696261222.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4941:EE_
X-MS-Office365-Filtering-Correlation-Id: 062d1f15-f1f0-4a06-9642-08dbc35ea509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	93NYhX1UHK1BqkcAxCJ5Kkk0tU41wz6eZSdZf3h+w+qZkd2ln0gDfHoQwQ5qwEufkmeiRNibSfAaE2l8PZ/iDssZ4tNtVeC+9M142JEMQoi8IqQjjND2DY4rirwxR1GEZcbimd8OH3Ibn7upCkJtZHZqMqqMOCk1IY00QBC7ro3wEXZikuwUQmyaQ/6wMz+KbU0V1hKnwyyIvPhChG14j1DJMV2kAU8sEW4k9x2+gCIPh4vpx4r2ptqkJQOqUk9bzYKJqFD783uIuE7pDmZF7Go3y8PJlbIyeOf8s/yQSi9d9T8vSRc6wgBixBLk08zBLxmhBWdiPUjUHTUcxmC3t3u3/NVrcQFfThO/tio3LC6c1eirBPiflfHrUhYMDDA71rGPXe2ig1sSKtonGjkEvRQg0nX62acm58ZnaZdJifHsnrb1RhFBXxrSd0rLxOKg+kqcfgwdoj9zIcL3rvRzfCetqttgtndVnd9jA6qv5GfSlDO5vDZEZ1oqKGcb1D/Hcqr/VlrGanuS+309Z5+VuNBQ8y+FQwn3oDtIpxZiAfGlgB0lBdFNMGCy80xt+6Dyr1F09huSDRH2jBe3d/D1+kylJVid+5kjb9ozpz8XlS4JroWgdEOgrQ+nhn/D9q/S3p0cFciQ36SuoAVe3agSbtO78ew89kzCWYE8Ai1+U3fgjfUXszW/qnrAW++1MHdfTPudmEf8Go3Xm1U+UpDoRLDlZdY9h0n2HLxEWFIMJWrlW7Hd27pYuEOG1PVpv+rdSvgPonHO8TwCTs9o0Rn4tQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(478600001)(47076005)(81166007)(36860700001)(55446002)(86362001)(356005)(82740400003)(41300700001)(2876002)(2906002)(426003)(9686003)(336012)(83380400001)(26005)(36756003)(70586007)(54906003)(5660300002)(70206006)(316002)(110136005)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:46.5174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062d1f15-f1f0-4a06-9642-08dbc35ea509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Normally, if a TC filter on a tunnel netdev does not match on any
 encap fields, we decline to offload it, as it cannot meet our
 requirement for a <sip,dip,dport> tuple for the encap match.
However, if the rule has a nonzero chain_index, then for a packet to
 reach the rule, it must already have matched a LHS rule which will
 have included an encap match and determined the tunnel type, so in
 that case we can offload the right-hand-side rule.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 257bec75e952..f4172fc6bd4f 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1683,7 +1683,7 @@ static int efx_tc_flower_replace_foreign(struct efx_nic *efx,
 						      extack);
 		if (rc)
 			goto release;
-	} else {
+	} else if (!tc->common.chain_index) {
 		/* This is not a tunnel decap rule, ignore it */
 		netif_dbg(efx, drv, efx->net_dev,
 			  "Ignoring foreign filter without encap match\n");

