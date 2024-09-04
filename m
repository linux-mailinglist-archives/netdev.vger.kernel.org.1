Return-Path: <netdev+bounces-125025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562D96B9FD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1982285EDF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C101D2213;
	Wed,  4 Sep 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kq+62Rkh"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D431D220C;
	Wed,  4 Sep 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448430; cv=fail; b=gUbHS9IcTSsyUjwk26RRLyRu812Sv6p4VDu6ge9rANkgUKYN5iuCj7xKdwcU0VmiBtN3PEoVhp00t1qTqvMnCoI8PUA6XJYv5At6hDe5af3vz+5YHOyQTRuD9KaEevkEeWBXiCUIEH3+UL0FTCCOfNue3AGTUIUrAhu1z7moTH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448430; c=relaxed/simple;
	bh=XqEkKxHo/HOAM1K3o9LnjzRgDiQCx0DmcIkzbO6iBMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5akbHHyik5zG2Wpt0rDYLJpalzgJVSLHQgNT7rkICTJ1e7FPS6zmfqGbPyNyAfLG8jqLiejRJrlcmCVeZGCnf8SlEsQEbMMrChd9XHSh+es7Q3NJzSDa3/I1glFMTwYqVexy++bTbiYTMjjEKmw0u8JZUj4fvPzYSNVJGOf9oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kq+62Rkh; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7D0uiBS6HPls2qe9LgfGhlZkjFR25jf/iF8OhCsZ5BZCzF3O5JhMEyiUa4kXQsDoMklCqqO2f1TQU8AvxmOAoZUZxX9mdkN7xX7Bi862rDNEmnJvmm/5lmNimQXzmhQqZe6OGHAdeFebqVO/z0QbZTWB2Jpj2Lg/KGKaJOmiQxnJKk4H4camYOqBEgxbzL1wP1mF/DIH7oZiAW440puyH6/rpaxA6tLR+5dHiLO0A5FXfPn+Tgkescifwf2OhshlgiL9VYdkHc9EjJUeSwfoSyskJlMYWhRIm4X98YHg18lgcI9Kn2TsSbi3QssSBNfrYk5AZ9KNiY0Ehtz0pTEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkijb7g1+LrQ/ZN68mX920LH33CzwkELb1Bo7LOjM8c=;
 b=kXM1uERRI5WlGHoJV3YuARlGpgvPJ7R6KTpmxA7/rpLABGXtI3Q0ECzPvC6OcWgengceAgzbrTMSekjBbM/DeyI9lLia+OIDNYSYlhd3uIu9uor7riNS19TbLHKsOQHAvWYrdLp0u/mj9syVtASUDbWZBddgX6LPS1m7meCMxPljtmOIFc1Tad8ZNYzEWs4vHIjGwkV9aflfOMArf1WveJ7NK4F495wbYuoj99/6nRIqrcBmaqg4eehi+bYyKdpRX2g2q/DrSV8/3l3Qw+cUN4KoZtTHqY+GL25pGj7aPHTiLCEm7OYzb2kzDuQDBVcBs92Hl0BLSvML8rK62csMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkijb7g1+LrQ/ZN68mX920LH33CzwkELb1Bo7LOjM8c=;
 b=kq+62RkhDtnj+9Ryc5GC6ymFaM/njOnFlviMr9MC/q5ASFv91vLLnZpUv5+SIhydGhM6AmzMU8vHP8ZvPf0hozRAGS+Le1d61ktVwtFC7g1zlyDYoV3iMTyk1tpuvT7n2+KNbCnobgzc2x22yiA4Mw2RG98flZCcClR/uHt0cYCKFr3FgmE9r/EygUKCpuZ9NE5pfJPx67KwzvEkdAAUB4v1uS5gnXl9mFOXKW4NLVNVJjvxdpvnwyVLWrOTrgnZh4ESio5M6wPFyHaK02q5TVWBE3rh0KaMFzbrcsPjPicqSaDiNYKAFGPCzbxTgHXEEggzUiE1f4x53Hjd0c5unA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10517.eurprd04.prod.outlook.com (2603:10a6:150:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 11:13:45 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:13:45 +0000
Date: Wed, 4 Sep 2024 14:13:42 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Martyn Welch <martyn.welch@collabora.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240904111342.2lboi53cl4pav4a5@skbuf>
References: <20240904105143.2444106-1-martyn.welch@collabora.com>
 <fc1afd33-c903-46ca-ae4f-4e9a1c037023@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1afd33-c903-46ca-ae4f-4e9a1c037023@linux.dev>
X-ClientProxiedBy: BE1P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10517:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ef55c4-9cf8-451f-3365-08dcccd2a42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XyUm3SRWdXEHxdbUH5n84PKuRi4b2mKTExpc8bDclzvqU1ONSHcEJQSjK38d?=
 =?us-ascii?Q?NTo05LBLWqz+49rsxrhkgr+8WuEj+bcCrEsYN2iZtszMN4k9cEcmSCY/qFCK?=
 =?us-ascii?Q?ldJkTHM6kgdqinSu7H9BIoDyfGACNRvMqz8Mf40Pb5IjfpO6EvYSnXXf3BHc?=
 =?us-ascii?Q?tSymOlBqW3pM0H/2WBGGjsPRcWKC19InkA9AVeWoxeATlRX1rQ6LIQ+hcA5m?=
 =?us-ascii?Q?AWzXYPc2L+ryKmekh6e1eSaW3iaMlVUM0iFB6ksdcstaSQO2aRZVhXdtgKRS?=
 =?us-ascii?Q?F1AQfjyIEUpBQAOxj2vCcwrJk1t9fdbwxK3EfWj8o9DNrpMU1YKUAU2NhQ3K?=
 =?us-ascii?Q?UDOHjuPEfvSE1UE1Xe0DqD3ezuwydKk50kirgwrqqaiPWbY2wLp8bDRmCZxV?=
 =?us-ascii?Q?drvUx5ff1Yz/bczXVHICldLb3mN7+TWxn6bBDhWLmXKrMKtINsI1u8Yss8CJ?=
 =?us-ascii?Q?k1wYjqk/6j6GHAaPEx2HTLnn8OWhq3JKSxp1kiSBRZoA7YYEFzzGj0WplC26?=
 =?us-ascii?Q?9/vuVw7owJ02qdFepBE1i+oBgFVhz6mRlpkMGCcjSRukISCtRnw/QPcziBSx?=
 =?us-ascii?Q?+p5Q2qGB3gbo+RCw2u/QWQcKpkyT1kEzhWkwysCAHF9b+Zm8MyrQNpHgXK6q?=
 =?us-ascii?Q?q6uFntPplFOh/G10MMs7rtul7AKEhWksnAqSIMIKaCuo2+2OMRiGRWkZoQSA?=
 =?us-ascii?Q?/0W3bGEabEyxOtZgQGO3R4PR4ZnqzKsk82veX32ykJ2JbpnHC1sRRQY6Pfsm?=
 =?us-ascii?Q?HvwwUs26ILuWxWLyhZ1IJJRnlT3vyzl/uQeTmDTB4g8+SJCd4EPYhvWGn50P?=
 =?us-ascii?Q?5RE5tEeybqEZa85AR21QhS4Tcl/mn10FfzaG/4/Crilh66opRSZfNaXupAWw?=
 =?us-ascii?Q?3DH88tLd3ZqoxuU+F7tvk58sXMVOczkplZV6kwtmSFHq91KCqz4YGHL4ytTG?=
 =?us-ascii?Q?PhmzspKalme+UQUGxW78ZNz6z39TdPR4ukAtKtshJZc/YZ4QaMBR2O5q2xK9?=
 =?us-ascii?Q?c1qf3vqJtf5yq7IHZDQ2bFFt7F4oS5DNIw/IffSi5C6vpL2nU2kiqfK69yJ7?=
 =?us-ascii?Q?c6RZ3JnUq9mPnnb3spdvy2x+8U8gQH4BeSOEMCcXvZB/mT7aCsn2LSgiUSA9?=
 =?us-ascii?Q?4osj2GdSF9lcw5hxCWDkkbhPCaiyndDiKIn2Jo+sz69AFS9ZrvEGw5LS2EN5?=
 =?us-ascii?Q?atiW5uiyP7+L1KpsAipaL3uFTu8fNdGjlKH9CfTppw7RMOUz89Tf461muxtj?=
 =?us-ascii?Q?lBU089GMC6Q6dbmIVtYbRLElw4264Qv9M+yw5hVmWRBZiHpo4OG5a7jKOZ84?=
 =?us-ascii?Q?LsHqgAYOdOci78iUO9nqYVDylHDDoKOq6e0c0EXpBBTgTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4av+/+BnED5TD+Epw+NS8TcmNzgzIhcnSXlIuZ2obqxeZ/qCaZaa/McyF95o?=
 =?us-ascii?Q?/Ptwq2JeGgXZKQi04GDIcT9tdJvO48owHlHHSfPOplvhW3DszsVznVZ/3R4M?=
 =?us-ascii?Q?j8edbqebN76FVNxoNzye6IIN2mS4GO8doYDEuzwSRa5CJW0k0p5PED5zVILs?=
 =?us-ascii?Q?Ry+SssYaMsUTlFNV2H0iQccl77atws5foRsVvmDNYoTsaEmDp8G31EzgCk3A?=
 =?us-ascii?Q?jU2UUITrS9NX9qG0oke3TEaeLbpj24j/NOTPjqDOj88sKtJdg4+8dIMhGemt?=
 =?us-ascii?Q?lDwCBnYIgqGCteOUxeGsgEChT1t92J09GVlzY2JFCH1D3B9cB93/EKRrdxiP?=
 =?us-ascii?Q?lx7WXmdSVGc4tNpWQnj0a9Sq0/M7Gw/jzTr2GZ+aHENUFLg2TGeyruHo+RvB?=
 =?us-ascii?Q?uEPbEILE8k22Gkiq0rEXzyAUPM/26DwP0GkHP1cmpDq5LrVPQ2XJ08DZkuyw?=
 =?us-ascii?Q?K4Yx/u5ey0vlTTVCWSVczhHeLBXgWL2VKmnzmm+9aEejAtgScLzJr1Rfgffr?=
 =?us-ascii?Q?4b7peCp3chKzO9qge3CHv1fkjAOTgOObQcPhBvlZMMN6PvIPq1+yRa2v+x/F?=
 =?us-ascii?Q?U8PVeE0g0CyQcsPpqPG0F0Icg0puJpKS0UIbFr7CMVck4wKEQVFXzFmRec7p?=
 =?us-ascii?Q?uUz1SoVlbY8/7u3ypnFobgRSzjKB6l14ZA2OGgD1ErdyAhpsdPLvOIqkDPpq?=
 =?us-ascii?Q?ulmgxBuhC75lIfAtEgBPalAwGAQoa/Z8Z/spnIguUs73OisTLWL2lS7n3Vk+?=
 =?us-ascii?Q?iskUPZhy3L113C0iYLNWITEbPriuJUn0GkwAkimzvsLY55UExmy12wpA+4si?=
 =?us-ascii?Q?kwSwoGfcGyva1eM0lgXaVhKIxlxrawDH/7tFYWLiDSz40hI+6hyyASCoDGf0?=
 =?us-ascii?Q?fpGGJTDUdFXRpZhOJ9LM4oFccj7QeOxLb50BmTYjV6DajywlScLUv5Ogpyxz?=
 =?us-ascii?Q?4ibzzTtMmGPYjQ5YkPX8jkTyKEtlcQWhgC59oyttl1o13o1JGZ1n6RFTkkyK?=
 =?us-ascii?Q?8NOwPWn3buKv6vkeqldb1RFF51QBgujK5X9cpovjvExmfKrejieAb12hUgnT?=
 =?us-ascii?Q?AbZ+wFu/vUmxSlrz1iLMYZzjxkgHDdLJCD0p5Kojw3AW/kgsGkk1tGfccOmq?=
 =?us-ascii?Q?10sqL+T+zGQd76pk5EPiaExsZki/gLozjYDrmQjUDAgpDIPLTgUMIAb69BYE?=
 =?us-ascii?Q?ZSKCJ5y+g4cBOMeO6ZyUjh4VdR4y4Aix59JpLRVhb3z06ddE/OVK6WNVSscW?=
 =?us-ascii?Q?qmCv0QicLZjgtt8Vi7dnW6JoXt3ywMVMlWnbsT/1kigCPDaYh3tVV1fNXNR4?=
 =?us-ascii?Q?mchrfpjkuoUPhkYS8ZRoc+9yrNMSw/wfuDtruYiyCUGBqvlzKgKfxYlj2RES?=
 =?us-ascii?Q?9escLUqkH8dekz8HemblN7GaywNQCgYlaa6JznVXGeQtXDRidG1CctBC2ue8?=
 =?us-ascii?Q?qZ4QNQUb3DRZM/syzujZCgfxZdrx1koieDgSQ+xyuucnSq7vEaZ6m2y4p8KQ?=
 =?us-ascii?Q?3htn39X2PVTQotXtbf1LLPsXwnOHd7dMyW0W8GwoQKoQYb3IRtXDzkcpaLVl?=
 =?us-ascii?Q?YcH4LId46kTWVpSuFv7pzRitP6YgU3Fk8sBuuWBis3mc9cgwFLkQETUusmAg?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ef55c4-9cf8-451f-3365-08dcccd2a42a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:13:45.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLd1pg7kOJwvbv0/xrkc1YgH4G3g91o4nXqNMqD7tf5iAIiGynPDbidNwpSYyo4stTUrQTmlqSVm02drrvM8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10517

On Wed, Sep 04, 2024 at 12:11:31PM +0100, Vadim Fedorenko wrote:
> On 04/09/2024 11:51, Martyn Welch wrote:
> > The enetc driver uses ifdefs when checking whether
> > CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> > if the driver is compiled in but fails if the driver is available as a
> > kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> > macro, that will evaluate as true when this feature is built as a kernel
> > module and follows the kernel's coding style.
> > 
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> If there will be v4, please, put yours SoB as the last tag after all
> other tags.
> 
> Thanks,
> Vadim

What's the deal with this? If I give my review tag now, and the patch
will subsequently be applied, my Reviewed-by: tag will also appear after
his SoB.

