Return-Path: <netdev+bounces-104698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4F90E0F0
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7263F284969
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF2A93A;
	Wed, 19 Jun 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dg5uG3Gn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B4A920
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757237; cv=fail; b=rzVGAlfvpNYXSr+nss5J5U3DpZi1cFzH+pGkWNSemUp9VAAsZmKxTJNIx/qdWzS9wdpW6F2pM/KIfc0zVVjt/PCjhHVFVw/euTh4MHf6oaNjNZUbxWhC3LlZ8KE8ki/opZd7tHtRWvqBPKKjHTBWb+CgKr60q31zMISiaGi7wdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757237; c=relaxed/simple;
	bh=t33wZQI4GXJOHyKVZvr+MA4t71TSiWrMmGfPjn+3XWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk+FN5GA4s+cpDYNSykNgAA0T7Kd6zwEGDu+RrQ4n/UqQObt36DcNPjYojmzxRRd1KMeYaDkm7oETkaEjHxKi9cg6oG6/aADDQWsKr709ltK4Y9utN9NNVSiyyzTHKmwZr4roTMvNrcYPqAfhkGaxGmojcifVAHTKUxZ+sxPN7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dg5uG3Gn; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAqQQpOQoy94wo6CGaG34gfmJvqoZQbFNdWLzNDsFxSIXbCgSHH3t9ZXe2L8/uy+jlQxvwaCPhyv1zPq5LKiVB7oVR9acLzanbAKgSGqSj4IX5BL8+Ktf5rC7jRxMGDnQcchh/CBMoIyqOwLA0XkWMudiDZjeq5B5dNH7AAdiwoyCqT20VIGhSayT+3sQb79VI0X4diqCMegpiZ78XF7YP8twHsAwZXpiQ9NXmAZXwCzkMBD0qHy7ZP7XDKoPY0HXxXc0z2JB6XLgNWc3hxjjzuVDjw4xFQK8R+Xni9YorL5Yf2Wpfw0jeuKVUIOABoP5FZDPcZwGusf7AhnwYcFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pNS1LYNkHzBVGxpxpPaPzmrnkxVxFaudIEfX5iWu74=;
 b=AYCcgNjaUu9xdyWV/9IMaNpA6syZ2nlUECiDOVo+72p4eFPPOU/aIBqw4zfDAUn3XnJQIclOAbbUSF4V+tK16ZXgkoams/ikRpGuI5VwHlvggLmrSUc4Ho66d1b1h11w0ZcNNqk+PQECDSjzDMVxyS/FXjmCYoI5TATwGs2PheYMdNDQtZCSxgMnTZwDtsduW4v6wcNIR6zQoQOMVMCf0Sk/0p7/fpoVaAZJp2ol5dUnR6eVzJs1P4YNny+rBcMixhV175y71cfpdSFu1DJm+DLgDzPK2Gfe8Z68c7/4oINV/u1PI+2LgSJd1+cBjeRYElLhJsd+eYeyOZlQAXocxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pNS1LYNkHzBVGxpxpPaPzmrnkxVxFaudIEfX5iWu74=;
 b=dg5uG3GnTrG/Vn30QyDP89kTGx/ejJX2Acld/jhP4Ew3MrH4NfEwGzAcgfMxqurnmjMZbaPofDyz1Z0/jB6/UcRI0HU2pj3EtgQdSerdnGMkW48p56gqGPOTY9nvvZxDonJBCS9yfrRNEVNhHCQgE+2xGbRvHljbEsw8dWtnaCc=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 00:33:53 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::c2) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:47 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 6/8] ionic: check for queue deadline in doorbell_napi_work
Date: Tue, 18 Jun 2024 17:32:55 -0700
Message-ID: <20240619003257.6138-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619003257.6138-1-shannon.nelson@amd.com>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9841f5-56cd-4499-d04d-08dc8ff77ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8vSxMWSojw+AAiKJgVmiWR6b3Ac4JAlEOAcLHs9mYDRqs554x1JIw9DJz/ss?=
 =?us-ascii?Q?n6i56QXwyZNR5Bimzqte80ESutDnhlFmUZltNxXsP3fjcPPdSZvpDVSpPyhO?=
 =?us-ascii?Q?74pF0aqOQYsfVPEqUfUNCNR8Z/Zj0CBdcBJUBg/aSjW/guCMzX/VgJj5gyL5?=
 =?us-ascii?Q?o4tgbUDkD256/BaH7I9OV2VJS4JpbV3e2+8GEcfiXWjnLojJ6BNCa9DO+r1K?=
 =?us-ascii?Q?f+pqg7eqC99Kap/GXvYDETJ2ek8rmOJGQNx916uOy5ridOS07/0qHSJ2cbDg?=
 =?us-ascii?Q?vUy1D4i9nI1b2L7lxxUPLuSVGjTkDA6RtLqoPlzS+0/SbfVFJ1TemH89tbI1?=
 =?us-ascii?Q?uFvBfDgkrRArDZzw0Ej4uiZafMULuY5ymGhuIBiXL2TzLKMiXDC5OzhfGR1A?=
 =?us-ascii?Q?ad4fuBM0B0pRitPCK5E0AfmrGZAwqFJihMWN/SmEjF2P6lSIGtCAWe5lZ0ho?=
 =?us-ascii?Q?rFeqYfKIIAwTYaCkTScMmCLpw7IGbdyxvsNiCQPbDt2IoJBJX5tKN5PBdu3O?=
 =?us-ascii?Q?mBqZrm0OSWilwLf5oQh2ZQtMcCEeiykKaRNqvwA/FpqlObz62reOfCJRIfFt?=
 =?us-ascii?Q?sAIPgUnN7CVefcTO6RNx8Sez02dPyIOx0BhVOgMiKtWqVqE5ZPgGPoXHimXG?=
 =?us-ascii?Q?4KhCTqrlWL5TXmZ9fFs7H7Qr7E1skXhUfa7qhjXyRQ5ElLzPZoNmpa4J1IF7?=
 =?us-ascii?Q?kgwB8tYSQfSMlrfplDlju9YOm7Nrw+u6z8CtHNGa+IXMSJcg1P3h9789ufZ3?=
 =?us-ascii?Q?FSP8+NX3RbABXEow3pyAd3JVDxTsPh9wKkMErUHOo6dLik/jXQBPL296Lc/2?=
 =?us-ascii?Q?/YjDWaledIV5CcHOXW1JDQ5BKaF+ash7Uis69Ptnmu04sEPzNQ4NsP6yWyUo?=
 =?us-ascii?Q?RisOn47QVyYs26M/ZPHXYvwMJmg6RX2evLUzk4P6evz0s/0A/Ald+9cOl+1Y?=
 =?us-ascii?Q?Bs06ZZNsHdLqhgVsA6xSeovRO+efYdiTED4B9GHHAwJDLV3Kn/c5JXuGFlnS?=
 =?us-ascii?Q?PATJswJ258jCBQWz/IXT+znH99gtvfv155HRhXaPdzoNAcGXjECkU3RI7SXK?=
 =?us-ascii?Q?1dCz/1XbnOKUyGC29WBYOB3Ns8kVI2klIC88E9yBLaM0hBMBXUkKuk1ZkZqU?=
 =?us-ascii?Q?4TS/z/K0dl0e15ijB5IDyoOMWaceRqNmz3mTNLCyCP63lgr7OZ6rsmYiwoj9?=
 =?us-ascii?Q?lixsZjjCYxw23uI877XnhSkak85P4rnpzaIAkKaG6GAgTDaO1d4tff91wU6i?=
 =?us-ascii?Q?B/Hf4f1qGxuKxik4DAb2/j8+mxNOEwmnZ0zD6uSRLw8bNwkPCJUMjkcY5HPZ?=
 =?us-ascii?Q?9lT6qOgYo2vVcPZ/yHnqk937Ccl/z4UZF/H9ZE9c6N5Ze0VilBtmLFgSVEqK?=
 =?us-ascii?Q?Ms2HTt3+V2jnMuOQUjVZpSmDj2gRIoBoEQi6O75Gg7Jpojlyzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:52.5236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9841f5-56cd-4499-d04d-08dc8ff77ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

Check the deadline against the last time run and only
schedule a new napi if we haven't been run recently.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 56e7c120d492..ec36ace6d010 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -58,7 +58,14 @@ void ionic_doorbell_napi_work(struct work_struct *work)
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


