Return-Path: <netdev+bounces-201376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094FAAE9381
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4D67AEF3D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CD1494C2;
	Thu, 26 Jun 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tjxjkAUP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCAEEDE
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750899132; cv=fail; b=oe7Epd3WVZKX3QoC/k/0OeN7aLZIdY03Va6tT9uXDKcZuOiyWbvO9SaEbrwoeFAAtHfgDz2HT4FsoUS8+XXtU+tkRAnbdExIJ7dmQOx7lmvshKHN+2MR5Hqb0dAisCOtUlf4p0M805BZLKtw17WnmrS9HzesPiYpY3ESncRReDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750899132; c=relaxed/simple;
	bh=4W9wczuuftBPYg937L2YvgNt7vFeJdwhi04iEjBueik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ExtiSNov/J7k4Ox1RkHgynjSnZquqFUCpc8m8ZbRN7rkzDWWjbwNGLJLcd6HZlZ2I6pbupikqJK2MW+ZnwtRDVNvEo8zt+BcO/F5t0yb59rtUC93fE3qAdPUXunsOh3P46uDOfTNHQwcB2Ap8X5eEk+/XIgPIbtNROyIgT6unqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tjxjkAUP; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjkfN7SMYXTkhY5f4FbPEGontsXQsXxbbfF++JQHo//HhI4O5pt0ouNNBtpZicXTP3XoY2CJlGPBJhAdyC48zQxqGDnB9OmAHpEB5zPkGc/IhDtDH51++P4H13k60HRHsw0QKOCVf+kjM4dfFvLPmI5t111/db9ltdUndayjsioERaiTe+/6iHjLUjqAudP+fyQkdr82p/vw+lSNcpXywzJPqIaZF4btXa8mq/rG8UWH8SIDWPFMj+0qd7Z+VDjOmhYD268aN1WK/e65VZPhGTUToSafhVQ6S3w9XUm6dLZiowTTkFKE/VGjU+beZGNzBvZ3x8YRsdGXoIIWQ7CGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBVt1DE9liuiMxm0i663vMOKu2Yvl3uhbDZc7NEvZsI=;
 b=Xj14eDgMlwOgB9Wo9g4vFyScLpYY43p+L4CQOEIJUsuwwmukgJgV5P+FzBOcl/6XxLsQ4Ib//NAx/tjI7PDFskkt88+YxI/5QZepJ8h/ibewgI3pv++U2YrIkKfl64ZhITe68l2LEvXavudftj9oeJIPNDsk9qnwkwfn33kxmtx1SyF7VXOZuLHr9nzxrfTyukvVPreRnynj2pIPlxdJjgXCfQLi+XRYNxfS6Vl4RD/1PnW+aIsRH28ueb3Cgl/OekuwD6c7e7KuHnR2Y2hiaTLsKHyZ4ne28zfSznLKUvYh40j8S5oArC7tWmwHpHi21m5XoGHeuFdDMosmO8jv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBVt1DE9liuiMxm0i663vMOKu2Yvl3uhbDZc7NEvZsI=;
 b=tjxjkAUP1iX+X3u1JmP4svDbA/YVAZq6tWGTXVZ9IhM9GL6r/IB46ygOp1LPYAd+HHZaeiUCiDaZQYeJfIhHXrvXJiB52NO6fjP79yxhBjMS0V8haallOjdHACzudvs+aEnP8w00lyooCHisenuiGNwuJtiysjE5JH0nzjMJtPZf38jC4aX8mmmvOsnKgR67V6FfF6uQX9Jq3g1Hl5f58QpiMIL6fSMNRM1jKhtU5GdqkxcuNnuYTHQTVSt5Dxo2n3+kmbLIcxXzWGFOV5idpJSLSH5gaGR/+gl3SMnIltaTV6giOzlv94qGBcRxovlDwfMxAEZTb0ewdFKAT0N9sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 26 Jun
 2025 00:52:07 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::843d:81e5:3051:a728]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::843d:81e5:3051:a728%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 00:52:07 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>
Subject: [PATCH ethtool] ethtool.8: Remove "default" note about rxfh xfrm
Date: Thu, 26 Jun 2025 09:51:44 +0900
Message-ID: <20250626005144.79972-1-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: c85bac8f-bff2-4f3a-17c6-08ddb44bad1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LLBjZMGLwS/iKOuI7X9AwqcFs9WMVjVxHJn4O08AUvx5zTZckmeGOXrcyC6S?=
 =?us-ascii?Q?52VG84pklYhsl8M6dM+1YAtxjdxHfggbnpgqw2brgg+kpr7+qkzGYdzcpI5Q?=
 =?us-ascii?Q?6KOPmnkRMQd1ktwJRKmroZUFICemtT/dzWyAWQ2aDEeU2Fv3sXRoFbiw1Lqa?=
 =?us-ascii?Q?eHAJu3+6YKaoMTOP7ankm6FFE9oODG9LkCFYTJoClYJ0wSKoJbZHYRkZNr+N?=
 =?us-ascii?Q?+w8s31NR7KPz6panoOOh9WTimp2kf5ToC6KX2g4YvDlEuV4nEailq1hW9eG4?=
 =?us-ascii?Q?hTAMX8BtebcHyy1ufyaH1nSOWJbt8l/+X6TgYj9x7XJ8FnH2KPn1gx+4C+mu?=
 =?us-ascii?Q?z1g7R5VxNsPSKi47O9OPyI7bW8hTFQdjE1Tiazvyoe9zh5ohh28ts/rN+I8x?=
 =?us-ascii?Q?IofW6H4HzapaAtyn5D9oqz9AuRZyJNt82dmNS0K7qlvksxcz4swLO0SBWhLi?=
 =?us-ascii?Q?IYJW+oaV5ZtDMzupGd3dHJbbMfVjVlIrUmwGPzjyLlxpHMRixRX0smVxmB9F?=
 =?us-ascii?Q?TPWBtI6Nea3W4W/DhabVWPv4P5SsS0Q7828gJ/rTorlMCvAFSdn6XyiNHEaI?=
 =?us-ascii?Q?w1nRYpm4T/HahjYb0DB8J7qZJI/BFGjdaBkmwLG/diar+AuGljzAoAbv5HCw?=
 =?us-ascii?Q?3dp32k6u02z+jn0eLmUiZIZ/aeywwzjrKDunXXBty+RNBfCXXZ8EAWBM/pIO?=
 =?us-ascii?Q?vaZOcAqd8QG/CMR4OJk9oQzhwB9Ed+n5uUwrTT0K20CaG0xzSAt0rqUjM8WY?=
 =?us-ascii?Q?GxvGRxuBzvL1PT222mEegJ240mR3wzBlscLZcZMNaJtqU6C3oBWzAvDNMqga?=
 =?us-ascii?Q?NA+7gyZ3KNfETFo+t7RAiKJXmz1fxnPJaKZTm32erlMm7h2q5SgN8D1cfxV0?=
 =?us-ascii?Q?AZMw0CsuLf5foYlC4z/1JrCicVpuIsU/4H6akO42UYRnWFRJi/zBNGQ5PIAm?=
 =?us-ascii?Q?6kOvzTKuncXqktjqR2mfye6o+PfqW9pbacU4DEoj9U6lIhT9BK9ih+h2QhRo?=
 =?us-ascii?Q?6w3dCxbHN0Habn8X1xo3h+YMaYyblKCZ2dX18gwfI7PGQNcxlXDjGb6IdRxG?=
 =?us-ascii?Q?RcO6jm3O9FjOLAp+882+aZLjJBtwusKw8qROumAb02aasJkORjgiMxlu04fK?=
 =?us-ascii?Q?4uNiWvmOlNP5KHJZ5XRcLI89U06P5m7Jz2nCk0YNTDh0V1muCmo71+BK+xHd?=
 =?us-ascii?Q?b2VEg/hHQ3YnUHOdiiX+oSn3tzQqJRbUyyK33s98l3vmOYxaDx6jxrwUoIN8?=
 =?us-ascii?Q?iJPjTB7NYs+4f+8C7HTOP3xGU3sEAD5l5mzF5mLG+lpuo/cnvH6sg5eEilMU?=
 =?us-ascii?Q?gKx3Uq6dcldtIdJf9/HQbZQKUzdzMtLcRu12QxD3Kw27bSRSQMQJAM3lvaeX?=
 =?us-ascii?Q?cl6vSODedgkl/VJzS4Xl1c1tVfBFQxLkFAhKK/iSTbDAQ7KF5dT1quz/dMwz?=
 =?us-ascii?Q?/c9MDtCIimI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aUQHcKar4r3jAQ3XrnTBpofUxkLrw8QQEOBTh4FW0YLMILpN5Y6Gd2UfYDqL?=
 =?us-ascii?Q?XxtA3le6+b6WfYcxGnw/EWOz+htBWZqF9MP2lNAK0hpojy/jyCscvot6ud/6?=
 =?us-ascii?Q?Oat+hAvUG62Fk04MoF0MDTu/u1qozwAQsHTCauTwCs4HkAvoZRwKyhsa/2Z0?=
 =?us-ascii?Q?LRAt61WIjhg7J3gXRE+Wp4isRE8ue/bmZf6ebvvZYvFWPdLZ1OO1ZlV+3KNw?=
 =?us-ascii?Q?FsLaamiwjpw8wuEhgGgThuO3/tDhRzL3W2ykIqPisGST3KgO8TKPgm23E0MY?=
 =?us-ascii?Q?568cGocrJZPxK84lITiin39PtwzWZVydyRZ71nyItj+LGxgAN9q3BA6EITli?=
 =?us-ascii?Q?6dqgXX2yZ52ciS8kaRYgG4trAmpnCkUBzAHRDbMLES3BCLqfwRub/8M9N3qH?=
 =?us-ascii?Q?bQ09X5NGbXJDH5BdN4wKPNXLjm5qdnegbnSXRwiMZgS58oqBD8vc3tQ5PbOU?=
 =?us-ascii?Q?MCfcQ0hyqafJ4j5yZnzLfbwXuYPO/nfNhZd3gd7x8ZKvtFPBrytwKRQeCsJp?=
 =?us-ascii?Q?nNsPQZsOY3m6B7pE/fHfaid5lkpSJTqbyVoJnRgZ5wDLHYuu9aY6SYpKOFpn?=
 =?us-ascii?Q?sDer6k46KwoUtgFNii0301sR8RxGicSvjwVeGvTu5lj368vo51Yc3rlsuD3D?=
 =?us-ascii?Q?4XyMGQUHhb6s5is/kYEkgPoI2SQZldcJIRAl6CO0D+X+1GcbjMGMihQeSjIm?=
 =?us-ascii?Q?k4liaqm8yZx7gPMvrMQixNm37pnRjeLf/qw6PVK7kaHRQR9sZfAjwNx+mqQN?=
 =?us-ascii?Q?ZUHx9q9KqXQEnJj0cjEx/guh7GqrjIREs4q+zwOMWoCPxF/2bNj/kC2ZAAo7?=
 =?us-ascii?Q?tmshMwwlLEDK9uX0gOMc+m/YSwKN9oGun4jhJg40XqoPo66snuP5GeGdkwqd?=
 =?us-ascii?Q?TC5BLPEGwBLRMcu6xFElSAo3wm84AM5YVrEzTKaRfkJ2F4uW+WennoUh/Dit?=
 =?us-ascii?Q?Z0FE9G+GtMh1/5vCnUNBkVR+rdc7Ta+YbQdr98hxBmm1UBPQTPsRlT7lHQCX?=
 =?us-ascii?Q?IP7RwS3b+Yc4uI7WYIyZmveQNqkeR7bOnPJMRkE/IqxsPoefMKDoZ2yC57rs?=
 =?us-ascii?Q?noCcDC9Yfyd7dMks1/zf3+3Lm9wCLN7SI9LsmOG5vuQ8ReE0vs5GGbtjXZ6q?=
 =?us-ascii?Q?PyJdUCJMyL2BI1Ju2uWkqbeCovh3PA7VWb15SKQq03JMI7jz6WJvllHdrqeg?=
 =?us-ascii?Q?7vxHpP2oqoOzO5nrpBbp7ec6kqaokld1sdeI+XqPq5ETnMdBLAiLotUYawSR?=
 =?us-ascii?Q?Z6LMq0AVxvTx5Jwf8X3sd75uDNYXy/32u21yVo+rdShHP3bhi8E73UTX9Hh5?=
 =?us-ascii?Q?c9Li5gNGEOJApV/p1580AqQYgTsW/iA7SzTMOjpRXlE5T9NW9z+JcMs2ATsI?=
 =?us-ascii?Q?2iBBuSUwleBzwhJTYzpAGj5GdYu0F46cDFlbVactyAx6Y/eOkF2QPb/CCof5?=
 =?us-ascii?Q?NveV2xeUg1T2UKPvqSzCRzjZXiKEBnU13F40Xyall8jzt+581s9c2FWgke+g?=
 =?us-ascii?Q?d+Vbcy8O1MwBTb5t/lBkDNIQEwVekQaGixCgxxGXyGwrz0+GvFHA5eF6dvXq?=
 =?us-ascii?Q?TXQ/i070yqdjpru63mDl/oc118sUORUYHqAFsbcc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85bac8f-bff2-4f3a-17c6-08ddb44bad1e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 00:52:07.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDs5EXAPgVsQb+2fdd/XAv8F1NzoZ5m88l1AOdsU8EdIL3sj/rPVcYK5ULk9flhG8Q9V/7D02nqv50NMFT9xbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

Since linux.git commit 4d20c9f2db83 ("net/mlx5e: Symmetric OR-XOR RSS hash
control"), the default rxfh xfrm used by mlx5 devices is
'symmetric-or-xor'. Since the default xfrm is driver-dependent and
ethtool.8 does not document the default values implemented by drivers,
remove the comment from ethtool.8 which says that the default xfrm is
'none'.

Cc: Gal Pressman <gal@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 ethtool.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index fd6ce20..29b8a8c 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1322,7 +1322,7 @@ and destination fields (as selected by
 then yield the same hash for the other flow direction where the source and
 destination fields are swapped (i.e. Symmetric RSS). Note that this operation
 reduces the entropy of the input set and the hash algorithm could potentially
-be exploited. Switch off (default) by
+be exploited. Switch off by
 .B xfrm none.
 .TP
 .BI start\  N
-- 
2.49.0


