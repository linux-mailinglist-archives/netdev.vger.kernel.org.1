Return-Path: <netdev+bounces-96791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB88C7D14
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2680DB25F2E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 19:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20333156F4C;
	Thu, 16 May 2024 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1VuAmx3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984B156F37
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886674; cv=fail; b=lgK+JweBuqPjk6ZlxuXFPFlzvHV5VUzOXUQIUvaYS6ejZ/nE3I8j7zcrXo7zhwpktCbE5LL1P/ZCEXwgdd5x0wvUWn+8NevgTKaUPI4R1mysuUzSUh+FTvxvSsKsH/coqFJH7AIawUjmakEErrzpanz42TqII7X206rBNsg+2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886674; c=relaxed/simple;
	bh=8M1vFFuy9ysRfvd7n9pWAdsIpmxpujts+uiEc2pA/sw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBRFPq50sOI5fkMrKLyNK/vhSRfLmdifwyKrggKzt+xv5MkDkO2Tn1RNfK7ADWC30JmjlXFZ4N/E1CY7n1bt8RF+ItrHFDsiCTYVGc5GA+Z95ef1ny9v2fqHFITnymOVGPIj+efi/VTNepFrGgCTKXCXvVd0YhcQcT5GAzgt8Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1VuAmx3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715886672; x=1747422672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8M1vFFuy9ysRfvd7n9pWAdsIpmxpujts+uiEc2pA/sw=;
  b=U1VuAmx3guCwkZMM2skD8zw9pFQR7xLx4r7p3jKKhO1yJO58TULTPePz
   tzugC8r0YrGL4VAa3LD0cVk72Z19D5XpLMkusIvxjg1/0NGmLPpt8Cz7q
   1XUHBubXs+/T/mLY/HbWInRmoQ+Pu4H3bIhaQiCpxO8Mrorg968s5U88H
   Rq+d+2MBmrr+zaw8ChtvpdhsqYCtk+KNHvCNSzPEqxeqlBRGV6O94uygv
   F98PbuXuHheMAm59tZOQbPkZ7dDuoM1i0zBk/Rpe/TQfGlxmO6ETv5ke5
   K5kEM55dWvu0x6shQD3JHfHIr0Pqjcn7cO4hyqAPYNqFpvZyIIbEe0ciO
   A==;
X-CSE-ConnectionGUID: xmfEbXO1Rj22rrOTBda+YA==
X-CSE-MsgGUID: rn380SzcRQ+XbDJvL7nFcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11870479"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11870479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:11:11 -0700
X-CSE-ConnectionGUID: xOaCjh10SxaCoUbv1tSyqw==
X-CSE-MsgGUID: SxecMaErRHq3T2hBGyWhTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31541479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 12:11:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 12:11:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 12:11:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 12:11:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 12:11:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/RnVXjESq1Jq+hUfwSqzUgBcxXLALD3KTYNPKDCgozpTOmxtTgXb8wUf8jbpU5EX6vyxo4K5kEthZFd4MQKwj26kUa4fX2CeuaZpwkOydD7ZY5zRtcNiCOKzsx+pZvPr50zBR4EQglWl7lIezo93BsgottSSY03t499y7e+NWwvP5L8pYneWmFxoXe0SsLDXyhmBakN3DmLlHNS8Utj7Tslwxmfq8dCVggNVWGANGxP+URMUy7Pv+6XisCAnCiI7LhP+NELfUbvSgswQWhGzKELTr+2kzzYR9WWrQGHoyb5J639wsOWx0T62Q2JurwEqocvb+BTPrlmP9+SaVM0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHpA0V1pUAurKdftJenAjIl4fkTz+7ValT/tUfViBvk=;
 b=DCi/bcraKHTqGLBE3c65roa9IOjxmpNkFMocnutoru5SrRNU8astxsEYvUDvHC9WeRpUiHsu3mywGDDPJwDtdHFUhM00eX1oVciYwORXMu8Z5WYehkoRoem53Wn5hBOzC5IkaJliLWyOJlaXVVYIOuh2zEK3lt21IaUFj1gcwTvY4r9C2fO3S1QZQtBLWuTcR2f4Gm4EswOJE002ATv4tU+e+0XP/zIyV0fLlm1QTaNMZ267BcuMnP0np6Pv9jGz31lQ56Q6dlud4kNqMkLf+BrrQuVUHdzrOSZ4AlOZQSL2YovyZDMnNg5H+2ahdyvdrGd/RUCp8+oS+e7vITr9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:11:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 19:11:06 +0000
Message-ID: <9fcff111-bec5-4623-bc22-cb4792aba55e@intel.com>
Date: Thu, 16 May 2024 12:11:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net V4, 1/2] i40e: factoring out
 i40e_suspend/i40e_resume
To: Thinh Tran <thinhtr@linux.ibm.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<aleksandr.loktionov@intel.com>, <przemyslaw.kitszel@intel.com>,
	<pmenzel@molgen.mpg.de>
CC: <edumazet@google.com>, <rob.thomas@ibm.com>,
	<intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-2-thinhtr@linux.ibm.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240515210705.620-2-thinhtr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4300b0-8a10-4143-f6b6-08dc75dbf013
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RndleEJ1dExiM1Y5cXYxSnNSM2FVcjR0NE1ZM3BsbGdZVm1DUDAzd1BJN1Mw?=
 =?utf-8?B?Z3EyanZsWlFXMmtBQ3YrSFdnYUExT1Y3Rld5ZXNOU21VRnMzMUZPMU5aYU5S?=
 =?utf-8?B?YUZydlIwSzJaeittVFZwa3J5bkZmQVBDWmFoVzdxSnRtQ3dzWm1uRUJxVTE5?=
 =?utf-8?B?dzZuL2lCS0lVMVNOVFJjNHkxMjNJdGk5NVZXeWhOM3FMUW4vUG5KN1o4WVVK?=
 =?utf-8?B?ZzVrVlkwT2RFU0pBNS9SL2ZNUExwdHUyQVc3Znd6UDJ6aWRsdGR0TC9NSVFp?=
 =?utf-8?B?aTBLTjZodmcvQ2cramlvMHVISDFGRXZ6TURPZFZrTEc0UVFNQXdhRWNTT1dK?=
 =?utf-8?B?Q0JmZ0hkN1FpQWtISGxIWnpGMDBRbE8vaHVRSGFxOXR0TDNleWcyQS9RT0FQ?=
 =?utf-8?B?bC9BaWNXeVVNRXFacVFJc1VQeG9Yem5sRUd0S3ErTGM4Ykp4RkI4eVFSOHlt?=
 =?utf-8?B?Tk1zZXVGUnUybUIyTzltZWlSV1FIcjdwUzAya2QwaEZhY3A5bEwxNHF2a2Vh?=
 =?utf-8?B?U2FGNWs3VGlza1EyYnA3cnE2RkZtRjBSbmF4Y1g5Q2hhVDRnN1p0ci93Y3pH?=
 =?utf-8?B?SEJGMHRGRkwzdXh3NkVublBKNVZQalQ0ZlZwRndnR01zNkpta3U5QWlEbVZP?=
 =?utf-8?B?TG9udHByQ3hBRUlwcUJmQ3BBWFRqSXh0Z0o2SDFDR3lzQ2F0T3I1Ynd6cVRr?=
 =?utf-8?B?RGUvOE5JcjJsdFVBRjVnOVlQdlNnRXliUGpPcnNlKzBpeVIySDgyM3VaUEdk?=
 =?utf-8?B?VnhvU3N4QjRGQlp6STRUWnlzWFY1ZFRkZW5uMVVxeGdsakZFcS9ZWTdFZHF5?=
 =?utf-8?B?ZHlKeC9idTNHVmxkRTBDNTkvL2w3b0t3REs0eDFKTGFmWXR4UFRHREJZNWI0?=
 =?utf-8?B?N1NCSFBQRnJ4dkgyRjRBZ0dOL2tZeVo0VDd4WjhPNWo3RWpPSzdqV1V1TzV6?=
 =?utf-8?B?TGdBNTJ4OWgrTlNsMTFTR3JkOFB0Kzc2enEvSVYxS3pEcitKY2llUEVzYitp?=
 =?utf-8?B?RTdOOTd0N25kWlFsNlFjK2FodDAvZDVRK3gwV2dvSnZGcEVKc3AvSm9FMkU0?=
 =?utf-8?B?QXViL0xOS0h2cENhSXMvdEdNckpQcERrcm1hU3VlbXB6YVp3T1IxQnIxcXhp?=
 =?utf-8?B?UkVndnlHdTJ5Y0FsODZoM3lHMDBQaEJZbzN3NmIweHVUNytZRXd0MVdMRWUw?=
 =?utf-8?B?aVZOVVVZLzEveDFsN3lVS1I1cXUzM2tnSW5oaDhDc0NYaXhBVGpybW94YnRP?=
 =?utf-8?B?NWxOR0RVQlNhVkEwTGV0NER4c3hVV2dBNmtPOXU5MGNyQjVDMmFkdjlSV0hU?=
 =?utf-8?B?c1ozQnlwQzJWcG5GTU1vUERNVEFRb3V2ekJ3TlNpcCtHN1Z5SjNkRHRUNHYz?=
 =?utf-8?B?OFJsK1JpZVVSczBrbUJsNlFtblE4STJQWHBkd2Vqai9LMVplZEl1bmFPZVFm?=
 =?utf-8?B?TUdnQXRpR2trTHJadU83QTNxTll5QTFJYVJOdGw2RmI3UngwVGpYNTRhT3FZ?=
 =?utf-8?B?eThEMHRJMHBFTjl3U1pBR25NWDVPRU1LTUxFcElwNld4NGcraE5JMHFMdW1K?=
 =?utf-8?B?d0FoejByeXBNSWxsZjA5R1VkNzJRYmNnUVRBbFhFRmxUS3VFcWJJUWdmSmVZ?=
 =?utf-8?B?RVE0UVo3SlJnS1BjVXJUTmV1YWxvRXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFDdi9HSStDNnBrbkYzdDlDR0wramtVNzJOYzJCTmpzV0tackFKU25Oc0cv?=
 =?utf-8?B?WDZybzFjSmowd0FYOTdYQmU3d3ErRmM3NWI1RlJIODNnQ3lmOW1xbmhPdlRj?=
 =?utf-8?B?ZzQ1L1hkeWpEV2hJdHdyeUV4bEpQOGVIajM3Y0cvWGJNYkh5d053Tnpvc3lK?=
 =?utf-8?B?MlQ1Y2djeisrZUpkUjRqY09nYjFpTXBIUSt3bVlVYUltTUtsQlpzM2ttaXJ0?=
 =?utf-8?B?b3R6c0dVNWN4ekFETVpNQnY1WG13c0NyQlhocEtKaDNWSTFRZ3VzN3B6VXZU?=
 =?utf-8?B?S3dwK2pUcjc3YjRwdVdZV2FNa0pCU3dUcjFwQ1dHRldZdk5PbDk2bzVQTVVj?=
 =?utf-8?B?bXNFM3lSOHBFcERFMU56eEVVR1dXS1NKdEhXd3BsWk80eklzeFFRY3ZkWTlm?=
 =?utf-8?B?cG10MzhsWXFVQ05waGI1bUd1K0k1Zk9qUlhWdVhKUjB4cHlZK2M4THlSVVBl?=
 =?utf-8?B?UmI1NTRLNmhJSXI4cEJDRTB6cWQ1QkRyRzJzNm1qcDd0REdGQk9TNlVqUnVq?=
 =?utf-8?B?UWZLRTNFdEQyME4zRHVMa2F2L1hCbU45UjEyQ0RweG9aTVMxN29nZDRkZmNQ?=
 =?utf-8?B?c2ZlNEg4T24wQ2pWR0w2M3dVM2d0R1RqYndVNTN0NTJ6L3F1S3NQRklYdW44?=
 =?utf-8?B?SGF1dFRXc0h6UHpMOHZwMXJkUFFreE95TkFPMmh2QUN0U0pWOWJVVy9IeThY?=
 =?utf-8?B?VEIrbGVoSm90NFgzZUh4TSsyUDN1NW1mNDhTOW1PcEdVS1g1dnM0VWJnU2xX?=
 =?utf-8?B?eTJKWUxjN2diWCttYy9zaU1QNm5nanlNWGtXNmlZVUVHdHE1VFpTNTY4VGFN?=
 =?utf-8?B?aTAvSzhobEV6OGhTWUtDYXQ2bTFNM28wTEs4eWxJZUNpTFgxSzREdHdDOElk?=
 =?utf-8?B?bGVZcmc3bXRCUVp6QzJIWnlxNzE5ODF3bW1GdU9SNlhMMlAzWWU3NW51bmFp?=
 =?utf-8?B?WHNkSXd1Qmo2YzgrdEV1ckxOdnNQbjQ0SjlQREQwK2xaY3liUFBLY3RkMUVr?=
 =?utf-8?B?cXUzeXJGRXVtcmRaK3VmMWlGZGhJbzIvcFF1SGR2V3VERmZsZndRUjAwdjFY?=
 =?utf-8?B?N2JVZnNJSFh2OWhlQnJiNVF3di9Jb3RZeWxTR3U5Z0lCN2dleFhKbXREK2hS?=
 =?utf-8?B?N0syV2RHNG9QNVJwRy9lcmEvNk1SYkNVR2JyWVZ4U3BTOUg4UE9oR0RsOXlZ?=
 =?utf-8?B?RTEwUVAxOUN0OTFMQ3NJSkhVUjZpUTRqTTdyZjR5YWoxZmhKZ3JnTFN0azN0?=
 =?utf-8?B?OE1ETEpGN1dQVy9yNExubWdUYUZjMnhrMWc1OVBoeTdGZXlpeUNzOFNmU21u?=
 =?utf-8?B?TFZpRnArajhUVXpLemV4WlREUS9VMEFuNHgxTkltQkpRTUI5V2tXSkxpMXNP?=
 =?utf-8?B?ZGIwVWlMaWE4VFJ6ZmhNT21jelk0K0dWMUs4YmxTN1BEUnpHaUVNdGZqNEU4?=
 =?utf-8?B?Zm5aTDhGc3ZDeVVKVmxucWxnTjhSZGgwVmVJaEt6VDJvN2FMdkY3VkxqMDZU?=
 =?utf-8?B?OVBFWEJkSWZjMUVrdlVDR3lIZVBLOXNGSzIyU2hSdk94cnpZTFQySUV2YkIv?=
 =?utf-8?B?d2w4V0F3b1dITTlGQnZzSDQ0eHVabzhSa2RDUHk0YndrYk4xRWZmRGFFRlhW?=
 =?utf-8?B?c0NqdHNJUlhJZVJ3RUVHMS82SUNkSWZoMXc3OTl6MTZMRGQwSzMxWGFwZ2VU?=
 =?utf-8?B?Q1lRNTErQTBzeWdmam1qZkpETFNKQ0hsZkcxbWVyN3EvZDc4Y2RtV2E5R2gy?=
 =?utf-8?B?R01JWXlTZ0J5SzhKazUwZ1cyS1ZXRk44TFdXbHUvY044enk5MUFVVG5FNmhD?=
 =?utf-8?B?MnpvczJmYU05RElveEF5MWNEY1FjTlBQK3ZoNXJlU1QwZkpSVU1WckwvZDIz?=
 =?utf-8?B?RGZ3S2dxc2s2TU9pL0Y3RW5rUmZrQWJwM0Y0NkwzVjNUQXRud0hOVWFuMTE2?=
 =?utf-8?B?SFBHS1grUjQ5RVF5WkI2dEJHNzZiTmVLMUl2NkNpemt6L2R3TVRLN1czTDBh?=
 =?utf-8?B?aXBPcTJya2FTTjNiQW56a1pIbGFXck0vQURTK05MNW0xZWhIYis0KzJBdzVy?=
 =?utf-8?B?YS8yZ2tzZXE0a2plOG1wRCtXU1kwU2ZkTzZzc2hyeWNFbXJLOWJ2dlNLbC9B?=
 =?utf-8?B?a3A3T2VLVEtOMWFLOGplMmQvUlp2RGw2ZEZCWXhQMEV3aXAzc1hSMUNKTW5X?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4300b0-8a10-4143-f6b6-08dc75dbf013
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:11:06.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkfhJ/XjwZrKrIWvp7UjkpPADpXSnwxnxeprPRCHHkkvprzXUWfArjo1lsCk5DGEaNG3TodMa/eYzmbz+zVv7F/9SZSPJ4+Sj4akH1Q4i4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com



On 5/15/2024 2:07 PM, Thinh Tran wrote:
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were factored out from the existing
> i40e_suspend() and i40e_resume() respectively.  This factoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device to be unable to recover.  The functions are now used
> in the EEH handling for device suspend/resume callbacks.
> 
> The function i40e_enable_mc_magic_wake() has been moved ahead of
> i40e_io_suspend() to ensure it is declared before being used.
> 
> Tested-by: Robert Thomas <rob.thomas@ibm.com>
> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 248 +++++++++++---------
>  1 file changed, 134 insertions(+), 114 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index ffb9f9f15c52..281c8ec27af2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16303,6 +16303,138 @@ static void i40e_remove(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  

I applied this to IWL net dev-queue, but I had some conflicts when
applying which I resolved manually. I would appreciate review of the
contents as committed:

https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/commit/?h=dev-queue&id=b0bdaaffc27a79460a8053c2808fc54e4cbdd576

Thanks,
Jake

