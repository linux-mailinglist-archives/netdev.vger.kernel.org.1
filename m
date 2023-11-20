Return-Path: <netdev+bounces-49214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A007F12AB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 13:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D4B1C20AD1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024818AFA;
	Mon, 20 Nov 2023 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+NyuWt/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8488E
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700481908; x=1732017908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hy0j1+k2Z7vefmyBwYw9K4Nc9BiYBO+FCOJWlm900wc=;
  b=a+NyuWt/yfwxjON2qq/+PyBuwsy492vE/SZehN8db+VWyDMRHNu69ld4
   IMv4qxM2+p0Fd1zcAX6eoOCOnKIXd15rXuwR/EfhYmB6xl/aXlAmcDNCF
   K8gviKB4rFhAbcXHGiprV1oxOwiwa5BLnMj0w6ifUnbWygp7RiIBaZ05C
   JKda5BPm9pgPZVrENJzJvjxl8zPy8VM/CjEnl7pXI40H96yavejowGzFi
   t9uZG0ePOamB4x8XEAxEVbM1EEbxzBkvaLH522GFSO5+Vn8H/6cZrhs2J
   qbKB/swl546eTcdyPdPtOs5o1CMweZ2v3tnWtKk1fsx/6ebQmjj+X/wfh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="10281101"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="10281101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:05:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939780073"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="939780073"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 04:05:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 04:05:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 04:05:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 04:04:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 04:04:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRACU+aOq4QwpvLuQL1w6H5aKtbsx3eH7JqIM2Rf6Oh+Q3BM77pxul9bjiodnMB6N9jA532jcOP6bYcPSG6ADfjiLFAebJVTkoC3R6nzbThn9ftXlK3UlM6n0nvyFlA6V0JnTDisaI1zRT+pn0o/pDGL5i4KRc9tQR8RwKR0H3Qfhl8nmG/4wPN7PaHydFSqDKxQR+FQkycvg3C0/FUXn05nbSz8iyc2I6ItxVA8tSsprVLxB0TpLv50Bbf8a8c++O9xnt/g1IOCD3+ZbAEPhHKvEvxl6kH7PuuDhP0Qj9xVPKZEjLjWPEd/qn1odMbnx36F1Qoek8tduPHiy4/Wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BulYT2UbQiGN6fJkkiwJW6BgMBPZTQL+AzR8EssZ1Bs=;
 b=CPLugas2pLPAfnCwjX50VbeqaVNyUoefDSTuxlElx+kvZ0PohMMgIqdiWRXMGXUBP5vEK78L8gRxqJlCUoA1E5O6PxAzf+f6RJuhAJYl35wx14l9ypN6+VqvAUGGjRaKRXR+gR56n0JSZRazSphdB/ye0qGD2vF5gz42WSSgLBY0zjtxtxRIUxXEv2k9H6tYOBrcQ2cgHINriLBinDUdp40HqBev1IYzgkcGwulXvn86MJJOs5cMwAf01DgkF36WiLZ6AOU8GfhKFfIj52UcRQ+kDzNr4OH8WAz8YNritelLwSuqvbtwrR1AHj4ttqEk0R8o1YOkSbMLLO1LKXtCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MN2PR11MB4549.namprd11.prod.outlook.com (2603:10b6:208:26d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 12:04:57 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 12:04:57 +0000
Message-ID: <8c1c67df-945f-44eb-8344-81cbaecb6ae8@intel.com>
Date: Mon, 20 Nov 2023 13:04:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phylink: use for_each_set_bit()
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <E1r4p15-00Cpxe-C7@rmk-PC.armlinux.org.uk>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <E1r4p15-00Cpxe-C7@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MN2PR11MB4549:EE_
X-MS-Office365-Filtering-Correlation-Id: f5decaca-9cb8-4cc3-d948-08dbe9c0e9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOCtiW69UQgqHCoDfYGPu1pmnsVDSBfs34P3soFQHTJCYKHFJWKMx+R4qBlsAZnWgAWT/XItxgsxmgFHgFGaMIpJQ93AFjTeOI9p9vHRTqBGzJJ6zN9iJ9611Ycgw7/+D4jBGylYscoyA5T7znhpOKLv1hSB9mjUOeoZtnz9LfEP8hRcM4B40+i+qUuE5Ftd7cdXLV0yAkYdf5qtYGCIRPMhNC06ZTbI5sQ97svfmkn/QbWSsdpX6i9g21hHbbnWfKnasLEX1h0ZSD9sxwPVk/kcA6FG6chnq8mItOaGYew6mb3al1XRIERIuit5bFlNwkLRfiQfTQnvooz3EKCBCrsFQUanLM7KKw2ZxEJ3sUU36oneh+GcvXbdVpDRcRp+virQVfqi20yd6SNw/6sxRlWtlypVLqBII2eWEtCwi7ArQp1NksW247vd0PXLbMUsmIlcDT8eVTWLb+brgXBTqm/5aW2QI+jaiBdOnYifw5cUgvJ8Muj239Zp/k4sVgyKGwa76ci6j8pEblWYqa52HiBQ297jspysyuhcHGsp5yXBwkbDCO1/JIA/kNIlb+nG5dvergfCJxxil4OYRnEFiYyB9O72uH7S5x0TF6gk0doS8zCvL54MrEw8GLzjnA5F9RVEcHh745VfGA6HuK4rvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(44832011)(5660300002)(4326008)(8676002)(41300700001)(8936002)(31686004)(2906002)(316002)(54906003)(66946007)(110136005)(66556008)(66476007)(86362001)(26005)(6486002)(6512007)(36756003)(6666004)(53546011)(2616005)(478600001)(6506007)(83380400001)(38100700002)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNiY0hVVHVhRWpieTNYMVVYejFhUVM3RmJoTGVPMTduSnFQREZETThkb1Yv?=
 =?utf-8?B?UGlveFhVM0RjeEJRLzQ3d2I2cU1IdHcxd1kzRVRXZjJ4UTVaOVlhcUNwRzBi?=
 =?utf-8?B?TXB0NjNsb1RBME5XcWliTVZHdU1ZeXdra2JQVDdPVjJsbFlnbU41MWRpV1Ri?=
 =?utf-8?B?VFcwTzFQN09OSzZDdTNVWVJaekxGOEJLRWQ2YklWRjk3UUl4N3YxMDQ5ZmxB?=
 =?utf-8?B?a2xlcU91bDcwZE9FVlRMTXU3dmF3cE04dU1Ra3lMTWpjSXpybmZEcnBvcFAx?=
 =?utf-8?B?Nlo1Z2ZsMENkNlFqMkVnMEtnM203a3FvM2pNNVM3cjkxR1hFLzVmbkdZUmhQ?=
 =?utf-8?B?eEpoNkoveFRmZHdnS2ZYeG5DSGVGcGUwaEVUeGxEcFVWRHFXQU1LTmlvdmZC?=
 =?utf-8?B?TWhhR2M1U1Y4SCtZS0I0L1RDVUVkK1NUa0VKUjdEb25QU0tZaHpZaDFWVHpu?=
 =?utf-8?B?NEpROEhsd0VLMHRBRkM2VmNTUnpFaUdaSld0aUlrOVBPM1F0R1VkRkFqcEQ0?=
 =?utf-8?B?T0lXYzJhYzJFL1VIR0RsTUxHam8rSFRYWWhYSHkwRm45TkhPMEZPaFhQTGlG?=
 =?utf-8?B?Z3B2YnVJcHM0c0o0TjQzQS9JLzBWUUpTeEdwOXhVRHJEL2ZtMGxBRUxvaHhx?=
 =?utf-8?B?RE85anhKVkNzeFpOUFNtL2w4R1dUeUVWY2lqaXJIME5YRUFGc2ZhU0Z3NzV2?=
 =?utf-8?B?QnlnNDNmdGloMkJMK050MlBJODViTVJST3FVd0d4WWdOYmlHc0tOdGhGTWJL?=
 =?utf-8?B?WEdQZXM2azVVOTVRSXhiZHBtRVhUNU9xWVZ4TWhaY2NpOTN6SEJyamVVL0lI?=
 =?utf-8?B?OFNDbG9oNFhYRklDRk84aWJWbjYrSmhhZjN3UUsvcGNNNnlDQ2FBMDZzR1Fh?=
 =?utf-8?B?WnFHbUViWUhQbisxMCtJTmFiL0s2NlJOK2Q3QXBiaWQzeTJDbXRmQXZSazRS?=
 =?utf-8?B?QzJyVHRURWZDUUszWHVGWnZrOVg1UFllMDdjTjcrTCs2OVF1ZzNydGFocVU0?=
 =?utf-8?B?T3dxZEcxMS95VkJMcnNzQ2gxRy9EUUFDYkJ5QmQyVnhISDB5dlpYUDBtaGRs?=
 =?utf-8?B?QlYyaXg0ZUVXbVFVTEpYMjUxdU9hejZTQ1pOTjRMZkxjQ0ttT1RNM0R3OU9L?=
 =?utf-8?B?aERhOFVMekMvbE11OU9qdkhsckY1RGhyYm9IcTc2eElsbklTUVhUQ2ZqU0lj?=
 =?utf-8?B?MCtId2FETnBRRllFakVoQU5CZkFxT0oyMmQyc0pBcFh1RGxSYlFLbWZQMTAr?=
 =?utf-8?B?MEo4U2lMTXdKQTA4ZVpjTDBCRE5OZmU2ZWljM0o3U1BTbjNNR084NnRvWUNC?=
 =?utf-8?B?ZlRoWlpRRlFSUjdCdWNrb21JY1h6ZkVmL3pZditQbVp0N0tRTjhFUWdzNjhr?=
 =?utf-8?B?Z0FDMGtnSXBEZVRmRUQveGIyU1JxakdnWDZnQ3BJRzh3dDg3clJYcVZIRFV5?=
 =?utf-8?B?eGFEdisxeklYeTBBSFd1VmZ4aDRSZWxMSkZyc3hZZW5DOVczbEwyM1oydkRv?=
 =?utf-8?B?UzlrYW40NXNQejJDZlV5Sk52akVXWHBaNFdxZlZXN09rclFwYkFRSUoyQ2M0?=
 =?utf-8?B?ZFA0aDhvM1JqQmJ1V1gzSXlBM2JOOVVVSWVzUHdrOWhwbGhYaUJCOEpnWllC?=
 =?utf-8?B?d1hXVGprVU9EdDNDSjRiM3gwWUI5em1QUGpFTkdYS0JWWmNTdUxUaDlGUWxp?=
 =?utf-8?B?U0FnZXIxdVMxRUIxVFlWN2svSXpPcG91RFNmZGdrejlPdnR5VjhMaUIyU0RY?=
 =?utf-8?B?ZkN0OHRva05vQTlXM0g4SzZudER2WlZzL2lxWEhtSzZoRHpadms4YS84RUVW?=
 =?utf-8?B?bXMzaHBDZHFlSzBXbW5zOGxad1JiU25DK0tkbUd4UlMzdEZmYTl0WWhINUIy?=
 =?utf-8?B?b3FZeEJ4Y0Y4L1Q3MG1lUGtXUDVnOXZEQ3c1MGlQWm5HbDR5bElvZS9oTmlQ?=
 =?utf-8?B?SFpLS0FNZGZ1cERNdlFXZ3cvV1BXSGVCN1h2Q0lrM0NiRk9KR0h1NHFuendN?=
 =?utf-8?B?dUtSU1F5cUptYW5GcGlnczRVbE5rUGVNWWxUNWlaTSt1WWh1Y0V1c0EyS1RW?=
 =?utf-8?B?TXlqd2xKQ3BPeG9VUmxvVFVzWmpGV1J2eDFWNDNkaXZPMGF2alB0WlU0QXBi?=
 =?utf-8?B?Y0VQSU5NSVZHZnNSU3FGZWtLZ1FlKzE4YjdSaThBSlRUQ2pqdUVjazE5Ullt?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5decaca-9cb8-4cc3-d948-08dbe9c0e9d4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:04:57.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkcQjD9cJ/0Gd3XD8b923lI50464c0f5fPe8dueX+9mPkVmKbrkLjguXYp2weTdbOypzpwQaS/TIL+fYiRu8a/EGYtXg2PFXUvtxZW0HS6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4549
X-OriginatorOrg: intel.com



On 19.11.2023 22:07, Russell King (Oracle) wrote:
> Use for_each_set_bit() rather than open coding the for() test_bit()
> loop.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Nice cleanup,
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/phy/phylink.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index d2fa949ff1ea..c276f9482f78 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -697,18 +697,16 @@ static int phylink_validate_mask(struct phylink *pl, unsigned long *supported,
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(all_s) = { 0, };
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(s);
>  	struct phylink_link_state t;
> -	int intf;
> +	int interface;
>  
> -	for (intf = 0; intf < PHY_INTERFACE_MODE_MAX; intf++) {
> -		if (test_bit(intf, interfaces)) {
> -			linkmode_copy(s, supported);
> +	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX) {
> +		linkmode_copy(s, supported);
>  
> -			t = *state;
> -			t.interface = intf;
> -			if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
> -				linkmode_or(all_s, all_s, s);
> -				linkmode_or(all_adv, all_adv, t.advertising);
> -			}
> +		t = *state;
> +		t.interface = interface;
> +		if (!phylink_validate_mac_and_pcs(pl, s, &t)) {
> +			linkmode_or(all_s, all_s, s);
> +			linkmode_or(all_adv, all_adv, t.advertising);
>  		}
>  	}
>  

