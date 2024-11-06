Return-Path: <netdev+bounces-142424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2309BF0A8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469C7B20E12
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD671DFE3A;
	Wed,  6 Nov 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kJ8mbFtS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA91185B54;
	Wed,  6 Nov 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904596; cv=fail; b=NthvzJ7827GgQ8j17+WNdo4PDAFE/on0NtOGVzr0SY5lHtVh6fxLXMzwrv/WnEXh88KPobEjeiz0II0gX4O2ZUd2vLL+TASbz4uHpz0mQtE75epjSR9YmPKz2L+WYIpwOMJlTECiySCcsPVRokBvoqdjOwZIaE3AiuO1l+sfvpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904596; c=relaxed/simple;
	bh=Kyrwxe4FZk/gKGAJ1FOBxcBJ28G2r81j3/DC6jSbqQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEn8VbVfDPRo+rpOXfnN8GdNBCctPutQhqVxEZFPWI2OVytdKToR5GzPesX0shKQ5AP60CaQl6bxztG+66MnBx8kf1qVGmE5arkiVpKN1/XA9oWFY6TtLA+nuTUS+J7830t5SUimcdVH7gRCYOX8uhjbgtooDtvgRdLHiQKpFjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kJ8mbFtS; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkUKZvGqrZrRqdTDItrgIJutZisJLGryi07DPR9wdnj48YJDrEFpULmwsbRrQDi7U0tUPoLGRfAd8dSQoCnPJwxd98i1GDtP+JxeVVQmA4e7MCA3S2VQEPCst3VIhY9aJQ95bgf0pTIYwhNtmX3ZCDFFFUs5GXnk1SDwxfNgtnhbsCEbj/RlNap5MwaaHpVsVuEbgta80kw/BdHk5SUbcErbHjJGylIJeqfHrOGQYqAylvsPUlYSdRRH7LRzhuNMMCODhqbxkAmvICh39uQ3X2JtwF0dcGrKojI6uVcSPDIq4MBlOWaeMvcmjfn5GMVsWqQP7iJZDPZZ1+5wjk0ATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkpZNwDBbzJPBzml78MV67BkshB9aDdjGe4bWmBQnLg=;
 b=HVWc+DtdiOeJEc0Zi0cplsyDKKRkzCiwiKre0FXxvWtWlHhytEQq1eWW6DnIR7YSVqYcctOuc94N7WGnYL0n0jttQiCT72k98wpbMsZYGJhqpAccEEIsJemBog/VV8JDCYXh9SnWRLAxmuZoxAM82o3fDwcrhHqGownRBMVJmMHq1LBFlqH1NYYbFT7hEvFBg5yH41hm6cwBR5V4fMYqIcb/eAa+mxWqzUw/9TZlEqXxdV1X3R/CVub+Y7Irdq6Nsrh5DtKixS2SnnhHlJmZ+lqB5/OhHTAwsVEJJlKB6lr+aIMbGkm893LO1hBXv3kln8KkiLb3ujICheGOkra9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkpZNwDBbzJPBzml78MV67BkshB9aDdjGe4bWmBQnLg=;
 b=kJ8mbFtSp+8JP7MunXzoOKLHD8hZhjSShPJ/vWmUtlbOURt2NExflRP0uf0uRMnR9zDitNVqMHGFcgMJIpCrj17NDxkcKk8TJM1AB/3CaoH0CZLuJ0wfL3C9KR8Vbf9hH2zQxSIRQDE768x07UAyM1YC/h3sLyL/eu7ECG+2FD0J/0njRg7Jbd84M6nPMTErJSXOaDzwe+rgyvNwPgx7eHnkzmzBREU9IHcEwh1mmCx93P9MgNBPEYIh2quvXtu5S9mmY8oaEzGwkroD/DUXO7y0V4kjE+6vvXU0AIOFH9LUwh3AEoM7RAZStzNoAa8nnMEVQICy1jhv7WeNgPO3xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10086.eurprd04.prod.outlook.com (2603:10a6:102:40d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 14:49:50 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 14:49:50 +0000
Date: Wed, 6 Nov 2024 16:49:46 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net] net: enetc: Do not configure preemptible TCs if
 SIs do not support
Message-ID: <20241106143954.3avqol5m7j6i7hrt@skbuf>
References: <20241104054309.1388433-1-wei.fang@nxp.com>
Content-Type: multipart/mixed; boundary="y5h5puwhv7qfzquk"
Content-Disposition: inline
In-Reply-To: <20241104054309.1388433-1-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10086:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaa0a3f-b9cc-4e8a-7294-08dcfe7243e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCEDPkhL+Kx7oi0w1emypYiXBGPROGOdibnzdDD9C2FgIkGjEQ8OIs2om8wM?=
 =?us-ascii?Q?WRXfPv1874sbaiCfeuqCW5UAGEKs+M4CtaTGECQRpA3Ecbang2N1jXQSQAFm?=
 =?us-ascii?Q?q7Hxg5IGuKFub0tkw0hiu+NtNxqzQiHgs/x4Yh7EBSOrcfDn7migxZlw0U0r?=
 =?us-ascii?Q?s6G/wbOVDeNeckHjSLsZ91wuSgMes66JV1hoLSeKxikmd6ew7/7k8hILTHsV?=
 =?us-ascii?Q?s0fIfjSiPW8yBb3GgiHwKPYt5OR56FSf+4k/gU4+JMJy8nZeovb7wZrUtptJ?=
 =?us-ascii?Q?eIeQTy0F28vMpPGAYRKsSScyDgHglLoevJc8fsibJilBNShAtd02j/MBQmWt?=
 =?us-ascii?Q?FUr4yL9schTYqiDA6VW37XGKW83vuOgFIGlJWsG/BTu/1/Yz/BDzj3uFvFUg?=
 =?us-ascii?Q?UMMgWZIAPhHgYFCak1WtOW81jWk8+pwwcy+2YPA9P2/mTf3NbQDhf6j1+OvW?=
 =?us-ascii?Q?rhQcuubfanc5h84NSv8F/FoLvXjZY9a3uOjnhcpLj1yweu0qbRbwqkmEvLoh?=
 =?us-ascii?Q?sbmdd3MTwSPdsWcoY+K/ThIn3TJOoKgPQ6n0Xfgq9ep4J4CCmhjZcu2qKQ58?=
 =?us-ascii?Q?hfgCWTE08BMYKpc+zI5WYJtGLI9W8V6vbgCLn1mFe6NzdqUKHsKVuqSpYh2B?=
 =?us-ascii?Q?DHeDqbVySDlsi6n8U+AmOs9l9JyBT5dgsLUo6W/jC0at9X+ZwkTHspIdtwlf?=
 =?us-ascii?Q?y3oT48wHsl9mTfry67ULdhh4geb23cYFKxC87VZcOY9LG/9yAm4zhBzRQEfk?=
 =?us-ascii?Q?mu1qKm2qoajpukmJJR5s9DfU7Mue1EAh4jxvF4VKkF4O43j+jUaR+Le8Qg7V?=
 =?us-ascii?Q?kU96M4Nhg7K3N7b9Wk3YpQD+vEOFb6ZxHQhJGLguz2iuwLzJX63ZVkGi3k4B?=
 =?us-ascii?Q?rBbAlfKs2hluonp+bbkWAZbcMiXS6Ab/y5t1XVDb2fJskVeWu3qLs7A5zzHu?=
 =?us-ascii?Q?QOMfMTqUOTMh7OkharEi8iEARyjYz19U2gCGKyoZrqbPXC60jnM0YGRj5IBV?=
 =?us-ascii?Q?c5kjk3Up5Suy4D4kU/gppgzlJx2oY+OskxOsx1AYKogDgsRRQTVWi3NBctlE?=
 =?us-ascii?Q?/Z3nBToZ8I689NAPk2qLnDDO3ytunNIFq3GSBqdDIl5dZ8UkkSNPcxzGQpDE?=
 =?us-ascii?Q?+VK2s98er8/57Eno/+zD1Ov4zaMS2CkddqW5y3ve9C1PAEEtN1H9V+2+NyjO?=
 =?us-ascii?Q?5tvkOA+9SeU3GmEO2wb8TyjgLTCMJyoLK5s5rIlXgk7M0eD4HeNAU4xWl7L2?=
 =?us-ascii?Q?/3+g5Q8mino7gp2NXgRGSNhzSLa7i+9upY/5vAzzqGhFT21B+UzUI0LFsNta?=
 =?us-ascii?Q?E8wWTdMAvoHyXXicR2zk3n8X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ig+5f1lgOQeWQK+6H3itWS1XejEg81DCPosQfkTo9S4B4Ygf0DHh7MvzU8m/?=
 =?us-ascii?Q?JJcj8qjh7DhwEO8QHDXZ54fYKAJsGNTAD6iQYKNoM/totXW33jltVzkAmqbi?=
 =?us-ascii?Q?WXnWddACQHKWHckljK0MP77GCz3RTPw/9MsxArt46cSrAxQ1+PS00zgdp526?=
 =?us-ascii?Q?0F26VnrNmD+yNNsBimZ2a21Pl3ZdFRNpqfxWQyHJW/IatxSJx/f6YMbUToVz?=
 =?us-ascii?Q?/8qGo7Nf0vpJwfrh9W4cRepgAwEbRG5PfzL4cRIlelrLTMxkjyUjtAJWWmQj?=
 =?us-ascii?Q?1J9glgi+1gZ5Bxl4O8TSVJEzEPHgGdb2ynnaIVy8eZCzqUtC5T5Ljbta8U/R?=
 =?us-ascii?Q?fxVCNNGIxNto3Zu78a2oyy99We/r5/HaZeeapINqu3fCoCh4glzacuiV5VT0?=
 =?us-ascii?Q?CQ81bw26Dhwb1RKVSRos1+z5ltf02m3xG/hA5m1eFY+qC7JEctv1r27Y4F7b?=
 =?us-ascii?Q?8llkLJW9shIATgmHdAC8Ej9cFqKtO2vwX8OjpXooHTaEFhLt55/9PEDO9rkT?=
 =?us-ascii?Q?kxIW85MWRfIBcq9T4sD80Ae66J9ldbJm42v56zZMWg598gKjVGP7xOucPFCR?=
 =?us-ascii?Q?Rxug3YietleMlykbIBomwTnF/GLYuEp+k44n6TTgqXbnSY9NgkZsM3YVC2LY?=
 =?us-ascii?Q?nn3k87+oHqu/2YjiCqp6ON/SVEdDqIl991/sygoq2Y8N3JjKBtN8FVoiiuOq?=
 =?us-ascii?Q?z7WT0/eR0je/YDrub03I1m3MsPjxFZhKA4ydOwaqQy7alo71HsNMiRYBSFQ8?=
 =?us-ascii?Q?umN4h9d3ciUeJWVrdXoHGrXwbGDRhpkNfLVob+CF+ToezDh8R0VkpAFVkj1w?=
 =?us-ascii?Q?MzMkEpYrCVochOpwq/6o7UP6+bso+Qpt3esJEkGlCOO4L9briFp9jwXFGsSN?=
 =?us-ascii?Q?C3lQEKEpfH36fQ8SYhxzRDRCQhYhURxKmIH5u1ColzatYIu6C8GKUaNkBWyJ?=
 =?us-ascii?Q?BecjDbglof71rFWpwBMfTM6CxOq3x59Vp2LdHzHCMacrLelcCVeK3x8yMnxi?=
 =?us-ascii?Q?3IeasZQbJFHDpD3RX/bg8c0XwEFrA9Wv1Z+AO8vtgr63TZM9b1sVF3amSADL?=
 =?us-ascii?Q?SlfPkyFjl2PUCi3P6Sdpu8gFkWP0ByfWx8oDxNcyr7ZrpmKrcKQrZSUP4DEb?=
 =?us-ascii?Q?EyXlkYPtwADP4wdxdNXelJDG/a5OZ0wLnqZDNoXBK05oT4qI9o+LJkfXYcUu?=
 =?us-ascii?Q?gg3525tjqE/86s7mAhYhd5ZqCIhu3wUmyIs6ScqE/pdgrI8eYUUgKaMcuQi3?=
 =?us-ascii?Q?cxm4LAWGFSN7sSiKxmw0ifTJ6rNRrzvwFvCraGzHUvClza2SBwtx2hutHDmY?=
 =?us-ascii?Q?v+JFGL6WQL409XMjNIHWAfDnPnvu0mH1ju9GBdJwFj7xQThbxQzn0iwYl8Z+?=
 =?us-ascii?Q?X8Ww1xlKm2xAIugBQgqRHQG6daL3Cf8Pov0WndmJ3ipXUhoU3md8Cjnn3E4h?=
 =?us-ascii?Q?Hd5XIhBLkDb1Eo3nfO2ZLMPAyKjwAodK6d5zBMETsRtukLjIoE0XC9Tcsoqq?=
 =?us-ascii?Q?J+j2o5vmDgMtPVbsDEOcfPSgYoPH9TP33LWcr98374lakXGDCzxGxkbodhpF?=
 =?us-ascii?Q?6d1XUgyHynY6eqUY/QCVEvMdAouy/TWVccopobS8u5v3GQnVJugca71wrq7a?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaa0a3f-b9cc-4e8a-7294-08dcfe7243e2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 14:49:50.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kuaq/VdSu791wPWGZty4APFm/yz+sEJ9dFXkR28f4ldy+DTV5+uDZiX2+/rwif+hziL0eKuqfkV6vuRuFCw/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10086

--y5h5puwhv7qfzquk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2024 at 01:43:09PM +0800, Wei Fang wrote:
> Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
> MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
> to configure preemptible TCs. However, only PF is able to configure
> preemptible TCs. Because only PF has related registers, while VF does not
> have these registers. So for VF, its hw->port pointer is NULL. Therefore,
> VF will access an invalid pointer when accessing a non-existent register,
> which will cause a call trace issue. The simplified log is as follows.
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
> In addition, some PFs also do not support configuring preemptible TCs,
> such as eno1 and eno3 on LS1028A. It won't crash like it does for VFs,
> but we should prevent these PFs from accessing these unimplemented
> registers.
> 
> Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1 Link: https://lore.kernel.org/imx/20241030082117.1172634-1-wei.fang@nxp.com/
> v2 changes:
> 1. Change the title and refine the commit message
> 2. Only set ENETC_SI_F_QBU bit for PFs which support Qbu
> 3. Prevent all SIs which not support Qbu from configuring preemptible
> TCs
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index c09370eab319..59d4ca52dc21 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
>  static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
>  					 u8 preemptible_tcs)
>  {
> +	if (!(priv->si->hw_features & ENETC_SI_F_QBU))
> +		return;
> +
>  	priv->preemptible_tcs = preemptible_tcs;
>  	enetc_mm_commit_preemptible_tcs(priv);
>  }
> @@ -1752,7 +1755,12 @@ void enetc_get_si_caps(struct enetc_si *si)
>  	if (val & ENETC_SIPCAPR0_QBV)
>  		si->hw_features |= ENETC_SI_F_QBV;
>  
> -	if (val & ENETC_SIPCAPR0_QBU)
> +	/* Although the SIPCAPR0 of VF indicates that VF supports Qbu,
> +	 * only PF can access the related registers to configure Qbu.
> +	 * Therefore, ENETC_SI_F_QBU is set only for PFs which support
> +	 * this feature.
> +	 */
> +	if (val & ENETC_SIPCAPR0_QBU && enetc_si_is_pf(si))
>  		si->hw_features |= ENETC_SI_F_QBU;
>  
>  	if (val & ENETC_SIPCAPR0_PSFP)
> -- 
> 2.34.1
>

As per internal discussions, the correct fix would be to read these
hw_features from the ENETC_PCAPR0 register rather than ENETC_SIPCAPR0,
and have this code exclusively in the PF driver.

I'm expecting a new change which moves the capability detection which is
similar to what I have attached here, and then your patch will only contain
the snippet from enetc_change_preemptible_tcs() which you've already posted.

pw-bot: changes-requested

--y5h5puwhv7qfzquk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-enetc-read-TSN-capabilities-from-port-register-n.patch"

From a83143233c9c3fa9c5437624ad50c9b5c46bb2ec Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 6 Nov 2024 15:17:13 +0200
Subject: [PATCH] net: enetc: read TSN capabilities from port register, not SI

Configuring TSN (Qbv, Qbu, PSFP) capabilities requires access to port
registers, which are available to the PSI but not the VSI.

Yet, the SI port capability register 0 (PSICAPR0), exposed to both PSIs
and VSIs, presents the same capabilities to the VF as to the PF, thus
leading the VF driver into thinking it can configure these features.

In the case of ENETC_SI_F_QBU, having it set in the VF leads to a crash:

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

while the other TSN features in the VF are harmless, because the
net_device_ops used for the VF driver do not expose entry points for
these other features.

These capability bits are in the process of being defeatured from the SI
registers. We should read them from the port capability register, where
they are also present, and which is naturally only exposed to the PF.

The change to blame (relevant for stable backports) is the one where
this started being a problem, aka when the kernel started to crash due
to the wrong capability seen by the VF driver.

Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  9 ---------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  6 +++---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..bece220535a1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1756,15 +1756,6 @@ void enetc_get_si_caps(struct enetc_si *si)
 		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
-
-	if (val & ENETC_SIPCAPR0_QBV)
-		si->hw_features |= ENETC_SI_F_QBV;
-
-	if (val & ENETC_SIPCAPR0_QBU)
-		si->hw_features |= ENETC_SI_F_QBU;
-
-	if (val & ENETC_SIPCAPR0_PSFP)
-		si->hw_features |= ENETC_SI_F_PSFP;
 }
 EXPORT_SYMBOL_GPL(enetc_get_si_caps);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..55ba949230ff 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -23,10 +23,7 @@
 #define ENETC_SICTR0	0x18
 #define ENETC_SICTR1	0x1c
 #define ENETC_SIPCAPR0	0x20
-#define ENETC_SIPCAPR0_PSFP	BIT(9)
 #define ENETC_SIPCAPR0_RSS	BIT(8)
-#define ENETC_SIPCAPR0_QBV	BIT(4)
-#define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
@@ -194,6 +191,9 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PCAPR0		0x0900
 #define ENETC_PCAPR0_RXBDR(val)	((val) >> 24)
 #define ENETC_PCAPR0_TXBDR(val)	(((val) >> 16) & 0xff)
+#define ENETC_PCAPR0_PSFP	BIT(9)
+#define ENETC_PCAPR0_QBV	BIT(4)
+#define ENETC_PCAPR0_QBU	BIT(3)
 #define ENETC_PCAPR1		0x0904
 #define ENETC_PSICFGR0(n)	(0x0940 + (n) * 0xc)  /* n = SI index */
 #define ENETC_PSICFGR0_SET_TXBDR(val)	((val) & 0xff)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a76ce41eb197..61e2df3e047f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -409,6 +409,23 @@ static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 	enetc_port_wr(hw, ENETC_PRFSMR, ENETC_PRFSMR_RFSE);
 }
 
+static void enetc_port_get_caps(struct enetc_si *si)
+{
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC_PCAPR0);
+
+	if (val & ENETC_PCAPR0_QBV)
+		si->hw_features |= ENETC_SI_F_QBV;
+
+	if (val & ENETC_PCAPR0_QBU)
+		si->hw_features |= ENETC_SI_F_QBU;
+
+	if (val & ENETC_PCAPR0_PSFP)
+		si->hw_features |= ENETC_SI_F_PSFP;
+}
+
 static void enetc_port_si_configure(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -1026,6 +1043,8 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
 	pf->ops = &enetc_pf_ops;
 
+	enetc_port_get_caps(pf->si);
+
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
 		goto err_setup_mac_addresses;
-- 
2.43.0


--y5h5puwhv7qfzquk--

