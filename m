Return-Path: <netdev+bounces-200398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1629AE4D2F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBA17A2D0C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41592D4B69;
	Mon, 23 Jun 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U5X8Toq4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E42D4B67;
	Mon, 23 Jun 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704810; cv=fail; b=DpQ3kI+Wpvk/P4F3lJd4BkJSXRsD+X37w92XNnxFEq49XTzb8na9e6cI4VYTrUNKs1RJS91g3gSAK0rNI5CEdGCwV3zb1hWKF7B4DyUuUQlmX9hQRKPh3UfgBPr8q4eqL99NgyRfWG71cldd73AozkdEHfMdeORSphBVOaQA7zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704810; c=relaxed/simple;
	bh=TPqeMh80gQBOcHpui5dsDRlcE8x3uF7B3//Ah9f+stc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jn+HXXRmaqTXJRBp7wG7rPsCaPkHXFuyvic9eAtMdBtNoMhfctcQmIow/NzGIA72w21Mzm4+iWRdcDzs0CtTmR+RSaw5w6NQr5sS1sKzvaP5FtjfR0vCNSbGhgGHxKY95vrgLNK5hBttakte65ujwq8PHQUA/zJrFR01GmjdHkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U5X8Toq4; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaGN2U3fxZFsFPtw8TccYoQhLin+4JVCC1gdyx2DEU/Ad+kAn4G0xZDnIqgTJ9ydUCBQxzW9lXT+NIWQOoZDoCSTPJS8r1WKjgi0uEvlQgRv8Z2LhSDPcpmah0KpNdWCvKCmc6uTuoNS1ssbI7KnFdPPH6wznXY9mqq/M3Yq3J6qzYo0eb9DLrlGT4NY69ygkpa4tBJoQZqWbTE9C6tcVJ6mSHOtAr+7WCnqLU3doX1UMvGr6hYQwYfos5yB0Uvbqoxx3ji/eQJmojymZivtFZ/R1cRhk3vHXQWqEuPfpdE792KnKeXdEo+G5fYNtCixvDEUeZhMYCcJ3WvZu0KZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynCs2MTFLP04N/27d+JtFiYzRrTc6zpH3o89lRx0a0s=;
 b=eIC7pG/wR6Yaz3w9tIAqebsApxr0IO0oen/14zz5p+ev1JesmA8bSWJNTEcHIGk4pGa5P2GnNa/vxnd+2hTIuONt18MYigYmmTvcrPiPZEBHUt8u5g5KJWcxtCmtONTw530n58swmK/PEJxeuG0AO0Ixf2KzejLGALE3jZhjzuPdKvJL/FbxZe7Z/NJ2Y1Ngp/2rlGDs5P18grWx8KhLbkOLqbgU8WuG8pb97mu9hV8c1igFiHI2NtrHHwwFbUA9BvkYaI5J/5h1w0fm8mLmEavIWZY4+gGPPkpxHEpb9Xt4ZTxYSyvtRYiz6AYm4En45hnJxa6KdMM4zMTDpQXJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynCs2MTFLP04N/27d+JtFiYzRrTc6zpH3o89lRx0a0s=;
 b=U5X8Toq4taFTqOl9wh0crHKN6tvF17/bYBhqvRDZamBNvc1//opAI+QW4jr0zSaMsxEw/ENk4FDsVSAXmIm86XRd2HqNdD7S9Es7cAhoWxrD/qpT6L4u+1exHDXN4lST70hMZBRU4ib2ra7Euig4xOtOqYE0wA+/yi54GENiBJZCDVfSeHSfF01o0n+42F1U5wMbTrHsoI6gymInyeWGxgbPU91k421m9UpXgBs00HyIi1n0RnXnw+e4i67fUryr+9CYNZi25lsfAvmqXmsUdLsvyRgkG7nnXS7r3HRNwpzLSvBB2wQG01Hsp1xO8MR7WEiB5bB5K420B/Ujuz3+qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by DM6PR03MB4970.namprd03.prod.outlook.com (2603:10b6:5:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 18:53:25 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 18:53:25 +0000
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
Subject: [PATCH v5 RESEND] clk: socfpga: agilex: add support for the Intel Agilex5
Date: Mon, 23 Jun 2025 11:53:20 -0700
Message-ID: <20250623185320.7276-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:a03:80::38) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|DM6PR03MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a2471e-3a49-4522-41cc-08ddb2873b73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MelTD1kdqRkGtpRmSwQOcY0ok40+2WO6CTmnj4jXM6c6NTHRnkaLD8zA6CUX?=
 =?us-ascii?Q?Ggp4U0jyL7kX8Sk+qgnWAHj4+kw6xNqWnxRZG5Eu79ODqPlkkpINhlhdoKt0?=
 =?us-ascii?Q?OVqlDYNpF4FOPj/3jNR/0hjrDXDWDluxTdaHBrrI5FUGUCournPuzXbPIzvf?=
 =?us-ascii?Q?yDuwzZZLFTAZtzMKRo6g1CvlYaHyHd7yw19K8QF9ILFap5hODJw5W20fDn8R?=
 =?us-ascii?Q?KX6du16UOdBwuwAL2+A3iXYIle8N89e0BU+FhnXBNIY2PjxVVPEHulmGT6VU?=
 =?us-ascii?Q?SQ5eIyyax0+aUj7URY+gSF71waGXbDgbjkB57XI47XzdhzRR0s3QCA0JsNxO?=
 =?us-ascii?Q?aPMIZ8EU9yqkYmo81XWEcQnDiUUgOLrQWr0lnpyNvKdcqj4LGJ+upy3CP+WB?=
 =?us-ascii?Q?69Mo9x1QniERpDtyzhEPoaQmb7Yl7ui27fCAGbPvQtYJcyt1Y/fBGeEoi2b0?=
 =?us-ascii?Q?ykcTdEgXl7migSPVYa8CB9WQJCvyB4O8obP4NP/7cQi4rgTwAJBsx/4yFVkw?=
 =?us-ascii?Q?rwYMfd0LxUzfgFFIW+f2huNmIS5BtxMNzNRmtuyKmKs0VRNL1PL9KjXcI3iQ?=
 =?us-ascii?Q?3tZFhJ7n6wisxEn6V3NiI9mtzL25t9J7qgpnwzErzW5RD/yMqjoyZBxu5vY6?=
 =?us-ascii?Q?AzDYI2pmihVgz8MH5TP8HB+omeNQHLMHhlBVIwsS8mF1yDyIBP4sOTuA7J0+?=
 =?us-ascii?Q?kigxwXyPOq7H8pz270PwKH4cR8oydXj/LwN9fKX0CBNyBJORUMB3kL3gCbIr?=
 =?us-ascii?Q?HzQ35aKTZfqUL7gmmwpsghiPwudcpTmX6zRh3mFXteyK65x/YSQPjyGH0xCf?=
 =?us-ascii?Q?JYaoiVFNpKlacQnXmXPIf/ZstZ3TcIBFy6wwqbummubiRsJpXzh5LtkkZ1t7?=
 =?us-ascii?Q?fH7Wjh/bAhgupEccQXGvA0qUVbOdKNwgCmhDkOZiSrIPtz+kOUCWWnFWoz23?=
 =?us-ascii?Q?yPfIqDoeqfZcJNkgjgQxHBQHbw0zhU82hEsDH97rgSSQTEJRnsA/MOc7p8ro?=
 =?us-ascii?Q?nIgMhu4a4HWFt0YUhu6DRG8Y/ZAPQgwZ4NRYNujh9N4dNR3Kl7aJYVOZlcz4?=
 =?us-ascii?Q?INMU9jMJE7klBCRNPhG88K/e5JGy+8U354IT1xWNklFIh5LWGf+afOn9rlw4?=
 =?us-ascii?Q?U99gYNLVI6BeG7lGUMvdTU/vdLDzbmZ8eWUk/D59fIUN5xtdhKJOHszmcXGG?=
 =?us-ascii?Q?9QnOTT4HWH6GPU2PwTnsUrbuHhpN66L4S1LcT/4ON+9ghU+V9RADWhDcfZT6?=
 =?us-ascii?Q?qPIufQKBktj692TCZWwhFxkGDcvwEsZBeDYL7gOahlaN2un3qTp2VkSi2Rrz?=
 =?us-ascii?Q?1YkRX5TdNR45YDdfbw+l3rTJa96k3Do7TglLeOrrhF0agR+Moza3EspdYWJk?=
 =?us-ascii?Q?urqoRME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2WHuvbWbUZWXQjxzt/98eP508lguaHEAKR3EauNXGclthTLzUqm+DaUXmze?=
 =?us-ascii?Q?ErUtkLpquVmB4bjAbiHQdPjCl5/c9Ujk6R2XYSWnHFmaHwPCR3jEoH+fOjOb?=
 =?us-ascii?Q?jHQwc+MWx3L0osHgd9tWy2FebfKu7ax8IuMVJp5TmnDqE8VymsIWh4Q/qnVX?=
 =?us-ascii?Q?5tiA5gOJqGGJJZm9IX3W9WZs/cR/te1Hk9CuvFURrG8dRnxitzP2ylBp7hnH?=
 =?us-ascii?Q?PBYqJdv1gL59PxEG/Kqh/U+YYkF4FMDAEoFn3tPH65+io1Ge7M03OWn7S7FI?=
 =?us-ascii?Q?cjxRwbNg7fXqUxfEYbPG0ecDINFYzxj6uSpNqqPAClfnx2eXVodi01vGETxF?=
 =?us-ascii?Q?s34fS/W28eQFX9zEaGJmDdUs5WTwegFTkaL652PtSMRXAyWAMVNrCX+4t6GP?=
 =?us-ascii?Q?lND0jcmpzsJJf8s/TAm3JVZPAqBuuniZtEijbT0vFvZRLOzj/7n+Md7xHQ+c?=
 =?us-ascii?Q?60Xknejaau341mmmV3juykf5/2Q4X7kAafO9O/QnVHWHW9AblueY6qV3RM3Y?=
 =?us-ascii?Q?4PBa0hy//nQKCg8rju1153Rqm4e5D1l2NjV2MEnrRdO6GfO4xQblbNWXz5ZA?=
 =?us-ascii?Q?UdK4k9Y5iz5FPnIar38qk6VOZu+zbuyKXJ6TJgVBR/X31dVWBQI1Cdbu1N8D?=
 =?us-ascii?Q?lGx3/3s+OHCJSvb5edKT2stDY+jrwK0cfM942jvAnhAzaeKT490Nba1CU8N3?=
 =?us-ascii?Q?dvnV8Ezg/5jZMFb5WXxcztECvIDaZwVMaNzSPK2JVzWhZAWy0sgYPNALHo9j?=
 =?us-ascii?Q?Mqs7IG6TtZ22dUHzQmYMUhSCwWvVN+QW8Y+VtMPiulqkeuSPwR5PiOA+VptB?=
 =?us-ascii?Q?xC31htIoH92aShMBkj+T3dF79MNEz+TC+faS/anAb+6JAwKXts3Xaajo0usR?=
 =?us-ascii?Q?VAroji3QixSFIxrN+H4QGP+rwxexH7F3RwMvZAp1DbcUvBgUgiDw+Gs/whpv?=
 =?us-ascii?Q?8gYjZlThhF+8wFcsavIfcnS/IqplvRy88BLEZU4hAEWAUEfQD/dRBjJ4XQik?=
 =?us-ascii?Q?E3ESWBGH2aGKSOvaSr6QsCw/NmkMTvVOjkxkCzfy3Vb3gXBQWU22w7iHS1+q?=
 =?us-ascii?Q?4S6ORzj5s39+xBKzyD24Pdcd/qUnWWDQzixP3rhcfeacVT2xI1fNaL85G6Nf?=
 =?us-ascii?Q?4SEZ19piiu8ljGUnqkZ5aktqI2jPIVS/IjWLS3mI+o2tvLEARyfSZkt1u+zn?=
 =?us-ascii?Q?s1fl5E6fdRJcUqhS/axRsH3BjxbKNPpFT40erhGZqtqFIlwgA4pypvcIGsNl?=
 =?us-ascii?Q?A/aVmK9YE6czFL7ZJOxRGBL9QdqQb32vWAs/mM867H0KinKWuIOWRG2ay7tc?=
 =?us-ascii?Q?6TRRf+K8CJhrgP46a8CXH3jutJw5cGneoo+f+ombmrFkuf+5yMGAyGADDNLD?=
 =?us-ascii?Q?V5mGkbUJ+ucexGSfU3MpDbJyaQamrd5xKAy7ixCx0wSED5c7b26MSdMq5Am9?=
 =?us-ascii?Q?EZDGrg4kxVWfbpq3EYYSRldRRRBjk6bGP7p+1SoDXQw1/AENPAV3MgfyOC1H?=
 =?us-ascii?Q?ZOFnuEyRS0G/dmaSYhgUjR1cCeY4NkNEIZTrIyF11NEs21JX2a5sf0S6XGi+?=
 =?us-ascii?Q?KuQ2jvBKISrocgcj/cE77W3lfy6aTrusgqJHFvLcSGYxE2+Br5jwzYjVmION?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a2471e-3a49-4522-41cc-08ddb2873b73
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:53:25.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAPSxd9lDEhQbwJRI04z2rHLqDfKm07KQjVgn6KMy9MyON/J+9YRn7e7JsVx56Z8P3p/Oatvjx6qO8OI+TLECBMjW6wpLAqkT9aCs7/2sI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4970

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


