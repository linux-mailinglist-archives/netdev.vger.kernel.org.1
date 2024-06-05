Return-Path: <netdev+bounces-100860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE58FC4CA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744B4B20C87
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935818C35E;
	Wed,  5 Jun 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0qHOLsN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375218C331
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573373; cv=fail; b=ASENx3M2+Yolew6z5WD7SnStxTV9IM9+Nxp43hpwS3Zz75t5SO48McOsv26QP+1bPLOrJrjJsduUBFQOZHtBijaV7QH/g20btarvJUFE/MbqSxNkPlP2V8NkqyYcJi7RPDmkVlL/sH4pcB88+cegPuW7PDFwSgTJgysL7RRuf/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573373; c=relaxed/simple;
	bh=hgSDsspeyBuV4tqiUnFLBng60lLCptYH4Q7F+TIXP98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jTxN0Azq1LFOK8peYyv9ts2kx/qW5LyjgWGmEJfZzASjvY+zs8fDOtmctoUfAHRBKt6onmJWcQQSN5aYyOFI9CVOf4kQ2qcy9cEZcsm5a3EzZEp7sONckiyiUU743lqzg9Q8weW+HvA4aUXPIz6jRIAH2EDx/hev6yHYwdchbgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0qHOLsN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717573372; x=1749109372;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hgSDsspeyBuV4tqiUnFLBng60lLCptYH4Q7F+TIXP98=;
  b=m0qHOLsNfXPps9MjxhPgjIwTO7vCfk8nh9jBa5kaEUbJCKLwzO5WyUSN
   Ozysw9p8+npEKrPNwVz5oPZryVg8V2NLZrXZCmLhvPHhzrLOGs7WkhG9U
   IXMc9Bgh0CsPCu0SKcqWtkel+gllaVUtia5ctLKnDcOBu4kyGwGP3mr5Z
   vYL3S44vlDeAiwTxmn2wegWLK58zgJBvKi5kbo7+pvVq6I2zPYltjvR7M
   bw/qrzTaKdCw+PwvfqbYkv3XSLh60L9s8fS826nSxNrs6+nHLBCn3JyoQ
   EsD58v90GagYC/OrlUk6bRbO/Z2ftpXvwwfgpePcNbk6k0F9/i8xDmue4
   Q==;
X-CSE-ConnectionGUID: Wnt2Q6UZQBW7/VWRr3sZhA==
X-CSE-MsgGUID: ng0gRJ4QTdiN95MsIOByvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="17948399"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="17948399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 00:42:16 -0700
X-CSE-ConnectionGUID: mg00VNPyRXux9cr4FEmWxw==
X-CSE-MsgGUID: 4aPH0gosSoOqEzuDtkNNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42618003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 00:42:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 00:42:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 00:42:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 00:42:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhIZF2z/jBp3vYskAc7xnFblMsoiS9EzM7kJ/Smo+5SUWl1qXx9YGSRsfoAXA0NKVv8C+hegudLlkgyKCT4jXIk/WCwYkqvZ+efW9U2RstqAN9ygZCuOmm7BrDzcaOKYGiIer/FxDg9sw6jkM1rX74KDrqcAebJylLPnSZy8hRQj1jD5RP12c44kBxLU3T8tb6PdlVLMUIym7OwQ3Phd8OKLI89as9awopowMrybINWV+6hv5Gjg+AYDUUXaI4hfRiXiZTWUCICA/8w1vi8VgDmIGi7sX+U+gyNvwAbv4udbj1jiK8lYvYEVFjQ/UiLVVQtZqrg/ahugxWNkbBLyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUt0EkDOwt31Z2zDkMjBSVA5fdn0yuAV2Fzv4bbvd98=;
 b=oe8DPLk5sQbnXZqNpikNVX0GO3w34ONaZ0R3mueEE7TglNkBTfdYpSq6c52c2OOy4Nqup9+Ad/VVJTSqtNWUtJV7i0ahvpUL2Z8IVQbMkWZK0F8XEISSxWdiT2n/XqHVIAHoweiwLLXxjuvpmBbFPjBDSVAYGYOFjFYs94cNK3iZvoQI4Dd6ufi+EreI6I44zZVD4hTZ/5yKOE8zns4/HIQ9Tw3FgdFi/7+DMSU1iieHGN8w64rNv5xiylNzqn6OLLMXwH8/SyoxGa1FzCyy24o4VJAiSApKRksOQz0/1lGDjMesL3Q1tZzS4p605T8z9RFBs+mfDLnbQ49nleUthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 07:42:12 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:42:12 +0000
Message-ID: <7ff67363-c309-4490-aff9-d8eb09556b70@intel.com>
Date: Wed, 5 Jun 2024 09:42:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] net: libwx: Add sriov api for wangxun
 nics
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <3039A3C780E832EE+20240604155850.51983-3-mengyuanlou@net-swift.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <3039A3C780E832EE+20240604155850.51983-3-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA1PR11MB6515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b545dc4-d2f9-451f-3f72-08dc85330338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THdNZ3FVM3F2KzhSamR1WlVjNUhZMVFsbU5xUDdYSkoraEw2UmVvWHhoNFhv?=
 =?utf-8?B?SStCclVxNzZjWUQ2Uk5GYWxMTHJEbHpoUE9OQWpEejlJaFU3RXNsUERoMVRU?=
 =?utf-8?B?Zm5qRmdGOE4yV0tkYVBIWjkwVVdXL3RHMk9kMGY3dkhnOUVyc2d4WGo2aFE0?=
 =?utf-8?B?aE84SUkwYXFwTURJSWJaMmF0aVAxZE1nOG5tOWdUU1JGaUdkcjlXMjlaZVoz?=
 =?utf-8?B?emkxVEFYNS8wcW9uNDYvTE5pRE1JbUZMOUFZWUp3ejJRK0VmUGFveThzN3ht?=
 =?utf-8?B?WVBoUmdZSUhIYkpBNXpVMG1vNkhoNnN4TE1MMlFNL0lmdDBDa0JnZjZERS9k?=
 =?utf-8?B?N3BjNElMdmw0VTRwejh4QUlXME9ZRFcvTUZQWEhjdmxZQlVIbVpQcVhFR1Fl?=
 =?utf-8?B?U0o1YmtOVUYweWRxaDQxSkQ5b0pSMk5GQ092M3diOFA1Z2xpcXZoZmkzWHA3?=
 =?utf-8?B?eGkvd3pWb3EzVy84bVNRc2hUbU5vWk8wYW5qMXZJL0xhOS9lTG81S3JvWUhK?=
 =?utf-8?B?WGQrUE1nSk4xdjE2c09MNXgxQVlsNUQyUDZxSHhoVHFkZVprVU95WTBtcExx?=
 =?utf-8?B?RDIvUWUvV3lwMll2dmNBdXVaSVhiSGZOZ2VsemNST2ZWRUVzeTFCWVlTQVVu?=
 =?utf-8?B?anNjRDQ5RE4vRk9WZFJhYUdTVHZ5bmFRa25FSWlmQlhRUkhPNDNKTDRsckE4?=
 =?utf-8?B?K0ZHRklGd3hWMlp0a1p4WXNnUCtQM2NON2c5RnV2ay95TXQvbnpMc1g3bXM2?=
 =?utf-8?B?bnBZRHRzQXNPM3BsbFNMbExIdjZ2WDlmelVtMEVjY3NRUmN6SlBYeXJ0cngy?=
 =?utf-8?B?Q1lTeTJxbWVpU2xtV0x4Q21YQlI2U0ZOQzdpN0NJMkdyckFlVko4SytYYldu?=
 =?utf-8?B?Y09QZ2w4YnFjdXRyYW5yQ1J0TzRmNDVzdFJFQ2RueUNneXJNVTFUMC9xSkdI?=
 =?utf-8?B?MVI4TGNRV09RekdkUEQ1TmhhSENyd3dBRDEwcDVOVTdONXVmZU1tNlhTYXdo?=
 =?utf-8?B?YjJ4eU4rVURzTTBVT2JZK2lYcXV2N1g1Sy9pVW83UTVnWFVPWi90V3JvQzBR?=
 =?utf-8?B?bjdVS0pFaUdrNW8yeFkramNwNExMck55ZmZxRHBzbU1tN3RyVjFmU21MQVMw?=
 =?utf-8?B?T3FNQ082bmg5UlBVSkw2d01WWm1GV1c1Q3dBdWI5cUVvaFJLeDJsbUxBaCto?=
 =?utf-8?B?S0RMemhBenBrcWZ4RkxoRC9PMUh0WS9YdDY4c3JOb1JKZ2VaRU91OUxORUs4?=
 =?utf-8?B?STAxZFJmUHlza1hCY0U1bE1uTDZqNkNRUG50bzJ0M2VOSXhCQi9qalpVdy9p?=
 =?utf-8?B?OUZDNU8zamZFK2RZc0VxeUExR1BhZkFJN2xORkdZZWpnNTEwZmdnNnZEZlU4?=
 =?utf-8?B?aDYxaHAwbU9ONTFrczNZODZYMFhYRHFJcEl3NnRqZ3JlNEx0NzlJbkwzUkpU?=
 =?utf-8?B?c0lreEV6MmJnQitoSHZiZFAzRTFhZWIzZFZ4ZUlucTd6R0JxcjA3SmRtaDdx?=
 =?utf-8?B?TFJWcU15bmRmcVVQWmJhdzREd0NwOTNIaEFxYzBaV2VxWTZ1eFcwY2hvQ0pa?=
 =?utf-8?B?YTJnazZpSTQ0WHlLbFYyczF1VHVPWCtBTmtUaEhHSUlFY01XczNJWDAxMTk2?=
 =?utf-8?B?WGVqU0Z4Vk9nNmFadzJKR0JZMlVPT0phUjg5RVhzTHJ6cWpUZVA0bWQrR0RD?=
 =?utf-8?B?OUltdGkwRzZoMVVLdGF2ZVIrK29BckVLMGYweXYxYWZqQ3Zta3pjVlFXTDYv?=
 =?utf-8?Q?WPcvNwfbjtrGDqCyBTmHUherrbVpIN0YMPE0wif?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZqQ0lzTUNuVDZLM3BxQ3B3WFBGMHhlWTNzenVJVklBcWgzSzVmYmM4M05p?=
 =?utf-8?B?UFBZNk9aMDA1Q1o1WkZldGNqOXZscmYyNGtsbHlrRFhBc3ZpcHlvRVlJaDNB?=
 =?utf-8?B?YjYrcjJibEN2UkdKSWtMakNjV2N2blc4d0ZmVHVadDhjaWs2R2tMVjhZUUFO?=
 =?utf-8?B?bThuNkplZjBDVktvQTkyUjhUck82QU1KVGxjZG1xNkZOMFc3TUllRWMrOVFM?=
 =?utf-8?B?MW02MDErMThZMnZwNmFmOUF0SU1JMVVkUEthbDYyQmVCd3dnM1pYcmVjbUpt?=
 =?utf-8?B?NjlXNHRLVTNmSjNCYUxGa0JHeDB3dEZndUpLb2E2dVduN2pib2RrM01vYjRq?=
 =?utf-8?B?RCt5N0wzbFBGaGZ5U3p1ZWpuUTE5aVljUnJTa3lkUWZVbi9oN1B3WFg5WFpj?=
 =?utf-8?B?TEJlL3d5bkF2dlQ5cFhiRHpvWlpqbjJhQ3NtWnJqcjBhVnZpRGY0bFVNUGNO?=
 =?utf-8?B?WS9ZV1dZQUQ4eGpTZE5rN1lrTHA5SG5JT2dFM3RYd0h6Z3ZLOHZxMHR4UmU2?=
 =?utf-8?B?SGNiNS9LS2Q2LzBVdkhjbVpQVXM0QWl2Qi81K0s4M2svcG0rQzFoRG8zZ0hB?=
 =?utf-8?B?Ym1NRm5HMy9zczZIcm5NR2JndzBPSUV2c3NSdzdGenZoNytZVGNOZnBaUXpw?=
 =?utf-8?B?c0lGS29raDhreWxRZGo3UmczU0VJaXEwN2thbEZldnl5RHcyZDFNVFF5RThT?=
 =?utf-8?B?Ym5VS003UTZNNFNGVXZNYjVBSUFTS0JlV3VwL3hkbDkwb281ZjdIcHlhMUVK?=
 =?utf-8?B?K1djaXE2cjVwc3h5VEN1bDNkdHBROG9jZ09xTHlNVWZvRkVMWEZ2aHMxV2Rk?=
 =?utf-8?B?alBpMFRrNHRmQU5nZVEwV2sxVWh1cFBIeVZrUGdsT2o0R1Y0WUI3NFZkQlNu?=
 =?utf-8?B?cnQzbEpDZWp5N1YvY1B3SUJ5MDBSc0pJeStia2JoZVJ3RC9pTDUxdzI5UkVS?=
 =?utf-8?B?cTBXSlFmcE4xalBFamZJM2kwUEFEYzd0dmNjdjZTNHBHMDE2MjR0V2R4dGox?=
 =?utf-8?B?SE80KzNYV1ltbXVnMUVQZEF6RkhKTDRlVldyYWtSaHA0d0VtczRBT3lDOGVv?=
 =?utf-8?B?a2FVVW1ORkE3bjErL0ZZVlp4TU50SlJtandTMlZWRVdnck91N3hFVWFjMGtT?=
 =?utf-8?B?SmZtdW04RHVmYXpmQitORXRnQ09Vd0VsUnA4VklEY1VNOHcrRkk4c3FyZFN0?=
 =?utf-8?B?bW9HbVd5RXdTYXBoMTFYL3J3UW5tcmRwYWsvclVRY0pjZk1SSk9xaHdWdVc0?=
 =?utf-8?B?azR2ckRaQ2ZRV3JCWnZJdGF5TnREMTByd092MXZHdElueDJEWTcyUXZEbUZT?=
 =?utf-8?B?dkV1UXFpb0g4ekZSNVhJQ2VuVlFmclJWcVJyTkg3OTRCMnVPRlQyNml5NGpp?=
 =?utf-8?B?SHBZU2NBYnVqY1hFaUdid2x5eHhMdFR6L1p3bHdnNlhid3NzY282cHhKdERt?=
 =?utf-8?B?VVNlYzVFS2JCd3RiM212VVpJV1dTa2pFbGJuQXVnR3dzaWdrajBjVlVPWXZY?=
 =?utf-8?B?eWkxNzFvUnBFcUtMb3JSUGhteUd4MCtrcXNqN0ZyK09CaVNlaTUzaGxZMHdH?=
 =?utf-8?B?Mm1wdDNMOThXa1pNaUpKY1JKeVBkVzV5VTlzeDdUT0I3emYvWVpwRUlaYXhG?=
 =?utf-8?B?eXU1cjNaK0g1cXdSOVpSNklrS2NLNU1xTXlRQXh1VzJtSzIxNkllUWp4SFV3?=
 =?utf-8?B?Z1FES1FZL0EwdUtzc2cyYmV6VitsSnJxcHFqWlhBQW5Jakt4c1BPT0ZPaHpM?=
 =?utf-8?B?VFVzR0NxcE9YSGdLTkc3OGNnYzQ2ZXM4SU9QTEZQKzdpeE9FdThHUkVMaUxn?=
 =?utf-8?B?VDNLNTZqV0lCZVlaOEZJcjBoM2R0OG1tMVV5MEtHYnFLRGJpRW16bFd3V2NZ?=
 =?utf-8?B?K0pTQVhMODRpUlcyajErZlR0OVNWWENkRWpZYit2Y2dtNm5nTERnby9wY3ZR?=
 =?utf-8?B?VnR4dS9pZDNyMjVOZHBwTkozOXhjZ3hXa2RnY3J3OWNpYjZVOW02cE1zRitW?=
 =?utf-8?B?NkhEclNuL3B2VXh2aVlJWks0UVB4akRJTUpQaEhNaDBPRi8xNEYrcG9qYTVi?=
 =?utf-8?B?T1hSbmx0QkRpcFBXek5Kd09EZmRtZ3EwNTJUeXc1dElVMDZYWnhVZ201QUNZ?=
 =?utf-8?Q?vzgHK3WE7boIHM/bjtwzM+sbJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b545dc4-d2f9-451f-3f72-08dc85330338
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 07:42:12.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfVamU/CczDHYs+b8Vjp1NPmJkyTgkf9JX6dhEL9u/GNZe5wPGezxZi/1ICnFMMWS8SQ4VWbeJJoShwLxzS78RmoHoCsJoFD89iUz2eScJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com



On 04.06.2024 17:57, Mengyuan Lou wrote:
> Implement sriov_configure interface for wangxun nics in libwx.

you could elaborate a bit more

> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
>  drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   4 +
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 221 ++++++++++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  10 +
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  38 +++
>  5 files changed, 274 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
>  create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 913a978c9032..5b996d973d29 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>  
>  obj-$(CONFIG_LIBWX) += libwx.o
>  
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> index 1579096fb6ad..3c70654a8b14 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> @@ -23,6 +23,10 @@
>  
>  #define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
>  
> +enum wxvf_xcast_modes {
> +	WXVF_XCAST_MODE_NONE = 0,
> +};
> +
>  int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
>  int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
>  int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> new file mode 100644
> index 000000000000..032b75f23460
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2023 Beijing WangXun Technology Co., Ltd. */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/pci.h>
> +
> +#include "wx_type.h"
> +#include "wx_mbx.h"
> +#include "wx_sriov.h"
> +
> +static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
> +{
> +	unsigned int vfn = (event_mask & GENMASK(5, 0));
> +	struct wx *wx = pci_get_drvdata(pdev);
> +
> +	bool enable = ((event_mask & BIT(31)) != 0);
> +
> +	if (enable)
> +		eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
> +}
> +
> +static void wx_alloc_vf_macvlans(struct wx *wx, u8 num_vfs)
> +{
> +	struct vf_macvlans *mv_list;
> +	int num_vf_macvlans, i;
> +
> +	/* Initialize list of VF macvlans */
> +	INIT_LIST_HEAD(&wx->vf_mvs.l);
> +
> +	num_vf_macvlans = wx->mac.num_rar_entries -
> +			  (WX_MAX_PF_MACVLANS + 1 + num_vfs);
> +	if (!num_vf_macvlans)
> +		return;
> +
> +	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
> +			  GFP_KERNEL);
> +	if (mv_list) {
> +		for (i = 0; i < num_vf_macvlans; i++) {
> +			mv_list[i].vf = -1;
> +			mv_list[i].free = true;
> +			list_add(&mv_list[i].l, &wx->vf_mvs.l);
> +		}
> +		wx->mv_list = mv_list;
> +	}
> +}
> +
> +static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
> +{
> +	u32 value = 0;
> +	int i;
> +
> +	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> +	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
> +
> +	/* Enable VMDq flag so device will be set in VM mode */
> +	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> +	if (!wx->ring_feature[RING_F_VMDQ].limit)
> +		wx->ring_feature[RING_F_VMDQ].limit = 1;
> +	wx->ring_feature[RING_F_VMDQ].offset = num_vfs;
> +
> +	wx_alloc_vf_macvlans(wx, num_vfs);
> +	/* Initialize default switching mode VEB */
> +	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
> +
> +	/* If call to enable VFs succeeded then allocate memory
> +	 * for per VF control structures.
> +	 */
> +	wx->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage), GFP_KERNEL);
> +	if (!wx->vfinfo)
> +		return -ENOMEM;
> +
> +	/* enable spoof checking for all VFs */
> +	for (i = 0; i < num_vfs; i++) {
> +		/* enable spoof checking for all VFs */
> +		wx->vfinfo[i].spoofchk_enabled = true;
> +		wx->vfinfo[i].link_enable = true;
> +		/* Untrust all VFs */
> +		wx->vfinfo[i].trusted = false;
> +		/* set the default xcast mode */
> +		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
> +	}
> +
> +	if (wx->mac.type == wx_mac_sp) {
> +		if (num_vfs < 32)
> +			value = WX_CFG_PORT_CTL_NUM_VT_32;
> +		else
> +			value = WX_CFG_PORT_CTL_NUM_VT_64;
> +	} else {
> +		value = WX_CFG_PORT_CTL_NUM_VT_8;
> +	}
> +	wr32m(wx, WX_CFG_PORT_CTL,
> +	      WX_CFG_PORT_CTL_NUM_VT_MASK,
> +	      value);
> +
> +	return 0;
> +}
> +
> +static void wx_sriov_reinit(struct wx *wx)
> +{
> +	rtnl_lock();
> +	wx->setup_tc(wx->netdev, netdev_get_num_tc(wx->netdev));
> +	rtnl_unlock();
> +}
> +
> +int wx_disable_sriov(struct wx *wx)
> +{
> +	/* If our VFs are assigned we cannot shut down SR-IOV
> +	 * without causing issues, so just leave the hardware
> +	 * available but disabled
> +	 */
> +	if (pci_vfs_assigned(wx->pdev)) {
> +		wx_err(wx, "Unloading driver while VFs are assigned.\n");
> +		return -EPERM;
> +	}
> +	/* disable iov and allow time for transactions to clear */
> +	pci_disable_sriov(wx->pdev);
> +
> +	/* set num VFs to 0 to prevent access to vfinfo */
> +	wx->num_vfs = 0;
> +
> +	/* free VF control structures */
> +	kfree(wx->vfinfo);
> +	wx->vfinfo = NULL;
> +
> +	/* free macvlan list */
> +	kfree(wx->mv_list);
> +	wx->mv_list = NULL;
> +
> +	/* set default pool back to 0 */
> +	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
> +	wx->ring_feature[RING_F_VMDQ].offset = 0;
> +
> +	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> +	/* Disable VMDq flag so device will be set in VM mode */
> +	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
> +		clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_disable_sriov);
> +
> +static int wx_pci_sriov_enable(struct pci_dev *dev,
> +			       int num_vfs)
> +{
> +	struct wx *wx = pci_get_drvdata(dev);
> +	int err = 0, i;
> +
> +	err = __wx_enable_sriov(wx, num_vfs);
> +	if (err)
> +		goto err_out;
> +
> +	wx->num_vfs = num_vfs;
> +	for (i = 0; i < wx->num_vfs; i++)
> +		wx_vf_configuration(dev, (i | BIT(31)));
> +
> +	/* reset before enabling SRIOV to avoid mailbox issues */
> +	wx_sriov_reinit(wx);
> +
> +	err = pci_enable_sriov(dev, num_vfs);
> +	if (err) {

Shouldn't you unroll previous configuration if pci_enable_sriov fails?

> +		wx_err(wx, "Failed to enable PCI sriov: %d\n", err);
> +		goto err_out;
> +	}
> +
> +	return num_vfs;
> +err_out:
> +	return err;
> +}
> +
> +static int wx_pci_sriov_disable(struct pci_dev *dev)
> +{
> +	struct wx *wx = pci_get_drvdata(dev);
> +	int err;
> +
> +	err = wx_disable_sriov(wx);
> +
> +	/* reset before enabling SRIOV to avoid mailbox issues */
> +	if (!err)
> +		wx_sriov_reinit(wx);
> +
> +	return err;
> +}
> +
> +static int wx_check_sriov_allowed(struct wx *wx, int num_vfs)
> +{
> +	u16 max_vfs;
> +
> +	max_vfs = (wx->mac.type == wx_mac_sp) ? 63 : 7;
> +
> +	if (num_vfs > max_vfs)
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct wx *wx = pci_get_drvdata(pdev);
> +	int err;
> +
> +	err = wx_check_sriov_allowed(wx, num_vfs);
> +	if (err)
> +		return err;
> +
> +	if (!num_vfs) {
> +		if (!pci_vfs_assigned(pdev)) {
> +			wx_pci_sriov_disable(pdev);
> +			return 0;
> +		}
> +
> +		wx_err(wx, "can't free VFs because some are assigned to VMs.\n");
> +		return -EBUSY;
> +	}
> +
> +	err = wx_pci_sriov_enable(pdev, num_vfs);
> +	if (err)
> +		return err;
> +
> +	return num_vfs;
> +}
> +EXPORT_SYMBOL(wx_pci_sriov_configure);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> new file mode 100644
> index 000000000000..17b547ae8862
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +
> +#ifndef _WX_SRIOV_H_
> +#define _WX_SRIOV_H_
> +
> +int wx_disable_sriov(struct wx *wx);
> +int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +
> +#endif /* _WX_SRIOV_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index caa2f4157834..7dad022e01e9 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -18,6 +18,7 @@
>  /* MSI-X capability fields masks */
>  #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
>  #define WX_PCI_LINK_STATUS                      0xB2
> +#define WX_MAX_PF_MACVLANS                      15
>  
>  /**************** Global Registers ****************************/
>  /* chip control Registers */
> @@ -88,6 +89,9 @@
>  #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
>  #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
>  
> +#define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
> +#define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
> +#define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
>  
>  /* GPIO Registers */
>  #define WX_GPIO_DR                   0x14800
> @@ -161,6 +165,7 @@
>  /******************************* PSR Registers *******************************/
>  /* psr control */
>  #define WX_PSR_CTL                   0x15000
> +#define WX_PSR_VM_CTL                0x151B0
>  /* Header split receive */
>  #define WX_PSR_CTL_SW_EN             BIT(18)
>  #define WX_PSR_CTL_RSC_ACK           BIT(17)
> @@ -181,6 +186,7 @@
>  /* mcasst/ucast overflow tbl */
>  #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
>  #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
> +#define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
>  
>  /* VM L2 contorl */
>  #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
> @@ -943,6 +949,7 @@ struct wx_ring_feature {
>  enum wx_ring_f_enum {
>  	RING_F_NONE = 0,
>  	RING_F_RSS,
> +	RING_F_VMDQ,
>  	RING_F_ARRAY_SIZE  /* must be last in enum set */
>  };
>  
> @@ -990,9 +997,34 @@ enum wx_state {
>  	WX_STATE_RESETTING,
>  	WX_STATE_NBITS,		/* must be last */
>  };
> +
> +struct vf_data_storage {
> +	struct pci_dev *vfdev;
> +	unsigned char vf_mac_addr[ETH_ALEN];
> +	bool spoofchk_enabled;
> +	bool link_enable;
> +	bool trusted;
> +	int xcast_mode;
> +};
> +
> +struct vf_macvlans {
> +	struct list_head l;

l is too short IMO

> +	int vf;
> +	bool free;
> +	bool is_macvlan;
> +	u8 vf_macvlan[ETH_ALEN];
> +};
> +
> +enum wx_pf_flags {
> +	WX_FLAG_VMDQ_ENABLED,
> +	WX_FLAG_SRIOV_ENABLED,
> +	WX_PF_FLAGS_NBITS		/* must be last */
> +};
> +
>  struct wx {
>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
>  	DECLARE_BITMAP(state, WX_STATE_NBITS);
> +	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
>  
>  	void *priv;
>  	u8 __iomem *hw_addr;
> @@ -1082,6 +1114,12 @@ struct wx {
>  	u64 hw_csum_rx_error;
>  	u64 alloc_rx_buff_failed;
>  
> +	unsigned int num_vfs;
> +	struct vf_data_storage *vfinfo;
> +	struct vf_macvlans vf_mvs;
> +	struct vf_macvlans *mv_list;
> +
> +	int (*setup_tc)(struct net_device *netdev, u8 tc);
>  	void (*do_reset)(struct net_device *netdev);
>  };
>  

