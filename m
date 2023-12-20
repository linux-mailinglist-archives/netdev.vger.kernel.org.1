Return-Path: <netdev+bounces-59247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355F81A0F8
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1118E1F21D56
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3A38DE1;
	Wed, 20 Dec 2023 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hlf5XSJp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C7374F8
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703081984; x=1734617984;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yLUK8/DLoXvZSy6HDVTDT1tw6GS9sh089ROqITowT2Y=;
  b=Hlf5XSJpk7rABt4vOnWBySzI0PAs9bRmW8oRlIzeNHNatZz59lxw9NeD
   U9RQkIQalR606KT0ToLkLu6F03N3cLGNbfrGz9hpGRdS4uIGrBtl9LU5A
   N/FJ3gYPU0kMz9pdaRFfXhHLytunZlViBXQFkPlz6xVjbqi/IPL2KnSvU
   TFhcDNi0VGepYB22aaq0GLbGi02GnHe+uGBZQ1BzsCZueM48sqz8zcjB3
   V/0qLGeaiNWffoKWEI69dTDc9SeoQ3RyKQyVUWQTPx1noKPPfT9JD86FP
   NVEbHpYVU9pLK5pAQZDemgKOulpsGikQ97YWGnkJlirtHR+gAPXpPbJ3L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2648429"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2648429"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 06:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="726089779"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="726089779"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 06:19:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 06:19:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 06:19:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 06:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/AiQtY7Bgi66xK1WhmIx2CWcHcNb0CffTVqHZY8S9YluVMFH0GqEy1M1RedMvpwWskDH2FUiUFKDG2GPqAYRyBuhFyZ5Tl4SqK//7bmdRCoKzf1jCRweg4s6spJ5/9e5pQyT5etbFTRaRVvHm5tDJN6gATvZk/qcOKDFrxKpYO2BnmQ9e1v9Aw87qbPNzic7k/ZnK3G3zIyK+84Dx7Ox1H2R1bT/hicBH2l0qQoMLrljU5pY6Xj1Y4HO1zW35k6dlj2qUFJBG84jk+jClv4GjGZUIVXsdps1+o077IV6eCVllLT+f5omWMCvWjtiUGRyPQRg1XmpL1yWm9qIuEv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMqfzKebtztRWHOfmOo3ahCb275QSF8n7iCtkP81Xh8=;
 b=e4J3VVhrOoaURw6G2An5QnD8re+UffdPgLGF1oBDstU7A5ls+2K6k+GVMkgrfiv3K0kAi5N2o99S5RRqPKiqn0M+E6ck9AKjK8Wj5Bc0se8Yg+ckxC95kl6o2nDnsGbwSLySpMPOTT1gjOsSDOLKbHnhKh0E2+Lb4iqLHFHPExGpc1wJdThBOFdgRCIymX/GUttHt9+UdDLktvqDgzpQTbiEI7u5SX1h12sJXViB2VXwWAgm3b2wHLW2ADSUHWPkB/h2r15IM5Thv82jU4XekeFY/C15QEf1sPKGDROc1njRQpbBgWO1q+ImpZPYkqO814BBRSE//oSIuHVxybDpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 14:19:35 +0000
Received: from LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::c851:ea8d:1711:a78e]) by LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::c851:ea8d:1711:a78e%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 14:19:35 +0000
Message-ID: <bf21c58e-a857-4096-932a-cc9718ab9779@intel.com>
Date: Wed, 20 Dec 2023 15:19:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 2/2] ice: Implement 'flow-type ether' rules
Content-Language: en-US
To: Brett Creeley <bcreeley@amd.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Jakub Buchocki <jakubx.buchocki@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20231214043449.15835-1-lukasz.plachno@intel.com>
 <20231214043449.15835-3-lukasz.plachno@intel.com>
 <693fb63e-8369-9cf7-4b41-7afc00b30618@amd.com>
From: "Plachno, Lukasz" <lukasz.plachno@intel.com>
In-Reply-To: <693fb63e-8369-9cf7-4b41-7afc00b30618@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To LV8PR11MB8464.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8464:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af55be-82d1-4b48-e72b-08dc0166b123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wgz+Z67QBfwrZoP+bLaeOxUaaMWNCXPVhtnjpy+itonAvrnHJZCiKfAmn2Nb35kVVOK3/NzRxQxnYAqhRNaJPXFEoqjSuLKE8RdjNRJZo1q+/EFrfc9TuXv6hdYm/wSOBgkl/NN/xZTwx82hB9CaKjFAks12YcWB9NALRKlpfjaH/JGy6BbPCH2PokSjEZAZAZRzemGW24i0cGiLgRuw4Mwl/T1330SZKx3q5m7XtFaw/YK46gs9EzXBhD4qI9PXmj/gzHkFEKYte5ci2Naf7eBxM4GUQTpnOChjzTe4EVdxeWoYV0hTtn4VUkRpcJqBYRlOEzCIhPZPkpBm4NxFokDMMSP5f+UDvQ/jT6LCFIp8fTQ/c6RDa1n5eIsFFs418S/CKtQEezw/dU9WHmprRUJoPbP+ra52UyAZDHVmPUN7rpvmECutrQT4hk7SaA54pn3uI8N5YhThHfpYgPa1obzLMF+xhJH/D/wwBIgDXTbBVJaIZ+dNhdD3HMGyxeXbtlhXJzAoXitdIRAUx3XC9pX319ZExucGpyusUu+XiOzZZiGK9YItyuEnjvz2I38WnxDOlHSPbCIGxSyaMSvKgSpyu8E4W/QUWwAgudP2RxjrPnIH/9WbyDHRR8QT6EzxH85KGA9Lkbtzdq/0xj2SkqrHdXY/d7ybSeo62nWbGczbZ619x79kWAh6sAtY2evS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8464.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(53546011)(6512007)(6506007)(6666004)(478600001)(2616005)(107886003)(83380400001)(26005)(86362001)(41300700001)(31696002)(316002)(66476007)(54906003)(66946007)(66556008)(8936002)(8676002)(2906002)(31686004)(5660300002)(36756003)(4326008)(82960400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDBaNHVpRXpNVHJ0aUZTMm83cFlhelRQOUZjNXBTM0tuRXlZVDF0SmdOODNQ?=
 =?utf-8?B?TlI1U1FlTXI4S2FRYnhUMStFeVUza0JnU3FMcmVEOUI0dzNMelJvRFc4WU50?=
 =?utf-8?B?a2ZTSEU1V1ZaUVVVSjA1T3pEZ2pmV3VtWjhnVVcwUmRGRUJhbkFxMDR3dE13?=
 =?utf-8?B?aFZUVGNCNDk0L2JJbTd5ZUlLWjgyRUNTMENMVERydklHLzJvdVFnWStjWVV1?=
 =?utf-8?B?bG1jMXNZbS9HVE5oVERpaGJiakNuaUIxYlNrNkxCbWZQZDVnNGlwbFp0d1RQ?=
 =?utf-8?B?VHE3M0xjWEZUM0w5YzZOVVRNUmFORGpTVUEvckhENkppZWhkUDdHWWdBTmFJ?=
 =?utf-8?B?TjdtTnR4bDY4VTM0dmlLb1B0UW00VlNvWGw3MFRQNnJLc1dBZ3ZIQTV1SGZu?=
 =?utf-8?B?aitqeFRxMVF5VlJST0hOMDhub0hkbE1WcG1CYUtOeEFoUkcrekw1WktUVlRG?=
 =?utf-8?B?UzFtbDhQcURKZmo4d09ZcDV3MHpxQUZVYzhDUUkzNFdaL3NDTDIyb0R4UnJE?=
 =?utf-8?B?VE9XTlVLdXg1UjhVWlAxWStqeTB1STNCKzdDbjh1c0U5ektDd1JRMWRkTndU?=
 =?utf-8?B?MGNKVmNMWU9Zc1lCc0gycmF3d3Z2Y28xVnFHMzEwczR1S2ttOSs1Q0Rpb0ho?=
 =?utf-8?B?N2lGZVVYeGN0MjFYa2ExSFJtYWZGc1FYK2JPZzg2Mk45aW9qSmRWUTkvMnk1?=
 =?utf-8?B?NkJNdDFiMWE4YTdKbmtOdENBSS95alV0RTFrNjFuL2ZiMXMvbXZBWENoUCts?=
 =?utf-8?B?VXVCeld1SU9aZCtKZDh1Z0h3cDBQYUZ5bzZEcXpHT2RYRUhCenlqNklTenNs?=
 =?utf-8?B?QXVxZFc1S01LSWQ5VHhDR0U4MVc3ekdWWUlMSlF1WW90WmpWTkQ5WVlNLytU?=
 =?utf-8?B?QkVRbjBiaTU0WkkxWEMvb2VTSXk2RERhUitWbVUvQkhYQjExTnhWQnpJYlly?=
 =?utf-8?B?TjlFTmFPcmZRK0JmMm9vQ1dhWVdVS21ZTWNHTUZHMDF4aFFMTjNVUk9lWGhP?=
 =?utf-8?B?c2F6SGk0TWZYa1RoR042MTZGaS84SlhaL0FRYlRsaFUyWnEwaUpSK1BxMzFZ?=
 =?utf-8?B?MXdyU1J3anRYMkh6ZFhxMVpwUFdEK2pRMUtOUXN6SEs5MjNib1E4cm9zeVo1?=
 =?utf-8?B?WGNscFhOUTRwZmd5dHZ1VGg2blhidDlFVTAyQ0hPQjJCWFl5RG5pWHVuWFVE?=
 =?utf-8?B?SEdTa0ExSTRFbU5mYytBSTMzOTdyUUZweVYwVVZaQUJpdmI5NXd4UnlYRnY0?=
 =?utf-8?B?elJwbkxYcTRNWjZWSHJZcTJlcnJnWk9RZzNBbEtNMHkyaER1anhVK0tqL05x?=
 =?utf-8?B?VE1xcjlSazJhelhOUVM4MGJoNk1JQUNsUmRQK0h1Z0lrRmZaYmIyTmJGNUR1?=
 =?utf-8?B?WjBuVGM4SFJjS0tTMVlUM2RlRDg1N0ZQenR3RE5MVU55MStOYitibk5INUxV?=
 =?utf-8?B?WnJFNWZIUUFpcVRZZm8wOUNYaHh0MGo5Q3JtQWljbWlUTWZPMHJ0SVNBeUFn?=
 =?utf-8?B?QmNVSWFqVDFJc2cvTENDeFU2czVDaFA5RDZvU3VYWGROUVVnak9FcjltOGpo?=
 =?utf-8?B?ajZWQW1udFVCcVlrV2ZyOCtNSFdlUjFRdmVtUzIveGthbW1SdFZqZUlNTGRU?=
 =?utf-8?B?OHloYnRBSW9IWFRkckJESU9kR2p4Q2FIZ0dQZU9BbXNLdUhXYXpGSkhKeWgy?=
 =?utf-8?B?REdRTVZycnhPR2RrcUllR01qZVl2WlI2bEJTaFY4bVVGeTUvVXhuWjVJU3Nu?=
 =?utf-8?B?dWcrVFI2dXMxSENjTzZvSWJhdFp3MVhTZlc4R1VHa3Y4MmJ1SWp5eUZFY0xn?=
 =?utf-8?B?czhCU1EzMVhUU0trREorTHVvV29DbjkvVmtHVmlyUVRDUWMwdUM4ZHczLzVF?=
 =?utf-8?B?TEUyS3RudEdETFZ4S1h2eUFGb3V1V2NIaDZnTlhFcDBDVlZmam5YTFFaZTdm?=
 =?utf-8?B?NmprZ2djbjVRb0FzM2JmWFYwNUEvS2FhemdOeWQwZDh5M01GK0g5Z3NGSlZZ?=
 =?utf-8?B?VjJ1anZnclJmVTRHVGpoMmN6VC8zcEpvcW1rNDREZDVNZngvTjRyMXJueWxY?=
 =?utf-8?B?S0RoUWlHQk10NDM1YzArM2V0S0xxTWxIcVhEL0d0bjYyeGwrVVMzeDRHRWx0?=
 =?utf-8?B?Q2FvdkhuSG1EWitQQWIxLythbWJFNVBmNmFFYk9Ic0JWL2p2L0ZFUEppbnRi?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af55be-82d1-4b48-e72b-08dc0166b123
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8464.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:19:35.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fho1i/FN5farwk/A1VZ3+4qmGdLG6/XqezK2IjM7U7q2qSELPfoeoE4ESzHByRGRGeD2jH/KIbEf4hYgp+pOKH0Ohb7X2SbWkziaOz97seA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com

On 12/19/2023 6:35 PM, Brett Creeley wrote:
> 
> 
> On 12/13/2023 8:34 PM, Lukasz Plachno wrote:
>> Caution: This message originated from an External Source. Use proper 
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> From: Jakub Buchocki <jakubx.buchocki@intel.com>
>>
>> Add support for 'flow-type ether' Flow Director rules via ethtool.
>>
>> Rules not containing masks are processed by the Flow Director,
>> and support the following set of input parameters in all combinations:
>> src, dst, proto, vlan-etype, vlan, action.
>>
>> It is possible to specify address mask in ethtool parameters but only
>> 00:00:00:00:00 and FF:FF:FF:FF:FF are valid.
>> The same applies to proto, vlan-etype and vlan masks:
>> only 0x0000 and 0xffff masks are valid.
> 
> Would it be useful to have user facing error messages for invalid masks 
> stating what the valid masks are?
> 

Do you think about something like:
dev_warn("Driver only supports masks 00:00:00:00:00:00 and 
FF:FF:FF:FF:FF:FF"),
or there is a way to pass custom message to ethtool to print it to user?

>>
>> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
>> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
>> ---
>>   .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 128 +++++++++++++++++-
>>   drivers/net/ethernet/intel/ice/ice_fdir.c     |  27 ++++
>>   drivers/net/ethernet/intel/ice/ice_fdir.h     |  11 ++
>>   drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>>   4 files changed, 166 insertions(+), 1 deletion(-)
>>
> 
> [...]

