Return-Path: <netdev+bounces-69619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122D084BDFF
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 20:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050BC1C23EA6
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F913FF2;
	Tue,  6 Feb 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azZRUjAP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB401426D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247140; cv=fail; b=TWYlQ0/rCVkqx0vq7sv8ZHiaJo9oDUi7Pbp56QuNDPyGxxMCFgrL8a0scPEWqmG+h8VB58NT6K7ZjLCjoJf3Yw7YuHYLwSaDPV0ek6dKgdFzGXwYD9zv4H2Tm2gZcD3vU8IgRVFBVGXfFu3I/rsjLSjZ2ge1KScY8fsucNAp/Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247140; c=relaxed/simple;
	bh=6q+yVyii1GaAOQd0aQXy8Iv3xeNU3KfZ6jUoru+GkwE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QvFXhjqQewY056DEMWqHKua0ZJ8KwrXQ1p2+mnQyJsTrNs1KyBvVeriNo2uXShDaxt0wm7V5auN0nDLVJbdwuaAZKCK+bK0scr6vC0cl5blsgjd8TALAotLT5SuioqzGePiPqOgkB+jj1FYuFQ91mabxC3p5eMPDZTlx8La2zlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azZRUjAP; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707247139; x=1738783139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6q+yVyii1GaAOQd0aQXy8Iv3xeNU3KfZ6jUoru+GkwE=;
  b=azZRUjAPOkfDPlLVDi9WJ76iTPHedvfi6FgQcrmAvS5sdt86au75T0t2
   FXNY1a9H3vVZA+A+kTVdumH+Zd3AzoMBZ7wzCwMkPjVS/O9SBF81JSHbZ
   s4fLrl8juZ7mlIzSN6CIm7Natwk8DXKIKgPoceqKYCv6x8yehXYsm6I4n
   ZNwmU5QtWo/36Yp2XXeJ08Lszn6S0sJ8XX5hh1jqH4vukmo4BFNgYlTlu
   OJYUWXAXZDRU4TyVTwQHP+PoA0TA+czp9NBh37J6lCTyAzaVXUweNUWkY
   fmwZsvMxkKNoR4VJi1702BRkHwx1azPkI5M6HNKp9f3YBefe8EimxYnD4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23305934"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="23305934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 11:18:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5726487"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 11:18:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 11:18:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 11:18:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 11:18:52 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 11:18:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKo928HHxNoaBkQdCYLR06LhY2XEqsda6dADE0qDZ4N6L2BcLsVAP73CWv+ku39jA+mJ2hX6SUn9Vok0krFKCZAbMtHRMhXTSp2U4EmZxrnF0maTvmNbZCoUGplPPpIUZxcHCjqA4GbCk5yJs7BA3eLFyDN3P/FOhDwA/+oVKdUWC8V3GD/u46NYl8pzRi2KBAcGkvFKZnAQ9PgsWBp75vPsGJpc8+FJcc1KCSkAPEtK4JGDhbF21/oSdnu130K9nhtfxdL6/3wNHXEG4w+cmbstEf2pqMYY0clH9fMJ00UEOfTed9SSslSc7VdW0xSB1oLTUJSNSufpYXBeEJIQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRskUFS47v6i9c/xrn3wzi/nzNY60Qc7vUr7ABq8kFw=;
 b=J8zl+siW2daQYBDZa6Ie25vrwpoBecqsQP/eW2QXIfbF8wds2gt1kMmzuhowLlChD4hlo5Ma0mcv4zzbVy1MXNkZFX553IeRqiBl0Vcqqc2YKB72GnayZPh6iEM236s1tGb8Q13wrR0Wrt0OMH/sHWI9NbkE2qEQ8Sp6JlFq7J/xxHNz1eJyZqURNQScWrCC6+PNdKV4C7f8vBN6cOlhPu+4bXsQkJ1tjEcarj3hfrnzsE8jfRJ9xz7dieBMTXDoDEzCdU1jcuh1VnPTdIh+ysuCbGxmwtsZl4dCaawJLumvUOVx4U07m7xD0BZkL7R2HNyfGr2riZgJwRJIjVAEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 by IA1PR11MB7870.namprd11.prod.outlook.com (2603:10b6:208:3f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 19:18:50 +0000
Received: from CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bedd:e757:f922:119e]) by CO1PR11MB5186.namprd11.prod.outlook.com
 ([fe80::bedd:e757:f922:119e%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 19:18:50 +0000
Message-ID: <d93d8608-be23-401a-b163-da7ce4dc476f@intel.com>
Date: Tue, 6 Feb 2024 11:18:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10 iwl-next] idpf: refactor virtchnl messages
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<igor.bagnucki@intel.com>, <aleksander.lobakin@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
 <20240206105737.50149937@kernel.org>
Content-Language: en-US
From: Alan Brady <alan.brady@intel.com>
In-Reply-To: <20240206105737.50149937@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To CO1PR11MB5186.namprd11.prod.outlook.com
 (2603:10b6:303:9b::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_|IA1PR11MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 288dc834-769a-4db1-1059-08dc274872f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSK/Cm3RrNHOkG9fRNEEV40AmLMOyZP86Brxv0TL33Trg/uz7aaiFtsCsk5x2cFCaZ6Y8jz7AFbmBzCm2CQLDhjq8U9oCToywp+/GNyNKBtq5NW054gG7urg6Gr0Vtd3duw7QOsXJQ1o+6AG4G4NPwqRb7WpojF1SE/cuLTr/h7rOam0bngXopnRY/3nuW/mYdCzFqDoJhtu74mQQ0Y7j5GPAm0TZuUteE9vxDQod9oyuNojq8hbXljWi9X8DYMGWeL5hNhWPEByccIiAfgVefvdkZEzW3mS+JQnA0BmopueXlVNeWUburB8sJ6JjJiQJn8YzQoABLdyTfp3RX+0oGtof9zJyp5FP8LZ0kZQSNFi2bBTz5A8KGIEqD3UPohvu0UjCKdnMGyCwC8INUdZE2k4L+nwn+g1ICy9cO/gVV6cuobciRkhBcz7k/boFHDC/M8UfEig3GuGZ0dwaBfAj8bvaUz2Tyrk+ZsT1k1gYBEKyvjX7iENjcKHQ7aj40Pw5Mu4lUgSYF6B/OeA56Dgi1r5LJZB9gbdVQvpDlJS/HB3T4UlRK0TFTFxgW2/EeNPiNXaT1dczeE/oFQQnp5Lva+Jj75uevmF41c6eXiqoh2yTQitIIGF/roMTokU4NWrrQEfI/+PhdytaMy5hzn+qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5186.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(31686004)(83380400001)(2906002)(38100700002)(82960400001)(41300700001)(316002)(26005)(66556008)(6916009)(66476007)(66946007)(53546011)(31696002)(15650500001)(86362001)(4326008)(8676002)(8936002)(44832011)(2616005)(5660300002)(6512007)(6506007)(107886003)(6486002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1NKa0F4cmdzcmtORVJNL2FIU2tLOG5vWmVJMTB6SlhWTFEwSXQ5R056ajg1?=
 =?utf-8?B?blBuaDY4MmhRZEdkRmpKYWNYOHhlY2g5S3UwYkNidzE3TFhCK2YxamZONjJG?=
 =?utf-8?B?Q1NVbEc0QytwM1lsZm1qTHF2bUk3ME1yRlNWbFJ4V0R4blFsS01VS0pUTElw?=
 =?utf-8?B?RUdEZDZUaWJtNTFxdWZwZVRwUWZNc2gveXV2aGlCY095cmhPNzgzNzdqTi81?=
 =?utf-8?B?cjA0cFh0THNGMUZDcHduQUxZQ3RBRWc0SEtXSVc5T05JOVh1MmUxQXU0ME9m?=
 =?utf-8?B?TllyTm5rV3ZNbzl1MTBwSWFheDF3cUt3cGcvakJuc25tNGcrU2JNQmNraTIx?=
 =?utf-8?B?aXpXcTl1Y0lBYWpmOFpmaGdXdkN6ZDRhTkU5NTRpVWxya1cxOUdWd1ZtRFRu?=
 =?utf-8?B?SXRqV21ZQ2lUaFZpTmxsTlBSdjJwR1ErSm1qZ1p4N2dHRGJLVGtmSmEwNS9h?=
 =?utf-8?B?NDd0SkN6WTVSM2xjVTdoR0RHVWZYdTRRTmgwRDcvdGdHNzhnN211UGpxanhI?=
 =?utf-8?B?aVY3enpWaUloTkFjZzl6VGxBTTlyZ05zZGVTZWRTNTYxaTJrdHlmVVN3b292?=
 =?utf-8?B?SmtoSmllMUl2dDBjVFUreUxXWjkxNDFrSU45Z2Q1RDJZRll2aVF2Z0o3VHZ5?=
 =?utf-8?B?amFLSkNxZXBBS0lYb2d1NEVxakV4ZGhFMHNUNk9UaHpmYlQ5SVBBVEJWdS82?=
 =?utf-8?B?NFBKbkliTWFOZHFka0hKUk53eUxlOStsQThaOFFOc285ay8yOVE5VDk2R3RD?=
 =?utf-8?B?R1VqTHgwMGZ1TWVTNmNENjNKK09ZY2hVOGJNS054QS8xSUpLemJlV2tjZFov?=
 =?utf-8?B?VVZEeElLbDduSFVZNGx1NDZoclpKSlJrL0pEb0N3b0t0Vlg0TXZSclJaOTUz?=
 =?utf-8?B?T0pCYTN1bGptaDRBeHllamVvM3FDdExvSThiY28xVFhNY2VyNjh0V3FvaHkr?=
 =?utf-8?B?UEd6M2ZpRUtUN0p6VEtmeWVNd1N6eWZMMFdQdWxzd280MllwK2FnQ3ZQWFJN?=
 =?utf-8?B?MUlBazhWdUVFbHZFZm1Na01EZUo3YUc5ekxXdytnSHdsWmErbnR3TGpvOXhB?=
 =?utf-8?B?UTFwd2FHaTJBbHVWV3g5R1FpQTRPd1JGanhuaUVPT1ZOcmpDcHhnTExBN0Zz?=
 =?utf-8?B?U3E3VUd1cXNYd0ZkNzBYR1NxSVpaeG94TEFUS3dFQmYvQU4yWFhxRHRqRE95?=
 =?utf-8?B?dGVFcXkya21jZmYrdlFaKy91SEpPdzlIM295N0MrVy92YmptMjVLdmY5a0s0?=
 =?utf-8?B?MDZNZmovMEY0TFcyWFZCaTIvaGRFbUxlNVZKRHUzaW10VVdnUEwrTEwwVnBz?=
 =?utf-8?B?RFQveW1HS1dCUFhtaUxpQ1hvdFI2eE54Q0ptMnRIUlVmNDFTZ3hWL3duWWV4?=
 =?utf-8?B?YXMvQXBPemFVdW1TV1FUYWtOZHgxbUdpUnRBdkE1b2ZGWUd2ZDFyOW85UmpV?=
 =?utf-8?B?V0htZ3ZHNmUzTm0vaEZmOXJXK0FxK0JZdnZUSDhGeXo1VU5LNHEwK2FqSVda?=
 =?utf-8?B?S29HeGNnOXdtM01WdHJFNzk5dkRkQWwzbVk0anBCbHdtWVFhTGlhTFd5Y0g5?=
 =?utf-8?B?eHRyZmZlNThrdUJuWk9oQU1SN1RhOGozeUFZbCtUbTdjYkVvNUI4bnpFTTMw?=
 =?utf-8?B?dEJLenNzY2dOaXlXb1NPQXJrK0svOFpXcDloTUxpdU9mb1BYdno5RTdtNlJW?=
 =?utf-8?B?T3g2VktNalc2Z3czMmEyR3VYcFZNTUlOT2d6QkZtQUFTRlRPUEdsWS9VWXJP?=
 =?utf-8?B?ajlHWTlsQk4yb0s3ZHJyYnZTeVlXUkZIUlhsUUxONWRhN3U0Y1dDYjROWmVN?=
 =?utf-8?B?WUErVitGWWYyZkZqRStlYXdWcXROeVNyZVYvUlN4amNHTW1NYkdnZFU5Y2Zr?=
 =?utf-8?B?U0NQVUtXakJCVC9WMUVrZXpwTUlLM2V0bzZNbGdQNjlIKzQrU2duY0lhN2pT?=
 =?utf-8?B?dS80emI3Nm1adFYyUEMvWGhvRFoxR2MrbFFjb3QzTHpBQ09QRVZnaEdtOFlv?=
 =?utf-8?B?SnU4and4Q0ZCOFZUVDc1dTM2MVRvM25RbHZKbG1WOEJhVWRiaFB0V1VCQzhp?=
 =?utf-8?B?YW9ESXdFenBDbUpxRUp2U3lycThOUCtnSEdmZlh4VnhoVlVkNjRmQ2NjQ2FF?=
 =?utf-8?Q?7dlkyyEJvFCGjaLHqDRB9lK63?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 288dc834-769a-4db1-1059-08dc274872f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5186.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 19:18:50.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqGF4ARNeSu9zkz5BB/GgRZsMJjf5KbiThLT73rVbNvJLIxsCd/zTmHxqwiLyO8zVRgtOFiNmcNleRx119rg/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7870
X-OriginatorOrg: intel.com

On 2/6/2024 10:57 AM, Jakub Kicinski wrote:
> On Mon,  5 Feb 2024 19:37:54 -0800 Alan Brady wrote:
>> The motivation for this series has two primary goals. We want to enable
>> support of multiple simultaneous messages and make the channel more
>> robust. The way it works right now, the driver can only send and receive
>> a single message at a time and if something goes really wrong, it can
>> lead to data corruption and strange bugs.
> 
> Coccinelle points out some potential places to use min()
> 
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1956:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1271:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1319:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:2640:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1295:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:2157:17-18: WARNING opportunity for min()
> testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3582:17-18: WARNING opportunity for min()

We did run coccinelle check and see the min suggestions. It's triggering 
on these statements I added:

return reply_sz < 0 ? reply_sz : 0;

A min here would change it to:

return min(reply_sz, 0);

I didn't really like that because it's misleading as though we're 
returning the size of the reply and might accidentally encourage someone 
to change it to a max. Here reply_sz will be negative if an error was 
returned from message sending. But this function we only want to return 
0 or negative. By being explicit in what we want to do, it seems clearer 
to me what the intention is but I could be wrong.

We can definitely change it however if that's preferred here.

