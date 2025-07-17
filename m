Return-Path: <netdev+bounces-207863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBFB08D3B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A364A54A9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DC52D375C;
	Thu, 17 Jul 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8zcLFpF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012025.outbound.protection.outlook.com [52.101.71.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D13D2D23A3;
	Thu, 17 Jul 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756175; cv=fail; b=qus+AIvP7IE8/fm4L/6fLIDE0REBvfzQskUY+AUGaAxEOxXNdq5ODn3S9vOuwaKqL16e02vohgY8xMiIqxBZR36Q+Eq89lbjfmXhPZmiRcN9KaUo/fKv5XLpp0ISAFqMr4gBXp/s+0WBUtDX45Z7PYJrcKQpoelcZY7gRhhBNLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756175; c=relaxed/simple;
	bh=8SJOeJZiSNG3doXSg0zdwLnKZdfgB3IGw93jOyUSg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqQuaODgTzHe5jUmvVVwhQCcqQ48ahTuJ/TPA1acTZTjXizQpE4QIAeznpjBYki140cPWfVH+IvIbwUowBnw1gSvwTXdC0fAvFHIZLMWcRmxYA8e4u/CtHIwbmKfHg8XgU1us/gnc4k9EcaL0MB4td4HRjJ0hRx6OaO/ZIJKiws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8zcLFpF; arc=fail smtp.client-ip=52.101.71.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC57I1KnLOJ+0NL0RcrzEPsrNGGBTQB9yEAGOZO6xoLwfDajZ8Isvt9uT8T0hpWvsANh/42lWTd1Oto1uOQluuyL5zR5yaCQs47L2pMICFTl0qd1Vx9oJ5o4mCXCfra/oLIHYhN8Md5H0uu26mZK9V/ZAJotbnMd4pBEu/klAJuBXM4BMEQsTR0hHwtJ26TATRpgXkfGSyGBfJNJW+BKx4vsoO86RFjr5bg+xfZ4wt/3MEjZxRM7Wf33s4jxj6FdhQ7JGifUsCp1IFVWBCOKwHysCfN/MzHLsYbXbZdlvKIUCXjwOj0BNLDwM+WFo58JZYbY005tyO4czGi9mW/Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfHH7zsH/Kchmnzqk/rmNObtryOZS0NrZxckurHggA0=;
 b=BhR9x0PbUpUbcYvipDfLpvhsEAcEybXK46mhHRK6biwULvXv/3qeKZt4hBQfSC0Jd40urDLDYDBgww2tniXyjUWGK3A0iPqB8WiPpYOEdWcvgySyH7TidOi/W7xJFYrPUotuljO3uWA4jF2rw07lyt7coESPZrYTkkXpPkObZEwQc/KcErKjOFTF6euY5UAYhW3HW/5n26bffSlA5lCnHskibhj6dNGbExwsBEx69WmJbIHUIC1oGRj4ZNom/fPKDypvpV6kmCOgp21rRRCWARZ5Z7wusfFpklq1zMzyMSWVPni5fbkNT2Dn7nwDIZ7Fub8EebZlWzimmnpxeKa98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfHH7zsH/Kchmnzqk/rmNObtryOZS0NrZxckurHggA0=;
 b=V8zcLFpF/9jrlXFtTzAE7lKf6/igILsgyzXA5eIa+wmG6boi/YICSBD/4qBXI+Wz0sNJiUG9DAjeD2nGIjoxgDJiHaA/AAM4dRxorgHZJt8bcR6lA0BPqu778i8nsjNzUlvyhXQ3+u9bv2TPDfkeMnEmkdtBmBPr+i1LrA6Q6l8awP9N43wdKNCbzpa5rKvFlqaVx/0atphc8Fv8gnsRN4lDkYHWtizE1lV2PhwFoCpXlDqlWSWrSTgr33pwJZBd8eMVslwWW4WA6eQFUK/vlJL+8iFf99uazbQnZxFUCsAmJ32Wc5+0ZOTAItcTe2BP+i4eGCLZtY+avSXItt+cWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:42:46 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:42:45 +0000
Date: Thu, 17 Jul 2025 15:42:41 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Frank Li <frank.li@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <20250717124241.f4jca65dswas6k47@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717090547.f5c46ehp5rzey26b@skbuf>
 <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 995d359a-d4c5-4f61-e66a-08ddc52f6dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHcv6CnklJ4GBA/RF0BNypWs9xa9E3OMO6vkMTxDHiDNzhP3n6J0mnkHX1XJ?=
 =?us-ascii?Q?zOBINkg4WsltqoTmhkvW7Du58+XP+3AZJF2Au7KNLvCi/mdxnXLrCXcevVOS?=
 =?us-ascii?Q?d0Ww+OdwQAUtD44vIspCK352x22ptfUyKvkQ/35gDvtj1gJ5kgkMfdFOGM19?=
 =?us-ascii?Q?xBqZC857/EVMhd+jRaNUIOmcdHShw9h5AtjbIXnLZR5oBHBOb42cpoBlkJyn?=
 =?us-ascii?Q?+mVk118l8yMZ5EFpvK+NcuLV0/EhgxzP4g7/BWzitX12YeT4qAFuok1MTU3r?=
 =?us-ascii?Q?QvKm2Hy31MFAMS1XvYpm1sV0TcMAgmxE+v45oMNcTUPJDOri0QK5r2ha8PX+?=
 =?us-ascii?Q?+WRnDrKDAErwfe6nM4A1PclzUgFdLZLGbPDAIB6BkdyD7JbsB5MCo5g7unH9?=
 =?us-ascii?Q?0UcFN7CMaK/CDHjL1M9TQLCX3MzkS8O0HB3OXTEigdWdKeSNYO/qawJ/aAr8?=
 =?us-ascii?Q?EB0k3NjptArJJaVGKiqyCczevUtk3YmuSwQfY5sb/4+4KDJID7bYSXjJ7Qd7?=
 =?us-ascii?Q?3TtBOYhMXFyykLIvq3iv6i6i4RCQD8N/TiGkb1AzD5JJYeSLBXH8B3GV6g+N?=
 =?us-ascii?Q?euEL7dF3VhqOs1g8pTWpn/wctECcC2i56ZCA4WQwvcsGm9m3LjTzAkdJAsxi?=
 =?us-ascii?Q?AcpvjQYhsg2mKRSZu4yKoG5CHkb/np9LuLg7OlZhtaXJQY56VECh9dvC9G/O?=
 =?us-ascii?Q?QfnLpWHJp8cNvbq4l+Y5YbXrY04g1Lg5O8TBV39GP8kGLSmFiUy9Sf7vJ6ds?=
 =?us-ascii?Q?VFvd9YfbulVFO2H8VwycPXt4u402iErqL9uregdWH4rOSx9ONv9PqVkg/wTy?=
 =?us-ascii?Q?Ua4z7gOt6NVzhs28ZgCSktRaIDY5VjDbNK7spQSZFPfx/WUxbebySEVmgQb2?=
 =?us-ascii?Q?swr+btpKyfB+2deOZe1GXCAPE+EjyNXyvmKn1iD35a4/BEcw8/mjncV6hgjw?=
 =?us-ascii?Q?97gPW+9Mc30RiGek8gswy1SrwGgYDvGfe8CEaTjf8aSBxnL4gWDo7QVWRgRt?=
 =?us-ascii?Q?VPkLVK7rO9ZEBduPXoHpOzbFAtCvwo/Xr8iW52/aRMSBACCo3C6hhNA5SAHp?=
 =?us-ascii?Q?GhZEPkv9xSPlAjJ4Jg7yfK2By1apSVv6+39EARcq/yo05HQ6YJetRs48niU0?=
 =?us-ascii?Q?Yym5cxg/UHRfJvdDiH+Og7JWsw8wwQbN7FEIIb/MPp2hFi2KwI5pEr1IDsGE?=
 =?us-ascii?Q?BjpUmOOnlYDuavBvXnTuJx9QmpqswpCEW/37rR7zK3hB5+tbEkH9u6NmNpIV?=
 =?us-ascii?Q?YH5ONhHcl8KYJXDmDJ6H9gSG80HNMnt6XcnqvuHK2oz8RWUGuainyfFAUGEz?=
 =?us-ascii?Q?xvnhX1p5Rr/gsS8oav5VB6tMWuXisASptOgg9N8lw/eGkaINDxqJta+6Vwe6?=
 =?us-ascii?Q?LEXxFvHO7y3NRSJ52vnl9+ccxTvrDEaVwWYzhf61v9ufVVkHaZEx62bc4Imh?=
 =?us-ascii?Q?rzTLzBvUoWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrfKQUVEtR5BjQpaem2G1mDImo071HXAgClthFydqAdCXxVf6E0FRe6cf/Dt?=
 =?us-ascii?Q?56sZxPCI9VWqIHJVR8z/h/8xh9xH1OvKmpjsKR5OgHZcvl5ffivRmfkFI3QX?=
 =?us-ascii?Q?9zWdwp73c0T+krG8HryNJubtHoDu76Iyebr8Vevpj50cNdA0zdf5ShK54U5m?=
 =?us-ascii?Q?61HzghLr2+CzoBzYl1LAG4kvjWDVgfvaAXngSeHOZW+M8mgpL2g3EFIZDUij?=
 =?us-ascii?Q?St5seLquR1KX8bBIpUC6SrSrUbKXZggxDHl8+E2iD2dxvP8I4qFx0AEknOf+?=
 =?us-ascii?Q?/lmA95Qy3flkdxRww1R6yhA91sm7/yH4Zycq7bYqERgjzX4EpCNOow57Ra1d?=
 =?us-ascii?Q?EaW/QGnW62/IraLV9AiaQPfGIvsNuM4EAVbphUOjhvtJB4xpqxqP/uQTclVD?=
 =?us-ascii?Q?6LnI2au0wYyEAZDRD3xcxZ23j67zrhZnSEs/guZ6HTOY1OUjpdIbqwpl59wL?=
 =?us-ascii?Q?HAXHAWP4JTxdzk75szTNcGodMqvGRal3qNMcWjbn2faBFPnpNgLgGuKRt4rd?=
 =?us-ascii?Q?b4mE5O1qcjZkO1NKZbfuVpn8CJ+K0X/0aC0gzNbTqlErYpTFhBIiY/44kOn3?=
 =?us-ascii?Q?Le8/5oXJygIWlzyGSsAUw5kj6Xbxer8gMNSXVLJBvsQ2Dv9sN4NUiSErMGSd?=
 =?us-ascii?Q?ER91l1fpzv0/vnTQlkfK0AlAklNeBt+XcroTh4Vv6P3b2qhdABkt9R+9iJEI?=
 =?us-ascii?Q?gV2y+U9Mpg8npgU4NRKh99Yks9EBwZ+i2pEIEPd3hw+iMgISSX/h95dDYVZC?=
 =?us-ascii?Q?0/W6/lOB5sOz+pgonk9u3gljAqbjEG5Nop4amxC70q4FD/1vq8Qa+EEKKJ6n?=
 =?us-ascii?Q?iNdNbDj0Cafk1QHKy547fyroWH4eoGfDcpXEZdN2OMK0wZUCr836OE6pmsKD?=
 =?us-ascii?Q?Snr/zONjsnI3pRsMhrb8NZuuBfz3IuMI32W+EXcwQPImfZycz+cIAkhXCDih?=
 =?us-ascii?Q?MbuCSTcJ/9GyCMXl8A4rsf2pGT7SU8AObXsp/CFxVvP5w/VpSRdGBmiqRyqe?=
 =?us-ascii?Q?fv6Q/NSHeoFZ7skqzY4eqLmEyqWtW+VIcHaqg7zbpYfms35OtRRU3yNbsPPH?=
 =?us-ascii?Q?mr3nUCa0Cy0icPh9FvSuF4JMIVWUJTCQpAWbCnkadxhGkpq2rOgI5WLaMk2f?=
 =?us-ascii?Q?PvpBlxWNWatCx8vurDVRYPIEnXxhBBDWCGVwwMsuc1VOo9BlAyMTdODV1N0R?=
 =?us-ascii?Q?B9exNVr3adyhTTYBHNp+E6musONCFaraYxADH9kgw+wGZaui/XqBG+VIcSYA?=
 =?us-ascii?Q?KhhafzuBMDFstkCpB4nfbHGf+mXMJfZWcTMosUCFuCKxA2Ul/EVbtGaP+pSj?=
 =?us-ascii?Q?CgRV+OzsX/8tjpXkYaDg9of2pPNVLSd3NQo3oX5hqkEMuW2RW/8v7mHXiCch?=
 =?us-ascii?Q?lUBdWLMjHkyEqd7zHRZzeUbl7d9GsXarYDKE7MEu+FfAJ2uCZOTd7yGXVgLW?=
 =?us-ascii?Q?RzNDK54Pskf7GWcEcIK4bX806DyttT88ic01FZFKtnYtm9CH9nShwIpQ6R4O?=
 =?us-ascii?Q?bh8zkimeWngC/x+dOjEiY5sdP8VeeEPIavmgey+ekNEb3U0r+p9hHCK5yXea?=
 =?us-ascii?Q?K0Bcu8TdkeMDP9yJEwclE5WegY232vb6ep6pgVvA8epH4Z04zhSnYmphglsp?=
 =?us-ascii?Q?5Vq/FQzXKlSqrNs8VkoAoA9p1RF1WGfsqNjjkc7c1VW6trQxXzlumWB/4cLp?=
 =?us-ascii?Q?TxgIKg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995d359a-d4c5-4f61-e66a-08ddc52f6dd3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:42:45.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItTzsNcSX75/18Exo7VRpwnnwvRmMHCkuOQ/1VJsYS6b2DSFzsE6iBFfqWcaj/EVgXzY9RPWDDcpfoRsLqDlSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444

On Thu, Jul 17, 2025 at 12:55:27PM +0300, Wei Fang wrote:
> > > "system" is the system clock of the NETC subsystem, we can explicitly specify
> > > this clock as the PTP reference clock of the Timer in the DT node. Or do not
> > > add clock properties to the DT node, it implicitly indicates that the reference
> > > clock of the Timer is the "system" clock.
> > 
> > It's unusual to name the clock after the source rather than after the
> > destination. When "clock-names" takes any of the above 3 values, it's
> > still the same single IP clock, just taken from 3 different sources.
> > 
> > I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
> > clock is sourced from. You use the "clock-names" for that. Whereas the
> > very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
> > not an acceptable solution, do we need a new way of achieving the same
> > thing?
> 
> This an option, as I also mentioned in v1, either we have to parse the
> clock-names or we need to add a new property.

I think a new property like "fsl,cksel" is preferable, due to the
arguments above: already used for ptp_qoriq, and the alternative of
parsing the clock-names implies going against the established convention
that the clock name should be from the perspective of this IP, not from
the perspective of the provider.

> > Also, why are "clocks" and "clock-names" not required properties? The
> > Linux implementation fails probing if they are absent.
> 
> The current ptp_netc driver will not fail if they are absent, and it will always
> use the NETC system clock by default, because the system clock of NETC is
> always available to the Timer.

Ok, sorry, I misinterpreted the code.

