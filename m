Return-Path: <netdev+bounces-50020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C63367F4458
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE06B20AB6
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA74AF9C;
	Wed, 22 Nov 2023 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnGz/+6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDAC1
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700650396; x=1732186396;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r/7WHNKYbZT5713zH5pFkjONpaFE9MlPAJRfR5Cp/t0=;
  b=CnGz/+6ZbfBi+Jb2BaUpp+VLdtVtvX4KljzqFsVBsVzBhMz52elyMJFT
   f9zViBmBOGglbJtQIBL9C7aIZSRqBoRi8l+JIdy4+0z0ueP/09ZZ6r9JD
   EeE2MY7/RLH8QtCQR4e8apMQJB88oTpZTMJAKdfA6sObcqdD/3tbLQVf/
   zL/l0xbvEgLe4ov7eKtBswcopF2t9RXNz+isCEo0wwxwaLCjPb/SfNAiw
   tB5oIFVGWUB30jjs3T5BzUZNi9ZJbsGJuoFWA659m9wdhTdM48O4Kj1wC
   FxnuyhihRXZ7e+tgJAPMMQ0BMVfxMMjvHQGPwJEQ2Wz8mY8GlhXiWoOw0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="377060492"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="377060492"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910752415"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910752415"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:53:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:53:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:53:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:53:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdwmgxopcGUkg7Kvw7BYbvRwXh2m9JRZtCXKXMqb5Pw1B6gkOAd8u3hQ6ekeCMciZa6FnwaytG4auVo8WDucYZV5YL9Skb1JBoPDjlioFrlYM3dBBXNwg4oS5AFEhnY8EK5EHptrVyW31c3Sk0SEitYsrmoY7eC/Sw3gfr8DuWYPbZnyKVdLkaHwGRyIu/dmdWZ9vpAZCZ4AgGli9pivpSB0l3a5dHRO5DKbnPLJ3otxtDPlsbdXGBswKFuiSTnFdMIC8AAH2mUAE5vDa7R+2l32o8t/CLdCJ9IyeIO7eI2OggEv31cgjqX7DkFiQj+PABq96Iu3HaENWisn+UhUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OROL82+Qt5AnKIqkcoR8UmfbkKbiCB5YWwi6VfENO9g=;
 b=T2d3jKkHS3aKOJ/QyhrCrj2HWJfvnceeQhorVbTgLw7PFPmyIzLaF0vbZhWqRbir0zCesYoN3SoALIkljuOAxlS7D+HTewmGn3bTf2BHRzm+xeQzX64qOsduaLh1w9OXG517LozBrdaqORMN1K/6Nv7ve7vi4uUIS8FWPViwbjp9JcyGoIyyVKIt8h+BtVAkPt8S8IEf4JXw/md2q+t0RXe/gWVu7GnmAXXv8wtcip0EPGOlaJqlWsWjni4jATVf7Y43QjTTIJSdKru8Br7oakwr1oYpnuGgK+7PsWTZSPanOoefvwpj0VIiPFn54vW4Fc2LD3+xkG3RwuifSwnYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 10:53:10 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:53:10 +0000
Message-ID: <564e559c-3b31-445d-b3c7-1584ad78d1b8@intel.com>
Date: Wed, 22 Nov 2023 11:53:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] amd-xgbe: propagate the correct speed and duplex
 status
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
 <20231121191435.4049995-4-Raju.Rangoju@amd.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121191435.4049995-4-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: cff6d3c6-254e-43dd-4362-08dbeb49379c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZZbE5LDzU2NILo//bzqy5RC6rFkUxQ79bdkJYFTqSBnFrVj9eUVp6yTaptihKMn/STXm561aRG4xLWZGngvVEYdCj2miR5n/ySGXqacuw5J+qytZFlYhMIsX3aDf6EGgFpu0IqmCjSDTqRFnqI6t6sLsT004R9gtgFrjIv2gt5165RliAGyHSJ4QU/OBw9bPwOG2W8kE93xQgZ+u/2/52ua7T1MZ7GaP9C71veviede0yhgonbA/opx63/svTXJiEFaqrVri87pd11GlquIr2Bh5khiTYnS4e5mj+vheBAoLCHNraFtzm3upIpU2xxrFRzJyhkbabPZrmyuEBNQ82qSAHM5OwnAtcKEHtP2xNDawxuEDLODceW73JnzL0vbRlwM7YdAkMBc1RmRHLoxeOy/ndyyD4Zjcyjl94o1CKfYvLBwzkzo3j15kTgu/qZYlAZzQSVAy+iYCg3XmDrj6z5GkGngkaQA9VJS9YyowZIlUG8Ql994/oJ7CBp4EDp66UEZWAXRDCgTioZfOE4ConHiO994Wy+62asi8ceROAAV/Bt0i7o+yz5QB+8UPWYJGhUHujMPrWgA0ui2enpchQ0P22yGVGv1UHvSDAFhFZ2XO3sJlnTc3hit4ADc1s0aCX9ZYNkroL1XXRoIw/EyGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(6666004)(6506007)(2616005)(6512007)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9scG8yb3RqTFNSb0VsdG1xSlRsMEVaUVNMWlc1Y3hkanBVNTIyYld1OS9G?=
 =?utf-8?B?TnZmdjNPY2gzbEk0cHpSeG9jNnJLRUd1eU5HWitlVnY2cW1DbVpORUZMNk94?=
 =?utf-8?B?ZkNJSHJCbWRWUmgya0tHdGdJZGViUWpBTEtsODJ6RUNveWJSeUp2aXlqSVZs?=
 =?utf-8?B?OXNVb2g1dCtmRjRiQkxBcnBpWExLRm00N0VMQXNsTk8yWkdiVHdnSHRDOHFE?=
 =?utf-8?B?TlpCMHNmUG5iaXFHNm5YdG5EZU9qMDFSRk1jQUxvVXI5NUMyR2tBcUZJOVJC?=
 =?utf-8?B?SVFSOFByc1RxZEwveDlvcGpPZlV3b21uS2lQaDJTaFVrcWgzYjB2TEMxbys4?=
 =?utf-8?B?bE5oTnVHY1NrSGlzMHh1bWNmdUZHTWlrZzQyUGtVaDRSMjBkNk8rR2d2a1B0?=
 =?utf-8?B?Ym9QV2o3V2pGUksrZWZ6MDRsRjFTbzRpT2xtUWUwL3dDUmhlS3BDZjc1Z0kw?=
 =?utf-8?B?UE9BY0YwM0J6RFpVbUlibUVVbXBKa1FiVm9TUnpYL29FUjFVS1o0QmNWbFdU?=
 =?utf-8?B?UWZ6TFFvMnlEZWlRcm4xMjBTUmNnVTViMzJKWjFZMzU4MEpmVUl2bTA1b3hi?=
 =?utf-8?B?c2dtdTQ1VlNPbk12N1JJckhwUjRKdnRHMy90NStpc0tRSUV3UTlSVWkzYytl?=
 =?utf-8?B?N2gxY3RmMmREZlQ2bjdhTTZYQytNOHdsRm5ndk1FejVNck55V2VNWFZGU3J6?=
 =?utf-8?B?aWlvdFJMV1NDNHZxZlcyQnh5UkJZKzA4ajdPMnVsd09pSUpSY01Idll6Tkkr?=
 =?utf-8?B?K05WanNNdlBrdWxXa3RZbE9yOWN4UWpiYUpBYURpSjR1OXB0SFRkMUVwL0lh?=
 =?utf-8?B?QzM5aE12a1EyT20yYVlrSklIbjNIOUNTRzVZQWxGMm53cWV6OE5hd0VpWC9h?=
 =?utf-8?B?TWhTU1JpZHc4RnBkSTZXOTBoS2MyTU80VkJZZlI2VTMzRDBIWXlLNmhpZCtV?=
 =?utf-8?B?OHFhaXppTXhMajZURkFXUUZkaGdxejdmS2E3dFRjZ3M5MnJtd2tldmc3UmJ2?=
 =?utf-8?B?RWYxbFF3d0pPNjFUTys0d01qS0NEcStLWkR2U2JHUmJuVFViSVJqS0NNL3JQ?=
 =?utf-8?B?eWFIaE1VbXprVFlHclltRFFnTlVZMHpvZ0FCUnZ6UWxiSzhDaktlSUMvQVRw?=
 =?utf-8?B?a2JkaTlOOWMzK25neGlGYXQvWXdWM08vbUZLbFpwQ2YzM3N4QnROVnByQ3Bs?=
 =?utf-8?B?VTJqRXJhMHJwWkpQb0Fuejd3YllRNEx0c0N1d1doQVY5K2NpcWJOSlNyMTNk?=
 =?utf-8?B?UXdyTithcDJobmhtVFlROG5CTmU1MC9lRUNuc2x5Ukl5ZjlScC9oRlJINWE1?=
 =?utf-8?B?YW9JcWJiZ2tUNWhEZm5heUFWMlRybjJDY0cxa1d1QlZoQUc5ME5Yamt2RGo5?=
 =?utf-8?B?MlpiT1lhNWd0QlAxOURzQTVvRDBQZkxTTDFSTkxEUkM4TDdMNEphMWU0amd0?=
 =?utf-8?B?b2Y4S2xaODh0bUZocm5ITnZCc05XK0xlRjZBL1B5L2JWTjR3ajVHWGd6N1Js?=
 =?utf-8?B?OWY5TzQrWnBiZytwaXZUa2hicjRXeXRyMy9UaFdQVmV0U0xrOHh4TVdtcGNl?=
 =?utf-8?B?eWl0VnZ4UVY0cWxJaDFqZlBRajJDbEM5NElsS0VLcHljVThmMXZsUnpMWkFm?=
 =?utf-8?B?QXNNd292U04rYWI1Y25yTjRSRXFCeG1DUWI3TlhEcmJHNEdwL3JhSDZhZzRH?=
 =?utf-8?B?RkJ6cmZFQ2ZtT3hpd2RpT0tpeWR6bS9CNHhEVDIyOERROGdFTHVOaEdEZzdH?=
 =?utf-8?B?SFkwb1R1L0VsRVZuVzZmbmxXUmhOUkw3MHg3K1FzVWtIMExiV2lvYTIrL1lC?=
 =?utf-8?B?MzFmdGc5UzZKVFFDKytBMHFiYU1FRUxCbGhYaEplWFhiTDE3ZWhCZWVsb0Jo?=
 =?utf-8?B?N1lGZVlHM3JtZHFqSkU2cmQ4WHdIMHhiM1ZlTmFrWnNnc0ZiNnMvUjRDeUVO?=
 =?utf-8?B?SmllMlVnaU1MMTdLQ0dKU3FFN1RXOXFrZnNIR2FsY1ZMU1EzeTY0eXBndDZ6?=
 =?utf-8?B?aUc5SWJ5Z0pWYXo3aU9RMC9qMFFLcnJoOXBxWktmclB2T0pFVmlTNkVuV0NM?=
 =?utf-8?B?ZzRMMDJrMUNvb0JJTWt3QUFVZXNpZlRBNlVTNFBrR2t1SElSOHRXcmc2K3Fj?=
 =?utf-8?B?MjFkeFFQTFdtRnpqNHNpWDJiOXFHRFF6SmNFUDRQUUFYeklYaTQrSHQrazQy?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cff6d3c6-254e-43dd-4362-08dbeb49379c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:53:10.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZBx6ZanyL3ZaF2nATGcqNX4+eKf7nUor8QcWQeP5RmgOWebya9Fs787Nd7bx5ZFoptdcLVe3EhWNL0PnstZufNzLGmUPMDPXoW805t+f/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7971
X-OriginatorOrg: intel.com



On 21.11.2023 20:14, Raju Rangoju wrote:
> xgbe_get_link_ksettings() does not propagate correct speed and duplex
> information to ethtool during cable unplug. Due to which ethtool reports
> incorrect values for speed and duplex.
> 
> Address this by propagating correct information.
> 
> Fixes: 7c12aa08779c ("amd-xgbe: Move the PHY support into amd-xgbe")
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 6e83ff59172a..32fab5e77246 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -314,10 +314,15 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
>  
>  	cmd->base.phy_address = pdata->phy.address;
>  
> -	cmd->base.autoneg = pdata->phy.autoneg;
> -	cmd->base.speed = pdata->phy.speed;
> -	cmd->base.duplex = pdata->phy.duplex;
> +	if (netif_carrier_ok(netdev)) {
> +		cmd->base.speed = pdata->phy.speed;
> +		cmd->base.duplex = pdata->phy.duplex;
> +	} else {
> +		cmd->base.speed = SPEED_UNKNOWN;
> +		cmd->base.duplex = DUPLEX_UNKNOWN;
> +	}
>  
> +	cmd->base.autoneg = pdata->phy.autoneg;
>  	cmd->base.port = PORT_NONE;
>  
>  	XGBE_LM_COPY(cmd, supported, lks, supported);

