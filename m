Return-Path: <netdev+bounces-101135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551EA8FD6FF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB4E1F21C2D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2110156F48;
	Wed,  5 Jun 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dX0J73Ye"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D115533F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617852; cv=fail; b=AcuFIqhjQ6bsFbg2ZcQnClFpEOXycy8oq2v6zRqXC9cQyN2EuXOdMFwshOT+RAKMCSbGoV174Df5O7M5ZgPjTiXrIoV6++mka6lmY4sXfRHWghbdkaLYR42Fx03f74p2f9DZQsddnvYMYzwIMMDc7fsrce9wgfPES5oQjE27lXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617852; c=relaxed/simple;
	bh=g4xrdYZzDZfPHLRDHvUkULep1pRCVFSfvEJ07X539Co=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONamn3htuuvDgAp2VBhRY9VmqtmFIlpnTWXeYw8fJOL7+DPTqguDr1HR72cPtMmeuBBQAM7K3tXBVPFJ1F+b1azV0jKTgJSMQ/QcRofx99LnaW6t/Ch1iQjZRX8Ke8MiBT8R4fKtco1g9ksAGNS80oqZ+q0PhggihoDm6xTRnp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dX0J73Ye; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717617852; x=1749153852;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g4xrdYZzDZfPHLRDHvUkULep1pRCVFSfvEJ07X539Co=;
  b=dX0J73YenXRDeB2mPznvWjsAnOxdw36Hf5Giyz5/Q9eFV2ahpvz2KYz+
   vYDOueacd2Z/ZyDYzpGuPZ/33cgvQJfpw00DQaZUd+u1YRI8I0N8heCsc
   6vglIGhMBQ/NpL+Apz7pNwlAP4versxFJdZGYlyyofzQcTeIigPei1g+v
   9C9/6YBXsBso22H7P1kLI7bJ3qtyVWv3hj9wyqn4wvl9wvx4z3TDvdujY
   Qm8V83GuVYJqps1VUCqRvCdcFva9LJXS3Xm6xqzj2ojVJYkgu1aENTnp8
   hOUj9b5++a+IKnX9RFn/VPpqbpa6mYrb5t8q095GuGyrZXMaXsLsYAMO3
   w==;
X-CSE-ConnectionGUID: 1VTP8kv6QWW0pP4AttwfDQ==
X-CSE-MsgGUID: 7BGseC4tSOmLFjFRN3nw0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14372139"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14372139"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:04:08 -0700
X-CSE-ConnectionGUID: 6coBGGlmQiW0tWGgBxrCMw==
X-CSE-MsgGUID: dnw1ln5JTIyPOdw3+Tf8zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="60895557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:04:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:04:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:04:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:04:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoboCGarwSp6Eib7sn6frU2ApybtUW68nPZTp+0iI2Re2ZClhiNQQLhH5fPKaItLrT7iYPKTzvjrGD3E2A6KkqWxgYBuVnZAZl7W/ANOmgv12UW02BbX8iXtkKdODJiz6aO3sn5snPKwr9aAg/DtsikstLe7A24oI6l37O3cWDWAsZcYdApeEQhJi4PKc5Rh3V+bozVcGwR4GJCaVPiY4boJxRypE63zpMkCIkrMEPKr/q5UOJBXCN7AnmuysUzj9wj0CRs2vx7/1i0h7C8OVRTerfUEDlI8jxPIXUZzlLR49mzWltF89ze//7QSujdMBdQGDZFpwK98fypSIwnX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bfiZ4OPkzN0OP/uKzEyeBVMfiFAWpJ6zHhQvY/aVx8=;
 b=AtE/dkp6ja0dKCDSSRqf0dJ4V3+nNsrvjY1P34KBafz68ifOaksqnAbJcAiaF4klsgT83khSF2tTICBl8uIDVkpyCLqggh+FZ8BqOcw+9PI1qC3ByGvdGRbCdxAtQcg3RoNLaXkRCHPB8J+t6uPt7toJe7mHXOKt5fnzl5/YKV3AA2Ar/wEZZ5vLOaUdA6rMzCzIwJSdYWwSH1g6AfnfnSKddT1u140+pqjXru6VALgLtNKG3CFzzRPjiqSqqye/5lUXfGP40p9t9IC5t0k4SUdwDAGxnVv96b9fvcqhYS1Qo2r+4lmuhAEPkFyJ3A6WsKrdtv5nWFTC+WVzVdxkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 20:03:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:03:58 +0000
Message-ID: <65068820-f8be-4093-800d-cec673d55b9f@intel.com>
Date: Wed, 5 Jun 2024 13:03:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
To: Andrew Lunn <andrew@lunn.ch>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Vitaly Lifshits <vitaly.lifshits@intel.com>, "Menachem
 Fogel" <menachem.fogel@intel.com>, Naama Meir <naamax.meir@linux.intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
 <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
 <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>
 <d27f050a-26db-4f08-aa19-848ae2c6ed2d@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <d27f050a-26db-4f08-aa19-848ae2c6ed2d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0293.namprd04.prod.outlook.com
 (2603:10b6:303:89::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a57156-2ba1-4f74-685f-08dc859aa2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0h2U2EwcGRMcWh2eWdRWlpCY3JQQ2xEQ1M3b2xkU0llekxpNnc3eUVEVmxK?=
 =?utf-8?B?T1dUMjFMMGhkTDBGcXduclpYaHhEUmtjY2V3eFhyUEdTaGJaSlpDVFNaVGln?=
 =?utf-8?B?TkpFalNmQ0tiM25Oc1FIckFMbWtUYmF0TzhNSXNwR09NQlV4ZXQ5OXFaQlds?=
 =?utf-8?B?cFVPcHFNMlRCQnZFYUdtN1JnVmZDTkVFN29XTnhlb2tvbWRKeTU2VCt1R2ov?=
 =?utf-8?B?Z1pUZEJtSHNUUXJHU2pqb2N2TEhaaDNaSk5IcjM4TEl4aHc4emFUeVlSZUR3?=
 =?utf-8?B?Z3IzQmNIZGxoWVV2aHhCalAzTEJseTNtZTVXZW0zdG9KK1Y4QzNRR09nNFNi?=
 =?utf-8?B?RmR0cHVlcGErRDE2bDlFQTdSamIzSkplOGtncCs1a25UYXpySEhyMlBLVXpM?=
 =?utf-8?B?VlVVdnpMUkEzTHhUbCs0ZDFyLytqaTVlZGZrZGkyaGpMdUMxdlVvSmFvc0M1?=
 =?utf-8?B?NDlvRk16ZEZacDdyOFNGSittZkwzVkhKcHgwcTFCS1Bjc0owOWRqMlI0TVdY?=
 =?utf-8?B?WUdKZTE1MHZuU0lMOTFFdzQrQ1JSR3gyb0IvRG1BU0dWb2UxRTIrQUpRWXRj?=
 =?utf-8?B?RkNDVXR6NDBIZHpRN0RmTnRFbGpDaWVNbGk4NFlHTW5HZ2g2dGhxRTl2b0lh?=
 =?utf-8?B?cXY4ZFB1YWR0VURVRDEvUFpiYXdIOUNBVTlwMVEwVnIzTWpjajcxSFdBWUxn?=
 =?utf-8?B?V3p3KzF5d0t0SlBWcG9VSUhSbklxR2hibEFERHhtRTNiZ1RyeTNTNkxsaXMy?=
 =?utf-8?B?TEZjNHhSeE8xNlZ3Q3lKSmtsK092RzYrNlp6OFBDR3lIZzhMU21VczBVVmJF?=
 =?utf-8?B?eHo2ZzNWQjBFQ2xrSE91QTJycDdzUzZSZDJSSU1ZL1l3QkVEMktQOVFralEr?=
 =?utf-8?B?ZFRKVU10ZHlkTk80YnRPeDBVS1g4d0hsNUZCQTMrRTRvVW1MOWVRbkU2c2w3?=
 =?utf-8?B?ZmFmRVVGNEZGRnIrd0paaG12T09KUXNES3B4SDZQWnpZc0VaMzhqdkJGV3g4?=
 =?utf-8?B?UHh5eTBBYkZuQndiWXJEUjlBYXZxbVFxK3ZBWnFKejFNUVZ0ays4NnliZnNM?=
 =?utf-8?B?ZHdwekExSlhjRHc2MUEyeURrbGxhOXI3bmxXRzlIRWoraVpBeGdtSE8wR21K?=
 =?utf-8?B?VFBqdG50RS9yQnRtcmtTUmsrY0FHczVTd2JQWDZ5K0Z5dEdPeGVUSzlLanpK?=
 =?utf-8?B?TE9BbVpRZm94SlZNQXRpM3BqNzBSSktoeXZmVkVBZU93Mi9JK2k1SHpWR2Vy?=
 =?utf-8?B?VXJVWERIQmprc3QyN21LZFVGd3hyNDB1SjN1dDFlSVdNMmhmelFUYUIxcVY2?=
 =?utf-8?B?M2ZnSVB1SURJTjk0RllYdVBmQWxsaDV5V2ZSbWl6NDl5bFpUbFhvZ2laVWRC?=
 =?utf-8?B?YThtVjVBMWhQYUoxUlV1elFQLzg1Q0lqbUg0K0VZYWxiV0FzKzBNY3RhdVp2?=
 =?utf-8?B?Z0xQellUbFVKY1NzMlhlVDd0RlZDVzM3M21KYTNDZ0doZ2xFV3ljUFd2ZW1S?=
 =?utf-8?B?c3o2aCt6UW01U0VaK3RQd21Ud3NsVkZGMDdTWnpBeTlPS0lxSzZDWHhQSkdF?=
 =?utf-8?B?NFBCemtFR1JNbDVncUdBalZzU1E4MFpzblBXWW1tR204YlZtNHlvcTNxcHl2?=
 =?utf-8?B?ZXdkUjI1OGhyVE8raTlaM2kybXZJd0x0VmZKNlVlMWNvUE1NWnFkaWVvTWpw?=
 =?utf-8?B?VFNpMjlaSmVOZUdCeG02cS9RNi8vYTJiUW1pTGRCQ0grSUJLRE5YdGh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0tLWWhSaVpKQ0pSck95S3BjRlFjSENYSWZac0EydDlLWEQrV3cvYXp2OHZ4?=
 =?utf-8?B?SEo1L1ptMGxmc2hpc3VOV00rdEVVem85V2RLamovOGxycCtvbUFlM05MckxS?=
 =?utf-8?B?cStGc1J4dTkvdm96MWFrQTB0UGMwSjBHcUQxdUVOcCtJRzgzS2RXMm9XbnNN?=
 =?utf-8?B?UHgrT3BPVHNEMHJ3aTduUDZGTm5VSk0zeUVidUkxQzFIZ08rT0UxVmNGdnZX?=
 =?utf-8?B?Y01XVjl0MVVtbE5zWkprczQzcVhoVTArKzk2V2xjaDEwUlVibjJ6VWJsZ05L?=
 =?utf-8?B?ZWNQaVpuNTF0SjYxTlljOHQ3M056bXhYay9RU2dLcG8wNlZxTG9ydDNaaUty?=
 =?utf-8?B?NnM2aGxXai9uOGZmSnozMEVVbFF4MFFmVXc0dzFEWEZNcmRlamdMZDVKRlpI?=
 =?utf-8?B?ZWJuTHN6Z0hJOUFsNXVkdWY4QVczTDMwSlhBL3E4KzdKSXNyck1WRXJ5cTJJ?=
 =?utf-8?B?UnMrYXN2aWROTExWYkRpZk1pRDlwTEoxNUkxMjJONFp3OUxpVzBBWTNFTjcv?=
 =?utf-8?B?aGhqVlU0ZDdpTWtGSmR0MEl3eHl1bmVSR0pxM0RWVFdkTnAwYyt0aytZbjh6?=
 =?utf-8?B?YW95THFJaDV0UHpBcnBkRUc3UUhBU3RHN3pYWGpsdE9SK0VwV3hzQlpvUEhq?=
 =?utf-8?B?RjBWaHY5TjlVdzcwUWd3OUpoUGxFVE56OWhLNmQyVjZWQURYWjlWR2U5M3RN?=
 =?utf-8?B?WEpHNTRXcVFVclBycEZoYlYvVVdWRGUwVW1DMzhHU2VHREdxbkNuMlFoVGJX?=
 =?utf-8?B?R0JDTUtreXZZUEdRK3BJemRTSXdraUo4Vm9NSlM0cTl1MGQ4bUNIMy9qY3ky?=
 =?utf-8?B?MVlrUzNUYm1iV2NFSFgzRU9JeU9jdStJaTUyWDRjS05IcGk0aUNwNFZFUUR0?=
 =?utf-8?B?OEkyU1orclhsYzdTUzR3Z3cwRVdYenBmNTBPVUl2S0ZzeHE5bFB1NEJmOHpm?=
 =?utf-8?B?aldRSWJWZTREdHdkSlN6cmZFUko4SXpIR0xRRThvSzg0WERSMk1jME9sbjFK?=
 =?utf-8?B?YkttZkM3emJlUk5ob3JmODlkLzhHM3hZRklHemFOVER3SFhMaVFTTkxkRnVV?=
 =?utf-8?B?eHZ6bmcwd3EzTUN4MkEzbnhPZE9QNjROdkF5cWMrQm5ZeldFeXNET215QjZT?=
 =?utf-8?B?QjZEcEZUczVCcGZwbmprdUExdWhXSkx0RURGOUFtS3k2NjFnSENVRWFjVi9s?=
 =?utf-8?B?WGVGaENKZi9HN1dvcnNCcGtFaTVFaCtnRlgrSnZnOUk5UlFXaG1YemdWV3Nr?=
 =?utf-8?B?N1JoWHpXYy9QSzIwM2FuMU9lZVVMSURJNi9lSEluQXNhZFpzMUp3a0hRT3dI?=
 =?utf-8?B?M2FjR09wY3h0RE1hOHpyMEpuMmVpQ0g4Um5oS2paTW8wNVdKcFBtR2lEcTFZ?=
 =?utf-8?B?aS9wRktmSkVseWwyNlc2QTc5OGxKNFpOYWFFbk1naFpSbHVpKzV2NytvanRC?=
 =?utf-8?B?cDBoWVdLWUowaUhNL0VTQ3dabjhhRkxRT0pDNUxGTXAxbDcwcmp2OXFJZ0Mr?=
 =?utf-8?B?cWdqaldOYml5M21LU21VcDNkZU96SkJJcVpwNC9vNWlPOUFvTDh5RGY0aUpa?=
 =?utf-8?B?OXNnL2NzSHgrVHU5QnNRNGM1Q0d3Nms5amIzcXdQbFRNRHd1dXpXUzVyejl5?=
 =?utf-8?B?bDhZOHRBeVRCUThIWWlsVUpPQWRXUG9QRkx4ckdMYUJ2WCtVLys1REx2R1dF?=
 =?utf-8?B?Ti9XZ0dFQnMzeGFKT0o3Q0gvaDBNbkx6ZG9SRHp1STVNUUZFbXJPSXp0dUVq?=
 =?utf-8?B?dkxwU1UwWHgyT0sxSVgvcm1ZVlNCMmwwUDBsQjc3b2JYOG5lQmtmOGpUdXFW?=
 =?utf-8?B?QnhKM0FvYVZYMjBFRTFTVXVrNWQvZjF0c1p4SjVYVW5xdmJiTkMrb0lwUlRt?=
 =?utf-8?B?ZmhNNlpNQm9QS1RHeHFTVEVhQWNsZ0N3eVhlNmp5azZsNHA1MDJCbFFiZnd4?=
 =?utf-8?B?Y1VJRmcyMjBMUEg2R29DSi9uV0s0Q1dMQU82VHJGaVhkMmp1d3dOU1daNE1B?=
 =?utf-8?B?ay80Ly9PYUNGNXlPeHBJVWNNUkVFdUZNQTI4SmlsNTN3N0lsWHdaZjdiNjRW?=
 =?utf-8?B?b3I2dXBKTXkyTUEzOVZmREJ0REt3OTZoRmV2cXBncU9NcnZ0Y2hJaTcvN0d6?=
 =?utf-8?B?WTdtaWNrMjJmL09WeWVidEtoOHN2VSttZUQ0RDJBZktmd2txdmlFY00yMThw?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a57156-2ba1-4f74-685f-08dc859aa2f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:03:58.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE1AU5LkelN0oJtq8BCM3Qyj6E2x8tmbjaMdlW0oddd+e2Ir/xwX2u+nN8MnKbp95zT93HZMB8KTpN+P/Cjdyg55uL5VV0FQJXkezV6fLzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com



On 6/4/2024 6:14 PM, Andrew Lunn wrote:
> On Tue, Jun 04, 2024 at 02:12:31PM -0700, Jacob Keller wrote:
>>
>>
>> On 6/3/2024 5:12 PM, Nelson, Shannon wrote:
>>> On 6/3/2024 3:38 PM, Jacob Keller wrote:
>>>>
>>>> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>>>
>>>> Add support for ethtool.set_phys_id callback to initiate LED blinking
>>>> and stopping them by the ethtool interface.
>>>> This is done by storing the initial LEDCTL register value and restoring
>>>> it when LED blinking is terminated.
>>>>
>>>> In addition, moved IGC_LEDCTL related defines from igc_leds.c to
>>>> igc_defines.h where they can be included by all of the igc module
>>>> files.
> 
> Sorry for the deep nesting. I missed the first post.
> 
> This seems like a very Intel specific solution to a very generic
> problem. The LED code added by Kurt Kanzenbach follows the generic
> netdev way of controlling LEDs. Any MAC or PHY driver with LED support
> should be capable of blinking. Maybe in hardware, maybe it needs
> software support.
> 
> So please write a generic ethtool helper which any MAC driver can use
> to make use of the generic sys class LEDs associated to it, not an
> Intel specific solution.
> 
>     Andrew


... Isn't that what the .set_phys_id ethtool callback is???

>  * @set_phys_id: Identify the physical devices, e.g. by flashing an LED
>  *      attached to it.  The implementation may update the indicator
>  *      asynchronously or synchronously, but in either case it must return
>  *      quickly.  It is initially called with the argument %ETHTOOL_ID_ACTIVE,
>  *      and must either activate asynchronous updates and return zero, return
>  *      a negative error or return a positive frequency for synchronous
>  *      indication (e.g. 1 for one on/off cycle per second).  If it returns
>  *      a frequency then it will be called again at intervals with the
>  *      argument %ETHTOOL_ID_ON or %ETHTOOL_ID_OFF and should set the state of
>  *      the indicator accordingly.  Finally, it is called with the argument
>  *      %ETHTOOL_ID_INACTIVE and must deactivate the indicator.  Returns a
>  *      negative error code or zero.

Maybe I'm misunderstanding here. Are you asking us to expose the LEDs
via some other interface and extend ethtool to use that interface to
blink LEDs?

