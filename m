Return-Path: <netdev+bounces-67641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6AC844686
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C6B28225B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57A12BF2E;
	Wed, 31 Jan 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8XFhEdE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0512DD98
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723536; cv=fail; b=jrsXyQDOD59K+xbO4pwaP7rQBOEYXYAikMD2h3mXkRbGJ8bdnbJlg7WbjGEeGQoRCMKye6a290tpuDWaKrtFoOCO8Br+DThlt3mHwlJDiVJJm2770u/UQigwtcatVcFRKspf0YfX1oX44UIZeg7qGkC51yUaROwP5JDI6G0j16o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723536; c=relaxed/simple;
	bh=hD4fdNfCtS17o63CbXzGfYA5VyClMClCSZgHlJm0ucg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s/iIVlbui4BkqbSxa0TIqmw6qw9j038ybsCKOuR6h/NMlWPmp4egbaD+uIptXJBIPJNu8CY0RxgH+CvpAfxXnS28jpCaIBy6Zg1J3bEgDpNYTKrPMheWm7YwpRXtwvZHN/VIBDPuBoTdyJxBNGoWrGBwMeX8NkpjRboJNeBCXwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8XFhEdE; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706723534; x=1738259534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hD4fdNfCtS17o63CbXzGfYA5VyClMClCSZgHlJm0ucg=;
  b=M8XFhEdEhqqGPeBclvTBBTuOCAwGdRhiBZK0TQEIrngRUONmGiKg/gzd
   8M7N6tunUcM6XrtQ5YnxlqML6W1XMKyMFJh0KITGV0XNGM/8lZsKIzUZJ
   5ivxTqJxqRaSEmG2zCfDCES5YvJLjdfEB7THxEsIThXJhV1up1BEdkjKR
   KCHMUDqEoEXFKxYFqqVgqFNe+WItuEo4wtakgkcMkJgTNXb96okwfDVgG
   Ek5o7wFhLo9blJm8U38x+gNk9SRQoR++fPOsbW4/NSqu/mRROmckW6oYo
   z6elMwe6wJpkYqRqfzCUshFbeU703RAM7hF5QfaI8Jrf6icTbulkJwmXE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400811308"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="400811308"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 09:52:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="30310208"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 09:52:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 09:52:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 09:52:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 09:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW/g9+uSBWwKyJL/KwCZzicjuJkAenP2COxekKkl74HLVsA6GWhq6EI9F2Q2KoyfXVx5Jjf0HmC5X8u+zUiZgBY3WafNeeMOaLmrO2mUL5WMyYRsWoSjakfhxz49tqES1xSlKWGmtV45D0w9zt4B02sP/huwK3/ywwbvwfGATmP1k21yRn7niN4r7wqZzkntojdX3kb7Y7A6+zjiWhf9cdoCSBQ32oPSgH8FtPjww0Ka7xXGAB8X/w0TktPdw/zmMg+/awLkuC6iK/G5tTkEkAgnWW8B8K3vEL9r2ISzqr/Ct09BkojwYqRFxjuuBco4K1qcIAzpotlv2fW+pKm15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZYcM2kxUBsAAD5fwvkwpMKGMcl5cwc7gQIhBARBzsE=;
 b=ZclYt5svC8U25lj2efc/j28DfJS2DXU9EENqa5lCohwQSZlx/9jkHW84F1+zysK804uOQeqMGEGx8/3JGD07iTw2F+O8eT8w76jvx9Arx/PUrvSM9Gg+nUZU6xuLUOwNwI+lkdbLPGppaRxSg68B7h4bO3Hc/W52ahp0RPr3YA2B27zMSgjwLKqOvU+pAPFKhsnQ23vYnE+G0EWqVzwaxTa4zFdNOEWET/tmT69qJvLf5CULB3KeR/1PnDk8XUCp8JIcqk7J5jQZy1A1LN4laaQi5dhAWcRJATanv2os1JyjDL1ZORWsqootPlVQrIphkbW4s4CGOHutI6ApDpScUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:52:08 +0000
Received: from CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bf2:91ee:5ddd:6f77]) by CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bf2:91ee:5ddd:6f77%3]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 17:52:07 +0000
Message-ID: <1f7335bd-1cd1-4526-b92f-3b6169cc6957@intel.com>
Date: Wed, 31 Jan 2024 09:52:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 0/7 iwl-next] idpf: refactor virtchnl
 messages
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"Bagnucki, Igor" <igor.bagnucki@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
References: <20240126054747.960172-1-alan.brady@intel.com>
 <41774365-e247-4e32-9e96-d256acfcc129@intel.com>
 <CO1PR11MB518654C3B590812C4155C2138F7E2@CO1PR11MB5186.namprd11.prod.outlook.com>
 <a022d442-db42-4f27-97b2-4738d862d46c@intel.com>
Content-Language: en-US
From: Alan Brady <alan.brady@intel.com>
In-Reply-To: <a022d442-db42-4f27-97b2-4738d862d46c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_|BN9PR11MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: abdfb1a4-7987-493f-f43b-08dc228557c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLknhAoKkRiAedqc34aJaBamb2n8NoyjlGNzqgF5/g1FUI/AAuPy7HlPd2BhS+RYbBnSf79Kr7F4ZTUrQoSyS9W4v1dhbKz69KAJNTXudTbE6EsuV2n3SiJMcOU7MRLRx+BKpD6qBNCZmRuGkAkPXWw5jBfqJCEyl0WqqUOsaauvx40l8agLjKkQUELduZlZ8gAhW0VoYwKMBN89b4YQJjvRQkLSYiBZ0pUM96cpmQ3z86yaBeozpebQ8ETAM2RLCWuZ31R+r4SjmXprvHZUWdj0w1Ppg8jL8Xe6md5IEM1EGJO1+5BN4Dkz28OvOrnZECR0EQRIDEtCzVP8pYEcn/Rdtkhaz8/4ChRPjM+iqYm9TYX8t6a8dVqjoj0IMpJIdg264Zw7DWYC7J0vvuRcWZJOdXqtM0g5f7nzI2qTqxupuVgRNSgUM4z3KUpImiISXZipM2GV5wlyUDB9lisI1STC+V6DUpa2fZYZzXOSV+PKfuIZwu86E2PJBAny7KZUjuvgw14/lzzDl5POAT7TJ1Lj2GakL4CF4yMHDWU2tNdJHMm5xln33OOkqWg9enzJFof5QYRUoC0EHJ65RrTlqPBLLEm5mvyFEJBmmzmonSFv8o14XDwr39iHUUJGgr6cWyk9xcU4TBDMbwuwmXz52Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(66946007)(6862004)(4326008)(8676002)(8936002)(2906002)(44832011)(15650500001)(5660300002)(31696002)(86362001)(37006003)(316002)(66556008)(66476007)(83380400001)(54906003)(82960400001)(6636002)(38100700002)(6486002)(6506007)(6512007)(478600001)(53546011)(36756003)(107886003)(2616005)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJ3TC9LY0Y3S3VTa2JEYzJuWmNpcytGTkJ6MkxKdzlxaVg2c1I2Y29jTnd5?=
 =?utf-8?B?TmtoMDlOeHZJZ0ZSN3lVWHd1Qksyb3NjMEkyZUZtZ0tVN2JEL3BMdGJKeWpa?=
 =?utf-8?B?Y0dzRmsxeE1DY0Vmd0pxL1k2UklnQ1Z1T2NIanJNSmJNYmcrMWF2YXJaMitt?=
 =?utf-8?B?UjQ4SzVobWdkeEZtM3RZMFp3ak13aFBvMFE0REY5dE84Z1dlTW9TNXRVakkz?=
 =?utf-8?B?Uzg2UzNKVktVOFVqaFZ6RGx6OVB4Mnl4RXF5ZFJhR1RBT05YeDNQSW1saTJU?=
 =?utf-8?B?eXhFL1lhUFVEaDlPWEZPdGxMWWdzdDFQWWpjeitCWUQ3Zkd0azZoVDJEMThH?=
 =?utf-8?B?VHpKV3NtR29uNEtlMGgxSGd5WDNnRzBneDU4V0p1VU9sSlhCSTQrZ01zWWhH?=
 =?utf-8?B?YS9kUjNKaTJId0RIZzkwL2hMZ2p3Y0IyTjRlVjJlSGlxcFB1UkYyQnE4YXc1?=
 =?utf-8?B?eEd4OFVoVlpVVHBhUG1RdkFxUDkzK2lUaDRWQ0lsRjIxSHZ0Z1BGdXpwSExX?=
 =?utf-8?B?WS91VXJ0VFlhQ0FVL2tiOG5HeXlXTzN1TzhMNlJQb2hPMDRjTnlRemFISHNw?=
 =?utf-8?B?aVlOK3ZrbndmdG1DVVllS29vNFU2NlBUY1B5bWJoeGQwY1VQeitRWlVhQTRj?=
 =?utf-8?B?Qkpya3U5WlhBeitjK1Y0UE9MemJaanJoOUt5eEdHVm5ibWlEazIzbis3dmxV?=
 =?utf-8?B?UVpyWTd6UGtMZy9RYURnUVlibThSMnNmWTBwbEREeERWaTBEVG54MGdkVVJi?=
 =?utf-8?B?d1orbzZ2SzNLL1RWWlZOa0w5ZW1OQWQ3YnZHclk5NlJubjZHc1hnbjBoY2RG?=
 =?utf-8?B?NFZiclQ2TDJDRjVNL0lGRE0zVkJFVnE2eDgzKzBDWlcvd2NWUTJUSVRrUzZE?=
 =?utf-8?B?VHphK3dvSE9SaUxjYUNtMjRCVkJrYk5UQ1VVV0FYU016ZHJwaklzOStNcEp2?=
 =?utf-8?B?YnBKQlVkQWtsNDRLV2U0MzRYbXR0SE9TdzljeU02bE11c29GbWFJT29ySjYy?=
 =?utf-8?B?alBMWndyYm5FK0F1LzhoeW1NMlNnU0phTURveVBTRjlaOWN2VFVjcGtsTENm?=
 =?utf-8?B?U3JwN2MwN1ZXNERXMlV0WHltdHdoL05jZWV0TGZycmhUQTAxZlRhODV6Zm5S?=
 =?utf-8?B?dW1NUzVqMWs0NmoyY2VLTCtBVlhlbUY3UHFxZjZQd2JBNThGQXJNY2ZMNmpm?=
 =?utf-8?B?V0xaaHQ5cjhJZFhTN0tYRnBSbXllYXRKY3JEaFAzL1k1R1pNL0VZRy94OUs4?=
 =?utf-8?B?WWx2L2VwMFIrOTRrd1BWOFRocHhNdmRqK1AwVHN3STRUcFJvaTFPZG0xVmVB?=
 =?utf-8?B?Zi9jMTM4WWtDalJoZzYxazB1cXdmemNDSkplY0JxdHQvMks4RG9GOFlpQ3d0?=
 =?utf-8?B?bjZ0RnFSWWNRa045V3VSK2RESTR6Mm9SOUlFdHFmU2ZsQXFIckprSkJYMTdu?=
 =?utf-8?B?M2lSQnRGYTZPRm1tZ3ppSkowUUtWNHU0cERZeitmeVBseDRmWnNZWjlYUk5P?=
 =?utf-8?B?NTVCU2pxeXJDc2FZalJHY0V4QnRrRVhVdnpQSzJnUmhFMFVTRzhMdFJzOC9J?=
 =?utf-8?B?RmFUTWxNTU4zVjgzbmRydEs1c1NpSUlsT2JXZHlLUVdXRVh6bVY1ZUIxRjk0?=
 =?utf-8?B?WkhDMkF0YzlOTVY5SDRJZ0tXbmRJakE2MFJWV3B1d3U1eVZFMVFhQktOeEFK?=
 =?utf-8?B?V01leGthQWZkU0RaZlkybStPMVBCM0J2UTZwYlkyQllkQjM2cEpOZ2NFMGtu?=
 =?utf-8?B?RzA2dm1UZGQzVmFDSzJvY3JHcmZkZ25PY04zbHhUWWQ0cEo1OE1mL1hHMDVq?=
 =?utf-8?B?Rmh0cEJjSGNvUVhSbEFmRmdMLzJmV3g5RXp2K2VickdaWFpNbUp0RVRuenhI?=
 =?utf-8?B?MG5ib1ZNOE9YRldRekhFRjFPWGZZVUxKU0RsRHBvRXJtanhkUEkyVGVmMEd0?=
 =?utf-8?B?MkhtWUZxTzJvYllLR0p4WFltZ2NlUkRXUU1JbmF4Q05wb0FlSU53UVgwMTg3?=
 =?utf-8?B?TXZtd0E5ZnJXYjc3dTRaT1hkZmdtV05LR0I4ODd2T25KK2RuVElBWko0NHZs?=
 =?utf-8?B?NEIxQSsreGJuUGRwaHdWTEFXWGxrRjEvY1cwdmRtMDVyQk1RTmpneVhLNEwv?=
 =?utf-8?Q?zGGwhAnxG44Piey5UzcojPN0v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abdfb1a4-7987-493f-f43b-08dc228557c6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:52:07.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG7pj1fIUb6JPMOUiNWUV2Nqeyhk/J8b3vFU3oVIOeF8j8A9smaAzqDrV7uBsjecJ8hp3+IXnwYTwcFe1rS5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

On 1/29/2024 7:43 AM, Alexander Lobakin wrote:
> From: Brady, Alan <alan.brady@intel.com>
> Date: Mon, 29 Jan 2024 16:12:06 +0100
>
>>> -----Original Message-----
>>> From: Lobakin, Aleksander <aleksander.lobakin@intel.com>
>>> Sent: Monday, January 29, 2024 5:24 AM
>>> To: Brady, Alan <alan.brady@intel.com>
>>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
>>> willemdebruijn.kernel@gmail.com; Bagnucki, Igor
>>> <igor.bagnucki@intel.com>; Kitszel, Przemyslaw
>>> <przemyslaw.kitszel@intel.com>
>>> Subject: Re: [Intel-wired-lan] [PATCH v2 0/7 iwl-next] idpf: refactor virtchnl
>>> messages
>>>
>>> From: Alan Brady <alan.brady@intel.com>
>>> Date: Thu, 25 Jan 2024 21:47:40 -0800
>>>
>>>> The motivation for this series has two primary goals. We want to
>>>> enable support of multiple simultaneous messages and make the channel
>>>> more robust. The way it works right now, the driver can only send and
>>>> receive a single message at a time and if something goes really wrong,
>>>> it can lead to data corruption and strange bugs.
>>> [...]
>>>
>>> There are a fistful of functions in this series and IDPF's virtchnl code in general
>>> that allocate a memory chunk via kzalloc() family and then free it at the end of
>>> the function, i.e. the lifetime of those buffers are the lifetime of the function.
>>> Since recently, we have auto-variables in the kernel, so that the pieces I
>>> described could be converted to:
>>>
>>> 	struct x *ptr __free(kfree) = NULL;
>>>
>>> 	ptr = kzalloc(sizeof(*x), GPF_KERNEL);
>>>
>>> 	// some code
>>>
>>> 	return 0; // kfree() is not needed anymore
>>>
>>> err:
>>> 	return err; // here as well
>>>
>>> That would allow to simplify the code and reduce its size.
>>> I'd like you to convert such functions to use auto-variables.
>> Certainly, should be straightforward and make the code much better, sounds good to me. Just to clarify I'm only going to mess with the virtchnl functions I've otherwise altered in this patch series to maintain appropriate scope, yes?
> Yes, only virtchnl functions. New functions that you introduce 100%, the
> rest only if you touch them.


I've gone ahead and submitted a v3 with the suggested changes. However, 
I would also like to follow this up with another series that addresses 
the entire idpf driver where we can not only use the automatic variables 
for kfree, but also make the various locks we have much better. I do end 
up touching some of the locks I introduced here, but I need to add a 
guard to include/linux/spinlock.h to convert all of it. I think it still 
makes sense to not include those changes in this series to avoid 
polluting it if possible, but there will be a dependency. Also thank you 
for pointing this out, I think it's a massive improvement to the driver 
code.


