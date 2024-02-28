Return-Path: <netdev+bounces-75711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78F86AF9C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32216B2634C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97187149006;
	Wed, 28 Feb 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HsSCRp0G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E01487DC
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125091; cv=fail; b=ipQ5HBOJRtDQaTxVMK/61TJXZjbG13liM5m9Xu5ErNfUOc132XpafybZx7dzLOg/4eufcM8wOOU3k+C5tmOKi7Ppa7MmKNuOLpkdCycB9PJFdn3xNKkgDuEdVWI89Xv7fDCtn8w4lt1oXxikG/DCi1VxciDvfyslrBFGjGTKFlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125091; c=relaxed/simple;
	bh=WPG1WdFQCgWH205L4cyQIMK+IArbMBwXIAxOB8WErX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9OCTvrWkzh3jkIBJzUZNiSUHv2kOzHNSiAkb0n0E/gnne4xUvX5a5e2sTVHFcvBlCfEJ+h8rwqQVYpkzoBOl4Zm2oXuCtxZVujyzOWh5TLPmjeHmvnY6KTfDL8CNAV3MefQ7t+N060BUHHq37V6n5t+HMW1rjgWzhwLLSEM/oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HsSCRp0G; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov4JbDkp+YQ9g8rrZzip3uq5mpazAHIQFExjEJpXGZkx9G0Nc3QBpkAdQpw5OBegtVAAZ/8IdUOjN3phuaemdkRZDxJ2SwtDEWuOMQiLd917+zyz8d2fygEbMoteNq+Ir3q4ZLaDztMVIqD14Rs2+1ukZHwNQNs4PMyAAlo20cS60kbhCf+38VsHFlEf7ERUAGIbA7yG+yComFO21aavLpcbQUAfC5I53h+sLLVks3s5LHufZ2uM8szt8UxNl+VrblPyHvfDISs+F+9JVxebLhlwYoWyT1FddyKCQYcFq7vq3Wl1A9eiFjZYjTSIHgJ1Bq8ipBRtBFA1k4T7zyvrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sLApczNqqtZPZpFTMVngzXYhp8Tp26lWbudrMCYYF0=;
 b=muB59ZrFCiqQiKrZtRqsExjjHErdVXxrlE34MrzP424d7ljRvNN6/cra4HvVJlB3NxWdC9rRXKVT73GjV9q2NfARhoRNngH7cM3KlfoplHaI280fOmtZmO5xFkMeYfg5WgqybqjwacsEHI3D/PdQQBaLT1vmWHdF56RcY/t3XEzM6JAROEVhjAEkyfdjt+EZi5o72HYbztCfH1sIu9AgvQhKjcwlNqo7BUT/NSeND0D9VYLz2axOCyCdSJW1TPtb7jYzK1FBUM89LGSe5OrKh4YXXHo8nXv0zMOJlOyy956qxXg/lo/3/VCsXmycnO2KKrisSYSc5/GElZ9RTb1I9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sLApczNqqtZPZpFTMVngzXYhp8Tp26lWbudrMCYYF0=;
 b=HsSCRp0GC1TsPw4W5A7ThpP6yn9ModCdR9mzI3ttZAAYlorecDYPttGLrfc9kR0NUJjb4gWUOcmDKfN6P3PYKbvxk7SURgL1QjlgqWSN45rYprHJBsyjZz5yxp5SGIVEQNpsmRmr4hGmSIk9v9L7XttqVLtxHCQpsyBLZEYyCrjp/DM6iP6IfflgZpNAa8+48PlwTwhf425HDimgXjq10iIEdwIE6EFcGVYkNO1Sq1r0sxUKnnJtS2RoCwQQ9MDxJ/6MKS1j71qCZLDxpDzpCtgccN3vkAAt5tdvCZKDiDor4eY4UIvzs0q8XO+lOK3gjS015OMh+a7CuRngFjqDCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 12:58:07 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:07 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v23 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Wed, 28 Feb 2024 12:57:16 +0000
Message-Id: <20240228125733.299384-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af79acd-b958-4ad9-a0ed-08dc385ce89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7FMyLqTE8cHJBNiNK3jOFwML4ld4GL6bka6eyAiqm+X8JUCnE9W3HjfOQjQiorLjih+PDy3PH+n0I0MpDIus1e3L2Y3QOB2wjgPEs6+wUCmkD/If5rZrFJBMJ3oCmz2ZLtaOugpOdx4SyZzCCFSOavMClpZgasc4IbXTjeIrosCr04Z0mPwKQAGR1/qtrnvMH69+PzFYyjO6TzR9fELvnuDPpUa5A00U5nyr3VVctHLqT7c76waelo9POfrpA6+hBUqgOUqbfI70PJJODC/UX6z/OPwoI8QWMnSYHuR16OEWowD5M7MZngto+OV7iMKMjmJhtUgMX+NCJu7ANlWSCjPRewmJRDV+i8PCpNiRJ/DBv0/Wwc+JGjppAMfrTA7I+MCEG+GBgNMsjypX5YgxSvYMc0u0zsDFjmLmlbFie4QF8IOOQx/xJ+eNwXq8IrSaHnPAoxsX8nl4zRKDau0jHVcxg0GHpV52jOcl3I6YxYsq8tT8IPNJSEJpetonMQOjes4RBHCQNp/4HeU/P5gAYW2UkHaT3kh+jDwwoTFTlZULmz4/IqDqZdiKuwO05K8Cu+h7wDl3DFp1JmltGmSH1XcaH4AmWTOT+rDqswr3AlwZVftC4Co/RJ1p0MDKng3saDbpsxRLjuYk+/0vqkOupA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SoIPPANPyVYB4HgkrX63ee0NQJAbBQRv1e9oVPq2nDRncZaDVSDaz5iaoLMJ?=
 =?us-ascii?Q?DG40OefsbonW1cShemRGgWbnduW0optqXpD/JJEpNS7+mdYhyi1SeyBrN6Pk?=
 =?us-ascii?Q?4UY/zitbm8zQqAxAHpSYCVnMxPyZl+pH2p1xC/IJsO2Gn8gLhvadY1ZxMfTa?=
 =?us-ascii?Q?GBeA6rdIQI1DZeABEHyXUNdWiWOqkwy/SngIrzlL8MsEKpgQ4QUAw2jlAnDL?=
 =?us-ascii?Q?gLjkc073M6EeZnQ2is9ZMv2dykFV9NZo2d57xDOWy7eDfIYRfjODRGtzyfvr?=
 =?us-ascii?Q?i5Snz/yZPON3AnQFuMTihHk+fH+rtACpdvUXw9jIGaX/RheRjEV0vNboLaOU?=
 =?us-ascii?Q?WRclu9I+xbVexZNRu0jLIO2J6c3ELchmCWKAOoc3dM/qN7OLRWqp5hX0qeEP?=
 =?us-ascii?Q?6ITkK2CuKkK3tKSKqiQwG+y7cIVqwol8YLUg3XP6f9o0qP8xqmH3O6uAKzZI?=
 =?us-ascii?Q?Xc72rs7ylmTnWoWV+//Mpr8MjbaNsl/WLTApGsrNlTgr38unzuDi45ZVNbm6?=
 =?us-ascii?Q?PLr27UAxw8pT2oizY9goQzgy3gfB4bNOX8AANjnpmLJ12pJjNYWcF0Wba2/E?=
 =?us-ascii?Q?Bf4FD8O7f7pHJUNbwoJuQvRSR3gnsR+ZPHCX59rwcsxJ/FslqE15HfAuqWF7?=
 =?us-ascii?Q?HfuTSwskHIQq78kjWFjheGncnBtZtidwl8yS7YADwr8UOEzLVx23WGtM13Ro?=
 =?us-ascii?Q?ZeDNkfGQ2ySDgXhhSdu0UBSSrN9F2xXHSIyagMwcxqplakIsT38Q+3l0rtJP?=
 =?us-ascii?Q?3OCZwEJLYMFGf0Ejz8PEUi0sWzCnbtJYng6i8D2W7ZVRJeDlYNmfARI2O9dr?=
 =?us-ascii?Q?oljzuQ6Cc+ufDYDpGWLtZ0758D77LT4u0y0Tu3dzIeDvxRBl9M9MbpgXPqLo?=
 =?us-ascii?Q?WA9th2QR8qIkoAkUSA5d3ACQe+aF0yIO/yyj36jss0HGBHHu5TrrIbomyWjR?=
 =?us-ascii?Q?dxffPsGDW18EytJqVoQzCIe9FhIPpFAQ1I+6lMDaFGo38teEjzLaipj/F55/?=
 =?us-ascii?Q?nWhnXLQ1icphOq1BcpNF97sQcwytEmiRX2TIOPaM+PXjrlH3Pf3y8uqv0F/6?=
 =?us-ascii?Q?tCU6IA4oNakDJ7IcTbueqQupJy98HH233wD3LbBOMxlCZJ6PoWyzwaHqld5E?=
 =?us-ascii?Q?j26Ov/hxob6+B0NOPy+jHwRclkEFB8Y/mBE4AzkM8J+6f8RQz5WSCMt362zR?=
 =?us-ascii?Q?Ay+GHzkv1YWztef+NmnVoOLpQSV4SV59fs4o1nVrtPJrjGriUGG5W1H1qnlG?=
 =?us-ascii?Q?WZ/oRRZHYJXMA9KJ0hitZ06XyS0M+rV3JxTiVCPyDOUi/fhsIVu7UM91DDOg?=
 =?us-ascii?Q?C3/CCiPzN+ltg5fcejKbTtZc5b0NEAvHBjlJudPBdvLvxabkfIa75IVYWpd5?=
 =?us-ascii?Q?+TNlJLRE3dypiII1GXndPK81RwdRK6x9tJP1lYv/UuPnDtabcw51iDp87HXE?=
 =?us-ascii?Q?XS5H0xKoYQbtnovsvLCXfdCtg9lB8fCtS+xVIXzn0JCo614XGyH9CjOj4997?=
 =?us-ascii?Q?1GPbwZVla54Iq6cNop1ck23IwuRt8pLJvQ6in2Q7zQXqmRbmhJHgJL4NCWJx?=
 =?us-ascii?Q?zJJqOstF5SucZDu4OnWBrdcttjg5++Ui9oyOkE2c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af79acd-b958-4ad9-a0ed-08dc385ce89b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:07.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Buv+32eCTWfKM1RMjlDrlzIbNiabnRS3ygkFwunPB5EVRqNwTTvhW0TIc0qBZXoduckZ4kcXFNx50N9ZHKWLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

From: Ben Ben-Ishay <benishay@nvidia.com>

When using direct data placement (DDP) the NIC could write the payload
directly into the destination buffer and constructs SKBs such that
they point to this data. To skip copies when SKB data already resides
in the destination buffer we check if (src == dst), and skip the copy
when it's true.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e0aa6b440ca5..feceffab1de5 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -62,7 +62,14 @@ static __always_inline
 size_t memcpy_to_iter(void *iter_to, size_t progress,
 		      size_t len, void *from, void *priv2)
 {
-	memcpy(iter_to, from + progress, len);
+	/*
+	 * When using direct data placement (DDP) the hardware writes
+	 * data directly to the destination buffer, and constructs
+	 * IOVs such that they point to this data.
+	 * Thus, when the src == dst we skip the memcpy.
+	 */
+	if (iter_to != from + progress)
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


