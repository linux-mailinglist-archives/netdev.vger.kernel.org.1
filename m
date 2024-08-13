Return-Path: <netdev+bounces-118246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E19510B8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 01:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955111C218AE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A31AC444;
	Tue, 13 Aug 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XSqFmyZ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9971AC420
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592501; cv=fail; b=rVGTZ+RF1rSggvmK52MkZXF8BdW/37eqY+Cv+Cc6usSBHwa2fpqUpokmCfouUuuYZDefbyNn+V1ZLvmBiV69++LijqSZ+/2MJ0gScDungR81VVwGeaMAfzkwTb2lpDE81Q+LaYlzvV8CZi1sQnJQYG9QOcFWcWBvHPFPEvrsmFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592501; c=relaxed/simple;
	bh=llBGp/lF0ox9pMyAvFZhwXA83Tx2SN/qDK3ZG2a/vUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ctFIkr9+SD87uNA/D1Fm06LLsG7ZUYDwgxrt0jQBYGKiNu6sADivev69nSMuKkF9m3aJFJmCZKMVUh6PkjoAPeq2OEIjN30x4HOO4qxbOt8qh166G5bgwLUDnTTVhHL2zNzyt5PZd8GP4/jCllx7iJd12WPVgNjLJotMefjon8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XSqFmyZ8; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdBjGLW0gODGZahQwHPuW5qCRgmp4iagjH+3eiGRmIZuF0IJPbCE60WBXyeb5Z/hr369VcDq/39O6hBUJ3X1fJyJa0oDdTkoutx/zjpuhkRhC1l/shJG7hA94+lB/tJfrIKkBUTAAuND/keeN4SBylxK3LptAZp39VA5KxnC7E5KTQnEYhT2UlE3Up6wp+MtKJuM2ohhMu9hlxCZGLzlmbYaFIzdgPfcuoxf3u5Mw0VFRzbcpqOLLc/lY0LscTpU+o168DGIoe/xsKC2O7aNln9myxjNjMQKaqbuZ+s/UYLGqEo3MdvsBR8Np6ChfEcIROhmwnGCVVGWWnvRRk2mWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8D21hTdp7Z2XdNXCOVqrfrMiX9/nD7P8QZS0DA3vc4=;
 b=qx1HtjlMOuEUEwc42Ds7QNSS3zRAziAmI+vRm1tUkOoZZW/SlsM2WsClnP/4G4PY9kAlfKIkX17mc2c4woN9GL3pU1UTkBsg0z7eX1Rl7xbC+r8Ty/n8htFkfg9N9kJmSBkmqjiASkutFPxamLkdzU0b/6d2BjDWv5QsYyRGjn3RoEPanQgYr6HDl6XQfd0LP0Z15QJZt93wfNH01/8F+Z94RFcuntdzbnDGFsloqvfK7VGMHANosQbhhRNzcfz+XRmupeKncp5M6yLGYW6lJByG2skt0RYhGu0vIlT1K8eNjmTgynHefrpqU5wMLVBR4EcyzcmMzTucorFMiCEsiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8D21hTdp7Z2XdNXCOVqrfrMiX9/nD7P8QZS0DA3vc4=;
 b=XSqFmyZ8cnBM5X5Ixof9GZVImJDrOgAIo6XNlaclM//OEcYU9HU2Vy5l5q7XQoHgD9xA8/YQZ1L4Xwz5RW2T+Yoc5u7eYenuXX34GPZMfS+FZ19UtO/i7xipLOhzBKMRHVeLEtKFc6Plx0A+xISv+VtJyQ+7G5c9S1v1oJR405I=
Received: from MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Tue, 13 Aug 2024 23:41:36 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::20) by MW4P220CA0020.outlook.office365.com
 (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 13 Aug 2024 23:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 23:41:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 18:41:34 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 0/2] ionic: Small fixes
Date: Tue, 13 Aug 2024 16:41:20 -0700
Message-ID: <20240813234122.53083-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa4621b-f837-4e6d-ff93-08dcbbf17889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fpd8iIWCCLEHLbs/ALfMRrQv/E29WtjJNGPvsR/pF7waTYBVQSgrRGvFVk7t?=
 =?us-ascii?Q?234H4s2hV543EnpIg/U/x3kFqi+OyLq7S3DMYLUVZZb7JF1hwcVkxpB9hLNr?=
 =?us-ascii?Q?GP9wWqTzFxnpCNdvH0AcgNMcsjxbn2yrMstEl20PAomRiWCwZTUbHXApV50S?=
 =?us-ascii?Q?kti4UoyAcpxHQW44pMBwi9XLH7XfiYpP16UnDTuWNjzPXddF5mo9R7jUVsIH?=
 =?us-ascii?Q?b/ih3BKNftrUlIMvt+gAfhiM39nYCO924KyjmusVNq9/kD8WUeUeenDIX7sv?=
 =?us-ascii?Q?BOp1UgTw18P+Y+vz2fUnf/svMPxPZsfLcn6paw7jsho1BWhbsM6w3GX1v+Zg?=
 =?us-ascii?Q?lauJSUm01G8Wjfu1s9W0VbG2kv92ckYEqAQnQ/Mlunf2+t1VlBcxQFDet9bw?=
 =?us-ascii?Q?IUqrlJI4mf1AaFl75nytfoIeDSaFEvntQ+Sca/7ebFpEKysBlVXYZkRFqTls?=
 =?us-ascii?Q?UaP11TIdA7Gx7+rkY5AWquDIIAQYNbe1QT45xEwPx9zEAjPv6CgInVJ0UqwC?=
 =?us-ascii?Q?Ro68D4/omZizFaosAHEYfv2fjIAuPi+s7ZVfN7QFh/5U0qADPOXWhtkXFssi?=
 =?us-ascii?Q?aRJ3RdyuWXqT1q745vU23Z6kWV5f1QXTcZhOW73bAPidzWAohFMDqUDA1lkN?=
 =?us-ascii?Q?ctUCSFOlXqAgz1awmfOPJj9TaNniDLfANy2tkZux/KUfpUI67CrjPIfc76c4?=
 =?us-ascii?Q?pdq6/CE7eO5dDH07jrk2twXQ40wQU5uCe0vvmTDRAGDOBhnCSBnDq76pjwOk?=
 =?us-ascii?Q?6wQ6w0Ef1adEAsLk0lMbz8SXxbhf+NMSpAoD3ZQ0ZJvBvlPcd6bgH+oTS49O?=
 =?us-ascii?Q?xatauITgtRfOuEKSjNrXs6Jx+oTFi68uvFdgw2mZf2rEikJUa6VhIGGe6yMO?=
 =?us-ascii?Q?QPmC5ckVfSonkYy5s23Tv+rWKmNpkIFx3ijnvL1fqSt/S1cy4gkbwPIfbQYh?=
 =?us-ascii?Q?/4YE9tGZlm4009Tsu4gXpSMrE93Hoiqo7YBqIa+qs25pC9n51hYljhB7zce8?=
 =?us-ascii?Q?9VVwnYes/a79GK1oaCQmPnukcZZjW5lnMQs6Pc3O/3h3JJa0uJOabClBnN5O?=
 =?us-ascii?Q?skRiCkdG8dNkf03VBjH+PasdvznAPn5SKRqTnOguZry17UiCDZ5fgsMJKzku?=
 =?us-ascii?Q?pqLg86U9FcSqmiuu4zguTSuL71E+n2yz5nIDJFQOaSrwM7XxhWimJnoABzV2?=
 =?us-ascii?Q?hon7Hf/HYA0nTjj0BWyBSbOkJ4mAmNJcVUnp9YsoBv3F7iUjxMUdhLbjpKTd?=
 =?us-ascii?Q?LNNmj0tW6u+OqdPnOOtsTR3nUDeqxgAkq4CHp0gCenGvJO0RWuBqhBEXmIht?=
 =?us-ascii?Q?LEB55Nn0Uw2HCiy2WSj26UzLbXWmnwzEhSzaykOB+K0Np0Qyd1m8jbY+O62z?=
 =?us-ascii?Q?0w6pjOHh0nd87SjMF4iO/FJbGyuhH+Nc3lFp8+cbRs0wyuqh6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 23:41:36.0933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa4621b-f837-4e6d-ff93-08dcbbf17889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543

Fixes for the ionic driver related to the case where napi budget
is 0 and also a fix for possible tx_timeout.

Brett Creeley (2):
  ionic: Fix napi case where budget == 0
  ionic: Prevent tx_timeout due to frequent doorbell ringing

 drivers/net/ethernet/pensando/ionic/ionic_dev.h  | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c  | 2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.17.1


