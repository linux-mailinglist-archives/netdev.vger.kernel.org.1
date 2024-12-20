Return-Path: <netdev+bounces-153711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758669F94E1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADA21656B9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3621570F;
	Fri, 20 Dec 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVajUWYx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD91A83ED
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706248; cv=fail; b=oC8r/vgxoUdNYJudZJkMUP2OpXXfwAwIFUyfemuKBzFxCPAuL7OXjC/f/JMEr5dhor9EGJTMnLuxz4QMCpjpdavyEJJHWF/DCntCunRzDBYmFWm9ItJuuL6oII++AqgI5Z/1ySb3ih5JgJMIjbbZMEvbbYzrJLZUzshoELwLLcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706248; c=relaxed/simple;
	bh=BbY2I6l4RwjCQym/TlJvAtA/egwx1S3JaQixcs3+NC0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JG81dcBqrLINp5C9700RcAdwbzLOZ/XUMWUW0xLhPeNd8SV9mYchuFeaLiJHWyf2gLgO7DDfQkkaZH2bR7LL/jKNEXAII3CZdVogt9nWJvFAJDi1KyitV8vNPdB1NvUkWiKSYDJwek3H2ZA4/9qSB2hTqdkk1UJOiElSmDn7LNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVajUWYx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734706247; x=1766242247;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BbY2I6l4RwjCQym/TlJvAtA/egwx1S3JaQixcs3+NC0=;
  b=NVajUWYxbezvjOLuwR1fBo+v0nSPvpRcIBjduhUmBqdDiBPpd+Zs+Iyd
   MjR3wlvhTjqyURXl1EKbEVNWpoJaOpxcFkYv+qOwaaDp5iI7W+k69QLIM
   fvx8HhJScrINj5Sdwe/GHb9XGG85d+Fevq7TRKuag2Zu4knCJ4vqpgrND
   4XA62c8PqEnjJITZxQ5L1+BHhrbcIecT/Tu2uzQKktbGe6nRK6yi6L5hk
   bAWe1uM0f5D8SKoW4/nHaX7894qgsSKYivtuiAWRFIysAOoYLa0WkFv5v
   JRDrve+65Nz4SijIZUAO4IdJaa9aA/+dbNX+CgQ8GWxNggo/0N9lzQT5N
   A==;
X-CSE-ConnectionGUID: 6euUi8++Q22DhYkY8GVknA==
X-CSE-MsgGUID: Vrt08Bf2RF6NQhlu7mV80g==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35473158"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35473158"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:50:46 -0800
X-CSE-ConnectionGUID: QQEYhGQmS1KpBhlHrZDCSg==
X-CSE-MsgGUID: fYIrtLmPTJavX67IyPXBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98592323"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 06:50:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 06:50:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 06:50:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 06:50:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtiyAIQpUV6K000kD7KcaoXyshwGfETTLjG5S8hcEgitDokQXbjTUgE93CavoZiM4rcHOjxArSNct32orBaJZAl8kCzt+WhoO26k7c/Gx9Sb4wJCmScrPJVPww7XWhYdWZLKzV0M5zj9z58Mca9GQDxpxzZc91C5jGWu4p5vyRby7R0RP2zJ/IrZuwtyJ9plXw0fhMalppBqXqnJcv5N8dAN6QcludqO8H6y39LwwlULikClJHyWkFdgPY8ap0swsyPsUG4pPEtGPW+RFmV6e1Meh/GYUoneOVI+Ewq5HBdFXA5FKoj84zfV3ZqzvxfvqsvWYe/pI27tnY4IHYAmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjUqwHtUuPyz7Qi/meLy/bMO5QdCXMdDmbA03V+Q5b4=;
 b=nsCmpWmgzrpayfmho3ZY3MVlat+h4VTtpolZcUc7838tlJMTDpqvpIkwpVEhQiz8ywk8v1KQCV2SlHqYHTBtYR7qBQ1i+sSrp7sh0LfEnKCaN4rqdzV1pLdqU9uz5cN746gD3pKq/xadaCJIGXRdX8r0USsyQ0QMRUU9yymKMzR2tmAw787Q/ejc+60oUDgkeB0wZTo0mBF/3IGDIl+1P/J0gJv25F4pWoaylRHjWWQSnpX5sxfB1Nzr9ynsybW8osEfuCEYhHl/PqnEK/qsnXirSCdwmYPBCswZIPNqSVnTgV7qFUVUXbKNxH0+eUUKs4fCJSh5JKz9s67g4x0uVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 20 Dec
 2024 14:50:43 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::b8ba:be35:3903:118f%7]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:50:43 +0000
Message-ID: <9e724101-bdef-4c14-926b-6e85722d8bee@intel.com>
Date: Fri, 20 Dec 2024 07:50:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: napi: add irq_flags to napi struct
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<jdamato@fastly.com>, <shayd@nvidia.com>, <akpm@linux-foundation.org>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
 <20241218165843.744647-2-ahmed.zaki@intel.com>
 <20241219193403.10a52305@kernel.org>
Content-Language: en-US
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20241219193403.10a52305@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SA2PR11MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 364c1582-3427-4cf9-06f3-08dd2105adb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVJ2aVViWDJzdHlDNi9IS0pEaCt6MnRibkM0Tjhqc0VKLzlKNHR6cXNWaG8v?=
 =?utf-8?B?bWNhdVAyWHdoa1ZpVE5pVWcyR01TYkExVGt6N3pFSXhNS1EzV2FSemJhaks1?=
 =?utf-8?B?cjd5UUoyaE91NzhwVUZoSDVuSThnWTA3R3ErVkNYWk5ucEp0THBzWEcxTi83?=
 =?utf-8?B?QjJlenlROVVrOVBEZkphME9xY09OR0FaNXVGeUgyR1VmNVhTSGM1OHRhRUE2?=
 =?utf-8?B?UVltaUJNc3V2WVpvNHc5N3VzUk1CTTV0alVHZndhUDlFa1Myb1lBOXFVeVJN?=
 =?utf-8?B?R28ydHRFN3NISU9YQUpWQWdvQ3RVUWxJd1plMU1qZEg2cldnRzJjSzJyeFlE?=
 =?utf-8?B?ekdiL0ZtRXJ3dGZ3dzdjWGQ2dzdIREdIS1pSYTVuQmNBdXN4dlExbzZ3L29V?=
 =?utf-8?B?Wm4rU3k4OXRuTWpGdWNHb3NPOVc1Tk03VW1iVmJYSGt2bzk0OEcvUTN6TzRt?=
 =?utf-8?B?eGhMcXhwMUpMUnJ4YnJaNEZQVW15ZVVBZkxEMGdjRzVnRDBrQ3ZaVy84czRM?=
 =?utf-8?B?ZEMzMThVRmhNK3FCMTRUSklrQUdCZEhzcGhNbXArVlNhb0hUSWpWMVQxc05r?=
 =?utf-8?B?T3NQVmVlOVNaRFFNdXJjR0lVd1k3S1RxeTVIbC9neXlIM0xiZnRQWHN5YmN5?=
 =?utf-8?B?V0I2VEZSaTNsVDJUTkNRTVFTQWFHcFA5dHAvMWRGakVqR1FQbkFaUWROYU91?=
 =?utf-8?B?b3VFUzd1d3cvREk2c2E3UnJvT3ZKaTZpcHk3L2wvZzZzRUhCejYwczZsWjZH?=
 =?utf-8?B?ZURzM2dnUWN5Z3gyYkNHczhDeWRZZnAyMzVxejZXY2U1RTNUZFRRclFvNGx6?=
 =?utf-8?B?cFJZZ05Ca2NBK3NUandDOSt3dWo2QnpwWVA0OEtxQXh5Ti9YMUFWcWl4cGVh?=
 =?utf-8?B?Q096ekxnSG41VGRoeWNlWnZtcitDclE5b1ZwY3JwQzZYbk1vRjVKOFB6TjRy?=
 =?utf-8?B?aDNzUEFSMXNvZjVvcGpRNStOKzB5Ukp5TGJyUUFmWlkzM2Z3RmFRNm9uT2Rt?=
 =?utf-8?B?b3RXY0JjV3dJZHRzZVYzU2NWQ0ZQdHoxQ2V6ZlBSaXlWMjlTRVkxOVdNdnZV?=
 =?utf-8?B?YXBMS08zMVNxL3pkNDV3V1krR1EyT09mSnYzVjQ4OFJVNktoQ2lObzdFbkFT?=
 =?utf-8?B?Y2hzRHkrL1FoVGc2cnNZandjajRPaW5xeFVobUo0czhHczZzVGxqZkhFSU1B?=
 =?utf-8?B?ZDVGRHplVXR6a2NXeDNsVUtHQjBuQnhJZGNCdGR0UXBLdWU2VkRDbzBGTnY1?=
 =?utf-8?B?bFJ4cnJrSFptWFZ1TjdHTmVXZk04TkhyRWR6bGhGMjNDazRVZTBncTBlZ0lZ?=
 =?utf-8?B?OFpqQi9qNzBnMFZ2SFF1Yk5FUWc5ODZBeEZ6dXNNaTdWTHNnUC85ZTFVMlVu?=
 =?utf-8?B?OEljYTFDSlFOTzZNOFY4UjdZN1pYTm5DeTBpU1J4L1JGdFh0WDdhQ1VKb0N4?=
 =?utf-8?B?cy8xOTl4WTV6VmJ5TlMrSGkzSkRLUFJtdmJLNTJxLzE5TzcrTkgyOWZmN1Nl?=
 =?utf-8?B?VzlqdnNWVzRqenlWaDFVbVZIL2RmM1RRdVBvUnNoTjNwZEtmUG5icFZFbDB2?=
 =?utf-8?B?OFlJR0VZWENwNzZramVnNHBMcHhocThLRVU5RnRGcHRqalM1cGhLSG9Uem1r?=
 =?utf-8?B?UFB0L0tqSFlHWS9kMHdYMHpVNGRXVnJCQTFlczdiMmd1cjBHTytFbkx2dzNL?=
 =?utf-8?B?c2FFWFhGK2kxdHhSU3VhWDJINmh1c0t0NVZhQlFUUmozaWRpS24vRjR2UmIw?=
 =?utf-8?B?RXp6RkIzQ1JMRnFMQmVSMXhmVTZqT3ZORGIwZDMzekR4YnlyRTlWQkdTMGc0?=
 =?utf-8?B?ODR2YjJ5aU9xVWtDZlYrdVRtVFRHclJhR3I1a2NiSmd4QTFJQXpGRjNsbXBv?=
 =?utf-8?Q?VbGY4zIhnh7Ni?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJ5emc2VktJUHUzWDYreE9sY3U1ZzVYTTZVczlraERVWUJNZjYwamczaVo3?=
 =?utf-8?B?MFNwUjNPMzJwMnpkYStCUEhmdjBOV093T1RUZHN5Si9LVGhTKytCVHRWeTgz?=
 =?utf-8?B?eUhvMDRKWnp1a3BJdnpQdDBWQjYvNGtpdk0yaG5UQW9VSUNJaTRtWVhWN0Y0?=
 =?utf-8?B?bFp2bitIdVFIclBjeU1wK2dRc3pwNW9xeTRXMlI4aFlDSitYb1JhK0FhdHZN?=
 =?utf-8?B?aittTWNkVDdwa3ZTdmpvZU4zVDlmQjNNTk9vVzJ4L01NTnFyRDIyY3liaDlz?=
 =?utf-8?B?eENESy9kS1hhN0JhakZJcTZvQkQwMDdkL2ZQN3VtQUppMTY2bzRGL1ExR252?=
 =?utf-8?B?dUtlQ3ZJUjJITzRqbENDRW9YcFhEdmtubDRIZzB1MldWWTQ0TEpZZldEeGRE?=
 =?utf-8?B?OGg1TFMxTVA2a3hiUHpsd2lwc1N4L2RCZHJuZjlMekt3MUNZTng5bmsvU2xn?=
 =?utf-8?B?TXVjN2M2OGpuZmlqZ3JjMFV4aUVJeDgrUFJBUnFPMXNOQVJlb25aRU1oZG1p?=
 =?utf-8?B?RWdhMXpJRjM3VWpvUWl5WWJTdGk1a082NVJ1a0NBekN1Wmx3ZUF1Z0h6S2ZO?=
 =?utf-8?B?d00xWDBFdFpmbUhPUUo3eHBxeGxBaGxHTDVpY1EzaFh3cW91c05wUlJYRzRL?=
 =?utf-8?B?Z0trTXRXZ0dSZGNvb0hseERwcDFMSE1waG43VWFMeUh3Tm9LeDdsVFY1SGNx?=
 =?utf-8?B?aEVId0lraWZJWTZkNDBiQ0ZBUHJocjhYUHdPWGVsUlkyVkd1amliVVBjeDV3?=
 =?utf-8?B?aWl0KzZMRWZBaWdPS2NGaUJVOSt1b0VXdHRZOVgwRWorMkViOG5vZE9oZi9I?=
 =?utf-8?B?YjdxeEJ4QlYvTktCenZNcXR1eXhTVXlxNjZNWWt6M1NKTnEyTlJpZ0gzWjRZ?=
 =?utf-8?B?OWxmaVN2V2xGRmdHVlZRV1lwSlVnME1ENHdMY0FUUElqNzBTdFh3dWN1OFRS?=
 =?utf-8?B?MzcwcFF0TG90VHg0bTFJSmwrbDNyQThxTDJSZGRvNVdQbG01WXZuWkpzcHk2?=
 =?utf-8?B?aHQ1dTN3SkhLMk90SXNtU1doNXhiSkxYNHpmdmNlRHJ3WUZEWWpia1pTSEM0?=
 =?utf-8?B?bVd1TnV3T1lQaUNEQWJ0Y09CMTlERDQ1Y21VU2lvdlJLdjVJc0psSW5vdEVQ?=
 =?utf-8?B?Tm9McXNWRzV6WEZycXhudnBsVEtXVVFKVGgveXJpanEzaGRYcm45dU9rZTJp?=
 =?utf-8?B?RzUzYWNwVVJhZzNRT2ZIcldrNE5RUjBJNGVLWEEvQmJRcGUxZ21UOEFSRlht?=
 =?utf-8?B?eWdMOFhINnEwQUxqWkdDcVNSSlhXMUhmYnZqVFVxdEdVUmhmZFhLTzhhLzRJ?=
 =?utf-8?B?Sk5ueVJnZXRlQVk5WG5FMnJXKysxb1VjVDloUlFSNkQySnZ1aURjcFlSZGtN?=
 =?utf-8?B?TXhQN09rSlNaWnA5Y1IraVRhcDl1cUlVeUxIMEpUYTRqY3NiWlIrRWw1Wll5?=
 =?utf-8?B?VEI1NHFxTVZ5MWFMUmtyR1ltQ3B0dndpZ0tjMkNWQ1JTQUtnemFuMkw5bVBD?=
 =?utf-8?B?SGhpMDZPdDlhbzlCajIyUlE3RjNZNkNBYVRlSEtXTzlVc3hxY0R3V094Qk05?=
 =?utf-8?B?RnMyT0tGN0lMTXhFS01YME5VaGJyNE85Ny9LWi9kVWlUVzZkcTZjV094bit3?=
 =?utf-8?B?Z1E1eFd4RHFXcU9JaDhiRVdXTmZzY1NlUUhUN1N2cFhIK1RPUXVIYjlXRW5V?=
 =?utf-8?B?TkxhZTNXSFZpOXVPQ0hQYVJVdXJ2ZG0xSHgyQjdlTzd6cFh6QVVIdWwzdUpZ?=
 =?utf-8?B?VEVWS0hVWm5FTXQ2cVdCZHErSnliQ3VzTG1meVp1ejlqSVlxcks2bXFEL1Nm?=
 =?utf-8?B?UnYycmZ4Zk9taFA1YVo1ZHA4THowL1RucTIwbnVDSnhqYlpqcWdxQXdEcnhv?=
 =?utf-8?B?Y2hoMlZzQjRqVzBJSTAxajVqSUNNelI0NjFiZmFoYTZlb0xETGhEeGh0SDdw?=
 =?utf-8?B?RXFzTGxibzZJUDhwME1KOXpPSFJvQW5YQk5BSjMySU92WWZkKzFQeElIamFK?=
 =?utf-8?B?SXdSYzZETk1weVkzNWZSTVpNaEZscklGK0FRVWFUd0NtN0U4UlBCby8wR0dS?=
 =?utf-8?B?RlhCNW5Sd210TkRHN1h1NG45bEljMGJKRmtyWHIyaWN6UVFESVYvK1pQMUdY?=
 =?utf-8?Q?AwDV0AfRIj4MZ4wZRf1KnRKV+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 364c1582-3427-4cf9-06f3-08dd2105adb8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:50:43.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyThgThmhXYR00Enw9WwQlOpHxiF2lHmhmlRgpvBu8hzm/kl1yJYQJoVBFH/R4ootbbEfNWA60MQQ//0OlixhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com



On 2024-12-19 8:34 p.m., Jakub Kicinski wrote:
> On Wed, 18 Dec 2024 09:58:36 -0700 Ahmed Zaki wrote:
>> Add irq_flags to the napi struct. This will allow the drivers to choose
>> how the core handles the IRQ assigned to the napi via
>> netif_napi_set_irq().
> 
> I haven't read all the code, but I think the flag should be for the
> netdev as a while, not NAPI by NAPI. In fact you can combine it with
> allocating the map, too.
> 
> int netif_enable_cpu_rmap(dev, num_queues)

int netif_enable_cpu_rmap(dev, num_vectors)

> {
> #ifdef CONFIG_RFS_ACCEL
> 	WARN_ON(dev->rx_cpu_rmap);
> 
> 	dev->rx_cpu_rmap = alloc_irq_cpu_rmap(adapter->num_queues);
> 	if ...
> 	
> 	dev->rx_cpu_rmap_auto = 1;
> 	return 0;
> #endif
> }

I was trying to avoid adding an extra function, but since this will 
replace alloc_irq_cpu_rmap() I guess I can try. May be even use

dev->netdev_ops->ndo_rx_flow_steer

instead of dev->rx_cpu_rmap_auto.

I will keep the flag in patch 4 (NAPI_IRQ_AFFINITY) per NAPI since it is 
used in netif_napi_set_irq().

Thanks for the review.

