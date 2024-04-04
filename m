Return-Path: <netdev+bounces-84945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290E898C09
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34521C2296E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA612AAF8;
	Thu,  4 Apr 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eilay54I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1957582D90
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247758; cv=fail; b=Zin/i5mk2nkJyl8rqauvH9V6l8P8xmgRKwsm7zLLcUmvDEyBD5Sbjj93pI3oFDLOCuMyT+5FsJitzW/TVOEAfJfH8UlTbNojF3qZfF5NeCQKfUv26/dyS3kQdSFcj54kHO7C+AP+0eQgXsgHwGjgmxnm0Mg8o6Sk3lB6sx9ZZ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247758; c=relaxed/simple;
	bh=QyzLBQOZU//gHF8sJL5ELHN4cePc2/T/FDRtTSSAS/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X5SH2qb6o9YeCgGwGtirL3dGuwwenszHjmTpWsUuSZyH5eVPu6ag/tUs+c2QnVwdZSHSizOaf2bYWWbOACYsVug8j4hdaBYYBE1Cy1NpDMFiXjdMcTgC3b8uslBkiUazuETmA2x9I07DvPfDAusUCDqpsJKUkIRDMURaKXVJY8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eilay54I; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712247756; x=1743783756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QyzLBQOZU//gHF8sJL5ELHN4cePc2/T/FDRtTSSAS/s=;
  b=eilay54INHEDkdO2GOmKnjBeTSwdRTwb6Z2AJMAtyS7D1oRB9f1pFrnt
   VgsVThkYJQlCF6+B1cE/ijlLcFQad2RWeeEirkPO5dQg1EsMFPUrMAOKY
   p2c3GHE8GGFd8NvHpY6dEXI3643UoOdWhj3Q9KMqreQgBnQdErbm6i5to
   kq+qOD2VmkBeRbjGaiI63DCvneW+zYfCSTd6yWX/4p5qfvhfd9E0VxKix
   dI5xRkLDDGg0vCgYQMOaziNEu1d/c91Ys37NUS13H4lYMq1ReCLmXgBqn
   GRbX+ak3EGlmeqxRH8YPMTzV024grpTQs0fhmJHGyNokOvMwUrFYwLHE8
   A==;
X-CSE-ConnectionGUID: UG5Oo1ItSeyHTPvr4qK8DQ==
X-CSE-MsgGUID: bF6U4xgSQGmiPq2rFRszeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18104895"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18104895"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 09:22:35 -0700
X-CSE-ConnectionGUID: XBAG9Zt+Q0SOT1uxQaIrrg==
X-CSE-MsgGUID: wQW6fk5SQcy6hNDedDBUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23336778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 09:22:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 09:22:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 09:22:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 09:22:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kihp5kT9EX9bJJCsjHwignMDz77JsM9XAF4coXhrLSOircDnPQvomunCLS1EWuodV5gX54gsSZw/YkmcMrj8Hv35yKJrqJwfhl/zcqYHP8PJevX7EHLXmIVT2VcKVpXO84kgGDj8PLHhf03NNN0jYTY/puhKlWCiu3Q3LmgHzgn2HD4IMd1sFBR1pxSvDU2pggtwg7SDc2fEFNS62j01DQbCAwTuvonn4Tcene4l4mCTRwCwfUcuVmeqZLhVBOgDJ+TGqBfLFoNgio6OqNnic7mOV45iCeDHdoba2IckAHjmIRszqcmhc/phLXi9g/ClxYVJekO+q8DP2pkAhMsvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PffW/gGU7jE7rHJhqfDq7MhmK2IwhFqyjxkkrjPMo5E=;
 b=MxWmtIg3HgKj6oj+jhKbko1plRCp6vErORtVHCdubYl9bsN1whe7rpbkC7C/XtMnyHAMioKI/lP874ulVStnLnsrpoCGJ0IFkAG77moY/urTsK2fY5xWsVgt4+gFOIFIRGVZa4BD4BfHLz8Hp/b5izAO1YNKwlaWr4eFrYPsZHORgt9RueeLZqzkSaK6AwupYQEl4DkokY7Wu60Fmpb0JCt81kCqJGa49GVH0/QwGk6YE4JIezjONQUtiQns61Mst5Nv8gEWvJa8hABLXG6UvXG5ddUxAc8I4T6YtlNn+QOFipyMpkaIySxChb1gDCEXzSUkOBJwHyJ5xspbNnNaZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 16:22:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 16:22:31 +0000
Message-ID: <e58fe273-1d6a-41e8-9e19-ac968fce241f@intel.com>
Date: Thu, 4 Apr 2024 18:21:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1] pfcp: avoid copy warning by simplifing code
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, Arnd Bergmann <arnd@arndb.de>
References: <20240404135721.647474-1-michal.swiatkowski@linux.intel.com>
 <Zg6yMB/3w4EBQVDm@mev-dev> <20240404075924.24c4fdec@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240404075924.24c4fdec@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNfObFtIsk6AJKj8UKYRZIyTJcAgp/hhWUt++pfHIKpDV31tggpnb732YAyy4Vp9x1qJxjBMxP2blJglTeO+t0Qw+dogigaJjFFKTll7CAbmmebo34qiEZPgHzZiYruh1nVyCJWGOe67TY4O325RkPukt0eTaPedqRGpXCYEPJ9alkgnN9ybrmVu9s7gm7ijdWMYAXo4aJm9pps/ZDHP9xCV7rppnpnix/+ySf5oyaKymZmyOSbcY18tg0iHVqhj0w8HA/a5M5b5hnSbR4Ryee+eAaEVOj+xxaH6DBR2MO/MNfv7LSMLUVLy51zUtciBSKXU8PjTKNwn9I3AcL+Vm5iK2fFS2jyJ2ooTihe+geddbmwzMIMPSqlq5EGbpOzNr8XrMbNYknNQwMqAgt3quRsLYZDsJHTtA2sT9AxILnc5CDSSvV9GByjn6DCm3nBIxHeVBFDZL/TXOm0u9du4g2Q2wkdSVkz/bUwVrOC9Ez1NbSusqmGAfrT/NyNOP7L71F4JamNjsZ+eJCuHQhnRyx4u9a5cVsAVKC3vDTkDVC+UeZfRchPdKziYhWgQi/ZiGjMEzYwE4GaQoVedcU0KmUCEy3Pn9ok4Vp9GpCFGgF62avZn+KiaFUCfVN65bACwtjB54NxFa+CQ2WMGssw7TnA7O7rJmwzdQLeKyWYRM0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdRUWM3VWYzZmM5QkFFakEyNmsyTXRxV1paNkU2eUgzUzJjZitBcm9lSVU4?=
 =?utf-8?B?Q2RYK29zRFVrb2p0SldGNGs4VmhZalJac1FiZHJnTUxIaloxZUJzMEJCbjFr?=
 =?utf-8?B?cFRUc0tZcTdQcStzVUNBOUltMUNNS1lGRGFzemQ0Nnp5dng0bGwvZjFCeUpW?=
 =?utf-8?B?MXBDNTFHd2RIVTd4ajBQT2tLSllTYm9JTWRKb1ZrNXUxTU83YlB1ZHo1b0ZS?=
 =?utf-8?B?YXlGZ2ZTcWJiLzFVTnY3bzh0a3krSHNzc0JNYWtzcTB4cXU1MDQvZTdQcUYw?=
 =?utf-8?B?bEVDaGFwd0tJVlpSV0c1NWx0VlJSVjJwK1pic2oxRDI4UXdlc3pway9GbCtK?=
 =?utf-8?B?eWRoMXlUd0RYY1laMzFDeUcrdi9EbUwxV01HNUlnQVYxZktKdDVLNmxFeGt0?=
 =?utf-8?B?RTdpTHZZVmhEa0dqS1NHMVd5SlBnVlh1Z1YyM0QxZ2hYenVseXNwcmtpZmNJ?=
 =?utf-8?B?VE4rTCthQ2JIYW5UY3IxU1JBOTRQYzN2Z1dxOTE5c05kUUw0cGtYcURjamk3?=
 =?utf-8?B?Wm4zRXFZcm52ZStGZzhMbDFIbDVab3FhaU1Gazk4VmRweHE2N1pzNGlocWgv?=
 =?utf-8?B?RlRZcXZnSWVMTnNHbndpTEU5eUJ6NlNSOXJ0dmtXWVFNZGU3MWxuL3B1WmxG?=
 =?utf-8?B?dXNHS0c0MTBDNG5YTmY0YjE1UHFaQ0hZcDBhallxRWxvdGNxOGZUc3NIWUZ0?=
 =?utf-8?B?eVJNSHdOTEh4c05YODlhR1NKd3IxYkV3S3RJaTQzZUgyY3pSamNCbnRscjdV?=
 =?utf-8?B?Z3V5c1RFTVBXUEVyNW5pM3NTUyszV0JHbjJORWFia21lMW03OXFIMzJ3VHV4?=
 =?utf-8?B?VStTc3k0Tmk0NFgvL2RCRmpnTmN4K29uZjlJYUo3YzZHeWhabWtHZUhzaUpP?=
 =?utf-8?B?MW4xVkExNnZWcFZSWmNOUjFydzduZU9pd09IMkMvTzNTNDlrQUhvTHJQdW4y?=
 =?utf-8?B?VFRBNXp6amU0ODBaWCs0UVFqRWNkcjZxb0NJOWpqd0VhOUhkOTBoVzNuUzRM?=
 =?utf-8?B?Z2F0Wk1vWkYwRUZ3Z3h1ZFJBZXA2UkZLNE5hV1p6K0hvTDJCY3VVQmtYdERW?=
 =?utf-8?B?Zyt1My9yYWFJMGpDdXhOZTN6VlRUTzJmZGxnNU1NdXpJRjhyMXVBVnUwT2li?=
 =?utf-8?B?OFNIampDdnU4ZE1qYjVMUnM5NUZWNnFwaHJ0VE8yQ1ppdVI3T212dVYzdkNw?=
 =?utf-8?B?a0lkZzhlRDdzakRQbXE2VW0wT3J2WWxyMVVwR1JiQnI3TjNtWnRCaGJKZWNa?=
 =?utf-8?B?S1Y1T0s3NTJoejJtZXpvcDliNDRXTnNmSXRISmREMEpVc2dMWFlGbUZ2Tkp6?=
 =?utf-8?B?ZkVzZkx3dlBadGFROWd3YkRpb0Ixak9aWVJROEp2ZG5VcGo2SHROQ3FzNVZu?=
 =?utf-8?B?a2dJSUtrQ0NoOE42TzVVZGduMGdRMklwbjB6YUIzdThlc21LTHNyWW04SFFK?=
 =?utf-8?B?emxuK0kreGpRRG9lTHFDV2Qxa0xiK1lxSlhCRjJoWTJ6RnBFZ3RubGM4SXor?=
 =?utf-8?B?eDNoeHRCamE0ek9qT1RIRWtYcmtCNkxEOE4xUWZMekp0NVlBV2lKYkN6a1RJ?=
 =?utf-8?B?ZGllMm1uVHBQSWFLaDVpTjRXTnEyenJlMkFURmhCdzRLZTNjOWh4SjNLMlJL?=
 =?utf-8?B?SnlDZG1maFEyaU5SWnUvRmJMRG5ZQUxOZ0JZL1JUcnU5ODhvWTk0RUExTENs?=
 =?utf-8?B?eUpWQnh0WkxjVHhIbnV2blBZdlFoU3BxRXpQZFJncHZMaTVPYmo0OE1lV2VG?=
 =?utf-8?B?b1ZVcXFzRWtrM0p4K2Y5alBuS1hNMk9aczdxS2Q2b00reHVwVUVSc0IyVjB1?=
 =?utf-8?B?WUQ5MlM0cWhYZ1RsM1k2eFMwem1TY2YzRCs4cE9VRWFwaGtlWEgwOE9CUzZL?=
 =?utf-8?B?dVg2S3RyU3JreDNnRVJXNmVNek41ZkIwa3JTN2FyaVZJUExuV1RSMzFRbndu?=
 =?utf-8?B?ZkJYRzQwMUVrVnFVZzlUY3ZockdxaWY1N2d5cTdDUlpVV1hTYXB4bEVzR2hK?=
 =?utf-8?B?aHJ1U3NNNzhFSnJTOGRFZVE0TFU0Qy8yMDMrWnhSMHFEdjRwc2lvT2I3K2pq?=
 =?utf-8?B?dlplY2s3NS9HSEQwU2xyU1lsK3UvelY4T00vbHBtLy9FQ0UvRC83VEdkaVRs?=
 =?utf-8?B?T3AwUEJ5REtrVmxwaWRXUUVBWnNkVTZ4MDNnY3MweGUzV0crT3phM1NJUFdh?=
 =?utf-8?Q?N/lGLVmjyjQVIkeM6n+vVRM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 344d74bf-b847-49e8-d43d-08dc54c36d86
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 16:22:31.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W6K7PotpY4sYoun//qpoNImv5Rx7lTnnNkhJ1xK21EjDyg+OMdGIPaKvUKiaWnFH7clPNAQeqWzrhKH8wwMbikCYld6dyVy2CcHSdnAo2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 4 Apr 2024 07:59:24 -0700

> On Thu, 4 Apr 2024 15:59:12 +0200 Michal Swiatkowski wrote:
>> Ehh, sorry, misstype in netdev ccing
>> CC: netdev@vger.kernel.org
> 
> You gotta resend, feel free to do so right away, just keep Arnd's ack.

Also pls include "Fixes:" tag at the top and "Closes:" with the link to
the original report right after Reported-by (see `checkpatch --strict`
output).

Thanks,
Olek

