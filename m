Return-Path: <netdev+bounces-215715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4BB2FFA7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56C916A6B7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9027AC37;
	Thu, 21 Aug 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwJdbpoX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F227BF7C
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792105; cv=fail; b=EhcFNxy3TBe2kDR5AAbjDfnqqIUjWjgbNbpghq2mDJF0Z6/C6RulgBx1yiSlJC48ANQ3XY/IOP9ha0wR1VHdnP+idtCFS03vX4+qHOHKgN1bwHc8CyyjNE2cBlsIAYFk9ca3LbbaLQ7aJ8VxSvj2aq1p29TTVMK1lO1rkagcceY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792105; c=relaxed/simple;
	bh=oFC3U4ZmKRlRKvdIxcmMo9nBXRN6AtarOjFU6iv2WdU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSj6uHj4WNC/zAPj/rjJEZQ3Ma+poASigDUHRtAJfx0bjhYquMRal9xpiAnMRh+AlK1x02Hqax8uOJNVH+V7H4KV6zGM1WcJlmhUp4mhgl6wy0TdoWtAV8F7fmUfZExmkXAc2UDUM3ksX0Dn/mITEY3wvG/wKTfDxPuuASU7BgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwJdbpoX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755792104; x=1787328104;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oFC3U4ZmKRlRKvdIxcmMo9nBXRN6AtarOjFU6iv2WdU=;
  b=EwJdbpoXb9dBDQQV4fsDGOybaXILtdBA5tJQWuaIncLxMEeDBM2Ol9E/
   Z0Tla7MiNZHJhTzNMNRrGKJcO4rd6TGOQZAjde83YE0X8CTPhj0BVj696
   YnHEwhT0BOBf0yGwV5IIKqAPTeMew/xqLr85Wuq/HUcUgyPB75KxA+s9o
   FexZBsFSi/I9JHFHRDtTo4IeZJtJuqNYEX4clUP5H6e5bp2BeZzHE7xtx
   RqUc0jbW0tEaGHE4NDXmAmGB/erveQOh2S/ovEEx7MzPUEc5Libl7PXmS
   bRHZgoqlXOYAKTJgiZSuD5/+Yv2fZhIOfX93kGZVrBepJiwapnN/1VVp1
   Q==;
X-CSE-ConnectionGUID: VpYGctf/Tc6Ahn5xGqZfSQ==
X-CSE-MsgGUID: 5oXdB4UYQUGVWbu5IRgsQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68687904"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68687904"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:01:42 -0700
X-CSE-ConnectionGUID: 5rfsJXJqS/euNks8D7vSSA==
X-CSE-MsgGUID: yb6BW5fZQPyyVJ8RX2Evbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173782609"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:01:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:01:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 09:01:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.41)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 09:01:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7zuxVY5uHpyFVVPOr0VD4zRZ65ib011m5103QEa9ejiaO0ql+/ZOLiNjQBXfuRcH095mvg7GgOGiW/VXSKDnluPt96HWNSGcAhFfvqDGlSD+fLGSSoyGrliijHRCTD0Gok9dpJ/nVkE5Bqdk7ek0Se/4fQxg55fVnePmVyIcVr3DGTR6B4MIlv5L1SIxo8zywyeAmP0UmmZqPElM+UntczOGbYyhr96UvQofM1n5kv9rBm0DcqVleRtz0QwhG5BWV5Swth8ktUOuVTKwCNFmHkCQSmU2LrkFJmG+R0/9xWjr/7klEmMt88SUO1HagmbPwT95ANW/24kLaojHEp2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rQeymO9wrt4VG+toKyc+y4OX16XOYIFtLuBvQCuIZQ=;
 b=KwbcbxMbIFKXS+UuUtSa7EClC4dx0eip4eo36U5TQsdz00Ar1nUc1Bwm20pT+L9yl6dq+Qo2oSR54xFaeU7gw1T2ATiIfM23tLNcsWSXVhns15e/JDKxxd+jxXrj8Qpns1UeJUj/r6mbgJrlvdCD3sFNf2DKaC+rsWh9B3ZUJVhx4uYzp7a+5bbd0lF4xDWoNZmA3fXXHALZRsoz5yGwqrFEKvw3UKR1Bddv3B0ANxrCbuR5UPASNTHQp7/utNZSG2ZCLTIV5t2NS4BM1UbZ1ZZZJz1/SqkoMtq2Nn97TM86j93y7J9/C+F+oK3cihdiZFOzlsqAbPW/FHLrhTq2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 16:01:34 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%5]) with mapi id 15.20.9009.013; Thu, 21 Aug 2025
 16:01:34 +0000
Message-ID: <615ba9fd-cc3f-45b9-9310-c01a4c0f3b55@intel.com>
Date: Thu, 21 Aug 2025 09:01:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-15 (ice, ixgbe, igc)
To: Jakub Kicinski <kuba@kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
 <20250820184550.48d126b8@kernel.org>
 <60e5f92f-009a-4ce7-a489-224e54342542@intel.com>
 <20250821072231.5b4ade31@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20250821072231.5b4ade31@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cfdf77-f1f0-4d21-da57-08dde0cc00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlRHdFB0YStZSzRTYWZ0T3hIOVhwZlBnNElROG1vaVNTRjFIMUdmdU9IWnFZ?=
 =?utf-8?B?VSswY2N2cGxubUpiZjBxc25uMnliK1Y3ajNzRWZlM25KWXBDUkwzUUpUMXA5?=
 =?utf-8?B?bDE5RjhTdy96ZElCeTU1eFlVZFVPbzNsd3ZabnJ1MDExblNZKzlrTWxJL2lQ?=
 =?utf-8?B?WncvOXB5TWQxSjZhRDlocjR1c0xRVmwrYlNaR01XVG1TRWJFa0JHZGFOTGtJ?=
 =?utf-8?B?UEF6K0lvWHdTbk4yWW8wWFl6dkllWkhYdTBpQU9ORGR6cHJXME1ManNyeWl6?=
 =?utf-8?B?d1lkL0FaQllsQUlkRlRTK2owcVluTllNbTRtd1BwSmZvc3EzR3JodWJKb0NL?=
 =?utf-8?B?TWI4enJ2Wk1yODJMcDBKSFJONjFVU1c1VlI0MUlqME1kTXBQT1VhUmdTRHg1?=
 =?utf-8?B?dndVZlBTM0lqaFJrbFFwNXdZQWMweTdRenZ0dVhiY0g0K1FubDZKWW4vdGU2?=
 =?utf-8?B?Nml3Q1p6SGJjaGJ4cDhnWHVNOFRKeFp6YkJ5VFBOUndMeVFvZS92Unp2cmRX?=
 =?utf-8?B?b0IvOEpoaXNxV1RMTVY1TmlHdDVycER0eVR0UExKVGlzb2tvR3RRc2xQODYz?=
 =?utf-8?B?S3piWWZUaGFacDNPb3ZOcm9BcEx1aUh4bnM2aWdnYmRpZlBYenlkeVprUHBL?=
 =?utf-8?B?UzJXZHJIQ0xuQjM1ZW5lSlBCQWwrY0Vkamt3NGpyNDJqeVg0cFhWbzdtNFZX?=
 =?utf-8?B?MHlOM1IxRTdZWDlyUUJWaWtuZjh4bk4wTUxXb1BvSDB4ekFPeXpJeExhZFhs?=
 =?utf-8?B?RVBmSlAzdXdydFJYYVZORlNPTXQ1UW5IaFRNRkhoZWNQWGtKY2kwbEdxYTc1?=
 =?utf-8?B?UjAxSW9YQThEcHlZdlg2Tlk3NEFYemU3ZlZJaUhFMUp2VXNZQTd6SThyWTVS?=
 =?utf-8?B?QXBVN0V6L09CSFoyVm56bGVwdzFZSEJSZnRzdm83OFp1c0JpdmZPYVZCUnV1?=
 =?utf-8?B?dXRCUFN0VGo0SFY1dHE1OE0rajY1MWZYYnBKZ0ZNOE0vZ2lvdFkzWWFJT3Jx?=
 =?utf-8?B?SkJFbHZKdFl2NFdLdEw0OUhIRlZwbFFxNTNEMUMrSXFVeXpEcGVaYmR2Z216?=
 =?utf-8?B?dXZ2OE5IQzhycGpLd1Rnb0V1aWJjZzh3UmxLS0wzU0xBQk01dTcrY1JRTHRC?=
 =?utf-8?B?RG02VmM1Z0R5eEEzZWNZL3dxenY3MzE4NmVyOEpFRmQxRlNXS01IRkVEVUFT?=
 =?utf-8?B?a3M2MzMzZHNVWlkxRS91dUxWRFg4d2ZFcnV5T0ROZGNUby9zSG5EeG9ZeSt2?=
 =?utf-8?B?dHZidmV1M2I2ZEZ5WE02NEErVUoxQndRTmJuamxjOEI5Z2M5dkwwbXZ6b1ln?=
 =?utf-8?B?WndmUE8zdjJyZlpTU2JMTVV1c2RGMGgxT0NsLzhzeVVXcUp3VGF1ZFRYY04y?=
 =?utf-8?B?Ujl6dWJHeFRVNTRCRUY0ekFUbnRIVkJETGV3MG9pZjliWGNxTlZBZlJmaUdq?=
 =?utf-8?B?QWExQWQxcTBrcGxxUDBQTG9sbWxIcDFXdFdMdFg2REU0NEwyanY0UGJNT1Aw?=
 =?utf-8?B?c092VmhNVitXRTJGWG91NzRIUHdBcjBNV1NEVUxZSVd6ZXp4Q25YRmRaV0dr?=
 =?utf-8?B?dWZWc1NrQXRRaWl3VWV6SXpyenB4TGZ1UzZxUFVJQlNOMlgvcG81elA0eElU?=
 =?utf-8?B?L2R5R2pzbzN1OURQb3VFT2U1N1VCMUpjcFRXZmxrdzlTdVpqK3MzMnkrUFht?=
 =?utf-8?B?anJOaFZCb1lCNllDSm0zQnI4ZHowQ3Z2Y095THQrdXhqR2FGeDRJN3gzSlFq?=
 =?utf-8?B?N3lrWnFvd3NTR3hUNDVSVG9nNml4NVZpdE53WmI3ZHppRVVORWlRaXAwdFFm?=
 =?utf-8?B?OGhobXRGaWsyYmUyOUpEZUdWZWJjWUdFVi9ZUE8yTnMveHhodTB2REpyZ3lO?=
 =?utf-8?B?WVZRbkY4VlNUS1dwbklpb2hDTUE2QzlwYWhuWlhnaE5oUVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K08wQndOcmlidG41OGY2LzRFQUp4UmZQbEdUWUJsR25pdDRGTXRmTXQ2NkM5?=
 =?utf-8?B?blBKUnJ0TVlPNjFvdld1b050aUtVRklzVXNnTHpydnpqVERzNHZSbkdVVXh4?=
 =?utf-8?B?eWpoeVBaeExjWktGM2Q1MktCMTV3SzRCNEU2ODU4eDZ2ZlZaTGNqT1JRTWg4?=
 =?utf-8?B?VkU0VzJWcURHUTFaRmlXMWEzY1V2cG4zV0Uwd0N2ZTZCU09PSjAramlycE9R?=
 =?utf-8?B?MTRnQXlCNXY4aUU2SUs3QUN1QlFEa3lvK0JDY3ZQcVNaZTQwYzRtUTcyTFVE?=
 =?utf-8?B?WVdLYTk3SW5VdkdtcEs1WS9PQTF5VDBlN0pjU0pMZU9uenZsSnBXQ3ErU29J?=
 =?utf-8?B?QjdEZkdGY2s4ZkxMcE5qV2orRHZHRDFiK25XL1JsOHc3ZUpDWUtPN2RzU3Jo?=
 =?utf-8?B?N2d6Q2xEV3RvRWhTd1dpM21VLy9FbXYwUEJoa2NsTXVlM0hHYXNPNDcvZy9y?=
 =?utf-8?B?RFQ3L3l5Q2ZRQWJWWDJFdStuS1B4VjJKQnlBWGVCZnRMQXh2WndwTkc0bzBT?=
 =?utf-8?B?bm40TUZibVN3anNFNDY4cDZ2VTRROU1RL2hLZFI0L2QyTDhWRzNSaExJMkg5?=
 =?utf-8?B?MFczUEhVaEtvcDhHcy9uUFpnL0pKSXhhY2p4bTVNYkNSN3BNdjlSNmoyc29x?=
 =?utf-8?B?cWM3U1lJZHY2S3FMRy9FbEh2ZVMra2tmZmJkZW1vTy9DNDlscjFkSVRJWG9D?=
 =?utf-8?B?NkQrVzhJVFg2QUNtcXg5VnNMcmk0bkt2UHZ2N0x2RXRCRzA1SDByaFgwa3cy?=
 =?utf-8?B?c2wwc3k0ZXdRUWxMMHBuYjRvOVQrejduRFdON1c2Q1RNV1lpNmFRTzNkbnVD?=
 =?utf-8?B?NGZ2MTZQUWMwcnl3QURLdHplMEdlaTR0QzdoelUvN2d6aE5YNFVUeDJmcDRY?=
 =?utf-8?B?d1dCNDhMQVgrd2lNNldMM2JqTFYzRzJlSnhCTFhUUUZYNEhwanpYU0RxMWEv?=
 =?utf-8?B?NnBjVkZGR3k2VkMyKzZNUUw0MWgwUnE3L2dqeVBXRjd6ZU9zUFZHdEpmNUpD?=
 =?utf-8?B?L2RNWEFtZ3JESWR5V25Mc1pHMFV3MTlMOUNUeStVL0NQa21uYnRpVHJEZHIx?=
 =?utf-8?B?RU0vN01FR241UXduMnhzU1JZOXZiYXRwbEt3RjZuMG9teGJMdmFmZjBlYzE5?=
 =?utf-8?B?MUdGc0tsTEMyYjBBRGRjQXBEQjN5Ly9lN3pIR0xKVHFuSTA2eVVSYnFOZUtu?=
 =?utf-8?B?SS9EWWlUbWFiVHBJcW9UZzNNcllJUDYwQlR3Rk05N2pETzJNMGtkemh0TEFE?=
 =?utf-8?B?cWd5bzZZSmhrYUs3SEVIaEVweTlESEQ1THlDQ0t2Ri8vOWRuV1RmYTFMa21U?=
 =?utf-8?B?dlFyQm1PcHNWTlJQNFhsem9qUW9SMUI5QzZJVDQvRUZPeUNOaHNBOTdudU1q?=
 =?utf-8?B?QlZJUWVtYUxvSklLMTh3VEFVc0tES2VYcVJlTHZwZVRpZ2FVa0dRYi9JdXhS?=
 =?utf-8?B?c2xZVzB1bUVNRmRqQUU1ai9XRUlESU5qMEM4TXVlQXRTUmtlcGVtOGg4a1NJ?=
 =?utf-8?B?RGZpTVZNTFhpb0xCdnlReS9DeERjVHljRkRlN1hzYkFWVXVLZ05XMlk0Qkx0?=
 =?utf-8?B?cHBUS1pIM25aWGExd2w0WDFVNmZSUVMvYmpaa3ljZWc0ZVA2MVNIeEJnL042?=
 =?utf-8?B?emJvdWVtY0Q4Z2JqZ0dneFMvWGQrWUszbkNMSFBlUkMyTW9Dd2Vid2t1TEs4?=
 =?utf-8?B?M0NMMDVpdlFlRnpQT2VEOHp2OFpvdURVRDlHWEc3RitvdXNqalArak8yS0kw?=
 =?utf-8?B?R0tpZFMrenNtTHpuVUJ2dVlWaGZRRFB4WE0rS29iZUR6YTNKVHcxSUk3d2Q1?=
 =?utf-8?B?MzhkSEtJL3JqZy9rV1l4d2crajJHaUxBYjBwWHE4NVFyN3UzNnRFbWtmbE5X?=
 =?utf-8?B?QURyWTcvWUtiYlRZWERnT0JPOHNWZVNzSHNIdHgwSmlteDN0Ni9iK1RPTTRw?=
 =?utf-8?B?ZGt2WEdCdHNUOGZXaHNkNUo1ODFDRDhObW9jY3haSUFuY045eWN2Sk1zcmx5?=
 =?utf-8?B?TkxwczM3U2R1Smlwa0JJQi9ScDE0YmY5ZEdZeGRrQWd3R1V2UFR0ZWhEODhz?=
 =?utf-8?B?WG1ObUx3eWZFZWsvMjBzTTI2R0xibXNTSkZVU1hUUzZXNGkrRGRaU0JrUG53?=
 =?utf-8?B?L1d1UTc4NWFQTTVDUXg2MGpaWVlLbWs4YzNjWFN4ejBoZGpic0VjVGhEaXU3?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cfdf77-f1f0-4d21-da57-08dde0cc00a2
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:01:34.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giZyKbQnL/pLEoOF5t4139cMIBqXtLPiTJmTZEHkIqCvhQVaeA9r0jVYi4xNADjUzbwTK7MUmOq66q/JfNX93OpiZDWGPbn56KRosLgDmjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com



On 8/21/2025 7:22 AM, Jakub Kicinski wrote:
> On Thu, 21 Aug 2025 10:31:59 +0200 Przemek Kitszel wrote:
>> On 8/21/25 03:45, Jakub Kicinski wrote:
>>> On Tue, 19 Aug 2025 15:19:54 -0700 Tony Nguyen wrote:
>>>> For ice:
>>>> Emil adds a check to ensure auxiliary device was created before
>>>> tear down to prevent NULL a pointer dereference and adds an unroll error
>>>> path on auxiliary device creation to stop a possible memory leak.
>>>
>>> I'll apply the non-ice patches from the list, hope that's okay.
>>
>> the first ice one fixes real problem, reproducible by various reset
>> scenarios
> 
> Ack, just felt cleaner cutting the PR up by driver ;)

I'll include it in the next misc net send.

Thanks,
Tony

