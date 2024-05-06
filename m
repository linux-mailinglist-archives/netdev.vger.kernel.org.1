Return-Path: <netdev+bounces-93880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369E88BD796
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 00:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A45B1C229B4
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3E46424;
	Mon,  6 May 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7iqa0Aq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54B38DE9
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715034678; cv=fail; b=dqoqJUfZU4MXV5DukSp6U+9kJXsK+CqgQBLx2duu3s2K62NA8yfGHhcAar9RoOOVrVgJP5HgWJV59yBbs3iyTcASmFanz43uy+YrZPEmDoF8sra2XR4RkTEQtIaxCncpZb++5a0hPYTzhO436U4hT1wcEjcOt/SBUuYdHCXkEPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715034678; c=relaxed/simple;
	bh=QeAycMrjTnfDE9nMi4pWbo66edPgSw+CSPfEcfjpMwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evQByGIVV/l9fRtTmAT+QMH/yBy8tyx9NboTuNLhKGn0Wc5tpn3/xK/SwCSRBjsqHF0BvgD/kcw2v2+pIa4Xi0Atj2/2hYuoGE1sQtpniELBbqLNLjKF1LC5EtGAvWvCnDucb8C4BKbFXBxEE+uoAfecoKj6esgYcjiSH2/P/R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7iqa0Aq; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715034677; x=1746570677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QeAycMrjTnfDE9nMi4pWbo66edPgSw+CSPfEcfjpMwI=;
  b=L7iqa0AqEkcooPH6P2GFK1C9bV8a0sxdzSvnh34Ra5oO+icQ9CR+FKuh
   Q4bQ5r4FGKTBuIkmnhSfwkQmUsAPIEP7I1XIoWWxHJo4B75ijOVCojahQ
   FylUhJtBR4WUIHt7qM39PjRFEBn7fxbB8W1uxVEdwbzFyvc3tqWFBQXyI
   lDxdIBkd+iRfi2BiqN4ln7Gg04lb/dmnPkcbrfo2N4kIrYfVc2V57xrU/
   bjJPysqwXnEDfviSF/5r/hMAgbm7TzpzAATt8alW91Z2NYIXCKllVZ8W5
   bGqMLuLcay5SSawVgAZdGn1+uBShbJyIWlJSYomAVJSQBpnqs4hWnHey0
   w==;
X-CSE-ConnectionGUID: 1gNT3ryyS2aRSWMKHNG0cw==
X-CSE-MsgGUID: w2a32o90Sv2SlZXk/AYL5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="36185381"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="36185381"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 15:31:16 -0700
X-CSE-ConnectionGUID: 26tEiBXARLWzPyEehJYxbA==
X-CSE-MsgGUID: Ep482lwzTU+9s/9xEC5Ayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59161656"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 May 2024 15:31:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 15:31:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 15:31:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 15:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqKCwYs7rRJEub+lXIPkBJ5SlWEXscpLnMLKgigpgd61znlw7FJl7DwhhwrIiXei1iSRi2p3dDPNAgaeWZRPQsaJGkwmJWNL9RQIxiIUL8FlwVt2nmR1QnDfkmIPmocZOo0cT3DmoN/4dLpiLMVTK9u1CSQng57YSJVdcNZ2r92q+W6lqx2cNDICBleL2hib7UQkTLOHDDAG8m+dqV8tP5klSU93dGCv7D0QRXaXCnQWqWUYOA84Kl9fkNfZKQth2wf6C4qPn7f/vYcADf9NCdkv9mQTxDjfwxFdR+yyp8J4kLgU2QxEdq2JgxOZ43ILU/o9fdlB9XoQM64NzumPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIrN5fwIpJ+1YDu7jfe9mjn+DvtxsJabA39ky3qdeD8=;
 b=l+QkzoA2/hTKn0/r6DhhmeEitZlcpHhLQ+RAbdhZsnOFzXpVXz9njLxxumzFe4JJDuV7tNmzA87kT7mIy43ZvZilCPDefAvtgtcabM8Q8glzw2E0c5mtKVRrTcfhDkyCewVTkzNuoyJ0EkFWHy8k1rOpuLTM2TH2Yjw1Ks083NCIUA5JLIKm/JjI5WB2XujlwXmntRbkDrS24uSsCSmoKNwrPS4K++PKjA+ZEK4eqNZtsbOon+j+EIiE24CjyTmrmL8/1Ln64OYDVzXrk7IW+0LQdPywBV24dvMgXAt/mvAYV4RuTRElczDUBJTzkiRuNj9xWL2FCm7HnrwOcxkRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5323.namprd11.prod.outlook.com (2603:10b6:408:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 22:31:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 22:31:12 +0000
Message-ID: <0bfded05-d4d1-4b60-a3fa-24a2ff6644b5@intel.com>
Date: Mon, 6 May 2024 15:31:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: annotate writes on dev->mtu from
 ndo_change_mtu()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>, Simon Horman
	<horms@kernel.org>
References: <20240506102812.3025432-1-edumazet@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240506102812.3025432-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:303:6b::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 103528eb-dd4c-48a6-4e9c-08dc6e1c3bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDVsMDlHTi9UUDYzalAzaDVLMXIwZ1pHRHhmRGp5NVpweTNhK2h0RnpyVEN6?=
 =?utf-8?B?Q1B2ME9WZ1pERDhKeS9zY0FBUm1rY05YSmVGODRXL1F5WU9CcElnR25ZWHZi?=
 =?utf-8?B?V2dkOE9CaWREQThOdk90WG1hVnpZY0U4YUtDS2kzZEpNRy80REpocSsrQ1JT?=
 =?utf-8?B?NnFIeWx0dndLRCtJR1JnRy94akpvelJlcVpzMUJ1ZHIwdXoxclVoS3F5WENj?=
 =?utf-8?B?QnVyZWd2YlFyUkpFa081RUJVRGZNOFdtQ0JFcUhEMElqRi9KNmxmaElvMjNX?=
 =?utf-8?B?cjhXaDJWUG52YXd2YkJ1VEJoQnJKRWVpUXA1eG44WE4zcUdmcDA5NFB3Y3Bp?=
 =?utf-8?B?Mi90a1JveWR1aXd4anUvM2c3R1FMSlZSR1VlTVZJLzJnSlBXNEZXYjN6Rmxn?=
 =?utf-8?B?c1pBdndoU1JyNGxpa1VlUWNSVzBLUnVHTElVWWd0SUhFU0trb2dlb1JrZEU1?=
 =?utf-8?B?bDRTelFTdk42YURXbGsvU09vY3pyY0FiK05sR0hjSm5DeklJVlZkK2Z2TFVX?=
 =?utf-8?B?UWxxV2FyMlptOUpGTFd5USswbi9tRTVxVDI0YnYxdHNCdXUzNStzT2FzR2FL?=
 =?utf-8?B?cTRpSWRhWVpteGxCVzhCUVJGUWMwbGZISGRRUVZRdnVyZVZLRVZBWmEzc3RW?=
 =?utf-8?B?TDRabmpOMmRJMlQ0U0hreVJydlBVcG44cStBVUZEVklqVXRhbkUwczNQM29v?=
 =?utf-8?B?RWExL2N2T0M2K0UzRVNjeDFPQzUyQU1wbGJ2VmZKb2tyZ0tnZHJ4K1Q3YnRB?=
 =?utf-8?B?cHFTM2ZFUFBnRFpxQ0d2NnRaQ0tWODhlYW1ETTZ2aEdnUHBqYmxjYXllVkxl?=
 =?utf-8?B?RGFQeFFJUTlQVXdsNEZleDNXSXdEWTVLcFVKL1BNQVB1NXJCcnkvV3NrM1dq?=
 =?utf-8?B?djlWZEEvSTZGYVFzbmtndVVid0NtUjRReDh1UU94MFdibHhFMHBZa0VsSitt?=
 =?utf-8?B?NVlsWUlzNHlGK2NLdk9paGpiN1V2dERTZU9SMTNCdERPOFFsdDV6RUxva21O?=
 =?utf-8?B?K0EyOXV3SGtRV2ZTSHlVMjRaOWpvVko4OEVQTDFuaG91dllQSFRuWUtGeDhO?=
 =?utf-8?B?RFF4UnZab0Z0UGtESDhWcTcxb05LWTU2K3ppYkZPUUR2MFR6Y0FSTU52cnFr?=
 =?utf-8?B?dU81eXRtSWFkTFNaRHkvRGo5ZVZzV2M3RVU3VjJSWWNKdTN4RHJTZmlMakFT?=
 =?utf-8?B?djdHR0oxOUJVVUtuKzcvNERFRGhQQXdndGZ0RTM4Z0NYM3hkQWt5NXZmYTdj?=
 =?utf-8?B?OXRDY3NhZ1gwMm5GZWUzNy9obmRKY1V3T2ZGdm44L0g4clkzUW1ja0paN3lN?=
 =?utf-8?B?ZnVKMU5LTngyNHYyc3RsSElEbHhvU05EdlhmSUJhWkZkSTVENlpBRmlxTUhC?=
 =?utf-8?B?V2kyWTBOcVl1Z1p4YUJ3VlludUZrKzg3bnluVEVETExuc3lpSmpyU1lFeWVn?=
 =?utf-8?B?Y3NTMjhwUURlRU5FWmtqMEdhM1lWTEtjVDQ1OHNOUWEzN3VTWDZLZEV1eGpT?=
 =?utf-8?B?U0M1L1RmcWxLcWhyYkoyMHkrcnIzRXRmTURWZ3ZLL01uNzMvd1lMdnJiMTl6?=
 =?utf-8?B?SkNrN0NLL2hSdm9EZ2o4WUtXQWF6eDZzclo0MEhncFB6a1ExcFE2NkcySGc4?=
 =?utf-8?Q?g9HbqDlEfScjR29p0607/W7X2BUXLpcgHDIjOum99Xq0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZEaDFPOCtiWU9FYzI3bUt5R0JJeHY2Ym5VcGErVjJ2SkVGRVpTRG90dFpw?=
 =?utf-8?B?VGpHQW4zZVpqMzdrTlg4bjRjQmJ2cXgwcy9jZTVZODJKVlJWeHpkcDlNU0J5?=
 =?utf-8?B?eTVqY21OZEMrdjJPUE0xZ2c0TURwL1lIS0FQRWN2MDhucEJpa0FhWVRQVTdF?=
 =?utf-8?B?QnZNVDF1YXdoSG91REhiWDkzcjdNRmp0OFhUZFFNQVUxVU13VXZnMi9TVlZv?=
 =?utf-8?B?NXpaUU1BMldqLzNQdGVjMVJJL0lsUnNJNmp6RDB0WEpScWFNekdacXdCR3dw?=
 =?utf-8?B?bHlSVmVZSmVQS0loenVLVzNuM0ZoT1VMNDljZW0xckphU3hnWHNFVFdwTXdw?=
 =?utf-8?B?WGxSMUZ0YmdNQWtBTnRXZkNXYXlSTk9yRGo5emFJYjFqajdpeXR3aE1ZU29r?=
 =?utf-8?B?T3hsNk9pYUViUVpiSkJMc3hseTdtRS9mTStoZlRtNFpzM05NbU1ZQ2JIT2h0?=
 =?utf-8?B?Qmp6MDdwMDc3YXRJUms3dUhZMjhoSmdLSGlIdXh3N29OSmoxZm5rNWdRRW1E?=
 =?utf-8?B?c1VucExYdjhNd0oxWlVqVjBZcVNPZk5ZWE5NRGliRGFIQnZkRDEveDk5UUc0?=
 =?utf-8?B?ZExsMEk2Z0lBUG9mY04wakc2MHdpc2c0VTQ2R2FwSGcxQm1jUUtkYTZqRGox?=
 =?utf-8?B?dmtodXVjZTZXTElXbGJCc0xtMXVHU2V0a3loeWdtTkdXTkVSdlRhMEZ1ek5p?=
 =?utf-8?B?a1dhOTRkMUdvWlRFZFVSQUZ3RVU4SW5YeGxQeHdGL0dNcHd2OUJXdDFZbjAv?=
 =?utf-8?B?WXQ0R1F3Rzc4RFNkZkpGZ25nWFpycVNPUXhZMUt3OUhPRXBsOWZpTFpEMUNG?=
 =?utf-8?B?SmVMT052MUIrRXBaeTlPd2pqaG9LZEUrL0RzdCtRWXhOUld5c3dMRHhDbnVz?=
 =?utf-8?B?TWJTclpQNFQ4TXNnb2pacVpUaU5WWVpud3h0YlNONGF5bE90SE5TRWJkWjJF?=
 =?utf-8?B?NmI2ak5xUUVuWmVveWNqTG1pYWUxTTc5TEhSbHRidFZDZkZtdlB3YWI1d0xE?=
 =?utf-8?B?cnZSUVpwaXZWSTh6TE9IeDM0TmxzcHhZa1FRWW94YnhHZUsvSkpCb1ZFNFg0?=
 =?utf-8?B?bW4yeTZvbE0zZFNSYWUwOGhSZzRaNTNUYTBUNlJoRXEyMUlTVHc3MTd1Y1hC?=
 =?utf-8?B?UzBzUm0vNXBNVDRHc0l3Z1R0TFoyY1kzOWRFeXEwK0FWalAvbGN1NGNYWlZB?=
 =?utf-8?B?UFZqcFRJVmhySXNXbmQrNTAzSjloT1djQ0FPWit2bldPd2JlYjNDa253Q3g3?=
 =?utf-8?B?QnRSbFdLTy9JRE92cnh2N0FNK2F0ajVabGJnSS8zWm5xc2ZXcHN6c0FBMjF3?=
 =?utf-8?B?NVA3aklxMmxLamlmRm5raU02Y0tvYU1KelZIRTZQTTJUTUtReEhyV3lxVldC?=
 =?utf-8?B?b2F6WGZKSmdsZlJBSlYvTDRJWkU5ZVlVOWMwMHdQSVdOVkJlQVJ6aXZTb294?=
 =?utf-8?B?ZHQza3lQRzNJQ2FBQk9YVXVvL1ZScFVUL0pHVHRwdzlIQUFhejBRQVBocTRL?=
 =?utf-8?B?aldKdjFwOVpvVTNsdU9uamFRSStEOFRxRncrRmIrVWpuY3FZTnZkQjVUV0ph?=
 =?utf-8?B?TnZONGlzL2RDalc3VndiVmR1V3B6QklCcEtOSExPZjM0dks4Z2ZaQlYzWWFL?=
 =?utf-8?B?N1VMVW1IM0xjZU9acDB6K0dJU0dXR01Ud25qTjVQQUpmczc0YWtSVHBCNDVV?=
 =?utf-8?B?NDM5aTVoNGRjdloxNDFtcVVYTit3eWcvRWZYSHcwK2dTVkR5SEtaakdaQmFD?=
 =?utf-8?B?QzBFU0U4QzNIQnpCN1JmbWJIWFk4L25kNndpajlRS1VhM0hRaXF0NEQyNHFV?=
 =?utf-8?B?cVo2Q3N5WnV5MjlSWHFkeHgxUGdsWmUzUGU4Y3lzYmJ5am1TZ3dValh3ZmRL?=
 =?utf-8?B?VnBFS2poTmZtTWYyaEZqeU1hTDVzdHVrQUd1SHR2ekg0dTI0NHNOcXdMcEdr?=
 =?utf-8?B?YUZvVml6anBGQ1dHY3lmT25TRU9OckZBSU83Vi9yYStteFNPdFJRemR3UDZH?=
 =?utf-8?B?K00rNHN1WW9XNzlaMkpyTzVrNXF1UGRjQ2VralpXSWFMZ3d6VHJ5L2pzL013?=
 =?utf-8?B?VG1BWVpWRCtGQytNbFYxOUZIbUE5VzlqY0luUmI2NEN5OEtZR0Zyd2xNdFd3?=
 =?utf-8?B?bzhkcGpHcW5TZlk2VC9WSzMrcGYvYVVLajJKZkRhWTE2YVQ4N3lwa0pIaVJS?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 103528eb-dd4c-48a6-4e9c-08dc6e1c3bd2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 22:31:12.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS1lz/m4z0b0z6C4kyKVTlCdfzhLapqUS+h3kjBBhcnr+67pc7K2Jp3Xkf6HrotNtag+55y7kPT7ws3TNixfg9KQ239WQquV+V2jnSa0J3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5323
X-OriginatorOrg: intel.com



On 5/6/2024 3:28 AM, Eric Dumazet wrote:
> Simon reported that ndo_change_mtu() methods were never
> updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
> in commit 501a90c94510 ("inet: protect against too small
> mtu values.")
> 
> We read dev->mtu without holding RTNL in many places,
> with READ_ONCE() annotations.
> 
> It is time to take care of ndo_change_mtu() methods
> to use corresponding WRITE_ONCE()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Simon Horman <horms@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240505144608.GB67882@kernel.org/
> ---

Many drivers, but it is fairly mechanical and straight forward. I
noticed one place where you also fixed up the code style, but otherwise
everything looks exactly like a mechanical transformation.

> diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> index 7b7e1c5b00f4728cccfb693e2ab4e32b9613616e..b7d9657a7af3d168ea6fa6acd205d690fc79db06 100644
> --- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> +++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
> @@ -3036,11 +3036,11 @@ static int myri10ge_change_mtu(struct net_device *dev, int new_mtu)
>  		/* if we change the mtu on an active device, we must
>  		 * reset the device so the firmware sees the change */
>  		myri10ge_close(dev);
> -		dev->mtu = new_mtu;
> +		WRITE_ONCE(dev->mtu, new_mtu);
>  		myri10ge_open(dev);
> -	} else
> -		dev->mtu = new_mtu;
> -

Looks like you also fix up the style with { } here. That is fine with me.

> +	} else {
> +		WRITE_ONCE(dev->mtu, new_mtu);
> +	}
>  	return 0;
>  }
>  

The new style is correct, and I see no reason not to commit this now and
fix up the writes.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

