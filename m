Return-Path: <netdev+bounces-127937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC76977163
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744B21C20C6E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D51C688E;
	Thu, 12 Sep 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SP4XUks7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1841BF800
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168544; cv=fail; b=JReCofiWyqaL/5ks/TxxvMwKiAyq5QX3n7IxLFa4eO1pBDc9fr2qyUbXdto6CN4fk0ZqVgJvQXHDnlHLFKvAo3pLjf8+mBnNl777gZwq8iyNhBCnRoHgI86cJIvyeWi/qw00ocS1AsV4RQ8rsGbrQAmN3JbI3j4chrQLgrtOSOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168544; c=relaxed/simple;
	bh=2c45TCB0esd4Fdwin0tTAQAT12krEz0XZ+z8pBzCLVw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLzafrG4dq+vYuWxql7SxziHVDZokAiqrW67W/94K2dodTN4ecJgGsKReBAqD549Z9DXDm6/dRFdLJXWCcz6hL2FH2WTuf584yziCjxLt7KC/4jZISeEPFt9VR4drxaQ6kxvs+ZDf4pFsc/RiOQXFVCFxFOLonlTkAUNmUrGkIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SP4XUks7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168543; x=1757704543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2c45TCB0esd4Fdwin0tTAQAT12krEz0XZ+z8pBzCLVw=;
  b=SP4XUks74xedBvUo/RDmGNTNKsUe5pngOM1wq7bOVFUna/B9jbNgU/Ou
   cplE8dPjxGK8N9H70FIU1v7o0g4T5ljLAdOxux/69S+v6CVWr0mXYZLbr
   ndvZ8PiMxHG9pBUR2W3lKBRs0SDgcI6jdzsWu/l+8zXFTf1LMulto44aa
   TYw1dhaVmY6MnQ1Ucq1CJpuKZZunt0y2Irn4Pu8a9z+qGOuK71EIMFq9w
   S4Q0/E/eRPOYtS1/HgM25m6YVuc0ZkCbqHzTNNrRKpx0cNk3YykacdChR
   Fkz5FiK1Ofp0Suq2ZEQgb9AlMH5ua9jU7lIBpkbts9WaYKuOaF4psJMk1
   w==;
X-CSE-ConnectionGUID: SUt+q4igSoa1GzYTNt23LQ==
X-CSE-MsgGUID: 0bFMILPYTFmsNLli8Tq+aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36396494"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36396494"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:15:43 -0700
X-CSE-ConnectionGUID: +cj2QtbpSymRW+dMOY9U1g==
X-CSE-MsgGUID: BwVmtk4RTpGhQyH3A8Hahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67517611"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:15:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:15:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:15:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:15:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMyH7taLGXHtdkkeXTx+fPmvF3cdw24IL2UkrDTQyfzhctqfeP2tDG5Bcjktv8Y5NrN8mUXv9KyK746xfsOCNK1DH8wJNigD9BSn4FbqGazbILcNzjIP6aHTA31gH8jn5HrQef393B/+hVeyPd3/99F4tb7nPCB7aQ4ieqF3/bVtiL71zO9QL5xRlWfTWCXUpVSWRvoypEFlelIj2yoamnwGjZsn+u+eTzoK/sKxmltcL5iDEIdSYZw4g3vEyRQLzHxNZ6NvBgg98cW/S19qyLIuakiQBkNY1G+0WKkck1gZqjF0qw/X+bB8eRtYStfY/j2A2aBBLI8Uzkyq6d6wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE3puFAHoKHB0nJzO+hBm4IPITfdsQ+BjlnswPn5S9g=;
 b=kO58ENP2+lKW2Angs3MDv8VrPwZco8FYHd3zhJaervDw48vD5Qa9P/8Q7TuixpDUvGPCyLXr/ui5Orv8LBKf7yzTRLrePsphG2cQAoVdpGdlPfsFi1/HDFcpx2KaTTwSr69qAZwVqEYo+c3+n4CgkpiS6GGhUffIY5rcMXe9AjlnpzRVMfdWjFhB65EpvyAi/f9qfphYtIOpXroCyOuJJZ7fHm1tFZY9mlI551ARw4uI0bJgfq1hNb7UlRwuQuAOHulw0c4REf2Ukikd+BAH+sgz3/7xUbdOPqhl19uIvdgMLbYdNmY5Q+WX2cTKYkJIf2JwW1dr7CRt8l29dA6YHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 19:15:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:15:37 +0000
Message-ID: <070d854a-949d-4974-be3a-ccfcd5430e05@intel.com>
Date: Thu, 12 Sep 2024 12:15:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 15/15] net/mlx5e: Match cleanup order in mlx5e_free_rq
 in reverse of mlx5e_alloc_rq
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-16-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-16-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV3PR11MB8530:EE_
X-MS-Office365-Filtering-Correlation-Id: 711254a5-10ec-413c-e39c-08dcd35f488b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGFUWHV2SWt1YW4wY1N2UklpVHFMWXNOQk5RbjZ2UFl1cHdJV3U2eWV3QTVi?=
 =?utf-8?B?TXR6Z2lHUHNtaWlpNWZSYW1MVzlpQldXS3N1M0ZLdnl2aHJQTzZzN25NaXpq?=
 =?utf-8?B?QU9IdTJSSVNRcVJtRUNUR2ZwRDdDN3RzUkRGWm94amU5eThqZjB5V1JYNUpY?=
 =?utf-8?B?MlhHMi9BeG9XeGtGNkNBZUxleStBVVVXVmppWW4yemlZcjB2YmRtQ2VERWtP?=
 =?utf-8?B?ajljT0lmQkxTQkVJNkZrZHZlbHdXSy8wbEhYTDNXaWJoR0xNVUQ5U3NLbkN1?=
 =?utf-8?B?NURYVVhmL0tOYlYyRmJjSy8vTTB4T1lFR3FEcDNvUG45TEhRTWI2QnIyRTRG?=
 =?utf-8?B?VVlkaEc0WlVyM0dNN3pkWTl2R21hTFdwT3NPQ3BqWjdaclZjSXpoMzhwN1V0?=
 =?utf-8?B?eFpkeVpnTHltTFYrcCt0VWhROHVSWjlieVpNeDlsZUFxS2NOb1hOYmF5UEp2?=
 =?utf-8?B?eG14U00wSVY4WWpPOGtETExBaCszd2UzUWF1a1paM0VjZ2tleno5ZUhQN2lj?=
 =?utf-8?B?aHFweUNCM1NnTG9RUkZGdDJIaHRXRlZubkp0RTF4Y2xIbWpVR1V1Mnpkd3da?=
 =?utf-8?B?TUg0RTVFTFo0ODJJcUVVeUhGUlM3L3BYc1IxNlEzQ2RMWkVETnZPRVpHczdt?=
 =?utf-8?B?eitaMm9mQndHajJjOWNUNUFPN1pZSnY2MXJrSmNRWVc2dlIrdFkrQituMlM1?=
 =?utf-8?B?V0szczd4K01RaVYwUFpKeXFRWXJRTnB0QnNERWZOTzRpUThPOVhqZmpEZlUv?=
 =?utf-8?B?bnlYbmJYcmhNZGExaVdYa3FFRWpRRHNJaXkwQmdPbDZOUjFnTkVwZmJzSHBE?=
 =?utf-8?B?UkpLV1h1dGdLdVJJMU4zT0FjL1F4T2RKVVZveDMzc0poZ0wvUlNoOCtZYThs?=
 =?utf-8?B?d1RXaWVEamFYVm5qNk1pcUhjR3U5Nks1Mi83VW5XOXdaUExkYU5yUkJyN28v?=
 =?utf-8?B?aEFnMkk2M2c2NXF0MlZTTjVBY0JQY1FQZnB1aTRNSW9DbWRLWnZTb1FtRklH?=
 =?utf-8?B?UmFDUStoMjZoMlJ3Y2F5Z1NSd3c1clcxNGR3SDg1NW0vN1daVkFuY09jZmh6?=
 =?utf-8?B?RnliNWdHNE1kc1V2cnNLTTBUQ3VIdUZ1eU5mNG4yMXE3UUZjYzlPYVZYdnor?=
 =?utf-8?B?Vk5GNy9NekwzQVphUnZFOXMzd1V0cTBFOG9QdHZvS0IwbXFxNzhJaWJPUGdC?=
 =?utf-8?B?ZVgzTVRSTzBoV1ZRV3ZBVG9XUkpPM0tGUFhYdnh1ZWR0cXp4bXRUZUh2dFJN?=
 =?utf-8?B?VWlxL2NWcERsSWkxNXp1NW4zMkxMZkJmVjJBVmFvZWUxa3ZFL3FPMFpCdyty?=
 =?utf-8?B?cU1BUG1nd0VhV2lwNWtrc2ovYUVRMy9BM1AwQkNoa3U3akljOWxNN2EvditK?=
 =?utf-8?B?VmlaZkxsVnBLSDRHOXJFS3RBWjI3NUJxcWNBcEZEZDhLcFl6T256SElaRXhF?=
 =?utf-8?B?anhSdzI3eVRDN3JyazRwSHVNMkJuSXZabnkxck5XN25UWkZ1U1k2cUROM29p?=
 =?utf-8?B?MTc1TnlGNXJJVXFWWktDcWxWR1RJYzY3ZHMwVnViTFdzTjRQMWhHUzNpdTNo?=
 =?utf-8?B?WkJ5VS85a1FIWjQwWURneldnZkV0a3pKZ2xJTFhGK1hTL3pOZFROSVY0UUxK?=
 =?utf-8?B?MUNVbGF6K2JjUFUxQW1mVlV6dXBRd21Vdkg4QkpXcllBRW5TSGlrTDdZa0Fo?=
 =?utf-8?B?ZkV2VS9xR3A1bUJDUXVKeWRSaFBaN05qZjFHMVBMYTdyaWhIWGd5Rm15Q1Vi?=
 =?utf-8?B?QUFHdzRxSzFDQTVUVzhKZ1M1VWIwcmtoaXk5clFodjR2bS83VnorY2g0ZXRB?=
 =?utf-8?B?RFp2YzhUSy9VSWtrMWlEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNPNThTWHFrR3dBQWY2cTlvZkRFdmFYVWJxMVNuZTJTNUdQYmNJT0RZdEky?=
 =?utf-8?B?QTQ4aytwK3owazdtdC90VEpxeHpoNzV5ZzMxVDIrS3psNTBxZWNCMmJxNkpH?=
 =?utf-8?B?dXQ2OTRNMmJTc2UrQXFtc3BFLzhMWTVBQVovVW1lYmZPMThCNHdRUGlEaFdl?=
 =?utf-8?B?MndOSFB3T1ZUNW1EaENkUy9lKy81UnZQVTVhNllDSzZhcTJpQXJFSzNzQ2ty?=
 =?utf-8?B?MGN1WkM0RjlwOGpLbVkxZWZMR3Q5VU1sekZOZDdGMWFtVzRjTGVId2wvdjJn?=
 =?utf-8?B?Mk95S3RmdzcxMStpUlQwL244SHB3d0V5UTBpRGQ3ZkJCTTBKU1JKYm1DcnBw?=
 =?utf-8?B?MEFFeUVNVWdJTFhac2R5dGJseUxZSXZxY3dlWUIyUDd4VXhCaVhLYmZnWGRV?=
 =?utf-8?B?Vnd6aEVzRHUzVXBrVXh4R2k5NTBRM0p0TzU0SWhVNWFMOTJ3Rm95WTlPR3ZC?=
 =?utf-8?B?RS9BTnJTcWZGeE1rbU5TNUNLWkttbFkwemFJa2llenhUd3lOZkozSUZxaXdM?=
 =?utf-8?B?WnVxdWE3ZG1adXVkRWp3MmppdXd5SzJ5RmdtVVh6WTVURStDS2puK3RjekR3?=
 =?utf-8?B?TTExTkV6YnNpeEtvYURGcklIQTdqZlNHSUJiNHJOeXpDMzNZQ1VTU1JmeHkx?=
 =?utf-8?B?T0tVc0tXWFI4NEZpSUJzMkZZMHF0ZWpwVW10WmRsY1JtRG0xVVAvT3Z6bjBZ?=
 =?utf-8?B?Qzk3dlZKRUhzRzF1TkFwWW1xVm84ejZETWltdXFjTUE1clk5Rkx0SFppMWVB?=
 =?utf-8?B?d1FjaGsvbVJNUTlDWFFLUlZLRVo5Rm1IRFBVSlo1dGFuUkdVN1JYM2toUWZh?=
 =?utf-8?B?SFFjazMrbDBYU0k2aXJkUHUxTi9LOWtLSFdLaHdhQWNIS3hhQnpocHJrT1hR?=
 =?utf-8?B?U3VLZCtXaURabW5HWUVjbDVoSVZlaEdZL3ZkcUlTT2l1aTc0UmtFM25sc05R?=
 =?utf-8?B?NWI1dHp6RDVEdG13bVBjcFlVZUhQOUt5QkV1LzZsWmZQNHZtQzZWWStPZllF?=
 =?utf-8?B?bW5SU05CNlVBcFp2SWNsQWJ4QnEyZU9TRjdmQmtUSVpqUlF1eURQdEZzbXd6?=
 =?utf-8?B?Rzk3a2h6OHdFdU5sd1BOWUttRnFOVWFBL2sxM1ZrM1FHV1dzTEFZWW91eWE2?=
 =?utf-8?B?b21QRUp3eDZZYnVLMnNkVTVKMGdNNHZUZEMrdjgxRFdUNlo4aTNHUnhBQ25Z?=
 =?utf-8?B?NlJoYnV4UnRKUDhtb3N1VzMrMzY0RWdzclNoSWRJbG1OcGNaa3VtcWQwMHgz?=
 =?utf-8?B?QU93SHRUMllOSTFoRENjQ3h0bUI2cm1uaE9OemZaK3A5cGRIUkJmbnRaVGVI?=
 =?utf-8?B?WENOSkhiUlJyeTdCWEtaNWtsaU1PRk0vTzJUVk1YSlJQdjVvNEVuRVNmeHI0?=
 =?utf-8?B?TlpBN0ZLVnZSSGVzeVhJL1hlNlhGSGpzQ3lYMkVzMVhBSXk1b0hJbFZ6dFdL?=
 =?utf-8?B?MEt0dEVscjd5UFVBdXh6cHErMHNBZ0c0UzZ3MStTRWtwQzlCcmcySE5YSGZq?=
 =?utf-8?B?MTd3R3pTMmR6dDJFUGYvMFgyVlF2dDdJdm1xdDNUODVkN3FRNU5kZ3R5cUtQ?=
 =?utf-8?B?UnNjcVE4bVZBYzg0SkN1Y3hVMXZVUnI3NmFOSHM2UnV6UkxOazA0Z0JNYUlF?=
 =?utf-8?B?ZWMwRnVkc1JuZXhyK2NyTEUvS2tIM2tyb1I0anVud0k0bWtreFFMakNpYmgr?=
 =?utf-8?B?V0JuZVRZblNRaTBZWm8xQ01hZEp0dkEva1pjdFFBZm1iK2Y1OGtidC9KcllF?=
 =?utf-8?B?Z0QwZkRLQkwzb1lFYjVQZmJYY2ZseFM4eVNIMG9jMU1KV1VDZ1JlZWxGMWd2?=
 =?utf-8?B?cmRISm9RNEpldFpZUTFrR1phS09wb3Q0WUFYcFJvSFJ6NUowSHBEOU95SFN5?=
 =?utf-8?B?M0p5VEV1SFZIWE5KKzZ1TitWNXJoaFE1UDBualVnMkdvRUtUN0svU1BzNkpY?=
 =?utf-8?B?Y0VPWEF1aXJ2WHNhZkZVWTJBaWdPTUtmMUIybDZkWWptYzhSQnZPbXQyTWtH?=
 =?utf-8?B?bzFaVVdIeWJQUjVlNHEyQkFucVhiSGo3b3NxbGxmNEZzSW8zb1pEa1l5am5o?=
 =?utf-8?B?RStUOGR1ZUovTGh6cDFEM0ZuZ3ljZ1lvYTdJRDR2enJNbjRwNWZXVytMQmxi?=
 =?utf-8?B?Vi9wYVRsTEtXOWYrRm80cHQySmlNMHRlVmZLYUtQdnlOeDd3L3NldkJtZnZX?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 711254a5-10ec-413c-e39c-08dcd35f488b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:15:37.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBrV9pg0niwVHFDqDwr21AWA18ACeyFSWMOVi2X7YL19nDeBfPBBEhp/c3aICUeYHJ1zDeQqD5Tg66tfOdLogqDjCf6tnnmVxXErarx0BwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> mlx5e_free_rq previously cleaned resources in an order that was not the
> reverse of the resource allocation order in mlx5e_alloc_rq.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

