Return-Path: <netdev+bounces-141036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B59B92C1
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A032841FA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BD1A2C32;
	Fri,  1 Nov 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xd87DJbp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7611A725A;
	Fri,  1 Nov 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469774; cv=fail; b=RkqTORxCGw+Ysh3VgLxJnCi6Q/9FGCadlW95LVB9sIZPiGqG16FUOR4iMUq5S3wpx9x9O4Z9QV8KBnO1cqFYOGuIhuP/UXVayEZXcxitgZQnZDtWS8y3OTOifm8+KwmKzJe2HCelF2PWPOJMnoU9ez+IKnk2L3GcLVTcI4DNhws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469774; c=relaxed/simple;
	bh=nOnwMkCyxBd6vv3HmMGe97GJbFZMJOwzIbuLP1Pvo9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omzu1ODuidkeFHkwHNme1r4h50ARCMLEJOe/p4+LY/7qCdm1jvqvkISK3fkLYGC7IEwUbRXGT3DYGLvKl1+ZDJ+RcAI4nKpRdIUdsKQPBfR585W9fpmwxhoD0A1a0qt1ouIWOdDLTuvX7qzGHtePX/cVV6Yd+8aDcl75B43oMG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xd87DJbp; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awaxWFLiAYUPKfh+CxQBJ8I7H/7oadFHfPQUeVPM8yANPxoPdMu4fiqH2gx7xC57ST1gFew3gKv23IsM8Ex8a0OL4iSuIQL1DkjsCq+RAkwngDq0QcoKUTTe75WpIdXyDpv+EyFaDgYMReVUXvrt3le4m1m7xNi75r2tAGYYn6uUHFWHN8XxjHczrLXGopvqxNWFuVYorO/EDxWHgRhl6xfo1lD8ZH48ddRXQVdCtgx2I7zxhB3Kb6m6XGX4VpNUQ/2pWsHd5r5NomdbfuRyfkwbW6L9yvbMVSM6Iu/Jw0b70/jVk0rS+t39HmaHZx07TebwrtgUyIuwgupZJZ+rRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIMY8imas2YL7NqMi7wJOGR+7ww8SzO4Eoec7sdFeto=;
 b=iyQJoLfpOeapPtyXBdS3sGw7oEzNnMOUFUcI2HazgH02NL+/xo/bXYyHvTiGGBXOuQLZijX0JNsp/0RMzy4aNrWix6J/OZ+jBwNy8BB4Bk9CBGjFbj6KbawVdMYF+syDwds6kzIZW4sPyqH8wBPtVNlXGgPvsUJi4s0cqkxXdxf9pV/mQr5AXZ2ez6ALnkKPbXy2bjqfbFeSwcDdwcutso7/FVY3LYHRYHPDgA5DyHH74/R6bF4YMeQcR3NbVMzJ5RB/o1JEhMIQk4Vkp02/3x5GIKOkp2Bg3I6irEfANSyOWd5IY7Wtn6Tpo4IziNYv4GNLY7P6Gn4mUNpFmTSLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIMY8imas2YL7NqMi7wJOGR+7ww8SzO4Eoec7sdFeto=;
 b=Xd87DJbpvV5jr9KeF+zD6kQhre8aNijOPPYtb9rZAlnv78qXJl0/xpB1zUrUV/MhZZ4t6s0CxJj18EQhq/Ac35T4I8N6ADJ6zijfoaOkK1ElUxnPjZRERAqS78tiWLsSYfIAp3aS7MpbP45ajkxJIcBAJn9EdW8tzomQ4XKBLWBcYaUt9JpJ5rr8zh18kIlsfcJi9JfvS1q33anxDZ3m6Yr4ZzHR5ktyVrQsDHx6a9f9z14vuykGnvrE0u2qkP3LmjWA6WSz5mfodiaVpryXUA8YzN50ESGawzfxRy4WWVVScdM4sHsojI6saE1uuhIro1w3N9y6dojDvaozmA7yKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Fri, 1 Nov
 2024 14:02:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 14:02:46 +0000
Date: Fri, 1 Nov 2024 16:02:43 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Message-ID: <20241101140243.rloj4gg5hwrloilb@skbuf>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
 <20241030151547.5t5f55hxwd33qysw@skbuf>
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85104B9FCD3D74743E9B261488552@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241101115519.2a6ce6daqrzmhcfh@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101115519.2a6ce6daqrzmhcfh@skbuf>
X-ClientProxiedBy: VI1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::46) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: 42610eb5-1d35-44b3-946b-08dcfa7ddcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gBAGHHaGAWOO0zVGsFNRXMTXc7eEsgXtyo7dQ2Hi4w+AlRT5M8naszVKYxMX?=
 =?us-ascii?Q?/3YIvjgA4cIHLv5SskxZRhIiMGlv+U4eyIwDxiAJXPTDsHotWkNXenDW5QeO?=
 =?us-ascii?Q?iGcXS+GVjd0HHcAqv2pj4X+1UmgE22D77ODsLwquTneRL81cGfU0A9CqaTGg?=
 =?us-ascii?Q?50QmHYKqWRJanm9AQaS6oUG5FW89Tmxu9P/FIUvBq7Quk3+X2c7OJ/luXLLF?=
 =?us-ascii?Q?yJBHx/JPzimG0n26aXlkLTTDshbnmn0RocemJkKIK2JdmsNYv1dtMgwVddwu?=
 =?us-ascii?Q?Tm50G0KC+V3YPCLzhwnWsMW1kBnsL9U4BHtCYmBkAJ9+BJXuhC/JnOxt6B3t?=
 =?us-ascii?Q?y0dSfczxDCqHQYWyQfOCKJ8Ybt+hDjL+csKrtca2LVKDa5b7bBA8HHYUBOYd?=
 =?us-ascii?Q?hXjH6vKbk1oc4CwFrAlusQEiFLsTzlMdDk2+iDzXbokZeXkrsd0S1MiR/Fq9?=
 =?us-ascii?Q?OMpmsQMB8Uzp1EYVBX509rn1oa3UqYUIFIm8fcQ4XFyT6NXmoUhkh6HG7f3K?=
 =?us-ascii?Q?JaQYE5ppqZ9XSqYf0D0TBxLY4urTwZwE1A3QyNjrttz2FBan3Xvv/86ChM+V?=
 =?us-ascii?Q?63Lr2emFbZ79hsu6WFQpVEL2BcKXBcL53rcc3ZbOsgPPjnMeYir8ex+DBdLe?=
 =?us-ascii?Q?xROFNt7ZI9Jo9yTwAn86C1J2dm0a2v5wbnDqYYH84D+KxhRDh+Gh0F2XM63o?=
 =?us-ascii?Q?RsociT+B5ilEisIi8arRGFggLz5swFqHwIsXqBbVD3osCjIWTuxOsXOxq4h2?=
 =?us-ascii?Q?L/dhSwjMidj2qYmTOIlIW5QAeji29dWm/V/P5IpZt3atqC5ctAi2+mh/hSoI?=
 =?us-ascii?Q?Mrf2SfIdTEju2zIW/d4gEOElI13unsuCzz2SV5p+y1ykxxlFxI/MKX+tlWNB?=
 =?us-ascii?Q?mFI+o4T/J3pWgwROFsbWU8ruW0R+4db0ZA1trkAglKUc7zRPA36lRA97GxWP?=
 =?us-ascii?Q?JwWkyb57Bt5aCrzjFYo8F49raA+PXgbJ3eG5y5kvfCH4y+XFnw8UjWmhdv/j?=
 =?us-ascii?Q?rBar7C186TlcaSVYcIV0SBT6te1VjqvlsrrcbjBOjaZXluxsQJDIRR9wmrc0?=
 =?us-ascii?Q?7ZxE4N0Uw3nzXfZmWU0KgIWF1BqP7W4WyAeSKrek9gwFa7ByCHFElI1po114?=
 =?us-ascii?Q?MoUVd/agzSkbhjT3h9ztydZB8JRwQQ+1Ts7qCaHqBvJo0bKc1VzW+E/92LKx?=
 =?us-ascii?Q?TuMIdnAKuPAhIC8NugiwiSRYZF2RWhTXwUvvkHFkVjtw9a9/qKMKg81syh3j?=
 =?us-ascii?Q?16ouO5B5TQgcbeFZkdiBsiwdNaTGZTR3uynI7R36Hpn9gyjASJB8dl+Fp2At?=
 =?us-ascii?Q?3BuONn3crTalTreeaTG8ARpo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8EoyyOVTgl13F5Fq5eJu5ib9fcd0R/VRNt7AZED/l70/tY0pfIBnOe4TLU3U?=
 =?us-ascii?Q?Kuf4K7Mxl8s9Ldt0d0RtEdiGJ0HW7bBXFHTwbWxqDN78znm5t2dNHyTxnTM7?=
 =?us-ascii?Q?ua0+tjqCuVjxOcI9bLfhWovBsQ9GImcEwsRY2nS5b0j1hVpUlEh+azxWelut?=
 =?us-ascii?Q?Yvm+OrOOIowoWPYR6iGMAt4lz0D93vabWOkPeSEv6OxtacOky6qJvM85o0lt?=
 =?us-ascii?Q?QqkSJ2XPtdAJ8rt4zMtbqqfeEniAaEThpWws5jYtdc/gWOnd3sfWNpHIvjnF?=
 =?us-ascii?Q?OnFbKZXAZJRowpG1IUiXdxeTHuQVGGiDozKc002d8nLCQN57OTfE/DtvCJBH?=
 =?us-ascii?Q?68Q+rMBDVbH8cISIScgwh7kp5ib/j3/GvJmVmH6IxmAvoqlz1tr2OhyYXT69?=
 =?us-ascii?Q?TxnOdKcLvNxR/mJ/W6anOju44d+AJNL+CwUqKrS6a8wdGgan9W6eAw5z2ytx?=
 =?us-ascii?Q?/bNdQt53iCRDQBw0X4V24fB+IRFYDCWbvEHx9a5kZNJodUKqaZlChwerVnY+?=
 =?us-ascii?Q?fmLbdfpQcFtaeFqMtbtZjTHCLJPXTEiXaXoCbUzMDT0Q56DkIMudkF6pj7IH?=
 =?us-ascii?Q?cvbjyPP+kQ/Byd/4tnPWpBCGR1yvjW0ozVzZul/gp0m1m7uX7rproo6r/vUP?=
 =?us-ascii?Q?Wl9F6xxKnNi9vlQrNsS5NIiuJ01F6XLWk5BwXKyesNdcL/yD0q7146sJf3B4?=
 =?us-ascii?Q?9z7LhVG9G1qb0qN6aDDeTemutzSekuc8X4Zr/P5PN8cuEzETaapbk4DZR/8w?=
 =?us-ascii?Q?TQ3zcbwORxL3ciuMR4AQEYVeJE5J6i+NF17qU+bZJpiCsIsKGjYOylmVoxmr?=
 =?us-ascii?Q?EQQx+OUe2zNUve3taGbFXmmHf3NAsEPgu3v6S5/jnwa8KWHQ+KNYB0+2Ji2Q?=
 =?us-ascii?Q?xmwWW+bkiupkzgtDzIlVylJJDG/h6qMMalpLhcXzGIwOCdFXcvoHBCgRpE1R?=
 =?us-ascii?Q?gHWBTGFibNWmSfEIdxhJXDAEoO8t8csq74ZwUt1FVknRc+FRp09iCmR6vo92?=
 =?us-ascii?Q?TZd8oaQKoDvlT5FRJUjTJyeZCYIkpTS6cibkCYdMJRoEHubbCnkOHaQjhLu8?=
 =?us-ascii?Q?kXSAubwK/tHIkOYB2jjNcYkR3aPhCi41oTdZbn2xX5l4RRwGIwrdH7RfdPyM?=
 =?us-ascii?Q?xxGYplUdSthGUcrN7lnWYDV3Y4VWA9BP7ko0KcWu4QliNCCGm+WhtqZgzxHw?=
 =?us-ascii?Q?qHfv5ZuxjAVPnWC89vt+CNfGqzMoW+RFZCZwS5zRhxNdGEw/8RJNUatmZknx?=
 =?us-ascii?Q?MpYNZLDWMg4llT2uZa5CdBXCN2XSHfTtErFp/m6NZL4VvHOLi+z9li2031aO?=
 =?us-ascii?Q?ZoSBGXNzxnaxLwi4Te1+Mw4sj1wd5NxA0kt3VQijHDchfZ80b6O/SYQ7DDvn?=
 =?us-ascii?Q?Eo4iUEP9ggv1WVYj4ukhoxuWs8Ln7EfezCsYQEgPbgcnTXFFGZU7vWbsjXxW?=
 =?us-ascii?Q?lW1R2KOpLMf0YUEhUfYVS7F7J84H4IGzvgLbrEIwHF1QCZMYiN1odvBCsve8?=
 =?us-ascii?Q?isbUEEkElJLIAu47zEblA/TMQa4bsNyuiQ3D0NSRltyGysnlEBZkfLlLHrPm?=
 =?us-ascii?Q?6kG3Zq27MAy4HJarmXmO4WadQJ2wPmjBe/UnARd8F3Hlu5lUJl+P/MFuVZAo?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42610eb5-1d35-44b3-946b-08dcfa7ddcb4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 14:02:46.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7giAdmtNFM6l75lMDV2cr/bjc/JD/N16SAcG7/7hsLofgVXTUh8+3HEhjw+dcQyzASAUVox6AOa5kdZ6JTWBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

On Fri, Nov 01, 2024 at 01:55:19PM +0200, Vladimir Oltean wrote:
> On Thu, Oct 31, 2024 at 05:46:47AM +0200, Wei Fang wrote:
> > > > Actually please do this instead:
> > > >
> > > > 	if (!(si->hw_features & ENETC_SI_F_QBU))
> > > >
> > 
> > Actually, VFs of eno0 have ENETC_SI_F_QBU bit set. So we should use the
> > following check instead.
> > 
> > if (!enetc_si_is_pf(si) || !(si->hw_features & ENETC_SI_F_QBU))
> > 
> > Or we only set ENETC_SI_F_QBU bit for PF in enetc_get_si_caps() if the PF
> > supports 802.1 Qbu.
> 
> This one is weird. I don't know why the ENETC would push a capability in
> the SI port capability register 0 for the VSI, if the VSI doesn't have
> access to the port registers in the first place. Let me ask internally,
> so we could figure out what's the best thing to do.

Let's mask the ENETC_SI_F_QBU feature for VSIs in enetc_get_si_caps().
Though we should do the same with ENETC_SIPCAPR0_QBV and ENETC_SIPCAPR0_PSFP.

