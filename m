Return-Path: <netdev+bounces-54053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC7805CE3
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02B01F2169B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F74249EA;
	Tue,  5 Dec 2023 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TynuL9nJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5EB2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 10:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d58b1/Xrzv8kvOIjgmw1BB6LrsW9G4rBU8f0jeF9BDh4QewHgskLJWXh8k4dp9ybYa7o7Nap53MOIM5JwPtLg2AsH3+enY2Mr+kJsI726w5vZxcuJ8LwEcbXBcI6wivJgSvmGZ8GEsxNgsE726RVFW6+R9ZwdMl2q983paBIFcRaPiXXEIgbRawhKW4aNgjCSEfyeCA1RSLVbq1vZTmb0GYR2bI7qWbt5LVtj99oI35rX92YnxcAjxBhja6KgEfH68g22wvtBQi/1gQJxV1zFqDukEtkR5myqr+ZG6Lf0g3JxUBIbhYT3SEOVW3uikGHn8yDuIM+Wt5BYpC+IMpmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9RcKgAR+S8Jw2kwvnn8TMcZMnmPlWtpRM7vexMW7xQ=;
 b=Z0aEZAa4qFc4hEaZ3m3Qcheg6zGPYnuJ3xhBH93z1AlcC/O2Jw1B+iqyy3nelNhqxDaTBxvPeJhPRvRj44DwT20phDbVVFcHi4qlgLSufouuUOP7rwnNsdyBMMuvUWjsYKxXFqDoeVmjIFJGxZrXAJlPjSs0p5FrfiyPgcQpCk/UvT3sqmz77DXbmBOOaezpLNp5vIjdxxnvlbR/a6D+zZE7z1+u5/duyABYSy0sgML2Y8txXVADsD7IGqmPrSbBhlFcx+p1tzet1/ZbIdFB7rEu+XoTZl7PsK+OrItDY0wnyPDj+BgRwSMVppMPDSQjEeFq7GxJrmCr1wc64r77Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9RcKgAR+S8Jw2kwvnn8TMcZMnmPlWtpRM7vexMW7xQ=;
 b=TynuL9nJrRGg2XT2EufzkOJpnNrHYEvMv86lEj2ecb6f1al6h3fIhTcY+cGQ68vKz7kdxp+03NguelaNlswoZCKfWY3g30UR/1j6/LHdRmg1m8jYWBXDIsJdp0Xkg2eh0fxfN6n9yZuYfME8W5OfRX3Zisp8ZJvFec9uNuooaS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 18:07:44 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 18:07:44 +0000
Date: Tue, 5 Dec 2023 20:07:40 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 5/6] net: dsa: mv88e6xxx: Add "eth-mac"
 counter group support
Message-ID: <20231205180740.aenvbx6vxbx3d6o4@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-6-tobias@waldekranz.com>
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce9e4de-21cf-489f-3c92-08dbf5bd1454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rh6vLprXE9aca9LoCMuGmyMAD3XVxhbUUig9JaZ+fuST6TyKq67iryrGjUUIGHyG6pabnbeYDFT8tQo/7AI1eNuuW6M81Iy7PZ0f7X5sW9mdx8WdXxUw6gOtw7xYri41r6mpEdOen6f+GBiKyWpgqG1x9QBUckr8JB2ExKS/6R1jG2a2xlaqLLOXrWO79LVKKUyLSckSkv4SzRV8dE3tQkPw3pQE00cyqfctZpPyZ2ESBDqh9HHDYCofl97AEmRJ+W4z/j7UIF1JHOabvPGq33QTk+JY+NEaUZztTDLvlfTkasSuenQw6AGpUKgQcNSm20Foz36buMX9Cc6pkhmCVNikVi0Bi7+NqPbM21azIzcKTOr4DUzq3ObSV5nSa0ysKi/BoqfPhzhJmpo0V5ewkgjdCuAcfSbY6SRiH2ySzblIOIBFbtAGTMm95qGEOM2D3iKeOV2C0bOgvfnYgaWe04rhU17C5ib77Nm43Uo6DoG8RQxb/PpKmekXMgsCKiGzQrk3m8dtwL1YevG4hvUdrAqcfhNI23qjHZE4L+c1PjLHN3hSCYS7lcTEaDJGuyNO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(478600001)(6486002)(6666004)(83380400001)(6506007)(8936002)(4326008)(6916009)(66476007)(66556008)(316002)(8676002)(6512007)(1076003)(26005)(9686003)(66946007)(38100700002)(44832011)(86362001)(5660300002)(2906002)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfjeZmKCnZG983qYU49H+vyOI9dLdOO/sZIKeE4XJppD+ufd5EXoSnMTzVTd?=
 =?us-ascii?Q?HvnOSeT+sAAgOeroxvIIzkz1PAeKFoUm4maLb3T4tGzzkZLTxouDybICA5Vu?=
 =?us-ascii?Q?IjgulaAYePcJQ4vhdLoK9dcrW00aqlZ16YhrJ95x68D44TRtZKzgjGLV5axg?=
 =?us-ascii?Q?2oYLLJDDxL58OwwtvfFdg/e71DtRnDWw51+/6wdooZq8162oXHFDbK+IDixm?=
 =?us-ascii?Q?AFdVIZeBc1mdsJ+TPT6f5m59IhQI7kYoVv03F4GikHysv5CsDZHVkaZ5POxr?=
 =?us-ascii?Q?cMVnSpaamjtMqDZZ8qynSZwMK+JNmYUobFdu3lMIAuAVezN14uQiUfPPWLDG?=
 =?us-ascii?Q?55fs1QUdzTwAvzT0IwkwnOwiK9oYflZQHEQ5oAno9xZC1j/y8VAjD33XyDob?=
 =?us-ascii?Q?spaBxcD88ikvBETv58tteeMAnpXC/k9AKEHleGg7S1toFvcWtxRkPolLPsqQ?=
 =?us-ascii?Q?GUGbJgMwqh7OTTjwzhqDlo7Vzlb8kVEJg8Xl30agMNIQxo+W4zevGJBUNPqy?=
 =?us-ascii?Q?/qsQAvY3IYYs/WaMlvhAYDHPCFldi4iuUyqbTOw2RrbgLfpc0eeHH3iE5/+W?=
 =?us-ascii?Q?+xtKz4sC9rwW+CMJ+97LOyuENm9PofgYDhoFF44saxZUwRuQYp7QXQ1DyzFG?=
 =?us-ascii?Q?b+uFcrS+WcNu+1tV+iOmKur5pG8qdUen9ojyZtelcsbKxf7nqFd4H+xj7hkq?=
 =?us-ascii?Q?5+ij2lZfRFLRQtrMr/FAoy4ISckN3IAWZ4PBva+US9dBLkqUE2VpcY7uHgm3?=
 =?us-ascii?Q?utAlLGpyA04PHoCSvZK3TJYItipMCpOPOuua/ixQmGItjh54jaAQqUozLLBo?=
 =?us-ascii?Q?A4OJTdZRSzK4X4mOg3JGHsW013fZcIcfQGDo5qYk44q0XH2Ii6OGeBFZEt9v?=
 =?us-ascii?Q?wGSOvHuv1zR0mZui0daWG2ryjO6NHXy4fVPbnnAj8pO37x13bEMsIrSrZiLJ?=
 =?us-ascii?Q?1LbiXMi9lTuvKFUK7DLxSyUCSTAK06MgIeL8yfS7tTgWUl8SA0d5bindxNk2?=
 =?us-ascii?Q?35pMgrCAMjEpo6BAUG7c9w8uoCNhoizJ34RXSPMU/WO6M59+60K3Fdj2L2JL?=
 =?us-ascii?Q?Ccrozd/lIW6Dxs/WIyqxuT9OoAdrp5UszA+s0GMEAf++P/mmuoaQMApWSubl?=
 =?us-ascii?Q?PobboSrsBk2xdZJbXLLI13M13oxupvPiWOgR3p0Vfzc0vM53YnNeKpWCGkZs?=
 =?us-ascii?Q?o8267WULdzrV8gRUqqVve7jMB0msa02Wm27YeLBwzMppJAJN7ys4QtuXtxq3?=
 =?us-ascii?Q?8CKe8+Pgpm737A6wSeytO7BmUdVvTks+5uqY70OMUZuL/P3unjxPou+RhF76?=
 =?us-ascii?Q?BeYbOMPSrlIJkCRQHAZloY9rPDeCytwikViUyYMbNG5SROBGGY3aKxOPj1EP?=
 =?us-ascii?Q?gIGdsmvr6uTQ3W1U5Ic1esT4830qOCf4vWh1WVijTcjoAEbgMpRG+S7RDI0I?=
 =?us-ascii?Q?MQ9+Mri9EfIVvuNP7OFPnCuKn32PbzKXgnbvAcPynn70qvehJr59ylaXlkdN?=
 =?us-ascii?Q?2eU7HyE+2uFZul/XiqSVlTZC2L2OWVVPpLNqFp/CrQIh1eq/d1Le6m0hlKQ4?=
 =?us-ascii?Q?LmHoDmN7RpoVMCBrSHopJSZ6ZDK7s3zcqfUU/EC0y7ufslfAbsig4HbXMILi?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce9e4de-21cf-489f-3c92-08dbf5bd1454
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:07:44.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tib0tV788BcMTiUh0KKV+AbP+j+FTBlprr0yxIR6ZHxDcSbCkCyKxaiJrdx2ei+Q6gIHiGkeWbWyC9eebJG5eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

On Tue, Dec 05, 2023 at 05:04:17PM +0100, Tobias Waldekranz wrote:
> Report the applicable subset of an mv88e6xxx port's counters using
> ethtool's standardized "eth-mac" counter group.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 473f31761b26..1a16698181fb 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -1319,6 +1319,44 @@ static void mv88e6xxx_get_ethtool_stats(struct dsa_switch *ds, int port,
>  	mv88e6xxx_get_stats(chip, port, data);
>  }
>  
> +static void mv88e6xxx_get_eth_mac_stats(struct dsa_switch *ds, int port,
> +					struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	int ret;
> +
> +	ret = mv88e6xxx_stats_snapshot(chip, port);
> +	if (ret < 0)
> +		return;
> +
> +#define MV88E6XXX_ETH_MAC_STAT_MAP(_id, _member)			\
> +	mv88e6xxx_stats_get_stat(chip, port,				\
> +				 &mv88e6xxx_hw_stats[MV88E6XXX_HW_STAT_ID_ ## _id], \
> +				 &mac_stats->stats._member)
> +
> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_unicast, FramesTransmittedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(single, SingleCollisionFrames);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(multiple, MultipleCollisionFrames);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_unicast, FramesReceivedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_fcs_error, FrameCheckSequenceErrors);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_octets, OctetsTransmittedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(deferred, FramesWithDeferredXmissions);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(late, LateCollisions);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_good_octets, OctetsReceivedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_multicasts, MulticastFramesXmittedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(out_broadcasts, BroadcastFramesXmittedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(excessive, FramesWithExcessiveDeferral);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_multicasts, MulticastFramesReceivedOK);
> +	MV88E6XXX_ETH_MAC_STAT_MAP(in_broadcasts, BroadcastFramesReceivedOK);
> +
> +#undef MV88E6XXX_ETH_MAC_STAT_MAP

I don't exactly enjoy this use (and placement) of the C preprocessor macro
when spelling out code would have worked just fine, but to each his own.
At least it is consistent in that we can jump to the other occurrences
of the statistics counter.

> +
> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.MulticastFramesXmittedOK;
> +	mac_stats->stats.FramesTransmittedOK += mac_stats->stats.BroadcastFramesXmittedOK;
> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.MulticastFramesReceivedOK;
> +	mac_stats->stats.FramesReceivedOK += mac_stats->stats.BroadcastFramesReceivedOK;
> +}

Not sure if there's a "best thing to do" in case a previous mv88e6xxx_stats_get_stat()
call fails. In net/ethtool/stats.c we have ethtool_stats_sum(), and that's the
core saying that U64_MAX means one of the sum terms was not reported by
the driver, and it makes that transparent by simply returning the other.

Here, "not reported by the driver" is due to a bus I/O error, and using
ethtool_stats_sum() as-is would hide that error away completely, and
report only the other sum term. Sounds like a failure that would be too
silent. Whereas your proposal would just report a wildly incorrect
number - but at high data rates (for offloaded traffic, too), maybe that
wouldn't be exactly trivial to notice, either.

Maybe we need a variant of ethtool_stats_sum() that requires both terms,
otherwise returns ETHTOOL_STAT_NOT_SET?

Anyway, this is not a blocker for the current patch set, which is a bit
too large to resend for trivial matters.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

