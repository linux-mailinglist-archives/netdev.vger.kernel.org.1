Return-Path: <netdev+bounces-208593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FACB0C3FC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA7188D13B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BF2D29BA;
	Mon, 21 Jul 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQi7UIeK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2942BE026;
	Mon, 21 Jul 2025 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100448; cv=fail; b=VfgDdqJCZz1lKXWOerCFYlbMFpS9K/tOB6Xaau+1y+loaJuvyM2kzuGw28sVWdQvr0VhWwy+qROiISkrI4tDwiTok6RNKbyARqebnftGJw+XXMKweoFjh/XPIHzA6rusYGVnUyHDVYQyQDSSitR8wLeh6Lc06w/w/L2T+hkOJys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100448; c=relaxed/simple;
	bh=PELtoaULHM1neNcXmc/t7UQqw2mkhV6XtBsbH+O/vPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HLmPCgM7yNlqy8STG3ZQqpJXhcqbbXzKnT7ZPxywhsce1VFXa0qVPG2oSL5CyarX14LtzEAPixp+yRGdab4TeL9e2V+zkKt0C1Q0F7WmM6xJIonrNHAeOLd1dcQaCI/JEat1Dz/iYDc7CiYj8QBOhLkmU8+ts3ys4YjIECfT3U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQi7UIeK; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glYojiX6glKthSrQ/Xfo5QpFWhPKggnXJ/81ZM0vT0j1XeqagTVnu19z2733Cf3J203KEeOyA/F0C6c50lsBOtm/Bc1hnpkj102VTkuy/U6L78cj4R3QP8nY14G7esWfw/LZnRaO9lMIjI04R6X2QZkgivEewtJ7Sf+t3sdT+Sy6VSp10uNwRvyRoKJZWSucWnUwE/7jjy7rsmDX4rwkQ6xraAhfCSKfQ7t4w4XmxH4VTbp33dPOpWIG5sJE6zHtFcs46X/ZmnQ1wt5U4+w5/UmNyQ3Bipyt+pZp7HXBKTVVTEEDtC5voMv1823GJVEukgniRkw8AKG2ieNVucUYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELtoaULHM1neNcXmc/t7UQqw2mkhV6XtBsbH+O/vPA=;
 b=PcFsFW/IUp63DEPKH6Uj8mI9fIuhQxIHn2KRMzbGsPIRBCCQNzh229hwBuuAk4bWm0gCF+XSgFsXiRsjXrqTTMIPySciiVNqibW6SUCBvZEhxtHBeWauw26nB233GtwSPGJEHRuXn9ozNEkyRTZy9bRL7g3By9f6YTxBogFZnqOnM19egXaenmRT/ppORz8eUIdDLK9hnXKBQwyDLVNG1sR0qPXpOxDRcH1JR3OSpiBlv9dTh2h1DpIVYVlQplMA2Vvx+PV2iVu8eghhHKLBLgzb4PbybA4BNt1T9LEEkJvcUHA8yo6iMhYYka9pJBmHJCOUKGCgIc3ihWu/QNEGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELtoaULHM1neNcXmc/t7UQqw2mkhV6XtBsbH+O/vPA=;
 b=iQi7UIeKgiLxtIti3ABYyaaW/YeTAc22uGE7Bl6BUiIGf+TYGZE1FZMeXvNrv9elj+3qNxSP/YYdiZ5z6i//rDknTUmzoithPuVR/asXbEFsB1GybJDchZto78YCG8pgwKTWfZJfkMysJYNZaM6ap40R3eeQXRs/vcki39VDPvfsFJ+jTtNIK6EpJTkWisUxGGb1buSIR8FOgVpbDBMETXVhjVbhFTEwq63dvHYOGuK13+msGj6cdB+/Hsh28uFE2oidVtqaADnsohlOnjKINgS0K2VaCVG8e7xw9c7ufDIz8W3xj1fgqg7GCPvaiU4zXQQ4V15i2wt/PZDQzHx5jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10185.eurprd04.prod.outlook.com (2603:10a6:102:401::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Mon, 21 Jul
 2025 12:20:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 12:20:42 +0000
Date: Mon, 21 Jul 2025 15:20:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250721122033.3pszhnhqtgs2swt6@skbuf>
References: <20250719124022.1536524-1-aha310510@gmail.com>
 <20250721083011.zesywxhisw435g73@skbuf>
 <CAO9qdTFwFpQh8O-sQuLDXj2eH7L_yBGTk6jdinZVGg9ShQtssw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTFwFpQh8O-sQuLDXj2eH7L_yBGTk6jdinZVGg9ShQtssw@mail.gmail.com>
X-ClientProxiedBy: VI1P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cc8d5f-e8c5-491c-5b02-08ddc85102ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAIS5xBaVwsaCYQ0WHJTYNww2D7rCfdaKSOO/GlnbjqUKT6Z3anT8orvt82e?=
 =?us-ascii?Q?TZHq6gSGhrrbx48tj7WXjMzu9gCetrNW2iCk4UUKy/cIja31KXGNf7yqPdpm?=
 =?us-ascii?Q?1jvwFSHIaw4jkDM3ZOHs3LS12Ggy+t4Q1NUCP/hcE5MrWw8wNTCDunBe9hKP?=
 =?us-ascii?Q?9/Tu9viYWr3BCfQk91piRmBtLfmtigCokctIfgyHXg6JgHXi0vZZGHEeKoMx?=
 =?us-ascii?Q?8GJhef7Bmu/Tid4K8lCETvQ4bPLPMqFeAFvNkDjhuWCrMgTZX0lNSY5yhXxH?=
 =?us-ascii?Q?yWaz4vvnQhaUmMJz6YIHJlq5L9eixAVyX+ZSfc20hILsDEK9sfrAc0eat/if?=
 =?us-ascii?Q?2MT2HHDuZE8VAfhqx55CHkWuZ1JjeJYmt2Ih9zk1n2oZquXN6bmIFb3Kz59S?=
 =?us-ascii?Q?FM/6xF+Q+9VfcC2OYgni8RHeGC9NMiuc3TOo4V2DMeGctPSlV39e8tj0/lqc?=
 =?us-ascii?Q?lLU3Jyi7YWoXAr10XtcDm+IT8qBGmQszCsZabJ/KQdpKWoQhf2iNt1fhpVNY?=
 =?us-ascii?Q?6PaJNBkhEfLPqY83EGFA5vbHDpuk8b3POauF4gRzJY8Y8YaHN/bobd1WtXWY?=
 =?us-ascii?Q?k/eZjcOAUXYuIqGSE3W4et2K03P9T9QX8JxGQOcwojFOIvO1yuaHOli/RF7A?=
 =?us-ascii?Q?Wrfe96khoSWV6djuD78aQnRGR07AOKyHq/XeuSa6dM7dwDLcuNxoiSNcTDV8?=
 =?us-ascii?Q?zowoX2aZ0bT7+MyhMIrzOalc12HRZIlgQo/gb2Xlx/PXg87XkCyUVdQpbmK9?=
 =?us-ascii?Q?o1msEo4kT+PL63VWgE7VsUhs9bQeOziPbxIMkXijRpEMOEHJy43SGPuvvQxQ?=
 =?us-ascii?Q?w34Grf468e6Vcq463LdlZF4D/h5K1o3KsAJ11uZS/HpfP04o3tmQukyf7w6X?=
 =?us-ascii?Q?O8x2GS+Vvd/R5/SSQZp6GnWOTTkbv0csCne6qJubwdiOOiFO0EuQB78bohmI?=
 =?us-ascii?Q?0BaAxKdTBXOysG2HNsShfY5wzSKJKDqTUTT5tl5M16bmmJHgezEfbEaWXkrB?=
 =?us-ascii?Q?HErVRzm0i3MBDPE15gNn310Q1bxEZe3MXfCVxyi6feetAAfpAkKqPDUHzWxW?=
 =?us-ascii?Q?AkuFCaOESrRmgtTNNGy7qNj19zCsI1WW0qROjS2oT5++kbQJKjl4H75bFnnj?=
 =?us-ascii?Q?xs6cA9vK9f8TuXFzJRHAT0WMPt8U4IoNubdtCxUgZDpO3wowsj1w781l4daq?=
 =?us-ascii?Q?gRtSnkjj9FNUZax8azTFM3yQLZlVfktnbR6+/1jndV0wBRUWFgln+Gy8DX8y?=
 =?us-ascii?Q?aiyEjVxrlyCKd5pD1sZf754sc0RSGzp6YS0Zvap0HPrIACXylDMRnw+JzFJ0?=
 =?us-ascii?Q?Op638RYMDwwMDTbn6l7OkU0OyWC9sXGZmy+PE1xkmPZB2N/lyQYmUMV/dP8Q?=
 =?us-ascii?Q?5G1SMJl6PFo9yPDXtzghdPtKbZKrJJhID8G84/M9tTywbAck/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?shUyP/1vU6wo546Cg/AVJQsqoqHci4hR/FUknM4FGMFB992kmlTCGPmez3ml?=
 =?us-ascii?Q?gEXXbN3l9TGzNzpHbI3LjLF7lY+P6g731gyOp/jIYCWhu9IRV8Hc7lJC1UJx?=
 =?us-ascii?Q?LwfldoPB2eLpLY6+FNblMxHE/lJeI1QkI0HRyc9SYhciPlCpSSBxGVamWDyx?=
 =?us-ascii?Q?3jYVHZp/UttbSlgkZ9jrEoRowrk63ty42G0O81jdTPsdLm4+ufykliumYyfb?=
 =?us-ascii?Q?hfdKVPZyZxKK317KuW5DvCRFku5Rn0Jw+d0f6ydx/7PRP6uGrOBLAdxKzbVy?=
 =?us-ascii?Q?P8j5MIkT+1dTi8UL0YeL8u87RXSQ9lZ5awIqEms7gG8AwiSlfvhSb6lkm6Wk?=
 =?us-ascii?Q?sc7aU970nA+tBPe/Ce2J2lms/RryCMz8rYpGcwzaknTBfGLKSAJgxmLl+TSc?=
 =?us-ascii?Q?1mBvOygbvN8KslFVoC5lCipKDp2opCn9voMlG1cec1Zw5q1WmVpRZ6Mut5iq?=
 =?us-ascii?Q?WEeXHiKwiGSLjn27bZdu7CTssHGz5dBI/GKpnzSo8+5H7bi0J7WGDOn5HA+M?=
 =?us-ascii?Q?bilLxk2V2xo5+YGvZURxz3QzI66ws/GBkraWyojD1TcHnjZk9a8VErNQ+MRe?=
 =?us-ascii?Q?46AE9QLHGgHXceicbZ4GCBhlwkVTi0pajaQPMDR0TZDI8ZRqXEzg41XtQriI?=
 =?us-ascii?Q?k5aDqxLb6HJBCMQ55Pou6NUPSV/b92SvoQ2MQpSa4A0ZxcknJ9Idx8OeU8Bn?=
 =?us-ascii?Q?Vboc6cBSqwUjZ9AKbXJZZ4a8BnNerEkGVHpA7Z4g8HZouke3W88vLCloISXo?=
 =?us-ascii?Q?4bvDqoka8NYtLyLirHQNuKRd7imd0hjO6CXxgjKRSckZXtA1cQUdz/XNrW9U?=
 =?us-ascii?Q?sT+sayBdccNEHcO98qelYMhckTClHIm/c2rjv387dNGUqcvGZb+wJJK97L+b?=
 =?us-ascii?Q?Ki1xKtEES8l1Ruw5JSpk3Zg3oxNcLrSOgE5mT5JYSdL/ZTYuzsFu8cCBVMTN?=
 =?us-ascii?Q?lTAxKd9PJceyJn/YXo9iQ6vEy3BJDsBd7CAjYZcv9zHA7DrDp0siwZcdE5Li?=
 =?us-ascii?Q?52sMQrhlF1TuRjMjmIE7A8gqOs0YQS7cdtpL0/7NSbZfKpKEUhrvdAgCI0Hu?=
 =?us-ascii?Q?/YZ8JB600NVeuVpCPlcM1Xth4AJPRDq4dTSkHL3J6bOP29XzqJB+vPGo47wy?=
 =?us-ascii?Q?WhaoQjDMCUAskyTG+rPRt4Xf4ebHksdGcBMCTwI3/wnjuFzRslYE/raI8PBn?=
 =?us-ascii?Q?Op1jGAaLZRRvIpvmBMoVwmKH6xGjzAaERKmtg37v5jhpgRkkRcSQTAJ9xP9F?=
 =?us-ascii?Q?8EaZJWd+YcfzZiP+yTKP1JUPujAD9LuQzr+lNqEzf1KjYdVHl9FZ5CVnE8kF?=
 =?us-ascii?Q?yuP6Xl9v2K/AuQX8U4nev8YKq8F0eVhi2Nxrkgu8RArCkAbI+d1Afc3ZQo3N?=
 =?us-ascii?Q?tQwRFqVInwZiIqmDKpbh+2bFlVz9X8xy8VQeh7Tspo2JNX98Dz1HQTbZmVX5?=
 =?us-ascii?Q?7oQPeerEe9h/P3pRtvWfWeyK4omKLsF99oypTOJnBdnSe2Ro2vpgB0pYWLy6?=
 =?us-ascii?Q?mqVuASgTaUFKcgyAEgb6MNByitOWtC7fPyp/R/t+iTFFIOiLfekTqVPdb0tF?=
 =?us-ascii?Q?7FbRsMzMugGcMxofarwMsOBqIebEJ1/hdjy2N6IsXTrL6KWruwSGAz2Pkz0R?=
 =?us-ascii?Q?KuGljLa1OjPsFLsQnVvoAQbkWb4lJYjc1tC1FWJGF+EEpaP8gQX1tjOD6laS?=
 =?us-ascii?Q?FW+k6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cc8d5f-e8c5-491c-5b02-08ddc85102ed
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 12:20:42.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETA962JTQhKQWBw5BJ2z1oROnOPuyFYhgV49S3gF/Ak0HTeylN4qf4O12dAdf1qI8Xtpx7yILLKJHS1Vxn+pxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10185

On Mon, Jul 21, 2025 at 08:36:17PM +0900, Jeongjun Park wrote:
> However, I think ptp->n_vclocks_mux also needs to be annotating lock
> subclass because there may be false positives due to recursive locking
> between physical and virtual clocks.

Did you miss the part where I reiterated, in my review comment to your v2,
that after commit 5ab73b010cad ("ptp: fix breakage after ptp_vclock_in_use()
rework"), ptp->n_vclocks_mux is only acquired by physical clocks, not by
virtual clocks?

Also, in general I think it would be useful to include more substantial
pieces of my explanation in your commit message, or link to it in its
entirety. I am worried that the info from it becomes denatured, for
example this piece from your commit message: "Functions like
clock_adjtime() can only be called with physical clocks." I did not say
that, I said that **in order for the clock_adjtime() call to acquire
&ptp->n_vclocks_mux**, then the clock must have been physical.
In general, adjusting a virtual clock is perfectly possible, thus your
restatement is false, and it proves a lack of understanding of the
ptp->n_vclocks_mux locking convention.

