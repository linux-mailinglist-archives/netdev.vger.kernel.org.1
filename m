Return-Path: <netdev+bounces-77977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E89D873AE6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A4F1C210E2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A71361A4;
	Wed,  6 Mar 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnToX0Xe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66811353E4
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739498; cv=fail; b=RYD7xuJiLXpcU2Suda39hlQiwcXfcoqXqjG3zAqcXULqIp3elEy+aj6hZ+j0LS7gG45pM7PArVpRcda4t4czE4Q89vEdxGDXBgxlh0SlW6A9Wowdg+PjhVyW1krhXHXb5Mv0C51pXjfF2LYRk52CwHR+3sfExMDKL4nl1k0nDTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739498; c=relaxed/simple;
	bh=Vwiw226hcS6SlIpcx4OQKBDVnA8EfkFiaADG37ejIoY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vm9gZ7vOm8r3YEnilJUT9ShnE8gyTjiRG898y/U60/NAhcMZlscgOTFa/8gQTgxsSAOK4gWkRu9MkU3Z4wjDv+Dw1PH/O5QPZArN2Vsmn2n8vP22t2CwZRfV4PDpxNDhK638Ps9j5vNEpbOfLXOZDhB498U7OegQzGhQe3IeNy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnToX0Xe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709739497; x=1741275497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vwiw226hcS6SlIpcx4OQKBDVnA8EfkFiaADG37ejIoY=;
  b=gnToX0XewFTqVmGU62ExXa8hm6BsSNOcI1kSEGiq2PxqihgXNf1O/ogV
   GIHwbn4VAAL/Gxc6xQ0fS6GWxDMdi33tGm7F+6dY+hymNl1tWGgOWTDuh
   DOXrCqEak58FyW/+uzOQ9Mv3YqNnr6cohxwDkxkg4EFJmMOAnolPq/Mjl
   Fp2WFkCi/4RVH7pSkXK2CxY5vuh9yw5NQ8/zpGWVuT4pXVQ2UEMds8zw9
   Wl0LI5Wi4tlRvAj9Q0/jN0aXwUuNcJAVm+9NpfOErC1VY8/U8XJ0+qsBU
   OZ1cmpIVmwrwna09E6NNuofUvT0f8qoWSLx3tjrcubevLq+TRH4ufg0Nz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14933662"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14933662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 07:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9771753"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 07:37:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 07:37:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 07:37:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 07:37:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 07:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8hhFwEZJh2NmY0NJBHd8R69dYpqcIwvKg4JbzVuAQaqNX2U0Ewgr81GyjxKFT6Zhl3LJKp/RqqYxxvsTry8yz76vjA8vRqv8+fY3EAav7L76Kx2HZ2OnowH7VAh2Ifwz5/y6KRHiPTRWl4qidGvxR8ZSvGfcwP/75J71cusiZcZgP8V3OmTYyhypat5Q7MiVuLdS56oa4IhWRpsVP3MRc6KKUsDfs/AExq4c6jTvsX5lm4246vuCIj4EQ0lbXj4fPUOZxMboOnw6PsAJdab/YolNp+7ZTRZ7zYUl7qgKwofvkFcyiHUbW7mDEshW0c54sQxw2FzHUyKCFpSgCLXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaayY60iWSddz3GmWFzPuGMfvX8KkXwVvOVUXEhYx24=;
 b=Bk/NPdIe4bbT8C25pDc6UYmwJHotcj+jFcmFIchnH8a46EWMmv+p4la4fu87vBpvYDMIYtjQf+Qa4iBdo5jQQuf2U4kV23NgJjqk73JxKbE8+x9QtOwvsYSGW0+qrXuKdA/gS5s4v6Qu15Mevc4Lhk2YgmnLI40Ff6l3lO8cdc+omkDwIoIZG7/QsPi0knKqVlcoJYsbqpgVmz3xpTZi0FkJnAL+XZr1xfhIX7AFtU4NQUHEHEgaPKHs5yEY8QG8Qyf8Jkzqj4oJkSUFp3phUxaAGfStsFpuCx6Y15A//6VQFNERbfSvviK9HnE9vI30o/2zRcLP9CbIjEVe7PiYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Wed, 6 Mar
 2024 15:37:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 15:37:45 +0000
Date: Wed, 6 Mar 2024 16:37:41 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: David Gouarin <dgouarin@gmail.com>
CC: <camelia.groza@nxp.com>, <netdev@vger.kernel.org>,
	<madalin.bucur@oss.nxp.com>, <david.gouarin@thalesgroup.com>
Subject: Re: [PATCH 1/1] [PATCH net] dpaa_eth: fix XDP queue index
Message-ID: <ZeiNxaq3jzloO9l6@boxer>
References: <20240306143408.216299-1-dgouarin@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306143408.216299-1-dgouarin@gmail.com>
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd9206d-1b0e-46b9-43e4-08dc3df35e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tykzRcAr2GWIz1zo9HwYiVmaMxaKeu1GrSWUNK0TrIGmdXVqtSFnAKtE5bwP2esnuomt/ra3EA83qwWUZPqchX9u4Q2rXc2fb1uvDKfmvS+TmE0pGARiSIb1xfCDcvxChMfpBcvK5t2knhLe1/UoXNeQss0zMkuFGF8Kz8chEM1Uc7vDOJixSZ3QrUUkGldnQLkUuQjhRH5FkL4ldHQ3gIJPdoTrwkf4jIxOWJFeUb08rEQwECdF1lmfJjZv+OkZ/3Nz1X0haDw4M/Nro8MrBRO1A6ECmkf3QWRh0hIEwByjX92c4jDunx+Gnu/U2dgbxEIJD8x3RODjy3Hh93SIMznJmtP0xCEeDbO8BN5cpNeurrnrTnh8k6Ce+gzQwvcMbpp2kwMmdMbcCQi11H2IaKzpzSHZWBkmppYlgNW2eqfiGvI4OoXbpFhofnDlNj3ynp6fPi7Uowa7NIVqRXCcx69aM6LEOCVT76CNBt+d40Fm8Sd5iQraOjzORGgvezIJHWYeIldpCzhwkx+boh7w0Pf5tLmD8UofC/hzcLM/nyvVPUKn0CLHozJU4JNjS+D41728Poa43ZbieUtFgS+EvCq72EOjvgPG/BO47V3EO7aYcGNbOcZz/ih8zWDqCYLbSQHJBtPxxKB7R6uHYaYb6jGOF3Axo0cPuabp8yP0SUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4b0P24UjSBqSzth8jNcu+T0sP/H/r3WUi0fMkKW3OI+CqzPEtUy/7SnBsu0?=
 =?us-ascii?Q?WfpdZQvZdSeqfQG39pWpSH31LxGjoHErOb5kCIOLcVVGqqNazJPE4l4nBx+/?=
 =?us-ascii?Q?V1Nt2zOqx69LLcHB0WZq6SxniZypTlin4M3xwY4XCoYeq9cP/ot2Pp+XYyLo?=
 =?us-ascii?Q?mtHbiBCE2a1p5p+SbQ2tENCB5CTcclIEWKvS9du1Akw2S5IdJNYyHbnGbvdX?=
 =?us-ascii?Q?DMLp/Q4GOJ09Qb2z6ZsdnTILFASIjRph0/6IuSZJvc9e97vIKKZnBtq/mAV1?=
 =?us-ascii?Q?/0CQGSgNO2Th1kzvr/RhJOA8qiOI3yyuxOMJEsQhfKX2IgTuXq9ZoOW6HHAE?=
 =?us-ascii?Q?YX5ZKDMbpZiExVQZQHPyt1VawRmmzSJMIV0W6saSk2nBri8Dk/uqF/muuIBe?=
 =?us-ascii?Q?OajgClxsssQau2DEGJ4wEMwRdb9PDHjcDwaIOqKeYT9kQklIqhKmnytbVdWs?=
 =?us-ascii?Q?K5DFk/tuC7CK3PzuETt8RzY1o5kxrNJmqqQw71r0+1vlIady2Ij7ypy7BUtM?=
 =?us-ascii?Q?I5V3n0XTZgUK27FSOZU1MxvSwkNyC50Uanmckv3rrFFbMgSDlQqlllb/Ue2K?=
 =?us-ascii?Q?84+ZQi/vEGo0EpRQKdznN5CKOJrdOR5dOpJDiPRzl2BGG60OSIvNDJf92pbv?=
 =?us-ascii?Q?nqOuKsBidxcQyfqTR/urL2RvVlQ4M+g0qII94Q2PyjnF7+Ilubb1xLE0lDTe?=
 =?us-ascii?Q?kQNsfKwqw85J2CAtAws/RP4/ckTbxii4APyI/vBpGkzKm6lGpfCsoXFQwXwH?=
 =?us-ascii?Q?jD72f/gsQ2dd2bbMot8AA+Z0sEjECabAgQ7BwGnRGJK0+tjGMZdTDvr2OXmQ?=
 =?us-ascii?Q?VDgWsnbHfd/FoO0jwjgrq9F2MYSwIBmzBgfaRd6q/LCQhx6TBHFx5He2LC2b?=
 =?us-ascii?Q?LM36VOclZPYU2xNWqUHTBwHQKnHYO2w+Sk454Ro1OPATz0GTOwqY8yrJvl8L?=
 =?us-ascii?Q?IPJJ1ItBVoy7RVFyQlbziBFXxPg96C63B2cO/GgjtLlFUA+Eiw+gN84AsVDd?=
 =?us-ascii?Q?eJrCg78weSyEsQOG9ELCqlL9dlwBfUub2S9en3ENT/6C+2/skMS7glISZGsj?=
 =?us-ascii?Q?sNjmt11/JibBlCAN2PxEO8kCkfNoxeqHsFQUM1un/852YpGjLiGnEJZo5OOt?=
 =?us-ascii?Q?tVMOpxlcYFWAahJwfp7zsmVmbgdTTex9rm5dWj2sZgU1F4R4z7Ff6gwLTm+T?=
 =?us-ascii?Q?2LSD4+X2KEgpVG/Yc29ZtcB1yvZL5k7MDjzMxck3fSSH2aBtbxQ9zUQHy7oY?=
 =?us-ascii?Q?SJLLjf83FtMrRva3/ZKqB3wYS5hcWvUA7o8sIJFh1mqG044wlIpoUORFv2em?=
 =?us-ascii?Q?iajiHtbVMDF02k7+QbZSS0+b2AgFhyi8lj0vfBdX7+H4G25nA71IEjcOOzfH?=
 =?us-ascii?Q?8JqniS1ZGZH8XVeu5D2vVfC9ohAdKsImWKXl/6D+X7NhDhOdg0oYCCkN7D17?=
 =?us-ascii?Q?HTGeg3m7pbYYpacFinxfxh2+bOUGt9oa8CYYN5PIc/JcchZFQL1RLtFQn5FQ?=
 =?us-ascii?Q?VE/Xr2gKyi9y9ZiW/ZFG6GdRmDxsvWsFy+s9VVpdqdCwjetjidZ+bRdzSwq1?=
 =?us-ascii?Q?HW9ZJmmlJ19fWGBiH0O67FKC3vBv7E7L04F2Aj6QM+doKNN9zDgfoYBN8L8g?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd9206d-1b0e-46b9-43e4-08dc3df35e97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 15:37:45.4222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1WL1hRpVVoERWe162M6Ydd9rFJUCKfGq4H4TXT2CnXCd0VZ66qUDcEwsJJcslMXsiWoMyDa9mBdE0HHGCH1VvAkBeF0VwxEqZ227/gNMcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com

On Wed, Mar 06, 2024 at 03:34:08PM +0100, David Gouarin wrote:
> Make it possible to bind a XDP socket to a queue id.
> The DPAA FQ Id was passed to the XDP program in the XDP packet metadata
> which made it unusable with bpf_map_redirect.
> Instead of the DPAA FQ Id, initialise the XDP rx queue with the channel id.
> 

Fixes: tag, please.

Also you have doubled [PATCH] [PATCH...] in your subject.

> Signed-off-by: David Gouarin <dgouarin@gmail.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index dcbc598b11c6..988dc9237368 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
>  	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
>  	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
>  		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
> -				       dpaa_fq->fqid, 0);
> +				       dpaa_fq->channel, 0);
>  		if (err) {
>  			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
>  			return err;
> -- 
> 2.34.1
> 
> 

