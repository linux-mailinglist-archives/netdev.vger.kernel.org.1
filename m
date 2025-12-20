Return-Path: <netdev+bounces-245600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FABCD34B2
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5C1300ACE1
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12B2E62C8;
	Sat, 20 Dec 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kztqCzQ5"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FE30F55B;
	Sat, 20 Dec 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766253473; cv=fail; b=HAEnQzVZG3f1aozJWnyyMQgRNnDmIf5DjnkDkrOEYEVbdhCFTINk50Of3u42NxnGiPeHWvQxCazPbshIpkb7tPr4CFWPbuZ3N1F5zxUgwKsYVpolwtG6DQ1K4YI2eRgnppRg/wNB/+DWdvoZZACeToPglsj8eA/uv+JXtBTboXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766253473; c=relaxed/simple;
	bh=IhxnEeMG6s8OwmYtXAUSsXjX/wyuCesjPRIFO70c7PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fb6J48oGfV5zydf1QWo/SZWsfDyBl50hjbO2DcKH5tUHTlbbalwnK5EJXmu8Enbkt/zwsOwxKn/boMCUoWP5kwpnPBM/X7Hy5i4iyVGHGc8J5x9/RtKalH47DCRSAzHY14FU906SluEOb6A6wLpxoqja+8Ed+Ox1ej1mh8HGJkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kztqCzQ5; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0AsuQAvlyX/sNeBQrEr7pYremKB7k/7+WRsEijuH2QLb1Yp9BCh37tdT59M183clTULmuqgcWTVKhgPSBzEL8b1yhhvMTOcGXz5D9CAlkGaI4uzmDpOcdYr6NWD3asacRy8iRN7+j548+uZvH+gWfNorh24ihBR1Y0t9qTf9lutYX3HsHMK8ykLRwIQRzFc0SMA2pGxWPLoOBO49cKcATOPFe7Ciete9oXB/dIgE0Hl4l+jFfwkNHeGiUdL45PWtUtPKFXRewqp9Un9Hjg/hHv0t7CD+kTaEHpltBVOrsXTQIZI3nukGS7jMcZ2wXweQwF+qnnK3nqSXsp0fsIQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOZJs9cyyXoLweIm3h+RPmMlOA7ru3kEC2v5rcQ+njo=;
 b=aUWjIUBCXHDZwrgjDZCNuxTPM7ddCb1q/f9DeulRwpyKkhNDFCQ1bqGHxYvPgKVoCPLxtdIZ0vv0zbNDq6N0XaMuJAdnLOIwHiBOc2abIcVNH/byDBJ3G2K91baBAJe+T/I5kRKN1TZzCuchpu+yv0LcQBfJfhs5kaJYk93L5Sep9/RyfwmJsNtiK3Kik/mspWAwkjCxPXsZT3kmDMFH4kByrHZeEiqxusuUZfJQELY19hcuEX7ywXGqlO17W6MBl5DQqsc7Ao8wvLvR/aSe3XBT0OTKgTMtZHlnFbOWPezEt2QkHCRmtlGGNLld1MZbGn9R/v7fnQu8KTxU3MgniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOZJs9cyyXoLweIm3h+RPmMlOA7ru3kEC2v5rcQ+njo=;
 b=kztqCzQ5ber6UCqTAkxNwbgSMk5WV5BPMvN10FwF+fkqWn+Gqa4ikHN3BGEsM6sRP3mW4kP+0UM51awElO+8XhUYBluHtuPmKHGAGtblZQhNGAV8JPugZ0Fdm137dUQjFiwm7wadQlP2/EC/fGjeGxxRILYvcZ6vGoh9mPMf1GPn7JTMaPa0vxq5/KtqFzXjxOMU4JS2gVPISXbCOrmYYIpDetiB5e/1ATviiOFu57/f2/heTcXpPzHrkdm/bHps+wrSxNC3ryQ608P4vId5/XHbjOPjU0KzWi9Bm0MoVjVRFnXXnmeVXEZqd8kaYhh7bwGTtbk6m04tIum6Hm8TlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB8481.eurprd04.prod.outlook.com (2603:10a6:20b:349::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Sat, 20 Dec
 2025 17:57:46 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9434.009; Sat, 20 Dec 2025
 17:57:46 +0000
Date: Sat, 20 Dec 2025 19:57:43 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] Prevent crash when adding interface under a lag
Message-ID: <20251220175743.z2dzeod4hviw57b6@skbuf>
References: <tencent_9E2B81D645D04DFE191C86F128212F842B05@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9E2B81D645D04DFE191C86F128212F842B05@qq.com>
X-ClientProxiedBy: VI1PR0902CA0029.eurprd09.prod.outlook.com
 (2603:10a6:802:1::18) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: f16cef25-f051-48cd-bc67-08de3ff14819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzD+Q6DWPAUvZZSYyLexhL9WQCm94j+1ibQuT5UgNKWyHrAKiiH1wkRInebE?=
 =?us-ascii?Q?EC/vYPL/4lSwqgy1fhuxXTTDbbNY+EA5h1HT6yOr2bFigCYF2yBLKwqFFW3O?=
 =?us-ascii?Q?U0Cn1NdGkJ/cC8Cg+PXVT5Gf0KIXpoyosI28PnhP8L9mxDgmbdYkgnWWVcIX?=
 =?us-ascii?Q?X99NiwC2WXDRsUBxIzy7SXXTz1PcUN7Ds7iZpebntrTaLDwMVPAhE+Jm72U0?=
 =?us-ascii?Q?ai7fBt7GIS04DwD3bGqmrfXSif14ZcQfzJbfCCH1BUtS+QOVYsiL3rUxhgYE?=
 =?us-ascii?Q?iOhKBYA2+BtoCY9fvv2XLJshb2E/jfWItEn+MOfBLQZyTx4Qm3S/37NOcixt?=
 =?us-ascii?Q?4ywcXT5sJJGM4ItJI4MYgwR0+xI3H7BaR19zxF9FvpOFALaPiibdiglS8Ufm?=
 =?us-ascii?Q?cRJeVYyZFUKziO54dxFb4CYeGN7yyC+F/lutb4lWTAZU+2WgDCI1Uso52mJQ?=
 =?us-ascii?Q?NNDR3oyMtO7ChSJDfTROg+UQLHT4EWhThwQz93W/DQmAEaGd/0YbQHT9MCR5?=
 =?us-ascii?Q?X14fpOKb5rIGeVhpuZG3Wose3WMsV9bZSzFr1qka8ROR311w9XaYYqrL9Dg+?=
 =?us-ascii?Q?GuPDNxNtr1gBkkADHaroqS1JAt4fzrXID0HKqAVxvygfFkLgEV8xbZW4ZguQ?=
 =?us-ascii?Q?TS4f8uPdD+IFsSojAt/XYrSmmOz3AUhyvoJ6wJT34TXMuCrA1KV3ReJxnhDB?=
 =?us-ascii?Q?LXFqfLRQFipuwSZdwC9ik8czl6zws2zb5AZeLvIbTW8+JdVRXJRN0mxwgZkS?=
 =?us-ascii?Q?hi3P8TSEOt9LN8qzMVicid6uY8oygrpfbD+MZHh1+2UyJojsCcYvvUNpbQ+B?=
 =?us-ascii?Q?fvc1DEE0B2pq9lZ+TvMYVlA2o+rpqkEcJBCEasiMrJKWAic0fX23alTgjRnx?=
 =?us-ascii?Q?Pt0ovN1/MxA+3C3I0G3YSil8PCdwtT5zdqFdvcDrvPZ+dRkUpLAk0VXvKvAW?=
 =?us-ascii?Q?KZc3CibWnPSe/DgpcvOXy95xZS+VU6CrhhYKZpYeacirt7fqDNO0zDbwDBQb?=
 =?us-ascii?Q?ylJMcB8kKzCJkvqZk6MvFHRjqABTZg7g3eZXgJ9AA0iNEmBWptnnxQ8oalSu?=
 =?us-ascii?Q?/afe3XaK6Pwbcq9XHFbSNUpUcpvQjpDdMgs2SR2pdjP3MvdCchIVLe32+59c?=
 =?us-ascii?Q?PMuScWMdztcYR7d98/lhdt65MfoJHHupcPsys/jfOY51M7GmxE2GgDS05Tc9?=
 =?us-ascii?Q?pqobXUr/zokHPhJ9gpX3XG6NmnkNJ5paQSvYBRp80vlNp5efElH8msvcm7pk?=
 =?us-ascii?Q?WQR7iGRk+vI1gyJu19CkBP89Q76I3qp4fRrfixV7GzVOGl+HbX0dQYHmpxaG?=
 =?us-ascii?Q?P2e0QG5r5iTJPkkXM+xSzeDCOLSh+TL2Kv49xVJA+T5F1JMgGGsBP9q0cAfU?=
 =?us-ascii?Q?hCpaMjznw0oKEQnMjxdAT4AZxLEFJoGfKOWnmf3m3g6cJEdJ6xBAwC1AzQir?=
 =?us-ascii?Q?o0UAmIZ00x+rtdLuiFSC2yM80Bl6LJap?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8hV1ZYyEyNoA/OlLEdC27XwpDzhhEkF45lJ+LyYNpqRvsuBaAex5+oWVbsPo?=
 =?us-ascii?Q?VYFV1lDYtE41L8daF2EyXWjdhG+OrNSbwzk7SNcG4xFwQO3DbRq+nsyT3mgt?=
 =?us-ascii?Q?ryWsUmz1+p4cc68aUk/19EPIrOQbnCRVcJckPwEfXiaAD7Bl9svZXYtUnpR7?=
 =?us-ascii?Q?e2DFz/rTH7CiEIa71H+1FBsupvK5h6hlyIj6RYB/YPdNh9DUUh8G6qwOp5ma?=
 =?us-ascii?Q?z5+T4I7xuxxY0uj+QoWM2HjrpM7A87TuQDaYUZ+FVAckF1CFgJhTbev0yqIH?=
 =?us-ascii?Q?Sy8XS1SbkpUyzoCvRiW/Y2855MZ44I5fAEAJwWwYnYdRVvo2QDdo+qI4u0hj?=
 =?us-ascii?Q?Qw5bCyBwT17pT+tlyQQQELg+7gvXHcMhfdrG+JosagCoT4hbcfYhSB+lC/sw?=
 =?us-ascii?Q?q202hT/n0qweUs/+mznSwh1/WQKUwQKj6Hk/MHqxQ5114sNrzdlkk1YFbR1p?=
 =?us-ascii?Q?1J/5aZL49iJw2q1LOozur420jWXtOUy83e0hJQwp1H3Utq86AT1x+7L31PdR?=
 =?us-ascii?Q?vb911c+HQm8Pyc1x6Z8lrK5aRAe/kE5YDKR/bw1ykO0lVcHsjVlOMUuX5jJe?=
 =?us-ascii?Q?ORcoI+0uPHc7Xf4rAvLB9R20bP3JY2wva3y102yvTd7LJrCPFk1X4vwdNfXg?=
 =?us-ascii?Q?Z+tunWHUNUzzc38DBmw0b0BCsxTAy1WQBL6p6IJU/CulfKQjZF+VRWnmbKSC?=
 =?us-ascii?Q?d5EI1IpNCbaqtEykn4ZrycoqbpQrhiIsLk3Ft7+hZSZwGROdZqFL9uUJIxFf?=
 =?us-ascii?Q?IBscfdfjFi6BZQOumGFo7FmLXlnIoKiC+8ZQa95wJzrJubgwNuko/Xz2wbxp?=
 =?us-ascii?Q?6hsZT8RsDUPc3QyN/H1QiAz/poPuuSshVvRDPTfEg3aOrJMYSFSzgri+ofFL?=
 =?us-ascii?Q?xdNzuYmv097DvZrzC3+WUzilSHB1oD3bkBVhMTB1qM4m6bxwlYvxtOnDsGVX?=
 =?us-ascii?Q?LxSeqs7x5RvXL9wKIAvhZrtz7KQdOyB+b8lsSxu7JHtwK72JBy+sRny+JFxB?=
 =?us-ascii?Q?dHyDet0x68qzSVt58V//0R7ZlB+/qh9oeXba1b2rT9ADNWuuiDpE4Aev9W0g?=
 =?us-ascii?Q?flzOUR/o77WMq+jECh29+YrBShkBrtYn/w4rxfSAqpHMLhqp+VxvtFl/9wx0?=
 =?us-ascii?Q?6hEKkGq50EWOORIqEpzo/FIQGZ698BmryW86v8LCQPst01P3gnzf4T6/50O9?=
 =?us-ascii?Q?cC5otEKpPW3nmVoB19YGr4d8ojoeZuz06QzBXXTBbZbblwEB3VsQaF853t4Y?=
 =?us-ascii?Q?LL5a7BEz21A1GYTZNQyahGycj3/HhDo2qKz1DrKeu/vL3Of/CNwDX7vCw1k0?=
 =?us-ascii?Q?BLb0ItKTKBtlWvwPkFwbaqHvOcXnTMp//bXya9RIgKkeuTynj6P4vtojp/IL?=
 =?us-ascii?Q?/my84W4CYviFqccDhgm34XWVNCExGt+/UopHPJMOCwIYR1bMRgXN7zQHJhOH?=
 =?us-ascii?Q?LSuNrw26mP3foE28pBEBFRWrUfN3+KU8rCrt9dm6zNIAi2prH3uCm9Uslzgj?=
 =?us-ascii?Q?70aVpQrCUngT/CWFgVUo/wypC2qJImuiSsma9Ohnfmlkr4FJDjnxaJcGVerZ?=
 =?us-ascii?Q?aM0sguN7+bVucXKwr5eLeobtKAdeH1W8Mw9RRuOIW0QT/yWBC1gk4IPtK5Y5?=
 =?us-ascii?Q?6GDvIroT8XK6hhJMeOS/N52a5dazXSv5Di9PYFvFEWwN5RUkz2Ubh57/KCpv?=
 =?us-ascii?Q?M+1V46LILlQUSPMR+MrGqKEp7/jid7sj/kNPjbO4DliZgyK7S6hdzQfdHHlz?=
 =?us-ascii?Q?SRJ3B/qC+u3Y+CUoVE3xmJ8vxF3MnfYc76edMtGvL4u/8N6h2IVaZV+KsAag?=
X-MS-Exchange-AntiSpam-MessageData-1: Um3OZlX0BfWNFHwIHuBGmDpOzSKna4OtoH4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16cef25-f051-48cd-bc67-08de3ff14819
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2025 17:57:46.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1afcjWWRst9OFSOGvFYk/vzSZZLbFGnTsBYOE8+BWSuKDP4b3L3Yle5FUtVMMVCU+MPjs3LZydMFDxiJkKHOBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8481

Hello,

On Sat, Dec 20, 2025 at 05:32:15PM +0000, Jerry Wu wrote:
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> had fixed CVE-2024-26723 which is caused by NULL pointer dereference.
> ocelot_set_aggr_pgids in drivers/net/ethernet/mscc/ocelot.c contains a similar logic.
> This patch fix it in the same way as the aforementioned patch did.
> 
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---

Please follow the Documentation/process/maintainer-netdev.rst process
and send the patch to the net tree and use ./scripts/get_maintainer.pl
to form a more comprehensive CC list, which at the very least contains
netdev@vger.kernel.org.

We need a Fixes: tag; I believe the correct one should be:
Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
Looking at that commit, we can clearly see that when iterating the first
time to form the "visited" mask, we do skip the unprobed ports properly:

		if (!ocelot_port || !ocelot_port->bond)
			continue;

but then there is another iteration over the ports right next to it, and
we failed to check this condition again.

I would add a small mention that the Ocelot library has two front-ends,
which treat unused ports differently.

The drivers/net/dsa/ocelot/felix_vsc9959.c frontend uses the DSA
framework, which registers ports for all switch ports, with the special
DSA_PORT_TYPE_UNUSED value. I tested the patch on this frontend, so the
bug doesn't exist there.

Then there is the drivers/net/ethernet/mscc/ocelot_vsc7514.c frontend,
which indeed leaves unused ports as NULL pointers. The problem only
exists there.

>  drivers/net/ethernet/mscc/ocelot.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 08bee56aea35..cb1c19c38c2c 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -2307,19 +2307,24 @@ static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
> 
>         /* Now, set PGIDs for each active LAG */
>         for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
> -               struct net_device *bond = ocelot->ports[lag]->bond;
> +               struct ocelot_port *port = ocelot->ports[lag];

Please name the variable ocelot_port, that is the convention in this driver.
If you name it "port", you are shadowing the "int port" definition from
the beginning of the function.

>                 int num_active_ports = 0;
> +               struct net_device *bond;
>                 unsigned long bond_mask;
>                 u8 aggr_idx[16];
> 
> -               if (!bond || (visited & BIT(lag)))
> +               if (!port || !port->bond || (visited & BIT(lag)))
>                         continue;
> 
> +               bond = port->bond;
>                 bond_mask = ocelot_get_bond_mask(ocelot, bond);

I think you can remove the "bond" local variable and replace this with
ocelot_port->bond directly. This makes the check rather similar with the
one from the previous

> 
>                 for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
>                         struct ocelot_port *ocelot_port = ocelot->ports[port];
> 
> +                       if (!port)
> +                               continue;
> +

This hunk is
(a) unnecessary. The bond_mask is formed by ocelot_get_bond_mask(), and
    this doesn't set ports which don't exist in the mask. So there is no
    reason to add this check.
(b) incorrect. You are testing that the "int port" is zero, not that the
    "ocelot_port" pointer is NULL (the real intention, but unnecessary,
    see a).

>                         // Destination mask
>                         ocelot_write_rix(ocelot, bond_mask,
>                                          ANA_PGID_PGID, port);
> --
> 2.51.0
>

