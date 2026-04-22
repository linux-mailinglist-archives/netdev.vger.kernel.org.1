Return-Path: <netdev+bounces-280316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKeEIpRh6GlaJwIAu9opvQ
	(envelope-from <netdev+bounces-280316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED54422A9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 102A03038D31
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C555F26ED25;
	Wed, 22 Apr 2026 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwyG+Fvu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2492C15BB
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837000; cv=fail; b=QH9R2loe70u/A+VdzJhppenGSuEmb7FlD7kYJt1ZoFZCJH5vZGHNHXy8MA2+p49FxIPoGFXJjTul+r5pyQpVS8t2gE9v/asqua/CPyuwBM3isxdIrfuGCUbqT50vgUtoDloZ3XI4JEvuGM33Dgi97SJ2c8Si+lq7ac70tBxSIis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837000; c=relaxed/simple;
	bh=q7T+rXnEIcxge9iDmSfZfVnt0apuOZPjEb1PfwjnCLc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4ALRMANBLH06nddZesgeTqII/AC+wNU8hCpV9wamxhNZh2wDTtLFe7iWlfpd0soHdOkGYEev2GJFv1fWpz+Lq1gEfvIXbGVjRNrm8ueMwuSdrvH5Ph/sStABw4dyI/4yFq754N9ObeHYIDY4ZJyegVGZXKYuZ5dGhp6GbsT06M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwyG+Fvu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776836999; x=1808372999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q7T+rXnEIcxge9iDmSfZfVnt0apuOZPjEb1PfwjnCLc=;
  b=iwyG+Fvuphn9c1uTwwwQQImHeLwi+X2Da8iNab6xtJnyP7BZ/MlwiI6c
   X1hIKpRw0Yzkk24jn0V/VD7Dys3YEvywPH1xV1VDswywVPGgea2pE0roq
   GoDWZy+c+/zuqYWvo6u9eMEiZKeV0ULO79MEDUl0uigkXFcaWLs/9AnqY
   VY7vkwEeFr/QejeEbo9zJucLGOyanBDXThyrz5E03mSfxlZKNtV40qwZw
   +icMhsJ9HGjdbXtZ+6O7LJVIHnTTFQq6y55UIWTwReNBIRaEuV0vLRVUD
   Geqwp1oX1fm2davwpaLotfiw3KB0Bhry7vF69OZ26lc3h9EDhGzlgPf9w
   w==;
X-CSE-ConnectionGUID: IO+F9ySgQ1q8/yeaqefUqg==
X-CSE-MsgGUID: heZ/lxWFQe2n8QSyBfkkYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81649792"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81649792"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 22:49:58 -0700
X-CSE-ConnectionGUID: YWRz3W1SSeaqEZsznexwxg==
X-CSE-MsgGUID: wwqcxuaOSwCrTWuGKSb9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="255743024"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 22:49:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 22:49:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 22:49:56 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 22:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIhQNsrVDO9D78uPEAY/kwJhLK0MlrzjzTNo/mR7TzFTqi4vUYfzCc5bKxAVBXixKBbgSlDXLuHlUU5KaXziIxFMOAjKzmJTt8nUCihyLargrY1GFghyvcqOPbRXjedEDK6In2qmD6LzCpLSVYD36rsSsNygSt6CjY4PqfwfLr4yvIrewB9mYZfr92+nQg1Vy27feIJpHfL/M+ysTWPEPtyQ7mm72bBzDd6pUAppI7Nl2YPzWZGTKAc8gL0ecmX6GnWqU85kvpOw26HswXaMooS0voWxWrLMnc38efe+TP7WUuFClyvmf7A2z2jT8Pg0tvwWHGQ/IX/YcOvB3XwfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDJr2QK+1i4FFoju5N8xniC8bo5lNNKe5pKYD7NKecs=;
 b=IalUuZn5bWiZirsr4Xg4CnEeVqMfOqAuKY1GJJp4XHnZAWxIs8rVMLvweMAmAsbh4b2CWN2RF/qmK0kEC/sGI/nnJMDUsRn9usUhHdtuygqqHcnCZieNPuLqNbPwZvsW0xLMT7+sPGn8x50J4+N8JguU8/OdneaB8dGrHJ4WClpHN8sm2i/17s0T4vpLBTBPnR94tQXOaSEOQcMjhcAmZ9tZ62KqH8PI+2/qesItEqa1LhS08ZuWBwTDlk7F/xWLDN9UGoh3WtmfOB5W6qXzooBlinYSheXBaD32xKO1iB6F/2ExmDv7bASsweJUVD7Mu8BtlSuLu3PTnRPXv/boBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.15; Wed, 22 Apr 2026 05:49:48 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 05:49:48 +0000
Message-ID: <0c855393-be55-497d-aabe-fbe72e37321f@intel.com>
Date: Wed, 22 Apr 2026 11:19:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] drm/ras: Introduce get-error-threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<soham.purkait@intel.com>, <anoop.c.vijay@intel.com>,
	<aravind.iddamsetty@linux.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-3-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260417211730.837345-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::16) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e6b19a-379c-457e-db74-08dea032f6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 50gLIajWTpZKy3LSHv0Eo3jt5rCP1Wd7LgZVB26+NoIMlvboVlO4odnzpfyfaiGENE9mMV3HypqGQ34AR53eLeskKs63ap86wKiKCcrIKRREWyn6LXPbvGaRNMCs9vUjhBjTQ87Kx1QU29fn0H7dPbK+b7P3lCvFWMC8l8flFxp1SNA2lbvL+lutD7EVczvF9oYIzOEtur6d224LCMSdKqZtVYYFwtNnYuaumFCmP7Tv3bxq86Igo8OTDxnStAXHZCphwzX2kldljVN2JJgkyfWugtDlOKxqEP0qyneR0UnvbFytM0Npk9zS4niAf1U/QiKB7ZIKA87TBZsMkuM1lofQlq84IW4tYS8hMXIDRSRQH2zjAO3JXVHPoSJTYKHoTiyPkjffg0R1uz1zI0vqVpRn18NMq/yJsl+eRva2ou3x6paj6Wu5T9/AikzO4ZUooaKmEYnri/4GkNUPZQlV0CPJ/9NcSUjjwECteM5LvwZqyEzhfo8yk3hwq9JmjCgU4Vs2bt5uLnWODn36ZrNgzSdRupqz4iqLfHkrf3K4LHOJMnzIldz9w0fll0Me3ll/D8Mkd+rQf6+5g9Q8O3BLSyrgrF0RZVdS6TaP7rVQNP2lQj0HkMji6xzPVTXaBu07V2k6t+LhUCXh4TQmpoHl+ddj1aqOBGNpYp8m7t60lbR4D/GigCe449iRr01JZN6p3YWji7KpJ349GoO9yOFv7DGGms6IMQ0s2+JWBaowQOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZGWFNCNjZjTWdDMitFY2t0MHlOaUNnRUJFUldhbVZLZmFZRHMvUHhPQmha?=
 =?utf-8?B?TDhIYlVqS21JeXVkYXZ6ZnRNUGFBWmRUbGUyUUpVUzl3RHpocG1qeVNuN1U0?=
 =?utf-8?B?S3ZzSEJncnFYWUJLeGNHMDZDY1JyRFE5eFRhYkloR1d3dnk5d0d6alhOcEph?=
 =?utf-8?B?TVRwMDAwQUVvSlNjMXBSVDkvYU8xUDhOSjFTZkp0MkdqSzY0SU1HVUJFQzcy?=
 =?utf-8?B?NWorb3RSSFQxSkEvR2M3cDhqOC9uSU9lRzlrVXJPS2ptNXlzTU5tTEx1MWpL?=
 =?utf-8?B?bUlSQXM5YjlnbHpuV25naFQ4NFBmdzR3YlZ0OFFLeEFLSTBWS2cxc1pDVHl1?=
 =?utf-8?B?VjU0RHh4K1h0N1hSd0hQYjlIOU1BY3gzanZVYmFXTVRtTDduUVBCSDRtcTM2?=
 =?utf-8?B?V0ozWDVBNkZla0ZJeXF3Y3RXd0RUanZ5VEtaTS9IWkxxSTBmZ2oxS2Y1OTBk?=
 =?utf-8?B?ci93ZkpPTGJPZURQc3RmTnNENzY4QkxuVUpoVlJwU0d0eWs4WHZEc3pNQUpG?=
 =?utf-8?B?RU9yZVZYdEM0UUpTaGFOU2hpSFR5enV6TVQrOWx6OTl1akFWY1NWODRwd1Zo?=
 =?utf-8?B?dkVQbDdKSXpOZVhjSmtWTXNUdExBMnhMRnl5c20zS29KUnYxZS9XSzAyMHVD?=
 =?utf-8?B?aDVDa003SDdaZnVVWHFHb2dMQWIwSmQyUVJ0MEdaS3czaXhGT1kvUzhyNlhG?=
 =?utf-8?B?UWtnT3JoQjVIU1hvVm5xTkh5Sk1QTFVVaWVHbkRSb3JoUm5nU3F2LzlZRkxP?=
 =?utf-8?B?K2hGOWM1RXRNa2VYUzNjSElRWUZCUTFtcDJxVE9zREorMWRtb245aGx1Z3JW?=
 =?utf-8?B?enkrUVRvekhDYlZWRHNVbkhqZ0VJcEc4RWQxNUhIZnRBNlhwS0swWTVHbjNU?=
 =?utf-8?B?QmRtMXNhOStGeUtRRHFONmVObkhjRE10VnprSFV2b0U4ZGk5cWRibUhrdkdr?=
 =?utf-8?B?ME5JV1RBbW1IL0xoZTlyYkwxcW1Gc0I5RmV3QVRnL2dNOFJLMnlYK20wTzNn?=
 =?utf-8?B?VXJUTDNIQ2JSYlJ4eVNtS1I1emFLd0pyL1V2UjV3Q3RlK1ZaNVF3YUdMa1Y2?=
 =?utf-8?B?MHlrQ2V3a2xCRVV2MVJVWlBwVlZLYVZCZkxleDNDL0R3YWszVHVXeXpXQ2VU?=
 =?utf-8?B?UGMvYkUraTZSUElCNDVwU0tNM3BMM0pYOFlFWVlYdlp4aDBZRHczRFZxMGc4?=
 =?utf-8?B?aWp5cXgyUkJQemhGN21tZUZ4VnY1R054cEFheGZ6clZzbHBUOEN1UGpFZHpG?=
 =?utf-8?B?WDZxTGdZUkZ0Z2h2a1ZtZysxYzE2dU84K1lFeURhMGs0MEorYlBMUXMwZXNC?=
 =?utf-8?B?aEUwTWlnTjRMWG14K3RSaDhpTUJHajFXVnYyNDN5Sy9KeGNPVlYvcThsVDQy?=
 =?utf-8?B?NnNKTytXeWpIeWh6czVZU1l3blBHdzcybFFRaytVK3AzQWh5cExYcUFibVdF?=
 =?utf-8?B?TDZ5OUE4STFVMGYrRXVUTVBLL0FibzFlUGFyY3g4SjgzaThacC9vd0pXeUVS?=
 =?utf-8?B?Nk45MU91azFrbkVTMm15anFTK3BvM1pDYUhvclg5eXZaUlhqMjk0Sko3enZN?=
 =?utf-8?B?OVV1V09UUUM4VHIrUkh4MURkTndlaFBWZVgrdnp5dGw0TU5yRXh5TjN4eFFE?=
 =?utf-8?B?NDNVWE15SDhIQkZZYjgreG9OdDRkWGYzQ2VjR0RpMDFjMENMZzdmZzcyNTF5?=
 =?utf-8?B?Y1k1amRZS3UzTnlua0lJZ2hMSDBNZElIcG1HM0l5b2crTVBHM1ZVOGZwZUJJ?=
 =?utf-8?B?UFIwT0xHSFM4Ykhqc2lkTUEvVy9jVXA2dEdZckxoYUFMNCtVeG9wSDdtL0th?=
 =?utf-8?B?RHV6ekRVL01kcTdkM3pQclhndVEwUVdkeW10MjQveXN0S1JPNnZ3T3RSRkNu?=
 =?utf-8?B?a1MxMDlwb21VZWxuWGNINFdtblZqbGpvb3dIRVVjT3dmTitEQTd5dXBoM3lP?=
 =?utf-8?B?TEx0cjJRUWJmdmFSZGJqUkViTE0wMzUrWmJGUWdmTkZwaVJYamFwWk5EOUd5?=
 =?utf-8?B?UUQ4VFdoVld4SXVMOHRRb2FXNEFCdjF0YW5id3lDR1NTcGJYUklTMHYrMC9t?=
 =?utf-8?B?dGZJMU5BdUY1b2tQS0VxZFRoSjZDQmJLRDJSNXRGZHdERGxmSXNSZnIrV2pl?=
 =?utf-8?B?YUt5emdlOUYzS2Z2VmVtd1RqMkIxcjJOdGRFNS83TGhiaGpMa2hzSGtBT1Iw?=
 =?utf-8?B?M0ZUckNVK3VWYTRwb1F4LzNna0JZMFF2M3NPNlpIV2poY1lJbGE3Vk8rUXNM?=
 =?utf-8?B?N0VNRUtDaS9KTXp0dXA5U1dpQS96SXRzMkpjNGs2QTg0aEhjcVZIT2pWNFR4?=
 =?utf-8?B?THdPMWdteWxVckltcExFQ1V5eVdndzhvNWtJcnNDV1BlRWVibVhDUT09?=
X-Exchange-RoutingPolicyChecked: QL9jdCNuWf7vt6KcomOXCLUihcm8Vf7mTX9YhUGW4ZvVAIXM1xkOyYSHd/VqNjmkNEh/YGjgzd0tgIbFzwycSM9Z7h17qZwiiYzT+fSPxnnhYiOd+16THe/et+bLAjDhdtMSVDITcjK1AB4UNXDfguWzWMizlm2XWrIXdvyW5dvnNPjz5PSHTS2M4hofDdxs77CBLcguHYUXeIHHLhV4Wbszpdf0HAlxAoPKG3MrvuqmBICKbqPg3Dipjq9Yp0+IxyraQwG9VTUASVGB6nxYzzkUJDJB8qwGeyDnfVdOwcRJEMzee7qBSUTKcslOr76+SOOMAc2yQy1ZdzqyH5S0zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e6b19a-379c-457e-db74-08dea032f6a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:49:48.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/ykjxXFn/PyFIVZ0vjOmg1ntGazqmoTQeWq3e1r8v+hTk/b9qfq1hCcph2LEVZ7pByAWRrtc9tvkanmNJDBoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
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
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-280316-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: F2ED54422A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/18/2026 2:46 AM, Raag Jadav wrote:
> Add get-error-threshold command support which allows querying threshold
> value of the error. Threshold in RAS context means the number of errors
> the hardware is expected to accumulate before it raises them to software.
> This is to have a fine grained control over error notifications that are
> raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   Documentation/gpu/drm-ras.rst            |   8 ++
>   Documentation/netlink/specs/drm_ras.yaml |  37 ++++++++
>   drivers/gpu/drm/drm_ras.c                | 103 +++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |  13 +++
>   drivers/gpu/drm/drm_ras_nl.h             |   2 +
>   include/drm/drm_ras.h                    |  14 +++
>   include/uapi/drm/drm_ras.h               |  11 +++
>   7 files changed, 188 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 70b246a78fc8..6443dfd1677f 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -52,6 +52,8 @@ User space tools can:
>     as a parameter.
>   * Query specific error counter values with the ``get-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Query specific error threshold value with the ``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
Also define what is a thresold. How can it be used?
>   
>   YAML-based Interface
>   --------------------
> @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
>       sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
>       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
>   
> +Example: Query threshold value of a given error
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 0}
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index 79af25dac3c5..95a939fb987d 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,25 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +  -
> +    name: error-threshold-attrs
> +    attributes:
> +      -
> +        name: node-id
> +        type: u32
> +        doc: Node ID targeted by this operation.
> +      -
> +        name: error-id
> +        type: u32
> +        doc: Unique identifier for a specific error within the node.
> +      -
> +        name: error-name
> +        type: string
> +        doc: Name of the error.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Threshold value of the error.
>   
>   operations:
>     list:
> @@ -113,3 +132,21 @@ operations:
>               - node-id
>           reply:
>             attributes: *errorinfo
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve threshold value of the error.
> +           The response includes the id, the name, and current threshold
> +           value of the error.
> +      attribute-set: error-threshold-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 1f7435d60f11..d2d853d5d69c 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -37,6 +37,10 @@
>    *    Returns all counters of a node if only Node ID is provided or specific
>    *    error counters.
>    *
> + * 3. GET_ERROR_THRESHOLD: Query threshold value of the error.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the threshold value of a specific error.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -66,6 +70,8 @@
>    *   operation, fetching all counters from a specific node.
>    * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
>    *   operation, fetching a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> + *   operation, fetching the threshold value of a specific error.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -162,6 +168,22 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>   	return node->query_error_counter(node, error_id, name, value);
>   }
>   
> +static int get_node_error_threshold(u32 node_id, u32 error_id,
> +				    const char **name, u32 *value)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node || !node->query_error_threshold)
> +		return -ENOENT;

For the absence of the function, return -EOPNOTSUPP

> +
> +	if (error_id < node->error_counter_range.first ||
> +	    error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, value);
> +}
> +
>   static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   				   const char *error_name, u32 value)
>   {
> @@ -180,6 +202,24 @@ static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_reply_threshold_value(struct sk_buff *msg, u32 error_id,
> +				     const char *error_name, u32 value)
> +{
> +	int ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
> +			     error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
> +			   value);
> +}
> +
>   static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
>   				    u32 error_id)
>   {
> @@ -216,6 +256,42 @@ static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
>   	return genlmsg_reply(msg, info);
>   }
>   
> +static int doit_reply_threshold_value(struct genl_info *info, u32 node_id,
> +				      u32 error_id)
> +{
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	const char *error_name;
> +	u32 value;
> +	int ret;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -EMSGSIZE;
> +	}
> +
> +	ret = get_node_error_threshold(node_id, error_id,
> +				       &error_name, &value);
> +	if (ret)
> +		return ret;

You have to cancel and free genlmsg here.
Looks like the counter patch also has the same issue. Will send out a fix.

> +
> +	ret = msg_reply_threshold_value(msg, error_id, error_name, value);
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);
> +		return ret;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +}
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> @@ -314,6 +390,33 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>   	return doit_reply_counter_value(info, node_id, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query threshold value of the error
Nit: an

Thanks
Riana
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the node ID and error ID from the netlink attributes and
> + * retrieves the current threshold of the corresponding error. Sends the
> + * result back to the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +				      struct genl_info *info)
> +{
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold_value(info, node_id, error_id);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index 16803d0c4a44..48e231734f4d 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_get_error_threshold_doit,
> +		.policy		= drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index 06ccd9342773..540fe22e2312 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
>   				      struct genl_info *info);
>   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index 5d50209e51db..50cee70bd065 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -57,6 +57,20 @@ struct drm_ras_node {
>   	 */
>   	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
>   				   const char **name, u32 *val);
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query threshold value of a
> +	 * specific error.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
> +				     const char **name, u32 *val);
>   
>   	/** @priv: Driver private data */
>   	void *priv;
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 5f40fa5b869d..49c5ca497d73 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -38,9 +38,20 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
>   };
>   
> +enum {
> +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID = 1,
> +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
> +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
> +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
> +
> +	__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX,
> +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX = (__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX - 1)
> +};
> +
>   enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

