Return-Path: <netdev+bounces-186105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0517A9D332
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F41B84ABB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BC224227;
	Fri, 25 Apr 2025 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nckyla09"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1B223300;
	Fri, 25 Apr 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614007; cv=fail; b=CwTglfKrbO53jxit7+fRxAWg7hN/N2rdxqnpQs53TbuOozDQvbff0T68M7ds3f6INc9pTYiZ3G+ZEio7/b7cD21P5RYZe9bFqWqYglU6J/U+MIIJSX51BqRyBaZIYtnfEAxEFM04Cu9vw88YJGs7eB161gXw96XQW7dN3Xsd83w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614007; c=relaxed/simple;
	bh=44QT1Dkz1szFuS33SWwg3vfi0RBJRM1LxvTRdnQ9BiU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0qG5zimSw9Y+OzXXZXBDJ+MEZSBiziWogjJwB8CGrec+cid/MhE9Dj32pmp02A42UPz/3uS/m2sWV36RLc3JhnJk+nfTfK+LROQjiVEDmM7oQmASAa9+nSbjL2yv4xv3v8pch27IYNe24Gnp1d0ttVPrqkSfvLqnwyv+hv03Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nckyla09; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDMuAp2VnW6dmr81mCtC5EQQjL3Qhs1EN8uC976FHWVhQTufdrGY9Ic6YRxdIahRVL1lIWLQzCA/MmTYzc+WlM3N5f4j94Vq+bzZEyGIKfvXsXh6EhcGyVJt6ndV13yTdzBY4VeGdLXlocJKWPSaRgd/y5oepQI4WfVuizUOKCqz6L6DLNNxS74bdR8ebEwmrCj5Kxdba0I+1lJ1/uYEfT1A4JkB/tbm2xxrCKyvIPQ/NrUQ3nqTAiu29LR7QAKmrJIXnCYtzns9GY+JGCiFMgH5SB2pm5+CurXTmo6aXBE3oSE3lMPxfuHZ1PaPfD0bw8x2VJxFg7JF5RFZzUVZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPJB8pMA1o7H++9v8qT3qdHmziRjbtTrrzF5HB7mrbs=;
 b=U9gW/A+ate8L4uUexH5rJOGktfG2bxchJ6qRAKSOEd6BTYAsrI6bT2CeFECZS0B8LMFkLlpBJhUSPIcyooAMLVk/fizeuuolXDnZXDjbLsb/2HpnIYXruvpS1JRRI5hHJBGamWXHp3hRM+FBa4eLtt5wPcmplCbtsBFleDe7EzEhgtNWtyEX3O9jayXs/r0dbjyRPYtC5353XuceeMzS0KSeQEPsPLQq8ZIthHgMI5TP9+u34yVy3FG3QO/+aCxmjX5pe7sFBso41o7qZOkcxtdUnAWKQHS5RRZ4+Fzzl+fSu4dHQzG1ccvZ4M0D1kh+uQiLWmqJJ+w2Fm2F6EcfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPJB8pMA1o7H++9v8qT3qdHmziRjbtTrrzF5HB7mrbs=;
 b=nckyla09zf9HGQkJX9zUtVUgG39R+rw9qmLhqBqouRNuLDdvw1E0Wig8wjX9uOfL4+naiPkEQTOCjKa3oExWqLu7BaG51ZYRoidtADFFHR9ku5LZC2gkRdDcc9R58ggdggVw/mrz1E4M9vdM3UDC5+ClvLoKSZnpmcdLeXilgS4=
Received: from DM5PR08CA0050.namprd08.prod.outlook.com (2603:10b6:4:60::39) by
 SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 20:46:41 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::77) by DM5PR08CA0050.outlook.office365.com
 (2603:10b6:4:60::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Fri,
 25 Apr 2025 20:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 20:46:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:46:39 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/3] pds_core: remove extra name description
Date: Fri, 25 Apr 2025 13:46:16 -0700
Message-ID: <20250425204618.72783-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425204618.72783-1-shannon.nelson@amd.com>
References: <20250425204618.72783-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 13033425-ae43-4520-cf72-08dd843a4829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TawHZV/jW/dtwR4RGEYMfcsRAOh6J8Hv7f2h1ZQde01iIpSECTC4heYv9CHK?=
 =?us-ascii?Q?s4gs4s4HY8vlKVmEpS6Hv+dmGMrJDFMFDb9EgXiZ04kqkfO8d/eld06YTYX5?=
 =?us-ascii?Q?jDIABHB0OmSVY3RbXCcSd9qd4h1zlKqK41i8cDVGU75/wrthT/WAStQa0P5d?=
 =?us-ascii?Q?deWpC3y2F+lgJ/twuucn9GHB3LQAXplQXnZwkHySOvsubqG0N1RrMto7JN0t?=
 =?us-ascii?Q?LdKMjMVMH7vso0hCeyrtQPo97R2rbarlBdUV4A93AGvVoTRL27uELgfGBlJ1?=
 =?us-ascii?Q?EJ1IGrRjmn+XT69019sOowGECi8TWxkxe1xjAr0VeId35xBujPOMzZnPSTEI?=
 =?us-ascii?Q?9Qjpj1AByXKdoIjoLVI4fc8EKnnaLvuoagmj3hqViYcFMrDHFS/JNhosoDKO?=
 =?us-ascii?Q?QQvaEhNTLxFf5XQSXgTP1+Wn6GyN1DbfiUY/aEZacQa/3P8zDfRFqWuFROCP?=
 =?us-ascii?Q?y8jUSo0SqHpgmqZvycJBZl63dIWlfEDtE9/Fx4KwsIuF4mipjTYWj057rj+k?=
 =?us-ascii?Q?xGy+cjHNlKTrYzzV537WLUk0coM1rEblrd/lDoBqIiv7JpbI17uJOR0sFOvl?=
 =?us-ascii?Q?WxqMF8XbeQ1tsKKcHOxOhHdO/DBlzOCbiaxnJqO1x3Iyzeh5dUyDHcvOUxKQ?=
 =?us-ascii?Q?oANlBPJWO17dzVNSImg/8H68doGKC6J0tWAJqDEW1QG003U4NkOz4HSiCL4s?=
 =?us-ascii?Q?ZAREEbzvPQ1EynI4pGoc2ksvdDMmiDEl3bAwtnJocymu+Okb4G3a+Zro1PGF?=
 =?us-ascii?Q?jLqNTe26kx3PFo627hK2IeNaH0tj1eTUl7TEjwEbwYFGG9H6BUe8heGaiWWl?=
 =?us-ascii?Q?Hj9Y7EbyVYqvQg8/fqqRWy5KXo1BZU7Zqa9iipOxgrOmbwFQX5s6XUETs+qQ?=
 =?us-ascii?Q?w9zRyK6IE7lCQwtuTc78Y3QGcBsPM/ximMdMe+w15AmzQid5mTQZ6Up80egF?=
 =?us-ascii?Q?mLNKvRoGOajZntftgsEXEsxAiv4eKyUZy48SVxtVgIx5az8yPoMHC1yZKXvy?=
 =?us-ascii?Q?J4uNlcXO+DB1eMfsytgS+0IJxrQrKHSgqcayMM5fFThGp8Yz5/G5uorF+jW6?=
 =?us-ascii?Q?BLDVUc4ryNtfpALVGssesjHr6L6lQkkosowxLqNR2tN2BQGGcoCBz6Alv4oC?=
 =?us-ascii?Q?14YcqIzKpFxK6ednCWIYQ/uzwAr2XTJuLhjCP+YP5rPJU+lI+40fOabijIuq?=
 =?us-ascii?Q?C0TfO7+8FqrvtADZ+LQ0NdFDnIROBWo9+Ws03hw67uu06dZf/aS2sdCX3KsL?=
 =?us-ascii?Q?vRySUH+RbU1Na0Cikypfpdz4aeUY7a3NtOA7H7D7nLnw50btfxY1jbcmDk+d?=
 =?us-ascii?Q?/AbFQPfUoXq3Ps+H+DGWfu1ooY1h8umf4XLmbueVS8OeVlBBFKpp8m3ap9z9?=
 =?us-ascii?Q?OkywU4nsl37hLogo05PAyRVDd2wd679LlqRfwwr6FkjcI8N7gVVtCM1yd+DU?=
 =?us-ascii?Q?2wS7XIe094EEmxmV/hwl+SkCIq+vt2uaIW1eIfRMjWKJ7afRzlmBSsGDSFop?=
 =?us-ascii?Q?md9xe3IhfBn9wpxO7pZfTofDg6p+4N0xKEKl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:46:40.9522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13033425-ae43-4520-cf72-08dd843a4829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

Fix the kernel-doc complaint
include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'

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


