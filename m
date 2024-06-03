Return-Path: <netdev+bounces-100175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA48D807A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6691F2126A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C67E0FC;
	Mon,  3 Jun 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g9CLrUgB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB878C80
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412506; cv=fail; b=s025Tvvl/t+G87uOzIEUUCUaJqrbPaJWSlX964TlPOQbMSxom3Z1ObnQG3qKIHF5G+b/nG35HsL3ykGOhiKxdKa8HM48aQZZHFlIcf8dpF/dzwL3GImjMU5kU6Lzq4NXwxtExONP+i9y9KktURHmFUXttWfOhYpCrPQ7BxjO5CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412506; c=relaxed/simple;
	bh=/72bBi/vRwVg0lZFi0Cz/6tOZqojeRPO781JwkmAHio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQyTRj03NhHGsoKE2fm+S+2efGBqFawu2fT/DiQ56yDelwj44d8NHeQas/yldaNflVozVINYJ63h1A7t4wx+LdmA51XZEvhhvqpEjF04dbYse3ndSA07Wzanlh22T/llFT+ubaLbPdlu+i2s2sLfyP8y7NWvvLutNYWpXQiDNMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g9CLrUgB; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZGaji1zKitxPqIqwLruMUW1fr0eSiSuYoVVgH7xfuz1yrhsxvS/j5IjlXWxA6yHQt1BUurd662Ef+LctANykxb/2KH3u8oxIMqOMdRbczMvPgX03EeERxtBiNzH5hWxA+CNFDLq0iZcY0YOVlm+25t863afjdkv/B8MmeR+ETRCSkYZ2XL+hyMYelJg6dMerQudV+cFAILNCWYx3NB4R1hkMX2uvpQ/WITcl7moYEiGVeEuhH4KFeN6C3Oi+BcdelopxVo4/uL3bqiVVMQehCTtu8utK05zh16rMWJOo/lWLO80lmBcJhy5zOoyLirGIMagXTdN+a0uhN9HBgPdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asrjViZ3tdJ3Ge6+c56GM1Tt80pubco/OXZsU+Ic9Sw=;
 b=kjID3QiogcEHo5C9b5LDX7/FBPJo/8t3jWSX8zUn1Ulkr5H1+JZpyZCnC+suQtBrkR8Z1BmyciVWSQe0/M7LoEhkgfnj2UxdDBWuisNv8DOCCJsWncNKjkRPRxYsWEQvIzfugbSEF0ayALP/oFYXIcojBK0/IBsQc7bG3BSnSFWtk8EVgbNe3req8I+c8nPYmGlv4CEHU0ggOGoM2F/2rX2s0T1sdz0nBnpS021Efdk0zqnaKT0IDFuzuMgmYnLr+4ouZuRbd5y/zMFgvcvnWLFZLKeEJjT70vT+ajuEeFisoZzsb6BJmDveNy178M7yphdWOxgFqcWgRhWvMY8LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asrjViZ3tdJ3Ge6+c56GM1Tt80pubco/OXZsU+Ic9Sw=;
 b=g9CLrUgBivkdbN0AiR9keJxDQQ1gTXb+h5jHNYzz2nXXX6IffhQfv9+m9cGupf8qg/DnQa/hTNjOeIjiP2Abt5zcpiDBdUUiBrsHRcmWzrj5Rho1OkPkmOghqshTMvPwzTZp9/l2vGV9Xw1z9EqNlKYfuh3X8BmqNDNT9piutss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 11:01:41 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%7]) with mapi id 15.20.7611.030; Mon, 3 Jun 2024
 11:01:40 +0000
Date: Mon, 3 Jun 2024 14:01:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Colin Foster <colin.foster@in-advantage.com>
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
Message-ID: <20240603110137.4b2a777e4ivzxc5l@skbuf>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-2-vladimir.oltean@nxp.com>
 <Zl0joZpD8YXMXf9h@colin-ia-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl0joZpD8YXMXf9h@colin-ia-desktop>
X-ClientProxiedBy: VI1PR0102CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::34) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: d18f1431-f916-4a5d-77c4-08dc83bc8c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZHNO+1Mfu5Td+NPQf08ayZNVTzw/7emF86XCx2rwYybjNsvx/yLa/H34S+Q?=
 =?us-ascii?Q?4WGu6L9AMYVMSoyTs0/uucCjO4osO/xmCeJ505pfU2r+A7RfSDRkRUwZH86a?=
 =?us-ascii?Q?qzKmXrYCYNfwYedR8Ft9sZUB3TZf82y8T/ZZXrf8LPX1sLEF2iOtLWTivBVy?=
 =?us-ascii?Q?46LugTVmcFBJrunucAzDKlNOodHE3v4cbAbpu3oZ6r4EuZcu+lwsJIt6ymIC?=
 =?us-ascii?Q?CKQr9bcs4fw+XE6XU7qivaiT86QoRm63cR51sZnf+G6VJLVV05ik9xKwD62C?=
 =?us-ascii?Q?fo8PXeC5KRTi5CCGrlQLxHKaGk39doiENSDNudvYMZ5ZM2Yf5RzjlypGe03e?=
 =?us-ascii?Q?A112KQs0fLeKUSit8gTOkmh4KT0m60YRUaKLwAQ7VDHoB5pnYwwZeI6uJ7sn?=
 =?us-ascii?Q?Llj0H89oXADB5TRnwHuQYMX5UKi3EwyaCZYV5ITxsMab7hVv9kKb5nk/HCPK?=
 =?us-ascii?Q?ljwtdXhsE1ON4Ds3QHzTdM0QQmhpr8nGSGPpD525wrjPxTXso2SJ+x1kRdj0?=
 =?us-ascii?Q?aTOFDZ8vlHECvndyd1z7fd2AqUSDp96kuZFPWaXr05sCXA4+4XUW4N+w4UML?=
 =?us-ascii?Q?fMguLPcEimDXtefJdzwuiEljk/LfWuv6PdG/urN9QTUvLo8ys0SzhP5+QDdf?=
 =?us-ascii?Q?arOd7TAzfCVEGHW+FFRKeTtOA0MRb6A1ZrVVUfaevAEpL5e0MxWz6VBwmE1S?=
 =?us-ascii?Q?4w14GUXpV+q91X7hKiOH6AQP9yDWXcCG8R1I3BL+TVIO/fk2rRlk0hemSdy2?=
 =?us-ascii?Q?yt6M2OBFQ1iqxxE1UC670l+YGuY8uQSD+PqLsO+QL2eIu/OPk/PnEDGpBAbm?=
 =?us-ascii?Q?waSEMH1uC+Fus55ab+CoCeEfSJEBzRoagIzCuyRXq5JPNt9EUP05JQ0wi/7e?=
 =?us-ascii?Q?BHo0ZGg+vsnvJ3Rn0VFLawiF0NLNSvXjzuPP4l7sKA+4GHKzXw1l43IuGAbM?=
 =?us-ascii?Q?XvJuTkkHvFZIFX+9hu0zBXOStTzS8RiK5MGBK9sHQZZVZUsYlkXoby8LqfS+?=
 =?us-ascii?Q?EVFnhPhuMNp5Z3o4fQdP69sShvZ+DKWHRuBby2yjAWpQ3YcKh4f+94QIJcrl?=
 =?us-ascii?Q?YOBG3M/+xRN4QELbTFxlFxVf3I4padVOFog+v3QkThYoEVNhtskQZarLOlRa?=
 =?us-ascii?Q?tTC1qmjnhMNrtFvpKGkj+rfCkOfEss24uCJO2GS+S1V76ANHjt+Q86fWvd8m?=
 =?us-ascii?Q?jt5QDxB5E4VWzpOMkNlQbspwgIkitbQNPop5cApsBNjP4mJxZQE0XISStbTC?=
 =?us-ascii?Q?QZoFU6tCQi78hBNWwxis2PlL3j3A9sdjSX2TPPoQxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZaU3ggEwaD3zcEQwqKCMU3sng6R4XdwoUCkJ+jgo6T6IL3iAh9jjE4o/gkZU?=
 =?us-ascii?Q?9oO7sjRjnt/LWlxrr9Wd5WqFtnqvvoTvlX7RKLMpnx8cMYLyDi5WqeDm2rGC?=
 =?us-ascii?Q?fE4SGE/q0J3SXGMuVIPcpP3RpEeguRagQ5Y9SlvFVTls6qM5kfZ565XgN8jK?=
 =?us-ascii?Q?E8cKUSU5o8opRh6OwkBT12zrJI8L9sONtoaqOzQUBwsqo0BzveYGxh0tbogl?=
 =?us-ascii?Q?geboAhFrdH+NneQNPha+d5flh9KpHa7ATej7DeVou6RJKU8Az16MsQDJEiQW?=
 =?us-ascii?Q?njkRID/v8WZlzuc2wzS/rJht6Ib2DDm4FldOQr5zMupHy1K/B5HT7ANCRfjh?=
 =?us-ascii?Q?hXng7k5AuDWl2HbzdSy5GzGWqcKRLhfFsEuAke/PCLaTRtzBFddP47Jbwcr0?=
 =?us-ascii?Q?CBreWM67Bff5RfJNvYXMxQ4eTbwqwKcOTdu/K3n6HWwxmHe0zg7+iE80OheZ?=
 =?us-ascii?Q?yzKCqckhudmVI1vZxLxYcyuTGShwoMYjeVDKD15oWTi4MK7L65VwAOa/o1W1?=
 =?us-ascii?Q?ocFd7CnCSEdH1O3wUjvr9hK92JZbYXUH7hPy2gvNKIGHN3BjwdFfCM/3uV0K?=
 =?us-ascii?Q?Or3OWroiltptqPpIPXs9tVxHq/jPAjmmuzWzQ4Zz1CqFWlFykcIGDouvKHdj?=
 =?us-ascii?Q?CzNoX7CrZaNZ/x41VAX99pRYNW02udHXf1sj6GDuNSYbQQ1NvGo1vNp/Ewdi?=
 =?us-ascii?Q?h271zN+x1hBczCCehhnf3wlk4OCnwrT+RPRrCdJ8SfnxAajRRmq0wb4uizao?=
 =?us-ascii?Q?pzRw6QboIvuvrs/BB99W2rLob0WLGOAuHhsiK6HdwqJ0qIl66E/RcJmSFN0u?=
 =?us-ascii?Q?l+dwAMZmXsAdfKBcXsXQQbialwe/L0xRXCUYPVkY+DsJl6BHrTRd5nkMuHi0?=
 =?us-ascii?Q?HVkSuwJIPKXx5EkL5yfIS02ljRKxdkudtsSN8kynB0GnQjlk7B6jhvOqBqUp?=
 =?us-ascii?Q?RGTH6fuYJUaFDK17dxGM8DyqdPwz0TjVExl9e82yC8SBF6ZNvZ3ercCmXLXc?=
 =?us-ascii?Q?1x8W0/n0MILweYHFi8Z/NZULCEv9EldjzjOhWDr7c5S1zbV4d8v5a80Fqj5N?=
 =?us-ascii?Q?j6JRShR6u7Ng20LAesmjUBKwA8AmeA8sDvXvbDkmXbggzCQ8EOe5GVtulyMV?=
 =?us-ascii?Q?umwgIfrYjsZL5zTUUDDoZ7suFMIPpKKBgI2tSgYLaIo/vCxdcdMLFKc7Mnwa?=
 =?us-ascii?Q?ly+vR2wDHRl1DXbGMkyQVqpxLHsbAGKn/ydJ1ZtyTSsy9WuY7hpnoexpqEQO?=
 =?us-ascii?Q?rxP7YD6IKqZ4aOei5cnw8366xrnAhI13udXpqJ5Z2C1ivuADEcFINohk0qJe?=
 =?us-ascii?Q?JzMoT0l0ZnQiNKWhTPCc8nTdgTvYiCHKD+eJUKwMAJ0kVZathCiaTduHf78B?=
 =?us-ascii?Q?jhzsgQrAdr3orVKJXNFNsgd7T1FTYu9kKtDwnTWOnp1YTbb2hww1bqWeFGQC?=
 =?us-ascii?Q?BDrhxYEEgB41H3z36Kks+W/MUg4PxnH2KIimWLddLVuaPUJEdBzYKCojJjST?=
 =?us-ascii?Q?uE+gUe7pViRrvgn5I67/W3BDRWmN1dbY3zCnwlQBKXv8JIzAEZY9KxdBPlVC?=
 =?us-ascii?Q?bcnrz4iagCTtyWbs+3m5AV5Yn/zcPmNwODLtUr/0zzqnvlUtscG+epcKtFeB?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f1431-f916-4a5d-77c4-08dc83bc8c02
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 11:01:40.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHQP+fTCitNnjsCsdYu7+rcOLHuwz/7ePp0fq5rNRrspQX3jWUwgdDciAjnVh1sFlx9WOShPbQM+QDclj8c5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335

On Sun, Jun 02, 2024 at 09:00:01PM -0500, Colin Foster wrote:
> On Thu, May 30, 2024 at 07:33:26PM +0300, Vladimir Oltean wrote:
> > Russell King suggested that felix_vsc9959, seville_vsc9953 and
> > ocelot_ext have a large portion of duplicated init and teardown code,
> > which could be made common [1]. The teardown code could even be
> > simplified away if we made use of devres, something which is used here
> > and there in the felix driver, just not very consistently.
> > 
> > [1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> > 
> > Prepare the ground in the ocelot_ext driver, by allocating the data
> > structures using devres and deleting the kfree() calls. This also
> > deletes the "Failed to allocate ..." message, since memory allocation
> > errors are extremely loud anyway, and it's hard to miss them.
> > 
> > Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> >  drivers/net/dsa/ocelot/ocelot_ext.c | 24 +++++-------------------
> > 1 file changed, 5 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
> > index a8927dc7aca4..c893f3ee238b 100644
> > --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> > +++ b/drivers/net/dsa/ocelot/ocelot_ext.c
> 
> I found my issue and was able to test the series.
> 
> Tested-by: Colin Foster <colin.foster@in-advantage.com>

Thanks for testing, Colin.

