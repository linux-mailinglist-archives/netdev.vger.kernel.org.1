Return-Path: <netdev+bounces-294909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kkWLkqPIGpA5AAAu9opvQ
	(envelope-from <netdev+bounces-294909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:32:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBBA63B21C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 22:32:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="iwbRYj/Z";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A91153007E1D
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C573A3807;
	Wed,  3 Jun 2026 20:30:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEA37F73A;
	Wed,  3 Jun 2026 20:30:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518659; cv=fail; b=BBieSBcN0N4M1n9WK32rYiFs4rWZZDPov/I0BPhQWPAKKY8Z8OjNyJyUjBEXCkIWMXG2DZpA0kL9gw/FH90L1GgrrMNAGBcvdFb7PFkvWZxWa0UGDZrhzIVKUFEdbgmSqIYX3XAJrabgJnQ1DXf5DHpPBT++o29GSpToKczUQ6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518659; c=relaxed/simple;
	bh=kwIMHQ72PewY6u6hYvB3C7YgLzD4TtApEGsla+SER68=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BovxG9EHCAx0tH9EgKUmyKvbISgSPk1oDVl8FmyBi1UFmZRkTvRVQ6/zxa6FHzaHVby2GA+ciC4ioWaTjtS+c1eO3t0BgkH4+0kR3Kzaj3wTBDic9B2iM/NshDCgmxS5kMlotvB24WMq+sxfTNLyJ7U4D2PxyubcVvhrGGqkO8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwbRYj/Z; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780518657; x=1812054657;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kwIMHQ72PewY6u6hYvB3C7YgLzD4TtApEGsla+SER68=;
  b=iwbRYj/Zpf3Wm8skTmdKG41lfmm7HwCX/WMOAringJV2Bs9TH7mKwTyA
   Pz0UWqbHY4Do14hoQz1T4IGfkCAv3ND00F3Lwx9HfneWCNkQD/U/o7jbp
   2O+RAnY79Pyg7aiszs5SN3Yw+DN9TMhTZXB1U7epUfaGYR88wVJ3yatLu
   nO1U4UWxIGx5IrzpHfahb9FEKFbmURVbieoLRNCBTVIvocKNyHqDgdMTY
   JZpaQwf67fV+Vyl+4AOnpX8j1Lnn7HMu/boo1ecz985tHkDVsVY34tduL
   8YjVT1SoF2FqNde9mJkfVUElB/RUo5c44EAJ0q/J8CyR9Pmv/JyrjuTYP
   g==;
X-CSE-ConnectionGUID: U6Dp9mHuSKGrnlZl6nU9oQ==
X-CSE-MsgGUID: LgcjWxkOSVS2xNFK68VO7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="68879416"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="68879416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 13:30:57 -0700
X-CSE-ConnectionGUID: 5XZJcUfPTWWQfSis2VMvCQ==
X-CSE-MsgGUID: 3I2UdhrQRcOJKI7n4Pkg1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="282441246"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 13:30:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 13:30:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 13:30:56 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 13:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7o+X235Kj8XDVh7b2sGi/3/9EvGyoJtYp4JETFuy3627g0pBV8rztyl1/v2927V6t3xXKcZNniPWOr0m4fTGxUjxblA+4pkvLgAyc3CmVcNsPEM0gha9MOfzzdzceJGU1lONpIA9q6gP6r7f+NIh3rC10gNAdL3jGauB5dTVNTwfLVGcIHRgb3Hsy+gS5+LRwWYpSKotVsCjIXZohwhl4Wd6d67pVJ7ZiPzG+5ba5HoIyUX/4qagp2e7KutZHZ4rWtHLOELKEBp/IZRemrrmFCLiCbYVckDAa/7FyiKzkMkc+tie4YV84p+NwEYirPk4lMtkaOv8t39GZjSYD847w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvbFHaMibi+gwpKw/PANcif8FojIfUF8zaGjOmL6bV0=;
 b=yQF2blu3+OH3Q+e74QxvGf11hafAONoa/YrJBSTofotE7HG6umJQ0dklB93CtIusOkTdKNOgZww44R4RA1CxjhGA3TLvDU0cUxCHML+BkSco5yveSmV6XNC2WYJ8P+U+UG25W9tkyajsC49dp2ClHD5LzczrPdsviYAdhOrXRIE5Aeu4LtCnzDWiXnjFDr+cd61WkNpGbEJ2Q8tjTOBhWtmNXt/so4/k3CTTVIYXG+MDuyeYZ/Yg2mNehoMvR5ZfDfeJx9PreKAYx5Dv7T8jQokaMaAYs7x9oG1o5Fm7Z3awaBkT/QGv9DUV3t3RlKCw4G+xxe2UwhcYtSpF+haQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CH9PR11MB9901.namprd11.prod.outlook.com (2603:10b6:610:342::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:30:54 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 20:30:53 +0000
Message-ID: <4502f36e-e0b6-41eb-adc2-be5245cf8e19@intel.com>
Date: Wed, 3 Jun 2026 13:30:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ibm: emac: fix unchecked platform_get_irq return
 value
To: Rosen Penev <rosenp@gmail.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shannon Nelson
	<sln@onemain.com>, Simon Horman <horms@kernel.org>, open list
	<linux-kernel@vger.kernel.org>
References: <20260601040201.103481-1-rosenp@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260601040201.103481-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CH9PR11MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fddd015-ec4b-4928-9b48-08dec1af0253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VnRujCBSfMrfk2Xt1YKn8U59uZu36sXshUL/2lPMJ0lHBCqGfGlEfJ2GLI8dEj0x8iuBfn0JgT6Mbcc/GtBH4mUIvQUKs5vAKH9op1tI77+TZ8EzKSnkbA09Qj9h2GkiGKtCf8RDe2bRNrIAqOQJKXcYSh3So/3uGgVUkNUgCtZWZx14s2Kui2OBJDajuUJmJGxYXmYFrLAzPlQqRGBjX3FSy2m8+mSKeTClk+Mij44YAFPEOX9AW+ORUJVw0h5Wu/Qo816gBJl8c8RbvjuaP1G8DWx53/NwwsZ9mQLQG0qdwlQigkk3xfbcJZG/LIjNILfjXYTWjC46bjahkDwf46kEW687nb60HlEqa6iDFJqdia9Ms1wgopk6ON9VuEWJBnCFatx2C8IK5u/E7NOtqA8isMaIFQX5/8lBtg4S30nSYlRF/0YQESjnBomX3GUiA0dk5enJLzqKQOo/0GcdqH+jRf4iMU7YxJKfknYw4f4A59zuJd6oV8pXdh0bze0NF34DUD8TOwYAxKUxENF8/ysH3R+oKT+Id+EqE9RJxuMyPcXPVMc/0mQIFa8txdUThdOtwK0ao8dZtpaV1caGN+lmP/EgKL1D8oMT55sjOqCowvOHAS+T2JS0S13fH5QugqMg9J1apT5xVyRfE4h+IL1dSMCa5qa00Ry4KEMSn57qDtUxBrK7v+vKWud2LMUE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWd6Qk1pRlVSRDN3d1dTN1JuVnVna08wWmcxdXF5RjFoMnMxak54L0I0N0NT?=
 =?utf-8?B?Z0R5SkVvUnlXUWN0MEdXSGFmUVhlaFQ5cUpRS0dUbXBtVUx6MXVyc3ZEQ0px?=
 =?utf-8?B?U0hZM2JSbm5RT2hIYUJuYjArVzFqbWxUMkJ3Sk5yQUZlQkEvL0w5Slo5QUZB?=
 =?utf-8?B?djR3Q1ZLQ0xwSnBQb2tweU94Q0MvbEVzS2JtdTVWd0VHdy9rS3NvaldxcnFY?=
 =?utf-8?B?RHlNYnRGc0tlTkVBaVNCNk9ZR0F2UW1DRHJTNmlmbnR4WEFhN2VLZWk5VUZw?=
 =?utf-8?B?ME5DT2VRMFhkRHZvZXpTR0lCdSsrbEhaeW9VdEJSUDM2Z1BrcGFSMzNJL2pD?=
 =?utf-8?B?UjhyTWk5dTZiR1Fvd3pUdWZUcFdHT2Y1SXRkazRMaXdWK2crcVVsd1Bqelpp?=
 =?utf-8?B?RVgxNTlYTmlwYUNvRjl1cmhldEI5RjZlZk9mV3Z0T0ZIbjFwVExrRUJYZ0JV?=
 =?utf-8?B?YkIyeVhQTXRBMmI5QzdGNEFMREJHdHcvR3JUWGVER1ZyN21IMGxMbTVWcDRj?=
 =?utf-8?B?K0ZmcHloUFRWQnVJY3lQcGxFaVBnTlFoYkp2UXllcmVuN3ZUWjFXSmF1d3Vy?=
 =?utf-8?B?RlJCRGxXaENPQlBrWnFTWFRsSi82TDlCL01kdXZKRTZPVVZXRDl5M0lONWN0?=
 =?utf-8?B?c1JjNytQUE9JZHc1VGZCWFc0Y1FpTWw0dWluenI3dHRBUnpwS3QzV3BUakZy?=
 =?utf-8?B?MnJwSTd2RGhoT29GWnVBM0l1M0dNME42b1hPNGNyQnI0Tm9XQXljam5wSkNW?=
 =?utf-8?B?ckpNb2Q0YkdNZ0dYUU1aengwNWtFZUNINFk5WTZwVElaeGxGaUtWVjBNNGFo?=
 =?utf-8?B?S0lPS1I3Mi80SXpqVVJsQTdEODkyREdvY3g0T3E5SXFEcm52TG1veFF6NlJL?=
 =?utf-8?B?MjFSTjJEZFBtNTZWcXdOQTZkdDRtUjRmWmdrOVl4cHE0SktwR0hTVGl0ZlRC?=
 =?utf-8?B?UEsrUzlRbDU3dGxIYUNOZUJ2REF5LzFlVml4aWpjeWFlY0NaZWl0QWxkMzZQ?=
 =?utf-8?B?dmVLWEI1eSt0ZVVmb2dKMFU4b1NUMGVDY2lnTXB6U1FYaTdRUENsOW1nSnJI?=
 =?utf-8?B?MWNFbFdna0NZNWY1VVVGZVJJajN5Q2xDL2lVRnlNNVVZYm91TTl3RDBCejFE?=
 =?utf-8?B?NGNjWVFucFdpWlgzZFoxR2NFRTRDWUxLZk9zZHdpa05ZOXlxMUIyYmt1WXZN?=
 =?utf-8?B?cnk4TGZ6SUZvUmcxbkV5em9Bc1FMYjJwajJOWHpuOWtsWTg4bENOMEtRSElo?=
 =?utf-8?B?bjRjbk9nUytQVkJMeVI2S1duNUVKMzUxeGpsejRVbk1QVFRFUzVTb0w3N29N?=
 =?utf-8?B?Yng5bnY5cXkvMHFPbVBxTGVWN2tnaUNsZkc3TnI4cWJTSTJVeEJUZzRyQllo?=
 =?utf-8?B?ZFRhbTJWVis5enFmZVhRaFVTbW4xQ0JMSnhqbFI4L2kzdUNDOFFON3VCYnY5?=
 =?utf-8?B?RmxPR1dZMWxrbWlnVVRLNFRpUlJxYzZsVEZiUVBIRXhZRnIvUmwwSUJmQTR5?=
 =?utf-8?B?Uy8zdWFocXBZbis3UnVBNVMrZlJSUzRmTVQyUVNqdWdDaGZUQVg0TXB4L01j?=
 =?utf-8?B?bmdOblNXamQ2bGpYd0JzYlFKOUxJNFc1emFmNlBhZi9JcFdGTSt3OHFaZ2lM?=
 =?utf-8?B?TFFJSEJNTUlEUmZmRkdKWHlOZUZLTHJkMS9NNHd5UWdqVlBtVkI2dTRGNzN1?=
 =?utf-8?B?R3JmSTA0bk9DclR1OEMxelJDNGpvTkdCNnFWYzRiSEVtUzQvbXFpYjJRWWk3?=
 =?utf-8?B?Q1VmbERlb3BTVFBYZXc4L3ROQjkwcEc0WUtGOXBSZWRMNlpYcFdUbk5kNy94?=
 =?utf-8?B?ZVcyZDhOV0pxTE9jN0RiaW1kMUxnYndJdWhscFJWcHBzQzhQTVg5S252blBQ?=
 =?utf-8?B?K092WkVtaHdOMnJ3UXI2RjVMbm5ob2tubzRaeGhReVREay82TElLTkUrd2xI?=
 =?utf-8?B?b0orajB1c0tqc1JLQmo3TUxrQy8rUHJmRWNvNEFucXZIWHUxNEFqYWsyUE1s?=
 =?utf-8?B?REhvREFXVTJodlM5SGw4S0NGUzhKVllmSkdoa2ZMSndYaVpaM1FiS0FlNTVG?=
 =?utf-8?B?THpiT1RqYUt2cjZLYXQxbFkrc1o0b1dNTlVkOEx4eG9mY2h4bE9XQm0wYnFv?=
 =?utf-8?B?YmsyQ3dpaFBveGJDaGZ6d0tWcENSQ1B4ODJGQmFVYlpsOWNZRERVUjZGRXBu?=
 =?utf-8?B?aFEza1ovendEcDdKaGJxYTJma3oyTjk5cU9rREs2YWxpZytYMmdXUzFFT2c1?=
 =?utf-8?B?MzlFNVZsbGdhS05aUyttWmc5VTZBMTJCMnQ2L0gzZ0ltQmg3TUZRakxDRVpw?=
 =?utf-8?B?Z21udW8raE9OTVNDTzdBejFCRCsyODVLdEF3QVdvVk5INFZMcVFUK2FTSFRy?=
 =?utf-8?Q?4LWqSw1LYe+p/6Cc=3D?=
X-Exchange-RoutingPolicyChecked: Hz5TrLU392CW4ZQaBDwlUbGTLqd2pDAnzBxymLSyToiKm5m5NECFpQvshXhArH05s/aszwdDCc/1PK4pjaRiAxTCLfSexNDCn3hAPEIaEVA25bxd1YqmZORnxJLqKsu5yh+wKLG+qAEEUMcHjEfr777bpvEBegHNm/9oiztAjE35Ok35g9LyKcRy2T9ojXn3Zalmwssft41OgRFmdxtumLZXfzocNsLdMwCfTlQWeAcUb5X4mdWwUmcQqonQG+yttK1WrUCT2R+U9DJ+NGoPNR/R4USClIYFCeTca53PywRPQET2OmbXC2NpjOIsloapajeoGdg/0REbtVNqbwxeHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fddd015-ec4b-4928-9b48-08dec1af0253
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 20:30:53.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDW7fUAOK4oc+fgOrxh+6tTJaAG9iH75IIMzmIYmhYvKBSM9lX259thosPNkM5M+7FtCM6uwisDb7a+bAo46YO+MNJIqcc09uViULvNBS+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR11MB9901
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294909-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sln@onemain.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EBBA63B21C

On 5/31/2026 9:02 PM, Rosen Penev wrote:
> platform_get_irq() returns a negative errno on failure.
> Commit a598f66d9169 replaced irq_of_parse_and_map() (which returns 0
> on failure) with platform_get_irq() but dropped the error check.
> Without it, a negative IRQ number is passed to devm_request_irq(),
> which fails with -EINVAL instead of propagating the real error
> from platform_get_irq().
> 

Yep, looking through devm_request_irq, it seems most likely to fail on
irq_to_desc().

Definitely more explicit to correctly check the return value, though it
seems like a relatively minor cleanup since we do fail almost immediately.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Add the missing error check and goto err_gone.
> 
> Fixes: a598f66d9169 ("net: ibm: emac: use platform_get_irq")
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index e597e2ad434c..d2194b406c9e 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -3035,6 +3035,11 @@ static int emac_probe(struct platform_device *ofdev)
>  
>  	/* Setup error IRQ handler */
>  	dev->emac_irq = platform_get_irq(ofdev, 0);
> +	if (dev->emac_irq < 0) {
> +		err = dev->emac_irq;
> +		goto err_gone;
> +	}
> +
>  	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
>  			       dev);
>  	if (err) {


