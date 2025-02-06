Return-Path: <netdev+bounces-163345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A67A29F70
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08BB166159
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CA155342;
	Thu,  6 Feb 2025 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRhlGF/f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D046BF
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738813261; cv=fail; b=AJ5TvGrRAgNw/8y9cHLO3MYxq3x2LT/aHmCkJiFV/zVnx9MSgNmva661wQoJb6lBGrNi3DdNJkf96UdpGPuqmae+Jxw5Sa0Wr7F57dl17Stm3FZ/W842tTmcqJhmvtuI2Q78syqZXxeCW1+vDtR1F+3qIDN89TILm+OnM96ie5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738813261; c=relaxed/simple;
	bh=UczeTj541y1sYUPBp5GDl7P7e5KuFAZNtWL3bU+8uy8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fzf9x1wTkVtdpOwl555QKjHH7v6pSlFJdh/t/rlHzfj8uUE0XKhMHXMg9CXsj1nLtO7caM6xmduT2Gkk+h1LhitX074Qs+JQ1RzQMuGr6uSBvWHqHDkl6XFf3iGDEuKBRNRuL2Xv7gZQKws2vEjGA78wrMAsaV2SXHh81TFHtAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRhlGF/f; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738813260; x=1770349260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UczeTj541y1sYUPBp5GDl7P7e5KuFAZNtWL3bU+8uy8=;
  b=CRhlGF/fHqm1pcIorvmEdVFyEsubjID365Ai9sPLnb9ZmghLlpQzKQL4
   i9eNYGXuI1TRxAEwbQsruQ2tmRMXs90vWjTiR8468EfKD9fJ6roDnBryb
   CgbUSZgZ1R9teD0bli9t0xtCUlDHBUN47M1UV9OVeCBpGHc/3gg/foGv6
   qV/RC0DL1sox10bNFwqGqsHdgZQ8MawA4uztgkveJH9bDHqzp4f65Pv3R
   TuSimZRsf0Y40MY+cgwmkeThFhxZM8mi1noSPhAoypxZAV73en+2dfa4d
   QAGk0nqT4G17S3qPhQvoJ+brv9Alovt8caGO9BJ9M2isgtFl8xfKpURce
   A==;
X-CSE-ConnectionGUID: OvOMwVtCT4S4cQ6fJmCXSA==
X-CSE-MsgGUID: 8yIkJmbsRTqMX1mg93L0kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43062240"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="43062240"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 19:40:59 -0800
X-CSE-ConnectionGUID: gvGF9hS4Qv26WD9BEDsZXw==
X-CSE-MsgGUID: Qf1qebAjRQu97AFqAz5qJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141968455"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 19:40:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 19:40:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 19:40:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 19:40:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwHAafHPL3JHx7KY4sO/EIxUBMs8/NpGudDsjvVxsJ+TIam0PB0+tfco03ZjlwWttvqTRngw7vEobZWdWnMt3w1b2OWIQZy+pf7WNvRUa6LfCSgRXtg6Grzihmg178T5TN6mcXcWxarSMeWz7mzwQ7x6N+e/JatUlHobxIO+I6fwXb7C/3F8lXheuhiOhmJjdXVnsVSFjzXGL8ZgJdt1j6ct6MeUv1cnmRdpo/X5fgwnpvwWKZ2nGvI67AxtP6FsZ2KPUgYZxO4X3nqw7A1mAsQtYMb+ytJ39w5qhdR6kTRGlTL4i0d2Giz/EJMnDLKMviF8kbHtPTzLdBbf9ab1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6C3PwOGpPtUbGBpMu8fiCEbU+VmJj/6DuY6FA1S2Ew=;
 b=tTLuYFS7wtcpM3ta1YaGAg4D5NqzUoHstHTsdVyUmizboEy/KN0wfowDg91VSfGV9mmFI9zUlUBqqNJxt4uTl9yr7BfN3KL9koQ4e5PqHCK5xXKpDNu2NFVB0ATCc2qBNUxC2pZqCb4PlI6H2MqHaveSd6NzOISWd9wA2q8HI5lNq63U1DOULTmBYGWFulsNLc0bUI4m/QIoxDWAUxVN+QiLPu2SEMC8nG+CO33PE71YfmL926PzpFn1apw7X4E5vSwGaGC/29DqJeevEWt8v/0EXItBgLUeupA2lBQXOMxKVV2FXqlu104IK4ZJ3KizXdyJSgP3MweN24hLpD3RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 03:40:55 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%6]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 03:40:54 +0000
Message-ID: <92cdbb04-4a59-41c7-954a-676d21ebd8f5@intel.com>
Date: Wed, 5 Feb 2025 19:40:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/4] Extend napi threaded polling to allow
 kthread based busy polling
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, <almasrymina@google.com>
CC: <netdev@vger.kernel.org>
References: <20250205001052.2590140-1-skhawaja@google.com>
 <20250205001052.2590140-4-skhawaja@google.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250205001052.2590140-4-skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cf6364-b944-4249-d2f9-08dd46600f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjNhaytvcjFPQzN3TFpsMGZNZ1lzWXJWVUYvYmQwaVJVNVMrdzAyY1ZhcUx1?=
 =?utf-8?B?VjFrMXBvbHZIazRVdUdRQUF1MkxLMURCemhnZkJkV0tUdDNYc1JWS3dSc0dU?=
 =?utf-8?B?REh0WlZQWGVhY2JJSkZuZHQ4UUpQQ1NEK2pzWE4xOWluaDM1QlJyZ3U5U3Fl?=
 =?utf-8?B?eURBYjd0SGVIdk93V2lsc3NQY0tQU0VUUkZtLzZEV3VXSU56ejRVT1VvWHFZ?=
 =?utf-8?B?Mi9wbGV0U2hkNVM5YjdlWSsxQU5jTUVpdk9kNm5JMFNxUWNhUTZ2YUdNWEV0?=
 =?utf-8?B?UjZIWEZNdzZXa1U3UU1YOVZ3WnNBcmYvK05iOFlZQzNhV3VIUW1ZRVF2ZFl5?=
 =?utf-8?B?YU0zbllwSC9SaFpnRlA1VFQyYzVTWnZYYmtwT3ZIMWRHc1J0aFhyU1pBaXFo?=
 =?utf-8?B?NExmanNmSlhGamNzNXJsM0xxMDhjcUdhNkN0eXdjdlZWemlOTUo1c3oyNnRY?=
 =?utf-8?B?ZFdzRXhHK0JFb0g1UzREWXJ2YWlPdEw1b2dKcTBsd3BCaXJjOFd1SmtFNjRu?=
 =?utf-8?B?UE93WnFrUTJ1S2VIUVB2bE1WL0NmRlpSajFoWkdOQnJUdG5kTkNVMmEzb283?=
 =?utf-8?B?blNCejVLZ01LNUtrU3hkSHU3aDcyWk1PV3VoRGR6ZjhlTEkyNXZZYUE5eTdN?=
 =?utf-8?B?NGFvZzE3b2NEd0N6TXFWSTROVlVMVENwZ1B2WldTWWZFbjNscVZ6UThSb1h0?=
 =?utf-8?B?RXA2TDh2RnVwZzBjRGRRbHlTZkFWNm1qRVVEMW1YVVlKTm1QZ0JVaGNCSW5C?=
 =?utf-8?B?NnRjRjhKZi8zM1hidGNHNGNhR0JESTRiVHhWaVVrZ3lIZHV1cFh4L3ozekVw?=
 =?utf-8?B?enRSRVo3Z1pYVVp2OUxGMXplQ243a0FPUWt2WlFOYWhjSTJjUHBQMHNlM2tp?=
 =?utf-8?B?YVZxZHNmdENydDBLL3NkTDIzNUpnYnVvNkxlVEs4ZFJLSjl5dXk1QkwvVFVL?=
 =?utf-8?B?emRjRkUyTEFsRWJYbTB5YkoreXN4a0N1OWlKUWFSVEZiN1MrZUlzcEo2eG4r?=
 =?utf-8?B?RHYvdEV4R2VOdWxBUEswb2FCRmp6TWtLU1UxZjYrajRmckMzY2tHNE10YmJ1?=
 =?utf-8?B?VmNxdjBjbVNqYUI4bWgxMFpnU2RQbkN4eVJwVXZCenU5aTlwTnRuMzlkUUt1?=
 =?utf-8?B?c2w3R2NlaEs0dnVMNTVKdFNLN3BseDhIOGdCSUVWNVYweFdBeTVhb29IMEY1?=
 =?utf-8?B?NkdzR3VqYmVnU1MwanZuU3BMNWVFSmFaSHZqZS85YnRuVm5NNVBYYzRlYWgr?=
 =?utf-8?B?TzBQdFRYdEY1TmZkWlVGaEJ5N2M0WXAyN3VKRkZPQk1NQTlvbDlTTE02V0xZ?=
 =?utf-8?B?TzV6VDNsa2lHMERCbHdHQkd4bVI2eVdSTTVNKzdBbXhCdnVEVFVRaFg1eU14?=
 =?utf-8?B?bnRiSEtUSks0L1E2OGs5MVhxMWF0cWh4aUJlYWtiZmtMcVNpMU04bUZnckxh?=
 =?utf-8?B?U1FiZWU3TTBxQXlKWkZTRDUxT1RaU000a25rVy9LN3RBMk1YZittOGRjTlJU?=
 =?utf-8?B?YklDTTJtZXM0aStTWnFkeVBIOWFZb3gzRmgzcFIvNllMQUZ2SzFiRCtKbDgx?=
 =?utf-8?B?UDI2TkJOaW5mMS9lWWk0anozMDQvUndXTmVhdnFjVm5Oc1ovalZtekNVcEFK?=
 =?utf-8?B?L01RbVUyMW9QN0xRQzlhSURxd0tTMnh0Zy9aNDZka1hoa0FJM3VtdDRkbUpI?=
 =?utf-8?B?STlWTFpkeG5hOXpzSjRUV050UGllY0JwL2JNejU4TGMvOHJxTDlLRU0xdzNZ?=
 =?utf-8?B?Tk9RM0x4NjJKZXdkV2Y0cmlOT3ZZR2lWVkZuMWVyc3RiMW5kRmU3cHF3RnZ0?=
 =?utf-8?B?cWRaVkdyamZhWDI1QVdXZGhya092YUhWaURJdW51Q1VaVnRFOGY4ZncvV1BK?=
 =?utf-8?Q?SGEln1hxbNHOz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9BSTFQZUNLQTd1ZU52alpJc1NVejAxWlQzRW5odElCUXJEQjIzU1dVb2dO?=
 =?utf-8?B?NDVmNWZ4WDlMTXRZSWdWWTI0aUZqQ2dSeFIwT291V0EvSUNaYmd2elhXOXRM?=
 =?utf-8?B?cTZsY2Y5eG04U2VyR3FEQm4vRjJRS0hua1ZTaUVGM3p5WFNYclI0eFl4VVZE?=
 =?utf-8?B?cUpqbGpFZVFTVmViLzM1T0FablVHVFFscWpDbXlpQklVTkZ4WE1pMDA3dVBZ?=
 =?utf-8?B?dXVkaERDbTg0UU5WbktEYU11a0diSkkzeGZ3Rkc2S0c3NWIwV3VOYTlWcTVB?=
 =?utf-8?B?WlNUQUlkcERaMVFFU21PdW9mVmJKT0tuUUZCM0o2Rm5hSnFRRnBzVTNFdkpq?=
 =?utf-8?B?VzNKK0xSLzZFMk0rbVVpdExNeXFQbllJcEN4Q0c5UVNsaGpMUEZkWUZvdjNs?=
 =?utf-8?B?TnB1ZHVGclErQmdrVnp5cTRLZUFUak5MaXViMDZjNWh1ZDJqbTVsSjd5Y3ZV?=
 =?utf-8?B?b2dwMGE5ZVNIN253bEhCWFBTUXd2RkZGYlUrWThNdFltaENQeGdUd0ZCcmtU?=
 =?utf-8?B?T2JxNGRUR04wREo4UG9UOUJ3dEg3T3UzK1VhQXJOUW9pc3ZDK2dDRVQyOFNL?=
 =?utf-8?B?Z1hGbHRQWTQrSmdpWXI2YlpNS1BlUlhWNGlaOHdSdlVjd29nYWJQNXJOYXg0?=
 =?utf-8?B?d2ZpUWJIZmRZSTN2TTRBUS9XV3EwWEpOMXkxSWpPbUdmdjdmWW91dU5ZeTB2?=
 =?utf-8?B?NlZleXRlK1pmdzJKRWkrRU1aM0hHTnE0S2pPTkxEZHpZZmR0Z1o0c3hxNS9E?=
 =?utf-8?B?NDdOL3lnNExlOTVZeE1kbzVPSFJMRERzRDFpUEpzQUtJaFhldlJTTUNyUUl4?=
 =?utf-8?B?Z2l2U1JFZnhvZG00NHNkYkNmbm8wRkhvai9UT0Z1M3JxSGo2elk4cWpjbmRT?=
 =?utf-8?B?emlQYllJTmVPeitUR1hJSVk0WXZHbERITVpkdVU5djBwSDYzczVia0pUVFpX?=
 =?utf-8?B?cTducENmcUoyNE5JVS9lTm42bElWWE5lZGxoNzNkWFlSMERpWnM1K2dsdWVT?=
 =?utf-8?B?dVMrQXA4WjFWTUlzeDd3WFZsdWtJR0tjQWc5VStKUHRkUExQc3QwaVpZSm1G?=
 =?utf-8?B?UXZlYTVaR0JjcWZMdk1iNHU4ZVhxRHE2RmoxaGpkUGs5TVpnVmI4ZnJaRXRF?=
 =?utf-8?B?STdsQUFnUEJKd0tzV3A4WXV2ZkQ5TlBaM1o2T1Y0MmJyS0NPblE5TXViS2Vu?=
 =?utf-8?B?Zy8yNEhiZW1Hd3pNblpyN3RWbnpjU2IrOGt2SjRoS0cwK01UcERjSDI2QU5u?=
 =?utf-8?B?aXpqR0gzUjlXanJOV08wWkxleHY4WXZYR2s3WUI2SU1wUmNxdmE4T1V5OWVL?=
 =?utf-8?B?M2RzYmFlY3ZRWDhRNWJVRHlUVEhjK1NJcXgwNkhpaWxVZWkvVzRVdlJ2eGZv?=
 =?utf-8?B?UGVyT2paRFdyTnJyYTJIbkV1RUErSlZQSkg2RTlxTEpPMjJNSGZsQm1jdnc2?=
 =?utf-8?B?aFVBazU5MFIwNThOdjBQalBjR3dMRXN2NWdjaXZoZFJFY0V2VlhqbjdoOEVM?=
 =?utf-8?B?YUxJZmdjUVpxQWt4VUNwQ0IwVGRQYi9jYmx0R01PQWtrTlNFUUhGeURIbWdO?=
 =?utf-8?B?OE5qbGJYdlFsejBJcTlsYWljSW9aajUveHI2eHB4V2hMc1l3S1ZBM0JBc1Zv?=
 =?utf-8?B?b09VQXU2OW52L3lGK084QXpEZ0ZSNlQybmgyNFNmdHFhL3BiNmJpa29lNHAr?=
 =?utf-8?B?UC82K0Z0Yyt0b09FRXpGM2JYV0h6RWI0TnlnclNqbzBuMXNJWEd2emI1cm8v?=
 =?utf-8?B?YzZIRTZBdmFmSzNORW1HQjdGLy85TUtQeVFVcmFwUGc5N09zbk9NbDJtWjlq?=
 =?utf-8?B?UEhFM21CZ3lzV0REK3pTNUdVdmZ0eFlyZ2wrZWhTdUtIcDc0Wk5oMFcwNGg5?=
 =?utf-8?B?Q0FNMkVWNzlxbitGc0xQZmpadDl3Z0hMend1Y2oycnEwUGFGM0JMRzEyZFdK?=
 =?utf-8?B?aHNkbGxJbHMxYXhVYWtqUjB0ZmtjVlR1dStUditwRmJDck9xT05pMTkxTUF1?=
 =?utf-8?B?YjJBV2JTMWFtL00yM3RmZWExS0FQdmpZQzVFK3dyek02aG90ZzhwbG9peVF0?=
 =?utf-8?B?S0RvbTRSNEVaQkV0Zm5CVEJsN1hzUngvTmZObHdWdXdnUUdpT2ViWm9iejI4?=
 =?utf-8?B?UDkzUWtmTGcvNDJ2dm9rNnc1bFBwVWJCVEgvR0RXSThXRlIzd1VuM3JWMVFz?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cf6364-b944-4249-d2f9-08dd46600f80
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 03:40:54.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLH36YRVULHRzreijUM7oD753M035qlg0ufA+tSdHP05VXxV8pb6hV7KHhAB549BnFITUqaQYm7ZnbwX64adsOnZyGMuAClyfWjJhZzwxFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com



On 2/4/2025 4:10 PM, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
> 
> - STATE_THREADED_BUSY_POLL
>    Threaded busy poll is enabled/running for this napi.
> 
> Following changes are introduced in the napi scheduling and state logic:
> 
> - When threaded busy poll is enabled through sysfs it also enables
>    NAPI_STATE_THREADED so a kthread is created per napi. It also sets
>    NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
>    supposed to busy poll for each napi.

Looks like this patch is changing the sysfs 'threaded' field from
boolean to an integer and value 2 is used to indicate threaded mode with
busypoll.
So I think the above comment should reflect that instead of just saying
enabled for both 'threaded' and 'threaded with busypoll'.

> 
> - When napi is scheduled with STATE_SCHED_THREADED and associated
>    kthread is woken up, the kthread owns the context. If
>    NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
>    then it means that we can busy poll.
> 
> - To keep busy polling and to avoid scheduling of the interrupts, the
>    napi_complete_done returns false when both SCHED_THREADED and
>    THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
>    early to avoid the STATE_SCHED_THREADED being unset.
> 
> - If at any point STATE_THREADED_BUSY_POLL is unset, the
>    napi_complete_done will run and unset the SCHED_THREADED bit also.
>    This will make the associated kthread go to sleep as per existing
>    logic.

When does STATE_THREADED_BUSY_POLL get unset? Can this only be unset 
from the userspace? Don't we need a timeout value to come out of 
busypoll mode if there is no traffic?



