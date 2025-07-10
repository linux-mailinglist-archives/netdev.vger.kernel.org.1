Return-Path: <netdev+bounces-205719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE64AFFD88
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DBE5A44D6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7816F28FAB7;
	Thu, 10 Jul 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nvYrl4HQ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9761328CF77;
	Thu, 10 Jul 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138392; cv=fail; b=Tma7UoKmIpKQpYe4dD8NP9LpxdI5sc9/m4KazeppXOFfWSm1Rp1bcjQgWxV1nFWmsf2vGQEUI7b+Cn/FUgZ/koFzN+aukv8CMCrjtm3ZhEGeAX0PAeKolse2Iuc1qRDBGkfzVvfCuTSYiItZdeXC6gmaeeq21iGsDs/upstRxxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138392; c=relaxed/simple;
	bh=/Aw/PHqD9tu/fmEVV6QszjC2GyWzmSzFh+NVDnU0XKs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KX26Znos22EPP+0I0BRQWDqAwhvSAzfhDCUIF40sR4OGR8eZDrStyflFc9qUEQDZXIfnt5gGQuLHGz4KGyoEoDewlg4TnsJk7X3yS7OJqUsegfg+Jdj0xLA8Z/6AoAzKaMxTRh9s0ss+uS0H1xO8fQu++TURPQXlZWWBO/NlDl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nvYrl4HQ; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRL9sYnFSp6wuv7nURNWq29Te3Doq1WcnCzN141a5jb1LHhaQlS1dJhN5X2kG3n8fHN6+ZwOVs8dw9siuewo6q3rvRbwKmKEvYX17QwxKxqijZ4xYRb5K9a43FVZZeQaTc1J2AaINanZrlfr5+zq+5sgj9FHAv+UU8dCwYEiaDhs6tXgJ31H1fFQxjqO6nOb6brYsxVsvFP57izWHGs7SwIs42hf6y5LOXECRoH2Y3pMWg24ZVxOM1ntWaA7dZE3ZNY/ym2PmWqfFkxA5axI5yRE2diOh+7UX2N6IIvOoadwZZo54TUUyk7kNiWHIL0pMoT1nIDh2FeyXeaC7AAO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qws2xTHjY08XebTp3ivmMedALmi2k4ywRd6hyYGFzwA=;
 b=iDnQL4ySKMD5240ChqhaknJd7uK2rDsS09+YWldmQNgfuIqkTqbR1M/KtyjopTV3m+9+gvfcEwYITdHQRuaeEhttl/5wsnLB/i+/ckQ1HYqo2Q8d8fnpv5xD2rUhlObkyYC11zLPd7VoSJT7AvOFDtlCGDGS19QkSeqknvzLOzPYYDIKi9px7gfw/ZWcVT3Lb9UQKEeH+aLA6bCCYF1jvPODDOhdT5abVmxq1fzYL9EmCo0ybeFnTPB0hxh5oQ2ExIH2d7mAJ5KVO+0wBCi+ULaw/TiXrSmfAtm76sczaqgE3Wos/cV1LOdTGpCICZh4c38tuQ+cowfPCaZwzCOUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qws2xTHjY08XebTp3ivmMedALmi2k4ywRd6hyYGFzwA=;
 b=nvYrl4HQIfl96V07kfp0WVLtaXOJp14xw9JAEP+ekkyXBIHeGHePle3kGHaT6E+HqoDAVn89Kyil6Lzc3pu4OBy3v4fPkTuBAqU82hAeSNwllNYEs0MmROQ08HyVb82QV1K7lZWv4vLd0Ik/xEiMOBI8CfxbZitoSjL7wWW+Gl4dq0/IQf5hHO2TVX+Ock7VbgGryCtdBHoXrxJudZO5FshFZZ7HHmySjmBVcYqz/CnYjEEwluFFQLXUDwh+6J+eirXWx6K0QuQ+1HOEQ7NF+eohnQg5qtrWND34YrIJYE+HxzQNw8++0gklccPwkg/Eo8/H2xKyX8mDRgFflLuuBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 10 Jul
 2025 09:06:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 09:06:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 0/3] net: fec: add some optimizations
Date: Thu, 10 Jul 2025 17:08:59 +0800
Message-Id: <20250710090902.1171180-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 117d5178-3e4c-4326-dbc3-08ddbf910d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|19092799006|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7Il1dGK/Q1ZLqbIgO/wQ6OgkLSbFWsrFmkFqb68F+br/v9aRD6gu+xQocD3?=
 =?us-ascii?Q?fNhRFYwKYhqJXn+0o7wzVhraF+9oLXo3OrsQib/TKIm8xJA3fnFJHbpprhp3?=
 =?us-ascii?Q?XrJWKEglZnIkamn/NrdyoJKj5WXtCeCIjSjikJDgOUvzI7luFILDnP75mqES?=
 =?us-ascii?Q?Q1FQnORCQzfh38UaW3/kKeQyxyQNiaKR/ecXS5RwRkdC00Ery7vcE75tjzOw?=
 =?us-ascii?Q?TY5bD/FjFGAJ9xKX3CJqqkA6GTlVXBxs0ui3CkOifJEpWKn6pXLALP0Kv60Z?=
 =?us-ascii?Q?DCEOAjlcp9YQDjiEhp8+daiJjCbJJiheHEoDjF29qCOS+utb299t/PRkxtVG?=
 =?us-ascii?Q?oFqb4s9CDaO8wkXI6MjK6uoRrX8YXDjJmyPuwkJODai2qgPDQaCBbtxIyshx?=
 =?us-ascii?Q?EJdk5eCZnvtAKucdKEiegmUGTr0m9HJxYvIRZAcIecci8u5W9PU1mACkfpQF?=
 =?us-ascii?Q?TMEFHaXAzNpaU1YzMFgeEjxxEAZRqve5yF8exF+NIivJf7NnVMpOiP5YwSj3?=
 =?us-ascii?Q?sHqHvr/sPLPZgIz3YqT4Prr6XEeJBV7lzxOTSbZiSoIh4x6qxeNLXCn5tXYi?=
 =?us-ascii?Q?XXtxdEjn9+hY60leM3kN4qK+SizhAWqDTmFDak2fNpuOpEhK/9zfe7WodJ+o?=
 =?us-ascii?Q?fc6RK6fS++xTssN3/oP1EoICgqc+mBYkAWcsTFbZHeUELsQcKwLta70BhKzi?=
 =?us-ascii?Q?MQXn5SuLhN5tchctaoniXFidfKXhzdxYUGER0x4OxkbMDzqagsj0X5pZoRgb?=
 =?us-ascii?Q?9U1gjSWdmgQ1bTrnOXLyXkhJ0/ZteY8uziqjHk3bhrQcvezQ9U7C2mJwD8hV?=
 =?us-ascii?Q?Biti+h7nLRO1oAQZd0GSlaIcqtKOI7SVAXpi9CnUy1LucIMUD1ZeEk3cIdu4?=
 =?us-ascii?Q?uFdMaEHA34NXKAYEZlNBYgt/2n1HmYMGQx4DCG/yvo2pvj0Af2bQ9WOThKbF?=
 =?us-ascii?Q?RjDbCrs2xpuQqdzkriPSZ4Vz89a64yn3o64XyXr3XHPx/bhfwpZeS0SQVlxt?=
 =?us-ascii?Q?tDiDYjIqg6RO+DM13OuTvX2xQ45JJ0XpHyYOD3JlSePdQFF7HlfH//lsRhD/?=
 =?us-ascii?Q?KKwY7mrZBYAI+ukNYVKxGZV/5XAeLhmGk8wHhzh+Z6046y0il6IcCaacQeDN?=
 =?us-ascii?Q?bTFnZc20M2qA2ZBAxImPx/OTS/bKU7dOjxDYfHucOFZRDluOvgBw/YD59YtC?=
 =?us-ascii?Q?H4J7x2EhR3rm8k5cmNgbiSG4+I0l9gSln4LyPuy4Wzklfe9iT+vmwRu/Bc85?=
 =?us-ascii?Q?A1yO/BRH4T2lUDO695S3G4K2B/troFFOpXO58EBlvWJnjpOe8bhvlAIfEv19?=
 =?us-ascii?Q?7qsS0g4dyYxTzlb/bvgicc4Gz76CXDvLJ/WoEgP97QKyxAQvKtHjlYsL9Cg4?=
 =?us-ascii?Q?A/ESEq4TUm4KEujx7dFYMObFr5KfOASnOgeRB1YFiATqiqdbK0i8Ss620NX3?=
 =?us-ascii?Q?H1lQMEbSX4XwvlyYsj+2anT1OWuf+PyxFnKH+O/oObDMcRE7IEyd4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(19092799006)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TK2V4JsE54xkQj2KwfUT01btZUz0cQ0TZ2iXO8PGLixLhjyb9tOvI3CFATp0?=
 =?us-ascii?Q?YFOWSB95P8QDi0CXHXMOfV74FHPEjmphxySgGmP4mWAzw/IpnMNSiSjO5bI7?=
 =?us-ascii?Q?Phck3LtIuF6wjo1WVMe02tVIt62hFbZzYVO6rVxgHJFkB4E64i2kWdXvFZui?=
 =?us-ascii?Q?t57w+bpWtFPuyuEJnp2hHvpLgqIkpjzDWO4XjAzEOS1i2mLISKdBzxOfrVKr?=
 =?us-ascii?Q?r+bkjE28b4GPa0HgzYCMM6Xa8aPupURL4uiJ9NeRnf8W9Rh3d3hOBjMLOKDO?=
 =?us-ascii?Q?/o9VPATJHPDs2zI7+Q+yqeT9ROOBa3aEFNfHKxopUq7k/fSGyl1dnk16SDCG?=
 =?us-ascii?Q?cY5vpV6JuuKNi7R3/fqUESEN39Bst24PcE5ju22fClryxKzLdNhCb8OyWyLu?=
 =?us-ascii?Q?bNZ8EceDW3wSpFrKh7R39hdsVEfrqexaxpV3ms2kG9LvUsOi9e5bJSdPHzNq?=
 =?us-ascii?Q?YuQgjMw6j8bMN1JCFMgk8V0Xnxp9Kb/KCL1/JlzQQe3d7WQ9cJ2jFVzBAMlr?=
 =?us-ascii?Q?J1v+LAtcKy8eJxpjgAICu2qYn6swKQQ1xZrW6fOyGqIU/aXTankstZjydoAg?=
 =?us-ascii?Q?cgX58PZh4rxAZRH0YsxkdkgrMhPdIOVUfPORh+xhcHIvd6u7O3WpQgJamVrK?=
 =?us-ascii?Q?eK+eblUnT3sZtD8qVjwO+/Fzjp7u+b6trmOeCKRQrkfhc2W7yitngjEDu/39?=
 =?us-ascii?Q?QIz5qy5LfcVTxZPHJ0m650cmrvOLUfTN/eXA5RO4Wi/H2eHpfwR9uYEz9Ehc?=
 =?us-ascii?Q?rkcvc8na0XT5w5IY3jBKs2r6Sl5ZJHtSTi+1FCUnCQYB0UsJG5V3uMQLsiO7?=
 =?us-ascii?Q?sSKbQn5dVjrHL8MesmA4QK1Bzay54Z8pKU4VK8VJXKP6gRYQPbDknQB/uVEJ?=
 =?us-ascii?Q?jSqQwJM67L1rQm4obfEnTFOt8hvxMslb8MBrpwqtozqmmVlXde/Y1097Di6n?=
 =?us-ascii?Q?2Yzl11gyWjS7TEYhc9qmmafbI+FPhhO7fUghe9d+tQGUkZYYdwzDYpx4oCnC?=
 =?us-ascii?Q?xLFFoBNd6HphxAHdPUd4Q3iuZ9OQySCF/q8uSK+QhyipwMNfn8zsou8Kix+8?=
 =?us-ascii?Q?u1P059dxoCXmyPW+jKqgpwQrhxQ3vCf2u0qCEV0NbMdNMCHgt/WIUqWwfDU4?=
 =?us-ascii?Q?CS6w/s+IWmeeexZzxrG1IsB2toN8H4t+HUaiMqL9xYUfIbDFTJpe0He3to72?=
 =?us-ascii?Q?7NF0rWSNgfp+UBF55V/f7rK6AG4YLz+BSgJfjXYDKQB83eoyqmZl3zA+apWd?=
 =?us-ascii?Q?9vkX7v3DpZ7J8xsDEpi0q/TW3t+13gV3C1NvhiF4oOACFr7F8i+iSbtFMcln?=
 =?us-ascii?Q?qnLRWrH3l5l3Hkcd9auJuhPfz2xwHcem8xD75q3fGiyuQeWULZYzBwYNE4e1?=
 =?us-ascii?Q?DLpuLc6U1wx0PmiuHOMlCrz0g7AyFKtbyGAWPilbL9v2k7b7ZCC5rUE8ONUn?=
 =?us-ascii?Q?9/LPGHtNmrHpYYkhq2+Os/RjRgIM3uMuUTlgYjVrqnPWdCOp6FZ06MJh6S/R?=
 =?us-ascii?Q?mOJHwrC2ES86C0LlgSXudVcLLhsRAupKpT+SA0HuBWnMNfA09V39Nerdm/ao?=
 =?us-ascii?Q?hUHWyfXtbvnndZXFGEyeb2VFPHrYhDp6hTRD1eYb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117d5178-3e4c-4326-dbc3-08ddbf910d1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 09:06:27.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4g4f0c2F32Y8XYXSPR9tswlWXhmu95OJHXqY3+Noh+3D7DcBngZYmiyTVtdCGHj/M6egSNmsl/GknDtYcI5cCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Add some optimizations to the fec driver, see each patch for details.

Wei Fang (3):
  net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
  net: fec: add more macros for bits of FEC_ECR
  net: fec: add fec_set_hw_mac_addr() helper function

 drivers/net/ethernet/freescale/fec_main.c | 44 ++++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.34.1


