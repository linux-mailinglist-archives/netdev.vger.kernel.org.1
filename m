Return-Path: <netdev+bounces-137787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A90C9A9D47
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9AF281B04
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46B3176AA9;
	Tue, 22 Oct 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="RZyKmLDX"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2097.outbound.protection.outlook.com [40.107.215.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA941714BA;
	Tue, 22 Oct 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586663; cv=fail; b=Qmv/tiXEpK7Dp31EZv/Ht8Be53QHDXdugXa4svy0qbUreN/atNFtMMMa/Orz1zFi9HiHhFzRxXC1fT49ei96gbJk1pyuU7novWSn/UZsy2fUz/IB9t/IWtVn7RUxmVHllndaIPDhxBXVaHWcLjk0k+YGQnMgs8xtjcDHPZM5hmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586663; c=relaxed/simple;
	bh=rZ0NF4KQGfmR+qp9RI848Tyv6sWE4u9xIC7nGvekR6c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tk+XWgm4HSbVSpUU4w9ROC9opIbAS0ESz1CW9jUYAC75AcipyxLMyFLs5slWvyq76/ag/kjRemmGV/cveo79z4CIqNhuLeVH6IRem4SuNkSFu7LoCB5Oj5piOe0rceFW5Odj459AVYqPwm6zEbAMM54AaKI1pT6AQ2ev4PrLz2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=RZyKmLDX; arc=fail smtp.client-ip=40.107.215.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN7MLG+7ZGOGdPe7KuNVHDbiEnd3yquHJZc/xEz92h/nQKL1f17XzrUG7ZH4jsJcwlbst5b7Q81Qfco0DSENp03U2VuptcNuWk40T/xO9Hg5YRp+NyMsxOJBDzyo0kA0UQyHfdXCwna8wyGxoO9cKcI5GcKMyzAnJ9gQOZMUfAPnN3i24h9+bKfi/e5q9aitgQOvJLM+oin09xA+boIhxnuAvyPcMJGINDWvWnWGcCvfhdaHIhkePkv3vVNp25O2Ap0lEeXSqsU65/l3VVdJX1e/geoSZjj/6adeoMK4tnSacv1DJuSmO8j8UA2CHyWg/7h9e8sXePP/cb7b9bpXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6hrUn/HotgPfyIsbxxBO3trV1dgy7qwIeCsrEiWcvs=;
 b=YDa2BSyBbeSNRJYUPPVwGgzFSDP9fEfmqVCpUWH8eXbWcLZ8nlb01B0V2/U3lUsyupcMmtbpaXv2l196sDcskcnVqmCQAMIOHMq11uOHPE9n278ihhqH0LnTiCQBntUddDa7cDfxclSF/eU5WXgx2NVLrJQFY2kjKxAJquv6rKfIILNe5U3MxwRD4bc2tXaHFfcCQPDgmc47JfuG8Wt50wDl1hAa1pJRwBtPT2oqLNqvhLEj1fqPDLDF4QO0ETrHogwtnGIgkkqO1V1tP8KpVrrjdid1jQAnvUcSPFesV5lpJGreStyGi5Hk9QNGHF/KQ5JYJdlmEdJoi1KCWErVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6hrUn/HotgPfyIsbxxBO3trV1dgy7qwIeCsrEiWcvs=;
 b=RZyKmLDXk2J1bFZQRvlfjxu9+CL+cR/PAu2Yqv9xm/sOkK3EmEbwKzepKnPwrJfw1N4joVrllSUnQfxKt2a/GwjWX2iRyLSP2l5xu4jhTsMfv3b6/sJzMN3iBXvyhtp5id1fqFP0zfDqAB1UUDxvLc41fweGivCXy5MwWw7RNjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SI2PR02MB5562.apcprd02.prod.outlook.com (2603:1096:4:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 08:44:11 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:44:10 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
To: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v2] net: wwan: t7xx: reset device if suspend fails
Date: Tue, 22 Oct 2024 16:43:48 +0800
Message-Id: <20241022084348.4571-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SI2PR02MB5562:EE_
X-MS-Office365-Filtering-Correlation-Id: 31570f44-8815-4824-80f7-08dcf275b299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cAId+YUbnXXqRo3S9hvSDBLzXgac0C5oCSt33epIh/sGbH/RHG6a80PVOqIO?=
 =?us-ascii?Q?nHKxvzE/ttNk82AxcVc8GmnuSouJZOtOyiSuJ2Mfq9NH3nHuezzbYbJkUAqU?=
 =?us-ascii?Q?kLfr+xUT3tzvZ9CN3SGTPLTiLyp/Qxw/3RnogR3u0/Nbjez+3exvMiIV2T2Q?=
 =?us-ascii?Q?wSvutLgumWfqR20m437bKCTOCsZC84G01N6yrqxAHrGYfEiQdV5uZOL8qGiW?=
 =?us-ascii?Q?lYNYvGSVWrTUMySuoXy1l1ci8NXBu6D0plOe3B/VaUxvKP4WanWfpKjReoiu?=
 =?us-ascii?Q?vWPSVyUl8kxJN2Iov/4Byk9Q1nCC6sbBZ/WmeWfOQ2dQX2EL+FOjqzwWf1b+?=
 =?us-ascii?Q?Gbg7xRuWtczaZtJz7jy9wy6pCJyubMunkcq0j8T+6DCdOxQ0VFv/vGV80hcD?=
 =?us-ascii?Q?5ga/HtjEFXJ/1xSyF5WLETYpO6ETwHeX5UMscfC8sja62N5MMhB+lwKjHQuS?=
 =?us-ascii?Q?gihG6jdFmPxrYZuWGxcwlNSfxflSQZKf4IE4+GgXG5mqVKtTuSX3DiKNZ+TJ?=
 =?us-ascii?Q?p8Y19T7R0A8CSXJdzZ/DPNitD5sMR5re9zaWE/JOQAj2myfNjw/QaJ+FirSF?=
 =?us-ascii?Q?3iIvKoG8MYLtTx94ZIyc+E/8JRRJhIN4Xp+1YLnvgiuYvWNxHJyj9F4jN16Z?=
 =?us-ascii?Q?XP0N5L5JpsxqKvna+GsMQF730umpuNu4DF/JmCQWRDeZcQOhMctgRgCf2fAC?=
 =?us-ascii?Q?6OsZKKp4Qrsp/m4nd6wPHVHatqxyOUeFIuSY+7RjNjtojc2lr+2LIqBEiPtD?=
 =?us-ascii?Q?UOfPnJDKIP/yJOJptavA5WtqYo2iX7phAKccLo4UrWHMh2S2aZNmaeyfPNeE?=
 =?us-ascii?Q?PYCrwKI5MZchPWFW9pOnYolpoTkaRcbihZEk9qojYE09ifv1vShRLlm6m66t?=
 =?us-ascii?Q?fI+Ac8h+sabTgRNrX1oSISZ0q0VbslSPfygTM0LgVA/3UIlU2CH3bVzBYdyO?=
 =?us-ascii?Q?w2FuvryE+hMhFm7bRWS1TKyJJ5OBIpOsOMRVQuNlhBbeMKf9VeMyIWJaTo/F?=
 =?us-ascii?Q?fWQO41fI7W44p/BcxefiJM7g8RSLYt0P9t32sIBvkdJjZ2XAJMfBHCrd+tSz?=
 =?us-ascii?Q?Ly937QgF+7LU0Q7hbeyqDJ+xyN5v7LGd6Nrj5B7U4+rA+JfkTR490T7kqayT?=
 =?us-ascii?Q?JK55eglKivaCaVfNcPupG4merfmYs69SptJhflW332FL5fhXAG/hZ8VBHm3P?=
 =?us-ascii?Q?n84ha++dzsTGf7qVyqXn3Im5T0QycthLjIS/gsFqtmeZDAZhXuaUptacbs1d?=
 =?us-ascii?Q?rSNYPQMGLSThf3TG9FleR5uG0R7pIn2aimNRfc8GkmeofeUgbFQKAcsY2Qi0?=
 =?us-ascii?Q?t7B2mhXAXCbu1Pdx+34mYel7iTl3Hb5K5e35FKrAM8oaOrSi1ek09ZVGLmsQ?=
 =?us-ascii?Q?+oHqDzCmr+J7ffTki6lFz7xd31dG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jSPezyVLB51jNmDWvwpHidWpBS8A7G/DdRlBgTZWFMC6wGmPVlGzzAxy7vcn?=
 =?us-ascii?Q?C5J2Er6mJWwHd0O6i2S3U2Lqt2OG16EbeRQ0XzTOOCx02E1XJEfdSk5zxdnM?=
 =?us-ascii?Q?rVDgeUwSE4DdABm0PrMU5JWdwLkyhzbPI+H3Mi6Hyjs9O4z6UUf6FhtTY9iR?=
 =?us-ascii?Q?Kv3qMGkbpi5G20jftBJxpltUsZIjaslg3tbo/7tc7wk5i5BU7279puGpEhy+?=
 =?us-ascii?Q?Rg9n8YnMjblwFOsFvFtIe49msuVwrJSbE4vi64cdE8GLQGEPsEWSGzOE7OZ9?=
 =?us-ascii?Q?E5iqphkqcjq+n2bitFnDbRPKqeFGZzNqDKFN3TcCIRnOvoZnmY+g0yJhPdvc?=
 =?us-ascii?Q?1xJuhEfZuamybjQsVKnuW6zs8NjAaSwXYr0et/vQVD1C1rBK2wIfHFojwqxv?=
 =?us-ascii?Q?Cgy2OhwBrZ69Fsanhi0bieLdy1Wyg1o5gKBY08WJ+o7Ua0jQMG8NFPAXij1/?=
 =?us-ascii?Q?y8co79ApK4b79hU6u5PkqFBxNtMFSLsx/u7Cmie0yrf/Ejj0nFD1IwKA5wJc?=
 =?us-ascii?Q?hkn7lx0Q1f2JrIN/BwO1ffZr45wbNo2fzRb2yI3L5kyQjJBsjuMAV+8H/nfk?=
 =?us-ascii?Q?5rmvhrQo3/jCqL424AjiWctIz8GIX+1VelY7NhDXdfEEyaZ4CtQhUEXQBpKn?=
 =?us-ascii?Q?qM92VHmhpsnPOn2jHc7QL83jClRKBr4WQlQEQq3MBbkAb0XO+6FE5vug9sxg?=
 =?us-ascii?Q?LXiZOjwQ/5LTRFjhqUzCvGd4krccoZF8iXiK5Ibvu3g0zPWCUEP3N5dQM2Df?=
 =?us-ascii?Q?QdqmVf5pMrFpbt63qAdxJc9kOeG3R6cajtk342n1m9uwnm2KUZRsvf3RQ7/i?=
 =?us-ascii?Q?x3WQ3MccFVtXPu5Z3pZIyunpZZawW49U2QDH30Ycest0jmbNQaVsbJq2Ia+D?=
 =?us-ascii?Q?pR0Ee4YXn6t9xXoe4ADoErnpA+FxWb9Kr2MWKz+D61+KpjiR8EzKtnCCMyn4?=
 =?us-ascii?Q?LmC53uYIgX1cFhBK7aIsLpCIQ2bfhoL6dlT5AQbC8v+TuK3SqsFUJKqponfF?=
 =?us-ascii?Q?tDuKC9Ef5fZE6Df4A/4shFq0gbaHEl1yvIzWrjwUnVxxKvwD8wSVrAKnsXFw?=
 =?us-ascii?Q?CFofZIDloUvZyBqI8enVoClE4+j9MwCuR+Oa16jkfLZ4bn2FBTf8WxEOI02S?=
 =?us-ascii?Q?Y+guunAa5uVYy9tga2qAqlfUIufMAAuE8WN/fkiAuwYH3vtmCECTxnSMXq6U?=
 =?us-ascii?Q?kx5HU0kebNO+21GAyyeV0DtJf36seV5JsN2e59z3NWD/8AaS4ClbCNTabQJJ?=
 =?us-ascii?Q?Elh6H2flNvfGYqstU8KHQkz0qLA74sWVqJQVfHpBiDvzxaZ1Y2T6MnCFIfaO?=
 =?us-ascii?Q?WMlvNZc+ZQx1mNqbndbehM98/GSWD4EFilFKhV+sOw99VdgusbQbyJujF31c?=
 =?us-ascii?Q?WYBiuzqRz+hORBhYosb2Z5EJXYZuKqC7sNYVjYu4fKjrJDnoZNI5LZUtSMw0?=
 =?us-ascii?Q?ZGn8auIfjxUY4wdB/23/I+1Hm83gTWvoQJAzbH9XjnlrtmbpJzDnUCTMfAEO?=
 =?us-ascii?Q?wbKXkby/GoDGQEDRb3UNoSXhWlRwT3e/qw+MUvUpP1cUufM7tJMr1e9tejm1?=
 =?us-ascii?Q?08sXvR6DCOE+RxkJqdwclON4BK+3BqLK9ztgoVzV/QI+n1qpw/iOfNBSUfEi?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31570f44-8815-4824-80f7-08dcf275b299
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:44:10.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KduZDVeG8o1ij6ie4xqdRKuFT2c+mOwYAhR+AQU73HbfYAd/Xwvi2kFCUEdB6+atRuwk5dnPZjAJYCElUGGdaF3MmzYmzLjieXTH41a0BCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5562

If driver fails to set the device to suspend, it means that the
device is abnormal. In this case, reset the device to recover
when PCIe device is offline.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
V2:
 * Add judgment, reset when device is offline 
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..4f89a353588b 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
 	iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + ENABLE_ASPM_LOWPWR);
 	atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
 	t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
+	if (pci_channel_offline(pdev)) {
+		dev_err(&pdev->dev, "Device offline, reset to recover\n");
+		t7xx_reset_device(t7xx_dev, PLDR);
+	}
 	return ret;
 }
 
-- 
2.34.1


