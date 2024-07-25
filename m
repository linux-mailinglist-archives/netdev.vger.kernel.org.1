Return-Path: <netdev+bounces-112945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838D93BF8B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03141F241B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795E197A7C;
	Thu, 25 Jul 2024 09:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gBin6fkY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634D198E60
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721901527; cv=fail; b=VO30fFIej3Z/31y/cUsvB0rcBq/jK7wZeFnP1deL4rRSXcxTemlXW4S/BrmBPPE2+lQurytZaur4yl4ecAmE/7wfkr0FHbvjzJRTzfevSTx05T9xadDM5eZN1/3YxAZrk3FvUCgyqyh9liw1KB4r4ABXeVQtEhS9XFBNRzuu6p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721901527; c=relaxed/simple;
	bh=3ZsyiqQeZouJ3RBybtNi/fbSkOtOiY284wnE8O/pgIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+LBwL3+1xBINR9flghzbVt3Don6Yp7arLoboKAvur2vRhUDQUPkN9qfAkrP9gwx++khLfApqjoXRY2/9NKYNTIi4BEx4/uZIGJgU+POOgBrSkZbZkZoiA3BzZWicUOzCWlolj1JJuxY4H0LBjICugxtjTnkt3pg7CayiiZztPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gBin6fkY; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkvA9PIMkRN3XtI6dFngyYYaUrI86w6SDcTxC2nI/LT6/kPKnTKEsFFN9CGmEhSMr0JJuXB4gNtHl3kw2yuNLWAO2vdoZMRHQfuVRKNPmdbutsXD9sVFQnWdDuxlyuwaprGRxuPjp04RN7Kv+H5X8ROOzilXVd/CRZaVjG/H61XDIoeLn2kd+t70hpDZTMJYcR0dxRs6+GzxGlOwKUmbnQkXLFw21VnZrQr+5a28xx6yCoW6UdILnSCa+U4B7ivt1bPkutq/IGnR36RvugOW4Sjn9/NuRy5LQV5I4nGSEVtc7qxHc/oAET0EKLUnDFc3Okx3NRGIrRfJTylEbYCsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmK+3wroZ/czh7AdsPhp9BupiHnaXtXsAKolS3UawRI=;
 b=aYd2itbhHZU2fHTTNV0MgZSXZ5jaAH+YaJWHUV/c4wWszAy1FIfDy1VpiOp0RR00hjeC/SE0bUcMggx4Ot+MJr74mymiikG2J5a7hzvxW2wLPOTGG+EH4hMh/N1iF1bFEyyLEJVLwGabtaosAKI+pBwXlIOhFLrFrB5F6KOLUwecuh0Vi16R7pLJxn9KpMUq3XuVK5ZJjIVYIKcYMXDvFA9yEKAg7QNPmtKqmY1ZDhaoRo5Mu//oxYVBZQHb8UoxNDXw3wcEOzeFocQl2yvigpldrTEVW9ghUI/Q+m+B0nGnnBLya7v+KBkhuLihuWFbvrdQHhTAzzFeXdq265Vr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmK+3wroZ/czh7AdsPhp9BupiHnaXtXsAKolS3UawRI=;
 b=gBin6fkY6pQwa2D3ivnoKjIV5919Nn5i5/i62VM/2N8eVYtj8kqx+bbKDM14vE9M9XmvYmAJIAnYZqzBrbmEhS+ioFueCZT0AYGXBXW9+UGTCYmUZaq3Mc0+9Z6NMXadxvKm+FNoIbQ/q8l2RiKhyZe+ZqFtO1TYaOvUmuk2C5oxNFxEoPMf+JRPdyVprcnULMcINXQ9iDfEDXrf+mTPXsp1KqGdQrmk5YrxOC/8sZNU+Q4ck/Y+5Rzt518pCh7epVeSfXRiQeymrsdsJArKT/o6BRH20OcsCglA3OpRHLX2KhlPlwc6FQHDSs8ABpAIVORuuwfgrtTgDsF+ljnMEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 09:58:41 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 09:58:40 +0000
Date: Thu, 25 Jul 2024 12:58:23 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <ZqIhv1RuZudqaUmQ@shredder.mtl.com>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
 <ZnypieBfn3CxCGDq@debian>
 <Zn3DdfGZIVBxN0DR@shredder.lan>
 <Zobnma+cQPMhIlSy@debian>
 <ZpkVIE1Pod1jrgsc@shredder.mtl.com>
 <ZpqpB8vJU/Q6LSqa@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpqpB8vJU/Q6LSqa@debian>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: be512e6c-3ab8-480d-21e3-08dcac905c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/WeqS7ZAtlv6CpppI6A4dmL3BAP8X6NUHR/VHAe9Vwgeg0getJWKrmh/ucF?=
 =?us-ascii?Q?nSIffYzFhTdW/Pwtmbq9mpRXqir0OyGSmHH7CEGrumBnzOPkaDqfdjPoRfSH?=
 =?us-ascii?Q?2QJZEBY7QYQzhdzNh6lvv7PGWC9f5q6YiLtCoh/XGMst2nO7g9mLzZLhxQ03?=
 =?us-ascii?Q?vCFE5aOE/IAfhA6SAqwfB3kdMMa++dmR9YHqeCW7WVpAK/1pD0QEMWtyuIL6?=
 =?us-ascii?Q?gpALli4vSoJDRNuIXsXK/Qlu7QzHT3h6Ft3fGAgTw2xciTy6e6x6QhfCVjKr?=
 =?us-ascii?Q?+lwWS/5iuv7xeextJpBFHjAXzN9tpL3YuyFapycqqPes7tz8oC0h/teV7pdk?=
 =?us-ascii?Q?eQ6zne/3o9d2n3eXP2D59PuY0fVb+gZfEw/xXI0sD3FXbTM13QfP7wzaoD/T?=
 =?us-ascii?Q?j4o/A9CDg++orEogu4Qjc/M+tYeUWmpzrbYlVF3PGsGuU2QU/8xQrXEfa50i?=
 =?us-ascii?Q?RuV4WROterwaxdTExgxKsOLzrVnXBJnhpkpusCacUQkAWv4EQ+Z6ZtGJau/E?=
 =?us-ascii?Q?PRk8MuuxyWHVKnHqALJgQahVB82NG/mjA9NkL4dU2KpkMLOfZczfKGKcrb1e?=
 =?us-ascii?Q?T7u2DwOczqE+uhWUkd1ZYSks01/UkkltUZtxKfxqBP9sVOqKYB2K2LhiBCqJ?=
 =?us-ascii?Q?pp75zvq2ZKrLYQ1Z1WK8CeOpHHzYwmb4vDs3neZGBGHFv892xIvq2ckYB4Sm?=
 =?us-ascii?Q?kNKlTHtdRUZA8tfHaB2NhDEFWWnE0TkPTIvFztEeAyvcj9eYxeeUPlDLdcxe?=
 =?us-ascii?Q?gnan+kxgXOXZgFQYA9zlDWY41I/uHloi/fFSnAGKN6iPISRoq3Mdm/Y29EI6?=
 =?us-ascii?Q?TJNrP1FxXQPY/n1dvPYKpl5RCvE6qQbm8aMbKBjRKdnpt+7042jk43mvQmZ1?=
 =?us-ascii?Q?MfCNwCzoMQun0CSKTr7BZqvuHFt2NvrWblIbFNxmJF5FEkyLf83kaJQezBnV?=
 =?us-ascii?Q?hQZOzr1+Kihf5MuxKbiCMW+RUe1UBJvSzO8f+DGzW75f2fvSS4/zZsPW6IKg?=
 =?us-ascii?Q?Zfxfcp59mo218DVyGPK6Qzhl5ENWxDynpsNfpL36ODfrEgemsplFUrpdmDVf?=
 =?us-ascii?Q?MPlb4i7rZ+XXitfKDWGsfxxLUj3qj3OOvyx4kIE5qZKCWKM5D/0rwnr5vqt5?=
 =?us-ascii?Q?gxmJwO8IfXofm8svTYKdYEsL+5vB991xeFFhjTlI8xgr+BfBE8tN/pvsnPFU?=
 =?us-ascii?Q?B5Ltr5yYiE0wpQCDP2mKKtN3E3Mij9yTrnLYb4CxTs6KvQLyneowuw4q5z5d?=
 =?us-ascii?Q?whDqHbpNj4r1H6zHWzzLT59z0OixmL3cgjSbAIo0TqOA0COnUya7S4NFc+W0?=
 =?us-ascii?Q?bvA/IaVrzbPj+QGveiPO48TUPZ1nkiYLRQE7ehf5kUuLHcCuJ4krLOi6kseA?=
 =?us-ascii?Q?4w+rm6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JfjyTD51VQ40IF2LXBokjrORTe7UfEPRbmU1YNBZDkORl7JLmQD2HxlNcCxs?=
 =?us-ascii?Q?0lrURI5z3FjGnyRgFslYFdcDBtVFihuP2wA2Q47KiZ+cTvB6UicVJHDxxFC7?=
 =?us-ascii?Q?7A/j5+inxe5qubh2ynYIB1EBXE0lbuM9tKa0pQ4wvo26lIlngKQQ+jpo37fD?=
 =?us-ascii?Q?8PVn+34V/rayrZgAhNmZ17AbnOdhAZviQdUu4/NygoKiPF9xbSkdL0AJeEP9?=
 =?us-ascii?Q?p4tnhUtbN2vKmIVYsp5PyMnoABRR36CWprj20iRW3vIfchLHR9YqqQTAsPmc?=
 =?us-ascii?Q?gAnycIoMZb/BeOsca67TgYfGUM2KHQi+xX6el16oxSHf9+5dBhwbRH8rw8k3?=
 =?us-ascii?Q?EjpVSTF2W8MlkQUS+XOe+68Sbd7dOH+fZ8WiYymoUbfiS9vz8xd2sxW+/mIQ?=
 =?us-ascii?Q?A65ViGZmhVcKq7GFDt5px3CAzOHnlchcS+N0lDf+vrn9cOsUYnYpMdH3zzuA?=
 =?us-ascii?Q?kRnt6zwg4MpFynTh7XaJNyNqNFRN4Kd0pT96+j4IoZNanRxXhMnTmJ/af1cp?=
 =?us-ascii?Q?NgilkcNxUEPqQxKBZeIjhuLZA8AcsdNIr1FZEVngYhNgml9FaWrOPt0dcyAH?=
 =?us-ascii?Q?/9/8ShXwyaBmjoqRazt3HU0lANUsclfXoYtI3CPxj7c0zA94Sfg+RKW3AhW+?=
 =?us-ascii?Q?9Yh5feBE0WndlD5t2Urd8NiQcuzpyvVbn6EH6cqwtY1f4nzYnhoShwF6EtBG?=
 =?us-ascii?Q?361Mp/lZLBtXJelXWNVo1SL0Cnq+rxRSBpdgxq/sA4PVYnm5fvlfRU/UKgPn?=
 =?us-ascii?Q?QSukPFfmvsT1yjN3CHoKgSb5UHtCtn9TPEUQcEDVXw0LMsiH7+3RfpOR2yy5?=
 =?us-ascii?Q?oCK+oPyvp/q9cTH2S+gk9+P+lCVQuSioUwCmj2RGTY7H6gWaWttLRzkM9JhN?=
 =?us-ascii?Q?wfvy2mP59HdCUKSPUDkWxopcMnk0GXuQqkDX/n7nNs3ShSKSMjhBe7yFGD9f?=
 =?us-ascii?Q?NKmcPpv/9ReNeGbZYiF0l8XaTgqhZ0A/7tOj8vfapd5CNSzwWWD2XPt6Mp9F?=
 =?us-ascii?Q?DovpBwh4qq+kIXu3Yv0fmDagz6kH8MU3Y3CBIv6GGAmsw6FFogkuJIcRgShG?=
 =?us-ascii?Q?yHk0nqMzKmtJ3fhct1qwmH6C9RIPjjUjgq3wzCDswaVZrScW8bmwoKKFnHTy?=
 =?us-ascii?Q?UPxtfFgIzRIK5kFOXti0dgHYXiACALzQaKY+JCpaizAZeV0v3M5hdYrwBgFe?=
 =?us-ascii?Q?fhnn/h7fiuJJ3k6QYHsaE7TtC9pw9jrUQb8g27B4/fHYxLORp6kKBx2SkV09?=
 =?us-ascii?Q?8H6WeQ16DVo4omQkS4E7RqAr98FMGzjo3cJWPO0++cdlC2/LWLsOf/U07Swm?=
 =?us-ascii?Q?hSCCd3vznQjucpkSKYt+q1c5RgV3/SgD8vlM1wEkxEKlaOxfpungkqoV7QZS?=
 =?us-ascii?Q?5YTlVxinn7gMzbyzCDiqHwj1cW7tOTCReeGlzMNjzRtv0b69NPehp9PC5zTF?=
 =?us-ascii?Q?ad4X84pDcz2NjoTRQtL/+DsG29d5vUoHv1l4+B3dUrsrpMVgO2dOVs5eCFlc?=
 =?us-ascii?Q?tAGDShKgoSHPLJxHkmpNDOqBkY5D3gGHSuWDwvw47C4DokAUi98JPAj20Qh5?=
 =?us-ascii?Q?MUOOI32vhejoWZUJkw918iSrLJ7t3DS5jLonBGlR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be512e6c-3ab8-480d-21e3-08dcac905c38
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 09:58:40.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrKm9oSYhgpYoPcTIDI2yaQwYVkrVjLKjPGOJUj+ugCupYvZTVH1bleFqzezpNMVaHAtaGZAd9wGo0IUNxWgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

On Fri, Jul 19, 2024 at 07:57:27PM +0200, Guillaume Nault wrote:
> On Thu, Jul 18, 2024 at 04:14:08PM +0300, Ido Schimmel wrote:
> > On Thu, Jul 04, 2024 at 08:19:05PM +0200, Guillaume Nault wrote:
> > 
> > > So, do you mean to centralise the effect of all the current RT_TOS()
> > > calls inside a few functions? So that we can eventually remove all
> > > those RT_TOS() calls later?
> > 
> > Yes. See this patch:
> > 
> > https://github.com/idosch/linux/commit/80f536f629c4dccdb6c015a10ca25d7743233208.patch
> > 
> > I can send it when net-next opens. It should allow us to start removing
> > the masking of the high order DSCP bits without introducing regressions
> > as the masking now happens at the core and not at individual call sites
> > or along the path to the core.
> 
> Thanks for the sample patch. I think we're on the same page.
> 
> > > > I was only able to find two call paths that can reach these functions
> > > > with a TOS value that does not have its three upper DSCP bits masked:
> > > > 
> > > > nl_fib_input()
> > > > 	nl_fib_lookup()
> > > > 		flowi4_tos = frn->fl_tos	// Directly from user space
> > > > 		fib_table_lookup()
> > > > 
> > > > nft_fib4_eval()
> > > > 	flowi4_tos = iph->tos & DSCP_BITS
> > > > 	fib_lookup()
> > > > 
> > > > The first belongs to an ancient "NETLINK_FIB_LOOKUP" family which I am
> > > > quite certain nobody is using and the second belongs to netfilter's fib
> > > > expression.
> > > 
> > > I agree that nl_fib_input() probably doesn't matter.
> > > 
> > > For nft_fib4_eval() it really looks like the current behaviour is
> > > intended. And even though it's possible that nobody currently relies on
> > > it, I think it's the correct one. So I don't really feel like changing
> > > it.
> > 
> > Yes, I agree. The patch I mentioned takes care of that by setting the
> > new 'FLOWI_FLAG_MATCH_FULL_DSCP' in nft_fib4_eval().
> 
> Okay, let me contradict myself... :)
> 
> Considering that the number of users of this new flag has no
> reason to grow and that we can ignore nl_fib_input() (which is close to
> unusable as the necessary fib_result_nl structure isn't exported to
> include/uapi/), does it really make sense to add a special case just
> for nft_fib4_eval()?

I have no problem removing the flag and introducing it only if
regressions are reported. See more below.

> 
> I imagine the pain of describing the tos and dscp keywords in man pages
> for example. There will be enough important details about the ECN bits,
> the behaviour differences between IPv4 and IPv6, the different number
> representation between dscp and tos (bit shift)... If we also have to
> explain that the behaviour also depends on the module at the origin of
> the route lookup, end users are going to get completely lost.
> 
> > > > If regressions are reported for any of them (unlikely, IMO), we can add
> > > > a new flow information flag (e.g., 'FLOWI_FLAG_DSCP_NO_MASK') which will
> > > > tell the core routing functions to not apply the 'IPTOS_RT_MASK' mask.
> > > > 
> > > > 3. Removing 'struct flowi4::flowi4_tos'.
> > > > 
> > > > 4. Adding a new DSCP FIB rule attribute (e.g., 'FRA_DSCP') with a
> > > > matching "dscp" keyword in iproute2 that accepts values in the range of
> > > > [0, 63] which both address families will support. IPv4 will support it
> > > > via the new DSCP field ('struct flowi4::dscp') and IPv6 will support it
> > > > using the existing flow label field ('struct flowi6::flowlabel').
> > > 
> > > I'm sorry, something isn't clear to me. Since masking the high order
> > > bits has been centralised at step 2, how will you match them?
> > > 
> > > If we continue to take fib4_rule_match() as an example; do you mean to
> > > extend struct fib4_rule to store the extra information, so that
> > > fib4_rule_match() knows how to test fl4->dscp? For example:
> > 
> > Yes. See these patches:
> > 
> > https://github.com/idosch/linux/commit/1a79fb59f66731cfc891e3fecb3b08cda6bb0170.patch
> > https://github.com/idosch/linux/commit/a4990aab8ee4866b9f853777a50de09537255d67.patch
> > https://github.com/idosch/linux/commit/7328d60b7cfe2b07b2d565c9af36f650e96552a5.patch
> > https://github.com/idosch/linux/commit/73a739735d27bef613813f0ac0a9280e6427264d.patch
> > 
> > Specifically these hunks from the second patch:
> > 
> > @@ -37,6 +37,7 @@ struct fib4_rule {
> >  	u8			dst_len;
> >  	u8			src_len;
> >  	dscp_t			dscp;
> > +	u8			is_dscp_sel:1;	/* DSCP or TOS selector */
> >  	__be32			src;
> >  	__be32			srcmask;
> >  	__be32			dst;
> > @@ -186,7 +187,14 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
> >  	    ((daddr ^ r->dst) & r->dstmask))
> >  		return 0;
> >  
> > -	if (r->dscp && !fib_dscp_match(r->dscp, fl4))
> > +	/* When DSCP selector is used we need to match on the entire DSCP field
> > +	 * in the flow information structure. When TOS selector is used we need
> > +	 * to mask the upper three DSCP bits prior to matching to maintain
> > +	 * legacy behavior.
> > +	 */
> > +	if (r->is_dscp_sel && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
> > +		return 0;
> > +	else if (!r->is_dscp_sel && r->dscp && !fib_dscp_match(r->dscp, fl4))
> >  		return 0;
> >  
> >  	if (rule->ip_proto && (rule->ip_proto != fl4->flowi4_proto))
> > 
> > Note that it is just an RFC. I first need to remove the masking of the
> > high order DSCP bits before I can send it.
> 
> I find "is_dscp_sel" not very informative as a field name. Maybe
> "dscp_nomask" or "dscp_full" would be better? They're more intuitive
> to me, but I have no problem if you prefer to keep "is_dscp_sel" of
> course.

OK, changed to "dscp_full" as you suggested.

> 
> > >     /* Assuming FRA_DSCP sets ->dscp_mask to 0xff while the default
> > >      * would be 0x1c to keep the old behaviour.
> > >      */
> > >     if (r->dscp && r->dscp != (fl4->dscp & r->dscp_mask))
> > 
> > It's a bit more involved. Even if the old TOS selector is used, we don't
> > always want to mask using 0x1c. If nft_fib4_eval() filled 0xfc in
> > 'flowi4_tos', then by masking using 0x1c it will now match a FIB rule
> > that was configured with 'tos 0x1c' whereas previously it didn't. The
> > new 'FLOWI_FLAG_MATCH_FULL_DSCP' takes care of that, but it only applies
> > to rules configured with the TOS selector. The new DSCP selector will
> > always match against the entire DSCP field.
> 
> Back to nft_fib4_eval(), making it behave like the rest of the kernel
> would also mean it'd behave like the existing ipt_rpfilter module. So
> people moving from iptables to nftables would keep the same behaviour.
> Unless you strongly feel about keeping the FLOWI_FLAG_MATCH_FULL_DSCP
> flag, I think we should ask Pablo and Florian if they're okay for
> making nft_fib4_eval() behave like the rest of the stack.

Yes, that's a good idea. I will post a RFC patchset that converts
nft_fib4_eval() and "NETLINK_FIB_LOOKUP" to mask the upper DSCP bits
along with the RT_TOS() centralization patch. Let's see what Pablo and
Florian say.

> 
> > Are you OK with the approach that I outlined above? Basically:
> > 
> > 1. Submitting the patch that centralizes TOS matching
> > 2. Removing the masking of the high order DSCP bits
> > 3. Adding new DSCP selector for FIB rules
> 
> Yes, looks like a good plan!

Great, thanks!

