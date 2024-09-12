Return-Path: <netdev+bounces-127934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62E097715A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB7F1F24999
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE031C4602;
	Thu, 12 Sep 2024 19:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JE5Ar0EX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED91C3F35
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168424; cv=fail; b=TvKoH6AuurxdyAaAgGPoE3Gogq1MtdeGUibNiDEmdr2RDYLKlmz0JYgI0ohOwp5rTTSaPAuciRsNYJ5LJoCWxNdrMVpZz+WGZWkyVUNxwV2puc4+qgkmv7hjaa1S1B5J62dNAI7M37glutZNbuvvIMJ2Z5VxcTBPWMVvkr3Satg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168424; c=relaxed/simple;
	bh=EuikWsXfUqSq3YldYi+V9UfJWpu9S00jyGkKkLeOlSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iqOYyM/+PIRTc0PrOObXOnKy4G5xc/Kya4cIc0tdr57wg2+UlOsW2Ct3rBj6K0rd3lyt/vy9GMsDbK6YQsinYRuJdHqZuGFfv87qBHWh0xV8oxdJ7sxlZxjwZMR5U4RPaTaD90G5J33VDn9ENyA4KxLWjxF6WkpFD0AVJQAdSFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JE5Ar0EX; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168422; x=1757704422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EuikWsXfUqSq3YldYi+V9UfJWpu9S00jyGkKkLeOlSU=;
  b=JE5Ar0EXTqDgLiCl9MZOg2KvNsBgjiFHJLB/NtsOlD4yra2VVeqcFVRl
   eX0cyAUQP0V2KPOXdUowcpDFZRD89KLyhrTDyG3SQ2EiWleuyGATddYKg
   h4EClVEN0jkkoiBlhOwAt+WBO/JIjS+4njmjLxlF9B6x8qMSxdNlawA84
   anSkp4PmtYHRZBHNhIkAuUL7VgDs3qFDWztYhIJdvIEcaonj0ujee6KtG
   exNgeTAKKem+RV74/s92CzgM4JB5c52H9w/EgGPouE0yanX6eakSdCv9A
   wEiam2f91Dccxda0WBUrooTzMTgxwbh3HFWJyrR90f47tNQw5OlfTxbIz
   Q==;
X-CSE-ConnectionGUID: 03178mXUR5Weeb+9wAAy2Q==
X-CSE-MsgGUID: vir7jgoNQQGtMPwo8BHLXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24534224"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24534224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:13:41 -0700
X-CSE-ConnectionGUID: J8kb5HkCSo6RJgcGD9BGQw==
X-CSE-MsgGUID: i4MTRsQYT3O0YMprl+bnsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98621915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:13:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:13:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/gWhUB6Xbq2rVZ0q5QEcT2xDkSlfgtL9Hfi2zg4WTSFfbfPUvym8ONRFi3eptkW8gthesIZqnvXjMQFlDDS9JWCqi9+2fA0NHrStdqH09qRXC9vEbILkdwl9ICJhedj8ub7MG/O8cNe3vDss+LghkCWNq9HuL2z4cBD5Gi+d0H+mibQnjsH0nbT2V7KOkBOFIc5332p+7l+zBfNYO894/hogxrhxv27mDBcuoWPub9C9TdF/a7pDH3ac9TDv7NyAWobcwFe4y4WipcTMv3OJ+v9VwWnZdJU8+vjEU7KNU+EoVweSain0xc5Ng/W/nkWnFC6UzIGobxiu2hx2Dawew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUcOmJGd6fn+DGDLpH99hhS3oz65jEMCSjZJGNfOu3Y=;
 b=W/LKdn3O11j7wCw6ET0XX6ixZ0LrxeQO3aP6poH/uAERhiEI1+e89X584S/u6DqLzMWrnxbiVVaRt/l2bLr5icf0IMlaBz0/rUBgcaM3VZvjrz28w+TdNm7zhNTw7oRVTe4npK91FY6UbPvGqkmlUt6bl7iiVnvdZiMYLZ2V1ZtzgORJSwEamGVqzO0l5zsbRIEH4SRZZ9ZpKxADJN7+9BqZyXpNZpofK1/fU00s7KzJeeO6ZPO9RHuAar2Z5pqZ5AmA2JUmnFWexOopare8earxY3ipSMAUiQF8NVZGTayF7M/urdzxCqD/dWGVeQuIoiBpRu7KblkXa74QbCzSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:13:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:13:37 +0000
Message-ID: <6835db01-cfa2-4606-be1d-8448b30a2e16@intel.com>
Date: Thu, 12 Sep 2024 12:13:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 12/15] net/mlx5: Allow users to configure affinity for
 SFs
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-13-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-13-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 032cfd92-615f-4aa0-472a-08dcd35f00d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2FJdVZ0N29YNG9DUWhhVjJZRmcwS0xnWXdtWjdiVWRwNXZRRGxucVJsRlp4?=
 =?utf-8?B?T0ZZay83bFFmdXRyZWc4Q2FQbk1EaWxWaGtIN0lLUjl3VTRVL2xhczhYWHYv?=
 =?utf-8?B?RWVwcXZKVFM4R3ZZYm5XT3V1VGZSQjJ3Z2UvalR3YnljYkVhOFpvdzUwYm5T?=
 =?utf-8?B?bFlOK0hIODB5R1IyT251QUwvdFVkWHZSdEE2VGhGZmVUSVljOGZ5T3ZJZjBF?=
 =?utf-8?B?VmFJMnQwVmFOR3E0USsvV1Y3ejcrVWFzNnVpcjlFeU92UVdkT095dGg5VnFO?=
 =?utf-8?B?d3FzeiszMVhwOXJIdE5zaVJQdkpBdXdWeXBJOERBRXRXUGlLd1VEU0lPZmgr?=
 =?utf-8?B?QWQ0V0pZUy9kaU9wVFNUT2EwV0tpb05STnBsc2VaNEJwVFcreUhmVDFMSXh1?=
 =?utf-8?B?bklaUXA3VzhQWVlZQzJzeEtHeGphWW4zUWt5emVSbHM5bUNabEt4UkYvaFlt?=
 =?utf-8?B?cXVySS9VWEdkcTVBVFdtdHlpV253emtKZWtpTllTRDVWa0FSQWhIbk5Lc0ZP?=
 =?utf-8?B?RHEwWVQzaytKcWRBNzluc2hPWUFPcStpOUcxMCtYVHR3WTEycVdmK1pockM2?=
 =?utf-8?B?SFZsb0l1N0FGZm9CRGYrdjVLRUx4Yzk5MGNvK1I1V2VVck4zdzJwRjZQTllj?=
 =?utf-8?B?eGhEQ2xZcXZTY0YrZ0JjRGgwOUo1U2pZb1RpVU42aDdMWjhPUU1xcHFZZkps?=
 =?utf-8?B?bHFwM3BodU9uVERrV2JHNWRJdXFLQStRZlVTOVUzZWRhYUxkNW5pZmVTVlNX?=
 =?utf-8?B?QVNvcmxWS0RpU1lURjJrTGw0b0NyS0t6dTNkYURsZ2tTQWRTM2VPOGlrTnh5?=
 =?utf-8?B?aXVPenFENEcvQzFZelVxODF4dVdUTVBDRkFmeGdzKy8zTG94amdqRTZhWWp2?=
 =?utf-8?B?emx5a01NbUdGdXlDc1NZNzN3aUpycEYvQjd2cDQrU2hyZ0s1MW45YXNnSmJS?=
 =?utf-8?B?OGdOMmc5QzZDZzYzcHI1M2xKeVVuS0pFS3hYbXlUb21Kd3lhbjhtVUx5cmNr?=
 =?utf-8?B?aFlaM2ZVKzNFT0tPN3dObXZqaFBOY1R6VHdhQzJyWWR2TVJORitHQlRvN2Jr?=
 =?utf-8?B?TkhXNFh0MnJSMC9iaFlpYlg3b0c4VjkyaUUwczFqNjJnVlZvSjhvWjIreWE4?=
 =?utf-8?B?Y2tDL3o4K0tacEt6bFFUMWVYTnptL0trdlJmaGdmSVNiR1FQYWRYaml2UGZE?=
 =?utf-8?B?UG1vV1NEaks1cWpVMlNaRzlreVZtdzUyVDB5bzI3WHJMZE94Z1BnMzE2MVd3?=
 =?utf-8?B?MjVDNGluODdZMU50RmxqQkcwRDQyaWxyNVZwd1lzQUZPWTU3VFhibFVqQ3lH?=
 =?utf-8?B?eFFXaVJqblU3ckFCN0ZXSkhqMGNqVVVVSkNGRnJPRGNZcXhuZm5wYnB5c0lI?=
 =?utf-8?B?MFA3MTZNKy84WFZ6QW03RHdIeGN3QS9hM2tHd2UwbENhYWpCOStNTUtobWQr?=
 =?utf-8?B?aXlRcWV5VWNDSi9PNTJVamZPeHM3bC9XZytySXpIemd5d0NaRzJwSjVUYmZJ?=
 =?utf-8?B?UGJNYkhkY3lHbCtXcVBwS203bncwU0lHOVh2RmlacnRkRGkzbHBuRlVpWnYz?=
 =?utf-8?B?a2tFZGY0VVdDeUd4Mnh2SDh0VVZ5RExuaXJGT1FpNDY3RlB6RDZ3UzFEdlVT?=
 =?utf-8?B?M1JXU3JiOEZia04zcmtMSXlLUFkxeVpTd3RTenhUbE1SU2FWNjZsbTVWRHRR?=
 =?utf-8?B?RkJtMlQxSGs5ZHFINkVQVjloa1JVQm1qUjEyaVFBTDNPb1QrcitvN0pGVk1M?=
 =?utf-8?B?TzVsa2pyOXJnRDF1NDdlb0czbWo3YmZrOElIM1VxTnZkZStVdm5lWmtncTJN?=
 =?utf-8?B?clJzRWxKWi9BNHZvdUhCdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjVwTkVTdlFwSlV5T2hZV0hQbzM5TnNpbVZUaGNIZm1rcTdhLzdsUW1kNHdy?=
 =?utf-8?B?Z3dQdHQvU24rYXkycXZGNFpHSE5JcjZ4ZVE1YVQrZnAybUw1Y1BtYUhRRXBU?=
 =?utf-8?B?aU5vS3ZnZkMrS01IRUZLNHRyNzg1cHdTNUw0bHZXL0QwQmxRdzhSc2VGcFln?=
 =?utf-8?B?aVlrclYya2Vna1k4OCtOQnpoUkt0SExJSzFYc01qN1MyN2dSTnNXU0JwRis3?=
 =?utf-8?B?aTFPVit1RSs1Y2NJbjI3ZGE1SVVhYVR6MVJONzhmWG5HWStMUERLUFlFa2Fx?=
 =?utf-8?B?NVl5YVUzK2pCbTdJQmpKYXhLQTF5bWlzYTJyUWNlSWNLWHBhc3JZSFF6bG5V?=
 =?utf-8?B?MEhobkNBY1AxWEs1MURWTkh4SWhDV2hEUXlDOHU3WW1hVDBDblNMMzBtZHRH?=
 =?utf-8?B?WDBVbmQzMWF3dXZvc1JvTGJ3T3R4UnBCUHRPc1lOUU5zVStpRGxXdTdTN2pl?=
 =?utf-8?B?MGxOSnphRnNQakUwaldUOU9FcHhRak9hU0t4d2lTZThHUWJpWHdxN2ZJV00w?=
 =?utf-8?B?RmFLRDlzMU5FbklHMlU1c0Q4ZUhMMnN3ZkV0aWkvWVRHM0JsaXNzenpMOWxu?=
 =?utf-8?B?Zm16QWdWMkZ0Ni85SlB2R0E5LzdIc3QzbDl3UzllM3NrSTZjYjRjMndpZDRJ?=
 =?utf-8?B?WnU0a3FiOVNZTmtXbGN0NFNXTHg4b0pBbUwxUlV6U3NiSzRreHBGa0x3S0wr?=
 =?utf-8?B?bzJCYXU1cW5pK1A4MzA2ZHpZWkxENllGZHE2cmFhcWhJTjRQbU1KbksreGk1?=
 =?utf-8?B?dUZHa1Vub3BGd0QwUXhudFdRTFdHUUc0dDEzMTRTd2c1WjZjOEVhVi9ZTFNv?=
 =?utf-8?B?a2MwK0RHOFRKN2QxdmdxOHE3b2ZkYnE0RDV5UEUrMmlBTnhYczBldTcvcEZ5?=
 =?utf-8?B?aEJjZjdSdFVrWnE4dlJKaTQwL3QwckJFbzlyRWlFWjZIbmZ4aFB5YmdZYlE5?=
 =?utf-8?B?WVM4Y1hXb0dVaUV0NVYybmJYL0NHZTg0UW5sK2hpekhZVmRFdEo3aHNadnpQ?=
 =?utf-8?B?WWJtRTJsclFKRU14ZmZPRTVvTVBzTThlekdxaldLT3FkbTlVV3YrRlpvQ3h2?=
 =?utf-8?B?ZzhRUnFIb1JCMFJlUzd4K0c3L25HbkFQZkF3T085VHdxeTd0akU2SXVONHlC?=
 =?utf-8?B?Nmt2YW92aHZ3NytOWFdmbUkyazhySkxGKzdoQndoOXVSMGdmeHhKZjJBeDJa?=
 =?utf-8?B?cUVQUHVrMDNvSEYvbHJNMXVQU1dwejViTHNVTmRtSituenorUFBaaUZ3dlNy?=
 =?utf-8?B?WXRJUXlUdWNBTGRxNnpaM1pXRG5aWmoxaVhLeWN2MFZMVmhLa042M0lFQ1lX?=
 =?utf-8?B?OU1QSjNSSFQ0TlBlZ0wzdkkvZEF0QlVhcEtQTEYwbjZBc0didW0vMkhqaFJn?=
 =?utf-8?B?OEFmRVpWaUlOTjVUWHo4M0RBREFDdld4aWw1MXhCNDRXeVlEbU9pVjQxUURL?=
 =?utf-8?B?T1Q5SHk3eU5zSDU2NDRaeVZzbEt6R3JzMG0wVWp3R0VHSSszZWt5Z01pNnQz?=
 =?utf-8?B?TzZaS1JZZ0lhOFFhaDQ3T3VxUm9tTWVpcVFIUnd6VTFiYlo1RkVYWmRIaWZ5?=
 =?utf-8?B?ekVING5sRmZxa2tmU01Mc1dRQnNJSG05Wi9LM1pLM2dPbnhtMm42RXpTVkdD?=
 =?utf-8?B?c25ob1lJRnlsaVpqYUNDSk5vQlpiSUlqOTF2RWF3OEtFelplUTVTTjA4ZGlL?=
 =?utf-8?B?UXVMbjBoQkxyM2tzQ2F4TTEyMzMzeEF0SGgrL2VlVHJtdHhCRk5sa3gyZTc3?=
 =?utf-8?B?d2E3QTR0elRaTGhpWVZHNjRCUU8yTjR4UXhJK2J4NTFaR0lHNVc5QVdYZ3A5?=
 =?utf-8?B?aGNKdkZvcmVsOGhGYVFiOCtyRlM3bGF4ZitjWGZtSExiZHZJMUZkZjNFbklx?=
 =?utf-8?B?VUlhYkhMTW1IUnpuOEhLR0wwTExvUnBaeGNkVDR0V09jWDVXaUI2UGs1aXFm?=
 =?utf-8?B?SzJsazZ4aWR5dXV3ckVkZGZEaGx1N2JGTXRYL2xqazFyVTRtY3lRMUJLMko3?=
 =?utf-8?B?RElvZitURHE2RTN4L1pNa0FvMTZESExkNWY1Vy8xSmhpM3VHT2tmZDZKWEtC?=
 =?utf-8?B?Qld4WDRuSWUzeTZ6Y3pPd2tZakJBTmNMNkh4am5heVFWbklNc1ArTG5XMFQ0?=
 =?utf-8?B?NGlyQTN2alo0Rm4zSVpjYXZIUDhtZTNpcngzNXVhSytpNzBvMVNhUTFNSnZX?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 032cfd92-615f-4aa0-472a-08dcd35f00d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:13:37.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AesK6R3ICG9rDnwPQ0VUmsRjgW0GhkwM+bFr4j3UrWxYsLyHvYuBC+uis+3OTPO4d+cSY89+OT6cmM0qrARvNTibyCCoQ90yu45NuEniQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> SFs didn't allow to configure IRQ affinity for its vectors. Allow users
> to configure the affinity of the SFs irqs.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

