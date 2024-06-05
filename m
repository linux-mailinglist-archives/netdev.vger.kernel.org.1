Return-Path: <netdev+bounces-100828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827858FC2EB
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68981C22357
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4B13AA45;
	Wed,  5 Jun 2024 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx1qTSLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED561FCC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564416; cv=fail; b=pwbTlVp+NrOjj1sY7PFUpUogCImv5a+Q5Ene03nZ4V60C7wtH/LsaVsuET+CtHsVQF13vUVGasDC33JWhUQAR/CDUT2kVLnnekuDZwnbw1DNCfjwUPc6ZBlUXhuwh54EtUGkH+mXHHe8LuYi+Y+kpWaNoQ6jZRygLm69e4YChnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564416; c=relaxed/simple;
	bh=u8wVw7Krdi5RcDk+DEqQOnt1biuYqtAMPHMJkedLoJc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=te1Jxldasz9fWuMl1xfe0C3jYug17M9zEr+crQ93l+cRQFWZAx3njtxY0svvPxeSmNms1D1+W4VdazOvUAaE+FfmsXZhSv4ZN2zhh5xgTz9w/GVIay3Y1+8LXBeRNh+qH+01BeOJAb/dgp/QbvwVk62qJftPd3YTlsvVMJaedPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx1qTSLZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564416; x=1749100416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u8wVw7Krdi5RcDk+DEqQOnt1biuYqtAMPHMJkedLoJc=;
  b=Sx1qTSLZ+17ciKVpxIw10SqQV2gmNaLo5YtC2/DYlmL4r7shRAVlTY6X
   ZMl93UBlJv7kJoSjIxbLUOVm+0XHVK8bp+foyv1P7q/a/ocHVDdjl06DV
   1SqX63q/vUX9CvQIONMEgx1rNsXt7iAS7p1FAS29hnRKDiVuKdLlXe6Ra
   BjKYdgD1t1PL8FvOTCakgHIuOHTcugn1/KLZTVaBdcEG1BbiGCkeEocyA
   Jjt7HejDauazLDJU3qL2O6YJ5vLtnzneJNPVRjjkhyseJfAz2Y712rZ+e
   +q67n6N/su6G/QICC+9Y0W8qgYi2c10+6FL3k2QQhmLelhn5PBOdTqBhf
   A==;
X-CSE-ConnectionGUID: sqxue2G8SvO61RTXBpNPzg==
X-CSE-MsgGUID: K4xdoxjURgWA5TVrUBQ76w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14102186"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="14102186"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:13:35 -0700
X-CSE-ConnectionGUID: DntRhM5gQ4uPjDI1MPOulA==
X-CSE-MsgGUID: N+ERQzCjTVSjL5fvvJEVaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37469191"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 22:13:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 22:13:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 22:13:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 22:13:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 22:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntaavfc2vM+CsKDNNgHxp2AvZSVl0s0Ad5sINDZVqoXpr0w1sbaBwIrdXHTNl6/RB7u/b1weQd2BlWQ8IjV+dKyRnaVVdHh0QaUVq+TP75c9o/DSk+PNP/69dSQVYZke7uD0YK2kos9WbMT1eO5Oe1adPlGJU8yonGWcBR6uY2mBPSWEEhxHebLvf/XTHCmHX9hFPcaRH9GsPu0es3dly4aMawm191/mzFD6YDFnKTfrC40RyAVMtMJyqlNRDjqYnzwuTT55s7fJXcW6gk4NF5tmKL3/Mfgdj9XfHa3e/cVOSoNrGmrIqS0HweLkWVzwpmG9Q9jD7tQ4qdAYbLtB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FijJlpe3CG1m5+59wwOmy4Q0B1yvt5GZ9jWeS2DiA8=;
 b=RxQ0ji88SJNkPlVoq8Rh8xQv1Jj4sM6oesTTjYGgUfQHWQVMhhkh1h5inv+2iEOp4ZHO1BeSNu78MHDhQeuiY5mFpEAD4CirowexxxRKJlQFDTJstzK4b3yN1wqiKsbJWhS1mPErfNMDU+718Hx5NvlvGY3gIx/2YcokU8kvkTJC8MYfGHZebAkACr5FCoK70yNmFj7oG+WX6XiVZ0xCPfDzvyX+YPywLEP7JMx9gTlnAZsvM70QdhYsWX41bMHnNbh9zbLbE+6DDx/nU1cl1j6ghlPDjevLE1IBS1cP2e4fhVFTyR7wo0BB5BfRKNGOaFJEtqgGvqorzmPkDqAeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13)
 by SJ0PR11MB5917.namprd11.prod.outlook.com (2603:10b6:a03:42b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 5 Jun
 2024 05:13:32 +0000
Received: from MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::f174:29be:e20c:113f]) by MW4PR11MB6738.namprd11.prod.outlook.com
 ([fe80::f174:29be:e20c:113f%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 05:13:32 +0000
Message-ID: <aefc6b92-4458-4697-a8ae-4625d610d00b@intel.com>
Date: Wed, 5 Jun 2024 08:13:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 6/6] igc: Fix Energy Efficient Ethernet support
 declaration
To: Hariprasad Kelam <hkelam@marvell.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, netdev
	<netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
CC: Dima Ruinskiy <dima.ruinskiy@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
 <20240603-net-2024-05-30-intel-net-fixes-v2-6-e3563aa89b0c@intel.com>
 <PH0PR18MB44745F4BE9093B23E9A59864DEF82@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Language: en-US
From: Sasha Neftin <sasha.neftin@intel.com>
In-Reply-To: <PH0PR18MB44745F4BE9093B23E9A59864DEF82@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To MW4PR11MB6738.namprd11.prod.outlook.com
 (2603:10b6:303:20c::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6738:EE_|SJ0PR11MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: b57f090b-db4a-4307-3332-08dc851e3e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHBlZ2ZCaHBmdDdVTnVPWDFHWmpXRzBFMXFSMm5RcnZsVG81Ry84Q3p6dTlH?=
 =?utf-8?B?RjA0NzRNeTZqb3ozQW13Mm9CWWlXTXF4d1drcHFUbm1DUUViRkJoTkhNdk1r?=
 =?utf-8?B?MFd3M015YWk4ekNkcjFGMWJEOVlCU3FidTNjNEVuR2FtZjN4Z1NGK3oxT0k3?=
 =?utf-8?B?MndCZkQyUWcwUXhjMmVsYk5NWjRqSW5VblVybk8wMXNTTTQ2NDljWU1wWk1I?=
 =?utf-8?B?cHd3VWZlWU9xVEJ3RzM3WDRjSXE5aWM0Z2pCWjA3eWFPZFZXSHduODVBaVB1?=
 =?utf-8?B?NXZWcDJLU3dCemUwQnYwZGxYN3pNWTB2VzFlbnlFcWRIbmhzUjcrZm5Sd2pO?=
 =?utf-8?B?bnVLRlkvS1k5ZGY1K3ZuWmNRVlRxTmdNZWtpTWIySzMzbThzcG1FdWtCRTBO?=
 =?utf-8?B?WUNaY2JvQ1hiWVZ3WmpockNXR29qelNlS25sVUVHMkFPM3VwUVY3TmV5V2h3?=
 =?utf-8?B?ZmQvZTJSSnNRd3lQSTkvZGxKd3puRmxiZHRtQUtTNUFrdTd0MnNJcWkxUWdx?=
 =?utf-8?B?Qi9VRjN4MkoxdzlOS051b2Q0TEk3OE9IdXlmakwzd1psMlZ6cTcxeUMxME9X?=
 =?utf-8?B?djdCeFJ2L25EaE1KTE5QcjlzVWFMSk1qdkphcVptVWZFYnMvc2lyMjEvdXg2?=
 =?utf-8?B?KzF2cHpoM1BwM2JWQVU5NWRuNnBmejBzRkJIRUpuelAwL0FucndxR2RGbXJz?=
 =?utf-8?B?bmVqQm43UUdKbENWYTlkZXZYMkV5TzVySjFMYk40MlFiNU16SE9KcFlDYWNT?=
 =?utf-8?B?ZUNuZU1ORHlmY3VJNVVCcUdRdWhHNCtnK2NaSEEwZ3lOMkx1V3pMN2NqQUM4?=
 =?utf-8?B?MkM1bEJnSk5ud0RGWXNoYjNmeUdQT0VNenlMQU42NXkzY2x0cjFJbG1hOXVi?=
 =?utf-8?B?bHQ1V1JzZHY0amxucFY5U3NJWUJFNjZHQnVvcEo1S3RWNnF2V0ErNDJhQWgw?=
 =?utf-8?B?WTUzNE8vNlF2YzJPY0ZXN3Q3b1p5RE4xa3VUMXQwNVFaSEdHeFhHVDUxWkNu?=
 =?utf-8?B?aWwyNndYZXI3NEdYWlcxckd1OTNXa2swOEM1eEpwSzR0NE9NMUdUYlBWNCs4?=
 =?utf-8?B?SERwTXA1Yk1VamZMNUdka0ZLSHl4dlh2SlpqZHd5Mng3WGRidE5hRDhmc2VU?=
 =?utf-8?B?MFBaUWNBanFnUWQyYW5uajFjTDVNNmxtVzdrSWQvYXVLUnRYcFQ0UWJkZWs3?=
 =?utf-8?B?UjkvSlVqMUNTMTJYclRKUGo3NURhSWxWUVpuQ3d3ekkyMXdxdXZmVjNUK2l4?=
 =?utf-8?B?eWRDaEFwbUR1YnR0Z2ZLQXd0cjBCeS9XK083YmJDSlhybGtwNTFBeCt4bHQx?=
 =?utf-8?B?RzNwTkFLcnphT2JLWVF5bkNHb1dqK3hnQkM1YXM2dkozZ0x2Rmk4bHlocERH?=
 =?utf-8?B?bTJsbkV0WVRHLzJReXVUeFN4bXlrTU42TGsxOXE0dFpBSXM2OU9YTkJzbHcr?=
 =?utf-8?B?RWZxZEdGK1B3b3h1V0RuOEZaYjVHakU3bEhLUGI3VGY3K0pBL01wUTg5TmYv?=
 =?utf-8?B?MlNVZWlyN2hhSy8yaFZVeVNFTmFoWnkxK2wyUmY1YVAwaEZxTzAwMDlkcWls?=
 =?utf-8?B?YU4vWXBwdkFRaXgzZm1tSzZobWVrRStqd3JIZm40eGFFdVBHeGpndytpa2VB?=
 =?utf-8?B?bkZPbUR6SlZnRndma3BOZTM2cVZWQUFOT1NIY2FCb0lORzVTOGkzeUo5bmk3?=
 =?utf-8?B?VUUvdVpMWjRwVkNBZkM3ODN6SHJRQ1F2dExkZUV6V2owb3dOY2V4aFBtWUtV?=
 =?utf-8?Q?ZBYcM7/iojsr9slSO/Mptq8OPdaDJplPZYncMTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVmTGxsL0Jlblg1SXA2eHdiMUt5RWZoNXE4dGdDK0x6UVFsSCszUjAwR01u?=
 =?utf-8?B?T3VVYXR2MHZUV25oRjNoVFZxek51ai82N0Z3VTdnbUZyM1JERjBLNkFHckMx?=
 =?utf-8?B?UnpZZEZkaXlpTnVPMXQ0aThwRllhbzdCYjdzYVQwN0kvSkRZK1U3K1VPemdk?=
 =?utf-8?B?UzlkVHgrWFR6T3lNT1U4U1RXcG5xQ0twcDZNdmJKRitubFdvbFhyR1J3cTVS?=
 =?utf-8?B?bjQySWZFWU40QUtnRDU4dHVxcFovaEhaQWtHdEM2VDk0Z21aaEdaQ3NXcWVW?=
 =?utf-8?B?RmFJc0F2QnpUVG1hbVV3WDNUK0tsVndXQUk5cVBVeWVIc0tNVTNSVW9CNlF2?=
 =?utf-8?B?VDRBOUtLMjdTM3RXSUFBWXpFcXdNTmVjeTRXYVlJSzVQY24vemhZTTVjOXA2?=
 =?utf-8?B?T3Y5NXFzUHJzZ1ExV3JselFPek5pVFoyL3JLUXV6eGxKbFo2ZllvTHVWekl6?=
 =?utf-8?B?am1rcmRxMjhLOWFKc3I1QWw0RnhOQ2xLdUZad25OeGNJS0Z2dllKQTBaaGpB?=
 =?utf-8?B?ekhzNktub3cyODhrcE9ibE56YWNvREFrVEpXaVlLK3ZzUlNGMWI0S3hPOXdP?=
 =?utf-8?B?QmlSMlpVY0RRN2VSYkJkZFZpKzZxZ3Nkcm1RSk45cjJlZGVITGpVVkhVdEtk?=
 =?utf-8?B?REFFNmRqczJZcmJoTDQ0eitiS0t3dGJvbXozTmxhZEk0R0VXNzE3eFFuRnZD?=
 =?utf-8?B?WHE5NHVlbHhxdW5yV2tEbXFZT1JJWnBKMXBENjNLTEF6RTBGVGs3emFMRTFG?=
 =?utf-8?B?TVlxenBrNlViVkhqTFFDcjlBRXg0UTRLTUFwandmcXJMZjd6anhndnQwbFAw?=
 =?utf-8?B?ODhXQnJ2SktkanpyL0pHQTFVUFJib28xZk9uTnBWMEx5KzRDeUlUeEx2aExD?=
 =?utf-8?B?RjhLT01CRmtJYnpvQVNLSWVLa0ttK0JzbFJzOXdKdkhaTGRYeGVCc25ycnlP?=
 =?utf-8?B?T3M5OFA0K3RYY2lDbnFYOHN1WGlHaDMvTGhxVW1XVCtsbGVodk43djBWdUhp?=
 =?utf-8?B?MHNXM3M4SnVlL1cyMmxXZTRPTWwzRGJzcGNxbUsvSW9ZOG1WQXBzYXRwd1ky?=
 =?utf-8?B?VjEvWXlBekV2ZWJVd0N0cTVjUXJJdURqQW5uZWtWMys1YmFQZ3QwVGtIZ1Mr?=
 =?utf-8?B?SzlCWm9KVGp0RjFmZ1dhUHVUSXBPcW9SVUFaL1RmUndEU3YzcjJFZDdpZ0Ev?=
 =?utf-8?B?Q2JlSmhKbHNncDFxODZJTiszVytYSGxhOWsxVjJFWndBTTYyemRGNkROYjUz?=
 =?utf-8?B?Q2EyTjl5VzRtU0RpbzJ3ZGF2VGtXVGZ4Tkp0a092WXNHaVo4c2FhdE8xNlM3?=
 =?utf-8?B?V2lFUGpwSHdodmdqaWMzZnpJQVl6RTNCOHNCdUNtQVUzN0lZTGY4Ri9xTHM4?=
 =?utf-8?B?Yyt4ZGhQaWRVYnpoaUtLMXIwUkhuNlAwOFMwS2plZUQrbnNOK3lOQUlrSkNX?=
 =?utf-8?B?KzRPSDFWMmdvWnVVYnEwckRDTkZ5S3lFbWxPYVdFRDREM2hzZ0xYQXZqaVB5?=
 =?utf-8?B?ZFFua3g1aFd6Q0NSSElrNFFHSjdEY0pvTS9qdzNDQStwT0czZEFia2VrQVlC?=
 =?utf-8?B?OXErSkVxMkxMS3dwVGwrYU9yLzlxaGFkc1JjTTR2K3JKdTd6ZUhmMGJuVTRt?=
 =?utf-8?B?aUd3R1RuQktMZm50K0doUklrZXJWV09nQUJYZjllVDJSeFpOSzhvZkVtYWZH?=
 =?utf-8?B?blNWWEE3NDRIY0l3UThLL1BqckF6THZlYkJha0ptU2FTWmcxOHc3SlQwYkZk?=
 =?utf-8?B?cE94ZWF2NWN0TURNRW12UnJNelp4OFo3MXR5clJBcGxwSVNtVWFEOGltdm9l?=
 =?utf-8?B?Y1pRbmNtalkzZEp6T21YUE8xU1RlV1FwSzBsaW9pVDZSMytXZ2t5c1dNZXo0?=
 =?utf-8?B?QVZIcFg4VktGNnBKS2VFdHYrR3E3a1Fhazc0a2FWUnpPWWR1TVNwMWRzUmo3?=
 =?utf-8?B?bTJBTEZCZW9EMEoyMnBUc2ZYRE9HeUxUb3RMbWxVM3YwbDVNWUhUWnFUOW9l?=
 =?utf-8?B?MlQ3TS9aU0VsbXpmQmduSFkveDRQeXZZTFhzZDlRMjJwTVRmZlUxR0NhTXd0?=
 =?utf-8?B?ejQxbklIdWk1ZHQ5QjZtQW5CTHllNmxSZElsUTAyTE90aXZUVFlaL0hmNTlu?=
 =?utf-8?B?Snk4M3NmSG95eXNJaTQ5Z2FDbHlUYVdWeHI4VWtEYTlmUU45N05sNGs3V1Vu?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f090b-db4a-4307-3332-08dc851e3e12
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 05:13:31.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDFyNPv5I9NPyTaqltFmYMEJ/jTZy+j8nAF6PL/u2ErNDXpzdLP47SCIxRDZj1pT9hfBpaXpzHMSgqXjwRI+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5917
X-OriginatorOrg: intel.com

On 04/06/2024 10:08, Hariprasad Kelam wrote:
> 
> 
>> From: Sasha Neftin <sasha.neftin@intel.com>
>>
>> The commit 01cf893bf0f4 ("net: intel: i40e/igc: Remove setting Autoneg in
>> EEE capabilities") removed SUPPORTED_Autoneg field but left inappropriate
>> ethtool_keee structure initialization. When "ethtool --show <device>"
>> (get_eee) invoke, the 'ethtool_keee' structure was accidentally overridden.
>> Remove the 'ethtool_keee' overriding and add EEE declaration as per IEEE
>> specification that allows reporting Energy Efficient Ethernet capabilities.
>>
>> Examples:
>> Before fix:
>> ethtool --show-eee enp174s0
>> EEE settings for enp174s0:
>> 	EEE status: not supported
>>
>> After fix:
>> EEE settings for enp174s0:
>> 	EEE status: disabled
>> 	Tx LPI: disabled
>> 	Supported EEE link modes:  100baseT/Full
>> 	                           1000baseT/Full
>> 	                           2500baseT/Full
>>
>> Fixes: 01cf893bf0f4 ("net: intel: i40e/igc: Remove setting Autoneg in EEE
>> capabilities")
>> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 9 +++++++--
>>   drivers/net/ethernet/intel/igc/igc_main.c    | 4 ++++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index f2c4f1966bb0..0cd2bd695db1 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -1629,12 +1629,17 @@ static int igc_ethtool_get_eee(struct net_device
>> *netdev,
>>   	struct igc_hw *hw = &adapter->hw;
>>   	u32 eeer;
>>
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +			 edata->supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
>> +			 edata->supported);
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> +			 edata->supported);
>> +
>>   	if (hw->dev_spec._base.eee_enable)
>>   		mii_eee_cap1_mod_linkmode_t(edata->advertised,
>>   					    adapter->eee_advert);
>>
>> -	*edata = adapter->eee;
>> -
>>   	eeer = rd32(IGC_EEER);
>>
>>   	/* EEE status on negotiated link */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 12f004f46082..305e05294a26 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/bpf_trace.h>
>>   #include <net/xdp_sock_drv.h>
>>   #include <linux/pci.h>
>> +#include <linux/mdio.h>
>>
>>   #include <net/ipv6.h>
>>
>> @@ -4975,6 +4976,9 @@ void igc_up(struct igc_adapter *adapter)
>>   	/* start the watchdog. */
>>   	hw->mac.get_link_status = true;
>>   	schedule_work(&adapter->watchdog_task);
>> +
>> +	adapter->eee_advert = MDIO_EEE_100TX | MDIO_EEE_1000T |
>> +			      MDIO_EEE_2_5GT;
> 
>          Since advertised is supported here, does it make sense add below in " igc_ethtool_get_eee"

It is different. eee_advert is an internal field in the board-specific 
data structure. However, since i225/6 parts have only one PHY type 
(unlike the i210/1 parts family) and this field could be used only 
internally in a driver and FW, we probably can drop this assignment. I 
will double-check it and clean it up to eliminate duplication in a 
different patch.

> 
>          linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> +			 edata->advertisied);
> 
> Thanks,
> Hariprasad k
>>   }
>>
>>   /**
>>
>> --
>> 2.44.0.53.g0f9d4d28b7e6
>>
> 


