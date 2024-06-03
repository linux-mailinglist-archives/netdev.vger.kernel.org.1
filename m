Return-Path: <netdev+bounces-100034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E38D7A03
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487311F2160A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41604A08;
	Mon,  3 Jun 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="PDABSfdm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2100.outbound.protection.outlook.com [40.107.243.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B304A20
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717380010; cv=fail; b=YhUS0TyqebJoZQyyyNbZW7g2Q4gk5ir9tcZfL4sjXJeU9Ds9eEB41V9b4ONE9NpwfydIRDbKhYn+aA+en6WOmfBSi1fPZUtMT/zh0jY48lUscvj2zFwXPMk2mjslm0nvXPxD78BWNE1Bu3I8gZBem2Wum/vz5LX8UToxzkyv/Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717380010; c=relaxed/simple;
	bh=AYGaCkAF50h1tWWg1JOuN2Ic5esGhZ6vRosqAhh+S4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D+YjvBIi2KwPK8zioqh3rOeWLbp7Lwi+aYbZPWGKmqeCvXofUKbeEBvys13Q594nVG4xcC70mOBfnfp9jNIXFKj3kKmZQVEwNe1WtihCQlujzoBFdVDURKvwIrIUcNYGkEAOa025J/vC+oK8w39Ooza1WOHfr0fzlahXLMiU7zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=PDABSfdm; arc=fail smtp.client-ip=40.107.243.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Shswk3UkiXwiax8kaZuH1stdG/Wl7Xk8tz11ICs9Ry3Gs0HzBAhx8HLnXmUoAE6G7NJTPxYZ1fa149erc58+sVzOfaV4xnCiSX/N/Wewvb6UwJNG1bMhfYg0x5DzfO4oEYsdNYEnZwEHlgLHOC10viYeSrTrD89prdhl21EgWj8p0Rh2drNoKhBRdPdVmvcwK4zCNIf8nQgWdKhNn848s+xzSDQBu3GjJg5vkAg1G4i+x/CPYNksQsLkgzYjMqFQzCIjmduxhyhqz6w4Fx6XG3qYMpmE8DcZbbugWaT70Zcz16+i5B9oiO8R7xkan+sTX3Tl3FCV78IRk+diI3o5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNDjvm7ngWkMRfo9K7kDeJB1hEF0Q1UbzXrn6HvhCAc=;
 b=FLfPiu3Vv8ggWrB6a1rj539HYxZjPHqtg/oadarYdlIgqxpu0cS0FnzS9kSlr7BTWpJf8AppB1OKnKCYKkhF2dOqp7fwn7uk2tm8j3KIWnKb2186HZaZni0XdNt/ub/WUp8h9WHp/W1pMFWVBfq05w/37Pg6Ih4efC8xXkG+SzKvDgcjh+xwnnHff1knjrx6X91GXn+D6H4rZy9TSLFQUVQ3KCAn/pbeZr2GDK7DwH9VLZ6QnsaNw0qst9AbpB+D2v+lwqtOHonbvnst8KVahYlG57FF42x0IezeP7VlHCAVytge2pDE2o4dRGMV+KBGyvJA35Bi+6s4YBq+2xFdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNDjvm7ngWkMRfo9K7kDeJB1hEF0Q1UbzXrn6HvhCAc=;
 b=PDABSfdmz+5grOz6agvD10z0RyWOOYqOk5DmLJjsPG/NZJenb+xo3hfIZ8fY75wOhKrSp5vqr90GuRmi1BgnwcRpsYTJRQs2euemYzHAJicibXqv6T7GyX+rDGfmTLL/mi9pXpoS7g3Jy3Ri+8+AeD1bBlUsZ1enqYpng9+90dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 02:00:04 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 02:00:04 +0000
Date: Sun, 2 Jun 2024 21:00:01 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 1/8] net: dsa: ocelot: use devres in
 ocelot_ext_probe()
Message-ID: <Zl0joZpD8YXMXf9h@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: d10c5915-246e-4127-b9b5-08dc8370e2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aq0/i9kx+vMx0a7H1usCskdKeejM2j8JSIrLf7theO7IlhYtVZjx/NntdHTK?=
 =?us-ascii?Q?oj55zIWCmsjZKyazqnjlMYrSfpjllsBbLhS+Myy5xv08cTjCkSTsTZxPuGGy?=
 =?us-ascii?Q?TCQM9wjrU69gMDkrmP24oTsOBPsE1c7PCDOAbHoS09eLjoiN8NDJABmrc76C?=
 =?us-ascii?Q?AINU6Oi1CaVWG0cYVdnnwJDjo9y0p/oE9xQI43tm1t8sm2ZbJdfpXPia1FUi?=
 =?us-ascii?Q?XWc0gRiffaYC3Rn7mK8bTKGn4BqJSbTyniqmQpcLEk/lEYbLdlXe9JB4NO1S?=
 =?us-ascii?Q?V/5zwbzLmKeKsteImBUDq8+V/P/ItDhrnFdC6ueG5UnRMgNcBt84mBf4hKYU?=
 =?us-ascii?Q?s3nx3KWDBuA1lctFJyXg11gxXJ82NpLneamxKBHzPlEWfclzS9o/DJ2H1zML?=
 =?us-ascii?Q?6IeC8DCeLj/9yd6KQLgZxfeT/Po8dt17rp7dUFvo2jJrpQorXnYCKD8wo0Nk?=
 =?us-ascii?Q?/oGBYUVsPd/b1mScMqDhRRtNYZxz8V2b3GkdOECM9YW7Tj/4aIShnAY3wG20?=
 =?us-ascii?Q?2PsezZa27txDOvJMQufSBl+ncRs+dP8f5FPLfjT5gSC3OOC6YWTmuFW4vVeV?=
 =?us-ascii?Q?ZpxRT2XOpm5YAIjjQODhPD2euq9gSfoq6l0ancCpPuMLICUaUbXmSLZz1cDq?=
 =?us-ascii?Q?8X66tVVRLm++rUDdVCuwyEx0nvReBFjQMQZsV4UuJnhu90EdT3XUIMJA2aIl?=
 =?us-ascii?Q?6hHiWcC+TRdYipAX9D4xkIG2RwY+cPrCTxbtYNV6oLzhZMT+IP+q93u66zzO?=
 =?us-ascii?Q?TlEMo2wZI0CFOv/8keHEXytFjk+QmLbYcYBWcuTzgVef7rJF9swwLqzDx4VN?=
 =?us-ascii?Q?3V9lFIqMQzCzffkzsZM6G771S2Aj14QiHMNvwzotu2Hqces5VUDiQJeo2lG9?=
 =?us-ascii?Q?svVrFW+gMabs2L5tc3UyYsy24AQqyuUMhA80mS0fd527JQC7JGbafqPU+u51?=
 =?us-ascii?Q?VnEFtfc/ga/ReIxr/oDW6pnpzGwPujdS09wTykc8L1okWdl2OQXvNWBSxIqy?=
 =?us-ascii?Q?O6+bcusw1ZUslNS94e4+G0DXMEKjwgXK1sS9r2H3foizWhXiEVV/kl2hj3P4?=
 =?us-ascii?Q?1jR1SmCcEJfCqFeLkf5rfhvZAo6jfj+g/SX6jB3zI7s14l2PXLlsrNDAJz2T?=
 =?us-ascii?Q?vNEp0yfxtvrXUZKohZgYyzeT+Vb7ZCFdYajQrTEGvnnQwu9v/Cnye/uHQIly?=
 =?us-ascii?Q?CXY5pREWJaOULQviDl0W8pqqsoB6HGBPU33U7BS1f4FpK9DbFFp3u6TZ8LA?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u0uob9/TXoZiBm0Y62cc/15hFcdWyhBH2znO6u/qbIvw2SI2w+wBtKrPoKxq?=
 =?us-ascii?Q?Cwvs1sCWNYVzk3TQHwXZn4Xskhhx+atgnP+pZOvaT+r7kyx2m1BDKKS47WgI?=
 =?us-ascii?Q?2znF8jXDeITe5sfVzVpzDJwyCkDq+Y7PpDuiW0mchYOZDpLsLsLrjyYyKjb9?=
 =?us-ascii?Q?mTpb5t85HMJ2gAuKCVrp1/g0E0OrZqdensFAizjI8pa6mvyu9DzgENBX+6bX?=
 =?us-ascii?Q?v1ph/H+9BH20bzBlhbsnTlStOcAqEwgUhpgmieV9EssyuKgrYpoDap+gtxE1?=
 =?us-ascii?Q?IhmtllXYCUoBDRjJf2RL8RE5w9OBpTKYk3w7m9K0uICrb6C5unMKRUO+YXOL?=
 =?us-ascii?Q?Kcs8/bSCeIpkYFe+49R+hy/tNrNaEm6G7iX/uoX/QmrU2E+ABXG8LDcGn0hx?=
 =?us-ascii?Q?7bQAB7iUxs7MjIdh9B1Qens8/TuGZU99UOtygxCufanjXJN5W94xl0kGx2oi?=
 =?us-ascii?Q?544oLZmlFUPUpJujmsbWiUBScyMOPbK1IX+E2qSJjg1yrl6pWuGlMkJTB1RK?=
 =?us-ascii?Q?3KrpgQgxTP7Bi5uIAufb1wfe+YRpkUIlPsTnLLn+jI8FaWRnCjBzttp7ccyC?=
 =?us-ascii?Q?ob0AfW8sx/wxfF0mH3tmicOL1w87oRItWqcY8rbaMhNSp2451jemWQyDpGrR?=
 =?us-ascii?Q?wwZTLNpAAZxYzs2COL4D38EAjtcsxoHJKmGROW6EwjDknBASwjTV3Bv1gfPs?=
 =?us-ascii?Q?b1BftLYuT8XVXf0EnNQZ0aeWqzM7gzyUmbi56gSBhfQuK6KSQreNrnbuFafQ?=
 =?us-ascii?Q?oNOB3hcCjbg1ZAuJSE92e6xi65JnethRQ7882VMAq2cWZ7i7rMu2SyISJPJk?=
 =?us-ascii?Q?1aALTqrl4J6HLYi+KqH00Nc/HxjR83vfGrfflw9N4VWKkOAYqfSpbNblTHq9?=
 =?us-ascii?Q?A3w57INNFZjGZSDR27E7aa+WK8Xa9+fG4X3ztj1QDk5AcbLmdXYpKaYM1ZQV?=
 =?us-ascii?Q?RiCCwUP69d6h77x5C9Iioi3TXT0UvxgMNYCDQs4if28iD1fvnOVUAnptW5fd?=
 =?us-ascii?Q?P1rTw6uHEB3bKvLer4bNohJYPV5ayU3UPMoy8I1ZBbI2+DK5jfAnv/sDUp4z?=
 =?us-ascii?Q?cQnMQJ6AvUh8MS5BXCFNypzZWKIx+cdy6b7D+D88VyCYmGcq7GRJnN65/RyG?=
 =?us-ascii?Q?x4tQOdNb5gBbHzsY5ssVPvzJlUho5DkRKtj9s0JUySCBoLL9vkcym5Gzu4Q1?=
 =?us-ascii?Q?wPzji4yqX/VEi2b7TGhEx7jBIyT6yxOkr384ISy+Ea4ncFuz9GhqfXQHCPd2?=
 =?us-ascii?Q?NAYlVMC8+oY2aBPx+1mp1G+LeVtED4cK8dMXWnvBeHVOsglBfaPlrNRemj8t?=
 =?us-ascii?Q?aHiiBC5afWron+sZN+i8/yyaZ+DKNqeydlmL8D500WeI3/r8l+TJN2bxyi+1?=
 =?us-ascii?Q?p/2nPPcxThCGN5c4sFQz1s8f7RbqurAgzwD9+7IfIOTALfjqB6IaBfDsyr2y?=
 =?us-ascii?Q?koNskxO7QbZOZgnIBw96ehUjR7G15+2j2dp85ljRc1BJRBB2HJjbKSwlmP6d?=
 =?us-ascii?Q?Sikfpdo/CF042XmGevbvTW9+cnet1whkP+zu12H0SaNQ6i0h076P7JqVkJjO?=
 =?us-ascii?Q?vCaiPBpp9Awnyfd0OoPWydzg/IVHRPBGOef/TleP5E2jkvpvWjoezXTKlSrY?=
 =?us-ascii?Q?xAMi5SbAConE1kN14dmufa4=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c5915-246e-4127-b9b5-08dc8370e2ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 02:00:04.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPn2eItRMkAApF7IFNS7sg6TkKXV4NGKQAxdOQRqhe72lJkXTM7SyqtxSEj7FKW2uRjlhE+8Sp7m6vvMudJ5sSdnnJNoYs/emscAUvWvy1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031

On Thu, May 30, 2024 at 07:33:26PM +0300, Vladimir Oltean wrote:
> Russell King suggested that felix_vsc9959, seville_vsc9953 and
> ocelot_ext have a large portion of duplicated init and teardown code,
> which could be made common [1]. The teardown code could even be
> simplified away if we made use of devres, something which is used here
> and there in the felix driver, just not very consistently.
> 
> [1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> 
> Prepare the ground in the ocelot_ext driver, by allocating the data
> structures using devres and deleting the kfree() calls. This also
> deletes the "Failed to allocate ..." message, since memory allocation
> errors are extremely loud anyway, and it's hard to miss them.
> 
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/ocelot_ext.c | 24 +++++-------------------
> 1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
> index a8927dc7aca4..c893f3ee238b 100644
> --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> +++ b/drivers/net/dsa/ocelot/ocelot_ext.c

I found my issue and was able to test the series.

Tested-by: Colin Foster <colin.foster@in-advantage.com>

