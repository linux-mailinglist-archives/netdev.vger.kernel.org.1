Return-Path: <netdev+bounces-285510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL+dDdsC/WmIWgAAu9opvQ
	(envelope-from <netdev+bounces-285510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4264EF38E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF50C30146A5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54265344040;
	Thu,  7 May 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb3XJqik"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634082BDC23;
	Thu,  7 May 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189015; cv=fail; b=O6j2SV4Z2yLLd/nCYOrVShX4sJ7WT0MQMcQsV5BzoOXttm2YAWrJWtmZaUG6B/YCVrcg5oKN1UxeJXuUFywwqapj5F48zt3F2TrX3g9+q7QqrUyxa7Gr3yA9VJL8bsxAzLFwfaKwDsTjpX0MefSrbPD4Ukh4VUu4ONkKh780I/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189015; c=relaxed/simple;
	bh=VKfzL4AbLo0K3u+g0mAd64QRgJUG7KzdLEFnLlwS+zw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlDnmqWA8qKlCXATqfIBXBbaxhKpMPSsPcIJhCElCmoMN50oCVcbsDDJ4linPzmTdmy9BiRlifMbRQkTx8tjNFOzzkz9PdIgGLbwpjtRA3/XsQpgdCvBVgiT9MavMeRHjaxNNRWFYyxxu0zsT1rZe/SXdpYzVjWGh6fz+EOXxv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb3XJqik; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778189013; x=1809725013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VKfzL4AbLo0K3u+g0mAd64QRgJUG7KzdLEFnLlwS+zw=;
  b=Tb3XJqikZp2WxgzLce9TU412zrESHz1ibOY0PW8CcHpGhMe/K/zjVOGf
   w48qk74FYY77K2orHUfG7xB0XUwTbh51wUKHS+4qi/kMVIkU50s2UdPrA
   WZTbgeVoGFjuUcCyRqFL/ZUI8mAmMiVDgOaOAr9W9wqCTlj6NS0MI4HOM
   ifk7X7ovx+jJNTydfs+MbAuYDPeM24EDw3x4rPsNvZrm2J5A/47W2v0AH
   AzFX9GK0WVvuRTyeQWJpWHAImtUE7dKXFJ9sZZhPE277SaX8BsaaGdUch
   OZaOgK7JNYtZj1ly72EjfgAiJI5o19bznorny2GiQVuh3JDHW6rYySALx
   Q==;
X-CSE-ConnectionGUID: 17VI3zWnQRy8mj6EU1nnbA==
X-CSE-MsgGUID: sQW/seOsTMuo36w1GUwc+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96580367"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="96580367"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:23:32 -0700
X-CSE-ConnectionGUID: t39bEYuLQJOAte91z1xtTg==
X-CSE-MsgGUID: Yn2HHYhXT2uX4WvvKaOibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="240565153"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 14:23:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:23:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 14:23:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 14:23:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MowFktH26E4OPGwvC6dA5iPQy0+un+FSkxcj44SKuhgNu6U9znkjb68Q1lSQbC7Gk5FXiK33X4tUaPm55PcevUrfMVwgOUUA8U8RTGnnSZktqxNQa9KiUfqmbw3dwoDLGBuKBXl2Orhg1civNrSAdzrlZhp+EW7pqy83TKTVshxuL69IM4gu4yWx6KediO9B0gMsm6okQzzOlYIlZ4LULTT8t8nmuYSb1FJRoHBhdBsqGBD7GTG5HJ6cTC97IPaoKVQ+/gBXe0l4b+MtPaeRoB4hc4lWULC/sRt8J28n3wKi80pxqa6J4QhbSmx5iQShKSc/tfys+WMadK/wMjwfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9HREcbGRi9Or4zBEM2XDkwPO64GlDqgvg9qM3uh6vs=;
 b=KGv9KpVWkMd0Q/OaCjvhGnvQGYjKtesERZ8QyX+8hNssJJiUWdmcDdezbCCWXavV9ViaF3vpvMfyDqxwnOasujL+7RWBnq6kQvIrKEMcXfm7SD2BgxIABe788DBBGY926fkUJsT1l+Lbb9PPP4s15UThIC6iZuHVXSx8//Pbo5aKRF2YimoF2aMERyQ8sOSwnhEUW6K7S1y9/W9WEeYjn3dZHj/pt7LRD2lfoNOSKJ7f9pdNvx8lXty9nIEHOWzU32luGbnxpS0s7pOU45/PIlMQdrFsDppaQB/E/QENc/6x5jIxUbP+EKnUzJfdGmdxUOLPImbWH2d8YlGbcxp6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS4PPF890B596B9.namprd11.prod.outlook.com (2603:10b6:f:fc02::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 21:23:27 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 21:23:25 +0000
Message-ID: <4fb57921-33a6-4ab3-a0a8-9b8c3a48fd24@intel.com>
Date: Thu, 7 May 2026 14:23:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] gve: implement PTP gettimex64
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <jstultz@google.com>, <tglx@kernel.org>,
	<sboyd@kernel.org>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<jordanrhee@google.com>, <thostet@google.com>, <alok.a.tiwari@oracle.com>,
	<pkaligineedi@google.com>, <horms@kernel.org>, <dwmw2@infradead.org>,
	<yyd@google.com>, <jefrogers@google.com>, <linux-kernel@vger.kernel.org>,
	Naman Gulati <namangulati@google.com>
References: <20260507211304.3046526-1-hramamurthy@google.com>
 <20260507211304.3046526-4-hramamurthy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260507211304.3046526-4-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS4PPF890B596B9:EE_
X-MS-Office365-Filtering-Correlation-Id: cae7dcab-0c2a-40d9-45c7-08deac7edff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BT/KRzTL97GUgH3mz3IhyqZ3UnYUy3IAlJrx88hpY1OnqJ66HaOyntt7BL0ypfA/qZFhMX7xgw2Oxk65xKf0ZSGlRbU2ULbnveaSJVnh6wVr9W3nEO4LknJZWzqqiGRWjwwFljYElrZDCaS8SouhLJ036m0r7oyya4o3XCcyC9AYF4/4148mVwUFq3QREQKPbYYutsqKHR2HtLi8q+nklWS7icSiIi3tgKcCVEENCTGmdkzi3ZEcCap9lA5v/vIKgMCIDMjdOnXS5YKxHk9CIiyZe1QQoDDXnNwYHaaCBs6F6CHKwd4fGZjgpi1qazaxDEtn7omXl05Usoqb5fBE/Bk3lT/x1McMomfOXRZw0CyF2ZdPHZph/jed4RfQykXgnjr91M/q4ksDD7tiZ3BEY5oz/CFn6jJTC5lhYoCofsTWyxIOqMePdmmwL0+2dDGc/Ofp+860SiFQmkZdhrVYJjwS7c/W3Fpn25CQJOMcExvZSa5Pzd0dlyTOkykixZj6uiq/lf1RPdMkpHX7S1y1TR7Rt+pIUNYMWTSY44RcLo/nh65XiGw6DjPhRk7oGD3P0l/du4LtgFXK+FMmF+KQr8rXDANwy6n6x9wo+g7/lGLbwDNMIlMWBamO5ZXO2VasPeQPoAsImVCu3Bx8M8MCvYWb6H48L3NZ3sFPI+b+jel84u/tbo3TwLOrM+/Yzp1M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M00xNVMrTUFHZzMyR2Y4SE04U3NsdFdsSXNEZFB2NVJoL2F4Yk5pczhWVlVu?=
 =?utf-8?B?NnNJNllFY0YvZDVwODFzMjRxbXREVUVxeUtsbzkzK213OUdVQzl1V2c4WDVt?=
 =?utf-8?B?RjNuRm9Jc2VaNkpUcVRWRVpzbm1HKzVxeUpMcmhSRkE5bWhsSTJvcnZnaysy?=
 =?utf-8?B?T2hrZkFKTXl1eGJSa1pEOHQ0WE9Sbmw1Q1ZqVVJJd3c5cDVrOWhLNmJMeFow?=
 =?utf-8?B?bVJyK2xtWjYvQmpGVlEvZ3ZiRlJEdnAveEVWck1HMlY5NmYzb2hIZWxEb0Y4?=
 =?utf-8?B?VUt2NEpSMDlJVmJQSGhGVmJPdHRjOS8yc3VjYW5JbDFmc1dVdENRSkI2TUxB?=
 =?utf-8?B?OWtwQ20vaG11MjRMdlIvaVM1ZjN0SEJtVUhqQUJKZDBCVlgwREI3anYrWG9U?=
 =?utf-8?B?VEVYS1gxbVVOMGVORklzVFViVFVsWEJNMlpreS9wZnErZEErZG5LS3RYOU5R?=
 =?utf-8?B?dEtZYUJFVmJOdlFBNFdrcWxZeHB5My9NV1doMjlDbURKeEhxRnlya295d1Vh?=
 =?utf-8?B?SlBsRjFjK0hVd1ZscmZ4ZTNkcGNRV3ZkamJMczZLUlFPcUovb2ZQWFZHSXpB?=
 =?utf-8?B?ako5Y3lacVdtckRMMWREYmlwRm9kOXNFdGFEK0FGZmNMZXhZalBpaTNRS0ps?=
 =?utf-8?B?ZVl6Rnpveno4cWczdTZDUklCK0JlTVUvai9uV0NEeTUzNllRMmRUbHpFYzdt?=
 =?utf-8?B?WmtLcllWcENlaFVwbjZXdWtBN3JRMnYwcHN6ek5VMzNlOUZHaDlkZGdWdkd6?=
 =?utf-8?B?RGJGQ1Nqak1VNEJQOE9IUDdZSmxXc0Zmc3IxbjFBSWhLakdPZmRISms4WEFz?=
 =?utf-8?B?MlA1VVY1UVYrM1FsWHpkOTVEdWYvcGFEd1RmdDBpQWdNbTZiWlRLY2syaXFN?=
 =?utf-8?B?bVVPSXR5TjErWG5TanhoVkNYczlCMFVjSU1adXE5eStaZVRjL0dvNXdOZDhW?=
 =?utf-8?B?anNNYVNBai92d2pqaVBMQkJXekZKb1hMSytIYndNSXdoeE5rVDZZV3doRld3?=
 =?utf-8?B?M1UxM2Uwc2NDTmRmOCtnZ0dFZGJJNGJlQmEwc2VaeENHM3ptKzBBb0Z6Yjhm?=
 =?utf-8?B?eUlrMlk0eTVOZEd0Um91SmQ1WUVTbWQ4Si9RSW5LQkIvYzFycEVnbUgxSnVO?=
 =?utf-8?B?N3Nia0tzYzFBWWFIS0E3bnNrSUlTR3dVdU0rYUcvdzlBMmxFM3Nqa0ZSYnZP?=
 =?utf-8?B?RWxseXRMVFQ0TjBNMWxaSldtKytmeFcraVVSbFhTZ1Y0Z2ltbnFLZ1FpN3N6?=
 =?utf-8?B?WnRkd05BakFuRXdiTFVucGk4M2F5QVFNY3F5UHF3ekthQ1VIYkx4elVmVHdO?=
 =?utf-8?B?WFpPdjhtRWwxSm1vN0NMT3I4RW92ci82WTFrb2V1WEdEeDlwdXUzOWlqd3dV?=
 =?utf-8?B?ay9keEV0bDJUVlY4ZUloUWJSTWs3Z00yZkxMMHNpWno5dVV1MlBZek1ab28x?=
 =?utf-8?B?YWNjSlVPMlpUQ04zTEduaEc3YjNCUGNqNGdCdTdGc0FYekd2VHczUHhsVElm?=
 =?utf-8?B?ZTI2TmUrenQxVFBENVYzZnlWT3VaeTNQT1RwaCszQUhmdktUeDFqWmVVb2s2?=
 =?utf-8?B?R0hVUTEyaTI0Zm9LK2NhblZTU3BlYy9aQU1OQ1ZMYWEyVzUwb1ljUlgrTUdU?=
 =?utf-8?B?eFA1T1FqNWxrVUNpNi9FdVJKUFlOd3c4cW5kU1Vrd0VtbzZyakZOZmJ3QTZI?=
 =?utf-8?B?TEZQQ1RZRWRsSEZ0NVZVaEFOTkJmakV6cGNNc3Q2KzQyOHBKQm8vTi9hc3Q1?=
 =?utf-8?B?QURUUHBTYjlzRDRSYjV6cmhTcjVacGl1QnExN25QOWp0ZlY2LzFsQzFOREY0?=
 =?utf-8?B?R1cxS3Jrdy80QVhVakU2VmdDM01CcGxRUzgyVXQ1OGpPVU9ESGlnUytjN1RR?=
 =?utf-8?B?anRmSjBIL1grSWQxRDBjM29MaXJSUWxYSWlXMC8xeGN5VTQrWjRKV3RLa0d1?=
 =?utf-8?B?MlJseTE0RitkQ2h6RlgyTUJnQzdySU54ZjdYUDRrSnhiTkpYbjhJRnJPaGZq?=
 =?utf-8?B?aTdybE1neW1YeEx5Rm1uVHc0M1lEU2M2ZmdSSjRMUlZ2VHl2cyt4WkdQaEdh?=
 =?utf-8?B?ek0xcS90Yys0aWxoWjN3bHkvMEhiT2dUYURuTGpYQ1hnVnIvUC9QN01KZ1NR?=
 =?utf-8?B?Rmo1cklKTGR0LzhkZEo5eGVTdUNQMkRQaGdCdHg1aWFwWS9JaVQxYStGb0p2?=
 =?utf-8?B?QU14THdra3cyNlliYlNvVjVmU0YrN09rcVh0dU9CRFVKVlJmekZtcG5NK09r?=
 =?utf-8?B?ZWVxd1ZMN0pZSVBFMUtMVzJxQjZQS1MwMTdxdDdzLzN6clJOUHVHbyt3QlJX?=
 =?utf-8?B?L2UvZ2dYTWpidklvUWJhN3licDBTWm40czFCenVLelBiRjQ3SUFZKzhSZW50?=
 =?utf-8?Q?c0ZULM0yVljh2xB0=3D?=
X-Exchange-RoutingPolicyChecked: LV0UgwNd585A72fAGSpPLXLAXiuok1Unw/5NbyOgCZRnV5MXR6tSwQQpXU17d8VmlJrKRSba2r2kFglyd+bbLHEY6Ga6QRJWBiTPubsIpSNvv3JKH2O/0o0mp0eTe277HbTROaqQ0rRNHeNsslV3ipYP/MBlwPaBTtH2csq7SN6Z0C5nYkG2Bw48b58cuteZUxjebqe26CRs2jCfeyiaSSkn7mcFIZUKm8FCUGOLDT8czbWZ1toNiWB2CPlM8E34HqmPljRkvWBWSKuyGF6lIDYrwmBNK/uYITls8RLQjENQjLvmTmfu+NDA5o7nIy2pLS8QhTAsbEeoGpVjDCQM/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: cae7dcab-0c2a-40d9-45c7-08deac7edff4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:23:25.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUzEAB3eJuhkkTbwQIyDnU4uEJDocUsRWTyD8FQqRSCPMPSkZAiZ+b7oX8a+uKSA0zT8DiGdPlEvcFxrOrgOkQ4EbyDOzyLuG6DcxEcKYCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF890B596B9
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: BE4264EF38E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285510-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/7/2026 2:13 PM, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> Enable chrony and phc2sys to synchronize system clock to NIC clock.
> 
> Two paths are implemented: a precise path using system counter values
> sampled by the device, and a fallback path using system counter values
> sampled in the driver using ptp_read_system_prets()/postts().
> 
> To use the precise path, the current system clocksource must match the
> units returned by the device, which on x86 is X86_TSC and on ARM64 is
> ARM_ARCH_COUNTER. The clockid requested for the cross-timestamp must
> be either CLOCK_REALTIME or CLOCK_MONOTONIC_RAW. These conditions hold
> by default on GCP VMs using Chrony, so we expect the precise path to be
> used the vast majority of the time. If the system clocksource is changed
> to kvm-clock, it activates the fallback path. Ethtool counters have been
> added to count how many times each path is used.
> 
> The uncertainty window in the precise path is typically around 1-2us,
> while in the fallback path is around 60-80us.
> 
> Stub implementions of adjfine and adjtime are added to avoid NULL
> dereference when phc2sys tries to adjust the clock.
> 
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Kevin Yang <yyd@google.com>
> Reviewed-by: Naman Gulati <namangulati@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v6:
> - Added a fallback to driver-sampled time sandwich that is used when
>   the following conditions are not met:
>   - The system clock source is X86_TSC or ARM_ARCH_COUNTER
>   - The requested clockid is CLOCK_REALTIME or CLOCK_MONOTONIC_RAW
>   - The architecture is x86 or ARM64
> - Added ethtool statistics to count how many cross-timestamps used the
>   precise path versus fallback path.
> - Fixed printf format specifier.
> - Added stub implementions of adjtime and adjfine to prevent NULL
>   dereference when phc2sys tries to adjust clock.

All excellent improvements.

> - Moved system time snapshot back to gve_ptp_gettimex64() so we can get the
>   current system clock source from it. It is OK for it to not be inside
>   the mutex or retry loop because lock contention and retries should be
>   extremely rare, and chrony filters out bad samples.
> 

I'm a bit worried about this part, but if I understand, it would only
affect the fallback variant anyways since the clock samples are taken in
the host in the precise/fast path.

> Changes in v5:
> - Reformulate retry loop in terms of total timeout (Jakub Kicinski)
> 
> Changes in v3:
> - Take system time snapshot inside the mutex
> - Return -EOPNOTSUPP if cross-timestamp is requested on an arch other
>   than x86 or arm64
> 
> Changes in v2:
>  - fix compilation warning on ARM by casting cycles_t to u64
> ---
>  drivers/net/ethernet/google/gve/gve.h         |   8 +
>  drivers/net/ethernet/google/gve/gve_adminq.h  |   4 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   3 +
>  drivers/net/ethernet/google/gve/gve_ptp.c     | 237 +++++++++++++++++-
>  4 files changed, 243 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 7b69d0cfc0d5..4de3ce60060e 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -880,6 +880,14 @@ struct gve_priv {
>  	u32 stats_report_trigger_cnt; /* count of device-requested stats-reports since last reset */
>  	u32 suspend_cnt; /* count of times suspended */
>  	u32 resume_cnt; /* count of times resumed */
> +	/* count of cross-timestamps attempted using system timestamps
> +	 * from the AQ command
> +	 */
> +	u32 ptp_precise_xtstamps;
> +	/* count of cross-timestamps attempted using system timestamps sampled
> +	 * by the driver
> +	 */

Helpful for analyzing when its not working. Nice!

> +static int gve_cycles_to_clock_fn(ktime_t *device_time,
> +				  struct system_counterval_t *system_counterval,
> +				  void *ctx)
> +{
> +	struct gve_cycles_to_clock_callback_ctx *context = ctx;
> +
> +	*device_time = 0;
> +
> +	system_counterval->cycles = context->cycles;
> +	system_counterval->use_nsecs = false;
> +
> +	if (IS_ENABLED(CONFIG_X86))
> +		system_counterval->cs_id = CSID_X86_TSC;
> +	else if (IS_ENABLED(CONFIG_ARM64))
> +		system_counterval->cs_id = CSID_ARM_ARCH_COUNTER;
> +	else

No single kernel can be compiled for both CONFIG_X86 *and* CONFIG_ARM64
simultaneously, so there is no need to check in sequence and an
exclusive if/else path is fine. Ok.

> +
> +static bool
> +gve_can_use_system_ts_from_device(enum clocksource_ids system_clock_source,
> +				  clockid_t clockid)
> +{
> +	if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC_RAW)
> +		return false;
> +
> +	/* If the system clock source matches the system clock
> +	 * returned by the AdminQ command, we can use the system
> +	 * timestamps returned by the device, otherwise we have to
> +	 * fall back to sampling system time from the host which
> +	 * is less accurate.
> +	 */
> +	if (IS_ENABLED(CONFIG_X86))
> +		return system_clock_source == CSID_X86_TSC;
> +	else if (IS_ENABLED(CONFIG_ARM64))
> +		return system_clock_source == CSID_ARM_ARCH_COUNTER;
> +

This feels a bit duplicated to me, since you have the same check
elsewhere. Would it make sense to pull this to its own function check?
Its short enough I think that is only warranted if you have a true
(non-nit) cause to make a v7.

Thus:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

