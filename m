Return-Path: <netdev+bounces-116047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA4E948D79
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77052B20F68
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD01C0DF9;
	Tue,  6 Aug 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuKUfD6e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34C143C4B
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942798; cv=fail; b=ZRI41raE8R6BpU1yvZqMSDnZbYgb87bo0T/9QUxeiKIrUy7gRf2PalG5wBIjbD+is5brfbXNKu3ho2u9cJI98J0mByNZ3a5qu2d6i+rhHYOubs5/g5sr5AHi1oTt6LoNVnQWe9t0zqHK74zotr3LWz00ECqSYbdqsLivEX5ujOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942798; c=relaxed/simple;
	bh=F21Rw8walXQJQN/YUAVbOe1paBvjOMqXPlscCcYTXF8=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=I9mPDfURnXH21GTFXX2YA6GXwUGrUSYvQ6cgwmLnh8Tw+YZklgmVAPy7CsgkBMSWy+VL6RjVDqfRbiXaihjvmx+G9VonvM/ATYYhyioDlsEHWk1gklRGWEM96SSHtFTw4uUNPou7uXd+RBhP7SuJd9kOzu9d2u1VYVHbexzQ2Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuKUfD6e; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722942797; x=1754478797;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F21Rw8walXQJQN/YUAVbOe1paBvjOMqXPlscCcYTXF8=;
  b=QuKUfD6e9a5hYdkDemEvLK/xd1PEPrT8Ut/88Q1giyAYqO0XDvuyiT0K
   VyxJyO7nydx1jRg1i6EMgt3qNT00+4h8MfI5mHkg9+g/+j2xhtn7O1Odq
   EUUHN+WpdvL3y9TQcfmlg1gnAXMzehoy4fDRsQ3p4YX2S8uP/KyD65E1a
   FgbAMT2AQr0KZz6MuX15HlbAXXHJUDWb+Hdv/5VEFbg6Dx3SFsLesxdmj
   PSMqAQk0tDBOxkf2ZLb/vbND1CdF3FR7IFSYErasVrG0ubCTCHPHXt45R
   mrwhwwZzrCCHiJv1sNkKVleqXWb4TurXW+7ZP5InAHRwpHk0/SK3dLEJT
   w==;
X-CSE-ConnectionGUID: OyvC2EbLTmOB7rv80r46LA==
X-CSE-MsgGUID: HunvMvoEQMiiha4Ql5XDYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21093331"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21093331"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:13:16 -0700
X-CSE-ConnectionGUID: 8DIM1WSwQ9GGQmW219Kubg==
X-CSE-MsgGUID: /5YCjlVNSGmqOQBTy19h6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56698484"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 04:13:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 04:13:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 04:13:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 04:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDmvlortz1G8dZ1DwBikn5L7QU/zjdm8bIGJ3rSvUpp7X1tcjyEUcG1B3oIMtagpx6Bw04/MiqYdss21jiV5kLd5XXeGIEzYO4g45jZWGhs3b2RIx45p6tQ2/kDdTCrdCCR6+iUljPhdVQ7/kofY0IKXOahKZkdoHvzGc6vaTRfjHBWZvm3YDvMeI3eHToxyxRIYX1VR/5xU5DQGty9wRSrGwMZcxjKWSFLqUkaGPkaidudpDXxm/wnFOF0QBUjULkHKwgAvTqVNNX8hbJ8wVYN0Nch7x+86Az4L+LP87lX8O5SSTHkFARIQkM+TlB1x3fnVnpZ9ETfFcmLdRap61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocWJmJ+pXzBdv0QIRzEtMdfI5RIgr7BCle0wCNTiPCY=;
 b=zJIgQ8TACk87WVZWu6HSvWgiu/NN05u6fXnc5utgb/X31RFch3ruOm2p+yh9cajDNIwjafmUnLRUHsA5rwUO14VE7nqleTT2RoArfNyTa3zIHKCnXXfRavBY67AJbf0+BrzuSGQkAlesQwil7YpNoDPLtnCXxRaunShkFu3p3Coq8GEycjFNAFUpqeiZnRZ1pPLsSbOtHvClqaV4t6KV++TUQmSV1ziy+BBkYI3uC4bI9DK+Z8aLZr5essHcAQklqZ3sWj4d+EflzJxfl6hAdk9e1Wtvh4iiSbW//K34Nyj3E39ieqK8Rlqfv8/RetnTE+MDIZYGYioLjV4AIBAdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 11:13:11 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 11:13:11 +0000
Message-ID: <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
Date: Tue, 6 Aug 2024 13:13:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
To: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 72978000-07d3-44fa-8f23-08dcb608c24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUFiSDh4UGcvR2NUMWFsQTZkaEJOZ29mREJpTGZwTGlONG1WcGRmMFBKYjRa?=
 =?utf-8?B?TUxuZERwSm1kbVNRUDFlMVRrbW84SkE2V09RTXYwWUIvb1FvcmxHaEUwL2di?=
 =?utf-8?B?elhzMk9aOGtQUjU5NkdzbmpQSnkweEMyclZ6NE5xajZvU2FZOWI5VE12K0tM?=
 =?utf-8?B?bUtabmFOem0rSHJIL0tIY3F2SzBTZnZXWkU0TkR4MDlmTUh5dkliN1ZYZVBH?=
 =?utf-8?B?TEJZbEx2TXk0a0hqa3ZTVHRHQUlLdFY4T1g3Z2U3ekZEVWVVSlIyTk0rc2JF?=
 =?utf-8?B?MXFWZ2EwbTNsdHFpRHExeXJLQlZ4M3JDbzRWTGFhOVIzQ2hiVGxyeG1Rb0Ir?=
 =?utf-8?B?eS9VVGVrNGVMbUVwYjhYZllnMVlqTzNjNUk4YjVyZ0J2WkVvZ1VpNm82L0ZM?=
 =?utf-8?B?UmlpeUVvVzd3Qnljb3d3YnZEUTlPWlRva0tLWHEvdmwrek82bUh3cTBvRzU4?=
 =?utf-8?B?ellTcXQrNWRRdCtrajhTeUhINk9Hcm42RUxjeURucnFabmpheGtQVmxxMWxh?=
 =?utf-8?B?cGpIb3poNTA4RW93dGFZNlBJVUFMS0xQUmtYKzZUWUpQY1ROdSs4TzA0N09O?=
 =?utf-8?B?ZEd5WUdiVmFnL3F6SEdnOEZIOVVuL3JUc1ZoRVNEY0dEcUVMSWdWa3FjTHJu?=
 =?utf-8?B?T0lPem5lMlRlRzR0cFdKSGFPeloxL1RJelh1SlR1RFpzaWhjYjZTTzF1ODlZ?=
 =?utf-8?B?WVJielg2YWpVUEMrVjNPeHBNZVVkSmNWTE90RVo3QW9NZVl5LzZBckRKRkdW?=
 =?utf-8?B?MEVTU3c1VWlIY29VUlVZNzlJS2RObFJ6RnJDd1ppU3dpbStOT0pHajVNcU5p?=
 =?utf-8?B?Y3VuUUZoY2I1Z0NWdHBWVGFaWEg5L3l4N0l4dm9FVjltdk4vZk1CSkE4c3l4?=
 =?utf-8?B?NmdaWEppU2lSYldxNzNWcUI3SzlpRjJndTFnbXZyRTdaUnZlc0ZlUXZWcmhU?=
 =?utf-8?B?RmpnL3l5WG1tYkY1bzVTeTYyNlJ3YVNJZHBvQUVUcmUvVEFkUTdkSHRYOElF?=
 =?utf-8?B?T21jbGhtY1p6NnVGcFd3bW9kejI1NnVYNE16L0dYN3gvc0t1ekV3M0NseDhs?=
 =?utf-8?B?dkdTWnhBazZBbG9MUDdZU1J3MUdTNWpMMkRNWnFJZlZkUkRwMXZwNWhGVUNs?=
 =?utf-8?B?dmtySE9PSWgrQWc1aHJXOENpWU5TQUNYVnJxK3dpN3pxWGx4dXhZQWh0RFVk?=
 =?utf-8?B?MnlpWlRnaDI0ZWNQMWU2V1BqMjJRUjAyVU5VcTNVS3lrUHRKNlBGdENFUHFs?=
 =?utf-8?B?Rk5SRk5QNWNvUk5uZENFK3ExMW03OXIxRW05a2NORmNrakZLOHVDY2tLNjc5?=
 =?utf-8?B?eTlMb2hDdmFWd2x0TFREZDJCQ1gwa0trblkzM3lLOFoxNXZSVUV1OUUxaVJ6?=
 =?utf-8?B?U1o2NnE1Zy9Oa0o0LzIwTkZRRnlrSEx2WHJBYUkyWFowMTlzL1gwMWZFdUc1?=
 =?utf-8?B?a1RZL3JiMnhYVVRJTWsydkJBU3l6dWxsZ21TNGhjS2xZR2Job0tRYnNXUDNn?=
 =?utf-8?B?bDdGOWpFRThvSFQycmpCR1J0bVlkYXQyR0I0c2lFKytFNUV2VHR3c1FqaUdh?=
 =?utf-8?B?Q1FyUFl4TXc4ODBYZytRL2xVdHdweUprM3hmZ0lzZ01VNXlPenNlbEFCcmlE?=
 =?utf-8?B?S3d2QkJEUUFhYzBnRlVJeEdlckRzMTZHdTcvTmc5TjNCOGFPUFZqNytxdlFC?=
 =?utf-8?B?NEs0TnpRS2hxaG12UktuczdRdXRMSGVNSXlVZmlJZ3ZiTGFoa2JYUG5VbWFh?=
 =?utf-8?B?alByQ1pFRHNRdjAzMGFWY3U0MmtaZEJZZzRHWVNpd25zRitQR0FDcERaa1Ar?=
 =?utf-8?B?dTZQYUM2ZC9KaU4yc0Izdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWt4TVhKSWQwcnkwdDdzNXFscGpKWGRhRlJ3ajNNcFBieGVvN2g0WU1CcG5K?=
 =?utf-8?B?S3NYbEtUTExBejF6ZndqZ2V5eGNqVnYvRmRhMGtvK3R4cmZrRlUzc01xMGh0?=
 =?utf-8?B?ejhFeFA5MEhCZHcybm5GK0VyM2Z6aExnUVBaWVNsVkxqOFJEaDNGZ0R6WWFj?=
 =?utf-8?B?U0wwVU5tbzJ3emszaHVLd3RuTUIyTTQ5ZzdaREVXNkZaTlN0Qk5WOStwRG1X?=
 =?utf-8?B?bUdOT3BHcFZ5TGNLTXp5OHhwanQyYWw0ME9obWxzbzY2NWx4YkhzYnpDK09u?=
 =?utf-8?B?NGR0L0xsRWpkWWNtSmJPQnRvR2w2UDhua3R1SGRnTndqZzUrVXk4TWFTMWJT?=
 =?utf-8?B?enBXb21XYXNHWnJFSm9YT0hNYlovWnpHVUVQS2M1aHh3eERmS255dG55TFFk?=
 =?utf-8?B?NEVlNE9KVktZVlU0anpXaUlhMStwclFuSFVVaURncll4WDZDZ3U1T3FMT0xT?=
 =?utf-8?B?Vnc0c2Exc28xbTlrWjV0VjhIOHpnOXNmR2QyZVdXTzk0Si9YWWNVNU5WYzQ5?=
 =?utf-8?B?eTV5aGNJYllqbHNaZ2UxSEZtNGN6aUNwNXE3QlZJRnBFNG9heWlqWVIyUFA2?=
 =?utf-8?B?SHhRZXlObXVIaERqdG1USnJSRnFnc3JMejRjS0dEYkxqWkNsU2p1Z3dsTk41?=
 =?utf-8?B?SmhESitWcmFtV04wTjlGSlAwZWhTSnF4TFpCNy84SDJaTXZaNHdQM1c4blNv?=
 =?utf-8?B?NER2cUZpN1dpNnNJUTkybVRvYitURzJ6SVgwZXRVd3RFYWZvRW1LbWV1Q1BW?=
 =?utf-8?B?VEJFYlg4SFZ5NkFZUkRKRDNCVVM1QU0zTTNsZHQveTFxRmw0aDVzWWRzZFh2?=
 =?utf-8?B?VEFlT2tpMDdJczQxb3dnV2Jad1dHeG5Pc3JrM3Y5WHVLQnJ1QnlaaHc5OUxz?=
 =?utf-8?B?T3RyYnFWajNoaHJCdVBRbFBqbVRMOXlUMDRIMXdCTktaOGR2MHJqSmsvbmpI?=
 =?utf-8?B?TzdSMkQ2Yng4OFdMeGJPRGcraUJiRmd6dkphYlNWcTA3ek1sT2FnOGlyU1Qr?=
 =?utf-8?B?cDZpUUs4QzBOVDFNU3R2U3p5eG40R0kvbHdDVVNiT2psWmVGaVdQQThmZ2F1?=
 =?utf-8?B?ZTVVMnU4T2J1cDZlMkpkSEE1aFVkN002VkFHd3B5NCtUMFJwQ3BRU0cxb2lD?=
 =?utf-8?B?N2IvYksrUW5iZE1BMlBkODhNMDlYVENES0NsYXI1cmlLVEYwSUszWlJpQXJz?=
 =?utf-8?B?MUJPWFdFbU5uUXFEUDVYSWpHTE5hNkhQa0hyaytHVFJtN05Ba0xEVXRNRmNG?=
 =?utf-8?B?K2NYeUs1MVJRYU0yUnlqeTZvbEFzWjNNbHRFUjBmZ2czcmpPMDVTWEloTy8y?=
 =?utf-8?B?Y24zeDNYWkxnSTNCRXZPTkV6R1R4aXJEYkFDT0pCSm4vazQ5T1JqM0pDRVFZ?=
 =?utf-8?B?dllFU2lTZUhtSW14eDRZd3RyUThqamVzRjRreVNMS1l4ZjBKejVBa2dhSnR1?=
 =?utf-8?B?K0MycjRheG1DVlhBZ29YbkMyR1V5cTk5Tnh1V3AwOGtTdFgxdnRhYTBoUU5w?=
 =?utf-8?B?eWw3M2NvdVh5MExQQXRQSGVvSThoSVlpSWZCdytNdXVsTkY2dXhqYjUycVEr?=
 =?utf-8?B?Y1REUjJsQzEwY0M0THVPTHBpS0JsTHdIS0syNVU1aENvQ2JJSUxxTW84dllw?=
 =?utf-8?B?eDFaN1ZjcDBrYkpCbkFUa05XTGxCWm50dlBmamhpcHRSTDZram1tZ2loY1N2?=
 =?utf-8?B?eXFaV0VPY0FiNC9LdjRqNEVSNE1RZGpuUFBmQ0Y3QmpOMlEwdE1ROUtxbDJK?=
 =?utf-8?B?S0ZWSjZBQmJsZUJZaC9kZmV6ekRPMmZkOGwwVUZRUTRBY1ZnZGlpYWpiL3FS?=
 =?utf-8?B?aC9yM1hHZW1Nb3hzTDZpN3N2SUpxc0ZPeFpoSnVlaDZ6aUVMMlZnbXRiVnhD?=
 =?utf-8?B?enYxbmJsN1VoNFZrRkRuQ3hRc3ZQc0NQODltRjRaU2VaLzhmZTdid3dYRlkz?=
 =?utf-8?B?NkZhV29Cc3YzSzhvT001YWJtNE1tbzllWFZwL0I2eE5JZmRQeCswRHNvbCt6?=
 =?utf-8?B?T0NIbDF5MVVLZzRYemJrUTJlYkJYQk1BYkdiZTJ2dWkyMVZJREgwQkRpRmxR?=
 =?utf-8?B?eDJmS1dkSTMwNy9YNnVBdnh6bFo5eWNLYnVQeEl4T2d2NG9YSXM5YWlLeDl6?=
 =?utf-8?B?Y29nWHgvRDl4d0FuT3l2RDhjbU5xQkw2cDFSaVBtS1RtOUtIREw1YVRDOVlj?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72978000-07d3-44fa-8f23-08dcb608c24c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 11:13:11.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axh2TqqgGsJUuWKgjtjN/loQQ+b9G2NQQS3YGyKs4UHZzBqzYevwqd6JdvYpNv/1fDq49BQQV0sXHGOZPFUtSxTu9zq/O3BWjQYGYaqiVQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com

On 8/6/24 10:25, Mengyuan Lou wrote:
> When use rgmmi to attach to external phy, set
> PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> And it is does matter to internal phy.
> 

  107│  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit media-independent 
interface
  108│  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal RX+TX delay
  109│  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal RX delay
  110│  * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal RX delay

Your change effectively disables Internal Tx delay, but your commit
message does not tell about that. It also does not tell about why,
nor what is wrong in current behavior.

> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")

This commit indeed has introduced the line you are changing,
but without explanation, this is not a bugfix.

> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> index ba33a57b42c2..be99ef5833da 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> @@ -218,7 +218,7 @@ int ngbe_phy_connect(struct wx *wx)
>   	ret = phy_connect_direct(wx->netdev,
>   				 wx->phydev,
>   				 ngbe_handle_link_change,
> -				 PHY_INTERFACE_MODE_RGMII_ID);
> +				 PHY_INTERFACE_MODE_RGMII_RXID);
>   	if (ret) {
>   		wx_err(wx, "PHY connect failed.\n");
>   		return ret;

