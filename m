Return-Path: <netdev+bounces-164822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C70A2F4E4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC1F7A3C5C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D6324FBFF;
	Mon, 10 Feb 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="yG+heHw4"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022131.outbound.protection.outlook.com [40.107.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3D243945
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207595; cv=fail; b=tKSJ/eb1jERuG46NdddD2mmM1muGKKkHq1rBp2yZTzVLEqA3K0thsAAmZ5SkbRONxOpjQEClVEi8D0tfR5B7EPuHrcrVjya75KSzxkigVd1Nj1IuXnrJam+XFIjB8ELKx0WsNeDqTtw8r7imxDlW2bSYxipOCy8eLdZC80A6RMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207595; c=relaxed/simple;
	bh=fmjjuM64nt+grw6AclSRv6yWc6h0UU2mXO6/8ApimVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NrRNWIbXGB9/xukABQobvQqvGh1ofsC+Qwt171kmvC35ld2wCsWY6LrdmLdv4sPR2i3pGLRoci1O5W1VONwGa40fmoi18MsnLwbsszw5D0nM/wtwGwbnDXsQfOL4dhjisxny3lPDKBAkL7xuu8g5cJJfT9C8Ts0B+yrttDHji7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=yG+heHw4; arc=fail smtp.client-ip=40.107.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBdQSxeqf/87+CwjZgA8XTbOErK+GXLU2JWYV2aiYrdsVMGdc/WciH3vfzX0ilP8VieC7uIkZpQKu58rEeepFaJzcsHkxjGAyI71cN8aGkpn6IK62gZI/YKxDKE3SbNdYkVsXOXW54cxuQSm1AzU8FS7OdAgGWX4XBUASDk1tdPHgzfdZBuY0L6DzhOVW51DDTrn/rtz6IL7a5pYvBLfAjDlqr/BUPW2jKXOVrTLw5Nt2rKOwTskueRSwCLYbBnHPxTB8QmunvtgIIi5ktjOS1Pli2+m5kvDOjY8aH4jS8Q7kLME0yokXgb7pz/PoINkGmLFvaK2gjXt0mz5vd7SGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tu7IZjxksbjvbBjMSys6gkvO1brHAapDeRVEKmNfg7I=;
 b=x4Oyqx6NUsGY1F5vbjnZSv9JFs+Dxm2hOBxygM488US/obrL4DNKCbEdHEXudFVQUx1oQnCPF/LFLGwJtCLL1Yn+7vhXzcy2dTq7LCpiQAX2xvLIL3bi1TNOapbhmboVsgYNG7MaIO4WcI0npZ+6onCZqR18zsGAcBOkc2ikfyIyuBY0YA4LwZALXvUtN8/8gLu50mDda5iLxp5htqkijO+G91Z+ov2qi6IPOSWeQla0hypx29NUVSE6FKd6rDHNhOyOen5W/ojvtizA9aa0Kj6ZJNnMYj8X+GV/eOsezka1hrJFFz8Ub6RZsPqmPU+sn+C677YhswgyBsbrvWKHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu7IZjxksbjvbBjMSys6gkvO1brHAapDeRVEKmNfg7I=;
 b=yG+heHw4yzgJn7qm6NcNlMKPMNF9OaEw0mhR0sLnFBk8AnBc7WUg4tNW3dcUGtgAYrR2x81tWzuEjlZWwIqVC7YE66TLluFI4YbkfVf9hC0AXA4ZdaHZLISSyklDKzZZuqveJIf0Y3UZcuXrq+XNfhTNjMyrwbOnxia4BKpHuYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BE1P281MB2211.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 17:13:09 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 17:13:09 +0000
Date: Mon, 10 Feb 2025 18:13:07 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel@pengutronix.de
Subject: Re: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignment
 to 32 bit boundaries
Message-ID: <xsvd6wfty5qq5k3c5rzhuyclef5fy2e2lc4fgwo2sa56qchjeh@ooeq4mtxqncl>
References: <20250206122246.58115-1-t.scherer@eckelmann.de>
 <20250207170037.06d853af@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207170037.06d853af@kernel.org>
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BE1P281MB2211:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f94b80-4713-445c-1f2f-08dd49f6311f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+I0bx3hA+xok/1yxs6/3IloiceiDedD6IEef80IcfFxiIY98C00gG1PYEvS?=
 =?us-ascii?Q?YVAcjRR3flFcizO2i81ZuxCAJfkl4WEmP2FMG+B6DSffLTAcdnWlmozjyT9b?=
 =?us-ascii?Q?4q6KmtWHqbM+k0vguO39agjzHB8EEcuKEARsLQ6PoVWna1Tw9VVq7KyNoa82?=
 =?us-ascii?Q?MTmbbwUnZMOzkZDD4QHqRUuPC8XJdi4Ey0b38qSRv0Ykn0CbOmXj74Q6JMxj?=
 =?us-ascii?Q?1MOIl49bdD3VeyPCgt/yOINL2gr9j/4yE46wkztkEMJLmDivpfL3Lg5Y+zG9?=
 =?us-ascii?Q?EtgQ+/mHL3g1ItjkGduPx2b9f23nP0ALlTEu1lluAsmjbPkRxBObry1+adPj?=
 =?us-ascii?Q?fQ2yif8oeHncHlRLvFX/iXx+cikmzvKLPZEjZTt40X89+ewbiLMooK6w1MYp?=
 =?us-ascii?Q?gNX8uRk2Dnqzs8+LNhnUI57zjlbRtbZmSwg5CMhRwxIt50RhegFZ8wOd3Kwy?=
 =?us-ascii?Q?rQPOGj7ofCpB/duNVVgsFCZ6iwO9oYTWDHQN+rWL8qJ59MbKIaCbpJ1ldwXn?=
 =?us-ascii?Q?HNTfppq2deyu3Z1VY2TiVYNB2hOWjHX+UpOme5hJTK62yjRt0oP/Jt47QjDc?=
 =?us-ascii?Q?IZEnmnfVnph3mNPu6cYRj8UAZNdCeAnEnxyNaQR6PeUT7bclMly7mrHpM+N8?=
 =?us-ascii?Q?rsH2lXX1DLfSgFbkffeJ1hHKPcJ2PS2NRbJL58SYK6gnQu1ZskxGeuyc9fBk?=
 =?us-ascii?Q?G8QMpC5ABUjhnwNG+HUAH1gXbJjtLRI+a8TlhRjGljfWU73ijdl4owQxinn6?=
 =?us-ascii?Q?3qIhDn8BF0CHm2y+HJLzdHhMvuPoaquxkOOzjbFQ3SEQBMWCRjFQ6FUidy39?=
 =?us-ascii?Q?vmGpdhwGtHtIZ8MEYLE3ykRfHF47PkgZoMwFvCcueHWd0p62LQdTCU8DgAj7?=
 =?us-ascii?Q?ody9oOsMddL64H2pwELJQVNWQRCOjLE5kK3Z0Jsy9uZUmlvcxgor5hE1fkYA?=
 =?us-ascii?Q?733Nyk+vaunYCUxxK+FLN8ew+PkWcuM3C+4YY9a0VxxepXdjRgpmASuguc0e?=
 =?us-ascii?Q?8em41XvGHSsvVk/6IUTarB6w6xRgaS7SoqxgeRpqWUQ0dmV1grNiqNHtQctO?=
 =?us-ascii?Q?pViikq4bToGRIhicnqPJ7Dmyr5wTRAUeqwuCzfga8lykJweBGUjvIXuWHS2S?=
 =?us-ascii?Q?RjthuRxMMylpJekMjgigH/pHGXlIN5LyvsL0gF5GeSHiKZMabhjWC66ylrsq?=
 =?us-ascii?Q?3FdHbLa434KyLKmKhshnHlA3zgTghIBO4otNespjBTKwjmfvvOXyspKWSAP2?=
 =?us-ascii?Q?FDNybig6DBDwjZtSj6g6IY1kOTw5OW1jqA/rJ+Nfaem81bzUbxPqZsyAE19J?=
 =?us-ascii?Q?KUej7xebeR5VQU2pQo7X1AYShfs8KIFt8AyN3daosdZBx+X7y9P3FCLAqW3q?=
 =?us-ascii?Q?fMTlALrxO3greu+mhml5FhPlsBEz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLJtVpxKr1aFtAJI0SAvRfQIlv4fx0otCepH3yirZxp9bNLvM8wmfSumlBA+?=
 =?us-ascii?Q?QPPyh3PAR1o3WtPWZgcFownuG6vVmGZWD3VggYTISZ5e1ePcn50bAj5TL06i?=
 =?us-ascii?Q?gJlnsW/wRyAqz9EnHomY2p8q1tduJzc8G7oXQ1F9bXPHgbRkU7OD36rSKIim?=
 =?us-ascii?Q?FhSq8S8M8pZJrbH/9kU7fNcGBpVvyFyHyDOc5jKylGZZkvHHjbxS32yQidnW?=
 =?us-ascii?Q?SSsYI1stUOaKJgk8Ddp9ee8c3igk0cMV/lJJvrZhnU1vT+SvMJxrcJlf5V5L?=
 =?us-ascii?Q?z97Qk94xFBmOpYk31+CMB3qSbbTFk+USTJZCIGHfgXs5Vgzo4vLuKoMTeMaV?=
 =?us-ascii?Q?rvsH9M0As/rasog1zhof3G2dl+90uNlntb+VX1TAF+cS5EhVxVTvSsItE2eB?=
 =?us-ascii?Q?dWvZmohUxVkf0grmkvGGu8zj+CSmNw3Bi6oW6LcUUu/Ke0/NHhjJvH5zxxaX?=
 =?us-ascii?Q?wMV0DTJGv3D66hwYi/zGT6QJ6Z6ia/KBeE3Z1AHlTWtbwBPsBnUA7bFvJc7N?=
 =?us-ascii?Q?ggod38vCzWQKPIsoipSpdzorVHFzdCyUTu16cWq1TyAjlx8QTbAAiDSoi3HH?=
 =?us-ascii?Q?9OVXM+NGxIGfuTe1AD2s4bj68SxfPkx0cMercl9eIT0VEsSQ+YHtMgzKz3An?=
 =?us-ascii?Q?ZLKIjnkJIaUmXZYj/dOkbAkx58hRvGdieFNkNmls21OkLNu/NABsUXAaiqpG?=
 =?us-ascii?Q?zOm0YviY9KFsu3eowOgZDpFWFQn9+bNXHBeDDk8CeQmrqhhNMCIknHX3bmpd?=
 =?us-ascii?Q?9FHndiHqWz2E4oN5cwJM78uyywXwqp1+jGWqcFn+wGXVOuFyV8+DYVbhkae8?=
 =?us-ascii?Q?MsYYN3fb2ZiARjBOo0hGlzPcn3EDgo8otTHTpj7IO73V5LB9/TIKwbsaUUyl?=
 =?us-ascii?Q?AGOrzw4x4K/+yMA0XoVXr0CpjavjNgPIYSDWIOQALDTs01cEYYg2mU4Jpw7g?=
 =?us-ascii?Q?aIq12X1rSH6wPVOQIwNo+QL0QBb1WLAeEkDKuXi+rJA9s1Ue1uau/zBg0f5R?=
 =?us-ascii?Q?D6yIqW/AO7nFNrpaMz6f+MNrlLzrKG6B/Mju8so8FAjVoAqS0ShQ468RMljr?=
 =?us-ascii?Q?1hYrJfXBAiAwYwA+XPpsVC2Rg+gEFlu34R1P9J5MZexFHIy7ggAwFqrc/vz8?=
 =?us-ascii?Q?D36cFFUI1AuewHP90eJUwwWAm4u00zELCbqCLC9PLqO7BP54K8DoCwH9gxlV?=
 =?us-ascii?Q?xi6DNVK3W+eyUAmHqeD5TY3MaQQlt6CyPeKmBKdE6Fd24+KYkoQI7H+IvWF9?=
 =?us-ascii?Q?uxMHb64hE2xrn1oExlKrv5gd/q5RMCueexZCwh81jCiEsSYot5sNUJI8ej7s?=
 =?us-ascii?Q?iC5Cfbs8WD3q2nFn0cw4rFaoIeJRSuFJaBWxLZWqFFVJ+WRMO2VlzsGWaFR1?=
 =?us-ascii?Q?2DL7H4tfI8gnbL63HNIs9+Kk4TIjJpVBYUDfr0z7HxNQvJ5A4grzJtPRBvSi?=
 =?us-ascii?Q?ixg4ZQGqSvV9vBGWpmFv0h6V8RdRP1WIuLeYSgf3ceACRZ2ZCA3E9NewOjNb?=
 =?us-ascii?Q?Iu/0EOBd3dSKfWpdMWrh5V78fvrpDb/D/bUFQietAJPb7UIpOvtmAB885C90?=
 =?us-ascii?Q?I+pdmFoPAf9v/CSoYiX6A3RiZEpsvM70ghpb8vj5?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f94b80-4713-445c-1f2f-08dd49f6311f
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 17:13:09.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqDzpqn93qlx1AlvSJU5jhdn9KrXpCQqIzxTAmG4fwNgjXQ9T1Lu8OUPgd7ExnJn2fv+VXDQ3jJz9bS562RphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2211

Hello,

On Fri, Feb 07, 2025 at 05:00:37PM -0800, Jakub Kicinski wrote:
> On Thu,  6 Feb 2025 13:22:45 +0100 Thorsten Scherer wrote:
> > -	regmap_reg_range(0x1122, 0x1127),
> > -	regmap_reg_range(0x112a, 0x112b),
> > -	regmap_reg_range(0x1136, 0x1139),
> > -	regmap_reg_range(0x113e, 0x113f),
> > +	regmap_reg_range(0x1120, 0x112b),
> > +	regmap_reg_range(0x1134, 0x113b),
> > +	regmap_reg_range(0x113c, 0x113f),
> 
> can these two not be merged?

I am not 100% sure.   But atm I don't see a reason why they could not.

> >  	regmap_reg_range(0x1400, 0x1401),
> >  	regmap_reg_range(0x1403, 0x1403),
> >  	regmap_reg_range(0x1410, 0x1417),
> > @@ -747,10 +746,9 @@ static const struct regmap_range ksz8563_valid_regs[] = {
> >  	regmap_reg_range(0x2030, 0x2030),
> >  	regmap_reg_range(0x2100, 0x2111),
> >  	regmap_reg_range(0x211a, 0x211d),
> > -	regmap_reg_range(0x2122, 0x2127),
> > -	regmap_reg_range(0x212a, 0x212b),
> > -	regmap_reg_range(0x2136, 0x2139),
> > -	regmap_reg_range(0x213e, 0x213f),
> > +	regmap_reg_range(0x2120, 0x212b),
> > +	regmap_reg_range(0x2134, 0x213b),
> > +	regmap_reg_range(0x213c, 0x213f),
> 
> and these?

Dito.

Will send a v2 as soon as I can get my hands on the test board again
(next few days).

> -- 
> pw-bot: cr

Best regards
Thorsten

