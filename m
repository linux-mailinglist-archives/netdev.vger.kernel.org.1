Return-Path: <netdev+bounces-94977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986058C1275
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2129628367C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1016F827;
	Thu,  9 May 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds+FBiA4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51CB16F83D
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271088; cv=fail; b=SE7zkGSzzE+teUQ8cBMsIcc/feZQKEKDxURH6Ww39UmXDH97tYQ+1nUfJ5R1Ibg6xv0315DtRHxHAa+Sv5bDUx2LKXQdzkkPYVzfo4aqDQ9W28CDateNPzJBkCFPFe8ThydtiaO6jNJQFdk0ltRDjiSsSQPbQIXsBTEvS4Zj5Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271088; c=relaxed/simple;
	bh=ee+hm1OL+kbm2duO2sQ4mf0b9treXiff8FnyR5+qs+8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrhpNMIlceOphewizmlr4Dd0/lYGYXwalA+lUtsMFHu7C5nKGMdqjs9JwnLMj4ks4qThRlJQk0zq6Dm98of61+ypFSTevuu/JrqTGa9vgg6PLaxmejjNRSLdp2YXfPFgxjRzIvHQD603uD3/ySnuKRi4gy6y3LbgoUj7jozC37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds+FBiA4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715271086; x=1746807086;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ee+hm1OL+kbm2duO2sQ4mf0b9treXiff8FnyR5+qs+8=;
  b=Ds+FBiA4vrdQ47Xp3/JSkl4yHhyZEDlkm1fKwvRLt93i66YuIrK3H253
   Lniozyty7hPukmNjZIBqAWnNMx7XEPwKI4xRjMk5FWJXPN1GVQ0A6Ik7e
   2FA2o1L2Rwnkd+7+JT1egFRuzCadUS+dIOb9PcDKPRUekGiWTSMxNl5iY
   hW44lS5MedSJXpSHfxLx8u6N1f0zyljuXmK7aVmKRQnZxDwfg1VVWkd9W
   VS3svKIwsWvTdq3zcMPChnwnJ5n1AWF8DL7kxzUcdYIFXx0coSkQsiMZ8
   oAIiQlnT7HOHqR8yE4MJQNQC9qf59yC6ccS9iA0WsQvgbDOp6TJvVQpMG
   A==;
X-CSE-ConnectionGUID: O9BlRwvwRuG6YEc8lln9qw==
X-CSE-MsgGUID: wXis14ZwQ5uFy5jH1LwDdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14154851"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="14154851"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 09:11:25 -0700
X-CSE-ConnectionGUID: braDAGBYRbuKaEutmCBgtg==
X-CSE-MsgGUID: fEe9RiUkQ3Ca8ItSKDaC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="52492258"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 09:11:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 09:11:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 09:11:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 09:11:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA4ySmPh+ThPV+6qh/yaOKlAOWkAr6D15Zdv/6V9UsX7lMOkuzwRpx944CzMwRmxMkSfKYn+Lsgf1ofuj3yvib7YxcmGlCQ/1yHc/jyi0vUstNPOPmePXHbZxdmBeJ+VfTwIZ8mVFjSnANLkh2P8Pun9oInGl90Q50N6AmRCDc0uGsqtheB+TXdfxd0y2+Cf4E4sl8HrLDEl2VydoBKzX0Nm+Bcm7PKV8F/uaeD3ejBozkG6wFYgr/F18cVriM5QtyOdQHuoBoQcpl0Tzrk5xI+A88CrgPbr529oapVbI+tC7xGpYJ1HpqfhXTMCRJHI1husXKfxp6jSj7BR2PFceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv1k2dopIRNPbxWrVhBNIRKT/A3il4EWJC166/lVVK0=;
 b=VqzfdnDTJqU3T4HBLoWCU33v7Eomus6Si/b14Y/hkJK+nmwsXhkRWiq9qalDe+SXgPDhfCTV8dF3uhsohxleMwOYKZhM5DQyVY5UZAnm/QD9cNdtaeyh7x6yMHEAyy95V0wPwTKipUUfNJxfIj2Q8QGM/L4FCQG8qwBiKxjcP2M6x7uBOVoTQyJjK2XIgZOEEK5qTNm8++w1SQ8uuRCcI9dKlhS9iCUPE5zdpDpv9zS9hBNY6SUI9yYfyX6iIL1HYGRCxFEJddXNMzbfABxJtyqt239SKkYVMU6Lgkhwmo0i63awCR3+mrl38zGh6OGiwVUWFjbtHwunkR9txk9QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 16:11:17 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 16:11:17 +0000
Message-ID: <0257b1fb-3e0a-d5d2-4e2c-eedc12e7dcd6@intel.com>
Date: Thu, 9 May 2024 09:11:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: Do not get coalesce
 settings while in reset
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>, <netdev@vger.kernel.org>,
	"Pawel Chmielewski" <pawel.chmielewski@intel.com>, Simon Horman
	<horms@kernel.org>, Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20240506153307.114104-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240506153307.114104-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1afd28-f468-480f-af0d-08dc7042a81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmdsWExyQlVSZUI0MEJPUUREUTk0WjFybWN3ZkJoV3l4dWJxMjZtVXlOV2NR?=
 =?utf-8?B?YlF5RG5NNm8yc3pzTm9FaEJBNHFYWGc2QzdnNzV1YTRXNml1VXZLeFhRcVEr?=
 =?utf-8?B?V1FrV2p3cTV0cHRFREp4UEdWUmpkM29pdFppazhubWJ3Z2t1UEdic2o4REFZ?=
 =?utf-8?B?MytEUnlOK3JUNHM2VXBGRnZVQlkwMHhhQ1hsSUQvMVlrTFhGbTZlZFpTakdE?=
 =?utf-8?B?RlZtK2h3ajBwUDNXRU5KNW5wNWtXTXNpeWQ3ZEJkQi9lazJyZXJnSmp2VTRr?=
 =?utf-8?B?TlhSaUdMNkl3UlNqM3R5b0dBMitjNTE2VXFkTDd6NUlPais0ZEhBWWROZHRy?=
 =?utf-8?B?ZTRORjJCR0lKT0MzeEc1Wm13WFpOa2JaSGJKdFpkSDg2Z240akpDc0NuVXVH?=
 =?utf-8?B?cVBWUDhHZTZuUm11dmlXZWJLamZGR3BqQjRhenJjU1h5QjNvVzdmalhFQ1pE?=
 =?utf-8?B?dzhTc3F1aTd3bTBnTlFTbDkvRUFCT0pabzllejVPWks2VkpCSEVZQVF5MDJF?=
 =?utf-8?B?RTcwNXpvb3FqVWxacmI4R3NxOTZrVWtkTWhmQlYwTDIydkJsWlhJNGdNZm1K?=
 =?utf-8?B?UXlZK1IxRElUN29qeGhsRU5JTERWRis4YlI5R3JhVlFTWHBvdVBLN0NxeHFE?=
 =?utf-8?B?ZUFxR1BPaUIxNDlEbC9TamRaYkI5bDZlTHFHaHdYWDhkSHFGTFptN2ltd3Fr?=
 =?utf-8?B?YmU5dDgraDl3bHRhOUNzN3Jqb0lucisrQlppK0VGUUhRYWRKeEppQVhaYjIx?=
 =?utf-8?B?MFpuZXRiQkcxKzRXamorU0N2dkFibURxK05yQ1NOT3hJRHluckVESnBjd0VX?=
 =?utf-8?B?S1VaRURLajl1N29DNklLbVg0Qmc4eU5QYjMrR0RzQWEvSjh2eEVZZWV4VXBp?=
 =?utf-8?B?WWU4ZXlBV2xoTW5ERkNWQWVXNHdNVC9IeGc4RHVqcUZHR2hHMzFFZm4xajJL?=
 =?utf-8?B?eCtpK2pxQlQ4TmI4VFFRTTZrUFVUaHZMeFoyK1VjTlNKcUt0Q2dZWU0yRUt2?=
 =?utf-8?B?ZzB5bjhwcDE2OWxaRVRCQm1YMGFRaHBLU3c0RDQrY3NxSDZwTkxGMVRYMzdF?=
 =?utf-8?B?dllrTWpsbU1xcW9tVVVkTDhZdXgydm9RR1gvVzhBK0s4UmFlUFVDNm9ncHNZ?=
 =?utf-8?B?akhkOXp4VjhONjgzNTdZS2JQRnoveFNiNzFwYndKdVRUejBuUERDU01MQkJJ?=
 =?utf-8?B?a2piR1BreVNCNEk2U0E3Nm5TTHFXenVEWGFwUExzOFZQSXZpdUxyZEc5c1Qx?=
 =?utf-8?B?UzJ0amNOeCtXZjB4SEVsL1NWSTBDLzJLQVV0aGFKQ1luN1ZwblFzQ0hhTFh0?=
 =?utf-8?B?RjdRRFl5cDV0L3hXZVJRaWtZRCs2aTJxRVlZTE1LVGdkTzNDcnBoQU0xNGt4?=
 =?utf-8?B?M1pTQmZTUk1yY3J4eEt0T1lFNVF1S09OSVpnaytoUkZESTA4Y1dZUWFwa25w?=
 =?utf-8?B?c2gvMENWUjFCd2JPNWNJTktUMkhkZWFSN3poR2tXekswa1B0TkhTRUtJN3Vw?=
 =?utf-8?B?blM2T240by9ESE9oL1lCQk5iVnU3SnBWclNIbXpyK1JpbEZmaHdJY2NkZVpS?=
 =?utf-8?B?V3gzSTlmY04rR0Z4RGwxNERKSzNuZElENWZCeWVQclQzamZiclI4RDlVaEo1?=
 =?utf-8?B?UFNTS0Z2RlhVR2svQTVpclZoRFYxZHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5tNXk5c2x3STdNb2pDM0ZSQkhGSnBZZk9UUkhXb00wK3dMekpDQkNGQ0tv?=
 =?utf-8?B?OFFoYkRYM0NrREE2WkNCRTRSNmcrUTludUtRcktkeS9VRC9JdU9wN3FQZ0Nm?=
 =?utf-8?B?WXpENDNmdWc1MGdJanIzK3AyNHhIekpZNUtEZ3JkckNMUytxTTREaXJHMEpK?=
 =?utf-8?B?WXI4YWJyM1ovdnY0aFBjcjhDRkt5YVBZSXRBUnMvNXZRYkVsTVFXdm5iR0Jm?=
 =?utf-8?B?aDMvLzBBTTQ0MnFHQS9kRUVTM0Q0dXRTdVZFSUNtelM3dmlSb0dRREkzZktJ?=
 =?utf-8?B?azM5ZXVrYld1Y3RlM1ZnY1Fha1oxb1BrWmpVMGl4RldtWng2d3VHakN1K0J4?=
 =?utf-8?B?NVEvMGhLQy9PeTk3THFmSmxNWnZsUFpkWjkzTlgzQXNQZGVtY3J6MnJqMDhW?=
 =?utf-8?B?YUU3dHkvRjlpbGZIYTdzWlQ1ZFJZQ0NvYThmMFFQYXRmM0tZY2ZpNHlmKzBC?=
 =?utf-8?B?aEtDb1R5MWtXUC9qeFNBTUErOHVkSWhOZHV3N0FUVTRBVDQyeXpsRjFqUXVo?=
 =?utf-8?B?UGt6RXYrN1VvK1pnbzk2YjB1REUrSGl6bWVIVmRham5mL21ZU1piWGQwQ1p1?=
 =?utf-8?B?YTRDUHpSUExaaUpHQ0VEWDZFS1VLaWVncE0vb1M3Mzc2cGNWbXJpeUFCOUwr?=
 =?utf-8?B?OEdpKzNDeTB0SGhwNXFweE1Td2tUWXozRFRNaGNpSUdKU0w4N1ZXKzZtdVFE?=
 =?utf-8?B?TEt1eDQ5VzEzTU5FcTd5V1FKOEE2UVVIQmY5b200UHpvM2hBcjBYUGJiV0xN?=
 =?utf-8?B?V0FtYy93V0ROR0VIN3ppaWZEK1pmaDJqeWpEOXZIZzFhOHJxenpGUHpDNDVZ?=
 =?utf-8?B?VFNOamxhRmpyOStESk9tVjVWNWVDR29XWFdCaTRNUng2dHFlenl5N3AvbFJj?=
 =?utf-8?B?VHpjaWo0QUt1bURNK201Z2xhQ0ZhWXYyUDlyOUlKU3lXTm1IQ0l3UUo2S0Zv?=
 =?utf-8?B?emN0cTQvS0VhOWh0a2VnSUVTOVllcW8zdXJWYzFyRmpNTmFoSTQ0KzlpWXJD?=
 =?utf-8?B?blhiTGxOSHVobUZCSXk3TDNPZzlNVS9kNDE5NXlaTmZOd254VFJjbDJiR3JS?=
 =?utf-8?B?RWJBbWtvdUczOGVDSk5VRFM0aXFnUTlxT1QvTFA2WE93MUs4RzVTcTI1cEN2?=
 =?utf-8?B?QzJEMlRFUnRvc1NDRVJDUGgyVXZGcFVNaThNTzQ0VHUxQzMwZ0FOOW9wc1hp?=
 =?utf-8?B?bVBVSkZ6Y0o2YzdoelJYT2EwTVJMMi9qRnUydFdlZUNJSGVnWUFpSlROUUlt?=
 =?utf-8?B?c25LelhkNThSOE82cEFPWlFURlNQcW9nK2oyQjlYSHpxY1VyaHM3RldwWUJr?=
 =?utf-8?B?Zm8rd21XRVZYVVd6ZUhkTS9MWFgrVE5ZTU9hQ1VzUmtjRXJMQitnV0tDYzFs?=
 =?utf-8?B?emxNSzVjK3ZRNjFndGVFNmRvaGRkUmx5M21VSEtaUnRmOXcvdzBHRkY5KzQ1?=
 =?utf-8?B?aUw2RGFncUZ3WGhpeERYUDVZVjhpTXFDTnBudTlabTRpVFVTK2Vland3RlVP?=
 =?utf-8?B?YXdzbHNvemc1dWQzaXJSRkRRSStKU0pqTUx2WVBqSWIrQjdoMW5yMEFHWUE5?=
 =?utf-8?B?c1BJTFhScGdaMUpIS3ViMWV2OVEwTmVQcnRTTkxNcHNNSlNuNmZiakN1Ukp2?=
 =?utf-8?B?blVtWkQ2STkzVXlBdzNhSzBKVFJlWnFFQkV6eXJEVTVlSGVPTTg1MXRZbHRw?=
 =?utf-8?B?UFpzTUFkRGxjd0Znc054UGlxcWlIL252RGdDNkVCMXdDY2hHeDZyWWNsWEhC?=
 =?utf-8?B?SVhqeG4rOVR2bE5tU0Fwb1dWSUlzR1RQa2xQNWF4dHlGK3phbGQ3a21WM2JY?=
 =?utf-8?B?RGpuNTBybzdIVVE3aE9JVzFqbzM5TEVrUmRCZXB5dm9pTXJkVXBJK3ZnTjlV?=
 =?utf-8?B?cHB2bUJHcW1Qc2RXNDZ2T3EyOWhtbFZ1T0x4MEZnak4wamZyRDdMUDNEYUVt?=
 =?utf-8?B?V3pFWjJRaGp6SnpnN3VtdUdlM0o3eGdVSkxGVUhlTXVCZ0theGdORWdFOWFP?=
 =?utf-8?B?SVJBSW5YVlY1Y08yeDZITjJNMHMyZnA5YkJ6bDlTUWtkcnJWU1libU0wQm9i?=
 =?utf-8?B?aFZXNVFBODBHUDBGUGF6NDR0ZWJ6QWxZNzhGeUkwM3Y0dnpNU2FHeS9BNzZ6?=
 =?utf-8?B?dThQQzZsWmhNWmNWSDZGSkxSK1pHNUJaNUo4Wm15T2UzSWRsWkZqS2Izc1dJ?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1afd28-f468-480f-af0d-08dc7042a81c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 16:11:17.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioy8UFbjsXNWlkDx65nMK9V/pXrC6Mli8n3WkHl4QttDft1A14t8CWSW7+dT6EaTWlVu4v6DR2OgFOvtyN2uU0WDaZUxbw9SAwM1uLIMGjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com



On 5/6/2024 8:33 AM, Dawid Osuchowski wrote:
> From: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> 
> Getting coalesce settings while reset is in progress can cause NULL
> pointer deference bug.
> If under reset, abort get coalesce for ethtool.
> 
> Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")
> Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
> Changes since v1:
> * Added "Fixes:" tag
> Changes since v2:
> * Rebased over current IWL net branch
> * Confirmed that the issue previously reported for this patch [1] by
> Himasekhar Reddy Pucha was caused by other, internally tracked issue
> Changes since v3:
> * Using ice_wait_for_reset() instead of returning -EBUSY

Seems like commit message, and probably title, need to get updated for 
this change?

> [1] https://lore.kernel.org/netdev/BL0PR11MB3122D70ABDE6C2ACEE376073BD90A@BL0PR11MB3122.namprd11.prod.outlook.com/
> ---
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index d91f41f61bce..4ff16fd2eb94 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3815,6 +3815,13 @@ __ice_get_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
>   	struct ice_netdev_priv *np = netdev_priv(netdev);
>   	struct ice_vsi *vsi = np->vsi;
>   
> +	if (ice_is_reset_in_progress(vsi->back->state)) {
> +		int err = ice_wait_for_reset(vsi->back, 10 * HZ);
> +
> +		if (err)
> +			return err;
> +	}
> +
>   	if (q_num < 0)
>   		q_num = 0;
>   

