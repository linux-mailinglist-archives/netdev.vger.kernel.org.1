Return-Path: <netdev+bounces-114065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC81940D9A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47ED1C245CE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A1195F0D;
	Tue, 30 Jul 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrgIGN0L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09409195997;
	Tue, 30 Jul 2024 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331729; cv=fail; b=HjYZdvWPLcbbGjUDEO05BAw3ILKzBDX3D0ScJKFFTK3Q1hiOO++Q0VlDECbVJBQYCws1QiEA890Ie7U69JXxW56f4UzCPgBdmgeR9LnsOeizpaRKzliuzAoiTrCuhCGb3cKvbffPY0trNctnflicCERjn/kT5AfEiA33uv854S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331729; c=relaxed/simple;
	bh=dzrjbZ0G46sPV7Io4/UaOGZpRueCgc5jJwljO/Fw/Zo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YJ1Uj2z5yB2B5hia7P2UhTMo3r/79MtZdpie+LqKmXmyLjEDqoOPlDoP9c00QrH0KSG21hk8VbmvAABQXFm+6kBsuxfUQq3FNBviujGy6vlUkpPmA/z9e5Lbe8LDJHkjA1Iuncjk89bvbAK8qTsBwT0i1u5K9dwdeNtN07l0R5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrgIGN0L; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331728; x=1753867728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dzrjbZ0G46sPV7Io4/UaOGZpRueCgc5jJwljO/Fw/Zo=;
  b=JrgIGN0LmI0LWfdx+7qvKjlTioq4+TK9fpWRLFWkEeOiTd2d9Y7yKakz
   epk1GAUttMOU7dpq1b6/OyOO+Z6pRpSXk8HHhv4o3DZ1t3ipisH4WbC+s
   db2yg742oGj+tIY8gMV4W1EZ0J/dym10kKES72ohc+LJMWQ8ZB/syjmHb
   3dwZ9P3ouF4AEjTYVzaNSUU0BBFFlo8tidAM2J2wGO9WMFstyAWdoUezi
   xccElDDeXUifU7boVoFzQiFTQaiWA81qnrOwY+Wv26FURE5c1QZExH6Vx
   Rf0tZC99B1umOzdSbajYeTX3A1Pw9FVfoBacWhn9J8d/9WcVflXpOPauY
   Q==;
X-CSE-ConnectionGUID: QjHs1YTSSqWN11/DwAxXtg==
X-CSE-MsgGUID: TE9duwZQSXerzKVgix73ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24000025"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24000025"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:28:47 -0700
X-CSE-ConnectionGUID: Tk2fp56vQ8CsItEZGlI/8A==
X-CSE-MsgGUID: FHdCZ+5KTi60oY1JzMvKhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="85228027"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:28:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:28:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:28:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekPqDaPE+flhE5AzjU/sp975fYAidmP8PU4Snlq1awhE+JrVYYLtZxTmzSIZgOk9/tUWkg4z7wXMX+eJ/7AIqOpmlbySLAc1K32g9vL/J4U9Vs1plZNtlrd1YH2YEGZpcvhSX96qizUixDRzzktWzUKCbGg47r5jfEA/jpB+hM7wXlzSShXqKvdnY7pmyPpwNQICT6zPuUC2SWqwWAfDh6Mxexu7Qlb4fNC6uOb0IDAm5BD/Ay6FwsqA9elyRZdGNUsQ41wtJQyB7Vefxquc/085Dyhop/akJwQVU/MLv7Df16mYmgY+e3GbMT3UlZPxR1xl+gHvlnWl2Vt4/ftpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QoBvI0n5AwtDiv1H1ML6HLrAoAZgFNrQBII5WqIv84=;
 b=cPmxwjBBogepFJ36RNmCP3qDUbAAKRseiNfqI7aUKUhMwTqQSjekUeh+Rdxmpz45NeTEh/ih/JGS0WD+4UHHmxbY1UIvqPKS8jqZaNHBhlP8wcPJrJNaanvZ2yicVz1qYIm/Ia16jVzAs+yroGMvzQM/yJj4LrN5devjvhTyRsDA6sCMgW4DEbKju/scdazOGrBdhbrZgsozpm5Fg8QPaDCY9S7pTKs4RJOqmtgqmU0S8r5ZRChFYTx1QlZ27fz3haEFsHpX/vkuVDftvzVrQEVTOO0J82UpTgnXwHX5VfI/HRiiEpDlEJAYFlJdGhWRS1EFRdrgPTueRlBqIfIb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB6870.namprd11.prod.outlook.com (2603:10b6:806:2b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 30 Jul
 2024 09:28:39 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:28:39 +0000
Message-ID: <46b36141-aae0-468f-be27-cc64b00050d0@intel.com>
Date: Tue, 30 Jul 2024 11:28:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3] net: phy: phy_device: fix PHY WOL enabled, PM
 failed to suspend
To: Youwan Wang <youwan@nfschina.com>, <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<hkallweit1@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Russell King
	<rmk+kernel@armlinux.org.uk>
References: <20240730081516.698738-1-youwan@nfschina.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730081516.698738-1-youwan@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::6) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5ec195-bc5c-4782-6c04-08dcb079feca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUJUSTB6QzBpa3MvODk2Mk5jR1lLcEI3Q0NmcGY4cDYyNnBSaW9mbkdMSHN5?=
 =?utf-8?B?SDFVY2pZSEtnM1g0VXgxdHpWTEt0RitmbzJPL0svV2hHeE1NVXF1YVB1azUr?=
 =?utf-8?B?dlBYUXFNRCtFMVFtcnF2ZnE5a004VWZKWCtRbzBySmlzZURVVG4ya0dyM0lr?=
 =?utf-8?B?UXdkTk9teFU5QXNNVEFJWjBFMzlTSHl1QUo1YXRjTlV1aGxLc2V1YUR2YTV2?=
 =?utf-8?B?R2V3TGNJWHY5cHQyMVQwZWM4WnZQTG1MZW1GcU5aRHlsdlNRMVEzWXVqUDVI?=
 =?utf-8?B?b29OSHplZlVMbDFSdWZRek9ybHhDQUNnZHN5N2trSmRmRnNyVXMvNG5Ub2g0?=
 =?utf-8?B?SnFvOWFDWHo5NHpjUXZTWmsxMFNyZWl5WHNEN1AyVzRSS21tSXJCMlNZRDZt?=
 =?utf-8?B?Z2FaU0pmSFRoSW8yU2ZiSWwydXdFUXJpMUs5TEVCMExUZUwrV0ZVT0pGSCs4?=
 =?utf-8?B?dVRabytJVE9vNFhSaWl1Yi9peTZWM3llL3diZnc3Y0owUXpZZy96NWVCUCtT?=
 =?utf-8?B?VnYzQnBKaU5CVnB4L1ZEbW9UK24yaS80MjB4bWRQQ3lQSWZibktTbnRGRDFs?=
 =?utf-8?B?MVpEaGMrbk41NElUTHY4N3lqQnpYdFhoRzEwMGxkWis0WmJJU0FINGpNOTFx?=
 =?utf-8?B?VGMxWkV1QjZrRFJZbEFuWXZybUNHdzc4dVJYZENpemprMC9ONnR0c1pPbmhp?=
 =?utf-8?B?MUhjVHZucEdNRVdTM2Z1Q3JybU1QVTYrcXFVWlNvTGRxeWpqVSs4ckI1dm4v?=
 =?utf-8?B?YzYrbk1jcmNabVlkeDd3SHdPZDg1SVd6MmQ1YWVab1NaQlZ0NnR0RlR6Vjk2?=
 =?utf-8?B?bCtVUnZwa1hHTTl5THNMTHRIeHNYWTRsQmd6VHpITENaaWJGZlRyVVFGaGox?=
 =?utf-8?B?a1NtamNUdmtxc3I2MUpkaXBZSHVzUmtHZC85MHhrQ2dkVklCNVpwWTg3UXdT?=
 =?utf-8?B?WVBtUmNudmgzZy9vM1UweDlVL1FuTTlwOExyQkE1THNscTJZdFdiZ0U1bTM0?=
 =?utf-8?B?RGEyL0E3VzRtd0tiS29iYWF6TGJUbzJGZ3ByRzhVak5ZaVZJTmNWSVk2RkZz?=
 =?utf-8?B?d3hBN2N2a25ES2hQOWU4SkZ5T3NWbEJrZk9FTVNpQlNrSTBrSEhJUHBmelpt?=
 =?utf-8?B?QjlBK2pydUxFaTNETElkdTM5YzRZNDlERXFWRDV5bXh6dG83b09NelVzdWZ5?=
 =?utf-8?B?SXd1a3lxUnJUaUgrenYvT25NK1V5V1RvdnRSVFVxTlFFekJXclJQUzViMlc5?=
 =?utf-8?B?eVhhVGZmY2Roa2xLUnRUS1pQZjE1R1c3cHFnUHdxMitzQXE0OHpSMGtTZ25k?=
 =?utf-8?B?WUZhaUxheFpIYndRMjNxUWZkcjhKODVjdlYxVExQd1ZEQUhCR0xIbTdSdWxT?=
 =?utf-8?B?NXFrZXZlMnFVci95czJ0U29FdGdGcFpwNUEwdXAxQzFTUnUxOEFWcE9FUUFY?=
 =?utf-8?B?dXhpQUQxL1V2aWttSmZ4Uk52c3JYazJSN09NUVVKb2pzVTZEcmFtbjU4T012?=
 =?utf-8?B?T242anFQWjVOY3MyWTBRbnVCUGh3L3YrMkhVMm9hSWQySWphbHZsZ2hsYWI2?=
 =?utf-8?B?TUltZThzTGNmc1NoNUlhTWJDUythZmpFUzVUdWgvcnp4S2xFRlBhSGNiNEo4?=
 =?utf-8?B?bzNUbHZCVWZVcDdCd0hTanRzYjViVGE5WDYrQzRFcWhiemF4NnFSU3NDMS9E?=
 =?utf-8?B?M0FqV05obXZtODFkZ21mOXR4ZHM4aVh2MEJYQ3JLWDZlTGNWcFBXS25xQktm?=
 =?utf-8?B?TGRWelJqNXdyYjZrdWpMelpzYVlYSHM3V1d6RU92UlNJOU1VYy9CbWh3eDF1?=
 =?utf-8?B?YTV1NnBPa3loZzBBNDhndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZBRnZOd3dEVkYreUhZcHNBckJZb3I1ZGIzS2FENGxpWXFTZ3NsaHdYRzAx?=
 =?utf-8?B?OTAvTDVoTm5abDlmMVljOGdnbSt0d0lYbWpwdVhEVG5sQkczUUhtODVyZCtz?=
 =?utf-8?B?ZmdKNXJHaWRMVVRVeUhLNE8wc0V1TTVLUElIMGU0S3lCN3RVa0xrbXh0bkFB?=
 =?utf-8?B?TXhXc3Ruajljak0vTUIxQklHeU9rWXhLSFFua3JJZk5RckxJdGhFQkNQRmRp?=
 =?utf-8?B?N2p3Rmc0ZGZBVEoyTWFhUkU2YWZiU2ZXMXo2aFg5dExlVW15c0llS1lReXZq?=
 =?utf-8?B?eEJZSlNjWHZENnhvMkd1V01zMTU0aDdNSlRqMU1ZODVwM0cyRWFGWXdzRVRv?=
 =?utf-8?B?Q2hXTWNGVVdITWgzdnFjVG5pdlp4VTJlRUU2NGpCM21FRmEvQ3dFMGN6dFY2?=
 =?utf-8?B?NmpEeW04TS80VHRCVnVSODZCMFY1aFNDQnV5QmV4WGttaFJ5WWZBMjJzRktP?=
 =?utf-8?B?Z1hHd0lPaS84U1U0WmpQM3Q3aHNNR1FEUUNNS3hOM3pzRUREcUtIU2VBZzNK?=
 =?utf-8?B?MlBzbzlNYVV0SSsxNXNpNXh3R3d1YzFZMC9Tc0NobGxVWWIzWHF2TjBnRTFy?=
 =?utf-8?B?bFBoRXNlQ1ZkQ1dWaFh5Z2hyd2R4aXluM1V1QVZMWEovakhlNFFhODF3WTVX?=
 =?utf-8?B?UTAzZDQrVTFxbVMrUHVPTWZONkZsSHdFT1grWWtscHhMOUdicVFGTU80OTNC?=
 =?utf-8?B?ZjlYMlVJSExEM2YyaTNLa3RIbG9USUFCejFRSVNnMGU0OGY3TTQ3cTQwa3Ro?=
 =?utf-8?B?Y3N3K2gwNjl2RUU5bExwUjZSbzV5eDZVZEtYc0hScW0xVFRCZUY4QTJsTDRZ?=
 =?utf-8?B?UHZ3djNhYjlqbXhML1haUURLVWpGWVpzUnhsajRVd0tjQ1BXd3kzLzVCWjFj?=
 =?utf-8?B?c1lOQkZQN2wvM0Z0R3hiUHR4MlplN3RXR2tMcVNHOVpwQ2FueG5sNGlieHl4?=
 =?utf-8?B?ZjBDWjhVZjQ2MU9QcnhwM20vTGtuUmJqa1dtMkZlTFFuamc4djBHMEg2K1pN?=
 =?utf-8?B?MWdlajdGYWhUMDRaQkw1bUcxV1NDK1RJWU1BbTNQM1pTL2Iwdm8wbzlOd2t3?=
 =?utf-8?B?NmpPREM4OG0ybnVoTDVGZXB4ak40NUdhbGJWWW0ydWRPWFRaSTRmeEZ4cCto?=
 =?utf-8?B?VTBpc283ODdrSXF0bGEweUIyRWZhZUJDYkVvQjdPVGMvaEk0M3grRUI1RnVY?=
 =?utf-8?B?NWNVbHFPZEJuRGVrS2hVV3F0cDJHTGE1ajUvM0ExSUdoODJiaFpUYng1d1NF?=
 =?utf-8?B?TFF1NkFRaTBiRHliM1NXQ3ZDRlRFQjhHZU8ycklFOFFwTm9ZUTBreXAwVGM3?=
 =?utf-8?B?bmZuTjFjdTJWMXM5K1pnNUJ3M2tOUEd4cHZCbytaSnpVVGFXOHV2TnVLbnRX?=
 =?utf-8?B?NXlHUC9id1pmaVYxbXZRMVl0MEtTb253UktTK1luSEx2MFBVcGNNNlBzWlZo?=
 =?utf-8?B?a1l5ekRlZUVPVGFod05KSGdWNUdhajhPa3BkQ3hxS0FDR0dwRWx3blZZVWNP?=
 =?utf-8?B?djZVa2hrSVYwMmYvZHZlYi9oM0tia3dFR2svRjROclBIYTB0QUR4azY5UUlB?=
 =?utf-8?B?RjhpZStyd1BQQnFsSjJDdEVqM3V0bjk3bFJsam5lck5FSklseDRUdUJWK0R3?=
 =?utf-8?B?VlFwOENGeXE3VGRlYitwUGpIN0NNN0RWRUdwanJUdFNXTTdJbWZaV1h1b3F1?=
 =?utf-8?B?ZHR5OE5XSnRqVkFIR0Znc2cyZEZLd1ArcHBKRGJWcWQxeDNuekJ4RjdnZjlY?=
 =?utf-8?B?RjM2WjUyODdFZ1g2RDF3VUpGcVczekZ2azlzVmd4enAzUmpqNHlSVHlFek1n?=
 =?utf-8?B?U1dEZktpZ1R1UDJoUk1FTnZIN1Jvb3lVMVBna3VRaXRZbExCYlhxdHRYaEwv?=
 =?utf-8?B?ckkrbEZmWjNsTjVjRUkxZjFVdEhjaVdoTEs4ZjJ3SkF2aE1ObDlONUQybS9o?=
 =?utf-8?B?djRZUnNvd3U1a3psQVhKNHRFN2RHSllONnNrbm52RE5RZGxlY0hVNXJXcVZL?=
 =?utf-8?B?UUxtOVAxU1ltc2pyNDg2eVJKNXF4TFkra2lyNm1WaGxJYk5BVHRwWWc1bDlC?=
 =?utf-8?B?Mkh0OGtDUmNOZjhlQlYyUTFXcWNCSW92dTNDdkx2a1prSDB3d3NoVVhKWEd0?=
 =?utf-8?Q?bCgpnQpfRVREk7l88Grv7m3Fm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5ec195-bc5c-4782-6c04-08dcb079feca
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:28:39.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhCvyrR1tYkeO8g95p/vsgj8v1CaspTA7c5NxXWRbYUjEMbnPrZVWA/2pr/Z6w60tgofGUAg87QXqycqiVVBzE+OqdvwqYbObOsZMT0xFeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6870
X-OriginatorOrg: intel.com



On 30.07.2024 10:15, Youwan Wang wrote:
> If the PHY of the mido bus is enabled with Wake-on-LAN (WOL),
> we cannot suspend the PHY. Although the WOL status has been
> checked in phy_suspend(), returning -EBUSY(-16) would cause
> the Power Management (PM) to fail to suspend. Since
> phy_suspend() is an exported symbol (EXPORT_SYMBOL),
> timely error reporting is needed. Therefore, an additional
> check is performed here. If the PHY of the mido bus is enabled
> with WOL, we skip calling phy_suspend() to avoid PM failure.
> 
> From the following logs, it has been observed that the phydev->attached_dev
> is NULL, phydev is "stmmac-0:01", it not attached, but it will affect suspend
> and resume.The actually attached "stmmac-0:00" will not dpm_run_callback():
> mdio_bus_phy_suspend().
> 
> init log:
> [    5.932502] YT8521 Gigabit Ethernet stmmac-0:00: attached PHY driver
> (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
> [    5.932512] YT8521 Gigabit Ethernet stmmac-0:01: attached PHY driver
> (mii_bus:phy_addr=stmmac-0:01, irq=POLL)
> [   24.566289] YT8521 Gigabit Ethernet stmmac-0:00: yt8521_read_status,
> link down, media: UTP
> 
> suspend log:
> [  322.631362] OOM killer disabled.
> [  322.631364] Freezing remaining freezable tasks
> [  322.632536] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [  322.632540] printk: Suspending console(s) (use no_console_suspend to debug)
> [  322.633052] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: dpm_run_callback(): mdio_bus_phy_suspend+0x0/0x110 [libphy] returns -16
> [  322.633071] YT8521 Gigabit Ethernet stmmac-0:01:
> PM: failed to suspend: error -16
> [  322.669699] PM: Some devices failed to suspend, or early wake event detected
> [  322.669949] OOM killer enabled.
> [  322.669951] Restarting tasks ... done.
> [  322.671008] random: crng reseeded on system resumption
> [  322.671014] PM: suspend exit
> 
> Add a function that phylib can inquire of the driver whether WoL
> has been enabled at the PHY.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/phy/phy_device.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 7752e9386b40..04a9987ac092 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -279,6 +279,15 @@ static struct phy_driver genphy_driver;
>  static LIST_HEAD(phy_fixup_list);
>  static DEFINE_MUTEX(phy_fixup_lock);
>  
> +static bool phy_drv_wol_enabled(struct phy_device *phydev)
> +{
> +       struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> +
> +       phy_ethtool_get_wol(phydev, &wol);
> +
> +       return wol.wolopts != 0;
> +}
> +
>  static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  {
>  	struct device_driver *drv = phydev->mdio.dev.driver;
> @@ -288,6 +297,12 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  	if (!drv || !phydrv->suspend)
>  		return false;
>  
> +	/* If the PHY on the mido bus is not attached but has WOL enabled
> +	 * we cannot suspend the PHY.
> +	 */
> +	if (!netdev && phy_drv_wol_enabled(phydev))
> +		return false;
> +
>  	/* PHY not attached? May suspend if the PHY has not already been
>  	 * suspended as part of a prior call to phy_disconnect() ->
>  	 * phy_detach() -> phy_suspend() because the parent netdev might be the
> @@ -1975,7 +1990,6 @@ EXPORT_SYMBOL(phy_detach);
>  
>  int phy_suspend(struct phy_device *phydev)
>  {
> -	struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
>  	struct net_device *netdev = phydev->attached_dev;
>  	const struct phy_driver *phydrv = phydev->drv;
>  	int ret;
> @@ -1983,8 +1997,7 @@ int phy_suspend(struct phy_device *phydev)
>  	if (phydev->suspended || !phydrv)
>  		return 0;
>  
> -	phy_ethtool_get_wol(phydev, &wol);
> -	phydev->wol_enabled = wol.wolopts ||
> +	phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
>  			      (netdev && netdev->ethtool->wol_enabled);
>  	/* If the device has WOL enabled, we cannot suspend the PHY */
>  	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))

