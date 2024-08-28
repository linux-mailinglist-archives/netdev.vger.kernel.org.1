Return-Path: <netdev+bounces-122741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4318962685
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C813D1C20FCF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68216CD2A;
	Wed, 28 Aug 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5l+YgZa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06E16C69B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846723; cv=fail; b=d6kVkh572Mwj/IH+rz9DXWTaaOPweH7MGBB3+KBTr5uMi06gszBD65CJAFP2PEAv5pv9t8sOU4XOWwzhc0ZI0df2tg1LChlQ1XGyEPSRQZEt40e/3UQCnXyT6BhJKD8vgtYXjJv5LfOwZfieJL8XSH/YuCPfrQtjlHwrrcD9/G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846723; c=relaxed/simple;
	bh=QUzdQKvzNmOjAoHmAGZfKxjK5EcUnsAB2WR4wnAvK6I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGGyQ9xKBDn9ej2lZyw5vhgqQC3/Y5u8pvNk6oC14s+cxoCXtmJ+k3UNL9sW5AMqhmBtiPP7ojVJie6pz5xawveDEncb5aluPcaBL3LeDiAOSdI20Zft4Cw7C/VmwNJjRgs9FXJN5zCsQ2IxaAjaTgQeUnrV7QS8AOMOrOPoMCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5l+YgZa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724846722; x=1756382722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QUzdQKvzNmOjAoHmAGZfKxjK5EcUnsAB2WR4wnAvK6I=;
  b=A5l+YgZaJUVHMZH+5ohbxTsjxp/0UIeMJntUvadr0tBVOixECiaDtKja
   djsNzNo4OlwEMOzOpX1oJfA697COpVfhKgqWcO+pf3dBFlOxQBt46lGs9
   8d+pxdzeEfH8mC5kytOKxO3hiHXVl6STzVVuRIFAPS99mQMvJgyBAk3Dy
   mOeqY15/VdDXeSp1n0SRiaf5Y/xJ7BEIPa42TFbiEDXghKsftN/hA61Nj
   8RQiGYpkiAWkwjnmYJJ8lY60ed36FRfGvRooqTKHouFbvFAYCAaXkYSLt
   ZABBSGbbeS2cTI+Ccw4nh4Wjte509CX8Ttx2rkz7YHyyRBvgNF4oZvW8r
   Q==;
X-CSE-ConnectionGUID: ycvtol4FQqO0Bs5xXDwQeA==
X-CSE-MsgGUID: 7k5LG0PlRZOPqzZLCXoNkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="33994095"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="33994095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 05:05:21 -0700
X-CSE-ConnectionGUID: IrIan4c/RMSukL6F8ejH0A==
X-CSE-MsgGUID: NpyuKwhZRAKvBq48xEB+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="67562835"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 05:05:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 05:05:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 05:05:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 05:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8RwGgXAq8W9t9rDbPBw3ZHZaVuTSjOnldYvndC4Di06emZR48lXFrmd5GoyCH1hvxCbGQG0pGAndjyXV8WZSRR8VnvbvSR5du/uhZPkHXV7IqT6PXyfShnqD1zFyYCPY/xmGgGKQMEArQBTpk/P8wy/BT3V32BnWnwJ4cUi2PMCBi7VqzujS9qV78PYaJMXgAkjddwvp9HnEykZ2/VJpd03GA8RmiNOeWZLm6l6Fbx3p0chYvoigac11s/mruZs29biqPOZwbj4tCAkorrhxGt3ynL8xvlJtsdqokpqlG/0z+zeqamveuazxv57ozZ99iG1qpnHd5PMT0rPVkGsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwwgSL9WLtjrQbxSAm6UcyemT656o92/WjVltMa7bZk=;
 b=DFySumeF/rL4a8HdkuUfg3e2z5wYltRhPP5Hiam2JpT2ImGuHKx/4R4ZsZY+EXWGpInn9kLYmgWLfs1kd5/lV5A2THskACZaGuaZwwRCOIjh7gavaPE3ZXzohfhHPwqTaLCDZB4Wry8DHpWNfT1XfZ/GzeO7juak+C7jhs7jNoJd2tFyRuPD3E334/mlx81NoHwVuYZmb1ATRv9Qp4zqu7W5+jyKkCkTtF8PXifwhWuWi+jSk5y63sjxIb/tntp51FokGleXCOHKahwHLKNqZz2jCTcRyYeWbSzrR6priGGolv1DgZqaXxiE0i1UtbsS1Pg9XoV/plbfPemXsVDN0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 12:05:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 12:05:16 +0000
Message-ID: <1a4232c2-34c9-4b14-a581-4bc2cdc11afd@intel.com>
Date: Wed, 28 Aug 2024 14:05:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 07/14] iavf: add support for indirect access
 to PHC time
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <kuba@kernel.org>,
	<alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-8-wojciech.drewek@intel.com>
 <9e708174-d6c0-4b8b-9a0d-5807463d6c43@intel.com>
 <79623019-60be-4db7-a35e-f2e4c41b6f63@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <79623019-60be-4db7-a35e-f2e4c41b6f63@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f05f09-98af-4d3f-2108-08dcc759add7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVF2MkV4MXM1VVF0K3VvMXZtU3FsbktvZy9Gb3BNc2xubjJ6TUlSclVuTGZv?=
 =?utf-8?B?RVlaNmd0UFB4aEtmWmhQQWtKZGp6OER3UnZjd01IMlh4M1RMMzVxL2Fub2U2?=
 =?utf-8?B?Z2Jid2JWRWNQeUxsNEtHY0FKRkpLcEtRbldoRE9rMGRncEtlek1MekNTVEhF?=
 =?utf-8?B?dlBZOU1PVkFCWEpOc2NjSUMzV1NZNUZXNmdLUC9ySGZybytUa2MrTHo5bWhX?=
 =?utf-8?B?b3kzcnl5NERKVUhKOS92SVJjdHIzU3BlbDQxZXVhSnBDbVphZ1ZZUy9qZWl5?=
 =?utf-8?B?a3pES2hOMVVEaDEzY1Z1RWY0N3Ywak40Q3FXeVNWakJMRUZUQU9Kd3BQbDd3?=
 =?utf-8?B?aU9Da3kveGZWVEg2UG16Z0VFblBFLzJkVlpDNk9DY3BlRVZLb0ZmdkVwM1d4?=
 =?utf-8?B?RTd1aUxkRExOaVVTMUFLWHovVTNRKzJjNExxY05NZmx3aHdST09vVVlPdkVa?=
 =?utf-8?B?YkYrZzBCOVo2d2UxcC8zS3ZsMUNYQThGUHQwMDltMDFJSnZzNlJjTnppa0s4?=
 =?utf-8?B?eGhsNXZRVTZ3dHI0aXFyMXpDQ3g2L1ZURExlbGpiUzZSUXFIUnQ4aEdJUWY5?=
 =?utf-8?B?TjRUMWErODRpaVlaNytMZEsxbjNabzBnSGljY3B2SXphSzl6ZDZ3d2czdUJs?=
 =?utf-8?B?WWlzTFJUcnVFVXlNVlk1UGRieFRFUC8vZU5POSt3b0tJZWJwL3M4bHlhU0Yx?=
 =?utf-8?B?aEsrUkpXaVpCZXU5NlRueVJoRytONnRUM1ZRZStiUDZjMkFkOWo3R0I0SjdR?=
 =?utf-8?B?SiszQkVicXdXaGVlY0M4UE8rRzVDK1lRRlZrZGJtc0tOeWVtRFFWbE96dU5F?=
 =?utf-8?B?d21hRnhPUE1Ia3FFRDdlOEcrUFVZdTR3WXlmUVlUNHFtNW5wYTR5T0dOQTNu?=
 =?utf-8?B?a2FxWmFNY25QVjJqamdvSlVXdkdFMHZLMEZSeXhiOVg5S3hTM2JRM1FLMmEx?=
 =?utf-8?B?WXVVcnpiS2RqSFptM0RLMzYrYzFnMUg3clVYMkI2V2RKTjBtQW43L1F3WHF2?=
 =?utf-8?B?c2lKNityVEFjMkMxVldJU1BQSFRkUkxKT1JyRllYK1ZyYXhQYSt3SndPajdJ?=
 =?utf-8?B?WVBCeWIvejBKUGtYbURGM2JuM0FZNGZybUUvb1Z6eEl4dUZIWllBU2VjMXBl?=
 =?utf-8?B?WDhEdXhNeE9Ccmp1azdwbU5Ob09wazFUTWkwWExYZGdxdXd4aHVTc1EzU1ZD?=
 =?utf-8?B?a3NsWjR1TnpwSGhLMnYzZEJVUm1JaVV1V1g1ZnVtdWt1Q2VzZFhsVDBUazF6?=
 =?utf-8?B?enFKeXBIdnFlNUw3MDVFQTZidDhlc2s3ZUppR0NLRGFBd005SHBRTDZXNE1X?=
 =?utf-8?B?VzFEQlMzYzdwN2lFbHQzcy9sZGRLUUNVUk85bWJzQys0RHNCalV2cjlSNVM2?=
 =?utf-8?B?MVFxRWRsa3J5aEdrY0FuSjNxVVF3VDVVQ3VWS2VoRGFtMWdwTGhCQ0NZUVNN?=
 =?utf-8?B?Ym0wbk5BQk1BOTM1SEJoZXpwZVlwUXliOW0xQnFzRGdwcjhLMmxYNktpT2JR?=
 =?utf-8?B?T0FJMUtiblJFdHNBbm9SVjZITlRMeDFTVisrNzgrR2JqT2VvK2tCNS85aGl1?=
 =?utf-8?B?VWtDUWhxN21jSmJZWHFtWEgxYzBGbEhRNnN6VUdqbi9GUWRIS2laVHMvTXA1?=
 =?utf-8?B?M003ZGZNTUVFdy9CVXo4cHRyZGo2UE5RdUdqRklTTDJBenpja0hRTFg3UW5L?=
 =?utf-8?B?T00zM3ZEVjQrTEdlVHNnNHgyVld1ZGZMYU5RM0tSYWhZUHE5eWp6ZUZON0JW?=
 =?utf-8?B?d2QrdzliWTJmd0ZidSthSlZldzRZZC8wTmlrajE0WU1pb1A0ZDFmWHc5b1h3?=
 =?utf-8?B?b29TSXhBOWhObndpTzM0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHJ6SGlYcVlZQzIwUHZYdStscHBBUjlUU0VRVHhlYmJzamdaMDIvZWtJRmIy?=
 =?utf-8?B?VVVWdEdxM282ZkNwaE90ZjJZMkhvTjgzUGZGTUpXNWZiTkwza2lRN1l2L3BM?=
 =?utf-8?B?V2Zqb0RERGpKRFJBS29JNnJzQXk2L0h5WWhMMUJaSFM3eVNzeTUxVVF2ZXdE?=
 =?utf-8?B?N1J4ZGl4Q2ZBUW9JQ0VMSjNTS0NzWjVyRXZyanZ3VWMzejR3NGVXYmZXeExY?=
 =?utf-8?B?ZzUwUldYYUJxQnQzYTNUY1lscUw1RVVsVytkVzdab3o1QXlYbFFVVkREcm4r?=
 =?utf-8?B?K0dGZXl0a2FFRDJDTVlxajdtMGs1aWd0eE9CakovYUpCRkIxUE45Qm9yWEJX?=
 =?utf-8?B?SHdNV1FNaUxaTldvc0pyZ1hEdlNYVTJmY2h3SmdXc0dYSHZTekFaak5wOE9M?=
 =?utf-8?B?S3hGU0QweGZQTXBlakVESDVUSnlvMkUrckxmVjFZOXVhcGtPUjdUbXc0aDJR?=
 =?utf-8?B?WkFhZTNRUnI1eExqdlJ4dU5hMDdvRU94Y2FGWlRKeE5OeTZwLzJ3VVFzYzFz?=
 =?utf-8?B?Mk9ucllWdHNITUNYZTdxSEVwVmhqYlFkYzhoaFBJbS9WbkpEVDFnTEpjQ3BS?=
 =?utf-8?B?eGl6RnpuNnB2eHFydFgvUmcrbzlQdS9HczVZUU1WZGV5UlNWZmhhRnNhRG9B?=
 =?utf-8?B?c2hVUFAyRXJtcXZBdTh6L3BSQW85UVVNdXFVWDcveTdvZzFsTm8yZktqTEtS?=
 =?utf-8?B?aVJqZkJyelN6eVhnYWJwQzR6TSs4VVg2bGZFWHI2dWxTMDJLcWZlRHgvNjVU?=
 =?utf-8?B?YWZkOWZzM1BTVEdLUjFySDZISW1iSHpEeU1LTmNqRktYSkVKM2Y5ZkhnL05M?=
 =?utf-8?B?TUo1SXI5dnk5cVVYaC9pRXdIY2NFVHBiYVpHQVhhVlM1TXQyUXh0ZE83UVNR?=
 =?utf-8?B?RjRLaFAwd0Z1SEtkMU14dGE4KzI3N21CY0VHUjd3MzdNRVhKNXJwRWxkYldv?=
 =?utf-8?B?bHE3NUhtN1pLNTlxY0VpZGxCWitRYXVGcSt1RUlXZzFISWh6WXArNytsRGVO?=
 =?utf-8?B?VUxIbUxETlI2c0dOSHdPaG1RaHNyTkVjSDBvbkpkS1dOeGMxY29XTGdDM3N6?=
 =?utf-8?B?dU55cFRXUnl6ZlZTTlFrUTFwL2lqaWNjUHRlOU9GZlJpellyay9lSTZkMEhO?=
 =?utf-8?B?Y3VnbitydmRpMC96Rmp6MUFsUkgxZWFEUTZVcTYyTHd5NGFUc0VuMDlKem9s?=
 =?utf-8?B?MCtxdG1yYkkrZjViTVhUR3dZK3lGelFPbkI1eEUyY2NGWTJjbk1HOHo2T2dT?=
 =?utf-8?B?L0ZQOFF3QWxQdlVmcUtKU0IzVmE0YzVHZUZ3YVNLem1aVWJXOFNLU1ZxOTFt?=
 =?utf-8?B?OVpTTHl1VE9veDBYL1JoRzVzZU5EVGZRWE1IeVlQZ3ExMzFsYUlxOVhWNUpJ?=
 =?utf-8?B?Q3Y2RnBMY2Y0UjZ4M0NMNlJaN2UrY0tSRitqdVg1VmdvaVpsZFpUbUl5RHJZ?=
 =?utf-8?B?VnRTZjhyZDdTVk5EQ002ek5TTldYU2ZTdVBGR0ZtenF3a2tDMXlzVzYvZjZZ?=
 =?utf-8?B?QUY1OUlIQWF6Vno4TUNadlhENGU1MXY1ZjFyMmU1TTZ3QVFWVjlhaVlRRUdD?=
 =?utf-8?B?N3N2VklsYWwrRlhKb0Z0U2Y0MEtmTmVHM1k1SXIzTGdaR1g0SlpqczhBRWlM?=
 =?utf-8?B?UE9Da3dKRm5QUDJVUUtKRU5xRW1zUXIraFlzZ3RZNmYrK0dzbXJna1VCOFBj?=
 =?utf-8?B?UmlMdnVMaVRuZ3QyZjFvQXhBRzNpdVJPWnhieWt2SHoyaVJwUlVxUGE3VDFF?=
 =?utf-8?B?R05lSHlhNjZHT3hPelQ1akEwbVlzUTd0SlNVVEdqS1I2REQ3RkpDUUpIc3Nw?=
 =?utf-8?B?c3l0azl6YXVOdHZCbUVxTk96bUZTTzRpbXYrU1d5QTlOZHpjUVR3azZTeE01?=
 =?utf-8?B?dVM0Z084bVI1eTRCWXYwOTE1NVc1VENOd3pWTEtVcHJGczZKRkZSUDdrZzhi?=
 =?utf-8?B?em1TUDNBQWRjdW1FOExIZ3lhWkRSb2NUR3FBc1dEQWJBVWlqNlA1L2RhbE43?=
 =?utf-8?B?YjJIdWJzTmJuQnN4Qmg0TFg3TGhyZytpMDlINDhodERhSDlVR0I2VnRJTWh0?=
 =?utf-8?B?NnoxMTd2MGpsSDhrb3RSN1pQdU9sZFNYcjE3SHBZbU5zbnZwbERvTnNHMnJ4?=
 =?utf-8?B?R0poUzJhMnBlVDdzNmhYSWtlejBUY29LcGVQb284UWtrQ1VGSUd1alFyRWpR?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f05f09-98af-4d3f-2108-08dcc759add7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:05:16.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV2Z6nsFaezu1vuvxrFdgxPxNQaGpiqQ9LbiKA6hiO0dzwzVU2n+qrWU6imkgasmdr2gQlhhIwnXyLO60IfV2ulBzNSBwEKv8+nBTGbTmMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6776
X-OriginatorOrg: intel.com

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 28 Aug 2024 13:15:09 +0200

> 
> 
> On 21.08.2024 16:31, Alexander Lobakin wrote:
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>> Date: Wed, 21 Aug 2024 14:15:32 +0200
>>
>>> From: Jacob Keller <jacob.e.keller@intel.com>
>>>
>>> Implement support for reading the PHC time indirectly via the
>>> VIRTCHNL_OP_1588_PTP_GET_TIME operation.
>>
>> [...]
>>
>>> +/**
>>> + * iavf_queue_ptp_cmd - Queue PTP command for sending over virtchnl
>>> + * @adapter: private adapter structure
>>> + * @cmd: the command structure to send
>>> + *
>>> + * Queue the given command structure into the PTP virtchnl command queue tos
>>> + * end to the PF.
>>> + */
>>> +static void iavf_queue_ptp_cmd(struct iavf_adapter *adapter,
>>> +			       struct iavf_ptp_aq_cmd *cmd)
>>> +{
>>> +	mutex_lock(&adapter->ptp.aq_cmd_lock);
>>> +	list_add_tail(&cmd->list, &adapter->ptp.aq_cmds);
>>> +	mutex_unlock(&adapter->ptp.aq_cmd_lock);
>>> +
>>> +	adapter->aq_required |= IAVF_FLAG_AQ_SEND_PTP_CMD;
>>> +	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
>>
>> Are you sure you need delayed_work here? delayed_work is used only when
>> you need to run it after a delay. If the delay is always 0, then you
>> only need work_struct and queue_work().
> 
> I think that Jake's intention here was to execute the work that is already queued,
> not to queue new work

mod_delayed_work(0) works exactly as queue_work(), which is:

* if the work is already queued and the timeout is non-zero, modify the
timeout
* if the work is already queued and the timeout is zero, do nothing
* if the work is not queued, queue it

So my comment it still valid. You don't need delayed_work, but work_struct.

> 
>>
>>> +}
>>> +
>>> +/**
>>> + * iavf_send_phc_read - Send request to read PHC time
>>
>> [...]
>>
>>> +static int iavf_ptp_gettimex64(struct ptp_clock_info *info,
>>> +			       struct timespec64 *ts,
>>> +			       struct ptp_system_timestamp *sts)
>>> +{
>>> +	struct iavf_adapter *adapter = iavf_clock_to_adapter(info);
>>> +
>>> +	if (!adapter->ptp.initialized)
>>> +		return -ENODEV;
>>
>> Why is it -ENODEV here, but -EOPNOTSUPP several functions above, are you
>> sure these codes are the ones expected by the upper layers?
> 
> I'll use ENODEV in both cases

But why -ENODEV? Can you show me some other drivers and/or core PTP code
which use it?

> 
>>
>>> +
>>> +	return iavf_read_phc_indirect(adapter, ts, sts);
>>> +}

Thanks,
Olek

