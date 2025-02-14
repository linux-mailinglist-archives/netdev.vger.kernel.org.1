Return-Path: <netdev+bounces-166355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C1A35A39
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287FB16F3F5
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54396230996;
	Fri, 14 Feb 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTKIG/UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5C1E502
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525126; cv=fail; b=iNFWvyknwkKAEeco/sKSGCSd/umlWVH/kYxe8ve6QnwbLxwKvamzn3H+Y1dzBDJrBJCJuAobh2SXxKPVoqCqPysSrFronN2kBZxB4x3BCcbQgvj22a9CUGXlH+fwjQxJfKOVLQwo2EA+Dwn97fPtO/xmjxor3iCMMdtTPORphvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525126; c=relaxed/simple;
	bh=WLCTGn8Ht0WHcWGaS0UAfVUUri2Jx3mZJquFlhmHcbc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CeKsJeFFMlfer7VgLBr7rsktWESq493nhOo4Nu8BBAIx9VuTCKLIeLfqKAZjshch3QHuEI9uuC/ZjcoHfZszbVEdxx5md0L7rVVgom58W7PyUg4/IEu18GEdqle5BtmeIFm2CfLuFeePbpvM46i98tKJ+eh8NaRdXShLYSAB8bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTKIG/UJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739525124; x=1771061124;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLCTGn8Ht0WHcWGaS0UAfVUUri2Jx3mZJquFlhmHcbc=;
  b=aTKIG/UJV8FQLXT4UVp7x5480yf5KxppDIDkSdRo8TrTJwSJFWYIC1wj
   z0fSWzNpk8+zmRcnMOb6fyKJ9/0b1v1bITtEraSXbYdr8TWET/JstQktW
   +N2UG2+k0ROh/l8LTz/Js/5z3iizzn1YLJcrX+6npylwwPuAgQr9+jR3h
   55378CbXfscAGDVcFr37KEDrgj6zEAmUXACuAlo9koobcKZMuFzpO1Yyt
   aeW1nGdy17+tjcZacqv2slVm0F4q8rG6HouMu//thYwma8HR0iZM9eaAo
   5dMi03mRIO5ofx0F2oiBE1lYwGuWDRhUkBbg1wJn0mBY7LnTGDDtWJc1s
   Q==;
X-CSE-ConnectionGUID: B1QSaky4QHuoNcep23uZqQ==
X-CSE-MsgGUID: JZooGvQoS76BBCkm4Lip7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40527811"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="40527811"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:25:23 -0800
X-CSE-ConnectionGUID: jzlOyBkHSViUH0FfIPHBMw==
X-CSE-MsgGUID: qmz2bhdZRmamlJwXWXVfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150586366"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:25:23 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Feb 2025 01:25:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 01:25:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 01:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj5MddajURRvk2ezRDVWVc+qQ24u2Tc/Kz3umnu79fO8Ae6PPyT3tSIHSARiRjLY9KOqIw8lty3iMc8CeIwHbRG8sAkIk1SDRk82RrqVA4SYEMs4GZyyLqOLmQO0vZ9nGnAsgjqdsCpUV6ZFUhv3L7b9tFFzQhxqR/MX9dVhnP8v3QKQZi4ymnlZEjWm7ylKAvuWeTEChDKlcmDrpStsEyzyhGh4QJvBxl156S5xAygbJzmil1atXKPicdvTQfgh4Dv5FJw9QnYSO0LUTupGkxwU1T9QvVaTyrm+IdGSy9WhLrgoJvIyr5qjmeEmfg1qPEwK8AZT94DQlHnxQjbHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyVKI5J8jjQdoR7r/QKuhtRJR6eP7R8guaAr9S/T7Qg=;
 b=BbTOP0AijP7M1UgUvtHWfXrRjqN3O/p02pV0LY3wCYFGW2kA9nU8ogVCOqkuw87cjBmBA8p8+KLmpSNXgJDViMkif1eY7F0LPVF3bUcQOjVWSmD/nRQrj1xgnlefyreEz972iS7UdkjVaaywFIc0T5MdxNrAlT+rzop6+s+4MAkK1/3RGVHhXyPsfIXPDxkE9THwDK6/I+TLumCMT8KuP29Pk2cIviPL8FK0sBhlwArUCEtu0yfeCy77a9D8p/y6eIc6hkZEJ43LuY2Ug8q9UG/ozvII8i1G9rhc6BgJpnaSlbm9UauU1ZvbfcyI9uxb2aKDGl8A7g4a5eFxkiEioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 09:24:53 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 09:24:53 +0000
Message-ID: <c25c5efe-6835-44fb-9937-87bf25368a97@intel.com>
Date: Fri, 14 Feb 2025 10:24:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] checkpatch: Discourage a new use of
 rtnl_lock() variants.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
References: <20250214045414.56291-1-kuniyu@amazon.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250214045414.56291-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0019.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::16) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c8f5c4-4b04-4127-aaef-08dd4cd97005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1JpZE5GNjRsKzlQd2k1SkFieGRic1hWd0xWZDJCTk80V0NPanlCTGVNbEY2?=
 =?utf-8?B?dURrKy91dmE2NC8yRHVEVGhRRkNsT0lRcmdIeWpBMjB5L1BVRlIzMXNhTTJV?=
 =?utf-8?B?a2FvcXBYVklja1hUTlhGRjB3VGQyV1k0dnlBVEhlNnBBektyTmFiMHBhamdp?=
 =?utf-8?B?eG9nZUd5Kytsd1NmalFYWXJReE4wbnJjN0Q5Q1Ywd3VDZWo0dElDL3VvZmxx?=
 =?utf-8?B?c2owUis5STNBUXluS25KTzY3bGREK1g2TXhjenozTmZvOWNhTW9JUk9vbGc2?=
 =?utf-8?B?RWRlOEk5WEF0c0YrblkvZC8yVUN5dldIczllQzRnVlJhYzNiVStydDFycHp6?=
 =?utf-8?B?YWMvL2dZem9HOFJST1ZES01oRUl3aDlxaG43UUlNa1lhbW5XUlQvWWRnYXRh?=
 =?utf-8?B?OGxQNnJuK01lOWU3MmhpZU9YWExhb0VqZ2dOSmR0VWROWThyZmNXY0dETDRp?=
 =?utf-8?B?NG5vU0VZUGNWSVgyTHFsVGoxQkdhdGxCQTE4ajBhU3lyazlwWlRFNGwvN0U4?=
 =?utf-8?B?MkJSUjNEOHorSDZ2MU1MbDdVMUhINkJ0ZVIrQm10OWg5UVNRc0duVzhPQk40?=
 =?utf-8?B?MzVRME0rZWZFMTZpeWcxcmxaNXI3SVRLbnNrRG1FRkdXVnlmbFlzbFgwQWli?=
 =?utf-8?B?WmVOSzBzOUx4OThOTER4NkJPZG9PR0hkWi9uNHZERFY4Mlh4aWoyVnlnZ2J5?=
 =?utf-8?B?ODlJcVF5MXgxZGxDNjJlN0ZTa0JJVVJzRGhHMkY0a3VuUU1BSTNuK0FKMUtU?=
 =?utf-8?B?OStEQmVhT2g3VjlvYUY4R1ZnenlscTRuLzhOTkpzRWluMm1DLzJBSS9ZaERw?=
 =?utf-8?B?MTYzT1FoTndXK1BwZjZoOWs5NTliQitNdXhSSmxCYXViOGEyRlZXbStsRm9v?=
 =?utf-8?B?QTJWY05abzRlNkRldHFXeEtEUi91VGZtZVIxa2V4L0w5SEdnaUNTbGlUMFht?=
 =?utf-8?B?R0hyUi82c3ByMjFHakFSY3FxMDJoTUpsSWVSeGI1bURRb2hTcWpUWFhUd0lv?=
 =?utf-8?B?QkNPbzcyU3ZRY2VGNm5rUTYxYXpqaTNsQTFiRnlLYjZwQVBHMStmdkEzUkp6?=
 =?utf-8?B?bzNWaGVQdFBSUGxWaHRsd1ZIeEpBR09wdGJRTWRkMjhQcklYRXhzNTNJc1dt?=
 =?utf-8?B?Y1ZYbDRQbm9CUUNJQlRWZ1hhMFpJL2ZBYjA1VlcxdHQyVk8yUkNpQVV2R2Q1?=
 =?utf-8?B?NS9KYUlwSGsxd2cvdEFWeGxQTWhwZmNoV0ZTbGIzV0hQZUVwRktzWFBZV1BX?=
 =?utf-8?B?bmtXaytrWnIxZkdNV3VGRGgyU0VPcFliR3lpdkhHZTVaT1BHK1V0andJVUU5?=
 =?utf-8?B?WTF2UW9IOEdZS0lDMXpVcStrN2kxMlJhOTd4TGJnb1lOSFpobVR2OHBGbzJW?=
 =?utf-8?B?QTdIZGsvVTRQWUdtTExpK1BTcFhnekFuemJSTWVvYmVIamc1V2NOQ3B0WlQw?=
 =?utf-8?B?NTV6ZzR6MGxGVkp2UEtxckRpVzZhVVhJaEpvcHNUNkNNc2Myc2tySlg3cElw?=
 =?utf-8?B?cGRpdGRkWWxZeFVoUWQzSXE4aE40cGNHNldIakVjMktPNHpoSHRzTys5NVEv?=
 =?utf-8?B?Rkp5Y2ZsTSttUGJNV0J4d1RzZHoxSW40TnEwb1AybnkwRXBSSjVjMHluOUEz?=
 =?utf-8?B?VkMvNC9vM2JlVzViaDlBTTlTSHR3Q2llRkVoZm9tRVFVMGNmQjRMNDc3cXFs?=
 =?utf-8?B?V0lISVRjQ2E3MDY3UUw1dmlxQ283YUpLN3Nxa0ZKRjFab3d6dk1nLzRWWDJS?=
 =?utf-8?B?NHVBTGh0aXFqZnc4TDFXOWZyODRaUnBFbDdZZUVJNUcweldOc01XYUlOWWJp?=
 =?utf-8?B?MHlBdTBKRTRHemVZanMwNlR4eVlLTmVzdTdGSWg0Z1hJUGlvdmlkOHpaWVl6?=
 =?utf-8?Q?Er18sDX4qmM2u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpPOVdqT3hWS3UvUkFlaUszZlZROU9UU0QxRXpUWHVGclFQWld6WTQ2SUl4?=
 =?utf-8?B?OTFMT0hoanY5ZzFYVWcyaGFCcUJlemFlVU8xNmZZcndRdGJpRXRwU2tEZEE0?=
 =?utf-8?B?N216KzFlbjhtemhsdDg2clFTU0R0cmsrdjhjSHc4amNaeHlVd0IzalNxcGhI?=
 =?utf-8?B?SWRQUXdHOWtaVlYzR2ZraDFCblViVlhMY054NGRoUnlVOVY4NXF4U2N2d2d3?=
 =?utf-8?B?eDFWVDNQcFVQOUh2K0pIZUU3bHlSNXR2aEFaZEdOTXM5RjhXMVRubUR6TjVF?=
 =?utf-8?B?Yjg2SnROVFc5UHpibTEzdjg4NmJLSkFDTXpTMDEzVUhNU2w4VU1YcVJBL21v?=
 =?utf-8?B?ajk2VENvZnN2Y1NmVGpzTFkxemV3YUQ1YldSSVZldHVNYTdFd1hKMjJyaDZt?=
 =?utf-8?B?K05YZ0wvV01MQWxYU2pNU21GcThxV0FySi9wNTRVN0hvdGl4STNTY3I5bndW?=
 =?utf-8?B?dXk5aW0vQmZaMmRSUkxyTkt1RU9oT3lFdW9lb2tYUy9uR0NEckx6Wm5zNGNx?=
 =?utf-8?B?ckRzV3ROQnBmK1NxcVRPSXRoWWFmU0NUTjFUakp4WmlQMCtRc0VRam5SQzd5?=
 =?utf-8?B?UUVabTJ6VTI2TStXcnNqb1B4S3dhcFlwbXFDTTYzQ1RpS09rWHpVNkI4a2s4?=
 =?utf-8?B?MW40bWUwcmM5ZXpNZU1uaVAvN3ViVDlxSkR3NmxmRGs2SU9pNjNCSEtzWkFj?=
 =?utf-8?B?Y2E5T0tYY1o1RUVzUWpQc0Y0UkcxQjZYTEVPM3BnenlFU04yeW8rR29uZnJN?=
 =?utf-8?B?VllhYTNrVmtUbWtMNW5IdnpMeTQ5R25lb1BMazRPa3piN0RYMUxldFpUOTVa?=
 =?utf-8?B?NG5PUmo0RitEQU1rK3VLb05GYS9iRytsMW53UDR4aWZzM2NRWWlBYUdRbEFj?=
 =?utf-8?B?WU9WNWdHY0VhS2Z4bGpNeHpHOW5XbHVXRyt2cHNzSERjZWdXSnRwdWNIZDN3?=
 =?utf-8?B?U3ZocWJ1NTVUUWJtRk42Zi84amlSeHQ4ZnZYYW1uYi9sR1ErVTlMNTdZeHJa?=
 =?utf-8?B?ZHcweXJrZWRlN0Ewa2EwK0ZoSFBLc1hsQ0x5KzhhQzJtOFpnVHBhMm5xd1Q5?=
 =?utf-8?B?V1BXL3dYNzExY0pudTIyQXhxTndOZnpQTS85cU85ZEVWYWpqRVNpQUVTRDEw?=
 =?utf-8?B?N2M3ZW0wVHJJUlRLbXI1cmNoanpBNDZPZXJubGdmc3FRdW9iQXFrclBVdndS?=
 =?utf-8?B?M1NkNkpRbEZ5d0owTFhQd2Y4NEtXWnJ0RTdXMmdOMGFnUWljVXdBK21jYUtP?=
 =?utf-8?B?cGhGQ0h4eHdJdHlFamh6QkxJeThDRTEyOEdISkhWYnByVnY0TDFyQjU1dG5O?=
 =?utf-8?B?OVY5dlNrOElaa05lSVgrYldxcnI0bVdRLzNUR2daSnVnWU90Nkx5dHFvODFi?=
 =?utf-8?B?M0dpNHRrZGNJL1BDZEovMUVUQzRGRk5aNDZVNHBtUktUQXJtK09jR05tTFAx?=
 =?utf-8?B?Tk9LemI2S1R0WCtncWlJa0Y1cis1Znk3NmRuYXpldkQ0WWY1QzlmajIxRTJN?=
 =?utf-8?B?T0pSM2k2QWVXTDFzUEo1eEJKL2gvT0F0YXBaMnY1UmFGM3FnZlZ3alJIbVJR?=
 =?utf-8?B?WWgwL1VRR05PTExqSHpLUU95V29VK1NaNXVCZU1ZZGhOZVcyeGQ3WjY2Q1dp?=
 =?utf-8?B?cUNuUWlSRHJGVk5BeklEenhzRDJoSDFNaUZBdk9vTmFubUxvUDZpajc3bE80?=
 =?utf-8?B?UE5vUW1CSWRmSXI3aUVJMUNoNlZab0NFYldLR2o3OGZmSEV6WDJmTG9KL3FQ?=
 =?utf-8?B?KzlPbzVBVEhMWjUrZkcrbFhVeEw1dmZaOEFiQXpIVXdPVzRPeVhldklJMUdr?=
 =?utf-8?B?TlJyTHR4alc2SWtiaTl0OEw0cXAyVngrL0VJY2dzTnRwZThGcWVZWHN1cFlj?=
 =?utf-8?B?Zkd3V1huU01VWnk4TGRBem9ZZ1BIcWNncEhxb2hOTGUzWHY1ZGRVV1VXbmZF?=
 =?utf-8?B?K0hjaUE4RGJyL1BONVlNdUFMbjhjVy9jM3Z6MTRqL0dlcllWMWFKRE1lTE4x?=
 =?utf-8?B?TTFCTE5zc3ZFU3JKUVFaaG85blNrcThKN0xmTE1VdysvVFRxMm9nbHB1Y0lK?=
 =?utf-8?B?bDRUMXFGck05ME1ITTVGRFVDc3lwekxOY1JZQ2U5aWUxWlpzTDBKeTZrOXRk?=
 =?utf-8?B?UjA0VWRvL2gyTmp2M0lZRFhUUVVtU2dGNjF6d0E4cW1SZFNkVnN2N1ltMmtM?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c8f5c4-4b04-4127-aaef-08dd4cd97005
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:24:53.0088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Gtezknvs23uBoPOSGH9nuONZzQr19iur5DJIlSzBXcJSGea4+Jp2sPWDROByQXF38DNQXCAGhW5jgld0QtDTy34xMNN9InDDgKJgg2UkXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
X-OriginatorOrg: intel.com



On 2/14/2025 5:54 AM, Kuniyuki Iwashima wrote:
> rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
> 
> Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> very large, in-progress, effort to make the RTNL lock scope per
> network namespace.
> 
> However, there are still some patches that newly use rtnl_lock(),
> which is now discouraged, and we need to revisit it later.
> 
> Let's warn about the case by checkpatch.
> 
> The target functions are as follows:
> 
>    * rtnl_lock()
>    * rtnl_trylock()
>    * rtnl_lock_interruptible()
>    * rtnl_lock_killable()
> 
> and the warning will be like:
> 
>    WARNING: A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants
>    #18: FILE: net/core/rtnetlink.c:79:
>    +	rtnl_lock();
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> v2:
>    * Remove unnecessary "^\+.*"
>    * Match "rtnl_lock	 ()"
> 
> v1: https://lore.kernel.org/netdev/20250211070447.25001-1-kuniyu@amazon.com/
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..eca4f082ac3f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6995,6 +6995,12 @@ sub process {
>   #			}
>   #		}
>   
> +# A new use of rtnl_lock() is discouraged as it's being converted to rtnl_net_lock(net).
> +		if ($line =~ /\brtnl_(try)?lock(_interruptible|_killable)?\s*\(\)/) {
> +			WARN("rtnl_lock()",
> +			     "A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants\n" . $herecurr);
> +		}
> +
>   # strcpy uses that should likely be strscpy
>   		if ($line =~ /\bstrcpy\s*\(/) {
>   			WARN("STRCPY",

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

