Return-Path: <netdev+bounces-214290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C7B28C35
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A65E1CE5A79
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5A242D9D;
	Sat, 16 Aug 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FQPrAghr"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013011.outbound.protection.outlook.com [52.101.127.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880C23D7E9;
	Sat, 16 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335271; cv=fail; b=d+9f61GKjSadXjPHE7iXQSbCtsETnqGAs/4TbGpGvNhFHgqnXKxIe7wH0dhZ2q/900+x8Ad0WVbIPVg7VwJOlyk91sn4mcOFowDdGOEHSELtUN3aOY15j2Bx5uKjVA6cq1zJXRxin+x2sMzdJ+5PJqC2e8+zupWnWPKXgxmpBbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335271; c=relaxed/simple;
	bh=RONMa2ikn2wsB/Ey7wpwT7gSToCq7xrR/pCzIBwe1wM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0pA/LOMjwVSSECQksJL6Kb0Mrm5nxN2f7rZAfSggJ6yfpn0pff+BHQ/ycUxX34kWNrqTEgBQ+yZotmmJKkhO2Wp3YeSGqtbOsn/zpRyHCPnuy0Ckk9S2il2qZ31iAz1HdruAZKWZZSMRjFCN10fff6LsJkOzOS/oMwa8b97vPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FQPrAghr; arc=fail smtp.client-ip=52.101.127.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6o+IMwWYAxff4P7u54nw/K7bVrwrqq6mXaQtLOWpf96CmsXvBNfq6xb1fOqClN3WSLloNSvkr2NspNonQzOGeKXRSdau5pZtbULbMLcyYyGTxTuyGGgL/fbK+8uTl2EHLz8I9E8rkVu7AKcKatvgErqHEChMqROLtC9nbJDp3zG2HRIMU2rbO1ac99NHjSHPQTvLsZ/O0MzFHPHQ+s+/+mPwyRSX3M+9dyZOXaMpdauBmJjkeCIyoOyToblX5hoDHYpxQ4XyDqfPBsowDjCUkwcGROu2flSiu5ZvkKONFdvuu6qAbjgx43A7hatMJkR8eBkxWhZy27rfMFf1OwbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtBoFe1vdZ9oleHWyUJUi+QZsigTWaqMmO/4a1oBhSY=;
 b=mgQyzftohliyAJ2mmeBMOFawjbzjxvh6eUE1H0JL78txpaW718i1FIrCiR2QcWjR1pWnGAe6nsuwI03SoIZQLT7p4x5r5JRBbk6rNGzA4NHOw0NsjIMBB1Fpm6q2C+kc0sHypY9ZFhq4shFcqArQTcV0ko4eZWdcM+3cHtS8M/gC6IiFgJjXj4FiGxxmlLbciR01NiGM2cwf5lo9JELbkQf9pKuyBdMGAGgYKfYDZKSBbQufCQQX89qtSU4JZWrPgCJFAmch9hds+pm+18xTMUBiBvvSBGCUAmIR6faawTAHR8QLy8UC841TiYBqyJp+pgDIki6LRlWi4WRCUJsFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtBoFe1vdZ9oleHWyUJUi+QZsigTWaqMmO/4a1oBhSY=;
 b=FQPrAghr/hgfG2LLeFDPjdfIzkZdB2VcV/MS+aBJtomIF7iPYO77OfBZb6QjZZA/H9TxNLImWSDYNBuqVLFOEHDKHKrwUQ13+zM+2Ri8CyV142V8rhhohW+rD9gQjilsWE8khZmXkAlHbyD0yHZKvcBB+bmB974BJBeSXNjGsEW44IRuRpSLiG2EdwHE879g1m0S8FTU5Y2unR4ICXyh3Tv0rrwDW8/wkZxBbEJeTC+3NTL77/01GPYYFTK8ws9dc4Cf6M0c9q3XxCgyXh7LvkMD/5VBHF8RHBfV9L0kzgRx1o4jcIi/Yc3Z8BqRAapUUzMIeOxtGh7C02gQNADgzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB5962.apcprd06.prod.outlook.com (2603:1096:101:d7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Sat, 16 Aug 2025 09:07:46 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 09:07:46 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/3] ppp: use vmalloc_array() to simplify code
Date: Sat, 16 Aug 2025 17:06:54 +0800
Message-Id: <20250816090659.117699-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816090659.117699-1-rongqianfeng@vivo.com>
References: <20250816090659.117699-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffc51d6-9a50-4c94-d40e-08dddca45d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHI/AealHabMSQEELXu1oSEoCbE+yzbCOGwo+MVRkbRn4tEf53004E1BpeX3?=
 =?us-ascii?Q?UxAQAhkUNq45BwIejmu+ZQSlfPCLIiC7FGNoL7c+2X/kzTMm5jU5J32BMQ36?=
 =?us-ascii?Q?Pp9Pcm0ZXHOieqPp9IFRI/7wfXbcERDtth14yxiWFILthf0vdxVK2pguAm/T?=
 =?us-ascii?Q?J8X/afhtkPaC+drT9Iwe0C2uBiYlbeB0AsWj6m3PJ0xyF2dDtbaW1OGKFHAv?=
 =?us-ascii?Q?JpvS4a8Vx2Ai5nHPRWTmERS4yDWDMwsJ0rYGKW9oM52dYOwt9IdV/oxsoZRa?=
 =?us-ascii?Q?hWt1r506+tCiF8hZLvJgFZKzDilc+cX9b2he96ovCLxC8GB7rZ++EoDBWC1p?=
 =?us-ascii?Q?hwTOR+RtxlihWYWPIkDkeZPvwYCw9FxxDqFGULAv3+v0prRGh+Lf1zCvz9U6?=
 =?us-ascii?Q?OnoTFlGlyuHi+FYQS16hj7vmnat+yPjyi+Q7lPnn32g7FrNOsTT/Q96J1ymI?=
 =?us-ascii?Q?KNdT7SzatoOjTr8nBU9Dza59uh1FHTr82kWIzqbLkDWUjDoQXoiv2+LlF7Pz?=
 =?us-ascii?Q?eZGgYsnkKRFhGPIreBUjK2vBnhmEPU1pwlEvhqienP5El5uR0ep7Z1taL2rq?=
 =?us-ascii?Q?FN5QssMK6w3q1UL6nktomcf80EobeMuQ7d/9zwr5xbwx9rZsC2M8YwSR+LT9?=
 =?us-ascii?Q?eUE31Jdp1f9FDFeeQkGqHY4CRfhHK/OtGGa9pFqslE/sLBVKjjN+1wutfc9W?=
 =?us-ascii?Q?piOH/XTOrn3yKjxBdx4w0zxFKlOSZB8KCwGYkYTFkAqjBGBeS5U4yasVhNlH?=
 =?us-ascii?Q?BfpdpwVYByN6nLLOs7/9lPBsgYMGG0X/3U5AryZq4o5aEZjCExfyx8e1t/z7?=
 =?us-ascii?Q?cgqnsKdrys9aRhh6ILtCfHMlqUY50Yd49Qd8xysVP9zPoA6wM4yRSkAH0NYI?=
 =?us-ascii?Q?15Ml+EHSGghRefv7Qiu1SpEhbnGgdf0C81OzcN3gymAmCeqbkC/bmUfRuWXp?=
 =?us-ascii?Q?Khxk68hDEc9GRc2kI0gmn3zljUekdCT4DpVfIVJy0hjZFEbQBiLNgDIzy8PO?=
 =?us-ascii?Q?P7MLkH4mdQWYYs9pp8+3LtK3RfyD0cNYHZ5cfeMt3wnP3BGc9mGtkCvNgpag?=
 =?us-ascii?Q?y1pyE8Kin0p7JhUYbYxMj8bN+4/bK/NRS7gFX69RGRORJgcWF2v2wi6fhY4L?=
 =?us-ascii?Q?GezvyECdPzPO5CL9tmR6KyQFfKjrYyQayzVUziDF4xd11AYIZjREEeOQnOwh?=
 =?us-ascii?Q?F7iJfsiA266sAF9mLilW6ceEayV1+mTuUg5ywugsu01u1T/oDzk30GX5CkPf?=
 =?us-ascii?Q?ekt1sAQKxCcDeftTV6EPY/93fdJRxJFgpUY3RICV1GAHpUSOfJwXuT1N38+A?=
 =?us-ascii?Q?a9IwL/p2JMPiUMggRK7TvUGelsVDN3m+90kwHpdY72y8Zvza7dcckNOc/A2l?=
 =?us-ascii?Q?X3AYiRwDUh7BLIQ37YeS0RIp1btOue0tZZtZ/gKLUom++yTepjgtJi0ySsBd?=
 =?us-ascii?Q?sqVvjINSUjGauTlOkp72dD0ZleShIbEypWFQBpzfIMOxvJ12HsT+wA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKC9haejncXgQ86O8/ZrYHlcB0bSS1rtC6bKu5Iou+849FO7WbXN/ZnF5T3g?=
 =?us-ascii?Q?E4i5TSdLUtYA8njJX/H9iRPxsi8zHid+KJNvV0ggE+WG7iqS3VcpCXcPxGOT?=
 =?us-ascii?Q?aHMUHh5KKbVJj/oz0JOzBYFIB5Zu2VcxkSZqp+t1Fg8adTIKAl0A9xNpj7yv?=
 =?us-ascii?Q?sQzUTKrl2rReTc1X/dI0f+U/B1cw5ofWX7x1xJz34XHk1mM7du2D8wP7xmKl?=
 =?us-ascii?Q?tAcGBxtDlzTHRAWx1iZkzelYI+P4iJR0SAia+hxIYRxBTDwXBe5Te5WGSHpX?=
 =?us-ascii?Q?UNjnZ0T/WL3puAKWBGHN7gMLoxGrcaJ3oLcVbjZXJg8RIdF2VoPqRqFPig+5?=
 =?us-ascii?Q?octGifZLovUoftgsmbKSU0DotJt+9BzSP3DT5hCV8z2Wl/+7s0CeGgKgGvdJ?=
 =?us-ascii?Q?vxOZOTn4R9+Ctor4FdRRsDRVNGWEUsdZBEjZTgIErJK29mDJKs9JHsXz0SIL?=
 =?us-ascii?Q?Ccm4kpb/ZJoUgkLRBGhNSXCLpNZz8FcMWVaP79vcSHQeH7yDumOHAoFv16WO?=
 =?us-ascii?Q?/cTMuj2NQItcfvWjoX1HIjs/tLEsRNjQPO0Wj0ggaXJRBW485PfcetSFIW/1?=
 =?us-ascii?Q?ABrtGbib8En2Wy0KHAjxrgNYiJ/TnYsa9kiofzYZ4BmfdbkPZ7i1BWHBUVkq?=
 =?us-ascii?Q?Ftg+5Xc1agHQxTc1vyrK03/DXbqQs9LDvAEHqCRCzk7WejF34CDcjdSuH+ff?=
 =?us-ascii?Q?/+S1U1LgEc/MueEUz11Hm1W/XTMcwwNlk7EAWnlyjy9E5p7hQ4sXQAENr/GT?=
 =?us-ascii?Q?DQVARMJfbaULunZfmgXxvpdBQKpbMNMjpJlvYcuLyC8Ept6RlNbCfZwbvMmL?=
 =?us-ascii?Q?V8sWMXFCh7U+ddIuXnEqzhc7WRMwimhqgMqHmLM7vy05nrW9aVDf+hqmtdtc?=
 =?us-ascii?Q?ENW6JX2Gm1FiA9O02n7Dp266qtIBIWO1OKZC6ojMMNAVYFQN2nExbs+ZwICY?=
 =?us-ascii?Q?BI6HKXR3m8TMX9UxZSJqXDBVuoSgyBhvk03ymekvRdFBLoGCxIOMIF7jG0U3?=
 =?us-ascii?Q?g45c1CDFc9Xo3mY2BB7kUVnvY0o/G5RtWo4TbnPJKnYJZAs8qe5tRWX0W/7f?=
 =?us-ascii?Q?8juJZiIIbC9j5svXuTKjH7BHOSvA2F9ZK74F0/Q+Elyjzs1vUYLGBd1yAqOw?=
 =?us-ascii?Q?iyjb9EdhGyktxzqHIzXQdRnhquUFF4pH65bh8fQunZdxhPhMPsm6Asy+kVqo?=
 =?us-ascii?Q?4jC1x5xMUK8ii2uZF4uOluBaJgHIQlhLIygHFEwO2tMW5yWNNIRgdz87sfoq?=
 =?us-ascii?Q?o6+jT5dYTyBvGZkUPLQVa93VMGUdCOiMY3hUMMGTrUILecg0jkzCf25QsI14?=
 =?us-ascii?Q?RBLAf0WUA5eIF3LrNTcii+jjxHhfJ2WUiG6ABAnyntpSMUnAMJMA8CxukcCk?=
 =?us-ascii?Q?I1q/zmqQA5yjObdhq5UKidQmV7gwIjz5fStA5wgs8ruxeMMYRxCG6WtD5kpm?=
 =?us-ascii?Q?3El3h4GZpAsW5ncks8Z8zNmm67GrvicymW9bDVVgN3thwm0wNtPCX1kIFnPf?=
 =?us-ascii?Q?j6exw3nnoBItVm2QZ84NtKttFtAsNqZ4BV0bHnTrH0gIfEfwcrVJGEXiOSAU?=
 =?us-ascii?Q?rbgyZjcskse3DA6x5ax26s02we6VrCBthVMiD1va?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffc51d6-9a50-4c94-d40e-08dddca45d9e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:07:46.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PR24wj8m8QVhHWkfL3wr2EpoJ/Mlp1FqIF57QOJKgEuM5uS5eqb4rRlwHYhqEb2VVfFHnfBFA8Cf7kafT5uZTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5962

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
bsd_alloc().

vmalloc_array() is also optimized better, resulting in less instructions
being used.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ppp/bsd_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/bsd_comp.c b/drivers/net/ppp/bsd_comp.c
index 55954594e157..f385b759d5cf 100644
--- a/drivers/net/ppp/bsd_comp.c
+++ b/drivers/net/ppp/bsd_comp.c
@@ -406,7 +406,7 @@ static void *bsd_alloc (unsigned char *options, int opt_len, int decomp)
  * Allocate space for the dictionary. This may be more than one page in
  * length.
  */
-    db->dict = vmalloc(array_size(hsize, sizeof(struct bsd_dict)));
+    db->dict = vmalloc_array(hsize, sizeof(struct bsd_dict));
     if (!db->dict)
       {
 	bsd_free (db);
@@ -425,7 +425,7 @@ static void *bsd_alloc (unsigned char *options, int opt_len, int decomp)
  */
     else
       {
-        db->lens = vmalloc(array_size(sizeof(db->lens[0]), (maxmaxcode + 1)));
+        db->lens = vmalloc_array(maxmaxcode + 1, sizeof(db->lens[0]));
 	if (!db->lens)
 	  {
 	    bsd_free (db);
-- 
2.34.1


