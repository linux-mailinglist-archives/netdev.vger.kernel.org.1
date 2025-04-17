Return-Path: <netdev+bounces-183796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C568A92051
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B2A7AB5AB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7F252292;
	Thu, 17 Apr 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="q/MCVhB+"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E3347B4;
	Thu, 17 Apr 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901700; cv=fail; b=iTafOe3iCnnro2GmZSKJnc0OTSoTiJLMXeTeGdcmGKTgKhVGSbjGDyldqnrWykHTGuXVCh8kj9TsnXpp47BJMxzoK4BiPQ9EqrePzqR65B7EApS0+j+FuiHHZRlD4W/191qkBGqjK8IYrtFoTPpLW3KFsFxsyJkzVPJJ9cyVQNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901700; c=relaxed/simple;
	bh=GYlM3/KLrOKy2Z4mQsCz/kEn5sJfHx+c+fDn9+xY5Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PFlqPwKo6+YgPXq/CO0AxYBAuFfZk2JTJPQOLFs+SdJ6EH8Cs1inFTDs6+PO1E9unNLz3t6+1L5thQwp6AUXFSx+MzMGVKtmzSHMxq/sfgtnGhbFXEuGkl9fWmbJ7jKlv1JT2Hkl7H+fhYGdNHBvMEl9hwvm7D1XqH1yxQrTpt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=q/MCVhB+; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+Id1OcvIocr+/DUEtKcSek+Pxh+v/mrGJIo3bI82rQL6Sqv5yZh7BF/S6PDArsw6KSb7fSxgNANLpgw0xwxqYYf3GomR+y3x7bEZ6F6ijuzed+np7wKzCowLgQJzxwDScYoGcgf1vQePX3SwvfQhvefluYPeP7JGkG84bLhzd6g/FQOid4LJ9167Q89Dob9y3cNKrEBCHO5m9d3ip97w2WHsj22cTB0NDDPz0e2ENKr5BGahotD1tB+hzJvRpDQu1KWQXMW7CSxXw49MRKWOLYJHUC6OelGAsmikhmKTHMZST0/LqqtylrXPUTifFhPKX1tmFa2NHKRU3bG1xxxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzI6p92nlPa01VK2aIRcEPjPPSL4HweEGtqTkl9eJbg=;
 b=qRMtYWifdhzTgjmmrtehccT9zpEWswG5udiwFo5vOMBa9XIyFBcnpssIDu1hB1AhigoEbNpv8q+LLK4VNWo8IyCvgBFbBXuueLa7v7YGVAyv8PmpZJaB83/K7wmQPFB49Upp02lfC0/+NVdI3fmh7Zs6+8FG+wp6B9h4hzOX/gNLNF9fZm1S6YigyKUoTNlh1+zmJYrfAQaVeoP+nugYJdyhoYYlt2vZ6hA1hZeoNixkRr4KNpgzcOPtiUPIAtCDTSai4VEzUZUrprhXPSyAP3VjWsIG941NY/k7jREVclb852/XwGc9XAi6/lTU9fSQNR/udPGJvbC0Wm1EdEnuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzI6p92nlPa01VK2aIRcEPjPPSL4HweEGtqTkl9eJbg=;
 b=q/MCVhB+nJV1/6WIYFP48ohqv6YCgwlPx/sbRRg516b/z//ud4UUS5FwqX5EQGbTHx0siTC7gO/W/gc9MC4l/k2Mz5hAHOoc28uMB+UKob6eIx05nsU0Ofsxjty1wWYqLvk/0ImO6PVvn6t4hE/jNiHsO2f6C5oKd1RdQsHEAitYdBMRBEDVP/ATWOZy5ND8rCyjQ1zpA7RGltrFDgsLw9Rvrzz/cgYbbtTHwwYMuDmmDp0qYnVEyRNEPUxDGRPjMmRf2gFXPMgohe8Xo5+o/CJq7oFkkm1M2747iGjWnW6pTJMzXb3Hp0gWm5+wSbYX5g/IXVo/uEQF+zH1pdq1eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BY5PR03MB5203.namprd03.prod.outlook.com (2603:10b6:a03:224::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 14:54:54 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 14:54:54 +0000
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
Subject: [PATCH v4 RESEND] clk: socfpga: agilex: add support for the Intel Agilex5
Date: Thu, 17 Apr 2025 07:52:38 -0700
Message-Id: <20250417145238.31657-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BY5PR03MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: a41ef08e-7ed5-433f-f3b6-08dd7dbfcfb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wxAb/GWTBquZpQgcfE7PdMVr37znS499BDxYYYQP1BRwvGS2N7VKhz8NQce7?=
 =?us-ascii?Q?G5+VOXNCW8clJ5if8MdLYzNSzB+1PnjEupzcQ4MsazKe38MsR6mU9O0CbZLb?=
 =?us-ascii?Q?n6AlRqmA4e8i62/6qiMTJ+X//VZrlrV32ucRho92xT1I7eiQYjQCF51RSgoS?=
 =?us-ascii?Q?dfdPloL609QPpno2mIxY2UVU7wCgRMWo0dR19IsJ/GHAUMcwOOowGfawlfV+?=
 =?us-ascii?Q?jkjlS0RCqlNtoy8ffANm9t1TX/ErudkP4F6rh2fMcHyAgiccU3hraxqUBgFz?=
 =?us-ascii?Q?qB2deOJjs+ojgwdx5haAK1BUDkIQ+IIaIXm9QyWm78x8RrAR2fh1DWmgr8Rk?=
 =?us-ascii?Q?rFAkJgZjePWM4xZvrA+SUODAsntbUPJJhF4bjT6PnUbcXARpCjNmCa8N45y4?=
 =?us-ascii?Q?cMU0ocgvVRRuPJlaqjIMUWBnGHKABuE3UWKDmpvr9FyYXz83DTYTy0W38JcN?=
 =?us-ascii?Q?tG+IFOeLC0luhTGZ8IhCc3qoQj4lJoOu2ipAeH+5h59Y+jU85wmmec26vgjE?=
 =?us-ascii?Q?AgDDjc+EZZwMZO1UXW5neOuYiui3kDM6tT4FWroWHw+sQR6Ui6LbqU8SFtpj?=
 =?us-ascii?Q?yDK+N4Vn2I16pnyraESjHKvh/Mmwrg/ZI3ioE8F2S2KqRADG3MotMY4LMHGc?=
 =?us-ascii?Q?M72z9urm7mdcHhRXYUOphUdpl5tmdJFa44V10VdvZGGf8yt6xg7o6H5o0V9u?=
 =?us-ascii?Q?uG2lRKcBMCUIXPCWTU0i5GyYSlt4W2vjKxlNXLcEFSj82+83vlxz7hJTnM7c?=
 =?us-ascii?Q?D2LBfgBNCQ7p9mjO6ZSjg3VFb6FKY59bmwJI2j73QApL3KmVNsC4EHL66X2h?=
 =?us-ascii?Q?5vv6OXEZRuqmU6yyX36ZfEOZZn0miK3uhMhANe8Fxf/UIYaeQ6lD2DWp3F0K?=
 =?us-ascii?Q?Gk97Es5QacvK5SthYf2Ach5QVpX2rKPv+OEvHIb1rHgdwMIj8J3aeRTldx66?=
 =?us-ascii?Q?Gwo9XBsr8vz6tENY3RO8nchdu0g3IPmQC5T1d3QbSwkonbZQPzknRrTcU3nL?=
 =?us-ascii?Q?0WnpFsuvec3q2x0SalgS2d/LnuOtUQY2q7uIXMS/G7myVwr1P8Nv6SC6ttsu?=
 =?us-ascii?Q?Ol6cM2J7ney6Zl75Zb/ZPLouPErO59K4KXmMo+UlPJLcYpJahb1Z4FaTY1ED?=
 =?us-ascii?Q?WQC52qJSBjx1MLkcU76iRcnv+C4nHdYjgN2ieGIw3gWY+yUwWSunVEr/RjMJ?=
 =?us-ascii?Q?lvqIQD29kqiRj2VXSMigcfOGYtdU4wA4bT/ltX4GbKPrPye1wyVBfgDplxzG?=
 =?us-ascii?Q?P9r6ImGLzNoNcV3fysDHSNcPM0jhdwRuiX7NTCDSD4hioMppm6Ibw8DKmPmE?=
 =?us-ascii?Q?f00NPWDnsHHIzf9Ps8gj/sIRdyAll3lqnMjwjye4X0D3wS2k7/Ed81QxayDB?=
 =?us-ascii?Q?8l5CutQRvWr78hEsH091RomNYtaFiwlM/WCAIVnFe9964P0MmIh0AcZF7TS3?=
 =?us-ascii?Q?GTTHFvSIBjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p84imMqD9PhaoH0mBjyZKK8DwsB2yIHp08mPZ3gZXqusmDWWvKsT/Hbmwryg?=
 =?us-ascii?Q?6eGKkk8rMK8KzjgN+qo4PUXL05di/K36YmdZ5xXQlWU2Nxa7kWPooL/8YaUK?=
 =?us-ascii?Q?r9anQhvdNFi2H4a6jSiAqVa27LkEb9Q5adIJ4DKioJ4spsvkGIYt+E3fRM91?=
 =?us-ascii?Q?iRafrXL+NtTiOkn1R2ZVzdbHy97hnGXMmRyryVPk9uME8t7iOJte6MyZdXsg?=
 =?us-ascii?Q?NKnFYr7bcziOOiUNLftH7tXpLHviplVyqTvwi+7kaHxNFhEeX5DjX8ZiPQC+?=
 =?us-ascii?Q?rZROgOHNLr1+kvejfRcNhfiHgiElnaU179ip56ujJNn318naXP2Ez6TWwUzG?=
 =?us-ascii?Q?JGe3pSu/E33FsCpSV1lsL5I/BhvKEPYi082pIyvuqtTf/LNRkOdwyqwEHZkW?=
 =?us-ascii?Q?rSawtQ+I3w5VXA5mFZ2uhpptp85iumsC52PpcJyilgNXHAjiSZd0Uwg5IPEA?=
 =?us-ascii?Q?R6OJf/ywv/VO4WZLfH/XFGNq9MA4QskVyR2mPjd2t+/OC7dBqcZgl9flP97i?=
 =?us-ascii?Q?7AMz4HblRX4h9gLeBifO9RgWfEQ8oa7XAzQRAVav5/HIa/XBWgJDzZQ0EQkS?=
 =?us-ascii?Q?jwgLvccpjzPBs8AilxA5Ca5unKoUCTi6wDUo/3uRppaYARRYPKzk9yKdQ4VN?=
 =?us-ascii?Q?bh2jIRtklNIgGN5Eou1pulGWQbuk7wga3n5dCoMtOx87qzPZmvYWWvvWm+1b?=
 =?us-ascii?Q?SXyo6Jlp7qOZI2QhB+QBmZethlXqbh1q7C1eFQzwYTYClvbpESV4DyKJb+H2?=
 =?us-ascii?Q?PHY7dj5fFHkwutJ8SLbrLocq4/j2NPJil3lvhYUDx8yg3NI1JLHofuIPO+ce?=
 =?us-ascii?Q?3D/kiUSvwdG6LZzGJdoqRLFTMeAOb0kPWslXhaOkXQXYuMyT7nxZB7fPw5uV?=
 =?us-ascii?Q?gwNmB3bmeoxha5G3/0l12KFf4tcutocDShGe4l9KWs5r4QczWe3XLYl2fUnq?=
 =?us-ascii?Q?7KFJwKrVLSTCSuEF21JbEdrewNoaz5k4GU5r9Oc8WdR8zdP0AZMn6Jlhb0sH?=
 =?us-ascii?Q?WJeJTBavsuIOnwk0BbnVXN2nKIWoaHEtIHB50EWoZNO10XihLdHFJbBqpntR?=
 =?us-ascii?Q?OQa6OJHJi8aoKKYJEO2Q4OlTSxjz6iElx4/nSQneaCIcf1HbJEfMnKVde2nl?=
 =?us-ascii?Q?MOh6oqxejZUvbQuvw5gctRW4Z9GvuhrJnDPZVAV3u1Ik69Kyli4DetBpz0bo?=
 =?us-ascii?Q?cgvBy2DY93mMtLbl0aEw/joxNznkephbd0x5TfGSvhZ/zskZ5W5JMCQFvIof?=
 =?us-ascii?Q?o0H8SnAm9peLsZcKRPXKxE/fZITmn74YNJiZPyaJRxH6/fC+o1fBDYL5xfYk?=
 =?us-ascii?Q?AvBO1gjCvumUxJTVt5vFY2YYDDsCt6n22G6fOL2SIhUv1Hnwr9glnzR8mFTt?=
 =?us-ascii?Q?Kpn4b67cv+EjElqRtkcA+S32FViS3i2/DfIzJsj+i9Rp+/NLcVMu9kb0zkiA?=
 =?us-ascii?Q?vwo3muno4ULON9Dn9Js//mFIktWPgXrENFs1X7XbiHqVeeSymUVRK/YvA7e3?=
 =?us-ascii?Q?XdiF3+gSon41TjSXFHIEaGKXIaGMhSg/7G+aAFPvg9bPIE6i0wtcrBpViSTq?=
 =?us-ascii?Q?lSOMl3py0xtUNbjGR8Q9u/RrfP88p/O7wPJvKPEZxqDIwfYre7BSOMJEEWZQ?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ef08e-7ed5-433f-f3b6-08dd7dbfcfb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:54:54.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz8iC1Uy+bpJfvEZ3p6EkYfVCcOYJvwPv/H3Ja1AWtCtrrsqEdw5KQdjD3Zq5kPgRzmwIUBnl/cUfZzljZEeZdFmmLL6hy8mo9t/RTz2DMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5203

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
driver for the Agilex5 is very similar to the Agilex platform, so
it is reusing most of the Agilex clock driver code.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v4:
- Add .index to clk_parent_data.

Changes in v3:
- Used different name for stratix10_clock_data pointer.
- Used a single function call, devm_platform_ioremap_resource().
- Used only .name in clk_parent_data.

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
---
 drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
 1 file changed, 412 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 8dd94f64756b..a5ed2a22426e 100644
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
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_boot_mux[] = {
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core0_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core1_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core2_free_mux[] = {
+	{ .name = "main_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core3_free_mux[] = {
+	{ .name = "main_pll_c0", .index = AGILEX5_MAIN_PLL_C0_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_dsu_free_mux[] = {
+	{ .name = "main_pll_c2", .index = AGILEX5_MAIN_PLL_C2_CLK, },
+	{ .name = "peri_pll_c0", .index = AGILEX5_PERIPH_PLL_C0_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_noc_free_mux[] = {
+	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
+	{ .name = "peri_pll_c1", .index = AGILEX5_PERIPH_PLL_C1_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_emaca_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_emacb_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
+	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
+	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
+	{ .name = "peri_pll_c1", .index = AGILEX5_PERIPH_PLL_C1_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_usb31_free_mux[] = {
+	{ .name = "main_pll_c3", .index = AGILEX5_MAIN_PLL_C3_CLK, },
+	{ .name = "peri_pll_c2", .index = AGILEX5_PERIPH_PLL_C2_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
+	{ .name = "main_pll_c1", .index = AGILEX5_MAIN_PLL_C1_CLK, },
+	{ .name = "peri_pll_c3", .index = AGILEX5_PERIPH_PLL_C3_CLK, },
+	{ .name = "osc1", .index = AGILEX5_OSC1, },
+	{ .name = "cb-intosc-hs-div2-clk", .index = AGILEX5_CB_INTOSC_HS_DIV2_CLK, },
+	{ .name = "f2s-free-clk", .index = AGILEX5_F2S_FREE_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core0_mux[] = {
+	{ .name = "core0_free_clk", .index = AGILEX5_CORE0_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core1_mux[] = {
+	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core2_mux[] = {
+	{ .name = "core2_free_clk", .index = AGILEX5_CORE2_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_core3_mux[] = {
+	{ .name = "core3_free_clk", .index = AGILEX5_CORE3_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_dsu_mux[] = {
+	{ .name = "dsu_free_clk", .index = AGILEX5_DSU_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_emac_mux[] = {
+	{ .name = "emaca_free_clk", .index = AGILEX5_EMAC_A_FREE_CLK, },
+	{ .name = "emacb_free_clk", .index = AGILEX5_EMAC_B_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_noc_mux[] = {
+	{ .name = "noc_free_clk", .index = AGILEX5_NOC_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
+	{ .name = "s2f_user0_free_clk", .index = AGILEX5_S2F_USER0_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
+	{ .name = "s2f_user1_free_clk", .index = AGILEX5_S2F_USER1_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_psi_mux[] = {
+	{ .name = "psi_ref_free_clk", .index = AGILEX5_PSI_REF_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_mux[] = {
+	{ .name = "gpio_db_free_clk", .index = AGILEX5_GPIO_DB_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
+	{ .name = "emac_ptp_free_clk", .index = AGILEX5_EMAC_PTP_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
+};
+
+static const struct clk_parent_data agilex5_usb31_mux[] = {
+	{ .name = "usb31_free_clk", .index = AGILEX5_USB31_FREE_CLK, },
+	{ .name = "boot_clk", .index = AGILEX5_BOOT_CLK, },
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


