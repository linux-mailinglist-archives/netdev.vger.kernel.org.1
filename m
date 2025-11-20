Return-Path: <netdev+bounces-240289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3BC7225B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2AE34E3F4C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C48F1531E8;
	Thu, 20 Nov 2025 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fMYF57WZ"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BBC133;
	Thu, 20 Nov 2025 04:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612151; cv=fail; b=cSIgU9yIUKCxs8Ox9AJoR8I3HMxtHdwIkvf5wEsR+kblVzbYMKfaDfwaVygoV/l6FqbHlBDbArJmorl0Q7sENtORrit7vdXUTYr1gvC8SpwOVK9bo8SlckKfJQia6bEoXukjpjUckU/PjG6xZIpR77NpmkwjXPFm24V8tojXJH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612151; c=relaxed/simple;
	bh=fppYExql0eyvCR1XofohhICscqMZ7Zl/xIBjSVbKIRY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ikYQeI8jlP3sBJvjBKl0cnFjp4H9nUF9Ghu6k/b7yS0UUPw054ot0mKzNsIywFbuMC4cWmIHmTT89izUTIlbKdQGbCn1XibIlNQ0o/d/BxeCztTX8OiFFZOVNlFgepVfvH7H0GxEVMEVvh0auehKzpFlKvYhomGu/lsR5lZl6qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fMYF57WZ; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDAmZXS8Y7YU+vg+3uwRrRktCyyr7KbvhgFJNAEQ1w9AEKV0lOS2yZ2BDVji/rmfy5l3SXQaLQk4WwQbLFvk/Dt3IZYbfq8bovTFICIHI6zwKjxZ22wYECqMDG5Acy7v1Le4WmI4Iocy77hpreaXHjRmgs/44KnbwBUqzdZYtx0PQLS7QeFfecME+O09YUhXX6UPPaeZG/6hnP4/bJBlzIBSFjKseMAoeF96UTjx42LY7P2badwRlVz3b71RKSH8quBWWa/HLZlBl8hotfQZlcgiZ5/o94Qc6nql4Ahi7oOi5zAtFJzmoBOUokGrw3Km5gFW9bDk2IB95dBQenyYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghiulmgwBEVEcV6m/5UjDsO/kO5PfEbxZvktr40RFS8=;
 b=sNNz0qeIo6pHq4cQYK3CKDM8MUIBmx3MkbuT+vVggzW9MHwbujhXburRRBKDJsHw/3efzFna9GstnC2udmNNbB32qCrj06lddwxaUZFq447+MO18Tv2rTFLpZ0W6s/Tm+58lGoYG+/mJdmExvS8ZsQFNJuX09hTNaPSJmnFIZVWIcDMANDVLAjhB/qe9RLqG6klp4vkOTsNnRS/Y0EwF7X/QJwTUXSdeXicYqtXop/RqsJn7WYWbyA9cs5b3Nk8z+hyWIwPScrPPaRBl94MW+S1Er0OfTm1+yvhYV+WaNi2/FZBYFf+in78CrUm1yyGEbeJXXvis/7hElY2Zx/xIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghiulmgwBEVEcV6m/5UjDsO/kO5PfEbxZvktr40RFS8=;
 b=fMYF57WZ+g4utfS04PK0Q+CVDPmrBmEBkzOWlF3URgiAcDLjmqvtm+wkcRi9xy4IHV6MnLb/nOQqgIfy4jgZlainC+Vzh4BwKfoarGdXsYIbCDuKmRO0sj+FNvF4eCE64/MFeU7yEOTM5KF0qfv4acAep3W08wUD5eJsvfF44j+g/cwyEdkR7nU5LiHMrvey+14jGq3jXjCrrR6xPjMc3qi4O7Fw2uZ2S/COwTVkbWFHeFbe34sfkJnfQCBP7DVVkkE7cKpAHvoQ2pSLFZoltaBd5RWUa/g9Li0ZbFTo0KGOM871iJ+6nWXkqGsTJgQ2MHfe4MofV24rumGCT3x9VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:15:45 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 04:15:45 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Carol Soto <csoto@nvidia.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Dmitry Bogdanov <dbogdanov@marvell.com>,
	Mark Starovoytov <mstarovo@pm.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: aquantia: Add missing descriptor cache invalidation on ATL2
Date: Thu, 20 Nov 2025 12:15:33 +0800
Message-ID: <20251120041537.62184-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: c59c3d60-5fc4-437f-3264-08de27eb799b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NB0nYOERmz3CNsF2FPJqLpo0U6WITE6UU9KJ9ycEE9508d2r5TuAbjLcgSM?=
 =?us-ascii?Q?6XTcTU1euIcw4rxNSZHOwaK8z1sLhfkMCjzY9eQ7nPGEuXozqbNcRpJTal5W?=
 =?us-ascii?Q?leMfmYdi6oKof9Zk1CURG4wRflySfmeQ1dEjjLozNR12q/LLRhQ+m9VFDUZo?=
 =?us-ascii?Q?x9Thm0ALTqvPr7O3M2dWERSgQ1s1peDM5UJHVgXqsGKrIC6QnXE4IxzDqvcl?=
 =?us-ascii?Q?Fx/wUHRfd0x7NUfUVO7EFEUtDyNezdzYr0d+p+PxRxakc9uEYXtg0y4EZ+AW?=
 =?us-ascii?Q?4nDNtYLBtyDJpZRTjHi4CwkcxHw4XSyP1/WTdvn74cJF3qaww7vnCjSPv57F?=
 =?us-ascii?Q?00KtKJPmyFesGTRQC3FxkR+SeDFWPm+Ceut6xom1/SR9umlDCh/5l/yhyaTW?=
 =?us-ascii?Q?2oTjsQLk7B8h6cveZBMH0COXarc94TeZwyimVcgBQoL9TYD5tBDJmmqSUBwf?=
 =?us-ascii?Q?zwsPTvyDDnsKvx0DGzL+uOptcjll40D8CTxOeGuGRkFfkjCQ2W4XPMJ7F3Yb?=
 =?us-ascii?Q?tsD6Emdd6imSf6QTxbzIr2ZlPCX0NEVpLuBQ6wWVPjw4bPs3mrH3fAbCzspY?=
 =?us-ascii?Q?XTRSxzjnswsQQ8ok1aWvLbCGC08IIltebYBS6iotmlDc7oNG91gQTzgcLnNZ?=
 =?us-ascii?Q?1Vj3SdFKGC/VkUKs8EZitsCxfJZGmJ0gbSiCkk07NTNeVKU96oSpfAFTELe0?=
 =?us-ascii?Q?/IDt9W8YMDIDmVI81l+/AzVweP8BLNuBlatOtfk3O6fU5pmIyjVkdEp6bWMg?=
 =?us-ascii?Q?K8PiJrW3OIrLgSEUE614B0XntuBZNuR9UnYxgVzuyW6QB6P914nyfMmlxPd/?=
 =?us-ascii?Q?D06/4TCe17We4OFw+2q59RjeWnGtrFO98V/N39IqRIMej0jqKDE6OPxU889U?=
 =?us-ascii?Q?bsR0yvycuSznFbno+o/GurqL7eB49Nr350dd2uJ3eH+20ALWSTI5RNclLm+X?=
 =?us-ascii?Q?O7OBTzVF7JkljCCGwsp9mJie9EBj7e00F/XspUiEdAMYjhU3MaegDrJnKHD4?=
 =?us-ascii?Q?ryW7ysv+3mE3ZNNjNPyiLrsLR29gAuKErF1YeZCthpCXVVF7UirUJIKq38CC?=
 =?us-ascii?Q?NmG8icy37SMPxts08byrugT8F3/w/JNKCJ66zlwUIZWwbjWr1wqitVY7Ueqr?=
 =?us-ascii?Q?rhCWjDt2/3xhFVNJNudm8bM8OIT2lJAdUpd48kGtBGm+XaSgfmaROyZ+Hz5a?=
 =?us-ascii?Q?ivb6nGBfXL1ev9PdPlz7bxVBU6QV7aTKmTiOb+NNQvUrN88jdO0MbXDMXaXE?=
 =?us-ascii?Q?IWBfiCqlWNPFCifJ2B7q1bRk/0sPXNvM1khXqpaPKGDP6JO8B5mOKvRRnCuk?=
 =?us-ascii?Q?gQdUuSKR+OZ5iF/DKMWOpLyzoxiXqqqKYQ3f+pjLmEu36NKt34dyb//Y4FSA?=
 =?us-ascii?Q?Lmic67PluHzIbc6eMmWoBWvpUErDkWpuhaVchjUd39tMaMqu14nvvZu+5lev?=
 =?us-ascii?Q?nbCcexyXJVbCXciPggm45LhRqf7/nLZz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eeXC7ULnaReSzBI0CxWLDwzn2TFLdHN1tLPQmTnArEvL4TtzdUsYOeZZhmKZ?=
 =?us-ascii?Q?bhpLxyhSK/9YR6LhoX8EmVbJqRQU7ow8kwZjL54tism7taLASTcVERp1TfKs?=
 =?us-ascii?Q?9QXwzrEHB1wWQ5elCeZa0n1Qmew6lj+8E095W0VKyg8r2Av0ZNBXDLwdTzp9?=
 =?us-ascii?Q?qyKeEtYzWpswqCmWUv9QkgBj8xbUVVSXGWndt7zYVofpxLMvjy28RquyUol7?=
 =?us-ascii?Q?EvEyAmu/djpGSJ/8a3GsHt7sirlr3nDjqUb04M9tCpzLKqbf9e8hsLo++fjv?=
 =?us-ascii?Q?DNukcLxYvKiSl83rASKCPua4ov8dlTWxKdeP3bXIM/r8VQ72lcDf9jeqXylY?=
 =?us-ascii?Q?YMtSDxFoQSzhZHEmNcVCaACXYG/jSJ4VJwRnd7Dp+HbE+JwFEJUR5vc2IFkX?=
 =?us-ascii?Q?2cKe0mZchziP1uVZ4GQkG1yVRbHd9KzbIWVsnab+t0hv3WXzps04rmaDOvlv?=
 =?us-ascii?Q?IEQ78bOsxuhjPDgRvNQy0qs67btwk4ZQKFMInX0wrN5I5d8qJ3I7BX79ULFS?=
 =?us-ascii?Q?eCff4ZkSNUrRIntgE0xtWB3kQ26ebJ/kDOlUJ8Z+aIKFVHh0kK4v2IhkrqZI?=
 =?us-ascii?Q?9wnAwUSmEh8e7FM6Kov8FTuW0OGoqbqcOhTEcbZM2VwL4U1mGURfu571Exm3?=
 =?us-ascii?Q?/ZtYjvNHPAjRd9s8veZK+61C+5Ni19P9yoHdrXinXNwDB/Q9YLp4WRQmFhMS?=
 =?us-ascii?Q?BQT9uYs0ZR/Rs/MQFq/BLkogj9QL+i6CsHrfbL/Fip8UJEoPdUotQluVGOQV?=
 =?us-ascii?Q?tkb1xG+vG2GCRXqQEvlN4529PI2P2nW5Mkl148uO7jZbnvziwmuOZ3dOFcS8?=
 =?us-ascii?Q?IKAs8YWyExAnvYa1A9A+br6zgLOcgy/cgr+DQERcg4o3zFc3VQfYdL/4Re+c?=
 =?us-ascii?Q?KlnKasRhawkVJklTIbjNVJFqRCFEBeDNo7nwZXEE/IA8LAPFXoAh/bXszWsm?=
 =?us-ascii?Q?zqI8A4hd8CR+iHRLtZaMbiFdfDz5EvJjDkS5on9EVxDVGx/h7Zih54tbrTYM?=
 =?us-ascii?Q?bqZqvjkJLvgnnpjoyX4PNGsf6GQThC+JNLmJqKA6dGs4Z2hYNGbvR0ks/xY4?=
 =?us-ascii?Q?1sfH6bcUlLg8DS0Qra+bFYny7cZ85LTp4zdUwLMRSs3woOIYa0A/88CaBsiy?=
 =?us-ascii?Q?y8RBK8++yPIgVL4VXH8yJw1g5SCniCGz7u8lLbWRPHq5F/UzTO3UNuVLKLGt?=
 =?us-ascii?Q?j8MuNFKMRsP6Oc45KeP1MEeCiRRoaUVEboFqRi7Dfah2ZDnsXw37n3VZ1dEq?=
 =?us-ascii?Q?EdMIg8UcLCF4dfoyq2FkVtSgtyz+eYn2ntOqhuxUrdOD8tRP1TFrjNCb33Ay?=
 =?us-ascii?Q?pp7t3SNo2FMK8Fqc0S3F/USsQhR4zHpzQwMUaWscgM2lQDVpHefr1JbEEt3V?=
 =?us-ascii?Q?2Z/6oRndMoTun0hw1WMD06NXsRjN9tlkJq/PLvvIOga14W5XTC4f7nT4UMxm?=
 =?us-ascii?Q?dfLx6xvfGGwO3M4zqMuhdJ9y62kn6vdYpqDkArcqvmGtUUA1S8ISdvqsWPML?=
 =?us-ascii?Q?zsHOBGnrANmm6nAVUdso9eg837zUHC0qs0uSpKt2ogxV5vgJ6XLjdr+rcNZ0?=
 =?us-ascii?Q?MHt9C0t8gdILy75mg6zNj/AGyajjIdbmWeHzRweX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59c3d60-5fc4-437f-3264-08de27eb799b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:15:44.9918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIe03TBhO6bjl3qHiCG7DBgKXdyScyAgANgTNc7+lD036qHkYkRpv+pZvPwWlEIFMt0Wn/+3U8Jj+wIXsHI2UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

ATL2 hardware was missing descriptor cache invalidation in hw_stop(),
causing SMMU translation faults during device shutdown and module removal:
[   70.355743] arm-smmu-v3 arm-smmu-v3.5.auto: event 0x10 received:
[   70.361893] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0002060000000010
[   70.367948] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000020000000000
[   70.374002] arm-smmu-v3 arm-smmu-v3.5.auto:  0x00000000ff9bc000
[   70.380055] arm-smmu-v3 arm-smmu-v3.5.auto:  0x0000000000000000
[   70.386109] arm-smmu-v3 arm-smmu-v3.5.auto: event: F_TRANSLATION client: 0001:06:00.0 sid: 0x20600 ssid: 0x0 iova: 0xff9bc000 ipa: 0x0
[   70.398531] arm-smmu-v3 arm-smmu-v3.5.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

Commit 7a1bb49461b1 ("net: aquantia: fix potential IOMMU fault after
driver unbind") and commit ed4d81c4b3f2 ("net: aquantia: when cleaning
hw cache it should be toggled") fixed cache invalidation for ATL B0, but
ATL2 was left with only interrupt disabling. This allowed hardware to
write to cached descriptors after DMA memory was unmapped, triggering
SMMU faults. Once cache invalidation is applied to ATL2, the translation
fault can't be observed anymore.

Add shared aq_hw_invalidate_descriptor_cache() helper and use it in both
ATL B0 and ATL2 hw_stop() implementations for consistent behavior.

Fixes: e54dcf4bba3e ("net: atlantic: basic A2 init/deinit hw_ops")
Tested-by: Carol Soto <csoto@nvidia.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 .../ethernet/aquantia/atlantic/aq_hw_utils.c  | 22 +++++++++++++++++++
 .../ethernet/aquantia/atlantic/aq_hw_utils.h  |  1 +
 .../aquantia/atlantic/hw_atl/hw_atl_b0.c      | 19 +---------------
 .../aquantia/atlantic/hw_atl2/hw_atl2.c       |  2 +-
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
index 1921741f7311..18b08277d2e1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.c
@@ -15,6 +15,7 @@
 
 #include "aq_hw.h"
 #include "aq_nic.h"
+#include "hw_atl/hw_atl_llh.h"
 
 void aq_hw_write_reg_bit(struct aq_hw_s *aq_hw, u32 addr, u32 msk,
 			 u32 shift, u32 val)
@@ -81,6 +82,27 @@ void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value)
 		lo_hi_writeq(value, hw->mmio + reg);
 }
 
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw)
+{
+	int err;
+	u32 val;
+
+	/* Invalidate Descriptor Cache to prevent writing to the cached
+	 * descriptors and to the data pointer of those descriptors
+	 */
+	hw_atl_rdm_rx_dma_desc_cache_init_tgl(hw);
+
+	err = aq_hw_err_from_flags(hw);
+	if (err)
+		goto err_exit;
+
+	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
+				  hw, val, val == 1, 1000U, 10000U);
+
+err_exit:
+	return err;
+}
+
 int aq_hw_err_from_flags(struct aq_hw_s *hw)
 {
 	int err = 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
index ffa6e4067c21..d89c63d88e4a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw_utils.h
@@ -35,6 +35,7 @@ u32 aq_hw_read_reg(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg(struct aq_hw_s *hw, u32 reg, u32 value);
 u64 aq_hw_read_reg64(struct aq_hw_s *hw, u32 reg);
 void aq_hw_write_reg64(struct aq_hw_s *hw, u32 reg, u64 value);
+int aq_hw_invalidate_descriptor_cache(struct aq_hw_s *hw);
 int aq_hw_err_from_flags(struct aq_hw_s *hw);
 int aq_hw_num_tcs(struct aq_hw_s *hw);
 int aq_hw_q_per_tc(struct aq_hw_s *hw);
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
index 493432d036b9..c7895bfb2ecf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -1198,26 +1198,9 @@ static int hw_atl_b0_hw_interrupt_moderation_set(struct aq_hw_s *self)
 
 static int hw_atl_b0_hw_stop(struct aq_hw_s *self)
 {
-	int err;
-	u32 val;
-
 	hw_atl_b0_hw_irq_disable(self, HW_ATL_B0_INT_MASK);
 
-	/* Invalidate Descriptor Cache to prevent writing to the cached
-	 * descriptors and to the data pointer of those descriptors
-	 */
-	hw_atl_rdm_rx_dma_desc_cache_init_tgl(self);
-
-	err = aq_hw_err_from_flags(self);
-
-	if (err)
-		goto err_exit;
-
-	readx_poll_timeout_atomic(hw_atl_rdm_rx_dma_desc_cache_init_done_get,
-				  self, val, val == 1, 1000U, 10000U);
-
-err_exit:
-	return err;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 int hw_atl_b0_hw_ring_tx_stop(struct aq_hw_s *self, struct aq_ring_s *ring)
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
index b0ed572e88c6..0ce9caae8799 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
@@ -759,7 +759,7 @@ static int hw_atl2_hw_stop(struct aq_hw_s *self)
 {
 	hw_atl_b0_hw_irq_disable(self, HW_ATL2_INT_MASK);
 
-	return 0;
+	return aq_hw_invalidate_descriptor_cache(self);
 }
 
 static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
-- 
2.43.0


