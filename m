Return-Path: <netdev+bounces-304203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7paVOKByRmrqVAsAu9opvQ
	(envelope-from <netdev+bounces-304203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:16:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD426F8C47
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 16:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=fhNApH1w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304203-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304203-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE9B30E0F29
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAE74C6F10;
	Thu,  2 Jul 2026 14:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705294C6F01
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 14:09:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001389; cv=fail; b=r4nCnO0Qweu4ql8gKyQ/HU6Nen01l3kd+6RHBOtM8R1izL8lgkep1rv925ZGY4V4ktrUG6/EUyxV77S51YO6Wa6comjScDghlRceGlkvYs6VeBGLT7z0rzwyiBqyqOdkH8bSusgWIumi5Nqsz8L5TiayFimXcb7ZXdhXdZS1bSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001389; c=relaxed/simple;
	bh=kW9+m6grfUzJskBK2HLBhu/ucrY2rJ9YXA7WnLCXWVQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IgWNuMHFkyqilBtWYW6L6mL50n2CNLDzfHKgeCFBBxd1c0mdJQ4on4/bMDT8gfL3dDT5KCrub2lrvbyKgS1Ga/CpM5rzLk9HdvZRatwsvyH5dHbIbbXWu3uecixqFvYxIERIYqi2XIV0vWu1+wNK6iB0L7Y1TjTbOqNv0GwJ3w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhNApH1w; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783001387; x=1814537387;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kW9+m6grfUzJskBK2HLBhu/ucrY2rJ9YXA7WnLCXWVQ=;
  b=fhNApH1wHq+Oxrv/pGhIlCNu303ondIc6pBe49QQLVIeSbue8oVEAJpG
   0vz2jaUINROXtQLz2F1O8GUr2XmgXFzSSecLjs5MTFVnKTvgJOW3B3IBs
   BSP3wtJydISATbPKPM7EIrxt2WC0HK4Y+YbB+RLblvJMCgwm2iC/L/ogU
   7Ux4vLsjhZozm64Ens7RZ9jDtHhjW6GJzYBqMZvY6KZ/GdM7ayTJ0mhaF
   6ugk6Tx7pMdN0F/mi+ak1gibx9ostHaWBQZ/fuOs/xr+vTvNS7e8C/ZUq
   gzGbZu8EgKMil02Pw7+dLjqt8PSf6TpMTt75MQr4SG6Vs59muPx3JnzjL
   A==;
X-CSE-ConnectionGUID: +QV+ZSQ9Tve/9M6aBIUbhA==
X-CSE-MsgGUID: aF8d2/qrQVuM8lRToS+bnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83788320"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83788320"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:09:47 -0700
X-CSE-ConnectionGUID: j+MMfd9fQO6yl18nV6ySmg==
X-CSE-MsgGUID: oF26m5GUT9md12wt7In0Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="277192138"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 07:09:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:09:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 07:09:46 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.58)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 07:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAaCew7aN3Wb09j7lR2d+kFxwZx5voHn/MS5tScIxe/BQ2yyc7Ao0nBGzwSrwjuH55pqOC7bZiwYPPZCQmweuoEuyVi+ScreGX4poQIJ42PyxHw52aTy9xrHtUHuTZSjqtC/0aCh9T2saGhSRiOLh7OGVU89sUkUO+e9X37XrJ3TIWzVHqExe+Bl7pTdSTylj1s8pV6yLDkoIDl6ex1mjf9pzMgInBp4PKSsx8fFUrQqSlyabH5EmNLEmvoLUuW8+DzP6ZKi9RC1rtXfxK6dcYHqGfyuEIYZVi1gsxwvuCwOa+aoTPGhojlGTP93YS1Fiu+l2clS9QhCDvGzokPFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORYaRwCHgLgIuAKigiJNggJfGrTafulNDlye8ZO6FIg=;
 b=AdJq6vooa0LTVAWRliNq55ztZDnE41DKRf1Ka1p64gJI8WCT2iKCALDSi8TFhu18Q+mQMY0EmA8DRqqR5Vnd3KuvBnsKcpgE08ZAWL6Mu7UxBn5p37fdWL472/COxlCB5TDrpc0kuvmFCsIqDYmOqn1iprTMItWa97BIpFUdT+O9tBRGFGwkxYqFyhjd3cwol9gvX+NUICa91/fFoJfXTmha/oUxQ2CNJC57Yb1iJ4BW85JDzomMejSenX7aNCphOjxDEGVWIYhEwr8VJ3X/p5keYsHImZQMWL/Iy5/w1TPXyxpCtOG7nF/aU5LvSSObfIkEe+myM05Af7oRrP161g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN4PR11MB9941.namprd11.prod.outlook.com (2603:10b6:806:4ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 14:09:44 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 14:09:44 +0000
Message-ID: <fb6b1528-058b-4bc5-b97a-ca2c844e0608@intel.com>
Date: Thu, 2 Jul 2026 16:12:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/2] ice: fix stats array overflow via proper
 realloc
To: <intel-wired-lan@lists.osuosl.org>, Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Piotr Kwapulinski
	<piotr.kwapulinski@intel.com>
References: <20260701104141.9740-1-przemyslaw.kitszel@intel.com>
 <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260701104141.9740-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN4PR11MB9941:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c8044f-2486-4b03-86c5-08ded8439149
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: gRBxcCsUM3jW2iZDlwG9IUjyXUh9daptGjQEuPOwXwCs0X+eTY0Bztl15sDMI3Kb7DX2TZBF0KYTQxBCKjY0yBc+r+TG1KAmDFHtwNNZg4EKPtYbpax5G2+a9jYdpXv5WXlBFoRDvxGQCax3RWQPB+nLgTwA/+xON0tU+3xLmSMgrCeEcX2J2bTqE4UCIRHwuxBrkSBgO9GEumVfM/YX24Pdpqi8H/kc5rrSf2fBbNkB4d5WUlMuej+1uS253E0eZMDYFeHS3nB9m8SCABJa48avOga/j3ZY8UapyMlIbEdojTHmf7HwoZZdpJRckmN3irt6VyzYWOpnA+Aabl+RDYH/3o8uqx8fJeK9t75jQHXuwhdIGyQ3zD6L28bE3Jrgl483VtPc0PhiyLHK5oI/TAMfC6YcZyhH/bKi6rTJgjW7Vyy28N1fewx/Jz4kVpvjl7SdX5q1T+vu6OY8qEKDEshKJ4mBlJmbTQ4uvWLPBRaLzozccMHhPawixTW3vfWtctSJJwNtHxm3LXsLunYpQNWtjQvPwkyKAyeEMqhxxb+kVX7JT4cZf5R6ZjBJ8aMl/R6f8pzbnpE03cCEjJSq91aKPnWulC3uMEDe3gOUeSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVnNzV3MGhXZU5vcDNwempndEZORVo5QzBKK1gwSXB0TFUyUW1zdGRpaW1j?=
 =?utf-8?B?Wm1uWElnV2VGQUhhcjJRZlJ5YjZHTUZUOUJ6UDJkVmhSYkwzOFJRSmNnOGFi?=
 =?utf-8?B?VFJ3elNJUER1cWV2U0N4SU5JQy93YjBleUh5TllzZ3ZhK0FnUTZFTWNFR1VM?=
 =?utf-8?B?K29peVBCRFMrMmMxR3VabUE5cTdDTzMzK1hoaFhuRWZ2cm00WU1aOW5yU0Fy?=
 =?utf-8?B?dDBjQU9VYWhPSDdnZkdJUjBvRnBVakEzUE1GWi9RemZkNEQvOUxHMUVmYzVp?=
 =?utf-8?B?U2xXOGxva3VXcW9KUXpVblZYdUM2ZmZGd0RQdVZscXVPVnhiZ2cvQU5FWVdX?=
 =?utf-8?B?S0xPVDNzdDVsQ3BkVVpoeXFBN0p2SktwUXNEclcvNVlkendqMmZjZjBUL2Vr?=
 =?utf-8?B?QmRPQ2U1aEdOTjNPNnJZNEFNMWk1SllRekx3LzQvVVdqcm5sYVJyOHI5S0lY?=
 =?utf-8?B?M2ViK0RnbFpnMUxHYjVMbDdNbE5wbGZUK2p1RzZSNFFxcS9hdDlIN040eHI5?=
 =?utf-8?B?UDBrQXZSY0lIWnpVV1QzcFVhbHF0UjlDTGN0M1hxcW5aVUpmQVlvRUhWUVZC?=
 =?utf-8?B?dStkdkozNjg4YW1MdzdLekk5M2I0UHNQcGtTWWlwcWRLOUw1OFpta2dDV0RP?=
 =?utf-8?B?M3RPeVQ0RElKTlJLSUNZMXI1dTVMeEZva0lXM3BtKy9QbFc1U3ZqTlJxUVBQ?=
 =?utf-8?B?ak95WWE0WkZsb3k5cTVXWUdVK1RhdjRCMWp5dGFJYlVsM2V0QlN0TEJWeGxX?=
 =?utf-8?B?dWxISnc4OUNLRXpGOU8yWG9BZkpHR0d0anUrcHlCTkxiOFp1N0d4L3RueHdH?=
 =?utf-8?B?MnFRMXMxMUpCYjcxeWlLUUJDMlNkVnZ4Q29FL1Z5NjlmQ2E4OHhKaWFMY210?=
 =?utf-8?B?b1lsaDNxRWNCaDNpQlh4S2tWUzE1N3V4dXhtZ0dtN3BMRE1CZmwwbnV6ZHhq?=
 =?utf-8?B?VGd6S2VGR05UM0MrNVVtYk42VFNDaHA2QnlWL09OaGNpNzc4d1UxaWZCTlQz?=
 =?utf-8?B?Q29HK0J5WXlGRStqbnRIOUp6Tmc0M3Q4YnpReHNXRlFIaDUyV2NacXhjOWRs?=
 =?utf-8?B?OUpPRTlmMHRkQStSeEFqcjdDc0FBUHpiNCtFVkxBbks4OElmUlQzc29NK0Zx?=
 =?utf-8?B?VUVwQnlOdUNZUkUwYlNMV002OCtQMzMyNENyUkZESzltVWtIc2F5aTI0ZWRH?=
 =?utf-8?B?Q1ZzTFRuZC8xZDNzMjdmT2dkWm43cTZIeUtUWU1GeE5Rd2l3ZjdoWklSNnN0?=
 =?utf-8?B?eEswMU02dnkrNE1NckZnS2ZYWFNzS0VCOG5ZeWpoMkMwK0ZONE5ydjc5dm5Z?=
 =?utf-8?B?cXpXRHhCaGtVdmI2NDMxeFdQbDZFbmNhbUFUaTlmVzB1SlBHK0tjLzA5aDk1?=
 =?utf-8?B?NklzVkF2amVrajlWcXZob3ZIeVJXdXhSZmFrSys4NHp5Y0MyVkVoQ1k2ME1u?=
 =?utf-8?B?ZGw1cHFjSkNsWEIxeXIza2IwV3hWMWg1VVZLUXZvczFKc3R1L2dWbmZrSUV4?=
 =?utf-8?B?WFVCblFaVGsxUFdZeEZFTEsyMHMvK2lTa1BDTkswNHZicTFkb1plbkpuQ084?=
 =?utf-8?B?K3NUU0g4YkN2dFM1MEU1UHJpSFp5Y1AzcHNzMmpPOVNlYVFoOGxnaWhGbE5a?=
 =?utf-8?B?clZTbnVwNE5HYVF0b05ZZmc0QSs5blNDdEV0N1FKcUN0RGkrNDE5Z2NGOXJZ?=
 =?utf-8?B?SHRVYk4wclRIYmkrWHc0TU02RkVVZmJSQ1hsT25ZL2FGZExCS1ZBdGhDQWNt?=
 =?utf-8?B?azR5aGpJVGVqWjM3UEYyeHlvb3pTMGduMnJzTnBkNFYyZGVDMEVWRGQyWEtN?=
 =?utf-8?B?MDVMVCtTQm9jSjk2NXJ3WTg2SGl2djEwVjlwOURXVnovYXJwblo1ZlNTTnRq?=
 =?utf-8?B?RWNxZEt2cVJvR21XcFBBbHBock8vWDdETE81UFY4YU1vaElJQVVTQ1BVUHpR?=
 =?utf-8?B?ajB3ZVNoRFJHMHZ4OUdBZ2VxbmNOcmEwVXlZc1NnYzY1N0JJL2k0WnpYOHA4?=
 =?utf-8?B?ZEJSQmhhNC9tQVpKamZQOHRtT0xMdEUrSnRDNUhIMjlycUtDemRzKzR2T0w2?=
 =?utf-8?B?cUFIMTlrZXQ0SkFEb3J5ZSszNUpKZDl6Z3hpYlRWY082UjBpcDB3V2VqS2lW?=
 =?utf-8?B?WE5pUzQyajZJNWRQZ3VDWmM5Mm1tQWkxZEM5MHBXbDcvTFlDNzZ5MWxtQSt0?=
 =?utf-8?B?TnpsbTdOdjhVTzRrL1pCZmMxTjdKRlR4VE1STkpkNkQ0SjJtM3hqa0Z6VEpl?=
 =?utf-8?B?TzF1MTI0K05NeTlNZURPRXhKdGt4MEtta2ZEK29sR1RBQmZScXlWNE8xRFYx?=
 =?utf-8?B?bitsKy9wbW9WUUhUYjhvR2VyUUhubmZoQTQxUTJWNERRdnJGMmc5ZjNRa0lj?=
 =?utf-8?Q?AczD2quUTpW48Gvs=3D?=
X-Exchange-RoutingPolicyChecked: lNYeJ7Ea96sG4kaKzdXy9cptLNNmTtipnlwHai4tBCNT2OEJXqApjvFEK9MguBjiHEuwq2EzTpTgqoE11XXvgKOtoiQIdp5Xi2NRaEcvOp3ZYNAikVdxZZO8C9PqwlM4feLUDsilhsZ/vlg2oPauvQQoPq1Obfd8gtdQ/JK6kYiJmr7gualPKc8/+KyKNa4EWseg5vVpMoYekQ9Zs79G6qT9Ge+37ey6eP2L1smzbsBJGMquOEG8kQHrT071ZAWwry+TPrjQ3Xc/kwHcXo6QDJrUQ9JWN6OZl5U1ntVE5P1ILvFj14Nw1+WE9JZhtauct9+iiVgXuteUd/4wr2SXKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c8044f-2486-4b03-86c5-08ded8439149
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:09:44.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grS8W7+AVlx6FNrOgSh687jmdy3K7tXw3TT+7KrOJmBygchtl+ttIvofea/idsQGDTF66CdpWbYe2bT9UmZp6Z67Ut6j5SlAlwbdDeMwIhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9941
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304203-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AD426F8C47


>   /**
>    * ice_vsi_alloc_def - set default values for already allocated VSI
>    * @vsi: ptr to VSI
> @@ -2319,7 +2274,17 @@ static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   	u16 prev_txq = vsi->alloc_txq;
>   	u16 prev_rxq = vsi->alloc_rxq;
>   
> +	if (vsi->type == ICE_VSI_CHNL)
> +		return 0;
> +
>   	vsi_stat = pf->vsi_stats[vsi->idx];
> +	if (!vsi_stat) {
> +		vsi_stat = kzalloc_obj(*vsi_stat);
> +		if (!vsi_stat)
> +			return -ENOMEM;
> +
> +		pf->vsi_stats[vsi->idx] = vsi_stat;
> +	}

sashiko [1] points out that if there will be allocation error
later we will end up with, say, vsi_stat->tx_ring_stats == NULL,
but ice_vsi_free_stats() will try to dereference it

will post v2 with a fix

[1] 
https://sashiko.dev/#/patchset/20260701104141.9740-1-przemyslaw.kitszel%40intel.com

>   
>   	if (req_txq < prev_txq) {
>   		for (int i = req_txq; i < prev_txq; i++) {


