Return-Path: <netdev+bounces-146443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFAF9D372F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DDA1F21DC7
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AE199938;
	Wed, 20 Nov 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quectel.com header.i=@quectel.com header.b="Ra6oC/Ko"
X-Original-To: netdev@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020074.outbound.protection.outlook.com [52.101.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C661187844;
	Wed, 20 Nov 2024 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095572; cv=fail; b=obI5PCwFaD/WI9RXdjS0lh7Um0uovy2fo5dfSfHk3M1O7BaZKHHorbhM/Fb5aH1536wOuT5a+qr74L/A6DCyDgCfhKTrHbRR0zMVyrF6iCgN5H2RJ9wsvJboKjD793eg+MlB7f/andJFazUYFerMkOTow++brLAzPJEhamSsu64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095572; c=relaxed/simple;
	bh=ICnf4U3rcI2XSJpKYsdtl6dcTQRzfjBOMCjbDUuLSE0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lr53ut/tzytAfuZd98u9VmEh29ILF+7FNG/mQViJ+AO1gBH8YG9cUKJu8ZnMH6wMjfy5bJ0oi4jRVNHMo73r+NzhC/aG9fV60PULpIHz6aHYjRHl03ka/QwW5DJRLG3Ehn3KsrSzON0v82p3Bclx7dPgBS4ug4jmZ69zX5KlRVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quectel.com; spf=pass smtp.mailfrom=quectel.com; dkim=pass (1024-bit key) header.d=quectel.com header.i=@quectel.com header.b=Ra6oC/Ko; arc=fail smtp.client-ip=52.101.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quectel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quectel.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOcKMdmOUFLIF8WPnzOczVV5OWCqhkLM5LoxmUxRoZ+obdyZqXz8j//J0d5o8ImHRBWxTmGQZVBlYu1gCRnHKKw3+vqctKI6w4JDO2Gm4HCNqg5W1F35eW+9LVQpUmMLToAp8ZS8Qf2slj5Bix+LgwQNJmFsB6mxT2KC2wgdRDI3YH32JBZYeOmKqpIvlPxSwsspETrihrt2FmtaSJTbFfp58Z8Jl95tEDw+5Vqk2Z3ztoORhOvKZYDXIdrJJINliBKLCPXFgud3pvsF1UJnBsMhzl+a4MmdrkzZktM+5SsO947MdWBdcO4kouKJtW9i+PDKDioMYDmBUworz0bJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nUgiiCpvR1gQE/ROjt9v+5sTquYr3Qvyli+kAH+YCo=;
 b=mAyTEmiou47nDocpHhsusthlEtsKT2NEhH6B1WAVEMnARcD3SCeIJmOXMNR7oqASvPMR06MYr0paVmSLwsniNgH4gOy7ctDVMJ7R/uQvzwxA3GFDCzjr7TvffifNwTkeD3ZDRUFywV/ophIqa+YvY8+jwj1NX4t2XAXlisP8BWxJOYZe8kRCVmuF9VZTJT7PuTnw4/pMZ7EY08pVfbk+xdTteghZntGK+GtEVAPVRMGm4d/52S76aisZgOIuYdLoriUEAkGwuMsnL+3MZ5eAcMr4skFkOG84UdfjXCUYZG9tY/7IME+g9U9YajDA4AmnMAcmj4tCzLwMGe832wznmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quectel.com; dmarc=pass action=none header.from=quectel.com;
 dkim=pass header.d=quectel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quectel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nUgiiCpvR1gQE/ROjt9v+5sTquYr3Qvyli+kAH+YCo=;
 b=Ra6oC/KoVmdqMy5Hj4rAEBkwZ4QbMks7R31Xm150p8ld13sIBsbbvVv4KQxUE/IVegi0c56wLg9Vr0Tm2oEHn6GNp3+P7jq8DaHsqdlxk3BteSRjiV4ynkdoBH7TK6CdwE27VRLCOPGKWMxstXPSILRdk7nkxTtORA7DCumCLtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quectel.com;
Received: from SG2PR06MB5358.apcprd06.prod.outlook.com (2603:1096:4:1d5::7) by
 JH0PR06MB6704.apcprd06.prod.outlook.com (2603:1096:990:37::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.14; Wed, 20 Nov 2024 09:39:25 +0000
Received: from SG2PR06MB5358.apcprd06.prod.outlook.com
 ([fe80::e711:eea9:af2:b2ab]) by SG2PR06MB5358.apcprd06.prod.outlook.com
 ([fe80::e711:eea9:af2:b2ab%3]) with mapi id 15.20.8182.011; Wed, 20 Nov 2024
 09:39:25 +0000
From: Jerry Meng <jerry.meng.lk@quectel.com>
To: ryazanov.s.a@gmail.com,
	loic.poulain@linaro.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Meng <jerry.meng.lk@quectel.com>
Subject: [PATCH net-next v2] net: wwan: Add WWAN sahara port type
Date: Wed, 20 Nov 2024 17:39:04 +0800
Message-Id: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To SG2PR06MB5358.apcprd06.prod.outlook.com
 (2603:1096:4:1d5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5358:EE_|JH0PR06MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 552840fe-8973-4832-7ed2-08dd0947387e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/izVw6wZJw9qZfQOq1lvqrT8B3DFHYs9gtbEMV9D2XXpHEN4kgsgHps92eE?=
 =?us-ascii?Q?QI72UNzjGNd/upLlzNmluY2p2y53Iummo2pmsmdU9jEZQ6+K7cxYyMVIj+No?=
 =?us-ascii?Q?hLn9oCNW2cmhiOi0MWH6bmhAaNfGvALUgtW39JDqHzpC1NGq/3ixJG+XZQnP?=
 =?us-ascii?Q?/EgX7d0/igELMaLt6T504Mv6YDbxeL2RsdZ2o+JTPP7XHtFUX/xMTEAprg9W?=
 =?us-ascii?Q?DDHXNQsjgLD/Fbmy3I/xhkkrtUVUlEVDKXqXCunNEviNMIKdNUCLJoznm8lr?=
 =?us-ascii?Q?+CtVWQQod5wbxN3P8Ou9tq7WeuCymTrPSDaoi2yux2SWh4JIbzs3Oxx5w+Vj?=
 =?us-ascii?Q?LbRFpwoOUj360QJz451sSUKY6p+sU0o+4PjehBbW9SFJ78xKJcmceRjemZTO?=
 =?us-ascii?Q?zurxN4jfLrWp38gyuR+xWJxf1i01uPWi2WipfJOwmp+t6qBNI3QKeERTwgAw?=
 =?us-ascii?Q?BqrBj7+qJi6Cn3k9Q8h+TReXSzg8zpqxeQ4zvAhDzZpkI5EjVY4lAB0T4zrh?=
 =?us-ascii?Q?SU5on+V5CR7KxBX2d52PVxSaJmOBAZfQRmIokG3zsbgs5rZz1zWCCvwT9ViF?=
 =?us-ascii?Q?nbyh9jPKGHhms7NpS7aH7utV0CXG8rBuq1mwBLNpYn+qh9UP9f3ikDy8dceF?=
 =?us-ascii?Q?ZzGcskJR1aY0ZFc5wlzfpqLhlWxoCyzD2U/b7SDT3bvXDDeWbYQpqMDMvCcL?=
 =?us-ascii?Q?l3VyeuzOv5F+6nQr6zcWK0HeVI+T1taCkcqYuPUcely/0RcgEDgXpfTPrdy4?=
 =?us-ascii?Q?y4c/Z82k0FNTz0EwJt0oE6TLDvT98v4BOrv/vZHSpzkA+e9CSwo6jmzsYPsN?=
 =?us-ascii?Q?38A5zTrNMZF3jcMwvf2b6LB5B7ah+4qNMHkbMy6BUB2zhtmIpqXjAqmcC0KC?=
 =?us-ascii?Q?bCIPeMER5tQMRC/asrONxbnkHUnWvXquZE+GYq7ip5Bd+AheO/flSuzXYuGr?=
 =?us-ascii?Q?hAJNQ5WsqDIPEjZl7J7G85+DYqztfcme/isy/LJLDjwTM69hflrUTpLsgBSq?=
 =?us-ascii?Q?JRmjf5M5Sx3ldDNDqXstt9344vj5V1e8GpqGfSVtNLEPGiwmUQ/rmPL6qN7I?=
 =?us-ascii?Q?fp0VibdyVs5Xqv6XlGX3Iv6vd8WFqCnkXNhTm/Gvo2DKzAMyfYpekqQ6/WPK?=
 =?us-ascii?Q?00p5Hccb58bxzHtPFDx/Jg05LKkNywlroJxMwMdp/Q2fc2xXIakJ+RdhuuPD?=
 =?us-ascii?Q?L0bbfnCGs5LLNoRfajT+kjFO05e3BPd2dF/Mq2lJMMtiRVITlb1qEW66Frex?=
 =?us-ascii?Q?KCMiqkwDGY5iRdHbH1GYIuo5j7YL92e2HYRbV20lzm0AvwK/nRKKrJveVgMt?=
 =?us-ascii?Q?MhMHTz4NBtBPX/Qr0FJbe9qhODqY6uhQCl28LQv9Rr129lmwKcRYo0uPiBSe?=
 =?us-ascii?Q?a5wLS1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5358.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2wUxaOIGKOsISkmbCVWhN4rx7qvMeO5xe0BWIrLQwBKtIqxD4Owu/yY2fsf?=
 =?us-ascii?Q?xS4UESCAQxgh+Jy46liH0rhjdP0bdmjnaRuho9nal3HfshqjFxrgZAc2M+8y?=
 =?us-ascii?Q?zJGmGA0ypMTHtw3SMJUqluAP3xEI76bPPfh+Y3QSB7zRSreQCOfS3NaKupSs?=
 =?us-ascii?Q?pGmlDB0fKyUDJqpuKO0GvBnZIYPaRt/S8l9BhhwtA1IrppB9VO6dnLbCid/Q?=
 =?us-ascii?Q?+DsN8sN8qCXSlIGD+sgtLJ9yj3olpiXys4cWkHikm1Rit3sHlFQx9zEQYRGj?=
 =?us-ascii?Q?BdNMkAKA93U5LdJlVo5hFbbqqhjCKafFqsvtNsYoXIEhVabFvVUPEngaDgkE?=
 =?us-ascii?Q?L3adJ+8opRDK3kP1QWGCCE6fh82m9FZgA8loMAbhB5dWgwRwfXrGG4r5DpTb?=
 =?us-ascii?Q?Iibb22/p+VJJF+sXiZIgDaZ2J77C1LS41k4bGFmW4N96yFuAZ2iFj4r70vjI?=
 =?us-ascii?Q?5bCqjp1kyDZqM4vf3++cujS/9aUPBUrBWD8y7xPH4MAToVxbe8fMdWCh8U/T?=
 =?us-ascii?Q?RLP0ekutzLyxCbCUegKpS9Ac1ucduNm/UNfAGryQk/JzNrernxo6efe13fNh?=
 =?us-ascii?Q?JsG14hAdmI9gJpbf3TbzQWSIYWopx0H4jlKiRK1n0g/tqydVZidKjQfbqbMy?=
 =?us-ascii?Q?CA6+jq7ZYv8Ud4qgWZXBvlIJKPcd3aD0pwlJOOCMBwi7Wv6rab6fnKUsDZ4c?=
 =?us-ascii?Q?t3ZQykP9dnMXYGJ4N9aUGT0BDDXChaHPROnFfIAhPdVmRp5jCY04ojqQrZeP?=
 =?us-ascii?Q?Us93zgwMkr8uTMkR19SIR2H2eRFMHIVzu+X7z1lH/48IqRlkSQqgLoFdZPAg?=
 =?us-ascii?Q?WdYPq74BDaXZzD6L8ET50nUZYeRPz5iEbMwBdvnhzwZuKTtFKVVl3gTe3NmV?=
 =?us-ascii?Q?nCxMeGN3GZDamDg+oDYjulihcf4h0zeLrHGqS3uuPTSASD4g7fFaqUO5dtZ4?=
 =?us-ascii?Q?HAIpsgsu84bpouakt+QP/qx+KXnRKIPwHCiQsP96thlBNIGPzHbvpSygArNT?=
 =?us-ascii?Q?7wfjX7Z228KRDnmyveskDy0roLeMAr94JxnRT6KUUL3puaxiW0FqybnboA2M?=
 =?us-ascii?Q?NWpyQfxTgDlzd1aa+uxW5SVAcHUFdtkZv0vc1xfM/fZaUQRU+kQI8UQihWl1?=
 =?us-ascii?Q?5H50bTOchsBHy4JBpF+AsQG5fmHWrE1lpEsyjex5gCayZzwIp2aVNWBvKmvc?=
 =?us-ascii?Q?NORwu3M0tfXqhiIdn3LNmzNoRhOMEdwJs28uPg5qrUC/mefDUfPjLpUkZst5?=
 =?us-ascii?Q?TCBiFTMMy6RkuHO/DvMl0CjlS9mP95aeub4omug/EZUzeauUvb6WUAo2Qdml?=
 =?us-ascii?Q?mzfl6PbCzmXRsDERBdO07wOaiEYHPD3hY70SnMUFJC3DZ46fHxQihZr4Fjw9?=
 =?us-ascii?Q?8Bt7kS2WhHAuHIRXy0er5xd9cfaHKRC/B0lK3/e+RbTslnn/Gv1JD1N2YBmQ?=
 =?us-ascii?Q?KVSTLZ04zaYomWE+9/xjYwhx6zyNP3JVrY0zEGVtuUqd7ZGFJCgFAP0ZsF06?=
 =?us-ascii?Q?YlLn/dQb9uckfrPOvUXyjtew5I2fz95iJbMpWsXSs24LR9Pvw+B1jFYu1qGA?=
 =?us-ascii?Q?y+eZyIbs/xwwIsK9t0n4Wak299yx4n1d1DaCwyJ9B1AYXE0n/91nMHmoZY8w?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: quectel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552840fe-8973-4832-7ed2-08dd0947387e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5358.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 09:39:25.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7730d043-e129-480c-b1ba-e5b6a9f476aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYw7FY5euAAP7WjEGWqsDO8HZPgDW83dFZTRkkcu0F4g+EMq5d8qsxGy5WffGiJ8ntg13WaQyDnzoeQWUHasW9QHCgolrcvJvaN7HMFbe1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6704

Add a Sahara protocol-based interface for downloading ramdump
from Qualcomm modems in SBL ramdump mode.

Signed-off-by: Jerry Meng <jerry.meng.lk@quectel.com>
---
v1 -> v2:
	- Fix errors checked by checkpatch.pl, mainly change indentation from space to tab
	- change my email acount to fit git-send-email

 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 drivers/net/wwan/wwan_core.c     | 4 ++++
 include/linux/wwan.h             | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d..082090ae5 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
+	{ .chan = "SAHARA", .driver_data = WWAN_PORT_SAHARA},
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index a51e27559..5eb0d6de3 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -342,6 +342,10 @@ static const struct {
 		.name = "MIPC",
 		.devsuf = "mipc",
 	},
+	[WWAN_PORT_SAHARA] = {
+		.name = "SAHARA",
+		.devsuf = "sahara",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 79c781875..b0ea276f2 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -19,6 +19,7 @@
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
  * @WWAN_PORT_ADB: ADB protocol control
  * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
+ * @WWAN_PORT_SAHARA: Sahara protocol-based interface for downloading ramdump from Qualcomm modems
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -34,6 +35,7 @@ enum wwan_port_type {
 	WWAN_PORT_FASTBOOT,
 	WWAN_PORT_ADB,
 	WWAN_PORT_MIPC,
+	WWAN_PORT_SAHARA,
 
 	/* Add new port types above this line */
 
-- 
2.25.1


