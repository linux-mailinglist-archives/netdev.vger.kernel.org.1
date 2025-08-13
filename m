Return-Path: <netdev+bounces-213319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A9EB248B7
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4CC8835F8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5E2F746E;
	Wed, 13 Aug 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H3TpDmuI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185512F83D4;
	Wed, 13 Aug 2025 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085490; cv=fail; b=VJP9rWg2hQIm9Hi+C7TYceoLPmhR63o2PE2EgemNCI1tpIqSSeQIS0RKK2nQ615WiG2dobBpvU2xLhjyvwLwq+BuJ+yXkFEWKjl232P3fSjrGVA1ti9svKCY3zxbbweFBXi8hApzxIjNyjupqW+gzJ3KpGLjCBYbhJmm6BekvGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085490; c=relaxed/simple;
	bh=PHSJIyR5wyXI551HnlsAQN3tITfTQTWNLjnGqnGUi/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iqAeVJ40G+7DugmDTEtvRfn8RDxt+zxeXLOqdDQX2lx9NBiYVTOvp3j/jPhax2UdhR34d9FDseERSFxvgl2Fl8LDPa4NG48sf/gL4GPcefOLUZLtVx1FJvpreVxsfdtDlHBtHBtFcAeyz6+Q2f8+qrTrTrcVni386GmB7MjsPas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H3TpDmuI; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qsc+K9em5lRBeT7rKgG6zmiUVBnjlvigUYJlRApyVtPICT2+T0ERZM9Lf0ALzecOqxoV2VJp74aIFkzY+M4Sj1OpUvJpr+pekw37czBASlKdvAZoUA+BlA+LKCzYJPZyIdSsrWDnTgjvbLCXbqZRbSY2yi2+ZdMqTHqHgmmVIQoXYUHEbQXRADxvKfP657vyWeIEYUPkvmZw0uSmsbm0MC+ZCazVXikwtfPl5AuT9zGfwwrH5duscMyN6x5wSUxtr8BVQ2gBIQM8yDyc0uvzGABWk861D01REfp/hGKFnRM59YCUsa2ok32YrHXqjJ+1PBy8aVzDphmtEnC9nQ1RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHSJIyR5wyXI551HnlsAQN3tITfTQTWNLjnGqnGUi/g=;
 b=fhyQc2/5UKtR/u7v3e2rutT+4umaAYVfx5UYkZEBaBVeAKUvsLRPMHm3vU8vD4a9L71kLc5A+2ua3tb3M4B81cAxViQgbY90O1wZxUTdX+12LqKSBa8j8nVSjU2NTvKZnbVpClOGs8T6IgHC8/mVUrMWaZ8fZbgJf2qXwn4mQtRIkgPEODwTWVntgzYmhcOi4yf1PmAjPxmGhnp+xk7Ut9Mt4Vi+j63kzoOLc5TIwHK3fxXFLyWXcpunSfR+5LphMinmlU5KM4ZeXNBrAIgWEB8rH2RTDVxe8Biw+vgdchPPPvS11EaBkFlqKVNR45h19UBi5w9IWK1kQoyrFu1pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHSJIyR5wyXI551HnlsAQN3tITfTQTWNLjnGqnGUi/g=;
 b=H3TpDmuIQ2SRLREVaDJvoZCT6naU/e3igca6MdrWXwMmMhVO8sxB1umdW6KqeqXuGMB6f6m9We2BKvKoSzm3IGSchxv0IIctYHl6LzJHIMAZ1occQMruyr8Vcdoonee31LaVNUMG80v4r8VAUfq+dVoqdjdDPUtKmWEm6kDpD0XruPw6nVb61kQLh/9/TDCITSHaFz36RhJuyRDW/miIgUxeGDrlCqvqbbAqN1eGRB7mKIZ7sX7LaTHfTQQIBQxiQ+nGeksmhvPwQOtMZUYce98/SEYbhJeBjhhVHDkKsJGaaRdZd5JzJmmkZbn90pNKU8z6C1tzTQGrZY+jyVGThw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 13 Aug
 2025 11:44:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 11:44:46 +0000
Date: Wed, 13 Aug 2025 14:44:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] selftests/net: add vxlan localbind
 selftest
Message-ID: <aJx6pUrnRMnh0RAU@shredder>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-6-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812125155.3808-6-richardbgobert@gmail.com>
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be33df3-639a-4967-04af-08ddda5eccfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VsOSAxZHExh2iXAUlYcsffHAwWw/NtnbEdIC909A4FQjdpL1XGbi2+PTc+Di?=
 =?us-ascii?Q?0rxAl8gvXd5eyD+Go4CItCQWj0jtgxGSRsHsj96RJe+KJs6rdvRQarX85TOD?=
 =?us-ascii?Q?TECDpBwoW3b7JQA5U3OSOn6koi3qBUdBnzlSmKn7QlQxPkJoH6CoYWGqVf4N?=
 =?us-ascii?Q?8hLpYViM1zzUbP5LzpNt3XpgoNFMUnlLqvg354tp2rKwK5SCV6tkhQaOSfn1?=
 =?us-ascii?Q?l1b7nZHeMaX/Ebi0jy7MORQVcPSrugUp5p8C3Sk/jxZBihC3+WAvF82oSl3M?=
 =?us-ascii?Q?HGxRsYwDloKoHhxjmObG9nUBrxPK3EhksoZUyFNV9n18wwscaLjajCy7KoHh?=
 =?us-ascii?Q?DV0VIWmaPqBl0ewC4ZBY1swh0nER4JS/GhF71drkuBgZnzFbh4/iVRgjnz2C?=
 =?us-ascii?Q?QzxX2avzeu48qXvc04pE9X3oTIC4BtM9nscx+VHpl5xowBIZH5mm1zIazByK?=
 =?us-ascii?Q?KhWMWLTio/E9VSBCIou/J0Jc+kaOpzvR1FpKU2q999mw1FjXlKwB/gDGJ6wK?=
 =?us-ascii?Q?8EpNpJPnoq+gmxJntqxbEkIuUmI7Pad/ivacxqVjas5DGbAMoSoCgYNHdBYx?=
 =?us-ascii?Q?tl8NQgbvG+VyZXfqvYJGO1va9rPNv4hCWHtKtB1B/gDiRRzldMG4GMq/soKf?=
 =?us-ascii?Q?YgW3cCjqWGrA4lHHKRmTsFAqJNaLI4l038iEuZA3Gl6e48ppbUQ9bB78rgPf?=
 =?us-ascii?Q?3rwk3Iry3KLiuZGgj3X/fa3Y6P1tLfu3T96FAsxPpATzzBpOshQt7S/ZfwdP?=
 =?us-ascii?Q?7fsQPxuuPGHWNJms+0extuexFlw9deMPlR6vkTRAFN82UJsp7IiPGu/S1IfB?=
 =?us-ascii?Q?dH/f/AXBFFPKqEG1kGbELw9HacjDd8mIrd8fuqPw7NoKJB7M/IwqN9MfeIBL?=
 =?us-ascii?Q?A+s04eZvD60BHZjhYPbP9iEOeGuJgg2AF5/nu0nLHIheywmWDPY2C7Pm+MQT?=
 =?us-ascii?Q?8rhlB+EpYzNQb6+XeYAW+SBdlJoycUS3eU2uAUp7BtOz41WFFzzjkjdVyroZ?=
 =?us-ascii?Q?zKw/z2WIRLoqfjjVcmB0AeW6uE5Poki0tVXQGofeBNOilU7rL8oaUHEZNQPB?=
 =?us-ascii?Q?AgsUR33c7b2lKHE2d0IMoQiX4KcIIwJGbxhSb6myGbk7ar4AmuRp09E8qHdy?=
 =?us-ascii?Q?GePBUKYDYeKqdzGAbLI2oBUMWfPHo6Dfgoxotkb9LH9MOljrTTbVm7reV16Z?=
 =?us-ascii?Q?LQeE/yrPRLcpqYRyY+U2hgTjRb+PCq5dYQpipEnslv8A1AKXZ77dztOXPQmt?=
 =?us-ascii?Q?a6/e6g437PWGZgn4oAhN3vwV3yyyXTl5b9H4f2APCQe8I8/dzT7HT96gMDc6?=
 =?us-ascii?Q?Wo8dYOoH6gQ4GtiXxUpuuICoF0ozJ4Dy3V9ZCEOAl/rXRkKT1fcZKQt/VLLp?=
 =?us-ascii?Q?NMu5coGUtzw9weJEMa26AFf34p+sebjCxjuGLjZ/sFUXUTNwH0MC8+lPco5b?=
 =?us-ascii?Q?JCn3Vn7Ll5Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V8w/7owiBi+maH1pLkbb0xqvFxzfEzS9n83G9f+7kSYR6rAAOzLBgNcALCJB?=
 =?us-ascii?Q?Ks66NlqmXN/jX8HvmBrl02tP7Rew7r621XQy79tWSKmI1b0zzZckWRRv+Djt?=
 =?us-ascii?Q?92cNsDznFwPJWzOR3c9pqRFp3wdPkt1x1hSJ9vzWpbfQAitWRyHgmEBkMwIL?=
 =?us-ascii?Q?iB6ncZPgQimrJTnTLOpkrttoPjy+wVdxe+e4JuFtBgBB7CP3V7dPx6jmAwHK?=
 =?us-ascii?Q?VLI50bo/BwLp6AF/4J0VBAPRJObjr4fjxDrjlxa/CGmpElFsaiNrCbD+05Ii?=
 =?us-ascii?Q?Yb60yUMXFbROC67EgMn7r5RtEhucn7siQBCbMr6alB7QclaOgazCC2P1ZusW?=
 =?us-ascii?Q?kraQrxLM42Afd0vgJyalmethb69wDCS53VFP8UPJXOxbJkhdxotYRHqaZN5P?=
 =?us-ascii?Q?QZxDZWIXTqnRKptJWX4xXWx/8Pa3V622chqklsnEqUnlWLIP9K/wI0JD+dzz?=
 =?us-ascii?Q?+Yn5qM9mvq/tSalC0vYncHPxCLHvjVJEldZMnxhm0nXncx8+rgl0mM4Me41L?=
 =?us-ascii?Q?j7XEzq6tNJTl8w0AANJe8vrZPYcAyWrzhSFi012+vp4+qmxMKLIeT0Y1VNVG?=
 =?us-ascii?Q?VkreUZp03aZZGDMArB0t1nFRnmY9/bYpjbvhleWvLgGFksa6T1GTOlLSrFEd?=
 =?us-ascii?Q?Dv9CeaFAH4kWjGRpetW3OJsRyZKcD+tkJiY+cZk7MdAaTI6+zBCuiEZOiwI1?=
 =?us-ascii?Q?1v8u/kF9JiEcEKSsfPaq6XVpU75IhvQgvhZxhztpHVAiTRNJJeq/zs8A7DOz?=
 =?us-ascii?Q?NwmM4jx1skCac23YZIu7xvHj0vcYsWMcGK22Gzzxri2IUsq4CL/WOAGsdp6F?=
 =?us-ascii?Q?/nlfRkcuWHj21SUpMe52voUwW81jS8nmRGGb7IVq8fdYt08WS6byttWc2W3D?=
 =?us-ascii?Q?xJf8NR6y0zUolYhEVzEleYCoVD0zi++pYq+NCuBX9s/e2EHxeQaolsUWVYfF?=
 =?us-ascii?Q?kK0s0iSpGmsiTzlfhLru/bZBvkklIY5hwR+uXZW6jv1Qnf/6aZ3PhQqsw+55?=
 =?us-ascii?Q?zW+43NdCSFmQlS9XDjRb/018rz+nXZsQueC1et8RFQANElAYUWNJjec9psTM?=
 =?us-ascii?Q?qBfK99Qz8jMECL9L6g6ZnEVLktqukJrkp16JYX9CAJicvgFWEQjHEzzZx/RP?=
 =?us-ascii?Q?WQc06zIWxcxwAHcxDxM8wu/q/BqZKbb+Wym0lTOW3PJakDUmDMqePrXrWVav?=
 =?us-ascii?Q?aflF88ls+4QOOeT17L49JSo7ztECc6AvYW37okAdDywubJ/UcMknKwRusqit?=
 =?us-ascii?Q?jfyUabNZsXmVaiUOf2MUvm45MMCQToytn39SqadriAipNH5Hu/BPYcMk+rFT?=
 =?us-ascii?Q?RauRwffsGfeB6Lc71bJp8GzLLyynQ6kRIvUuipHETuFXehVXJOlLbapW/V7h?=
 =?us-ascii?Q?HeEoUolIE6LQ/eAu0RzvQLxTAqDgkYln7xUTMjZK7ycpyf5i5kfJ7KGyhtSs?=
 =?us-ascii?Q?xPNY2xh4jJ3XCXUonNo/tBhGexge6siO80V38cbWZzTn7go9VGNB152v0oAR?=
 =?us-ascii?Q?o7CTaJTvjYQHdoqfcCIF4ocKQ3/jzHVUXuuadDRpxev3kG2+Tul4qATLw+Wk?=
 =?us-ascii?Q?nhJXWBza7/8FU88RaI01rjLn92t7mH/s4obHPhlo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be33df3-639a-4967-04af-08ddda5eccfc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:44:45.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MjgrspFvM5+zbDWD5yqL/4V6GDah1cirql5H1S0vOhXHyI1LFUtJY3HueQEs5O5Ly9nYreNmnclJzKOxU666A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

On Tue, Aug 12, 2025 at 02:51:55PM +0200, Richard Gobert wrote:
> Test to make sure the localbind netlink option works
> in VXLAN interfaces.

Thanks for adding a test. A few clerical comments:

1. Indentation is inconsistent. Please convert to 8 characters tabs.

2. netdev CI started running shellcheck. I don't think you can eliminate
all the errors, but some can be easily fixed.

3. There's a blank line at the end of the file that should be removed.

