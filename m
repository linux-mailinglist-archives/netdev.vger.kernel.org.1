Return-Path: <netdev+bounces-37453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130567B56D9
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 67364282475
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52761CFAB;
	Mon,  2 Oct 2023 15:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6763B
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:45:30 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE0AC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1fG3Kw6RspEilMpLT64z5Txgdgo8Alska4YfTRnJu7qojQx+JTFesqwn2U+O7O79HArhfweDEQp7R/NzNRIKzugUuXwKdiX1apu0IT/qoFirQWBjPuVPINM2LF7TEnlKZeGYUQyo9iKhgHMZniopyBFZSt07DCnODiYMRp8xFTU1ULicM2DDfUfp01wQM5YozwLh1c7yXUcq+2rmgxWgL1WkqdxlUunLgXdI72UH3IVVq5HJ+vgsCPPTseoqjhhi/e1OyDgi5uc3eccJN4c+1c0GD65UODRnyHgU+58dMYz2f8qYglHig+L7cdPWqU9wcPskjc0CdXRwvoNycql8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnHClOLwqMyBCE61A06YZ0GeLvK6XiYrvvrA/KodcP0=;
 b=RANA9kEjKknWLW/7sO7RnPvQxAd5qecsDHMQYHzgl3R/xnVfBlk/4776g7Kryuq7EhM/oYhPAylctFqio8N6ClW/oBl0fu+XWe/HtfqHSbFLTk0LFltY3B/i4QPIZSyMw5GUNaG2l1TraZVn1aNZUBzMQH25CDo9Ud4XD+3m45eO58Hs4prcWMx6RfE0mboTgaQsnSBLt6YdNNdEHsewjMPSwoGWbWmHqD47U49rqiPPQJiVVpgeGUlRyB4i+sn6MNbGJyoxMG6wRBxUoaq7CPTwQMXkZGelEL5nmSRZSuQtg1AGdTcv7P2EZqWO1+JTp23C0z1AXpogc98e0Yky7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnHClOLwqMyBCE61A06YZ0GeLvK6XiYrvvrA/KodcP0=;
 b=tD0VSEpcfMGZtAT4H7vmcd4AcLQyd1lv0jHEqYEhHiKcYeD/j7prgcBwlmRTmsWbzk0xX//PlcFpp7k98lSZoy1DzKfR74XHefr9w9Qm5JAklIXNM+iGBDRX5E2siGtgaJ4doJYqs7pgBUq9WocR6zN+giUmp4fovxp7TC+RHfk=
Received: from CY8PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:4f::22)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Mon, 2 Oct
 2023 15:45:26 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::57) by CY8PR10CA0005.outlook.office365.com
 (2603:10b6:930:4f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31 via Frontend
 Transport; Mon, 2 Oct 2023 15:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 2 Oct 2023 15:45:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 10:45:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 08:45:24 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 2 Oct 2023 10:45:23 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 0/4] sfc: conntrack offload for tunnels
Date: Mon, 2 Oct 2023 16:44:40 +0100
Message-ID: <cover.1696261222.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: d450866b-a27f-467a-0740-08dbc35e98c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HPChyoz2ZpCE8NRWF4VXeaWdLmaAa1o+K6/ATqgDgyTRwaaL8bXyM0gvIw3KjegCcjS8NDyNGWsoYcmDgJ6pcdSQpLhNjrzKXNL0LfBKacYSjUSTDUw8Tzgb6HH1gHlx4P8r6ZBVwKS+KKDSIzF2V4fDZgNVLhuIQsTQwpDg+hiO8G5zFG6QaQ2TlCq4chPW0fVBwwXMJOZaMSJ5jz8u6l+MV0m7h3jk4jZDK7mUprd82MZIRboQRF4HQXqqtmhQs6mlJjOu/H5zNSyoJ1hq7IRBww/TJJmP5gb3QAN8cF31+aGItWFCUnKGXAxk2Vna83mMbLovq1FHShrvWuxw6kEgZBs/vDdQPcVdMjtzwVDbHlKfK+jU/JRzXjBKXe/wc2gPdd0nLYEgtffF8h5hPnfZ0IIEw/8gJ5vCUeMWApOs9SAGNgWgiem+gl9slYfbhnihV038sbrUOiWkB7gxzkDEV/mEYPElViwHEqikvv24HnIO4aP8YwYQZ4RAicmooWGdyDYLx/6dKlufM6lqiZRrqEy3cbj8su/Ye4on+Xh/i+GvKngDBbyDFAGjbW9qzXCtM27kTTECbDztCA8KU+qOdPoS49ET5seGyJ9YEvPbfGXqn+HwTdNavlRuwI3NMmt8DnO1crokX83oxK6t44Rv5CCQS2G2Q4W+BDSn3/A/rxT/of6u4Ab4VOHmbFKXBMZroW0ybma7aeCNoBBqqoxxI9T3R4tkAHjKUrr9zKl7MxY/YIqewILJ7eyAsDC+AxIEpzN4BIyTWZ0Ct3+ZqQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(83380400001)(40480700001)(426003)(336012)(2906002)(41300700001)(2876002)(86362001)(356005)(36756003)(54906003)(40460700003)(81166007)(478600001)(6666004)(82740400003)(316002)(9686003)(70586007)(110136005)(70206006)(55446002)(4326008)(47076005)(8676002)(36860700001)(5660300002)(26005)(4744005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:45:25.9223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d450866b-a27f-467a-0740-08dbc35e98c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

This series adds support for offloading TC flower rules which require
 both connection tracking and tunnel decapsulation.  Depending on the
 match keys required, the left-hand-side rule may go in either the
 Outer Rule table or the Action Rule table.

Edward Cree (4):
  sfc: support TC left-hand-side rules on foreign netdevs
  sfc: offload foreign RHS rules without an encap match
  sfc: ensure an extack msg from efx_tc_flower_replace_foreign
    EOPNOTSUPPs
  sfc: support TC rules which require OR-AR-CT-AR flow

 drivers/net/ethernet/sfc/mae.c |  59 +++++-
 drivers/net/ethernet/sfc/tc.c  | 329 ++++++++++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/tc.h  |   6 +
 3 files changed, 388 insertions(+), 6 deletions(-)


