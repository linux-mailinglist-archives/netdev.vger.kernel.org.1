Return-Path: <netdev+bounces-65533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFB83AEFF
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84B1C1C24EF3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7327E796;
	Wed, 24 Jan 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rJaAlgSt"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2161.outbound.protection.outlook.com [40.92.62.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95D7E774
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115648; cv=fail; b=VzD9QzHC9sxwqU0GmrC+JX79YYZY1kIlATiecJNgJKb/U8udzLahSCF8qk8hL9022WZOd+IAIAyQgfqAKj4XTobO2W73VMCDK90bRQTzkwIX9nYWHjDdsNI5o93gn+2eb7tbhR0sYwJebH5hbWdaqxF2WKBPjTcPnn3Twm6n7+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115648; c=relaxed/simple;
	bh=HCFE15hhhCzY7AxfUl4epowycEHVa4ZbaA5H6ZzyGXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AgzcXR9xa96rADQ3SvyGAw2R/KtlhS0L6+NcK1qDJkWK+awc4GYvlK3lhN6HR1jyhxrNOjdzfCv5VVwpisgioY3jmHdmMqO06vhxIXLT8OqoWpCEgjen+EcTmGk8HG/BiepBT4q4L/y3760rATHf0gcDweCackOQN0A7YO5pLxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rJaAlgSt; arc=fail smtp.client-ip=40.92.62.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyDVpQNKWSYGrKA52zip7lhhfHZoprFr+4U5ODxCjW4wsC+v5MNH1fziH8dGKSVLB8GCgurKObIZJ1fKZ+1VrJ1fJLchbnMZi5W/TeiLiMTLbfcjxn72aOPF3uYnFvFg+2hfETjUY0+0ykIMxz0ihjOrO4Tvoxd2BurIOGya78+gN0Tkh99mtcXjpqmavrK3ozgIu2p13VSh6gUygK/NU1eoMNG7MVRluGk9RUb0vF1DonGu98q8tXCDozLKA8kmZhBIXdKlBq/wi5yc6bqR8mPgHLqyKnLykzlbWeV+b7Vd17vc2siaF0jWBcPrEg1F0tR3KglRt9d16de0P10d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1bNUaprUgF+W03xjmZkX0ARuAs7sGxl2P1Y2Q8mYRI=;
 b=LLmDHNeIFe3T9r9vG+uL9sN/m8jZPRGbSXON+EbKvPOPWnxVk94OYX8at/NKNj0pCh0+4kCbPB0rk29mlR9ND3YhLCxp0e80sSD7n7z3eLm0pCu/vz+vjT03lHn3M5GM1u3HNuzja4OcVXcHgCcwtsq+Am7k3aLNTdGaxmRXrteXl/0RkjpeOZEa8WyTEWXITWU53JXNrfI6+QYvKUQR56GcRqg+xVAUSlTibcuiNZ0rT9QSnYv0MJIuoWc6xG2tKbcqXBWxoUc2BVlEvGq7/ImwVdZGlBIhmn4GXNWCJW1QjwauvBmTOqDBWk1TLDBJUaUDwI0Ze7qtZWT9ZZ0x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1bNUaprUgF+W03xjmZkX0ARuAs7sGxl2P1Y2Q8mYRI=;
 b=rJaAlgStszpDOr/sGX9jmYhKTFPjEtSXMOnP7nam5iyPBkqeDift5zBICNXWz3j990kp7hH9XUsN0x4t9r7r8RL3xUcg0DMB2sVkjAFJ/lQu5cux8nIATuS8LWPe69SH56K0QbQFUSutM0iSJ7ZtrA2awgGfeTzBXkuxyr6PR/7WEpJyT5htWU0d/UVYG+YmUfSmFvGADeZ1A8fBVHdkJ7OfX/APLf9pQTPX2KDU0Beab7etmtlgX0138OxHCn1gtCEfh9fP7Hf33vZsBxXq8RVLlvtHjHal5NSx58Jk62oP2AYcLjm3KdENhD54p0Iv1suGEx4LiNJn6NjZbL0fgQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4936.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:00:40 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 17:00:40 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v6 1/4] wwan: core: Add WWAN fastboot port type
Date: Thu, 25 Jan 2024 01:00:07 +0800
Message-ID:
 <MEYP282MB2697FB6601DC1A323ADBC036BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124170010.19445-1-songjinjian@hotmail.com>
References: <20240124170010.19445-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QbKri85XlZziw+A6oQzSP/9CseaJQfRy]
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124170010.19445-2-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd6cff8-324c-4425-2e0a-08dc1cfdfe48
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	52EYR7rWf4E0I987kWnFohcE9dyA3VdfkkRj6x8B/Xqezf4TAMgbLg0n0v4zoE6oSZtjzGtXYgaxB0KI2oCAtJg1JiMX0YPX39+p0QQ0yrU1owTQR6VYuLW0b2S9+5wDSbKo2SKwP9AgqLGmvDOtF4aIN9+IivL8EdXXGjjowthbKsEUllbz32rZNgcvgfnR9L8AQZmd57WXZ9wLoapvExO1YtKSH/FJ8YDzoY5H1L6oK09iMG7Rn81lIuUQQ3N8pf6sCEE032wjopv4of2FK8FgLR+pHi0Ou1qZw1uRPR/0NCfHc3svqovqHLCed/PRPB56bdt5PPsjq5iehhqHJfnhSZ4Me0jSJqkkY22+AjV8YhfSWQQ39yGT3a+0PT2GlxK1u5XTNINErlLfQLOeUynYEIa1x++wl57jxbHL7fdlCN6p755v2xFjK1TUXO22YlrNnitAjCIckdm3HWYjXtvZrRGblyS1ckpdxnWIatpsvRpDWJddDb6zVF7+gHdsSsJk7IlOHI990gU+Zsg4X2l7krDbWy190bnexKo/rjEafNZhIAQqHJ7TbzAnBpXE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tL+iaz7O+dVKIC2q5g6LyJ98flsZ6suC+LQ0bgwNsaAwC/wxWU5OIKvpMv4q?=
 =?us-ascii?Q?5FLLwIT8iN8z9x6ivLOVgxEwtUEDyuVL253fylBo0XuSYg316Bxcdc6Zdyuq?=
 =?us-ascii?Q?p+jPV1v2uQrw79PV73rFrdJyflpGOgJtFwILnaZyVLRieRLtr5Hx9b2g63pi?=
 =?us-ascii?Q?UfyzWdtm2Y+6F2gMj9iQcpgtWXf2ya56V6Iq2HR/TOAIAx/aG3Sp7V0EgzZW?=
 =?us-ascii?Q?Zz8H+ahFPFluvCSgNxZYHIrL019SFgHl6SrFDML9aeaHmSxI6YPDSLQspzK3?=
 =?us-ascii?Q?OS5iK9P6dYpk9XteqP3gF2+UNL8rMAnNpzZg7GIeNfe7LXjAcMf2PSETnU7k?=
 =?us-ascii?Q?btZCiBxh10vCYqYMV4zbCw4Hm5X4+vx05vu82tDzEpJ06La6QDrbOmM1uaeX?=
 =?us-ascii?Q?5XZX/mDhQLdbgwNJN1v4LyXzUah5VnkrXm1NGn3Yd8Zz9+RVh4PxE3p5ErJZ?=
 =?us-ascii?Q?p+caTnI9uDx6SQoE+lOuIKsdjpBY3bjhmWuhgjqMLg8qjwdB2+e7pqppZU4x?=
 =?us-ascii?Q?fEFeH0DXes4tUpt0soJKsmzTFT25ubxXco3+EecWb9KhJCT0kiYmZtLa1Rw6?=
 =?us-ascii?Q?bBEcXSjb0iI4IsGRLAca2S79JwB7Uy+VjNXuB6u/NLeRHnq9BZxdieFV7YMm?=
 =?us-ascii?Q?E5OYC7x/7f8BGs2chpsO7QCdYZ5y+gZG5zoIhTP77GPtuLFIyQ91dWpw4u4F?=
 =?us-ascii?Q?FhWprDchy9EfsnRqg8W3TQaKuEdKq+3SS/hVWjLbz0c8IQLvtJex4IcaDhU4?=
 =?us-ascii?Q?FM7/cYLxHCl0MX4PaTDg+BjLfNpRekKsPj4Grmm4Znwbf5HMAQDrm0HceZEC?=
 =?us-ascii?Q?jQ09T01iiFNJrKSvlebNTZUJzfRwIu3uexnK97pH+ULiK/dTEbnTFvJ7sKst?=
 =?us-ascii?Q?xYg8u4NwpXLMmMU54HaSpEvfL6+RZHstut4Rl/n3epMvq3yPmmopvypjNZCR?=
 =?us-ascii?Q?ZbOb/Qq9GiNM1gjgiGNAJ7V1FBlM6YUF8+sameemBYXe0jFhMbKzLGIH8XeL?=
 =?us-ascii?Q?P6b8uO67h84ca5Z2kvLB7I6uP6Ut4dguMoHp1wqGOgU3sgR3gEsLu50YQUxh?=
 =?us-ascii?Q?c92hRqgf5bKBGvVFTVTvTbQQ9mqCVsRGTYVcWkiA767h/0p2D5GUWYnZRjPk?=
 =?us-ascii?Q?oiZXQmmucdWoUEYvrDSfp3vPXnfyydvXLqTYJ33Gv/KdhXe0KRvN8eZY/q79?=
 =?us-ascii?Q?aWAExu00HhlXYCjWKq7Qxnvjngqu7yfyGUi0QdfwvYd2D7at/yMYY5n+Y3k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd6cff8-324c-4425-2e0a-08dc1cfdfe48
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:00:40.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4936

From: Jinjian Song <jinjian.song@fibocom.com>

Add a new WWAN port that connects to the device fastboot protocol
interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v2-v6:
 * no change
---
 drivers/net/wwan/wwan_core.c | 4 ++++
 include/linux/wwan.h         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 72e01e550a16..2ed20b20e7fc 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -328,6 +328,10 @@ static const struct {
 		.name = "XMMRPC",
 		.devsuf = "xmmrpc",
 	},
+	[WWAN_PORT_FASTBOOT] = {
+		.name = "FASTBOOT",
+		.devsuf = "fastboot",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 01fa15506286..170fdee6339c 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -16,6 +16,7 @@
  * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
+ * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -28,6 +29,7 @@ enum wwan_port_type {
 	WWAN_PORT_QCDM,
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
+	WWAN_PORT_FASTBOOT,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


