Return-Path: <netdev+bounces-107676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5023391BE47
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482C81F21770
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CD1DFF7;
	Fri, 28 Jun 2024 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtgTkCmo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8B1CFA8
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576923; cv=fail; b=UCEcalEozH/MoQrYrttP3dLYug2q4ULesnjvv+RVxwrsJ4FNhA7wjCA9IfcN3mgiMR4GU2ItpOCnZQnWD/Xv8PAVGPB77xUqma3OurFzV7wf45ijm3AJhVr1nA7+E9T7fSB+pAAocbfq/eEo1cYQk2n/iCneNBtYql2WHZVzv2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576923; c=relaxed/simple;
	bh=tcVIa0GS1pr6W+q/Rs8aPvOhcvtvwij66yqFP9gH4qo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSoRHvDuoZy+nIdQa3lvCbzehZ1xWTtxCtqyxsyufmNpvnUXP7V2/RTH7SX34m69L20663QHcnIvgP4yz/D5o57CrZcK3Dj675FjRNEyYYrqWGggVweSUFLJC2994q067myZCb856F6FTls0Ukgdzp8GmFXkYW35jl3h0joCl4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtgTkCmo; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719576922; x=1751112922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tcVIa0GS1pr6W+q/Rs8aPvOhcvtvwij66yqFP9gH4qo=;
  b=dtgTkCmo2oQSTL25sufwCIiLFO72WALY8tddy6f3FPZHFeEREhi8jSVJ
   4TzwDsKJS2V/0H2/cyC6LpG/ECz51Om2kajAYhrcbI2svfXvYqTnOc5iz
   DHo5DEC2FCGu5OMGORwMztfSyYVZf0JJdiM3QK8sDDoPxCaQcHVxKcKpY
   1/MXfcicO6wWHYc79qKoMX86VzlDZIXuPDKs5r8W93iidOSRAHTs3eHck
   s3B22bQPpWFTXktNNkYToAyBQjTAVdUgWnc3FtWEeBqyzsU3rx9ySXMIk
   nK6YEswUgA+4qsHMwtVngFCYEPElqnCG+8vkIL+5GnyfN+vYRwC+hgjV6
   w==;
X-CSE-ConnectionGUID: Imh6KteQRZiaMcqZ03yIHg==
X-CSE-MsgGUID: O3HfOn9MRw+j1Cp3pm6iWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16575718"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16575718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:15:21 -0700
X-CSE-ConnectionGUID: kAuh+sXbSjK7xsm9NBlJZA==
X-CSE-MsgGUID: oiVC7N8HQ1S5b1p16NMhcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45135244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 05:15:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 05:15:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 05:15:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 05:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE/T7U35Nv0WtO/oCblzC1kPg9w14LpPEZUZT3aXelpk+XpV+dorZuxOYLX9gfJ0v/dSymrdlmMKEXTIhHJleZbQ9vx4OeeLTFNKKQfgadAbq+OhPN7Jjdp/HHWUYv9AeOrnampXsQx87Apbb25yO85xSQTJjYkbaK87qSMklvDJ8HSuwCBIGyXNQF5JAOOpaizfz52/Sp8+xVHnDGl3Qm6j78X61zmJYIjU7OUjt6AjETb4HEQCXCuQo8S22mf5Hng9tVMoNUrUS6/RFJZrUQMwVLPBjTQgf4FE7XJDv6ro4TJDsqZYZKwe7Aq9I7iNKRYiYYvIia67K/Fp+5rX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNUAV/TRETLJ6f1Fg72z4dPLO6FH8BXKjNrGpUjJxhI=;
 b=jiVnUDnAnWOfPboVK8Aqhkdb5aeQHTHeUnWtIkxcG0YOjQZwzEUYbmoPQcG0voXAWm+dv5emuhg4bNhJ5Vtgl+g/+haW6ltNRGwz7VZD/Tde/gG49rM5GaaSiki/YI4WFQr3uUsEJSQxgmeCBZpcliKK2xAWCLQBWL9fpHtNXwy9oRmleMstQtSlKKhjMZPSF1byEUZIA12v60xxX61DynqFNjfYkXHFtgzNtAr0fN443MRwx798Ga/XjiqYtTpA9kqdNjyF6ZemBxAn5WoqcpPs6seq07O0xyHW/vCQYQssBtT0CClKEXSLtvwBuS7JkgKE5tSyXtVbxuenrqWdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Fri, 28 Jun
 2024 12:15:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 12:15:16 +0000
Message-ID: <14d72e0b-3ec3-4d73-b2fa-e7f7b30f9a32@intel.com>
Date: Fri, 28 Jun 2024 14:15:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Edward Cree <ecree.xilinx@gmail.com>, <edward.cree@amd.com>
CC: <linux-net-drivers@amd.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
 <5ac63907-1982-0511-0121-194f09d9f30a@gmail.com>
 <b6f4adee-76c2-466d-9d0c-f681fe32baf8@intel.com>
 <582527ed-802b-f20e-4c50-f6f2ba460c4c@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <582527ed-802b-f20e-4c50-f6f2ba460c4c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 3195d6d6-cbc1-4615-a520-08dc976bf81b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ky9QdzNudkZPNkJwUWloNjdJeU4wYUZNR3BEZ2JGaVErekZYVC9RNmtSV2du?=
 =?utf-8?B?dTJPMm9ud1UrMndxV3BqdUgzMjJGelFxeWFFZWcvRVkvZHZpVVh1aHR6OVE3?=
 =?utf-8?B?NGx4R2hNZXVXNTkxUzBpZ3hZZjl3eDBrYW1YWkVWUXBsMmpuU0hRcWowNnJy?=
 =?utf-8?B?OTBpUFpnQ3dIQzhEb1BWT21OeGRJSkV5TUkrWlRScHBFTjNHREtZaG9wU1Ru?=
 =?utf-8?B?SjJvbFhZWmd0WFd1bjJiYU1HTWhMKzRxQVFoVG5VV0x1bUxobE9US2lpTDJU?=
 =?utf-8?B?b1dTNnNJM2FjblE0bDBVUk8ya0ovaXNSTFhWYlkzZ1JvREFETURkOGVSaks5?=
 =?utf-8?B?eHF1Z1Nyb3lyUktYWkYraldUQ2gvQ3V5SlAwbkMwVmtJWG03MHQrTTZFQ2RJ?=
 =?utf-8?B?MGNzV0NhLzlSRnkxVTlQa0JJN2x0ZHhoNmxTVU9jTWJyWVBVbmVwMWY0WVlW?=
 =?utf-8?B?M3pWakNLeHhUSll3aVlRSm14U3ZlckplZFRjcndEU1NUalgzeWFZS1pIYUp6?=
 =?utf-8?B?ZUZEY1NCVkxVR1NsdlFpcHFGelg2eWM1NW8rV2hZam9lNEcrUVU5ZFdOVEIz?=
 =?utf-8?B?bmpXa2dlSlBlTW5WSWdsaXVvMnl0TXNacDlTaFRrMnN5dmNoTEtzM1BLVlMw?=
 =?utf-8?B?Ynk3R1NOR2NCVWJBeTZ6eStzQ2QyNjVlNkx3SW9YWlBmcmF1SzVsZEgyVGFn?=
 =?utf-8?B?SXltZVJwNWkwVjk0QklxSENrcDF5VkpCaGJrb0lOOHJHZ3dVYXV2Ny9KbG5h?=
 =?utf-8?B?WlBiRTVHMVdPM2I5aUJmNXJKZUVFRHVzSWw0U01oTzMrSThYQzlxWmpyeGow?=
 =?utf-8?B?S3FrNzNRT0RUMkYvY3FYajhHa0JmcTlVUU45ZDVSY1k3bU1SYzNJalJhSm1r?=
 =?utf-8?B?MVFwQXd5aDJYL1hGTVprN1M1T1hDaVE4VkR6RytwQVBRa1V0bnc1K0cySXZR?=
 =?utf-8?B?WEdUaHNZdkVkM0Mvd1FNdHkwbGExVzc3WDNqOCtmOU10MGZjMHlReUY2aGZI?=
 =?utf-8?B?TE9TQk5WcUV0aElpMkJyQVZOR1pZMTdvMDMybEFoajhvYUhpR2xndnVlQ2xN?=
 =?utf-8?B?T3ZDVUFkQXJSVDdoSm9lb0FSQm9wZm5ZQThucHh1SGhBcEdZV1JCM2o5VmpM?=
 =?utf-8?B?eWpsTzR5cDVxak55b3A5UGwwQWtJZU82UlR4cGM2U3B6dGpvN1Z2aXhlcktD?=
 =?utf-8?B?KzRFMGZCVVpucDBGNWVHUmpJVGhPYVYvU0hpTzdOU1M0LzBqV2xPU01keEt6?=
 =?utf-8?B?T3hiTStiWW9tZFNwVlFuMjhBSGE5M1ZJdk1mWG9hNmVodm93enVEMlErOEpL?=
 =?utf-8?B?cU1LeDllRTdtaStzcVE1dCt3NFVpdHFJSjlCSXNsOHNKazI3U0VHRS9pZU9j?=
 =?utf-8?B?UWtkREZSc0FSLzFWOHNISlJzbnpIbDR4b1VwQ21mcnFOdmM4UVdBOHhUdUJE?=
 =?utf-8?B?WFhGcllwZTNzQmJwc0w1d3dHQ0EwQytYRHQra3dxTkNkcWVKVWo4Ym4vMWZo?=
 =?utf-8?B?Yml6RG00SnE5UjFGd0Y2V3VESTY4bk4zM29DMGI0VUc2WEdqcVhDZXVrcUJu?=
 =?utf-8?B?VDRxaWNodEM4WVFMS1BMSk82amNOKzVzV2U3Qk9LbDUxa1RhbnBpcTh1MUZR?=
 =?utf-8?B?R1FBYVdPT3p6UlRPVHZraUhhTm5ZM3lJc3BqUWc5UnArbDJGcXZQUzdWQXRP?=
 =?utf-8?B?N2syOXhibS9oWHJ3WHpkR3dWVXFsNDVaVjRGckp3WHprZ2MwWC9XZ2FYMWV2?=
 =?utf-8?B?NW1zYTJoNWVWcWNhR25Md0huempJVllKaEhLbHN1c3F4QUl5V1NrN1FEa3hG?=
 =?utf-8?B?SHZEdWV5bXIwMzFDaGkxQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZTbnd6QlIzd2o3R0FrVWJ6R2tWblhnTWZ4cy9RSTlVWGl3UDVzZVBDa1lx?=
 =?utf-8?B?bmdpVG1ocTN5Q2JkdHBtUEpmb2tDMHJIYlZNOHg5QXpXV1lvRllZdElyaHEv?=
 =?utf-8?B?WXhSczVQcUlKUWNxSFdsalVDSU9rTC9Vc1VsRnM3STN3bitsclFOZytid3hE?=
 =?utf-8?B?U0orWWJ3YUNmQzR2QlA4RmJ5UFk2bG9RbUVrMDBlRXlVRTBTK28wSmdiNTFw?=
 =?utf-8?B?RUYwcW0vS1ZFQWFxaTR3QXpaY1V2NWdEaEROc041N3Y5OHlFdWI2ajhGNjlH?=
 =?utf-8?B?UUhzWWtrTGV3L1hrMmJxNGNybUpacktHa3dYbXBiQjV1L2lkYWdMalFrdVln?=
 =?utf-8?B?V01FbG4zSGVXUFdqdG5jamhhaDFaZWVzazF4YjFyakIycktBbjJaWlNIYmMr?=
 =?utf-8?B?bVJhUjBVVzdLMkpRQUw5VkpoWG41MEg5SHpqUXZkbGsyL0p5bG9Qa3k0Y3JC?=
 =?utf-8?B?RGlkYWljMUxwblJhdVNLaTNzOTFvVVpLNHRSTXNYbVJsTVBnb1hkQzdSRi94?=
 =?utf-8?B?SDZ3ZTZYNEMzSUI5WmVPUi85Q21UK0R6Mm9lUHl0YW1nSUNVZ0dqNlM2YTR5?=
 =?utf-8?B?d0drLzNvSnVQQWFuZThlY0JuNkJvdHlnOThETVBKMVl4bVUwZmVlTk94N1Vm?=
 =?utf-8?B?dlczcVoxSUFwL2FlTm9lQk5wZ1RpYUJyeWJ4azFDMGhLeWVubi93MkkxSDNk?=
 =?utf-8?B?YkdQelRhZjN3VEFrWmE5WkxlRFVkVDNQOVJ4V284WGR2MnNNSlNmM3Zac3lC?=
 =?utf-8?B?Nk5CQStTZ2lkRElNY3pid0I2N1Y5RHNCVG10c1EzSzJtU1dMZXZycTFXS0Vr?=
 =?utf-8?B?NG5OOVVRZU5LQkZtQjdnSWxnZ3k4VGY3bkZvYS9Gemcvd1RnSkR5eExMOXoz?=
 =?utf-8?B?TkFFQnN4eTZkeG5rRWhjWEg0eURpVjdubDRKT1F4RlhRTTFZZEFpcUtjWFEw?=
 =?utf-8?B?Y29zOHBIRHNGU1hYSVZWQ0xHeDZTc0hVSEJjVDNLTEczcUpHU2E1NzEwQU56?=
 =?utf-8?B?TlIvVkZVR3RTL3oxWWZzZEx6c3ZkNFpTenM0elU1dXBVdU1sakduajArTC9a?=
 =?utf-8?B?Zkw5cUJycFlvME0yWHlCbDBWektOeEFGV3hSaHFKR3V3S3czZVA3RFlOSnUz?=
 =?utf-8?B?WFhYWktEK2RVKzJWc0VtVkFjNDcvRWNiekpyZjBxTjk2VU1VbUNiaXV3Znov?=
 =?utf-8?B?SmNRdEdnNThubm0zWXViWDJlaWlPNmpxSG5FbVprcjdHbE9qT2ZNdDVXYVpj?=
 =?utf-8?B?emt2N0JEMHozS1hpcWNBYzVSR2pDM1hPdkluWXhhVHZCRHdyN3JRM1ovMVFV?=
 =?utf-8?B?S3RjZzlNVHRBOGRJVk15K2UwbVo4SS9qVElXN3hRNnEySlVpNmpWUTRnUDg4?=
 =?utf-8?B?eFdnbzBsb3lJSUF0aitDZlV5djNHRmUrbk5pdkE4dXVZR3hBK1lvL3k0eVBa?=
 =?utf-8?B?c0o4OWcxWDBjWVpvSW14aG9HL25PLzJuTWhJcDRLUVpXRTJlSnQ4ZTFtUVo5?=
 =?utf-8?B?V2VCNENkb3VzWlUwTiszTUorUGgwb3FNejg3YWZCQjJvUTVROTZPMktJQ3px?=
 =?utf-8?B?TS8wVG13YWlDYkY4d2E3ck9zN0s0aHpmb2VRK2NvTTExT1k2cjkxY3NNOTZv?=
 =?utf-8?B?blQ0Wm55RUdYcEtjUnlzQnJXb3BVV01nVEc4MmZ3M21XbWJJK3VvMDZHaU9D?=
 =?utf-8?B?VUQyZ0p2eGVRbWxDSVZwSmkzaUxRK3NRMFhkdUhDblJOT1Rzem54VTl6ZEg5?=
 =?utf-8?B?cnY1V0x2Rkcwd1NaK3YreE1RYmRvNWxYcXJvZm9lQ2V1c0RieXJKbEQ5aEdv?=
 =?utf-8?B?Q1JzeGxQTHNDbllSaDZjdjVTR1l1UUhya3lhR2ZUTjR3VHhZVzdOOXE1dEtF?=
 =?utf-8?B?dDU2bGdGN3NQRkhOVFF4bFhRNUpqZlBRWWlSL2djK1BmODRjZGQ4NzBYZ3NP?=
 =?utf-8?B?d3lMb051eERaRnNCOFgzM3lnMGhtWVhYd3A1Sk5pbHhtdDhTZm5Bb3o1cXVW?=
 =?utf-8?B?Z3UxQWJOR3AzU0txcTRqalBZODQ4SHV0R1QvUVhaQm5jSSt4RHEwWFRTbnJW?=
 =?utf-8?B?VDh4YXFDL25rOU5qUWYrWmxpQURuUk10amFlVlhDQytnTnYyaXR2ZUNrWHRy?=
 =?utf-8?B?WUc4SmlrTVZyZEJNL0lXaFh4bzZiSkhuOU1Wc1lvVHp4YzdrZEkxN2tBRnIx?=
 =?utf-8?Q?gtcly6fHOEMNwGfjfMAqbKs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3195d6d6-cbc1-4615-a520-08dc976bf81b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:15:16.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwuqg/HyMMJoh6VP2cPMNx2A9Oo6dvG2TReRPHg1HXlJGjzeWzbLowKRwvLXS8lepnQMOKq4KbQJxskMzteRfQJZRduwuv4ocT9sAnx0s1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com

On 6/27/24 16:24, Edward Cree wrote:
> On 26/06/2024 10:05, Przemek Kitszel wrote:
>> On 6/25/24 15:39, Edward Cree wrote:
>>> On 20/06/2024 07:32, Przemek Kitszel wrote:
>>>> why no error code set?
>>>
>>> Because at this point the driver *has* created the context, it's
>>>    in the hardware.  If we wanted to return failure we'd have to
>>>    call the driver again to delete it, and that would still leave
>>>    an ugly case where that call fails.
>>
>> driver is creating both HW context and ID at the same time, after
>> you call it from ethtool, eh :(
>>
>> then my only concern is why do we want to keep old context instead of
>> update? (my only and last concern for this series by now)
>> say dumb driver always says "ctx=1" because it does not now better,
>> but wants to update the context
> 
> Tbh I'm not sure there's a clear case either way, if driver is
>   screwing up we don't know why or how.  The old context could
>   still be present too for all we know.  So my preference is to
>   say "we don't know what happened, let's just not touch the
>   xarray at all".
> In any case the WARN_ON should hopefully quickly catch any
>   drivers that are hitting this, and going forward new drivers
>   using this API shouldn't get added.
> 
> If you still feel strongly this should be changed, please
>   elaborate further on the reasoning.

Thanks, it makes sense as currently in the code, works for me!
I'll review v8

