Return-Path: <netdev+bounces-198574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B5ADCBB0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58573A47C6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25F22FAF4;
	Tue, 17 Jun 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ok8BJBjX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4552DE1E1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163782; cv=fail; b=cGoQH6mNifBigf06yDS3deFLH0egkY2uF2mX+kAdCqKmU9/1UTFVTfWFC0QzcZzTODLZxeDAfVo2242yHjSCjd8/b24f17XCGxJ9csn99b4Uq+WjMj4/8KNVp9dTj4ZXrQhL47imjtNgYLFaZhAs1fIso42GuHRRq8wXVTplpcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163782; c=relaxed/simple;
	bh=pGLInxSlE401KtjD8ny96fTEHsw8ufGzwRmH8B1Xogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRsw/k+KFkkQBs3J2KI7LHi/ickIisp2V5q8XIoK6Y3bHCP+QKpJIVMTcPybH+2SyO0KaUG7XzFb2YS8c1K8Rh+/v8qoS2mqehuo56dMYtPSu/nq6muS1AJT96nE3xvWELymUElWu5CLobfEr5dsTiEtWWHAyV96ik5xqwENYAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ok8BJBjX; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8RyViIYIHCYRNWKOZrjQZFUkoEkvdYBN+cPCjOAQEkcDS/IayVuG2aKvc0zoeqcrVXlSULIRCG38Cn4QT6LqDo/k712BsRfT6vpG8qW7P2s2jrknjUsoyqR+v/wc40E2I910/nYhrysdaHRkJ4oMX7rZ7zquDKB4Gx817ztGLiNS2b9w+HOS3kOG3rjzNUBZrgQmcNqVoGmypD+PnchnDsRPkgwu2QVhaJOubsL7lo5zc7nj/bAgE/MWVqpVIFbp2CtGRZ7k+R3eWytTPwKDowz6nXg6EQMU+QQzP3V7AsyBqSk24nHOcmX2aadtwPPQX2kugzez6AtRzQqe41ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ9L6SZgEepERFS3imGa2BXkA/ViAXbgHlukQaA6wLw=;
 b=glcq4zSp/K3rSmJOymm03XclWJJjGc/rhtPdxBGL5gzKPZeluvodc1FZgFoNmQmLwmDNNcqwnPTJR3JXy1Qk5JUWMnKuaIaslzmnix3iGdr0efYXwR8DOqO/7bj64w3IFdWFTeHjPUQCMOtvOVTdxHmUPaAw2hGPj0KEo2/dgoGzRvuzCF7xWEg+rXNbxSX0MjoV2iLd/oMxdcGQbHUo1ZaHw9d3vSJfv68FeydvjBxm5lq5wQuOjGrLRmtuj6UqDawZcYS+MvJFqd90BS3Q12YrQ6ZFRcFGiNrWhxJTeZeFPla7Yf7zvE7y0w7FjpFWBMMQ0y80DH6jT75DjKoJ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ9L6SZgEepERFS3imGa2BXkA/ViAXbgHlukQaA6wLw=;
 b=Ok8BJBjXPo328Rnmgzquptsz+QqJTSAnvZZ03UNC8jG6Yp49/tw/dB43PvnetkMr+cXc0vB1gFweYFd8mGWt9WOUq5owBrTTOj2nYUumcFXj78XqjG8YnZQazfij/eNKE5aaNasXvYrZ6DYz8Zz/7ft9erTcY7kGHHsf2RtBaILLqHBGc2RnTVjtMAylyESmstULXKh9orSRS/CTOKz5gelaChmUBSpcqC+GBcdxzW/gmVvQnM4lfBTgWyFDC9rID0lH7oI3Xy9Ddw8c3xVWZB1Kew5ku76i2rMELMl8hb4XpsmVqJ28YHW4lHP7BkS2f27Ldmc53725Xbv3SrGmcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 12:36:16 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 12:36:16 +0000
Date: Tue, 17 Jun 2025 12:36:03 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, 
	sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk, asml.silence@gmail.com, 
	ap420073@gmail.com, jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <fyuhlxqjgrypi2gu24kj3x3noulgibd3kdgmek6qmbssfjailj@uf7w3fyb7sqz>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-20-kuba@kernel.org>
 <5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
 <20250612071028.4f7c5756@kernel.org>
 <vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
 <20250612153037.59335f8f@kernel.org>
 <zkf45dswziidctwloy7wqlpcu2grdykpvmmmytksyjwal3wd42@f5cleyttlcob>
 <20250613161636.0626f4f3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613161636.0626f4f3@kernel.org>
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea65cc6-cd97-45c1-bde5-08ddad9b8d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFfOsHNLF3+Vlr/QIkQ/+ZB+s6M34Bb3IahMVnJaieW1YUHqMbSlDsbqptXk?=
 =?us-ascii?Q?UX+NzY92DAtmmyuyf0pFOrZKcd0Gqf29iJnfSCBM05Mc8uQe67FfhgtjvYAp?=
 =?us-ascii?Q?G50+MinJYaKy0S48QKGzJcdKGYo4KTfrqnuXt9K2C4DBcRHkUR+OGFenofoA?=
 =?us-ascii?Q?L0jYK5gRw9r0KHVCSLOyb4qBiU8cjILl65hGdgH7iZTpCZPRBTTm2mnSwUPr?=
 =?us-ascii?Q?Wn9QJjSAINwWMJPYGdLK4aEjQ4Hp08LIeqeVS4ylWF45j/hS9Hcq7mZ5jZpB?=
 =?us-ascii?Q?pTQX5aq7Bm6752tc/7QjDLnqZ4Q3u/LdU9G9YyBcF9vbYiL2cCOjTPZBlmeI?=
 =?us-ascii?Q?8Mlhi9IZmoTywL/yK1H1EDsFR64zW+G0Z+D/wWvEhpX+oI15takx5B4lai03?=
 =?us-ascii?Q?9mDPkkQYzwiUvKl9R7rpCXA+y6b8JggiPWwDUks57p2GRJyAuAgTeEmF+0A2?=
 =?us-ascii?Q?HlPW9dU897KvSLMSPtC7pFgc0BdWz6DSELiCEal8rymMXWVs3EznHlzLPwQ1?=
 =?us-ascii?Q?1T3n39bs4qJdjAb6jY+0YLV1LkyA4HM0GzL2tK9qVrGWBzIXtXiZmLOW4NFo?=
 =?us-ascii?Q?N+vvpOb8wgUUBoQq53pZt7gBSo6Ub3KPdcBH3lsjv0ltdVxpi4Vgss6/9Ymh?=
 =?us-ascii?Q?P4wezd4Go2NhwY3NSzDjlklvZ2s21JwcI/Q/Fj8tkB/zfCbSKUV8h/pg4Nuk?=
 =?us-ascii?Q?KLRZOH1ef8rAc1B07zi2Ou09fGrbb7+vf+M1B8pVdCUWkJoI8RfTYpK35H9V?=
 =?us-ascii?Q?vEu5HVEg8JtXJgL+lGu6bABjFzg7vU7glfFQ06a8YSqleL4DM6molCMBRcow?=
 =?us-ascii?Q?aMfpKcWhamD3ureyEVC5GkTixTB+/Q2PiPybPM9sfcKEhFqGcYFVO1DRPtv2?=
 =?us-ascii?Q?TFYoWMZOXUrDJX8QqihA/JW78nj8kORZybWUg5djeSf5eSDfye4apPjCg/Ra?=
 =?us-ascii?Q?JUOmKA6tJL37v60hlPt9iXpAmwbgb6OunTUFdkZ1mwLpHrR2/p8xfL+WQUpL?=
 =?us-ascii?Q?Qa2MTpHp5i4P+0SVZhKPhLxz8rXGOPv1D8gEgZ2OLA4x63kWWPHhE1sIKH1x?=
 =?us-ascii?Q?VQZMHsIADaSRRlgmvG+80b2nyzGBMNNfmQHMJ3GOKc0A0o3punGYklJq7jA5?=
 =?us-ascii?Q?2WMYmmwMvCR+Lli5wjSMTAq1Dhk6nMvr+wLiNExJ5jsVwzYhvEVQgOsX+HpN?=
 =?us-ascii?Q?p7qyWrXCgL43m22pxbP5X7D3W8/oLQ/dxsAoI9HAPO8aX+RMpxxRKy3AkBd/?=
 =?us-ascii?Q?nDZ2w+bXXsmEP9f2Mo8F7tiiskqCIIN8UG14uoEiR67x9/IA/Fp29YOxdIEm?=
 =?us-ascii?Q?psgvY6ckh0qInr/Rod0o14VY41HEdj+kp9sZFufKuYRk5uDaiUicc+bqxPDs?=
 =?us-ascii?Q?9LEV007Lb9B0dZDCkrw9fewvQysaY7E0qpgqhULPrCJ24gBDEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bbO4ksLJBqGvDEJaxZdjiYvFeEZCUSP0V2RZghswLkZafDWilI08UgeAg3c1?=
 =?us-ascii?Q?oHsWYJS0+W1ZZPXlaPm1v8D7ym5rcZfwigzAAT9c7TV4vcG2rZ2hlTiSUUAq?=
 =?us-ascii?Q?h/96FPw917wMcVyo8FXI2eeinGnVNCRRjBU31XHTq3lIaVqGDcfbukE8Tfh2?=
 =?us-ascii?Q?BS66T4vj0s+3pGE5vyl+XnjPxL8bovEqs0QMCUxzDIsAj95A2KixJ04NbKlQ?=
 =?us-ascii?Q?QYDYoXSNSNd8YOAOaLDOglRaFGxL7HunROMR/1d9xhk4mPyvL0z1DHpdvE0A?=
 =?us-ascii?Q?NSu3X4gsa4Zu9cVJ9xPdHrymcNU37tXZWLUp4o8fmP/C0kQTl/+5ggY1if63?=
 =?us-ascii?Q?/DxR+RlnVqh1tmSxEXYAep+l5RzSw8miOs9GVk5mptLNEkIrxRhrVWTtlm51?=
 =?us-ascii?Q?4mOmldAb8ayyzNIzqu74sxOSccJ5K48quejfa9P3cSo6pPzKoz0Jnh76m3MO?=
 =?us-ascii?Q?0DeLEiybD3HADs6u1y1AdcMreapw3ThZEcRw5nLc3JTTwNi3asy86HoEerpF?=
 =?us-ascii?Q?iFA8ONI6oYYFGStQamMQ19tXCf0psVjkmjU8bWyQm0AI20ij9+7SuNqJL4mH?=
 =?us-ascii?Q?M3VcJge98I3q9vEU7/WfWqiJ471vEkN/aLmv3Q9XgU4vHVkhGQz4djIDQLOZ?=
 =?us-ascii?Q?30Z1nN/S9laoAoO0lemM01zwFDhlt9wjcEWUlZVR/TLG3ue5XYszD1BKi7BN?=
 =?us-ascii?Q?4LyU+A1hDjy8LRfh61+iiumHcthTWrMt8/2nReLkXQjCHIS35KCCLGeq0byI?=
 =?us-ascii?Q?uz4A57NsuNyGCX8PWboOZUwxwBADjF4r41p6da8KIajUojefJ15kcFmVTeCE?=
 =?us-ascii?Q?Fdv2AAuMHlOPNjgTkc+GGdSh+OE08v4bY1m2U7bcwSZ4w+OmL5Mfq9ivlksq?=
 =?us-ascii?Q?nBk63yP0vlVLGVf+hkW4FfHvaDzmfqkH7LZ7/tPReHSs0Fo+ciZHyh1oqOLB?=
 =?us-ascii?Q?kkRehVmcNZgsImZ3p3RI6xsvLfAzcn1ZplJ5MyUuqwreLXemN08G4+/3wJgX?=
 =?us-ascii?Q?sueWSPOM5FJj8zBeJPg0UwYKvk02lZw9Ot3J0MdB6hqVITOaFfwBbre73y03?=
 =?us-ascii?Q?7byRJ1W3HjJjtk94oXKwiFX6UPWKUbkroQbRdTnNxh+VU52srh86D80WKEbz?=
 =?us-ascii?Q?6Oc/9CfL6PyGRyvaYAkyQNYadMcCObcutffbVCDJc5xUiwFRFNVomP9dJxi7?=
 =?us-ascii?Q?igv907/czv+MMfnrvmFGe6zfUQbtHdUBuDTO77Cvnw7kxeSgkRvSE1WOz9Vt?=
 =?us-ascii?Q?JT8/f+u9qvyHOCucZDaRYaqSarZAuF1c+05Y8EdbxbIRKS5U1SG0N+79lcr7?=
 =?us-ascii?Q?CrJMtC8wCm/sJaMSx1SROF1m+mIBCdkHk2XSGbkazyshoAZn/hnqvdjWfzxl?=
 =?us-ascii?Q?hJ9Q2Oo5FuBhmfZz35LqVa08UbLa8bGtz3ot0J905riLWW0O0M2plxzyRBqd?=
 =?us-ascii?Q?gk+k3AdJccZ538fUPMYuYcKa1KKcjhesgVW0wMDm4uRCSeHVDX1w5mjPqLqU?=
 =?us-ascii?Q?qlJdAuCnoanrReC5zYrwEVArHC6JiZJuVo5iDJGAk8+815FTzy0AXbgVX2Kk?=
 =?us-ascii?Q?PRW9MhiGzKZL68udtVP4XgaJFs6qTFmzaru6vju5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea65cc6-cd97-45c1-bde5-08ddad9b8d5c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:36:16.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGisfnQ/P2Io+ImFGmTiTe6WVtKOqmSkCTgQ7sNVdLiTrgggseC68AhtdTmla7wNRTYdKMF4R7gAf/zr/WwdsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

On Fri, Jun 13, 2025 at 04:16:36PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 19:02:53 +0000 Dragos Tatulea wrote:
> > > > There is a relationship between ring size, MTU and how much memory a queue
> > > > would need for a full ring, right? Even if relationship is driver dependent.  
> > > 
> > > I see, yes, I think I did something along those lines in patch 16 here.
> > > But the range of values for bnxt is pretty limited so a lot fewer
> > > corner cases to deal with.
> > 
> > Indeed.
> > 
> > > Not sure about the calculation depending on MTU, tho. We're talking
> > > about HW-GRO enabled traffic, they should be tightly packed into the
> > > buffer, right? So MTU of chunks really doesn't matter from the buffer
> > > sizing perspective. If they are not packet using larger buffers is
> > > pointless.
> > >  
> > But it matters from the perspective of total memory allocatable by the
> > queue (aka page pool size), right? A 1K ring size with 1500 MTU would
> > need less total memory than for a 1K queue x 9000 MTU to cover the full
> > queue.
> 
> True but that's only relevant to the "normal" buffers?
> IIUC for bnxt and fbnic the ring size for rx-jumbo-pending
> (which is where payloads go) is always in 4k buffer units.
> Whether the MTU is 1k or 9k we'd GRO the packets together
> into the 4k buffers. So I don't see why the MTU matters 
> for the amount of memory held on the aggregation ring.
>
I see what you mean. mlx5 sizes the memory requirements according to
ring size and MTU. That's where my misunderstanding came from.

> > Side note: We already have the disconnect between how much the driver
> > *thinks* it needs (based on ring size, MTU and other stuff) and how much
> > memory is given by a memory provider from the application side.
> 
> True, tho, I think ideally the drivers would accept starting
> with a ring that's not completely filled. I think that's better
> user experience.
Agreed.

Thanks,
Dragos

