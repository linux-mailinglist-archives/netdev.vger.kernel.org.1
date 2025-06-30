Return-Path: <netdev+bounces-202453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163C1AEE027
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7AF3A9BE6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA8628C006;
	Mon, 30 Jun 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEykpmUG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4E24466A
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292486; cv=fail; b=abwm/CW6ggdYyc4nlOjUBzaxGZW5wAqv6kwpgI3M+CDV5DmLAgIZiq5QlMl7cgABSgYbl/UMigPVPUtiUBV9jeWn/WsX34MlOqAPBzDQ+ARy1B/qbakGFHWH3qO9sXfiy1LafFapoLlGsDqD2F0+vh+66rl7nshK6wc6vOlQBK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292486; c=relaxed/simple;
	bh=Ao2g3bUiMDQmmjSkvAYw/7PPDE1B2l/HT+FRA2XIpdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=if8iJMN0eFwm2o45wihOtLabMwBG2+K0MdNEc/EsvjM4KtwvXAqvXnmmM2RFsW6ezAGLAEplkstDcjYRiKrSeE68ItcCqMW8NXqQJKyoZNmoX165mNEccG7+j8/Xhv0vK1Th4U5ZTEdj9mp1/BEC8zVlw2+fl+rZfVF6h6hjehI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEykpmUG; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzpCpCikUQXSghAgXRtS8mV2izIDMoHRxRMlQA0EzDs8XPMPOfVvf1dXxXdJhlqnbV6dM3kv03jazpOIwhSnsd9aZAPZt8ANwmb8Apq6Xm8m5m7M69uES43+jb7wCD/A3d0eXTdHKfcCPnhuie4lw0DmaEnTeviZf7/JXdMosCprnXZ+hi7SM7Hj/sGtih7H4IMpJtAUOZOU4na+CvqVg+eXorFs9A798oNv07ku6wi+zCiMCaXVcLk2HA/3QJskWPK0sti/Qi+YTyG6QXCbMY2TctviMixXVzZeChAPJXvBatOTifc1+V2xacWdjA9VdQT6o5ixQ82O7hyfi7Yxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awFhljjfzJEjzSw1SKbrGkrheVkDe6NRH0EOTO4SjY0=;
 b=O3R0dLd2pvU5udzMJDMndhWQ/JSZHI86JJyjyfaMjYKt8Vaf6lmjP2T0zdZXqcYpKQ1fCPBCWVzkacVclcCG43LCUJcU7apUMcDBpg40AYOT5Z4ctJpGG3687vBvgQcisjsoOFAPpA9ikNusky0feEJ7/5WbwmYuvVPNMYmt833YSZy1r0UPObf6BcwpovM3Y34WzUTJl42pWULNbtKPiEAJhsPMa750PYwXT59txMo2Qy/+pp98Kwbd8puQ65OP7Eih3x2mng2XtLXAQSjyCh2sxOgO8jo65PfWTUPhGwoPN7fCYbs0pYp6ufIf9R02Y9JKFnwxM/rBGfLWWAgKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awFhljjfzJEjzSw1SKbrGkrheVkDe6NRH0EOTO4SjY0=;
 b=oEykpmUGigzcCvvblR/z+FK7YYY/yrQ9fqSNiQDrQt2CEIf5bva+YYLUHRUuzNAlj6STpPhgXSOzEsiAkin8zkQnp/akzvbNDMgXxNDSmjD5LmGmscRxi7r0PslhucrP83OEWFmkadf/6tZC2I8sssGURGYVyzPLSbd4N60siFxeDGQn2yThXrhbnl62QbywiVIBO7iYZp/j1yEX4Jbp+zIiBfJe+sdCTOSlmJhploZSEpZINdOK9Urix7uTgff9zy6Ul+1UtE6MoNGMXHRiXXrYBQ3RK7H4LbNZ4T5w36hVg61Vc3OtcQMcY3GMWSQ3oH3c641FqgsQ0fo+39k1jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:00 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:00 +0000
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
	tariqt@nvidia.com,
	gus@collabora.com,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Subject: [PATCH v29 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Mon, 30 Jun 2025 14:07:20 +0000
Message-Id: <20250630140737.28662-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 439e7140-0722-4cc8-d4fd-08ddb7df85b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7PxfQ36Wy3cKT030wn2GwfxrLxEdMMV1//9w23IvCDAOAaFK7MJNwf60JVy?=
 =?us-ascii?Q?y2MzC16xZGDOTyYFJMUlPBpJnHm4TKaqrvRYi/ZPESuyiUr3WqUulNZ+R82H?=
 =?us-ascii?Q?3q6Y1Oz/FFvb8jKmi8bQdRKYFq+9tqbhAl2mUxOtfXInp05SzBPcE9euI6n9?=
 =?us-ascii?Q?0c081uTyvygL/TOVJ4yJIgOvn9NgTXN2Kz57jdmth6v1Kv0cQiYaC3FGMKqX?=
 =?us-ascii?Q?TfPYDCpnvtN7PjA30rxyw57iBTWB9x8zQpDfbB1aMh8kobzg1Cqvfy2QBPyy?=
 =?us-ascii?Q?BSnWAwYF72B+NE/IyLC6aJuMTUSivLPf51OhaGlsZfeR96HI1CLO8xQUYpah?=
 =?us-ascii?Q?akMX0EvTnqQjrHHm4ALz30dYIf5rQz8fHT1FepIZrXFKjc8hoX/SGfjGnzQh?=
 =?us-ascii?Q?PDmj/K0Ha5fBbQuHc4CGMmjExOenlbvZpYMp9h4yCwqjXhYhVmS0s97KW8WE?=
 =?us-ascii?Q?DhLGyhL/tokhxS6c7k1SclNk1LxMz+LXra53AkoxcCDNar+nZZbMbnDfF7XG?=
 =?us-ascii?Q?YeY5GWrOcTuu+gwKwqQV0RWgkF6Xt+noerKpPRFXlxXEbJCUsjPkOSiXkEq8?=
 =?us-ascii?Q?HzGZBF/x5RIP6eab6tNK4DLMkAwQ1vNDYLzJEALJTuwGd1ExN3xpLBTvlM3p?=
 =?us-ascii?Q?8j2v976c1HVAGlKSZCjM2/lLpXl0bYuQ80C0KmlDghv3AbaJj0o+tNMhOzPm?=
 =?us-ascii?Q?8cNIPc0BYNnWKmmZkvBOJ8euVp2EEJDCW8rCDaVEtqptg5m1VIp684kXADoj?=
 =?us-ascii?Q?HC7D+h5+ZAq08SplZPPWTvmkiwJkiZo1rs99iLc/EwzxXYY3ma1gk97mxkNa?=
 =?us-ascii?Q?g8hLTgNcNTafYnqpUPv6ptJEQb5Q1LyUDnCQLHwT1h+SuGRDDYLBs7gotYfJ?=
 =?us-ascii?Q?kbXXHUMA5tc5eiAVNn1900kdnYTC4yLp6qe+ALR3YccDieNYBb4XFK9YUhTz?=
 =?us-ascii?Q?SgT7RpAWWtJE4ZaJ9bIEW2oV6HyZwqgsRCMIodmcr9YPVccGc2uANVoQZSDm?=
 =?us-ascii?Q?UkIDJ8vHfbvCPlXpfStLKnj1NLHoVlfB0U1mqaARBxvMaExoW9vT+5ThgO/A?=
 =?us-ascii?Q?lckChVVaTzNSAt+zQX97pJm3gnW5njbMo8GJyp1QoRyVEyvHiHA/21NHZlX8?=
 =?us-ascii?Q?1AUauATB+YUIONhAPeu1BG4sWbzwNlOu/2rocp+XhKXJVoIa810p7pXk3e2b?=
 =?us-ascii?Q?+USBLx9oJ3Z8n6CaWntSqgKuvsEdLaIBh22V06MSYnK0hzvMlD9xH8XGVjDS?=
 =?us-ascii?Q?pfQbREOCd23/wYhbtl4/trJWzSzIXre+2Ry76eO4e5zSZT9YQqBDormGQZcd?=
 =?us-ascii?Q?ETZAG6z0OOE3Ipw6QRV59eA0IoqHtISKOOh0DdOd6I5C2JRksDxyAUkegjUl?=
 =?us-ascii?Q?VwF/yZ1VeMPV4Guwi1Nub19+3FAgqdemK0eX7tvP9YHtX3SvOi0plcesEGZt?=
 =?us-ascii?Q?ne6tvRp+O8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYK0TukqDHvUCZuwyv9k09Hw3C5PTOqSsopP+/1DUyp71L1gsk2TteWm8x5i?=
 =?us-ascii?Q?Ktuk+dZKlMg2gSOqmB+Aq4D8LCeuwWVjH2pW3DmzDxjVMuh0pLA8LOkNcUgF?=
 =?us-ascii?Q?YV5VTKdUXkHJ6bdzns1xlLgQU+5UTCpyWhiwt4kVM92LYxbcR8HsLNSruO/y?=
 =?us-ascii?Q?aBkanGV5ZXvoUP98cZGsj4Vs4Z8zHDS7TFgbyEiy+W2MkQSzn1aLKMtTUB2u?=
 =?us-ascii?Q?cwc82j36EUn0LtC7eHDYUF/PLlFkljBmNW28h51jRyRbzKHCy6by3ktfTEEA?=
 =?us-ascii?Q?w4+Y/AQZQgwse2hdnvgML54FgD4mRqveeJs1OFFf5FYMb6NvzKX/sr6h8khJ?=
 =?us-ascii?Q?nplP+yGVAWkkSrKJmtmSInW4XxVHqzjDMF0OPt1REzmAndBDDqeaoiUoRLcK?=
 =?us-ascii?Q?lIhXSaGNd3GvyxGF3tLRdYH5UgMFNdmujyfzeS/0z3xnnDV6VlYy7ZCC9+OI?=
 =?us-ascii?Q?vw2+hY/nRlXwu9dES/Qrtz1tqJe9Jz35NxVGI+mZDubKaxLG/0RYzoiiowam?=
 =?us-ascii?Q?AYBLUDeZtugu52PeUc2fYVF0jIBIdU6eDeZIxU6zAI9GA68pMcjAjOzLk6zp?=
 =?us-ascii?Q?br2JH35e6VvF4OpFN8CbaXfZRApbJJw7xNWE2CQoB26UyMN62VXgXGCSqv+l?=
 =?us-ascii?Q?SWf2Uv/+kc37gA9GJVNz0wrTS/3+XsqtHqmTcd+n0OxGbDuXLT1uBcRTHjKD?=
 =?us-ascii?Q?EBYzYe5EcSs5YzW+qiWvXWUQDk29Y5zvcH1hgRBFhoWO74F3L/+hUpWD2pO8?=
 =?us-ascii?Q?MmYIwBNWtWnDQVbYeJoI7ltKnyt8sOx1T+hEcrZ04I5oAZMlY6dQ6lM2WvEj?=
 =?us-ascii?Q?BtYMeRJv7KTsbsfTCVFptBOqlYlLlYaiCuIPNAz1VP2ml/ejpJ6fPjo/HMh5?=
 =?us-ascii?Q?ppejfE0ahj8MHd2IFfKeROJtiPGeYpKqliLuLcsmOuTlngtrsoFXUL9ciiYZ?=
 =?us-ascii?Q?qw3jWt9bJI4eQfdwbcItox9+xRG5ejoypp3/Y4drRB8zh/GdspylzA8DeFK5?=
 =?us-ascii?Q?PhI9Y5zADTrfz3dQvcmRv2vG7dYa5muQQ+JY1UMEWsc9MOkNL35bvb3WuP1S?=
 =?us-ascii?Q?8PTWTcdAMC4bI8j5gduRww5e4elx6202+FHSRgEYi4qwEsjLp7ui244RE1Yc?=
 =?us-ascii?Q?m1fCt2CrcLfrFFjUQzZ5wSeiJTQOesciCbacxKJmRIAAQsmkh7B3AqP/vOHi?=
 =?us-ascii?Q?1TuwLiDD9xoaR9fqgqPU4/iZX/0cmVs3sKWiFmUHXL0SuTMf+Qno7l4i3erm?=
 =?us-ascii?Q?wcjTz3s+ktcVhYid46fzHrpW5SDhToaLdRBZREj3W2CmQoFmnYqlGql+7lX+?=
 =?us-ascii?Q?ogZzrlcNI1l88EdRlTdCNfZOuIpeDB+5TvCWpCZbSu8WuCXGVJHECiXZSjw0?=
 =?us-ascii?Q?AE08httGbhwoR9rvqycnsaguMl07YtrYdlIKEJOiS0HXQTo6yzqOEyd+G93T?=
 =?us-ascii?Q?dpyrW82Pr/vAdRKBNF8iQsue3sOJdQOoo4wbDJfDl5i+iIoUUvao//ZOxzcJ?=
 =?us-ascii?Q?TUibPa6hAOy8opEWu73cvm9oXK//9fV1q+ZKnieNk38jXqvFdvFjhVJfWFja?=
 =?us-ascii?Q?TZ7uK+YPUeBFXmHwNw3xRcRCuKUypoqjzGCAilaq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e7140-0722-4cc8-d4fd-08ddb7df85b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:00.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvAcTs4QLkL5qEkBzGKANSsKlglKe3nODKD4ybHyqqJ5SoYZw7nW1M3fEQ3ySgJnwNMmd0q9FVzgwxNOWR5lag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

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
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 lib/iov_iter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..47fdb32653a2 100644
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
+	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
+		memcpy(iter_to, from + progress, len);
 	return 0;
 }
 
-- 
2.34.1


