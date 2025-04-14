Return-Path: <netdev+bounces-182149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A1A88059
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581FC167B29
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ED92BD598;
	Mon, 14 Apr 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcEbkxV/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884327C873;
	Mon, 14 Apr 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744633724; cv=fail; b=UkYVflgoeY3+dbO/4TSQF/7czm7Aw30F7xf1kpCv1hFR6peUitEY59c+sSeHDijJ1G3BsU4gGf0pmRCr5C6MoTdXbnlJ9xYh35V+5mwBOtSdpqQ+DrYtBQzdU9UEJKF1uO+yFQrf8gZrs119VMKlXrmA1RhHjCFpa8ljV8vbEhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744633724; c=relaxed/simple;
	bh=ujZD6v6seWj1eTlyIMSPcIJWfmMBlZ5bgWZQmmWntS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VKTgooORb6Z6cghbxFS7NyK2ikSvpUPFm2mGM1vObM77IjHua3ebJ50R9/MvTEhGEFtqjhCGw6ZQ5Qg4aBDsuRLFuGpAstk0spEa6Yn8X3+V2QmKupQGf8aGZsGYY6YzeKO/po/fn5nXutSMYdDY/vmrKyarm14V1YFlWv+7uMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcEbkxV/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744633723; x=1776169723;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ujZD6v6seWj1eTlyIMSPcIJWfmMBlZ5bgWZQmmWntS8=;
  b=EcEbkxV/p1RE2Z/YwyLzLwZRROUibXoqZTruPNACxdTuOphhdgdGPNCI
   Le2Irz1Nm1Gy/4oIvC6AvOf2HRqWMV9SZgsDx5wr8IKGtrLAL+sgUqkJ9
   RaSeJNKegE2nKzVMxBwZgMRoZMjBNc2YUdEBOCOjvIj5Zz6Y7E6/OEAkw
   9J4h+8fZ5pswLqQqcVe4YRfoqHp5aeY5LfNLxBPB3SFWY6kWDvWRRp4kj
   jP86CiA/lZv/T724qaj1G2ibPTBqBQsDadGGaZ6N5lycejBsZAI+Fdq/z
   T3+HvQWumukWaqblJmZq19vtv7zBTWat4JCp0Cj5Kgk++Xf+xTCUFfM4+
   g==;
X-CSE-ConnectionGUID: H3+eLdnPSPu+FEPUjzNiGg==
X-CSE-MsgGUID: 7fJuMbY4SxeCU5Cv259G9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="45989039"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="45989039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 05:28:41 -0700
X-CSE-ConnectionGUID: yWNy9gahS6KENq1jU4VCBA==
X-CSE-MsgGUID: M44uI7cZSXOLNihmb6OrLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130345514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 05:28:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 05:28:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 05:28:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 05:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1QAnKYBQ6dijnpjbEhRAajcGq53xwmTtqiYCtUgQLM5dRFEj/Vs1mw+ET9CMR58/4fkvMdtVA5ECEUaiyiMr/yekjwuMSc+DfBrCGnf8q2DX5o5cKbE9y1I1lD7qI3h/S56KiuWkkRb8Ua1YyZy45jd7wU15mZnCUUICfvz7ICwjlTQ+eCvZbb7lDo2okG75iVzOEQVguEehsI1Y5sGntau7+ZoJln6Q6UgiDGYicO4D/8OcWcf324rUK2T6qBCHJKx4IUktLKA/LWRVzCTMBakETN7KLDmSCjqWSK+btA5vN6JLhkJ+kJKEH2oHDfPrXIYDWabI13iBjRygNj6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvk6kihtnMbzQul0sE0+AFCFLGlMXxbyYjL0osoVgsE=;
 b=jA76bsh6YcwI91IkuxuTDOCcNsA3FiVPV47NQeX22kt12LwReC+tZQ1ucAYG7BD2LJdC2oTNoXV9oBVC7anPXJFbUY+8yjG0GQHwNgrAVHWekssb6q2rfUUTYH26QuLFZUyDopUEnsMyN0miWOMtpD4BLQoM4MF2KPzdAcJYMo2LkUKn5yDHjEmgn8rS1JlXFLLvV6Ur7VsTjgkPzQRTlXR/HKkkPsiPu4655LbrUZnrQWhptxKqPgq4A1Ul7BkxY+s2w/Drv54sRJbE8yqm/tJZJ3zF58N3ipcE7zS8SglFufIAoTgOgnToTmEE/4DrFJWXH+JlrylVZ2S7OaDMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS4PPF93A1BBECD.namprd11.prod.outlook.com (2603:10b6:f:fc02::3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 12:28:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 12:28:37 +0000
Message-ID: <69a0bf15-5f52-4974-bbaf-d4ba04e1f983@intel.com>
Date: Mon, 14 Apr 2025 14:28:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: Edward Cree <ecree.xilinx@gmail.com>, "Nelson, Shannon"
	<shannon.nelson@amd.com>, Jakub Kicinski <kuba@kernel.org>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet,
 Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, "R, Bharath"
	<bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
 <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
 <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
 <20250409073942.26be7914@kernel.org>
 <5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
 <20a047ba-6b99-22d9-93e0-de7b4ed60b34@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20a047ba-6b99-22d9-93e0-de7b4ed60b34@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0020.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS4PPF93A1BBECD:EE_
X-MS-Office365-Filtering-Correlation-Id: 865edee9-709b-4399-013b-08dd7b4fe18f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1FNY2ZvbXBobzB3SEFIa3dhMEMvMkpISjdJT2cya2dNemNKZ3BCMXlNRlhM?=
 =?utf-8?B?cERqd1R6YmozTDB1UndGckd2Ulg3aWkzSUVTR3pzUm02QUxEQmRGM2VOaGFI?=
 =?utf-8?B?dVlQTHozVW4vM1VuVm9jckJSY201d0FIR25RVmhQZUJiN1pkQndOVEpadjg5?=
 =?utf-8?B?Y01CYk9RTXJBQVZpUDNoWDY1Y3h0TmRPRTlrZDhHRVZXQmtQVHBYRFhCV0Mw?=
 =?utf-8?B?eTJXY1MxTmJob2ZqVDg0aHJxN3NrOTA2Ymo5K3ZMdXZ1Zzh4UFEyOHg0bkk1?=
 =?utf-8?B?RllMRlY1R3VFUDJheFdCYXRMWVZXUlpxWWd6MnVBZ2FXbGo3ZGs1cUJwYk5v?=
 =?utf-8?B?WTYzL1ptNytGQk5renZLVzZsNjhoSXdKNTBlalM1NTYyY1Z1SWYrQUtxTm9S?=
 =?utf-8?B?eUIvMkxxUUtRN3BnZ2l0RUkvNU5ZS3ZDN0pWZmIycVZObzlvT3BIVitSeUVZ?=
 =?utf-8?B?Y0xqc3Jaa0tpQXpGMXJZQ3VzeHhEUnhSblY1dmZqZXhyc205bTNXeDIwUkFm?=
 =?utf-8?B?aXNUTzYzYXAyNyt6ZkFzYkErSzRkT1huYnd1cnNDZi9RMFRheUFRSVlGVElz?=
 =?utf-8?B?dlYvNFdUaWVDS0Rtamk2cGdKTitKZHp1MlFQY0x2ZkJJS1ZacEFlcXA3WUwr?=
 =?utf-8?B?UlpFVmI3T0txVENocEsrQi9aM1l5WFgrVkZGM1J0ZnliQmZLT3BBTWpvenYw?=
 =?utf-8?B?UUxmZ2oxNUdYWHphcVNkUkIyeXNFTXhOcGVDdm5sTFpvTGtIZEYxTyt1anN1?=
 =?utf-8?B?SkY4TU4vTkhYWElNVFJwcDU0bVBDb3FiNUJTdjBvMDg2eUJMam9STFEwbU43?=
 =?utf-8?B?bUIxVEpncmxqY3NxQ2xxU3NUdzJNRzBVZjM3OXVqMGZ1eGZ0NGVINUxCTGhZ?=
 =?utf-8?B?cWdLRUMrZzBwSHEvZUdTVkp0TFVhbUo2U1pkR3VYdEJVcUoyRzY2VnpmcWhX?=
 =?utf-8?B?Qll3ZUFNRDNHWHViS1JwRkFaVzY3RFBkeGZ5WllzUHppRHhDQXhNNzZYMytT?=
 =?utf-8?B?UXRwTkxRR2pnTjRMTzlqSmdGdklMNU91U1FrRHVHZlM4eTdyQS9xOWl2YTJq?=
 =?utf-8?B?bGIzanBVejBXT0puNVF1RG9pWlc5cmowUWljL3FGR1dpTkxUMDBQbWswcDRV?=
 =?utf-8?B?Sk1FNFRkNHFIOXllNklrMk1YYmNObVU4QytFRk5ZRTJ2WEoweGNSbnBFaXNL?=
 =?utf-8?B?Uk5FUmdQOFgwdjV6VkNmSmZUV252M2x6Z1MyUjI5d2hTTzRhRnpjeGZKNDFI?=
 =?utf-8?B?WXhuTEZPZmlDZU5rdnQzZnNlMngvYVA1STFrUWVESzN3cTRMM0VYa2VyTVZS?=
 =?utf-8?B?TDc5bHJkcmFxRlVBWjF4R2pwYzNPZFBQdXlvak5EOXlha01zYm5ES1Z4bEFp?=
 =?utf-8?B?N3ZvNWVHR2VpU25SYWF4aVl6c0lWNzZvRk1ueVFldXhGblhQU3ZKcjExNlpo?=
 =?utf-8?B?UXdNa3dKK052L0hJT3ZQL01xRG9GRWJNT3UvVHA5N202enhaOWUwWGI5aHpx?=
 =?utf-8?B?YUk0THdIT0gzeDhFVTE3cDE0Zlo5bU04WFU0UXZaeEdCcHcyS3VseTloYkRm?=
 =?utf-8?B?UFVGY1MxTk5CSFNLVW5iajZaRDZwQU9VSUc2NU9yZTIrbU53aHdXa2U4Uk92?=
 =?utf-8?B?SDZ1V0Y3bEQ2ck9mQUhFelZwNjIrdHh0VTQyY1ZWRGYzd1had2d0NXlMQTcy?=
 =?utf-8?B?K29SdG9VYSt0STZ3blRyVEQ5dHZ6R1VOem9XL1pUczROcUpqVDU5a3lrV3VJ?=
 =?utf-8?B?KzRrMmhIdDNhYzZjSDEramNRMW9aTnJTUjdWQ1B3TE1FSmtQTC9OY2xBemhE?=
 =?utf-8?B?WDZVQ2dtclpwb2d1d091M3BRWjRKdEZSVG1WbTZHM2VPc2E3RUdWV09jZE5i?=
 =?utf-8?B?a3lLK2oyMXBZRHNEeFdCRjJUSE9TOGpwMEJRY1JDSGllUG1OZ056azQwWWdW?=
 =?utf-8?Q?aIOs/+LO/zE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xuVEhxZFlzM2JTTVpkZEd3akRYaWlGb3dwTlhmYlU5VTBsOGxIOWErSm5G?=
 =?utf-8?B?WnJ3bkNMdzhGWC9YdWdsNjF1cm5LYmRBTm5Sa1JTNEtrUy9QNlBSWnNQb1JJ?=
 =?utf-8?B?cnNHSDMxcWtmY3NYSWFZT2lvbC9FQURTNlRmSjN2S29halZqYWlWOEpCYUlv?=
 =?utf-8?B?L3VsWUtuYjBmZDJnYXZoQk5SSUxLRkFsY016MU9ydUVwQjcwdFEzK1hhSXVN?=
 =?utf-8?B?eVcyZjVuY0lMRkxIVXd5c3doUHdZVzVRdk1ENGlLeVp4L3h4T1BZejVNcURt?=
 =?utf-8?B?S1RkZlpUVTV2T2tpQkQ0STd3NHFiK052Q0FFQUR5TG8ydnNqNzM4TTczWmts?=
 =?utf-8?B?Ui91RnlKVzFVdHppMnBoa1Vsd1lBNnpDTXdoQU9weXlWK09PaWpKZnJldVNq?=
 =?utf-8?B?TUJPa0tDb0I0UlpBMzFtQUN5Tmg4Y2lrRUFSYnQyQmFyQVR0cU5LYysxUytk?=
 =?utf-8?B?WnhRK3RpU1J5YW9SdDRZc3pqdDQzYjJzaWg1eitxV2VWYU5jT2IwK0l0dVpZ?=
 =?utf-8?B?aVVmMk90WGtVV0lkdnRBVkluc0kyQkc5U3JPQ1VYL055S3JhcnhCVGtqSTNl?=
 =?utf-8?B?MWV3aDI2N3ZrcEFua0dFS216MDlZdDFkWEx0dktkME51SldPUzlkMk9yMDdN?=
 =?utf-8?B?TWtSczhqbjZ1ZHU5WVpYZU5OalI2cThlOE1nbUJhSUVYVHdza3krYU9GYnNy?=
 =?utf-8?B?cVBVRkJRM28yWWU0OE83bTFwZkcyZXRvWnpXN1dZUVhZQUVwUWZNbWNMMVZ0?=
 =?utf-8?B?Sk5pTkhOVWtydk5wUGNJdmZLVzFBWTFwTW1lbFJMdWFjTVJpSURpelpyMmYv?=
 =?utf-8?B?ZGRJVnVjMHZaOEJNdXJnZlRJV2FZV3drY3l6ZXJzNTNSNWxGOExLWVB6VXZw?=
 =?utf-8?B?TGhHL0JuTldpV1JOeDJBbVVSZk1qNnFMdEt3OVRNMkxBZ0FpMGZDeUl1UzEr?=
 =?utf-8?B?Uk1zUi83M3BtekhwVTdpWWtMbzFHS2JlcFQzZjUvOVV5MEN2Ukt1S3ZMV2tJ?=
 =?utf-8?B?ZmVzbHRDZGhoUVNJRXhkY0FJREdVeTRBcXhRQnc2a1lWcmkraDNycEYycGxX?=
 =?utf-8?B?UXJiVjBHbjFoQjI2a1hMa2RvWENwTENyNm5qMExZTUdCS1N5QUhUK05WSWo2?=
 =?utf-8?B?djZxQzhla0IwTE5RWDJTTUVQY2dralhQZkR5S2R2STU0K1Y4bTk1ZXp6TURv?=
 =?utf-8?B?R0dSQ3pZM3hxRWRVbTVaZ0ZQaWVIakw5STIyUzBVMVNoNitpaHFIS092OUlW?=
 =?utf-8?B?cytXOUVvTW1CMDYzbldlVzFXZDArbjdlYWRYZk9Dc0NKeFdDanFhcytRME1Z?=
 =?utf-8?B?M2ppVEhrQ0Z3bTBlTXZRK25YUFBxcmp3SmRsR21VSnBoZXJtNFczdUpNMTFK?=
 =?utf-8?B?U1ExTHUyeW1JQWF6Z0V4LzhYWmszMm03c0VHSnZsQlNRZFI3ZFhJVUVzREVQ?=
 =?utf-8?B?RHkxMWhJbDJRaDk0YktvVmRMbUhYOUNFSXlQZk5SdzJvU1dUMXJIalhsQzZ3?=
 =?utf-8?B?WnN4UzVONU9MRm9nTWF5NFViRUVaenljTC9FamZhSGJCY0t5VXRVTUo3SElQ?=
 =?utf-8?B?a3A0bE5mK0lZd29MRnd0a2NpcTJkZkZkazMrZTJrQWxoTmNBOTQzbTlnVkMy?=
 =?utf-8?B?K1g3Ynl6V1FDOCsxbGptUnpnNG9FWm4wSFE1YmozZzlyQmF6VnB3TkF0b2Jh?=
 =?utf-8?B?QlZqamJ0a0c4NUh2b3pRazg0ZkhxNndqaGZFM3NZSnZpcGlNaDNvVU4rcjJO?=
 =?utf-8?B?aTRaLzZ2b0FtOU5waFIzbWxRYkYraU0rU1M5MUxqTmRIN01LUUJlb3h3cDJz?=
 =?utf-8?B?dEZSVXNUUlRFem1YMTY4Y1pPcDVvUTRJbWtKZGxRWVlkRDVYby9VQTZZcmQ2?=
 =?utf-8?B?WWljVUUxK1J5eUJPajlvWmUxditZdndZYjd3Y3JkZE9aS29SU3BQU21adVNv?=
 =?utf-8?B?enlJZUxmSGlFM0dBVVFPWXkwc21ZUE5Sbm1PMmVxRTBTVy9VSDM5TFVUemNN?=
 =?utf-8?B?Y1ZLbnBqdjF4MDhWMmVrL1A0ciswQUF6NVVrdUFVaHlXY0F4ZWhsWU11WnU3?=
 =?utf-8?B?MHU0OGsxNWsvZXdwL2lkN2xDcDJ1Qnk3L0plek42L1ZHMkQwVEh2dXh3WUFq?=
 =?utf-8?B?S3NtZitnODlKeHBWTGlaalRaTVI5ajgvUjdqM2gzRWZhc0V2Qm9idTRMVGNa?=
 =?utf-8?Q?dSlpLL5R8a8j/7/Y4QMsajs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 865edee9-709b-4399-013b-08dd7b4fe18f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:28:37.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQJ7Kr7S+EpvKQ5nsrj+ti1whQMlkeS8fEdvDED4ypkV4v20wVLLWqi89gE9kfoLlIrQCdB+DRhPBNqrAqxJMFEOJ1JMdoF3RAoPZMwUIyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF93A1BBECD
X-OriginatorOrg: intel.com

On 4/11/25 13:11, Edward Cree wrote:
> On 09/04/2025 18:25, Nelson, Shannon wrote:
>> On 4/9/2025 7:39 AM, Jakub Kicinski wrote:
>>>
>>> On Wed, 9 Apr 2025 14:14:23 +0000 Jagielski, Jedrzej wrote:
>>>> No insisting on that but should empty entry be really presented to the user?
>>>> Especially unintentionally? Actually it's exposing some driver's shortcomings.
>>>> That means the output was not properly validated so imho there's no point in
>>>> printing it.
>>>
>>> +1, FWIW, I don't see the point of outputting keys without values.
>>
>> Because I like to see hints that something might be wrong, rather than hiding them.
> 
> +1 to this.  Failures should be noisy.  Time you care most about these
>   data is when something *is* wrong and you're trying to debug it.

That's true. But empty string in some info/debug utility is not noisy
at all. At best it will be part of the report attached (and with that
developers will be equally equipped to tell that "there is no foobar"
entry as "the foobar is empty").

If anyone wants to be noisy here, there is WARN_ON() or we could even
pass NULL ;)

> AFAICT the argument on the other side is "it makes the driver look bad",
>   which has (expletive)-all to do with engineering.
> Value often comes from firmware, anyway, in which case driver's (& core's)
>   job is to be a dumb pipe, not go around 'validating' things.

that way we will stick with the ugly, repetitive, overly bloated code,
repetitive and hard to fix in all places, (and repetitive) drivers

yeah, good that we bikeshed on something so simple :)
If anyone is "strongly opposed", please say so once more, and we will
drop this patch. Otherwise we are going to keep it.

