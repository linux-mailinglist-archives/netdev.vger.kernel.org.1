Return-Path: <netdev+bounces-47864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C837EBA1C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 00:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D83A281347
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B226AF5;
	Tue, 14 Nov 2023 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3vffOfy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3C26AC0
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 23:06:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749AFD0
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003173; x=1731539173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fBTUR6bD66Jlv9gKBqNvh4YPr3w+7s09uOj3i97h7R0=;
  b=C3vffOfyF6Nam5XlgHMXHnSeK+kwruJAVbMTJHvt0bFdrrE0pYrxaXes
   rBX7J+p5rdiWHzM2R1Kf4RN9omHNSl+f8/aC67RhCyv4li8jvTYpplmbM
   sHGSH7RXfCOCtglY6PvUjNnUNOcOdxG6AUHSWjOYjHk4sgwhphmiXtIzI
   hsm8USdiisxD8Qap/G9HNZr+PvCN36ks5vaQ33vZizh5+XMEsknur2wB9
   vdXNK104zwaB/D2Kf8/BvV1OeYOLihOjG+qKF/x2kN28/HB/w4YuMF9Ga
   ebANv9/W9nHR3CPbLhBJ9zx3IXUxBjvidamFrW+WcVdLonRfZVxWoxbKk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370115245"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="370115245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:06:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="758317078"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="758317078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 15:06:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 15:06:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 15:06:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 15:06:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnTfxPBaD6e7FuObynNTPDBgrqaV12+FwSzuTU+9ydnZ0VVVnJwCmatB8dofVkJ0xyRLtbviJcO7jdynDmWhZDNRkCD9LelKHm6wszD0QQUbRpd1W3JJn9S6YHiuX9Z8s8ou0uCICPiptl8oD0ONUOu/0LRJbUJQyCkBnOS82ScZMXPSGADpzJan0sWk/ffzG76BT7GqJqJ0FFn3rAq8wmNwTdXC1kN0P6AOoTApxEW54AWDjxBCY/SoyU5ns6bv0aDMuK1QAJ14+LVtnD2wj3JrrVHXfkpkof7GxBBdT7KoZJ7a9toM20Q7x7rIIQrJ+v5edL93c86ZvONAOladAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaQoV+RUEh76FYxiNzOyRIpSE03YILANmMzCVu5FIRM=;
 b=RsBwqLhlL/PymfmyR9PgsQWV6hyRK+jBkDvDUjiDlfwXBl9oF4fCjUMSt1jfu24fTpls14o7L1+5tAMdWgXSTcJ1jUic3a5YwV1OGYU7sOV84a+IbYp+e0AC1Km8mnv3nHC+0Tx3jO44/BVB2qsLXUq327v1Nw1p7CWhEpeLLCehmfGjV2dQ0zB3PTYWee5v4U5hVYtx25Q8C+Uwan4maTqosTmfxzqfRWQVHNFSXYd0rUcFg328xNqkVr9nzTDpL/5N2fpVrL9aXZPJW4kBmg/PPJMC22jDAkLW80I5VSYAYGv+oCEzFk17zzw4x3aVgMumdRV+fkcK4swX6qfFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 23:06:10 +0000
Received: from PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::d722:19c4:2468:6024]) by PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::d722:19c4:2468:6024%5]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 23:06:10 +0000
Message-ID: <71058999-50d9-cc17-d940-3f043734e0ee@intel.com>
Date: Tue, 14 Nov 2023 15:06:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 00/15][pull request] ice: one by one port
 representors creation
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<wojciech.drewek@intel.com>, <marcin.szycik@intel.com>,
	<piotr.raczynski@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
 <20231114173235.2c57c642@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20231114173235.2c57c642@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To PH7PR11MB6449.namprd11.prod.outlook.com
 (2603:10b6:510:1f7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: a9efab21-aa04-4c3a-f5a5-08dbe5664a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yw69L/mZUwF18kgEadIZL5PaBLMoiD/Y8Ft4q9CRqBOLXvBCr+JSE0TUNIPVmBMSZfKHNKnXz5AIjcNK/0S/chPdnDiREt4JbAcFArdgrOVkEVONid8xUrHmUFh+Ux/umKiC/kaMEhrGEPT2BWY+XfDyFmmSea3Ms5Ku0XHm9hPpZrL8jd8/aGr0Fb1VNGO3uJhzEgtlH5uMo3kikhtyjlneeS2snPGi5JnnbBkpJdj2gY84BOT+WzEMMnmZVTns1fOhkv/jGfbbNWFRtnzvP/UMbS5ILvdaPLgDMxLkb+VkFrfJsIUxIeCtTv07Gphw0cPz8lWz4t33CxdskBalpeTCx/zhgwZY3Q7QkuIJLfe0wj8q1C3KWn6WhvNt3bvevFwY5/2u82VaopIEJ20yQzqrO5Khr8m5oCtlqQJ5RpsBhG5pNh1k6pEJa1L3wn+Rg4tz4B17Pbk6BzK+p5iYKY8I5YbzWf/y3jKlDU4298SEF1FtR00PdfWsBoiifE0t/d2SxZCYHPXHQXubCkLlL5Q+Q15qlqn5EowuVP89GWq4pdPaGZLXPVfpoRiQlSzvr3Xm/5p3DV0hjN62AMQk4h9sVcMv8Kvo6YSKVuBIIKDyyF9FzhtzaqXyE9cukSDag9CA0lzDSlJHd/mTw2urQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6449.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(4744005)(5660300002)(41300700001)(36756003)(38100700002)(82960400001)(31696002)(26005)(2616005)(6506007)(6512007)(6666004)(86362001)(6486002)(478600001)(8936002)(8676002)(4326008)(66556008)(66476007)(6916009)(66946007)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZBeE1XVVJFU1FhL2QzemZlMWthR2R1aDVSTHlaNzZqVk9MNHFJdXJjTGNu?=
 =?utf-8?B?eUR5a0I5VVU5cXRnRnhycXVKREg2M0JsZEZENEdWUU1KLy9zNjVwRE5HVXh0?=
 =?utf-8?B?SkVtbEltT2IrRnYvZTBLZUJBMi9HbWZoaHFhMVpseUUrNUVZV2lvRGVPZ0RM?=
 =?utf-8?B?SC9yaWx1bVkrblYvbGFkOGhSb0xCbUN2QTF4LzMrNG5IaFE2ZnRSMUxpNzkw?=
 =?utf-8?B?QlZhaTZ2dm4wTGhmVHVsaWxmK1VhN2RibHNQMXpEK1RucHJ4WGo2WGNRQmJr?=
 =?utf-8?B?NVZ5dG83STdUR29XbzNJYXh3VGtvVXYvMTFVcHRPQkU3ZXVROUFUQmJ0cEZt?=
 =?utf-8?B?Rmo0dGYrSlJIQ2FxL2RGYlJCVGl1REt6T0xHbnp0SUh2TXlFS3dtRWZMeUFX?=
 =?utf-8?B?dEtHV2xkdlZtU1MvWFE3dEZnSEt1eFZJQTVJYXZIU2pvcVo2TWNDeHdzZENj?=
 =?utf-8?B?dno3YjlzQ3NoVXpCMXJFSzd1K1BtdmpiZ1kvWEV5RmFDbTMxVFNRbU51UzlE?=
 =?utf-8?B?WjA2NnF0M0JKS0MrdE5sSWJLd2l3VDlPanpIUnA3MWxzL3RlUXB2TGZNME0v?=
 =?utf-8?B?RlRBQXBHTm5pKzZDWTVzT3dBN1JMY3BOUTUzRUp3QTI4Q2ZNMllHRzdGanJ5?=
 =?utf-8?B?Nk1PUXJYc3FUM1UvL3FGTTJBY2tNY0U2bitHKzdtVUFPT3k1UURKT2J2aWln?=
 =?utf-8?B?YzgwVERjTmxsQ283cnptNjNsNlh2ejRVM0VWVWRCSW9HYlNTd3MyNUlrY0tV?=
 =?utf-8?B?ZTl2RzkxN0Z3ak1zdEUzeTZmOGJQZStPVy9zUHRVZEpmcGpsdnFDcHA1N3M1?=
 =?utf-8?B?OWh4SmhYajYvZUFQY2FRVHkvYlk1YjNzZDRNQ3IzclhYLzdBakUwNWI5OFM0?=
 =?utf-8?B?SWhVOWRDamZNdGp0RlRIVnIwWWEraHZEL0tPa005Y0EyQjhSL1JoakpoNzZF?=
 =?utf-8?B?TDJKdjdvM2t0TXVZR2NmZHQwUUR3OEN5UzhiYXJjMkVoU0dTKzNyemwxNEVn?=
 =?utf-8?B?dmdRVGxBdFE1OG9qc0k2SldJVk1vOC9hVnMyY25Oamlud3VDVFZDUUZ5NFYx?=
 =?utf-8?B?cGZWdGpUUkQ0QVY3Z0oxMHVLTjVOVm55OXpkVjRHVUxLeTEra1ZFZmxVMWlL?=
 =?utf-8?B?M1BGcm1PMjY0alkybDZMOXEyd0w4ZzN6RlBVS3dlVUYwcG9DODZwMGd2eHNw?=
 =?utf-8?B?Rk9qSlhWdHJYMFpsZjJlUGh6MVRiRkgzK0pLcmp6VnlJL3pTQWt2Z1RuL0U2?=
 =?utf-8?B?U0lEejdOYVQ1ZlFpeUdxMEtSZ3NXRVFhNzNHSkdSOFNSdTgvUlh3WVFoWlVj?=
 =?utf-8?B?cXlWYkd5emllMU9TemFydmNHWEZtVjZSMzBJdVNFQkN6VmQ3dUpYbmhwcUVp?=
 =?utf-8?B?SlZWVXJaVENidndGdTQvYmRhbkZYYjlWU1Q4SXB5S1UwM3N6emR3QXlUcTFM?=
 =?utf-8?B?OWREMnZ4NDJzL3J6NU1VRkJUZ1puaUYraXdpZG5JTllVdG80NlZvR0xRRVBZ?=
 =?utf-8?B?SldCeWpHMU1UQVAwZmtSTy9KQXJMTllXSGZMaU1hN1pLUGVaRmZ2NGF6VFlX?=
 =?utf-8?B?N1VCY2NsTFNFeHRUV3hLNGxxWERrdjNLNFBjdlhFbGlpK3FZaGxUTHVERDZI?=
 =?utf-8?B?MitLRjJza01FZnFNTzdqMGVCUjRMNjRBeVFkOU5PQkNWcWY1dlpNaHRxUHRT?=
 =?utf-8?B?N1JwRXN2QVhabEt6RlR3RmlaY0VobkNHd3k4dmVqK0VDczJvL2lMWkFqUFAy?=
 =?utf-8?B?WGRiQ1FSYlFCaW1NR3YyUjJhRUk1RnZndG9VUzlkL2NkaUhaaTRQUmhNM2s5?=
 =?utf-8?B?Y0ExYW1VWjdwU2Q2cVo2b0FQb1pTNXZyN0x0ODFjMkgwWG1wTngyVEpzR0Jv?=
 =?utf-8?B?aHhpbC80WFYrZVdzMmxXYlp0d1lKMG1sdG1OK3plNXllc09GclJ1S0I5Z1lx?=
 =?utf-8?B?Nm1EMVVEWW1kS0ZyZzJSVmxqNGZadHhqWEFWbTQvNjlzVjdWYkp3MGFaejBx?=
 =?utf-8?B?TW5zbVVqZU1TUVlwS0loRkJ2UVdOVGNwTks1YkozMHoxWGN2OTRJeFRFSnhr?=
 =?utf-8?B?Nk1sakQ4NXFOZE1JM0pjUGQvUzExZzMwdkdTVWZRK2hnUEFkMExGRUVDcHRl?=
 =?utf-8?B?MkVvYUJzR3ppelZoSlozSDBNY0Y2NDI2TnVKdG9UWGg4TEFpQ29YT3NtMUZa?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9efab21-aa04-4c3a-f5a5-08dbe5664a29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6449.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 23:06:09.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FetkhnI+ZWMsFzaoh1GInGQrLRS+znWUXit5kl5wWMTBPCcwyFzlyYljTOSX7c3eKp2Ah5DuN1Kpb4eYfF84xgozQNMcI7UDlBgdf+wPieM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com

On 11/14/2023 2:32 PM, Jakub Kicinski wrote> There's way too much stuff 
from Intel in the review queue right
> now and the fact that some of us are at LPC isn't helping.
> 
> Please slow down a bit.

Copy that. I may have one net patch in the near future that I was made 
aware of today but, aside from that one, I'll slow things down until 
things are caught up and LPC is over with.

Thanks,
Tony

