Return-Path: <netdev+bounces-96932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8898C846D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD361C21F54
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772422C68A;
	Fri, 17 May 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HMcaF7hS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F7224D6;
	Fri, 17 May 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940274; cv=fail; b=TZac46aZ50Dnph6CuErkKPo9tI7GDKF+Yw5vr2dOJ/dWBaOrwvSAjLC1ICy1FwqDdn9v0YVe8Y5BalOesUy5tAEkiISy3MCxCVEUd/DucXmUBDI4avDDCL2bxmxxlNOacczQcc0npiDeTqj8Ih98ZtLpeDDdtdkJdT9XBTYG5/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940274; c=relaxed/simple;
	bh=Cwffk7gRtXU5i1h99yRLbnFLd2gC2IUmPKesLcn8/6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wjf5fF7IpyA+NXUapoWvw7tuS07U8cP0bjlEfIpsYYMfdRMs9nNdykqfgK+Kr5423ZP/NhCOwRTDxORXGraAQCjgtuTmhptU37AvaAjLzPWXOj0sHslpoSBcZlW3rZX+nvlLv5AFV4e4x1i+5vJ1JjOlpR+kjO3vK85bCXm88Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HMcaF7hS; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na0Yi0IOl1gQk+U1G0vOVsPJMHimCN9o9W3Ca/rxZRpBVLrfGN/NysvQKaCxGbMP8lY3ognjpGjqAP7Ir6Ue2/7QsTM6DIPNuw4tcWFZETXTlONB0ensm/efl6Idl39UXSSms2XAp5TeGA31gI7C9FfiaWVCg4jbt7+fgHYkncTE4jGN8EmR+2l+6WeP8rWnYlSWTLSU8Okt/w5lDf+dGeUYfZPqUf9ggu712Lwlla4iAuMGFmiCSb05Grg6NUiQ9E4c9fA26x4cueKxCBtmDN5Jh3s4yx65+IPOmzfLAjZGTb70Nsk8jE/vFlqNpbW7n0wp2Ufj/Ge583nQ3IwLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO627+wAoaMhA8WhEXPpdFBWRu9NzBi6STAfEbkrR5s=;
 b=CVZ4Ny3/2z/jqIO7vBkcrZLMLLfiOO9ydRI1dMmys/fERKCnkcOpdDe3J2xFteZxNA512IXyfTw7Sy62yUYUCkyC4j+9WEyf6mfL0FhM3bl+OLR8NePaC2KaoA0LmqQPAfqZ5SFmz1ZRd0SIor6mJVt3dMBluClFvr6Nm9nTVF81oao6cB31CEIDlafLJvCuorlGaT53hE9tuHPvvcPcgqLKeLJOJBpECl5za9nOah0VGbdV77OasEL2T93wnz7JXwyHh5aCGmyntZIjvJuRMozuTOdETX2F3s0HeBjfGhIvuD1YoO7+blvK+AVpulkxvyjVvkqqqzBYA1++2aFgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO627+wAoaMhA8WhEXPpdFBWRu9NzBi6STAfEbkrR5s=;
 b=HMcaF7hSHPcNszoQfzmgudrPKJxG5w5gwyczdmQUCll0bioGJclvAxHrhY+orX5Hb1QeY1jCUGZTmOcyNdABx7zlCqCqz2yAy+ICkDhL8jE0K6qgomvdJH1nJ0FR/2qoP/jxbQQRxnqcHrw/N3cwvjVRXIVZQnmwRzKdnJ4fRKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 10:04:28 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87%3]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 10:04:28 +0000
Date: Fri, 17 May 2024 13:04:25 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: lan966x: Remove ptp traps in case the ptp is
 not enabled.
Message-ID: <20240517100425.l5ddxbuyxbgx42ti@skbuf>
References: <20240514193500.577403-1-horatiu.vultur@microchip.com>
 <20240514222149.mhwtp3kduebb4zzs@skbuf>
 <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516064855.ne6uf3xanns4hh2o@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 01046b81-83da-4d51-c3c4-08dc7658bcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hz5C/4fifaxfJfRXYATk2mEAS9BcdkdZvO++K/AC0VjMpvGgzhj4ty3x9q7R?=
 =?us-ascii?Q?6rP85qIFsAlJ9pHxeGznbIGTNpfI/5UOtzScFhqSXpcnpM/F3I3N6bi/bznF?=
 =?us-ascii?Q?NnFYnYV8QOWv4lyrN/iYuNsabcTKtQpvq2ymph/MPHW5BfmQsS+yKQFA9Oqs?=
 =?us-ascii?Q?UvPHcUwxFyK0xV50/WaNnuJo60cnjrc+4OJZOQalkhG53mqIy+kEXZaUGKiG?=
 =?us-ascii?Q?5YIJ0paN/MqYe1D4nRhV+92mZXL0GmX963lPhX7I13CaR1wONIcf+Xx9Zq4C?=
 =?us-ascii?Q?BaJAtMEGu1dCbCOihTIyN6mFDAq5wdESmfAIwjptJyphhQQ1IbrMoFXBo4ee?=
 =?us-ascii?Q?YO55iYNWEIsCpRDgq//sEZ9E2n/TRtb6hCRvDz7b0UdILjczL9iLF0uB18+o?=
 =?us-ascii?Q?x4tsRs4eW2vAtFBdN41ZpuJvhQl/Cn9Ax9yCNCxSWI7Rg6iGK6weS7/rqtyJ?=
 =?us-ascii?Q?+speyEmoPbkDDVdkgSzdEEQCjrFgDpton+bDt+uOF04ZyF+dRqrVmktIGX5z?=
 =?us-ascii?Q?pBt01iNCiqsDKCQvYzkBh/IGGiNmTo2P5g3VgoejXQsxXMjbj6yO5Wgtyi3W?=
 =?us-ascii?Q?5A07ucUzdgsupPVNO+nxjKBuKZIhbX9RA5+kUd5W6OeX6p05g7EqkdduHJLC?=
 =?us-ascii?Q?dk2lHDAXcGHcEu4kyCxdOQcCABmc3sCxMSN77pyvSY3/Xkyh8Zw2A+x/dG2e?=
 =?us-ascii?Q?Yl71Gj584C/zLD558QYahEnhDMQHGaWy7NJvySPKqiHf5TsN3t80mn+IE2WR?=
 =?us-ascii?Q?9mFcHwQRsie994anMcUHBtGTCg+2oXpJW3IkDB81WDNy4kXAWZKcq60L5pef?=
 =?us-ascii?Q?ibv2XITu8uCDhnLRMThg3oFvzHfhShlZqvzj8ik16iz+bxCtVcriYbri/uyX?=
 =?us-ascii?Q?VOUNHZkiw3oW8YD+yFEpxA+bkE3qoKY6U3PRso/udgZiEtI6WQi+Uin9HYxS?=
 =?us-ascii?Q?/pnYBkE70uiB95sIwzqqsbZ0I4r/ALDDIKGglj8xjo3B65oYS86PM/Gbz7UB?=
 =?us-ascii?Q?AtYbQmjp7ZIpSLmqtgDL4FnTL0TMmbkyvUMCXa0/u/caklb26k45i7NjQHR0?=
 =?us-ascii?Q?baIaqxA64ibfVG+b/kw2scsCoxscJ4oMvGp52LSaIFpYjkwU7QIHRvW/uuGC?=
 =?us-ascii?Q?lH7xw2gHcIaNY7GYIr2j9m2pMPPL1PUTsbamf6EhgRtIk6nrbB6kt7j77imp?=
 =?us-ascii?Q?Wvv/t1MtyoIHiNxM9xwrmcYAZcjvvjfCs9JpeBpk+q6zO6sJLsviciJbSAXW?=
 =?us-ascii?Q?OkvbQyPhCR2rSwx6AyPQn6GcS3Jp3eYpjt++dYKijQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgMCs8YJJae1iiFOj9h1BNZhbOWzEZun8caIpKGYCZkE4b3H4tuEx6PPU4Qe?=
 =?us-ascii?Q?Vi++uXe5dO3M1u2obluSdAMcY/RSVUovTth1Gv9rn8XWNiysPg058SiX74eX?=
 =?us-ascii?Q?er8iTypWUv550IgPlOWjxgsOUpo+e7vBjhex2xfqhkhlzDKHVTcGNaiL9h1w?=
 =?us-ascii?Q?Yqt9bNiqTeOIOsPtYhrm7nfQkJHTtamVT5diWrB0ytrztcRCDjXnMcGYlsXR?=
 =?us-ascii?Q?6SjBadD/cRbGisNmiqN9aYRbW6fOOHUsPW/MMpIoH2j61fbRJMx82eKK5n0Y?=
 =?us-ascii?Q?dkT3wZRDhrVSy9li3R5C7Q4R37WJi0zS7iHUALJjv6RNz0qCtOu85S24Wxml?=
 =?us-ascii?Q?Qw4E+En+PnNv1m0bDupjkoX0MDlHYPTNrdltm+1kgc3EG9c0eYmqgt5yt62E?=
 =?us-ascii?Q?zTIp3vMt009LoD+YKXCTTZUW4VuIq+B6wHR/+YkujQAgUVb7SawzJXnlkaYZ?=
 =?us-ascii?Q?Uw9LLPymXnLeCxCc+CUyXSI/dbLmjeiqu/p9vJleFipGbWy9EBYYnqov1aUc?=
 =?us-ascii?Q?F9WT/JWgFP2O/ns5vg2wjZ6sKcV0OWWoQor00rHbcy1ecaVzdiOc3pzfTeA/?=
 =?us-ascii?Q?8bgptf4zA6d43LhsuxOj0I9fqfqvxayLXm6DdJCj78qx+9Tt2OtJ/pikCwzg?=
 =?us-ascii?Q?CjYhARFc4BTDobh6qdtwLHWl9DRnCwga5aEN/PoMllRDXOhg7EsarCKbrplx?=
 =?us-ascii?Q?UluFntW+q6j3V/9zvy6RacjO1QV7eqk9HvhAvvtxvpuXPpJax9TinKPAmUNl?=
 =?us-ascii?Q?r2RL453CHEs5KdgcCNk3Drf51l8+XLc23Gxx5zGSmXvQKpLPidSWaZXWN/UA?=
 =?us-ascii?Q?bvW3RKbNq72YnUa5qsRNoZbWAfiRjjhCDE+tlXWTIfD3dRASU9d3+OVEw6rr?=
 =?us-ascii?Q?OHv/KYAhgKc1S2h7qzKt3gvKDk+Eaq6Upe/K2DpVGwiVFIHTfeqk0Y1dxZzk?=
 =?us-ascii?Q?PFl5k13XYv1fKbuSoRTERvvWX4UDFS+BkaRT1G7qtZP3n/KEXvXWg04F5Beq?=
 =?us-ascii?Q?E7Pd876g+pByOnHu1lRUKzNj/MIqUTAAObmYxREUHZqbRi5vrgLhKdDO80Xl?=
 =?us-ascii?Q?PVEuv6lR6EnR0Yl3ZmvNPJP/6CXj5laweScK+14WedGKI88V5P9EkdWR/NX2?=
 =?us-ascii?Q?2/0nQeqlMzTL3ZBQN+lJtkuT1c1390dWFnXTFH1TjWkdWpgvdtQWKWQiHpdY?=
 =?us-ascii?Q?TQwr3x0G8TCJpBj3ozJg4R/F9H5izcmnPlXiTN4xjigf8WUlBp3onq+HDrKd?=
 =?us-ascii?Q?+0VA3SA1IkZLfp+jEb/f2b3rhYw+87AyofgtYrN3bjNlbL9zcc71m8nE6tVo?=
 =?us-ascii?Q?sU/9C6YecD+NQ+DROpFiEEnlfjnKD7ZLiwHWrQVxOfGubwFxdkV3yK8wbSfR?=
 =?us-ascii?Q?K8PQigsiaX+yQ7LwRPqjgdYWFLtDVf28s7vIFhCOWvZDaTzMNhFsinbaE9Ii?=
 =?us-ascii?Q?RxZs5tSaQjHC/elOwnNKpdTevsLdyVejXc7Rl80/P4iGxHHXlFgsiLLs0B8S?=
 =?us-ascii?Q?ptJLEJcjbpdBMbuH/x+TG7aWUdYs0KtoJNZiMwf4xfsdh8bR95fXHraXz9d+?=
 =?us-ascii?Q?2P5qbgQap35Wul7omg1HYDvjvgQCEkSD+H8B7DWiMEbS87y6QOVzZVE2r6jy?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01046b81-83da-4d51-c3c4-08dc7658bcf7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 10:04:28.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXOf0/B6gfpjDL/nGMzy0HR4O7dIIDqRy121nZRvodYEB3iqf9uimtDyBXazhmOLPkX4VE0ZNVSn9wrLTOnDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694

On Thu, May 16, 2024 at 08:48:55AM +0200, Horatiu Vultur wrote:
> > Alternatively, the -EOPNOTSUPP check could be moved before programming
> > the traps in the first place.
> 
> Thanks for the review.
> Actually I don't think this alternative will work. In case of PHY
> timestamping, we would still like to add those rules regardless if
> ptp is enabled on lan966x.
> 
> > 
> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> -- 
> /Horatiu

I don't understand why this would not have worked?

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index b12d3b8a64fd..1439a36e8394 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 	    cfg->source != HWTSTAMP_SOURCE_PHYLIB)
 		return -EOPNOTSUPP;
 
+	if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
+		return -EOPNOTSUPP;
+
 	err = lan966x_ptp_setup_traps(port, cfg);
 	if (err)
 		return err;
 
 	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
-		if (!port->lan966x->ptp)
-			return -EOPNOTSUPP;
-
 		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
 		if (err) {
 			lan966x_ptp_del_traps(port);

