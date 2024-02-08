Return-Path: <netdev+bounces-70206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA984E02E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8B9B2BE83
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641D71B55;
	Thu,  8 Feb 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwAGLWDw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01D76C79
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393394; cv=fail; b=aoguXj2SchD3tzWeS3KcDawHgv0jWsLNUajGoN84E5tOr6nWbwfhDNQK7P7qaC648xZLNs3DKG2wvl4G7aa0SewrA3vmzfmcMHK1iJl+CsroJiz3m86Vrb9tbPQLI4qqZp8a1I+fo8MQvF4jYJ0+ld9aWB6mk10eNNP4CmuotMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393394; c=relaxed/simple;
	bh=4BXMDWqT5sLKCHGl2Q6MGHUabUUSf7l7cWK9EN6oZ5c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pCfXbOvJRGtJ0vbuib7bRFjR7xXYkxcg1GY7r7jqnIwHLMD7kz3YHCfib/ylWikdNbKGWlsRyM09KpCGv/LxmjWljBwHAtakqlUTQetaXON3SvHo+yLNDNBoEZ50TF6fd74rXLOPRraZB9+mPQ4TEEzHKajR6ddvUOJnaud+Eko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwAGLWDw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707393393; x=1738929393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4BXMDWqT5sLKCHGl2Q6MGHUabUUSf7l7cWK9EN6oZ5c=;
  b=KwAGLWDwGcX7io/8rbE4EdJknt3NtfiCvUFiqWSgqedtV6AH8eHiCsCk
   PDThVbX8C+nB1iT3bE1dS3cM09KNY3+cH0UTUZ4yAuF2gOn0KI4XCFhhJ
   +QrA4rHgkYf6zL+NzeCIjZCN4Ux+7hMg14qqWaWs6Wm70DbPgsSyp7Ayg
   PdccmGK2HgNsHolqlwRFfQmo2VbMSos8P+gSJTAOe+CBuwVFok2beiddp
   W7w6nIKlIqhEaEAO42g6xnMXuutrmu8yaywcerZV7Q/T2xjr215e9oHgc
   ybqBzhWCThiYoj8/GSsbTW1/RXrPxqeTD9LPGDBdRGDF4WEJ/crYnB2m+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1088986"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1088986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6265103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 03:56:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 03:56:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 03:56:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 03:56:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi1BVSvK5vKUJlnHAZ8fR4zK7LGVd6Ysul2emeB3Asno3KKqpRMA5JlSP+InQosUngzZPweVdrrN+cSFcKqwr+m2U7vGw9/LvEd0S0lr2qtVBCDyiULauzZNc68Z7fcu/1/vYZKuVbXieM8vBgKfZW/R0KUsuQZ1X5Sfhv/OJZZiq19mLD0wJgnG6zZyj7Cyq8FKFFCE57CRSOoRtfaW7ViLs3VZSiGiXgckszpgptIPzFtHeeCEaNfB3O6SXryNMq6115JcJ9BZovK2b+dkKO7uZnkO5Tb04d5f/gAGJ16kKEY3yhbnOlBTVo3W2i4ofN1+t3jqF73zYCIyTATVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV1yo5pvfobG9sKsA9OcsmY4U7pun3JqqpqPRAnk9YY=;
 b=YLvRo8vNiA0rD0YkZsyka/uRImGIyMorov+PVDa5+WYKufggiB6GZoxtVH1kuNmdvbcA6eOE/G4UvYioF9AejE5cgkncTofZd+lYiiqayxIywhVj4QqfLM/8zm2nbHWiu5iIXO213lmPM5lyAS9RweJ628iojQGSnnS7LkHHJVHr/T14bVoMTwu+MnoPXFa9OTvytQuvWnbXoBv0iuTCzyHNxZh0SWGk1l/BzZJhbYHDQRJggkPj+ws1Azr8kGbeSS2tLeTXLaQv5XyCJ2S7L+NME3n81ge6UDRq2biVPeNyKGj8pLuhcybaUzewbCBZNUBITuSG4ra2b4r+DYRlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17)
 by PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 11:56:29 +0000
Received: from LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::9e80:a6c6:5f1:d19b]) by LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::9e80:a6c6:5f1:d19b%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 11:56:29 +0000
Message-ID: <8e4148bf-71b1-48dd-a2a4-84a46f2cd66e@intel.com>
Date: Thu, 8 Feb 2024 12:56:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v5 2/2] ice: Implement
 'flow-type ether' rules
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <pmenzel@molgen.mpg.de>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>, Jakub Buchocki
	<jakubx.buchocki@intel.com>, <horms@kernel.org>, Mateusz Pacuszka
	<mateuszx.pacuszka@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240206163337.11415-1-lukasz.plachno@intel.com>
 <20240206163337.11415-3-lukasz.plachno@intel.com>
 <9deb3115-eb04-4b18-90de-c884b91dc101@intel.com>
From: "Plachno, Lukasz" <lukasz.plachno@intel.com>
In-Reply-To: <9deb3115-eb04-4b18-90de-c884b91dc101@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::24) To LV8PR11MB8464.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8464:EE_|PH7PR11MB5983:EE_
X-MS-Office365-Filtering-Correlation-Id: fb43e724-004f-4adb-0edf-08dc289cfc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ayd452ow3gqLOa22Lxo5V3gRSh2DwpLR98UOlNeKo96PdhM2WMhsEjGGOSRcgUA+J0uO77EPuBbornNgeiw2PK7WhP8l8WQRi0z0oFBxK3olgiPOM5bDwA0NBB42zrEV62h2p75OPl7zXYIKBiMkFSdBLH5C/Xjwj8f1DqWKwh029h+bMI2GqoBK9L4gTxDxC0aFqZ2FaFlUcyPyL/I4Vnk6CFhEMYk2VBObN4f14ey+PqJ2VyJE5Svzi+aK9H4Rrf4yaofko2eJrvsWYImB9qvTlQsMoRphI5u5u4Ss6GjJQ/70zmg/DOYJ7vDEJYXSfEMl05D3//WWDIlgoooZ8AkzQpZpiFs6IAfAnjo0a4N5ivMB8xUsLiPyvjppP7veN5oiNyqmbTZKCeH1Arvf1OQsjhXdVZugl8MREyQvfRjZzOyKmVZ9NbDhtD/ZlrrL4hpEsx9rUXFYoyIrvhAaRtQTT+Tp4StM1qLO6K6scTCqrLBg2JcB31IJb+4L1AIr0e+EeJO224NttxnwuKh7mH+fSwo2jIJ3qmyBEGUz30xaNKIG+4s9Ic6GLWC48FFP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8464.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2616005)(31696002)(4326008)(8676002)(86362001)(6862004)(53546011)(107886003)(36756003)(6486002)(6506007)(478600001)(6666004)(5660300002)(6512007)(8936002)(6636002)(66946007)(54906003)(66556008)(37006003)(66476007)(316002)(26005)(83380400001)(2906002)(38100700002)(31686004)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWFiK2duVzQrTlBjSmMvWXhqWmE1VldBWnlnckdRbFFXRjF4RXdkU1V6TS94?=
 =?utf-8?B?SzlVOGlmRjlkeGdKYmFaMlhSd3NvMVBsRDJsWkloMmlZYWsza0NObW1LMW05?=
 =?utf-8?B?c2plREd0TGZYVnlxYU1pN3dsTER5N1NSanYrd1lFa3l4aFN3NkFPYTRIVUw0?=
 =?utf-8?B?c2JyQ2hVV0wrSEZxNGhRVG9nWXVKbnc2NlFPZEFXaERKZzlNQjNOckNqYTNo?=
 =?utf-8?B?Wm5Rak4vc3dhcHR5S3B6d3dUTEd0QStlaGRPTEQ2UnpTaFQ1VS8zTyt3VG9Y?=
 =?utf-8?B?NTFLS0ZlSXR4eEU3aTJXODhNektPcHNmODYwMjVyL0M5WExsa0VTTWVEL1NE?=
 =?utf-8?B?WDd0L21wdHJxNVJhSkViaFFSZ1FlcTFyam9BbXZsQzhXSlhibU91alJHSXV3?=
 =?utf-8?B?czVHdjU3cXFUdTROOUI0SkloWFNtV2xpeVczVlJ3WWY3QzJEUmg3Rmc1Smsw?=
 =?utf-8?B?WDJPZnhrQm9wZGY1UHg2cGNNZURPaXlWUlJKNzUyUllXVDZVM1R1Q3BlM1Zu?=
 =?utf-8?B?MThGOFlYYk4zTnBqd3dvTWRKWlQ2Njd6UUNIVXA4UzM2UWNRMi84S2hGeGNQ?=
 =?utf-8?B?bnJzSGZCYXpwc2hmQ282ekpnckI3UXJ3OExhb2tZREtLZmtWYVpZamZ6UWNJ?=
 =?utf-8?B?c0kvMGdzcFFDdHowUHhnOFVkRCtDVDJiNUh3a0hYbW5pNUNwSTcyU1lNekh0?=
 =?utf-8?B?Yk0rblJrL3pmNHNqWG1xVzFsTzNrNFB2aDlzeWJnQngzR3pUY043bHhEWDQz?=
 =?utf-8?B?NFY5bHArdUx6MzBvTTJzY2xrL0V4QWV2bDJJTnF4b0tEblo3ZnpzQkFFdm1t?=
 =?utf-8?B?VzRTYUpxSlJEY0RibmZpczhna2NjWEVlM3VkTTQyb2NWY3MwSE5FQS9KbklM?=
 =?utf-8?B?V0JVT1FYZjNBVHpNSk1NOWpkMWdVVlYwWGZ0NzRZNUx2ZEI4STVMWTlub1Jk?=
 =?utf-8?B?N3hDa1owbUgvRXcrRHJtK21YYmpJenVBdE92cXlOdXJZVmU2VUlwSHhlVHk4?=
 =?utf-8?B?TDBBMDdjTlNYc3lIVWJGYlU1RjI3eXArRFJoZitMY3BqQ0Q3dDNXQ2Jacm9o?=
 =?utf-8?B?UnYyeVZ0Y3dNc1F4SmtNLytRNUJ5UzlYR3ZsZWhkdGNieXJRSFNzUFNTU1lC?=
 =?utf-8?B?eEFLdUFQQlA2U0Y3eFZrbGVjMllvQWVpdVFTemdVU2JLVDJRd2NEcTVXdnEr?=
 =?utf-8?B?K3p0bXh5cXNWd0hmTmM4cjJQZTgrYnpNK0RSUDB2UW5wWWNNOG9wbXRSbzlR?=
 =?utf-8?B?aTBkUGw3akxEcmhhaldFMXRYbGpQZ1FKOFhhdEJERW43RTNDVDBxUjZWMkhV?=
 =?utf-8?B?b3dsREVCbGhHQzRoaXhuTUJEenAzMyt6Y0xrOFJvTDRjeWJvTnlQUkVqdWFl?=
 =?utf-8?B?ak5VZ2RlZS92NlRzdmtrazRqM09Fcm42U3VnN2pxWFdOUVFQL1UzVFpWb1FQ?=
 =?utf-8?B?VjNuV3VDUjZvQjVzRGJHNWRZdTJHUzREc0dlMUlPQ3ZnT08zRW0wQ2NyTm8r?=
 =?utf-8?B?dDlOcE9oU25YMXhJaHBWMWJJRU1lL21MelA4Z3BpR0lTY1Z0YkxjRjBDc2Uv?=
 =?utf-8?B?N1ZhTVdmejJEdWZMTnJoRlpIOE41TU9oOFBlZTFvY1lMVzFGY21aL2NhM2JK?=
 =?utf-8?B?cmNhQW5CYUZmYkFkZ3JscXczM3l0ZjJ4MzBzUGZ1RFRlUXU4bDFPL2Vzb2Zl?=
 =?utf-8?B?cVNGR0x5eEtGOEx4UldDU0dxWGxHRjBHcVNISmhCUER1T2ZmVHhtRy9lU3kv?=
 =?utf-8?B?dVlRWFJNWC9FL2NVSE1uVXhDaTlvREF4U1FYenVSbmhVUDlZdXJSQTROYkhz?=
 =?utf-8?B?U3l2U1JtNGN2VUlBd1BzUFh4VTZXQjZEbzFCWW5JYlJWUnVndHltdVZPNHVO?=
 =?utf-8?B?YlpQOWMrVEJQcFl3OGZxYUhxZjZlTXFmL2k1U3VMZTBtQ2ZFUXhUeG5rR2pX?=
 =?utf-8?B?RFVuUWpIWlpOQ2xZWHJXd2MzWmhoemxVTUNVU0MyR2lzeUU4azhYL1IrY3Zl?=
 =?utf-8?B?RjZPL2wxampyd0NTMUdUME5zUCtPQlVCNkpqdW1MWW1ocENHdFZidURMZHdP?=
 =?utf-8?B?TmpTYksxeEdabURXaU1Tdmd6b1JhQllqTTlVRkpLSTFjRjRmYllGMnhuYWlG?=
 =?utf-8?B?M1EvbTVBUUZYYmtxRGZUdDBZZVpWelhlQWZ4K1dsakFtUTgzblY1S0ZPZmhn?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb43e724-004f-4adb-0edf-08dc289cfc10
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8464.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 11:56:29.0722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkZyDjPKbXzgiEvsQMiiNGG7/pagB8XiOLLJZ8t8VCdMkNo5YB7Ichy28d0t5qfoF08LTWhv6uh8V6C/FriqlhpmuvnKLOKfifRXBwGLkWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5983
X-OriginatorOrg: intel.com

On 2/7/2024 3:07 PM, Alexander Lobakin wrote:
> From: Lukasz Plachno <lukasz.plachno@intel.com>
> Date: Tue,  6 Feb 2024 17:33:37 +0100
> 
>> From: Jakub Buchocki <jakubx.buchocki@intel.com>
>>
>> Add support for 'flow-type ether' Flow Director rules via ethtool.
>>
>> Create packet segment info for filter configuration based on ethtool
>> command parameters. Reuse infrastructure already created for
>> ipv4 and ipv6 flows to convert packet segment into
>> extraction sequence, which is later used to program the filter
>> inside Flow Director block of the Rx pipeline.
> 
> [...]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
>> index 1f7b26f38818..5fe0bad00fd7 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_fdir.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
>> @@ -4,6 +4,8 @@
>>   #include "ice_common.h"
>>   
>>   /* These are training packet headers used to program flow director filters. */
>> +static const u8 ice_fdir_eth_pkt[22] = {0};
> 
> I believe this zeroing is not needed, just declare it and the compiler
> will zero it automatically.
> 

{0}; will be removed in V6

> [...]
> 
>> @@ -97,6 +100,12 @@ struct ice_rx_flow_userdef {
>>   	u16 flex_fltr;
>>   };
>>   
>> +struct ice_fdir_eth {
>> +	u8 dst[ETH_ALEN];
>> +	u8 src[ETH_ALEN];
>> +	__be16 type;
>> +};
> 
> This is clearly `struct ethhdr`, please remove this duplicating
> definition and just use the generic structure.
> 

I will fix that in V6, thank you for catching that.

Regards,
Łukasz

