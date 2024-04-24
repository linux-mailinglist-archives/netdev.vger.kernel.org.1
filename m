Return-Path: <netdev+bounces-90839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3248B0675
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1D11F21FD6
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B834158DA1;
	Wed, 24 Apr 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFDqjplp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAD13DBB6
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952364; cv=fail; b=EkyPULcXGikwp3CnOFpBFZNC/rAQ160IM6wLXbktDAC6g7QDkV7Ft2w51QYybzKTkcMClKazWxySuL2egdHsQ4DTkTQRR1cr9VtO5OA95dgJUmb8JMFCFjz5AM8fRrDeZ6EC4olvikWhiJeXQskb0uBodNkXQ1nA9IQQw5EsWow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952364; c=relaxed/simple;
	bh=7dDtFM/0gX4PbV9QgABfW2ytT3r7lEab0bXg5Kjin8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QgEC38c2GMOnR2U4ckPZaRrvwhOVQpfnZhYy9R7CM272sJqbfXYYE0KyjPMwoByHUQwEfsGWhcozOt9+1HyZOBSKuBgnET4Ov8drZ3j1dZVpg26lmVv+SWK3XkNkcUCk24HPfvYihDhk4f/z3TXQA/8Lfx5rlEPnDnppbkuwc7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFDqjplp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713952363; x=1745488363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7dDtFM/0gX4PbV9QgABfW2ytT3r7lEab0bXg5Kjin8k=;
  b=VFDqjplpuKuJQ6rguKnfFk1xG2efmzn4zbnSxPoTRyuWbicZImIzgWRP
   3h9V5l8kCfZFD3QVFGFFoWgj+2iCBxg7bMHZpQKbDELXGbhrCFhzNddVv
   oz7DtJfiSAe4V24N/1FbHGmP5HDLR4S4ovOZJEXQGXMSAtvdyeHX6iTjC
   Iihmwt7cZVPwkfLH7X5wkz9+lWXdfedR8YcbKr4bBOvbBQq7C7c7pen5U
   vN6Er6KkbVVxPb41s0KolrmyCX0524P5UkxvHOjVLUyuheZBi3kgD0nMp
   0OAsdnGi9d5cqXbvrO1AJ9e3Xy636YRTK/yuMD8Sy2//8ETWL30r7/N9u
   Q==;
X-CSE-ConnectionGUID: QrWJBtrsR8Gde8ICsxLMwQ==
X-CSE-MsgGUID: 07fsl93/QwGHQMwqYsUcVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13408417"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="13408417"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:52:36 -0700
X-CSE-ConnectionGUID: SAkGFKd5QDq9E2L7fWIScA==
X-CSE-MsgGUID: gCFA1innTqeJAcb3bLdFrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="25104581"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:52:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:52:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:52:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:52:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMhznxHCa9VYwSHKh3CpNTD4z/B1/G2ePbKSMJ4EfXwYFB1t1fe5MkgPnjnAhJy3k0ADZGni4T6fOvAqxZ2X2TcmGFO2KWMkG7o+CyzP/72dmyd9NFlczBM4IxfPi4gcf+VX9oMLoRkJ3NH6jhMd6fh10BgBAfXzPFYtR5VgoSAwJU8LkcYuHH8xUnCSOJ3RcyPucyHJu8D/B1VCVTknuAcH77XsGaXWGb8Krf17ciYSCCL1MSheknI+DwG+xQH1WRGBX1Pqh1JF/I8S23hKlHA/Gdkllebhh0XKdNfU4znz8S1RJGPLnvdXiH44MGh4JENrtWUvy1JsaK073pYdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DELaKfq/bHP4aF1HAMAhsyI3IPclmm42XqGPs8EMGdc=;
 b=m8Ze79iuF4VZBvu/2TCrsO1UuUNWtDbuuyVLD1ldexJ+DQKgfMz/N6mHfbZT3xeo3CTbiQpcTN51r5Yj4kNy82Tld+dyNDGDvN2zIUc3qjGGiru6/MMU46nocxnt/ReHatsATgd0seWfPhc/U3ejqJxz3O/t78iaT9uK8ECp714fJZ/FX30TfzjdY42E+aWt9asiU5KI2zsog+RdxnZoJ9ILhgnr8gJOg60+cSGr5EURmGT6Opjwlm9g9JAoYr4Jnmer225aE9WLp76Owk1Bj6RmVsW+PrBEFJ0bTz+j87/xLtxUd0WPMvCtyN9DWzk3uApN6c3kCK3+qXNVAukLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 09:52:32 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 09:52:31 +0000
Message-ID: <598d25c1-3361-4f01-bbaf-ab335fba3da3@intel.com>
Date: Wed, 24 Apr 2024 11:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Jiri Pirko <jiri@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-2-anthony.l.nguyen@intel.com>
 <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
 <fa6e7d19-e18a-4146-983b-63642c2bf8c0@intel.com>
 <fc3c9135-ad5e-4f32-b852-c08cfb096492@intel.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <fc3c9135-ad5e-4f32-b852-c08cfb096492@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0070.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::20) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c1458d-fdda-4b0e-0cf1-08dc64444255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWRzOWFZK09vY2I4VWtIelFKRWo4L29xcnBDZWVGZ0VDRkVRZjZIV2c2VWxw?=
 =?utf-8?B?elI3ek5oeEUrYlNzZThZZGJWOWpXTm83NE1SeTdvUHowVUdYSlhsZFkzMjE3?=
 =?utf-8?B?aE01V1daNk9DNWZkT0swSnhyTkZocTlSdXZhbjZMQnQ4U0NhREJOR1kwUGEv?=
 =?utf-8?B?NFllQTdkVzBzUU9pczZBVU1sVjgxOFlrYXNUclVTZ2RGc1JmZmc0YjlqbERs?=
 =?utf-8?B?d0ZxWFJnUnJTQUUybkZhWHJHb0NRMUo1KzVUUU1ubE1IWTQ2YXEwaW85dnIw?=
 =?utf-8?B?M0VWc1JOTVRvNFQ2clpxL0U5YXE1ekZPV3BZUVBnNDRPTXl3YXR4TUQxSi9s?=
 =?utf-8?B?YUxwL2NhU2R6U3piTk5tbWhURzBuMjlWUDFzcy91QnNySTBDc3JVZzFSalYy?=
 =?utf-8?B?Ti9ENW5OSXdCalVYd1JHcS9IdVBVTTdNNUxBVlBCWkw1ckFyc0JuMEV4SThL?=
 =?utf-8?B?OVp1bVowcWc5cWtwcTVYNHhxL1BRUjliMlAvdVZCQkZabVA2UnRvRUt0ZEhx?=
 =?utf-8?B?SVp0bUcrVXVnUUo0TVhMUWhVdlQ4UTZCckFlZWZ6aWJIVmJuc1RQbVpackRu?=
 =?utf-8?B?djFmd2RET1JZOWMrendxcTVXeXZPUy8rWGFNWmlFVTFhL1lmNk40Ni9McXNm?=
 =?utf-8?B?UkoydWlnaDlOTmRBVzRUSWc0bk8wZUZOY2ZKeml5VUFqMXVOMVAvUTUrS01C?=
 =?utf-8?B?RUNncFkzWEt2ODhIeDVIOEpqcU9STXM4MVRKV1Rwcm5zRHl1TUlsSmJINkh1?=
 =?utf-8?B?dHdsempBbGF6TGFUbDBGQ2tIcmJKSjNYYUJneUFwbkdUK3VmbzMzZW5sMWEz?=
 =?utf-8?B?OStVNjFhcjJPbDdKN0hLcGhQdnphWWwyTkI3OVdMb05uWDA5NzFNb2Y0Y2Nz?=
 =?utf-8?B?OHNPYWlpNWk1YnBpaWpMTVlEMkNOYld4RTZBcng5ZW5nYk5ONElldVYxekkx?=
 =?utf-8?B?dXZqZU1LWGV5M245TzJ2SStIUjk5dTJoRzQvUWI5UXJpTnRCQjFjbXF4UWhU?=
 =?utf-8?B?Q3A3cDFtRXlKWGRtcmRURUhtSmlVWFRJS3VORjhKVjhxNkpXMnVDVlpkYTdx?=
 =?utf-8?B?WjFnNDZsdmNzbnpQSVY1VUFKYld6NWF6Q3JmNTdGeDFwYnNYaVdGR0I1a20y?=
 =?utf-8?B?UDJmY1VGY3l2cWs1dWpHaHNWRVJMLzJabGVralB5V2JCWnhlTHVSYjUrRVRp?=
 =?utf-8?B?Ly9YbTE2VGE0R0xYVEU5VGJuYUdjZzY1TTc4elB3anpEYUNlcjM0S2VTZ2Qy?=
 =?utf-8?B?M1FGNFVmdWovT09CdU85YklmWFhqM1BieTYybmQ0bDZlZzhPSC9wRnU3S000?=
 =?utf-8?B?NHUwRWQ3bEN1Y0d6dnhieVdsb1NSSVFlK00vM0JMdTVOeGEyT1RWYzNIT2xJ?=
 =?utf-8?B?UExqNlZaQU9QaURiRkREYnBUcmRmejBPbzNuNy9jQitYVjV3N3UzMWR2aXA0?=
 =?utf-8?B?VTlSMW9oOVdvbHJvMk94MlNSd1RYcUhycVZTSGUrV0pGVW5OQmtnZHl6c2Yr?=
 =?utf-8?B?Mm1obnhaTFlrRXZlN2RjTUhJemQzREtTbnJHakE5QnBsVXNXZXpQZlVlU3c4?=
 =?utf-8?B?V1p3UjVCY1UvNUdNU0U0MHQxYXdrZTQ4aG9OTWd2Mlo5bGV4akFDckwzSFNE?=
 =?utf-8?B?UU1LVkt5R1QyZW1aMXdka244dytHTk5lekI0ZDVQaWMrb3VUaDBaM2dBeENC?=
 =?utf-8?B?d1hhZkFTKzdsdVI4UlVDbFNjc21LdHFla0xoWXNEUUdDM3dwTXYvL0FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZXbUtOdE5PN09walZkS2xrTjAwTCt2UTBlZHNGNjliemJYT2pxOSsvejc2?=
 =?utf-8?B?aEx0QTdXMjFuQlpXa3cyL3MrVTgxb0VacFE3OStXRkxDbmpwTFdJZ2F1QmZQ?=
 =?utf-8?B?T1FWYzgwaEk0SWNXVzh5RGU3bHZtSVREaXhRMHNLZDJxbE9lNDUyR3dnZWtV?=
 =?utf-8?B?L0JBWHdjU1l0dDE0Y2V2cUxBU1RvUFdCQ0NHclRYZUJQNkhROXJTdlR3MXMx?=
 =?utf-8?B?eUc1UkJzZHk3Wk5na2Z4TUZBNmw0VGFTS3NwN2M3djJzdjZ3MHFLMUFrOSsv?=
 =?utf-8?B?WXhYanhPM1hPa1o1Mm1qcGpDRTRrbjl5Ym9lTFFqVXdwSkwyZUZSSTJFaUpX?=
 =?utf-8?B?dFNYWmhyaE9jVWxxVHdGVXJyVVFrSHk4V0paaTdOREhPVVE5ZzVPM0t2Q2RQ?=
 =?utf-8?B?WW5oUVJxS3prZVRLTitCNE94VGFrQzlodTBzQzEzZzBXNkIrRlVZWmpxNUpj?=
 =?utf-8?B?cmFaS3BxMTF1QVl5YjV3dmR6bWM1ZW81eEMyT3RpaDRUV0JlMm5tdnRmM3Jv?=
 =?utf-8?B?WktlTEk5WWlWZW9XY041RkEwcSt6U0xlSVhoWWc0RDdUOGMrOXlneDNZcXBZ?=
 =?utf-8?B?YkVNZnQxR3JyL0VrUjNDdGRxNWRZRXA1MHI2em9UaUtnVFRYQzUrL2NwZDBO?=
 =?utf-8?B?bU1QR1ovNHQ0V0FYY2xxQUFSd3RtaEJHVE9mWnFwaDJuYncyQTBtckIyK2po?=
 =?utf-8?B?Uk9PUDE4bldZaHJPK21JYk94MGRndjlRUzBGWVQ3eEhkNnBESXRob3hhVm9F?=
 =?utf-8?B?c3J0Z3V0ZGRlT01Ed3REUXlEQk83cURCdjdHWVdjdlRQaEx0dmpCV3NnNTdL?=
 =?utf-8?B?NEhHeWdHUDNYL3dHWXhaL0QxUWhaMkF4QzNVeFdPUndpTGM1WjFXb0tJM2R1?=
 =?utf-8?B?MHF0QTFVUXRFNVhYQm90UnJXRlVJS1IycU85SXpzTmVkdTdDeVZITVRrUGtW?=
 =?utf-8?B?YTF4SDl6dklXRnkydTQvWTljZmpBSnVuQitBR0VjVit2S2V2a0hMMmJxNUJp?=
 =?utf-8?B?SmxzaVlGNnRBR2pLeWw2dWhqV3pUL2FSdjlycHJ0RjYyY0xCdHB1eXNWQzUv?=
 =?utf-8?B?QjJVQ0h3UWdFeUttTkNlVVBoakpXN2tTZGYzQTVnVE94REg3Mk9IVEo3eVI2?=
 =?utf-8?B?cXU5TlNPY0w0U0FPcHNaa1pDOUZCMHJQMkphTmNUNmFEd2YrS1NoV2YyUjhh?=
 =?utf-8?B?RWlKVHNMa1NPYWg5L3VkZlZQcUYwM3BvSXRXVzRlU1UzZEJMc1JpK2FzR3Aw?=
 =?utf-8?B?OTZESHRmeGdXYVNCQXdna2V1UWtSOElLck51YWd3TnllUHJTd0NqemU3bkpZ?=
 =?utf-8?B?OE1pRy8zQnVtSHBKWU9yd0UrL0Faek4wbXJiSzZBRElTU3pXa2N3anR6cmpj?=
 =?utf-8?B?SHA2NStZOVpQWVJCbVFVV2dBWnUvOXpzNS9nSmhPaCtONTdPVmo3dTN3bjNp?=
 =?utf-8?B?SDJta3IvYnFrYjN5S3hpNnhBWEZISys5S2NVMWJYM0g5MHZZL0s2SkFRRERN?=
 =?utf-8?B?dHdmVkdMakhKanNYYVhpYlhSVDY3bTNjanhhbkZwNTU0UENYVHdHd1RDcUZl?=
 =?utf-8?B?NFQ5UHJSUDVzb3dZeVlON1dNSWpMTDJIY054SzdIZnI1ZVp5Z1JrYVFqS0h5?=
 =?utf-8?B?eUhmTCs2WUVHWktoOWh6WER5OGdTdzJyemZsSEsrWmxybDlnNmhaa0FSRjJl?=
 =?utf-8?B?dHQ4dTBwMzgxNTYvQnI2dTdYb3ZlNUMySFIySDVkdWVPZmFkODVZaWtZUk1F?=
 =?utf-8?B?bG1nRG14a0ptZ3E0TDg0WmxraENNc2VvOXZOTWhmNnk4U00rY1RNMk42eTR2?=
 =?utf-8?B?V0dSVm1tWVJLYTNDbjBEYVcxb3NpbXRSY2xBK1ZpNDZOeTQwclhTNHhZaENn?=
 =?utf-8?B?ZVlocGdQYlRQNTZZR3RuV3dkYS9tclA0WllzVkxWWGk5RDdlUGdsRzJhVVM2?=
 =?utf-8?B?ZjVQbHp2VnhNQmNudEpTbTFiNk14a0RCUWVuNzM3NVNvclFTR0tYLzU0TFJQ?=
 =?utf-8?B?MXBuNFN4ci9EazRBamVZbnhodnp4a0RrSnQ0OU1DVjJmUzZ3N3U3UDd2eEFT?=
 =?utf-8?B?OEpJZUZLdkxmVjdPZkMzeFp6b3hBOXMwV2FhbVgyNUJGb3lLUlE3RnQ2SWp2?=
 =?utf-8?B?OFRHV3pnM0tUSGxHRy95b0lEOUlSbTJuRzNoMld3cW12ckFGRWkrWnJock1T?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c1458d-fdda-4b0e-0cf1-08dc64444255
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:52:31.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgVFPTDtlGozmIJCLEwq05L8CZD//GCrvR2rEprPbtA8Jfk6FquEJHL5lB5fYEcgDnRBv5bY6q7+4Yxa1NrWthxyF4AETwOVIr6aCz8trXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com



On 4/24/2024 11:24 AM, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Wed, 24 Apr 2024 11:20:49 +0200
> 
>> On 4/24/24 11:05, Alexander Lobakin wrote:
>>> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>>> Date: Mon, 22 Apr 2024 13:39:06 -0700
>>>
>>>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>>
>>>> Extend devlink_param *set function pointer to take extack as a param.
>>>> Sometimes it is needed to pass information to the end user from set
>>>> function. It is more proper to use for that netlink instead of passing
>>>> message to dmesg.
>>>>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>
>>> [...]
>>>
>>>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>>>> index d31769a116ce..35eb0f884386 100644
>>>> --- a/include/net/devlink.h
>>>> +++ b/include/net/devlink.h
>>>> @@ -483,7 +483,8 @@ struct devlink_param {
>>>>        int (*get)(struct devlink *devlink, u32 id,
>>>>               struct devlink_param_gset_ctx *ctx);
>>>>        int (*set)(struct devlink *devlink, u32 id,
>>>> -           struct devlink_param_gset_ctx *ctx);
>>>> +           struct devlink_param_gset_ctx *ctx,
>>>> +           struct netlink_ext_ack *extack);
>>>
>>> Sorry for the late comment. Can't we embed extack to
>>> devlink_param_gset_ctx instead? It would take much less lines.
>>
>> But then we will want to remove the extack param from .validate() too:
>>
>>>
>>>>        int (*validate)(struct devlink *devlink, u32 id,
>>>>                union devlink_param_value val,
>>>>                struct netlink_ext_ack *extack);
>>
>> right there.
> 
> We don't have &devlink_param_gset_ctx here, only the union.
> Extending this union with the extack requires converting it to a struct
> (which would have extack + this union), which is again a conversion of
> all the drivers : >

Makes sense. I also have to take a look on docs issue reported, so
Your's suggestion I will add in the next version too.

>> This would amount to roughly the same scope for changes, but would spare
>> us yet another round when someone would like to extend .get(), so I like
>> this idea.
> 
> Thanks,
> Olek

