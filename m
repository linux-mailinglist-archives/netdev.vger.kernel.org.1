Return-Path: <netdev+bounces-91830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953868B4224
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 00:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94A91C21AF5
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642B364A0;
	Fri, 26 Apr 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaL/yS56"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CC3B28F
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714170351; cv=fail; b=nDszM/nCOce7NYSZyfYUErWMhrn6s8QK65oSMnQ0g5gVk/b1i7C7jsvNpCX9t/x879iKzPRGgau6BqrEabay2zuqpe2uNanrrYzooHvMAXQ4QrU+3sZJRN16CQKzNH+ypFdVWZ9QHCjug1S1AsqNkS4pQT0fSaCRdCuVvHM95EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714170351; c=relaxed/simple;
	bh=UPrTRo9Ch+oI3N13GlZV/TNoVp4zPOTw6qQKhhMbCsM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exY9MJGOlvo+ormMJG9Lb1RlTBrq06KZTNsgBFwMt7uuo0ltSC/RZYuxahO94jQOzC6A8slRw2VlLA3CaWv68Fr7GiuaS0Tgrxfa6PICAY+sKfMgYvL2Gv9uOyQ9ZDC+snwv2e/UWSFWLcyMFcK1y/zcoxqO3g4VSlMOZaMU1N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaL/yS56; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714170349; x=1745706349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UPrTRo9Ch+oI3N13GlZV/TNoVp4zPOTw6qQKhhMbCsM=;
  b=iaL/yS56aTrGtUC5yLi9sOOjPIDd6fYcjqB2Fn7WY0coPa7NgXQN6Qfj
   8ybjtaKDNlJo/ouGtwU/YpjewiX0V0CF6wdG3+1xRnSjBX41wYToK09lM
   BUl/S9bAd7Wqb/TKuqGeU+y7KJ2oiHM+dphBA90L47Q8Vw9E3MdDDW+zC
   lU4vBrzPisioKgpkBUca6dd9NeqViSvOs6RhcSnf0WTEp/MkMzM4DhqCC
   Rssf7cfswxKX6MqHmKgZV6pBJPYWIuu9Fh2TFmq8OuhD5X9PhxgPMkard
   CjuDn8ec3I8gKu7CGhT0ajpE/4PPKA+w62EplXv7n/L7hlnxzncdpNdS8
   w==;
X-CSE-ConnectionGUID: zw4WhsEIT3OjiGrZVFCFNg==
X-CSE-MsgGUID: U1E1CCsAThyLIA239V6Z7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10080025"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10080025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 15:25:48 -0700
X-CSE-ConnectionGUID: HWJhoPmkTtigZPL2rMf3AA==
X-CSE-MsgGUID: nHexXkimSg+TzKNZJGVzpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25633127"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 15:25:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 15:25:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 15:25:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 15:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPqAQKT4uaUO+MRofeUSzwwtNEnhv576tH2SGK0Lrb0yAZWmWj8MWwWOqt5CuRWY7Q2iSQpxpVK8NNsQXsCRLpcVRdehmAGZj0il/x184IyAHMTvtZEPyWf1jQPTQ1jP47yZzcl+3rMD/f9OIs4dX44305yhs1IsBYlAUWUaHS6QtBsOk8nSyDhRBetpBeNyRJDs4LIVCjbZmU8TqKyPcut3EqkReHMHwMBtKWvDuDHh85l9K72sAALTCgJzc3PJ7CxphpcvD07QvoaZNL4HzaGwBMvUjhKXhuc7H9UP19CzJzJgyNHECuyzaQKHzF12cQVQExqS5Vti3YRVXuSuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75twTWspiD6T1tvLIaBxMMuJoEjZs9RLEIyVPRej928=;
 b=lC9VIcKnLemrUzvxpsuxvzYF7a9Z+vX+9uL210H8g4TBlt9eT++1JTMx4GkEZCYbzJbwM8FjVHjsKDnQqndh7InWj3thmBdKylbXyVOYu5VLprmm2GRSpqM9Un2xuQCz7DxSILJuIHmJXIM9MUCfBHGW5OOgN2Br0P4OsASmvVpQfVV8t7hbi+JSqYJhIw1FYsW9CVZNa9hJS5qDa+Wx5rg2aEKPBo831Tbxn62I1QtE/B7FqClurjuSVajUH4IQ7m9njNV/wOdDW2scMSYK1WDH1RCwAppdAuYU69Ycj/bK62uXeU5aoP8Zo5QaDtFTwkSUMuYtsII6fbRTnz2XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5821.namprd11.prod.outlook.com (2603:10b6:303:184::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 22:25:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 22:25:45 +0000
Message-ID: <698dd861-951b-44d9-91b0-5a39a953857c@intel.com>
Date: Fri, 26 Apr 2024 15:25:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: Extend auxbus device
 naming
To: Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Knitter, Konrad" <konrad.knitter@intel.com>, <kuba@kernel.org>,
	<gregkh@linuxfoundation.org>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
 <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
 <Zie0NIztebf5Qq1J@nanopsycho>
 <3a634778-9b72-4663-b305-3be18bd8f618@intel.com>
 <ZikgQhVpphnaAOpG@nanopsycho>
 <3877b086-142d-4897-866e-e667ca7091d7@intel.com>
 <ZiuNxivU-haEQ5fC@nanopsycho>
 <39daba1e-5fbe-495e-8398-200434f89230@intel.com>
 <Ziuvjj8h7GzsL9RF@nanopsycho>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Ziuvjj8h7GzsL9RF@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 064895ed-26b5-44e5-39ea-08dc663fd10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dktqUy9sVHFCWmFnNmh0SjFCNDlRKzFkbjc1RGRSd0hGY0M4d1B2OEZ6SUN2?=
 =?utf-8?B?YnNqMzVQcHd6ZUhmaG53S2tCVU5ySENTSGhUZGh2UGk2SWlWVlkvRlpTYTh2?=
 =?utf-8?B?RE1PV0ltOXNSa2cwNFNUS0pyNmlDU2Z3WmtaTkl2eDllOENEWGZCMlNpakZU?=
 =?utf-8?B?RGlvNnJabG5xdFduNlpVaTFtS1VhYm83a3QyeVoyTlc2RU90bFFqWHpqQjFL?=
 =?utf-8?B?M2RBWDhiSU80VXM5bzFaaGx3WitLVWpRanAxUHFJanFGekNzNkVhWmV5UnVx?=
 =?utf-8?B?NmZxbEZIc1pkNVc4VUJEQ05ZczZlT2d2NEwvbkpoYUxGb3IxSktndWxJVWN5?=
 =?utf-8?B?ZGFkVkkveHJZaHNoWkgyb2UrNFQ5ZXhMYlZXNGtlNjQ3anNxaC9SaGo1Wnl2?=
 =?utf-8?B?cTR0dWRKZ1VIUWVVYi9KVFBKUFRTT3dZeVRHVDUwZitsbFo2djJxa2ZqSVdF?=
 =?utf-8?B?TnYyeUhqZ2ZvM0R5QUtlREFyb01xMUhHb0dCWVpEUVJqbWVXT0Q4bU9yNlpJ?=
 =?utf-8?B?WEFkRllQRlV1UUQ4VHNrb0xVdkZ3akdDOUxmSEl5b2pvcXJCa2VTQTRCMzFB?=
 =?utf-8?B?T2pLT2ZKeEFlUExYei8yRVV6VlM1WWQ2TTJoNXB5bTJGdnpsa0VObXZ3QWZy?=
 =?utf-8?B?RGVySTNDNGU5b09zR0dvZ0crTVpqanpLcUJMeUx6eXhHcnZRTWV5OWVBZ3JL?=
 =?utf-8?B?V0pBK3F1T3RRQmdwdjVJc1VPYnF0Q2EvZExXMzl0cGNucTdIYWVOd0pmNnRT?=
 =?utf-8?B?cGZBemxJLzk5SzdlVnpEQ0J1bmNBNm5SeGpvNVk1dmtCa05ZNGYvbkIvb2pB?=
 =?utf-8?B?S3BJY05LY0F2c3I2Qk1wT3l0bmxuZEZGUzZXbFRoZDdBcm1NcElFTmdqaEVl?=
 =?utf-8?B?b2FtZmJUTGhjZjd1b2o0TDlGL2hBODBNUkR5cmN5dTJHbDlvTVpER1Z5dHJq?=
 =?utf-8?B?WmxxcEpvbmJSeUUzaFMrcVR3WnlpK1ZhYmdnT0dwNVplajJ6VmF0VVFTSUlm?=
 =?utf-8?B?TlZXc3dDdE1TZDUrOCt3cmxDTGtuZmhFQjluN2pzUm8yTHRTdXJkbWsza3A5?=
 =?utf-8?B?em84RFR0eXh0RW1acW9ma05ZdG5BOGNvRGtEVGs3WGZHUXcyRDM0a1FFSXB0?=
 =?utf-8?B?UlUvWTdIbWpDMk14aXhDWTIyM2NyaVdKTzhuUjlRcWJSWGtYTE9VQXdDZS9V?=
 =?utf-8?B?bTlzUkdFQWN4bjhYamdCNm44S1ZLY2JtVTZQNjRmNjkxUy9va1JGa0plSkU5?=
 =?utf-8?B?OG5qN2ZMaktpVFg1MmhlamhOOXF2VlA0bVpXMjgxWkI1QnlsNFo5NmtvaU5q?=
 =?utf-8?B?NWRBLy9OdTQ3aFN4TVVNZzJhWFpLNjdnQjlRcHNIZHkydlkxamJwbWVDZ1RE?=
 =?utf-8?B?cnovUllrUitRdndQTEZCYmoyem5jNHB0ckxLQlZnK0JRNXNycFVyZW5FNjc5?=
 =?utf-8?B?elVGZnlXWWN1Z3BlWnFsc2ZXUitjaHplU2pMRSswZzVjRmdaOG1kekg1TzhS?=
 =?utf-8?B?K0dvbXF3dEQyZzVKNmlGcFV0VHlkZC9tM3N4bzBMK3grMjBPZGUxVmE4OEts?=
 =?utf-8?B?RDhNNzltNC9RQkhMb24vUStWZG1wb1V5VjBoUm9TU25aSWRnN1E2RWpRdnFQ?=
 =?utf-8?B?MTNVaE5EdmFXZ0drN2J5Zm9aV0l2WnBKS3puN1ZzYm04a0FVd040azlXVDdo?=
 =?utf-8?B?YXROVHhrSm1nbGtIRUU5NkpNdmEydllmN1JXMlk0aTZVbXJaeEFuZktnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9ha0FISnMzY3RqMVhHWHp6NDMrSUNOY3o5RmxCazhMOFcwalYzQlVoU1Z1?=
 =?utf-8?B?NklzU0FFYytKaWxxNXgyQUo2a0RGU3d0SDdKMVNTTm9WdzdxSm9rU2cxOTZG?=
 =?utf-8?B?M0g1WDBETGVrTENSUFNuemR3Rmt6dXNmR3N2NkhISElzWjF6MWdMaG5LUFVj?=
 =?utf-8?B?MjYvUDc1bjdpcDMrcWVObFVrMkpUOGNlYS8zTXIwendqRTBDb3M5eGdvcmpH?=
 =?utf-8?B?VklGUW5LOTVpTHZUbitpTUNscmtpRDRZUEdFcUxvc2wzQkExVEE0MUhncldx?=
 =?utf-8?B?Um1iVUJRZ2FVTVI1MmNqVHVCblVjTXAxVFJKczBCVzhyU0FUMGxpZ25TZS9t?=
 =?utf-8?B?YjlKSVR6TGE1TG82M3p5V1puMXVSN2lMdTNZT3hqTVkraHVDY3FEWjFBbFVY?=
 =?utf-8?B?L1RZVjZsVHA1emNQQ3ZQallLdko4eWcyZGFTanFua0RUOFdOUit5eDlwU3Qx?=
 =?utf-8?B?L0ZFRkt5VFIrK25LV3NIQWFsRHYvMy9CZEtnQzl5STUvaDhPbEdtUTFPYTkz?=
 =?utf-8?B?U2tYVEZERzJOR1RhK1V6SDlyMTQwc2dvQkVtUjFyWDM1U0lMK2w2YnpLdnlx?=
 =?utf-8?B?RjViTGJESGpRK0xrdk5VSjg3RGhxV3lrT0NnUXFQZDVXZUpzSkdTZzZjbHJM?=
 =?utf-8?B?cEtLSU83T1NSQzNpbElQSi9xZVZidjdPSXVoNkV3SmhoMnZJQjhyMDNPSUFi?=
 =?utf-8?B?ZVBBWVcrWjY3Z1o0VzR1N1pBN3JqQUxLL2pWMmM4UVdYU2w4SkxNcEZPT0s4?=
 =?utf-8?B?YzFwdnZmMFlPeWRmUWhKQnJ1YmNaMWdxUnd6TW9MT0xpMzhNTlI3VDM0TU8w?=
 =?utf-8?B?eGFrZStsbms5UnhkbG5XUmY4U0JQVUcyd1JSS3FuWU5oQXhOc2hWNmhsa0V2?=
 =?utf-8?B?UUh2bmRpZmMvQ3ZWWUtnTmVPcHdFRHc1d0QxcjF0RFNleFBVSHNKWmpTWFY5?=
 =?utf-8?B?RUNEQ3NoMTFkYitqMVkrZnVKVkdJMm9BMEhPS25Ma3B6aXhDY1BZTHN4WjNx?=
 =?utf-8?B?amY1R1BMRjJjTnJjWU1mSi9pMjJyS2V5S1hZVEwyWUg0MnFpS3hWd2VFTjVs?=
 =?utf-8?B?YzJsQ0Z1OWc0dkdxZmFpMnl6WVNRU2xGeDYzK2ZkamtiaUhFM2ZEdElmSUhp?=
 =?utf-8?B?SXNVaS9ZWWYwRmNXMlUvRTcrSUkzYk1jTjlubm9GTXdqdFlrQmdaRlVIN0Zn?=
 =?utf-8?B?cGFLd0NmWnFVUHVZdVJpei9VVU9Xc1VES09ubS9kOFdYTXJVMDdaaGRlTFQr?=
 =?utf-8?B?RkMrWmZxanJEYVlhak5WVDN0QlJDYlFwRHYzOU1IbGs0TE1UYkFsU1BkMkpU?=
 =?utf-8?B?aURXajVsbHJyZmtSajBPbElJaFFhdlNYSUIwK0FEMFJ6dXpWTklzenpqRUlI?=
 =?utf-8?B?OW8vV0I2VVhxWkdpcFJ0NDFRYjZ0c1UvTlpoR0lDZm13MlFrMk5LdWxmNFBL?=
 =?utf-8?B?clNwUEY1ZWhSWm5jcjdZVyt3UW0xcG1SeWorNWV5RnBJb3pDeUFpMnVQRzdS?=
 =?utf-8?B?amM3NHkxWTQ1dzdlcnErbTVLVGhpSmh4NUNBK0xNUDZLcXJzbHZTYUwxa3VN?=
 =?utf-8?B?Y3dEUWEyS1gvMUplSDZyN25oM2x3WWpuSFl0RFNGKzhuK09mdktGS2xPeWVX?=
 =?utf-8?B?YTVEVnJGSmo3WHJwMGpXS1BWNEx1RlNpK1l0SnM5N2ZJK0tYUFZ2YUFwMWo0?=
 =?utf-8?B?cklac0dyU1FKYWw4M0kwb1NpYlVHbTNYaWZMajB0YkNIekdtVDBXLzM4aExM?=
 =?utf-8?B?eWFKSnoxUnRyMjJJRlNSdlNWTkd6Zm81YkhWelI4Q0dhSFJyYmkvTTdMNnpP?=
 =?utf-8?B?N2toa0hTQzA5eFF6RS9iY1BZaVhhamdQWjE1NW5LWlc3aFVWc2JDbHloTm1y?=
 =?utf-8?B?SENENGREdXBqTVZoMnprWDBVWjlRT1YxVnRXTUtvUjhoQ0FGY3cyOFJ2cVpj?=
 =?utf-8?B?enJqZ3lPYzJYWEQraEd2WmNHNzAzS3JjaE0xNkZOaWFXK0Z2ZTgxeXBiQWlS?=
 =?utf-8?B?M2prNnhIRTFlQjhTOHkrUUdRZTBLYTB6ZUMzZXp4YW1EWHJmZnhrem5jZHNj?=
 =?utf-8?B?NTByQXp3MUEzWnU2SVFHNC8ydWxaUFlRWitsTGw1a2I1NmlnWDRPVDZrd1VO?=
 =?utf-8?B?ckZIM2Z1WU9YYVNiQlQvUkNwQytDMnpVU3hEa3RtWk1jNklrMlZSOXRlVm5O?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 064895ed-26b5-44e5-39ea-08dc663fd10d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 22:25:45.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR8+QpLxvVkBx8O1vu36hWCNvz1ipSDSQN3wSgRlyNJFkUL9Skv2DcynRoYAThaLc/rJKqwI5JLN8UyiOPoSdO4JURjIkNVbfiBIlER4EDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5821
X-OriginatorOrg: intel.com



On 4/26/2024 6:43 AM, Jiri Pirko wrote:
> Fri, Apr 26, 2024 at 02:49:40PM CEST, przemyslaw.kitszel@intel.com wrote:
>> On 4/26/24 13:19, Jiri Pirko wrote:
>>> Wed, Apr 24, 2024 at 06:56:37PM CEST, jacob.e.keller@intel.com wrote:
>>>>
>>>>
>>>> On 4/24/2024 8:07 AM, Jiri Pirko wrote:
>>>>> Wed, Apr 24, 2024 at 12:03:25AM CEST, jacob.e.keller@intel.com wrote:
>>>>>>
>>>>>>
>>>>>> On 4/23/2024 6:14 AM, Jiri Pirko wrote:
>>>>>>> Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>> Sent: Tuesday, April 23, 2024 1:36 PM
>>>>>>>>> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
>>>>>>>>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
>>>>>>>>> Przemyslaw <przemyslaw.kitszel@intel.com>
>>>>>>>>> Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>>>>>>>>>
>>>>>>>>> Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
>>>>>>>>> wrote:
>>>>>>>>>> Include segment/domain number in the device name to distinguish
>>>>>>>>> between
>>>>>>>>>> PCI devices located on different root complexes in multi-segment
>>>>>>>>>> configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
>>>>>>>>>> ptp_<domain>_<bus>_<slot>_clk<clock>
>>>>>>>>>
>>>>>>>>> I don't understand why you need to encode pci properties of a parent device
>>>>>>>>> into the auxiliary bus name. Could you please explain the motivation? Why
>>>>>>>>> you need a bus instance per PF?
>>>>>>>>>
>>>>>>>>> The rest of the auxbus registrators don't do this. Could you please align? Just
>>>>>>>>> have one bus for ice driver and that's it.
>>>>>>>>
>>>>>>>> This patch adds support for multi-segment PCIe configurations.
>>>>>>>> An auxdev is created for each adapter, which has a clock, in the system. There can be
>>>>>>>
>>>>>>> You are trying to change auxiliary bus name.
>>>>>>>
>>>>>>>
>>>>>>>> more than one adapter present, so there exists a possibility of device naming conflict.
>>>>>>>> To avoid it, auxdevs are named according to the PCI geographical addresses of the adapters.
>>>>>>>
>>>>>>> Why? It's the auxdev, the name should not contain anything related to
>>>>>>> PCI, no reason for it. I asked for motivation, you didn't provide any.
>>>>>>>
>>>>>>
>>>>>> We aren't creating one auxbus per PF. We're creating one auxbus per
>>>>>> *clock*. The device has multiple clocks in some configurations.
>>>>>
>>>>> Does not matter. Why you need separate bus for whatever-instance? Why
>>>>> can't you just have one ice-ptp bus and put devices on it?
>>>>>
>>>>>
>>>>
>>>> Because we only want ports on card A to be connected to the card owner
>>>> on card A. We were using auxiliary bus to manage this. If we use a
>>>
>>> You do that by naming auxiliary bus according to the PCI device
>>> created it, which feels obviously wrong.
>>>
>>>
>>>> single bus for ice-ptp, then we still have to implement separation
>>>> between each set of devices on a single card, which doesn't solve the
>>>> problems we had, and at least with the current code using auxiliary bus
>>>> doesn't buy us much if it doesn't solve that problem.
>>>
>>> I don't think that auxiliary bus is the answer for your problem. Please
>>> don't abuse it.
>>>
>>>>
>>>>>>
>>>>>> We need to connect each PF to the same clock controller, because there
>>>>>> is only one clock owner for the device in a multi-port card.
>>>>>
>>>>> Connect how? But putting a PF-device on a per-clock bus? That sounds
>>>>> quite odd. How did you figure out this usage of auxiliary bus?
>>>>>
>>>>>
>>>>
>>>> Yea, its a multi-function board but the functions aren't fully
>>>> independent. Each port has its own PF, but multiple ports can be tied to
>>>> the same clock. We have similar problems with a variety of HW aspects.
>>>> I've been told that the design is simpler for other operating systems,
>>>> (something about the way the subsystems work so that they expect ports
>>>> to be tied to functions). But its definitely frustrating from Linux
>>>> perspective where a single driver instance for the device would be a lot
>>>> easier to manage.
>>>
>>> You can always do it by internal accounting in ice, merge multiple PF
>>> pci devices into one internal instance. Or checkout
>>> drivers/base/component.c, perhaps it could be extended for your usecase.
>>>
>>>
>>>>
>>>>>>
>>>>>>> Again, could you please avoid creating auxiliary bus per-PF and just
>>>>>>> have one auxiliary but per-ice-driver?
>>>>>>>
>>>>>>
>>>>>> We can't have one per-ice driver, because we don't want to connect ports
>>>>> >from a different device to the same clock. If you have two ice devices
>>>>>> plugged in, the ports on each device are separate from each other.
>>>>>>
>>>>>> The goal here is to connect the clock ports to the clock owner.
>>>>>>
>>>>>> Worse, as described here, we do have some devices which combine multiple
>>>>>> adapters together and tie their clocks together via HW signaling. In
>>>>>> those cases the clocks *do* need to communicate across the device, but
>>>>>> only to other ports on the same physical device, not to ports on a
>>>>>> different device.
>>>>>>
>>>>>> Perhaps auxbus is the wrong approach here? but how else can we connect
>>>>>
>>>>> Yeah, feels quite wrong.
>>>>>
>>>>>
>>>>>> these ports without over-connecting to other ports? We could write
>>>>>> bespoke code which finds these devices, but that felt like it was risky
>>>>>> and convoluted.
>>>>>
>>>>> Sounds you need something you have for DPLL subsystem. Feels to me that
>>>>> your hw design is quite disconnected from the Linux device model :/
>>>>>
>>>>
>>>> I'm not 100% sure how DPLL handles this. I'll have to investigate.
>>>
>>> DPLL leaves the merging on DPLL level. The ice driver just register
>>> entities multiple times. It is specifically designed to fit ice needs.
>>>
>>>
>>>>
>>>> One thing I've considered a lot in the past (such as back when I was
>>>> working on devlink flash update) was to somehow have a sort of extra
>>>> layer where we could register with PCI subsystem some sort of "whole
>>>> device" driver, that would get registered first and could connect to the
>>>> rest of the function driver instances as they load. But this seems like
>>>> it would need a lot of work in the PCI layer, and apparently hasn't been
>>>> an issue for other devices? though ice is far from unique at least for
>>>> Intel NICs. Its just that the devices got significantly more complex and
>>>> functions more interdependent with this generation, and the issues with
>>>> global bits were solved in other ways: often via hiding them with
>>>> firmware >:(
>>>
>>> I think that others could benefit from such "merged device" as well. I
>>> think it is about the time to introduce it.
>>
>> so far I see that we want to merge based on different bits, but let's
>> see what will come from exploratory work that Sergey is doing right now.
>>
>> and anything that is not a device/driver feels much more lightweight to
>> operate with (think &ice_adapter, but extended with more fields).
>> Could you elaborate more on what you have in mind? (Or what you could
>> imagine reusing).
> 
> Nothing concrete really. See below.
> 
>>
>> offtop:
>> It will be a good hook to put resources that are shared across ports
>> under it in devlink resources, so making this "merged device" an entity
>> would enable higher layer over what we have with devlink xxx $pf.
> 
> Yes. That would be great. I think we need a "device" in a sense of
> struct device instance. Then you can properly model the relationships in
> sysfs, you can have devlink for that, etc.
> 
> drivers/base/component.c does merging of multiple devices, but it does
> not create a "merged device", this is missing there. So we have 2
> options:
> 
> 1) extend drivers/base/component.c to allow to create a merged device
>    entity
> 2) implement merged device infrastructure separatelly.
> 
> IDK. I believe we need to rope more people in.
> 
> 

drivers/base/component.c looks pretty close to what we want. Each PF
would register as a component, and then a driver would register as the
component master. It does lack a struct device, so might be challenging
to use with devlink unless we just opted to pick a device from the
components as the main device?

extending components to have a device could be interesting, though
perhaps its not exactly the best place. It seems like components are
about combining a lot of small devices that ultimately combine into one
functionality at a logical level.

That is pretty close to what we want here: one entity to control global
portions of an otherwise multi-function card.

Extending it to include a struct device could work but I'm not 100% sure
how that fits into the component system.

We could try extending PCI subsystem to do something similar to
components which is vaguely what I described a couple replies ago.

ice_adapter is basically doing this but more bespoke and custom, and
still lacks the extra struct device.

