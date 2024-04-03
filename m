Return-Path: <netdev+bounces-84566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EE2897554
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4051C20DD0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A614A62A;
	Wed,  3 Apr 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnMJoPa2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7317C98;
	Wed,  3 Apr 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162158; cv=fail; b=EJZ7tdrUkwVx5NPhMvO6P32z7NDtcXBg2O12JG3BQORDKt5hAz9ST8vMhLkoBRbGwsjkPNw09FdFyjKF8EYvUSrM/3bdkr7JTNn24CGWWiUJAR7eWRaKVSqNSKm+2Q/l8tf8674EMD+zP6fB3f36du4WbuxpXp7YMI6DoWHucI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162158; c=relaxed/simple;
	bh=mYpyaN9BqGR5bzP9VZdfTPohFVd+z4pFjVl+L9iibSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mqn3IkG6QzDEmHU4HN/UKWah567h9hxK/k9KSxAwsyLXN3P9T0yhrJYYnITw5wdhWUtPT1+f8hZ1W+uBdpnonDnglKXHjMlUs2BEqE02rlh0CWkQCxf0lCCm1QL8mXyCJnSLsFZH+TAFW9vaiUKQfSHP/rt74GjG9WMbT/QPJNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnMJoPa2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712162157; x=1743698157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mYpyaN9BqGR5bzP9VZdfTPohFVd+z4pFjVl+L9iibSU=;
  b=PnMJoPa2O+iYvJBZL1Z8MzatFJtQBq03/DHVmgQQep9F82mHnB+M6TgJ
   opvAkWBx/QMLKTD7UhdPzl15R/cFKQXyA2s3a/mVzcNxCSYYFQrqCMi9q
   yPEHGUwnn8sTHNyDkBTfXz4f0Sr5Aiq13xGQnL2IA5FYIplCWdR1iZWqs
   gKf1xDGskQXN7ZPjTNeMEPve/7SgDEN4gZmXk51lH1nbpGvSw5Bx979bI
   0Oy2b4e0dqlrTYG0VZBd4bRHnB5fVnoUOHESb5HmnS9IfPVdlNcy2w99a
   k8wSglvpn6lFX4lkFjfcLgrTnUtPiiPEFVDudAKw00eDwTj19D8WGFhEv
   g==;
X-CSE-ConnectionGUID: Sn7A1Z9tRuaZAQqPdxkdHA==
X-CSE-MsgGUID: Ae2BBASWRoqZemCg4XJ1pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7641560"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7641560"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:35:55 -0700
X-CSE-ConnectionGUID: 5oitbbDhSfCOCGMnQnCyVA==
X-CSE-MsgGUID: wzwlZm16Qt6xWu9lA38MXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="22982003"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 09:35:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:35:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 09:35:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 09:35:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 09:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSQCj6HB5MgI+NrZgze1YMjIScVNEkwso9+WM1bWz/UFYxnIhtjI9RaDirmNGLhB2b0jKUx5eSRZUf8gl1oLAKH2f36Af9SNQ8PUtZw5jZjB4bxJP/U6YanrE/HykIjCdNZR/PjFgCU6XPiDBX+xq81vpk7zDpCHFL3ns7BtHzsh4J/0G6Ut86QybsqFvRur5AzPicrhn+Irq/RR0jVqxGye3G95A5sAvUCKlZ7DzS28EoMA5N4rc3PFlAWkFoqACL2UDBvGb5EJUE/GWw9gmcysAgS+qa+gy/haMRxcOhZC2asklwNXoP1S4vV8MpWGM0MIjNQlH87IEPaYz/1A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v3byrtQFRM8lbsytoBcz4+mdx110lEaeVIZ4R2gVZI=;
 b=Tv8XJBYjWijfnK4Asr7eDil1zlxFKTTmKPAmICFpmUrkOjXFdqDvc4hvC+e+CVGp5TwZihRhEbSG4uoCCD/vQQAuTPDq01XSi8kdP8Axeb4FbADOl1+hMReunaI/MXVL03NP8KksqIQ3pdas8DgCGbLmziQRCZIqylD8t5MABV1QC3mBxeTfyYvNc235tj3kMPCh1ST5C3gOFUnV/v98ZNHwSF2g1o20cPeotQ3wlbIYjNEXJ/lZZYQQdhWgVqG/3DHP+hxLNj+yx2dQZ6HuCXZfu21aBeBCIkWCxhSDMJjXs81D9yr94Ndw4CDppr1qr1wtem5EITMU3r3zULxBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Wed, 3 Apr
 2024 16:35:46 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 16:35:46 +0000
Message-ID: <2746b1d9-2e1f-4e66-89ed-19949a189a92@intel.com>
Date: Wed, 3 Apr 2024 18:34:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240220210342.40267-3-toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7629:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Trh4caSWFAUWs30fCUUT5zd6RjUm3zwVuht7i0bjyzxceOmCIY0KDlYJrY8JdpHYwKMRetYGP+UTWinhytzFIOzDTMw7c2UTZ+0i38+IiuRjJLCfFjCAeBL6cddv1Cewxwoo9jJcxloQFry2xs7WgZFk3heQLunegQOzRgr4gMkP/OQmhBV4+m0T/nuDNtLqZgI/QtxLUecxaqvNKpTSa7BeydmwEH2uuEigh53PeigsxOrouXVn/Pp1DzYrVkqrwyA/u1M3AuYP1MhLuFUt2Pvc2rHlYFuPfeeCL92M5bPTIlNOIl1GsJR+LNIXRPSpvyNkwaxzLr9SKP/nN03rr0kG/wG1vbzTAp/M+//r7QcjUvbNRfjhCE0jALS/CSiFQ1Ev0VcSqIY/LR/jl0i5YhQUtkRzSvvwBO5zCcxCjal/upBdpAsExhZjnfs+bXnDCfhWCULex/yfOdaxKmGNx2W55CV+ueg0g5qgJfZeJx7J3pywUpnyAbMrCvOiLQJHAmSB20W6XxDKi9JFihuJY15Y2SLzpeAnrJeaHeVmgyzhf3Mmp01taC1ioCJVSB+e0B1FjMKbvgy4JmGX0DqQYEr1Ap8HxTut98HSfFiovBjwpWmRsvwCh6JbnwJR16IpTPIx0il6rcq0bg6uw5ooQBty7yAxWiXhNuDcjKTIFV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTYvZVV1STdlQS9iR203czFPYTM1L0N3OG4vUmVQRWFhL0tlS0hEcUlvbVhO?=
 =?utf-8?B?VkhHWW5JQVBSbkVBRENKTktyTzRoa1dMbElseXhDUERtK3NhSTVmZ3FERWFO?=
 =?utf-8?B?ajlaTGNySFlHeVdCTjNsSVZFWnZocFIySFpBT25aZUNxNU1IYnpIdFVpYnhy?=
 =?utf-8?B?NWlmeGNpWFl5UXNZa2dJdG1IT09RSHhtQlJIMk1KVXJ5TkEzU2xhcWRBYVUr?=
 =?utf-8?B?a0xvZGZwK0V3NGlDbysweDFueEg2Mmw0b1FoWVdLeHlhZytCYnJhNm1LMGFL?=
 =?utf-8?B?bVRzRHFzSVlxQkt4aUxaL3JzWUNUN0M3SUtDbkkzdVY5NzVTRzl4ZDBRTHBh?=
 =?utf-8?B?ckM3bkdTVHYxbUFQZzhTNTZpSmp0ZVM0bzUzNGJxVU9CQVF4c294ZWVPN0NU?=
 =?utf-8?B?Z3Y1ODdJTllwYmU5YTYvZ3k1ampjYllCL0VvdHFyemxoRGtQYjNZNG1zT0Js?=
 =?utf-8?B?RENwK1FodzFHWFlPM0VFWGF0Sm85SFIxRzNqWExDZFd5OWVNWEk0Unp5blk1?=
 =?utf-8?B?a3FscXpYVGZxcTFxVHpVdncrREo3em1NMzNiNnZDaFoyN1lieGsrTk5SaTBE?=
 =?utf-8?B?SUExQUY2YmNpMDZ0RUM4TEszNUxoS0JPNGgraVFiM0tpRWpzMWp5VUxINGpp?=
 =?utf-8?B?NkI5d1NrZkw5MTY3NDl3K0l2U1lLa3AvZ1FWM2hFYzJISmlMTlM4WVFuUXhj?=
 =?utf-8?B?MzJNeWcyVUx1SGdhaXBOU0hac0tmU1Joc0dJMFZmK242MlhVazlFT1hQUmtk?=
 =?utf-8?B?OWh1aEM0a0Z2NkRyZUJjdmZkZ1VpUFRLMzFIanVqOWNoWW1idnJaUUkwdVhM?=
 =?utf-8?B?T3NoV3RrVFRvVGJvWlFGYnZtUmROeXVXa1dlZ3kzS3BBRVN5RVRTRlM4WHFL?=
 =?utf-8?B?V1Y1bTh2OGZ1ak5pbThmVEF1by95VWwwSjJ2bjdpTWZrVkc3bWVZbzVlNk1x?=
 =?utf-8?B?eEhwdXdFcjV6QTNDVmJOMHAvZUx3cys4MjRwejJXd2RucXBBeFR0RVo0MVpJ?=
 =?utf-8?B?a1d3Ty84TXo3TThOcStwRTVTMjFqeXZYNGdtVGhKSnpuT1dnVFFqcHJkRDBa?=
 =?utf-8?B?NjU3WURrR3huYkJ0NXBLc3ZxYnE4aW9TeThDVEc5cUxaYXVJMVZhUkVhWW9I?=
 =?utf-8?B?aktOZFZLbXMxenh2bzRqVkZHdHBZVHBrNW85Q3E4NGRpVzJJcEVhcld5T1lT?=
 =?utf-8?B?dXRzV3lsaE01NVRhZ2VFMTd5d1JvbFpKNFB4NFBGVDhIeWtJbUJJejVFL2t6?=
 =?utf-8?B?UEdkT3RJOHVUWkkxSTMybWd3OC92VDR0bGh6dHUyVVBIM2ZlTC9aVnQ1K1Yw?=
 =?utf-8?B?NkJEMjlwSUhPajlWRmFDbnNIekJaaGpyMVduRk5PNzN6eHZaZlR6Zm9MNnU3?=
 =?utf-8?B?N0NpWnMvWmVVR1VlY1NwSGx1ODM0MjZvQmcwSXhzNThxdmxOVlpUWTIyVkJU?=
 =?utf-8?B?ZjB2R1hkQVZoWk9Fb2N5MzB4VEZjVGc1cm9tR1J6VzBvWVJCS1lzNnZGVGl3?=
 =?utf-8?B?YlpKbi9meGc2LzhPSEdWeHF5Y3ZzMm1xZ2FmTE9GaTdRRmhwV2ZDb1B6Wkpv?=
 =?utf-8?B?SnBCQ2J4dmN4YTM4Wlh5VXJlWDlPdzlKZkMxQTVvcElNL0l3WU1tS0FxbE1h?=
 =?utf-8?B?R1BScWhNZE9FMzNzcW1yRGtPVVFKaXhvci9QangzajAyNTJGeHlwNlMvZXEz?=
 =?utf-8?B?K3duNmw3aWQ4NkREaUdleDFnaVpxOHhKcndCSmNwUHpUOXFjZFh1dHI3OWpt?=
 =?utf-8?B?bXk4eGhheGRxSXp0RmxjZVhvdndBbURHTlBCd0NlQlhBbVhkR1lDdnJuMzhu?=
 =?utf-8?B?S1V6YXk0TVNWdTFPRUNiRXg5dlN5U3ZXY3F0ZEpWRHNzTGpOcVdNTEhwVVk0?=
 =?utf-8?B?VDdBWG9LZ1ZIb3I5anlZN2M1YjJUcy9qc2l5eUZMM3R5T2NyN3Z2VFFvYzFD?=
 =?utf-8?B?LzRSVWIyM3FwVGowYm44aDhyNlhhTHQ2aHR3UG9mY1gyRGdLYkR3bXhTcXlp?=
 =?utf-8?B?WGwrNzFCV2UzK3dUSWNFeGNqZFg1bDBiS2JmLytJajBsQVd3NEpYb3U3SDlV?=
 =?utf-8?B?Q0ZqMjhuSERtWEcwZ29DSTVCVGdtbzVDSnpHRUQrL3NlcXNJNFluT0dVZm5U?=
 =?utf-8?B?NXg2eE4rdkNXMzB3Q3lvWlVGVVIvUENlKzZsdXQ2SC9xWHBYVUgvenRMeFdx?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acf55d6-97a2-4275-908e-08dc53fc1ce9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 16:35:46.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEgSiZxmrPgGq31/SyvjMilaxvMIgIxMkxSPViHCJuM23AvO0MADQiSqujabMThVPOaiFQ+Zdfve2WkhEO6iCD1hBPFzbc6+0oZb82GwDGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Tue, 20 Feb 2024 22:03:39 +0100

> The BPF_TEST_RUN code in XDP live frame mode creates a new page pool
> each time it is called and uses that to allocate the frames used for the
> XDP run. This works well if the syscall is used with a high repetitions
> number, as it allows for efficient page recycling. However, if used with
> a small number of repetitions, the overhead of creating and tearing down
> the page pool is significant, and can even lead to system stalls if the
> syscall is called in a tight loop.
> 
> Now that we have a persistent system page pool instance, it becomes
> pretty straight forward to change the test_run code to use it. The only
> wrinkle is that we can no longer rely on a custom page init callback
> from page_pool itself; instead, we change the test_run code to write a
> random cookie value to the beginning of the page as an indicator that
> the page has been initialised and can be re-used without copying the
> initial data again.
> 
> The cookie is a random 128-bit value, which means the probability that
> we will get accidental collisions (which would lead to recycling the
> wrong page values and reading garbage) is on the order of 2^-128. This
> is in the "won't happen before the heat death of the universe" range, so
> this marking is safe for the intended usage.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Hey,

What's the status of this series, now that the window is open?

Thanks,
Olek

