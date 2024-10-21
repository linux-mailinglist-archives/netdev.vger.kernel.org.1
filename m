Return-Path: <netdev+bounces-137457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B53A9A680B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4091F248E2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B31F891C;
	Mon, 21 Oct 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="UDlGGXeT"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023123.outbound.protection.outlook.com [40.107.44.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242851F891A;
	Mon, 21 Oct 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513205; cv=fail; b=SgXwSNqqxkAAluHoqiufIrnxKcpNMQ4TlCN5abiZioAFXLsLdy9FAcKDugsVERE4azQgbL8e5G5neAHbi4iEj3Pcsf0+BuZXUGMyR60fj8udloxTgCArDK+of76Vf+BEgo/1vjN+um4fcCqEaiSblYXBub08seVP0J8lrAGUVrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513205; c=relaxed/simple;
	bh=bMPmrl+pJ/8g3E1+15By0VQGopx75chgUJzaLof44wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyBooRxxmF6ViMhrD9OoDNhPXY/bRKTcSXH0mOURDaAQx4sCBWOFnIwxIZ8hjYjW3rc2dQmSZ98ObIt22BGerZYpPh6j1HUggJD/s1l85cTP9Yf00AdjwZcDUFWUz+Vo4Me5qnWg2tQ3+iyxtLPLNPzYC9FeIChHmfKp0MnKDQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=UDlGGXeT; arc=fail smtp.client-ip=40.107.44.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ+nl9LstLygqZ7dzqg8tpiHKjBZkw+CnWAnaC4fLGihDLcrskNR5sE2QTVmV8QMdbfIJYIwHTwFnY7b9DGu45BIciiXIcKqgqp5sK7XJuNV/4JaAewLwpAsVEFsFZvCkc6/Ee2N+HzlrTv5r631Hksi1glb6XeH/J4EN6GObGqm8bL/S+vvM7i8vHKF++Xmnx064RDXnjD53lW7D+hSm4L09vsxMB7uKmM4bPXyRyn4q0RztLlp9GayH672HTNOC5aSe1l5/ABGpovZ5eEgIfhv0sUMdy6HpyHMvK2VWBkuSbu7p3FCY8iMNkng8pOB4t76Uh19buGzXqOdVEA2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+WQ+FqP4/Uda8y41wT7Eu+mzy9im0bjP4dL6q41EZc=;
 b=tQIbJSrH5NQ5fr05Dj6oTe8BzsHJnxUvHat9A6Usjx+cAjWaj3JlwdBOJ3k1kXYd/TczENbX7w/UsP7hMqtUYJrCa7NrnnU1ai+zCRGktqbOKOxiEXxp+v1yUK37jOweZkS+Wp4dSx4Bq5k1B4gix6Lrgb7cAMSU8yZTP+G3LqWGo/GXjvzLIhInqRq3Dny8w63gFbWExNjiHYP2uzHz0Bg9hLMkAtNxbyng4TC0xweFaUDARUNLJW2IrWxPs3PwaHSp6X4Kkd4Yo6AqSPQvnauWMr6fUN0qpDcbHA+UUxZcYestE6Z7SN/c1EoQRLQ4T2PTyqU0Pd6/WgMrnSNFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+WQ+FqP4/Uda8y41wT7Eu+mzy9im0bjP4dL6q41EZc=;
 b=UDlGGXeTrZa4/tlp+Ymn0PCIqcoGBrSx6vSXcs2Vw4YuMJD9+muQNAUKrzIh/KvxKNpShYvgt5fdIj62wmtQkQnWQD40pZhcYILS8hmIyo/iHCuMTPc0HZMy1sVAtAcK7aE73cxCz1p+QzuObKSWJ3Ezp7RfLNu6dyXAD4z0WRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEYPR02MB6268.apcprd02.prod.outlook.com (2603:1096:101:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 12:19:57 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:19:57 +0000
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
	Jinjian Song <songjinjian@hotmail.com>,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next,RESEND v6 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Mon, 21 Oct 2024 20:19:33 +0800
Message-Id: <20241021121934.16317-2-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021121934.16317-1-jinjian.song@fibocom.com>
References: <20241021121934.16317-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEYPR02MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 778ead96-72f5-4f2c-d286-08dcf1caad28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfty1H/+MAzGkXp0wvR/XJwXn+8KT/KlH9twSoIMb2eHC8Jn77vDp/mKN+5M?=
 =?us-ascii?Q?+wxoB8R/KrEshjLvW4mWNKapDVTzNI9edFTu+vWXXf/Qf1LdRNDY6fiT2fjI?=
 =?us-ascii?Q?c6dB6gy5L/a9QJpZe+dLXCS3N38jaINDtTM0CD2/pbuHVg0FE/x0b0q+Dq2h?=
 =?us-ascii?Q?lV40tZD0PER3nY5h61J7YHjdIBcwux+kLtJvJFJEobsvUc5dcTMSSVIgw+KI?=
 =?us-ascii?Q?S8TwrHLwNc2rSs/WUB8X4ITiwf1fT0G84oTlKY+Pvbhba4RzfN6k/M9tHwWP?=
 =?us-ascii?Q?oHIKDkDIwG7fd1F2dBpuZ6F0+FimkpNNy3g3iRac16MiW0rk1DH6UzBlZ/yI?=
 =?us-ascii?Q?Zw8T8TsdcG98vyzG8JTPj0q2vJwBSNVMtXecQutJ2c1hCsfVw01sjUyydXxc?=
 =?us-ascii?Q?DyFBnh7liP5dIpCgMUZRT/aFrz6wzTU9NcTUpB76c0VCQP53rV0lFGFiGp5A?=
 =?us-ascii?Q?My4v3tDvYQLIly0pg4x9xXFX2ioU/P7rTsRq9vJe/iMVMQwS/RFKnMg3SBWD?=
 =?us-ascii?Q?/Ubr6fdhweLvnQs5VgC7VHZQWbrakjFpEbBnm6YCJyHgjZblN4w+ZD1+EA5L?=
 =?us-ascii?Q?CYLdcV+ThbMJEDH+4BjzbIi17KKTcXOiglqd8wGN0vD094nB5xVPTBgg+Ct+?=
 =?us-ascii?Q?38rEEqILyDWD6AkHCHIUYBfUoU+LAmCAHUBAJpBSPZEg8fVmH2WZGWjpAGoV?=
 =?us-ascii?Q?RnyO8dg13Ixble4vZjhHdC0f2femckrW1RdKqx2evAnhO+r/FENJIW97iAMt?=
 =?us-ascii?Q?rxQXySId1NQREoYBfQwq0AEOvU+a+85wHA0he9sAqleB0Y0xz6v8fhl2Dqiz?=
 =?us-ascii?Q?CA8ZL+qTp+6yFhH7r3I/4nz+5o75nm0/Evg3usEnJogNzqlDdHGEX4qotM8T?=
 =?us-ascii?Q?hwFa2LA+EokYRVLGbShCYz+LvNVXrMWeM6TYP2j8rjbizbwxDSQuwUcYrOhz?=
 =?us-ascii?Q?Bj/hJvGJV19pkExj39bY8wOhNQLtkZ77rgtkld9iGDgO62G1gIp4JC9rDfqj?=
 =?us-ascii?Q?LGHUprfiu+O9PpWypyDaICG+wPP0TEztiKtu9dtHe/2XcSGSYMlLfS4R3ADd?=
 =?us-ascii?Q?xpT79Rt79zDckhJ8A9L7NLCCsmX+3L65pim2N6+R2uqlZG5dQGplgD8oMwdg?=
 =?us-ascii?Q?ZvHgBtGHVjoYhNOF3FO8VZbHpRlSImxpCHifm/xxdK/brkrysXIGIkE/xnsW?=
 =?us-ascii?Q?1VaYV0B1xyfg2BD8iR+EanZVJXJakisBDMPxDsLsiJZjFqwqLHllw8FJ20Qd?=
 =?us-ascii?Q?HsW9lZNlgWCNB8s4k+Cel0YWI1b/QgWHia8yPCDEfkM2p+gik2Ity0H44dMv?=
 =?us-ascii?Q?0YUxJrH/6vAbxdPRBLIqKEhppFxne8WH3QFtR58Ns9fLcePXmo12ygD2e33V?=
 =?us-ascii?Q?kVR5QewV0M+Zl7/F4Xrh/12nPvDm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ChYKAvkG2zQ94CfMwYDRig/eoYAG7me4azYwjZlqrpkQtvKaOMShXIzn//P4?=
 =?us-ascii?Q?gToJgv6kh67impTQYElfV28dAygexzDDoxnhJiLx31wsdpMotq1ZI6xrKEmA?=
 =?us-ascii?Q?GArNRcryo4mE249ypHJtkNqqsibt+6OelRa5tkEtE+mFtHQZMzadEIMN+dQI?=
 =?us-ascii?Q?BPTjP5tPNY56EuUupjxL4zFGyViOgeuT1HpBNw/xbYn4vnrpDl+MeXRDlU+v?=
 =?us-ascii?Q?4AFnamKgiakgmxAzgQ5d5fMXN3YQADdiRbklJ+sGeqMfzHwFvilAlFNqHm/b?=
 =?us-ascii?Q?fY2dN/PSiBrOrbQIYzZmyVSBxp5Ljt5ppz3vY9R/qVmIkW/Ilb15x3SGxfyC?=
 =?us-ascii?Q?5nxZFetxWg/WmMJ6AsYXFU3kZvxwf0jmgLBCf+tgits/AeipT+u+TE+R2Zzg?=
 =?us-ascii?Q?+bGHUZ0Rs4ZEaZB26wqIsFfh3J5K37H27BbDPQkVEwfBXztdItzbULRTyaw8?=
 =?us-ascii?Q?LlqcZw1vNmYUjsd70f2Ulu1Cx9Ayj/Msgg48t3gpsJNOa+pz+kaWiFLWgBy1?=
 =?us-ascii?Q?ESABhUVH3s3tXMk1cXphY127L2C8x1QXrjp8AnHYyg4pkXDuKxMP7DkEYsug?=
 =?us-ascii?Q?P05W5tWGObx1px8zhKv0EgeMvTWIMG42E8pJw35MRkqCDWZIl22/sBiwMWOG?=
 =?us-ascii?Q?CjE3WaJZZpztuFI/XYx/tXWi0trkpXfC1GNgEN154a/S0ITxVa2dQpdkdhE7?=
 =?us-ascii?Q?uQDvNqamOIPKy2j/iFDDbl9gDBqRQfgj64HDiiw8dVMCuiVsj0K4cH/X/jzq?=
 =?us-ascii?Q?DmzeLQvOK7lfI7DTYzoIg40S+LPlOFJZtnwP00Na5qlBv7eGSzlw0OKK5hDn?=
 =?us-ascii?Q?xC5J7O2hwwrQG+zGrpBuUp2sn713xZKIF6DEggZMJEo3RxB3MDwA5Z3hXLJG?=
 =?us-ascii?Q?SNeKFaFalLDyYpeUMfHUDZIue0ejAE+cshxwLcMv5EGe38y6d94XVEBtIwjz?=
 =?us-ascii?Q?Jq2PYQjW2GmYybde7ozZl4KlmfRycITSdeRR2g15+Vrq3cKNqq1NU4X4eCUa?=
 =?us-ascii?Q?Ip+4UUyDOd+d8R2rlR3xW+G80hwzpq6Xc2y6lkgq/9c/Z8Nwiq5vdyMsqv2j?=
 =?us-ascii?Q?Fee9H1Im1X90moFB4N6PAB+oeUj6qdL9S8vhnePWvhx9STWx5Tn8BilGljVP?=
 =?us-ascii?Q?/PHUSaihAWHXiyNITEnRkU7HnfiaElXAHMB+WRW7Z/n0hchvwYuRi/pMLXtq?=
 =?us-ascii?Q?U9DLXTU1lKR66euVE/rQ6tb6OyvzEARIUSOIqDaFdOkIg9hx+JynF4xiYiYh?=
 =?us-ascii?Q?dXVv8KngPnf30Q6wHtAC2KiZ0FtxorZqGk8OPKdmhnimb1PJo8ONwY/7WU7Z?=
 =?us-ascii?Q?uFrD+dXtwNOcjpsJLf5HdBk6dFSbWUqEdWlEqzllVIJoEGS7GlEompKFWnn+?=
 =?us-ascii?Q?TVvwntcXfUDnfmN8E7blMH52R0htymZU5tJcSDPdOceXMn8yQKdDgbKyaPjj?=
 =?us-ascii?Q?LAeE5Z9eJsH+kpx5oFLxwvx3Kwv4ok+y2rDfvfjm0SAd2KvteaQ1D8sD8r8e?=
 =?us-ascii?Q?mphK+Y2YFvdB5gXrVz/GnYZ7wWizzk12JJ+f/XCoII5uovabEGICeXQ0KvX/?=
 =?us-ascii?Q?tzBI5rjiRGNGBn39EXRGRyYHSnP5iXsLTgxpETgCLbQ17iEzAwMvnXznSr0r?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778ead96-72f5-4f2c-d286-08dcf1caad28
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:19:57.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+oHvZjiv/vB6WHPNYwXRY2GhwIxfTV995rY9E1EE0V7zdrcSWi2ThN8WjKEj6koHRxmLfDjdcC1z5qwWwyuX8EgEpDcp6fGXeD6PYapE0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6268

From: Jinjian Song <songjinjian@hotmail.com>

Add new WWAN ports that connect to the device's ADB protocol interface and MTK
MIPC diagnostic interface.

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


