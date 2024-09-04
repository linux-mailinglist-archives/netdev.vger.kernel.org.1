Return-Path: <netdev+bounces-125193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26496C36A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2067B2393E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DB1D2226;
	Wed,  4 Sep 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bCsVuDLn"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96204286A8;
	Wed,  4 Sep 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465847; cv=fail; b=MJubn0IWv1dm+WPa13gyKM/Ytpn91S+nPUnMYDdyg47Iq+/P8roZR7Zr+QzBrX82FhBskK0UtM1FZ/pWrHV4n99GFVl4FZbCQaviSbd9KzmycjV6h8zvk6H9Qp3GthZYVIBwzU5bR7lzBINjW1367QGbycD3s/Hqj0RVtMjzHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465847; c=relaxed/simple;
	bh=a5bkJrMZ1wv4MdJPgzMJadSrmD01z9qjrdwbgRIEv3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBp962AiHZHZsgrxtbhZ9A8CmsZieS7fU41g3VpKSZOfG438aYQ0TFS5v4bpstUF+de4dRB6xHo/2Nf09XcyaBsu99ERTmlrdIUiDOGMaSC8qcZJqbK6oIbIsZtSBPsJX8hk+J2Sf9Xn4iQsBMA29KWsV2r13C5NG5uI3T6bnqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bCsVuDLn; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWqqBuRGviGXP0wVHD7tVOTqrcPruZzEH6OduFIFSRUaUhBlSmz8EDdUEMaL8Mln78pN56w3tOTp5xiD4kKR+Hk9HHVBMbrToG/I45LDP+03Qb4+QBxHj5hIi8Rplh2Kb9dlsQ9tZfkOshrJXzzjdaZmaheFFSOXuP9W2K04Sqy2TJvKTluQ93dONwbwTElscpvfYgjjWnVuxwonhFV0t6twizY2eNp8YL3shzr3nTwnQZEwdbFpE3DF+Wz6RQRTWA3I2V73yOtq06JCN2r3uO1CBceYADqttzoemYL+mQXHNFFhQOdpvWp5SmIDcg9vEpolwImZkGikX5ltZIVFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSRh/Uwlf4AFNrOW5ZJb13ykZCsWFV1S2aN6izz2kBc=;
 b=adjOCrdTWbdHQStzjJ1VHlebiu8gt7W4cpCJSX9VrFDGd3ZZbQM3Qjr/rfnQwmtWqAMzWXY0jSp4wDBlGMWALMgEtPo67XHhwQAULX/VnMddpJewmsYr3e5ct6Kouin/zB1zrvUk4ckb/d+c5NX5yKb/IsXssN66fZEpa6bHlMLLCp03wjVxaQBNZyvFOa66wZS59L+7Mwz44WrvGBcJdXCQ9ioeC8kz8UKBMdyUm8DJdLnJPpXNUjGzw69VN8bK3mtmXeZBAhFiGd10HNRsy2yNHgi4aJMi0862GzduvoDE0aE6I/ud0qLJl0tt+hRfVV2TtsVORrFSC6tY048epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSRh/Uwlf4AFNrOW5ZJb13ykZCsWFV1S2aN6izz2kBc=;
 b=bCsVuDLnu7DKwlzcsIq9fa8R8T2chuSDzxX8Q4rzVaY4rf49wrQY6HIZjv6NAsjMkAfZ3u79RJ5NT5yQz2jr/kpn9zVj99YDS6VqRqRO81ulmUNG3ofranksDrD86oYGrBPvyeWspi/36wn0l48DgHjNIhrK1KI5sdy7WYN/EqJHq3yx7e2g5QuuU+hzjcYHH+WE+0JUZztrHe6HM4UzPwHoC+e2IXkNPiBtcSCBcs/pv1kFS+FWsRnZ4dJCnIkP4UMHVy0Hak5C6LZTWXh0Ha/93QdqMsQMI9oH3gbwNN+YZfJ8LOf6Q/moIOg+gDRLj5cLcy9b+xcUGlWyK3P2ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:04:01 +0000
Received: from PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::b7b0:9ee7:cd10:5ab8]) by PAXPR04MB8877.eurprd04.prod.outlook.com
 ([fe80::b7b0:9ee7:cd10:5ab8%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:04:01 +0000
Date: Wed, 4 Sep 2024 19:03:57 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wan Junjie <junjie.wan@inceptio.ai>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <kywc7aqhfrk6rdgop73koeoi5hnufgjabluoa5lv4znla3o32p@uwl6vmnigbfk>
References: <20240902015051.11159-1-junjie.wan@inceptio.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902015051.11159-1-junjie.wan@inceptio.ai>
X-ClientProxiedBy: AS4PR09CA0024.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::12) To PAXPR04MB8877.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8877:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 08bf679a-5d34-450b-425b-08dcccfb30ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzMmrTueHbD8KDFVfLfWRdFSwiqyMrQHp9w05AF7lJx4PGiqHm5fvCPNKvxe?=
 =?us-ascii?Q?EQOcM2EsH0ctV8Gk3eVHs1mPuZ4de2XZAhYpickF3IFOVI1LR8jpuf4NgEUZ?=
 =?us-ascii?Q?RlVC3xB/nNT7XSEaoaMOybdiKYrSE7dPo1xa1sHcyPfYGaQ/4ZaUYXx7SMU5?=
 =?us-ascii?Q?jPLbbIFh0CEaugHDQuxKVGRLz5txjhrLTGbpMc2mhsmEG32XdOWhrwZU4ACV?=
 =?us-ascii?Q?FUOADKNurB70s+Mzh3dH2S3I9G9UmsQEUHc3s48prwRmDsdrTv0VSaGuqPuB?=
 =?us-ascii?Q?UTgAhCj8ySqZdC/dDRdKRHP2OcMYMe0NKLNlmu0/tfjSHGT6JNxdaFY0CCaG?=
 =?us-ascii?Q?DW2GXoSMHqPP6SmJVrIMqQEJLTb4m3xEUzx2YVh1w9La2+KoYDYvOqyAZ7Nk?=
 =?us-ascii?Q?jwAIoZr0+5bRBElttlLLwoaJlkF7KSWePUo7yKxwAXd/SGJ94VpRgBGSCLLh?=
 =?us-ascii?Q?kFIjeU+597eZsUklUhU1M/2lers8T7gP18qXa7gmAwmpo2lh9lzk40Gu86s5?=
 =?us-ascii?Q?9+UxwOnYp4XO2nVQ+R9b/PkeU5Guw8HersMlbSU9UvW9oyoiUSsiarTbo+9p?=
 =?us-ascii?Q?Z7+dPcf74STRJUxv8ZNxeYYBiaFHsX2uoL1ltcnmB5ZRTjsQR9i/P+XB3A+z?=
 =?us-ascii?Q?T1d51AYU8bhX1RpZzZARI+DAKZCiiffndvrEFxjx/DtHD1GD2X3cr6adkLB+?=
 =?us-ascii?Q?l4YkHbjAGjii15T3/0LHOWPSfIGpUHcYMLT0YltCFFCmwhRwx2UKXYiQAzJD?=
 =?us-ascii?Q?dZEyyFDeYuMnXObtJpkeN5qXMd2tSIYMU0Eov/5O0flGJKzjVCgqyz16PONv?=
 =?us-ascii?Q?Lt2yh15wmNbLvAu+ZLwUdXvDl+V9n9FM6k6b0GQUjqW1SVsVhXl5cMvvOIG4?=
 =?us-ascii?Q?8ZHWdcbUSW5AFFcH+a5OWDxrJkmegynfDO8+eKSbiEKxzvRbtHYlcajQm57h?=
 =?us-ascii?Q?DQwop4JdiOrqB3NAY77lelfTDo6lEgmzHY8KTEVnwtNgnWoDFJD1C/D4dKXA?=
 =?us-ascii?Q?uj9jq+EDVw/FoUGowOL5O2dCDdRZP1dlD6CpcKaRv4ydIoRNtPQh4YD7QQwh?=
 =?us-ascii?Q?rtH1p3VjXWMk6/6IZvdBuj7oivvYbW8ytpHmUWSYN8oSjPsuTgtTwMvT5zYk?=
 =?us-ascii?Q?IdXVveP8IWcZeSaBOJoewUWVrOrB/urbHPYpu45oebUCnXWo2wX8UfUmxg2j?=
 =?us-ascii?Q?q2AEYEDoBDUk3GktfqVzg7O8Z5iDc0g0UrhKHQWPITOc6QuS9udVUao0GiS7?=
 =?us-ascii?Q?iSIDRDYQlQF36uvixFLLeimgLt84a83bCaxDIuAMMUDU5afN5AAT5xplVtSo?=
 =?us-ascii?Q?9QUkAMeshLY7ZawDurHeBOyh1wVlDeePGm2cVbfbiSTNJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8877.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Zl1ncy2rS69iUsUTcSXwCcrzVGwFdO3BNztP/v/HEP2ciFQkYG37ssidK3m?=
 =?us-ascii?Q?Py7PlVQlNLTLucxBEzYKopGlIFO/vVPTxWVHqPpIlUHTKZRefPUeMlH3UwlJ?=
 =?us-ascii?Q?Ez8rUt0sCILfw3s/bEBCD3Rd9mcO9UG/71hQTkQU0dtIUMfWGQEGXapI1ZnS?=
 =?us-ascii?Q?yqiAZjyI/Oc6Qwhsxf1MOBoyuCqJv5Nr3+jwsL2aU9+6fRIMDHNUiiPK5YF8?=
 =?us-ascii?Q?o9KYdnpluPvrNXk8uVV39e8LuqjS2y8c33+d5biDT/nxew3xp2vEFwYfp3NP?=
 =?us-ascii?Q?M8tME0HTa1Na2X9yHHXk9OJ5sn56SOZ806Ebgpt0bePxv4B1h5VE/FYPKATZ?=
 =?us-ascii?Q?/hRHhuaiG0ouU5AhaNLhor96Fo9n/+p8pcr+Zpsph7OCFFJzUEsqrXylY52K?=
 =?us-ascii?Q?XyQevWnLIuEOQVv5IIVVEBVSjdIyrAsrf5A34tS0NEga0ao6eF1Ijb8nY3U9?=
 =?us-ascii?Q?ZIWQtnc3pm/yoZ6xhCSKXj0TiVCKXQWq6dPYLN8RR090zJttYQRoa/fMCKug?=
 =?us-ascii?Q?Tn97RVFVx7HzhOoEPvO6l1kgofedJDPTCeL5NJBwBwesMhg1X9BMw2U7ijCM?=
 =?us-ascii?Q?/f80mZ0layIxPIXSE3X6UwkCw87dnhgD5sFNzIAJKAJtNZ+W1oFlq5emWVoY?=
 =?us-ascii?Q?h8AiM3LdvGo9ILpQjh5GTntIBeMezCUK7zj+CgjC44qD0YtW5OFmWngS2Eb6?=
 =?us-ascii?Q?W4po6kHe4pq6N8gVBlB8vAxbY136vTcFVnt0j/mDqSOPn0i3mD0NPlhWdVZ8?=
 =?us-ascii?Q?lvpNID8zhKg1P/PkF3F0X0n9oZE/QLCv9mvJFUDsyLU7e16qLboznYxPYrb/?=
 =?us-ascii?Q?DjEXB0aeCCvfpo7yWBZ6nMuXk9ivAzpehHhpPoowEWbRpzeygOZ+sk3K+myh?=
 =?us-ascii?Q?+ZzZcEbQnvCzt+vGNUyYkbrSQxttQenVXJvv3h5/wDpG0ObeSyw0SU603/GO?=
 =?us-ascii?Q?UWdYq743yaF64OPYl223SBNh/zszFBtHU/jhrEv+NLF3BY1gLd/CWlyW4KDQ?=
 =?us-ascii?Q?MwKx9TuQOglzA/GF9zWhLEg0roV4QWeA2TR0A1Jc9Jkpd8dSvAzln29lMOZp?=
 =?us-ascii?Q?X2NFtWBfVDc2xFyruDPejzVJ8Qm2Mp0nh7P5krTph6SHovrUmRDX8205KPud?=
 =?us-ascii?Q?a6gNUSswqjHuVF8EEPH8P5B8Kol85imIf1HmUU48ZUoUlswjTJpMc3D9aO4h?=
 =?us-ascii?Q?vx7A6PdivdKXCi5JEEKwvk6aRBK3zWs56rnBeAXE7YhhkAXvb1osUHRaKufl?=
 =?us-ascii?Q?iUc0lXikoryr8znVfZa1Mnl/q5TEdTLJ4WeNx/WmbM8r9gnaJJfK33lb6hIF?=
 =?us-ascii?Q?/lEP0f+FjkUo0JJIvLXsLpfSTvvIXHB5HOrlAh6OPDzqDiaAblIZqAUcHAMm?=
 =?us-ascii?Q?dH23F+Ts1p0UkUyzA7Ue5/vcg6cFP0ebM7aIc6JQ7+///FIpI4MK1eFvQEpC?=
 =?us-ascii?Q?mjSY+owV2soi/UbSs/hXY5frhbfaPUwx5EjnckHW//IoPIw3JBLShEy6T23E?=
 =?us-ascii?Q?/U14lqtpuZHbOiCjqo4OdD3bHeMy6+C1QNappm8XsP5wzeHOsEdl2ngeeB5S?=
 =?us-ascii?Q?AwJfNjDlVXOzUHXy74us5A9sWIVLB4kULqwNNGqP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bf679a-5d34-450b-425b-08dcccfb30ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8877.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:04:01.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajdApX2bKQOnRTJ4XLOB2t4/vvGTe43y6BUWBZtK7pnT8uny553/UYbBtwxvTpA0FiUqveaY4fJbLrZ1kaQIsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972

On Mon, Sep 02, 2024 at 09:50:51AM +0800, Wan Junjie wrote:
> Currently, dpaa2 switch only cares dst mac and egress interface
> in FDB. And all ports with different vlans share the same FDB.
> 

Indeed, the DPAA2 switch driver was written in such a way that learning
is shared between VLANs. The concern at that time was the limited amount
of resources which are allocated at DPSW creation time and which need to
be managed by the driver in the best way possible.

That being said, I would suggest actually changing the title of the
commit to something like "dpaa2-switch: add support for per-VLAN
learning" so that it's clear that the driver did not support this prior.

> This will make things messed up when one device connected to
> dpaa2 switch via two interfaces. Ports get two different vlans
> assigned. These two ports will race for a same dst mac entry
> since multiple vlans share one FDB.
> 
> FDB below may not show up at the same time.
> 02:00:77:88:99:aa dev swp0 self
> 02:00:77:88:99:aa dev swp1 self
> But in fact, for rules on the bridge, they should be:
> 02:00:77:88:99:aa dev swp0 vlan 10 master br0
> 02:00:77:88:99:aa dev swp1 vlan 20 master br0
> 
> This patch address this by borrowing unused form ports' FDB
> when ports join bridge. And append offload flag to hardware
> offloaded rules so we can tell them from those on bridges.

Borrowing from the unused FDBs is fine as long as no switch port wants
to leave the bridge. In case all available FDBs are used for the
per-VLAN FDBs, any port that wants to leave the bridge will silently
fail to reserve a private FDB for itself and will just continue to use
the bridge's one.

This will break behavior which previously worked and it's not something
that we want.

The following commands demonstrate this unwanted behavior:

	$ ls-addsw --flooding-cfg=DPSW_FLOODING_PER_FDB --broadcast-cfg=DPSW_BROADCAST_PER_FDB dpni.2 dpni.3 dpmac.3 dpmac.4
	Created ETHSW object dpsw.0 with the following 4 ports: eth2,eth3,eth4,eth5

	$ ip link add br0 type bridge vlan_filtering 1
	$ ip link set dev eth2 master br0
	[  496.653013] fsl_dpaa2_switch dpsw.0 eth2: Joining a bridge, got FDB #1
	$ ip link set dev eth3 master br0
	[  544.891083] fsl_dpaa2_switch dpsw.0 eth3: Joining a bridge, got FDB #1
	$ ip link set dev eth4 master br0
	[  547.807707] fsl_dpaa2_switch dpsw.0 eth4: Joining a bridge, got FDB #1
	$ ip link set dev eth5 master br0
	[  556.491085] fsl_dpaa2_switch dpsw.0 eth5: Joining a bridge, got FDB #1

	$ bridge vlan add vid 10 dev eth2
	[  667.742585] br0: Using FDB#2 for VLAN 10
	$ bridge vlan add vid 15 dev eth2
	[  672.296365] br0: Using FDB#3 for VLAN 15
	$ bridge vlan add vid 30 dev eth3
	[  679.156295] br0: Using FDB#4 for VLAN 30
	$ bridge vlan add vid 35 dev eth3
	[  682.220775] fsl_dpaa2_switch dpsw.0 eth3: dpsw_fdb_add err -6
	RTNETLINK answers: No such device or address

	# At this point, there are no more unused FDBs that could be
	# used for VLAN 35 so the last command fails.

	# We now try to instruct eth5 to leave the bridge. As we can see
	# below, the driver will continue to use the bridge's FDB for
	# PVID instead of finding and using a private FDB.
	$ ip link set dev eth5 nomaster
	[  841.427875] fsl_dpaa2_switch dpsw.0 eth5: Leaving a bridge, continue to use FDB #1 since we assume we are the last port to become standalone


The debug prints were added on top of your patch and the diff is below:

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 217c68bb0faa..8d922a70e154 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -81,12 +81,17 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 
                if (!fdb) {
                        port_priv->fdb->bridge_dev = NULL;
+
+                       netdev_err(port_priv->netdev, "Leaving a bridge, continue to use FDB #%d since we assume we are the last port to become standalone\n",
+                                  port_priv->fdb->fdb_id);
                        return 0;
                }
 
                port_priv->fdb = fdb;
                port_priv->fdb->in_use = true;
                port_priv->fdb->bridge_dev = NULL;
+
+               netdev_err(port_priv->netdev, "Leaving a bridge, got FDB #%d\n", port_priv->fdb->fdb_id);
                return 0;
        }
 
@@ -127,6 +132,8 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
        /* Keep track of the new upper bridge device */
        port_priv->fdb->bridge_dev = bridge_dev;
 
+       netdev_err(port_priv->netdev, "Joining a bridge, got FDB #%d\n", port_priv->fdb->fdb_id);
+
        return 0;
 }
 
@@ -240,6 +247,8 @@ static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
                fdb->in_use = true;
                fdb->bridge_dev = NULL;
                vcfg.fdb_id = fdb->fdb_id;
+
+               netdev_err(port_priv->fdb->bridge_dev, "Using FDB#%d for VLAN %d\n", fdb->fdb_id, vid);
        } else {
                /* Standalone, port's private fdb shared */
                vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
@@ -444,8 +453,10 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
        /* mark fdb as unsued for this vlan */
        for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
                fdb = ethsw->fdbs;
-               if (fdb[i].vid == vid)
+               if (fdb[i].vid == vid) {
                        fdb[i].in_use = false;
+                       dev_err(ethsw->dev, "VLAN %d was removed, FDB #%d no longer in use\n", vid, fdb[i].fdb_id);
+               }
        }
 
        for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
@@ -475,6 +486,8 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
        if (err)
                netdev_err(port_priv->netdev,
                           "dpsw_fdb_add_unicast err %d\n", err);
+
+       netdev_err(port_priv->netdev, "Added unicast address in FDB #%d\n", fdb_id);
        return err;
 }


What I would suggest as a possible way to avoid the issue above is to
set aside at probe time the FDBs which are required for the usecase in
which all the ports are standalone. If there are more FDBs than the
number of switch ports, then independent VLAN learning is possible, if
not the driver should just go ahead and revert to shared VLAN learning.
In case VLAN learning is shared, the driver could print a warning and
let the user know why is that and what could be done.

> 
> Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
> ---
> v2: fix coding style issues
> ---
>  .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 216 +++++++++++++-----
>  .../ethernet/freescale/dpaa2/dpaa2-switch.h   |   3 +-
>  2 files changed, 167 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index a293b08f36d4..217c68bb0faa 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -25,8 +25,17 @@
>  
>  #define DEFAULT_VLAN_ID			1
>  
> -static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv)
> +static u16 dpaa2_switch_port_get_fdb_id(struct ethsw_port_priv *port_priv, u16 vid)
>  {
> +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	int i;
> +
> +	if (port_priv->fdb->bridge_dev) {
> +		for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
> +			if (ethsw->fdbs[i].vid == vid)
> +				return ethsw->fdbs[i].fdb_id;
> +	}
> +	/* Default vlan, use port's fdb id directly */
>  	return port_priv->fdb->fdb_id;
>  }
>  
> @@ -34,7 +43,7 @@ static struct dpaa2_switch_fdb *dpaa2_switch_fdb_get_unused(struct ethsw_core *e
>  {
>  	int i;
>  
> -	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++)
>  		if (!ethsw->fdbs[i].in_use)
>  			return &ethsw->fdbs[i];
>  	return NULL;
> @@ -125,17 +134,29 @@ static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
>  					   enum dpsw_flood_type type,
>  					   struct dpsw_egress_flood_cfg *cfg)
>  {
> -	int i = 0, j;
> +	u16 vid = 4096;
> +	int i, j;
>  
>  	memset(cfg, 0, sizeof(*cfg));
>  
> +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> +		if (ethsw->fdbs[i].fdb_id == fdb_id) {
> +			vid = ethsw->fdbs[i].vid;
> +			break;
> +		}
> +	}
> +
> +	i = 0;
>  	/* Add all the DPAA2 switch ports found in the same bridging domain to
>  	 * the egress flooding domain
>  	 */
>  	for (j = 0; j < ethsw->sw_attr.num_ifs; j++) {
>  		if (!ethsw->ports[j])
>  			continue;
> -		if (ethsw->ports[j]->fdb->fdb_id != fdb_id)
> +
> +		if (vid == 4096 && ethsw->ports[j]->fdb->fdb_id != fdb_id)
> +			continue;
> +		if (vid < 4096 && !(ethsw->ports[j]->vlans[vid] & ETHSW_VLAN_MEMBER))
>  			continue;
>  
>  		if (type == DPSW_BROADCAST && ethsw->ports[j]->bcast_flood)
> @@ -191,10 +212,38 @@ static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
>  static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
>  {
>  	struct ethsw_core *ethsw = port_priv->ethsw_data;
> +	struct net_device *netdev = port_priv->netdev;
> +	struct dpsw_fdb_cfg fdb_cfg = {0};
>  	struct dpsw_vlan_cfg vcfg = {0};
> +	struct dpaa2_switch_fdb *fdb;
> +	u16 fdb_id;
>  	int err;
>  
> -	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	/* If ports are under a bridge, then
> +	 * every VLAN domain should use a different fdb.
> +	 * If ports are standalone, and
> +	 * vid is 1 this should reuse the allocated port fdb.
> +	 */
> +	if (port_priv->fdb->bridge_dev) {
> +		fdb = dpaa2_switch_fdb_get_unused(ethsw);
> +		if (!fdb) {
> +			/* if not available, create a new fdb */
> +			err = dpsw_fdb_add(ethsw->mc_io, 0, ethsw->dpsw_handle,
> +					   &fdb_id, &fdb_cfg);
> +			if (err) {
> +				netdev_err(netdev, "dpsw_fdb_add err %d\n", err);
> +				return err;
> +			}
> +			fdb->fdb_id = fdb_id;

			This leads to a NULL pointer dereference.
			Variable 'fdb' is NULL in this case and you are
			trying to assign its fdb_id field.

			What I would suggest is to actually create all
			the possible FDBs at probe time, initialize them
			as unused and then just grab them when needed.
			When there are no more unused FDBs, no more
			VLANs can be created and an error is returned
			directly.
> +		}
> +		fdb->vid = vid;
> +		fdb->in_use = true;
> +		fdb->bridge_dev = NULL;
> +		vcfg.fdb_id = fdb->fdb_id;
> +	} else {
> +		/* Standalone, port's private fdb shared */
> +		vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
> +	}
>  	err = dpsw_vlan_add(ethsw->mc_io, 0,
>  			    ethsw->dpsw_handle, vid, &vcfg);
>  	if (err) {
> @@ -298,7 +347,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
>  	 */
>  	vcfg.num_ifs = 1;
>  	vcfg.if_id[0] = port_priv->idx;
> -	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
>  	vcfg.options |= DPSW_VLAN_ADD_IF_OPT_FDB_ID;
>  	err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle, vid, &vcfg);
>  	if (err) {
> @@ -326,7 +375,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
>  			return err;
>  	}
>  
> -	return 0;
> +	return dpaa2_switch_fdb_set_egress_flood(ethsw, vcfg.fdb_id);
>  }
>  
>  static enum dpsw_stp_state br_stp_state_to_dpsw(u8 state)
> @@ -379,6 +428,7 @@ static int dpaa2_switch_port_set_stp_state(struct ethsw_port_priv *port_priv, u8
>  static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
>  {
>  	struct ethsw_port_priv *ppriv_local = NULL;
> +	struct dpaa2_switch_fdb *fdb = NULL;
>  	int i, err;
>  
>  	if (!ethsw->vlans[vid])
> @@ -391,6 +441,13 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
>  	}
>  	ethsw->vlans[vid] = 0;
>  
> +	/* mark fdb as unsued for this vlan */

	s/unsued/unused/

> +	for (i = 0; i < ethsw->sw_attr.max_fdbs; i++) {
> +		fdb = ethsw->fdbs;
> +		if (fdb[i].vid == vid)
> +			fdb[i].in_use = false;
> +	}
> +
>  	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
>  		ppriv_local = ethsw->ports[i];
>  		if (ppriv_local)
> @@ -401,7 +458,7 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
>  }
>  
>  static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
> -					const unsigned char *addr)
> +					const unsigned char *addr, u16 vid)
>  {
>  	struct dpsw_fdb_unicast_cfg entry = {0};
>  	u16 fdb_id;
> @@ -411,7 +468,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
>  	entry.type = DPSW_FDB_ENTRY_STATIC;
>  	ether_addr_copy(entry.mac_addr, addr);
>  
> -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
>  	err = dpsw_fdb_add_unicast(port_priv->ethsw_data->mc_io, 0,
>  				   port_priv->ethsw_data->dpsw_handle,
>  				   fdb_id, &entry);
> @@ -422,7 +479,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
>  }
>  
>  static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
> -					const unsigned char *addr)
> +					const unsigned char *addr, u16 vid)
>  {
>  	struct dpsw_fdb_unicast_cfg entry = {0};
>  	u16 fdb_id;
> @@ -432,10 +489,11 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
>  	entry.type = DPSW_FDB_ENTRY_STATIC;
>  	ether_addr_copy(entry.mac_addr, addr);
>  
> -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
>  	err = dpsw_fdb_remove_unicast(port_priv->ethsw_data->mc_io, 0,
>  				      port_priv->ethsw_data->dpsw_handle,
>  				      fdb_id, &entry);
> +
>  	/* Silently discard error for calling multiple times the del command */
>  	if (err && err != -ENXIO)
>  		netdev_err(port_priv->netdev,
> @@ -444,7 +502,7 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
>  }
>  
>  static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
> -					const unsigned char *addr)
> +					const unsigned char *addr, u16 vid)
>  {
>  	struct dpsw_fdb_multicast_cfg entry = {0};
>  	u16 fdb_id;
> @@ -455,7 +513,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
>  	entry.num_ifs = 1;
>  	entry.if_id[0] = port_priv->idx;
>  
> -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
>  	err = dpsw_fdb_add_multicast(port_priv->ethsw_data->mc_io, 0,
>  				     port_priv->ethsw_data->dpsw_handle,
>  				     fdb_id, &entry);
> @@ -467,7 +525,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
>  }
>  
>  static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
> -					const unsigned char *addr)
> +					const unsigned char *addr, u16 vid)
>  {
>  	struct dpsw_fdb_multicast_cfg entry = {0};
>  	u16 fdb_id;
> @@ -478,7 +536,7 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
>  	entry.num_ifs = 1;
>  	entry.if_id[0] = port_priv->idx;
>  
> -	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
> +	fdb_id = dpaa2_switch_port_get_fdb_id(port_priv, vid);
>  	err = dpsw_fdb_remove_multicast(port_priv->ethsw_data->mc_io, 0,
>  					port_priv->ethsw_data->dpsw_handle,
>  					fdb_id, &entry);
> @@ -778,11 +836,12 @@ struct ethsw_dump_ctx {
>  };
>  
>  static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
> -				    struct ethsw_dump_ctx *dump)
> +				    struct ethsw_dump_ctx *dump, u16 vid)
>  {
>  	int is_dynamic = entry->type & DPSW_FDB_ENTRY_DINAMIC;
>  	u32 portid = NETLINK_CB(dump->cb->skb).portid;
>  	u32 seq = dump->cb->nlh->nlmsg_seq;
> +	struct ethsw_port_priv *port_priv;
>  	struct nlmsghdr *nlh;
>  	struct ndmsg *ndm;
>  
> @@ -798,7 +857,7 @@ static int dpaa2_switch_fdb_dump_nl(struct fdb_dump_entry *entry,
>  	ndm->ndm_family  = AF_BRIDGE;
>  	ndm->ndm_pad1    = 0;
>  	ndm->ndm_pad2    = 0;
> -	ndm->ndm_flags   = NTF_SELF;
> +	ndm->ndm_flags   = NTF_SELF | NTF_OFFLOADED;

Maybe the changes around the FDB dump could be in a different patch?

Ioana

