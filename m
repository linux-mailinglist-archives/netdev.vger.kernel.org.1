Return-Path: <netdev+bounces-99518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF68D51BA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C2F1F228D6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35F4D117;
	Thu, 30 May 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcHPyI6h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011B4C602;
	Thu, 30 May 2024 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093446; cv=fail; b=tyXA9e3chdHz5KygigZQoZmu3jk65ay548R58XWIj4vFrhHAxqHrj0A5CXR1sMjp6gmqPc3N4GzKtYxZ1Bp5PX6eB2aHSmM+pnbVK9IJplEY/Lu3OXt+wclxqrxrkmlQv2q0Vpl/tsqdIaEMazDfxksAWdOFMyqXjO5AToIxmkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093446; c=relaxed/simple;
	bh=zs6ii8eRcVfjGjrJWk5gUFwIQ6qy8YpnHPKYZ/715uw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=If4A3U3o02eKUpsZuW3G9sFXU8+LdbelVAT+9U9jfpXerc+5K5jdZCS+nM+FNIfjWgJYT44uXJ2XF8gKkSxXwrqukDK4fXn5A9OG+mIcfIEEDDbhnMMLJ3HThAkydqbRtXcBG8ZhPHJIz3zhp0Wg5LHb9qLIooB6q+RGeDvGjyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcHPyI6h; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717093445; x=1748629445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zs6ii8eRcVfjGjrJWk5gUFwIQ6qy8YpnHPKYZ/715uw=;
  b=UcHPyI6hhF+IEyextpIYOMtGs/dHgMczeqIjx1kLzvhXCJTYpJUUumVr
   2IALLp+Kv5wrqu0I3Hu0ALjPBe7ne6vIwJIRj76uO4cBWpdX5kUeyZV80
   K4bRaHdEO3F+sTO2kZaZjdG54VCaE3i85DWOeSowADkkSnFUJ/E4eU3Yt
   WIrFQb7qsC+K4DNNcWlgP6UnNwKniNNjGYwbX0ezgEo9bDZFD++AX5iow
   oBpv2wbQ4znjAbKSHASs50Usmvo1hy9uk36eQu50xC1utq/DufCvL+pMn
   dDka/H+h98Lmtg3JUWOHQbNyWbRx8vNo+lDYOvX+36N4hTIlp43UrjXTW
   w==;
X-CSE-ConnectionGUID: 5DLL8ajwRdmhfg2EHrgT2Q==
X-CSE-MsgGUID: /v26k2nXTem/Ri6HNzi+RA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13831910"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13831910"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 11:24:04 -0700
X-CSE-ConnectionGUID: tu0qY5EoR6yQvkJfNxoq6Q==
X-CSE-MsgGUID: BNGMQmdbS2OHBtS/wWe35Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40368160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 11:24:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:24:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 11:24:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 11:24:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 11:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMZzC8Z1IPVepBRthHxiUGzeplBRwWnZL3Btal7R8tcgI9cKi8kjzeR7dDlb+hHbhI4Gv2toWdCD+Ra3Xh7RHn+zRY895Ldh0thdYepfD63fG2j0UHxRLUAPGQW5u8ohtUAWykyM2P7PpSio2r05iikuXk87OLm6mbs/fY2h+byqGUEzxttK55uVwDHyFOvwMzVftoi75iG/UIzeBLK0jKQl3wxRc1HKzmO6MGt/VR6MF0ctu6m+5i7Db/rRkkpIu2haFb2MM0zY6kwO7fNC4HLEp3gGqagu8HzUukevTXK4QRZZxMHstfJDy6+O3VaertmTI33sjI703IwH9gvatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rPqiriXAjkazz46WitUvRSz8J7lJA+hz1hHWjhuH8U=;
 b=QZhgd6PEBc6Pw0ok5APSSz0fF4odvEw4+r9K7ZLWnWiWN6K4so/F3PJNcyjozYBzyFHcT5QaPg8YMp5WebQVvBNNQdWfyZBQ2VN0yEX175dbaqBuq09ha6cxE8kYFNyaJuFr17FQzqKTinVixg9xZ8h2Z7tf6v1fNFK5XMNzxRSlXljn11AaSPWdts7c36NA7R+7H3rT28GaknZJD7R0NHOBtq34JL6ZfVvpcO5BVIS23Nk9Udg0lFvQwygvofH3BSm9tMy/FSZH2eNJZ7Shy2rceZrDDdPzQ54lVCZKuqtxvlk8zITzCbUkmVyFNGFGYBNv0kordGpS/9XFTGp2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 18:23:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:23:56 +0000
Message-ID: <8363b014-dd75-4dfc-a248-85a2aa129cce@intel.com>
Date: Thu, 30 May 2024 11:23:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] octeontx2: Improve mailbox tracepoints for
 debugging
To: Subbaraya Sundeep <sbhatta@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
References: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1717070038-18381-1-git-send-email-sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:303:b4::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eea355e-0c93-48f1-ae89-08dc80d5aae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2dRYW5BTjkwTmgySGowM2w4dGFJQnpraTVaMzhMdCtRcHgxdHp2eHc3OHNh?=
 =?utf-8?B?aW9HWVcvclBPemwyK3pFMG9hOUFUL1IxWFhHWjBTbG41NXlIVnFFRTZLUkNz?=
 =?utf-8?B?VUVRYk9ETUxla1VTSUZWUmttMzlad0lJK09RQ1AzeENuWWZlbTZLY05QcTBJ?=
 =?utf-8?B?SHRObGErM2hsb0N5bXN3ZksvRlNlcjcwOEY1VDZITnZ6VXp0Qkt3QW5aTXRH?=
 =?utf-8?B?QlRtM29ucGFNY0xGZlNPK0I0RnorVnNJNE1wdS9NY3Z2azM5a1ROWVdGRGUw?=
 =?utf-8?B?amlXMnFzVWxMbFdkc1FzQ3BNelBGcWtodURodXp1WXJ5eFNLYkJjWFBGOGYx?=
 =?utf-8?B?djZKQjRqUXE4eFVQTCtJTnM1c3Y5VDEwZGVveEZrbWlUUVU4d0RGb1A4cFdU?=
 =?utf-8?B?NzhPRnVPb2IvbEE0V0NVVjlMZUhWMjBaUDdCcVdMSW9FQzAxTFFmZytNUzVS?=
 =?utf-8?B?S2RNazlXV2pLL0RBQkpvWWlaTjF4Mmp2NmdJNjdFSDArMUlSZ3EwNi9LWXlS?=
 =?utf-8?B?U3E2ZGpNc1VyZmthWW85VjNwS2hTYzZobzNDTWZXUEZobVJRTnBlQVJnSE5E?=
 =?utf-8?B?TVVqUkVDZEk0NTJyUkI1TWdaMkFuQzdkVmhnNjRGN2t5SnA0Q0xnUHlrUFha?=
 =?utf-8?B?RUd2TjRnbkgrWEdRbHd1VytTVGJwT2N3SWtmTEZMWmx0NXhrRnlzdndPSFV1?=
 =?utf-8?B?S3l2dm9zclcrMUZtak9HU041alZ3QUltQjdOSkhKQmY2U2dFTzRMSmtaRW92?=
 =?utf-8?B?UHlnU3JrdFJ4a1JGMGkwckZwU1FHYzRyYnlVb2l6YTd3RDBuSjdwb09kQ29n?=
 =?utf-8?B?dlZUYlZtVER1bXpSN09MakVVOEpDUEN0L1ZxYzNSaVZ3MXgrSkVNMEw3NUxI?=
 =?utf-8?B?YjhadDM2QkJVbVdmaStyM0tLeVZKQnpQMGJMNUlpVG9OSEs2VHVydGk0elk2?=
 =?utf-8?B?NzRpVXJHVko3NzNhTmlUaHpRcnBjZFpRU2JCTlJPSU9rZEJoV2NzRURubHQw?=
 =?utf-8?B?Ri9VeGx0eHQ4T05ER2pEcnpxWmhNK0k0bzZCN0I4ei9JSkxyUjFxTTFRbmsw?=
 =?utf-8?B?Qkd3YzhWWHdzeVBqSTN2U1BVYW5mQm9XbkRjUEZvMHZpNVpVWGVCMEl3ais2?=
 =?utf-8?B?T3BpK25Mempsclp0eFRTYlR3NTRSZjVwUlJPdGlqaHZlYjBhTVZNMExTemVn?=
 =?utf-8?B?Wmw0WTRiVzYvaFJwSytnak1mM1lsK2poaUcyaER2Y2RQUGdlWFFGeUNqSVpK?=
 =?utf-8?B?Yk5TQjFMYzZjUXMvUi9CYzQ3TzdOUUJRdGQ0UzB0NTJZNUpWR0ZKT0pLVWlN?=
 =?utf-8?B?S3ZiRjlYeVBJZE9iaGJ5dTcrU0NNODdXK1lXTy9qbFljam9oKzVxMG5oSXph?=
 =?utf-8?B?RzZFTXlCK1cvTkNtOHNhbWdReFo4NmJzN0RLTnlqaDEydWNNZlVobmlqWUQ1?=
 =?utf-8?B?ci9xODFGc0hpTFBMaktiVmZtN1ZLTDNPeHp2TkdCUTVxWGc1MXZjdXR3N0tS?=
 =?utf-8?B?bytNbG9nRGFvK3BpcEc2Z1E5Vmt0OTJUQ3ZQNGRpeVEwTUtiUUhEZVVyNEpq?=
 =?utf-8?B?N3ZUVTJMNE9HVG0zdHMzNE4rbnk0cm8zUUhMYkdDUFpTcWNqK3NjS1ZXY0tj?=
 =?utf-8?B?UkJxSEsrZHBxN3JXTzJYNnFSTmhuUnFJaGdncmd4eEJDZmNJTUo3UWlsNXRh?=
 =?utf-8?B?VUFOQ1E0KzQvK0h1NHNxQVVOc0FTUzZJdmk4UEhRdEdkd1RzTUI0ek9RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmJSUG1vQVhpN0Y3aG9yc3plR1A0OWxFVFhiL0VyUnczR3hmNXpYSHBTR3dI?=
 =?utf-8?B?QlpKeFpUZU5FRkxSd3Z0M2RoZXZyMWlnY2tNTXBsamlSaFA1MHBVV1RaY044?=
 =?utf-8?B?VFcra2VEaFNPbW5HK2xTU0dwYzdsc1pYWkl4dEs3UDI4NndQcTEvL3ZWbWJl?=
 =?utf-8?B?N0RKak5KMVRnZkFEL2JjL1U5QVJDcGNwZEtJa3J4dUhSQ3cxZFA1WVU4Z0lJ?=
 =?utf-8?B?RjQ0SWkzVW5wNGx2UVhINkl2cExhZ1hPTnlTY1lOY3ZhNDc4Q1NkSlpUNEFU?=
 =?utf-8?B?N05nZUVkZHp0TUdjZytKZjg0a01XNVdPNWdVOXZhRStiKzNCU0ZLcEh3NXcy?=
 =?utf-8?B?QU5zWFlJK1NTdThlcnlnRnduOUFYN0JrREs4Y3lrOTI3VzdVV3FuUnF2eVQw?=
 =?utf-8?B?S3RTd3ZPeVRUZncycFBUTjIwVDM5VXFKUmc1eE5mQ21pMG4ydUxYNlJORnhi?=
 =?utf-8?B?NVJhN0dTNXF0MUh4RnBxSXBIQTQzZTBTV3JYSU1qemMyaFNISVRlNGw0dG1m?=
 =?utf-8?B?aVdXcE1SaytKVFV4RThicGphUURmMGtlY0UrQ2toY3lMR1VHRDIvd01LMWRi?=
 =?utf-8?B?OGRCM1lqT1BnTmk3L3c5NVhrQ05HZmtBbEZkc1JDQkd2ZXNUUWpLS3pTMktM?=
 =?utf-8?B?T0tSeG1SMW5WWFVKempwZCtXZ1JMY1h1L0dKdlBaMHo1QlNhVGhZT0tyM3dH?=
 =?utf-8?B?Q3hGVVY0dkNoU214NkYyR21tcnJCd3hpRVRGeENhY0Zmdk5KV1NRYVUzdWp6?=
 =?utf-8?B?aGc5ckJTRzNwbjJPTkhDcHozUC9TN3VKL1gvaDE4c1NQVUJ6a2tuWDg0d2tB?=
 =?utf-8?B?U1JDZzN6SXFMWjZGQXU5cEprdU9xd3Z6aW5DdnpWV1EzMDNZMi9oMHBTREx3?=
 =?utf-8?B?Y2FuNnowUE92d1U0QVhPVElrZ1BKSGovcnl3OTllVGd2bnVhaGs1dERvK1Bl?=
 =?utf-8?B?aTc3WldqbmtLM1pDbWhVZmVJZXZvWittMTg0VDdNaDlLSVVINUJQRnZPandS?=
 =?utf-8?B?MjB3Q0sremczYzJadzFrVWJGTnhPSHQzNXlRdk84MUFsc3R1dGh4REgwdlEz?=
 =?utf-8?B?ZEJqTkI1OU03MFAxazZqSEFXSlVWQjJrblBpQjl0TDJYb3ErbzRIKy9YNkoy?=
 =?utf-8?B?M3U3empDdC9zZnlxd0diWm03VlNBU2htTjQ3aVpTZHUwdVhleW4rV2FBS21q?=
 =?utf-8?B?S0NaQWFqcmtvajd3T2tycW9ZRjUvQ1lrNitCNysrYTZqZGFBSmRncXFUemYw?=
 =?utf-8?B?UVFxT2VvNmJCUHdrWXVaMjEvbFhDT2dlTUlCZ0ZXYnhXNGVQTktheWYvalhN?=
 =?utf-8?B?bzBjay9HOHF4RG12Sjhwa09YVXo0YWxCZVBJRzdDS2ljU2RhNU1aZzNUbDNi?=
 =?utf-8?B?Y3VNd3NHVU9Bb3QzK1JaTFFwVjJUN3NZdEVQaEppeFZIYk9hY0R5U3dpQVN5?=
 =?utf-8?B?ZDM2b2tST0M1UW1iUjAvUVZPOXRFclVLeGloSCtJL1VUSmZuYTMzNkJHdTNI?=
 =?utf-8?B?NUE2Ym1Rcys5UE00WHJIalNtT2lFamFmSGtKc2JoKzAwY2NtNWFQbEdYR0NW?=
 =?utf-8?B?cDFXVjlCdXcxbE5ZelUzTFQ3ZmFzS2kvaUQrSlVYemRTbmFwUkdRM2FpNmhS?=
 =?utf-8?B?ZzhQSWxUYUpyeXRRVU50OWZSU29vc0NjVlU5RWJDTVhyRlJWLzhXTjN3SDJC?=
 =?utf-8?B?d0tHRXlaTHFoODRqTWUwMUt4OHYzMi9Oc3Z1S3k4RlFkR1AvZk9NNUhjT2JG?=
 =?utf-8?B?UlRGdmkxa0Jaa3FjeWdkMnQ3VEtRbHVXN1Y2N0Y4YlFKYStJUzQ1NDhGMWJH?=
 =?utf-8?B?N3N0TWdsZUdURTVKNy9RRHNpcVRVc2hRbENRa1ZDWmMwOTJzQUdUcUFwMi8v?=
 =?utf-8?B?SUI4MkwvWlYxdzBqakJFYVNCSnFIeTFudDNVMCt1UTlSM0g4VHhQMkZqdnRO?=
 =?utf-8?B?aGQ2bWo1WkU5QkljY3orYU1pckdnNW9VTFhSanA2MEJ4RHhibGZ5OEJYMHlB?=
 =?utf-8?B?amp3ZnVQcGxyYUlKS1ZtWjdBTExPK2VLT1JNY1lia0JpNnR0bFY4c2xBR0Rh?=
 =?utf-8?B?cnluNzdNWUwwMkFRY0xBTnQveXVOeG4vaDBCNjhYTE5zdDM5Zk5oSGIwUHhY?=
 =?utf-8?B?Yk4wdXA0bERvSkFRMGhnNy9abE5sV0cxVW9VcFFRb3VybithaGlRYWRtUVds?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eea355e-0c93-48f1-ae89-08dc80d5aae3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:23:56.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkxruU+38pSwqfpH1JcSHPQZNRqCHNWgm5HOjgrugD2BjmY4jPjYaVGi49NEpsEVwwsqUg9OChiM7MZ13OyHdQuBjz0OqfFIxnITQnOo7bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com



On 5/30/2024 4:53 AM, Subbaraya Sundeep wrote:
> The tracepoints present currently wrt mailbox do not
> provide enough information to debug mailbox activity.
> For a VF to send a message to AF, VF sends message to PF
> and PF forwards it to AF. This involves stages of
> PF receiving interrupt from VF, forwarding to AF, AF
> processing and sending response back to PF, PF sending back
> the response to VF. This patch adds pcifunc which represents
> PF and VF device to the tracepoints otx2_msg_alloc,
> otx2_msg_send, otx2_msg_process so that it is easier
> to correlate which device allocated the message, which
> device forwarded it and which device processed that message.
> Also add message id in otx2_msg_send tracepoint and new
> tracepoint otx2_msg_status to display the status at each
> stage.
> 
> Below is the trace log when a VF sends a message to AF with
> this patch in place:
> 
> ifconfig-523 [001] ....   146.134718: otx2_msg_alloc: [0002:05:00.1]
> 	msg:(NIX_RSS_FLOWKEY_CFG) size:28 pcifunc:0x1001
> 
> ifconfig-523 [001] ...1   146.134719: otx2_msg_send: [0002:05:00.1]
> 	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001
> 
>   <idle>-0 [000] d.h1   146.134722: otx2_msg_interrupt: [0002:05:00.0]
> 	mbox interrupt VF(s) to PF (0x1)
> 
> kworker/u49:2-238 [002] ....   146.134723: otx2_msg_status: [0002:05:00.0]
> 	PF-VF down queue handler(forwarding) num_msgs:1
> 
> kworker/u49:2-238 [002] ...1   146.134724: otx2_msg_send: [0002:05:00.0]
> 	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001
> 
>   <idle>-0 [000] d.h1   146.134726: otx2_msg_interrupt: [0002:01:00.0]
> 	mbox interrupt PF(s) to AF (0x10)
> 
> kworker/u49:1-184 [000] ....   146.134739: otx2_msg_process: [0002:01:00.0]
> 	msg:(NIX_RSS_FLOWKEY_CFG) error:0 pcifunc:0x1001
> 
> kworker/u49:1-184 [000] ...1   146.134740: otx2_msg_send: [0002:01:00.0]
> 	sent 1 msg(s) of size:32 msg:(NIX_RSS_FLOWKEY_CFG) pcifunc:0x1001
> 
>   <idle>-0 [000] dNh2   146.134742: otx2_msg_interrupt: [0002:05:00.0]
> 	mbox interrupt DOWN reply from AF to PF (0x1)
> 
>   <idle>-0 [000] dNh2   146.134742: otx2_msg_status: [0002:05:00.0]
> 	PF-AF down work queued(interrupt) num_msgs:1
> 
> kworker/u49:1-184 [000] ....   146.134743: otx2_msg_status: [0002:05:00.0]
> 	PF-AF down queue handler(response) num_msgs:1
> 
>   <idle>-0 [000] d.h1   146.135730: otx2_msg_interrupt: [0002:05:00.1]
> 	mbox interrupt DOWN reply from PF to VF (0x1)
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

