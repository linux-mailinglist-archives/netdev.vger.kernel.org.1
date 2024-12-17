Return-Path: <netdev+bounces-152637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B820F9F4F20
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893FE16C7E2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC31F7545;
	Tue, 17 Dec 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1pRh1k+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC721F7086;
	Tue, 17 Dec 2024 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448470; cv=fail; b=k8Bsa6WAXbRjjt/fUOj+i5plItwMVEBwFdKf61MFH68XN98vPtV0tXXqkDFtfRTBDJIJDqXKLYMUFFXUzR7QpDQYKKwKUI9kv6jJK8t3C7YAi7FU97fY2aVyaPB4OzM2QE7HMh0hY5cH8lVIbuWNRRQ0ibKuWXPBJknIy3vWe88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448470; c=relaxed/simple;
	bh=U4pXm7IvZZ57ctr3A6OJ0xmWn/DlRxAqnJA0Vt+HheM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IaZT9v6bmv32PJpd8Ekl3WiJ5VxwmIrbe6kQTs0+sjVQFI5hAvoAjfKt0R3xTAAPvLuitxpAJ12vQNlfCz7oW/kFMqfhb0qTg5n6L9oLxmHWvHm2Ko/eC/XdlnlI7fNC2joIP/MxPeYPp/mMXLThoQyfzfuyhbmndfXdeete7io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1pRh1k+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734448469; x=1765984469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U4pXm7IvZZ57ctr3A6OJ0xmWn/DlRxAqnJA0Vt+HheM=;
  b=O1pRh1k+hdey0p1QfoeX8zJvqBK12/EoHpa/XmdRSbuT3Nbj4Ce/HGM6
   BTJv7fYsZ9wphSfivR/H/FjMXIfHJeeC5IxWgZBHCKjhlbx+EI5Te1Y6d
   57DCJnjxez87KVY35/C+UdnmDWjJMElJsO1+OX66BtCJaiG89GPGPwVMb
   NJQxEM5pQ511qG7mD0s04fWZLzvaG+61kIv4ndBh+rLq2uUP6XFT7w20Y
   9NvUkOuRyuqLYao/MP4pIdPetTlPnquiRJPYyks3jXd/DY4mg2LR1Nv2g
   3+Ng65v/cMeYExT2Q18U10QiLLG+ml0l//5it2HOwOK5rhywohuDUjwF+
   w==;
X-CSE-ConnectionGUID: e/xeaeJ2R8aUysO3iBUpDg==
X-CSE-MsgGUID: pK4+EFzyTZGiHhmSF21F7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45885198"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45885198"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:14:28 -0800
X-CSE-ConnectionGUID: 1fEVkiZvRkiJI9cfpWABHg==
X-CSE-MsgGUID: XzUxv9VUThCDRpbXQDgMYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134902890"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 07:14:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 07:14:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 07:14:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 07:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbhXolVaX0w3C6A3c35pwj6Mrw0IjE4vTZYQqvBO9ORnYwArzMkvlnH/YMUaMQcTWGHEVBJL309ygdun6EF8IET6yGWlw4B/iMD38DQJcP0pJn5BNykUURJyAL8vAqkoJbEmuDTaLElPfroC2EA/yLSMAn+fyYzSPyTxmmoa9HVcayIHJZfXFSApblCbIYJlCfH6IVW5DGjdvsEepZlKY1ZSXrq72N9quthHo0PTpGWuMFWcLHAOc+8D8pG9rnwPkh6TQet6xY2POn/ql9YcTnz+EE8HgIYk5bEX7OohrLJyLEYEraUW9idf1rsJe2PXW7WVNGWaMwxcjObkuUvQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCT/Selc/6MBuuee8GItAi5pUdsgZuZsVtU6BYiHJC0=;
 b=fdP+LatSdh/xYAvBT+qBdJ6ol6wByOfaCO/9u8ij0MZaXY19mi7kMFiwWG3J9qlw92ISgaEKNJCwmm2B2gqY/oKcgz1IpnpjXYGnJEGjXDH1FzKtvPTG5y+Ym/TjUGqR8jyVXUecQiuHIQQ/4V1AESJi89+p0a47CiHU5KrvKXFMoBroEcacA5iuE1VEmyyjHuLjv6EYHf2s9FziG8vELFAJYk9ghItq2sJ7viRjN95PuhrhKN1AN16OMKpZ8fjA5OTVvjGyoOvp2lEyZGXfadIHRLl/qI8XKfxed3mwOVzFY+mgMKdDSfOICOSUs4HEn+140ZqI7U4UqSC6QZPM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 15:13:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 15:13:42 +0000
Message-ID: <5f2eb433-479c-49d2-bc2f-07f6c0a52c60@intel.com>
Date: Tue, 17 Dec 2024 16:13:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 1/4] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
To: Wei Fang <wei.fang@nxp.com>
CC: <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<xiaoning.wang@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<frank.li@nxp.com>, <horms@kernel.org>, <idosch@idosch.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-2-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20241213021731.1157535-2-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0294.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: f414ff4d-75f2-4f1d-ba17-08dd1ead64c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmNmb00xQmtmQzJwbk5zUWVJWlRwTHZCQjlKTnRHYzZGVDg0a2diQUorVEk2?=
 =?utf-8?B?UnBTZ2Y4V0pibTVZYk5FK2ZBeVVsQWVkSllOMnNmanRaTFFTV1RWM3JML1ZP?=
 =?utf-8?B?bGJCUVZUczJXYmhiVmhEck43QVVuRFh2eXZlbkpaaUhmTURaM05SdWNXVFkx?=
 =?utf-8?B?RktyVGdsbG9URWlMN3F6aUErRTlqZSswa0dzWWk4REUyUGpJWk9QekFJektX?=
 =?utf-8?B?SkJoUEQzdGxSdGdjTUMyL01qWlJLQUVrS09kMUczOVU4WVA3OGNyWnJ4TEFx?=
 =?utf-8?B?RUtVbDZCdFRVTWwvak5scyswbGlOV0JRaUZ1S3pmY2RqVk5oN21GMTU5NWJj?=
 =?utf-8?B?bHd4R21DN2ZCcDlyWEQ1dENldkRCYXQ3QmVKK3FVWHJYdTlkK240cFlJaGtM?=
 =?utf-8?B?R2VIL3pxVE1sMnJDYS95V3FVVjJSNW13RWY1amN3T0JvdkNqL3pwK3hvUmV1?=
 =?utf-8?B?V3pnZ0I4VjZvU2hnKzNtWExVeUpxNHVPRTBmeDE4ODlpd2l6WFR4cE9pUm16?=
 =?utf-8?B?azNCUnA4NmZKT0xJLzJzRjhrNDl2YzVhd3orV2tVd0RTcjRnMERsWC9uQ1lC?=
 =?utf-8?B?WmxTdEZKbUJrKyt5YnN3dWMxTnJ1UU9XNDZVQ0dSc2xiSGM4VHZiWHlDUmtp?=
 =?utf-8?B?T0ZYeGlPdjBuWHEzSE1zTVgzMnRNVE11UG5TQlI0Ky9hWDlOUnpXVS95bXY2?=
 =?utf-8?B?bUErL21MMDk1WnhDTm5XVStBSE5WSjR4Q3JBVFR5YXVQNVhnUWozQzlibXlM?=
 =?utf-8?B?ZHhHbzVkMmh3Nk9uNTN0YTlHcTE0RVY2bnFraDE5dUJjZ1VyRGRvTFdFaXVw?=
 =?utf-8?B?eTFYbXd3WFNnNldXY2FLYVNNL3Z2Z1FkaUN6Z29SSy9HbFZOcFFGWHUyVGw3?=
 =?utf-8?B?Q3p3Rll4S3JsdG9Na29FQXZ5Zk5KVlhBOHFrOTd4UFQ0dnBDOVVjaGlhOEMx?=
 =?utf-8?B?OEJNUENVRGNEWHQyL3FoQ1cwOTlDcnVwUmpsZEpmUGRIS2NwbnZJNjJRVzha?=
 =?utf-8?B?Y0xUWkZVQzcxQjZNcWZaS0NoSjJzeE5qZGc2MGFnRlNaeWVRaS9rUDJUaGZl?=
 =?utf-8?B?Z0E0c0Jhd1o3bnZyTTgvZjNFbW1mMzRqb0Fxc1g4eWtpVzJjNzNaSHAxZXdO?=
 =?utf-8?B?MDI5aVUyUWVRVmtSczAyQ1lOWS9ZYjQ0cVNaTWdmVkREKzJmajlkVXlGbmpw?=
 =?utf-8?B?TlRvajgvbE04R0E0dklCY2dWSTRFalA2b0VwZHNLM2MxRlAvVk9CTXBHZ2NS?=
 =?utf-8?B?QTBndXpEUGJhejVoNlZwOVcwU1REUjBadGsyOEpEZHI2b2ZnSFNKcWZ0TUtN?=
 =?utf-8?B?WXJtQVl0TnYrWkxnMnQwSWdqNm5mRGU3a2wyTldqejZMTHMvc0pDNDB5V0Nz?=
 =?utf-8?B?TlJqQ1NER3A0MFpHY3NTSC8vakwzVy9xMU94a2JiWCtCaEF6WlFwbktGQnFI?=
 =?utf-8?B?Qm4vTEVxdDZ0TDgvNTF6dkgyL0lRZWtyOERFTTJwdENacWIram9TY2l3Znls?=
 =?utf-8?B?bU81VGtKd1orR2tnbWVXUW9nbGIvOGhNWE50YTNLUGJSMFh5VzIzVTF5aklS?=
 =?utf-8?B?bC9qd0F2ZUJrUm1JQkU4RHF4S2RWODNoSHdMU2FKUno1UFVpTXZnTFJiaXFr?=
 =?utf-8?B?WGpoNjdkYWVjNDl1V3JXY1ZrdjdFWCttMFJRcWxza1Uyb1h5ekYwb3o1NHFR?=
 =?utf-8?B?V3RHUFNYQzJPMjBGMFpFcHJpUGxoTjY2aGJiWjBVNGxtOFR0eW4wbmpKUTZC?=
 =?utf-8?B?eXh0SlMwN0FLZTRBV2ZLZDFFV1cyQ1o2bFZ1WUVlek04QW1MeU9NNi9OT2Nn?=
 =?utf-8?B?NmtCcnVPYjIzQmEyUnBDcXY3ckpBcUFHcFl1RU5GZmh5bmxVSkM1SytkYklF?=
 =?utf-8?Q?p2PiTaiKg74wN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG5CeG82UFhrd2ZZWTZCL1ZENWt5ZjVBSm1xQmNQWU5NYWFuUTNSaUMrSDBh?=
 =?utf-8?B?RzBHS3VkbFlPL2FUaGlXMEF5a2Vvb3dibEszV1JEcUU3aFl3bktCcnBXazZo?=
 =?utf-8?B?d2w0ZEhleS9PUllPNlU0bE9mN3RlYVoxNWFxNjBjYTRTckhiem90aW45UFpG?=
 =?utf-8?B?RFJjUU1ZKzNzRERsUmpKTG55Nys2bXo5Q25RZEgyK2VRYzdzV2VWbkE2eTJ1?=
 =?utf-8?B?Ylk2UVJpNFVibm5IUkhScnNRcWhCVUVkZVFTSVpCelZoMUgwSUdUWTBjUFZI?=
 =?utf-8?B?NUtDMFNkOWRqSzZoL3hXSU83bEVDRC9VSEdBUlUxZndPcVd1TFEyb0Nnb1JN?=
 =?utf-8?B?T1hNY3BmVTM2bzlpbkwvSE1HUFB6MHh4OTVLWkxtTUNCaW03bHB1VVNqd0dr?=
 =?utf-8?B?YnhlTVNVaGVES0tXemplb3ZsT05xQy9pazRmOU5JdVcyN05acWZsYUxsQUVB?=
 =?utf-8?B?RlVqU2szVHVEOGoxakw2NllEOStqbXRYNldBR3d6ZzFSL0RrNHA1L2podWIz?=
 =?utf-8?B?eWJUQTJweENSYTlkRUlJYkZGN0FxYzBSTlFIT3RrYW5Edk9MSGRCZUdkR3dy?=
 =?utf-8?B?bEpzblBDYkpBZU0vcjRhVHBGU0syQjlsamw0Z1h1YWY3OWRnSkdpVXVOZW9r?=
 =?utf-8?B?aS9scmJ3dzcrOEk2bmk5UFlBdWk1ckpLUW0vVGozQlhiR29xbStDZkRWMVl4?=
 =?utf-8?B?cDRzRUlWWm9MRFJEOHVlTDErQy94MnNUTjV0Y1BwWlg0UXJlM25wUW44MVAv?=
 =?utf-8?B?aGgxNDhLbjloUlhXZTM2bTZsVE9TbWd5T2s1NHdjUFM0TGdJK3NxbXlpQ2tF?=
 =?utf-8?B?Sk9qcUlUK2JEVWR4Wit6VDduL3crRWFMcmhzSHV4akczZmxOSlo5YlM5V0I5?=
 =?utf-8?B?YytMdDhSeGR6dk9vMS91emNodU9nZ2Y0VGs1MjM4bkFMRHhjT3JEMER3dnF1?=
 =?utf-8?B?c3ZqMmhmNzI5SXRXeVdZcmtrVmNXMlRGRVExcWkyYzdrTlY0UTVQWk9hTDcx?=
 =?utf-8?B?c1YrYnA1ak9FWW1KSnBDeEdjQXA0RW9jZVV3VzU2V1hPaWpmMlpQVEpOY3Vw?=
 =?utf-8?B?clM2REs0VjlNTmRxUTRXbXpkQmNHS0wzNXkvYm4zT0FtSmVjMUpFa2JTTmky?=
 =?utf-8?B?dXNwbmJNTmVqUENSU3Nzamd6bXBSdnhFVEN0ZnYxTzV5SkZXZk4rUGxQUjVy?=
 =?utf-8?B?MWFtSzQrYnQrYXBEWWxCTkhMcldSM1BEVHRZbFpjbGUzT3Urc09iREQ0Q250?=
 =?utf-8?B?cDJPK3p4L0NsWkVJZlcwUzVyMGduRGROUXlJMnBWUEo4ZG9TbjNsNkFWdlZ0?=
 =?utf-8?B?WTNTbDFRSnAyQzBmVEN3bVRUcDh3SGpsdHVWM3M1Wi9nOEVLTDdUUDBsTkpU?=
 =?utf-8?B?WDNzb3FxNUpxQ1lwd3NzSGl4N29KaXlGUEJDVEFUeFNpWmh2aWtZYmEvd2hV?=
 =?utf-8?B?Y3BxaGIyTXNLQ3N5UjdRSkdCNVJVVHd5YUpVdnl6UzZEWXJKM0RPQkFhbjlr?=
 =?utf-8?B?ZFE4aEltSTZHQ0VkOXVyZU5RcUprelVtcnh1ZWxBdUdCZGZPWUxDbTBkZ05p?=
 =?utf-8?B?K1ZkRHFpMFFZRTgwQXhTOFVNQ2k1Mkx0ZjBLTkRSZ2tnTDNmakg5YVpsRU5G?=
 =?utf-8?B?c3dZMFF1ZEd5d3NZTnh1M0JKUmVJS0VHdnF4bVhpQktVK1JBZFNjeExFSFkr?=
 =?utf-8?B?WGFhN3ByS3I4dEFUWW80SDlKR1llOHc5TTI1TXJtVytZR2ljejhSdVZxN3Fu?=
 =?utf-8?B?WTUyY2JzZGpSUkZBVHVnMnpCWUozeXE3bTBGU2xxcVJucjBJUThuWDZlQko1?=
 =?utf-8?B?QXBVM21CN0dvNjh3bklLUGZ2UmdoMHMzdFB0RmpMMDl6bWo4TVpjcFRlT3dP?=
 =?utf-8?B?bmdlWitTbGErK241MnBsUFl1azFqZkZEdWovMnpPeW5PU3hpUXhRMUwzbG1p?=
 =?utf-8?B?QmI0SnREejBQOVAwU0FXNHhzeGVBUEIxbFdKZUxEQndLL01qVGpWekozUmww?=
 =?utf-8?B?aVJ1LzBSSkl5a3lzUnBkcmlXQmY2UTVtN2V6N3NIMVYwdHZaQU43dnA4L1lC?=
 =?utf-8?B?YTZSN2FHQU1kaENocVl2RXl3OUNnTzJ6eDNuS2ExMUtPWDhidktYYWxneCta?=
 =?utf-8?B?VjJpWVlyQ2g0THlUU3E4dEk1eG0wLzRmcExJSFNTK0pWNU0vYUtQTUUvdmpl?=
 =?utf-8?Q?Ds1XhomlEzi0/WtaSMpktCo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f414ff4d-75f2-4f1d-ba17-08dd1ead64c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 15:13:42.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EexR17N6iHgr4sMhJB++AO3fnNrpvbQousB2BXITe2jdK+KGkwCT2iGROfgkvnZV7NhYYFK461bTl3LgqMpAg8d3wlPzTONfbUcgrAU349w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
X-OriginatorOrg: intel.com

From: Wei Fang <wei.fang@nxp.com>
Date: Fri, 13 Dec 2024 10:17:28 +0800

> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.
> 
> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.

[...]

> @@ -163,6 +184,30 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	dma_addr_t dma;
>  	u8 flags = 0;
>  
> +	enetc_clear_tx_bd(&temp_bd);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		/* Can not support TSD and checksum offload at the same time */
> +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> +			temp_bd.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START,
> +						     skb_network_offset(skb));
> +			temp_bd.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
> +						     skb_network_header_len(skb) / 4);
> +			temp_bd.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T,
> +						      enetc_skb_is_ipv6(skb));
> +			if (enetc_skb_is_tcp(skb))
> +				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
> +							    ENETC_TXBD_L4T_TCP);
> +			else
> +				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
> +							    ENETC_TXBD_L4T_UDP);
> +			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
> +		} else {
> +			if (skb_checksum_help(skb))

Why not

		} else if (skb_checksum_help(skb)) {

?

> +				return 0;
> +		}
> +	}
> +
>  	i = tx_ring->next_to_use;
>  	txbd = ENETC_TXBD(*tx_ring, i);
>  	prefetchw(txbd);
> @@ -173,7 +218,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  
>  	temp_bd.addr = cpu_to_le64(dma);
>  	temp_bd.buf_len = cpu_to_le16(len);
> -	temp_bd.lstatus = 0;

Why is this removed and how is this change related to the checksum offload?

>  
>  	tx_swbd = &tx_ring->tx_swbd[i];
>  	tx_swbd->dma = dma;
> @@ -594,7 +638,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>  	struct enetc_bdr *tx_ring;
> -	int count, err;
> +	int count;
>  
>  	/* Queue one-step Sync packet if already locked */
>  	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> @@ -627,11 +671,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  			return NETDEV_TX_BUSY;
>  		}
>  
> -		if (skb->ip_summed == CHECKSUM_PARTIAL) {
> -			err = skb_checksum_help(skb);
> -			if (err)
> -				goto drop_packet_err;
> -		}
>  		enetc_lock_mdio();
>  		count = enetc_map_tx_buffs(tx_ring, skb);
>  		enetc_unlock_mdio();
> @@ -3274,6 +3313,7 @@ static const struct enetc_drvdata enetc_pf_data = {
>  
>  static const struct enetc_drvdata enetc4_pf_data = {
>  	.sysclk_freq = ENETC_CLK_333M,
> +	.tx_csum = 1,

Maybe make it `bool tx_csum:1` instead of u8 and assign `true` here?

>  	.pmac_offset = ENETC4_PMAC_OFFSET,
>  	.eth_ops = &enetc4_pf_ethtool_ops,
>  };
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 72fa03dbc2dd..e82eb9a9137c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -234,6 +234,7 @@ enum enetc_errata {
>  
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> +	u8 tx_csum:1;
>  	u64 sysclk_freq;
>  	const struct ethtool_ops *eth_ops;
>  };

Thanks,
Olek

