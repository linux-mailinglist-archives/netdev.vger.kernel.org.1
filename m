Return-Path: <netdev+bounces-99478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C148D500A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5EB240F4
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45A28DD0;
	Thu, 30 May 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyNDYhR5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6241D554
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087545; cv=fail; b=chtz8mjdcuiVFOt7hbCLIZQFpy5F2GWf/7agi69huhr2vDHBSEDMvKtq2RbO0g4blc4t7Ki0zqcIp3BcDApNUJy5GoK5vI9wqNAsn+0RAhhaqjOKULrGsAuM4XRiHPUsJ4DRoOkrnrprGFlukqOnsOdSLwPHoBcY4LqnxpGNwoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087545; c=relaxed/simple;
	bh=3y9MctrIBhe4pCJKlcJ/tn83hOd6NEohbCsuyFDMmXs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HYv7+04j0xSogFT6sqMuo12hR9d3zc49xY0W7q7m7fLwhoLGbhw2RXVOG6WGcIUE6yXPrmzfB3L6FWYN3DZ+gMn7UYnfiVfCg6kAXgfpWE0HbTGEF/DTddSET5qJT11DwTIR3nTYRQm+OZq9KksWpOkbxT1ehfmJIuYJmpm04pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyNDYhR5; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717087543; x=1748623543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3y9MctrIBhe4pCJKlcJ/tn83hOd6NEohbCsuyFDMmXs=;
  b=GyNDYhR5k7pVE0gFFIjSofAAdTomTiWObQ92ixAfY4k9eHZt2RUHrYfP
   N9mQDmHj7LsfbDn52tfO35Ndu1EUMUDBwqpJyWlG8DsdiKYCigqEH7VXb
   9K1GlYlyqldPXeSE4wb+SRgWkVVA+bJymfbWhykbXCjHtjEADZ6wu4P3a
   ZOjktlFsN22XpkyJ021dYciHWdHvA5qHilnmvQuJgnJcycL3nbWJg40vB
   W3ovzwldtgrZ3uucxrwLOl6m8T1TXQ5y4R1dQgx9NPf3inflBDfKPhxIL
   7Illa0ONpnHLdRMnXdPta9c1lYvOGkz+c+TS2h1BlZjCg9zc8szb5zPQ6
   Q==;
X-CSE-ConnectionGUID: Gb0yEcldQBefD9onyxANUA==
X-CSE-MsgGUID: HwFfu9UbQka5IIZGIdjwQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24992781"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24992781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 09:45:36 -0700
X-CSE-ConnectionGUID: /wTfFV0ERoukw+tqmiZ8Gw==
X-CSE-MsgGUID: kVLcFkaSRUu3QAJ1zGaEYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36494652"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 09:45:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:45:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 09:45:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 09:45:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 09:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKmWaz9DHzwcQwd+dMUTiAwE3Fy/QTPkyq4wg74flb8GTBLpUvdlcmLEUcZ2VCMKTy3BYejkO9vsYBgIuA9cBTslZBzGshRLhCTAsuaeSMqgI9h7S90Q1wLuLzcaWasy8XSQTBb0CcmvcV1JpYj1aGzSA5w0DUxC8OCo/hCUs+G9+oGv+CexYIpbZ4nbOtye/mm28u+8Ww0PdLCjQc8yj27lcoCAGLwTeQtCTJ5Jy7YlfnFV0VBQbvYKM/KL3fR15NG1h/SWfuAlYKZdKb8n9MCDx8I2mKx1Gc4h/uwYkN23xhlIzCcwfiYZe/1Q3+R/ffegOAH8wN17nwLqke/4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4T+XbGysgP1H+AyLoJLuLKAv79U6NabLX+hI392Vq8=;
 b=lMhJeER5d6492jpY+P97Y9DpSRR1HfqWwJfqQBG6RBH7Wc3KNxJE3IxPzgDJy33chNsi2BnovsFlufXgYqHgZBm5ZYgUJUWZxtPxr/w05ij50p4o9UL2Z40l3OUiHko/vg0V/qhyrJQc/71z8Rfs09ScYuIXfSxcQR5qhxkgk4kt8MXCbT7Q756HqR19URKBgm+CfUr+GPYZpmSQIM6AQhir1OyQe7vxpKyka7thMCqMOgINic4j/a1GpqG4ZlBqPzdatNs6EFgrwgbtQTUOe1B7priQGmiAIoE81nRtwAP3sDkxVjUTXBD/86zSxwph7kk2hv+aekaW6J+Qe57jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB8284.namprd11.prod.outlook.com (2603:10b6:806:268::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 30 May
 2024 16:45:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:45:31 +0000
Message-ID: <caedbadd-1840-423c-9417-b9a2c17cf955@intel.com>
Date: Thu, 30 May 2024 09:45:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2024-05-28
 (e1000e, i40e, ice)
To: <patchwork-bot+netdevbpf@kernel.org>, Jakub Kicinski <kuba@kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<hui.wang@canonical.com>, <vitaly.lifshits@intel.com>,
	<naamax.meir@linux.intel.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<anthony.l.nguyen@intel.com>, <rui.zhang@intel.com>, <thinhtr@linux.ibm.com>,
	<rob.thomas@ibm.com>, <himasekharx.reddy.pucha@intel.com>,
	<michal.kubiak@intel.com>, <wojciech.drewek@intel.com>,
	<george.kuruvinakunnel@intel.com>, <maciej.fijalkowski@intel.com>,
	<paul.greenwalt@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<brett.creeley@amd.com>, <przemyslaw.kitszel@intel.com>,
	<david.m.ertman@intel.com>, <lukasz.czapnik@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <171703443223.3291.12445701745355637351.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <171703443223.3291.12445701745355637351.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:303:84::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 257d47ee-a27b-400a-5249-08dc80c7eb61
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVljbkNJT3Uxd2VpT1ptN3VWcktEZG5TNGhQUlFQYnFEd3VvUWtTY0hmYWpI?=
 =?utf-8?B?bTVMWkxqN21qMFZXZXR3dTl6RmpnaWk3T09OT3VYUzk4REROZ0p5Z25tWEIy?=
 =?utf-8?B?SDcwNEowY0Z2QVhZNU5kak9DQyszYXUzTjNOSEtFcm5aU0FKSTVNdlo2YnJo?=
 =?utf-8?B?eERpeFdPc3QzTjUrRmUxeFVzVkczMjk2amNoeG5WTWd0NFlCdU1nVVFkZVY4?=
 =?utf-8?B?SXdaL0ZpKzZaUy9SMWhuUGM0SnN0bEtoS1dyVUtLY2hrczNzNVVObU1aWXRR?=
 =?utf-8?B?UC9jQmVCU2hUbnZWdEVSVE8wM2psS2M2a3RZOHJvTkVGcTRkeklSMktXRUFt?=
 =?utf-8?B?bytpQmpna0doaHpObG1UK2Z4dllWSDBnb0ZQck9XK1p1ZlZWM3Q3VUM0ZEpx?=
 =?utf-8?B?dEJhbmc1d1VGQW5ZV3FxZmNpR21KT21ZbEpNT3RqWldCa3BRWGlDRE0rbUU2?=
 =?utf-8?B?MGhDcTNTTHZNUzR1U09qNUdXUEMxRWdqRHB2dzJ2L1J0RFRsd0piR3NzSDky?=
 =?utf-8?B?aVhRZTVXOU5IdUl4N1hYRGJjQ3lBYWlyOEo4Z2VMSHB2ZzRRd2ZMTkhGL2Jj?=
 =?utf-8?B?Z3JaSFdWQzloS0NjQ1d5WkpMODBmUEZSYmZ6VndFWmdBK0pHRkRHZnQ5ZXls?=
 =?utf-8?B?cXdMT29GTjBvZ1JiR090T1ZGK1hZaDhKQ2FYVEF0QUtDTDBrVVVnT251WXc4?=
 =?utf-8?B?LzhyeURmc2FtaTRLYW53SDkrMG84Uk1kakxGd281UW54MFBpbk1mVE91LytF?=
 =?utf-8?B?Wk9sa2UxbTdzRGtsWWNqQ2gzQVJadnYyR05ONEVYTFlNVWMvcFpoR2lLUW1G?=
 =?utf-8?B?UUNNTHA4TkZ0cktLOWZnQW11WmNla0wxOCttVjlRMG5MZ2hhWGhtWlhZS2R6?=
 =?utf-8?B?d1BhaHVTTVh1TzFWRWFPSndxVTY0eUFqQ2JXaWVvM0orQlI1TGY0UkdpL2Vo?=
 =?utf-8?B?YlUrWVo2QTgzYXdzR2FIeW9ab1hTbzhmNktZNFZYZ3VTZVRNSVVUb3c4K0RJ?=
 =?utf-8?B?Yjl2a0FCb01Ta2UxTUlhQk41VmZrbVpMbkZqaE5UM25lNWwrVk1UeUw1YmMr?=
 =?utf-8?B?ekFPOGJ5VW1CSnNrbkZodUVZSXBpV2xKNXpUSE5ZcGQ0VTd3Q2RoWGhSWnZV?=
 =?utf-8?B?VnJVKy8xMFdoNUVVdXlpN2pmbmhFdFMwckJPa1hxSG1ZSlNiajMvTzZJM1p1?=
 =?utf-8?B?dk1jcm5iYzkraEU3aldMZ1JIMElMRWIvekthb3lkOVJhTE5ORjhnSExjNXp3?=
 =?utf-8?B?dHF0OXRJUjFEUGhaQURJNEVPbGM4eUN6UjZ3cXB2MHRSOUt2dEVaWGFrMGdu?=
 =?utf-8?B?M25XSjk1bWhCanFqZ0JTTFNTOUxZWW1tWW1DK0x2Ym54VlZlcmtBSW5ycnJj?=
 =?utf-8?B?V0xTTDBuaWUyN2RkSHA1NCtnTXVrSTlPY2NLMWd3N3g3VTkyM01wWnJRMklm?=
 =?utf-8?B?UFN6cGZERVl1YUhBd1VHWmNQRm8vemFTV2N3bnJ3Q0dxTzRrazNNVlMzdWJU?=
 =?utf-8?B?SXVWTlRWd0d5R0tabldoQWR2WE5qaTZiaDcyeXB6MzFVc0U3OFpKSC91aSs1?=
 =?utf-8?B?TW9LeXppcm42RWJLQmFhQ0xxR2x0b0MzSW5PUFJXR0ZyaS82QVBScDYxdzgr?=
 =?utf-8?Q?/dnmNqGijyUXAXH2Nvoz0T8hM0xfpG0tXCD75743qw24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVEzeGx2ZFVFRURrN25CQzRiUndadk9lNDRvZGpqU2tzemxQTmhTaVVXa0hq?=
 =?utf-8?B?SHcrbVFtU2hMMjJjYThzYi9XRUtGL2lyQXJOK0xZdmlKbStTOWlJYzB1RUI1?=
 =?utf-8?B?UGc3amdvc0NQZTQxSXo3c3hiLzQvZGtYZGF6RUhRWnljNnB3dGRsclVKRE95?=
 =?utf-8?B?dFVvTU4xWWt3OTlVS3JVM3AvRW9VeHBZeitZTThIMWEzV3hhOENkS2N4dFRu?=
 =?utf-8?B?OGlCdUQxOVJ0VTJZdUNiU2pGUHNDZnFadEhuYzFZcFZYa29CdjQreGlzdnhV?=
 =?utf-8?B?cHdnbTM2cS9MaFlMYWdVc1NITWZWRjkvQTNTR0dROUNBZHFTcFErWS9PNkZE?=
 =?utf-8?B?VEhsbUsva1ZMSjBrY2kzN0swV1k5VzZkRlBwb3FMdzNrNmpjdFJzaml2VmdS?=
 =?utf-8?B?b2IrdFExSnRqYlAvajByeXNKV0phaU12WHFrZEVsaS8yR2EzN2MrNlFaQUpm?=
 =?utf-8?B?cGhoUHNtTmc3cmlBeVEyZDNQMHArcWI1YXpkUmlyTGZRZUxwQ1U0QVU2M2ZM?=
 =?utf-8?B?aGFBK3pjZ08zNzdZZkVOcklRQXNxc0pxSlhieTd6d3Fzb3hXMlRPREJRcnZh?=
 =?utf-8?B?dFV3bFowSUZJeG5mSzBQcDU1UmRxeEpiZHN6RHdheXV0RUNZRnlHVGp6clFK?=
 =?utf-8?B?c1FYSXgvcGhGajQ2eHgxTUdBWS9laW02NERITER6OUdaUThRTzJKN09vakdo?=
 =?utf-8?B?RkdPU1hEeXFhaGR6ZmludnFmMHBTS3V3YmYrejU2WmNvQWdoN0cwREl2L2Uz?=
 =?utf-8?B?TVc5VkI0NmFuME50TXZHYXFnL3RvN0o1eDVtYjBLQzU2OW5heW82OXBqN3Fu?=
 =?utf-8?B?cWp1d0hiNUFvZ1VQRXVMRENIRkFQL1BubEY1ekNFRGdhazhzU1o2NFd5VHlG?=
 =?utf-8?B?aEIySEd1N3RLa3VLVWlaZklkY1V5cmNJbkppZkdzRjRsTnE4Qk1mTVhnZDNH?=
 =?utf-8?B?dGx6MUszTVQ0NmV3U0ErZVhPZlF2Q2RxUXUyZmMyZDVYYWkreVlEU3ZLZExx?=
 =?utf-8?B?a28wcFBQazJBRXU2ajJGWnpnUUh2TkxpVzc1bmYrNi9teVd0Y1pWWlhNUGlC?=
 =?utf-8?B?OTdUaGMybE5QTDR4eldJYjBoMmdTOEErTk9HSFJGbnpIQVY5aHN4cUJnSjNH?=
 =?utf-8?B?RCtOVFBCMlRtTCtHdXZuWEVRTDduMXkyNEVTNFQ5S0lmWEI4UDVjTUdxSXVZ?=
 =?utf-8?B?QS9QTG4zdFJpZFpGN2UyQTg0Wk9qRUtDQ2NrbklvaFgwU3h1RkFpSWhWekQz?=
 =?utf-8?B?OG1Kd21Zb001eGVPelM1ckZRTTEyQTNCYUlmQXNCUDdsN1R2OTIwRTQvbjg3?=
 =?utf-8?B?SGt5b1VJb2Y0ODJ6WjdoTEJKWG1wdTVlb0xTb0xZNHFuSWVSdit0cE5vSzhM?=
 =?utf-8?B?cDNRcGFmZVY1dGlwcDZZYktmOFBKSjJZSUloTzZua3c2UDdXR0ptME1XbXFP?=
 =?utf-8?B?cUt4VGV1TzNOYzZlM01rNDQrc2dsSUdreW1qbGhadUM0bmNwalNMOVF6S0Y2?=
 =?utf-8?B?SlJjMlg4RnNhbjVNVmpabXlYYmVESUpET1JXSGQvZmFrS0tPVnROd2FHNVJM?=
 =?utf-8?B?ZjVncytSREdueTdLbndpRGpGeSs0VDgyZHJyOEpuUUdqamlvNi9TdXhaNzhu?=
 =?utf-8?B?WXIyQjg1MjVML1lsSWY0am1GYmxSaDJJREJQMzNDdmVKNCtBUUttOHI3UDNm?=
 =?utf-8?B?K0Y2L0J6LzhNUFNYeDliTDJvZ3FwWHkrRVVsTFFoM3VSY1VoS1lqSXJmVGFJ?=
 =?utf-8?B?Ni9ZbmN3Z2JjV2RsSEFsRlJVVUJRRDE0cFZsa2tpdjJKaEsrR1BFa2NTY0ZF?=
 =?utf-8?B?dDBxdEEzZjlqcVhSaERLQUVXY3dwK3E4d1BKR1BzRU9qVGxjL0pFL1YwenNs?=
 =?utf-8?B?S2tVb2NkZ3crUkMrSFdvODF6a0YwWlNrNy8xMjJ3UzArR3VISEhWYzEvZG9v?=
 =?utf-8?B?Uyt4M21SSmVycXVBbytNNlF2ZzFLRFlpV2Z5SHUrVm0zN3laeFNSS3hJdENX?=
 =?utf-8?B?VXp5d2VISVZtZ3ErblZmRy9hN1E1QVpBbzlwcFd5TVVmNDFwZGhUTHNSU3Ax?=
 =?utf-8?B?MEo3ZWtBU3RvYWdmRC8xOFcrQXJhelVGamcxTGhJOFFYakFPVXdIOTBGdU5l?=
 =?utf-8?B?U3dja0oxbXhydTJGbGI2YURJQTFsTHZhSjdJVUVnR0JUOGhLUVhWY2hsUUxU?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 257d47ee-a27b-400a-5249-08dc80c7eb61
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:45:31.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6JZv+FGwFl+BaK0ZyyO7qrMtGr+yi3YMCCmeb6y88rUHH+JkQrc/ZwcpfnWfZnZ5z2o06TrCcO4g9ZM2JIRPA5YDSs2QrsyD5oPtZQPiZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8284
X-OriginatorOrg: intel.com



On 5/29/2024 7:00 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Tue, 28 May 2024 15:06:03 -0700 you wrote:
>> This series includes a variety of fixes that have been accumulating on the
>> Intel Wired LAN dev-queue.
>>
>> Hui Wang provides a fix for suspend/resume on e1000e due to failure
>> to correctly setup the SMBUS in enable_ulp().
>>
>> Thinh Tran provides a fix for EEH I/O suspend/resume on i40e to
>> ensure that I/O operations can continue after a resume. To avoid duplicate
>> code, the common logic is factored out of i40e_suspend and i40e_resume.
>>
>> [...]
> 

Some of the series didn't get applied. The two you commented on with
issues or questions make sense.

> Here is the summary with links:
>   - [net,1/8] e1000e: move force SMBUS near the end of enable_ulp function
>     https://git.kernel.org/netdev/net/c/bfd546a552e1
>   - [net,2/8] i40e: factoring out i40e_suspend/i40e_resume
>     https://git.kernel.org/netdev/net/c/218ed820d364
>   - [net,3/8] i40e: Fully suspend and resume IO operations in EEH case
>     https://git.kernel.org/netdev/net/c/c80b6538d35a
>   - [net,4/8] i40e: Fix XDP program unloading while removing the driver
>     (no matching commit)
>   - [net,5/8] ice: fix 200G PHY types to link speed mapping
>     https://git.kernel.org/netdev/net/c/2a6d8f2de222
>   - [net,6/8] ice: implement AQ download pkg retry
>     (no matching commit)
>   - [net,7/8] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
>     (no matching commit)

I saw this one didn't get applied either, but don't see any comment on
the list regarding if you have any objections or questions.

Thanks,
Jake

>   - [net,8/8] ice: check for unregistering correct number of devlink params
>     https://git.kernel.org/netdev/net/c/a51c9b1c9ab2

> 
> You are awesome, thank you!

