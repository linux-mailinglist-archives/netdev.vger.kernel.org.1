Return-Path: <netdev+bounces-90826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9728B057B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A9FB27D23
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1756158D9B;
	Wed, 24 Apr 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIwlDAYT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC8158A31
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949582; cv=fail; b=PyqhBFIh5ONTTU4adjxVk7406dCtop3cfqauJMbzr/dhIxmsvBlQMj0U/4asDfYWzGTPj8VVvQ631TzYvqo5I9HYdqW1rCV6i4lf2QYP6PyouUWLJiQZjbzBGjUZ8MOr+9zAGo+yene/hcVB+fDC+MA8UB5SRW+Wsq2vsySSgHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949582; c=relaxed/simple;
	bh=P221B9ELpzyjFKggXtMcELdb5PYElyPEeTXAMr05bu0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O9+5IyWabbmsqJpfiFF4tFOLTdtS/1n7eeaghZ87h8G30Q/9OgmaDPAzHVhCRs6BYNtxysmDn6FdRj9D+5wQ6BBdfVkK8tBezD9DttdraTuPTjHlX+hGtTUEtQnsYNL41Um2e4CsUuuPxwmr2U79GcWkXG436FvP+h2DBsPW3cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIwlDAYT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713949578; x=1745485578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P221B9ELpzyjFKggXtMcELdb5PYElyPEeTXAMr05bu0=;
  b=WIwlDAYTGH7EQMEF3YXRTZcCtHY8NjBKWaIZ4sY5rwCarHI/RxjjwNpz
   L7Z06Tkh5N/y+liSuxgUcunLI9z41IcxtXZ7Le4WYgZJzM26+i9csQyCu
   838BfkUM89Bb4PnjpYnS/2cTWsF7H/pDk+l06j/6KJnlqpjHlv9p5HE7G
   A8E238lS3PnsfXWXwvz2mcmVBMs0TTgAqmO++SpeVjHF4vkpiSeMWv0mX
   gCQppKACM16z7/FZkJZAvN7LbPDfPY+rJaMpEqowQ26A+YlZQ4wePrIQj
   DbMQSYH+4selYfn2GltHIRJE4/urfgypMtkcfMULtingzeSdTiUjQpJot
   A==;
X-CSE-ConnectionGUID: /lrlXjR+TpS0KUxaugspww==
X-CSE-MsgGUID: Q8yk56K9SVO8UGd/NQI7yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9439893"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9439893"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:06:14 -0700
X-CSE-ConnectionGUID: Q6GwdYqJTWiBaYLvFaxrOg==
X-CSE-MsgGUID: U1xwLo9ETsuSWcIfk6VT4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25167631"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:06:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:06:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:06:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:06:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN2yCeTcujPCTsvAQ6sMQAXkEzjl79S7b7lstgXy1jHvz580nSw2qJZdBYsrTUdFR6olalnPZ+iT+P4g3cAUzXB4ZL959Vbxo7faRx/m4S4toLnEl6z7hcf+6j/ENT4yeIzdYFm8OgIZ8BbZJGf0v7Y+0dc7PokeBUsMv1pbd5FnVdjXUdbxADZen8o6nj1cr6KQ/LXQgjTp2GeDZZ59TCyQZMGy58JDI/LUfTx/eGikLr2aLJobzw2VRkW0/gerbTzrOBzjzb0G4TqkdsLwGsNsOkQSm6pyw2VF2tcwxGagIkUiBB88B5RtOEnbSEyOnuedN/LCWiRpPXoyZLRp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St7MzLS0/lznWhFIM5tMRP2MsBsloptr1AwTbTOu+Gw=;
 b=P/pz2ZwYK3hrByC5241eKvGHOaPI5mWyonZg29SJ0/tt+Gt2/RbVNF5a+lCg5ut4/dp05/Gj2oQsaIpsLhvpPbo16M87Q8jz64AWRCpyvk20JsQnJJ9uj5210HzCfsKHLLTSqZZYyASjMGEwkKN0hI0KmSrEWVPlxXhu+0eK9gFcl4Y5JVSaFdk8LU4GYENKOuVdUaX30k0c5Oq1px01x/c0L/N0ywrZoBQrlBrQxfoxvnfSHLOhX/V0OaR7HCmcntL1KBveTLMRHIddknqMWixoiEs1QcaJtZOUYnGoJC4B9cQDS97A5LIXongMfLzGi7pRG6qmUplCAXefcgdIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 09:06:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 09:06:04 +0000
Message-ID: <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
Date: Wed, 24 Apr 2024 11:05:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-2-anthony.l.nguyen@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240422203913.225151-2-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0360.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: c2356c83-c2a9-4eae-6021-08dc643dc4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2gweDNVSkUrM1ZpaHJEd1NpUjB2TUYxeFBNYVRMUU5CQmRBSFUycWxWOXRP?=
 =?utf-8?B?L1dDcHp0eUJWUWFWTjJtUkplMk9mVERWZjl3aGp2SEwrSnZKUzRjM2l1dGdN?=
 =?utf-8?B?ak1PelhzK0w4Mm44dUFEM1Fkc1owR3JMTCtpWTkxMWFMZE5hc25aRnZVR0NE?=
 =?utf-8?B?aGkrYzd4Z3VVZVNFY3ZtQk5rbnh0QkR3UW5PcGpJeU9pRzFtV0NUSE5JbHcv?=
 =?utf-8?B?bGwydFpGV3IyWjJURDhDSWlhRC9TRzN1L292YTFpeHd3NVd3amFWVTFqdVcv?=
 =?utf-8?B?RVl6MTRZQWxGVnNSVSs5d0VScWt1bHg1TTYrOHkyR0trRTNkbmpGQ3RLcnBo?=
 =?utf-8?B?RXpLQjdMSWN3NmprSGVueXF2ZUZzMUNsZ0NKNEJzUzBIMnBWL0NLOGV4Nk4x?=
 =?utf-8?B?UWNQVENIVm5ISXBWM1R3TVRpSERiT2owKzhRVlNvNElKYkRZQk1GeTY2ME5o?=
 =?utf-8?B?VkZtTVlLaXBEdXdXRExwUVJ2T1U2MU51Q0lZZ1N4NXcvb2R2ZXV4L0lJU2Q3?=
 =?utf-8?B?TGNCQ2VTQmdrSlBpRUlub0xsV1RWZTJDb3ZjR0pkMXo4cTJYUVRFREVNZy8x?=
 =?utf-8?B?TUhuS0prVy9saHZVVk9waEQ0ckxxK2xsREYxOUUvZU5jblU2MjEzeStOTEpn?=
 =?utf-8?B?YnN0WFJ5NGdEdExaTXZxbWszeUtsUkRweURoZ1ZLZGpzS25BaVB5UEllemgx?=
 =?utf-8?B?YVFOR3VhMms3WG1aUkF6Yi9yNGtPZVA0bUlBQnBYaEQwcDBtb1UreVI3Y0hx?=
 =?utf-8?B?eXl1SkxqbW4yMG9rVzR4Rm0wRGF6eXR6eSswY0VlU0N5M3ZwQjJkZlRub3RB?=
 =?utf-8?B?U0VvdVJsditkTTBpRm5IUHpLQ1NzS3BwbjdkMzFZY3BtY0hrWXpRdW1RYmI3?=
 =?utf-8?B?N1UwUXYveE5wSHRhdUVLaStCcDJsMlNxSlFJYkdCTnJ2VEF5OEp2SDIydXFM?=
 =?utf-8?B?OXNObGovdFlxcG0vckp2dFkxa0RoZk5zZitYZUF0Zm40UnVXZkhzcldxRjNk?=
 =?utf-8?B?L2FBTmdSUklrV29HajJ3eDM2Um01Rlc1a004RWpUVlllTlRhQ1BsMStFUzhR?=
 =?utf-8?B?UGJCZm9rWCtOOUJickVXSzVqRUVFK3hjVVA5dUZRcDh0MHc1NHRQLzBuM214?=
 =?utf-8?B?NE9JM2xLOHVGbkRqOUVMUDdTNUJtUjkxUXZqREFUWnJSK0JSVWlNcUl0dmI4?=
 =?utf-8?B?MEpyeTB3N1VINURSK0ZIdzh5VVJHd1ZoTHBCRTlPazd1dDNIMnR5V201SWNO?=
 =?utf-8?B?QjVkWFB5bWNWcC9yYXMweUR1T3JKSzZsbDlMajVjMnhpZGZ5UWZ4RTZERmIr?=
 =?utf-8?B?MndvODZhV250QldiVWYzb0RmdUJJQjJUZWgvVVh1UG45amdsbU1OSWEwdS9s?=
 =?utf-8?B?ek5QWEQ0RUxlU3o4TkZWcGFFZ2dKUDRnR0wyOU1pVmR3Z2ljd1NwNExDeVZL?=
 =?utf-8?B?aUhHeFpldmdNY2d1MTJSNG10U2UvOWdDYkhKTnVCckdYaklrcndkbkp6Rk14?=
 =?utf-8?B?VE03QlZseUhnLzcvWE5waE1KZ0tRNTZoR3pxengxY2E5TnlZVlhWeVFSR1FV?=
 =?utf-8?B?ZTF4UkxHZE5CRUR4T01Cb2lYMW5TNXFVY25tc3d4WW1kWG9RWjBqNzR5TGpE?=
 =?utf-8?B?a3hZd2IwQWQzUG9vN3RMcUxFSXRGTCsxM2xuNkxlU2hjMVFQSE1LTWlnTGJ6?=
 =?utf-8?B?Rlk1OXdzaFgrdTUxT2ZYVy9yWW82VEp5NFNyNDhyWm5qdk1HdG03VnVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVuZ2xJL29lVUw2ZHBwZUM5V3FxWjR1WkdaM2kzaUltSHpPMnZiTDNMdVN2?=
 =?utf-8?B?QWx0MnlCNGVOaExvWWc1dEVlZE84Nm0wUldQVUJPRkt5bms5NHpsL2dGclha?=
 =?utf-8?B?Mk1MSmQ4RitFQmxZby9Cbmx5QnV1NHVxbnQ5YVZVY0c3UlNQVWkzVktOQWFh?=
 =?utf-8?B?N1k4dmZaMlZUeENXUk9iMFVWL3JUQXVLRGJmZFhCem83ajg2cGFjL3VGdWgv?=
 =?utf-8?B?akNkVTJxay8zc0xxWUdiNEdJcUIvNENoUzB4a2YwYXFEU3E2a0dONUlrTkxm?=
 =?utf-8?B?YzJRSHVPZ3NFSVh3VnNFMWtQY0hXc203SkxvUDN0S0pYWC9rMTJ3Ny9pQU00?=
 =?utf-8?B?YVRPcGhyZTF3TlE0aFI0VEMrb1dXcldUbkJCVWlnMklnNVJwclZtcjRSa05C?=
 =?utf-8?B?b1o3R3phMlJGUWJ0OHJ2bU5wYUI2eCtZQ3Z0NTFSVlpCVUwrSzdmT2pkem5M?=
 =?utf-8?B?amtuSyt6eWU1TW02amphbzVzQjVDN1BxK3JwVkZYWTU1c0xjd2MzQ0ZZS0Vm?=
 =?utf-8?B?ck9oR2I5MVpmRkp2eFBRcWxRMUQvVjBmS1RwMWZhczlVQ2pocmJpU1VyUnZm?=
 =?utf-8?B?ajhXd2NyVFc2cW1uV3FwR1BZbFN2anlKb1cyZTlTQWNDcXdEQURuWDJMNXBv?=
 =?utf-8?B?dEtzM2RzbXlzd1JyQ3NZb1pJWk43aTFHc1Z6U2NVLzRJN3pKRy9YK28ycFFm?=
 =?utf-8?B?V0NDTUpMVU5adTJTcDh0VnBLQzZrTHIwVllwZUFWTFVUK05YNlBOeVlFY1Zi?=
 =?utf-8?B?T2E3K0srb0lOL0pVV3R2SGdGYUc4M1BNdmtlU09leWVYZTkrbERhK1ZMbU9U?=
 =?utf-8?B?K2VzaTVpbWw3QVlSYlBZcGU4T0hBM3ZhRkRVd3N2Sm1XRSsvUkxxbGN3UTdL?=
 =?utf-8?B?ZFh1VjBDWlVybkVrQ1VJNTdTYXlqdkIwdG5PWFlDTzNvVkwzdUFsRlp1OEtH?=
 =?utf-8?B?REphYksrMUhHRkh0ejZsc2JSVXozc1RsUGFxeDJ2N05JRzlneDBvMml2clc4?=
 =?utf-8?B?WVVkZmFVTmVYOE1hc2RtL2RiSlZGMHUwY3JiVlJzRkpGMG5sV1VKaHRLSW9i?=
 =?utf-8?B?citYVTRxelE5aXVmaHpkbjNPZHZrZ2ZpOS9rSFFIenBRamRSSEE0WUR6dVR3?=
 =?utf-8?B?RkkxWHFsbmkxZnF0WUgwQURtUXh4OHdUQlJlbTF0ZnptcmdWNjA0VmxlZU52?=
 =?utf-8?B?WS9OekJrMEREMXV6QjhFNWpscHE3bGxwMUduZkljSlpFdkpZOEkxSEpFNUx3?=
 =?utf-8?B?QTY3L2oyWWNKUDR4em5BRGovb2VUbmZWandTL3lOU1hGVm52VlVOSU5GbEk0?=
 =?utf-8?B?K0k5bWt2Z053bzZhaEI1ZG5NaG9KUUR0Q0JFQ3VUNitmbHZsVmZ5NkJjd0Na?=
 =?utf-8?B?d2lzTWIzdlpaNVh4UVV6cW5hdjdMM1AydFpGODNOMk1xZE1iRGhkNGdoNXlz?=
 =?utf-8?B?a3Y1b1lZOXMyMVVYbm5xRW9WTVlRandUNWdBaWlMZ2hsb2lvdXVnVWZjcERL?=
 =?utf-8?B?S1phenYreGlrY3AzU1FDOFk1Rml1WDNEdUVvV1NQV0hjYld3QVdJNVhPS3ln?=
 =?utf-8?B?RUVqWGdnMkVWQkFsL1VDRGFNc21jTVVtVlVCTDJOZ2U5Nk03bndTdWpQamtC?=
 =?utf-8?B?bW55ZlFTQlZIdFE2NDlIRHZadDBaOWVVTEh0NWErSlpKUm0yUHlnblhqTUxP?=
 =?utf-8?B?alBxUW5yK3FlbnBLYW1WcERNbFNHNis1WDVCN1JTL3l5emVTcFduY0QzZFdH?=
 =?utf-8?B?L2QxMWlyYndyenJzOGN0UEpsaFZMRnA0YkVxWG1PbFJKR1I0LzhWVTlnMnRV?=
 =?utf-8?B?SWpjdWRBclJoZDl5bzlQSTFMRUw1T3JRdTRPcnl4cC8rNzFxYkpCdk1KSGVw?=
 =?utf-8?B?a2tObnNXZitQZFRHcm1XZVRBc0Nzc3ZCL3lzWUh2Q2lDR0kyTmZDS3phRXFK?=
 =?utf-8?B?eHF4YWo3S2l1c2lRQ2Zod1dvZ1RtSllQaGI1eGFmSGdML0NxVHQyWVZDSUI4?=
 =?utf-8?B?ZDVkNUpIdk4zclRPWWdKK2YzcXgzbm9CV3R6VExzTW1YME5OYWUvUlVNcmpu?=
 =?utf-8?B?WEVYdVBGVWJCWk5WSXNSZ3l5b1dqS3FUdHVZM1FETGJGMi90ZzhHWnB4K2tI?=
 =?utf-8?B?UWg1WDBwMkZlNnNuMW01d2NrM2REMzQ2SzhaUHMvVmc1MjRyUEhYalhRbmNj?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2356c83-c2a9-4eae-6021-08dc643dc4ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:06:04.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIftS2US/2IS5cQ9RNpkLAdRcAn2ab2FJGhJw8RPdOqEYha24EOWu8+dg6aLMDcOs1pxoN7JMZ44tDq7hNSVbmPFYPZb9JppLQkkQf3asTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8380
X-OriginatorOrg: intel.com

From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 22 Apr 2024 13:39:06 -0700

> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Extend devlink_param *set function pointer to take extack as a param.
> Sometimes it is needed to pass information to the end user from set
> function. It is more proper to use for that netlink instead of passing
> message to dmesg.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

[...]

> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index d31769a116ce..35eb0f884386 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -483,7 +483,8 @@ struct devlink_param {
>  	int (*get)(struct devlink *devlink, u32 id,
>  		   struct devlink_param_gset_ctx *ctx);
>  	int (*set)(struct devlink *devlink, u32 id,
> -		   struct devlink_param_gset_ctx *ctx);
> +		   struct devlink_param_gset_ctx *ctx,
> +		   struct netlink_ext_ack *extack);

Sorry for the late comment. Can't we embed extack to
devlink_param_gset_ctx instead? It would take much less lines.

>  	int (*validate)(struct devlink *devlink, u32 id,
>  			union devlink_param_value val,
>  			struct netlink_ext_ack *extack);
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 7edfd8de8882..a6ef7e4c503f 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -1258,7 +1258,8 @@ struct dsa_switch_ops {
>  int dsa_devlink_param_get(struct devlink *dl, u32 id,
>  			  struct devlink_param_gset_ctx *ctx);
>  int dsa_devlink_param_set(struct devlink *dl, u32 id,
> -			  struct devlink_param_gset_ctx *ctx);
> +			  struct devlink_param_gset_ctx *ctx,
> +			  struct netlink_ext_ack *extack);
>  int dsa_devlink_params_register(struct dsa_switch *ds,
>  				const struct devlink_param *params,
>  				size_t params_count);
> diff --git a/net/devlink/param.c b/net/devlink/param.c
> index 22bc3b500518..dcf0d1ccebba 100644
> --- a/net/devlink/param.c
> +++ b/net/devlink/param.c
> @@ -158,11 +158,12 @@ static int devlink_param_get(struct devlink *devlink,
>  
>  static int devlink_param_set(struct devlink *devlink,
>  			     const struct devlink_param *param,
> -			     struct devlink_param_gset_ctx *ctx)
> +			     struct devlink_param_gset_ctx *ctx,
> +			     struct netlink_ext_ack *extack)
>  {
>  	if (!param->set)
>  		return -EOPNOTSUPP;
> -	return param->set(devlink, param->id, ctx);
> +	return param->set(devlink, param->id, ctx, extack);
>  }
>  
>  static int
> @@ -571,7 +572,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
>  			return -EOPNOTSUPP;
>  		ctx.val = value;
>  		ctx.cmode = cmode;
> -		err = devlink_param_set(devlink, param, &ctx);
> +		err = devlink_param_set(devlink, param, &ctx, info->extack);
>  		if (err)
>  			return err;
>  	}
> diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
> index 431bf52290a1..0aac887d0098 100644
> --- a/net/dsa/devlink.c
> +++ b/net/dsa/devlink.c
> @@ -194,7 +194,8 @@ int dsa_devlink_param_get(struct devlink *dl, u32 id,
>  EXPORT_SYMBOL_GPL(dsa_devlink_param_get);
>  
>  int dsa_devlink_param_set(struct devlink *dl, u32 id,
> -			  struct devlink_param_gset_ctx *ctx)
> +			  struct devlink_param_gset_ctx *ctx,
> +			  struct netlink_ext_ack *extack)
>  {
>  	struct dsa_switch *ds = dsa_devlink_to_ds(dl);

Thanks,
Olek

