Return-Path: <netdev+bounces-76314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994DC86D36A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E62833C4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C35142914;
	Thu, 29 Feb 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CTM4Fw1x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2941428F5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235627; cv=fail; b=ZVAzJ605ZoMQU1jPz8CU1MlqlzbFrRLeu7DD89rfSq/aT4/Z1YN2TVBVn+mCnfHqVSzAhGf7KVHm7Y/w7yyauih6SRTnFrYJv9vf0WQHM7BlKEAqc8X/sC0U3ua8lHBb6ilCsrTgwQRcHvWns9lNFDsd4os2OB2HbwB0rMuxt+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235627; c=relaxed/simple;
	bh=9n7JoX1i/2qbzDcNJlmknZqkn1hvM0DAYGSd4LuLJ6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4hmcPsHD9cnXTR86b+O/l+RuLogLYHvUDAkxvxQ9u3VG0mbZuB7timHblqJKAKFtaMoRhsexSUjc0NMqz/HOHu2KxoTLNS6hdu1eQ7Qj3HioMzjnnGq6BcOhu/wcRPzOd76D5nUbnOnP/nzFUfv6c6WQdeUvxqmDZrxm/cJL30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CTM4Fw1x; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ueqle6fddf4qwKFj9pu7HsvHWXC8pwld0FgEtqsdd4cSVcYvclHukI4TPiBfrz5EQgM/Xt3lCOqHzYS3c23a+Smttd/RSvmGFF6SrzBW97heUUIvvxAIoLSLsJggaHhtILy8XkPYSgaCI0BMEjxqH5roaCFsYYSolNfeM/bjRVPO/TOUTOQ4X7Tzim7CeisJ++kGfcjdU4zAt107lRh+iKXj036Tq+5exn+w0InibykS94MNVHaOg3YtHiy/RxCqKxnpb/Egu0hpjXaeNLGTl/vE9VhtkPyOwMnqQOeT2UdZ8rcM4sKKq+QO5sUy/nQA389FEz8BobJu1ug1if73hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwdc8gcVMLrAhKcOwROR8vnRZVngfPMyhg+/C7YTjes=;
 b=hTizm8lNwIwkmtCQRzxFVhSLmeL4s0e4FKFR6Ln3y4whkaee4gNi0L2WnjjAdAtyjySXKx/jEwPXOga+ylOh8uSy7gFVPgjIomFCkg7cQ+5YTUzjW0ysGpMyi8l8OHxt2nNQLlYHArP4Gf93hzNpEwD8cODexdq4MmuS/OfQHJNlH4yO74dxb8nSAhgS+OjIPBoI7ayydLNORGe5r4663+WazGPMGTgDR4YJNvZd3GKN2U/IV/FhuLxIH8BDYHfXvkn42k7fedr66txmojYKAawYkMZ3+MajPg0viUkLmMgGCUHL9baWp1tJ9cYeMN1+pj3j752pL9ZFuOMMivy8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwdc8gcVMLrAhKcOwROR8vnRZVngfPMyhg+/C7YTjes=;
 b=CTM4Fw1xepr7+53IglE+I7gDZGWcf/r9Fkp38TMI3Y2IMDh6yTaSiA8HDj8wEs11kJAesLBalVORRAQVqJPllZcy9OBgWcal/JHY3otrHtA13GN09inIUu2jrEs7RyfRENfqjLhC3+mwIWLclV8UGABQzgu+6mCpgmaA8rqTwFw=
Received: from BLAPR03CA0166.namprd03.prod.outlook.com (2603:10b6:208:32f::18)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 19:40:21 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::ed) by BLAPR03CA0166.outlook.office365.com
 (2603:10b6:208:32f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.29 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 12/12] ionic: change MODULE_AUTHOR to person name
Date: Thu, 29 Feb 2024 11:39:35 -0800
Message-ID: <20240229193935.14197-13-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 6854d129-0464-4641-5ea2-08dc395e43c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nMSIEuc2jpA9qr710IbLlUwNygWAlzN1f5iq3y5mzRwjbVSiOVedrcO7+Vq5GrcZVVrLbBQBG/f9Q8TIFSCda3dWitj9SgR1gOz5QZRehNdzF5qTbvf/pe1JHpSB4HnimAizVgHi+u0PiqArBZn3zgKaVWnx/KXolgFlRLSPJ/9KWMcnHqojkvH6A6IOj1fvPQqxzKoqdyEfvn9fTJIZOLSoYqmefidYliusLrp/UirEckoQQ785br7tWFg2qiwqY7/SuY2uSexCID40euKUwYMSgBsTkse5EN5Io1VoVV5Yy87GTo9wczvOboaMK9IZx3kHUxCb3uIrkTTplDsMaeJcwm8eHeWoWlNZLzaMHqwEb67S3rbWcTXm2KezVIToJQFiILGZBsOcUzkp+Uxy8FDefTXgpIikkJEPFdbKaT7mz2squs0TcDLyZt60sW2HR2eABeJA/ePlBRtHoawi42sn5PEMquNPx0Gjp7kWbiqJurn/uCkEG4fzhPx8tiCJwJZTuxFUUCalmP/b5KMDw5dxDIZoNrPmwCWuPfCd/v9U5XycCl4eWRYNgPFmRuzBva0ftGSQcAu7uMGhYpxP0+Ccbt//6EGX7ZQo4a9A4Dg0qNojINVPFh5s3T+pt5lBjB/AY3yVN7mro5OSYu89K7U36UbLg/d7vIOYlOW0flw9r5f3Gr7jqQWLZ9rBRvlwLvdSa6JdMbz0qfgNI2uNVLxhXPhXEU1VPiXZ6y2EkqNJ+nGM2pXnt2xRDTzqL2BK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:20.6303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6854d129-0464-4641-5ea2-08dc395e43c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

The MODULE_AUTHOR macro is supposed to be a person
not a company.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 165ab08ad2dd..7a1974668d4c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -15,7 +15,7 @@
 #include "ionic_debugfs.h"
 
 MODULE_DESCRIPTION(IONIC_DRV_DESCRIPTION);
-MODULE_AUTHOR("Pensando Systems, Inc");
+MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
 MODULE_LICENSE("GPL");
 
 static const char *ionic_error_to_str(enum ionic_status_code code)
-- 
2.17.1


