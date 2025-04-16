Return-Path: <netdev+bounces-183480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E0A90CC7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0455A02C2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D77226CE0;
	Wed, 16 Apr 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl9gm+Cs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324041E1C29;
	Wed, 16 Apr 2025 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834168; cv=fail; b=l+zC7+pK49wjy1jIpKF0NA9L1q27kuzu84kTrjcFx9mliSXM0te1vN3dABEql2RFQAPjjLk3Eq8lvcG+xYrnQJ/xoWDAFmQP/PO8uaAjp25jF3HSDHnbiLhN0gEqMZ9BLKQcuXEymhoUiipWZ+14pQMX9QZ6muFtWFgTSIJ2DII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834168; c=relaxed/simple;
	bh=zrOPncqNOPmPplmaInlGHUiKjb9FG5ahs3Yh35c7+BQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MOETllGK7IgEda5xRhSMdeOCST+ms8sQV3jtcfKU40WZhST6EFwz8WDOTwc+rD+qw5SZe4vjKnrYOiKZlzD/xdGGoxh5sbywIMMPTy8Kbkq4k2mVGhfMDmpV1TO3WWNSp3uM3jLhj/qWe6uaTlgYGDsoS25J87gSnYfBfN6e8eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl9gm+Cs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834167; x=1776370167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zrOPncqNOPmPplmaInlGHUiKjb9FG5ahs3Yh35c7+BQ=;
  b=Wl9gm+CsXeS7bJQKz+PoC6htktGhKgqsSoNbOa7tkyZuF1+SMMmw0JXo
   s+wROn7+Q0EUGsUr1ZZvMbVR6VKAWv6RgFU8RuPhIMjwXTP+6NK890ypJ
   /ev9NQUhuHyVsVBkV/Ogvs5R5u9gn7CVQe6pbRPywZSCS51vI28CjlX5o
   FcA4q1uvzSCMYV0DbxPy2oVXlwXVG7DGNiQm9Dr4oQ762+xu7TzHyubxq
   MIQYe5hWMMG8ExCDeqk/NUpFqJuYO4y0FX03sDRP0Z+8uum/S6W4Z+ZAE
   ZQgfOBNfB1xyqLcC5foCoguiFLZAH71XR6tbrQKSGSHn48zFJp5goJlTu
   g==;
X-CSE-ConnectionGUID: I1XIhMcLTzKlj5I4ROR7ug==
X-CSE-MsgGUID: iua3OpnNQ6qHI3QFQxBTNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46117599"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46117599"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:09:26 -0700
X-CSE-ConnectionGUID: 9MAzrgqnSvyTBcVb+7IuBA==
X-CSE-MsgGUID: TZsC8clXT2yw4lNgVEz6IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="135445924"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:09:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:09:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:09:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:09:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrXaKVDj0tJgANpY0QGfr66NNjjYWWFGVdY9WiGcjmift6jlXj1Qe5XrC6S/lbb/cJipYv6S4hNtRYu5ORUKEYOlxoWyUoUkCzGibdqQBKOKzc3J2FJ9JeJij+/BQGnplBMrON81ELp1AqLUZXjR0OH+iojAIZzjFrLE4kMTykMcj0nbZZzcTRoImzT1vjnka2+dAp777yc0GgQ1kC3T7T9LRxYA6x0Fk/yVVlgpiYF/WW0gZ+dux0jaFvPK7faXb7NaxUOx5jloLLBdKr/spL1JsRBVCZlf2rUbx55WnZUP3+PHu1A0YcRZyxGNTISlRJGnzsqTnxC9i+bcKTELjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HWhYXBsYr64uA8MS1bKUdVW9zYZPvAMV7hUrgN+uG8=;
 b=GqM7H9I3FbbC6/0RSSTDYP3f5XGTZnhHsq3LK41DpeEQY9W6xe4KdDJc1q4efD9PlGIb0P10Lt2gXrvVnt6wnvAZceByle+DGO87gF90Vy5uEDM0z3ghfQElm9keGGi1igeclRKqODogb/hzdWxScyFwhFx8kxqT0ErS091tkx8tSDnLcmiCnI7YclIsZR6qFwNoHaxK7S084BwtJ1xzt4TFhUyfPhAX5yoJuY2Zopx4DL25jUwOtgUfztTdD02J3vUu5HE03ff0AUk/nrbdBxAcxY/ZQyMsNpq+wtxEqr/jBIQK6sM1oJe4NLeh2uwLTCkotRkBwWzQEV2kyMpM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 20:08:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:08:52 +0000
Message-ID: <43b3ad78-3f79-468e-9943-941b7498ad90@intel.com>
Date: Wed, 16 Apr 2025 13:08:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
To: Abdun Nihaal <abdun.nihaal@gmail.com>, <bharat@chelsio.com>
CC: <horms@kernel.org>, <Markus.Elfring@web.de>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rahul.lakkireddy@chelsio.com>, <vishal@chelsio.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250414170649.89156-1-abdun.nihaal@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250414170649.89156-1-abdun.nihaal@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:303:8c::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: b997d201-9b03-4061-d8b5-08dd7d228213
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUJRNnpsN3RRWGZPaUcyMmN6RUFDRkZkT1I1YlF5eTh4U1VwNFVXdmZSYkow?=
 =?utf-8?B?M0NxMEJTdHVFdUJBTHFsWmtocDlLWkl4ZzRLTXlhSTJPd3pYRUcvK0VsQ1h1?=
 =?utf-8?B?TWtRdEsxa2hmLzZ5TDMwSjdXbjFDNWRZMVR6MnNpdVlETDJxSm5BbzJXYWFt?=
 =?utf-8?B?bnE2bndsdFFjYkJsSTAyZm9sOW9OMkp5ZUdiY2RxbncxOEpJS2wrdSsrLzdk?=
 =?utf-8?B?bkpweWJiS0t1WkZoVXIzZ0NZVlZVUkdlOGx1azdQZFROK1Bkbkl1dDJIMjZT?=
 =?utf-8?B?SlJGeGJOano3UGZjMHdxWDg4SlpRK3MzcE9OYjRoSnRvRlZPYmo2MVFDU21v?=
 =?utf-8?B?Um5JdzJIWVlEWmpsZUYxOHV4eDNic2FXYlYrYUIxQzJsVVZNWnBDVEFSWGlF?=
 =?utf-8?B?WWJPT1ZRMjdIeGJldG0rNlJOaXpaL2Z0VmdiNU5tZ2NtdWhQT0lEWm92ZXE1?=
 =?utf-8?B?YXFtVTdUOWtSYlo1ZG9sd3BWN1NCUVUvVWxqa0VodTR1T2UwWlJFNloyRXJV?=
 =?utf-8?B?YzZrTm1VeCtyY2dnc1lSV3BOcmJockxKWUZ6dGpxdjRiditkZjExYjdEdUxl?=
 =?utf-8?B?ZHRkUVQ1ZXlPOVBwSEh0VWNhenlkNTVkajEwNWFWVkRIMUhWcGNweEVvdFRE?=
 =?utf-8?B?NEJGSnpxby9wa3J3aWFISGlWUEIxQmZBU0J0VHdPeXNvMU5NT2Jab01PbEdP?=
 =?utf-8?B?c0JOR3JuZmdIaFJPbUFDNTdhMExTZ2pTWlZTUTBkQ1BMUnVLUVVOU3hOSjNZ?=
 =?utf-8?B?bUREdVJQNVIxdG5oV1pNamxlV3l3c1VTU0lFT25sTm8raVJFbCtGWUN1OW1J?=
 =?utf-8?B?SVc4R0hjbmc3QVQwZm51bldGZ2pBZlNzOHZUc1ZuM1dPOTdSOEJVS1VwNXJY?=
 =?utf-8?B?cUFMYkhBYVBZK3p1K3VvWlRncnpqWndqZlozTk9DZmJTN0FtVHY0SFVHQjRa?=
 =?utf-8?B?RjZmZ3Nvd2Z6a291eGxQNldaOWlMc0IvUU42U01FVFJid241dzJjUjFPSWxz?=
 =?utf-8?B?NE1wZ1RxV1BDR3d4M01VTjNwdFA0RTZzZUpycWJvOVNHYzg0dThEcStQSEU4?=
 =?utf-8?B?R3lUcHE5azdBdVpqU053WlExWFdHVVdLN0ZFL2FTZ0VkWGhhTnFhTklNUFpE?=
 =?utf-8?B?cGQ3R0NLY0pkZ09leW1SelEvVjBBZzVLNWxLbERwWVNYeW9vWEZHMytHYkRM?=
 =?utf-8?B?VzBGc0xwT2dXZXhuNS9FSUhUbDdsTzlWL25iaVYyTGl0cVVWLzNnNEI1ZERr?=
 =?utf-8?B?elpVY1JCRU9wRXpXZklVS0RPd3dmLy9FeVFZUTVkTnZLM3VOQjhvY2hxYzNJ?=
 =?utf-8?B?b09OalJqQ0c1Nld6RUhHa1dObnoxY25IL0xsS3M2ajFOSEFCSy9OWjFpRnZW?=
 =?utf-8?B?cFI2dU5QbmxiTFBaQVBMbDIvdFhVZk5qbS9JNXJHcG55RG1aOGFDOWdnRklo?=
 =?utf-8?B?czJjUEhTY0JnelZ0V2JhQzgyaEFaajIrc0NrWXJVWlBjZUdsVUt1SmFyUWtM?=
 =?utf-8?B?SXAvOTJMWm9pRUJUcGNjdk4wbUVKcGw0aW4xdUxlMXh5Ky81cEs1bXhFVjIr?=
 =?utf-8?B?UW9ES0k1RUlHakxEUEI0bERCdTZnLzBqMHFHUlRaWU9UNmU0QWViSnl5eGt5?=
 =?utf-8?B?TjVuZGc1T1lPNURZUkFWUzMzUGUxYzh6d2FUeXRVQ2pJUHFORzhsMkpvK2pU?=
 =?utf-8?B?ZGJrVDBzK1NmRGFEMW5HOWFXVkdOU3RLYnc3NDVnOWZHSGtFc1d1L1piTEhD?=
 =?utf-8?B?RGNTZ2VaQitjV1c5MHJ1MGpVOU5CU3dYWkN5T1FTSUtXUVdzN0JXZGV5ZDdF?=
 =?utf-8?B?aXVIcUo5ZVdQWVU5bFdzdE9obHR1UDM4TDhtS0NCUnpzNndVMFRqMEVWYkUr?=
 =?utf-8?B?SkN0ZUR5UjhrRi9GeVpIbDlFcHBTK1VqUk5hVHJIc3hhditaZkZQZVV1Z1ky?=
 =?utf-8?Q?XMDHV5gusAQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEZmTkthSmtKMWdwWnRvQ1JNS3RyajhBeE95dTNuSm5RS3ZvWk9yd1E0Ry9U?=
 =?utf-8?B?ak1JYkhpVDJIbVFHVHFVekZjbTZwME1IOWM5UHhkUW15WG9QV1d1b1NqVGwr?=
 =?utf-8?B?MnAxa3Frckc3eXR0MXkzRVdSMVNxMmRWYkFoQk1BVllPOUlZNVBoVVUyMFN0?=
 =?utf-8?B?d1JWS09yVkRNUWpFWHpDVjlmalN4Vm45V2ZGRW9rN01Yc05pTFZmNS9nNFVC?=
 =?utf-8?B?R2podVNoV3V4L1JrdEhnOVBZQ1BDQ0RhS2MxTTA3aThyTWNWUnM3QThDRXJE?=
 =?utf-8?B?WkhBWktQUXNrYUV4RTJwQXJpTUlWSjluU1RKdThwd3RzZ21TZmlaWWczMHlG?=
 =?utf-8?B?QUJZWWFyOHNwSUlWSzlYbndGZUVJMVArRjdhZkNqMlhOcXBpYU5VeUNaTm91?=
 =?utf-8?B?OG9LdmZkdWFVMG8xYVNVTm5Tbmd3aG1YaS9ENndCWVE3Z1gvWDRhaytKbWNX?=
 =?utf-8?B?OFlwalBpMW5hL1U3MWN1QzFLTk5FZFZyOEhjT1NKdG9KcGl2YThGb1NoWDln?=
 =?utf-8?B?QmYxWHFQQ2Nnd1JuTWF6eUMyajRrWjJWZmpQNDdpaVpDS2ZJMldWSCtONmM4?=
 =?utf-8?B?dlhsSUVzYVdieW9ielBWdWF2TDZ5dWxiQmZlNzJ3NVVKNXFkc2tWR1ZmMmJR?=
 =?utf-8?B?b3JxNTk1bU1JM2g0VzUrbExHd0FjUDZJNmVDQzdZallTa2wxTWkvbGxvanhD?=
 =?utf-8?B?UEJUeHhxZFBkVzdLencrVmNFZVpXaW5pVVAwT0t5NVNVR05WMUFkNzJaZzJO?=
 =?utf-8?B?a29NQXBIR25GeU5qWWlHMWc3RmN2ODFOYUlUaXVTb1B6VXdqVWtacy8yUW0r?=
 =?utf-8?B?S29pZGRjYWNYSENpZTMwRWdSdHBXcWczZzRvZXZ3bDlVa0ZLWGlkRnRNVjZB?=
 =?utf-8?B?alFJNmZFMHFLQWhYblFkaHZ2c0NmVVJmZHdJdlhkdHVsQ0dFeG9KelZXT3Jy?=
 =?utf-8?B?ekNQU0JBTGJJc0NVR21PZTQvYktnYkpTY0E2dm13VHk1SHNVeTRnaFdxZCs1?=
 =?utf-8?B?VDhXS20wbWwrS01CTnFKMzRKZk9FKy96S1IvZ3BuckJVN0RhaE5qUm5ub0wr?=
 =?utf-8?B?OUFqbTA2V1MrNEhKNW9vb2tKL0JnM3d5S3dlSmlyTlV0a3ZHT1F3NWs1cFdw?=
 =?utf-8?B?M0FTaUlHSld4M0RJbS8vc0ZacDRYbE5OdUVDdmxkaExDSzk5dnUyTHhIQ3hP?=
 =?utf-8?B?ZXpScDdNV1BLbHZ1U1loVGVPZ3l2akV0SXp0UVRnYnd0LzZSSXFCVnlaK0U2?=
 =?utf-8?B?a2R1ejc4M0NJVHZhWDlDaEZvQzRPOTl2Z0hoZlEyY1BJR0JVdGVTZEZRT0E2?=
 =?utf-8?B?UnZmcjBUQVcyeTQzc1Z2MWU3T0V6NFNaa3JoLzJZZWdrM1FvdFFuV1V4YVd6?=
 =?utf-8?B?T1NRNlZYMTFRdkRwUlZ1Q21tZEluQWhBdnFDTFhJZ1J2RnJPQVN3T002TXd4?=
 =?utf-8?B?S2pqVnRMUVRneVAxa0l0TnVCdWl3c2t0OUY0ZjhXK0txWVQ0MEhXbGs1eDRk?=
 =?utf-8?B?M0pkc2Z5NzlvemFZVWtjaWtla01DR0l6eFlHSklMN2pMd0hvdEx4REhnZkJL?=
 =?utf-8?B?Mld3TEFPN2l3RnpNcXprYzhuMGlYTVpsbkp6SFRKclVTYmZIRDFpNmUwc2cv?=
 =?utf-8?B?a0lPcTduOWsxdEtiODNoZXRsOW5PWjJEZXR5RTU3SmxPOHNlaCt0N1d4dVZB?=
 =?utf-8?B?WjI5Wi9vUm4yd2IrYVZFUndxelNJQ252RkJqNzNRajdvMzlMbFFUR3JobXZw?=
 =?utf-8?B?aDJ4WThxaHRmYlpETHRKUFhvWVAwVnBVb3JQaWZJK1BNQ1NLWHlsTGJ0LzhZ?=
 =?utf-8?B?RHZGQ0ZSN2dJMFJZakVZUExEQml5OXNpcm8vbjVFK1BnT1RaeXdYRVlWRDdF?=
 =?utf-8?B?cjJvRWgzUVIwYmVKUUJYcmJEQ2JZb25JKzNTbVl5Nmk1dmVmVUIyaW52NGxG?=
 =?utf-8?B?cFc3Q1BNSFBBYUZuc0d5OEY2bjdEZUt3eG4ycG1OaVEvWkFFazBNdC95ZnNm?=
 =?utf-8?B?c1RIR2lEMVliTGZWOWlmV2NQcWtWMVJpRmRQNVd3NXhCRUJyQmtZdHhxcm9V?=
 =?utf-8?B?T3dMT2tqdGJoMnZwd3Y5UVJ0TDUvWFdOdEJPOFFWcmFnWnA2bmFaWEdaTTlU?=
 =?utf-8?B?UFRQZFJoTGhkaVd3aG5tUFZOc2RXWk1xTmYxMHZkNDR3UW1rMVNHY05PUG9m?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b997d201-9b03-4061-d8b5-08dd7d228213
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:08:52.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9+CxPWdygDAwqHFZt4nDvyssddUwNI/A+NUzzP1+p9o+G2T+2tsZZX8S/dibrmnDKyPH5Mo3GCG1lOIfEu0KjvAH05l2RclhuMUgZZBMRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com



On 4/14/2025 10:06 AM, Abdun Nihaal wrote:
> In the for loop used to allocate the loc_array and bmap for each port, a
> memory leak is possible when the allocation for loc_array succeeds,
> but the allocation for bmap fails. This is because when the control flow
> goes to the label free_eth_finfo, only the allocations starting from
> (i-1)th iteration are freed.
> 
> Fix that by freeing the loc_array in the bmap allocation error path.
> 
> Fixes: d915c299f1da ("cxgb4: add skeleton for ethtool n-tuple filters")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v1 -> v2:
> - Added the Reviewed-by tag from Simon Horman
> - Also set the branch target as net instead of net-next as it is a fix
> 
> v1 link: https://patchwork.kernel.org/project/netdevbpf/patch/20250409054323.48557-1-abdun.nihaal@gmail.com/
> 
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> index 7f3f5afa864f..1546c3db08f0 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
>  		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
>  		if (!eth_filter->port[i].bmap) {
>  			ret = -ENOMEM;
> +			kvfree(eth_filter->port[i].loc_array);
>  			goto free_eth_finfo;
>  		}
>  	}


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

