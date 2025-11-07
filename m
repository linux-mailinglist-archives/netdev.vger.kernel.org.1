Return-Path: <netdev+bounces-236630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B77C3E7E4
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E59D188B1FB
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C7230D35;
	Fri,  7 Nov 2025 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FESzhwYj"
X-Original-To: netdev@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010011.outbound.protection.outlook.com [52.103.73.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569471482E8;
	Fri,  7 Nov 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492603; cv=fail; b=Ls8YdBfaJ89eFHrkj7zOq3/3k7NY09C6ylYAZutshYusYxRENTIFswkWwt+G1PPewCacfw2YB0XjCY9U+B/pgpkfgEAaffDTIP4aLGhHi39PGqvml4yjd6WOc2jb70tb2LOe3RcFewhldZBdW1V6X4QA1BwLGR8o5oH1zoP3CuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492603; c=relaxed/simple;
	bh=+iW5rbfI6uFK7e9TC6ioAwOETZkYEmBdnOP05Rrr5P4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L9FwQITI8jLcY0Wo8TNOcWS/uOoY+BubAswyfFvviFy63JtzScgd65L5KcPJx4OV+44vtq43j2NN3NuWkzpedZTXkGejiG8WdnkBqgjVXhogShZ7faDLITn4LsR939bCAt2UnTgmbxferZGcKXe6FS2fw3iM5Lus1kSyQb02ZUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FESzhwYj; arc=fail smtp.client-ip=52.103.73.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLU9HVW2fdXZfWd2UsE24UlPJp1rkXUNlYkjaxcVz4Kt4Lbj2T3jxSNFbMHnNOvWyXNpWM7jNZqt68T05U21KLyYzSfIXqtNCuBYvg9Nwa+r12bl9htZp7Km6DK9xuRaQlfH21MsdoaMVBrJ4O73dpOvxeUm9rJ0MBvFk6QnCAfBd3F/EZNw9eTgldeSwuC1p7Jg3j4z7hH/SjxN5o1r5ZshPsOxeH26ePpnZiGHZZ/Nx0850mixLYOEQur3/+EqlYQ+I6Qo8HajZQqRWic0METc7kRrox/dHnu0+PYMzBi6KjhNpLwx3esPJL7VCmVQXFNcxKhSOUhvg9bimNUWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdzI0jEmHyysJQEuDC4dINb3NcA9OT7ErNT0nG1FChw=;
 b=wN2UECkl3HlssbbNylpxFvmfmFpUqB9zA7hPKmOZ9LBprObbEpQRAZIkTcUcJ3Z7QTVvuuYa6/ILls83v5HUx4WroG1jeomXKq3TDDLCTE5CCVB9YRdnLfMocLO72AhZgupdF7IxoxoBuzZLlowkVqGm2R+Q7eGwhPhI+dDHHWnmYzN+8LappNH74d2uAGwZro0ljl93IFQXpfRNC0pgxkVw/haa8o+Vp5uubkoRtppMN+xp8nr1d941qWfrJ2fhj4uRe695PIb+Qoa8CB/EBmg1zvrJwnqwU2G7D6JrJha3G+/yBcQ8LILkZpqNg6Tdp6uA0W/wLX6va2tGVAM+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdzI0jEmHyysJQEuDC4dINb3NcA9OT7ErNT0nG1FChw=;
 b=FESzhwYjftPnQSUaVNBR5FR/ZaM0+An5y0mJlV4muUFH2H8WVwNw8L4EK1428N0AxKdf7B6YpNDi+thCHZXRVwTFjS9bpzrRiC94/A4JA07RAFO9yjhWIn5+8f5xIlbNUGoOz7cnyTYOoi7EpYuTJ+D6z1epsQvaoMXeyiJe7LAZ85lVLV27iM5P7jjm5EuUOtWRUhG8PIEur7OXN1hflIRRcPOCbjI5snq7PYGPv85PlO/phKmeHBBnv8B/jy2dUDihGdEMrPLeqgXEoFltUphUroUttGvw9wVAZLbeHCQvalj7zqEIHLPAS631DMD5uECWY3aeE6NVJvL9YbXh3g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB6715.ausprd01.prod.outlook.com (2603:10c6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 05:16:34 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 05:16:34 +0000
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
Subject: [PATCH 0/4] Add scnprintf_append() helper 
Date: Fri,  7 Nov 2025 13:16:12 +0800
Message-ID:
 <SYBPR01MB7881F31A023E33A746B0FBFFAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20251107051616.21606-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d98b53-4590-4a9d-ace5-08de1dbcd158
X-MS-Exchange-SLBlob-MailProps:
	a+H6FLLcF3qR2HGZMjL0lriKLF3k1Y96M1Z8XJJye1m1QbIRUW7LYNGJM4N0lLzcUjVbxtVvKn6oOqDEEIglI9UxaRxnIKsJ/xk2XyqzxSwt1IcJQwunvl+R8MBoKNdU/6i2Y5p3tNge+UpATOCrO5VLvNyHLUq6NXWUckbzvM4xzJVEJpSmdXdMR4eouXIvWIk8noRLeYx/ibqaRTZYHFxHtTkiGlxb77uGEBgYVy8PyQ8SBPAdcQHKL+nm1Y/Otc1jK4l+mnhP2wzT3BOdFpQ0I9/UetAjwoDhRjESTJrBuOVFptnKOx6bQ+HCs+c19AcSbPQ5BoztfRuZLAiI8RN8bNzpb8DUa9W1eWQRGrnTGSNUGR+HDtxW6v/mJqT2afo1mx71Qo/6gDYLkWPornI2A7T3VYk1LaaylegBKAq0sladITj7lhnu8SmBH74QYeD65CmgFV8m72dazM1ETtjlljQ7hud3L0m6+pOieR7VoNweu7b+fNsoGBILCsYADGa8Dke5OlU/xwrTKwfciBtLgeHRWfs/8L4RkSr8cx6LXSb/hYvHFFqwCJJU4oAlYYJn04NZN0x1I9OewdBPXOjVxr58ZYomnR01556eh44HsLK4YVM3pPk29w/ACc/V7WI1wEhcBkmGS8NEfBXkECNxvVt9mBnzmWZQFkC4grwNvyo/s1Ll+LqGGKq0cbyvhDURydKHq7zM+5GQSWYVwiWECgqbopGVF/B+DdugRQKn9EJDn6HuCqQHwbiU+vJ5KHM1dcm4xhg+TGlNVKJUH0IN1nq08Ky95Khqx16H/gEzCUUuAuVckmws0wiSOjyK
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5072599009|23021999003|19110799012|461199028|8060799015|39105399006|5062599005|1602099012|40105399003|41105399003|440099028|4302099013|3412199025|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ieyEXM2Z0wvBoYG47RGw1XE1xEkamMnqqfBRN5ejhCnTU2lQ3GmRwqTkka7h?=
 =?us-ascii?Q?HWFXAkBnI/bUjpRdjuhaUE9WLD0caYQ9aHLZKe2PCH7mOaD4qMSncI/W0KLg?=
 =?us-ascii?Q?9hnfd13xSDBX+JDCxi7jrdFVhI3N3F6BEDzrk7h0d2DSGMfy/3ALVaFqaMjn?=
 =?us-ascii?Q?xq4L/vEWLLvdPcH/iX6MlF4qmnhgUllxOPgYgW1GYwSRJeWDkVxfE4fExSiI?=
 =?us-ascii?Q?+N1Gwk5v6SXMUHHCy7xCY3od6f01RGnOBCDHJ1ABStkTXT+Fx7YnOGDyEkIi?=
 =?us-ascii?Q?9MAFzirOSWVZlx5ae+rnLgRPF4/FD1X4ZeHw4x6ZTmFWJW8pKkuEB7HFobOB?=
 =?us-ascii?Q?rd1NSwUYRZQLBzZBSpwRkyQstrwsT/sPXAM2C1BbOp+JuN7G0X8aFgXLp00m?=
 =?us-ascii?Q?/AyLBYvs0wlUc6sIB/c5Ft9Y0lfW2SH02BolYwDKuj2chLbpCwHx9xYfPjxK?=
 =?us-ascii?Q?HPxvLMKMctplVuqPPVYSNv74Qh+bzM/41cOZ4sx8vQYwFcW8k3kQcx6DUNPw?=
 =?us-ascii?Q?Nv+aSVN2oYK24BwfFQmHgBCKCPvH5jd8gZhR+ZcaqW56vMlr2sY0nH0d7ELZ?=
 =?us-ascii?Q?VCbu5jNMyDGh01c/SPLyzMItAAnOfsFkAXkr+mvt+1VVX9nx75Tsw/yXmzS+?=
 =?us-ascii?Q?Q93I8gzc8ZkJVxSmZsHEkvg6uXjfjK/1l5nmlcu4tdKHtf6TWHvXeFvd+96+?=
 =?us-ascii?Q?GI4hzQFrfW6fTU/XU0k7q3RNbq16hIKZ0Il/5yUf6AtAJY1e6JkfeSRsAw7u?=
 =?us-ascii?Q?aMLx4I+0QycizTmRSwCjI8eV1EsLHYTQp7FctahY4ETFMiIxtkuP70qGBeLN?=
 =?us-ascii?Q?d77E4r60vncvuC5yUle0OhGq/FcikxCsl0srUuI31QeUNhDmjqDf7lRlnreo?=
 =?us-ascii?Q?diWCl9x8QICqVc1LU6S5W9AKi/ps/ifxEho3Qu2/giYd31wwcv9fQCL5GkwC?=
 =?us-ascii?Q?LqO822+hUXrI3RK910RVNWvbKIgsC23+uSqvmALIkC621ARFb47UpzLIYYNS?=
 =?us-ascii?Q?GdNwCRnd1zcXaeI64OFi4iyOK2yzdP3y21PgbNLnH9dzkiMCBeQC87yABl0Y?=
 =?us-ascii?Q?P1VoReusqbL5Xd1wAR4F9YCb48zgQNkdgIFzVNiS7sviJ0lYLCpZR5M+Ta00?=
 =?us-ascii?Q?bfap2HH9+21fUPK2MKri43VIfQggD5eUNrRJXOmnFKGrAZ4d9xu5mTjxfnmK?=
 =?us-ascii?Q?37gx4BlDaPon39JrbtXBS7lbDPbQZ56cYXmRWnkTfRTmPVkWfy8Y1BtB9zGl?=
 =?us-ascii?Q?jBt6y23jGLQfqniUn31ByRyV7p6GvU9ZB1R++bTz/j3w0sjmKntmFCaj0Ff0?=
 =?us-ascii?Q?K2mK6WOXp25dClpGEWh3AVEcf6tEf4ykVwFcRXRrzrJww0iKmNtJ0wG4O/OX?=
 =?us-ascii?Q?1KGah819cbHDoglEJSHvli6YCI7dNzHrFMWPaBCsjNJ31/Hbag=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f4zu3DO7cnH5O6prtKOxu//FnsyZoWyVZAcXr2W9DZWFqV7ehpaxcms/4uJA?=
 =?us-ascii?Q?8b7NBoN2wFG4YkzH6fQ+yNFWCkQPUEUYkxQ5SBFBc9uspLTtlVMyPz89TXl1?=
 =?us-ascii?Q?QHaEtTAJgkz2AFs8Jr97W3INCYcmzoHQ4SQYxu8SZxnfWYBMZ37y0zvo+DYw?=
 =?us-ascii?Q?NdRXGFzBXSOg/Qkk2FlckTkrk1XIOQXTXuxQiGWZLdm9akSDIgE3jLbhKr7p?=
 =?us-ascii?Q?gZKOQidcs1Wvb4k32DbR2BgbP07nGVNV59jVYLPTV7vH2PoeyVX4Ix50pyFm?=
 =?us-ascii?Q?jxFfgH+FO0AmlXjm0iKxNmus6axeBY8JGeDFAO8UghOwWSuYnTF/hGRMcrzD?=
 =?us-ascii?Q?KLRej94N+BjN9EwrDoeAGYbW9LWizWjnSPuzea3W5K0Uc8QkQk3HE/Ruza/I?=
 =?us-ascii?Q?Tnecjsz5+ZGJHRJu9DZtCgkx+JSAeeUfNU18htl/JFfO+D567tWXfBUgZ+Ts?=
 =?us-ascii?Q?bUmOLLNcbVk2ZXBNa2ZFPznNIjEHBGqglEEZKvb7+Elp9+Oo9IIlpwtpm99D?=
 =?us-ascii?Q?zoCQNQKvT0Ob485Wro76ecltH1UX9fZdA5ASzgWemce6IYQZtzqgZTxMgz4k?=
 =?us-ascii?Q?+RAWAA0SsqXpj3QE7NOD4v/Tjw0xHd/KSbN3XXTQcm+ItjY6jlpTrO4CWSWZ?=
 =?us-ascii?Q?Bnk6V9m8P9WmTbExkAMOc1BhBVjjfjRqDYjk1S4Utt/EBIBRfVzdfOCGzsEp?=
 =?us-ascii?Q?8xC1/eKpPhNgKHEmCz756i/D4L7+qs7vqDVlR4d5RAAtR0/GcWF+xcCiHPIR?=
 =?us-ascii?Q?xZvP4+LZqOgmQ+hBHW2pmAdf0Z2/i/8WuVhf32nw16MGj2IcjcedfKAaFNvm?=
 =?us-ascii?Q?nYzh8xV8hj5q0f1ph656yzyg/rjQFVN/cYejWAT/TiTRcwRgKkNE0J8CCrWK?=
 =?us-ascii?Q?S5dZO4cwAQwOaoQ58pAYuu4qFJOslgZuPcWx6oOYw5pmicppsW4hvMjhd0+W?=
 =?us-ascii?Q?8gpWau7XO+qHfnF9UD1YNUUBrRuey2Nsf+LRbe4zdeHJmoIY6mR2R8PJgivC?=
 =?us-ascii?Q?dKJ7Yz+s99x+ULLfXVbWnpRLYq8wJQIZD6DrkktLKRHyOzD4YKSxKEjgVyz8?=
 =?us-ascii?Q?ebhF2C5FOlrtNlwbB5T7BNKEu8O159U2ECcTbFCfKSD39dhW3aqbJ3TH5ig1?=
 =?us-ascii?Q?u4yliD/xPGoXHglyKhs8ObyHP0cy2Qq6oXu7k4SCQDslTkgkpy+G2jqas2/P?=
 =?us-ascii?Q?9wwJWLiPlEJJX+HCGq+CXwYYPw+RUiW5nHTy8kNZl8ICI1PQUjN6QjSIZpqo?=
 =?us-ascii?Q?olaU+eBtlW+0YA9pjMAE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d98b53-4590-4a9d-ace5-08de1dbcd158
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 05:16:34.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6715

This patch series was suggested by Takashi Iwai:
https://lore.kernel.org/all/874irai0ag.wl-tiwai@suse.de/

It introduces a generic scnprintf_append() helper function
to lib/vsprintf.c and converts several users across different subsystems.

The pattern of building strings incrementally using strlen() + sprintf/snprintf()
appears frequently throughout the kernel. This helper simplifies such code,
and provides proper bounds checking.

Patch 1 adds the scnprintf_append() helper to the kernel's string library.
This is a common pattern where strings are built incrementally by appending
formatted text.

Patches 2-4 convert users in different subsystems:
- Patch 2: sound/isa/wavefront
- Patch 3: drivers/media/pci/ivtv
- Patch 4: drivers/net/ethernet/qlogic/qede

These conversions demonstrate the helper's applicability.

Junrui Luo (4):
  lib/sprintf: add scnprintf_append() helper function
  ALSA: wavefront: use scnprintf_append for longname construction
  media: ivtv: use scnprintf_append for i2c adapter name
  net: qede: use scnprintf_append for version string

 drivers/media/pci/ivtv/ivtv-i2c.c            |  3 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c |  7 ++--
 include/linux/sprintf.h                      |  1 +
 lib/vsprintf.c                               | 29 +++++++++++++++
 sound/isa/wavefront/wavefront.c              | 37 ++++++++++----------
 5 files changed, 52 insertions(+), 25 deletions(-)

-- 
2.51.1.dirty


