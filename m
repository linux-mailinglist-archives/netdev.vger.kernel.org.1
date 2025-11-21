Return-Path: <netdev+bounces-240712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E81C78357
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 93E4D3844A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE933C187;
	Fri, 21 Nov 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b44e/gp3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14A136351;
	Fri, 21 Nov 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717127; cv=fail; b=AbPpyu+bDbmF1WGM+pmh2e3Kot3vJQjPTpVHeCKmAbVrBmw3baRqDxqqj8RPb136B5YZVCZhp6iRyY3FCLafcNciOwShU1LKkylL6ytWiccBdmo3KJHH1OamAxEr3tYy9apL1BoR5BOtXylS2xJf1KnQN4CVfqPvq8CDJXesdaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717127; c=relaxed/simple;
	bh=HQd8Mzebd1dVEDAs3KDKDvDx9oOcmLAzmUnKgYKXHas=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTFAhokDhFvL/UI/022jNw77Ga+nSuGKtu+BnJQSvyHtWBV++TEHKHL+HbAch+YcgVVEnYQiwk6BuXvqCKPzX+6dYJN+lDkMlUa3+1x433fxVco0VHopJYr40nzMia+R/x2r4o5TImwHSYUovAgJEzfjWZOP6Ps13luBFQi9sFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b44e/gp3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763717126; x=1795253126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HQd8Mzebd1dVEDAs3KDKDvDx9oOcmLAzmUnKgYKXHas=;
  b=b44e/gp3q5oiezHsCzNDrRUXMpeX0/HS9RDnRYD6vhAcVejIwNR/UL4n
   jz+Mjf6nzhf1ZmxYnHr/uRrkqFac4KnUXDDDcGTPEk+lq1AysYxrFAvOO
   ZFwcy3IeK65e6UMds2FWtCozqsXLvLu3eWlZCDWdhjxF2HmTU00OKzNla
   GcUqe1rdnRDitileDxzSU2YhntL+qCEy6aOr/kRNUOY9vqo6pSJ/L8m37
   9X/gBlZlmYZiA4POu27UAnl1s/Ub84o+XZ0qplHmN/WeUlYA/msEN5vnH
   7424xNBSrIQxqHW8tk7etLzgqRJOGqf68TBohb84z/cGaf5iIAv+2rmc1
   w==;
X-CSE-ConnectionGUID: sIY3FFWaRb6eHDSDhSc0+Q==
X-CSE-MsgGUID: st3+0nS2QUySzn08p0Gwgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="77274902"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="77274902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:25:25 -0800
X-CSE-ConnectionGUID: www93ySHTmehZ1THXtGH0A==
X-CSE-MsgGUID: Dbg2LDRhTCy5Pf1GM9AiVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="195810351"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 01:25:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 01:25:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 21 Nov 2025 01:25:24 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 21 Nov 2025 01:25:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcXImY0WNsdG7+7RNB4pWxJhwFj3Z1ZlnIATm7hAENgJoL9WtNOvfxyzY0wvGirncnRPD9CdG/4HkuIVGOll4V/l1rbZVbAKt9yAo8V3VucYtt/GD4RzIToCuPSFbgQL5ZwwDGquGnJU7YxH4IYDhG3eCPlfcLJOpwZhMHPOATQzVk52J90x57pFkOkd7XVMKoDTPhU4Z1qQdiVNP853lGXXEK+05JV10UJEQBcgj2V+KKwLoXqN2ZHktN2LH72JWfQqDT8i+Ufh94YH0fk8Ddmo7GYUqVXstaGO38Os3yR+p5jPOsxaQgTkMDVvFUTR3nq/VFm00UrdeLeF7t+8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BYDyARtiKUSbgdhhXVKpxj+GMUV/R05fMMj54/dtFM=;
 b=S/VKkOawyvXRSu/au/kKALu0PR6YoDduDvDbzKKjafGIynW/De7CEi9GgSLkEDpKZYbS9yDbCWE9gRzRWWMrhaTxygQ/xKpUbbyLVC7t6IxBA5FnvezhX9V+WbcWCpu45qiHtIXaYj0bdvtETMqWmE6YbUZj0Wn09yBEWnKD8Vof0LNALZJnPUZt6Wryb3gi2BsJ+qIak0BVvLgib35a5xoERnDFTeBi0ysTebprjLn3cROBz7XWc+M1qV1c2v4sz/aRcaiaEhH4ECaYEChcW3U/Yi+yjh+H1xv5jpi8tN307al2v5K3Uz29GXkTEFVGjRIFfYIV3LbhsEobfX7QUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 09:25:22 +0000
Received: from CH3PR11MB8315.namprd11.prod.outlook.com
 ([fe80::f03f:df11:742e:6272]) by CH3PR11MB8315.namprd11.prod.outlook.com
 ([fe80::f03f:df11:742e:6272%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 09:25:22 +0000
Message-ID: <0776633b-7e0a-46f6-b4d9-4bcf459bae62@intel.com>
Date: Fri, 21 Nov 2025 10:25:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 5/8] ice: update mac, vlan
 rules when toggling between VEB and VEPA
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
 <20251120162813.37942-6-jakub.slepecki@intel.com>
 <IA3PR11MB89862D16B3E71FCB8DF2113EE5D5A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Jakub Slepecki <jakub.slepecki@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <IA3PR11MB89862D16B3E71FCB8DF2113EE5D5A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::16) To CH3PR11MB8315.namprd11.prod.outlook.com
 (2603:10b6:610:17e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8315:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: df5e0d22-cc48-4f18-39b7-08de28dfe527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0ROU2VGVkRKS0ROSWp4dVVKNkJUVmZCRWtmNk1ib09HWk1BL0tsZVhkVW1F?=
 =?utf-8?B?TWlZQ3NTK3hPcFllS2RzanR3MlBTRDZwY2ExYjRCNWRsUXh0MEl6bmNjUmI5?=
 =?utf-8?B?Umg0R2l1YUFYQTJxVG92Yk4rL29ueUJTYTVncDg1dFpGbkIraFYxaG5SbFlV?=
 =?utf-8?B?dmNEYkM1M0NreU9ZSVNwSlFYcE90YXFHWGMzWmVsRHo2WXNLVjlJZlpSQWQ0?=
 =?utf-8?B?cDA1Yk8xZXdqcndPY25VRUprMWtuS1A3R0Rtb3JqeTdhYWc1M3RqcHJ3Yy9D?=
 =?utf-8?B?aHhtb1RsSWQ1d1dGMTZPenAycXRRTnFYcEFxRTRGeGo2c1hpbzVvL3dLTTRa?=
 =?utf-8?B?SG11OVg5WnFzcE0zbkdxZW13SGMzOGZzRStzYTVuNlJpN3JNMlRVVkhWaS85?=
 =?utf-8?B?OS90RXlOUmx0bzIwTE0zc2NYK3Q3U3Z0U0kxRmFjbWI2SFk4UWo0Uk9qWUZj?=
 =?utf-8?B?Ym1DK0p6NFZ3S2VsSEpPOC84NE5tTmtYZWdWRlZVd0h5aXRjVWM1NVZVZnMz?=
 =?utf-8?B?QW1wZG1zODRBaTRNUktaR1hON2V0U21RTHpsaUFES3FMaHVFYjl6WkJrTUxw?=
 =?utf-8?B?MlJOUjhZQUtpY05OdG1VWXdBZUQ3L1I4dEQ1LytxNXZtTm00Zk14djg3NzJN?=
 =?utf-8?B?U3VBNFdTNjVIbkdDbVhkdG1GUWdtZFM4TStkN3RyV1pCZGova2VlNXRtWDRG?=
 =?utf-8?B?dUlNSVE5U3NGOWVBMHI0SnkrTTFoQ1p1aklOY2RyeHFSUEZUbTNCTjNmWXRB?=
 =?utf-8?B?OEVrT0d3eStDMVFsM3RtMjB2Y0ZmQ2oyZGZQRzlzbU5YOW1sUUJDNnpqdi9R?=
 =?utf-8?B?QmMySGsydHcvYVM0M3JRQWVMem8zV1FHRlkzcVl6b1poUExGNWpiS2dGNndv?=
 =?utf-8?B?NU9PMCs0bDJiM1BsbUZhZFdZVWtuZE5qeXJkeTF0K01ENTJ2cEJVODc1TXN2?=
 =?utf-8?B?VXR6am9Mb2V1VEVCalU5L3VYcVIwV1JNZ1U3MlNoL3M3SXBqTG9DdW5ZbjhJ?=
 =?utf-8?B?Z3dhc1RpQVJlTTR2cmV0SWF4bDFCckhweGhWWTFsMUhuUXZMTTYydHd5eHN6?=
 =?utf-8?B?dTk2TEo4WWdHbFNRWmpmUGwzcDZyM2luWDA4Z0lJMXg2SFdaa3FrMU9YQS9P?=
 =?utf-8?B?Vm9TNUI0eEdsc1p0ZlVyTlBUL2NhaTlBV1Z6OUdJNzhzM2YwQlBuSUIrNHR5?=
 =?utf-8?B?RFhlcjRrZzg4a3VkWlB0K1FVMTFkQUVkSnc0K3RwVDR0SWV2dW5DQkJqK2dS?=
 =?utf-8?B?RXQzMkw5alA3eDNtQ0tzR0xzMHRXOVJJOC9QUUUveHArT01YUmZGKzlZOXNN?=
 =?utf-8?B?UFpCdVRoQW1rSXRxN0QyN3MvZ1pBa1RhN2l2UGFZaU10YnUwZnNGZkRJcVNu?=
 =?utf-8?B?YmpyTXNsNmlFQWxqcVkxWGpibFUxN2wzdjNxams1T2p6TWF1R3hScGIvNXpO?=
 =?utf-8?B?OXJvSWRzNHNMbU9CVTMydjFrT2VBSHJkUm9YeC96akpDem5IWEUrakVWRVNm?=
 =?utf-8?B?YytNcnhIUVZQNUdoNk10dUhNbTVYYzNyR0FnT2RBQTY0MkpDQWJoUTZrMmZl?=
 =?utf-8?B?UWRUcm1RcmVpZDVnSjdCSEowZFg1NWZER09sQnczNDQ3cFhtUkFJTDNGNWRq?=
 =?utf-8?B?WURST2hGU0c2TDNMR3lKK0FMbkNKa0t2THJwdmJ1eGo1QkJpeEZ2M2FoMlJV?=
 =?utf-8?B?OUYrcndjQ3FUSmtJQlZyYmxsV2FmUGRXbzFrbXNDcjM4N2Y0T09iZTRkL2F0?=
 =?utf-8?B?bXlrdDJFSGtTdE90bHBjcGVFN0ZGWFE1YTBTc1VrUUVZN1VqdEgxL2NCVTNB?=
 =?utf-8?B?L00weXFDd2FQUk16NkVheHZjZXdwbXJxV2pRYUxhb2VWOGh6bVJua2k4VUhQ?=
 =?utf-8?B?TzlPd1VtSkpZcWxMYk5Gd2J4aEQ4dmlEcEZVdUErZ3l0RHBIZUEyRHFKNEJK?=
 =?utf-8?Q?i048wkqvuEJl9DnL3OlpUOjk8CWvGL/r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8315.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9TYWxxM1RCSzVDSTRGV3JQT2hXc2NKbXhDNzVPVzRicTNBVmJDKzc0bVc5?=
 =?utf-8?B?US9QWlhjTnl4Q0pMUDljeXp3SFE3TnZZSUxuS1RBNzlXV0VzcHdPQzhKVXpI?=
 =?utf-8?B?dTRhSFU3MnNpU2RkenFDalYrbkpYUWorWG9WOE1pWkVISW9qWmRnRGtMTUtm?=
 =?utf-8?B?UTRPVEhlaVhDMThDbzlhc1VLMEpkeU5qSG5zMHVmTHRYN1NYS0VabHNSNUwr?=
 =?utf-8?B?MDZIZ1hZL2pNZER3MDNkeVZ3SHp3OEZBSTFDV0F2a3FhSmZOYmR1RzVXMDBm?=
 =?utf-8?B?QTRsY2U4WFZvaUVFR2REaWhjVnlqZWNUaVNVM09hRFpKVVk5SmxQOGI2dGQr?=
 =?utf-8?B?ckZXREFiQ2V2bk1DYkg0TGhXNjErQURPdEhkNWJXbnpka2Y2d0xBNnNBWk9V?=
 =?utf-8?B?K3JqQnVxdTlFMWUvOW9uQ0tFV3BVL0lVY1RmS2MzV0hKNDFMMFI1M1A2enFH?=
 =?utf-8?B?SEZkcnNaL2ZaRGcrWWR0ZFZGYWZKWmovUDlTa1Z4TWVYZXg4Zk5TU21iYXJx?=
 =?utf-8?B?Vk9EdUIzVUwxclcvakRkWXVaN1ROWFJQN2FJVlNHMGJDemo3andiVlE3bFl0?=
 =?utf-8?B?YVBwTUhraEp5SEpyTUtpTGRMVHZpM21GUGk4T0RHdlg0emtzWHI3MnFlSko0?=
 =?utf-8?B?cWI0dHpWQlIvK0xCeVhKMlcwcXZvMENCdm9QelVTZHhLcTgvUjdLTFp1MFk2?=
 =?utf-8?B?QmY4a3JoUGwwWFVHVnFucTltNm00cHY4YlRVSDdRdEYvM3pCRld5VXVadkU4?=
 =?utf-8?B?UjlIUzZXOWhHVlZWQk9NM1dRRi9yWXNPOFNVR2UyOEUwZnkwVFRwU2g0M1JE?=
 =?utf-8?B?K3RKOTcyNHk3dDN3YkpiRzNBVHR5Q1R1cmZoaWJMY2pTQ0ludStoYnR5MTl4?=
 =?utf-8?B?cUlSbERXRlNMQmdKSXo3all1V1NQSTVvQUVQWG92YkxPUk9ucGJxek1uNThD?=
 =?utf-8?B?NkpHQTBuUmhpOTZMNEFhYUczVGRZM0tpRWJvZkN6UzRaSmVlRHJPM1dQWFdm?=
 =?utf-8?B?NDlxS2NGUFNONXYwOXFjN0poZnNRTEFPWHVjNDNIUzgzNTJCL3ZNWXVRa0Nv?=
 =?utf-8?B?eVIyeUdZVUpnMEp0NDB5SXcyaDd5N05EdFpDTTdUWkxGZURocWtScFBERDhl?=
 =?utf-8?B?TFB2bWYwZW1aQnRjZWd0RG5oSXFEbVBsQ21hU2h6Y3h1VjNjWU02WStSQ2Vk?=
 =?utf-8?B?eVFUWHR6aTRjODUvWmZ4aDlhTjRaRTRXbnFsMWc1a200ejFhcFdEVDlWUSt5?=
 =?utf-8?B?YXo4dXd0WVljUXlhSUpiUGF3N1NXL250d3BpbFFFbnpPY1pJVEMxRG00S3NG?=
 =?utf-8?B?bmUxemxOMkU1RVBBdmZnNGJSc3hNZUZiTXQ3ZktRUW9pTjZhbFNOeXRQQjl6?=
 =?utf-8?B?TFNiVzVPZ3cvdnc0b1BhaVFGS253UTZLTE05VDZsRXA2Vk5UZDVQc1EzdzRL?=
 =?utf-8?B?WHZpSnZiWUo2eGx6SHhLUkNUWEtwUFlMWVo4d1ZXV08yWkxLcUpZbjRKNHZw?=
 =?utf-8?B?eXhlUzhSMEZncGVuZmlIM2JXZ0N2cGFuTGdWRlNrQU9kS0x1T3dyc3daTFoy?=
 =?utf-8?B?OEJOcmhLNCsybGV5WW1lV2VQNkRTNEpvR0orRFBTcHV6WENDNE8rWTQzSnN3?=
 =?utf-8?B?UnpFRStmZ3Z2TWZYMHJxQUQ0V3QvQ3VrTXg5VDhDOHpkYmRxcnNvWEVMOHRy?=
 =?utf-8?B?S3dCZEhHY2VNaGJTRWNUTjZta2d2SncxeDU3c1U1bWpJUWprOTZUcFpVTWdr?=
 =?utf-8?B?V3VIRStnbk1UbFB0OWhpUmJHVW8wUzVWaVRCRjhiVGZ1d3EvdG5wL3RFdTFi?=
 =?utf-8?B?V3pIOUh2cWNxVFczcTNGVzNmdTM3TzU5dUNUem4zbzR0R0JkYzY2cDFJcnZC?=
 =?utf-8?B?TUlTRXIrTzU1d0RFVi9nL3RzMVlJak5lOUM1YnB5dy9XT3NRU1d3b3FRM0py?=
 =?utf-8?B?N3hoZEVLYzdvazlQSzByLzIrbmEzTFlyNDZKenU1cXJEMW0xYVNBaDVtWmxB?=
 =?utf-8?B?VXNKaWlsQmZQZER4dU1tSFJwYjdJKzV5UEV5TUNFM3JENnFYVXZLMmVrcldx?=
 =?utf-8?B?TTlCYXNVRERaUDZwMHRwY1FHajVSdWJLQ3phc0hUTlV1S0VDbUEyU1R5RjNr?=
 =?utf-8?B?aHZjVWdMRW1NWllzTTd2RktQa2FEOHhmWmFGKzNCbSsrVnVkb1ZBN0M4anFn?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df5e0d22-cc48-4f18-39b7-08de28dfe527
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8315.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:25:22.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFKmXo8gRwMLAJ2JklrjfXGBoNkbZcpqrknQlnI/HEfgVlmt46dRPKqb5sbJc6wi4iNwic7FujqsNcJGgVhESBfk+EAEda0LkhvgyoOzJmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com

On 2025-11-21 9:54, Loktionov, Aleksandr wrote:
>> -----Original Message-----
>> When changing into VEPA mode MAC rules are modified to forward all
>> traffic to the wire instead of allowing some packets to go into the
>> loopback.
>> MAC,VLAN rules may and will also be used to forward loopback traffic
>> in VEB, so when we switch to VEPA, we want them to behave similarly to
>> MAC-only rules.
> Is it possible to verify from shell? Could be nice to add exact steps to reproduce/verify.

It's not straightforward.  The easiest way is to observe traffic on the
wire (or lack of thereof).  For my testing, I have a patch that:

# cat /sys/kernel/debug/ice/0000:45:00.0/switch_rules
lkup=0x0, id=8207, flag=0x0001, action=0x0, lan=no, lb=no, count=1, mac=00:00:00:00:00:00, ethertype=0x88cc
lkup=0x0, id=20509, flag=0x0002, action=0x4, lan=no, lb=no, count=1, mac=00:00:00:00:00:00, ethertype=0x88cc
lkup=0x0, id=24593, flag=0x0002, action=0x4, lan=no, lb=no, count=1, mac=00:00:00:00:00:00, ethertype=0x8808
lkup=0x1, id=14353, flag=0x0002, action=0x0, lan=yes, lb=yes, count=1, mac=33:33:ff:0b:64:f2
lkup=0x1, id=18456, flag=0x0002, action=0x0, lan=yes, lb=yes, count=1, mac=33:33:ff:df:a9:13
lkup=0x1, id=24594, flag=0x0002, action=0x0, lan=yes, lb=yes, count=1, mac=33:33:ff:f0:75:00
lkup=0x1, id=4108, flag=0x0002, action=0x1, lan=yes, lb=yes, count=3, mac=01:00:5e:00:00:01
lkup=0x1, id=6156, flag=0x0002, action=0x1, lan=yes, lb=yes, count=3, mac=33:33:00:00:00:01
lkup=0x1, id=8208, flag=0x0002, action=0x0, lan=no, lb=yes, count=1, mac=22:0a:5b:f0:75:00
lkup=0x1, id=22538, flag=0x0002, action=0x0, lan=no, lb=yes, count=1, mac=ba:d1:81:0b:64:f2
lkup=0x1, id=18455, flag=0x0002, action=0x0, lan=no, lb=yes, count=1, mac=d6:3b:b5:df:a9:13
lkup=0x1, id=2056, flag=0x0002, action=0x1, lan=yes, lb=yes, count=3, mac=ff:ff:ff:ff:ff:ff
lkup=0x4, id=26632, flag=0x0002, action=0x1, lan=yes, lb=no, count=3, tpid=0x8100, valid=yes, vlan=0
lkup=0x4, id=9, flag=0x0002, action=0x1, lan=yes, lb=no, count=3, tpid=0x0000, valid=yes, vlan=0

I could RFC it here or on e1000 if it seems useful.  Otherwise, one
could enable and pay (very close) attention to 0x02A[01] commands.

I'll try to write something to clear it up in the commit message.

>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 0b6175ade40d..661af039bf4f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -8147,17 +8148,38 @@ ice_bridge_setlink(struct net_device *dev,
>> struct nlmsghdr *nlh,
>>   		/* Update the unicast switch filter rules for the
>> corresponding
>>   		 * switch of the netdev
>>   		 */
>> -		err = ice_update_sw_rule_bridge_mode(hw);
>> +		err = ice_update_sw_rule_bridge_mode(hw,
>> ICE_SW_LKUP_MAC);
>>   		if (err) {
>> -			netdev_err(dev, "switch rule update failed, mode
>> = %d err %d aq_err %s\n",
>> -				   mode, err,
>> +			/* evb_veb is expected to be already reverted in
>> error
>> +			 * path because of the potential rollback.
>> +			 */
>> +			hw->evb_veb = old_evb_veb;
>> +			goto err_without_rollback;
>> +		}
>> +		err = ice_update_sw_rule_bridge_mode(hw,
>> ICE_SW_LKUP_MAC_VLAN);
>> +		if (err) {
>> +			/* ice_update_sw_rule_bridge_mode looks this up,
>> so we
>> +			 * must revert it before attempting a rollback.
>> +			 */
>> +			hw->evb_veb = old_evb_veb;
>> +			goto err_rollback_mac;
>> +		}
>> +		pf_sw->bridge_mode = mode;
>> +		continue;
>> +
>> +err_rollback_mac:
>> +		rb_err = ice_update_sw_rule_bridge_mode(hw,
>> ICE_SW_LKUP_MAC);
>> +		if (rb_err) {
>> +			netdev_err(dev, "switch rule update failed, mode
>> = %d err %d; rollback failed, err %d aq_err %s\n",
>> +				   mode, err, rb_err,
>>   				   libie_aq_str(hw-
>>> adminq.sq_last_status));
>> -			/* revert hw->evb_veb */
>> -			hw->evb_veb = (pf_sw->bridge_mode ==
>> BRIDGE_MODE_VEB);
>> -			return err;
>> +			return rb_err;
> On rollback failure you now return `rb_err` instead of the original `err`.
> This is a visible semantic change.
> Please justify it in the commit message (and confirm callers expect rollback status rather than the original failure).

Agreed.  I'll see if function documentation would need a refresh for
this, too.

Thanks!

