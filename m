Return-Path: <netdev+bounces-208024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A172B096CA
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 00:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B18E7A4726
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF462237164;
	Thu, 17 Jul 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONo/NYpX"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AD21ABAE;
	Thu, 17 Jul 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790070; cv=fail; b=erTsO3i+ObdOht3ODtPD03wse/8tv0lZN+JxRG7zDvEbMwstow9BIqdTKzvWmUtJlsqHZKakFBjlwebg4durYRTpkQoSkYvZ+bvSCjtWki+eTDxGAZXv1HsYRlrMsCjMqxwJsTplY/bdIChEglVAQ/MpyOtDlc0cP4l8otC2fHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790070; c=relaxed/simple;
	bh=q9GUeVuHJHx0tUb7iyt9/cZM0uuWHpTOR47kz/Qd61k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcFYgylAteWHQoSAHVZzVsJUqfNYJCXServNJA5Gu61FlTDjrKZYRsFvt7NxGpomV+2/dtI2nfZFnVyN2CCMjtsXL6nJZ+hwbhBg6E0K2kEvbJdv34eUh4OdT1j5KrLE+rkwZQlUODypOv9Cq4/7VEEgvRCt3AXv1/Zt1fpjx4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONo/NYpX; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbZA3PQPEfzyJLKrYRp1mtUajAr+NIDeCeX8gpahb3jPWccosL74IBTf3eKKg7TAwskyoEp5Uf2Y8Y5Sd9ank1U5cmdSL28ZicFY3cLSN5dkn+SWFn9NcpMudDqfnSbnGOpoQzwCAgjWizQFnZLSxVw+XbOvvJ/SMejspwFuctH6kRZXM9pI+WO3kqO4dTP7/3O2FO4fh4LI2pF1l1b3XdErV7KhWdcRKUzZsn4hi/5LF7EGrJeH8Vxz0RXXmrHbwNGDUDdUWUEgIH4OEfZ18EfLObB7DqKTTwdQp8zeNALxbkWHBt4hhO1OwqnMmQuYWEOMIOZyCbLPxJ99DlfC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmmymYXoq5EjQOY3UWqvCBDQjdZKzWbmu+HLyyCkNMM=;
 b=iMHqtrY4cmB+LebVSBuAv3p4UPTk/7LsogIE3dztSAQIY+rF4S2vkm51REiuGwTfvL7eP6Cj1x+ePpA1swE3JVqqIWSPK5swFttaaeR3Qi9z7GP5LJ16BEex5WH5ivwkSqv0Hcl+UsTM407NgXNKDsCSl/+3rBukHcuq+eZmL6TWZ/1udC4WeJSfw+LZzjRYGsNkxRcjCR6h5PJOMt/b5RRixPLFfg/NVIqQVlALZn9REqBneYR9HrzX49QXdmq5MoR87vahFzjWVv0lHWUd3h2DBjYRU3W9PEZvZayQRe1OVLxmULWkavSby8bSbwElzruDWohsrdz+PgRF51FQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmmymYXoq5EjQOY3UWqvCBDQjdZKzWbmu+HLyyCkNMM=;
 b=ONo/NYpXJr/1vX9/LnOfL9tRpXyPmh/SpIP1qOBUw44QwbH42U26mjy0k94CVI7lzjsoj6zK4cm8A357V4ppgJNnFna7frxWL/hd/IMc1qWPEATMV8w9Q5UB0pAAHWXApdgjdGcRUoH3t5ry6me+ULRuWotJpzCsFOGYiaIcP8iBvm7116E2Bn9PbLpHRUjf77PW58Sn6tXFfA0iNfjbcPj18wCsAGtyPo7vIaQxO2dlSOoqZAVXTAjjYealHlyik71QSl7GLqvNH1SkI+ssTK/g4rRZXzD3bprHpaLKQCv6hEkzlsGB6MyLblgfr37DeY4fFC0k5UyNw3g2PExK+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11385.eurprd04.prod.outlook.com (2603:10a6:10:5d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Thu, 17 Jul
 2025 22:07:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 22:07:44 +0000
Date: Thu, 17 Jul 2025 18:07:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aHl0KvQwLC9ZCdtM@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
 <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
 <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11385:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e01563-f7d3-4300-3265-08ddc57e5b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYnERI4PDwog3x00yEhxEPxd2uEhbgwiiXD6GhO5UQwfJGOwjOZujZPYF32l?=
 =?us-ascii?Q?+eNC8jh5/WthZUCJRvzBKS8mfsDJ3FsD9myMQdU06ut7XClWkIU0qpxhaTRF?=
 =?us-ascii?Q?9K8Oh3aKlZx3DBLF+VdGkEeAs5GXZdnVDLD58XJgqn02sMaFn0rxshxGwJ2J?=
 =?us-ascii?Q?T1a4mUEFwOu87S9pAFJbvRiV2J8PGaYIXHXNy26VJStnV3Od8UZFZmsB+uAu?=
 =?us-ascii?Q?+dsb3pJScLqoAfvPjSg9zNWI1eqUGJPZIhZFOejz6Asj+dlyPfXTcEuQmVv4?=
 =?us-ascii?Q?LCieyNYI0iGTySBkvUE90tzys3QLglwYnU16+3+Xza2NRbB5LhQ6GT6YUZmC?=
 =?us-ascii?Q?D7ytSiNvIX9mrLFk5py0uw7LnamQ7Uv1xxbUHLk6IuTToFuXr4a5eCBtN0ig?=
 =?us-ascii?Q?JNONatGqhTeLi6WypxTXBV0mcTPI4W1BFBv0R6XqTXGjCGYi37/hiRAJF314?=
 =?us-ascii?Q?0nxiRU73sOZ9cq0c3hJ/0dYjdkf2Qpy1gcRbPwmnL7Cu+5i8hVw93tTuEfcw?=
 =?us-ascii?Q?8O+VES+uzy7jwhASxdFTgRyZ+141TUwp+llQ2HUYUEgxevUQ6SBjlikK44RT?=
 =?us-ascii?Q?x8vidx3/5qoWyg6bOM8Gx6xqmWTBNaEc47d5ffqpfM3GRrxdlvVMF0VjqSSU?=
 =?us-ascii?Q?VDVYllUGF8nxcuKLpNxOTPLvnaeUHqePTf+g35R2bGh8IGfy0v2HD14GxaOT?=
 =?us-ascii?Q?jI/6TOL0P9bva7xZ7NUHB+ToCPNYFCKylwEcYiHss3PPlDDTjBGhiarYWosp?=
 =?us-ascii?Q?8vhsRd/4ejCKCyxAjHfXz+aThgBUVVZEGCrF7NshrI8arW0eBdhJxqsVnrwo?=
 =?us-ascii?Q?OgrJUImkZrqxYznm+siWlAP23q0znHSvyPAlkrP4ZOQ1293WuuTKXQWQ68No?=
 =?us-ascii?Q?yI048vCbudPwIPKZgKePPTEKt79JaHRaqRGZVpD+CP0P4yO49JszMaYKqT9j?=
 =?us-ascii?Q?BUhTvQToz14PDSdGeVwwKWVXFnVfp4veFXf/W4phnvYCCAGwHHXlIwnebWyO?=
 =?us-ascii?Q?GTK6xz9F7k3orZxDCCB1ofxbRiVDdTwHljW8IRpqiiycY1VWMUwuJsu2MNdv?=
 =?us-ascii?Q?VmRjiaojH8ieSW7blznMhWIrT+GRoXioePa4/n1Wwg86qA74wOit6yw6tptq?=
 =?us-ascii?Q?CH5aIAZzgxovQYRM7yJL6Lfo1w0JUxV0e9lXsEVHPgTxFS13rtTJMB1Z202l?=
 =?us-ascii?Q?7i5Ni3Uyu3EOz3E/emmzRo1+Nj5ehflVxyQRnwyuqfD6nQmyp3S3Kplr489V?=
 =?us-ascii?Q?1niogtYiBw1b3UQsN4wjnVcvJBDpcO+2uMyoRXUnLj7KJAJ995v9yvjLu7UH?=
 =?us-ascii?Q?Skwsw30eeK8ZfTcpPqD46sEJlYVrcjnjvNZNEqnT57n5rf6mwcW/ExcduP4E?=
 =?us-ascii?Q?5Nd+lVo4AM//PKSlQTZAZ8FSuEDgofeF4AT2phDe64f319qkOAHWsrgHSLP6?=
 =?us-ascii?Q?ql8ryrcOL5p5TiBTbB0IHu5jrUwW2+zS0Z5XrThTSt2Gz/A7EMyGywa6k51G?=
 =?us-ascii?Q?7A7Bf5es97GF9P4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dkfz9UK6EwoHz22G7/jFWOx9IgtMJOaSjFtfBP8+bI+rIu2np3dBc8zo1wuP?=
 =?us-ascii?Q?7Ya0RqUDGr9TIVzg692tKSx9V/brc1D8CLNf+0HJ1OKRaTA3c8T4TlD3XC1+?=
 =?us-ascii?Q?h1eoXpOuCPb8lhB9lZ5ehGLCs0SZSVCIFEQi3usWivdVejSEAUmzj/1a5Wtt?=
 =?us-ascii?Q?VmL5cI9z1mhRgpF2UphoQwlDR9K2mMohkgR68cCAJrUfEzsVhM4ff1N0J4Ep?=
 =?us-ascii?Q?8pnlRvnwkzdM7S+stnmbDcXMOnFTn2HBG7M3vyvS67JtMenm/OIKP6UhO4FF?=
 =?us-ascii?Q?wM+lSbH1WlO8ADhPSOKeXbRJQh6My7+ed4+K43U59BLZBghJsr5Q9qTQ5M3x?=
 =?us-ascii?Q?C1R/Y6PfaQtgLfpDzfQz8dw2T8Zcq6YOdzyI/HvRtxSZRD4GcZ3jsZXpI8ut?=
 =?us-ascii?Q?Zsi7lQ+B7XoQumaTRH43oBUbHVp17wTgrkZuIkH29BX28QLuGHutzBb8ZiVd?=
 =?us-ascii?Q?ogBvypL6SUI/t62iUYjpSG7bVG4j154ZjI7HtURraKg7NPXUqfp9YC0Q6eYf?=
 =?us-ascii?Q?CSDV0pmVEFi3k4C5bhY+PB3ngYHZMHzr6vEeIXiZ9SHgs1MBzmCibPe74XxK?=
 =?us-ascii?Q?PQhha0UY3FaZ2BIsrd63qCLP4yP6BpW1FoDQvd+2uC/Q5kTflZEOAzTJycFp?=
 =?us-ascii?Q?DWG5Ps/4AERsrP9IcrFAfmxOBjBX81fyGoFqo4vyr7krlL/36k8sCfnB9k3y?=
 =?us-ascii?Q?0+fq61ATVK3F1u740767haSuiGsqSyac+yQG93ZVvlX1tTulldF7VHbg/65W?=
 =?us-ascii?Q?zsF31lvsdajDwHLmIM1LT0E0VPuJsmNvY1yPwE7Bz0mtS0fsF5vDPbBezgF4?=
 =?us-ascii?Q?u6+dtsWunmhtmiSpbEgBzvgU09jVOHCDzLIJd5e+xcENhzelqpwuVBUUXKBb?=
 =?us-ascii?Q?YGeA4fPWY6Tyox1yavOsQyT0OhOjTGLq84gkzDCVTQxgHWAUh99fwzShqMNY?=
 =?us-ascii?Q?+EhzGDi4e5iZeaICVTPDxCRINFbOvYDjNAxWp/o6Iwaj5U8d8uEuoDAHYjkD?=
 =?us-ascii?Q?tGnlHR0SlckupQUM6hkOdXDVUghDb8EYgBqOxE9ZsLHNrrtRiXXFhWwr53sy?=
 =?us-ascii?Q?r4YOo8vKVL6SqbyLoHRkEMU9YJuj02Y1E6loXagVuYH2z/g5a7YblSjRp21i?=
 =?us-ascii?Q?tAo7HjLNKyYdVh53pv+UUlD91xdiUjgWzY37jvY8HduOdYXrcHAVKkwCFbRu?=
 =?us-ascii?Q?5X/cLAr8aJgfIEzrTWDs2PIEvFv6QmUGvostsepx/LeE+X+0q+ZOdw1Om8W8?=
 =?us-ascii?Q?r2adr+3ieMB4Cqvj33mYux9MBknhnZL8LZk6RSC8DK1HFIju9W833tV+CEvH?=
 =?us-ascii?Q?vM50dUls68XzyrA4LdJ0B+UaCBl9+IYFCp4BwWtVnqXF7ZfmYj0uMuFqcmFh?=
 =?us-ascii?Q?2qbok+e8+xhUbD6Tt59C8A4uQnpfgTOf75vYXKrHGIoqAmymfst6u7hVEB8T?=
 =?us-ascii?Q?cId2PJRLWozj4e7AZ8K9eErgff3ulNM5fvA/fUACBMNkdNcIYfBQNaJo934b?=
 =?us-ascii?Q?bK8MdtW3tLjvadmbmGQnax+CQWhcbVIVoxhJYDqaMg03ONxfVO4/WAW5tOrL?=
 =?us-ascii?Q?KfdKSSRXax7a+Qdu+cQjQTDLy9LZ1kkdqDjjbU9q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e01563-f7d3-4300-3265-08ddc57e5b56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 22:07:44.7062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoXJ/pYdPpgkdl4K0B/H/sJqcl2FhYNKytzdmysUfcPhIZzBcdMtLx7F/6zyhPBcrrIaaol/SbEwQQFYP0FSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11385

On Thu, Jul 17, 2025 at 12:35:10PM +0000, Wei Fang wrote:
> > > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int
> > > +offset) {
> > > +	u32 val = ENETC_PM0_SINGLE_STEP_EN;
> > > +
> > > +	val |= ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > > +	if (udp)
> > > +		val |= ENETC_PM0_SINGLE_STEP_CH;
> > > +
> > > +	/* the "Correction" field of a packet is updated based on the
> > > +	 * current time and the timestamp provided
> > > +	 */
> > > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val); }
> > > +
> > > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int
> > > +offset) {
> > > +	u32 val = PM_SINGLE_STEP_EN;
> > > +
> > > +	val |= PM_SINGLE_STEP_OFFSET_SET(offset);
> > > +	if (udp)
> > > +		val |= PM_SINGLE_STEP_CH;
> > > +
> > > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val); }
> > > +
> > >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > >  				     struct sk_buff *skb)
> > >  {
> > > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> > enetc_ndev_priv *priv,
> > >  	u32 lo, hi, nsec;
> > >  	u8 *data;
> > >  	u64 sec;
> > > -	u32 val;
> > >
> > >  	lo = enetc_rd_hot(hw, ENETC_SICTR0);
> > >  	hi = enetc_rd_hot(hw, ENETC_SICTR1); @@ -279,12 +303,10 @@ static
> > > u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > >  	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> > >
> > >  	/* Configure single-step register */
> > > -	val = ENETC_PM0_SINGLE_STEP_EN;
> > > -	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > > -	if (enetc_cb->udp)
> > > -		val |= ENETC_PM0_SINGLE_STEP_CH;
> > > -
> > > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > > +	if (is_enetc_rev1(si))
> > > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > > +	else
> > > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
> >
> > Can you use callback function to avoid change this logic when new version
> > appear in future?
>
> According to Jakub's previous suggestion, there is no need to add callbacks
> for such trivial things.
> https://lore.kernel.org/imx/20250115140042.63b99c4f@kernel.org/
>
> If the differences between the two versions result in a lot of different
> code, using a callback is more appropriate.
>
> >
> > >
> > >  	return lo & ENETC_TXBD_TSTAMP;
> > >  }
> > > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  	unsigned int f;
> > >  	dma_addr_t dma;
> > >  	u8 flags = 0;
> > > +	u32 tstamp;
> > >
> > >  	enetc_clear_tx_bd(&temp_bd);
> > >  	if (skb->ip_summed == CHECKSUM_PARTIAL) { @@ -327,6 +350,13 @@
> > > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
> > >  		}
> > >  	}
> > >
> > > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > > +		do_onestep_tstamp = true;
> > > +		tstamp = enetc_update_ptp_sync_msg(priv, skb);
> > > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > > +		do_twostep_tstamp = true;
> > > +	}
> > > +
> > >  	i = tx_ring->next_to_use;
> > >  	txbd = ENETC_TXBD(*tx_ring, i);
> > >  	prefetchw(txbd);
> > > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  	count++;
> > >
> > >  	do_vlan = skb_vlan_tag_present(skb);
> > > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > > -		do_onestep_tstamp = true;
> > > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > > -		do_twostep_tstamp = true;
> > > -
> >
> > why need move this block up?
>
> Because we need check the flag to determine whether perform PTP
> one-step, if yes, we need to call enetc_update_ptp_sync_msg() to
> modify the sync packet before calling dma_map_single(). ENETCv4
> do not support dma-coherent, I have explained in the commit message.
>
> >
> > >  	tx_swbd->do_twostep_tstamp = do_twostep_tstamp;
> > >  	tx_swbd->qbv_en = !!(priv->active_offloads & ENETC_F_QBV);
> > >  	tx_swbd->check_wb = tx_swbd->do_twostep_tstamp ||
> > tx_swbd->qbv_en;
> > > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  		}
> > >
> > >  		if (do_onestep_tstamp) {
> > > -			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
> > > -
> > >  			/* Configure extension BD */
> > >  			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
> > >  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP; @@ -3314,7
> > +3337,7 @@
> > > int enetc_hwtstamp_set(struct net_device *ndev,
> > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > >  	int err, new_offloads = priv->active_offloads;
> > >
> > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > >  		return -EOPNOTSUPP;
> > >
> > >  	switch (config->tx_type) {
> > > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
> > > {
> > >  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> > >
> > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > >  		return -EOPNOTSUPP;
> > >
> > >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) diff
> > > --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > index c65aa7b88122..6bacd851358c 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct
> > > enetc_si *si, int size,  void enetc_reset_ptcmsdur(struct enetc_hw
> > > *hw);  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32
> > > *queue_max_sdu);
> > >
> > > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si) {
> > > +	if (is_enetc_rev1(si))
> > > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > > +
> > > +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> > > +}
> > > +
> >
> > why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
> > CONFIG_PTP_1588_CLOCK_NETC
>
> Because they use different PTP drivers, so the configs are different.

But name CONFIG_FSL_ENETC_PTP_CLOCK and CONFIG_PTP_1588_CLOCK_NETC is quite
similar, suppose CONFIG_PTP_1588_CLOCK_NETC should be
CONFIG_PTP_1588_CLOCK_NETC_V4

Frank

>

