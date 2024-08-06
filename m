Return-Path: <netdev+bounces-116021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AB948D03
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6527C287A8F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417911BF301;
	Tue,  6 Aug 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrVvFDch"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA681BE86E
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941081; cv=fail; b=QESe0+aXKv+TWJMUFaCDp5Zrmt0fte9R5fYBMjf6VvbcnaZ25YmeKESBTcRz2l40Bsz/C3vaLS/d+HvpmeY0Zgs66MuZLYsxLW4i536wfXrXyxqelezbicxSNyMZsuBXNA7Dttbu/vPwuB0yDHnru9uGmLIdrKLpGfSYNRDJGcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941081; c=relaxed/simple;
	bh=HD03bkeesoOZBGf3UwVaH+tvlIudMo/3k2lo6VKfg84=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mj+HGVq6chJEEf43mNcV+q5IV5eZujhNyoQ4sEPcmXAYY2JSfRsDFzFTP7Y2aMq0TLhnj4ivlMaXJLdrw47Dt8XB3VlJ1oyKbz9aKb6xzTjafJpy1Lh+5wlUUm42Eetxr5aURA8/qJhZbKT/OdPHQQSpOZvlysOYqxw1BkiK8Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrVvFDch; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722941080; x=1754477080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HD03bkeesoOZBGf3UwVaH+tvlIudMo/3k2lo6VKfg84=;
  b=jrVvFDchpvk7irHsDuq2R35kGN7pyDKGXwLIN97+hxPDqlpzrzTbzD41
   pOfeTfQ9zzrkc5+t7B0EnXxWQQWSz7q5kOqZ9slbhDZkGwW5Wessd4mfD
   x8wdVCBgBJAiZMs9eMZ/FYonZq93s7uZuJoCqZOjxBLyr2Yti26N7E21J
   Uqn08u8jg1zwcnSv1w496RU92B74aVsIlUIw5PZvGGNfSqWktYWIQUd4j
   lKdDX+0pC1PXtY97JpN8zK4L6B3I0GzbGhyCNoAs6heO71rXlDEKca5Hz
   Tx0+EipCpnsD005aGbvV31B4c8a0KX1zfFpwGgUcgRkKm9Ry7EO3AcQXR
   w==;
X-CSE-ConnectionGUID: k3n5kO1SSmOH0TgJ8zb/Ug==
X-CSE-MsgGUID: jHAI6VTQSqiCTMjjh1/hKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21127755"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21127755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 03:44:39 -0700
X-CSE-ConnectionGUID: oxaARXoETo+dlYWKNr9/kA==
X-CSE-MsgGUID: UcKKHZ0qRX+oMMFMIGnTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56171783"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 03:44:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 03:44:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 03:44:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 03:44:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 03:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtMm6vHXFwrxxUlD+aboRhcnzqezUtyOrJyUMZvaoA6Ltft8up7tSWuQRDwRP2tYAuLhBeRbetMEviN7k96/+csGIwMi9XvTRQuUqxOhyPajxh40tnImWZdQ5yuHSk+9+U17n+YUF/i3eDDqPoaZJlccPDtNpJPmEpFdQh4muyi0Ac0G8rrxIHgxUvGCPR4DnobjFvdtptCEATN2i8B5ezEzM34svw7wUS7Ka2M34D7qum1bHcpor7iMLCG89YcLubXZKZ/rbGbiTaD+AVwGGHNyyS3IYmFBR4N5LZMW4QQ9YqeAc7jJBgt0HZJLcvhHqZbJSQKshPidrHIY8e4pAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbufXqf/Ur/ygRcbPmYyKJxzvw9P3Gl9984h/gzQME8=;
 b=XcnDhTEzXFgFvUUgKcLlNz0TUh4ibflWwLoTUA5uA+Y6lF3HZ8Gqj2aJx0XnUbER38OzLdbm3Ci9ANtYhIzlbfZNfTphCBQaNzlgF0xrVkgczzmcokLPMDzJ8KRqx6kndoFJpsout1ZMeNGmle6q6QCrmsbTtxWbbHiBqT+AsqOOtRoIgn2vaRk9W5Q/4Bz/5PCtrsOYf3/SXbANEZGjcATcyX6HLkjKkyH/9XbYdYT8XQSdqDwPL6HTZShAYRpAtLRfh2rX+lh6aUjlwyxONGQoKkJ5wubWS6jo2XmEfJ6JvwykhkuCZlhYD06LIipRwjOJZlUNytwaUFP0UKBRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 10:44:34 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 10:44:34 +0000
Message-ID: <d99387ab-7883-43a3-99de-fea37026cfb1@intel.com>
Date: Tue, 6 Aug 2024 12:44:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/12] ethtool: rss: support dumping RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dxu@dxuuu.xyz>, <ecree.xilinx@gmail.com>,
	<donald.hunter@gmail.com>, <gal.pressman@linux.dev>, <tariqt@nvidia.com>,
	<willemdebruijn.kernel@gmail.com>
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-10-kuba@kernel.org> <Zq5y0DvXQpBdOEeA@LQ3V64L9R2>
 <20240805145933.3ac6ae7a@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240805145933.3ac6ae7a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 71106712-3562-4c5c-727f-08dcb604c2fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zlo4ci9adGtaV3dmR1ZSZ25yT1AvSDlrYzd1L3NiUFllYzlqOUxtUjBWcWl6?=
 =?utf-8?B?eENXNmlEV3VXZnBuVXBUMy8rVE9Na21pOHg2clFoV2hOcUpMWFh1L0tvZXBO?=
 =?utf-8?B?RU9DOE5YQ094eTBqdDc0MC9Wak54OVQwdHZYUXFIQkZIaUdseG14dnUyVURB?=
 =?utf-8?B?YjJOL0RFV1pDd3FCbnEwMFV2TUtwV3h0TmpYaTF5N29aemdmOFBCSlpOM2ZS?=
 =?utf-8?B?eFVPRVkzUXdrcmVnNUYrRUZWcmwxY0N3dTVpNzNMYnYvYThSZThScE9EdVlR?=
 =?utf-8?B?Uk5xL01SUUdqOUFVVDZDdnRFMXllUFk4ZThPVTV1S2tuNnlXeFQ4Z0YyNklj?=
 =?utf-8?B?UHpKY0owdzB5L3RNNWpzT2NiNGc2TGt5MG54dXJNMVBBcG1ndHJXNEs5d3N4?=
 =?utf-8?B?RXdwUXBtNkt0ZEVrSURnMUt2NGpUcTFVdk9yd3QvMzlRL3pDYkM2SkpTaVIx?=
 =?utf-8?B?clFlZXNKdkJQSGluYmMzNWkrODIxb0FLYTV6T1dHRU5MQXRLRWgvNm03Q0hS?=
 =?utf-8?B?TllkUmQ3eEVpVVA1L0p1anloam1KR25YS1dhNVZ0T1BMWHhmMFdUeUNYa1pz?=
 =?utf-8?B?Mk1mUjJVbHZDMERlN0YzUDVmVG5oR3lUZVdYZ0VBL3pKTGIyVGhaSjZMeXNO?=
 =?utf-8?B?MVV6ay9Wa1NTbU5JVDVDbjl5ZkRaYkdXdjNNcGRWSFZwVGg2VXNqcmZCK0lq?=
 =?utf-8?B?ZHZiYnJXVnNVcUJ6VXFpT2JjYlQ1TjFjS2FvR2ljV0VGdjJMRGFDYm9tY08w?=
 =?utf-8?B?blNBVGRZUlZhT3daNEttNGZRWE5NTUhuQWtuY2hMWGJQanhnLzg2Ylo0V0cr?=
 =?utf-8?B?cUFaUXE3MkNzK2ZMM3ZuaGQ4Uk1pN3dobEpHdExYckRNYnZYVGR6MEhrNE4x?=
 =?utf-8?B?bWN1MWlyNTl2NHl3TFhyR1NQYUk4b1c2RFQ2ZVdvVWY1QVFVN1RHQkE5K0NU?=
 =?utf-8?B?KytvZEp2bHJ0cisrMXNTZ2RzVUFiNzN0NGkvek5tdTBDQ09zYzVSUjhqT2FG?=
 =?utf-8?B?UlZ0RW5KR05XNlgrZGp2RENFM2dtQzVHVm95KzhrRGpqcm5PcGJhSXdBaXg4?=
 =?utf-8?B?WG5EYS8zVzJnWWVNSHVZMVBtWFhnbHdMTlVVTzNFUklBdW92SHdBbzNzdE1V?=
 =?utf-8?B?NXlHenI4YmovZ3g4akVrcGU5WE1la2kxVnJmWDhrbEpuSVhvZzJCcU9IVW93?=
 =?utf-8?B?N2UvVW5OeVRsYk81RjJjZUlWZ2l2ZUtEWmkxd3J6bmpVN3pna3RCVk1XeThO?=
 =?utf-8?B?Q1hMMnQrckJxdk1EMXJRTmdSUmhiOWd3dklvVHgrbzNBMTFvaXdkQnRBdE9I?=
 =?utf-8?B?L0wwMGE0elQ2ZGpqOTJhcHZ6QTNvOVhETytXRExCd3AzK2ZVL1RPM1FSZjhu?=
 =?utf-8?B?Wjd6RTJlRXR2RGhsSXpIZTBzM2hXMGpLdFducFpqbEE1UXRnd1MzcE9ER01U?=
 =?utf-8?B?b0x0eTFpeEJZZjQwaGs4L1pmM0xFNE9acWttUkoycEJUZ3B4VWVqbFBiajFy?=
 =?utf-8?B?cW1yZTl6ZmIzOVhhOE8zUE1qUlFXU1lQY3VJUmozcUhtaDV5V3o0akJ3ekZK?=
 =?utf-8?B?c3Y0bkNYOXdsSlBhSTVlOG8rTTZPQ2k1UnBvSTVac1RxVWNpY1FuVGJFZVBv?=
 =?utf-8?B?bDFVU2xnVmgxOTRCcHZUYmFBYjhzbEJKOHFzUmwzYU83ZHBQUGxJZGVHWm9Z?=
 =?utf-8?B?UnZjL2Z1dXJBYWJobGkwZW1aaGl2cVE2cEVtUlJ4TGV5UUcycVhiZnk1N1di?=
 =?utf-8?B?RWhvTnExeHUxUlZMQ3ZLMlpONTJPQnBDU1BkWjZYbkY3NmxqUjhTM0J6Skxp?=
 =?utf-8?B?YkI4YWJrR3YzKyt4dTcvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2s4NFMzRFhaNTRGc212eTlWV1Y4QnpqVmFRa0pzOFJiYU94QkpPdFdhZm1T?=
 =?utf-8?B?Z1lzODZ2V090YVZWSzZhZmk5OXVsUXN2MUJybVp5V0hQVHBYNCtnajd0TzVW?=
 =?utf-8?B?OHhVT0ltQXQvY0V2WEFoc3ZwUkVxK0U5cS9vRGkrb2NkckVqUFpPZEF6UWxk?=
 =?utf-8?B?eVNSOHF2LzRZR0gxK3FZWm5lTENxc2NDVUd0MC9sbkY0SHQ5NGJLcDRUaFFF?=
 =?utf-8?B?OE0vNTdWeVFyejdEQUFLYy9KWFVUTlBWalE1azRRTVJIOW4wbDNtYm00V0JI?=
 =?utf-8?B?V2RiVm9GTmNnOUl6ZWhhZnF0aWNFTFY4MmdGOXNWaEU2TG1UaFNxSFErNFd3?=
 =?utf-8?B?YlBhbVVlZnliSXZTZkVnaDJ5d2lYUE01RzRxZ0srUVQ0SkovZ3JqSCtQbzhl?=
 =?utf-8?B?TU1kd25jSHhaMjkvTk1MdzE0L0Fhd0YzNE13eE9EUTQ5UGV2WEdUbEYxR0dI?=
 =?utf-8?B?Rlh3NU5YQmZZRXJxTUpVY2ZqMzFOUXFWYU5TM1I0bkprT3Z3M2hiVW5NTEw3?=
 =?utf-8?B?TERYc05rbnRoaXdSMUR4KzRXNDB5QnEycFdmT1QxL3RrelRNdzhEc3A0a0lC?=
 =?utf-8?B?dXMxa1FGWWJCNTJIZFUvYW9rWWkyc0RsKzRDQnoraFAvWE1TYnFXYXk3eEky?=
 =?utf-8?B?dEQyWEpoVG5RRmxDWlRLN0IyM3QyZXJLTTNEelEwa0ZwMmtqVzdBbUNmT2JB?=
 =?utf-8?B?ZE9Sc1MrbmovLzRTSGxhdzVpMmlqelBQS2doVkVpc1JVRWJFZXNUTmZJelBY?=
 =?utf-8?B?VnduQlBRcUFrTGJoWHZBSEM0MnlwbzVDbkdLcXJPNnFFVVROUjFrbXM3eTRr?=
 =?utf-8?B?a0xScTMzWEFqWXV4S0VxaFZFSzdDUHZLR0hGekJndmx4WDV5aEo2Z3lFMmtl?=
 =?utf-8?B?cGpTNnpJRE9vcmRvYVlPajJlUWZDR1lWdG9SVmxablE3dFM1QVRQTkpJcnRj?=
 =?utf-8?B?ZDBTNVM3bjljcmVYQmltUldFQlo1aXVMZ2VOa290S0FzV2hMY29IdXRzSE9m?=
 =?utf-8?B?cEttclQva21QR1o1QytBcVpjRDFkT3Q4MGZhV3NqTk1KR2VPVE1KVm1saS9U?=
 =?utf-8?B?eHdXL2svckhBT1pJZTFMdmVabVhrdk1yUXQ4MDJlKzBJN2k1dVFTbkV4UzJi?=
 =?utf-8?B?eTJXTjkvazVpVVk2eGhDTUZXenRCaG9UZWhjN0wvaFZCSTJwdjdJMG8rcnE0?=
 =?utf-8?B?VVpxZkRGZW5mK1E2M1ljaitaQTNSWmdmajIyaStzd2p0Q0YwVWJjekZSY201?=
 =?utf-8?B?THYvQVdPcys2c0JrSHNPMTZ1YXNWSDBabTZBeHRHeUsxbGc0MFJUcWxXb3dM?=
 =?utf-8?B?YWd0MnMvQzdFRWIrWVRJdERwVFB4cG1LMUxDODZRbEZ4QTlPT1daVlVVMXBt?=
 =?utf-8?B?NmdocENXT1hRdkpFTTRGM2s1Q3A5WHVlYkVQaUNpaHZzeUFnQVJBR0hUeExT?=
 =?utf-8?B?c3ozUDFhZjZQTFFzL1V6ODZ2bC9JY1NpQXJrZ1M5OUM2UkNsaDFBR1g2VDRH?=
 =?utf-8?B?WnZEVUVlODQvUUtvdkFzblQ4UFA2eHhtK1J0WmtRR3REK3JHS1Vqd0RkL3o1?=
 =?utf-8?B?YkxGNDdBWVRCc0VDL2FORE1seUc0UGV5VFdrQzQyd0l6N0lmUW1hYTNWaTFn?=
 =?utf-8?B?YlBmUng1blRscWRpNkJ0Sit0SWgrYUIzQ1d0SzVqS0U4WUI5OGF6YkJRVE52?=
 =?utf-8?B?MVI5Mk5tWHZwMzgxb3pOWnNDOGovYWFpZ1o3cmFiVFZXRG1TZGx3ejhReFJ2?=
 =?utf-8?B?UDFxODBUOEVUdENTbEU5ZnpRbFJJbVBqZzhtRUJuUjE2OU4rY1BSQXhHOWMy?=
 =?utf-8?B?WWExZlZJQStSUDVmRm5yUTl6YXFaVmZhV24xVCtsdDVCT1hYWFhEY29vZ0wr?=
 =?utf-8?B?bWkrK3RLWU54MUd4NTJGOStQVjhIOXZmU3NnNHd6d1g4RXBBV0plM2VhbHpG?=
 =?utf-8?B?NVhNanB2L3JrcVI3Q3poUTRSRE00dXFQZmZpWmNWa2FsbjZvc2pFd3VnU1Zu?=
 =?utf-8?B?LzNuTFJCVWZjV3pyNmY4TjMrY25aOXhPeUhJUm9ld2dpTnZsVjR1VXg3cTFI?=
 =?utf-8?B?TTVWdlM0VFAzVnR2Uzh0ckpWWVVTZHBUeG0yWU5XMElsZUg2QjRhVmkrMWVZ?=
 =?utf-8?B?UVVxZkRvQmtoeTBKYWQrQ3dKZ2JGY0RlVmMvSTNNc2YzREpCZ20wcVgzNzZE?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71106712-3562-4c5c-727f-08dcb604c2fd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:44:34.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or3ff5TEbd1AKELtjbqwAAQx+NgPRrbTO/G/jrbpvIhlfghCIf5fDcHNrSaoIcJaQ4CMe4OOwjl9+uTUUEo+aoI4N6ucn0qXH5xoz++t9Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

On 8/5/24 23:59, Jakub Kicinski wrote:
> On Sat, 3 Aug 2024 19:11:28 +0100 Joe Damato wrote:
>>> +struct rss_nl_dump_ctx {
>>> +	unsigned long		ifindex;
>>> +	unsigned long		ctx_idx;
>>> +
>>> +	unsigned int		one_ifindex;
>>
>> My apologies: I'm probably just not familiar enough with the code,
>> but I'm having a hard time understanding what the purpose of
>> one_ifindex is.
>>
>> I read both ethnl_rss_dump_start and ethnl_rss_dumpit, but I'm still
>> not following what this is used for; it'll probably be obvious in
>> retrospect once you explain it, but I suppose my feedback is that a
>> comment or something would be really helpful :)
> 
> Better name would probably help, but can't think of any.

perhaps:
ifindex -> if_iter
one_ifindex -> if_requested

(I would also like 'ifc' instead of 'if', for the obvious reasons)

> 
> User can (optionally) pass an ifindex/ifname to the dump, to dump
> contexts only for the specified ifindex. If they do we "preset"
> the ifindex and one_ifindex:
> 
> +	if (req_info.dev) {
> +		ctx->one_ifindex = req_info.dev->ifindex;
> +		ctx->ifindex = ctx->one_ifindex;
> +		ethnl_parse_header_dev_put(&req_info);
> +		req_info.dev = NULL;
> +	}
> 
> and then the iteration is stopped after first full pass:
> 
> +	rtnl_lock();
> +	for_each_netdev_dump(net, dev, ctx->ifindex) {
> +		if (ctx->one_ifindex && ctx->one_ifindex != ctx->ifindex)
> +			break;
> 
> Unfortunately we don't have any best practice for handling filtering
> in dumps. I find this cleaner than approaches I previously tried, but
> we'll see if it stands the test of time.

This code is clean, but by just looking at the struct one could not
expect it though :/ Perhaps a rename could help, or just wait until
people learn it (I remember you have recently explained this dump
scheme to me :))

> 
> I'll add the following comment:
> 
> 	/* User wants to dump contexts for one ifindex only */


