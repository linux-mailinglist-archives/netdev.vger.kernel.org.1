Return-Path: <netdev+bounces-98828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 190DD8D2939
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F64B22F39
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465131FA4;
	Wed, 29 May 2024 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JHL8MVSF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE001ECF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941015; cv=fail; b=GDpIh6ooEcxViVnWQIZj/WY1cj5m8W8aOetd5cyl8ovwoWcb1fm5IAJxdgCmXSPlRf1jkV74NKfGk+2T0p7uLHZvqNSP1UTMCIHvGXYqFpLAJJjwjS0CD7Ku7ezXy444BBRKnsTVuYoFG/fa1FxXAPUVyEPWN+eqATqDWhZXCwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941015; c=relaxed/simple;
	bh=zyflnIWiyfzhZX9X+z5V4wqTRUacXz1GInB+K5XBSKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGda0PSzkXcL8Cb4bsGnROinYp6Jkl+a5VAbz7DOl0D/q5EOXgfYOwxRm6ArRKcFdeNyBoWJs44eWUwFTx2NLMK6tBKhd8KrdTJ5IefnVzF//0wAkG1gwK2Tv9V6+TU9WmQKQyRgA6gkq/5nFwUmZvJZiXrP4YBabodd5MjZ4Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JHL8MVSF; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiaT2aUud8GYAC6s5mgAPlLBZ2+SxhHNOLtYP1ioa2y6MGyVfy9OppW1nYldVmaRcjQKNcbuU169uT6mK/3igw6hAiW2h6qDznDUXsycaGj6Bl8G1i4sTTZZNCOJj9ftJHWWa9OFn1KfrLMctn71jhJ18cW/UxgMIcby0G11B9w+7co2bTz84pZbJCEr/w1Try9WQzltK0cxby0hIR9XYgy/k5bIK22quKl3MdjvdNMJhBzOFW2/JQTsj3NPfi/0IV/rv+QCC1s0C3qm1bKIX/hue7vz7eSgY1ZRHXSP9ar6SVqJx2WqQ3dIubJhE2248/4vxVh3VxzlpKBu3g0xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv/nlDnC1yF3fNIJFa6MnaBjcAosfg5kXX6Ws13ZGHU=;
 b=hq9z72Msdn/+aJ7op7+JXduONRJa0tTGtb1Z/xv/QFSYxYGTgghtE45DsZSjV3KBqVwDZlQYiORMk0bWiwdTAznNcV7AKxs4yT9jJaBDcRtuGtWLQsOo302nTYdbZMsfg50JZ3MGz6OcAVD0aDLcgh+tiqo+wWF/zVhub5AYepJlOgKwAcRjEv98su5rQ0nhWLmzGVg8u01/BWYWBZLnPRf9JrfdSKf/nh6Jsv4vPAXjXUmpR4KxNLvz67wIHf8ShQ/xz7b2OrbheY61GfAmRdJufb8fv7UZmkmcgOpBuPKNIU3fuG+3sH+szBCgSdcqtN3pIa9Vc6BfWt3/E/bWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv/nlDnC1yF3fNIJFa6MnaBjcAosfg5kXX6Ws13ZGHU=;
 b=JHL8MVSFhJNLDZhZtWmNfLAQn7BFOr0fXrbKz0173Zt2Vaofm1Tunf5/6194cXoAiUSUp1J6pVLHAcQXfzvfy+dU7Foe9ODNZkU6L1S4fMGhbRQriOAJYP8RtjJ4V7n6r08mMCOMrcE/4WUrlB78CTWHagwlxbRoVkOftuhMSIA=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 00:03:31 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::92) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 00:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 2/7] ionic: Reset LIF device while restarting LIF
Date: Tue, 28 May 2024 17:02:54 -0700
Message-ID: <20240529000259.25775-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: d3765d52-88bb-45c6-f008-08dc7f72c609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1+rczDwkvM9B03OOf92rj2vkPVtBOZNBbxfE3PeWqykmRUKPxyu7w52vjXd?=
 =?us-ascii?Q?FHXNgFmQRS+lG7Kr/vE9py6KYZcYK+2towgxcm6XJvqEWrn/5GVM5YWiHsng?=
 =?us-ascii?Q?bTfG0uOK7G2jHu4UygT8pxNLRseFUGDzI98F7fdEHqXnPktifXNM5ASZTwWO?=
 =?us-ascii?Q?fcO680aHjywh6s73Q2/Gzegsja+jykNQLzjH2DU8UJw09pTSrohbGgGF/+ZJ?=
 =?us-ascii?Q?oMqttPsVYv9fHzCk8zm3sn7wIXiZlrBwjObXtCHspT3sUVevQ7hTmfteuRwy?=
 =?us-ascii?Q?gtrrAzkDvuznBbfIusCMnKFDNCNevPpLixn8LJk4c0m7nl5/jSWmrDUH3ZB8?=
 =?us-ascii?Q?MK8A+BFbu5k5UZIjIX5Amt6rJBb5R/GFD/w1EV+gcN5BBy1OGhrq2ufJ9nyV?=
 =?us-ascii?Q?oZNNYjIsYC1ns6Q56SmfEyVtdHoaSJhhI3C8QnEmgMDKjv24h7+lzo85MAwJ?=
 =?us-ascii?Q?4zDbMgthvq+5eOUULJbGewKk7MG5AfWK3tIoctnXAPcGm84qe7EwUcCL9tLP?=
 =?us-ascii?Q?nT1GAnN8reYmQF+zrUEIdY7B++bsXpOLDOCrc9maLH4HPETaLcH23GH6f6l8?=
 =?us-ascii?Q?xkjD1a/d8Mz7qTucVfyfuS6n8ST+5CLRcQcppxbrzAi/3qTRVa6Wmt9+9nOo?=
 =?us-ascii?Q?7LEL5QLHJRUSuPMe6OfNB09ABjhFJixliU3joKwdERGLdelFqGpyBb6Bc9Ga?=
 =?us-ascii?Q?YP1i+RsQux5vByqfUPhFgR3TDcZw5ZvUr3Apejc6RfWknnraUzWZc60vlF/A?=
 =?us-ascii?Q?id2qUD9EUvRd8rVSjaFyn4zNT9qz29q5HUVPW00Kg9ToFx25emhIhoUG5Xtx?=
 =?us-ascii?Q?xiaZmy2OKMH/DApUueAOYWcue60ekLAVan4a4ud/NA0euR/f+1Mxr2etLr2F?=
 =?us-ascii?Q?DjuBkT7PLhqMfaVZYXGTgkcCUikLEdU2ED2W/aJHxarqhpSfQlFIiIh0yPmp?=
 =?us-ascii?Q?/scPUV2g2kTy3QA6TG5+liSW+DXHMcGPXqFc5nABh9oF6XAfYwsewWnY+Xcl?=
 =?us-ascii?Q?ngemfrazsAwfau8VFV+gjRuVDmLZB6P/PAwElkqUYUlmVfZ1nUj1wvYiH8mr?=
 =?us-ascii?Q?BuH2iYrZzmHcqUZ4VZnn9yWoEWSG6D0ilO5SejO20wC6x83DQhk8zTn+wQp0?=
 =?us-ascii?Q?6CdBHEvsv01pKG65xnrODm3/Z1kPbM8d4jZ9ckksQ8bbshslQcAAfgbd5cdU?=
 =?us-ascii?Q?jzFn5lHdyBi1wC8t+WIxPS56gfmHurUvWv61weHjoS4mKI7UM3bPeIw7We8T?=
 =?us-ascii?Q?i9Y7pq+B82pe9StaVccqx9ANY5ZV3s1g8M8FnhN7Ku5BooD62G8eh18Wnl61?=
 =?us-ascii?Q?cAS5ZFJoy2t8OdY6GamXGzbdzXRMImmqg/PkybjJoAVtGk5mHYgxjQtluymA?=
 =?us-ascii?Q?NI69xYo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:30.4057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3765d52-88bb-45c6-f008-08dc7f72c609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

Recovery from broken states can be hard.  If the LIF reset in
the fw_down path didn't work because the PCI link was broken,
the FW won't be in the right state for proper restart.  We can
fire another LIF reset in the fw_up path to be sure things
are clean on restart.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 12fda3b860b9..101cbc088853 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3388,6 +3388,7 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	 * just need to reanimate it.
 	 */
 	ionic_init_devinfo(ionic);
+	ionic_reset(ionic);
 	err = ionic_identify(ionic);
 	if (err)
 		goto err_out;
-- 
2.17.1


