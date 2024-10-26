Return-Path: <netdev+bounces-139308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9709B1670
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 11:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F251D1F2236C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C261D0E3A;
	Sat, 26 Oct 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="s8mNrATX"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2129.outbound.protection.outlook.com [40.107.215.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB41CDFB8;
	Sat, 26 Oct 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729933797; cv=fail; b=oSUdN25O3kZfm6MxA8caMIfjE34/+UOh2duRCyf7PLeDm0+GPAJ1R6kkYMdj38ZT8ZvZbCCnR0PU44/qSi9ZUMEhSJLYbBzlQ5X6hfWC/cMYOHq9YGH4s7pyPuqIFTwCjg5nya2UZRte1QXYw8E6rNxYnQ0BhH4HM5XbrOWvUaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729933797; c=relaxed/simple;
	bh=ANwIFQh1XNwk2S1cnVw6cdFCKkdtgK7BB/BXHeX34iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTJAhvlIsQSlFHLFumq7zv4uo0IsyReRfD/Z/iLorQlaxcftf8eow4HeSmzQbpNLP1XHjhFTccoezbUTJShfRv0viGS6GM0Wcre4ta2ZPja/X/S2SGOIeNvRohFjFeKc/V1yt4TiTupGRB7SnLvxko9ERDMZX2Q2P5FGipSSkD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=s8mNrATX; arc=fail smtp.client-ip=40.107.215.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCXJz4+gNErGrMTtjA2x1zFZbQJVSKB12+dnGDthRDmTnfcOLB3P5avGjTLl2fKuF3l6Fs9HQAQabncGDjmlZlnLdDy6w9mFdDrZU/7X04fSFbY+pgEiIVaR3/dIMZ8PTOmaG7d4bBKtpUZd4/uard2/MgFQX2sEvLO1jCgpigDssyBop4RymcGaRDuzPUEMtUoloWm4/7lBPoMpRimR1ghxI2rePRjNSCMSddCs9UudJIWZybsDKVHYSrPdgThWF7SzlT+MxfioKaMKTkWGwI3K4fUTmuomb5c1sdsh9FciSQMRxaHp6fZcof8KKzw2adtcfbWMdbtHqn/9kGRgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CVB7DGPsHwnsQCoXB7SBZjklEmEnihl9vo2LqNcsog=;
 b=kNJfnGfDeTIsMMKmWdpbdZqB9qAPXHkKcg4GVFp8gZkFF69naM0pyAGwNtaoLE/eqha5zM72uyFG5xHVU0tgx9GK9bfg1XUNlgPMfUIuQQYcIMKBULWVVR3NMGRZbfsnjIheRwBUZtswe8j1cj1lDdtuBOJxH5kvNsmkpC81dh3QTeyM9Wxu9hsDsb8i/SB37AZXYBbfT7DxMInzDBnvuuq+seylIjjGgA8cDIZ5C/fqe+R1nD9T5rVGMFkiSAFiIy+2BvsLB5T/mPHKmb8PpJ1TE0bjEe6bL9RI+ueGHIavFBtOYHDuIDyT8nLIPfM9QLps6W0ible0VMK8ILcb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CVB7DGPsHwnsQCoXB7SBZjklEmEnihl9vo2LqNcsog=;
 b=s8mNrATXjk/zZkYXAjsrryB2krhrWC5de2M8PRQJ9mwdYB0uozBcAGGerEEW4ZJ1zOHfsCQfIe4x89HIgq/FmHegB940DtE8/QF3BttszxBvBCwcjML+UmkgzsD9+TXDYZ0KazrRTASrPvnxdat4h4+09fimwRRZRBKV4cogJa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB5864.apcprd02.prod.outlook.com (2603:1096:101:73::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Sat, 26 Oct
 2024 09:09:49 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8093.018; Sat, 26 Oct 2024
 09:09:49 +0000
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
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v7 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Sat, 26 Oct 2024 17:09:20 +0800
Message-Id: <20241026090921.8008-2-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241026090921.8008-1-jinjian.song@fibocom.com>
References: <20241026090921.8008-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 915198c9-c44c-45f6-da2a-08dcf59df185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+c6l/jxl7NYaw5AU53/xRYzdwn6u5WSHDCqUI4LnUWMexIDF1BH3o4t28Uqf?=
 =?us-ascii?Q?xTuMWlezHbt2rTCzTo4/1uFjg8ZNMAJta9ZuHcd8NvJo0Dm+wduTDvfF6TEx?=
 =?us-ascii?Q?ltOz73abh+uXgjAZoYRZT9O8VVdrhfgLUuIt9lHRDmkiMGbZ7GuPCQezb3J9?=
 =?us-ascii?Q?ZKj026Ucw+DTnYJShU8x7OlMMSWCZYGklPPnLeiC6oDO7X0thOSfeHtAO89T?=
 =?us-ascii?Q?wy/sacXWIISqdq5pt0wjvORMjfVzz8sL6bKr5OVOmgLhGwZqtxOOz8wzFrgd?=
 =?us-ascii?Q?RRCX78oq9myPBzyDLMWQYLSRhJwJpUguv4qVUOgdwZ+dv8QCG5z1HrxDQU9i?=
 =?us-ascii?Q?3d/amK1gIIhOU03WGAsO+qIXsvt4OGcHtBd5fLw2EBVNG/U+oXacoDYOLzBs?=
 =?us-ascii?Q?yiORqO9DWC8xeq4oGdQjZIy2mBU0QQzyyBpBUZB8tsY+gb5RsGxX11vf2IxL?=
 =?us-ascii?Q?UcCdyeMf2HaU3GzcUV6XiBr+jV92XB7Ge7OaQARaV34fxHU8FE89PqSwZWRr?=
 =?us-ascii?Q?JlkXGjzyaQKz0ztBM7oPnynFdUn9gapMp9zmgM3gDQ2LI06ZBM0yfu2hNguj?=
 =?us-ascii?Q?ILIPRD5m60zUaKphaSo+PZ/pfHF3A2x/a+/YuOKHQhuygejQeA3FNiSMmS/+?=
 =?us-ascii?Q?ue618/hf0LPXNhAqvr0tyX0c63EaZmDRjC0jtKJ0UZYJSaUGXuO6I64WBGse?=
 =?us-ascii?Q?44mTUN58BcRfJmhy8rLB6Uv183F7DvjW0trAJUkGZHkFJXm5/NJMAWYNUFES?=
 =?us-ascii?Q?gqRqSQDR5kaKDv2s+Y8GLh5GoHJYrr17oTFn0iqnuxNhz3Jwxoqvwyy74BR8?=
 =?us-ascii?Q?0k8xZI1w0TAZnGH6K/Wkd4VkBIQMtbR/3xa/J0xmVuWw1UTs+5CUb/upzyoz?=
 =?us-ascii?Q?a/H0q2+RVAU8ExpHym7/XQPs9okUKTftXDaGDr8fmvtlRse3WEjS9f1bB0Nh?=
 =?us-ascii?Q?tJSQwuH3jq8qruR0L4Fp18YbA1WXqG791AP5pmi3AVTbaH9onB5GwSF/xcpA?=
 =?us-ascii?Q?h1tR7Jamsj+6xiv2efSgPCu3Zzx7EG+Wi22+PXjV3T0254OZhThIE007ZVAJ?=
 =?us-ascii?Q?y7yke5owXKsIGIKbDAiTe0+O67cy7itfs6oGO6+EfEEDaMCzSwZftQ6Nw40m?=
 =?us-ascii?Q?et7VDzADkzwxdxP0WmAQpgcleBzFZXDH9almZkiQXXcwizOVulRx5l8Fj8IV?=
 =?us-ascii?Q?vTZ0Yo6KqwajABlMD8hkQJ9dZD8lNLJ23SjzKNqj1TRT+J8Sw8S+5OZf+inm?=
 =?us-ascii?Q?kf6I+z/ju1PNpp9mvYm/MSKbDWFTe6J+hZMqQ0UNu+i9wC1BdnwGU+mWG/Re?=
 =?us-ascii?Q?DG3Zt3Qku6gOn274BkP+6q5O4q3p9qKSd8H5VUUdVfNaQedf2BEZq7oCcWa0?=
 =?us-ascii?Q?ErB9lebYtUHbIx/xfdDIlzhyetY3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jK55PTZNGOnY/1iyymzPOKzSYcVbOnYiqRlUQKKmzSv8TKs+D5ZoD6Pom6oY?=
 =?us-ascii?Q?Y8fKL5B/Knbtvj0hkKf2CCuhxvn2Ig9BUv1rZWNJE83Zwo1qZRCAfq5Vm76E?=
 =?us-ascii?Q?+g3tH1HBeeJblC5xdWAKqn12bTStN+RUxGRRxQITlzu4uHcA68P1sjtQx41R?=
 =?us-ascii?Q?gtOJR0urg/E+ZSAVv7H1AKn0G8zkwQo3s+AWt9Wrf/SN9BJ2w1oB5E/6jkDs?=
 =?us-ascii?Q?o48szgVTFXqHEGbhhy+YnXk9dNNFglzSQfPEaYRvjLpnGLhACq8xnQr51dON?=
 =?us-ascii?Q?/WiPYsVsGgDPegrV9bBMbQRrcUEXlmFIlHc6soPMa6j+5F8+h604grgXxZub?=
 =?us-ascii?Q?uE/0BveEcUhy083ngaAG0Y8Pr/hccATKHGOPlsJWRDtjoH6zH+jz1hsZZL+r?=
 =?us-ascii?Q?+c/ARIqA+3/jH/HTdE75wJvltmNdVcOiN2B8MkHK70VauwNOFjDxfArRzhuL?=
 =?us-ascii?Q?YDMWygwxVTPXADIrKatTconk9LN5IlM0TNuE2jPUA9Ujae5MXno0LVBkCXtq?=
 =?us-ascii?Q?acX9gPVcjwWJBCnQ5a3APhrebfQaKRltazbgah+YXU+aWOLliAtic8cg2w0y?=
 =?us-ascii?Q?axg7aJnVTIdQcwirupT94DceOFr55hcKZyy+k9WZ/MIJ1mcQhDRWDqSn0qse?=
 =?us-ascii?Q?rGvo2kGO4IycH536kKbtl51LmJEs4ATp/wrLyQgdGwpn+mshWdQrytY0GcAy?=
 =?us-ascii?Q?/49TKa6vuiwcuJdzTaSn77JV8KnEAZkCRpXZs8GlhOPP17F5e4R+/skq3s1f?=
 =?us-ascii?Q?bm/hngE7G3EmaTZgNZeWsV/MC9H3n/5G/Lw4YlH/ex89CN2p0GDhl4tfOeps?=
 =?us-ascii?Q?EhnKYTamGNqiMvFKsd04OLxEhYOgV8aHSzYNeHf4u9DzZqbKvGLZ8PAjNz49?=
 =?us-ascii?Q?4qt4Sri2dgVfGAXUwOcbbUgy6aUlENoW/q2rDpnWnF2D8xrCzHGBYYjYzd2R?=
 =?us-ascii?Q?21SVQVIDL3LM0+ro23f8I3134twFe1J/J7xlFIGLXvH8vKbFV2iVLcgEzsBB?=
 =?us-ascii?Q?rqOl3q63PSwYQJZxBqgI0LzfOOL5CsTvdIikTtXySfJ5aU6p5MTp6M3knRRs?=
 =?us-ascii?Q?N8q5EH2txJ9rygYug+xnfal61QRDlLhJPcGnj+SbXw+l1efNfX8NBk6p/c/e?=
 =?us-ascii?Q?MhCnZ11mUzNcl7u7/lNZ0agol6U7N7wrD8Y9LMUU+jRwySlj1XpQw0BLqWQz?=
 =?us-ascii?Q?hd11Vq8DeCFUvXB58wRZvtT5nlYvxxlOUTA7B0o98AtGD3gEZGaQBRRjV5qS?=
 =?us-ascii?Q?Qs3cJq/ekn/4gqtsfHXea13OjUtnnancz2jfBdFKlCg5qTvfkWBUqDZy0LJ3?=
 =?us-ascii?Q?0wHu4cUB93zk6zc3/JjgxZQWLAT2Hpn0lMlZLz6vzdGXpc90a1wei/w0Dd3A?=
 =?us-ascii?Q?ZDs7OMhC/oYEuH5LLoGim2kd7E5vynkwQRHhV16bgrREvbyjP9yBpDZ0NqjS?=
 =?us-ascii?Q?OYsURvK71K1039fO5qIg0pRDs5zu4rAdDj0nMfby72xQKsyY7e3/OK19vFqW?=
 =?us-ascii?Q?fq1LUdY1UgI8eFoBrZjY/ogmrFWa+xyB4cOVavD8DmTGCLwLCSN4AviT9DAF?=
 =?us-ascii?Q?VRfKxPjbQpwhR2dGulBRvyEgiBaT1HqwGrd/L+y1pvUspZOaR77/09VY1b/0?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915198c9-c44c-45f6-da2a-08dcf59df185
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 09:09:49.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtmjRcFsBN5lDuEwQFEME3T8nPTMyEsXWnhL3aWlYqPr84rWapOZNhcXcF0s4wHjga+3gRIDESWxC+PMZqgrXZvDsKaCSCFUpvZAusp+TB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5864

Add new WWAN ports that connect to the device's ADB protocol interface
and MTK MIPC diagnostic interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 8 ++++++++
 include/linux/wwan.h         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..5ffa70d5de85 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -334,6 +334,14 @@ static const struct {
 		.name = "FASTBOOT",
 		.devsuf = "fastboot",
 	},
+	[WWAN_PORT_ADB] = {
+		.name = "ADB",
+		.devsuf = "adb",
+	},
+	[WWAN_PORT_MIPC] = {
+		.name = "MIPC",
+		.devsuf = "mipc",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 170fdee6339c..79c781875c09 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -17,6 +17,8 @@
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
+ * @WWAN_PORT_ADB: ADB protocol control
+ * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -30,6 +32,8 @@ enum wwan_port_type {
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
 	WWAN_PORT_FASTBOOT,
+	WWAN_PORT_ADB,
+	WWAN_PORT_MIPC,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


