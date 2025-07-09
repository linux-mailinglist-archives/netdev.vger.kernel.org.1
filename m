Return-Path: <netdev+bounces-205232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185EAFDD65
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E355C582ECA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE41FBCB1;
	Wed,  9 Jul 2025 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HoXkhUfJ"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012021.outbound.protection.outlook.com [40.107.75.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FA1A23A0;
	Wed,  9 Jul 2025 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027815; cv=fail; b=smSQlrzvVElZT1ZojCV3AxcnaD1DIzR3u4pQ74pc4eEdTVla88TLj/W2bzxflvcgWSbTxnloi94p7c7uuaibgkg83l3avscLYTkEuOOY8nFvozevIhqDyoAz6uHStMHRJfhmgow2P6zYTK1xf7mwCFAE1tw1eYLLat8pl3HsDQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027815; c=relaxed/simple;
	bh=uWCYp00kqkPIL2OhSzrl1x+MQmWQLv3amJ7F/i16mSU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzKfXvORJp+gdKDmYQ0FVwGdSee1qINaWZd3K5RrIdM1F2Ojr+9b+OrcPxfj/7eRkvXbFk/wJjybPeh48ds4lAiTACsP5mfYx6NJYBS+7gVbQVN/me8L7vc/Tve/ko2FI43gCUY0b8Rjy+Z6Ci4D0/BbnWCO4/9msERq7H3vHhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HoXkhUfJ; arc=fail smtp.client-ip=40.107.75.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmfG0mcou4anuBc2ppzbVS9fZqKv45Do/ghTrK6u+bvJ99yoF2tE97ut4x41tob8FuzirRas0nOLEc/Rpq5vBImlD+qa7svm0G+RbkplJOjuXRhl+FqSy7M38jCjC6sNJd7rFDJe9O6o+dZ8YNhbClrBFTrtfXO4yfmIbs5i2IvJz8RtPaVNEzvHS+dg6fnyrKd/HFfJJ7S79EiPNuNYwiy0IN9pvfxScDf2pxGBjqaXzs9xM+Y/qTTAAKPdkHWSlBKbW7RHpikbOAC2RTCVUy/X9k2syoKu7R6WFMwRq3uiDIzyk9qw9p/onIVFNO1NOb4rfpJYJQEYdjzaq4SmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75/ZZI17eCJmeascglv2wdbld7FMsi05h5Fi3PdpV90=;
 b=kWr/nUFiBpmqnrJP2kOA99CVknfQgIOPItc1eJ8mL73U41rvvzHehlzIruu3O64wZykPy7YQ5Qj9zU1ZrtT/g4q0mZKrhH5GxwtpsdMFtAurmJVq0gAHr/Nl6kJlMqWSEPcfhJzUUsU5ak/sG4qgV2zt9dgXdH1LdjZIRuAFbaa5ISocam8kumInhmtz2XXgvR0xZ1z9qpu/y/iC62DLq7inQWlwI2d63N8/ztD26vAZZ99jrbso4Di+/Z5rD0m3u5us+he6jMCsbBYwhYxS/JGxLOQZB/Q31DT4aX8EXgxK2fzRU7uW2Lu7Xw+x8FJe+8CA9j4OGIqiODK0rz82GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/ZZI17eCJmeascglv2wdbld7FMsi05h5Fi3PdpV90=;
 b=HoXkhUfJU++8QlRWbmknNMB7e7a6dTnEyK6NP8p9PU/421Wk6NruxHuQwVJq1qD8uv9yPf5Wagb6fbVF9vLeZkBiw3guCgig7GEskt2rAOnhhy0tNCaUYKER4dYG1GVkJpi9g1BeIjy3dC1MsqzjcjE3Lq/NGf8YdFmJUBE+k/SQ+wnmXsQRIQc5VsmXa+T1IUzYjkadsGUu2g+zz78hXkeeWSJOxO5MKGCA+UFksn9i/+IyuicnSSC57Mnmk5Dl2+nsew6SH1U2WMli5Kp4gsT5ZzSIjRyDZB85gpy0exAtgj4Ex8xqnW9po5+H1HHviNDfg1I+wSbvBBxhliQlOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:31 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:31 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Eric Biggers <ebiggers@google.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Lucas Sanchez Sagrado <lucsansag@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Philipp Hahn <phahn-oss@avm.de>,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/12] net: usb: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:34 +0800
Message-Id: <20250709022210.304030-7-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a41971-00f8-476f-565a-08ddbe8f9919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ovkZIrM9LzULA+Nr5Qm3+QaJp+jSl3MpsE9ezk1wvvkgnK9hdgmN0DE/20B9?=
 =?us-ascii?Q?n3XduZjE/cvmMzhDPSIfhRLdvk2k5RFRWjIbUt2wPp/0ehuuJCtV5ND3rR/F?=
 =?us-ascii?Q?ajOATo8Aw4cUyMaVuquiGIlN1qac+FRCacAJr6NxRa6BJogu1OL+YYcuZeO0?=
 =?us-ascii?Q?9UsFaqVsQByH0L5KIea7Zv3ccl8ivth8KeMhs6pCfjvmxR6MzwIYcXKg+2Js?=
 =?us-ascii?Q?EYMdPmSbbBJRIol3jQQuQV2aiEEwYgD7LyE9m4kR8QVpEb+/Ac4V+NedpRl3?=
 =?us-ascii?Q?j+TsSeNbyNmLTj7EMzkqDOYE0LbQkD2ZbJXVJY4PNUQdgH9zQnxUcI588+tg?=
 =?us-ascii?Q?JSFwSpz45Y0WUwRD44yX+s9aSJj12AtkgWsyE8fSbMH2RdRtj43SmlqoMdgu?=
 =?us-ascii?Q?eZKEBKbx6e13hN4TYx5L3sBfvww+qL7dbKmIYVTl5/hHT7kgVC6tdyqiWxHf?=
 =?us-ascii?Q?A0HLRbTlxGJPh9vr47DJa42KTVlDXKmvFkQwhsk+qipaJl9PgjZE4aj3+DVD?=
 =?us-ascii?Q?thLNdvI+oEOvcEcpCa9ks2cU7hZac/o6HgrbalJUT+yF3VUQl8PmCuAsr8V5?=
 =?us-ascii?Q?oj9ay1kDDbMWBuSD7MmmNaE6Z/tWE7QgZXd+2EsB9G1h2Ku6MC9HborgA3HW?=
 =?us-ascii?Q?mL9vUcpMhznHc6xteHCPfHaf5HGHg40KDYHDtNH3LrCWKXpx51vc1D57tZ0P?=
 =?us-ascii?Q?z2iQgR+t29GjzYwdUJLSmckBWjuKuKd+mVc0fLTpNws9F2kKdhinnzvUTKEj?=
 =?us-ascii?Q?cwHwBMjM2anehbcDUqfceezBGAWQLSp4oVJ8W+C67x2FpHzGcGbd8/dUQ1H7?=
 =?us-ascii?Q?1cVmvwZhU/gM8KWieHVicv/NDzHEMdGfi8N4s75vO8nZNAiwFIJI/gLgeIDF?=
 =?us-ascii?Q?KMY4zul7aE/H/uYIqEnci4QABauuPWwZMg0OfWrdas6kZ/QJ8Z0u4sq5xAV9?=
 =?us-ascii?Q?Z/gChijjkXya5j93vF0Xc4lxkr2SQJsruUDWYWdGeLCjTvC/zJ/LT3H0LFGi?=
 =?us-ascii?Q?CzxuMBMDUlTYqB3wh23YhEoLBeghKoVar6sDUwNxpEq898EP4EXdu8bL+7vL?=
 =?us-ascii?Q?2yyQ+fRUGxFzH+ai/atHfqT/vrLvbs8Pq6xve5LYsh3vhTiQoTW/lxrm93xv?=
 =?us-ascii?Q?Gx8yISiDBJSULAZbsniYDfhfFiVKKDlpVSektv4dT9BFySdu83d2f/k+IDuu?=
 =?us-ascii?Q?L28LjEgRaLZDoOmVycP6ZDR8DdjaUDiAG+BMJdUkSIC7VnMAsM/EfQZFtcp3?=
 =?us-ascii?Q?bvb/v8uU26NKr1/VIsbhf8xFVKh6z3IwYnf+C06LX1YT09/ZWyLX06oYq1ms?=
 =?us-ascii?Q?uDyhuWf9I6faLKGkiYanjaF0pOaDrUyI3nvPJA6y2rnmd1JdbWXwsbea4GgO?=
 =?us-ascii?Q?/N8W5I7vCOhnZ2+6MdpUvFHYBvDXfLF8iGTJYqHXWJigs9hKyNjZGpQ3KMVc?=
 =?us-ascii?Q?gZwwnJWfSkgPYhxUPjbbIXkFto0aKmG+GaU7hd3ukoUF8eFW1Mof0TPwU9pU?=
 =?us-ascii?Q?KAaLHEt5Rn05yy4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9znEPf05x+SEkuYuEuTOWul//6eWVnAwwxhALrsPfw9kwtEjhA4USC2IR+lK?=
 =?us-ascii?Q?MkQoSoGqfs+4a9UjZyeGlUDYarQcFddff9RrWmWbKpCX00EHhtouVJaufzRW?=
 =?us-ascii?Q?l+FAWjmwMMIe3uPynJIhWh/6Tc6htW27eHE6GN9AIABLQlp9UZ3Gc/SIEZ9D?=
 =?us-ascii?Q?/L1BNw5KS+fLJ5EMIEndw4Cy+TSD6Ple7IClX+5r0hHX1P1OpSKnx2WONZWK?=
 =?us-ascii?Q?nSHuwpZY0WQp2T1uAxs/SmWmwrEjzsV+XFTJlHOIJXUR3o+zo/XCO8zHmZAZ?=
 =?us-ascii?Q?k858rnulYX2OWlSEnDiixzwM9NNPHuva4NltmMNEsZJd62knO1rlAqjEyAy4?=
 =?us-ascii?Q?D6ic4XMwc1qfri2AZvcOdRfD1OfpkEvh4D9N7ef1rbNKXmLGaZaqHnd8ct5z?=
 =?us-ascii?Q?Zi3OAgTojRPG42ZB410/j0XknefRb+VGS+Vs0lr4dAv4+A0E/UBWHxjDEHjd?=
 =?us-ascii?Q?jfzwXn4M3f4iY2E0CGxsmzfSdsAw8W0b1cxF40SfFO6a7gE5X/eCB20eu0hC?=
 =?us-ascii?Q?If8bFvyC9hUzJ/MJvyPiAJQrISWDHr0EykktVS0tJhEelNmOH4C8IsCnXVeT?=
 =?us-ascii?Q?Aq7k+x5G/WbMaeTtQvMRV482m6RSbfa0YIVs69GL6GDWp/AsZlDG1IXc664P?=
 =?us-ascii?Q?pHtIccFdwFVmDaGG+nWke6UXnYnobNOEarpe0f57WJnEnjUndSi5XrBSMj9K?=
 =?us-ascii?Q?S5+gWxVm1QcJYxwBKeTTNomhaekCRvL2gSKPVMWzJdwKExhuNhieTpDckXit?=
 =?us-ascii?Q?iMbc/2ZwOEET4JoWKh0dSgSKrDt4RO9NfLIynWcQCzUMHedMdveJPjfJrtsJ?=
 =?us-ascii?Q?mFxEnyVuMLCrDGhVH3sq3pi9gSRSAE7qQY/0NjcT7FM/By/PKQmvVpifxIvo?=
 =?us-ascii?Q?IyCBNzdEQa92tvMDX1ERnCrQ40yxZCSQ4s6O9UqzfFVwMgggp6gn9Sip5M+h?=
 =?us-ascii?Q?PLZlKx9bV7ESLxfljCocZVJI7KbU9Kc78xcncziptOLpC5as4sjHvvIv3Vus?=
 =?us-ascii?Q?niLEG00rySydOhE9bww1vxCjfsGJI6/+R7nHEcAO3oyTtwZBLX2prHT686tr?=
 =?us-ascii?Q?OCscl08c/xuhNJ3krV6CspWOzl+WtD6/5DhTxAlGmelAkLV3htkXnSzEdqBC?=
 =?us-ascii?Q?iPSgTC65JwGpbmih1yZuC+/2gyUxKy/L+Tb5zn4DNFDILptXnU0Zk/lC5NWa?=
 =?us-ascii?Q?orfwQiay76/VhWcGYBvtb2YoN1EwDGVa2udi4wcVZPTlk0ODGXC8+Zy2/IGT?=
 =?us-ascii?Q?XzUjIB0xC+j76NCO/y876VQXvOLg3Wfw7BbC7FWUN2E5NXqvO0xVPKiKs+Kd?=
 =?us-ascii?Q?FX2vq83j++eQX3PZ5hDJsb1z+2bkHdbtDo/P04/hXwYqVHOHJJYmpjXgSQ5w?=
 =?us-ascii?Q?wLRdE3HHrqv+wlBZF7UV3WseWJYYAAA2GXY98+QBXwBhHPgMwrKKuiegRR+8?=
 =?us-ascii?Q?UvMLgoRXcst5fjz/XGer2Z2CfReNWJsCi6+3mXcEYDfhfPKJB1aabWzFT6QA?=
 =?us-ascii?Q?Ju/iS3UiJLP3rxLEyUydQHhVQ/7ifgiW2JnwYFTKJqoEoyjNpkuq/h4/gFmS?=
 =?us-ascii?Q?w4LZ1nasRU018g8zh1wNiTCuxF4+XBSEnFCLaFCt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a41971-00f8-476f-565a-08ddbe8f9919
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:31.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5FcgEV7zM7bWyYVh6+LYjRNeTFNF+v+aCf84OQ9RrsRT7lfUXPVrqIElxTDvop/JYG2oHQegE/2lGxkEnvtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/usb/r8152.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d..c81a43da914a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4949,10 +4949,7 @@ static void rtl_ram_code_speed_up(struct r8152 *tp, struct fw_phy_speed_up *phy,
 		u32 ocp_data, size;
 		int i;
 
-		if (len < 2048)
-			size = len;
-		else
-			size = 2048;
+		size = min(len, 2048);
 
 		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL);
 		ocp_data |= GPHY_PATCH_DONE | BACKUP_RESTRORE;
-- 
2.34.1


