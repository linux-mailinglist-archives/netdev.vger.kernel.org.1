Return-Path: <netdev+bounces-30317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97232786DD2
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BA41C20DE4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04618DF59;
	Thu, 24 Aug 2023 11:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6901AD57
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:28:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::622])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D37E59
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 04:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMds9bzKotsyudW4/X5t4zRQBp493QGkjmC4/MGH4tgyRk4M5dCol9Sqn9NpBLtisNRKIJvfaXyNQZWLjgT5JAQlKBk4bqdiEFXa7fyjA175MqYIUw6la8go3VPIhwAshaLsKsyxywd08HEL7Bhjpw+ExRss9nLIg4YnFVpuszs+xAqx/3mCbOX6v9WMdKJ2JLzqJfX56pU7GZ0Yyexn3Rfq3dPlxaxaY++vdFTPEe5rUQ+Pc0QHP5uaZqD0diTxyL5qhvIi97cl5C1T8My0t0GYL0ooMvvG3MFa//Xjz4g+98DATbHwNRrnFFKZf0oN+4NQMwYGbcXMnW0cTaTr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OlmF49vWjpeyZDv9R1tDE+i5S1ue/5/auzcppkbBEs=;
 b=KwVDWdpanSxRSgx8W/kw1A7vyPS57WI2OhGtPSVDxBKAhr8rvItdBv6pt/RnJScYIem3gL8nTa5IhOIzDJ9HWL8lIcqThXSZxbQkilPG/8n7Bx+NdsTio34vejvFC11IbuUUVy/SQw2uK2qpIUmg3LklvXExj5kr6VE/pMjDwV0bD10Aw94sdYfE7dRPdgHzSQj3cIsGMIgUFmHCwZKgl03d/yN6i6Ss0VOmSM6LhsRr/IuFIm4WKa2a6r/pwsrbgyp8qgXo3+z6yUtxgQQreZQuikSKeFXncPkoOW4xXvStUh4Uh705U0YJwzh9Vtl8p80m/gLed80KguEhZ2BX6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OlmF49vWjpeyZDv9R1tDE+i5S1ue/5/auzcppkbBEs=;
 b=ze3QDMN2DM48KkVQr7vaA7EgWJ/9B1xy66mgaPGq5m7VIxIwd6oLoXzueZLwYTcyc3dOqdHDV/S17rSfq5n4eNLsDkMtn3e7ZKXpQyI0shsUbs+uJscc8kEv4cDH3h26r2DFkFXp/+NKcjgsEjKWbXgQNUnLukVNt4gf8G2pEUs=
Received: from MW4PR03CA0211.namprd03.prod.outlook.com (2603:10b6:303:b9::6)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 11:28:52 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::b0) by MW4PR03CA0211.outlook.office365.com
 (2603:10b6:303:b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 11:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 11:28:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 06:28:51 -0500
Received: from xcbpieterj41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 24 Aug 2023 06:28:50 -0500
From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next v2 0/6] sfc: introduce eth, ipv4 and ipv6 pedit offloads
Date: Thu, 24 Aug 2023 12:28:36 +0100
Message-ID: <20230824112842.47883-1-pieter.jansen-van-vuuren@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d802717-d578-456f-3fd6-08dba4954b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHslhcDQ5i5Lr4wE7EnKPnfF1phO9LXC9g+W2tBclKi4Dv0ud33sTAQa++vd+7EcjIWT5uyVOzrfrwUOP6NSEu/IO3LFvBUSW2CH7wMbOfkvJhIVy0Si16Aed5PrkXUslrKdaFI8ZJVeDkrHGURia6yobr2bgME1Zr+ezu9XY44kuFq3q+otu6Nt2mhsIqRakW5oHRiBBlDvTSpASeglunCNs7MQBXqYl5qR7JlUT/UEnyb4vHu1SMszyxfo/iTt4ocQXfXICW6oRzKwRfPrPAauj0/k491cBV61ChAawdwYcNAnWTTeiXvS/lP7P+wzryvCdW/Sfvh3N9vjSqE4wxsUT3EoxxPHnuHPD5UiOQ+0riMBYvfaPRXFoROSzqwN6CZLgwxGjuyZq46g4Ng1SlUNzsD2wtBeRqEDl7Mu2RM7Sz+lnT+J9ZXgfoJMlULWvEB5cx4QM7Nb2SFe3+5q17MEecvLL9hC0WIygI2iWN1RmIwvnAluVZY6TB+LA5ntxLizQ2sXoSXlazRhCjdnwxZWW6pcMayztg7VbN3hEEzuv0G/jIBp2gV4iiwQqJHhD4MPEHwg8AIzlK5wctbLk8e/T4I1/lti8mboiis9ZYFYDN0f3bxGYhL5wTFHs7b0UrItt2jBxB1yE7kZAWx/yjyLbZka0sF8X0BZjmkJLE7v4XGhzADv3OMHfyduWSiCrR8dirpMZbR4QTO8gVgNDGuZ9xh8yI4U4LLgoTqZOkxTBrL3B1n48SJcr5U6d47W
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70586007)(70206006)(316002)(81166007)(478600001)(110136005)(26005)(36860700001)(356005)(6666004)(40480700001)(82740400003)(41300700001)(86362001)(2906002)(966005)(8676002)(8936002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 11:28:52.2258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d802717-d578-456f-3fd6-08dba4954b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This set introduces mac source and destination pedit set action offloads.
It also adds offload for ipv4 ttl and ipv6 hop limit pedit set action as
well pedit add actions that would result in the same semantics as
decrementing the ttl and hop limit.

v2:
- fix 'efx_tc_mangle' kdoc which was orphaned when adding 'efx_tc_pedit_add'.
- add description of 'match' in 'efx_tc_mangle' kdoc.
- correct some inconsistent kdoc indentation. 

v1: https://lore.kernel.org/netdev/20230823111725.28090-1-pieter.jansen-van-vuuren@amd.com/

Pieter Jansen van Vuuren (6):
  sfc: introduce ethernet pedit set action infrastructure
  sfc: add mac source and destination pedit action offload
  sfc: add decrement ttl by offloading set ipv4 ttl actions
  sfc: add decrement ipv6 hop limit by offloading set hop limit actions
  sfc: introduce pedit add actions on the ipv4 ttl field
  sfc: extend pedit add action to handle decrement ipv6 hop limit

 drivers/net/ethernet/sfc/mae.c |  89 +++++-
 drivers/net/ethernet/sfc/mae.h |   4 +
 drivers/net/ethernet/sfc/tc.c  | 476 +++++++++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/tc.h  |  58 +++-
 4 files changed, 614 insertions(+), 13 deletions(-)

-- 
2.17.1


