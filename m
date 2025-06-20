Return-Path: <netdev+bounces-199714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A49AE18B3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD05A5C97
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD0286D7F;
	Fri, 20 Jun 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qc813RQB"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568ED28688D;
	Fri, 20 Jun 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414769; cv=fail; b=BGyJdCpLTkPJDl6N59YkGDLlaqJpIiMt6qn/rbkSTiv6KF+aO9t1d6309pzns55OlQgwHvWKd0EjqjrMeT3yTSbDSCnvwBcDtpZHr/CxPvJozO+P1NEFO/u+v9/1ZTVQeSgBuDvT42terBic1tT154ePXu+01clXCxhleO8tKUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414769; c=relaxed/simple;
	bh=6ASbrAXpoYxK6wf/O5nYWrw0ClcQqhB0g3A6SMrTY1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFJssIMx7cgGrNZd1KfzXarKTj9MsJ8NJLgTiUBuVW4juUlCmxRYoTInNHxbM3VZTf6pKcNvNBU6QevEI6lqoi8ZztZGaj6glorCZXytZy8Gv1cRnmWpFOFsRDr2TM35+E9q1dcdb2Zbr3S1e2TlLsC6nQ78++OuMLGUlXp8sTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qc813RQB; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSsiXIPG1FQf62jjEtfuSpUlDVTuz92HHTCdQTv9dD7YEUxXm5ByVjQJ8loMnrGOukbc0lgBHEW4e0k1v7/eXAtUxlaetpV7kmtfPLwwFfnG3eC6oK0EnhwwKCH1hLREdCzzSxhylM7bDAgykB/M4fxhFCVQ2DWgKck8SIFu+dOQ0Q2k0uqRfCHMRvhjzUrVz8y/d4uur+tODJFuwOx4WVBhZQUbX501IzE5Fbt+D4gOcZw2YsA0WtzKJEuMrrXnJCFDlZeEfFLIWb5g7ndF3c74r4FtIXpK87jxBe+05d7AqpH0+S7g08fOl93wusqY7ZIqMxGNX3KhmrkeS86Cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx56ktiRIFt8ayfMAbZl3pzv0DX8pbvYGLG5xogjc3w=;
 b=K70lftZIZSZOY5EBQZ/SAKklUspuJRbJE5EkntiNLsreEa5EAJtoZIfrxLXUQ0q/mG6jo206LcIJ3Rj0ajsK0Ng93SgYIZscJbLglgQCMgdfOjcIm/wdJq8T2SqQ40/J18LBkDWAu3huU5+rOO1ZCgDS7gGQrMjuoOQtAQ43EdlEjBiBGfAUQZc3dcMJdHXliG1fchcPPvxK6wqPe6/A/ZDCQH+7Nh556+weGJwE92G1v1mMP42QuTyO6kifp0HywN7zDsdoNs5cc4x03FxkkZhpmIGlh9Z4UHooOg9gdgRV6ZCPYpYL2X6tdR6SHCymfnzkDZfwEYzOSVGJWySuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx56ktiRIFt8ayfMAbZl3pzv0DX8pbvYGLG5xogjc3w=;
 b=Qc813RQBTGo5vS8YUkb1obPL1o+/QOYgOP+3q/Wl6m7cSXJN2O8kn66nixmcUaHZ6c2660yNiYekdH+MmQfVrslt/JOEhOA9lBCa6BJNT9ISpfzuBR5WebLKBy2N9DFK4nY7XYVYbcJo7JhkoJEL+pxr/piLPyHkr/TeM3n5whzVG4g1tB0ZGuambh18SpKn4m54mKL0cL6y0INDSp4DXPL3UcaO18gJp1VNT7g2laguyt5FOQ8DXtP+w6NktgKaP70xk9Es6Y+qRdz7/PhJmajMER/A4vsL2JpYKbx9gZmyP1ZGPenV6CWOfMlniJjQTV5z/WDzOokseL2hGdCViw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB11258.eurprd04.prod.outlook.com (2603:10a6:10:5dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 10:19:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:19:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from enetc_port_counters
Date: Fri, 20 Jun 2025 18:21:39 +0800
Message-Id: <20250620102140.2020008-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620102140.2020008-1-wei.fang@nxp.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c0f560-9cab-4986-f273-08ddafe3ee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uUmgsTp4IZi+zxzCpTlAc0zjEKNMONIwMmrYr/CC16ocHPMTqDw0qA3fqdkx?=
 =?us-ascii?Q?YfLuT2DcIWggVKaHLTHVB6eVlMkCwj74bwdgbN1dV57IDv4aX2Y2V1j9KM5L?=
 =?us-ascii?Q?eopWxJjooYbJ1T06YLHD+0TZvnHfqR1GZ+0xwt5S57i4YJArUT4nZ7b3LtmD?=
 =?us-ascii?Q?XLHWNouqN3L+Wvz+m3xpc6r0bkllKao+SQFl193gz5UrIjimjHSLcaQv7Kac?=
 =?us-ascii?Q?dLGtcw/P4+eOuRm2oLGg8Zjw8/koFzu6xVxapgbh/fx9Co4ByEdExHLVlm1Q?=
 =?us-ascii?Q?vbgIzMXrMCly7wH8Me2vtfN1BUpzEQmWr+OWGX+cW+I54ookT9KUNUp7XIk1?=
 =?us-ascii?Q?aOXo1/Mt7g1eqBguqWPG++6bOiDEAIGrq9kfChg4r4fhykzl0DDrbyouI2Yx?=
 =?us-ascii?Q?PmIC7eJYvoAZaMz8/ny02VMAUF/zp8kLWaR1dZFohSaHdumOdmSYGm3syrs0?=
 =?us-ascii?Q?CAmvHgxNLYVF/2a94NiXYEWbNeeb59ZLr7s/zEYWf0gqY60KA8KpyewXT9Is?=
 =?us-ascii?Q?U9Ns8aEAAMIlwZE4wcOwU3vKJndMCgvLhEizsXI3bxxYbUJRVrjG5iN4Vrso?=
 =?us-ascii?Q?4PJBLSQp5bMMPHfpQNrV/iKCxbtZHEtJXhma5mi6xPTCECPDY1HWY7uvhUIe?=
 =?us-ascii?Q?feZSw7kYDYaenHd6MuZ/c+4CmH+emWfjCy7HRkr+RqetLpiE725zC29vbXDU?=
 =?us-ascii?Q?oDNiLaoCOPQnTs8lU+lSq4tglWUimAQ0OgdvHBVqgB0nmG8cfMgH6JsLRNit?=
 =?us-ascii?Q?viDEazn/hTIedQvLNchcx9GvyYMxyi7dVzg/1nWwD1PATKAGy2xBSrzJhszl?=
 =?us-ascii?Q?+oaHPMnlAw0v2lUsJrqFLcejjjnk2qYbhw01kFck9ppl3NxTTKWwxclTHIsY?=
 =?us-ascii?Q?d0C6L653SPnQFkzrJaB9bKayjSRubZIEIjrC/I5g7BQ/RmMRE1TExNtdqdd0?=
 =?us-ascii?Q?QtHZxDzrcwl9ajuEr+pDkzgw2q07dt9dvwSh2HhzsDiR9NqueBsp6gQe1H/9?=
 =?us-ascii?Q?S022xT6Nl9Xrz+7FemTxX1Zd4TxCVk7kXMBHvOP6suSoqP54dXwiRNwuAuAP?=
 =?us-ascii?Q?1ijRqswkyGC64/zRyyrXjuxCGFz8E93QZMubCQ8BnvBisDhZ+oHOQEXGI0oW?=
 =?us-ascii?Q?VYFMDIP8g8PAHa2cqfs5zLrIq1Wwi4PI1snppKM2RSNnjLKH3dw5NW1n/ISf?=
 =?us-ascii?Q?GZFwYbvU5zveiawAdd8ot9eXoLD73lbXuDDW+/bQb+brdbcdStIF4Eas0Nnq?=
 =?us-ascii?Q?I0U9ZD1bnjDtOVEjncNHI8U2tMYsXyDv3Ff5tmAalCFVqvovbbrYgXkgXGVc?=
 =?us-ascii?Q?24W74ygD6iElnlTOH8jx+OdWnnacKjn/zjoLS0soZrQHkdZdYJ/F0WoqFJ56?=
 =?us-ascii?Q?7loqz5JL+CXambfQslLTk4MDh1TK+Vs0iWOAUS8hw0oxJwwgSXBg5EHoB7Ys?=
 =?us-ascii?Q?HGgyMO0bCPcjsKbu3rlmrYLpPzO0j2G3D9P5IA0ioaEQ7trgWTEoxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NGnpFPJc6R7o5Y2oeaqm/1BsOSnWB1jGJNCb/cB2HUF5ZOskPjvfkY9hNvmw?=
 =?us-ascii?Q?09b1EjrosQfC1EzNL6lpegWpAWUP3aqPtZ3227ooxWxGqBz1hNO1LGSXQoo0?=
 =?us-ascii?Q?Xcs6mMV2zO/S41EXfrcVV3honLMZ8Fb4wOLuNZGCfQOUsxKkzNuuoBwTEvMD?=
 =?us-ascii?Q?95lQXsDDD2ORWi/hxV+lfq133ISNmwmCW2fc+XyIhRworFDMmLTdQHT/SlS/?=
 =?us-ascii?Q?uyKKNTghayOCrdsmmA9Ba88AI8aI9Let8w375pTWpyKDqWKjejdHkkCuJdgl?=
 =?us-ascii?Q?x8GEkdykFvC0GR/Sc0o7IANJcZPpMUedea5Mes9lVkU/C+YivUUo1QElbS4V?=
 =?us-ascii?Q?udgUq7WlIaCfswOwedy/c1PWdkfHKWU2EEv+M9CLMeoQ/zVQ7HYRueRZpyCc?=
 =?us-ascii?Q?kh9ScD6mCs+0/cYCyLmxZJ51Gn9Ba/zwSEti9WfgvSH1gJHZ+JSsrLbYo6Mi?=
 =?us-ascii?Q?QpLp6jDB+9tBo0lXs97CsYJjhyneu+TrkUds4oElAFSsvdGFWmCm6hrmHHlW?=
 =?us-ascii?Q?e6PGestFa0LtPz8gbM6EBoaAjCzw9bLr/ZbwMJBgmjjrKGV6IC6ZQkiueZ57?=
 =?us-ascii?Q?Vz3lX7tSVDz3SbB9tRE2Of20+YO6kH+HC+ezHx+IkdVaPD0FdfDS6b/2m5Kz?=
 =?us-ascii?Q?arPqpwxQ7os7OPlyNzX7Kvmg69XPtH81ByU1Oxvao0Ksc654FNkA87bCbGmU?=
 =?us-ascii?Q?ZZiGNQHVVd5RphrrmHpgq2Hl5mS0cQUbn46MRIIgHgKSZ09IlEKJv1KC2ny2?=
 =?us-ascii?Q?rueQlDSvNaPSxST+de+AGBuar4jjHqYMsXvIUNrP9ePW0ltPLYpLwOkIgTYx?=
 =?us-ascii?Q?gCTIR/GNnpp+Sa6fZYqODWyQIL/aH0AXXqVTsf04Pk8SmeKXNPO4Lf9+6gNu?=
 =?us-ascii?Q?WJSFVNJF36G4xeBt2RW8uEGJIoV8LHkRtvhqOyucmQSO6/q15rU7Y67LeT+H?=
 =?us-ascii?Q?tmYmzFgJsdZikB+jpRHAaWrNCek3n3B2TBIkHWzS+BHRGvUzZkBBtDW/n/5d?=
 =?us-ascii?Q?IH3ufbzyU9pKeZn8qkNL+Dq1NiqRV7eu4VzUNdogEKXhErJlfdFpcg6feUTt?=
 =?us-ascii?Q?DaKXkaTa7AECSbr+RkJwUTPCxHDP9pcpJs3AdcaX8/anAzkbEVHmPk8E7rYZ?=
 =?us-ascii?Q?fUXLI2eOsuCaUsLfGp3VTzjf0/1Vzhlzc6X4321bZgsM49PVsPHNpxshIXky?=
 =?us-ascii?Q?v23Lz6J2OaHsqxGYR/AwgX1DBUXvTlcgJ/c/ljAivo374O36XHn3wlRsQm5q?=
 =?us-ascii?Q?jqGzbrAtetSlirtzSP8jFuBi+m9p7Q5oCpbsY0wsFBeuUdSWLHRmBX0W4cH+?=
 =?us-ascii?Q?NY/IRPFxd7tDlGZW9BqYEIi5rK/fJ/aLJcKJiWnaV1ub85y/EeFU704g+BWa?=
 =?us-ascii?Q?KNCIIlsXLZO2svq3QwXZrih3f71ME8eFgZNe0KLaHmijb72dxHn6l4o6RVFy?=
 =?us-ascii?Q?Sy7v2vq2RjysH8YfSlLNTqH0BcC/IJyJLa+i+hOH5nh3sbmHebN1EjMInGIp?=
 =?us-ascii?Q?3Z8W5JAJlqGtzpwXgwY19BMSVwm06BQOP0EqOAuWPKamSEhew/SGyg1q7IvA?=
 =?us-ascii?Q?Shq8qpjTvRD0tV6ow8VUoBXFgCercpRRHu2zn3JL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c0f560-9cab-4986-f273-08ddafe3ee55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:19:25.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jg/tGT/fHBaKe0UYrlS3V3tRhFM4mhOajlzjEreY7YU0s6xyx2ujnhdfE5Sz1C8bUeAjLtAi/FxoRdRH8jEMiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11258

Some counters in enetc_port_counters are 32-bit registers, and some are
64-bit registers. But in the current driver, they are all read through
enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
64-bit counters (enetc_pm_counters) from enetc_port_counters and use
enetc_port_rd64() to read the 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_ethtool.c  | 15 ++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2e5cef646741..2c9aa94c8e3d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -142,7 +142,7 @@ static const struct {
 static const struct {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
-} enetc_port_counters[] = {
+} enetc_pm_counters[] = {
 	{ ENETC_PM_REOCT(0),	"MAC rx ethernet octets" },
 	{ ENETC_PM_RALN(0),	"MAC rx alignment errors" },
 	{ ENETC_PM_RXPF(0),	"MAC rx valid pause frames" },
@@ -194,6 +194,12 @@ static const struct {
 	{ ENETC_PM_TSCOL(0),	"MAC tx single collisions" },
 	{ ENETC_PM_TLCOL(0),	"MAC tx late collisions" },
 	{ ENETC_PM_TECOL(0),	"MAC tx excessive collisions" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc_port_counters[] = {
 	{ ENETC_UFDMF,		"SI MAC nomatch u-cast discards" },
 	{ ENETC_MFDMF,		"SI MAC nomatch m-cast discards" },
 	{ ENETC_PBFDSIR,	"SI MAC nomatch b-cast discards" },
@@ -240,6 +246,7 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 		return len;
 
 	len += ARRAY_SIZE(enetc_port_counters);
+	len += ARRAY_SIZE(enetc_pm_counters);
 
 	return len;
 }
@@ -266,6 +273,9 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 			ethtool_cpy(&data, enetc_port_counters[i].name);
 
+		for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+			ethtool_cpy(&data, enetc_pm_counters[i].name);
+
 		break;
 	}
 }
@@ -302,6 +312,9 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 
 	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
+		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
 }
 
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index cb26f185f52f..d4bbb07199c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -536,6 +536,7 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 /* port register accessors - PF only */
 #define enetc_port_rd(hw, off)		enetc_rd_reg((hw)->port + (off))
 #define enetc_port_wr(hw, off, val)	enetc_wr_reg((hw)->port + (off), val)
+#define enetc_port_rd64(hw, off)	_enetc_rd_reg64_wa((hw)->port + (off))
 #define enetc_port_rd_mdio(hw, off)	_enetc_rd_mdio_reg_wa((hw)->port + (off))
 #define enetc_port_wr_mdio(hw, off, val)	_enetc_wr_mdio_reg_wa(\
 							(hw)->port + (off), val)
-- 
2.34.1


