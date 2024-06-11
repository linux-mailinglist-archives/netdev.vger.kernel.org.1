Return-Path: <netdev+bounces-102673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5275904369
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C7C28469F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F686EB74;
	Tue, 11 Jun 2024 18:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="et7t+GfF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A8605BA;
	Tue, 11 Jun 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130116; cv=fail; b=A9RQ2zpNd5glta5fDohAsP23fhElACohzXnHI8YfZmVFFfA8a7FNL+M9ZGb7f2rZ9JwWoXotnLRyX/W8wKBdm+aVy0NhgKsdPFJgB7qUluSpzfMz7Hoh5KzIWcn34E1/QK3qPogk8tN/SE7IDrdtsgwb68VS06t4hFZgNyJF1gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130116; c=relaxed/simple;
	bh=sd5KS2wN0kWH8XDBaEenJh5fJlHc0OzBQwUxwvuZ/P0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YTvmyAqvRyxcmtZaRBJynjXHGkSF0MEpXlmtqp7M/vn4tNLZ3avCerZ4pjPFbYKBWFueZUTq47TK7bWSQtSM14tlzdoeqixlY0iivkl9I8ZAi6e9Cv69fNwEUdLwRceYRV0Kako07CzuGMc2Ij71TqHFwf4pJC1nBzHW3vbK1mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=et7t+GfF; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718130115; x=1749666115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sd5KS2wN0kWH8XDBaEenJh5fJlHc0OzBQwUxwvuZ/P0=;
  b=et7t+GfFYDz41GNW+kGMK8ycCcsrTcuk1hQbFjrcI16+1cazIPPLWaWX
   xXTnNzRdl9PuLxfjATLM1Ms/+0ApP/fwKtTDpTNtjR7D5RiKpJCcBoepf
   csiYVzK/JgK91lujAR6OcZXzn6m8iy75o7MVxUmM7nT2Dvah0dts6dOzR
   JYS4kziBxE9EYlgV8kwTJuwCOe1C++mZPGhbBtXOzx4T81GKhZhqIMeb0
   gPYuLTEygK82I9qfpBZBpGkl1yBNKJerlPL9Oa+KfVwJ+/D9NDsTWWEqI
   lvZPoV916hlaaW2ZtMmKlWl6wVRlPnLuz7vPKg6fX0kc0ldgju7W67/R5
   Q==;
X-CSE-ConnectionGUID: Hvb+4AjxQBGmWqyuGWpkAg==
X-CSE-MsgGUID: NL/SZjvVTgCQKyd8iXpMNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14989475"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14989475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:21:54 -0700
X-CSE-ConnectionGUID: rG7jdUIYRFWpR5Pcv63vSQ==
X-CSE-MsgGUID: PAEIugvRRQ6JagiBr0n6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44648414"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 11:21:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:21:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 11:21:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 11:21:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 11:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1+1NJZkSYuMY0i2/vtD+97bfja9hOEsNdhNLavMr4Z7C9M1QnnIfxWEIYXBo0Pz8vtJtM+8iznEvdWRr0EArnDot51hij07TwRwwxsbWId7x9k/6k4iOaEXM9MgecfM0p3YnJv8MxCVuoesSZ6RzOzzzM7cRbzbjvdsctOqMu0bBydAIu5pBXcutBe0PmHcTmakOIMy8b+sF8LSEnjJjtmuOF0BSSj+LGI/IBID5g2aU8kmPJOiMa78TI5PzbosowlgfkGTyQYAMRc0/Sqhs9kSDJuTVcEN+1HFXOhikcAJjTJBBOh2QMugm+cWIPDJwcp+HtwlhptLtDBeIIHNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJMcb/A22n5kRoImxQ96Hm4l88J1Pv0mR6i8cKmPtzM=;
 b=ZLo1UDjeRx9eSxCPcqsmPFE/+NOq1OHMoDkY/h2pdg/2ai5nDNDOe7gi2a3JGnBZRBWqNHCqExEWtz0VH7TezjLmhRaJC2udCFFPrErxiXU78B0eLN7dO46koygOMqNL4hVNNZBX+kqsryiklE9ojipPzdMdVmqcmGekIEvu6SIOTvNJBOKeimTR5jX5tm8Uyyy6ziQVAckXRsRYl11FbYVi/ld3jKTbp3sxwrIVBN9GqHIOaGqeCY0HrV+diSlM48eC7SC2yWI0PO96pU0olcZ/KpErZMsij/h1olmV7mkHA6EGBxxOE7AOvbm9pwwNpdHIbL3ocdWjEQGeg5RodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 11 Jun
 2024 18:21:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 18:21:50 +0000
Message-ID: <1b07a0c6-c973-45b5-94f7-f9234e244a11@intel.com>
Date: Tue, 11 Jun 2024 11:21:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] igb: Add support for firmware update
To: "Chien, Richard (Options Engineering)" <richard.chien@hpe.com>, "Richard
 chien" <m8809301@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240609081526.5621-1-richard.chien@hpe.com>
 <4f2ec2fb-5d31-4a90-9ef6-a036d16a5cb4@intel.com>
 <PH7PR84MB15819CF12F71CB6D55F50576E8C72@PH7PR84MB1581.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <PH7PR84MB15819CF12F71CB6D55F50576E8C72@PH7PR84MB1581.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:303:b4::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6212c0e6-9e1b-49ea-1984-08dc8a435ca4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGNRUkNIQ3hzU0xMaDFpWGtlNGNVOWJvK09renFhV0lBWEdiRWx2SDh0bjhM?=
 =?utf-8?B?cjVLL2JwV0hUbTl6cTBwVE9vYWk5WGUxUFQyUUVUaUJXdlJPUDJrc2lnWExr?=
 =?utf-8?B?SnFkbkRwZlJQV20vTnZybnBCNG51VDh2b0dwQjRCbXdPemkzck5zTWRTYVZ3?=
 =?utf-8?B?ckRmdmZxUkV3Z1U3Y1N5SXBXSUtOV09VeWNrU00zcW9JazFkOHU3N05CNWpz?=
 =?utf-8?B?Q2ZNS0RTbk5JalQxZzFMYWdDR2xxclR3NHRveFN0MlE5eWNTT0FrNzdsQnQ0?=
 =?utf-8?B?dHJubGVGWnNPNDY0c0NhWXUvcElhcWR2cDJYSDVaQmhQamhrNVFaRTN1RXlM?=
 =?utf-8?B?MWVvbHhhR0FNRTBmVDJyd1R5OC9nZlNYRTg2OTByaXZnRG5XWFNtQ003UVNn?=
 =?utf-8?B?UTRCNFJKbTVnWFNZbEw4YzhkemVTTGxkbENQZ2xoc2pRVFZ3UVRLK0lNaDcy?=
 =?utf-8?B?MlhGWlU5eG9zTVZuNnRzSm5PNStNR3AvYUxZQTdNK1IzTll0OHArOHZDWXVD?=
 =?utf-8?B?dm9SMEJYTmlLQTdvelpVR2gxbEZ1SFBJK3M5L3hmUy9RVXIvVWJpcU5TRjQ2?=
 =?utf-8?B?MXoveHUwaFk5YTFrNkVsQ0lVSkVibWlYcjV4TXhUTkZvTTlub2NDU2Y1ZkR1?=
 =?utf-8?B?dk5pNHgvTjFDODRHb2pkUjNzRm5UTkZCRytWa0RTeWRKbXpKZEhidXo3Y0pK?=
 =?utf-8?B?OHY4N0lMenVGdzRrVjZ3K1czRG5nYjZraFEweFY4ZnRWbnBnSVlSOHVza2Zy?=
 =?utf-8?B?aTJBU082YUh1bTROUVBiaWJENGU4clRDNlZld1BoaXpGQWE1YjYzR3ZDc1oy?=
 =?utf-8?B?ZnFoOEU0emE5bTdEV0ZSemYvM2hZS0YvTEFnQ3JJQVF3K1VIL0dtQWFYK01k?=
 =?utf-8?B?L2p6UHNJWXlGeWtybHZvRFREaGR5b0V3bHBzS0g1QVM4SmNtNFZYekI3ZFpV?=
 =?utf-8?B?SXk4WWZ2NmhGa3BPVWE0OG14a3kvd29Ka3gwbmNqcUdmV0dqalAyQ1RNeFhN?=
 =?utf-8?B?b0hVbmh2NjVCQnVONTB1ZkErVDZvbmp4S0hETURjcVFBT3VPa0ZOa0tFdWE1?=
 =?utf-8?B?YUplQzl0ZGVoQXpRSTJKcnRWU0pwTHlienQ3SWdNZFZVWjlUV1pKWDNOaFpy?=
 =?utf-8?B?ODlFRUZEK3dRTTcvTmczVGh0ZHFGVG0wMXZoNjIyOGZiU0tlczljSm9UZ05L?=
 =?utf-8?B?a2tQWTdsMkxvRlMxM0Y3ZWt4S2pwdUMxdUtsYnhaNUswcnNFSFJMc2lpU05C?=
 =?utf-8?B?V3dLRFpOc1FseWtnMmRPam1Da2xQTmY5ajVZVU02OEZvWnhZZ0dyQXdvRFJ0?=
 =?utf-8?B?Zmh3a2VDblBoUXprT2h6Q3FpRGdUZUVXeSt3UUdkMGZTdUwyNUJNMFR6Q1FL?=
 =?utf-8?B?UjJlQVFTNVptTVZLVmhRK0lFSGZTSHV6bEtzdnVTZWVyMzFSSW1jRlhyWFRF?=
 =?utf-8?B?MjZHWkpaTVBJRkg0YkMybnVtc2FkK3F2ejgzZ1FlVHJBdDg2QURTcjhpYWxx?=
 =?utf-8?B?Vko1YnBwaEkwSS9wVmZIUEhpejBneDI5c1IzMXhSdXAwWjN0WUc5OUd0Ymtl?=
 =?utf-8?B?ZldwNm9uRmxEdzVadGxUNWV0WTgwY3A4SkZkSGUvS2xJdU5COHoxUUdUN2V0?=
 =?utf-8?B?dnZiaWQrb1JOVzdKZXF1c2ZhYmoxd2w4YnN5Kzl1cUxHakVVWjQvckhTZzNP?=
 =?utf-8?B?bnMzWlZpVnVpbEtTS3dBVjBXazBoaklyUTNaeGJIVW85Q2UvSTB5UDB4VDNL?=
 =?utf-8?Q?zEaiup5l1LhsErD1IZyT7/+O9l7YkIeGdtUVl/G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZwR1ExM25Ha05MeDdFSCtmbzF6eE45TDRGclNMM3dVLzNwY2U1ZHdKYjVn?=
 =?utf-8?B?MFBYazR3bVNBeGRiRzdYQkxuY0FnU005SXE4d2gvQ0VGenFldlJlL285K0U1?=
 =?utf-8?B?aWNkWlVUZFFQY1BzTG94bVlhc2tXVi94dzFVYldnTENNY2NVR3ZRT2szN0t0?=
 =?utf-8?B?Yk41Zzg1WFBQMjFzbld0dlhkcjJPcG1oVVVpT0ViaFVsWUMrTy9PcThrZFVy?=
 =?utf-8?B?RzJQcmdBeWpJMHlLWmN0SUFMbkN0ck91TGxRRyt6bzQwUzFJWlRVTWNzVXly?=
 =?utf-8?B?WDh1OEZWenZrL0dncy9jOWVFOGtNaXVSenZwKy9yK2N4cW5OSHVUbVFNY0NG?=
 =?utf-8?B?ZUpyRjAzRTYwK3JEbzlaRlJJZjBaSkF4TFBnMEZKNTk0ajVDcnc2Vm16QjhU?=
 =?utf-8?B?RC83ZDY2bW4xWTZJTnMxcHlJbjZodjlyaGd6TjlNWmEvelh3WjlFajFmdGNv?=
 =?utf-8?B?WnRUSU5aSUtXb2ZwK0pHVEF4ZjZOSTg3eE1OdXRBQjlCcWVIZ3luU1NQRVhZ?=
 =?utf-8?B?NThpSFlsWWZEdnNzR0JoR2ZIaUt4VXcwTDZ6c2xhR3NoWHJGSkVHcFJHWlN1?=
 =?utf-8?B?QnZ5azZoenRzZElrUGJaNHc1dExyMkF0QysvVURBbHVEdlZVV0pmUEQ3NGRj?=
 =?utf-8?B?RHNCRDEyMjdYcW5iL3FGRHRDOFpjbTV5VmM2TVhuaGJJOEZGbVkxWjg1R29B?=
 =?utf-8?B?eDVRcEtrc3E3dVN2NmpMbTZBZnhMV0UrSnNEV2ZnZjRiMVgwY1RKSmZUTnBF?=
 =?utf-8?B?cm5kSXBiRVBCMUw2blkzOFh6eThUTS9TZmNwOVJYZ0RZY1dEUVdZOSs0TTdW?=
 =?utf-8?B?RVcxdjBnZkhzVjUvZDhzU2ZsRVlrbGlDcnhMdEdxYXVhUGhtbmRXaVVlS0Rp?=
 =?utf-8?B?VC9MU2l2cDhleHVSNkoxcnpBUlFmcisvR28zMVpNcmUybkl3VXVQT0VEU2pN?=
 =?utf-8?B?Zk1CQjhwUmJweWNxZUZRVEFMTjN1d0p3K1lkUTNvOHVkY1MxS1Z6QnlHK2J0?=
 =?utf-8?B?bWJEY0FYSk9DMy9vdDRMMGxuVVU5Nnd1T1dFUlhnNGs3dllNL2c5ZUx6c3cx?=
 =?utf-8?B?MmR3MmpZa0tqbzBGUm5IbXlZcjJINkZUU0pzaDZJWER0cE5wQ1d2L01ta051?=
 =?utf-8?B?SU9tQ21iNlVYZ2tXWlowWTRmUXNkMjZHMFMzaUJqZU15c1hpUmdka1lCRWtI?=
 =?utf-8?B?QlYrQ09WbEVXR0RJTGZGOGY4UjArMXA1U3Q4ekMrOGJLbGZuQ0FOOHI4TlZJ?=
 =?utf-8?B?V0FaV2RnK0ZkQ0QzTjc1M2UyTmhHeXdzb3hQbC81MDVnWDdvS0VSaERRYTU1?=
 =?utf-8?B?MUFMRXg5dVd4U1J6OWtxbEhmMjhVbjVaVzA1RTdEQjZLU0hheU1xNnA1dGRm?=
 =?utf-8?B?MDNCK3VOYW5yYWFuU0h0MVdFUGZ1SXlvMHBIQ3Q0TzQvd01LeEJ4KzhXSk1O?=
 =?utf-8?B?N2ZSR0RuT1MwYzJzSVZuZ3N0S0ZsV2xpcWhXS1o0eGhFSzM5b3NSUkV1VUFW?=
 =?utf-8?B?TFlPRmUwWXRMRkk0eUFpZDlXZndLZkV4dnNxVlZLeUJsQ1lnbTZqQlpyYThw?=
 =?utf-8?B?ajRCbEZwSlhBR1NpcHZKMG1MSmZVMWg0UkdZblpDWk14d2xYRkZQVFZKWDhS?=
 =?utf-8?B?U0Y0QkFmQUt1SUFCOEw0OEZxS0NDT0xXN0YzTEhjL3FNVTVtM1lwdm1hQlFl?=
 =?utf-8?B?cTYwL2FRU3NmV3dWQzVFN1pqN1ArNmVsRjhWWEFhSENJR2dQbExTSit0UFc5?=
 =?utf-8?B?MUdVM0xEbGRGa2Q4b2I3QS96L2U0ZTQ4Z0JQeUFQcFFZb25hUndoaEhtUXVy?=
 =?utf-8?B?TmdtRU9VdVNwVXU3Yy9TVlJqOE1zbUdLTGtJQVd0RXM1UzZvMnljejJrSkdj?=
 =?utf-8?B?ZFFTYTlyaEF0MjRBQ2xoMWdUNG1MMkdoU1pRc2tuVGFLOWdQMnJVbkIxajZF?=
 =?utf-8?B?Q2RwS1VMU29DMXdwdWFEaGUwZTVxMjgyS3poQ0ltKzdxZW82OVlUa2trS0hY?=
 =?utf-8?B?U3pOMjhQOWMvQmRTMWxiaDZPempqdkJwTHV4K1RzV1hQK1RIb3FnRENaY21D?=
 =?utf-8?B?cGF4VDd2MEJVdE1hSTE4VWVIOFh5c3B5dms2bEVSUEFBQW9Ham9hUU9mc2NM?=
 =?utf-8?B?bzFMUnhKVlFKbTliYzNXZmhYUG5ReTkvRjhrbXgrdEFBY3JFRHZ6a2ZGR0pv?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212c0e6-9e1b-49ea-1984-08dc8a435ca4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:21:50.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1apIibgB12ZYJOO6IrqXcM8XfIhYhqo9t/SipNsmEwgC4b1EqdDRakyXKnohiu+WLLLtKnrSYYamgsTIJnsxFUke2LyEYaO9dSCvm3EGq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
X-OriginatorOrg: intel.com



On 6/11/2024 12:55 AM, Chien, Richard (Options Engineering) wrote:
>> However, this implementation is wrong. It is exposing the
>> ETHTOOL_GEEPROM and ETHTOOL_SEEPROM interface and abusing it to
>> implement a non-standard interface that is custom to the out-of-tree Intel
>> drivers to support the flash update utility.
>>
>> This implementation was widely rejected when discovered in i40e and in
>> submissions for the  ice driver. It abuses the ETHTOOL_GEEPROM and
>> ETHTOOL_SEEPROM interface in order to allow tools to access the hardware.
>> The use violates the documented behavior of the ethtool interface and breaks
>> the intended functionality of ETHTOOL_GEEPROM and ETHTOOL_SEEPROM.
> 
> Thank you for your detailed explanation.
> 
>> The correct way to implement flash update is via the devlink dev flash
>> interface, using request_firmware, and implementing the entire update
>> process in the driver. The common portions of this could be done in a shared
>> module.
> 
> In that case, does Intel have a plan to implement this mechanism
> in in-kernel drivers?
> 

I'm not aware of active plans right now :(

>> Attempting to support the broken legacy update that is supported by the out-
>> of-tree drivers is a non-starter for upstream. We (Intel) have known this for
>> some time, and this is why the patches and support have never been
>> published.
> 
> Although the utility in question has been enhanced to perform firmware
> update against Intel 1G/10G NICs by using the /dev/mem, this method
> would not work when the secure boot is enabled. Considering out-of-band
> firmware update (via the BMC) is not supported for Intel 1G/10G NICs, it
> would be desirable to have the support for the devlink dev flash interface
> in in-kernel drivers (igb & ixgbe).
> 

Yes it would be great. I've tried explaining why the existing support
can't go upstream, and why this would be valuable. Unfortunately it
hasn't led to action internally. I'm also not sure if all of the flash
update logic is in anything released under public open source license,
which makes it challenging for someone outside in the community to work
on this.

> Thanks
> Richard
> 

