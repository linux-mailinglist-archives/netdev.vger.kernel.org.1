Return-Path: <netdev+bounces-132001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFA9901E0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F0E2812AD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ACA156236;
	Fri,  4 Oct 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3oQ5KaW"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013062.outbound.protection.outlook.com [52.101.67.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F8146D6E;
	Fri,  4 Oct 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040434; cv=fail; b=f9c4PYf62Db6McfYdmAQ+7LcWBQnJof29EInWJiLl2GhsyNRGs9K/Ne7tgXeCDUgMWi0OBhKbeg/7oaoZahfW7YUryMoUeCvxwgWpm9Rsdoq05hA7CWF3sDEW/C9ZYKECdezjqVAtAoenyV8BO8Av1uacfgO8wqFLqQWsAGKn3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040434; c=relaxed/simple;
	bh=+T/x4c4Oa9D2/PDaN5D98lA9T81VNMYGRZTsXgSIJvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwplMit6IGHd7FKsJHZHQWCkMN+YjwVsG4ox7zSMq2TLBtL/+yW4tuLLnZJNvX/AlsCZjQKzuA3n3FSTxVCOQO1tC7B1du25redKb5BZf+cfmduHVYWofe7UQ6R0HzC+IZsxjMNOX9MYWOLhue0xNLkceNYAkr2QW7T4/W2sHrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3oQ5KaW; arc=fail smtp.client-ip=52.101.67.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcEeH2cLJITiJ3zquCKWCIlOSNIGgzgQHrLwKeQ8mO8qUrsIgCCYWufBaKLxGrbhCoawC9dCGNEn5trPjF4Q91jZP+w9nbns3G1llt+dj6Wxku1CpCYKgHh+cIiWwK4ONAsNUxASMIxMEVHALOdy99LL0CeqAwXPMbZgVrJ7YIvw1FCJ7Fdd8pC7T3+7aojHUPApfcpQNG2Kj+3jfrw1uaNVkHwCKnZ76QL27skplrfAdvLtF87eDQDLpLRd+mjtygvuuYflqlO4q8OVUm5WgJ4moriSpMYnMRh6YP+/63xuhNCvLd3A+g2D+v9BjIUV8A9/etP4vjCTCXFu6MzJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I83QcKSVO5ycoRNGTj3AD+2rudeuaUr6zgakR/Zi13Y=;
 b=g773QqzF+bRSpJIxvDKr6qPEYhDYeG7JVwuEz8CY4JLVJhMz1jNIgGAzdIK8r2DxtaEfkiZNmaBwCNZCbwevblLZ/MxQN9QuJNmwhn1mrztEz8LCO4BcoUx9Ic6hC27tRjSuUFw8agIbOjHWbqp6Yyf2Mm5qH25fkyjlQRTe0nmIM7WWiJy+cAj5Jk7PGJK3xFtcQrdFscOq3POhbV4vFKWZlI9Fk9tn9O/AmfWkT5gCARrRBUmRpT+/QrtF7ZFLIjNHP+Gf1Q625cXQ+7MdVTAPRGIgoW5E+tDNNahgECW63zhyUGqLnta1dCNjkUtCBiSGRuhb1ES3puquumq2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I83QcKSVO5ycoRNGTj3AD+2rudeuaUr6zgakR/Zi13Y=;
 b=G3oQ5KaWSzqPr/NnpOwTavf4VvM7wcO7Zq0dAebi1j7KGuFoW07txXjJWirLDwXK0wh9j0gT3/fr/Sf0X6tROce+pnv4mT4uxPYYd/c6m9tQxPTguzDOnWFIgmxYtLvNQxKHodBbDqbgZFyTnFmTGee8xud5NUH8zbTdRQ9b3V465TdKmbGeFCiyPuUkiBHJbC9KLVK/bBwMOfwh8kCSk0VsNC4yWA+cxqdXaJH5V3nETUH45za+P3SdU2aQvl4ZMjKV41RrCsp/xd8yh63z23m6vN8Ys1avK0A1d+D2NH4NBF8K9qw4QrBpSng80diwYLOIfZSdZntS7epDZddSkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7025.eurprd04.prod.outlook.com (2603:10a6:208:19c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 11:13:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7982.033; Fri, 4 Oct 2024
 11:13:49 +0000
Date: Fri, 4 Oct 2024 14:13:46 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 0/6] Mirroring to DSA CPU port
Message-ID: <20241004111346.ctsq5bqqq7zfpsuw@skbuf>
References: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VE1PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: b337d26b-bc00-42da-8814-08dce4659f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CtjeWIjC1/RwRqrNtUcJqyCDZhz3ttQZQHdCjRi1b/nIeGpb6MlunlZdv9J9?=
 =?us-ascii?Q?M5vOpdaWUSxcKObMTbYYYgnVjL9UAPLK28Uli8BhM17m/p+W16yMlCOgeYca?=
 =?us-ascii?Q?tgGcRzgTXOhxcB07cE9gSANG4h2690piSuwY1KzvfLY0erUWWPu2Ma6QgOAZ?=
 =?us-ascii?Q?UG8JqNwTVkjryUKPH1/FdLE5FjBrVgs7UI8iqwzBwypoaGEV/fbbeyNlUUnH?=
 =?us-ascii?Q?O1WzXBuDkGJEQ0Jn38/IvjBO6tKIvtmcn1t/FbatVYcmSao5XWQOiiRiy9fL?=
 =?us-ascii?Q?IhrwWCkx5yR22CLmhvI7F+v1d9N6z7AF613+aggua9/Ev4+ERG2SWz1S3fN6?=
 =?us-ascii?Q?WRM5eadrxM+XweMxqvpyWpYkhBHTAkO3UAEb4SWAHL3SZyo9GT4O4LPCi4MO?=
 =?us-ascii?Q?iaSI2LHwO36EpB+sqgjbFkEcJp7idKfYR/cuErBGOgL4ER+fR5XBZSrjz1S9?=
 =?us-ascii?Q?1UVzuDCpquCWcXcYk6Rurj2MfFkt7hWPkmmHV8Pl4wGOqzKzNzAowAj1Alwl?=
 =?us-ascii?Q?KJQOYTxXzVMjHylfTOOglTN3utbJVd7xfg8QrmPHpM9H0lXobfKE5rFsRkdo?=
 =?us-ascii?Q?C08DXg2F2uER7/6i/kAxOFUYx1f+pacwX504NRMsEnQ750tRk+WKkfxLOAW2?=
 =?us-ascii?Q?PHRTyR12hGbLqblHP9XzxApJ7+QWNlO/DgPQIuaEPUw4Dcg6Egp6jRcSPvyo?=
 =?us-ascii?Q?AqIovb3rh5fLtq9QRO6Ui6CpU0DpYs98ntCp+ksHQ8kKFzo+4YjyntJfk4YG?=
 =?us-ascii?Q?reA4cclZCVbc6zIQR1L2KFBmETFdntdVZ6gVIHssS2zCd8bjcFNCKCphOA4v?=
 =?us-ascii?Q?x5YA7CxltOK5jgzxMmIpXT+/Lvdu0S6T7OoH2xdTNWni8sPIyshWUGmOGpV+?=
 =?us-ascii?Q?iUd2K4YnJXtFUXauzDi9jiu3fpu9iZ0Gfp6LWgBYfJmgsTpmH4v71vzxK+bG?=
 =?us-ascii?Q?kAPokWB5MwDTTVz9Eca+04vgxTCzx6p/7oH8MlWMIHfPeLm9R95H5kgsyZ8R?=
 =?us-ascii?Q?sFKNNIG5DIIoEg92Px9/K2vU3O/TtNC4OYaW9JsxTwGV+ay7fvmVpkXtFf0u?=
 =?us-ascii?Q?ed3KtsxC7kucL8rd3C5Bg/FgAV5OzAGwOsx+j9btVesRB8i0UojR8T60EX00?=
 =?us-ascii?Q?vXYxEtpuWN29CmCaYDW1D7kJHOMKv7jV8+OQb4iflc3UKxpkUo9WgoTEC7j5?=
 =?us-ascii?Q?ASPKGnNIENHvuGIveAe+G58WBg3lTNdOK5oiRvC7cLxHLAC8AhWb8BgstvK2?=
 =?us-ascii?Q?yqatv8hQBXxdi5TIvIEpeWHRf/iIzbxH+acKAfLE1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3D7VV4qqexdt7SCJ4pU5DqY6KC8/9ex7wu6GTauhSmHurfQX1yFxCq03ZdH?=
 =?us-ascii?Q?LfNXYeiFZAnOlJrMc9Ql9e+Znh+IWhVj96y81KC4Tvp6p6FsT9ni7SzV1Zdx?=
 =?us-ascii?Q?+I5qvpfruI2ubO7A2m6plR+9BpOGUMNMyZ2WLoIetTbDEptTvB4QhLM08sTR?=
 =?us-ascii?Q?xkGYLDib++ma5au0CrUa29ZBa2gp132PfRB4L+lBeF8m4k2cgMWJdYiq3zaB?=
 =?us-ascii?Q?secUmFquxSk7CE5BMrQeioAe4PtxA1ZLkUb67j0Wptao4ALFoo6jEZOzuWnu?=
 =?us-ascii?Q?+4XQhv18CKkvHe1VEkCe2ExIhWtAocbAVVynhc65YFTFXd0k/WvHGnJ1KzQK?=
 =?us-ascii?Q?1L/5ZlDOwgak9ljv4f2xh1orKFCTJYnZ3ORCEfGC7vCo0YlOWAmuVJ4xLbon?=
 =?us-ascii?Q?6vg2wGy+JhB0eaeH9IilP458xEPhQfVuICQJHgT8T/M8XM/jg4A61bLQ5aSu?=
 =?us-ascii?Q?lY6hIOcVZV9Sfas+ePvNWoTyB9ZCMjnlthoNctBwbvpqMaI+z8buROpc90wI?=
 =?us-ascii?Q?ZvQWPbHrd0DZdW8/MqCWRhRViPVxBCY5VkqtFSt+GKuOjY0DQxtDC/RcuLuj?=
 =?us-ascii?Q?Pgw8SIV1jFLNLqGqRWcEZJzXobTghUnvMz/YXc7balhA+TSjCAt5ZvJaXuzv?=
 =?us-ascii?Q?U6cQCkMKTYpKpRWiC3b9Z9A92v/hdAKnBDZYB4ZoXjpnYm/bL7pBL+uxJY6j?=
 =?us-ascii?Q?relyzPfoy5Qy54WvQzcL4sGCNVq8jdh2oGTbYVU85pRiwCYlDiAcQt2hHT/X?=
 =?us-ascii?Q?y4Gjmy084mIiRZilDL/QclHzpXzVmzc9VwnfKEsw03UoSDOhnpH81MBWZuea?=
 =?us-ascii?Q?OVjgFBOh7I3XZGVFcND9+zodR1K3zIsBduKMR5wBROS5R0fjFzlTmzY3nwEL?=
 =?us-ascii?Q?K2QjvmKHFlhMJe3CZrZUWPnsAzwBDvJNPsE2bBBk+SAVrxmcm9oF2grCyBLy?=
 =?us-ascii?Q?DeYo+fVwbSV19My5IXgUcEt2vn4FHwxwaTXjnzouY/sEov+6Sbtw7obbt/r8?=
 =?us-ascii?Q?iDFiYNKcfnrfRYpBR7nJTbxSFT3G+Hl7c/rWAPpxCTtKdqhjyZIqlCAjqO/b?=
 =?us-ascii?Q?tk3o4a9gTXhyFyFzEFXCuJWg1OU2l26aF1VL6ZQtvc3WgY4o1jH52lBhTurU?=
 =?us-ascii?Q?QZgLoo8OedY0UeWeVbb0IV2vpPDzIpGjHlNx5S1izBM25FsKcPbhtpTWPdwa?=
 =?us-ascii?Q?mE/QGrXGfN2zYZ8AlBfs3+snPFfhVhEERc8KgW5uWJFS0t3EkuZ8A7liL9Oe?=
 =?us-ascii?Q?7H4GbxV6ZPd4nOKztr4nUOMIvlgG1OPW6t90LYooyxdKfyMg6yGM2UrFDGXE?=
 =?us-ascii?Q?aCmahF36y/zfiYyTzSOu76opJNPAaIg8rCQqxd2FEghWvVFW8WFBcPtN9VLB?=
 =?us-ascii?Q?BBSs/tr4VDdc37yv2HCrGSR0gcUG5YwMSzok0wk+9fXE88PCIoIfnPSJLrAg?=
 =?us-ascii?Q?FBMK37WXjUT7GwJ/7IE+lN94L9f7dofVyjsRoThb7M5RC/H7a7YLjnPBAVNf?=
 =?us-ascii?Q?5I7eciQwhFioflTESClqy8Qh/6fUkuRZVO/zZuUiRdei5AN3Lsaeo8sq/r4S?=
 =?us-ascii?Q?faGNrQO2RcfamKUVPLa1fGprMXJY2qU2UQO1DZsLbebvsoFZBo3hR94JQoVe?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b337d26b-bc00-42da-8814-08dce4659f41
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:13:49.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOmd7ZgUZxX7iZURjoi3fjpmYX3aOjkPhwnINVhV4udQvdHI0ZyWXVgS6wj08RLB42OTyQcckbLQQMxNSqst+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7025

On Fri, Sep 13, 2024 at 06:29:09PM +0300, Vladimir Oltean wrote:
> Greetings,
> 
> Users of the NXP LS1028A SoC (drivers/net/dsa/ocelot L2 switch inside)
> have requested to mirror packets from the ingress of a switch port to
> software. Both port-based and flow-based mirroring is required.
> 
> The simplest way I could come up with was to set up tc mirred actions
> towards a dummy net_device, and make the offloading of that be accepted
> by the driver. Currently, the pattern in drivers is to reject mirred
> towards ports they don't know about, but I'm now permitting that,
> precisely by mirroring "to the CPU". I am unsure if there are other,
> perhaps better ways of doing this.

Since there aren't any review comments, I will just resubmit this to
net-next.

