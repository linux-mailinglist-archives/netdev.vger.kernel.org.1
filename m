Return-Path: <netdev+bounces-190283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00ECAB5FF9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 01:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2111B3AF3C9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7777420C489;
	Tue, 13 May 2025 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kMqAAEkM"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949C5695;
	Tue, 13 May 2025 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747180126; cv=fail; b=dPCyxaTmHenHLxS3vOlECfuPDrms2zLUz9OyinaNjw3mEGZG7ppcsuVIJceWIKzAi8oBVZTZsn9MxJZ4BspXMGW9QKPPGCE1lbQTFNZF4C/kLnPW7PDIFXNU3vOpJR2Hd8stqf9osHMOZzkM5JhxvHg5n6GLit79tbHybSVEOwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747180126; c=relaxed/simple;
	bh=TPqeMh80gQBOcHpui5dsDRlcE8x3uF7B3//Ah9f+stc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qhPjvJg157TM30JEnbB0TU688pmc1JK/xDXc2vAiZ7xVuQosyoz78n1EmWxbMPjmB78h2HNH1g5ysDDSyIVPe9C3T6YucuJmdCZcBk51ppX2qvIvaYfj4u37C6jafd/dBvC8PlSfRDh0vpgnsFyJEMUecKavtII372TCjHcAlGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kMqAAEkM; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiBEksKmhBNLmpMkCbEgu0INPOugZi6+RDnwG+Tl/H/q3/+2xkueKNEMNRHMBky6qT7pyaPd62AGNJ6MALZ6WyUZo+pTd3pT0xU6wZZaCbLaoARiAqJhA76oxB1iAEIhXeZtBwwIEpnGOnyer9wuWJcVsWc4/McwK7MDFcX2D1Ob8YzKXASbGTng9WuuZTMjL2EW/z6mtRvF1i9P8lA9J+7PsyUMnvw2mi3XAfnGD+WThyZ9OG4hPHrjnTZeAnmS7IooC0jFkgn5Ngd1Y2U5qSqjNLHUVRqOp8j2LnAD35xaW2WtkvLVOS70JPshkiRV996Cuye2b+KWCEs5ZVYMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynCs2MTFLP04N/27d+JtFiYzRrTc6zpH3o89lRx0a0s=;
 b=rL6PiJTNo9yOY26ZTumSrW9VmRKmyZ/J+iOk9S066Cd91+y6n/7YNvtMrB7XlzD3L7FbZiLj0EhOLhhy02ibNdu36OeZNHxAjF2mh6PDgQ4p7ZEYyzwE9isG2zNXGgASXrEWbg7951YAmvOTk2KElCtFXdaXxce2KyBgeOjqfZwGq441uUUzn03fnRZmO3vKiqJ2D0cVa8SjT/7IjjpdSqn4Rhlv9hW1lHDuMEovSiVGYB7XLLEjRANnuFC3OMUW2iE0tn3s4SNVb4rk4GbuL0/TSVrJ+eUbZWFssSvSoBf1LxTGQCXVJWMtwIBmIRWlRWpV+8++iK2q9Q8iFeck6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynCs2MTFLP04N/27d+JtFiYzRrTc6zpH3o89lRx0a0s=;
 b=kMqAAEkMDCEhadvLqVqh8Y5OznWDbXWsVOPzLZ6ekDdSZGm3szHGSTixIiAXvxhm3cyUMw/GC3RFAcL6kOGMo216dTMhqeEnaQd03qSs+EMC7B8AMLY/VT+aB0+RtSSVmn2f0yjO3Nmq5k2eQ5T1ksGtQ32uUg1ZlVm7bo7wDGtu6aK/9akTR+HMistUtTezinc+G23i38qgg4ET9eDWMV2Is4oKElDp6E0H+CFOYSx3/rm2q9f6Ig+wJksa+tmpdLg/t8PD46hJDKWBJL48yDCH3f6Lc2WD7C3K2P5UDS6fOBaDuOaVLLIb0qmIa3ERrknJ9aez3DoxNIrUlsJMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SA6PR03MB7687.namprd03.prod.outlook.com (2603:10b6:806:435::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 23:48:41 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 23:48:41 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	linux-clk@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Teh Wen Ping <wen.ping.teh@intel.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v5] clk: socfpga: agilex: add support for the Intel Agilex5
Date: Tue, 13 May 2025 16:48:37 -0700
Message-Id: <20250513234837.2859-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SA6PR03MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bdeeba-7a25-484b-46dc-08dd9278b092
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/qv+MB3IYo2nb3Ln2xOd/grgNNIdrjq1IePUn+zsM3pOitG1YP8Fh+vtgOA?=
 =?us-ascii?Q?q7KIZXGujgOjwnA2+FjPLY/Wfdj1DKlTbAhbuMdRbTdZ5WRJHae9Fl2TkxWq?=
 =?us-ascii?Q?QFtjO74nRVAmoRgJmRoOhj0NDlWQyEeFoVpbyyCIejeqqYFdne780C1VWB7p?=
 =?us-ascii?Q?Di0Traj2bKdFoK7LKuUyNGRaOfAUFp81veWyBRIIOCs/W9CZEkq/+E6nhaVB?=
 =?us-ascii?Q?xDyd+l6cy0B1HrflbEB+cUWaCILNx/NISLaLvoGc2v6ArAuO9LLqh7pYR8M0?=
 =?us-ascii?Q?1/9wNHmYKICImIWjee8doqD98PJ89COSrCMVQHnLmZttoSWeegLC3q7jK8fj?=
 =?us-ascii?Q?yjKsAKwjBXF4/5jJFEcSUOw9FSlA2pnIH5TkNUBVkg5tqSy3lO0CHnsu+Jr9?=
 =?us-ascii?Q?OgAIHfhJwZs9kWo8SpgLCnnhkZTY21q8dabH9Mij81Wacx+Evl7ynILYB8uI?=
 =?us-ascii?Q?mCJOnRcDrNrV3Ytj5Fj0aWImJw1U4X5qM1HQVOMFEufjhk3UjHBppOZGqOXQ?=
 =?us-ascii?Q?X3dHCJJxfqcPg2ai4JHvChTve/LDn2yCjdB0pYpaAIg7wr4sCtaJrCsPZR5s?=
 =?us-ascii?Q?nEXlVk0z6pgF52IvRJK6Kn1uW2FtxEr+5KFes3M9muAwfroMQHKfFOycMiDw?=
 =?us-ascii?Q?z0t1zrHR1d6uBDCymlo9ANRVmQSWjNJF0sc/liJ4yhLmXfpUeV8Z/vvP5VGz?=
 =?us-ascii?Q?uwoaXFkpZF+cpq2Ws5QefsifHgMaX6mUdtUoiDUBF2SpgidGK1xBsS2K8+DO?=
 =?us-ascii?Q?se/0eUxMXxci0K/YsQss5ZEO9ksBbaQnd03bf4VERntcVyOSqVqqOUVA2HDX?=
 =?us-ascii?Q?GnZCCy0nOj3gd2tCbSoiNIVrre7AlpBuMeCz/Hd2DqEbuD1zzxLirnwGhzA2?=
 =?us-ascii?Q?GZ2jMM4lIDLH6PFgxIr6W90uP7SkAHrzH+XRAfqQ01fN5HNiGhZtKyUWnCxq?=
 =?us-ascii?Q?+Z/57nrPPh4LHpqeBmjNQL17Na9NDEj8oaVcslGbzr6XUXZm7FtbbZU2DqmY?=
 =?us-ascii?Q?4kN2oDMYkmFTNnUVmkaKum7QNzGLKvPs46PL2LTeYL4Us0J+9JkiM5f4Swvt?=
 =?us-ascii?Q?VnZ+zbZuDWKnf83QYGZ2xhtJWFfiMNMORPOVgf6jGANZ8d3knVi76Rs1BBNb?=
 =?us-ascii?Q?RocwL3XE0TDNBY+i/ZTQA127eUZK7FrArCPr7G5m1O4h50cerC/DIw31Q4/L?=
 =?us-ascii?Q?kP9Z1ZtJjkZnrG84Q/3wXaSmgUjlzrTK7c8XbhFYiWhx3ztKzGklTAE0AfKs?=
 =?us-ascii?Q?hS2dgFR2UtaPb2P3WVQ7WkYLGomyYE1abyKBQ9lAgenb2CwqbiAq0/GK9oWr?=
 =?us-ascii?Q?zObZ8ioVOMZleycPlweuH26ekJKOwogrscLU7ivpjwpWVQ/T/BamGHWlTrHD?=
 =?us-ascii?Q?ynxJKCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K3jHOMSGH4UfnQSNIoHzVpHjg/4uYMTdV3H8bYeSihu+JWzNUn1nlThIgXqN?=
 =?us-ascii?Q?G7MBM8rH4NZ30WpZ29L1EIPzPdkjrRl+Co2Uyhc9rdwVxPTlzs03lWE7Obm6?=
 =?us-ascii?Q?Nfcvowlqc2aqa/ZRT+FXx59IT38Kpnogf3rku0xqsnnrYrvbb9aW+wwLoAw/?=
 =?us-ascii?Q?+Iy8z+O1escj6Jx6LwbFV1mACgeX1HCB2NFLZWHImfDTqEkr7so9N5XurWOR?=
 =?us-ascii?Q?SZ5pb9v2J0JwT/GyEwrBwjBK/cpbyNCvfzBbSCKd/DmDgWsRiASQpoB5SMdy?=
 =?us-ascii?Q?+7pJzlU+olmN5nOtpBwHoudcjNt/odxJf1AxwwfX5NsKxQMuNATXxPu74bfX?=
 =?us-ascii?Q?iq6qj/57keuPd/Wu8a5kdCJ2myUoQEX+yHniUZOKAT725qkP4nfYv26kRrXk?=
 =?us-ascii?Q?gmofTKlq/QF89QCi7fhrwZceKpayZYQ2nPXBxjt6G3LouRRZI8uDWtydIOQU?=
 =?us-ascii?Q?dEebOyelXMgAUbLq86nMGhAmUNDirMH30IZwshg1Frr/beYCXyv+fxYM6/R3?=
 =?us-ascii?Q?XQg9yB3isxKAgucyb/7NTTfI2l3XBzhf8OSRXiasPTvPE1Sj+EhTX+E+endl?=
 =?us-ascii?Q?440RB8n7sAlrxd8zkxQir8TH5aTZWBycUbAUEERMBe5ug5j4NOV4gsACici/?=
 =?us-ascii?Q?4Q8dEJYPyoRcRLtXO/Apmam086w3Hk2WEqerfOgO6AOmXHYvhEqv/mxpSqGC?=
 =?us-ascii?Q?V+ceVfrSgVDdOHm1Err07fOclrFwatHzKLBTnc2qdRRz2kz39mU3JSlXeddh?=
 =?us-ascii?Q?lKkouoUkzrhXw45wNuPuX9l/vhf+daaCdxHXE786OwIC4//3HBAO3FgpqYpf?=
 =?us-ascii?Q?Jvve8P+KnmJ4Deuy8ph7YTyn2kLVZw8a6Qj5DQW1t7jKrliu27sEkw0b0Yuj?=
 =?us-ascii?Q?HqdK23LWnlItyKkbAF8PtX6SacuM2mOOzwLtsuyfvAbhnhPwzEFBeFo7IHc0?=
 =?us-ascii?Q?/qweL9s0BpUhcxhd+L3TcYvbtKdo3S+ZZ7zbUGoRiBqCUPXVBTjgNAKitHgV?=
 =?us-ascii?Q?V3QMuSzcB9nxO9heApLzYLT7eWvjeMlFQtSBtanqKP1aq5Yn9mhOHndSaSS6?=
 =?us-ascii?Q?XlloL9//CXHIYtIUVN9SLo35hz5/awwyelqQkbkZjt1u8SDFPwqn31sE/VdL?=
 =?us-ascii?Q?dflRfU0Ljq8J0N7UO6b7gvNpQlXi+i09A74JfcuDmawppLyk7ZL00dWQ0y4f?=
 =?us-ascii?Q?OS5+butcA9a4KgolF3PVGzcGQgF4zJb78t34Ojvk9AAFCwGWQT1eux9Fxzyk?=
 =?us-ascii?Q?QqDKKMF7CuRv51e/Facw93FSNHCaFPOiR4XVf9jMqLDIQ1doF0RhtnbQx1Qv?=
 =?us-ascii?Q?8iyHAG29vVa88OZckB5oDx9+oLnmuI4rcZJE2Ek0l2zp4LklTgaaFr4P3jwI?=
 =?us-ascii?Q?17fuhngOFQdUN6UMnlUPE/pcYmEwy35Tx3lrCAWDxyPehGhz++a7OLmSFg5P?=
 =?us-ascii?Q?ULmdMSndiHmj7eBUQ48U2r2YFtDjULsUeHFWMvrzNeB7TUhu4bx1ZtmTeEBk?=
 =?us-ascii?Q?k+tp+a0w6UjDjThKCCTFr8fvu96BgEZmOShAACL5ESLhc6edJPDLjXJCG0ZM?=
 =?us-ascii?Q?+VJap0g/V5EFElnwTSVKXgYhnSSAHPkxHETDcnsPsNyrtGYANZEgV0NXLrXM?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bdeeba-7a25-484b-46dc-08dd9278b092
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 23:48:41.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X/wR/K0uVzguLzYHycYzkpJIdBERiyEMlGepwqxaaC8+/ygHUpqyrmr48K2DopD6FP7UwTcB+nfGZX99YH/rsEQip+fuqhsX+QktdK5/gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7687

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
driver for the Agilex5 is very similar to the Agilex platform, so
it is reusing most of the Agilex clock driver code.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v5:
- Remove incorrect usage of .index and continue with the old way
  of using string names.
- Add lore links to revision history.
- Link to v4: https://lore.kernel.org/lkml/20250417145238.31657-1-matthew.gerlach@altera.com/T/#u

Changes in v4:
- Add .index to clk_parent_data.
- Link to v3: https://lore.kernel.org/linux-clk/20231003120402.4186270-1-niravkumar.l.rabara@intel.com/

Changes in v3:
- Used different name for stratix10_clock_data pointer.
- Used a single function call, devm_platform_ioremap_resource().
- Used only .name in clk_parent_data.
- Link to v2: https://lore.kernel.org/linux-clk/20230801010234.792557-1-niravkumar.l.rabara@intel.com/

Stephen suggested to use .fw_name or .index, But since the changes are on top
of existing driver and current driver code is not using clk_hw and removing
.name and using .fw_name and/or .index resulting in parent clock_rate &
recalc_rate to 0.

In order to use .index, I would need to refactor the common code that is shared
by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
this patch is acceptable then I will upgrade clk-agilex.c in future submission.

Changes in v2:
- Instead of creating separate clock manager driver, re-use agilex clock
  manager driver and modified it for agilex5 changes to avoid code
  duplicate.
- Link to v1: https://lore.kernel.org/linux-clk/20230618132235.728641-4-niravkumar.l.rabara@intel.com/
---
 drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
 1 file changed, 412 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 8dd94f64756b..43c1e4e26cf0 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2019-2024, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
@@ -8,6 +9,7 @@
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/agilex-clock.h>
+#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
 
 #include "stratix10-clk.h"
 
@@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
 	  10, 0, 0, 0, 0, 0, 4},
 };
 
+static const struct clk_parent_data agilex5_pll_mux[] = {
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_boot_mux[] = {
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+};
+
+static const struct clk_parent_data agilex5_core0_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core1_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core2_free_mux[] = {
+	{ .name = "main_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core3_free_mux[] = {
+	{ .name = "main_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_dsu_free_mux[] = {
+	{ .name = "main_pll_c2", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_noc_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c1", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emaca_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emacb_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c1", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_usb31_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c2", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core0_mux[] = {
+	{ .name = "core0_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core1_mux[] = {
+	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core2_mux[] = {
+	{ .name = "core2_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core3_mux[] = {
+	{ .name = "core3_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_dsu_mux[] = {
+	{ .name = "dsu_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_mux[] = {
+	{ .name = "emaca_free_clk", },
+	{ .name = "emacb_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_noc_mux[] = {
+	{ .name = "noc_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
+	{ .name = "s2f_user0_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
+	{ .name = "s2f_user1_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_psi_mux[] = {
+	{ .name = "psi_ref_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_mux[] = {
+	{ .name = "gpio_db_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
+	{ .name = "emac_ptp_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_usb31_mux[] = {
+	{ .name = "usb31_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+/*
+ * clocks in AO (always on) controller
+ */
+static const struct stratix10_pll_clock agilex5_pll_clks[] = {
+	{ AGILEX5_BOOT_CLK, "boot_clk", agilex5_boot_mux, ARRAY_SIZE(agilex5_boot_mux), 0,
+	  0x0 },
+	{ AGILEX5_MAIN_PLL_CLK, "main_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
+	  0x48 },
+	{ AGILEX5_PERIPH_PLL_CLK, "periph_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
+	  0x9C },
+};
+
+static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
+	  0x5C },
+	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
+	  0x60 },
+	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
+	  0x64 },
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
+	  0xB0 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
+	  0xB8 },
+	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
+	  0xBC },
+};
+
+/* Non-SW clock-gated enabled clocks */
+static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
+	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, agilex5_core0_free_mux,
+	ARRAY_SIZE(agilex5_core0_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, agilex5_core1_free_mux,
+	ARRAY_SIZE(agilex5_core1_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, agilex5_core2_free_mux,
+	ARRAY_SIZE(agilex5_core2_free_mux), 0, 0x010C, 0, 0, 0},
+	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, agilex5_core3_free_mux,
+	ARRAY_SIZE(agilex5_core3_free_mux), 0, 0x0110, 0, 0, 0},
+	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, agilex5_dsu_free_mux,
+	ARRAY_SIZE(agilex5_dsu_free_mux), 0, 0x0100, 0, 0, 0},
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, agilex5_noc_free_mux,
+	  ARRAY_SIZE(agilex5_noc_free_mux), 0, 0x40, 0, 0, 0 },
+	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, agilex5_emaca_free_mux,
+	  ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
+	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, agilex5_emacb_free_mux,
+	  ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
+	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
+	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0, 0xDC, 0, 0x88,
+	  2 },
+	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, agilex5_gpio_db_free_mux,
+	  ARRAY_SIZE(agilex5_gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
+	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
+	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0, 0xE8, 0, 0x30,
+	  2 },
+	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
+	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0, 0xEC, 0, 0x88,
+	  5 },
+	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, agilex5_psi_ref_free_mux,
+	  ARRAY_SIZE(agilex5_psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
+	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL, agilex5_usb31_free_mux,
+	  ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
+};
+
+/* SW Clock gate enabled clocks */
+static const struct stratix10_gate_clock agilex5_gate_clks[] = {
+	/* Main PLL0 Begin */
+	/* MPU clocks */
+	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, agilex5_core0_mux,
+	  ARRAY_SIZE(agilex5_core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, agilex5_core1_mux,
+	  ARRAY_SIZE(agilex5_core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, agilex5_core2_mux,
+	  ARRAY_SIZE(agilex5_core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
+	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, agilex5_core3_mux,
+	  ARRAY_SIZE(agilex5_core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
+	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, agilex5_dsu_mux, ARRAY_SIZE(agilex5_dsu_mux), 0, 0,
+	  0, 0, 0, 0, 0x34, 4, 0 },
+	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, agilex5_dsu_mux,
+	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
+	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, agilex5_dsu_mux,
+	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
+	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
+	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+
+	/* Core sight clocks*/
+	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
+	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
+	  0x44, 28, 1, 0, 0, 0 },
+	/* Main PLL0 End */
+
+	/* Main Peripheral PLL1 Begin */
+	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
+	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
+	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
+	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, agilex5_emac_ptp_mux,
+	  ARRAY_SIZE(agilex5_emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
+	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, agilex5_gpio_db_mux,
+	  ARRAY_SIZE(agilex5_gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
+	  /* Main Peripheral PLL1 End */
+
+	  /* Peripheral clocks  */
+	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, agilex5_s2f_user0_mux,
+	  ARRAY_SIZE(agilex5_s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
+	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, agilex5_s2f_user1_mux,
+	  ARRAY_SIZE(agilex5_s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
+	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, agilex5_psi_mux,
+	  ARRAY_SIZE(agilex5_psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
+	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, agilex5_usb31_mux,
+	  ARRAY_SIZE(agilex5_usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
+	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
+	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  14, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
+
+	/*NAND, SD/MMC and SoftPHY overall clocking*/
+	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
+	  2, 0, 0, 0 },
+	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
+	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
+	  0, 0 },
+	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+};
+
 static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
 				       int nums, struct stratix10_clock_data *data)
 {
@@ -542,11 +913,51 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
 	return	probe_func(pdev);
 }
 
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *stratix_data;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int i, num_clks;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	stratix_data = devm_kzalloc(dev,
+				    struct_size(stratix_data, clk_data.hws, num_clks), GFP_KERNEL);
+	if (!stratix_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++)
+		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	stratix_data->base = base;
+	stratix_data->clk_data.num = num_clks;
+
+	agilex_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
+				stratix_data);
+
+	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
+				    ARRAY_SIZE(agilex5_main_perip_c_clks), stratix_data);
+
+	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
+				      ARRAY_SIZE(agilex5_main_perip_cnt_clks), stratix_data);
+
+	agilex_clk_register_gate(agilex5_gate_clks,
+				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &stratix_data->clk_data);
+}
+
 static const struct of_device_id agilex_clkmgr_match_table[] = {
 	{ .compatible = "intel,agilex-clkmgr",
 	  .data = agilex_clkmgr_init },
 	{ .compatible = "intel,easic-n5x-clkmgr",
 	  .data = n5x_clkmgr_init },
+	{ .compatible = "intel,agilex5-clkmgr",
+	  .data = agilex5_clkmgr_init },
 	{ }
 };
 
-- 
2.35.3


