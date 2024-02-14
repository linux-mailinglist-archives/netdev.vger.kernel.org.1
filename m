Return-Path: <netdev+bounces-71859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDB885559A
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFFE1F23F48
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669114198C;
	Wed, 14 Feb 2024 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1waUpGv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D77141986
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948907; cv=fail; b=K4kHZPxHKapnoIkAq5bPKd2aY6O+IaV4UephkztoybmA6WR6RVtbf1unW9kblT2X8kIWrUmDcofS/V+hgsYsrHvd8uBfL7X3LxovxlY1GSYPbAcqgn4uMyqT7V5P4phH8JBiv9wdhNgDnDQSin/jZyMXhJ2AO1F3eBdm9qLJwCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948907; c=relaxed/simple;
	bh=qU89Q9cK2UYhqokhqxkTjxAANbPf1Rs3xt1U1Xydri0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYoqo7Wpc1Syn5gbEYymxBcguE1MGpODy22eh7ioxIppxNlWbZ51NNDlSs+x5gTRooffWmmNVbQddTWVgeJFFEOiWln4m/XMsdj5q/awUDEH2TNoPHGO/45vn2a2nnCvLnO7z3ETQRZnFW6O3f9vRrfVxFA30KedQMNj97Omfm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1waUpGv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948906; x=1739484906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qU89Q9cK2UYhqokhqxkTjxAANbPf1Rs3xt1U1Xydri0=;
  b=W1waUpGv8h1X14ahynC3Ig3Po6MZFZKBXDrL5eHNXYO5DdrEDQmkVq3e
   W74LjjyG0Dbqgg6DbSeM4al+k8yd8BbEMyDhP5C0Txh/rTWLKA0P1Zr3i
   m4g0Y5mECmL3TWor8a+hdWJKgWwwgZNDnuLQIUDVaMj41jsmEAxhS7Su+
   KZ4ENjiXLMD920qsIxWro16xFG3lUTW7f3rRyFoV1Vw9HPghAQ78aPrNy
   V/PkPGwCvkktRrD8NiYgZSlIP90fMjjRSZBSD2T/zHpZ8rrFEbQ9eODWY
   uK/M1UhQPbdVKtrgcYTump68yiQOJTD+leCIVTa/ibu/mIE7GG138AqKK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1874026"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1874026"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3342491"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:15:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:15:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:15:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:15:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:15:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNfR11LS4cTnMEhYVXJSYkUTVwMeBVQOCmXPomlLd2L0+YTZBoGIe80RwzLEwkwUVdCNY3S1FL8hj3ZUu129cx0e7whc2T0xaCeBI6YgnebhujSXFtCui8fBT0v5NGhYxONOvLASkdVg2UewQT8VgX+mwAtzXRgl6zWX3WUIHlKJTTKfsnC3abkfTE35R2KbNeGpXwwMqkfp/uGaYrcq+jk/snQtYS//yluMzsX+QQN7/jk392WDGUPfSLdVgFECEz2tkUt77JPt0o//9EXjYwUWR6DUJD5Z2Otx0cl9r04T2vOXL0ThMnUgevNN6RWLpaZFJVkZi9pypnE7RudwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I21yq2xaDmXVWBIg5KTzBlC+WmhV8x9NlFsT3G4Q1BY=;
 b=S+9zQH7pllTYdCfJX+g2AvUS5H1LpSNCUEtwyRCdnLWDxJ9H9akJkSTjNxRwaj8Z3VAK2EfEMymJ7G+gIpVEeeNb9rDrMcOlTy+4OMVP+wXRxeW1w5cQ+inxyUredgAcMOVLaQq8gxpt99uvYBUNiI6MabYqFwYpU0Zqt1RprxSau7DHxzx3HelVE1nsSeVjeHue5cVCKe2ykOea40FkOxWNrUTAmJx9Ge83bnEKZnvyaFDG+FdqsCcG3fYPg2Wf0dkHA2yyXLGoojJf9YmZH7j2Fv8xH5s1GJd8prU8G5LeVCpAn8pK4VoenuqzZkGAOP4A5HtUSQ9Nst2a0FuxjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7242.namprd11.prod.outlook.com (2603:10b6:930:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 22:15:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:15:02 +0000
Message-ID: <48ff5cd2-fb3c-46a8-a52b-b6c50aa88598@intel.com>
Date: Wed, 14 Feb 2024 14:15:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 5/5] amd-xgbe: add support for new pci device
 id 0x1641
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-6-Raju.Rangoju@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214154842.3577628-6-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f0f5bf-110d-49bc-c9fe-08dc2daa6420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XL8PxqmW0na0qpc39HaIiYzwtSYCrNokNznTuLwUVyqkh0gAvxpF0Anq/gM91YAF2AAVXil7HIGKydmaEOhWAKqd2mLr94MlHjKxqvf4ppbwY4bi95xMy5FqmhDgwoeyYAc7O5CsrzsPC4Ey/ifu8GEwnSdchHq1e73ZHj0QQaWE7HJ4iwb41qusnnLQ9GIYtiLONl4vhwlW59NnQLYPlONRgKRzgGBfJ0vS0pB02eWwagpEjMJTOzx6yB2D0tTNa6zhtLz85ivuwuXp31gknXrGi/jauII4A4s9Ff4iQBEBGXoxDLhNivmmt+wMW8dE/ls+hE5AE9WqE+deY0jgJopU484Yc9eMuLSsfvqBNXuuVp6fx0nB15bjweXO67f5X5LGkt3BZxDrlwG8rVoN93wZgHCt3cZ0N6xFoZydhH94P5Z6JpLaVqtvKsUFtarjZnJP3xTKMVVJ+ls3QTGrjf8m+eRtPAdfRoTEGC6N5UOLCsq+M4qJPYQvIOdGyrQeQ5Voj9flB/x4CqjZw1uVBwe2PopOyGjmst7ha9YbsyAcugu9fVpncNHnjDa2T7yl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(31686004)(86362001)(31696002)(41300700001)(26005)(2616005)(558084003)(38100700002)(6506007)(2906002)(6512007)(5660300002)(53546011)(66946007)(478600001)(82960400001)(4326008)(66556008)(316002)(66476007)(8936002)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FWUktZQ3h6TzV2MXlldEE4VjNES1RQK2NKUzgyRGlOMUxGdWxaeE1jSlhw?=
 =?utf-8?B?RmZZbWVXaFpiTUpKSmRNemloQ0ZxalZ5TmREL1M5bVAwUzgycXBWK0xVZnEx?=
 =?utf-8?B?NnVsUGRjQ3I5RUtuNFcwckQwREpnMUZ2VmpCU3Z5VjRhTVN0WDVEa1RMRG9C?=
 =?utf-8?B?ckZXOWE4WmpVZjVYNmZjSGNxOWNCaUFFSHRTT0Z0eVZBN3lraXFVZEE4UGc4?=
 =?utf-8?B?YXZNYzRHZU0xbmVUSEl0UUo3WnZxNjRFc3VxbDcvTnlvSE84OFJOQjN4bGV0?=
 =?utf-8?B?NVdxU1h3aVNFYmlzcTl0OXJ3aFYwbUxsbHNsbWF4SE1BanBHY3EraG9tK1BU?=
 =?utf-8?B?UExIcUhEZ09FM0pGOFNMREFSSWp0a1RBWWdkalpQMU5xeFdzbFdnS2ZLWGFS?=
 =?utf-8?B?WElmRFpTaGlqV0ExcCtpRFpwdnVWNndQWG44SWJPZ3ZSMlF3MmVPZEp3Uzdt?=
 =?utf-8?B?elp2bWNHY0hlbkxmUUV1MHVXZ0pDNGwzV2N4S3JKOWt3WFd4d2dxSDhEWWph?=
 =?utf-8?B?YVg0azFVaEpqNmg0ekpRUnFmb0tMVmdIb0tBRFgwUEJvRXM5WDQySzN2MFh4?=
 =?utf-8?B?K1ZDT1hiZkxjY1ZweWVDK1Z2ZjBSajkraW9lWkIrN285ZU1rQzNaalRjdko0?=
 =?utf-8?B?YmcyRzR4NldPSzdEK0NjRWRBbWo3S1hiQVpTY3FpUFZwUVFyS2RWWmV1K056?=
 =?utf-8?B?S0NFN2ZPQ0xMUHY3VE1BMkJXWHZvazJNdGhmOGdYdm11S2x4Yk1UemFNdlEw?=
 =?utf-8?B?Y3JuL1JrR0F1L2RrNk9URHVJVUdIZDMrT0tBZGt5bG9oWnN3REppdzFMTmNp?=
 =?utf-8?B?L0tPMnVkZ2drWGVrYW9LM01TVWN4eUoxSkZSNURvcGdZRm5IaWw4SXdIMFB0?=
 =?utf-8?B?SGUvTm9URkxEc0xzUjNBYXJBVGFFWFJMM2pQZ0d5cStkK3V5YkdmbkVFSTNM?=
 =?utf-8?B?Ry90TjZzUTYxTFk0S3pYRlpDWkRHdFpOMTE1eGNkU3JXVlNCZk16bDI1dGZv?=
 =?utf-8?B?WFRrWDhwTlA4bUtLdjdjYnkvNVFuTUlsQUJCMTU5a0xpRzZwbWlzTXMrcEZD?=
 =?utf-8?B?RGNWaS91cGxWV2F0UzlBTy8xaE4rSGhtSklFTTVMRGo5ZThROUMwWEF6U2lZ?=
 =?utf-8?B?ekVuNWhHbjdjMk9HTSsrL1A2bDlTaldhNk44amJaNy8ycUVBTFpmVXBZVDVM?=
 =?utf-8?B?Y2VxdzZKM2lKZGRNTi9IUnc1NENSWnFvckRMQzlJMlpZOThUQzRURDFTUE1H?=
 =?utf-8?B?SzIzRjdJaXh0TUh5K1JibWdiNGhHT1pESzJ2NTAxOWJ1bVJsVzNac3NHUEJy?=
 =?utf-8?B?bGV4RXpZa1NFK05uY2tvMG5jNFlXQkdyNURKSDFJOVBSbG4yN0F6bWk2NzZR?=
 =?utf-8?B?b3dsT3pkeEkwbklzREh5TXc2Q2Y2Y2xQZFQyWmZQYWNZV0trTURlSmdjeUts?=
 =?utf-8?B?QkZFUDZoTUQwTEhPR3JIWXFJT0FNRmNCclZnUW1INVRucGdMVnZzaXhkSk1y?=
 =?utf-8?B?dEdZSU54Tm1ERFlTdXptbWhsU2Y5aGZyc0Z0WllmaU5ROXE0SFVoZ1lMVTRW?=
 =?utf-8?B?dTJraUtFa0FjODdGZ1pmVmhrSEl4Z2EvTlBtQmpBZUcvbGFPV2pBWVFPRGxt?=
 =?utf-8?B?SFFXNEFOek9GZHZKdjZ2bnB3RG5qTCszdUtYcllCU0tjWThsOUsycENjVExD?=
 =?utf-8?B?SjJ3dktzTjk4SWN0d3pHSDdIcGxNWGZzTWRQbGhvK01ibVZDazA5QWFNS3R6?=
 =?utf-8?B?S2tmbTVDVC9nQ0xtSWlJeS95VlBjbnVrTlQvNWlBTHV5V25TR2lLZTJxeWFl?=
 =?utf-8?B?ZGZ4aHVHTHJsRGNnUXRmTUxwUkxOaWw1YW1EU3V3WVFaTUpjcGFkNmI3aFlZ?=
 =?utf-8?B?R1pYVFNhZm4ybG1id2I5WGJ0UHdvVGRQeUJrNWZqdi9XYm5qazRrWDRtUkZO?=
 =?utf-8?B?Z1ZLbDdqTlN2RDUrUHA2RWUzQURLcEo0bmt4bHNsOTVscnBNd3BSRWlpQnFZ?=
 =?utf-8?B?QVdTRm9samZtR1dHN3JsaThqYzVaMmVINExxRFFBOHpRdFhNeDZVRHBGek1n?=
 =?utf-8?B?aGhydXdlQjJhNTVwVGpwVHh1SWxuKzNua2dKa3Ayb3UyQWNvYS9GSnZEYjg4?=
 =?utf-8?B?TTNwVkZCNmR2TVY1QmsrUEU0RVA2RS8wUDhaZld2SjhndTR1MTdvS1ZQVDV3?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f0f5bf-110d-49bc-c9fe-08dc2daa6420
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:15:02.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o59k1MBUa9DCn7L9GCcSib9BxfvYUyPnkBLvWp0YsohzEfOb8PtdAKmJ0lHPoxOtFFbnKe5Rv+CM92cGxWhOt4DRzH+SGtmjMJm9awjPiZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7242
X-OriginatorOrg: intel.com



On 2/14/2024 7:48 AM, Raju Rangoju wrote:
> Add support for new pci device id 0x1641 to register
> Crater device with PCIe.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

