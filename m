Return-Path: <netdev+bounces-252613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMbKN9jdcmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648B6FA97
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F3793074737
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9A36C59F;
	Fri, 23 Jan 2026 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EkqB0K4i"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DA38946E;
	Fri, 23 Jan 2026 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135097; cv=fail; b=tvMYvZ24/+2KhU7AZlTvjN2OhxqqgpC7BPmCprgg4JTDgHCXC/TshxWhV72jAD9FtDSXL+RHq+rMZDc8KiNkbxOGLtDRrPQx2RXbjcIajzuDJw5fJXjOyrm3xO10lwPoOPrk3wDg9mBNSo6gE6p/jJLFgJ35c+PSgqB33pgDUVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135097; c=relaxed/simple;
	bh=p1eGHM7lpN9ym3Ozi3DwUxPhsNVsEdryk2unUxrP6Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4alhAOK/HbkcD2CC7LIrnIuzIszUJLAf7eMu7sd1T6afEbAyHJzFlz2/dvzQBBCHJHGSZk6jZu/jsxNerYdzz/rJ/g1F3LNL/VgtnSGbmiU466n34WLs+0keN+47u9OWLulY+e9y0HTYTMASIwDgT1LmGQ4I50XwxDz9YUAUAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EkqB0K4i; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwSNE2K97b8a6qD2yxoKF28b7faPZHvXIdWPxXYWFX2Qg4P73bklXPldT3eyBpeu6BT2rDPB33NeVr9j9deLrjJGV5KbgMEqtDQx33AafELhrtJ6COuyXYV2ze1qfoJ6qiBd9IT6MqaKehsse5f5heLNO9vmtmjo0aUE9NgNrVBNvlfkfuS6c8YZua3YLQN2KjGHx7csRMHTqOsykSmbxMqxyIihkNpRkHfai869XK5N5d2adxmrZo1L3O9RVISlwwI4s6PUXlA3H6KWi4xMcI5YoJGtmNtuTFJWwPN2bF0J/FuWx0YXxI+kRG34pDhxQGgl2P52UXGbzrf2cNox1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BrAGMnDthBj7sdLDxycpQbG/fzuiWC1joQos3OkrDQ=;
 b=MFYmi6jd1KDVzxgivVRwlxA0KGmOdLWevIMmmdh/3VA3M3M5uNiMRgtbLDr/VTKliotX+3fPP0Qeky78kjL0EX6LW8oJoVbsLQJHT6KW00oW7kMf6ybNSMCTUejcGg38qeEvQfOb0Z0l3oIgsH6ruVqKy9QekhxE3Op3AS1PhjVDlCpAXAJR0HwJFnH7psKoPa2lwe9ACqxFPSCmUmZfVHEakn8glH7fj/yKFHWYbJLutcIIvEmiTaISWV0BT7EKKsM4AwZabNebQ5ALhpLLM9DqpD+OkF/AhOjLpD+lc4+yE0UKK5AVPn+p+ncq0EPhyTEWZWUaDEypldtOK7F8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BrAGMnDthBj7sdLDxycpQbG/fzuiWC1joQos3OkrDQ=;
 b=EkqB0K4i3vCOWze3kByC6fXlTSidYSCWvFyqAUBo+CvlH+OmF474Kbh4Kqt6WJsh5rjrSRayGPczjDDAv+/qsvzWE9VwCyGkfe+Mj4FI1PvcQIU/cHyLSvB5s3PDXkJWztYSvh/1RUZ2ogSF9EW3Hf4Sv3vfZtsMnPZBptcue3FO8YnNSCJCioQAyeh7xuhPpp8eOLCa659EggmWoNc8eBXEz/HGGD5SQntr3rV0mGs6rrzbE7Ggm8FZQPnA3LowMoXbm1pUbTYPzyJz9426xgqCi+5FCKA8Mg6kKplqbQoI0xT56FqbgVqaLt5oVgsDqcaSsj4wwbMFN7CZYc0/yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:23:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:23:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 14/15] net: fec: improve fec_enet_tx_queue()
Date: Fri, 23 Jan 2026 10:21:42 +0800
Message-Id: <20260123022143.4121797-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: fff07e5d-5bc2-4756-6993-08de5a26590a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7EIqNZEjlKQniJuNwFchY6XViAIxtoRsNIpKInIcVKBbVVJM/4fY7Fazj42?=
 =?us-ascii?Q?vTM8pdbsksmWNX9iLPuLgF3qmSgpLZAPcCBECUgKbmHtLg/Q4vt2KpG4b5yx?=
 =?us-ascii?Q?U5v6aNqrH8a8q8plxWoiSlpq1OmQjdv6CxA/6BSPXkbeCuSODuUWUxKuEocQ?=
 =?us-ascii?Q?ofJ+5fKRaG08z1e9jV7p/ekc8D9XxzI6sGmBZj2BRuXztBxZ4Hb+xRgjGMTo?=
 =?us-ascii?Q?hKTwDw8hYFVuxRxndW1xx48h5PTwscZNEkZanvG34aP4XHsFL7S47Gz33+1Y?=
 =?us-ascii?Q?ZidxeCk6v/yHkRCfR7F78jcdsxgXlEwvk3cZnvYPEA2U4/C4PiMlD6FgmsV/?=
 =?us-ascii?Q?j7y1HwvQgr2zldJaid7VWSpKgdbZyEfy/7bzBs2NBfjG6pwVic8iknN5ci7x?=
 =?us-ascii?Q?sN4YZ+NRhxHbwRgZso3PxyXgj3QHLfk8cvt70AJulrTpFWCtLrWGXdCLEbv9?=
 =?us-ascii?Q?ZD9tJ9W4dx1GoGWaP38iXZBKgnXxPhIj9RVWerFEgtOR7BOwmE8zYMY7Y5NQ?=
 =?us-ascii?Q?uQ2cWD3UH5I/PLo8nD8nu/fC6nDR1viLVvG61DijVYOB++p0cXidY2d5h0Ju?=
 =?us-ascii?Q?Re4e8ubMkH7W0f/adMmeBRxc8k897QGVPaxk8xUaiHNdESOFQeh0okgp/v+0?=
 =?us-ascii?Q?75WR3m00uSPf09ckMEuByz0fubWKcOwjMh1GXNqxNeDQXDyM3qNEMrA1z5nx?=
 =?us-ascii?Q?CMK1/Jss86ac8s0xFZr7gYOim7glQt5RDuORzcp0TXXQ+IUUn3rMGTbaFFlG?=
 =?us-ascii?Q?FQI1R9E46SSUEAbYpHkMVbu5mKwZrpB5F4M9v9TurweSAOJML17mxubr7CxP?=
 =?us-ascii?Q?4zrjLAoSlkvPOc1eNEmPeijy4YqZz67/ym5iCidKXnfVayqWM9yklQ/9kmUf?=
 =?us-ascii?Q?Ganfce9L1szdMbHkw9ASJx6UgenL7cjHcV+Ld3SMRbRo7TKwRDsAOwYsNWdP?=
 =?us-ascii?Q?rblKb8NEj4UdvLzuh1qbO1GmV6Cj4WkdozXyAW15VYSDeJU221CNpvxgjkSR?=
 =?us-ascii?Q?Uc82qmisMM501IDuOLg78NHOH8XkQzoADaR8TxPA0s7kKqtFnViE14uF2p4N?=
 =?us-ascii?Q?3nzz+f/NRatuPxo0FvwaQ91F2lw8WY+cuFuESYQCmU/9SFUfzls9ioOOuJ/Z?=
 =?us-ascii?Q?ymjQGOnOnoo5KgOaD+DIQuzkbDVHmpnDNkh6ee+HCA3Z16Z7I6/bQy9ADE0S?=
 =?us-ascii?Q?LbW++o3cv32ohM8qgtNbUJm+ZcTslRRcf2MOrU4YXKaxPlHmlb6RbzZh45GP?=
 =?us-ascii?Q?zANBTNbwlKE4M+HaSFjN2QA85d4/nd4pKUAfN5jiZkA+e4m7PwH0ztySqFg7?=
 =?us-ascii?Q?dcaUFkTwC3clRkv9MWjRah+cCxQA627TpvxMm+xMzjQ5bTZhYvW4zIs+mXzi?=
 =?us-ascii?Q?dVD4l27elKgN9JMHSMR4+rOs7W6+syrK6o3WoWgiLXipvK0+ohiKME/gGQIO?=
 =?us-ascii?Q?kRb3lJ0Q/93Zw7pieTk7JQjz07gZvXAOyt9BSY5bPkcymWny9doCPYvkEqiJ?=
 =?us-ascii?Q?8I7HSNw05GzGyuPr3wRaWvB7elNWxSRXyK4NgnNp5+RcmtblZ/WWg7P+8ARm?=
 =?us-ascii?Q?NWcAuyDBef13a/s10K2I2rnAn/JPEktFbVHIQ2Aj5yQGoqK9IA9saHQWuVjH?=
 =?us-ascii?Q?/DR01Hyj9YNPXXQ/0kNoZOCNf9qor7mYF9atspTt6dLE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/duMlT6S1/KlVznkxbmoZkFZYApQVckMUiUSwX5RSne3a9DuFFtcorvrdIaW?=
 =?us-ascii?Q?4suVJzCgrrK5s8dmV7xzU7OWweI/ootpzy8k2Kgl959GZABAjvxP9SW6VidI?=
 =?us-ascii?Q?7gmWPeFPkP6gqHCxofWZbDWqXSjaAFE6x+RKriYLQPEXsO6eLM0wAzlQLv85?=
 =?us-ascii?Q?+IdvxncHDKVwkaUn3DfBelvFxd/rtuR6fHH1gicrNzu+q+fKLzRd6Nt6HuSs?=
 =?us-ascii?Q?fqHdoZvmq2b2Ld6WeI9re944AK2LK7MrodOzLJrAtjGEuSR/D2cPMgC6tV9d?=
 =?us-ascii?Q?avVHq7S7nQRW3vRwDaMhHhGb3KnzJTtHq1RONoOgihOrrYlk3+fIZKaFuxNZ?=
 =?us-ascii?Q?U2oUaJd6lSErD9ch1Ce+I2LPy8bBfh6MroQPuI3U3mzo/yIEDZ+3lpqdsvDZ?=
 =?us-ascii?Q?n+NDXN2TYqjxm+DtSKscFHwD2dnDI+sZSx0KbKUXF86YGdfrLVyD3+vVKbWK?=
 =?us-ascii?Q?hVPtzlLqE0nzUszRTrCB7Kd5lC0ia/DqGk1D3oHM17waz1tMgf7su9m9Uljr?=
 =?us-ascii?Q?KcKDrD8fWx+nTqQUIMtYiSGSy781rw2TFMifHevU7qiNwdNcrOdC6NriGO9B?=
 =?us-ascii?Q?F8aELDutdIVunptIu0Bs1Ftd6KcYYMpQEANdJFXFImVHhQTfN6lRh5a24qT6?=
 =?us-ascii?Q?WZnqGbWMzab03LX0AUM8z7RsECmYVuX/8DHqtSBn091glX7RaL+fz7EpDFJ7?=
 =?us-ascii?Q?KFJNP67cJEVvaKwFAxflbx5vtjrf1qBB2yeYSEJJ7khZgu/ccOvwxxPVNiWr?=
 =?us-ascii?Q?PaNyE8LNU/TZtgLDgpaWhbDgVP0W+w82wOrP4DFQYMozKNIoDcUIBaOusbOB?=
 =?us-ascii?Q?t3/DPo/xdSm91/P2ZFskxTawMDiWPEKGs7iOJkUQ6Jl/ksAxoQz/ThcKwXgd?=
 =?us-ascii?Q?ylusM1zBA7MZe7PVmYm7u8d9Z4+OhMcgq+5LhOL3vchMpgd5iz/QBDguhXGi?=
 =?us-ascii?Q?abXL2eIsQPdRzP/LrxDsncYjrvt3LiR3w0aMuPBPxDhuUxk5hMcrvV4hMzw7?=
 =?us-ascii?Q?uPQAuO7knlLJykWEGjhywhkK6Qt4p+oIT88rCWvs1R/tCasn4qhXnbJd+7AQ?=
 =?us-ascii?Q?XOtc5dcLec+Ai3LeSsi2nxmYGTENOTLZVWtQzEj5QSyb8nxlotxohqqJRoPT?=
 =?us-ascii?Q?o9lUuSMYHFof7n406SDCKyBmEveFmG9SA13OTz68UdW3Sj3LXZ2hzJzDKuM4?=
 =?us-ascii?Q?JLA2MhkzCFfGAoOZ/b892yYHqNt66cekhO9TMHqLBvKtus0YuaNAO3lv2Ubp?=
 =?us-ascii?Q?kUEDpGwYbRtzlTZKE7VldWynhsFfulME8bc+yjGneTbqU+y7HdJ5njUh+0um?=
 =?us-ascii?Q?rdY4l4lJDr+pX+yI0RsjA+kk84kkQbpmUFeH0AO1epDzMX8Wdi+rudUPFZJW?=
 =?us-ascii?Q?/He+GJrvFMq3VHBTO2iJm19uzw1sOTahg3pEAZZ4RenJW4csH55GmSaIATN2?=
 =?us-ascii?Q?nlRIhG7/UKcTz1+h6ybPldWXLmBZSM5/LhT2VEdtzTBby+U1m6pr1lJApVSj?=
 =?us-ascii?Q?SS9MjD6U7RloCbik1SkZFqOuTlkuAvhA9sHOjak7yTTxQ3iuHnDUkMaEKwz1?=
 =?us-ascii?Q?ok2Hy61KhhDY56d/H+8UjF4JrKwwXKGVoO8Rk1vQsah/H1nmSiG+/sC/V1b0?=
 =?us-ascii?Q?RP0kme7C4pktA9Ov8Hc7SAQPNd/2Le9rkLwJAr9deNe5LLGSf7sg3oe8e1n6?=
 =?us-ascii?Q?AA/iBrPjfSUaEcgHnarUU2jULIIplDTZpdSZUcYppy+fh9G2EAldGDtM1Ooe?=
 =?us-ascii?Q?HahUF0bUWA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff07e5d-5bc2-4756-6993-08de5a26590a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:23:08.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rg0BvIzlJidtvITZuBWBWYFb3MTkds/D4F78RaxaXpMqiqUcp9LkTdZlNcVxHxvmhAX67MqeBUy6gOIn86NjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252613-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7648B6FA97
X-Rspamd-Action: no action

To support AF_XDP zero-copy mode in the subsequent patch, the following
adjustments have been made to fec_tx_queue().

1. Change the parameters of fec_tx_queue().
2. Some variables are initialized at the time of declaration, and the
order of local variables is updated to follow the reverse xmas tree
style.
3. Remove the variable xdpf and add the variable tx_buf.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 43 +++++++++--------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 867694d6d54d..c19ae60b04d7 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1467,27 +1467,18 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
+static void fec_enet_tx_queue(struct fec_enet_private *fep,
+			      u16 queue, int budget)
 {
-	struct	fec_enet_private *fep;
-	struct xdp_frame *xdpf;
-	struct bufdesc *bdp;
+	struct netdev_queue *nq = netdev_get_tx_queue(fep->netdev, queue);
+	struct fec_enet_priv_tx_q *txq = fep->tx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = txq->dirty_tx;
+	int index, frame_len, entries_free;
+	struct fec_tx_buffer *tx_buf;
 	unsigned short status;
-	struct	sk_buff	*skb;
-	struct fec_enet_priv_tx_q *txq;
-	struct netdev_queue *nq;
-	int	index = 0;
-	int	entries_free;
+	struct sk_buff *skb;
 	struct page *page;
-	int frame_len;
-
-	fep = netdev_priv(ndev);
-
-	txq = fep->tx_queue[queue_id];
-	/* get next bdp of dirty_tx */
-	nq = netdev_get_tx_queue(ndev, queue_id);
-	bdp = txq->dirty_tx;
 
 	/* get next bdp of dirty_tx */
 	bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
@@ -1500,9 +1491,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			break;
 
 		index = fec_enet_get_bd_index(bdp, &txq->bd);
+		tx_buf = &txq->tx_buf[index];
 		frame_len = fec16_to_cpu(bdp->cbd_datlen);
 
-		switch (txq->tx_buf[index].type) {
+		switch (tx_buf->type) {
 		case FEC_TXBUF_T_SKB:
 			if (bdp->cbd_bufaddr &&
 			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
@@ -1511,7 +1503,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 						 frame_len, DMA_TO_DEVICE);
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			skb = txq->tx_buf[index].buf_p;
+			skb = tx_buf->buf_p;
 			if (!skb)
 				goto tx_buf_done;
 
@@ -1542,19 +1534,18 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			if (unlikely(!budget))
 				goto out;
 
-			xdpf = txq->tx_buf[index].buf_p;
 			dma_unmap_single(&fep->pdev->dev,
 					 fec32_to_cpu(bdp->cbd_bufaddr),
 					 frame_len,  DMA_TO_DEVICE);
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			xdp_return_frame_rx_napi(xdpf);
+			xdp_return_frame_rx_napi(tx_buf->buf_p);
 			break;
 		case FEC_TXBUF_T_XDP_TX:
 			if (unlikely(!budget))
 				goto out;
 
 			bdp->cbd_bufaddr = cpu_to_fec32(0);
-			page = txq->tx_buf[index].buf_p;
+			page = tx_buf->buf_p;
 			/* The dma_sync_size = 0 as XDP_TX has already synced
 			 * DMA for_device
 			 */
@@ -1591,9 +1582,9 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		if (status & BD_ENET_TX_DEF)
 			ndev->stats.collisions++;
 
-		txq->tx_buf[index].buf_p = NULL;
+		tx_buf->buf_p = NULL;
 		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
-		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
+		tx_buf->type = FEC_TXBUF_T_SKB;
 
 tx_buf_done:
 		/* Make sure the update to bdp and tx_buf are performed
@@ -1629,7 +1620,7 @@ static void fec_enet_tx(struct net_device *ndev, int budget)
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i, budget);
+		fec_enet_tx_queue(fep, i, budget);
 }
 
 static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
-- 
2.34.1


