Return-Path: <netdev+bounces-107152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEF91A206
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCFF1F21A34
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAC12F59C;
	Thu, 27 Jun 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRV4j6UB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B54D8CF
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478836; cv=fail; b=bGbkbpfcOc7yLDJDiK7cGozEI7Z+Nk9Ym1ZmXRHuWrpRsXIoN744fNTsK34gO2DEv5d2jWAuPfdFdJUaIwHhTkuVlNrngNBfJWBbPVtkUTPY5IB6K3kVM13WCfCRZzX7QGtcWAB2LHqiIiak39l6iyujtlmdPQzpAf6pOzagslw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478836; c=relaxed/simple;
	bh=8CScuG0a/uQmwSBmnSpbhDXMVFlqcJEVxae21WmrJt8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqbIQqzq2VIJ6r1bUAXRow7iyjcTKWeyJ3usIOD4zgsNSvHrZoyXOp7eUeLWV9QVACIQy4T4NnRAO+2Z4kaVVbiuKSN6Qn2yQosUdfP54HqiPEDnh/E8P+tC/qDAog+KkUU5BNduMTW3s6+5LnxDyrZf5YjN19HLadIJ8znQQQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRV4j6UB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719478835; x=1751014835;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CScuG0a/uQmwSBmnSpbhDXMVFlqcJEVxae21WmrJt8=;
  b=HRV4j6UBEp3v/xiULI9ocXTTQYtiQroE8mlrkLit6rbXs1BRAerXNieY
   jCHF8Anb4MvXGhjvayuQV4FRIoCG/9ZB7Qqnz82jgK1S6d0YJ/+FlnUF/
   4uja5YGlbmDlfhX1tQQJo5ZhG/tzEdeB6ecxS4ywrxPMKx1UrTqUjQW+K
   RCcop4fmO9sjv7+GmXHnK6Xwgdi6TYEeea1JN897K5oHc00s9mKHvvcCG
   ZBwj6gSF2ujT5pLbpOrJyg95I0wkTps1Trq4xLMb9dlmV7DnmWTsvsl53
   AdWim8mg7jjC6JdKfeR9gKwg+R0sgKbPh/w2vh7WT97i8cLJ+eHxByLrn
   g==;
X-CSE-ConnectionGUID: rnP3aewGT36RUb5HE417dQ==
X-CSE-MsgGUID: jAN42rguQ92g9MSINkaypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27279762"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="27279762"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:00:34 -0700
X-CSE-ConnectionGUID: 9sb4V3V5RWGL+zNLY9hLdg==
X-CSE-MsgGUID: i4ypOMwORnyFsxo/ijcmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="49485388"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 02:00:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:00:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:00:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 02:00:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 02:00:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQwHhOdhEoSkiYqfzyjePqow92qspdmksxY9OXhS+c9fCjOapw0iKxC12+y/imuw4zpELyKfx3fnyNhgQhC+LLGQMUWziMKvF/4EJOJtXAB4sNt7pACSqvUO5YdOc1aqasu5/8zNUthqUO+bZ9bDdOI2DzwGj4BOkg5qX8Nc7VFHiP35u1Iq7gIVn09kXTHM35p3F0pCyMRbtHJqGbCwMSz/ms23dVBwT/1zB8kKj1Dv4yr7arbY8nNESr4z5GcsHAYqs2EE2qsizcMbZN4wZu9w0JdZJNQImLXIjxQSdoLpnq0eExg1eLr2vEF7M87BqswqhzPGPbKb/s5WGfmIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6rRZalP5wP7oAFowPqNNTfhIIJ2HGmALy2YAe3YMzc=;
 b=GQc+T+fLSO7/5mbCXl5Xd/JGkhsNWSj9t+UOQCXnujAsuLDEPT3qbjBPAalXJv91RkGvxz+gk7jNmJ7Cz4/Ey55J4SGTsITi9bbId6CrhClgRxCiCEO7jJeNqBbsT4tiCwkr+PY8hWJdmfpUsHnML88h/L7EP/EDBmL04uezmvybDOdRrjCWloUzHeADyfPNYHsaFlglk7SgrhVWITlc2O3q9vqKwRW1kcfROwjT0tTD3zjw8TC3EuqYBJecvpIGrDoVD/OLATPDFFlmqnocqzQAF+dMnindRwV+FhDrViYTuISX0V76ZgRs4sDYdk/OzLKI0PeWqX7icKPb9eKROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA3PR11MB8048.namprd11.prod.outlook.com (2603:10b6:806:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 09:00:31 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 09:00:31 +0000
Message-ID: <86bf3922-e38f-4230-9a9b-1461f36d85a5@intel.com>
Date: Thu, 27 Jun 2024 11:00:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] bnxt_en: Add new TX timestamp completion
 definitions
To: Michael Chan <michael.chan@broadcom.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <richardcochran@gmail.com>,
	<davem@davemloft.net>
References: <20240626164307.219568-1-michael.chan@broadcom.com>
 <20240626164307.219568-2-michael.chan@broadcom.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240626164307.219568-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA3PR11MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: e2435733-be10-4628-f0a0-08dc968798f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akl1dTlhNEs3bjN1NlZ5N09VRGtHT0NnM3FJdnc5L1VqTHd3YmhJS296WENo?=
 =?utf-8?B?emI5UU9IS09SeXlXaEpkRUhYMmtVb3JZVk8wZ2xRSTJSWG9sYkd1LzA2M041?=
 =?utf-8?B?UnZvSXJGdklLY3R0TVA2azI0Y3FCOFhoWW5ES0NRWnRFY212d2ovbnlLUGNy?=
 =?utf-8?B?VWp1MkQyNVNZY2tEOXUwM3p3UlR6TXltb3ZDVDNzL0VGV25HeTVYS0R2a3Rl?=
 =?utf-8?B?SDB2VU9PUmQxcjBldVU0Nm54K3E4bDNxRElzUU5sSjdxZlZ5OFFhejVsYXhD?=
 =?utf-8?B?UmNXcG1mb2pqY29NTVVsOG1Pd1oyT1lyMTRmZVdRM2Njai9sUzB2eEtUaVFy?=
 =?utf-8?B?SXlKdDJqa2QvME1WalpwdWZCV3BrNlRwK1ViTWRXUE9USTJGSkJLMEJSZHBj?=
 =?utf-8?B?VDdCOS80M1hKTldEVEpBV1dWeFBCZERka0pVeGxHcGpMZ1VFM1JQcVQ4R2pO?=
 =?utf-8?B?MFcvTS84NnhIYVJiNzRLWEFsZDl6MXQydVZTcXY3QVNQRHFVSXQ1Q1ZBMlRu?=
 =?utf-8?B?dUU3bUR6MmNDb0hqMEg1bUo1U01wWDFkZXNVb0hidDBtaWxxQVJiV29pdmhV?=
 =?utf-8?B?VmVIc25La3NXdUJOOTBZZDhBaFlxTWUva2FyTVR0SmVaV2VKckpVWWJ1L0xH?=
 =?utf-8?B?dWJsd3M1Rmc1dWN6Y3RVZnRhUGtWWGNvV3NLWm9Ncmk1ZWZ6WWZOc3RIVGN2?=
 =?utf-8?B?SkdaZUJxTExyVGQzd0EyaERna0p0L3dQNmxkbzM3dnZwQ1N4akNtM3ZZTmxY?=
 =?utf-8?B?MVQ1NG93M3lDUkk5am9JTDVwRnAwOWlwUG1EVDRKeGRoTi83dXUwNnVncnNj?=
 =?utf-8?B?bTZMZ2NxTUdkdTQ0KzJRcWVxYVpjcXNZQms1SUFKYXQxSFBuRnIxZnJobG40?=
 =?utf-8?B?MGwrUnk0bGp1M0lTMVVQWFArbEZuazNOaldhTnhjV1BoVERNclVQdXlHY1RO?=
 =?utf-8?B?WkZPYW90aHRtNWpBWUZwL0k3UG1yaklDOVlmc3J1cmRFRzhPdUV2R2dpNk9I?=
 =?utf-8?B?S1B3MEZJNENGZGhFUVp5Y2tVb3YyRzFYM20xL0ZpM1E1b3JaTzNBTUVzK2Iw?=
 =?utf-8?B?dHM0VGlVS1h1dmhpT1YyRmtJU3BoT3ZwWklmdG9PRitNSmhIbllPOGdMaXVD?=
 =?utf-8?B?QzRNc1Z1ckRtWHZESVp6dmhJcDlITDQ5RzhJL0srandlcTR4WFg0TFJ0Z3Bk?=
 =?utf-8?B?cFEzOXE3bW9hbXUvWUFEcmgvVmhNcmZXdHlvVUdZNDlmMGZsN1BtTHpNRTZM?=
 =?utf-8?B?eXplMVNFVExnMkVnYTg4OTBmMWJaem9USDFjTXM0MTAyOWVVWDdKQXZmbkdG?=
 =?utf-8?B?L01DNm9CYnFLL1lCS3RXeTdweitIRUY0MGQvZG1QNVZwWGNqanBNZGZFSy9i?=
 =?utf-8?B?TDVPOWZOclBETHFRYXR3TERodjgrYlFVNGFSQ2FMMkkzR2JEaUFFTS9SeXIz?=
 =?utf-8?B?TWNMcUppM0E5bTFydkkyZWVZUk1WcHFkdkJjeVRseFV0TFZvSTU2U1FQdkhq?=
 =?utf-8?B?amszcDd0MDRZMTA5OXV4ZnI1bWlSSDZleUIzNjJlckJ6MWFqU05aaVBJUXVH?=
 =?utf-8?B?UHlidUNNTmxOS0psRkZGN1ZMTnZycXBCa2lGNXBlYS9iL1l2REJPWVFUOU5B?=
 =?utf-8?B?ZXhRZ2ZuWG1lQTArUjlKRFJ5ekdHeGZENHJUYUt3aWJXcUZiWWVGaEJrV000?=
 =?utf-8?B?REs2eW9FTElzYXNkalprckF4OGF0K0NEVi9jM0kzTW1jSzB0aUVHTkJTLys5?=
 =?utf-8?B?N2RsQm5CbVBXQUFDZ0hicXV2VVN4RkJxVUhxQXBWTTVoNXB4TUpLc1oxVFlD?=
 =?utf-8?B?c05lZmlIYk9qTTFWTU45QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlVnZTh3RnJhYWN4T1FOeFAyNGFheStLUjBuZTNmRFNEMWw4NzVOU25qWGVP?=
 =?utf-8?B?UktoWmg1ckkwN3lVKzJqNXE2TFJzU0ZFSkhIMEhhb2tnMUtEVFpMOXJ5Z2cz?=
 =?utf-8?B?ZjdEUXpOUVVmeVhQbXRrTVJ1QUNyQ0tWOG84aUY2R3N1bktxNFE0TU95RGhm?=
 =?utf-8?B?RnE2cmRVOEljSXNRbWZHS2VJRHR6NldpYm5yNFZBUTNXM0RUL3lpb3NKR1pn?=
 =?utf-8?B?aHVtbzVMS1N3SUZEZzJPOC9KeUUvVnNrcElieTEzOU1ZQ1dXb1hJblI1TW1M?=
 =?utf-8?B?SFVUQmZoc0RDNFRFVEFqcUN5M3krTzVIbk5wV2NPSWN6cGloNHJoU3lzRnQx?=
 =?utf-8?B?ZDQ2djJTcy9ENTJtbGZjOXgzUEtDeTBhM0RzYXVtbkduSUNBS2krcERYcVgz?=
 =?utf-8?B?NjZIL0RNK01BbjQ3dXpWVnFvR0RWVGNoUnRDYktOTlgrUU52R2FXV2YyZUlU?=
 =?utf-8?B?K010Ym84UnhRdEg2dGxoLzhMdStuMkFGNWxIR3k1NTFPcjVUc3QxeFpqMkVX?=
 =?utf-8?B?cEtrYi84YlJzWGdqaUJyc21iZkNLQ2YxZ0tGcTh5UjZ5b0JzYWo3dVp2bWhG?=
 =?utf-8?B?Q3llVHJKdEJPTERjUTIyTmZsSkRTWHZld3F3SnRPT01NZkZtd2l2L01pRWhL?=
 =?utf-8?B?UlBsZ3RTamU0VGZSS3ExQlU1aUhVMWNjREw3VFFZZnAyUUk0Z01BTGF1N3BK?=
 =?utf-8?B?ak5PUlFCOWkwZHc0TTQzNDIyWVpUc3RwMWZhYy85L1cyTi9ndjZNaW8wTVJo?=
 =?utf-8?B?THZyb0hEUmRtOW5zVllxelhJdmZsbEpxTWRpR2g0c3IvSUVNM2psZzkwNFZw?=
 =?utf-8?B?Ly9rODg4Z1c1UmRjZ1ZwUWpFMUJ2MmZDWHpRMFNKWXJ3YjNqa095SktzODdz?=
 =?utf-8?B?eGdMaGZFc2t4QmQvSnFmbEovYW1rbE02VExxOW1lS3g1VzI2RVNLNzhVZ01R?=
 =?utf-8?B?RFFiZjhEN3FRdFpwejlRWnlzb2d2SDR3QlQxRHZNZ1NSYVZjWEZycjlwUmdi?=
 =?utf-8?B?NFEweEpTSnc2bHBES1hhMUZIYS9PdFBkcEFIMHpuWEhxRkxZUkZBMk5VeGFM?=
 =?utf-8?B?U0tFZk04RGlQMnh2N3J3WCtOVFUxak9SYXZsOUxCVEhwYkhsV3NOWnpocWdT?=
 =?utf-8?B?Q3l2cFJKeEVGWUdrbHdSQStTaXdlWERsWlpiaFk1S3RxOU4xb1RuaERhdUli?=
 =?utf-8?B?aGlydEtiSEFJVFR4Z0dsRmpVYkVXQmFWV1ZCYWxsbkxyUnBBNisvSkIxd0lz?=
 =?utf-8?B?NW5zK1QrS2JwK3FZL2JnSFQ2N3draHg0bkd0cWI5RnpGUEQ0cmo3NENoRXBG?=
 =?utf-8?B?TGNWN0NPdnVrTkRLelhTZnQyWlBmRXVsM0I2ZHQ1ZXd6SzV2d3pBTzJyYm5s?=
 =?utf-8?B?RHJZbFNwRUltelRiVVkzSlFlaDkzUU5OUDYzSWxwSUpqa1YrM1BIS2tBNTBS?=
 =?utf-8?B?anRFaldHcXJIWjZGcTgwcHJFS3ZveGZyZVBhU092RThwSzYya0lhc2Rld0FL?=
 =?utf-8?B?Z0xWeEh5NkdOdy9Hckh3U29jbFl6a1JoSGhDaXJSVURoZkdRdVRWY215SDIx?=
 =?utf-8?B?Zk1DK0V1bEN6ZHBIMTY5eVFsMlA1Y1pYbXcwM0lYMUluQkdrb3VodkhUcTJK?=
 =?utf-8?B?Tkx2QVJmZW9IUEJkdnl0YW9GMVc2cHB0SmJXUitYUG1kZXpBK3ZYa0pmZkl1?=
 =?utf-8?B?bW5FczU1MDhQbWszZk9aZ0hodnFENHhXeU1BTlpUb3E4RFpVN0YvTWZqVUFR?=
 =?utf-8?B?NkoreER2NEs5NGI3L1NkZ21PREhTNkoxeldoUHN4NHF3NXlJZjZ6Mkt5b1Yx?=
 =?utf-8?B?U2VCbmQ4eldod0JhRkx0OVFzQ0hncGpuanBTTkwxNTdUaGNOYkN6WHZWY0pK?=
 =?utf-8?B?ZjhCa1BxQXlva3lYUldzc2lzeloybFJ5UzhBVWpndE93QUUybDVaOWY2T08r?=
 =?utf-8?B?NmNONXBiNUJkSGNlSjJMNjJIUlZ1ZmdxOWM2dFlCT3A4WVBtYmJrV3RvaXZl?=
 =?utf-8?B?NDkya0hnbmNxZzQzcFJSbERyaVczangyNVozazFJZ3BWNGVFQy9zSS8xbGtV?=
 =?utf-8?B?bUVkQUkybGRjaGprOWlXemd6UU9DUWx4cUZwcmZ5VnhJV1Z2OTRFck1Nblhu?=
 =?utf-8?B?dXFWMXlJMUdXYmdMMWhsVjExaXlDTW52UTU4SEZva2NQaTRkT2hPQ0xjNHl1?=
 =?utf-8?Q?kQkszWWKaZUBlCc8MRzOfQo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2435733-be10-4628-f0a0-08dc968798f6
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 09:00:31.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C46+LVuiQqiroBJOJzGbIQyIh5o2RGvfjRG0JP543AIYS4npuaYWQUe0iTPm4dWacm051R+soUW7Pn9xsSuZV1R9C4MgNFktat+rgZvWZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8048
X-OriginatorOrg: intel.com

On 6/26/24 18:42, Michael Chan wrote:
> The new BCM5760X chips will generate this new TX timestamp completion
> when a TX packet's timestamp has been taken right before transmission.

Tx

> The driver logic to retreive the timestamp will be added in the next

retrieve

> few patches.
> 
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h | 26 +++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 9cf0acfa04e5..d3ad73d4c00a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -181,6 +181,32 @@ struct tx_cmp {
>   #define TX_CMP_SQ_CONS_IDX(txcmp)					\
>   	(le32_to_cpu((txcmp)->sq_cons_idx) & TX_CMP_SQ_CONS_IDX_MASK)
>   
> +struct tx_ts_cmp {
> +	__le32 tx_ts_cmp_flags_type;
> +	#define TX_TS_CMP_FLAGS_ERROR				(1 << 6)

those should be BIT(6)

> +	#define TX_TS_CMP_FLAGS_TS_TYPE				(1 << 7)
> +	 #define TX_TS_CMP_FLAGS_TS_TYPE_PM			 (0 << 7)

weird way to spell 0

> +	 #define TX_TS_CMP_FLAGS_TS_TYPE_PA			 (1 << 7)
> +	#define TX_TS_CMP_FLAGS_TS_FALLBACK			(1 << 8)
> +	#define TX_TS_CMP_TS_SUB_NS				(0xf << 12)

GENMASK(),
please use through the series, same for BIT()

> +	#define TX_TS_CMP_TS_NS_MID				(0xffff << 16)
> +	#define TX_TS_CMP_TS_NS_MID_SFT				16
> +	u32 tx_ts_cmp_opaque;
> +	__le32 tx_ts_cmp_errors_v;
> +	#define TX_TS_CMP_V					(1 << 0)
> +	#define TX_TS_CMP_TS_INVALID_ERR			(1 << 10)
> +	__le32 tx_ts_cmp_ts_ns_lo;
> +};
> +
> +#define BNXT_GET_TX_TS_48B_NS(tscmp)					\
> +	(le32_to_cpu((tscmp)->tx_ts_cmp_ts_ns_lo) |			\
> +	 ((u64)(le32_to_cpu((tscmp)->tx_ts_cmp_flags_type) &		\
> +	  TX_TS_CMP_TS_NS_MID) << TX_TS_CMP_TS_NS_MID_SFT))
> +
> +#define BNXT_TX_TS_ERR(tscmp)						\
> +	(((tscmp)->tx_ts_cmp_flags_type & cpu_to_le32(TX_TS_CMP_FLAGS_ERROR)) &&\
> +	 ((tscmp)->tx_ts_cmp_errors_v & cpu_to_le32(TX_TS_CMP_TS_INVALID_ERR)))
> +
>   struct rx_cmp {
>   	__le32 rx_cmp_len_flags_type;
>   	#define RX_CMP_CMP_TYPE					(0x3f << 0)


