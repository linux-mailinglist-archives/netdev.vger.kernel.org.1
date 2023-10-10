Return-Path: <netdev+bounces-39566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C47BFD3D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0581C20B53
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696874734A;
	Tue, 10 Oct 2023 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qC9Wb77s"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56F8BFA
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:22:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12FA4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFU0tGFthuK8geOLcP2dMdZFxjUPqBo6fxe9yy38rRTq81F6eDRb32RN7tVRB/2HOFJE3hyMxB3eeVU5cQBCgMtA2LYHi6PvDNKS9lT/bnmNOy9A2cMIMQA/WpA3iCN+qavTBEta0xo4ls+pmxFaYi8Lj+xcS33UJ2bmR07Yop/vZin65qUvAxAYgHx4TOR5eDZH6KaDLzzRwFSWMvgF8EBM+ZdEoNP/PkCj7T0HDwnt5ZmPvfwX+I3JQY4Twb/5e6LKwnB986HIwF9/xYNxvH8vPmx5pjwih6T0gOZsP6or9rTeUd9aVtokB1POPVx9HpMUMF8qcUHzOYy6IzTbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65vOImiqhT9k1lCy3y/fKiCoM6AiMnet7YlVFEMKbkY=;
 b=YF7RxTAr4ss3kyMNvElvPlYhq+OlXNF4Kqa4gPeVWR6nehUbXoTPoIpkz3MFiYSIYw47QEpvG3zxF/KWiYmdxA5/yOB2vrdGXT8qx1b2zwOafIxRoUBWlqg01Zem4D7CLHcuescY9W2v+LJDJGTMuF9CE7P/EhpdcISesk7t3KNowo7Ps4lxZgF4VnLYyrBvR/XEv8H0DdCwgFDMBuM0zsOa/TuDrSsOem9npcLmwOEZVtWdpudeQv6HcTPDpY+Ui5KnfNkIxNm8jyimeuaaHBeYxk638q7li4L/6Q0FAwovSelMS8PMs9rgIT5hVXJdz05nnta20A76uP6keQfG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65vOImiqhT9k1lCy3y/fKiCoM6AiMnet7YlVFEMKbkY=;
 b=qC9Wb77sC8vynX8qct5jYOmbD3C1ONcvpsLSN3xVqFs+x2WCNV7MOZFShJcDYX1y5aG7r/aiXmUSXCn2MivY7I6O0t2LhfHotQRnRSWkPuz8zLqr7wDjw19XnXTGXUpzcEdiQLttkvpVIZ8YByVdr3Os68uXcT3DzlD5bbZDv4Kf138NmVkfY09QMxtuAEFuIkCRB4lzvOOGXyv7PO84OqVF4+cxgsuT7jTt/gxsHNsyCGEV2PJKV7vcHqDcdCWfhQU8qHPRR8rPyNPtGgTXyj2bVfLr1D1W+wNAyfQEWX9zUXjmRHk2svr+4n1e7qDUXh79Nj/eSkQSn/8ejSa20w==
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:22:20 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::64) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 13:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 13:22:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 06:21:55 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 10 Oct 2023 06:21:53 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@gmail.com>, <sriram.yagnaraman@est.tech>,
	<oliver.sang@intel.com>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] selftests: fib_tests: Fixes for multipath list receive tests
Date: Tue, 10 Oct 2023 16:21:11 +0300
Message-ID: <20231010132113.3014691-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9835b7-1b93-4866-68fa-08dbc993ee8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SYris1NlOsf0ItfkgRU66nlH+XIJQXpAzyRNJedxsMFhoi7w8nG9RSdtHtkJwfNCcXnRmseCt3YX+cONQJSaYTzWq99lA1V8N6lqialQOEWk7vPPeuis0yoCjBE2RYG7DC/GwDaJFtF6+MZWgY65MNPDgj/EzCThdJBfUhy77W/jvht+/CB82eXq0RjY8lyiGUzeUtpq7acYqdxIsQ+hn+v6vTPU90NAYGhwj3fIRdQU+vEtKXB9dRjREZq8g58k1SPF04WC9X06VLYlq0WverlEIZ3uJ0Twj6FyKrXvy72pp73S7d+fjqJxoHdOI9utrkt6HNmLEPWZNCCitbbdpGSMno8ulksqska9416gFsVqf5pMsiexNAvjkOZCkLd5M14KHszgkDE9XqROhhZGVBHDjrTwJko65hiPxv/ubnHdLIbqWHD/vFDY1xZwpKmW3DSvtBxDl0memCdIHi2oEdIqbLl/omNBaFEnhtsRMAA3yLfiNTlXPI6H/Ku+jGVgxehUEaAizVOjXSczSsmcDQqjwCp2DNWLffKORuOwcuIwFsEuoqdumctNI1LAXz2yab6UjzuXjcNZOzsjj+EYAJOyPihah1+7B/muGsLhGGaStEGBtVdyAMf+0vHZYF0mUWCip3+SpCjzlSztIKX6HZhUM3GtHkpT4uejpvwt2+xuQisz0FKXhnE4y92Vz8A+WiZ4k59Wb33XjOTH4Bt2/GE+plNsjobfyqtJC5RpJkzLfApWlnSwv/owXR/BExD+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(2616005)(26005)(426003)(336012)(1076003)(16526019)(36860700001)(8676002)(6666004)(47076005)(107886003)(8936002)(2906002)(5660300002)(4744005)(478600001)(4326008)(54906003)(316002)(70206006)(70586007)(41300700001)(6916009)(40460700003)(7636003)(356005)(40480700001)(86362001)(82740400003)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:22:20.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9835b7-1b93-4866-68fa-08dbc993ee8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix two issues in recently added FIB multipath list receive tests.

Ido Schimmel (2):
  selftests: fib_tests: Disable RP filter in multipath list receive test
  selftests: fib_tests: Count all trace point invocations

 tools/testing/selftests/net/fib_tests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.40.1


