Return-Path: <netdev+bounces-226633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC85BA33DE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58291C03684
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A03429D287;
	Fri, 26 Sep 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eN/6KUwz"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C95265623;
	Fri, 26 Sep 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880332; cv=fail; b=VHsE3noRGGTYm9HGJtPp6M/sY8G6rXpu3Lvoqd/YWQYUI9/V0je2pd5RwG2nRsaTx0QOKi2p25R3Yb3ITF4UGiKdroqGwXltYvGKyVcNo8Y0gGJal7RMqpCWtUgfY85FANW/hjBfnXPx5LIb+id/2OVblQiWqkWQdnyA2CPwVEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880332; c=relaxed/simple;
	bh=N9C3LINreChvVAP7yk7nuq0l6FdOl7U5d4Y/EeMV/eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kwRJsfpAlFz89j1EZQjSioPdtLa1cqjNFeOFYUfnN7lOYucqyj602VEea5N8uvTQHtKyq2+VPY5fk351NouuTOrQ3fToWmaHIowdOF9xENEr+7ttFNfL8i2UePSyytMW3c8QyhHYX5mukmy4jMA9ODv/hmvyUjAWdeCoka/CsSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eN/6KUwz; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdJlOGxjdEy3FZ+Z+z/hKkDsfvJIKCtjuVJF4lrV7s1xMG8jQpKSd5sfL1qLsn30Y373OPkzqQLuNQpdOhzXte81yJYpTeMXqxmX491RsmTVQd8z1zDlWRNdUeEIRI0h3a84n2aqm3x7hGfWXbRsmaTUnYWhugdoaJ5pbOfQ2mDlLk2Hvwvq4IpFWcCexe9MDZBCKCRju2jgYXmYCJof41UTD9Mf3zA70QPWdf+wBJyNkgxV7s5NHSX4lIraEn56DB/uwmjplwL3Y8YfuVYNSBzDWMmb7rn0ajsPUTR4Wz3m4fFvaXBUWb8ZJVoAepyT76ponIB9zNdMg9lKKIqe3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkYA8Lb5BZtNzvqhe7IluR+G7tDbJJSwZ8lcnypVJJk=;
 b=dkqfbZe8WLbraHasOjm3TRqmwnUYrRwUygyq4gyuCaT4ugoxYFcLWb0SZDpvWpPGDKUtlJzF6zcKCj+KiNG5V0FIBStJtJWHHffCRbqBwnRF9cbDtPnen+PbJgFr3K8l/CzzyZyM/smQQRUqnaInLSiqO00OcOZnkrZPyIEiTP46diAtC5DENKjDniFlDlQvkDDQ2Fu1om8DaGy4oNmd86W7C5zMY0xuyt9OYdSanJz7eshx9ym1rxalf9vzAtmTzhFQLdElBUs3pCgahVZpWqZd6lBnr7BoFEpG5Gn3QPJrJKmPcYJw0OdkEPegDJLc8eu0KTdk5/ZSMs82ukYRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYA8Lb5BZtNzvqhe7IluR+G7tDbJJSwZ8lcnypVJJk=;
 b=eN/6KUwzxDH/coP3Y5+gwS8xRZeMpIJG/jJ9iWLcDhkhcsNupajPAq3FDHenMay0WtwIPjN7JZf+2G054UORmCuMmqLkUZtRYApdCHPsjgZbR+OPZ2GkZPPnZNmrW1wwPwRdd0i+rcjkaI9cIXSFSQdfCJw0QOcJ+5JJWvtHDfNPHkEX88lSR1gJ5yUX00+fV/n7retuRY1YXfE83wjezr9Mbw5VYkDCwCkhqfAWuyy6ctJ5CDofjsO0OF8nsZsYN3GZ3S7TFyloagDXcHIa/NIQQ3fNg7sJ02EeW+ZYeZpGVCaG8wj5Wxh8PsO92J/gUB9q9C3hL/faqmtG/rS5HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:52:06 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 09:52:06 +0000
Date: Fri, 26 Sep 2025 12:52:03 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev, christophe.jaillet@wanadoo.fr,
	rosenp@gmail.com, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926095203.dqg2vkjr5tdwri7w@skbuf>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <aNZhB5LnqH5voBBR@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNZhB5LnqH5voBBR@shell.armlinux.org.uk>
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: 99860de9-80e4-4adc-110d-08ddfce25a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|19092799006|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adhO6zwE4bXZuRha6Sa8bn5F/uam1JmIo+4nnsKD+o1DsYyCwIU3wHs9DXtL?=
 =?us-ascii?Q?mRbzvOoXuuuZINjxV6S2iVeNWu4lxIbWuZXNMVLea8sOuC/kR9/lXImj4YD9?=
 =?us-ascii?Q?FBREiUPGUehrElcLgEHNYhdfZwQIY2f2UcB2ehXpQQBXGnmF0pva5Hvu1UC5?=
 =?us-ascii?Q?wCM5fAqwtY5Z6qdV3oSLhsjq9NhpIThyHuOZdXv6M/mRY4O6VEpJ06+kFuEE?=
 =?us-ascii?Q?em4AaUAFvXb28yRQO+Cvb60VMd5vCrOfU3NkIwEDVi5N28qQSlRw9HHtl9iv?=
 =?us-ascii?Q?skO+iLBj8pMuomTVx3tarq8C2/lw5ZGHN2H9LASiJYaoBvnkQjh5E8uIybmG?=
 =?us-ascii?Q?NuEuHWruNlFtgoq0XeTeq3yFJQ+twQ0nbIogA/Tw36YK5C7qO1E3b5ayEGG0?=
 =?us-ascii?Q?tVsAPdbtpGvkT2Vs0OUZAt5g5jFr+QYEO6suK+Z5CzNuOwKj+feQg+Ij+oN1?=
 =?us-ascii?Q?7/jNqwwZORQas7TqdoMDMa0EFuzvhjRVtP4zZLs002PgbmZT69nSRj9LYTv4?=
 =?us-ascii?Q?PbyqJ/UCYAatduLMV5b+Ak4VgZcDrDEytSHrR++7z1l3iztEC2rsTuar5UpD?=
 =?us-ascii?Q?iqYr+gEF6qoDVngu9Q6YVAd7Zit8JwBKoUJLk/Jl/9Z53DqS+ea2hrx5Qdas?=
 =?us-ascii?Q?T95XLlQ3HJDE2UjU3MISF4Eq8qoQXexjRLUDl4D+8DT68mvSGbwtFL8TaNgB?=
 =?us-ascii?Q?6FkcZisSbTvr6ksoF2DpEAJRvXHJEiuCvbsXIHCi/tQefkGP9F01KSL9Ifbo?=
 =?us-ascii?Q?srxAOQcNCvf/kxMp8HnWbhN378l8VIVOXwCvUc6yseAecxsOzkJIVmY1rTqF?=
 =?us-ascii?Q?5GJ4qXExOQVOAaYKnuEQP5xqL5e98IPQ36zWTH8Ex81tinT3b43tymu/f2nq?=
 =?us-ascii?Q?5riWum+BDNM8pyEmjw9FFahtpKdBYykxKQZpT5FyVKf5gcKB6NeFQXB5MQ1E?=
 =?us-ascii?Q?3zwskekoh3EmsnQOz54ehD+owynhqhBiI/DkNPeei0ijrzCrAyz7l6WV5FEv?=
 =?us-ascii?Q?nq2uZBLCAnSeUu8FTtvPA7Vzzi8YBYRkBzDwfdMt+vt8hj5SIXb1znxaFcQ8?=
 =?us-ascii?Q?QlTYyqKD0mTQV/lX9VCxdybHkM8cNjm87PT9pXuhaCB6Ppaf7ojMBFoihEOz?=
 =?us-ascii?Q?rD4vYayzRCMd1d7vzi+4aIyh2q9IKki8UQTMS7ttzVAeAhj2QdfftG63oOkx?=
 =?us-ascii?Q?XwF7GXKz7KdlR35vUsiLTsCZUZQtdxcH7WVRsXxFIgHZb3P8W1Almh5Ua6vb?=
 =?us-ascii?Q?qpaqb+WJYqV/r51wVeEX3pQNveheOCG4BdY0nfVO05eLWkHp6fz/ZvCsj+65?=
 =?us-ascii?Q?BjQnG3h7H2sGhGJQc2YsDfFz6XQRp6TyCopeob2UcYo7w8IAFqwNbSd61n9i?=
 =?us-ascii?Q?jst3D+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?821CvFBZR64RAtXcMwNce5vjCLZeKXMeR8jmBg/dciPaSeBlZTY6MVx7Udtc?=
 =?us-ascii?Q?pE6fwWIkEVQCPwVmnPLK7Te5clmLr6YV9nyRQbHyHvAxtdRGQfEqgQdz0QLL?=
 =?us-ascii?Q?xVrW7uioHJhlyE3bv/sooewYu+U4PqrkJ9KTQLmAvSkM1OwdsqACQUZJSALw?=
 =?us-ascii?Q?Bvr88Bo/jABbv9spv4ogOgnBLoAW4xWDKG61wEsFfIwRuk9mRRf0e8COAe0s?=
 =?us-ascii?Q?KIOQjLP/mXcViMTqWkoupmrM42BJZdMQw2Rbfvlh4TmT5nwK4QuZq/N2Sxpo?=
 =?us-ascii?Q?EKtZdFLIXi2Rvz96N48ETOVzL+LHMKsdJejhbliRGakbLGou2dl4hP5cepCD?=
 =?us-ascii?Q?dlPMrTI0cTnpu/LUDv4GxeBgDG0vD8jU3NfA+DKnmAB14A7HrHAT8uEBHAGk?=
 =?us-ascii?Q?DXM6f9hFPwYGCaCECVScrHtpSSp9Ce57YMdNFzAuHSsDIggb7hg5KEA9oCGF?=
 =?us-ascii?Q?6WHPwp1yBZGJepZm4ANik2UhLocqe7p6ucSgGhmHu8Mpsak0ChltnXV5slQE?=
 =?us-ascii?Q?iB/EctwM0aLJt/C4ffSdf9Ond06G0Zm94lqLUHMFDLGl0QrxkX9MlhkXj0B0?=
 =?us-ascii?Q?jGFbd/I9JvSeFLYpYOQyktB/K2P9rGjt6JM0n/tURqR7f1tlsr2Y4d0Y1kKj?=
 =?us-ascii?Q?Pg7JV1JB3Ltl+vz9NCW/GOX/PvKzBkwPoA2mBcngLq0u5BX+oAaCk9mySFvZ?=
 =?us-ascii?Q?HXgclV6Wtsuh1iNlmoc5Lo2y01sujLPKR54k9710yF1C9ByZP60AVtgXrrYN?=
 =?us-ascii?Q?cAeLz/k7xhxUe64PBL9PRQoVlxP2CS+dYx7xkCHYvwgfOQ4N762271eqxZ+u?=
 =?us-ascii?Q?LSaKQ8H5V6b5pUwcyUOL0lPtNUQzINSiiDPM/GtaV/TF2na0ehHvEcPunrOe?=
 =?us-ascii?Q?MVCrX8JeN9XWkr9OuX0EZ8tL1TiQZPJg80tnuyUl9KRkDQBzIhI4dZ9gyn9E?=
 =?us-ascii?Q?2qJgU/U2mZ4hFll5roiop+TB2q2Lnc2eAljITIU/EC+bBWXdDYU/rwtACf/+?=
 =?us-ascii?Q?S85B4rL3bsjUa/m0hT5DM3wd4zXNBvMN7M+GR9hEfB7jVKZQ8w8QZbs78xfC?=
 =?us-ascii?Q?8vTdm1SJ3zAYsTLOEG4vLjE6uTowyEd9nAI4FlixEMfZxv3Bk6EZ6zQrgi2h?=
 =?us-ascii?Q?WXY3pk2CixJzyvtCHiPnJT77ChRpcdnuAxS6JL/oFD82aRaPFvYKZYLAoyxN?=
 =?us-ascii?Q?32p0AQqdFryq1EARaN5MWExKMc9G0STrhw+ab7oSL4CqHYvCUlVuN78EQDJC?=
 =?us-ascii?Q?/Au+67QXTa/0NPDnhIQS8ccyZQmjJ8t8LmlRrrjFnlL+8+2wmWfBNCUQHHCb?=
 =?us-ascii?Q?QS0X8msxj4V3ZyEbSe92YknbSRtTUAXNHv+e9LqbkeuSh7M2eo/1kiUZM3KY?=
 =?us-ascii?Q?ZHryNGNtNsyH3UGtLVE/LnK6Q18e3GwO7XpBDVuqyFyGuS4zM2mz2sO716s3?=
 =?us-ascii?Q?YcaFtPakywfyipLET/naf80cj/TOBVjo0MhHxk/KnZRtC0Zue76vFIOWXRhn?=
 =?us-ascii?Q?E+Zx6WZ7KHk/3aWyppm+Fg08CK6nQNY8BqYz0K1L1I6LP1hbrIn8Kb1sJeB+?=
 =?us-ascii?Q?LqV+AMWRnNOsfRNnVIMIVAETiAVfmZqacrTdPJR4OHvMXPSlIp+x92upx61q?=
 =?us-ascii?Q?SGCDhzYI0MDO3w/8Zi/I6Xn5mGE1wfavKBSWhDFkgJPVI2SGKwo5VkPrjSbS?=
 =?us-ascii?Q?hYhqPw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99860de9-80e4-4adc-110d-08ddfce25a1d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:52:06.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVheI1gz8VS/ZzDgC6ZV6hFfr58l3u7/gwRrxPiBeqdfN7a6ZrW4AKnpOHSPFwkTFI8CGeaPBU51ynlkMArBiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092

On Fri, Sep 26, 2025 at 10:46:47AM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 22, 2025 at 02:33:01PM +0200, Horatiu Vultur wrote:
> > Thanks for the advice.
> > What about to make the PHY_ID_VSC8572 and PHY_ID_VSC8574 to use
> > vsc8584_probe() and then in this function just have this check:
> > 
> > ---
> > if ((phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8572 &&
> >     (phydev->phy_id & 0xfffffff0) != PHY_ID_VSC8574) {
> > 	if ((phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> > 		dev_err(&phydev->mdio.dev, "Only VSC8584 revB is supported.\n");
> > 		return -ENOTSUPP;
> > 	}
> > }
> 
> Please, no, not like this. Have a look how the driver already compares
> PHY IDs in the rest of the code.
> 
> When a PHY driver is matched, the PHY ID is compared using the
> .phy_id and .phy_id_mask members of the phy_driver structure.
> 
> The .phy_id is normally stuff like PHY_ID_VSC8572 and PHY_ID_VSC8574.
> 
> When the driver is probed, phydev->drv is set to point at the
> appropriate phy_driver structure. Thus, the tests can be simplified
> to merely looking at phydev->drv->phy_id:
> 
> 	if (phydev->drv->phy_id != PHY_ID_VSC8572 &&
> 	    phydev->drv->phy_id != PHY_ID_VSC8574 &&
> 	    (phydev->phy_id & MSCC_DEV_REV_MASK) != VSC8584_REVB) {
> ...
> 
> Alternatively, please look at the phy_id*() and phydev_id_compare()
> families of functions.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

The phydev->phy_id comparisons are problematic with clause 45 PHYs where
this field is zero, but with clause 22 they should technically work.
It's good to know coming from a phylib maintainer that it's preferable
to use phydev->drv->phy_id everywhere (I also wanted to comment on this
aspect, but because technically nothing is broken, I didn't).

