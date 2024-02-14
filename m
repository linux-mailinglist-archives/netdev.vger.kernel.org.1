Return-Path: <netdev+bounces-71850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6885557C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41491F26BE5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D27141983;
	Wed, 14 Feb 2024 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N82teXVf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBB13F01E
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948203; cv=fail; b=I7ff/MaF/yZntL8tFyZ7IELKcvJiQc8dMGPjVLlJRPbp1lJiyGqVXUckkgJgfKdKLIhiXCIU+ffW+aR97B8q6pRTbmyC4qmwhjCJ/uJyk1FOJH8d797U7OrDA5gjVSoAgxjdyxdQQf4GVvPZ2GFGvkxia5PVsq5UHZFuIFAb3Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948203; c=relaxed/simple;
	bh=xpl8gsNUVT84GvMpgXOVOa3KuJLwkk1xQX1ZNikNG+0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfSlGtWXpUB61Fs0t/Ap4mCvXyRpd8RlN7w5Um7m3jL9SSDAQ7Y7PmFsjKZ5mjROEs/Qe+TnAYvz9Pt+uSOa3iCGN+dhuExAS0x7xfiJWHlHkGT/9XJFCwkdZEmYypom88BuKEh8EkL54BwVCx4NspCgIgyxdxRRkVvWOXUwIHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N82teXVf; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948201; x=1739484201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xpl8gsNUVT84GvMpgXOVOa3KuJLwkk1xQX1ZNikNG+0=;
  b=N82teXVfy1zMBkObtHIuomTdJ93zdDrvuxdW6Zf4pywN16QsHLWVuvvH
   PbZhQrdfSIctfhFGA/2Xlojyi69pHPzu411/drP0X5SzKTg9YaMIylA+v
   Zkf1r1Tu8I+0KzvtzOFExkvlJ7zSZ+D7iFBPwmH3fx0XuDekdl9j6B0wp
   cxf9mh8ARXJyMv0GKQ73J782vk3cuBfHeD3G/n+13G6DMebLUS+GY43Vb
   jVKOMrHd+fIyQgnJX41/lUDyg3jGz32vDxFYtcl/V/2xbwX/Ud7ct/AFL
   rlLzcUzZxzZ4J9e7o+flvExdg6Sjd+g6dvxqBVk2LpQjWrLeMGxl44d3S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12733831"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="12733831"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3308741"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:03:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:03:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:03:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naCUWj8JzFHapD6Rxr3Z/d6IoA01Ix/c9SeYtlodbQFgO+yKAks1yyn0/2ojgoIRQCJYcIQSlmgCZ90yeZhlNhqsJrQQ61FSxiDvWCg9a0FbeXNLbUltqlG07nEDDtC6bytb+lzyz/xEB9u0W9sR91rUCWf5NTM/G7EmEwr4M9Dr/bVoV0bkg7v4S8V8XOOeZypeKkiP239FGP8EMSCT4tZP/7MTo8lgrJgefqWcB8VvSGOzeqXLxIFEBAWx9VHfCCHDEFNH8DKtiFjjvaVSLdkCA+KUap5WkmvA/Ttbr9UAM61f06dMOaGmsvawS6yVPlY4sm2UxPYMws4M4ERvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUh6eTeu2VbYkka6a//Tx2tJ47sRAjEcysMeleOIGgE=;
 b=eVIlm1rXKnyFZAvNnScB6LSzhXfXADyl893bHfcf+79uuO0gBwU/74Un/mlG/z4McoVf21ihLpSkxogaeBFwoWsW5rxySHl7Q85ngWK11IBz7HGTWLjOHsJlGSKYOKQ9Pw9gy6uAs2pGSduDsmeKRLTmZSaaXpFstygUiuHbHPAGJpomz6fOgKN0+nERLJUIWKRW83mVnwyBYt44f8+oNXv+Kg3oi/HZPqI/BwgIBb+1y/zUx4Uw9C8yc0WuMbF3JGAlAPgCUer7MIhMYu8+pzM/c0myO6rXPxzvoNA6CcxC1fWOE6mE7McQd3NZx8WOiXSvK6MLHBvjpQYstEo9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Wed, 14 Feb
 2024 22:03:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:03:18 +0000
Message-ID: <3cf1629a-a106-47e2-a75c-b299beae755b@intel.com>
Date: Wed, 14 Feb 2024 14:03:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 4/9] ionic: add initial framework for XDP
 support
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-5-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df91919-51a0-459d-7505-08dc2da8c04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FsOoqFOZN1gGmi/rm5kgAxFGoBFmYOog8UgHClLEulsYcHtBDc34vU8ZnfF0DPLO1ZvIb/XVDVVIxD8TlNjIzhXVSIK3QF6oxFiw/BoFxIoMBGuIJE0jAFBOyj1XGdQ+6mp+ZKTcNvGzBke7i4h5kfj02/CEBcdpaUC9nPu7vfrzdKncmNTgbKedc0dXvBaDZydu7ynRWTP/MVwRfu6r2ms6JwpsFP9ru55BOvbE3ARdpHj5EPWpy+NyFlxNdWcq1ASzhgf4ixFdTZg4zi289K5WTXcjMsqb5G3O1bydeuyAGWFLhzNTLyXlwXPDQ1CI5bzCbmNurSOPQP1WYGeqOJiCSa3oNerhdIsHlCrJ3xMP2/MCq8eUXnDqwKbC3wj6Zd5xIySa6w1/Gsks0h6RGZPIkKZ2jdr2SXQP/urGrYO4C1Zlasr7TTJH3xnft8o7h5oZL9eM/2+8eiLyPqP7NIiBiA9T1bbzmoC3eVpF5e1QM1PXPI+R7iuc5mBQdQgG/U8dbWZAp5zKrxSmle5iDIkZnnKq5h9hzxfi9y64pMck+/yvMHjCB0sWgvFLI93
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(31686004)(41300700001)(2906002)(478600001)(31696002)(4744005)(66556008)(4326008)(66476007)(66946007)(6486002)(8936002)(8676002)(38100700002)(82960400001)(86362001)(316002)(2616005)(26005)(5660300002)(53546011)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3c0TFJHVU1LMmJMNEhyN2VPbmhTb2FGVXhRZ1VwcEpQSXdna2VtTHdtODNq?=
 =?utf-8?B?TFBhZkVrRnUzMHZzOEdIYWVTc1BKM1dycWNKZ251eXRzMzROL2N2QjZqMG8w?=
 =?utf-8?B?QzFSTFB0ZUJ0Y2pUSmVNZ25ZMVRreHIzK3FRdjR1VlNoQndwcnpDRHM4YkVl?=
 =?utf-8?B?SVFRSytTZWNEZVRkQVJKZU1pb3lzSTNTYTNzRmVnTy9UWDF2LzFrclg1bUp1?=
 =?utf-8?B?STlmNmVvdGtmZXBmc3l0OXpkYTRDT1h0aFVFOG0zOEFOQndtYmFxNU4wYW1w?=
 =?utf-8?B?Rlh1akxCRUwwSVZGRm42ZW5BMmt4R3NVM1dyTVJya2Rtc1c5NytlRzJxcFNC?=
 =?utf-8?B?WFdVcy9mK0VRcDZnalF5SkozcnNkcWJBWVNZODRwTldOVWpDR2VzY1g4U0U5?=
 =?utf-8?B?MTh4aHZ3bWs2aVlpbjljd1FnVi95ZE5GbGFyR0xPNEIyUTk3YXVsSjRxQnBT?=
 =?utf-8?B?Znl3aksrcEdSaHNvVS9yTXduT0RiZE5wUFBvNUVDTDBRSFJUQklWQWU3K3Vl?=
 =?utf-8?B?cnJFbDczcUViOEFKS3ZSbVA3c2l1a0NkMGdhajd3TVZuOWlHbkJoNTZYV013?=
 =?utf-8?B?L2RzNnVSNDhpam1SQWliVmM1bXY3aUw5Z3NLd1pMUGZjQlVRZWlNbUdIaDdj?=
 =?utf-8?B?WjlpT3RvK1kzQ2Rib3d3blg5eml2VlNZa29KZkZ2cEZDUHBFMlNXZE5KUkpG?=
 =?utf-8?B?c1l5dm96NjBNK0NNT2ZiOEVxZC9IL3V2YlhMTy9qSzUxa21uMDVpTEpza3Vu?=
 =?utf-8?B?WXRuTW1VWW9GYUhNZkcwaGUvc0Q1Z1ZwMEFZRStOaGpTYnhQZkhkY1pSMVdk?=
 =?utf-8?B?UDNwUkpIdWxVeG92cnJ0bFlUeTJjT0NsbmlraUhEYkpGZGI3YnBndFp0QzlN?=
 =?utf-8?B?YnZkU3FGMFNsYmFMbjYzcUhvcmhYV2RCODRmYzdCdm9YOHBIcHVFZVdGaGZa?=
 =?utf-8?B?K2M2cG5IZHJ6NVNUUEZqQUpFZllCSk11V3h6QVRITkxEQWViL3l2cSsyd3pQ?=
 =?utf-8?B?RC8wblVLb1I1VVJGcjA0ME9ISGlQUFpSWHNzUlZLKzhTNjhXZnNMbTJMemtT?=
 =?utf-8?B?NDNtd25ncStLNEpsWGpnekQ1YVFXa0tULzc3M3NTdnc4WGRJUnJldUFrbU1x?=
 =?utf-8?B?YVB0cDg5QlNXdEhuckxRMkJkTU53cXdjTjFnanlGTHBNS3d1QTB1dUhmTlJo?=
 =?utf-8?B?VWd1R3Jjd2hINWp6NnBwR0pBSmpPSkg3aXoyeXgwcTZhUVJpNHptSFJrZC83?=
 =?utf-8?B?KzEyQnQ1M2FMQmFVTHZFVEVveGUxS3haNm1UQTZWOGVYZkZjZVowM0lpMGFy?=
 =?utf-8?B?WGlCMGFSQzZhTFlEajYzcVZzQmZoOWtnREZSZEIyRngvL0Ixc0x6NWdNYmZH?=
 =?utf-8?B?SXluZXZWRGpleE1vYlJmNUhCUXJkV0xXc3FHVW5BM1Q2ekEzWjJ5TE1KYk9p?=
 =?utf-8?B?K0NSNE9oNE1WTy9uZUNHV2V3Vzh0VVR6MUhUd0NoSUgvVjZDbWFWU2I0RHZt?=
 =?utf-8?B?aUtCN3FHdWZiWms0ejJkYUdvRFFpeVhtdmFFNWlqOUIzTXkxQ1NtbkhRRk5P?=
 =?utf-8?B?RDlxOW50Rm82MjBWcjRUSE5CZlh3aEhGZU5VN3VpUzFUbW90cVQ3aGcwNVF1?=
 =?utf-8?B?R1RUQjgwNHJaMm1mL0pHU0FVeDVMT0M5UlFneWtpSkdqTG5uVmJseUlHa2g0?=
 =?utf-8?B?YXFQREhBM0hvd1ZzcmxKT1J2MnorNG5iSVJ5Tk5IUmM3c3krTFhJS3ZPOXFF?=
 =?utf-8?B?cWp5UmV2UUVDR1ZsbWhHeU1NdTJUM3pBZ21TWEJ6RXFPQ2FEVkhMUktMTG5y?=
 =?utf-8?B?bHJSZG5xOGNqTGZwSUtPNWt1TTNuSS9LRVVkM0tVU2dwSy9IZlhvenJUa212?=
 =?utf-8?B?VDlPeThqaThES0FaQytHVThZRmRFYnVsZldESExHVEVaMEVndWlGL0RUYjRS?=
 =?utf-8?B?cmpuUTZSTXMya1ptK1dERk93d3YrcUR1dGlvbFMwaDhIQ3I4YnpZNTBXM3Ew?=
 =?utf-8?B?U0Evc3d5MWMrb3JZeWFNNVlWYzExZ1Y1dHB3RkM3V0xFbkJLNFFpcTZWUzEx?=
 =?utf-8?B?SW5GU0pTSWlrbmtsL0V6VnhJeFJVS0kvQTFXa3UxSHRGOWtwR3d3SENDanpw?=
 =?utf-8?B?QnZsNWFuMTZYODNYVFVJSW84cGRPa2hNOFNSeXpZczlFdGZCejk3c1BGcWR5?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df91919-51a0-459d-7505-08dc2da8c04c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:03:18.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWTU64aXhHfQKOhv0jxBDznvaHjbGU+KXqoP9QwcBv0JK4SDqQOsZXTh11BkDdt/n1B7QpfjKJ/NnDcktXS/BO8FTmlAh4xXNF9gdxW56h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> index cd3c0b01402e..98df2ee11c51 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -721,6 +721,11 @@ static int ionic_set_channels(struct net_device *netdev,
>  
>  	ionic_init_queue_params(lif, &qparam);
>  
> +	if ((ch->rx_count || ch->tx_count) && lif->xdp_prog) {
> +		netdev_info(lif->netdev, "Split Tx/Rx interrupts not available when using XDP\n");
> +		return -EOPNOTSUPP;
> +	}
> +

Not your fault but it would be nice if set_channels took an extack when
operating over ethtool netlink so that this error could be properly
reported.

I don't think that sort of refactor should hold XDP support though, so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

