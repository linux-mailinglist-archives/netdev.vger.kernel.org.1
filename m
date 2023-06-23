Return-Path: <netdev+bounces-13511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02E73BE8E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CC7281C33
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26D101E7;
	Fri, 23 Jun 2023 18:39:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845FAD30
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 18:39:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::623])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E61BAC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAxmBKTFlFUAtkMgYwsXZsgY8VWwFWGHj2V0LcTnn3CxO/FaNPCzizn6X0EJku1chjhT2Kp/S8+bCzUTrm7dt+Is/QsjVsO37L9Pe7wKiupspYAuWgU8lJTyPbaAiGf6c1qH/RRSjI5ZrRL2oelKjXr/ySqMeny1zmTvZ3SF21J35Bz4uobm4W+rjnKY2RK0xu4i26k9m3FARGt44fRzSwMNV4QcyE6qI4huW1H5LybiGm4nMSOp/+mmRWWDS4lKmnRx81QEau/SKgtEdI7ljTrxBnxev47tz1oii8+PoG/khTsTuJgRMtC1UOQcvMRe2QJaUr/+rp2JtfOFVQOPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjEisxnG+GwU9RC0BFvbFItS7Pln/joGrv2XClXoONg=;
 b=BhrxUZPWcYiDk/veK6DxLseK+3cZuXulfGfE3WJTDtGtxkWDfdHLHnB/4EpgoBWbASsknIUxnxYqtO4PqmN1AwsIIZF0f63NUlw9W9lr//ZypaPNabQGEBGkxSqG+sBFI//eFPd7n3xnqGCxdwgoMcf8TF0OcIAGmjet1NpmTQba2tug6zKL+ZCC3xHyF1GnawAbRXYq95OG7wpVKZtNKFOss7GSG+x1h3RBAHf1ke/lMytF7xHfUAqsYmO2ow4HOlelECj0dpMffZ67KjyVf9h0eX0Lh2WCzeE+Bkw2B0OQdZhA8vQU04sHEPVLfezrp16AYdNmB6LdAjpZlf8arQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjEisxnG+GwU9RC0BFvbFItS7Pln/joGrv2XClXoONg=;
 b=NuyhTz2grbq4SYXx0zW1DircEJFOoF0tqtGbYUQxsJTM1I5xpDVMDboY10TahwyFvoAjBfYmpVwFVlt4RAO6L3KTnsvBfv0KnZo7jU69VDiPHFHg23iao8Cj4wI1Ap9Bz2FV+xYBed4Oolf5xkmtsJLIs4cGYB0Jzl5k3g7hkTI=
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Fri, 23 Jun
 2023 18:39:30 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::e7) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.27 via Frontend
 Transport; Fri, 23 Jun 2023 18:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 18:39:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:39:28 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23 via Frontend
 Transport; Fri, 23 Jun 2023 13:39:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <arnd@arndb.de>
Subject: [PATCH v2 net-next 0/3] sfc: fix unaligned access in loopback selftests
Date: Fri, 23 Jun 2023 19:38:03 +0100
Message-ID: <cover.1687545312.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: e3699ceb-306f-482c-74a0-08db74192dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dt8f7mPj5/a1E7V8qR1mTzmA7+uMuwM60kv+Se+Um0FKJuM2lpo56Nh5f3SI5TbyxBKG38dnppG5yZOqsfoUbBw+1o+02scmL0Y5JsW8D3dBVmW0w1u/LV/bGPJwqn2HFqV196YPvGjjqus2NV2XmF1rltqb/q+2ch7h6wNzqcw6fnzANeuhcX6uec/LLxCPquuwTG+qsOr8XYu+6ZbqAqdHfL066MghpfmDiMMXGUhZEgBAWU+iwFaauAnFLff9nwORcNtoThBLUGCitPJMfzWPSuBWxS9iWw+cbejJ2q1dVo+qLku8z35szPiwrfTm//Kd1ar1EgBJY9vICEqXTbzLnSH0n238lkwi80jm5AflQOJ9fVEfBbxj5HkaQHdDV+E8HwqH0oroAm8NkkgzqlOAjzZuT9MahcsjPKf4hrJSypumNp2ajhhjmCGa6LaAU4bjiWOnjJfuSWoSKrPV0PXIjhKtdVN/v9GiBDYuiHXXLFDn/3b2tkr+6XqViiK078T6Ku1bt1zCQWjlh2AMd7nnkhNTeeys5lgvJKyRnJvjZqvYql1s0EzKvDAQTFg4dgYGDzBevkqiu23DFXND/UEG8kkWzQT33QzkylIGOq0YZxLlHwyNT/GIRs+HHHW2FTCNdK143ocfbFEhTglzSPYov5XwCw3KpJ/YCAQoUNJL+poSsdq/QrT35kfUBqooC0qLRh1MPIac85Ln6uBwV+fW49w3UpPS4D9sX0C7zyz0G3fKrXcefDvDrHdXtSizeGYRY7nc5HJsvO7lIgO5tQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(478600001)(6666004)(36860700001)(336012)(186003)(26005)(9686003)(83380400001)(47076005)(426003)(36756003)(82310400005)(55446002)(86362001)(356005)(81166007)(82740400003)(40480700001)(70206006)(4326008)(70586007)(316002)(8936002)(8676002)(5660300002)(2876002)(41300700001)(54906003)(2906002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:39:29.3896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3699ceb-306f-482c-74a0-08db74192dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Arnd reported that the sfc drivers each define a packed loopback_payload
 structure with an ethernet header followed by an IP header, whereas the
 kernel definition of iphdr specifies that this is 4-byte aligned,
 causing a W=1 warning.
Fix this in each case by adding two bytes of leading padding to the
 struct, taking care that these are not sent on the wire.
Tested on EF10; build-tested on Siena and Falcon.

Changed in v2:
* added __aligned(4) to payload struct definitions (Arnd)
* fixed dodgy whitespace (checkpatch)

Edward Cree (3):
  sfc: use padding to fix alignment in loopback test
  sfc: siena: use padding to fix alignment in loopback test
  sfc: falcon: use padding to fix alignment in loopback test

 drivers/net/ethernet/sfc/falcon/selftest.c | 47 +++++++++++++---------
 drivers/net/ethernet/sfc/selftest.c        | 47 +++++++++++++---------
 drivers/net/ethernet/sfc/siena/selftest.c  | 47 +++++++++++++---------
 3 files changed, 84 insertions(+), 57 deletions(-)


