Return-Path: <netdev+bounces-211005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9019B1625D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E203416B269
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA312D9491;
	Wed, 30 Jul 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze2NmCoj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C42D948C
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884692; cv=fail; b=la15LFwJj67ntyzrMPSU9qH2l3vOTXVEl59YIlaZyyP1Tx68p8thsNBfq1q61tB5ZkOxMlopO/nhkslu+yYXj2kFKheWM/3OsV0KzwdvVnFWtp6zHchckopXbbQSncL/q1DvUnSAqt65C4Wyvg1RtcRkHBuazXcC9uj13MeXsx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884692; c=relaxed/simple;
	bh=KSFQaI/V0GIuyNXIeV+nwiDh5eLN5l0FEggsOl9FLg4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UiDB395AW+d5tc1uh6FcD8K4YuJEaMavFCZdoQ7EVqhoKP+ZYIkyHmloqjp68KE/sPy8+2QCIuM304/wGpxaMOj0Qhy9R9Fctt5tlvrLRPIzIO22mGko3jSIUgGtt1b1wPbUP6vQ+DGCsy8mqs0SWJGjOVzK4XGZNaM8DHl21ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze2NmCoj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753884691; x=1785420691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KSFQaI/V0GIuyNXIeV+nwiDh5eLN5l0FEggsOl9FLg4=;
  b=Ze2NmCoj+ttEgS52jVmupzwtuB2kxHsRJgaHlVk4Tj4s5BxTilrXBIs2
   84sWj2bcBWE0i7WZKQoddBzro1ZSjwwWkyC2OSC7QQEK9rSs/AQxOdScV
   KlyY6sxj1b0ijSr48m27CtH79o26Tk6KwGx4vXDYaiCe7HpGz46h5oB1J
   WLOgKhV0jtWfAPOe5cvxIO8V1+o10hCJJk8cobi6n4oJVvins0R+7hmqY
   VMLYxkP1IEk5Z95/UdAZO0bBVh6TXEhzFfno1/GN/iSMOnwmeEgCDtKMp
   8dBHcIWxOjTifF8WYT+3vxIsMBAt0eHWMGsR0rmbFJ1xO61k0aZQUK5kj
   A==;
X-CSE-ConnectionGUID: qf+2u/iASMCbwSeTnQFAIQ==
X-CSE-MsgGUID: k8aqV4BeS0C4zqK7SWpMcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56334554"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56334554"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:11:30 -0700
X-CSE-ConnectionGUID: cGA3+5+HRmGQJ/lNXR+lWw==
X-CSE-MsgGUID: vuKGFBciTf+G0ATV934v3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193982231"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 07:11:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:11:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 07:11:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 07:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9UQyetEpPISa6MuuvXy98kpj0Q1OQgnOTjjMf40sj1dQcGCNpBM/kG4zi+oQyl1WtS0m8o8TBZl4xnw6iVZAeis6zYvXlKerF8cWZG5wBco/GJY+8uA3PlM56l+TUwRUyH7HTpzGIfyAed3U9V+Gf/Km7Pw6MPNpbb51/IzXO8htxsbXsp8Lss2Jq3STj1knu+NriXbsGam3LvtwY9U6A/9XhrOI+rd6OlP519c8uYMWFEBNEiveZAEkb5u2pAKlCfHpYq+zRgHL49GE3dVXV+Eunh0viWk3ok/OBYTdYqg0zc8zlqAnReeIVMP1YROE32rNaRiNvcwQN4WjXx9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZVAtXILM9C04qviqa5RNV1vQc6YXkI8vQyXBqcBDyQ=;
 b=Vbtig8DNmJyX1nUX8qTvVJxofllrWuyaczlBhZR+KeD3uXTTvkTsEeJZvhAzat84f5/UsCY2fwOVhTf67H+m26nDHICPzGm/cL3ryBbUsTdNt/rpi/kffrAdBGvukCMrjSBth8cu1RTbt+XkK6oQciD3qNvB1AcZbR1xhTsgD5lFLKUWM5DUrJx2ojo01MqxiJQk50Oeb5Luy34FUQwI7NPMufOgc/TQkyHF07y2RLPeAz4bsTEy7nnQse52ni2GTEHF+p8D9i3VIDciIdbiLbLlQ+d8r+RymMn6Quss7cjzUBXuW4cI17hvGJrMI5ynns0TlNTCyEoOX+Dg1Mk0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3SPRMB0026.namprd11.prod.outlook.com (2603:10b6:208:575::6)
 by MN2PR11MB4568.namprd11.prod.outlook.com (2603:10b6:208:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 14:11:25 +0000
Received: from IA3SPRMB0026.namprd11.prod.outlook.com
 ([fe80::7d8f:a435:614:a319]) by IA3SPRMB0026.namprd11.prod.outlook.com
 ([fe80::7d8f:a435:614:a319%3]) with mapi id 15.20.8901.036; Wed, 30 Jul 2025
 14:11:25 +0000
Message-ID: <f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
Date: Wed, 30 Jul 2025 17:11:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
 <20250714165505.GR721198@horms.kernel.org>
 <CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
 <b7265975-d28c-4081-811c-bf7316954192@intel.com>
Content-Language: en-US
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
In-Reply-To: <b7265975-d28c-4081-811c-bf7316954192@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To IA3SPRMB0026.namprd11.prod.outlook.com
 (2603:10b6:208:575::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3SPRMB0026:EE_|MN2PR11MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6eb540-8d83-4366-da02-08ddcf72f839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEZPc21HZUROTC95SVJ0ajQ4S0ozWUVHSXdFdVFOYm9hOFNEV1k3ZFNST0dG?=
 =?utf-8?B?MHQ5Mkh3NG5jWTlIZ2lyeS9kdm5XUGRQc0plSHFJUjJDbDl6Y1RLUy9pYnFy?=
 =?utf-8?B?L1c1V3hSRVViZWQrMkxkU1lReVY1WDZ4cFlVM2x1NEppeGVNQlhndUxMOTEz?=
 =?utf-8?B?L2U3SFdPcE5RYjhGeHZJaWVmelNheURkOEU2aG9MWTFIVWZnVGJaeEdIbmNt?=
 =?utf-8?B?L3g3d2JRdUQ0WU1qOWx4Qmw4cDdEM0lldTZnWXJ3VWx6dFFBTnk2VnBiK1NE?=
 =?utf-8?B?TjNPNzFvalNvT2U4K1RNazlCWlJoOG44YnRhNDR2allxVy9VTG9GTWlsYlFT?=
 =?utf-8?B?TDVkMCtOT0kvWk00MXdJRllTU3V6d2dRc1dFUUVUNnJhWHlRL3BoZ3NHWUYv?=
 =?utf-8?B?dGNHSU5sNW1rcEladFIzVzFmRHdObjBHOWRzSTZMNXNyWEE4QzZJdkVwOW4x?=
 =?utf-8?B?N1o2SnVhN0tJdUhFWDlRKzBzYzhvZ1h3eG4zMjhOL2M5NnFpREJLRzFTMm1S?=
 =?utf-8?B?YjZiRUZuMUpGa1VEYm5TN1hQcnUwUUROWnFPMVRSWkt2OThUL3ZoTWY1NGJo?=
 =?utf-8?B?WEFpazZyWUFiNjdvSE5YaUhhMVpvRGVDZU1EdS9xcGlaZ2RCQStrcE52dkx2?=
 =?utf-8?B?TUNuRmdta1pDSXkxVThRSklRWWRBeGN5dXFQcmZLOFpVVDFMa1h5a3JzZm9v?=
 =?utf-8?B?YmpTMHlGVXZwTllyaXIxbndnUWV5b1dpZUc2L29HdzV0cDJUNXhRelZGTm1z?=
 =?utf-8?B?RnQyTVZ3Z0oxWXZmYjhydjhUL1BlUThYV1gxUmJ0NjQ2bXRUTXZFeC9IdkE0?=
 =?utf-8?B?aGhvRXFMUmZ3WVp3bVdMWE92T1c5ZXJBVG1aRUVUVkJuVENRWGdKL045Y1JP?=
 =?utf-8?B?bHVDNllPVmNTS1NhZWUrVTNvek9CQTNDSldkS1pjSUh4bHRucGkyVm9YRUlN?=
 =?utf-8?B?cWFUeEJNaDA4Z2dxaXZGZ1o1YkgzOExINFRxaWZLWHp0SmJyQk04emxBYjhu?=
 =?utf-8?B?RGdIYjAzc2NFMm54NlpyLy9JMlo2STYycDRHbGZ0TnlmdGxTNjZ1b2x5bGNm?=
 =?utf-8?B?RnZsWlpnNVowWTgyWHNTSW44dnJEcXZxbEpYNkYyWWtDZzRud0lwMi95TkJP?=
 =?utf-8?B?R0g5WWxJZ0ZiUHVtTlM1Qy9GcFNteVRrRVdnV0RkUE5SNkswNm1LU0M5UnQr?=
 =?utf-8?B?OWlVOEZIN0l3VEd2cm1PTWZlelBNSUUvVm5zL0NqUjJCZ01ETWlMSXVSM0RU?=
 =?utf-8?B?S2pDWTFiVS82R1hPNkVLcDlpYlJZdTlYSmt2bW42eW5KYk90N3lTYlR3ZU5R?=
 =?utf-8?B?eTJCM0JHVnZrS3pEaFRHV1dpalRNc204WmR1OENZdklLRmtuM1AxUHJFUjAr?=
 =?utf-8?B?NnZvczdhNkJnZEJ4dnU0cC9nWkhFS0NYR0src1hsODBETW5GSVE3bjkxZHlF?=
 =?utf-8?B?Q09SWFFYR29pUzU3UkJrRG82emdkbVhZUUdDKzdxTXorQ2JDRTBCazlheCtx?=
 =?utf-8?B?Q2xMNUV5Ymw3R29OODdLL2lMMUkyOFNXZTlnRnFyZHQxTEtLQUduWWdCc3ky?=
 =?utf-8?B?TUFnRjc4N3czcnJMRDNFbDZ3T1VIWCtQMUpWTUhiclJpR2Z1aWRNa3ZzQnJL?=
 =?utf-8?B?QTJJN25YazV1L1hZL0M3V1VLK1IzWkJkVy92c0U3aWZzd3d1emIzMEhqYzF0?=
 =?utf-8?B?aFJGNy91d0hsTDdXL1VVZXQ4RmtqTHFLaWYxSTBPOFBpV2lQSDNOZmZLMVk5?=
 =?utf-8?B?OWhEWkhrcFU2LzV0b3JOWmxXcHJ1dnluOHFyTHViRStCTnJVSlVNZjNVVHNI?=
 =?utf-8?B?VXhiNWpub0xVZldtQTJzbUVPYVpPL3hoMlpOcHgxckR5RjVYZXRVeGZMTlE5?=
 =?utf-8?B?eTVrd2YxZGxtaStsMnY5QXl0anlNVUdRZWpZMkYrTHlNRHRya3gzblFrWks0?=
 =?utf-8?Q?2Nnu3g61wQ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3SPRMB0026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YS9ReUZDVlorYTNGSGl5SzRnMU5VQXdGRWVrVnBsMXRnSXNGTVFoQkEyaUJE?=
 =?utf-8?B?YjN4WXhJaUY2b09pZ0RRaHA1cVdodW5ONnAxTUhEc3BFRVZBb1EvMi9ZNVJt?=
 =?utf-8?B?T3gyVS9oU2k1TmFTQS9qbkhkamJzQ1RWUFA1TEJPTjRCYXQ1ejNJejUzbjVm?=
 =?utf-8?B?bHNueFM3Z2VZd3BFc1hKMDNZQSt5VDc3WFh3cktzWmljRGx3SE56UEoxa2lZ?=
 =?utf-8?B?eDFTQW82Q2QzV1h0cVhSdzZLRmkyMzNUekR2Q0VIY1FrZGxMdTUrNExLdWkw?=
 =?utf-8?B?ajR3My95bHdONmx4VnQ4YlMyb25sZHR6TTVLZEFvV2RQRzJvMWRIdi8zSnJO?=
 =?utf-8?B?ZlNFcXc2VzA4azhCdDllaitvNVF0a0lEQUZzU1FoQXdMS3h3ZXQ3a3ZYaUJo?=
 =?utf-8?B?dHJUSmlqOTZkMmlJY2R4Nkp3dkZRTlViQzNxa2tsZ0tOQ2U5ZWF0QkxKblkv?=
 =?utf-8?B?TjZiSDFKV3I4dHdCWHRjVU80bC83QkpXb0djd3FCY2tvSmdaNjQ4MXN5d0E2?=
 =?utf-8?B?dWZBblpOVTdKaXN4bE43Q2hHUXZaTkpLdlZqR1M3cUF5TXlNV0lsd25pTFMw?=
 =?utf-8?B?L3ZYa0lCY2tiUStyV1V3Ri8xb2c1U1ZONVcwL2I4eVdHdmNqUThRR1BEaHhM?=
 =?utf-8?B?bWJYajhSSVJWNThiYTh6cERGOTI2UUZWdUhsc09hb1dkRGNLRjc4RlVmOHlE?=
 =?utf-8?B?UHArLzVteHI1YmpmZXpkSHlGRFgxWmNCblJTT2JWN1dTSjBhd2YzcmtVbkNU?=
 =?utf-8?B?bS9lYTE4TGdETmVxeVdLUlVJMVFHNUZpOTlnRmhFajh2WlptTFJ6K1pqaFhI?=
 =?utf-8?B?SUE0SFhVUXRUVUFEMkFkQjA2V2JPeXJMVGFFNWJuc0k0UTVsOTl2UVZmNWNZ?=
 =?utf-8?B?YUF5UkF6TkVIVmZ0YWlaam5Mb1pRTkh3a0Q3eU5JazVPODNnSTlheXVWUmtP?=
 =?utf-8?B?R1JTOXZiZWtsbUQvaWRNV1pJWjZxbjdQL2FYWWtYNy9xYVFtOFZBOExZVFln?=
 =?utf-8?B?WnUyd0tZalFuVmVEU1ZDU1dqU0o2ZjJaT1ZDTGFLUHZ4UlZrVWRRckZUSVkv?=
 =?utf-8?B?eXhPS25OZjRqT3NxeGJDanA3QlJpUkFIZnh0L01TcWRwUzZNUUhMTmtkcjFv?=
 =?utf-8?B?OWdUWDFFcllLN0xSV1pPRVpoaFNnVlpvVDRNRkJyWEh2Vi9IYnRnejMvOXlQ?=
 =?utf-8?B?TmFDNm9ZOFVxQmJueG5pTHpRbTF1WjVRUE5IWWJaZis3ZkRIWWlQZmJLRGlv?=
 =?utf-8?B?aTJxVGwvcmViTG5aQ2QwaFpaTjA3SmJYK0hLTCs3TkhpSkVpdWRFV0lOb1Zo?=
 =?utf-8?B?bDlUd2tzZXRoeFJTY09xNVIzaU9sUlJoQW1zNHlobjV0eC9FM2pxVHlHOHc4?=
 =?utf-8?B?TmRKOUpaQ1QrVFRnd1RuRktsU3o2cWdGYW9FMnJFRnp6c2lmMUk3RDVNeitk?=
 =?utf-8?B?RlhkQmNpSjNCbUpJTHh0NU4rTmt1SHlScG5kNjhOVzVHcFA2ZzMrVlNRSHlt?=
 =?utf-8?B?QS80VmJHOXBEeGhPQUFjQlc1Vlh2MUdVWFBvb2ZVYjFxQnB2SnhPaTduY3BJ?=
 =?utf-8?B?KzVMQXl4aURIczFuUnZiSGc1LzVsUis3TDY5dWdFbVMrRlAvZWt1d29PV0Uw?=
 =?utf-8?B?ak1Vd21rSzZ3ai9kZHN0K011V1hQMW5pMDdGSXR2eHdjbTZNK3hkVEJYZjNG?=
 =?utf-8?B?ZldScGF0K21jWDFMa2MyQ1FYaCsyR2NLbDRXOHh1bGtDWFEzR1N2RXM1ZFpQ?=
 =?utf-8?B?RXdQZU55dTNhTHZQUjlNRWtsakdRRzQzZmtJT3lxYzh2ZkJjZTBBMm5na1RV?=
 =?utf-8?B?dWVYMGE0a3dBUTBHbStqNnd5K2ZiU2JkVUF5eXFsR0FsRGZ5OU5aY1haSUZC?=
 =?utf-8?B?TnV5SkltTWtSOUdNbmNJVlRCYmxtcmFBUWlEUHZNT25BaUxPK2lpOWowR3FU?=
 =?utf-8?B?TGZrbjNEWTlzM1d0KzZObkFUcWJMSFp4TzhSNkRNSERHNEJFTDN2eGt3RjFj?=
 =?utf-8?B?Ui9kYkxsYVZSVndHVS9zNk9ydDhidUp1dEJNTGs4V3dqMTBNclFNRFJ1QTA3?=
 =?utf-8?B?SWRJRUtuVWZ3cE1BeVRQdHVaNHdKMlJlYUt1R2RQYzE2RmgzL1k2VW9hZmQx?=
 =?utf-8?B?RytFK3J6MElwMWtXdU16RWQ1eHpqVXFWcmJZYkdxL1JiNmhIbThYTzVVZzBR?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6eb540-8d83-4366-da02-08ddcf72f839
X-MS-Exchange-CrossTenant-AuthSource: IA3SPRMB0026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:11:25.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNzAX8rRmLcvuaUyoqYIIORB+EQ8Ij/y1tsiKA2naQ4mTdlGF3ePRjth1RDvQHrL+/TMZtUabYCNhv1tAn1yba8/xL/waHEBsrjEGmBhXVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4568
X-OriginatorOrg: intel.com



On 7/16/2025 1:25 PM, Ruinskiy, Dima wrote:
> On 15/07/2025 0:30, Keller, Jacob E wrote:
>>
>>
>>> -----Original Message-----
>>> From: Simon Horman <horms@kernel.org>
>>> Sent: Monday, July 14, 2025 9:55 AM
>>> To: Lifshits, Vitaly <vitaly.lifshits@intel.com>
>>> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
>>> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; Ruinskiy, 
>>> Dima
>>> <dima.ruinskiy@intel.com>; Nguyen, Anthony L 
>>> <anthony.l.nguyen@intel.com>;
>>> Keller, Jacob E <jacob.e.keller@intel.com>
>>> Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and 
>>> module
>>> param to disable K1
>>>
>>> On Thu, Jul 10, 2025 at 12:24:55PM +0300, Vitaly Lifshits wrote:
>>>> The K1 state reduces power consumption on ICH family network 
>>>> controllers
>>>> during idle periods, similarly to L1 state on PCI Express NICs. 
>>>> Therefore,
>>>> it is recommended and enabled by default.
>>>> However, on some systems it has been observed to have adverse side
>>>> effects, such as packet loss. It has been established through debug 
>>>> that
>>>> the problem may be due to firmware misconfiguration of specific 
>>>> systems,
>>>> interoperability with certain link partners, or marginal electrical
>>>> conditions of specific units.
>>>>
>>>> These problems typically cannot be fixed in the field, and generic
>>>> workarounds to resolve the side effects on all systems, while 
>>>> keeping K1
>>>> enabled, were found infeasible.
>>>> Therefore, add the option for system administrators to globally disable
>>>> K1 idle state on the adapter.
>>>>
>>>> Link: https://lore.kernel.org/intel-wired-
>>> lan/CAMqyJG3LVqfgqMcTxeaPur_Jq0oQH7GgdxRuVtRX_6TTH2mX5Q@mail.gmail.
>>> com/
>>>> Link: https://lore.kernel.org/intel-wired-
>>> lan/20250626153544.1853d106@onyx.my.domain/
>>>> Link: https://lore.kernel.org/intel-wired-lan/Z_z9EjcKtwHCQcZR@mail- 
>>>> itl/
>>>>
>>>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>>
>>> Hi Vitaly,
>>>
>>> If I understand things correctly, this patch adds a new module parameter
>>> to the e1000 driver. As adding new module parameters to networking 
>>> driver
>>> is discouraged I'd like to ask if another mechanism can be found.
>>> E.g. devlink.
>>
>> One motivation for the module parameter is that it is simple to set it 
>> "permanently" by setting the module parameter to be loaded by default. 
>> I don't think any distro has something equivalent for devlink or 
>> ethtool flags. Of course that’s not really the kernel's fault.
>>
>> I agree that new module parameters are generally discouraged from 
>> being added. A devlink parameter could work, but it does require 
>> administrator to script setting the parameter at boot on affected 
>> systems. This also will require a bit more work to implement because 
>> the e1000e driver does not expose devlink.
>>
>> Would an ethtool private flag on its own be sufficient/accepted..? I 
>> know those are also generally discouraged because of past attempts to 
>> avoid implementing generic interfaces.. However I don't think there is 
>> a "generic" interface for this, at least based on my understanding. It 
>> appears to be a low power state for the embedded device on a platform, 
>> which is quite specific to this device and hardware design ☹
> 
> Basically what we are looking for here is, as Jake mentioned, a way for 
> a system administrator / "power-user" to "permanently" set the driver 
> option in order to mask the issue on specific systems suffering from it.
> 
> As it can sometimes manifest during early hardware initialization 
> stages, I'm concerned that just an ethtool private flag is insufficient, 
> as it may be 'too late' to set it after 'probe'.
> 
> Not being familiar enough with devlink, I do not understand if it can be 
> active already as early as 'probe', but given the fact that e1000e 
> currently does not implement any devlink stuff, this would require a 
> bigger (and riskier?) change to the code. The module parameter is fairly 
> trivial, since e1000e already supports a number of these.
> 
> I do not know the history and why module parameters are discouraged, but 
> it seems that there has to be some standardized way to pass user 
> configuration to kernel modules, which takes effect as soon as the 
> module is loaded. I always thought module parameters were that 
> interface; if things have evolved, I would be happy to learn. :)
> 
> --Dima

While I understand that module params are generally discouraged—as
Jacob Keller pointed out—implementing the same functionality via devlink
presents some challenges. Although it may be technically feasible, it
would likely complicate configuration for sysadmins who need to disable
K1 on affected systems.

In my view, extending an existing interface in an older driver is a 
safer and more pragmatic approach than introducing a new one, especially 
given the legacy nature of the devices involved. These systems are often 
beyond the scope of our current test coverage, and minimizing the risk 
of regressions is critical.

Regarding the ethtool private flag: while it may not address all 
potential link issues, it does help mitigate certain packet loss 
scenarios. My motivation for proposing it was to offer end-users a 
straightforward workaround—by setting the flag and retriggering 
auto-negotiation, they may resolve issues without needing to unload and 
reload the e1000e module.

