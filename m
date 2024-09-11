Return-Path: <netdev+bounces-127303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5C974E7E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA431F22B35
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028E15098F;
	Wed, 11 Sep 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3Q9dowB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864F13D2B2;
	Wed, 11 Sep 2024 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046995; cv=fail; b=qNJ/Mm5DOxTR52ZcKcNkfIk/wVcG82L43VId3VhselL6KdYZRh2mWDKjoH05gjozuOOVUszavBm3egRGXwtwcgdN1Q+3sOQgRtYJfuCIpf/ohnMlEPBffI89FKzvjDtq98pGLfnZzkjIbvA38y3G3wn4874CiFKcLRYu50lT4Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046995; c=relaxed/simple;
	bh=uP/rWBz+s/fQTM7/H2Y3+gfIjE9weSn+Tk6lXZKwENE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iAc2io0RFu2yU+AqE+nqv20HV7jaGMEGUNuYmwu3YWvd7bjQ5H6vXQstBPPUP5UZ2blRwhAZlPodHyfPUkv4VowEss13/KknsSqUamZGYeO2z7kn/kodG8IhG1WwSgqKYfj7T9M5Z2bLfBlfWxqciF5ZCqhypfRhwKdpd9oiyDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3Q9dowB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726046993; x=1757582993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uP/rWBz+s/fQTM7/H2Y3+gfIjE9weSn+Tk6lXZKwENE=;
  b=f3Q9dowBD7hJqrcGgEq/KgETG1ku4taw9vK7987s4wt/0AktVAzI+7V9
   TDcPj0Oz6cI7wu8PFa9a8tr8TAq8Ykggd5hbJFVUvM01s2TWV1XXG3wVL
   uMYtTenpp2IyDP+kHYPb6fQ3K+XFsHdAFJL4nPZa5VgHOxAo11gml9COR
   17pp9NVOR3wpCGlVHrdFTpJaSD96hSL5YvTsOU3Ec5OrVoygB7WnFwMLK
   X0pPagoLozaC19iympL1KEcjC/Gy+lFIUDbThOwvMlDWLNHk9HvQTUED4
   V8/A/xFbn8qghArluD3PvGMwnVNq2eNr4p3jeofTq/nPMeVJtc4iAX69v
   A==;
X-CSE-ConnectionGUID: DwKhMVR8Tl+FnIvhoO5+mA==
X-CSE-MsgGUID: IzkF6yiLTPqZXznl1XrflQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="50247879"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="50247879"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 02:29:52 -0700
X-CSE-ConnectionGUID: 0H+uG1cATP2o53GodQ5QlA==
X-CSE-MsgGUID: YEnDfByXT+S48Z4+QNg2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="98012972"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 02:29:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 02:29:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 02:29:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 02:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqyTcnUp6Q7Q/VAEzx3+B5imkaOtpBzRVxA2qxK9lUTpahiBEXvB9kICaJg9ZENuRPKrh7iizBUyPjdiWrWdTYVl4T4lP9YjAnkufcMD2kOD1HTdPkPY09jnlL9HeIv9wn8uDlKpXKk6mwWLrvPu6ZifMWft2kBwn5KABn6IBHIoKthCGj/tyC30ip3bgxf97eb7p0LOk04V3wQuSM1m82OLAoOyjgIUppUJQKS+cjqtp+vpCi32WIg/TcIF+hPNBgDZPMeQaNWbejYQrgX1ZAYGmZMl6UbBUqoOFFRwyJeeZ5S4kJ883Dmr+M/epBberJU7pnpE13Ps8MLqfgtzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVHdAsBjcGS3l/exTjZLTXXVQ0BP7+p/BFdLIzCsEYk=;
 b=jTa7Cd0eKiMGE99MUMAyG9fSAlK9DaJ9kqOvWV6fMZcSGOI61HGyWzsIpaD2nOMdF1J2HUZIRdbGBmpgfABpYcjKGZSkNCBzgI61Zjet3sCJgmDIla+QYeCHJVNV1FWs4LavLwVvszrVfrW8NlSkrOZvk+bXzMbauZwVpE89BAY9DysTCLmPfKWf0uZei5O7+Jqg4lNcK57P4jMZsWuG4XFugfPJ0P3c81NfR7Sc3PUXM5h+E/ATPZ8Zj6jzFIi0Dzjd8CN1wROv9XjNbeJOhQOVsrroIHN5b4IB88N8rLkrK9Z82TgtDGW7dd0ZxTZzohaCQU3HsPVPK6rXiJ4M4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB6539.namprd11.prod.outlook.com (2603:10b6:208:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 09:29:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.7918.024; Wed, 11 Sep 2024
 09:29:49 +0000
Message-ID: <26614b92-4d24-4aff-8fc3-25aa8ed83cb6@intel.com>
Date: Wed, 11 Sep 2024 11:29:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: seeq: Fix use after free vulnerability in ether3
 Driver Due to Race Condition
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
CC: <wtdeng24@m.fudan.edu.cn>, <21210240012@m.fudan.edu.cn>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <davem@davemloft.net>
References: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240909175821.2047-1-kxwang23@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0071.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::22) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: e33b3085-cc75-49c6-fa9d-08dcd2444892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0JZV1JpS2RIQU1zN1RNOWZ5eXNUQzhvNDUyaDEvSjZwaXBhT0lDQmZvQ3RI?=
 =?utf-8?B?M2NsWkljTFdlSm1NQmQrejFXRzJDekVscVZ5K3N5UXRJODF0T000bHNKTEYy?=
 =?utf-8?B?NWw4eGttYnVOQU9mOVNOQ2JNNjVLRnVsUDExb212eWtldkxmc0hnRDVVcUV6?=
 =?utf-8?B?LzVkYWRTMkdRbktKSWRtZE9ONVE0bHNndjhFakpoa0hkL0NjVW5Xd25GZXRU?=
 =?utf-8?B?aHJGdHlDOXViSmNLVkZuNjZCd0NlK3F3bS82NVRtOVlKRXZ4Rld5UGdjWDFV?=
 =?utf-8?B?QXlkYWVwNUl6cE04aG5FZ2NDQWZaV2l0dXJzUEltNUVuWVpmRlFpR0k3b3BR?=
 =?utf-8?B?a1Jvb242UTNWdjRSdTd2OGo0a3VmeEpDSzNsVCtBeFBmVStmYWwxYWRpWkhy?=
 =?utf-8?B?MUtONDBPUUVCT05wTkV2OFVWck5oT3BnZ3RkbHJwSDNNTXhNNFlZckFFSkNz?=
 =?utf-8?B?NDE5Rjcwb1R3N0FhdXo2a00velBOMWFwSnJpT01pa3didmVVcWNxaGxid1Zx?=
 =?utf-8?B?cHdLZjhkVm1KY0cxVTAvZXhua3NQdlhmakNQSkhkZkZEYk1JcCtvQTI4Nnkw?=
 =?utf-8?B?a2J1REtVQ3JTWkI0Vyt1dnp0OWx5VWVINnR3bjRQamU2Zk5NaWROYjdzMHhI?=
 =?utf-8?B?TkpKazJCaVMzUG1BUkFtUDd0UVdHQUFDTmhwb3J5ZXRPOUYrbUM0dXkzNlpo?=
 =?utf-8?B?L0psOVhTcVJGZm85d1FRQ2tzOURzNEtXMDI2cHcyQlh2UFljengrdVIrWW41?=
 =?utf-8?B?Vk9mRDJGTDJ6M1Z5dWNPMlZKU0tTcEVyUkZ1QUtkWkNHZ3FCV0I5SXovOWxX?=
 =?utf-8?B?WkJ1RWdNUE1obkgwQXRQN0FPTm1zVlJaVm1jd2oyR1hNdlpOaUlOQU5oK1ha?=
 =?utf-8?B?Z0dJeGJUakZWSHBiRGg2V2ZYOFl6U0VvSzRpb2ttazNFZlJ5VDE2RGtlZSs3?=
 =?utf-8?B?T2d6akVUdEFtZEJ5aVExYjFVOUk2SHRleTJsVE5hVE9tTmVuUFVCOUpjK29w?=
 =?utf-8?B?QWJWVFZ5NnZ4VUpoWHhYOHpiakI3cTZNUmk5QkRkT1RXb3phUFZ4bGcrejFs?=
 =?utf-8?B?MUZXd0M0dWhFTUdVS1BSZzUyNnY1a2JGMnp5Q1NEUzFQOWpsUHB0Y0h5di9F?=
 =?utf-8?B?MkR2TEQxSStRWFQ5V0pMMmxCbVhVWDkxWFM1c1Y2Sll2SkhEM1dtWUJ4aEtR?=
 =?utf-8?B?R3FMck9QVVJyUEFTUTJDclc3NFdoWWlKY2lxcDdGZU1lMHdSWWFzWVR0dXlv?=
 =?utf-8?B?RXl6TEdjWW9qdHk3VHVSQ2IvMlRJZkhIQ2FndkY2eGJvVmw4anhEcGZPTVBI?=
 =?utf-8?B?WUFYQXAveWRFSm52WEIrMlMra0Nsc2tqbFNmcXNnc2V5cyttbVI3ZlVmZEdB?=
 =?utf-8?B?Qk5VYjlzeGhBd3h6S2xTTURkbTZMbGpyRTRPZlN3cllQZkNWS3kxV2RyYWZB?=
 =?utf-8?B?OEFTY2FNWEtBU1ZDSERCSitCM0g2S2NBbzM4UjhGTlA0dTNHbDNNaUtZWExT?=
 =?utf-8?B?eXk0dHpLWWdGUndWelJBRWswR3FabTF6a3NmejFsU212TGxaK1dEMVkrT0FW?=
 =?utf-8?B?RktmTmphNXFMOUhJS0FoMEM2MldJbVg2YURWeHU1V2Q4M3RzcVRYeGNLV09K?=
 =?utf-8?B?YzUxVGJlTG41T0ZkS3hQZUN1TnA4RE1CTHRuS3kwRm1iWFpaY1BlOWhLYU5R?=
 =?utf-8?B?TGpSUmhBYUFWemlHT2JhSkVyOWNla21LNHZERmZHT01aa0JEUkgwSSt5ZDcz?=
 =?utf-8?B?SFpJdGh3b0d3YWw4Z2dCQnJKMkY4NVdjREd2aFlCMzJqczZtUVJ5TjVGSnNv?=
 =?utf-8?B?Kzg5ZW5IN09qWndLNTVhdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkdZVTRuL3BORTFuZjBzTjFPY1RCNitEMFNrSzVRazZJN203YTFFZXN0VW1z?=
 =?utf-8?B?enBMNWJuUXgrWFRvb2w5RHQzVHowMnlEZmxKSlM2eUEzL2FVSnVRNTEydkRQ?=
 =?utf-8?B?V29TcHBaaE9Zend4aWNNTzI1Y003WUZxM1BwZXZZMit2WXJycGtDOS9jajRq?=
 =?utf-8?B?Vm1UK0Jodit1a2NGcSsrci92UFE5cVFxUHJpQlY0S2lqMWNKb3JDMnIyUlNB?=
 =?utf-8?B?RmlPMWxKZTRaSkdCWkRwVUpxSTgydFV2RENMVGhlMHFhMVBDTkR6dUhPZkQw?=
 =?utf-8?B?Mm5xK0lNNjlyS1dDRkRwL0kwaVFwMWEySnJtQmwzbGpPc0VoT212a216Vlo2?=
 =?utf-8?B?QkE3OXdhNWE2OTJlYTJmOU53b3dxRTNlRHgyUFRWMmxyMCtsdDB2THArWjdh?=
 =?utf-8?B?c0dKSTZMbHpCVkNucVpBWGpIL0U4YVF3YXVzcFRZd1ZkYldhaktXVngrVVJi?=
 =?utf-8?B?WVVTTjlEK0Naak1FL21oRGFhZGptczRUdnNVelFXZWN0bDB6ZXZ4aG1aUUI1?=
 =?utf-8?B?TmlPL1NGcWhmY3U4cHZkaDlpdXMxTW5hYTVBK3U4L1FPTFVMbHp0UDNETDlS?=
 =?utf-8?B?alpySC90TzlQY1lTNjdGRGlQNG5sZkIxdG0wT2hQOFJXK0RwK010aFB4NGx4?=
 =?utf-8?B?NUFkYW40VDExUUlwc0JrTFZidFI0c3BrZUZmcW9pSmtpaHNMNUlvcVI5eFZV?=
 =?utf-8?B?M1d6NzVaejVvclQ0U1A5ei9Jc0ZzQ3ZRaVkyUWhuaVV6Q0llTzdrQW1VeUI0?=
 =?utf-8?B?ZnBMZGozWVhYNHh5YUtqTDRkdVMzSDRFSTc1TXIvclVkVExsQnBhOEF1bnY0?=
 =?utf-8?B?M0FySDh3VlpPRnBEV1hGREUyMlY5bElSdWJUMExlMWRaNDJaNjNMb0dtMmVD?=
 =?utf-8?B?dTFwTlViV0ZFQnM1V2I0L2dsZnhqcTRpSGhiV1NYTTcwNDNLbzlyOWtSSUVY?=
 =?utf-8?B?RUdyVnRUbEdodTFoTmNBeWFJUXdMeEF1MVZCTVRWWk9kZnI1THVLZnFHTWRK?=
 =?utf-8?B?OC9YWmR6NXVkNEtGZzNkcFRmelg3eUduVkVFVVZxS2U5Z3RrSXlkMFFOby8z?=
 =?utf-8?B?WFhGZE1Bc2FFSVVEZThxa05IM0hTOUlIbGZHcFpYS2t0THBYYWZYVW9sWmI4?=
 =?utf-8?B?c29hVEYzSFlRU1U5alVGeU9UMm5FNXVvK2Y3WFk3Q3B2dW5nZzVHVDRXaVZ2?=
 =?utf-8?B?SmE2cjhSbU5KZFpqWkxyay9lbUNCV0xkZEE2Q3l0b0pBOE9sa2xUSEo4cTZC?=
 =?utf-8?B?NHgwUVJlYm5GL3lNcEc2eUs5Z0N2K1NoMVcyZVQ0UVlFTlQ0TkxNWWVkWjMr?=
 =?utf-8?B?dTNKYTNoSXNZRE9hS3NTaUNiSXh2ekYyQTVqZ1RZQWRONVFPVDlwMHkwMHpa?=
 =?utf-8?B?WVgrTC90bVBmbUNGOSs1dmwvSHF3VjZWMWIvRHZjS2hyV1BSTSt3cGhYdnk4?=
 =?utf-8?B?UmhRb3hMeGYxNWhaVEZQY2tmWjVuOWkwR0pCM01vRDlMU0ZsVEVFa0VjQTJ1?=
 =?utf-8?B?RFZxSWxwb1lHYzRQallnOXFRLzJYeDV5ZGlUR2R4NklaWkUwcnI3TkJKcTlz?=
 =?utf-8?B?bmxwelp5ekR3R0pXSnRNaXNaS3dHNFh3SXg5TCsxN0todVNlTnR2M3FOczR3?=
 =?utf-8?B?cnBZdzRiVnNvV2Q4UW5KclpPR3F3M2diRVNNNFd0UERRZDZjQzVVZG5Zb3lU?=
 =?utf-8?B?ckR1WTBwYzJEOVhRN1RWRVFubjY0WGtJaG5uK1ZoZ0xoeGZxTXVSbmZPNUdw?=
 =?utf-8?B?cmpUbHBGeWkwRlI0MXFpdkRzK1BEY1JpL3drdXN1MVk5UXN4NlZoR3o0K3Fu?=
 =?utf-8?B?SXc1TmR4ajVMa3B1ZDNSV0lDWlNoM2VrdGFXbmk0bUMwRmxtWm40YnZYQmpQ?=
 =?utf-8?B?S05oczZDeHo1enltanJSR1hFNHh3NXVIVUU2RGxJejF2S2ZHZzdiYVNVMzVB?=
 =?utf-8?B?Q2lqSnRualRHampBT2hrTmFiWGFaNzZkbWhWS0hZajdUS2xYbmNVRXgzRW52?=
 =?utf-8?B?bkNveG9GTWk3bGdUNU8valVKMmkweU93YS9QekZQM3owYkcvVmxTay9uKzU3?=
 =?utf-8?B?bWFyQi9jYS9ObWhuNHRRd08rRThRd1lFd3lheGhEbkdQTjhoMkd4NXJXVE5o?=
 =?utf-8?B?RVJ6Y0d0V0VPQUo1Q1NQR25Jc0VzczVXRFl4eTNxM2E0QWhQa1lETGFadHlI?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e33b3085-cc75-49c6-fa9d-08dcd2444892
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:29:49.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56CdvTarfwRQ3m+rg41yRkpM5O48fu7u+20tvCODmr/pQCfKPBXhAZzAWKW96JOZlQAEc6IJz3WYUJ+yAlOEb9Ghza/+xk6+XoeuUlbuqkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6539
X-OriginatorOrg: intel.com

On 9/9/24 19:58, Kaixin Wang wrote:
> In the ether3_probe function, a timer is initialized with a callback
> function ether3_ledoff, bound to &prev(dev)->timer. Once the timer is
> started, there is a risk of a race condition if the module or device
> is removed, triggering the ether3_remove function to perform cleanup.
> The sequence of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                    CPU1
> 
>                        |  ether3_ledoff
> ether3_remove         |
>    free_netdev(dev);   |
>    put_devic           |
>    kfree(dev);         |
>   |  ether3_outw(priv(dev)->regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
>                        | // use dev
> 
> Fix it by ensuring that the timer is canceled before proceeding with
> the cleanup in ether3_remove.

this code change indeed prevents UAF bug
but as is, the CFG2_CTRLO flag of REG_CONFIG2 will be left in state "ON"

it would be better to first turn the LED off unconditionally

> 
> Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
> ---
>   drivers/net/ethernet/seeq/ether3.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
> index c672f92d65e9..f9d27c9d6808 100644
> --- a/drivers/net/ethernet/seeq/ether3.c
> +++ b/drivers/net/ethernet/seeq/ether3.c
> @@ -850,6 +850,7 @@ static void ether3_remove(struct expansion_card *ec)
>   	ecard_set_drvdata(ec, NULL);
>   
>   	unregister_netdev(dev);
> +	del_timer_sync(&priv(dev)->timer);
>   	free_netdev(dev);
>   	ecard_release_resources(ec);
>   }


