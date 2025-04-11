Return-Path: <netdev+bounces-181453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1DA8508E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFF1B68DBC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6812F399;
	Fri, 11 Apr 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RTKWkWPa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829826AFC;
	Fri, 11 Apr 2025 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331556; cv=fail; b=JsoJaIxH+ojvBJX/fQ5ZxTAvwgJwg+zXlmvamRx9xHYk0yGXDx1pdafI2ccfMEeTI0QteeOazqSM2DVEgPj3UCzR8oyQ4VvOq8sSaEEta4ilwh5o4UZo8LSBYDZ1terwzx4ryAaKPHzOUgUj7IuKpNOWTt/34kFhWIioCGFm7wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331556; c=relaxed/simple;
	bh=mKLD6U0Qq2qly3eDbHZO08EQYKAEddHLzKuuIjiwxac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyTGG5i7r3fiekg85jjo3JFw4E0c0YIGBzPrTpr9HeknKwP8nG9x2cHtxenIsuJWTWkP6DL8SX+6hr7//f/QCwf9xWVw4U0bMXmP1glt4uczyvxfugPOebD0QlLt19WQXiGs8vob1Xh9GVamqBciajQ/MotMEXF9MSiHRCu+RRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RTKWkWPa; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmKqjP4AD04JK//on4xKcTJWb5t/1uT6vDyej+2ngfCNjl9EaU5V/Rrl2iGMEG5PAHAb0tGAn5Mfck+bBS0bL+/PdInsQkNuOBC5o74JEA2SKo30IHX6WSnBOXUS1L+m9IBYzAIuvtViVD9ABomfs/crbhWv5CJyohtWOTQwIiWYzlcvloGaoYBFmF4/0iaskfZgnICsoND7rLYJ2XPFUfDZYn+K5u3LIzt9/CuDSDutGPFAa5K8yL4stD1sMfo+Hu077xg8iqNl891Dm/P+rMbClkvHPjPEnUozmrdqLOVtZKFB/zT3Q8T17XYE+peKXEWoROLSXCnjNaZEkJCmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ay0wlKg4LcOtA/fHnyTVaGJ2zevnadCxEZ1xV1GyPU=;
 b=bKYTkEKbNSCCv+adpXMM1aty8sgunz3COb9eAlunmLvovv3jmgnmuIVaIwXfmBodfP/zRMbV/JI6fUZME5FkI5I4Rd60hmbY/sK3pq2p20+etCpOxPF6zC5b4GL7A2OYjLsRHOImkLpQdyf5MBmtkb+lgz5AeUbG3ob57FqbbUJeZBis/5iSOMW+WUvYIHg5KKbk1oWKGxzIlwW3VmnfFFvWgjamOD+BZZ7v7+7ZHG7NcHdRpXYTQ4ryQQ1tmMbqaB28un6odHoBwosHFrqA9G7XcxxDtrGpUDh8daLG7UlfyvSpLNnq6i/LAt5+yWQzXCzbaoGvyeWliUvdn9mZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ay0wlKg4LcOtA/fHnyTVaGJ2zevnadCxEZ1xV1GyPU=;
 b=RTKWkWPaFmMzhh8gvWHPnYxmfISHCHBvwa2iF/GkR5tKehaQA+Us3dBBWdl22E8WUkxjAnZ8CMS7hFMPcgMuEMZ+GG00LdRtCZItgp98KO2mCCAJzPcIYSsoK7hkjTlBP8ujhZRzxXd8g/IeX/51qxl9efiobTapFV+UxOSOBGs=
Received: from CH2PR07CA0047.namprd07.prod.outlook.com (2603:10b6:610:5b::21)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 00:32:30 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::56) by CH2PR07CA0047.outlook.office365.com
 (2603:10b6:610:5b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Fri,
 11 Apr 2025 00:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 00:32:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:29 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 2/5] pds_core: remove extra name description
Date: Thu, 10 Apr 2025 17:32:06 -0700
Message-ID: <20250411003209.44053-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411003209.44053-1-shannon.nelson@amd.com>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: b47e713e-0738-4d33-edf2-08dd789057f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJxx74HhqUWa1MAMVrjcEt8ykqZ+Q7IGqokD/oyU1VdXu/WBfBpij9J563sO?=
 =?us-ascii?Q?DftvcYCSy8eDGMofsY1bdBHsUkJZQtcC5qdNRxfo9cUcd/nWGW2svdVDShdz?=
 =?us-ascii?Q?gBUa2Eg3D01UL/Q1ap2/dVJseILoSGCNqFYW8hRMgq0KJxoim3nJeQcBKs17?=
 =?us-ascii?Q?jOS/pt6ESqvivfpCQkCl21S78utqPHnTZxH3GBaAwNULsKySaFJNnlmUrkjg?=
 =?us-ascii?Q?lnf0R/V4+TNYXMfslmPRhk8zviYkb6vRYNqK8uYi6cPvYmYCQgr8lUneqN5y?=
 =?us-ascii?Q?YQlCVRDBB1PVJv9LPP0H0K7LfBNDqZowxKA42L26ozOJmzPtuPxD6rPobFiN?=
 =?us-ascii?Q?LZGPYhJcdO4xVhM24OjCCtgfzfISEIfvA0vOMZFh/WI240aOTfGBs7coXB6l?=
 =?us-ascii?Q?/l8X+KhyNTp5m8k5As8syIWeDycEB/3/wMYUpaIr4RWoe/hcyoeHU3nZtHtg?=
 =?us-ascii?Q?QpQ5rV8IxC7LNa686U7wLCyegwEHER2IDlAksI4X7O3idAk8ray+1WQSenZd?=
 =?us-ascii?Q?HVxND/jW+B8j641mAdVOkpSV40eiwM4qRtEjEea2Yd7tnjsIImGmMF1fEdAI?=
 =?us-ascii?Q?WbwMV8lpijZui9o7n4JRlkFG23ZfZJzndEpWWoTsGvudSnVsT7izLsnxvsCJ?=
 =?us-ascii?Q?/VzcaVQM33cSbqzBdLWz6r7dXLyIPqfKhDglPUiQlDY61x72eRRCHVvm7j0V?=
 =?us-ascii?Q?BwS0MnIMprwZozsGxTrBYxUOP/KcBT3ekkJyp3tIRE1j+3Q7DygCg7gHZkbY?=
 =?us-ascii?Q?h7XWcijDS++WFyLchCQeKp0jPpx7xnV5NglVWQybJmLO1cqaQKgqVdbl1mNd?=
 =?us-ascii?Q?+IFlAvE8TsZ/U24K67n2PKtwy8CCEeUzzTZjYGY6brBVLyX8s4HQJmD7nS6Z?=
 =?us-ascii?Q?7z/dCcUBGGDU7aMvjsvj0IYAtWP3J5NjjubQ7Pyg5hmwDC64pL0QVUO9jh90?=
 =?us-ascii?Q?RdgIdKf7PYAlrZV6Lvgc/oGPFBMNE5YKXrb49Zshd7PIk86DByt5uyFp+sl/?=
 =?us-ascii?Q?sOHgFVAOY1aMtI7oPzGl+pN0IyTO5bkwx9MHPdfnVm0GyGYX5v58tUJ3h0TZ?=
 =?us-ascii?Q?7qwbkovxnFQA+vSGIN/RGiYAg95JxgSkl9NuwRVq5M1PDHwWjKcx+ObVvq+h?=
 =?us-ascii?Q?W7qZ8GmQajkTMP7fwqpOdqp36W91RQbeJtptyVvmiuaazx+iAP05DYc8ZCWv?=
 =?us-ascii?Q?hlgNxqKh5COJ9Hh4Tb0bOTAl7q33QeutjwM2oIXpyBx7wOsApT3Ff1GY5Lrv?=
 =?us-ascii?Q?34u85Wax1xPHBFKJvzwnhQN/8pnaikdvA1Av8L25pZkWMol3yBdvueHp1wBT?=
 =?us-ascii?Q?GV8JyV88nqzgJxRaXZ7vLob3VUV3D82ylfIIrl7w2ZEQUayHggd6qV/yz0Mf?=
 =?us-ascii?Q?MJtdjVTqh9n3qubZAL+EXzymJfRi6HN1ePx5wm+/BQ5SgdRAhKK1TvOLG2Fe?=
 =?us-ascii?Q?b+hC6s3hk8OU3FpZM2nhfswM2euGUZXfp75RIldb2Z0aQpKlwCIXPmOFvdnx?=
 =?us-ascii?Q?XZ7wg9w06SSOZAoABh+oIpfl/9NR2a8hLUJTwjH2HB+EptILiepSwLVaPA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:30.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47e713e-0738-4d33-edf2-08dd789057f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

Fix the kernel-doc complaint
include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/linux/pds/pds_adminq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index ddd111f04ca0..339156113fa5 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -463,7 +463,6 @@ struct pds_core_lif_getattr_cmd {
  * @rsvd:       Word boundary padding
  * @comp_index: Index in the descriptor ring for which this is the completion
  * @state:	LIF state (enum pds_core_lif_state)
- * @name:	LIF name string, 0 terminated
  * @features:	Features (enum pds_core_hw_features)
  * @rsvd2:      Word boundary padding
  * @color:	Color bit
-- 
2.17.1


