Return-Path: <netdev+bounces-227146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE76BA9243
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1670A3A913A
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F71304BBC;
	Mon, 29 Sep 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kss9woDM"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C503304BB6;
	Mon, 29 Sep 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759147544; cv=fail; b=FOzeUOvfMwFFZ2YqpJoXkZmx4Is3GwopOkBDJ8Cg8X60LRA16EeU+WSX1FMDB1OECn/0YP5VHGBKUXC8da+We7UQGaGcFR/9KEI7scAd8w4C1Xf51Z7M7KqpURxjC5+3+R5zmHZ8/lpr9OPLUHWrn1XJUIBpPhA2ElbOrLfzz2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759147544; c=relaxed/simple;
	bh=/wMXkQtaZEnfcd21x7aEgqKd5qa1wKIDj+lQgbq8bw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C0Acxmiamuz/iYS23iJhDxaakAHiV1+mQY/bZjD8BxrOKXiFVKU2Gvb7viWyL11Ev3+0wc1ex2HICu2gFU0A0CItzgqadOTH18KAD4aVKMgVP0+71tL3ICgGn3jT5Mbl5jSGb1KaP392xDZFeo7a4Xuuohl82AxdsE64edMGkEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kss9woDM; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFVGVI5TO2+MKYvyjnh1phtXscWGi4RfULhr9CbES/UvIYelUapzRyyywmT4DswAZ90bOLrWky/WAKXBiURYW/P32fiYPNt/6im33c5PeRPRueAX639tQtXCOfnGAf3G5aVvSGwFdUvKvDwtEVE4dHjOZvjzMBYzdgUWPlW3OX4+Yhol9DHdXJcn/bzoqK28s0NiKBaodmBHpwvClS/qsfa8hhmy6OIMRlYKJfPw+WmT6xNqV1AtRE1MSOrv/UDbZHiYYoAtgBa0Yylru2g5Yosjy8Dp6XRjgiYMWsOwLMbyFVt4xFTyfizSrfd4ejdA0yyCN+XRbt61S7dtBctR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhfAa9JhIytB94X8hGXDoxO2qOC5MGiUDuxO9rgq/sQ=;
 b=iEo4bZPlEQ+HcgKLc9Zeis2aLvcUY6DxrRjYs6uMkrKTauPZBvWS8FE7l9JrQRBfvM8nhfNJnCP798smPoqXG1JVnLOEkmKNUXWCXnYLRhnHLftXeGHRirULf1wvW3ZdOYPLjolpLWpnXcjXPrKjoqv4qNespHkuANuNst1PakPytkee7Yjsy/daDbuUF4CpLmTQa0U1a27YFu9ZLyvdAkdlAwQYHYMTe1ItGi8JYcL3Cu1PKG8muMsQUg4PPmdLj3jThw17MYG2GSGqgyEjHTwnAWTEVy0UPGMGaS7lM3X2T3ZVQV+iUiCxh4WU6n47HOotMdhE7WLJp/IzzW3SHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhfAa9JhIytB94X8hGXDoxO2qOC5MGiUDuxO9rgq/sQ=;
 b=Kss9woDM5cwYbqoQlFK70ewjpYHU3Mjv4VT53DiBzT22m2/k7OEO7VNBmXmpwc4na7x9i55fZ+ETeR7bIyBmDcUNpMHAO64G01Rc1HhxTNVGQP1xXfB4HFpsLgcCaWsrJZFtbqylj01RIdLRLZjt2NgNT1T2pnjOyNihuEMcf+m9nqtLoKI5I1qiV8SJIzzJ18aSB0qYK/fyAp0B1XxqMmDDFii28T2QRGkwu6+Vd+EAHlbVHccitSDfj8c1nKoE5UZxNA/Z3ZWtR55zjhYMwje//x/9KXEkTV4xSh83yLnqoFHJLT3u8aqRpJ9T3L6u2p+NuaMYGBKHzQ3ahNAhBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8141.eurprd04.prod.outlook.com (2603:10a6:102:1bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:05:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:05:36 +0000
Date: Mon, 29 Sep 2025 15:05:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: remove duplicated mm.o from Makefile
Message-ID: <20250929120533.jhvalxhnxcbo75g6@skbuf>
References: <20250926131323.222192-1-m.heidelberg@cab.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926131323.222192-1-m.heidelberg@cab.de>
X-ClientProxiedBy: VI1PR0502CA0032.eurprd05.prod.outlook.com
 (2603:10a6:803:1::45) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6c31e2-1396-435e-91da-08ddff507fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VhmT6PjsROnfqB1APXcohbWE21OKacQRs/1+piAFGpZjcsoRF6o6F6hUvYrd?=
 =?us-ascii?Q?NbQVpSxHvqE0H9FwiKRgJPIV0VKZH3HbYkWyDsiZWsvHYphTO16eiVs71KDs?=
 =?us-ascii?Q?vJCcvMsyFrit2zMlciHgpQrcUatot7rPYw6gU94mftpbXZLv7FuAHMbHTCsz?=
 =?us-ascii?Q?LoPjt3ZNHhWpUL2q9x08de+tkfLSrbyajoxF87G3Mw4KL0eeCHmLxPJOw2IK?=
 =?us-ascii?Q?6+3DslYoLPeRWqs6l7XO9nq6sFGVwORt+ruRBPtMJMumCjgGEzx3y9mY+SQb?=
 =?us-ascii?Q?52UqibhvzfX0gdNECSmtsbQsNOy5XFA7kDk+rhVW7YxhpcYfLR9OLflyGyPo?=
 =?us-ascii?Q?ilaHyoYaBmvsePn5BKJVOb8lgz2+yAUpOdNY8XdS/MyBRgnwkjZ/Zijk7ISw?=
 =?us-ascii?Q?WhELuqBlNG1ScAV69koTzh9FvrswTn3jKXK8KfpH+DM+IJd4QD/xWiJlhfRL?=
 =?us-ascii?Q?aHMDqySeoSAqVNPWVk6ZvFnSMg0YX+OBB30URIiJGcPn/3Lgjb+5l1p/zZf6?=
 =?us-ascii?Q?ziYs6VOSeQMUjA1jJZXjinBgRvQxXRxiUtfMNCoMsAUa/+eBJsC6FqFMfrti?=
 =?us-ascii?Q?Zr/77o+hNVhJwMykaE/eSqpEjOhnu/POXdzNtghlbqzZgJSg8/ox6MFa6uKB?=
 =?us-ascii?Q?yx2dJmPhSsUqO8oq1w3YNbJ+VMF1urrWnONZcALmNGCIL3uQu6K/FoV1YAVA?=
 =?us-ascii?Q?sAbbAsPfQrrZaLquB8z88ep7HQm8a56qlAoPLTRu5OKLf3qg0ifmRXG6qTBj?=
 =?us-ascii?Q?DZUaQ429/D5Vv6C0OkSDqnxB7aIGTpU9JzgXcMOAMltFFupMaHqHX3C9vszU?=
 =?us-ascii?Q?va4mt0/beq+9wNr+KghPrtLl4bsn5qrlDUakO8XMuJoOhBgCrwwnadPwlpYG?=
 =?us-ascii?Q?n/xpQzgTIBQ3TJ8oE/c9JESD8QXcspxxSRWg2hyFEaTps/jhaZgeahvj06Tg?=
 =?us-ascii?Q?q+CMuOm3eYVdClfpBkmMneAl/Llg7gAcIibr3zrxDfCNnDivi7pCcPvBxL8q?=
 =?us-ascii?Q?BZ89Uu9hZyfOenRud7vP3Y2RVNlBZo20bXg02rhtEsEVjJORmz6QUyN44ULk?=
 =?us-ascii?Q?XVPg5gZKeI0ZDj/mMuhpgU1ngSzydBqYb9RMJ2G4gqU7DwtwJuFLpBjT1oAq?=
 =?us-ascii?Q?N+j+IprQVzoC2UqPLSrT+d4Hg9w//dXq0ohFrQUseUq6N0iWC68LO3z+gDJ2?=
 =?us-ascii?Q?cX6rJH+Y91+lM9276aM/NeXgK0vHzcsHqLmFWX5Lsw42dmwFGhh6SXLQDamN?=
 =?us-ascii?Q?3wrT8N8EwSHjGWpNX4NblIHJqd5cO+UCzkmNosA7D/dnllX4EF8sjxkX/7sd?=
 =?us-ascii?Q?zOKEDkzrird+rdvBU6PZEGvGjDFJpR7R5BFJF5QrrOU3dWnkwIm7hpxElemf?=
 =?us-ascii?Q?9Mtrn8LPvPPbiKYz/a5JDZ+0VXBrh0DINZeoWwA5buSKjGJEHCXxl6phq0X7?=
 =?us-ascii?Q?U5mslP2+tI02S7XNSIcqo9A5r0KcMZVM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z3M54DVpqvuvFfQQOfrJBMpUFW0fDJRcyFnzs+78KaTMZo4kI4hfKRnN82Ea?=
 =?us-ascii?Q?m4IPv1R+rE2E4DFvDQlMqfEDqHcJ7cesrKdf9rsmH50hbIzFTaEn+7EBcPRD?=
 =?us-ascii?Q?n2MQCB5DzKnlRTabnCmK3QjGOMRBR6sVP52E3B4ad1krUGrWsbjYqJGsRJXX?=
 =?us-ascii?Q?XL4OLVVwnatBEBc2ePeY8VdJUOHKXzqz9OaW/+B0j3t8/Vd03q8R9UEszHIO?=
 =?us-ascii?Q?aUcT8RZ4UywA131h5/5ORzi5U4h4Iv4pAow28ue2zXI7vupKuGoTGF0klpYz?=
 =?us-ascii?Q?L36ozIVPdQJu1grjlNx/gECe4liqymg9tMlBreVKDFaS0SvTRAmctg8cIC04?=
 =?us-ascii?Q?C3ZhXuq33QuPz+kML3pqOSVyGk+2TiJENoRbSSNm0+7sz9noKSWh/4Mlj55d?=
 =?us-ascii?Q?++Y6AxVlu/pDcppJV0W9veAu3yVRiQULxZVFzmV4XR/8Ci2GdBKbbivpOztQ?=
 =?us-ascii?Q?bKr7Wea5Dsn71XE12GhD2DfLEGVOm069LbGRHi1TN2ugWyGjVvGRxMeQodjg?=
 =?us-ascii?Q?QA0sXB4k9+MUg4MisxwTRziSN0ylQLv7vXcPws/eAfJ81Y8vUkndVhTVsbDT?=
 =?us-ascii?Q?9ho9V0BMtDygZ5b1A9yipYFaynuqQxPMDAR4+jLD7BeglrJT1IIYn60SLYxg?=
 =?us-ascii?Q?6i8VGRfCrH0bJsN7qwKdaST8/GCEKpTCK3LVSf92PtkCGkOwUtKa/hxqvdqV?=
 =?us-ascii?Q?bx8VpTMTKJ6gvIGY/aF4S5mmwvtamfDvdKHzEbu5i+fJXTSYKt1/mR5Y5wOt?=
 =?us-ascii?Q?xHP3hHCzbpNJcJn6ItxS140p8m2/hWAccPIfbaXzth709serwkeLGWr5mz51?=
 =?us-ascii?Q?Awi7a3Aa7zj+krlatUp0zG91QdDTYNeqWz+dHXmzLbujpxrLWMMz5jc4GBhy?=
 =?us-ascii?Q?5MjLdePRBIG3qultff0rsDJMcOYqAVZfdG2oWvTSFlnvXMp4zU7CElxc6CTP?=
 =?us-ascii?Q?R9dRedksfMXwHb4X8gz7pQRLhgNy2tvGwZtkwEv2DJG50cCrGES4hEOMZyNN?=
 =?us-ascii?Q?HnNloWrrJ1wOrvVxgQC5tJ3mlsBBwa3ip/WEBq2ErYpZlvDESzjpPG+AEJ1O?=
 =?us-ascii?Q?Xs9Pjj4/aBuv30zvw8YY6DSm2miHf2jvd5YJ5vhTKyKkuz7yJNvXfGHIyceJ?=
 =?us-ascii?Q?MVglRvJEohHb3Abpu2kSkR2+EapR0i7Ay6V32m9u2SzR74zwksqSkF/FXUNW?=
 =?us-ascii?Q?Y1S4erDvZ1DarYJCrU9lnOUNhzZrDPU07eScbDe7/NRh15fVtHtWzwd7FLqR?=
 =?us-ascii?Q?smvLD4A791eQy2vcuMI0AvD1ed8KN/rM2MkSjdEWa7jtjR2LZqdBPQqgdeac?=
 =?us-ascii?Q?jtkGUBeRsRW/OZ/+ftydz8jJVVOkcFGBI0OZPKluFoFmFf19miA4ntAUpiVt?=
 =?us-ascii?Q?XRZcLsb719sAw6QfCPIYCUs42Ff6ERvTQ1viWRdiyi8iVm3HP6BdAhV6nFW2?=
 =?us-ascii?Q?FgNEwThxomTDa1jA+JuBrcjccE/LhVL9jR7MaVEuDiizk08nvNZ2olv5HTZe?=
 =?us-ascii?Q?nd6Qh9Dd8eY5pG3CMe/rbBGUQJlC7EMJ2qhOPerJcjbwOAYTRquc23XcJ6hR?=
 =?us-ascii?Q?H2ssujg+HTaiLyH/UsXG/z5prSlYa6T9ZfF8vX5YPeMvaMS5ZDc3ZHGlViVj?=
 =?us-ascii?Q?VFekKK0fQP7ZKTbWXzYEWITMHaCa91QrG1VA76DpqeREooxcuYVqn901X+0h?=
 =?us-ascii?Q?DNFhTw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c31e2-1396-435e-91da-08ddff507fb6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:05:36.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yck/nYLaTaGUIr3mxOILJvdPsB/7BQYX9jvxo2QMxQjPCIO1SQuImPZmtoLePsWHQ8CppTal0LrIRA+EJOmZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8141

On Fri, Sep 26, 2025 at 03:13:23PM +0200, Markus Heidelberg wrote:
> Fixes: 2b30f8291a30 ("net: ethtool: add support for MAC Merge layer")
> Signed-off-by: Markus Heidelberg <m.heidelberg@cab.de>
> ---
>  net/ethtool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
> index a1490c4afe6b..1e493553b977 100644
> --- a/net/ethtool/Makefile
> +++ b/net/ethtool/Makefile
> @@ -8,5 +8,5 @@ ethtool_nl-y    := netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
>                    linkstate.o debug.o wol.o features.o privflags.o rings.o \
>                    channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
>                    tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
> -                  module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o \
> +                  module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o \
>                    phy.o tsconfig.o
> 
> base-commit: 203e3beb73e53584ca90bc2a6d8240b9b12b9bcf
> --
> 2.43.0
>

Must have been an incorrect merge resolution on my side. Thanks for catching.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

