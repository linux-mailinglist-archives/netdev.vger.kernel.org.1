Return-Path: <netdev+bounces-157781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381EAA0BA2E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C54169AF3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68ED23A0F0;
	Mon, 13 Jan 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cas3wVZC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B71FBBC5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779287; cv=fail; b=UhdmdKVLN5gNGQ2lJjQvkJWpygmxdZvrQj0s6rAm7pllQTfj2DKyBs0p3Vmpjf817lczJS83JC+SvT7YgbwE274LHgsGgsiMeYo2wksRRek/DADeZOqUrUM1tqUAWExCuQ5mE5u1hvRpdEeHfbjmdpmA2v3terEN7hNQy/ee+SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779287; c=relaxed/simple;
	bh=Bzlk/q+zio6uDj3umdyb5TtaWQdqnYEitKEHbG8GLgQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rU1Zj/PwmBmsBniuEQ92rR1NrZDTGhws8Ol6T0CmNqwwFw3J/KkS7xsygsgzzzP/oq+u92oLYuD/FQDxenfkIYSZbIwuUWZoIYxBwaeottVEg6PrXB6wEh4Rf7pXNJIh3WARyFAIh4yMlsetZ1vkVXbjWMCSCcOxu1vdxKpeguE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cas3wVZC; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736779286; x=1768315286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bzlk/q+zio6uDj3umdyb5TtaWQdqnYEitKEHbG8GLgQ=;
  b=Cas3wVZCjJrffo3BiMM3Lres3TC5ycZd4+8nPp7OjMU+5Zf+N33d/lV7
   3gDrshsOFY1cvZVk/0i2APiPcMCB3rc5SWCxmevKYlxxVM0WOb4oFGoej
   hhwb6wqr/lvAm2Ak7ihU8YntwMjY1UiPoGZCMsyUxZvz/rNuhJApHS0o5
   y0Qu0ApsKH8uq5/lHQD3nOLL+nDcj4l3I4mq2J92t1pGhxQJtbk03U810
   QY4h5DoCEQxBuB4K3WlT3bdlXVPSOdvFcQRZmcP2G2CkBWh6Kvo1gqlDL
   x/6pVBgwaR5ekDQBTkpnS/PlGwtcn5RL/oGKaOnHtblxFowurPzI85wME
   g==;
X-CSE-ConnectionGUID: SvxmRq8ZQ8SQ/QJBhwk13g==
X-CSE-MsgGUID: RRGy9ozLSzqrkK1vHZj6yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48460178"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48460178"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 06:39:03 -0800
X-CSE-ConnectionGUID: 5UMWtfn/SNueAPfdR+5wtQ==
X-CSE-MsgGUID: dUQmzrK3S8WzKtHbbQ6cKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141776029"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 06:39:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 06:39:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 06:39:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 06:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0QOfdKv7+hnxcr6SSuIXa/qSfswy0A8Jw8so1Y9wjnwynOtWSs5ZXiSuBXMhxAYlx8wz6cTAdNZQAoBdcpKiIPV+x6EaE/MlEngU6NOfK2njhUuPyRQM1bbfZrdph3gE6Q/j9fyA9ScFy4+8zPK/yzio2B+plkV5eHgXqMEJc2MDA4nXaqPaBVPxnkOssUpYfHoAK47RvNoElepPOapGzMK4y3CCEnclOziGDQyHTQDafnTWWIVIuAnLwfgMTdEPHGaXLVRYLG+10H9Way/P49dvpp/aeV7T7mHFk37p6Eyb+acLlisn9ERPZKTEMOW/HobHA/tmMNCDAv9QPeYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T1c1qB3hG9ynC55+dNnX+ib0poloTPBt4rFcswzOao=;
 b=N/NmDgV7IkO57o47BPQi3K2ArQoO9yxaWgyjNSa/SFlG2ecwqS6BVeZxd58iZSHXKhx1Fmi1mSYInXkVuwBCmtsEeo1p8NmN3/kjpgH9+x2qSNF4b2eOLQNkMDRSn+BGPUlwPjYmOhYJT/Tvn3vO3XqZ3H0q75PHBUeiT7uo2BA5qak40gKQ8Ymjn+Hx+0tS4Xx+H7XSLAf/JSRUpKgK/0Vb9+sZ7OiTXvN8gK212Sgpylklc2H2g+djFmz8f79YufYzAqMdl/62CCf26WdCsBVrO3iNkqCYdw6DCCb4f2fN0g/QWNCq3Bm9R3w2l6ZO0+SEGQ4HxFSZ0Y9/D9ML/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:39:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:39:00 +0000
Message-ID: <50b370cb-ea52-4fd3-b3b6-5038150762d3@intel.com>
Date: Mon, 13 Jan 2025 15:38:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 14/15] net/mlx5: HWS, update flow - remove the
 use of dual RTCs
To: Tariq Toukan <tariqt@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
 <20250109160546.1733647-15-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250109160546.1733647-15-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 6992a4af-a68a-41ca-336a-08dd33e00491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWpvay9IS3lmWENDUEVMSkNLS0RscE0yMkNOOXhLYjVpYnByNEljeEFKSkp0?=
 =?utf-8?B?c1FDZ1RCUGRxVTBCNzRnbVN0MkN0N1NOZ2JxOGttaW5rcXJFT2YxVVpvcmp1?=
 =?utf-8?B?cXEyRmJoM2FaZFROOEhyOXhwTlM0elFISWd1eURhblNRaHRUK2VVQzVLYnlx?=
 =?utf-8?B?cnM2Z1V0QzEvbTNjdTlnTjN4Ny8zdGdQVFJRTERjVHUrYjFsMUM0RGlnZUFX?=
 =?utf-8?B?NGdjS05aMFVnMWw2cEpENmw5ZW9aMHh5OXZTRHdjZXN4dzhoNkN3aWVFSzRn?=
 =?utf-8?B?Mm0xLzFnMC8zZldYTVRMbGlIbjlVVzMzYzl2RTVLUDhsSCtYT3BmZEJDV2kr?=
 =?utf-8?B?M1llUm9xSzkwOVRpSXNmb2FPV1dRQnVPOS9YUHZWV3A5SUkySy9UekkrY3hX?=
 =?utf-8?B?YWFTekZySWtYNnlha1B0THZRdHJVZGNrazBiaDlReVU1cjR4OG96RzhHbTF0?=
 =?utf-8?B?ZUxPNGpMc1REQ1YwVDd3bE9UM01lS0pXVlltYmN1NDcwOUFuUDNkZzZ5aURz?=
 =?utf-8?B?c1NtN1F3YmExNkhVZFpQVHFJSGdoUTdXdnM5cDhUUHBTZmlNZkRtekV5Mlhp?=
 =?utf-8?B?RFBzYTY5K1BLVHlIR0pyb2ROY0NVZW11MWFGRUUwZzlLejRYQThqLzJ4eDV3?=
 =?utf-8?B?V0ZseWNrUlovSm5xUTVOVmNZbWlEWTYyaXR6eVYxR3ZFaHJoUXZBQXF1Qk1C?=
 =?utf-8?B?NjYzQVlnbHJQM01oMVV5TTE0M3lqaXl3d3JPT3lZcHJCVGI0WEdlaVJ0TnZ6?=
 =?utf-8?B?cEZqZXppU1RJWnhrZmQ0Y2xlTzMrUUJMblM5NlBveGJHUU1rTzNVQUIvVll4?=
 =?utf-8?B?QlJuRVNqb1dPL2lPOVhEZFhYWHpSLzI2UTNMQUErTmowcmtrdFlZaWI0SFBr?=
 =?utf-8?B?TkY3K3B0Qm9DS2oveFBhZjBUMzVYM05jRGlSMmNVMGRqcmlzbXJuK21HdXpk?=
 =?utf-8?B?WTRiN21EWm5qNTJWUk55Z2xMWG1BZFB1Tk42RW4vYTdKUjJOVjEyY0JFZ3RZ?=
 =?utf-8?B?VXZMTngyTXFKK25IMHFNelBjdmY4cll5M2pLa3JwcC8rNVFJamRYWlV3L0tW?=
 =?utf-8?B?L1ZyZU1xR0JDMVZxVjlERnpWWEMwNjFycTNKRHR4UHVqb0xoTXV6Z0NZZ3pH?=
 =?utf-8?B?dFd0U0pHM3I1cmRWN2x1RWFML04rQkEvTnRIMC9ZZy9VT1g3VVFta0ZmRWZZ?=
 =?utf-8?B?NlArbjd3RCtuVEdzeU9BWElXbVMwT0NvYzkvdDlrbitLTlQ3VkMzSzh4MUFM?=
 =?utf-8?B?d0dCa0FvZS9mZDNIK0E0NEN0aTlaWXBxNTJ2WlJ3cHIyd0V0Z2VFSHdjZWMz?=
 =?utf-8?B?TVphMjliNzhCbHNnbnV0a0MwT09zcUJ0cnNrQWxHWWpoblpwNnFFTVBRRWpE?=
 =?utf-8?B?d3BTSTZMcUh0ZTQ3STFBSHNoZHlpeXVZdGJNS1pVY21Gb0lvLzJUMzVFcVE1?=
 =?utf-8?B?em12d2xqdUJVWHdWbXUycWtzYUQvV09veWU2RjcwMzZTS1N6dFFSOVk5ZjI1?=
 =?utf-8?B?VkRtNTdRUUx4emdVNVExVWJ5U2RnT3d0QWE5UGs5UGkxZFphczdVWTkyYlBi?=
 =?utf-8?B?SEVnMWtJQ1Q1TWZXbUtoTU9pQ2ErTlZvZkd0UWRSQTF0N0FLU2g2UE1XQXJl?=
 =?utf-8?B?c1BBOWlOOGxpTnFwWm5hdlhBT05aS24rK1ROTDRrY1ZCbHREYWxQMzBRMmp4?=
 =?utf-8?B?cHUyM2VGWFpDQmFSKytPWE5uZFgvcG5FcmVpSGFFbW9nV0FtVFBHaGc2R1Rs?=
 =?utf-8?B?bTNiSWJGcmpFNVoxdTJXS3RwcTRibGMyeWZVcmp6VHBwOXFQVE9DTk16US9H?=
 =?utf-8?B?TnpXajZra1ZXTnFrTFRnU1p6a0xqNHRBZW1GWFByVnhPUi9xWUhoQXM5a1dL?=
 =?utf-8?Q?quR82CuchWTyG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTZ3M0s2YkFtTWZUbU9lRUFWb0tPVlYveFN4NFM0ZUFYOWJtMU8wajNEdFFy?=
 =?utf-8?B?SHZya3ZsOE1GMjF2RkZoZ2ViQzZ6RnhXVVYxc1lsYlhGQmZ0OGRFL3FVbGl6?=
 =?utf-8?B?blJKWEQxM0ZGWVhYZjQzSkI4VWFTRDd0VWl0WVcvbFp5RzhzU1lrcXVyU0hn?=
 =?utf-8?B?VmErMUtRbWxid1NEUVJFRGZzQjhrQ3hUTUtpYkxKM0dYVHRUYTNMUE42M1hn?=
 =?utf-8?B?TUZHRGJxWE56azhrZnRQVFNYU3U4STd2OFp6MjJGZmxaYmhNb2dnaUdOZnRF?=
 =?utf-8?B?bTNhbDZTOEZNb2dLanJxNWlIZWRuZ3hJMVo0OTVIbmg4QjhhbkdHeTN5ZEVa?=
 =?utf-8?B?MzRyOGhpRVIxSHVOTmtsZUtNRVM5NE5LZFhFK1lJTDdtTTlrb1V5MUwyMU43?=
 =?utf-8?B?V3ZscUtBdVZ2MW1CbzBvTXZGNEdlK2ZMYXQ0akJOR0l3WUUwRTArbCt3RFkv?=
 =?utf-8?B?cXYwQlIwR0laR1BXRm95YUZuSnh0NEVGdHBoRGhpUVRJR3dnQTNKSUkrY3B2?=
 =?utf-8?B?UGFJQnNpWGYxR2R3aXBwaVdRSEJsWndTZFl0ZWFvMEY4djM2aTlnZUt0SElL?=
 =?utf-8?B?ZnAyeG41UkFQSmNZNmowWExwSnZDM3JmSndMYlJtTGV4TWdjcWlXSjdDMjAy?=
 =?utf-8?B?emNHdmo2RnRRSG50enpHdUc2Q2pydytTdWZ0eFQzVTk3UWpPTVlBd2lwSmRI?=
 =?utf-8?B?SmtXbWNpelVMb2xzMTVtRkxoQXJnOGFDVmVJdXArUzg3emFjUFFwZzM0UGJw?=
 =?utf-8?B?L0g5NVEvYXRpOTkrVWJkTGt0YmFyVGU0QmZYQzNVRVhQT0pmTS90dDY5M3Av?=
 =?utf-8?B?bkRCcDkxcTBiUFhWcTlsL05IUVNtR3ZiTzR0OFArbiszY1RoeU44dWJtMFA3?=
 =?utf-8?B?d0t3TXJPaXlIb290ekRFbkNqKzBwWDFON0RDTzJCL01JUzgyZkh0K1l2aG5Y?=
 =?utf-8?B?ZXMzVXhyeWtITld5MEJIbmY3NXJJTy9OL1lScEMzN3BTZTJKWTVyamJJYUxj?=
 =?utf-8?B?RTBBOTZJd2lqZ1Vhcy80a2o2RVkvLzYyZXF5Z1cyUGdidXd4ZGxVNWRFRlRm?=
 =?utf-8?B?cFJyVXAyUXZ3aVhPUVBCMlJucHZydkllMVhlVUV0MURRL1NPakZjcmhlL3V4?=
 =?utf-8?B?UEhEUmV4V3pXd1RVMk9PQ29iWkE1czFsSmZ2S1RiMzFlVzh1YUUzMVNZdm5r?=
 =?utf-8?B?RGFMbG41dENycm5hL3V4WlIwZk8rLzhUcStJK1dTRXRYUlowTEVVMEJ1Zzhu?=
 =?utf-8?B?MFdHeDdjSHlrYlRXVHArTkp2amdEMTlZK2hTWkxCVnVBTlV1YWJvNENCRk4w?=
 =?utf-8?B?aHN6MnZMNWpud2RBL0h2NTlUYzR4ZTNycWxGRG9ScUxGUHZYUTJRellKaDVx?=
 =?utf-8?B?MHB0VWMwYmloRWxwNy85K2E1dzVFejRLdFVFRERCZmQ3SFZTNG9DdU1DNUZE?=
 =?utf-8?B?TUYweVVQNlpTYWptS1BEZDl2a1M1NTJwWXZoNkYrbzQrek93cTI5RXR0dzdj?=
 =?utf-8?B?MGptKzhvVm1QV2o3NW83UEcxaDhqaWRRTUJRQ0l2RWsxMHNUSVdvWnNqTjl4?=
 =?utf-8?B?RnpOaEFFTUFtWjg2UktRelBacUMyVGZEY3NtK0hhTW5ZYlNzTUNTQkV1Q2pm?=
 =?utf-8?B?V0s4S01oQnFiWGJjOElsTmd3bHpSZXJ5djV4VFRSaXhPcUY0YzRYTkVaUkc2?=
 =?utf-8?B?bVpCbnZrQnVSRUdjVFo0QzZmV2FMdHpyUEZacVFXaDhXOWRJOEZWWC9pR3Mr?=
 =?utf-8?B?NTUyMUc1ZERHMUJla082R2lHT3VIS25KbFF0VlV3aTRidWFCVnJsVnp1cWwy?=
 =?utf-8?B?QmVJcDVZdmFrUXhIeTY3dnNHKzFvVXB0MStjWFRZcG5NS2w4SVplZ1RMeURQ?=
 =?utf-8?B?bXRKZCtKbkp6RXFiL1I4ZzN2T01mNTRXU3RaeGFZWjV0K0d5WlduVGZJZ1N6?=
 =?utf-8?B?czVBc1N0aGlqMEhnNlFsaXdkZW13aStBdzBVYWpyaDBVQWlubVJhNlF4aEhr?=
 =?utf-8?B?d0lzR0QvdW1seDFyOVdMQktLRlFJZ2J5dWhCd3VvUDFySFE4MVFVR0Racnk2?=
 =?utf-8?B?UVFTaTM1Tlc0N2dodVFac2x4NDdUWEhsVDNaSzZpT1dtNHNZVm93ei9EcEZS?=
 =?utf-8?B?VTJzWVdsQ3BhMXNhSFh1YWplSkthV3B0UDJzS3JkY054cFdlRExGSjBSMG9G?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6992a4af-a68a-41ca-336a-08dd33e00491
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:38:59.9768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3iAxOQwNsaF0GvJ7ly0imWlTb5SVRxSiEc4RSkggd4p9KXqanNZmzbeYQd+wvTiIoBM1KysbqooXuXotWu3yQreJzttoUBY3t3d5Qsp0TcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

On 1/9/25 17:05, Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> This patch is the first part of update flow implementation.
> 
> Update flow should support rules with single STE (match STE only),
> as well as rules with multiple STEs (match STE plus action STEs).
> 
> Supporting the rules with single STE is straightforward: we just
> overwrite the STE, which is an atomic operation.
> Supporting the rules with action STEs is a more complicated case.
> The existing implementation uses two action RTCs per matcher and
> alternates between the two for each update request.
> This implementation was unnecessarily complex and lead to some
> unhandled edge cases, so the support for rule update with multiple
> STEs wasn't really functional.
> 
> This patch removes this code, and the next patch adds implementation
> of a different approach.
> 
> Note that after applying this patch and before applying the next
> patch we still have support for update rule with single STE (only
> match STE w/o action STEs), but update will fail for rules with
> action STEs.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
What is STE, RTC (and STC from your existing code)?

perhaps not worth a repost, but in general it is much welcomed to
spell out each non obvious acronym once per series.



