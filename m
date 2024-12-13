Return-Path: <netdev+bounces-151822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545339F1133
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17D02828AE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C61E2306;
	Fri, 13 Dec 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzzX1cmu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCA1C3BE7
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104644; cv=fail; b=boLKE4Hk6HBMEDmmyrI6GdPUxnAnQcN+fu93XLf8uHhJ08IkvKQiDmXYCsPXeAAGKk5wMJHp2rqVlHKpxbUCfuHH0HCh9w1gcI8in3mCO7XHHqUgprJJbxmHhTLTs0vPpnAiNjLsSMkACyqodes7JbQfe+a4uhhaqKEJ5Db70RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104644; c=relaxed/simple;
	bh=ZXk5BDQZqnm2F1XWyfChM1y6fYR2CbXZOslXIciqpTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2Q51gkoObzhFJRbfdDbfLidWwe9H8/uziMgQL+p8+8CDbI0xjfvro/5f1DlaqLukxGk9Q8CbJUFPsXJ+e2DMRofJGxFSg3YhOABKBH8XrJQ5UlNcyi/YXwpgink6Y1qwmxZJihetRaQGjf88J5jWYHa37UrjR6zQrk67QPTd7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzzX1cmu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734104643; x=1765640643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXk5BDQZqnm2F1XWyfChM1y6fYR2CbXZOslXIciqpTI=;
  b=dzzX1cmugL7InKc11wuaIpb1TQt/fdL4xQU3imQFziNFc1wI/gy+3g/S
   Aq12EYpKc1bTTVxow6wzkYilSimdki/eW0LM2dqwoxGDOd5xTgNOJ7Ywt
   A3Mic41DqkUYRdOdpzzwQeYMuJzwBfj5dg9PHGPNmqO6u2MKIAEW+m36D
   RM+Aor2jmRLyD7lz4INrH2yygzZve2dlKHr7UyovQ2+qG4weqozbFTlJc
   pXpPgaIphNGfd/lXNtvU2kWdJslmANE3vL1+VWnfW56+CJ+E+pndxDucQ
   qzIJ5c5hd5YthGWLObeKM8wx3ipKo/rqakLTvlLJDrgiPdSKkXNKt2d+U
   w==;
X-CSE-ConnectionGUID: uXKIVtMgSOCxsXa7wBJxYA==
X-CSE-MsgGUID: OqsLVDQET2KKRsM8P7xP7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="37406720"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="37406720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 07:44:02 -0800
X-CSE-ConnectionGUID: db3VAEfUTgKKnwc6sa8HvA==
X-CSE-MsgGUID: fLIBETmvSHyrrF/ylE2UHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101145445"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 07:44:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 07:44:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 07:44:01 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 07:44:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7NGoujo8uuz23wKyyfajuiBGs6o52kgzUergQYyxssjyDOQkThqsIsmokTf7iOyqVSOHWZea938Lnq6g30TIrI/E9H0BFXuEic63kPIe8IYXnG+mGTeLPyg5lbjhackmda7ONzDQEPzDpD37YAEMFDYWNx9sZMDwTbhyl+41JBx44FFh0MN7QEczhAuzjDwzja0XYlto1IM1umOGPMSu1C/NfGv7EFo3Idq8Jfy1M/mCJNKLKIxeYRO3hX9/2LUnyaVnhEXdeCN7dY6l50j1xjZ5PEbUsytbW1BIDjLyFAmVhohfH/R8zNoY9g35Z3J1kqp5WzDoigWRtfuJgQX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFPmIB3X3BkVk/kerCybQb0UtwL3lWHzC4Eo2uuZFL4=;
 b=y40Aw+QA6bU72C3lHyLBs+n9QkEoVJNR9WHGdqNkvA1/rtfV1Qgw7f7zjsUsapAH5sz+Ac3o4ELuKPOTsO5O57Lbbr1DSu4YngyAfzOuLvv6h8FaxQguuDtzJNNIQy7BRPgMeEHDToBDoV6TjgoPWovHNr+lqk8YrR2iLhvj/zzUvfiU76O0SzTCs+RqeiXtRDL5v8cjFCDKPOsWAoNKYdcvmyig025N4D/HrNp2Y8fLS+4SS3yV8pAYJ7qhFGy9P5ILjFScBFyVxncTlOkWbrWYc2gEnDn3UfalHytgyxfCjw3iF3FKGVdBqqbFRrN070L+/ExdJi1PqTGG3uabEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:43:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:43:29 +0000
Message-ID: <1e4cbdd4-691e-45cc-a2eb-c9ae76cc88fe@intel.com>
Date: Fri, 13 Dec 2024 16:43:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: rename page_pool_is_last_ref()
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<asml.silence@gmail.com>, <almasrymina@google.com>
References: <20241213153759.3086474-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241213153759.3086474-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BN9PR11MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f21bfcb-a082-41bd-b6fd-08dd1b8ce3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejJEUEJWSHJSRm92RFFBSkZpOGtuV2wyUkk3SU5mNUlmRDl4cVpWYUNpcGZi?=
 =?utf-8?B?Q25peUlCV3ZrYnl4RFYycWxSbnVDcjZyY1I1RGg4c2Yxa3Vnaksyb2QvZTJI?=
 =?utf-8?B?USt1dXR5VzdPR2FsNlhNL1kwNVNteldacTYxSTZBdzNRZG9SaXVHRTM0b1Bu?=
 =?utf-8?B?RXJ6VnRKemhnU3ExWC9TR0NtNWtpcktrSWVKeG5ZckVBOTVpdHlrZHlMZ2dG?=
 =?utf-8?B?bG9QQno0Q3VQL0RrY0taWW5zYlRZblNpSDZXR1RZTDlUSDY4aE9tTFZ0Z3pK?=
 =?utf-8?B?dmpHYU1ZNlBQaWF0VFp3ek1IZndQQVRxY2JEUzJZdXNESTJrYyttcE9UNEFR?=
 =?utf-8?B?dDRTZnJrbklTTzFWNktvNjdNUzhsTlNwd3lYbXNsZTU5NzJ0bUlkSU1LbnhN?=
 =?utf-8?B?WW90THQvVTB2SHI5MnNPNVg3cGRacXNtR0crRExiZk54ZWZrMExFa082d1dW?=
 =?utf-8?B?ZnhWaDNBVURMTUVZYTgvaTZyRlZWcjFnbkREdFpnR3VJMXA0QlZJOWtJSUtk?=
 =?utf-8?B?TlhvWGs1MVBjS3NrdnFhcW5MMkRmbEtMaGU5bC9BdWxkNUQ5cUdPaStHbVNj?=
 =?utf-8?B?MVhNNTN3NVBPa3Rad0FDbnMrNU9NTVlrV2xuY0QzT1NTUFhNVFJtNFJrTGpP?=
 =?utf-8?B?RDVpQmw3cWlUZkhYU2tRQVR3YjNvQ0g1dHMxUENvQWtVWFh0SXI3eWphNGJD?=
 =?utf-8?B?eE0wUnBPeTZJU25ZRUlaY1NoL3kvQjFhdEtNZFRRMjNVUWZ2SHFCWlFoM2di?=
 =?utf-8?B?djhrOEtBTlN4WTBDaXUyTUNXK2ZycXIvT1NhMG9LRitkMllSTGR4bHlGYkR1?=
 =?utf-8?B?ZElHdXVRZFBCbk94S05LL3NObGxWTUl1bVkzTkJ1a1U1WUxGdEZXdHVtZzcx?=
 =?utf-8?B?aWMrY1N5clcwUlhIQnZKVERhcEZBWXppOWcyVC9WQzRyL29tNEZvS0Iwamhm?=
 =?utf-8?B?WlVDYk9oRWloZHhWTUJsaG81YjNLcVZxdVpQQmNmTVJsNHAvY0d5M1ZBUlR1?=
 =?utf-8?B?NDRmSlVESDlzMm8vNmlPN0h1aXE1N0czTjZ1MTliL0hQM05lUGJjYVFhdUdz?=
 =?utf-8?B?SmY3SEZWT1dsS0Z2Y1NCNlJTdnlXTjUwTHZMTFRZS2FRb1hiRUxENnNFNFU5?=
 =?utf-8?B?WVhLdzA0eXFZYlZRNXAraGgvY0tJTnhvUitneVZZVTJlbkN2cFpnUGZDb1FZ?=
 =?utf-8?B?azNMTnZTSUgzdzk4RXFkbS8wSWcyRzkyK2NDVUhRTTFZRFR5V1pPT1RIOXVR?=
 =?utf-8?B?SXJjWEFxOE00ck1Fdy8xOVZmcXBtSnNoWDZ0clpLalhZTlAwS0ZBalg3clc0?=
 =?utf-8?B?dDByVXpXVlhFMmtsclBEQ1JvREVlSVJiSDJJcm1pMFVsWlBvR25GbkJHRVR3?=
 =?utf-8?B?c21LcHVPLzR4Si93Q0NVVGVCYlhtVVRsTU04L1NmOGY2UjhlcVNFZFNQLzZX?=
 =?utf-8?B?SHFTanFyTk8yZS9BbEIvS0JoTnpGMCs4UWNSbkdvbnN0TDYyYXZBckVCM1ZN?=
 =?utf-8?B?RVpuRTVOai9HQXRoNW8zSWtXUWtUSFE5Z2xVZ0dWeHBBNWNVakt4V200cWhu?=
 =?utf-8?B?VEtjS3BrYzhZbkRvUTI5QVdyaFpFMUZQc0t2SEYxNlBQK0JvNDNoWWsxYWdI?=
 =?utf-8?B?dmVnOEpBZ0NGZ1pvZlpFd0lJN2E2cUFYbWtWL1YzSUxoN3AwLy9mcTc5eXlF?=
 =?utf-8?B?Rk9HdGdEbGxZcmNQY0NHYkRzd0Z1YVllVldHa3JKS0UrMk9qVHFNOU5xeXF4?=
 =?utf-8?B?cFVLTlhYM2V3M0hoUXFUZXNsWVJTaUVONVZlRnp2RXE1S2x2am4yQnFVUnVn?=
 =?utf-8?B?ZW4xR2UzckdlTFk0MEZjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJHTGM3cXFKTk9Ca3hybTJFRTFPSE1keWJrdTUybERaUzFSTkRFOVVNNnJX?=
 =?utf-8?B?eU4yN3ZmbU5SKzg4aEdMTnZnVkRORkNHMVVtNGhWVmVtYnZYVmRGS1FCeUZG?=
 =?utf-8?B?dDJ6ajNLZXYrNURoS3dsbUo5WFhwc3pHSXpOdTNHUVVZZndLOWU5czkvOGhX?=
 =?utf-8?B?dmZqL2pLVDZqeUVkWEhjcmg3R2htdWxtTXppUU1RdHFQQ3dVMjhJRkVtMXl0?=
 =?utf-8?B?TFgwSDZ1dlJjRUMwZjhyYkt3RDV4bnN0ZVEyNjErUTlaYndHM3UxQTNmMmVj?=
 =?utf-8?B?QXRKMkYzWVdTL1h3cmxMeE9NQk42NWU3UC80N0dhcmZmS2RNdFFFM3ZvK2hW?=
 =?utf-8?B?SEJOZzZwS3MwNitia0xMOXdBZ0dhUDRjMjgwWjFza1BqbzgrY2gvdGZmbHJP?=
 =?utf-8?B?NnBmRGd6QjVjSWVza2hjMGNaWlQyUGF6NGxUR1ZFVlRNWUVwUy9sTmRkUFBM?=
 =?utf-8?B?U1U3Y2x3NjBSN0N6QnVzUnNEMlQrZS8xeTBMSFM5bFdUMWVIMHZuc1JpOUdY?=
 =?utf-8?B?VFZscG5EWXFRSjRVQ0p5NTh1Q2VLRjg5djZyT1ZiNzZJcEFVWUp2dFpYVW1x?=
 =?utf-8?B?TjBKSHVCZUxJS3dmL1FLOCs4VHhWMWRUUzFvempibzVBTytIYmQyV2I3WkNa?=
 =?utf-8?B?czlubDBUN1MrSzZTNVpjQkxjbG1reTZ4RTR0dktBZVRET3luODNQcEphaVlG?=
 =?utf-8?B?QTFQaUg2aHN5cXlETGVWNFgrWGUwWnNhdDZzbXVOUjNBUWYyVjVRY0R5ZHdn?=
 =?utf-8?B?dHkrUDJ6OXdGWUt2dDFFTnJZblMyTDQySzN6UlFqR3l1NUhzeXRmOUw4TUVt?=
 =?utf-8?B?ZTlmSTlCRDRpb3JaZHpDSFVCOU9BZkNJQWpNdSt6MVQ3Z3F4Vkpkc0dQY1gv?=
 =?utf-8?B?VWpZWnhVbC9HenhNOVhFaFkwT2RxZldQS1hKKzB3dFFoSmlzRnVUc2VzQmRm?=
 =?utf-8?B?Yi9YZFQvSHhMSG9BT2lDcXdJSm5aU2ZOU2hydzN5UEhFQkZRQmJPaWJKN3Bv?=
 =?utf-8?B?ZDZPUFh5M3hueFcvY2Fkb0NiUzAva3lkLzRFZ2d6NGRuNkViRVpSa1Y0M1Fk?=
 =?utf-8?B?c0Q5N3hQT2xidFc3RVdBNldaS0psMTAvbVF1MllmRkhQRzR5bnp5VE4zaEFv?=
 =?utf-8?B?TkRxUytabjViNHZJSTJTSmtkc3JlSXF4UXhVMXlWR1B2dnVnb01HbzgxZ0hX?=
 =?utf-8?B?R2h0d0p4RldMZ3h1S0pCQ01YdGZCZE1LSFZya2RSck9obHM3REE5VDVUd2N1?=
 =?utf-8?B?MEIwVkJhM1FsanBtanpqb2YzZENzWVZ1VEs5cG93U0I1RHJScjdmWmM5VFIw?=
 =?utf-8?B?ODZacHZlUmtTTUN4UDZsMmplVTZjQU42MitTeVoxUHk4M3Q2NlRZMjNTajBQ?=
 =?utf-8?B?bHZMVGQxNUhnQ1ExdGZwNFdacmNhRTJGZDJkd1h0Tm14bzJWaG5XWDJSSTJx?=
 =?utf-8?B?ZmhQYUJmUEdvNjBoZXFZL202UmwxZ2tqRkNvcXNqV0pGRFFKQzloZG1tblNo?=
 =?utf-8?B?MHpNZVByMWRQOFk0LzlKSWQrTUFmZ1ViV3JndEwzS1Mxb2VGMmV3c0FZZjBL?=
 =?utf-8?B?Wk9ueldUaDdoWXBpVVcwNmsweDRvaXZmcTJiQWthSjhCUUdORkppL2dVYTFV?=
 =?utf-8?B?dGR2b0Y3TVluaGRGMFlucVkzVGRKVkxLSGVFOEdKQzFuZWtnOG44UHo2Mkkr?=
 =?utf-8?B?ZTVEVzlzT1VCYk9uUmR4SzhMenRoUmFBaXpVMzZqMXl0TEdzMGZVRm5PdFdo?=
 =?utf-8?B?R2ttbUcwTzVDVjlKNUlTL09LOHhxbDlTSlpsbElMUUtwR2tXeitFWVkrQzhv?=
 =?utf-8?B?OFJBUTVkMDRqUDBmQjNLU2JRa0NIek9rOUdUVjdHM1cwUDlBei82NEZPNUEz?=
 =?utf-8?B?UUJDOVNTTS9hSWQ4cFN6TUVOMDhxcGJ5RnNkeTdiZjdxRHk0S3BtWlFxTEZk?=
 =?utf-8?B?MVIrNmJHT29DMndOZ1NSdENWY2NKYlFPVXZHaGhDYkErMGZhZ2pxWlFtMnlt?=
 =?utf-8?B?ZDIxL21XN0lBeS95ZHVoTjBvbEFyZCt2WjNkMmlaMi9KLzRHRWZyV1hQTnhX?=
 =?utf-8?B?dk55TXJNOUNYNVRVZjdER2tWTEFGNGJ5QjV4R2tKU3M4all0TDRIUXNnNWho?=
 =?utf-8?B?dkZmbWhybDNZeHdMQmRIZFlzM2x3WXR3ZTZOT0k1Q0d0dlB5MnluSEVKYzZE?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f21bfcb-a082-41bd-b6fd-08dd1b8ce3c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:43:29.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p5X8jvolsJM/wG1f/iQEoulotDo63pf7X9nKe5cfMOW6f7yz5J4IeEVmAOuwgm7XqkwpjyuxVJhiFpBmYKFJV7RxNug/TmTbm5YeYXxsXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 13 Dec 2024 07:37:59 -0800

> page_pool_is_last_ref() releases a reference while the name,
> to me at least, suggests it just checks if the refcount is 1.
> The semantics of the function are the same as those of
> atomic_dec_and_test() and refcount_dec_and_test(), so just
> use the _and_test() suffix.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Makes sense to me, I think I had issues in the past with references
while developing stuff, as I thought this function doesn't modify
anything :D

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Hopefully this doesn't conflict with anyone's work, I've been
> deferring sending this rename forever because I always look
> at it while reviewing an in-flight series and then I'm worried
> it will conflict.

Thanks,
Olek

