Return-Path: <netdev+bounces-137988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB09AB627
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607251C23F47
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774381CACDC;
	Tue, 22 Oct 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A700LlUp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206991C9DC5;
	Tue, 22 Oct 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623038; cv=fail; b=LMxZubLXK5nxfqrLF9HM85nuw1+K646/NMlzScEZ/e7H9l3j8sZno4oPuFUHCvYuZ3NtHQxwxMxKeEXQL/ei8d0bglfkra7k0h7Gv+eARjpC5nPr2TvI0ZJxJ4T7BNLzY3LMUnVwP1eQJuRR55kE05hAkUeV7zqZs7QNk1YLb7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623038; c=relaxed/simple;
	bh=ZUEl66Oz++LmPfBtfh7BwQnZOhMyQAx2I9U2tXmSY8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHkXLcrglpMf1ZBwotesypxuh0TnGMNAJevkugBzGZauyCrvpAKayXIqWra8iEzg5QSnA6HxW5tLHNH/K4d17aLt7EkJAF4/lhFhNC6K0sFi6rCzTAntzY3p/9b1Fzb1S8jIX6/ASNHImw+OF6dMPOSY7P2LHGN/50Id5M5lEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A700LlUp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729623037; x=1761159037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZUEl66Oz++LmPfBtfh7BwQnZOhMyQAx2I9U2tXmSY8s=;
  b=A700LlUpWH7IWSfzOY5LtIXbQZa+VQUFobFarzoU1ZNeWcrSydR0bchm
   lK4DpX/anU4xz2GToCxKJZGoA65+C/ZMSkZUfAXz/z25YEn+Xgk7bZav+
   mz8WXWRKhTZnlOi4JMlT35Fv2eNcGZkAtS1HUD89Ls7KRxwSbifVwyrCa
   0vc581yHq2JEPmiI9NV3Og4sMIcMkcmhorAhvyEuWg0Gcd7F+fpTX4VHO
   BA75PbyBL1Z0RznN79EKMjgn633UhPTNxF1Igroaf9hRB4ST2jvD3FK4V
   4VehCn193tjYZR2nUM+p/pqss4CLyNlnFi7uBcwUO+NB1yqzjeHQ4hmAp
   A==;
X-CSE-ConnectionGUID: CRWVsJxmQPW8zvDQVVYGIg==
X-CSE-MsgGUID: y2c1RAnZSGacWDNLj852NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="39760844"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="39760844"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 11:50:32 -0700
X-CSE-ConnectionGUID: B2JdQoexRkSUQnQzaF/m0w==
X-CSE-MsgGUID: xmmYaRWzQK2eVRdSswcnvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80297436"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 11:50:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:50:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 11:50:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 11:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbQQREqTggda3RlsuMAzgyD1yFSmWuPqT9snYC2APr7jVyUaNg+sXFXEC2R9A4Oi45sR74X1/2sLKhEFa9dvYixYBDlQtqGtZ4HeuL9ViY2t1XUbZrrAjzB4ulgtuTBBggTtAe7dtxy4rWUKiFGdGprpYj2LcBXeQSRXMpK2EgKRbV6jb6Hx0CB/JDZy9GRv1uR2xLwggrZsqqe5gxOFxhtDvothqbk8scW+V2z4ccuMGHf4lc01mRMRq6Jj+0StAPDD1MONJ33jIPrN2YGyxzTA96jtrz6+0ouInXWrCTLuNTKi26YrTip56j+nWJ5RdBO9X/TS13MDQy9Arq++KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsfFnuVCJkgcQ8xocrL+x4WfFrjKAgt+yFHSoBrQHnE=;
 b=fvXoCR1ieuK+FCWefu1DlsUgv1S//zeGOqdSy1taZ6+XCmVH+FYFgIt/GBMHqT8rvxk5ubbIeMWtmBBf+c0pVpJhu2xDVZnJh58LxQw6Ml9ao+gntfrVvYE8RSJdlbFK+LEuvKNqL2Ii+sIyDb7Uw+vNIAG5tk9xCqU2tqoJh7gwMVlW13HZZ8HdvaYZoFpICKBXeImpj77P2qsXIkVjcTSsKvn+m3BnS1tXalxPUhjq5b3SqHD4Z+9k36nmSen+umli6MgbHNbxFwq0TTbIs1tK875D0pWlr386wNXiYOmJ/DZIvM1QrayDywmdeOTUONsWPPYCY8W+K7hnX5xkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB5034.namprd11.prod.outlook.com (2603:10b6:806:f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 18:50:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 18:50:17 +0000
Message-ID: <d4eccf1a-3346-4446-a7ef-67e6905be487@intel.com>
Date: Tue, 22 Oct 2024 11:50:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v3 1/2] igc: Link IRQs to NAPI instances
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <kurt@linutronix.de>, <vinicius.gomes@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-2-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241018171343.314835-2-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 8200d9b0-1c8e-4c5e-6ec7-08dcf2ca5f49
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVjeGJqNzdVOEJ0ZU9PQUd2RnpPRnphQThObWdKVGZ3SllHd0VUOFZkRUxM?=
 =?utf-8?B?MzQ2elcvQkxSbFFnc0xieEtkTEFHekQwdVgrSkU5ejJoWGZDbHFtdENxdjl5?=
 =?utf-8?B?aStqVWZwZDZVaFJkT1c0SmIyRW80WnJhNFJzb2k4NlAwMzVCSnJaTHFLa2Zv?=
 =?utf-8?B?ZjhHY2VObVlYZ1RaMFRFbGhvSENmV0hBYnBJSVRDNll2NlZ3bE9zbldYU21M?=
 =?utf-8?B?WHNoSkF5RDBadEhJQVBiQUwyNWpQTEVDR24wZGQxQ0NsdHFSVXVHejJ2MUcx?=
 =?utf-8?B?aXJqaU9Haml4NGs2VGYxbkdLbTlhd1U2RmJxTjdkeENBQnZrdWtoQWlFbHdY?=
 =?utf-8?B?V21XR1lHWDdVUnVhNUQ4MCs5aWdURkpwTFp6alNjZmErb2hLNHN1WUNpQ0Qw?=
 =?utf-8?B?dG9lcDJPczd0MWpybktkcEhPMUtSUU5aUVY3NGNmN1N1MjhmWWVOVGl2bDdG?=
 =?utf-8?B?RW1sMHp1cndTb1RYVjZYYlkwanBTWGJxTEtuenM5OHNFNmtic2N2VWFubWl1?=
 =?utf-8?B?cVhZQTZxZTAzRW1QOG5ybkF5dVE2Y1hQb25jRVNJK3dVWUFuRitxSFJ5NnRX?=
 =?utf-8?B?WGJ2WS9pQ3o3Wi9wSzNCbTNmcDBDMVk2NEc3dVJmTWp3QVc4dWh2V3RZTnNL?=
 =?utf-8?B?ZTRWZy9RejFhOXRSV2hvRWRBaHdzbUJXYjgwVm5TYjM2ZzExTlJRVjUzSmp6?=
 =?utf-8?B?M0dUem5FY01BVUMvTHdHRFJ6NFdyWWgzb0hlaXUxRE42V1d5Sko4Qk9mTzVT?=
 =?utf-8?B?V01PNndKcURaQzRFWFcrSkxMRHFzRnVJRU9EQThvL3hHakVhYnNWMi82ZFJq?=
 =?utf-8?B?aXl6Uk1kamhJQlZ6dVZQMC9zKzFwRWhEZ3pybTY1U3RsbmljVnVNLzh0bHB6?=
 =?utf-8?B?eUpLUW9TOTB1cEN0Z25EOWkvdkluOFRibEhvTTQ3S0ZZVjc3YzhwdWZWV0VE?=
 =?utf-8?B?a1JwNFQwT20wU05STE9jUkMrRnI5ZllGeXVQT1hQWE50R05Jbys5UEJ5b1JM?=
 =?utf-8?B?bEExZHgxdG1ENDRWZHBXTjBSVWRsNkMyRTllM2tydWZGUzEzUExhM3ZVL3FD?=
 =?utf-8?B?aVp3N21Jcm40K1lwWXdZVGRrb2ZJcGNxT3dlV1llMGtZUjVocHRzbnB1ekxT?=
 =?utf-8?B?T0x4ekdhZG9QdTdhbkk5cDl4WmZlS0RZRC9nRzIwTzBrVzFKY0hNSkQvY2g0?=
 =?utf-8?B?dFQrSEM5aG1yUkdxUGE3MDdTYUVYY2tMa014Q3ZIaDROaFBtUEFaM2g2a2JQ?=
 =?utf-8?B?Q1Zxb1RaT1dZSVlTLzdObitHakZoR29ZWmlEVHM2QVV3a1BIbmMyREU0ZWpM?=
 =?utf-8?B?QTk5RlR4ZVQyejdQWnAyaUxQUDRRTjZ0eEl4K2Z3TisvbmVZNnY4NGxuQXRH?=
 =?utf-8?B?WFlnaFd0Rm84YWR6ekt0MWdXeDZIS1JraFNqZjhUM05PMEppZXZDRW5ubTcy?=
 =?utf-8?B?U3M2QVFzOVhmN0c2VjVaenhtTndVN1IwWG1kZUM2czBGanpqcnFaWkp3Vkda?=
 =?utf-8?B?N25YbEQ0RmlRWG1oUE1HT3k4b0tLVEQ3QWlUbWhuRk5udmVibWN1c2NLZng5?=
 =?utf-8?B?Y1cyRnFFWDRyWkFkS1M3NjRGcHRwM2xXbGpzaG9tQlhHcHZOYkwvWGluZUtJ?=
 =?utf-8?B?U3NiNHl2aElZT0hNNlRzeVVFemVMZXBMWHpycThzM0t6UVVEL2lVWUFiL3kr?=
 =?utf-8?B?NTQ5NGdiUEJtMHNTNnRvUkFxVkpqNDI3MFJMallmaXVDR2RFVGhWcy9EcUxY?=
 =?utf-8?Q?egmNz0+Qn+LJ3pskFQaxDYM4KF+KplVD6Kh+eAe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lCSFRlRUxrbzNUUGxLNHcwbWt6M0JuUzNRSnFEYnR4aVUxeDFRb0tGTG5I?=
 =?utf-8?B?UlEwb3EralBVOGRRdTNSR3Fwalo0V3V0bm5tUjVnS2NxM2lTTmEyc2xBVzBt?=
 =?utf-8?B?SjV4SHdPMVVxSVpqazlweGprc3VTR1U1cWFyTW4vNzBFT2RmdTM3SHhFWnRC?=
 =?utf-8?B?a3FrcTFNaUkwZkV1RGIyc3lFbzJyVkdlcFMxL2RILzVjMzR6alA1d05NUlVK?=
 =?utf-8?B?MUlZdnNHaWY4RkJCdy9MWXFQVVpYbmNqd3Eza0VCenFEanVwd0VSWjRJWncw?=
 =?utf-8?B?dHUxbXBZYWNpRjJwNnV1M3F2TVZqQUFnQTkya01HazN2alZkT0tiYWp4ekFo?=
 =?utf-8?B?NjZNZjU3SUFycmFRVm9XZlhsejR5d1RCYXVMcnI1c212R2NsVEo0TXR3Q09a?=
 =?utf-8?B?WGpUa1I2UnBWdWh5ZDlZdTBaVXZsbDhvd3p1c1pnUVo4MWtzODBIMDJjZ1Ar?=
 =?utf-8?B?MGdFQkpBRHZsREFhRmRadEczZ2ZtcHprdjlmNnFGaUU1bW5mRGUrbW94R3pE?=
 =?utf-8?B?YkxQb3p1WDdnMi9LTE1YVEVCaVpYWjNnRFoxZTZRbUVIbDBHTGtZeitGL3VO?=
 =?utf-8?B?aWJhRXRLZXMwTUtZYXBDVElCRVVyelU1dzNOL1BXM1NCQnJ3aUdKYVN6bVVE?=
 =?utf-8?B?Qlc2M0tBL2lkN29xUWlRQ0xFZGozNDhmQjJxUjhuMWhST1RHTkdTYWxOd3FJ?=
 =?utf-8?B?V3dTRDRkVmxOakZYVExOOEtSakwyRmhZMHBZZnlITmdKMmhtT1ZVNFdwOGhm?=
 =?utf-8?B?Ryswb212Y3FqcjFuaXRmbDR6akd2N2hUSFFNNzZTQnVzaUxuMThmVTkzZzZh?=
 =?utf-8?B?dm9DME1sVmhOencwVFYxQnF2VEt3ZFRLc1B0VVJLOU16UVpkNHZwVGpLYlpG?=
 =?utf-8?B?UDc3ZjZ0S21aQWp6b003REZqcmpYRjVHcXFaNHVVUTdETDJST093aUJTUCs1?=
 =?utf-8?B?VG4rQUZNTUZsbzI1bXdNQUt6SW5hQVJXcHpUbElVVVpLdW5ETzB6TVZxcmRt?=
 =?utf-8?B?YlRqbzdWRHZlNUZyUkVrZTR2TWZPb2tqaExRck1sTFRMVDJaVldyVlNvaUdN?=
 =?utf-8?B?clROWmMza1hHOEppNDZuT0FaNTJyOUdkNFo0YzdzWEh6ZWhnc01Ha0hTRDQy?=
 =?utf-8?B?MEpPdFk4TmNwam1MbWNhbHREMVNpOThFK2pqSElwNHYrT3pKQUI4alcxb2JI?=
 =?utf-8?B?aWpVMU84cUd4OTJ5T0tra1JpU3J4U2hTc0xROWlZNWxtZzRQNDVmbzdNenBw?=
 =?utf-8?B?dGJLWmkvazA2SFRhUVFUamtJSlNmM09saUt2UDJYaGxKekxYbDdzekt3a05o?=
 =?utf-8?B?OGdrKzl4Sk5Eb2F3aitVY1IzWWxZRms5VThtcDNzNHFkRE5CZDQ2ZFd0NFJ4?=
 =?utf-8?B?dnVWdDdjdTA3Mks4dVRML1RlWU9oNWRISFhvOVRuVTFDaHZDRzRCcFNVa0Fy?=
 =?utf-8?B?Sm01aDVQcmlubjVuanJ3Qk5jbTRKa1EwQXJpRGwzZW5JVk9ldTlrVGIxZW42?=
 =?utf-8?B?cldEL25HNXhhVzRKSnMvVHh1VS90UGk5QkxUN2NvTlI4QmpxZ1h4cnlSLzJz?=
 =?utf-8?B?Ny84WnpLWHBQeDYxYVp5akJHUXJCSnpOOEE4NVBrMFZQUUE5b0VQaXZsUGpn?=
 =?utf-8?B?ZC9RK3lRcjdraWdnV295RlloazBLaXpKTFoxZEJ4TWVVeUFmajVYV1hMT1E0?=
 =?utf-8?B?RzBOUllHZUNxTDdOUTdpc3ZmNEZ3S21SYXdkRXJIUTJkdUdEdStmWHUvNE00?=
 =?utf-8?B?M3FvaEpLOThuTS9vejNKZ2cwNDgwMExkVUcvY2NuangwL0lRQlNUK0R2S01p?=
 =?utf-8?B?ZFZjWXVvUW44MVp1UlJ1NHBkUjJkOHZwWFMyR041NFFEUFdUa01LNVlNUGh6?=
 =?utf-8?B?b3ZucmxaT0huRGQyOTNidGIxRlFXZ1UxRkJlVjd1bFFQM2oxYXMxT3JlMnBV?=
 =?utf-8?B?Snk4VkpScGVIL21pZnBXWVdnUGErb2xjWDVUeEpka0hqTTZNR2lKcHBiOC9h?=
 =?utf-8?B?bjlGYjAxVFdVM1VYV0dVcTRVRWF2S3VmajdjYVBGLzRYSktJakt2WXFVSkpu?=
 =?utf-8?B?T3dCbEsycmg2VkprVUFKZFE2U1o5NzRHRndIb3Rma0ZqcFhPY015bFpCcTJI?=
 =?utf-8?B?TEY4c3JPTXA5WXltTXAraWRrRHJITEdDSmZoS3RqL3JYUDJHWlRiMkhHYUt4?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8200d9b0-1c8e-4c5e-6ec7-08dcf2ca5f49
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 18:50:17.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/kXERiBnv/9x/ovJL/CjTLrCmzbR+XEB5/L26CUCnHvhMOUqmlLnLs3LB9TTa8bdbUc49JQOouECjxCiklhZXSV+cHS68PYw1n+/IVfFpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5034
X-OriginatorOrg: intel.com



On 10/18/2024 10:13 AM, Joe Damato wrote:
> Link IRQs to NAPI instances via netdev-genl API so that users can query
> this information with netlink.
> 
> Compare the output of /proc/interrupts (noting that IRQ 144 is the
> "other" IRQ which does not appear to have a NAPI instance):
> 

Minor nit: 144 doesn't appear in either output, and it seems like this
intended to indicate 128?

We think its a typo as the 144 appears in the data from the second commit.

I can make a note here to fix this typo when sending after we finish
validation, if there's no other issues.

Thanks,
Jake

> $ cat /proc/interrupts | grep enp86s0 | cut --delimiter=":" -f1
>  128
>  129
>  130
>  131
>  132
> 
> The output from netlink shows the mapping of NAPI IDs to IRQs (again
> noting that 144 is absent as it is the "other" IRQ):
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump napi-get --json='{"ifindex": 2}'
> 
> [{'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8196,
>   'ifindex': 2,
>   'irq': 132},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8195,
>   'ifindex': 2,
>   'irq': 131},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8194,
>   'ifindex': 2,
>   'irq': 130},
>  {'defer-hard-irqs': 0,
>   'gro-flush-timeout': 0,
>   'id': 8193,
>   'ifindex': 2,
>   'irq': 129}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

