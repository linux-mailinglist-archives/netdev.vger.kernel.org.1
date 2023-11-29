Return-Path: <netdev+bounces-52313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9777F7FE455
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853EDB20EE6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5C38DD8;
	Wed, 29 Nov 2023 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC/l3F9L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9327BD7D
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701301868; x=1732837868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NU+M80aLR5wm7KUwwQc/R0NJQI8HvuSGcjwQsZTGcvU=;
  b=eC/l3F9LYVdwg1J/86tfN42BgoXSbyXcDzmrhBhCU06SgOVhE6HrF4a5
   Z+DYIUuXfj1fU/RWBPXDos3tZW4p0R2UljNIrFQ+V7lrFmgg5dsVSv3Cy
   3gvv3YbpP9DXUgJII62zDmis2ZF4fq8473sxxhBW2IZjKf4ZRpGcBuEkR
   AhzSqxfUfJR4V670IZHPL3s2OK7lypSSjVgXisocIlhMul5b0gT83zoKs
   6rGIT1GBytDkeOVD8XF484R92H+D6YXWC0U2RJ7GpkVixA5Wl9EEDmGEv
   rumCNBkXT8Da6gGyU9jH32Rf5+/ThbLBiXXH82RZqJaEPRL0ouZdNpkVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="397136457"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="397136457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892617990"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="892617990"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 15:51:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 15:51:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 15:51:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 15:51:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRqjavBaAAlQBVIVRavoOwZEctj9ICrZOk6n0toqAgVsjLyAhHPqkA5h49uVLf4C+dBULs2pH3ZJpDENR7uzsbNHQ5NW89rnHkzhnVeb8AWgUtRZBDM3To4tQnIXZRheaa392sIwljZA01dprD5xJWB0bvg+3hhTJOWHU2DwWxb9cJVV9uWQhEy1DJVdZ+JIr2F5PNHiGJKjyrlsQkukREjR3j3pcvUZi38MXOPGjUNfZmTzulKlLzdJIpU1eDGDZ18SajFwD5mtJdO4hM624dDH9jL/LPLTlUa++b+aDV0mW3pB2qmNgCkwPbFMwznWOTTkuDOasSVg/5xDJCuEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWkZt0FOKfkUHh4Me3BerAnTCBEwUNAO6f4LYAIk3ws=;
 b=dvbTEfp9h1ITKm9SBBygnFHrNVcI+uG7UYFSQxjl3xa7Zga4TUGqXGUUb+yCAJWYq2YGBTZCFiaOIkwLTQogdtKsb9Tg0kva5pikavMrLr+6yvExkXV9yDPV0F8UaRMoFcHyAbdEFCbtJF5BdrTH3q4suvQ+lvvjYWbXss3xGzZgoJSj3CdnqEtqzGCRljI/FER8XHYwcT25w0VctEebLANzWPT1TLlsM2vwqv3KdJV5f6jAb1smsQs7N+oYaPj+Mgv1E2vEjZ1aEmpq4Z6saJOX2hao7OqKaZrPpfBrOZpJ4GQavOOU6iPvkXy+9YDdWjsn4bk8YXF4tZmChJ/l8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5672.namprd11.prod.outlook.com (2603:10b6:8:26::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Wed, 29 Nov
 2023 23:51:04 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 23:51:04 +0000
Message-ID: <3834d40f-919b-4dda-9e3a-9243d702ea08@intel.com>
Date: Wed, 29 Nov 2023 15:51:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 00/11] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
 <20231128180609.34a4553e@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231128180609.34a4553e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 375d9ea4-5d95-481b-ff3c-08dbf1360bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgKFdiVV6pjTEinKr64cSTUKP7mLMd1VhQDaI491o7VUqlyW8R4ESN9EhPkRMD30IJ7+qoU2O79c/w8g4FsoXQ9uanM9gUXyRubsGrMwdZE2y9qGD1aPsS7xq/SR9rmUcHZL/hUEBzNztNj8wviyCeKCx7HUNYA6dfmptZBWmXPD33e88B0XFeS7BRBtUgO3z2cfULSydfrq2dNZ+ZSzm1fygNB80qUd8H8/6vbDVPc8qRjc+ItptDFpgKM23Cfk2xEnE0PZsnLiPTBRhBsYVW3xlYkOFmc6UT/Y1g1Xr2sQwN/kh84Uj4UWc1Cz4W6AaaiMNFAZlhdCDOCvmOSe8vhI8XbbJs+iixiZaExO6CoMejnbcAmX3BGL4jw8ZsEBlFS2hY/b+oWASzejwjHpub7cFns/gD3VQAtrjaqgaGVq8QMl1HPFpp1j9auZEn6qXJZm3Fy+nZCErb5ALjLG5hx/XFDV4hVSA8JwW1haUKlOzDYREOXd8f/+quczQdL4wbAuU66AtXVpEq8LMT37oHU+MP3Z2hzpNXR7dUjdLUp2zYkx0oqQJHj/OrO1hs7m66OtmLA1m55gLTGJfc6Jt6xWuMmHkfVBHyGD7oZVcbSXz8rW1fHHh+u0ogj/heUhNrMePEYq/PTTU/UmOkjEgBMd4mk8YehL8IAiNMz2y5xmLdFssZ0o0p9VV55yzp67
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(202311291699003)(31686004)(38100700002)(82960400001)(5660300002)(2906002)(4744005)(6506007)(53546011)(83380400001)(6666004)(107886003)(6512007)(2616005)(26005)(478600001)(66946007)(6486002)(36756003)(41300700001)(6916009)(4326008)(66476007)(66556008)(86362001)(8676002)(316002)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElQODJhc2VjcDc4ZExnYzluSEVvVVNjaDNTK2VaSWJNQVNkZTlZelJkZDdC?=
 =?utf-8?B?N3d3dHVidWhIYmdxYmJkZDI1KzhVME9idWpOWDMrWVBIQm1oelM3NlltbnJm?=
 =?utf-8?B?bGlqWmlXdEZpcWdYb1BEK0h0ZGhqVzd6UDJmSUlkcS9EMFVycEJwNXpXaVlD?=
 =?utf-8?B?VWVrV0t5ckE2bnZMNnBKL2g4YXdSQ2k4bjM4NUp2QzhFVDRRMGZVaFZPT0p4?=
 =?utf-8?B?a0hETXA4NzFnVGJwc1QwTW9IbmNucDYvMGRlMG12UkxMTnQ4MU5rN0svS0Rp?=
 =?utf-8?B?SWVZY1FIVGRja3FKTEM2SUtsVnpVWUpmZC9mTTRMWUcvWFgzUnFQdDdCL1VN?=
 =?utf-8?B?TTZrWDI4MDRjc0NkWERFaDVPS3JSM2s5cmhUZWpWcXBTM1ZaZkRicTR3M1JQ?=
 =?utf-8?B?T3BDdEliOGRENnhzaHprejFGNWlDcWYxdC85UU40R000M2UweDdnZEhIMGRC?=
 =?utf-8?B?VDBOU21xY0RRQjdIU2N0ZHdkQWxEZjdhc09LUy8wQnpsc2VqSUw0RDBsRkNW?=
 =?utf-8?B?OE1hQU1Bb1ZGK0xOcU5hVnVpbGJ4R25Ga0dWdkZyV3A3YkhpSXlJelhINnVN?=
 =?utf-8?B?L1hMNUJ6TUFDdGFPRWxLeGVuM1FQdWppUEtrMzdZUWJseGpDMmx5a1FYTncy?=
 =?utf-8?B?Tnd5ZVdhbjJPTmRoUkFwa2JVQ1ZCT3NDcElQRncyVVpLT1ArTWpFamFjWjV0?=
 =?utf-8?B?Z3FUencrN1VtdG5QMHBtb3d0SUVUMFd5S0p2YWMzbWxuRUd1ck1OSytGSWRn?=
 =?utf-8?B?Yk9xM1NWQVFqUVIzYkw1TWxrQWxCM2xwOW55cTA0bWVaSlhvMzR6V1hQeUtr?=
 =?utf-8?B?T2hBRk9FT0V6MjNXcmR3eE1nUmoyTFBTZE1IYXQ2cCtMb1BqUmFpZ3M3bUxn?=
 =?utf-8?B?dGl5dWIwd1hkdkV4ajA1TjRBZ3dJMERSNWpnaTJlM1NNaTEzVDJ6M2JVc0Za?=
 =?utf-8?B?UVZTM0FQREpzaGZxMDloSFFiQmFCcCtHS1JHNjF0alAwNlpzZ3dZd2IxdWJ5?=
 =?utf-8?B?UzZ0M3ZydFBZOWxLSGIrQk1JZEdmVDM0S3Ntb2t0VFRpa29NQ3huOXdOYksx?=
 =?utf-8?B?dGVteFU2SUZVNW9xaVpVYXpaWlBTU0U1Y0l1RDZXUjRQYlZ3V1p3QjZmOW1T?=
 =?utf-8?B?OXl0aXVOVkdKemRtSUhGa3FmMXF6RlZwYnNTTVByYVozU3k4clNBaUpONWMy?=
 =?utf-8?B?UG9yNjU1YmNxR1hybllUYXlJWjJTQXZPNmJIY1hpVUhqTGtkKzBDb09xbTN3?=
 =?utf-8?B?eDVpTkVrVmlIT1pXQnRGVi82Z0hOZEUxZXRaa0J3ZlJBSTIvTytqV3lIV3ds?=
 =?utf-8?B?VVZZekRQTmJ1aW9vNnF5dzVOaE5xcmhVaWhuMHFZRHdxYjlUem5ITDArUnJT?=
 =?utf-8?B?OVQrTkowbXlEWXQ3MWtQT25HWFRzOGMyNTJJMjVTSXY5c29oWUF4MmxYWUs4?=
 =?utf-8?B?K0xadmRpd1FaYlJJc21wMWxGRTJSaUdzK1BjQSs5U3A3THZpQ2RvUURvaXBD?=
 =?utf-8?B?ZGJkQk5kRmN0Y0FYako0WU1MV2oxbnRLWStwNTVPRkRMVEdXU3ZBdytpbk53?=
 =?utf-8?B?SDcrWkZkRi8zNS9xSkdkSmFwQWZ6amFuSHFvd3BxMmY1WS92Sm1TVTlDUmJJ?=
 =?utf-8?B?UC9LaUdiT1gvZlJNTGxUWGsyb0RQKytlN3lmNy9MaG1oZzV0NXhFTkVkYnlC?=
 =?utf-8?B?ZnN4TEtPNUQwZ2dpM1M4Q0ZOTEFmTStqbWxScWcwUVZmeEVoYXU3L1hqQXZi?=
 =?utf-8?B?citoMEVBZk9uSjBHVUdOSk5uZEdybWZHM0Y0K2oxc0h5eFBxM0JNckRUL3lC?=
 =?utf-8?B?L0wxY2k1ZVhTdmlmVTNmOUhaYlMrYzhCcEQ0TStQdEdrbjQ1THNJcTV3TjJG?=
 =?utf-8?B?eDh3bnZKSVVTVEtBbVVveHRubFA3OHBkbVZYWWFLWi9MQ2FsRi9sRzc1UDNV?=
 =?utf-8?B?c3d1cjlWcjdJcjMrdjExalkycnRCcDRQckIxdWtENmw5WFhSQVllNnlmQmZa?=
 =?utf-8?B?ZDNCRlhXNis3TS92YUNmVjQxN3Q2R3JXWmp3Yk82M0ZnTDhicXd0N2k5REVH?=
 =?utf-8?B?SExtZUZZa3hpcXZMbmxVbko0dlpyTFZPYjg5Y00zdDFZaHRrUG40Qm0wVndS?=
 =?utf-8?B?ZWczTGdKVWk4L3FPcnQ4clJ0YjFaYnp4UUFKWW1YMm9UYVIvbnhkMy9TbmdQ?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 375d9ea4-5d95-481b-ff3c-08dbf1360bbb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 23:51:03.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwyWfqG8LMs1nM5ReQ+43IlSjtmckX0nxCOcVKg2LFiKhSs9PUf2sZFo9l3PJ0xeooOx34bFwpOce/KjtIu0vj+3dTSCLSHIIqScWViUtEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5672
X-OriginatorOrg: intel.com

On 11/28/2023 6:06 PM, Jakub Kicinski wrote:
> On Mon, 27 Nov 2023 19:49:25 -0800 Amritha Nambiar wrote:
>> v8 -> v9
>> * Removed locked version __netif_queue_set_napi(), the function
>> netif_queue_set_napi() assumes lock is taken. Made changes to ice
>> driver to take the lock locally.
>> * Detach NAPI from queues by passing NULL to netif_queue_set_napi().
>> * Support to avoid listing queue and NAPI info of devices which are
>>    DOWN.
>> * Includes support for bnxt driver.
> 
> The changes since v8 look good.
> 
> Please respin because my page pool changes touched netdev.yaml
> in the meantime and this doesn't apply any more.
> 
> Please make sure you CC Eric on v10, and Michael on the last patch.
> Right now the patchwork get_maintainer check is complaining that
> some maintainers were skipped.

Okay, sending v10.

