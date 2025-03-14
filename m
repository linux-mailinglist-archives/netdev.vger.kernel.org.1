Return-Path: <netdev+bounces-174932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFEAA616B4
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 17:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDF87ABAFF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2E62040A4;
	Fri, 14 Mar 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MHRR7bLD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36272B9A5;
	Fri, 14 Mar 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970810; cv=fail; b=OOGPmLdnIO4O/uIH+RoMcvDf2KVHOv8tNLDVbpIiLGJrbvhFh385ZYcmG+LZ9tbF3FbtYlewM0j1+R45yZhwwZkm+l3mC7vN8xCnvio/u/eEXQTvtzqZrAfWmt6UiivtrMZGUWYg5g7q+uYom9fTS/4PgP2mE64awKQ4s2diDzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970810; c=relaxed/simple;
	bh=GYlM3/KLrOKy2Z4mQsCz/kEn5sJfHx+c+fDn9+xY5Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SiX6ufW/sHwyKzhxbJ2T7ObYeqzPj6xTdBDvFzPnZmCp0j8UqTUavIxj7Xm82kfE9+8xH0irTIOIptjq1nxRSq/SSIsOI2PWaH/C1Bu5yHgjjymkll7f+mjijzPyPkSvtsIpSSItxNxbzNfWrumWM8k7PMNT8XFqNsFpas8zgyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MHRR7bLD; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjtI0QLvvqGjQDhnWxjcTXp2Sp3WdlHFmA8Uc2Jm3qQXXD+hAkJ5x7zzX9IVxplr/UHPcNxfnxLPyG89rWWO+ZCPnaevto/v9r4dEbsQzWCnTD5lfVfCST8u6FVCy0o2SF/61KRrg2PVvayGeAUj9KS2RNoYoXQHi8zdfSbpGMTdqWAMW7zbl/0vBmMg3hg631IbQsTnVvH5LiPTuMOByLcaMnCx0OuGcKU0MDAkRH3TNZVbzBFWYHY0zuBNQI3NhGcn1PX1/J6XVBNOntkEny5ggj/sCu3PTh45KRIp0GD6+8uoyyKW8A1zp9fHZwUh7vvQ7aKhUKTQkqdyuldmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzI6p92nlPa01VK2aIRcEPjPPSL4HweEGtqTkl9eJbg=;
 b=yBvCvumYJnvffgd2ynbYBVy9RNZ1N5gBT1SlsoC+AbIn/rfpQHWUKbh4q82YmE92mvVzNRyqxlSKNoQVUAItflkl+Q4wgz2ZykrhGBFxI1BkrTn+FHSVXMrRBLKoMayfV6BYmPl0hhLU9WV/4lnV3aCCUl9PgcysztMmAloS+sVFdMR37DPEzS8ttPGmBTFd9Lz5vPO/XHDAXIjWrsuNXnu5xUliKlVEu45DiHzuERTrVpHqzbV4kTfjvVJvAOvXYqDSNe5tT2kh1wFBeSnJm9do7GYeXBu8pZp8uGiJm4we+k1BJNxQWUVMM9wSvHwAAfvVragVswg6tfUgkuqNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzI6p92nlPa01VK2aIRcEPjPPSL4HweEGtqTkl9eJbg=;
 b=MHRR7bLDFSU9Q2D/Cr31Jq3hlpTlAo3cXAcYPJ+gJr931tcUBNIlyv7kxVqzlxDlJTS/9pBuyP4AWbJ8TrUuSWm/UVsputOz4OqSpPIrJIL72iUGXo8Vzq/U4l3biuGtLzcy0Sylhkd75tgl1ioLLno/D3Ak/cM7KDwlFZLFlS4dASDWcD4DpxicMiUDKz0Fk5hqVnJn5tF8L6tozKiKJSmHyGOPHdkln6kjWqm+cjseSIS4aJ0HitdAx/pvatF1axHAbKl9CFU0i0uWoIrtKMAdiQpvOLcOgGvOgoL0ej9uy8OXHhfHvF/PZP6Zz4479lVCGyq9nfbqulUWC4jskg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by SJ0PR03MB5568.namprd03.prod.outlook.com (2603:10b6:a03:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 16:46:44 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%2]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 16:46:44 +0000
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Teh Wen Ping <wen.ping.teh@intel.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v4] clk: socfpga: agilex: add support for the Intel Agilex5
Date: Fri, 14 Mar 2025 09:46:26 -0700
Message-Id: <20250314164626.43868-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|SJ0PR03MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7715c364-353d-43bd-6379-08dd6317cd6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcM74cCV2oi5uHSOk0CCYUzysjqTUQ1KKdPXyZjeSj6vwDvgntJuQpIu4guN?=
 =?us-ascii?Q?AL9HCmV3nVqlwtBBaDI/VX9AUPNKDHLfRCvsQFFg6Vys47iCpzIYqzPR8k+U?=
 =?us-ascii?Q?bCuY1ljAkr8yg1CnXiFJMP1dX6onciSz0cDC1+4XfQwjq7FjgSLzowoQyKCA?=
 =?us-ascii?Q?7riAe2TtaJaJ25wjoCK/UfmP90rWSkXTBX4uqdtrvkZ6yQgWTOHwylmDblQe?=
 =?us-ascii?Q?Da9biR7+cHfmMx4XC6/Lrq0zsAL8oEqhFcW53LJDcYmuxmJPdL/5IQz9n82Z?=
 =?us-ascii?Q?TruegVryEh5yPQLE30oJzvOrplLeuCJ5T4eEgc7w26Fe2BQRMe2UrwQpcwOy?=
 =?us-ascii?Q?6ylwA0co4qDa5mxv2Q9SBV32qlrxoKXNTdVFG+VFVyNleroaDWaaFcvQGtXb?=
 =?us-ascii?Q?MxTFLt/5HH9BAxYWktW+gEhwMYRJFgFJph8EuSOjMsxBTg6YXLSS0AkPPDKP?=
 =?us-ascii?Q?7Fs9Qzmz+AvuP3gepgex0KmEJtnN2CSV59TAJpxsJgAI4qMzCChVbxZKNRhM?=
 =?us-ascii?Q?FQGZnaYiDpb/ARfLgH6KIethmNYA0Y0It1YsnBzf4+mrvLhtGN8zDjW30WCD?=
 =?us-ascii?Q?Byg7Qw7TJKH/RvpST2VO9tCsQF2ny6WmUOK91830yNVpR7VsCGPDT6pS3sj6?=
 =?us-ascii?Q?CbSEcHG/JJnoQTngLJES1HQQyKQPWVMMR++eq7cdtHqZIxMQw0sTffdm1Srb?=
 =?us-ascii?Q?rsMr83zqk3Y2bom9Jdnvg4y+8HSLHJ6MqKwM8myf5C4Nm196XNJLRml56e0l?=
 =?us-ascii?Q?QaQfGmz3H1s6o2ld3j3JiE2JAsumQJacg3N2Ii5EKtgExxS1A+cZsiqVHmpP?=
 =?us-ascii?Q?ZrUvLtfH4dD7F0+5Lw6mGE1sIgnlbqJ+AtZvYLHOfPEZdu2wtan02jTaNpe5?=
 =?us-ascii?Q?O2X+r5cVGI9iiUIF/cUOY/UPIl4rraBtlxZBuUxkLluBQtaH7EQUKntfrwc7?=
 =?us-ascii?Q?NthClrzqgXkEEDcstFSh1V8oxtUc2RxBrrrx9vK7muSlsENb4yprd4D6jyiT?=
 =?us-ascii?Q?naAbeonmkwR3CQOFWKJlDQWSNuzJ0iZDCkHHkqRciJBVStYsDt2fWCZvZhri?=
 =?us-ascii?Q?SMD2LnMDaMVz7axB4CzaB3fsmvNTpzW3L91hYGXk6zH+SaSNtHwuPVf7uaVu?=
 =?us-ascii?Q?kW7dwVIYSovBLY/HhG/eyLkpVL2TH4Pp5H+leCxsqCs01vrqhCFhCge5i7WD?=
 =?us-ascii?Q?dcV0+D54U1azoelhu6+7TP9rsAxPyuQbguyCtObovOI8O7wlEre14uX10cWm?=
 =?us-ascii?Q?f1WzJexcYefrB0em2lKYDGtjzBT9egW41eQK04Td9fYFeziO20ifp4l4s9Bm?=
 =?us-ascii?Q?3rAehlcgz6ZW/LAY3/+IaMStH4afVIViDs80n95FWzwPjymxTwUQnIHUymbe?=
 =?us-ascii?Q?LnmIzPf6RRn1DR7ZEr2XgsqD270e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I1jyKN8ibsVN021T5qfiVEz2Uggnh/7EnTlX+obYI3w2Dc01aOc5s6JBrr20?=
 =?us-ascii?Q?4gvjAd16SBeF6kmXCgIVQgKAU2bwuWtuD/ZY4u5Vj+lqnvDCl/j21jina6oL?=
 =?us-ascii?Q?ydiGjCuvjEXWS+eC8Am/IOaqte8P9r+v7/vM7U/95qFjL6z/sdDY1Mof3jKQ?=
 =?us-ascii?Q?SntcYI6X3EBw0VuJdh0cNYrKdcS5hZDf4Gl3l9kSjm/e17tyqPYhgKSgKGVE?=
 =?us-ascii?Q?LZv+60h+hU3Zu6lKZEguqXRaDTYIPnfVY+CoNaBoBEKJOAWZkIJlrsoSptIu?=
 =?us-ascii?Q?L88VjyQoeXRkgtRJbopbCvjcJZJ8s0iNv91qn21YKuyTizdw7ZJk1/76ABX4?=
 =?us-ascii?Q?0KhQYzOA1ZlmrwxM8Ujpi2MCzIook6sklK99+2kpCaTR1JFC6rfqnPokH1J7?=
 =?us-ascii?Q?iPtjFMwU6wGjCrmR9Yn7AZMuhuUZWPy5wq2WwgDBETuE8dofriraaxAo/BSO?=
 =?us-ascii?Q?h2Mam9V0l9jqPR0NqDjeRe4StxuH9IYawywskhPo+QWoHESdxloBTAoe5Sdd?=
 =?us-ascii?Q?O11jHWqlb7nQK9xDGxoSMyDtXz8HrWzs9Xg/4CeuEO1eK2KtuCFLJoVtJQG+?=
 =?us-ascii?Q?ULesyh++V0mejIQUVjy8QaPePk3uvq+dmRVDiKGRHPb+Q2VpHt0uOeHVNvGP?=
 =?us-ascii?Q?2R+cLFyPWeZY/wMfCjn9lGk/sbCjn2r5OR5SZkHQOZ96erYbJplfubkfelCF?=
 =?us-ascii?Q?oAJvV73LPORsaMWKWAAmUwvVLLhmDmskCp04XOpLKaXWIpeJyB1IzIjg2UUz?=
 =?us-ascii?Q?2JIxQwiWVsf2lUi1hG/Nq+vuk4FklZRCL8xF9dXmVf6UuVpyDGHq+xH37z1F?=
 =?us-ascii?Q?Xq43ZXVGAiaVduI2U1cPEgyg8T3tGOAiQ/9AdbEKDHPS/x08yBSNS377koDd?=
 =?us-ascii?Q?XJ7LuGAtZZQIuREU4s6q5RJUMUgKi4tAWQgOSmEHJtZeY0EmaltgIdTcqU/U?=
 =?us-ascii?Q?YgNuGnPkBJQ1ZaNq8m4D2FTe4NOjGSBbwOVJysohILFzE/yKUeQcWP8f2bUP?=
 =?us-ascii?Q?ZcI9zMdjLi/5yi6fW6perzlA+7x0ANvzppk8K0x1MnfUecZ+ZjaXufuJof2i?=
 =?us-ascii?Q?TZQmZfZ4FxuNTVzXyCdUwKBd0qkF1Tc9J89oGPH0zI+68GTBH+JGgY5SLz9L?=
 =?us-ascii?Q?zMLUHXoPU/13PcVUQ18l3yu0h90IbVKjWSne0LIXqMWqddoYZE+FBvuLsQ6D?=
 =?us-ascii?Q?iYRN4NIdAdN20wts+yCCcjOVTCHnOFf5+ZLvwglvzqL/PcPYT7y8WPqaKPLW?=
 =?us-ascii?Q?HVUwZKtgm70BqckMJ0CzKou0TCoX81rGWPZ76CqZ8hbEYENzs4ae5mAPb/A+?=
 =?us-ascii?Q?5TtKV7g5ae/kjlsqqku2RtgOQuk9mr0BInr2IhtXCMqQ+D6rBNqO6/tdo/+O?=
 =?us-ascii?Q?6K4HRoug+vF4pfruNquXLp9Zhevm4KcWh8iodBU+iPJKwGvbBy4hCQENvnXI?=
 =?us-ascii?Q?Qwe/R4jScIWAJET4Wa1AV7IOTVOmwAxxm9Q/6sH5kbgz/fiHqWrVO4ufhU8e?=
 =?us-ascii?Q?C9LPbcgC3kfFv3S6sxbbHdmJohtGXXoE4pCXKfCp13g7e6y/QudW1NKB+sOx?=
 =?us-ascii?Q?TBy/9oVQIi381c1IcM+CON5hf5LrZLJ0TRVOC5jXisb9uqdtf/SklCHbLa0v?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7715c364-353d-43bd-6379-08dd6317cd6a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:46:43.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CshzWgVrn6XIGTpAOb1S98dHLhxLRSxeGQZ28gxXwpV/5NlkM/hLhxHgtRiNrY3a5IZW413MKz30Mf0tYhbFopkQh3TWv0KcV1/9gRo9xgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5568

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


