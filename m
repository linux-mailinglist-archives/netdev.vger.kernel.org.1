Return-Path: <netdev+bounces-217339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DCB385CD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B19A1B64229
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE432271469;
	Wed, 27 Aug 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKpCdhPD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5323B609
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307432; cv=fail; b=hselM9tk/0VptKJM2yGVrkmbusRLuBed9tyY+abv7krv9rrMmrblW5Zsv020ooL95KxBChH+MG1onCW+c9OpN4ctPm9dLNAMxM6u9N3sWGgJDK0/hdOP7HIBsQ1TU2zGFKJ+t9QB5yx08942CvIlMKMK3SoehldOjfbPF4bIv6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307432; c=relaxed/simple;
	bh=CTRghobkF9FnsMGzOZ7Iz5NEtxg75SrJaUX3hIVnxic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoQjJ6fJ+1B4RDKtJfvKAlSx5UdaLnst+UjcrL2jdPFEOR9FN5wTHZh2loKFMbnx8zGwbSEc1Zdz/ybMOEkh4ZwPflf0pFIuwtssc25X9JB6hKWH9xp5YRUahUdNhTgPlPopECYF7UA5N0v9z9HgwWedHjEF6uu0c2qeErnpwL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKpCdhPD; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756307431; x=1787843431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CTRghobkF9FnsMGzOZ7Iz5NEtxg75SrJaUX3hIVnxic=;
  b=SKpCdhPDHahqsFjAI2gHP6Ov3wFkmyutfxs9rDRdEah8QwOpz5YNfWvh
   06/hDRcgWrruUJrVTnYODWVY408A9N9KVBfvPVYUrZ8VO1WRLV8XiS7OJ
   x5slXBjXoXfmuglGwOqDBdKGdW89/gr3jxl+gw2AKQOFZbAGbBsUh6T8d
   WKLsSlITcrx/292+GUpACyE0na7B1Nr6d/26f2cEevddaKd4R+2dHL6s6
   sMbj7skczR5HKNcWNJtoESiGEepX7Dw7W5dvmcsNd/ezxphJhwTrS1f9B
   BKuKvMYizq6D30H0bdFY5Zy4wlgNiJQKEAW2Prx9mSNkJAgi0uWsB1Z4m
   w==;
X-CSE-ConnectionGUID: NbBl/+TATk6dTXXJaGEYrQ==
X-CSE-MsgGUID: yXeagzxGTl2uMXYeec3UWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69272756"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69272756"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:10:30 -0700
X-CSE-ConnectionGUID: 3xCBgmoDSx+VEa95WykayA==
X-CSE-MsgGUID: dJQMFLU5TNidzQEGR+yH/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170033798"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 08:10:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:10:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 08:10:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.83) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 08:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbQwhlFw7IkKpGJGvicWuuKRGfpSpeJsqKcq460R7l807czvq83xOviJ2gQIZZMRp8IWCiP8JX/KKQb5Pz0Ot4RCmR2bWcT8sjqze/5D4VuomZjb5NJFNDFGPcekWrkCZ+EMY2MfwnDKxA/kdSo2VlnkApAkrvGebMdy+7Gp1EoOUqO1/IlqC+izebVqRNNhneEg7j2Wf8WedHuFy0snu4SJA4oviyySdDOsxqlvdOExdOFP0mz6sR0yyy1dyalvNWZVNXQcz51EIwgKtXIoL/4YJFXDxd5WbVQuGhoqvH5ecv3B3ATa7TDqz5DpsFC6ik4Ze8etYe4DVVi/XqesXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/+KTLyS7uoe0sAiLK4qmNVs3ZifQ3IvNu3hlqGYxZE=;
 b=iZJWw8eqLLAyv8NKQizgMbTqpXn8iHZPW9MfvpakXXUAGIs/QMy5ruquZQMKy2YXIIyQCJ5piNkNzc6luxkXJIgi8yehmRAQX7QaOtYn4N7LlI4kmmEygfvYEwaJrB3ydx7PTj7h7zW+ktzz0FlVvZ/mmQFz+7db79q9Ds7tvr/zoAHr9EZS9Wb4m1ARNhnbqAVgxgslBV+SDRhvBfH442t4pTXvnyiuH+Q7/mX8iGhWjGc9WxdiJsTIwLKmvo8fd4baTAszR0zgsWgrxugSaRPMqZIbd1KJGATPIMpG3G6e8bPCcqWcAgngfljXI32KYtI+RZ6G+DTV59thALS+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 15:10:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:10:24 +0000
Message-ID: <1555821c-0645-4b0f-8c4d-dc3cf2ab518b@intel.com>
Date: Wed, 27 Aug 2025 17:10:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: wangxun: add RSS reta and rxfh fields
 support
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20250827064634.18436-1-jiawenwu@trustnetic.com>
 <20250827064634.18436-3-jiawenwu@trustnetic.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250827064634.18436-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0009.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f27d7d4-3fdc-444d-16fd-08dde57bd8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTNhM3B0MEpBb2pKV2xpRHByRmdQSHlkc3JRR2hXdnFpK3BuVzN4VGlrT0cw?=
 =?utf-8?B?YURwWWd6SGpTdmN6Q1Nidlg2bzAydzBoT0VlVEFaVUhZSWZQNFl1anU1b2xk?=
 =?utf-8?B?bXYrcXd5enlBYnRVNzlqb0lCUTUyaXlXcE9MRTVCNTNDU05uTnU5ck02MzVw?=
 =?utf-8?B?R2FFWEtVY0Y4ZG95THlKbG1vczJBNS93Y3hWOXl6WWZ1TmpMemV1WE9uY0hs?=
 =?utf-8?B?enBMS2Rad1JDN2N2d0VGVmZaNm5iemdvWVlEUGM1WFFRS3pxd1FSKzdKVEl4?=
 =?utf-8?B?blRmbzFzRXVMR25ta2Jib0dTRE92dXZMVkxFNGU0VlZRVzFVV2hYcnh5c2dK?=
 =?utf-8?B?WTZFNDRWc3BJeXFxY3h4NGU3dEE2aDB1aG51a1pwL3dmbm0razE2eGJZNk8y?=
 =?utf-8?B?T3B5eHdGUXVwa3pVNnNTaHBUc1cwYzc2THFCQlVnRVE0SkhhS21RQkpTOVJB?=
 =?utf-8?B?LzRhdDNhVVA2M1NTdHNnMzBrZUc5OXpzZVBwTkUvMXBwQnR5WnB5b2xsVE1q?=
 =?utf-8?B?SkRHcnRMd1NYeVIvTkdDMWRHdURTOVB2ekhOc1JLQjlxd1pRTmR4aGRHYmly?=
 =?utf-8?B?WlBFY0wrRHhNOWhtUndtRVNvWkVaZklQNVdsQ3AvQ3dHNEJ0Y085NWJYWWM3?=
 =?utf-8?B?R2F1SzM2TURoTTFjdmFZdndVd3lkTmxTQStHeVh2Q0RqYVBPRXQ1d2dZdGND?=
 =?utf-8?B?YjJndWttQXE2NW1JbE1mM3pzcmNFRjl6V3dmNzRLUnV1WmxUVENXL0lBUGYz?=
 =?utf-8?B?QWNVRXZjWmJsY3VmTjJWVDR5Tk52T0tTTE1yLy9HZUcwVGxiY3hGQmZ0NWlZ?=
 =?utf-8?B?d0RjYnFzWHM5dWFsQWJkNThtUitjVlcxb2NQT2FBRzZYdTlmY3VRYm9YVFBl?=
 =?utf-8?B?MVlTTjBPTTZMTWYwUERteitmblpDT1dGTk5CUlVOY0JLblZHMmJoOFIwa1gz?=
 =?utf-8?B?b2VVZ2VoRkxoYkQ2eWRaaSs4OHRkL1FYR0p6ZFVZWTF6WFBISHhlUDgyRm5F?=
 =?utf-8?B?bHhuNERpUmRlTlRBK2NsMUtqamNzd2FxYXR2elhHVjlRL1BLQUYzanFHa0Fa?=
 =?utf-8?B?NTNCZUhsSjJVcHQ4V2E1UVhGM3NQa2RxRzRaWDMzOWFNZHVHdDI4OFdwRm5k?=
 =?utf-8?B?dFFQRVlxWlNYS0Qya1Z3T0sxQUtvSjNHYjFuZ2FwUFZ3R3dlNzdUMEs3Y05Z?=
 =?utf-8?B?ZnAxa1k5TXZ3VzVJN0xsTC9xZ0NrL3RmMjg3Tm1sVzVFWFN3Q3RFZkdUVVBD?=
 =?utf-8?B?a200TTY3TTZneTl2bEIzYWh4a3VBY0RtVmU4emR0RUZGb0hvUUZTVkpzaEpl?=
 =?utf-8?B?aUxNbkNHWERxN2c5Sll4cHVHNCtBS3dacHBmOTAwWEl3a0M4QkJ2Q0luUEgy?=
 =?utf-8?B?d1MwNldRT1ovQitYZGdvOFhIOU12amFTQ0ZqaXM0SUg5NWdiR3doY1BwNSsr?=
 =?utf-8?B?WERiK3ZzSTZyTnlteE5uUkVFRXUyRlFuaVQ0U09jT1MrWmpwaEo4d3RrMUlQ?=
 =?utf-8?B?b1FkczVXTEh4ZUNEOERzU3JYQVo3KzRERjY3VS9ieVlYaXR5SlIvVjBYc2Ny?=
 =?utf-8?B?MlRIOWwwUk1FejhHU3dMR1FXZDA0ZUhLMHA4K3Vac2VHSC94VzNTdXBPQlFk?=
 =?utf-8?B?RHVKdGg1QmVkdEN0QnBLa2lSRXVmSFdKSmpFVS9ScWcyU2NnQjdvbTJTNFho?=
 =?utf-8?B?YnFoUDl4Q3RabU13QUI5S2NCVmRWZ1FJVDQwc1NlbUIyS05odElmU0VUZEVT?=
 =?utf-8?B?dDBLRmZFaDBGbTNpTlRVUHI0US9pK2JHeCsxVGNLWjdHQWhYU2wwTy9CMWF3?=
 =?utf-8?B?K010Y0NaNlUvSEpMbGVEUm1URUdzaUJpVmVJZ2c2Yzl4ZlVpbDROb1FaQmNF?=
 =?utf-8?B?b3A3bHZxRm12MkMwRFVNdjN4TGtucEd2cXlzaENmZTVtdnV6RnROMnRhZFFl?=
 =?utf-8?Q?Im+QZCYzvc8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZoMzFRWVFsZjhtYjBQVHFRN3dwd1BkSDQ5d1p5dnZwb3NNRWw4bjhKN1Ix?=
 =?utf-8?B?aXpFM1BNSGpscHkySWttUVFEQzdTUTV4ZFJ3MHE5OFVxZVkzOXFBTzVoMENx?=
 =?utf-8?B?ZHZqVzVUbXdKa1FzZ1BKQzZ2SFllMEJTeDJpZFRLM0dvSkl1ZGRrdzYwcU8z?=
 =?utf-8?B?WXVyVjd6b1BkMkJFb0RXR2xRclordjhiTE5jdHRDckFDdWRYLzk1YWR3eWo1?=
 =?utf-8?B?NjhRYjJoNmUvUE1RR2kwaEQxb0UvVWVrVktnTkFJTEJtalFRUTZEZElUZ1dx?=
 =?utf-8?B?T012amJ3UVdkVHFsUFdZdmxXQ3p0QW9nanpuL29wTHJxTlprdGFwYWFrRG4r?=
 =?utf-8?B?Q2V4WXhCYTNoT0p6bXZIZTg2Zkw5V3FMTEllUXFnUFd1a0VCOVFoWk5qaG1v?=
 =?utf-8?B?dE16Zk1DRXdTQWNrdG5oYmhNMWFkbFBZajN6M2NpU3ZoWm9kWDIyS0NrTFMr?=
 =?utf-8?B?Rk92VDFIdWFrTzZMa2dYZGtiOGt4R3FYVDBPcEVqM2hkeUZQSGFSeG1GZ0Jl?=
 =?utf-8?B?TmloT3NCZ3h6NXhXbjkyOG5CdE5mNjc0YkJoenM0VzBubWIwNUhjN0hnVzFE?=
 =?utf-8?B?bUs3OTlaVERkYWJrdzkrblRGYWFURlZOUWloSmdOUXFYaG9mREtNQTh0dHE2?=
 =?utf-8?B?d2VIeml2RDAzYXUvN0lEa0g5c2ZjTUJOaWpic1FpMlZHaDcwUm5hNlZISlpT?=
 =?utf-8?B?cmh2ZStSUnNhZUVFMFJpMzZyQTlyOTZPbDRCVnJvaVFRZ3czNWlDZHZHYkRo?=
 =?utf-8?B?T0R1Zis0eHlpVDVLeHJwcVYzeFlkS3BwcXVTc1VjMXBXY3dTVTZiSzdCek1t?=
 =?utf-8?B?b3ptZHByL0ZHZWt3NHVUYStWd3lkNmw4dzFYNkp5VVQrWGdlQmhUd3dRZHNV?=
 =?utf-8?B?VmJQRkc5NXd0Y3R5Rkg0OEUrZzFqN1FNckZLWVQ1UzRBS1E2Vm9XTDdYM21B?=
 =?utf-8?B?bXg2UGI5L3BwazZiVnFyV01wV3pDUXMwZWxmc2FwMVR5ck55Y2daZ3ZaaTBw?=
 =?utf-8?B?SmltZ1NrYXpLSml3Tm11cHB2L2h3TzdYc3U3bjhUN1JFMUl3T1FuWjZFKzRQ?=
 =?utf-8?B?NkFtNVp2ZGlReW14UWVHYjFIaDlOclFiSzM3dENEaEUyTlYwVy9FSUovQTd2?=
 =?utf-8?B?UENyYi82bzR1T0ovYnJhUm9pYUJvODhKU2xTWEhodVBqQnJFcVQ0MmhyeEVk?=
 =?utf-8?B?NHFWQkpaVCtxSHBrWGZMS2NVSEE4Uk9HOTU2My82d2lIZ25MWDIxblV4S0l6?=
 =?utf-8?B?SE1XNk1jVGluemdXc0M4WFdLNldvM0F1ZDB4SE9hYlpMUldCc2FBUmZSeTRl?=
 =?utf-8?B?UlFlL3AxNzRQbS9wVnZkUTVFYlZHR0NSU2tPeE16c3FBTGFjdDZEZGtIOTFS?=
 =?utf-8?B?R0laSUdVVVZNcExob3U5ZmJLbkQ4TEhLajFLWXNiSWFrOHFVaEtUTWxZZDVZ?=
 =?utf-8?B?Lzk4dEJwUWpHYUtNYyt5V0VMU1dSV2dDVFZISVUrMjdEcDhXQWt3MHNXMGFG?=
 =?utf-8?B?N3oxRWwvd1NtWUI5UTNVRDcxUHZWTGx4aFlwZUx0c0FaUnMvMjRwd2srb1pY?=
 =?utf-8?B?NUhkMDV2andSRERJYUlCYzVlWURyZ1pwMWNqdis4NXFBeXcxa1ZVRS92Z1VS?=
 =?utf-8?B?WE92ZUYxVzYwVDM3V2xUMVJDOFRKV2JyZU4xOHYxNGkvelorQUo4MCtzWkJj?=
 =?utf-8?B?Z2poRWlRcWI0YlB6TFlLOCt1QUw4cjEzNVBReHBtZUkwTTFJUDdkWTlXTDQy?=
 =?utf-8?B?M2tMaFhLUzJ6NmtkeFZRcGF4TWRMNnpUM1dCRjRGUnIvRXZOOEJRejZuRFAz?=
 =?utf-8?B?VlBJQlpBMmdQNFAvZC9pK0NKZ1ZLRzJDUVF3OG0vcmNGcUtRUEVhRFhsSG96?=
 =?utf-8?B?WHlYemU2bVlSQVBFMHRuTm9oU0VyV2VTSFJsTVdaSjFwUlJyWDUvWWwrZWgr?=
 =?utf-8?B?elBVTENFUk11Sy9DWStmQVN6Si9HR2FJdzNjbkxhbC9ITjhQRHNXUW90WFRi?=
 =?utf-8?B?SkZtMXc4Q3JydjNyWGhBWlRqWGlUVFE1Y2ZNSDRYcXd3VGNScU9oZGppeTVE?=
 =?utf-8?B?YWhDOHZMZnBibnRoengya3ZMNnRRYjV6RmYrTTFzU1NaRGQ1aEtnOE81djFh?=
 =?utf-8?B?bzBwWlY3dlkvYXZYQzZsV3RTb2F4VDJUWVZTbWlyb2ZRSXJJTjdzQW9JVDhP?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f27d7d4-3fdc-444d-16fd-08dde57bd8cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:10:24.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bogsrh1WF/Y/aUPVPEIA4uaZDl+ExGMjKwQZmErpEFE+U/I3QRcue6n4TW6+SdTZvROZqM/K4ZBVE08vSL5T3MU5mJOb+J2b2CG42kLIGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com

From: Jiawen Wu <jiawenwu@trustnetic.com>
Date: Wed, 27 Aug 2025 14:46:34 +0800

> Add ethtool ops for Rx flow hashing, query and set RSS indirection table
> and hash key. And support to configure L4 header fields with
> TCP/UDP/SCTP for flow hasing.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 152 ++++++++++++++++++
>  .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |   6 +
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
>  5 files changed, 182 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 9572b9f28e59..a0a46b1b4f9e 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -481,6 +481,158 @@ int wx_set_channels(struct net_device *dev,
>  }
>  EXPORT_SYMBOL(wx_set_channels);
>  
> +u32 wx_rss_indir_size(struct net_device *netdev)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +
> +	return wx_rss_indir_tbl_entries(wx);
> +}
> +EXPORT_SYMBOL(wx_rss_indir_size);
> +
> +u32 wx_get_rxfh_key_size(struct net_device *netdev)
> +{
> +	return WX_RSS_KEY_SIZE;
> +}
> +EXPORT_SYMBOL(wx_get_rxfh_key_size);
> +
> +static void wx_get_reta(struct wx *wx, u32 *indir)
> +{
> +	int i, reta_size = wx_rss_indir_tbl_entries(wx);

Nit: you can embed iterator declarations inside the corresponding loop
declarations.

	for (u32 i = 0; ...

> +	u16 rss_m = wx->ring_feature[RING_F_RSS].mask;
> +
> +	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		rss_m = wx->ring_feature[RING_F_RSS].indices - 1;
> +
> +	for (i = 0; i < reta_size; i++)
> +		indir[i] = wx->rss_indir_tbl[i] & rss_m;
> +}

[...]

> +	reta_entries = wx_rss_indir_tbl_entries(wx);
> +	/* Fill out the redirection table */
> +	if (rxfh->indir) {
> +		int max_queues = min_t(int, wx->num_rx_queues,
> +				       WX_RSS_INDIR_TBL_MAX);

I guess you can't have negative number of queues, why int?

> +
> +		/*Allow at least 2 queues w/ SR-IOV.*/
> +		if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags) &&
> +		    max_queues < 2)
> +			max_queues = 2;
> +
> +		/* Verify user input. */
> +		for (i = 0; i < reta_entries; i++)
> +			if (rxfh->indir[i] >= max_queues)
> +				return -EINVAL;
> +
> +		for (i = 0; i < reta_entries; i++)
> +			wx->rss_indir_tbl[i] = rxfh->indir[i];
> +
> +		wx_store_reta(wx);
> +	}
> +
> +	/* Fill out the rss hash key */
> +	if (rxfh->key) {
> +		memcpy(wx->rss_key, rxfh->key, WX_RSS_KEY_SIZE);
> +		wx_store_rsskey(wx);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(wx_set_rxfh);
> +
> +static const struct wx_rss_flow_map rss_flow_table[] = {
> +	{ TCP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_TCP},
> +	{ TCP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_TCP},
> +	{ UDP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_UDP},
> +	{ UDP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_UDP},
> +	{ SCTP_V4_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV4_SCTP},
> +	{ SCTP_V6_FLOW, RXH_L4_B_0_1 | RXH_L4_B_2_3, WX_RSS_FIELD_IPV6_SCTP},

If you start declarations with `{ ` (with a space), do the same at the
end of them:

`IPV4_TCP },`

Thanks,
Olek

