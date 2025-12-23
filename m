Return-Path: <netdev+bounces-245846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A877CD925D
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D963013EC5
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2767329392;
	Tue, 23 Dec 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="h7BAIVp2"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B86027FB1F
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766490315; cv=fail; b=eAjMFYszI8HPADvcXawFLL7vkvmFbEoLc0Q2dyJwAWyMWaGK32zWbisx7gD/ZDlwWNdZk/rw7GED/9NlgmwoUxSHyuhRNBP1huhpfIjrUnr50wPTF0LSGP3idx4nKNQ8zIqZ7AfejGwuasJut0L8+v4gDfiv9N0y7vMXx8MGFkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766490315; c=relaxed/simple;
	bh=bAxmF8HbnYsjzHQiBKN9S6hlIayu45ZtyL0Nz8WqN8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qKhiodgQANNaYKIP8oNzbR9jiHszwZrtpPKdxMgqa78/cXAXbfTASwyRKSNo+TwYsw9LHS5YWvtgi0JYdbN3oIFLXHyo3x5zR8jXdwZQy2znC26uYDwFuDhJ0hRgubeaePJ7hfRlJU0H4cvCl0ctxIJ6mlmD+qyc+q8l8RQuGPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=h7BAIVp2; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsR/MTirwq1+4TZlH2vUqIfHK31mVDl+jzJupkcI9jZxhOCWK5Oa0VLFJXIkIk/v+M1qXxVR5EBW29/6ztrTBsdekFDy/ERmlcuTguD16MmcvgGWvp6u1XntaFiPYJ3fCzKJwGawnXBCtYUo3Jb8Zmm0Wg29wMZBW+VlVnATt08zuP+E4mW5SDSB8mmB1Jq7uqBQ4izgEUdOCA8o/JfxiSH+J7MhRakvxzLuEZZ1p1ftARSmX8wS5qTkrbdo9mK61/ODCWYxdWb/3mnoOIoXjF85Rv7qYrDWzhhp0ujiYACk+C/mrEZZ5MNSo0Ty5wPUPbvlTNRTIOvTYcSeT2ivTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAxmF8HbnYsjzHQiBKN9S6hlIayu45ZtyL0Nz8WqN8s=;
 b=eabj/HVkwG5vi+Bu4OanwxPzL5Z4C77Lxvx65oRT61zU9Ao9fWflAHfXyAn7SE4sbqDNJwjPgloBnDMQ+culH5xAMvM+Mif3hPfg+BsrapsRsegbcABg4OCfllXeSaDHna8SiFy2F+MUiigEKviIjqyYNnniRlXW7Aejmb9cYvshtT3SwK0Rp2e0/RkNNwojbhjCcC1kPd2uKP+1QuMoTw15DaQa7vKsYYaw5jvdcI2Euc1v0HtLB8EYpccEEe0KskQYUNjIVc8IUeYtv+CC5vbv9c9nmxsSj8p0tGE04wKqtYfjKZx7f3JEZmIz41zSBP5KCzKFtwT0a2AtEIx5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAxmF8HbnYsjzHQiBKN9S6hlIayu45ZtyL0Nz8WqN8s=;
 b=h7BAIVp2emw7bguLdMgt4a1VwGGe1JDbDqmYKxQw285TSElRJFx/X5ReJrD/cMKzxJ4qR+Edes0ek+Sjeoe99K47iheTBk62YPW4f+R2XXLxazjWEoCNb0s/ATi/qSRlNWtvg6ftkXiDQYK3UmMj6zHnw3dgQYhiLfVFu6tcrrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8576.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 11:45:01 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 11:45:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: <netdev@vger.kernel.org>,  "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: Re: question on gswip_pce_table_entry_write() in lantiq_gswip_common.c
In-Reply-To: <aUp3D45Ka-rYL44u@makrotopia.org> (Daniel Golle's message of
	"Tue, 23 Dec 2025 11:03:43 +0000")
References: <87sed1shwl.fsf@prevas.dk> <aUp3D45Ka-rYL44u@makrotopia.org>
Date: Tue, 23 Dec 2025 12:45:00 +0100
Message-ID: <87o6nps9qb.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::18) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3cdaf8-a7c6-43c4-3f73-08de4218b4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qnVynUvRKM+oiSejPkZxP/GW2sPHVBz6wHAjcsz9a/ao7obgLwLWHmtvsQE5?=
 =?us-ascii?Q?yF8g9/v7YHVSSyNzWDEmdee4gvT7PQCzdrq+rDzuzAC7eQcIo1VuDHPmxqET?=
 =?us-ascii?Q?6th1APpdMIpM7GAXPV6BPEQW5L9smsfEZwOKi2hNfjjZ/IEKeiOR5sK6HdI0?=
 =?us-ascii?Q?Zd9X2rjeVR4HULFxuzVfPAO3wq7N+d4emen7LH7RNXFKZjnh2vTrjVbFVc1C?=
 =?us-ascii?Q?3eHV26sI5ZQpeIU0rOBri/sPb5oNvy9gqRQNYPTqOwkxF/T4VWYy9DjBdUoi?=
 =?us-ascii?Q?Kgdo8+4OMdOhyM8hoItRZIEjz3aP2b4SBQEdbljLMjJlIUc33DhTTYGpjSJx?=
 =?us-ascii?Q?uNfJbyrQNjvZO7Lv4ZV32wBmzRggdRZAh8hVZgkdSbfSHzeq/bXkCR70JoPx?=
 =?us-ascii?Q?KK20zCfH0LVUnxAkMNsqM/dmPoACWYFRlLN65RC7weqtAKoeiS8SJlyUgLOu?=
 =?us-ascii?Q?O2MQy8Xf1/Fo120340cZ4+yOWj4gDLrY+M9zRXq18dlgREdCHIY38P/LQyBD?=
 =?us-ascii?Q?gbTfBTulCXweaNJfzdJzItK+vuVQYEakW4fM3xRYUgcn9cQplP3QbtSBB4fF?=
 =?us-ascii?Q?+trF+aFzBZ4mHwDb7L6VQpdIVTeMnZ+4IpNLvSfc+s6e8Zn1dCHKTVqpdx+Q?=
 =?us-ascii?Q?/Yt+GxMPPiDSbo6XE1rVaD6HbLQTY5i/59Bqw5lVgj/XGUpKcmD0KXOHsh90?=
 =?us-ascii?Q?ALRb4aTD2ZiIeWi1LTJmU/i/+kvAtU6CFPhLt5DObBgmFTxBMgt3Oq98esLI?=
 =?us-ascii?Q?8HTHR83T+T8TTGvmcfeT96aU/WrUV1ylxZqDNeOoIgSYg/eI98Ge68Q8qnW2?=
 =?us-ascii?Q?8RP/KhTgtrOdlr76Zx5O2o7mmxn71fcYTOhPOg1SSd2684PzfIXApSykWZeJ?=
 =?us-ascii?Q?eCSST2KDNwGQXshF/6HT224Rns+u+VjFucDr/VQEaWn48mV6aasY4+cKGTW8?=
 =?us-ascii?Q?u2v/KjEWT26I8kq6wghnD7rwjWicANvhfq+0p88UU/F1TwJzpCe5ZL6dSna8?=
 =?us-ascii?Q?w+sNvDu4lquK3EqLhDgBchXJ3z9XDJ9JEzR6347guzN7qYS8Sbp0bdU1y0jc?=
 =?us-ascii?Q?hj7yAjzUYu6nFJF2RAPSNElmQvedYoRphaocPrWDbGQcxH2IRVdM3VFRye7P?=
 =?us-ascii?Q?mdovZxyIao7HNBRmxfHkvLpUJREaM8Yzq1ir/H7ZsGnvFu9qWxApBPcO2T+C?=
 =?us-ascii?Q?2xM3xq3Cl0x+fEvy2GP1S+lJEJCz4zrrizaNGt2HDoabKfadde/jWlZ7WAWv?=
 =?us-ascii?Q?Isqd5MDqu6JJBtxSaPTqcvioyRWx/AkOc+KU5STUfPrl04CaOBEkZ8EE5Wsb?=
 =?us-ascii?Q?gFkafhMdhALVsBtwTTZZ9bC7k7rZgJu7yPgoY9jrhwHi5oNN/hVoWwwUWwH5?=
 =?us-ascii?Q?5bdkhHCZyOyoNMY7RtjSTEwm4ZKrUzDAZDf57m3uO4x/h020bHRpaugXxM5V?=
 =?us-ascii?Q?VTFlDmT9PKyBzgab355jlhrfe3h/+5m+Nh7w5dhFYIoDWtH/l9NoLyiPjX/P?=
 =?us-ascii?Q?uv6lWDINp3wXcmWxQLpKOu7HwyxNQ7xIOjlZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rleq1Jhw14lHL8nlYgF3uG6fiMOhYf6nPNNGjq5q85MKAsx+5ZFEOSehc+XH?=
 =?us-ascii?Q?fcI9H/fkL5waODprhNAJnBqkZ30/5+IkpavXe9O45ncQG9gDtZxUne5B/zkP?=
 =?us-ascii?Q?BfOQN44JcT4EfoTgDb7fa5KqC8Gf3+AUellpoqJGTFmxrYFZvZygKz4P1bmi?=
 =?us-ascii?Q?EvY8UotUqr45AykrmtPZP8F918BnqYcPt88K34wJYNxW4t8cbmMOArB3fQJC?=
 =?us-ascii?Q?gDm7ZlP5AJdSEAW+Xf7ZJAZLI+hJL5tFnpiOTOv3qIl/5RlShCH6PI05wMj5?=
 =?us-ascii?Q?B/bmDw7p4LTTI509DY2BneNbogDpU6UH31zQG2Be/pAY+2JGzZA7A9tmqMqB?=
 =?us-ascii?Q?AhZEbVSqBsUG7Per/3YStyqCRiECl+fw5oKlLolhfeHBkB2pcuha9kXPZUFv?=
 =?us-ascii?Q?A6J16owGl0Jv0ZcWsXCPk+haF1rJBufDUixiASVIU/YkPwMQl70vyIn8YN0P?=
 =?us-ascii?Q?Dayw8DCMYksd3BFxjin1OSPgUfAVFa7ExtI5nXTFfRj/4xid3yXfXYMVwXuL?=
 =?us-ascii?Q?TDJoSBIunu6Gb12eL18TH3FN+Yy0Yokke4K3ClVBQAjB9XCIbxGKEy7nz8D3?=
 =?us-ascii?Q?LtVaCYqkOPxhoGNUiDsJ+lBx38wexFHWEDWvFzfWsVhv86wcdk0zpu2WWTiO?=
 =?us-ascii?Q?HxzvbHKDimWBbrzQDmU9lKWumv+tAIEPVfm7sRJe0G6Nd+ErnPSHn2sUfiuJ?=
 =?us-ascii?Q?aqQEd5vFEhrKiqAgbG1avZ+TcrbuwpoMNvXYW3Ym6xwkcMdpwAKideAY8x/v?=
 =?us-ascii?Q?hY9qoQ+LJ3dTw+ZSwsNG0GC5tCVSqAC+0Zu5Opg40kbK6NHTiT4/PbJzAjJz?=
 =?us-ascii?Q?rKbaw1DoFF+1YtcUjx+L3fSrRdHnMQd7ti7g6AMoIn4wUU5HyG+OmwDDkYZw?=
 =?us-ascii?Q?k7f/hX2lMArs7WEmc0c+ZpgIkOgW015mJsPR3Ivga8OgU6GyA1QrCGfYQNfy?=
 =?us-ascii?Q?PXDNfCJAcAd+k+w1X6658hiM/imPzR14IwRioGoiAkF070lJChvmy0TDVWNG?=
 =?us-ascii?Q?biM0N+ehod4Un7ItcA8VxgXNkPGkoFeR1fu4ioDihcMzZsYZzEO26IM/Xd4D?=
 =?us-ascii?Q?yVqYyce2QzWOTBHAf3wfMDBQszrZN9XuGSG6HbAKQX76vUBpXUj01mLAEP/z?=
 =?us-ascii?Q?XpaYyB83iU/7PccSLaEzBoTP/PcE6uXFMB5NSE+vcXyrdLT4EcTREJYR7WVp?=
 =?us-ascii?Q?Q50PMFA7808/U0+vdp4ADlkYcm1aTdn/zvx32TshYIDMONtSG7nTyx6f7pI4?=
 =?us-ascii?Q?VL2oMal8QiRUBdLVUMm4VoLZpIEPI8Jb544SlxKUIIpBBh6O7QVI3LpHvlSm?=
 =?us-ascii?Q?HWVI8ufS6SSWaEgxL3VsDIbViczMafKWS4wo5+gmKsUByse8EjAWgpjDLgL+?=
 =?us-ascii?Q?Fj1JzmW3NPyy3u9eVQfeXGhFKtBKuVBwiPggQLvIVMf4Wxuo0lK3HRCksFbI?=
 =?us-ascii?Q?mCLvlvZbp7UhlMu++pLTx0KegM7Zh0yNtnZE3AJkG540OROsNyPMacw/f/8d?=
 =?us-ascii?Q?q5dstcjPbUOcoqEkEhVcyOgpUr+xbY827unNIn9Gu/8z+ERSXacRaw4N6ZY7?=
 =?us-ascii?Q?PlF8n7KnYumzDEre5JzprOYvJ8VPMWGwBskrsru/J11nNHZeG5ZPlLDU+qzA?=
 =?us-ascii?Q?9I19K0avyLkkPyBAN0pn9pUyWAZtXNNA+avLLyEjFyk6LsBHLsyCxUDHJo3W?=
 =?us-ascii?Q?3GO0CKQhy64nHpCXJK2q3ra9tResRn2tnYuRVfdhlMmD/dJalEPcDdXS9GVC?=
 =?us-ascii?Q?6ah6S5wgZjRRFF80mPjgyJK8Y9g9n9U=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3cdaf8-a7c6-43c4-3f73-08de4218b4d2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 11:45:01.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fm1M9BcnjND8fgYm4cv/mIphZBXtKsXpUgN5I7NE7c7E/+Mqx+EqXzZpXrWKsqjKkBVt0WIV8cwb9FxeHZhGdW6031YGLAG28rIoG4u9AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8576

On Tue, Dec 23 2025, Daniel Golle <daniel@makrotopia.org> wrote:

>> Another thing: I'd really appreciate it if someone could point me to
>> documentation on the various tables, i.e. what does val[2] of an entry
>> in GSWIP_TABLE_VLAN_MAPPING actually mean? I can see that BIT(port) is
>> either set or cleared from it depending on 'untagged', so I can
>> sort-of-guess, but I'd prefer to have it documented so I don't have to
>> guess. AFAICT, none of the documents I can download from MaxLinear spell
>> this out in any way.
>
> I also don't have any for-human documentation for the switch table entry
> formats and registers. I doubt any documentation of that actually
> exists.
>
> Most of the switching engine itself is covered in
>
> GSW12x_GSW14x_Register_Description_PR_Rev1.1.pdf
>
> but also that doesn't describe the individual tables.

Thanks, I do have that document (with a 621442_ prefix). Amusingly, on
page 9 it says "Attention: This document is meant to be used in
conjunction with the GSWIP API documentation." But if that is supposed
to refer to 617991_Standalone_Ethernet_Switch_API_UM_PG_Rev1.2.pdf, that
doesn't really help to understand the hardware, as that only sort-of
describes the use of some library functions, the source code of which I
do not have.

> My reference for that is the old/proprietary SW-API driver which
> describes some (but not all) of the table entry formats in code at
> least...
>
> You find the SW-API as part of various GPL leaks, all files there are
> under a dual BSD/GPLv2 license, so I can also share my (latest/official)
> version of that driver with you in case you don't have it.

I have a zip file containing a
621048_GSW12x_GSW14x_Linux_DSA_Driver_V1.0_Rev1.0/ directory, and the
code in there does resemble what is in mainline somewhat. But I can't
find any more comments on the table format(s) than what is in
mainline. If you have something with just some of the tables described,
I'd very much like to have that.

Thanks,
Rasmus

