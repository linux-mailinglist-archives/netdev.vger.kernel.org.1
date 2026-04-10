Return-Path: <netdev+bounces-277264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGW1Dr2W2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:20:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F83D2AF8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2735230021F4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4932BF4B;
	Fri, 10 Apr 2026 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDBwWCmO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E21A6815
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802029; cv=fail; b=Bz39iCBQOYdPg8N3Ky6NtRzoU/jmO9CZorsb9hprIrjwQQN30yh6W8x9huNDTKaqHGigPlke5jZurfIHTT8vpj6tZ3be9MaPTc1oNWldf5HuteFakulNLxPNhPAYqkXjkHLZBSSfWWurKQ3Mmsw6Hixlup/A4MmEEH7SFRoQiPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802029; c=relaxed/simple;
	bh=dAs5iiE1e2rUnOSZ0isyNx8qhhvF4ijnlkA/BzdJpIk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jNypYprXfLIW/+daZT2OigXkXmaxrH8hVTRgyu+8jWy+zfFgFOEQn8votTFjJSKHbIEeoUrJfFxRgNteGf/hKPBsP31vfrFI7lr+tSgg7Fj9rWWC+W4xNgMGKcjY0js6ud9oqNTglKYzGkRmaUNEWWXApCUodjummbRqFG3vU+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDBwWCmO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775802027; x=1807338027;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAs5iiE1e2rUnOSZ0isyNx8qhhvF4ijnlkA/BzdJpIk=;
  b=TDBwWCmOPtn/kblNyoR904GTH3riteFdP0tCf/8zy8rvBYfxbBTM4Ppq
   1brywsCWVVijzqZ4Q+UNNLMqAanSKDFZXJTGQQlZescHm5gKFeyIByccP
   9W0Gi/K9qS6v9T+37JT80k8gb5S+ylRxPxZyd0Izqq00uNJYHtSZCp8c6
   aUPtCTXF6PjyvDSf4Gns0XCixYKoPdCEL81/7sF4QbiX+TvKFD4lFYQYL
   J1ZO6AnFysZU1XYazcWSmyBWRc9I8J5ZV72KO1fzcenfPrWqwgsolpTED
   0l82kUpRAPhBTTmV0uxvSGP7r2arLaMvhuvBbSdVOBN2IpyooDtVG/fR2
   g==;
X-CSE-ConnectionGUID: dwDjq5o0QUK81UmLL3xC4Q==
X-CSE-MsgGUID: WePvNxPpTc2RHb1s7fZkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80409011"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="80409011"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 23:20:26 -0700
X-CSE-ConnectionGUID: fEkYILRPSWiv8flXxq0xzQ==
X-CSE-MsgGUID: nifSogyDQTShjxtYnykcmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228886360"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 23:20:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 23:20:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 23:20:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 23:20:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2w0VRToroJPTtXBKtMDbqpvoacKz4bWtNWHwgi830QrRbAyWcqZzRg/047oIX8b6VlFX9onXcxcwieaoL0BzNebBGZUq2kr2WsHYQzMT9gwBOhdVF4jDCSuuSRAiKBgEItFYdglbiGP52nLzw0HxeOuAyc75rXvirr6UDASiBFNYD0nqYd259o0x848/qMZKtOLeEJlHsQckm1klJucAc2N8bw8MVdSgAuYkDlzX4cijS6WS9I5bSJ4DDVgcOv+B5SrgDUt/cLH71qpHlmxhxR5SsdNLdq4vRwZARpZ95RpnJ8wWmCyJo5c5hUYuDezgLrQRA1JqTUWIpbKJ55ukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWArsXTtMlhIX04+a43fnORPDzwlai8rBhUzFK4M+Yc=;
 b=BsTi/+jeM/4wlLYaSYpAu6h82rnQ9emHi1dwuiIVcW6+ff6obpZdK1gpK4P/UuZFM/9JybsjznV3dP0RKuncwEhwRaVcchtAkvVgzM0LRl7ZDPO2R8ARzVLoPoBM+mgpHTE7OWHr19u9sXSIqznMhXyaubv5Uf+hhHKmTRCD9AuwhK3PuZBqfESEN40oObPbZZiClHYGDCNZuZXl9BPkl9f1RV0PpaYkajT6ZE73oWj4BSiib1bG6W6Oq1tcEqnA6PuOl/tZkob/srsJH/G1uyYuptpFn0SjxBHcbpTycZfoxpWEoA9sjwBFLh3JUuIrQd0WK77P8Wr86t6t5dtFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Fri, 10 Apr 2026 06:20:17 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 06:20:17 +0000
Message-ID: <69c061b4-eb40-4e2d-aeaa-5dfa47b2db8c@intel.com>
Date: Fri, 10 Apr 2026 11:50:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
To: Raag Jadav <raag.jadav@intel.com>, <aravind.iddamsetty@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
	<netdev@vger.kernel.org>, <anshuman.gupta@intel.com>,
	<joonas.lahtinen@linux.intel.com>, <simona.vetter@ffwll.ch>,
	<airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<anvesh.bakwad@intel.com>, <maarten.lankhorst@linux.intel.com>, Zack McKevitt
	<zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
	"Hawking Zhang" <Hawking.Zhang@amd.com>, "David S. Miller"
	<davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
 <acPjxf5XTYuR7sbM@black.igk.intel.com>
 <09f253b3-ee64-4fbb-8cec-820e9769aa80@intel.com>
 <adc6hTz-xMopiJsc@black.igk.intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <adc6hTz-xMopiJsc@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::8) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CY8PR11MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9fe60a-9083-467a-dc88-08de96c93be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7FO7QXvtbSCB3frAMyCwgEeiq4tuPTdgSSijP0Pa30UjnXXk6JpNXJIFMTY3IJG0GG77cacd/HKEp5IVZB0WiSJyA7xuLIiZsNb20Fo4l0Uj2auPZe/WBsoF9cYoY227vWaBO1bxq4OavkxsGaP/xdlCz/4XotrlNRoo+N5Pl5Fr/gDFZLtEWk9cvYUBZ1gOMWa9yPBGzXcHwM1Ozrier+5Gw+WjGSUUFi2SJCkXaQXgH4CPYtIsq3QwO7wqssuxCNaLMr3F05eePMu+EZHE0A3QEL3R5qYwUk3PxpI+qtpwpUVH57XIhbSPNb4RpYQGLzPJrxyMJwe6GpBkTk7zU0biPPqLqmzYil65ZwKAFlkbLuusEOs9YxVe/IF6y2ggYpDK4j9xmKxNp/jhIwziYFLuTgyshKFkUGMkD5rdT5gNlSabFk6v8tQl8SZqSgSJG6Yowqqb1YzCb5PnMBmWbskzgnFldZCvb0yDdMUp8QvR5DGuJiM5RRdvApcuLsKOV5SGucgMixsuyYLjLgXRbtFgkJiiUEBNRGVOJdxDCARWEUeS4MZ55cGo3+D6+H2TjDhqckEkLkY4HBgUk78j4puhIzwqaM9DdfwH/qHm/CBme+/SRq9FVMC8+BSi2ezqRgCFStLYJ31CdrsjSw3ibYhXfLwMuAxC4EfGzgujd8qwAehKOM6H0Xf6xV9BLPsG5HpJVzkaoQGIwAoxSIXRUXT948rWa45pqUBztXAxBIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdneVo1OTg2ZVlTZkt0eWJVdS9XWm1VamVtYmFpb093VlIvM3NNc2hCa1hw?=
 =?utf-8?B?dTFQSHE3M0QySC85enpLRDd1TDl1cGQzWG9NRnVpanh0dEZUNGNadk1HL2Nk?=
 =?utf-8?B?L0tpVXRGQlk1dUprNmNUTmJERmkyRm5RZndPRHFIODlGbmI1R3YzTVFlaHN6?=
 =?utf-8?B?S3IwWDE5bmZyWHVkUWNDd0xMTWpIWXNndXhOUDJYSG1QdXIxb0dZbGFWTGhl?=
 =?utf-8?B?ZEY0MWh1OGNyTVpUNUpzMEpDVHhBQkduTzVHblhqKzN4Zmg3dGdoQ1UyWUdV?=
 =?utf-8?B?K2hGSFBMMSt6cDI4TVBFUSthQVN5WlY3M1V0ME9pUkN5RkRPMHNRY2REVGJs?=
 =?utf-8?B?K1A0OFBHdFN5YmRUR1Y0VDU4MHhwR1d6bFJCMjRHODEzNFlkMTA1Rm83OXVq?=
 =?utf-8?B?TkJMaVdMWVExeGZkQno5eEVlK0dFdFFBTlZvTDVMRGx2b1FRVkpUVTdud1U1?=
 =?utf-8?B?c1VEOEZBZGxva3R2R2ZzeEwyYU1ZOEtOTWlDVEFZOEhwY0JnOXRaVmg3bTcv?=
 =?utf-8?B?L0Y0bHdDbWo5akJPUU5ZbFVZYnl0cDBsaEtqQ24ycm0rdGhHTnp6bnVaY2tq?=
 =?utf-8?B?cnJsOWxCRDRHdkg3VWF3b3BhQ0FFY01kbXVNWlBOdG9xNG1TNWNwUExTekdS?=
 =?utf-8?B?RzZ6TnBTa1Zpekk3QnNidEd2WGhnQjZwOFFYNThPZEJ4b1dSQlpITk00cDVy?=
 =?utf-8?B?VmxSU3NzdHpDWmkwdlBicEo3MFZCdlppa1BodUlpTzBIOHBaejQ5dy9xdVUw?=
 =?utf-8?B?cDE5QzdkNWJuZDhYRkp2V3JETXl1ckJXRCtjZnk2QUJ2dTRKZTdDQUFQd2lY?=
 =?utf-8?B?dXZoZmZCOTRVK2lKY2tZdVVRbEVVUTloRGNxMWNCNXRCWHVsN1lpK3BZcTMr?=
 =?utf-8?B?eTNVQVVJTURSQjZ0aEpIbjh4QXg3WXYzWnQ1TVN1UW43YUxMdzJTeTFoKzRs?=
 =?utf-8?B?S0s2SUExUXNhbTl2YnlaMnQ0NUlWQmFyd25FK08rNE5nZCtsTXh0WmEzNFI2?=
 =?utf-8?B?UDJ2V1o1MFJmQzUvTmJHdWlyOWVXRWtWZ0JnamdONmJDOUFmR1FHQkhoRkJO?=
 =?utf-8?B?RGg2MFRWQU13cUlQZTE5NTQvaXpTNU1wdW85M0lGanZCQ2gzNy85TXp3c21k?=
 =?utf-8?B?NEV4VDNnQkxXRlU0ai9XNHpMTnRkYXg2Wi9QY3FpV0lZVG51UjVpeVlXSEVP?=
 =?utf-8?B?QjVnamJyR2o0MnhXcGg1dzFqRUVxY1J4T3NGTGp0aEcwYVBqK0c3V0VmM3Q0?=
 =?utf-8?B?dTZmcHovUklLY3lpclU1Z2ZuY2tPVUdXQ09OWXhUK0RpLzA4ZzZNams2TG8w?=
 =?utf-8?B?eU5sUUN0QXlaaE11QVVSV2R3ZnZDL2sxK25lSStWeTZuUS9BTGMxcys3VXkx?=
 =?utf-8?B?Q0w4dlVoeEkrb1hZWWN1VWJHWFgvOEc4NFZKekRzMTVHK0JTS3ZqbmVjTjRz?=
 =?utf-8?B?dEZyRHh5SWd0QVljOFVGczZOK0U4bk42Q096S0piSC8rTmk2RGVLbmh1S0Uw?=
 =?utf-8?B?dlh6Sm45YU81aHdHTXREdE1vYjJwUURGRmNPRnlGUVZ6OHZ3WFJWOXJsdnFy?=
 =?utf-8?B?QVFUNEtRQlk2QnRDOVlMcFBUYzh2QmtLVUFmT0RoUTN5Q2Nvb2wyN1dnUDdL?=
 =?utf-8?B?OTlsQnRORE80aU5WMThxSEFKck1lN0RUS0pLM3d3UXlUUFd1OFAvazFZeWpy?=
 =?utf-8?B?T25xYWQvbXRKWWlHRXZyQmlrL3pZNWF2RjllMW9HZk9WYkU1SjRlbEtOaWVr?=
 =?utf-8?B?TTBWYnRPQU9veEJ6OE9VRWxjbi9nZVMzd2NEVzlwVlBaems0V2VJUFZYdjZY?=
 =?utf-8?B?ZFBGVnJwdGQ0RHNwM3VwTDZSVnFVN2hMMWtKYTA4cVFMb1B4bkNPTi9TTHdK?=
 =?utf-8?B?YmE3RkJYWXp0dERRQUI0YjBNYmswQUxNaHRJYjB1TGM1ck1HV0h6ei9tV1k5?=
 =?utf-8?B?V2hvajdiVm5vS2FWNlgwcFRzcitrRmJ5b2Z2N29laEFzNkt4TUFDeVpSQ2di?=
 =?utf-8?B?YWkzZTZPdlJYQTFOZWtwbnVuQjdkWDhFQ1c5L0pIWHRINzlrL3hqY0s1RlVX?=
 =?utf-8?B?b1QzSWlHZGZnUGVjbGhUaG5DUE1oM3NuZmRUQXVqY2VOZkI3cmpwcUlyaUxv?=
 =?utf-8?B?SGEvSEt6QlB4NE1pNlpqSkJrOTNjUEo3ckZyKzZTNHNhd1UrU2xrSStwWXp0?=
 =?utf-8?B?WjU1OFJJa0FHT1lNdXlsMlk4UkxxZWhTbU1BaitIZW9KNWd1THBFb0RucU5W?=
 =?utf-8?B?VUNXQnRuVTdqQVhqSWJONkI3OG5Udy84UFlxdGFZNUQrb3VPYzNDZ3ZqMFRS?=
 =?utf-8?B?dG9aYzg2dzA0UjZyUU9tcGhTRk51SnZFcms0KzJVQVVKak0vYTdQZz09?=
X-Exchange-RoutingPolicyChecked: I+i7c/iUbeslzj5EhbRrQpogoRm3g9ZFAkt63PnsimtCHuhsRABCdgBoylU6nPwd4UghFtbaCQH8xs2KdcMsxFVEpcxc+JsnuQrR+n7O1qpJ0IQwHdPHPswJw0PkKRiU3iOT6zkZxSt1jIoL3faQrHwmsUU0WGFTIvT4srqhRX34a9ndqObThTRarDFuy7P4Hl9GU711NFKQYM3cX5YUcaHhg76OPjBbdjGlFEYpKQwMy+unkYwm6UD2jKjGX2NPWF6PXX2kcryk2T8sDgwDs36YE+j5sBHX9ukjyii9eMSHIBbj3kElmkVp5nCTahwaso7h8hKhDFGXNWf3v93CEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9fe60a-9083-467a-dc88-08de96c93be4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 06:20:17.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHL1ye40YHTiWUYMXABHz16zTZVyV/qSRYbcyoPbhGvZ0zwAhuVlwikvxklINMSVXl9jWVdXy58b82MZGp1HQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-277264-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.freedesktop.org,vger.kernel.org,linux.intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D70F83D2AF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/9/2026 11:05 AM, Raag Jadav wrote:
> On Wed, Apr 08, 2026 at 07:59:33PM +0530, Tauro, Riana wrote:
>> On 3/25/2026 7:01 PM, Raag Jadav wrote:
>>> On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:
> ...
>
>>>> +Example: Listen to error events
>>>> +
>>>> +.. code-block:: bash
>>>> +
>>>> +    sudo ynl --family drm_ras --subscribe error-notify
>>>> +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
>>> Can we also have error-name and node-name? I'd be pulling my hair off
>>> if I need to remember all the ids.
>> Yeah makes sense. We can add the node_name, error_name.
>> Adding device_name would also be more useful in the event.
>>
>> @Rodrigo/@aravind thoughts?
>>
I tried adding all parameters, but the event response seems overloaded.
I think node-name, error-name is not necessary since this will be mostly 
used

by tools and scripts that get the nodes and error-ids prior to subscribing.

Let me know your thoughts

$ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --subscribe 
error-notify

{'msg': {'device-name': '0000:03:00.0', 'error-id': 1, 'error-name': 
'core-compute', 'node-id': 3, 'node-name': 'uncorrectable-errors'},

'name': 'error-event'}

{'msg': {'device-name': '0000:04:00.0', 'error-id': 1, 'error-name': 
'core-compute', 'node-id': 1, 'node-name': 'uncorrectable-errors'},

'name': 'error-event'}

Thanks
Riana

>>
>>> On that note, I think it'll be good to have them as part of request
>>> attributes as an alternative to ids (also for existing commands) but
>>> that can done as a follow up.
>>>
>> We cannot use names as alternative because it won't work for multiple cards.
>> example in xe: Suppose there are 2 cards and each has 2 nodes. We cannot
>> query using node_name+error_name.
>> Also most of the netlink implementations use id's as unique identifiers.
>>
>> $ sudo ./cli.py --family drm_ras  --dump list-nodes
>> [{'device-name': 'bdf_1', 'node-id': 0, 'node-name': 'correctable-errors',
>> 'node-type': 'error-counter'},
>>   {'device-name': 'bdf_1, 'node-id': 1, 'node-name': 'uncorrectable-errors',
>> 'node-type': 'error-counter'},
>>   {'device-name': 'bdf_2', 'node-id': 2, 'node-name': 'correctable-errors',
>> 'node-type': 'error-counter'},
>>   {'device-name': 'bdf_2', 'node-id': 3, 'node-name': 'uncorrectable-errors',
>> 'node-type': 'error-counter'}]
> This means they don't persist the user needs to figures out all the ids before
> anything can happen. In device node world we have /dev/dri/by-path/<bdf> which
> makes it much easier.
>
> Also, I'm not much informed about the history and it's still unclear to me what
> problem did netlink solve here that cannot be solved by anything else? But we're
> too late for that discussion, and again, not my call.
>
>>> Also, what if I have multiple devices with multiple nodes. Do they need
>>> separate subscription?
>>>
>> No, we subscribe only to the group not the nodes. In this case the group is
>> 'error-notify'
>>
>> $ sudo ./cli.py --family drm_ras --subscribe error-notify
>> {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}
>> {'msg': {'error-id': 1, 'node-id': 3}, 'name': 'error-event'}
> Hm, perhaps I need to spend some time wrapping my head around the new concept.
> Let's catch up sometime this week.
>
> Raag

