Return-Path: <netdev+bounces-78181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F38743F3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5501C2039A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98131D543;
	Wed,  6 Mar 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+CbD/4O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D641CABA
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767834; cv=fail; b=B/BL64hklLbttQABdcqskZmbECkBp4/J/Stp8FI1HMDjIOhp6vA2DECmExKsJ46BkVsHghSKK4Opu4C2SvmOtl3rUpEmpWJb5gyFlCENjPVqwSEdsAf2V74imXLh7VXRnrdFeQqz4cdD0W2GTyudPZ35K2d3PPcgEsTkHEqC5fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767834; c=relaxed/simple;
	bh=uyjCLP0qD9bmHi3aF6j/tKwiNZCIWV5TOm/AyUiPHvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4YyrQKO8SXE4q10dWwQUZL0wF2L+CO7GBoB6UgUA8qUBmez2vqz0uKU+ZSC7y0eQurvESE5t3obFvYjqs+1AfyEOEZS5pJfpImuBupbTUrowFZHWxHBY3Ba3lefHTXEyONyitaUkiVY0Z4Rh/cbwRyBTHvQu3HgXdiYQo3r4uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E+CbD/4O; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuwKaKdW0C28533zu0zmZyPr0jzAO28fUurMP7a68tCBkeRoRKQqk8exZPZ5Pw7rLJUebTpqnWPMqwDsdXw75oy/Mq/k79unFERlP8j9tCp4mdOSRxXi5uhz83h+kw9Y/kVX0FuUnpQcErlUcxGCmSnYuU+kRiTXn8FRTBk6ygM2u8ya4DUhLFOHOxF7YzOp2u8BdKeJkVUWIZ81GEItV8EvZdibOpaa+FzX5JKGZT6M9nsn+u9LatYyNGpaKqJDZVXsb6ld0z2tpDJZ7hnoXyAGRbEuFYJEdqZ3tl/c0DLDMCQpwnWgwbFrDVdQtCVX4nSC/Xm63q+3PSuRfhHnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy+ivL543X6q3fHVrsS3Oscd1vhcIE3N2TMZU3YvEQA=;
 b=YaYdcdUBD1itSt+s0EZdHZSeNgjxRLSqg20yF75JGS8tA5kMNiyjcW1rXzKVCXxj4JteWcSRqxki4MjIzNgFQ+oHFiobGR0muIZwsc6agXi20zax66jMEGBemdipKXJ9bXaSTfm4NAcmnKf1SKEPpBs62/vvY43Ful9S5wQNNydqthcPfNoKlWAiK+eUn1mMSg51LSNbvrif2C9II+vVlZAmPlbHjv/0lUYOD19r4xXim4MEOcas+R97SMHkM/wM3+bmG8oQEsCA8+ZwcvJCdtygmugmQyC3R2WYObRvViZtPEKHLoXPGga/ZtGrJzrBdiNzL8dlHtq/yMJnheZQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy+ivL543X6q3fHVrsS3Oscd1vhcIE3N2TMZU3YvEQA=;
 b=E+CbD/4ObL/PwCTiaw84zT1c9xER3LRm667PqisTpo8zXRcjT72piU+ujlWS3ifR0KAHMHwTM8NikHnwbxPbWP4Tjds5D5cr33FfqOhia4+wBlL9TKQt8kvFeVlxAZkqh8kJhrxU29mN7Zfu7kOm8LMFE35vGsDKPM4PUHWHhZE=
Received: from PH8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:2cd::18)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:30:27 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::12) by PH8PR07CA0019.outlook.office365.com
 (2603:10b6:510:2cd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:25 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 11/14] ionic: rearrange ionic_queue for better layout
Date: Wed, 6 Mar 2024 15:29:56 -0800
Message-ID: <20240306232959.17316-12-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dcb988a-2b21-4187-6507-08dc3e356763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vhxd/RqiT1YosmGYoZ38BCGxxbQfmBqeeel8U0BZaEJo+rKVbL6jJ/ZRv/JD0kbKo1sy2b5eLCujUy8Hup6TwRovjvahISc3It21vUSPgh4jv9estGQMh9pCOu68AxhN4DeZoPsu4kx2JbceUBdJENeJd2gA8zXncGJuaojtFYjKdtKzRzw1EDJGHIKhaH6gUAYcyemi9fFel/BKgHarGF4Zqj6vzGhKw6HlWfJ5ASksOeuWrJ66IgoOn3yxw/MgTrMnh6Mj8fMzPAiFg6LVRejYVw3X0/XPwHO2t+MAqQngBN6VD7C6Dx7aplMvyPGNjTK0jYzFt8u0Nxb87l9JbnDheWF/x1PeWpThp8K3Yb6eMqiXECddYP8jb3fAdxaejmAIVE3h5QEJsVYSMS6XZfmNRNXOKVLM04VAAP7NDve/xSvas7u2vvzniLg/EUZ5wEzsZrzd87DgZdDieFZe5cQHqB+7XBZTUvSgWrLsNKzrkZbyIPE/XxoJJPLKqNv0fdsmTbq9qdVQ4e5W4BCD0A8SFVMZagdjQJPgKHzSSRhXLSzgOFWbesNfmkIiRiK5wXubw8YXeo4lcrr6LPQx/2mKZMnQ7AYhr3cVgtLUb36/yhntFI+PQdt6+ZphGA7iKWvSrKYB+BkcG5e0/4ad0Jus4+1/Fj4uCTymVPCSru/s6zWZao3DvByjperCFLzf10E8/OuXdJOV3Rrlg1GWyrTAYYNSSXnGoBXq1YZs5rNxGLoUamOeBEecJKRzTBsf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:26.7898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb988a-2b21-4187-6507-08dc3e356763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257

A simple change to the struct ionic_queue layout removes some
unnecessary padding and saves us a cacheline in the struct
ionic_qcq layout.

    struct ionic_queue {
	Before: /* size: 256, cachelines: 4, members: 29 */
	After:  /* size: 192, cachelines: 3, members: 29 */

    struct ionic_qcq {
	Before: /* size: 2112, cachelines: 33, members: 23 */
	After:  /* size: 2048, cachelines: 32, members: 23 */

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 2a386e75571e..f30eee4a5a80 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -239,10 +239,10 @@ struct ionic_queue {
 	unsigned int num_descs;
 	unsigned int max_sg_elems;
 	u64 features;
-	u64 drop;
 	unsigned int type;
 	unsigned int hw_index;
 	unsigned int hw_type;
+	bool xdp_flush;
 	union {
 		void *base;
 		struct ionic_txq_desc *txq;
@@ -262,10 +262,10 @@ struct ionic_queue {
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
 	struct ionic_queue *partner;
-	bool xdp_flush;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
+	u64 drop;
 	unsigned int desc_size;
 	unsigned int sg_desc_size;
 	unsigned int pid;
-- 
2.17.1


