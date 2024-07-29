Return-Path: <netdev+bounces-113605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50BA93F43E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A851C21612
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0359143752;
	Mon, 29 Jul 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbgbxDzm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830311422C4
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253113; cv=fail; b=gyd6WJ5MNT8/LhN6wEMSDkAuxiCTa6MOGfE28qUyaOz6e995Ca/aaou20h3OzZQIC25Mt06Kvn0A9hnNIlgXwZbP5Npo2cYNnCzqvNvXANjDlsqNwW0jIH0KF+XTE18rj/1OQiNBYYdh9aGr45b7kRNdC9XLOvLmarziqXVnR+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253113; c=relaxed/simple;
	bh=9t3R9g3nO2lyVVWx+McZ6V5bXEQFErovzqExoXfAysI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fFSN2H5jWCD0hUo8M/9PKS8uXShYDoMDcxmMQX/qDrsTtZCrOTFEgjoJOE69//i3TcvD8RzMyO9fO9brbwZUa82iDCQDLsKiFPs4rC5Z1IU3P2p3v9J0WUNIPsbwj2iCdU84XuRCHzkxRa8oeJCmLmp2kGuZJ3a6nTzTfaHZDgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbgbxDzm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722253111; x=1753789111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9t3R9g3nO2lyVVWx+McZ6V5bXEQFErovzqExoXfAysI=;
  b=WbgbxDzmMfbobpkDYK++KvXUZLhA6vGS1ZU4qxoavZofsPESbr/kLRfo
   SnfclV9EvBei9Vv0BolKzVmAHUTQ8tKzzPqCC+/m5SYZdPlxmvrQDp4Og
   Yg9l3LTATZxuIi7BPZHRc6hVqOzy1iknn/7HczS1ctH7wclC0uoXX1ap/
   dz0ds9wWlUzIK7mKhasNgjK0s6G0hu8J7E9b5YKXu1KzfxVgmlwINMNDK
   4TG6C/6wzYCibGxfJegd5sRKD7S+/v4exYbtQNvMHdgF2ovzljmBNaJTU
   kSujo38s08XwQ3IAElyD9unqekP1Fho98o97QoY3wrtkKxmivppTbIaxa
   A==;
X-CSE-ConnectionGUID: JAPmgMSNS6yIOXDRnAxoPA==
X-CSE-MsgGUID: iI5S4O79Qa+olETLadRmNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="37510101"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="37510101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 04:38:30 -0700
X-CSE-ConnectionGUID: LXCnTq5jQe+o4bA+aXindw==
X-CSE-MsgGUID: 6k1O5197Tky1wilGXKK5jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53860003"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 04:38:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 04:38:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 04:38:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 04:38:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 04:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taDLbdqizBgeGwcBEjzji0V/AmyqtNX71f5FSFPTzfCshVpQId2+vyuom910sIj2LHI5q0H9b8Zgah2ZpsrjNptxuO6LfY5X38isq+n2+v2b84uE6VG31cuzc7RRxkcxHhStU2XCsM9rr/mzETC8GeRpcn2i+7hrjNCB9WkQIeoJg/vjl5C0A0i7pPgKNdPjsOq/7RkkJraBWSa99+euI3Ello5nvF44j6UcjWoYMInejK/lf+nAowEXV6BclxfQ99X29idHRQ5lqQfNQbUHI5bFjL6+MmlAo9T9Zu/OznE23l4kOsqkGloog0zVjSibzgEJsyoX7NKhCQBqslP4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/dxHyeJ9RHp/fRMcrOM2dKTq7x84F7Ea1DZWrh/n8Y=;
 b=YqDdjwl7tsA1wJoXKcTz8Zow+xC1swYm3WtoRqkYqxISXnoQVGFqqb0cqcUuxXUBsibVtFG4+JAIKBi+B/yT1UfTuB7ifrxqEDUDslwQjUVp3rHhqVRQPm6UchJznkL8tNozQr1qLBHC8ksgB7i578cqp4hrqyNZtdL8sszSmukEsAua0S4x9CPnlUgg2yV/d+zZBMipVKvzlOeoaNNQsv+rAygH4PkxotNw1WLvMTGjqYxWiq6jYxQSfN20lp3peKXZtovSTYqODvgUS5MDuWme5scgPplpNkdjVnCqfKAt4scmr07OVHdma+XAcafxN7gFx6cWTz7OigTYPGYi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:38:26 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:38:24 +0000
Message-ID: <9bfefa59-6105-4a5a-97c6-619b7d0db2ac@intel.com>
Date: Mon, 29 Jul 2024 13:37:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 5/5] ice: Drop auxbus use
 for PTP to finalize ice_adapter move
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
References: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
 <20240718105253.72997-6-sergey.temerkhanov@intel.com>
 <08270b9b-58b6-4b4d-9134-372494d116e4@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <08270b9b-58b6-4b4d-9134-372494d116e4@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|BL1PR11MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: d1df47d7-9c9d-4d1d-f426-08dcafc2d469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGtVNlZaV1JSWmExakdzcGUwOFRhK2J6Rko5WmlLRWFaNGdkWGhHQnhVenhp?=
 =?utf-8?B?VHNGSzd4a0JEZ1lrQ2E3eXdwaGdpRXF4L0JWT2gwTlI5QmRJa3R1RUxhWjRE?=
 =?utf-8?B?T2NlYXZrNDExM2ZTMHR6U0lMZkhhbjhZdlp4VGJYYzg4OWtFUE94Rm13YzFY?=
 =?utf-8?B?Q1NsSTVkdGZFT2FhMmlsQ0RaVlBqRzNxOUlYcmZwVWN5eVV1MWdHdktsU0FY?=
 =?utf-8?B?dmRPdlpoUzBJQlNUNnhQaFkzQmo4VEhEMVZtM3BSZXlzV2NvTmVOdFVFclNL?=
 =?utf-8?B?dG5ZdHpaWURkUC9EMlBneGpUSCtzdzllRmtMR2tLdHd5QVlVQnRyUll6Qy95?=
 =?utf-8?B?dnMyYUxWQVVXa2NzZHRwNUo4TUdLYmJFSmhiZkJhellqOGNKNmliMTNsR1FP?=
 =?utf-8?B?YkROR0ZtVVRBRFp4U202N2hlbmVQbVBCSUFxTjRpem1TMVhodElYell2RGFM?=
 =?utf-8?B?TU5seGZuZnZhbko5OUFKeklydmpMZ25EUlZLZmlraFhxK0tTdzBpTUtmSDFz?=
 =?utf-8?B?YktQTnF3OTY0TnRBUmpiRXF2ell1MnJ1c2IvZ2gxTkFtSHdEWHVjZE16a1E4?=
 =?utf-8?B?d2ExcmprMWVIV2pvQmpacTJ3R2Jhb3FOcWYrZ1lsOVpyenROWm9oRjRRUDVk?=
 =?utf-8?B?V1dzTzBYMks0UWtVS0pXQUx4U1ZObXEwcEhOUVBWQ05aaEM5NTNFVmZMS3VK?=
 =?utf-8?B?elpsa21hZDR1TU9FQ1VpRXN5dmd6YkFpc1VtcmpDSm5tbllTcllIL3FOeXQz?=
 =?utf-8?B?cnNjYm5iSnFEQ0FZRlVkcXZmeEQ5V0lPNXVRanV2ZnRsVkIxRlJKYlVHaUR2?=
 =?utf-8?B?QWtqdzJPb1BHU3RkcFk0ZDNrM3hjekxYY0d3ZWdSRHF3S2ZOY1BqOGFuYkZt?=
 =?utf-8?B?YzI3SmtxKzcvTFc2OTZlUHpObXNHb1MwdEsrYStkay8xL3grZG9zZ3BPRk5k?=
 =?utf-8?B?Nk01Qk1vZWFyS2hTU3haalFvWXJtZTkxRVZzYVNpNWd0WmRweHZtUFQ1ZWVT?=
 =?utf-8?B?cE1XTXRuZDFhTEFSNFk5S2o5cTNTYXlGUlFPcWxlMDZPWnlzbFE4TWR1b3Rn?=
 =?utf-8?B?ZnVUMlh3RXZZRDNnVDlsWjh1YmR4YVlpUEt5eDZjM1pMRWN1R1NXS2R1Vmsx?=
 =?utf-8?B?SVQvcjRWMHF0SGJDTTVEeHJCQUlsNnBNUDJaR0l0aVRaRWt4Y2JBMWpZMVdC?=
 =?utf-8?B?TmhxdUFyMzV3L3Z2UmF6ZlFMcU9ObEg2cW5UOEZwRkwvOThQSmlsK1JDaVd4?=
 =?utf-8?B?Y2dMUXZUNHk4RG5QQnZLNDhQZDJMSExBM3pwRU1zQW5mdWdKRyt0ZURFbFY3?=
 =?utf-8?B?UFRFdFg0aXd6YVg4dThaME9QVGZpSDJuUDlUNk1JSklnRFJjS2NkdzlNend5?=
 =?utf-8?B?eVJDWE14YXdDNE92RWtPUXRLZktoNVkwS3kvSStXZGZOQXBaNjM1K0UzWWY0?=
 =?utf-8?B?WlFwQngzbHhIK0pOMGxLLzJpMEZpNXA1VWI4Uzh0dHZxaXk0bmVNWTVjQW5S?=
 =?utf-8?B?Y0w3SjQyYTVkbkt2TndWbXY1Sm5UcFQzMHhhWUUxYm5xMnhLc2tyU0FNYXgv?=
 =?utf-8?B?U1h4K2szU1hTZlVJdjQ5OTl6U0UxN2NCV0xGcjNEazNEbGZVMm9jZXI5NmpC?=
 =?utf-8?B?RUFvWE5Ubkh6a1cyT2JGOERFM1NxMVpxNmJBWFdLa2Q0Q001L2ZCbkR4MDdx?=
 =?utf-8?B?c0tETUxiaHc2UEtJUnpYNk9oMngrc3FLdFhMNjdMMGY0emQ3dFdDL2tRTHN1?=
 =?utf-8?B?dnA0SHJxMU9rYmVFekc4eGNRb3JXZFJodlE4UzAyMnN5Yk9oV0JFV3B3NDJ4?=
 =?utf-8?B?bHd2Y0RjQmYyMVRCQ3lpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlBaZUg2cTFTQmF1UlZhaERrNHpBZWxpSG5hSjd5RmsyK0tOMmpsY3UvWXdp?=
 =?utf-8?B?cTRpS3NzeExXVng3MVZLZ0pSTnV6eFFPZnVzb1lLMU53b2NiUG9ZdUdQdFdC?=
 =?utf-8?B?VkVxZjBtUkx2OTFWaUc4WlhuMlRlTHo4bGhySlVEalFtdFBsZ3lNd0RMZ2ZQ?=
 =?utf-8?B?WWl4WS8vRGhId3RRNVorM0hjTkRiTkltTGFuQUc4ZEM0NFQ3TVpCS3FYT0pM?=
 =?utf-8?B?di90blVIOFh1QlVHUUxDV1NITkkycFZCeDJWd1orMHp1K2FoVUxaM1MvM29K?=
 =?utf-8?B?YXlIdWtlMlE5Uy9LMFM1WU9xN0NnbkJtbW5TZFNHV0ZGTFg2STB1QkdkRTVz?=
 =?utf-8?B?azNOSWFzTjRFV05vYVNKMW13RVhYbXBmRUZLd1BsVmc2RldGVW8rKzZYcmhU?=
 =?utf-8?B?UlorTzFJM1o2b2t6L3RpS0lhRnpVa01pbG1DVStaUEZOU0FGTmxFYVk4NThs?=
 =?utf-8?B?akFDV0F3dFYxTTI1N1RZSWtnQThpeXFHMVBVbzU2RzBtakdOMGRsdUQxcUVz?=
 =?utf-8?B?aW8wL2IrSGgrWURwRDRncEl6TW1ZeFpMSXVMT2dQSkNBNllSaHJFWDBqa0dI?=
 =?utf-8?B?NTQwU0pYeFN2dHA0akdINmFEMnRpWVNZZ0lLSnNINjZBMEpWa0VybWl3SE4x?=
 =?utf-8?B?Ylg1c0luS20vWmhnK2JkTTdhano0dEhVSWNUSlBOOGFkbEhhQXRtNzhmQ3R5?=
 =?utf-8?B?K0dYT1NQUkFoMEoyeVIyUXIrYWMvbmZ3ek1VcFdoVUVUbjkxSEtSQ0xxejlU?=
 =?utf-8?B?SVZhT3Z1ZVd6Z2xtdzh6b21URGRrL1JmdThUWnRTVmE2M0RZd29GTFNtTVE1?=
 =?utf-8?B?TG5paGRCK0ZFQ21xNWV0NmFIMmxGdUx0Qkw0RjFGaDVhV1FNOElFdjgwUkVs?=
 =?utf-8?B?ZS9KUzNqQUVnT3FYRE42eFNaeTVJamRWOEhLRzJqcTQ5SW0yRlFQcGwxUnJZ?=
 =?utf-8?B?WlFmM3lSYUd0cFhRbGw5V3pTbmNMaEFUOGJzSGw2M0xhcGlQWnhvN0FxQkhX?=
 =?utf-8?B?dXkvM1FXVnBCZ2o4ZXMxa2R2SWsvRVVDN1FLc2l1dk92ME5nMDBheXdpVi9B?=
 =?utf-8?B?cTRxYmxKeUhQVlFadWtMRHZFa0IrZ3EyNld1MkZIdFo2NDFURE52V0N1RWVh?=
 =?utf-8?B?SzhPQXhwMm04SjhobkxtNVZiSnRSMkFoT1dUbTRhRmJMVVYzb0ttVmU5OGFw?=
 =?utf-8?B?UngrNjYwUHAyZi9NVU4xWkh6cktONDF0dFJXS1RVMzlJN1NOSTF4SUhJTGI4?=
 =?utf-8?B?aXNvaElMamJ4TDFDUHQxdEFmdkxVV2phRzcxdG5Ea0x0SUFZSXhEWEZPcnJk?=
 =?utf-8?B?SlpPRVoyT0Z6RnJCbkhPZnk5Z1NrVVNZYkl0MzVZSCtNQ2dNR01XNUIyTU9X?=
 =?utf-8?B?OHMzb1BCV0lkMmxBN29GQWZQTWZOZkRFenBBSXFDakF3eGUvVXRHS1hDZVV2?=
 =?utf-8?B?UStOdnMyZDJ3d0dVcThJR0MxdEtHOERzZ1NzbnY0bGdnZC9sMytqdzJ2SFI4?=
 =?utf-8?B?d0FqbU1ZYlV5dWNuRFdacDhQaE82eUNkeWUwbkU1a05uTkJRdndWTjV4MGdD?=
 =?utf-8?B?QXptTTlab0hSSUFZTmRWSllLNVRFV2dXR1krV2tlVFkzck12N3BTck1sVVlK?=
 =?utf-8?B?ZS9WcGxPcTBzWFlFMjJQekJRS0EzWFdVbUdJZjhiSnFnY00rMHAvY1B1aDJD?=
 =?utf-8?B?bzFZRS9Xd1ZVaGw0c0YwS2VLOENFV2cza0VCUjdpb2p6NFhBM1hmcUtpd0FT?=
 =?utf-8?B?Q2dFbnVHeklnZ3UzRHQyVUVmcW9LQ0FXL2ZsWDBJTGFtbGQrMlJGZkJUSVQ3?=
 =?utf-8?B?eHI0S0thRXU4b3dtQUxNWnIrOUhmYzVxdFNRSlJScTFtMlJZWnZXNTM2U1Z4?=
 =?utf-8?B?d2p4R2w1cHFaUVRFNlhZWENnSWk5Z1U1MWhSYmVtTTYvZWViQ1JhbGlmcmxr?=
 =?utf-8?B?ZXJCcjNiOWpyR0ZEeWY1MEpMSytKK29DN1VGR3lZaXF6QXdydkh1Z3ZIMG1B?=
 =?utf-8?B?c2dSVGhEWU5vekg0TGhWVDFBdW5ndGZOS1dZZ3FkYWswZWZPd2hnRXhySkto?=
 =?utf-8?B?dFgram5XcENMWmc1VlpYQ2pvRkRkUFlLMTZ3QkNwZ2JpeFJPVHhuMU5pTCta?=
 =?utf-8?B?MlVuam9tSjMvTTNKd2NzY3VObzV1dEMzZGN1Qzl2d3ZkTUMxb0NyZHF4WkJ5?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1df47d7-9c9d-4d1d-f426-08dcafc2d469
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:38:24.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWxqBeFwQeZkO0cvz8nFuciMl1+pFyYTJ7EaXe1n6xocxByiHUeUEXF9XGzthu23sDLXzP3r76WEnfVd6PqRI+pPixvzKTkU/5Ho3wI+nPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com

On 7/24/24 01:20, Jacob Keller wrote:
> 
> 
> On 7/18/2024 3:52 AM, Sergey Temerkhanov wrote:
>> Drop unused auxbus/auxdev support from the PTP code due to
>> move to the ice_adapter.
>>
>> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ptp.c | 252 -----------------------
>>   drivers/net/ethernet/intel/ice/ice_ptp.h |  21 --
>>   2 files changed, 273 deletions(-)
>>
> 
> This patch probably could just be squashed into the other, but I'm ok
> keeping it separate.

It is way easier to read new impl if it is not intermixed with removals
of the old one :)

> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


