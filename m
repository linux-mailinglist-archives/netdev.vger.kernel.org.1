Return-Path: <netdev+bounces-170176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CEA47961
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B211719CA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7582222D4;
	Thu, 27 Feb 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6d9fZ60"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD42270024
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648844; cv=fail; b=Rk3UwaGdFgdCqhPDkwkSLnP3C9kF5vaIccCY61XU+UZoYCrnfNlfFlhOD9W+Oi1ePsHBIyBwG9BJDOIodQGEGzKCjghRPyTgxapXYTa59rwF5ddp6NYY8eKkV9Zw8T066uVe3YAT3eQfbnQkquQXGDwL+BgpcSPakgPTWrJTJbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648844; c=relaxed/simple;
	bh=doinEHCbxsK6Ar4XksnGGGOvu6jszxhjOeixLnXycVI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnexvWOt6U/zSyOKGFDHWD13bGLfW2ToSzdBnVJEQKOovxv22+AQ9wSsiyuMdVi5vqjxwpUZsvsaepbSh2DXtLN1+qGvob3x/2WyjRRY4P/75aErLIL6VclFjNDN0rJ1runZeP6fvjqoBgvCQ5kPDQq8vkb3dLAjoWCT8PtqqUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6d9fZ60; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740648842; x=1772184842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=doinEHCbxsK6Ar4XksnGGGOvu6jszxhjOeixLnXycVI=;
  b=e6d9fZ60ITDr2WC35E78hchrBb2j7eAhB+kFFZ5kiZlGs/v/HeoEBMpt
   /hAkdpMRRLKCQW3RkufSRMjbXdFC8WQLTD7mesGMFjVxFPEZcxUj/vtl0
   xC5Kx1LzNYGFIOK/com2TpCzoxvh0Uc0bqdD2KZo0hT2q58gsfHeFgiEQ
   pqq5EfA5+qAT4vsA3h0vLFHS+M/nh0sW+pt9NM4nDTbaAhpW6h/JPS1Ad
   2dBLFY4yFr3UVYuhmHo/8pgY0/xGRlFDY0Tbl8QxBCqv3oag7LFBgjUNg
   JBpTejQ+C2thC6p0S+g8HYVwL/HLG44TIIPC2aTkoO5PRwq4B8S16bCRd
   g==;
X-CSE-ConnectionGUID: QaAnzH8dTsGztErS/iKzAg==
X-CSE-MsgGUID: rnqFBb+tRf6G+LkQzJ6Rag==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40706099"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40706099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 01:34:01 -0800
X-CSE-ConnectionGUID: aIN2ed1RSdi729bMYEUshQ==
X-CSE-MsgGUID: si0Gne9rTSCFT+J4MMIZNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147895225"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 01:33:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 01:33:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 01:33:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 01:33:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbd/Qzip9nUhZrwe85Ny+HQQOd+Xsr9MXHW4NbdjOeZ/a93EHO1YT8kun78m/3vPROgiAQhXkAFKGsTfeotgZBTFAgf0GHOz7YlzEYNv7wuLFKOBV/ORQvzGVhm+eyNT0bSMllMRQ0Q9wOLf1VPoeIIkU/3jOosxnc7GmthSWScVZcuPA+Zqw3ZMcP03ivfRoyEI9rPnrY/Ut7/MQZqAnvfiYlHt4GVNHsd185GCwXDBEM+h9F1qPMcc1nWVT30qnU1T7yWLFEgrD1fiGT7+yLoaNB15fDldsmwFsVy3B6fRl9kYC6eBgBorVLPBFdXvGPJg2RD1ola/YYnKWLZuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPXGNltfX4sJDLiHu5ZV7DATiqI7aRZQMnQKkKFhFEQ=;
 b=iaUJ7WCS8drCsGDorrNU4QO1dJBRvXIpnJ2vIl4Blfp804qV+GxmeeXt6fRhj3JXFWp82JO463XMkC8ufFsUUK6R/26TpVzStglHW1/SPQoG/frKeWsyzatxdaQbaXrmU+CHDKls4jgJfcVAlaINC1/DwcSrAJqCRmoBMIdnlUVdQ8RXsPE/1q9tSaL6FeXYVrO80+rOpvQYOr6NAa+qVXB387hATbl7Mduf3zaubSuHRdpSm4wfn68F1E7Maufs25fMXg4TgyzNj5A+abQPuIX1S1eqddSmCVh6MDu9vWMgwBjOzdu2ky6wcWLvObx42cyOel7njvwLMxLuOH32eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CH0PR11MB5220.namprd11.prod.outlook.com (2603:10b6:610:e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 09:33:39 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 09:33:38 +0000
Message-ID: <9b35544a-8666-4828-8871-8cd38b189417@intel.com>
Date: Thu, 27 Feb 2025 10:33:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net-sysfs: remove unused initial ret values
To: Antoine Tenart <atenart@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: <netdev@vger.kernel.org>
References: <20250226174644.311136-1-atenart@kernel.org>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250226174644.311136-1-atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::35) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CH0PR11MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 5560191b-025a-46a1-c0b1-08dd5711d0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWhDR1MxTVppbzdZVVkyQ29WOGxRTXdxU0R1Kyt1Y2k2dFBUekxpV2orMW4z?=
 =?utf-8?B?WHF0T0ZFemY0SGZaVHR6Y1BvQm82ajVEUytmZTJ6ejIrNE1LcUNGT0tKRjlE?=
 =?utf-8?B?QUtLcmszcGZicE9xVExaVEZYUDk3UWdqSVNBL1VLU0RuaHdiTnZCZ0RGbXJO?=
 =?utf-8?B?Yit1cldVL3hlcWJZYlRWdVVESmFHV1NxaUViK0pVc0JERWJ5QzN3YWtVcmJC?=
 =?utf-8?B?ZHJON1pFS0FpR01XRm43Ly83S3hVUklPUHoyb3p3MFg3bWhEQVBOWTQyYnBT?=
 =?utf-8?B?NHVwdVM4c0toMXRlT1lYUFcvdmN6L3IzbU1XS3ExRWh1c1FodEVYbHV0WC9U?=
 =?utf-8?B?cVVQbTluR0JIY2RNVDh1Z2N0VUlXVlpEMDNVV29lSGxHb2FSWHN0anVuTVM3?=
 =?utf-8?B?ZDRoT2V4WCtNOXdOTURiMUI2ejFOSlFLZ1A0WWFOTVpQQ3UvdXViWDhDWFpB?=
 =?utf-8?B?cVdVTitnYjNSbS9XQUNYaWduU1ZtaHlna2JIRS9yd29KVWZmZnJWZTE5VjRL?=
 =?utf-8?B?YklFV0pwYjFxMkRya0RIUG1qcE9UaGJsVmpzb1RPV2FOVUIwMno4MThQYlEy?=
 =?utf-8?B?a0ZUMWRTazRqaFpkTVNPZGM3UzR4K1RZdHNsZ1JGLy9iRGFwN3dNajEwTFJG?=
 =?utf-8?B?Z2Uzd2F6MGIvK0VHSHlleWpLTXZGS2h1K2MyMThKSDI5Uk14QWZRSzFKNmZt?=
 =?utf-8?B?VXBOSUc0dlBmYjdrNDE0Tnp2Y1RhOEcwQ0ZPN1ZEeVRsUnJ3Zmw0ZjZ3YytB?=
 =?utf-8?B?RFk0UklPNlNRU1dEbGRNcE4rd1I2NVJqbmFmS3RLU3RTektxdGhVNVZGdnlZ?=
 =?utf-8?B?K3B4L0J3RHBQQjFrT0lDMG9DeEU0bDJZY2xwNlllWnRLNXdDS3V1Wm9vSFE0?=
 =?utf-8?B?S0hMTDJEaU5ZdVlDQ1dyY0QzWHhWN1ZjSkxhKzdPczA5a3Njb1RZY1hEUFRt?=
 =?utf-8?B?TkRmdnNrYi9PQWN3UmtiTHQzTkQyVHNETlBoMzV1VHJLVzhQcmxPVFJTc1ZV?=
 =?utf-8?B?djJwelczZWRET2diaU1BSFl4dTA2U1FMU1ErRVl2Q05ZejZYTU1kcWFUUmkx?=
 =?utf-8?B?RHRPVU5nYkU1NXROR2RLM3p1MVhja1R2ZDNZUHBqMUo1eTBSTVY2N3EzSkQr?=
 =?utf-8?B?RzJYdk0vckdrckNqMGI3cnJWMmtqOUlmNDFJaTlnTDFHYVlZVHF5NlN4MDYw?=
 =?utf-8?B?S2tCWDNnRDZGRHl3eGRHWnpMRUhoUkNJSHA5S3hIN2Zqdk1ya2x2YkNsUEp6?=
 =?utf-8?B?NGl6Q0lxZ1U5SjBtWmprUTgwcTQ5YTJIaVo4bHNpb3hZdjNrWEg2MTRJRk8y?=
 =?utf-8?B?RzZNWlYvR0YxRmUrT3k1VG5laEFlMFd5L3dEODFBOVBDTGV6VE5NbmZUS04z?=
 =?utf-8?B?THY1SHdNV3NoZHFma3Y2ak9BL3hta04ycTBPSzhIVFM3RzFzNExoam1XVDNr?=
 =?utf-8?B?dGl1aXdUaUxyTXhJQXVBL0gxWTIyZ1p2QVJvUkk3SHplK1A0d2hJZi8xQmkw?=
 =?utf-8?B?MGNyTU01S081UU1iSEdWR2xtUjRkNnU0YUQxZnRxT2FPc2ZWdmpPV05JSUZp?=
 =?utf-8?B?aVIzWkpadGJ6dUkyNGdiMVNsNk05MnRiWCt5TWRicUJuUWJ4ZU9id2cyMFhl?=
 =?utf-8?B?dDNzSW9SMlNKVVorU1NoLzh3NmxjKzkwNUIyOUlZZmFiMEoyT3EwNUZ0Vzk0?=
 =?utf-8?B?UWM3TjA0cFZEeVR2elYyYUliUnl2MVhHRE9jNFFQb1RHN290WTJ3enpXNEg5?=
 =?utf-8?B?d2hVUmVQUjhFQ2N0ditFNm5CYm9EN2FZZkd4dlhEY3NxamZRZDhCeXVZcXJN?=
 =?utf-8?B?Tm4xQTJ2VGExSmJOLzY0bHFoSGlLM2NobERqWnZNc0xSaHYxUHVOK2ltMXZ5?=
 =?utf-8?Q?5X+Wynzwff1Js?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBWVk4zWDB1OEk0N2NnaUVUYjhIZXVnbWpjUmtWclZ1cEt6aW5RRE5hQ2E2?=
 =?utf-8?B?Vnp0TzhIU1JPRmo0ZEpCbk5JWUZjcDBldFNObGJKK2ZKVVFuUEN5QjFZckJa?=
 =?utf-8?B?SjFtYkJUVTgybzgzNnVobVNPKzRHK3lHZWVJZVhIRkZyUkhWSkJOcG9yZWQy?=
 =?utf-8?B?bGlEUGQ2SFNPLy9WM3AvajhCaGxrWHBvbGxaMHVhYkZFa2xYQ1dLV3hpQ1Jt?=
 =?utf-8?B?Y2ZNZTFZWUt1d0Y0aWQxWi9pQzFGSmNMc1UraUV6VzZGZWVZNUpZVWRubHdO?=
 =?utf-8?B?WmZMbzJTYXovbTdWZFR5ZEY5SS9MdThOK2NyY3VXdmJZWXhjSDBWTGpzdEcr?=
 =?utf-8?B?RWZQS1N5eFJDMUY0RTBLTHJRTnk3UitXSFBvOUhVeHo4eExDMXFPQTFQUVUv?=
 =?utf-8?B?di9QeDNiVE54RVNrVFo2cVF6ZEppcTVBZHM2UEVHY2MzT1ZGemh5akQyM3pV?=
 =?utf-8?B?clAvSkZkN2pnLzRHRVlDTXF6OWIxdTNrSlFGQmdKWC9rRE5DaHRpdXJUK0ZJ?=
 =?utf-8?B?RlpXajdrVmdrUVBzd3RralZ5OUNzWEVGZ2dBSGs5Q3plYTZsSklYWHFWOWZt?=
 =?utf-8?B?c0dJcUhDYm5VU2dsWnhrZVBIZVNWUmI2ZUtiKzNseHhleCt2L0gxL1U1OSt0?=
 =?utf-8?B?U1MvemlxQ0JCZVRtU3hxaTVLbFFTZDJSbFo1Z0lBSFZCRDJTaUlxYWdDYmsw?=
 =?utf-8?B?eHVpRHF6ZVFEUmx4RWdBZUphWHM3UEpxZVg5R3NlTHhDaHhPYWYzcEtvNGR3?=
 =?utf-8?B?WmtKMWRQN3IzQkUrNlJoaWZwQXQ0Ry91c0FLNXdhTzFTaE5zUW9TM1A0bngv?=
 =?utf-8?B?NFVqUFpwTmRUaGlhQ1hZeTZYa3AwQUVna3IrM2JueFhlaGFGVmx4MThkOGZB?=
 =?utf-8?B?ZkNxYThKREpwZ0VqdkRuVUw5UWZ5V2RiYkFVOFZXOHp5ZWI0MFJTaXhRbHZH?=
 =?utf-8?B?aUc0UUlFcnBja1pWQXJUZFhPOVQyN1kxSXM5K2NRVWc1cXBsU0NhVUVSVkNZ?=
 =?utf-8?B?dXlLNXNBWnhIUkJzNmcwOFJaZXhjbDBwcEo5cUJhQ1ZyQkxMbmZFMjBLaWM2?=
 =?utf-8?B?Q0dYL0FzSVV3dG9nQnlXQk4yZDFPRVNlSGNNL0VqbzF3dy9yRjdKblNLUE9Z?=
 =?utf-8?B?S0NGZFVTV3lVaSt5TCt4bktybXl4UnlFSkRmQ0dBNGZLRmFxVDlNVGswUm5j?=
 =?utf-8?B?MURsNExYS0hKTWRNODlzVkllaDZFSGswVFlXaHhCSDgrOXc3alBWOTFPQVJR?=
 =?utf-8?B?anpqN2h3TEd2WkMwTFNpcGcrRGFROG9BWXhtL3EvZ0VPSndZN3Q3emRRODcz?=
 =?utf-8?B?S3p5c1JVWTJSYUkzMy9id3dzYUU2bkZtQ2FXaWtGSFVIZVdVS3RSSGZEMUFK?=
 =?utf-8?B?YXc0ZnFRbjZicFIraWRZa1JDRC9mdm9LRWRFMitWTmNialhNRkQ2S2FqRmk3?=
 =?utf-8?B?QTBmajZZYW9DT2V4cisvcXRUMjBRTUJmdnZQSi8yUVRNV0ZLNkIrbVVFVWc5?=
 =?utf-8?B?anFPWW1mTVN1NC84MXYxOE5CVzZWeWtDZGtTNlRDcmZZbUdWOUY0R1B3VjV2?=
 =?utf-8?B?T3VJbWgvZ04xMy92aTBTWWNuM3A5U3lBVEluMzNraGRIYkR2QUgvUDhGRmNU?=
 =?utf-8?B?ZEo0aG9iRTJmYmpsQk1ITmhMUjBma095bnYyVE1HT2NVMEl5QUc4WWVKbmR3?=
 =?utf-8?B?amkyem8ySGdVcEllNWNrOTlLRllhT3dzR3FZWmE4R2VpckpDZ0lReEJ1MTRZ?=
 =?utf-8?B?VnVvZjJOcHYxUklvOHNKeTEvRWRSdHdUYitjNjZ3dFNveVlKRmFaWExvdFIw?=
 =?utf-8?B?Vm5LWEUreVpQdzJYMFJacmVGT0thSmVVcGx3dGJkWG8vczV0QkRqdUVZb2Fy?=
 =?utf-8?B?cUVPanBRcHVjTUk0T1pCclZJWDhpaGtueGNzTUVVWkhkYi9IazZEbGNXOG5l?=
 =?utf-8?B?RDM4ZkVsejl2MnU2QW1HYXdxK0lkeWo5M2ZEYmNncEpOK0orQ2NPSFVQeTlG?=
 =?utf-8?B?a1pOUmdiRVY4bG1BQlF2MCtIek5MWG5ReCs0Q1QzNlZMMTFkKzVrbXl2UThN?=
 =?utf-8?B?d05EZ284TXdLT2d6eis1bTZoVkQxa0JqczVGMnBCL1Rpc1ViOWl5T1BIYUI2?=
 =?utf-8?B?Z1I0WCt2eGtEVmRreWdtN1dtakE3MnRrdHRxTE5DRTVtNndDdmRWdjlIaFB2?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560191b-025a-46a1-c0b1-08dd5711d0b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:33:38.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbkTH+sM38GWo4QTwWa7vjRzc5fRPwjm2GWRS4SGTjUx/fb08CktL7Npz23nkiQo3K612QtNfLGDp5gvrlKlSySz4AA8UOcqqkxG+YkwP6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5220
X-OriginatorOrg: intel.com



On 2/26/2025 6:46 PM, Antoine Tenart wrote:
> In some net-sysfs functions the ret value is initialized but never used
> as it is always overridden. Remove those.
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>   net/core/net-sysfs.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index f61c1d829811..8d9dc048a548 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -568,7 +568,7 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
>   	struct net_device *netdev = to_net_dev(dev);
>   	struct net *net = dev_net(netdev);
>   	size_t count = len;
> -	ssize_t ret = 0;
> +	ssize_t ret;
>   
>   	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>   		return -EPERM;
> @@ -597,7 +597,7 @@ static ssize_t ifalias_show(struct device *dev,
>   {
>   	const struct net_device *netdev = to_net_dev(dev);
>   	char tmp[IFALIASZ];
> -	ssize_t ret = 0;
> +	ssize_t ret;
>   
>   	ret = dev_get_alias(netdev, tmp, sizeof(tmp));
>   	if (ret > 0)
> @@ -638,7 +638,7 @@ static ssize_t phys_port_id_show(struct device *dev,
>   {
>   	struct net_device *netdev = to_net_dev(dev);
>   	struct netdev_phys_item_id ppid;
> -	ssize_t ret = -EINVAL;
> +	ssize_t ret;
>   
>   	/* The check is also done in dev_get_phys_port_id; this helps returning
>   	 * early without hitting the locking section below.
> @@ -664,8 +664,8 @@ static ssize_t phys_port_name_show(struct device *dev,
>   				   struct device_attribute *attr, char *buf)
>   {
>   	struct net_device *netdev = to_net_dev(dev);
> -	ssize_t ret = -EINVAL;
>   	char name[IFNAMSIZ];
> +	ssize_t ret;
>   
>   	/* The checks are also done in dev_get_phys_port_name; this helps
>   	 * returning early without hitting the locking section below.
> @@ -693,7 +693,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
>   {
>   	struct net_device *netdev = to_net_dev(dev);
>   	struct netdev_phys_item_id ppid = { };
> -	ssize_t ret = -EINVAL;
> +	ssize_t ret;
>   
>   	/* The checks are also done in dev_get_phys_port_name; this helps
>   	 * returning early without hitting the locking section below. This works
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

