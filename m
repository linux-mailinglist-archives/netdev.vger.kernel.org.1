Return-Path: <netdev+bounces-212618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75FB21781
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85223A4EB6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAF2E2DFD;
	Mon, 11 Aug 2025 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVvMRcdD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2667311C0E
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754948230; cv=fail; b=GYwshs5ixDnkcL10Vf3qPEdGUVw+W5zELBIDY2D5IcseWtUM1i+fXG/+uCd/36b5xr1kKIduIYbD9yVYKqHj8pG0/MEPUHRyRr7nzZ8tNbz/glhEHRGTFnUk2lU7+AtsG0rbfAhzf3tzVSjSFibsT5ClaFpcYRtok9kKjrYPo0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754948230; c=relaxed/simple;
	bh=jhSGqf3RDIydYgzJVgat26EFqnhjN1AVu2+gbTGAYn4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MtnaDdOKuplcDIc3Rm/a71Wzu4QiBpiujvt/XLpZhG+TVbaa0sw4VH2TeOpKyvaLW4pFpuMctq5quZbPBadyMK13D4paspPAYkm7y7F/WiMvORXezzoeUQi8uCjjO4FDFaj7uXj0DK9Lkk5KGDZbc0KXGaiYoIfx33T/1jNZRK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVvMRcdD; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754948228; x=1786484228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jhSGqf3RDIydYgzJVgat26EFqnhjN1AVu2+gbTGAYn4=;
  b=aVvMRcdDXpSHU+nFMKFg5AY7xiJh1PbufZsDfJh0RMg8nZKl6QmKg8KJ
   ZJ9aDIuZl8+eoCP3J6R/nnugij5b+8+EZaqVDJnEuPzjtSiTtboPSKqts
   x4i0p7ceQD/1vRiktMDUfyvG4dEQrNXF3RK9pXkILbmqlQ5NPl5UNkqGA
   wkGgCYqiVa0paE23MBtIP3PF7j4zywYBivtVszQHw9NlNUYmU6NbfyECs
   SI8WXxCFea9BIf0YhSYNMOfSYeYFUCigeuMJwmry09KMTq/YCo1j63z1c
   EXozEgjUligJdTCYpU2ylnsN4TMbLh4OUqzx3WuxUCop6YyUox62ETGhp
   Q==;
X-CSE-ConnectionGUID: HZToboeSRHq3D36Iwbtukw==
X-CSE-MsgGUID: /MJWl9D7RYq/sMNXJJ9XJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68289897"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68289897"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:37:08 -0700
X-CSE-ConnectionGUID: VwYHrRLaQm+tjccISAqCNw==
X-CSE-MsgGUID: wmWe0k94TTu267ymGinD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171371097"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 14:37:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 14:37:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 14:37:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.71) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 11 Aug 2025 14:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWdt9O1NwxnQw+27/ea1Azjd3NhSMS21Ks3YmFJjZrKSIEZWrdrA+4mgz4etPLVL85bxl2m485cJFLePcVjPJMzrIF+9zyMMlvd25ajONIVCjd5TSlzWLsijL528n8zsmF/lKlUxqWephweBiT88xJ42e2C/+GeUBv0bCC3UyjAZYIZ6UDkWi2Rode8M3TMtkvUx2Msqc6H8SqmeBKXJAceuNtLPTwaSNmBZpPV30qaavL22jnHAzRYduGpPbDuc1Dlja5pXF9/xqTSBeGOrUq91R/Xh27jgGU48tw5mjcx9equtgjd1lof2eig0WNWTt3tPkiKyIVVv2EdwJeKeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq0ZMTf0Cu4Epvks8QAf5V9UAPRO3yLc7vXBJf6ZzxI=;
 b=iQ469BeS/HD2w51LG/cLwqx7psmaAbP0+dsYNSDVIsapdLQMPniVIsOfHl9/tY5qOhavrI2lzskeWep/DDN3I0YglDCZup9ExREcS/k+2ERGcOJG6a1nsPTUnWCorWLa5XzfaDuG+DQmjxOLBoq2435wuoEH+buQsYBOa+I8rZrMsUDKjbDvA/TQJy0oMKlATAGZB/9Kj1EG+0Y1TkoejZkW3P94/f87jm7/xM7jeUIcKEreNqR7+k/6T5rXvEoIZsDIW66cVIO8dnMMqCq36+vkraL3t1F9KDIh+gJI05yFztW2zA8Bpvanck5Rq9tHhj9YdHrtPxEiVlm/cc7kYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM3PPFF2E67D388.namprd11.prod.outlook.com (2603:10b6:f:fc00::f60) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:37:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:37:05 +0000
Message-ID: <fe773700-40c4-486e-b9f6-5e2f2022596e@intel.com>
Date: Mon, 11 Aug 2025 23:37:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] devlink: let driver opt out of automatic
 phys_port_name generation
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<David.Kaplan@amd.com>, <dhowells@redhat.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, Jacob Keller <jacob.e.keller@intel.com>
References: <20250805223346.3293091-1-anthony.l.nguyen@intel.com>
 <20250805223346.3293091-2-anthony.l.nguyen@intel.com>
 <20250808115338.044a5fc8@kernel.org>
 <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <c8473c7e-0432-481d-9db2-656c3ad7305b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM3PPFF2E67D388:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ae7372-7e9b-41a4-8c8b-08ddd91f3789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2NkTFl6TllJSGNuNUxrTFQ3SGE4ejlGelQzdUh3ZEdsRVFSWmtFYzBqM1JS?=
 =?utf-8?B?QzU2SHJRV05xNCtxUE5jdUo1eGRndnhNTkJvM0p0WFhVSGZLS0gybUtNRkFC?=
 =?utf-8?B?aXFXV0RJdUZaS0lhWDI0N042UG9XTEYzbGlHandCOTQ2SGJIZ2wxTmJnZUxY?=
 =?utf-8?B?bkk1TlNiVU9xdFZ6dU40WDBSVU1YQTdncHdrd1NnWGdWZXVzbE9XVEhDWklL?=
 =?utf-8?B?ejYvK3ZqeFQ3bUhORWpEUWFRLytPN1p0VjBpMXN2UGM3Vkc4YXdiY0ljakFX?=
 =?utf-8?B?RTRRL1dFVlhkS1MxYTBPYUpsOVdmL3NtSHRqb0FHcWJvMVJnN3lxV1JxVHVa?=
 =?utf-8?B?bUhsRHB5Z2tnM2V6bFVvOVo2UjNRS0xWcDZWSWh6dlBpTEVGUTR5ZHFrT3VN?=
 =?utf-8?B?aHEyNHo4bUlkVUE4YkhmY2lCME51WTZrczRGVXdCa2kyWWFwbVpCS3A0bm5q?=
 =?utf-8?B?LzJPZzNpMG5PcDFIZDY3RktZUU9NbmNvY0U0S3JIQW5GQ1lQVGd6ZEpjUkdZ?=
 =?utf-8?B?ZWo4bW9lQmp5VEdPRklscXBjd3pGTitOcTAzcHRtLzJXZjhOZ2RrUDNMazdw?=
 =?utf-8?B?NEdWbGNCSE4rYW1JMUtxa3FpVlhVd3pXdkd0MU5aMW1XTGxWUFptdGo2cjZF?=
 =?utf-8?B?K2d3WFBUblJvZHZ2aDFVaDdKWi9aSE1kMDk0d1A2aHJjY0wvZjBYT3FCbzJP?=
 =?utf-8?B?SXpWUXozcGJIVkdOR2Jab2lBbkhVNFdCbHlmUnBseVNiUyt4SXZpenFudXhJ?=
 =?utf-8?B?MnB4dnJsYWJVYUt5MCtMZjBvekNqZXRvTGxiN0ZwNTh2MStrNW8zZFBBcW53?=
 =?utf-8?B?MC9JNHRXRlR6ZWVBRk1ydFlZd2ZLZzJTL1BFQlhlY1V1eWxVbTBWbEVXRjda?=
 =?utf-8?B?VUNFRnBwaFBhUnNyNnVrTGt2bUxEYTlSVG5zODdSZTFQOTNkVVEvckFHVFpX?=
 =?utf-8?B?Mmx3RjMzb2I1NkNLL0JTSmt6RFo3RUNUWmEzZVFlcUhZc0srTTgxV2JQM05r?=
 =?utf-8?B?aCtOUTZ4TjExaE9TK1kxMEo3VUd1Tmw3aWRxZ3dibW5hYWRPeEZ2Y0JEb0tM?=
 =?utf-8?B?cHBweUxkaDVacG90bFc2U1FCMzU1d0NmK2gyME5OZkpLOU1jV2FLb3F5YU4x?=
 =?utf-8?B?SE05bjlRQk5XTStwK0t3QXBiaWh4eTY2MWl6c2RZU25qUmV0ZVZQNzJXenN0?=
 =?utf-8?B?RmpRRmZvb1M0THQ4MkxxQ29pMmFuUUtzNkQyaWs2QUttRzBqMEYxOFFVYWtL?=
 =?utf-8?B?MWVlcGNPNHF3aFBwZ3hvcHBZZVhWeUlMaENJYW05M2NIbm94eGNNcGxCajV4?=
 =?utf-8?B?Vkd0TGlvaTVIWjN6SDVnS3dablNTMnlVM0R4OTFrQUVVQ2FGN0s1bFllK2xh?=
 =?utf-8?B?NE16V1kxUEtuMXA4MVBiS3B4ZDhGYUk0MW9CeW9MbmdObjI0ZFUwQk4vTzlH?=
 =?utf-8?B?MlVENFdJbVRYS2JnSmhoRGN0UUFJOS94dzlTTE1ibkVBMW9rdG5OazB2MlJR?=
 =?utf-8?B?YmdmZEZDR3BzankxTklmOGw1c2pCdUhsQzBHVElOT2NUN1pTb2RXTDhOTDU4?=
 =?utf-8?B?ekduNjB3SjN2TGFyb3pBaWxjeGljc3UzcnpVcFR3VjRsejhPaDNDYTdlWlJp?=
 =?utf-8?B?WkxCVWp1ZDRDRkZud2xKdDBuNzNUSmFqUVZTNkhkMDNjckI1S0Z2cDc3WEFo?=
 =?utf-8?B?R0VXMkc0RWRDMXpQOWRnWDJhbkRRc0YrNU0rRDNsZ09vZU96UW9WYnV5bDRh?=
 =?utf-8?B?V1ptUlFTdi8vdmdLamJkMEFFSGxIOTBnYm5WNXBxUkRpaWEvRm9UYUhJOElS?=
 =?utf-8?B?WDJoTVdXRzBWTmpVdjJrL09MeU94NGlMNGlFYWhsenc0ZXd1a01ua3R2UnMz?=
 =?utf-8?B?TDMwTXhTOXpzZDZSOWRLU0I1U3MyMzh6Wlo0UVp0UGRnQXBvRWhKOWNodVZE?=
 =?utf-8?Q?Cyn9LSN2OD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlJSblNhMllOSjZVZkNMNEhveCtDVFNQMWRoN0tiVWFpV2tCbTNBQ2R1WEpa?=
 =?utf-8?B?S0djNHVDR2ptWE1vVWVHYXc1NWdLbWNtVVVhbEJxa3BJMDA3ZHNqbnRsSHEv?=
 =?utf-8?B?aitYM3YrbTdvMFdoVDAzcllRM1J1M2NzVDhPMVcvVEpZbSthbUsxM0k4elBx?=
 =?utf-8?B?akQ4N1hCRFllZEhoODhSTTRFeXlBMHdKVm5WYktvZDRTUHo1VmVmaEtQYkNs?=
 =?utf-8?B?N1I4bCs3TEQ5aUZHaWFEZnFodzVFM1lDNVM1VkZGdUZxMStCVkE5SjlzejQv?=
 =?utf-8?B?YzFmK0ZodTVCVGNoWHV6a1lYNnFCbEFpZG12NWFpRllkeTBGNEpBWjRkMFRk?=
 =?utf-8?B?TFBHTWp0SHVOM1h5RUducjV5b2U5aWl3Uy8zRllkdEZoaHRWUUEyMk1jZHZi?=
 =?utf-8?B?RW84V3ozUEJUN3dMdTNQZGI4ZU5jODVTZHgwNG8vMWVFa2wvV00zR3BheTBY?=
 =?utf-8?B?YWV3ZU5SNGpjN2lyWE1sSmRnS2taV2RhamFHd05VQ05uenRhdWtNajRrRUhL?=
 =?utf-8?B?enNjaVRyd2N6QmwvWXY3c0NhbG5hYUdJNWRWQmYxNG5yV2g2Ukk0bFVjQUU2?=
 =?utf-8?B?UG92TDc4dllicWtkMmVxVldwU3NISU9DTWRHR1p2dHJXMjJZbjU0UGFHTlR6?=
 =?utf-8?B?dm1yS1VYYlIzdnQvUzlJamRJNlhTMU5vNXFrL3NUSm0zWUdUUU5WL1pUT0RI?=
 =?utf-8?B?TGxuNGY2czcvRzcvYjhoeENyN09oWDY0WjA1bndqK3pPNWhsWHJsWGFZQy9P?=
 =?utf-8?B?UnVMcWg2dUtJVEExUEtWdzNYWEJCcy8vdG8wSFIzMVZ4WTdpbEY3bGx6SHpk?=
 =?utf-8?B?eko3YTJ1RVlTRHFJRnNEc1dOZm54c3ZaTUxNbCt4M3ZFMG8zRHBoV3ZZWUZB?=
 =?utf-8?B?d0sySU1KeElVZ3F2UGtOT09ZWERqK3VYOXo5UTFwZ0cyV3AvSnVrbjNIbCtw?=
 =?utf-8?B?aW56SWlKS1hsL0RmSGJBNDhNdlRDRnVJVm1QQ0k2Nm5zOXNZUDZUazZVRnZ1?=
 =?utf-8?B?Nm1CcHJBdzdSNmhkU2t6QmdCanhUZ05IYWo2UlgwanVUZG9qS3JXSWs0NllX?=
 =?utf-8?B?d1dhWk9kRENXQUJZK3QrL3hlRncrZkZkUHBQWFV6VGlodkYvcWl1TFBjSUUw?=
 =?utf-8?B?VXNVN0hxdnJsamtZTWQxVC9JNmVRTlZOYm9mNTNMN2NqUFFLZUl1aHNPZDUv?=
 =?utf-8?B?a3B6Uy96ZFpOTVZacmIrdVNlRk5ka1J6aVFSdkthQ3pIaElOUGZWZVlRendC?=
 =?utf-8?B?aUJHZ1FNNDgxTkVCTEx1Ujc5NjNpdEFGWWpaOThHMnZIYjZ5dkh4Q3dPTEQ0?=
 =?utf-8?B?dmlQT01nSEwxM2JOcFZ6eWtkbjlIemZKaWJlR2ZhUU56dDJ5aGZzdVV0UFU5?=
 =?utf-8?B?d3hzMzU1K0RxTjgrb29UN0hneWEvM0dtTFptUEs5N2NWRkEzaExybjRnVlBs?=
 =?utf-8?B?REpzUWwrWFRIZG0vS0pGR0IxR0wybWp3MXVaRkVwSFQ4a2swMWJDazFPcEhL?=
 =?utf-8?B?WWY2aC9vYTZsWFFPMGpZcWEyV2FaWEpoQXU1UTFESXVwWk4veGlhbzNaTTF2?=
 =?utf-8?B?cE9HVGNiemM0Q3duL1ZNenlyZmxtK3dkakV0ZktLUlJ4WkY2ekZSR1RTd1Fa?=
 =?utf-8?B?QWpyNi9qYUtrSks5WWxScnVFY0I3UnA0OXNzUSt0VEFXNzFXa0hINFN6cURl?=
 =?utf-8?B?Q0FydFFzMXB5aktIT29nTWlWV01WNnZiZk9CRUtuK2orSERNSWhSekQ2ZnJT?=
 =?utf-8?B?Sk1SamZaNmdGZE80cXlRRURmUlFsb25GUWVWU3F6KzB5cmZ6QlJYc3dHdklt?=
 =?utf-8?B?SVFlWnZneVF0MWUwc2pCNWFhcnR5d0s1QitOUnVRSm5UVGJYZUxwSlVjUDRL?=
 =?utf-8?B?cmZycHFuSVZqRGFxcWJlNDdMNDJEdkhyazd0TnNuSGdxZTI3YVJIUEhlS2ZN?=
 =?utf-8?B?c3U0d1V2RCsrZ3RidXVjQTR4SzlQSXhjbmxiTWJaejJzTVBlc3Q0NGRqZVlL?=
 =?utf-8?B?TFFTRFNXdkJqME9mVktCVEpxYWpDRm1wbmxBR2NYSDhPc245Tld2bGRjQkJK?=
 =?utf-8?B?N3puc0sxaDY3Y01FM0EyZlhIUWR1YTZpV1pycHFFMkxGSFpya2xUTE9PdnlU?=
 =?utf-8?B?L0JFWUg5QjQzVHQ2K2x5RlJLUTAvazJLbUJUdFI2V3NlU3pEdGVnTUJEVmNv?=
 =?utf-8?Q?DqGsQLs5IuNbNqLMd7T8e8g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ae7372-7e9b-41a4-8c8b-08ddd91f3789
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:37:05.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IdGSj0iYX+1IUuyTDWU+rzTdJJQDrWNdAcR2S0km74bMP5IbQT4Mh67CcdofvddBUbZrp0eH3Zo/mXaOk9OaoQ72waXuyJDAwUOYHvHJLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF2E67D388
X-OriginatorOrg: intel.com

On 8/11/25 23:27, Tony Nguyen wrote:
> 
> 
> On 8/8/2025 11:53 AM, Jakub Kicinski wrote:
>> On Tue,  5 Aug 2025 15:33:41 -0700 Tony Nguyen wrote:
>>> +    if (devlink_port->attrs.no_phys_port_name)
>>> +        return 0;
>>
>> Why are you returning 0 rather than -EOPNOTSUPP?
>> Driver which doesn't implement phys_port_name would normally return
>> -EOPNOTSUPP when user tries to read the sysfs file.
> 
> Jedrek is out so I'm not sure the reason, but it does seem
> -EOPNOTSUPP would be more appropriate so I'll make that change.

when it was a driver callback, returning a 0 was short-circuiting
further (devlink) name computations

but in current form (v2), it is indeed better (at least wrt outcomes)
to return -EOPNOTSUPP, as that aligns with both sysfs and devlink output

so, good to update, thank you!

> 
> Thanks,
> Tony


