Return-Path: <netdev+bounces-259501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLjZEMApl2mXvQIAu9opvQ
	(envelope-from <netdev+bounces-259501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DC8160092
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956D3300A610
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2426C337BBB;
	Thu, 19 Feb 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1BOt1N4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FB226CF6
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514298; cv=fail; b=L1h6O50iFfUlo/mTTR70xWcJOSxyoII9HIIr/1zP3E1x7MuByqqYF/1gjp5WWSHKOUyiQ0t2HzCtWriWq2IyqxoALgaWF033mQQLLg49WcR9muDlr/fJ0+KNRrAi9iYLa5X7Us9C6pcy/ZTIrXK39z2Sk69qvr0eTg6cEeHgbvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514298; c=relaxed/simple;
	bh=FTtP9ra8eQTB4sl5nscN9OFwlyEmYjL7NkfWVadmGV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5+u0lMjBosp9wTWvDUJi3Nahgxpi8D3fRTu6LX/58TeasTweIas6JZSHWjF2YVTlDB5O+PFNLizgOoGeUoxPXXqPxJHXRzUFQpbhf+d8uye00uRK3bwT1k8Me5R8KztRxY1ru1t6T32FGlx3TB9qYgtyTeDsnM7rZ4mkgq/A1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1BOt1N4; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771514297; x=1803050297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FTtP9ra8eQTB4sl5nscN9OFwlyEmYjL7NkfWVadmGV0=;
  b=M1BOt1N4KRcO5ScECyKU6U5uG8joeuehc21q4b/WK8Cn6TjzNB75jMeM
   pLKoK81P1dEkctMCtqN7t5nokexq6TQGB7eDn3aykSGWZEIqYJ38uYf6B
   VkFD+NmCagcAW5h/JpM+NxkwR1K6wqSt3u5eak48pdNci3YFUhYpJRY94
   9LWB+L858eP0s7VBh14nma/k57lDU6JmOHcTorjKw2IWywFwA6SSKcoGF
   DAJ55OxNU7XSDhdgg1TtkK0y/wpYVBM17OQqLi/+V8+9xASjfGT05bdAr
   BYFKm+KXJc/715Ei1WhNIbgIOnleof82AgdvJMUf6eh54ioid9uBDe7zk
   Q==;
X-CSE-ConnectionGUID: mvziINQhR/KPx1ay1cYg+A==
X-CSE-MsgGUID: 2Isaq4CrTImYkUbbjJ+lCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71805434"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="71805434"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 07:18:16 -0800
X-CSE-ConnectionGUID: 8MV8SwPTQuii/oY4UD7zhA==
X-CSE-MsgGUID: nK2AxjnpSHKlQ3JyP0zMdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218678220"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 07:18:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 07:18:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 07:18:15 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 07:18:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py7WiYLq7GNtL1ba2AJJP/q5eap+x/Qq0ue7e68JhTKVL3RNtr8qJetMJHvPQrwXDMqqH1CbkiA+43h/e/3On6kgpOyN0iuIFhx5XOfzZP8GfwjaXcbP1/edrmYXMZr9Zrqe6vckTJ0kWQ0Syl160oUowFJqKck+Lp3RQfyP0/uFUyP9hF6VlgTBRHiLiDfrY/uiPWgBDaUc22wRMbvP6oBYX/hMVn3wPYJikRprXFjXmopFHr7OLM3hHwtaoHhGWFPMmKJzRFPxWZA/urQC6ua+zGZ+MwWHRa2sR/GFbO1mx0ZyxNJJLcGelrRuXTOPZrELj5KW1dMPm3Nbb+Wq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugtVciNrutPBnrrfwfQSx3hy/F1rgEmuQbjWKap+9NA=;
 b=SLhWNWJgZipYph1ZJ775r/6YeBiMI31QubYapTOO/1cK1jSz9se+52WJYGqikFIukR/b6h+9yjL4LG4ljmUhvWCaOj7LYgzuLkhUfWjv2v6Tc1c+rbw3jEsD/6+Ma0PbOdYgr9/t5aneAVe4q9j7i9LBzHjdAOJHsszqjmXyI4u6r9JQUYhql8KK0f15N9NNGiUj6fgyXbpa/g3UVI0xoq3behERBFpl6k1nDDwRQR+1F6qCp+IR4setqsDTsvXidNiRuN2mfrIWcltXzL6hcpU0k2G8xk1WbaecZSgbktZrd1ocAjx/hgOzo1P6YfUmydD695GISGhn4lRRREJV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Thu, 19 Feb 2026 15:18:00 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 15:17:59 +0000
Message-ID: <e11e8358-7a49-499a-b508-869da5b05031@intel.com>
Date: Thu, 19 Feb 2026 20:47:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drm/ras: Introduce the DRM RAS infrastructure over
 generic netlink
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<aravind.iddamsetty@linux.intel.com>, <anshuman.gupta@intel.com>,
	<rodrigo.vivi@intel.com>, <joonas.lahtinen@linux.intel.com>,
	<simona.vetter@ffwll.ch>, <airlied@gmail.com>, <pratik.bari@intel.com>,
	<joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
	<shubham.kumar@intel.com>, <ravi.kishore.koppuravuri@intel.com>,
	<raag.jadav@intel.com>, Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
	Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>
References: <20260218121904.157295-7-riana.tauro@intel.com>
 <20260218121904.157295-8-riana.tauro@intel.com>
 <20260218175607.711ffd2c@kernel.org>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20260218175607.711ffd2c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e65c41-4c09-496f-1a1f-08de6fca111a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzUvbzQ1R1VVTThyaHZSSXBzb3VITHR4YnEvVlQ5VkduWFlEQXkwTDU4aXB4?=
 =?utf-8?B?cGVOZW5Pb0c0K1laNjlxWXVydTdlNUEzUHFJbUpPbnJRTDFPUHE2L3NQMUVj?=
 =?utf-8?B?OGx6eWp2SWIxYlBJVCtMajYxQ2prSXBZVjc2d1kzV0lFa2pmSkxvencyRk5r?=
 =?utf-8?B?eHFlQzV4SkJLT2JpanJwMFBXb2cyQ2N3enNtQWhnTHNuNlRqY3h0WG5CMmRM?=
 =?utf-8?B?MWVIMm1ENk1RekR4OHNmRlZpS1ZUeDh1OUFkck5tei9iYWRBZFRlYThTQm8z?=
 =?utf-8?B?MU5hRlYvSDM0Qkg5QWNJQU1yajlWYTJKc2NJZWIzdmhiQTFONFJwVnhLcEZF?=
 =?utf-8?B?SW16V0h1OTJuUGw0dFZUUmdsWFZySDJIS2EyU0t6eDFVWVoycFVNTGZMeFpw?=
 =?utf-8?B?TlkrNW1SSGdXNGQvVEFlTnU4d04xUnEwcDdaSWw3UWptbXI1MjVLU1o1Z1dr?=
 =?utf-8?B?ZHBIa3ZKYjdlYjRReVlIMHoyWTNoWWhsT3lSdEhDV0tUSzFMYkE5VTZmM3E5?=
 =?utf-8?B?U01ZanJMVG5wZk5GQjVDNHFqL3RJKzZpeVJFZUdHeHlJWGlEZmthWFJIU3R3?=
 =?utf-8?B?SHEvdE9KeGtTcEpuUjc4N1VrSEJuRitEcG1qTXczaUJWaUxxZ3IyMVBrRWdY?=
 =?utf-8?B?WWdPMUlYQWRaZnAwQ3V6U0x1dUZqK2pOaitsQkUyd1pUUndwM3FQOWNETGFD?=
 =?utf-8?B?WWVaNXE5b09zaFQrVUVxUmNRVzdrcXpBY2lyb3lhU2w2SkZpS1hWaTRIVzEv?=
 =?utf-8?B?U0FLN2I5cWVSYXZ2Zm85QkJDenpGTHA3Mjk4b29Jc0tXdEZzZ0ZCbm1EVEt2?=
 =?utf-8?B?NFlpRUFLa21PcFQrTTdXNHU2WHI2THVGV0h2S3ArdWEwYm90NmdrNC9lV1lR?=
 =?utf-8?B?WndnTTFtUkpzaXJxNURXWHdrZmFmSW8va3g2QThSa1BUQkRldk5tdDhaNGVj?=
 =?utf-8?B?eUVSRzJ2MVRjWVdXbndsM0lLdHBLanZVVldqY3pJalhZMStzeXVZL2tyUlRy?=
 =?utf-8?B?cHlJcEIxUTg1U1ZYVjRnWkxSZUppVWl4eHRXNHo0eFpmZEE2OW50dW1vTGE1?=
 =?utf-8?B?VSt0Q0ZKVWpSS3NJM1pCSGtrV1ZRQURBWHN1WS9DclpkeEFCeXBhUWxMUEpI?=
 =?utf-8?B?ZkM0aWxhTDdBc3hYZ0ovbzRBQ2hUZUVVL0dUbEJ0RGowNXJEdVdqUEU1WkJl?=
 =?utf-8?B?ajFLRmp5ZGtRTWtHM2pteTVxenhKek1yNHV6aWtpU01Scks3TUZiM1MyOXlI?=
 =?utf-8?B?cHFtanRZdm95eEVUV0tkcDBUTEJ6ZjVzYWNNZjhxWjQ1V2hWUkhJSUtnVVdB?=
 =?utf-8?B?bUN2Znk1bjZwQ2Vpd0paM1JLSTZpeVB6MWFjOFZCQzVXRHRWSm51S3NPeUFu?=
 =?utf-8?B?STJxZ2k1d1BCN0hIaW0xR1NsbUp6cUIvRXNidm5vUDNWWDRXL0RUelc2eG9w?=
 =?utf-8?B?RFh0TDd3UGpqWkx4UlR6eHM3TTdqNzgwOVdNVmxCNkNQNFZGSkg1VEFjdzFM?=
 =?utf-8?B?SSt6N29EZ0hCVFRhMDJIa1RvSDN4MEpvaE1XbSttQ045cWtGUGRsTFp1UitP?=
 =?utf-8?B?QjJqNUh6NTQwTFRidG44RnJvdVlsUmVvTXBmR25MY3hHUHhLSVRQYXdQeWls?=
 =?utf-8?B?MUVZTjY3ZUNZNnQwMWk3S1hxSlFhV2xkVWwxR3YyUDlBSkJxTnVRRXp6L2Zx?=
 =?utf-8?B?MFNabndsYTZGWnRHRmRtRUpEQWlRTDRGQlJhQU5mTXlUR2ZzaEJCS0VyOExK?=
 =?utf-8?B?TTA4TUNoV0NRWDZHN01QcHhybmh5RTBIbE9iYkJhNy9sOXVVVzBXN1dLWVlG?=
 =?utf-8?B?WGthZkh2MEV1Yk8wMXRWVDUvRFZpa3N5QTJ2dW5NMXI5KzBBbVo1UmErTjhr?=
 =?utf-8?B?NDZTWjlJcTFEbGwyQXkwSTl1ZldHdkZVRGJlRVU4MDRXMytIVzNMVFFNZ05m?=
 =?utf-8?B?TmRlNzRWa3dvSzRPUktBYTQ5ZDkxYnZZaHNmYVVuaGk5Z3ltK2hFOGxpZjB4?=
 =?utf-8?B?VzgzK0ZxY2g2eUhuKzQ4VEdBclk3N2VGcjhmOXpud0VUcFF2eVQxc3c5NGgv?=
 =?utf-8?B?WVRvL0ZTQlRZMFZLWkhDU1FmdEM1elpFTVBXMmlWM0JpVFM5M3JSRzV2YTEw?=
 =?utf-8?Q?eqCk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURTWm9Ya0ZEeGhvY3g2MFBlVVRxWU1NRlhzN2laQXFhWEtKbGtzOG5FTFcr?=
 =?utf-8?B?aEZvUkdNRHA3UmlzaHBHenFlUE1BSm1YK3RuR0l2bGw5UVo3bDRMNzl2SHl1?=
 =?utf-8?B?MVErRTdrWDdFM2hwanlZd29SYmJidjgrSm82Ym9CYjM5cU9sRVFCU1BkVEI0?=
 =?utf-8?B?S1BvUzR6ZUdxbnp0SVMzRVJ4NEV4ZUNCYUEveVB0eHlwdTVJZGlOTTZjKzhR?=
 =?utf-8?B?bUJrMFpNSUdiT3AwaHFqdVhIKzFiS3hhY3FkR1hhOWpSdGdFclVBZFNvMmtj?=
 =?utf-8?B?VlVFYnNzOFdLQTJCTXlPMFRYd0pmWkRGSS9vVG1MK1ZMbWQveDJiYkltOW9N?=
 =?utf-8?B?M2pLUDZwbnVla0tzM3NFaWdZN3JIYlA0VDUyTW9zbXlzb3NTN0NoOHluM1VU?=
 =?utf-8?B?am4vTnBhZjF2bzQreDUyeHI3bnk5TVR6OHhCUzZRMGphaEhwN0Z1cUJOK1RD?=
 =?utf-8?B?emVwTm1DTHJpelAydVlnbTZyOWI1TmpManN0ZGJEaXJyREtIVDhJMjBUc1Bu?=
 =?utf-8?B?cm9pbnRib2VSdGcwQTIrZTVsbzViK1dYbVA5bmpQakRaK3dzVVRseWJPLzdm?=
 =?utf-8?B?Z01VVHlSVEtna0gvTTVjQW1GOFRGaXZoZUh1eFp2ejJvMndxbXBCUkFPTGtz?=
 =?utf-8?B?YndCMVZ3ZmROMGhsZFJENlQ1QUVDT1ZIdURFcHNSYktKdWhxUVVXZlFhYWJw?=
 =?utf-8?B?TUFpcFI5TEh6R1FaUzFabzJwMUhkc1FRUzNjR29BanBIQk1XR2VSZ0Z6UWQw?=
 =?utf-8?B?a1NpREUvK3c4cGNkUUs2V3VUaXo0b2V0N3JCanIra2UyZk9zNUNoc0pReG8w?=
 =?utf-8?B?THJUTW1rRTVmcjBBYko1TTZBWllEc1BBQWFQQkdyODFhTXVWelMyYmRzamY0?=
 =?utf-8?B?SGV4eWc5azd2aHk5M1FpcFhKdkxyc3NKRHUxR3EveW1SZFlJcFVMVjdoRDR2?=
 =?utf-8?B?eHEvTnpuakdXdE9qTE9TUXRaOWZLbEVqVU9CNDB4QWJIMzBuYXBmODlGS1Js?=
 =?utf-8?B?WmxtVFhMN3JEeFFPNXpOZzJZUkJXcFMrNGNFWk1RQzBVRDRZQjVtVHArV0JE?=
 =?utf-8?B?UHRXUmpYNEhwVktiWU5lOElVOXlVNUl5WUJxTElaZ3BkYnNrUHYxcTF3SkdT?=
 =?utf-8?B?K1NQOWpnMkM0THZEQlNWbUtXSDJHSkQ0NVMrWUllS092bUFxK2pydTBQcHhI?=
 =?utf-8?B?dmV2Q0tHcGxwTFJFVHVBdUVqMEg3WG1VYWZqRE9sUU5BVDRKOWxaTldtMlF0?=
 =?utf-8?B?VjVsc2xsZmY2WCtpRHZCUS9yREllbGZ2MDFlSDdQRFJPNkpOSUwrQlNmSVd1?=
 =?utf-8?B?WG5kWjJZUFpBZTdjZjJSSkpBZDlKNVM0bHg0RFF0NTVFaFVKWXVFU3dTeWU3?=
 =?utf-8?B?QnJoSEtKUVFTUmN5b2lBRXFQR1VReXBrNUZyVktFdWYyNGQ5U0lBODJKVXps?=
 =?utf-8?B?L2ZDUm4zMmh0N0tMN2xXZjNVaGh1cEM0a1kzYTFVWXQ4ZVZYYzdEOUNNWVow?=
 =?utf-8?B?SGF1UDFCK1FqY3RmQWwwOU1KckJvQWRMNCsxbmhFTGdZQUpvZ3BFVGMvWHUz?=
 =?utf-8?B?YWE3aHdXTlFqYklrRWtPcmxkdmNDRGw4V1dRVk5uMGp6bDFIS1VDT2UzZGFo?=
 =?utf-8?B?MHgrTThhclZya1BnYkV1cXhVWWg1ZWIwN0U4ZUJmS2hrMnl1UFMvS054aTIz?=
 =?utf-8?B?V1ZIdGpGaERXN0taR3B4aHZ3anBlS3p5Vlp6Z0s0Wm9zQnpVYTk3eDVDbEMz?=
 =?utf-8?B?YkhZR243MlpLdVBodER1RDVjOG1raVVnUXlnQXMvK2RtamVVRjdUMjFWeVJz?=
 =?utf-8?B?ZkwxcUtOSHhxTU1ndFdOM2xYcnRkKzd4cEw1d1ZwWlA1ZXJySjExTUVnV3dQ?=
 =?utf-8?B?bVR4VGVNQTNhZi9Dck9JZld6S2VIVTMwYVFrRmRCTitkVFhFZm90c0ZEend4?=
 =?utf-8?B?QUxMVWJsUFJSVGhucEQ0RGRvUFMyczBpeTQrT0wwUk80c2Y1UFMyNVVvejRj?=
 =?utf-8?B?a0NwQlFWTXFLNXBBdkdKZHlqY0dqNGcwa2IrajNBUkl1UUh0KytDQlhaS1JS?=
 =?utf-8?B?elRHNFNvVDBUMWxESXhYWHZBMVdUUVRQNFNOU1ZXNlRLM1RaMGoxK28yYldI?=
 =?utf-8?B?WDlueVRuM0NDeTljc1REY2NRcE1PQi8vZzI0bVhHMHJKOU4yKysxSFd1OUlm?=
 =?utf-8?B?czdMSUlBVUh3b1djc282TEphUkJXelNTbzFhT1Fhd0tWdFJjeGlucEtza3o4?=
 =?utf-8?B?cDIzaDkzTmVzWEdaUkJBemowQTRoSFZkY1RNUzgrcVpodnBuelE1aHI4S2Rs?=
 =?utf-8?B?UGRFbm9qa3RUZnFUQTVSNmpZUy9rUTFiNUQ4bC9MaHdjQVlwQlIrUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e65c41-4c09-496f-1a1f-08de6fca111a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 15:17:59.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hE5uRih81W2tCu5HIhtTTFItrQ/MXlVMtfbPzs9q7lesVjoivv9FRb64BlKrFPoggKAz0akB7xKla9hDPb5mkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-259501-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,davemloft.net,redhat.com,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 90DC8160092
X-Rspamd-Action: no action

Hi Jakub

On 2/19/2026 7:26 AM, Jakub Kicinski wrote:
> On Wed, 18 Feb 2026 17:49:03 +0530 Riana Tauro wrote:
>> +    -
>> +      name: get-error-counters
>> +      doc: >-
>> +           Retrieve the full list of error counters for a given node.
>> +           The response include the id, the name, and even the current
>> +           value of each counter.
>> +      attribute-set: error-counter-attrs
>> +      flags: [admin-perm]
>> +      dump:
>> +        request:
>> +          attributes:
>> +            - node-id
>> +        reply:
>> +          attributes:
>> +            - error-id
>> +            - error-name
>> +            - error-value
>> +    -
>> +      name: query-error-counter
>> +      doc: >-
>> +           Query the information of a specific error counter for a given node.
>> +           Users must provide the node ID and the error counter ID.
>> +           The response contains the id, the name, and the current value
>> +           of the counter.
>> +      attribute-set: error-counter-attrs
>> +      flags: [admin-perm]
>> +      do:
>> +        request:
>> +          attributes:
>> +            - node-id
>> +            - error-id
>> +        reply:
>> +          attributes:
>> +            - error-id
>> +            - error-name
>> +            - error-value
> 
> The get-error-counters vs query-error-counter is sort of asking to be a
> do and dump of the same op doesn't it? The return messages are the same,
> one returns a single counter, the other one (filtered to given node-id)
> dump of counters. Not a big deal, but from Netlink perspective having
> these as do / dump of the same op would be more natural.

Yeah they have the same responses. I looked at the other yaml files and 
yeah it would be cleaner to use the same op to make it more consistent.

Thank you for the suggestion. I will add the change in the next rev.

> 
> On top of that please definitely make sure that the code is generated
> with the latest tooling from Linus's tree! We tweaked the output a
> little, it shouldn't happen again but running regen with this commit
> gives me a dirty tree with a bunch of:

I did generate it for initial revisions, but then kept the same files in
the latest revisions since there were no changes. Sorry will regenerate 
and send it.

> 
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 3415ba345ac8..31f0180c1035 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -2,6 +2,7 @@
>   /* Do not edit directly, auto-generated from: */
>   /*     Documentation/netlink/specs/drm_ras.yaml */
>   /* YNL-GEN uapi header */
> +/* To regenerate run: tools/net/ynl/ynl-regen.sh */
>   
>   #ifndef _UAPI_LINUX_DRM_RAS_H
>   #define _UAPI_LINUX_DRM_RAS_H
> 
> 
> Last but not least:
> 
> $ yamllint Documentation/netlink/specs/drm_ras.yaml
> Documentation/netlink/specs/drm_ras.yaml
>    59:14     error    too many spaces after colon  (colons)

Will fix this

Thank you
Riana

> 


