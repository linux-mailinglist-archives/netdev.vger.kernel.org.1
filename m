Return-Path: <netdev+bounces-84854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0A8987FF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EA71F2282D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E51292F9;
	Thu,  4 Apr 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c1IDraHx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2686AE5
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234267; cv=fail; b=jyOHyNgEzVbUXNfpXJ8AQVSHAgzmNBVKfqjg+F1Juo+/W9H2QyGVTTINOlKtkpCu9qkGS9cR3ZJOM7+MwFWyi7GRVfryJRS83RlP/REDy583I7l7N7OJBHenp1NNAIexPMBU+Ht/z+qfoFZXyMoFBJRFFnbJnjAVosh7fm5Gal8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234267; c=relaxed/simple;
	bh=j0s7oDLo7AVI5tMEaP6V3ptoP4NOQx4fCO4E/mluvN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtEWy8qtjb4I0AF5xKnwpRDCfWO1RIwRRLRwoKAlbW0qUOjhO7p7X0xPyBEmV4/r8G5ECPI4YeD+PHFjeub//9SIZYdo9ldoz/RlNfahdqh7WKUnngWp0MljONTqPMcdWNqzY6eWcW44F+ws6DOLREflH50sm3r0mfEsDQ4lCcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1IDraHx; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0+hf5b6DxYrEzRdfFF2dfYarEFYMqNKjnPufbrGlu9rPtkpSXkPosCFFSvDyZWX4Qykb1PMRkAwYdOSJh8MxtLMPHE39YhZY43SLfvqQZ0YNvs+U4XtiPSbfOkTfv1zsZlDtd2Au6YfOIi1K3x+r29X3+ke1/FI4b84Vro8bLQJOmFCUShpIjMcIaph2114TSChF/ctIaL8Y8BpW9O4p0TI94L/aFOH8g2ICQg6LrWa/1/zopFdxllkO7ABl0rbbbqkDGETWPCvC88eqBUu3O1pg2/X8pJ7U1oLkkPQmsWISra/2B6eXqV8SL8JEJWQgRnvulz8UTkW10YEmyP6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsfiniPTnQsteDUFveq8OrDLT13JLtoJig0rBNRnlVc=;
 b=oTzRoSiKlWerGdkouib24fyHi1DtjBAqI/9cM8KCn+3NIUvQOptUzV543dpVN5bl7BXIJQZ0nI9hp4KpF2/d8OvM8Mxu212h6vC/2loEjfMhVW6GFO3LqCOVuiUZCkZ9Kidd9e1ri01hqNmTlrvrLGnrkPm5KXLQ4rT2vDY+dUn2tpZZIKHL65UDjM9//JH0WqPQ4Uv8OyNIsp7/XCMLaAgVv3EiyI5QX1CgLaeTxplMXcLCuzOGVThDrUi9t/p1biRA2z1y0PuosRYnYSiBVUU9prfe/CFZmvlBSVE0XGgRhEfx2MNfNPJWcQT10hwUn+YRUzKv8vuCZLTLf0gc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsfiniPTnQsteDUFveq8OrDLT13JLtoJig0rBNRnlVc=;
 b=c1IDraHx6lNM4J53x6oxaLp/3JVHiaSvJeA2g5u0U2xZITlAVrjcxWQsryAt6VP/+SzTTdxF+Zm9aBbJ+IO1xC9nCsW0cc9QdAM7/Fv9BzQeulCHZAVjRM5NBB2fvwTfF7zgMum9hp5OP30BIE9X6TLXnXV/MfRUFbmkw8/yLiOllH4k8e/H/A1bcEPwSfWiBeYHMY0PZOeWxnbaMyip6RXhZbdgWN3JZsM2BFg3sswnO9kT+spohVHhDNo0Qku46v/Z240JSzgnG9j7GMIkDZyhgYBzjuloOEDr9lI3Jz+7+PNa1ayXiRvnb62SiMjxRqwPLb4Mi9G7TFjXMNY2DQ==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 12:37:41 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 12:37:41 +0000
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
Subject: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Thu,  4 Apr 2024 12:37:00 +0000
Message-Id: <20240404123717.11857-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA1PR12MB7104:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D0aN0zPei1Xflf2CsBPgoXx/oCFEDxuUcK7uoSFAJkFvLwT30ENs2J73gJZGG/Qe3xj8/z1ASh0wUj1LjboSN8pjCv6OgH5hyeH1hY+a//ieWEoQelaaT/kODdObeaftK8aWH1JriUTj+Knax8pc/ZhXUc0ZEKvT+aVvjde9kAB9VtMYyHVlRVf1LsCKekBmVdf/Eb9JPuKmPMrTyoOSLxWGLKi//VLPHM4+GEUuJSJxySFljYn4FKAFapKUq10XKDQS0ghJ3+vdpW84w3/NUey64F3XZ7nJo8VX86xgWBdyBW6/+K1O+/0SHFzTaP7vGd0jI0xmHVLl50HRt/9NwB+vRxeHZuI2gzBPYmye/Q0cEz/G1ZmEAe4kgGpZml3X5dOiedCSbE7RLox37Bf19xP0RaxzFGisgVVFO9s+AdiFTXw8kQzGG9goATy1SvbdifMX21JHHPp9frPdrQSYfJvR87eYG/amlf1eJQIOogUdsmy6sD6c7BSHavxMP4TyWjqArqMMDJ1efbMXrrU4WN5G5nU1xMvOYyykScuJ3tkC/ycyk7bxuI9xKNylC7HWfvRbToDUGkOXKuTG8lQIkgT5lNDslPvyF54BicKo8rs2Bnhs8X/mfrc6x4KERN87ydI9FmDhrymwI+lPrKbQMv7+YTDrk3/qnRvlsxVf+jE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssNHO8s2F68wRZoGzPzoZOhtd3ZPk0VbG48AYXMBN0m90GykvujT3+YM5ni2?=
 =?us-ascii?Q?D7iH057cgzl6+1ZVivsZyx8XbGMe+q5npCZusQFvv1KLNC9GzTj41CyuITGF?=
 =?us-ascii?Q?Alvw2DFn2vRUYEnbNctnY1IBznaVzyCLbE6zTd556uOUBptVMvXnsHNdmRxu?=
 =?us-ascii?Q?hUXJMWbBJHzJ46rlYv8baWrW8Bm1LyvjMhBBPVPnQknWltvYjz+V6yChxOVb?=
 =?us-ascii?Q?/+9yVZl7w9qfAn6IkV7SasLIgmFAlWukbkg21RtU70uQPmNv6+CfS76OGQGx?=
 =?us-ascii?Q?0L9WQp1HHM64t/f7gaZtX/f9JMXcjrYFnswiq7adgv2/U35DcuUPdz9ZRZhE?=
 =?us-ascii?Q?FOrQ5+CGULTqKTzIhbkrKYXiqOo3QVHMe+DuKv6oZSPcA7VSFso6lABYcgsm?=
 =?us-ascii?Q?bNBOyQj+STitOdUfSAEMOle3S+kbhPVkFrq3IK9mjNVsxZ2aDP0oojVQpVJ2?=
 =?us-ascii?Q?QXTAWXVjrluYdUsCOZvc/T6Ym94OZ3OMveiYF82WoDfyieKi0KBTd15gHKLl?=
 =?us-ascii?Q?5jjM2oEjsTRRU8wEz+zWM7jzb66QF84UcokFMJizL7DEHqYa0MH02FsSvd3a?=
 =?us-ascii?Q?qRs4AMntCEw/zw/KgbqMEu3GNnJvagbfgSjhmI0gR1AQQxMRYss2QUCDJviM?=
 =?us-ascii?Q?Gb1iIN17GvexAXU0J6yxOCo/Qhhc8k7XVvRYZDlDwUhTOExyAsiHJOuNPE/9?=
 =?us-ascii?Q?CbQ4EjajpFba7LqNSPsGAr3tLNNDuoW8tVZgpxy1aHRp9oTwKv8+lbYYe2eE?=
 =?us-ascii?Q?2FW9s4Fw10voEd3DmXrXIhWQajU7OoluIpIzoMvrv0nuGlsDbyk/+KyVBXcz?=
 =?us-ascii?Q?8bpWV0VQMEyp+q2aZoGTGrBzenBn57uDzww6SNA7PKDAxkQW8lilhoC2a1Nj?=
 =?us-ascii?Q?R56GbuWOpFiL/0ok9Lo/3X6OP5veRZBPgL0H2c9h2CSK7gBgiufZatQCBCDz?=
 =?us-ascii?Q?PVVb2r97fTpqIa3UUQwe0x6aJ7ere6Td1laQYKGv1YdoolHvr++yrI4nEleL?=
 =?us-ascii?Q?AEThttrHOqIMcEKMqkSL+ehJFccAFA5FWVCysKv1azHWWkup6lLjQ2X2ChYb?=
 =?us-ascii?Q?vOYOg8D9Spal9Lz6+rbLtFwkIo6jQdHwHvXW384RrNSFfPtMSVWx7Q3zJUKD?=
 =?us-ascii?Q?Le3TeQoxRYnsXzZwb1T9xLeP+SeY6dgD99PBeQj9NCxKMNlVn5wAlMDIWQ2T?=
 =?us-ascii?Q?xKUl6+BZ1eK1fw55xaM3B7v5y3lcsRINmpZVFGok4TLpCoLl+Hya05wJ2a/1?=
 =?us-ascii?Q?Fm2IlW7z/ePY4vk1VZDzc5gJJwCEv3AqG9+9Of6Md0ylLBdUuHb20TghBEw0?=
 =?us-ascii?Q?ntZ89lUlkxcWWb7gz509LuIUSZg1Ah1QlV29OkaXdgG0IOY0ghIg04q9BDfX?=
 =?us-ascii?Q?KWezFFgV/S8E178oEMkLD2ereZukneJZ/6RptA34hSRsZcXOrKGxj/DgrYqr?=
 =?us-ascii?Q?OP/StnXkkjrfHLkf+FWiNGvyiwoG9lcYt/5OIuv5LgH2SRe0IrPXaTp6oQj/?=
 =?us-ascii?Q?ztXRhkiBxNWexYcxnQKL4kVbfpeESRuyQJW6eciI+UofDucS2ruwQEaYMPUg?=
 =?us-ascii?Q?bkdpx2CdLVixsVCaFvX5SILdYHXBI8hjbQhtuGIZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca9d11d-e67f-416e-9526-08dc54a404b5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 12:37:41.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAYHnj0+lTUBEmrLckVBWHzqQog0KZie8KRtIb4emfU53jUzGAL57jjGQ+yt3Lgl7h/KzwNqwpn1VzUVaidFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

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
index 4a6a9f419bd7..a85125485174 100644
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


