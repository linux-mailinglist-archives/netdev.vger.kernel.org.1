Return-Path: <netdev+bounces-280539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AwTFc8a6Wm7UQIAu9opvQ
	(envelope-from <netdev+bounces-280539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3756449FAC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A73301779B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897B3EF674;
	Wed, 22 Apr 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAQxB+Rn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145F3EFD0D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884391; cv=fail; b=poUodI0+AaFyIEEv1wMUmiRzX6eZ7H22gGfu5Qm5qCj3Wsn25DYkJW9n72TyfEB0gUIibBmnOSXdXR2LHfr/52uBmK7HnCDmMZfs3snLGiuWi1bZ0TJRPwxWEIa7KtLCbwAJrla8FVj37kfeRNSGM1YGcQkwohkvR89ifiyj5EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884391; c=relaxed/simple;
	bh=Sct9RCxFTobfDSMIG0PFzDAO3Ysd+KoLFY4lWEVzvV4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=crvtr/g5zWwfQKMi+fMzfRWNUhTNOXdVAl0WVgQlPPJze2pXrLn9Q/YX2ULb1gfU+lVAJDy0OzrgFBGe3ehvLQd9sNTn29LV9dGFJaNRUDmQfbSfXXZCfOYF28EB717T9oneVCicm8zgOXrSHbrd+6WvQFJ6xWz8hkWcbtW0XPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAQxB+Rn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776884382; x=1808420382;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sct9RCxFTobfDSMIG0PFzDAO3Ysd+KoLFY4lWEVzvV4=;
  b=IAQxB+Rnw0myIvuy1SWZNI1QOs+0VOuNohQTp+PDRe+xQXtSHKzmk+7G
   Ulv4eWyb/JOlp8V3mUG0RE9V7OWPigDDIM1WoS+UjEieBqKvabTNZsxVV
   VRXE3vmxdFchC5zIjqhqQNwbS6Oo+N6wgTYS7774HcPL5iFQoYDvnE+HE
   kH0ZDSv7RdzdZF88HAsyHRkQ6lN5Qcv6Uqq58Wrp4FJimD1ZVW5DxFI2P
   ob6kjekOL7/2A2fVd3nrw1LgdzdNcR9zdGREPqNFS0ZvkrSlHsBg8jrxR
   WhA39tJLQoGRCYvYZ/KS6uTdczpB2ADOwstMpps9KrQU8jLOjv55kFz6/
   w==;
X-CSE-ConnectionGUID: q3N1nnDCQnau/r7oEeHf7A==
X-CSE-MsgGUID: JX7gskPETjS255Ny2m1O+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81710417"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="81710417"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 11:59:37 -0700
X-CSE-ConnectionGUID: ztg35lqpSq+c3yDrzafA/g==
X-CSE-MsgGUID: QNQ14Eu6TI2MtjBInsy2Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="227858198"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 11:59:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 11:59:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 11:59:35 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.68)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 11:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcFtFeZH1YZWjHshxy/dYpzDSfDNfYia7xzaVxQYeBya1Z6M2hGRYb0kL8/gB1gs2x6PFBN3jfUzUz4pUMSvm03uA7HLcTFQ2pvS/Qp5DFET12/qmgTHshGcy5ks2E2f6v0sWRwVhyaRBc9+uNb0S+jZZCJU4+EXNBsyFEq9wFzChw2P1M9/g/5tAzkEXQmbvFa7MKR/NM+42VW5Uv2F5/20AqMAEO25DxlaBf5hydBv5x4TX/jfm+RBe57n2oVWrbdOL3Y73weKyepDHgcveAsJrPsCEfL87JnENl5SQDR61+Wg3NMTpYvz7Py6izjaRchnQmGHMnhrnCgFANh21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1tnk/IAFfY8JAuvUU566OZ0P6vNXGUfYraDfx1N3vI=;
 b=ihDAuYG4U11gsFuzq9anLQlJarSgxAzm0+VprP2CYwqglRHXNziP2sBg29du5EXLpX+ChVOiUi6ie3/sTHP/91Zm6V1Uf84hnE7izki23gH1PjcUE5KbIFrJmdXDV7ij5GCiwgkZpf7qDFRuaiqnWA8iXqPWjIa7HhFAwQMrweyfbDjYn6z1kE/lhHn7IaB4rlyRNWY4lF0LUSahy07096vlgS3JhSBOiMM93e0SyEA3922U7CuXNtVVqYrD0O2lFDy6jNaw+fSH0bSsDy45YIOBt7aBDGJnQp8aYAhaWN5WngOj5FlTxop7cv2UNZa0nuPk87Y5UIsOYFNNvtvC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 18:59:28 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 18:59:28 +0000
Message-ID: <f31b09c2-efe6-4e6a-8dac-19a796a7d8a4@intel.com>
Date: Wed, 22 Apr 2026 11:59:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] Intel Wired LAN Driver Updates 2026-04-20 (ice)
To: Simon Horman <horms@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Petr Oros <poros@redhat.com>, Sunitha Mekala
	<sunithax.d.mekala@intel.com>, Timothy Miskell <timothy.miskell@intel.com>
References: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
 <20260422092304.GJ651125@horms.kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260422092304.GJ651125@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:303:2a::25) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6e3126-2667-44de-0db6-08dea0a1471d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info: wHR1Q2fQKaQ+PcKyx49CaCfw0bJwUN1Z/+G9pYLTQbqbcZnxbar1SiWdoLq+y0FlFK2rfd1ATC01NLWQl9uy4blw3LzsJZPrThSiS+MYuXsFnIl7NoArBYh04VV9OaRxb2ZvhtjFS6ztJ8ha8ykecQZ6ACqZ2D0xzAj7AJgdDCDpZi+vIN1DGlbtO4lZzX2e/TMzBu+nHMWkQTvQ+Sggnl0JZVk7KHrV2oQKk605oPIbWlXyio8C9DA5w32eI9egtZWmtDn3sYy9qx07STLjB9pJRa8iXjmOg7Ytq8IS55rF1LTFUCxNJwjtM7LKyP6JLZmBvrHaf/RBkaKsyf10DocdFlMOwgkqHGjdRDKknGNBcPU2XhyHrVvFj5iow7fThygexwuNShUOYEGRqf3hvN4sBILq/eniY3pWE1sqJZgOEdIMMFr6aToZYcgswMswYlvFqA7be6fe5v0SqexuV/VSyQuNNtoiuKn0upz+rZ9OkdiGjEM5RUzjMpayk0IQ08HdCkGVEztK0gR6U0fue8fcorSJbPpkAG+2tu1M0qIarksxNV1Hn2++nH4wZtcqQxo11S9XQHfO56vkZbtsOrXzQRIrEN0UN0kLFxY0seoRLlwgAfxzXhKyF/GEfYzvjoQMgcae5PFaWTFJmYOqWiW/oaJvpwQboChp5IitI5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmQwRnR4SWdmU0hJRFhHMytGaWdsMFBSMlV2c1pFcy9Ua0lVdWluV0dxMzg1?=
 =?utf-8?B?dVArRWxjY2FQTEFaQmZvYlhTdjdBR1hKb1lDc3BjRjMzRzNGYlNpT3hPOEFO?=
 =?utf-8?B?SHNzZ0FtUFpOMTdtT2M4U21sSWhkdm5MSWc3ZXA2NHNBN0hnZEZncWJRdDVP?=
 =?utf-8?B?V3RIQnE4aU9FSHB4U2FVNk1JN3VQZndvbWlKaE54bFArVVZOZCtoSnVVc3lG?=
 =?utf-8?B?UUorZ3YyeEJiRVhLay84RHpOaklEcG5qakd3ZFphVXFtU3JDUElocExMSzNz?=
 =?utf-8?B?SnV2b1ZrMVpPdHVlcGV3VVdTVEN5MVI1V3p2bTZqcWNoVzhqa1NnanR2Z2hw?=
 =?utf-8?B?cHNrLzU4RWYzM1hGUUZyZkVISGo4RWt3VUd5MzMwS3NvSXNCRW1NUU85aHhF?=
 =?utf-8?B?MitiNHMycEVTR2wrNG03UmQzUFV5WGFHU3NOQnFRR0w4NGRzUjY0M2xUVjlQ?=
 =?utf-8?B?MmFsNThMSFNjcEF0R0ZsSmZBUzZteVdXaXhjT0ppUGFHdEhkclo3OTVjRTBT?=
 =?utf-8?B?c1ZkSXI3eis0Q2lYeTBoamkybkdpVGpDMHkrckZlR1A5Q2NaUDk3UGQ4eDFv?=
 =?utf-8?B?MDlZSHZ4QjNQNEdnWlMzNk1idXBDdWVlamw3L3JyYy9Nb3o4WEpoNkQ4eXhM?=
 =?utf-8?B?OEx0TDJOT1hYTjlLZXRMYnhqV3NmMVlqWW5ZcXFNN1haQTRkSEorRXQ4ajdx?=
 =?utf-8?B?SlRnQkZUT2ZnWmpNY2c0NkkrSldpTEowNmsrVmFGSEp6TzY4aEhCZnk5VXNr?=
 =?utf-8?B?UEFHVDNZNzc0QUN3WTA2K0kvbkw2UCtVOTk0K1BqQ1BISnpvemxaQUIwM0Mw?=
 =?utf-8?B?NjNXeWVrcXVQVTJIQVl6enRjT2I5Q1Y4eHBZUnRMdVBwM25SNFdCNGhWMDhv?=
 =?utf-8?B?Z2xTc0p6enFOdkpEU3JCc0thUTlvSUgzR2lQRUxUT2dXbzhuQ3pXcWQrL3JK?=
 =?utf-8?B?dWdReFRiTkxsdEtlU1NlamYwWmZ4U1NVWDJadTh5cDJGKzFrNEtWclZyR0hC?=
 =?utf-8?B?VnZRVE9TN3lOZzZ3dHNnQTBGOUpobXVjU1JXd0x6NGMxWjZpQkR3MVZ2RHlq?=
 =?utf-8?B?UEhKRnJpcTNNTENMR05ZenZveWV1Z3BDSVpMSHhPZ1VGeitzZ2N4UnFUalZu?=
 =?utf-8?B?L1dtamtuLzFxcGpCWnRTTmVsekNWSmt5Z1BNWllPQW9jUkJlQ3hORjQyak92?=
 =?utf-8?B?UzVJYVlsUjN1bnpzQWR5R3FMcmNuL05lTlp6Mno0QkF0ZHhRKzRzTG44dmFZ?=
 =?utf-8?B?cURnZFFoN3hpZDdna2FYT1J1Vnl2NDZRcDJRTnJRM1VVK2s3bldYb3FGTzhr?=
 =?utf-8?B?WFpRTHk4QWlYOHVucWxKcmRRQ01IdDVYMHo5ZmJYRkdmcFYwZFRsNFZTVHlz?=
 =?utf-8?B?VFZNODVtakY5RjI4SDZFd3Jyb0xaSE5pVGhYdlBPblMvaGhWRkV6RG9JNi9L?=
 =?utf-8?B?YS9YenRjQWlHbEtZRDd5YVc1dDRUS2Y2NWRpY3VhR21hNDFPSForUU5VUTM4?=
 =?utf-8?B?ZmtNaC82K2o3UWk3aUhkREVRdmlia0FHZEh1SXhxZnNWZ1Z2Qkk1MGdPaXY0?=
 =?utf-8?B?eEkwdW5QK2lMM1NkdFdkMVRoZG5ESTRYeGFOcnk4aGxqM2JwUGZBTTgwUUxm?=
 =?utf-8?B?YWY0eXEyNys5ZmJpejcyZlNMV3VwWTJlcjJRekRFZ3VCSUNCRStYcjQwMUp1?=
 =?utf-8?B?bE8xZklTVE5ZdlV4MkVvdyt1dW9seU16NkhHb3c2bVQxTS9GMDFSZXA3MkZD?=
 =?utf-8?B?c2RqS0dOQTNnYzU1cGlRTzc2OW5iOGNydkROZWs4NVcxL3ZCaXBTdFZ5MTM2?=
 =?utf-8?B?L1RWNkp5WVR4N2RQNWZxNCtwSkk0VlJqR3F3N004RWEvWUkyNVY4NDZzK0xZ?=
 =?utf-8?B?RFRQQXZXK3cvdHF3Q2pEZGNVMlNKYnFsWUkyWnZOMnlFQ2Z1TmlxWGR6TC9Z?=
 =?utf-8?B?WEFuTFZJTDVsYXNZdEIvaUZ6ekFXUll3MzRiSVZjY1N5LytnalJkTE5HWUsr?=
 =?utf-8?B?Q1RyZXFvT2k4QzFCcThZdVR6dnNBVDMwZ1BXekZ5MWpteEhqcVBDK2tVRGwy?=
 =?utf-8?B?QUxxenR1Z0dBZ3hhRk1NM2Uwckt0LzNxK2EyL0VHR1djaDA3aXl2VzJzUHR0?=
 =?utf-8?B?YlZwMTRNRVJORnpydXpCNUVqWkV5d2ZzWDFQUWtlU0xTQW9tTmM4YVR0TFBM?=
 =?utf-8?B?RE5ab0IvWlhkaStjb1ExYmpKNndYQWQvNWdJY3pOcTVXdW9WRHAxcm51WVVq?=
 =?utf-8?B?Um9tOGVrOTd3NVpvRUd4S2c0STBiSU1TVjJ4V01hUTZGNlpCcWxSaVliMHpC?=
 =?utf-8?B?NFBJRGdYK2ZmejdQbHBwV1VWNVFYZG1tMFF2TGNvVWIza2lMQzBVWk12bnFj?=
 =?utf-8?Q?aGVJMPCp/2NlgSJg=3D?=
X-Exchange-RoutingPolicyChecked: OxvhfXrZ69DKiBjcvUwNmkfnSoZVh/gJTfg9cH0NdLI4mOs6A3BUt4Oy4Ji5QgyrgFHdRv/Toeru7OJe9WG29ORbRrXVhnEX/6+IumcmR2ktAs5MnUb/EWrmxWNR6wI3r6gCetTl0kMGw3EPkc6m8vgoQbShXoAGhf7Y8+lXTKd9V9RvDeqQzSAihp2qYfOpoww6Jkz0r2cOMUzw2Auv2pajd/pjiZcQUBuz3G0kYx+i6oGtMnSbwZy9sAY5mqeBDijtF6U7p4ISuYGZYwTUZiLNE42QAvAd3q98QkIBVnffa9u7Kaf5O8xEoCdl491gkk2aS+NiMGYbt/Ch1k8pxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6e3126-2667-44de-0db6-08dea0a1471d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 18:59:28.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgsMB4AfbUDrUu00DpRHJTv+E9kaU8VxRBEu/uqra0VKpy85fPFsX+uyBzbG6JxActATgAwIT9vJQcC0iDcUL7RzYMSmKvSuK+KsriHWYX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-280539-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,intel.com:dkim,intel.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B3756449FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/2026 2:23 AM, Simon Horman wrote:
> On Mon, Apr 20, 2026 at 05:51:24PM -0700, Jacob Keller wrote:
>> Since this is a set of related fixes for just the ice driver, Jake provides
>> the following description for the series:
> 
> Thanks for the excellent cover letter and patch descriptions.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> For completeness:
> 
> * I have looked over the AI generated review of patch 2/4 by Sashiko.
>   You may wish to too. But I do not believe that feedback warrants
>   holding up this series. Actually, I am skeptical those issues
>   should be addressed at all.
> 

Interestingly, the version posted to Intel Wired LAN did not receive any
feedback from Sashiko, and the code remains unchanged. As helpful as the
bots are, it is definitely frustrating that they remain somewhat
inconsistent.

To answer some of the questions, Sashiko says:

>> @@ -377,6 +377,31 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
>>   * The following functions operate on devices with the ETH 56G PHY.
>>   */
>>  
>> +/**
>> + * ice_ptp_init_phc_e825c - Perform E825C specific PHC initialization
>> + * @hw: pointer to HW struct
>> + *
>> + * Perform E825C-specific PTP hardware clock initialization steps.
>> + *
>> + * Return: 0 on success, or a negative error value on failure.
>> + */
>> +static int ice_ptp_init_phc_e825c(struct ice_hw *hw)
>> +{
>> +	int err;
>> +
>> +	/* Soft reset all ports, to ensure everything is at a clean state */
>> +	for (int port = 0; port < hw->ptp.num_lports; port++) {
>> +		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> Could this sequence disrupt active secondary PFs?
> This loop iterates over all ports and performs a soft reset without acquiring
> the global hardware semaphore.
> If the primary PF is rebound or undergoes initialization while
> secondary PFs are already bound and active, this lockless reset
> will wipe the timer configurations and outstanding Tx timestamps of those
> active secondary PFs.
> Does this need coordination with the software state of secondary PFs or use of
> ice_ptp_lock() before executing the reset?

This function resets the PTP timer, but it is called within either the
initialization or reset flows and only by the clock owner. After calling
the init function, the driver will reconfigure all ports, so I do not
think there is an issue.


It also says:

>> @@ -2179,6 +2204,69 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * ice_ptp_phy_soft_reset_eth56g - Perform a PHY soft reset on ETH56G
>> + * @hw: pointer to the HW structure
>> + * @port: PHY port number
>> + *
>> + * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
>> + * bit in the PHY global register. The reset sequence consists of:
>> + *   1. Clearing the soft reset bit
>> + *   2. Asserting the soft reset bit
>> + *   3. Clearing the soft reset bit again
>> + *
>> + * Short delays are inserted between each step to allow the hardware
>> + * to settle. This provides a controlled way to reinitialize the PHY
>> + * without requiring a full device reset.
>> + *
>> + * Return: 0 on success, or a negative error code on failure when
>> + *         reading or writing the PHY register.
>> + */
>> +int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>> +{
>> +	u32 global_val;
>> +	int err;
>> +
>> +	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>> +	if (err) {
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
>> +			  port, err);
>> +		return err;
>> +	}
>> +
>> +	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
>> +	ice_debug(hw, ICE_DBG_PTP, "Clearing soft reset bit for port %d, val: 0x%x\n",
>> +		  port, global_val);
>> +	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
>> +	if (err) {
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
>> +			  port, err);
>> +		return err;
>> +	}
>> +
>> +	usleep_range(5000, 6000);
>> +
>> +	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
> Will this write clobber hardware state changes?
> The code reads the register into global_val once at the beginning, but modifies
> and writes it back three times, separated by sleep windows.
> If hardware or firmware modifies any other bits in this register during the
> sleep windows, the subsequent writes using the cached global_val will silently
> overwrite those updates.
> Should the register be re-read into global_val before each modification?

I do not think we need to re-read the value between these writes.
Neither the hardware or firmware update these values. If other software
is accessing and modifying the value for this register, we have a
different issue. Again, the only caller for the phy soft reset function
is the clock owning PF, so I don't see how another thread could cause an
issue here.

> * I have also looked over the AI generated review based on Chris Mason's
>   review prompts which is available at https://netdev-ai.bots.linux.dev
>   (if only it had a name!). It flags an potentially incorrect Fixes tag in
>   patch 4/4. However, the cover letter for the patch explains the
>   choice of Fixes tag, effectively rebutting the analysis generated by AI
>   (I guess it didn't take the commit message sufficiently into account.)
> 

Thanks for the review!

