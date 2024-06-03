Return-Path: <netdev+bounces-100036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645218D7A05
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C552128130E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34F4A3F;
	Mon,  3 Jun 2024 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="kx9DuxXX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528874A08
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717380271; cv=fail; b=bo3c7WGpn2caZ9zJlP4PXXVDt6nRNTWtf3osseGrNdjmNSJgZMmYCBGTpfcamgD8ZhBLWrv7dOfWhzh8uDV4N+wurIAve27eDCYn/x4ZEQ7yuWjcHmNSSbLbpW0wRD0Md7Hb02X0h4UNN5RG5sRPyiByF+T0N6XBZAyx/Bey180=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717380271; c=relaxed/simple;
	bh=VQ1M4nGvF4lGpfCqAiFIbT8fpkuFtOOEXE/KNo7g9Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaxRDfzmbt+r85YPdSKSstcd55UDiA86MnOncds65nrL3R0t5wiuzWYpl6nz543Zf0ow7nzfTz4wwuuoYb9bmZ+kXAJUrL9q3gP4BlGO/N3Mml3Q/+a6aIiNCbe0pRNPSYznrqJc87VVWo7t3cVbnsrMkRojIFudQG7/5MiH89Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=kx9DuxXX; arc=fail smtp.client-ip=40.107.94.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFunUGeKuMavk+y/Z+KDyPxecxwhL7FUIXy4AhTTS6IAgPmEJgGlCrca0y+b3ZvK5AkmQYPFrqgQLK56jrb20hULlohYrMr6PdVHf2e9CYTa7ptQMB+OldXm+9UbyY1PBlvil+66pnsOtQrailSLPslnYtVG58m071VsjHTE3qh0TSnbnARpyPhjp3C7AasJ4UUHOnYKvUUu5E8TWtMVNBeOlak9SzB1bk4DZEFrP+ANOTppHTfujRwzyyEnfWOLwcU5TKi8pm35Sqszod1MmD/RXrndFCdBnrhyr8T8PYfrjHWNehG8NFUZ04kMv8RonPixvt3hWjcttU0Gl8qg/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBp6EuGtxMg4a5yACmWX58lFo0mHM0nXo7KHMvZn7t8=;
 b=AhpKRLRvTY8kcp7B8Nnn54SRWEvwXm6mhKM4+XbLREkxSUODmI4XsjYfHY73zY3+nXFhIEZOfZzZgl9WSy7ZzuH563z7OhwCEXras1lv2lIKzlbQYkHSkGOO9iORQQdDlhCbKY8jzDYTOJ8DB33OrDOvLAG4idfJ2zbQFGu/vPfJj+/jCxdt9V/8CP6g6D8jk+b21EDIHD7N1iL/7PAA7aHAYFVrSv90oJKLE8bRumfsrzMhl4dPeTWhHGv+Wje4Lxu2nfOlN1wR6pB9l0EvQBiI/SuMHcoKFtu6iWcmYHH0uVT9a5EEJX3V+3qKK8En2QFMHC0ewo28tHTyKWywEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBp6EuGtxMg4a5yACmWX58lFo0mHM0nXo7KHMvZn7t8=;
 b=kx9DuxXXIryYN9C21rOjJqNFv33omTMdZlehP6/817iQc1txK2hBh9/gILWfY/zYz1pP6B22BoZxfEhM5ZNLaBl5bhGG2lLoeVnIoeKpOQTQN2hovtpWDiktmw7pqdCHNQZKSbrnWn0aOSuTC3ZRbABFEkklQujalcyjrFtqb6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 02:04:28 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 02:04:28 +0000
Date: Sun, 2 Jun 2024 21:04:25 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 7/8] net: dsa: ocelot: common probing code
Message-ID: <Zl0kqbWp1SJYjzO6@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-8-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-8-vladimir.oltean@nxp.com>
X-ClientProxiedBy: MN2PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:c0::47) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: ce33c5b2-d609-409e-d3b2-08dc8371802d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YVdJZGTJEYcJ8i5yC9WJNoMiWuDXdyoKCQ6QqXiy26+rRyoypiZOE7s+5jKj?=
 =?us-ascii?Q?X38vVTQEBRKrC7gTV6O3HY0ESyzh9Thv6A2Sj45OPF5FtXMxpwf5SFiWwHpt?=
 =?us-ascii?Q?bd5H4Xi+CylQNA5w9lBPMnjyZ+a5dupvZhU456YaE1Q5sZ3N6jsMsEMsPGDm?=
 =?us-ascii?Q?jN+Zh1Gt+mtdou6AbnOZ2tdkZBoTSnPEAnL2/jT56+iQlkzqWhSjKJ/JDt07?=
 =?us-ascii?Q?m/huAfcTScTr//Qz39fI8TZ016mVQBdIGtmPaoeKg8MtCU0cFY6XNBWqISRx?=
 =?us-ascii?Q?9E2ZMdrNrLQVwuKyATO/d7RMu1hZUUpq5A4NlGCDtg3lFfSajqHEmidEUHx/?=
 =?us-ascii?Q?hrADdcWR/QnxPYxfmgtmdvIoLYBf72s8Wp5pKOIyjgIc6UjrMuxX187nWI4B?=
 =?us-ascii?Q?/ZqiZyVenh7wdshRVg9YfAYZ33JyRgBqaXd/rVgyCAceuIZfh8BR9DeAwI9v?=
 =?us-ascii?Q?AAtnagxbMd0IEqrtGOEGTwvUll8HQGBm7L+nCWmi/zEEp7He+i6Yex6RK5wX?=
 =?us-ascii?Q?YBukgWwvh8LhRZYvQ/q68UQCgKN7xzhRsq98JFsop7Xo6AEW1P8zwypKqxBT?=
 =?us-ascii?Q?mzO97aPP+3tIsQdpYRNHSfWijEWigUtnf5CnJFtlzbGUc5ULWRZMWGDUYV2Y?=
 =?us-ascii?Q?7bGBUswmtYTu8rH3e4fgRDqk4ssU6FmK1hRn9Fj0PY3BarLkD12+LSc/Ak4Z?=
 =?us-ascii?Q?86P98M3VHQPltsVa6zs7081TsKYVLqG59mnADuY8K53fO8dnwv7dGzZ3eWPG?=
 =?us-ascii?Q?XNeC4WFHO5zAEndEoKCRR/BKMqHtkIJ56YZ8pDJ214swf+SAolX/jrjqvC/0?=
 =?us-ascii?Q?G3iiBoZaztnvi63hybbNpDCzfButpxkoQYxqIWolSKm5EZvTapBoqu2XDqVX?=
 =?us-ascii?Q?R2W2PCjZCqKHQIQAHkN/+RP5QEmQvAaHsVa2JI7gAZyM/bE07D+qH/aTKG+n?=
 =?us-ascii?Q?XrW1tr4S65lAk4JY5Zu46CXPilzrIFbxg97gf72QZNbHjJji13Qeb2wUvxkH?=
 =?us-ascii?Q?+NSi7i8gSSOE9/yDYDq3nnfoT456zgE903akr5uufRi9YTXKb085ZTOEPmm2?=
 =?us-ascii?Q?cnXPNNAhMBGYUa3zZRqDN3s9pt8CBO3kGsbq0IG1Rfvpi+QYi5LS4GgvSPSa?=
 =?us-ascii?Q?5IPBDwU2Jh6gcz55XVBnpjtNMqFLNCp+TKx3onYafM9L3FIg0a3Dq2D2pgQz?=
 =?us-ascii?Q?py+YLIb+TRM7fY6n5jstOrybVubF0+GGeR8Z0jeJRh4qSCeenH28ygj8/F0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrcT9y1/RzZc+ftPxIN3IbGdc3QnnFAMfkQRm9NsoEqK3xbYLM7Hu9YpqtPm?=
 =?us-ascii?Q?QYORgbyYMKzh3CvXRkKuHCSbO29ZRPUWwbuOJpt+EnvlIufM7AwBzl9+x+Kn?=
 =?us-ascii?Q?dtdVqhcEnOk0hdHOa3Ii3d4rC8QhnMW1tr/6LVe7WBc01eVF9LR6w51MtTAI?=
 =?us-ascii?Q?uCXheCz9hvkdnfMhbU6SpjIHWSzeR0IfjMU7nqwPcmj+SClVDai372XBaelj?=
 =?us-ascii?Q?aj1x3gzAYMv/s9PPggLzYk+pLxRN8KF59VXFRtvm1GA5wYHabzWLOGJn3Neb?=
 =?us-ascii?Q?FeSEeVQMwtLIlKDWONbpAXvJgOovHPTbn8FMeiYuMnBv3Axv+ftZ1V3G0CQ2?=
 =?us-ascii?Q?BTg4cjVwntoVRNV1lzMYGEjTvr/9sWGlpIv7nSVJmfBblRDngq0QVypm6yA9?=
 =?us-ascii?Q?SH8hGlaqxWrkKTsggXBxpSWr4SGLocYfDkuX7bxHTdwt8zXp6PuSlGOlF9fc?=
 =?us-ascii?Q?mx+hAkNli/F1x4S+iG4sg1msHAM2F3DTG6xsPRJzS4d8Ry8E5Aa7zNGYqA8P?=
 =?us-ascii?Q?F+S5ZaadKJ6HkFphP53q0nrd3192517KourVAqqNUX4o/zLyuMJuLJs+KyQs?=
 =?us-ascii?Q?4Jc/iYolHR2FLhGS96F28WthFSgl7fcNH0FSkxwZn0YkLAyeGSSFrl6iYmoy?=
 =?us-ascii?Q?MOK8ar+SqgLS3i9YFaDYV5fVNPRp9yVR2Ot1lEARXJ+8l3WBMREO69wrW12V?=
 =?us-ascii?Q?ckQ5slfZwWoqp4le0g5m+WIJ/QJRyvcQSc/N1zqQv1omBPCIWtMIqVITrrYM?=
 =?us-ascii?Q?UBBVs/rf7oMdlkR6D9OHzg95Vo650IlR8Ieg62SiGaRANxvrZCpMj9fCv70J?=
 =?us-ascii?Q?REeW/sR5vHFByTnUrsyo1azMM7o9f4icxulDa+7BVuS1DV2QbK8QZKmrCJ97?=
 =?us-ascii?Q?AkBovC+AWlISun0dyTIF1BLgqsk74D6Aho3RZCT2avuK1nyZcgA1KyZPsGAM?=
 =?us-ascii?Q?5IczDzr8HQurWP82felvakVo2V1xpff/r3P7KMPzkyVVg7Krb6Z0UHHPmoCN?=
 =?us-ascii?Q?r3dUWRW5PWGfCxxyEORWVnqMcunf8+XYCCz5GPqJoDJKH0m2T3dMLRajAh+Y?=
 =?us-ascii?Q?h6D991CytqJpAVuSKksRqTRiDCMae+6hKYtvSQpfa6i1N/88awugtj0t8/u+?=
 =?us-ascii?Q?4F5mY1bDzaInbxUR78VOv/akL7rXgnLLAxkNeeyj51weaiNsaFviMJdMEjv0?=
 =?us-ascii?Q?ALYXfEiXqrImVjhgx6lIvbZE408kaYMMHS0xjyQ34qZ75Yi1E+ZN2g71Csif?=
 =?us-ascii?Q?9qPGiY0oOxtaI9R+2Etu0r2dQV58Syydsff7oMbC8iacCJ7S4kIvgBSECA9H?=
 =?us-ascii?Q?w2cb8jd9O2Ot752ExrEl5VbrCDQ+x82zT5xGK87PyejSRP1Ei7OcdqvFu5fU?=
 =?us-ascii?Q?hxq5xCFH6EFTwNaSoNja03UtoQv8vmttf6Frt1QdETNiVLPGPlEJpt6ihYpy?=
 =?us-ascii?Q?hccNLsLhDVEXDBuN5B5caMxlNtmFI6xMIU04onb2VZXysAHWl7UlUsjKoL5q?=
 =?us-ascii?Q?yUzzmPKymcizyflzRwzvGVKlwhZpxCUEO6lJmpPztKyt549wp5CDdTIKJaOO?=
 =?us-ascii?Q?r5V+GNdieN1P90pjwJUhTjT9oqdoDxdu7QcinOHa6ViXO+0k4UOAxyBNir+3?=
 =?us-ascii?Q?GBHJkfDs5suxPW8SkRSu+hw=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce33c5b2-d609-409e-d3b2-08dc8371802d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 02:04:28.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsphJMaB8rFYBU4OUmwSl5TBbpXAM6z2mXqE9Ej3IMCe3gJ/K0p2xB76XhQTUklR18sDDf3w13DHqNY3Ezq9daJuJp0cMq028FDFuGvjAgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031

On Thu, May 30, 2024 at 07:33:32PM +0300, Vladimir Oltean wrote:
> Russell King suggested that felix_vsc9959, seville_vsc9953 and
> ocelot_ext have a large portion of duplicated init code, which could be
> made common [1].
> 
> [1]: https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> 
> Here, we take the following common steps:
> - "felix" and "ds" structure allocation
> - "felix", "ocelot" and "ds" basic structure initialization
> - dsa_register_switch() call
> 
> and we make a common function out of them.
> 
> For every driver except felix_vsc9959, this is also the entire probing
> procedure. For felix_vsc9959, we also need to do some PCI-specific
> stuff, which can easily be reordered to be done before, and unwound on
> failure.
> 
> We also have to convert the bus-specific platform_set_drvdata() and
> pci_set_drvdata() calls into dev_set_drvdata(). But this should have no
> impact on the behavior.
> 
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/felix.c           | 47 ++++++++++++++++++++++++
>  drivers/net/dsa/ocelot/felix.h           |  5 +++
>  drivers/net/dsa/ocelot/felix_vsc9959.c   | 44 +++-------------------
>  drivers/net/dsa/ocelot/ocelot_ext.c      | 40 +-------------------
>  drivers/net/dsa/ocelot/seville_vsc9953.c | 38 ++-----------------

Tested-by: Colin Foster <colin.foster@in-advantage.com>

