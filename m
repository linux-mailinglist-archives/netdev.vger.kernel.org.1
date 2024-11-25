Return-Path: <netdev+bounces-147250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BA9D8B85
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C64B29BA0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AFB1B6D0E;
	Mon, 25 Nov 2024 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yj51uN/Y"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A3160884;
	Mon, 25 Nov 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556666; cv=fail; b=nSVvptczqlzU7dYmDg39+FD7jlvZjIzvvZhLLObJ37UFEhGi4JX70u+BaULP83XTNNGd7D5leJ06bpv0EIDNybnWJkbg7c6K2PrAmXLunphm60sKDLvANUPxKuEOhzKtq3bXCzmKJowjYoHl3Q7ajuhrLboL8CrkHIF26rRx8Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556666; c=relaxed/simple;
	bh=kb6uGDnrXaioCCyGLzf4G9uU8HzKhM4hczGdaBEazFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PS+UpDqiSV7DPe8R80+QLAG04TqJBi0bPUbaD9wW/fLfQ6cMoZ1A3T7BVYnmk5g1lCjb74QokO6oNyWuy65+RwoGaz1RVl4GLKtiKGBBMEwmeHhq6ep8inTEUmc4NeyB4vvFgd7/YQEb/5/hdcFaR7g0sTH4RTGzbiS6LlyHnug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yj51uN/Y; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1hqdcwgbI7ihtVUUV9f+i2FFIdBFeMtO/OO1KnV3vpdq2dV3QggMyWdbEfwYcfzdbx5s0aZUI1fhBL8rbRvl5gWVbcnZEh7zWBCAornPxI28E/bJsix9MIO9zDJ8DvaJJ2ssvGPDq2BFnt4U7APGV3tIGzHGkd+362xTuclthCgH2URcvODL9JAmyJn+qr6Fh/iGOZ5WbAa8GdPTjuppi+Qmk+H7EMCSCSpbncMRxgc5JbHkzkw5nWF2WgUZcTBZPZ3uhnWmG+GfSTSwAdWZw4rp6dz7Jpb/IRSs3pKNIxBzcc2fgYHGnuEfmnwubwFWZ2aUEoqaNYkNytVUgW2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loNZmyWHpamaxTSA0qM/iNvmEY4f6JTpcCGov23dTh8=;
 b=i8OfESsbIpeSeW/p5SAw8GWdkq0ppXEc4HlgeEZkQN/Xco6OWKFz6EzPTmvG0NcKfvvkemdIKJ8VDeQPZJZvIstPSRpUsyw/+C2XbaOG1qzvF3JyZva8RIwjLciNO0CdMyg4glRLY5J3Fjn5hIJvjIq6RHoQbgy/pVF+krj+aUaob6qZW5vDRbGoGEqiWbGb96GZWxYlvMUDU/uJTVcOVm2c6/92ZYkXU9QmiUxV9GO9xD62qJUii5sq1g9bVLTfpm95Dy9DRaM9ZfRbAAtxwLuPCorWI4pPhHRKwff/WIENftaAaWSQ7+lKcV4BGkHnicXpaG0U1C2YgQvqBxw0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loNZmyWHpamaxTSA0qM/iNvmEY4f6JTpcCGov23dTh8=;
 b=Yj51uN/YnBzdeFhhHm+ILfPte78mh+x32byiGcVnIAnmJJo1VUFoJDv0pD4hUJovteiTe90MGW9YzMuSWq486uezngV3we6OQub95qh0X5SMO2+L17fAVvkhE/pN99iEuxRC5OFkb+p3hrp7hUCqbm+XP+3Z5v0CKYR1okSI9Gw6pS5upfwFRIf53UVNYToiIDsZF73jW5OIjwHinLlGItSaDGhO6qp5No/yJwHwLOz75Z8xGLDI7zx7u/lwFo2f0fLfvNj2dMbCa8rjDFM3kK/cBuiPGQkUVGp9vVwUdd1U3ALVqrWbhk1HQAGOxxOxUkfor8GVL7xJp3kVbCsWfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 17:44:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:44:21 +0000
Date: Mon, 25 Nov 2024 12:44:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net 1/2] net: enetc: read TSN capabilities from port
 register, not SI
Message-ID: <Z0S3btCU0raWZIUc@lizhi-Precision-Tower-5810>
References: <20241125090719.2159124-1-wei.fang@nxp.com>
 <20241125090719.2159124-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125090719.2159124-2-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: e1000719-3fc7-45bf-6a4d-08dd0d78cb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zLX17o0wXsNRemofYUEyN1ugkT35XN0BXZKBa/rBa78ESI55yrRfNQiQj1rg?=
 =?us-ascii?Q?XG/g3y+g9XpfSQbrmeKSPx0ON/Uy5Tn1icVtYAAQu5jfYTeyt4eNEnj+pdFC?=
 =?us-ascii?Q?8CgWQEorJUqIB9+G7TgKqh9HTRL1dYAclmtjJnmJKIvpcQJX+DQKCWdAt2+9?=
 =?us-ascii?Q?64UiVX5r2AlNLTnJ5d/4nz4Dx+GU3vN9rFR2CgZK+KVkFfZ+u0n+wl2wFCSm?=
 =?us-ascii?Q?UW5R2bD3YtH3PukGrEG6WwjVFjVH2xnDugNefLTnX8djxC50HtrV+XErCo5E?=
 =?us-ascii?Q?i965TmwyO3zjizOf9x9b7mw/2Fg60/V0ZJyVhW3Qpg0OJyAmmOSdz5kP7hph?=
 =?us-ascii?Q?XrBZz5t1QReqGpc90MQYWPq9E01l7f/ErpMoUYY7vuHqbjWLvfgca+zVk7wy?=
 =?us-ascii?Q?3rDeJXxodnNw8vROKjxeRtMxTw+9FZAGln6JFXjc+TFdV1J/8xgfCDEW3Get?=
 =?us-ascii?Q?olZOZZA2Bre8DALySMCeEB+8q0Vz4BqdDeRMtMt4Sp2NC3Oafe4czLX3lGSX?=
 =?us-ascii?Q?GbCl72YvRQDpAuMpDP9K91XPGyeeH0d+XtcdlOuNq3QNRkVOSzOMSugFMz+1?=
 =?us-ascii?Q?S0pcYc7RcaveuwI/iZBjaoterlNSPCn30PO65dMAo7Baf8RObsshnUHf+5P/?=
 =?us-ascii?Q?ohgSk4JxY/TRcatgLQ35QlmsRYH6MoWiiRUgs6sDitMhDExgCQonYnp7iEiK?=
 =?us-ascii?Q?hx7xZkJxDxvyo0QiL3T/1fkGy62pUhxPQ7itgrEJqOiWwIJ0vInHT15naL4n?=
 =?us-ascii?Q?ulOCBoPZZigIRVoUk/tF/X3SFshUd6oAciaNioOV15RYtdwVdWe7oBSuzB36?=
 =?us-ascii?Q?z0jYPywITnb3vBlcwJMHfnbi8QLaBnoyZauQXtHbSzL+k/Lg2hP0IMewc7zS?=
 =?us-ascii?Q?upzbfdu0zeVplyicRI3r63pID4BDEQYZfZgxZUINo4SQ2IojqNCPyS8TfEqS?=
 =?us-ascii?Q?ViAnOKavlMjUdbaKnJ3u1xZdabDEPWDbk5lb8rQsQS/mP6O80+/matIoVxP3?=
 =?us-ascii?Q?WXcIjrLGFIPXD1xcpaIo1VlYjlA5DyqRgdveA+8S5SQUGXx56JQUgfA3hGGr?=
 =?us-ascii?Q?52R50fQ1Shi8zOwiE0E9dG6EAOUAY2dW1023bPkms64ukbYOc3pa1L35zYvl?=
 =?us-ascii?Q?ra2+AnTFSVYyBcfb+EFamUuyGJzk+y14dq15a6Sw60DcvFCTu1KzctXd5dlY?=
 =?us-ascii?Q?6jchRWFLcuMcsdJnxpTuqKyV9o/I0oiQkj7k5bp4eSZTEFcv41jaAoagti28?=
 =?us-ascii?Q?3d4qaynEvTIlsKnVbtEXMFUv+wU4nz3HZHFrH/kYLQE4n0fCYWMBmRP+UbFE?=
 =?us-ascii?Q?tA+5a1pHJeCIBwacL0A7N4Fks6x2xiFD70Sf1Kb42uQ5I6JXPwdqrdt44Fob?=
 =?us-ascii?Q?W9QtQ/BFTKT6BmF4A/rPrF+jLJV3mEg1xB+P8SGBzZEx0YObzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrjcjD0gPBadHGUGsCpIArMk4wxZC+1S9YBaGdCKC32FnOrddhEwNNRILCr0?=
 =?us-ascii?Q?Da7FHVe17OZJqyKJ81DhCPCPkq+nsoNmQbGjxKd7pCxga3lWKYQ5kqT3sWV/?=
 =?us-ascii?Q?PXG/pGwr8tGziWmMg52O3I0Ej7HrvbGkz7PRBwg6xUQ0u8dvahUZmajMhH3I?=
 =?us-ascii?Q?hvAcw9R2vNoio7yGFqoyUHiW/R7UwzCNo36rbQ9vf+qxTA1WYH9Ja8KpJHt/?=
 =?us-ascii?Q?nAzjLN7/RqFZ/7nzBSryG2bwvjxV1PmmYHhzNIlrhhE1FhCAnFucvRhDYkOS?=
 =?us-ascii?Q?0wG4xz6jhKnmRFEm28puvytC8To/2YZb2JEnpJDKd88Ymk3SbFZe/j3Idq1V?=
 =?us-ascii?Q?NhecRonCz/ZpF/QsNvB6GvUNlJNOeYlLiqtKxnSeWJdt8s5bFwNNz7lMT3Cv?=
 =?us-ascii?Q?FQEMNO33Ercv91P73X9MUiT+u9Zo7i0JLoNFNZd6HlmioirKwz7djJUUUchD?=
 =?us-ascii?Q?f9+SeG8bvK9Z9k7+28jbxK/sP8i9Cy/FjEXNFV1iE3JrTMGSSQ4phUxFEI6e?=
 =?us-ascii?Q?T7PdsSqtDsnEz7KIKCqWVngEOrhlXDUa6bGKhYNcSpY+RnrSwNYq5lAKrCku?=
 =?us-ascii?Q?LACSDyrmVmAhKfSIAZaHbxw0o7nwYcw5WiMZdFqVhpZyg/VKlaZDAMWB7bSp?=
 =?us-ascii?Q?/Su+xcOFUkBH643O7cO4GYDbQA/EU0/V3QpSrf1IR2EjjbCy42UNszwWLWYS?=
 =?us-ascii?Q?kuolLY5FLOfpKseLW9Viy7gNSQhG6nRx9bfolVOuqJrOa/r4UJZUDA1ug710?=
 =?us-ascii?Q?mvT+4x/UyAZzBwkmQfltZB77t8so9HTKZM/uF/BkBYGbVkk363lo+QDKdG12?=
 =?us-ascii?Q?5NYETXj4MkkqAEGDfs4FlXDNdGazmU29tOjZ/sgGjdohgA4S2yJLBAmK8hjz?=
 =?us-ascii?Q?O4sI/se+T2kFmC3ioe6ClGie/s1PiK73rNaTlhIK0JjkxFXvppHxrwz9+KCb?=
 =?us-ascii?Q?dkRPNB3kcK4ynP45l3NSJh2EznsGIw+Avti60EIjkEqPPM+HX7PWokGwemkj?=
 =?us-ascii?Q?hEAu3LHE+l9G5OMTezTaogaCeVrA2ljePk3cRNlH9kC8lMJEm+ie0i8ZSTu0?=
 =?us-ascii?Q?xENZaSliqerBwnEuF5hSc/rdiZUwqDtAQPfcWP5udG7pza1tEbh5ut4rYX+3?=
 =?us-ascii?Q?jxreOK24HkDtRHeubZn91uefbaWX4CPqJ8iyjCUQxvIvTkx+7GcnNg4hBEum?=
 =?us-ascii?Q?d8wX1Z+9AA/fxtZKYYbCcSkCPJewX2fLwOPUt3+JtCzy7pR6EQsiwsR1zntI?=
 =?us-ascii?Q?pDXTtiPwvkahWX2+qeoneWnMOGUWxjLjK0IkYL6aGphD594G8AxBwUt2e1CH?=
 =?us-ascii?Q?/U2AmKdJy4bcwH4YVF4IWpOpQYxrvRQ9jbQakoHPHH2X9IX3iZ/B59OYoYo7?=
 =?us-ascii?Q?Q3sCh6Cxc3Z6OS361Emd7rtmfl9MmmZjrvNcf//iwly9USj+8nEU2okMqDg2?=
 =?us-ascii?Q?ADvDTXyBXI/t6YSjPrKKeHI6grKMK6yiVqzotYUfFgsp7bJwN/o+Cw6DY/Xc?=
 =?us-ascii?Q?3ohnjx7m9n4a3YX6ydm0Chz5FWkCN4S25NZMsS3erhqc8SKAgpGGJ+35X5b3?=
 =?us-ascii?Q?xZIwWsst13KSxtdP820=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1000719-3fc7-45bf-6a4d-08dd0d78cb28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:44:21.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4nAgDOXE9NK5Sqd/VGsTKZ+dHfJI5BZ9/lT3kNsQ91kcLYuQeQJnATWTwRTgBk6meGyKnqJ0/VS5Bk4aCh5fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Mon, Nov 25, 2024 at 05:07:18PM +0800, Wei Fang wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Configuring TSN (Qbv, Qbu, PSFP) capabilities requires access to port
> registers, which are available to the PSI but not the VSI.
>
> Yet, the SI port capability register 0 (PSICAPR0), exposed to both PSIs
> and VSIs, presents the same capabilities to the VF as to the PF, thus
> leading the VF driver into thinking it can configure these features.
>
> In the case of ENETC_SI_F_QBU, having it set in the VF leads to a crash:
>
> root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
> mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
> [  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
> [  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> [  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> [  187.511140] Call trace:
> [  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> [  187.518918]  enetc_setup_tc_mqprio+0x180/0x214
> [  187.523374]  enetc_vf_setup_tc+0x1c/0x30
> [  187.527306]  mqprio_enable_offload+0x144/0x178
> [  187.531766]  mqprio_init+0x3ec/0x668
> [  187.535351]  qdisc_create+0x15c/0x488
> [  187.539023]  tc_modify_qdisc+0x398/0x73c
> [  187.542958]  rtnetlink_rcv_msg+0x128/0x378
> [  187.547064]  netlink_rcv_skb+0x60/0x130
> [  187.550910]  rtnetlink_rcv+0x18/0x24
> [  187.554492]  netlink_unicast+0x300/0x36c
> [  187.558425]  netlink_sendmsg+0x1a8/0x420
> [  187.606759] ---[ end trace 0000000000000000 ]---
>
> while the other TSN features in the VF are harmless, because the
> net_device_ops used for the VF driver do not expose entry points for
> these other features.
>
> These capability bits are in the process of being defeatured from the SI
> registers. We should read them from the port capability register, where
> they are also present, and which is naturally only exposed to the PF.
>
> The change to blame (relevant for stable backports) is the one where
> this started being a problem, aka when the kernel started to crash due
> to the wrong capability seen by the VF driver.
>
> Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v3: new patch.
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  |  9 ---------
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  6 +++---
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 35634c516e26..bece220535a1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1756,15 +1756,6 @@ void enetc_get_si_caps(struct enetc_si *si)
>  		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
>  		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
>  	}
> -
> -	if (val & ENETC_SIPCAPR0_QBV)
> -		si->hw_features |= ENETC_SI_F_QBV;
> -
> -	if (val & ENETC_SIPCAPR0_QBU)
> -		si->hw_features |= ENETC_SI_F_QBU;
> -
> -	if (val & ENETC_SIPCAPR0_PSFP)
> -		si->hw_features |= ENETC_SI_F_PSFP;
>  }
>  EXPORT_SYMBOL_GPL(enetc_get_si_caps);
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 7c3285584f8a..55ba949230ff 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -23,10 +23,7 @@
>  #define ENETC_SICTR0	0x18
>  #define ENETC_SICTR1	0x1c
>  #define ENETC_SIPCAPR0	0x20
> -#define ENETC_SIPCAPR0_PSFP	BIT(9)
>  #define ENETC_SIPCAPR0_RSS	BIT(8)
> -#define ENETC_SIPCAPR0_QBV	BIT(4)
> -#define ENETC_SIPCAPR0_QBU	BIT(3)
>  #define ENETC_SIPCAPR0_RFS	BIT(2)
>  #define ENETC_SIPCAPR1	0x24
>  #define ENETC_SITGTGR	0x30
> @@ -194,6 +191,9 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_PCAPR0		0x0900
>  #define ENETC_PCAPR0_RXBDR(val)	((val) >> 24)
>  #define ENETC_PCAPR0_TXBDR(val)	(((val) >> 16) & 0xff)
> +#define ENETC_PCAPR0_PSFP	BIT(9)
> +#define ENETC_PCAPR0_QBV	BIT(4)
> +#define ENETC_PCAPR0_QBU	BIT(3)
>  #define ENETC_PCAPR1		0x0904
>  #define ENETC_PSICFGR0(n)	(0x0940 + (n) * 0xc)  /* n = SI index */
>  #define ENETC_PSICFGR0_SET_TXBDR(val)	((val) & 0xff)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index c47b4a743d93..203862ec1114 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -409,6 +409,23 @@ static void enetc_port_assign_rfs_entries(struct enetc_si *si)
>  	enetc_port_wr(hw, ENETC_PRFSMR, ENETC_PRFSMR_RFSE);
>  }
>
> +static void enetc_port_get_caps(struct enetc_si *si)
> +{
> +	struct enetc_hw *hw = &si->hw;
> +	u32 val;
> +
> +	val = enetc_port_rd(hw, ENETC_PCAPR0);
> +
> +	if (val & ENETC_PCAPR0_QBV)
> +		si->hw_features |= ENETC_SI_F_QBV;
> +
> +	if (val & ENETC_PCAPR0_QBU)
> +		si->hw_features |= ENETC_SI_F_QBU;
> +
> +	if (val & ENETC_PCAPR0_PSFP)
> +		si->hw_features |= ENETC_SI_F_PSFP;
> +}
> +
>  static void enetc_port_si_configure(struct enetc_si *si)
>  {
>  	struct enetc_pf *pf = enetc_si_priv(si);
> @@ -416,6 +433,8 @@ static void enetc_port_si_configure(struct enetc_si *si)
>  	int num_rings, i;
>  	u32 val;
>
> +	enetc_port_get_caps(si);
> +
>  	val = enetc_port_rd(hw, ENETC_PCAPR0);
>  	num_rings = min(ENETC_PCAPR0_RXBDR(val), ENETC_PCAPR0_TXBDR(val));
>
> --
> 2.34.1
>

