Return-Path: <netdev+bounces-84885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7D898894
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DC91F21F84
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48AF126F14;
	Thu,  4 Apr 2024 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ercya/Ga"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E84126F3A;
	Thu,  4 Apr 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236280; cv=fail; b=mq4F0Wb2qrvKwLtX5yw4nNhd7bZWNH2LEOILdlSNjatAisZygRuQH0jXBirOwFLjreTG+hQsxVmM9CTjKcSSNeZYbU9qe65eGNsqiCdt1LE5XhQwB2sCucOFH+Q0OBL0MRrzX3c+olinkraY6/jNiv6JwK/2g6gTl16qSJw3Xq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236280; c=relaxed/simple;
	bh=IeQn+BBAwi+w6JF6nEbl7EZMv5dGuqkfGKrod7MH1es=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLBG7e18+1CKhQlbTfxcCYRbMV9v59CRtayzZ0+heh5ieBipVqeEYtEraR+u5m32/jFNaTydNAO7RsasBtFB2vYMaJXe41rB3Pp9FKX5twFSDlHd9/zvsszoe8IIAqZGIUvZutz1lfN1JWJe4+eCLmd7qtFJuerEM0t2dznJZe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ercya/Ga; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712236279; x=1743772279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IeQn+BBAwi+w6JF6nEbl7EZMv5dGuqkfGKrod7MH1es=;
  b=Ercya/GavbdlQxbCie5mIoEg6zzH42/gewTo1d2wO0rdm4aLAxMVz0B8
   LkO89fBXgA5os+z2dtkMbSdKnMHcLblGWlmqkADC3FJa+awvbA0h57wHQ
   xZReTQdVmG8+ZRMW1YJzNnjgC8c7pRbrMQgR4UKQQ2Lf4hCeHrz/bqO8R
   INGiDSiR8EM4s5v0smIZIXyt7fPjsLdTSUWDgKrDTRUYzwUhZOshNj57j
   Lkv0bmcM51qJ4aBwPECc1J9zWn4zRaRxjT2B6U/+WkIEm0QPEF2IpwzyW
   MOPQKJIwuNPWVMH/FmCGiOZ9uRPyUfvda3UXWaHtnDdogr8Tt5/8Vc57w
   Q==;
X-CSE-ConnectionGUID: izzioVBfQaeBwQrzmwZaFQ==
X-CSE-MsgGUID: O57FJA35SWq38QMexnfObg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7366585"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7366585"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:11:19 -0700
X-CSE-ConnectionGUID: psOC78s4Qe+Krx7BVMneGw==
X-CSE-MsgGUID: 2j8v6NuvQxqi+/N8MqzyCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="56235759"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 06:11:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 06:11:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 06:11:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 06:11:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 06:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyEkZTVvqdTByJd7IYw+csumlBFvjuBNxGRBk3pgunwokfC8TALSM9T0r6cipsR6YL4OVDnbQNHxw/Fy/4y+qxHzjUTgY6CK1VWjOi7kxjV2HJQThnhyv0gs+N8oUCnX3HCiXglvb74vHP6KE2FcRe6Mlq9K4f0ZZN37HXNF1nqC4m71Bx9P2aaRzJnObzA8nfluyDkHV67zwX7gWaZeb3PaqYhSwF6OoLc47F/NB314AxpUhP0q1DgfdDF+jOSsNs4sYMWullrxHg4UsR5NM28C3s0ltUyZSjvK/Q3eFkGd/K7p79RZZZCvHmIWXohggkmpIiTP7LNdcZ9nVkzB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+PBr2UB4HSmK79eTJdS8uf4zEcbwN4lSNvRxVrKCXY=;
 b=UuQYFqvJF1xqh+8yiDd3xWVf6v+eCKKOg/5S40Y+pdcAw+8ppyumjEXpSDGTK4UHm1TReCvIDz4T5/iqeHsdVSZBQkv8C9pUF8VWvKYsJCEHkIHLBisXfdE9tamO8OvOMMgr4+lCA57p4vPi1HvVIufa4TbAEvKBpixQigBDPK1BYzIm2yszx758K9DcXToQyX4yF6CJelbe7voMb9urncVovHK1jXvdpCv7GZ71k/T+/2fEqn/VWIAQNZE1v3Z4zdCZVyW8UOtUNRGlyncc1LkGeg42JUT8ABPq+HUmD6RPT80fIDuHjtWf4X6QoaTZJg9Jg2ycl1bFP4cPceAvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB5209.namprd11.prod.outlook.com (2603:10b6:806:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 4 Apr
 2024 13:11:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 13:11:15 +0000
Message-ID: <ef853ce2-4e44-4a07-8dfd-6b8a2d48ad62@intel.com>
Date: Thu, 4 Apr 2024 15:09:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
 <2746b1d9-2e1f-4e66-89ed-19949a189a92@intel.com>
 <660dbe87d8797_1cf6b2083c@john.notmuch>
 <f53e02ef-ee33-4cd0-b045-a3efe7f0fae4@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <f53e02ef-ee33-4cd0-b045-a3efe7f0fae4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB5209:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idir/u7oYb6t6v8cDynDVGkjBXy5nsf0RLmAZlkoHYyCSmC1t9+/8/+YA/VgGx3ACLakdhKu2bwgVs90J/ENPOtd6636es4evqoni38k7YDNMOBbTNNA3/gp+E1b0j15FndLuWXqiXsgpAK09tcnChmdCATSy8ckO7UxXmz43YrjbEM32+4vLVj6mO7AUTSlA+RTse/2RxKTdGfiRrtmODFR7PYMekrRDcwkmcLTDIY3JcHJviXm64LnoF9SEZCsrVHuhThkKeKDeoHMQM9/rpN6Bn1b/0m2YzjzLO6bIanCsaNyf5xTiXFjYYEd64KcYWEoYAivIvcvQKDoU9DghGvX4geihWc6sOltc+TGrtNAlDfnWHZN5YwR2K8bs+LHr56dj58NS+H8L+fuVd1kNVWT12fT7dgj4yR/6G1hG+bQzJDX/F1bB8yncP8xhotod74MvUNebcLDZqsw2vv64D6OSf9Iws8TWg6TfEIPkuA/U5EV36nQc9CHhgirQBuhEz3RiFVs0CJ3dFDEY91szP6RNrR2WCUZ22sTDGGJ5zvW7JpOngTAEtSORgjHm9xxv8yQze4BhAW/Q2yEZ8KcPcO1A4f4ULAlDZtUox10mfiYziOIYfKxyvo//kjBFrmd9HzAKKnjPri8LiZDBBU5QciRxws13DRyjLj8ZrCmVAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0w5NVN0WHMvdlhMMW9lMmVVaWpoTExNcEJnK0NvWUd0WVQ0WDA5RWxiTnkv?=
 =?utf-8?B?d2Z3eC9HTFZaOXNGNEJBUExuUnBtbis2bmJueGV4OGlBemMwQUVkT3dlZkJ1?=
 =?utf-8?B?VlJ0MjNVY2NKdmpwVS9YNVdudUxic3I3ZHZsWExudTBxUXc4dERJTDNVYUda?=
 =?utf-8?B?blVrUjc2UnhTMkFYa3ZpNzNPSkRlN1kxVC9TOXhHZ0dDbjVjQURjZGxUeWRj?=
 =?utf-8?B?VnRsWS9YTXloOVJudVdzcDBBT2lxMzRLVmN2Q3k0TEs4K0pPTGljWmRBcFgz?=
 =?utf-8?B?WG9lRk81MWN1cWZUdUJZMzBZMXdRNGd0VEVtN0IxV2o3OTE5UC91SkNGcjVG?=
 =?utf-8?B?OElCZmtXZXEvSXF5dzJ2ZGFhUjg1bXRJcU85MEYwOG5HY2lhSEMyTWtNbnFa?=
 =?utf-8?B?NGQzc1BvRUZQUGFhRnRTVkd1SEFzbjRnYnF3L2FRWUxxOTNwV25rUm5FRmpn?=
 =?utf-8?B?TzhUVzhkVkdlVWQ1Smo4dG8wN3A4L045R3Y5RWs5ZEFKWHhvLzBIdUxRUk5y?=
 =?utf-8?B?KytSN2NCeTNMMklGN3RmbTNLSTQvbmRsMVR0dWZJL3VIYm1vMnArd1BVY2U3?=
 =?utf-8?B?a0lqcVByMEFhL2tFOWk5aVVyMUdtR051eDNKbDVqUFkyalZKamJ2UlJLWkNq?=
 =?utf-8?B?RVpMKytQbFZWVGhkQjFGM1BuUm9saEUwcUhiVVhNd3ZuTHlUcTh5blFWdHJY?=
 =?utf-8?B?M0M5V2JBcUFnUlNKR3RFTXc1cFpxc1hvWXh3SUowVXB1SlpldE1FV3FtckEv?=
 =?utf-8?B?VHBYQVFZKytEM0k3UkhwMDRvU1lXaGlzOUZIV3JCRitYVkpCZGFaNnpoRVc0?=
 =?utf-8?B?WjI4bHRIQVFVdGJ0bzNJSHJGa3BlNkRtRmlVTzNwcHZXc2ZhUFZ6ZU1ibzFK?=
 =?utf-8?B?Y3ZGRklaYVRuZTYwL0dUbVBOOTR5cU13aCt3SVV4SFJCYU1HTFBiWDdQaXF2?=
 =?utf-8?B?bzZheEl4cTdqTC9oV1hGSk5uUkRVLzZ2YktyM2xaN05Leno2M1hKUk1GRVN6?=
 =?utf-8?B?cUVNZVRtVUFwM2V5dEJqNEg0WWJ4S2x3UXdyZDNXS29YN2tKN2t6ZkRHeWw5?=
 =?utf-8?B?STQ4U0s0TndvTGNmUGZnT0VZOXhxd3BOdmNrNVdrV0QwNmxXN0xKcWx5R0V1?=
 =?utf-8?B?YXlYU1pVR205OTlPbnpJUXJEdXdJM1BVUk5FbjIxbXBRZERCQTJHRmtabVJw?=
 =?utf-8?B?YkhCVEdZUDRUSEdJazZIVXU4MHZFTEdEdlFEU05jVXB1QXFSWUhGTFJMTmQ4?=
 =?utf-8?B?Z0dtaHFkSUxQbERyeStCRWpTMVYrcVRoWVJJSTQxc29lZGc5aGs2Smx4NVNh?=
 =?utf-8?B?SEw1dXZFd0NnNFYzQU1TZ1B3Ujd4RUtjaVNtbkhmeFF5WnRkR3hGbHVJRWRx?=
 =?utf-8?B?WVA1dW1SZjVuaWZOMWNGSXpPMUVlMVk1OVJPTlhrZG13Zjh6SW1aSExsNFJH?=
 =?utf-8?B?ZmxCMXFjQTFyQUsxR0pEU1Q2QnZXa1hXWGgrTjd5OENud0ZoT1o1UDhFZzhP?=
 =?utf-8?B?YzFjM3FJb0dYOTByUmMzZ045YythTm1MQWxzRDFlWCtyaFhrUHNnZ3g3RTNF?=
 =?utf-8?B?dG9FVTllS2hsNnl5RGxmQWx0TlFyZHpVQUZaSUJxaWgvOUhhY1pnQjJkSDFZ?=
 =?utf-8?B?cm9pNWlPRWJ5dXQxMmZzcmVCbEV3d04xRVdXWjkvVnFiRlprdVgvVUFPVEtN?=
 =?utf-8?B?SnljWVZMWTVqQi9QbVlQV05wQ1FJODNDdWtYTXFhOGZpK2ZYODZScWo2L1I5?=
 =?utf-8?B?eUY5SDZrd2FDa3RzTjhzZVZNbDdYNDY3K3E2aWZZMDFvcjB6YlFOc1RCSHVW?=
 =?utf-8?B?YlhLTHFVRUs4MDJMUXQzd0lKWG8yWFk4Z2NkQVpKR1BXanV5L2tIb1J0Uk1s?=
 =?utf-8?B?ZzdkU1lzbkNkQTJLbFlxSzczLytQaDY0eExxQUFmcGUxUkwvbk9hUDlycnNa?=
 =?utf-8?B?WUh0V2xqWStPa09EQlA4YVRhaFFFOWlUUlBXU3NMNUU3OWI5ZEhGMG0wdm1N?=
 =?utf-8?B?cWdQb3NVYkdLWFRwY2hQYkJmTTFNbkYrSUJXdWhvQU5sb21xUHVYQ0FLNkpF?=
 =?utf-8?B?NCtMbmpCOGU5MmdxWmFtTlA3Z0RYYjM3dmxrYy8vei9RUW16VWU2SXBHNFF1?=
 =?utf-8?B?dDV4N0hSL0t1MHJyakhuSTU2VDZ3QjlYNGlnYWlzREFjVXg0OEc1QzYzcFI1?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d48c8fd-68f3-46d7-17b5-08dc54a8b500
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 13:11:15.0363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Tsqc/iOFaAiy5zJwfGP44r460589YJohY8qzlaa/o4+83zclsCKWeW6DbeOIxYZwWFH0YoGsZLg/AS7oLVFTKYFcjJsPYtiuIlj91SYE7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5209
X-OriginatorOrg: intel.com

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Thu, 4 Apr 2024 13:43:12 +0200

> 
> 
> On 03/04/2024 22.39, John Fastabend wrote:
>> Alexander Lobakin wrote:
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Date: Tue, 20 Feb 2024 22:03:39 +0100
>>>
>>>> The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
>>>> each time it is called and uses that to allocate the frames used for
>>>> the
>>>> XDP run. This works well if the syscall is used with a high repetitions
>>>> number, as it allows for efficient page recycling. However, if used
>>>> with
>>>> a small number of repetitions, the overhead of creating and tearing
>>>> down
>>>> the page pool is significant, and can even lead to system stalls if the
>>>> syscall is called in a tight loop.
>>>>
>>>> Now that we have a persistent system page pool instance, it becomes
>>>> pretty straight forward to change the test_run code to use it. The only
>>>> wrinkle is that we can no longer rely on a custom page init callback
>>>> from page_pool itself; instead, we change the test_run code to write a
>>>> random cookie value to the beginning of the page as an indicator that
>>>> the page has been initialised and can be re-used without copying the
>>>> initial data again.
>>>>
>>>> The cookie is a random 128-bit value, which means the probability that
>>>> we will get accidental collisions (which would lead to recycling the
>>>> wrong page values and reading garbage) is on the order of 2^-128. This
>>>> is in the "won't happen before the heat death of the universe"
>>>> range, so
>>>> this marking is safe for the intended usage.
>>>>
>>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>
>>> Hey,
>>>
>>> What's the status of this series, now that the window is open?
>>>
>>> Thanks,
>>> Olek
>>
>> Hi Toke,
>>
>> I read the thread from top to bottom so seems someone else notices the
>> 2^128 is unique numbers not the collision probability. Anywaays I'm still
>> a bit confused, whats the use case here? Maybe I need to understand
>> what this XDP live frame mode is better?
>>
>> Could another solution be to avoid calling BPF_TEST_RUN multiple times
>> in a row? Or perhaps have a BPF_SETUP_RUN that does the config and lets
>> BPF_TEST_RUN skip the page allocation? Another idea just have the first
>> run of BPF_TEST_RUN init a page pool and not destroy it.
>>
> 
> I like John's idea of "the first run of BPF_TEST_RUN init a page pool
> and not destroy it".  On exit we could start a work-queue that tried to
> "destroy" the PP (in the future) if it's not in use.
> 
> Page pool (PP) performance comes from having an association with a
> SINGLE RX-queue, which means no synchronization is needed then
> "allocating" new pages (from the alloc cache array).
> 
> Thus, IMHO each BPF_TEST_RUN should gets it's own PP instance, as then
> lockless PP scheme works (and we don't have to depend on NAPI /
> BH-disable).  This still works with John's idea, as we could simply have
> a list of PP instances that can be reused.

Lockless PP scheme works for percpu PPs as well via page_pool::cpuid,
seems like you missed this change?
Percpu page_pool is CPU-local, which means it absolutely can't be
accessed from several threads simultaneously.

> 
> --Jesper

Thanks,
Olek

