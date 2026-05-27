Return-Path: <netdev+bounces-292101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O/UF8SFFmqqnAcAu9opvQ
	(envelope-from <netdev+bounces-292101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:48:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E65DF8B2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A587D302ACFC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 05:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0721FC0EA;
	Wed, 27 May 2026 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw/MLMZp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178D220698
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860928; cv=fail; b=o1tIUeRzkYXRVvJ7rdXU4iikezuqf7tYXs1hKLb4Hul6l916OEJOjK74jzu3gLy+S6qIrD3GOeyVYXCPWpPC1q6kv/wdbDyCox4McBhMdTM5miKFc3tiBG91xiCLWZEsmH3Q8YyBLfD+zR1dMHLw+dJkiqI6UmLJzFcBDQnyPk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860928; c=relaxed/simple;
	bh=IDPQurbhbAXSVG7xT+N3nM/zGB84TU3T5UAHN7eB934=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6T3WUcsg15eORhmzhnXqMhP2HWOouU2TUdndToImFeaD0XnMuVlEVMjWSMOJ57+swSjip8ZDVlWtvjc5RYNU9leVk/NI9orzK498kBWNx1Zpgn+51M9ATF7+EgmS1T0R49oIoA1h1dBdtzPHgyC+scUxrefcot1wA2l4MlWaAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw/MLMZp; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779860927; x=1811396927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IDPQurbhbAXSVG7xT+N3nM/zGB84TU3T5UAHN7eB934=;
  b=bw/MLMZpSSAeC2+iMYPxjtBltUsl14f/lwVamfa7NgtjRQsys3K7ENZW
   nRrnNIJuKmUKb5Uzhwof4ONTOQjVOJtmX1P6l22PolrtCyOQMYXPt/7Q8
   gX9trx+E89JiTS7URCGk1KJAlrpQdphVJ86b0g+RXM2j48Cj9hMECygF/
   XqdC/1aQJHnDBRnO90CWHoIjFLWMq/vS96j/Kx86KZeJ+06vIkygHhh0V
   ETyPOlxgSw7uP7n5mLrKCoUH4xrdreSl2VQMwQSffxLeWHYuewZQQJA+o
   LUrp3ObsunmzkdhYlCzuddqffLa1tvvJ+Jeqa4WM93mEILOCltT9hD3T4
   Q==;
X-CSE-ConnectionGUID: Sr8SxbBzR+WDpGJ+6v49jA==
X-CSE-MsgGUID: 56NGA0dSSguXQ3vwTd4LRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84307883"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="84307883"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:48:46 -0700
X-CSE-ConnectionGUID: daBNRoB3S0qrdR6RyzziDQ==
X-CSE-MsgGUID: RNiDu1gnSISmTSFdwGkD2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="241308154"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 22:48:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:48:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 22:48:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 22:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrhoxA3VTZ7oDuc81Vni9mW8sfQlOuJvFbxLTdq5YiwsT8T2ESmtWqrfgpd2vE2pKT9i9ipiDMraH93FAvrLlWzGbRR8RflC6vYa0i+6qA6R69prifHYBiB9WjSIahv+qPdTqnKVnwkjX4XeSzypnd1H5vEdC8VpUNuLbwpwh52IvDOVoHz6bl8smkU6GixHhcHYN77cpS4z5xu484+3hW6HKKatWh6qmXW1Y/zuQCwYA4+dCNI5yZlStshlmu24rTIZeXJ2d0MrZhnAU4DLbect8Ojw4gKDii3nxp3QfwB3miDHwV6t94jj1jTQLp7MOoB8uPZBZJcG+bmzJLhctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBBzWtrPbw2V13gkWyt+pz6qWAY6vCQsoh658MG8Anw=;
 b=AdGtfoWsKkVj1JxNRCfTPRXsB0IX8IrFanRP6zfDs5WrZ+tyJQs5smsi9tlxJguwaaSWRwBreg+meiHuXmLbUDl1k7udrUfxEY2oe2zejtwIG5M2htT99oBYQ4XAPAQ+Deh72j8GBVsyi1t2MQZ5unURkfuQ9zUePf/aJhRaLAj6weVQky2Il84e2qXJasNJWqsqpvHE1aQmY53mb8+CCCG0riSjBqpBguWpDeBT1vVchrztBdfostJzQUcJem4a9U1/G2fPMKmZrwqL4n70R4S9EluFUnmQWJGxy66A2l9BNFvsPUjPiimjJCzmJABqG6/i4OZ6yqIZO4wElc/g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 CH3PR11MB7723.namprd11.prod.outlook.com (2603:10b6:610:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 05:48:41 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 05:48:41 +0000
Message-ID: <55145a97-df5a-4b7c-b316-5a2bc78f6114@intel.com>
Date: Wed, 27 May 2026 11:18:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] drm/xe/ras: Set error threshold support
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <maarten@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<umesh.nerlige.ramappa@intel.com>, <mallesh.koujalagi@intel.com>,
	<anoop.c.vijay@intel.com>, <aravind.iddamsetty@linux.intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
 <20260512191610.1817578-7-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260512191610.1817578-7-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0258.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::6) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|CH3PR11MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b2d563-2407-4784-cc74-08debbb39b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O/xTqjxExELA2KWM5c4G3/6C32ddtH0EYGSeUhA3RQ3NgXqnO2bPoqX/84YLN6TI2xwIaXS19gHOvhTFjk8bmXh5cYifzD5x2J4jlY8f82N6cVD9tckocBscOgGl3YLEjWf5P2/cunmzqWWxTgtEozOob1R7o5JsGITgQLf4RZYEjTA5Xi5Xi4cjzR/ohkt6jD9mn7m3eA6hL31ozYBjF7sCpnkTo4iyViXgqMfgIhexLp3SaupZtVBSAzi72PAWZxhTmsDMGnLKT/Bgi2j8//UXx23SjyrvVglUpku7zGk8cG1hzXOkxb7xB8DdMoNpZ0ZvAG0LKtAvYK+GF12FD8ovJzfp+WpisehR78VrLJODx5u8yugLZNVb+e38Bqwom41VVY+9ISzuwBdDKPGarWNCZJ2ODNjIBoRvvi5DLrYy9QHvFKS0a4zD519S75K+C+tz/V/7BQY9Wlt8qOBq3+r26tIZDAI/xcMHL/X/RFeDzAcOV0R6myv72SHKBcu1nHTMDoLJg3d+sRkLvOYSV1u9neFp/ncA3hp8CbBS+vspBgEnZkXJKD6CQBBi6RELETWr3U9WKXz+LOxN/fUjN+z/xae1DMMXFZBaXU8CSA08YIOLUjjYXY1ln2r6AwXQu9LjRYk7bFMFZD2U44Xe0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUc2cjdhTVBLOEF4dXZMQW5HQUpTVlFZZEpKbEVTaHpFOHNlaURNODd1UTlC?=
 =?utf-8?B?cEdrUW1teTQ2eTZCQnllMXl1NzNSaFFFOWxXWWFFSVJ2L2wxTU5vN0ZRVGJ2?=
 =?utf-8?B?d1RDSEM5VnZWeEdMOWFyS0xSTENYMzJ6SzdJWWFXSEcxMS9SNEQydVphTm9m?=
 =?utf-8?B?OUIrZHVNb1kySVkyTjR0eSt2NktwQlV6d3VlSDRNUUpoUXovb1ZXdEt3L3Fk?=
 =?utf-8?B?V3dsNmdON1l6V2Fmdmpad1dQQXp6SmxTT3ZmSWhOcjcvSGpoeHE1OFZOaFZX?=
 =?utf-8?B?TzRibkJmeGRMelY1OTE0VHhVNUNoQ3RINVpYM0p6TnlhWDd4TnU2aWwwdjYv?=
 =?utf-8?B?YndLbm5BUjlZdXN5R1JPU1YrbU54M1RHb1pSc3BlNDFJTzIvTnRoRXJYKzN6?=
 =?utf-8?B?eWNuWldvakhodndnTGpxYTY5cnQvYVlWYVFwMDRFaldLWTYya3ROYUlCR0ls?=
 =?utf-8?B?eTcyM3F4c1RTbi9DV0hXcE1DbFZjcVgrT2ZqWEY5Z09IdUJVczBRTWJESVk0?=
 =?utf-8?B?VzluTVBWWDdmSWRmYUo5Mnl3K2VJT0szY1RiMFVRME5VenNVUTJJQlUrdU0w?=
 =?utf-8?B?eDdWdExzNFhZdTdodnNiZFNWT051b2JKME91ZXBvSFVsUmNrQ2dQS1ArVE4z?=
 =?utf-8?B?Y3lJeWVhcXRCTDdFR1BSa3BOZ2N2ckNRMGltcmhBTk82ZTZ0US91dHdsQXVa?=
 =?utf-8?B?QXBtUUtjT0p3bDZPVk1Db1puQy9idHUxTnJmMDZmSWlsY0Qvc3A3em5FRVlv?=
 =?utf-8?B?SnhmKzc0RlViZWdZTU5OaEpoaE0rR3NKWlkxT2c0VGlKZjFJRnIzSFJTV2pq?=
 =?utf-8?B?bHhVQ09qTXV3TTliWTJLbmpFNzB5Zmp5OVVMam5wZGNWL1BmSEVTbEJVWTR4?=
 =?utf-8?B?WVFOd2c4NmM1UDJRZzdpeGpBMHpYMXBTSWlpaDVUV3JiZ0N6Yms2TjBDaVRs?=
 =?utf-8?B?WFpETVNtQ2JVcHh2SmlFOFVXS1NFODdXZ2wvcllhSkNDakxVYXg5Rk02Uksx?=
 =?utf-8?B?VVNiRWs3RXUyZUUzamx2WnlBUzh2SzF3ckRzRWc3K3hoaHhXS2dGd1lvRlN5?=
 =?utf-8?B?endFV09JcjhSSGFaSnpXYW9WTHd2d1cyQVBvNkphdjduRy9KZVNYZXRLYXRh?=
 =?utf-8?B?dGZHczNONWF4Ykg3OU5HVjZIMnB0SHdmaXVKOU8ybU8zbFovZnBvbG5XRVRr?=
 =?utf-8?B?OW9pQjg2bG1TVEYveFEyclVhczlxVThycnFlM3VsRWtzTnJaZWZsK0s1YVUv?=
 =?utf-8?B?aTVZNTZoTGxMYVRWN1NlNFBhTDA0YTRGZTMzSm4xOXBVcFg5bHMvRU9JN1Ey?=
 =?utf-8?B?OXRxOUdLN0dPMnA0ai9YdjROeldCbllhOWlOUzlsU1lOd3JodmY5R3BicWND?=
 =?utf-8?B?T29zTm41OExqZzB6alRaNE4rNUhVd2htaVFRMzZyOEtTclVldFFwOU94QnJv?=
 =?utf-8?B?a09XM2pEbmNZbzZhV3B3ZmdyMjl5Znpnb2Z1MGpHME5tbmlHQytodUthWXph?=
 =?utf-8?B?QyswZDQ2YXIzajJyVFBqRkVpcWxHY0E3Y3Z0TklOYnl1SjVWZ3JNQ2RvQUVj?=
 =?utf-8?B?NG1jUXh3TmxuZVI5ZVBwaHRwWGxyTFdMTnpjSzM4U3R6cjRBQm1WdHVDOUtP?=
 =?utf-8?B?T1hTKzFHWWN3UEM1YVNrT1pNM0ZlL1ZwOGNNUzYzRENsaUZhaGt4V2hxNEFX?=
 =?utf-8?B?dDdPdWJhaDZOTHB6cTdTblRWejlvRmpzYlcrOUxkVHpmTmtrL1FjSTM1aGFI?=
 =?utf-8?B?ZmEzNVRvdFpKTmZXYVpSakhTNFYwc2x4c3hzRzRpbk1aUGF0TDBUSjB0M1VQ?=
 =?utf-8?B?dDNCT2FrcFEwbkFtQ2ExOTgxbU9ObFg1Vm1ydkZFNXFpN3BjV2xZUlBBVXlp?=
 =?utf-8?B?VmlUbU10K1ZJSm5EVm9QVzh5WmtKSEhwWE5SdkZFSXpoTU1oSEZrUWJFc0Qw?=
 =?utf-8?B?bHpiSktrTnIxcGRDRlU4UVdGai9ONHM3SWU4cXdkRmhPZmJNazhPZitNOWpu?=
 =?utf-8?B?Qk10WFpEZER1aHhBYzRRWUR6S1pyQnJEVTcwL1lpRDlqSE8wTEN6NldZc1Ro?=
 =?utf-8?B?OGtCNW5XOWlrTXZEMllyRkJnNnc1ZjdEZXArbUtHR0dXZTFPdm9OcnpKelA1?=
 =?utf-8?B?ZStSdk4va0FHUmV6K0UrYUNYRFBrTmxkMEdrejlGSThHektYMUpaUGZ5VVYx?=
 =?utf-8?B?b00ySDdHRXdHRWRmZGExc0ZtUDRHZmhUNTZhNnc1NUU0STQ3RU9OMUJzUU9R?=
 =?utf-8?B?dTI1S0lYN0VaU0xVSng2Vi9VZnpHWjNYUCtGajFaRTZwSWF1YnAzQ3N3cU51?=
 =?utf-8?B?UWdvbjBZQmxRZzZnb1IxelF6YlM5Qng5NlFTRU0ySjQ2YytUMDUrdz09?=
X-Exchange-RoutingPolicyChecked: cAKy60XfWOErr+5ST09L6B4Zk9p8M6AT66zpbY6e+pO4oJ8kePKmn220mjpS0hgHHNpwAOMgdUfUSRvH1do2l6kZuoUfqnLtAFs3d5auowG5MOxxjvyke33rmY+UwuYnm/E07qSCgzojli6DLgX7/XD9hjMGgRwL4Xu1WQubfnGIaioWM2X6eROnTjE+ZKWZ8R6THB5G06weRv3I15GEpehkvltaB4yJPaqOSiIJFUvE80GnhPCIBYhTiMV+vOBym8fJstkWy/DHn+4FsdEH3sRvKUYqPb7o5RGDhRRNC0ZGpfqpkjSC3vEZfRVOGWIgWMBSA1JoT6i5cUCxVOVFvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b2d563-2407-4784-cc74-08debbb39b0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 05:48:41.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dq0WF2jrsAAwceITVGns1yMIWSnsmcFyKHTGsW3Veo0VRR+gA0RSmuNjE1Sn0BzPKri0/xiJUsWliujvfJZhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7723
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-292101-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,patchwork.freedesktop.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C98E65DF8B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/13/2026 12:46 AM, Raag Jadav wrote:
> System controller allows programming per error threshold value, which
> it uses to raise error events to the driver. Set it using mailbox
> command so that it can be programmed by the user.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Add RAS operation status codes (Riana)
> ---
>   drivers/gpu/drm/xe/xe_ras.c                   | 72 +++++++++++++++++++
>   drivers/gpu/drm/xe/xe_ras.h                   |  1 +
>   drivers/gpu/drm/xe/xe_ras_types.h             | 28 ++++++++
>   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
>   4 files changed, 103 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 434dea8bbdb1..4548e5cb08b9 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -34,6 +34,17 @@ enum xe_ras_component {
>   	XE_RAS_COMP_MAX
>   };
>   
> +/* RAS operation status codes */
> +enum xe_ras_status {
> +	XE_RAS_STATUS_SUCCESS = 0,
> +	XE_RAS_STATUS_INVALID_PARAM,
> +	XE_RAS_STATUS_NOT_SUPPORTED,
Nit: Op_not_supported
> +	XE_RAS_STATUS_TIMEOUT,
> +	XE_RAS_STATUS_HARDWARE_FAILURE,
> +	XE_RAS_STATUS_INSUFFICIENT_RESOURCES,
> +	XE_RAS_STATUS_MAX
> +};
> +
>   static const char *const xe_ras_severities[] = {
>   	[XE_RAS_SEV_NOT_SUPPORTED]		= "Not Supported",
>   	[XE_RAS_SEV_CORRECTABLE]		= "Correctable Error",
> @@ -70,6 +81,24 @@ static const int drm_to_xe_ras_severities[] = {
>   };
>   static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
>   
> +static int ras_status_to_errno(u32 status)
> +{
> +	switch (status) {
> +	case XE_RAS_STATUS_INVALID_PARAM:
> +		return -EINVAL;
> +	case XE_RAS_STATUS_NOT_SUPPORTED:
> +		return -EOPNOTSUPP;
> +	case XE_RAS_STATUS_TIMEOUT:
> +		return -ETIMEDOUT;
> +	case XE_RAS_STATUS_HARDWARE_FAILURE:
> +		return -EIO;
> +	case XE_RAS_STATUS_INSUFFICIENT_RESOURCES:
> +		return -ENOSPC;
> +	default:
> +		return -EPROTO;
> +	}
> +};
unnecessary comma
> +
>   static inline const char *sev_to_str(u8 severity)
>   {
>   	if (severity >= XE_RAS_SEV_MAX)
> @@ -149,3 +178,46 @@ int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32
>   	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
>   	return 0;
>   }
> +
> +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold)
> +{
> +	struct xe_ras_set_threshold_response response = {};
> +	struct xe_ras_set_threshold_request request = {};
> +	struct xe_sysctrl_mailbox_command command = {};
> +	struct xe_ras_error_class counter = {};
use a pointer instead
> +	size_t len;
> +	int ret;
> +
> +	counter.common.severity = drm_to_xe_ras_severities[severity];

It's 1:1 mapping. so drm_to_xe_ras_severity ?

I changed this to switch as suggested in the latest patch series.
[v7,2/6] drm/xe/xe_ras: Add support to get error counter in CRI - 
Patchwork 
<https://patchwork.freedesktop.org/patch/728423/?series=164393&rev=6>

> +	counter.common.component = drm_to_xe_ras_components[component];
same
> +	request.counter = counter;
> +	request.threshold = threshold;
> +
> +	xe_sysctrl_populate_command(&command, &request, &response, sizeof(request),
> +				    sizeof(response), XE_SYSCTRL_GROUP_GFSP,
> +				    XE_SYSCTRL_CMD_SET_THRESHOLD);

Nit: Consider keeping the lengths adjacent to the buffers. The current 
argument order
might cause accidental mismatch.

> +
> +	guard(xe_pm_runtime)(xe);
> +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> +	if (ret) {
> +		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (len != sizeof(response)) {
> +		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
> +		       len, sizeof(response));
> +		return -EIO;
> +	}
> +
> +	if (response.status) {
> +		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);

print the error code as well

> +		return ras_status_to_errno(response.status);
> +	}
> +
> +	counter = response.counter;
> +
> +	xe_dbg(xe, "[RAS]: set threshold %u for %s %s\n", response.threshold,
> +	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> index 982bbe61461e..d1f71b1de723 100644
> --- a/drivers/gpu/drm/xe/xe_ras.h
> +++ b/drivers/gpu/drm/xe/xe_ras.h
> @@ -14,5 +14,6 @@ struct xe_sysctrl_event_response;
>   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>   				      struct xe_sysctrl_event_response *response);
>   int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
> +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold);
>   
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> index c29e9a3d43ce..6047fd891022 100644
> --- a/drivers/gpu/drm/xe/xe_ras_types.h
> +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> @@ -92,4 +92,32 @@ struct xe_ras_get_threshold_response {
>   	u32 reserved[4];
>   } __packed;
>   
> +/**
> + * struct xe_ras_set_threshold_request - Request structure for set threshold
> + */
> +struct xe_ras_set_threshold_request {
> +	/** @counter: Counter to set threshold for */
> +	struct xe_ras_error_class counter;
> +	/** @threshold: Threshold value to set */
> +	u32 threshold;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved;
> +} __packed;
> +
> +/**
> + * struct xe_ras_set_threshold_response - Response structure for set threshold
> + */
> +struct xe_ras_set_threshold_response {
> +	/** @counter: Counter ID */
> +	struct xe_ras_error_class counter;
> +	/** @threshold_prev: Previous threshold value */
> +	u32 threshold_prev;
unused

Thanks
Riana

> +	/** @threshold: Updated threshold value */
> +	u32 threshold;
> +	/** @status: Set threshold operation status */
> +	u32 status;
> +	/** @reserved: Reserved for future use */
> +	u32 reserved[2];
> +} __packed;
> +
>   #endif
> diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> index a1b71218deca..b865768e903b 100644
> --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> @@ -23,10 +23,12 @@ enum xe_sysctrl_group {
>    * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
>    *
>    * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> + * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
>    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
>    */
>   enum xe_sysctrl_gfsp_cmd {
>   	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> +	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
>   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
>   };
>   

