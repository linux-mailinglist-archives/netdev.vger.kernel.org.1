Return-Path: <netdev+bounces-90840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CEA8B0679
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9058D287525
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544E158DBC;
	Wed, 24 Apr 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLYCIrxD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8506158D9A;
	Wed, 24 Apr 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952460; cv=fail; b=XeTHGEnw8YnVxMYWhwHlxicgHE3XELIxWYhPaK9h0o24Ahwg3vfUYq0bN0CT/bFd4k3KFEG0hOptWX6B5MGF7KbMY6V03L3/cOVTywMJr0LvyQt5EuXA3GfAyRlk6rC132Q6/Gu/VjQLrH/AFnk36f+RVySUPjY4QQdTfteQUxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952460; c=relaxed/simple;
	bh=+CAyHYCqpxnJ5ul+SL3xqeOW0AnkahcOI+sZoravvSM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6z/6Fqncof1Kon46q+ne7aBWdLDKAxV841jwHhXI67ZYzUDcklJ/3Ij8iP3M7UxkewdaeH0Y5+vy5l/ZgDDa/8dGeOb7oztQCa2rRD8RDeJ97I4Y0vuLTL3N3s0mjAeRwgts3DnMqx5olYPHVTOplY9ciQY1ks1pcy4Ma56Sik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLYCIrxD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713952459; x=1745488459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+CAyHYCqpxnJ5ul+SL3xqeOW0AnkahcOI+sZoravvSM=;
  b=CLYCIrxD21VgGQeGJuGdymmLMKnef2Napukjqm++7A/b6Hx+5hUgBbU3
   Ddke/7SBNbtisfiHpZ+6cyHdbrhWc7QulFenyI/t81OJGMskYZVSYlmGI
   ps2UtDGtG2TLu6nqR+j/pxnhhSoBikUoTbP9Narm346JC+acVYsdgmcpf
   K5djqqVVLqCsa9cq192XYdI1OaLk26q30VSP12Ink462qLKorOAYhOhth
   ICldW3z3pTkDChyYlLGzmFuqACaQogslYqP2DZPAiK+9TvUbTOt4jGr6J
   C7aGYmdmA1yzMLhSMkAwMJtJ4biP0UdKcVEP68jNljtzbv09Q0V8H/arB
   A==;
X-CSE-ConnectionGUID: bBvSZGiNQ+uPFAaQKQtt+g==
X-CSE-MsgGUID: qWeIUE6QTE68ZBtpbeYSAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9444780"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="9444780"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:54:18 -0700
X-CSE-ConnectionGUID: n7tSIqePQRaCj+NpFNJb9Q==
X-CSE-MsgGUID: /uBGcOdqS/GJhzVsdOA+9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24627799"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:54:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:54:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:54:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:54:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKbwuR8u5DeADy8TyOTnt4ZvL4crmP+FNM6SyuTw66DnMh/RvHdgnrOKhLevC2s/gCEPEysPU5YSPmMsMaDFK4skHyfrMZiPoz3P/0bmkJ9X7Z+rbNDc1esoJDk9PNuROU4eyDh8gfp4ntLoI6dgdnBXUMqRVyykOJv6FzRmYkvUsJ3GMMkk2y6FsvCqdBQmVXGSEK3xX3KXlHyrekX4iTU9Ls7Qr02hOsUgyEvZx3PbPD2ldCgfn/5D7XG81C2DJV8uVOMUYz5RRUecyzMtOfEGlavuHV45qaB9AhkJsW9ylz2qbusco+cLbBBj8g1e3M3sBMp3ygl+tZ+1w6Mi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAGaCmNtGSNMdDDHTSRGGtM+wcXAyK9nJGqySiUJ04g=;
 b=fvBuof7I0TXGFB8sKShEgh/Qn8J4g8S8EnLmRDZTR1LMpYTalOEwzWpdUX8N9JkBvVxJTZ0USCph91aeg5aEuDj9Ugts3Dqx8sp+f1dhyPKkCaEyp2gmT7mb1tbAUPE4I/B6eNglBa1aOlXsI91Agq+mTpg+S5zY58nni5mVRf3k75FtJrke/RP5wdkKcLr+MFOuQAQy8RbRPQB5zOGsft0QrRozgH6+UJlM3Wrb3/4jozyS/Bu34+vvt3fmHgVYdOeBlE5BG9YYM+rh5kHnpftTmzLu5ltSKrhH4ou8iyTzP19G2YGgJr4Cl3T2txx20dEZClElMNuVK3tlj1DyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Wed, 24 Apr
 2024 09:54:15 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b3ae:22db:87f1:2b57%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 09:54:14 +0000
Message-ID: <263b96d6-692e-4e2b-87dd-cf70a8818cbb@intel.com>
Date: Wed, 24 Apr 2024 11:54:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] ice: Document tx_scheduling_layers parameter
To: Bagas Sanjaya <bagasdotme@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>
CC: Michal Wilczynski <michal.wilczynski@intel.com>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-7-anthony.l.nguyen@intel.com>
 <ZierbWCemdgRNIuc@archie.me>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <ZierbWCemdgRNIuc@archie.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: c1834007-9625-49ca-dc41-08dc64447ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2ZkNk8zbUlMelc0RytTbmRKMXJRK1REYTN4cHpuUlU0bXZ2UmdDMFdHMGox?=
 =?utf-8?B?UERoS3FNZWtpRzZLRFQ1QU8vT0Y4bjNiQjNvUnFJWllvWjdYSXhFelQ0cHRt?=
 =?utf-8?B?QndxcktRN1dIZHMzV0tNdVpXRHd4bXRFR0UxeFRXM1RDdHZTZytxVTVyaFl6?=
 =?utf-8?B?WTMrU3A3SVFraEhUK3E2ZzRxYVRHckFGMlB2MGIvZjY3b1ZPQ3MvTmt5VjJ6?=
 =?utf-8?B?RGFYOG1uaTM3SW1BTjJ0M21OZmM4S3FCZnlXTUVXV212SXJvRU9vTHBQaWE5?=
 =?utf-8?B?Y3VzdjVMZGsvUUhkdnRySXhPRlZsQXRzRkZHa1hFMTV4TVFaQlhJdTcydG04?=
 =?utf-8?B?cDdjSVdSUjVRQ0I2bzhwTWxZMStTQWd1cFUyYmJjSUQzN25xVzlmMGNMVmVY?=
 =?utf-8?B?TjRUdlprbllweXNEQWFWVlM0NWlCVTIwVjczSmEySDdJVTh2aXpzVklOcXNF?=
 =?utf-8?B?czM2WFJSeGNQRE0yVzhOQzBUWm1UY3crMFFidkdua0wyRjg5R3BiaVh0OElx?=
 =?utf-8?B?Rkhlb055RVFGV2YxT1lhMk5CM3BHa2RwTXdmV1ZDREdyeVZ0dWFIRHpZbjhK?=
 =?utf-8?B?V2p2emwwaS9UNkpWRnRMS0h2WkU1QXlqZnJaLy9FcWpoYVlPVDg5alRIUW5K?=
 =?utf-8?B?amhXd0ptZ1Y4aFdPdlVIcVZEQ3dETENPcjlVSUxjWUpyU3JJb3RsaUJqNW1u?=
 =?utf-8?B?cTFSUWw2OVNzbDNxZkk3bVNpN3dVUzFGNk0rYkc3U2JBUmVjRzBhT2ZjdTBF?=
 =?utf-8?B?SUdKWnlkWHc4OHJwTHhXOElkaFdSTVB5eHAyZDVwTFNaQW9WTkxrS01lNGdT?=
 =?utf-8?B?RmVBMVZpVk0rbG0ra0RMUnJSdkFVVDFwUk9OekIyUzJBekU5UjZjZFo1aUpw?=
 =?utf-8?B?YnBkNEdtUDBRLzBBc1FTUEdxaEYvK1JLK01PNHJ0eVlpcnEvY29rNVplMVdY?=
 =?utf-8?B?ckF4MFNoOHVXZGV6WlIyN2ZkU1hzNnVoaUNTbzZuRWhCQzJidFE2RXZBb0dY?=
 =?utf-8?B?MCtkcVFxMVJLR0VBVkIyR2dRTFpKaEdEcnR3SUI2eURTc2J0MGNndlVHakRR?=
 =?utf-8?B?Z2pUSG1WKzBKdU84ZVJacllCU3BLb0tJb2pMZkk1ZkVRUkpEL3ZNMVE5SzYy?=
 =?utf-8?B?dEs3QmJBcDB2cXNXR0N3NnVrMjJrRTR5UEhmcy8zTzJTKyt5aVp3VXM2QVRI?=
 =?utf-8?B?S0s0ZU16VitBN0JWZWY3WkxxckZ4R0VmK1ZUMGRoVW9Lbk5BcmVxVTY0VW1W?=
 =?utf-8?B?K2RIaVRFR0FzNVhtSlVERHdORXFQSkk0eXNCQk82MVZVb2xJRUExclYvSFVB?=
 =?utf-8?B?a3hWU3BkVi9RaTcrLzFWUmxsMFFsNWRRb0MzRkU1cnNRR0JUQnRRSEJTQjBw?=
 =?utf-8?B?aDltSkV3cU1iL2dudlJid1k0NzFRRzRWZ1BSckg2M2hGamR3akJ1bjRDM09h?=
 =?utf-8?B?UWVYVHdhTzEyYzh6a2tUNll0bUhHVDdaenRLTUlPWWpncUxIOGoxa0lkVTlR?=
 =?utf-8?B?M0h2K0t3Z3dhSllCVFlyWXAzT25FUXJxcEtwakR1VC8wYkQ5VVBFaHZXTXIw?=
 =?utf-8?B?Nk1iVnQzMHRaeFh3Y0VmZzdLZkNPWkh6Z3lVczV0aHN6YmkzZTN2RjBwN2g4?=
 =?utf-8?B?MWdORFRKRUxLbHhUckJTTkNWNXRXWk1wcVQvYTMvd2JOZGpldzBTbSsrTUwz?=
 =?utf-8?B?VG9oaVptK1NZUER0dlg2aHNwcHJ3UmlDRE02eDN0QUNXOEdTUnNWSUxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdlKzk1VHhzMjZrSHVhckk0OFR3S1FVcjdzTlVEUVhGL0U3ckZJNzNGeVhY?=
 =?utf-8?B?VWp0TDNRL3EvOUhjUlFpYTVHUDEwSjJGMUNaNXRwNlE4TmpLZmNrZmF3Qkxt?=
 =?utf-8?B?WXFWQ1FKbDllWTZTZ29sVlQ4ZEcrdjR4bnN4U0Y0SDN3NzNaTlFSLzJFeG5t?=
 =?utf-8?B?eDdlTVpmejZoSmp1Y05ISnBTRU1FSDAvNkVpV01mWDlrOGtuWkk5Yk1HdjZ2?=
 =?utf-8?B?U08yYmhhL2FNYmtodlZPdUlSc2FEbHVyYkpYRWp0NUtTekJvK3VvU3BZa2Qr?=
 =?utf-8?B?Sm9iTHdZZThFdWkyRmV4eFFyUUZSTnMzbVo5WlVnazQyRUxBbHNPR1lFUGp0?=
 =?utf-8?B?RWlpM2ZueTJzZzZtcjFYdG5wNzdJWVdYZ0dpVGRCZjdhUkVyd1NsaEpoakwy?=
 =?utf-8?B?ZVdqbUxUZDgzakNXemJLVWZIb281bWNJUUhUdUgvMmdnT0pSUG9HZnFOVFFx?=
 =?utf-8?B?THVleC91NnFubUZyNlVKdnpLM2U2OU5tNGJ6anQxVXhLQTdRTWFIYmJmV0x0?=
 =?utf-8?B?RlFLcUtzTnNRYkhnSG1adjFCaWZUazFsYzBkYTNZd2x1V0dKZVlJQjY4U3hO?=
 =?utf-8?B?N1FiOFcyRlpHUFNvYXU5dzRyaS9sbmJNdEFjbFlRWHl1bFF4K3N6UkZmK2pH?=
 =?utf-8?B?cVVacnZTcG9nWkVvRXZmSmF6MEV6NTAwMHhzQm5vWlZucDhNbllTVHpLWWNm?=
 =?utf-8?B?a1RLeW9QeHNNQWY4OWFlM3BPcWR2Q1BQdVpBaXZKM2M4NktPVUJMNWlwWmNk?=
 =?utf-8?B?VzFYNXJaaC91RUtMWndOSTZwMEdPRUhVZlAvY1V0NENEdHdqUWorbm1QeWpw?=
 =?utf-8?B?cHdBczUzOHIxc2dBbDVPejBVaWk2L3A0dGxQWHRYUE85UjhScEVvUklJVFJN?=
 =?utf-8?B?YVdiLys1dGR2WldSR0g3UU1zY1hzVjRCVyt5bkFHWC9XVmpnUnJ0TWFlbURW?=
 =?utf-8?B?b05MNVZocjJSaytIS2lhR3BWVlpVdEEyajY1ZGJmaUp6dUJaNDFDS3MwTDh2?=
 =?utf-8?B?Yk90R2VmMDdHTHF2c0NDSHlqV2FYTWpLTDM2eUdjY0c4ZUg1a29uU2cxcTdS?=
 =?utf-8?B?elo1akxETUhpVDRGSHU4Z09DSTF6R05JSEUxRXJtcmxid0RFNDF2ZWNUK3hv?=
 =?utf-8?B?b0t6cTc3R2twb3lKSXlQWTVrd3NKN2lXdHIwQklvTXh2TUJ4L1BhNktCN21j?=
 =?utf-8?B?ZFUwejIwVzh5MDBrL1JuZkpQQnNWd202d1lMenRLcUEwaUdMcXJYOFJPeXRX?=
 =?utf-8?B?L21FTUl6LzNLeW9yVFBjeHdZRG5UcVA0c1JzbWFKS3JIVzVoWjRZK0dvUTVO?=
 =?utf-8?B?QkFYNnk3Qk9uSU16MTR0UGY2ZEk2alphS2ZJOS84WE9DVjFveFljUzFsVlVw?=
 =?utf-8?B?ZkFqKzFQdkR1VDRpV1hoZHcyTG5hUnlQMzI3WG41MkZiNTAvQ3hYQ1BUQlA0?=
 =?utf-8?B?cVRsb3oyOGJySnY5cVN2bDBpdjc1TTlJQmViV2xrbFlCNVM0SUt4T01GdGtN?=
 =?utf-8?B?K09QbFFsRlQ2VFI5Z1lCVjYxZGxqNDZOK0I2OFBrbll1ekplUG12VEtqT2JI?=
 =?utf-8?B?VkZxVS9Obnd5L3lwakhRZXFyNWlkUlpLZmlhVTJJL0I5WWx2RVZLSTdQaHQy?=
 =?utf-8?B?bkMzOGlqODczTS8xdzhKdHNpT0p1elRZc090ZXlwTzlpc0dWWElEMms2TUJW?=
 =?utf-8?B?UTZHeCtBNXMyT2ZWYUlYU3p4TWk2NlUxbWg1bGNmTUZqMFdUdnQvU0VjajEw?=
 =?utf-8?B?bFdVVFBmY0hVUkVpRzFWbFVwVWFHUXhOOUk3bDIzYmlXam5WdEdxWTFCOU1B?=
 =?utf-8?B?NXMrSGlkT0NXR0NJbVdDclVyZHhMWExzaHZhellUeGlWSUR3WDhwajhJM1J3?=
 =?utf-8?B?YjRaZUdPVVIyc0QrV0NpeG5qYkF6R01Pb1Fibm1lSktjVXFvT1J6TTRKeHhv?=
 =?utf-8?B?TExVckZBT0ZFTlhXa2lteVc2K0ZoVEhGTDBHTERxd3ZCQUhuaUExMSt0ZXVI?=
 =?utf-8?B?QkV5ZXJRTFNMa3ZWaGxtczNraTB4aloyeGZnVFJhQmJEaVJwb24wdE5WdVZt?=
 =?utf-8?B?OFo2RnloV05pb1orbUR1NFVoWFNWVlpWKzA1L0g0ZDc0OUJLZ3ByZ3NUNkRv?=
 =?utf-8?B?STM0OEZtTjRkcnJRTzMzaUVMQnlWNEhlR0dFemlxRjVkalY0ek9hSlNLZTBv?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1834007-9625-49ca-dc41-08dc64447ff4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:54:14.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR8DSB50CwFCc6uhDqKv7JkMnVEzQPqdUEjV1Am+BF0i6NvO7paM8Em69KggSpVRATlK/qINzRcJdy6ZloS0kiHar8qOsksa/WQFkAgkSV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com



On 4/23/2024 2:37 PM, Bagas Sanjaya wrote:
> On Mon, Apr 22, 2024 at 01:39:11PM -0700, Tony Nguyen wrote:
>> +       The default 9-layer tree topology was deemed best for most workloads,
>> +       as it gives an optimal ratio of performance to configurability. However,
>> +       for some specific cases, this 9-layer topology might not be desired.
>> +       One example would be sending traffic to queues that are not a multiple
>> +       of 8. Because the maximum radix is limited to 8 in 9-layer topology,
>> +       the 9th queue has a different parent than the rest, and it's given
>> +       more bandwidth credits. This causes a problem when the system is
>> +       sending traffic to 9 queues:
>> +
>> +       | tx_queue_0_packets: 24163396
>> +       | tx_queue_1_packets: 24164623
>> +       | tx_queue_2_packets: 24163188
>> +       | tx_queue_3_packets: 24163701
>> +       | tx_queue_4_packets: 24163683
>> +       | tx_queue_5_packets: 24164668
>> +       | tx_queue_6_packets: 23327200
>> +       | tx_queue_7_packets: 24163853
>> +       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
>> +
>> <snipped>...
>> +       To verify that value has been set:
>> +       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
>>   
> 
> For consistency with other code blocks, format above as such:
> 
> ---- >8 ----
> diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
> index 830c04354222f8..0039ca45782400 100644
> --- a/Documentation/networking/devlink/ice.rst
> +++ b/Documentation/networking/devlink/ice.rst
> @@ -41,15 +41,17 @@ Parameters
>          more bandwidth credits. This causes a problem when the system is
>          sending traffic to 9 queues:
>   
> -       | tx_queue_0_packets: 24163396
> -       | tx_queue_1_packets: 24164623
> -       | tx_queue_2_packets: 24163188
> -       | tx_queue_3_packets: 24163701
> -       | tx_queue_4_packets: 24163683
> -       | tx_queue_5_packets: 24164668
> -       | tx_queue_6_packets: 23327200
> -       | tx_queue_7_packets: 24163853
> -       | tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
> +       .. code-block:: shell
> +
> +         tx_queue_0_packets: 24163396
> +         tx_queue_1_packets: 24164623
> +         tx_queue_2_packets: 24163188
> +         tx_queue_3_packets: 24163701
> +         tx_queue_4_packets: 24163683
> +         tx_queue_5_packets: 24164668
> +         tx_queue_6_packets: 23327200
> +         tx_queue_7_packets: 24163853
> +         tx_queue_8_packets: 91101417 < Too much traffic is sent from 9th
>   
>          To address this need, you can switch to a 5-layer topology, which
>          changes the maximum topology radix to 512. With this enhancement,
> @@ -67,7 +69,10 @@ Parameters
>          You must do PCI slot powercycle for the selected topology to take effect.
>   
>          To verify that value has been set:
> -       $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
> +
> +       .. code-block:: shell
> +
> +         $ devlink dev param show pci/0000:16:00.0 name tx_scheduling_layers
>   
>   Info versions
>   =============
> 
> Thanks.
> 

Thank You for reporting that. I will verify this issue soon.

