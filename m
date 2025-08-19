Return-Path: <netdev+bounces-214982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DCB2C73C
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 744E34E465F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862502773CD;
	Tue, 19 Aug 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVOs2Hpu"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6352765E4;
	Tue, 19 Aug 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614347; cv=fail; b=XPKJB7RBVOD1RGz3Ya3Fa8TuRdSy7jELjTF172INAW3N9UtSDR5ILEm6tx09WaFry0tJYqtljqMaBkdlsP8CEvuAAIooUgWcU5Dfd45/lTwWgPXdCzGcERfN7yRHX29+Hsl0PHY0GpPPh/zp7R+KegLFFbNx56ugcvQcl++2X4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614347; c=relaxed/simple;
	bh=TgOnYKBAFVj9V1dWbJmkCmXNZJXCdgGF0l1Ziosnblw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q2qLhzVC6VQRLl0bDzg+YScePje/xEkaWMMOfndZh9hstG2YFrofnpUFBi/s+zVXJzGhVVhtcvjxr1aiUUXcfbkVOOYcrnlaTvw8h3n1yVzrIN2SxIiYW+BzwmyHJpeAgNczrj7NOs8/LGmo2478LrJiXnIaQaxcmGzXMFr1c5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IVOs2Hpu; arc=fail smtp.client-ip=40.107.162.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyaDAZFzvCjInWEdZsX0bDRfw6Unmh+QpDGEE772QsnKMn1fWnoqu/1nMfbWuHKETe05RNo/1ia1J/kwHTVFoMIfosoNPL4/JN5w0LGryEzt2Miz7EuVBgrtGFcYzL61CEKJPmcSfXnBaoJ1cKNU3knf5mVdDi5SnW9Hh+YxS6GemcYeES6u7/NIoPzhIS0DaVfnHwXy46tNB8IYrs14V8qXC+uz363weokv9Gtmuf+pB2J2fKiV0n8S6VZlEGOTlwGdfVPWptEdLOLSEt3HhsryNTVkKGlfQrPjBly+9QF92qHuu82FkkAz49qUpLNW/di/c36MNJsTHczc4gSxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIFJSwDoLjgtxRyLdNHKvSv7eca3nLUeyNXRENhjEKg=;
 b=BnJDPuYLwdErVRDzTwPPRrTCvnKZsOVQCPDcsOs/sykYXz+iyWMv8Wffnjwbx9RUgNvAJ6K58tId0GnP0jgdZoZ8EHQRCMQB2xQg10aoLAMjySp/g0xgYjEng60SFWPsJotsxbz0e0567QdnRXij4UaOIagFXnE2RBLxC+lBCTWmD+xh90OuPdC3D+CLR4nTDEsItmsszyUcte53eZWmPB3YeqNBscsue/stIaoxjjz0JiO6z0OFap8xyNJzPoPRlviGyb/+Wq8oluNX9m7NcOmWs6CZ3XKTLAr6iGnCRVhAOfY/E4LTtQybi71GujeIy1Mv/QMVUiK2JT58/ElXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIFJSwDoLjgtxRyLdNHKvSv7eca3nLUeyNXRENhjEKg=;
 b=IVOs2HpuEOhCdHVA2Phj6wwsEgfKcgyazdihjy8/0sPbcTjxO90uIs9RC3zJmwzj5VQHDGvXKlJivng3SaSOSVii1KBWiSzQGRszBhpv7nj+CnJeYdkXZgXe1MatVpVNb8djDthOiCnVTqQKR1EpZadX5pn88BAppvdvoFBPASgYu6ddJEwPCku/ZFD6Fli2jyMhY+nS4s2opWtRRrdWF+uNF5BFfLYsLxlc6o5VbHgjWWZ4pfEeo+1uFUsnhpxEDWa6RO+JOZk7fzQnN5xK9E9AJMCD1sTz9aKj8HosyUF79YKf7pqF/NJ7ybWBgVER3SyI87XFC45LrR9eziL6DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10752.eurprd04.prod.outlook.com (2603:10a6:150:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 14:39:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:39:00 +0000
Date: Tue, 19 Aug 2025 10:38:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v4 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aKSMeI/mBmRxxDZt@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-2-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0182.namprd05.prod.outlook.com
 (2603:10b6:a03:330::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10752:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3a625f-3665-40d9-2f5a-08dddf2e22e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+FnQgRpd3qkycT1N0Rnj1SGFkZ5zIY8nqJEBn1Q63SzzMMu6XEivv+tQOCo?=
 =?us-ascii?Q?n7qcQrLHWniNaXoYuJeHHo2t3hX/VcJjk8X7opNccyS0Rtj4FWnzf3gR/RvU?=
 =?us-ascii?Q?WKNeQ34IYQFHywgTdOyem+LNfC+61EOYZxYHwIJqEk4alXd1qDBJIlpowMlg?=
 =?us-ascii?Q?q8e86jphdxgHXZEnOaK5NBGIS20rcKoEQqQXAa04oqOb82ynnfMDLXN/PKGw?=
 =?us-ascii?Q?8qzqsqTo17DPS+bhFfSyn90cIzo8p65TxBLps433bwMqj0C7gLnorFxX0MUi?=
 =?us-ascii?Q?vpFEXxK85FVX4VsdBC3d+ynZ1Vla7fdur18bn9VvF6pPm3RNeC9TixUu0G/+?=
 =?us-ascii?Q?Um114a3Z37NzOp3QvZ80H5oEZHZScI5gn0cJAq3oPcaR50F1qLmrh7faQXaA?=
 =?us-ascii?Q?g+uc43WkvCjpPhn39Ea2DQFUKaF7D5L0QDm6GrRluAC+Mgcgmqi2Y8XNLFdR?=
 =?us-ascii?Q?8SbE6QgTJdgYUxKmjn+Bn/JpW4uY3J+n372csr3Pb8Eif+qRGIk5acm5kQex?=
 =?us-ascii?Q?fZK5s6bNt/Y6qv02yL2dwgCHeGRaTX7tEY6ncTj3rRI7MWuZ2D075g2vQQaw?=
 =?us-ascii?Q?ea9n5D7BiEifRXNviZz88zsv77fTLtpvpGb/Y6aNwYymNARNX3Ka3n1Yyy6m?=
 =?us-ascii?Q?cBotZWPsrGI14uBBdMR/rdbAqHBN1CbxBF72AewQCr/Xf7PdqT8FVNDmnsb0?=
 =?us-ascii?Q?g0ud5rwqWU0UbeMAwUhFCRyt1B8xIjDtRPl5JeSpaikQlgo1rriDlLJQTIbT?=
 =?us-ascii?Q?7R20VemP+arsONzoG439rZ+/IaDDNbV0kSKNMq3b91QPFyRnOl7E8dgwUhUw?=
 =?us-ascii?Q?2g89N71DFJSuYJCMjIPJVujceT+bqkP9b7Wqn4+c5DnppAZZLZq/HhhgVPH1?=
 =?us-ascii?Q?roGVufBF1MgoF1/KcvktcTm5IrnxDzblS7StdcNiO5/ZS0BX23GWVnaRkLLL?=
 =?us-ascii?Q?jbA+Sci3rmSGHRw3zb+lKg3/ptXCWsNh+koSlBu2ofkLTY4w9d09Xxvkx1Tr?=
 =?us-ascii?Q?hSaDETs13gPluPJ/5OnibqJyGSgXiWHRSbqHzzucgSXkUPZWtR7wI3XrDqJy?=
 =?us-ascii?Q?AcTz5FjVEc+/VDwg0/Q9Gkz7RzepoXwTkz4YntaUGdbIB4mZ0/BN4oyCisPS?=
 =?us-ascii?Q?eYsA0EGxkGNC9qVW4lRdFMnzrW5Fjw0mWuWYFQvEYUiYMPbLrhNLyhdwsM6e?=
 =?us-ascii?Q?Jv9fvXbUYdJTv54ogpD1Kg3UAdruQIFCPa3SBNHn6IZ3QldvpnA9C99AXAJ9?=
 =?us-ascii?Q?4zIf2Zm8ME6iW3qBaaSoFbhdoeegqa8Jfm1oFG3jl4+4tvxG/Br0/xroFq3D?=
 =?us-ascii?Q?hrHJFit5zYzWJgPK15sUwemH5GbJDq2JVVOXnY5AzcuYDH3JbRMcvmWruvvH?=
 =?us-ascii?Q?oqvGavhF65CRGntSbd2tOjTyKBdgLcDm3xDu87RyZclsHlHTOnn/kNId+9FP?=
 =?us-ascii?Q?P2m/2vvRFqs5NASMJx4NvKPLgLSSP1XI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlzcvFzOT/98nE9gy59e5bRfgD++Rr8V1vrLDSqv8lYRytK6D64CIUVlPktH?=
 =?us-ascii?Q?HgImlP6822Qoh6DiU9Y6Inbi03cF7stLjTmrtVStrusl4rPeFEIn8R/L4io1?=
 =?us-ascii?Q?AuXu+JEBL4avcTWJuyf9rOswOPtwojYQDw2t0mdB55RYaBnsmWG2sODDlOUg?=
 =?us-ascii?Q?5bjLR5psgYoIVXK+y8MHkmDBQGX9PSBkszrV61ocNNCxeL0jOs/g6Rm3cbJ1?=
 =?us-ascii?Q?Oa3R1EgkHpTgNn8govs46J5u/th1SwQPDk4Wk6jT1UZ3WWtWDd5w6I9xKkDl?=
 =?us-ascii?Q?TmeL6NHX1B9y1aFDrd0RZOdFAlzRnruxmjpnPpKEFdKXKYSMP5RI+SeklKvC?=
 =?us-ascii?Q?1xInzSkSM+qzfTGly6Ok1qykXz8S8ViQxUtYYtDx8JjVLFni/FwXHmOTJ5fG?=
 =?us-ascii?Q?AlrxfXi8rzC7mfGrmn3e+WrmmkIXe2rdEQUXCcsolCrwAejdTUUQlG7i/jJC?=
 =?us-ascii?Q?ecmcjC9mX3PG89Z6KcUi9WsgPiE5BKeY4RW5nTtpr6xSF6WOq/w4oM87Nybz?=
 =?us-ascii?Q?SUvxsjQ9gcI52ryiAOUmkbFqWJ0/ht8M6J6YQpOsJ1qVzhx792SHm5k5a2R5?=
 =?us-ascii?Q?Y22tjWjri03OZVwDqLxzIzUp1tzoOHLvN7NBH+kLa+50/Adp4yjz99nnkVIN?=
 =?us-ascii?Q?pdaxaCqqHgR2XSUsOhcrqH2qVpP1Nz69ooh73p/Qsd3K/FmgMJaeaHpdV8kv?=
 =?us-ascii?Q?FLufS18SEGRNfQdSnJvGhe4LGnCRtohbHmR/t+2GNKSiIX1s+h5yy2n2mx4e?=
 =?us-ascii?Q?3DIBOqNzJyKJyPClDyNUaB4LyHpZmNJ1Q1X3iw0D7lDu9VQ5Eu4ViF5P/Yma?=
 =?us-ascii?Q?cDAhG+cL7cLdGuPl+l/Mmb7xYmdTxUuRtyRkO6E6IizDmUH7SyJBkXeIILvA?=
 =?us-ascii?Q?PVpbA8UULGPVyKNgZMhaQJ0MBQzUijOYQvTnDFoovL7kfue2rm98fs/GwnRt?=
 =?us-ascii?Q?QHUsZPEpqsyKe1eRadsxCP6GpIEmoSL8uYzzTrrnEorBLNKJmVO6PuXFxIUu?=
 =?us-ascii?Q?W+tQ3m1WWja7IKViv6iL9lWHi8K8HMoOUE/Zfapku60OObGig3o7mzSkeqjw?=
 =?us-ascii?Q?OUUycfEvBGS/8tEF/iqjivSb0lTyrM22zFCJnBzRNZ04I6MGMdcmFNvIUIZe?=
 =?us-ascii?Q?dbNimcf9R/In5TR+/yGATmZywEz4KsB60F2/fMwMVkRK09JWK7euvMGZ/isg?=
 =?us-ascii?Q?Gf7lvFA3XD0AgR98XyjhyEGP9blRWPSlMcFIPPpsz+Kzt5X5+rXRXC86ZfQK?=
 =?us-ascii?Q?ZRiHugjuwaf4hFmBUeVP6RLymV4gT8JJsD178F+afyRo14G4Ibb7+MCQ8Rw6?=
 =?us-ascii?Q?h18h9ISnhoUaX1loBTxAVAfMeAg99HbnH3rKOEym4m1c/sBvLbpHXcUERqYC?=
 =?us-ascii?Q?P+SDRFKRFrD5kMHIA/3ymL+51qsMmmJXL/ZNeiBCMPLpX/Xa3RlAVqzk/fnG?=
 =?us-ascii?Q?e0eLEbFH06Cekr+y6Zjaj/uunR8D0IUhX4OY6e5fox32moRz7vvqvzOMPkli?=
 =?us-ascii?Q?1S+UJ4+5a0aCvVWIHAgln6KH7vSsopznlNzGTbvxJ1z2LCMa+eHrG39128GJ?=
 =?us-ascii?Q?6+l32x0G+h+9XwkJx1yRijYE1nBKKFGk2YfBvlMa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3a625f-3665-40d9-2f5a-08dddf2e22e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:39:00.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d5mh0aTt+CekJnUglTp4p794VEsx4A/GB3Xiy/NhUGAhoh1sLBvkHvzwvcKFp3RWQIeDLo5ZLvazy5RzSqiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10752

On Tue, Aug 19, 2025 at 08:36:06PM +0800, Wei Fang wrote:
> NXP NETC (Ethernet Controller) is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), the Timer is one of its functions which
> provides current time with nanosecond resolution, precise periodic
> pulse, pulse on timeout (alarm), and time capture on external pulse
> support. And also supports time synchronization as required for IEEE
> 1588 and IEEE 802.1AS-2020. So add device tree binding doc for the PTP
> clock based on NETC Timer.
>
> It is worth mentioning that the reference clock of NETC Timer has three
> clock sources, but the clock mux is inside the NETC Timer. Therefore, the
> driver will parse the clock name to select the desired clock source. If
> the clocks property is not present, the NETC Timer will use the system
> clock of NETC IP as its reference clock. Because the Timer is a PCIe
> function of NETC IP, the system clock of NETC is always available to the
> Timer.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Remove "nxp,pps-channel"
> 3. Add description to "clocks" and "clock-names"
> v3 changes:
> 1. Remove the "system" clock from clock-names
> v4 changes:
> 1. Add the description of reference clock in the commit message
> 2. Improve the description of clocks property
> 3. Remove the description of clock-names because we have described it in
>    clocks property
> 4. Change the node name from ethernet to ptp-timer
> ---
>  .../devicetree/bindings/ptp/nxp,ptp-netc.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
>
> diff --git a/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> new file mode 100644
> index 000000000000..f3871c6b6afd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/nxp,ptp-netc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP NETC V4 Timer PTP clock
> +
> +description:
> +  NETC V4 Timer provides current time with nanosecond resolution, precise
> +  periodic pulse, pulse on timeout (alarm), and time capture on external
> +  pulse support. And it supports time synchronization as required for
> +  IEEE 1588 and IEEE 802.1AS-2020.
> +
> +maintainers:
> +  - Wei Fang <wei.fang@nxp.com>
> +  - Clark Wang <xiaoning.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1131,ee02
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      The reference clock of NETC Timer, can be selected between 3 different
> +      clock sources using an integrated hardware mux TMR_CTRL[CK_SEL].
> +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> +      The "ext_1588" means the reference clock comes from external IO pins.
> +      If not present, indicates that the system clock of NETC IP is selected
> +      as the reference clock.

	NETC timer reference clock have 3 clock inputs, sys: from RCiEP,
	ccm: from CCM of Soc, ext: from external IO pins. Internal have
	clock mux, only one of three need be provided. Default it is from
	RCiEP system clock.

> +
> +  clock-names:
> +    enum:
> +      - ccm_timer

look like just ccm is enough.

> +      - ext_1588

Missed kk's comments at v3.

"This should be just "ext"? We probably talked about this, but this feels
like you describe one input in different ways."

it should be "ext"!

Frank

> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        ptp-timer@18,0 {
> +            compatible = "pci1131,ee02";
> +            reg = <0x00c000 0 0 0 0>;
> +            clocks = <&scmi_clk 18>;
> +            clock-names = "ccm_timer";
> +        };
> +    };
> --
> 2.34.1
>

