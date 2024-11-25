Return-Path: <netdev+bounces-147188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90B9D8225
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D409F163315
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F919066D;
	Mon, 25 Nov 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQwWdwg1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F78191F9C;
	Mon, 25 Nov 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526615; cv=fail; b=RiV1spNonD5L1R8BIo1MsAfp8adELH/tJRvJw97h7VREZuUTmgaXldHW1WF6+HnfD0LiCjK68lvhP/lL5LBexpDYd4wcpBLb7x0hvemkuOHkgTvKWkl0A2kgFnQDP9RFydjsDUklkfmhJeV377D2b1Mf1h8rm84rbdz6VV6ZCXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526615; c=relaxed/simple;
	bh=Xido9d/rfQqCPZ4ilYIa0q7WL8tg6FLXpdrmPTgu75w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UqkmBYeRXDVrGl3VWavF6MiGDmWxD42HM8SuUIElytCDJ4p0Mwhtgcv3o72KGRz4stDiUOWOGT+f2wzQkYF26fuyded2HY23rloWoT0BZ1xVvKM6iSmhEoHxvqxEAL2TiAfEs+SZNNf3bQLouIK7bel46SXmYiBMWo/y2XTJ8zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQwWdwg1; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBOgCqEkOQ1NGmhObxMY9ECS9IVAY1pzHelTq83WXQFLZ8SCM4KVHltbyCo4oMY3DNckkYULc7/BfzCDI6G0g73Lujh5sJbycH43mTNgtLIiPhLFDqBWiUREYhV7QzijtH/QzLjxAVfv7trDihf6xSrVucfo5aXiedqoU3npG6GA4vebKizJmBWt0oHwWhNagkiPL7RaG4k5kJ1SEPDTStvbHjz7OlBbuvu4dkr52nKNKUcmXBrmHd073GaoITaRzjhpQKMHG/VfNT+6tPkK20DqGXz6ELdTbcVEwbfJoN7jMbFsRSSXXcWgUf8T+hwznq+ZOecXbAOjNbY8onKHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MPxxxCutL++lnq4/rKOPtsMN9A0H7NzOV7jT3Ylboo=;
 b=V0kDjO8mhnY+nwZ/yi/oYlxY6cRCwy1PfUT1p2XQREX/sax/NqvhcSLDPu8VBWmpqJ2mcVC3t4exmpHcrpyIPzMPaHlI6Q1zKGNx8K/IeiJi9ziHM5Q+Pf8Ap/ITawiEDRPshOsuS6kBQAiIMHucl2v7nAh8PiAINkCTuE1sRBlSkt6LKD35LmmLgkp20VRztY1My3xTBrhbnQf+Go7Dc1n5rSsUTpZL9zUxSfmOZ5kTUavPwYG2pmOtHjlZF3Rjb7Z7s+PvdPOqZWlaW9EOrSX87fSdxcpBA48EpYl43zEniUw48A1oH5aQeNWKLaPTkX5Ra1szuA0GAoBDkq9I9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MPxxxCutL++lnq4/rKOPtsMN9A0H7NzOV7jT3Ylboo=;
 b=XQwWdwg1En7+vnAEWjRnfphTEM6RC7YMtfXVHEI7OB+TfHfnEZJ0FWxjvtM8FXuvEPrGKKHHxpyBeQgEODU0IVJYeRbvWFNIdcmmTL1/7OUgFfPxIlWmYjsZXGrXYinpE2K9ttyMQJWM+NbdMG2zglSvNDUnD5KUtcW6ULPPIaMTwoS0aRre2pglYYmkny4USssPnFs6LdKbmnY+mSg/UIsRkV4phQ3Qzx4iCYILizeENl7PKNXpj/WagPvPe4cZwXqX+Z2pdCQFwDzxhugtvx+vcS6a55YKTCOzSMNpEZ/BXCkdhqinyh9ITohjUNE/aG0mQi1/mcYL4BcgqmxVTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 09:23:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:23:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net 2/2] net: enetc: Do not configure preemptible TCs if SIs do not support
Date: Mon, 25 Nov 2024 17:07:19 +0800
Message-Id: <20241125090719.2159124-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125090719.2159124-1-wei.fang@nxp.com>
References: <20241125090719.2159124-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: e668336b-8a1b-42d3-a648-08dd0d32d215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESvMhiRIBBc1UckuXB441MwjLlNazXzfKcV0kPj3bRQ62wUJ9TQ4WtTTrVQ9?=
 =?us-ascii?Q?dh42rivJom2zedmNHQtpk8sUm4uRFNewqQN16HuHgcrrb6EnrXCx0rm1byCL?=
 =?us-ascii?Q?sNJl9PehftNC7e/lIHSDKjazQSF9U+d1dpg48hILt4cp8D62oaWCZXEOmVSe?=
 =?us-ascii?Q?N0YogeR3mpZwxsJ/Pmfd9/YwvNM3YZWCq73vGG18ZQTuC2uecSgNiJherBfk?=
 =?us-ascii?Q?39m0m3tqNEoVNO8dnF0kCW5phFt4FHu9DSDy/69MasHSRQeVTYgQ27ckYGU9?=
 =?us-ascii?Q?PG5hEscU+VFKtnDi2cX16+yVWAF8X1rPoyGzYns0M3zrwoMqiBImpdKOFlGZ?=
 =?us-ascii?Q?ta5nF0I91AinJE99R/DSNAtgBz68mIZQjgASQ1saL99HSjwLrgBsN7shryA3?=
 =?us-ascii?Q?5U5bOLZo6OyOZLoYIPF3OWfkX4LH7qC3rTaL4/OLoxELmu9tRUywKmx4Mes6?=
 =?us-ascii?Q?sztGl8BLiYOcBaoOklRiEmKS/YiFbStCTVdS0AlEb8HWElfDEDUR6K6ZPqIv?=
 =?us-ascii?Q?gyLbhlnUo5/LAuem0AMENxH1p2c3PyAkP9yd+2F1rIjQulfMgLGGNcd9XP0O?=
 =?us-ascii?Q?xn7/YYadLmT4fVHpAPb9squ4d/aEebQo/eC761rAGxhm5gH1fcvINmFTQa0D?=
 =?us-ascii?Q?IrLj03tW0cKR5oQn2n93XTOchXRm7jlYMWRvbger/jBiUmtmYYd2pLI6ZR1W?=
 =?us-ascii?Q?6MCHSonfi90rdKYAC/dBT61oaCuC4jL2obIElW6acv60bkk2TWS4FEqFGv8B?=
 =?us-ascii?Q?bc2zKdvZ/ScyW1yUp4CLzTPXD8Frd3dbb8bc5ryjH41LsVP72fyL/peeePuj?=
 =?us-ascii?Q?j5Okbb1hf5pWEMlxGKhjtnwsY14kVVqQMbZeXPsPfoYj3Bdb4TVG/E1kDPcE?=
 =?us-ascii?Q?IA4i/PXiND+1VnWLp2cHuwDQ16NaTxkp8RDjb3+Ef+8GEcyfdajrMaz6DQBf?=
 =?us-ascii?Q?By/n0X/Z4+qHUcpHIQc0MIRvltsYqy/sVPL5RxQXlW3Sy0HOVp9s39b1/MfG?=
 =?us-ascii?Q?GYa9iwuYpuIgfNWmvKz5GAlDzXiCjKlHNod+xJ+oLYdV8pP+2oJa4kBXzLdj?=
 =?us-ascii?Q?+JkpiYQj8NmvobKKJB3NRUE3kI8LoOqXYVjCf+2uXmKRS5MvRKIFBHDjmtMs?=
 =?us-ascii?Q?QeIAo4CJ/b1dMOwO2a+5zeM1p0K4UULldHPZIshD1Aw2anKqKrsrmwWWbMCf?=
 =?us-ascii?Q?Pj2CJHhBxHryl2OV3D7sIhDAz33YiAjQ619TlDQfZcFA4AdCfnFJ3SVVKuxT?=
 =?us-ascii?Q?jaID4jqvWvXWkAAfjJjdUgCQfN3QKbVDle9EgxJCoeii4aiRs8XThrcX5bXB?=
 =?us-ascii?Q?jjgJLGDiYoeglCcZ0SqSvxRybhGLA+Ff0v+IB4JbRRK6SKwS5mTGfKTqaf/F?=
 =?us-ascii?Q?Ur20oOtv1hg2gL7K2tFxxewlp6LbgoTFDviEk/fNfaoTvy2UBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtbQhZ1GptU59VLpq9MtYH4tNxFbu5ZsAvB0DkunxIxr7qmdAP9rXCim8Qj4?=
 =?us-ascii?Q?t0/Jrbqd+8bNSg0O7Xvrh/zHAO80m3Ozt2TxeGbkxoMOqa+AJIYbO9HSF9bt?=
 =?us-ascii?Q?u8hxWABhbMy+xXrRzIWEm4wVjmff9SGzHBt3X1mgVywaeAi9AQQFZFs9sHIK?=
 =?us-ascii?Q?MYnD77ArG6yaJk/RFPCR/kGqmnZ3UieySPN++Mhyup+exbk/rmjHh0d+ZswV?=
 =?us-ascii?Q?CUxQz8ZQqPjHuiCfYmxm6GcjscMNyqEW09pp5tQWGa+57P4bLuFwNbH526b/?=
 =?us-ascii?Q?VOd1fk4UQkZQGXZbCj2PmCP4CO2K3UlzFjSe3rFF8ezDkN+BUV95nCUyskL+?=
 =?us-ascii?Q?jRskoW3/btFgxqOQmrgs27I/hn9cC9u73MGSj8XFI4ZHnMqArCVhJC0ifm1s?=
 =?us-ascii?Q?56amMAggil5QKI1yyFlNZ9pJSAuH/3PD9xoBay2s6ql9/O4q/Lrg/GHfgM/c?=
 =?us-ascii?Q?JKqEki70FANJTlyQDPXv4P6aA2cr5eYvbke6q/cRMAumeN0tDqzrMqXAPJkj?=
 =?us-ascii?Q?FqMa/NLIXYdyxD1HJuvhb8uTTOjpivcNerHtLxJzKeTEeadCTy1A5oG76FeR?=
 =?us-ascii?Q?mmrH1GR0hOz4oTDdYzPd+iRbbh0BqUU3tZF+4KPaZVIVCYZO9mHw8/ECb5+g?=
 =?us-ascii?Q?Ezfwp4B+gHUcX5yk1sBSR22Y+SlM+oHEIXelsjTlZMosYfATV9swNplLCgvK?=
 =?us-ascii?Q?WobDWU5p7ivViCpmCXKvXo93oqysmLZoNmm8AYiLzeHQRyT25DcUjaSJ5XCw?=
 =?us-ascii?Q?a9oGM2sXMrfQyGdyVBh47kAUYjf7/u8HN6BxgRTkOhCI+ofGp6wC24w3eGPj?=
 =?us-ascii?Q?/iBjS3fPDZUFQs9dZw92qJMP1lgrb4Sxm//1ew4GFD2MXn4ZPvlm/RiFf4na?=
 =?us-ascii?Q?8fq9aCEoquzoNPUCg+F7rAtx1BG7UwVgONZDWK4h8cFKZwlWpViSnocUt/hc?=
 =?us-ascii?Q?kjhRyHYPkqkKMkTw2ByyDdsZFO68EHEkAN8h5NsBrns/FFWa8A47sw42AMV2?=
 =?us-ascii?Q?UtAIyeBVf8kSonCHO+p0KVF+ZxZYXVx4M3AWTSI7XSKzMUl6B7489qU72yC+?=
 =?us-ascii?Q?e5Fz4sTVcIGZNcnULbXTZAmzwaeH5+i0ECHKeC5siZYO8ESV4gcAsu9pmE+X?=
 =?us-ascii?Q?YRsSrg/+q8Z622C0G/K+pXKGDxt6mBkdCeB0T/Z7mShrgFTGVDPBRKrPB/sp?=
 =?us-ascii?Q?SEBNarMZnDre2seEOJ7RLhiIStvey0ofwozPBSDx/KyiWQF6nXvca2q0sPiH?=
 =?us-ascii?Q?kK8j59MHW9Zy4o52DSdLhHsNukjR+ljcyY13yMSa+z955XT/2oAoYO5nBM/G?=
 =?us-ascii?Q?MMZY20+BWV+htCUzlR9of0vLY4vqeKqHQpgr27CkL48HTFunlldWQZNp53eD?=
 =?us-ascii?Q?uP4eVSh9d3fTPkAV+y19N3EaUmxF2dKupw/NxlXY3wh+Gph57D146AGlz6Vs?=
 =?us-ascii?Q?rP6psnNl74adrREeSlshr9X2HJizINacrZRshYEBdVgy+oVGPw9+pyIazLRB?=
 =?us-ascii?Q?h43VdH/VzGkjfKWK1Zeav2keReHiEW1Qi8WX7K7+T4oVA+B75l9STtiEALKk?=
 =?us-ascii?Q?euW94bOwKl3F+6PE5Zvt2Lr8oWaxE107tndYy9/1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e668336b-8a1b-42d3-a648-08dd0d32d215
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:23:28.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIkalf4wqDEFDPdZZZR/Uz20mxm198czKqvVhBHwoGPNLXivGu91T9KicLSCsUkXKTGI7B1f8OcHWhfk0hz34A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
to configure preemptible TCs. However, only PF is able to configure
preemptible TCs. Because only PF has related registers, while VF does not
have these registers. So for VF, its hw->port pointer is NULL. Therefore,
VF will access an invalid pointer when accessing a non-existent register,
which will cause a crash issue. The simplified log is as follows.

root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
[  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
[  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
[  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
[  187.511140] Call trace:
[  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
[  187.518918]  enetc_setup_tc_mqprio+0x180/0x214
[  187.523374]  enetc_vf_setup_tc+0x1c/0x30
[  187.527306]  mqprio_enable_offload+0x144/0x178
[  187.531766]  mqprio_init+0x3ec/0x668
[  187.535351]  qdisc_create+0x15c/0x488
[  187.539023]  tc_modify_qdisc+0x398/0x73c
[  187.542958]  rtnetlink_rcv_msg+0x128/0x378
[  187.547064]  netlink_rcv_skb+0x60/0x130
[  187.550910]  rtnetlink_rcv+0x18/0x24
[  187.554492]  netlink_unicast+0x300/0x36c
[  187.558425]  netlink_sendmsg+0x1a8/0x420
[  187.606759] ---[ end trace 0000000000000000 ]---

In addition, some PFs also do not support configuring preemptible TCs,
such as eno1 and eno3 on LS1028A. It won't crash like it does for VFs,
but we should prevent these PFs from accessing these unimplemented
registers.

Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2 changes:
1. Change the title and refine the commit message
2. Only set ENETC_SI_F_QBU bit for PFs which support Qbu
3. Prevent all SIs which not support Qbu from configuring preemptible
TCs
v3 changes:
1. remove the changes in enetc_get_si_caps().
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bece220535a1..535969fa0fdb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -29,6 +29,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
 static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
 					 u8 preemptible_tcs)
 {
+	if (!(priv->si->hw_features & ENETC_SI_F_QBU))
+		return;
+
 	priv->preemptible_tcs = preemptible_tcs;
 	enetc_mm_commit_preemptible_tcs(priv);
 }
-- 
2.34.1


