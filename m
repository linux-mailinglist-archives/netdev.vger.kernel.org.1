Return-Path: <netdev+bounces-90298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA88AD8FA
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204251C215D8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42E44369;
	Mon, 22 Apr 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6JpzCgb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026303D556
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828160; cv=fail; b=lkrzHlSxs1gqmI27JbpF5dZ/DU+XdQhBBXHo1QmYvc2k3Ff8PiqLjngtAdwCI0fTsXwtBnCAmBxhtABoPW56hmpbw7SommYxDY1JyFqq7/2AciFnxNrLy+UOJ1wxwZn2eoh9102rPge4weOgDmnZfkG44q2Y//4gbpfGfaibiV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828160; c=relaxed/simple;
	bh=wCzLIRyvLrH/uGyVzNEz6ZtXrWXWiErNknImeQQW3Uk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nkhmntf3LespWyNeECvHIVZeDa+hYjIPTRSNnXC/aRy929TorCm5ZM2mNxpArfP8TlUkMdxaQiiwVm8R06pI0c9lqdfX4F1N/WyqewAXAq37cI5s6Hby4pqhaUz522uqDfpJI+3z8yBuF+vbna0M08kg6f2YwYJUl7dPs/lLa8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6JpzCgb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713828158; x=1745364158;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wCzLIRyvLrH/uGyVzNEz6ZtXrWXWiErNknImeQQW3Uk=;
  b=d6JpzCgbeYtFT/wS9bdLTpN9vsDrtyAopJ0tmaBO1so1AoOdqb4WkvqH
   G2fN1Bi6W/tATrrTzy/fOyFISBrGuvD/ZLtPHWk8Khl6ihhursWNE66oj
   xcRyEJ6W2HWpl4ietdTWgL9bD25YMCw7MO/QP05aYmLW8e3kIgcbGDN3b
   cvrD2O5yjBSw8d6grbs8o9zN7rB58HdI7PSM1BOrHyj7piW5XM+MScVFC
   bFZJYsljTp2H4TfqtbLHjjarDo+l5Tiz8g3YpPZZpqD7o4mrtV6OnMZG+
   aJUhCmPqGHFu+IPYAoiy9UWxyGLL9HPROK92cGbO0FJwGwPcBanh2fpeB
   A==;
X-CSE-ConnectionGUID: U1HTiIygTNadv4/W1mMOGw==
X-CSE-MsgGUID: PhIbkBRLS7SHzlgL8AzDSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9558050"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9558050"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:22:37 -0700
X-CSE-ConnectionGUID: LH8BbWqWQISc0yQG39AreQ==
X-CSE-MsgGUID: DvNLBdp4TDOjlX2kwAuhEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="47453670"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:22:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:22:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:22:36 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZstX2gH8sbSw7vq/5dNqvuqdWOkuiilfXc45qOp8QS/llfHJw++pp2pinwWAw8Nq4jDwrbSxJDZJDwk7xZM1qsMiWpSYfs6sIdOKoDusDo6yz8nwTswQyMntP15w6cGInA4YQe8uI8/JjfMjSgpwUgercJ0IKt3ZFbKneaWTmsRNfe1e1IisvUJBJLXKT/S+g1WVLMuzjYrkwfRHR2e1V2pPpao5xYBbb+2+p9LZx6zV2lpEdkLlzZrmqnq8Hpj7NunaGOT1RY5DB1SROtgc68/32D/e4/ZB7Xe6K/VEe3HzIIBr+Mqn3Ng7Aq41T9rMduRF3rhfspJHDCnUH7Y5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXPLz5wkDNlR2/rnhzfF9bEQq2LR5S+qy5vihbQYNO0=;
 b=jScxuk4aQTd2IgrmEQUJkGREOp+0vLfnyEHHAcJSQBG891qbWuHCejEun7oeAv5SbPgwtVYZMW67rTEdQVsf+N5NdfXE/s4GMP3A6cE8mkWqNS7/pteodBg4yqczceed+hRhqU9FDGP36OGyPLIeyh0cuK6r66cfVL8nkyxJ1cJEsdUvVp4OjWC7d6byzmUFuDE2skUHXjxJiu/07Z7v5FGRqs+CUUXiAcuIWDNWVAwQUPTKB95zahOxHnMSfSIsb9rYGg5AqvUYuRGgVREc4VNXrcXZ0CBPN7EKoq4VG5sNG5iV9eMJd+/DYw2nd+dFdUXcGORuC3loolMJBnLRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYXPR11MB8731.namprd11.prod.outlook.com (2603:10b6:930:db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Mon, 22 Apr
 2024 23:22:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:22:34 +0000
Message-ID: <cd03becb-678b-44de-b249-a66b37a9077d@intel.com>
Date: Mon, 22 Apr 2024 16:22:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] Revert "net: txgbe: fix clk_name exceed
 MAX_DEV_ID limits"
To: Duanqiang Wen <duanqiangwen@net-swift.com>, <netdev@vger.kernel.org>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maciej.fijalkowski@intel.com>, <andrew@lunn.ch>
References: <20240422084109.3201-1-duanqiangwen@net-swift.com>
 <20240422084109.3201-2-duanqiangwen@net-swift.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240422084109.3201-2-duanqiangwen@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYXPR11MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 7076bd22-b58c-4476-bc8f-08dc63231734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkUzeWd4RTR2VTlMVXZ6Nm1EL0U0b2toTE54ZWpvQ014czFNTWo5cW4rN2xR?=
 =?utf-8?B?YkNTQi82dEtxbE5ZVG0zZGFhOVBVSC9KK3Z6b3RSd1VBaG5MQ0M1UktEWGlm?=
 =?utf-8?B?M2txc3h6ZW5SbE1PeFloSGFPeis1bHFObU5PeW5mODM0SUZnNkh0Z3pLSVBr?=
 =?utf-8?B?eW5IL2Z4OVVYOHVCNkk5bXA0eXNid2hxT05QenJUNzhoamFzNUMzMTRINllY?=
 =?utf-8?B?YXE1cElKUmMxamJaZ0JLZXo5K2s3MFpETXB3S1BYbGlSK1Blc3hOS1FxWWQ4?=
 =?utf-8?B?cW9PMjdEb0cxMnJIaWFmM2RUWElpdTlKZWVSTU1mamYyU1dyUFAxM1JPNW1C?=
 =?utf-8?B?bGxCdW5OMjE2QnU5U0dJSlY1MUliaW5mbEM0VHpTSEltdFdaZlN1bWdVWUVU?=
 =?utf-8?B?bjNVelI2czhvNHBZMkIvU1hBbk5wcEZRT0JyVmtsN3pleWJ6amlwUUF5VG10?=
 =?utf-8?B?REhKQjhiVWcrZno5WG1OVlBsSXZGc09CUitUS2ZOTEExdU5CZmV1UmIwRVdN?=
 =?utf-8?B?cUVVZ0lySkljaVZDZTk4bTBLV2c2QzNpNFh4K3pWWFdVcFNWaGxFaXVHaWUr?=
 =?utf-8?B?cE5mZ1pWNHFIeVNkU0VwUFBlNE1OOWdzSVhCUlRobzY3cEhOWW8yS1RqdkYz?=
 =?utf-8?B?WWd1dGtDTmxDWHFVdHFWT080RzRFK055QWttNEs0Szg5N2Q0c2QyY3pxT2Q4?=
 =?utf-8?B?U3NzamM4RHpQS0JYeEoyTVdMYU5JQURPY3pLR255OVJoT2pkcjFKNkp5UWd0?=
 =?utf-8?B?LzlZUHJCc21WZ0JoRjY5ejVsckdjS0Z1NWNPbXJjZGprdlBWR3BydExLNGR1?=
 =?utf-8?B?d25RNkhrNnlQcTVUaUhDTU1sT0Q3Z2RsbFNaMVlqVUZSNTJHNkxhQkFhTmx1?=
 =?utf-8?B?NmtDTUtpN1l2YTUxNnRqSVBKMDBPYzZXamdRU0xPb2UxbjZ3bi9IOFlPTWZi?=
 =?utf-8?B?QVIrSDRFSWpFZVk4NWRBbTRrTWpoL3RSVDNxVExUNkdBRW5McWJKaWU5RnBa?=
 =?utf-8?B?WnBEMnRGbEl3TXRPQTBHWml6TTdPemk4dzVZcVJDVDNWVW5kOFphWGEvTmtF?=
 =?utf-8?B?Zyt5WTRKeURra1pLTVB0U3BWTVFWZCtmTTY2RXVoaWdnLzkxMlYvaG1DajhS?=
 =?utf-8?B?T2J6c1RQUGpYZVEvWEdBR1JzWUxFNE9RRXp4N1lkajRYQTIrUXZWazk2dHM5?=
 =?utf-8?B?VjR2VTk1N08weHdkYVRSY3QyaS9PS2hjZ3UyRG14eUx5ZTBFUVZqb3l0VVZN?=
 =?utf-8?B?eVNiamp3WEovOHZVZDlWeDl1S2QyakQ2ZmxDeHFUckVsSjgzdEswK3RaZDU3?=
 =?utf-8?B?WnZ6Y3hxMzRmYTl4MHRTdW5jSjZKMkw0eHoyUEEvcGlkZDIyQWZCNG5NT2tL?=
 =?utf-8?B?dWp4QTRlcUo0Q3pkbFM1aVI5alBYVkUvc3ZLemtVUFpaSEUyNXVqN0RBNEdq?=
 =?utf-8?B?V0R0KzZvbjA2ZERIaElPRmNObWVobTV1SXdLR1dLSlc5aEtkOS9TL1Nsdi9W?=
 =?utf-8?B?eUc5Z2Z0ZHhoMlNINmVCT3Blbm12K2tqYzR4WVByakJvcDAwSnVuMmlkS3VL?=
 =?utf-8?B?MkU2RFM5ZFIxSWJKZXFmV2x0eWw0NWg1MmwyMjZuMnVzUzZzejREb2ZVcnd0?=
 =?utf-8?B?NC9ieUFJYmpzbWJuOXFRUkt2ZEFrOXBIQWFIUnBZZC83MUF0SEhCa05yaitT?=
 =?utf-8?B?KzEzenY1VFNVQTRuZi8xMklZcUNWMlRYdjZsZTMwS2JwQVlEa2NvTFNLeExq?=
 =?utf-8?Q?sGOA1qcgoAt2kpEvyetBNoT4radoU2/ldxp/9h1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NEZ29IQTNCZmcwVjd2c1N5dzhEMG5TRnV1QjRyNmtZODJwbEhzaG4wWGlK?=
 =?utf-8?B?bVplR0ZDTGFxWDcxdFNOZzlSVE5LSkhXRXJyZ0xxd005VmtIeTJqbUFITSs1?=
 =?utf-8?B?QS95TVdNMlF0YzFCVVpsRk0vNWRLRGxWR3grcHRBa2dZYmk0QTdvUmZTekkw?=
 =?utf-8?B?cnl0TW9WZXl2eUxubS8yNXFLUnBzT1RzNm1tU2d3eDBNYlh4Z1ZkdTFqY2hs?=
 =?utf-8?B?bElKbEQzY0MvT29qaG9wSUs1dDloMUp1U1o3eFd0S3dCNWVjVCthckdoaXFO?=
 =?utf-8?B?RWVtSWlzbjRnYlZHNW9nRlNHY2pDQjlUdE4xLzkrSU9jdC9SVDlBQVJJWW1R?=
 =?utf-8?B?VWs2M0djcWMrRHNTVi9YY0tQL0dST2VLTExOS1hlN2hRbG1xdFV4elBOVnlQ?=
 =?utf-8?B?UGZZaGpUOUxtbWF4UW44SXIrRGpNaGRFcTN5czQyeFhtZm1mQlRnako0ZDBG?=
 =?utf-8?B?T0MzQ0RzNG9rTWlUL1RNMXlXUUR3OEJNZm1sd1dnUXpTamJ3R1dweU5OMUow?=
 =?utf-8?B?U29NaktjaW82SS95TGN2QmFGK3VkbzIwQXRJaGg0cmR3MUlLSkFIYkt3bjhT?=
 =?utf-8?B?RkZkMFZvUCtvKzh4QW1oTGwvMEErSEY5SVNmTEo0dFJYV1dWYXBtOFFvQ01y?=
 =?utf-8?B?NmVkV1pZL00xR2l0OWNVQTFOb20rZ3NmQ28xK2tMb0JIbHVxRUptb2pJTG5P?=
 =?utf-8?B?OFRieTIvU05BVTBaRWFxS1UzSFc4Um1OYW82RWVWQ25VUTVuT0ZqVStZWHJU?=
 =?utf-8?B?SndIV2Y3blJsNHlrdVpSeW82WEF2a3d6QUJoRU9nVk1sTWYvKzVQTVhMdFUv?=
 =?utf-8?B?SXFVRjY5Y0tQOFF6STl3YUw5MlVERVlISVBjbm5GY3BpclNFdy9ZbDUrU29y?=
 =?utf-8?B?TTRqbDhrSURVd0ZCa1IzNXhyVWVvcFVmb3pzdkZlTWYrWFl5ZC95MFBVQnpH?=
 =?utf-8?B?a21FTkRSb3NCU2FaRDVDZ0JtL0RZdGYzbEpTaEpXRkdwRk5zUmRTc3l5RFl5?=
 =?utf-8?B?a2gybnJlNkVkTjRQYndvUU5kRjBoeGJBQnMyT1F4enA3MUdTQ1pCNlgzRzZG?=
 =?utf-8?B?cjlsUkpqeFRGaHlWRW4rVVBCK1ZheHFkZUtZTUFPcFo0ZW4veGdvSVVOTlF1?=
 =?utf-8?B?OTVDZGtZTXE4YS9uamVwMTZoY2Z4M0dIcHgzZ0hyNno2cldDdm5nVW9QZktK?=
 =?utf-8?B?TlZpNWtwUitBbXllVDlqa1ZSdmV3eHg3NmxjSHlaMmRUMlk2b0lTaTdIeC9t?=
 =?utf-8?B?TkV5R25BRy9jRU5Nbm5JYlozVGhISWZGS2FDakU5cTZuckZYSVl3SnlWSW5i?=
 =?utf-8?B?SVlSb3pRVlVGSmhlTXl2K1poOGRFZUl3T0JtSGVzMHAzazdnZTB0UnFVWWdD?=
 =?utf-8?B?a3lOZXNkUDlBOUExSDlTNWJLNktDQVMvdEVUZEsrOXZpc1p4emVWd0lmQ3I1?=
 =?utf-8?B?VmVVL0ZKUnhJMTVqQ09jdXB3YmhUYno2YkR1eFJsTTNkc0pVWEFHYkZWdTMw?=
 =?utf-8?B?blo2SDRxV3NsOTVqenArTVl2bHJnUlE3T3I1aER1V0ErdVJFRFQrK1BSdkFB?=
 =?utf-8?B?aWJscm5wcXZuRlNRTFhkZk5pMWtIaDlsK1lWd3pGL3FUYmttaHlydklvbXZw?=
 =?utf-8?B?aTBOTTZqWFYwc2JCUmhRUEFuQnNEeGZJazRvbzNCendVRERqbDdEOXBlQlNn?=
 =?utf-8?B?dENNTjJtT2dkcEhMNjFidFgrSDZsT1FFeE5sUWg3OWViZmV4Zlk2bjdxWXBa?=
 =?utf-8?B?MVQrYTl6cFVpV3Q3NXg2NEN3WjFXUDdkRkhLOW5HWFhJTFRiTUpJVjFPODBH?=
 =?utf-8?B?Q3JySmplRXRkL25hY3pVS3Q5NkxETWVLK2o1WmkzNHYvbGgvQVlqUzdkZ1VL?=
 =?utf-8?B?Q1NKcmltR1dPdUU5ZDc0djY5d0hReU5WTHFTSnpORnRLV0w0bHJubDVuZjVE?=
 =?utf-8?B?VWI2SUhKL3RiTGVXdGEra0ZVSXFJSklNTjdQSHJyWWNkWDBiOHptdDRKV25D?=
 =?utf-8?B?blpKcGl6bm9WSjNUK0R2dlRwZzlKR2pLcVFybG1IbHhoeEVhb2NTZnBkdzBI?=
 =?utf-8?B?SmFOclF6TVpPT25ZYit5T0JxVmNaVUo3d2xWb1hvRFFiVXBkRk4zUWUwVWxS?=
 =?utf-8?B?NUVleUNNN0JFdkVzcEFXUzlZU3FiVGZZUG9nc241MEFLSkpLUTI2UzBrd0Jj?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7076bd22-b58c-4476-bc8f-08dc63231734
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:22:34.5112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViKA68njRFjdAHPKllqPHSo1LWsblB9u59SVftAFti8NV1x5XA2Uq1/LJQTs2wH4D/2OeyLpwMfoyce89pG4v3cZ2dWKc9RG4RXWyM0r1vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8731
X-OriginatorOrg: intel.com



On 4/22/2024 1:41 AM, Duanqiang Wen wrote:
> This reverts commit e30cef001da259e8df354b813015d0e5acc08740.
> commit 99f4570cfba1 ("clkdev: Update clkdev id usage to allow
> for longer names") can fix clk_name exceed MAX_DEV_ID limits,
> so this commit is meaningless.
> 

The fix for longer names only adds 4 bytes, so it does fix this
particular case but doesn't necessarily resolve from having a future
issue if another name gets a bit longer.

Still, it makes sense to keep the original name now that it fits.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 5b5d5e4310d1..93295916b1d2 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -571,7 +571,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
>  	char clk_name[32];
>  	struct clk *clk;
>  
> -	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
> +	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
>  		 pci_dev_id(pdev));
>  
>  	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);

