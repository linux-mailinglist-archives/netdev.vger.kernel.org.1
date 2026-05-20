Return-Path: <netdev+bounces-289799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMmHDvBfDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEB588C9A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688BD3011F06
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C49372B4B;
	Wed, 20 May 2026 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm6avNJi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDE2C029D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261155; cv=fail; b=iV0fR2Cc9uj806mhe74HWCAHKTcq2lw2u/d5ShihastRKmdVRpKYX418iY54kzm00SB5Cdk6t7UUH38KhMyCARkGtynK3KtFvdNP7oIba+xtvLlB6UaPPg760d7XLNuBeL+3i0I0MJFF/v5ZVKadzI/tMCK634/u9XLS4VSak5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261155; c=relaxed/simple;
	bh=jEBgO7m9JXQquvGwL/8WSktCNiNp4YQqReARCofFEeM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Typk2r+QXqzwuWH1v2ztSzRUEHvY12vmkjLWzQO1lPttnRusQasumKf9FdpvqlsdBm3zO/TzWa4Bn4aIsX/2DiOGwZcjEKOhXpz8lWEezRgMRAw/3OblFykXk8psgrjup/06QI9pQ/eOYVT12u/f18tOTpTanTeuexh6vxYvgQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm6avNJi; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261153; x=1810797153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jEBgO7m9JXQquvGwL/8WSktCNiNp4YQqReARCofFEeM=;
  b=bm6avNJioDTQbkKWsOnnx0JfPIOQ9YduJViwohLTMydooGoXMlvrCUyO
   74CXG0gGCQ7bgmRZoVHWYRNXdSbcMtGXcIJqlPQCDOG/nuaNGPL7VRmi8
   ClRzgmBJPD0zecOgVe+R9BeKn2GEsPq1D84l2i9DVTBEGYseQPWoTnvco
   RCdIZL2fHMqkxNhVb1SPl+Vqr9UEBzS3C+dF6Ujp7SmxWEkAUwaJwORWO
   9Ub/Pq009m7gwjkVO1TQHxX38nAh/ELpgpn9TuSapx+Qi/FDavJ4QXxSJ
   JQs0uMFAE3zNjpPXhTX57c3ZLn5hG4Qlp8Wkgl9A9js6D5aLiH3l5qKqI
   w==;
X-CSE-ConnectionGUID: uxsr9aSZRI6eYMBI56Qy/Q==
X-CSE-MsgGUID: /NHMn4cOT5uw7ozWWLoxTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80268331"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80268331"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:33 -0700
X-CSE-ConnectionGUID: HrOlSSokSBqUsHzGFy+YEg==
X-CSE-MsgGUID: DSiX2/tiSvqaHn4lKsbFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237071005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:12:32 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neJ5najBLDB4wlVNACHffKGIVgP5F0lVWdO0ae807eYAUiNnMvMStIuR36ECJDQeDKjGpQ9V6HOY70Ifwv9+9p2VpTBAGjafYKu+cVR12gCHqFzu8hIWjeIVgIFX+FDzYE/XdbBMjW5ephntLCpvYLQwsJgHM4zYoMhJcSkGLBoSGcZeDj7djRnGqKOky5iWcRYkIjZGpVHJwa56DXAAvSOdClWrWN1unLNrA8ueh+2CeW7yg29kmGUC5bHCelFgL4+INpaAKPBtAgElajgaDtfrXBP0IaiOb4fSjfyuTVcg132GVkmO/ehGfliM9hYd4m1sCN900bZvcWXbEqSZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIfz6orDe2POP7nHJEzyhrmQWLRflCOmFo+K67kTrFI=;
 b=S8D5YPXrFEU51IMfgYijaIcpEM0hYRbk5GsYNGW3iHGhjgylGrtquSQFhjL3sNcAeTM3wVBV2MVaR9MFZGjWOxbv/7AdHj2Zmbn/K3iqcOWNc2yqPq3+szpIfW7aJqudxGFsWQM1rybRJMlBmBSYoq+9+5kEWMHP5GG++DrqWzC1Z67hHFdR77f+XqjBUtqtOKuTElEhOjT/y6wrRV4zY8MuoXQHEI90jShTYKT+wle8yOr8iW6w2gvxALBGzNoRPvQS4PyH3IXEK/+yY69LOhEVp3O3H8PeB0NDUeGW7Dwhfu7yf9yGgr0zGtAvfdG9dtrtdS1YO7b/QnyJrTAHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Wed, 20 May 2026 07:12:29 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:12:29 +0000
Message-ID: <ec201038-9ee4-4d3e-90a0-5f25cbedf5b4@intel.com>
Date: Wed, 20 May 2026 12:42:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] drm/ras: Cancel and free message on get counter
 failure
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <maarten@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260514202839.1888688-1-raag.jadav@intel.com>
 <20260514202839.1888688-2-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260514202839.1888688-2-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0299.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::18) To IA0PR11MB7955.namprd11.prod.outlook.com
 (2603:10b6:208:3dd::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|MW3PR11MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: 564f556c-98b1-45f6-eed0-08deb63f26c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: qScAXPaj9ngfO8fN9nc/Md58bNmQwfzEM+XloPVIJQ8cigqUlB50CwNk+5yii0saZRz7gOUUA35L8XCjYpC1RhvRf2SOuIN6Ff01TZmpUhD/VAhhGAcmrZxaLPqxZCsPtgsO8+AmP6nRPXAjLfr8f4mx8TZvkLe6ooPJycLgDwjFNGhia8ILbEtYNDcWdkvn31zbPmbUrfPikDjDIaXlmQ/qhMKwjDKpJm17C2QeMHEYk2PgQ0iNKFwmlkyZX9khyLKlDcwEIZaCAUFlqxVb5014rLh7AH8BiIIx99s2swJprup+MnEvP60ORHuvPt9JaznYX3PAOdS8oYfycxpeOGTyrjSUegKMXY07JRrsSJOe2Yhz1XmD2i8082V/KJnUi9ygg06kCHXcFTeHz9jv7fMDMxjxXFZXN1CmUuQCaFYxo4nEraQ5UFy62qBU5Ytfi/UTigZ1KnXGtSUZDPsAbrrucbKWvCuvOAcMITHD79Gcf9rtQeAL9fRSZ7li+UEdrNAeGAAnzo3KcksWZGWMT13juv2W9Jl8BCR5txFhJZ0o3S3QQfR1Sajt6+C5EYPxZLeosCNzM8Vzwc0px4m/O/KzBasGZrtRIoujibUWesg2lO0xEu8sRenVKZJTBrPDUHcnQv2SMyo7ibFQg50hRoVIvO6WoAwibAKj/56ofD25RSQ+asRZqnBdkeH93Ydo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEREV2tRSHdPc0Jicyt1WkJjUlcxc1lTNmVqSnQyRStvK2c2MXVwaHE0U0pZ?=
 =?utf-8?B?ZkJHVDI4UEc4SVpudU5rZ1FVVjFQWTkyYVFwSDM0RG5Eb2ZjTDlRTUtmWmZq?=
 =?utf-8?B?MEFwVjdPeExTbVE1Uzlyb1FWeDJVY2twZkVmM1hVbU5aemNxMmVIeEx5MzN3?=
 =?utf-8?B?V1dmbUo3V29iUGFrSWhYUThhTkhKeEJxa3BUY2o3ZHhoVXRpY0cxRitiU2dB?=
 =?utf-8?B?ZURDV0gzN3cwR3dmRFVtQlZtU1gyRm04eVR0K1JsMHErUTdRYk96MjJYSkt6?=
 =?utf-8?B?TVlCbFZuNVlmNEg5bVR3QzlLbDV2MENRbDFQWmtMQ3ZUanlUN2taSGtleVVy?=
 =?utf-8?B?cE1SSSszKzAvdUIvV3E5QU5FQUhaci9VbnZ2YWVHMTkyMFRmR0lKVERZL0dH?=
 =?utf-8?B?NDFYSE9vcnVQcGNJU3hBcnArMlVEeFFZVEZ0Mi9yK2JVVVFsSmZtNEhkRlAx?=
 =?utf-8?B?MjRMcHVPWGxtN3VYd01SZUoxK1laQmpTM0wvTk5ySFV5QXdkMlFOS0U4MDJs?=
 =?utf-8?B?dE5Ja0J4ek5Qa1gzUnBleEFjWWdJM1V0RjJ6YnBEbW5SR1lHTC82SXBoc29u?=
 =?utf-8?B?Vjk4cWFhVDVHUnRhS1VYWTZLQTdwQ05YNTlUOXI1aCttemtQdW50eUk5UlAx?=
 =?utf-8?B?SHEvK0NEOTNVTlZETys5YWcxdjRVSjY0K1hGZzAvOHNhV092TXpNTHdoT1Rv?=
 =?utf-8?B?WVU0cmZyRXJxMmFXTzVBVmdReGFZQ0FIUjU1UUtoMk1JdGpxSXNWNXpCSFlz?=
 =?utf-8?B?TW5mUkZMTllBM3RvZjNxWlBoRVJ6QklhODRvdmVJSFQvVXJUay9uT25yOElj?=
 =?utf-8?B?b2lLY2dFdlZpZXBNTmpXVHBEQWg3U1I2VzBOQmFlS2svZGQvem50b01WK0lU?=
 =?utf-8?B?MjljeXdRa3luMDFkTGVseU9HWTBxZS9MSnN0RkExazVKRnNXNG1jaFBsa2dp?=
 =?utf-8?B?UWRncVVYMjlUcU50YjQzV3NPSVVmVllxMTZVQWFBSE5hWVFMU1FsVkd2QlU5?=
 =?utf-8?B?Y2h6ekpneVFBNkRsMnlzZms0TE5LWlJCYUVMS1Yrditzb2tseVBCVHNLZEh5?=
 =?utf-8?B?RGwzTVJ1STAxYW1aVHQ2RlVBeDVQRG5oSVlsV2JhNUFaaE9oVUp4TEtyK2oy?=
 =?utf-8?B?Uy95VWZoUTR5dnhjcEhUZU9ReFdSem1WVHU1U1pkejN2RDYvSnlKbWNkUkZa?=
 =?utf-8?B?Mk1oN0hNWTd4MGlKZzNQZmNKdUlLT3ZwQjZSTFlWOEx6WHBFZFFVMFdqL1BG?=
 =?utf-8?B?eExIK0p5WXVhUlpOQjJVc1BDYkJiY0VJUWVPclRBMm5zY3owYVJwbWdXMElS?=
 =?utf-8?B?UTVjR0JQWWVST05iVFNqckpOSmdtSjI4OXZPcjRMcS9xNXVsNE5qd1lOM3g0?=
 =?utf-8?B?ejlsRmNDZ2ZrclVpY0NhdzhEYzY4aHVuR2lKbDMwRE5oWWtBM1pTU0t5bGVi?=
 =?utf-8?B?TWRNbjZpcFA4WVBHY0dsYmlsbEt3U045Sm9iRWM1UzBVM3V6Ykd3MlNtUi9v?=
 =?utf-8?B?TEx0R1pyK0ZxdXBDeVI2MDZhd0Foc1JzWEZ6SWt3MmFWdytPYzBqdDV4eGVa?=
 =?utf-8?B?VDZ6b2kwM1E5WGRMVFUrWlpwZk14dk15ZGF6REdTM1d1MnBaUEtnZGZYQ2Qw?=
 =?utf-8?B?S0UwNVp2azVYRVR0RkRPeEplSTA4NUhpa3hGUTRaMWs1eWZXQjlEdUtRQy96?=
 =?utf-8?B?ODRmdVhzTUQ1emJ0RWpzMjRrMzh0NUtvRmp1TEg5VDJsYVZXVTBXYmxnc2ZZ?=
 =?utf-8?B?NDg2REdUUmtwelZqV1RNVG1zSVMzVlhBQitBN2RqT0tHQ0s0RDljaVkzc0Fz?=
 =?utf-8?B?MGdJNXU1S3NYSHVWd3V1eVFJTjJGSVA1UUlvak9nT2pFWTNvZVdRUlgyRHVT?=
 =?utf-8?B?L3FWTU9FZUJRczhjS25SUTdvVWsxR21jQkVUWTVvQjdzY3NSWXNlQzhVZk0w?=
 =?utf-8?B?ZGNEQTM4RVZQM1p1dmN5YWgvOFhLUloxV0J5KytwWGMxblVkYXhUaDVNaVJW?=
 =?utf-8?B?QmZBazRVTFhPZlo3YUI0N00ySGp0QWRKSzR5aEszU1VGTzAwQ2ZTTEZNNHRj?=
 =?utf-8?B?Nk1Va0xYT3BmbTJRWmdwM3pDUlMvckpOWk9oaFlFSXNFUEFBMWdlOEVVMDJU?=
 =?utf-8?B?cVZOVkRvWFhYc0w4R2pDcjBJWHUvakhZOS9QZzVFcUMxL0hEZzZnb0xTRTVp?=
 =?utf-8?B?MERDRUNmZ08yOUpaQ2VaelNKRlJxWTF2WFFtRmZFak5WQnlRbWQ0VGRFTmhr?=
 =?utf-8?B?WWJFOXlPNkl4dmdjVmR4ZkVRUmxSZlYxODNaNnU5WnlhTFhYTHFZNStLWHMz?=
 =?utf-8?B?S2tqdUYzbnV2d1h2RGF6MUhxQk1BSWZzYUpXdkhGY056MHk1dGtuQT09?=
X-Exchange-RoutingPolicyChecked: B08x8xfH44qx0d65Yz5YgXBa5zW3fxDfafy1FO8iq6w1RYsRLLr8JxCcfnO7H4uS60sV+F3LYiT62tE2oSiR9zVxqaoPc02CMO4zdbvJPRfKCcoNMZaosGbKsYSeaSE/UnD8VhQFiRY6rZ3j9EE5MNHra/J3Y0KancXPRjjpag2fHuXNutruNJNoXGiyio9PBs6g1p3Y8/magAODKnJgORih9ilKISwsR0JBLEoA7Dm8sjaSSYDgDXPHsKU2kGt9Gqpl6X6Il1EGCPOAgzcguwz9NG8kLmOGSbAIXsb20F1q1ji6xPqL094H4ltYC1IYaH6ymJjI/ZxNnofYVCbZHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 564f556c-98b1-45f6-eed0-08deb63f26c7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7955.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:12:29.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhEvXOyA5aQ2fXni5PoDTvr2M5vpqXu919CtNNloE9EWtsdOvN2RSqKOMUw5mY1qkPxeaGfNa93tUnpy9TRMtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	TAGGED_FROM(0.00)[bounces-289799-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 96BEB588C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/15/2026 1:58 AM, Raag Jadav wrote:
> doit_reply_value() directly returns on get counter failure, which results
> in stale sk_buff and genetlink header that aren't cleaned up. Fix it.
>
> Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>   drivers/gpu/drm/drm_ras.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index d6eab29a1394..262a75f0c493 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -207,8 +207,11 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   
>   	ret = get_node_error_counter(node_id, error_id,
>   				     &error_name, &value);
> -	if (ret)
> +	if (ret) {
> +		genlmsg_cancel(msg, hdr);
> +		nlmsg_free(msg);

Use goto here. Its cleaner since it's used in multiple places

Thanks
Riana

>   		return ret;
> +	}
>   
>   	ret = msg_reply_value(msg, error_id, error_name, value);
>   	if (ret) {

