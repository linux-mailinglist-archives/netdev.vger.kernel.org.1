Return-Path: <netdev+bounces-232735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2144FC08746
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A451A62FB6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001811A314F;
	Sat, 25 Oct 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG1dXofB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122081FC3
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 00:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761352665; cv=fail; b=DekUcckNphRbBJDFny0CatbhpPOFq2QvNtUV1GjVk0AuzIm7g3Z6wagzHCxu6eRGj18OkKczEKEywApbAzDDPPpF1kRBJEcjH8J3vkGhQ174VhqwTw65kdiSQiKOfsSCN8s/ol2QGk+QGaw1SZOfKZ2pK3bEZG27gcXnud+Xt9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761352665; c=relaxed/simple;
	bh=Ye42Ia1A0iRoGtfWRJQbjffY6iHkV2hR/nhBJTZymFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmOyOUarWyj4vTlw/vWsSoFovLMduunLwZYhtiooHm/ddqZCYMfSJTiva6aWYUTTMvKZ5VjMpeR2saJX6rDUdUGLjWLnr6PJwYEmkMQ/RuRAocm4qDOQQqS4/MVeiNPL+Wg+j1EGYQrb6IQKnEeOicA8wdfeS7rCA0aiHm/jSGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG1dXofB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761352665; x=1792888665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=Ye42Ia1A0iRoGtfWRJQbjffY6iHkV2hR/nhBJTZymFY=;
  b=MG1dXofBDgJxq/EAMrNyGCb+YC/eYKnk/x+JEAIgE67gaXMjD2jFOnUt
   d7WLNRwVoarbfnKyAJ/fCRLH4PV/Dw0ONDyG6m6/4K1aXfAmP9/BHwm7X
   P3bc6+RsU61lQqQCWQ45ePbXDVBRkVu0gxMLWsEYqLMZVnqi62mtQAVV8
   30ucdOKxXfYArx+e5x6NKDgml6Whi0EGBE1SKOq0iSD4uxy1KBtbG6JW/
   7/CMK0SkX6dozM3j43/Jg8HEHyADN3p5AKUuRVUoxLboBPGjac8olNGN+
   ButxtBTiuFYM7t+0IqFkqo+5fPoX/gbVUQWEafDVUGGqwYhepiSue20vr
   g==;
X-CSE-ConnectionGUID: eIKUrwWOSNWOrJkmQP/w9Q==
X-CSE-MsgGUID: FKDDjMKdRHCyaHtYK3lvvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86165296"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="86165296"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:37:44 -0700
X-CSE-ConnectionGUID: 8mHK9LsdRIC9a6HzCkFwQQ==
X-CSE-MsgGUID: RBAjqckrReiNCpCx+lzbzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="asc'?scan'208";a="188617202"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:37:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:37:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 17:37:40 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 17:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA2PSjUEWPoMnpZN5h+8rP6VFHA2BGw+mg3VSP8bxWlX1eRjHGXUrWSzBeaJMqLkKWmFQiskj4R019i8UUYo6wBkMFXSHJI6bO7A8XsNSANgsZsZoLj2p0r/IPJDUpTqSt0iRhF2sXtPkGWt+FuPn7W6VuwCO79ie9hFaXh/NRPGqKkeh/MV806f3lQqMaPiuRtAIRRoMNFl8/xeLdBdTgLnW9uUm5m3HhkPDzmTM8ZrxykHeDuXYWYNREiH0W0x+B/NghZ83Gt7lb/2OGz5caQJ+oVB/xlELtIZMisWnzEAeKH7UFsjjfX38rgtan4AMaNCsVmx8uRrGsmCsrn/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye42Ia1A0iRoGtfWRJQbjffY6iHkV2hR/nhBJTZymFY=;
 b=PHJ+6kGYrD66Olm+sI5ZDU2fbumeZHydka8RheV5X3OZRD+euJk8dSZFfeFB93Q8eYWLnEBIM163HtSwgsUiwOxUYwvzQrlfKU8Uu29O/qurOstvbYaDd14IZ+xWVJfv85lYe6vhBIz40sWpdc8HAFWj7bdlDEeMeFvmgglUe9wryDFE1LwCSAExNaoHVPowqSU8DKPK0waWajJEeg+X3/Kswo1GSe4paNv1Kk7p1F9DpQ+VW2KOr3bsZPfk9eujYjssTVOxaLxI/n6hj8RUxPaZVd/ijCmLuspLKWLvN02FjbL/TX+EzKjmN9yfiuYJ7boqUK83M1IbrwtnRs5KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 00:37:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 00:37:37 +0000
Message-ID: <fd171a3b-144c-48df-b284-f14d0398f8f6@intel.com>
Date: Fri, 24 Oct 2025 17:37:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: txgbe: support TX head write-back
 mode
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-3-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023014538.12644-3-jiawenwu@trustnetic.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------6mv05z9EEGjJNsR0sCh0BZP9"
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: cc09c3e1-ada1-473d-f380-08de135eb268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlRaenNCUDhYZHpDTFJQMWo0c21zTjlYb2xRNmh5eUhLUkpITVFrSVBmUkdn?=
 =?utf-8?B?c1pYNVBlY2FMWHE1V2FWbVJ1b2JlZ0VzRjNkVGpNR3JuZ3pmbEFxbjJBNGRP?=
 =?utf-8?B?ZHczN0gwb0VSUFZFQSt2Q1llUUkwcnRMUXFCU0k5a3JlNWNZVEhPT0NpaUJC?=
 =?utf-8?B?U0VyTFJJMnVscG5uNlp1eVl1citPeVVVWjkwWVAyUThhTzN6ZlE0NXZmQ3Uy?=
 =?utf-8?B?NVQwa3JKcysrNDFPcHVzWnBucHQzU0NVMCtnYlRhZlQvLzM2NDI2T1ZJUjdy?=
 =?utf-8?B?RG9YSkZrMEt6aFFRK1QvNkdqTGk4Ky84T1VCaTlGOEdiN2l3eXNhVnI4elRM?=
 =?utf-8?B?Tld1WmZjbitRU2NEdVArb3AzNlgvanF2NjdnWUt0a0lrUk5lU3dRanN4VXI0?=
 =?utf-8?B?eWZPdURRdnNCdGQraU5od3h6dnQ5Ynl0U2gwbTN5Rm51T0JGWDFmUFFYNmVT?=
 =?utf-8?B?YUc4ZDZQT1p3UTl2VytHdTZ6QnlMekZtMDR3eGVuVkN2VVVYeWRTUm15Y0ly?=
 =?utf-8?B?Ym9kRTN5d3V6MjZRMmhNSHhaeUcxZmZ1SnN4dFpIZXBhLzVsUkRIaDJqZUdR?=
 =?utf-8?B?RXNFSGEzWitQallldWZZZDNWMFc3QWZJMWYveHdBekN0diszSFBzL044bU9o?=
 =?utf-8?B?dnZ3QWtUeE1XZ2d5c05ZSXZkZ1RDZlY1WisvZ01tcDBHaFVhUmZyQVI3ekFH?=
 =?utf-8?B?bVRPS0swcHB3dURBMzR1SjdwazhkNmZha2JFa01ybFpaekUrbUs1ODJFRFov?=
 =?utf-8?B?U3ZoR1lIWCt0TDJEVm5tN242ekdTeVZpN2VQQ0M4WDE5YTBqeC9iZ2V5R1JP?=
 =?utf-8?B?MlBOSVpYOStBS09od1lraVVGdkVFdTViM3dkekZuclFXcWI4RCtlTnV4Z0Rq?=
 =?utf-8?B?TlAyM24wcmhtcGxmSnFING9odVk4RWJQVFlSRUw5UFBDRU9hYU9KSmRVajBh?=
 =?utf-8?B?MjFEbTJMekFuOTU1ZlJsMUdXTjJXZFh4ZStHRkFVQ3ZUK2dWeXo4NDdSVEZ1?=
 =?utf-8?B?RVlWcGtMRnViSHA5OTZiL3d6QUJ1ckcxaVdHNGRETWRXNzZCL3pLK1pXVW9X?=
 =?utf-8?B?MEVnaVoyVHh1TTdqcDRUWHNoc3JENDlRQ0h0azRxTndaQzNnRmRlQ0RPdFBF?=
 =?utf-8?B?OG5IaUpiWGdRQkZDdExFeEJtSUR6VGtRaXpLSUpYMXI5MXZhR1RCeG50YVh3?=
 =?utf-8?B?YmtvbVcvek52NFRPVEcxTXVqSHcyS29tSkRoc05RSGhMcm1xSXJnQlJIY2VY?=
 =?utf-8?B?alNWNHZxK1huYTZNWDZ2UWM5UmdEcHNLazcxRjB2QkJFZkhhUU16d0w0cmR1?=
 =?utf-8?B?Y2M4anprNWU1UWRlTFU2dGRGZ3BUQ3RCMjZuOTJ1TC85MG9qbHdqMmVUbEo1?=
 =?utf-8?B?RkpCQW9TZGRYODBFMVlEVmJNVmJDY0x6aTR6TDFoMGpNQ1pFZlJZcnpIM2t0?=
 =?utf-8?B?NEp5R0ljZE1xRUJzajVBb3dPdHZkbEkxTzlRdUZ1TmJXaU9Bb2xQVmVvVnR1?=
 =?utf-8?B?ZXZQQXNXTGs5QVlBNEVIUGJyeW1RdGYyQ0NBSkpVSlJYWDBKUWY3QUVTOXJ5?=
 =?utf-8?B?QitFSmc3c0F5L0pnWEFoemFFSXpMTDY5NXdUZGYrclBQZyt1eFl2MnAyUWNG?=
 =?utf-8?B?WVhObXRSL3ZKTmJRRkE5VkM4K0NRdFVlZWpnZTBkeUIyOWNHcWxXS3Z3bUs4?=
 =?utf-8?B?Q1NFUDhmbDZ5YWZvZHJmaE1uT1BWWDZ1cjN2WW5MaWh0UmNTUlYrSHdhRDVU?=
 =?utf-8?B?TTNmTTVzcnN4VFJIZTJsYzhVMkZkRjhONDZxdDAzalg0TkdGc3BqdFpuaTRQ?=
 =?utf-8?B?LytpUFdKQit3OUZxZmRBSFk5TTJOSytaL1ZYd09WTmp4a3M3VDk4emlrNkpF?=
 =?utf-8?B?eXZhcjU3RWUrVUdsaXh6UUR0d3JaUlVhNGp0S2hDb2x0WCsvY0o3cWpXV3Ev?=
 =?utf-8?Q?RPAR6WheuZfEVgjpOW3qTe2h7fHQ+gEA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllWRFU1SXk3N1gyWUNXc0dhai8xL09KZjlhbkJwamRxMWlpbXozRjZRSGg2?=
 =?utf-8?B?T3pDejYzSVcrbnhzbGo4V2VDZWttd1R3U1JFU2UzWTVsOUxYeHpvRmxwblhr?=
 =?utf-8?B?YUhqMTArT3N1dGYrREtjNGhJM2dyUy95NWMvbWlSVkxEUG9Wa3lSVStaNmE5?=
 =?utf-8?B?cDM0SURuVFVJU054d0VwUktXbEdxTWRCbFk0SW1UWHdxRFpvWGJyOGNpUFdP?=
 =?utf-8?B?WjlzdjczN2dyK3lSR1lFeWxYUGU2d1g2Q3gzMndsZ0JFWGQxcW10SE1WZVdM?=
 =?utf-8?B?RWlSY05xTDdmVE1Uc1BCeWNFTlVlSXNiNnN2d2V6M1BSN09wQTFkdmFvUjdp?=
 =?utf-8?B?ajBhaU5OaUY3VHExbCtLb0M2YjcwRWIrYlBqenpSbXJxWU9NUnhqTk0yRGlz?=
 =?utf-8?B?V3k4cVlJS2h6aUMvcDRmdTF3b1JySUFqU2p0aU03TEwzaHdjd2pmNUt2V0hE?=
 =?utf-8?B?UEhtek4xeDVuUEJiUTJBNkJxOC9XZFhWdTNETEZmN3dJcldVRWlPcmwxQlJN?=
 =?utf-8?B?R3NBMDFDY2ZNbXZEVnlxZ0kvZG9UTmVJZ1JNVTUvcnNOMkc2Z2IzQlZqaXNt?=
 =?utf-8?B?Umhpayt6TEF0WlR6czR4S0dTOUlra0FQM2dlVTJiWGIwb3FlZENVQVo3aWtq?=
 =?utf-8?B?dlVQOFU4U1JWbXBQdjAzQ2lFZSs3M2xMdlFCM3NKVVVnczNWd3FwRzFGZkRM?=
 =?utf-8?B?YlBrUS9UTjZEeFZUQlpQNnhYUTVHaktoRjNmN0hweSszR2tRYTErZ0lJUmJV?=
 =?utf-8?B?WGNpSHdqZVBFcTkvNmlyTVhEcjR2bjVEN2dIQ2l4MktUZkJPQ2htUWhOalBU?=
 =?utf-8?B?aUdOR3J2R2NYVTBNbUJZSWJjcWVKZ0w2MGNaQWhGQ3dqNWxhc0tadUV5OUE0?=
 =?utf-8?B?dEszM0pWbnh4dFBURytiUmJOYnZvTFpCTGQrTkJ4Uk5rNlE5anB3OWZZNUVO?=
 =?utf-8?B?V3lpckppVExIMm93TUVLc1pqS1FwTXMwRThHQWFDR2VTZXhPbnhTYVc0ay9L?=
 =?utf-8?B?RFhoVW1LQ3NyRXBYZDFQdG1pTEl0ZjBHTDdNOU0wN1dwOWxZMG55ejdtQlg4?=
 =?utf-8?B?UmxMYUlldmVib3ZNRitFTUxBSXlXUi9wSWp2aVJhVW5xK0JpT3F4Y25PSW1O?=
 =?utf-8?B?WXhYeVdrWVlVUGFtUEdNeENvaGh5SWg5SEZNUjdkM2RQcWhhRFVib24zWS9y?=
 =?utf-8?B?MU1tMUYrNWtLaW43emc3bWdFQWN2SHdXK3JnK1gzaTEyVzhZUW0yK3Z6d3Vp?=
 =?utf-8?B?VXgxZytHWWljSkRrTks1ajRZZm1senVYRHNpbHFvcWtxYUVSL3JITmVJUjRH?=
 =?utf-8?B?amVhZlpEUlN3WFphRG8waVdtK3hMelkwUVY0ZGlIckY2dG5GNnJYcDI3WWVI?=
 =?utf-8?B?a1BHdkJnRlBtNEdhT0V0d3NpcDhJUUl1dGNLL3FWa1BqdW9lSVJPL1BHMDJK?=
 =?utf-8?B?WmtBU0xySUgrYWJDTFNTUzJrRVFZTlQ1NjYxcE05Q3ZoQnlNdVloZCt6T0t5?=
 =?utf-8?B?L2pyc001OXZCZWN3d0xxOWRYSEdVSWtFdkdNVHZCZ1lUcXQzRGxvQWVsTjhJ?=
 =?utf-8?B?YTM5NnNoWGtTQXdyVHFJQ0UyY202blBPR3pVNzRSbjNHTXZyejk1RUxJazdV?=
 =?utf-8?B?UWM0bU1MZjVsQVZiaUFJZk1LRnlMTElGTFRPYVV5V1pyOGM0OVdVY1A1NXpF?=
 =?utf-8?B?UmhFRkxZUTZrbjF4d2xtUXU0NUI5SFNjS3Foc2ZVeHQraVRoK0xDOWMvdzFJ?=
 =?utf-8?B?K01GOVh0MGlwdkRPd0F3bm5ibUZYcjNhZDlmc1FiZVBCeEFISXc3akdYOThq?=
 =?utf-8?B?VW10dGtuaGxDN0dYS05SQjR2Z25tT1RXejVCK3VtNElDQjc0QlpXcVRUTExz?=
 =?utf-8?B?c1FwRHN4QjFqWCtlOTlWazRJenl6cUoyMTUxbUkvc0VNUnkxQThMYk1ycVFQ?=
 =?utf-8?B?SUhod2NHMS9kSTVPNU5QQ0ZHUDJUeG5YUU9iNDNLcSt0eUhwMkk3UlV1eXZU?=
 =?utf-8?B?bWRXNVhDcldwajVHbnd6dHk3VUJqRWd4SWNFa1M1K0Z1VmdzV1RpVk4xYU05?=
 =?utf-8?B?Y1ZGU1FSTXF6NW1LcmhVa2dxOG5hYkROamh2bFdIcjJRT204YTZhSlF2U0p4?=
 =?utf-8?B?QWlWeGFia1Mvc3F4VUhkZTIvWkNNNTViVXpybWg3cElKbTB5SEpnRE5GNDhy?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc09c3e1-ada1-473d-f380-08de135eb268
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 00:37:37.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1DAskxdm8wixqrp6wgxpU9kPndXWyb8e35DJ9uDy/1/ORJqVJSug0TqEH8gtRI8D+xUgEyucn0W24BF6yFNd0XAFeaCQif7ZcVeZdHbgEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

--------------6mv05z9EEGjJNsR0sCh0BZP9
Content-Type: multipart/mixed; boundary="------------VLtSJFS88s709rbpl7vW4aPk";
 protected-headers="v1"
Message-ID: <fd171a3b-144c-48df-b284-f14d0398f8f6@intel.com>
Date: Fri, 24 Oct 2025 17:37:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: txgbe: support TX head write-back
 mode
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
References: <20251023014538.12644-1-jiawenwu@trustnetic.com>
 <20251023014538.12644-3-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20251023014538.12644-3-jiawenwu@trustnetic.com>

--------------VLtSJFS88s709rbpl7vW4aPk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/22/2025 6:45 PM, Jiawen Wu wrote:
> TX head write-back mode is supported on AML devices. When it is enabled=
,
> the hardware no longer writes the descriptors DD one by one, but write
> back pointer of completion descriptor to the head_wb address.
>=20
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------VLtSJFS88s709rbpl7vW4aPk--

--------------6mv05z9EEGjJNsR0sCh0BZP9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaPwb0AUDAAAAAAAKCRBqll0+bw8o6PLh
AP4502iaq5xpaDlACqFDmEhkDaD/yCA0jRt/E760bK+5DgEAtopc5d5zjnMp2Xq+5g9dwF19X8/r
eVMPlYfBcvJynwQ=
=AoyN
-----END PGP SIGNATURE-----

--------------6mv05z9EEGjJNsR0sCh0BZP9--

