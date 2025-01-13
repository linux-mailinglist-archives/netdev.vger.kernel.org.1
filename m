Return-Path: <netdev+bounces-157854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B81A0C0EA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F511883B71
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6014885D;
	Mon, 13 Jan 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlOmQmQs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16761CCB40
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794828; cv=fail; b=Aw5Puywl/jDw2LmFdFNUEP6eeY2ZCulkxm/cuZ8pB25Ii8+YRbDZIOY7Mgu1doxeTdzG6YSMwRBlYHT0iyjUI2ppdSPqAjRHTJIJ7VOHjFVPUkLRooV5kjxcXHOuvRM422FPB+mzCbNVOLmm9kAqL8eAVjPRuK45IBq/BSySujA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794828; c=relaxed/simple;
	bh=nyhFLhCYq+/vhNVjIjLyNdlznkqs6zeDVxwCv72Fq/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dldbXlhpV2WvCOirhyX4L3KpQfwM9/+/6peHjzwbxjkQymOG+4O3uAfHmfdawX1ar1OJngHuWWFojdmur0WjLv9dALfQRIH8+IMA+QchXV9ZxA8hrzwq0ZCPo6ssSsHtHSNdBmXF4c+rdjUnn8F560G3VoC+TQpX6ciSxkizbBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlOmQmQs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736794817; x=1768330817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyhFLhCYq+/vhNVjIjLyNdlznkqs6zeDVxwCv72Fq/Q=;
  b=TlOmQmQsbSD5JNNJ/s7WcmaczyDUvFyL7GSHPC33hEHW/xIuOS7+gkbg
   W0a4eD7GST0AIh0oJz23ivIytXTStc4iIw7Um9j+dwiQ4o2ZBWxId9V/r
   8q+RqYAnONOHJLX/L4qdwR7mIZcpTzDtF+j/BZ7/fs8ZOK48MTiXmLV0p
   xfbt0v9/d4D/C1itfjYHsnFChRF64B/ABLhJH3nyY5HNKLNyXiMh7VF0j
   N+4rSla7S9jgsB0ANlOFAoAbTQkhDfwUVcxoHqiHoR0X76j+8H0KOF6FZ
   uK+QiAUp9RuY/0wSQN4OwB1TbOhWMkbu7gEGO6wN/pu5Nlm0lRKjdcW6n
   w==;
X-CSE-ConnectionGUID: 7EKLwBQGRAeOUs4H1RuxUw==
X-CSE-MsgGUID: EvK/TpEVSkuGXx3TnDJXBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="59558475"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="59558475"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 11:00:16 -0800
X-CSE-ConnectionGUID: zk3JJTu4QNe1f6/yQh034g==
X-CSE-MsgGUID: Mw6AXDa7TIqdDCCSNkyTqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109548640"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 11:00:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 11:00:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 11:00:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 11:00:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8nd5IGCd0UfTz7WFfLc7YcNpD5bYPrGlD8WSq7VK1eccK+qUQ7PjjDsG1DmkSNZoe2ih/EpMNdHQrBVqaQnPGG/JAp4kZQeso2WkCpASYV1iE6c82KLQkR0zIGvKk1Xo7ayAH/ZzTETKQPRqaGI9FHQyfipFZbmw1zkORj75yjKim4A+fW8vOsf0veivfNpqw+JzyUjeUvXWLWLMLZtzONvjSFdLx16T5KQSpP3GUADaZnbl2bh1CipF6IEoGDHEFtI9qHgHn4EyD2piUbcqP5kHk7uTGlEGG5mXN5tdTGRMzkvURfRD9OOt2iW44zGmoBSjCmOm0r8t9ycsSyAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8fs9xgQAqnaoyULKaO2bw5rE5MCVrTcXmHNWcMLD3c=;
 b=Uc8FqqAwwq+3y7wCXN3uunwYMtBmezGgBNa3h/UFZuxjP9xwTiSpKuRidYIDQLQurjNPox+47sgFnUPOuF997Ez5emUnTrDWka8i6hqmSRGiHRgEecvicTEcdDXKUbqFihIAza5hygzL3beDpr7vYGljzLcKsSMcX0oYQgRRzCmsqI90O/seq+R9KdCQEM/c9c935suJ8/8ItowVBcORDGGxnibdhvpRbq8Of/uRGTvzfFLsxeCuCfD/iZQ6QjLGlO7RMyptYQ0D8lEcwsDLriX7v002qRqbuLGdr8gKxTIjG/oDBF3PAT6NmDUpxUjqaHMNPAc32RN/KWdusDLGUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:00:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 19:00:13 +0000
Message-ID: <da99b127-878a-4acf-b2b4-8ff7c41e1fe6@intel.com>
Date: Mon, 13 Jan 2025 11:00:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] net/mlx5: SF, Fix add port error handling
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
 <20250113154055.1927008-4-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113154055.1927008-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d9c9e23-be40-400e-bab4-08dd340482f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVl5NGpHQ0RDY0hPckU3VWdnc1ZyMVdObmQzQ1VxSVE3VmhaSzBSSWJveVVt?=
 =?utf-8?B?dm9SVVVXSXNCQzYxemcrVTk1RE1XVE1EaGJ0S2dCd3JYVUgxYnN1d0owMVhI?=
 =?utf-8?B?Tk1GeVg0T08xazJ6ekNuWGFLTDJzc0JIN3J3Z1J5bFNMVVU5K2FsM1ZINmpt?=
 =?utf-8?B?cTVKT1h6RmNLOEJaTGNrNWREZkdPZmNRNzFOdUVwWXVWUUl5Z0JWeGdhNFJs?=
 =?utf-8?B?bUJRUlVtYnVaQUlrbTdYVUM3M2RWdjh3UEkrOEx3NkN4blY0NFVXTGJKamZP?=
 =?utf-8?B?YUJ3dEEvVlpPUzNCZC9QSU0ySmZyZU1BdmtQTjViSnlmTXE1OW5MV0pJb3Az?=
 =?utf-8?B?dHJ4aG5CWDBaNzV4NlpnQU1qTms4d0s1TXd6ZFBjMWhWM1BhVjhVeWJVMWFY?=
 =?utf-8?B?NHhXVThjYkI1cW9HUVFnQmZmSE5qUkZIaVVlVVo0ekJOenJOdGhLaSthNzZm?=
 =?utf-8?B?M09EUDd5VFh2MTJWTDdBWDZTNkFGd3pHcWJiRzVZL0NKTU5NcFRLMUtQOFRz?=
 =?utf-8?B?R0xLTmU5aWVERWhIeDZLcE5zTC9UdS9YckNmRjBPZStLZk9YNWEvbk9pY3dV?=
 =?utf-8?B?UDYxRXRJY2ZncGlKQmNzZHBvc3g3KzljODNOTDQ3V3JhYms2a29pMmpyODVI?=
 =?utf-8?B?aC9TaUpuZlhlcEtYRG9GaHI5Q2JDUERhZ21QNzM0VXlJb1lBUW9ZWXRVa1ds?=
 =?utf-8?B?SEQybnl5RjVHWXd0Y0lrRi9ONE04SnZqODdjWTFMcS92eE1CY3VQSVdtbUZF?=
 =?utf-8?B?RDloVnArM3czaWRkWUpkcXBNWDd1WjkweHlFUXN4N3hFZ3hoOUdnNW80R3VF?=
 =?utf-8?B?S2RjK2NxeUoxMHFITWFSZVdHc3RjMTZ1aHVocDNqN1crS3pETldSTVpNR3da?=
 =?utf-8?B?Uzh6SndTMWVsck5CeFMvSnIrKzBZdnRXVzVDNmVaUlFjMlFkZG1Za1VQZXl3?=
 =?utf-8?B?TkRWWFA3SXE2QU9QMGZYWmt1a0pYb1ZzcS9UcDBkRjUvazdhWStLTitSb2wx?=
 =?utf-8?B?TUREaVVNWXVFMDR0WTNxL0w4QUp6Q0l1dmhpaEZjalVpUUlKMk14QnNZczBZ?=
 =?utf-8?B?TmQwa0RyOVpWT1B3aFhxU08zRUUwU1hGMEhaenJ1Y0JiN0VvTU9PTHNMakE4?=
 =?utf-8?B?aDk3SUd6OTQzemI4c0VBUWM5aWlyZ2M2ZEpPVUErN0JIc0dpMG1DV1pLL2tw?=
 =?utf-8?B?YXk0OC9kQkszZkJBRzBvUDB2SkNXZWlwZmxsUlRKVWZrVHlwdXJ0VkVIakgz?=
 =?utf-8?B?K1BqWHd1UUhkS2p0UUNOcE9mcjRyd3BEcUlpREN0MDM3cXhkdURqZHdwYXpL?=
 =?utf-8?B?UXY1N0QvQTVMdmpLT0NFSGZMVDhWSzFoNCtNR05Zek55VXluTGNDMHU4RXlp?=
 =?utf-8?B?dUt5dUhiZDdaZ1pWSEVqeXUzY0dLTzRKYisrZGhqNVpJbjN0Qm9UMW10eXFY?=
 =?utf-8?B?b3cwWkZUUDFSNUl0TDdWOUxrcVlXNEtucWk2R3VOOXpLdUNqcEhtZm5FNTMx?=
 =?utf-8?B?S1VlNmRlUFA2d0xZQkJCZDFCSEt1cFZqMm1ZMmVqUk5FMEluRDNMWDQ1eEhJ?=
 =?utf-8?B?MEFhZHhkakZFeDFkUzJIRWQ3NENuRE0yRm8ySnhCbGJ0bi9JQnpDaDkzUnA5?=
 =?utf-8?B?Sk9ISjRFU1RpbU5pUHQzZktFRVkxNjVEaWxGZzNKSHRnUUkrZkQ2cTAvUFZa?=
 =?utf-8?B?RlZKRTFOaytXTUZoeFdpQUk2cUZUUWJkc0lCSlBSMXEwZzlZWThQa3ZXR0M2?=
 =?utf-8?B?U3JoMi8yWG15QUVWREhBUkhUNDh5MHZnd0NjNUpXYlZhbXRJUEh6TGNlalNH?=
 =?utf-8?B?RGFGSVdua21LWU1jZDhHcGJpTzdPZGYvd2d0NDBtUm40UlZqQklhWDkrUHBw?=
 =?utf-8?Q?l732VC3RLPhk+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRSclRab2F2cnEzZWF5OXJ4ZklMYVZRa0pCRnNNNnI1OUsrZEJiSUh1OXhI?=
 =?utf-8?B?d3ZjVGl4MW9YdTZtd3hRaEw4dG1ERkl4R2NoN1Rnamp3Z21JYm0zdGx0a3dM?=
 =?utf-8?B?RUV6V0hhVDE4N1krc3JrS1FtMDZjcURobUtzbyszby9hUGlwajc5S0Z0NGkx?=
 =?utf-8?B?ZEZSZHl6cEtod3MwV3crYjVwZmk0bzhHMjFBTXdjYzF3SWEzb0NlWmN5a1Bn?=
 =?utf-8?B?QWxYSE01cEdyWTcrK1Y4bFRwT3FJcUpTVzh3TThobm5nNmZ1T3F6akZuTnpT?=
 =?utf-8?B?N2dKQWVlbkpBTjJnL0RublM0UGpIbFhJOEQ5MjVjalZEVEhPaExDM1N1VXFW?=
 =?utf-8?B?OS9oNmZ6eFNLZEsySkdNV3FFQmg5SjRFODBOKzRqQkRvRS9QT2t5QzN5eTNK?=
 =?utf-8?B?ZUFsUW9vY3FPdldySkt0eGVXRm1IT0NINUxnbDc2MjJnQUpnbmxJeS9ueG9X?=
 =?utf-8?B?YTVhZDVocWk2SjJxSzRMcUtWZ0NkZnNLNlpNak1adXJXYXI2Y3U4WFgrRFlp?=
 =?utf-8?B?WjZJeGY5cGhSR0tmS2gvMHRlZy9iOEJTMHdyV094WE5rWEE5bldsakYzdVpp?=
 =?utf-8?B?OHBodnVyelROaEliMUJXR1V4djAwbHZBd2hEMVFDWXYxeWs2NTZjNURFeGhx?=
 =?utf-8?B?TU4vRE5WeVFCUDRvQ3lpOFoydU9QSnlKYjZ3Z0hsdUN2NnVuaytSc3NuMWd1?=
 =?utf-8?B?STN0NCsyNjhZOW1sNHlaSnoreDBEd3k4aVFKcU5YYzNpNldWYkszTFpmTkVl?=
 =?utf-8?B?U1A2cnZzTjJRMld0YVFHb0NXVHl1YWduNk92VGUrM0R1czFqcitUMEVJcFpT?=
 =?utf-8?B?cWFXSndXTUgvOEdRWXZaRWk0bnQrd2k4alk3ZjJZdzNUWjF4ellWcFJlTE1B?=
 =?utf-8?B?RVNtWFRtSHZUWFB6K2FJeDVDZUtVTlFyanBFKzhOM0R6YnJScWVPaUdjL2FY?=
 =?utf-8?B?S0ZEV2ppbmtGbXlnbVNqbENpUWtEYmcxL1JjbVpFUllhN2luMW9IQmZNODc0?=
 =?utf-8?B?UVk0eEF4cXNEdDdDM1JsaVJjcmNTaG5PZTZoNm1nanc0UHZSc2ZpUUlJNElo?=
 =?utf-8?B?ekh2YlZleHFXREtwSUVaMGJaR2JGTjNoVFVnVVRoMTZKNERjTmovTlp4SE9z?=
 =?utf-8?B?T3l2QTRoVEdlQkFyU29STGNuZzJwM1NkWnY1TmhVTlRMbzhsb21CZnlzOTB2?=
 =?utf-8?B?bC94NEJyVnJFLy9xSjJyeW9Dc0wzUmRBSDZCWDFUakM2SGRNUnNGWXZyZlA2?=
 =?utf-8?B?OTh0M1dCQnMzcFN1V3ZYZXVTYk5nWmpaS2VoZ0pweUtKdlZUVHlPZXlDL21Q?=
 =?utf-8?B?Rks4dWl0NHkzdkR4d0VLM1lNSXdweE9GK0Fpbno0OHc5Tm0wZzRJdkNMaG4z?=
 =?utf-8?B?VEttK0NZVE5JMjNybEpmd2gzazAzVkV4VktTVHRtdVJwOWxsVVBnQkpWM3NY?=
 =?utf-8?B?Zi9TNWdSdzV3MnNFVW5xODNyQnhTcDE1OWZIRHo3SndsWEN2TXEybDFRSmZL?=
 =?utf-8?B?TFQrUDQzWU1nQm5wSlg1blBiMm01eFU0V0dZLzJtNHE3Ung2Q0wvQnlPRVNH?=
 =?utf-8?B?UFVBYm0rRVRHWUJ0VVVGTE8rMjI2Q01tUU84OWVIRG5FMFdQSGRwWkl0T3NT?=
 =?utf-8?B?UG1ZNkRZNm9rRTI3M25iaDVWZkQ4NlV5RzJEaGhqYzJTL2xoTzVlWHJWUWp0?=
 =?utf-8?B?THI1dUhmWjJtdko0ekRyTTJIQjZveWVkNGZMaVIvRDNQTS81dUxXMEw4MTBk?=
 =?utf-8?B?WFZKUVBqZlhsTnRxQk40eTVabWtoYzFHd1ZyMnE4RzNNNDZMS0xMWEx2dE1L?=
 =?utf-8?B?L1UrZDJ2K3gxR3hzQjhKSnVmZitPWTBxMUthRXM5c2dTTG5kZHdCa3NzemF0?=
 =?utf-8?B?SnRuUVY5R3E1K0lsbHNNOVp2SGZraTNlQWJRZmVwWmlsc2lFTnBvVElJeXFr?=
 =?utf-8?B?by9PYXFPQk14UzlNZmhDVlE4TE1BQzV1OWJ5S0xLMU5kcHN1ZkpjVTlqR201?=
 =?utf-8?B?V0d1RkVsTnQ3UXJsRWxwNmNFQmw2dkVSajFTMzFMdmM3aVNwNTdvN0psUGxG?=
 =?utf-8?B?RU95Y2tkSW50d0J0ZFdIN2JUZGJodUE3bzZZWTJoWWNGdnlmY1BtT3hoaUl1?=
 =?utf-8?Q?wDu0gz73g01TJvxU1pzAgMewj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9c9e23-be40-400e-bab4-08dd340482f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:00:13.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhEeA1kBv+rls7LOHEgsCu1s7be2VexfjqfOnfMHv3fBRzkJaoACyC6UvbwPjHzynSchuedDNwizDhOXBejVeoztALuVfoTwHmcFCH3aJWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com



On 1/13/2025 7:40 AM, Tariq Toukan wrote:
> From: Chris Mi <cmi@nvidia.com>
> 
> If failed to add SF, error handling doesn't delete the SF from the
> SF table. But the hw resources are deleted. So when unload driver,
> hw resources will be deleted again. Firmware will report syndrome
> 0x68def3 which means "SF is not allocated can not deallocate".
> 
> Fix it by delete SF from SF table if failed to add SF.
> 
> Fixes: 2597ee190b4e ("net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()")
> Signed-off-by: Chris Mi <cmi@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> index a96be98be032..b96909fbeb12 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> @@ -257,6 +257,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
>  	return 0;
>  
>  esw_err:
> +	mlx5_sf_function_id_erase(table, sf);
>  	mlx5_sf_free(table, sf);
>  	return err;
>  }


