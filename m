Return-Path: <netdev+bounces-142964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3659C0CF3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC382855B6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E9215F58;
	Thu,  7 Nov 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KADhDm/2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082CE216E10;
	Thu,  7 Nov 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000781; cv=fail; b=foFuH6VJnP9fD9wjCzRCZKZflq78dgy17wQ58IYAXQDUYtxLuu+aPUYn22aW6yNOvUTUagwfRUiY8iktEYJdDxr+kWvRTNxMLqrX8viZFEz7pWK/zU3Rd6Fg998QVF+CnseWleAdolUgvsO2s0c20X/O/qIB2xtpP2OPy02G8SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000781; c=relaxed/simple;
	bh=m4Nmn7sB0poidWz60N52Qf7kRT4r5UVBIjqjT1oRigU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IF5vJF1OCJxc+wjZ2gSeiQdhXxJtb2szSXTs0r+PJSMzVCPv52idwbL1Lt1GSUhXxw/L9BVGL2Ej0D5jk2Wr8RfrUcYy+Fg+Yv/+7vJvHnjq8UdTXktHHTWfxXOJVqLQzvKpvjrHS3PhCqNCpZiQqK9E1v+bH7MqCcF+oFPgsHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KADhDm/2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731000780; x=1762536780;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4Nmn7sB0poidWz60N52Qf7kRT4r5UVBIjqjT1oRigU=;
  b=KADhDm/2iz6Gn76rw91driIWriRLex+mVjq8N+R8ZU0mi/Ivek21ivWd
   TkXfbv2mz+cu95NyUQ4aDiabuEuHBux/AP4SDeU+dVIagOar7tekrREKa
   Et9gcfsqgljrEv8ZTMPKNWrZx4+S4UwTR04dRVj9Y75qAyV+lb2rx68h3
   fohX/kI9NwXntUUMlG0cVpTgFrO0YuUlB/MYQULMuk7+DFn5MlnghFEg3
   4wIs13Lu9lwd6mTiGrsS7eXNbG2dMqVSMOODe+ExlAuoDwfWL8Pmnhq3+
   AAhdmm6VfBoFpqfTKDCXsz/vsu8BJxRIp75yoZltsGX/VETT7t7DSODzN
   A==;
X-CSE-ConnectionGUID: fw3U73vkRf+lLWQJW0ojmg==
X-CSE-MsgGUID: 94+sv2WVT5WiHWsmrJw/aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="42233668"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="42233668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 09:32:59 -0800
X-CSE-ConnectionGUID: WYAY+f4kToy4hpYi0fNJ6g==
X-CSE-MsgGUID: /lUKjWZuTUyYBYyuCiAZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85967591"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 09:33:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 09:32:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 09:32:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 09:32:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AompA+bmVx+0uz/HScMbVwsKN3sDA60ldMJOCAHB4xlQG06tunHtpny5IdtLSkVWUq4iKmH/3XGL5a9XXbEQ82wLu1IQwUGzZ3/Jq6oSmBFh64ZQXEtu8NOPKUWe+eyVjq3SMHDOYDyHvxh8edI8+D3BXEPMVNo6RJB3PpokVCPRVzdN7fSrLGTI0v1yadqlN+nKqLboSPqCIBtjY2kzjwmhqsJZkOfNqtzbOANGjJELshQRpKQ4cn14Xp1mOpiQpd8RXfJVxWkkWiLbmUgw55U/9H+UAtEukZ/vFdjI01up/ATk6RSiYK3OGMo6FAQTqed9yA4ZWEt5G0p0E6Khvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkjEaglUZeoHarUgrbfCCDAIibltcULxnvshJelLAoY=;
 b=aLMHR0x0ixHkHa5zonTH5c8OmFtdgu1+IGZglEf6dTC71R1OoN6dUMK87G3RMhAIRzjckeS2jkYw27pJO4FUpZ04Nv+N/cOLEQfz2NZvcDz1M6pLXiwJ+tMOoHg88c358SAKidssKt4OxAOGIAJ07ZppM+We9Gx1cSWqA4UQCne1ObtyOqOMkaUSCM7XQYUARmu+bwoheDS8G7FMsPnexNN+rfaDo1hMMaJDBGHsFv76abn8w9KWlFp6BQC5SRfSlJ4Dl/+066j0YhrQfCyqCbfggtzS9duGV0Nj5PFCKDcAkNUTxJ/gXSV8NvEELgK9m2ZVZhBvG+9Lq138evw0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 17:32:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 17:32:55 +0000
Message-ID: <d0df4187-4ebb-4a28-aade-8e119a4b216c@intel.com>
Date: Thu, 7 Nov 2024 09:32:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Daniel Machon <daniel.machon@microchip.com>, Vladimir Oltean
	<olteanv@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
 <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
 <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>
 <bda38b6e-73df-4ca5-8606-b4701a4db482@stanley.mountain>
 <5ff708b8-1c6e-4d53-ad64-d370c081121a@intel.com>
 <cdbf7a65-024b-40e0-b096-29537476c82a@stanley.mountain>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <cdbf7a65-024b-40e0-b096-29537476c82a@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: d1186f70-d9be-41f8-6f57-08dcff5236f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFpyRGZpNWllczZYUUMxTFF4NVdrZmJhQ1QyRkJEOG4wTzRPNnM4c2JpOXJP?=
 =?utf-8?B?Vlcyb0dEMzg4ZmpFbUFoNERmanQvZlo5dXRNNEtQRHhKV1Fzc2RjSDBoQ3V1?=
 =?utf-8?B?emxIeUZrSzRqZXVqbm5QYmJOd2F2Z0I5RDQ1aFpYTDRTTUFLY3ZZZ3JaVVlU?=
 =?utf-8?B?Ti9uMC9FbEhtcWVoRHVTR21DMm5zKzRiaVB3S0JDdFh3cEpVQ3dMUlQ3MlVX?=
 =?utf-8?B?d1FwakloUG96Zmsvelh1Rjhya2dFZ2lOb21DVTJqR0ZVa01sdEROYjRqa0kr?=
 =?utf-8?B?VjdFWWdnSDVPSGppR1JHMFVtSjlJU1JwTHVKVjlzU0hqSkJ6ZjNTN1pBZ2JB?=
 =?utf-8?B?V01VcGpjUGpnQXg2N0h2V0p5ZHl6bktwYXE3WkNCZmhZVnBCMFo3SWVHUTRO?=
 =?utf-8?B?Uk1wWW90a2hlNkxqalhBU2tIbnNicGZVT0drNUZuK1pHNHpOSVhHb0YwbTJH?=
 =?utf-8?B?SFJBb1pIRFpvbTlpT1htN29UeTZxaWQ3aXJ2cmR3R3c3RzNpSXJPMit2OCtL?=
 =?utf-8?B?RE9hK1djNDBWZy9oNXhma0dhdS9JRUp3bjMyMFVtUTFWYTBUdlhoSXJmQURs?=
 =?utf-8?B?OTFtbDZQbnducE12MHBIRmh4ZWpMa2U0VDl5TlNidHFTQXdDeXpwOXZuYnYr?=
 =?utf-8?B?bFUyMlJ4b1dKaVdyOGVQR2NSTkZ6a1pvQ00rWXRSK3dHMXArWjRURnVxQ2RG?=
 =?utf-8?B?cHpyM2Jzd05aUlQ4Y20rOTBjaUJlbGVVa2dMNHU3MWtJSzdhcm1FclM1enFx?=
 =?utf-8?B?cW1OMEJTZjQzNXJaTDZVeHVNQ0FGK2JqQnU5Yk9KTGVIT3BwRjZDQ29ZUWF6?=
 =?utf-8?B?a0FYQm1jdzR1b3Y5MWdMUm5SUHl3K1kzUEhaeUJodjRnVTdycEhCQ1NaVVpK?=
 =?utf-8?B?TDdCQm5aWkRxdTkrTnlHYTVFU3JwOEJZSDNHMjhCdG4wWmE1QkdYWDQ1MFlu?=
 =?utf-8?B?NmZZRUJjRzYvTEp3QXlDWERPSTg0NGV1b3FkbEFzMExTL1hCWERIRGJyRDd2?=
 =?utf-8?B?N0svVG5vcWhDTlduZ0lsME9OWkdrbEhRaC9rT2FYeDExb1hTdXMwZ2g3ZGZh?=
 =?utf-8?B?d0x0ZXZWV240bDdxcGF4am1NUFp5M0NmUllwUWI2QW56S0VPS2NDQkdBbE1F?=
 =?utf-8?B?eGpwbVhNK0svKzRwT2JrVy9XeWYveTg1dnBSTFNnSkFJdEgvV21EWGZ6RzZq?=
 =?utf-8?B?SnNOYW1FQzFETjF0TnQvRGhjUXNpTk1sMHIyQWdVaXFPQlJWdmNCc3l2ZlpM?=
 =?utf-8?B?UEtXZ3JOTWhEV0ZCYUwzMVZ6WklNSWdsVDh1TzVzMkFNTXRZMURvMGQ1Nmp6?=
 =?utf-8?B?RFNaNUxiKzV5Rk5FN292WHVqWncrZDZPTmJESHhkcGJWVmErWlVhdDlLRG1X?=
 =?utf-8?B?Wm0zZUNxY0Jra3ZOSjdCUzJmMFY5YmNyQzA0Q0xYQzBrdnU3NG1NOGRNSlor?=
 =?utf-8?B?eWZsWGIxVGRRN0xyVkJqNW83d09ybTZiZzRTRVVlcGRkai9jNWlTdXpFblQr?=
 =?utf-8?B?SHNmUDlGM202ZzVTK29HTmRWVW9HdnowKzJnWEVGSHJYQXZ6RzZoQzJlRVYx?=
 =?utf-8?B?dHZ0S3RCTjZyMmljMDQzb21ORmxOQ1h0RGgxeDQrYjJDSVFCSS9zZ2pkNlBn?=
 =?utf-8?B?bWNzWE9EWllGSitQSmI1OHhyemZjNjFGZ0lLMjZia2t0TUt6OG1UMHU1YUJM?=
 =?utf-8?B?MzR5K21HSjZXY0dKenFMS09kODBaaVNZMHVOL3k0azJKekEyclBWUnpGQlVz?=
 =?utf-8?Q?7YIk+2PGETW6wy9eCtW5zCBUbQjahy3RcJ0b01G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBMaHdja003VFFkRGw1cWlFc3BKSU8rMWJPYy9xTlpmd1dFTStoZ2dUcU00?=
 =?utf-8?B?c2FOMVBWU2s4UG5Rd1lxZXBMZ2FUbmJxb3BoTWtkU00yMGlrL1RDTGVmWWlG?=
 =?utf-8?B?UXBieXZ6NkswMW83ZnBPcHY2VWJ2RmMzL2tvRjd2RldFakZRT09zTUhycWVr?=
 =?utf-8?B?dmF4c3Y2M1pFNmt4bERSNzhGTmpkYkJyUCtvcFRmQmZ4bTlVelpTaHliMk90?=
 =?utf-8?B?cW84MXU0TVBkOStHeU52YTV1K3krUk1pS0NtYXhXS1U0bzhWdUJocFNRbzAx?=
 =?utf-8?B?MEJmM1dYQUFTeXVGeis1RHRoR3BCT1F0MmJaR2pEMVkvS3c2dTBCMHpjNmtt?=
 =?utf-8?B?b0xUVUVkM3doZExWT2QxMmZueTZQeGtId29RblBxQzRWMWVYRFNGK1NSb3Ja?=
 =?utf-8?B?WjVXTk94dHp1cHVvU3g0dFdiTUlCcFVZQmdBVU5iN2pIZDNVZ3RYOEhNalBm?=
 =?utf-8?B?R0YyMm93T2xxRXVqZEpNWDdQUmt6bFhuRkp1MW9aRGtESndHVEd2VHIxNlQ4?=
 =?utf-8?B?QkFhdzUvdHJtL2hCZnNuRkE1SzNIRXd3elJuRXhEYW8zQ1MzQmIraTUwTzhU?=
 =?utf-8?B?aFVCYjFadHN2YWZwMlY3dUdya3IxZWtqbjZ5djBtMU85Y04vN2VGam11SlI0?=
 =?utf-8?B?c1ZRWTREK0Z6UHFDaWdJTlluWStIcml1NHA5MGFiOEl6dlNFbENXL3RyRERR?=
 =?utf-8?B?c2lWd2RaSHlLUzVMZ3hxc0wwUGlsL0EyTEdkK3hFWStDcEVhQTRYVi9JTmZp?=
 =?utf-8?B?TWdrRFc3Vkl2ZnZmZFQyZ0NkN3d2VjhaS3NqRUtaZXlzREhEUkU0Q1lMa0li?=
 =?utf-8?B?b3pld0QwRzM1SFVDTmFPbStnbEk0REh0aXdNODN2bHl5SmdZTldLOUhtVXdP?=
 =?utf-8?B?RjVwZUJBZUdNcGwyaGpmeURCcHV6c3kzKzZtUVNnelpkeGxyMGZmVTBlYWJu?=
 =?utf-8?B?aW1NeEpzemNnWVFJK0pSaFZrb0NoaGFMMllEVFVVNzZ5TU9DdDJXbGFvODZk?=
 =?utf-8?B?OXgwbVgwd0VtRCtaWFRXS3hrdHRqNDUrWHJ5QWF6SHA3Wmtac3V1anpPMCt3?=
 =?utf-8?B?OGhvR3ZwVkxwY1lxb0Z0cXhiQkJwT0E0bE5zQWZ1bmNlaGphMmJGNzJRRVpk?=
 =?utf-8?B?Wm9qTU1TSllrN3YyZmViZVlZaUpGTmZkNDlIY1JUbmFGNTdtZS9Hc2VCVXJU?=
 =?utf-8?B?ZWN1L0VhV0ZpZ0E0eWVtd2p0bHFiRXdnUzQvVzR2OWt0ZUhyQTJQMHFlbHNE?=
 =?utf-8?B?aGdKcjN0Q3FVeVFNKzlEdEhmR3VqK3RMYk5Nd2c3K2VmaWgvclJDVFRtTXd6?=
 =?utf-8?B?eWZBZFA0VmZ3OFlyMkNCYzlWMFZ3YnJjUTZZMlI4bHF1NGdmd0tvS3Ayd3BL?=
 =?utf-8?B?YXkxTDVldm5GeklTaWJWSlFoc0p6cWgvMUVSNmhDMmY5bXU1aSsyZnhZQmkz?=
 =?utf-8?B?TXRGOU1BRUR3Yy9qeSsyY0dxS05udWRZRXhJcEhta09vemJidG54WFV3UnVO?=
 =?utf-8?B?YndHNHJaRi9heW9rNXcxTmNKQjYvL3JiTGlGOFVLbHIxVFlxcU8xbGcvOXRP?=
 =?utf-8?B?bGZ2TzVUNG1Xaks1Si9oc2hmbGlRTmV0WkpEQVF0OW9qOUZ6M1FvTVYvdTll?=
 =?utf-8?B?TGllVHRTWlQ5SDJmekNTK3prSXBuTzA2QW5OQWM3ZTZaN0o3d0RnSzRVakNa?=
 =?utf-8?B?Z0hoVkltLzBwaGo2WWdXbFQrZk4xVGFrNG00aklianVYU2ppaVVOSlZOb2ti?=
 =?utf-8?B?bTNlSGdzV2VwYU85WjBOeExJbHRiaTl0bW5LbHBHRVVLUzhvZlYzOFdZbzBD?=
 =?utf-8?B?dmZzVXZrZ3dBOUZTSm9Wc3IxbGFSWnJER1NhTENzKzRiaXBNT0s2SElLS3VU?=
 =?utf-8?B?cUtLQklBa2IvZ0diS1FZbHh2Tm9uQmZqUG9icGpHc0NnMjJuNnhNL05KclJx?=
 =?utf-8?B?Y2NtbDIrL3p5T3FuZEtIQzZQWFJsQWkrLzM5K2RWN2VJaFI2Nm1ETG9LZ0lX?=
 =?utf-8?B?ZzlwVzZMb3JTcnNuQm0ySUNVcVduRG0wbFlYY1MrVHRKWHVQUnNPQ3JqUzI0?=
 =?utf-8?B?TStHNDh5Y2k0VG5iMUV3WFpYOXBFQzVCZUQwQUd1dU1WTXdWUUppL29PK1l2?=
 =?utf-8?B?Ynp4cC9BRlp0enh3Y0JXZ2RGeElPaTdoUTZNUTFIMmx5V1JGYUtIWFVlNTRX?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1186f70-d9be-41f8-6f57-08dcff5236f2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 17:32:55.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KllzpM2ml4Lzx5ltDSbga6ln1b4+i8e6eaYjJChigBmcAgX5YqlN5mSJ7s5CreDk0L2zYk9APrq/BVt0BhaT3CXS7p5N4bMn8r0hH57C2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
X-OriginatorOrg: intel.com



On 10/31/2024 12:46 AM, Dan Carpenter wrote:
> On Wed, Oct 30, 2024 at 01:34:47PM -0700, Jacob Keller wrote:
>>
>>
>> On 10/30/2024 4:19 AM, Dan Carpenter wrote:
>>> Always just ignore the tool when it if it's not useful.
>>>
>>> CHECK_PACKED_FIELDS_ macros are just build time asserts, right?  I can easily
>>> just hard code Smatch to ignore CHECK_PACKED_FIELDS_* macros.  I'm just going to
>>> go ahead an do that in the ugliest way possible.  If we have a lot of these then
>>> I'll do it properly.
>>>
>>
>> We have 2 for ice, and likely a handful for some of the drivers Vladimir
>> is working on. More may happen in the future, but the number is likely
>> to unlikely to grow quickly.
>>
>> I was thinking of making them empty definitions if __CHECKER__, but
>> ignoring them in smatch would be easier on my end :D
>>
> 
> Adding them to __CHECKER__ works too.
Jakub suggested implementing the checks in modpost, which means the
CHECK_PACKED_FIELDS macros won't be merged.

I saw you did end up updating smatch to handle this, so wanted to let
you know it looks like it won't be necessary now.

Thanks,
Jake

