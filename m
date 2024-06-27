Return-Path: <netdev+bounces-107174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583191A308
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B66F281C8C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898AA13B285;
	Thu, 27 Jun 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9P1II2c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EA91386C6;
	Thu, 27 Jun 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481854; cv=fail; b=b62Kpz0TsSgs16pAU17q8D/VeGeko8p8nzBcYepAZZXh4rh0bg95mDx8GlDo9VSVCjG0LT4KQi/QYGzeGSYIl5N7JeHDoIWKp1+bAFmJGe+6Tz66U9Nt9/X0dCuKiWukCBlMtUV2xUIQsIqxmqX3VNV8hztDobU2sUYifJP7Rmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481854; c=relaxed/simple;
	bh=Vf0duHYcv/cts5jMC5lUUdKzUEXPsC5IZMJJbBYUvEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEE6dD0otH7q0ATRtFea9HVYL80k1GZT3enphbFxQhrlO8CjnoVf+36FbiB81QkzNs0vZRwxb/v7wfLkwDShNft20ia0SduXanrLg9tiolO3tvxVsxw+uSXXNzadPGh208ARoGvbPguirwD8HVElVdTrjr/WWfH0I5Jew+BYue4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9P1II2c; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719481853; x=1751017853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vf0duHYcv/cts5jMC5lUUdKzUEXPsC5IZMJJbBYUvEM=;
  b=j9P1II2ckJavPAiN/AMEU+icA7DOLRYpQm2VoANpGvoltbb9zmauadlS
   8X3SxBFlMpq7W74g5Q8QoO3oRlC13V03Vd7K0lMXg6Zc6F/7CQ7VapMPf
   2LiEmfMh04nDIsOLHWfVAnZIjOF2Qh2fnf5Chl/HceV2CzFTmS4xTepBk
   WsstlNVngoRzxzOuHV80Pg984lZseKSauW5XmKOD4qKVpXir9B4rbFY1i
   +CDVWwhzJ1zmR4B7zQ6Aqw6WrEgrUTdTKfLv3POFbmYBOdHAv4Ek1Y3ZI
   NObOM+75x/OD7bs+QwO79+m4SY0cBbiLv5X2awHO9t8mqgNAxQZxe5mXw
   w==;
X-CSE-ConnectionGUID: ssoAqawmQGiyjZN4sjoohg==
X-CSE-MsgGUID: vkqIdQ2LRPu5lQ+Tl3F9+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16744300"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16744300"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:50:52 -0700
X-CSE-ConnectionGUID: m9uKctcQRKqjAQx1xA3WwA==
X-CSE-MsgGUID: AX2i14+LSP6X5wdZ4y+RIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="48926484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 02:50:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:50:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:50:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 02:50:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 02:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naJIVwikQANu5AD4Jd5qAAKtVtTk3zNEhjKMOvEh0C2U2P1o8C0E1YjBb9OIQFMQoQK+l2X3UMs6y1WrnliXz9L9oSMVZ4S0PK1t8xq5eil4CFChMKLxIlz/VtC1axsuzN94Sju23o6KkFJHqpIV6LVOgd0BRnYSBrDbGXbxsqrIAmdAPBbZvY0yHvnK85J0AkpGOeo+2l/U6OSXWEPdnfyUQmL5drrnhXYyIA9sFBHVuvU7Zq8AhI8Nc2fsiU6dUUn4nyvJ6rfgV7eh+KpjVSqMN9j3N/Q3ZzL9Fzeiu5uqYrMn8ltpQn1ssa4ZqWkFr7N2dxVL4K4x27tXOcvBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbyLcLHsHLjwP2/4Ug94L3BQrsPEQ/lBKPdVvUIqJjs=;
 b=U5UkYRDwIkUsvq4RAjcYZGTt8PdM+lldTcdISCpgObZCmf4KdJTC2fEHQ1mwsIzKO8c9/tnMKiprwa085QYYAc0xmajuZ6mtszV6eM7VCPGm8wRmZqi7ahGoWxOfXIrrq5GZhPhGTubszMCOgAkJT42XEbbUbGR6kVZN6po29H/WzCvOsHAaWqkuSc2TL+00znmT6LruwR0CINRSNUF/dji+Evt+t0UYHRPPUjf1g6O+q+6YRE9Eye0mgK1MgNdxbW5Y6YVddbpTXZOGgFmkucUX7V2s9SfHPLLN6v9CECNiExZV+5BsnLygX0X5L9BAO0WD+qcTG8l6gR4XIIKjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 09:50:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7719.022; Thu, 27 Jun 2024
 09:50:46 +0000
Message-ID: <e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
Date: Thu, 27 Jun 2024 11:50:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-2-aleksander.lobakin@intel.com>
 <20240626075117.6a250653@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240626075117.6a250653@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2938e33b-c4e2-4e8e-a55c-08dc968e9e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1Z0WWo5T3pZQTBTQXdYcWJVRkhYdEhOd2FUV2p6T2pmbjFSSlB6enhzRGor?=
 =?utf-8?B?VmxXUFJVb0V5REM2RmdwbTAraUo3aTNiVW5ZWERicFNpN2V2Ukd3NGNpaVIy?=
 =?utf-8?B?aEhvVzBsTnF6SDhQZkVmUUY3L05rcmJ1QmppdjJMK1FQV3hBa0tjMGtZZ0lX?=
 =?utf-8?B?TGpGMnQyYzg4TWFDeFQ1KzdQQytLZE5acWp6a1ZGbFh3Vkd4dnBDL3NDUVRC?=
 =?utf-8?B?Q2VYOE1NVDhXYllqVHZ4ZnNlZ0l6YlRlQmNIc09UOXBkaHA2SlB2SFdxbUxj?=
 =?utf-8?B?blloVjZZSnBOajZod0Vtai9mTEVPYmdBNmdRRkZ2bk1LWUxKT3VoVE5LQ2Nx?=
 =?utf-8?B?Q1Uxb1k3ZGZNUUxWVWRNa1hlQVJqL0xhZGpQeTNTemdMSDcwUS9way9lc1Ir?=
 =?utf-8?B?OXE1cDdQaVo0eUY5VW1hdlpXOGx2MEJHamJoWVBmTU9CT2RPeUo0WW5nV0hs?=
 =?utf-8?B?eCtLVlBkY3cxYWt5bGVQU2Fjb3A5ZjF2cGxuRENKSXFObW10dCtIQVNEdE1Z?=
 =?utf-8?B?UnhjemRQRHpxQWZTSzc4NUZaM2l5dWdFcWZLeUI4d1NXaDhvNWZMS010M01R?=
 =?utf-8?B?UnVZZy9mcTI2TS9DRHlYRHB2dnN6TGwreDZlczVrQ2kyVlJubU9ZY29na1ZY?=
 =?utf-8?B?bTFmNmxkMVcwbzJCaXlydmdGbldlVTFJb2MxUTY0bENtTzYvTWxseVVYcGtC?=
 =?utf-8?B?OGkyNWN1R1BqMXZzeVEzK0JNMStWd1cvbFNQWC9rUDVOTTh0QWpITEdDMDdY?=
 =?utf-8?B?b3hFTUNwTmM0Z3BmUDkzbWhkY2srbWxRWHM0b2RRMzQxamRTcmljdnFwNDJv?=
 =?utf-8?B?ZEgwckVUd3NybzlteFpJVFl4d3hDbFU2WnRHK3NraThjSlhQVXBJQ0lQbFFH?=
 =?utf-8?B?TU00MFBGOEx4azFmbGR6YnA3TzM0cmtWY0w3MkxWK1NpWnFRME5VL2pvaVlQ?=
 =?utf-8?B?MUg0OTV0eE9kZ3g4aU9IVmJkcWJvdkxEanhoRmwyYW9SOGt0STJmUk1mSHJF?=
 =?utf-8?B?WDV3ZlRlTnRuWlJDR1lZdXE5ak5pdWZsUXUyVVZBMFd4SW1NTTlUNDNkSXpn?=
 =?utf-8?B?Mlc1dHZnZWlyQVFyS1AzN2h2emxlc2s2eVdHb1BRYTBPWFJWZXRpWmVkMnh3?=
 =?utf-8?B?RXZBN1VsZTJNVThiY090eFY3NGsyanhmcGJKT01xY2JVMytWS3FZbnM3RThG?=
 =?utf-8?B?K08zZ3BkaGt1VmdVRmtQM2FFdjNhdE1ZUUJUN0hjTkRKQ3FpcDRCZzNvRERy?=
 =?utf-8?B?ajZrTlJITGloK3FPb2NMWHBtWnVoa29GOWI5NER0cG1ScC9uVFQ4SnNGTmNt?=
 =?utf-8?B?Y1U4a1FjUVpDbktvNm93V1lDMGlIUzdHNk9PenRHVS9JN3hVU0RGanJtUEVP?=
 =?utf-8?B?VHpURmZNZUZndGRTT3ZRQnJjUUxnZVlmK25EOFFvbmtoaXpVT2svYTFQQ1Fh?=
 =?utf-8?B?NzlxR1VMUTJONW9CZC9VWlRoQm0vMElwT2cxTURod1MvYkJrTU1vRW1RSGtQ?=
 =?utf-8?B?Ym1HV3Y5L3BsMkR2UEJBL2F0cEJIcnB5TVBETDRWZlJmaWNLSktHeTdOa2d5?=
 =?utf-8?B?eEVFdGdSOGh1U2FJYlpJUUhMcWJUbUVhRlovQ25mOURJa0RlaE1mSHpaYVpZ?=
 =?utf-8?B?L0RxK1RiRDNQUTIxcDU4WHR2SGVsb1dLQ2J2TkNzYW1NQ2J5YW1yV00rY2N3?=
 =?utf-8?B?VTNLamRuOXROOERKUW5MZXNkSFcrVzg0Yk5naWZEWmVMTGpNRUFzc3Q4QjJ3?=
 =?utf-8?B?Y1FrUU5ZcU1KRUtZYXJDQkNvVlZtK2RYdTVYcUdiM2duUGRPSTBMSVlOZzBx?=
 =?utf-8?B?cHUySktJZEpaZjdHcVpqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmhPekYwdVRYNGp0OHYxWkd1aUoyNUY0ZHRDT1djS2o1WDJRengvKzhBWHhF?=
 =?utf-8?B?MU82TXFwcTZyVmZ0NW1oWXYwNGdFK1NESzE4bDNkOEs2WW1pcEppK0VwWFlF?=
 =?utf-8?B?c2RiRG9KdGl5emJNcTdtdGNLa0ZtYWh1SytaQnFkN3FQb2ZGbzdRQ1liNFpu?=
 =?utf-8?B?Rk80MEZqV2lJSHU2ZUdlSTFSb1VFK21ERUZ3bGlkcC9vY2xTa3RnM3lmZyt2?=
 =?utf-8?B?eldKU3JURGI3MGp5bmdUbEpMbjZyZGlWbjJESk1BRkN2dVRNRTZJL2IwTjVp?=
 =?utf-8?B?ZHVWZDVaY1AvQjlldmx0amNyOHZZaEVlVCtuQXR2WVl6R29qcEZpTktOTTJD?=
 =?utf-8?B?QVV2SHorRk04NFRvQ0V0UllSWktKTy8yelJ2UzJuSjRYUk0za05kUC9STXlR?=
 =?utf-8?B?d1BHZG9IQUFUdmxiQkQvbDRHSWZlN0N2YS9ncjduNXowZzJBTjBxQkpETjhj?=
 =?utf-8?B?RlhNWW1GbE9jSjFxLzZuM0VlSk9DTW9ncjFaN0wrYWpKWndCeUs0OVlkRWMz?=
 =?utf-8?B?RTM4aU5hM1BzemxtRnNVZm1jQUlFMjIwdHpuay9RcGxaaW5lbzlEWDExdWoz?=
 =?utf-8?B?cU5jOHNhOU5DaTVDdDFsc0lOV3V1TDVKajBJMGwxZTVBa1ZuR1EyQ2JONFEy?=
 =?utf-8?B?cnB2ZGtiNW9IejM0dUtJNFNTeDhtOHdiTDkvNjFnc2IwczVRYy91TkJmOWVF?=
 =?utf-8?B?OFhjeXl2cnIxL20yVHhzZWp4R1U2OU03ZTAwRDB1RlNZZzQzQmllRk1PTFlX?=
 =?utf-8?B?dEZHdzZmM1lWN2lIVkpxTm1sMytVTElKMGVmSzFiRHZncHN5dTdCNkxFRWI2?=
 =?utf-8?B?cnpEandhYUpZTGUyaVpkL2d2a1BWYTJKd1NGcU5BS0FaNmJTM3IySnBKRkhS?=
 =?utf-8?B?TUhOZ0RQdWl0Mko0QUJJb2FSS1oxQVU2V1BiRC9pRlo5TzZYQXZFbTU1NEVj?=
 =?utf-8?B?Y0tEOHNCM2NpcTZkMU9ZRzAvM21ta2xTeTRKNFZ1WllVMytoMHVGaXBhYkdZ?=
 =?utf-8?B?djZkcGZHcGtiQ2xBSmpZVjRNeGJPTVo5dmlxa2dQSkNZcW9tS1dOUmJwODhs?=
 =?utf-8?B?R0lGTXFwOU5jYXpLbTdJRW5MZGxqM0Z4RkFPWVVNRk9JVE04Q1VsWXQ1QzlK?=
 =?utf-8?B?QndrWXNnUzVzNHZxUkpyWnJ6Q1lGQWVWdlJ4K2dlS0JoNkdsNmxOUzZQSUx1?=
 =?utf-8?B?MldVTWo1bnpOY2VwQWtiTzRmSlkvR0dRNk1RdFhUNitYTml1YU1xS2lYTk4x?=
 =?utf-8?B?Wm5lckRBdUdxMjViRjNLSXB3MTM3NDZkTTQxbXJYNEFHVFROKzNJQ1cwSUQ3?=
 =?utf-8?B?ckhMYTExWDVqaU1GRmtSTTJJZEpTR0t4RzZ4NEhJMEJpMGdqQVRUZXhhdXVX?=
 =?utf-8?B?eWphSXF1VmIxenNyWlNQSDZMb082dldmQ21oSUwxRUdmeXRLL2JhanR0N3VZ?=
 =?utf-8?B?dGJaWFo2VXFtWnhHb3lzZXlSQlJ6TC83T002VHlBWlpoTUZkMWpJNFF0UmtI?=
 =?utf-8?B?K3JPSlloRStPZnFzcWhlVnNEcWRTVTdiYVNkVDJIa1lacm1Ka2JtaEQvYVUy?=
 =?utf-8?B?VVFKYTFIRElLL2NnREE1WHlXeUZmdE1Ec0ZXMjdzdEoxdVpybnZMdWlFL2or?=
 =?utf-8?B?MFI1dHJPR28vQjNLR0hTZTBSc1Rab2tnL2g1RFVFUU9abWZ4YU5tc3p5Vjd3?=
 =?utf-8?B?OWw2TlBOdFJuTG1WTkZRNWh5aUZ6eFVBVklpTDZ2QWl3YmFVNExEMGhPajdI?=
 =?utf-8?B?Qm42cTF1aXdtUk1IdjQvODQwZGRkdjdZV1J1VVRVS21FQjl4YXZ3VWJJS3pn?=
 =?utf-8?B?a1IvWHRzM1F5R1k0aGtlVTU2UFBDL1JvSVFVdy8vMU02b3JNK0lnRXNhTnM4?=
 =?utf-8?B?OWdENUFuWnBPN25ZclNBVFdGUGFlbjVvbFF0eko0c0FJYmxnWVVEQ09SNVBj?=
 =?utf-8?B?WUozc1RwQmd0Z0QrQ1lTaWgrd2NYNlBvd2xKd1NDcWhUZ1NXTUlRTUQzZVU3?=
 =?utf-8?B?eGs1clZkVWpzRXByUFhMeXlJQkFLeHpsdXlXbUl1TlZiTnYzdEp1S3FRTkFY?=
 =?utf-8?B?ZVFtYU44ZkpjK05iMW02WWpJN0V3WVRxNjJNMjRCbzRwaW5FU01YT29iR3Vu?=
 =?utf-8?B?UllxYU1QR09xVExGSTBUdzdvN2NIc1VJMXB0dHEvV05CaXBocWx3SCtNcGlv?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2938e33b-c4e2-4e8e-a55c-08dc968e9e31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 09:50:46.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YrEonWnL1QKEpJckrYkBCqoFUzNtyl+WrYH/TXjwbfq2EuWjtz4sScgJ6ZbpYD9s68whBQDSQzg/4WLPyRkLuJ3Z+C3enP3ZzZZoXRWT+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 26 Jun 2024 07:51:17 -0700

> On Tue, 25 Jun 2024 13:44:28 +0200 Alexander Lobakin wrote:
>> +	struct_group(__priv_flags,
>> +		unsigned long		priv_flags:32;
>> +		unsigned long		see_all_hwtstamp_requests:1;
>> +		unsigned long		change_proto_down:1;
>> +	);
> 
> I don't think we should group them indiscriminately. Better to add the
> asserts flag by flag. Neither of the flags you're breaking out in this
> patch are used on the fast path.
> 
> Or is the problem that CACHELINE_ASSERT_GROUP_MEMBER doesn't work on
> bitfields?

It generates sizeof(bitfield) which the compilers don't like and don't
want to compile ._.

Thanks,
Olek

