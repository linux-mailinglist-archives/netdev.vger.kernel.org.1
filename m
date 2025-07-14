Return-Path: <netdev+bounces-206689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2046B04135
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB17C189B832
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B02586EF;
	Mon, 14 Jul 2025 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QPunpGWS"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667A257AC8;
	Mon, 14 Jul 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502494; cv=fail; b=O7Q9ykks1LgFYuT6k3rw5M8daaU/YM2o9UlqJTrQTAdRmjydbGZmGtt30yBSSHNddy5dbucUrd2/w8o0hX6nMM7BfEqFrImGymBZlcZGSwLhNl9NHEES2dSa17yUiL2y5MZMQ7XPJGFH2MdF2pLCPbBiaMBWd8IsIBPOmmuufDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502494; c=relaxed/simple;
	bh=CEez+32NsI0cgfoc/IEfybxVWDAYPvjIlLDZv65+Ksg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gx3LJC7rcFXwY6pRZLZ9zOZDOIKl9OuJiN0g0yqxUR5r8U6UjCmhabi0J22VlkU6cnHRKc6Liee2mIXazRvaI/pJcq16kLXVNKNuBxrTV+B3OMReQIRQJJu/SykTuuNBvr6db8H10aJpmRbcQcdPEfwJS1RoY0mPK42k8whul3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QPunpGWS; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITWmMrmIBejRaI5HfP7FdGXNVsw8cxeviII42FDzvI4rXSe4MI1CFXv5G4wWyVr5N29k8jHnEXQHC1Ne9o4efDP74us1It+SyeATgK1VrijmZp4WZSitNNFaKdQVWtdfbaQC/E0xdH2rspvtgn80T1J4MNBMDRkTaEux+GAiZ8dfv5BqMdFgtjS735sW2PCklSv7PeuffZimZ1ulgWIHUhD5B8BmzovTJ5SqX7miWBrb77TCHn7G5pldyd5ghJSewpjZ+RHVyz8o6cGdqRgg1bRRKGhL/ZvBburU0/4m282zJth5t66fV6xrJsod5jWPWjmFRKy4hHEk5KdSniPwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC0Km0vBhIqB3OH24EGG0gEEZ+IGZwqVeOkQmzdnl5Y=;
 b=hj1v82F+v2K7WwTQc8mDlKe/Db6glxONem/wWYrdVluSO5Cfa1gRcYtucNs+UzMpRmuitAKYz0ofHZ6RPQIsQ6G63mRxhQNOU2MF3zHAoLON11t0WQeJdsGmSr0kd9q36A5WxWWVWZUBnMPb+XZbZIVXINxxQKFHiUgGo6Kn0HvGTQBG7TFIVkp33/ZXrEauGBAuVfMZ8yhPDvROsUuB3L6tnk0DGAw9eXBzHPfFhOXbmFTii8qaKt8O9Cb9yLa6fggYS7sJFY/QCH3OlMd3i3WqYV1AjaA3WzhPAvCUIqw+XiRarKtwjnzLAX+wCcA8mngGI6sTm9wBULsnPlq4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC0Km0vBhIqB3OH24EGG0gEEZ+IGZwqVeOkQmzdnl5Y=;
 b=QPunpGWSuRGDenUJ+965gHVm3DHqNHNIpfLHb2Ze60kipNj5PttYjKsQnmXj+9YPITDNrlZhT9K2keUfs7nuQiwc/VVAK78nWEto5570RfjwjWJ+YI+W7aw3BlDyjyd3PTqUrA1SGQ8bnAjXyMWC3oWpuSEu4LYsFKJTz3lB8W32xAujZMjQ3BK2wDQnvTNYcmMGbzyCKBPEIZyy/ulGL//cgpr55U1gZuv2tM4kBXKx37/UvvPDFmCGSNP4lMD19J2bVRdVltr0QQjbLv1ZruExoTIZrWhSqnFTCjfFKm4EkDik/nAWq1G8dVDv30sa77Asjdn5ypfScFtrxnkPUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9484.eurprd04.prod.outlook.com (2603:10a6:20b:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 14:14:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:14:48 +0000
Date: Mon, 14 Jul 2025 17:14:45 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Message-ID: <20250714141445.yykvzxmmdeicsmsl@skbuf>
References: <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714135641.uwe3jlcv7hcjyep2@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714135641.uwe3jlcv7hcjyep2@skbuf>
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a99cc5b-a0d2-49d3-17a5-08ddc2e0ca8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?chZK5WjGtB6XtgiJHrq81pEvTfTTDCccjk29JAVgPz8HvwlIeMDaSS4xQKWX?=
 =?us-ascii?Q?YvzJEnXLcQ+6NUOicv0T1iWCBigaK+xYjqZVkgS284r41uM6oEmuPXoR3lj+?=
 =?us-ascii?Q?UYGo8hqpBswFpAdVqA2quXvx1hheOByn0EIZLl+W2mcRSnSJUMWQeFhYTcG/?=
 =?us-ascii?Q?EiGx+pMsRU5x2Al6KjexJ97kqplJYni8jvkirdY/Wo7O/SO292HXPGAAb4p3?=
 =?us-ascii?Q?DvIyu3rngPKYmQQ3VM1Vv7WH7+qf3+KeQkXYsTTrGwzjJGWj3mgRoswlT2up?=
 =?us-ascii?Q?4HQ2uecPh3O2pWaqL159m+B1NX3A6ftxdodFSca2ie04WDb5dq/8uy1MH2l9?=
 =?us-ascii?Q?x35vhferz4N0p2aJrjsP/aCsjWt/Fq//r0RqIFL1Zr1nElSmbqhEcgLglyib?=
 =?us-ascii?Q?FZL1Jid3WYpyWa33m2hf+padfV/VFmwPjE86WpZ+EkrImFnHTR+3UWYb5RNr?=
 =?us-ascii?Q?pMjU2RPdTeNg1Q8YV658M6/GK3cHJK8j7o4ZS5SX5ZmEhKWqShwLF+eez37c?=
 =?us-ascii?Q?KmtRyLTikwkTvNGCDfStGc4Sjiuzsc1z2PEBXHZcbQWQfYSbR3sYpqTUcZA3?=
 =?us-ascii?Q?rmChyPCXbAYaAQdHBpa3uf6wx2B1O1/89NmLvC49XCiU5aJeT2wig+kk5H5S?=
 =?us-ascii?Q?yvegubisTEp3wPmyqztEb8ioPsgihRCAdP4DMOm5E+A3YW0utUzm+cx5uP9O?=
 =?us-ascii?Q?wc5cJBCR8WF0NbL+AShfGHIA3Pm77tt/E2k9YG69XSdZ3VKvM2Otwtv22MR6?=
 =?us-ascii?Q?n3xPVE8wK8axRB0LTuon8Z8i5zKsKMR/+K5+3KrCUqYZUcEf7TLcuClYZtoT?=
 =?us-ascii?Q?mukJfPxgCX05psM10OF8Bg2jPJZ7Q5PYyvz/XFcyKZdWXmjBfPpFHF9hKxfq?=
 =?us-ascii?Q?np/SjJEJUK1viIN0b5hE9/IsOUZ3hO1BPdhhGkBFfj3fHTamyNERPhMq08Bw?=
 =?us-ascii?Q?uqIkLPYZJcM9TbTYxWJ2VG/e21CdGSTB4bOUXxgmsVZWiNsSORBsOT/zCwzn?=
 =?us-ascii?Q?XZ9ppIiaTFXKL8FtBZd3BqpgwbtGZIqSEz8IMUIOWv/1p8O+UeChS+OcUGKJ?=
 =?us-ascii?Q?jQ+f1jrd3sS74K3+HLBOBK/ohhQeW1181SZkd2XnEVuKmFZBIi/6mONhED2E?=
 =?us-ascii?Q?eTK4T0q/uDFMrOrGL7NLfDtpqP0Rf7yQamWJNZIuH0cfDLd7mvFubTU27wom?=
 =?us-ascii?Q?HhfUe5zSNJRMJ4a+eFH9sBiuiRf6K8xkisFd3+jVv5ZR0bFJ8kxxqhGqlZnM?=
 =?us-ascii?Q?jkX9M1ciuaX8kYVcvUsECSQ7SUUCx9mp37ooe4FFvFZ7sEqAvgDdgyIP60fV?=
 =?us-ascii?Q?SWYmt8dzkLVC7agPEr4UofZ20Gjx+KZqKhxCDn1vUdF4lURx/Ius0Z0Nt9my?=
 =?us-ascii?Q?WNRGi4abed/2ymImi6jEcQRPsVqMar2qj+gpRMrygrGzClyR7Pm6coCeFrYH?=
 =?us-ascii?Q?bpLuefig1eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gxDKJQUutZaNk3dqiBj9EmCBrWPPcReoYbCyQAhXsAVU/TnaCVPwY8zQ13We?=
 =?us-ascii?Q?oUDfX7tzHqFrscJUfi4p+nutWDeaS5KAZxFLQAkQSTyZGoCXvcnbkJg3Udnj?=
 =?us-ascii?Q?aM1wSlEC3PlAOPvD9pRqaYfsjoi7sMmFT/oemtNjbGGntVuA2NowsmRI3YdD?=
 =?us-ascii?Q?rJRUrOXhCukyxUDwl19KiGGujX+tuGkrjiHqK1uOeKP7SUOJvce+nt55kU7V?=
 =?us-ascii?Q?KYMSB1QLqvge7kDRHNX4c5vt7YoRDVY493y8LAzXBvq2QA7e0H0IrLPKklao?=
 =?us-ascii?Q?oTzAO9QO9A0f3Elk6uleD503F9++sFf/ALzwltSvTrsEqgoVDSTfGXiwW0Ze?=
 =?us-ascii?Q?A97BHbFHEEDDTxAiBNjhzmXjgUmiEotXAZidid8vU8c6kgU7WQlEkGLDMqEC?=
 =?us-ascii?Q?YObCUEl95Lk0dLQFuXyx2zEyFbEmIpqFIQCnUfBDIOhqKsRvj+QVGecqwN/4?=
 =?us-ascii?Q?pv9S4iUBNPiH91JjZmQTvJe6nb4CAF08XUjGu6THTNZEWLD6wUVYbeltJSvx?=
 =?us-ascii?Q?A/48gshFPvU0cD8Rya4cxaMtQbuBO0rSfNOMQz9Un0kBPJSKwxa+ZYD2ygNg?=
 =?us-ascii?Q?0EggxroHE+De2Zur/ngqDbI3f2rJDuT3dBFoaCPv4/aqLbs+Vxk05/LZOCLj?=
 =?us-ascii?Q?wLB7PD2U/aOuVZWni84Th8paj3qai+TD1c89VKTt4AJTSgb/7dC7Jf2VWX/M?=
 =?us-ascii?Q?yjl8W7KY1G8VOxSuXUibcwZotYDu3aKQHM2PtPLFBnIK08p8hMEE/gw/CEbu?=
 =?us-ascii?Q?pal1u++hSHq22gwhhUuDmKTx88Mm79DfkYN0o6DsnWs6lql8FWEbeoMaY5Oj?=
 =?us-ascii?Q?9xubA2GEabrZFqRlFsUIyunjTpmui24MQ8QwmgwUfqYDfFRqmsaMpuLedxQO?=
 =?us-ascii?Q?gmEq+/tGPc48r+ZYLugI7RCgZeLGhUfVTOkvXdHtZxX17qNbmHcCyPSNiDJW?=
 =?us-ascii?Q?n2Iz1rnjgP0lR2RqmwAJnT7wsB3EHUA/HPnX+Jc3Hy9AfxHdWQ3O9fFymRPx?=
 =?us-ascii?Q?MhD7/0sL84XJ/xFr6LXsXuJMwGVlblYmYjFAmdwsntVyrXGli3SN6zzcChMn?=
 =?us-ascii?Q?YJ8IdDI/A4t0MjmDaWMcQsBKt+gF8+GxoN4i4eBMw0+RL41dwhshreIrNbaM?=
 =?us-ascii?Q?tyt/XT5+Zfkc4YNuBSGrKNVfgWYh7KMo44Cb4IyRiryeXXipofylStqe3XLk?=
 =?us-ascii?Q?apkF4GfySUNcxGZbX41m2tObqT+iTjUlx1WL746TCGKW1YB0PshWieE92llD?=
 =?us-ascii?Q?w4K5HZsTU3zfMMekGKKqLEYsnj7XNLwiOZPQLPcKRNKpNiz1gYhpzWlrKwVZ?=
 =?us-ascii?Q?YE1be+VIvEK16I4uiTvWiWDfNEzHduUsBtdTxW7PzLEPddB3F0PFbw1KGHLA?=
 =?us-ascii?Q?fU2Xv7YCXYuBJOX/DOHah5myf90AUMzsyir7wtu0CE/qRKOb/d5LbSCB17fd?=
 =?us-ascii?Q?t2qfuzfcUQKEXHtIb1VqNcJFNqJKS6ivW/8u3pb2WMgRKMtV1OUYeSVaRfaj?=
 =?us-ascii?Q?zADTUDIZ0fb4cJ4YZLX9nqHqFo+Xu8bcuxp62T5sv1kHLCQqiEZxqtNQiMLd?=
 =?us-ascii?Q?Cqs5cVinSYAwTlt9YW228k9AcEIIyAS8nAsSruOrcaQZhxW3W9hMuNb03FWL?=
 =?us-ascii?Q?BBnv62tetwbx15A9y6MqQagHDh0lNGZiqYTFzDI2nP2rpH7iof0wKJ97iLAt?=
 =?us-ascii?Q?1GvMPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a99cc5b-a0d2-49d3-17a5-08ddc2e0ca8d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:14:48.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61Q+fRmXscdDwmM7AnVzoOIKStrfnKQCbDM8dls/Kh8Hh3XAHM4XPuBki4bTS+62HPLjfOBBAIthbyl61Cx2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9484

On Mon, Jul 14, 2025 at 04:56:41PM +0300, Vladimir Oltean wrote:
> On Mon, Jul 14, 2025 at 04:22:51PM +0300, Wei Fang wrote:
> > > On Mon, Jul 14, 2025 at 01:43:49PM +0300, Wei Fang wrote:
> > > > > On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> > > > > > I do not understand, the property is to indicate which pin the board is
> > > > > > used to out PPS signal, as I said earlier, these pins are multiplexed with
> > > > > > other devices, so different board design may use different pins to out
> > > > > > this PPS signal.
> > > > >
> > > > > Did you look at the 'pins' API in ptp, as used by other drivers, to set
> > > > > a function per pin?
> > > >
> > > > ptp_set_pinfunc()?
> > > 
> > > You're in the right area, but ptp_set_pinfunc() is an internal function.
> > > I was specifically referring to struct ptp_clock_info :: pin_config, the
> > > verify() function, etc.
> > 
> > I don't think these can meet customer's requirement, the PPS pin depends
> > on the board design. If I understand correctly, these can only indicate
> > whether the specified pin index is in range, or whether the pin is already
> > occupied by another PTP function.
> > 
> > However, these pins are multiplexed with other devices, such as FLEXIO,
> > CAN, etc. If the board is designed to assign this pin to other devices, then
> > this pin cannot output the PPS signal. For for this use case, we need to
> > specify a PPS pin which can output PPS signal.
> 
> Ok, apologies if I misunderstood the purpose of this device tree property
> as affecting the function of the NETC 1588 timer IP pins. You gave me
> this impression because I followed the code and I saw that "nxp,pps-channel"
> is used to select in the PTP driver which FIPER block gets configured to
> emit PPS. And I commented that maybe you don't need "nxp,pps-channel" at all,
> because:
> - PTP_CLK_REQ_PPS doesn't do what you think it does
> - PTP_CLK_REQ_PEROUT does use the pin API to describe that one of the
>   1588 timer block's pins can be used for the periodic output function

Just to expand on the last point, maybe it's not clear enough.

This is how the Felix/Ocelot switch presents itself on LS1028A. There
are four pins with unspecified functions at boot time.

$ ls -la /sys/class/ptp/ptp1/pins/
total 0
drwxr-xr-x 2 root root    0 Mar  6 16:56 .
drwxr-xr-x 4 root root    0 Mar  6 16:56 ..
-rw-r--r-- 1 root root 4096 Mar  6 16:56 switch_1588_dat0
-rw-r--r-- 1 root root 4096 Mar  6 16:56 switch_1588_dat1
-rw-r--r-- 1 root root 4096 Mar  6 16:56 switch_1588_dat2
-rw-r--r-- 1 root root 4096 Mar  6 16:56 switch_1588_dat3

And this is how we configure one of the pins (here, 1588_dat0) for
periodic output:

# enum ptp_pin_function
PTP_PF_NONE=0
PTP_PF_EXTTS=1
PTP_PF_PEROUT=2
PTP_PF_PHYSYNC=2

PTP1_CHANNEL0=0
PTP1_PEROUT_START="0 0"
PTP1_PEROUT_PERIOD="1 1"

PTP2_CHANNEL0=0

PTP3_CHANNEL0=0

echo "$PTP_PF_PEROUT $PTP1_CHANNEL0" > /sys/class/ptp/ptp1/pins/switch_1588_dat0
echo "$PTP1_CHANNEL0 $PTP1_PEROUT_START $PTP1_PEROUT_PERIOD" > /sys/class/ptp/ptp1/period

In the case above, it still depends upon system pinmuxing (on LS1028A,
that is handled by the RCW) how/whether switch_1588_dat0 is connected to
an SoC pad or not.

I was just saying that _if_ you were to eliminate the use of PTP_CLK_REQ_PPS
from your driver, _then_ the pins API should be sufficiently flexible
for the user to select which pin is configured for periodic output.

