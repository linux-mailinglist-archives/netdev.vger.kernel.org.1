Return-Path: <netdev+bounces-53665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890E8040C4
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C282812B0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6535F1A;
	Mon,  4 Dec 2023 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zs0FOI6b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E8A90
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjlSzn/BfxwlWkt+CbaGnB8AdZbK6SmJ+tRSUaY5ZMxfJTwwJPg0rJGnOQni7LsXdrcNnfxnBOiVX6pbV1DW1uhqvWXSKfNkBEOFN545SMvEmT0Q3mhvMlEMcJP0tiMbf2keEbmgsnZm5jTv8ep6cIOLoC2MsfU9uyNUbTgfIGoFUa+k2JBNEsNhl+1zXlu7/pQonuYJ2NmZ5K2wBg+rg3eScYeDNm/knGGH7tY2C1uaz9UNJn8V4oK8d3QkRvYPkTmI3AvRiSyS+oDv7G5JsPVe83uUYxgsdbgY0SHqiLtpJ3hHArVQoiRLN/1HpO55Jk0Ow3gNyV9T3hBLwhwNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z7425oqu0yzftnRPvCS5JeJlCrJ2ODUwfMEpCKOrhQ=;
 b=Y9eyPPsD0NfdCAc8hgohKfU5msm34e+mKy0r/OuniPGSpu1r4AZJDyP/4i99ULlO6G1usKstFywfTAe6KNpFwAGWojCpEEtd9/MyNf7zCLnhsWttRl80z1nLYSpkle4ykT+scAn+7xZbNT8ioSSfuaRqf6wghxjT9ookfqD3vmpr+CQnfzBmlCkz8zVBay5hC0NJ8MeLUmEGJF8ND7YtEhHXDAVm4OfKaq8NE53xoP9c5hPjFZTnWqfl/+fwSKnPF2ujBPTk/WPQyCzKKQHCqgwzEsO3GkhE0PhDN2EeqnRtuF1tazwg62fH5+Cek7sJ3XQBdWCBxCsb5PnMsPMdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z7425oqu0yzftnRPvCS5JeJlCrJ2ODUwfMEpCKOrhQ=;
 b=Zs0FOI6bJmhM1vHISAhruhfHpxhuS6OKj87XvmsqblSV7s2f/ZGBEPVDuYk8q4tu/54TJQhDP+wRSi3PmEVXh1MHlMiz+2J24LoVYKEaK543J3zs365NNf7Jm9F205EtUhHOMm6FaWH/QA9cMrNSavBixs6mmzLWt5XpEdetoZo=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:09:59 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::23) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 4 Dec 2023 21:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:09:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:09:57 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/5] ionic: more driver fixes
Date: Mon, 4 Dec 2023 13:09:31 -0800
Message-ID: <20231204210936.16587-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: a56c11d6-b1fe-4814-58b3-08dbf50d5fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HpFnMJFhhioZgk9kslALQQYs6kY/o2tTDSe8oWviawYpecjIHmZcP5IUr1nvCCNwLVRMZJU6VrMy/3Np3kI9omi4ckuhRwZlSI7MTkZhPZGp/aH5/orNQkcpc7gPgYXd39soL6vpIWGja9au7+AlPa9p+z5B59pRKlgHhkZOa87VKUxxYRriQE26NhbeBW3s8u7pPh5/jd8xcrccWmUSIm7c/F8F3SeHMXboKtgYOVRUUgI5pVypntzV9q9tFBj8TpAr4xRdcI4BGVIwKcpfJL5wnVk6pSjzc+my+6neNCozG7lmp7qEgorjDuAuil3O1sHxs+OJDDFtmjgqp+2GpLCWE7R+VHRYLSlF9bBhFKyY72K1U7UCUyzh+3lM0i3SYlI1JuXJ3cKL1MHjbY90g8rWzXnR6kOGFuCrVY66STlBgKnq13PtaK6I1BvQZtW8/I33Kul4Q/rIz4Trx5w9CR0O0/QmLLd5jz19HamCL69sbFxdtKTyOqPq4fi1G+dEd/qNUazCBg9vUl/YIUkWNCZYymoiI1I/YcwA0QPrw5+FxsGWZ0jP0KsX77rQZbPs8kuvQeNsFfC4R/YdODjZTUjfD3sbKnOPT0Vt7j+vdngefQ3Udk8Nf1SxtjK0y3FWMg5/JWB3kNqtnOcEW3swSpKlnJAFkHzMx/EvGWunLhFJenbVfevjRSs7dzsShb0yxxrwxQ0lLMlTPtzQJ4mWha4d2w4AUknsYgF57R8CsYkA66oG3PBzZg8iPtRNY/5FHC1L5t7qxzMVImrRdw6IHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(54906003)(110136005)(70206006)(316002)(478600001)(40460700003)(966005)(6666004)(4744005)(5660300002)(36756003)(41300700001)(2906002)(86362001)(44832011)(4326008)(8936002)(8676002)(1076003)(2616005)(36860700001)(40480700001)(81166007)(47076005)(83380400001)(356005)(26005)(16526019)(426003)(82740400003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:09:59.2823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c11d6-b1fe-4814-58b3-08dbf50d5fd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

These are a few code cleanup items that appeared first in a
separate net patchset,
    https://lore.kernel.org/netdev/20231201000519.13363-1-shannon.nelson@amd.com/
but are now aimed for net-next.

Brett Creeley (4):
  ionic: Use cached VF attributes
  ionic: Don't check null when calling vfree()
  ionic: Make the check for Tx HW timestamping more obvious
  ionic: Re-arrange ionic_intr_info struct for cache perf

Shannon Nelson (1):
  ionic: set ionic ptr before setting up ethtool ops

 drivers/net/ethernet/pensando/ionic/ionic.h   |   2 -
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  40 -------
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   7 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 107 +++---------------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |   5 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  22 ----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  |  10 +-
 7 files changed, 28 insertions(+), 165 deletions(-)

-- 
2.17.1


