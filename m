Return-Path: <netdev+bounces-149161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8C9E48C5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 00:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80ED28116C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C031F03FF;
	Wed,  4 Dec 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0lcsHvz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D619DF66
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354717; cv=fail; b=SAAJXDLhq5jJCGDVMZigfUBHvDBrQMWiReQfqnb+Z6HgQ5bFznNC9QckaemkU+1vWX4w40OLtFqpkE6XpaXEVlenc3tWZikC/OpFo8m0d8TlpuOTZfREyzfSmSIDxoGdpXUj97OrQ3xP+ediV9WfAAXwFCwlQv0hqjC+OkkiMtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354717; c=relaxed/simple;
	bh=STGiIxGmcUZuIf1K1IVwTNDmuZjrel/Ds0iBE9258Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sb7UbkNhwqrrm78pWixBDD55lpFaOPNnm5DdZKe2g9VNJuSBQN7ofZI2HFjxNZYlJ2nEb1x5AfxFTSqtWh1t4+JO/XRit1Gsl3mjDJ0kW5zcxdCEbTA4wWbKJYd/fsEJSwUBiWGD1r80CVK68K24HNlGyfehBUHhaFATF9mBp3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0lcsHvz; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733354716; x=1764890716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=STGiIxGmcUZuIf1K1IVwTNDmuZjrel/Ds0iBE9258Ro=;
  b=H0lcsHvzREMPnowAa0D9YTGIS6fM+VCBopQEWOy3mXG+SQdjNdot5xnB
   hK4oNpkMNJY+ID+rcWkjcNrSzW8cXe1y1/MghijFjsSxDlspG9qrEkCBi
   kEXwyVAOUXBBcQcDrw+BnURU+21JSfiDM93ocYUq+mfKWsBtwX5gRqGUy
   h9zsAEQbVb7F4RlrvNoX2qpd/2y6jxqxNJRVEULIrErk7RFxADGsXPYyd
   VLWBV3UzhISmvDS6Sq4G4xQov0SM7BspQuzg5hZXoGVb5T4Heyscu08D3
   4G0a1QolZn/K6I/nMgELLoAyMCjRhUTYdFcr+h3H1D5lAHL3J5PbuXxPe
   Q==;
X-CSE-ConnectionGUID: BSBwdKrCT/GjKErWpgXXBg==
X-CSE-MsgGUID: RsxXAG1eQrG6mTE1iCPcIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45022275"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="45022275"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 15:25:15 -0800
X-CSE-ConnectionGUID: wzbJQBATTG6taubZWVJOMw==
X-CSE-MsgGUID: BdIEv4Q9TzStI+aApp14Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="94744571"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 15:25:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 15:25:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 15:25:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 15:25:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2NEVqa6RejNsItTXLOH2zRICs0pq7CUVVNzSkHLMn1BlNxjZq+CRwyoIduvcZYS+86dwGxyv4DTLxBs65lewkSQB9IUtejlArwGW9T4AQXA0oEBr6rRrizC04m7yLtDsygUaAxtZj9J/yeoC836B72AHqOT4y5ye/YTCBTPaP95cUoboIm1kpsdpqCmL4yoWlwfGL/Yt71i7Wd7lqaVlUZDaqen0kd6L4YHxbpBk39XSQNFzkg7JhyFwE6R5jr0jxpdZHbmQGLgLnF+whfKVSnuD7eEdmwgbb13/FHhz91HCM4DJF2bnMCpk/NScNinwSxypSKf+zlhZWgQHh+0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaryoqLxK2cNZTAdT1T/wWUUTYWGFNjzsGPx4gCwSr0=;
 b=A57SOC/k7QYo7QuyR3CiBKlhloIzbDUoYbF3NJ8oQ+B7vEG3uMuppTNNtiSFN2BZA0P2gBCjALSnD8TeGGYzELeB8X2GhKzPyZ8db6sefDmwvDR/4KQE05gaQyF/4bB5G+ySdVAT8kjO2ad6ALMUbFojmSo8huSSfn+AdhhlAruR9zg64dd0ocJc88SaTLolBtBH4cn4D78maI5j/sqAdNfdG0a9xFpyjj3osbtFUubcrbMngBgpnQHjgIPjQV6QhPJAGQJF7ufR7YR9/WeItcN8x5ezsFg3NyA+AM6RejdmfjWFE5LqQtOEW+1jqJ+5xrnD84Oa4oTwVYgtV0N0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 23:25:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:25:01 +0000
Message-ID: <998519c0-a03f-4190-a090-f8ada78ea376@intel.com>
Date: Wed, 4 Dec 2024 15:24:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241204171215.hb5v74kebekwhca4@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd848b5-2d6d-4b82-f96e-08dd14badff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHZPKzI1aG5pY1FtNEdYaXFkdVZLVlRGS1M3dmIxQjB5eEwwRG5Jc21zZTFM?=
 =?utf-8?B?Vjk5UDh2V1dFZTBuYlZKNnlmOEU3S2s3NnljS1haWmtyd093akQ2b3Q4UXBN?=
 =?utf-8?B?V0dsbUJBNkxZcXdoRGJrLzFvcEs4YjUvY2tsVnBRaTlMQTdPOFhNUGpJSzdG?=
 =?utf-8?B?amNFM0MwYTlLK0FRUEJyTWZDdm9LKzhTZ0NEZFVzU3RKYzkwbTBKK1kyUlBM?=
 =?utf-8?B?amh4UkhLOWlWc0dKV3J0a0R6cTRIcXlSQ3BrWFZlR0FlSjFOSnhKa2M5TFBj?=
 =?utf-8?B?bk5ZK1hoWGtERlZwdzhadVZXaE4zUXRIYjRBOHZIRDVjQjdmNFZIeXlrM3J4?=
 =?utf-8?B?ZWlYUEFnYmxrVDRXKytUWUhsejJTaVVkazVYc0pzRjJRemtBUlVzZTZ6bE5Y?=
 =?utf-8?B?anM5eWl4Y2UyZzM4bUlNZG01aHJRYXM2U2dSMjJtZUNLNUg5eSt2a3F0d2Zq?=
 =?utf-8?B?TUc5blBYa0grRVptUERMN0pFUGF0TzN1SEZNSmxFU2VsUXZVcGh6WnJxNVNG?=
 =?utf-8?B?Ni9FL1V1bzA1Y0RPQlc0VUdsYWFjUUV1NzNPeVo2WFA5TnJLRU5vTkpvVWN6?=
 =?utf-8?B?NFBuL013bktJRDFYQ1hPSWVOOVRDeHo0MkM0cXFhVmtwUHk5dUJyNjNwUFJN?=
 =?utf-8?B?UW9ubktRNURtT3lkTVZyZWVMV1RtVXVoWXhHN3ZVSjZROEZ5bTRzQ1hJUHd5?=
 =?utf-8?B?QzM2eDBwQUY5QklmbHFxWlhDdWFDTEpwTDZqTmNKUUhBeFdRc2V6R2dPVFMr?=
 =?utf-8?B?TFlIZ25UTzRnWGJJczlQSXpRNG5uRUlId2NOOWRVbVZndnVNTVliNjJrbEZi?=
 =?utf-8?B?QjliajhWUFNLUnFxV0VKekRRSndhWUo3eFpudEJId0JQRVRJMmJwOWNPWWlr?=
 =?utf-8?B?aDNjR2Z0alNraTdGRzdadVF0dkdiQWxWeW1rdFNxUUdSMWJKbHFZMm1LSlRl?=
 =?utf-8?B?RlkzMGFQN3ZmYUFsb2hiaGFINE15VmU0ZzB3bWdtMWRySXBVMEJZWjNPY0tM?=
 =?utf-8?B?bEV6MTIzeDZwcWMyY0RXZUZyM3B6RWw4dERxS1djbHVDM2JCSmxWOGFZUXU3?=
 =?utf-8?B?TVJnaHpaNzk4RStJaUJNelNJZjREUjEwaUViWGZZOG9iZG5NZHpuM3FLTEM1?=
 =?utf-8?B?d3VORG5WUi9veEhqMXlIaXNXdmNzY0F5WVBERzRzOGUwRHVZQnRTVEp0TFlF?=
 =?utf-8?B?YkR4aTNaZGp2RW9CQTJJMlcwSWRWMjhHQWxjdGZzbU4wWm1xQjJVQm9FVlZn?=
 =?utf-8?B?VVB5UUVvVlh0YlBSakN0a1N6b2dZWmlsTEpqL252OXRBUWtUUW1NSEZFaGI5?=
 =?utf-8?B?VWpQUExFalFzeGIwUFZwOFpXRkd4dG1LNmlNcjl2YUJlOEdtajhmcVhOa2dB?=
 =?utf-8?B?bkUzczF5djhZTDM0elhreUxBbkdoNFJWcnN5YkVlWjRkYnNVM2RTTGtTdlVG?=
 =?utf-8?B?QUVaSE8raDRVcnhXMXhGYjlzRFNiZ0tVeEg3eWRtRWZCcVpMOXZNbGtVYUl1?=
 =?utf-8?B?NUNWQlpLQTkyQUkwZ2k2UVRZS3llVnZOTEQzK1lOa25OTXNkMWN1aDltLzI1?=
 =?utf-8?B?VlNOZ3BFc2IrSnZlUEp5Zkt4bzNDNkZYUjNYcDBVYUNmUHdJbWtHck5NcHVP?=
 =?utf-8?B?RjJaMFMzRmJ5S0pybUpPaVFGR0ZxRDYyYytCd0p2RXdtdnpPcytCQW8vVmtJ?=
 =?utf-8?B?TlRYY0NkVEtpMTRCYTZFUDRWRWtMaktQU0gxZ045R0N5U0RJVXVONjdveVB4?=
 =?utf-8?B?YTcvb0lMYk91MWlEUmw2TVViTkkrd2czZVRMSjBVWld2NXgzb2JiYURuRVNa?=
 =?utf-8?B?bTZ4Uk93ZDJTVUJyVm82UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clh1YUNydk9FcmxZbWlpMmVEUVRMalRBeUtKb3ZDTzRCRjNlZ0xjTTIxWGdN?=
 =?utf-8?B?UDZQbGZydHRodkUvL3RwNXV5VElKK2FodVI5di9jbmk4TkJXTGRIcEovSEJ2?=
 =?utf-8?B?VFdNMm1Cb2R3enNhUk0vc2tvNFBRTTZ0Wm9jdkZrM2lMZE5vemU1Wlo2VUdW?=
 =?utf-8?B?QURyZzA1V3RzeE5BSFJiNEdKWEdnWnVkSEszZlIwclI3NVZFTnVaZnBUQlVG?=
 =?utf-8?B?azg1Wk8ycDlhQ2s3SXRzMkZKUWpqRU5TQitUVk11bkNUY2IrYTZPVk9lZFVm?=
 =?utf-8?B?Q0k3MzRhYmpEY21xWDl1TElSaFlMNTBzUndzYVRPc0I5VHp4bHNVSDVDWlQ1?=
 =?utf-8?B?YWpHTnA2UVFxbDRSN0YvTGJ2dUpwWk14aUhFcWs5VGhuMjQyUHRvL0xhQ0hJ?=
 =?utf-8?B?YmMzb3F1TDhhbklpSGplNzBTRm5YeEFFeGpIYXdUcEJ4VVkyYnpCWEhFZFZN?=
 =?utf-8?B?VkpjaEg0TmMyRWZjUnVkbHE5dUt4RGtkWU9LTk1XM0gyTlB5eExuRjBLL1J1?=
 =?utf-8?B?YjlpWWpVZ2ZrQ2ZaZFRrNDFBVXdRcEpEWkZUZkp2YjMrbkdpMTVxOU4yalIw?=
 =?utf-8?B?ZlpvaGpCYzJmbkxUOXRqRTdXVWtzWXFoWUoxVmVBYU5UMmZDcjFpLy9pdkEx?=
 =?utf-8?B?aHhqbUpZTGdhRlJXZGhWd3RONzhZYVMwTEF6TEJnSm8wRjQ2MUFkYVlnL2RS?=
 =?utf-8?B?Q0xDb1ByWVJLem51OWtIS005NjQxeTBPMzNLZDJCWExwVWVCa2JaUEFVUEkz?=
 =?utf-8?B?YmhTeHFYeWxCRklmdm9QT0hWRk10eGNOd0JYWFZ5eTJFeXFobFE4WVR0YTdJ?=
 =?utf-8?B?MXdEMCswaVBTa1R3WWthcGc5NCszdUNPaEhsYlRzU2hySGxxa3RYZzcxS2l5?=
 =?utf-8?B?bEZTSDBsZGpmQm5jOWE5cXM5VTJ6WTlHVFc4SkgxcWxGaTBkMFo3S1FuZWl4?=
 =?utf-8?B?Z3V0cUU2ekdDRXVWUys2MEh5TjRodnUwWTB3WU1tL1pybGoxVDkveGE3d010?=
 =?utf-8?B?NGJmOFFyaEtQdmpOK2I0eXJwNDVlM2ZvR2FLbFNWUUhUcEFVNko5V1VoMUlv?=
 =?utf-8?B?OXp3Z0NBY243ZlBmYm9qek1CRlE4ZzhBaHhqbmVLZTl2Y1J5Yll3eER6d3RM?=
 =?utf-8?B?RUxkUXduc2M5cDd6QlVUT1pGZklVMUczVmZncllyQ25ubmV4QUFXbVF0NXZS?=
 =?utf-8?B?Y0t4SDVZclE0N0w0Y3ZQbnBhcThJbGtpcVZUMFB5d05ZaVBqQmhNdUNXM0xQ?=
 =?utf-8?B?M1llQzd3RklOTmFmR1g4NnNKcEptbC93eFpNNUxMRGtLSGl2am1BT09HcVVC?=
 =?utf-8?B?ZVhSVyttR0Z2a0VnUk9IclBPTVNtUWhIOHJTQkhXdFNteGtvc3Z3TmJ4dVZh?=
 =?utf-8?B?MjJRTC9hSExSOEtRT1NFT3liVllZRFJRU1lvUm8wSWNEVDNXbUxEajc5Q1J2?=
 =?utf-8?B?MVVvNWg2TUFZb2p3eUc1a0ljamRlTEd2aGMyUUhiMWptQXJjZ0lKKytWdWpV?=
 =?utf-8?B?N1M3dWtHbmxidE9HbVJNQjFlLzVmK2ZLeGRnL1U2cEpTMDJPMUR1WGdXM2RL?=
 =?utf-8?B?WHRBYjJwbGpiWllzRDhzYllxVGU1ZmVNMDBqOVgrNzhrL2xNWHJRd0ZPMkxt?=
 =?utf-8?B?M1lVUVBxV0tvZ3FuZDF3Q1VtVGhDVitDdHlLMytjVUV5aXpaWnhiblBxbzZz?=
 =?utf-8?B?R2FGZUkrR1FkWVM3N2FtQjdMM1QvQ2JXZlhmcm42emlqZHJpVEZUOUhQc3Iv?=
 =?utf-8?B?OXdCTTg4ZG1DajZ6ZFJBZml0b2crLythK1N5Y2F5TDdGK1ZiTmx3eUVtTVli?=
 =?utf-8?B?U0s1SDlVMWp1cFI3R0IyL21wUXE4ZDlBUUMyWXEvR1lEdFdWYmMwQlpOM2xM?=
 =?utf-8?B?NTZPTkVkNXRrVE55SjZEbnVYN2NDYjhZa0FoWE0xc0d6ZFU5djFKSkpwOGcx?=
 =?utf-8?B?M0tCN2NwQVc0WDlJVEI2YkF1eEJaUDJFZ1dkeGZBR0dUVng2NWNxZDRkVGZC?=
 =?utf-8?B?amhwVWRjeW1PWW9Rekd4UjIxWnFET3A0ak8vNkJ3ZDNaVUhqRlp6U091UUJz?=
 =?utf-8?B?bCs3ZVpwU3VaRzExK1JXY1QrV2IzNjB6TWx6VmVObTUxNlBGVFhyOERycnBK?=
 =?utf-8?B?ZzMrdG1JMUwycU8yajYxMnBHUDgvejg2a2F2T0RORlB6UklreWhYSkpDam5m?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd848b5-2d6d-4b82-f96e-08dd14badff3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:25:01.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcOJcOnW5rdFznKX58a0wAOA9HGkuEIjrWMrcDgZFKqhIaf6RdTp8tWHjmRNM8/H6W9Jwwgwm8bSq8R/kkhOCulhsmju9EjoGO9vTrKIY+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com



On 12/4/2024 9:12 AM, Vladimir Oltean wrote:
> And there's one more thing I tried, which mostly worked. That was to
> express CHECK_PACKED_FIELDS_N in terms of CHECK_PACKED_FIELDS_N-1.
> This further reduced the auto-generated code size from 1478 lines to 302
> lines, which I think is appealing.
> 

I figured it out! There are two key issues involved:

> diff --git a/scripts/gen_packed_field_checks.c b/scripts/gen_packed_field_checks.c
> index fabbb741c9a8..bac85c04ef20 100644
> --- a/scripts/gen_packed_field_checks.c
> +++ b/scripts/gen_packed_field_checks.c
> @@ -10,9 +10,10 @@ int main(int argc, char **argv)
>  	for (int i = 1; i <= MAX_PACKED_FIELD_SIZE; i++) {
>  		printf("#define CHECK_PACKED_FIELDS_%d(fields) ({ \\\n", i);
>  
> -		for (int j = 0; j < i; j++)
> -			printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", j);
> +		if (i != 1)
> +			printf("\tCHECK_PACKED_FIELDS_%d(fields); \\\n", i - 1);
>  
> +		printf("\tCHECK_PACKED_FIELD(fields, %d); \\\n", i);

This needs to be i - 1, since arrays are 0-indexed, so this code expands
to checking the wrong value.

CHECK_PACKED_FIELDS_1 needs to become

CHECK_PACKED_FIELD(fields, 0)

but this code makes it:

CHECK_PACKED_FIELD(fields, 1)

Thus, all the array definitions are off-by-one, leading to the last one
being out-of-bounds.

>  		printf("})\n\n");
>  	}
>  
> 
> The problem is that, for some reason, it introduces this sparse warning:
> 
> ../lib/packing_test.c:436:9: warning: invalid access past the end of 'test_fields' (24 24)
> ../lib/packing_test.c:448:9: warning: invalid access past the end of 'test_fields' (24 24)
> 
> Nobody accesses past element 6 (ARRAY_SIZE) of test_fields[]. I ran the

The array size is 6, but we try to access element 6 which is one past
the array... good old off-by-one error :)

There is one further complication which is that the nested statement
expressions ({ ... }) for each CHECK_PACKED_FIELD_N eventually make GCC
confused, as it doesn't seem to keep track of the types very well.

I fixed that by changing the individual CHECK_PACKED_FIELD_N to be
non-statement expressions, and then wrapping their calls in the
builtin_choose_expr() with ({ ... }), which prevents us from creating
too many expression layers for GCC. It actually results in identical
code being evaluated as with the old version but now with a constant
scaling of the text size: 2 lines per additional check. Of course the
complexity scales linearly, but that means our text size no longer
scales with O(n*log(n)) but just as O(N).

Its fantastic improvement, thanks for the suggestion. I'll have v9 out
with these improvements soon.

