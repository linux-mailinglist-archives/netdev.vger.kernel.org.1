Return-Path: <netdev+bounces-141401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD59BAC44
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD871F2172F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B2618BB82;
	Mon,  4 Nov 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NRgWnagO"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADB14E2FD;
	Mon,  4 Nov 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699947; cv=fail; b=WQh5HP8QZkOrX7mk2gAmu6Z3kxjlu0paIrfrjvGtL7oQvWnATYfVK8N5coeloZ+dICfnYugrWBJbjGH3V8PdY31sQ7AY9mewwR2ijWteJn3jpV04bwoaSK9+i4wRGMkgd9U1uOBo2SdfHQvIwVVcRGKdHzcSyJZiDsAL4yNVgQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699947; c=relaxed/simple;
	bh=TpOmJjxesC92ijikdMY1N6LB2jlvspErGwqu2W3aSMs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=srHQmZwF1s1t1m4yDNhwtfJYRKHS3GtbwuHbeqtKLOUtMdv6+/87vDH9+u0gZTFbQb/SX+rcs09Y5BuDfLc/MrwWclGStVQX6SqHdv7u0IA+xCoxb6N91LzBV7V8NlBpWLFh3H/BHgnejok1LmRqnSZyyDshp44g1sL2GHgvnlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NRgWnagO; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3br2J/s8jyvS0chfoG4aygRKL9oXcrip8y22LiXGbbK4LOn3sFrglrf0R+F7CuSJrr9gQUh5WI6s9J8iDqASHHw3z0B2hV2KIb481aKne8IKLckn2xPVENxv6j8vdOUUiPN+MRR4LCW7OkXimCYJET43oQhVcaSoS/pPrWDlTZg0fGzn9xvXzStAo20DRQIavOiPcuNpqwaQUXEx/7Vz732poHdl74kVrWcIsFly5lVr5xwg5WSAuRkz3Ze4/bgwt01OFtDw959xJToy1dLCgswImB4mqklhtG+cYqxJhnYBsGe/sXgZCOHyK7ON6m8vqFKXj1VMttFKLjmnWqtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktxnUWkN+nkx3qM8i218Ry7l4pjTa4bXYkS410vJiuw=;
 b=TAb+wRHuJ3OFn5iOrMf8c+BBXMcroyLRt6B3plMDSJjxKKBd7jtTH801n7bJopW98ppdD6bNZKOLHuRJjxJqSI9JTN4ugG8cMxqeYQezuJTiJgzduyI16kSBhscGIudgiXfGRAjRuxj/Ej1X+UEjTLHlLdyTf/8LhCHf60a5L87NLuopxntA1cpLQDb151hfqCz4ZrUJonyepdnxxvkcyM3G8vWj78p2TChXRzmdtg50Ud2YmyNvaMguo5tTJk/WUZo8V8OWr9WdHCgsD1/4PrZU5lTIF73adI/g5Haq7cJLTOMXfmePRiBj8Eb48HqaESFoLXwo3IgXA0HlYCNReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktxnUWkN+nkx3qM8i218Ry7l4pjTa4bXYkS410vJiuw=;
 b=NRgWnagOxl9inCuGPMX2ZB0LSIwyP4Ub4kZXvkuLIxPne4MK+Mo5TFrAnbLfDmZfms5yjWcFxxPGYnxxkFNWq3bS0H08zah8u5JKiapw+MFEqjDlgXYVO1wUslm5uO/cwhm5dEEehUdH8C2gp7L0HO6jKfAxdVqAGbi53fEB4JUPQGd9eiD/8/7M5nmAJUDDTnq73yY9UmPH2TYOESN8gwUA0ULDoOSBBw/rSYJIhXRqGayStesvCfqs0flTDIsZhU7ujTjbENLGzVQtOzBT2K56t/srG9PBiCoI5cXoG9L9TID6QVO6rScbBBa5hmCFomArL9/2hnIFNK6x5eCUvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8173.eurprd04.prod.outlook.com (2603:10a6:102:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:59:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:59:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] net: enetc: Do not configure preemptible TCs if SIs do not support
Date: Mon,  4 Nov 2024 13:43:09 +0800
Message-Id: <20241104054309.1388433-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eec2edd-8288-45ac-6a8b-08dcfc95c84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iXS22+Nv3kzlQYCMxK96ZUFoFp1qQigk8OHEofyFbaRZYMZUo42Cn5pro3EM?=
 =?us-ascii?Q?7hxIy0JYbO3ju6+8x4vkrxm2bphsCea4vOcki09v/H3ms7unyDuayDciBhLt?=
 =?us-ascii?Q?WniKqKUgHyjtTx42NaK9yCPUGkmuuko+BkpZIHnsqkzHwiGp2sJu2E8Jx86Q?=
 =?us-ascii?Q?rmGnZlwGLH6WLJnB0G0ztNjrVfUI33OVb/XsHySE/BgijE7e7j3Q/ICWenVc?=
 =?us-ascii?Q?2U1RezfmVtazKe/FWtoWs+DSSDN9/dipN/E+/Cs7myXda2J5lFIZYTT2rljM?=
 =?us-ascii?Q?wK+Mk3UhRnec/OmK0Q2G0SHeTeGxlvgsNRMvTlbDeimmXaOmrTTET6i34kqF?=
 =?us-ascii?Q?Ee4HbYTKn5toqifDl92266OAkiUDtzRObFP1sMfoeTDqTrrIQwb7CDYE2ipw?=
 =?us-ascii?Q?cjcJkSBq2sF4aj58J1l9fj1D0cgczB4bkay03DlPEa4NusiKHuLpMDE4DB5g?=
 =?us-ascii?Q?VQm4DlIPz2Ry/p01bOMzoewfW7OyXICL6BiIzXN5pHoVA7Yfh0TxbRIkjy19?=
 =?us-ascii?Q?RJjnE+u80S6IZjzP6x5XQT4X3cR5/rIpOh4J7K2vm0/zM+N2CjnF/UITajW/?=
 =?us-ascii?Q?iE1Nw2+TfngPiFkkcthl9RL6+aDTtXZbT8obcoIzNxhDfqiyTTwIbeUv93Py?=
 =?us-ascii?Q?Aajl5Dp58ITERFtF+oDXtbXrrKEYbII2L/1j9xjDKUZ0uFS0WzshlqFJFaNg?=
 =?us-ascii?Q?iq3n1sn8CxNqQywBsVslX8X3GOKCYQGFmRprDImpUrh+5GSkQT7oRzto5Y9u?=
 =?us-ascii?Q?kDO/DmUF6tb3YA//0+jNPuqFiqf9eMRcQkDThv/uq2EmBdoietIUZAxRZnC7?=
 =?us-ascii?Q?h58rUr2reiRUbo1wp4T+E/4bnqm/1IFcznbMcn80GH8Ddc1fGkdUe3sDewrD?=
 =?us-ascii?Q?bhG3ySUxi8kmWRfSmsyDlEAvEMDwl0/T0YzlNa1+HR1StlaFSlrzwBxELUVl?=
 =?us-ascii?Q?KQYGJIHLAtFIPlYOK2M14gMSPWxJzLSrS6CLQieh4m/AUhnaWibPHFNCRZPP?=
 =?us-ascii?Q?hDsSYHVC3m7Dje2L1MvBnvxYZ8XkcWv9MH+Pc2ClsSRFj2TNV7ei1fNPipu7?=
 =?us-ascii?Q?8GY7eikq0kA4qxnfbPL7AWFNo75KUlhBbX8l0ZpVPMn0aDm15oiEYD27lZvK?=
 =?us-ascii?Q?p9Apg+YwgudT157ONriCLG0ZoKNDlK3dXHaJ6vnG1DuOLXVKzLx7m9fTQPb4?=
 =?us-ascii?Q?0VupuMrwL7OrKsi1goCVQbhG396Utu8zsC59K89R2wdeqh/i0/g4KormaE8k?=
 =?us-ascii?Q?WACTyFrCXFfm9UHi9HGZR9b3eyO8JtC83leROSQlqrD4vHrM1Sq8EecrpTvE?=
 =?us-ascii?Q?jk2GlrNBJ/VCoGKNKp0ZMxiKLRsaGDSocHbGaqpJEX31f+IkehboeVHQtYpq?=
 =?us-ascii?Q?zz2sbunCvLgevBXsX9Uk+W06Orth?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a9ahsPjAaXRgYUv0mDEfdxlFNtJtmlsL08N741B3MwL9W1EJ8MJ7a5eJTQfd?=
 =?us-ascii?Q?plvHV7pCntAY4H5LmAslduXXzN4eCvYDAsQicnbbq8mX80LwjIk3kmvQn5yr?=
 =?us-ascii?Q?JCVBfS7PJRe8Hi/n5SwEQxLExy2kGlcMzSdLrD0U2Ezm9ZVYL/E20AJCgk8b?=
 =?us-ascii?Q?gmz3JQM/KepapQZctIkFQ8UqQBvIq1c/LldmvnJxGQ6IvkUDpujhdGvbxkl2?=
 =?us-ascii?Q?ArSwoy4oIdX1VfAm9pgJ2vVkFUBrn++sqn9ZjbYcwMh1fvoQ5s9gkcF+RDCp?=
 =?us-ascii?Q?7xMOn29c4Og3kopL71ZDJ20Mv+w5SgNUS3GmJJk3YsoC2hAPs6sGoyKbBGQy?=
 =?us-ascii?Q?qCtDLuF8uwRidBfcHUAgBB34sBFQ7FfCcsOhftD7WAxt2vV+W4n+4+3VkVtw?=
 =?us-ascii?Q?RMNtpJTW1EqUKygZLA7NNTNyimQ2SVOlt/b+quZVxx2EOrZkr23bMoJTbt+s?=
 =?us-ascii?Q?2J8Ck83WnNkcGx68eusUPDhdC7yR2pIoOoPThQi+IoeBTsG5GHj8+1duFTbv?=
 =?us-ascii?Q?qQYk1teEI32ri736kfmZvfpXC4TKbnu2xELp4M+LHNSjdjFnpEmCv7AG/LM0?=
 =?us-ascii?Q?2pnnhVmY5XtEAl018RJEUkwIxKazF0cztO6DUXYBNdzRJKPWl6A/o9CPDLTv?=
 =?us-ascii?Q?MzQF98g3S9yCVNIvbCcuVRnR02PzluDyXGAEx9bt3P9F5DUU9pkGNxmzjY1g?=
 =?us-ascii?Q?mnmpJmiQ9hkI3NpgLOb5kmjk+NjEo9uA/MbRrs7NLY7SPwksxJn+f9j7DApg?=
 =?us-ascii?Q?PO1pzzDXz4uq4xRqImvwSSBLTB0pGGfSv0o9tm/CaOElxlagmVupiglh6hCv?=
 =?us-ascii?Q?U9WZZ6N1ToMxr77AY5xKJ5Ex0E0vPf1sb+bLjaGQ6PRdm+i+ouoqbF8OhTRb?=
 =?us-ascii?Q?aR7URLYHyuh1pQO/hLZdqm009BhQ8vGy//UXjMM2HSPAgyBuJWDVmmKlLey2?=
 =?us-ascii?Q?ST+IrY2T6j6Np9DLN3dzTIijp272XSimDRqL4qQQAww0MgX9TErtB1YZ0Osl?=
 =?us-ascii?Q?iT/U6ASOuIcUGBBZuNXnrZ93PNIE3NnFwRLncBFj54OkA3Lrq4k3/ZM5SBTl?=
 =?us-ascii?Q?FslfA4EBEEhvct51EbiLBA0RC6fJr+NO3TvEaDRwm2ZLhxLnhq2hf5RcekDJ?=
 =?us-ascii?Q?1tiIP/v9yFF1sdSq4J0GnlFwlSa3K0ol0UmMkb7CeDY5SJiWmwwHvUHby0fh?=
 =?us-ascii?Q?PPkrSZ80BAc3G0NgDVH5w8CzXe51BrGzP8hAjU6AtfSWEThtx36oyPJVyjOD?=
 =?us-ascii?Q?aLeFgZWo6bNVoScvWu2sFbd55a9XAgZnSoRfGgALJFgecx0UZQ8BL512EL6I?=
 =?us-ascii?Q?YDYRyPQXUZzxREGKD5OBwfpaUQcw8qsNA7l4NkT4HidO/mXfwOXyY4LnyTi0?=
 =?us-ascii?Q?sw37izAtz5SrIAMZslilZpP1i8g0LA2n1QDbARdTa876u7hFM3tD+AU3QtDd?=
 =?us-ascii?Q?b76x7Npo9z81wb6tURmnn7TmA57UL/PvpqesPykdMeWw45aJ26oqx5CSDNna?=
 =?us-ascii?Q?OZYGXc88GreEKXWDh07k2BuFsJfa6GXd4kyXQGlIBB6te+zx1AvN9VVPCBU3?=
 =?us-ascii?Q?ZmPcBp8/R9Ct8u0KMjaq6FsFHuWm15GO6hXGh9k6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eec2edd-8288-45ac-6a8b-08dcfc95c84c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 05:59:02.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/OpUtcnhdbxh26PWyoJz3jNwxbEJY6TlN9ordezIAywHWIDmRUY2JUUyEjgAInmtYPFKD47zTE0rLGrv+2xJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8173

Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
to configure preemptible TCs. However, only PF is able to configure
preemptible TCs. Because only PF has related registers, while VF does not
have these registers. So for VF, its hw->port pointer is NULL. Therefore,
VF will access an invalid pointer when accessing a non-existent register,
which will cause a call trace issue. The simplified log is as follows.

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
v1 Link: https://lore.kernel.org/imx/20241030082117.1172634-1-wei.fang@nxp.com/
v2 changes:
1. Change the title and refine the commit message
2. Only set ENETC_SI_F_QBU bit for PFs which support Qbu
3. Prevent all SIs which not support Qbu from configuring preemptible
TCs
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c09370eab319..59d4ca52dc21 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
 static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
 					 u8 preemptible_tcs)
 {
+	if (!(priv->si->hw_features & ENETC_SI_F_QBU))
+		return;
+
 	priv->preemptible_tcs = preemptible_tcs;
 	enetc_mm_commit_preemptible_tcs(priv);
 }
@@ -1752,7 +1755,12 @@ void enetc_get_si_caps(struct enetc_si *si)
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
-	if (val & ENETC_SIPCAPR0_QBU)
+	/* Although the SIPCAPR0 of VF indicates that VF supports Qbu,
+	 * only PF can access the related registers to configure Qbu.
+	 * Therefore, ENETC_SI_F_QBU is set only for PFs which support
+	 * this feature.
+	 */
+	if (val & ENETC_SIPCAPR0_QBU && enetc_si_is_pf(si))
 		si->hw_features |= ENETC_SI_F_QBU;
 
 	if (val & ENETC_SIPCAPR0_PSFP)
-- 
2.34.1


