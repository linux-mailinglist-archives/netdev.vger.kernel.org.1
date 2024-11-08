Return-Path: <netdev+bounces-143138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971B39C13B7
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D29F281622
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8012E7E;
	Fri,  8 Nov 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+guq0PS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339A7462
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029875; cv=fail; b=sOm87TW8ViBJG7DXgHhU/CARiLwdUNDMGcITZ3EQn3sYxGcqygCNfnI6MR2wgTq6UoYcbBLAfJ846Nd06B8d7ewC7Wqz7LQxLqpJpdOOaTpvhCbf9ZDYUeBrcG9a88rEL3j/5S2+uiTuUArmNjuUQcDYGlAAWTandP+ktbTHgFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029875; c=relaxed/simple;
	bh=WLWYI4b66/AQlNTRcAYaBwjtQMMXpeBA2+lA0MBoIzM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMh1ZnTmLJKICpyUvx9+/AoLZpeVuuuyMmUlq5zz63yDzBvJHfKTEYPWYp2ju1C96HmMgDUFMupOOjgJtM4QWGVIRUuuaOxqvnOKL6G99ZGWGP1nOTtoXlGLqNoNXhufrCL/nmsypCTUm//DvVmNg4tvSaHpnRTTIO36+Ut4h7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+guq0PS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731029874; x=1762565874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLWYI4b66/AQlNTRcAYaBwjtQMMXpeBA2+lA0MBoIzM=;
  b=O+guq0PSgPeoRdpkk43Emo8avCUboAcQDl7btA1mBwQwRS87N5ryWhu+
   9jSg+90Blk1DRqh5MwvBtrYQnL49Diy40CUyzarzUM4eWRGCivqGnqvf6
   wqA14c8/Q63bI8Or26mvNhMgZs8ROnssoe72aYTUKznLtm/+C/vYZWLfK
   6+OLkcyTgd66PoSTVAYTvgTj5e+w11BTo/RMW1hHtcILw736Fd5d2ZY58
   Co1vieN//y197Ka7KWmDMGdEeUaYqLkbSl4aXfHB3N1BeqQvIxgoTC1ga
   ADOK+LltHLGUVoR2/6qldcrwK0f93KTTtt3gwmnpn4MwN7IvETkv7jwF6
   w==;
X-CSE-ConnectionGUID: 5p1bqv6pQ5OAD5VHcUhlmg==
X-CSE-MsgGUID: WuGAtNtYS+SIBIycNOV0jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30676879"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30676879"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 17:37:53 -0800
X-CSE-ConnectionGUID: KMAsezGATY6iae4pMimMHQ==
X-CSE-MsgGUID: xN+rCSi/S4GxPjo06gAbPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="90447270"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 17:37:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 17:37:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 17:37:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 17:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xiya7KyX82Kv1+eoTF0TxjulHW5AYmFxKUuBqDNy/abXn1WkLqkdh96UDnLfRXhI6bG5f8u41IrV48kRfQyv1Mse1mUlsgofiI1ETgsTC9ZRo7MEkF7+ZCYkqzuL3HPT3uj0TU9A+qsy/ZHSiIGrdzU1U6FegIc+LbmdS3px5YmMGpTxB/ZNqJaTVRZw3dc2pxsv4SIFYBRfImOj37QAXXyGTfVJrrEBAv9lZ0NUciC3zSzZ/GB/aQrajczIZn0A0vp+Qn9y4B/xWHn54rDkbYSpVWUOko1p4k9VUJ4L0sYNvbv+yEOERvqBE0wQQI8VVSu8T2OhVbF/QkmwV+mVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KfEe97UPD8KdviYI31YHiy/6F2RCmYScZl4VEak3Is=;
 b=mll/zToa/zMly3SZyMk6FvC1oQtV61PYCv7b7GKDmJx/i0zYP0Liy8RBXtugmJkddVOnxCpZNC4v0Pk8eGY/SaEKWa5URF60hNdSWz0twRDdLKpV049rfSjWmcBN/PRnNeEZN+mmpYqQX9MqHI2sWmIir3tAq2ZsxMouZDdqQezMMo+6jniuoJ0pBwZGvnsuQ0bu2e+tk4SS+Xj4l5QKzNUnoPKRjxeIxgpZSGnuwOI+hrL6b/S4p15VPOokblltL/KHqQgcY9q2WSEuomQ3bzqJ78wGeLMtzRFdn3duOyC8GpOb+tUkHuNHNVAVyJgChCbOzgAn+IsjGAyqkVS0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 01:37:45 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::6a5:f5cc:b864:a4c0%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 01:37:43 +0000
Message-ID: <7aad3452-a08c-4c28-9bd9-3fa1cd1f9b39@intel.com>
Date: Thu, 7 Nov 2024 17:37:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] ice: Add E830 checksum offload support
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Alice Michael
	<alice.michael@intel.com>, Eric Joyner <eric.joyner@intel.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
 <20241105222351.3320587-2-anthony.l.nguyen@intel.com>
 <20241106180839.6df5c40e@kernel.org>
Content-Language: en-US
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <20241106180839.6df5c40e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|MW4PR11MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3b6d71-39b1-4fe9-8075-08dcff95f0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anhjRHl6VzVYL3NqcWQvNzhtQkxKSEs5SWpseWF1V2tIbWk2cU5uZW9lK3l2?=
 =?utf-8?B?bmVLcDIzZ1R1a25rZ1FSL3VEaitudkk3RnhyeDYwcitXMnVRaDRiODZ0MVBJ?=
 =?utf-8?B?TTNlUis1NTZzTm9iUEliOTVHcXJNTDJvTHdzeXo2L2krNDRkbEpwam1aZzJ4?=
 =?utf-8?B?TFpFWWRYUlJRd2pleDZRR3hVRWhGbE9JWkpJZ1JmYnlhbGNFUXN4eHlkZGxz?=
 =?utf-8?B?WEtHUlNXYUZMdGxObTVFVG81bEVoWFZmbWRQYXBRYUFxbDBuZFdxOEJnTzZ3?=
 =?utf-8?B?M1BEMkFmTDZlMHIrU0pGNG1nL2hJUkFFemhmdGxvRXF0SVZ5V2xYMkVWdEJH?=
 =?utf-8?B?UGNZbm9oVUNSZUF3bmdvUDZPYkx2Zm9ERDVnU2xKZnFBek1VRy9yUnVGMHdM?=
 =?utf-8?B?VG1wZXBUS3ZtK2RRWVZZWkRER3NuOGdURngxUjYrQXFSUWxZbUpONUtNTjlR?=
 =?utf-8?B?d0Nqd01sVjhkeiszVUgyRTd1TEdYOUVrejU2MDVNMnRla0RGNHFEQ01yenpJ?=
 =?utf-8?B?dXJGcUhjNHNQZTdmN2x3Sjl0YVk0VHhVWHFTdVdTVXE2bkc4VGZzTjkxallr?=
 =?utf-8?B?NU42VndRNUhjKzRYU25zb0srU25LRFU2NGtaSEw3MXlaQUpiekFLSHJjRGhy?=
 =?utf-8?B?bXdJYjZKS2Q1RFZmUTlwYThJaUFBaXlKWlZYZExoR2VWTVhEZVpsS0VQTnZL?=
 =?utf-8?B?TG5uMlRWUE1TZWJyN3QzL0tjNkFIYlNUbHJPQm1DOTJFSVp5elZOcFU5aVo2?=
 =?utf-8?B?UzBkQk1DSktHb2VLUFIzbUF0QUpnVVdIejVZcmpoRlhoRDJ5aEpjWEdSTjJT?=
 =?utf-8?B?TEh4bE5zb2E0WlFjbXFOTW90V1Y2WjBmaWJpTlhCMDhJclROc0Q2NU1tVWts?=
 =?utf-8?B?LzVxSGV1NDJ1VzdsV21iQ3NBbGNBa3N3cmFad1dJc25MZTl4eVNjZkFMemU1?=
 =?utf-8?B?a3UvT2ZkdzZGUVdmNFcrUTh0VXB5YUJQVGlUeE9wWFJTZFRRUDFSVFRrUTVD?=
 =?utf-8?B?WFl2V0pzak9VZFpHRzdnZ2FXN0hQTzdYSzd3cnZHaUJ1dEJzZnFMTnkxbzR4?=
 =?utf-8?B?U2VldTUzc2NDRjVGKzlKTjYxRHZ2eUpLbkc3OHZqeUZrTVQxVk1PNkpBcjhZ?=
 =?utf-8?B?OXR3cmFZZzJwT1BLZEptNkdJYkxLSWhKMWlVZmw1QTcvM3hBLytpNmpVanVh?=
 =?utf-8?B?bHVGeDJpQkwySjlDYVVLSDFEMjduY3d6bkxCMVVvdkRQckp2bjFtN2VvZy9o?=
 =?utf-8?B?cEFrKzVJT0Z6Zkt2Vk9Zd3FxeU4vdUVPK2dqcktDQnF5cFAvUjhoS0ZQQitE?=
 =?utf-8?B?VmFaMHVoZ3NNT1BSNm1aWkZ1bXA0ZnVMU2VjcjUvU3VzTWswalJkd09MKzQr?=
 =?utf-8?B?elNlQ1ozditTNkZtZTI3SDhXMWIzWFRZVWJxVUMwUTV6ZHFwemFnZ2REcVBI?=
 =?utf-8?B?VWh0Zk5kVm9HazVsT3pHS3FST0xvMkREbWxwTG9ZS3lmNmI0SHRzakVwejNR?=
 =?utf-8?B?a0xRRldtUHZnUmJ1Nm5BV3pKbTZYMFFNcldHelcxMDNtY3o3NzlXcUttUjdY?=
 =?utf-8?B?Slo4Qi9NeEp2YUNROUlOeDZzL254VncvRHBYblA0cEJHVWJkUFhuVncrOTlV?=
 =?utf-8?B?djBGcGw1ZDFUYnVpWTJTQ0kzMFZINGlOb01KZWUzL3ZDNFhnQ28xOTJmdisv?=
 =?utf-8?B?OFQ3TXp4cisyVGlCeE43Q1RIV1VyLzZST1ROd0dSYnhaZlZoOGFCVzhMVG00?=
 =?utf-8?Q?cHxaD+hTvnKl/BInf/8VdmaDrtAWSosV8/YjPRF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdDTjZZQlRsRC9TZDV6NytmalU2OFN1ZzAyWDYrTW9iZXdacXljS2RmOFA4?=
 =?utf-8?B?U2pKaVVvQ2ZuUzJzb0hacHBoVVJERnNkS2pFT2U1MWYxa0x6UXUwYk1LR21T?=
 =?utf-8?B?VUtDRG42TmdDTG5qWEZZMlFsWFhxczI3a1ZBMFNGRE9kNTU4cHo4ZXhUVGlQ?=
 =?utf-8?B?RWJBZGhjMDRSQyttbER5NHVOdmkvTVMwTnBaQWVTR05wekoxVUEzVWVkNkVn?=
 =?utf-8?B?NDZRRXVia1VLOUxQOThDdlNUeklOMVNwRGhVbXc4V2haT21xaXRLeXpHK00w?=
 =?utf-8?B?MVJ2bncrdUYwTTNkRmpoVnZuWi9tODYySGZ5UVdDVXlkZGR6eXBDOWZZOGNI?=
 =?utf-8?B?QVkrQ0pqTHVXK0t0MnBCNHZ1VVY3c1ZpdkdRNHpsZXkwcmZvK3NYK3VpVXA4?=
 =?utf-8?B?MDJIRXFhSFNUc0hmVlZWOVRxTmd4elFmcVBIdHBJUXZpNXQ2ODF2MzArb2dO?=
 =?utf-8?B?YXBUallkQjM2LzVwWEVXWm9EMUhQaW4wQUJXTVhRMmdqQzMxalBWL1AzMWFq?=
 =?utf-8?B?aUEzdUg0WXBONVh0a3hSeTFBalZiOHZnTmVZK2szOGphdVJmQzRJSkVVWCtE?=
 =?utf-8?B?YTBtRzBza2VYOE9QZjJQZkpQVnh4eXpoUlZRMWFaVzdQekZtY2R5RTVIbW02?=
 =?utf-8?B?dmtybTcxZzNxU2xPazF3TGUwNkZJdEZNRUlrNWJRWDJBU2tGamhWbUwxaWRF?=
 =?utf-8?B?emUzaUN2alk1YjJOdm1nTlhiR1FNU2dkbUpSSGhNbW1wTVByME5DMHQ1QkVh?=
 =?utf-8?B?a0Q3ekVIaWxScmU1Zm1wNG8rdUpJaFlUS2ZzYmZ5aDJhRDVMQXNickVVbzAv?=
 =?utf-8?B?RWNpZGR3Y1RYVXZwZmZ2WlJDc3VpNDJXempSczB2a3dUZ2w4dU12a1Fob2Zs?=
 =?utf-8?B?bkNvT2t4ZGVpWUd0cU9sVzIvaXVIamVhSVBTa09JL0lJblhGQ0RwZmYxUW5U?=
 =?utf-8?B?amdMT1ZHbzJnVXZaZTVnSm00a1dPVnRKWE0vbzI3aUtWNEJzU01PWmpkQ2s4?=
 =?utf-8?B?RU42SzVmM2d6MFVCSldnWm5RenFsSGxtQ3NKb1pNOHduUVErWk04ak9YUUtk?=
 =?utf-8?B?NWpGNXByR0NRTjlrZXNyRXdvMXVDZEFYMWtwUEZ0SVB4dkoxazhQL1RiVlRG?=
 =?utf-8?B?ZHVQVW1aN1AwaXB0Z1RGSStJbE1XbnlaQ3hWeTVvSS9HZ0t1TzFkZEY3OHI2?=
 =?utf-8?B?VWFoeWZDaDBicFkyOUp5SWxmdm9GN0xGOVRocUtWRlYrQXB6dU5RTGtMQnBS?=
 =?utf-8?B?byt6MGVTanFSSStlbTV5bTBpVEs2OWx5SDVYTllaSThrQ3dub0VlOUR4d0J6?=
 =?utf-8?B?WU5QajQzdFVKdDVmVmtBL3BzZFN3S2l4NkpiNkQ0WTFTRU9QUlJFd25HbHdE?=
 =?utf-8?B?RU4vbGw5ZzUvS0lGdTdWVzY5cUNOZE5NZXJicWNiOHBkc0lJRVVXa0k4WWh1?=
 =?utf-8?B?dDljdG1md1VvcWVVUDZGSDJSNTNScDBZKzhDSGhqVWE5cnlONDVHdmthT3RP?=
 =?utf-8?B?eThWZmFmMmc1RUwxTWdOUFJLbGx1QmlxQ1BvWU93ZjNkRS9PUENTM1NMQWJK?=
 =?utf-8?B?d0dBd0kwUjA0RjNZbU9UTkFwZW91QW04Ym82K1V6M3BoZWxkWURWcXoyRWpO?=
 =?utf-8?B?cGE5b3F0aDMxOEdLNUpiMUFteERNdnloTFhqOXdKR0hvbHZKWVhpYk96RTd3?=
 =?utf-8?B?MmU0ME9QRlRzOFdTalhlZG4xc21LZ092S3VDdjlZelY2MjJ2Z3E1SGUzR3BM?=
 =?utf-8?B?WWE5RElTWHRNR1B0RnppWllUMHZSRGVtVTRURTlMVkE2VkY3eTlBellkNXR4?=
 =?utf-8?B?ZENGRXAyM3IyNXBSUEtiK0Q4RGRZOWtBWXpuWG9abGdRUm1ibVJrcjljWEo0?=
 =?utf-8?B?NHV6T2lHY0xGSjRhMlFmeGFxeFc1WThxRnJnZlkxaHkzVzN2K1hUQWtVWkZz?=
 =?utf-8?B?ZEpyN25zZXhJRW8xOUF6YWkwZi9nTW5DNzlOL1hNb2tPVm9DOVNyeHdTdlhU?=
 =?utf-8?B?Um5ROE1DMFU1K21Dbk04clliMGcxcTFBdXkvRnQzNXNybFR3RzFpaVErK3RO?=
 =?utf-8?B?SzJVam5aQlRyWHcvaDAxcWNvVVlmVWxxWDNFdm0xb3g4TnpsT1NaYjV6R1Rr?=
 =?utf-8?B?VzVnNG5sYW85SEFubEpNTlBBS3h2bnRQd0c5ai9GcDVjeVA3TXhxR0RaNTZt?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3b6d71-39b1-4fe9-8075-08dcff95f0d2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 01:37:43.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL0EGtrMkCvhnw46jRcI5hoebbbepzeGzJNZRMYMAG2juVxl4ElsYdhTfHibCDVZElY0mwlSX5EKDYYc3vTiie4K8hjlvlQGfoHZcKKGEPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
X-OriginatorOrg: intel.com



On 11/6/2024 6:08 PM, Jakub Kicinski wrote:
> On Tue,  5 Nov 2024 14:23:35 -0800 Tony Nguyen wrote:
>> +static netdev_features_t
>> +ice_fix_features_gcs(struct net_device *netdev, netdev_features_t features)
>> +{
>> +	if (!((features & NETIF_F_HW_CSUM) && (features & NETIF_F_ALL_TSO)))
>> +		return features;
>> +
>> +	if (netdev->features & NETIF_F_HW_CSUM) {
>> +		netdev_warn(netdev, "Dropping TSO. TSO and HW checksum are mutually exclusive.\n");
>> +		features &= ~NETIF_F_ALL_TSO;
>> +	} else {
>> +		netdev_warn(netdev, "Dropping HW checksum. TSO and HW checksum are mutually exclusive.\n");
>> +		features &= ~NETIF_F_HW_CSUM;
>> +	}
> 
> why dropping what the user requested with a warning and not just return
> an error from ice_set_features()?

Hi Jakub,

I took this approach of reducing the feature set to resolve the device
NETIF_F_HW_CSUM and NETIF_F_ALL_TSO feature limitation, which seemed
consistent with the guidance in the netdev-features documentation.

Thanks,
Paul


