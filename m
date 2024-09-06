Return-Path: <netdev+bounces-126113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511496FE72
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A3FB249A2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638AC15B96C;
	Fri,  6 Sep 2024 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ACO9+SsN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB015B14B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665200; cv=fail; b=UB5XTdT51sIQP8Q0YzY7O/FwpOEHdJEnpRL1UOgZv/1yoXgzV9t9EuGe63MceR4xwCcLF5LQt5GO0GC9iSlKHLu5RwFBHy9JYjjCQkRDbS79wWO7K7rtZJy1yJKSDCUREl4pfR7dbEjEPrtdqjd+RdyNDzvv7IMbTmFKd112fJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665200; c=relaxed/simple;
	bh=j3CRyk6Y0uBremxXdEIQSJdVQVA5Iabxi3t9ThH6b30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oi1U3f5hWlqh/bnCn/rdHpJ89ZeVcN9se+uIB74axEc46bO3sM3EqJIGEnW3zOQCDLU2XUWwuPW8H/8hB5ZdAJ1IOmTvsBaN/XclZscfIl17Rpucfwy/cUbGDK/VQSx8l2wE6PtL9vNoj2M2hq7J99nVTHe+U8m6E8u28MfvP5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ACO9+SsN; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUzPg5VKYSBMBO9UocsaTXZXHWgGvYrgIHs+OvnGnYxkkuJCj7PMcHK0lBNpt2JbsZ5jK7uOw395ACji9O3YfEQrXI6PTE9k91sAB+iSsQsBu72yikRSs7fUsfLyRyTPUsEmC0tiGTZDOOB9NUwKakIH1kA6vOYRaaY5Xpi7FhhB/zrHk9n8bCC3odS/xSeWXFZiE12BPuUHLH0R6KEZCA4DJSjtJ76m9tE8cjgcCY8bRTiw8Pwi4ZjRIb8ofjLESnEU9VOv4zpGzQmQLD2ZMGrVRtgNPUo95JgJxu5P5oDBcJBmooAcH+1qMN9Welb1Bu1eWzZGeo+NQMPV6QdqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydGgXlmc6O+3iLJTFB/BCjqDr+bSvPG4muJH5tyCb50=;
 b=JvkRCit+exXg2QfVhVtR1IthIirM3XGWXXRSBYvl4IZ7YICMY5/ipCfVo2ttX4LlZ8/JrU0V7ujwgg80kROMcc+xEe8vzYWyCpnqi3rLht/KWcSLPT56bJS5tREgvRA8nzMDUR3Y5IGKjFe5M1/SeCZjdkBMsJnApCKet6SOGRhaHhnPYPgrCWmfdMZiwBt4UMUeOyQ3XMoc7oiwNrcgBiRMq/5MY+R1QN9OQ9S8gm7Jc/3iBjtEzuwotsE8BfDb5d3S6N36yNAQaJ0rgLtu7D/vQyLlpTtQ6yerDvitLZZYpperKlYcihPUFy4jLT4r7915vZBm2hDDxXhxkiEf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydGgXlmc6O+3iLJTFB/BCjqDr+bSvPG4muJH5tyCb50=;
 b=ACO9+SsNm4aBegfLdptY6Rjuc2E9LV0JY3EksFSiu+0Pvu4v5ODE3Yc8uS4RN4ndyJ5siFQbLWj6EeNhF8HNG7Gmv1Uo5Fvq6sk59D8gtCch3iKW3/F1A4YA56BnJ4fsQnQMcmHaU8tjCtEW4vU6b0IQbWPi0EcqFWdiL9CR1e4=
Received: from PH7PR17CA0066.namprd17.prod.outlook.com (2603:10b6:510:325::15)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 23:26:35 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::75) by PH7PR17CA0066.outlook.office365.com
 (2603:10b6:510:325::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:33 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 1/7] ionic: debug line for Tx completion errors
Date: Fri, 6 Sep 2024 16:26:17 -0700
Message-ID: <20240906232623.39651-2-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
References: <20240906232623.39651-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d78de-a5b2-4499-7ac0-08dccecb598e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezNlMI2gDgGgwWi6Dz3FV95S45vB4BeT4okbHbtLXwEVTwDc9LALJTZV6c6+?=
 =?us-ascii?Q?eQbkNpjeX8gTstdJGHUhtLu+pBjWAGLN7ITfgi3TlaP11rEg6qE2QGIPKAg6?=
 =?us-ascii?Q?PqACwZZMLBNawmo0uCH1rADNKIan4Y5h/yEF0u8C1acUK8DodxDxjU+/c2wa?=
 =?us-ascii?Q?3w313ptSkbFpldWW3MCgTSeaxBLsgCgfXaFTo3oCEDfj/ksnn3ns1rL8+0vz?=
 =?us-ascii?Q?a0SGHa9EOBr5OYzY8yykQe4ITkgSAmNL+wI1h1uJ/h75+8OhjmYE3KArg9zQ?=
 =?us-ascii?Q?6eKk5FuR8tcovmzsooQv/sSuD58VDHYSGJxzWZp3qQArZQ+rRod+P+vk5SGw?=
 =?us-ascii?Q?UnMIdZQQ0czNXvZ8FwYmy1EJsxRMXc+p8cknC0LfVALT/PzMFz89riD4Hene?=
 =?us-ascii?Q?0obq+4C27e5z7yv4eqn1lPMl0rQ6BuONQLTznJxCxjPzE56kffDUa7xk6IOA?=
 =?us-ascii?Q?9wQn8EBa2pm/R4GzqW8ZIGvos5nyqosB5WrdGUxIfTnQph0PocS6I3JHQ9zi?=
 =?us-ascii?Q?asCQuYOzzBJbCbzZ7tvEMmAAL04moEKeh8W0KxHNR3DOGT7AsG5jlorQ/KCM?=
 =?us-ascii?Q?63SuWWVClK1Mx0ZRaV8WShJsbE5BEN5ngBNepwB/z5pmR1RB2Cy2RqjKHmpP?=
 =?us-ascii?Q?7W6aqc+pzmVK+t8qMGnsmkKob3RfRMFCEN/c/Tl3AduHlWocModKccbW1MTp?=
 =?us-ascii?Q?FWV6rdO7V80cU6sHgf55XAPxDas4DyX4KU603lOOIH+l/oe/lmafKW8Hs6qs?=
 =?us-ascii?Q?CpA72/DaD2mMzD1hBrfcTwgQ/F5a6vgzdLdl5puX2pXC9gL+ton//V3rjLGq?=
 =?us-ascii?Q?W3j1SZ4laS+1QpZChXtVUEVYwezas0Cpgs//QnEMPWQ7RqOdfNauLTYG78nv?=
 =?us-ascii?Q?HRYP2aOIpPgT5IdbCoj3MZ8f+o8QrGwijpP3XTd3f37DCbRPz/0f3G75ChKm?=
 =?us-ascii?Q?LpxcwsviGipITiX59ONTUBkwLOV+1zDzz7oNUtP0hYitO50aSePe3f2yJue9?=
 =?us-ascii?Q?QMKDy9bFkb+ROYWfuajVijFhM31jAPGP49DlZi+twsegp1aSx7Z2ZU89wMLb?=
 =?us-ascii?Q?+rTuDk6rl7LCSJBeUVY9cFefO7arvirM7VsZNC9a2RM6X52gLczMVgOausI4?=
 =?us-ascii?Q?vBL6137vPOL0RsAyV3b3M4viV1aNoOKmPEu+d8zAb2V1HzdOm8FSjMCrxAIZ?=
 =?us-ascii?Q?q8+9Bk4G21Qra9h36WJuBtN/fNQcGzTJM8lQzXPHMrmCyEUz69GDMTRblzIp?=
 =?us-ascii?Q?7VwkvTcaX/2LFnQiZPmpU7xUBlioKycgleL2Fg1RSB6V+tWeywPZFiQosFoZ?=
 =?us-ascii?Q?igaw3V07FgWZTY4a4xnLxIWi/3TCbI/8FkxlGETI3/ZkPVZe5nH3QHNllwoA?=
 =?us-ascii?Q?/rqgHAWVcZe3DmwR0VApmy2xnoTv88V3HuPbdmSxcBBzZ4EG1vqygAN83lcp?=
 =?us-ascii?Q?3wlbwxe4fZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:35.5023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d78de-a5b2-4499-7ac0-08dccecb598e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

From: Shannon Nelson <shannon.nelson@amd.com>

Here's a little debugging aid in case the device starts throwing
Tx completion errors.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index fc79baad4561..ccdc0eefabe4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -648,7 +648,14 @@ static void ionic_rx_clean(struct ionic_queue *q,
 
 	stats = q_to_rx_stats(q);
 
-	if (comp->status) {
+	if (unlikely(comp->status)) {
+		/* Most likely status==2 and the pkt received was bigger
+		 * than the buffer available: comp->len will show the
+		 * pkt size received that didn't fit the advertised desc.len
+		 */
+		dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d desc->len %d\n",
+			q->index, comp->status, comp->len, q->rxq[q->head_idx].len);
+
 		stats->dropped++;
 		return;
 	}
-- 
2.17.1


