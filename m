Return-Path: <netdev+bounces-278057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DOmLRPY3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:48:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550B3EB7F7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BF1330241A7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C92B2D7DF1;
	Mon, 13 Apr 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKdbkizY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848827467F
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776080893; cv=fail; b=jfHX2iZowNM/xESHrow+oNy//OAVieHFbX1QwzQRBxbl6yY/APRe07d4YamXaqA21aVA5PXlgZyUKxtjQ9739LEIF0HaR8SPsCtx72laJkQ5vwB7KhLi3Btw70ypPk4s/bqQoAbzsjIuJNjr/nvGqGi7PmoF0gYjseFFKTdvB54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776080893; c=relaxed/simple;
	bh=Ri6IRf8DqRa5VF8J8ucVw/hcV1bZqmM/NMOQSIP1vWI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+eT+b22XbrStCafQ8f9BeF13foC//Kjsm/kXKYT6hBnXeBm4HjSqfvj+gjlzvmUI9c95q1fTf7qCml8Go5J7FXZTD3skLVXBhcJn8zh1+R0bLdbtkoiqj6XTunAwKgb96qyBxrxfLuzfNqrohey3BbyfdVnXeTrz7WHW8XSL9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKdbkizY; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080893; x=1807616893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ri6IRf8DqRa5VF8J8ucVw/hcV1bZqmM/NMOQSIP1vWI=;
  b=cKdbkizYUd1e3CuAEJl5evbzFXlnqyz3jMfJqXoM+ou6ii7LyqfyoKOm
   VyU1uHGCd46cevlqDSAYnnz30q0PAvkuhitj9p13tRXjNuyeBJwDTycUS
   1a2vj/pAW+RJ9OvSUpLApXkYcgCDMxsXw07NA70/eSIVDcTguslmhNybP
   cHxccUGQixxFS+9sQu/CEnazUhqe0TVvAbgyUWsaEwV+MatftlBeXPdSK
   ncCdvE9mUIw9WJg34Y95c3wQ+mQkjgSPR9SLzvnyUcYOxq2REJhAJbAOf
   azV27LlfrAr1ptM5o4o+H2YNsCZpi9kPyLRd4ykjZ/pwSS7Z759kZLFU1
   g==;
X-CSE-ConnectionGUID: HoBCuGjURRyWfqvKl6YFxA==
X-CSE-MsgGUID: TblOKlOgTrG6/tzSRSVDJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80600794"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80600794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:48:12 -0700
X-CSE-ConnectionGUID: gB9L1mGcS2qqYhQRVwAzFQ==
X-CSE-MsgGUID: uMTmL5HHTv2drPrQlPUL9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="226595631"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:48:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:48:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 04:48:11 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 04:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mE/p590Q1kxw2Tdjrh06BREWvmlyH785b7V5swo/RGpmiZUzitQ5fbmEMVMgNyEDP3xMIqB4/MGvqHf0QZx7FK+y46yI2OuRS8c3pRt3A0s/oKsVw1gKQqg2ibvNypzftbYf1vjnX7cCnuUjw+0L3DY8YHg7fVciWBxKq1r7dsCvmFQRcrKvAYBTgK5kH7OWak7TSJdBLYp0kC84xLROdxFptiqONU/QMSnA72Jq5+avFKlTHwPCTZfvNnCVGEAhxjVNzmFmO1dMmOs7dZLwnr8GAzynGn89UVGqHhAm6O6E/ID3F49P3ZVZ42pjJ08OkmLvBef031P7fT3BieAQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8El40Nqkm/TaaXwOZ4Vb4YFjDlgZV7O3wigyGq+NSy4=;
 b=Gk7ALx8+bCdT/MiPOPpARVF1XpFhyqpccfaWIL618edM7T1Pjn6jKC8nwOjnW9D8KtfvGric+26wOe20DqmeYqqglrTFAOlcWWZd3xZ9jGK0VRkGDogTE7QHZRv2ACUalFQRr/ToQ+3ilQ03aJ2glMrDiqKd06vWI/qPJl+Vi4ZQmDu5gdKiydpRUyE26+ePZUVLzhhEqqXulyrEUG7Vhnu4wytFZ5+PetV9V5ABoMKdjSRaADButILWYun62Lt6LFNiuMo5rFbnzkeOssx5QW9lZBn0LoGhckzIC09pfoghfonGYlc13oBHM9Q+eokbKkPX+8Lo6zvP+cBEMj4oSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 11:48:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 11:48:06 +0000
Message-ID: <2a90e151-2e7e-409d-9123-1e261c1a24f9@intel.com>
Date: Mon, 13 Apr 2026 13:53:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 2/5] iavf: fix error path in iavf_request_misc_irq
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<anthony.l.nguyen@intel.com>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260413073035.4082204-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0cc9ab-0495-459a-ecc3-08de995286fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FzFowUZxHcLQIYOiIwjY3hJNdl5VNSO1GfAiKSk5lbhSUmZnt1o1Ryy6lPROdUEq4wvlhuhtkwu/N8b3XMMEP028mVlWZvuiNhcPVCR3BGRoa0PlE8vJyEMTXOh43XeCSKjbpZFeFipbIzUflkzwAxE0TNEjvMpZf3qEWJ0e+lB5leld6i8NQVGRaeIv9EvObJLunB22TAr7d4BEuQj+ODj4pIrz3JHVdLXeWS8MAgp4Q3K+R+30x8ex3XDFciT0NiVgAzZcyXP/1z5yJps4wchzIWEFvDZ+AAl6MMIPzWTUZdddn2ow0Fn4FNJM8+NCVnqISG00vZ/p1Xjn8ZuyWk7cwLLPp6bFGTw9Ho0mxERQqC0wsd/wwCnB7fFtjFYJF4jj2k5611biokAgz0SaFbj9Nwygv8P2HIOCQ6T/pjz/CKwOfVwdu82H2JfwxDjyni5KgomQXaxBx9FjByNKuxJqPy3Bub8LRT6V9dBBNTqxgNEnu61dtP1/z0VY8Ns0cLTf6xU8xrgfLp2IoRp9kMiq3mgnGjVhAICKo0RB5kOUw3D1SemxRJ17N+gEIDsmalj2U/G1MxDPjjDP2Xs/KlttPlWu29b0AAJP+OACEevEw7kvbx2DvZPeeDauPfkzLABLcTDUFEwdOW48UoRVXC9vx1/bDs7W/v50jE818vhBcbUyILEJCKm0EAQWz9gwvWvkJZXBLbxXqZj+mrZICmHtPkp+gqUBqP2tmrGhfJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlxcHVyZmZJRjJ2WG13c3dOa2JPRW1RdzBzTUVIZUVZcVFyNERVYTU4NWdv?=
 =?utf-8?B?RC8zZE5qRUlUMmplT0xScm9WV2VWeVM4M0RwZUpuaHRCYis2RFBOdGpmWCtn?=
 =?utf-8?B?MENCWCtEemhvL2xHWUZoMlpoQlpMWDVoUUphNWpMcEJlemRBazZoS0RkbVhv?=
 =?utf-8?B?bElicXROK1hlYytYaUtpNUZnM1pFaUZaY1ZDd01sdjhuOUYxamVaU1BvMU5Q?=
 =?utf-8?B?R2ZJcHFvZkVhYXN4aFZsNzBWMkNuMUozdW5MWFA4ZDhZOFVudTl3eVBIbFhk?=
 =?utf-8?B?T2U4WmUvNE12YkJnWE9kcDhCVU9sb0lJS1g0TXdEUEk2MllTa3JJcE44R1pJ?=
 =?utf-8?B?MjB6enoybjFGdFBLUFV3MXgzQVA2SDBqRFRDMm52Q0VIQmkvSTFwUFJBS2t5?=
 =?utf-8?B?SVY5NW5GZEgvQmJRazZKSWgvdENaTGNYMWlQVU1nQm9qQnUvZytib1FOLzRH?=
 =?utf-8?B?QWYwUnZSN05JTVhGMlBIdGFkZlFKbFB3aXoxMnhlNDVXdWt0TjF4eFRYcXY4?=
 =?utf-8?B?ZFpZTFpuUHZUVUgrVi9qMnFaQWdxT01NRlh1MnMvSm0yZ3VOWEVrMDNWODVi?=
 =?utf-8?B?bkpNZzRxbGpUUW1pd0orWk10R2VFWll4eFlwTmhMbjVvZGhBa1VMY0ZHeW1r?=
 =?utf-8?B?RGU4R21CNnlWS0lBd0pGS3J0VUcvVWt2V3ZQODdGakZtWG5mWkdkQS9reFIr?=
 =?utf-8?B?Y0FmVXZSWFNMc2FPMFFQc0pUOVJzcm91aHUvbjFkOVJiWmZvRmZTaHlJKzJl?=
 =?utf-8?B?MGtiMXExbzFiQm5BcldIL1NJSmRoWCtxZk0zd3hoWjMrNUNMTE14MXFXcU02?=
 =?utf-8?B?R1dDVW5RbFZwSDFlOE5WTE51T3JSSVN0RC9lYU4yRmVrVVV5bW5JekNZRVlJ?=
 =?utf-8?B?RkNwYi9YdFdaY1dFYXE5RUlFTkJMUTl2TGlYOG1NL3U1UVBlY3JXMnkreSt2?=
 =?utf-8?B?ZldIOG5aRVl2V2VUYUJsa1JjOS9tUTU3Qno5Tkttc1lzeXlrcFNtSGNhR0dQ?=
 =?utf-8?B?TzFEcHNLMXo2c3UwbDB3dDBTTW5BcWdaamg1UU9mNktMYlA2bDdEc1Bnd2Jz?=
 =?utf-8?B?T1BPTVRFcWYybldKN28wd3A2RUZwV1ZTQ0VmNS9LbldLbzNDaHRUNXY4T0VJ?=
 =?utf-8?B?UDZ4ckxqMnI4cnlVQmFCSWtQOERmRDh2blpHUk9OYXFySEZJU1ZneUZEMTFv?=
 =?utf-8?B?eFB5ZWtINWVHL2RoenkwREtIM2N2Rk9XUzh2UHU1SWRIcHVJOFRkWFh4NWJ0?=
 =?utf-8?B?QWVkSUw1OWdwbElWb2hjL3c2RUhpSFY2Q1RCaXBqL21RT0I3RDdYQSt1OWhZ?=
 =?utf-8?B?Qmp0Z2lqK2tXaWNXR1gvZlk0TWFkM3B0WWZrei80U0E1WGxDWmxkSzNLQ3pq?=
 =?utf-8?B?TGcvRUNtZGpNNGVCR2RLL01OaTNqeEFqeEtkNFNWUlQ4ZkxudmVZRzk1a3lE?=
 =?utf-8?B?MDIwRzhZclA0U1lxWnNhQzFWaC96L2dadXQ1dDQ0OUtsUUtvRWJtRjZHdDZD?=
 =?utf-8?B?MFFtQTZ2bXRBM0NERWdyYnNmQ2FTR2poVjFqTm9MK1BteW9QNE9zUVBnMGhS?=
 =?utf-8?B?cDIvejlPcGZIWjJOd040OFZjeDhCdStMcEpWS3NiT1YrYjRJOTNKSzBJWE9H?=
 =?utf-8?B?SkFEK2NzeFhtR080QjBpb1Z4SUQzdDY3azhlRUlMeitFWUIzUW44OTkrOFo2?=
 =?utf-8?B?Q1AxdmN6WVdkM3E1TllJcm1YVm9iMmdkc1NVU0djU3laOG1NYi8vSWg4eHVp?=
 =?utf-8?B?aEo1enZvTUdjbWxXUzl1NkgzQ2p0YU1ScVpKejFDTm5HMXRQZ1FsT2ZiMjRQ?=
 =?utf-8?B?dHA5STBUUitRNjlSTUNTblR3eEhidytqOVBPbnFzOURobVZrbGVkY2ZvZHNI?=
 =?utf-8?B?OWszMElDb2R3Nk5pMUowY2FpQlVmd3A2cUQvd08xS1JKT25yY1dDbUpLQUdw?=
 =?utf-8?B?Y3pWK0Uya1YzbzVSZnhRVEdhMXBBTjVJcGh3SDF0SWlQbkJFOFlvMlRPTjl4?=
 =?utf-8?B?N2NSVmZjTXg1dDNtcHhOWkRWdDFqZ2c5THZueDkvbHFGWHZYNUZpd1RjV1VL?=
 =?utf-8?B?MDF0TzgrN21DMGd1dHhxUzBNempndDV6RUtMQ1dEQ0RYMG85VXFFMmJmL2Fm?=
 =?utf-8?B?MTRIZWVTcGd1MUtrSTdMRGJLR3lLb2hBSXZGODRCWUU0eitYeitsS0VpdVJR?=
 =?utf-8?B?RVEvQUVNVkhseXVFWE1Ka3BxblhiZ3JHbFRKdUtjTHU1WmVMN2pQWERDT3Ns?=
 =?utf-8?B?TzNoN1Zxbjk0bkhsSkwrUEJzdmVhaE5tVEVQZUtNMzNwc1ZBYzV1M0RXTnZO?=
 =?utf-8?B?eFovWEpwbDdXODNEYmZ0SEZlRnFSZzhGQjVvRldoc1F3TVkwUEh6ZnF0Znpj?=
 =?utf-8?Q?9pGvxkVKdxrEM1D4=3D?=
X-Exchange-RoutingPolicyChecked: vLn56yd/hZZHzaJyxZlB+KjGlfHrylNdEblICLyB+radLEqhwNC+iYTg+mbZhOXLwbeKJgEq5WDMLFGu6nVGlcjrqofHmDt7XvI1PUJiO+vA21PkHKM+QcF2NWiUkoJ/ldp/MpoTamKl3BUchZEwcD84xODq5j31VbHZyL8+xtKThdGPXh2O6be9R4C4g4ZyYgWl3aqNsCutVPwBRoQFGdsR9ueI1DB1gsqDpAXNvVRPe+F6w1iPqPEv13hy2B/a3GeQ8kaPiRQSqTjV9dKGC8mnp3bOmFCn3N5COaloOAlO2iRQddQ2tA/YN8N0H/juJJXZp2Ogt6R4f3FparZDBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0cc9ab-0495-459a-ecc3-08de995286fc
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 11:48:06.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsDSmP38azPKukS4vdi8QQh4wyHXUeYZqRVcHELoN7PPMnTqxNYSC0h0CVfWmqTk2IMrV/fqWZHt76jDA9fivoSqa1RXteRzICv/Yq7AhC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278057-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3550B3EB7F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 09:30, Aleksandr Loktionov wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> When request_irq() fails the interrupt vector was not registered for
> the driver. Calling free_irq() on a vector that was never successfully
> requested triggers a kernel warning. Drop the erroneous free_irq()
> call from the error path.
> 
> Fixes: 5eae00c57f5e ("i40evf: main driver core")
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001a..ab5f5adc 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -587,7 +587,6 @@ static int iavf_request_misc_irq(struct iavf_adapter *adapter)
>   		dev_err(&adapter->pdev->dev,
>   			"request_irq for %s failed: %d\n",
>   			adapter->misc_vector_name, err);
> -		free_irq(adapter->msix_entries[0].vector, netdev);
>   	}
>   	return err;
>   }

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

next time please CC netdev on IWL submissions

