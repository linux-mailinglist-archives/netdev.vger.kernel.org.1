Return-Path: <netdev+bounces-173458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64918A59045
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9475416BDDE
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446572253ED;
	Mon, 10 Mar 2025 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0KoXD0K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F20222589
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600260; cv=fail; b=f5fdHiTgm+8iuiL1l+tQm/2Gl3hRjsOavAhDPc2nnqpRy1Hy1otWK8cSlIIAAyeMTIkbTA86YqZHR/CJ4QjlDd/FxUhaQll9GvwUpQ9hVdjQYRW2gi1qWOokcaM3Wg+M1PvGiq0DrDFH4i4HODsRYm+FntRo4N+fzNJkMX1iVFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600260; c=relaxed/simple;
	bh=XrKvY4MSCguIUxJiSJRwsN2lsk9dfXaB5GIkbhwHgks=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rrx+DTebPYmhkUMeXw+XnOjyfbroNhofopyeWrA7sGO4EV+GobkffXtCvni2ibDYV0ES1u/kr0dYA2WVhNFcPsT5aVY67js83X8dztUJ2sjKGmWxC9kz/9TAm1Ys4FjpBse3Ho2vwAa4MCwtQHhhQsauClnfoaEb3wNWO/B68Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0KoXD0K; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741600258; x=1773136258;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XrKvY4MSCguIUxJiSJRwsN2lsk9dfXaB5GIkbhwHgks=;
  b=A0KoXD0K3cruIbbm5YG4oRf4DY+HXc5iss4THgNhxr2Y1iGcoTbdrEEU
   6zi4h81k96uCkl7r1nGCdWaqTvDdKJtbUXfsYSZEbcdjRVwgSSNEKgWnV
   ECqo/leUwLcGEkYUd3N4VbWfypqLkfMdGnMqHzp+mlxH09hHAGB9Qk6WK
   NI0yLtfXwSc2zGAq2QXEqIBtnrF5DrcY6va/fxUEJpb83jg/BQQCtRo7m
   Mcol/2F5cu1vkfk3l5bDWpsUTVwX95LCI0IZfWlKh7Th4/TItAjqJ3tR9
   Cnx/jnJ3Gs1vfzLnSJUh2qwq+sqjCcicFQfkCVC770+diWZYDsQcJRUgh
   w==;
X-CSE-ConnectionGUID: MDPxVihMRmG/bhSLFoGLnQ==
X-CSE-MsgGUID: qypOHmQHQySi1I8i1rujLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="52796953"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="52796953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:50:58 -0700
X-CSE-ConnectionGUID: +Zn1CAULTPmrMbQEgmJF4w==
X-CSE-MsgGUID: 2C7ue94aQyek8gfX60Ktkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119779387"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 02:50:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 02:50:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 02:50:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 02:50:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTtNa7my9PhMSRw1dcsPmylkOd6hkZz55ye3fzWPtyld9wSybpmzbzmbKLeHnxRKCvzW2hIOontSS7Q6B1I0uz9+OyfjP8ebmEpy4F7GczxD5/i586eEc1ejGodOEggdS8dPAbowvPrxFhmvRBVnnatOXkC5ppRcaTAkPIUZdykPE3W8/EzTPfPoXvrPz4YJQJ5GUp/Wy7/IBhieGegPOKtzOovP3gAwbXw9lHPbjsIUYXxkbuUtA9AtLtK00xBJaLdFLTMTuE84moXxFNJTYfSmAZDO9r2wZvOBeYx82hv8YLTpgR9pKfuSoLd8ScJILFW9t/HbgQ5GEjathKU/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9W2WiYzD0w4TUWYN9WVK/XEvYOAi8NqlwgaH20+7RE=;
 b=Ae2jCXKB8VFWCcWvxJFuZrZe6Kqcu044J1g6zLIh4P7896DuO7dY4iestGDROk0ZyTRa0VMWVoqOM+jsDPXpcMU2np5FBMVNctM5bT7Y51pj5he9pCtAjnc8ZJko/3aU52JoXUKwjRavahtT6GDgAFmHTqmHkWIZIYv80vky7fa7OrPE/05F/39fYyJ+yGVEUTmwJrcwlz5SmcDwfmAU+ZIevl2gnLqmnCJ01Q74JrTezMA6Cw50H4Uin++vU9cwsE6UdqFWjKuq+py+oN+nZbnlCJKRNRX2FXD7IIKzvCi7XgtcsXjKujSeGfF7G92jSw1D0/nQaDYqeMgmV+AgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:50:54 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 09:50:54 +0000
Message-ID: <3ed3e4e5-7b28-4543-b6ef-624064540d52@intel.com>
Date: Mon, 10 Mar 2025 10:50:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] ice: use DSN instead of PCI BDF for ice_adapter
 index
To: Jiri Pirko <jiri@resnulli.us>
CC: <intel-wired-lan@lists.osuosl.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>, Sergey Temerkhanov
	<sergey.temerkhanov@intel.com>
References: <20250306211159.3697-2-przemyslaw.kitszel@intel.com>
 <28792ae2-bee7-48c9-af5d-2e1ba199558a@intel.com>
 <vt6wnwcje727xv4agzhkpe5ympcvhtgg7qbaq4hlvw42roji2r@3kwjm4togc7m>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <vt6wnwcje727xv4agzhkpe5ympcvhtgg7qbaq4hlvw42roji2r@3kwjm4togc7m>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0046.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7b9815-d1ce-4558-177d-08dd5fb90c90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdxTlV1am9YWFpWakZ3MjVGb3RjOXR4djQ1cVJ6UkN1dzd1bnRFRWttYVRD?=
 =?utf-8?B?cmhWbTV2VzBmTDEyQzNGOGpFZjdPTjBxMXEvLy8zbU01SkJqdGdVU1NvZklJ?=
 =?utf-8?B?Z2p0RWlnNHdtaEJpcmIvZHhWZE1HRDNDQW5ObWwwVG9WVDB6MisvZTV0eVhn?=
 =?utf-8?B?cXozRTZXanNLbWpDaEtvWHF5SzJYYnFXQ3FZNEdmMmVqa3dDL1NmL25mMjZr?=
 =?utf-8?B?R04ydDVtbHpZUTNON0t1ZHRMaFg1TmEvTFprUW5KSHRTY0c0SGZHS0FCNGIw?=
 =?utf-8?B?Q2F2UHVDQlF0UmV1bnUwYWNPV24ycnhsZTcwZTF4OFJSYW96Zkg0amNLaDAr?=
 =?utf-8?B?Zmh6aDRNbWpsQzBDN2V0YUxmd3Z2V3dBUmJzWkRNc2hFcnR3ak1UZVpYRytJ?=
 =?utf-8?B?RlRpRHFuNEJRSlBud2dVVkJmeDdaeUd6c0FSSzhLcWZrdTNFRWNMWDNVUUUx?=
 =?utf-8?B?bDJmRmdKdHl6WEdIL08wSVBlSmNVNXRsL2dZSThWZGtYU1RnRWpWdXpMV3o1?=
 =?utf-8?B?Q2NmZmNRcmxSQXlPM1VFRkFpd1hZV0VnbSthdE1HZE9TbFkxd0lhbEJIZTdV?=
 =?utf-8?B?QWJUdHdTY0VIamZhVDd3OFo4dldVczFFZDdMemxjMnNMTmRLRXR6aTY3TS92?=
 =?utf-8?B?SHVtY0JlNFNFckVOb2x3SGZLUHB2dzk3UDl6S2R4KzdZc01EVUZLMS93Y1Ev?=
 =?utf-8?B?RTk1djdwSU8rTG9Ma0MwenAwWWdlZ1dHUkZ4ZmE4dTEvV2pMWTJycmtseENF?=
 =?utf-8?B?UHBlM1JSZk8wSG5NOWd4SXRENEpWZ1g2OHRXcnpYQzkwcGNHTVM4aHJVa0FQ?=
 =?utf-8?B?ckFXNncvMGR3YkFUSlpjL3NEU0VTQjZTMWE4ZlVHMVl0SFd5c0xLdVoxS3pJ?=
 =?utf-8?B?cGxOeTZCS1J3YTJ6b2ZvSkl2Nm94SC9HRkVyU0xWL0g0SEZuWW1CVzZQaWYy?=
 =?utf-8?B?VVUvVlRIRWVUL3dLcXN6c2lFS0w3blNTZ1EwaXBFZTZuVHh4c0hRaEo4UkND?=
 =?utf-8?B?S1FDbGFsb04wTTVpZTQ3NjlCc2R5Y3cweXYwQU9Jc1dNZFZRb0tGeDlWZUdZ?=
 =?utf-8?B?NVREU244NVY1VHd1Q0N2V2VVcmpXdThiMDIzL1p4WDh3ZkNOR25XSE0zZlBo?=
 =?utf-8?B?MEFHU2pzRm1hdm5nR3pxYWh2N0pldXVzWnp5SHdpV0pLbTFIUGRJYng1OTZx?=
 =?utf-8?B?anNqRnJOR3BTYlZtY3J1TmpVQ0lFaWM4RllyM0QrRDNEditQNjJRRnJQWnZn?=
 =?utf-8?B?WTU3SktaMWFkZ0pDOFNDU2pGVTlsYk5uRW93cjJaQUtzV2FaQUtGSkpzNG5s?=
 =?utf-8?B?SzdXZFN5UVNxWHJyRmRNNWEvKzdGS0NoWE9BWjJTUk9zeHpKazNyRHBDaVhw?=
 =?utf-8?B?T2o0Q014Vjc2UXhneVEwQnIraWZVbDIrdnVnVFZaamRqMDVQWGRKbncxMXd4?=
 =?utf-8?B?KzVIcEQ1U0JYWS9ScEhLaitqOElTU3lUdmJ5Rnk1TGVBUjhmZlVxM3BLRHFq?=
 =?utf-8?B?SVlpckE1aldUUkNyWkRKL1lxRkM0OG9vS0RmT0lnWlF0OTAxbVVVUFBRQTB5?=
 =?utf-8?B?NUpmdzViZmdzaHVPelJUV0w0c0swWEFoNXNJZjVuZW9TNzhrVTBldmVCa3hE?=
 =?utf-8?B?OFRWaC90cnZwOGE1V0wveW15bm1seW1uK05Na0p2SjRNZ1J6cEExVThFSmRJ?=
 =?utf-8?B?cUlZVTY0SVFKTVpqQ3NNK1J2UXArcExTOENDdlhpWE9MS0s3eWpBL3BGSVpP?=
 =?utf-8?B?bDAvZVh6OUUrOUtSTmxZMForcnJjRlA3VVhnaEtMSmFHNHZhSFAzZVB0ZFFu?=
 =?utf-8?B?Z0lyYnBWWW5pSnJrc0MvUFpkU3prZmE4S29uWlB3aDYzSVI5bnpiRGF1dUU4?=
 =?utf-8?Q?CzAX0VuPL0eGj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1prTjZLU3U4dU1xMnlUc2RXM0VuNVhFSUxIdDRtYmNTZnNQUzA4MDYrR0lX?=
 =?utf-8?B?ZXpYREViT3g2dndWVUxha1c0UmlJM1p4TTlGaTJGZFQ0V1QxaVFTR2xTMVNE?=
 =?utf-8?B?UWY0clFuK1lWZXY2TjhLMFlodlN2cGlwQTRVZW5pcDRXQUFqaHIrLzk4Zlc1?=
 =?utf-8?B?K3dIL21DWCtJcXQ3SjJOOFRIck9oQS9KVXFqbDBONFNiME9tcncyNENSRmZw?=
 =?utf-8?B?d2xFVUNueWJXcnB6OUR2b0ozN3lEdHJhc2hreTRMbWkxbnoxckY4empIVFNi?=
 =?utf-8?B?Q01RWUpxSE85ZlEzc0NyT0tFamJxbXcxWENsVGJwdU54cFc1ZHkwWnRhWDkz?=
 =?utf-8?B?VTZ2QzB5NC93QVhYY3VYQ1ZyYXQvZDN2OGlIQ0xqRFFyOWtwdHc0QnA3YVFR?=
 =?utf-8?B?dVdiNWtHd3VjQnNtVVhYTXRKSnlwSlpxeXIveGl2M1k2SGh1WVVqNWM2T0NX?=
 =?utf-8?B?bmhyUG5oRDZhb042U2pKdXl6akdKUmhMUjdKR0VTcGpGdFNjZUUxa3FHVXpX?=
 =?utf-8?B?ZDMzdGxJazhsSlphRG92Y3dJeVpFZ1FOQU9IMjFpTUF1NkJXSjYySnE1c1hj?=
 =?utf-8?B?Z1VtemllUzhxNkpFVUpuRDRCVmNWOUlKUUVsSFJORGcwV2RUMGhoUHB6THNy?=
 =?utf-8?B?eE4yekJqQVdlb1ZlckEvb0NJMmQvK2I3L2lEVzlrTHZFYXJ4NnJMeEJuSlBt?=
 =?utf-8?B?VjhTSUY2dHJYdEUzb0VFY2ZoMkE5WnBiY2R5MHVxT1BDK1NhSS9VaEdHZk1I?=
 =?utf-8?B?K0p6RzFGcGdPalBKL1ZiZHNodnlYRjRBc3R6bzhoRkVtbG52dkdNdzVXN2pp?=
 =?utf-8?B?WDdtVTJCWTMxTjB3b2ZHZnpXRHl4c0lWOFkwOUtrMTJ0bGNtd2dYaDlUQ2lm?=
 =?utf-8?B?V2ZXdC9MVVBSLzhVc3piNFdjOXBEWkJ0bHpXQ28xc1J2bDAyc2Y0ZldINmgv?=
 =?utf-8?B?Y0VManZGaUNLQlVZUFl6Vzh0ZjRZSDkyTlJFdy9tK2NRblVJVUNmNmwvd1Z4?=
 =?utf-8?B?ZnpFWFY4aDU3TFUvdkN1bjVLbWRlZDh4UlhhV1k1MzRYR1ZMVXdOU1lKQmRl?=
 =?utf-8?B?bU1IM0cvTFpSRzVoWDhsQmJzMXZ5eHFNL1phYU4wMlBja01QYzhPanJxRmI5?=
 =?utf-8?B?b1Y2WlBTTmljbU1NdGFzYTVKbm1jRzFwQWkxNjJVZCtTekVqaytYNjNsLy96?=
 =?utf-8?B?SUtaQ2NmRHQ1VG9LbjhaV1ZESUdBcXdXdHJ0YTAxY0VySHkwME53UmZFakJM?=
 =?utf-8?B?N0ZmandqTTBZeGJGZmZFMmFKaG92TEJwR08xU01PaHVSL05Lc3dyNklRdklE?=
 =?utf-8?B?amphVFgwdnA1bDBETENIbmFkdk9NRk0ydXFiRUFCdnFKVzNmTXVZUmV5V1Nk?=
 =?utf-8?B?aHZxYytPOWF1MkhNMUp3U2xKWEdIRFFSeVFDSzk1dC9aNFU3czJSSkpMU2xR?=
 =?utf-8?B?dlRrRVFzYzZNQWx1bDBocWZCSVk0b216WmdLOHpJekNiVWh5bTB4eU5LK29W?=
 =?utf-8?B?RFQ3aWwzYzg4QU1zR2dxSURONVZ5SmlTY0ZjZFJ1RHZvS21TUXRNZjVlR1k1?=
 =?utf-8?B?YW4vc0p1VG04QzBaTmZ1Mi9QcmJJTjE4TlQ2ODVneVc2SUpjY0NFay9QWnN4?=
 =?utf-8?B?SkUwVlJYdWdPb2FwQUo0V0RQdDFTNUNwVEczQUVHQnUwQmtGWEpUTWdoYXRZ?=
 =?utf-8?B?WVBRYlFObDBRVWdMT3JXeitRMHM3K1FrdVFJY2JlRENMaStCVGVXSTVtU2xE?=
 =?utf-8?B?YzZMWG9OTVRCMmZBMlpnQ0VabGJYOU5UWWwvYzlhdnpZWDBXdTJmUzg3U0Q3?=
 =?utf-8?B?QTlqV1puRVEwaWxrdEYrc2xmeXZWeHhzK3Q2K2JtdXZwYWxObE1tcWxINnhX?=
 =?utf-8?B?eEY3cEtDcjg0NGVJSmpNem03US9IN1p4TlJheWpGQTdJemhKQkNKMWZ1U2h0?=
 =?utf-8?B?ZXZOd2hsVUNCa2diVE1BaFBUWEpKVnVFbE0zaEdnbUZkUUpvbENldVQ2NDBh?=
 =?utf-8?B?eWZoQVVJdEZXbmpCK1pGQUhLT2RmbnhBTHF3SjhyTVgrNjdtajYyVzVGcDNH?=
 =?utf-8?B?Y1lrWWpRbCtyV3FBbndFWExSRVhQZFVQQTgxZTJlQW9zUUwxMW8raVhmYWtq?=
 =?utf-8?B?TGJ4dkJ0azZlM0hJRVNmVDEvMklXTHVqMzE4NmxKN1ZXK2gyd0lNMlQ0alVn?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7b9815-d1ce-4558-177d-08dd5fb90c90
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 09:50:54.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ot+yOQGFa9IeMJqM+inaYPPJolZNXZxUkZ3xaExWB/5rtqjIUAGnoFQFQGKQt9r35wcFTH7qY06GRnZP+veBmiDmkqV/Ql9NZPY4dcTpm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
X-OriginatorOrg: intel.com


>>> -void ice_adapter_put(const struct pci_dev *pdev)
>>> +void ice_adapter_put(struct pci_dev *pdev)
>>>   {
>>
>> A bit of a shame that this needs to be non const now.. Could
>> pci_get_dsn() be made const? Or does it do something which might modify
>> the device somehow?
> 
> Would make sense to me to make it const.

It would indeed, but to do so, one have to constify at least a few other
pci_* functions, I didn't even got to the bottom.
While I appreciate the added value of typechecks, I would like to focus
on different work, especially that there are contributors that seems to
be focused on the hunt of such cases :)

> 
> 
>>
>>>   	unsigned long index = ice_adapter_index(pdev);
>>>   	struct ice_adapter *adapter;
>>
> 


