Return-Path: <netdev+bounces-75468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A782486A08B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE031C25AB9
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C6149DE2;
	Tue, 27 Feb 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ8c2yI2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4840149000
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063496; cv=fail; b=IUTcTP3MmMx9ecgypOPU5cd+INEQNVSet8Xuqoo5dKOajHVDa/bFnmez8zDNR2s/a9kPfRVShPSJbxI43g3Ek3ZnNW4fe1azT/7TuICHIcluw5cJHLQlXtAM+/C0PL5OtG3LXYVjYwFWtwuzbTknThBXI5y0ZXc2gJN5Pv8wick=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063496; c=relaxed/simple;
	bh=9miZeflv6JwfH8P8s3jmTzTtZcinTKxbOcUVLBIcYyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jjw5rG5s2V/PG5KqTK/L45WSxZBn6Aly4whogCPDDuiByL5B0QTl3R3DJD8MdtJ1OqITLqgxHKJ4ByFHtFHxsoZdINYvtks+QBzGE0PknOqhwbE1HfCClQ1p2t5rorx5BKZe6Sd3sUzfXQlUZcVFfeBvmJSTuaOGM6SijTa+UMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ8c2yI2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709063493; x=1740599493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9miZeflv6JwfH8P8s3jmTzTtZcinTKxbOcUVLBIcYyU=;
  b=OJ8c2yI2MnVZ3yErDAxsUcI0IWdYvi/tcr6Bf8XLN3KsBRZDMLisaSRL
   VUJChrq3hRybxhB1eyxGUyPEyOd5pCPPqKYQOmMhjO/ICUNGPWCHl2qfo
   1T+cJ9l4f0TtWiTZzNrMRrlYSBfuU/fBFdG/hxylQ+EGj3Fzwvj8h5+sM
   02zGDWCelGcf6884FzFLHYHSShgenLuQEICAw6mBBYchNibiEb8Rjt3ur
   cYTQLRHZoAFOpXbGUNDZEdBvkrCk1mCVrAS9RG1KRQtrqB4J7+7zk1MKj
   whHCeBGyWAXBdTDaqWxH47ZYKnI/cTkxQFN8LkPfAdIEPMcZDBFuxmiKP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3353887"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3353887"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:49:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="30350378"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 11:49:30 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 11:49:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 11:49:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 11:49:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 11:49:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhcBEiYx8lX9jlGpJT/imyCJcH+GUye2FYIU56khWN90ZBIbQc4lv45+J6dZ4ZWsa3PAs+GwWnGHQ7fgyXVjoIFGJbzBVtMR4Sc7YI9aP92UmO/jxwUw1k6VGDfzy2f9eVvA4UP7t5vZb2gLv0pkRJX8HChXnqAne/YeG4/EYwKU6ctprCimwqAl5cPqITqGVcdGmodeihmlgaONpRhGKanlBdXbiM7CeV+LFxpGLHdH6fFa64Fk18vSdV9OjGbKQVfqPcTWwbOjrnMmFY0z9XHu/72A1DtwFFm3J41drlHgajHQqKsAjapW9IlenMEprpZ0Mzlxgla1WtaMLeTd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVM+JEonnLHUE4rw+ZEr9Xk9agReytnaXxzoSGzyBe4=;
 b=FupuzU6UpKB415xgPdQT0B/RmIpvp2Ng3bi7KV0nS0Qakf7r5znpIvTxVLk1nTI/DPeP4xsOmD1T4HU+qHmq0pyso8zVLwcHmI+5XuN0YfXw2Hu6VM56CYlTi/KGe0X6wIDpnihF7Ie9VHDMczLTeXhC9/3xGTTIMS8NnZrOPy1e/FqwLOZHX4NfmnmszsubebktRkYpHQ+7vzReqHXMCi4NH/Bus+rI/DL83bQCxETQdi3vQJYqXLqF5Vz1R/mYJv51qBduXQLwTQhuBJNGavsRfbu2Bzc/HJ3uUhrYv4JttoKMrFrINLZ05tyzCjMvkhhDBnTvgq68/0XFLfUYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB7913.namprd11.prod.outlook.com (2603:10b6:610:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Tue, 27 Feb
 2024 19:49:27 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 19:49:26 +0000
Message-ID: <8bf64451-fd0c-4365-8d47-71792a9603a5@intel.com>
Date: Tue, 27 Feb 2024 11:49:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@google.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>, <vadim.fedorenko@linux.dev>
References: <20240226211015.1244807-1-kuba@kernel.org>
 <20240226211015.1244807-2-kuba@kernel.org> <Zd0EJq3gS2_p9NQ8@google.com>
 <20240226141928.171b79fe@kernel.org> <Zd1Y4M7gwEVmgJ8q@google.com>
 <20240227072404.06ea4843@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240227072404.06ea4843@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:303:8e::32) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f16c0b-8704-4d64-6f2d-08dc37cd345e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJzbgXrW9tKkac06//21t8MlyvY6ifspPSJ4g7mXfro+3W7u1dE9xvNA+t4IEvjxl1p5kV+y9PMb8uUV5DJ5rj3FwtHWES8EIXOiACbE9VlADSAY62g+Kwet4XJOqgD9wWdnPVLPSOMRVT0Z0ex6AkQ5v9SFbrRwSwrM3fLuPKBfRS3a2xk/dij31VCeA278mL5l2kwzjhdgHzCqEK4hz92BMBMts5Hery9xEZVXBlYmLTzesE6va5OV3mMUW73SrtmAigMOC9s/Cc+u5dax9OE/KgyPA1G1ng/nm6d5ddMPDhvsIZ55YrPyooD2oE7a4bJDxiAAdGJsa2cGTV4y/9GAd2LF7gQjqiWS2N1F4cMPdJ3UuzEXOI/R426Wu1hqzMVyVkwelrG4DKJ9Wpkg21tm/MF84dlHhivppfZIf6HuHH6j5roNYXjoVjR0bYOQ8fKW4Dk7bcV3dTZCZCAG5lWzBprObUE/LwBpP+76D0sJoP1+OszhEotZo7xAUClfGUeEsIu1dw6SV5AN0MsWg2zQvmbZfLjx1HRxT8VwsEi2VCJz+zh2VWNg4+m21gfXj3ouvZVHqncTl6jSKb9+cDsmw+nr5a6OrNAIcGJRRMgIXxmvZvuPgE494fNifDU2i4mctkKtobLz5iuol5PQvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2ZoM3ZJNE8vN0tnVEdRMlFucjlyOWxtS1JZR1NETmg1eTJ3dVkwZ3N6ZE9O?=
 =?utf-8?B?YmQ2cHFvVEhtTG1CanFWdXFhWVppUkZEUXAvRHZGbzNnWUxndzJPZ2hEd2dp?=
 =?utf-8?B?V3hBMm5WQ2crZHdzV3dENVg2eGxlcnJIYitSTERSUTFiZXdNYmk2emx0U040?=
 =?utf-8?B?TE1JOVZkeno2RGlPWGxQS1ZDVUlDQlEwNExnY284bTVHQnUxNTV3ZmZXa3NX?=
 =?utf-8?B?MS9GR2lDbjBjanl4SVVXK1o3WkN2UU1RejUrWTQ2NUFqZjFZZ0RCclVaME5w?=
 =?utf-8?B?SmlicUFMUHZScTdxdWVmMU1udXZ3ZVZKZTM4K0E4dEJqc0JtUWhxZTFoNHk1?=
 =?utf-8?B?TFFPMlJ6QndGR2F1UmhkbkxHNG9kT3NzMDlueFN3OFlZNlJnbjJ3ZURaRFpV?=
 =?utf-8?B?Q0pMSjNod0svOFV6SURIVUtnU0Vxd2Y1b05YRHFNQ3VVaTh1T01maDhtM0F1?=
 =?utf-8?B?NmpkeUdQRmRKRVVzZi9SZGJWbW9zSkN3OHEvTzlQb2s1RlI3aWhsUzBWVVFX?=
 =?utf-8?B?NmFPeW42MUNLZGJzalZUeXZCYjc2b0gwNzJJeWR4YkFoZytHYnpiajkvWk44?=
 =?utf-8?B?djY5cDF1Wmh4ZFF3aEdFb1dHRkxSanJ1d0VYNEc0c21FL09aWmNMdS9zL2RN?=
 =?utf-8?B?NWsvWHFUUVJ0VjBxWXBkWnZBdDh6VjNRR0FpbEswL0I1MzNGY1ZRTzNMRE9t?=
 =?utf-8?B?ZHgyN3NwR0kycnh0d0FEaUttbm5XN2t6U3ZudkRvZjVVMmQ5NjhhYnAvTGJy?=
 =?utf-8?B?UUdHZmNXSVpXRndPNTBEMUlxL3VMcHFqQzAxK0tkeHZ4UllESGdzWDhPSkdI?=
 =?utf-8?B?RS9mQ21DNjlleFQ3ZXBkd0pKY0RiS0RUTUdzbnNHSkZZNlFQNWJDaXl4RmJa?=
 =?utf-8?B?eU5xeUNTck9ISmpyV21JZzR4bzU5MUk4VHZLRXVPalB4T2RTc0oxZjM2L2RZ?=
 =?utf-8?B?bkRYRit5VHUreHRrYWNMeWkyUWVCdUs4czlRcGUwS092SXBXQWE4bVk4aUtP?=
 =?utf-8?B?YksrMTFIWnQ2ajg1TmdrK1M0Z2U0Z1JWQWFUUldHeWhsc2lTTDJ3RTgxUUt0?=
 =?utf-8?B?WXltSHFYWUFEbjlaa2RBdG8vWmpncFhrSTd4ZzQ5MWwxWldrYjdpeEl1empr?=
 =?utf-8?B?cU9vd1NJVEMweGxGM25iZmNZa0ZxMWNDM05hZDd6czhjeXBlaVdoRG1MNHhQ?=
 =?utf-8?B?Y1dxbGVvS0xIL21USHpmWUZvYzFUeDYvTHg2eUp0WU1BQ0htUWh0cWZyZ3Vx?=
 =?utf-8?B?d0ozNzZ6THlXdXFKZlYvZTY0VlFlTFN2QmVEN3FZZ0lXOHN1UnZDQlZqVlBr?=
 =?utf-8?B?c2d2dEY0Sy9mK24yMDBZaFh5RXZZOFNGR0REYWE5SmQwQnhETnV4bHYvVVpJ?=
 =?utf-8?B?cGFUdlRQdDVCTXRZWFRWb0hZNy96R2UzRHBYVWhpWHI1dmlCejQ0c2ozdzFT?=
 =?utf-8?B?V0JNdXJyUUt6UXhUTUlaODZuTzMzU1R3aFZYay9LT21neStiYk10NVVHSnZJ?=
 =?utf-8?B?Nk5yK2lBN0NkNElyWWs3SVc2Ny9PVGtubFp0azVDR3htb2RKV3UzTHdrd1FS?=
 =?utf-8?B?RHN5RlNGamtwanh1REE5QnhmMi9XQ1JGUXQ0WmpvMkliMkViSlJIZ1dTNDV2?=
 =?utf-8?B?QWFSNUYyRVFOY25TakhsNEduemNVdjJSUlIyVFo5c1Fib2tTbkxMMUJxQmlh?=
 =?utf-8?B?d29ocDJXeFpVRW1VZE5RNFJnZWpGV0JTNGk3c1pySWh4KzBkUXc2QzZ3cDhk?=
 =?utf-8?B?UHA4ZDhZbTBYSms4Y3JXR0xncGpuTXpOYXM2SkdyeEw4TVh1UU4wNzF3M25L?=
 =?utf-8?B?M0VlS2JPRUhzK1hmWDJ5MUg1MEVYbjNLTmxyMzFubWx3YlgxbE5peTFHSzJ5?=
 =?utf-8?B?Y0Fackh4S3NUcGIvRUZVa21lN25DcVBFT0dqc2ZXR0dvdjhsdVVRL3Fkc2Ur?=
 =?utf-8?B?aUhlUGlJajNrOU8rbFlYbTJBRVNjZFNBcWhBS24xR1VqMjNOc3hhUHhDNTR4?=
 =?utf-8?B?a1Jtb3VQSitycmFBd2h2bUFvc1JXWGIweGZaQXFZQTNESmxRL0pnN1dLcCs4?=
 =?utf-8?B?U3RxSVhHcnRsdmlOaVozSTdhYTRnalk5WWVCVXZoUDVFZnQxdGJFNXlKS21I?=
 =?utf-8?B?MFpndGxCSi9iZ3JmczZGdFRZZXp3MXBjUXgxWHo3amF1cVBGQ0gyaGUzVVpR?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f16c0b-8704-4d64-6f2d-08dc37cd345e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:49:26.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buBIe0mnlc+fEyLatOrrJpgqTyNzCfaJxnZxU4DJ3fILA0oJniokANgZw5OClY0hfpAkR2zaoRogVjq9sLPjJOUUZT1A74dc3fPyBPFcO1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
X-OriginatorOrg: intel.com

On 2/27/2024 7:24 AM, Jakub Kicinski wrote:
> On Mon, 26 Feb 2024 19:37:04 -0800 Stanislav Fomichev wrote:
>> On 02/26, Jakub Kicinski wrote:
>>> On Mon, 26 Feb 2024 13:35:34 -0800 Stanislav Fomichev wrote:
>>>> IIUC, in order to get netdev-scoped stats in v1 (vs rfc) is to not set
>>>> stats-scope, right? Any reason we dropped the explicit netdev entry?
>>>> It seems more robust with a separate entry and removes the ambiguity about
>>>> which stats we're querying.
>>>
>>> The change is because I switched from enum to flags.
>>>
>>> I'm not 100% sure which one is going to cause fewer issues down
>>> the line. It's a question of whether the next scope we add will
>>> be disjoint with or subdividing previous scopes.
>>>
>>> I think only subdividing previous scopes makes sense. If we were
>>> to add "stats per NAPI" (bad example) or "per buffer pool" or IDK what
>>> other thing -- we should expose that as a new netlink command, not mix
>>> it with the queues.
>>>
>>> The expectation is that scopes will be extended with hw vs sw, or
>>> per-CPU (e.g. page pool recycling). In which case we'll want flags,
>>> so that we can combine them -- ask for HW stats for a queue or hw
>>> stats for the entire netdev.
>>>
>>> Perhaps I should rename stats -> queue-stats to make this more explicit?
>>>
>>> The initial version I wrote could iterate both over NAPIs and
>>> queues. This could be helpful to some drivers - but I realized that it
>>> would lead to rather painful user experience (does the driver maintain
>>> stats per NAPI or per queue?) and tricky implementation of the device
>>> level sum (device stats = Sum(queue) or Sum(queue) + Sum(NAPI)??)
>>
>> Yeah, same, not sure. The flags may be more flexible but a bit harder
>> wrt discoverability. Assuming a somewhat ignorant spec reader/user,
>> it might be hard to say which flags makes sense to combine and which isn't.
>> Or, I guess, we can try to document it?
> 
> We're talking about driver API here, so document and enforce in code
> review :) But fundamentally, I don't think we should be turning this op
> into a mux for all sort of stats. We can have 64k ops in the family.
> 
>> For HW vs SW, do you think it makes sense to expose it as a scope?
>> Why not have something like 'rx-packets' and 'hw-rx-packets'?
> 
> I had that in one of the WIP versions but (a) a lot of the stats can
> be maintained by either device or the driver, so we'd end up with a hw-
> flavor for most of the entries, and (b) 90% of the time the user will
> not care whether it's the HW or SW that counted the bytes, or GSO
> segments. Similarly to how most of the users will not care about
> per-queue breakdown, TBH, which made me think that from user
> perspective both queue and hw vs sw are just a form of detailed
> breakdown. Majority will dump the combined sw|hw stats for the device.
> 
> I could be wrong.
> 

I think the per-queue breakdown would be useful as well, especially in 
usecases where there are filters directing traffic to different queues.

>> Maybe, as you're suggesting, we should rename stats to queue-states
>> and drop the score for now? When the time comes to add hw counters,
>> we can revisit. For total netdev stats, we can ask the user to aggregate
>> the per-queue ones?
> 
> I'd keep the scope, and ability to show the device level aggregation.
> There are drivers (bnxt, off the top of my head, but I feel like there's
> more) which stash the counters when queues get freed. Without the device
> level aggregation we'd need to expose that as "no queue" or "history"
> or "delta" etc stats. I think that's uglier that showing the sum, which
> is what user will care about 99% of the time.
> 

+1 to retaining the scope and device level aggregation to reduce ambiguity.

> It'd be a pure rename.

