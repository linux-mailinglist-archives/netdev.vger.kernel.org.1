Return-Path: <netdev+bounces-244785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE18CBE8CD
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEE9530DCF63
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9543321B9;
	Mon, 15 Dec 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NseqilkS"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A253321B5
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810980; cv=fail; b=VLggk/Qs6r0VJ8KpcvfUYKhupwWDTCPpmOb7DSMoNcHjxbEdeU/MjiN2VOD6SOJOEaFcbeDrX1Eyp2BMgPnG/oQm6D1vzLL0DE53WeKlGQGWi3f20IYAZHYPbo57EeHcXzPqxjozAITas4/QxxUBdKII+l5+WSj/NLHQckZMgxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810980; c=relaxed/simple;
	bh=ikS+EQlkfp+xFX0LWUfuPMmsqDDgtGP+Hr0GfDrDdbo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FbGNACWSGMhtNkbD0heYBEnTrCG0PYHqcqq8d3tCIx8zsp1qfUHSpHNHpXdJD6HbUUN1aKJduasFEOK2msZMvc8fE87QeHGeANFGbDwfz/wfGWVUkmp3k+6OVCVaPAYfVd3Emewvxzs43mMMBryvq10gaJ5FbjNHDt1KC02m/ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NseqilkS; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVATpi8/y373xym3VF8YW610wFqdjutlayZ5U9MHcGUJRKcR30aaNo6ep5h1Mm63zNqTBvnFPkeY7HVa+G2G/5s3fl3IRpXAtb/xadFrQyWgvIIYUsJXWK9gOvzqghI7ba/ngODrw1yFzydIcbqJVJsZijsnBk2mqyLz92H7e+Jk14RUt0D3BfZ6Rw4akDv8EUevQxHgVSUuvc2aZiaZG+Dji5D6RyLBdGdA5OhhFIt4/asTZspA9yX+XS1SbffvWOmj/clbL49saL5zS4uSu+BJqI4F8n75wHNTMq6TicbRBfZcqGRrx+mbdqm1f95j3YD9E2FDf6VPWlfrPeG/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYanM20opPpycMGSNHlXGRcz5xVqK7phK7Hpp0VZ3sk=;
 b=Vb+cVFCIjEXCMmRKerB8LNjtLd0EJEfh2zvdMJ+dwnDMiTmpIsvO/4uu/saN6vdHs9WPV7jErg2aAR5u8yg5EdlzzzLBXUQmNsOPG3FxQLv+1GM89Ya3h0kM0N/8VjKo+yqViE/HNn4G6qGeHEvophqFjLyzsyK2FNL6awIJGBzmP/U+ut2YaA8QU0GZb06yS8zdTSvAnATQjV2SgpaOI7WxELI7wbVSorEBz9BBudyeK2oocniHd2g6ZLlAjY7y/5wMX++u1PIvmO9HiVEpO1cUG+EsulfoiI2l78LLsjcpHgmd2avzOR5mH63bXkU7+PiGkE0njXaWXRof/DWrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYanM20opPpycMGSNHlXGRcz5xVqK7phK7Hpp0VZ3sk=;
 b=NseqilkSqPxDXa0RkHLUw5DJJMblr+48o9UcxSQBtJefXO1Ro7K28m5/h+LjM0eCG5mngtK/37MmcgKHBkpgaSNoJqAf3Nu17Nd7r6IpdUtCXahXcLoYsdJfAE6r213qZoFlqir2Br3e9mskMdjKqt3fGIoiM4KMv29ehfGLsb5UC3PF2xCVUkhbjgSWpru26Z9xG8FuznkfeSEzhU1zxDoyjQXQWI7tnrx9mFyB4hqonW/6YFGuhVHiHL13HpTss9vxxhiZcLUHM5Ouv2bu1uE3C+siL3K5ccqrNU44HgrnqlUMv9sEx1KTuh5qCazITpydBMNiCJkm93gC+8I0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Mon, 15 Dec
 2025 15:02:51 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:02:51 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 net 1/2] net: dsa: properly keep track of conduit reference
Date: Mon, 15 Dec 2025 17:02:35 +0200
Message-ID: <20251215150236.3931670-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0157.eurprd09.prod.outlook.com
 (2603:10a6:800:120::11) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 66439a83-766f-4003-8e48-08de3beb0456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+dz5y7rP8+78RIZaMej7X95oF3PUjkjQbRGeQqVtOA7VSxW2oylEQRFtEnI?=
 =?us-ascii?Q?PTjxnuPI/D1o335j/tT3FaKu8ud/PUba85qe7QemAaSrWjD9dZPej66h4cp9?=
 =?us-ascii?Q?xabKccBqDnZlepdRRlNc79bTgQ6QMsTGWDqMnRqKRxAX7XwCgnmsYOBm7GYe?=
 =?us-ascii?Q?0gKdWKtCt9SN3eOEYR1Ab7ls5FwGYrk35kyXdE/q6piDcTP62XoeBzTr3S9i?=
 =?us-ascii?Q?THtvzVGlraZ7+6xuaDyrJomvEknAKnCjOOQmkpii0bFb/w+6m47QDc3JqrjO?=
 =?us-ascii?Q?34P4GFxebHpkiyh+YZnBVCCneeg1zjDvF0YqR4h4pdY3ihbhUK0D2C+apJx2?=
 =?us-ascii?Q?GxTjSBaNOlEmtwKzh1UbV9OISj/V47MmhsV7av/urUj6i2IyHpuGg/MV9Uy8?=
 =?us-ascii?Q?49MmTgk2MnfNc0CiO0shoWulrPnjrtF+lyqoJ11UGYEoiuASBBPLIiRHISv+?=
 =?us-ascii?Q?5cDjiSmsDoDUpWWDvjpFGA43dcC+BmxXSwwF5MF/Xi/vsAhzpxnk9wMJDuCg?=
 =?us-ascii?Q?3vYcbmVh4NPJFNGkSQfNomsrdjjGAhmUo7jGpIofyYlCqKy2L/Z4smo6QeJz?=
 =?us-ascii?Q?Us2lEY60Xs2RfnV1rmXIlKrlxT+5cuudZkq8UgS3sptPE5FMNhFIjaGE6utT?=
 =?us-ascii?Q?XHpqVu+MdbTjcef94bpB9vRgUvDODRv+1Loea6HUvwrzqKxafJx6SFt9rOV3?=
 =?us-ascii?Q?3Ic7tCTqqLqefVxPwf0Vzh/2pG/0YTnkMURZgiUGyp3BMMFARx7XSRTySVwC?=
 =?us-ascii?Q?kt3PDBVvHleU4mquzDeMh5Nyd4FTKjU57N9UMQvZiEFYDWjxKo0ldjaZcD1h?=
 =?us-ascii?Q?Cq9Q0A9H4m1trwLtZSf5B82j3ji5zYif3VWMcIOuQ6N7qwjoxNx7pXt5rNAb?=
 =?us-ascii?Q?ifSaiIf/cyoWW/+pGaYE1W3yaARh0abGGAhZPcgS3BL0deEFlCMgvkGmC4tY?=
 =?us-ascii?Q?PucEjRAcLtWpHdzGpunr+QNantg5yhh0ocEc2ZUGNVwVodUTbtjngZBxPl/8?=
 =?us-ascii?Q?bow6dzIsIxwDmrhXH3FntKOFxyR+oXWo9Jort5oDv6YNXMqVlbLYXSeLa1GA?=
 =?us-ascii?Q?yegvlHJmQQixtgnBAabn76qZp5kNEW4X9Dc0skLGudzgWtmpuc0IXlXiYvGM?=
 =?us-ascii?Q?0NPSUSHc/Et9hgF1DV5+BAz62CSOqczpyOMRHszVBFy5UIO6p3PP9Utyww7i?=
 =?us-ascii?Q?+ld7e+Ddsle2vtHBrJDKIUF3b2cnqKuIVb0mhbiX1ScnGAoQcH/vMO/Bh6qk?=
 =?us-ascii?Q?unCG9TY044dPk+EL5j2KvYfK41Z55j59NvuxdaU0vwS36GvrH9umg/XL8bN8?=
 =?us-ascii?Q?Fm7rohBCqi5J6LkaqyoRpeOm/0mD1Z78Z32sLY4tLCuaWyFgxPgcmKA3d/Ea?=
 =?us-ascii?Q?4a1lSjqIy1qiN+ukewNzekBwnuYUB+Oly1EJug/RpC2n18GTnjaeAkKVixyM?=
 =?us-ascii?Q?p8cEvwukSLFJUNSwcq2S5qaXgfmsZn46KvOlCrXL6sta5Em6QWYMrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9yDZjeKkOKvpPIsv/Lyf9Fm5zTD1Cke/40hM9p1I6kQImf3AZ71zMy+boG4?=
 =?us-ascii?Q?xsSCS/j0atTxecnqnoHZ8x44OST1myExxYUYEJmOHAvcL0y5XDsnbCqW3WrK?=
 =?us-ascii?Q?mXnsKiLAaiQriLQLctE7sHD6+tdtEjZbgsVeYBm4VbicocYYfWdYrAaGFl9I?=
 =?us-ascii?Q?wp1V/61iQzpTx3NjGDMRaXMW4H957+Dv6LanpORReM5drHTmPDIozWiWUYx2?=
 =?us-ascii?Q?1FB6bZalOwrHlt8zcfndymDdwzFz8WZxgK0FbToud4sKANV366UmISjTwyjr?=
 =?us-ascii?Q?1SUqNw1lH2BCxZfgDnvZhypFV4P9v+5b6mJZv2nAkFMrHAcDecR0W8QsILP/?=
 =?us-ascii?Q?SXWpyHQ6nwLYAluPUBWq6451+GIQ0MXsn1/8ZZx020f52rEDgRyZhlsgSYaZ?=
 =?us-ascii?Q?1Fo3r+V7t4d5Rp1nnQoAXIVJxP203rP7NqPLeyW0HwIfAk+T9Ulf1bpdGb1r?=
 =?us-ascii?Q?9fyVEXLfCXqScYCcLqauMUO+HYjqxE6Lyo+TMQnnNAA5oeaR2hug189kdrc8?=
 =?us-ascii?Q?Q4P93udByHzcOZqRmfwiGvyjEzoZfHDTTyQz68YOt0u4QGqQeEt5ruACE8RJ?=
 =?us-ascii?Q?KKbvXRpce1bw/aptfTTUY3ARJMfgvta8PpuTnHHnZEjO1h08lGJlQK5ZbmvX?=
 =?us-ascii?Q?jtfWeUEDz1C2uGBztBqaglolWG37+dFpkRRmPn6DDo1GwLvHqOVoq8yAZS34?=
 =?us-ascii?Q?brK3RXJeME6yHxUATbwTlGwrE6jJhU3cFWsZL5wm6uZYj16EKhcwC/zso6OU?=
 =?us-ascii?Q?pXbZYaH1HkyObF3rGDgsEn1tm9gpcogJYEIPW/euF/yl+R0yOk5hGSJ+dcaJ?=
 =?us-ascii?Q?6Cb5bpF2AmiasbOvkX2X3tFBQs13GxhLsE7hlRuUVUpBWD1xeU7BuE1KZWOV?=
 =?us-ascii?Q?CU8wgH/TpqZYMZriFzb/ynZxAOmudknOszGNcMn7dn87fpX2fWx5OCAbJOda?=
 =?us-ascii?Q?Luc4+WXkFy+D+9pJr55l4CPNGEn8SkuFZCpNecRdrcKS3xenNuUIpAnwxPQR?=
 =?us-ascii?Q?1d8Q7wNXOdMIPTZ6PMCKNGQ8sczh728AOpt7A8Hdo4UFCVe5YEI6tetrHWRV?=
 =?us-ascii?Q?6qxs176fanJgc0sxSiIlebpIW9ONpTn+xgWh/+ZPV05km+SvkfdKZs3PJkSQ?=
 =?us-ascii?Q?Q9xT+kGWE996D0KE6KGNBvo4bJWLpp2ix3mMoph89YwGxJ63r8QmGY8dbj6H?=
 =?us-ascii?Q?hJ5cQNQoQ0imBThPfTfG20krkZBLkvBKHS6SZpIlSbbL4A7aza5p1FxbLuh+?=
 =?us-ascii?Q?XsfEZEkxLSZrILN3SEo0ayr0HsW7A7S+SSv7qDqDda7qP634uviyFWmLhyaH?=
 =?us-ascii?Q?/6ZpIeWUhLQfNqPqBDVnmNkRP71TipWstyF1fz0ND0ISookCr3o1l2hGr/Wn?=
 =?us-ascii?Q?S/X4Qvc2lijCa1y8aaQLVff3MGI0s1LJd/UFB2U2fBkJQaBcla+SzYsfNLjV?=
 =?us-ascii?Q?XirWv0fR2Bb2bAGapqbpXKEgYwUj5Gq7G3qeuoTiKsr00Sat9I0BUIbNO8pB?=
 =?us-ascii?Q?LTwhs8XrsYeWPCZHdEjNHgocEgAkadd3l/AEDIoOydSjFy5UsFvBzDkWVDG+?=
 =?us-ascii?Q?3yIFFEiZHAKuBHjYuZBOijVYsmWaTp4lrUk36gr7IbqLnRJoNqe/HRhrLNXm?=
 =?us-ascii?Q?75sHcly2AFu0D8s/EUFbUoCKltJJXNse5IeJIdwGGVTPqYOeUNHjf+IGj//f?=
 =?us-ascii?Q?2Z/llg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66439a83-766f-4003-8e48-08de3beb0456
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:02:51.1917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlMlENj9D3cS/cDKy5aDHYi7Qyv9ccJ5c1jWCVWQTZxzPRixuAje5AK+A68wW8xOE434tJaBKLbGHYA3oYQPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367

Problem description
-------------------

DSA has a mumbo-jumbo of reference handling of the conduit net device
and its kobject which, sadly, is just wrong and doesn't make sense.

There are two distinct problems.

1. The OF path, which uses of_find_net_device_by_node(), never releases
   the elevated refcount on the conduit's kobject. Nominally, the OF and
   non-OF paths should result in objects having identical reference
   counts taken, and it is already suspicious that
   dsa_dev_to_net_device() has a put_device() call which is missing in
   dsa_port_parse_of(), but we can actually even verify that an issue
   exists. With CONFIG_DEBUG_KOBJECT_RELEASE=y, if we run this command
   "before" and "after" applying this patch:

(unbind the conduit driver for net device eno2)
echo 0000:00:00.2 > /sys/bus/pci/drivers/fsl_enetc/unbind

we see these lines in the output diff which appear only with the patch
applied:

kobject: 'eno2' (ffff002009a3a6b8): kobject_release, parent 0000000000000000 (delayed 1000)
kobject: '109' (ffff0020099d59a0): kobject_release, parent 0000000000000000 (delayed 1000)

2. After we find the conduit interface one way (OF) or another (non-OF),
   it can get unregistered at any time, and DSA remains with a long-lived,
   but in this case stale, cpu_dp->conduit pointer. Holding the net
   device's underlying kobject isn't actually of much help, it just
   prevents it from being freed (but we never need that kobject
   directly). What helps us to prevent the net device from being
   unregistered is the parallel netdev reference mechanism (dev_hold()
   and dev_put()).

Actually we actually use that netdev tracker mechanism implicitly on
user ports since commit 2f1e8ea726e9 ("net: dsa: link interfaces with
the DSA master to get rid of lockdep warnings"), via netdev_upper_dev_link().
But time still passes at DSA switch probe time between the initial
of_find_net_device_by_node() code and the user port creation time, time
during which the conduit could unregister itself and DSA wouldn't know
about it.

So we have to run of_find_net_device_by_node() under rtnl_lock() to
prevent that from happening, and release the lock only with the netdev
tracker having acquired the reference.

Do we need to keep the reference until dsa_unregister_switch() /
dsa_switch_shutdown()?
1: Maybe yes. A switch device will still be registered even if all user
   ports failed to probe, see commit 86f8b1c01a0a ("net: dsa: Do not
   make user port errors fatal"), and the cpu_dp->conduit pointers
   remain valid.  I haven't audited all call paths to see whether they
   will actually use the conduit in lack of any user port, but if they
   do, it seems safer to not rely on user ports for that reference.
2. Definitely yes. We support changing the conduit which a user port is
   associated to, and we can get into a situation where we've moved all
   user ports away from a conduit, thus no longer hold any reference to
   it via the net device tracker. But we shouldn't let it go nonetheless
   - see the next change in relation to dsa_tree_find_first_conduit()
   and LAG conduits which disappear.
   We have to be prepared to return to the physical conduit, so the CPU
   port must explicitly keep another reference to it. This is also to
   say: the user ports and their CPU ports may not always keep a
   reference to the same conduit net device, and both are needed.

As for the conduit's kobject for the /sys/class/net/ entry, we don't
care about it, we can release it as soon as we hold the net device
object itself.

History and blame attribution
-----------------------------

The code has been refactored so many times, it is very difficult to
follow and properly attribute a blame, but I'll try to make a short
history which I hope to be correct.

We have two distinct probing paths:
- one for OF, introduced in 2016 in commit 83c0afaec7b7 ("net: dsa: Add
  new binding implementation")
- one for non-OF, introduced in 2017 in commit 71e0bbde0d88 ("net: dsa:
  Add support for platform data")

These are both complete rewrites of the original probing paths (which
used struct dsa_switch_driver and other weird stuff, instead of regular
devices on their respective buses for register access, like MDIO, SPI,
I2C etc):
- one for OF, introduced in 2013 in commit 5e95329b701c ("dsa: add
  device tree bindings to register DSA switches")
- one for non-OF, introduced in 2008 in commit 91da11f870f0 ("net:
  Distributed Switch Architecture protocol support")

except for tiny bits and pieces like dsa_dev_to_net_device() which were
seemingly carried over since the original commit, and used to this day.

The point is that the original probing paths received a fix in 2015 in
the form of commit 679fb46c5785 ("net: dsa: Add missing master netdev
dev_put() calls"), but the fix never made it into the "new" (dsa2)
probing paths that can still be traced to today, and the fixed probing
path was later deleted in 2019 in commit 93e86b3bc842 ("net: dsa: Remove
legacy probing support").

That is to say, the new probing paths were never quite correct in this
area.

The existence of the legacy probing support which was deleted in 2019
explains why dsa_dev_to_net_device() returns a conduit with elevated
refcount (because it was supposed to be released during
dsa_remove_dst()). After the removal of the legacy code, the only user
of dsa_dev_to_net_device() calls dev_put(conduit) immediately after this
function returns. This pattern makes no sense today, and can only be
interpreted historically to understand why dev_hold() was there in the
first place.

Change details
--------------

Today we have a better netdev tracking infrastructure which we should
use. Logically netdev_hold() belongs in common code
(dsa_port_parse_cpu(), where dp->conduit is assigned), but there is a
tradeoff to be made with the rtnl_lock() section which would become a
bit too long if we did that - dsa_port_parse_cpu() also calls
request_module(). So we duplicate a bit of logic in order for the
callers of dsa_port_parse_cpu() to be the ones responsible of holding
the conduit reference and releasing it on error. This shortens the
rtnl_lock() section significantly.

In the dsa_switch_probe() error path, dsa_switch_release_ports() will be
called in a number of situations, one being where dsa_port_parse_cpu()
maybe didn't get the chance to run at all (a different port failed
earlier, etc). So we have to test for the conduit being NULL prior to
calling netdev_put().

There have still been so many transformations to the code since the
blamed commits (rename master -> conduit, commit 0650bf52b31f ("net:
dsa: be compatible with masters which unregister on shutdown")), that it
only makes sense to fix the code using the best methods available today
and see how it can be backported to stable later. I suspect the fix
cannot even be backported to kernels which lack dsa_switch_shutdown(),
and I suspect this is also maybe why the long-lived conduit reference
didn't make it into the new DSA probing paths at the time (problems
during shutdown).

Because dsa_dev_to_net_device() has a single call site and has to be
changed anyway, the logic was just absorbed into the non-OF
dsa_port_parse().

Tested on the ocelot/felix switch and on dsa_loop, both on the NXP
LS1028A with CONFIG_DEBUG_KOBJECT_RELEASE=y.

Reported-by: Ma Ke <make24@iscas.ac.cn>
Closes: https://lore.kernel.org/netdev/20251214131204.4684-1-make24@iscas.ac.cn/
Fixes: 83c0afaec7b7 ("net: dsa: Add new binding implementation")
Fixes: 71e0bbde0d88 ("net: dsa: Add support for platform data")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- modify commit message
- shorten rtnl_lock() section by calling netdev_hold() outside of
  dsa_port_parse_cpu()
- modify netdev_put() order in dsa_switch_shutdown()

 include/net/dsa.h |  1 +
 net/dsa/dsa.c     | 59 +++++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index cced1a866757..6b2b5ed64ea4 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -302,6 +302,7 @@ struct dsa_port {
 	struct devlink_port	devlink_port;
 	struct phylink		*pl;
 	struct phylink_config	pl_config;
+	netdevice_tracker	conduit_tracker;
 	struct dsa_lag		*lag;
 	struct net_device	*hsr_dev;
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index a20efabe778f..50b3fceb5c04 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1253,14 +1253,25 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	if (ethernet) {
 		struct net_device *conduit;
 		const char *user_protocol;
+		int err;
 
+		rtnl_lock();
 		conduit = of_find_net_device_by_node(ethernet);
 		of_node_put(ethernet);
-		if (!conduit)
+		if (!conduit) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
+
+		netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
+		put_device(&conduit->dev);
+		rtnl_unlock();
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, conduit, user_protocol);
+		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
+		if (err)
+			netdev_put(conduit, &dp->conduit_tracker);
+		return err;
 	}
 
 	if (link)
@@ -1393,37 +1404,30 @@ static struct device *dev_find_class(struct device *parent, char *class)
 	return device_find_child(parent, class, dev_is_class);
 }
 
-static struct net_device *dsa_dev_to_net_device(struct device *dev)
-{
-	struct device *d;
-
-	d = dev_find_class(dev, "net");
-	if (d != NULL) {
-		struct net_device *nd;
-
-		nd = to_net_dev(d);
-		dev_hold(nd);
-		put_device(d);
-
-		return nd;
-	}
-
-	return NULL;
-}
-
 static int dsa_port_parse(struct dsa_port *dp, const char *name,
 			  struct device *dev)
 {
 	if (!strcmp(name, "cpu")) {
 		struct net_device *conduit;
+		struct device *d;
+		int err;
 
-		conduit = dsa_dev_to_net_device(dev);
-		if (!conduit)
+		rtnl_lock();
+		d = dev_find_class(dev, "net");
+		if (!d) {
+			rtnl_unlock();
 			return -EPROBE_DEFER;
+		}
 
-		dev_put(conduit);
+		conduit = to_net_dev(d);
+		netdev_hold(conduit, &dp->conduit_tracker, GFP_KERNEL);
+		put_device(d);
+		rtnl_unlock();
 
-		return dsa_port_parse_cpu(dp, conduit, NULL);
+		err = dsa_port_parse_cpu(dp, conduit, NULL);
+		if (err)
+			netdev_put(conduit, &dp->conduit_tracker);
+		return err;
 	}
 
 	if (!strcmp(name, "dsa"))
@@ -1491,6 +1495,9 @@ static void dsa_switch_release_ports(struct dsa_switch *ds)
 	struct dsa_vlan *v, *n;
 
 	dsa_switch_for_each_port_safe(dp, next, ds) {
+		if (dsa_port_is_cpu(dp) && dp->conduit)
+			netdev_put(dp->conduit, &dp->conduit_tracker);
+
 		/* These are either entries that upper layers lost track of
 		 * (probably due to bugs), or installed through interfaces
 		 * where one does not necessarily have to remove them, like
@@ -1635,8 +1642,10 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	/* Disconnect from further netdevice notifiers on the conduit,
 	 * since netdev_uses_dsa() will now return false.
 	 */
-	dsa_switch_for_each_cpu_port(dp, ds)
+	dsa_switch_for_each_cpu_port(dp, ds) {
 		dp->conduit->dsa_ptr = NULL;
+		netdev_put(dp->conduit, &dp->conduit_tracker);
+	}
 
 	rtnl_unlock();
 out:
-- 
2.43.0


