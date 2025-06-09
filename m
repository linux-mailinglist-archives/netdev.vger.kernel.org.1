Return-Path: <netdev+bounces-195881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC79AD28EB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A1318919C3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE11F0E29;
	Mon,  9 Jun 2025 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wkc6+Nic"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AD18024;
	Mon,  9 Jun 2025 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505636; cv=fail; b=aV14hjwiv5xfvc59UB7b3oQM6R1g0akMpQhrNA90ExJWYd73ojNHiX/uhlBEsZhAc65aeCTfWvef+hhckT4nTrjrL4qM2/yaqFfPVNpZvHD0EUwFrpW5aFLYXznyouz101JnwWaa/DXA+Czmfyvz0xnxB7DJp7psHXDgCISLEjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505636; c=relaxed/simple;
	bh=d6krwjLJJZ6ZprRGiWfg2W4HwTyZG6qcoqp1qUx61ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwkja3MlyeAGbUt0K1NwL6p5/kV+YWiOXg4bphoCWmTK0yo9Gb62ismXKt8uXowOFRxXy4opHX7GIk1EyO4QtGvE/Lk7xqJH3a9wrKZfYDU+NMzLvvvo2AUE3+cwWiogGw6yOB2DDpcd+gbjHoniFE03uJB6WSrNMgj4yVZFWEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wkc6+Nic; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHvJi1pfjcNA7Uv+p7k3YBEpzstlRBpgZlQOx28d0jW6cj0MD8QOl9zfrgQrBQgIHZB3lD/zkyjD/ytBzuBlexyF0tvOxzne/3FlmkN+k3k1CWaULkm2qjnC4mSDjI0tiLrSlc8dGTjstNWhFvtPvJ5nuJiUcLPiIvWdAjnVd18Ty8HF5ndMp8Sv30aUGtHq9TQ1o+twxbhrHQkhELtTSEagC0Hyj69DO6lTH+8jGC5TCOdrAsyfrpsB2jEP5ZT6Wm47bTrOpGuj7PZodgqwwu+Od7qvD0Ji+A3LyGjPBnWn5LlkNNlYgTyFZzc0ZTFyCom7TwvrOEciG+lODE7mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FZtWlvnB3XDqA4knyUGFaeT349p7uDQuHk0m37k55o=;
 b=v1RcYvl6x1pVwQm5xLiOYwxV9sRSGeNT+rhRY5RgXCniOH63sSgW/Q/GcByJ/vCuB3IADRdSjw8Jhve8RB21zjGRLB0XJ1E85RG9MnRhxqDd9X3Xvria1OMNXj5mWPrPNZY5Kh8ZDhWWrlye51mgICkSITa1JPVGwQjrHm3JfmBbRCFsz5bldwhTkwa7IFKibQ+GRW4dUdv0rhxr7DoSUxaaVAXOVEsGVpmtJ+FoAAT+0YUClfKfV1kQbhZTyAHtwViSXyJcQQsZplJY41VdbEMLU92hSGFMLSbShLXZ1xcOC+UHU5WIjVFqjzxJay9XW7Pe9u5JfZL6RHmw+/tDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FZtWlvnB3XDqA4knyUGFaeT349p7uDQuHk0m37k55o=;
 b=Wkc6+NicJvKg9ojg1mgtFh4+CW+LbqnvxglTtaaCV3XlVIey8DWHe7TnNCXocvPW+cc0U6fVUCeWgxmPGM66x+833H1DKXEVfpgd02SIwvY4Uf1wVfWU/EarpFEeax+af/gv5ooTj+If9biwCbZf2GJCg8oREQtpDcmDPXl8CLM=
Received: from BL0PR02CA0112.namprd02.prod.outlook.com (2603:10b6:208:35::17)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 21:47:11 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:35:cafe::94) by BL0PR02CA0112.outlook.office365.com
 (2603:10b6:208:35::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Mon,
 9 Jun 2025 21:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Mon, 9 Jun 2025 21:47:10 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 16:47:09 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 0/3] ionic: three little changes
Date: Mon, 9 Jun 2025 14:46:41 -0700
Message-ID: <20250609214644.64851-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 9deb5625-ebe2-4fac-79d7-08dda79f3016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTpZTa8cPl9N4w+CdfbdsGHqe7K53M8vl2bHLHoKbpLeYV1D4vv9Q55iHY5n?=
 =?us-ascii?Q?GJuIJp3qJ3QV3jdTcWcWWXFVBCqJ/MQVAiZzN1lS2ajCar6V+5YWw7X+CK7l?=
 =?us-ascii?Q?KAdVcWTRj+SvzN3XxDkcX8L/HKz7RXpPLolJLxFW+MPQNkb9M2LAtr5nG8lO?=
 =?us-ascii?Q?cY0uWcpxJvYL2ynxlTfFxbKbC2zKri/yJ+dZqUdwAXLmty6oyV7Qt45EdQDT?=
 =?us-ascii?Q?LEPP4R8TqmYW9tCJ6ud0DAxu/Ry1FaENTh/Pbq4fLQKMZbhPIFi3tYpikZht?=
 =?us-ascii?Q?hGJ3Kbx0b2wyM/3vNtFhUHiIGrKdKjPpLCAvSv7A/HOf/EZ5PuGGn7Lqrl6J?=
 =?us-ascii?Q?ISfCGCy0hanLij2NHEhOArliYhVizXduk0V0AJMMuHJJrq58VLCktD3jOSF9?=
 =?us-ascii?Q?vE5hz+eM1kkNRI2pW5QXgvoYyfxJ5m20/i4fFRZCSdUqpfs2+OasgE8QIVvQ?=
 =?us-ascii?Q?v4oJ47S1rqK+HsUW1E25FSQf8KHS1oigEcse7lRF56hlwaeXEZWGnPpuIu69?=
 =?us-ascii?Q?tDzoyiIO4LDNyi3o+nK88SV9vXxAAvr8ypeeMMKAybZKDPgpdo4jv6aDMHIA?=
 =?us-ascii?Q?k/OHbb2nR4npU29i6qTviQHJJAbkiKEBh+rCJuoTQl2HRMUQFI4VJ+SJ09/p?=
 =?us-ascii?Q?TSDu9cnrID/Qz1uDG481ro2gLv29H0murTrIDQF305kuBZDYrC2WrFcc75fI?=
 =?us-ascii?Q?y94X1O8d73mJP7hoSocnfw88VwLF1vNxCTA1Jjo8LjHGNlZ4N1ZBpBUwmtdR?=
 =?us-ascii?Q?XQM2T8LmWp2tXDarJRPAb8jAfGaNJ7EhCnjbS0YdZUYJqw4WWKxutOx5m7ci?=
 =?us-ascii?Q?LBIiSRrJHLzATpOdAHomUMDOkR7A4e3rJRSoXTN26HKEmeAevei6UfHgYXeh?=
 =?us-ascii?Q?PjKIvOdUuabEx8xHnZW0xwRczqTi5/pVKf/OXHlNXoci4/x2bpN2hshD6iS4?=
 =?us-ascii?Q?RlTddLqMkygw6rXxX4SbuXLUpztZdbTZWUpdt6cz424yZaFU0GKFTYQE3iTt?=
 =?us-ascii?Q?kamSX8CTWzkbvTs7xwIYo72EFdE++346Lkydr9W6+hCX5lwOaPmm8lpy+X44?=
 =?us-ascii?Q?NmYw9inALesLY1yj7+oRosonWqoasrKxet+Afvot5jOfdl1XrCdk7ORo5SoV?=
 =?us-ascii?Q?81bfaTE8XjYD09OLhjgaZjwiM2ZHsBX+s0XEYAzWlpxpWL6JonvP+qLeAUsh?=
 =?us-ascii?Q?omM+xzRCub/8PGy1SHulNpiidJCO79sHIz1qFO7JhQX/tGbiSHbqWAMu5TxE?=
 =?us-ascii?Q?+pJvkukvOB/RwDPR5bm30P8xWidTwqKawKjj+BTtauCxY6gN7lH6Gtl9Q9RV?=
 =?us-ascii?Q?rPcU7X86TWUWPcWP6Ez0+6/XqBimMMNiNZiTC5kEE+vuM1s9txqTEdrUoNA0?=
 =?us-ascii?Q?ccT4IfE337ybCo2Gqy7i6FlebW/BKT1L0LuXiryzezZVUn8oRuXYro1aXvVO?=
 =?us-ascii?Q?PQSt9Fzr1RXEvMMH7ctzKMasUv0DDlaa4G83mKPEv6qX6+Kw58TY/BGskQDg?=
 =?us-ascii?Q?ZS3KtTpuTtpHE+6lZTEvO9lh8wjlzNcoe6+e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 21:47:10.4433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9deb5625-ebe2-4fac-79d7-08dda79f3016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677

These are three little changes for the code from inspection
and testing.

Shannon Nelson (3):
  ionic: print firmware heartbeat as unsigned
  ionic: clean dbpage in de-init
  ionic: cancel delayed work earlier in remove

 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c     | 4 ++--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1


