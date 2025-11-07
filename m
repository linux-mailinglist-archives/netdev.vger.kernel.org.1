Return-Path: <netdev+bounces-236635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C62C3E812
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CCC44E97E7
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5F29BDA0;
	Fri,  7 Nov 2025 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FODtmJ1G"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010010.outbound.protection.outlook.com [52.103.73.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FEF295DAC;
	Fri,  7 Nov 2025 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492896; cv=fail; b=bSy6Z/vyyODFpLyvHEjCliw9Lswyhrj7x9ReuiYowAqG1RksW9+4BgrxvHNy25MtSdzShKbA19YaY+V0qNmboDyTFVHWKJcpYXxWx9nyavIqjDTXAhIa123dU5ODLA0QYUgkJcBaURqi5eAvWx8EQIxK6B8n4PeCk7JqmkdDxSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492896; c=relaxed/simple;
	bh=HC+gZiLfOGnrA3etsTi3XxrRkXaF71sJh/mC99mj8T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdQy5CqbQGk7VcKc1/5mz7v8pxefvp+3/h4J0uasVg2q8Xd0yOKk0NfV5dywLTdjwE28HqsG0/2fYyVIvvQ6tQAmMOV2U3rQQsiH+oLrvoWMhAxZs9MWnDWumyTgGq3jf5OukXyTFgJ2ezmGf+6mhZj1qHN7RJXbmVNn4ZK7e5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FODtmJ1G; arc=fail smtp.client-ip=52.103.73.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKCVg2V6d8LbIJ4YNqWL5mJlLM6XpeDit4s4wz2AX1bk0IVScgVFTbzKIJPQ/yGGCTkQb7APkNV3Gs+QPfIm+mHmrPFH5t5U2CSvAOubjsiuersCgO/06UOoWeDHFvqGkV+VVnMy/9yRVYuPB8eOlYwTz6laDhpb64AoPynY7G0pFW67XNnDnLrAoqqRipm77G4QZcuqMY/+jd0/hDJ53mpWcNpR4yOpe9tAw4fOgGcbKE8la+EXNeWXk4dNu029kEJQcPeY12qaAQCI+QOEd4FrqTht5uREcOLTTA8yWzAEUf0PtXJd+/lYl56TxXyYUHcvywNTFGGfOKViuHXRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpgoUGgYpOXlAIBrIMb7hEZIqU4z/Cwv1gzbMzb9oWg=;
 b=qjgo7Gpr35zEPEU5CGxBTC0emcRSQR+TvGab9oNhWgDdImS4HVE67DIouTiA/Bg9PDuqwDaalvdMTN2ET3DGwWMZdJ+O8fbFWSpDUPQFUfxmB4VCcfnwSfkFmlnm5BhvSMuhR+bufXCaYg5walC0czTzfkRy11fWdLQGXzyscM0Z86kbKWTO1TJ0qIPs5ncrvI2uJoUbzBKFug/z1Jk0HN5xx3kKrR8EGDkV9APOsspZpkrYzGAlig++iuMUWEHCAqSS+sXWTp7xPERDsy02a4+XrELTfkKJqrd/GThfNCHGm6qZs4pMVEnPBk+XCp9cQ/RnlQtebfeBXyfsMPuOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpgoUGgYpOXlAIBrIMb7hEZIqU4z/Cwv1gzbMzb9oWg=;
 b=FODtmJ1GRdwDQ3nPaatDF7B5O/pEQgX/6vqcHxBn6zhyf4jFk6sd5DPrH8jECRcBlUFjA6XxYsbvIqkHQD4iUlopgZPOGChnN05ngq+LsW4lm5JbOAl5l8nqGfGUUPThE9TNbR/vHRlWTRa3Ddg4esk+gWFjUdwMhJVCuugFGmqBZOznm0lvEgnJ57yr7Rh12fOTbGcgAm8rxGr0wIJhPDjTiDlLRb6VDNG3DzATrZxPRkmF8exrjkP4Wx3yYeIJKihCFKftp+gx7Ckrqzck+nVuT0yTdaTi+ykipcp6gS4mD3Ct0xLrekHb1q38XIwv2k6T5GoSJJ2vcanRJJwUpA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME0PR01MB9633.ausprd01.prod.outlook.com (2603:10c6:220:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:21:28 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:21:27 +0000
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
Subject: [PATCH 4/4] net: qede: use scnprintf_append for version string
Date: Fri,  7 Nov 2025 13:16:16 +0800
Message-ID:
 <SYBPR01MB7881FF6A051A192E02112C94AFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251107051616.21606-1-moonafterrain@outlook.com>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251107051616.21606-5-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME0PR01MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e294c2-7869-4802-8078-08de1dbd8093
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12Dc43FlQvP2yewYSt45NTkBZDYljTvSk5EAj6TkReLMFQnZQsHvPWCy4pWULrI8/vjKSigHYbrtAH8wug9uDtyot41pGihpvoM5bAFmrob8wlF89+kzmPJBc/2DIWJQlMRzrMRhZgUVndM+/Bc3dyoQe4JB7Y8K6U+J0ZlD7Iki2VDMBP1Cq4Bka0BRWHYFwcSVN5vP9JVXvnjAY9N/Sp7QafxYikWHTmZqlHl3e7AbKXKZZOpltK3gBdUyZzLjdfJxuqoTdDMpGbHgXPUDSmily8z7zWaOli4CJ0tMgKAVVOfnTpPInTaXw6OK6hC8ba3uvTIAzqONsJcQutZEbu3qE/AnoVx5BwrIfw48jkIV+mnpfL1ku9VsPjvXespLPYj5PElMXprB8Yhh8C1bP7PYf9j3/MXxUgM7JQj5/cPgJdGVNNIgBUQcrkX13suzcU3QGvjMJs8KzlCvalyh/xqxTA6xvjxRE+ijxvwxnnwq9Ig+qAVYsiWc9owNNiiTW6u9P+u4WmNVjsodoqpPtU2cnYjozuM3UCsXwsbOiZpYQD/Ebj0BDh+SYGx+jqE3G2aAdAlXgxJ/JLd52FJ1iIpH843G32Hbg8gr3zXsaO2cybdMWPLiWM2WBfzTdMi0Jnki3h7LDKaVn/NXXQ7df21HleYtw4Sr56nGOr9zIZyK87VY4c5V8KOZad6RGTwHfYh7ZO/668s7V0vuQDg4OJaZvN3ocR1WvJlwSPaRHyClw/46jmJWlXsLo
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|8060799015|23021999003|15080799012|19110799012|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wyZ5r/Y7Su5XY6Tah/h9xg/Z953zMbDYPUSeY8szUYLJPTk3N+pepz2twZKo?=
 =?us-ascii?Q?rh0WU/H+XUxe6/8FHMt2dPMk9660qOFamgV20R2TDMcDc0g2lBxP6StRruo8?=
 =?us-ascii?Q?L1vzXA61YjqbDNrlRA06GywEZCTIf/c4Z2DLolqOHWVn/aUilRk8oG3WIf55?=
 =?us-ascii?Q?Eowj7kD6n0gW/Nna6uvkiilX6vHb+LXeLq0z+dUKmrp0Q4aqHAPs3QLkIkyI?=
 =?us-ascii?Q?zav6hkfaO+dpAHqTCAM8bqo05gx7cDAFP9RiFgcwu/ITNiLHq+c6758kYMn9?=
 =?us-ascii?Q?W4cOWLd2seLMNHpuRkRn5sZd+aaVmAW9tGRvd4hXoVfYOTDQHIbtvI6HdWXl?=
 =?us-ascii?Q?PrDkEuSsKAwh+zuvL67xl9HE7/wn2eVhYpwI3FloEnVds9eB38DIOrb31wqz?=
 =?us-ascii?Q?LqOrGtJhvB4Pm8zowHjdPlQEgmh4nSCmCJASywOuGYLU/U4sEKjqu/k2lDc7?=
 =?us-ascii?Q?Dzk/PJv+DhjP4XRtkylKLuX+BvOaaQmHBIun4aIk+549bAmXLWyPDioomN2y?=
 =?us-ascii?Q?jpekpV6yBpjL3MROJ0GNyOQcSCDS3wiMuzadeabnTfVXGojRtCVVmY+k4yfZ?=
 =?us-ascii?Q?PfM1sjRz5YOMTP7tvJCIl2wjehj4dmTYrDQ0pVTGmt1WzyKdUNl3I95UKJLW?=
 =?us-ascii?Q?15aO1C7CpTfOIhkVmaxppKOlUad9CHskIi8XONCNPqV9me4ZBfroVvo6sraT?=
 =?us-ascii?Q?qXpz80EbyHVSrXOKnBdl4drTkPO08vJbNlbDQebq1b0vqytjv/4jCqLpM3Ue?=
 =?us-ascii?Q?PIA3z8sV0Ldt2Ek8hl3XKjH+9jEAfVyMsFP3VgTK/qI/mLbLR3+O8NLvGtYw?=
 =?us-ascii?Q?jSlmYaM9ZR7u/9oGMuEyv9WBlFHUFKcuudwMsDVBuqL68KVv7mZaRwAalmG2?=
 =?us-ascii?Q?v4T8L9cU8N1AUy4vbxP+bZXH7GKuC7R15Rn8OoE//QFvz0VIlA8ht2Pi8Pva?=
 =?us-ascii?Q?zI7X4zEHO0sKWA6kErM9z7AmPwUIHy+CH0mIyCkOTuCJ4+DAVPxNxH7ShcmJ?=
 =?us-ascii?Q?thaZ0xKjlmOP59paaw6DekMXS3F2aAhJRgf2u63oTc2VcNHm5LShAyEvW6om?=
 =?us-ascii?Q?wW50TjZS48UP5nbAH0oFdqvH/5whHIzhnWru5PQcWC1DC6hUphGvXGqmkFY3?=
 =?us-ascii?Q?kkllGyZlW+sw3pYbsJJbMKzpcAETq/qoIqH5LwXyMYZZspLKmc2B5TiwQx6l?=
 =?us-ascii?Q?jJ1lGk01P70/DVTeNsBomoJwdOXv48sL1Ncnfg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c4xIS8xh2oM02L4YQ2uCBif4IIvXC0HtAu7Hlp9hvziLKLABy1FhzGY8rxt7?=
 =?us-ascii?Q?99urjjTlfyuEj2kO5aMVOyznIad3+E1AWYjBkLKHTNsUjyJzv98Fu8E4MYyR?=
 =?us-ascii?Q?+SJ3/Mr8+k9kecC4Pn1zG0VrLk7iFlN63flyFKeStPRKL6hq6rep6CiAFW9U?=
 =?us-ascii?Q?5+1KznjsCEOrDM7rT0Ugy/+qZKSSawXxpJjT/9i34Uj1PZ2bIVFOOqwGLano?=
 =?us-ascii?Q?YAFiWUjS+kIItF2wXrsdRyeOdtIJg53XCQlIZzRIMKZ/6V5lPtMxXA/gWecN?=
 =?us-ascii?Q?cMQKNtniDZT1Q4Bzf8cVw42DKfc+9QChDGQuAt0qadtGOT18e0VyviOlj/3r?=
 =?us-ascii?Q?fCaCbdNMHUAPOF0aUDvz+xB0cPMN0rln9EFj0dvepx5NSwMKF4moLVnI+eTm?=
 =?us-ascii?Q?WFv+izbN45DQIdK4jF1y1774yN+o6wFENS38P+Q/+llB+5gQUHlAIKU+CuwB?=
 =?us-ascii?Q?b3WVwtIspKo/TykHdP6fbu+G+mfNg/4EPQumug6BIX34WLC48FIoOkn8FspH?=
 =?us-ascii?Q?6KZvjsQ0BkP6T4ZUEadtFw6bBhHBYTagabiyjaZKfW3bJcfqCdQskRMqBczX?=
 =?us-ascii?Q?ib0G/6PlB9rr0zr0MdSc8wFvnLR80XtRqj/y4GfJXmEAvng7i2gw+0Dy62mM?=
 =?us-ascii?Q?uDiGZohGb1iKeZYO+aIhmU5p+t/4x6GlQal7/PIvuvkXIyxnECCk9bH3cvde?=
 =?us-ascii?Q?jxywVlKdn2kArfqKirKNvDKF1snepEVlIHZDwQV9EssR8puWivcJDVr1k8k+?=
 =?us-ascii?Q?CivK3HiVnfSXU8/4QlPCSFgCbyI1rCYrUvK335G7nrMsYtkQw31otl48f6T3?=
 =?us-ascii?Q?Xas2tHVuv6Y58qsIXsjKbdgJuWspVFsSTdx0nwY37ym6uBAVQUvqImEo1Bli?=
 =?us-ascii?Q?WLhgXH+gScjZjMCloYmNkqqezz1nFDPVM7uiGVnqRtURhnjryyPQGfAS4A75?=
 =?us-ascii?Q?NNBUjnuw7L0yrkRepOV9Zcl0+hxejkSDlcnSWIbZLvnGBbd6Uprbzh4ku/ww?=
 =?us-ascii?Q?TriV5EDoC/5260zouE9S1qIOaRTR3Kn7YEVFl+TrYwO435dS7Jxs2snM5oTu?=
 =?us-ascii?Q?khXCChlg66W07WGleaCyy+C4GMlqJ3DshOgNzNQ+Duc2KNbSRZvXUBAOqnNz?=
 =?us-ascii?Q?bwtQtzc0eUo5xY6TQO/1xiGJzUR9YacadpRcemkWVJswgO9ljWVGGv4aHFKs?=
 =?us-ascii?Q?XtmHrayjxAyH/O3UKC7mOYTe6qnYfbXV1HYEsHduQ6lkt94fCSK02yQafPHs?=
 =?us-ascii?Q?KSrzCm6VSgkvBvxOYrcA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e294c2-7869-4802-8078-08de1dbd8093
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:21:27.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0PR01MB9633

Replace snprintf(buf + strlen(buf), left_size, ...) with
scnprintf_append() for building the firmware version string. This
simplifies the code.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/qlogic/qede/qede_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index b5d744d2586f..6e85c3a4aaa9 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1185,7 +1185,6 @@ static void qede_log_probe(struct qede_dev *edev)
 {
 	struct qed_dev_info *p_dev_info = &edev->dev_info.common;
 	u8 buf[QEDE_FW_VER_STR_SIZE];
-	size_t left_size;
 
 	snprintf(buf, QEDE_FW_VER_STR_SIZE,
 		 "Storm FW %d.%d.%d.%d, Management FW %d.%d.%d.%d",
@@ -1200,10 +1199,8 @@ static void qede_log_probe(struct qede_dev *edev)
 		 (p_dev_info->mfw_rev & QED_MFW_VERSION_0_MASK) >>
 		 QED_MFW_VERSION_0_OFFSET);
 
-	left_size = QEDE_FW_VER_STR_SIZE - strlen(buf);
-	if (p_dev_info->mbi_version && left_size)
-		snprintf(buf + strlen(buf), left_size,
-			 " [MBI %d.%d.%d]",
+	if (p_dev_info->mbi_version)
+		scnprintf_append(buf, QEDE_FW_VER_STR_SIZE, " [MBI %d.%d.%d]",
 			 (p_dev_info->mbi_version & QED_MBI_VERSION_2_MASK) >>
 			 QED_MBI_VERSION_2_OFFSET,
 			 (p_dev_info->mbi_version & QED_MBI_VERSION_1_MASK) >>
-- 
2.51.1.dirty


