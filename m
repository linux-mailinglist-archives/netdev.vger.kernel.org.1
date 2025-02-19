Return-Path: <netdev+bounces-167902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF853A3CC69
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ECF188E799
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED032580EE;
	Wed, 19 Feb 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0Fnp7sd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410E1CAA65
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004451; cv=fail; b=SmfwZIZLlePeP+ZwUDLMAu81Tecn1cEq9gQMdYpHR35xNzl1YQewwIlCSf6oE+tqgWqYL4MeUPjz5Hu8QnvMnbIFSHHA1JkBnZOfZIOtzKgJtIFpXGZuYV1vr3NnYI3NchqvJqmudYqu3ha1t0uvY+31iek0jwlwhJHCF6kxvlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004451; c=relaxed/simple;
	bh=mji1XkwmCbkSVJifHlrgOE46E4Tf3cRHOVnH/8mbsoQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o6t3CVVStwJTwCUXL/7G2AaMIqQt/tdBCl0KOB/Y6d7PMozuYLuepkufEMGSlneibT7u7WWc1w0so0flW9WSC5el8ua4OyTp/Rkbf1HNDnReOIR7GXmRFuLI4W4HyhL/1jo4JFx5VDABhPbAdcB+b63fAH0tS6KnlhAESFVHkX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0Fnp7sd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740004449; x=1771540449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mji1XkwmCbkSVJifHlrgOE46E4Tf3cRHOVnH/8mbsoQ=;
  b=j0Fnp7sdmITRrNetx0WKYEcBxCoFm9TeH51MwYAC5BGzns6EXWovbA6r
   CDR4VNoHleSOc6lv6MR2oNMssKcsI5P2AVE36VYnXJFDXNPG0sVhifOuf
   o8c6i9PGEs1Q+7XbfCvVEgnQwY2vPxzvzdHWnkQKuYSGporHQ1SyMOoRl
   yTxC87m6aoKjDGTiOETU2gBEogMoeY75MlhcbIA8X26+iTMWg74hQHK5q
   T5z9/N+v5dSrESStH809tvl/Us/UNHs3xY4ta9c9+6J/mHo0gmeomleSO
   CXsFWK9r7cjQf9l5rI768g5nwVUZc/qI++OwEJvUEeDOp5VBkIkphC00q
   g==;
X-CSE-ConnectionGUID: dzss6W1eSH6sMuLJN++kHw==
X-CSE-MsgGUID: wN/4cpHXQoGCIlrpF2N2pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40884293"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40884293"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:34:09 -0800
X-CSE-ConnectionGUID: qX5LXXXSQxmwyMTYlFDfbA==
X-CSE-MsgGUID: KPthxpJ2QUqTNfBjxosPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119831322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:30:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 14:30:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 14:30:32 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 14:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywD09+GmO3jzNXjwYTJT/LIdqNklL6Dd/sFjzuMXwACUwOS+C+jEM/ABKGMJawfVvtpyHrtqFt2yr3f4E9SBDxfnsIxA/C0UIgCwZ7S1jfx44P2I9/9dWonptqn5FeXLsDS9MnMrXeyTW12gt1olIfpak5Vx1jLCykki4xeV8dz8VYAIXcOQCV8cxgcLlk2bqd950RgID27H6L+tBWKwMufCN5vGbAydfdTP+JUFuyYar3h7x+t97OpVPmEF0e6XQPcaD5SK+CMvzly73DFQ0rdnVysNX83lyEyjA/3QNkHmk2KPqUSvAqMwtn0T26OedfdH8U3nEdlVrHVnUQRntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lB7TQgL4nObyWpWF1yaxM96ZLoJFkecFhNlEF9qj6I=;
 b=ygA4wE/uzMIaSO561g2+m8KATxDnBjxIWvxy6nbMnbuahzqbdx3KHfYV2IYsxzIRMM5vY4Da/nMtdRE9yVBDd39RMlEH31cNVWkLqOPA771mGQ8OcHn4PIUx4ilyyNvdqorOeJXHDSgFgo05DRLesVIECuorEbiizPIkQRExfwdONOtwa8VH7FWFna6QQ/Jd7AZDMDs5NMO8QFjdAW+PZ+51nMgIuHwJNhSbd3po8Po/a1YsM6JtsZeWyv3AVDn9M91DdPzIDkn3D7FiLNRQUC6xhpbFYCyxSf5GAyOOHXlpFM+VWlD9iGxkijkwtuplBhD3P4MsdCfDxg6OEQEjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6783.namprd11.prod.outlook.com (2603:10b6:806:25f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Wed, 19 Feb
 2025 22:30:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:30:27 +0000
Message-ID: <bb42f26c-ee15-4ff9-a8fb-09669b727ced@intel.com>
Date: Wed, 19 Feb 2025 14:30:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: ensure periodic output start time is in the
 future
To: Simon Horman <horms@kernel.org>
CC: netdev <netdev@vger.kernel.org>, Anthony Nguyen
	<anthony.l.nguyen@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>
References: <20250212-jk-gnrd-ptp-pin-patches-v1-1-7cbae692ac97@intel.com>
 <20250215145941.GQ1615191@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250215145941.GQ1615191@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee0368e-14c3-4aea-c816-08dd5135020c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVh3aG1MbXZ1RDNrY2pQbjJ0TkxsYk04ZlI0MmF2bzNhSVVlOGdKRjA4cHd6?=
 =?utf-8?B?TDMvbkpWRDBTaHhVY3lkWjJFT3loMzhjcTlaTi9EK0dTWmRXeHFVdi9GZkY3?=
 =?utf-8?B?aVhTWGp3eHEvVW9ZRmhENk1zazcwSzIwUmo3SlBXZ2U0TnQwTmkxWTV3enZ3?=
 =?utf-8?B?YWttUlhCclFTZmFVMUs4TnF1M3FKWnJjTlZ0Q1phNllHd0NwaHFWVnp1NVYx?=
 =?utf-8?B?QzI4U2xFWGxXQ0d1WTh2NzBXNFRZTy80WDFid0ViaFJ0em9yTStPZDBXS3JC?=
 =?utf-8?B?S2FhcUgwQzNReXMwREkvME14Nk9NWlJHVkFVQmc4NWNoc0VLZ1NhOUNWNk95?=
 =?utf-8?B?cjMyS2NWZzh2UFBOcStGQys5cFQyUVJDSVhFTHZ3SDVHa0lKdEJVeW9mREVK?=
 =?utf-8?B?UnVGNVhBalpmQjdBR3hXYXR3QmtMekM0TGlqTjF3MEw0TE1oallMT1hVMmtl?=
 =?utf-8?B?TlQvL084aUc4Rm9JeW5xVFNxYXJBMDFRcTlXL1FjUi92RkpoWERmZTZtUTNt?=
 =?utf-8?B?T2ZKelNiRVA1cWJ0OUdWbjFxT3pIS0FFeXR5SDgvY1NHbEFsZVdybE5SSzRp?=
 =?utf-8?B?OGdjMGJNZHFvdytWM3R6Wk1HbFNuR0NSL1Y1RVcwWThEK3JEdzFCVEJ0ODRO?=
 =?utf-8?B?anpCSWhDcU00TG54STBSL1NML3J6S1lxbUEvK0pXUUViNkhoSXExSmpYM2o3?=
 =?utf-8?B?SjYybWVQdTcrc3cvWkdBYnVCaHdBWG1QWUcvc0FIZytvSVhNQThLZmdxTUxI?=
 =?utf-8?B?dTdITnVxMWVDVTV0YVpkUC9lYm1oZjRkNXRUdUFvcDhQMUh5V1VSN016Zzlk?=
 =?utf-8?B?YkNZMmxidnZ3aEhkSWFwckR0dWNoUG4zdS9MV0tYbUNNQ1pQTkl5YWYydnU1?=
 =?utf-8?B?MnRib1I3RXVxanFTcHR6K0pkZ0hWU1p2a2E3U2kxVnpiODJUZVpYaGpTZjZK?=
 =?utf-8?B?OUgxbDErVkR1OE5iYUh4UXQ0VTF4RkxLM0xiYi9SWVdmMFI1WGlVcGZjeGYz?=
 =?utf-8?B?N0ZyNEs3UDJlMnRVSnhWOUM1c2YrM21tSGo1Z0p0NTE1a3UrMDQwZTMvY0lm?=
 =?utf-8?B?NU51SkVCaGk1ZUpJelZuOGc5TEVrdmo4RCtJTHovbkpPM1R6UGRrMDU2czIz?=
 =?utf-8?B?cjdjbEY2YWVTUDlLV1o4UnNRT3ZENFJMTTlPeEdyb0lvaS93UkJNamp4YXJJ?=
 =?utf-8?B?Q096b0ptSnlpemlScWcxMVlERU94V0NQcG5tL2lYSDFteXh2dDZha2RjcEM1?=
 =?utf-8?B?UTNMMnl2ay9YcW05NE5wdE5QbUhYVFVBUzF6MFE2d2k3WVlXZXlHY3JEMzVG?=
 =?utf-8?B?emVGNURxZmxpRUVNcXRUdW1NbVAwdVkzSzV2RVhZcVI2eDhnNU4xQWpPbVF5?=
 =?utf-8?B?czJTVm9DLzNpTmFkdVk2T1A2Wm9LUExhUlZjQWR3WERGYVFXbVduUlk2V1Qr?=
 =?utf-8?B?T2JXUnVSNURYejd5dFg0VUlySHBlSDBTVklTYnoyTlJFTDhQUzRuaUE4enpl?=
 =?utf-8?B?VTUyU1ErQ3pqRFRWdU5ZV1hvMDd6SjlvYTQyRmF3ZVRXK0owYVBvTlZWMFYy?=
 =?utf-8?B?OTRnRnpPMzMvQTFrY3lwNXQwOW9wRnBMNCtkVXptNVFBWjc3THZVcmo4R25Z?=
 =?utf-8?B?dGVqMWg4SGpKUHFLNUZhZEI5OU1lcjQyZFd5ZVlkMzVzTjlBT1pJajJsT2ZL?=
 =?utf-8?B?UDc3MUpXb1hrSm9UUlo5ZzBMVThSRXJYYlRwcWVHUnh1UmhXcThOQmVKTHhy?=
 =?utf-8?B?eGhWblBubFROTFRLMmJ1a3VBVXE3cmdqUElzL1VwU3o2cnIyamZWWGVSV25C?=
 =?utf-8?B?NjNGTmlLZmpCb3EzMWZvcGVqNk9NRE9yVDBWa2V3Y1Nmc28xZUV3d3piK0Zo?=
 =?utf-8?Q?bUlKPoKprU+EP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXBPMW5sZjU5Z3hqY2ZxUFJNd2d1SFVNSDA3czU2b2dDT3lRSnNia0dYV3Fm?=
 =?utf-8?B?NnAwWHJSUTRkYk40NjJzK1lBQ2dMblZVMlNWbUwxNnFpbktwWitqZndvc2xH?=
 =?utf-8?B?SUptWUZjUlNFaTRMZFRkc3hOYjRsZEZaNU5XNnN3NTBZdmNhZlVZWVBncm1S?=
 =?utf-8?B?Z0ZmQlFTd2lKUk92SGYza2FJUFZYNWU0NnpoT09IU245Z0dFZzVXSzhrcitL?=
 =?utf-8?B?MGVPL0xXdWdQWjVkdnFuZU0waW1oQnNKL1lLTUw3UlVUcHpqaE9sMkZaeDU2?=
 =?utf-8?B?amhTeVp0NTRZdVlCOHFwRE5OclY3SDN3MjBWUmovRUY1OFh2ajJsQXJ5WThT?=
 =?utf-8?B?bVl4ZithNDFkZzlSZFlkVGY2Zld3dVdPa04yNm5hWUI4eFAwV3lkeDB5SkN1?=
 =?utf-8?B?dUJva1Z1bFN1Z2UwRUk2SnpjZUhmZFRFRklGdjVPWnZCQWVJUUUzZENLNnJJ?=
 =?utf-8?B?M3RaQkd5RFVpS1FHMTczWUFIVTBZd2pKd0cyUnFTTUR0aUV3Vkk0cFBMUSt3?=
 =?utf-8?B?ZGZTY253bzNxUGQzZDZZWUF3THRrcVJXSnV6SlRrZlBjNEc2M0p1U3pJYmc3?=
 =?utf-8?B?QU5yajUwVTYxdjVYQ2Vmd1lmSjRPNkdmQkVUMWFlenNqeGgrUVB3Q0taQ09t?=
 =?utf-8?B?V3hST2MwNHRuUmN5S2laZEExd25kOHFZTW44dHg1RGQzSUs0QVVJM3dPZXpw?=
 =?utf-8?B?c0tVY0NOZi9tOXF2RlNuSWdNMjFiRi94ZXBCb2FiQ0ZHc2I4VGdaYVgzbTFU?=
 =?utf-8?B?QjZTVXBqQS83RWhremx2ODg1dVVGZDFQNmljZlFJMVFoZWlVUFFFaWdPVnFk?=
 =?utf-8?B?SFJsTngvL2swQ0ZnMUxoZEZiZEJuZDYrN2R3OEF3SkRUL1pERVlod05TcThk?=
 =?utf-8?B?elpEU3Y0b1FVR0RTQStWQUdZdXhjWkErdkZDaGIwMkRwUERFQlM5cUtESTRH?=
 =?utf-8?B?NFV5R0VVOFpCRTRTczVvUGVXN2hKQmMyODY1OENuRmptdTZocUplVHlmR2Y0?=
 =?utf-8?B?ZnBRcUxMOU0xdkxUUGtud2phSTFFTmhZZ25UdHd4MWVHTDNVdEFhRVBES1E1?=
 =?utf-8?B?akhqNi9ET3FzY09hdHAyaEZTQ2x5NGVpRlhHd3dPRExYQmkwcURMZFkwNjVO?=
 =?utf-8?B?TTlpL1lxZm1YOTZ0Y0dvWWQxTFppWHNsRjVWNG5FanBXOXR3VEYrbFk5d2pU?=
 =?utf-8?B?SHZjM05XNk5tZFZFVW9PSXRUR3NMancwU2h0bFhwelFzd3FTQUdQbUFERUFm?=
 =?utf-8?B?N1VOQnN0NjdMMXVZek5rVkRGZ09SdjJyMFdheFZtLzI3UFMxUHptZitqenpj?=
 =?utf-8?B?MTF2Q0tVWXlmU1Q3d0RmcE16ZUZFODR1R0l4ZUhqRHhRWDNwR2tnRFBLTTNK?=
 =?utf-8?B?bHV6YVFuZUM5YllOYm9KQTQ2Vms4MzhJa0dyQzhaa29ZaWxlbmFXNmlJNFJJ?=
 =?utf-8?B?OTd3OVJPOTNKYmtLb0JBR0JKWVpxNjRFY0tHTXJwbFZYNG9YNTFBbXdLYjAr?=
 =?utf-8?B?MHl2aXJPUnk4NGFRekZLQW9XTitmQlZubStvYWsrbW9ZdDIvTFB2OXBGNnNl?=
 =?utf-8?B?NXJ5VnI3NlBNbWNiaS9EL2N3aGs5dldFWC9TYVU2U2J2Y2U3bzNLRnZDanlY?=
 =?utf-8?B?SndkdXIxLzdxdk1jdkQ2REF0TnQ4aXc0cWU0c0NLSVYyUFRIcTU4UUFqZGth?=
 =?utf-8?B?WGNHVDFyc25KS3pyNElqQkRvVjEybW5wak0wOWJJTlRHNmYweitwT0tRU1lD?=
 =?utf-8?B?MDZ2VFo5Ti9TeTFtM0p2ajNaY09LR041cXN4VlJmTE9maGlzT08vbEdDSG5U?=
 =?utf-8?B?ejZyK1BVUVp5bkFyUUNtN2psWU5BWGc0Z3VpQ2Z4WWIrS1NHWWdYbW9hR09Z?=
 =?utf-8?B?NGdEQzJiOXVDSmRqMFZ1ZkQ1eVBidGRpK3Q5SFk0TjhwczJBTnp1RmQyYWwx?=
 =?utf-8?B?U2svWE9nczdNKzZkRXYxM3B4TE5VcUtKNlBKNm1NenBhTERWNlZLVEk3dXIz?=
 =?utf-8?B?bDNiWWtoRTNDNVJPOFpoNGRVeUdoY3JyM1pOY3IxcVFBZE5iMmR2Nk9iL3Vs?=
 =?utf-8?B?MnluNmxpNHdHWnUrQmk0M2hqU3lGVEVLUXNrVk9VbEN0Vmo4UUQvQWk5SFA2?=
 =?utf-8?B?c1RoR1FUVGlGdmptSVRqeUVWUUQwbE9PUkFPYTM2WHBIektvUjllQUlNM0xi?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee0368e-14c3-4aea-c816-08dd5135020c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:30:27.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2psvhnP746g4oungRmgdABa4ZYx6LRlUz9V8PFHnWrm2BBWuPqf8WKhA+atVVwVVoVLDButEzLdwAecJ1Z/7388Z7+9B9f/85qVEO2ixFPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6783
X-OriginatorOrg: intel.com



On 2/15/2025 6:59 AM, Simon Horman wrote:
> On Wed, Feb 12, 2025 at 03:54:39PM -0800, Jacob Keller wrote:
>> From: Karol Kolacinski <karol.kolacinski@intel.com>
>>
>> On E800 series hardware, if the start time for a periodic output signal is
>> programmed into GLTSYN_TGT_H and GLTSYN_TGT_L registers, the hardware logic
>> locks up and the periodic output signal never starts. Any future attempt to
>> reprogram the clock function is futile as the hardware will not reset until
>> a power on.
>>
>> The ice_ptp_cfg_perout function has logic to prevent this, as it checks if
>> the requested start time is in the past. If so, a new start time is
>> calculated by rounding up.
>>
>> Since commit d755a7e129a5 ("ice: Cache perout/extts requests and check
>> flags"), the rounding is done to the nearest multiple of the clock period,
>> rather than to a full second. This is more accurate, since it ensures the
>> signal matches the user request precisely.
>>
>> Unfortunately, there is a race condition with this rounding logic. If the
>> current time is close to the multiple of the period, we could calculate a
>> target time that is extremely soon. It takes time for the software to
>> program the registers, during which time this requested start time could
>> become a start time in the past. If that happens, the periodic output
>> signal will lock up.
>>
>> For large enough periods, or for the logic prior to the mentioned commit,
>> this is unlikely. However, with the new logic rounding to the period and
>> with a small enough period, this becomes inevitable.
>>
>> For example, attempting to enable a 10MHz signal requires a period of 100
>> nanoseconds. This means in the *best* case, we have 99 nanoseconds to
>> program the clock output. This is essentially impossible, and thus such a
>> small period practically guarantees that the clock output function will
>> lock up.
>>
>> To fix this, add some slop to the clock time used to check if the start
>> time is in the past. Because it is not critical that output signals start
>> immediately, but it *is* critical that we do not brick the function, 0.5
>> seconds is selected. This does mean that any requested output will be
>> delayed by at least 0.5 seconds.
>>
>> This slop is applied before rounding, so that we always round up to the
>> nearest multiple of the period that is at least 0.5 seconds in the future,
>> ensuring a minimum of 0.5 seconds to program the clock output registers.
>>
>> Finally, to ensure that the hardware registers programming the clock output
>> complete in a timely manner, add a write flush to the end of
>> ice_ptp_write_perout. This ensures we don't risk any issue with PCIe
>> transaction batching.
>>
>> Strictly speaking, this fixes a race condition all the way back at the
>> initial implementation of periodic output programming, as it is
>> theoretically possible to trigger this bug even on the old logic when
>> always rounding to a full second. However, the window is narrow, and the
>> code has been refactored heavily since then, making a direct backport not
>> apply cleanly.
>>
>> Fixes: d755a7e129a5 ("ice: Cache perout/extts requests and check flags")
>> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Thanks for the excellent patch description.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ...

Lol.. can't get anything right this week.. Just noticed I had already
sent this but forgot CC to Intel Wired LAN, so it wasn't showing up in
our patchwork.

