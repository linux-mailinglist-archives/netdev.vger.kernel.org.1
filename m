Return-Path: <netdev+bounces-140306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54129B5DFF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3641C20AC6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0B1E0E0E;
	Wed, 30 Oct 2024 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e1V7D1Hq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825181E0E03;
	Wed, 30 Oct 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277404; cv=fail; b=R3I1ueK3xsuwloBh6UApNkQKPi2nTpISma4L5spZjlgmlS0FeYiFgW9N9je+3YIcBUscjBKfxB+0sS2ox7Jf/opIG2EDIrGa+0QfZIaQPCVVJ6YWKKnyZXDr7wXQZEu0DpZX6/OgRv+IhnWv01uoQqrlxQM8dy6lTIBm0ooSFN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277404; c=relaxed/simple;
	bh=inu39836AOS9VYbF/VKtuVaN0HIG/6Rg+/qae5iChSc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X0U7zs0j05o0I/LtuifsBNBEZg9YGIHADO0V5VlJddsI0VCGf3FeWcDgmaGKDAG5njHpB1B8VWULloHJDFXSJpHoUcqqTCjUKx96k9JRZpmT4Sryf1E0DxPBLW9LB5rb1Zm7RwH8Wuz75Re5Pm+D0cPxt19r82DRYLpH00CKpDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e1V7D1Hq; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adZ8cce0Tj0M8awgjptqUngP77xILXWCG1nMOaPN+GwEDYtF5siPaT06jzTLNsXOE7JaJxsIOQ/N1A0S7rZZFe6JqYKc+ipV7U/ykwyQrxrmKfI8e8ATfkCiVFxGVEGnvztwkzpuVvNGmj0NJpNZAovCuwqh7lq5q0GCqovxqH1/RAWUUy1jVKSMPDDl1D1YtF3lZ7J1Nt2FkkZD7Lxry7kwhiFLxC3vYqRDpmRwIlHMlFKI7pm45sgSkYOAHy5ACnE9Cts2YU4K1Cmu6gXdaoz7EHWXoTRKwmFP5BCDMALTO1xKHgiCzM7Mc5Oj7VZ+STjIWgfjrvGAkaibwsyNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGe5E5SgsYwhFYQ5MQ5Y38BikIJ/sFB1YqIF3ZUf/HY=;
 b=wsbZAIRwJnVLuFaX1TpWANEmNpLNkxiGUBs/gbymlB0k+Yd4iNXkKQ4qJgztIY+q4KiEfP5xY2flFQvMq+vxqclv+CxDo288wgwagWC2VtUj4bPBVtJGSgsAn5h5yPzpBHAhrFA9cHnM958luIxvb2VHlOgd+f+qwZMoxQX4Y2+ck/DWzCO7VYcJf25/CM+6RXVxqn24lxXJd/KhngGpk8WwUQEQu/1MH9PW1pmBfmkDywAveKCnyzGZO79U/WNMetGcS1vehPr2QsUiPuk95XnkSphd/AKgHEqWUMD/51kKxMNvkxEuVo9ipt7tGsK+hBPxBoz+xTk7tnaICEiruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGe5E5SgsYwhFYQ5MQ5Y38BikIJ/sFB1YqIF3ZUf/HY=;
 b=e1V7D1HqdclY0GU10bZD8Kvf7EpkQZwJ1au1zEyZVgSVM+NiQlTXIAS4BxiacyGYpGlsvaxjKUq2rWjz4gR47I3EWVCHAlQu1+T4FbJoaoxN7A7OWxPz6W15/vvoGwXl+vUGsQKYACATNU1G28uYWhe/K6xzNGESP3zTcVIQtjBC7K32DpmnI/VfmdSLul/hOvQdz5nl3soAVLIN1PvO8TzNGuGFVhzf4AIdPtPXum023/M4cUKSxO82XYo2f8mgFnE9XjWCWtW7ioYTZ6bmpJmZj5PQvPIc1Y73Qon2/nU0ljbxkkoG/2LBZH/HuibnZZmr0agQtK+ZQlaOkupo5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8878.eurprd04.prod.outlook.com (2603:10a6:102:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 08:36:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 08:36:37 +0000
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
Subject: [PATCH net] net: enetc: prevent VF from configuring preemptiable TCs
Date: Wed, 30 Oct 2024 16:21:17 +0800
Message-Id: <20241030082117.1172634-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8b130a-c470-4af8-ef56-08dcf8bdf7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4URX4tULLdQ+opNRJ7MCymve64E9zP2zURlDGSy8eN/+ZOSLYLrCATm0UE4m?=
 =?us-ascii?Q?r95P6B+rGS78R1LQiOt9lkyitvOdMmSPM7dd0VfiKXFHgri6XGdOAV/IwLgV?=
 =?us-ascii?Q?7HgziS4XEovwmXlwtgSEqUplSv6Hk1hwlvcUXxyr8aCvQwxa5R/rPXJzHVsj?=
 =?us-ascii?Q?K9ePG+YFXHBrSzFjXvgOiD8Mh9Nk6GYGb7Lf+w+tZ3qJO/ro0CcPZAMX+7dU?=
 =?us-ascii?Q?c/DgPD6zznF/pshwA38tHoXk8bZYMwnSjhfYnzhzedDtinguAm1a2hFFDp18?=
 =?us-ascii?Q?a7tHsWR7y4af4TBn/TlJ2uThbD2aHi3egpMnMNF0FYTAFjd01LZRdjRnDSTK?=
 =?us-ascii?Q?xuQs131/bC6JwuKoC+gnus3bEp3C0kNIuj5Sd+AV+HFbd/3f85jRfJo8QsIZ?=
 =?us-ascii?Q?J7Cb8gMwBuuvto2mXI21n3U4qbLjZLkYnCFzpIyZrVHcMZhsVq3Jw/yJ9aP7?=
 =?us-ascii?Q?veEkhYTw8N7nwk1qDaV0r+2NQw+xPf0pA4BNkXZld3TfDbhkqQMe4Xvu3Z9q?=
 =?us-ascii?Q?NoDzDqPfZow48lMQ4VUiLYfVin+37lRHZnGYeM5J5CJNbXqDKfkJwhrQ4601?=
 =?us-ascii?Q?uCdaQfHPBXyp2cPiGawzBLRJkCMNotWT2Xd3EcN8DwE3GSb8NhZFfnN2SIUS?=
 =?us-ascii?Q?pv55LydAhTiasOBtMvY4DcnrcgY2ut3LAnc4kgfyxjmUgWu9pb+2nCaRAovy?=
 =?us-ascii?Q?MRlZf+OdcVaNGbw1rDXWM1IhZfDuXXn/l8J5IN3uNmFY7pS7kL8dr4dUJ471?=
 =?us-ascii?Q?XuBrVxGNOatcItXxQePLTaxqQxCtksD61ITzRZnifm+GZiPeWJJDcuxk6Ye6?=
 =?us-ascii?Q?yTxci+p8I91ujmPHYoCJLmU4bjkibCTXqKYjo5/XbwLpnF5ltY2R54a52bzW?=
 =?us-ascii?Q?0cKobpsqEIXOPF/kTtXzBmffPLUlrtfUztVOOu07bNvyxqwIkxdTD4Dr9d7v?=
 =?us-ascii?Q?1+7w+Mj3rWGBfds/95LRHHbHcJCZN+KB5UjtD3jOh/dQIWvvGv05dBqzIbrj?=
 =?us-ascii?Q?vlJSIMpOV+ZUktRav4g9aZNFOuoMS/6IJE4ub1SZ0srLcWNUU7A0z/BK9/D5?=
 =?us-ascii?Q?Ff8Oe8vVQLQZGTmv3ImMzdvOVwOhPeDSa0xeY0g17voYbWkRDp1htjZG6fcN?=
 =?us-ascii?Q?vK7KBOzs9Csp5wbKwXDNcKJGGc+YTocH3HFAcMA37HUVb1vvwF2SG8/GEWc7?=
 =?us-ascii?Q?hTVud86ZtrGbuEnpBT7llIOS86weCuWbw3MQ10k+XkGp9CLgCqT6O2QJKSJ4?=
 =?us-ascii?Q?YKWjv9+9DTOAVAZowbdn/uq+0KvXUpe4jVv4iFKlGFDNiG6bRqNaOe+wym9M?=
 =?us-ascii?Q?HHT9qhTlsXl4cBgs5Oet0zFzCqzu9n/gGckyx3XkRt6F2GsW8jZMNR1Z4WZL?=
 =?us-ascii?Q?hk7WDLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngzcwz7iUQk2CmvUHroxpMD+G4zUSbfx+lXsQODuaqHEYkNhuN/k3z0KMrFv?=
 =?us-ascii?Q?2kQ4R90qca2TvgDRqnM/wVe2RES486ADTNpCcQ7a6UP7Ba2ikbC59mnZzWng?=
 =?us-ascii?Q?nfivH9z2B1D/r2dX/HwkCF0CtQIrMsn+EFNTlSSbBNXDKGN4lajnLbB+XSCj?=
 =?us-ascii?Q?KKb/GUyWzliE9C7tnEVG0+vn9VfOdx73H95oGZ0WJ815vj+xfoGWWYGO5z1x?=
 =?us-ascii?Q?I1/x3dxep+nJTYyVsShKpeWMTK9SYPmhsxLZldYAb2meYq5qdUh6J+H1yZRT?=
 =?us-ascii?Q?EWxjUxQKplk+cSroPLOUI3sjhzkWXs3f5TP7sROXqfaxRVRDtgZZB0fAT66V?=
 =?us-ascii?Q?+gXFZmRmNArHtpJYeuCToY3fyv6K1m/dycdb7aASBIHPMa83K6yXyX07FmeT?=
 =?us-ascii?Q?ybIkdAUSUbaDt4J/Om0sW9L8aVhGmsrD6RPhWYJzurmc3Fr7Oc6vzlO5j1KZ?=
 =?us-ascii?Q?a5F5DejC+wtSadCX1aJnDc7F34n27EkjlefQKUQwNQ9+60ep2uzt3M9QdXVI?=
 =?us-ascii?Q?ar1uQVJMtC25cVXauaXkjptPpMyR+1NdT3ZTzzr9EtchgNnDFggIGWC25ddQ?=
 =?us-ascii?Q?cXQffn3QBarkmwMf/eRBpPHWjB/bWnfk/3hr7OGmb+uChcAyoCkQapL8PdVO?=
 =?us-ascii?Q?wOuCLjQYuCIZ0CKafsyxg1kklfQGiR4GF587Uy6DrT9IYtYecah3UCwEHLY/?=
 =?us-ascii?Q?HVrxtSjF91/2K2GBjWO/uw/oHeoaX9i8cl+bJajjs0AG+Cb7pYg2J2HaaMlt?=
 =?us-ascii?Q?hxPN8BeeKaH47kSL3dDbcSPY295LMo0A9M60DCJCT+pMohJWw+ccKxB0VDYZ?=
 =?us-ascii?Q?Q8CEuyWPV32UBovBBiLd+oVZpzol2l0uu98Lf+qwjVSOcJ2xHthagHkOpIwd?=
 =?us-ascii?Q?Sig87WpqZBjelW8hHuR5P1gioSA5kHyWZ80aV0pBJh7BsL6WVkfb/nfDEzLk?=
 =?us-ascii?Q?9oNyYUrUhJFwJD809sX0dege56h7kkMHf41zIuauDITuf4i/FR0RNjv0RjQt?=
 =?us-ascii?Q?OVF4gmJayjZaMvoDK0opk62/2Eozfn7r3blLF9M1Nj+HS6y0g2kHzBGmLVm4?=
 =?us-ascii?Q?nW0CTsxHI6BiQ3+9zcUUpohT6pqsUQEm8FK9HbK0fNU2V3PivADl0L55jer1?=
 =?us-ascii?Q?jGZhBZmDbGwKOxz6E+xTvO306hyolp0RWVdfY6eAVDr0bhGvwxIqjbxD91bP?=
 =?us-ascii?Q?G07H5rlPoRkUhzwJPVL1HaBXcogICt/TTCsNsGa63yqcPSxv42ftLSjGYIaC?=
 =?us-ascii?Q?Un7ih78nxYjjYM+eVLLWgfHXs0ZI6pVmGVAE+g7Dbes35CAX0TUnCdJyEj6M?=
 =?us-ascii?Q?7JRdokrx70adClAFmkpxeTkTuH/kYbW1Sm6ao6WcMJrZUBJIEhuQxDWLPws8?=
 =?us-ascii?Q?pTcYISJ4WV4TbTtK8k89XaZNNRCl1x3R/PehRNQUi7g0qDcu6PgIe8cKE1Zg?=
 =?us-ascii?Q?UadY/Qc9wC1+QEwAEwUerOFQIYw5l1lbky6HkR/49Z50FocHIwAvksP+nvoQ?=
 =?us-ascii?Q?SsTh/bJ1ARwMwq/Y7/eFO/nxtkhxYLnA/47HNGuzvzex00Wsc5jzSCtlhz1C?=
 =?us-ascii?Q?MOMBdAlccPorOmPiWbJ/jBlhOY1HJ3Lw813gd4q9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8b130a-c470-4af8-ef56-08dcf8bdf7e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 08:36:37.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQBIxAztQxl8dR8qMVOT0PWupNtwcebH+hpuCJnAkP7gLSkuocxcKu8zpgI7BddWCruj7X00WYaD9j5tLv3aNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8878

Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
MQPRIO. And enetc_setup_tc_mqprio() calls enetc_change_preemptible_tcs()
to configure preemptible TCs. However, only PF is able to configure
preemptible TCs. Because only PF has related registers, while VF does not
have these registers. So for VF, its hw->port pointer is NULL. Therefore,
VF will access an invalid pointer when accessing a non-existent register,
which will cause a call trace issue. The call trace log is shown below.

root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
[  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
[  187.298760] Mem abort info:
[  187.301607]   ESR = 0x0000000096000004
[  187.305373]   EC = 0x25: DABT (current EL), IL = 32 bits
[  187.310714]   SET = 0, FnV = 0
[  187.313778]   EA = 0, S1PTW = 0
[  187.316923]   FSC = 0x04: level 0 translation fault
[  187.321818] Data abort info:
[  187.324701]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  187.330207]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  187.335278]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  187.340610] user pgtable: 4k pages, 48-bit VAs, pgdp=0000002084b71000
[  187.347076] [0000000000001f00] pgd=0000000000000000, p4d=0000000000000000
[  187.353900] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  187.360188] Modules linked in: xt_conntrack xt_addrtype cfg80211 rfkill snd_soc_hdmi_codec fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_descp
[  187.406320] CPU: 0 PID: 1117 Comm: tc Not tainted 6.6.52-gfbb48d8e2ddb #1
[  187.413131] Hardware name: LS1028A RDB Board (DT)
[  187.417846] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
[  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
[  187.436195] sp : ffff800084a4b400
[  187.439515] x29: ffff800084a4b400 x28: 0000000000000004 x27: ffff6a58c5229808
[  187.446679] x26: 0000000080000203 x25: ffff800085218600 x24: 0000000000000004
[  187.453842] x23: ffff6a58c42e4a00 x22: ffff6a58c5229808 x21: ffff6a58c42e4980
[  187.461004] x20: ffff6a58c5229800 x19: 0000000000001f00 x18: 0000000000000001
[  187.468167] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  187.475328] x14: 00000000000003f8 x13: 0000000000000400 x12: 0000000000065feb
[  187.482491] x11: 0000000000000000 x10: ffff6a593f6f9918 x9 : 0000000000000000
[  187.489653] x8 : ffff800084a4b668 x7 : 0000000000000003 x6 : 0000000000000001
[  187.496815] x5 : 0000000000001f00 x4 : 0000000000000000 x3 : 0000000000000000
[  187.503977] x2 : 0000000000000000 x1 : 0000000000000200 x0 : ffffd2fbd8497460
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
[  187.562358]  ____sys_sendmsg+0x214/0x26c
[  187.566292]  ___sys_sendmsg+0xb0/0x108
[  187.570050]  __sys_sendmsg+0x88/0xe8
[  187.573634]  __arm64_sys_sendmsg+0x24/0x30
[  187.577742]  invoke_syscall+0x48/0x114
[  187.581503]  el0_svc_common.constprop.0+0x40/0xe0
[  187.586222]  do_el0_svc+0x1c/0x28
[  187.589544]  el0_svc+0x40/0xe4
[  187.592607]  el0t_64_sync_handler+0x120/0x12c
[  187.596976]  el0t_64_sync+0x190/0x194
[  187.600648] Code: d65f03c0 d283e005 8b050273 14000050 (b9400273)
[  187.606759] ---[ end trace 0000000000000000 ]---

Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index c09370eab319..c9f7b7b4445f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
 static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
 					 u8 preemptible_tcs)
 {
+	if (!enetc_si_is_pf(priv->si))
+		return;
+
 	priv->preemptible_tcs = preemptible_tcs;
 	enetc_mm_commit_preemptible_tcs(priv);
 }
-- 
2.34.1


