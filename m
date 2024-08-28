Return-Path: <netdev+bounces-122957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57BA963476
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD3B1F24346
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBEE1AD400;
	Wed, 28 Aug 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mi61UuJt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24141ACE0D
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883306; cv=fail; b=ty8MUfQaynoms7/rohCsXb6/HCOdODFisdg8wnCphpGIMNj8bEv6YkFbgGlFRIzC+/KuviPOau0u+uyDuB536awI2KOAx8kg8gQ0TiFwkv9/gnQoHrM8IiIFQKCco3R94jmS9GSJXAVDbXP/0pSZ5XfnU1XHvW2YbXZAW93nfDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883306; c=relaxed/simple;
	bh=6ENHUvoA/ewNzC73YsFzIifiLGH3UXv8amIwLPmcFk0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUMnGy8EVgjYbk9SeNi28Z5fjYGciDxpt3+A5JfFw5fDbRSXD3WrAlcmyC8DxcW7d6Ds/xn9tXVAL+sT78XITDh/EkOTRdty5I9EjpuJEh0XhSph2QuFaIY0kqkSsOTb/GRpgmmxnufQIJDb/s74dn7DQ+Csqp3aWdWa8xP2IEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mi61UuJt; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883305; x=1756419305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6ENHUvoA/ewNzC73YsFzIifiLGH3UXv8amIwLPmcFk0=;
  b=mi61UuJtZXT+QwVcLKfi9MR2hHr1A61MRTrroEKaKL3yOttNeXJVfR9A
   BePWWIklpslOpQX6K662GfOa4fIZd7wf4FNkyEsjZ8NdtFw13GBD07QR3
   KPQXfQ6YS/QgAiDC5MWjCUxyB3gfRh61eWDd6P/OuIHRPKhbaWq08PY2o
   AGLRXVqhPkmwIYR+ptZsff8YIKzCyScUM4iIJfqlAO6Py7G+jqwawTHGz
   xrkzH0bzK02V9T7g2LxcIJUcSHSahl3CY6cYzpSZm5IJvz3ZuMTQbfGZn
   JUzhaTMrruHTigqg3D4wdIZlrxWFCSO+9476iN8whnC75Q+HV2JJmjBSt
   w==;
X-CSE-ConnectionGUID: gcY3tCPWSaa31JMiLAzJug==
X-CSE-MsgGUID: b1Cw4tqiSXKa/lvAvEYD2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23588809"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23588809"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:15:05 -0700
X-CSE-ConnectionGUID: DeLTA1wwRuOwH8QCuW3wWg==
X-CSE-MsgGUID: NB5dsl2gSqKuaQKjnaqU1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68194763"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:15:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:15:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:15:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW8Dtlx2p172M4nOSF8VVGL9dIQRjQVgI0Tpbbf+YClQC974p137RfXERJ+EXmZs60DJEvkpVwf5tzpQHFkYIOA5JQdjwuGValGzU73DnNl8G6uBBFkuxpIMzE2yPhkkZPTDwsVifsfe6vFMRbcGmoFDsdENDYY3ZhirZZLp8XaVmkmKBMwW/BE/nup8U0la75CFLW9h7lnBjXrqmhEL7kMXrlml45L8s8H3LISk+OrERM1y9FRg5BkoCa9kbt1evsJjTthKf/pf7TptZKD41uSrMjk4WECxpXxnpP2wg6EGMpywnfrYsYHhM5pO3hUbBcDQeErUJ4Rf9oPUJD24qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7msoNXxKyetbe5UotYi3r1TIMlyVG1IoL6STLPpE21g=;
 b=MQYZ6onUzG+4BFRcjCcf8kPJDZyJbdb4kf6D1NfqlnlO/YdQV2sLfRBS+7kpueWXocFJtN7aRfSHJIbDPx2IRHTekbHXC2334zsPv27iavWvcVNAfOOlhHY8ZvLKGf7L+x4Ohrh9cF7CIzfQp3JPiGwVpb695i3Ee4/DBr74YrcBBrXGd11zxmuWArMOMSSU2AlthJ97YP1ByzOfl7XtKpBduaS8JF42ZwJeHiA0EUlPUvPBaVnsoHlKXZYGxNSPELeag3LJ14erKjDU66QMZ7TJt3DnzsSey0UbQmYW3Ciz5hJ/u59HoBojnUwmzdDmu9EfMzKb/LpsnsxmlBz86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 22:14:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:14:53 +0000
Message-ID: <e238122b-5df1-451b-905a-0dfbd457dd08@intel.com>
Date: Wed, 28 Aug 2024 15:14:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hns: Use IS_ERR_OR_NULL() helper function
To: Hongbo Li <lihongbo22@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>
References: <20240828122336.3697176-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240828122336.3697176-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dcda51-b78e-4cca-19b8-08dcc7aed74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cS9BQk8xR2w1enY0YjhGWHVuWG9TS25Ca3hyRVlGNUFvU1V3RTJYZDRHMlJ4?=
 =?utf-8?B?czdsMUc4WnByaFZJRkJvTWFhZk9INU9UaWJZd0N3TE80M2pUN1Vwcm5ubmNY?=
 =?utf-8?B?b29EcllkMWVQNVhNSWpXZzFDUXdnWDZYc0JieGYzUmdXYm1WMVkvdzJlWWhJ?=
 =?utf-8?B?RyswcHY3ZStOdmRqZDdKNFIzb1QxV20vMkNwbzJIL3hNWWxDQ3A5eTFiaFk1?=
 =?utf-8?B?NHRJa2JEYjJ6aUVzNGJSVUlZNTk3VFkxMXhocE9WVzF3UmFhOUpRdm5ZTGVl?=
 =?utf-8?B?Y3RaWUhoeXpibXhDK0N6REY2YnVwUTY2UEMwcld4ZjhZdlpKMHhkNDlxcnJK?=
 =?utf-8?B?RHllUDR4Mk9QZGhZT1oxYVhCWmYrQmQzNG54ZzNOMmJ5TDF4enpFdHNXejAy?=
 =?utf-8?B?WHJwK2wxL1RrYkYrUXJmbWllcXdOb0dQc1Q3eVJmWUNESUYvdXlIdzhjaTNO?=
 =?utf-8?B?QXBLb3M3NElDSmRDZzk0WmpBVUdsWEZCMUxJdzl3L2dkQVU5M1VEQTlnYmo1?=
 =?utf-8?B?V0V3cS9oQXVDaEtJdVAwOE5vbll3Nld3TC8xLzdkdnlmcHN0YUxXWjdPTWhj?=
 =?utf-8?B?c0U0Q0RkcmR4S3lKZm43MWJ0V2kvbUxKeDRCK3JlVlVhSnc3WEp6S1orSzFo?=
 =?utf-8?B?a2lzNnc3REF6NWFwZVdtcjk1WGx0LzJJUmsvcHVUcndVaCszUTBOZUZTODln?=
 =?utf-8?B?RDRJRy9iTGtzWk1ERlFwVmpyM1Q3Qk1vYmZ2SW1rbVhsZ01abFFjaGpGamxL?=
 =?utf-8?B?K25XYTNOUmRCTUI3VkhKNnVmMGV1R0VrR0xvcW42Y05tN0tXYmJyNFQxZm8y?=
 =?utf-8?B?ZVV0MktDaGNWdXRFd28zenFpRHkvUVV4dXBucW55cDNoWHVDSGdjUHl4RmZT?=
 =?utf-8?B?czBkTkpRZm9oZUxocGRpTGFidFA0dmV5eVBFQmUvT2VTdStqV09SNTJKODZZ?=
 =?utf-8?B?NHdqTHdLT083OTM4djZmcEdlK1gwbDUrOGZ3WmpEMkNjQUFDbHZmMXprazN3?=
 =?utf-8?B?Q2JaTS9PanpvOG9zMVd6VEgyL003NnZuV29veHQvbGIxK0F5WFNaMmUvbWsy?=
 =?utf-8?B?dWhiK3V6SjJZMDRWdnQ5WTd5Q0JRVCt0RW0wamRpNXFKQndMV2E0d3k0bFpL?=
 =?utf-8?B?Tk1NTGxiWkdBeFZLclN0eFVMcXF5cDVEK2NjNktYdVU4eGh3TWFGR2loQ0J1?=
 =?utf-8?B?YVdjNjBUMEU4TkJkaG42MkxLcDd2RTJBY2hMQU1RdnAzM3ZUVVFCQW5yaENs?=
 =?utf-8?B?Q1pwbWg3MVdxRjA4V1Z0MGZKbXhJSnpMeUd6M042ajZ2VEtzdWlwZXFRNDZq?=
 =?utf-8?B?clpQVzhGMmJPRXl4Rk5rMGJoMW1PSXdaS1FvT1BQb1JnQW9qNjlUR1BkUytP?=
 =?utf-8?B?VmdBc3VaK0cxdy9RSCtPOTRvbVh4V3RVeU03WmFMekVQcmJ3K01iQlZqUUpI?=
 =?utf-8?B?QVhSUG5tdE5Iak5tbC9yTE5ZclNYMWt4Sm5ETlMzaHNmRUxVRTV5RDRjR3Vm?=
 =?utf-8?B?M3hTeW0vaXlCMjB3QTgxNHBTZ1ZLbXJwSVgwMW9OWnY2NXRpc3RISk0wMllD?=
 =?utf-8?B?STdJV3NXMzJMbGttaXAwcTdvdUJvRlV1ankvRVozQjlCQkpwU3JQTDYvZ0FK?=
 =?utf-8?B?VUN5MXBoRFJoMk5wcE5SNjVseHhWaDZJRlROaWZQVUJaR1ZOYzM2SlFrYXhj?=
 =?utf-8?B?aTJDNFRnZE9JUk1EM2p5NmUxZ1k3eitNK21IUHl1UE9EWElZVzVPWDFnbTZ4?=
 =?utf-8?B?VjI4L1NnRitDTVBQWVZZWXlSaEROM01PYUlGTlF5Umh3Nm4xSjhOOFJ1WXcw?=
 =?utf-8?B?UzM2bHN0T3N3UGJhTERSdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnphbFMzamxMbDVLTG5td3N6dlVQVlNtR2dNcDJlajdaTndoWHNwS21NNktF?=
 =?utf-8?B?WGlGMFBsZncyUCtINE5pR2o3UmJERDJMTXVHSUlBSjh5a0E3QlZ4WlhsMmVp?=
 =?utf-8?B?RUdRYW5hQTFtaGRoZUNsWlVnSUtDQW4vSzZDNUMwUVlvQUgvWlZLdmkrQURt?=
 =?utf-8?B?MFFJOXpJZEt2bjVydUE3NzZLZjBFNFZBUkJQTyt0dHFUT3BFcXZRUFNEYVJv?=
 =?utf-8?B?OXdmMXF2Qkd6Rmlsd0oveHh1dGFGalVWQ3dlZ3M0SUFZbm5UYUtnK3ZOZm9k?=
 =?utf-8?B?OUx2N0ZRcnZzQTBzakJpS1FLMnhrbFFtZXJ3WDNKSWJtcFFQNllZNUxUVS9o?=
 =?utf-8?B?RURDVENtbkdkODkzNWpwcUdmRURKaFFuRVd6VllEamN4bkVuWVZISGMwRmlF?=
 =?utf-8?B?dy9adlRVbzh3VVdSL1EzSHhvdHc2cUFFMkNxVkxiR3lKM25ZbU5PWDRUOEpB?=
 =?utf-8?B?Z1dTOW5tUFN6Ulk3M1Fla0xyUkFXUWtuV0g2Z1ltaVVyVThvOEwrMXVOeHlY?=
 =?utf-8?B?L3hFdHp5Wm5UeERWeGhJZEIvamk2YlBtUU5hNnVkek9PU1NNajBYNzZRQ1c2?=
 =?utf-8?B?clZmQzV4QmJET0VVd1Z1aTlValYwb0tqejZIcDJtRm5Vb0xFQVRDMDErcFZx?=
 =?utf-8?B?enJSTjZ6cnpFUFJOSEM1dU9DN2FMNVVJM0ErMllWYWY2eVl1RHR3NkNWaENC?=
 =?utf-8?B?MjJnK251dlBsUnlvZlR5Y2FBSytlakJFZG5Ob3JWaFozUWRxWXZBSWRld2ZG?=
 =?utf-8?B?aVpoUlRFZVo1bmQxT1pxOGlXMnVIMytVMzJvTU5ESC9VUllOV3JyemxicnVy?=
 =?utf-8?B?Q2pQWHNZREZWazM3WFZFYTVnSmRPbFJ3NTRIZjEzeTcrR3E0RzdqcUpPVEo2?=
 =?utf-8?B?T1BTaERkaFNyM1NwWWRrZ3E3SVMzaWxZRnlUeGV3WFBaWFRuQ3JKYmMyaTVF?=
 =?utf-8?B?WXdLcE05N1EwUnlERDVhYVdITDNra3d1d3h5MnhqRFp4UGtSNnBtRFFDRWRY?=
 =?utf-8?B?Ni9MQWdILzlIcWYzL2ZVYjhOZGRjNjNxNEpDVXIzbjlnZjRxMElNK0FnbE9y?=
 =?utf-8?B?NkRzdXZJalJqZHplc1F5ditzR3hvQUVVMXNmUnpuUGwvZllXZlZMdzlxT2Rw?=
 =?utf-8?B?WVJtQ1VrY0lCSWhDeVp4WFRrYS9mY0tBZEFGMDNXTjQ4SmlFY3ZiTDNMcmda?=
 =?utf-8?B?bVlqSUF3dTh5OS9iVXpheUx2TmxsMTFPNE1HWTdhVjFpOFhIazRWN2tyZzFP?=
 =?utf-8?B?STRlZnZmRnpCcHZtZ3EyNzRFNTFxeUNzNXJacVUyeEhWMktPcU9FbWVCN3Rq?=
 =?utf-8?B?L1lpM25weWFzeFViVnZ6MUNyUVlsR0Z6RUZONXVyUjQwWjBTemNxY1d1TXo3?=
 =?utf-8?B?VStBcVRjYndPYjM3bWQ5aGE4MHdTblFPcFpyZ2JoR2V2VGZLTG5xbUFJdUtX?=
 =?utf-8?B?OXRCeFgwOUFaaHpNeEdTalJUaWoyUCtjdW54NDRRRmJ0b1hIejBJdWswUHIw?=
 =?utf-8?B?Yk80K3FEMmlOYmU4bVlsSkpESDM2TUFtU1VWalg2R1Y0Vm5wUGhseGJFdHcy?=
 =?utf-8?B?WHpKd2hnZ2tpa3gwM1A2YnZ6dnd1aWYvc0dVVDhuVExleXkvN213bnNrekdn?=
 =?utf-8?B?akpiUVFiWnlxVUQ4TkhWVGZXWnREdXAxMWxQaUZQQTNFSSs0eThJTmNqa2VG?=
 =?utf-8?B?Q3k1ZHhxQkk5eCs5QjJnM2g4Qk5raTA4ZXdiQVlROG9Cc21CWnBzMlhKWTJY?=
 =?utf-8?B?ZEJyRk4zMnpXRndqYzhzbHJGRDZNZ21XWCtOcDNpVmhZZWJjbk9jMnowdzIv?=
 =?utf-8?B?RUxjVjdEWGVRWlczNWM3b2NyVWFzK0kvLzlSL2ZMSkxnZWR6YzQvQktPdFAw?=
 =?utf-8?B?S2lGSUs2V083Y29BWm5RQTRqVXp0YnBRRFhNQWVlcjBkUWNWcnB1Rk1Fd2Vt?=
 =?utf-8?B?clNKSE45Yk9yMFM0TnkrSm5mRmxjUGthbDROUUNJZWZkOHBwT3JBRUowUWNM?=
 =?utf-8?B?RGJ2Q2ViSzVRQi9mMEJXT3lSalp3dDU4QnV5a01lRmJpdG8wdDExOThBSDBp?=
 =?utf-8?B?Mm5nbzFYSG8yeXBUdi90YmUrZkF0R3JJOXJKMWdETGc5MTI4MnVTKzNqeGVj?=
 =?utf-8?B?U1hOZkY4TDJMUTMrQVpmamw3VmU0S291NjdwRTl4cXM5YnlYN2hZRHkrYUxV?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dcda51-b78e-4cca-19b8-08dcc7aed74e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:14:53.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJtV+6k4KfU6GVpdn1sUQoMPn6rOdDcMxZFDf8RlNyTDYJB0FVC1WRfG/iVzhrcDMtZth/LdEEDNN6SZZFueqS2n8nY9FRAlQScl/+lHwbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
X-OriginatorOrg: intel.com



On 8/28/2024 5:23 AM, Hongbo Li wrote:
> Use the IS_ERR_OR_NULL() helper instead of open-coding a
> NULL and an error pointer checks to simplify the code and
> improve readability.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> index f75668c47935..53e0da0bfbed 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> @@ -734,7 +734,7 @@ hns_mac_register_phydev(struct mii_bus *mdio, struct hns_mac_cb *mac_cb,
>  		return -ENODATA;
>  
>  	phy = get_phy_device(mdio, addr, is_c45);
> -	if (!phy || IS_ERR(phy))
> +	if (IS_ERR_OR_NULL(phy))
>  		return -EIO;
>  

This does collapse any error from get_phy_device into -EIO, when you
should specifically check and return the PTR_ERR value. I'm not sure how
useful that is, and feels like a separate cleanup.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


>  	phy->irq = mdio->irq[addr];

