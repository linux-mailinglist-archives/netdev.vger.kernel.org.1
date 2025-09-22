Return-Path: <netdev+bounces-225247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40620B9114B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 14:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4F53B0460
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3568202C5D;
	Mon, 22 Sep 2025 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ey5a7TKK"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34835942;
	Mon, 22 Sep 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543336; cv=fail; b=pN06p4d3alSgKa2LrSAFRCaQ69+Vd9Y1CR194MCASPZF0Wd2EIHcY1zEtstGoWL7mlX+B4E+xmo2MrhVPoISnMNi2SpqJSjWqzfC8mLNzz5Wbl1FisTl8X72uR2/+auFH3xJojeO5lk+/qv27SHnh83azF1PAP+HCmt2SX0mSMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543336; c=relaxed/simple;
	bh=kuP8MiAO3LJdhYDLo4JtD8WG4E/ZXI6ncqh+HEOkjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLYN5d/Rda+UMfpULMeF6vWcgFahjRK+S1oBtBHnNI8/IaAm8CJVAH2pqWGdvTqeDkwuUMllDpnKE0Ll+EM/Sy0+UST9ltdgFWhlLIkwBUZiqsJRgVhGnUHY8TLzphEhE7wZNbavdhJ/fv0SAqesxbiHRoVzOezGO1VSno3jE5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ey5a7TKK; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL8OWMnea4u99+Li8tjoqoLlNqHoQGNTDGiE8oTqO0fKWi6+gSLqw3+CI6mZBmnXE4aNOG7Qwz/njRKJcM3FY6DnnVhxh9cq9D7ub0TWk6zhSKtF6U+x4Z3a2fIvsERasruiA7kYJ7x5/oquay5UPB37r4p2Fu54r0+XZ/cMyxxWFMlZrQVy5VBExc21p3t6q5znZ+AkH51jge041mj4SVVF1exOA7HNWli0dbydAS8hEsEe+V8FJxjhNYdKn2TZG9Rdnvju3nHXKqacaLOef8gaoV2f8lRAREJGnsCWg5kIjJi7FLULLAauBomG38Tk+1hv/D2fxz+q6pK3yKDvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDmBojr/L3+E48ae6O8OpOGJbfCQNs5ksobya4Yr6bQ=;
 b=d1XUxz4sv6z3XNdihIXxQpTH2xYP/ye5SWBjSEb/kFy9Oqgl+DqJcYg9X9inzjiam966UizuimPqBiNjGCIh60WzXlQTb5APvqPdYtHaspLYRexP8Zc92/zNZLJEScfowuZoyW0P2OOnGJxH6silGgpVZGoSR44+6g8TXQtiyLM5sOn7Yo7kx4BzXs2XjZ8zQex8uBakha7cqoWa5vpqxQs89Extjxlc0xMHvjDeTP0LK6W5hPGE2hgA70iWYPJNKfbi7SslwZ+5s7k5//uS4VhtX/67lyj65/VxbL3qrhWwLxHRKLZ1UuxidwWhBAt+xdSaKzftAT2xWfY7JnX43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDmBojr/L3+E48ae6O8OpOGJbfCQNs5ksobya4Yr6bQ=;
 b=ey5a7TKKdBGxnYsAzdvRvHznMC5PGOvR+kH/q9/Pnf8BpxTwHOmjFWBqwDgAY4oprkAnOK+sBLbkEjiYm6hs0xzisLzBrPF7OFPcxG/Lv+vy/Ib93MZol1J6XiPhXjm3rJPaRu2sCDCmGzvSpKErE/q0h4USReyglj355eaolbjXjK6axxsn8VMy6+c5+k1bZ8gQaXt0O4X1RcSnsa6B8/ky+VBayq4ikZtNth5VHVelb7Fo3kbsZofQLzMt0RiQFXuzvXuVyPSxtkHAIpxKKkFu2Di3aV3KybHNfPMZMSh/YRB1qykqFs4isHtvjfgbqSorWnMaQgvxLJrmeDGhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 12:15:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 12:15:28 +0000
Date: Mon, 22 Sep 2025 15:15:24 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	richardcochran@gmail.com, vadim.fedorenko@linux.dev,
	rmk+kernel@armlinux.org.uk, christophe.jaillet@wanadoo.fr,
	rosenp@gmail.com, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250922121524.3baplkjgw2xnwizr@skbuf>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918160942.3dc54e9a@kernel.org>
X-ClientProxiedBy: BE1P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 91adb75a-080d-40e7-767f-08ddf9d1b791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?75zhWwYa5rA/NywCg9AW8rNhI/+/nKmZtmobPYjG3c5vwOyqp8B11o0Ad1E/?=
 =?us-ascii?Q?bnYYY6Xq9MoNqpoFj7+HZG79OFE5/add/pouhvBDEURLXmRTBmakbz+qCh8C?=
 =?us-ascii?Q?6+IhKIHOWDEwP5wUSaSZRFcSoCcEsvQKbIAwj+J242hXdB/O+da3pLszHuKH?=
 =?us-ascii?Q?jMZ+NfgKHXx7L3ulg2iC+K+4cHH0AuzFVUzAtvCxieL74IxLLmTpAIGJWoYr?=
 =?us-ascii?Q?+T64uWiPpScQhKh/fg5EhtHza5C121O5zajxevpHAhrk25u1JyhQe5mhB7tQ?=
 =?us-ascii?Q?0if9LxA6o2StfRKtyG7be9gHK3Wcn9ZxUKA3dSKTMqfTFmZR5L2AUbtiUJSv?=
 =?us-ascii?Q?zCq6PX+lDTRi9zBpcRPWsShNS8RzUjJ78PAdkXCM0HQCw+/szJAODXpQs+12?=
 =?us-ascii?Q?UzXUsVXJYWlrc0+2wHXSpCw836g0Lf09zLEjsI5RJRC2zBerGMS9ppwEbrWj?=
 =?us-ascii?Q?7F1TQiv/10g40a/MXG0X2c0kmhVagjBCLFlYcaP6HHU+0QCu/n74slVeWP2L?=
 =?us-ascii?Q?djJpqXVFypCdQxSLCSYoVf/wSsOoZiNCdYUqAAuvrIKr/sP+nIlkc9Fqvuez?=
 =?us-ascii?Q?Ao9QoVItxmLpBFotqiMjzAq0ML5uVW6hGu77RZ8QKz5VKm00/eNlVDI0mKMX?=
 =?us-ascii?Q?bOKc0NyhR4LC79RCEsvEB+zsEww4yDIe96uE36Bg01NCBRxvzwXkSXai7OOy?=
 =?us-ascii?Q?M0gNmVgCo1X9wLn3qyKmEZWXTjQNHI0FXHkR4Yn5Q8AbLMvEK3Zmd2CNIyG3?=
 =?us-ascii?Q?hBdvy5ezDj0R4TT7D3KwwVXezbh5ahec9QADDwJ+NCVZ3y6zlRvTIGFo8mEE?=
 =?us-ascii?Q?h4W+yDrNWigIaBsT6UOEdQ1Kr9uJN4xURa4WeTwpSksGZyMxiSLh5dQVGeQW?=
 =?us-ascii?Q?EOtSRxyaLG1KNVhC+WSogR3IRvxX8McLrXiZyeNISt2Hh0kKpUPdp0bmO584?=
 =?us-ascii?Q?w5iDJ7kBIX49DlCBUjw0PkYPg0WJUYJfTK8pGNXPuiImOznnzU6CPIYrJdS9?=
 =?us-ascii?Q?OpTs6DCKHkOmxGTKfsoVGF7Sb/DNQ7YB4PQJcFJK90dmKrJqpIQiYotUizxR?=
 =?us-ascii?Q?n49j0otXXpuhc7ipJzXIr6JuZbYSqVIr3UGHiGMYxnuaVVqWq3IPuB5klYSB?=
 =?us-ascii?Q?GuN8ZrQa6IG+vF6GJgapU6C1Hh1FBP9jfsAZGTWtXcQxONyhl8TXr750OT0p?=
 =?us-ascii?Q?d35jvkdJHBmetwxL1h8wIHej4A7M2N3B2MwS+aHu+GOuK8IeKouhj+yllkR0?=
 =?us-ascii?Q?SGP6+5HIBPG2ggI9S0Any7A35FqVUSkbo0uXhxNbVzEdzLnFsU2iwvzSp6a4?=
 =?us-ascii?Q?XJ+WSCDvIsdMeUr8Q4SxkKnejWUr3r9Mah8UXUF9cQd9ZSqdyXcIOmtukjPN?=
 =?us-ascii?Q?/Cs/0G/851ArVTEa2qdq2w8hBtIhl56VsaI3M/sBOQqCD8cewA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bqDuPwxIs5YjAv7i8V6VUM/q9iu7hi4xx3VOKmwYntHV4CPftBChQ+Zj8Uw?=
 =?us-ascii?Q?VfCvAJEnXscH+jcYvTQv+2YyQ34apIquzOXqODHWJKlNDytyeo/pLeQVCujn?=
 =?us-ascii?Q?ZFnXpHZ6Hvl9uEO60VzbKpjZPrg3Tlq1ePPS3zUuPxsDlI+nT3237gQwEI/a?=
 =?us-ascii?Q?MMh8IR+R0vsT6mf6XgOa8ADxt/6dl1fWvi7VTVoAh1Ktea9Akk9pc4LN2NF7?=
 =?us-ascii?Q?8dgaVWVancZYW7a2mkystavE+Gww+dxTvOFtB23xu4IsKoTfaYvC5olgXSM9?=
 =?us-ascii?Q?jJj5HS1bzx00KCAZ+Z2kGJIVfr/qKXIVBYwOw1WQIRg2ixDOp+cd55ddvfa3?=
 =?us-ascii?Q?infOufH3oZw0FY6DSHq1WFVtpRcZ5mEE/bLHGVtRkZhQOtEKRmQC0eWmIklK?=
 =?us-ascii?Q?ik2ZMfwxwCDsqCVHdSY6lXbZC0oPKImrd1U2TJprmtyyKxy2Rw9+sCWKfReD?=
 =?us-ascii?Q?j8O05voDy4VLtL5Re9uUq8twcXcEDhSqAiPW57tEgrEkqsiB5s0bFIZ+0Kf7?=
 =?us-ascii?Q?+SfwNVtCUv1bXlhqP3tSq8SPl7iptK1+/1Hi1Vpvd3EL9Cs6yosvMXUF+DJ4?=
 =?us-ascii?Q?3mywzk6bmKOsQJlJbmGHULXpGZ72Q4wYnth7DfFku5UKNcMe/yihvTanVWt7?=
 =?us-ascii?Q?4t9p7DXgWQ00CijUomhaTQflny1rabvuzaMyAiE9xRprjOb8PdKDswAg1LD1?=
 =?us-ascii?Q?dnEFbhQN24CmQkrFGxUH3+deSpjtYp6JEoA29tEkLTzClrmk/Ck8sYxUch3T?=
 =?us-ascii?Q?3Re78FNUc5HxfP9UWQstn9cUVN8Khn1vQ0TCvs1w8vF6Ny5dwD6Jb7o6ozvj?=
 =?us-ascii?Q?vhoN/P2aYLMDT2/CA2wKdta8HHM3E+kVhRRmcRxKj6nk6AOaxxZJCCwMSyZs?=
 =?us-ascii?Q?ktg6ll6130j4zOR5NNsxnXPlDZsKxsD1AOlMZP0GqAIyQimnfWh5nCk43DFy?=
 =?us-ascii?Q?lr/Ka/tbKaGgEL3jeqdBHLaQb46IElW4/7OBlMn/cw2AX2nHz+OS/FRKg+9i?=
 =?us-ascii?Q?SKCUltm/bjgPqRJ5oaJh3ZMvF9E7kZ6mazj7gO0vJdL/OAJxk+NTNq6AYic9?=
 =?us-ascii?Q?7P2A9JtYJpYG6EQ+4w1yIoVaXBoAwJgw5MxHhqNsXN7Iaprvy5vQC/KKVmDA?=
 =?us-ascii?Q?HJFnGNawoxt4XfW+F+oP6TUYIKUwJMIbM3DdvW9Oq5bfx04bACM/KcCastea?=
 =?us-ascii?Q?rKaqQEfZDidY0UHA4YJKoSCrlJRpuMGjMFlAngjZSehmuGGvO/X5Kfo8LSs0?=
 =?us-ascii?Q?ttbo5jOvClouFQ6LmxGuIdYsSpMjBSvtcH7SRz0kIgZyu/L5izj5vrjkvSHk?=
 =?us-ascii?Q?4vA6D6of5Hx0x60XWh6LEd8Q899ygY5WgYvEDgOid/07OzwBLJR+P9Rt1Pld?=
 =?us-ascii?Q?b/v53QHQnLuTbO8Gs/b6yLte9MbuHC1C4/8CZpTLFBo6lD0IxdeC8gsw7Ab3?=
 =?us-ascii?Q?EjaIVZhsbxaBGDOFVbh8SxtwiEzSf1To/n71d0RU4tLDDpZSv074eDOCCGS8?=
 =?us-ascii?Q?O85W+CwftNbBcjMZMJ3oMd3NaeDG1u6LOLldgXCCtracR9p7SoHtfPtnnMSZ?=
 =?us-ascii?Q?HgESuthPGPoPIGzcpEOcyU4WJSBgiln8MfwDbJzbz3+ImtNRyi5HOa5gs4B7?=
 =?us-ascii?Q?DC1PLgdYJKAdcIQX5xKl6UCHwFRG2PBz9/Z62bWwQ2ljczkqgyPziKOjDpgj?=
 =?us-ascii?Q?XtOu3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91adb75a-080d-40e7-767f-08ddf9d1b791
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 12:15:28.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDf4g0wcpOtNk8QWA0a7FfWQh4Z0UJh1cKZzcgWolB7yULwUmykb2MGIDxZDdth+I83cK3XUpmA4pX7ZxoTI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031

On Thu, Sep 18, 2025 at 04:09:42PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 13:33:16 +0200 Horatiu Vultur wrote:
> > When trying to enable PTP on vsc8574 and vsc8572 it is not working even
> > if the function vsc8584_ptp_init it says that it has support for PHY
> > timestamping. It is not working because there is no PTP device.
> > So, to fix this make sure to create a PTP device also for this PHYs as
> > they have the same PTP IP as the other vsc PHYs.
> 
> May be useful to proof read your commit message, or run it thru 
> a grammar checker. Copy & paste into a Google Doc would be enough..

I agree, and I did not understand the problem from the commit message.

I would suggest something like below (maybe not identical).

The PTP initialization is two-step: first we have vsc8584_ptp_probe_once() /
vsc8584_ptp_probe() at probe() time, then we have vsc8584_ptp_init() at
config_init() time.

For VSC8574 and VSC8572, the PTP initialization is incomplete. We are
making the second step without having previously made the first one.
This means, for example, that ptp_clock_register() is never called.

Nothing crashes as a result of this, but it is unexpected that some PHY
generations have PTP functionality exposed by the driver and some do
not, even though they share the same PTP clock IP.

> Regarding the patch the new function looks like a spitting image 
> of vsc8584_probe(), minus the revision check.
> -- 
> pw-bot: cr

Also, even without this patch, vsc8574_probe() and vsc8584_probe() are
structurally very similar and could use some consolidation.

Would it make sense to create a static int vsc8531_probe_common(struct
phy_device *phydev, bool ptp) and call it from multiple wrappers? The
VSC8584_REVB check can go in the vsc8584_probe() wrapper. The "size_t
priv_size" argument of devm_phy_package_join() can be set based on the
"bool ptp" argument, because struct vsc85xx_shared_private is used only
in PTP code.

You can make a preparatory change in 'net' patch sets, even without
a Fixes: tag, if you clearly explain what it's for.

