Return-Path: <netdev+bounces-229970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47E3BE2C48
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41825E09FE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ABD328627;
	Thu, 16 Oct 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad732v2U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B932861F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610050; cv=fail; b=ISezNX35j7mXs4Ncw1MokJadYlr+pBPn/iLdqi9Maoc1iatP84EXYkCt82lN1AsS/qR7A3wEItxCS8NDqefyiDdaZLw6gxUC/OAa/jb2nhZGBFadXGa6dSGuNPztib7Tpta9+5YJLpH6/UlecrPMTCPQ2SrtDNEL96g4A3BbRlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610050; c=relaxed/simple;
	bh=N1X8EgfG808ijBPBo+jI6qDTdNvPWvJ5CLIK0/DibNA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mjNN/dX8z0BNmi6giS9SaCiOBWJLQthztlEPJPamPZzzeB535bjO1+FlcahTmBNcCWiEFOnH6HcTyIdQ2Ju4kGJpD55Yrw0XbVH0k3NKsJohRzVrdULv9cOyN5Wl26S11nccXZHZ+qcZYcAbuknCrB66wgnFgSiHm00RRq0pa9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad732v2U; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760610048; x=1792146048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N1X8EgfG808ijBPBo+jI6qDTdNvPWvJ5CLIK0/DibNA=;
  b=Ad732v2UclP+iMbc9rRZ+z5icwu4KeRkMyoqeCbWM3vUXJr8aOdqsewn
   92lR+F4UN1KFlP2DQ8LfD37n811E3GxJciCSeQvYYWyVv+ojyJrSvgv2+
   sycRDzoqteVMlv5wgNwfKP3B5f6rgYNT02RMgDCnCwV+8qIwfQoFfLtNR
   VmxoiIA+2YOn36rDpjR2Adz+u7SdG4Wi8rveUys2i5oSrejSbIWHkMIGg
   mie0KxZ5CLmqjvZkQ12OF+wCEaWYM5Ng3IDiSmcIndiToZR13T8oNTlrg
   l6DghSBV0IfxjcVKYyQaqvEP72ZKETin9EmzNUqtnXyty7MTDHRQCJmT/
   g==;
X-CSE-ConnectionGUID: EJ/5W1mcQj2dLLlS6ca1Hg==
X-CSE-MsgGUID: Wjr8Bq3AShCmRH86vpQWig==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66629207"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66629207"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 03:20:46 -0700
X-CSE-ConnectionGUID: yUpViSzwTqmcZ1xKfWxGAA==
X-CSE-MsgGUID: rvMkTr0lRySlTcxlZmjMww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187512085"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 03:20:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 03:20:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 03:20:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 03:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3YMRhVstN446r2VbyNQcLnylzlc3CcpAXIhgBKTI+kvW8M9TECk1wOYY8Eof17PPmV+1QYwPVvj7Wn8ZTSESsgdgaks+b3iao39FDtuO5OAMN8UmTEpf/IduFkX6P7r4fu4FVXZXhA1qZOu+9HcMVyde6zhgiK+0bPLN8gDXsD4UgH4e3EhY+nZbPPJBAHFlvrLIhtzsmpDT/2YPpi5hN5+sx7GPUSkx+dPjrsu5RBGuckyuoz89dbTEs5jfiNH4eOae2lhU1ljBckpuchwcFtkqN9tNbYWjmMh168F0EPELfhVX6nxtUOCG1PYF535rgf49uY00qHqXqYYRYlffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UV42RXlWrfBe/OffrmF3ZssQNJO1rdbYinH+SlHosG8=;
 b=CeRCvdC27aUsr54gJ1Bl9d/Dl6SFSPUNWbKr3+LYvzdfiKDnf16fmPF5cfa8z/2bDHd7O9grK+m/+NNgdWBmC1bGyXqpiFeoemKEU3si3M1AX2zjEyVuewsWjo/uBc9uPjoMGJzgJluS8pEOnWkYNgTstFSJzi4L7Kr4Z9NioK/2I6Cf7RFIfmZtd9E/U0IcrMwqomOYtX/dRXwQaFGbp6hHA82kooMM7WBxddQBHIF6Iz27IpKbyqjZbymyWyDPESP90I0BRFn/c/PdMs3qgxNZ80UmcmptrHti3yGgOnwQEG5fY3YkszHxBAtOukrPSu3tjAOHpJvgvZCIP6KlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:20:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 10:20:44 +0000
Message-ID: <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
Date: Thu, 16 Oct 2025 12:20:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251015233801.2977044-1-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251015233801.2977044-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: a209d6fb-3b42-43b4-8f88-08de0c9daa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlUa1JKMzhjdWl1SldVYzV6QXc2OHo4RTVCeldHZEVid2phbFhjaTJnOG5S?=
 =?utf-8?B?Vm9ldHgzMDR2cnUydmxpVXl0L2JLbVZVNFpCVU9QZS8vL0NldUVLYUIzbFg4?=
 =?utf-8?B?UXBKV1hQM2pENktPQ3VKUmhtU3M1aXBJWG42NGNUTGo3cVh2RVNuNE5uakhr?=
 =?utf-8?B?UmJ3YVlRQzZJR0FYaEFiclI2SGlRUDNtZDJKOXRwcXEvcVdrYittYzdFdWtW?=
 =?utf-8?B?Z2ZpZEFlRVdUUjVUdUp0NGU2UW13NWJwVDJvYmptQjJGR1hjcDdXK25sQmVM?=
 =?utf-8?B?dnpJeXd6OUdXWHJQWXRoTkxNekJoUEtTdXQ1WWhqR3J5QXdPSkU2bTFVL2lQ?=
 =?utf-8?B?dUpSWTRsQjhnaDlOdytqVnhseGI3T24yN0N0cHU0RkRYRmJuRmZwNlJWeHBz?=
 =?utf-8?B?N2tiV0Y0eCtxSDBKZnFCTUpRc0F2YnpQRXA5eUsvdnFWcVJ4MjBYaVh2Z2NR?=
 =?utf-8?B?dzBmK243c3B4UW92b1NRSUN3cGVaQjdxc2JIUnQxdXgzbUtDNGw2VTk1OCtQ?=
 =?utf-8?B?RzBERkY1VGo4cHNtSkc0c01uVVNTZFFMb0xGWnZ5M250NkdkTk5CWGF0Zktk?=
 =?utf-8?B?Q3djZ0NNV2dheTlTZW9KWjZGRWhXc3JUU1R5U3BId2w4V3VsMjhMRm11OXRq?=
 =?utf-8?B?WjR6Y0dqODdjVDRQWTFSSTVpTnNMRmlud0hvRFFkY3dKOXk3SWFSNHI3NSts?=
 =?utf-8?B?WTlTUGY4UmZ5Q3RiTlh6enJoT2kwZ05EaFYrZExwbUFlaU9hUzJjVmFiNHFW?=
 =?utf-8?B?Wm1iQkloWmVSQVpFSDAvYlMzOHk2K3dLUWpJRjA2TFBhcXdsalF0dUw4c3FI?=
 =?utf-8?B?MlduQVZxb1E3dklCV1dmRGFrWjZ1Y3lkczJ5UWg1NDFtcFJyM1pPZVFMMEJ5?=
 =?utf-8?B?WVQ3dUpwTUFLeDczRnNsR0RBWm44VXRnSis4NngxWFhtQy95eUwzMlZubE4r?=
 =?utf-8?B?clZmY1g0b1lWVnpDK0RTenR4OFVkRkhrUTZOcXUvSzhXTTBtK3k0OXhTSzdY?=
 =?utf-8?B?bElDSG9RU25SNVRIcU9vVzk2ODNOV1JodGZ0M3VUQnRLT2w1UldSZm9UWlhH?=
 =?utf-8?B?UjRmYmIvNjEyRFc4ZzNuZ1U1QkpNYTVwcDFSR0xETm15eTBEZnpxeU9NTXdF?=
 =?utf-8?B?QVNYbkZ4QUZmc1VPMmlvbDgrTnViVnQzeFNkVDZPOEZudnB0dlV4d3NQTmZN?=
 =?utf-8?B?WGJ2MkkyTmRJdDczL1NkcEg5MjRzWnhCYmR0ZFYzTmxIYjRrVnREaW84bm5p?=
 =?utf-8?B?anNqOXcyMFVGYm5nMGFVTXBnbG5kMmpDVXdtc0s2eHJjeFRRc05KNGZGQUZ1?=
 =?utf-8?B?RURxUGxRd2dRZ0lVQ1FpazZmQXMxcWhBaVRaeVZueSs3bHJvcWs4OG8xeVFG?=
 =?utf-8?B?Q0N2UGFMTjc3QUl3K1JVcTB2KzZqVXIrQTJlejVxdUFERExmRjdWd1RBUllW?=
 =?utf-8?B?RXovMTRFMk04a2R4RmF3cFNqU3drZDk5T1hQRCtkQU0zRXk4blZqNkJNL2to?=
 =?utf-8?B?NGg4eWE0U0dWSWorTHh2eno3N21wSDdLNnp4c2I2ZHhRYTIxODRYRU1paU92?=
 =?utf-8?B?a2pmM01SYmZxS3o5WS9CTk5HNGJRZGdMODgydVdrcW9uRFVxdXRjeUhHVDQ2?=
 =?utf-8?B?Mzd1VXIzVEEvUTFFSnRQMkU5SFZFZDFDTlFRV3NwcUNZdmYwa1U4T3JPT1ZC?=
 =?utf-8?B?blZPSTZLMDVxYXBJQnRDeVdhOEYrRHRQNHl1SCtqS2d1aFRtamwydk9ncklV?=
 =?utf-8?B?QjZNRlRIV3Myc25ZQkZNQTNaVWNkU1pONmw0alBUWGdCQUk5UVFCRkZHSGgr?=
 =?utf-8?B?Uzl6OEpCcnUzdXJ2ZzJjZFd4bldUeitEWXJRSlhvSXZkZCtJRmJVQWpMNWFO?=
 =?utf-8?B?Yk1CeXdGcEcwT01JNmhVWWxWTDlCZ2FFMGtDTFlFSkxBUm5EelFXQ21oVUNE?=
 =?utf-8?Q?bExbSe+RSkeJ7if02ix46P9B9OjWuqbj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdJdjJOaEYweStTSHRNRG80V1VCeGxMS240ZTF1cXBZN1FDMW1OSSt6ZStI?=
 =?utf-8?B?T3RJdHJuZjdjYUZodHNYS3FKcThzVDRvTDAzbGVyRHgxamdLK1BmT3VpMWFl?=
 =?utf-8?B?NFVQamE5YnVBV3BRdUdzRlE3YXVpQlNzYmZ3U3JwbHNpaEVveVZycjVJRExp?=
 =?utf-8?B?WlFqSXF4VzR2bWE3ZnJWZFluMjRmQWozWnhEckdJOERKODFvVzloelI2T3ZH?=
 =?utf-8?B?V250Z1pLUWRqaFkxZUtQdlZxSkRSMnV4ajBnNFlEZ1RaQjA4aURNaTN1VEw3?=
 =?utf-8?B?dk5sNGt6c09zT2dsNGIwUlNLdkhmL0x6WlZsMk1aWnJiZTZzY2FLeWxEL1pX?=
 =?utf-8?B?VVJJZ1p6b2l2ek5zZGZ5OWE5VVpFeFJLWDZPTnJnMHkyZzVlVkFxRmluZXdp?=
 =?utf-8?B?UG1LbzVOQllacmM1RWhvNWpkNStkR3ZWUjVMcEQzdDl6TlVXT0hMdzlPMDNm?=
 =?utf-8?B?NGJvMHlLdDlRQVpZczRpWkMwa3UxZnpBRzM1K3E2bFUyT0IwRDhkcEU5dlE3?=
 =?utf-8?B?R29CQzVpWVl1WW5nbmlvMTE3c3Q3bExhRnd1U2tCcWRBbVg2T204bVpwdXhI?=
 =?utf-8?B?V1VDQWw3SWlZMzA2V0JJVDZxZ3RxcFlQYUhkVTkxY25pQTVQMTZhKy80c0t1?=
 =?utf-8?B?L0g1Sk5RVU1OVTNiclU0T1JDU3Rjd3dvNm9EUWswQ1Q4WlZkRXh4N2Y5US9R?=
 =?utf-8?B?bXU1YnZwQ0Zoc3Urb0l1NEZLQlJvNGd0ZmpFUzRHZk9WRU93bUdIdlVJUWFl?=
 =?utf-8?B?akZwQ0VHSUEwMGZGTjhzWkNzZDRScm5JNWt6SUZablZYeHJHdWFlMGhrSDZH?=
 =?utf-8?B?TDhvODU5aVhCU0NhaFNRY1BQbHYyaFc2Wk5pU3BnTGJnVG84S1ZnYldmbE9M?=
 =?utf-8?B?THJsM3M5OGh4ckZXYURvTE9qeDduRUk4aTNiVDZ3QjZ2WHlXcmk2Y3dleW1Y?=
 =?utf-8?B?NnZEZi9Cd0ZCZCtqMG9kQnMySlNIeDNnUGRFL1BEVEFLMnZDTmZxYldSWVg0?=
 =?utf-8?B?Tm43WlMwY2d2VjJZU0Z4UEZGbDN0TFdwZS9aVGk2M0FLRnpJUnhmbEVvSUFt?=
 =?utf-8?B?VHQ4dVNXVEZNWjFCdXFqenpwTTdqUmkwZldNWDk1aG1UcUVzRGJzb3lkemc5?=
 =?utf-8?B?eUdoVG56WGZCQWxvN1ZiM3FVKzY4K2k5eVU2dW1OZ1dEbVMzVjFIZzJZZjdn?=
 =?utf-8?B?TE9JYjg2K1NEdDNNQnA5cGY0U3A2YncrZW03b09vM3k1ckM4MmY5eXVvYW1R?=
 =?utf-8?B?OXVtMEdYNFhleEVTclV1VUNYS1Z1bUZDa1M0dWQzT0NMZzZzdUVzNWZqbzJ6?=
 =?utf-8?B?VjU2Y1lQUkV6ZEZVUTUzMk0zaEdONlFGZFJ0aDFpT1ZrVWdZV1BiYmIxVitV?=
 =?utf-8?B?L01MRlZRRUFTSzR1SHZWekkrbkpvNmxJVjRTaUlubWRQWkNhcFRONGFyTHlJ?=
 =?utf-8?B?OXlFYUpIUmJVSmd2aE5USDQ5RkdwVm8xWEdvYmpKTENJSm1TOENoOE0yakdi?=
 =?utf-8?B?WmRxM29ncVN4MDVOVEJRU3pnWFp5bWdZMVo0RmVhT0dTL0pCR0I0Sk5VcWdT?=
 =?utf-8?B?N0hKMWlLNTJ1c2tPVVhXcWt6dVFPcmhMVitSQk5wTEpxY2x5SWk4NGRlbUhT?=
 =?utf-8?B?VGZoTHNUTm01LzIzMVlNd2NYOUJBR2tXeG5jdUU3aUhOQkdhNjc4Snl5YnRw?=
 =?utf-8?B?Z1JhTndpSjZNdDlYQUs1RHZiS2lNNnRuYkwxdVc0M290dEFKR3VRcTJHZGxP?=
 =?utf-8?B?V3ZWdk15RkFUVm16Q3phZy9BNzVTek4wOUNyMC9XbTFsUWorejI2U1gybjYr?=
 =?utf-8?B?L05jVlJNYzhkK25abFJnQ1o0Z2F6d1c0dzhIRi9qb2Q5RzNRUVNYTCs3aGgz?=
 =?utf-8?B?dzB1dXBvV284dXJwUVltQTJ1eHFqMnMwbWgrQUgwaEgrMlpCUUdNQWRzRUow?=
 =?utf-8?B?MkVUejBNSjl0bjd6RmdobVNPcFU5STNMdGw2RE13R3RQNWpjSTlORW5INVo4?=
 =?utf-8?B?NTMvb09kZS9RdVh3cjVaemJKbUVMd0hGQTArSVJKVzVZMmlPTnJSUTlKR0VD?=
 =?utf-8?B?UHNCem9Da3ZEVTl6QjVCbS96MXJvR3FaSmloSTkzUXZuNlpvQk1LRmkxelE0?=
 =?utf-8?B?UnJhNHFDdHdWa3ppa1BlcjlxeHp2Uy9HN3RIMkxKcUp6OFYvaURSTklUUmMv?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a209d6fb-3b42-43b4-8f88-08de0c9daa79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:20:44.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Fd5qyR+LZ1fQcHWx9RGfeUckAY0WqUEY8BGwdIJhb4iCOdF3Jh9GOFAi+Vhpd1+4AMdnFHwn4ANfwUfNqwivQts+qgxSy45pAbckw7YgBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 23:38:01 +0000

> Following loop in napi_skb_cache_put() is unrolled by the compiler
> even if CONFIG_KASAN is not enabled:
> 
> for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> 	kasan_mempool_unpoison_object(nc->skb_cache[i],
> 				kmem_cache_size(net_hotdata.skbuff_cache));
> 
> We have 32 times this sequence, for a total of 384 bytes.
> 
> 	48 8b 3d 00 00 00 00 	net_hotdata.skbuff_cache,%rdi
> 	e8 00 00 00 00       	call   kmem_cache_size
> 
> This is because kmem_cache_size() is an extern function,
> and kasan_unpoison_object_data() is an inline function.
> 
> Cache kmem_cache_size() result in a temporary variable, and
> make the loop conditional to CONFIG_KASAN.
> 
> After this patch, napi_skb_cache_put() is inlined in its callers.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  net/core/skbuff.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..5a8b48b201843f94b5fdaab3241801f642fbd1f0 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1426,10 +1426,13 @@ static void napi_skb_cache_put(struct sk_buff *skb)
>  	nc->skb_cache[nc->skb_count++] = skb;
>  
>  	if (unlikely(nc->skb_count == NAPI_SKB_CACHE_SIZE)) {
> -		for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> -			kasan_mempool_unpoison_object(nc->skb_cache[i],
> -						kmem_cache_size(net_hotdata.skbuff_cache));
> +		if (IS_ENABLED(CONFIG_KASAN)) {
> +			u32 size = kmem_cache_size(net_hotdata.skbuff_cache);
>  
> +			for (i = NAPI_SKB_CACHE_HALF; i < NAPI_SKB_CACHE_SIZE; i++)
> +				kasan_mempool_unpoison_object(nc->skb_cache[i],
> +							      size);
> +		}

Very interesting; back when implementing napi_skb_cache*() family and
someone (most likely Jakub) asked me to add KASAN-related checks here,
I was comparing the object code and stopped on the current variant, as
without KASAN, the entire loop got optimized away (but only when
kmem_cache_size() is *not* a temporary variable).

Or does this patch addresses KASAN-enabled kernels? Either way, if this
patch really optimizes things:

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

>  		kmem_cache_free_bulk(net_hotdata.skbuff_cache, NAPI_SKB_CACHE_HALF,
>  				     nc->skb_cache + NAPI_SKB_CACHE_HALF);
>  		nc->skb_count = NAPI_SKB_CACHE_HALF;

Thanks,
Olek

