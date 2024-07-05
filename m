Return-Path: <netdev+bounces-109489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB09289AC
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8E28997D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F914C599;
	Fri,  5 Jul 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss6RCdwL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4414B96B
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186115; cv=fail; b=CHbhe2oBWAwU8CTk+okMiRe4ccUzQ03ozPJYQ4M68YN2wk3Nxu1hESE1gLNSraOrMxb4kVzJygNiqmMuXMWGjPi9vlBEiDYSkesE3PQn5X3Z2PwK93Rs8Rxnc4yQ8zuytfYRMWfnbkuLFdEd2NXSJLVTbuQGiE2JuqjmsxDZZlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186115; c=relaxed/simple;
	bh=uajEb0ZFwxnOlFNveUjz4W6g51ybxnB3u+YslVpottg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3/eYfNfRTgie6iLipKyFktTQ2qHBaKbcIC2DZRoCFpifSF+5u4NDefO9U6YrUhh1rphnd+C5tYCGX3B8B7ta+h45OG2JWAC2/86P8VOnHBq481UkgbUbFDRQ/UnY4YEIJkq9i/egmY2NeCxXO9fIuJR3ygs/ZahhbWDF+KCvw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss6RCdwL; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720186114; x=1751722114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uajEb0ZFwxnOlFNveUjz4W6g51ybxnB3u+YslVpottg=;
  b=Ss6RCdwLTlRo35ax7IIMC0Ty/SXOAJWKXFzbTrkpGzFR1p/msYOOSU49
   HKT8XyAE9qhYQ02p/MJlJcMSqpw7rv1u1xxEThRJWuOVNFy+ihsJbPOfz
   5T/KhRAxpl9tKjFDFxrU2OiEQGKxX2ldPwSm3g4k5v3/6fA14V4Zz23nj
   2/hNwib16Qdvg3SqEIgayWqAXRlWwdKkErQu5eO3Y7Tb0vwMZEJ7VYdEL
   AbYX6VLlVDFKA6EGV2bJXcwH+qwsHdpF65bwaLQ+SJ5m4gLsYbBgT++lk
   IRyUtyoQ3BcGyMdn3yXZlQ3+skO3xhUUZqSVCQwOCBgRvWiuaH0B/+lot
   A==;
X-CSE-ConnectionGUID: Xhko89zUSc2+ibqAQu/W2Q==
X-CSE-MsgGUID: 3ZgvPPw+TeeELGBxvNA4/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17349375"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17349375"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:28:33 -0700
X-CSE-ConnectionGUID: kP8xogasQc6E0QA0YCSFNw==
X-CSE-MsgGUID: sRzV9qwgQ92YeA3d5c7rCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51214355"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 06:28:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 06:28:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 06:28:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 06:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EINyOveyphMUlcsn9wZipuUY+cvSzWCE1yVMw8dhQ0DUp0+ea65SYDeNp7qCVw3BbXEZ2tsb+joso9z45SKMkhEYtx7IO9jhbb0+XFyylTqS5KyO7AKpj5UNw057zuzwlp97/QqP6BQ58d2wkmN43NKnb090V9/nABafe3njwia4QLH1+JnGYpnQCueUtUThiGTc2Dn8KIUb7PLh3rmVIh2AEe3Hb2yNS06dCiYyzpkaVGVurBQIDbY+v/BIjQe5gp8vCKfnicSYb+ueOxl2zlPQfPy/NVtW0kdx4MRsgc2zaVq0Ot0tMVYCB5u6CrcFB05LHK96y2mqFG+oqMWPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ou88OtfVG0wb3L1C4cf/ZqPPk0hvPJfmZ360CEbwvY=;
 b=QL9HPf4NJltDKHZELFO5qiQQ+m/vFtQ47ao0Twuizg4TH63I4qpXWvSDtvbywSi5qz2P2KnLmXUhqsBCeBugmMvo4iNELJTrFW9SBP4bEylVQnDz6iLV7YLKSc/1Wu0Apo+rmAiMVGENhWI62WUrNDrO30fABHpWGiO3lcT1POMUpbEBB0N7Ec9ACGaxmDP8OzpAsmvB4VVP4LbiHipvanl1cYFbXjL8DquBI9SBSzdel8U0DhmbjEaEC1dyFQ+0Go6mWk239q5RUKTH0p3jbc8NFXSGnv6H2RcSiSrE3PNIhc6iINspkWchXhHAfIZHzteSrU8nk0BaBj6RcXuLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6917.namprd11.prod.outlook.com (2603:10b6:806:2bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 13:28:28 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%7]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 13:28:28 +0000
Message-ID: <79f8905a-0eb7-4203-bdc7-fa77c25e79ea@intel.com>
Date: Fri, 5 Jul 2024 15:28:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Johannes Berg <johannes@sipsolutions.net>, <netdev@vger.kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
 <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
 <b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net>
 <ba861ef2-eb28-41c8-b866-f3accc7adf0c@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ba861ef2-eb28-41c8-b866-f3accc7adf0c@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: f07efa16-5a58-4e40-e3e2-08dc9cf65b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnJnUlZpTU9VWGV5S3BzRG40cU1oT00xRFlFNkwzeDRrbDlZZmxPbmRRTzlP?=
 =?utf-8?B?UC9qbSt3ejRCcG1NYmRXbVoxWVp3M0NwUm5MSDFWNmEzaEJsSVhEUjN4WUxX?=
 =?utf-8?B?YXoyVzVBQ0FUZ1lvZ0cxVjE2VjJZL0o0UmtqaXBFRFZEeVc4bTc1Mmh2dkV4?=
 =?utf-8?B?czJocGlJVmhVVG9kYStuT0gwRmNyL1BpVU53L2Z0bE5XTUtkcUJDeWZqMzNp?=
 =?utf-8?B?VWNTZjFDR3NQTlhDZjQrN05TU2MwRDBwUStMYjRabG9TYkZtaTd2djNXTmZs?=
 =?utf-8?B?Tm5lU0E2WktlN1RORmlOYkdRcVVyZ1dHaFphbjA4bEJiclFDRjZnaDFWYkl1?=
 =?utf-8?B?eGxFNlc2SVBidWE4Znp6WFlBOVdUR0VoTjltWWhZVkczK1JlcklzWUhDdzFT?=
 =?utf-8?B?NDFFSmlkbElEcmI3eTc0cVMzWktRUHp3Q3AvVTlPb0RjeitTQ0M4aVpEbHV0?=
 =?utf-8?B?QlNyS04ra3AzYml1c2JDRWRWelBXR1Z2RmtMeFl6S2RkdExLS2lmUUg0dnd2?=
 =?utf-8?B?dklKOTlDbWl2L2lrUG1NWXpSMDFqT250TlFTTm4rZWdnb3ByandDVXpNMU5P?=
 =?utf-8?B?Y2xrSTRjSSs5bWdEdEE3N1IyNGpCc1N0dFkyL3p5Q3F2UTcwcm1HYm12dExY?=
 =?utf-8?B?Z3I1TmFNaWdRM3F5RVh1d09IQTdOSWVkTUVOaFN3aW9OcEVxQTB4SDk2RnFQ?=
 =?utf-8?B?S1ZOblQvK3Z5TkRpenFVcU9lSlh0WmVBQlZwR0lNWlJQZE1mMU1MM3JPdTUy?=
 =?utf-8?B?Sk9SRlFabTZrRi9RQ2VLRWFKNnBlVVhySFlvZS9DMFhEYTgxZ0pxaExiOXNo?=
 =?utf-8?B?ZmErMGR0ODRpT0Q5cDBqbkZqTXUxZmJyTkV6RFltNm90UmYxdU5SUWNTQlND?=
 =?utf-8?B?Nys4eUsvbEZhVUlLVldKUGZ3WnBuVEtubGhmYWpRVE1EY0RjOVZZTXRzZjBU?=
 =?utf-8?B?ejhjVDB2UXpCS3lYMk0wak5sa0x5YkFEb2ZjRUZwdXlpQlZ2aHIwS21RYW1L?=
 =?utf-8?B?d2pINC9tQURYTDNkejd1U1ZhR3hFVjR1TUxuTDk2WmhzSk9NdFNJMXdQcEdP?=
 =?utf-8?B?VWtwZGwvaHArRHdMTzE4ZzAyNGRrWVl2alFjbDUxS05jeVBMWUZsbTZhRFZi?=
 =?utf-8?B?RE5GQ1F5UkFVSFdkMVYzRC9oUHNPU2sxR1FXMVRnWGc4NHhoYXdzK1k1dUxr?=
 =?utf-8?B?VFU0T1FiTjRhTE4vRE8wTkk3a0k3am41Um9yelpsYksyWjE0RHdBZGRZWUpx?=
 =?utf-8?B?Zkw0S3BHZ1kyN1k5VzVEcFNqSHNBWnZUbURwZkZ2TXBHOHJpNlgrSjdJQVNa?=
 =?utf-8?B?ZG96MUJtZ2E4bFYzYmhrWGw5bW9YT2dRelhIRGFKc2FxeTBXZkRzTS9TRHg1?=
 =?utf-8?B?bzM5ZklqV1cvLzBsRWdmWXcwNzM0THVqNTJHQ2VIRGdqeXZYM0J1RXRaOEt1?=
 =?utf-8?B?bmhRVXJMYzdqdU01cllvWjdwWTMwOFVUdDlIK2ZqbTJ0UkhJNisvV1R6eU1w?=
 =?utf-8?B?cG9sZTE0V2NIaGhlcVRFdXdGR3RMQTVlTVhTNEswY0JUdjk4SkM1amNuZ2NW?=
 =?utf-8?B?NTdGUE9aa2x0V1cvUFhrNktYV081QTZGZDRIM3pBdzRaa3dvamtHeGJmOTdI?=
 =?utf-8?B?LzNTQU40Y2R6ZkRkTTlkWi81VTdiNjVpeStGRm1Bc0tyTzhqNUVOQ0MyVk85?=
 =?utf-8?B?VzlPV0NYak9OajV3V01YaGRscDNIVnNqRTBmbkY0a2UzQ3orczI5aU04K3ZH?=
 =?utf-8?Q?cSJ3t6Nb8AIN/veYfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NPTmlSY1pOcVBGbmRhd1B6YU5vUkpWNHg4SlRIY3VjS1BheEJFLzNUQnB3?=
 =?utf-8?B?QTV6MmkrWVR5T0VGQm5OMTYrV294aFdId09NRS8yWXM0NS9yWkhFeCswMFB5?=
 =?utf-8?B?TzZZY0lQS09hdGJuRzRnQ1p1UmUxYk9VcEFrTnREVjJPNThhM1czSWdqTGNP?=
 =?utf-8?B?WG5BeU5jQ3ZsY1pEb005d3NtVXRhcCtsRFV4SFVnT21kUEJzTUJnVzJ3SjRG?=
 =?utf-8?B?K2lCU1hybjlpWm5vNTNXUUpmQUY0ak1wbHVuNVltL0tNRE15ZGZScmpPZ2hl?=
 =?utf-8?B?YWlTS21XeTMrZG5zVi8zdVd1dTREblpwWFBvU29tc3NvWnk3NXFJUm8xaTRv?=
 =?utf-8?B?cDYxS0lWcGN0ZlNxU1htY2hHK3gzMVJRQlYwckxsbDRzSFdvckhYSit0Nktw?=
 =?utf-8?B?Vm1vWHpKMkkzZ0tid2pDMm9Dcm8wL2N5M0xyUG0rZTVRUHNtYnBGbXJXL2I1?=
 =?utf-8?B?K2M3M2o4UEpZSjBVdFY2VXI4Q1pQL3h5TFBFejVNckh0UUo5WVVKVTZNcU9m?=
 =?utf-8?B?V3RaYTFKMndwVS9tMXZtcDJCU0ZxbTdVT21XNjhQbm1nanRTRTNqUVMyUGVP?=
 =?utf-8?B?UG8zenpRUjJnZi9NU1B4amtOa09kMEdSajEzcUllOFJUZW9uOGwxcWpqcjFa?=
 =?utf-8?B?anpGckN4TnFockpEY0d1T1BSOUc3dzNOTytzVTlrTDZueWpmaFNlRVA4V1gy?=
 =?utf-8?B?VVRJM2Fvc2hMZS81dGlHazVZeTVwWG95ZGhNS2psVlpoSUFUU2hwemVaT2gx?=
 =?utf-8?B?RFEzUzJoMm9pZXhnQUR3ZER3ajNyRjZQNDVFeHp5bFdQSkdyRElXdldRZWZQ?=
 =?utf-8?B?elBlaGYxQ21BK09sUFVxNHFZNWFQRXR1dUFXRTJPYWRIVm1jZXNsMzJ2bVB5?=
 =?utf-8?B?TmE3a050UFJrYUcxZzBRM045Mi82MDdNdS9PZllsS2RxUkErZjI4RDFDZ2ZB?=
 =?utf-8?B?U2NjZGcxd1A2MHQ0aVhXbS9hQzg1a2x1K3V1Vm0wa1pQdytkMmE2akxCalpl?=
 =?utf-8?B?OCtGUC9VSzBFN25zUE1jcWlyc1cxT2pvcjErOFRkRHBJTVlPWTY4cUcrcVZM?=
 =?utf-8?B?WitXMzVGLy9sSElEQ2g5cFFSbExINWlJcWV4WkNieWdlMTBsTnRMbVdibStB?=
 =?utf-8?B?RldTUUx0NUd0UXEwVktWTDJVdGl6VHR4M2tmQTZEcXE4OXY3Nm80V0p1bnBC?=
 =?utf-8?B?MStkald4MGpEY0N0MzNFZFlndzg2Q3BOdkVRQ0JSa1RROVFidWhFVDBCOXc0?=
 =?utf-8?B?Zmx1WWhROVEyYlV2ZHM0UkFMdFBzcjA0a2FjbUZoUjV0aW4veDk5ZmYwY2I1?=
 =?utf-8?B?d09iMlVCbFpnVEcwN05hRG1JQ2NUTVFBOFE2K2FGMHZHSnFlTjRWYW5sUjkr?=
 =?utf-8?B?NzRsNGJOVncrUWNIanVnSnRRUnJzQ2NBVmJFVjhRaVhKOXFJWWRjL0Qyek53?=
 =?utf-8?B?ZjBLQmQrYzFpR0hJbXlrVUlYQWdWc054RFJGd0hrRWFqbk1MK01RdmZQOC9v?=
 =?utf-8?B?dGJCUXo5cUNsTVh0V1Q4SmVrc3BaU1V5VFQyUXRhU3gxMS9SY0I1dm85VHFF?=
 =?utf-8?B?QkRkejBHZ2ZWY2V5SlR3dm9HV3IrOElxNisrOUE2ZlI4Rjlmcy9XUnJFc2ZS?=
 =?utf-8?B?TG11a0c3dDF2L0VYdFVoM2tjRzRaRzVHQlhrbnZoWlp1eUt1bnZycDR0N05m?=
 =?utf-8?B?RUl0Ri9LZjFTN2kxdXpTNGJFY2VyS1lYL3E2QjNqY050YUdiNG94cnA4QkJI?=
 =?utf-8?B?K0JCUjZucGFLRGFhdjIvcTJWQS9PWDlBZEZVeDBWVGdvaUdCNjZvakg5QUpy?=
 =?utf-8?B?WXZWWmNzNzIwV0pISEVTcHBYQWFsTERNOG5qMlpYZ0FHdmRoTjF5L2R5ZDgx?=
 =?utf-8?B?aE9mODhVOW1kSm5kb2dzQndIWTEzaW1RNEZ6R3k0VUdFT3ppRkJSYmE2ek1I?=
 =?utf-8?B?b3VOVFhEUWhxQm8zTjAyK25pZm01cS9wSStCMVkyT1pGYXNPQkdVaXdybGp5?=
 =?utf-8?B?eFNreVQwU3JQTlRBaW9PT0VwVWV1UFIxZ2JzSXBIVDJKaHduUDA4UkhmQW50?=
 =?utf-8?B?eTlVVzdkcUt2c3BpVTRDNFNldTdQcVVNTXNIUlJzSHBEaVRsZHZTSlpGZUox?=
 =?utf-8?B?dWZkOTFwOXlBRlJuSkJpd0pqWmZhSjlBSmJ0aE5mZUw2dE0xSUhHMEdxYnQz?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f07efa16-5a58-4e40-e3e2-08dc9cf65b08
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:28:28.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mlvFQueZzfge2dgjKlWqPY43uI2yqHgzUYr4PKvUNmcsXDwNOXGlbctzD0K7mpdxbsoNIGx5r8VF0/aVVBRqgDnhBu1rdPF603LmiIOcY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6917
X-OriginatorOrg: intel.com

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Fri, 5 Jul 2024 15:14:53 +0200

> On 7/5/24 14:39, Johannes Berg wrote:
>> On Fri, 2024-07-05 at 14:37 +0200, Alexander Lobakin wrote:
>>> From: Johannes Berg <johannes@sipsolutions.net>
>>> Date: Fri, 05 Jul 2024 14:33:31 +0200
>>>
>>>> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>>>>
>>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>>
>>>>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>>>>> be intended, so fix that.
>>>>>>
>>>>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>>>
>>>>> "Fixes:" tag?
>>>>
>>>> There keep being discussions around this so I have no idea what's the
>>>> guideline-du-jour ... It changes the code but it's not really an issue?
>>>
>>> Hmm, it's an incorrect usage of WARN_ON() (a string is passed instead of
>>> a warning condition),
>>
>> Well, yes, but the intent was clearly to unconditionally trigger a
>> warning with a message, and the only thing getting lost is the message;
>> if you look up the warning in the code you still see it. But anyway, I
>> don't care.
>>
> 
> for the record, [1] tells: to the -next
> 
> [1]
> https://lore.kernel.org/netdev/20240704072155.2ea340a9@kernel.org/T/#m919e75afc977fd250ec8c4fa37a2fb1e5baadd3f

But there you have "the exact same binary getting generated", while here
you clearly have functional and binary changes :>

I'd even say it may confuse readers and make someone think that you
should pass a string there, not a condition (weak argument, I know).

> 
>> The tag would be
>>
>> Fixes: 90de47f020db ("page_pool: fragment API support for 32-bit arch
>> with 64-bit DMA")
>>
>> if anyone wants it :)
>>
>> johannes

Thanks,
Olek

