Return-Path: <netdev+bounces-151133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD649ECEFD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A261639DC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A98119995B;
	Wed, 11 Dec 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDPvctMl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFB246342;
	Wed, 11 Dec 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928619; cv=fail; b=rJiongc9JhU45Q7t/698obQD/AYaCRVGmFdy0K50i4I/lXbhgFNAniiJkRQHMJfMJPkDJ87yXC745jJaOit9RzzrRzpLBJ+wJR6j7bn3SUoJmqnCaZvXZ6IaX8p8pNOEDlibDSx/YL8vEcmOjbz1PkSBhfqRUdzOgJj8gBNAbhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928619; c=relaxed/simple;
	bh=6dlV+5gO2Av+7ilIrq82kx/iNlTF/SAbPNc6H2DDtJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G3d7KhY2IjySmBZVVoqHlVAtoJ1RlJm9wcplTd3c31hTIXWc9mllo8OyDDdwqqtwjCvTUzkwOSoU+gTt4nOLG3QjzH4dv2fwSMCSoq5/E/ZQHHzoG+0K9ceNKCQSGCTnd7YMUDTcYXCOKwTM4SVABwQbrVgZuvGKGA4eSlyhU2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDPvctMl; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8RLCZdhROYH8EfD3qs9Du3BNBLKtC5WAQdKJUBJOClnCvF4V27cZGAsXLtETSQd7mtU6xR/gSi6SVwDgNA96lUHD8pBeFQ751bIT6rE254zkPwJkVSlP70RHwIMQdupknbPNdaUihdGhDelUnJBAF78gv7XmrwIplYnQHB4Uw6yU1wZXR1oKy7GV4Y+WyO4Tg91lQ0yg+NqnBnVD6Z3E5QT7kLpcmqXZr4b52vadkpZHdQ+6LLlBeAeUDdB6KkXT4mmuuCmUDIMaDKnhmbjCRbTunPY1fZJcMj6YN3sBZAtsj0tzMpcjJyh7sCvoE6Ysm0Hxsdvh2xjdluKpxgOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7uRMzaEaYb/682/e5a+MPtyhlcJmQIP9ctnIwOHmxw=;
 b=jipHS6/tqZVx+SO7Fo08YfBH2IYRdbXNvFQ4cT4z7soBkyqEdY6e6516AiB1vVKz9ceHHI04vfu38Rb79x0+dV1AUYv/euyT1PQFjfCkkJ2WiqcGZ0MGU452bIUKgnRNyADVthgLxMsMGZCFsvFLw9cJklPVxS1m5uDpjLjDhsZameiXFskJZWnjGF2SwBLxpLdkRxkjmPoWSucS1aeBrKx41GqjUd9KUZoFe9PmHUYnOLUqSm+xZ7abzBtmRnsZNG/qdkhFNlakAPVm/Dz84N5N/lNMSX4UjD6PrA0kBnQbwyG99O0w0YybX8ZRbyy9f2ckbPfFdVmBcg6gmIx7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7uRMzaEaYb/682/e5a+MPtyhlcJmQIP9ctnIwOHmxw=;
 b=cDPvctMleUmOS5U7ED/4gObgRQJ701SaR5/+xMLTyrJXUkvPp4u2/Z3c10XSglatYNRJDv4ZKazTEEWwJc63xGpFvsRnOuiYazhRGcwMFwE55K7kqvBJ4hhmJl6BgDOX9mhsB2iPDh/J46Bzx6uxY9ELsmk6G5DFGBSRe294C/2LnDMebP/8v4rqQU0pHsmHFbde9F59UBfBRzsqeNgvzEpKQRCxRF831QSTAgO9N5hhVb1NXAJqabtCv/aiLnhzyblvbIMKRo4YIjMsAV0f7eACy6ON+1W1k4wvDk+ih5vBqlgWo1DNYBtQZtGGjJu6Ijg56Q0G0zJzEQ/hhloUnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 14:50:14 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:50:14 +0000
Date: Wed, 11 Dec 2024 16:50:04 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <Z1mmnIPjYCyBWYLG@shredder>
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 591731d0-5500-4e46-2b7d-08dd19f31ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r7SyYCLHe0c6mD4NnqXN5e+/0k0IeT8uDuJNFZA48FwUJNMFy0q23ZNyiYwo?=
 =?us-ascii?Q?pT8XWC2l4PZrgbK6NaAj/M605XOEIg1YkPvIq29o2ugh/DyR+wqh+371Hg1O?=
 =?us-ascii?Q?etRa54YpdBZcb4iqbsHgNwioOgia2Zl7kPEJRrZY7EbqldwapJyQDKGdFAU1?=
 =?us-ascii?Q?cts+R/eWuHmqWe4zByscQnQCeIWCZ2Fwno5A4JhzmYYn+ahm9e7vdUqSDClq?=
 =?us-ascii?Q?NOdILeT/Oh7wD7+ATfK/qKzl4RtVAV8pys/rKA/qeLIB7T3JppS+Hf8OzIWU?=
 =?us-ascii?Q?OvgrYbE7mhUhz4I0yJDga3tcqk305D7TYRcF0+hcRG5amqGd3tFCEwwEwCgH?=
 =?us-ascii?Q?Z3tfRL3A+9lvwvfFWJFMZh2LDCxnPQsAP70XUy/9uBSjFKQfu+Z8rJ/ZDCrd?=
 =?us-ascii?Q?PGIqgyGDKeot3FAvSHj2T/cbEY9c/gyku+8G/GuKt93q/Q8mLcSGt1BtpzEl?=
 =?us-ascii?Q?oUSC4C4Nf55Q9gQydHZGn/N72mCoz/JRnDCnis9NAh4Y9cmtqAO2CRkjJQFY?=
 =?us-ascii?Q?EaNFcjl8j/Kp0Bc2tV6VYheaQ2Oay0jwV3V9Ib0epIzFc8llk1glntxtqv+R?=
 =?us-ascii?Q?zaUq7p6wXHWSk5HnMnq9U7Q0oKyZ7QpSIXT7ntoLeR0DatWjN7tFkTQ42XnV?=
 =?us-ascii?Q?l7i+E/Rjua/Mo15se/UuFU3dmo2mwBF48cbrUGSlgAPJGOj3GB8h/9XIB+ye?=
 =?us-ascii?Q?STZTb62xZ+4YXAqDhAZObMv93QkFa/e6uAR3ldckJe/3CqtQFc5UL+NiCfuE?=
 =?us-ascii?Q?qzCvhff9pQrLv/+Jccd8pJKo1H7zSoIpwSskIG2k2Id6eSzzuvKkULSn875+?=
 =?us-ascii?Q?UMESX91WiW78FlFpzou6cEND0O191+Wuwa1uH8PqMmKwjKFxGChGEvfoq7Q5?=
 =?us-ascii?Q?glk+yClg7MZxwqVWk1wG3iUXDWkghs7YuhqYWFBladkcTM7v5ZE2Pn43l6iE?=
 =?us-ascii?Q?3N6eS6Un1XarO4OsfjdqPnN6nXEwZImhvaNTkBnFh5+HsJne219jUrr2PQ0B?=
 =?us-ascii?Q?6FOvMW8Y9uTTtkCdL7whKBPlwklh7b0yj5tmPgsixdEHhS92m93b5TNGVqs1?=
 =?us-ascii?Q?ek7LiQvWmFX74zGaZQhWt4uIkHqEzw/Mx6vnTvlXkSpjxLYvK6h5+kk+iZqA?=
 =?us-ascii?Q?izDcpl6ASfnRT4Gkebnhk6boVwhupvidRqYFUZ5nbkjfSGv/qlmi/kUlzN9N?=
 =?us-ascii?Q?+XUE8MPSvIKSfWQBFC/41nAEDEiqM1bC1ysER8YdRwmRfyhtXrh3Zxf7y3nZ?=
 =?us-ascii?Q?HKr+srSXN8k9nP2xl2IDH9DaJh65Gz2kGgH3ntgGJEfPv0OOAGC2I7ovVMzN?=
 =?us-ascii?Q?U9CvCGVGJy6lB9fbqTjJ6nqq3LgHnsLTWrwIYNwmjKPZGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWSE/GGqZ0WjX+VqxR+WEcdSqp2yJzcl1PTnrAkmUs7TpSvnv29WWkMjyZ45?=
 =?us-ascii?Q?KUg6trvXpcjElNO8K1PsR/Gwo3GR5TZ5uVvwdTgQSw1l5EIQm7lnVclu/HxD?=
 =?us-ascii?Q?5wqNN91r9zpxujjfh/bN11TiSbAcKQohVkcu1hF3AZCkiyZb7Qy3zMYoGyeN?=
 =?us-ascii?Q?n2MBqKlGMb4azUlV6gLhH/TgPv6NooCYLymrPbkaeUJ6qIGO2VFyZSWvOZr7?=
 =?us-ascii?Q?atIepYjgN9KuM4XF9L++UXIkrpAMdO53kuLr1Hy97rb8wDN4gasn7+tTYAH5?=
 =?us-ascii?Q?jJTZEnvOMnMylVBIm3n6+oJp+7fvenNcx+X076cZ2AnPjX3eJmHBGjOaTPoC?=
 =?us-ascii?Q?oG9y395EC+aVjeAfgAYEcRQ+gk8iENAmHuFHFRtcpBAcUZ3B1ggKVagMLyP0?=
 =?us-ascii?Q?b/vaWIy2a2vI0rMZHWlBOf2gGVYyw8DX/bFRa7uSvIMkAk5LCuUhrK8qwDBi?=
 =?us-ascii?Q?lE9RP6CrRpQdkAW1rSHtZR2vXgc3lckSE1C0DKQg2DXqi/sD9a+7VLSferEZ?=
 =?us-ascii?Q?7sxg8c3QT/MqaiCFl1g0q9m2guUX4wPs/r5Q/hoVXiMt5MLX05bpyzfjvRE4?=
 =?us-ascii?Q?qnbLpEOnpaOAaczF7GfaWmHEpFxPgqT1qRhfLbG+s11Si1anwQnTC2OR1G/p?=
 =?us-ascii?Q?qarX/oPss4KXwW3DC5f9Ak4OhmbqOMhzuLhMFcBcLKVJx4WxsBFFyxyLxNgD?=
 =?us-ascii?Q?5fC8PvwJt94bct5jvAsgLEbkkd3HIafY3lSN4ePz9GcsAkRFixpBcHeXl486?=
 =?us-ascii?Q?ZQN00PNb9yTgtkYVlhDj0rjLQJwjWmUxOY8oyIwadPnGhSAOhgNN20hmo6gv?=
 =?us-ascii?Q?dFOa3dj5YtUTY7NCipSezvY6NG//5Np8adXCd4urep7pmpv+OGY5/QYhmATR?=
 =?us-ascii?Q?WuDtDWG33+qB4OLLGXrTEYwCNaWWmXDE+Wznh2m5DFgPIdoO4mLITAM7BPTX?=
 =?us-ascii?Q?AKIJf2BjikWWmqNdkNGO1hn1Hy0hrb4oHOZGWIuHPl4E7MBcQVKIF6hqNd4x?=
 =?us-ascii?Q?5orXiNTkiceC1V6CU9Ab92yhgYbOMYgA7jF5zaPWBaitH+Y3PCltNZ1sxK/J?=
 =?us-ascii?Q?Q8B2UjMVDdcbLRqBS6FaDMS4jLeppk+OeVsUxzD/wjd7IxRRHCnoYZX0QkBj?=
 =?us-ascii?Q?M/Tj6ZL5QU1SsKqnTeZQTrU4aA9zbZMq09EG0ul8Rr2EJnbr2/YugjfW5Rgr?=
 =?us-ascii?Q?5whPp2UduJM6ZeB4b2j4emD+Ali3sqNVj72UWI4jfD7iqeveNCxAT2mLBLsj?=
 =?us-ascii?Q?IZyfQsmK5j0cmfA3+3y731Yr846bL4qHZYF/s3qzMTH5rTpGEV3liiN21M9m?=
 =?us-ascii?Q?Afc3IP5AgLRR42sZxiH2CpUyiAXWYuCAWabMD2+ZMeVm5CtlwPL16j7bt2qo?=
 =?us-ascii?Q?NVOmPwuEw9EG7FSzpgQV+hggS1gHuxhcqK+HEUTDCDRCbOP8z0bWhsJuphoP?=
 =?us-ascii?Q?c2sMxDER55cUoeNSKSH1vd2U0goiKFZhtCjgtm+mcQutaf6yhT3FMtKGh7Eh?=
 =?us-ascii?Q?pcACmsSw53qP8064D4Sw0lUeRAHMajl2lQUnyQ/vd5E11TVi7+PLiWsPNT3G?=
 =?us-ascii?Q?6aJj5DgofcCdBeDt6NOfrlWBSTCh3y5uzYzmhZkD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591731d0-5500-4e46-2b7d-08dd19f31ebe
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:50:14.3111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS4maZgZ6p33+Do5T7WrHiuMHYesGD5t/zcFWUZgk3TLSPHSVxHAsKWa98kmOCAj+SndfUKbDp0Ax2mz/KbaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150

On Wed, Dec 11, 2024 at 11:32:38AM +0100, Jonas Gorski wrote:
> Am Mi., 11. Dez. 2024 um 09:42 Uhr schrieb Ido Schimmel <idosch@nvidia.com>:
> >
> > On Tue, Dec 10, 2024 at 04:28:54PM +0100, Jonas Gorski wrote:
> > > Thanks for the pointer. Reading the discussion, it seems this was
> > > before the explicit BR_PORT_MAB option and locked learning support, so
> > > there was some ambiguity around whether learning on locked ports is
> > > desired or not, and this was needed(?) for the out-of-tree(?) MAB
> > > implementation.
> >
> > There is a use case for learning on a locked port even without MAB. If
> > user space is granting access via dynamic FDB entires, then you need
> > learning enabled to refresh these entries.
> 
> AFAICT this would still work with my patch, as long learning is
> enabled for the port. The difference would be that new dynamic entries
> won't be created anymore from link local learning, so userspace would
> now have to add them themselves. But any existing dynamic entries will
> be refreshed via the normal input paths.
> 
> Though I see that this would break offloading these, since USER
> dynamic entries are ignored in br_switchdev_fdb_notify() since
> 927cdea5d209 ("net: bridge: switchdev: don't notify FDB entries with
> "master dynamic""). Side note, br_switchdev_fdb_replay() seems to
> still pass them on. Do I miss something or shouldn't replay also need
> to ignore/skip them?
> 
> > > But now that we do have an explicit flag for MAB, maybe this should be
> > > revisited? Especially since with BR_PORT_MAB enabled, entries are
> > > supposed to be learned as locked. But link local learned entries are
> > > still learned unlocked. So no_linklocal_learn still needs to be
> > > enabled for +locked, +learning, +mab.
> >
> > I mentioned this in the man page and added "no_linklocal_learn" to
> > iproute2, but looks like it is not enough. You can try reposting the
> > original patch (skip learning from link-local frames on a locked port)
> > with a Fixes tag and see how it goes. I think it is unfortunate to
> > change the behavior when there is already a dedicated knob for what you
> > want to achieve, but I suspect the change will not introduce regressions
> > so maybe people will find it acceptable.
> 
> Absolutely not your fault; my reference was the original cover letters
> for BR_PORT_LOCKED and BR_PORT_MAB and reading br_input.c where the
> flags are handled (not even looking at if_link.h's doc comments). And
> there the constraint/side effect isn't mentioned anywhere, so I
> assumed it was unintentional. And I never looked at any man pages,
> just used bridge link help to find out what the arguments are to
> (un)set those port flags. So I looked everywhere except where this
> constraint is pointed out.
> 
> Anyway, I understand your concern about already having a knob to avoid
> the issue, my concern here is that the knob isn't quite obvious, and
> that you do need an additional knob to have a "secure" default. So
> IMHO it's easy to miss as an inexperienced user. Though at least in
> the !MAB case, disabling learning on the port is also enough to avoid
> that (and keeps learning via link local enabled for unlocked ports).
> 
> At least in the case of having enabled BR_PORT_MAB, I would consider
> it a bug that the entries learned via link local traffic aren't marked
> as BR_FDB_LOCKED. If you agree, I can send in a reduced patch for
> that, so that the entries are initially locked regardless the source
> of learning.

I will give a bit of background so that my answer will make more sense.

AFAICT, there are three different ways to deploy 802.1X / MAB:

1. 802.1X with static FDB entries. In this case learning can be
disabled.

2. 802.1X with dynamic FDB entries. In this case learning needs to be
enabled so that entries will be refreshed by incoming traffic.

3. MAB. In this case learning needs to be enabled so that user space
will be notified about hosts that are trying to communicate through the
bridge.

When the original patch was posted I was not aware of the last two use
cases that require learning to be enabled.

In any scenario where you have +learning +locked (regardless of +/-mab)
you need to have +no_linklocal_learn for things to work correctly, so
the potential for regressions from the original patch seems low to me.

The original patch also provides a more comprehensive solution to the
problem than marking entries learned from link local traffic with
BR_FDB_LOCKED. It applies regardless of +/-mab (i.e., it covers both
cases 2 and 3 and not only 3). That is why I prefer the original patch
over the proposed approach.

