Return-Path: <netdev+bounces-168441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6202A3F101
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13281887EA1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1920458B;
	Fri, 21 Feb 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvFW9xX/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD61F03DC
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131584; cv=fail; b=bDRz54bn9puEzgNbVUiMKdL8ey/XRYcZaLhJ5CexdQ9XHBtmRG9/ciSYwmBhrCH22ipeVeRyEehkHByr/62LOFTXWTB/IFC8OPvPkdOtwM+BFBxE1USYLcehIDYLp0PQDHo2/O7BBwiXwbTaarvvBLgoGV9VePzAk+l6PYV1+vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131584; c=relaxed/simple;
	bh=rwL77RRGV3wyKkrZJQf1OcLwI56cLgyZTeWuVfMYtBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldE+7cWFKtPTrF65dwDrd+u9f/ye2qW0pB9o2ge66sD5LkUxDhX4+RMSaxWWc869ERA+ofWJc9X9/Evbrc0CEilS7q/j0jqlmFP8P/qcTgvNvy3UjGlwtDEMAWaxefKANZSomyXIlhuwDLkc0g5DIUMBSAidnSzTuhbPGyH6I+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvFW9xX/; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtFJE1rHlFtl1h1/r03DER6zz/60w5IEYSkDDNfaSMWcTGctd6YxN5W5uJGFpebssUBDogf1hzSqurD1RXczydqFKr8sRuu5CDiVWasEY2jfgMWlWnkwIdMw5Xbu98ql4UsmUBJeux4Yu0X5ZmtAma+XtOXbaFYWjAUJqjkiGeRTujgw3nXCDwf2KO7ORiu5CKQB0oncIbGTd9NvCz3DXkAfaKzHtDYbRgFhPmj/Gj4cfREic+5ISrMZjPt5ANaJs6u6xSH6egpthSN/a6KGCqWM+vDieM9TNOM32EvuzyARI5zNuSgfGUC8BjPeKelGXE79JW23cwPGmw6HpZ7jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvxBRTTA9mZIgTD7KFLWMcDQe/foBZACWO8vpTvo5h8=;
 b=Ra8ejpjXpr+7qUI7RdavxCZWwbpHnEprIINKdZsoUlxyKdYLfDNoeSzQO5iI/0qkBHnmOFelAr7SrA2bKZ1U3dS3/LsxedpwR8DHU/ILcbrackFYXo0px6GsnJhLS8mWwRPt43S64sP8LUvNzY0epzBEyADYkZGAjudyZBU7UTA0u9Hi/mJ03DxXuSPEni6uruiciDkUFT7d2gwSr6gBk7ukbrD1EOZfenz5+Ny96jMqGqZ8ySIT10jc//SkKEJP8q0eRLcMRMAYOIQIRYfAdGB+87FOoHwCN0K0DezBqZ8esasY570Zu0WMPb17vFWgM42TL+ReHIPEE6zBQoKSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvxBRTTA9mZIgTD7KFLWMcDQe/foBZACWO8vpTvo5h8=;
 b=tvFW9xX/06wKojA6ActerLD93+XJf7rC4mmrT0sLLlWBnQbCiWNJwTTp0aMIEcuUdTOC2dyETDb7Iq3hnNY5Tz4KjHQgpzuyGEjHIBQwF+i/LPqSHErlqhBci2WqX0+aIMhMwDxasWOiZ74tK76yVhKOk8i+wXzURhVfhEA8hv8OY6qfIVZgBoMk7pCgC8NsIZhIDpVvISk8PhgPldKQtDCAOjUwvELuY5fxC9iTwwENoseglAf9KwOjQraiTeFyxaYg7Gsad1xZDt91pBFV03P5kE+RFJVkZG919SOFE6xW8Hd1ll0K907kNxXP9exeD25DVrIJE0PEJWZbKWShCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:00 +0000
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
Subject: [PATCH v26 03/20] iov_iter: skip copy if src == dst for direct data placement
Date: Fri, 21 Feb 2025 09:52:08 +0000
Message-Id: <20250221095225.2159-4-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7262ba3b-e722-4c7a-58af-08dd525d86e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pEDw+S6KdNGtYLDf52oM+7kBbt7vZVwt/nmr1ZzX95zmTwZKSA4/TFJHhMGn?=
 =?us-ascii?Q?R/bygLe2YFR97O/Fk2WZcf7XvJ3o1pHwiymJ064+NMTsu3IoBzM1AHupfdtf?=
 =?us-ascii?Q?nh2p50jyg4B0rRwtUmkXVVW8h+2md8j4PHo/VcRItXldmGYsSBm9LQt4PP3Z?=
 =?us-ascii?Q?4kNMQ8XB3o4oXlY/UxPhfAbGe3STeolBM2F4z6unY/E7CiYLkLjGivVUK7G3?=
 =?us-ascii?Q?ZbOFnp5TzBknYnaMkYWV8C/6p+4JyOqEbzM2v/3JOSc9nSzxG37OhP7I9+W0?=
 =?us-ascii?Q?kMdJ6LmGQYzRQa880licTjHqBjVe79g/Z9Hg8aUeSwJ8OOReztt9cG7qRHYk?=
 =?us-ascii?Q?41QJsEKpP/CKi0kNWsvo+gJyZUEZ0EWX4NCJkpZauLb7Pb9WCSTYJ+AZV3VH?=
 =?us-ascii?Q?8faZImM+FqmoODJgobnhXqKvExgxzWjctg9JMimTNs8H/pwf8KV3tmzE4nNH?=
 =?us-ascii?Q?H3nEncX2JMzIQa2ewFk/ih4zce+aPyp98mUaj9RGqPMlm9NjGYILMdqd00oW?=
 =?us-ascii?Q?MuaEs2KcMd9CMPCgzvf8iKAByc0G1/x/7HSbPOSOfCsrYyM0ObBiijSkA+aR?=
 =?us-ascii?Q?O7BRRHxQapYoR+GKCnr49CXPaxrWazIlChHtKdcMAqQwDfF0eHgKiEqy9Nxh?=
 =?us-ascii?Q?G8ku+8nIGSEFSW1/csekGTlLSQ5Jl2Wy4tcTzty85jW77Lie0CBtg6S4hUJR?=
 =?us-ascii?Q?0GSGH/3v6oMm/zT1aHcRNueq4N3KVzWXciP4WcBP1eR4UrzXTxvUqf1WJ5cS?=
 =?us-ascii?Q?c+UvU/hzN2RBqWNQGgqWblT9WO0Io0yWNTSgOZbRute0tr+7E+OK4WHpWB2u?=
 =?us-ascii?Q?6A2IBoCtYhW5gem9YAU+dwVoqLRkbMKxjSL4SMoGzBbu6f8pq9L/IJc6xtk2?=
 =?us-ascii?Q?X2j2T1HLKVhfabgev2Nwq0RS26RrWu7oIQ+1bxu/Zf1D6ge6xBExV+DTlTSd?=
 =?us-ascii?Q?1lEr5e6AdWs/28jUe7nSWm2J2q2rRcDUpR6TiSrBa01QSsJCVuKE1wSbMcKP?=
 =?us-ascii?Q?RvfoQ6+umBlXvONkpd5EMgytUN1Rt6L8DW1BqWeDL2mv8PwbwItzZLxD5y3s?=
 =?us-ascii?Q?j7JxBugpQF3wa0V6xCkesb2H3P10lojDPA961HdXq10aFUCW3mOU3ojLX9qU?=
 =?us-ascii?Q?HX24Z87MtTt3rbR1miiSUhrV6YNYeKK/37dumergxHvBwMeAW+zbHYfKVeEp?=
 =?us-ascii?Q?P5hIiQFpl4lCd7xRei5BzO6D+kpz1KUxZMrxy9wMp18JPUH4KkegJ5j+EKzv?=
 =?us-ascii?Q?1A7E+bAMljvITnBUVMJsghefZ2nHIIGi31e8wX96hLHHcgx+HAj3d23NY/T5?=
 =?us-ascii?Q?Mij8rMfqDs0b5f93JKlAmC9J3HlPK9QRhpS3gGD3baTCTxafbxM/b2N8i7K2?=
 =?us-ascii?Q?meah/njNYm7VLhFPSFyR7ZJomQIH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JgLFwZPNqcRBw1Y666iJiHCaSOA7T1ZhjJmVx2i5Ucv/cGFe9Z2tlkMexJo9?=
 =?us-ascii?Q?qFynBdcxKqO8XPWHPdRf2O+E1LDWapHj7COeiaH+kCfPyPfUID7KB1KrzhRZ?=
 =?us-ascii?Q?OpOfWi1Yuzb2i1VJXS3fPGAJdAh04ZpEqlvUgXWzIs8DpFUvj0KGemVFlnAd?=
 =?us-ascii?Q?iMreZ3AXALb+JNbx/v1N3MGBeYkASGjACRJpLiMThWtyqpy67JVqDNWaRyz+?=
 =?us-ascii?Q?g20sYjHd4lHFrtLWkUNEv/TOYjJvbRODVZiFVeokdqcrDajfVXSIkVtDBkFY?=
 =?us-ascii?Q?CqlYWtPgVD4P3ctVyeGQ19e56E0UeOF11MXaT5Pr5yhaKIM/FqPYuge7KtWK?=
 =?us-ascii?Q?GAWVPSoDxdi6v4Z16GRoS9jgPLQ2XeCBHeJX5s8wFYWb+L1SpIERilnPf5u1?=
 =?us-ascii?Q?+stJRXK314MZkJZ5G/QiOwUPoF41AEmmVQhdfZmEIcbUGpl6YXVnJZNt/ub9?=
 =?us-ascii?Q?G02TSouh3CJ0E/iX02dS574mx+y5ryiqlzW96yDkoc3k8bCT0OKJW3ac6mNH?=
 =?us-ascii?Q?RH1GpslAHEG2tqaaTscWHZYvzBMjKRYEWj/YRQMYOIHYPeb1JZgQH0+/4hKo?=
 =?us-ascii?Q?C3nI3BWBJBponxVWBKezd7+VP7Tk3m3eRaTLRzMdBKBfxY5tcUDQDHDWr5th?=
 =?us-ascii?Q?iJTU4+Y4r8qsj7kyvkoIiC/ZjZ5HeZEurSHCT20BQl0SujeJpvkVWjFjxj3m?=
 =?us-ascii?Q?PsQf83bS4yBmmLp1OOeEYTixlvBahSxgYR9SYX4duIDl9Qp30/PJGlKxpHs5?=
 =?us-ascii?Q?MuTmtaX6xuvdA7+fObpLdB4s9LjX3wNG+mPNN/l1E4KoQ7uCUVECtWA6YtWE?=
 =?us-ascii?Q?1QqHkRccA3+jkAODZtLXPqUY/R0zLzEYTlSMS2ghglPUUlf4UhdCXC7+Xsxw?=
 =?us-ascii?Q?kHA7XHBpvpOdhAb66lunHser+OhFXTuxXJ2k8UZN/LXQgisypt+h1AOcbiQ7?=
 =?us-ascii?Q?Y1nnHVHMtF/hoUkblIIT6Zbyws+g5oKilZeXr44upWpdwLXU4L24CWZ/elC5?=
 =?us-ascii?Q?ZLduQ8lDrURhvNkRUppVI+jlt/9DFi0HABF6FNr05+CnSY1s1liNFa5eQAuD?=
 =?us-ascii?Q?5ZUaZsGKTLweIo2JTF5eCPpprpPBxZ5/yc54i8UV+oY2W3+d8+nCC07M9oBs?=
 =?us-ascii?Q?b+iFD+DWcV8U8eB1stXWMUC9N3Iq9W9u3+iWPueSLmxhYKdGnSxbCCYd9FGO?=
 =?us-ascii?Q?M92HEPrVtXsImPr7Lb1u+WK1ymp0YQd/4afRrvGtr89YSzVhATvuYLq1oPjb?=
 =?us-ascii?Q?aVw13+1TW49IIf3XHSwRgUVhYMeH8b/vSPocAhnLtamms6xi0F9cOvxrHxTz?=
 =?us-ascii?Q?7C9+Bfw2DPD6kUPf6LL+OMHAiyXJDbJMvF8B2orlsS6reXLkON0rhXI3H1Mv?=
 =?us-ascii?Q?W72PtjlgX0RWb8aHjbog1D6OeQI6bURT4rK1UzH47vHKdDXjkWRKKJl+AlIA?=
 =?us-ascii?Q?BWp7HmNY0W0Ta+wX3sbcZm/+Kuo9xOvFz18fQ1mLXHsUYAq4aLsr9VJFh8Dz?=
 =?us-ascii?Q?6vX3XUV+OAvgKH/8F52lE8Er6jyyqc/dv7o1Gkx6Dml2zdA24gdN2uXfY+US?=
 =?us-ascii?Q?mvKrGm9VF4WvYh0sL171LoOmd1iY4A5dQSsF9dF8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262ba3b-e722-4c7a-58af-08dd525d86e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:00.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riZMgCDOQzwBITURaCvXtesASHBgPVgxTQFoMBHapn1665JvcY5bJUgdRhPuB5MVobmJmJaYUvtjndy1pg88LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

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
index 9ec806f989f2..4474ac512d6a 100644
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


