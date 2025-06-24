Return-Path: <netdev+bounces-200869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94798AE7257
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D8F17C61B
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16B25B30C;
	Tue, 24 Jun 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo6aUipN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EA2586FE
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804487; cv=fail; b=UDO60vl+2k65KASl1gXyqMC2fiD4ImeQylZzTkOd0fY9d2Ovtv4BUgHUlUOXy3JWklczxfbDx6AueGZJOPybbLXmQWbBT5Tb6rgsfCHq5jLHTITJSn/k+7ZobKAHh78pXx1q4rCiGvhWCUcxQcpw3osPkIgxcpFUbtkatD/CL6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804487; c=relaxed/simple;
	bh=XcFa40ZHxCCjOz91+BBVdV5HJ286TvFcc5uEcLdp5YA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KH9D+wF2dU1Z8rvH6dM7PNjrnOduOnwJ3YtC785+pjq+/3HIgKLU8hT9t1+7SUQL29xYsXWXbxA1HikmcuK8KDdtt4OVQatCw1RphcNFuRU6Z7+ZitADF72J6mrCaseW7VNx7N7LM5GZQcLvxj+AsSjANdHHNeQpYEpvAj5hXvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo6aUipN; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750804485; x=1782340485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XcFa40ZHxCCjOz91+BBVdV5HJ286TvFcc5uEcLdp5YA=;
  b=Qo6aUipNS3nb8XKAF65wCAxIfGGeYw19wbKpfubPZbvvT0OQV6n8Z3Uh
   fNshr3xBk4H+0FpwHYJIcUj/m66JcKl3CCtwXm6rE16xY/kWReF9EEUB6
   Qd5PTuOqYLGKdZOtCj327MkVtQk5Xaq1PBv6Kk/FxCNO7pNDNneSXWUdl
   B+aRNDsAdAMKR6GEGoaPtWYYfHYkiskL0XyZwuLL8ZTMHFwDqbmpVLlPB
   24JDecQFfIZiTo+mQePI5sX29Jprh2xi10wxlIuCJMV6D62ax7PL84sOr
   DibXMDXi3hwrxZXnXB/2G397PThA+a/I/bi+/nR/znz3UBa+tHm5agj16
   A==;
X-CSE-ConnectionGUID: ooaM0AtQRaqgDvAZfP9/PQ==
X-CSE-MsgGUID: MT/uZklKRNSCRi4cWKrg5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="78483842"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="78483842"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:34:45 -0700
X-CSE-ConnectionGUID: l9ZYjWdaQJiv5dKA2mUwmQ==
X-CSE-MsgGUID: 6CyR8XYARUa1dqL0xRuBrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="152563812"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 15:34:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 15:34:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 15:34:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 15:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2PKLb045Ay3UvQnuHYZkGIfz5UDQ70YMb4xoSGIdPn11lmSpJRb66E4P3OzbSrZQhbhVV3+xdUEmTijv884FVGoRe6zOLCBef/BqOIDEzNAt34ZMq5iYwHVGAyv4BLg9LDQjhUmbw4YewDh3nhBwkcqeBVSogT/cTMvdPtnSmFR47XbnzH4V7aob+Qk75rYTdGZGuidHNUpop/YyskqWW+qTOb6lEH9sPjp/MXmgdvBv/1dmtcds/ilTPlQLkWf/DlwDSpPMaG9+U8DJbiWnvIXcEioF94bobPNOTkKo6Z7dmZ7BJzN+ZhAQrhF6aY6PsNQDNS7A4S86kso6J+zYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFBc0q8OdMr05kJK2b2HEX790UB5+Ps4ii5y3pxuJ1k=;
 b=h0zMTo48jTMp5fuzC9a82UNH7GsvNI1mQFjNfCbdh4T/wTz7TxVwoQTZ+TnA7CzWtdfrUEf7FW+8ekU6Y8CAUuGH0ChnmYOvvCfVdMkkO7dMRfXyA7S5j4qWKUaQnXtRXVkutnWGKZ8kopnk4en2eqHJ7sNLIdpty/FRb0g/pdxxMedlUGaw0Uop+2Z/h1rvXeS4m8LDXaI89PZporKKleV3duszYHr38o9wfoR06QLowwSnJ6A1oErLWPHn0ofixzDj8Mmjfuyy2a5Mdaju37SyTFFrRoO//JYbm9Ds4VYmwnjH6jCQj6D4zJ1+S0a+alZG4ojtCQXnTTfcysJFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 22:34:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 22:34:26 +0000
Message-ID: <cd8e05e6-76e8-4fa7-89d5-33b1c4f7359e@intel.com>
Date: Tue, 24 Jun 2025 15:34:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/10] netlink: specs: devlink: replace underscores
 with dashes in names
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<donald.hunter@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <jiri@resnulli.us>,
	<kalesh-anakkur.purayil@broadcom.com>, <saeedm@nvidia.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
 <20250624211002.3475021-6-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250624211002.3475021-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d5efd8-65af-4736-8613-08ddb36f46c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0VyVGlFRS9BUnFJNDJyL1p0YlgzTGVzdXo5dldJN0swNHlXWitqME9xNzFy?=
 =?utf-8?B?bWdOOHMrY05UV0dEb3JDYW1ydzFub1hzTWY4UXNUVjRnUGE3Zmg5d1gzTUx3?=
 =?utf-8?B?RyszTEx4K2tnTG84R2VZNmxOWUdtdHR6NWtXYUhpSGJHRWREano1WnRMQXRG?=
 =?utf-8?B?WkVVUERIQ3FYa0NqYW5UQzZOS3R4aG01VXFEL0p1UlB0SC9MTldMdGpCdzVl?=
 =?utf-8?B?RzEvTkZKZXdZcHYyUTBuQ2UxTTB5bTViSUJobmtCTDNLVmVsWnFjR2FqWlJO?=
 =?utf-8?B?UzBOTVp6aXE1SGdDVi9vMGFpL1ZnUmk3b0RHT3ZtTkJMUFRGcHNXQ20vRXlk?=
 =?utf-8?B?WGZrbDRlSWJHUDdmd3hNRkpJYU1SWU1lcENRNGVHTmVVamNSZlFoaXRUando?=
 =?utf-8?B?ZUtCc0ttM2RvVmtqdUFaVmoxMjZMZGdnd0NSdGtiV2tKMEo5Y2p6S2ZHeGc5?=
 =?utf-8?B?eUp1YVNvOWFzK3JQd0dIM1o2aXN1MnMxbWxNK1VpZmc1VFBiYWI1VWtHK0NJ?=
 =?utf-8?B?bGtLMy9zSmR3SU9LS0xmUC9TalZUYXM0MVY2dUloVWVQdUQzSmpvMTcxaFVm?=
 =?utf-8?B?YTZPSWtHNUp2MFpIdGc1ZVMyNndIQWFuYzdKR3haQTRvTGtYOHZST0lqWWRC?=
 =?utf-8?B?dzJrYVN6dmhMZkl6aE15M1krSmVDR3hEYkdGMDZiQUw2Qk0vTlIzQTUvOWww?=
 =?utf-8?B?UUN3U3dpUUdHNjArZ1pXQVk5NGJWUVN1YWlrY2JWNnBOR0FtVVBGYS91dEps?=
 =?utf-8?B?Qjc0YTV6R3Q1TjcxbkdMNDh2MVhjRnhVTzlqeG5sVFVMa2xsZEFkYUllUWdQ?=
 =?utf-8?B?dzB3d2lIcHFyendWNThuRHNTZ0Y1OUtYT0lzSE9xSHhrNWZONlRrRm5QMmxt?=
 =?utf-8?B?bGVFNWVpenZtNG5hM3NsREdkNy8rdUZ0M1h6YlFJckZjK1k5am1PRUhENXFm?=
 =?utf-8?B?Z0didTh1bW9pYytmUkZldm5qdXJ2ZHRSWWorS3BtYU9wSWlwMUhlNHp3Sktm?=
 =?utf-8?B?M0g3QXBoYk5xY09iWXVHUUdDMm93OXVUcUV0REpjYkNKamtOVXFDMkxIKzhG?=
 =?utf-8?B?bnAreEVDQUlBUWJJdlR6QnJWOW1NaWpXQklxOTNyTXExcUtyQ2N5U0VVWFh6?=
 =?utf-8?B?Zi95ZElHSGVyMXNEVC9leUFnaXVDQjNpTGY2TURIVTBqdS8vVDlJSEVmVzVB?=
 =?utf-8?B?cmRUSm54TTZSS1REaDNCelFaZTVybXB1SDNlMTNGSTUyZE8vN0tNWFJtaEF2?=
 =?utf-8?B?WDBPeVF1dVA2VkJuWWZwTWdhajBuaGJnZ05LNUNoNXNtZ0ltOWtYanlIemV2?=
 =?utf-8?B?UnMzdWhhdlhKYVVBOS8zd3AwUVIvQkx5dW43R0pvR1VDNFZKUngxYUV1QTR3?=
 =?utf-8?B?Q3U2OHpvMlo0QXo3ZnFOSmZIRDdoWnB2QlF3K1RxVnNVLzcxNTlQQTZ1ajls?=
 =?utf-8?B?eFhjeThYeWlKdEN0TkZIYmcxT2tsa1M1QmkrS3FNRFh0ZjRjK1JtSWl2bFJ4?=
 =?utf-8?B?Wk91MTBxRlZJbzdISmNRbmhrNDc3N3RSL0N0c2Iwa2xqWEhBZXphOWtNaGp6?=
 =?utf-8?B?ZEdObG54S1pDdE4rVENOcUFkKytocWRWcHpJOWEzVUNyVnJkMnBSV2luZWZ5?=
 =?utf-8?B?ZmN3VXpNQXhGTHNkTVBmM1dqZFV4M0NBbUVhT2RVTVVUQ0xjQW52QVdhaGxR?=
 =?utf-8?B?WjgyQUJ0NFpoUUdFbGptdllUWXV1TEdUZmZSUUtYam95NkpqVzg3Vld6SG0z?=
 =?utf-8?B?WDQ2bDJzSjJHSEU3TmlkcDBTZngvNTVXNWxNRERVMU5pOHFHZHo2UTZUTW9z?=
 =?utf-8?B?cytPQjhOeFlla29LRGdaMEhTY1VacTM0emoyOTkwL2hHeTVSYzhKaVVidWRH?=
 =?utf-8?B?NFkxVzZqemJiZ2FRVGkwMmJEaDhyd1lzdU45dmg1VTBvbk5PcWxuTGtaOHUx?=
 =?utf-8?Q?64ssPAo9zDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlg4ZTBnaXU4eUtOSnljSWt1cThBNlhUZTlCQm4wVGtKSmVRTmF6cFhOSGhU?=
 =?utf-8?B?WjdNWko5V0hjOFBwRDRFOUw3NlM5UEJNOEtLdy9vbVNma3JyL2FYQ2JEWlQ2?=
 =?utf-8?B?K1RRM0tEdE04WGhUTmVuZmVpNUpsZGNCc0lhWlhpWVB6V2tVS3EvUmtlTDhz?=
 =?utf-8?B?Slgxa0VhOHovNVk3YVREdFUwQ01rRXl4ME9UZVFtTFB3N3ZNZGUxeG1TTmhx?=
 =?utf-8?B?TEVyQVN0ZHVEQzllMWluK2pTUFg2SUdTRHZ6bFhlRGs4WFZoSXdyV2s5ME9o?=
 =?utf-8?B?QTVxUzkzei9RN3V4RVJNRHU3SGFFNUQ5M0NNT2JtUkVqV2J4ZXlkaG84TGo2?=
 =?utf-8?B?SkkrMXNkT2I1NFQ3T2ZFMFhlTWdHZXUrWHdyeURSQ2xiNnJWMjBIN1NMWEtw?=
 =?utf-8?B?ckFaRm5SdDZUUkpBcUhYTHV1MW5BdjFnd040T3hmMnl4K2F4Q3FiY2RUSFBn?=
 =?utf-8?B?MEFQL09hWmUxS3BsVndLQnRDbjFCaHZpam9XSHU0OE9Qa3FPRVliZjdQdDUw?=
 =?utf-8?B?dWVuRlgySDhKRk1IVmljODhObFIydlFMTXVHOUttRW1vbnpSY1RaTkRneDMz?=
 =?utf-8?B?ZWpabmlGRWFDZ2huL2xNdVlNWkszVWZnSFI3MEdqVStwUTEzTSs2ME8xOEJw?=
 =?utf-8?B?NGxxUDZBK2xBdk9sTU5yeEF2MFNrMGtpckFXeHZmckpzbnFQQnUzZGtRTGNX?=
 =?utf-8?B?VFl6YkJrZVk0Ny80ZlQyM0ZiMWhuaHlKUUtKT1pNZmxCUkgvMWRyNTNEbHU2?=
 =?utf-8?B?aHB6ZnpqOHVKalYwWFc0VTVZOWR4NEp3WFZ2R3pWR082V2hWLy93SzdiTXho?=
 =?utf-8?B?R0I3NnZ6RnE4M0QrL2pMSmdubExRSTd1ZElnZllPYmRhTUNsTkdXVnBUTnp4?=
 =?utf-8?B?RURoNjBPSkx2aEFvYzhOS0owbDU4RDVDY1lXeExkdllkUVlSU2w4eFJPcDJO?=
 =?utf-8?B?YTBEbytoajZWZkpKOHc3MFNKMllGQW5aSUVFU1BnbkV4Zm1Za2VmbEZ3eHA3?=
 =?utf-8?B?YUlWZHRxNzJtT29UZ0U1cWdSWHcwY1BraXdxdDF1cDhCTk1LR2hGdlhOK21q?=
 =?utf-8?B?cDR4RzFxVXlId3hycGZSRWVzQSsrMDU2d2F6QVpNY3cxL1Jzc1U4Rm5oamFt?=
 =?utf-8?B?TFR4TjIyYnpyRFNSUFhUQWZRVHB3Q1pYMkt0Y1dRVkh3OXdhYnMyREtXKzlw?=
 =?utf-8?B?dWVuRkRDanpySURtS2s1N3l2Q2pEK05VWDdibWhkUGxmWW9zT2c2cEZUUmFr?=
 =?utf-8?B?Y3B0Ri9kQ3l5UnhmTHpRSmlOdCs3OURrbDFHL0hBaXVhb0F6N3lOZFdzSXFq?=
 =?utf-8?B?bzJuSkEzdnV2NzNUTE43amxZRkJ1cXlIT2JTRG5QYWpXVDkzamh4SDlSU0dl?=
 =?utf-8?B?QW1GaHdxaURmSmNwV3NMT05KTG43RjlncEd4VnZ6VENIak9kZnRiazZlc0Er?=
 =?utf-8?B?eG9nRGtZaXJ5bTZKWFB1V0ZWQXVPV3l4OVBCTklxc256N3M1UlhVdEZLMU9r?=
 =?utf-8?B?dmFIMUlaZEFUMHUvUnZoWmRvUmlFYlNoR2ozT1Y4TkpvL1ZYQVowWnQxemhN?=
 =?utf-8?B?cktvdXZqVTMxREMwaFQvZi9zaEZYRTR6S2RSTTZJcE5lUG83N2lVVldXek1q?=
 =?utf-8?B?dDh1ZTVUUDlUNmxKY2E5WEwxY25RSk9qcHBwL25qL2s2NXo2ZFlDc0xoOFJH?=
 =?utf-8?B?ZU9qOERuUEZyYlpTSWtqZlE0d0tCeUVYWXo3cU9LRk0wcE5XM21jUHJzbjhM?=
 =?utf-8?B?alN6OGRqek16ekJXb3RmY29haTlUc3ExcU9ENnhwTFBZUTFpV0MvNGoxVWta?=
 =?utf-8?B?TFM4UGZTQTZzaC9KL1JRMEtEQzVlZzR5ZVd3Z2F4bnlCelVnSDVnSGJMZUkx?=
 =?utf-8?B?dHkwL1VCOUdYdHM5dkx2dTEvNHd1SGMrc3FEYVhXdjlVS3pTZjdtait4Z21D?=
 =?utf-8?B?TXFueWFPVExHbDZzeUlHeHdPVGRpTzAwU0ZOVE1nSXZ4a29FZmI1andNNURX?=
 =?utf-8?B?TjVlOGtIcU5XSkN0SVcxWXRJSVFra2JoVjBMNFBuNlMwNUJQOUtFSEtXMWw5?=
 =?utf-8?B?WS9JL3lSV3Nwczd6UjRhU2p3N3o1V240a0dwVEsrakV4QTJPWi9NVkRKV0s5?=
 =?utf-8?B?WVdpeFZMVUNUdW5lZmFSajEzakY0WkhEc0JHNjJzVzJoOEtDcWJ2V1ZTbGhq?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d5efd8-65af-4736-8613-08ddb36f46c7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 22:34:26.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i1w+UUVdcnx8BJ9m/bkwcA/wDZF2sZznd3G/tsPoT3J3fbsvNx8CTlE8H1UrYltw3g5YarDJYmlV0pePWewGKdekWzVDbWRrw+Nl2PippU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com



On 6/24/2025 2:09 PM, Jakub Kicinski wrote:
> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
> 
> Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")
> Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> CC: kalesh-anakkur.purayil@broadcom.com
> CC: saeedm@nvidia.com
> CC: jacob.e.keller@intel.com
> ---
>  Documentation/netlink/specs/devlink.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 05fee1b7fe19..38ddc04f9e6d 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -38,15 +38,15 @@ doc: Partial family for Devlink.
>        -
>          name: dsa
>        -
> -        name: pci_pf
> +        name: pci-pf
>        -
> -        name: pci_vf
> +        name: pci-vf
>        -
>          name: virtual
>        -
>          name: unused
>        -
> -        name: pci_sf
> +        name: pci-sf
>    -
>      type: enum
>      name: port-fn-state
> @@ -220,7 +220,7 @@ doc: Partial family for Devlink.
>        -
>          name: flag
>        -
> -        name: nul_string
> +        name: nul-string
>          value: 10
>        -
>          name: binary


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

