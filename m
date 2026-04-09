Return-Path: <netdev+bounces-277098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNFlK03s12kbUwgAu9opvQ
	(envelope-from <netdev+bounces-277098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE03CE8F2
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 20:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC8A304C96F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF6F3E3140;
	Thu,  9 Apr 2026 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bM8goQPP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF113D1CC0;
	Thu,  9 Apr 2026 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758287; cv=fail; b=bkh21rxx5cP/nFXbINrIA3oUZFuUZ6pqgDG85iTYuQKeDjhs3qainCz2HOHd3WahP9iPYMsp+/HwzulwtMAhv6WdYdm+yntd6teV6NFG+c8mzQ8pjedRt+A2HLU6KBME5IyvE4NjdTYF71Ls0KTJjnjTK4lmhXHFdGkcFl50H/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758287; c=relaxed/simple;
	bh=NaNRLFht021rKhwAm44WWAhUZKZft3ILu4UE8tcNuh0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxPA6XSGOwPbPmq4cK0A06GqyBOjEVvBY05QlM4xC/sELnmoZ5zr2+R8yBFGCE7T3Q7IJ+71YF2SldlvOpGpSAMXH3LLk6fHPFXTzGP5OCBpA+yyRyZnLve2YzQuWLr2e190c9J5N/izLYAWICZsr0iA6AmPcEP5PWTvIBoAyGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bM8goQPP; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775758286; x=1807294286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NaNRLFht021rKhwAm44WWAhUZKZft3ILu4UE8tcNuh0=;
  b=bM8goQPPrGWaSlItEaVhoQ5dxwOJbPSJ2KyiTNhfpoK5KOWyzPXaUge5
   AVs88DIANJ68l0aznkln37J5DGPZbNqCnKdxCEvh7k5Gx8n3FzjrLXzl5
   +uW7/R2fi7mUqGu7PSWQ13R+nLN6hKEZ05Yv3o3e/09C7lGJXK8OXagXT
   A/vQSANAK+fsONU2UsEFNHXACbEaPrYL66N4B8isk5qWzHq+0B+XysC3s
   0i95RPZ9ukzXc5+ZFf0ng9wu6DeR6N7rKUkEMhv+qlE/UfnnQ2eg4l4aE
   d7WzJd18bzWJwTEXSm78pGGYnf3+j1s6Z2RxOmd8669LFEP03rohwUjWr
   w==;
X-CSE-ConnectionGUID: Ak2LjMWnQz6BQX1dfmrcDA==
X-CSE-MsgGUID: jMWfuB9WQiiQW2hdnk+xOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80367257"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="80367257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 11:11:26 -0700
X-CSE-ConnectionGUID: YTSL7NsnR0yJ8mAMHXobVg==
X-CSE-MsgGUID: UKFXhrpCTxmJLZnZ8KsLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="224527067"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 11:11:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 11:11:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 11:11:25 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 11:11:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD/4RUoV+/b0dXaYXCiprJXjclH5p0MNs+xGNwdwU5pUjERKj7deZdap8g4Or7s2ZWhzf802p9ExtvkevBx0Iw2YSntN9K7Wk4iQskdoIpzYPS55nCnoN4q5dg/if0x9dof/X85KovrBXWjT3yjdtDeU8H8BpbWkHJmotryZpkvJo3cYi64U4VgaaHgPCAKCRAf+3cdt2MbnCXvjN2EL7rO3jAKwjcDVdtq8msU+AEGU71+A9LQAXWmpHJPpE/WvoU3WracDziyANPTnvIQE2cFjl2MFABGj/Ubb/rDH4ReSfpEinkjnyrSlpPYMQ+GBeuNcxVJEis6GS4dIFi+W/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScW1Zxduht4FKYikXRSBsYVqWEWuPkTYtefMAqSbFWc=;
 b=WDMDQyu0OLcAxZtJcKP5Fnjm7dp4/+0QxasHLJXUsv5YQL0S5xDflTzaUKgQldhksHEZaPTnUO9EJez/ilfbCi0zVghkuo/PK82HRoLfRVAyFPQN4z0vaIr0smF1fykwIkZtb8oUA29AcxYeFJPEZmZz5qkD0zW+GMyVnRWlNwd+OqTu/ni1iRyyvvAK9UeWcmp7FR274W9O1X55Ah9JqFid/6T1Cqxs+TJVNTaYJjk31ic0Bq/bvCLr1x/2KbQbsHKDbJvOkGKnMl1DYSeXofZbKNk85Jkx5k9lP4ZlRdVFQ6wcS4GF/Q77X0KVk3y2X55Eab3GiVhmsLuIkHH3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by DS4PPFA58A7783B.namprd11.prod.outlook.com (2603:10b6:f:fc02::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Thu, 9 Apr
 2026 18:11:22 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 18:11:22 +0000
Message-ID: <225fe41f-532c-412b-bd2a-7251d05fe83b@intel.com>
Date: Thu, 9 Apr 2026 11:11:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] libie: add bookkeeping support for
 control queue messages
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: Phani R Burra <phani.r.burra@intel.com>, <larysa.zaremba@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-6-anthony.l.nguyen@intel.com>
 <b559c877-7712-4ed7-adb4-d2b667e16e74@redhat.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <b559c877-7712-4ed7-adb4-d2b667e16e74@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|DS4PPFA58A7783B:EE_
X-MS-Office365-Filtering-Correlation-Id: bd376206-306b-4749-bb02-08de966367af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0+DU1j22QtYW7USA3XvoaSmOKWactoA2I1YpcPKabUqXGz4PjhNMQApSMbSnH3838vVFoKuoepL0BQzkwRsb+megKzuXno2vH9MZMb5rrXLZbtQqm3WMXN3Rrf8tqqQw6gZ8LQgYTq/+Nz5gSQfbwTv3g6BS3bYD3F/Eh2a1UkUV6wz+LzuOVNAq4blrBy/bEwiFuvizcsbhEQ1yWSMfVKI+SsOsuOCCA4RjpZnihLooyCn93GOhtD+LYO0xhGnRjE8TLBnDOJHbhtdD9UgTq/1NytJYT5ESLwz9b2XyGTvNjV8hIiB1hmIN1CzrGrub8Pt7rjea+TxRC44PmhQxahP9iu7EgG7m81PruWpOVAnHmScZhG2ZFnI6QadfCyXGdCxREagjcTEwVqWGaTJluWndhnycfmRPpxD5uVNrh0o87IqLnch1frd+S7N0QE5Kz4fv96+wVn9+yHXs4T7fBr08qxS6Rh6BRCl9AmGOs/9cL4Bsf91nAF+fUStfxiPghyriVFy9FUFQ0QxbKWH0RBKihqw9H9EuyqMUKPcGH8hx1ErslJQ3ZlEhTE5sfdsTo36J6OmtqI4WhjI0KMc0mOt/uc4Kfm+7feI6nHwEEqZ1EdGEpdDMGvTXziOJbuC1XKu3ZPssmS0SLPPmJBLsI28v+wZn/7CjS+JXFlBZxQErLk+FSVirGk2eRce3JSNzeTnbDv8j6a76rOx0lxy8mtcbEhJEaIsMOOeVo9OyroQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJpa3hLcUxXNytJV01WbEs5Y1c2ZDg5NVVPcE9pN1JWNjZkQmVmWG9YWlNU?=
 =?utf-8?B?cER4VGJpZkVvYzNoSDJqakxHa3phbHBRekNCcFAvN1N3SkR0L2NUZml0QkJt?=
 =?utf-8?B?MUdtbEpDRXhnbkhabms4KzRtRk0zZkVycHdqMjJVSFNaQmNsdGlVYlBOZXFU?=
 =?utf-8?B?a2h1YWpTVlkweEEyOHFsL1ZGWXpRZnlQR2RPZUVVblMybFYyUlJWbFBicjBx?=
 =?utf-8?B?STAya0ZweXF3SXNpNGp5K3lhOEZnUGFiNTFzMEp0Q25LM2dHOXVsK0pXUDdi?=
 =?utf-8?B?ZWtMdFJwaXhwdXlPb1h4anZKd3ZYMW5NTTU2NkhoblpLMUN4ZUhOTEFmTUll?=
 =?utf-8?B?QXFieVVzdXR2UFRic2M2V3lkb1hjanRKVFdDRHNpOWZIQ3BpL1NVYTR3dFlY?=
 =?utf-8?B?NTIyMWlpQjdadzFUQ1dIMVE2OStNK0Z3TTFoODFCcW9hVk92ZnYrMllZNUM1?=
 =?utf-8?B?eG9FTitUbnhMM0FiZG9jTzF3d2V2SGFqRUV5b2NQaDJ5cFZOVzZZUXFNTHlP?=
 =?utf-8?B?U3k3YnlnRTRpL255aUtwclRRVGxjMVl5V3BiekR1cFZaaEVhZGVEQ2NCdGp4?=
 =?utf-8?B?MlVKOTNyNzFrMllYSGhOeDFEZC9YVm9DY3ZiQ2hFUGR2cWRENDJoemF1TG40?=
 =?utf-8?B?bDNoN0dZbVM1VktqQk5kdlpBNzFlcnpQbmVVSTJraTVaekk3TXBTV3diK2d5?=
 =?utf-8?B?bVB3bkpsSHIxdVJ5eDQ2a1VJT3kwTSsrNEhrMnJvV2VlVnQzZTg4Nk5INXNU?=
 =?utf-8?B?eGxNNzN2bWZoRktPeUtBQjQvUkxuRmFxb1FBWUpJVkxIeEY3VzF4VXNGcEVo?=
 =?utf-8?B?NEs2eUg2aW1wZXBZT1BEemJTNXlRYTFvQUE4QUJ6dUFDZThjOVMzRTlJUm1z?=
 =?utf-8?B?U1RrbHl3NFh0OXdjS1NxVGRGUGpmL3FLWnlVM212QXFvNE01dzRtZkdMZHVj?=
 =?utf-8?B?azlLSCsramxSYnZjTXNVeENDN2VqeUExM013cW9JbVFOUFJDNmRGUWxKd3NW?=
 =?utf-8?B?Wlp6cmVoTS9UcnZrOWNKeUx4bTZ5T0NabVdhU0pXWG5ZRUJCaHk3ano4N0cv?=
 =?utf-8?B?VUVWVGNtdjJTU2hHTzUxbFhYYkV4MGVOMkpBUmI0QUdaOWYrdTZaSFhvZktJ?=
 =?utf-8?B?bkRBa2U3aFgreG00di9MOXl0ZHRXNGFUMlhCejJUMTBVNFlKOUJKSUlNWS9n?=
 =?utf-8?B?TnpYUlN5a2FFb0RuejgveWd4VHdNb0RXSXBtYTZnYTBtcUUxZzBhNXVzbE4y?=
 =?utf-8?B?bVZNZHpvcTNST1VOa3E2VzZZUkxoa0owa0llYzhBdm5KM3lSbnBZZXFlT1h3?=
 =?utf-8?B?YnVpdnE0VXRncWxsOVJQSmE2c0FCbVh0MmEwaDA1V0tDRWFkS0N5WmZ0cmVr?=
 =?utf-8?B?K0hTdzdUZXZKYmMrdFIrdFRZdVVOU3p2bVpQRXJvZ1JpNnNoOWM1dnkwUmR1?=
 =?utf-8?B?RzZZSnVlUGw2a1BjZ0pkNG81T0UxN1JoeWdMVnhxMnVDRDZ3N1BpUDMxS1d3?=
 =?utf-8?B?QWxHVnVoNTUvcUIyL1NkeDhZMCtycGpMcmhEeHVmc2pnZlVzTDZham52YXgr?=
 =?utf-8?B?VFhhenFzb0tYZnBoV3Z2UkpSWGEzZjZGUFlnYUdNV0F4WW5hbWs2azU3TVJS?=
 =?utf-8?B?YWxSZXA5anFsU0V1Z1M4bytHUjFKMWIxOWRzWDZkbElZM05FS0ZXbklIeklm?=
 =?utf-8?B?OEJxM1RoWVNwcHc1QjhYdS9HZjFPV2NNNWJKTDgyOEZXNTNpSC81ZEppZnZJ?=
 =?utf-8?B?T0NGYlNxYTJxYVlTSGUyOFZadUw2Z0dBKzk2Wm1Fb3EyUjAzbURocXQxbWhy?=
 =?utf-8?B?QjJvUVF1TGRVOU04WkxZUjVDVkdBLzhiemc1SHdPcFNpeUJnNHJmdTRYUXhS?=
 =?utf-8?B?U0U3d1lQSDdYTDVTVlZ1WHdwUll6YTBNRWtMY2I5WmRWREExS0VhcTNXejRG?=
 =?utf-8?B?SWplSmp0N3N0Yi9mV2ErREJCQVRpYkxNdWZvQjk5ZExUNXBGNytTOUZxVDFD?=
 =?utf-8?B?bUladlpGV0NvOGtiZmtkYzVJdHN5ZURiMkRxYUp5VVEyQ1UveUloSmhZSkZS?=
 =?utf-8?B?NUpYQmRsOXUxZUx0b0pSNHRyb1IzSDhMbmk1dXc5c1JWRVF3K2RwaHF4UElO?=
 =?utf-8?B?a3pDU0pmYm1zc2FiNDFDZU5jQXVjRzlkNy9BWjZQVGU3YURWa1VoSWlqdkdQ?=
 =?utf-8?B?ZzRMM284S3RlS0d3dTZUNVgyTmN5RWxqalVrSFlmQTlrNUpwZlJZZHAxVDJG?=
 =?utf-8?B?a3hwSHhrQnk3dEtuUUdCYW1YWXlLY2NUMzFUTXhtNE1NeGMwOVhwaEp0clg5?=
 =?utf-8?B?Mlk5UEpSL2VOYmpLSjZvTDZFNkkvd3NxVjFMd1JVOVFlWTlWaU9yWkMrOTNB?=
 =?utf-8?Q?kRbH9x3QzaRw3bfQ=3D?=
X-Exchange-RoutingPolicyChecked: P85vUKoH+Qt4EnKDe9ZIT9O23mvGMN8AUTKBN2v0vG6Gd9X1m1kCpbhy1wTSi6yHTd24JgmmrUdbDQxf3X1gz3Cq4jBkW4OnApyvJ2Vrh8v+y7whqnfctBwGenBRzwNR+zWAZQ7Nhy8kwKTf0NtC4UIhnESCSW7mGGs//yZ7gyce4PY6X7sCBggUcFHxKpgaTAN2XEugA7tDPw7YScxRAZt9ii44R/9oWI+5SeJ7dtl7nSm7yiFucRYRvUr9Io74uIMwRQitLJMidKXgC3wm4NXX7CGuQgNfJ/NiC6XMVRrSoMpvLH17po+LQcaL2LkNVGvqckwtFqGUXTOtT5vbaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd376206-306b-4749-bb02-08de966367af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:11:22.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJA/5sfvkTHbJYRzlfzX7g4V7RIQ7qI/grVQgVwpTzD90LSh4LGnVCgdyeUN3agD5ZBXTGW/Vlb7znn9tzt9waiIHz4eK82LIAJQ4bfHy+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA58A7783B
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277098-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2FBE03CE8F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/9/2026 2:07 AM, Paolo Abeni wrote:
> On 4/3/26 9:49 PM, Tony Nguyen wrote:

...

> There are more remarks on the following patch, please have a look.
> 
> Also, it would be very helpful if you could help triaging such
> (overwhelming amount of) feedback on future submissions, explicitly
> commenting on the ML. Sashiko tends to be quite noise on device driver code.

I recently started looking at Sashiko. Yea, it's very chatty. I'll try 
to help out in bringing feedback over.

Thanks,
Tony

> Thanks,
> 
> Paolo
> 


