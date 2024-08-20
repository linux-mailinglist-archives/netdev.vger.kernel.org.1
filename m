Return-Path: <netdev+bounces-120237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D48958ACA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8FE1F2575A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44918E77E;
	Tue, 20 Aug 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxZVsfii"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BA18EFC9
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166765; cv=fail; b=XEeRPHA1n6fJFLeaO/wpvxZVFAczDPanyGnIew5XIY10/zvXXND3Q5KXgH44XWhDRAFYg6qPbmErgq7vmkaXN0f42RPd/TTbjUzcx3uza1zNLa0Mt2El4tCX+IP1GZq2tanDPY6GeIn+FBpb0di9P1MOUkKY+YCwpVdMW+93sNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166765; c=relaxed/simple;
	bh=PyXhtFb7rgXG3oBaNddSHij3Brl5Ecv2YqzYV3eSLO0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZcrJtKXhKLcNOk/NYvQkSqv6tMPBuYNpcak78d6Uw1Wn8t7aI/SJZbiXQzFvbSOhlVKUQf/eaZkrlnycWpM7mGMlMFdbqRqPAUgYvPnxy+Hhf6JuAd39iXFvwDi7YwfyhbHPxfKhDcsPdiyWdWN3uklieeUAV+bIcFOCKPsXgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxZVsfii; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724166763; x=1755702763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PyXhtFb7rgXG3oBaNddSHij3Brl5Ecv2YqzYV3eSLO0=;
  b=MxZVsfiiFZ0V6kHNCj3VI025fbmWz9Oqui/vLBkaFMg7oXIbIAzWuE+h
   3PmcPHmOiuaa/1DM9YMJ/Bs5PLGlM7n6+IfpKdhJr7ye1xQQ+x5/hEyF5
   b1UUwlvA5xK0jbuB6T0qbmm+sJH8pq9eGe+/Z/VYpdzQHXCmK6y/GriSd
   3lGvro0TssP0uz5T3GI3JQUlTtNRsj6yRJ3csn/uWZm7rq9cQi5RGOoik
   NXGCBAdUNLboQt45Dy4LD6886XoQC8ylnVo68OcXfKrRoKO4IXtQ2eZ2U
   HkY4zCzYstXqTCoMnU3uInWCdN+eTiwaYADrXmOfJZeP+ut6SIYblrBXo
   g==;
X-CSE-ConnectionGUID: VjopOQxzQXCoFZ76h2MuBA==
X-CSE-MsgGUID: SxGPoSZhSbm9lY1TnrIE8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22358574"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22358574"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 08:12:41 -0700
X-CSE-ConnectionGUID: wofLB+TJRfekynZhAcxXZQ==
X-CSE-MsgGUID: TXh+dkdeRY2MAMvcEOPSmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60412883"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 08:12:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 08:12:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 08:12:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 08:12:40 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 08:12:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAPc7v8HzdhRBjoNgMNyVJ18eQehkZoiCeS8jptAGUvmefF91TMjddAY5Po0aON3UM17DhFLIXorA0YvmjJGUEH/BnYeQCLWcvUZXMb/Yhwc0teLJeCkaClH7CwF86XONNq72tQuX2noGWX7VaWaM/pR6FYZ5YXaNpyVnlImfjDLwbxQOAepWkfVZBRhkb8wr2HneP4e7QoyYG6mTkHAwzjobXaHlwIQF9OBj6PS3XLyEUSXQOZ0QHr8p6/dxCsfrqHjVsyR6f144woXUZJ4FOw3Xd3sB+BXTepFbttyg+T0g1NL3r1uvTgbdSiUOzWSdAql4/D9DAoEEPNJnDzZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0y62f5kd2JzJnYIXG8maqB7Av0bS+dEycnB0CcAxUY=;
 b=wHmLr15liLbZrQ1RKe5yLASDsNdZbNYe32/YLbebpTl+AgExQzZ2TER/GSMIxQGVf/d2Ve+TM4wjbA7M4M/Lu5EQf1aEdNQ4mZFG6j73v/d+pcBwJ6Fw7rSR51EInNQpbpfLLJFhLsOaIFeDA/ggOb+z/TgL2YYXqyinhjXuJ8Qm+4sQpFV0TOmwYXW5Luc5DTtO4G+hvdccIQvyhmliLOTtDlUAcAicmDRahSmYA7u1SD3xpiwdcFOmw3ICoLfwGAY1CVqgea79enShvPDZ/VFQsdRapflHc9pcaIsNmsKdvK+dJwdw/+fyI1qML6SSQBEoH2OiWEiRycju7+wf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW3PR11MB4569.namprd11.prod.outlook.com (2603:10b6:303:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 15:12:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:12:37 +0000
Message-ID: <d3745969-df9b-47fa-8854-6654867f94e4@intel.com>
Date: Tue, 20 Aug 2024 17:12:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <virtualization@lists.linux.dev>, Si-Wei Liu
	<si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0336.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW3PR11MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d7f098-9745-4525-d2b5-08dcc12a86ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3dsVktxWlNzZllnaVhJVEZaRWw4SUxoSnBxZ1dLcjJsYThVa3RBVXRET3Z0?=
 =?utf-8?B?eVBHQ1Q3am1BNHNTTFlLWEtlWE9abmFvSEJSdVNLWHExQ2JhenlXT2pRSE9o?=
 =?utf-8?B?TTVQVjkxbmUwbjh5TGlSeFkzVkZPN04wM1N3bTZPN3Q4ZHVTMDRZaEozMWs2?=
 =?utf-8?B?STNjcWlseVJKQ21DclJUZFBYekJid0kzcWNhVUtxTE93dXNSV2hKdUIvR09W?=
 =?utf-8?B?UGxLMmRQQzJMc2Nvd2NoMFRTL0hGVmZkT2dFQ25pNVZxQTI2WFlHbjh1V3pM?=
 =?utf-8?B?eG9Qa3h5QzRYeE5NdEpjZUF2L09QQTBNck5vaXNpb0tsOVZCUTV3enBXajA3?=
 =?utf-8?B?dytqbC80SVZsait3ZVdPaUJCQlNta2RxM01QclhCTFo1ODdZMjBPQUJVZGJY?=
 =?utf-8?B?ckpwUk9qdEs5SllGRzE0b0tmZUFlVVBJWnJGRGlxQStwMkcrZDJhbENSQUNR?=
 =?utf-8?B?em9HMEtlTldHVS9HVXhRWHY5MGNzWWl5L1ZyVC9iV2t0NGg2eWQyOTB5c25i?=
 =?utf-8?B?bFExVkFoeERCTHVJMG9iWDFoYXNuaFZrenEzdFF3M0J4R3dMcG9HQjRuclpT?=
 =?utf-8?B?WDJoWU1UT1pMNFVUanJUajZJNlNEUUl6VFNiL3FPdkhmeExUWFROV3h2K0sy?=
 =?utf-8?B?RXg4M2VrYXN6UUFsVkoxMHgzeURWV2J5a2dpMEsvQWQ2WUtLUThGNjdNTTZq?=
 =?utf-8?B?cXZPcjQ5aGlqTEJrTnBRN1QzaDNuVTVOY3EvNXBpZjJyVmtETkdFbURhaUZj?=
 =?utf-8?B?QlcrVkx3N3o2a1pmSXdEV2pHZGJ1ZGZGYjAyR2xVNmIzODdqU3VCUmFObWxa?=
 =?utf-8?B?ZjVWWmJCcEFMT1I3VmhndGptcTJQOG9FeFVvbG5Ka0crbVRyVnl3eitDaHJh?=
 =?utf-8?B?YUE4UHdFY3ZSeEFPMDg5eGhMME5SU1EySHpkOGdCVmpLRkFDZEltNzk0MFdq?=
 =?utf-8?B?NmNOaGZEc2VsT1FPcnp5UUlObWdiRTVUaXd2NVRpU09RdlMrL0tTRFkzeTJo?=
 =?utf-8?B?SWVrK01BbVF0VEVpcDhyeUJhUXlFbWFtMEVVanNzYkkwdy9jMWFSZHNCTTJ1?=
 =?utf-8?B?MzV3TTN0NzU0RklOUGNrenlLRWlIMlg5WDFucVIzYjRnSG5PTnp2Ky83RC9E?=
 =?utf-8?B?OTF4ZG9NRDJYK0tETGo4aWtpV2lGaDBpY3UwMGY5aUtVbE9kYzY0TEIwdHdn?=
 =?utf-8?B?QUs4RG9ZNnVOWXBZSmV0Q2g2SEFTV3V5ZFRSMkRyWEdvT0pvUDlvYjJqS0Jx?=
 =?utf-8?B?Y0w5R0dWOFBUNWZocG5lSzZSR3ZxREcwOTNOTWIrTW9SVURpLyt5UkhEeGpn?=
 =?utf-8?B?dVIram03djhMVXFVUmcrVUNtUWNvUWtUZnhtc0hxYmhpb3VZdnpXTWZLWll1?=
 =?utf-8?B?SVJMbzRrZHIySC9NN2Q3cHN4WHk2d3RMK0NSUGp5alRNVW5TQmkzT0IwSHZn?=
 =?utf-8?B?eGlGVXJRZ3NDY1IyU0o4eU9hOU9YZ3BpcWJJY21MVy9ORmlLNlpTYllDN1Fu?=
 =?utf-8?B?N2JrWWg5U05RaWM5RG1VblJLcllKL1ZXMm92NGQ0V1hML1pYVkhvbk9UQUQw?=
 =?utf-8?B?Q09aVmdmdlRaNGhZd2xLTlFqWUYwUEYrQnRudDlPL25tenJ4M2xhK2FFN254?=
 =?utf-8?B?K1RVUERhSlpxbldVZDhlNXBXRWxBbVhzejRqQkQrZ2YrSzE0OHc4Z0J3T0NW?=
 =?utf-8?B?VlJLRVBTQU9VRVdET1NGUFpsMXR3RnZnN0l6eWpMRCtuMmxOalAwOXBIaDNQ?=
 =?utf-8?Q?Um/XkCqkMMAwZU+iOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU83d2VGeDFQdEFSRE9CM042YVN3Yy9jV21HMFBZV084eStqcmdGSEtMdHJH?=
 =?utf-8?B?d1FscXY5S3QrcVh3R2Job1M3ZndsSjh2WkxOL2FIRTd1ODRZVW1VWnhMQU9R?=
 =?utf-8?B?OG1OU0VsNHQ0NEFMRFBobkNjTjA1L2FVN0hxakRsQ01JRGNMdUJ4RGtONktj?=
 =?utf-8?B?a2JyQUpxcHZabGFlTW85V3dvMnJJZi9oSEtsVGs0aHgrRE5RL2IzaUdIdkRU?=
 =?utf-8?B?VmpHNzdobm5XSm9hYWpld1FoSXQ4MVNLRHN3TE1tU2ZMbTdrdC81MnFsYjJz?=
 =?utf-8?B?T2pUTCszczB4WTRBVzZoemoreFJmaCtEaE5EdmF5ay9JQk1iZjlNaTZvZEVq?=
 =?utf-8?B?TVhWUjlpOXZLNzJvTEZncjlxR2tTREpFVmRGenJCUSsyODhIc1BXSEVnTjFP?=
 =?utf-8?B?Y1FyMk9Uck84RXlVU3J1MUh2YmNvamJRd3BiRnBnWXVxZ25QZVg2ZjVJeDV0?=
 =?utf-8?B?bnN3TkpqK1lqWEx1cHMwelptdzM0Tk1oRmE3TEtJT1ZFTHB2Z3VqWVowZERJ?=
 =?utf-8?B?UTZmZjVhUXVpdnBEdm95SFZKTmxtU0VLai9ONFhhSy9PN2EvclFaV2JPaWE0?=
 =?utf-8?B?WDFqNCtubFo2RVBvaW10dWtrSmVSbHFWWDkxalRtQnhlSW1rTGh6aE5Rd2tM?=
 =?utf-8?B?Y3U1NWcxZUs2N1ZEV2JGUENZdnBOa2ZWM1BFZXBXS3BReUg1WDU0MjBucWJq?=
 =?utf-8?B?UTFlWGVubUlHSWhPVTUrMjZ4cWZjT2ZYL0JpL0pJU2FNTy9OUEdQUVBhaEFZ?=
 =?utf-8?B?bE4raENib0pCMWFHUVh2cXJLeHBVeXYwdlpwcWxjUnNtNEtIY2kwVzdxL2FX?=
 =?utf-8?B?Y3IyZk5YYkFobXd1MjQzUW0rSTFyU2pDVk9Gd0ljQkhTcG95dVdybWVQVHZv?=
 =?utf-8?B?UlkrSHBjUkxrYm5obnlqb1lXZXlHbUFEYWxtd0hoUUE3dVlmYUg3MlFKRWdh?=
 =?utf-8?B?bXNVMWdmaDhtTzZMZkNzclpKa2lhV2d4T2Z6RWVJOVNqWTJYLyt3Ly9ZU1Zu?=
 =?utf-8?B?d3BUR1lYVnhaUTdCV3cxRi9pa29hWi9mazRMWVhFb284RGlTRmFwNzJpWDBv?=
 =?utf-8?B?WGVEVE1hbFVxVkZVVkt2b29tU2hRVWtzKzBnMG51akY0c2kza1V4VDBTVFVx?=
 =?utf-8?B?ZDk4a09TRVZRR0V0SDVFMnMwNDM3QWtyMzZnS1pjQk9LNkRaVFJ1V3E0d3c2?=
 =?utf-8?B?R0dyWmV0aHJtS1RhRWFXd0xCY3dsVGpQNXduRkwraExLdzdWM21YYnBrclpm?=
 =?utf-8?B?ZjF6RUJjSDJudVBtd200SFF6WUtCbEthM1NqMGczdTh4U3dsT2lIT3d2bk9Q?=
 =?utf-8?B?a2dEN2doaSs0Q0pkdDBxTitpTS91b1Y1S2o5Q2xFOW0rdkFxUVVCT05KaHBq?=
 =?utf-8?B?Z0d3YlpZNVFBanMySlRhMFJkYk1TOHBYRmlMMTE4MFZnMjVNTEV4eitFZTl1?=
 =?utf-8?B?T2ZsZzdqQlZRd0YxOS9IeHdXWFZ3cU1sbWhKWUZmanQxNVQyRTRNTWpzNWpa?=
 =?utf-8?B?a1NvY1BQUVp1QXA3T2IrVEgrUTcrS3ZoVDRsTU5PYW56Wk9OMlByc2xmazhu?=
 =?utf-8?B?VElQdHplL1VmdHJBYUsrM2JDaFpESVdvQXptbStLU2xCMW0zL29DN3FZU3lu?=
 =?utf-8?B?RXQ4ZHNDcld0OTZ5REZsZXFHZWtPd3JUY1J3Mk1VRk4zeDhENW5ldnBNOTdH?=
 =?utf-8?B?Q2FKaW14NTk5SGlLQVhpV1J0OVJESnFnT3AwN1BNTDl1T2hQeDdhUmxhTTAz?=
 =?utf-8?B?QUJSSEZsaTNGSjZrZnBwcm4wYWk2N3I3V010SjhzcDdBYTNQZ0IxYVkwSTFP?=
 =?utf-8?B?QW5CWm9zQ3dPNk1GQ013ZGp6VXdrZWdZaituS25iTjBZTHNJekh1QkpRcHVY?=
 =?utf-8?B?azkvNkVmbDlpY0lyZFBiV0VpNmQ4VGkzQ2tsQVVFWTJaV05iVmJtL3RHaFRT?=
 =?utf-8?B?UFNETlZQVVR4ZnFZNGdacFdhanpTVm9USG0way9DdnpVV0xRM0xGaHNBTkpY?=
 =?utf-8?B?empwTHVCV2dvZU9qcmk0Um9JdXpYdHZ2QXBERU1XSzlWSGdnNXZ1NlpxSmZ5?=
 =?utf-8?B?RSsvNE4xdDIybmhLSFBkMjd4eXFyb1pYMFRUUm9nNDk5cG1ET1I5dTRjSmhM?=
 =?utf-8?B?N1V4Z1BUZ3pReFllL3Z4d0xoQ1dIbXZEcFRaWU92ZmtVZTlWOFJiYkxmdElL?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d7f098-9745-4525-d2b5-08dcc12a86ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:12:37.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8wjzy0diP3mt74tvUvrTmqCwMJz1vTgr9b06FzpzwTXqfvtRjKx05ScA9NPiaetrnDYQmLsABfXln1kwXecz19q+EB11I6WOZVJhcQgBDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4569
X-OriginatorOrg: intel.com

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Tue, 20 Aug 2024 15:19:13 +0800

> leads to regression on VM with the sysctl value of:

Where's the beginning of the sentence? You mean, "This overflow leads"?

> 
> - net.core.high_order_alloc_disable=1

This `- ` can be removed - at least some syntax highlighters color it in
red :D

But I think you can just drop this reference to
high_order_alloc_disable. Just write that if the backing page is
order-0, then this happens.

> 
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
> 
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> the first buffer of the frag is affected.
> 
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>  	void *buf, *head;
>  	dma_addr_t addr;
>  
> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -		return NULL;
> -
>  	head = page_address(alloc_frag->page);
>  
>  	dma = head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	len = SKB_DATA_ALIGN(len) +
>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +		return -ENOMEM;

Why did you move this call into the call sites?

> +
>  	buf = virtnet_rq_alloc(rq, len, gfp);
>  	if (unlikely(!buf))
>  		return -ENOMEM;
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	 */
>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>  
> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +		return -ENOMEM;
> +
> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> +		len -= sizeof(struct virtnet_rq_dma);
> +
>  	buf = virtnet_rq_alloc(rq, len + room, gfp);

`len + room` is referenced 3 times here, perhaps is worth a variable?

Is it fine that you decrease @len here?

>  	if (unlikely(!buf))
>  		return -ENOMEM;

Thanks,
Olek

