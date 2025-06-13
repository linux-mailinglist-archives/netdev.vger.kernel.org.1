Return-Path: <netdev+bounces-197612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418EAD94F4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E753B167A88
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DE22F76C;
	Fri, 13 Jun 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9v7mntS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E052E11A5
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841385; cv=fail; b=H8IOaZrMHrFKmxfm+fPoRFATOm3O9pi8eLESM5yW4DGGJL+pigruY4rA0f+yXb25389srBxLgvbTjjNE/RNQ4ELgVhO3Wg6/X6VrnldBdlWm/e+iVDFadcn38wa7zAB+EKjV+LzPWOGRMU99RcjgjnyRbCJm1F+Nivl9fPig/J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841385; c=relaxed/simple;
	bh=x7SzFxupknOoPuVMJIE20/DHnt/QaX+vnVEdu4XJYuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ptH+vfjTQ3Mm5S2+zUBsoUcx7Nxf6sy0CkX/wt4FmH9ME3/Z6LRkqwskztqoijp225IGb3dTl7OOTcj7iznv7pet79JRlfHnIz6vECel253PRHI2ddt/UaPqYhLi7cMkKTVlQB3h4o6PV1O+1PX/zbbXtaxdxYqVRHcvmVEu6ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l9v7mntS; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OliVekN6s/aPLgMBFDRkjE/psEkZ+TGhLaGRciru78/1D/0caY2uNSHGsXW2HrHrmjy0w0cgX+xPDelM7cPO/ip4Gp8v+rHXkW2LezniDsLZosGqKt4xZctGOCnQHYkOTlFQz3rrXALFuiG5MHxX1R6rqduLTMQpebaNzLkZciaLryXAfRgDQyvhrFQtYo+dsduR8puohSPhR2HCNHo5y9I1jmmx9L5FghNAviQ6C6H0r11wUQ8prOaRo7RxRz6G2R3Bis1myHQUApzbpFFBSQjt7WFjeLKsiHJc3hBihPo6gP6eACBCbkftvo/v0jRkpST21tZodXw2DHNIt3pvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7V4HhUY30w5O3ciYN9/nKkPM2tlUmVC5ZXYIss0JAI=;
 b=T5u+DvoQfo/FR2qnb+hgw2d3/BMK+vWg+0NoZe9qKm+b2ifPfL/7a2wAB3dXvG2Y0FxOFPoFmim5pMWbrgFpsXt31I5SPU6HIHgZH4k4K8c00MIvm9Pkq42Gx6JXcBdSmQzzTHd0OV19J3pNPzogtV1KTgLY5P6JOjgcJyhROHk1cPLtzr8bLyZHpOEd+YgjUGdfAGBD+rdc5Tcrq8u8WTjZsWUta4nY8t2g7zElmHZ+6vHl0NJE4VgsYc1zJ0K+9Ln5e4IdCmxQFqHQ4iw460HDnpkj9vPr7FD5KzxSI0SJae1pS8IreD6MWkc2Kh2F4lTvS6F46mDKyMgxfX0Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7V4HhUY30w5O3ciYN9/nKkPM2tlUmVC5ZXYIss0JAI=;
 b=l9v7mntS61BjbXATIVE8tFiYuzVE/DDdMNsqIMNnoCWzWJbCqQ/tVuGqpEEDR6qqNI5rjFhJ7Wfcn4rbbvqvNgloEin3y7mt0nyutFUwaUWZFPgq4Ec9dBrN7NJFlBW2sUfs1m1eyrRY5gI6F6IjvoYhUDpjzsxLMxPTDUBNY+ZHIdH7/P7jAijT1DHPjuhpoFF7DRpdpiWyhzIDjKNPhM3Iq22k0D50vkCd5I4fsv15Wp5U2ARcjUM1MWJ5ci0eflYMLwd4vET91n6yyeTOTcTlvUtIL+D2oqSKvYEfwMXGRyHHXB+L0XV0BYwyI01hFLaS67+wK3zh11eVIWmEBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Fri, 13 Jun
 2025 19:03:02 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 19:03:01 +0000
Date: Fri, 13 Jun 2025 19:02:53 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, 
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <zkf45dswziidctwloy7wqlpcu2grdykpvmmmytksyjwal3wd42@f5cleyttlcob>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
 <5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
 <20250612071028.4f7c5756@kernel.org>
 <vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
 <20250612153037.59335f8f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612153037.59335f8f@kernel.org>
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8bb8f1-2c25-4e7a-3823-08ddaaaceb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9BPA0UF4RqrEv1XkotnJrRMT8cyTwo9Sihhc1K0WS0vyyevQCY1NhnmfVpgN?=
 =?us-ascii?Q?Fv7Hs3ajbArXIaGziDxtTe2pRgBLSNY+xD2ycXlX0HpgbD6Ey2YAiaHLxv7e?=
 =?us-ascii?Q?oHH0j6IlDwUaPqsxaN6s83TwKE8lDrbuSGCarY0VO5P8nbyte60N3nRW1USu?=
 =?us-ascii?Q?ez0N3ed7X7Y4CtNMWUokx1dew6VCJ+KhyMh6YwAukgQuMYttw+Ys9W3/H6dL?=
 =?us-ascii?Q?ehXp/py2Wn6fFSIMx7vrpgw2YDlUwJbrAapCe6pBMyyjqd12ek4HGYjiCfG8?=
 =?us-ascii?Q?fmyLO7y6L2zttisPVg/aSY/CMD+g+Yuu76pnUbKmbmy3jkWBEHsrMkBLG2+7?=
 =?us-ascii?Q?VlWbaKYDwBKq6f/WpstNNTbIr1rMynRYzAHNLDbuHy8OpkqU361vWhDaDocE?=
 =?us-ascii?Q?+RA8W6AAMCsAzJibEVCsfzTAsGtKeqv0obwuOhz/RS4K3YokAH9w7w5QHH0S?=
 =?us-ascii?Q?lQLSFz0X4NYliK/ne4txghx3ejVDb5JLO+qaOqB+WPeQBWUu6DOQLdGq0MZe?=
 =?us-ascii?Q?nCan1shUpW5KEUTDNZo61uq+a3niXMJQf4ncyE9fCMnr4re4kEp/q6lmy1of?=
 =?us-ascii?Q?rFu63BvX71z75qCwcCreDqw9yh1J4GsMlfsspNtFTzk3MpNxNA8l3DphDfF1?=
 =?us-ascii?Q?EjGfN3V8bgIJSMJQvFqh6DdSjyvodOhhY4y4UISUHz4dhSS1JsSE3/UMq17W?=
 =?us-ascii?Q?tVSGBxlay63IfaClUxUJhk1a8V2qiOx1IS/5hfZ244b7CER70P/WEpP6G/Tc?=
 =?us-ascii?Q?K7++fq10Qo+iMMpAqQGRfSpoBEsdoAlbsbeq6SCFYi63QOyQxdmtxU1Rb1tY?=
 =?us-ascii?Q?PfXnBsq2XkLJUa46+X37eVRmsdOTIwQYFyI2t1tGQkGxm5hOCfR6iqqsbup8?=
 =?us-ascii?Q?vntJqhNc266PKGO9T8gNkAFkQxjWAc5I3Zlgf/FL40SIei0UWoQUJLC2keYf?=
 =?us-ascii?Q?dVmlsHxWdSrnsfhTVudJDWXnaQYBoAyQxSpnlolRT1zwscMrEJi46qHuAxJc?=
 =?us-ascii?Q?lOzIS27yi5uHdZJHPikbzJ1AuAYdtsQJUbtj+c5lboDp3Bx2kNOS7qb9y0Vh?=
 =?us-ascii?Q?r02I2Xy/kRYf8Bn/LGPBIaK0ZfGWsJlkcvcHBH8QOfJvyihxqCCa3cbqb09W?=
 =?us-ascii?Q?VLrj5UCBmCbLM/7En1rO68+IISEvBJygafId1HzNN8U86rYcL3g1HeA79awE?=
 =?us-ascii?Q?vwGBFjTy2q8pTZqGDUvzX9djhVbxdd78fGvjKLijrlkqvk49VsW61ebFRV0+?=
 =?us-ascii?Q?O8i4tsOm68SRSM38ScNOP2NM3uaZUkfYcrXUOW8ksveEFrG4kvIGLxOPdEGF?=
 =?us-ascii?Q?QUBhhN3o6wgO9yqBBSH250RtNGF9vmWQEcM4dSCSTFt8hYOXV0TNdXzArs3B?=
 =?us-ascii?Q?NGWNaglDdkIu9q2Phk231oSJWXj3Lb2buvZPpu0YlRle4ZKTA2V+x4qh/V3Z?=
 =?us-ascii?Q?+s+uOpD/TKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?re/dj4G5H6Ofs93PQNjkH/72ssxWV9ArVeQ0TZIYz3YjUJzm9Ecdkb+eIo5D?=
 =?us-ascii?Q?ucrpsiTK7/e74ivYz6lUdyOLNAipl/1fftiHX7nnl7bJdi6ooSNY9gIRucl9?=
 =?us-ascii?Q?7dudaou76u9gMsIMsKgszLJ4Q9sW8V5lHGVzELgpUu8D8p4d1O7bTaU3gBgt?=
 =?us-ascii?Q?VT6FUsG/bFBDAxIJ/nrXoRWn454i2e51Y+rmKvdxER9iUDSE6rCUJvMuVhUr?=
 =?us-ascii?Q?NvdOKi37Etg9lVxPIZzL4PK4ppUwPr9hUFSAnD3VI+kQY1q2WQrKYKpridwX?=
 =?us-ascii?Q?hNQv2sgu1d72n9YrJJIFNKTQ751aDrof+IpTPAMc80PdWTsj4Z2LRv7eTaIK?=
 =?us-ascii?Q?hX8vUMZR2Dyll8EDmFD3bHB3cTDNmuc26DlTFXD9TdtapdK3/mpYZpA2qrl1?=
 =?us-ascii?Q?6Hx0B6Gh2w7J6PoxelqXfLSwDSEPbZmgJlVbZ/iFtJBsOiQ2T5G+gGsZ9EEC?=
 =?us-ascii?Q?nckfmsbzEl+veC6OgqxF04R2Pm/gxlK7d12KP/x2cB7X65N9GpbIK9HjiPUI?=
 =?us-ascii?Q?agFyDpwLNhVSZCjzf4mWiKZOK5FdPe/ybuEcYXdMI+4YcHh+JTMDw7Jcd9fo?=
 =?us-ascii?Q?bLoNxt9+Ve32ILXUKIwiPY77BoyHAdRHL6Y8kVcHjhtj+sn/uu2up8hTWrS0?=
 =?us-ascii?Q?8UUnpFvGrxSfMY+xpIwXo1HSeNoA1VX//FO/ly2YjyYP867pC8iBV7vfdU5v?=
 =?us-ascii?Q?5OkIm67Lg5d3SD2LBcdoLTDTxJZO8q16+gnqAh/H6A/1+536/obfamEp7aqc?=
 =?us-ascii?Q?iAxUa92lv9YjtJUv0cCXJ9CD1Z9YsBhMjAg+ZcGFdJGfSPb0P0dQ8xdINQr+?=
 =?us-ascii?Q?yS3lj9aOxffNnGYGWl7j6MOMfOORIZQInWAAwbEkwfD959wy4/amYc2e/xm8?=
 =?us-ascii?Q?1NTBM1EDRkTae9K6RNAKw6zPIpZtIBmzTy4/9tXg7KbO+vRfPrq5BFKYpfzQ?=
 =?us-ascii?Q?h/SAVUCoMTiK0cwf4qEyoORz/Bm0JGCwqMg3t3jzYdYfpFO32i8eYf4Zlo+j?=
 =?us-ascii?Q?4+UZURrYCay7r4gpiVV5PLXS1h5Jqj3iHCqpKO7vwSDW2A7XBEGYdyjVW3x4?=
 =?us-ascii?Q?UOIMXKnPDT9qtdE/tMPAdf57c5gBPJbJogBEeYFB2wnVFBsNyIYBtKZJL9D0?=
 =?us-ascii?Q?aG33094JWamAThcr92Mjj+KJjyCF5NQRijiNScv1F0Q1uu0b3TYdkHziCyjH?=
 =?us-ascii?Q?K2lgI/tcYWehBm6H20LyhMoQYreJAWI0JtANMP7FZyCGzMgfhSUS1euVYpgX?=
 =?us-ascii?Q?K8fPXd5Px9q8J73vcueAhLmb4wWiV3Hwcgk9h0RPJn3E6ztWM5NJzqCoQwbl?=
 =?us-ascii?Q?3V8jX6WlNEfyDJKPlcP3T7BqyB1UzKGTquSk4l6xRoJ720oBBX5S689AIGZb?=
 =?us-ascii?Q?wREKrWWxIXGEgbloEf+22RQDrkAeRsW1z4uXGOfUTzeT8uDehEcB0oBAh+i9?=
 =?us-ascii?Q?i2hFjgSoLVXcR5caL67J/4q2vo168EaXk6rksdgiuevXgArVvSxNUopiyUUI?=
 =?us-ascii?Q?ce+2Jl3V4y1nGV7eEvWxPfOSRzBFV4Envc/K7nNO1NDFaTl3h1dH4LI6L0O1?=
 =?us-ascii?Q?bZyoMO2Y3AFHEF1hQ5EJ6PssW3HLHtJ+MaDD54hR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8bb8f1-2c25-4e7a-3823-08ddaaaceb52
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:03:01.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gElkbhLOlGXzcCQw1RvEqE12LAPo9RalPrPuhannRPOTUjfhuClj71OEsd17k4Wst+NbKt6YXUeUac0RMMhY+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637

On Thu, Jun 12, 2025 at 03:30:37PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Jun 2025 15:52:12 +0000 Dragos Tatulea wrote:
> > On Thu, Jun 12, 2025 at 07:10:28AM -0700, Jakub Kicinski wrote:
> > > On Thu, 12 Jun 2025 11:56:26 +0000 Dragos Tatulea wrote:  
> > > > For the hypothetical situation when the user configures a larger buffer
> > > > than the ring size * MTU. Should the check happen in validate or should
> > > > the max buffer size be dynamic depending on ring size and MTU?  
> > > 
> > > Hm, why does the ring size come into the calculation?
> > 
> > There is a relationship between ring size, MTU and how much memory a queue
> > would need for a full ring, right? Even if relationship is driver dependent.
> 
> I see, yes, I think I did something along those lines in patch 16 here.
> But the range of values for bnxt is pretty limited so a lot fewer
> corner cases to deal with.
>
Indeed.

> Not sure about the calculation depending on MTU, tho. We're talking
> about HW-GRO enabled traffic, they should be tightly packed into the
> buffer, right? So MTU of chunks really doesn't matter from the buffer
> sizing perspective. If they are not packet using larger buffers is
> pointless.
>
But it matters from the perspective of total memory allocatable by the
queue (aka page pool size), right? A 1K ring size with 1500 MTU would
need less total memory than for a 1K queue x 9000 MTU to cover the full
queue.

Side note: We already have the disconnect between how much the driver
*thinks* it needs (based on ring size, MTU and other stuff) and how much
memory is given by a memory provider from the application side.

> > > I don't think it's a practical configuration, so it should be perfectly
> > > fine for the driver to reject it. But in principle if user wants to
> > > configure a 128 entry ring with 1MB buffers.. I guess they must have 
> > > a lot of DRAM to waste, but other than that I don't see a reason to
> > > stop them within the core?
> > >  
> > Ok, so config can be rejected. How about the driver changing the allowed
> > max based on the current ring size and MTU? This would allow larger
> > buffers on larger rings and MTUs.
> 
> Yes.
> 
> > There is another interesting case where the user specifies some large
> > buffer size which amounts to roughly the max memory for the current ring
> > and MTU configuration. We'd end up with a page_pool with a size of one
> > which is not very useful...
> 
> Right, we can probably save ourselves from the corner cases by capping
> the allowed configuration at the max TSO size so 512kB? Does that help?
> 
Yes. Sounds like a good start. We can always investigate the benefits of
bigger buffers later.

Thanks,
Dragos

