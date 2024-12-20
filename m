Return-Path: <netdev+bounces-153659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652089F9185
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08FDA7A2DA9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286531C232D;
	Fri, 20 Dec 2024 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2B6bh1G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DC1C07CD
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695001; cv=fail; b=fgbkYeKOo+/rlNLQJsIC/gry0lFb1wZ5V/Yx23ABnTEemWGl3FV3lGD1rBlGFNvT4XyLD+uuKbEVsozROfZfQ1LRLuSk6MAm0hENf9ZVk09mkwvfU5jqfIdkn8KH2e04GvvZIWTZmULAP/7kIECaqCFqk+sLIWkG8ecpadjIUKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695001; c=relaxed/simple;
	bh=fpbNuwcCfzfYKMEKnfgp8oWhPwyAij/ENNRWmc2ezGA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvMfgsCuMeBQdpdJX2F+j5imCe4WDMPXVC6Ju+VAnLOAcjR8UQqK169iMsuPMtcuFWBrD/mNCTUlcRoRyIBNW/e+YnBkAdKM5cRGDwzW542/OzLXY2Nm5CGkHaHx1bnHyJpwwgxBUgb6xM0dbPVx8XJ908kB7VGJEPrnrfZkOuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2B6bh1G; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734694998; x=1766230998;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpbNuwcCfzfYKMEKnfgp8oWhPwyAij/ENNRWmc2ezGA=;
  b=K2B6bh1GCcytYZp9MP5PkNCcSYXfqUptbJjkamuWR0IUWergwYRzogWw
   Gz20Jw/AC5GoHXU9Lz5bYqLp2zF70kWrqMgHx7l94+7lqxNHGpjdGvHxF
   3x1sXyvkkyl9Fyrm2Mgd/r1Y0d4TxxHyDFPBshgR5M+pbbMW/tEAI5FlT
   1Qe8X8pRSXPLsYmBBx1lS52V45lIk0p+3I+nH1RjddNqxCWSlpUtLUNxN
   /Ci+hn+f609iiJx2jhfLujuZmyHRUbfB6wEEsvVZ+NB1TCzSj7OX8CMms
   slvlNODQWF53fXYNtu0uSmGh9scbHD/SD95vQE/iFdhUP5srYUyTIKvpC
   A==;
X-CSE-ConnectionGUID: uB2mziI5SXOc81Croegl0Q==
X-CSE-MsgGUID: 9PP1SU2VTSaGehKX02dyIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="34562880"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="34562880"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 03:43:18 -0800
X-CSE-ConnectionGUID: JZ05LqsnS0adAHcJnB4pUQ==
X-CSE-MsgGUID: qXCJEfhzT0eOA7Tl5cOSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135835143"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 03:43:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 03:43:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 03:43:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 03:43:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKoOLUZJ2LtIpHMNnBB1xyyuUpg7xpqYb79UEb+cN1Yyllkv7yLu+IVIJKjbiWyTkdFHSBDC7pDaZ3oit9CsDTAVhbx1ZPdcqaVIa1WGo9c7UoTSOHPboyCPh9i1nMeimR983bT/5N/qjfIjFwDeyAIZNWLfmyWR2V18a4i9ObcZTbAEiHbE0KGG6UPqaOpo1wxvIW9/P8wIC1u7j7rYdPoLj5mtjdZbavpI+6RWrLTw+sgXo7FMA2qhh3LAYzzwm0iVzscCqLQ/VJsiiojdBA/kJGfOPErI5B4WwEXOQ/H4dCkjU++/DjgdRlB9v9QRlgrawsJ0MXx+TXwTf6H1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND2nULnbw9vIzIQ702Y85tAt9/IW4zCTUBysB7+M/7o=;
 b=EZojEFxKzhjX0YWC7n4tmp+RJ9DhvNIwusHba/uUM3+W1rlfNn9pSNDgHwgfK+i+13qTe8FDPyVC9XhF8zP1MbIdOPoy7iUm/tUCsUN4CqnExZDkV8zpR65IiB5xbHpbWm8jfZlAPXRIqeolC8awjGMCWWuvcJhwfzXSqPMpnBpgW1HC7cgyGlihtkkVCeZHg9dPUPSTUuiq+D19xPnSVv+DRMzptsBbqlMe7EtVgIOpA2MdJGUgjtqXSBPWzek/j7mVo7hTAXrc0GdMF/eAB+jLFGUSGhgZClimcY4GBsK8b/4m4aH1vjunvYYKx/VempHUamOXH/nekM+cSsq3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:42:46 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:42:46 +0000
Message-ID: <aa36e48f-a54d-43df-979c-bb81a90257f0@intel.com>
Date: Fri, 20 Dec 2024 12:42:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] eth: fbnic: support querying RSS config
To: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>
References: <20241220025241.1522781-1-kuba@kernel.org>
 <20241220025241.1522781-3-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241220025241.1522781-3-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf69f9c-5a35-4359-6ec0-08dd20eb6c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zk00SXd6Q3JNSU05eUI2R0NONHp1ZjVDazJsM2hsNkpxaTJEL0hhYnhqYUtn?=
 =?utf-8?B?cFRwbVcxaE9sdFQzVzlyb1VRZ1Brdy9vUDFEeGtXakFlbmxMYXBONFVGamNY?=
 =?utf-8?B?NWhHOXg5S1drQU5rOUQrQzJkdEFRVFRveVg3NUdmTW9aQ3V0NmhITElPeE9I?=
 =?utf-8?B?a2JGd1BBeFZ6T2gyT2M1UGg4SlFrTVQ3VWJpc241cCttUWE5NlFQV09CWFdQ?=
 =?utf-8?B?bS9JNHAvWEo3M3JKT0xubkNoMHlBQ1NqdjV6RnlvU0lCM3lPOFo5U3g0NGV5?=
 =?utf-8?B?ajJ0Y3V4OG1UVXhhRHYyZDFROHJpSmhPME5NdzhnZnBVSnErS0IrT2pkOWhq?=
 =?utf-8?B?eGhHM1c0a1Z6MzMrbWpVc0EzSmN2VTFQblZmdU5wenVwUGhzN0hFMEJxOU1V?=
 =?utf-8?B?VFl4QlM4cGFiSjlSRnE3UGMyOU15Tlhkdkh5NDFSbDE5bWpxYzZFN3h1cUwy?=
 =?utf-8?B?Q1laVzlQWnVHZ3BwVXl1MTVQV0hXZnEyazZXdTdHUkRqaDlVUEZSZ1ZjczI0?=
 =?utf-8?B?U1c2cGhVMEl6Zi9nTDFNN2lpcTA3aUx0Y2Y5eGhIQnhZTncyS2t4dFZHa21q?=
 =?utf-8?B?MzNMbkVZQitrMjliSnBwZWtFaXl3bnV4ZWQ0d3liMlh4MklBK0lDYTFFcGhk?=
 =?utf-8?B?RzI5Q1A0aGh0ZzZnZmdobVlDbFdEcjUydTNjSTJhOG5PNzVPNGl3a1E4disz?=
 =?utf-8?B?NlluL2RBVDE5THhZMUcwQUVYWG5Ob3VxU2crR1lOR29TRVB2eHpNK0dWWURO?=
 =?utf-8?B?Nzk0TmY1NW00MWROa1JZRW1HQThyNHBoNzdiZC9VbGF4dHV0cVZtNER2L1J4?=
 =?utf-8?B?NEFaS1I0dEZHVmg3Zk5YSXFweUhiTDg3cndJSm5EbUlFN1hHVXIvYnk1bS96?=
 =?utf-8?B?RWo1d3pTTDQrSmVvRkxFNDRJemtGOHFEbDBVMjdTYlA0c2VOSFR3b0RpMGhD?=
 =?utf-8?B?cGw3TjJ6SjIwY1RzbGdtc0FsSndHSlFHYlN2MUttVkJJWHlFREVvUzJFTVQv?=
 =?utf-8?B?QU9yZGJrQVdmV3c3VUkwbEs0ZHpDRDloMlFIWHJzREVyb25wMU5BYTVITmdB?=
 =?utf-8?B?STZETU9SMkQ4QUFlb0xIY1ZiZ2VTRzkvRDNRQnlwa01zNlpIV2lMcmEwUnN1?=
 =?utf-8?B?b2k4QlFvRTgyZ253MTNxKytNb3hYN2VMT3oydUY5Q3pEU1Y2SnVCZmR2WHo5?=
 =?utf-8?B?K3preCtNVjF4NGNtaDlHTWRscGFmY3VaYUU2cFJGWFdCa25ObzVjUy90bWI4?=
 =?utf-8?B?bWZ0OElnakVjNWc3bXZNOXl2ZFNXQTdrbHpCSk9MZnhLam9OeGxTTmI2L0Z4?=
 =?utf-8?B?RnJQUk1lWkhPekswUW80bDNFVEJ2M0xla1l0eU92NUduSnhPVTVqK1BQRUNp?=
 =?utf-8?B?Njc5eGhjRVFaZEpQM3hRZ2xPQzliYnVPeU91SThyTGpYV25OWkhhWUxyRFNF?=
 =?utf-8?B?b2Y4L0tCekY1d3dRbUlWYW52bWtxSm5iRmZqMmxtb20waHBSMkwrZm5paC9k?=
 =?utf-8?B?WWdSSlFyZTFjNzRNeXRoM2czRWNVTnVLSEdVT0c2QVIwc2R1ZjYwQmZrMEla?=
 =?utf-8?B?aDJaZ29ZZ05qaEJYenpqdjg3aWFIM012cXNRVE1zbjN2UDlDZEVLWFN0TVBz?=
 =?utf-8?B?Q2FGdlpVQm1ISmkzcU1ocmFReitFcVFXTXdOd00vbFBaSlNLc016bWlmdHE2?=
 =?utf-8?B?Mk44RXFtYjRSNk5icFJITmRyT0NhOURJa0NMMHFxRXZHUTF2cjY2dkdpeTgr?=
 =?utf-8?B?UklOU1ZJamhweFJnS1VmVS91TmFZQmFoVUYrOUsyYjVXRGRaY01RRGhwZDFs?=
 =?utf-8?B?UFpsZlF0VE9QVHU1MkFON3B5a0lnejdpTjUzbnZQZUNpQXJ4dXFGVVFWRjln?=
 =?utf-8?Q?buW5IC5AhkNBc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hNV0Q2SHJVMTF0cmRha0FVOHhFREk3MTBINnUzVGV2SVROQ3dmYlgrRTR2?=
 =?utf-8?B?S0MwT1AwRUNBaVRiUU05bHRrb3RnbXpyVmlKVEdhMU00dXhwZnk3YTgrSEtN?=
 =?utf-8?B?SGdpVGNJVjQzbFkwK2JCdCtsZ29oWlJwbldia1F3eTBuUmdURk5jRzVhTHQ2?=
 =?utf-8?B?Tnh3SXNqV2s4QlFNajN2c3hjTUNyYmM0ZllmOGk0bVBIeXkzaHBuRmxPSzMz?=
 =?utf-8?B?TU5RSXQ1dzh6ZXhzbHo1TXo2a0xSL1hBSGFhYkRqNTd3TnFMaEpGWElDOTZV?=
 =?utf-8?B?aW8rbGd2MUcxeVdUK3BSRnFSWnllTVB3T01Fc3pLUDA3QWIxYkpURG9FUlFX?=
 =?utf-8?B?K1RqMmk0eENabjZXU2JVbFZRT1BwWXJnNTdZVXVsZ2pNbEVoM2VLcGl2a1dL?=
 =?utf-8?B?VW1BVGlVVGZBRGlEUHVzN29RajM4elBRdGovMUxaTnRZOEFUb2F0YzZQNkhH?=
 =?utf-8?B?RGZhYVhtckNQVlhTYnEycnF5cDZ6U1h0bDdlQlBkTDNXZElWNHRWTFVnc0Nw?=
 =?utf-8?B?WnpMdXI0Q3Z0T1d5UElzQlhJZlpYbHlqM2N0UmsrVGZLNE9idkZNMWZkZkZT?=
 =?utf-8?B?OE5FeVJKNGF0TkFrc1labHV0dlpsRm1JOUEva09mS0VNSk1UNURCOFN5MUt5?=
 =?utf-8?B?ZXZhczdYeDZpMHZuVHpRM005VUdmeFBVMmxnSGo4ODhQdTYwa09yVURsdXZo?=
 =?utf-8?B?NzJ3cEp0Q2RDVzRrL0duWjhMcjFTN2NSZGhxckdmTGVkdkFmNU5zQ1dLdHNL?=
 =?utf-8?B?ajVzZklvZ2JOWTVVc3RwRjhwQVphaVZRczZhMUhOWnlFbmI5SFlleG1Wamg4?=
 =?utf-8?B?T2Y0aFJ6M0N3YXVzeXEzRmY4WVA0S1M1NUlFR0NBZCtTWGNXb0lYb1NiaFRP?=
 =?utf-8?B?dFMwZGlrampxS3pHc05HRTRpS0xzclN5T2JXeVdKS2Y3SFBKQmNmT3dIQ0l0?=
 =?utf-8?B?ZHo4Z2RpMzF0VzFpOVFpY0N4M3pQRFhDMnJCWml2dDhQTCsvTmJRZzJXMXNx?=
 =?utf-8?B?OVFoUnRueUoyRUFPeFFwNzVMNVF0OTJ4S3pTdk5IQmtiQXhsODhuZEtET3Bt?=
 =?utf-8?B?czk4QzNFUnhwTUROTEM3aWtTQTJKWUN1TDRmM2ZQWWVmOXZEUUVhYTRmbmpL?=
 =?utf-8?B?c1g5QlMrM2VKckpsR29oVHpTOW91UDlLVEpDVmNIN1NveXhSL1QyN0owWC9H?=
 =?utf-8?B?RHhxVXZHblV3UlJSblRMS21pR29Gd0JONmtIQ1NKSXROTzhTTzFGL2N0K1da?=
 =?utf-8?B?bElGOCtPRFVWK3N2U29uaGlHK3NEWjU1WGdWODBySzNpNEhsZjVvb3Z2Ymx4?=
 =?utf-8?B?L1RvZThPUG9vWDI0YjZTQmxGcEVaYW1nTi9XMC8rOUtpOTQrclVaYTRLK3cz?=
 =?utf-8?B?SWN1M2ZGamxMTUJUSnFvRjNFVmtucmc2eis5eDZPdTlIT3JJeW0zTzg2YjlS?=
 =?utf-8?B?NVExaE9ReXY0YzdzRVpXVE1VTmlDTm1hQkhQc0RPc1Z4akhpMUJPaEs5QnZ2?=
 =?utf-8?B?QmxKOWxPWGR0SU5uT0d1ZXY0NGcvTm8xZHd3TDhaUnVtd0dESnpEMGtaeVlT?=
 =?utf-8?B?TXFvN083SUQrNWVqT21US2wram02RGxnaE1GYmowUmJRNzYwaUEyNWFLRjlz?=
 =?utf-8?B?ZHBLcXV0cnhTWmdrOXRZVUk0a05LZkZTT3JjdVkzd1VTZUZkYTMxWUZ0dnFw?=
 =?utf-8?B?clZOdTMySC9pVTNuQmxxMWF6bEcyako4MHlVK1JVUGNOZzFYdUJxS21JTkRK?=
 =?utf-8?B?Y3h6Tlg1UElPaEVnSnRtVTdoNDU2UHpXZUhUQWxjVkErWEJEMmhDWlZYMlAr?=
 =?utf-8?B?Q2RGSEx6MnBhWWlIeGl3SnhYYUJEVGxTeXNPdG5VaE1FY2pXZmordlNQelFR?=
 =?utf-8?B?bnAvQXVhR0VETEJVeTNObXF6YUFwd3dtdlAzdzNTTTJJL28zb3pqQlRyblZp?=
 =?utf-8?B?eEdoK0c5ZE92Qlc2NkJLVG9nc0M4M2ozL1FrNys3SmI1QXE1VnVKNHJqVUds?=
 =?utf-8?B?bEN4SnIzdmhXVG05cVBTakxBOWNmeGdEN1dtcEpjV21jaVV2ZTJuL2QxMElO?=
 =?utf-8?B?VkVoYnR4eEVoYWVWQThldVlEY0dQRFN3NzNab1JLMkx6Ny8wNWZlUlVaY01s?=
 =?utf-8?B?OTV0S01VZWk5MWZ3YjBFdUNNOXlyR1pvK3RjZkM0emNqdFFtOUZORnQzWUln?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf69f9c-5a35-4359-6ec0-08dd20eb6c57
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:42:46.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33hJvic/7eyYOnZi+1mLSzqZZKp+0E4n3RssSl+0KxgpGScAeQAqHEvDaaHaZr+Qb1X2Zpx7qvugTL6PEdPXim20shbA6ainkUl3r3AbiMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

On 12/20/24 03:52, Jakub Kicinski wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The initial driver submission already added all the RSS state,
> as part of multi-queue support. Expose the configuration via
> the ethtool APIs.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 103 ++++++++++++++++++
>   1 file changed, 103 insertions(+)
> 


> +static int
> +fbnic_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	unsigned int i;

AFAIK index type should be spelled as u32
And will be best declared in the first clause of the for()

> +
> +	rxfh->hfunc = ETH_RSS_HASH_TOP;
> +
> +	if (rxfh->key) {
> +		for (i = 0; i < FBNIC_RPC_RSS_KEY_BYTE_LEN; i++) {
> +			u32 rss_key = fbn->rss_key[i / 4] << ((i % 4) * 8);

are you dropping 75% of entropy provided in fbn->rss_key?

> +
> +			rxfh->key[i] = rss_key >> 24;
> +		}
> +	}
> +
> +	if (rxfh->indir) {
> +		for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
> +			rxfh->indir[i] = fbn->indir_tbl[0][i];
> +	}
> +
> +	return 0;
> +}
> +
>   static int
>   fbnic_get_ts_info(struct net_device *netdev,
>   		  struct kernel_ethtool_ts_info *tsinfo)
> @@ -209,6 +308,10 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
>   	.get_strings		= fbnic_get_strings,
>   	.get_ethtool_stats	= fbnic_get_ethtool_stats,
>   	.get_sset_count		= fbnic_get_sset_count,
> +	.get_rxnfc		= fbnic_get_rxnfc,
> +	.get_rxfh_key_size	= fbnic_get_rxfh_key_size,
> +	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
> +	.get_rxfh		= fbnic_get_rxfh,
>   	.get_ts_info		= fbnic_get_ts_info,
>   	.get_ts_stats		= fbnic_get_ts_stats,
>   	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,


