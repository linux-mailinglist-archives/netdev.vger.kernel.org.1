Return-Path: <netdev+bounces-179981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AAAA7F076
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630CB3AF5E1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698F622A80F;
	Mon,  7 Apr 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KuW7KfxS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55022A4CC;
	Mon,  7 Apr 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066313; cv=fail; b=NGyqUFwv1VCnikzejDEJUYBjxm9webj43dLEpKLwZ4Q6TNNOaFzh1j7lJns2empvxrj8enxOdYS/voVLGsKYlDUs+WefvQpCMkzgktH6L9SOaBNMh0q1wjaZ4sCL6XbPvpkb1mVmmBsoVsYXjzaJ/w0RYGR82ciQXLSKnj1umVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066313; c=relaxed/simple;
	bh=p06Itxrw6JrvHJwzgwdCAWN95qadbwxeFMZG19zncJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHuUEDRfyVt1mgkMi27LAhmE+O7ZTF/WXhGGuyOyRMOXt420fCtnAZKHvixyQkXXpDininxPWO4L2Q2K5DRaw212rMkr33qhJ0W1ihzJdTSzvSTvBDWuO7INE+v0XIPHU7lUQfpxdBriRRVAG8LPLUligesBKhGLYjT3JX2gEhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KuW7KfxS; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyiIPN/WUaqKZ6jWWnoh2nhbcYfEkhtjr3Q+MIaE9LO37pdXNjX/Wk2CREBpLQLZYtMXpIajiFx1DuZWSUGk8WzRSgC6RdwyonLO80ycrbVShB3Cndq3IvbeM8OjSnjaconOr6tSaXRdOd8es3H4kcKyw3We0SdVcdSl0I8dww2dlSn4Pq0+6LD3I5YSPed9UMHIIK8XXC578UssYQW+QKdUf7xe85IU2EGufzyJNDk6ud5j78zlK6uSyKUVKyLuUHD1FaCZ+xSdXh4BugFkwXlqrHccZ9ITOXYnRNelJmHgFWlR6pxl5Rcg5zmZTN78yfY3Y9yKlva5xH2xkiVr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P6mPLGKSYe29hou8fEON/0VDO3tQ82KXXaPmiCsET0=;
 b=VKrllFWHPZz66JZ8kSPfxxjpNLlRTcCd6rQgjBkkW8VssZlkwysDtKFODAHr0hjhrvStnwtykEfdYdAiuk8f/aSbtkmo9kzNKBURafMAzu30kHtg1P/48SMXxr5eFyYTUKh+0nFqAeeBm9zgH8h3Cg0HehCaKiWqQ9TyQQMrG1DLqWXKaXaS/KYOyKnQFPMg0bzl+ELvpaxkjHG0UF7IZgnHPeZfZv1rYuv7LkIHbOOy3Er0ClcJtexpXKthxfAZoXmf2BMJg5eGxQLcUkqlA+6hIdFR2ZfsDDNYT/SJIQEWzeUNJrnHGO3ofyLwoeftMSgWlpHSOHdPUNFG/csOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P6mPLGKSYe29hou8fEON/0VDO3tQ82KXXaPmiCsET0=;
 b=KuW7KfxS3NEqvL41foGZbkG28qZKQfyc9yaEnSBh1RJEp2qOv0KUenGUAWyMhaP2wkqguSWSoX1tFVkpU+TfRLnLMkFlT/peBrGvBJtcaubT2RYKzpVECpUG3HgS7xatLJoFUhEiQzmOt9eLyACSjGtaejepgEGGiTrR9V0RT/o=
Received: from BN9PR03CA0082.namprd03.prod.outlook.com (2603:10b6:408:fc::27)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 22:51:47 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::44) by BN9PR03CA0082.outlook.office365.com
 (2603:10b6:408:fc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.47 via Frontend Transport; Mon,
 7 Apr 2025 22:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:43 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 2/6] pds_core: remove extra name description
Date: Mon, 7 Apr 2025 15:51:09 -0700
Message-ID: <20250407225113.51850-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407225113.51850-1-shannon.nelson@amd.com>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c8aadd-163b-4f56-5c52-08dd7626c690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VH4km9f2Q6DjcQoLFbu5aJAwNgMSp92piJrT6X3/Z3MxFN3eW2HWOHXGYSO?=
 =?us-ascii?Q?1nOk+X278PiMzZXxdxJXgJpXoCaBZoW50K48v4Q3i4o5U+WsYVkKv/64smZH?=
 =?us-ascii?Q?bx+fMX8k8oGEpdpG7j+daLLHpPry6a8rnbBhGd4WV0W/Cum1ENR5VjeFu4ta?=
 =?us-ascii?Q?6epwNRn+ro+blsp2xletq3kV9k6TQNCpH9jkXxzUCvRBCCzgXD7pzNau50hC?=
 =?us-ascii?Q?4r/ivQpSPh4MAAvAsDMXUeW0w9wiYlyxPRPzvbmGQ1+HOL5kbKsEpLguQDAa?=
 =?us-ascii?Q?KeJqnBpyScU9MHDpTv0Ev9atnMdkykcYZkEOVOFIokESVZIz47lDbBZBV/GR?=
 =?us-ascii?Q?Zjt29S+6FpygRQGCqi974k9fUCEMsynjKxMRBNy8jXefv25uEHkV/cdyz2Jr?=
 =?us-ascii?Q?3oi6zCDkr9w7udK6aB0owcP5d2UgkF7gg8kj97nPhwHKKFhwRt0fkq56qxTN?=
 =?us-ascii?Q?Zho6zpc7U93aj/qIltmGX7mzI5nE+WUuAvss1EPwBi7H1oeHHQter8qviN0F?=
 =?us-ascii?Q?Ohts1Y3avZa39lYPlxaJfXIkUliW0D1pDYHN7Q447xWxhKZOhh79M0Hd3rL5?=
 =?us-ascii?Q?IiktTLSEXFnpfYmnXydyvpHnLcTEvgpJfzxnCeMvhyNvytQniu4A7XVVVfJc?=
 =?us-ascii?Q?M3BVVnqMn1ByKdvnZznykvWviWOjFdYomqLvT0qPHXN4kPle13qpqHVAFhYs?=
 =?us-ascii?Q?eEubLor8jYorJsl7V4XKbXrG6g5DsJvegg4j7NGGNQhoq15daE8bfmIYCtE2?=
 =?us-ascii?Q?2PazfPAHLbN20VBNKsiH5nt8Rk6SqVaqYVyKxE2InGj0JXxJsuu+MxJB8yYc?=
 =?us-ascii?Q?7BGadmVoHBu5RJMzYSecQ9+g2mjeJMyd3+FnavKkx5/b9PuS/KQZo32sEjxC?=
 =?us-ascii?Q?oVxUOPIbWjWQWEBg4oXP7+13MQ4mm+ZLS7DZl8Z0nJF2Ud5LvS4l1aBmQYJr?=
 =?us-ascii?Q?G0jG2ASxFjC4HeOvb/OEyv8i9jkbOOX/ds/QmgWfkWSTGadmxWNhVuLxvHXn?=
 =?us-ascii?Q?/RU97xbq8zLkWAIU/oLAJMSz4SSZmWFWARbvMJQOnae/8q649gTDQin78wTI?=
 =?us-ascii?Q?LreRExql9WrzRvDiYedzkzfYWXvUGIlUm6ANVkajI+4RPXF9pVk5t7SlGqFS?=
 =?us-ascii?Q?Mmi4wNsN0kv7o5T8gqWyQcDom1SYnoI0gi67tQkBVSi2I32glSXviMgFfgu8?=
 =?us-ascii?Q?oyo8xreY40lHeZ80I9Cgcru7HMnWFC8cqPtGL9hMWIMNitpk6jYTMXcXnWTf?=
 =?us-ascii?Q?v3MJwexJwemgHveTyuVrBRTN0xb/PFvpDu66oHp6XmDHSJJvXYm0lU2q66pk?=
 =?us-ascii?Q?1Igw+k5Z1ncHKpOOUJq8Nm9/Idtsv8KKx8CkLF9ezygFg8XYusiwsyD4DFmK?=
 =?us-ascii?Q?np/f5rUCyMRJtSs5gbqyEW25E3H6QbhYopCu+wAxbYMxP8v2hN3Hl9fqaqfF?=
 =?us-ascii?Q?PzLzRf2kjRmizLj/T1xvsMYMrjl5XCpWOx5uJ75OA1BlPacxQF5SKqmzqttp?=
 =?us-ascii?Q?i3V4SxMzhGrx+f8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:46.8194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c8aadd-163b-4f56-5c52-08dd7626c690
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060

Fix the kernel-doc complaint
include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
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


