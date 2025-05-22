Return-Path: <netdev+bounces-192873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FE3AC1743
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C213A6421
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B102C179B;
	Thu, 22 May 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+Y01stD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680A2C0309;
	Thu, 22 May 2025 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955121; cv=fail; b=HJN4GvFe4/CnlXcNV+P1f++9l7Hj6l6JCNK1T3S7oJJztD18AcL6T5YzsVyLX+TemZO0W/corRSwcLXCJjdpiDovaVBPVUdEt1yTxQW34cRi4eEKMyNQZ+0MHvYYH4DgexFrftIdJHFHUrDQrZbNOcUQFTioy1iEMZ90jJ1l8ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955121; c=relaxed/simple;
	bh=/5jMnNZww1Pg0j00Ez9ySjbCmIz6asdMW6GJJk1OS90=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hC46SWtOIeLuvWOabWubNqAoqjXyFkPMBfqCogrjfMInT6R3hvQPc2745Qx8StZ8w+1wiuLgeX8TIJixv48FUxeWLWRAGS1xSQOUeowfutQqSVpYctnHdeabMU6hHqJTARV2BPsqihGgMiW13TeRmxmjjeXMl02F8qIJ6Qewqo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+Y01stD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747955120; x=1779491120;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/5jMnNZww1Pg0j00Ez9ySjbCmIz6asdMW6GJJk1OS90=;
  b=m+Y01stD8nqeyQt/q6Xr3VA/VB0ikGes16H/yFX5D3GY7heFSXWR3gSk
   xM3MYLDXBJT+Ve3r3seVMw/HsShDEJzNmJVW/yubybB07oytYQ68M5IFV
   sDHd8wUEacIqFgh6cDdL4Vdbj+XQw33ymSENgDNcZcvbxrz+cGGLo/VX5
   zAf8IZseQCi8kq6fky60grC1F4LcYH5cytKQfMaRUfyghjEy4fzrplZ4o
   6ZdAm3qLNn/QBAo538nP6utCMzG7tJNJiDKEqnLHERf/yAd6J/ibyuYkr
   qEk0fP0JiAZupAfTapmFdKG5mMQ6KVXC677t2jlb/AR/lmaIl8AgEUCsi
   g==;
X-CSE-ConnectionGUID: 5RBdfUQNQi+9vf+nTAiuSw==
X-CSE-MsgGUID: A9XcGq4YQ5yc7UqolWT86w==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53795926"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="53795926"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:05:18 -0700
X-CSE-ConnectionGUID: pc/8YcK7TTCzPjVZeQeESQ==
X-CSE-MsgGUID: QifXYS/lRrSUdoGx0JzWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="140689644"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:05:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 16:05:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 16:05:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 16:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytuV9cr6ubUWXQXhjAzmo+HcqQS7cxgx/K9YgU56fblvxswyALaLlnLdy+kwNk+bQxR2WJOef8+OFtyfKJ7VN4MgR8LXyse4yqaxGgw3MX5lKcezDDD+7uRMW+Hj2aWYnLb84xgwICHPu9Qlbn7GdT8cLQMziPAcTvx69GbQa3QgwOzStZTfh8Ckru3RBJb7WNZaD+jAmNm8xYTCFiDVy5MU93NFXC1Oy5vYCUACCsQZjx1Qb/3rQL0r9VUrivFaNSkDH8hWN7UOCTWWv6XkPqcKG9BmS+Kw6VuHoqCPeIWNI3gWaYyKZ5fSQ42eDIXd3qhOgZr1o+LbEaYLyb16HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyRYLIFrNYdW93b+n/xsKRiXwSNjNbx6JgDSsrQQfPg=;
 b=i9Isl/3GNXSJTTBxzacORSjvRbUYhUqswFXIwUppw64wVn+BWABB+V2G4EEHvc9Cd9L5Sek9hGkCFnztKW7MTA5NniPwKpYvjPN6gIVPOolpgJ1Jdnm3d4QqZQGaQAAe7fwZNtcYRp19j8lYs38T0+59OZMuGkGbOPI1epC8enQRjYQCJs1w2fIaHRMksaevp8VtHYuq6S9Jo62nZBzKFSVqerUARZbg4nt0EsWS7lEC1IaJ9SI2NLUpffqitDJXvjTur6tIw0lzNQHvzQOCOSR9rxLPe9p9J7vvrIBqn4yQRQk1OH7QMB2rn2ZpjunybaZ0/SeMvNEmxSVYhippTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 23:05:08 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%2]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 23:05:08 +0000
Message-ID: <c9b62eaa-e05e-4958-bbf5-73b1e3c46b33@intel.com>
Date: Thu, 22 May 2025 16:05:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] "possible deadlock in rtnl_newlink" in Linux kernel v6.13
To: John <john.cs.hey@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Joe Damato <jdamato@fastly.com>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAP=Rh=OEsn4y_2LvkO3UtDWurKcGPnZ_NPSXK=FbgygNXL37Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: 29edc701-3357-4669-3e49-08dd998518d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW5aSXNlZ0VhTjIwN2ZqMzZwRUJQaDVWeGJsQTcvVU1JbUZySjROTzZHQytx?=
 =?utf-8?B?UGp3aTYrdlo1QTZVeFc1K2UyYkY5V00zbG5BWjZaUWtKOUlEZVFMcndhamFL?=
 =?utf-8?B?RDV0NDFCRWZQZVZ0aEhBQWtwajE0OTlTZkhGMndJcHFGVkY4SFh0VmJUaGNE?=
 =?utf-8?B?NVN4RUVTSXhDUVgzNjNLakdCMWxSZ2E0dVBKaEhzSlBXWWphbGhHK016TmZh?=
 =?utf-8?B?ZTN0UmI2YWoxSWlPM0dKWjRjakh5TDA3d0IxTWdnNFRoVm9jNW9ZMkdqQUZZ?=
 =?utf-8?B?ZVIwRjd1UFpmdlY1R20rREVMQ3dsd093ZUJDdEFmNHRTRVRHMVdIMmNtdUZv?=
 =?utf-8?B?TlZ0Q29iTkd4LzJPeGhEUFEycm5hRSs3ZmRNak1hMTRERXZoQ3RudXBOTUQx?=
 =?utf-8?B?VWRVMWp4SFlBT1ZzOERBQnBjU2I2bHdLU3pYTTh2L2lsWHZzbjJIcmVVQy9J?=
 =?utf-8?B?TTF3aC9vU1VlZE1lQ1JSSy80R3IxOFMrbEIwOGJTa3VzYy9Vem81TEhCK3R2?=
 =?utf-8?B?QzFscmpWVDgwaHVCYUh6TzkxaEErRld3YWdNcXdhekM4Z2k1cVdONjhHNUVi?=
 =?utf-8?B?ZnN1TnBLUkI4ajQ4TWI2a1RHMHRjSVY2VDNQdGkxeTVTUDRaVGhacjJPcndy?=
 =?utf-8?B?c2JiT2Z2YmYxWkpuSDV0cEkxWnl0MEVaOFVpc3JseWxkbHptZkovZHFIZEdu?=
 =?utf-8?B?T2xCQkw2THA4NDdUSWVTM3dGa25FWTM4RGV4bVQrVGlLbTdMeDk3dHFad1ps?=
 =?utf-8?B?ZUVNUHh3eDhKTlV0dTlvUmJPczEzbzNvTEsxdmU0OUFJNW80Rll0WENRNjBJ?=
 =?utf-8?B?VGFvVWszeldYK1BzNTlsSW5pVzVCVTFETXpZRWplZkFZV1ZBTkVpbm9DbVZ4?=
 =?utf-8?B?UksxbSs3VFo0U2t0dWdoUHlPVTFPRThIRU5UQ3dCeDdFcmFscEU3TWk4bnRi?=
 =?utf-8?B?WEtUSFRFTXF0NW8zQ3piamwyaFpHQTEyU1NKdlhDNGJna2pxdHlNeHhDVVEx?=
 =?utf-8?B?UCtaOFFQRFBJcTlEaVNnd0JHNS9YRU5zMWx6NEhTZk9KWVBoMHN4b2ZKOGxs?=
 =?utf-8?B?OWlrT3FkbkloSHZzckRMRHBpQWZncEFNSGZIQzNvaENSeFFGSlhUWVM1d1Fp?=
 =?utf-8?B?TnRyWFIzN3huekI5cytJYnBjSTBSMG43TDlFb1Q2b3c5NFFXd1hpeUNzL1Fs?=
 =?utf-8?B?dlYrMDgxUlVqaUVlcmJwUkYzWmh6V0Q3U2RmeVFFL1hHTnlLVXRJRDU4eGJS?=
 =?utf-8?B?UHp6NWI5WlZlcE1OUjh4bTFpYVM1WkNCYlFDa1QxSmVDaVVCY3BwVjRoVFNS?=
 =?utf-8?B?ZUIvUkRjRWFGdnNmRitYbFU0NC93VUcvNzR1YTYvU1VRTE1JbmMrNmFjTXhQ?=
 =?utf-8?B?SjBaaTZCVDFZZkluN3dDR0xvMXhheE1hVlRqTHJCNUdKcFZ2c29HRGdWb3F1?=
 =?utf-8?B?N0lKcDdndHpRWjVrNjd3czlJS2pSVTUzQkU4L0VvUDBJU2xoS1U3WUpSRU16?=
 =?utf-8?B?bm1mOVVFdllFd0RYb0NZWXJDcnd5Vk9aa04yQ3ZjcXRuZ25keFF1VDBSSlhV?=
 =?utf-8?B?MFpCWW8vYmVLNU02azdvRjVPcUw3KzIyZ1JWeUxkTi93dlp3bWU3YVVMTUFV?=
 =?utf-8?B?WmJHWGoySUY1SFJDaW43T3V3ZU9xeWNUUHdWQWxDOVVBZjJzdVIyeHZpbWdn?=
 =?utf-8?B?anVaUFhYSVV0TTFwVjh0cnRqNWYzR3ZDZjJyVFNZaEh0bzB4b21Jd2VDc2ZE?=
 =?utf-8?B?bnBsSVVEQTEwVVBxNmZubkczVlhIeW5PbjlCUnNMZmw1bnh2c2kySlE4S0Jo?=
 =?utf-8?Q?IgFTl29tQrWQcT+2UiESAtP5t3AyqlFOTHtlE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJjK0NFMlc2TE9vMVE2elJPWnphV2gvazQ1MUdSbWxFRHQ1cDJJd2tXTkRk?=
 =?utf-8?B?UE0wS1hTNlB2YTEvK1ptcFRXbXQxVmtySC9lazRsVVA0VGkwcDRtZFV2bElp?=
 =?utf-8?B?dzZJbjZTMXlGTW10SnQ1c0h0Q01ocXlIdlFxT3U2ZUt6NVVzSlRQNVhKWmJP?=
 =?utf-8?B?UlR4T3pYL1owdFN6T0ZGOVZDWXpqMWxJMkhyUFlWUU12S055Q3A0M0hpUlBF?=
 =?utf-8?B?UDBEa3JYaEVXVXdxOFAzNUVvWGE5ZHlEN2k5T0hTNnBmTTREU0tHNXg3Vnlk?=
 =?utf-8?B?QzRYdlo3eThpeThTbW9lLzgyVXpncERzdDFEUDNKNWxMUkg1UGJWbDFGaUo1?=
 =?utf-8?B?b1d1VEdOKzBCVDFxYUZ1MWxRV1ArL1JYU0hYNVVXMTNiM2FMTUVvajRxU3Ev?=
 =?utf-8?B?UEtERHlSR2lydXhwNkVabndBWWVuWENkZVZYaTFMa1Vscnk2L1FveVpIUXAx?=
 =?utf-8?B?TTZ4Wnd5TWs0ZDYvenRocEpPdFhETzJGWjNGazZaY2F2Vm4xZVlPSld3MDkz?=
 =?utf-8?B?N1BKRkxoUkVEUTl1RldHb0JrZ3c5NDBBUS8zSHFpMU0xU25NMllXV0Z1TmdF?=
 =?utf-8?B?MDRkd0hNV3k1cnI0aWxQM0hXVmY0MWlBMllTbEVRckY4a3U3RlhIUURiT0ZQ?=
 =?utf-8?B?cWpwU2ZQeXRzdEVvTDVxWmhSQTRLYVJUWkl1dWlXdVhwZjlrOExhRXNObTcy?=
 =?utf-8?B?YzBwQm5NQkdJUEpKaXE1REdPL3RycnFwZ1p5UEpETGxuKzR2V3dIaVcrb0Zp?=
 =?utf-8?B?UXJVRElDNEEzWGg0WnVnekJrNzMzUjBwZ1VTYlFBYWt0anFmNXZUWnV6Y3k5?=
 =?utf-8?B?bzN0U0xWZXhBYzNvb3pkT3NOVzVnc1NwVkQ5SVlNQlIwVGY1TG55azZlNzBs?=
 =?utf-8?B?WW0zdk9QTm5kRTFESjZrbjYrV0lLdVFNendwcFcxd1ZmZVFKSEdKVlR6UWpy?=
 =?utf-8?B?S0JVcFZNSE9SOG9PM1crWEhrRER2SUtVK0hoN2ZPb3laNzVzLytrMm5QcC9i?=
 =?utf-8?B?VEV0TU82YUpKZ3ppb2tSTk9PaXJLUmU4MzRGUzJmajl3bG5VM0IxMjNsTG9M?=
 =?utf-8?B?a2YvVm51QnMxOXVuK3BjZzFIMTd1cXppWGR4cDFydmEvNjF3OXdmazY5QVJM?=
 =?utf-8?B?amUrcktjUWhuWU9mSWxlYzNUODlJT1RzZC9tekNQUXJ3TXo0NEc4VkdsaXY2?=
 =?utf-8?B?RXF0OGhvWDBQQ0xMUDZGcm11ZXRRZ2ZzR2liT1ZYOHFCQ3pRVGhuNGE3N0RE?=
 =?utf-8?B?T2JUc3dQWEJpN3lPRWpjQzQ3L3VBcEsvODcxbzd3UTBwTlBJQmp2QWF1cGow?=
 =?utf-8?B?TmJST21hUEwvSWFLN3B4aW03TGJRWFh3NnRpaGZsZlF3cVU5ZzVhZzVBVXoy?=
 =?utf-8?B?VVl0YVNjK0Z2K0c0SUJuWEZTamlwMC84S2greEdDZXl1anhHOHF2SjlMWU5O?=
 =?utf-8?B?alFMaDk3eXMzMWttb3VhL2ppNFJsemt6MEN6eVNxVmMrUW02V2o5Znc5eE1B?=
 =?utf-8?B?WnRzb0x4MmhuK25vSlFCcEFBczIrdU9lZUxIcG5WVzQ0K3FRQTJVeHdqckd6?=
 =?utf-8?B?Ulh4UXB2T2k1ZldEWkdkU0hYQjJJS1RRMC9pWWNYVW9ySzV4VDhJSGp0Sisz?=
 =?utf-8?B?Q0c3Y082eHcrdUdGdGZobUNId3pDTFgxdTFFWXR3TmhaQktNQUNtR2cwbTFF?=
 =?utf-8?B?b0QrSUJ1MnBvNXlHZi8zMnU3VUNXbkErMm1FT1hMeTMyTGc1TzcxTTZLTVda?=
 =?utf-8?B?NlZUOC9HYXdubjMzMjhqZUMrOTJLRjc2ZWhIUXJTcTF2RXRHUWpCVG1uemFn?=
 =?utf-8?B?dGk0ZXNuT0JHc1lITjlEaTZmZmVYWVpveHlPU2RLUStXbWRPNjlVWTNKU0Fj?=
 =?utf-8?B?c0V2MC9jdjl2WWlYcVZMUFNUNy84MlFxUVREa3JhR1lTR3l3MkJhRkZNcWNh?=
 =?utf-8?B?T2ZOTHl1dFJWc1pKYXRsYkxQNUl0OE9jNTBnTHVQL096VHJJNDg2dlEwT29V?=
 =?utf-8?B?UjNCVHI1Y3F5L2hZTndHeXdPa0R5VmxGOWJzY1hKSWpIQmoyWmduOUNFTUhp?=
 =?utf-8?B?QjV4ajUreU5MWkJjMFRJeUVSc1lQcXVnNmdlcFVsY1dMcjlWMlpWZ2RrbEVo?=
 =?utf-8?B?a0RtQXEvTTcxZGpxdDc0anNNNDNGaWRNWjVqUVYrYUZUL3R1RkNKU1JQdjI3?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29edc701-3357-4669-3e49-08dd998518d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 23:05:08.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/OtdvdfQtO020dmE3cg2lLFkwISGbz2Ls08xRKoaztcru/giJ8ecvd4YaWi9pDJZCXlYX24Uv+UoxGYqvUWvWRWRD919/2LhHLv4SRJXFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com



On 5/21/2025 5:52 PM, John wrote:
> Dear Linux Kernel Maintainers,
> 
> I hope this message finds you well.
> 
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.13.
> 
> Git Commit: ffd294d346d185b70e28b1a28abe367bbfe53c04 (tag: v6.13)
> 
> Bug Location: rtnl_newlink+0x86c/0x1dd0 net/core/rtnetlink.c:4011
> 
> Bug report: https://hastebin.com/share/ajavibofik.bash
> 
> Complete log: https://hastebin.com/share/derufumuxu.perl
> 
> Entire kernel config:  https://hastebin.com/share/lovayaqidu.ini
> 
> Root Cause Analysis:
> The deadlock warning is caused by a circular locking dependency
> between two subsystems:
> 
> Path A (CPU 0):
> Holds rtnl_mutex in rtnl_newlink() →
> Then calls e1000_close() →
> Triggers e1000_down_and_stop() →
> Calls __cancel_work_sync() →
> Tries to flush adapter->reset_task (→ needs work_completion lock)
> 
> Path B (CPU 1):
> Holds work_completion lock while running e1000_reset_task() →
> Then calls e1000_down() →
> Which tries to acquire rtnl_mutex
> These two execution paths result in a circular dependency:
> 

I guess this implies you can't cancel_work_sync while holding RTNL lock?
Hmm. Or maybe its because calling e1000_down from the e1000_reset_task
is a problem.

> CPU 0: rtnl_mutex → work_completion
> CPU 1: work_completion → rtnl_mutex
> 
> This violates lock ordering and can lead to a deadlock under contention.
> This bug represents a classic case of lock inversion between
> networking core (rtnl_mutex) and a device driver (e1000 workqueue
> reset`).
> It is a design-level concurrency flaw that can lead to deadlocks under
> stress or fuzzing workloads.
> 
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.
> 

This is likely a regression in e400c7444d84 ("e1000: Hold RTNL when
e1000_down can be called")

@Joe, thoughts?


> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.
> 
> Best regards,
> John
> 


