Return-Path: <netdev+bounces-119387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E70C955661
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 10:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6221F21A82
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06A1422D2;
	Sat, 17 Aug 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="oNaWcQ2v"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A27F484;
	Sat, 17 Aug 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723883674; cv=fail; b=MeQ+qqqtPvHTn+4XavLR467CNdjBs4AoHIAnHzKPX2bHsmqPYv4NdWDK5zGPmLLcMg0S0Tt4dKMDRP5Zh7YfYxibpbqlnV8jxNrPfF9sRr7wbNle0gi5HGmOy84SAworovUOEkLQNsOIve48C/ugFhXWvUQYa7sv68e4t4XjbX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723883674; c=relaxed/simple;
	bh=99jyp2hA++FBJ6L7KW2DG1J4plPx7jj6xIwgl6sWllo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iFyRC0aZdi38n6EG39QLU8HEcz4HB0LTUmzI9E2bKXGFcxwPwA7L4ztQ2Z4iUnJzOoPHqm95kqPRV28G6z0o6c86oOkb5auaXTMmpKPC1I0dpDzcXeSc88GI2zf0SlUqrVNP5URkC2f4vPurBOhq9rMOkTEAj4p3pLGvLx6SXqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=oNaWcQ2v; arc=fail smtp.client-ip=40.107.117.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seLH7fciqOrjTXNX9x+Z1jKxz2Ydf0FxgNkeq+IMTtleNX8mnMw+yjdPZzYA4dFzWJfp9TkEPoo86xv1NGvR4v8u4+PAJxjFuJ4TBZ3Nfc3nimCsViIAlGa/d6WoVdY6OqbxZjmQ6A2WGEsIJeRHyOmWGdCzrVbzoftHpuAvZpbkySHcDg/fqSksUbyFf56gI/GJECbMSYFYpOaXcbEM+SlJiZwhTCTAfBIdwfWll2HllCOQH7oyUv/sCVWMP4rv0T3Tv0HdKV0VtTRw8aLu0nh8/bJUkERnranq+mKVKIzgnLyaabwZloL9udlBMbroeAGvO4qaWSebNs0wMZda/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMjBW1Ztf1ecRopCiAC763qdj7xKc6fo+L3DENhzyFs=;
 b=lDDyZknAYx7D/QBYMkNIkoNnCzqJFsYelgGgwafUI6jsHxUO5yVesVfVA9F1NgBR+Mv2ZS6ZAW+8WYJqhlmq+IcczPY7QFaudhANGYGeT3ud1DkfG4KkxQkz1vkH1m4bDjckaONuk5rymwAZ4ZZXcn+Xn+t84zGcNh3XZGhdnb3Q0zjt3W/PVE1iRCj8mNHjGsZJlelvK3IW23MWZLjzvt2NXEAldsfH2y5uPqnoIBfbGr3uf2k+200Jasi/hGKTVyjm33fERr/O3D/T4ijbsw/yS83mhbxUOofDcLQzbPOsSbHlnPnpNt1DDS+MMKyULZmi7ZYh4wEafT/6nj1gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMjBW1Ztf1ecRopCiAC763qdj7xKc6fo+L3DENhzyFs=;
 b=oNaWcQ2vQwpXHvyUgm5XhLnwQWkz5+O7Q5VRWJuyY3IbTQASRR4cxVuDFZOpG+AcxKiTGhloUvNwSILl/Vq1BOCzt/jkKsxZJg5y+5vOj74oXcni+Lu52tndUEHlFJLkutwyFFK6LRwvExdqh77o/KB4sWVfE45Fzu5iH7HmPqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TY0PR02MB6152.apcprd02.prod.outlook.com (2603:1096:400:27a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 08:34:20 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%5]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 08:34:19 +0000
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
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v3] net: wwan: t7xx: PCIe reset rescan
Date: Sat, 17 Aug 2024 16:33:55 +0800
Message-Id: <20240817083355.29811-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TY0PR02MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 168615ee-a66f-42cf-034a-08dcbe97634e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlZVkRwHBPsAseL7AWtCoVKpz2Lf1hQBGMfVtLXrLWFWaxKcu5RwDYUrvnes?=
 =?us-ascii?Q?5s6zlaFaAXBXm3wciDHeaJPnNmgMBkhS4o/6mL9yjU2fT/No57KxSJDdOCb6?=
 =?us-ascii?Q?S7TzxTmO5ad89A3pNfU3+kpxv3Xy2EArrQhH97N6i1hjQM70T6jVc1EkoxMs?=
 =?us-ascii?Q?WrHj4oMRlfALq3x4lqDOumM76NFuR9uMY681kimYUTnwtedFGgLBdMLuZdbP?=
 =?us-ascii?Q?FGOcu7ytci1lblwyDPQsMLbyEylTLdAcC0zkUZWNlgq7h3Qodo8LdGO6kB1f?=
 =?us-ascii?Q?n7tkJejeukzosG1dDKx+1KQcAakG9cAX7+czoRwpCBgC5vbYG32BnUs9a0jp?=
 =?us-ascii?Q?rXDqghA1JDRC3YyhhXW8Aq2ZmPAvlGR3D2s7F4bGPUJBLKUUq1ebFf5ZONBQ?=
 =?us-ascii?Q?r8zZos2aX/v/ODngUHVhndlGR6MmEzWRlsfpyt9GlazQ72C/KqvAzUGQT5Nt?=
 =?us-ascii?Q?eMcf50fL7mkxehxcOEz1inEtFO8OCIUaT+Ol5apjbbplgYWxmZa5uC2L3ak0?=
 =?us-ascii?Q?axIlfqhp8MoBxhzZdJXVk0CMSQulETooXuut0V+9lJWmh2YQ9hWz1niZqHFP?=
 =?us-ascii?Q?pfjTm9Jnw7gFhieNb5b1pWTMR5iuFilm5HpOu8oRK3tBXeYn43Go1eS6LiF8?=
 =?us-ascii?Q?OPXNtBU5uzu0IvLcgURtHKmOj7F10xfGU3qousVgfMV2R830POttzcpIb8Ie?=
 =?us-ascii?Q?/1/1nWkNu8aGh3q33QKV7Kb4aSp8DJyhowiHIRgy7xBdxqDiF3rCm+VHDS5x?=
 =?us-ascii?Q?nwJ9aIv40v5Ii4PIeaIjKHorpjCxmxCORSU8ijYdJx3pCFwzCQDvvkUDxLz1?=
 =?us-ascii?Q?IMwvIwzoEf9r38iJa6OiWHH+jsJdUw6j6L2T5hiqrXW6/w8ZUW8ugut01OWp?=
 =?us-ascii?Q?3AUS+1VzizQFE4ttToerEHxqgENcCQm+c3okwI6wpgMaWIrT4u/j4PaRmlPI?=
 =?us-ascii?Q?DCwVLmKgNhdxNojMhmmWxlaFRqqJjuOe4Q7h8Ua17Q9e/1GquDfZoRqQsA36?=
 =?us-ascii?Q?AEd36/CKh77EnzoYGsKvmCdXvMPF2EquTKbCs8awr0F8tZ5Yn3rtQAGBOyDu?=
 =?us-ascii?Q?rl9D+t21U2cjBF8zigLWlGViaZggh+2in3gm0AclhDHBqWDeZfCofr9ygT1S?=
 =?us-ascii?Q?Jc9zE71BTuHk8ITTzGGS3wIaRNTU4sZX8HL1KBFlRdgZgL8SHujoWAbmNAOj?=
 =?us-ascii?Q?LVuMD80Llele0viETSeBYh0TjDmNfNDqqIdbtgRu3WlnSFdtNJqWkvUdTZjP?=
 =?us-ascii?Q?KKs4+ayZxjJTMU9T5oqPuEToVbrqOVAMwmhjpTs0B8ZylTidGCDf8dv1oodp?=
 =?us-ascii?Q?sDe9PB/T03XEj6H9qUiIhy+e6ZPZ75Ctr3jvytIT6FgM66c9CicWOrFQLpdM?=
 =?us-ascii?Q?I7uVmeoT9EA5aChRvSzGllLNTBpn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eznmQwobLaKgJVPkX+UXbaQ7dZX6zY6Mhiz/Z2ycQ0pGZyiH/60aCs8wO2CJ?=
 =?us-ascii?Q?ex8Lcf8pm2EIaFGQIt9ZA9dkYvcPKOgvU9t4hNMqEOYkTRUhPXGuIRCLG9Dd?=
 =?us-ascii?Q?HJN6l/45XhoDi3k2jUkwHZfgdnwG4J/FjB9OLBrsLkTpd4sc+zprORJ9b6FT?=
 =?us-ascii?Q?FVkH+vG4hXOIQ1A5+pjBEIgZINN29e8klNFnOimo5Dej36GzuKhluLcuQ+Ps?=
 =?us-ascii?Q?3aWfkhYdG5TxkT1sGBOXeaVy8Zg9OfJuuRaFozLzHvhlnr41YuAqcpiCK2aJ?=
 =?us-ascii?Q?NZMNtO+ExiV1dDyiuQAy3ZTo53fCCoNpxTUktJFLn2dCs/rC6o+obESU7wpX?=
 =?us-ascii?Q?B+s0K+SpyMJan6f/Xx6P3kBE+m9liyC40hbZvANWWoyMcIYj6qoyu6v8oQUI?=
 =?us-ascii?Q?a48jKe+A8rQaSE+l5A6zfzgHOZKmPG7BQYTjFHhWHJ5R0cjCZjALefaKttpa?=
 =?us-ascii?Q?gN0ukT0u4vDMxjrrh8oqmimOTos7/w84xxCaFudw6C7p/YdKfkydZEeviT8H?=
 =?us-ascii?Q?k2Umf40DNK+n29mEJnHkCTwOag7hjcfQhBdFTwtjny3xahp/rVnn86vcAfK+?=
 =?us-ascii?Q?VEwoyqOZwYYHlnwp+6/E+wFgt++H0bV5g8xrbGJ1MgT7EOlZVikw7Hw2F1/9?=
 =?us-ascii?Q?gWEH+Th1HTF6MD40MBhOb5hXJweU6dNN0OZEZZ1LDiwjl7Mp60bTdWgiPxC2?=
 =?us-ascii?Q?3ItzPpbBvRz3Yv3LJH9yb4L9TcyiYqS3Us6unCOmDLXPFJeCwu0M+U7ExgSp?=
 =?us-ascii?Q?hNw5bjvd5Vs8RXP6/jrTyjg7BoMVzzwQXOvP29hq7CcCu3G04r3WB1Go6JyQ?=
 =?us-ascii?Q?7BS7/YhAi0ztn5JASs+HVj2XtYfCXlflHP/VdItRWMw8OcVkCeSSV1X0EkR6?=
 =?us-ascii?Q?EEIeOPjmKMtuRGVX+kV5Jca9QtwJh6bkKDsXd8G4BQPOdlcYxu3STtbtZY9T?=
 =?us-ascii?Q?RRmIO2HWQD5/KTMg64xpLJUJdgMqh8mHI7jNYe3CrZdFT8envZDPPTUJxYkJ?=
 =?us-ascii?Q?YUyZHDbVkmQXviYJUxiVj2DdYFnTdDqpqw82jWspOV+w+5saZjGu2Erfn3LY?=
 =?us-ascii?Q?zuMUx8BTzK2ieorqBS/qUnB7KI8ukIZ/Nyoi0CduENeGNxB0k+XX6c3/EYYN?=
 =?us-ascii?Q?dmQ0Zfl4yoibAyfoAAZOBP97hrB/4aAb3GkAjAXKhiwMO66FZ7xPM47PxqNe?=
 =?us-ascii?Q?doORyPkcR/BWtUGGtQ6ZLFYdoBAzwmZAMPQ+4DtokcYWkMMrO1N0NV1cJ9DW?=
 =?us-ascii?Q?Ez5+Tqk5yjJBjrt8jDxQcIYF1iR8dD028XA5ZYoRbOxfGBu4DPtH+iQongje?=
 =?us-ascii?Q?TrMg7KwuKtcuwT3ucVUMFjh6HUyF4ztFivmLmBLDsvBkjUSQb1oHHow6qwQK?=
 =?us-ascii?Q?Wx1548x06hgtg9fl91B61Yo+Twg43NrFb4R9gBKEa4+/9SdmjuVb9XrnsZRc?=
 =?us-ascii?Q?qKv9tN3Wyp94Hc3CLLH5mTHE3trMSey58nqi17TnOf9uhXW85N9s00JdDkqH?=
 =?us-ascii?Q?7jpuASZIJzvp5LS5VNwIG/72kxx0tvjMBtj50P29zN2zUhYxaKKSmuIT/enU?=
 =?us-ascii?Q?8C6SJ+fQKKS76TisUnTPC1lCyt+zGK9/f2kqGRwo8wx3ntBviapniHjFinYX?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168615ee-a66f-42cf-034a-08dcbe97634e
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 08:34:19.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvdBtrEUOgfkd7TSoKbaMQSuL7EbfJi0prxmz0OXhPHyH9IuJ1GhugLeooaf78RX/TsOuM+jjfZQEzWHhyMo/9x7ZVspzM2mvqOLQBobQTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6152

WWAN device is programmed to boot in normal mode or fastboot mode,
when triggering a device reset through ACPI call or fastboot switch
command. Maintain state machine synchronization and reprobe logic
after a device reset.

The PCIe device reset triggered by several ways.
E.g.:
 - fastboot: echo "fastboot_switching" > /sys/bus/pci/devices/${bdf}/t7xx_mode.
 - reset: echo "reset" > /sys/bus/pci/devices/${bdf}/t7xx_mode.
 - IRQ: PCIe device request driver to reset itself by an interrupt request.

Use pci_reset_function() as a generic way to reset device, save and
restore the PCIe configuration before and after reset device to ensure
the reprobe process.

Suggestion from Bjorn:
Link: https://lore.kernel.org/all/20230127133034.GA1364550@bhelgaas/

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
V3:
 * supplementary commit information
 * fix the error codestyle in t7xx_mode_store()
 * use CONFIG_DEBUG_ATOMIC_SLEEP to test the reset feature
V2:
 * initialize the variable 'ret' in t7xx_reset_device() function
---
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     | 47 ++++++++++++++++---
 drivers/net/wwan/t7xx/t7xx_modem_ops.h     |  9 +++-
 drivers/net/wwan/t7xx/t7xx_pci.c           | 53 ++++++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_pci.h           |  3 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  1 -
 drivers/net/wwan/t7xx/t7xx_port_trace.c    |  1 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c | 34 +++++---------
 7 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 8d864d4ed77f..79f17100f70b 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -53,6 +53,7 @@
 
 #define RGU_RESET_DELAY_MS	10
 #define PORT_RESET_DELAY_MS	2000
+#define FASTBOOT_RESET_DELAY_MS	2000
 #define EX_HS_TIMEOUT_MS	5000
 #define EX_HS_POLL_DELAY_MS	10
 
@@ -167,19 +168,52 @@ static int t7xx_acpi_reset(struct t7xx_pci_dev *t7xx_dev, char *fn_name)
 	}
 
 	kfree(buffer.pointer);
+#else
+	struct device *dev = &t7xx_dev->pdev->dev;
+	int ret;
 
+	ret = pci_reset_function(t7xx_dev->pdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset device, error:%d\n", ret);
+		return ret;
+	}
 #endif
 	return 0;
 }
 
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
+static void t7xx_host_event_notify(struct t7xx_pci_dev *t7xx_dev, unsigned int event_id)
 {
-	return t7xx_acpi_reset(t7xx_dev, "_RST");
+	u32 value;
+
+	value = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
+	value &= ~HOST_EVENT_MASK;
+	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
+	iowrite32(value, IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 }
 
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
 {
-	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	int ret = 0;
+
+	pci_save_state(t7xx_dev->pdev);
+	t7xx_pci_reprobe_early(t7xx_dev);
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
+
+	if (type == FLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "_RST");
+	} else if (type == PLDR) {
+		ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+	} else if (type == FASTBOOT) {
+		t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
+		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
+		msleep(FASTBOOT_RESET_DELAY_MS);
+	}
+
+	pci_restore_state(t7xx_dev->pdev);
+	if (ret)
+		return ret;
+
+	return t7xx_pci_reprobe(t7xx_dev, true);
 }
 
 static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
@@ -188,16 +222,15 @@ static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
 
 	val = ioread32(IREG_BASE(t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
 	if (val & MISC_RESET_TYPE_PLDR)
-		t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+		t7xx_reset_device(t7xx_dev, PLDR);
 	else if (val & MISC_RESET_TYPE_FLDR)
-		t7xx_acpi_fldr_func(t7xx_dev);
+		t7xx_reset_device(t7xx_dev, FLDR);
 }
 
 static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
-	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index b39e945a92e0..39ed0000fbba 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -78,14 +78,19 @@ struct t7xx_modem {
 	spinlock_t			exp_lock; /* Protects exception events */
 };
 
+enum reset_type {
+	FLDR,
+	PLDR,
+	FASTBOOT,
+};
+
 void t7xx_md_exception_handshake(struct t7xx_modem *md);
 void t7xx_md_event_notify(struct t7xx_modem *md, enum md_event_id evt_id);
 int t7xx_md_reset(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
-int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type);
 int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
 
 #endif	/* __T7XX_MODEM_OPS_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 10a8c1080b10..e556e5bd49ab 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -69,6 +69,7 @@ static ssize_t t7xx_mode_store(struct device *dev,
 {
 	struct t7xx_pci_dev *t7xx_dev;
 	struct pci_dev *pdev;
+	enum t7xx_mode mode;
 	int index = 0;
 
 	pdev = to_pci_dev(dev);
@@ -76,12 +77,22 @@ static ssize_t t7xx_mode_store(struct device *dev,
 	if (!t7xx_dev)
 		return -ENODEV;
 
+	mode = READ_ONCE(t7xx_dev->mode);
+
 	index = sysfs_match_string(t7xx_mode_names, buf);
+	if (index == mode)
+		return -EBUSY;
+
 	if (index == T7XX_FASTBOOT_SWITCHING) {
+		if (mode == T7XX_FASTBOOT_DOWNLOAD)
+			return count;
+
 		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_SWITCHING);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, FASTBOOT);
 	} else if (index == T7XX_RESET) {
-		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
-		t7xx_acpi_pldr_func(t7xx_dev);
+		pm_runtime_resume(dev);
+		t7xx_reset_device(t7xx_dev, PLDR);
 	}
 
 	return count;
@@ -446,7 +457,7 @@ static int t7xx_pcie_reinit(struct t7xx_pci_dev *t7xx_dev, bool is_d3)
 
 	if (is_d3) {
 		t7xx_mhccif_init(t7xx_dev);
-		return t7xx_pci_pm_reinit(t7xx_dev);
+		t7xx_pci_pm_reinit(t7xx_dev);
 	}
 
 	return 0;
@@ -481,6 +492,33 @@ static int t7xx_send_fsm_command(struct t7xx_pci_dev *t7xx_dev, u32 event)
 	return ret;
 }
 
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev)
+{
+	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
+	int ret;
+
+	if (mode == T7XX_FASTBOOT_DOWNLOAD)
+		pm_runtime_put_noidle(&t7xx_dev->pdev->dev);
+
+	ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot)
+{
+	int ret;
+
+	ret = t7xx_pcie_reinit(t7xx_dev, boot);
+	if (ret)
+		return ret;
+
+	t7xx_clear_rgu_irq(t7xx_dev);
+	return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+}
+
 static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 {
 	struct t7xx_pci_dev *t7xx_dev;
@@ -507,16 +545,11 @@ static int __t7xx_pci_pm_resume(struct pci_dev *pdev, bool state_check)
 		if (prev_state == PM_RESUME_REG_STATE_L3 ||
 		    (prev_state == PM_RESUME_REG_STATE_INIT &&
 		     atr_reg_val == ATR_SRC_ADDR_INVALID)) {
-			ret = t7xx_send_fsm_command(t7xx_dev, FSM_CMD_STOP);
-			if (ret)
-				return ret;
-
-			ret = t7xx_pcie_reinit(t7xx_dev, true);
+			ret = t7xx_pci_reprobe_early(t7xx_dev);
 			if (ret)
 				return ret;
 
-			t7xx_clear_rgu_irq(t7xx_dev);
-			return t7xx_send_fsm_command(t7xx_dev, FSM_CMD_START);
+			return t7xx_pci_reprobe(t7xx_dev, true);
 		}
 
 		if (prev_state == PM_RESUME_REG_STATE_EXP ||
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..cd8ea17c2644 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -133,4 +133,7 @@ int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_en
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
+int t7xx_pci_reprobe(struct t7xx_pci_dev *t7xx_dev, bool boot);
+int t7xx_pci_reprobe_early(struct t7xx_pci_dev *t7xx_dev);
+
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 7d6388bf1d7c..35743e7de0c3 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -553,7 +553,6 @@ static int t7xx_proxy_alloc(struct t7xx_modem *md)
 
 	md->port_prox = port_prox;
 	port_prox->dev = dev;
-	t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 
 	return 0;
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
index 6a3f36385865..4ed8b4e29bf1 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
@@ -59,6 +59,7 @@ static void t7xx_trace_port_uninit(struct t7xx_port *port)
 
 	relay_close(relaych);
 	debugfs_remove_recursive(debugfs_dir);
+	port->log.relaych = NULL;
 }
 
 static int t7xx_trace_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 9889ca4621cf..3931c7a13f5a 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -213,16 +213,6 @@ static void fsm_routine_exception(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comm
 		fsm_finish_command(ctl, cmd, 0);
 }
 
-static void t7xx_host_event_notify(struct t7xx_modem *md, unsigned int event_id)
-{
-	u32 value;
-
-	value = ioread32(IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-	value &= ~HOST_EVENT_MASK;
-	value |= FIELD_PREP(HOST_EVENT_MASK, event_id);
-	iowrite32(value, IREG_BASE(md->t7xx_dev) + T7XX_PCIE_MISC_DEV_STATUS);
-}
-
 static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int status)
 {
 	struct t7xx_modem *md = ctl->md;
@@ -264,8 +254,14 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 
 static int fsm_stopped_handler(struct t7xx_fsm_ctl *ctl)
 {
+	enum t7xx_mode mode;
+
 	ctl->curr_state = FSM_STATE_STOPPED;
 
+	mode = READ_ONCE(ctl->md->t7xx_dev->mode);
+	if (mode == T7XX_FASTBOOT_DOWNLOAD || mode == T7XX_FASTBOOT_DUMP)
+		return 0;
+
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_STOPPED);
 	return t7xx_md_reset(ctl->md->t7xx_dev);
 }
@@ -284,8 +280,6 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 {
 	struct cldma_ctrl *md_ctrl = ctl->md->md_ctrl[CLDMA_ID_MD];
 	struct t7xx_pci_dev *t7xx_dev = ctl->md->t7xx_dev;
-	enum t7xx_mode mode = READ_ONCE(t7xx_dev->mode);
-	int err;
 
 	if (ctl->curr_state == FSM_STATE_STOPPED || ctl->curr_state == FSM_STATE_STOPPING) {
 		fsm_finish_command(ctl, cmd, -EINVAL);
@@ -296,21 +290,10 @@ static void fsm_routine_stopping(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_comma
 	t7xx_fsm_broadcast_state(ctl, MD_STATE_WAITING_TO_STOP);
 	t7xx_cldma_stop(md_ctrl);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING)
-		t7xx_host_event_notify(ctl->md, FASTBOOT_DL_NOTIFY);
-
 	t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DRM_DISABLE_AP);
 	/* Wait for the DRM disable to take effect */
 	msleep(FSM_DRM_DISABLE_DELAY_MS);
 
-	if (mode == T7XX_FASTBOOT_SWITCHING) {
-		t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	} else {
-		err = t7xx_acpi_fldr_func(t7xx_dev);
-		if (err)
-			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
-	}
-
 	fsm_finish_command(ctl, cmd, fsm_stopped_handler(ctl));
 }
 
@@ -414,7 +397,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 
 		case T7XX_DEV_STAGE_LK:
 			dev_dbg(dev, "LK_STAGE Entered\n");
+			t7xx_port_proxy_set_cfg(md, PORT_CFG_ID_EARLY);
 			t7xx_lk_stage_event_handling(ctl, status);
+
 			break;
 
 		case T7XX_DEV_STAGE_LINUX:
@@ -436,6 +421,9 @@ static void fsm_routine_start(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command
 	}
 
 finish_command:
+	if (ret)
+		t7xx_mode_update(md->t7xx_dev, T7XX_UNKNOWN);
+
 	fsm_finish_command(ctl, cmd, ret);
 }
 
-- 
2.34.1


