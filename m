Return-Path: <netdev+bounces-285534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKAGAy0R/WnjXAAAu9opvQ
	(envelope-from <netdev+bounces-285534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E084EFC8A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E501930578FD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D831C39C645;
	Thu,  7 May 2026 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmHuJXgU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B739A7F9
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192576; cv=fail; b=N8q5AYx0P2GBA68calR4bIQo+MY+NACR6XjsU3lKyS7DtjlmVwgcZp5mOHd3P2AeCK82oNVtCKZRQLzv8otC9v8Qs6jerZAtIpGuRnEhPZZ/0RvlpA2yGIGzat0WE1quuORpJKFzyTJ/KgHF8HiTdDHagzBkVw9kYQPy5KQQNPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192576; c=relaxed/simple;
	bh=NUkDhMnpz0yeMayS9o9VgLS8RMdBgyOH3kE1qfZIKao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wguh+dW/ZCsqvDYXmv1B6hTzvYMGPSEHC+9R30z4HVR6J5PJnRFoCLq7mqWOuVJlspb770Ywjdb90glxgAwdXsuYc7fouMwQMoFKkeV4cSIZZkIpQsRbaK9HB183CyYsMSbm0rvPOY1Div7HsvaIH5WPsUq5bMzEDfX6097HhgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmHuJXgU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778192575; x=1809728575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NUkDhMnpz0yeMayS9o9VgLS8RMdBgyOH3kE1qfZIKao=;
  b=hmHuJXgU4AYLbtenUkXIMVWQAwiGrZNT1hFluofU6udof5OJpltuxn/F
   A31DpkOqEkggH4CB4QdDkNojYEz0aEfhaDsvExhA3EmPxoIAHHSLH8Hq1
   440whRBh2Zse5M0OdfSfRXGivxNgb67PzxB55wYY/JdYK36EVbcmBhhQE
   hBn6rV9R32Sh/a5WF2B1wRD+XJ6+uzAzFDNK0JOc/ZLndHqFQPjc21830
   zQvhQT6gpZfA2GJUbj3rzKqK0PXyklzl5Js7PfdhC1kBGN6Yw/I8YH4vY
   twjMxDbAF/kLJ7lVTzucxGc2uUG4FwSYi7y2pqymEt9UZzBOmnM/8ty+j
   g==;
X-CSE-ConnectionGUID: IE3CUQ5xT3ignffu6cWfig==
X-CSE-MsgGUID: hpGDDUw3S2+1SCuEt8U0yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78303981"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="78303981"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 15:22:54 -0700
X-CSE-ConnectionGUID: EjyP8OeETSect2hra8FKNg==
X-CSE-MsgGUID: PstMqqCvQLOsnmWwS5U1pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="230201645"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 15:22:54 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 15:22:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 15:22:53 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.20)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 15:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9sLtQ5PwxptNsjDVEK1MyUmEZ8+Od9h1dhPj0R57cIh3/rnoZbFhCci8/uuLmhXfVdV+/Em/Nw+bL+vfN27qumXdm4XOfi5GzXm8QantsAwO9gfI0fdrRr/RNrI7w0j+RnwTg2LxLYQ6RdZu6AD+7SgzHIM3F3N14TF6rDL+s+BCxuppj7bbZ9EpVwEYQYEJnXLA8fGbhSNKWUfsJ+nq+Azc3iiaTaN8Hk0W7uokpR4i/35cFZ2maUbfDHy1YbtWuyO1gchtl8YesUgfHrw1M4BR+uvLiAG2vlxgut7//qN6hOiTQPmvO3J4i2OTZ1pzCPg7A7O69AYzoX8ixM1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIzRDwERSGXSKycv3kHodSEnzVMgh0GptuwvoYO8hz4=;
 b=DJnqMjWoQlF1e0TrJMZjc/n6jqlTQQn8BQCEHVkhWwNwKCrUsXB0RbEsLymVyj36qRV946CxGNfU749Y9Vm9Ys9qFTi6w/nInxRO0eU13hRx2jRsG6j7hTyzlZw8X7DAJZ1C8m7g/VV5PB+xSlldZ+iy0MQiCBjCbsyMW16BkpZimMiGI7XMoZJ3AP4FuJSd7rNOgmbQOI4C2kD+suril9rqkqsrQv9SGlosGTiTrrHoDQl6LEDGdA7Y7ZfnxutWRbf4ukhUyvgFh/pUsKMpllwg3b8b9hh9dhcSzQG0EvzG2doA/tyUiWpKCgth2Erg16P8k3eR4yHDGK3EmlDFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 22:22:48 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 22:22:40 +0000
Message-ID: <eeecf203-1356-40e8-963d-9498e9413da8@intel.com>
Date: Thu, 7 May 2026 15:22:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 00/10] Add ACL support
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <sandeep.penigalapati@intel.com>,
	<ananth.s@intel.com>, <alexander.duyck@gmail.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: d8012a1a-9392-4cf7-6fda-08deac87268c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jboGCzrHwt9E9acjYPImGcq18+E90fqF7J/18iFYqtd8YJoyzRdPjxg3eKlZim5YwcICE/dD5xWxBlvS6xEC6RZ7S+szx0pWG7D6JggSfo7RjgGHrZ/9lV95IkOXakzXNmGSf6rtTFBd06yWara5prAvGtoO+Po+8YdkEpNXnFpiK+SwSDdDFtrRshhZ3wCL5HU2IanyWNzolmBJGKExgVkZEHBGXqU3MvvsTb25CXbPaqCP1tCaGx1/pdD9MLQnWhwv3UVgrPD35wWYJGKR6Nx97GzMdUdzYR7sMahEgJaF3lCKoKstFV2LdZnYVSNz2wLmeNO6zeBmad7+crNFFIxKtICKzRymcUVxgBQmcBSSlVPOmAqSNCHg6x1FcmhO4ztfVnmVByqSwGDXCIYjYYm/+dOs8BcsXi4/IpTf1ESWBFd1h6ANwD26qWbSmaHOJClcaKLdo0Ed1xr5s1wew+Yx+LxEkZMkK1Y21qLISRYusmWZcWcMj8PniY4TOBMzhtXRMrRNbXdBFW0QQmOaTZpMBAl99rF9DY7w3HsWDSVKnPRnsm4DPqhYVfSfpYY6CU1t5ycS4po276uP6NJ0Vb2hCTuRUFh4b4lMW3PG3z5DJWKtaki+9vxfOSkePIkGOQfuOd/xHLPVc5PqX8YXrv/vcG+04oSTj8diCTsDOD91y3N1RK5xtfoxwIOwp8AWDSzO0CU2wDW8MDMGzG5XYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dWaWdheU5OdENqY3l1TXlrcUNLOUFTank3UlI5eFQ5Smo0N0E0NzhqYVBh?=
 =?utf-8?B?eTBXWFlPdDFjR2tiR0pvajM3bGJUMDZxcmVEQU9kUEZYbDFiMHAwUXBZWThz?=
 =?utf-8?B?aDFORGRhaFYwMCtBREdrQmpOZVcwRmFMaTd2ckFvSFpicWlKTWVhcGVjQm1D?=
 =?utf-8?B?ak5CdWlLdjJ3NWh1VWdIRjR3MWhoMnJPcnpkSDRtcmx6dUp4K2tuRnI1MUQy?=
 =?utf-8?B?ZDVpVnR6M000cmp6MFFsK2lMZGhqVEtDTFFxU1FVSklCWHhRSWYxZzdndm5r?=
 =?utf-8?B?amZ1dmdQbHdJQjRTZmsvamFPMFlCOS9KS3ZiSXJaTkRiRm9PLzJUbXg2MGln?=
 =?utf-8?B?TkxLQmhuMEsyNGppRDl3eDRiSjEzU1NMY0g5VDRWeG81dG5sS1RsUGxYRzZa?=
 =?utf-8?B?eVp2dGJ3L3lRL0JxQTFMS1pVcFFHcTU5bE9WSkJ3d2R6YllCeVN4K1gzRzNh?=
 =?utf-8?B?NlR0UGtnamtSczlzb0Q1UDk1WktEV3pzWVBmODFqOUkvV0l1NE4vc3VqOVNk?=
 =?utf-8?B?a1ovTkhMdk1HbVZLNVV0NGQ2Ni83R2hvV0RZRmFKZXVJSHNDenhNRTZvVlAy?=
 =?utf-8?B?cFpFekZEUWxhQkYrMm91VTB2ZDlxOEIwa3ZBNit0SnZiUGlSQSs5SzJWUnlv?=
 =?utf-8?B?YmVIci9nelFxWHh0YVlJT0E2WGdhZ2xpM05IN2x2YktoTzZ6LzVNbTVXbDRs?=
 =?utf-8?B?MTRyM2FyeldOUjN4UStDbkRJcXdPc3Z0cGZyVE8zZ2IzK0pjd2dObEZ0QXkv?=
 =?utf-8?B?UmoxekVsT0o3ODlWTlFTb3BPWjkvTDlRVE9uenlxUk5WTnRYZC85Z2l4WGpv?=
 =?utf-8?B?SDZWbkpzdkJ2QmoxbjE5M1k1KzNIT1BSK3cyaXdIMlJmM0g1d0lYckQ3b1RT?=
 =?utf-8?B?Z3o5aW9JR3N3UnNqbE8yYlFPZVBkd2RJL29KSzNDaFoxQklTOEI0LzhQZWhI?=
 =?utf-8?B?ZVVRaWVhU2NpOVdFZnYxKzk3MENtOURBSWNpemI2N3Z5YTkxN3pYeitjRjhX?=
 =?utf-8?B?NThsNVdmQnplS0xBNlQ0TWV4MjlXTmd3OG1uS2RFdWxTbUdyOHlpb0crK0dP?=
 =?utf-8?B?NVNlNzR4UzdHaEtMMjNuK2FQSlZJTElSOHNBcUFOU2RmOWwzMytrM01ZNXVy?=
 =?utf-8?B?aUpnek9qTmhmS0tLWHJSdTBUQ2dvOWhFQmZ2SmRaOWViTmozZUZTdUdKSUZq?=
 =?utf-8?B?Mkk4b3k5S2hDWDRGTTBWNzBBbGhGZFRTTFpPVStRL0JxR3c2T0lsNjJBNnJh?=
 =?utf-8?B?RlowQmhmbVlPaitmalRFMC9GNHMyK3Z0Y1hHQVdlelN0cXJIcytXQ2ZVc1J2?=
 =?utf-8?B?RDZTZlFZUWZhTExlZUJNdzdPZkJGeHpIbUx3d0ZRWm5qSEZCL21uZHNMSlpM?=
 =?utf-8?B?ZDFmSmptQ3BKcnV3aTVWWmxlT2RNTGtpdDl5alBveVhNZENvcmhTYXZTTGtW?=
 =?utf-8?B?TGt3TkpsOGVaV3pUeVNscFBSVzFpWWNrRzlGRHlmZUlDNlhEZzJIV1laRnhk?=
 =?utf-8?B?cmRaYlg2b1ZTRk9UbTB6SDh5UGs1TnVUaHoydllHcTRPNTc2amNLUGFla2h1?=
 =?utf-8?B?YjRQQldOcEdEOGRadmZRdlhialJjcmhWU2FmS3BGYXJyNCsxOWRkWXNsRjZH?=
 =?utf-8?B?dERBUUI0OTBaM29CaUtzclA1eGw5dnBNcWtiVTREWk1HMDdRQ0gvcnJVOTd5?=
 =?utf-8?B?TzZhMjhqekZWYkhOdlFmZERzWE5oY3VPeVJIUENqMnJ6dlRuSlNwaGVBMlBI?=
 =?utf-8?B?ZzhoUko3UWJIeEdJQ1BOOFQ0R2JoWld2VW9WSk42Tk1MK2Q0V3Z3bTZSb1g0?=
 =?utf-8?B?T0NXTHBJZ1A2SHN3ZWk0M0IxMWZGUXV3R3J5ZFY0dFljNjJtU3ZqZ3lVeUxn?=
 =?utf-8?B?c1dpTGtzZnlRZ3cxQ1dOQi80ZkZIblhmMXRZZE1qNUtrWllBUDVDR0V0NXlu?=
 =?utf-8?B?NzI4ci9kLzJ4WFY1WTlxNklFYnp3dUZ3M0NQRDBBZmRHdURVd0xScnJ6VWtD?=
 =?utf-8?B?UWdnOG01UDdmVTRXRFNCdGZpTXNqU1EvakVJMmErb21YK3RpRjllUFhSZy9x?=
 =?utf-8?B?QTdFc3hBbXp0TkdOZlpkY2JCVUtleHpyb0kreU5Damg5VUxLM1RLenRhZTZY?=
 =?utf-8?B?a3Y4NkM5VkxXVWhVN2JmSUpZa1NZTEV0aVoyQUhMUGhPYy9EZzVTcHlzSTZu?=
 =?utf-8?B?VEtBM3hJYmdLNXlNZGVscjNKQm1FQWFjMVBPOUdaZy8zQjQxWFpXWDcyK0FC?=
 =?utf-8?B?YkpZc2dyK205RFNyNi9Jd3JWemRkM3dGR3BVbStyb3Zid1doZGV5RVdmTnN6?=
 =?utf-8?B?eHhpNS91U3hRdEMrcGNnL21NQWtBMHVkQnMxRGI3SHFYT200UTJrOXFMS3dQ?=
 =?utf-8?Q?4yYIpSc5M1JcZA10=3D?=
X-Exchange-RoutingPolicyChecked: Fuv+3UFvPdWdVGH86J2ISHtnFrqyPj01BxTVEODvsrfXeCKFjLZ5VZusIALrXkX7K8kD15BsRx/gp3EzpgSHtkvAQLfG9J+8aFwJ9mbadom1KTK7srLQj4F909FuDEqRYZNPgp+ARVfXfSChnpFtQLyFRB4Up9P0wo7SOfzlg+pjntpnPGQ67sIl1CzCD1Oxxkxl1BhcUcK7MNxQ5LNwb3r6TV+zt6WZ5SaQTd3suLgClxXpWl+JNNjlPuqIcmrqldY1nImiF9uAzgZC38KzWaBm5Yhkx6oq+gttcmKArAPXClGYJKqa82EotpwnxRynVVUrg2hv0OA/F2jX5UVzCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8012a1a-9392-4cf7-6fda-08deac87268c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 22:22:40.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CudqX31zRuHX92DirPXQyBcMafmG9fRCrd3M9V6/gbL6cKoeilhp5I1QpmMmWoCCEGlA10fNKhXIxpWUbiVT+urSKj/Ldcp7ztK80/cTOOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 76E084EFC8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285534-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 4/9/2026 4:59 AM, Marcin Szycik wrote:
> E8xx hardware provides a Ternary Classifier block for implementing
> functions such as ACL (Access Control List). In this series it's simply
> referred to as "ACL".
> 
> Implement ACL filtering. This expands support of network flow classification
> rules for the ethtool ntuple command. ACL filtering allows for an ip or port
> field's optional mask to be specified.
> 
> Example filters:
>   ethtool -N eth0 flow-type tcp4 dst-port 8880 m 0x00ff action 10
>   ethtool -N eth0 flow-type tcp4 src-ip 192.168.0.55 m 0.0.0.255 action -1
> 
> This is a resurrection of an old series from 2020 [1] with several
> improvements, but the fundamental logic unchanged. v1 was almost pulled
> in, but ultimately it was decided to drop it [2] because of unresolved
> issues. One issue was too many defensive NULL checks. Second issue is
> about inconsistency when using multiple input sets. Both are addressed
> in this patchset.
> 
> More about the second issue:
> 
> From [3]:
>> I would argue that you need to have some sort of logic that basically
>> checks to see if you are going to hit the input set issue and falls
>> back and applies the ACL rules. Otherwise you are significantly
>> hampering the usefulness of this filter type. It doesn't make sense
>> that dropping a field will cause a rule to fail to be added, but
>> masking a single bit in some field will make it valid. It would make
>> it a nightmare to use from the user point of view as the rules come
>> across as arbitrary.
> 
> Flow Director (FD) has a hardware limitation where all filters for the same
> packet type must use identical input sets. Previously, attempting to add the
> second filter would fail.
> 
> Patch 10 adds automatic fallback to ACL block when FD cannot accommodate a
> filter due to input set conflicts, which resolves this inconsistency.
> 
> v2:
> * Rebase. Notable conflicts were the removal of ice_status and the addition of
>   libie (which affected AdminQ communication)
> * Reduce the number of defensive NULL checks
> * Use = {} instead of memset for definitions
> * Use kzalloc_obj() instead of plain kzalloc()
> * Move from devm_ to plain allocation for objects that don't require it
> * Move iterator declaration to loop start
> * Move some defines out of structs
> * Fix kdoc (except untouched ice_ethtool_fdir.c functions)
> * Adjust style (err for return variable, spacing, rewrite some comments,
> * commit messages)
> * Remove overly verbose comments
> * Add patches 5, 6, 9 and 10
> * More changes listed in patches (if applicable)
> 
> [1] https://lore.kernel.org/intel-wired-lan/20200914153720.48498-1-anthony.l.nguyen@intel.com
> [2] https://lore.kernel.org/netdev/7192efe4d27c93148b3205e65f37203c89170316.camel@intel.com/#t
> [3] https://lore.kernel.org/netdev/CAKgT0Ucxd5-gvEwWAdbL04ER2o++RX_oekUV3E0rYquEgFKj1w@mail.gmail.com
> 

Marcin wrote to me and mentioned he had a v3 planned. I'm going to drop
this series from the queue in awaiting v3, despite the testing pass that
recently completed. It was apparently already known that a v3 was
eminent but I lost track of that detail when applying the series.

Thanks,
Jake

