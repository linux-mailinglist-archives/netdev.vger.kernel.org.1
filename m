Return-Path: <netdev+bounces-211615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C31B1A6F4
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CC27A3028
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3B1E47AD;
	Mon,  4 Aug 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMhI6wX7"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD21F91C7;
	Mon,  4 Aug 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323361; cv=fail; b=chpr3IgpVRzICrEIb/jBUzSyTe27raVdLsxz2j703xA/bNJ96c+v+SHiXgfG0owackMbwQAPOxaND+lMBl+dATJVvKWPd8Daain3wRC56I+xRoJdgq7a9ddZjuL/XlRejT+XnX9d30JIMcraffTF7HuCeTwIWEA75C/cqtmATRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323361; c=relaxed/simple;
	bh=yCtkoSM99F9T1nXq82WlJTHlSqtLiR5SPF7XL8xxuZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gDhVZJcqIW3eVl9kwgutOAOKpPgfTX+ugSIw39Nr/3R4b+ctM/+LQEiRNY2imBL/0T6pvuqI+I9yalFWGI8C8LTherFLyMwemPrei5uNCXrzwktcz0LiZkDX8QhP+mtgYwaQL4Qff9aGitLn6Y1IGnq45OFm6MIoL4XTDYYnVuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMhI6wX7; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4VQELl13MSTvrc3i2ulD9OfedbOn6qYbutiXimhxF5yvrX5fsRNtuXDQib+36o6McYR59TDsANX6K4D8KD+6hPp2UNmzbTiVc4723vnMYawW5IS/Rqad9+UMvkIzV3eI8TnWC/aBc5iRfaZZPDXnZXJOhB4QQl+06c7okhgl1WReWjmhcTaFtv8Q/2skWL+H5Tt/ELWqYXFFFzg1wsUuQ0jl+2iYhZT82eWbPKvkBLJkpcNWSXXezIK6GFu0mtLkasCrYE7qqmF2nu1zZHbZiob9fAR3pHZbJexmAO+FmXfL37mpQbcYnaLNTAeoB6Q1rP1hs+0YMpfLpnry7ukXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA7KJFZgGxV/bLDVAdKu5JXRdW9lQkL/MSJ+i1IA+Jo=;
 b=CvD2ClWfM2Hnpp/POqLwxyqtrO7ctgjv6evGR4ZCZYbQ40dzW5trAdurQp6Je00iqDoVtk7mWGHNbAFN55NlGGf+THhR7H7CFJwgQCIuIeCeA6nXYeTR3F4RckHJuMsRHWW5jdLKGjsfjHHBOSCevnZZ84vq15PTquremmqm5i/FGzfzzadJ0uoO+FLwdwWBYVawqU9/E0xc7BiQ07WDCYHCRaxJ1Jv7CJMLx7qtEC1tu5J1+WEMq3psY4+9SkTskG56Bw+6GD/S93+P98qqzft973s4fzetSAKHYNgk/ljdN0IpAYQUvdB+EZMGO10lyomLpcGw747k+HB7bbfQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA7KJFZgGxV/bLDVAdKu5JXRdW9lQkL/MSJ+i1IA+Jo=;
 b=aMhI6wX7F5RsCAZHFIE2dLZ7aK6pkURD9HoYEdjiJELai4jGenWyq8Q/pBsLK1HkV3Ih4WVF+w8qWwqO6mSyO7V9eQMOWjrLf4EZEfB/PtfMQm7LKkwkeF7XtZxXqYpXvLYwTKuX76nUIDF23yZQQbClIe94xuZK7rX32wSh1O7QLUrjRPNlBCWySGB6I9woU4Zt4tRXJiXtIpT/9QIN+inkTc2D+Q3nchaGwBJUeQEQfEh0MtLR4ERuwD9dorsGdhTi/zkPVlms6fIhnOCxPcPH5cWw73H6GUw6+a2QD9TKhwowtb1U1jXuo6yY/VhOk7BZAe9YzHK/67Zab3GsDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 16:02:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8989.020; Mon, 4 Aug 2025
 16:02:37 +0000
Date: Mon, 4 Aug 2025 19:02:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250804160234.dp3mgvtigo3txxvc@skbuf>
References: <aJBQiyubjwFe1h27@FUE-ALEWI-WINX>
 <20250804100139.7frwykbaue7cckfk@skbuf>
 <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804160037.bqfb2cmwfay42zka@skbuf>
X-ClientProxiedBy: VI1P195CA0074.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::27) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9ad5cf-1898-4049-e8eb-08ddd3705508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KI4bLUBrI1S844igqbGXwRbyp3LDBLq7WQiDUcWYfjBXPPnPqr2XR9ADXm6?=
 =?us-ascii?Q?gLSIenOoRIc9FvjEffT+5t6UUH61YgPD/VeUJ3rZ7q85YXl++Wy7WeInBtyD?=
 =?us-ascii?Q?E08y39tsEL+QgMLRexMnMXbrKJbEwIgqEeOguQmCS7pxR7hsuBeDWckOFt/e?=
 =?us-ascii?Q?bRlbACx2YeXCO9o5rglyFme3M8EWtSzPvwYMDc9rv+y5MtpxksJFDfGQeBF7?=
 =?us-ascii?Q?kHBA57lU6thD9b1nM9bOVdFWC04/TI8K/08hUN5zlU38ZofnuuOqvm+rb7yX?=
 =?us-ascii?Q?zHTTj+A0YQtaF/mxNoqfMFPhAwi7PY39vBz9j7xrnI3CIil1baZd8/BZ/QwB?=
 =?us-ascii?Q?uj9KzmCxv70DtSvHxsUWQpdQCeTe1cN2kvgSV2+MoBhV47nRSl9mTPT0vpUJ?=
 =?us-ascii?Q?9/Do8C9JRPUtwKi0C47ZmpTLE0SmaEuhDQcu32h1981EnzJDeXlcIhBkI85R?=
 =?us-ascii?Q?5eLA8/txfM35V2I2c8o+RiQ9qrv6p9H5jy5iNfxB2e2CdHgyH3ePwxb/czgj?=
 =?us-ascii?Q?8EDsnAC989SY3nSE9VJuHSka++bLzQC5HQDymAyctR0RiEqqnjAmoIbpdtOu?=
 =?us-ascii?Q?YkCIJo717wzhY3P+tDV/4+JqAkN3CfbNjM4yChFzhbo5YhIgboIUXxm1unqK?=
 =?us-ascii?Q?gIhI9FLMlJobH0bJGvx5Egp438KXXr8omtXnwXELJIU/RwNj3wpNC/nLSo0R?=
 =?us-ascii?Q?ggwsRHS/WdgU8Tj6roOttPmcqVjVC5A0/GZuVYKtM0H4mV8rEwu1tZJ9Oocf?=
 =?us-ascii?Q?NA2+nJnYhum9ZZWhf4lssdZQXLR5eiBjvEvcUMBVNs0JsUYAIWYKb/mgblwT?=
 =?us-ascii?Q?APc3sjPcahHtuQvfO8PZB7D9Ln2mGrsK/Du+2dKQdkX6LTAFt/2jGsHwnd6z?=
 =?us-ascii?Q?yNsRQti3N22fZ968rc9ExjxlvrCeesEfXu7/JU0ygbKjW8rvVzTAXMtiec33?=
 =?us-ascii?Q?vE7Ke0+u1aCtmCOizVGvRGA+GBFkjZu+NnXoVSbGWBSp7pCkmK/gtguYf1kj?=
 =?us-ascii?Q?R3mZVb+BDsvQTT0DxNhRyvaGNU2ZeL4y/BnhJcoKzwCfBduyDwGOVGVywmx+?=
 =?us-ascii?Q?/G1uWTxyQyixU5JRWdSyfCMtYZUrDNN641yQjD0nSMfpU+ZtlPF06U19M50w?=
 =?us-ascii?Q?5YUFOUr262zt09nnIZPeXJMKKXwgBshJmZoDPNgGTDvcH7JVFxZBh/jOp3Vk?=
 =?us-ascii?Q?NsLNWCsPb7bxWw7vVMlpDrkG2s4J0Lmur14suvNDisled3kkyrB/jaQ7RIyH?=
 =?us-ascii?Q?6coPfI5E0/stGssrz3FldGFdaI6U9gWqnZ6GGGGfy7waoSxoXtnR66W7UQfj?=
 =?us-ascii?Q?3HmhigDOwxDmluQWMRbNo3lKQX6SCtr7pzRyVNyKj8kVlSMQWs+/YBytwUDM?=
 =?us-ascii?Q?NQeI08N+YFiVv4+xckq/vX9CQE1lDICrfwbcmq+X6kfj29gmpWGuowg5xJhr?=
 =?us-ascii?Q?USK4bIWxaiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HP/C7I/jhMlqKJr1KSxsJ/Jmiy8ie7n/d/UhPqsZUVK3vyar4mTwv4It/wR/?=
 =?us-ascii?Q?RjPymsIm1FliWGafyTmNgZqntpizxNx8JjYEVChLjuQpZcyCxGsvdRNlAAvE?=
 =?us-ascii?Q?iEw1z/JsIpybgNH6QwIJ6+Oo+GVVkrvLbStd3oYe/UsJyxfopFV6+3mppKdf?=
 =?us-ascii?Q?ZdcUuhvCTDIW+ZcgHhsF0S+p5oyIy5+FVL3VYUNn8rNSB+FusHfDra/SaB0i?=
 =?us-ascii?Q?1U/QYY6U0lOP5qH/nO25FYl1HuqJIb8AXkCv6+CtsrbGIY+trUYITCOePF0M?=
 =?us-ascii?Q?6ga6AEYFp2NIN9c/Bq5BCrOaO/MixRXfXnwgQpueSam3us7IuaRwU8j8/pai?=
 =?us-ascii?Q?1ECXFwkJQ9SPyENbPVJ5W7FROGH92F+FH2t2D0mN1tBAg9li7yM4cq+InvL9?=
 =?us-ascii?Q?RmZnBXaz7aTCELb2I7Zs3D/jCKv77htOybVUYwTSscheLMqWyEf333HqXwXM?=
 =?us-ascii?Q?1BPExai8NDJLuhh9CtqUbO6Bax0Vq5yZ2g9hnpKavtm9GhAragouQyZ+lOha?=
 =?us-ascii?Q?0zG0TXP1ZVtZZK8qq6YiyarniCoVaurlZs+e31hhoz8V20HzpS8Cng9zYI4T?=
 =?us-ascii?Q?1Etd97dHjfPtFpmXNNdCHUV9EdAzogj9ER87wSScZeQug1tE645Wiwtjvudn?=
 =?us-ascii?Q?NKZ8LmilLe5pzP0aJ9aBQZO4adW3IWQaghbWNpDEOFCMoRxZBAqqTH4arutt?=
 =?us-ascii?Q?X4ST5b/bwb0631yjzhP1t74LHEU4aSl6NwKS4QGowqjFo33T4c7rZLA0I+44?=
 =?us-ascii?Q?aH4cKRfo7gjOfIZwZK6ydzRJca3qWD1mAWtMNr7PT4x4r5uMoD48B+NJG56K?=
 =?us-ascii?Q?eBDXtBIh73lb/ke/M1P0SwTwi50bQgzF8y7DbSYFM+gIrM537qC5WbPz2gJ+?=
 =?us-ascii?Q?bnvUdbkqECqVhnLKJIkDcLHHtxRAW55IN6WB4pEPWQj17qd8taNboglq6RFE?=
 =?us-ascii?Q?Fx0cRwJfj9JPz77rndno72URcu1qS5NYf5E6a8We2hFRgbdTFWLaJ7D7ICrB?=
 =?us-ascii?Q?NiXNq1jcTfvTp2XJA678U0P4lXUWUMOCa9H7VHSFVyLjnGdtmUWi9/GmnvEh?=
 =?us-ascii?Q?SUzB4GqaQgRg55YeJqB+1U8MJ77/Yddp8AWe297X7XsAN/zxVmjRNFJuMuDQ?=
 =?us-ascii?Q?QQaH5lmgCuIoFuhW3pVWeyWt5EomI+jnphxxTmYoCWEBDQATMsn+QJ9nvirq?=
 =?us-ascii?Q?ydDm42DCpJV12TC3p5EY+h3MwxINlDx8Z6juvbBaWmb2M4DnlXEhbWjcg+wh?=
 =?us-ascii?Q?kPJnw95CGIDIm22ZSHWRBY4EtCRkRp/uwoJjUg7yaEilfMUXyKI5pT8+RIWy?=
 =?us-ascii?Q?TrqQx9YqT9FGw/aSRYlopKu7l6XimT/4dMR9YvKQ3flAWYkRwVTdPs7hY96A?=
 =?us-ascii?Q?lLEc9uRxxX01VobFAMZbXmjKn01ICq/F8RDtvmWxH7wd87+OyYEzaFRaLOpL?=
 =?us-ascii?Q?Rr9nCcvGozBywNPEL/PUoPuO9Zp5KFGTVvLlJBTSHToPzEfwuFFK2wTpzGsP?=
 =?us-ascii?Q?M3YCOZOmpWKpSOGz/+EN9yZlaTsjDY7i0njkIEIFdonWq8vKJCOwHTeQg1d9?=
 =?us-ascii?Q?uM5kGQv12duw8y87oEmGiMooBotc2lU6+JHaRUTRZjyibQ/01NSFLLA9y96+?=
 =?us-ascii?Q?NS0YgVLkYUtUi14jD/1hMQ5qGHCoumaOuuSRxI9L2iP7WmT5g8NOLsUQp2y5?=
 =?us-ascii?Q?L1bjTg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9ad5cf-1898-4049-e8eb-08ddd3705508
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:02:37.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJkyTi/+i2jgEwlCl6rKkyk+yx4BlH9eDDK/h7rX6E3RHp3CFWDOw6Uom3hti7Wq7sffG2shhfRFwLidZtVlkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046

On Mon, Aug 04, 2025 at 07:00:37PM +0300, Vladimir Oltean wrote:
> Can you apply the following patch, which adds support for ethtool
> counters coming from the mEMAC, and dump them?
> 
> ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon | grep -v ': 0'

I forgot to mention how to show flow control counters:

ethtool -I --show-pause eth0

