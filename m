Return-Path: <netdev+bounces-133581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E49965BA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2187C1F230C1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535218B465;
	Wed,  9 Oct 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMj84JoB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0C189520;
	Wed,  9 Oct 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466947; cv=fail; b=CW8bYQrrB/lzjx3crdBt3hdPlBkPslqZ3uAC3t/aeuBfITB+Rs4hbxAHa8lNicoEPg2QfART/QeVLbLUwFkN7V76S6r5njQtU8pOyL7jzd1KU2DzVaWvzJ0LPYZq7tLeLYdAHYhbSQUuJ5knWRpjqrPHnehdmzuHhIJ+RszRlIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466947; c=relaxed/simple;
	bh=B2UJJWVoIivxHnlI/p98ZFkL0453BW71qVuzAGSI3n8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l1rsXlfxObwaNumh4BNSNQVvaLjscsYFNyizPoJLcwlK/jojv2erURG6J42FBcsymPRAFN32Nt2VwO4Bc2B/HC+QFrzlu2CQorFjwrP0oAvRkFeYMpP3DLa58gcb5ebiwynO0PCwGrWVziPvZ5vPg0QWacDPSE5g4Of1iAiUHHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMj84JoB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728466945; x=1760002945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B2UJJWVoIivxHnlI/p98ZFkL0453BW71qVuzAGSI3n8=;
  b=jMj84JoBo5T8ik75ijuXFFLMii2cfyCthmDpW0yJ6FjbCgjmkG1thf4a
   lwkD7/VFTKQgS9VtuPHWjGXvMqtwk4vFx8j9+50xzc0OgYPV/rcVcQttA
   VLq7yJxWWsFeDCgpZopIUfP9ZFIFn3swMe616yigD94SX2yRKMAhS+enS
   f6hjgBvNObngN7xLpq2hkM3MX7DpnSXN+MC524RVZ3Xd3n3tdgqdWTFFD
   k3UwQ4HMq5gvJA06QuwOo5dzPkJxuFPZ5kWGtVOIkWtO0WI/wXMKzkv2N
   0ovB+VCUHfo8f2TvvZWB/o/Q3BAH5iV0Mjb6DFt+DllMm9UshNqC+qYkJ
   g==;
X-CSE-ConnectionGUID: EOe5vzQRSqCtjz4MlO9Zuw==
X-CSE-MsgGUID: dJFIM2urTtSPyQ+rEXsbzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45275359"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45275359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:42:25 -0700
X-CSE-ConnectionGUID: TWJHaq/4RmykHvvQXvkM0A==
X-CSE-MsgGUID: uNmxPcr1RUW0G+TP1xEtjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="81210704"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2024 02:42:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 02:42:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 02:42:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 02:42:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 02:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unxFQ/m3o+kObojRS9jiNTMbGGkkrWCHcuxK5CDYkwkFpTXyFgIHyI39trj1di0EIbxNv5sbtCAn4pS6n77cai7idSlv9FvbXF8lckDPROYhyhjk51MmRPiTo9ozHt4ER23wbKrakhSETFuhtxjCSArcXvoHrZj5oMEBEcwB96DqkHGqexqj56/bT/UQB1NXffhNFVWcys6gUB3T6tugSIPGxNQIHj6rTbUdZvEco7I/3UxeSh+SlUWHVQP6qxyrZHrDXT5eRQEvr4BlppsBkPTrvGW2RW0/GIR94Wkr88LaZx9kFWbH0H4/E9qNu2D7/bu3Cd70Mt+ZesMO9bLdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIVEUT1nzsjAApMSRff9HRlKaWFypVuW60cJiaFdjco=;
 b=Kk+Bs7QQ8qhoeue7coUy+ZgPc6iA+uTvFnMAIpAOHI02TneQsL4ySqONUr6Dnc5JAVr1zLnVT1BJOVC2nQcyijbcW/snQvolxZfkcovwLC5qAtr8zR3mTn3bEz2Y/T8tTaWg8tjeWmw+yHap2/JZolKyfkcng5EHjuYxMUyf9/g2szJCl+/43D5hQOEdUPYIBciCvtUHKGE+xHchGubDcXIhkuVRcfMtfWdpv9e/c3jB4LDyjThLmEypna5Pzeg0MS8ddzKPT4MMzdGfqdjN4i/UEwBPH/pHvQnhow+LRcudOSXqvW7OMaj1NVTd7qb6Ddnc38L4C2UyOIS2Rgg/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 09:42:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 09:42:19 +0000
Message-ID: <01c97823-d560-4f89-b757-752e18940f31@intel.com>
Date: Wed, 9 Oct 2024 11:42:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] docs: netdev: document guidance on cleanup patches
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
CC: <netdev@vger.kernel.org>, <workflows@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a71a396-5d54-41ec-e0f2-08dce846ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09SS2xMODFsRWdqQm1hQ1BuMWFGWFRsMW9YelBubGpVeHdrY0ZiRGpFcXov?=
 =?utf-8?B?cU1RbEVZL3l6SDVONW80ejVYdStveDJYa2ttQTRXTEIxWTI3RzNhaEJnMDZw?=
 =?utf-8?B?MVhjVXFYNHdja0ZLcVZFNTB5MnhyeWVDWGV2SDUyajdaRDQ4a3FJYWNtbUZH?=
 =?utf-8?B?N0s5bzJ2Tnlqa0hYOVpNQTg4MDRDSWxwaWVoN0FNb2MzaVVyVmJFVlhacEVS?=
 =?utf-8?B?VHd5UndONlNHbVN2djRQTmNuYkpxaWNKSkxScTNiNUhkL2QxRklBZWk0cGQ1?=
 =?utf-8?B?cTd0d1NVYmNUSk0waHpidGNrTXdXaC84ZFowNVFvY05TWGF6U21LY3YzejNX?=
 =?utf-8?B?RWZoeGRjZXBUNFYrQmIyZHZUM3dmUDI0SGVZQ1J0MWM1RlpBTTVIcjJZdkNq?=
 =?utf-8?B?ZXNQZUw5WE9YeXJwZnExY2Z4cllFN1NtSXFoM0RlMUo3VE5vTHl1OSs4UVow?=
 =?utf-8?B?SHFLYmY1SVJTZEtpODh0SEhtc1l4MWt0SHJBOFpuTVZHNFBlZVhRbXZFMzFX?=
 =?utf-8?B?ZnpEVnZ6LzFiL21KdDlXcTVmSk9sTzhrWEx1Ui9acy8rMzRwM25jMS9rRGNZ?=
 =?utf-8?B?Y0pCaUtEaTBQT2FiVDJubzdFczViZDJ1RGhZRDFjQjhwUHp4Ykk5OEo5aDNi?=
 =?utf-8?B?NTFmOFZRaXh4MVd3UGJtbm9hMXNLck9namV6NVFlR0REdHZ0dHI1ZG5SVmNo?=
 =?utf-8?B?UkZxRTdLbG45YVQ0M2tJMW9JRW1qL1o3Z1BMb2d1eStUdkpKNWQxZ3M3cWNp?=
 =?utf-8?B?ZitwSjRWWWcxR0p5c3hCNEVzeDR3Z29zOXl1dFlUaFNIL3Nnakxtb1BkMHU0?=
 =?utf-8?B?NEJTQnEzNFdxUk9wM2pNeUh5Zk5HUXMvS2xsTHVESXdIeXcxd21EKzF6T0hS?=
 =?utf-8?B?NTBhU1FMdmQyWm04dUN2VjdhaEwxakVWdG9VNzVoZFU1bUNRU1dzZ0M4TEVX?=
 =?utf-8?B?ZGpvdVpYbm1aaUdlcFkwZXVwM2NuZDVlWWZHM210c1U2K2k3Sy90ZnZnWmEw?=
 =?utf-8?B?VzZwbGRmV3QyWGpNck42ajhCSTA3dEF1VlFwR3NzQittZ0FVbFlDOFdtZ3Jx?=
 =?utf-8?B?bmkwZFN0c25ubHBmUldkMDkvUTh2Wkl5ZlVPYWY5b2doZ2w0WUM3S3ZFQzIy?=
 =?utf-8?B?NkVkQ0xPdm50SE5GaGFUTUg5Z1RWdVE4NU9Qc0hWeVBCQTZzSmdaSVAzczV0?=
 =?utf-8?B?OU1BVnRBalZLNi91UmJFcUhPdFl3T0VJSlh1aENBZkVKRzU1bDBUMzE3eDV2?=
 =?utf-8?B?WnczZ01IK0JyaklRTUxjWUlIVEpQeDFheXlZK2laZFNUSVJxVGpDL3FxRFBD?=
 =?utf-8?B?ME11eERIbitiaEF6dGg4WUFTUlFyaUI1aFJicFZUNytIV2ExQ29KVGpkSENR?=
 =?utf-8?B?Z3g3OUZkdk54aXlOM0lSQ293RTNuVEZWeHd2eGV0S2gvMTY0aTZIK3FoUHh6?=
 =?utf-8?B?RzY0RlpxK2JWeWJkaisrQVZIS1BkZElyOHhZMWo5aGkzZ2lhWVNYOVRiQUFY?=
 =?utf-8?B?cnU2UEo5ZnR6d0owQ0VmbWhQUWpiajlneFhVdk43RXd3cXNTM0ZUVXNLRHpM?=
 =?utf-8?B?OEVBeVE2Sk1BUWIrUTd5YjEzMWxpdGx1OUZ1VzVOWWFnWTJvb0NlRGIzOUp5?=
 =?utf-8?B?c1J3N2k2Nm9pUTRRNFg2WExqMlFZWWVCeklQOXJ4Y01lU3N4c1BuTTdYN0VU?=
 =?utf-8?B?MGVseDkwQ3ZBYWpOY2x4L2tWdGF1UDBpcmg4cVoyOHVjM1JQR3RIUmlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTl2T2lxaUhpQmJReGFkd0JtU0EvaVlNMDRJQ3NOQW05OVh6NktPTzlyUENT?=
 =?utf-8?B?L2ZPWWx1ZjJCcVFYVkErQTBWK1h3N0Q3TkdITS9wN3RpVGxSZFlSekZyVzZT?=
 =?utf-8?B?cXFzQ0VVelJaeVVwS3JuOHQ0OG1HeC96K1o1cy9VR0psZmtIL1o1c3VQK0lV?=
 =?utf-8?B?Rm9NTURUelkwS1Rid1lmOGxNMGNKL1AzdlFNZHB3UUlLVzU3UGdBZjV3Nml0?=
 =?utf-8?B?S0FqQkZBYUxOWXZEeEdSa1hqRWVtYlpTaVJ3RG41SmRsM3NrS1l3M1laMDMw?=
 =?utf-8?B?VnRaa0cxbFVYb09mRVJjOGgrcjJmTTVXZFA4bURuM0d2UnM0UVNXSjQ0UlBa?=
 =?utf-8?B?bkk2Q2xnWjR6NzlUZEtzVzNlSHYyTFdCcG9ZTzJ2SElQVUxXODM4NU1Td2Nq?=
 =?utf-8?B?WHd3VnlvYWxkY3BKYUd4TStna2tycnFoWDI2U3k4YVZlcGNtQmpDcXV6NUhI?=
 =?utf-8?B?cnpKdG9zNi9lNGZKaXBzazkyM3Zsblh2RzltTUhxdm5vdWMwdkovOXh5ZUxM?=
 =?utf-8?B?cTBGN2lQekx4ZXBYL3hhbUo3Y3N2UnJHYzBTQWZkM0YzUTNhZEdQaXF1bU1T?=
 =?utf-8?B?TTY1YzVycDFsWUVua2laTmdYQ3lZNng3Ukk0UWw0VzBLRUlmK053OU00alpU?=
 =?utf-8?B?bDFkOGhwOGYveG40NE55NENrVjYzRGUyb3RlOTFvbVhvU1ZER0h3cjVZQnRZ?=
 =?utf-8?B?OU9DdHQ5SGhLd2hWcEhGSTZnWk5pLy9MNEVMSDN0N3V0NHNlVHpvVVhKOHVn?=
 =?utf-8?B?S0IrUUhUSy8vb1Frcm1TV3c4WTNyTmVoL0VKb2twdHRFRitNMWljVk1qWE5E?=
 =?utf-8?B?K0JWaktTQU9Vd2lTMm9TSmJnanM5SFBLTHRoUzk0MFhIUEZNa0xzOTAvcG85?=
 =?utf-8?B?ZlduU3ozYmpoZXJyTmIvNVBXQmRBTVJrMjBzanRId1JYQXRsOWtwSldicWVT?=
 =?utf-8?B?cVhYUU9jWG1iV2hxemlHMzVDSmdCZC85Vi8wclk2N3BIRUtGbDl6eDJGclVE?=
 =?utf-8?B?SlpraWszSHp1NnhyN1c0WXg1WlhrYVoybmJ3ZmN0bm9GRDJJVlFrcnlieWYr?=
 =?utf-8?B?akxRTEFKWHgwM3Rjc1FUK0NNelJObTJEcjJ0UlZ1QU5ScUdtanNaSjI4MXFW?=
 =?utf-8?B?V0xFejdPNW1LaFA1V3AvV2prdGszUitGdVUwRURiWG1qWUp0ZkgwMERxbmJu?=
 =?utf-8?B?cDViUkJ1Skh4QXZkZVVpSGxPTE1ncnlvNnBLNHlYS1JMWXhQY1dkTXdYNTdp?=
 =?utf-8?B?N0NjbFRkSnpLRlQwVWNocC8zbmRBYytaWTBtQ1RhMUYyMVdCakpQaExsRU1W?=
 =?utf-8?B?Nmp5aFF0dEYwa0xpanVna0Z4ZXNaTGlsanZiZkZneFhGWmd2T00yaWtYSlBQ?=
 =?utf-8?B?d0UzYmNNTEZOSFJuQXdTSGF6RldWZVVIdkFLcThISTk5ckxKQlZLQWZIL2NT?=
 =?utf-8?B?U2VDTU83TDd1YXlJaTl0SWdMb0tYcjE2YVlUcTB5ek80QnNGdm5STDN4MnVT?=
 =?utf-8?B?VzA2Z0FycGZWNmNZYU1WL1czYWJIM3pFUU5QUG9HbzczRjNBeVduM3pmbys5?=
 =?utf-8?B?OFVsak4zR3RwSGJWVHBLcVNpek1VblZkNkI4aElYV0Vqc1hoalNWWkZUdU9j?=
 =?utf-8?B?VnNsTlo3R1Vha1AxSnhMYmhlWExmV1FaUGhuVnc3aWdINDQyMEFYdjhDTGo4?=
 =?utf-8?B?K1lOdVlKdHU5SzZyWExaZHprQktMYm5ER1B3S1FCcllueVU2K2NlaVpYSXNY?=
 =?utf-8?B?YnJ5bnBpdWFXRmZkNitWN0EzTThyWU14aG00c1MxRmlCa3E1bFZBcUJLQkcy?=
 =?utf-8?B?Q0tYVHdtRG1SVTF5RGc5QURBWVE4OS9rbXlwN3p6WU5nTzFKMTRqQ3pBSjk0?=
 =?utf-8?B?cEtPVk80UXVJbnVGa3pMTWp4MlpkTC8yL1Z5S3FpTklvbVJNZk5LZVhBbXFi?=
 =?utf-8?B?anpybWxCRGdGZUw4SHRyVU1kYzdZeUswR3Y1OWJIcUZ4SVpsV0tnbTBpanVX?=
 =?utf-8?B?Zld2M3JpRDRyMHhTTDVVVUwvdTdFTzB5bVN1ZkJyUlRKTUJ6czIrd3NjZUl3?=
 =?utf-8?B?SlZkQTdiNmErTXpXeENLVkVSSjh1YUpLUTdiSnZvMU4wSkFUMmN0eGNWN0Zi?=
 =?utf-8?B?M1Bpb2dlTTgyZi92djVtNkZDZ2hzTVc5c0dEUlNmWk9nS3BkelJVTGNpMEdH?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a71a396-5d54-41ec-e0f2-08dce846ab08
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:42:19.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBMf7j/F5C08TVYCE56NIz9Tbs0UI6SDjTS8GU7XCeI+zDfg+vilsonzoz1DBJd0A1HitAZAY2YzlSqZEATbucZGy0WThvenqhLhHYI/j/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com

On 10/9/24 11:12, Simon Horman wrote:
> The purpose of this section is to document what is the current practice
> regarding clean-up patches which address checkpatch warnings and similar
> problems. I feel there is a value in having this documented so others
> can easily refer to it.
> 
> Clearly this topic is subjective. And to some extent the current
> practice discourages a wider range of patches than is described here.
> But I feel it is best to start somewhere, with the most well established
> part of the current practice.
> 
> --
> I did think this was already documented. And perhaps it is.
> But I was unable to find it after a quick search.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Looks like you wanted to say "please don't submit autogenerated clenups"

> ---
> Changes in v2:
> - Drop RFC designation
> - Correct capitalisation of heading
> - Add that:
>    + devm_ conversions are also discouraged, outside the context of other work

devm_ is generally discouraged in netdev, so much that I will welcome
the opposite cleanup :)

Your write-up on this is correct, no objections.

Perhaps we could say more about the status of the code that is fixed -
Maintained/Odd fixes/Orphaned - I would don't touch anything below
"Maintained" for good reason

>    + Spelling and grammar fixes are not discouraged
> - Reformat text accordingly
> - Link to v1: https://lore.kernel.org/r/20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org
> ---
>   Documentation/process/maintainer-netdev.rst | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index c9edf9e7362d..1ae71e31591c 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -355,6 +355,8 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
>   with better review coverage. Re-posting large series also increases the mailing
>   list traffic.
>   
> +.. _rcs:
> +
>   Local variable ordering ("reverse xmas tree", "RCS")
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> @@ -391,6 +393,21 @@ APIs and helpers, especially scoped iterators. However, direct use of
>   ``__free()`` within networking core and drivers is discouraged.
>   Similar guidance applies to declaring variables mid-function.
>   
> +Clean-up patches
> +~~~~~~~~~~~~~~~~
> +
> +Netdev discourages patches which perform simple clean-ups, which are not in
> +the context of other work. For example:
> +
> +* Addressing ``checkpatch.pl`` warnings
> +* Addressing :ref:`Local variable ordering<rcs>` issues
> +* Conversions to device-managed APIs (``devm_`` helpers)
> +
> +This is because it is felt that the churn that such changes produce comes
> +at a greater cost than the value of such clean-ups.
> +
> +Conversely, spelling and grammar fixes are not discouraged.
> +
>   Resending after review
>   ~~~~~~~~~~~~~~~~~~~~~~

