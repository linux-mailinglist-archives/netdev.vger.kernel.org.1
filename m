Return-Path: <netdev+bounces-217328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BCCB3854E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C272028F3
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55250216E24;
	Wed, 27 Aug 2025 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3ilbnvh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62317E0;
	Wed, 27 Aug 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305933; cv=fail; b=fx+3n8f597qj5Qzf67jqUo7uprkWeebzKwagCvELWSFdTKu3WhMrbzI17F7YwKfwt8sdQ9Uqn0hryeUPmz3QV/wj3ZTJ1nlVlAxtNfIXxnnN7lUdJ9/QDMVzI2D5B0Gf6E+GqD5Ga0Cf0hq0pFO5+ycDrgyCpHVOix+NEl0Enm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305933; c=relaxed/simple;
	bh=sDLKtrizdcDZIPUSGMf0JSdx8Q7UIgwLfa7bZ2gi2h4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=it8RjbkIKHZFl9PzMk2qQ8J4IZebsHfICyi/HMF1NXX4wKn39KRcoxKDKXQRZ6Y0hGt7QP7bCzv2tFpUVdVJjI9BTSYs3rpcOu8+JjkUzYi8J1wlonpixy8arOq7XNJjAz6JmieOzwr7JqDW5tHiNda+KKxHGoNZ4r1CKF2fKAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3ilbnvh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756305931; x=1787841931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sDLKtrizdcDZIPUSGMf0JSdx8Q7UIgwLfa7bZ2gi2h4=;
  b=a3ilbnvh4DhOYk7oWYvca8p4ayY4iV2liKhOy2ACNXT1KJW97ARyeny3
   7s9QaTMFVvqBVt/0la0FZXKUsVf506d7QJz92OT8HZqcswdBNtUZiDYda
   BmencByYwzWC4WZhQlaMC6ChlWUIdRiXjMF9k03M0r5v0qxaidm4YlYOu
   gWWHfusm6VzVFbbAuoPxqs8FBUiEp7y/Gn3QSkEodt72eCanlK0kMWvEe
   PBhNnOJ5JQo+sENvSTsmjZBlNmaDWHG2tG01EvtJb5iynpYwtsTRX26Gt
   R7TV9SMM5VHv67AR1jKOHpWFlMN/q1FTQWWx19vv/nyz4rkKtEIpLcpuk
   A==;
X-CSE-ConnectionGUID: f+5bPBNvRBaaWPXIrXEWZQ==
X-CSE-MsgGUID: gBz21AD4Q5aJCeEGvUAFGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="57578520"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57578520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:45:30 -0700
X-CSE-ConnectionGUID: nQmcMFQuQDaXN8GDSMlqbA==
X-CSE-MsgGUID: 05wXBJH7SdyrvZVEb3W3vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="207022127"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 07:45:29 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:45:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:45:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL8gXN58fFmL3bXQgDKaXmQWoNvcFi3njtJAm9nrWElFyPliXx74h/BTgl0ZmhJL3AIlCARYyYU0ZVBc9NnW+lAvpJvqgnJIYi8HoEn9xTdBIhWq+ow5BYiOewXLM5uyOngI/UdlpJ1iNUVikmB7g1tGVnvJWq4ADvr7rNJxiCvPPzx7Eb0W9lNI9167dB7frOBrzcQ+8JBxbFfspi9ixBSqNbOqO3xUazHhTHnhbCwfQlUxFjcQjifQ+/jz18dOmRNHgsy6Kwsy9YTzNux0u5pfh393fTlj8eCKkqCrdeNl11sxll/p81mMw01OYikACHkIWse+HjmZnb3liHYrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ile8LoReir2WzzcBVunLI18NBmaUZ8D3J8WTPmvO4EM=;
 b=FUydNeThASJ7en6S3EjMGZkqpKSVdDhQiVyJtzuoprl6xwwxFxY3hhNIh55+XMgsMSJEPwDnbjvSnENvbZZn/967Yc036fAwcIevgbnqr6VsrWPRFJ1nLQtl+wjho8ob5obsJ1P9J2/xr5KrHsNkX931X1ZetwHwBCRe3FDGI4vhCtXlHTi3bm6mhSCm09MV+JFbYTQcYGiEJygcQZHffc2QGKIRr1JbQ+QJKaZCpKWxmKuL2qlShYKsBpG1FhG6HECPZsAbxe1SW0YhO6pDCl+9tinpeGI8NkW81Soat9RjBXnUXtc5sq92nMxuexo7bSpSDsg9URRpzl9OCPLqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 14:45:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:45:27 +0000
Message-ID: <ec71f1cd-89b9-4a18-bcc6-0bac6f6660d0@intel.com>
Date: Wed, 27 Aug 2025 16:45:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for
 cleanup
To: Yue Haibing <yuehaibing@huawei.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250827040027.1013335-1-yuehaibing@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250827040027.1013335-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR06CA0029.eurprd06.prod.outlook.com (2603:10a6:8:1::42)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f06dba-d35d-4d5e-78b2-08dde5785cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzVpdkdBUDg4NC9QeE4rN0s3bE5MQm9BZUVrRVhVZTJMZXdQTUFvVFRzYUZz?=
 =?utf-8?B?MTM2YUZmVEZXKzhPaWdWK0Z6S0JFQi9oRlZTSkdmS1JhVHRqNlBpa0lSSkpC?=
 =?utf-8?B?Z0l3VFhwb1VCN3FFMEcwMkRDcmwyd1dDdDFFYWk5RFcwNEpDZW5CRjk4Vlpy?=
 =?utf-8?B?Vmd1R0NqNFlsQUpYRW02MS9kNnNpNzZOSGdyVWxueVZ6MWJrL1VQeE5Rb3I2?=
 =?utf-8?B?Z0o2VVppd2VuQ0pRaS9pNWIrY3ozb1o3RWNiOE1BSVRDM2dXSEtZSTFqcDFG?=
 =?utf-8?B?Qk5LMHRjSWlEZFRhVk9jcWx5dXdoWCtTMUk2QWlnbTdTYU5MVXI1dVNHa3Nu?=
 =?utf-8?B?U2hqM3g5L1Y1UlpOMFFXaDVrQXQyVlBUWEU3RXR1STNQNCs4dmkraWpxODBN?=
 =?utf-8?B?UDJIQ0xabytrQ0FCUGxoeCtqWjJDWjZxNGZMUDVrSFhFbEpJcVdnYWgzbjRt?=
 =?utf-8?B?Zi9FcXFXQkxmUngzZFk5cjVjcVRxMkxWRTFtWmczYnRlODJmeVVJZmluRzQy?=
 =?utf-8?B?MzY1SHlpVUx6TVRQcE05T0F6NmdPZFFMaDB3a1p3WXJEd1lIeFJVRXFQWDQ5?=
 =?utf-8?B?NGxtZy9LWjI4T25QUm14KzFpNTJZTk9Ud0pIV0lHQ3JDWnVvNytzMHErRFp3?=
 =?utf-8?B?UzRUL0hzT01IaS9Zclo1c2dMTjRhRXNVdXMyYXhOaERLUTRhUElmNkZKbEFC?=
 =?utf-8?B?RTFPTTQzZklObU16SWFVVHVTaHNvRVJNdGRlYm9HNmV4dnNnOGNkdlA0RHNi?=
 =?utf-8?B?MmFzU21mQmRXR1RicWF5czQ4dVIrNmNwVUtFblZkWjhvZ2tmcmI2dWljMXQx?=
 =?utf-8?B?MkRoK1NMSVhRdVpJS1VMcVBDdXpFcHc5SlAva2pIeTFTZC91djYxY2N6ck91?=
 =?utf-8?B?T1FmUWk4eE9Tc2hPdGw2M05FckVINDNQWXk3c3lId0M1UlRWcm1XUU9INllu?=
 =?utf-8?B?YzhudEQyL0JoRGlRUTR6T25RajdGanNCMVlISzZFbjI5amUzTTRUbitHbjU3?=
 =?utf-8?B?QkRkemY0ZXd1S051R3U4TXF2T0JESnZmRVp4ME0vS3JKSWpYY0RwRTVaNWxy?=
 =?utf-8?B?aGhqQkprTVA2dG8xMzlhbTFwMGUrNWk2K1NNQXBzYmEycC8wR0JmOXFHK3JQ?=
 =?utf-8?B?WkRaN2Z3c294aVJyOGhxeXEraUp3RkZ0NUIrRHErWHRNNzhxMFR6K0xMY0tk?=
 =?utf-8?B?aHNFbzkwU1d1eHlYMTFPYnhKTUM1T28rTE9LWTVEQUxjSURsanZoY01NQnEw?=
 =?utf-8?B?MnAyMUpmbFBWbWpORDFLZkp0NFFpYWk1ek5BeDkxNVhwcDZOdUpGT2NuQ0RK?=
 =?utf-8?B?R3ZsSGNFK3VMcnhXNnFEY0ZibHd6My9zY1lPV1BBT1pBVVZvcnQ5ZUw2ODZ2?=
 =?utf-8?B?d29UWFN6Y2RJRmVtdXdob0VDcVcyZ2g0UzZtUXVoYWNoalNnblRTd0N3Y1pY?=
 =?utf-8?B?a1JyS205WlNlUmVIczdVZlpXNDUzcFIxeUdnV0RabSt4QU9ydzVYTkluVGor?=
 =?utf-8?B?dHRxQlA2bmY5d3JKK2E4bTV5V3ZCZE52WGMyZ29xUEplNE96RnkwNk9LV2ZO?=
 =?utf-8?B?ZEdXZTAwQjJDMlg0dkRCM1VwYzRhMFNrMFpTeUkvanR6NnZwVnRRN1NPc1dl?=
 =?utf-8?B?bHJkWjBNQXg1RGFEeVM0NFN6aGY5VVNEcEVGaHFTRU82YWtnVXNkWTRwMEpn?=
 =?utf-8?B?cWpLYzhHNDV5NDY3a3RIUVVQZUl2Qm8zSHJ0ZktnNStCaE5VL2RodnZkWHdK?=
 =?utf-8?B?bEc2bWdqV0FIdGVsbXM4aFQ1OVFuS0NRUnVHRTJqaFhKQ09rVEtDVkVBN2s2?=
 =?utf-8?B?amtlRVpVZ04xbjhuNWhhVndzbTBWMFl1TjhBSGNXbFQwN3NYaXRLUjdKcW9i?=
 =?utf-8?B?OEZSZXFIZFVoSWxGdlg0bThmQmM1ODJWd3VvMTRQL203RnUra2x6UjNZNnk5?=
 =?utf-8?Q?trtK5zjoHVk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejljRmM0WWlTdFZtcUcrQUNNaTlVc2xnUm01YVRISk85SWZhZy9SWG5mRWY3?=
 =?utf-8?B?TmxOM3NoL0RSdWV3N3hxZUZvSWJ4T0N2cUI3RVl3WmxYRDR1cmZaelp3STRP?=
 =?utf-8?B?UlRBOTdIeitVUU9BS1pxdTl1SmVNS3U1YUdxdmtQL1ozajF0TVJEMUFudk1s?=
 =?utf-8?B?cWFZdlhtWHFiZTZhT0NObHp0V1Nmb21mKzd5eWZsdnkrOEhSMCtaNUZBeUtR?=
 =?utf-8?B?Sldpd1ozYkVaWGFqSFBBSnF0bzNNc2lkWnhpbFhiWXNvVFhYNm8reWoyZ0Ru?=
 =?utf-8?B?WXBack1qM3lzWUIyTTZTc01oRWZQWGJEL1VVbnZYMTNVSDVnUGMwZmEySlN4?=
 =?utf-8?B?OFBxbWRvbXJtdkg4cDJtc1hFdUlVK1p3SGtTbWwwNGEydThoMS9WWTBPaCtj?=
 =?utf-8?B?WkdXU293cWxKV2l3QmZES2tqSVVsbTlQc0lncU9RbUNDUTVyVk5XWjViS2tL?=
 =?utf-8?B?Q1Q2UjNYME4ycUxoUmQwc3RhREpvTDJMTWpXN1U3ZkcvWHpMYmJhY0NjNnpY?=
 =?utf-8?B?U2NhTEMvSmFxWmQvQXdaNTk5OEczRGk5eFRjNWVBT2QzUlVGRitaL2crYnU0?=
 =?utf-8?B?cUFHVW1NMkk4T1dlUG9yRkFQL3NFcWx3T1U4VEhJQzQ2WTVKY0JhLzV1enhW?=
 =?utf-8?B?d0NNc3FEdUI5WXhkejJHaXJxRzBiM0UwdlJyZFJqV3RJeDlHajBsbURFTEhX?=
 =?utf-8?B?T3hlVE91bVo3dDBLR2F0RlVpTkdZbHcxOXplbFdUZldJcUxGV3pCbGxWWFdz?=
 =?utf-8?B?K21LaVhwUWNHRzA1N3JlS013b0pSOVlqRCtaZVFnNGNzSlFPN1VUQVR1YU9C?=
 =?utf-8?B?SzhHN0ZjMzd3SDFzVDBocjU3aEp4MDEvR2dqTkhHcmpacTI2VVc5emlzcC80?=
 =?utf-8?B?MFZXak1kTUpqRm1yVkhyQUI1UVpOTU1GOWtLT0s5blFCRTBvL0w2L2paQ1lD?=
 =?utf-8?B?Zi8yL0pnNE4xYzhJUnFVdktLM1ZDTFRMOCtKUU5QZ2h6S2YyZFk5UVp6RGRl?=
 =?utf-8?B?UUVpYnY1bDM2LzBWUzJVdm9QR2lkOFRoSWswVFcyNGVtRnRvOGZaOEI0UFVs?=
 =?utf-8?B?bllWcktwd2x6cGpDUllnZ2hPWFhTZkRIem5TVVAweDA4UklMQlNaWmNkUUVk?=
 =?utf-8?B?ZllIN1pmdllGNmFwK0UrRktUaS8xVFRtSDhENEZRdjl5NWlXUHAyWWxNblBu?=
 =?utf-8?B?emJDSmk5aGFyVGlYbzI2bllzTDBSMUd2dzRhNHppWXV6SW5RdndNYWVBREkx?=
 =?utf-8?B?VVhUZkMwMm9NZEQvbUdQNFR1MyszVFRJSmpEUXJwY3lubW5JdkRGODhFQlQr?=
 =?utf-8?B?M3k5bkYvTWdYWjI1QkM5bmE5VW9GYnpoNk5QblBLMWE1VlZ0SjlGVnhhUnpR?=
 =?utf-8?B?cGdYYWk3bVhGVmROSVgvc3hqdHNEWVEwRWhLVEZPUFRxVXVBN1RZZXNvNEV0?=
 =?utf-8?B?MnFVTnR3a3hPVm94bkNXN0VFeU1JUlBCdTFMbDZRUEVSa3EvZzJSTlo5R0l3?=
 =?utf-8?B?YXk3V2NXTVdoUTdWaTJzQlhoaFVlTWhmaEFPaDRlZEd0T25lQ1JwRmhwQWVV?=
 =?utf-8?B?eVIyMXpmRkU0ai9tRGZhZ1FGa3VyVUlCU0NzY3VxR1hMQnZad1Q0NWExL3lu?=
 =?utf-8?B?aUFLYjZ0clVOeTdSQnNrQ3NRRUI4bVUxVlFaT0t4ZGJUVDd0NXBiN1o3bmxq?=
 =?utf-8?B?SDVoT0kyZVUwNkRNZTIxaFpvRWNKSE42QlJzTTQrM2UxWGQyRGtJeExlM2R3?=
 =?utf-8?B?dGpZbmRCQ2EvVktpaWNPMnNncHNxcWdXZGpmMHJBZyt5NzNQc1ROdUpwVmJ0?=
 =?utf-8?B?V2M3QzdiTjlvaGRoSWttZWJSNnNZREoyRTRsUm1GSWZJZkdZNStSMFZZbjZN?=
 =?utf-8?B?Z3F5NGl2R0hCUzgwTHk3bEtXejIxQnlsSFhnaHBwNTc3aFgzSUM5UmVNenFp?=
 =?utf-8?B?ZDF1NVQxU3F6WjVwdmVieHNucURtRTV1dlJtT05IZjloRjNrWXE1V0YrK3FF?=
 =?utf-8?B?YXlCNUpaZ1ZleXF1ZjZydlZSWGZlUFVmTDExUzFpS1QxT0YxZ0EvbEFWSXpF?=
 =?utf-8?B?SlhGb3hrNk9HaGlqRlZWWDFGcVpXQ1hnSlBCNVhQcERGRytsYW56Q0l6a25a?=
 =?utf-8?B?REVVdGtGRW5vNyszUkJLOEJlczU0NVg0VmJTNVRUMzBVSnUwYmRBcFN2bU82?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f06dba-d35d-4d5e-78b2-08dde5785cb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:45:27.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzIqJZNllvvNayH0liP+KqWUky6FUtmI6cKTPt5HjFd4IK2qz5WHV94g5xlSgxUPWz+Scm7dHj7B1eshVLLuoNouOCR3vKCbZdZryEV3BbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
X-OriginatorOrg: intel.com

From: Yue Haibing <yuehaibing@huawei.com>
Date: Wed, 27 Aug 2025 12:00:27 +0800

> Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
> ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
> 
> No functional change intended.

...but bloat-o-meter stats would be nice to see here. I'm curious
whether the object code got any changes or the compilers still just
inline this function to both call sites.

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/sit.c | 93 +++++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 50 deletions(-)
> 
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 12496ba1b7d4..bcd261ff985b 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -848,6 +848,47 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
>  	return dst;
>  }
>  
> +static bool ipip6_tunnel_dst_find(struct sk_buff *skb, __be32 *dst,
> +				  bool is_isatap)
> +{
> +	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
> +	struct neighbour *neigh = NULL;
> +	const struct in6_addr *addr6;
> +	bool found = false;
> +	int addr_type;
> +
> +	if (skb_dst(skb))
> +		neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
> +
> +	if (!neigh) {
> +		net_dbg_ratelimited("nexthop == NULL\n");
> +		return found;

Return false here right away.

> +	}
> +
> +	addr6 = (const struct in6_addr *)&neigh->primary_key;
> +	addr_type = ipv6_addr_type(addr6);
> +
> +	if (is_isatap) {
> +		if ((addr_type & IPV6_ADDR_UNICAST) &&
> +		    ipv6_addr_is_isatap(addr6)) {
> +			*dst = addr6->s6_addr32[3];
> +			found = true;
> +		}
> +	} else {
> +		if (addr_type == IPV6_ADDR_ANY) {
> +			addr6 = &ipv6_hdr(skb)->daddr;
> +			addr_type = ipv6_addr_type(addr6);
> +		}
> +
> +		if ((addr_type & IPV6_ADDR_COMPATv4) != 0) {
> +			*dst = addr6->s6_addr32[3];
> +			found = true;
> +		}
> +	}
> +	neigh_release(neigh);
> +	return found;

I'd put 2 additional newlines here:

	}

	neigh_release(neigh);

	return found;
}

for readability purposes and also a NL before the final `return` is
usually mandatory.

Thanks,
Olek

