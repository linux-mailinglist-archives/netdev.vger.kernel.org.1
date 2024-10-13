Return-Path: <netdev+bounces-134938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E599B996
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 15:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187FFB20CC1
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140A7D405;
	Sun, 13 Oct 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXrg7HeG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15CC143890;
	Sun, 13 Oct 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825888; cv=fail; b=hiF0UPwHW1CMv5Vz/qA/6jwt6QrktqVaWIJwRkBro4/EnHKHA2KKgZvAH2jr+5SC9Yfbu6G2cZzJcy3ZBoqPbSrOyDY37QKIrZZLM6/quFURYeBgMoee7OW+/r6V69yLR0EMfveYN63VWFBQHrcw/c7tyU0zUvAosw/V9h+KtF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825888; c=relaxed/simple;
	bh=Vs15NOZ5vuJdxeGWqrV4uhbFE45snIN85sQHjYTdWUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvvVjixKdQKcHKyUuQGebjaXbskNMaU2bxIN5TLmmlyiOGYi+reSx3FgbHedSMd8w2PVQ22lR4RcB1EUIESrweBMFkDMSRUQg5bpNgQodFsgaAH2zchtdBgrVYPUWcFpuJOBPxUO9SP6lWOkMCAxz68LsjUOBf0+Qbuv40dPAgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXrg7HeG; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2JQ1Ygh5QYJ6xlPeUSbL7RP1BStgF4v8dxTL/yLVc4Auv+lmXswbuzqGZetQquPyZnXvMpMEc1u9GdFEyl79jY/5yvGsaCENPW35WI+i7cdVVvBDuXH/cN8XgvRfii2Hy6ai5g89jTqecpWe/+2KivUcvdWK9BrZDCeVBNiE5PijXxP9P9rHfln/42K+5ZupcEEEpNC2gtNVYx6h0SHikMXEHcPM47qJbsfK7ZG8q1rEvIbRgoxTkaXCVtBvb/qzyr+e1Ibr23zts9F/f+9kRZayHQBu1djjPka8sqWXV99a6ctmpSwOOJMBhIj3iYlUNOIxcFXgU7oNvLPcHLvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHj/eLlTI1E1XK60jmweRStXCZE1aCyVLUnKGaV/ZTY=;
 b=WRVF3yCNFXYMkLN4bIZUosJLAUx/rCYVA2mQyATKAKUzu7zApNSgahPkByizJbPSEcARfEkUKJJr98KhYHo9BePQf+BHEm2W/Pi+6H3rsEswcc7zMrAIYmmX4QgBMnm7cpHZGstVz+8rt4o3spZHysXu2Er3tv4VQAL79vvKFKCSL/vX5AtOjW9E5hZd5DArv0I0rZkoqoFjzw3sOgcuMJoAyf30XQ4Yuk9p3jdKBUkALptpShaZ6tlfMIPlFzxtr9R8726SFAjlBZ6xgS0xmcDud/FYxsIe4RX9iLAzCUaKHp29RxjmwvVxM0jZSf/dhKg7qIjOtXJKWJIN6Mr/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHj/eLlTI1E1XK60jmweRStXCZE1aCyVLUnKGaV/ZTY=;
 b=QXrg7HeGvLvWIPYXzdEUZit/y/LT6yBzdNF5qQNEP+6YeJ0oFgVQYhDJXMgKZZVpcoT6mpk3qGEETwtzIg0ZjHk9bhj1rPY2TeSfG3vTJnxkE6+oVtlUJ4plF4Wy41Tym7HLN2v2MPvSEVnqIS6dy6IiXCV2RYZhPz1neNviCPg8+qFa1Gfcppu3INGvdQTmsA6AeYephgq+Bm2fjOF42C1/XCqfs6+T31twRbOwbZRnDbrkaqtjT6Ce2ULHtkzOia5NlLxloCPDZXTKjfX0Ax8SPBe4CT5N1qJUZYynX9dfh1YP6YzweWetEa84rffAS/wpiRQI05yb5k1nrxhc7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 13:24:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8048.020; Sun, 13 Oct 2024
 13:24:43 +0000
Date: Sun, 13 Oct 2024 16:24:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, aleksander.lobakin@intel.com, horms@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v7 12/12] net: vxlan: use kfree_skb_reason() in
 encap_bypass_if_local()
Message-ID: <ZwvKEait2FZ7K03c@shredder.mtl.com>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
 <20241009022830.83949-13-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009022830.83949-13-dongml2@chinatelecom.cn>
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f81b3f-da72-4668-d71f-08dceb8a660e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bNhG5lqE2aWEl2hlVILy4AY40taaBlgZSkgUkYV+a9i7XFdHvMneXlli3eyG?=
 =?us-ascii?Q?03IqNfiHkgKsTPuVGxgNdZTlhEPade1vPHx6OXq0XLPhYLzkL+iqM8guV7Cg?=
 =?us-ascii?Q?mVx7vc9wCF6K0TqaXMMiW5cNXWugZzgP/LKPnedMKl8yKdQm3j2EETWcHfn4?=
 =?us-ascii?Q?/25kPG3fehDipzfbJhz+IJDSxg0FaJcDqM/zGxd3/J26I7tjOaxbMwCnWkY/?=
 =?us-ascii?Q?2LR2hjfWKWwC0Vz9o/GMdTHqljGwH9aBBYnaq+ZUs+gsEW4TRxT2JIn1PgIk?=
 =?us-ascii?Q?X/7qThYkS4XFEaJ1p90c8/+l5mZBfKwZ6CL5IQLkvoAJOEJy1DPU5DepAPRW?=
 =?us-ascii?Q?WGeyH10To1UidTqJejazk2cTi5CQjXWCKaAAJ5JXdUQD2tkrooD1vVLORUMS?=
 =?us-ascii?Q?COCvzH7qjqYeUl+CGJP5XVk5/vFmA48eP6hHB/5FwUqKld7ZEnSQjoRCIEOy?=
 =?us-ascii?Q?VepB2eEycepSVAqXAtvNU9PaTnu1nmV/Tqv+EYunSbJYdygmYKhJHQB1BOWL?=
 =?us-ascii?Q?GVl9v/CEdPXRyzBWlDxyllB88aqg5Wv+XiZXf3eNbcXvKg1/wdfr96AmWYgL?=
 =?us-ascii?Q?3plVvqXTu7WZpTQnTGN8HX3ELQTuFQTSaAhVU8+PhGQNqNPW0tykyBsdNTED?=
 =?us-ascii?Q?QtLJatb29yND6gc6hqPE+tinHBHrlAWid97f/1SD2VSotI4FnEUIsvVoDMtS?=
 =?us-ascii?Q?7vIKG+Ox8z5adcUgw6JtQZCU+/x8BVw47Er5sFmVX62he99EFWQzou5TLsSP?=
 =?us-ascii?Q?ThHNLo+SFCFiKdOpeiUPBcUdSAOpq2/w+CgM6WGirCWPDInDapLnZ42U9eIQ?=
 =?us-ascii?Q?cae8lZr+WFc3VhRsYEkCuA+WEBRYFtRQm00fbjbTpY+kaU4nZXhzkdWLRAZL?=
 =?us-ascii?Q?nrc7q9wamU+/2F+yfHRAXi++Oh3WrueYGI1UkEEGCVxLcA0daRgl4OAErs3z?=
 =?us-ascii?Q?3Kc99czkQZyhSK3jcknxh5FdgkCy156xPAYtQbrIoI4tSYZK2YFmubCKpX9x?=
 =?us-ascii?Q?hW4vWD7sMAMjtE4fDR37ltBsWG8cgRLoxWZPjcyQ0avbMUP7VHB4SIVt/+mY?=
 =?us-ascii?Q?Eyfdz6NS5TopPN9GM3o3cC+IVGGsZerDGpBaHWS+TVUZomGXplOWcnTmHqjn?=
 =?us-ascii?Q?IwJCQ+a2RGY06su90WY9cDlyegaqCieqXf3jly21I3aLpeXNyq8OfDA1cnXj?=
 =?us-ascii?Q?z0To9pSJ3DpITLXNtpM4w3vuntS8njg/RihA5vpRJCkIThUbendK/JzdxdkK?=
 =?us-ascii?Q?BwRaUojUWuex3kpTEgMuoLeHZs+YQ4tJ0tJ8agUKKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeGRYnAiecgnbrJLZvCveD+sZG4dyXhD8oKSnGSP1IMuTQTZfjpX4r4z9gRB?=
 =?us-ascii?Q?pTQFItx++tVP7pKNPcqISfuWZ6Z/GeCt3Q1sHPkHthkHrSFNpKPMNfphvv+1?=
 =?us-ascii?Q?DbkKWi4EU0t39nCwiSefw7uqEURI0j2vv8n4i1yzsLpf9p6MAAwvFaNbvYwp?=
 =?us-ascii?Q?Ce6W+K99fSvpPDeU5M5yxAI9eCOwtqYY/TUERbeSU7Ir0kjpWta8JXP6GawG?=
 =?us-ascii?Q?HGPfELJuGNWm2efcu8TbeYCchsTHleyCuaNDjEo3datX4SRpJ7n0Akv7XM4u?=
 =?us-ascii?Q?pO2IP5dPtFlefbWmiKpVEgqFwpttd+wVKR5URd8uoqL8+zqTsYhnSY29gPvj?=
 =?us-ascii?Q?w2Tg3tnyTnHsW5O9D9eygCA0dFTt14GlLJKA2wSk8LRGUG1PgOfo/WBU5hIv?=
 =?us-ascii?Q?Ii8TGEAE9sXlz9FKB7F0K2FokNCUnM+CY+9yxI3NW/ab2OlI3jpJgQJ5iUxR?=
 =?us-ascii?Q?1BsAJVdzlFyh9kFmWezrPF6+O52VCCc0d8QGbtWZ+ZXFveKGkBre1KZI+SeL?=
 =?us-ascii?Q?L/t24l8UY7PiA5H1QcAfi4FpAC/A3OT5TQrmyj3l9RDQ33A85bqxt7B5Mi23?=
 =?us-ascii?Q?eC/jU+y19Yl0X7msN+IZYYmPwhxU5LhnzkVLsHIdP98tVyjDMEVuWhE19+kx?=
 =?us-ascii?Q?+UabEdohzoMAFGiOUFzOLB8m99GAt2Vi++fN93Ox0LV3rA9Oh1JC0AzXF7ab?=
 =?us-ascii?Q?3xBvTo4SXPlFy7F3vQ9sXxcVPZZgdhKiRsfvZVRgcZPM2hgTAYAoREkju1Zc?=
 =?us-ascii?Q?RyWfsaxRxKlwv5p/SFgbeYk+4k1G5iGj7tJBZPD9nn6+69v0ZIrxiIddFkLl?=
 =?us-ascii?Q?sZ/EbkMkKNMrVUVjF+CmSyp/UB+8/l5cj0pQRvmDENJk6/bh8vEG4W8OS1kD?=
 =?us-ascii?Q?yvzkr7oFaY090tJiLLyD5CG/Ph+2II90PEC4ogHYFgXy8GsUblwct1A8z9Ri?=
 =?us-ascii?Q?8LbMhhNwEAnlHyIJpVT9PlQzsuUbx1Jq+sF/JcotBr7+o1WfoOSmA5b7Jo2q?=
 =?us-ascii?Q?b/jd9m/OSM9ql7WbZQBv530a/27H2AkZmqEavyHYk0PXwoKPst2GCRkjCT0/?=
 =?us-ascii?Q?bHK4e74OlzeZMH2Y2MUyJ9GX6v8u8N02OBEJC/Jrd+dmjdLBO0cbw9dW9YT1?=
 =?us-ascii?Q?x/r6nmRDF0v4USPYtZt9ZIkuG2cwa3W0AYQyKG5ifYd3Q4KID5Eflg6IRypA?=
 =?us-ascii?Q?+2Z7FUXxKBy0e6KvBfHLpbeL+HXDhgDPPY7jozajWETk3yrI0q0YKJaz57it?=
 =?us-ascii?Q?pE8cBWaITKDlwgR8wLaZkZwvKvW7y6z/IpoHtrYOoQQsqHYRonVhvRh/8scA?=
 =?us-ascii?Q?95ItBmrBgnyF20Eri7FiiPccfDaH3xEP33o+q1+sgSL+tbayNtZ/NmjeZfwo?=
 =?us-ascii?Q?/SmEQWQ0N5OfiXISgXwrNX573tVW0laWArlgxrBMvFjMy2YMDNJ8BTTHZUIC?=
 =?us-ascii?Q?sVHbm2Uelv3iR5D2ER5kEF8o9Zq1c4XtdKU6j0eOrWuu/nUxipsfgadyvmLw?=
 =?us-ascii?Q?6W2L4x9UsC+AGrwkHi0x1PI6yHmL0ZMy5lXFqhmcSQhufDw0Php74d6OYzjo?=
 =?us-ascii?Q?TdOF9LF3y7WpZeeTNkmP991nz3W48b28IEK7i/hn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f81b3f-da72-4668-d71f-08dceb8a660e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 13:24:43.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6du70WThVPloBx2lh+PYEZoTLFa8++mROnoMPkOyKKM8g+LE55IK8MKmZloms+0y5itZQshWA15Z6sfs3ALadA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

On Wed, Oct 09, 2024 at 10:28:30AM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
> no new skb drop reason is added in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index da4de19d0331..f7e94bb8e30e 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
>  			DEV_STATS_INC(dev, tx_errors);
>  			vxlan_vnifilter_count(vxlan, vni, NULL,
>  					      VXLAN_VNI_STATS_TX_ERRORS, 0);
> -			kfree_skb(skb);
> +			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);

Shouldn't this be SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND ?

>  
>  			return -ENOENT;
>  		}
> -- 
> 2.39.5
> 

