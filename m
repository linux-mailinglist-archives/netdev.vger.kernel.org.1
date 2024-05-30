Return-Path: <netdev+bounces-99548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F18D53E1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BE91F2743D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB54D8D0;
	Thu, 30 May 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na7T7t6v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FA3207;
	Thu, 30 May 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101043; cv=fail; b=TTE0soLJHXtI2ImJOJjp2V0NBFOjgc1gGNBZ1QWZ7SMujHtXLUrm82qdkIXsrCP2HE6p2rNFYnnnmA9/jKWsHNSFadKMupozDfMnIAuEEv2qGoQD8gBhJu9GQphrkNaDUAtXt6w+481YXnClr9fNRbBx2LDJeF9O8IEPKJfZKsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101043; c=relaxed/simple;
	bh=E4vgHFWVgN5Ci74FEt5hn7519abcxCVoDpuO9aCDCV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S2IsZ6iPER2BggA8Tv/PYuNh98iUTWSTnSAvuPy9f6Nchss4QrY2MMYuNP9L4fGYAgPBPoYH3SCxGTAT/pV2o0xxxAsImI7423BngBZqWd94+65SNDpvCO8ULRYdEl7OHXE1e3M2A6bRYJj8f989hWXnT6jr16R/T5RUEfqukNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na7T7t6v; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717101041; x=1748637041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E4vgHFWVgN5Ci74FEt5hn7519abcxCVoDpuO9aCDCV8=;
  b=na7T7t6vxWfCosRwrr4lPRLhOvofJBlugiMUxJhRlEZ9lLx4RlARkagi
   FNX+MDumm8cZSlF0DsffZuNiUiXS0wsQS/86Sv1HYTCgqxrck/LzOjw4Y
   6I787U+jIoGqAQrucOP0r0azFazTD7zrfa86399pyUqWPEk2v2KezorUp
   30rmZnAaUpuWl9Lmr8Tg3V/WFESqEBxcxtz+8t5xXXLh+g1vCBkUnYkvV
   dnnPW6xoJFJSVVxLNRarf/G6iArBOHoEgi+FbzmfsprYFCxUOxQH3gNEP
   Aub41EC4wljeVljfsM6GFibDcZ3pcEa3CWdJou2owZ744qT3VNuEcIydE
   g==;
X-CSE-ConnectionGUID: A3TgDfq7TJmSCnSbtyKx/w==
X-CSE-MsgGUID: h7mbyVhSTYqHrCyyQG9aXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13745765"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13745765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 13:30:40 -0700
X-CSE-ConnectionGUID: uT+j650TSq+euQSwJBT2SA==
X-CSE-MsgGUID: mUL0DYx+SAiFg5++xE57vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36437018"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 13:30:38 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 13:30:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 13:30:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 13:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3EexfEt+ApqfZaD0ODBDHdrqyaz0fotkjAJNib+krpSUjtjt5MAWp9CS2h22Rp7qOoOUnS4D3APykwiMr7VP8XrvwrjB9or6FHcy2FVxXbpdyyHELY02Ga41ea5py01vhHgdVoONbUoLSX+0I5NL0FR3XdcpjHL3l1cwoYkYMJsx+MMkVGss71w4Og3EUA90jMpSCg2kBFrJt3MPNDOYQZNE1c6SJd8qyNtQvHlJ8GEtAGQKQr7Zxn3Pq/NTs9/Qh0W3erJSe92RR6X8ZFHZisL0iZ9ZuLbNdy+XELezoL7F6ZmZWSUNLggw6wxEW7uTk4ztEnGsDODudwNtYl4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhlwlJraD2DXQNDc5EsUdEHwMPbQkf3wpE8TGSZG3LU=;
 b=eLR+3nkRVfyGuyYNWD7j6F3eVHuZgK+b0rOw71pMBxDQl66LXj9swa+FgzpOxzveLQKPmrLxkqrLXbxa03lSHbNEWxplqYymka6gVgYHKNCt5CvzsRyvOVMIawixyXMF5kTeRJqk5fxhZ6DrNYI79bSUC3bTOTS52iAX1TnjxuNQ+tkMekz3iR0I8Fid+lMoNCo0zfYzOI1rFDdTAxLR5LQPzwNAat20orOTnGeFJW4o09nga3eyn3do2CAVxU9QByFik5ZzS4V8MuNHqqJUcw4YyP2aBPHPH/KX84GfM6GINUm20zFaVOpK/S/2cJdlw//0YF9zsyt9pfVo2Zo0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 20:30:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 20:30:29 +0000
Message-ID: <b4bcd52c-ba0b-46b2-b302-fb412542328b@intel.com>
Date: Thu, 30 May 2024 13:30:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ethernet: octeontx2: avoid linking objects into multiple
 modules
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, "Sunil
 Goutham" <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Suman Ghosh
	<sumang@marvell.com>, Simon Horman <horms@kernel.org>, Anthony L Nguyen
	<anthony.l.nguyen@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Mateusz
 Polchlopek" <mateusz.polchlopek@intel.com>, Netdev <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240528152527.2148092-1-arnd@kernel.org>
 <2f1603fa-d03c-412c-895c-bc4afa06834b@intel.com>
 <866cb878-47fa-4bb9-ba93-6a0c0e70a4f7@app.fastmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <866cb878-47fa-4bb9-ba93-6a0c0e70a4f7@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: b4883ff1-63bb-4fd6-f970-08dc80e75880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWozcHVTdGlZanRIa0ZsZVRXbldpeWVQTEJXcUdTNmdqaWJ5bkFHd0U0SXFC?=
 =?utf-8?B?YVNJNTFHY1pvQm5MM3lkdUwrNXUyQ05GRWUxUVRScnFhZGZkYjk1SC9Zem9z?=
 =?utf-8?B?M1p5YXhkYlg0RGxHNHV6cHh0WGN4YTg4aWR3TTJRMVlRZVlLdTRSVXZwRkNx?=
 =?utf-8?B?YnhDY2VNRWhVNjQyN0hxSHM2cG45ZEF2L3hhMW52YWJaWmNOaDdXV3VxQ014?=
 =?utf-8?B?SER1NXpxSEJVNnk0dUxQQ3VsOVdLd0VVV0FNa0EvODAzdEQvQ3VtbWtidmd3?=
 =?utf-8?B?ZVRQUjg4amszbXNCZ292dmlrKzdEQlpJR0NwWG9nZDdIUitoSHZLWldqcW5K?=
 =?utf-8?B?WHl4aDYrNzhidHI2KzZWT25mZlBrZWczRjV6Zy9keEZ2c0tzazd2K3ViYzlp?=
 =?utf-8?B?eDFaOGNqZi8rcUNaUVo4OWNpajhmQ2lRWlhmYzNsZzJYWG9ET1ZMYnpCY3hM?=
 =?utf-8?B?SGRJanltM3JXNndYcEFZcEdZdmo1MnJIZUd3ODlkOGlvOEROYUZ3TDYwSXpr?=
 =?utf-8?B?ZVZDdjQydTg1clMxdFdMa1cvSUt3alMzZ1NGaVdrRHVDaU9OeWs2ZWYwU1R0?=
 =?utf-8?B?a25HaExtalkzeHBpcktiRWNENmx4T2NvWm95K2ZOMzhFeURPR20wcDJjNFVG?=
 =?utf-8?B?dmJ4RHBTbG9Ocjkva2V1MDdFZmhCNUJ0SkRkWTEzUndXem9CT3V4L2JrdGJE?=
 =?utf-8?B?N0RpSlNKOGVHdVY0c0lwUlFKR2E5Vm16bGs4cVEwVkZ4OThnRElQR1h6NStS?=
 =?utf-8?B?ckxtUXRQakl2QWRBdGpNUVprdzJjem4yZjRYSnI4VUZZL1U3S3B2d3lTbThP?=
 =?utf-8?B?UDBhd0JTaCtGdW1tMnVldTZKOFRKdk5VL2JERUJlNm5IWGNJS0Y0N01RcmUy?=
 =?utf-8?B?ZUg4d3YxcnJDbS9KR2hoRXBtckRpSDR0ZEFZVVdqT3dIUE03ZXJZWGRlZFBp?=
 =?utf-8?B?blVPbGRIOVl4cktlck5kZkNROHhJU1hMUkN3U2I4NmRoNncyZ2YreGNlRTR0?=
 =?utf-8?B?ckRBUWtrSnhwWWRoNGRpczN6K3NsV0VJLyswTFpkdVRQbXdmdm9aRzhkeUZP?=
 =?utf-8?B?RmVwNDR0b3BoWTZXbkpyeXhvUWxlOU9aVy9jcU9aWFgwWlBJVTF0UEFVU0Rm?=
 =?utf-8?B?eDUrS3NuKzVZckZTUG5mbDRSTzNleEx3bmtOWWhGT3JuT3lDSXRJRVRuMW4r?=
 =?utf-8?B?S1EwcmIyRVM3T0VTMHJOVnpGVHhuTEtZOEdGQ1lnRFBUVkNJWnAxTm9Lai9n?=
 =?utf-8?B?bUc0djF1S2dnZkg4aUdsZVVENnYvSGpzMDhjbm5nb3hPZVE3WGRrc2hXM1Mv?=
 =?utf-8?B?OHQ1M1pSTGtRRE5FdDJhVE9TVVlUL2FNSlZwZWRtcC9Ndlc0eWlhbG5JSzRH?=
 =?utf-8?B?aHR5Sk9UWXJWc0NsQzYwd1d5elFTRVN1cEpMUnJ5YUc2YzZtZ0RKK0dVZ1d5?=
 =?utf-8?B?cHBqam1jRUwwM3ppek5kY2QrZzZTUzdVbUd6TGJNTUR4RFRBeS9PM0hHalJr?=
 =?utf-8?B?NEZBUGlwSndtQ1YwZzF3eEE3anlrOWR2K2UvamZpWTljcHRINzZFdHRnb0xw?=
 =?utf-8?B?c1NWa0VqallXU1BhVmw2R3FwRCtwbnZJdEFCMmxWMHlQNWpnQWE3NDNUb2JT?=
 =?utf-8?B?cE52N0ZYQkdpS0c5UmxIODFONFNuL0ZqM01hejV6aDRJWkU3LzJTeGNGU0J6?=
 =?utf-8?B?N2IzUW5WUFVGQkorR1Nnck00WkdyK1NHeTZFNFl3NWlzZGxhSHdWTUlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlYrRWRYRUQrNHQvbnBGazdFb05hd1ptNjR0Q1RpRHl2OFpwa005TUZ4Zlp3?=
 =?utf-8?B?emYrZFFqUWFSVVM0d1J5TXVzUUE1YWMrK25hR3BQNTQ0R2F0QXFOTnNEaTU3?=
 =?utf-8?B?ZlVIT3lsRlNuQ3dZeVJPQnlib3NiUW05cGpieGh1ZEN4RFBUVmUzWjQ3NVNN?=
 =?utf-8?B?QTlmY3VvUFlyT0FPcHhZeS9uZkdKWkxrZkJVUVAxRDZKN0pITXp6cGlYNU1i?=
 =?utf-8?B?bGVrdlZGNkhJSXpCWE9mT2N6bEJ5SWRMWmdURE1QdDBlREprdDRkelhQRExn?=
 =?utf-8?B?OVdVSlpMME5qd09ucVVRcEQwOXgyT3kzTXl2Q3EzWUJDS2o4cnNhemFhWFQ4?=
 =?utf-8?B?ZCtVNFg5YkxvQm4rWm1vTmZPS3JmMnUyb0VyQjFlUUdJTVV0ZkVnZW5GNHp1?=
 =?utf-8?B?aExSUWEvZi9LS0Q3WnpmU0FVL0x5QktGR1pmY05tZVppY2UvZnh0M2JOMGhq?=
 =?utf-8?B?eXBkYUVVVktiU2xlcjN6VFdkMldKU2pxZ3FwNTMyUXozTkpmN1JSYmM5MXpG?=
 =?utf-8?B?R250anpYcWN5blVKTjZXbHIzTUtUWHltTzRqc0UrK1hsM21iQ2h6VW5hZ2RY?=
 =?utf-8?B?UE45cmhuRlBFVnVMVjBCdHRjdWo5ejdvQ01Cbk14T1gva3M0QmhlZFVHc0s1?=
 =?utf-8?B?aTBIR3QrREpXZktMZGVOS1l3U05ObW9uU0xKb2hSdHl5b3duaVJHU0J2Q2tJ?=
 =?utf-8?B?NVBsbkdUY3VLd05XdW5HWmpncEFibG1GOGRzd2pyV0JCSjJqblJuVFJGcDFX?=
 =?utf-8?B?UDcvWWgwRDl1VGRYbjVYQm0yRFRadkZxdXEvWVk4WmwxZkJmRDhpNDJKQ1FV?=
 =?utf-8?B?ZGZ1YS8wdWNQcmhiTGNpNjJoSHJZeXhBSm10WVBGRk9Da3E3ZzVlN2QyOE40?=
 =?utf-8?B?SWJlVjZGQURXaXVQcmk2RWxVVjN6Q3JKR09RNTRiSmFDQ21kM2Z6Y2didE5l?=
 =?utf-8?B?MlZYOGVkRGtXZnRRM3A4ZXVwdjcwbW1VZEgrczNacTBZK3kzQmczMGNMZlRa?=
 =?utf-8?B?SVdzeHMwZWRzWnVsMWVPcXlmaHVvWDZMdWRxVkR4NmtYeUZTYkxIVHNBdDJ6?=
 =?utf-8?B?bWVKOGpRNU1hZG1EbENvamVMUDNTNFI5MVAyRUdIcTdBeTl0MFUzUkkreVB0?=
 =?utf-8?B?di84cFZYcXJtejAxNU5idTNHSzBGN3VBZmhvU09UblZRRlBuWCtaUThGTDdF?=
 =?utf-8?B?ZVhQQ05Xa1lReUpWRXJnSzc0cFRhSE9TVUdLRHE5RXVWRG05ZUVzNWFpQUpi?=
 =?utf-8?B?ZGJ6WFJGMEE3UHV6OUQxMzEvMzBpeWgvMjFpWXlQSkdVdHJqa0ZBeEVDVi9D?=
 =?utf-8?B?SG9uL05JaXF0L1l4UGd1Szl2eCtaMW9MOHhPY1FEMTJQeXVYRjVTcWNuWVdQ?=
 =?utf-8?B?clIvZXBvRUY2ckJYeSsvTk5mU01lUFBnT2xsbzBBSzI1cXdNVldMWVRlNTRT?=
 =?utf-8?B?UEhKdEdQNEtiQ2ZCUmhSa2FkcG1SaE5Day9xVHVRTWdocmlMTDBaVVVkUEFE?=
 =?utf-8?B?bkI1M3RkOHBKazdHRU1VektUQWFLdHJMeTRDajlMczhvL3BPeS9ieXMydlNL?=
 =?utf-8?B?M1pwWDBmR3hnVmo1ZW1FSE5uamk4amE1K1hwZVprbDBoMldBYmlrRElqT29H?=
 =?utf-8?B?a3pxT1pIVUdSQXNLVVZqeDBRNStWYUhEdzZ6RzBnVWNDMTdUODFSbmxCVnIx?=
 =?utf-8?B?QU9xS0h5TjkxQkpBQlgrT3JUNE93TXZ6Q0Y0bzN4cHFKbnVaVmNUWE5BSDhr?=
 =?utf-8?B?Tjk1Q0JFTEg5SWR3Ty95RkJRazF0UmM3V3FMeW9mcWRFUHg0UEo3aThTcmV2?=
 =?utf-8?B?ZzhCSXVmSmd1dHJFWFBuVWdRK2pBY0dUQ1M4TzdMWUVVL3BZaXpxSHVZTm1L?=
 =?utf-8?B?Yi9pM2dlWVZBWVdKcHozVEQrOGt5MlNOK2ZJYlJTRUdST2hmbnlXSG9hMXlK?=
 =?utf-8?B?ZjFzSS9rM01mN1FSWlQ5TTV1a0x1ZHNORElpU25YcXlRbXFDV0M1cXBwT1Bx?=
 =?utf-8?B?SWZEQVVneWJlQjYrVTQ2VGJHblpjaUhSRTk1OXpKUW5sdDlieEQ2cWJSWkl4?=
 =?utf-8?B?VVBPRFZYWHQreE14Q3E1dGFlcXUzVXNabUhjUGxsR21ha0ZLK1hJV09WRVc3?=
 =?utf-8?B?OVBwVGxzbFdxSFI4Y0tad2xJbUZwZkUvNVlhUGJXby9NeTEwNVdlRGJNMGp2?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4883ff1-63bb-4fd6-f970-08dc80e75880
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:30:29.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPJFTsV52oFJPq67BS9/AYkndEdLx7o1XDSsyi1lGDLmhp+vO6pFypIefM0LmXycdT6cxbTERFrrf6NeKoY6wnAw7n6S6uWXruOjaccZTAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
X-OriginatorOrg: intel.com



On 5/30/2024 11:52 AM, Arnd Bergmann wrote:
> On Thu, May 30, 2024, at 19:54, Jacob Keller wrote:
>> On 5/28/2024 8:25 AM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Each object file contains information about which module it gets linked
>>> into, so linking the same file into multiple modules now causes a warning:
>>>
>>> scripts/Makefile.build:254: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
>>>
>>
>> When I tried to build, I don't see any warnings produced on the current
>> net-next with W=1. Is this something new and not yet in net-next tree?
>> If not, how do I enable this warning in my local build?
> 
> The warning has been around with W=1 for over a year now, it still
> shows up here:
> 
> make ARCH=arm64 allmodconfig drivers/net/ethernet/marvell/octeontx2/ -skj20
> scripts/Makefile.build:236: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_devlink.o is added to multiple modules: rvu_nicpf rvu_nicvf
> scripts/Makefile.build:236: drivers/net/ethernet/marvell/octeontx2/nic/Makefile: otx2_dcbnl.o is added to multiple modules: rvu_nicpf rvu_nicvf
> 
> 
>     Arnd

Hmm. Ah yep, I must have missed W=1. I thought I had it enabled. Doing a
clean rebuild with it, I do see the warnings.

Thanks,
Jake

