Return-Path: <netdev+bounces-110090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76F92AF0B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4FD1C22042
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9912F375;
	Tue,  9 Jul 2024 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="YYcsdmD6"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7F12E1E9;
	Tue,  9 Jul 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499058; cv=fail; b=oRaqMm+ovOzqGAbL3aO48TtVBUD1FYz9Kz6/L6UBfZWWiZR20F2l9EcnHbgb3T5iQb4EcxkyAA2bcKLpvDlSoBFZx4o8XN/XxdLRbeG+3U2zewqXfF1HqbH/RVEoSxboqrfYcumeW0kwmN239+jLaQXE1mq6ITgcJNjLw0RsbMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499058; c=relaxed/simple;
	bh=3zfuP1sv4iUvvExyRqIChypttB/Fw5J2yKi9/EXQgTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3Fq7sh6XomCaQLUwDkqZrvEHUgHWdX0JGqucaCj6ppvVfBzf+eEGLhbdI1h1j/LatatUueSZX9TtWW6/8KWVizz7kAwrUdwpdM0MtVTPqkhq3oQfSZ0IGQWGhjWtXAochLXY8IYC+b5bvUBlbJacsts5vDKIPdM8niJytYjsdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=YYcsdmD6; arc=fail smtp.client-ip=40.107.215.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOJWt773G+iR8FewErF1v1EXRkKzH92pPXilyz80eRes07+aBq4vWWpZTs7LvA4flaAfmT8n6oz689hBPXWczy4rYGmF4FLZ4JuxTNYKYQ2T7SB2ck5hkC/UmU+pL5kZfdYqArMTNj/JZ4QrBnw+ttjjq0HDlrVu5xbzW8V8G9bSMQ/vIXbwi29DM7y4F9+oCv+wZwv4iYsqm4MP+rzw/5qhwBuuDEjASqg3BzNvZeNYq1vMaUYTbbvmn+iikiQbE/M8ypEOLWF42gQzaKvZ5jiOkt1oFWWiLL13fDhCo7XvcYwwFBNKna1QiNx9ENtXSMVU/08QiHk1mW2fR/fvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duN7N9TURc9wnKlLcQJnw5LloNUvtgiA3EKnROioOoY=;
 b=JwGiAEDW+7WZx4RgQKcnlCxt0TbQUPUHSTkMwNy2KxqMNePVJVTdvI1ea71r1jM7YdF9f9IRvOVNfiz2qGx1Ea8H8lQLyOnINU6DFsk5FqfBNduSyBatx4j9K1xoDOUKtewWDpvC9XPtMJ6e6j/RTEmwr0jVzhj7NUng1TXlATVOGeXnRU8qihXOZZplPF6q+92i4LvAPRKKDBQZKDqR+AktHvU5KdSWNhH3IswuU998mXLG5abQOpLx3hJiDRVBL6kdzs7kPi3Yjl9SJtRAXRpx1B1QsRGU4sku+IaDvy8cRTPS4b6GrgcfwysblzDALub7GxsDUNd0J+COPs4KQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duN7N9TURc9wnKlLcQJnw5LloNUvtgiA3EKnROioOoY=;
 b=YYcsdmD6YgxtcsIUpeqEIOOIPjRvm3Vaf8TKtIIw4j3mWL/8R4c1CARApM0EVMoTFWkKk33W/QZwLj86o7ufKnaxrUAmQerYBkqcqJizS1MP7ByVzpaxSaTxFhQN4uD93zfowmv/YxX2B2zAh50ALLKJh58XKuhu/pfBYccSJHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEZPR02MB7365.apcprd02.prod.outlook.com (2603:1096:101:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 04:24:13 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:24:12 +0000
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
	inux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 RESEND 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Tue,  9 Jul 2024 12:23:40 +0800
Message-Id: <20240709042341.23180-2-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709042341.23180-1-jinjian.song@fibocom.com>
References: <20240709042341.23180-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEZPR02MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 288e9f2a-c0a3-464b-4932-08dc9fcefc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TOhAkr9eMy8349453xleh6bT/EbZDClyRsk6PWtsFSl5R+vgwX294qU+5t5B?=
 =?us-ascii?Q?ycYSTEPO8SQAMYFIKqKnc0SpSW3WhXjU6opoxUkznaxzz+N1GeQ6L7i42Cy0?=
 =?us-ascii?Q?2S4k2YnS+RhzFONX7aaNwhnm4rQB+eCbDxq+4C8ZkZu+v8cq+sgLmKTG3qTd?=
 =?us-ascii?Q?qAq3JCs4sGK0pL3jHXuKDE1NxMO/6wgPVbaJm704l+Tzwwc0jlJowJJLqpOk?=
 =?us-ascii?Q?+abPMBnK38m6EUAmXwxefocke8AwRvHQVJWnbYvyoxvqQN+DKwJT+urugRxf?=
 =?us-ascii?Q?0E+GOWSwJgRpxuMzxG8pJFY3tLFGjXTX2yQ/8+NmgioMBFlCIiO8bL0KVK79?=
 =?us-ascii?Q?az/zuofgzmp4MxEmVnzZCD3e5u2RSkAc44aUkAI19ske/P1I8yJfoaRAg+K/?=
 =?us-ascii?Q?TEjM1RJHRN41mNRBmordwLTKKQGhkoBm6GdaCXft+yOJP429AHY8HLR/D3en?=
 =?us-ascii?Q?nsaLCulD/AtAHinbvoVJNk40+EPsnfERIHL4wb7LOCffWn9J+X62xivIaNC+?=
 =?us-ascii?Q?Omk63uw28dEaDCnI5O1oDQ0Y6M3z3zMZzBO/pDg0uw1EH6xsnB5o5sv2qb1v?=
 =?us-ascii?Q?6oy8gfFNobTb+C55JJCuhzh5eja0GcGaKPNSCg3meijaLYIGpemjRa17k1Ne?=
 =?us-ascii?Q?xjXxa/Y2L1AUC4iE+ENkAOIc4ne6QIr0cNiTNjzkJy6kjnGPL0/epAWmFts9?=
 =?us-ascii?Q?XCgugoXFgi2qrqdl0mt47hKG8yvNXkX5gKa2lHTK6wyTDxr87T7sXjw/+PEo?=
 =?us-ascii?Q?xPUm/2+aY6fpi3TX6ukwsnij8DYjaCcMFWk0LbhGVNDZYte7diAjwHACzoOO?=
 =?us-ascii?Q?70mH08tLx8jdBgaWxNVuxm+exGJwvbKtJLKrWQxJdF+ZFQDoWXfBPhq0vTwT?=
 =?us-ascii?Q?ms78hx3crAlH4A2yGKA74hckJSjHSz33Lc20ChNZA+tbLaHajAR92qKpQM8s?=
 =?us-ascii?Q?qTGano9WR3ZAvfPFWeoY4KkDV1iF814/ljK9Iov1J9X4/31LU3U5qlBmGlvH?=
 =?us-ascii?Q?U3wzXoPuVaYA7vHZ+WJeF1xTPNi+gliWSwQSmaqIxtgJ9X2Qy5iH50tIV170?=
 =?us-ascii?Q?l8d2DOiTF5XwBQoEhH9PclBJBm5vx3wuA6ffAqmxW/wBojOwCHaxJhEutupC?=
 =?us-ascii?Q?Z3HqBD9hhnPsiYA2MjQaV2C5fqn0+bGfRoJKl665HXAUuexyNNWISP8mOSwe?=
 =?us-ascii?Q?MjFFT4Dz6CXLqVJArtoCHTLS3APv7SfiYAFngVPcHBa9H4YRcwFVZLDRzIm/?=
 =?us-ascii?Q?Cas47THS7WvEUIay/Ac5n3YjKUvwfjcGk8oqLMOuqxcNtMBNnB9fFFCU8p9A?=
 =?us-ascii?Q?yAwRPe4GRLfWosPK3z8DUMumqvXEEgpzVWam5uKykJuuVl0W0wMklGggg0RH?=
 =?us-ascii?Q?yrusGpdjo37ku/pAMMusIary2cD1W0T3Dkvjy/cKdqoEoF8S+85kXSi6txXj?=
 =?us-ascii?Q?QJ7FVZfmwKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wTUpv+aaytmDxZ6+rz8PjBMIM2j62NYRm7IbDLec3paQqINN16ZDslzomubW?=
 =?us-ascii?Q?AkFi3ryheDK+n6WIyGVnJcAkDnZl9//V32S0hvE5ZhS2d1NQIIJoSn7A0TRS?=
 =?us-ascii?Q?+I7HPgWX/05hBhjt4PVqMCVJ6hNPGPCVnsFusVzEr9BpLcajXBR1xlHXc94C?=
 =?us-ascii?Q?/wTWbuoF/CfkEyTys+7r5wH9Q8NYtKwBsyK38IB7A+5IZ9PNtkmv/0YCgCSI?=
 =?us-ascii?Q?rBlGjRHKQltHRlMZXXdcjnQwigKQGtG89ah/QNxPSwd9Ec9nipRH/MGf7PPK?=
 =?us-ascii?Q?YQwxgrMc2ASQkN9MuFuC1acrynJQF/8WqZKS8+Dku6KQNP+sN7IGoFt92Ns9?=
 =?us-ascii?Q?kmUPIX8SLkTCvmlO8mESLmAvpCmjQVu+pfr+Pyql4lTFcehBqKCUj1k7fH6F?=
 =?us-ascii?Q?W5WWNlbuA9YJotFeh8/l9Sebldu/3paz03UswJk6JKWZ21Jf2yBMmoJKsX4r?=
 =?us-ascii?Q?sEKXhyUlQNObMdkeP6wKZaDPjXABc5x9qTO56kBXTsC7IRsMZ9DH0g7Xc5Ri?=
 =?us-ascii?Q?EsPFDfAQnEqJy4V1uY82Be6pi+Bi2L5O/xmkd5iG+rtsduEbe6dseChcjpxH?=
 =?us-ascii?Q?PzGXdJO+ErrSD3YBvAzak6L7/+HSfcJToKNhhUq0JKy16Y4GGuQLl4Me9RbO?=
 =?us-ascii?Q?x9p40sod5ZECHhgs78q4S8FWvY49DR++lj6fcOFDfJN7pabZJGWCEg9zdCT6?=
 =?us-ascii?Q?ePwJYUxZgQf0ITZRqw72rixzP/WXDDoDWMc+TxW3gWPecDXZJOH6c5Wufsc2?=
 =?us-ascii?Q?Y7Bh63m03SAeL3m48m67WmMIXlkrx9LSCqdshioKjutRMrbSQN+A/3foiLoa?=
 =?us-ascii?Q?SGg0b1HFzHYagQIdFDQP9O1GRy8o00HcLHltSqJxq9o/95wrD8+UDtDk+amc?=
 =?us-ascii?Q?bTtmLn3QFW93Vhjq0wF/7Xmkqae8vj9fqZatA4J1boRNEQgeteZSXK+4tRvo?=
 =?us-ascii?Q?MGUhajYKBirF66Lv4L3pnG60PWZ0EuSVaCRMPvnZhGt0p8io86EVGz7eTALj?=
 =?us-ascii?Q?RuhIz7FLyPUFC+7fJ+zo7WbYx4yH7iqxY+R+nxzonCemY6SBPKJ+kdl5dp6V?=
 =?us-ascii?Q?vb3yx8v9IOv5D1FUhrLVzNDcn83jWBv7q/zKTFD0pgOniElx0qoxyoPn+DRq?=
 =?us-ascii?Q?+7Ve/UjOA3fIvzlTlytdb0/h/lLCWfYeZmblWgwL4ahv2b42Tk8nQamAT5hK?=
 =?us-ascii?Q?IH3+zINZWt/MmCFz6r+0MH1dDvGgB5SmHu488oXeTxnRHbmn0rjBVYFO9JJy?=
 =?us-ascii?Q?OZ9eDtZC+kRLAETfWZyd5lNrmSmV7XLc4VrKejLJI5o6lagfh4bNGZ8TDAM9?=
 =?us-ascii?Q?Vi9fHTaveFOPkTcbhVKoKnahjSqremSOCHUhn5jGPIM4o3iPHocT1cMjPf20?=
 =?us-ascii?Q?rRegK0K3garrucFAr6DoJawekbTIiz5pofky94AayGu/6KP8OYFxVQV4hSD8?=
 =?us-ascii?Q?at+t9D3PBPOWq70ZMkU/xaFAHMmrFUV9LUD0WyYpwthwRJS08wFS6wMsUe59?=
 =?us-ascii?Q?z9cpTs+KyJaq682D/2Lqy3KcVU5CiKOUF0mOBAhilj/sItIbUi1X1pxBnDPM?=
 =?us-ascii?Q?JLQVCSq1rxKhXxbp1EY58aHgfJsezj+PRLodSle143HVnwa4PM5E4fvyscB+?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288e9f2a-c0a3-464b-4932-08dc9fcefc60
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 04:24:12.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eDK10EY6pMbIoXTgEMziq9HLZfEaEPf5cz6/NKvJuxLCuPmDxuacuSzzQn8XM2KkGFM+M5WjK2qX+kcw19OUE9NQwOkcfAzPC0x6iJt7JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7365

Add new WWAN ports that connect to the device's ADB protocol interface and
MTK MIPC diagnostic interface.

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


