Return-Path: <netdev+bounces-129676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC9985771
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 12:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483D8B23273
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 10:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECFE15F330;
	Wed, 25 Sep 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CZlFWW9c"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969E15C158;
	Wed, 25 Sep 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261849; cv=fail; b=jBPgRcM+KSsBlGJsPP3ssr3/+3+atx3OTTqpumWnhHru9W7070BfGGAP0DJN8kOyfA2ivcFCTZMLsAfNCL+TjrZFHZXRzyfAPh4IRiPFq1K1JCqqJKK8jY+f9egb90zmEXzk1JIp9ipcxMj+UbK3PK1azQA7LiQGD9X3StzJX5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261849; c=relaxed/simple;
	bh=IJ84u6xNFKZiOvNHOeFjQQhAMWfuhQHvGLhBQsxHO8s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D+Y369RAOMSRkQNOpmjRDrCXHkEHjcw7nEPu9rQmNbu/BtHaRbcO1dnSVSdaOSjCelbIxtvGG+doghj5uNpOOuEKZWerv3wVeB5kjBskNs8u3+4tPiY3EagQjxDPx3TS/ZkbX7Kby6xlRzEa10SBvwb4HhqeIrokzGZ6GENRNKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CZlFWW9c; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiHmqMdCtR7faUHuaC+Njk7CdjOnylk6vuz/Cv7X1XJtNN6A5bAwUqw99+3zZ2Ti8wCB0CQKw1DN/ubZ9RuN+pXZb4siATmrRrcFu9J/cGHSCYaZbVBHN/f94QrEczB4cbIrnhHcI1fWecdMm4aqlWZEV6bJOkR9YrvMTKtz15tswewXTuQeX4sNemHOMVm/0QZfUSxpWr6AStA82XYgVHYa9o4Wvfi+Aqcb5B43SNZXQ6JZd6dRJkDGR1GxK58zbvQoEbS4kwPlasbyQwxy+R96pxm1fkacE2C1uA7rIN4g51RrEEeQtiADXFSwUgyPDwTfdfXO2sxl3aVkd61mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ93D4gSsYZ7FybN+rOQpx+5LqEsFiK+yNeN9eqht14=;
 b=dG9mKvsJyIx2shG1em2YjVu7a1LYWtbq2OVthUXqQPgCvPLqodRys+GZVkuUFmShgcEckbDr1jCr6tqCT/OUrp5NC9jtf+Nwu+YXg8PfWdR9Giu3JyTm/VK4SQvI8zx0SDG5QI74VoTxmPJQ8u+foV3lZzEUdKAf9WivA1r3G4euoqaOskjX6s4k1mo8WRSVHSnbH7z4pVt9CSE0tcr6rLVhkdxASQSPyyjCW5JPpA2YchUKzL5blQ08dOgMF3fJKvTVDq3OOElgmb+kVeD+qQWkPdDkFjqianFaRvlUBxZInF53kvt0Stv5xY5afOZ3HKtH31niimQ7XC1Sx7kyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ93D4gSsYZ7FybN+rOQpx+5LqEsFiK+yNeN9eqht14=;
 b=CZlFWW9c5K/dqbF7B2tdkJT++J9512Bfd5dDLovCURgcU3ASFNB+8Yubpnly+4KQ42R+6i4Ut5BpNjp80pYAQ41R3Dvfwk1nIQ1jVdIbIFRIKyjBrn0n+7B46hZupYjlfaM6ZNRwojZOYtsuQ5OFvXvuLfgayzsdqgAe7zLkedg/HUb9OYlg9Q9zSVP3IcDjsBN3L5dCrguvCaxsb1I0cv/YpBxoJagT6nQVdWUTPStwnodnK5CgZ7iwEzwi1Ot2HThkHDmuvI776czUmlUmLrpCR5jBx9+Rim5TprWcI8YmvloUEIpVy2FOJBfecSfg0N0kUj5rE5c552hnFJOyww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TYSPR06MB6900.apcprd06.prod.outlook.com (2603:1096:400:46e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 10:57:21 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 10:57:21 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: 3chas3@gmail.com
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] atm: Fix typo in the comment
Date: Wed, 25 Sep 2024 18:57:07 +0800
Message-Id: <20240925105707.3313674-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TYSPR06MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 349575d6-df12-4f3e-65ee-08dcdd50d3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1Ma0bzOh0AbrwsEl41/MpGMxbWynkZCkq0Elb6gkynLZDUEjIT3OKBzkdUb?=
 =?us-ascii?Q?ND/Sp72JfqZMgVf/lVk1Q9l39RlhqRNNo+i8KNYLet1ecbk7kZgrCzDAjI7f?=
 =?us-ascii?Q?+gQDJPoxmkqTbjS3duxuB133aaerR3vXeXP0dc8h9TRYs2uOfGBeRwurKXDp?=
 =?us-ascii?Q?2AG5+eFoKxL7GtaOP3S8o6xfUFLTIhncBw7n7z7XcaFLzfQ2f2D2KEoAyYUZ?=
 =?us-ascii?Q?uiw413z4nfnLJzxHgKFNOe0x1qcqh9nMT3WGbZEHmPM9D1u1ssnbIocB4wlL?=
 =?us-ascii?Q?73n0ZZtevMeNDGOykKQUtosiBvJCX53j/KC0cj7IgWcoFLo8znOgLgbtvtm9?=
 =?us-ascii?Q?AlRnc/NEIasiooiZm2fQbrLBi9piMIAFsXaT7ZJjaS8AvAdHjW1eKCA5l84P?=
 =?us-ascii?Q?R5MDgul/LpcCodRZRGmr3aYd3nCY0rDRnVsGzWyhYScbfLImQr2uI2dG9iSe?=
 =?us-ascii?Q?R8zUgR7MjlxMqHYSLIYp7uw6hGaXPXKNNT9FpExKNesh6MXzLcNjYHMYVhDC?=
 =?us-ascii?Q?5QWfaO0YB0F8EKq0o9FpkzzCnyjpHjH0OzuB6JhdJO1I2EUhxE0YeNvTt82T?=
 =?us-ascii?Q?opeP4vOVAdPflnySt5NQgCyYEi1PpcjJearT1X2c+ONHQkH8sOJRG6lD+aZI?=
 =?us-ascii?Q?YQAN/HXnJQQFQ+Bjcx0qXLqfnmyESilrkYm9Vj+Lu0xPlUta3rwFoxlrlZcE?=
 =?us-ascii?Q?Ph+avltgmWmzmGIpKR0PsNrkIX21tTR8aN92x/mjtCBx1zmlv5t2T4BnMO4c?=
 =?us-ascii?Q?hNyyc+GkF8x0hNnJcMUu8niT//MrlrG1f6rRwMgQxTehfBNLD0+olVQzhYcR?=
 =?us-ascii?Q?0LPzxwlUbmmqhHeGZklwWm5qOYArs6XpDPoPJL/6DRXSxMam90kdsQdEqzid?=
 =?us-ascii?Q?9I3jMnILCa+hDgYyEGTneWZG5NHSf5hanxuR7P3x0RBCKcldUf8VUFnGwZwm?=
 =?us-ascii?Q?ios9BHK6rKHTJx1a66xC2d5ukPZJc2RFFASUYLr2uC/YTOJwdURHUf1LKJmN?=
 =?us-ascii?Q?+vs+MuOFdZgNMYWBgy3+9Guo0bW0HXb4iLCzRNSLhbKj13TOdi9TXNCvm9uF?=
 =?us-ascii?Q?5cWevP4eaW3gI5UxISxj2jD3NX58AD6AfzX0e1WOfW0NUBePPiX3ZL3BQEST?=
 =?us-ascii?Q?joqjENcat9LoJS33B490pJEu3pgnR3xuNAu8oAwfR2pGW0Ggi6/bytzJrSC1?=
 =?us-ascii?Q?Ilj28GVwi66uKoomm7qfj+zVLD/9WYLsGoE8innSltrRT7qKLNZgAacUc6Hk?=
 =?us-ascii?Q?bU1VvSgs2S/Xeul2MjyQlruqaTgc/Db4sCuTmLdzGFW+BS3mXRapUbbR7A4L?=
 =?us-ascii?Q?0pMybOfC/wKDFFysDSzMpIX9g2CD0i2zrjclpmBfcZlEEiL8HZGkSfq/zBTr?=
 =?us-ascii?Q?ZvuYm8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBj+pk/eaFk92k6b2SgJFDX7YHR0VIDZkmMd+xl2iCXdymvX66piBG2KmTkf?=
 =?us-ascii?Q?hvEt1CL1n1fuB/LIx3oUWgYwHn8GDr8H6dhIgWWI+YzCRjyPvoeKa8KxX4Kn?=
 =?us-ascii?Q?YVrg98CHcg9xLMjXek89vu+ug5IZRZREGZhZyNX2RcAc0oHDqGoUbWVQiocX?=
 =?us-ascii?Q?qdIubntb95uU77mxxhhfbFr9Zuhl3bCDCX5mLhXdIH0LnoHkAnfILSndC8dM?=
 =?us-ascii?Q?u6o7oI2Lb3vCxH58238flnTY4t/dGMRfeiUQmuVi2lmPhpglzu0pl6LeeE5x?=
 =?us-ascii?Q?cp7EFoTWM0D4NSpt+EmLzEjw2rX3UNMi/W4THtn+USLLlPZ5ZhPj/raYNyqt?=
 =?us-ascii?Q?+iOaXRTZVvWME45OyeTkMn5UumQ+9qiLg+DxbLMrYq7PKiKqD25b8CpKirNi?=
 =?us-ascii?Q?Nu9k6zIs4Txun45nXLqCvPx6j1WmLvHeLUThMgmCKB3+bFvsqjLPGqnv06AT?=
 =?us-ascii?Q?69BYLzZfJ7u/az5YEqL+SAEgBSzOoUnDVJTkKMR4I2Hxpez3jX+5tUoFgvmz?=
 =?us-ascii?Q?v5HOtLuMrSOJJjRNaYm1H25JDMWl7T/jW8FjQUP4kt80VgNuOACaA4qEc5+d?=
 =?us-ascii?Q?82gKrGa77b7+zzDY0nQzsi9SfnTSlZkrUQxjPy3sQgfnmh7A2Z7E+THYzdM5?=
 =?us-ascii?Q?6rH9PgzXjvYQIlGzPA+a87pEXrgDXl+vEUTzK+mORVC9koIPKgr5mVyZWYB2?=
 =?us-ascii?Q?G6sJbhyrh3kfILLWS9CmCAS7GtXeGR4P/eL0roN234F1k3iqJizdnxdGZa4u?=
 =?us-ascii?Q?zhdaE/spKBEzRRVf5kgmnJK6/JBWsZ5cSujdrKtfwzrZ7EP9eHPY9wdr7APQ?=
 =?us-ascii?Q?1aIfPo6BnyieV7VNAFegktbFvbtdL5bjI0UUcxH3Gqrn8ZIaJ2OnDo5IscQj?=
 =?us-ascii?Q?qy1Eq9qOSFrqMP+U9NMyZ4B1BVtLKz8X23FiwLVVzVCr1CaC6ER7pw/SjShl?=
 =?us-ascii?Q?fpHTkSIcY4RF14Z4QbcMBkxDtPBpS83xManpUNyP72l+LHW9E3rAz4N4p2mg?=
 =?us-ascii?Q?KgIz+foDk4GevZgeYq/V3tx8f2nAaqp4jqsh3Q/I/T3FgT8DUWkk5Owun3oz?=
 =?us-ascii?Q?P3RVUlU4fXfCVpiqUPO2hJxFHVzJM6PYoth1xqGMhCpwTzaoshIBmCL1PQe8?=
 =?us-ascii?Q?sZ+bsR6UJ5Tg+QvS8eldBa+x5xOBRO7U/AN9JheXv7pQuZCTbgPr4S/93kYT?=
 =?us-ascii?Q?5yqbCn1wd5aE8VXGI9Onpu/mYd+Kzrb5N5VHQUe7SCNwf+vNMF9/7DA8sJFr?=
 =?us-ascii?Q?QmJ0wWClMmcxmtj2AuI2ultfpOsGD3ULUwo9DKEtKPC1DvZLhEuPsABKioB5?=
 =?us-ascii?Q?srx1WZFiH7I0hnIHpd/g/D9kUfYns/48DKCrxn7/csUhOm2AbAvPWCSjluWu?=
 =?us-ascii?Q?iHGoEJhT1lYYksj0sVpSd7tIDF04GjZVRtBw3UoIgghDnVVB9U8lbXTBNB02?=
 =?us-ascii?Q?SrtFo1lBUwZvjNul39rtnDv/CsQysR2sAEFZuNLJI7dAmbqUxNieawadotg+?=
 =?us-ascii?Q?LrDOXiSADqnAzg9UQvxE+sJtBoHOUTIJ3GAbhfLd1MY/58blEkg1tMfHAfew?=
 =?us-ascii?Q?XBarZCo+6bOyCPcf0ZFOeA86kN0jOiNAlmmfHJHB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349575d6-df12-4f3e-65ee-08dcdd50d3f0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 10:57:21.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhAZIEN5X2TveYyKm2zwVU3dMHV4GOyZiGWoUZzqRXFkF/zIiH41fItceykxsCw7mEniWsv5yI2yFQTSz8Fq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6900

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'behing' ==> 'being',
'useable' ==> 'usable',
'arry' ==> 'array',
'receieve' ==> 'receive',
'desriptor' ==> 'descriptor',
'varients' ==> 'variants',
'recevie' ==> 'receive',
'Decriptor' ==> 'Descriptor',
'Lable' ==> 'Label',
'transmiting' ==> 'transmitting',
'correspondance' ==> 'correspondence',
'claculation' ==> 'calculation',
'everone' ==> 'everyone',
'contruct' ==> 'construct'.


Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/atm/fore200e.c |  2 +-
 drivers/atm/fore200e.h |  4 ++--
 drivers/atm/he.h       |  2 +-
 drivers/atm/idt77252.h |  4 ++--
 drivers/atm/iphase.c   |  4 ++--
 drivers/atm/iphase.h   |  4 ++--
 drivers/atm/lanai.c    | 10 +++++-----
 drivers/atm/nicstar.h  |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index cb00f8244e41..fa60a68cbf49 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -152,7 +152,7 @@ fore200e_irq_itoa(int irq)
 }
 
 
-/* allocate and align a chunk of memory intended to hold the data behing exchanged
+/* allocate and align a chunk of memory intended to hold the data being exchanged
    between the driver and the adapter (using streaming DVMA) */
 
 static int
diff --git a/drivers/atm/fore200e.h b/drivers/atm/fore200e.h
index 5d95fe9fd836..8be31fe38ff7 100644
--- a/drivers/atm/fore200e.h
+++ b/drivers/atm/fore200e.h
@@ -570,7 +570,7 @@ typedef struct chunk {
     u32   align_size;    /* length of aligned chunk         */
 } chunk_t;
 
-#define dma_size align_size             /* DMA useable size */
+#define dma_size align_size             /* DMA usable size */
 
 
 /* host resident receive buffer */
@@ -612,7 +612,7 @@ typedef struct host_txq {
     int                   head;                           /* head of tx queue                       */
     int                   tail;                           /* tail of tx queue                       */
     struct chunk          tpd;                            /* array of tpds                          */
-    struct chunk          status;                         /* arry of completion status              */
+    struct chunk          status;                         /* array of completion status             */
     int                   txing;                          /* number of pending PDUs in tx queue     */
 } host_txq_t;
 
diff --git a/drivers/atm/he.h b/drivers/atm/he.h
index f3f53674ef3f..ee6bd0704b38 100644
--- a/drivers/atm/he.h
+++ b/drivers/atm/he.h
@@ -788,7 +788,7 @@ struct he_vcc
 #define TSR14_DELETE		(1<<31)
 #define TSR14_ABR_CLOSE		(1<<16)
 
-/* 2.7.1 per connection receieve state registers */
+/* 2.7.1 per connection receive state registers */
 
 #define RSR0_START_PDU	(1<<10)
 #define RSR0_OPEN_CONN	(1<<6)
diff --git a/drivers/atm/idt77252.h b/drivers/atm/idt77252.h
index b059d31364dd..2b42561b6fbc 100644
--- a/drivers/atm/idt77252.h
+++ b/drivers/atm/idt77252.h
@@ -349,8 +349,8 @@ struct idt77252_dev
         struct tsq_info		tsq;		/* Transmit Status Queue */
         struct rsq_info		rsq;		/* Receive Status Queue */
 
-	struct pci_dev		*pcidev;	/* PCI handle (desriptor) */
-	struct atm_dev		*atmdev;	/* ATM device desriptor */
+	struct pci_dev		*pcidev;	/* PCI handle (descriptor) */
+	struct atm_dev		*atmdev;	/* ATM device descriptor */
 
 	void __iomem		*membase;	/* SAR's memory base address */
 	unsigned long		srambase;	/* SAR's sram  base address */
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index d213adcefe33..198a75a012d4 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -18,7 +18,7 @@
       
       Modified from an incomplete driver for Interphase 5575 1KVC 1M card which 
       was originally written by Monalisa Agrawal at UNH. Now this driver 
-      supports a variety of varients of Interphase ATM PCI (i)Chip adapter 
+      supports a variety of variants of Interphase ATM PCI (i)Chip adapter
       card family (See www.iphase.com/products/ClassSheet.cfm?ClassID=ATM) 
       in terms of PHY type, the size of control memory and the size of 
       packet memory. The following are the change log and history:
@@ -1284,7 +1284,7 @@ static void rx_dle_intr(struct atm_dev *dev)
  
   /* free all the dles done, that is just update our own dle read pointer   
 	- do we really need to do this. Think not. */  
-  /* DMA is done, just get all the recevie buffers from the rx dma queue 
+  /* DMA is done, just get all the receive buffers from the rx dma queue
 	and push them up to the higher layer protocol. Also free the desc  
 	associated with the buffer. */  
   dle = iadev->rx_dle_q.read;  
diff --git a/drivers/atm/iphase.h b/drivers/atm/iphase.h
index 2f5f8875cbd1..aec5d27ed2e6 100644
--- a/drivers/atm/iphase.h
+++ b/drivers/atm/iphase.h
@@ -568,7 +568,7 @@ struct rx_buf_desc {
 /* These memory maps are actually offsets from the segmentation and reassembly  RAM base addresses */  
   
 /* Segmentation Control Memory map */  
-#define TX_DESC_BASE	0x0000	/* Buffer Decriptor Table */ 
+#define TX_DESC_BASE	0x0000	/* Buffer Descriptor Table */
 #define TX_COMP_Q	0x1000	/* Transmit Complete Queue */  
 #define PKT_RDY_Q	0x1400	/* Packet Ready Queue */  
 #define CBR_SCHED_TABLE	0x1800	/* CBR Table */  
@@ -934,7 +934,7 @@ enum ia_suni {
 	SUNI_TPOP_ARB_PRTL	= 0x114, /* TPOP Arbitrary Pointer LSB       */
 	SUNI_TPOP_ARB_PRTM	= 0x118, /* TPOP Arbitrary Pointer MSB       */
 	SUNI_TPOP_RESERVED2	= 0x11c, /* TPOP Reserved                    */
-	SUNI_TPOP_PATH_SIG	= 0x120, /* TPOP Path Signal Lable           */
+	SUNI_TPOP_PATH_SIG	= 0x120, /* TPOP Path Signal Label           */
 	SUNI_TPOP_PATH_STATUS	= 0x124, /* TPOP Path Status                 */
 					 /* Reserved (6)                     */
 	SUNI_RACP_CS		= 0x140, /* RACP Control/Status              */
diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 32d7aa141d96..1aa6161437b1 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -135,7 +135,7 @@
 /* TODO: make above a module load-time option */
 
 /*
- * When allocating an AAL0 transmiting buffer, how many cells should fit.
+ * When allocating an AAL0 transmitting buffer, how many cells should fit.
  * Remember we'll end up with a PAGE_SIZE of them anyway, so this isn't
  * really critical
  */
@@ -217,7 +217,7 @@ struct lanai_dev;			/* Forward declaration */
 
 /*
  * This is the card-specific per-vcc data.  Note that unlike some other
- * drivers there is NOT a 1-to-1 correspondance between these and
+ * drivers there is NOT a 1-to-1 correspondence between these and
  * atm_vcc's - each one of these represents an actual 2-way vcc, but
  * an atm_vcc can be 1-way and share with a 1-way vcc in the other
  * direction.  To make it weirder, there can even be 0-way vccs
@@ -603,7 +603,7 @@ enum lanai_vcc_offset {
 #define     RXMODE_AAL5		  (2)		/*   AAL5, intr. each PDU */
 #define     RXMODE_AAL5_STREAM	  (3)		/*   AAL5 w/o per-PDU intr */
 	vcc_rxaddr2		= 0x04,	/* Location2 */
-	vcc_rxcrc1		= 0x08,	/* RX CRC claculation space */
+	vcc_rxcrc1		= 0x08,	/* RX CRC calculation space */
 	vcc_rxcrc2		= 0x0C,
 	vcc_rxwriteptr		= 0x10, /* RX writeptr, plus bits: */
 #define   RXWRITEPTR_LASTEFCI	 (0x00002000)	/* Last PDU had EFCI bit */
@@ -618,7 +618,7 @@ enum lanai_vcc_offset {
 #define   TXADDR1_SET_SIZE(x) ((x)*0x0000100)	/* size of TX buffer */
 #define   TXADDR1_ABR		 (0x00008000)	/* use ABR (doesn't work) */
 	vcc_txaddr2		= 0x24,	/* Location2 */
-	vcc_txcrc1		= 0x28,	/* TX CRC claculation space */
+	vcc_txcrc1		= 0x28,	/* TX CRC calculation space */
 	vcc_txcrc2		= 0x2C,
 	vcc_txreadptr		= 0x30, /* TX Readptr, plus bits: */
 #define   TXREADPTR_GET_PTR(x) ((x)&0x01FFF)
@@ -756,7 +756,7 @@ static void lanai_shutdown_rx_vci(const struct lanai_vcc *lvcc)
  * Unfortunately the lanai needs us to wait until all the data
  * drains out of the buffer before we can dealloc it, so this
  * can take awhile -- up to 370ms for a full 128KB buffer
- * assuming everone else is quiet.  In theory the time is
+ * assuming everyone else is quiet.  In theory the time is
  * boundless if there's a CBR VCC holding things up.
  */
 static void lanai_shutdown_tx_vci(struct lanai_dev *lanai,
diff --git a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
index 1b7f1dfc1735..f4a703730166 100644
--- a/drivers/atm/nicstar.h
+++ b/drivers/atm/nicstar.h
@@ -332,7 +332,7 @@ typedef struct ns_rcte {
 
 #define NS_RCT_ENTRY_SIZE 4	/* Number of dwords */
 
-   /* NOTE: We could make macros to contruct the first word of the RCTE,
+   /* NOTE: We could make macros to construct the first word of the RCTE,
       but that doesn't seem to make much sense... */
 
 /*
-- 
2.34.1


