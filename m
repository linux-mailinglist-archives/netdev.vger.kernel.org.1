Return-Path: <netdev+bounces-86502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6889F0CC
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52481F22BE3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDFA15A48C;
	Wed, 10 Apr 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="r/BvLiIr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2B15A48E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748479; cv=fail; b=WJgUAmaJ1361NW9n0QLQ1ui/e8pmV4HQo80/kNm00Z3j6ni9H0spLPQGSuW143eua7d9ToVLchxE67e1dAlBZtE6zgdLZW2vruJ+NDy9+RZRjMjxhBYLiIL5Q/OCUojXg+MHwMJNpqC/yM7aV+oJMYxat0ckv49w/bziCzioMpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748479; c=relaxed/simple;
	bh=0wAm+fV5r1fyt+9n7vjdEYTnpEo7z/j9RfeoDI/l9Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n3uNz3mlRh1pdCYXsZoWH/u1AXn8CanR1va4gCKsxiNtOG8BrnoL1zZJo7853t5Beuyqr1kUXURXHPAPqT7KaQJVn6L/Eockq+mjLLwDiYGKU/QOpn3DxBg6UwxouQAht0N/kSv1hKKQ8Ucu4spehtuy1iFH/eK8nOgRv5QvrpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=r/BvLiIr; arc=fail smtp.client-ip=40.107.237.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDTFM88eq2vtqDVrj5nuetM9vbg+lZA3l+jPntXVWA3ClsfuuWIXkYdcH6Fc6w/BI7KqbGWXNr9Sp4n0G8bdvgGHg9SOJhk/glwYXU1HaTbsnZ3mLoK3mPrtzFlBs3IbFfSycBU43WYBtS2Zq/X9BxThK+h8m7wS1WJNk6UVTbCToSFdaC372xhCs0MCyt9I1L0aAbRClE30lEgNcaGleUHzuOz0vBS97hb6mJrx16rU6IOr3CaUVh+v1mPR5nJRY3iCMFbse+lQcw+ochNgzLcROni/uiXTnV2v1Agp+a1/an6IlnUS2qUNJUVDkycJZcS/t8ImnqvzvHjXUmbcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EugGRKHxuaJL+g5+nWPqO7caMH/chJB/w4m8dy8JstM=;
 b=aYUt1Qm/uPnU1uPjlMappJFxr/2MTx4HtOsU+x8SBhiAOQuHIAQ8JCVhXq8gdK1YZ83OdN4i4YOE3c5/4hkEZI6V4KNGtGUftY9HY0D0PsBEIIs6zKH6VPuSQfvjbIdnNSOShXP1Jr5I6BAu6rq0UEWTYTVoHio0Ual3IW5QpMVh/DzNkKPNkeCFkkiBpp0o3xKiw9fRluvXvMDRY377nIzHlaxS7cv2j4cdZEiFt8AtIcdo1rBfv5uBsJP/a4ue7ILocRkl+Q+trLDRMWWzW+w8ZO/vfAlPBzLeEMW3QU/ZNFGjhqeeWNxNLpFMgThti9zsZeo/AlVED3om8jF6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EugGRKHxuaJL+g5+nWPqO7caMH/chJB/w4m8dy8JstM=;
 b=r/BvLiIrsTcfot0iIW3LeeU0qBCqcbd4oC0XEByrvatfOsb1HKA27QYSitCTpJTGKsmnLKf7n5lzF59QeME8WHEryUoKgmV2XyekZPM6/VLBA2WCp21eYoGqN84NmC61cjcYQ3x+QsNHHopTIY17tEPgmbGkwwLAFHKBrfwtdi4=
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by MN0PR13MB6665.namprd13.prod.outlook.com (2603:10b6:208:4bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 11:27:55 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:27:55 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next v5 1/2] devlink: add a new info version tag
Date: Wed, 10 Apr 2024 13:26:35 +0200
Message-Id: <20240410112636.18905-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410112636.18905-1-louis.peens@corigine.com>
References: <20240410112636.18905-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|MN0PR13MB6665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKARExtzU4ANXuJWS/HssMjvdvf1ODqxjvV8v8njPk8YWVWYw90Lo6JJr90CTF1JWbFWdCBJNgLqa2uxtyw0yJdKBuKCmy98sfty7XG8v62QK5RiS/tNmng4lDrnshks/Mb1l/iOsFgH4J2Pnh/2GUt7SkssgkVzWLYrw8xxNofr9nHL5XlHsVI/zcnTd/Mkrf+ZxXaUgBlMiRQXPTE8sT0ieqMEEUykp943lDqmo8PKCu1GpdtvZwezn2Y/vgVuZLXq8SulOlSV3ER7He2HGwzOXLmMeS13ygteBUNgnnP+cM3euDTC8bFUJHoPagieqO15PIW8A3XsGoIR7fnvYr6Gz9QLl9EwaDmK7UoxoJW+pRhxYpnpG94d/rb5IosiCKVnq1P/46F4qtW3SzmJlRaZ1zxCT05ce9dFgLqAQllUXQyLpEkmG4f2JVyyy1WIwJONT/54q/sE/sz265yk5bUQCn+fqRMUICK5IigR0qtPuUfJVDvG0tK0Ht0JNs72MOVNXcOWvuRxAgUxLDZk/CvWOn0pVbdjlbqjyauzhkETeEiFF4Jc5Nw7MXXufnJZPASIwVcgPAn3y0+GcKJyA6X03o8/JbXVVMAe1ID/+OdTCH5BYUQ+hv52T95zGGx4L/Oc4wNiZSa9GEi9y27VF6ocJt4nXh2RyI0Ye0GRv9C6thUYpBtO39SsK4cKoBTFV1snDOJgxf14p+Ja8Si48wJdQPmevrumr/Z88W+pyvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptanPUfR+dhiFlyCge1V4HyLAYKkTwyaoL7o1gOZDuSgItwQNfGYHH2Iz95Q?=
 =?us-ascii?Q?FcVpH9OXe0+yGpL2an+mHn9ld/aAhiCD1lBVuxW3FJgayaptIT9lCRuZS3OJ?=
 =?us-ascii?Q?pLeagoyou8sDsZPfsrUr0uiA88qGiEcnTIhy+MZt6WGNKHvW6ccQYsgeUZtX?=
 =?us-ascii?Q?vKj8NQwbP8w2rz+mGigoy0LeVnekAwujnNHg1a2HUkugJOyIIQRVSxiKtph2?=
 =?us-ascii?Q?j5vodXtA0oj2JX/NW6Xjap6ZJKgcWELJAbymXbVX9mVNNxVXmMzsfA1vETGG?=
 =?us-ascii?Q?ncQx5Swfi2U6LZGRxdSlwnWg2xyBWFfEz+D6mFFO7802TcQ1Gx6R53bWg5zP?=
 =?us-ascii?Q?rvEZdlemkq+RqSo27uDWEfQ3mZaaLNZFvk+/e5e64eh8RhhRH8iJw2dqIkGy?=
 =?us-ascii?Q?ld0DlaB6q+Q1L9Z1QR2BHGkM1BrcCjbDFxTQ3ONKcCO70+dVN3/uEvU/R9ND?=
 =?us-ascii?Q?vaHlkURE7tS6s51UMNzIkgqiwyyVOucszk+cyxvLD/CuB0ZYwLTQZFpYfQ17?=
 =?us-ascii?Q?QGz96KjD5nlusys8laaHoXP+cWPDa3zBlp+/11ml4+OmaeLkzueozZ//SN4y?=
 =?us-ascii?Q?HDY1HvGhT1mjMJvMo8j532NxLn74MllENnNvDKYSzGXJpmg9fXUVH2BEikB6?=
 =?us-ascii?Q?q5QUiBuF7fFkjWyY+6zQ+xzyrv9HV3CR+JfO2SjyF5wlGdbw6powj1s2ualj?=
 =?us-ascii?Q?GXQvcrhavIQCZHn1XqDdDxvtuN0XEdhEQ0O6TH+/r4YyOvbnV1Ygil9V5tHB?=
 =?us-ascii?Q?dbERRpUonGH0GdhvDgR32/5N3f5xzjlpXfIvjKNhUKsJJYMREWlOwhAY1YfF?=
 =?us-ascii?Q?KYHkQLGDubu5A2rA6v/h8klvCn+Vb60GgXarzrEXEhJxPwmgIiALshtay/JD?=
 =?us-ascii?Q?UUH7UqxHas6d45C11BOXEtD2Fv3VRNGcI4gdHhrw6yaW9+XTfRH8GSMbG+a4?=
 =?us-ascii?Q?NxcqEGL8lDJNm+ZrjGvQyEpNU8k0Pg+KUF3DF++E1V+VIcviO2BV7IGFYKi/?=
 =?us-ascii?Q?GIrsa9+SQBdlxbudFe4mb3yaY3WOQwi2OnkWz/s3lLXCae5HBQDalknSr3TC?=
 =?us-ascii?Q?w+DbZf7jPK/PgY3sto+YTnrm1XCFrBkHradxdsLoHYOO1ULGThVtZprq6L10?=
 =?us-ascii?Q?nrmmWD7A9bQYZJkjpXW+uexlP9LSAYpjqEYCJKthMm/QkmS2m7uS9/7RurRt?=
 =?us-ascii?Q?NwpHb493Azm0UaIDn2X4+AoYFrx12rir2ODe8RMJ3+ixS94ZwqWnGT5tqMC7?=
 =?us-ascii?Q?716lu1AylTrcZrLzqYwgdVZjCNEaFBR0GG3KX7aqGGzF5kD7kcQD/tVu17Kr?=
 =?us-ascii?Q?p/QbG6t6nJAiSi2OL5fw4aUK1j8o+z6Wnfz3ZBGnki9rdJlwfJdjWC7VvKJ7?=
 =?us-ascii?Q?d1X39g7bj7ud/tUEMVeijV9CmtCV3Ls8dYunog+oMeHIqufkWgwjNolSrYgG?=
 =?us-ascii?Q?G79yTCuR4GJF1eCFV2pvldW7so1GdIyGge/eOpuKkHcFNSsJtJcBxV2Gmmgo?=
 =?us-ascii?Q?d4OvPsuOQf6fSpqHYRKwC1LVJ90ke50xfPWZlJCFsFKGTF4iDYhYo18D2T4s?=
 =?us-ascii?Q?2XlBsysOuvqPdrdbU/a6Emw4Ksod8ub6S2+DBHsqxXgFN0EDEPzRGxj3GoLf?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058b274c-8c49-402a-8c71-08dc59514473
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:27:55.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDWJxhTfvZPcqjwGr4JpoEXfI7wBHZywB5O+AIxi6W7XypB/5eRZ2JIEro9uhcu9I/b4caZEaAIRp3xab73/pm55kem1fMAFO8upPj8e5PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR13MB6665

From: Fei Qin <fei.qin@corigine.com>

Add definition and documentation for the new generic
info "board.part_number".

The new one is for part number specific use, and board.id
is modified to match the documentation in devlink-info.

Signed-off-by: Fei Qin <fei.qin@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 include/net/devlink.h                             | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 1242b0e6826b..23073bc219d8 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -146,6 +146,11 @@ board.manufacture
 
 An identifier of the company or the facility which produced the part.
 
+board.part_number
+-----------------
+
+Part number of the board and its components.
+
 fw
 --
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index bb1af599d101..d31769a116ce 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -599,12 +599,14 @@ enum devlink_param_generic_id {
 	.validate = _validate,						\
 }
 
-/* Part number, identifier of board design */
+/* Identifier of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_ID	"board.id"
 /* Revision of board design */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_REV	"board.rev"
 /* Maker of the board */
 #define DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE	"board.manufacture"
+/* Part number of the board and its components */
+#define DEVLINK_INFO_VERSION_GENERIC_BOARD_PART_NUMBER	"board.part_number"
 
 /* Part number, identifier of asic design */
 #define DEVLINK_INFO_VERSION_GENERIC_ASIC_ID	"asic.id"
-- 
2.34.1


