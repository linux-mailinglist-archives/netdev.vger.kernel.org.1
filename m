Return-Path: <netdev+bounces-57255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D865812A39
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6FA281D6F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74451171A8;
	Thu, 14 Dec 2023 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM5t29XG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06C5BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702542154; x=1734078154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BA8lkXRine7LdS9cyMKc57WXIDmi2D+HPYeQPgf118U=;
  b=jM5t29XGZM+Ad6JbQOqCrJFTwhHb1sse40jAKiNkbtMi/1Vt2hxd/O30
   t8uno/gvseD2l86RjZwOIs7UmhigTohleBiVPfp5fNwzcotz4rGBpDjdF
   /l2FcFBHKKN832928v9a1ZTNrI1dNOtbT+Z8KxEEF8nX9LaMQBjsbOeIr
   g761uCCOAt8+XaSTPLZXCX1pvuKsmV7wLsTosavTdkBS0q4tU3PTRLm+x
   s846DzvnWbWIGimAwqxGxp4fUJloFCSW5AN1euAibCOTrDQ0AvJ4bkIBI
   7K5lfSG9yR8qQHmbG5ad6tTblBPYYehhNkb9I7sypYguyVSHE8L2i00+f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459409947"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="459409947"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 00:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774268571"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774268571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 00:19:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 00:19:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 00:19:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 00:19:32 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 00:19:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLbZ4vpC2D7Dbw0Z4yYtnb/Bh2193Y3UBX3eDXdGjXQfNatX/GoRhFPxxTG0u2In+KHyjXAR1NKDmwqXExAdFscLhkzXI/qipGs07TIofHaKb+SSRu3a1V5v+y0GZQd8R16L/5XCEl6pSPRg5CR59Nr3hMrFSKzbf6O6dEmcVBNo2tHt3RVfZ6gKMAVxzvHkezEk87c9zGYhwS9t3Bz4WzWNa4R6GGlXCuGusifoSlnj0EF42XRD6zu+uenmRY22oOIneI66/imcKbJ57f79KNV0UECpunEJt6XT3qFIdUF2T2mF4RqboQYohRYDG62GumQ4uF4XMz6h71C2aaFxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfofDWZX1TOxXfc9XOITiAsTTnPeJC7Frpn5XkPJJdM=;
 b=AnWbacCiCRhcpwjdiJIpaEFoOB/avlBORzZZ0nyyDhd4zS0YnnV5K1SZM4nkcx1kVlAqRkBo/4Uuy75atWWVB+PNZySYgPMQDVH0XddV1vy5Giz9hxosLld/OFGaPb2jc/thaRGX4u/YJSY3URkDpaFUOUN50Frc9L1apfe71whIQkCwrGQE1YCgLT5dl1jLM0P+c6aQ1lrhZrmUkaF6RBJZiXhMcOIvlyU3efvnUkwL6Brb5ddI71V+WoqOuorg12CnTMyRiarWbPUVtDYSplWFC7EXRJxe6ukfRG+HwSczqXsBjukLHujfRy74mKM8yI7GGQ2XBj+tjznVjhXwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.30; Thu, 14 Dec
 2023 08:19:28 +0000
Received: from LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::c851:ea8d:1711:a78e]) by LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::c851:ea8d:1711:a78e%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 08:19:28 +0000
Message-ID: <4bf80a63-868b-4ed6-9e73-ba79a1315bad@intel.com>
Date: Thu, 14 Dec 2023 09:19:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 2/2] ice: Implement 'flow-type ether' rules
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Jakub
 Buchocki" <jakubx.buchocki@intel.com>, Mateusz Pacuszka
	<mateuszx.pacuszka@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231207124838.29915-1-lukasz.plachno@intel.com>
 <20231207124838.29915-3-lukasz.plachno@intel.com>
 <20231212102913.GX5817@kernel.org>
From: "Plachno, Lukasz" <lukasz.plachno@intel.com>
In-Reply-To: <20231212102913.GX5817@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To LV8PR11MB8464.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8464:EE_|DM6PR11MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 3defb3ae-6d1c-4b40-431d-08dbfc7d638e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PgOqFGMxVgTCjDs5vLgMPZdiYU97Oh4mKZwUOuzvnLozmqpkyg1H8lHjeFKvVaXbxz0sb1S0MoIhyUw8SHFHlm5umoEmzoLAt75iM84Fx7INKsVKc/R32CClc3cUb/03v6ZO3J9OZY/8+5cNfjrT0G1jO2+L/xHfNLeAgIxBE2M37elPrcIW/ciI/61+xJ+koFT+RUpMhvoGT+onVNgE3un/gBkIaPkvQE2rFJCxWdAvlrbf2RTBvBzQOVu65o0m7iOyCv+lNlWA8sW55P0i2cPm8ctqVAW8YcFPF7hgJCtzHJa3rydbJHg8GR/SCzjWTPS7smVSTBtm3N6tkbqKjA1PiREi1FrYbs8vJ1BjmUrYELANYSIZjdEBeRO/eu6ytsBQbxqFqv7aARzOtxYIA9m3dgnvUZ+9t4yPlvpTTheiudNfejpvHk3BYy6E21/OClIiIpVjHGFHUZvZI4bzMEtxOGw2PBzUcasAI4PcUoqzJeh5EEpIRaXCCZLx/64kmxGeRenRdiqtmBpt+Hu7969z2aCXzvdhM31IeKqw3KNjteSeX2pkZB3yroNU8LEVS7zVBkJpjF8/MzXT9j29rxKSey25OYtALkiLqXHsQwxnmq1+4m1Clvs1eDG6z/yUQQLKKzRaX8JC/3ZZ+66NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8464.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(478600001)(53546011)(8936002)(8676002)(6486002)(2616005)(107886003)(6506007)(6512007)(6666004)(26005)(4326008)(316002)(6916009)(66556008)(54906003)(66476007)(66946007)(38100700002)(5660300002)(36756003)(82960400001)(2906002)(41300700001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHdYNFVwL3YzaDhqNHhXVDgwb1lmWkMzdVZHR2F1RjVZbXBHMDgvU2MwZksr?=
 =?utf-8?B?TExQOFF2MFoxZVE3cmJlMSswNXJIdlFKcVM2d3AzWFN5VW5lSFFxUkp0dmlS?=
 =?utf-8?B?ZXVBQ0xMQ2s2RHIwQ3hCWkVjeE5rRCtUWDBtM3owVHNEMktDOUlnZ050UTgz?=
 =?utf-8?B?VFA3Zi9TdTJ0RW5IZEJ0N1hjd3FESU5ZdU5WNW42VndQY1FpclRFb0t3NktP?=
 =?utf-8?B?bUVicUFjUDRkZ1RDUndDRU5GY0Z3TUtRNVg1ODhacnVuTmU1eTdCNDUwK28z?=
 =?utf-8?B?NFlYNVA3bXR3Yll3N1E2UnJhcHlqeG1PYytKQ2lZOTc1bDk3WkN0cXBwKzVU?=
 =?utf-8?B?M1R2OVJ4MGVpY3J6MjNDTWQ0Y1UxSmpaL3ZVN0Q5Ung0b1pnYmdkbGZtTkNr?=
 =?utf-8?B?TmwyWnViUUZXYll1MW8wbUp5VTdMUVBoTWNjRmtyWlRLZVBmd2dCL01MQ1BP?=
 =?utf-8?B?Mmp0Y3JsWjRzVjRONWFscDM5LzdzTklveEpzMmY3M2cwL3VHZXF4ZmMvSURG?=
 =?utf-8?B?eGlSV2Z5Q2J1cWQyQ3VSUlBnc1JkaHFVTDY5VXIrRjVWZDRnQlVSVTdZV3hQ?=
 =?utf-8?B?azcyOHRBUFFuZWJwYUJKenBLeEdDWmR6TU5rTVd0SmZSVHVYdXJaK2pYTHFK?=
 =?utf-8?B?RUJPc1JNK1JOc08wRm1Kd0x3bXB3aUtLV0tKR1pLbW5CdCtPeHZVcTczSmcv?=
 =?utf-8?B?YnNYOVJjWDV3TzdQUWJ5QTRiV09PSXJmWlNtb1BvbXNESTVXZG44enk5bnVK?=
 =?utf-8?B?Y2o0OEx4cHBFWVNXdWQrNDBHWkgyMEQ5RXl4STdxVTN0eWVlM1FBOTJYMkF1?=
 =?utf-8?B?T1Mxdis1TmxIdklLaXdWVTRPc2llYnV5MkY2dmpyNStyMFRNakxDYnRhc3Yr?=
 =?utf-8?B?OGhyM0JrMXFqWGIxaGloUyt6VFpTMkFNWEY4alhNVE1ndGw4c2VHMWdFSXNS?=
 =?utf-8?B?L2tyYmlOV0l6bllMaFlyclZyblhvMDV4RmEwbTM3bjdkUTdBT1hIZEV2Q2ZJ?=
 =?utf-8?B?TEhnTy84Skkra25kTzQwTmRJVUpRR3A0WXNaMjNjcGlHUi8zWHBGN3pPd3BD?=
 =?utf-8?B?K3dvN2RFRDZmcFUrV2dOQW13Qlk5YndMWjRDelcvaG94ckVvVGY2QUtjZml5?=
 =?utf-8?B?RkFpTkN2cW9ROHU4RytudVFSNGE3OEEwK2lwa0xkeDc5a2RZcnNQNDJvajYv?=
 =?utf-8?B?czBKRUFQOUR5Yjh4eElSQVByNW9NTzhqYldEYXM3U3pVS0hGVmhkeU5sM3Rv?=
 =?utf-8?B?QzYvSk5BWU1pN05NZEQ5VnUrU0RwK0YxdGIyVURSUjJIZUtTZEZHSUwzbjVK?=
 =?utf-8?B?MTJNVDZpZnJaYkJEcHk5M3RDV2ZhdUg4WnVpSkVqNlJiaWNvbHdTYTZEb2Z3?=
 =?utf-8?B?TncxSjJjZ2doZkk3LzdFQ0tUWnVYeklnU1EwbStsTTRGY2ErQ2lmWDRtL0Ev?=
 =?utf-8?B?czc0T1FpQkRWUjhFSlNKZ3lyZnpoUDVWVUx0Sy9MWUFGMnB4T2t1enJKeWtF?=
 =?utf-8?B?UHdFL0lVSEtucGRWODFxNDZlYjl2Q3NhaHNBQmFOOWdxamJjUWxHQ3ZiUkwy?=
 =?utf-8?B?akgwWVhIdU1KT2FPVHIvcDcwcVRwVDlzcVBqczBCKzczTzhGWFlmQjUyb0xa?=
 =?utf-8?B?MFdncjI4Y2JRQ3l0ak5ZMk9FZUVRU2JYbXp5WEo2cm9wMHJkV0psL3BsQnRj?=
 =?utf-8?B?OHdrWGFtVTloSU5TM3ZzRWp5SG5Va2VvcGpmc2pTQ242MnViNUN3dzcwczVq?=
 =?utf-8?B?UWRWVm5vcm5hSU5sS2lJUEM4cXN2UUgxb0s5eFBQTjYzdmhSU0lkVzZTZDRK?=
 =?utf-8?B?WldHSGIwQW5tYlR1bS9tT25qZVRlNVRiRGZsdEhib2NEcmFCT3plSXBWcDRN?=
 =?utf-8?B?VUFDNW9veTlVTTA0anl2NWw1QTVDRWtnZzF4cjBxUHQ3YUNhdk5Id2tneitG?=
 =?utf-8?B?MmQzTWV0RnBRVFZsd2NDZGxaeEpWSkpoeERMNVJyZm5lbldmMi9CbXViblhu?=
 =?utf-8?B?eE9paGhodlpLd1AwQk93VzFjRTdtT09UcFc2dzhHdEFEdFhrWldWMzNZTjEv?=
 =?utf-8?B?YVNkSDlQanMrUjI0bWxHQjZacHlYNTllL3hwZXg0TmFQalppVlROWFBxcGpG?=
 =?utf-8?B?aGp1VklYZjNtN3RwbmV3cTE0c0M1Y0JIempZbWRCUWY3ZmlIdmdIUldOUmln?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3defb3ae-6d1c-4b40-431d-08dbfc7d638e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8464.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:19:27.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5iF35whloS9WSnjn6mUagRWAVntMYMvqIPkrFIkA//cbQWjPOlAe51hjUtMu0GGu4jQhJRfLmf23nAUNfEr5dQGhcHH5vZsnTKs4+w+57w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
X-OriginatorOrg: intel.com

On 12/12/2023 11:29 AM, Simon Horman wrote:
> On Thu, Dec 07, 2023 at 01:48:40PM +0100, Lukasz Plachno wrote:
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
>>
>> Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
>> Co-developed-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>> Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Lukasz Plachno <lukasz.plachno@intel.com>
> 
> ...
> 
>> @@ -1268,6 +1374,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
>>   		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
>>   					       &perfect_filter);
>>   		break;
>> +	case ETHER_FLOW:
>> +		ret = ice_set_ether_flow_seg(seg, &fsp->m_u.ether_spec);
>> +		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
>> +			if (!ice_fdir_vlan_valid(fsp)) {
>> +				ret = -EINVAL;
>> +				break;
>> +			}
>> +			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
>> +		}
>> +		break;
>>   	default:
>>   		ret = -EINVAL;
>>   	}
> 
> Hi Jakub,
> 
> A bit further down this function, perfect_filter is used as follows.
> 
> 	...
> 
> 	if (user && user->flex_fltr) {
> 		perfect_filter = false;
> 		...
> 	}
> 
> 	...
> 
> 	assign_bit(fltr_idx, hw->fdir_perfect_fltr, perfect_filter);
> 
> And unlike other non-error cases handled in the switch statement,
> the new ETHER_FLOW case does not set perfect_filter.
> 
> It's unclear to me if this is actually the case or not,
> but Smatch flags that perfect_filter may now be used uninitialised
> in the assign_bit() call above.
> 
> ...

Hi Simon,

Thank you for pointing that out, perfect_filter should be initialized to 
false, I will fix that in V3.

Thanks,
Łukasz

