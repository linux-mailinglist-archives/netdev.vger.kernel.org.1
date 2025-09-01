Return-Path: <netdev+bounces-218646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9AB3DBFD
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30805189CBBE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88A2EFDA1;
	Mon,  1 Sep 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gwg0aF/r"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6032EFD92
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714162; cv=fail; b=UXurb7uMwIKnCpTbtr1m7bkm6/RRhJ2ymSHyYQI2mDd+7eZK0mhe8n4il2hg7YoJUcGOh8jM8JpkuERwYw38v4Q8IGJKGUGcxvZ3H6J0TuktqNRoeTOfnMmecOS+ydq57IJxtZNgC8DOoe6a9FkTAvTToOWIZARVS6srnKZY1uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714162; c=relaxed/simple;
	bh=LCyA8d+aL5/hWD0ttX4d9qqLT5UlvlJ+MUHBm1IP2Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t1v4YsLJGW4TiThXzhPqyXPoxqeZ8yskZw45vMxCNpDevCPNQtKkisEa5mGKeeJUUU8YzBw5dl+Co0h2v8wm9GPi5yzeuYaI5F6NeFmT/CG1wNEyeIYQ0hzI3aipDxyiWw3Cvx+rQdLMWzd3CQEI+0bu/Sl1UBSUsaBuvUVKvSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gwg0aF/r; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHWT3sipkH52tDeOnLNlYc/9+7DEbDETrHpDLcGeOrMivoiawkVAjhvYfg4NINZFynClt9LynUxXy3+LBuS8s4T14zmpRweT5p24ShxI9JhYpNJ9PV2EB6sZQlRic9WtHCvd5KJpUd3+uLNpBXbgWS/IuDW64+W94CmF5Q/WiSLSqZJvIeCySbgrbpsoyMjLF10QFe1ZAxQpCPzQ7iYm+noFe6xjM+o0M0TYiVt5UDPGVZhlYdEBB/LpG3c+vLiwt6pB76RvIauGBmLqRBaC1WQuWM6dghA7RM9uJ5MihW4XvphXMjAsI0hSf9nUDK8TAL2AuuiyNdpFyklHQpPzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shpxpd4GB5h5EQZFKmSa1m0keVlxlYmOJfXjZnWETqs=;
 b=WEKHNtWsZOolbaxnKLflbApbfb1JhSp2OYq83TRELQXRwEXWoCFOcHypDcz8LvFYuMnjFosgoVIx9ItWM2WUETnWowrafRAb4RpiOnn1YMdxV9jNRzCUqLBZiCDcia0cT1ppigYAEMzwyYOSiiAtI/yP/sdWTJuydCBnOQqRWK9/9qaCmHijR+jBtBNCfDpcRQcgw9WUz74Z9Mrd/u2kE9ctRSqWnyojXtB1IfxgXBg0R0X77iKw2l/xU0MR1y7yDrnCPxYwCGrJ9Lj0hNiq0bcxt+RR/d9xc15bXJARM9VzGsEplFA77Nbwxmw5LKwhmBgKmZUdCL9xyWXtSIqh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shpxpd4GB5h5EQZFKmSa1m0keVlxlYmOJfXjZnWETqs=;
 b=gwg0aF/rB3qtr7EzyD/JiDyPhCCYOjldPq0CNjebkoAssDA5oPbESvZ/9RiB+SohHjLMGBDRVG4ZSnkV7dgVHIhsQB2cmHtxREia7Sg+4M3kHNplObqYOV9BOKDIHWA5icmjDQa1Xc4ctikZspGFwblWe+dEZXgLmQD2Pea3cru0AEFvyEy7ENRCGBUQsRQSJNTZZtT5PT+nGkGw3jrY0TGcf3je1nUDhhb37ce2uzaoO5d5G7+a2SXHfpYxZyWF6ps8UlW18Ozm2KrL6xaYeko6jLgMwPqzAlf2mqRJ4JekiAH97UZoLZu6vBNf0ACEN1gSkh6+FVhMi6EA3nCrRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:09:13 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 08:09:13 +0000
Date: Mon, 1 Sep 2025 11:09:10 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901080910.vztxjxm2q2b32sxe@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
X-ClientProxiedBy: VI1PR09CA0155.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b64bc5-2746-4564-6240-08dde92ed6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZwfANe5RnUSlYGWUAWQ52GMQjuAGVDPTpNBdWNTlHp2jA+t/Zfg4ft1PKzN?=
 =?us-ascii?Q?0zrER8KbTinpVoIesYRdwF2X9ghsngMO11bsEe8M8+9+Ol4ehOPwZgO/C6EK?=
 =?us-ascii?Q?BDBcqF1Q+6X5cAd/BC8Szln4TJjyca2Hyi7I2shuj2DPxhpdIz0nQ9lnc1ny?=
 =?us-ascii?Q?Yza611rQM7XKhP2ovE8psYYMZSSwBLHiOhyAMLeLQM7NJ86SyBW9t/dlONsH?=
 =?us-ascii?Q?fOf/yY5G0kDGktgDPcKJlj+Ut3jqe2umcKzKukUdAInzVAxhkFk0/TUo6ZwJ?=
 =?us-ascii?Q?ERPkPcGk8z5BezCnwxfEKlLT5NFXd1u81mhpIhxLraGJQclbyRfCM5b9eYf8?=
 =?us-ascii?Q?Vv7K+vOddXPqo/dBldQx+GtbOdHWiIgdZVQlZfQ2iphpzu2Shx6F98d6fQBG?=
 =?us-ascii?Q?SK2FCuQyI09H/XDIxdO0vKDvNE0YmfZb7i/RL1nIpS4bmH5hmDKnjnKOCMv3?=
 =?us-ascii?Q?pbc5atm+oknKzn/m/AKB/PtaoBpi9eygpEILsx9lu74U8s+pVytLD3HClIc0?=
 =?us-ascii?Q?psA5ZMl/GUEVJjVy/DPubfae8XeHZZVr5K/7Of51QyvXD+y+gNTg0e9ct2LN?=
 =?us-ascii?Q?ygNtWbRbpzHs+zyoPzfN+/ygpbcLc29i6HP+3c8KGLuoALQ9/TH6PDssZ7Nj?=
 =?us-ascii?Q?9OowdUt18EUQ3y1qwlFM+qpbFwIuWrR7h6H90Q9JaAnkSwE/CJ7VjqkO1TvA?=
 =?us-ascii?Q?RAUKonjEIWptHG9ti94AE8NwOZIrixQWlofaHz25O4mmiyf/MyXIECxoN6fU?=
 =?us-ascii?Q?RVY/4givkeF88wCV9az23Nnfsc1iO11JjJMqqTb8ptUIYtLI/lgLMcjSVcbU?=
 =?us-ascii?Q?spFChnePFU8FhhmsQftY8oNzd/glap5e3NEaRAWCzpNNJ+sktgbKgMoWFjlA?=
 =?us-ascii?Q?W2ugbij9TvP+FRRhozAKvklDS5cm9QZcNPYGggISr8CzLkWzuw/17P8Gwqkv?=
 =?us-ascii?Q?juupzIZQp2ImhTosqbdnelc4ApE+UphGMJ/WzjCwK81K7r5Wdz+0FrS+UdmA?=
 =?us-ascii?Q?jcwAHcQ/NgDy8tomjNXcEL87zIIk9bIOcaxfBt5A7uFdbt1jEZHRWfYHB0Xl?=
 =?us-ascii?Q?rq8P8+VC5kgAK2L+pKriB2txvqX35GhrGFj6w4qFGyMQxg+j0BPSHgWtNb1h?=
 =?us-ascii?Q?mc0wUQ6y55o3rVbdMJ41FiQ0yROSgkUYLyxpPuipAiVEW4TxuRaTDlv/CggW?=
 =?us-ascii?Q?9OMcJMUht/9YCVHdDv9lw2ZCmJhjbJWVaTg/3n+To8/5scmkzjXWOXNPbwpy?=
 =?us-ascii?Q?MlS35BD8V7Jn6hfRghY8FmdpeJLrCxHRqmE6f+CGrGqsot3pAXplnzRunVsG?=
 =?us-ascii?Q?nVtV3TgnqoktIncamN/C79MHT8tyf3p56eEI1h/bftYhMOjYRJTVpV1f6HTm?=
 =?us-ascii?Q?1TfBN4M3fPKyln7TlX2h859XMNX0Y+QlXAEt420QckgRhH2g4GuOHt3CXyeD?=
 =?us-ascii?Q?p+QPMd6pySc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/nMtZ7eMslxIecv/dtjNQiU9rial0w3VUPZ1GyZm72XxfwK5as6t+5a5fuw?=
 =?us-ascii?Q?4M3eGidCXco/4WXhS9U+EaVsTDJAIv6cIUSS8jPWwj6CsbVBOXRbb7Uspnje?=
 =?us-ascii?Q?i67rLqe8z3DP3zx1+yxHp7YMa7njZTPKcNKuYRwC7l0p4SfwObibZuFqKiP5?=
 =?us-ascii?Q?o1kbu8hiQ8blsY0vnGfaBV8iM2tufkULdXfvqhynx64ZZdAwwe9EuTiBlsp4?=
 =?us-ascii?Q?4wvmyRX1DBRSPCFnxLhJvqE/VZdXwoiwLoeLJMYwYYixGItOH5h589+DyM/5?=
 =?us-ascii?Q?Ea0cv0H2cO/jDJ5TrYXYIM9XEPgqgNWSIc9QjyGGvo/enbstHniSQm/n4EtE?=
 =?us-ascii?Q?1hFUg6DRT93h8RQ/TyPAjGHXmihn2BDUpSvq1nPzFpz/4B4Og2gcZFeekmpB?=
 =?us-ascii?Q?7RiiaJlLYCkrwz6ef1S00iE7RBUdZsnPCtoIb5KH+o6AsOqvv3MIlGvu+jsd?=
 =?us-ascii?Q?KVWV6q0pfT231M1rfy52xjQZ8jtVh/HnRO2Qah4b0odReOcD3e5JPqZg8xaT?=
 =?us-ascii?Q?sR/L5Befy/vQ1lPE1seO3jB8tAVXgWGTtMno9c0zESvJTSvCT95uwG/pwO38?=
 =?us-ascii?Q?3PZ1MM/anFjRfHSRXYtbw+UFdhM1oEpfF7HYbJ34D1zUpN7rdgoN6wLDxtH8?=
 =?us-ascii?Q?LQwRFneERqMmRhNEpfjFACvDAOr9xZR+/5r8yL/nEZFuc4SNDgB+uT55QXRp?=
 =?us-ascii?Q?VYA+6+ng2R2x9E/uZRQGkYrDayZoesHQSyzJB+9k5bNw5EzMdg83gAT5vSfZ?=
 =?us-ascii?Q?Jch1uF9su5DFlBrAKdm/Coxzp7O9ELsPxaodPYf4/kLi2yoVIPC78dA55LFu?=
 =?us-ascii?Q?iv5AkaHSlBlyS56LBX+ot3vWoHDtmnCIzPcjMjrLxid85jOkKMXHv0fxZU5c?=
 =?us-ascii?Q?Vft72QidCPPbbPyb1xQKmBNHiseeJEDwzB6y8TYvpkkdLShTypfydTKcHQMj?=
 =?us-ascii?Q?UGLZUL2Ku4ksnDmDPDg0xHbC1yybUN8S2/Ko0dEhhiPUeXmvm/xlbs67cRIZ?=
 =?us-ascii?Q?ztt3zzdf0CrNYEGiDNDiWUxU+nP5lyLb/uc9x9LO9J1Osj026xriAHx8qpil?=
 =?us-ascii?Q?1qlnriVOOtYkWr0MbcWI29oUpje0KRBje+5f6TyijBTQtZkqk7LHAhVYHJp7?=
 =?us-ascii?Q?S1eCgFFFDYsyNPt+GaVlqQRi/SdY7p7Hqc8VvI8lP8rdxsRv3Bc5R35zNuyN?=
 =?us-ascii?Q?6CAh6y8RIF0yhrpYmQxylQOzXiS0RnEOy3LXMLLgPHfzE8w0cDQJIJT32nFM?=
 =?us-ascii?Q?mbcQ+CML6W85pQnK9zUxIH70O3F0FoF/mM7gMapnN6rVmPHpTr0yJVF7GGdW?=
 =?us-ascii?Q?OIMMgzJ3YHbzeG55J8WQVYA2aEMXUYdBvCnUiQNcGU1CgxHRhcAfzQrSRQAH?=
 =?us-ascii?Q?aklldjYeYa+DnUy+/9bKIXdQXdK3HZmmU+40UXC+y89Jw3LLz86DN2LcIBV+?=
 =?us-ascii?Q?AwwhW+8l1ZYfEvp3CzJF5b/VhJ3EzHs1lhCe6yaeAABDkM8GkHffgSnGsz3r?=
 =?us-ascii?Q?jLfVZC6/i1qzt+Vt4wnuU8GuViai1E/xrJK1x2jK/YEGLqDy8y42qD9YdLhk?=
 =?us-ascii?Q?ZRlb2xAZXFh4wwIlcZDWLx9yBNogntn7KwWwm0rcslFI0wZc57upeg9WoIBS?=
 =?us-ascii?Q?Of1GUnvhhD86q1pJwczt73Bz5c8mPFV9XaaUmtRQAwBpIoiksIadstb1VT68?=
 =?us-ascii?Q?yOXtLg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b64bc5-2746-4564-6240-08dde92ed6a5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:09:13.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxN68X2xZ8d8ddFQnmGSXh7uFK3DxPeoMMwCUdpz2NOswJxSaOU7rBz69ymGY2690NfrOddXj0DIJt0CvpUOqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9780

On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> phy_uses_state_machine() is called from the resume path (see
> mdio_bus_phy_resume()) which will be called for all devices whether
> they are connected to a network device or not.
> 
> phydev->phy_link_change is initialised by phy_attach_direct(), and
> overridden by phylink. This means that a never-connected PHY will
> have phydev->phy_link_change set to NULL, which causes
> phy_uses_state_machine() to return true. This is incorrect.
> 
> Fix the case where phydev->phy_link_change is NULL.
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Link: https://lore.kernel.org/r/20250806082931.3289134-1-xu.yang_2@nxp.com
> Fixes: fc75ea20ffb4 ("net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> The provided Link: rather than Closes: is because there were two issues
> identified in that thread, and this patch only addresses one of them.
> Therefore, it is not correct to mark that issue closed.
> 
> Xu Yang reported this fixed the problem for him, and it is an oversight
> in the phy_uses_state_machine() test.
> 
>  drivers/net/phy/phy_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7556aa3dd7ee..e6a673faabe6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -288,7 +288,7 @@ static bool phy_uses_state_machine(struct phy_device *phydev)
>  		return phydev->attached_dev && phydev->adjust_link;
>  
>  	/* phydev->phy_link_change is implicitly phylink_phy_change() */

We should either update this comment to clarify that the function
pointer is only set to phylink_phy_change() if set at all, or do away
with the comment entirely. Otherwise, it doesn't make much sense.

With that:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> -	return true;
> +	return !!phydev->phy_link_change;
>  }
>  
>  static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
> -- 
> 2.47.2
>

