Return-Path: <netdev+bounces-76305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8E86D361
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5201C20B7D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2813C9FD;
	Thu, 29 Feb 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e+rIUtIj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F413C9EE
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235615; cv=fail; b=tnRqOwLFivZQjTbEhDJoiWsQhJOzcSr4WlmdoNJcUL0Iwh8lz487CvKQDEOax7r4hBEN8jP/1iCZ+nP3sDaMx664Sz1NaWLmb5nLFpLuqY5xBsg6/wT6j6VQpVax1SO0nj0yAyTJ96Yw5USq/rM85aJBmmj1LTmj5Ldw5oUPGkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235615; c=relaxed/simple;
	bh=/X9+fdZOveEot092SUoAxat20K+KGK38XNyLeEySxFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3LPXHzDsnIJaiocnuTNuwxF7lPz2+ffMWpPekAo7m8Y2l2bLj7U4QxxLQV8dpuqHb82+D4bEfmNEuIu4K87GPRTlhDGGZAHiKaJbJ5W8r3+de7qrPjOHLKY3PYVppScN/4JhojNW6f2HMjCFImW1K2AKrQSFcjh1fbYIvPc1NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e+rIUtIj; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbFRIhnIWpgv6A19kBFqjy/abM2q1KSHxgrozzrDB1SU0XPASX1LM7nI/5+4MygZBtxtz5mVE7EVHSGLHVG8vG6Ma7HDvK8kJ7KE8E0pwL43ttQKbeLXQa6BS3mEZnTkFovKgm+Cgnix+PeV9v1f6pq4J/aR5qMASLDD8s3kUO9ISPk28/wZu2h+dk1e9JAKPitkpVMLXIYJBSrWLcc4zAkfxCJ0kFdTbyY0h+hVgQQD95EowIzZhD0zQKlR35BfgcrAlH9JeNE3ec3PPZep0f653qpfiEnSjOGe5+ahU2ZtAILWIr1/376iSVf1VgZM8x8XJYiNFXLZeD5nNnvHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBNzh0YxLHsSAtaq3SNeLWpUtHCiRZejTjDvCuHEzUI=;
 b=k/cxhUWwVcMttFsOcpRoX0X5WyMQmNoi0CFUIivRavxxZCZGOJBypIuaChxMmU2Ev3h9s391lEvQtwPaHS2k2Cbud+6DPJdRxNuLy+wdirfPyj19RjL7KGusADPRU2+H4PmK8KTsFjxc+5I49QGyU+cvu4YG9IoLKPNSj1wRkcc1T//p0XzOHYn8KJaU+wClJ0DIlRRiZUOyctHEx0V3Rm5qc/ugXw1C3kZ1YAAmwrpsvi9ODe0aIB59jT3TF27wf2LECK+DmUOF3jz4q5c0S20UyCs09dWENwlMP3qpDCyzs9On8xoiN1qiH03VX1rdqG6StX5BzUPrr4MjVSm+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBNzh0YxLHsSAtaq3SNeLWpUtHCiRZejTjDvCuHEzUI=;
 b=e+rIUtIjOiS2QSno+As61oZVCbijLamWx6/OU4an8WlspgtoQiuikXLdCAJQckn82equVKR7PseV4Ngr+3XtDxAH4tRRHK42H9tgKvBzVGf6iONQgO9jZQ3ssNG5A7nyoNOUtJtC0oFlVqDR+W+2u0AG2N+bbbPxugqvyu1hKK4=
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 19:40:10 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::b7) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.31 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:10 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:08 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 02/12] ionic: Change default number of descriptors for Tx and Rx
Date: Thu, 29 Feb 2024 11:39:25 -0800
Message-ID: <20240229193935.14197-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de5b636-a604-4641-b2f4-08dc395e3d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NM53g2w6DfV4kdZr1aLPnx/XVU4GhARGDJUO5vL2F5E7lyXn7nD0oTQMlV0XsKtTqfsHFqNFmEa5YNgReyybNx+NMY1f8YQQKaXke1dDL7Jyyt/d+pjqChPQSzK+WSe79KtTtXBAh3+u6fiPxpF0QQ2WpqzSPfoL3o0fIGWISMQx0wFgVLQLdt4T9VPIDsDtqtODDgTc7cqYeVae7NZX4pBDJ5FLrUEWDtd6S3VoUokh9JjK9tHWTtb5ZgSdIDsoJb57CF5+2AB0q5fyrYe4cFXXFWiR8d1nU5F6WlFFDTTSMwKdgpiZaVDqgAk8cZmVXbM6yMtlLI16tUw0VGZp/kpSGfmnoAHM6aIXXSOXf5Rch5ZNZrIRt1FEYPRo2IYZobl0h3JzUNc3GJOT+IMCVDvVofyMn/zB6gONj3C4g5FVtJcX15ZZBw5J/6k61elUHY6jI/VRQZNMj58OLSnK70LI+iUR/FHdP36egqP3AF7dd093YBMjQ6/dGhgPJC2EUi6EkjyPFLVI8tlNQFaWw38GBp5rknBqAP0qLyfNzGD8fz1DLqwg7XfKRJwOuwhe8WPjPryoQNAE6OoskCDB1EPrZ924DLCbZXs2q/OOPJXMpig55o0hL6mEoiRHLNfHaJG6iG7vOr3z4t/jA1CxQ0EHpZ7zT71uVIRsfpeoKoSGxSxjWBF5w3aQwPccmo1tW0OQLMXAZa7vooWUi7Zh4BIzrgywQBBU3YNYu40jqFYwVD26gRR2soMYxPkpbyFu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:10.1301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de5b636-a604-4641-b2f4-08dc395e3d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

From: Brett Creeley <brett.creeley@amd.com>

Cut down the number of default Tx and Rx descriptors to save
initial memory requirements.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index abe64086e8ca..516db910e8e8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -16,7 +16,7 @@
 #define IONIC_MAX_TX_DESC		8192
 #define IONIC_MAX_RX_DESC		16384
 #define IONIC_MIN_TXRX_DESC		64
-#define IONIC_DEF_TXRX_DESC		4096
+#define IONIC_DEF_TXRX_DESC		1024
 #define IONIC_RX_FILL_THRESHOLD		16
 #define IONIC_RX_FILL_DIV		8
 #define IONIC_TSO_DESCS_NEEDED		44 /* 64K TSO @1500B */
-- 
2.17.1


