Return-Path: <netdev+bounces-285616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id omlaEFRj/WnUcwAAu9opvQ
	(envelope-from <netdev+bounces-285616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:15:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FA4F1683
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 06:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571E7301D315
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023A272E56;
	Fri,  8 May 2026 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkrHFKOE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB512FFDD6
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778213712; cv=fail; b=lPo6TZoEE87w1BHBlhpZT+fyW93RwN7EyTSJ5Y9yhOvsaXwm/PuRmtSl+EsaEpZb8EtZvVJ8oJwvfVgXi2QG7UNGzMPCdaI4htO//ub6Jyxm/6bamIcqL+xKW5X404jLgBARXfs1TPdKeJVeujtr4FH+NcXh8x1Z//vgcveZmLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778213712; c=relaxed/simple;
	bh=Sn6gmg4laYPWucujUo68mK3Jv78SMJvFs7mBXxzJ1U4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuYeNKJ8g3Lhf5Uo+79xWhD0k8WYVVZ+bw3wWQujgwJKCEg3Yptfa8pu9HDtrgXFLAAofdTQf7CfXaqlwbS8Mt0pgpk6Po2l0E9Zk+ONAXdiBdyMLZEXebBIx2tEXED3z4bcuRQO/+U42CETMO4cXSKT6U+JlPYEpl65AMbkz/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkrHFKOE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778213711; x=1809749711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sn6gmg4laYPWucujUo68mK3Jv78SMJvFs7mBXxzJ1U4=;
  b=ZkrHFKOEapfyTlNPa/VK4DpMrKqJo0HM22paK6LM/hnO2//J5FazIzBd
   w3GAA3zmwYLMgTpw68sa49FRLFR9slSiqHzbbdtwP/E6TGXCaDEtAtv7x
   JqA+hsoW12VxaKLdVULVc0IZeZwwgdRo2AOp1CcTCUaN15+XWYj1RIASz
   8g97DWcdBepTSCEIkYZLcNzTznpj+o7ct40G3dSainnDmNiHvpbR/Zg0q
   0ACnkRsZFMTVCjUp97TXTgcFKtBZQunjx5iibQz02yHN18z4Tt0zzEmS1
   sACzWlCqxSn5BQVlIj6cBghIp5KfUaDsYCEP+PejEi48FINru/4BYF7gE
   Q==;
X-CSE-ConnectionGUID: QV7RlkCgSNmybBQ3B7zqaA==
X-CSE-MsgGUID: L3YS5woBRlu/8GbWDvFUjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="104637816"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="104637816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:15:10 -0700
X-CSE-ConnectionGUID: BKMlzuGRRaipkzVxx3EPnQ==
X-CSE-MsgGUID: AjnESq2vQke8gYvLb0rvnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="260368389"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 21:15:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 21:15:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 21:15:09 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 21:15:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vw9VmiW5QttglLGRVcV/EULHMPm/wvHzW6+SMGzf3AkFChXkKxWM7DH75keMck4n38/0L+31AS7GCrZguufdWuOJ2vaJB9YUbCyxGSx3ZoyKw/HyO/vDUOZkaLwhPknLUWAXK1Ou6KN0OeGtrsDTK+8So+FQy9IUphMmc43jc2H/xDLxiEthyYdJ00ixTt3LBByGElWxKcp4JUVebAsoPW1q8SU/NwwCq5UqoSAdy2HQDPh70LHM1wwlbkAbLCEd+Fnv6ccpSUKU2p/xJIg0IvMFI1rGu9LV+jxxCO3uoii5Xt6GQxkyzgGJfZHRco1cywxRt4roF7Wh6FU6xYcrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F/4oYjpN6lQXjw9VtE1qV+aHCIVaWu8JSvJiFTNsQs=;
 b=EiBllQWs0Fo8yt9G1PgHYHcFQbWC6j0I+YDpRfYYaGfK3fiWrY7ZNG3c1hrDQseAgY6SmouoLEVOuJQnRQWVRLy1NmDoXpFKBbeGn6XZOkOY7aE5ZONvcjDJlvlaj7mAjGLjDMMXKP9sDdbU7yD4QH+mOo99T23YoAkNpd1/VaKl7dhoIwonND9oNsrTF/Pt01lMCm6ifaf5AXxXF2LB3Wek/0SuECKpp54goRRcnmUQMJ5+Dh9vyr+XK4wDKEK+dyhjOXw/fss3n33jM1KqYzsiRl7+P7xZriKmYrRtcu+9uh7AXWDvN16klcipOKnfAH5nOYvhFrQhSPsQftUjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ2PR11MB7598.namprd11.prod.outlook.com (2603:10b6:a03:4c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 04:15:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 04:15:04 +0000
Message-ID: <05165d50-d60f-4afb-aeb4-1c20641379ce@intel.com>
Date: Fri, 8 May 2026 06:15:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/8] ixgbe: use int instead of u32 for error code
 variables
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-3-aleksandr.loktionov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260508031226.3601800-3-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0021.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::27) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ2PR11MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa55026-e6e1-4abb-1199-08deacb861ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: h5ZbXDwaDJZLo7nucc8meYIfiY+zglrH3DJbs2t5H+E6zilR9WksUGm7ZP/R4YtSixd+UE0p8365d/PUUZm9ZhMDXI3m9yefsa2t4P7GyGzHAbGUyacry2it3L9rjP7EayghO7suCp0B3ioiGrOmhJ/oQNnANcZmplA6JCfqXfgej+rMoxb12d4Tkm225LFpCfAyMUTCIQLJ3fji6vpuB6Bg3z/+dPCu+AlKk9pizxHdazIGJI2Jg4sOb2ZzaWeqsKcMj0NpS0KOGOOtrA7QxHEZ8lQL6fspniyYxrUUFdmI2TEVQ9qi6G0Zs7VsvGKeK0uprybU7rxRb1VCUQBFkMFmAmWqxFRXRWYOMEbhXsNixwvoToMso6cLxP6ZZFjzEuILgXizin0lp09+lqn6MH5JAt/bE5q2LNrlm1ThB2mnUGZVpl3yXA7GZGKP9oHgvVzzbJpM/yiV0ieu1TRBMf+fum3LWVdPDN27bA3xT7s8rViiXc8NISL57cln8BTO6U/6F+IHBMzCuny8cGuKrv9Xlxq543HmEqGUEt96hd05imfAqEonbV9UvvH/Dyr8qrTZvkR9n5EmnWjYdefI7EBlg+zjJEVv1I3XXnDrzWYORTW/zKuKbgJ8Rc1BxcJjNpWYyordtqrPem/9PsW4AI/snDrzUvnifevkkkqFhFZCUUkpdK13ME3WSK4lfkHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmdWZDlDZENhKzd1ZHV4Q1RnMVRTazdFWEdLTzRVSFdLMUw1MnRLNmdBRUVp?=
 =?utf-8?B?MFVBUGsrL2xLRE9UL2J2bE9sWWRvbEVsOTRaYWtFOHk5Z3pNbXBJRFFEUFBj?=
 =?utf-8?B?MExFQi9tb3ZGL1dDTmVFMUVGZGNOc1ZJZjJUUFF4Q2x1MmpzL01lYVF4L0JX?=
 =?utf-8?B?Z2kzMEN4RHNaQktTSmNqeWlTRFFtdndIckFZSVdtYUJUUG5rdGl1c2svYVpM?=
 =?utf-8?B?N2ZqbW5IRjAxbks0MG5kSHRPclBac2VlQzMvQlp6dTRhVGdrODNjTHlOZW9n?=
 =?utf-8?B?TjRyWXZmZmRZd1lHblNoeUY2MCtSZ1dVRzk5M0wzdVV2WnJZLzA0UG41Mlpp?=
 =?utf-8?B?ZDFZMXdiNEZucW90d1Z6dStOL0kxdzArU1lWdFZkZWlvSWFqSExJQ1gxc2lo?=
 =?utf-8?B?ekhacWFwR2pZQ1kwQVRBbWtDVUpaKzMvSXB3Sk1GLzJRRTUxODNZenpITzRk?=
 =?utf-8?B?OWdlMU5aYzUrVUE2ajZBVFJ0WTRTQUVLMENvMkQrQm55cE1HQ0poekVUdUZ1?=
 =?utf-8?B?NG9WaGRabE1oWW9halRBaWpibHpmdFJ6a2U3Vy9xN0lwK01WdUZwY0t0Qmc4?=
 =?utf-8?B?M04vZjh0SHZxY2FYWlhhUnFZZm05YzNZenVnamZEZmdQRWZYM3IzYzhoNTBo?=
 =?utf-8?B?UWgrZ3YrK1lQdnQxeUdOY0dtV2psd3IzOGZ3TVpXYitkOVZSSmVZRmxIV21y?=
 =?utf-8?B?Vk96cWlpbXlyTGpzYTNVeWZ2ckZoRnhMbWw2d3JFcVpmMExYdkVaRDNZQlYz?=
 =?utf-8?B?VXJjTnFUZGt6UDZFREUxazNEb0FBUDllT0hLVVNUcHVnQzR1WjNOaXRqUDhw?=
 =?utf-8?B?b2R5ZGM1NVhTNHBsNm40UllFNGdobW1HMExIRHBiTVRCNzdhczJOZjF5aHdD?=
 =?utf-8?B?cllHQWU0L1ZBMFRYN2pHMldzRThHUUNteHJjNStiaS82MkdoZnIzR2c3Si83?=
 =?utf-8?B?N0tBcDlNbDcvMmdidngySHJITUxLMmxUSjdWMTJScW9KOThkYU8vUzNNNmhY?=
 =?utf-8?B?M3dTcDJMVHE0SCszdTc3Yzl6UEVrVERDanNuQXJkMDNvSVhBNlFpTE8wOHZm?=
 =?utf-8?B?bS8vdTBPVzg0SlVObHlBWk1rUzArRmZLK3YvNXlpREFOdjYzNjV6RFVrYWZB?=
 =?utf-8?B?TTRkakRTU0VRWUxIcTZEcWNjSXNBSW80czZ4aDI5aXVPY2xhYzhJcTR5RS9B?=
 =?utf-8?B?WHBVZHgvcC9ycGhXVDcxKzdWRER1bHBTRzVoSzNOaUNpNzhQWEFxUmY2ZWtY?=
 =?utf-8?B?Qzd3dFN6b1Mzb1lnSXc3WGMzRXQxMEluVW8wd0VIUEljT21hM0d0NEs3alVE?=
 =?utf-8?B?Y1dGcDhUaWF4L3I3UGZUVVhTNXZLZUdTWmZIdUhibGJFTjJhSStjdWN6VGp5?=
 =?utf-8?B?WWF6aGRuWFlaSzdVRjgvMDc1anZ1L0xNdmtPSERQTDlmVldRRGNVVGtmMkZm?=
 =?utf-8?B?SXJOTG94SW95T1FsSDJjL2tRVmxHeFI1Z0thNDdBNmNvKzVST0N4WE8yRERZ?=
 =?utf-8?B?ZUNIcXhsd1JKUXpRY2pETEJjUXNSc1dhd1ZIUkltUkJzVHhDbERwQ3ZEclk4?=
 =?utf-8?B?WmtobWY4L2ZLNzNISkd1S2lsUlJuRzRucHBrN1dFeSsxTnI3Y2pUSTJWNUFu?=
 =?utf-8?B?bzZrbm5vZ3NoMG1sYnB3SGIzODcyUExRSG1tT09uNlljekFLVkNyUFNpQ2Jv?=
 =?utf-8?B?N0xnSUE2SUg5U2VzTzhOMk9EUEphVTBkcmpRcGtvVWRKSGVHNmZFVGRVMmxY?=
 =?utf-8?B?cXRBa1dyK2lsK24rSWhja1RYMnBxU2N0UlJ5NmNXc25IM2g3ZWt3cHJJOFQy?=
 =?utf-8?B?azdFSmlNZEF1SGoxZEFHblpJZ2hmdUF1TTRuSTRzeDVTNFNmcTF2TTlrSDRJ?=
 =?utf-8?B?Qkg1UjhIT2h5ZFV3NUR6M2NRcmxDazIvUUtQUXVWZXlxQjdGbVU0SnFFcTVp?=
 =?utf-8?B?QklsYnh3VVI0SVlFQm1tWGljSTZVNTR5bXZPdTFLS3E5eEkxZzhtS3Y0K1pW?=
 =?utf-8?B?RUoyWWIxYWFZZVN3VERhSXl3eXJtWTBWQ0RhWGNEWk9IbExBeFcwbDF6ZkZi?=
 =?utf-8?B?MWxkZXJvM2lSa1R4dEp5L3hVdUY2Yk9nbng5UHJTV2JpUmlzNTRXSFdMOTZy?=
 =?utf-8?B?NlJPMEx2QXJsSU1jQzBsZTJJV1RHNjB6OU00ZkZmcTl1eWtSc095TUJtMmdz?=
 =?utf-8?B?SDcyMFAxMWlTNUwyMjRhWFJIajUwbXUxVEtUMnV6WnBTajd2Smg5QUhkdnRC?=
 =?utf-8?B?WEpmdUw2NWFaMXpqMG5yT2JtUC9YeVFQVWIxSGw1RG1MUG5jZFVqYjlneWVE?=
 =?utf-8?B?ald0ZzBPcU1QMGtBbFZjTVovOWxQQi9oOURRMGNFNUoxWncyS3NhMFBlN3By?=
 =?utf-8?Q?MaC4TsAZ9bl2koIU=3D?=
X-Exchange-RoutingPolicyChecked: OUN2M5wmvInNS+3OWV72cg+lIsgY9RMvTI/Su3jL3xx16fSpyAaKZjIOvYhveMM3VFI/qicVp+9IG89nBGL0WlLKDlss/xneTly7wvnCrCCdHqAChTZpW3zoZgXzDmqjy00enSzfDrFbA3NdyhNnRS4TCBAwrwl98wmnd2uhlwkEOD+CyvU9HosJHoQXO29wpslUaD2G2QDrYbhll3ZC6GaAE1u+lmCEm44YU/bpBsbYSPQyQX3wTlEZX3FmXNZhK93ixB/560ao+7iuIV+EnSCpOMvXN2zFvqOVIpf5ut4/f7UG4ZOSAvtxq7DNOcM0bcFpQmpcMBQkswD3VKfJnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa55026-e6e1-4abb-1199-08deacb861ad
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 04:15:04.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3DMEYrrGPchdYnr9lWmDVTC9C30MVlHLj+GldgJB7EywztYxC1yx8MGYp79BC0X8X8ewcZ8hx/lrpgeNfA8/ThqKku022aTYDqymvIbAoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7598
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 462FA4F1683
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285616-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 5/8/26 05:12, Aleksandr Loktionov wrote:
> The variables used to store return values of kernel and driver functions
> throughout the ixgbe driver are declared as u32 in several places.  Such
> functions return negative errno values on error (e.g. -EIO, -EFAULT),
> which are sign-extended negative integers.  Storing them in an unsigned
> u32 silently wraps the value: -EIO (0xFFFFFFF7) stored in u32 becomes a
> large positive number, so any "if (status)" truthiness check still works
> by accident, but comparisons against specific negative error codes or
> propagation up the call stack produce wrong results.
> 
> In the Linux kernel, u32 is reserved for fixed-width quantities used in
> hardware interfaces or protocol structures.  Using it for generic error
> codes misleads reviewers into thinking the value is hardware-constrained.
> 
> Change all such local variables from u32 to int driver-wide: one in
> ixgbe_main.c (ixgbe_resume), three in ixgbe_phy.c
> (ixgbe_identify_phy_generic, ixgbe_tn_check_overtemp,
> ixgbe_set_copper_phy_power), and six in ixgbe_x550.c
> (ixgbe_check_link_t_X550em, ixgbe_get_lasi_ext_t_x550em,
> ixgbe_enable_lasi_ext_t_x550em, ixgbe_handle_lasi_ext_t_x550em,
> ixgbe_ext_phy_t_x550em_get_link, ixgbe_setup_internal_phy_t_x550em).
> 
> No functional change.

unless there is a check "status < 0" somewhere
anyway, that's why the preferred style is to write "!status" or "status"

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  6 +++---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 ++++++------
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 65426a1..b6308c1 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7528,7 +7528,7 @@ static int ixgbe_resume(struct device *dev_d)
>   	struct pci_dev *pdev = to_pci_dev(dev_d);
>   	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
>   	struct net_device *netdev = adapter->netdev;
> -	u32 err;
> +	int err;
>   
>   	adapter->hw.hw_addr = adapter->io_addr;
>   
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> index ab733e7..de8f6c6 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
> @@ -262,7 +262,7 @@ static bool ixgbe_probe_phy(struct ixgbe_hw *hw, u16 phy_addr)
>    **/
>   int ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
>   {
> -	u32 status = -EFAULT;
> +	int status = -EFAULT;
>   	u32 phy_addr;
>   
>   	if (!hw->phy.phy_semaphore_mask) {
> @@ -2811,7 +2811,7 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
>   bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
>   {
>   	u16 phy_data = 0;
> -	u32 status;
> +	int status;
>   
>   	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
>   		return false;
> @@ -2831,7 +2831,7 @@ bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
>    **/
>   int ixgbe_set_copper_phy_power(struct ixgbe_hw *hw, bool on)
>   {
> -	u32 status;
> +	int status;
>   	u16 reg;
>   
>   	/* Bail if we don't have copper phy */
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index 76d2fa3..9b14f3b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -1911,7 +1911,7 @@ static int ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
>   				     bool *link_up,
>   				     bool link_up_wait_to_complete)
>   {
> -	u32 status;
> +	int status;
>   	u16 i, autoneg_status;
>   
>   	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
> @@ -2330,7 +2330,7 @@ static int ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
>   static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
>   				       bool *is_overtemp)
>   {
> -	u32 status;
> +	int status;
>   	u16 reg;
>   
>   	*is_overtemp = false;
> @@ -2418,7 +2418,7 @@ static int ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
>   static int ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
>   {
>   	bool lsc, overtemp;
> -	u32 status;
> +	int status;
>   	u16 reg;
>   
>   	/* Clear interrupt flags */
> @@ -2512,7 +2512,7 @@ static int ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
>   {
>   	struct ixgbe_phy_info *phy = &hw->phy;
>   	bool lsc;
> -	u32 status;
> +	int status;
>   
>   	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
>   	if (status)
> @@ -2606,7 +2606,7 @@ static int ixgbe_setup_kr_x550em(struct ixgbe_hw *hw)
>    **/
>   static int ixgbe_ext_phy_t_x550em_get_link(struct ixgbe_hw *hw, bool *link_up)
>   {
> -	u32 ret;
> +	int ret;
>   	u16 autoneg_status;
>   
>   	*link_up = false;
> @@ -2642,7 +2642,7 @@ static int ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
>   {
>   	ixgbe_link_speed force_speed;
>   	bool link_up;
> -	u32 status;
> +	int status;
>   	u16 speed;
>   
>   	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)


