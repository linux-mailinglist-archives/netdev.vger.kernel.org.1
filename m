Return-Path: <netdev+bounces-280320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH7OK0Vn6GkLKAIAu9opvQ
	(envelope-from <netdev+bounces-280320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337A5442527
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA38730363A2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F0B2D8DC2;
	Wed, 22 Apr 2026 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra6FLud6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754F2BEC43
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838360; cv=fail; b=n6Kojtzo7Zh9HLlOeuiX9FzFGOwiRrQea9apMpAZVOHSZK6ScVCkbhT4m/yD0zeax0UWoHT/V4WQs2IdXyTzyD2Az5MzqePFmxcf68EFlb/Mq64X5uOzOXZGhp3aw9b7/C8bhQWf9GAjWDSCM/dELpWg4gcIJvGO1WRjWrAMido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838360; c=relaxed/simple;
	bh=pmm2dxqXIeMjKgzbFicpTSj8xH32VMDT9hW/Gg+vBDQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hSCV6+QX7hDZSYYOuWBTAQC1ODPcnAl0Caky7JrOBlT0vFlj24wtnYFPbEy/N5L9jvvaSgN1K7zht5M7LUeZd6UP+iCfmCDVwa0xs7wWrbvJip7zYJi18DRe97yPLTS34tFr6qip+QoEgYPdc7bv9PmS2chE/Tdyo7AJ2PyB+Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra6FLud6; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776838358; x=1808374358;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pmm2dxqXIeMjKgzbFicpTSj8xH32VMDT9hW/Gg+vBDQ=;
  b=Ra6FLud6KNVSdmprPHmQrSM9yD8xj49avLhF+Aa+tTUyfh32M57JBcHB
   MomLVak/lbYU+WyNekYxgKYb3N7UNpKbVXDKy3/QX3WZMDK4rpLo2fGsj
   o/6NYezH6X33aH5hWSNLq5FVB4RcFMjwTOE+Ki7M39pu6noVoMgrHWLOa
   bW5pKDxUQED2GGBeiAQAhb/phMA3Y8h945SjtI6TEywf+xt6X322mLq+z
   gz/LJBu22+HoxVn6kdZYx88Ho/J5K6qXudZEDHm+uUN88OrilHNWa9E/r
   BXLW8XsG5kKfr4f9ulIKqxcCGeO0EIvfVYklJNPJkRjY3cNHp9I4yck/o
   g==;
X-CSE-ConnectionGUID: Di0NbsXnTKqowXKF3uC1QA==
X-CSE-MsgGUID: FkhoI8PpSo2IC0Kjwoap3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="103245092"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="103245092"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:12:37 -0700
X-CSE-ConnectionGUID: nS+G9IY4QeyfHOjaEq+o+Q==
X-CSE-MsgGUID: mF8QKGseSv2Hlm1NgDwF2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="236266053"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:12:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 23:12:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 23:12:36 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 23:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqqlfHYTjlq1GjWtTiGn5a8KdBydtjpCravBEGcK33Ge0OHS6nihlKKqkWSxq6K5T9df0WQ8TmSs5DluLbivN5iUGGmsZBb8VBlLvcdikTEpBkJ/gGuFPwc4y6X9Jj57e0PBtiBXZHu37OxtcqRjMn6yjCHAgHbKn26MheGM0jnwKCct8e/3NqBXywlW5/YZBAeRDcZ8FMj0gwUqvRtYzQPw5HSx6Me13ADqlk9C3CoGXovFJ4yitWAPNVcB/0uUMe4b49ALiepoUb81QHst3i7v2mv1SyqfITKHFGcKhFbCHF5Xtt20RCy4KWS8iNUxeXrK3XiYIS29WqRrTFztLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn6D59num8wGK5Me5o8uNenSi11DihRUMX8ZiaOg8JE=;
 b=iC9570fZCi7ZxjjNhcrlwoh02hkZ6usZlsWnxjEZi5rALHNp9N3hypDtQe/4T84XRXa34M/Pc2faxldhnKC68lbU1zovXvIsLhGHY2+tfLdjxv6f1+pRsOUs9qq+yfrhhvy5GqylLp1RQI6je9FzHLe6EJ7mfJriRGAwaD7Vz6PmurvF4kosmR0/N4jI1vr0ptdID/Po6O/qbDuNJUbSVoL+wQmPZ37cESPgR0Q6nTBIYJtXsZUMwz92X9XB+6PMSqTNKGR9O4bGPxrPFXfbSBifQ2OgtKoGP5CpmHGRm0vH6dolbtYlL+sFnnIudsWO8CHf5FhSlAmAd879tmvdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 06:12:26 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:12:26 +0000
Message-ID: <663d0ee8-98d6-4f26-ab0f-b3ab44d0fa23@intel.com>
Date: Wed, 22 Apr 2026 11:42:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] drm/ras: Introduce set-error-threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 6756f54c-361c-4492-5aa9-08dea0361fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: reGDn+gDzo+Unt3bBF8FdN91OKZqofPRzhuuDm3bOtw4zlY9/s8yf+hG+iMG+fup+2N2gb/KelloXbx8YQaFS/DOUIBq57UkQdUx0V5XtwYNoMdCk5VxSMjJg3wqj0YK9ezRuccnJsKUbVIvXxEmd5gIKluRp5YMCM5ubdncdU40AJWlRzFjTOnDg3RFNV49bytxoIiwiPBJja+18avS24EM1tgmfk/dxdOVZ95GLq8FZkbIHEkB0puMjKHF34X+CoA0bC1eCYld/N9d2BuvHPmNHCzV5GNLFU4aTf5lomfWLstKucSUzoIlFJW1hiXJluAkQnTqINlsKXNEtskNn7dlTdWmZvfcp+FweFqyM68DKFaooVzG8xLKVjByv/4mc5JRk6Rwg2pz2FBgHJJMc7vNAOY5NJbkMdmMzkfBuMpOMDf04GVt3U8D/hzYF4fOFMub0Na7P4HcCPV3CRYXRAIkMmOxfi7SpRXK7WUzyJvTyMTDjJVzS+guiV8XYqQxvvi4OLLQ/BpGQIYVw58w7JB9BIDV66lbIJDOIl6pfSheaOp45kZO++mDcx8gwIa/hpBh8Wk7MELu/GN3I572SS4+KUL0qLcpQQI30W1ZpCj8b0bp3B0qWQbxwPiwUlvGyxQtByNBNHF2iVxW3zGb0XFrI/NQgGAtLa25+3TErdNjeleao0G4Uw2k1+lhc3Job9ep3in9E+unfIWMFWDjDJNnvlO9605CilXvndZgDzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9ZNVNlM2FSTWJnWTQ5K3NTc1FiNHRQbDFuaFNpMFZNeW9UYVdGakgwa3VC?=
 =?utf-8?B?dktPRE10d3pvR01LN0xDMTNlanNsUmZYZFNjVlB3MkYwRkh3Z3Z0NExxaXhv?=
 =?utf-8?B?L3ppb3EvTWhBTXZyWmw0ajNNVDl6bzVLUmNtUnFCblBsazJFVzdiaEtYaDFs?=
 =?utf-8?B?MklsN3VPeDZ6dmREdFNiK3R3SG1LM1ExYnFCcUJZRVU4S1lEdUZKTFRJNTU0?=
 =?utf-8?B?bVZ6cTcwc1lHWjFwR0V2WG8zU0pIU1VUdnVLaHAwblI1Z28zbFlyL2xrNC94?=
 =?utf-8?B?YzltZ0gyNmNmN2NVcGkrcVc3dGV5aFRqeEpCVjFrWGNwajVzd1lCR2QzWTRW?=
 =?utf-8?B?Z0lFTTErS08xL3dqZ1IrdGcrQTZ6bHFYTWdoanFXVE5YelpFWWxxcXN3RGt6?=
 =?utf-8?B?M2JUelVUSVJlbDhGUmJTczVuYkU2RmpiTWZXZGNYNnpmSlF3TW91bVhtanM3?=
 =?utf-8?B?T29mNUlwUDg2am9LUHpLbndYcHp6cVNydUVZV01zWEpGMU1xYkJDYzVOSzZ4?=
 =?utf-8?B?SlJvRWEyYUR0RUF3aGUrMXZhdVBiY3VlenRJTDYvVE53V21taFZpT0wyTEtN?=
 =?utf-8?B?UGRsZHJRQkd5UWRTTnM2RncxM0NXT29IZUg2N1E3eXFRVXJGQ2pJTloxcVFU?=
 =?utf-8?B?K0FkSlc5RTJreW84bS9VU3JWaVQrUUREdy9yaTBMUVNGMVZWZStidkRRamFX?=
 =?utf-8?B?TWZ6SmRUMmttV003QThybTBURHltOVAzeGt4clVOaXdXUW5OOEx0QUFMZGFv?=
 =?utf-8?B?c2xsKzhuUjFWNGhhRDh2N095dDlWSHNYNE00MjBvdkRHYy9xNktYdUNaV3N2?=
 =?utf-8?B?TEs2VVBRQklXMzArWUVNd1UrZmg1UENQenRwNFBUOTJSVUJEZHFDS3Y2Vmx6?=
 =?utf-8?B?bnlnMUNvUFF1ZW8rTDE1aVZNaVFKeVptSW1ZS0dLWXNPZmN2ckVzcU1mRFVR?=
 =?utf-8?B?SDRQSnRpYkJMVFhvNXZ4RVhwTXpHK3FZbzF0TTRsSFQ0WWowcXlzQXVsMzVE?=
 =?utf-8?B?Q0hCRTcycU51TWFQZi9hejdRT08wL1RBZEtOZVhQS2NyWHJ3VmZTaFB4cUVw?=
 =?utf-8?B?c0NZQXIyTzhScUJXWUtCWjc3TDZoMFpDc0RYQTBDa0JpblJwZmFPMHoyeWpR?=
 =?utf-8?B?Q0pYZEgrL20vdnd0cU1DaU5YaWgwZzZteldyZVBuaWNCRTU2aHpGVzB2V2pw?=
 =?utf-8?B?SzFnRjdzZnF0azF5Z3kwSDVJNGtLaGhvUjUya0JLckd0eEdTemxpY3R5YmV3?=
 =?utf-8?B?elVJL1k1UmdteEVtRWlqcC9ZeE5VdHYwT3diU0ZqY1YvN0JHeFhtaVkyMU5T?=
 =?utf-8?B?bzFaNXZKREtYWTFlbGRoN0dlc3NTQjhwYnBoOVZiaWNKMHdLYVNCSUZib3pT?=
 =?utf-8?B?NXRER2JrWlBxZ2NlU2ZTOXBrQVZPZExXRml5RXc2dXRYeWE5SHlEUi9uZkpI?=
 =?utf-8?B?dzFZc09zU25QZ3B5Z3FFazR2dGFzUDBYekp5d0Z1TnE2Z0FRWG45RzJKOXli?=
 =?utf-8?B?WkFxdGdRb3NhaWc0T2RudGtSQzFtMzFLS3NQeDRGeVhrbW9Hc0U0SUhIMXpC?=
 =?utf-8?B?WGRtdGxkS1FQMnREZWdVbHBpbFQvNUZOYSt6VkVXcmFPa0pMakFveG00UE1S?=
 =?utf-8?B?T0dHeWJaY2xOSkNqN21ZZVVlR1lIa2N4akZDaVl0d1pUdGVLRDVqZktrcjU4?=
 =?utf-8?B?SXhrTFV0d1hXY0oyWGU2R1FPVUtSTXRTZm9abWhjQ0tlWER2dVc4S051WFlG?=
 =?utf-8?B?N3VFNFVnZ2l4clNwRkYzd0FTcjBxWmVTMU9QQkxnVWVwNCtZMkJYMjBJdGlG?=
 =?utf-8?B?MXdvRy95YmFnOHJWczRwaTR4NVhZdzBkSlpxZmxKcFBtSjFJTllCdHlheEdQ?=
 =?utf-8?B?dzJyeUxQNEZUcSs4bHlwL0R6WTYzZEpCeVdDYllMTlZ6WlJwQXpWM0sxZHdI?=
 =?utf-8?B?Z1JxbXhNTE1JcVpCR0IvRnNZTm1OOVNEMjNjdk9TNzMzbWFGVTdiMEJWbzJZ?=
 =?utf-8?B?Yjc4ZEs2a3pZaDk2S2ZKZmc2cktHTnVhbFFLRzBkMXVMZ0h1WTJwY0x5ejJi?=
 =?utf-8?B?UCtpQ1RIZ0VqZEFHQ045cUZRZGNqRUZRRWlZZTBuampiN1p3cXFYaXFQNzVl?=
 =?utf-8?B?NWdZRlVNUVlxcjg2Zm5NVHV4Z0dwTVBqZ3BIbnZ0ZDlVVEluZW4wWWxDOWFR?=
 =?utf-8?B?SGNBVTNCcWg3cmY1VUl6VjR3Z3ROc3FjOC8wcFBCZXJHN2JtWFdJR3o5ZHlB?=
 =?utf-8?B?eEJiVzVUL1lPRkxnWmhBN1loSzFkd3ZGZnZVdG1TZkw5dlFWYWZBRVlmQXZZ?=
 =?utf-8?B?VmU0ZzRTZjJ6ZHVSNHNNeTVQQk96aXU0UWR6Zkhib0grSGpOSUJsUT09?=
X-Exchange-RoutingPolicyChecked: QB0u6v7bXmUd6yG7dTxFitVATzE0i7qkpTm7uY6OQnOcXGuP7gtLQ0U5yrEfqM+eh2Z8jiR90yD/5Smm5dunGw4v/T79a7VRMvd8ajkXVncwozS/+4EzuEyL5NaniTA/Y6LxagSWOX0cdwxaqYLYKyA1igG+r/5GINueR3j+OvV/BXx5ZB6vTJBoxOtH3f+IM32EMClSvD4kCA+7iVlQfpkWBWXmFZq6xSRTD7Qo95N6Ri20sp6nswEGu4kMAb1SOwWMfwm+XtD5u99MvmCovMYGg5hdO8u7HFMZTeOUjPYpWjwRv+FU4A81xlhjq5cxnmTpXWIxz+NzoD5zLfEZOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6756f54c-361c-4492-5aa9-08dea0361fd0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:12:26.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I33caQddmiijf4ZZOJNszImuzWl+BI5wU2K936s6/Ic4Jf2uwXgrZmgRX0bBXQnXltzgrVqy7ktnBX8p7/QO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-280320-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 337A5442527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> Add set-error-threshold command support which allows setting threshold
> value of the error. Threshold in RAS context means the number of errors
> the hardware is expected to accumulate before it raises them to software.
> This is to have a fine grained control over error notifications that are
> raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   Documentation/gpu/drm-ras.rst            |  9 +++++
>   Documentation/netlink/specs/drm_ras.yaml | 12 ++++++
>   drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             | 14 +++++++
>   drivers/gpu/drm/drm_ras_nl.h             |  2 +
>   include/drm/drm_ras.h                    | 13 +++++++
>   include/uapi/drm/drm_ras.h               |  1 +
>   7 files changed, 99 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 6443dfd1677f..a819aa150604 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -54,6 +54,8 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Query specific error threshold value with the ``get-error-threshold`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Set specific error threshold value with the ``set-error-threshold`` command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -109,3 +111,10 @@ Example: Query threshold value of a given error
>   
>       sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
>       {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 0}
> +
> +Example: Set threshold value of a given error
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 95a939fb987d..09824309cdff 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -150,3 +150,15 @@ operations:
>               - error-id
>               - error-name
>               - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set threshold value of the error.
> +      attribute-set: error-threshold-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d2d853d5d69c..e4ff6d87f824 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,9 @@
>    *    Userspace must provide Node ID and Error ID.
>    *    Returns the threshold value of a specific error.
>    *
> + * 4. SET_ERROR_THRESHOLD: Set threshold value of the error.
> + *    Userspace must provide Node ID, Error ID and Threshold value to be set.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -72,6 +75,8 @@
>    *   operation, fetching a counter value from a specific node.
>    * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
>    *   operation, fetching the threshold value of a specific error.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> + *   operation, setting the threshold value of a specific error.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -184,6 +189,21 @@ static int get_node_error_threshold(u32 node_id, u32 error_id,
>   	return node->query_error_threshold(node, error_id, name, value);
>   }
>   
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 value)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->set_error_threshold)
> +		return -ENOENT;

Use -EOPNOTSUPP for absence of function

> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, value);
> +}
> +
>   static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   				   const char *error_name, u32 value)
>   {
> @@ -417,6 +437,34 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>   	return doit_reply_threshold_value(info, node_id, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set threshold value of the error
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the node ID, error ID and threshold value from the netlink attributes
> + * and sets the threshold of the corresponding error.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +				      struct genl_info *info)
> +{
> +	u32 node_id, error_id, value;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID]);
> +	value = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD]);

do we need a check for max threshold here? Probably configured by drivers?
Or is it upto the driver to check? If its upto the driver, please add it 
in the document

Thanks
Riana

> +
> +	return set_node_error_threshold(node_id, error_id, value);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index 48e231734f4d..8b202d773dac 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,13 @@ static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_E
>   	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD + 1] = {
> +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -56,6 +63,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_set_error_threshold_doit,
> +		.policy		= drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 540fe22e2312..9db7f5d00201 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
>   int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
>   					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 50cee70bd065..7a69821b8b78 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -71,6 +71,19 @@ struct drm_ras_node {
>   	 */
>   	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
>   				     const char **name, u32 *val);
> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set threshold value of a specific
> +	 * error.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_id
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				   u32 val);
>   
>   	/** @priv: Driver private data */
>   	void *priv;
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 49c5ca497d73..8ff0311d0d63 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -52,6 +52,7 @@ enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

