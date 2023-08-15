Return-Path: <netdev+bounces-27717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CF77CFC2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659E9281439
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673B156C0;
	Tue, 15 Aug 2023 15:58:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C01154BE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:58:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB941FD3
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7JpIt8rnxD/APhleTA0RSjj9Jd2PYqQxc8FepYDaNLBqrFPSCPF8ji4LQcxa5hrLDnN0eUaS/2mJKwKuRApPeM1qjRrsosaeyCd3YPVHXN44nEtGmDA8YGJtQvS31/FOnIyq+Z7KLg1E94w1jAUDjfvASabOyGbCxiGmIasrZ1STU1woaj7r8ILGpE0IAXan1D9wW1VJsvT8EGx4t7Fle0fjXB9edLq+U2z/V+NQti/jzm+I6mZNdT2s3QrAvV5BQ+cGSIRrPOmM0J8KXr3nnj7nZblCwwj/gsGp3uql8GqwtmzKVMhyecSRC2Ax846Nfw7BdByo9zakJCpLfmg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Yfr+g9z6+f48ikT2cgkd0PjknPU7zg/wcZ20M/MkUM=;
 b=MYM93Cobutqn2WGAoIsfBvc1doXzXRfZkgyJ3W2axKMYvk+4D16eUSur17Dj9yc6c6OnOp8oEDWpdpGQtm19Tntc4G/ioyRQB+bCMxkrsu74U+yxGiigbmacoVHhzDMEHByMURVDoJC2Ai7VPSLKWMaAE+dCsEUXheJ/vzQmilfvkg23GonDH9yaZKVnuURcKnx0yRa40LzJEY5ulunlfGTWfVuM2wAGPKcBsBh60aBP6KmbwnhA6a5aXlj4wV4ni8eQhHzcWJB1YllI+DaF7+8RxslqSFA+kKXk9sizfk6cz6ZO7d1/tw50Tu6d6pnqzGOWmkBR4GwOFD54p8u/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Yfr+g9z6+f48ikT2cgkd0PjknPU7zg/wcZ20M/MkUM=;
 b=rpE7hEQxxLLykt5JkvkBIbUQkjcvelD3vrkIa3QY+toC6ZGspwAAsclHJkpn9Z9OqX5pfTHKd5y5N6Rx6mCqDgaOcUAHSJWi4PApcrvlGXmrH4Vwe9bwQVFcygUUwrkWwyI7dQrF5yWKSggtH0M4ALXS79GlazJ5c6dIskGtBX8=
Received: from CYXPR03CA0090.namprd03.prod.outlook.com (2603:10b6:930:d3::26)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:57:58 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::74) by CYXPR03CA0090.outlook.office365.com
 (2603:10b6:930:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 15:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 15:57:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 10:57:57 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 15 Aug 2023 10:57:55 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net 1/2] sfc: don't unregister flow_indr if it was never registered
Date: Tue, 15 Aug 2023 16:57:27 +0100
Message-ID: <a81284d7013aba74005277bd81104e4cfbea3f6f.1692114888.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1692114888.git.ecree.xilinx@gmail.com>
References: <cover.1692114888.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e74e790-23a1-4f87-50eb-08db9da86571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UgkfVM2R+3l1bD5rXe+74dSCDpXLLNyZAvinwBWc4E+OQ5sT9ITmn5ENO4L9VaLmVoqgKfREXGLUkREmNodyH/M6WMF+Nl4gvDa0NUp/DkyIFS10w1G9yx5Qe56baDtnttKR1kQFF+sXhEPLnagPDpBRhwoeA9Efty8xofm3b/zwJ86AFXNIp0G0NNc+fN/gDbc7plJiaAOwyqYitY8roazVX9WownRWHygwNO11sZwc9kGQLO8LBBO6HndWPGVHrMwms1W0+GEj3l4PeIswOUUZhQDPEOkP172Xl3DBrUvVxsyZOwbM/dqQiUQAkRnsXTp2TM6wiZK7Afkwxae2vM/XM5w3wnH83IHtCVgJqSAiSN+erjl2tpmeymEoEAAspG2mS2j17iEsjkUdDtGomQgLiWodRjoHCChRGSRMaKUorJIWhDbF77f/ktDOloB5NeO0jZ8R7hExjiIdqUiq3n63kzd6cMcz5XCBAh0g/TqMoVMjjWhcWJ0EPFsx9fmSZ9WOysZ3qVV2MxBsUx7Zm8w2mwPJfUCCC0AHaT6qLLkxmwJ0LcdTmjpTXUlN3l0RdzOxeZgWRZcDablKdnTdBnoUo3q5NmblrTfAadO70TRxF8Apvcs3ORpEjThj7bmacNlVtPd4+sVwnxst2heh1yQiqYR39YwwR3jb7vuOzd0/kqiTz/xyZpmmN0gKzZjI1F0SDO2c61bMLUmIwZR6mA4QHyPFQW4eTbEjdnPec6UeTySknGmLhwTCdRBAjAMopnA+SEYHfCz3Tbg3lJEt8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(36860700001)(356005)(426003)(6666004)(86362001)(36756003)(110136005)(82740400003)(316002)(70206006)(70586007)(4326008)(2876002)(83380400001)(55446002)(47076005)(41300700001)(40480700001)(8676002)(26005)(9686003)(8936002)(81166007)(2906002)(4744005)(40460700003)(5660300002)(54906003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:57:58.3955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e74e790-23a1-4f87-50eb-08db9da86571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

In efx_init_tc(), move the setting of efx->tc->up after the
 flow_indr_dev_register() call, so that if it fails, efx_fini_tc()
 won't call flow_indr_dev_unregister().

Fixes: 5b2e12d51bd8 ("sfc: bind indirect blocks for TC offload on EF100")
Suggested-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 15ebd3973922..fe268b6c1cac 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -1657,10 +1657,10 @@ int efx_init_tc(struct efx_nic *efx)
 	rc = efx_tc_configure_fallback_acts_reps(efx);
 	if (rc)
 		return rc;
-	efx->tc->up = true;
 	rc = flow_indr_dev_register(efx_tc_indr_setup_cb, efx);
 	if (rc)
 		return rc;
+	efx->tc->up = true;
 	return 0;
 }
 

