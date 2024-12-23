Return-Path: <netdev+bounces-154112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2609D9FB4D5
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 20:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CA31634FB
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8821C5F04;
	Mon, 23 Dec 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b="DTdT1KOj"
X-Original-To: netdev@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020111.outbound.protection.outlook.com [52.101.189.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48618A921;
	Mon, 23 Dec 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983804; cv=fail; b=ndHUK5XuTDlcmjPGLlT7SJMrgF94k5QnoBUAmbEbmM32whFHio9GbKrjdWZoPcQqiT21n/sMCeTyHEvcQ2wnxVp4OAfFibWLg5YXT74H/JnbKk2ulM50O+3rqtsejqTtvJdIp+4+Yf+neXNf/HEMFe36nEBqpKZPzHBxOUPIquc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983804; c=relaxed/simple;
	bh=qdsgn1le/g31ANTYWzxXOyeWSXQdmFEdKYOcqHsJYSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a2v2DVQdUgWc/+cd+ZUuFh9th8/GW6oW6jDR7xQj/xSMN+EzfrqLa9K69id2974MiHUd8+unnCuuaiU2Zvf9LzUnHpefY/IrB8rwEes4zUG3IxoftWBt35LUT7nzDybxd2EQJKYr/pDPoWKoOYF5BvxKawv323wzAV5EQ3P6McA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com; spf=pass smtp.mailfrom=lenbrook.com; dkim=pass (1024-bit key) header.d=lenbrook.com header.i=@lenbrook.com header.b=DTdT1KOj; arc=fail smtp.client-ip=52.101.189.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lenbrook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenbrook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf4QL1sEjwdZ1hbfIuHXj+IcDadNZ65EAzMV/Zf/shxEKwGcDgpy3bUhIzRB5xRgw+94wmEh+4LQAseAk+ZYHePFaPZGybq3galcYOrjxrjdzmsL2C/W7sh2Cz1Gzcgsc6grtkI4xcg+nezvj0LwQArRUbvdQgtdbv4VY4j3X7TnyqbDPzdhrIs1ZQvWfmeUwY6tuuRfrATgAeFyNcWrIvVF2bqPyajuEbYg0w2uGhuGj55MefLthiZotcuZyOLgP7gTeFVFEdzH2M+xXDODoEJlLouB+0GGoN+A6Msur9y+0H5/u2XtHNdcB6Ipq7V53xMXbPs0YKwqph9VM/da2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRS45rUsXT3yCzcfithvKU2OxPm7YXCd/K/+wPLEl5M=;
 b=xbR5xOZnBM+RI/dqrCYCZGLmye8q4Xd1/N+ir4pHV58WqcidAXR5g+/T7nbIhAGX3EMce2zGTDVgBXTCsMYGp0LR2SHKCYMD3CDgfVgC4KEdCirekh3UtMJ3hUGCOWRE+qutfWXqvnrQlko/pHjOdpwR5UK+CymlI00vWyp5XJTOboDVC2IE34Sl6aXPqWaohlMeE0r7HOExLCNpywpGQOuAQ6D2vnYFnYs91n296BE3Q83qGhnu7F9y8Qo/Q6VeFrpDAaE8i3N5sbvZjJUQdqPqBOo92MxUv7cnmslnkD6TcXjPPjjJ+Vr0MZslcwJuDpl9kXgMFoHwmzN2mtfEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRS45rUsXT3yCzcfithvKU2OxPm7YXCd/K/+wPLEl5M=;
 b=DTdT1KOjMxiech8m9kKqAkfpDcZeus8g5Fc+EVz0cCMyR3Hq8KiNf2MPaWe4o+zQ33qbJnQSZn0cs6m+Z5y4nFBe8amENMsroRuGyRC5vlao/z199Ji4NUNoNSY8OBQ5Kmglwm2edQpSwWjupQGgn6ADuGzxMeq4p6n/1olYB3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:54::18)
 by YQBPR0101MB9710.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 19:56:38 +0000
Received: from YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541]) by YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9def:1c97:2f04:5541%7]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 19:56:38 +0000
From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
Date: Mon, 23 Dec 2024 14:55:34 -0500
Message-ID: <20241223195535.136490-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0474.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::28) To YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:54::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5632:EE_|YQBPR0101MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 877861a6-ee62-4c8d-758e-08dd238be97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zmwj8KPOI0jnb1ei7YAbNS2aCdbYnGVEGtMJ0dCgO45dUjcENTV/hdhYkKQe?=
 =?us-ascii?Q?7MYKgYNgBae3wLggoJFlZA4TJGTX9k5BiNjerzxG9hWj0pt9oeSPM2T1I34L?=
 =?us-ascii?Q?00J8qBRqUIab882lqZw9DyzVEkK+6zqN3wbn/gPs4gfXs7/tW0kYGW5wsJxW?=
 =?us-ascii?Q?RBcnpX0V1dXS/sZWuvJt64TLs+ktvdwPSpgbYhH6rYs/Itc9IGgPPbc7xJAI?=
 =?us-ascii?Q?GxsaFmIOKhrdDvH2ahrBm4JD4DmA29ANPSPQ970MBtCU0jJfdidgoIW1+Euj?=
 =?us-ascii?Q?6a7C2V0x1HYyLBxI5Y85T6qDXL8+NeKxbfJgjR/MmUdvCpQOcfM3D4mnbpP+?=
 =?us-ascii?Q?xQ1xX2vgy/bCKw7GgAWMTaXMsBLVWW9E/V2p7XWEbiqBgekIqq5U0b/5czBI?=
 =?us-ascii?Q?tGY8qj2YuW5xPz1Yk8i0jEI3EOSXv31xdnd0vFPn1XK/lFCd9cpMepYTDxkG?=
 =?us-ascii?Q?CxT7wvNHm+PaEx0e+jcU1Yt1FoLv/z1IJxU5cQnmMU4MZgm3cHKjdwcQGSXk?=
 =?us-ascii?Q?L09yyi7MlTkJUQL5RAAwGl1voB7VFZoNCUtpqSrrHCFUWwN2A12T1GC6TJSW?=
 =?us-ascii?Q?9PIVnyWf2aOGndMBkslGxOXAGHXTSrhYdNvmlD13Iltsf9HGrEkhdSyW6tHN?=
 =?us-ascii?Q?E49eNloNXetKjDxSFi8wTw/NeozUAQHg4iDYpembsWZQh+j4Zdh4+Zhe+PIH?=
 =?us-ascii?Q?BcNzoaT/gSfPegmkT/Qbi+l4ID3kUT10nIrMZAM52nZvLlao1RsN+/+AJoJt?=
 =?us-ascii?Q?I70B3T4IFr1dZJxQ4hRe4BB+p4q4ivuEmAb3yVw5Tdlj17Zh2WgsJ7fTQAyA?=
 =?us-ascii?Q?++7lhLwHp78ln/icaV1WSk9+MjbW0dbbWNqkVeTaxngPVgBKztEjB9d+Q/Cp?=
 =?us-ascii?Q?Qt2N3q1bk5uXIVA8CHHGYg3GvTME53w/g5+/UR0VQCkAal5cVFKNC9iPC2d4?=
 =?us-ascii?Q?xcxzJ0H9/FRgAriLMDQCbmJ6TNj9ZimauW10R3xDh2ZuSBuDjAnvTUlHYpPG?=
 =?us-ascii?Q?SCnWNl8KBWnywVynmAly9/8idTxcH9sEOSpcw+4equ8OvYjiV5ULLE/xpMvN?=
 =?us-ascii?Q?aZYTXmb9T4wmgCiKldm5DgRHvrOR6mBDQam9f9+wZSalvyR5/64wi1kE/mZl?=
 =?us-ascii?Q?seB0RFFAPmbXtUuDIYjR5MDxOrs/9GLz5RUcKErcIabd8FXDhs6vFrkhXCm7?=
 =?us-ascii?Q?OZWEHmnnQXVhfid17yiSn0+9GnMpf/7ppaXEaWMB04ZOc5u69RYE2cNBJM1M?=
 =?us-ascii?Q?Jl35hXrPjScX+tBdVQ+YqwO9WAN4YBMVxtAktFcc4scx+bo9bT39n5Rmh/MB?=
 =?us-ascii?Q?6fdBdN/64Z3gD62Fi8UVZyC1fdJQgsttpkvv1tkDFLpIJmg9ziZIwS9eobWk?=
 =?us-ascii?Q?G34Cwuvxsy4r71NOy+rmh6VOJsnJmF9GV3Af3whU0yDfOHPIkAbaKOzq5+lX?=
 =?us-ascii?Q?sKBFF22ICe8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YE/B7vrDue5LkInkuqHZuw0nooRUwqmRPhP/wn/99iXp7D3QeUpUAht/PLpx?=
 =?us-ascii?Q?r1U7wdFhDU+gYy9pS8oX9lOeKgm2kgkDaqz6bm4hyKIVeYr4KKiYHnzLV0Xf?=
 =?us-ascii?Q?VWxUPBJTRdX2hfwvNkW9AljPyaf5vUciBxTtqMtf0R2lf5ZqqZ/nHMCzzYcZ?=
 =?us-ascii?Q?0DFq9uQwu0X0M6hotmToiScfIXr0WGCh0O/MI3uVqYFQ3mZ53VfkH88Ipx5f?=
 =?us-ascii?Q?80Dw4pOgqz4uBD5yZfPW8MLPpaiDmRVKSln7+f8zZx2Mo0NGegXWZaeXwTTQ?=
 =?us-ascii?Q?/d6Rxwsuk40rZPWhNs0XtPNoDjo0uSjxiidAQC2LEdcm97tH1Yl8r+84oL4v?=
 =?us-ascii?Q?C4bqEETunpdJ5z5Q+WrYorfirKM6za44M72DKiNtmCBgE+z1/kMdIqMYY7aY?=
 =?us-ascii?Q?ZpktYvz9Y8oHUIE81L73ywWE01aTSE/o9bsvj/PpWBIS8PJiVi3i16NeA3i4?=
 =?us-ascii?Q?ZEYl50q4IY3O9t8UvIOwM7dY9xsZyMwssCobXduS//kKijRoY2xlaobvzA4P?=
 =?us-ascii?Q?7oXpeIM2pjR7vOOlse3eb1KPChGqER/UKQLDodo7LNjY5fsE0zGqg7LfE4lH?=
 =?us-ascii?Q?5eZ1WM4dq/hE/8nvBI/6IG+EGdTjcG8MKZcsS8AlI//ujShbv0RjY0xe9P7h?=
 =?us-ascii?Q?xHYKXdIW5HJPvhSiTxogmW876ZCFgPNom04d/255db/5bGMQtqKE0LEAsz7B?=
 =?us-ascii?Q?H37xmXiXzyauxYGbqbvEE5QpZ1Vl8Rl08S7er2eYOHLP3xLxr6WY749AxDgG?=
 =?us-ascii?Q?aFP+Nliwpwm6jVchjXnrlBZmkl9mt5sUzRc/YJ2o8b1z1F7ORKvL2Htce6Tm?=
 =?us-ascii?Q?PhtqOoCoA8zLeXbDLkmeWDj+KuXzMfeo3zTs2/tuNnAjGqzXhUvQ9cUmI5Jg?=
 =?us-ascii?Q?TkXVTlo+we+ZpgWhNIDom9LjMHxKe4RhF1O4hr7DyX6J1YQTbOlGPazDqSsS?=
 =?us-ascii?Q?fe+1KmXMOqV4dBhRyyuz7nBpCe9bXR7gz+99Ii2WVjFHseV2Lql+uFyeG3lX?=
 =?us-ascii?Q?KAl1yIfDOFykMKgY0qwNOC9bEM/Nja8d/wgvgHQMayfZLFxOQZn4Oflc0y1r?=
 =?us-ascii?Q?jTJ8z8b4ZuvXR8vid7/u3pPe2qbXEL2QRJyeca2NpTdeHpYsGebDxf4WTOmB?=
 =?us-ascii?Q?VdjXUhMR+Je5AMXSpHzj40aNu5QcztvhoiLFuax+6qbTi2LWe1hM6FseMwFV?=
 =?us-ascii?Q?WG22wztPIGWT0zkfCHFsRsJdP8Bkokmo9bARVUpmAnFT2zPEkt9gs1k27Pie?=
 =?us-ascii?Q?jYKSr7+7tnxLCLuQkmy3cGC0NQvGgJnF6yXkNaY+zjLnwWJgcrNwTNXGQEbn?=
 =?us-ascii?Q?YqV54ml/oUhzxTd7CTvG9uhlg+pfZehRaj6jXi+ft7Xkijyy6dmMl3AqMnpb?=
 =?us-ascii?Q?HTaaX8lRqo/46NoewyV2j3HHnXT0DkH1sVnIPyuqZV59cMpm93MavMHABPO/?=
 =?us-ascii?Q?UVaknjCdKka/RoOgAusyS4VR7m5W9ZkMNF2Wgv41yWE2DJr1BtHWOnRyn/eg?=
 =?us-ascii?Q?hH950tvcTGEe5ct30bfEtVqe1OZ7GP+wQ98/81sZAKDx4SUrnh8q9v5HGOUh?=
 =?us-ascii?Q?wficonev26TV5lqy6hr3jGL9Vf6r/WtKeJ2P8NYgEnN8XnId1KzSh1HODlOJ?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877861a6-ee62-4c8d-758e-08dd238be97f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5632.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 19:56:38.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNqTeCRpyxuUdbBmwcBtElntuX0DjiJW0GzEPnCkD84dW88XH+z8HoH9FiNXoJeUfAyxjC1Eo4Xft0t4RnaNYjFUwYK70zlaCbaVtSEE688=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9710

The fec_enet_update_cbd function called page_pool_dev_alloc_pages but did
not handle the case when it returned NULL. There was a WARN_ON(!new_page)
but it would still proceed to use the NULL pointer and then crash.

This case does seem somewhat rare but when the system is under memory
pressure it can happen. One case where I can duplicate this with some
frequency is when writing over a smbd share to a SATA HDD attached to an
imx6q.

Example kernel panic:

[  112.154336] ------------[ cut here ]------------
[  112.159015] WARNING: CPU: 0 PID: 30 at drivers/net/ethernet/freescale/fec_main.c:1584 fec_enet_rx_napi+0x37c/0xba0
[  112.169451] Modules linked in: nfnetlink caam_keyblob caam_jr rsa_generic mpi caamhash_desc caamalg_desc crypto_engine caam error etnaviv gpu_sched
[  112.182764] CPU: 0 PID: 30 Comm: kswapd0 Not tainted 6.9.0-02044-gffb6ab7d6829 #1
[  112.190261] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  112.196794] Call trace:
[  112.196806]  unwind_backtrace from show_stack+0x10/0x14
[  112.204592]  show_stack from dump_stack_lvl+0x50/0x64
[  112.209663]  dump_stack_lvl from __warn+0x70/0xc4
[  112.214385]  __warn from warn_slowpath_fmt+0x98/0x118
[  112.219463]  warn_slowpath_fmt from fec_enet_rx_napi+0x37c/0xba0
[  112.225490]  fec_enet_rx_napi from __napi_poll+0x28/0x148
[  112.230914]  __napi_poll from net_rx_action+0xf0/0x1f8
[  112.236075]  net_rx_action from handle_softirqs+0x19c/0x204
[  112.241672]  handle_softirqs from __irq_exit_rcu+0x60/0xa8
[  112.247172]  __irq_exit_rcu from irq_exit+0x8/0x10
[  112.251979]  irq_exit from call_with_stack+0x18/0x20
[  112.256967]  call_with_stack from __irq_svc+0x98/0xc8
[  112.262036] Exception stack(0x90981e00 to 0x90981e48)
[  112.267100] 1e00: 8fdc4400 81067700 81067700 00000001 00000000 8fdc4400 81a85500 807fd414
[  112.275288] 1e20: 00000102 81067700 80e6befc 90981e7c 90981e80 90981e50 8080113c 8013ebd0
[  112.283470] 1e40: 200d0013 ffffffff
[  112.286964]  __irq_svc from finish_task_switch+0x140/0x1f4
[  112.292474]  finish_task_switch from __schedule+0x300/0x47c
[  112.298072]  __schedule from schedule+0x38/0x60
[  112.302625]  schedule from schedule_timeout+0x84/0xa4
[  112.307699]  schedule_timeout from kswapd+0x29c/0x674
[  112.312776]  kswapd from kthread+0xe4/0xec
[  112.316893]  kthread from ret_from_fork+0x14/0x28
[  112.321609] Exception stack(0x90981fb0 to 0x90981ff8)
[  112.326669] 1fa0:                                     00000000 00000000 00000000 00000000
[  112.334855] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  112.343038] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  112.349835] ---[ end trace 0000000000000000 ]---
[  112.354483] 8<--- cut here ---
[  112.357543] Unable to handle kernel NULL pointer dereference at virtual address 00000010 when read
[  112.366539] [00000010] *pgd=00000000
[  112.370145] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  112.375468] Modules linked in: nfnetlink caam_keyblob caam_jr rsa_generic mpi caamhash_desc caamalg_desc crypto_engine caam error etnaviv gpu_sched
[  112.388734] CPU: 0 PID: 30 Comm: kswapd0 Tainted: G        W          6.9.0-02044-gffb6ab7d6829 #1
[  112.397701] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  112.404233] PC is at fec_enet_rx_napi+0x394/0xba0
[  112.408949] LR is at fec_enet_rx_napi+0x37c/0xba0
[  112.413661] pc : [<805355e8>]    lr : [<805355d0>]    psr: 600d0113
[  112.419934] sp : 90801e68  ip : 00000000  fp : 00000000
[  112.425163] r10: 8fe2b740  r9 : 000005f0  r8 : 00000000
[  112.430393] r7 : 8133830c  r6 : 8e740820  r5 : 81338000  r4 : 810cf000
[  112.436927] r3 : 00000100  r2 : 81067700  r1 : 80e6d4b8  r0 : 00000000
[  112.443461] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  112.450605] Control: 10c5387d  Table: 11d3004a  DAC: 00000051
[  112.456355] Register r0 information: NULL pointer
[  112.461072] Register r1 information: non-slab/vmalloc memory
[  112.466742] Register r2 information: slab task_struct start 81067700 pointer offset 0 size 2176
[  112.475469] Register r3 information: non-paged memory
[  112.480528] Register r4 information: slab kmalloc-4k start 810cf000 pointer offset 0 size 4096
[  112.489164] Register r5 information: slab kmalloc-4k start 81338000 pointer offset 0 size 4096
[  112.497800] Register r6 information: 0-page vmalloc region starting at 0x8e400000 allocated at iotable_init+0x0/0xe8
[  112.508349] Register r7 information: slab kmalloc-4k start 81338000 pointer offset 780 size 4096
[  112.517158] Register r8 information: NULL pointer
[  112.521871] Register r9 information: non-paged memory
[  112.526930] Register r10 information: non-slab/vmalloc memory
[  112.532685] Register r11 information: NULL pointer
[  112.537484] Register r12 information: NULL pointer
[  112.542283] Process kswapd0 (pid: 30, stack limit = 0x3ca59c34)
[  112.548211] Stack: (0x90801e68 to 0x90802000)
[  112.552578] 1e60:                   8fdc4400 8fdc4440 8105aa80 00000000 00000000 00000000
[  112.560764] 1e80: 00000000 00000000 8fdc4440 00000000 00000016 00000040 00000000 80147414
[  112.568950] 1ea0: 00000102 8105aa80 00000000 810cf5c0 00000006 00000000 8fdc4400 810cf6a0
[  112.577135] 1ec0: 90801eec 8014037c 00000100 00000000 00000040 00000040 00000000 80d49400
[  112.585320] 1ee0: 00000000 00000001 81067700 90801f2c 00000101 0f07b000 00000001 80e0a240
[  112.593506] 1f00: 81338c40 800d0193 00001000 00000000 8fdc4080 810cf6a0 00000001 00000040
[  112.601692] 1f20: 90801f67 810cf6a0 00000000 0000012c 90801f70 8065ec7c 810cf6a0 90801f67
[  112.609877] 1f40: 90801f68 8fdc4fc0 80d49fc0 0f07b000 90801f68 8065efd4 ffffb6a1 80e02d40
[  112.618063] 1f60: a00d0193 00000015 90801f68 90801f68 90801f70 90801f70 81a5232c 80e0208c
[  112.626248] 1f80: 00000008 00220840 80e02080 81067700 0000000a 00000101 80e02080 801229d8
[  112.634434] 1fa0: 80d47510 80197904 ffffb6a0 00000004 00000000 80d48c80 80e02d40 80d48c80
[  112.642620] 1fc0: 40000003 00000003 f4000100 8013ebd0 200d0013 ffffffff 90981e34 00000102
[  112.650805] 1fe0: 81067700 80e6befc 90981df8 80122bd8 8013ebd0 80122c78 8013ebd0 807d07d0
[  112.658986] Call trace:
[  112.658992]  fec_enet_rx_napi from __napi_poll+0x28/0x148
[  112.666945]  __napi_poll from net_rx_action+0xf0/0x1f8
[  112.672107]  net_rx_action from handle_softirqs+0x19c/0x204
[  112.677703]  handle_softirqs from __irq_exit_rcu+0x60/0xa8
[  112.683205]  __irq_exit_rcu from irq_exit+0x8/0x10
[  112.688009]  irq_exit from call_with_stack+0x18/0x20
[  112.692996]  call_with_stack from __irq_svc+0x98/0xc8
[  112.698066] Exception stack(0x90981e00 to 0x90981e48)
[  112.703129] 1e00: 8fdc4400 81067700 81067700 00000001 00000000 8fdc4400 81a85500 807fd414
[  112.711315] 1e20: 00000102 81067700 80e6befc 90981e7c 90981e80 90981e50 8080113c 8013ebd0
[  112.719499] 1e40: 200d0013 ffffffff
[  112.722994]  __irq_svc from finish_task_switch+0x140/0x1f4
[  112.728501]  finish_task_switch from __schedule+0x300/0x47c
[  112.734098]  __schedule from schedule+0x38/0x60
[  112.738650]  schedule from schedule_timeout+0x84/0xa4
[  112.743721]  schedule_timeout from kswapd+0x29c/0x674
[  112.748795]  kswapd from kthread+0xe4/0xec
[  112.752910]  kthread from ret_from_fork+0x14/0x28
[  112.757626] Exception stack(0x90981fb0 to 0x90981ff8)
[  112.762685] 1fa0:                                     00000000 00000000 00000000 00000000
[  112.770870] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  112.779054] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[  112.785676] Code: e0275793 e3a03c01 e5878020 e587301c (e5983010)
[  112.791907] ---[ end trace 0000000000000000 ]---
[  112.796535] Kernel panic - not syncing: Fatal exception in interrupt
[  112.802897] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

When I first encountered this issue on newer kernels I did a bisect to try
to find exactly when it started. My bisect led me to c0a242394cb9 ("mm,
page_alloc: scale the number of pages that are batch allocated"). But
this commit does not seem to be the true problem and just makes the bug
in the fec driver more likely to be encountered.

Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
the problem for my test case. But it still seems wrong that the fec driver
ignores the memory allocation error and crashes.

Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/net/ethernet/freescale/fec.h      |  2 ++
 drivers/net/ethernet/freescale/fec_main.c | 38 ++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1cca0425d493..ce44d4f2a798 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -618,6 +618,8 @@ struct fec_enet_private {
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
 
+	bool rx_err_nomem;
+
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237..81832e0940bb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1591,21 +1591,6 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 		fec_enet_tx_queue(ndev, i, budget);
 }
 
-static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-				struct bufdesc *bdp, int index)
-{
-	struct page *new_page;
-	dma_addr_t phys_addr;
-
-	new_page = page_pool_dev_alloc_pages(rxq->page_pool);
-	WARN_ON(!new_page);
-	rxq->rx_skb_info[index].page = new_page;
-
-	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
-	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
-	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
-}
-
 static u32
 fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
@@ -1697,7 +1682,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	u32 data_start = FEC_ENET_XDP_HEADROOM;
 	int cpu = smp_processor_id();
 	struct xdp_buff xdp;
-	struct page *page;
+	struct page *page, *new_page;
 	u32 sub_len = 4;
 
 #if !defined(CONFIG_M5272)
@@ -1759,6 +1744,16 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 			goto rx_processing_done;
 		}
 
+		/* Make sure we can allocate a new page before we start
+		 * processing the next frame so we can still more easily abort.
+		 */
+		new_page = page_pool_dev_alloc_pages(rxq->page_pool);
+		if (unlikely(!new_page)) {
+			fep->rx_err_nomem = true;
+			pkt_received--;
+			goto rx_nomem;
+		}
+
 		/* Process the incoming frame. */
 		ndev->stats.rx_packets++;
 		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
@@ -1771,7 +1766,11 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 					pkt_len,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
-		fec_enet_update_cbd(rxq, bdp, index);
+
+		/* Update cbd with new page. */
+		rxq->rx_skb_info[index].page = new_page;
+		rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
+		bdp->cbd_bufaddr = cpu_to_fec32(page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM);
 
 		if (xdp_prog) {
 			xdp_buff_clear_frags_flag(&xdp);
@@ -1883,6 +1882,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 		 */
 		writel(0, rxq->bd.reg_desc_active);
 	}
+rx_nomem:
 	rxq->bd.cur = bdp;
 
 	if (xdp_result & FEC_ENET_XDP_REDIR)
@@ -1943,10 +1943,12 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int done = 0;
 
+	fep->rx_err_nomem = false;
+
 	do {
 		done += fec_enet_rx(ndev, budget - done);
 		fec_enet_tx(ndev, budget);
-	} while ((done < budget) && fec_enet_collect_events(fep));
+	} while ((done < budget) && !fep->rx_err_nomem && fec_enet_collect_events(fep));
 
 	if (done < budget) {
 		napi_complete_done(napi, done);
-- 
2.43.0

I am not confident this patch is correct as my knowledge of napi and the
fec driver is limited. Even if all my assumptions are correct I still do
not entirely like this patch with how it propagates the error state via a
variable I added to fec_enet_private. But I could not think of any other
way that did not involve more significant changes to the existing code and
I did not want to spend too much time on it until I am more sure the
overall concept is acceptable. Suggestions welcome.

