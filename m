Return-Path: <netdev+bounces-156297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F8A05F75
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA17A3A6481
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9A61FE475;
	Wed,  8 Jan 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAspOCJD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3B1FDE31
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348333; cv=fail; b=uZCSCnf8kUVt2bhn5audmHuvvRGNr8W3zAMYvU3sZc8dROuqw2swRAlq4I7SoAIUzmXpioNbYUtcAG+Cl0dXO7PGfDos0woR/B/wiHz5h9a0jG4YjqAXw41YnSfOtLlik06Nl38jFQmK0mIAstczL/VksKs+LR30Zq5pLRZmhUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348333; c=relaxed/simple;
	bh=ZTyHIj9cG6pxafqiM5fzUlaMzkWdqU8cs8XNC9wpdz8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJWrLAEB+TsIyg4C/oph0rjgJWgW62wTAbaA+QXK3irE/8pjEsQk/fchqnz9OM1WD9aR7OSR1ByfMYTYvdTnTbW7LwrvlW8cnuNXbNshCN0wTd2XfTTW3axC8WWp/uIfxp2gGmZQ9SMBNYBxCPzCFHAuraJAuEfIzHTVC+NF6Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAspOCJD; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736348331; x=1767884331;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZTyHIj9cG6pxafqiM5fzUlaMzkWdqU8cs8XNC9wpdz8=;
  b=jAspOCJDtgeE1psNgh88Ko2Uz08v3dDxV9a+3CC7kLZNqhljCaTlYVKs
   JIgYe2ynpRQCH5snWlVN0nJDVrTxk/SsuYjyk8u1Ra0TDqavHn7smeZ4P
   UVk/05o3ZVzoNawQ9EG+J16TW5jixwMvfkoK2oWmG7UJnIK1KBKE5QqL4
   sokRU0YvZ3da29SMRshZjn+xDen/Lt/7UPLsr3ICjwbykqPlPTVK5vr39
   OkrlKH9X4ZTgcR0y7nkfXIj8l5SXogStRIF924R2LXU3p4RFaOH86FvWX
   6fNSGXeO9/5SWG5/5yk0ifdQU+oeq3QicvHEsUztqLguAOrbfUQqaH17l
   A==;
X-CSE-ConnectionGUID: Adw+QoM0Tw2MyPYdxsuQoA==
X-CSE-MsgGUID: c2EUuHu2QLOokhEldx6FSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36797706"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="36797706"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:58:50 -0800
X-CSE-ConnectionGUID: jwBhgTyFSaOTE4ipznvHhw==
X-CSE-MsgGUID: iL4XpMVGSxSOJ7Ww3zzUgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="103617536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 06:58:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 06:58:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 06:58:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 06:58:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhojubXYUYDM2pzELEDs1dyq4V2t2OhZ7MaMtU/rhmY2LTNiG8dKUCLKzzy4X6rZOXSUs3U0u1Bi+Vz6lS6Z+XnTdcT8AE96Xayv/zvsCe7whjkr00+GvtX6wE6yTFZxWPx4x6xuqBcYFZaQ8cQh8v7e1XBcLgBQmp5LeqbwgE0yEUhjK5TpiTetAYpz3xYGE4z3oojqqWctTzB9bzT/pa+R2/ohx7ZzH6Ta32dnAHrN8jwre+FP3MlXW2wY/CsUkqT8ETW/GS+njVHm5zwOZSoOABuVHRmR+NQ9Crl/5M6YXU1gQ43hPjLVplKMAtL0gzGAhSw/V3VR8DGQKOrURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBTPrh2VGU9jvRom8IJii5WAoU0jcdJ/yUyna1j9GuM=;
 b=Uo6ALJxa3JH9WlAAnSsUN3gTQetfpYA+piTM6RNFktO5Smzk47u70nY9DuLPJEPUk063tY8RgntMnkOTHUIWWlB/8cHknWCKM8ntBSXm0aTecith5SGduzgRTojQSEcBLuJJX7ViyuP91X4nYC14hC9/x+HB8vKfr27QMIioVXu913FwNFvdvxzNgl666lLd8R9HxttXAfvzEFAW1QOes9gdb0k8pwuMKh/2OkF8LHNwAlql15O5o+4CEnFSAQwhRtbScovkLnY6lbm9ye0srKSgvfujkMM3+0Nr7aN3UamM5YRzKM/RYntWM1+bC0+KGzvLsc2g1Fomwn7ZGgdb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:58:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 14:58:43 +0000
Message-ID: <9a961e7c-1702-400b-89ed-4dcb2d1ef81e@intel.com>
Date: Wed, 8 Jan 2025 15:58:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net/mlx5: fs, add HWS modify header API
 function
To: Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-7-tariqt@nvidia.com>
 <0a115ea8-7be5-47db-9fa5-b248bccbcd38@intel.com>
 <adbf7344-2d1e-45ff-86da-e2a7299f8c13@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <adbf7344-2d1e-45ff-86da-e2a7299f8c13@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: e1774e65-3871-464e-afbc-08dd2ff4f1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUZ3THI5eXFtRDRjUU1mWlBvbml1Z1hLdlJnbk9QQzAvNVlvbjE1Zy9HcFlp?=
 =?utf-8?B?UWljd1VoSHc2aXhxTzZkaTRZTEdMaXp5d3JmRUI2eTROeS9qSUhPT0tpTWNs?=
 =?utf-8?B?Ym1HTG5pVmhuVmM2MGZudDZoQWFZdmxHbXRUVlMrQWw1ZXNNT3QrMGwzSjRO?=
 =?utf-8?B?ejNuVDI2NzFPMUtpUzcxQTVYbmROb2ZNR3ZSaVVVanQzQ0I3eTl5V0pKVXA1?=
 =?utf-8?B?U0Y1M0xQRFl3a3Yxc2RkclprZmhGN3NRbC8xa1VzS2RSamRyWnNZVVBDaDR1?=
 =?utf-8?B?cllackhDbGl1NW40TEwwTzREZ0VSZURPR0YvSlZidmRaOWFPMXRKVlR1ajNa?=
 =?utf-8?B?clZEM0hqcS9CVHNTUlBxeGIxaVZES2JSMVY5alJTUG1kcGk1TEhCVkFyYlo2?=
 =?utf-8?B?TktVclRiRFd4SzUweXExV2NkeUlyTlJBMkU1azFZZUtHMC8zSGFRNUZ0ZmhH?=
 =?utf-8?B?R2ZHZjhSUnZVbXloMlJzSGVXN1M3V3YxcU9HVkFyRDcyMVlqN1VKd1ZRMFN3?=
 =?utf-8?B?ZFhod0NuTHk0Q01GS1BxdEQ2WTNoWVN4WjFia2NvQWhuUmM5SXN4MlFFR2or?=
 =?utf-8?B?dGtnY2pPNldtcUdiNHpyL01OWVpqblZNakhRS0ZPZUJFdmtqS3o2dE96RWNs?=
 =?utf-8?B?dUVhekRBQzJEaXB0QzZRckY1RDJTTlJwVHYrd01GMm83Qkd0NHQzRFVJNDhQ?=
 =?utf-8?B?RlZNaEhlTXc5RXFiZmExVzdHcHF3Sm9HZE56TlJOazh4OVNCQjAzNllFUjdr?=
 =?utf-8?B?UTM1a21CUkE5VlNFeVhTVitHMUVRMExpMUtneU9FK0labWRBSHlGQ2FiOTVV?=
 =?utf-8?B?OWloRU9JRFRKRGx3cjY5SGFqVEp6SFFvTWMyQTVab0xkeFpJQ29xc1ZSK2pP?=
 =?utf-8?B?L29EQWRCZ1J2RFhQZGx2VVpnWXYvZ3h4Qi95QVVYbUd3Z1BwbUI4VEZHSThy?=
 =?utf-8?B?QTBxdzZGaFp6eVFIY2JUZDVNdVllcXhzZGtJRFFZRXRlVnNPN2pLVzczVmoy?=
 =?utf-8?B?Y1BUZ2ZsRWZtWC82OWU3MmhLTGgxbUtZZ01IcWE1a0pMLzR3eHRMMFJvSUwr?=
 =?utf-8?B?T1Fxd2ovWjlhUkJ4aHFQRXdDbjNzeWFKdDFIY0Q0WFJWcWhaZVUxYS9wLzNQ?=
 =?utf-8?B?ODRIUTF0UldQNUU3UzF4Nk92Z0pqTEw5OHp2d3A3cHNmMlYvTmF4Niswb0hR?=
 =?utf-8?B?TXJOV20xRURQcEEzd0N0ZHlYNEtieFpjUjhZb2o1NnU2enZkbzY3aW5tSUdv?=
 =?utf-8?B?US9JUGhRUmJ0U2NFSk9jb3dlL2pvamZGZUJhWm1QVUNnRExBMjdnYzUvZGZo?=
 =?utf-8?B?bzRoVDdnZmt5UXlKQzdzTmc2dmRJT2I4UTBxSmJrTGk4TDhUeHd1cm85MWp4?=
 =?utf-8?B?SHYvLzhCdlBYOHJjazFKUjZOTXNubDlqcmJVQkg4WXo5Z2pYVmU5djRIWDZz?=
 =?utf-8?B?ZWkzMDNoZ21FYmxiOVQzOEVuZE5LTWhuclQrQ2tnK3Y4aCtncmhHM2pRWklY?=
 =?utf-8?B?WUF3TlZ6QllQRW5yOWVSWVlNK1JXWXBGWnBWUmVwcExKZmlMVXdEeS9zOVlz?=
 =?utf-8?B?eXlhbmlOMWx1M0NzNzIveStQNjZlUm9seXpNZFpleEZ1U2luVk0vRFVvTVBY?=
 =?utf-8?B?dFE1R2lEWHNIYWpNMUUzRzE1Y3ZEWUk0NmYrMFhrSTlzdE9MZFVWN1E1cWp1?=
 =?utf-8?B?SG5OVStpSjVLOHZHS2NhMlZvN0xVbWUxWHRKZUdKVVBXbnZEaFJYWjRTdkdL?=
 =?utf-8?B?Z0RCVjdRLytmVjBuYW1UazJMZjg1Sytoa0xOWHZvd3dMYi9HeXhjT3RDeURL?=
 =?utf-8?B?eGZtclU3SEYxNWEwLzJ2VDU2RDdBMi82V09nakF6RlhHdytLeGxDRFNGRnlw?=
 =?utf-8?Q?oQVJ+yYfFSM29?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjAzbHpJck5xenQ2SGZKcy9CT1c2QXBNM0F6ajRyS3hFNVlSaEJTcG9EakpT?=
 =?utf-8?B?K01UT243NG9yTEZWMzBYU0pNdDlKOUZqUkp0TzVENEhyN2ZsVE9XMXhtTDlO?=
 =?utf-8?B?Q2NVdit4TkQ2djV2VVh3VW9nMThhbWdWeWxqUW5HdFROZVFCYitKcVBhZzJs?=
 =?utf-8?B?UzFMQVFiOXRYWUF2SHQ3TG5KY1ByNWd1NXNCWlJyMjZadndNVUovVm9Pb0dW?=
 =?utf-8?B?ZjJKdDNhZCtxd0RtRTFwckJzSjZOWjVtWnlkQ29uZGEyQ3dUWUNaYkFOeDRU?=
 =?utf-8?B?eERHTkFqeHpMLzJpMnVTR2llTEZaOUFWcUMyb3FjcWZUbUNoeXdtWnA0bjV6?=
 =?utf-8?B?TjBhNFlPNUxBblFtNGRjblpVS1JVOVlMTFdjOS9oa3dEaXBvdlZLbUlHS29U?=
 =?utf-8?B?cjFhOUxRZUVPTlB6U3hHc1g4UTdlY1I5WlpWU0tPbXRmYzVhMzZwYXZXeXdK?=
 =?utf-8?B?NFZWVjdQTmExN0hKUjVLU1JENWdNbkVHYk8wTEsrUUJFQ2R1RnkrU3pDUUxr?=
 =?utf-8?B?eFZycnpXdkRpdVdqK3Q5QnZFSHVKTllHWW90MWRrTUhVUGl6MGIwK3k3b1V0?=
 =?utf-8?B?SzhGSHZMRWZpUnpoc2xGY0EwOSs2d045cWMwSUxtRExoSG1XY0U1djQvbTZ5?=
 =?utf-8?B?eXQ2OEQ5VVc5U29mZGhMamlvTExhOU9HUnNWQTg2TWJIZlhUcjFMWHNKL1k0?=
 =?utf-8?B?akIyRWYzSDg5MjdxcVZhZDVlZWtHUTVuaVRFOHd2YjQwT0R4dUd0YmRNQ1Zm?=
 =?utf-8?B?TjRFUjIyMnhYL0dtZ2hzSFg5UVVXdTNrVGF6Mm1LaklicTRoM2cwM21JSmRV?=
 =?utf-8?B?RXZCMGVjNVovNXpBdEhRYVh3VzN6ZE0xWk95djdSblFWV2FHcTBhdFROMThJ?=
 =?utf-8?B?OGlMSDRmbThtcHh0RWxON3BpOUhMSlBQUzNLRkx3U1F5SVJadjBYYkZrRmRk?=
 =?utf-8?B?OEZnR25HTjU3VkFxTmdzdnE1MjQ5TWtTVkgrTk9MVjNlL2xXMmkwSmZpRkxk?=
 =?utf-8?B?aXlLU2ZSajVaTVYyNmZvRzNNbmJYN3lQRzV2QUkzUk5jM3NhUzZxMGt2S0h3?=
 =?utf-8?B?cThtN0ZGV094UHQxL1IzU1lsVXVZY2NMVmQyT0hwNVBRaUR1VS9ndUFrSTFi?=
 =?utf-8?B?ZTIvV3luYnFtNVlGUUwweDZwU3p1NWZhQTRMdUxjWjlJRndUY2ZWYy9NNm9C?=
 =?utf-8?B?TWk1TUFPSk85VDFaSEYvZEg3MGo2ckFzUWQ5cGhnQWpiY09UOTRQWDFPOXZv?=
 =?utf-8?B?Y2lwcWp6T0llVnhTbmQ2aExjQTlVMFB6alROa1JjMjZJWUhLbkZDQm5sK3ZE?=
 =?utf-8?B?KzlRVWpGTFBqbGlwdmRBUDhqT2RtWHNJdTlRUnZmWFNyb1J1Z3hESFZ0bzB3?=
 =?utf-8?B?b3EyR0U1WE1NNTF3S20ralZoVnpEek5McHFlUzlVenR3Z1NqYXdhOCtPYkZY?=
 =?utf-8?B?N3hlUHZvQUliWGFUSTl5NVFoeEZMWmR2bU1DdkFHRVFuWUpzR0F6cmZyV01E?=
 =?utf-8?B?WW5pcjBZRjN1ZSs0WHhITmVzZTNjQ0s1Q0VEcVZic0EvVmRrTGUycjMrdmRM?=
 =?utf-8?B?QkJBcGgrYUsyOUUyL01aMUtpQkhkaVBMSXZoYlFHZ0JFVnpNK0pITEduTFdt?=
 =?utf-8?B?Y1RWSHpYL3Jjd3IxT3Jrd0xCVmhvU2RZU09yZS9lV1djc09vMXFUYlFqL0hU?=
 =?utf-8?B?K2dKN01pRjZnaXpYcUw2WFVBS091em85Wm52QTgxZHYxMHhVUVlHQ0I5YzF0?=
 =?utf-8?B?UDVWbDJGSFVzR0d5OTkwcURuemc4KzEvMDllLzZTQ1N2VXBGNWxLT2FhNG9k?=
 =?utf-8?B?dWxJTEM1S0xzd3d6TitGczJrOGVOK2lpTmd0cjl0T3k2emxKajlwUnJjSDNZ?=
 =?utf-8?B?STc5VFFNUmk4c0Q2K2NxUzRCdkUrQ00zSGcvK0hOc3oyNXd5RDVuU1pVR1N6?=
 =?utf-8?B?eEJGUXVCemxNWnFzS1pwYVhHMVdTVndGNWZGWWNtampOeEcxRm9FUWJ3eWd5?=
 =?utf-8?B?NEhYWU5YcHVRZnpRTS9ENXhqVVVMR0E1aVdxZmwvemlYZlROd1VudzFsaTVp?=
 =?utf-8?B?WnNYNkRKQW5jaUt5RnpEMlU0VUVYZ2w5cTF1K2p0clBRb0JXK3hCTGp0VWxN?=
 =?utf-8?B?ckVpTmNVT1M1RW5DZGlmYkNrbUpvQnYyRGt5eXM0dHBWRkdQYks0Zk5uK0FC?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1774e65-3871-464e-afbc-08dd2ff4f1ae
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:58:43.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEucJCJT1guGYrwAmk6MkNMh3H8kK7GswMR549SzUyygeJthmzErLcFUMqWMzoo1PiJbxsjK9zENSxIBgL58JbPkU/L/b2Lc9la38KqUSxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com

On 1/8/25 13:04, Moshe Shemesh wrote:

>>> +static int mlx5_cmd_hws_modify_header_alloc(struct 
>>> mlx5_flow_root_namespace *ns,
>>> +                                         u8 namespace, u8 num_actions,
>>> +                                         void *modify_actions,
>>> +                                         struct mlx5_modify_hdr 
>>> *modify_hdr)
>>> +{
>>> +     struct mlx5_fs_hws_actions_pool *hws_pool = &ns- 
>>> >fs_hws_context.hws_pool;
>>> +     struct mlx5hws_action_mh_pattern pattern = {};
>>> +     struct mlx5_fs_hws_mh *mh_data = NULL;
>>> +     struct mlx5hws_action *hws_action;
>>> +     struct mlx5_fs_pool *pool;
>>> +     unsigned long i, cnt = 0;
>>> +     bool known_pattern;
>>> +     int err;
>>> +
>>> +     pattern.sz = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto) * 
>>> num_actions;
>>> +     pattern.data = modify_actions;
>>> +
>>> +     known_pattern = false;
>>> +     xa_for_each(&hws_pool->mh_pools, i, pool) {
>>> +             if (mlx5_fs_hws_mh_pool_match(pool, &pattern)) {
>>> +                     known_pattern = true;
>>> +                     break;
>>> +             }
>>> +             cnt++;
>>> +     }
>>> +
>>> +     if (!known_pattern) {
>>> +             pool = create_mh_pool(ns->dev, &pattern, &hws_pool- 
>>> >mh_pools, cnt);
>>> +             if (IS_ERR(pool))
>>> +                     return PTR_ERR(pool);
>>> +     }
>>
>> if, by any chance, .mh_pools was empty, next line has @pool
>> uninitialized
> 
> If .mh_pools was empty then known_pattern is false and create_mh_pool() 
> is called which returns valid pool or error.
> 
oh yeah, sorry for the confusion!

BTW, if you don't need the index in the array for other purposes, then
"allocating xarray" would manage it for you

