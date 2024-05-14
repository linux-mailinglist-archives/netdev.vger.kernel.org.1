Return-Path: <netdev+bounces-96326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6148C510C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979841F21943
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2112F365;
	Tue, 14 May 2024 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJkjrR/p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590E55C0A
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684016; cv=fail; b=Y4cDkI/BAceCi7OF/3a9CM+e8EBDjA2/uZH5DVyx6AgBJpltoAQsgRCxuULw0URnLasLtHRXZHif/QYLiEeIaTZ2bqWppsD/zFIf6DDF/litqWvsJj+KggNFZlWb2dk1y+J86jjmkdpfYGnMKddKt8nuDSNEV70MeqJ0pe8+DQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684016; c=relaxed/simple;
	bh=tIDaq9/5PyKQfqtK2h8Zy/CIYZY4VUyXnl9VAbyDTK0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LhEjkzVG0VjRKkMjeqw+a+vEXcFwdIaneioBmx2AfN6DriZzCUd47kBj9dMCjlpKo8B29msVIk3rYldAHBwpvBprRUIcZjcWrD8mwBz0T4PjmLEWhRXWLRqhLTZFnySuZ8/1pCMuKbsxRWdrQDoKRhaMP4fSGYlYIzw/NFRWwao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJkjrR/p; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715684015; x=1747220015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tIDaq9/5PyKQfqtK2h8Zy/CIYZY4VUyXnl9VAbyDTK0=;
  b=IJkjrR/p2rp9qHIpoQgqmaq+N4LMjj4yKvKc6++JKBI3HKSvqHe6jw5O
   wxVKIveq6YsUEMASP0d17oWupbdsK8/wRwiGABNwUmCHZlTp5Bw7BrC92
   rfOC8B1M6PHdES86kemy6OSWGSCC9xYyEGDxDK+gZ5XSoZj91LWwhaZiv
   ScSS7yViQiPwjfLVacmp1wd5docn5ENoT8jwBkIUZIle2RdcbcDKhyBky
   DY90Lkj2iiaCqcavsbJ/2XFW8pO4U13RaRgt1KWAwJlP50+R/BI6rFdov
   74d4i6Hr7snlrVP0EpS4C4V9YJ1q4wg2zRvXlqV3n4Ham6DxXXyWRcQSI
   w==;
X-CSE-ConnectionGUID: LgtNaRXvQFCbNsKYQL2TqQ==
X-CSE-MsgGUID: KxdO3CZBSvuYMmX+muA2PA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11513208"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11513208"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 03:53:34 -0700
X-CSE-ConnectionGUID: riaQ+x8qRdKAUxG0j74DPQ==
X-CSE-MsgGUID: 2DhqnfyySeaQ3zpe9bhAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35174867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 03:53:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:53:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:53:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 03:53:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 03:53:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAk5mm7fewrJYhegD3HcJ9HK2/nSVdyRlhIqSWKo9i/s8ZrKdo/LPB0gYt0Kl5TaYso0HfNC2xk4aqA2oItxPPYP5WuyWH9c0Seu1o2V5vec4lD2zfMhyGoYXPTcHFQaeSnDbRb1AGqeIRk1j3emY2DQWChaRZEq/o17UMJm6PHMblBzECrjFCpyfZVVbqTlJ4J9y7XcAdEHysG7YeyLZQWyWyLPKtK231sM2h6NrexDJT0ZOXs8MpLHL8HRqV6ltV9tlGXXp5r1FRUWc/cWfA275Goepy2QnTqaw1OtPIvBHJPkt+OCH/jYUOM7saNXdcdj/949P5PzILZCUCzsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnXtftCza+0rJOz89i8kOYe2bqA9MuIiBHHGc6khxXY=;
 b=gGVG2jm3rUc8CGRY3bRWQbBbIzLTOjv31H2FjYdwXS4FWuiZIXirfFad2wt/a4Kyorwe+R/cGMIM7nXCM2kGbiOod8oOtp6aRGYPv+9BcjpPbuytaft7KIg0wefrAaBH/ME6nnjTE0XUutELLMVt0esXphFgOCgkB4JIv+vcnyp1x0PbO99RBv/fyadAiqUuMFpFClVJ/5dgdcwYE7J6ZEuI1mrgIN3O+mvb8Ng25N/meGnZWaV5vLXikOiHe8eEtXT7L6ne33xGRK1q5hkynz/xArJVfQxCjQFJremqt8nEW/Kna1rrzdTgxR7LOVdA5fK9wNSUrrmXDWcuDDoBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 10:53:30 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 10:53:30 +0000
Message-ID: <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
Date: Tue, 14 May 2024 12:52:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Eric Dumazet <edumazet@google.com>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, Realtek
 linux nic maintainers <nic_swsd@realtek.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: c84cbfb1-db59-4b7e-b57c-08dc74041763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG5ieWNXamlzWjhyS0psR3V0d1dja05TdzgzOTFCZGZHSk1GcGQ4M3g1Mk9o?=
 =?utf-8?B?N3RSRTZzUy9DR1RzSzR4Uk5MTHlydEE1Y0tSakE1V0FGY2FTdStjVWhEK3FC?=
 =?utf-8?B?VFZOOWxsb2l3SXhGNDE5c3MvblVROEtwakp1cFpraS9kZmxydllocW8xTk1s?=
 =?utf-8?B?Z2JRSUVraFFvTVptTEE2SWdmME5lVzBBNStNcHFQOUxiQkVTaXRZN2l1L3dx?=
 =?utf-8?B?WUI4c3I3VHdTRnlyZjlGbFpNRGVjbHdqUkVPRXk4NkZrRUlqb1pEKzAxcU8y?=
 =?utf-8?B?c2V5ZTdzd2hDdENLdUlsSllZRWh3NDFwMmpDa2phQzFFUzcvaVBFYlA4ODdl?=
 =?utf-8?B?NTJQZ09DZ2hXbWcvbldTMDVSWmc2L3l0Y2pkZTZJUmtzOEdySlBxQy94RUZH?=
 =?utf-8?B?ZkpMalJUTUdmT294M0VKVEFEZ2lzS2Q3VkNFd1d4ZHdhWnFXV25MMFNWRVRP?=
 =?utf-8?B?S2dGWVI5bzlPQmFIRUlnNHNHeEpGNCtLV0JxUUxHWEZCL1NKS2pPQit1bFY1?=
 =?utf-8?B?UitxVVJLbUh3Umh1RE1QajJhVEFNL1N3VWZ1Wk5HTklhMk1VVHNDZjhiYnZu?=
 =?utf-8?B?RUVzMzY1aThDcnVSZXQxNGFoNTZ0WC92dTZ3eFhpVW5HQmhXS0lwd0k1bkJy?=
 =?utf-8?B?d01RekhwQTl2TWp3K3hnazQrdXU4Kzl0Mlc3ZjNlRVMyeklqZFBNdUJKOVdq?=
 =?utf-8?B?aDJXV3RGNVFxK1BtRWhkNEtsR0JqWktuc05HNDVGNmEvZE1US2R1SVlyS05i?=
 =?utf-8?B?TGhKM1FlV0J3bzJQdW5ZM0pxVGQ1SzFsUXlNS1RSMDJvaUJPeERGZ0lpNU4x?=
 =?utf-8?B?WTBDQlZTbW5iU3E4OVo2elhSVXE3NzArYlFCRHJ2VWVDaUJYODNvRjQ1Y0Ro?=
 =?utf-8?B?a2JBUi9rSW5Rem9WSEs4UEpiTkc1ZDUwSjBPcGRZWkM0SmlPZmE2YVpPblNn?=
 =?utf-8?B?UHhlNWVVRE0zRjNCU0gvSUxxK3ptRVJJWHN4NG1OakZyUHVFcE9KMkFDVldp?=
 =?utf-8?B?aUtMN3EvU2xEWEJqbTk1NkU1RHRmcGVGRVRKbjN3R2Y2emlNVGpYZEhIT3RL?=
 =?utf-8?B?YllGSExqNldiMTFRZDFLU0dOQ21STG4zL2UvQUdrK3plWnFMZzBOd3VPKzNH?=
 =?utf-8?B?T2dHSUxQSEtmYkFQSzdGMEFqNHE2eTArdG9JRVBEN3Z0WFNMeXEyNWRQWWR0?=
 =?utf-8?B?Y2xZYnVJcFJoTGl5dVEzZHZNVGpOQzZaZEVDblpVZFhLNDlGQXJzQS9DQ3Fp?=
 =?utf-8?B?MUl2N29TMUJ1byt5ekZ4OUR3UFQzd0lORk1TYVozRWNDcEZLS3lTWFA0dnE3?=
 =?utf-8?B?cm1sT3lXbTkzY09DR1ozQ0ZHRW1GZGZXUDRwOVZZZC9SNDVTeS9lT3R4cThO?=
 =?utf-8?B?blhMVHZ2NUVxZmdJQnc0QmNhY2xMRmVmTU9ob0YzZFhiNDR6b1lXR0Z6S2hx?=
 =?utf-8?B?emtGK1NwY0FSb05xMGs3WCtiUExic3ovT2tneGZJOFpSdzVLWnVQRTR2enlu?=
 =?utf-8?B?Z2svNkRDYjNyOXU2MTB0T0d3RGExeXFRZFFsbWtyYW4vTStZOHlMTCtWYWRy?=
 =?utf-8?B?Z2RzSGlpQXo1ek9taFozTXRkTjZlblNTRWFabWNXTEhvU09OSUF6MmV4dkJq?=
 =?utf-8?B?a0xXYlV2dDE0eElsOTdSTi9GZ2FBdmxFWlREN0piQ3ZjbVJ2aDBiakdvd0VV?=
 =?utf-8?B?SXZBS3gwVU5jT0tFZDYrbzhOTXo1ZFFCTVFqcVc0ZXMvTytmYTlPZTlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHZrVlc4TzFueU1iZjFQdC9XUHQ5b3dHLzh5amRzZmNocENlSTAyMjVreEY5?=
 =?utf-8?B?WVBIOUVUWkszS3FPVkpVWFNldWVXKytRUnRDMjVxeENmelpsNkZLSnlIRVJi?=
 =?utf-8?B?clFpQXF6ZC9mYll3SEp2anlVQnVGVjdpVFZQdDBIdFQ3K1dOeWNGSnBtL0pk?=
 =?utf-8?B?eVNIais3Um5TS1Y1V1c1UGVlekJCT1JRYVozMmpUcUs4QzdYRDdkdHJsN0lY?=
 =?utf-8?B?STRUSjhGYW5Zc3BrYnljTnZROXdSUndlUktHeHB5bm9jeE4rOVN1SFJKMytB?=
 =?utf-8?B?a2d5TDVPckJSakRBUlFZSVc2VUU2a1ZwU01ieW1nMDNMcFVNMm9kemR6cjZr?=
 =?utf-8?B?Sjh6VUczTVVsQ2l0Z3FzUXJvZFYzTm9ZS1AzWG42MWliSDc1aXkzdVluTnFU?=
 =?utf-8?B?VGlHZUgvTDgyM3l5bWFMaFByczRvM0x4eTJ4S1lKeEVwc3BHOXBOaGZGcDZY?=
 =?utf-8?B?Z051OWpKcGE5Tk8vQWpIN09yeGxVZUg5VUJIaTdqRTRmMDlGN1ExN0h2STBi?=
 =?utf-8?B?a1UrM2hTSDVWK3lZMWQrbzY1SnNNZTZKb081TWJhVDhWNUJYRlR5ajVHOUdq?=
 =?utf-8?B?MS9VTWVIZG50ZVpBMDNJbFoyTk5FRk5HL2VGSnJyT1A2dFc5S0dpd1ZLVitK?=
 =?utf-8?B?Qms4ZVliWkJuay9ud1ZtNktnYUZxUDNicVFyZ0JBczZzbnlRYjhNcGYxZXUw?=
 =?utf-8?B?VFJyVy9aZUF1aW54OGVINzdCZmpSUHpSeStUMnZSdWNxU3U0MzFNRjlkSXJJ?=
 =?utf-8?B?Y0QwQnQwaGppVVE2RnZNc0V3b1Y3KzJqQ0dvcWxPelo5VGx3YVJ0eUh5Tmhp?=
 =?utf-8?B?bmlwUEFGaWV1RUNMUnJoV2pRemFSQU52eWZ3MDVucHpSTUJVYW5LdUFtZ1Nu?=
 =?utf-8?B?emMxd01kWUZTTjVaMnhKL2tGZGNueEI3dnhDMzJUVUdUWitmcG5xTkN2SWM2?=
 =?utf-8?B?cy8xME1DMStXUDFDcFpNTW1WTUFJT0xZNEFCclA1OTJnaEROaGY2U2FWSkYr?=
 =?utf-8?B?WVYraWxhMVNXSUNaVEJrT0JoVFBqR1VwZGhHbFJQcjlLeG83RDZ3ckFScFB5?=
 =?utf-8?B?Z21ZYVZLOG0wNitCZGxheDBQaGNBR0FOZ0owY2JYR0dtR3pyd2o4QzQ4b0FO?=
 =?utf-8?B?aWNTcFUrb3Qxd1hKYW1aK0pkR1pUZDdkOWo1cUtBVDN2NFhISUZ0ZHIzWTNI?=
 =?utf-8?B?Uzh3YVBYbmFjUjFOK05jZWtUSytzNVUvTksyTTJsbk9iaVVNVk1qb0xXTnFU?=
 =?utf-8?B?OUMrSExHaGxTZnJVZlZHKzFIckNnaG92a2pteldaa0JNdDd2UlJSR3NvdGhx?=
 =?utf-8?B?VXlTNm9FT0FIdUhJNUVvUFQ3S0FtQjRSTU1YT2luS0FnNkxCM3BrcDJQWEYy?=
 =?utf-8?B?bkRLVGRjZTU1YTBXZjcyVWtKMGxRZFNZTnY0TGY1OXdKQ1RlMjVZdDJ5WGJ5?=
 =?utf-8?B?QVJKTEpFL0pOc0w4QXQ0QUgzclBJRFlJQTNnYUdrWmE5TXVMVGl6QjBTRFYy?=
 =?utf-8?B?SjhVNytwL0xxUjYyV2Z4NEVkbGt5Nk9DRk5vZUVsb1BBOTJ6YTMwekFOcFdX?=
 =?utf-8?B?SHB2Ykk5Rkc5THJFR2t6T0YyajY4TUt1dUQ3Rk1FZjZMT1FacUxRVW5XeTlE?=
 =?utf-8?B?ODQ1OWVlTzBxcHcyaTJVYkRQT2xFaTBlR1RNRnVYOGVEdElERFlMM3c4YTRC?=
 =?utf-8?B?NWNPOFB6Yk1lVkJqLzVtUTlLT0M2aU9aTjhHOHhlZmVUVGdsQjI0RmJXbkdx?=
 =?utf-8?B?TWYwNnVPaW83bHBOdHVSbWxEZ0F2NDRJbHhqbGU1OGVQd0lYSGF0bjJTQ1VE?=
 =?utf-8?B?STYvdXpJRHZwSFFsWENpZEltemR3SUkyY0VMWTNnWEsvdGp5YVVZNmFDdnBQ?=
 =?utf-8?B?emZtcjJVRGJvdk9KWnlSOEh1N3FkY1A1bUp4cGI2KzI4UlF3VEt3a1VIcDU2?=
 =?utf-8?B?SUc0MzF5SnBlaFgzRS82a0N2aTVBdUcvRDVXdDBEN0czMVd6NDJMWHRPeTFs?=
 =?utf-8?B?RUlaSXZOVUFENHQzaE9UbVJwc0g3cHFKNGhDY0ZuRmd2VjZ5ZWxHeGY5Q3VO?=
 =?utf-8?B?WnBLTTFIK0JaM3o3ZkFBYXpoWkZ3Umk2NnE0ZHI1ZjlmVGExMzFURTc0ZFRl?=
 =?utf-8?B?dGdJZytmRjdKcVhyK2c2Q2Rkdjd2K2xHS2lvWk9pb0VPOVdEaGZkelU4WWYr?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c84cbfb1-db59-4b7e-b57c-08dc74041763
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 10:53:30.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpPhqxCAk3R927Om0VRTBbXH4E7pPTecalGPrwSekUEZbbhdfRJoo1AIKvlYBiTurw7nVd/DmxbQMr/teDtInpfxgZuA4NXA98DyEoWqso0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 11:45:05 +0200

> On Tue, May 14, 2024 at 8:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
>> default value of 20000 and napi_defer_hard_irqs is set to 0.
>> In this scenario device interrupts aren't disabled, what seems to
>> trigger some silicon bug under heavy load. I was able to reproduce this
>> behavior on RTL8168h.
>> Disabling device interrupts if NAPI is scheduled from a place other than
>> the driver's interrupt handler is a necessity in r8169, for other
>> drivers it may still be a performance optimization.
>>
>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index e5ea827a2..01f0ca53d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>  {
>>         struct rtl8169_private *tp = dev_instance;
>>         u32 status = rtl_get_events(tp);
>> +       int ret;
>>
>>         if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>>                 return IRQ_NONE;
>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>         }
>>
>> -       if (napi_schedule_prep(&tp->napi)) {
>> +       ret = __napi_schedule_prep(&tp->napi);
>> +       if (ret >= 0)
>>                 rtl_irq_disable(tp);
>> +       if (ret > 0)
>>                 __napi_schedule(&tp->napi);
>> -       }
>>  out:
>>         rtl_ack_events(tp, status);
>>
> 
> I do not understand this patch.
> 
> __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was set,
> but this should not happen under normal operations ?

Without this patch, napi_schedule_prep() returns false if it's either
scheduled already OR it's disabled. Drivers disable interrupts only if
it returns true, which means they don't do that if it's already scheduled.
With this patch, __napi_schedule_prep() returns -1 if it's disabled and
0 if it was already scheduled. Which means we can disable interrupts
when the result is >= 0, i.e. regardless if it was scheduled before the
call or within the call.

IIUC, this addresses such situations:

napi_schedule()		// we disabled interrupts
napi_poll()		// we polled < budget frames
napi_complete_done()	// reenable the interrupts, no repoll
  hrtimer_start()	// GRO flush is queued
    napi_schedule()
      napi_poll()	// GRO flush, BUT interrupts are enabled

On r8169, this seems to cause issues. On other drivers, it seems to be
okay, but with this new helper, you can save some cycles.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> A simple revert would avoid adding yet another NAPI helper.

Thanks,
Olek

