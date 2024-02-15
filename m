Return-Path: <netdev+bounces-72136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD5856B0C
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687D9B22715
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FFC137C2C;
	Thu, 15 Feb 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxdGFtM2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237C137C59
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018222; cv=fail; b=kVRaQtXFWZckeztqSPjmIpyFOIvJyc3opJDR9oRMTbxtKHULB/ulzkBN0fvprUnIvqgJbeBOi9EfMVnd1YShTvB0Gj1CHUsydvQ8ogZZjfumf/Ib3PUFyD+PrqISu73CL/XkLjSohAVCnJfVrQPZtQj33wL186nCFRgQCqbsLYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018222; c=relaxed/simple;
	bh=nvg5z5aBHEMkZBTeYfWwQnOUTxhSq7aMAcr6SfEwojM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iiYvwmTKW5AgMGUrTSY0rdYyWWxkOSM4e6rTlram3/a4eNH1SDTeZpS0VPhSufw6lmBrKzieAy5sBE1Dk7K2+r+WttDN1SB7LHy4+5d/RStNe77e6V81N6ZXxFDhL+QFIDpHWr/kedJ2DfT0YMyztoPi6MGyfK5SVbLC7Vn/ztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxdGFtM2; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708018221; x=1739554221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nvg5z5aBHEMkZBTeYfWwQnOUTxhSq7aMAcr6SfEwojM=;
  b=nxdGFtM2n5hq2JOC9+Q5pWCvAdqvoBFVtwrc8SNAQG0tvzKJ+om0KOD+
   TGYgNcUbMi19bzERPWF78lXi/39aIFfUbN1LIDtasFB++J7SQJj4cF/rD
   IAwgRLt6hDAWogwn9pXS0j6LIHUTMS0GATQXIKdYVITE13cB5srl37q6B
   HZYOkQkayLY15MroBJqAi+YIo8oYsMjJKv26xexASY3QmHG8QygBMjtJw
   jJbCjSI6KrOEfbNRSLEryrQnt1eZU1pyQherS0kF1EuBLpRg5Cfpn5yK/
   ddcPDnwNI9yrhPyg0aEW3B7oJ8ADRxBN/aeH9P6Xwt3srJKzNMqffFqpX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2260665"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2260665"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 09:29:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8200459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Feb 2024 09:29:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 09:29:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 15 Feb 2024 09:29:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Feb 2024 09:29:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbXrKbPed/5BLfIQE6bODrFHv9OvUH3p6Yd1eDY8o6IFuuI8HtRvGxQwNkEELtSfmHRwvqVrkUDbNn7fg/Dj4P+3tiWHTWxQ6l5sohSsw3A3Y8d/4TaKWO3rV61Xt3QRccre4kCynxZ13u4xspd5tC2TcxYJlILOUKNf8UBdG2n5mO+KMWNyEEbB2ztw23S8UAc5P+opY886pnWgng7hzFXIIFGlbjHBX+NAQlAOpjJmh9HDspD5QMp7o1uVGPmfIFEoFXrLztGHXVUKQWcl5WxovfR+d+jRYRicWjhUDX9M6pwlLhMRKdLnAnJSlZeWLZrnKKRyQLLKJN+6ea++KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceNo29G8A9xTfNNzuz24OA8LmsKpIkqCBBFmEn6/T0E=;
 b=IJHPUEX1bqzFowj4dH69k0n2heMoqqIMJk4PUkAA/VY2SraVvSaoLLctiHTdz6JIsF4oB3cgkknZzgB5OoqLaVwyHQtaQ+2oXgFvhnPvp3VQI4HpPEm/fBBZzukoTcuF8LpqgWzRsPal4S+AWLfn8zT9G/JoD2BYHnuvXXVIdXW79aMdmHYEvH0MYZv5+4OGNwPXJqFW01cuVo/ExGpiqRnjWXISXIE+kY9XqpqUtAhe0BsUGk4U/tdAGl+oA0zMCnoJiAPP69Y9+iFxiuRBGbFgsb+QwCrcTDzPz+PxZdKX+j+PhhLkPI9MGJ67wJUY68pQs0SYR0uh5SQSFAN1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Thu, 15 Feb
 2024 17:29:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:29:45 +0000
Message-ID: <0aa2635e-8402-467a-b684-5608ebb4490c@intel.com>
Date: Thu, 15 Feb 2024 09:29:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/2] bnx2x: Fix error recovering in switch
 configuration
Content-Language: en-US
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <manishc@marvell.com>,
	<pabeni@redhat.com>, <skalluru@marvell.com>, <simon.horman@corigine.com>,
	<edumazet@google.com>, <VENKATA.SAI.DUGGI@ibm.com>, <drc@linux.vnet.ibm.com>,
	<abdhalee@in.ibm.com>
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
 <ceca2088-10c2-4a7e-ac4f-50a5338187ac@intel.com>
 <19ebb8a4-fbb8-442e-9fae-95890355a110@linux.vnet.ibm.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <19ebb8a4-fbb8-442e-9fae-95890355a110@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: cd191bd8-1fae-45b9-0a62-08dc2e4bb385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fewXNnQA6GWLOacxZi8UzyLjG6oGH5uDqBVob72xmU1d9FHqZx3Dc9q0HyA08gmL68A6pWC7tVSYzByvGPHSBSkUYeTTP8sEvbspTu+fpBY1Jfz2rVxIFtQwPkb1SZfk82A44jBKjC1JSVU6scz9ar45/6DIqaBhgyhLsLJwAgeBLp/s16yOkotPtEYmxmM/vCw/TipVC88ZxShSGxm/jDOPaSDD6k6DvF695ywn4sWjSxv0OCvorRkqlpAMMbZDNXaYhM6VmmYFLZzaySiKOhf0SXWP3JGMkZ+Q2osDx7JZ4ad70el8y2cswV8hfVRxfz1AD61GuOPaVmZG+2QsbhYlaVA9i5nC9rjDX25sWWElLcYyHp8Li+doy9AfAkhto43AGl/Y+QveNjrYWuoedjPTO6o3/402R+8BF5KkpXzU7dKEpV3W9ZagXnHzXaelByIUcb3XOMnFmZTefACSxbFcYAivV0z2pc48JDlaAbPG9AwWXGuKur9czzuklTgDOMUS2sVmNyXmYowLhuvztN0BXxXTPU0BLmqFAxEM+Q2AUcMdUArfZH9BYXlnMqKy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(8936002)(82960400001)(7416002)(8676002)(31696002)(86362001)(6486002)(4326008)(478600001)(5660300002)(316002)(2906002)(6506007)(53546011)(66556008)(38100700002)(6512007)(26005)(2616005)(4744005)(36756003)(66476007)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdHdi9WOWkrTFNFbzN6dzRRWTU5YVpaRzYra1d1VUpzM2I4eU5ScEF4Rmk3?=
 =?utf-8?B?Y0hSRnJSTHNxN3RTd0h6TWN5RlVMUW4vNnIyWEZXZFQ4VHg4b0dTbDFDK2Rr?=
 =?utf-8?B?ZExLMzZqaG1rMDMxOEcxK01jS3pCM3pRUTVqRnVSTktTNWRWZFBtMnJ2SWd2?=
 =?utf-8?B?VzFJTW1ISHF6TnU0ZUo1bDhHcHFVYTY0VE85YXBUODh0U2xLNDh5RWJzZDQ4?=
 =?utf-8?B?ckpVdDZlbjZSZW4vemhTbnd5c1NySklpL2s3b1BzSjA1NkgrYkRieXRkV2px?=
 =?utf-8?B?WC9jZ09TZkpycTByMGVzclNYVzFHY0FvR1FyTmZsU1F0RkY4bmZEcUMvRHVt?=
 =?utf-8?B?UXNKSlpXSklVa1RQc0xGUnFIZ3o5NFFLc0dlR2FnZ1hiMHUwTEJHMG5qMjd3?=
 =?utf-8?B?WEZReWlOMGg1bEgwU2VoZngxYXVJWjk2YkRaVDFkNmtyTk4yVUlXZUtvdVVx?=
 =?utf-8?B?WWhsMEZiRlFjdWZIbVJoL29jRlE0VWYzVkY4OW1lM29yeno0VW52OW00L1Bq?=
 =?utf-8?B?UjhtY1NpVFRwNkw5b01qUWRhQ2dLazNVTnZBVER5REhoYWlKZDlkQUpzUmVN?=
 =?utf-8?B?L3FPK2lScmJuWlo4UTBuaGFoTFVkR1pyVnJWMll4U1E3ZFhrSG9leWxtUmpu?=
 =?utf-8?B?U0JNcVdaL2haVlRTWVJiMTBTOXBRZ3dtY2JBNStjRUl6LzdoMkVUYWVDeU5H?=
 =?utf-8?B?cHdhNml0aGVJL2lSQzl2dzZLUkxJbmpyV0poTVlsaE45QUNTdnRodWkxQWxI?=
 =?utf-8?B?cnZnanFYMG9WS2pjbUZza3dKVkF6NmRnQUR6YXdsRHkycE1KUEYzTTZuZ2g5?=
 =?utf-8?B?L2xTQXhoVTFjZ3NTMTlPMzN4OVQ1UWxBS3ZWemdWOWk4b3pIdGNaTVRZV1kv?=
 =?utf-8?B?MnZTdHZwdTFKWUt2cENBUFBZMTZyYktQeCthMXEzTmFlUTRoaXRSTUR4WVdY?=
 =?utf-8?B?NmdOTi8rV0gzUXFGandibXZ2WWZjYXN3ZVpaeHZkZnNFQkJwaGR3ZkFxUU9J?=
 =?utf-8?B?SjdjU3N4QU9ybnI1alhXNEY5Wm9yN2VCTDVCRThhNHo4aHFPcEtadEh1czlh?=
 =?utf-8?B?VVlyaGdJS2ttOFppTkdOcHAwTVhLUlFNenFQZHFycVFFT1R5S3BRRTRLRUVH?=
 =?utf-8?B?a2dHVnhnMSt2ZDg0Ukw2V0NpNXRlWDFTcWFlTGJxc0dQem5BZVBKQ3F2b0hs?=
 =?utf-8?B?MUY3ODhwaUJIQWdpdWpsenlxMlZUNnNMWFlvZzQweTU5V1FTSXJ6RmVGa3Rs?=
 =?utf-8?B?dGx3YkNuNUdYUDNsY3AzdkEvMU56U29PcFFncWlQZlphYUJFUUcwWlJBTlZx?=
 =?utf-8?B?Y05sMHBBTU9sVGp6eVBXUVZ1dGVxbGhvYjRNYzJLN3NOLzZSd3NmOU5rNVd5?=
 =?utf-8?B?QS9CNEJnWmJRNDlRdFdKSzNreFNDK2xvWlduK29UaWxaR090UDdMQTlCUnBM?=
 =?utf-8?B?bkJyMEtTbG1SMWpRN2s4Sm1EemdBaEcxZ1VUS2hTU1dpMVlRaCtnMEJVUXZC?=
 =?utf-8?B?Vm1DUlJjT1Q5dGRxbGpsbFRwV3BJRUhIVE5nUWNwdDBqUzZVTU9KU05FWlNG?=
 =?utf-8?B?dU05ZXk3OUUzanhnRDdlNWN1RWVlQVpHTEZiQnlCWWo1bDlIbUJ1YzQ4azRD?=
 =?utf-8?B?NEtXMjZqMFNtVWpuSTFpcks0K2dmSUM1azJTSWFHdEMwU2wvbjVUYWMxWmJO?=
 =?utf-8?B?bW5xcGtBcVVDckR5REVyN1ptYnVWRmVpNk0zeXNvSTJhQjBGNUlGblZlaktU?=
 =?utf-8?B?VWNKOVVkQ2tWM3lMRm1CSkFMcFdMdS9xVzBzeGFUZmhjYTcwaXpMWGNKREVX?=
 =?utf-8?B?Q2xHdUZsS3ZKZTgvR3lEb28rcW0valVlVWNMcE1lNFZqcDArNEFiVFRLOUV4?=
 =?utf-8?B?ZyttR0g1WURtYzl3MU13Z1B4N3JxRCtFb1JVT2h6bm41blUxbUJ2N0FQRW5N?=
 =?utf-8?B?ZjR1MXJXNjFPam50NGMva2FqMzJCMEM1QWxXZHdIc3ZZVkY1YkN2T1NkM1ZZ?=
 =?utf-8?B?RzVnQWdJWmJKcURuVEM3T011MERCUVo4V0ozeG45b3JhZ2ovcG05dEIrVHlZ?=
 =?utf-8?B?ZzBzamJTZHYwSkU0MnVzWnM1bmV3c3NGckw0MW1TQmVrZUkwZWl0dEhncElS?=
 =?utf-8?B?YmpDVjducHBUMVE1d0t0TW9KZEhScXlvRC91aWpWZExDYW10MjdTVEg0anZU?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd191bd8-1fae-45b9-0a62-08dc2e4bb385
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:29:45.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNiIkRtWoFlp8pe8gnmqIIiilUNocvVqsA6EcybkOYqI6HiXOKYhj4yRzZUS+aKILEm2MBtbf3XfSPXN+LZBU6uMa0dDXDWWfz6D8y6EQSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
X-OriginatorOrg: intel.com



On 2/15/2024 8:08 AM, Thinh Tran wrote:
> 
> Thank you for the feed back
> On 2/14/2024 2:48 PM, Jacob Keller wrote:
>>
>> The subject didn't clearly identify net-next or net... but the contents
>> of the series seem to be one bug fix which would make sense to go to net
>> (unless the bug itself isn't in net yet?) and one refactor that doesn't
>> seem reasonable to go to net..
> 
> I agree that the refactor patch does not need to be included in the 
> 'net' tree.
> Should the patches be resubmitted separately, with one targeted for 
> 'net' and the other for 'net-next'? Your advice on the best approach 
> would be greatly appreciated.
> 
> Thanks
> Thinh Tran

Yep. Targeting the fix to net means it will hit the next release and can
get ported to the stable trees.

Thanks,
Jake

