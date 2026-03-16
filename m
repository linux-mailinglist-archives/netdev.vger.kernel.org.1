Return-Path: <netdev+bounces-268186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNmcDSQfuGlYZAEAu9opvQ
	(envelope-from <netdev+bounces-268186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:17:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4829C227
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 392473003ECB
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2D39DBC6;
	Mon, 16 Mar 2026 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb6IxjKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29239A7F3;
	Mon, 16 Mar 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674033; cv=fail; b=AL9vuDNOmwvlnCiVgEaDIM/M9ZmoArJ7PeUktHWrTKN4xK21+olZp9mvksIz64DhG91Tp2ooIDZ+tTyQa1JUbp7vqTP8OHe79qqZ9tkLRIxWJILDU2vem19L+k+ycb3B10m1H6fZ1/b0t+2JJKdVHVt3RSAGfREUBo7GI7DGTTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674033; c=relaxed/simple;
	bh=gYTMjzy8daT6UzfeWljNpWIU5rtBW/9SeCUOZYC1ZAg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENodpiCH9Ln5NYKcccNvFBcitOExJGdXsxFPJRlHJVUEW0iY0crELn5vT4ZQTKo9jNNM1s/Jy4oDHAwdGkWISb7uXapv8tCaWo7uYLmWl8LavUky8TCUn4YuRvJzfoSwTiMBpt1Pf0Bwy9FWFmSA5v1/vYaE+v0j82jLQXzWTn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb6IxjKQ; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773674032; x=1805210032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gYTMjzy8daT6UzfeWljNpWIU5rtBW/9SeCUOZYC1ZAg=;
  b=Sb6IxjKQAT+Z+GO7kOtUTVNd8M0+bQbjSrlCyJw3hIqUwknv5td6lS6Y
   D2azkU4t7lnX51nyd7JOTlFqkXbc8e7a0cZZ5M68EJyrBNu1WgBpIWqHI
   +L8EbcJS2c2uozqQdA3TUfF9E8mATNhbMdtx2droqAz3X194eA70LcFhy
   340pf3TsO+rZXGzSq7xCXh0ym2vXd5qNjlf0esUS2NEPDgG6ux1OtAjCS
   N/2AOhKY1LbnhJEqNEAxsdjx/aYOVJ7tRaZBNnIL+qPKbgamjNBUL/lZS
   8YbDcoz9+lfnzVaUV2cutqWk4cHLAAODk/Dr4/CaLVP9sAHRnhlcFoyRs
   g==;
X-CSE-ConnectionGUID: AQP3gOpORoisXzF7ZtMwMQ==
X-CSE-MsgGUID: AJIH9Z8SSku2/h2IVV9j2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85008336"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85008336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:13:51 -0700
X-CSE-ConnectionGUID: A9AJ2JvNTA2TSPXxGbLZlw==
X-CSE-MsgGUID: Lfe9W6tFQEOIeAR/uXDqQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222028775"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 08:13:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:13:50 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 08:13:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 08:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl8wSQ7nTpheo53mF2r/ATxXyj/yNstXAk9KC3k+UmT/lNROkZaQrYnj0hZFN1ffvHJE/HkqX5k2gom0mj0pOiQQf5THAIElBkVHILDPR5BhCFqH46Fcqh71eabmGYWwuHXQ1O839ek0yocJmh/Z9UnidkBDP0NwgGycDWfZhfXgdoleRVDJwR0Lo1bqerqBvuk6uEF0uTNNH6+nhaYdGTT7/44bp1yck9BGBNSILU/Eb2bzy/7pw8SuDa78pZnzw0TIzmSnxv84UV2TsucQiEAToLbRMgQrpePoZRcXvICdLRCN+ONL5YibRmDVsq4koPnEIA/sTY4IttOuARLj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ7tHw9GYs84M+XcPHKgI2MR43VA8lCDLAYPjAxMlEM=;
 b=Ea/y1r5hbqFON1PgEDwE4HEz2eJBFoTHorgnscTq2VnPF6GEw8M+X5LfBaRiz6PvtAFFAZlU05XhETMAbkhd3HwOaZ0PYaHx9yN4jd4NiHUpW0/DMsFWg6nvuIam8vqM21EohlSwdISkTypIWtj+ch6RCeUBsWDmTgSsgtP31mNDJTuv7egA7IQoGp5lFfqs3GyBEEyXT8wHcfbXSTdDsGv2To0/mGpTFCGq9sgvwJiPrqC1TYlw171RKAQeXuXzIBdsPV9lW1dkEKabEgTL2i7wiu73GsSWdx4GO2O90rirQ4MqENxsxAazTG+1Oqjh8XoPByJWhHUrxf2p2OH78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 15:13:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:13:47 +0000
Message-ID: <4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
Date: Mon, 16 Mar 2026 16:10:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <horms@kernel.org>, <edumazet@google.com>,
	<sdf@fomichev.me>, <aleksandr.loktionov@intel.com>, <ast@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <hawk@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <magnus.karlsson@intel.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
 <20260313014628.1509116-1-kuba@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260313014628.1509116-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DM4PR11MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc422f4-10e4-4f2f-f8a0-08de836e9ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: yuKO0H8unD3z/Nx9E2YBTFzk4cgScu2IZJ/1YLqkqh12Ow6dePJUoCvDJNnvOJ54qpwkTkAkA9vFg8IFrIoN82o6x5cUi+AceUCAW45zya0n7Yu3TdGHHLvCdWFEExf+Db9fAZdSBhZX8S4EQpoiXpgzzMCvYDuWvMo8mecA4paJ1FzB6O5d8xAjR4NbhbcejaTzKFm9WJ+saa7yNyaEY7NABns9QHBDzQdqR1tnNIlQ85b8crhNrb8oXysXbK5E70SvNEDPjvdnAe3rP3tI8GdCCvHS6AlMRJ1kWpUaxACoKi6XJD4ocgDd68qjWtxsjAGhdPX8/PscSHYnBmoLhOKEfF5Q4HADGW/yYfTWoRhddJ03qcIx6zlHUs5eN8GLTIjOvBk2lXiZmp1ioPJDZJDmEy2YSqalJsgNUCubev+a6Oue7gKf9LdCOCEj/aFxjD8kIm0NbiqvFaADjXFMtochvqXAf2umepZFVojLpP1CU2eaN/1nJS2Z4elf4dp2Mp0HgBSRB/n3tYYzl+1vzTx8B6GBSr2midFu70l1yW5l/+OpVj03P7fN2QK7JmxQviE/REIeGt64P1ZaZkTSmjncWeTzyoAxiuhaAPL7YpHEvZNBLwFDEu6wsPPkEhhRO1sHMvYo5xdw7egOF9yxder3CVuPCeARdX3WUNmISTMv0T3U2jqEYHQxTw0fq0mf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25oMHVuMUJsenFMbkxPeDVoSUF1NkdJQ09OYzJoaGdybGpzU2ZvNi9Id0pT?=
 =?utf-8?B?TjhpUWRyc2Voby9tNGp3YTdyTDBFczN1c25NNmF3bnJTTDAvYWZMYzFsN3Zi?=
 =?utf-8?B?bk0vSDFWYktVL2NSRENFb3lmZmJLTkppLzU3aEFSOTJ2azQrTUJBb1lDUXhp?=
 =?utf-8?B?QkpXWjJDcnJxeFdoMUZSTGIwUi9yQm9vOTc1Y2Y4dGF4RFpDYUFYdGFqWUFp?=
 =?utf-8?B?YXBBYVpCRzdsNGJEU0xWUFBGOTE5UWlZNFRQOVlFRnNqcHdoQlZjemR6ZENh?=
 =?utf-8?B?Z2ZGZGFzWVJ0ZEduWFE5NFBCR0w1OElRcUdIYytjOHNiK0gxSng2bnhsWGNV?=
 =?utf-8?B?TkhHVjJxT05UeDJQZTJ1YzBWN0RwNlVKckxmRlJMdkJHaUJuQkRYSjN5Z09Y?=
 =?utf-8?B?UERaMC82RjZyeld0T3RpcElZcE9aNkZpcW1hQ2FGVGsxWU9qS2RMWmVhUnhy?=
 =?utf-8?B?OHYzUlpoVWJveTQ1Y2R5NFBYVityOEthckFMMi9yQk1kZVJvejMzYURmakM1?=
 =?utf-8?B?VkhlS2oyVTFsTUdsVUUxWGNldkZnU01GMjdRaC9xOUlSeTkyMjRpQnRQUzNv?=
 =?utf-8?B?SGJmUFJOd0hUZ2R4ZUI5aVpLbkhiOW9YMytrb3ZRRFZHL2drMkR3WlJycFZS?=
 =?utf-8?B?eDZNeTZKQXc1SUYyNkN3UTVac011VURveDl2T2pLcVVmbDd6SmcvKzRJZm01?=
 =?utf-8?B?ZERXTElUQUhSMm1YbENFSUV0T0Vzb25mck5HMmRXNm96T2JvYWE1SzQ4Y3ZM?=
 =?utf-8?B?TFh2VHdBMXpDMWJ0OTBJTDIvbmo1Yld3Vkx0SFJYWXVRcXlhNnliaVc4RFo0?=
 =?utf-8?B?d2NhS0liSGFmem9welF4SFJld3hOcFExTXdNc3M5a2NTMjY3SmpadHFLdXE0?=
 =?utf-8?B?ckZnNi9ZQW82TTE3dDdSK2ZHSStNUnFPQUxaM2MzN0ZvYkNkWndxOVB4VU5m?=
 =?utf-8?B?elk3V2dTZEtDZEhVdnF5UmpRYWRHR1JVN3VNMlNFbHFhb0hHVmw1dWIvaW5O?=
 =?utf-8?B?UXdiejVkUkpaRFZHMFZUMEVBMzVtS2hlVXJaLzhYSDhYelp0MmZWL1Z6Wmc2?=
 =?utf-8?B?QjhQa2V2T2NiTU5rN3hVNzlVZS9KYXBGWFNIYWV6NE1DbjloN0tKYkZ4ckVV?=
 =?utf-8?B?YWRxbWJEbGJwbWV4OFEyVEtMa3FwaklMc2drZU04Uzh0cmQzSVpPYW0vQW1N?=
 =?utf-8?B?dThJY2dSZFpjbUhhTjBCNFlISXdvem1hTnpTT0QvYlVLRXFQZU85c0pnM0ZF?=
 =?utf-8?B?MWJmZnlDMWtKSTM4c1RlL041clFvb1MwWTBMelQ3VVExVS9kZjZvaFowck8v?=
 =?utf-8?B?SW81Q0xENHpFTjRKRjQ3TEtPa0VLdW1rT20rVkFJdm44QndBRW9Ob0NIV3Jm?=
 =?utf-8?B?a3hVcVV6Qzg2U3JRRGU4b3VLaEhGVUNJY2ZCM3FSV1BtQ0piWnRMMUQrbzBr?=
 =?utf-8?B?ZkwrZmJ0UUcyQlp6dk1ZWmF0MGlBU3g4UVNNZWlVZkxLakZGZCtDMGQ3V3RD?=
 =?utf-8?B?eFgrVmZkT0FxdVFLc2VYVE0rYVlIUHdtUHRzOEo4dHd6QUV1TE0rejFrQjVP?=
 =?utf-8?B?b3ZIbnFOWURnWllEZThtRUlHSXMrSXF0YnBmL0MrSXRES3ZoWnk5ZzZCV05B?=
 =?utf-8?B?YWhSbmxNTDBxeUMyQWtnbzJpNEtDb3RtTkxQcWUza1Z5Mk9WbUVyenNqTGZF?=
 =?utf-8?B?c3BTS2R1VS9vSU80M0U4cU5aS1FZYVphS24rcUVUd1lMTmI4eUsrdVdwVnhL?=
 =?utf-8?B?RmV2R3pqNURWOFZhRDN0Rkt3c09MNm4zSzg0a0R6aHlmZmhtVThLenFva25z?=
 =?utf-8?B?VWlWbXM5SHVTclFGZlh2Um9hdTRzZ1V1azgyTGZnQnVqOU5ZR2MrRFozaUZV?=
 =?utf-8?B?ZEtmZmdkM0JPbUFzM2lRWWJpaHdidlRoNk5GdVpCR0lYU2FUdEJjYUF4V0ZG?=
 =?utf-8?B?dHZ4Zkp0TFhBMjVyYXh4NStaSUhaY3V0cm15QnpBS2tVMDhURWRrVjdTQ3Qv?=
 =?utf-8?B?WndScWxpQkdvV29QbUJ1UnZ5T25Da25XOFJKU1JUOEcyV29OVDJFUlJoajhO?=
 =?utf-8?B?L0pYdGNUNXhCVWJ3d3lmUDJoSlM5Z2I5M0R1eEMrTHZmTVVoWjJlS2t5VnQ5?=
 =?utf-8?B?M2FhMzhQdU94YXVHODhqZ1RsVVk3eWZ5RFdPWGZ3dDExUUFhL05mNlFhL0x2?=
 =?utf-8?B?OFJKb2NUNlpTVlI5cmljM2tXdS9KV0FTUkh1UERPL2RSREwxTnBmajlTenNt?=
 =?utf-8?B?bkU3V1pYTmNRR093b1V3Qm9mVk9ya2d0ZVFydUU4VUZpUC9oQzVUSU5zSjY5?=
 =?utf-8?B?WWxlTWxxZ053V0ZxaVgzT3RERXkxeTZPU3UrSkUxS21VajFuN2JITnluTzI1?=
 =?utf-8?Q?hlJAgXt22Wy6DxDI=3D?=
X-Exchange-RoutingPolicyChecked: ccNcGNfEwDOzgXzXMnnPsM70VtlQz6S8R/F0XhJzQ6Sn7mYDrQB2jwya/HiniE9sPNdxsRLbZdVLBhUdPJjoPNUyxaII2jZj1bD44gbA56phEn5qazZ29vx7z3tilKE/5Hp3mTPUQMZa9yMO0O3b7WCWttMyCmX/6ktVxy2vZo2z8lObASZ9Qhb+//CXVX9aCty1EVRD22uBvsg1sWd9nVfwHPTqTkvrO2pm3s2qNqVIv8Fk0J2ayENz0oFLNIeXMhCha2ffeRTaThF9fissPGCPO11EMUZetSw/rdopkl1alFCoUgGwvIvgvjyPNMWCRPgBSKb+OX9NM8BBCuKahA==
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc422f4-10e4-4f2f-f8a0-08de836e9ebb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:13:47.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dCwnDFv7QuYQN7lyK5E2UTA1AsBcOiSJlcIvQmOZzrTEK4ZKycGCXdbU9IPUsYmI4YUvdG1H/3o+hA1TyWvEYXHB/41VNyje7DR6jsTxH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5262
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268186-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 88F4829C227
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Mar 2026 18:46:28 -0700

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> ice: migrate to netdev ops lock
> 
> This commit migrates the ice driver to use netdev ops locking. Queue
> management ops unconditionally enable netdev locking, so the driver now
> uses _locked counterparts of NAPI configuration functions to avoid
> deadlocks.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> index bd77f1c001ee..08157dc04ed6 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> @@ -273,14 +273,13 @@ void ice_vsi_cfg_dcb_rings(struct ice_vsi *vsi)
>>  /**
>>   * ice_dcb_ena_dis_vsi - disable certain VSIs for DCB config/reconfig
>>   * @pf: pointer to the PF instance
>>   * @ena: true to enable VSIs, false to disable
>> - * @locked: true if caller holds RTNL lock, false otherwise
>>   *
>>   * Before a new DCB configuration can be applied, VSIs of type PF, SWITCHDEV
>>   * and CHNL need to be brought down. Following completion of DCB configuration
>>   * the VSIs that were downed need to be brought up again. This helper function
>>   * does both.
>>   */
>> -static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
>> +static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena)
>>  {
>>  	int i;
>>
>> @@ -294,9 +293,9 @@ static void ice_dcb_ena_dis_vsi(struct ice_pf *pf, bool ena, bool locked)
>>  		case ICE_VSI_CHNL:
>>  		case ICE_VSI_PF:
>>  			if (ena)
>> -				ice_ena_vsi(vsi, locked);
>> +				ice_ena_vsi(vsi, true);
>>  			else
>> -				ice_dis_vsi(vsi, locked);
>> +				ice_dis_vsi_locked(vsi);
> 
> Does ice_dcb_ena_dis_vsi() need to acquire the netdev lock before calling
> ice_dis_vsi_locked() and ice_ena_vsi()?
> 
> Looking at the disable path, ice_dis_vsi_locked() calls ice_vsi_close()
> which goes through ice_down() -> ice_napi_disable_all() ->
> napi_disable_locked(), and that function has netdev_assert_locked(n->dev) in
> net/core/dev.c. Similarly, ice_vsi_close() calls
> ice_vsi_clear_napi_queues_locked() -> netif_napi_set_irq_locked() which
> checks netdev_assert_locked_or_invisible().
> 
> The enable path calls ice_ena_vsi() -> ice_open_internal() ->
> ice_vsi_open(), and that now calls ice_vsi_set_napi_queues_locked() ->
> netif_napi_set_irq_locked() (requires netdev lock) and ice_up_complete() ->
> ice_napi_enable_all() -> napi_enable_locked().
> 
> The old code called ice_dis_vsi(vsi, locked) and ice_ena_vsi(vsi, locked)
> where the old ice_dis_vsi() only dealt with rtnl_lock. The new code switches
> to _locked variants that require the netdev lock but does not acquire it.
> 
> Callers ice_pf_dcb_cfg() and ice_dcb_process_lldp_set_mib_change() hold
> rtnl_lock but not the netdev lock.

Doesn't the DCB core take the netdev lock just like netdev_ops? Or it
only takes the RTNL?

> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index e7308e381e2f..a8e2db6dc05a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> 
> [ ... ]
> 
>> @@ -7563,7 +7570,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
>>  		if (err)
>>  			goto err_set_qs;
>>
>> -		ice_vsi_set_napi_queues(vsi);
>> +		ice_vsi_set_napi_queues_locked(vsi);
>>  	}
>>
>>  	err = ice_up_complete(vsi);
> 
> Does ice_ena_vsi() need to take the netdev lock before calling
> ice_open_internal()?
> 
> ice_vsi_open() now calls ice_vsi_set_napi_queues_locked() which requires the
> netdev lock via netif_napi_set_irq_locked() -> netdev_assert_locked_or_
> invisible(). It also calls ice_up_complete() -> ice_napi_enable_all() ->
> napi_enable_locked().
> 
> However, ice_ena_vsi() in ice_lib.c calls ice_open_internal() ->
> ice_vsi_open() while holding only rtnl_lock, not the netdev lock. This path
> is reached during PF reset rebuild:
> 
> ice_rebuild()
>     ice_vsi_rebuild_by_type()
>         ice_ena_vsi(vsi, false)
>             ice_open_internal()
>                 ice_vsi_open()
> 
> The netdev lock is NOT held at this point. ice_vsi_rebuild() took and
> released it earlier in ice_vsi_rebuild_by_type().
> 
> Additionally, if ice_up_complete() fails, the error path goes through
> ice_down() -> ice_napi_disable_all() -> napi_disable_locked(), which has an
> explicit netdev_assert_locked(n->dev) check.

This one... Looks fair. I need to adjust ice_ena_vsi() to take the
netdev lock instead of RTNL.

Thanks,
Olek

