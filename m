Return-Path: <netdev+bounces-217210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DDFB37C29
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F1F7B632C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EB6F06A;
	Wed, 27 Aug 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K680ag86"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC11E9B12
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756280844; cv=fail; b=W02ZE1KUP1uBHB14QMWSj/fh2DSsq1zGVhJwKnlaBKQG/J3/O1biCqczm+LUVPs5TwiDsEGXuIVMsYw3VvrrUmthvaCmIVvr1d1gZ0zDknqkt1uyPBTiLJogAiNbo3c8bn5kP1yobuWOccpjRbfY7DQMY3n/KsRmaR4U6Vjvm1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756280844; c=relaxed/simple;
	bh=FAt9ZyJAlvNopMzDKC1YF7aW4I76wFLXLE/RnjqjEL8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4734pTl14/Amy11hePPWDJDC3DK60K/P/gIaOM4JsffdxdxLuWMDyxCg9foKzYuvbisGzjRGZpYEYzyLSt1smEVonkKDSVT+7j9RcYcxzNwrERqJg3+GzNSfcoSKTaM3JwrxhnKZVP5IlXNxV2c9ggrvKAnP867LRHJrwPwuBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K680ag86; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756280843; x=1787816843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAt9ZyJAlvNopMzDKC1YF7aW4I76wFLXLE/RnjqjEL8=;
  b=K680ag86r3tvsYVUz9YxjoHyMuJEMsYhbKauI5bZ6xv9xuKY3+gbPi5t
   iBrzOMiUAXx3xjdR/1o9v1Ti7vwB9TSqM6/ci1N1yGlGx32Li8MC0aLPI
   yYlY34Zd9JHNJAqVme3U6fnV8zPVLdnp2ZawPeAYDU87oLdKUIki3+gMd
   zRRuSdODQR+d3d4d6ELYgPbbAmp/nH9p0c860zSmCvChb4DkpYXg6XOzN
   SexocCWhfjXo427IXJnvK+Um9CS2oBx5umvFwZDny5uAHvyycp+hxl3bR
   +0mk+GoddZrA/KdhVaZr86nJUg9/pvyagmFpqSIdH2564Dto29dlBK9Tw
   A==;
X-CSE-ConnectionGUID: rP0J4MHDSMmkKHrxA2pWvA==
X-CSE-MsgGUID: pn7i15sKSByYduDN5sYNwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58625469"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58625469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 00:47:21 -0700
X-CSE-ConnectionGUID: Xp7NHUCwTI2syjUQiKc1ZA==
X-CSE-MsgGUID: zfft1rEvRHqLFk7uyxgGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200668340"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 00:47:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:47:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 00:47:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.79) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkOsLPQMn521RFbCmerXSDf536/1BKx47RUPFX/WwtEJ5Z9QlnNJKxcq4LtQrhLQcsUa0oQAI5U+ppEtTCeaCDq51/gj2p8YfStrPLcuhZXAqwHCywzEpCr0Wpqqyb4IOmyTCJ/weB7FaV4MHzJSheNEJm0Nz6/DyYtViiQyWtHG8ga2ED9xLuf8aD8poDuxcRme5tofymq+kELQq+O0mMl7J356ka6KTaYdjmsL5DSSfQPT0yu5dk3bzhYqPy9aH0fmhABIW3b7WB/3OUygPVdknJVJ+lmMQhYkB7QA4sv9ZUH5+u9Jxcw2cxCRB1v4V2ZhiHOq/3FfM3BH61wn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2di84LzGXtaSaXStJGffsoiXYwDAQQPsKteU9Lb//po=;
 b=krZhtxPlTyFXJ8/GH7RT4qri/eDkDJmAb6fFqerywienEyMHGpr84HaiugGPzEmzYA2ZcxMJBbWFOv7WQyErFiS8VpdRbmpwQckdABxAcDEmyUcBGbMDLHgAp5VSgeAkzO8UmcmsxFIsU3+za2wyg1cRNBZq2FV8NnUPHtKwAnw7HyfA1DJLMhyv7w8rACTBZ5blR7EKcihGhDr3fqrn3lxm8A0ybGNdbEp+cC2/+rW9Outaq1JB4ym+g+kJGE8VcTk4wmRibpphm+8K+IUuwFNerhGVVx2afQcJuspPzFqAerezVuinRLRVn2QF6ZvEylGyQqjQ2YEDgaXat7dAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 07:47:17 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:47:17 +0000
Message-ID: <a9a2de1b-6432-447e-a446-741c5a8e53b4@intel.com>
Date: Wed, 27 Aug 2025 09:47:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i40e: Fix potential invalid access when MAC list is empty
To: Zhen Ni <zhen.ni@easystack.cn>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20250827032348.1374048-1-zhen.ni@easystack.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250827032348.1374048-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR06CA0014.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a460bff-1834-4b39-64d1-08dde53df1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3lnRFJkTTRKS2QyZ1BDWVBGdVdlTjJRQmhkTUNIQTBqRDBBMzE4U0hBRTlz?=
 =?utf-8?B?VDVpRFpESk5ZZmd0Y00zQTlMVnFiM1dMQ1ZXcXgyVVR4Y0pBSTd1SVNOOXRW?=
 =?utf-8?B?eHJzdWVzRDFlWnlrMk9SQmY0VmEvWWJUbkZnVzZDdXdrallaVS9MQWMxZDhQ?=
 =?utf-8?B?ODZuQmhiRm5EbnVKOHlyd3NGbmpsMVVwUXgzTU5wNzdGc2c3RFA5K2RlaTkr?=
 =?utf-8?B?R09udDJuSVZ1NVNhcEpBL1pKL3F6R1RGenQrMStmcitJU2hJQ2Uveks4NGVs?=
 =?utf-8?B?MGkwZ2FRV1ltcFE4eDJQeElZU05TTkFxRk9BUGU5SVhBVkJRUzBqSUlXTENC?=
 =?utf-8?B?ZldJTmtXSGNWWXY3dGFsNHFUZXV4QTVoRTdtT21USmgyem84QzlOb0RTaE14?=
 =?utf-8?B?dktoWGJtRUtTMEowcFRmN3BrQ1NZb3JocWFlZzR0Ni9SbVJMdS9Xbkx1Mm05?=
 =?utf-8?B?OTZnZUFIM1hSMFdPSkhVZ2l0T0VwMWpHaHRsOTdOSmJrckhNVmg5ajg4aWxF?=
 =?utf-8?B?eFFYeEZjQTM0S0tPODBqcU1wKytCK0h5SXQzVWZHd005Z1VRbTRZODZ2dXkx?=
 =?utf-8?B?ejJsdkdPZUMwNHM0bkZzekpwTWxFcWZQZEQ4YnFsRmQwcUl2MWN0K1FuWU15?=
 =?utf-8?B?eVRtVHA0TUtFYXd5dXdqSDhkYnUrMVEzZ1FIQjhJcjAyeFBWdzFNdzlTQjFm?=
 =?utf-8?B?bWlwZG9JbnRqMENqbVJCN2xFbFJkbERCazNQVTN1YUhha3lsMmxDMC94MlJL?=
 =?utf-8?B?Mi9QakFxUXZ4NUZpbnV1QkVxUEJ6VjY3aTZTNkkyY25UQ3g5MGtSR0U2Sy94?=
 =?utf-8?B?MnJqUUpPV3hpQkhDUmZVUW9hWTlBd1Y5cU5OUlNkSWt0SnpoZHVYZmNHekFS?=
 =?utf-8?B?bEtyMnQ4M1IrZTM4eUc3Sjhqb3JsME5tUkZSbFAxc0JYZzh3S2NuS2xlSHdv?=
 =?utf-8?B?NlB6d0hXS0tML1pWclpjVm5yeDhFMnFhazFjTTlUaThLZnVjVE9UKy91YTZ4?=
 =?utf-8?B?RmZnTjZ2d3FOUURYWHZJS0pPOWJtcXFpVXF4RVR6R0FiSGVUWm9PUmczd0tv?=
 =?utf-8?B?M2x2aVdHeU9ybGJseHNVZ1ptcnhDS0VweWNkMUZYWHR5U0dUczdSTDdFR0Jm?=
 =?utf-8?B?Q2dmdVZScU1ZMElETERWS0N2Z1BQSUowd0tuUWpJSlhiMmxCdE1qWWlhbXQx?=
 =?utf-8?B?UjJUZWhSZ1hobE5EUFVXZEtsZTBMMUNLUFF2OHhrTW5MMFZEMVV0K1V0QnZs?=
 =?utf-8?B?cGc3bGQ2djk2NWF2N0VvZzVkMVdzVU5iakVzcWZJaXRtMlZxVGVQVEhYSzJm?=
 =?utf-8?B?RzVDZnBJbkp5SmNJemFlZmpFQkhYYjJRQUJtamVuczV4YjJjV3dVUjBSUmx0?=
 =?utf-8?B?VklESWRQd2YzZmJLUGRPTDNzZkdMY3laNk5aaXRML3d0T3ZOazAzVDc2eTZY?=
 =?utf-8?B?MjBMcVErUit4cjRhTEhkR1VBT2NRYU1TeUsxcTVsZjc3TDNIYWN0WHhCRnFY?=
 =?utf-8?B?RXdVMFJzTHBoRkU4eUEyZkp1TlNwcnl5aE5uZlQ4TEN6MGgwSTI5YmVyUGc5?=
 =?utf-8?B?SWxwYVk2RVE5bzdGZWtQR1dhSHJIa3pXdHZqT3pIK1JnRFRpUndvak5CWWor?=
 =?utf-8?B?VU9NREhOc1oxWHQwNXZYMTdzZml0NXllKzdhY21KMHBDYmx6cllaeG1Gaktl?=
 =?utf-8?B?V3lxU0lLZnNscVdxRUtXUG82cklXakVvVDdnSWt4S05ndjRYbHVYMWR2VStm?=
 =?utf-8?B?ajVWWkdOaE5PL3k5QUJ2SlpNU1owem1SWVdaUzZkNjFoR3hzNUlET2M1Z29H?=
 =?utf-8?B?QXRrVVpYTDBGelZxdzhIeUZKbms1UTFhb0JHMndUQW1lNUZjNmZYNTY0UHZn?=
 =?utf-8?B?Q25aeUhJb1JUQldiRHVFbFV3bnlWeW5VQTdnWmJvdndETytVMmV6T3FMcG9Q?=
 =?utf-8?Q?Va5t22QohbI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEk5WUM3Tlk1YXNGbVZLK2F4VXdGbnhkSHBIQUJHcjlmTFZpY1U1cTU4TktO?=
 =?utf-8?B?aTcyUm9yZ3BZbTFObmUyVFE0VzVpMWN1SGxPbmhKT3BTOWFvQkthTldJOEo4?=
 =?utf-8?B?cGtmSGpjVEFWbFpQRWgyQWJiNEVkWnlpa3VxOHRmSm9VNzlZT0NlYTZkSDBS?=
 =?utf-8?B?aGQwY2toRnR3YjBSRHJ1MnR1TWl0aXY2c3J4SnBtUWt6dTVlSjZVVE5NV1lF?=
 =?utf-8?B?WWNVYlF3czRDbXpkV05LN1p0ejRsejk2SG9sS0tlRTlBOEY0TGRyUDgyK3FL?=
 =?utf-8?B?SjJvUVhKRWdOTmpUU29wZUdFTFRYNHAxcGY1aFFTenMwNWN3UGdBTVBpcFpE?=
 =?utf-8?B?STB6MkR0VitzL3Q2U3RzUWZEU1BrNlkrZVI5TEpIdFhqN0hZOVRSQXMzUGM1?=
 =?utf-8?B?ZUlBWVQ5UURpQmU4b1M0cGtvbDJKeHZDaCsvYi9kUElFcGZCYkp1cy9wbzk5?=
 =?utf-8?B?QUlZODFMeWEzeTk0OU1yWFZhNGthQzAvd2RpbFI2dkJmZWtwbWIwQ2JBdEVS?=
 =?utf-8?B?MUJvRzRQMlh0ZFA0NVI3NFFYeWk1ME91SmV6RGwwVHlDMGV3NWJ6ZHhESUdX?=
 =?utf-8?B?TGpMeDJLYnVsUnYyM1ZsN2pHWUQ5TEl0YUtTaDMvczJVUGJNZ3FrMjI0d0N5?=
 =?utf-8?B?cDJ4NlEyaXZ3Z1NGdXc5SHJmT0J3Y1BUc0pvV0ViaWVYQ2p4TGF4NHBSMmpX?=
 =?utf-8?B?S0FhTk4wR1Z1WW4yUnBnRUZSRzQ0c29SdHFaNGhuakJFREpzaUQ1Uk9yd1Bk?=
 =?utf-8?B?Q0FBS3VTeERrYi9TUWJwQVJmWHpzRGJRY0c0VmNiOG5IQW5GQjhrYjVSVlNt?=
 =?utf-8?B?aFlXYllLN3N4UU5KLzQwajdFNjVwb3orejMzNi9mN0dDTUpvdTBXWGo2Qmsx?=
 =?utf-8?B?STIyR0g4c05LTVhDVkc0NEZTQm8yeEY1Y0J4eG9DZmhFQmxyNTQ5TGNsVW1u?=
 =?utf-8?B?M0wyeHBaR1FhR2N6bnFjZnhHeWxRY3dtQStmayt4VkR1YWt4ejFVM3VSa3Fw?=
 =?utf-8?B?UndsVlNmdnhRaFMvVEUxOXZ1QlpMdVRDS2F4Wlg4b1BCUERjaDNDOUJyT0xQ?=
 =?utf-8?B?SnhzZXk2LzRHRGF6QUhXTmFNelVsbmdwTjVuaHU4eWIyWGc2K3VkZ0l4OCtj?=
 =?utf-8?B?UnRuL0VKOTVBMmdhcERTY3E2SnQwK2JEMEh0NU1tYUN5cXVocHVkdVdsUkZQ?=
 =?utf-8?B?TTJKVThnZlZFdnl3NGhOMVZ4M2ZQQmpKNWNxS3pGeWZJVG45bTNZS2VGc0Nh?=
 =?utf-8?B?N1RGeExxNkRvd0w2R2Q0OVdqOGZtcStNT2I5YUlCY2VBTkNWRTRaelVxQ3hq?=
 =?utf-8?B?M2ZlQUg0TEdnUFI3M2lzLzd3MXBzazFFamNFZlBPMWkzcE9sT1U1SUtxYysx?=
 =?utf-8?B?M2V4VUcxV3lQM25EcTlLNFBWSnpoZllHR0h1V0dhclhjK3Rvd0FTNDFKQ3c0?=
 =?utf-8?B?KzVUSnF0L1Q5SnhDY0NGMGQ1dXdSSndHNTJxN1k2L293bXJjaHl6U0U5YmJT?=
 =?utf-8?B?NjVuY2szb2hqSHpSQmd2K2l6Q2NNcXlaVDJ6eit4QlJqakJWOGV1WFFETVlQ?=
 =?utf-8?B?d25VYjBzU0FWYzErcTZ1Sm45ZDV3ZVF5ZVFzU3pRTkgrcnVXSzEvQXFObS9N?=
 =?utf-8?B?ZTFMUmpNbjNxYTlGMHFoTGJrZE81dnE1K1ZDd2xwLzM5bzlUSjJuSk1XMHFV?=
 =?utf-8?B?OFhoNmdFYWxqbktUb2hEbzZvNVIzMTBqKzlFcHk0YmhBOWJVa2xrR2VIemNt?=
 =?utf-8?B?b3E4RmVWcWVFcTkvMzA4Si9XMmV2WFlKR1VPYUNXcTRLY2oyOXpIL0xOL3hp?=
 =?utf-8?B?a3dQaThDcDdpQkU0d3dIcHBua2MxNmhGczl6Vk5SWmtGdnM1alNrNGRROHor?=
 =?utf-8?B?cUUrdjVWaG9CdGJLVDhWdlN1Y1dTeHJjai9Ed1lJKzFWTXlEMitNSE8zUUFy?=
 =?utf-8?B?a05wVWU1dVZibWd6alFYT21KUlM4SW9EOHoyQzJlTW9wUHBoZmhvK084ZEd0?=
 =?utf-8?B?YmV1Q2xidnROWGZHMDZraFNXN0VNY0dZcnZTQkJtYklvOXVrQVRYdG1oWCtH?=
 =?utf-8?B?WVdLTDJaaURJeVRPQW5Gd3h1dUptL3B1QVM1bGhkYjlWaWh6NWl6UEVIYXRX?=
 =?utf-8?B?dHkvcHhETUk5ZXZPVjJDTUJYN3lZZXlDems1WVZGVUhWWlBxOS9IbFI0bFBD?=
 =?utf-8?Q?NhrQL1V3qBNq3U7RQg/y+/w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a460bff-1834-4b39-64d1-08dde53df1f6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:47:17.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PpFCretePSZums6J0ts3XNlchQlp+CBEmmr9SUFbN+CDabNi/O9p8CNkqg0TyB+T84x2CtQWmA96aRapgOZ2rLuXiFymQ37CqBeD6qv3kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com

On 8/27/25 05:23, Zhen Ni wrote:
> list_first_entry() never returns NULL — if the list is empty, it still
> returns a pointer to an invalid object, leading to potential invalid
> memory access when dereferenced.
> 
> Fix this by checking list_empty() before calling list_first_entry(),
> and only copying the MAC address when the list is not empty.

good observation, thank you for reaching out!
what about using list_first_entry_or_null() instead of splitting into
two operations?

next time please tag intel ethernet patches as PATCH iwl-net (for fixes,
like here) or PATCH iwl-next (for features/refactors)

> 
> Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_client.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 5f1a405cbbf8..0a72157aee0e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -359,12 +359,13 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
>   	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
>   		goto free_cdev;
>   
> -	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> -			       struct netdev_hw_addr, list);
> -	if (mac)
> +	if (!list_empty(&cdev->lan_info.netdev->dev_addrs.list)) {
> +		mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> +				       struct netdev_hw_addr, list);
>   		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
> -	else
> +	} else {
>   		dev_err(&pf->pdev->dev, "MAC address list is empty!\n");
> +	}
>   
>   	pf->cinst = cdev;
>   


