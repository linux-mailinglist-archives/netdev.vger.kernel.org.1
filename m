Return-Path: <netdev+bounces-236631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCE0C3E7EE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7F0188B20A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF6293B5F;
	Fri,  7 Nov 2025 05:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GqOnK1KR"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010005.outbound.protection.outlook.com [52.103.73.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6028288522;
	Fri,  7 Nov 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492607; cv=fail; b=YiZATW/8fE++bY9NU/4GoLH5GgSPkKq/wM8LOYXNlvlqob1547MYmfL2ZoZRH1GH21IN4DnOboxkvC72+2SlHKZth8Q48ILSS1AiJJKciNiIDbANYGT3pQJMDUP5Hc+XlQ4TCb4b/yLFRalbxQmyhzO1FByFoh9eZwOfn3wKTgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492607; c=relaxed/simple;
	bh=ud43NnE3PTlcgt4KTiGxdzZSHjfPG0bBUsTf5Ah4HSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVS61TJPlhWZiLUNzYhekEDS3scZIs8o6stDZ9Zt69pKhmDa0dLL+GsKZhqJGoeeFhUrHwAs2Ld5zTDfg2ap6OdgPS4WRvP4AU8M9qcv2fV4HgzthALGhstI7z5JbOvuGE3OZyPDowoMJ2DtGfXuCHLetD4vTX+KUjf687WL0lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GqOnK1KR; arc=fail smtp.client-ip=52.103.73.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkkJX2sqfVoti/MRuN/Jks7eU0EYjltfGQ48OXNUKqok5M7GWHzY9s/3lWGYCR1Hc6ztLZ0QlCKS8rYQcYgqTkE3IPENshXVf1KSgW0Lo6d/TsbkkRRVF1IN/TWUNqok+7+HY4MhPFeyK2lrP+7iJyxgmaNv3RBnz+Ux+oihWmbxUOys+7wHd/c74fIc4iW/bd9Cp5/TJW9A8B9nlZOky0PktYoqynIzxjqLIVBrKM7ihcqV63m68Y9pUm//n3toyJXJgoRFCPFdLr2BQt/l8Pz5W8fA7oSD5uAMjc0pCEuSwChsolzXu7JVrGb4nWx+k1q/JU1id8xHN+i67x+NhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Ap5TtcjgvulmB6QhBzKWipmNNSaMrq+7cX4Bi6q0s=;
 b=XJ6kLhwy/W9lZNaMHEjGXoW0BBZZ8ppyLFAKiiU0Ctl/R3mYI42QOiokAYylZROUWfQGzKF0WZGdgyvGZzEkHun8Es78H2vhYXzjQwjmFssNnFkmq5bvEVM2jUurCwG9eQn5qnqB6A402ay3IzgyTY6hDsV6NY1u4myQHhiAgUsOrzEJwgH4sAJtuAfwdDqPG5UsKJPlWDU8eL+PFFqmLIwMemFKkmUZ9I36mNf+dz6cv8tHh0yL3SR4a1MC4DxFJ7KdgcHgcEbfYZg149i+vUfFJUxJzP9iB5hVs3PbwdQJaLlEfsonUshoIrvn33CqSFc0sOS+3xmHigeye6Sv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5Ap5TtcjgvulmB6QhBzKWipmNNSaMrq+7cX4Bi6q0s=;
 b=GqOnK1KR40ahE6kikx6lijPXFGWa65cizpFxbUBvPHFtNHoaJQhIDI3CV/vvov9tAByCJS31deTDDfZLXL3vDT3L0M8tYn9P9ag3fjJ82iXkfz7zl076mHg83sydnXYa4VdRxc03AJsJTGG3K13D1V0WHV0/CuZAXtpomSSMVB5YKn4J7oFbl/b5JI4ko8hGR89usEJQehOvbZ3Fv1QIhHJAaxHiNDlZqSQxIhtrJ2+2t1eobDkTKCoGnXkbwcxD55x63vL1cbumoMW/8CZDwxCPvdJtDk20TpEaTtqfCWhA0zs7b4DSXVPLOHntdwWWV0cUNcfpXOpBnoRDS5cvkw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6715.ausprd01.prod.outlook.com (2603:10c6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:16:40 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:16:40 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: linux-kernel@vger.kernel.org
Cc: pmladek@suse.com,
	rostedt@goodmis.org,
	andriy.shevchenko@linux.intel.com,
	akpm@linux-foundation.org,
	tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	mchehab@kernel.org,
	awalls@md.metrocast.net,
	linux-media@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Date: Fri,  7 Nov 2025 13:16:13 +0800
Message-ID:
 <SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107051616.21606-1-moonafterrain@outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:a03:100::45) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251107051616.21606-2-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c056d5e-9171-478f-e9b3-08de1dbcd522
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12Dc43FlQvP2yewYSt45NTkBZhihx0RKuivZ1ojceRBfEad32Lbbo45F33AiIfrAXoWOesMp9faaWtSTOT9gSQUcvnAJ2+oBtLdyMDnLDZThC2J46nO8W5uI6nkC1UjClIFKVr7Oi1AXYJaLZ1FwwfFtvABjwL5L5KKBBq61YRa7HOge5EY/wufElxcLPNRz0gpQ6Zyuft2ftortW+GdNQp52bP55WdNb+q1tdHjCngLugDx7rd0IbVbtt7vY5d/sOz7Vb4RBOfl65LRAEOKZRTchmFsdXSQ3sn8iy3hVw9skkxXqTUlH1B1h9I9cqmLbiK8z1T4mYm0s4cOIS0GYRLAQ5oBZb7hbuqB05E3lQEnN0qZYmdtbDm8mHRkbdgKj5/VToSsmgptM6qilCFo0k0JAcdHGKteKltsyEMwcjD738cxwUiyJL7JbVr5eqWfS8ZKOKeRu5XW7MAMFlzOBykUoR4E1Bwxi68oK/IJZqjKV28tdkQf1gAl5kt6pRfAJyQc6ZFNJDWQsqofYF5yd3LPntEgkazGhT5MYUXJOVYmdv7KM0VLjETEtuqWtQbE0IknxtPdiVHwu3zh7qUHie9EIS7/ys9/4Zr+Ovl2XLR5BHSfkZ2r5Frc4bTKTWrwrnKnIdUoL5sg40VPDtbXP2OmLuyqVAlQKh9tlNm28wk9cO5v7xFE9ARFLgL1fNQwKPNlw/wwYgwKU++Wcp51G/bQqJc67bHob+x64rkaolRsDGpfnwPRggnmM
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|51005399006|41001999006|19110799012|461199028|8060799015|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wjxUHkDSuKY2ycEq0lk1kmPDVaW1AMVFXVVwiRIT0Jah6a9FyQtNz4PNceQ?=
 =?us-ascii?Q?X2URz78SyqelR2pvieIB5/M7oVjp5+BwSKCtGeFz5dwSL/jEPbVy8IyOwwZZ?=
 =?us-ascii?Q?fnh9qCTUQjeWRa+pjqNV3JeV/Ip3Fd2/AlhDY6X8Dz4rUKJQFKpqiOga3Zn2?=
 =?us-ascii?Q?1rzE2ms8QGM1QhaIB/foe6ibGyrEnGeP9wwb7P8NvBzTrPHshuhv7mGn7Uzf?=
 =?us-ascii?Q?41YiEw/Kge+X9dJmh1xMtDenLOcqv9zk1rvs3a9a//19VUuwSIrJVXCEPV/9?=
 =?us-ascii?Q?uF+S96P3aaCmYMYMW/tFLyLgG1NaV+Jp/HB3EyN6vHM0ZntwT+Fa2Njj0QC0?=
 =?us-ascii?Q?kjIGVR4CuW+/LlEfN/+XNC2fqBMxFzeJe/OVnlJ+KWWRHK+7G97BJNZub9bq?=
 =?us-ascii?Q?vsuTQsN9ttmwNAFz2edIREnUkl+LwZq2WYqh2dys2EUUo7IfwEZYh6gF8+/C?=
 =?us-ascii?Q?kAvM7TLVvBtxkox60Z4fERXBgLDRZvZW/oOyyQtaWwjbIKu+o2WAkObvaeCe?=
 =?us-ascii?Q?mlFN3kTuGY1dUr1q0pM54s1SLu5kpL/29B/UMRRi2N8T9BBnz7D6LrMP8DCm?=
 =?us-ascii?Q?9e/o6cGIqoBuJV6JZprW7eSwZs1PxGrIPb3s9IDIZ59om1NYSatvMrddJXen?=
 =?us-ascii?Q?GtbW+Hrg1vdBoDFWUQucbZKvhBzrdn0eezcuLWrFkDujpU29ikkMgVZLe2dS?=
 =?us-ascii?Q?E8CZ5k71AS84nOPZt1U4S1zaEgthAy2XSRjnn6pZBnQ6D85vokx+/SiQbZND?=
 =?us-ascii?Q?c90i6QFKSdaOcUrq23FOBbKvDsx369AALoTGxZZvnvLCH2wpZvQf1Oz6nxXc?=
 =?us-ascii?Q?c7A9RgOXmNpOgKQaMEIvkUiwGam5eDXSalLk3XU1DSc91gGAR3i4bQgT6z3l?=
 =?us-ascii?Q?yC3VYJoa+ChjMO8yUyaTOvk6iXtESF4zI1/YPwg1/3tztV4aJb1TxWtGNHQI?=
 =?us-ascii?Q?X8SKyjveBlmdZFsLc8mA02Oqne3Wi8i5DmlEfVFvDDh6GbpM9wxlGilO6mG0?=
 =?us-ascii?Q?OmS50OYGXmT4A+SCCUSNrl0E0LUos2hkb8S+TtMT+u5ZpMcP5I8NdUxnXeh0?=
 =?us-ascii?Q?+kHACFKg/Cm0zKLr0wf/+u5dVC7dUKek0KIAvro8Owm+NtacvWqwuxJrluC7?=
 =?us-ascii?Q?G1s8YceqMityOpPDlS177Q5QMEdeG/ufdjUxtwMLVOfovJK0IL7FTHyEMslt?=
 =?us-ascii?Q?AE2X25LXtIDQFiQB/orbnT/N5/VPe5KojlWkmGU/ZW44Eb5tAOiPOyt+PY0?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3byRkAgdw/vYWyp0zxLw4Dpd+dbpaM2i7NgJYhZ9+8BjxbmBwrbF5vWUNsS?=
 =?us-ascii?Q?wx0pzhRQA2LRUkIb1NbgB3rMky2GreSxTijBdXjeDbfuRjyucml+CGm5BD5a?=
 =?us-ascii?Q?G+hlDg9qpB6kOysonRjp2Yq+75q3h2GZ5WQKrWeXtxbLjP4U1GeqXII6tDaU?=
 =?us-ascii?Q?RvXe/8ylaavIX8J3SHm++bRAM7FxPyb2aUJGakI74OHUwcWaJ0EXYuMQhOyU?=
 =?us-ascii?Q?MrFAh6lSygXiTNIVvO0DNgyQHRljeEHu43p6weaRn8DLpSb8IeZgq7WIzrt1?=
 =?us-ascii?Q?3Cmxlbq3q5WJ2xfrOn08tJ64S4UqaIOpV9XVEzkFKdBJWwvhrK7Cu+tfJa/6?=
 =?us-ascii?Q?qDO+okWImd6xwGM5uSN89w9I2iZtYwUUb7zvCvJToktz/vqoByFsc5zRw2jk?=
 =?us-ascii?Q?+d/TIuPbabyEPFh7FEnjKvBF4gJYvzfATpJeqsKifXGvlnyu5wKyeJifCv/6?=
 =?us-ascii?Q?DUsSOAFRlEZlsVOobe7wkjSR1K/H9Z+klzBp7q4M6h8BdQ74G2tmfKU3O2sN?=
 =?us-ascii?Q?BD0NAbZ1/ECUE14SjjqBgX9mdVDS/pW/BZVZ2pPptZH2Bn8oKRlFs5/yaqOj?=
 =?us-ascii?Q?NWdk+PC+UqY6dUusfoBSEWxyorGn2PSe7RHudrXoXeDIl0vmJTNmywCN4JTq?=
 =?us-ascii?Q?vVgkKKRxIrfuHCEv0QpqRE/k5S0j18HcWphuP2urvmw4Ulm+0ho2lA6Wuzry?=
 =?us-ascii?Q?5qA+V3xJyothmoqsDxXj/o9mDDsMMLkI2irTsLCQAhVdDK+RdsBNuEsBbgJt?=
 =?us-ascii?Q?GWE+wdicsPpnrDl1erE0XTMJ49cYZrjgaDcjJh8pUF2X58cgNeHeuhiZmxky?=
 =?us-ascii?Q?tUPhwmXMNo3ch5YHFfWHNIIAp1uVybDOHJ224HKnueidY8h0+ly+hF1ThXTy?=
 =?us-ascii?Q?RQ3FJ8Heq+o8sZ/pW4H9s7dqSZgnSKBGWJq0YB6PSYL3pHkjFujkL1W9Y58x?=
 =?us-ascii?Q?flJj9Pd/J07SpkxqP7s9v+Xs6EzISeJRB6TWfyUlb+WoefxdYva5GyzgT07o?=
 =?us-ascii?Q?C6gBRVbo/jISkZ1cRqKMwQz7Yv50AdXCjHg71X+lDLkx0BCFMW01X0UDrdei?=
 =?us-ascii?Q?RlEK4IMd9PI18YfyTz/Ag16mmF6w0hCHPLbmDuJw5kkV3HaGkKBKDJQWtJCR?=
 =?us-ascii?Q?TXNeFdGoGQcXsO60CDo3PNZkQaWlX8P31DqYY4GYwvSieIbtHje55UjQMaq2?=
 =?us-ascii?Q?zI66YpSuNxwvb0hYRUr/TSlMnxHceIfzwHlt2siMGDeuh132masVhUfQSiQb?=
 =?us-ascii?Q?DBxyNzYQmuClzhmT6eSV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c056d5e-9171-478f-e9b3-08de1dbcd522
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:16:40.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6715

Add a new scnprintf_append() helper function that appends formatted
strings to an existing buffer.

The function safely handles buffer bounds and returns the total length
of the string, making it suitable for chaining multiple append operations.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 include/linux/sprintf.h |  1 +
 lib/vsprintf.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index f06f7b785091..3906e17fefec 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -14,6 +14,7 @@ __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vsnprintf(char *buf, size_t size, const char *fmt, va_list args);
 __printf(3, 4) int scnprintf(char *buf, size_t size, const char *fmt, ...);
 __printf(3, 0) int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+__printf(3, 4) int scnprintf_append(char *buf, size_t size, const char *fmt, ...);
 __printf(2, 3) __malloc char *kasprintf(gfp_t gfp, const char *fmt, ...);
 __printf(2, 0) __malloc char *kvasprintf(gfp_t gfp, const char *fmt, va_list args);
 __printf(2, 0) const char *kvasprintf_const(gfp_t gfp, const char *fmt, va_list args);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index eb0cb11d0d12..f9540de300cd 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3048,6 +3048,34 @@ int scnprintf(char *buf, size_t size, const char *fmt, ...)
 }
 EXPORT_SYMBOL(scnprintf);
 
+/**
+ * scnprintf_append - Append a formatted string to a buffer
+ * @buf: The buffer to append to (must be null-terminated)
+ * @size: The size of the buffer
+ * @fmt: Format string
+ * @...: Arguments for the format string
+ *
+ * This function appends a formatted string to an existing null-terminated
+ * buffer. It is safe to use in a chain of calls, as it returns the total
+ * length of the string.
+ *
+ * Returns: The total length of the string in @buf
+ */
+int scnprintf_append(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	size_t len;
+
+	len = strnlen(buf, size);
+	if (len >= size)
+		return len;
+	va_start(args, fmt);
+	len += vscnprintf(buf + len, size - len, fmt, args);
+	va_end(args);
+	return len;
+}
+EXPORT_SYMBOL(scnprintf_append);
+
 /**
  * vsprintf - Format a string and place it in a buffer
  * @buf: The buffer to place the result into
-- 
2.51.1.dirty


