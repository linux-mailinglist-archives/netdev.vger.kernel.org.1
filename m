Return-Path: <netdev+bounces-102391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26625902C36
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5B02853C2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367E215279E;
	Mon, 10 Jun 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmzvVKt+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7251527AC
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060862; cv=fail; b=aU9p9vzPAg6NmxlZtFxtXlu6OuepdmZAu76znNUKomo9o/9aOeYiT6lBd8pSwrhoPhA4Z54STK1Ug5HdvaCGLpr/qPawDZ2bau+U8bNFkU+e6Kl/3kkHqgVaXCaBSlkx2060tPNlqcmMYyqjE3H7+Q8G04yUGTXJSrNNiBria/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060862; c=relaxed/simple;
	bh=5sB3CxUDmaaUAuSYh5D97XEKHROPVNs8AmsPJmf/+Wc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+H+Qru93422x6jlbD1DlRMeG9UvEqCywXsBe/Li9S6JrEQGWuU2UJsAwhR5pc9P/loOE56BqP2c78W15Wbg6xU8/IpI6VlUwTLJdtTbQsRXXRYhfM2JjuQ25kM+taTtG7ofcAlHgW3BP1dTYmS0+o1t/hcElGNUfYx46JfTsBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmzvVKt+; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDLq51fuBpF2/k0P058PY4NMirWb0fFAAYLNRMNBmcVfF61EBxq06ZrkKcn8v3IqVA+5mOYeZ/ll0VREhhsSEVuHl3qld5nf7hGcXluaeFntdytj6dCoKG6wzXqXY59JlgH59K0r3EeETDuITREoj7H4XhZDNETsj+xa31zXJDvKDd76GmgUbKGUCeSbVOiMZqcezcKx9JjG1/7WOGuhq+eYUt9xSa5eBniUoLYWb/5WIkkzymLZxPXHsx1VDRKsEXJEtSYNL63dyEURavb6otb5523TayI0DBA4WyAkVb06iFqGEaiMDWcwGCq5H9p6I0UGzV8w7qUZoqcVpJbBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8LFdBwLNkkIc+Jt1O/jE3YCpb8bveIk9X0+cT6vdU0=;
 b=IytJR4uLdtrg32hDjCHFeizApSAFe5e1HbvGGGCRoSx7h5N8Ebg0noTys6YhhyVS6emjD9hlejKdl/PtDJhIVSEvlP1un1IlPaf8r94X1gmGEyQ45v/3WsSsUoBXtJHaFeF9BzjigJV6Jp+NoY92Mm3OLvLLZsGuaCu09inMjviJv8bVYc9JKJzFxqUEkywyOS+d1BJhfLGVbcjnHIKmWdunjwXWZLDkcrP+KdAy8WBBBNlIDQU51a0Oij+EyLWQ7jPTHWN9bYFBVxS3FiEKa73vVL2HZpVbzjj7zG6fLy3JLdV6oDZFqVJpX4WxHpKQHPwOU2hshbapOkmZyTfH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8LFdBwLNkkIc+Jt1O/jE3YCpb8bveIk9X0+cT6vdU0=;
 b=CmzvVKt+pTPQ1/3SqrCZDPdwhSA78zNqCUuEIqEUzPLIGxpjV9pX63xwHFFxs/WxreoKYb3D2aDAezhpcUDUGgt6Qdt410b3KoTTGmBYjZDgeCq4ruUHLmnY4gZC7NgIE91waU6p1U20A3VhnBtPaWus7aEMBNuc2GBWX/uqdYA=
Received: from DS7PR03CA0283.namprd03.prod.outlook.com (2603:10b6:5:3ad::18)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:35 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::96) by DS7PR03CA0283.outlook.office365.com
 (2603:10b6:5:3ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:33 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 6/8] ionic: check for queue deadline in doorbell_napi_work
Date: Mon, 10 Jun 2024 16:07:04 -0700
Message-ID: <20240610230706.34883-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240610230706.34883-1-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a7c073-ff19-4f1d-cdfb-08dc89a21c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1O+fS1B2vO8czqnchbTmTsEloL4PNzUFuHw1U4DFCi9oV8jnkR2uXc9FNxnm?=
 =?us-ascii?Q?bY4CyNszLbJb6hlmobC7lihQy7c4Il3gSZUMu4Bcx4dzYL6fwc+Gn66Y1CsW?=
 =?us-ascii?Q?hq10Pa6CDvs+XvubT9Qjr1Mbv1qYju36qots7uJFSTskVQxnjzWj9gxCtlBZ?=
 =?us-ascii?Q?ynvxgnXeLw/HdfQ9+by5i/KiAM2BQy+AGuG175oliThGz/4IadgUrPHEulR/?=
 =?us-ascii?Q?iefQa2HRUcw7f/7bPVDkYrC/2bxtgQJvRUSd2APm0+jRQEbc/jQqWWD1wmY+?=
 =?us-ascii?Q?uXGPIXbmYNU7qTi8643HQJ8embpA9U7sjF7z+DJvfoBsBUc7yU3gAoi3HzEG?=
 =?us-ascii?Q?WbH6OvQ1bAqFnz60BNar84H0pA02Yz9/xEZ6NPO3l3xDYSzuN+QY8639yxEM?=
 =?us-ascii?Q?Q57vIXLJrzQNkWf/bg4Rok8hjaSfXRYeLwELJMLhS6JwiJIV0a92so+Td/Gs?=
 =?us-ascii?Q?eFraXtpExqvCPdPM6vlKp/gGH6eYo/PHrxxADJK8r92UNC+IrPOjjnXMEbvs?=
 =?us-ascii?Q?qNU5do8V1z74VlD6U2dNzuL9rubydEO+D5PTcWGEHNMLDQFM3Lj2j9PJ+HnK?=
 =?us-ascii?Q?Xsc8AAu0q2nvSOr112NI3LWlOV27u5mPUTY2YrOvg3AOWD7BzVFR9FEiyPo5?=
 =?us-ascii?Q?Jlr8XeC9R78hakad2f4kljg69uZYUPq4tjy4V66Ke/6IT5nlVItYWVDXBToJ?=
 =?us-ascii?Q?Dewkb/jtfZ5HGr0KVJgZ3wMISvf8TsvU/l+NdPOs2nKkgX8yLxOI1k6PN9Vw?=
 =?us-ascii?Q?oArUx1EvBRVvGBLPEMC9lzous3sYGbF/17O5t+ezmXYAGMFoVH41M0QPdALP?=
 =?us-ascii?Q?M2Y1HqeKjP5LIG//K6dFzLlu7cuHQ/cxAhasIee2bw/PeSIW4LmP5Ru1+VxT?=
 =?us-ascii?Q?1HEw4fSDGsnlgjHw4H9t6PabvESLHI8sUeYmooI0E4uu3zogoWvXBLklMtX2?=
 =?us-ascii?Q?O87GQVcxg0NAkR/ch3eDCUefHratOVsYiZ06Sbs+3PQeVdBuSBhX6J/uQyvs?=
 =?us-ascii?Q?t7BFVFklkMUl/hI86Ylvx4NBUDmGzAqZCI0oQf7BM6wwvA1Jwz4gsvc7T2DP?=
 =?us-ascii?Q?jacG3srV4aS1B2B2ZfIiIfBwA83neXJWsQGGo5pED0UFeWVDKjFfbErkxYMD?=
 =?us-ascii?Q?ZqlqsMg0B2NCaiXggJwE7lW+Npl4uP+00WmBcPPyRA83gAwY6Vk2T25Wpf1S?=
 =?us-ascii?Q?a3tP2lIIUiduaaGq9a0KDmP+sxp0iLTmuZP0oK4zW2yyKsEnd1aFAACjW5EN?=
 =?us-ascii?Q?Xi2gQArRdp2ZBsCxTNq0tAAmNhCz+Mzq6cbOoE+eSPCqXlZxMuqqnzuzmFgP?=
 =?us-ascii?Q?LeWV7aS6ZJ9RP7H7mu19JqkZEtFMILX33jMP26dxmdCrBKuKRSfMWdJZiR31?=
 =?us-ascii?Q?ebGbvIskcVPSbdvCHtbqo4cxGj0qEQHBrd3xbGI3/9+PHY9bng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:33.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a7c073-ff19-4f1d-cdfb-08dc89a21c3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934

Check the deadline against the last time run and only
schedule a new napi if we haven't been run recently.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index a5a4dc21b9f3..f3f603c90c94 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -60,7 +60,14 @@ void ionic_doorbell_napi_work(struct work_struct *work)
 {
 	struct ionic_qcq *qcq = container_of(work, struct ionic_qcq,
 					     doorbell_napi_work);
-	ionic_napi_schedule_do_softirq(&qcq->napi);
+	unsigned long now, then, dif;
+
+	now = READ_ONCE(jiffies);
+	then = qcq->q.dbell_jiffies;
+	dif = now - then;
+
+	if (dif > qcq->q.dbell_deadline)
+		ionic_napi_schedule_do_softirq(&qcq->napi);
 }
 
 static int ionic_get_preferred_cpu(struct ionic *ionic,
-- 
2.17.1


