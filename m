Return-Path: <netdev+bounces-159246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839DA14E8D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852A318861C3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2ED1F7577;
	Fri, 17 Jan 2025 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEGDR2t9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB819992C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113802; cv=fail; b=Y627NekTIhl5t0zb9aXrCll14zneJnzoxcdqjPna3fNZuNkoUdHBGViVridQsMC/AJqju1b8HOkCWGl101CkTydjVbWfF6MQyhBRbEhDYucdaZXg1Qhe8wV0ygSsu8S9assI3WoEEsJifWWRenEMpUTp9ztVFGNEOhvdydR0H3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113802; c=relaxed/simple;
	bh=KxLtQIYy5y++GBmi0LTvSBFX5dpQInAgEfneVxKXurM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RERBJzQf8U2pBtBndUCd0q03MfjSAVoUUVzDa6D2Bh94DCmPOh2Vh+ia3Gqif/DKsdHK6c2xK5Cdqf005t9U+T3l9qj1ThWRsQM8D1suBL1Kri5+Typ6yHFbPDhGIjaTZ3mFI5AY7oJurqzrHpQuhZtlM/UbFC+vyN6p2vPX9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEGDR2t9; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737113800; x=1768649800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KxLtQIYy5y++GBmi0LTvSBFX5dpQInAgEfneVxKXurM=;
  b=KEGDR2t9uFeLa6qkZmvPpXFkvw63pc85l6MDM0+AHmoK8spg26ZcYmzR
   +vVlbdK9MeGkvXHheuBUwDnF6tbwXh0gOtn6dKmI69pMQVEkRnQe+knic
   rXIChpyp1aISL6HzT2ZfnbhR93LnkdezcvYMFMXc8Usd9LBXjtWlQOnB2
   PNLEJrYHZBzk15LBHJuasGmKnsd4GTtvexvh2FGgrEbXW82UA6Z4JYwWS
   v/yEIm/v2p07Ca/gD5lfHp0tTEzxWDVP7JO6YldLQoPbWEW+oQsvvMejJ
   WOqKgq/epCbnXMhCas+7JunmzPTLJdW6j0m8qQF4a6JkGc1Taig+nFm2f
   g==;
X-CSE-ConnectionGUID: kEhfhwrTTGitO867TCua/g==
X-CSE-MsgGUID: wSiU6mVrTom71uXVO3l7eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48033359"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48033359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 03:36:39 -0800
X-CSE-ConnectionGUID: 8/c4L6tOSaiwvc4B//PScg==
X-CSE-MsgGUID: cGFolilJRMWCfCZxFQDh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="110786854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 03:36:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 03:36:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 03:36:38 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 03:36:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZN3DWRKvqjdrPGNDtE61ywyeCXm5zeQQ5exz5KCz1kwkpUszlYBPWfTxuliOknwSvG7xT5tZN6vFvYN/dYY0Xik7SgXKyUbQFp4BSbso+v9Vaxk6kPW4IrRoOi+EZUGgKL9TbpB4BW2TW1QCbZBqHibadYqWZyFhOmfr/Tw/2QDQhfzytjejSs0uRO3zrJ4jI6SONlFYNwdcuwI0R2TdYm98kfDytqYvnBE+7VAkbA7Umd96ONbGFAnQmtX1Q/gIA4ZT5BtoC6CS6GA7Z4tI0rHhVwXZejUpPzm+/fXNCbPXrLhNPAnFU8CQ3LB2ZX1BVUeqDHajdDCgq3Zw+grj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQKeSIkEzSqUZYGaqWdN94tES6YzuDvzW27ZBuug0xQ=;
 b=R7P4K7KYT9wUQrj3qIeuRMeyz3C1fSzbip6temqUK8zoHCaReU0Nkjlo6SIFkLbuo/CXp2Xd5WdTFZv6tDHc7lX2t0G3o5Za1JItBZT0eSKiZZO6BKQtZqHTNqBRBaHgx2GGTWVjcNqjJapQAR/gh7NMhT+EG1FBfCDiigL0JiCWXM9DDOg7Y0E2IOA6affBfdVd0pNu47IyHCsfmBp3Xkz7ISXGmaY0OYeLXt4QpL5sSD9ZdByxaYWS+s4NyirBsR2xkI84Dyusx1V+PiQKEil8FYlFxjgXYT5RE4IEfd6TC3RN+JAIoU89NDu+t0k8ISinsPqfQApMtdEBIPgYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 11:36:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 11:36:36 +0000
Message-ID: <6315c8d7-c140-427e-b4b1-ce5bbe1e536e@intel.com>
Date: Fri, 17 Jan 2025 12:36:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] mlxsw: Move Tx header handling to PCI driver
To: Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <cover.1737044384.git.petrm@nvidia.com>
 <293a81e6f7d59a8ec9f9592edb7745536649ff11.1737044384.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <293a81e6f7d59a8ec9f9592edb7745536649ff11.1737044384.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: c00337be-75ef-4789-933e-08dd36eb338f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWlmbjdWR1NZSHJvYzMrL043UktiRzRtR1ZUWk82TGt1SER6aC9LeGdZYjNM?=
 =?utf-8?B?bzYxWmZyQ2pKd0dmY3RXZ3FhOEQxeG1pSVVpL1ErL2tyMkF0OXpjazJaMGJo?=
 =?utf-8?B?ZGMwSkJtUjZjTHZvdVRBbEtPVjl1NDEwb2Z2YnpvWWZ6VWNZaGxIS3VnVHNm?=
 =?utf-8?B?V1IyZVFKS09GRjlaT3VYeUZoR1dUOFo5QU0xb3VBRTBYc2RVOEFIcVpJV0Ez?=
 =?utf-8?B?bVdvTkpvcmltdWl0UkxubGFzdFZqSkU4anRzL1V5NUhJdWdiU1E5MThycG1l?=
 =?utf-8?B?TUg0dnRwekpMam51c00ydmpNamZlVVZNY2FXajk4NEVxQWRxajFOQXJUUkpj?=
 =?utf-8?B?TVE5MXJva09qbzlIL055QkthZzNEVWR4czdya1hreWhxc1hCUW8rZTQraWJX?=
 =?utf-8?B?Q0FkdlFMNG9yL0hXU2g3N0FKQVdtYkdBblRrdlJXSk1OaXdNay80c2drL3Ba?=
 =?utf-8?B?b1pFWUtXSFBkMC85V1VEU0U4SUhub2hidGYvYmxqZlJyMTdWa1R2bC81b09B?=
 =?utf-8?B?VEdaRlVKWmxWWWVBNlNHYUpUQXRlaUlCR2VJUnh6bXQ0UlV6V1cvYWxoYm9h?=
 =?utf-8?B?Y0RnSW9xVEp1RkNRT1o3SFBoSzBxQXpoSEF2SmxGK2VjUy9ESnhnK1FHNXQ1?=
 =?utf-8?B?bko2MjZZdTNoR0xUclJXQ25acEF5ZGVuOGJrcWJUZlZ1UzdpTUxEKy9HeWM3?=
 =?utf-8?B?THVLZ05zOG1kQXM1UmIzOE4wN0VxV0F4VW9QVWhSQU13TStQRFdLaTFHOXhu?=
 =?utf-8?B?QzE0MG5NRU1leFQ0OStOQ3d0aXZoekk4blRTWCtSRVcxSUdld2xCaHRKWE5B?=
 =?utf-8?B?RVYxdksrWDhVK0RKMWdqWmJwdm4xK0lqQVNkY0NMS0lWdG1pRTBzQXF3OSt4?=
 =?utf-8?B?Rzl4aEhxUjJSemZyWk8wWnc1cWNhcmZZQk5LTjQwVTBIWWdkMkV5a1FIdEpR?=
 =?utf-8?B?cUFKRFMzYXJsSFJ2SnkrSHJndUQrVUhiSFArTXpsWUkxSzRhUVVLWmp6NEY5?=
 =?utf-8?B?WGhFUnh4Rmx1RVVvbmhEL0xOOHI2RGdIUnZqY3J3M3E4SDdTUTNjcndyTWNC?=
 =?utf-8?B?LzVDZkdtVHJtS2haT2hOTFBURUVhY2MrRUxPeEZ2MHlFMWVoazJ4MHpvaFJh?=
 =?utf-8?B?Vks5VjdHcXBNdjA1MUZWOTUyZVZZVlh1MGd4MVd6RmNyVlVuVHpMMXp2eEVu?=
 =?utf-8?B?Uk1UVGFWNUhnY01XWVlNZlZ6dWxkUUllazNIUTVxT3kwWStTbmt3NDc1WVRu?=
 =?utf-8?B?bHAyRm5SSXIrVnNRb1pXTGdxSllUZEh5eHNMdGJGKyt6MzR1d0xuTUVFTXFZ?=
 =?utf-8?B?NCtJRWlianBLS09hbHNKeHJTZGhreENuWnJTQUw0dnMxMm1oSGxkcGV6c1RM?=
 =?utf-8?B?SUQ4UnRLdlM2YzJzLzJYelYyckhaMHZxTXgyeTZUakJrTGo1bGhyS0t2QXlj?=
 =?utf-8?B?QW5aRnFBRGRXYzg5VkFnWFFFU3NnOEtyOVFDQzR2M3lEVUtmQTZOSlFWbHdG?=
 =?utf-8?B?M2FvKzJEMkV3L044MHhTOEE3dGdFcU1mWnc5d3dQSW1SSm9Mc1Fxb2pHVzB0?=
 =?utf-8?B?Ui8vcVhGWWlMN3BtU3RvVlJrQXA1czNDdXp4MXMvMGlhckdoVlVCbWF5bVRW?=
 =?utf-8?B?Q1pGaFNwcmtkenpXcmZVTlI0WkVXRExRYllsdzQyN1Q4VEJjTmJYTXh1S0sw?=
 =?utf-8?B?d3h6eFpoSVY5bUcyTE11NjFIdUR1QzQrU1J5Vlk0ZlRUdG1XSjkrc3RTdURV?=
 =?utf-8?B?Q3Y5WklNMkkzMGRhR0Y1aXY3RVJmSS9wWUtMM01NMk9LYk1Rd1hreFFrcEdv?=
 =?utf-8?B?NmxHazBsNjZKeDBrUE4rcXdQeGlZUzlZb003VFFMRE4wM1V1cWpTZnlKY3dl?=
 =?utf-8?Q?6H6DudvIRFibX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlp4VjZnOHVyL2M2M2JERUxWL2xYZzJhdUZScWpwYjNGN1hqbVlycUd5S2ps?=
 =?utf-8?B?TFVwYjR6S0YyV1piNTE3d0tYMmZ6NmY2RENEaStldHhyZnVKb2RFV2xnRTVa?=
 =?utf-8?B?ZG1oSVVoREhBOTl1VkZsSmU0NWxtMEM5d2k1LzVqc3hhai9FNFhXWW1WVUIy?=
 =?utf-8?B?Q2hxNFRyNzkvL1cvcGZ0d0tnb0h4aDdCWisvQ3ZhanBrY0FoODBZWGVRNFVh?=
 =?utf-8?B?SFNFNVFBcFJQUk10WTRLMzBDVTdlSy9MOXVETWpnM0swN1JCWnB0UU1NS2Ja?=
 =?utf-8?B?dXd2citmdWdrMGc4ZWxOcC9KM0J1OExiWE5HQzArVnpsK3E2eUcrOGx2dmxx?=
 =?utf-8?B?RU13K3RISXRENmxNUmtYK3FVVmUxMnpWRGEwTUlhNFJOWjU2SG9yWWtIelRH?=
 =?utf-8?B?eE9jbzU5NjV2cE1DTkNkOUgydGdIbUdSbUNsNlEzekFER1FIUEZtY3UraWNn?=
 =?utf-8?B?cnloWUVYNWp1L1NFYUYxYnRXNHFIT25CRE40NG84cldUMVNhcWtqOURvdGky?=
 =?utf-8?B?bTk5d29mdEZ2RVhqN0dkLzEzMFBVZS8rSk1OUHhxTkRvSnhwRzVtK2dzOUxD?=
 =?utf-8?B?MHRGRk5VRWg2V3pERCtXcUpEcC9uRzk0OENSRGkxcWRacCtQdElUbkovRDkr?=
 =?utf-8?B?YzhQbFRFM1c2VkRVcVdpeGh3dlFEY3YxaVFBS2tIUXlaeGFISXZEMWZDTksy?=
 =?utf-8?B?YU1sZVY2ZTB5WEFITE9oai81cHpOQUlOUjBaN0lDUWJxNHllNmw2WkxMNWQ5?=
 =?utf-8?B?R0JKMDdnalNEd2U5RmxnRDlXZFNXL1pOdDRiZ0R2bGlxK3d5cjQzTU9ZbTcr?=
 =?utf-8?B?QmVIWnRWYjhyVm4xU29vRjN3aGRaRGdGZVZRa01KeENiUmJxeXY3YmZQM1oy?=
 =?utf-8?B?TnBZTXQweTZlUGtLbllEcWd3WVZBTVVEb004cC9rcXIxYWxQdFdTT1BRSG45?=
 =?utf-8?B?STE3R1dSWGUxeENuTDNWZlY2NnluaTlzV3VPVnlWdXBITUFjRzREVkVXQ1Vh?=
 =?utf-8?B?MFg0VFNuL1p6QkhiYWczMDE2OE01cjA3RVhTT1B1aVlSemlVMkNudUpMWXJ1?=
 =?utf-8?B?RFRyRVNCRW8vbkVuOFBVSisxRWZrZWJ5MkhrUHVVUjJZUUowWkxDY3hPdEsr?=
 =?utf-8?B?aGx3a2MwRUpCWXdTSVJBM0tTSjNMNUNNdjVZRldNTjE0eUpxdnkxaVpYSVB2?=
 =?utf-8?B?citkNTRDU3U5UlZWbm95L1JLZWJTOC9uWjNPNUtyZkMzOHU4eUZwZE9Hd1VT?=
 =?utf-8?B?VWU2VThFWTc2ZXlUN3BjNStsYzJWc0d6d0lwd3lNUXZVZUxIck10Um9VY2g0?=
 =?utf-8?B?R1puM0V6MDhld1lIbmNWUFUxeXlYd3puSXZzaFBrQTE3K1J6RTUyTDZoRnpD?=
 =?utf-8?B?SUcySUZlSTB2a2Z0cnZpcDZ1ekhEWUdBYmNobDNnWVlJblRzMHhLTnRhOFI1?=
 =?utf-8?B?a2RCWW5abko3TzZvVktoekF2WEhMZFAxQkJkNnAyMU1SYi8xc21QaXlVNWhK?=
 =?utf-8?B?ZlFKVUMrdnNCUmZweFlFdDV6Q1Y1dDRRSndURmNRcXk4dTJpSERLL3dWMG1X?=
 =?utf-8?B?OWRJZ2xweTN4ZTZucW03M2prdVpRSmRyMnJqV040angvb2xLNTNlVDhTRllW?=
 =?utf-8?B?SE1pb0x4TVM2YWtMUTl2dGZwbGN3eXgzUEd0WkpnOFREeTlFZjc5NW1GcmNT?=
 =?utf-8?B?Rmh0MXRtR0pUMzQ4aTdZU1RObXU5MHhVS0VtVTcxV0cydzc4RllZTFRzVlJ0?=
 =?utf-8?B?SDFhT0diRytvVDJVYjgrVTNwMDVDc1lkT0hkbHdFWXYvYlhMZXRicmZZdFNH?=
 =?utf-8?B?cGNjNDIrUjZtUzVIN0kxTlhUTFk1b2l2UjE4N01pSXdjQzdIWjIzK3hSaEM1?=
 =?utf-8?B?bTZIVmtWaVdQUWdOS25xbXVoVmdrZUFrblZSSi90cy9TVjRGYVF0MGJtM2ll?=
 =?utf-8?B?NExyL0dreXNabHkvQlgzZHA0OUNPL2d2V2xrL2kxRWY3TkkxN2lOWUNzUmdp?=
 =?utf-8?B?Q3NTVG1hRFdjb0JlQjJKcUEzU2s3MUpTeFo3L2dUQ3pGQ2MwS1RwaGJkZ1dw?=
 =?utf-8?B?S2lNRmRuZkxCZlFjV0oybVNWaFlWTmkvdU1TL3ZIalRMNjQrUkdrQVZ3cDVp?=
 =?utf-8?B?T0tVMnR0bjlQK3dweGhlWU1iUjhydUhhMjFteHZRYURWQzdINHB4ejRyeVZN?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c00337be-75ef-4789-933e-08dd36eb338f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:36:36.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZKtGIvc6Ch675O9lwX9UQ6kdlORNsueFNOyJfFLZ/86dJO2oGc8CaOMPvnEvbt2L5unOFlD0hVR/pp9JkZ/FncWTdBg1RcsV4N8Ze3RUOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com

On 1/16/25 17:38, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>

Two nits, not worth a respin, perhaps you could address given any future
change around this will come.
(but still please educate me and reply to the last question).

> +static int mlxsw_pci_txhdr_construct(struct sk_buff *skb,
> +				     const struct mlxsw_txhdr_info *txhdr_info)
> +{
> +	const struct mlxsw_tx_info tx_info = txhdr_info->tx_info;
> +	char *txhdr;

I know that this is was just code moved, but u8* would fit better as a
type.

> +
> +	if (skb_cow_head(skb, MLXSW_TXHDR_LEN))
> +		return -ENOMEM;
> +
> +	txhdr = skb_push(skb, MLXSW_TXHDR_LEN);
> +	memset(txhdr, 0, MLXSW_TXHDR_LEN);
> +
> +	mlxsw_tx_hdr_version_set(txhdr, MLXSW_TXHDR_VERSION_1);
> +	mlxsw_tx_hdr_proto_set(txhdr, MLXSW_TXHDR_PROTO_ETH);
> +	mlxsw_tx_hdr_swid_set(txhdr, 0);
> +
> +	if (unlikely(txhdr_info->data)) {
> +		u16 fid = txhdr_info->max_fid + tx_info.local_port - 1;

Again copy-pasta, but would be good to explain why -1.

