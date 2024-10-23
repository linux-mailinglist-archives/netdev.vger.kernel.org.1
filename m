Return-Path: <netdev+bounces-138245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D09ACB5F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D31F21CE3
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DB81AE016;
	Wed, 23 Oct 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOXiAivs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC81AC8AE
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690702; cv=fail; b=URTaH2WGvMsOwOiLaVeDyETJEc2QSYER5HKhcIznVlFwyWOsrJf+8lMoJ9fC+wdvlOzeY3YU/nttUDgGn7AKaD+YFtgOAtsFIFdSaqGfbpoyuXrtqx0ujbT3rnnPyRhBs2NzH8vDqoSYk02R4WG0vpA67fygAT+iw/ta+ekt2s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690702; c=relaxed/simple;
	bh=+LCo/b9d1CjxXkNMbdoAgw24wndWb2HUf99ECtEJ5Y8=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=JNyBENRf+410AVGerKPTatsxyGLFYFB2AkzGkFnNLSBxDRTu6wE4Py7cVbYmO9eOSt4lJvLrkfzRPVfOfCV4iIQsTN2U78DK4IlH0+FcE+/8T8SAWdUQIsP7V7ITHqbZAkcz+wz7GzqlsbmHAXb15OxlMUmkzdBgZMqI1fObfWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOXiAivs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729690701; x=1761226701;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+LCo/b9d1CjxXkNMbdoAgw24wndWb2HUf99ECtEJ5Y8=;
  b=HOXiAivsftVgVCIezXEJYj+j+aiREWuKYskul9Y3knRlIA5bbq1x8B8H
   T/ry7T+TVnS0MSnmKU1Sg841UTDZ+pQr/kJrGBzB2ZhhO4tD4j6Koyc0L
   O6Caf/kICdd2KV/JXeltFHn3B8lMM/WkBX/dfJI/DV3xcrA4wVriiODEB
   KfEWX/oTS6s66jaBemE2FDUf2vPIODHano8DVh2LIbmW4nRUQIKA3WjGf
   iHz43UT3fW1MqlNrjUHC//mvBGpKgDj5VTa+wcVji8uTeDx+EFWg+UIv4
   sACzWk49CTD1EngxQi/OY8mOzrH46RBdR+kx7dR1tmo5RwgjNmXJCQbX4
   w==;
X-CSE-ConnectionGUID: YbBJxWNJQSik8+oDh5sivw==
X-CSE-MsgGUID: FTSrGn2aR527TwFKC4XNVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29149255"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29149255"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 06:38:18 -0700
X-CSE-ConnectionGUID: PnYr5gQVSQmz8QgqPAxYBg==
X-CSE-MsgGUID: bR8VJc1VRRC7VT5HrwPrXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="111049042"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 06:38:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 06:38:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 06:38:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 06:38:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gODb9cOxL+fUtij5tvGS4IHUwjTHbsrSJbffBgCSmWoAZ/Nt8SlyWZnJpAeXXkETyxWYhMEDmmJtJTQ8RQBPzryaC0Zng+CC9jsEK2mJOaKE2dV89fpoB48WxRFm9dnX0F7TONrfhBrmyXYT1oC9OCepb5NATbr0hJ72Jyl46wnUSqcnFz61HkpW04Qv4C4leZYzDHe2xwGY0MZzMfDTyeHAESB1AO/iH2omEnZwuXGdfjjV0DqXJlAJ4GSpTp5AIo15YjS80O7I+ebqEhfczA66GaQUc8zVjWZRjB1vIHnK2rpKe7xmZECcdhSF2Of77R+ZFsrXjQenY7ljdQeyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av+5BMlbOOh3Ubv5uPcMCEVjeEaugNPlzP+0tOmLJso=;
 b=CEKdQl0Y9laF0y/VByVWZFEwe9O84p4gBuAZcI3DhWdaJNEDYvA9qnBiy/Xtu67qKLng7si05JLPIkdY2ilFY+DJ43RyKSW8WdrjlzWejdLWGYeeeZfLaVLlCGSbvt5F600mlqINevHmQrTKlH2z1R1FAnm9+X/uncS4F7U/SASDNekOb41wes37k0Q8Hp2hZq2auLem/0JfPxGK+2ZNllzDSsaI4xZqVsFnnvKfA0AGm7PpuJjvx+tS6EYuL/eG5cVB+AfJ7Xxu0mmFm5oDDc6pinHL301nJpMSVqN8LiJpq3gNeGxFBS5OLRQqYbPf9mkwwOwDoyYutudXrWG2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Wed, 23 Oct 2024 13:38:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 13:38:15 +0000
Message-ID: <66d96956-e393-41e6-952a-3f23ebcd3a79@intel.com>
Date: Wed, 23 Oct 2024 15:38:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: igb driver: i210 (8086:1533) very bad SNR performance
To: Stefan Dimitrov <stefan.k.dimitrov@gmail.com>
References: <CAE8EbV3aruDHKrBezSLg_hy0XZG2Dr1pkzvXVVTj0QpNpH86nw@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
CC: <netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
In-Reply-To: <CAE8EbV3aruDHKrBezSLg_hy0XZG2Dr1pkzvXVVTj0QpNpH86nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: e6188faa-3961-4b24-86da-08dcf367f228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1VSOFpld0ZHbmN6QzlJdGFFRjFEQkNjODd1T0ZtUkJKQlJQM2QzMTAvMzB5?=
 =?utf-8?B?WVhHa1pkellIb25ocTl3MEVDaXJySWxqT3BXNklYaWhmem1EQ1VpRmZPbnp5?=
 =?utf-8?B?UlJsVE11d0trQTEzSUl2Wnh2aTVZZzdOQWlYbFpTUFZmRExaWk1iZkNWS3NW?=
 =?utf-8?B?ajJQek9EL09uV21aemgydXF4QTJhNHBOc1Z3K09BQnJYZVFWZmZYZ1FsZlZr?=
 =?utf-8?B?TWlXR3RJNzBSN0FGRjQ4cHVlRmVac1pHeHlMUG1EMWovTFUyL2dlZWkySko0?=
 =?utf-8?B?M0xBKzZzS1FjeHRNcUg4bnMxcy9tMTl4dXl0YmlBNlE5cFd1VXY4SU1xZmFn?=
 =?utf-8?B?b2J5ZTB2OGpVTS9CckE3MmcrTFRPL3BCT1pMRXQwSjgwY2M4Ym9JWU1IL2Yv?=
 =?utf-8?B?MEd4dW9KbWQ4MHRjVFVaQThyeWZtWGxiTVdMNmpDcjJPdlNSeVY3VXFMV1FK?=
 =?utf-8?B?MVA3ajBDaW44L2pLdW0zZWpnSDlHelBUM3JjRGpSSjZPT1lQVTRZODJPenUz?=
 =?utf-8?B?Z2VvVEtRWDM0YUhqNmN0cU9Nemlndko1YW9ySWxjaG5zT0dtL3lJaTRMaU9a?=
 =?utf-8?B?T243MnVxd2luOXVEckx5UFlOQVZpZWo5TlRnTGVobUFzZzc5ZDRQeGV0RUNV?=
 =?utf-8?B?bm9Ydk5OaWxjbGRuVUFNTWtWQUlBVzhDWDZXT3BNQklYelVYSjhwWW04MnVT?=
 =?utf-8?B?SHFGMitJcGsxYVRidW1OaEhRM1kvczhyNnlmclhnTnIwanZUaGhyV1FTcENK?=
 =?utf-8?B?aDJBVjhuU2pGQW1ZWWNRVTlxODNvNHd5WUFiQ1NZT1YrQzF2RmNsdFlXdzZZ?=
 =?utf-8?B?UWNuL1NNS09wd3B0cFRpQnBuT3hheVVnOWtFVjhxMGFNSE9KMFZ6c1p3M0ZB?=
 =?utf-8?B?Y1FTQjFMdFhaWkh0MEFqdFJGcnRJM1pIbmNMbVNEOEU1T09SYWI4NU15YXRv?=
 =?utf-8?B?VUllTTRuSTdmNy8xZWNobFJTM1dlQUFKYmN6M1hUbEw2WXRwMHpYNXdVaTZL?=
 =?utf-8?B?ZzMzelp5QjJnYmNDMUxITEZVUGxXZEREbFFIVk1nMWZ3OGFLdE43SFptWFRa?=
 =?utf-8?B?aUIwbjZTVEk4UndZU3VlZDk3SHFSZkZoUWZaZnBSeXVHdHJQYUNkeWFNdnZ5?=
 =?utf-8?B?eldVWk1MeWlxTzZXSURlR3ZnQnVETDlabEsyRk1jaHdldkVmcjJvNVVBMUYy?=
 =?utf-8?B?WitFcGRQZFBIYUlpeG11QmdBNE1nZ3kwZVJScm92czFwcjhaMkhKalpiMGo2?=
 =?utf-8?B?WjBFazJqY08vOE1RUHFrWk03NTJraEtLZ3Zjd0pHVTNuZ0swVXZ6YTNkdzFW?=
 =?utf-8?B?Zk5yL3Q4TlVFbGZTZGdNbjBGVUJFZURYaUVFNFllcHg3d0Uyb3RtNFY5cDkr?=
 =?utf-8?B?cXBLR1lpajd5cUlFMDdZbUlBSWZSNGQrNzg3RjNzRnd4SjJJVnhTQmtweEp0?=
 =?utf-8?B?ZXVNamdleCtkVE5qeDRXdWtWVHplV1ZZV0ZjN0cvTnZFV2pDSVZ2NWZrMmtC?=
 =?utf-8?B?SDlYb1dJTXltY1B4enJoM1JsQjczczgzTzk5akFBbk45S2o5Y0tYNFpQb1kz?=
 =?utf-8?B?cGxrSDV5MEVQMlJvN0JjR203VUZQV29NYnJsTXh2MTRyMWgwMnhZcU9UQnBr?=
 =?utf-8?B?K296ZU5MTG1XSE9mM0VmVEJ6UWREMlNCWVFZc3dkeGc0NmZ1OXU1WlphT0Rx?=
 =?utf-8?B?OUZSMVdRdzNDYjJuNkZ1R2M0ci95K0dsU2tMZkF5b2VTZlhOSWxRT1R2YlJP?=
 =?utf-8?Q?8D0dV6rNZHYIQYw98DboYJt3o8A0IAS8NohD9IL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNPTTFDQzNYK0VFSXlnbndvWWdTcEc1My9VVDd5MVZ4SzByYjlkd0pEVzZM?=
 =?utf-8?B?N0l2bHdCelYwOTM3ZFpvRDBSWSt0dElkRCsrSmpZUWU3VVR0TVhLWldrdERB?=
 =?utf-8?B?RWlwWms4aUlUbFZkWHVLcmJybG9ubnZmQTVXM0UxOWM5V251TWNGR09vN3ZX?=
 =?utf-8?B?c2t1SytQM2o0TWdNaEM3ZEg2RHdNSW5tTkgySXEzTnZ2WW5tNkx0bmtSeU15?=
 =?utf-8?B?OEp4Rk1mcWtvSkdmTFQ1ZmZtMWtBTkE0TW15UVJaQjlWRUgvUndVbngwWDRm?=
 =?utf-8?B?dzYwOUlBRzM1RUczTVR0NEh5NTRLK0hnYUZySzJqNEM2MkNVSnZZM2c1Vjlv?=
 =?utf-8?B?NlBzWG5hckRERlpiSmtnSUMzdTBlbkpQWXFJcVJCWkZkOWg4VHFSQTVaSjky?=
 =?utf-8?B?bWtlc1RRbkplV2xBamJsNTZwamtNai9ZcmNScmdockhwaURleWNaZW50R3I4?=
 =?utf-8?B?QisrRkM2T3Q5QlNxY25KdTQ2Z0JqYlhCK0FFdEZYSVBVbXVtSU5LUzZZZUFX?=
 =?utf-8?B?dWlIYjA1N2xmVE1LSUtTNDE2Tm5hbzU4WWRJLytwenAwU1RuWnlBVmZHU2NR?=
 =?utf-8?B?NnhnMXpXSjRKdjdiRUlNOG5NZ2hEekVETmRNbDI3b0FqdjFqS2ZyUERyNHdu?=
 =?utf-8?B?T01TRTk4TVZxRnIrZXFnQ29VdlZib3NkcFlEY0loaHF2amlpbUs0MXN0bHdj?=
 =?utf-8?B?bjZHODBZOFAzcDRmakswS3Z3Ulpnc0RNbkdNUkJlVUZ6dWhudDA1MDNCZlIv?=
 =?utf-8?B?K3V1dXRqbVNzMkhMR2NVOVlhN3BwZHBJQVlNa1k3L3NNZnlCbEhReGdTemVn?=
 =?utf-8?B?cmNLcVA1cWduV3E2VWpmYjZOL1FNYWVPL2o3bzBYdGJzL1VXcWpYZnRtVjFj?=
 =?utf-8?B?VUZnQ1hmazhpWmo2WGRMbk10UHhpQk43c0g1M0M5NG1UZWEyMm1qbWtnczRT?=
 =?utf-8?B?dnRhazMyZzRiWDdLWkJEc0NpaGQvZ0NSWnZ4VzFDWWVEMWdkZ0ZYUktKcFdw?=
 =?utf-8?B?bG1YWDNVQUcycHdJdklrbEQ3ZVFPNW5ySWpwSWYrTGRNOWxoTkx6UkdzOW1Z?=
 =?utf-8?B?bWdXY05iMWNiSTBrLzJnckx1OGRtVnBSU05UUk1HOEthVDN4aHhzUDEwaGsx?=
 =?utf-8?B?ZmJ3K1NBNVRHcmg2dW1lU1cwRXY3dFRUN1d1aER0L2c4Y1R0ekU2c1JLUFpo?=
 =?utf-8?B?K1R6NURxeTA3SEJPcjVyT3BVdWpkMDF6VFV0dzYrRWhEQStwVytWSElZMzRJ?=
 =?utf-8?B?S05IcUhaWWlNRlBmOWlpU0lpdWJZNHJzRlJidThTZ0M3QTR2YzNkMFA1UVAw?=
 =?utf-8?B?S25nK1JLSEU4ZFEzYVgwb2Rqd3FFWWRUT3ZUR0pWakZ6WUNDclBBMnc3YUpD?=
 =?utf-8?B?RHMyTUZpWDNwbVZxZ2p0dW9ZT3NqajY1UVIyYndCSjlpb3E4MGZOam4rN3pD?=
 =?utf-8?B?QkdLV1Q3VThhSGgweEcxSURCVHBwZHI4azZwK1F5VGNPM3lxU0hBcVF5bS9V?=
 =?utf-8?B?am5EdUd1bHc4ZXIxaEZ0NjRZSXpXb1dKUmUvU1REbXVpSUpWUWFRZGVFUktm?=
 =?utf-8?B?TFFSZU5pUEcxWE9TbTMxdWxvRTBHK2RGcVhyWG9NNS9XdFBsemZyRHRLWlhD?=
 =?utf-8?B?UGpvVkQ5cWgyVGwwVjNtOURWQWNRWTVGNDdLYUNUWmp4YysraGtWZ2pPblM3?=
 =?utf-8?B?amdBZktiYkZLcWVyR3ZYK2lWa08vMEtxaEVvSGhGNDVjZ1JSQTV4Z3U1K09C?=
 =?utf-8?B?TmlOdzdtWHY2ZWdkb3hDV3o0cHlzVXhLc2VseStqNkVYUkFNdlREZW1GRFpz?=
 =?utf-8?B?ekx6b1BtcDZseitPL29DR0RiV0JQRDNkS1NpWlZKbEIyQnZvYmNFZ1QvU25N?=
 =?utf-8?B?V1lna01HdjNFSndKNi9uWWQ4Y3BXb2h0V0JjeTY4NXptM0VEcVU4ZnFnZmxI?=
 =?utf-8?B?YTBVZHgrTkZPOXNLOGhXVFdDay84Uk1xcUYrMWtQSTZQUzVSUkhWR090bDZR?=
 =?utf-8?B?U1Q4bnUvVXIySjB3QjlBREtlN0Y2UlltNTBPTm10TUgvUy8xb1k1a25ZV0M4?=
 =?utf-8?B?eXBiWGE5QmRtbWJVOERWblVmS2RycEVtRUxUSDdtSndwOVQyYjUyTjlLOXQ3?=
 =?utf-8?B?OWIzNEYwOFhTdlpmT1cwM0JkZjMrSFV0OC9FZTdPWDYzNXYrQ0F5S0UzQ0JG?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6188faa-3961-4b24-86da-08dcf367f228
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:38:15.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pu3z+//YwyAGMxhpXVPAkKLmRqMT5IzHfK9//QyRiw5i5Qvil/l0jwCApWBoqbC3BUxBHTkvgl62G9ZTYl6R0q/zxPxxXUQ63rpBZfRilA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com

On 10/19/24 14:39, Stefan Dimitrov wrote:
> Hello All,
> 
> I am reporting the problem only, because the exact same
> environment/setup is working perfectly in Win7 with Intel driver
> version 12.13.27.0 from 7/8/2019 (I guess that is the latest driver
> version for Win7 as it is not supported for years, but it's the only
> Windows version I had during my tests).
> 
> So, in very short: the same 20-25m of UTP cable, works perfectly in
> Win7 and not at all in Linux with i210/igb driver and my best guess is
> PHY initialization in the Linux driver compared to the one in Win7
> drivers somehow reduces dramatically the Signal-to-Noise performance.



> P.S. it seems i217 (8086:153a and 8086:153b) is also affected, at
> least based on my very short and not extensive tests I did today.
> 
> thanks,
> stefan
> 

Thank your for the report, I will dispatch it within Intel, we will
communicate the progress here.

It will be beneficial for us to know the firmware version used both
on Linux and Windows setups.

For future reports, consider also CCing the IWL mailing list to get
faster responses.

Best Regards,
Przemek

