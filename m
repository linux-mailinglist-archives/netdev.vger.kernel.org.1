Return-Path: <netdev+bounces-124735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6896A9DD
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DB61F24953
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F41EC002;
	Tue,  3 Sep 2024 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0XjCqY6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83B23D7
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398308; cv=fail; b=jxo1S8zvzdDJK4o/fIEjQzHY6GTJJFvNgQnvUKAlKgomaC2ywp0tvzfF+Cx/khYRrfXQpF7HYVu+gaJx0ZKcFS3f7VfxQzLlgbRuby63ABwOi68q7UjyarNdiDSPdvfgPbCr3uRAhHIVzlRapTwLlm1vdD5SZ6zqw0Q+deXZ3iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398308; c=relaxed/simple;
	bh=fMPx17cdu6LQGNDv6Q6gPJfy86nO/m9PyHYhMO/kmHg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud6w8Vh6rvOoTQtofXyOjCflT/LaxGh5DKhCNRwcj07yIl3P70p40IbO35d1JbV+cc2ZLFMacm8VgzUmmseNSdWirtvRELlTVJGWciioX+kQy1tLrBek0Tb06wFkMQF4ZrfWnhj6O3CIJjOQFYb7LYU/USScekitF1lz1tHXrsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0XjCqY6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725398306; x=1756934306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fMPx17cdu6LQGNDv6Q6gPJfy86nO/m9PyHYhMO/kmHg=;
  b=k0XjCqY6SoOmWL1g5pODcrVWeuHZpH+PEZTdtBcEJR6qPDNmF/6RfNrZ
   LIrVfxRdnx9qH51C7VtfPdZ5S0E50bZtgXB7ZKutXWrIV7WGKc7UqIUcV
   e05yTAVNghZe3lzJzNk60kS4xKscN5+YzyuU7mLP4QQnLA0FtpZyOuYyS
   aior2CgXTCUxBT440zB07Pw6i3ak6XfxIvH7hDKRN00UkBkFZa3DoS+Ec
   leUGkn+dLYlxMwhgJOnGqT31BR+Zarm6SU0udMX56Yip2fEOY4JdfdMj4
   53c7Fpt+JqqqbjJTFasUo91EZaJmGOPdqYa5qhHruUdozX/vBGRx2wfs0
   g==;
X-CSE-ConnectionGUID: uVMWfoeuRYuVKscAxe5ipA==
X-CSE-MsgGUID: ZAHZZo0RTpyqwBp0zB0YtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34691664"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34691664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:18:25 -0700
X-CSE-ConnectionGUID: hfLQQtHCSpmCTKUhYOKXIg==
X-CSE-MsgGUID: vSkcFLIvQSKW+oJ/cCBPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69831657"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 14:18:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 14:18:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 14:18:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 14:18:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 14:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkdWMfAWAHWUrOD7Akd8diJmyxDrYRzr2rBCuVeQ7H7OF6o3BIfIm/StsSdX7cyDyBQI+GGOahjQ4G7gGf7cFSVIP625IJJwkRdVlsLmqd68kGYZCtO1CtUCKvv+fGDM5t6aoFujE3mSMOwpSzg5l9WEH4ar4+wtZ0WMHbeD8ZNpQbqmnGdmfS7SL4GbXe2HTKYXsBGQUR/yudD13WSO0CrRvZGvrCo62a+8uqrqzvZSHzFNnzHT5znorDk2jplfEBH3+FTFsBK942NLyebz+YD9p8RP8+ebFYtLW3XCaeFjaiy9+M18xJ9UcI8KQaFnJiG94UFKla8s0RdFgi730A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6znAu6Yd4/1QjSf0QU6E7y9+JuijvcZodAcZYawpPY=;
 b=VX3+i2oCEB482VS93QG9s/f4NsYA/GTV2wqSATQSwqzyxLho+USCq0Fcj6IyQdhPELxhM1vEZOZlyETeEhayA9gUzhsFHgJ9al+IvBxSV/Yyqa2g+J64egpChOQ/G0ZeQyDJYd1Rer6bnWO0XjD9P3Y7US6vQwWp8efGsy/nD7zth5LzRBeNg0heXDOKbgFyypVRJIYi+StakrWLRo3Y1T2LUkR7vF86XwUrczaMHCrQXAURqyRttoHSbdJdAdMbiushemFwytN3A39K5iFXDMM85KLUrXZwykJ6YIew7KOaP5ulye8Gn04rpzZMsqCCUYTBTYDdr3wmsMYLzLNtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 21:18:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 21:18:20 +0000
Message-ID: <921e5259-27f2-413d-9075-c5dd2576a66f@intel.com>
Date: Tue, 3 Sep 2024 14:18:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] Cleanup intel driver
 declarations
To: Yue Haibing <yuehaibing@huawei.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ahmed.zaki@intel.com>, <richardcochran@gmail.com>,
	<michal.swiatkowski@linux.intel.com>, <amritha.nambiar@intel.com>,
	<mateusz.polchlopek@intel.com>, <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20240903122234.964218-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240903122234.964218-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: a519fa59-62d1-4d43-75a7-08dccc5def38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTF0TldiLyt4SFVTZmNEOC85eDVpNjRPRVg1RHFOR2FOM1R3ZjlWR3BGTDQy?=
 =?utf-8?B?Q01ucWpzdnA0UUt4ZmpCYnVGSlJHSDFVbGFNMGVEU0dRcmVXbUFEZSs0MjJL?=
 =?utf-8?B?MURUcWxnWnlyb2pVenlFd2tseEVkcHdibGhYQkgrRUM4S1p5eVY1VVpOYUdS?=
 =?utf-8?B?dnI2N2FDbGtMaG55RHBmbjhZOWNCNlBTU1BEYnZTQkhvQi9tNFNndENqaG5v?=
 =?utf-8?B?WG5yZms1czA5Zi9TeFk1RWgrYTg4VFRseDhjbmxSWnErQlh0T0wyL0d2Qm1M?=
 =?utf-8?B?REQxSE80dG1Ib2cxNzlJV2g4RXhMM2gxNnlBSTBleVVvbTBFWElSN0FFWktR?=
 =?utf-8?B?eGM0Q3VNdnNET3NtVTFSYi9sRkVIRWVuV25YY0YyODJUdnduZ0VVM0ZZaVVq?=
 =?utf-8?B?czlMUFRUQzZHMU9vN2dIYkN4cTFvQTVqNmZZNi9XUVNBdzR0Sncya1VNTi83?=
 =?utf-8?B?RlRRYitwb013MEpTVktoa29kSWZDOW5YTlJlNzhyc0FGT050ZWcxL2gwakpH?=
 =?utf-8?B?SWN6eFM3Z0pwd2xkd3pQSmsreXlnYk95eWNQQTlUUlhvR3FxOE5vNDlHNENW?=
 =?utf-8?B?VksrMG1zRERiby9kdjRlYVpWRFFucnVraElFSDlqMXNKT1hhTjR4U0g0clNN?=
 =?utf-8?B?TmNIQkxRZnVXZ3U3K01uV1I3bDg3MTBlZ3k3bjdieHE3Qk1INVg1SnN1MGxz?=
 =?utf-8?B?WkpJMUJkWVZiZzR6R0poM1RXbU9yUFNRTFdZbWNGNHZMMm9EYmdiWUxRcTFn?=
 =?utf-8?B?b3FFRS9hSWc0L0pSMEhmY0M3cVYyaWY3MGkzSTJGTkcvSVI2VVpWRzhMbDY4?=
 =?utf-8?B?ZmsvWGRhYk5yeE4yU3hNVStMMk5qODlGdGtDMm9qWkltOGo3M25qU2cvZXJJ?=
 =?utf-8?B?Um9IQTNMQ2xQKzY3bkh3SmdNcHdsSk90ZzB1RER5Q3dkVG5JNkt4elJNSkRQ?=
 =?utf-8?B?RXduaU10SlROMUV1c0xiRnBSbzE3K3N2M1BhaXErWW1KY3hhNHBlNE41dk5Y?=
 =?utf-8?B?R0F6QnB4ZjlWMnNzQy94Z1habnRweHBvVVh3ZGJlM0pQZkNNNVRPOEtUNUMx?=
 =?utf-8?B?MkJWUDNPQ3loSzBFR2tBb012dENDZXg5eTRPMU1sRy9tZnpKMU1DbHFvM1g1?=
 =?utf-8?B?ZXRKNzJ1NkVqdnJDT0k0bFlCazI1dnJyeGxsODBEN1h0Y254VTFOTDNVTnJ2?=
 =?utf-8?B?VEJseEJaa09SQ0d4Rkk1WDV1dXhlK1RXcHZCUzJnNnhhRVU2ejdFMjBBRy93?=
 =?utf-8?B?cW5jdkNmcGJUdzNLRGFSQUk3Umh2cjlJMG5UOVE5QWRZb0pmakllc3VlNkl5?=
 =?utf-8?B?TlZpQVBVdG0rOGI2U3IyYllPSzZ6ckVvNEVGWjdGN05uWlM5dFZqUjRtT2pH?=
 =?utf-8?B?N0djeDVqU1pvUWtSTmZmR3lyZmxyQ0NWYzNqZ1dtajluZ01vY1RNV1NZQzVi?=
 =?utf-8?B?bU9reUdZUVEweEJkdDZmVXpTY0ZYMGVJcmtjOWJ6eEZiSVdydmtBQTZjWEFL?=
 =?utf-8?B?NXBLVjZPeWhxOE82WklMNVNGQXpvODE2TnExVUVNRGVoTFFwbVc1VEtPVjBE?=
 =?utf-8?B?Q0lnemdHbkd4V0NIdmcwZXIwd3g4eE1RZnZtTkhyRytnRHN4Mk1zcGFUc0Jk?=
 =?utf-8?B?VklWTitaRGkxbTB2M0lEcU82Tm1ST3dySGRYcW9lNGpaQmlTWXlnTmw5K0JW?=
 =?utf-8?B?Lys4U2YrR0VXUVR2VU4vUGVaSXlFd1VEVlhPejFCV3Rsc0gyRWVvKzYxb0Jy?=
 =?utf-8?B?ZHMrNmpCdWdXVE1pR2JOdEt0YitZc2dlU2RDUEN1MHpWU1ZEcTVJWTliVkt6?=
 =?utf-8?B?SEo0SEhkNFdDejFUYVhlWnJwNm9Eckk2VVdOdmE3YjR1UW83dnR5czRZckUy?=
 =?utf-8?Q?2YAEp9CQean6h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRkVm50N21WQVBDYWJrVVp0bkNTYllSYysxbVhiQXFhWENHR1luT1ZTa1hi?=
 =?utf-8?B?cnhFVXNXeGhma094Vm9xU2c4K2lLcjBiZTN1WjE5dGZqbkRMY01QRHVMOFJL?=
 =?utf-8?B?NUQzMjNVdjE0NFVmM3hHa0NCVVRWb0hqNkJZcHpwQmx4TW5RcUt6ajJ2UFBM?=
 =?utf-8?B?U2FXL0dsMXhUdlFDVG9TTmNzSnpQM3J5RnBzRHBGUUxsM3JOZ3o5VmRDZnJs?=
 =?utf-8?B?ZWwxb0MyQUpPUG5BTkc3YUl2K3YrejMyUlkxMVFqUDBSd3FrUHVpTDBpdVNY?=
 =?utf-8?B?NnFuQllKcTIxRGdPekFtU3c4anJlQ1hFbjVRbGo4eHlmZkIrYng4V3JGRTE3?=
 =?utf-8?B?bnBBNWVvaGpoUDRIb1lURVAxek1JVXJLZUVScHJjOFUrbjZTbldxaEtwYUov?=
 =?utf-8?B?dUlWbDh1enFEbUF0TEFyMDhSWEwyNHE0em5LTDk0YlY4MTEvWFBZK0kzU0Z3?=
 =?utf-8?B?SGI1WlpaNmJWaVA5TG1KRXpNb1UvdlZqRHlxS3hVQWdsUmZKZXdtVnpMdS9F?=
 =?utf-8?B?Z2JWN0YySGpSNlNhQm1OQXhXN1BITkFQOTV3UkFWOTdEaFM0UjdJblhVNys5?=
 =?utf-8?B?SDROMlliY25Cc1JzMDNsazlPOVB1M2s0QTdNS2hnVWExcjFENlpVRUZyZVgy?=
 =?utf-8?B?dlFHaDhLTW9xbXhveGxLSTljOHVFRkRzN05CTzg1OThvd2I2UXdyK3dFQ05W?=
 =?utf-8?B?cjJUTUQwMnVlZHdYYW83dzByc0VGeGplbEJBaXVjZFltNVFGSnQyZHpIUkRs?=
 =?utf-8?B?bXpYYlZoa3phTlJQRDlMRDZXTW5YQ2ZEOUsxY1hrbHhuMklyMXBwN0swR3Bv?=
 =?utf-8?B?UGUzdzJ6UUVTbVhvNlFQdG9haDFpcENHVDRwV2FhdEE1c3VVc2dWTW5Kek1s?=
 =?utf-8?B?eFJkQVR2b29Sa3Y5MnF1MkQ5S0Vyejd1K1M2UlFpZGo0VEx1ZHEyTVlPSFdM?=
 =?utf-8?B?cnhiWW4wa0o3MC9DREdsZm1lTkJtRzFzN0JpeEVtR0pxMnExdXpYUFBWZkc4?=
 =?utf-8?B?NEs1UWh4bGhUWE5WWmwvTHduMTBZQUxEOGNGMkwwbUhwbU51emZNTFB0b3hE?=
 =?utf-8?B?azJtL1YrZDVsTmxJaE5BOVJhcTlzY2hyMncrMldRNzZXWmljMzcxKzhqQVFE?=
 =?utf-8?B?ejlRTXhnSzRKdkIyaG9xY1FHbG41NEpUVEpRL1VsSHpoT0lDaW5vbEJxNU5h?=
 =?utf-8?B?dlM4QzRHUDh4UTl4NzFZQVgyV3B3Uk1DTHZDY1BHY1FyVmRBWEljTVB4d3dj?=
 =?utf-8?B?OWpyTE5hdlBzSVovOTU2RXFHeFBDVDNROXRJRldWQmVERzdtZ0dWSGxlaGFS?=
 =?utf-8?B?Q2gvTTd3OGRmd1NYTFBzelpsTWlHMjVxTGFmMFk1Q1g0SXpYakhuekk5MURD?=
 =?utf-8?B?dlg0THA0NnA2Nnk5eFpueGg1N3U3blIrZHRkeFJPZDVkY3JxVDdzbWQwVWtt?=
 =?utf-8?B?bUlzWnVrcTlSQ0xvUXg0VklhYUNSMCt1V0ozUWZvVXJibTlGYk5tUWE4U0xu?=
 =?utf-8?B?eHI4aW0wTmJQZjlKWG0rd2NTZk11V2s3aTFYayt4S21QaHg4NnNZNUJ2UWhX?=
 =?utf-8?B?RlpTTTlTTzBTdnFLUEUwaGZnS1FzUUJpRkxEV3dDUk1GSWNoUlBjcjlIeUwr?=
 =?utf-8?B?bmlQcVYrWHNuc05QQjcyWTJpUlBoSThveENEclQrWDE3d3F4ZnpOQlIzT3NW?=
 =?utf-8?B?cXZtb2Z4Tmc4OG4zM3JJTUdheG95eUcyM0ppbnBvQVlRQlVRdVNGMElHSE9x?=
 =?utf-8?B?VTU2WlBlN05ZMmpuWHczRCt5YmpEQW5LbVZJZFZmZEZoeXRvZHVxZENLeUVq?=
 =?utf-8?B?MG9BOWpJYVhwNzJKdzZGcUpQbndMNDl3dVBrVHZhRkx0SlhNekNZdHE2Tkdn?=
 =?utf-8?B?ZC9Gejl6TFRmaHNhOHlNQ1RoN1JYZXdiSGNYWDZlY1pjVksvUE9ramxWWEhW?=
 =?utf-8?B?cTZmZ29hWitra3BwazJFZzcvMlhHdDJVVklwZm5sQzBja0dVOElJdjd5NkVS?=
 =?utf-8?B?dUpiNWZMdGFrYnJvOEM2dlRadXQrK3NGeEQva2NFelR1UEZkbjNkYkpiZmg4?=
 =?utf-8?B?WFd5NGwzY1ZpekhBQ2U5YlhlWGhZMkVjeGZOTVdHMFdXaW9DTFl4SWxwN25H?=
 =?utf-8?B?TW1tVFVZa1lHTjZteG5rRURiZklqS3VIMnpSSHZRcEZkSW9zNXlnZXZEcjhC?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a519fa59-62d1-4d43-75a7-08dccc5def38
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 21:18:19.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+f3spL7vkC7qvcG5MJcFTRQhmJu36Ujb886LDlNqsLDZurniZ06Y1IpKZbkZBK3qReIZWV0wq/gD4O6y3WMsgYUDMKCNOy12WbzhfHUQpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
X-OriginatorOrg: intel.com



On 9/3/2024 5:22 AM, Yue Haibing wrote:
> 
> Yue Haibing (3):
>   iavf: Remove unused declarations
>   igb: Cleanup unused declarations
>   ice: Cleanup unused declarations
> 

It would be interesting to see when the code for these declarations was
removed (if it was ever present in the kernel to begin with?)

