Return-Path: <netdev+bounces-243895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7CCAA2F9
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 09:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 151223011310
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AC23EABF;
	Sat,  6 Dec 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/DonLWy"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448D22127A
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765010473; cv=fail; b=YTNpjOfYNcZaz3rQLxBFI03FTF8J3fy9zShbpuPBzr6EAkFwjqshaVGcLycy1CV/p/Rw9s9dvD4+8T2LQn+RJGj7AscBdBPzZW9KYOtZxV65w37tgbMA5Ag0CorTMaCPIlXCN1Xz10LldMONcHpd2ZZiu7VveU96byrLHzBV9kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765010473; c=relaxed/simple;
	bh=VqFB344u7FtrMu6pe2hncHKbcqNMb4stTrtiB+hkDCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TKGA+pBXOQhuIQqwWR00D8BMco/vfjVRmrv6bu68CmT8TKeYzwwjlBe9KLcVgjin/SjEkTIjbnX8zh9t/YQAcTB7CZa/NXaouXeg1Ip8wKdQ3pWnnxAyK+lWbAJpStKrBFMOT1xeyDdlDceCxTFNGPykn6rWB0ppfR3P3fdAgAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E/DonLWy reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXZ0fTQdVJONiIq4hGLSELm/flIwX81gK/Jm4FhQaCMjiWnn9AG+D9FZXFWa3v/vKCjV4Gib6GWmF0hJTx1LX8QjI2jOUmonZQW3pbycjIvXJSkQbraiR22iAQwwJ+XisnvP4Gqthknvsb1tVVDjfhAedLVRLWte4IH6DG2Vypacu5O7pB1fW/Hk/0JXKqK9r8waLjFUgtWPZv4AVbOtSade6SoCKMFu9CSKpChQnM0IF4q/tpAa/hpEUMmj0OXip1F5qyXHvQjJPGgVGbFrzrN5ckMHXSWZq3ZMHvikDOBHKrOOEtPliKko8UEcko1aM1L++AvtmYZ955o3Rxw/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5rDqxHtMUWN7VfrZBvsblUXGOJg1OpWWA71p47ZOSc=;
 b=WdnniB/SpkAF46rHwZsBSfnImWGiSHFiajZcS6QuunbbLilcpUn5XKwdqjHXgxhm9636bntbkTSKpJlho23psTcJqt+IVtgZR/QJOksqpZLzhjSHNuzxKPKb079sIqCQeNcAG5bSvLwiPv/AZ42wkgF4Q9BVrLl4U4/kqisRVl7ZwsQrq87emX1ZUVtAgpadVGikoGkUsBdwsyXAr4WtQ558hbhWhanLNUpjzSbLUUqgJmwgroNC1zrvczQfKtH8WPyXmy/JrOa5bFlTpw1Wx2fEQb4jwisshtT0PYQh6ezJASALjorwZS0vp63nejzeHf8dGrFL46H5h2Bsmi0BGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5rDqxHtMUWN7VfrZBvsblUXGOJg1OpWWA71p47ZOSc=;
 b=E/DonLWyHWn3zJsaBweFSelVATSt0InHkfR7I3FXV857w3gLsMg9nXzbkKwPSQCgj0zyjYdnFHbxotYA8gd5T0OCkKs47LOPV5a3n5BmCWjTV6hWMWb8rL8flnAE9GdMDDi7aVWmXq5fRWAe/26t/TxX8CY/mqdq56cW9H56mUlt5ubGXJgumzht8O2e3c3yJ7NBLGFcV26VKEQ1bbPSqfw8hiUCaGB4RnYVYYcDNc5vAXh9gjnkkQRLdnU515d/Xk4IZY/EbjdcNT43+EVdheheQQyw7PEerAMLsxshQFtxeJdztFpdsnTPmb2FMebAG2JrJj4mLER1YP/xtbOH9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 6 Dec
 2025 08:41:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9388.009; Sat, 6 Dec 2025
 08:41:06 +0000
Date: Sat, 6 Dec 2025 10:41:04 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [RFC] net: phy: air_en8811h: add Airoha AN8811HB support
Message-ID: <20251206084104.prufjf2jbvtwctlg@skbuf>
References: <20251202102222.1681522-1-bjorn@mork.no>
 <20251202102222.1681522-1-bjorn@mork.no>
 <20251203232402.oy4pbphj4vsqp5lb@skbuf>
 <87sedq4pyk.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sedq4pyk.fsf@miraculix.mork.no>
X-ClientProxiedBy: BE1P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::16) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b63f698-b0b1-4c94-2f8e-08de34a33278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?q1MixSeKtV6RrBmiDlCQEf73l1A+5VUe3qK8YiF77V209e+XW5ZCNdr7sf?=
 =?iso-8859-1?Q?qIeDbDcpDCWMxGmhLd8xX4i9H3JHxj7eLuCh987/uO2fwpZ4z1bvQ6A+Bt?=
 =?iso-8859-1?Q?Y/Oze0Kf0NA5NNDSWPUyr2k8AWPII2/QJG0OOeDg8M6RvTamiUSL0SwOTM?=
 =?iso-8859-1?Q?Uu3NnJpTMFj0kJMydjhKkdW6Cyt+F9X68bdRHV4Kx1B3Nzpp9jNzKYgaHJ?=
 =?iso-8859-1?Q?+hLDjqfPiEhGHbEW5XrWz65yNVt1HnEEyliLlGvTsYCKVQmqx/h5eRVUjz?=
 =?iso-8859-1?Q?yAq8/bYH3zgNgNybjLMFxYBBmVorhzsQw1jkvtiPEw89Qz+pgtNgpRbtkz?=
 =?iso-8859-1?Q?yn8H0fcFBN3Dp9SWmpE4LWSc6Dj2ET3BmA2A2kdTJHv4qfFCBp+BYwiJiN?=
 =?iso-8859-1?Q?4QDsx4E/5Wz2lZ4TdEZPcGACtczt+rH4GRFfRpbToXjzAv36RKxf9m1rsF?=
 =?iso-8859-1?Q?nPkKAzKkR5Ih/NCfCcrnAn9OrmkgKyWtK6B1YBfdMjCtPsnwBW6q15UXws?=
 =?iso-8859-1?Q?/TZIhubi88LtJBt60vze5BXtGJUK09zHg/rAGNNwX9q3NoIRPNsikrHwkd?=
 =?iso-8859-1?Q?kTmESapnjWllDCqsyS6oqptra7AyjfbHkkOdGk/vW7aNqhs07PWKin/jiR?=
 =?iso-8859-1?Q?N67ZwVZqys3/1c4AKLIVqPlfzgUA/Lu4GeWn7Ly+7Aec6RrRdM6o7iqyTK?=
 =?iso-8859-1?Q?AM7A3TwUWRzFJdoYNnSCffy+jQwWpUVLJLUgw1Z3910xaL/DprmqXu3lkD?=
 =?iso-8859-1?Q?l/ndsRREubmvUF6H1KXRvPMVu3OTmr70+l4wrwvktN3peNB6dluZl3f/9/?=
 =?iso-8859-1?Q?cxR6GhAaQPFmsCJAABdfl/7czJtj+a3V+y1FLJyDbgOhWzuYfq2KkyayNt?=
 =?iso-8859-1?Q?zCItX3C/fRYvdohw4pqoFL3qQUI0yZ2QL6sJ7BDlTj04iT6DegrLOfGBzD?=
 =?iso-8859-1?Q?nhAEkWzHxZrtn6caLPtgvXWF0BkZFCzXVxl7Bdd4ZJ3OxcrV8LtYDzYN6W?=
 =?iso-8859-1?Q?TvKN4kJCo+7Rm1tOMZ2okwj8kbK9Vb1vnFtqAnbN6ZKgXKIGBjHqvSWxmu?=
 =?iso-8859-1?Q?QXHFC028rT1KLGKZBO3psa/wfEmAIF5djpvBLT++mxGokMY7bM7PmVc1J0?=
 =?iso-8859-1?Q?ZIVxWsq8tNCTC5C0WUHVpN494C3r+phujetBKgAOWCRx0PtOBZoIEm5YLR?=
 =?iso-8859-1?Q?M/mMiyokCL4r2VVeYusCrGZiXSR8ht7FS6ZXCeRVa7vZLOOuM/ze+IbcPQ?=
 =?iso-8859-1?Q?B4ogi7cRjYMoqs90ClY2lIMXu767AasnKUXdOXDKDbjtn3oSYo9Ebk6a+9?=
 =?iso-8859-1?Q?HEIwoApEBRXddYj4yD8xDN+iRsUZybsdth0owsFejWVq2jok7cjmEBp9X7?=
 =?iso-8859-1?Q?XA8RJTOUcn3PcYsQ1/ID2c+b1pJTKtfXmPzHza0YITQxKU2kftuk9FQg+r?=
 =?iso-8859-1?Q?yG9Ndf/6yJVeQ0rD1qtRiPjYVsTkkDweSzQM/wdxbjW8k+xELKztFO+YRy?=
 =?iso-8859-1?Q?abc0V5kHCHMEP8aY7LO4UX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9vG8v2McPaq0Hi9/+9sTzbeymwELYV5cZHdOPK3hJZzkmJMKldicGrGYwH?=
 =?iso-8859-1?Q?AVRSe+yS/sgIZX/T/ASwhdXrVU71in+3vb3Q1FhtJL6cAtGbzEiMo9/itG?=
 =?iso-8859-1?Q?8aFYxZQD2NnYHtnMRPbINzx/ekmYG0erpJ5ocintrie5l87X8poK0O6fB5?=
 =?iso-8859-1?Q?FhtgwAxnv1+8adfVMs4zta3hQGJoXYJ/3lgXovHlp6VjxNf+j7tIMwWWfj?=
 =?iso-8859-1?Q?u7/OYCgOXiR55wt3dzzwiljDKC9qplO/jSoMmg6cluu9vHfnbWUsGs1Mdj?=
 =?iso-8859-1?Q?RScKs7KUrr4hwm4xiP14sNcEgNmC3ytI2SB6ZgPmccK/dBFZ0Hw/sxrmyt?=
 =?iso-8859-1?Q?eQkvjWmRABb2RiVd8M1H3UrfuHCr08OMWT5SuGn2naSEvCl1TI7nEwa+6p?=
 =?iso-8859-1?Q?UlvH1R/F65Zq/YySjFtwdL7wr+wklhZ/5UlPluU015a6SS6S+AW7t6SkD5?=
 =?iso-8859-1?Q?SQ7reiGzfWSmsZ7bhRiQRKIDkvjwWZcnZnALgzGuWUnILgsDiobMh1cZMg?=
 =?iso-8859-1?Q?GX2zUL17XMAWicuy6TKHsvYdCi3XC9+hLewaD1vEpy70Q4wYEX5gdx2w8g?=
 =?iso-8859-1?Q?wV0NcmBzYudJOgcYhDKf3OdUXAChzTjKysMFoGquU59hvn71ZQC6znBUvp?=
 =?iso-8859-1?Q?Xma5jGQ7j/yCbNridh7W/rVTfese1+TNQKAT1CdJbMPhZsbbS0kjpFc9/F?=
 =?iso-8859-1?Q?WGVkPUh4K1LA+MaAi2cSoGPzVTwXwlMiFPRIDN3YmC57FsTrujOxhLYNkD?=
 =?iso-8859-1?Q?iO6oonvy+0/RZLoGejPqVKQBKER21dJkwBJo3yC9zgHceH/4I0m0DPiEaP?=
 =?iso-8859-1?Q?vSmsYH0dHJx9AAu2QYY8F08iBm/YpkeQ5GAI/EizZ4WqkW7XIdUHZl59aq?=
 =?iso-8859-1?Q?H0VLvYxAYL3W4zH7gDD9zJnslHSsREnXctPbazhgMIoQ1unG0c3tfCFKk8?=
 =?iso-8859-1?Q?JKup3k1235uZxNtLHTMLQu2FUDPU3DTHFIndfQDWlBv1gVyC/Q5xX2xr6o?=
 =?iso-8859-1?Q?Q2tXahNGkUciDVK2ff9yURbzH/aKhx19gvByI8YylQhh8ASu3kV1a+B6fC?=
 =?iso-8859-1?Q?WIaJlcGLtzNY6Ugsx6VdIWpBaZgr2Sr01/KUDf0bXpIGkb8UJI4vi95eCS?=
 =?iso-8859-1?Q?um97LLSkOBvs070Ks68Eb54jZUG5s5FaquRJDHTQzjp1LJKcIkwFff/VWc?=
 =?iso-8859-1?Q?LwmcxeXM6FKPIdw8/ckDn+xK9m7vCD5oKLIRrVNMKkGfPISjPKxTX260fd?=
 =?iso-8859-1?Q?wA+J8yLTQqLcve0x3goLMHj82ujAglwN3TfxTKsztkS1Dkndp4u6dIgCMS?=
 =?iso-8859-1?Q?8hfowcWiPdrvgsCRKBvkc9nSZZZjj73Fj3Sz6u0hFVV1rf0GVr5pyfnFSu?=
 =?iso-8859-1?Q?/SyW/INGQ9zLcAMIKa7v4lFR06Zfe77kTz/bybMZ2av1h+4eT/Y9PaflzS?=
 =?iso-8859-1?Q?7WJVJqvAaLYP7x6Oh+2eW9LqAqOoXpyBEC6R2MJtMt2Sdls8FzBp6424a3?=
 =?iso-8859-1?Q?UtoD6RjmKMgyU6rngcqAzuMBGgRY5GNqdmS+Zr9y57g788apyFZykWF9kK?=
 =?iso-8859-1?Q?gSn6BDiLuwXrcLNXLwrRA2/VZWbBi5ETrvDHRjS6e3VwbEMWeiuk1cHZal?=
 =?iso-8859-1?Q?5jBGdHk+7l8+8WzMjAzcMae0ZMPvxKxeEpGbVW/yoVZXzf+y4a85drlor5?=
 =?iso-8859-1?Q?zUrrNokANOUJ7CfoWGE6VwvyWMECPMH2fTOyTO57DtW+Rgzl/hxZs5TlWg?=
 =?iso-8859-1?Q?2ESQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b63f698-b0b1-4c94-2f8e-08de34a33278
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 08:41:06.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvQyg/4U7h/2yCKSXKTz48oTP0nwdGeDJqr1v0KmVQMWmhQ1dODvzIYBMrOcOdq+JqvAHZvHz0TdZmR2GCIYAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

On Thu, Dec 04, 2025 at 09:21:39AM +0100, Bjørn Mork wrote:
> >> -       pol = phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
> >> -                                 PHY_POL_NORMAL | PHY_POL_INVERT, default_pol);
> >> -       if (pol < 0)
> >> -               return pol;
> >> -       if (pol == PHY_POL_INVERT)
> >> -               pbus_value |= EN8811H_POLARITY_RX_REVERSE;
> >> +       return phy_get_rx_polarity(dev_fwnode(dev), phy_modes(phydev->interface),
> >> +                                  PHY_POL_NORMAL | PHY_POL_INVERT, default_pol)
> >> +               == PHY_POL_INVERT;

As I was writing a KUnit test for this API, I found another bug in my
submission which you also copied in yours, and I want to point it out
for when you resend.

The "supported" mask of polarities should be
	BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT)
rather than
	PHY_POL_NORMAL | PHY_POL_INVERT

