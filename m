Return-Path: <netdev+bounces-54624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A60807A7C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 22:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608651C20944
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8F70970;
	Wed,  6 Dec 2023 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi9w26rq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9298
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 13:33:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHhgOQIjugTS5rMKsW1Hy/GEfDbWovbJepI6a/PnALGgfCUHarnlzNcZe4t0bwTwincPA0FW2G6RRFSeuMyo+JNfjJrUJUfQfouR3wq4O2jD9BUOMfklXSnF2A9h7+uYZt1q8rGhpUrISCwX0JFxKwg7OTpIJ2qx3VFlpMC2Wus0KcC4mxxzO6jbENYcgbrT6A1vZsqkkvW3E/76GSO9rdvkrIiYwfZFvao86QpZRZdKpYvF76vBMVD1zXpM073PwgJLc9N93YeI3BiDpXGkzvA/2iQoouhoPUXYCWqYv4UWeZvwETtXJFWjt1mZcc0sOuOIUPqtQUmB6qhRuf6xRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+eQz85cHi8w5mu0aKTja07eRjbsvLAuF7dr9vC0sYk=;
 b=eyOaQ84zsf3t9Agj32ykKIR3U/rVJWqx8ThC+KlSj1AYWFela8DwcEEQoQQX/UQM2jitQtP8scIUV9GT71phGrRE7iQQWuNQki7dX3bY8cRvUFavu2jglggu5VanW5y7O219oDAG7YFi666jXca/cUsyNmzQgb/ouH/0atPHX+jEc9TE5YFWrPVdj2sQmctRTdsTDSQak5ywbBCks93cbTnDsVTmBxejBgsGiCDHeZ/XlxI5BMGbnIPNTpzCnfQLkbBfavEx3OsdIQUitETLeh1tpU5V0tYeUtGq4Zgb4FtjcV71kEK8nWp1CNpNYaMS0eGtxXob6/MMMzW1KgFPZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+eQz85cHi8w5mu0aKTja07eRjbsvLAuF7dr9vC0sYk=;
 b=qi9w26rqD9Y08RcAjtaqZ9qkIWkSBzMC3KlS9ZRR1iQiXtjRVrViRx5C8GoMlBOrqNdjvSNDFFnQ05Ye5EFynefN4eAjgxnuXIosXxoLtKnlpM638D8sIp+4/gkA/e7gax/HnATdJGh1ib/2gRGi+Xdwln+rWJ6tfEyu5cAmIjfr+jUL+JxNY/MDq/UU1LAiVF6kT23HA88LgCBmQ0qBzA//B/jimqBNFRUBFXHe1/G2lh0Z3wOUKnmretMJHTI8RLFlUOgQHdGMw5posIalQgKp3EzIUS7U2JKxg6AHsWn5PeI2dW6BzEXPlj08tkMveAdnn+ZJYR+32hkZT4+ncA==
Received: from MW4PR03CA0032.namprd03.prod.outlook.com (2603:10b6:303:8e::7)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 21:33:02 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::d5) by MW4PR03CA0032.outlook.office365.com
 (2603:10b6:303:8e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 21:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 21:33:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Dec 2023
 13:32:45 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 6 Dec 2023 13:32:41 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<jiri@resnulli.us>, <johannes@sipsolutions.net>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <andriy.shevchenko@linux.intel.com>, <jhs@mojatatu.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] Generic netlink multicast fixes
Date: Wed, 6 Dec 2023 23:31:00 +0200
Message-ID: <20231206213102.1824398-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 91751c7d-4017-4536-cd75-08dbf6a2ecf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x72rU/Zm8//aCF3pAy0wrEOpEe7NyRlZuwlmcPef9PntwGSCSB9We7S8B/hUVCEzf0yzkwKJjmUHu4CvCJeU8sp0sHyRY2tCaAoZiGMeAUBG8/dyqKLBCs6vHPogs0sTBQ9cOpFY8Mjsx8k+KvxNg07hiOTvRTYvM9wtyhViPFL6NlWUzTIzKVF/mGJGK7jjCZ/N5cDKZtuUf2qu6Z1vYumdgbSssGZkLYNrGCRdif0I7xuUooMDgi9+FaVNLYLRuawaSZde4/mwlDTQ8cQSIOOHsLuLd352tovvR6jW4HEqXlgAWSlGFCmRdllQ3b9T4/Aq4kZMkprNd/7N4osTif+3XNGVG7smsXbOgZ9cTtCRCelE405EKxCKUoWqgpXGM3lSkyX6NPd50P+82eUyWNopBzFN/LI/Nj1ISuNDwapiB7yQhthU15WW5obLu2BPYhIV+gyoPcUJgiulMZLrOl0MQOFNxjfqqcjYchTjl9eT3xiJeIsRE+4RwD9qSu+f+ipZKSBuEYq7sDfwSowqmnM4fJBLNffVp01uf4XLIccsgraRATmjNrepb+RSnsCW4fxRU4OMv0Nopsox4OFCoksfxqRtz+5G+BhgS2AyDL56BVH5cujxBQGI3XXEGtOxvyICtub2ssFGJp1e2qyoEiP9UN7u61iiC8igek/MVQsiRwxRomqHb75kt0kIkxMQ5dsfFMz+rzp34zL/R7t9nCDqku2myaNni9wAz/0ZFsxjuuspXnJK0Bgbp1XgPRtbGh0LwRpgxuf7dLxoFW534w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(40470700004)(36840700001)(478600001)(47076005)(40460700003)(356005)(82740400003)(6666004)(2616005)(41300700001)(36756003)(107886003)(1076003)(16526019)(26005)(336012)(83380400001)(4744005)(70206006)(70586007)(4326008)(7416002)(2906002)(426003)(316002)(40480700001)(5660300002)(54906003)(8936002)(7636003)(6916009)(8676002)(36860700001)(86362001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:33:02.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91751c7d-4017-4536-cd75-08dbf6a2ecf2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

Restrict two generic netlink multicast groups - in the "psample" and
"NET_DM" families - to be root-only with the appropriate capabilities.
See individual patches for more details.

Ido Schimmel (2):
  psample: Require 'CAP_NET_ADMIN' when joining "packets" group
  drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

 include/net/genetlink.h | 2 ++
 net/core/drop_monitor.c | 4 +++-
 net/netlink/genetlink.c | 3 +++
 net/psample/psample.c   | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.40.1


