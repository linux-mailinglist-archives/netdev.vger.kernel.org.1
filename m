Return-Path: <netdev+bounces-56043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7919480DA07
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9146B21617
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073D524B3;
	Mon, 11 Dec 2023 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/DFaAPN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08945B8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na3soNmrrpp47XvnvrYPkFAAsy8ZVXri8X3zMMYrizRmCvTpD5gHh91iUcwpnG2d/Xnj/secFssz52UeHUJV20qJoFBqRrCJ294u3f3x/8svmQ/j0WMdfmuiRpDNQ0vLHnCfwSm4LWoJmB47Lki0cEXzhwkqm+fIClwH/3HmC/lpwv6scllW1iBc2UKxwQJkmdnKDbOvb+Bkc/vkmy2y4LKEEfu7SSpx6Z1W2Ovs83QfYOsA+Mncew34jIQNNd+WsfMDVJ3vdkXUgRcVjYmG8/GjAiD4/WWEKr8K3D9pBOHw4RBO+7XtVyWxGOpCwfwxgljV4POBO2j17RyQEgBv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap5iyFV3O9sT/FDzSnNGf4Rnav+S+YiFxBdvfRrscEI=;
 b=I39xCMtqoDSJpuuIrGgQvVEGFSM7Pdy1whB1KvQKMktwHRMXqAu6ldveG/ULSQV1uUEZ7V8SprstVmBZ7OGGG6yXC3JOjePog+bNFlY9cVJj905wWLIvMRlEyhU/vAcYdY2tTT1mgz0sVMVw21VIwPjWqG7VqpYBiw2qmlQKeX0IMuHBQAhQli8iyKLxudIV0Q1jwmJCYfg+lbGkfTetE8yFmGNIjfSWnFOvww0TeUHZbrz7r9bRe5ATMSTD1EGF7B3/FfzcD8Pr6vwJPOktY7M39NFL0KbB6kSxrbQlhBvvwhVxWseVjV9IR2fiNgseC+Z/suauCVnia4x0gP7tCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap5iyFV3O9sT/FDzSnNGf4Rnav+S+YiFxBdvfRrscEI=;
 b=H/DFaAPNNW7GEVjYiLnDs0SkBFtGuwrZ6hbjI6D7ucqS2h8Xy1qWjUOYIb6PdWJtIqln6mw3dyXeIJO6ro0PBosSWkvyDngwk4QX6i6cd+kFNxX/99EshLhXYeLNZbzYpqguNBaOvJXeDe9OAY0ZBBczm0fIEWB7QlfxdpgW3CQ=
Received: from DM6PR18CA0014.namprd18.prod.outlook.com (2603:10b6:5:15b::27)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:20 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::68) by DM6PR18CA0014.outlook.office365.com
 (2603:10b6:5:15b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:19 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 0/8] ionic: updates to PCI error handling
Date: Mon, 11 Dec 2023 10:57:56 -0800
Message-ID: <20231211185804.18668-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 4010078a-b6ba-4b2b-83ee-08dbfa7b247c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EwjJDQzpHMbHPAZtPH9EvL9UgZSw9tNCO4B3jyAJtssYfKa0CUKZSN3CYSYvh32tLtfGBf/T5+HBssas24HmFWT1vCJl00zj01JS/iqAq2bsiDXpX2NBISQLqyTC0Ns252ciDMsSmqKzlMrlXqq1hdZaAEraRG/r7qGYTumGtK9PaV/4zeTx64qwREk/6COKvZHBzfPGbqb4NdAl7SbQ/flUDkHHgEvbXzYrFmTlPsPxi7yAAi279ylfuYaVpjLtqTrI+SVdhaN6fxqrWIBS7p1ReVuip/C5fbPGpcreLAPa94uBo1ChktYk2NqZ2vdulgnX5GepaxvJcSe02XvpBh9layb72f6oYYYHeHL0o8nZqKeqPCKnZCgmaEXj0A79TcpIEUQLzflOSV9FuleyKBt6ZSI0RE2kAUuZbI5zo0V8VI2KaLCok8ylJG3LCwt07NqisgWi6p5t7FJ/U3YqCvqbkmvX9IrHyjpF/+e3p4fY3pK1oUjc+nLz9IHipSOXIR+cT7gabvSzngpf7FbC/kPmfyREEu+akMnr1POgFcZj4IQrMii7qjxLPeQi8SBSoKBESmaCmSMF1miW8UayPbfDhr7coUskim1PXDQhoKTRzN2Ys4dcwNNPcb6GwlQ8GcTtKS5aY3/vHI3CGdJtaqZgK4QfeT/6YsW2oxbOrV/AWwlrcXlibTE9lMHyybECmqS2U07qGwRXXCbBh8ogW5tZUcBW6RvP8SmirodKPQehaXRteRs7XUOLjNXdxa9ucfiJYLg592uVc6LQZ6/KmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(4744005)(40460700003)(2906002)(5660300002)(44832011)(316002)(4326008)(8936002)(8676002)(54906003)(70586007)(70206006)(356005)(82740400003)(2616005)(36860700001)(110136005)(86362001)(36756003)(81166007)(47076005)(6666004)(16526019)(426003)(478600001)(26005)(1076003)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:20.2337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4010078a-b6ba-4b2b-83ee-08dbfa7b247c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633

These are improvements to our PCI error handling, including FLR and
AER events.

Shannon Nelson (8):
  ionic: pass opcode to devcmd_wait
  ionic: keep filters across FLR
  ionic: bypass firmware cmds when stuck in reset
  ionic: prevent pci disable of already disabled device
  ionic: no fw read when PCI reset failed
  ionic: use timer_shutdown_sync
  ionic: lif debugfs refresh on reset
  ionic: fill out pci error handlers

 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 43 ++++++++++++++++++-
 .../ethernet/pensando/ionic/ionic_debugfs.c   |  3 ++
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 24 ++++++++---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 ++
 .../net/ethernet/pensando/ionic/ionic_main.c  | 22 ++++++----
 6 files changed, 81 insertions(+), 15 deletions(-)

-- 
2.17.1


