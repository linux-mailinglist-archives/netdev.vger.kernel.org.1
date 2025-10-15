Return-Path: <netdev+bounces-229549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E46BDDF0B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38B254E711E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABD2EB879;
	Wed, 15 Oct 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ml04TbB3"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9411A5BA2;
	Wed, 15 Oct 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523514; cv=fail; b=Hg/eu86gYtQdUSUg+lrJVhmBU7budjRcPHQJkjg+t/6+dln39+gAcW6ZozY+EO2gM+S4WXsvPsvcm1gNf98Ocgo404/hNjZN2ZklrkpkuFuaodu4BpUkTxPouVcqFekqSkEmgstRwpvY0ZElfMFGzvk410M3gKylBohMhUahSsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523514; c=relaxed/simple;
	bh=7FkwiS5TPy/vvCFtZtU8tdCM7kpbRrGV7b9W2BulhpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVclyYgk7O4rssnvgDzQGFBxVufLc+Q+7wcvlOam1rOkIAMCJO1DT8SeKrFyUUFvpjz2uO2T6sri+atGnGWBcm6yOspi3KTrcypt15tyuDCjSmgJ0SssIY+SN80/tpFEXCnjev3+kOx+OfZSrFvohrJi/RKvM8uS6QEgv0g3250=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ml04TbB3; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYCwc/js5KoRKDb1cbYyoWHcOkI0COxOlBPbXgkqE9tSsVm4VkugCzZAQ2am7N9DMjeUuSS9zNahA4oSmuXe0OYj9CRUuC/qdLXLFKoA0ZzxnqfW8GgngcWL2SvU3xI1Np580YphiczSeBu6e+2fRilxfYtetUt8z+D4y/t+62fKrYlK18IL1KTslB8or2LNUeCmFVfZ0/z3Fga1MUt8nqqJe8EezH9a38PotbEds1CCvMDGpphillSaMp57dodDSpBB3Jr1s/gTARJrT86ZHRfUDkEL3FlNAZ340QYLMDvnr5bANlKE/L/PIwFOZYDg6NEvwIw32BeWxWbu/LHcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzuD7Qijw5ovRh+dMhLB2zNP8NE4QliEc2Ksf/guP2I=;
 b=RZCvUaYB0YzWZ5Bkdw6w74kY6F3S8CuW4PzyJi0zqAhURU7FYGjMHo/kK9RdV848g7DdHZ8f1LeZt3pQqcAPeQabE6tHPciFzv+Xa8j/WCPxhdAOxmWfYpBqJ9elRopj+HQH0Y0L2efEZcqx92YjXNZ/qsqmnbUYyQuYl+OivC9gf3JLTp6cbQUzAMxQewmdDruiYLFGUTQB2zhTC0DeNKVIo2pdmw3q5aRg4TgjeIxQmnUUAl9zcb2Gfit8pOaxXOjw40TWkFk4LKbUg4WMXs+7EWdbIaIjPc6hJtx6rCDSqlVyT8wRy4o4HeiTHHB3iqOOMiBjqZDV0FdVgs3sQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzuD7Qijw5ovRh+dMhLB2zNP8NE4QliEc2Ksf/guP2I=;
 b=Ml04TbB3cMTLKv7sQ3SIvyyeFeM8NBxRCO2Nj6psH+BJD/tWeoZWUxpMoBOqU2TBxWjr+ys8dEIvYz3x3R7Fz6SWrchR456prAAQglw6WYVEDT/Y/LFQbogNVjZDeqZVhaPftTkmM+bN44akQG8YpxgiOqhVrK3MioQmQoXhUPNvDFCmEpuWCg4qBiE/xxCxkQEcR9dFwt4iPKtjcmrZ/RgQGIw5uUFS9y+2eJ0Vs1AtFk2v1M61ElV6D2IeOuyCs3xi0+n1Ub7XgAeUTmpfxNp/wiRTsGrhOPZwvFfJKEKqeJQVLy+BOEZw+RBDUSA7yW+GxnKEtzeI86b4BR5l0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 10:18:27 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 10:18:25 +0000
Date: Wed, 15 Oct 2025 13:18:23 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa2-eth: treat skb with exact headroom as
 scatter/gather frames
Message-ID: <xl3227oc7kfa6swgaxoew7g2jzgy2ksgnpqo4qvz2nzbuludnh@ti6h25vfp4ft>
References: <20251015-fix-dpaa2-vhost-net-v1-1-26ea2d33e5c3@traverse.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-fix-dpaa2-vhost-net-v1-1-26ea2d33e5c3@traverse.com.au>
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|GV2PR04MB11328:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bfaae6-df15-4142-546b-08de0bd42d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rX0X9STNO6ULQMyt5SDaeyaIlfOm1fabMIpJ2AugSuyIyanpihj4FMT+l2NQ?=
 =?us-ascii?Q?bMTRTptTr1nIZ9XdPDAjL8V46M3WLv+ehsNG37/WiLzyMv+9bKHkOcpP5tbs?=
 =?us-ascii?Q?NTDs1qfe/yffHWFb9QpcScHxnI6OXfnLG//HZY6Yigz9dW7zL7MyjZvNYzwe?=
 =?us-ascii?Q?RYQ3yL9RpfGZCvi5nwq79T8QpkaEDGNS7W3uX0nzboF7EbKu2GfOWw/3SH1O?=
 =?us-ascii?Q?Gz7/4YmBXtXmxwnOXU0X383KGaBPVr9RdXG3UAU/etFwHPGFEHigaKAKyEmH?=
 =?us-ascii?Q?brJB/Br8rJhIowaeJEf+NccDN4gf/qpGRDQ+/o71OLFESPFw6rzpvYcqj3ig?=
 =?us-ascii?Q?ntjojf0M58kwR5Nrmu2wIkp6MeIJaNeIzQnljBS/29x71d3SuFTTZKLTAaBi?=
 =?us-ascii?Q?jRXEa8jngHNzPmmht4An8BXCvYgU/JrwA4ye6OVLhN3YwcrlE6S9YoGDbkF+?=
 =?us-ascii?Q?E39u1SMXjGEBU4tHHuqW+2xHv/WdsP1vFWFW2PoKZEFKnZ6BIZWs3PCVmFyZ?=
 =?us-ascii?Q?haP3f13PqfXMwHv0VIJEGoRXrXbsm/Fak2PMmnKNuatmkCvVO15GLJHgXDhp?=
 =?us-ascii?Q?omP/5N/Ppq+J6mCJxooMp0NDWmN9WHOGDDLNGfATYmGIPiczSAfnY07xON1I?=
 =?us-ascii?Q?lYrpfo3gtCblAw/YbxnyTox0L1GBwB8+UVWPwgN+4nmsG/s4MaPpNubQBsQS?=
 =?us-ascii?Q?4DIFtOT9/qy00SfKdEif5uRhAnQxVFLqESrd44ZCDCY36vLZ8j1+ZiBi31CW?=
 =?us-ascii?Q?b4bGw1ZAPtka0w1QSSCE1njWH9DxEllFyUQ9X0TtuOyroVc4L7P5PhYh5xzY?=
 =?us-ascii?Q?+rdXm1Eykeke1b6gAJa8qxcjCIARJxifDmTzmwiRhyLe+p9fAPa31l1k9SbL?=
 =?us-ascii?Q?hQV5rB+24FeqlUG2R5GXKNG0UF9yPtfJHU/XNJVxDkMjlPm1BgHoQdMFzeI1?=
 =?us-ascii?Q?OPbmflkdC2mfJXN/IXHK4T8/1e043K6Yxbt+kFdAtTi4MtrgXD3jWx4HFIvT?=
 =?us-ascii?Q?LRbRe9phF+ua6LOm7Ib2vbUSLtCAYi6B1ZJ6VIyHFFn+bTWADt3xwZxkuRIO?=
 =?us-ascii?Q?UmCxak1bVOE9fwBafdxmztRRUyXp2FcWLpBQtLHCl7BBNoKygE1sqLTZHgg0?=
 =?us-ascii?Q?zsKu1oD64P12t7Daimp9ooLm31Keul96RzSk5sNlEQbzHqmpnIDW8KTGXBLT?=
 =?us-ascii?Q?JMtI22Aqi7hdm2URzjX5od7P9mYQAG/R8rNd5fFQWWEl/4QqkqbbDu1qCUR+?=
 =?us-ascii?Q?R3DR+hIDcHIlP5o2dvykX4dNthL4qqa1cT8M9rdV5p5jyY+Ndr1VcRzGuvp3?=
 =?us-ascii?Q?VjnQ7hFv2cm16ReqnEyYwivyYcVENZVDssXgRoRSUOd32ajwRGqBy8tAINFK?=
 =?us-ascii?Q?dYOdwj40m4EXAp7j5UehPo3W3P3SRRF9QVxznlPSHmdZLcEU/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3l/mt693SO5YLcMo//Sn42iaV4KcZu7smrhW1YcbxR7Qekau1+xCg4m8e/Ms?=
 =?us-ascii?Q?d2/LFrvL9q9u02agTWj06D5V68drGmFxzrgFhIafobxQYS5warEeUhUypzyl?=
 =?us-ascii?Q?42xU7HYROPvcCD7ILCq5NQsDZjMP9ruGM+gs9VwIMXgsrPwjsiWFogAiMSAH?=
 =?us-ascii?Q?D7OOamdAzdKhvFF/qEks2NaJmZ0oXjAh/zK+r9zIQQDTaq9kAGtHfUNrK0D4?=
 =?us-ascii?Q?bWHEwR9WWR+M4df4JiVCa9S0c5pmngR8DM1y1q+Ci66MM+d462taHwVAwftn?=
 =?us-ascii?Q?oFGTBwaFFb8jazNBT6//TUgWsJfdMxyFu6hZUPLHddc0MzDoRIpncE10qxFN?=
 =?us-ascii?Q?jvykq10swkTkHaIU2qDWLyxDkI/QxO9VkA/VAHXeyNC/ZssWGGjimDTHAF3w?=
 =?us-ascii?Q?c1Wk6AatZz1Jed8zv1IbXZxg+KAfRQ+2qDd3puCOeKgaVLvZQg1LDnnEPhYa?=
 =?us-ascii?Q?0QGo2fEPQh4Jn5nUlvssT3GZFuUvX88BTBNJY1Nu+nikZ5Btjh5tBfrbkpoY?=
 =?us-ascii?Q?CUiJbDDzZjixqy1nXwfWWuNelPeI7D9I5JjQVpKRSV9PTl7JKQnBEwTXuNjk?=
 =?us-ascii?Q?Dnnbo3OGpV+XtlJqRQvJhujdQ2xILGjTLmQlIpY0NJNUqk8Whs0oNqmpn99P?=
 =?us-ascii?Q?GV50x1I/9yyz29KK4+S+urGERgdmANcNEVuw7HdOB9nr8E1gui7O8eBxweXx?=
 =?us-ascii?Q?dr0cSMMeSUDZzsDcTn6lWcgnEaBaQP74BdMYXEBK+ti7FU7ZsDvWFe5yYWLT?=
 =?us-ascii?Q?MzfJa4BaBfwQ6y3uDTKqfLJjuaHYKXtPCPGXXMWDNWsCdNzerrCqQj7rXIAH?=
 =?us-ascii?Q?exSfSyP8owuPiCQBCZrE0dVxTm/VyQSjhn4P7WSJGHlqFBQ1eePqiYsfFL84?=
 =?us-ascii?Q?9w1Ad4y5IkP0+Yqwc87dMu24vNNQYZZhPShWnw0MXGQ2UzoVcr9e3gwnmk3v?=
 =?us-ascii?Q?ZULmvE/DogPYZaRq3YWhhoHHHKQW+C+ZZTbFqm4xXqDlIDU8hLJ8JqQpHD2J?=
 =?us-ascii?Q?qVn3ct/23UP1S7zqL7/4zPYtUTtkj+qBMk2qAPW2K3mbtOQVy0cUC6H25+0N?=
 =?us-ascii?Q?BE66dp0lvBRy8oGiyqz7+vRHb/OsVX9oZK80fCdaxoKlQwlTMFcS+UdtBoBe?=
 =?us-ascii?Q?8+hMPnR4Zpl4ne2Ud7Z9rBUpD9j6GxG6Fh+pdyDRhzLp8iNgcO0BamawDX80?=
 =?us-ascii?Q?pqIJ/CFPbzBwcdc/HuvvsHmzRPD52QRQ/y5xC7S2Ept481x1mCVkHMAmS3l0?=
 =?us-ascii?Q?OuWzIYunae/oI1h6cwBXwoUwMmkuNsP5UTIedkFTA3uUsp06CzbhTWqSe8iK?=
 =?us-ascii?Q?6URSKP8qm1cqLn1EhFZEUa74UbV0JEK5WOVY9kQQx8g/Xjjwngg5k8UiOa8V?=
 =?us-ascii?Q?7ftxqxBET3ear9t9F7svUR88ZQ07iINY0pzgP1eXsYydkfaSXSKrXzk1HC2D?=
 =?us-ascii?Q?9XpvFVVZ8fNUz4aiHW6AOYWYjxFvG8Zj6dBKzvDM2sxI+yw1zh4wInMMpDfO?=
 =?us-ascii?Q?zUAuJdyo1CPclUj99RvocOi7qNRWlxyH7eeoNf5cLCkQgMUYr7DT320h/6RT?=
 =?us-ascii?Q?3+GdyI7irQHlFVM3Zts0l9fd2WZ0/nOucz/HAQeo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bfaae6-df15-4142-546b-08de0bd42d64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:18:25.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdYrxOeaC/kPCcozksqfVAWhv3eQ6E+e1Jbfdz9mFZcyQcpYbETXKfEMVdj3NvHYOcVACYVKgXGJrDMEUaH9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328

On Wed, Oct 15, 2025 at 03:01:24PM +1100, Mathew McBride wrote:
> In commit f422abe3f23d ("dpaa2-eth: increase the needed headroom to
> account for alignment"), the required skb headroom of dpaa2-eth was
> increased to exactly 128 bytes. The headroom increase was to ensure
> frames on the Tx path were always aligned to 64 bytes.
> 
> This caused a regression when vhost-net was used to accelerate virtual
> machine frames between a KVM guest and a dpaa2-eth interface over a bridge.
> While the skb passed to the driver had the required headroom (128 bytes),
> the skb->head pointer did not match the alignment expected by the driver
> (aligned_start => skb->head in dpaa2_eth_build_single_fd).
> 
> Treating outbound skb's where skb_headroom() == net_dev->needed_headroom
> the same as skb's with inadequate headroom resolves this issue.
> 
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> Fixes: f422abe3f23d ("dpaa2-eth: increase the needed headroom to account for alignment")
> Closes: https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u
> ---
> A while ago, changes were made to the dpaa2-eth driver to workaround
> an issue when TX frames were not aligned to 64 bytes.
> 
> As part of this change, the required skb headroom in dpaa2-eth
> was increased to 128 bytes.
> 
> When frames originating from a virtual machine over vhost-net
> were forwarded to the dpaa2-eth driver for transmission,
> the vhost frames were being dropped as they failed an alignment check.
> 
> The skb's originating from vhost-net had exactly the required headroom
> (128 bytes).
> 
> I have tested a fix to the issue which treats frames with the "exact"
> headroom the same as frames with inadequate headroom. These are
> transmitted using the scatter/gather (S/G) process.
> 
> Network drivers are not my area of expertise so I cannot be 100%
> confident this is the correct solution, however, I've done extensive
> reliability testing on this fix to confirm it resolves the regression
> involving vhost-net without any other side effects.
> 
> What I can't answer (yet) is if there are performance or other ramifcations
> from having all VM-originating frames handled as S/G.
> 
> As far as I am aware, the virtual machine / vhost-net workload is the
> only workload that generates skb's that require the S/G handling in
> vhost-net. I have not seen any variants of this issue without vhost-net.
> 
> My original analysis of the problem can be found in the message below.
> The diagnosis of the issue is still correct at the time of writing
> (circa 6.18-rc1)
> 
> https://lore.kernel.org/netdev/70f0dcd9-1906-4d13-82df-7bbbbe7194c6@app.fastmail.com/T/#u

Hi Mathew,

First of all, sorry for missing your initial message.

While I was trying to understand how the 'aligned_start >= skb->head'
check ends up failing while you have the necessary 128bytes of headroom,
I think I discovered that this is not some kind of off-by-one issue.

The below snippet is from your original message.
	fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd alignment issue, aligned_start=ffff008002e09140 skb->head=ffff008002e09180
	fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd data=ffff008002e09200
	fsl_dpaa2_eth dpni.9: dpaa2_eth_build_single_fd is cloned=0
	dpaa2_eth_build_single_fdskb len=150 headroom=128 headlen=150 tailroom=42

If my understanding is correct skb->data=ffff008002e09200.
Following the dpaa2_eth_build_single_fd() logic, this means that
	buffer_start = 0xffff008002e09200 - 0x80
	buffer_start = 0xFFFF008002E09180

Now buffer_start is already pointing to the start of the skb's memory
and I don't think the extra 'buffer_start - DPAA2_ETH_TX_BUF_ALIGN'
adjustment is correct.

What I think happened is that I did not take into consideration that by
adding the DPAA2_ETH_TX_BUF_ALIGN inside the dpaa2_eth_needed_headroom()
function I also need to remove it from the manual adjustment.

Could you please try with the following diff and let me know how it does
in your setup?

--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1077,7 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
        dma_addr_t addr;

        buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-       aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
+       aligned_start = PTR_ALIGN(buffer_start,
                                  DPAA2_ETH_TX_BUF_ALIGN);
        if (aligned_start >= skb->head)
                buffer_start = aligned_start;

Ioana

