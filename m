Return-Path: <netdev+bounces-152342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE79F37BE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD2A161EF7
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34620457E;
	Mon, 16 Dec 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5PvW/HE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7738FA6
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371127; cv=fail; b=TezLhFw1djtoY0hRUZ7Fy7dm9AgjFdt6j6vLtIpHeFuuIRcP16SQb4TyFH+40UJkwNzlhGRC1BKGUl3SlixmJWFPfijbkSIiTzNDlyd25BRgPIHXnSqWucYlBmxPjfXsmfnHzHGBn+ioE9/ShPovl6SjTf/YiCFA3ospu2LTW0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371127; c=relaxed/simple;
	bh=LOc6jWErDH9N1KXDNfh3aUTciMbuCyFsuG5h24Sa3Xg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Foz1B8w6Hkpjt08qSAFsziCIy+dLELF9GFKuumGS4IHzJRh1V7wNLtJ4EP9Xxfm1K/CHi4pBTc9NQzJ8oi9oePOwU5FpoljDxzybIf2XLqNQkzp0kllGqy4jguNMwxfv7RPok4g5R0MJBWQMAu1wxpqONyypTI8mrq7O6l87U00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5PvW/HE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734371126; x=1765907126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LOc6jWErDH9N1KXDNfh3aUTciMbuCyFsuG5h24Sa3Xg=;
  b=C5PvW/HEm29RljpnCB6XAXWmAiGjH67VU263fQCucGPnXZ+zuWkqVRBn
   vlWX2iY9as+GZW3WER2E9Vdd0rI2EH+28L1xFZo6W9WNEHLgMj5o9skYp
   7mvW2ItnrLxoHO2xI++OZuiNc6ld0xkmN2y+q97+6OUOjOw4hhdKDOXZd
   +AuvAvWtmrqE+g1MexBd0ZZWpXXq6VxMxUwWwtwkaYy4VTSwX9jTrwJbf
   BeVmleJE3Xeg7pB1BBY3PxU3pdQRG8ekOyBZxQHfUtWwY6NqoGcwAW7bW
   lghdqlbXKSFSACix5HBwjtZrfr4puXecKHki31aF2+JxUbsjVnfA7bTla
   w==;
X-CSE-ConnectionGUID: 94LaTShCSjin/8tjW6SjFQ==
X-CSE-MsgGUID: XNCOVN0aTc+0TlEUCc/Oag==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="60153163"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="60153163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:45:25 -0800
X-CSE-ConnectionGUID: JyuA6c0OTj2/tj3L8NVpbQ==
X-CSE-MsgGUID: oNltfGYETiyeKKPeh/MOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97705329"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 09:45:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 09:45:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 09:45:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 09:45:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1OaISACUTLnQBuiKAMe0dHenNcgDhFzViJ0xNe7RZrwYOPQIXNgqjdjVl6W8fpJdS+jAzicRrtQTVZWmIRMLgDEXnjpq7sXeWiSocq9vMq+Sg20GlWwHQQiYmXV4FoRQlFLYG5ytDoe0IgD8sCtufgQM+D1Rfv6dtOSYmq0H3+8oXebgSKUAsKVwVHq2sxpqEg3q0gDlishpXI3kEmys0yt3hQ6elUdxaiX4egm5XycdHl7d3lWCPF2MBfEsRmxa8waOZA2xqU++IdNoXXO2G0dGNx3EAZoDLw+7VDpElUNa6KPrawE7d7OxJ2dUmxSSrq4VmQfT5LL/tdRl5NjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGotJUz8LbRaw228kBLFs/7LXrHjK0KDYlxaBogZtXU=;
 b=P6F02q1NYZuZVDyGSsW0dPRwY2Iztf5xyChg//k6lWBMlqpt+UIktLZaTnd2kENKXXpDB8DQSg85jDyRpmDiHarNboJ7Mzix7J6LM2yGDSAO5WJ5aAlPCxSgNHigCHYeWllmrXBsUbNHqw8QFFHf2RyQvTwWkDVxAbsLS+du/UqNq1KeUvQMET8/pHnS12rsqiFxTHFjuDbLzKomwyDTPwxTJws7lAbHmaVBYHQFATk18FPVBNIrUyDeO6FFAPM3d+5Y5s4jXin8I9ddVJwYO7kXLbrQ1G+x6PG5ILfdEuWEKPvZqLJMVbejo2M5DG8fNlCKretLEYW9TVrgQOwt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 17:44:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:44:40 +0000
Message-ID: <35e07596-1153-4e40-9fb7-d06703b82804@intel.com>
Date: Mon, 16 Dec 2024 18:44:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlxsw: Switch to napi_gro_receive()
To: Petr Machata <petrm@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
References: <21258fe55f608ccf1ee2783a5a4534220af28903.1734354812.git.petrm@nvidia.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <21258fe55f608ccf1ee2783a5a4534220af28903.1734354812.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b2f65d-4a96-43e5-9604-08dd1df95113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDRPWU0xL3ZEbkNraUcwcWlhdnpyTnB0UW1pcldlaFd5TmR3N3AwOHJSYXJX?=
 =?utf-8?B?SzAvOHdhTkZDeGVuT1kwRmF3cTF0eTBOSVZjbDJSMmNhUkR0aXRyUnczZ3dq?=
 =?utf-8?B?dWMwNmpobWRjdjk5V0VKd1dPcmF6MGdjMVVhelFlTjZ6OUJJUGh3WDdoZVA5?=
 =?utf-8?B?SWNHbEVIRVc2bWNTdktQdzdiQzBQalBSZndqY2o4akhEc0hxcUxZWVJaSXFM?=
 =?utf-8?B?bWZ0SjIyTGJGUU9OSmFmUThsQVFhd0hYWHc5WXJTUkJ2QWtUT3Q5MmJTNURI?=
 =?utf-8?B?MDRpY01vbjY0aVZjSVN3Vk5XNno1N0pQalZUUkRjTmduTXBlb1I4aFFpK2xn?=
 =?utf-8?B?UDFLMzZ1endqc2ZQdSthTk8xSEpkanNoazBjU3ZQSGRnVlRMNC9Tajh1Q1dh?=
 =?utf-8?B?eGtkZHVjQW0wVytYVFRBTkwzWWtOZzJhWVVNK0tzMm9wQk5jckJEQ3RFMlUx?=
 =?utf-8?B?SVc3aVFGZ3Z1R3ZRcU5jSi9OeDIvbUw1KzJpNFZOTTRrOGFnVnRTV3B6NUk2?=
 =?utf-8?B?ZWcwN0JoUXFTZElBTXhUWnZYdldBbVVhbXp3TjQ4WkxWdmEyTmlNUWdHbUpm?=
 =?utf-8?B?VFhWaXBPSFdHQXdGbEVsRmY3ajhTWU5PQVlSdFJHMmVoc2pHZUp3dFIzTTFl?=
 =?utf-8?B?V01UbFhONjhxM0lSR3ZZb0JPSlVheU5pY21heVk3R21CTVJYbTRRU082alFr?=
 =?utf-8?B?L3lzQ0EwYmxQcytyelN3Sk0zTkQ5bTFDRE02NVh5eE5IaktuM1lWR3NGUEht?=
 =?utf-8?B?enE2R3laSGZmTHppeVN6VThkVUhJM2lmc1ZVS3libVJycU53dnJLV3FSTHk1?=
 =?utf-8?B?SWRWR2xVenRiVm1rYTZtVkY3K0RpQVptNWhrZFBUZnBiTkRiTysxcnYzcXht?=
 =?utf-8?B?WjVWSW1NUGIrT2M1TmFyRzREcHBHWGlvOWxUTDNYL3JNeWpvVFRUK1hra1Ey?=
 =?utf-8?B?emRCOUhCcUJ2VThQVFF1NVk4MEMzZVJoZDFKdmdUS1VmRmVTa1VRMklDN3Qx?=
 =?utf-8?B?NWt6TitxRHhJdGRkN3JPclB3NlF0OU5ib2k0UDNYSTVEUHpvMW45UzUyb1dh?=
 =?utf-8?B?VThNSTY2TWw2K0hsYzRGVEtndjNlZzJSN0lPQTM2cmI0U1JOWlZIWTZuMGdT?=
 =?utf-8?B?Rmw2TUJMd1hXNGZkQ292YmJCem9haEh0TjJQYkdrVDV0dEVQaURpc00zV3dT?=
 =?utf-8?B?U0JIK3M0ay8wUmk5ajQyakVEREZha1hKK05hL3NEQnlHL3VocXZ5VVBqNWd0?=
 =?utf-8?B?b2RSZy85THU4bkI1MlFNTkhNeVB5S05oK2VWdWcrUVJwckc5U0tiZ3RLNWps?=
 =?utf-8?B?amh6ZzJuUFIxbkk3MTNJNjhIbmVUVE9NdkRVQk5aYllaOUNJbElvSGpIazV1?=
 =?utf-8?B?Y1ZoUXcvUFd5V3d2WE8rUnEycUJoSENZRUp0Q3EzbUtPcWo1OUlUYUxNRUNT?=
 =?utf-8?B?VDFxRTJJbC9kR0xKUFQ0bkcxVk0vc2pudy9QSUVMMmRKSUNNR0huWFl3SHI5?=
 =?utf-8?B?bEpUREQydWEzZjZEMjFUNHE2dnBSZlhiVERBbjFWeDBSZ0dSZTBKUXRSSDAw?=
 =?utf-8?B?ZG45ZW5yNHdVTzFtOHJyZU5aUk5yYTBCaGh3YVNCV0loRVhCUVU1OU5tUGMx?=
 =?utf-8?B?c3FJQWxScEptd1M1ZjQ4UFo2ZWV2cEprSDQxb3JnNkRnY2k0dVBBZVMzN2FT?=
 =?utf-8?B?Q2dtYmhucUgwT2pJS2dFMnR4cjNPd2RsR3BkV3RDdE5QVDhtWTEyZ1VmZE5L?=
 =?utf-8?B?RDRPdlFHb3BJelh6K0h3RzBPU2pNQnhDOG9uTGtaanpNdFJuTUIyNHFTT3Z2?=
 =?utf-8?B?d3p6SnJiTDRKU1FyUEIreVEvWVNZVi9SQ1Y4dVkzTUpkV1QvT2NuQjFpTlps?=
 =?utf-8?Q?jE8YXngeaLBkk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVcybnh1UmRrWWFjTHU4QlBwVi9xNndLU2lTc2R2MHVKNlJpOWdLTGVHL3U2?=
 =?utf-8?B?dEdBaUtqK0pEcEgzTDZuZlJwNytsV2JxazN3VEJ3eDU3UkpGblBlWGNjUCtz?=
 =?utf-8?B?WEROMzUrczdaZnJTSEc1OHkvd01aWk5uTnNDRE9hN3I0ZEo4bEIyaGhEdUpl?=
 =?utf-8?B?dTZQU1A5ZThTUElybURVa3BDRGtmNzhTcGRBWHg1ejVQNnV4N2M1YW1STEJW?=
 =?utf-8?B?Mm5Qd09XNUI0c1loWEcrdE01ZVhpb2VZajBGUVo5em9mWlBsNE5DRnd2L1N4?=
 =?utf-8?B?Q1NYK2xxdEZBUXBYT0NCUGZNTVJLSnhyNWVQbENvMkwyM09TNHBWRUtIZ2xv?=
 =?utf-8?B?N2t0MGhzWWJraWNEcGhQWEFlOVpzcHFIaC91dzFCdFNVUnRuNGNaYklUN3M1?=
 =?utf-8?B?QWJSWE9MdGIwVkdxUjZBZk1kSTNYU1lwUktva0FiT1NTOHUvbXJaVEUxY3lt?=
 =?utf-8?B?Y2dwUkxTNzdsM09KdjVacHk2dkFVSDRzV1ZCRDN2cVZydTNCblIrcU9WREJn?=
 =?utf-8?B?c2ZmZHNHbXF5eDFDWHNwZXpaVDVTK1JTVDVMQ1cxSmRwSjVkSDlJNm5XRXNx?=
 =?utf-8?B?Z2t4RjAyblh6djlVbzJvZkhYa2Fld0I1T0pwaGRwWjI1ampiTmU2WlN5UmdV?=
 =?utf-8?B?SWV2bnRFMlpYQ2xvbmQrRDVVTDNtWEcxR3RORFV5RTUzK3R6QmhnNmthV2lX?=
 =?utf-8?B?Y0k3dTg2Ynp3MDVZWVgyYnUzdG1hSTJ2Yi9ITjRsUWJnS0VUWkNFT2xrZHNT?=
 =?utf-8?B?anViekxFdEJtc2ZvU2RtSURWeTVqNDd2NTlPMHM5K0I1cXRKclFBZFV5UTJR?=
 =?utf-8?B?M1RNSjF0TGJCY0Jhb1V6eFdwUkNLMklhSXg0SDNCaGx2V1dVMVY1bUdvbDNv?=
 =?utf-8?B?aFl1ckI5c1RhbDlLSjBVR2lTSHBSazFWY3VxMzlWV1JxcU5XYkdDNWxQQmI3?=
 =?utf-8?B?VWdXeXhlSzBsVmRBMVU5WUNkUFVxdEpNNHFGSDhKWWIzb2tEMnRrRTUxRHp3?=
 =?utf-8?B?bjh6emg3aDIxak1lM3pwUGJIWFg2dm9YRFdScUV5K3p0TFdJcUdqczM1bzJT?=
 =?utf-8?B?SVF4L2ZsSzFJYVAxdVJqVEMrcWdOMHg5UlpDSTNvcGxEblJaWHp3ZEFieXFM?=
 =?utf-8?B?OTJGZ1A3NnhJZlczSFU2QWlhOGthc2grUDVrV2JPbVkxSUVmMWlYeTdOUE1F?=
 =?utf-8?B?V0Q2VmR4cmdIQnNrenF5eUpnN1J5MFFCRDV6VHdCcUtydm9jbEdQeWpwM0J2?=
 =?utf-8?B?Nm9SUGgybkJmL2NWcnNVSVRYQS8wVlV1L1crSkFGLy9Yb3FmR3JyeE1BV3do?=
 =?utf-8?B?aWlkL3NxOTl2QmZOVWNwczJoazFIRHZNam1FaWxVNDRDSFpFREhzMlZ0WGtn?=
 =?utf-8?B?QTNMR241Tnl1ZlYwY0U1Y0dDRVlGVGJPOWZOYzBic2EvaDVEM3ZEOFJBNGpR?=
 =?utf-8?B?YWRpd2RKcGdveWRtRFMyQy9RS0MrbG5uT0FhVUJMb0Q0Wmlkc2t6b21zWHZk?=
 =?utf-8?B?Z1RuTEdCT1lyQ1pTbmNlaENpYXlORmVXT0dsNTZtSFhQMVAva3R1N2l6bStM?=
 =?utf-8?B?N2Vma2JaQTFyWngvSFR0WFVRb3dWZTQvNEdQSDJvRlBOb2g3OWc4ZGNVR0c3?=
 =?utf-8?B?UC8wZXp5UnBMMzBSR1Y3ZEdHWW5pcGVKRnVmT0lqMkRmVmJkNjEveHhkQWcy?=
 =?utf-8?B?Z2Fzd2NSWGZEYzE1dEx5ZGdZMnovaStaaHEyWXBnYUYvOXJwTzJVRTlma0cz?=
 =?utf-8?B?bTk2bk5FQVNOcWlQTTlveUV1cWpEVW0xcVFCYTFDZkZsZFRidnhFRHpuWHZ3?=
 =?utf-8?B?SlFFQjhYSzZ3ZVRueW03N21MUVhWRzV3OWdCWk93M25kdGhrQ2c0UGlrZjlj?=
 =?utf-8?B?MmhGdTRIMVh0bVJCVEtmbEh0VWNmNWFjUU02Mk1oN213N2hzZDJ4Uk9pYVhu?=
 =?utf-8?B?S3ZTcWt2M3c0QitxZFQ2WEUwcng5TmtDSm9vWjVPYWtMbVJOYVRJVjl2Ymto?=
 =?utf-8?B?U01xSUNIZnM5UlFVcUdzTWRPcFZHTk9tQjhmN3ZRS3JEa084QTEzRWptWnZQ?=
 =?utf-8?B?c2p5ODQ0YlFFMis4cTJPTEdKR1NkS2tEcnNLMHhwb0hDNElvZEdES2RhL0FM?=
 =?utf-8?B?RGd6a1B6eXR1cjhkL2hyVUh1L1hnMG5ENEQzRW40OGN2Y25KYzFMUVNEVTdq?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b2f65d-4a96-43e5-9604-08dd1df95113
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:44:40.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uTVl99JGoWbCXguJrbZYLBl11VmX07GL5VGkw/yZXGwRPEwyZw7wCb2Bn/TPvx+YM54OTsMnlNzvo7pFXoVEuVBxtzX9OT0Nrr0zg5li/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-OriginatorOrg: intel.com

From: Petr Machata <petrm@nvidia.com>
Date: Mon, 16 Dec 2024 14:18:44 +0100

> From: Ido Schimmel <idosch@nvidia.com>
> 
> Benefit from the recent conversion of the driver to NAPI and enable GRO
> support through the use of napi_gro_receive(). Pass the NAPI pointer
> from the bus driver (mlxsw_pci) to the switch driver (mlxsw_spectrum)
> through the skb control block where various packet metadata is already
> encoded.
> 
> The main motivation is to improve forwarding performance through the use
> of GRO fraglist [1]. In my testing, when the forwarding data path is
> simple (routing between two ports) there is not much difference in
> forwarding performance between GRO disabled and GRO enabled with
> fraglist.
> 
> The improvement becomes more noticeable as the data path becomes more
> complex since it is traversed less times with GRO enabled. For example,
> with 10 ingress and 10 egress flower filters with different priorities
> on the two ports between which routing is performed, there is an
> improvement of about 140% in forwarded bandwidth.
> 
> [1] https://lore.kernel.org/netdev/20200125102645.4782-1-steffen.klassert@secunet.com/
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Amit Cohen <amcohen@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

