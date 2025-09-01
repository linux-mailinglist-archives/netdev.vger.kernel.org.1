Return-Path: <netdev+bounces-218683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC6B3DEAA
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34D63AE3E6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E467C2FFDF2;
	Mon,  1 Sep 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YnN8K36Q"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915232FB986
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719341; cv=fail; b=NWO3ONlr068IjuYL/l+HUhBc7qeLAo76wTEnH+YybZbx+q4JN1WWg5DFvxp30g7dTzhuh/g5/C6MSb8aIvekrnKlijbmZvgGjWoOJEM3aVNKuD0zRzC1ccc4LkhUvlZH27nx3vqnQQDi741l2m25oACycbAUx8eMc066e4IETok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719341; c=relaxed/simple;
	bh=ewxtSrE3fn1sga5ycKzGrwztdqfk74mPD+WmGDmeUu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oaq8Iii047WPK++OkzXnQ+3rjNCs+J7PTS+ghD4s1nPFKs9I1YeMfa4cl0KbbWbNFFbMGW/5ES2YDMS5fYKfQG7TPH4eyvHU/qUJBMbhFogVjESM6aK/aYT5djpcxgRSEAuNulSjt7ZK6wKh0/1TovNQP7buXQMZS6I0Y++44gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YnN8K36Q; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT6PSgjb4MlDVCu5NQhwZ6KZ9aDoj07Ty5dTSjFjCK8zpVdpjRWY6+Gkb4XshWMQrcZHk5217FbRFwGsSUda1QET8WI+KxLmxgEml1XaHjYj9OM33Rdvyz0C32S8C9F3OoCCTYiV+W2vht2qJz+Ps3YfUh80cg+ZGjmDXi9l2o+p/v60Vwyx9+cK5FJyB3ifanAG1QWqWyZGoJuN5NBNOPpLj51VbGMbrotM/N453H9uhLOYOvTfk2vMZH5qAvYvoPK+UObXA/I6TNqMoCf+/b8yjIp2udHh9ltUqzQ6H9cQLx1a1YeBgwTBgGzaLXJYnc3LGsN5w7FSQnjGWhwQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/bjiOhGLqCzfMymtMSj0dTbDzhMNcNVlnNiB9M8uR0=;
 b=HM3OO/ru74J4Bxr0iahVdIsijlZAwRpHTHX50syNAjDSULWiKU7jB6rEUChzTG79yt1pvXll7aUi6+cQWxGcCKWIrttw318uzSOIliy40uw0jxVA9uuzlfWbLRYKL75jCXKYJzHT9VID0wApqzxxcSqs60xOwSbbyV4im3Izov8rIB3vxQW38J3QZYpwaqc/0AenLH2yB0G7Idr4xgGUz1N7YdFgHxkFK2v2eUm1YHm3gAhFQ07PFioRdbBzwCdxrKeQExOpsHjnDYxitoyAQnVEwedc1dT+HV6nR1/Brg0wNE9tc43GHA6XtMYskIbUMw+RXECKmqpop4f+1qcCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/bjiOhGLqCzfMymtMSj0dTbDzhMNcNVlnNiB9M8uR0=;
 b=YnN8K36QAhBE17juEiUtRMvH3wzwWnWyGbj9g2iSoAMMbFuX0tA0AVxEXEv5qPVGBtzYXrb77juZnXrKRy//oCSMc9iM3qTs2XusufaBocuchg03YJPnlQAHwJlWwZV8dF2ALo0xZNZ8MxgS7bEzDvUR1vGYLSNf4HzfZ1KYH6ihaS1bfG5ZA5e9j5Q+Tsig9pO15Yww7Ub92xSKfSxQKawWlMJL/ake7rAti+5MoLXLltmgBIi1v6RYUrBjbEQ3RQjcTpi64UnMSBjWI1WEcnSAcz7FWuaX2+QeE4PFWzixVE/8WqamP6+2Xhw0OgMka+zWkfKQ9AZ7MlGk4YL6cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7376.eurprd04.prod.outlook.com (2603:10a6:800:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Mon, 1 Sep
 2025 09:35:35 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 09:35:34 +0000
Date: Mon, 1 Sep 2025 12:35:30 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: phy: fix phy_uses_state_machine()
Message-ID: <20250901093530.v5surl2wgpusedph@skbuf>
References: <E1usl4F-00000001M0g-1rHO@rmk-PC.armlinux.org.uk>
 <20250901084225.pmkcmn3xa7fngxvp@skbuf>
 <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLVivd71G4P4pU0U@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:803:14::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc133cb-24a3-4a15-29b0-08dde93ae651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgLoet2mI16ai4SQbusK2QGFjs1k8TmF8n+wC6HZJ4szovWAU0Sj0yyEDVWC?=
 =?us-ascii?Q?LXrahTEBz89UxkgvbEWt2ktDxMCL0CJJ9IKPsfncoh4T8DSj5+29WtwFTj3x?=
 =?us-ascii?Q?//bResiJUU3rOQTp//wt01l3tT5pa0jLuvbECPHaFY5rLCXxd7jEanGAA9++?=
 =?us-ascii?Q?EsWpP7pscjMj8vqmBxLfSdUbyvlVhEzxGAe9Z57LPEakwCpVEX7iE/jlrags?=
 =?us-ascii?Q?ZI7k8PaVHNzMuitD1RCLU73zQ0hw+SIzUoFhvQLWWNFeon8gc1LvUtrRMZcE?=
 =?us-ascii?Q?+yjS4RemcEqNRXa9aCXgjxw9tm5v5Fdvw+DbrxXlsOj6b+0Dbr8scER9WxpO?=
 =?us-ascii?Q?7xcHAILhpDcl8owaHhqER5FO6ZDqXm738Hzj4DHuVqzAdaDCYfN3Hm7TxHdw?=
 =?us-ascii?Q?k46I7IUnirOjS5gkX7QnBEOztPuYLGcqq6wRuEktsuPbSpwbzmZcuxFbsnhW?=
 =?us-ascii?Q?EASLCpD79WVXiZX61ER5GaCVR+CEJ30H8pmcp20yM4WRtc1RreVjckff8qQO?=
 =?us-ascii?Q?QORoC6qSCuOnU8OzLFXGxfnMJDDZxu21/5EOKE53G6AKc353OMz89L5dSWH8?=
 =?us-ascii?Q?dvXfOiZmvEcbv5FgmtBokgn+uwPS91UXNPdQBzt4JbhmAc6WsHC8qaZOg+72?=
 =?us-ascii?Q?126LaTaIl6PJx2hnd6xXeK0Bz65+K6RXNWQkgLoen5555ay7Fetsr0YuV/zV?=
 =?us-ascii?Q?gkjLGl1vt7KaMACVh5q7iQtv0qKcFwi8gt+Q0FhwJDOmvOWn37s446i01TW6?=
 =?us-ascii?Q?kKBzhK9BZXT/1+i8ZgEj88u9edrAx8y+LExsNmZkrcqA50nNNZ//PNp9i7v7?=
 =?us-ascii?Q?qnpje+5IlVTNNpDMGdX7xfPTbUjg4ivaN+Hyrr6CR/N4PiHrJ4/8ypI3PJH7?=
 =?us-ascii?Q?0sU7GxHuZwJF3mO4gfAammrF+60kZjwEBgaPySd3vl2jVPRXXvgFKEN6f/1G?=
 =?us-ascii?Q?kZguFL7RiCqzjVWhXMqZ3lutaWkpulVJT2oVjJshEzDHjfr9Ps0RRbq9bh6v?=
 =?us-ascii?Q?uLFUSWmg1bjl0o9wsu87qLlU3ja9F5sao874Yg9buQI/0QVUmQvWSlBNAFBu?=
 =?us-ascii?Q?H+vyteYTEd43OWlldX9dvCYgLT5cYKOiDjYKtisKSBTgMqfBobeiOb/1nj6G?=
 =?us-ascii?Q?IsNg+rPcC+YYD7GYKb9NIpvnshtsEgVDmNfxc/7Le8CYg+sBLmAUzIuiPxPz?=
 =?us-ascii?Q?luP9ve35IY538hWCV9ikc+XMAqx1BNhayENktGGPcskSiGV9Y5Nl400VbGPU?=
 =?us-ascii?Q?3JnA5mAVDfXxrtCnmlUfKqzlfRrPW2O8XHo70Z9WcNkeS8Yt88efXlxWNdqg?=
 =?us-ascii?Q?wSSAhS2+5kQtpusMte1arvtU5/fxzI6WWEQibIG9pqRDMAAKVIXlvro2nUBv?=
 =?us-ascii?Q?sCkUxds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFcZHFnNaNedU2ZpsWHruYankNzdY69jRUR/i4KxxQ6+XHlo1bd+BD0m+1L+?=
 =?us-ascii?Q?OypgEHZvaO13MEBBElGLNQ6q7EWcpivghuksIIa9IwsMd8HJF4pTCbe7mrg3?=
 =?us-ascii?Q?MIQpiZxSVdmOw4pGUMVyC5cQDECdANBHjP5GgmKY1ZglZPqg8tHlXuLd6K1n?=
 =?us-ascii?Q?bgbp7DsJ61J7wjY3amVL/z4A0rQv6XlXyH4oURWNIMMJdd8tptt1a4WuEj/f?=
 =?us-ascii?Q?cZTo/DyfH9rfNNYCfJVEM9NdLcyuVzOSqPxJ+L7hPVSDwag6YJpfnl91qDHK?=
 =?us-ascii?Q?r/ZDmGyPrqbXusW8rlKWXImif3WglCTIWdS8g9neNv9tgzIsFsH6/PixkNyb?=
 =?us-ascii?Q?T+SPeoswq91MXcwW7R4WdT1zg4a8oHHdDi067dUxuc2vpA0jGm7hrWuG/Xn3?=
 =?us-ascii?Q?Kui2P5s0yebqnetEnzwyrxeRKzEjWtfG4jDGv5E/oN9J+rqvmfFF0g58cTdy?=
 =?us-ascii?Q?Qr04wXK4sr1KMSuyYYkdXqJ3s+cLXuQcc0c+VYKeihJ/YU3gYVBkpfoi7KHe?=
 =?us-ascii?Q?iZlNQQx78gWcb+uN9EtJpBrA42LxWaNbKSpmPNAXXxmFTY2T1y319HZvnAa0?=
 =?us-ascii?Q?tYMftnOQwJaYmJBq2WOjuJXo+ErdG44z5fsR1SQhySO9IB/apRUWtGX2Il+Y?=
 =?us-ascii?Q?JqZhU7fRfobx/q3/6kVegRo54NnrkTWxik0X/mMuW/4p373JS1vj2Gr6i9N3?=
 =?us-ascii?Q?v9RVz0w3vrjsmAwoDjpcU0MHtrOsljnn4oAeolJXLYfy9yhmEiDTtNh98yA0?=
 =?us-ascii?Q?1a94Y/HSay+Ue0skSC4bySTxYIaflyze7vJTFfaoIiUe47aaQeTFUMTQM2vq?=
 =?us-ascii?Q?USmlH8KPQuBaoPkvyBcyysx1gl+EAtbgiYAOUbwCeTNM2ERSHIXKoAGMFCz0?=
 =?us-ascii?Q?9b8gN4YIWd87gTHl038KOdGY23wGtvHVYPSFKbH4G1JzWywkSxPbM771iPJa?=
 =?us-ascii?Q?RxdjoGTaM5kH5TEKbuqPBzIBcR9dNSijCXyYVDDvZfGWi2c6bpS8LZvVDOGW?=
 =?us-ascii?Q?tVEvDb3xmHDZZb6mBLhjfffzjHca7bxtFOthHqvV4dSVVaBxy1hv5eSO3JHJ?=
 =?us-ascii?Q?etSQbNzHWJ+4mR2GOxnAHGFQSWq58HRK9/LPo85z+zaPWTpavj85Dv6Ecz99?=
 =?us-ascii?Q?gDNcg8smOxU7xgfHQR+CvhxF0lET8rM7DTgk7Mikt48/LYl8krbaNxvTM12S?=
 =?us-ascii?Q?b202qXQWF/6ucheImk6LhUfNOOSmOHIL4z8qSXKKx4pqNpRVNfXchsDpNX8z?=
 =?us-ascii?Q?PWGbe2/qaA5S3O0ijGM3OzlhQvPVJt3t7ixR4WOEho/8vbMrU0uGfOlfWDkP?=
 =?us-ascii?Q?O+OILZflhHtsi/d7bXIcn8GlXGAXDcamvtVucxIXmPG1Wdq0Hk0UBpWAII3h?=
 =?us-ascii?Q?LnUc+zQc/XOl3NhBNOn5TyUzT+/7jiJq26VukhggKvXUtaBc/AKRw0lJweAz?=
 =?us-ascii?Q?q8+mhT+o94VdF7nEN8A+yGNwNExf83e7ZIw5EwSjmDUeAKwIQzFk9+KHE56x?=
 =?us-ascii?Q?hoAI/xmukMN0GfJojQykssV21VejzzI1SatkQ2D90mz9ds0poRAqR2WUBnKH?=
 =?us-ascii?Q?3ed2l4O6ZVBqySwbjKde1WqDkeuQ1HzEZpXa2mHI281S/+KAy7mU30WDMGX/?=
 =?us-ascii?Q?eqakIO1cbyuRu4CK8p+myoGga82udpf1MMcPap7nUwG3i/d3ZGsM91yJvvOX?=
 =?us-ascii?Q?Io3xvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc133cb-24a3-4a15-29b0-08dde93ae651
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:35:34.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLT8+t4GY24YKkN+EwAFPKqEatWlFCcTDxV/ninwACUzR7beWWuEJicV0rItaGCkvoeng7s4sijEoW7iCuRV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376

On Mon, Sep 01, 2025 at 10:09:17AM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 01, 2025 at 11:42:25AM +0300, Vladimir Oltean wrote:
> > On Sun, Aug 31, 2025 at 05:38:11PM +0100, Russell King (Oracle) wrote:
> > > phydev->phy_link_change is initialised by phy_attach_direct(), and
> > > overridden by phylink. This means that a never-connected PHY will
> > > have phydev->phy_link_change set to NULL, which causes
> > > phy_uses_state_machine() to return true. This is incorrect.
> > 
> > Another nitpick regarding phrasing here: the never-connected PHY doesn't
> > _cause_ phy_uses_state_machine() to return true. It returns true _in
> > spite_ of the PHY never being connected: the non-NULL quality of
> > phydev->phy_link_change is not something that phy_uses_state_machine()
> > tests for.
> 
> No. What I'm saying is that if phydev->phy_link_change is set to NULL,
> _this_ causes phy_uses_state_machine() to return true and that
> behaviour incorrect.
> 
> The first part is describing _when_ phydev->phy_link_change is set to
> NULL.
> 
> It is not saying that a never-connected PHY directly causes
> phy_uses_state_machine() to return true.
> 
> I think my phrasing of this is totally fine, even re-reading it now.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I think the language is sufficiently flexible for us to find a phrasing
that avoids all ambiguity. What about:

"It was assumed the only two valid values for phydev->phy_link_change
are phy_link_change() and phylink_phy_change(), thus phy_uses_state_machine()
was oversimplified to only compare with one of these values. There is a
third possible value (NULL), meaning that the PHY is unconnected, and
does not use the state machine. This logic misinterprets this case as
phy_uses_state_machine() == true, but in reality it should return false."

