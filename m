Return-Path: <netdev+bounces-190374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42091AB691C
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705C43B5192
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE526FD9B;
	Wed, 14 May 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="Di2q+NCP"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021095.outbound.protection.outlook.com [52.101.129.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0D1D5CC4;
	Wed, 14 May 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219676; cv=fail; b=afuxMeIcpuJaasB++ab4i88VSaECDQVRkJikliYejbm7L35KA7NddRlEEaxa1FA3LvRkjltlOIhSuAoKbI6R3roKfG8oL8RNuRigANEYnhCVcVsW14DPjPWjuZzn8GmrTsER56SlmkOIHSePwsHYO51bTMHHgTgT1T+WSbqk3mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219676; c=relaxed/simple;
	bh=lP/Urk7hIp1Ov8My6gDy8ib4q0gYatunHk83/iIiMGg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZcpRgjuauru2F4rxnignSFAmPBQJAPdhXiUdF0xfD6ZuAkApUQ4qnhSJCqFZUpeZMv8yx+fpp0H6XLELPVAvp9oZQIM/KIwbkVlmhFgiIZfnXU4yp85tI1E/WM+KoiHK5QVwyFkNL0ZVb6vloN7tfgsQH7wzhXmUocTvS1MfD6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=Di2q+NCP; arc=fail smtp.client-ip=52.101.129.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+ky9X/OHdjot0TmoQe6jVX7IcUn6Ls4sYAIu3bWyDoR4A2Yj6ayGrfaiVliHYMHOtu3YkQjFMyQzO49pJ/OvNb0hL9u1iH/WOIXPa0G8ajfQGVZyhJgJyi1wSn0gIJKpyc1mo86KFpx+fo5jhrb7ZomvrD0SotvugzWRhems3OjFbwXHbmmzGQ6+7Ec2bRf1f+4179lQUbZ0bu64KBHrKVClo8TboKKXAtu1N7d50CM6ZpMUF77eBIehHwc8qn0wCzrCpErYMhsZUoEjkCAHCiDPmL6FTsi695+d8VXGASJZ0c04I4Fcev1kRxp6hwBU7hen2QDGWNhdFmrCc7sNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yV3wcqK2ufnQ3/IUtnaL6dX+kDfgpIOFdsaeRZbahc=;
 b=HbO4MXIaL5k20TvcNkCPvZaO9a81lzB/9pipROX73gejfXglmSTLf0l6LaDTPp+u6jdkbsgVc6SlaLg4EeJZ6GxDdgMdeCDEIwzPZ/cMtU57onIPnqi6wHuSQROMBnQmOsvg/cWJiZIRI2gSDPHlupFMIyZgXjgTvKVRGmEQz8BBIhUjlekJa84Mtu6wr+Zojg/iLzd1JIfQjdeGluF8D2Pot4NlLHy1IeAov8Ykh2cbIV02T/x63SX6Hn1lzIqzE5V9Si8BNWRIrjOHhhilE7uPStBuKIKkVreOtT+wdak+hZAtjRA6Hr04LDvVOMrhUhKI2r6prq/6lqXCql+idA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yV3wcqK2ufnQ3/IUtnaL6dX+kDfgpIOFdsaeRZbahc=;
 b=Di2q+NCPGIoYscOzQujHux+QDrkSPNNSZAOYqfUAdTxDdSTNPW8YcZuDSLvMra/9lvUL/RXNDoVZBW5rdDnqVtfTcTH72rfn0utEnmRie4UoA/nUHAcBjtNKixKPoszdomz73KwcmWmo4HFC5FcNVtC2h8eMEeH+4k9zqBixq0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYSPR02MB7631.apcprd02.prod.outlook.com (2603:1096:400:469::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 10:47:44 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 10:47:44 +0000
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
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	rafael.wang@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT and FAG count
Date: Wed, 14 May 2025 18:47:28 +0800
Message-Id: <20250514104728.10869-1-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYSPR02MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8150b1-9c66-417f-e9ad-08dd92d4c1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jqD2UxivpthOyvK/f1MqoqCfOytmM4zWVkpI3mNf4YnonppZof1OCJhAXL19?=
 =?us-ascii?Q?fKMbv+AAHfHtI5WallsNQAV6wVW0GVJzG/+jvoS60lITKLqu2kHnt5Gaydv8?=
 =?us-ascii?Q?DG7LklSyNvWjH7c5oEkmTo3PfXMXPT6GBblugy0fcsFU3lAACuC/l8UgO2cg?=
 =?us-ascii?Q?shIQ9i3er3K6sHct3S+pNeIPQyMwgpWoIKfdbypHlb1wEc30o9H7iFzgP7lJ?=
 =?us-ascii?Q?MbVcbMnrumDfKos1OwvptJ714HuxjeBM76+yL7yodad8AwwJ8gSc1z7cOACB?=
 =?us-ascii?Q?ptL/ydvnR+PI4ZHhb1BfGCfILFe9a8ndIWNXYGKWHMDOvQDlwZZmna3gw3ZS?=
 =?us-ascii?Q?lCkPQTbOHNB5VBqu6KzTTMELeNSDx5fjbBXPebCXjtfBsusWwRRr8XsVA308?=
 =?us-ascii?Q?8cfw4YDUcCoQBojNZ3WT78XrlA634f+vhCEc0dT2EIQL0lm5VPRN2PN400hn?=
 =?us-ascii?Q?ppk/CR1WqMuDmJMvz2yHAWeBTiP10GKNZwu+Le8Umuxy8LbTVORJ93/L4sbj?=
 =?us-ascii?Q?6oo2j4TeUweHvFoHAjFh9mA8XSy1ZM7P7a7cdC06rNVa1izEFFY+MwCW/23K?=
 =?us-ascii?Q?pcwyXEeUn0TZySGOhBuQrpKYHhHsOnTfAIV3V8vVthti7yr43KymC800mKKX?=
 =?us-ascii?Q?Y6Rn62oMZGxzaEBcawhK43a2gG0F/ubqJRG2mJDCwxX+WQrUUleyULQSO4TC?=
 =?us-ascii?Q?T3kgAqQUpR3wlA5Eqc68Vznb69IPwCvMwjkq4qdWVtHMq6gXFDMrFa8KSCDB?=
 =?us-ascii?Q?gB8igRBW/Q2CIzxxffaIL1olrs3IRA6PobSn/IkPXCVSKjlr+DURwt1OQ6q8?=
 =?us-ascii?Q?d4bKCuZhGXNJd9vzr7CPGuDdMZoddAYhZkjmBj/dnJLfsLumJtySxCtZ7ZX4?=
 =?us-ascii?Q?Wl2Bq8M/YjdtpQpJuunLdKSUSuF4W42NHhtpxlQidS15y1E4/NTJzYn8TdvY?=
 =?us-ascii?Q?gIWIyTF/ay4zjPSVuxvSssKwT/7AzDlyoAxr+8XmXzt9VbwA67UWolgGlXoX?=
 =?us-ascii?Q?scGSrgczp+dC9M1XAr4uxubCwekFlNc5R6BD9aeU003FIqmR3y+ESjbHFPC9?=
 =?us-ascii?Q?E3gpQob3bcjWewNDnIRgRI1ZTfsJ8c1PxxsnobHfUEyb8RRLbLLnyOccWRRL?=
 =?us-ascii?Q?0kVbEccHlaTL7a8MA1IBP+P9Q8Bakk0gErLvZ6p6yi6ZyLqnANirowwu/ws8?=
 =?us-ascii?Q?rwRNOrVrBYXuHnJ/J0+z7A/eIjqRAHee8IKhHqH72vxB/rVKajV9RW7vm9nN?=
 =?us-ascii?Q?8WJcW7BryTkU5M/hfCaZNXpBxrsV8FglzsbZw4/RpQm40m0yNLjLfYZ5iYE0?=
 =?us-ascii?Q?qbRnfxaGGQgR8xP8xLRIjQC3/YfGahDz9S743kIkxR6SgmGvWmrxX7RBZHAa?=
 =?us-ascii?Q?Q7meAS0hcbQkezLDU8FHu7VcVXG78y3NjSBzQqEBo4KsxsIX1d69pP/FiplI?=
 =?us-ascii?Q?Db6SvWg+t7Y36+OETN3UTWuBBQOcGVFC5E5cvyL7Q8KdCgw6kD8qttYBQa27?=
 =?us-ascii?Q?0uW3Mi+Xt5aAn9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vpNn406LM5skMEPhKL67qjhwRKQcK8gRVKuoHebXvA1pnZoTqedqbaZa00C?=
 =?us-ascii?Q?ncfBsIo3GMy8JDePlSUJrtA2UEJfryO6THKLo3q68vsQ6wHZyGIO58Tax1wa?=
 =?us-ascii?Q?/Sh7WV77p9wGVujU/qhP/z3o16ABpoNaTqRS+pYRKRyhTsYM8lFw04isLOSD?=
 =?us-ascii?Q?CSeMmICv8UFcWPZM6eTdVFEjLEeLIAXNpPzvDi/mXL8eCX4+snEMXkXXIVlu?=
 =?us-ascii?Q?iCT3kEXbUk6GI3RhQ8bvTcfO3ELvWm5PVvtLu9UvqEnYnFKos0LykyCylZ3R?=
 =?us-ascii?Q?r7AzOKiDzBqUNstwje4hQWkKy6IEGoqL8OqhTYwoPHtGpuerbxl0H6k3bkkL?=
 =?us-ascii?Q?FPFK5phT5zyihmcN3SOD5SL1c8c64ph7m6kmBTHvr/Y5dtE+zwO2dVKlOGi2?=
 =?us-ascii?Q?h5B3hT/sjmN+auearqfZQiqHkW1zi+lb8iH9pRgGdHeOP9KVAvYlZtslLRqn?=
 =?us-ascii?Q?oWZUHbndfd+befSoKHOiJHX5O87DjUx9NSAQPjYSSi3IwHPDbbDHMlpY+xgc?=
 =?us-ascii?Q?eCw0dacbz8kTLPxHKbenVDFR3ScE97bBn7hU/KbIPA7dl+k2QernYRFnYKdI?=
 =?us-ascii?Q?BbkhTt3ENwwL5TMm7rEoy2UwO/+jYCcRM/z0IYYs17wXpJIm7bJcnDDzYjuJ?=
 =?us-ascii?Q?7MYJ3Yatg2UefIU/nuh3cG0IqWRtart4sdg4h79ZnxQ8HypnxaBDxNF9Hfmh?=
 =?us-ascii?Q?iIv9MSuNVHWokpup4Z0TWTPurx0wZsZn1TD4ByhhDTWIas7KuB52c2VrM7Mx?=
 =?us-ascii?Q?FhqMJ80rcvHQXoGWI81QNjdJzrkIh5re0xCvWOodcwlmyXKB35fpFueEQtbL?=
 =?us-ascii?Q?NnIUw676lvcAWnTZpo3BWWz2T5kABxAcQko1cVi91qiirS2L9T9tW6PtafUV?=
 =?us-ascii?Q?gxhsf7INpbP/pbgzc6um9ALlw1HDtjD6Bl5DeDSW04jlmPut4zO9aQGvNezs?=
 =?us-ascii?Q?FxNnSrb49cieBXPesaJjcx8h79/YOqgJSMgmFtV0IZniwRTawXbk1fdlvqnk?=
 =?us-ascii?Q?eVwHqoeg1L+uriHjDWOQtflAWu8oTE96lGVa2bfXJdUj4wMsN3xI70vgyWcX?=
 =?us-ascii?Q?7WM20oaHQhRHdQv/FmiIKPWe93DTbcRXlWQANEmWpyRGoPghx6kKmX/YbhHp?=
 =?us-ascii?Q?Uwz1R7NCo04Sgtb58QFnI4KyzeTfci3ohcvaBccgX7I548ce3lXIx58rJRmr?=
 =?us-ascii?Q?irJATwBpIbIrw6stvCz19z2YP1QDT1r9Qp7oxLU70jJqkp/TX36evPJSiau4?=
 =?us-ascii?Q?lQkXh309STDBp54Wm/UfoT02ndJN+Qzz8d8rNTzyJA8lH2+F+aWs9j/9KV2R?=
 =?us-ascii?Q?2jx7dhU5hd+Faj2T3S4k9bit3BikMeMQpaSVnrz/cZnP0HMCy89utnDoWGpi?=
 =?us-ascii?Q?J7VJS3RJZh96OVl/gDZhR2z7oSyEes9Xo4hE/XDw8fZPTEilnDYtZ5qMNjho?=
 =?us-ascii?Q?mWHboqUaURqkinGXPntIrBStglx2EAK1WooJ7GfgoNl4wQQJ2AbO/VwnsKB0?=
 =?us-ascii?Q?6mwL78mgu2QGCVAgz2PK5XE7QVmHFv9qV9tcYqLAiKJlwy+DYAG6J30E01vq?=
 =?us-ascii?Q?5wxBEf2TNe80CaUwWTAuGf+gQNiYDIo6Vtc+SUrjYFQEYl5YaXT48nmJKvGE?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8150b1-9c66-417f-e9ad-08dd92d4c1ac
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:47:44.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmaoZhlT8Ia5E4llc/Q6LThFz19VvTPtyvktGmeCALpnVlXCaB8bQuxiLTK+TCEAGBm9zU+A2G4tdNyVzU8zuxi3jUueidnQXeBn+PCACHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7631

The DMA buffer for data plane RX is currently fixed, being parameterized
to allow configuration.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 12 +++++-------
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h |  3 +++
 drivers/net/wwan/t7xx/t7xx_pci.c           | 10 ++++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 6a7a26085fc7..7848e470432c 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -49,9 +49,7 @@
 #include "t7xx_netdev.h"
 #include "t7xx_pci.h"
 
-#define DPMAIF_BAT_COUNT		8192
-#define DPMAIF_FRG_COUNT		4814
-#define DPMAIF_PIT_COUNT		(DPMAIF_BAT_COUNT * 2)
+#define DPMAIF_PIT_COUNT		(dpmaif_bat_count * 2)
 
 #define DPMAIF_BAT_CNT_THRESHOLD	30
 #define DPMAIF_PIT_CNT_THRESHOLD	60
@@ -279,7 +277,7 @@ static int t7xx_frag_bat_cur_bid_check(struct dpmaif_rx_queue *rxq,
 	struct dpmaif_bat_request *bat_frag = rxq->bat_frag;
 	struct dpmaif_bat_page *bat_page;
 
-	if (cur_bid >= DPMAIF_FRG_COUNT)
+	if (cur_bid >= dpmaif_frg_count)
 		return -EINVAL;
 
 	bat_page = bat_frag->bat_skb + cur_bid;
@@ -448,7 +446,7 @@ static int t7xx_bat_cur_bid_check(struct dpmaif_rx_queue *rxq, const unsigned in
 	struct dpmaif_bat_skb *bat_skb = rxq->bat_req->bat_skb;
 
 	bat_skb += cur_bid;
-	if (cur_bid >= DPMAIF_BAT_COUNT || !bat_skb->skb)
+	if (cur_bid >= dpmaif_bat_count || !bat_skb->skb)
 		return -EINVAL;
 
 	return 0;
@@ -944,11 +942,11 @@ int t7xx_dpmaif_bat_alloc(const struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_b
 
 	if (buf_type == BAT_TYPE_FRAG) {
 		sw_buf_size = sizeof(struct dpmaif_bat_page);
-		bat_req->bat_size_cnt = DPMAIF_FRG_COUNT;
+		bat_req->bat_size_cnt = dpmaif_frg_count;
 		bat_req->pkt_buf_sz = DPMAIF_HW_FRG_PKTBUF;
 	} else {
 		sw_buf_size = sizeof(struct dpmaif_bat_skb);
-		bat_req->bat_size_cnt = DPMAIF_BAT_COUNT;
+		bat_req->bat_size_cnt = dpmaif_bat_count;
 		bat_req->pkt_buf_sz = DPMAIF_HW_BAT_PKTBUF;
 	}
 
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
index f4e1b69ad426..4709770fc489 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
@@ -22,6 +22,9 @@
 
 #include "t7xx_hif_dpmaif.h"
 
+extern uint dpmaif_bat_count;
+extern uint dpmaif_frg_count;
+
 #define NETIF_MASK		GENMASK(4, 0)
 
 #define PKT_TYPE_IP4		0
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 8bf63f2dcbbf..021a05b49225 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -28,6 +28,7 @@
 #include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
@@ -54,6 +55,15 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+uint dpmaif_bat_count = 8192;
+uint dpmaif_frg_count = 4814;
+
+module_param(dpmaif_bat_count, uint, 0644);
+MODULE_PARM_DESC(dpmaif_bat_count, "BAT entry count");
+
+module_param(dpmaif_frg_count, uint, 0644);
+MODULE_PARM_DESC(dpmaif_frg_count, "FRG entry count");
+
 static const char * const t7xx_mode_names[] = {
 	[T7XX_UNKNOWN] = "unknown",
 	[T7XX_READY] = "ready",
-- 
2.34.1


