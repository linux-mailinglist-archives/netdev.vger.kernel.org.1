Return-Path: <netdev+bounces-211872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA07B1C21C
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A5D179EEB
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062D221FB8;
	Wed,  6 Aug 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UglUDZNl"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4317597;
	Wed,  6 Aug 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468803; cv=fail; b=tbtmfyp1i/LVW/MmeAdEcmGqB68tLMG85b26ROBUBtMzRUOr1R4dhN0717E+jYdtgyAA4XwF0/W3o9zb6tBQ4Q4lTmOFrQgYkvJeuj+H2eSkn/Bu/3/L3UXt2zIYYZsVctcKR05vTWp45lUbvr8xwW8FwUdys0Iy7Iy52XK5jW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468803; c=relaxed/simple;
	bh=RcWbIkzzeYBoqs3YaikGMnTgKWioejDpbzW0QOgJ3KY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Kjx7fkGwgd7totT7Ow+ykBwZF//SD+WJUlyQaNB8exZdEBkST3F/abFEsushA3UH8GFUEBF8wgpWeTHqLtSQYMmHV9h1MQfG1hOVwq8uAvWs0vs7Iv+io/leHcQzxzcZqynenzfgfUUKDtlCG9FDeAPuciNVOsPIvpFAuOoy2ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UglUDZNl; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK4iPNBDuyaMnTL85QooPSW/Z6HboNKic2swvZWf/cRYCmPnnIBeuZ/qrfVQxH/Sy6hM3aDxQTdGrPiUOFLyiSunca07SlO/TG/Kx4N4bFDgzpcaLfTQcVyVQUfdDdiJZVjyPTPZWSp5i49usHCKliOE2EdD5FWHsSp1AzUJGBAJeqFP3pfqXqY0ZKg0Ajih4v5uT44ZndDTRND4D7e9EBDY4XJta0DmJQOHhQtxf4g8WrQn7kV33YqTXU0CXt8SkHI3xalauvkWov9K9S5oCcdiFCnbjy4A2Ep5xVe3FEfDRbz/KKtZ1PENpKLYkZr94LRDvBXLMWfrVCRsaUeN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD4fLyE3bG5M+xDECvgfGcpNlpLMLOzyjFKV6k1QgT4=;
 b=Y+YnX+cndmHFsQveoRBxJOAc61ZMBgZBRAH5olVvPLgCx3YfBxdb5DhYHM44ptma3nQJvirOsPpN1v4NdV94X/ab/QXXBCPE7GmBGeUgdLhJFy7f5T5+pggeJePoPk1RnIC8K1SWjyRvZGS+whh8IodAb21A/nt/NeuFA+lQ7nTYmmT8QCgUsydesg5/8gcvfCc7QIRgwktTvXmPH0u3xW6uCaSP2uBeZPH/y/vqfcQbbHvtCMLfV4RD5ITAlAUD7CdrsTyYvu9bqasxMhjO2hiWZ9vnhARNGuKDNHQRi3NsILFhBCEflQtDV7lpnF0GnVNm2/Q1bttedShvuFrK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD4fLyE3bG5M+xDECvgfGcpNlpLMLOzyjFKV6k1QgT4=;
 b=UglUDZNl2AtFInW8tr/d3piZ/K76z2eFGkctXURF0Lt/nOOsd+IYZNd9sMfk0cP3aW4MVtN8dNo8Ndw/Mf9M7NYhjwoUKxIbIOcUhz9XhI1RygItrx2MITZrJABsBQ+P0Lsb+2EBASO8d/vmf8O9NO4SmwN/0h1T5WPcbqeqOalECQKLLO2bdJoLHp63X8maUsqWKS7oisPnavNdPr7KgC0SdDHHJlj12uVu0n1kE8Mc23rahB1BLFKHiVtT7BUgx+0pgsgwRfMQQXVaVuMRIl0b1cRjDg42gC+RJWdcQAL5M/66zmMrYD5RltD10YulYZnUJHdKgRBZNEA8YvJ3cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8560.eurprd04.prod.outlook.com (2603:10a6:102:217::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 08:26:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 08:26:38 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	o.rempel@pengutronix.de,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RESEND] net: phy: fix NULL pointer dereference in phy_polling_mode()
Date: Wed,  6 Aug 2025 16:29:31 +0800
Message-Id: <20250806082931.3289134-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 969e9367-5686-4de6-c9fa-08ddd4c2f629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIquCns3BBcSAxgqwPgTFxn1iQroQOZntBJzeKiFZBSFxTqRJTBEKssfVHUn?=
 =?us-ascii?Q?YKozOFlR8tr0j0bt7XaIkHCMcaGU+26h6niGqQsL2IK6L9YWm4V3L8+3H663?=
 =?us-ascii?Q?oMAyKHiucuevcAiWCyMzM/X4r33i0L84n5GJYLAcTmAfCimOvnCnjobtAU4r?=
 =?us-ascii?Q?yvoWr2vgkQiT1+guB4KxWWuupnNKmbBcUw89z+Ye4d56uqy58R5dzSsO5GlH?=
 =?us-ascii?Q?bALLohfERuWRmEe3/pkAAuqdsNTVbt1k7vtZ8l+hDhXG9tmA37w9b8krLj8I?=
 =?us-ascii?Q?JRHs08Gw/7o1UbtJsp2vp/eqols9wzn9lAHLDztEwOm4C9iAcBUPjCLTJK+1?=
 =?us-ascii?Q?msK+Vi5v2HmRWSDqHd5bZZROQ0H06xRBuMpO8YIhJZFSQvcvL+MhSHEozZTp?=
 =?us-ascii?Q?yuWiaW2NhfOTFVrpf+jTLJWqfd5RTynPAeVn5AIIaFVk4/Mj97PC0i9LOLq/?=
 =?us-ascii?Q?ujtZNwf7sS5WYMxFRagOmZ7dWoQGd9Z6rBIKgJsnKy5488vjbvdjEnE4gA0N?=
 =?us-ascii?Q?vVNcS87alEdUqsKxsxggmVxkgUrBhjymUTKzDwxARjKcG5hcVMmiG651qJMn?=
 =?us-ascii?Q?9dhc+OWO9w2pPKsSfg+Vf2GZHt9SRDkaeIv1+/qo8KduYTsZdZlFh3NqG44Z?=
 =?us-ascii?Q?up+UQc3RX4x6wopPG4LiP45HOw6hdyutvCMd3PPf6id86KEG5/e/yVMdt0NX?=
 =?us-ascii?Q?gKkWfm5c4I0UF952A3rspWFLH2+R0h+/VVcxqLzC674DEhXQsibL1l7TgXvM?=
 =?us-ascii?Q?A+dxzUa0lsmr+gjEqoQSNaY0uSPuh3cd2rEmiD51K/g0VuZmzj7f63eU6OMq?=
 =?us-ascii?Q?2DHAFtfvbkFLHV0ixXhjnTOJLfkKOsAt7qyfB8lxVuDNyfU+zjYzFR7nqyzN?=
 =?us-ascii?Q?QaTmaCv1qy+Uvp+BA6JlkbDJnB/2MPmPdviT+1/eN6nPzGvKIgrTAguiyyzw?=
 =?us-ascii?Q?IG+9vF+90pKeVmWeK++bCtqACHyhhvzGCnAk1SNQ++05Qzlo4teJCPsgiolu?=
 =?us-ascii?Q?VbTa6teZrk7mB6xLRjlZUffGWQHIrjV/xzPmObOTGTvgsbUJ2dASerUH3Nbi?=
 =?us-ascii?Q?nvzvPgiHnWHAI9fwuirwyM/HI/LjdtR7rD/DcSS2AItwQ9hsGqa3sqD3GtnA?=
 =?us-ascii?Q?VJeIdhHPfraWrxUc5m+NpyBtixu0d/GGou6MDx0+BWs6sH+fMDtjIJWy3rJD?=
 =?us-ascii?Q?4F6XyRikG14eQi3JwFP5D3VOUg7iWEKAvUjXswIhEuPuV7qos1j/Uhq8T871?=
 =?us-ascii?Q?Vcj2xdQftBbLawVK/KGMt9XOpcnsiU8v8Li87XQjDzgA6NFuRQAp9W/ZQOEQ?=
 =?us-ascii?Q?VTYy1RC5HgGS6fAh7ZQaBumAnKMnAO2MIfhwX6yWM9p0COQWHX8r0x6WbO0d?=
 =?us-ascii?Q?O1A1iB+W9GHpOkPXjcSi3POiGUm9I8UgrnbDQQ6HO7tlTsrTCRQKYQjBnSmQ?=
 =?us-ascii?Q?YDQOCXNKt7+F99wnP8UvMA+fqzg0hujxUbO1AU13K91xC1cRHcKi2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5pIN2zqvip5NJdELaYT4nTk6yE1s7FZmllSvg2/W81ByIGE9ahVxb2g0clAg?=
 =?us-ascii?Q?fMLAS6vjG/QGQyJRqLkrHa6UUQxL395QPhT37bhyNAVEmavfVbhqdcwBFu+D?=
 =?us-ascii?Q?VJjRA4qAJ+zHm3u5LDmOUgztZjvJl2xOCLFm7d7Cc/Z+aE8exukwhY/G7wth?=
 =?us-ascii?Q?PX5p00e1HYV5m+Y6eMrxGj80Yo7T/sa86imMVEBI33tp3H2Dpqm/l2I+PM2B?=
 =?us-ascii?Q?OKN74DkfvhS0T3nsCzCnvxPzQyS8EJRqB4WjTsyx6ma408jgQNP4p/tonXRa?=
 =?us-ascii?Q?NHDBGt73g+WKkY+TyulAQYP8fKqPoyXE4rJtJxH5MMnXBQBdqzZx8CeHoI1x?=
 =?us-ascii?Q?C/9Rjk0REvoQIyahyfEXhHpJk9V3XpvBbO7lkY+OQoSQ+ns5Jl7yOR+S0L2L?=
 =?us-ascii?Q?soD0T8Ki8PNVTnyDFpoVLOAK+XlL+g5UriIxUv0m8LAhVvNNPdW5FQSbVsG4?=
 =?us-ascii?Q?N2ebKA5lvJvwTNTcVFR1As1bhKkDFJB8uHxDkaOI6obvu74F/soFPklJv0Y+?=
 =?us-ascii?Q?rAKGhOHUrKnEU+YphrAkWdT+PD3FesvHcbqt0JlfMMX9DFjM6kqy9PFCbwgv?=
 =?us-ascii?Q?5FKSgs4GG8g3B4zLn29Y6ABQBnnAfcD0h64loYWPCMhYh6cNb/S/DqjFAOl/?=
 =?us-ascii?Q?rEwkqM6l82hIl8s+M2DjuGybOzqx2vDZMNV4NCwz1HXEUkoepdA8NmBj6r+k?=
 =?us-ascii?Q?NKV+BKVNWJv5xf79M/Kw59TAxUVXGI83bMPSA/44RV5Nhsn6B/Au3Q1P7J9p?=
 =?us-ascii?Q?VjmGaHaY3utoNf7/vSjS3tqKj5BQF+hWrnxKR4+vkOUFXR7sExwded58MHb3?=
 =?us-ascii?Q?LFoP0MvSvRJwSamstCt8FbVK4NWXIfnIkAYfcaVKGCeFyxVVHks7L8g252e1?=
 =?us-ascii?Q?Rf8ZNj0U/nR1N131MEb0wFbPtgMX09GgzwPHBmGGC3ragfWDUtSyr4QZCGH8?=
 =?us-ascii?Q?4mhKaipcIvwLaLuIbi9pq8ihxM8I0kJuLRNGYn9xgWpIfUp3Y+bv/W4IB6DT?=
 =?us-ascii?Q?afFDXebBxpYzQrJRlF2BOP1DQFdRYhmzSIs/WLgPds6V8WKBdwPhzRCB8VMo?=
 =?us-ascii?Q?MsIiFSZY8HOnmqGsrYNkXgzwE1rSGyH/nSsyEL2Eby5RiysIJK2CEozXav0v?=
 =?us-ascii?Q?RaODHTv9ZvGJ15Lv5mHemxopMhXkpWbIhoIZJoOvM35PHCxhZbGena2h341F?=
 =?us-ascii?Q?e0OY7QHtg/O+C3zrSbEj8VPTCMOa6gdGOpK04Usycto0FOdJYBkfRsE8pD0Q?=
 =?us-ascii?Q?mNQSXn/GV4qvsr8n+V8ybXdNQQV1uGH/qoCsbO6EUjBrzs31SE9pSM9vBMGK?=
 =?us-ascii?Q?ClAddTGqfDW0Ij2HOd/deREZ6ID0/YSoetRD/ybqDcZKeccSkWHTHekFLW5I?=
 =?us-ascii?Q?x3P9SLkpcGDaPRuWsSO2J6wFOxsHOJN+bnBpoHGMjNqRYs8Tp/2BxxMUtb/D?=
 =?us-ascii?Q?DX4pPebxfbWCIlFl9VY2jKRY6bNrYEzfVP+VoOfw/XzsStGWWXsLdh+RgcNp?=
 =?us-ascii?Q?Yz1FEFS8GIi2GiCMrvFaTYW4rLAF+Ayg7/2qHH3oqh6j3gYX8KDSpSRoqYNr?=
 =?us-ascii?Q?eTQ3nAu8Vp2+g712fPafUPvjtakYXjpumHwTxwNY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969e9367-5686-4de6-c9fa-08ddd4c2f629
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:26:37.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUd2MYjOYeW/Ke9z60H/fG3UYSYHlRuOlVt45cMlZr+bo3q3OrCK+01omemHz0QwKHsNmaqDOQfFOp3rWHYPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8560

Not all phy devices have phy driver attached, so fix the NULL pointer
dereference issue in phy_polling_mode() which was observed on USB net
devices.

[   31.494735] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001b8
[   31.503512] Mem abort info:
[   31.506298]   ESR = 0x0000000096000004
[   31.510054]   EC = 0x25: DABT (current EL), IL = 32 bits
[   31.515355]   SET = 0, FnV = 0
[   31.518408]   EA = 0, S1PTW = 0
[   31.521543]   FSC = 0x04: level 0 translation fault
[   31.526420] Data abort info:
[   31.529300]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   31.534778]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   31.539823]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   31.545125] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000085a33000
[   31.551558] [00000000000001b8] pgd=0000000000000000, p4d=0000000000000000
[   31.558345] Internal error: Oops: 0000000096000004 [#1]  SMP
[   31.563987] Modules linked in:
[   31.567032] CPU: 1 UID: 0 PID: 38 Comm: kworker/u8:1 Not tainted 6.15.0-rc7-next-20250523-06662-gdb11f7daf2b1-dirty #300 PREEMPT
[   31.578659] Hardware name: NXP i.MX93 11X11 EVK board (DT)
[   31.584129] Workqueue: events_power_efficient phy_state_machine
[   31.590048] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   31.596998] pc : _phy_state_machine+0x120/0x310
[   31.601513] lr : _phy_state_machine+0xc8/0x310
[   31.605942] sp : ffff8000827ebd20
[   31.609244] x29: ffff8000827ebd30 x28: 0000000000000000 x27: 0000000000000000
[   31.616368] x26: ffff000004014028 x25: ffff000004c24b80 x24: ffff000004013a05
[   31.623492] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
[   31.630616] x20: ffff00000881fea0 x19: ffff000008515000 x18: 0000000000000006
[   31.637740] x17: 3a76726420303030 x16: 35313538303a7665 x15: 647968702030303a
[   31.644864] x14: ffff000004ea9200 x13: 3030303030303030 x12: ffff800082057068
[   31.651988] x11: 0000000000000058 x10: 000001067f7cd7af x9 : ffff000004ea9200
[   31.659112] x8 : 000000000004341b x7 : ffff000004ea9200 x6 : 00000000000002d6
[   31.666236] x5 : ffff00007fb99308 x4 : 0000000000000000 x3 : 0000000000000000
[   31.673360] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[   31.680485] Call trace:
[   31.682920]  _phy_state_machine+0x120/0x310 (P)
[   31.687444]  phy_state_machine+0x2c/0x80
[   31.691360]  process_one_work+0x148/0x290
[   31.695364]  worker_thread+0x2c8/0x3e4
[   31.699108]  kthread+0x12c/0x204
[   31.702333]  ret_from_fork+0x10/0x20
[   31.705906] Code: f941be60 b9442261 71001c3f 54000d00 (f940dc02)

Fixes: f2bc1c265572 ("net: phy: introduce optional polling interface for PHY statistics")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 include/linux/phy.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4c2b8b6e7187..068071646a8b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1632,12 +1632,14 @@ static inline bool phy_interrupt_is_valid(struct phy_device *phydev)
  */
 static inline bool phy_polling_mode(struct phy_device *phydev)
 {
-	if (phydev->state == PHY_CABLETEST)
-		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
-			return true;
+	if (phydev->drv) {
+		if (phydev->state == PHY_CABLETEST)
+			if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
+				return true;
 
-	if (phydev->drv->update_stats)
-		return true;
+		if (phydev->drv->update_stats)
+			return true;
+	}
 
 	return phydev->irq == PHY_POLL;
 }
-- 
2.34.1


