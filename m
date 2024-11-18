Return-Path: <netdev+bounces-145947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6AD9D159B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E211F2204B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B971C1F27;
	Mon, 18 Nov 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nQFBDjRJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E701C2339;
	Mon, 18 Nov 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948309; cv=fail; b=PhHFCdYl1WYmf/8Irxo9HkqTtUSJKr7HGFbYvXvHA9M1SlMxxBdTeMLMZ5UVIBK6OIwEI0NnTCkr97B5fnjaaRHfH8Yi2J4qmAcLh6Bs2z/o3Qj4212XfYomW4jnx8ALWJqVHb1EteS5mSjH7rxQh2HTCN1xEjC8X0NJ+G/2/s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948309; c=relaxed/simple;
	bh=tmzH4p5V7OsfPdy3Ar6TLjoP0hf2Z2za0OlT6dKdyw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f49x+bRCYuoqhDCAlZGtreAofhjpOIJkiDb2KbMe4e6bkoGf3Vowtrcky3cTF+ZYCdPyEBdm6foJpswW7n5BDE+4b/x40PqCmRkj3lleLPiu8DU68sRrjJ8C1bT8PqHAC/PFjuUyqGka8T1b+HVE1vL12YUZTctg7JgD8mGbdmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nQFBDjRJ; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrKkfmH/MeQbSFNSSK3XYJOnv2cAFWvQNQCf9hpcOZZgTxx6pwRCMfVNgl4UuNCGK158oWH9vKEgZ9NEMoDN4YJGXYXr8phI7Nfrh7SwmppnQAl3akoUvlpFqCv/7LzXPKJIALTnqxojen6LcY5ImRnEiRAAKYQTNdZCOrqsefnZ0WoLk2Q+vhTPHAQeJhNGFWMeH21JFKr87oB7/QWmFrJ+Ut6zDe2TTFW6v5ZnMe8pP6PmUQMIgk5urxn5xmhjvsY8Li+qmojDabc/1eWS/e2F50yzI2TZtZRJWpQiazZs0cQEXUyTpyhv20fDYNtMYHG7hRQM5oDj1EcprlxN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IC4GM0Rj+XiCREtClPzzW9d0fOeSS6zyRqkQ12zgCE=;
 b=C7hUMG5f/Tvp7WF6aq6+kpMki+mXaHd0eZANbsa+JnoyNKb6GHovIf80EuNQW9iGihS1Wo4LZkA80si/NNPka/wfs4GRhigaaqKQvi/dcCvLgS6HfXOwSZ0IQqL9VQILULRx9vpbJfGEVeZlIN8auuFYOC4I+HcZM0xLNMZG0MV0jU7jJMT7uYQZsC9Jh99qIph6uJzhGM5s/cyophcTMB7fo8Pw5reSbto/xyq298xDtjGHc4OhEBREzCOMVso4QQTSC85MnrtvZaxU6rS2yXVNalyobacR0qLxQS8dWspeUg77GTUxoJzNq8+d/HAwyT0DOmvvySvMnDhsy9lsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IC4GM0Rj+XiCREtClPzzW9d0fOeSS6zyRqkQ12zgCE=;
 b=nQFBDjRJDX7v2DbU5X9W8fzjSfo7+QA8QDoHlA8u4mV0eRzTxxhmYTZbR/Zx8WSDpy/wGcdfVQKhKk/BIYd+RCStuzf0yJY1R2t6SvtwHDF5yW4Xp5wntu+cyJ002t9xq/LlG9RaWGqkMH75D1WixIAQ/YvyIAMQIGPKsZ1U0g0=
Received: from BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::6)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 16:45:03 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::8d) by BN9P220CA0001.outlook.office365.com
 (2603:10b6:408:13e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:45:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:58 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:58 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:56 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v5 10/27] cxl: harden resource_contains checks to handle zero size resources
Date: Mon, 18 Nov 2024 16:44:17 +0000
Message-ID: <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fba7a6d-3d8f-42bd-398e-08dd07f059bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UmGWdgdD1RtOiv8D0u5nssJ+jIlIGpdyhYumIOKbiYED2UZOO+UW/sl6dLLZ?=
 =?us-ascii?Q?aOKe+tgb5apYebtQBFPHLZrvgHaux6m+nzt8H4DcFtqrCLiy9icH/NkdYWvf?=
 =?us-ascii?Q?tm9PdsQbztXKFLbCBH1n9/sSTfZGErAagcmxipjistNEVWGHfkBKMRRyDIb5?=
 =?us-ascii?Q?We/dqHT+zrlycE9QX1+NedJqGLul78Bwmj2PCaSq3GFtq9nXvfbTkzo91UWX?=
 =?us-ascii?Q?AWhGXjqDACWuSsNNwSSeDsyRh/USdYjOZoEy1Mr1W5+teaSwVLCDSpgp0e5a?=
 =?us-ascii?Q?sQWXwD7y0EYaKuugDWbf4Yd58eYt5MWDs2+l0zb9jPhUrGrjYOsfE/OZ1zi/?=
 =?us-ascii?Q?GbZTKYyBJzlOqZyk7vccqWBfK4BFInzclUtUUD4AF6TZrkuj1lEfEmc1W8Ya?=
 =?us-ascii?Q?w4wOQadF4YmvAzVfwmmxk59pkK26xkaP35dg7GvVU/+l5y2PuAjjJ/pb44up?=
 =?us-ascii?Q?YY9D4byfs3L7ZTpvGaeYNfC4H1kcqY+g/wbjoHXa0b6ZQMolX7caN+D7pn1m?=
 =?us-ascii?Q?ukJCEQTbryn2bT32iYg0GfFBtWTN7SOQFJ4On7437Uqwl9RQyjuxEyGl2PjQ?=
 =?us-ascii?Q?fsAbw6Lo9wy6XjtN0WtjPv6RSAb3dka0EN760fSJCaf8qDu0jnoNIW7LlQQm?=
 =?us-ascii?Q?64WSueQekfatIy8Lf1WPaUIGboiW79fjUxKFiF6fCuo7KZ3nua42s1IRRu4T?=
 =?us-ascii?Q?o/w/GqoWcPy1MxGiA/ZBih0ojjfF/wTv7bLkSEl3Z2MrVwzD06hPf1IQ6ctA?=
 =?us-ascii?Q?hDUwsE5S9GZBai0sLmFOpj6rrI3aDJzfAt5F1HvxOUfLqqNEVyap3S1e+99V?=
 =?us-ascii?Q?kP6hrU+rMR118Y420Fig3L6c9LIcCf7AVyk4u5K7g3W1K4YpZ0wqUeYTFWv8?=
 =?us-ascii?Q?abc4K2fdG4UfcbZr9SbNfcHL1/3mC8cy514/jV/TVzM7MHjV/sFvkaS8hlbR?=
 =?us-ascii?Q?PnCiDBtyp/C21g9c6oznj+vNe4/qVz1lStE9Jh7SapkrLQQuG/H9clJpE3tE?=
 =?us-ascii?Q?0sBSNxmd9BjnunoUTi+wGJix5RW/Ltp6Nc9HvnNxO9OV8Y9qXmv/BgzuOQXA?=
 =?us-ascii?Q?YgKTIk1I3x3pDJXliRDMFZx97haQTlaDuqi5utj+S4cuba3JGynvu07xTggV?=
 =?us-ascii?Q?UR2xuJXYsPnhkRSoSbsT78IZSKo++2Wtrb1rQFvCIU7fQs8gfNlWbwNsEXzh?=
 =?us-ascii?Q?Rh/vhwYzfWLz6Cj/NGzas0nz6eLrNu002E6JsOEDF7UB8RSGUP8hoMNPwWim?=
 =?us-ascii?Q?7iExHtjbFVF6qsQ1TWLKygPSE+11EggmLSozU46/K6mBB2a1sQIubhWVCNZQ?=
 =?us-ascii?Q?YzXZuLK+9DEg9TNb7EcfrKBmMGuggHVQQg8u7ag+tejPHXJXYQH+ROP4dDkN?=
 =?us-ascii?Q?b0a7Ai4DDzDd5haL491EG0XxFTCByV7R7q68hWSQGO9rsgotUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:45:03.4478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fba7a6d-3d8f-42bd-398e-08dd07f059bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

From: Alejandro Lucero <alucerop@amd.com>

For a resource defined with size zero, resource_contains returns
always true.

Add resource size check before using it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 223c273c0cd1..c58d6b8f9b58 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	cxled->dpa_res = res;
 	cxled->skip = skipped;
 
-	if (resource_contains(&cxlds->pmem_res, res))
+	if (resource_size(&cxlds->pmem_res) &&
+	    resource_contains(&cxlds->pmem_res, res)) {
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	} else if (resource_size(&cxlds->ram_res) &&
+		   resource_contains(&cxlds->ram_res, res)) {
 		cxled->mode = CXL_DECODER_RAM;
+	}
 	else {
 		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
 			 port->id, cxled->cxld.id, cxled->dpa_res);
-- 
2.17.1


