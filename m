Return-Path: <netdev+bounces-267906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAx5Kpq6tmkyGwEAu9opvQ
	(envelope-from <netdev+bounces-267906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C9290D39
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A376300C03F
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D82FAC0E;
	Sun, 15 Mar 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiWpr/Ld"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224F1459FA
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582999; cv=fail; b=LKKeVpQXKyJri5NoMNs6j0nF0pGlsPmvPiVIHqgj/Ncmz4vDU3B2Op2UioqphXlYX8A4kUbAyjUuCFBCs+eIMC0C0PDiAAMzvO96AvXAUZNwN0KFLqKe2dOHqGMZk5uXCs+0db1ruR3PY3qYGAWbuoKpvXJ+K1E826lg+frR4B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582999; c=relaxed/simple;
	bh=mv842J4FnRZ9pyJ9ueJW0vpAk3q+fCFOtECPWVMmfM4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k7wrCarHs6wSvsrNuXtPYj2x17mt9DTwl1HZhRaxlWBHT7gu6UqWiIvh7UqroxIoVK3I2AEeOMg+iA3Eb1JAShkcWIqNiH/+9gVVGHKO5QDyCyxqpSP38yVpzIMtef3Jzxt+zq4l+cttYWjddyKbkI8BctaEjssHjyihUcdxF70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiWpr/Ld; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773582999; x=1805118999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mv842J4FnRZ9pyJ9ueJW0vpAk3q+fCFOtECPWVMmfM4=;
  b=XiWpr/LdHSsb1jUETcDZW7oamGjgGIWyK13rMLtZD8ZhXA4WSdgR7zVU
   v4mKwodIGUoZrrYBjfsXbhZURQH7LWSnj68ZS1CqTy3XWLXiRRFW0BQM6
   MhpSWXfttIDcGGx/JlA3qulfehXXiJmCLokiqcjMxpgTcWgjjKmgm3FOB
   CaGeS7/MDhoiBYhaN0K9wW+7ihtMmNGINOkfidxCDMjasqqUjzqmRRbW+
   +eFyziD4/B1SB//z+UyNTiZbIVRRNL4dIYcKDwqx+U3nF+w6MITAhO96w
   Bpi9F4YM5cJFQLsI05BMnADdc+zD9nUfpTLhXsMLdDIEotlCcbug4UfzD
   Q==;
X-CSE-ConnectionGUID: /6QOYh2qSxeBBWPItj4u/w==
X-CSE-MsgGUID: VGSp/48mSuix8KPqlTZpfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78465214"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="78465214"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:56:38 -0700
X-CSE-ConnectionGUID: 3UpYE9C8SnSyb+u5Op2fsQ==
X-CSE-MsgGUID: Nld/up3mSoysGZOxh8szzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="223929958"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:56:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 06:56:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 15 Mar 2026 06:56:36 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 15 Mar 2026 06:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJC+76vX77qNk91AG0JcvBukmF8Jsi3DWA9Y6YDX5TlKZzdjNqzmegOsvStmofnJuZLIaHFz+C/Ra7v7UBdCBk4eIVEZPIWwWh53hl2jLVIjxgb9eMxnhxtb1x6rOWVDyOfN2FZGYoAXzuvyB9v/MfZwOKcrUKgxKSs+nXbO/u7EmxGSVx3aZZNQ3U3rWZgT9YC1GPCpr3PhP4w8GpqA2zZoXO2PvWxICaoDV5ABTzGO8+QXlmURGKu4Zwk1gDUpoKWwSe44DHRSxsAuuTZlgxVCWSH6gf8Qas98slU2pT9Vza4Bsfwp6m/k2sRO7qcf39ETuAkoIsVz1zYRbolCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1IhabHyG5aTPHRyDnr78eZi2dqCdK8mxLc/pUYd6Cg=;
 b=jv6Rih2N6/m2JNLTf/75tLTCZsbT6JAFBKJJpAqakoUwFIk/0WT3ye6wvnckpZ8T0188CMPl8xgpajpc/A0jcvw63WxgvHWxAv/qmNUXm8/MFVITICSMo41XfTXMMNyDXKQFCCxgummB3XqCba8jm09C1DtYY9YptLVLea1Of+juZD41JJgC7tx60VropPNCK5ErIavw5OcMz09v3dKBhEnGZpuz3bhP819hVvSreh7OHM+1kW9bJuDjNyR8mmjmleT5wJf1TA8cVyChhj/bV/rXKdh8ata0WqSiU7fY4RyHxtW5LuJc/0q08prKwqFnlOAwDFAoHoLAv4P0Swn2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by DM6PR11MB4609.namprd11.prod.outlook.com (2603:10b6:5:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Sun, 15 Mar
 2026 13:56:34 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%4]) with mapi id 15.20.9723.006; Sun, 15 Mar 2026
 13:56:34 +0000
Message-ID: <25df2a93-07c8-477e-9717-fb4a815cff2c@intel.com>
Date: Sun, 15 Mar 2026 15:56:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Kohei Enju
	<kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
References: <20260307182808.155027-1-kohei@enjuk.jp>
 <20260307182808.155027-2-kohei@enjuk.jp>
 <IA3PR11MB89862987ED725ABA6AFC2199E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <IA3PR11MB89862987ED725ABA6AFC2199E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|DM6PR11MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 828e044e-ed03-4a86-6b24-08de829aab06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: g0pkvddQQWoH9hMm2Tl6ecscUnYWQOu7vjby4uWRW+hEyUC57Rtz48p66+wQBLScrUfo55cfl8BtT7IAWby9WbZYArX1FkGxzof0DoDvSyQeARy32aCquXcaf4l74vb4ubN2f3zLaI41vcGX2LunahmGj4S+g8p/98kQ+yqWDAV0c1UrUYs7KB9nLe8zdKWtEKt5ex18Yp5KDnD7kp3KPzZHxPfPZl1o7c3OCnm4YEhg2RYObhUO1azeneJAGESpC3IzQv3rVt77coJBvcxO2PS+uC4dLOX1tRuPwoh5LIL/3fDH8gpmYtfaIjgtZEzINbzELisb88ZxfmUjioiRKwYlpcisR55dtHCoVaJcINfZhxadzkeZyQq/Vom7PUmngkeakh31kPhacG5SswEnkt9uqtoxhpNs4fe4K/9SpL58qyT/7H0l9GHAwuSyinMRlIlvKeDx2wRVc3nRuhcwsuVu688FiO4ZWle5BD8m+vOBoMMpMkY7N1TwZEJccdbBwtycKdzxZ2qcmfG0u1T2TdJ5v821OVu3XKY8DZ5xClSz3nvrgx1S5cgMIXw4ZtX2tBzq5C6lhdmEdV+/IIDj1sm148813HyKkKd23ApdhM64SxdjF4jOfJ2jOXgLCVwYSbsUtJl0iWo0ufT+jFo14gl43H4uuiqILEiBY1B/UCOBJtTg9OhXFmkVthKN1eYM0ZYz59ds5dDCh3VwRBJ9Q0sGONb+4ExUKeqnp6pe0nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JsUGVYb01IWkFqbzRJeTRHRGIrUUNsaGNPOW4yU2lORE9iWUJBTnFPVW5V?=
 =?utf-8?B?VVFQeDZmaVFzSm94WXpKeVV2dUtJRFNnRkEvRU5xbnFWQkp2SW03Z3MvbUxk?=
 =?utf-8?B?bW1EMzlybDlhR3dGZ0VtQS9TRTNEWm5ONUFrTFluYUEzZnYzdzV5Q1g0V2lt?=
 =?utf-8?B?LzlFNVNFQko2QkU5SEIxSVYwdUtNYzRVUEZRNUo3SmpvbTZZTmIybnBRb3NY?=
 =?utf-8?B?bWtTYlc0Sy9xVkNQQVlaWXQ3UGdyYzNNVy9ka004OWg1M0s3U1d2cmdicVlD?=
 =?utf-8?B?WEpZK0RDNGl6dXVYbDY5ODVqTWN0SzRUZTJ1d3p0N2hxczQ2OE03MzZpREZy?=
 =?utf-8?B?enk0bUgwa21jcWQvVHdFcE1tdGYwT2RsWi9jL0RPSVRhUUlObmovZ1RDeUFy?=
 =?utf-8?B?R2lVclkyY2F1WUpFaDBvY0Uvdm9BaVFlZFZLaTJpMkk2bHJ5RlNrbkFQalJI?=
 =?utf-8?B?dXdBb29vaFdSVHhJdEc5emJNNHFWUERWdlNXK1JZb2N2Z0hoRTJHUEN5dEYr?=
 =?utf-8?B?ZGNwYk1aYWQwMWZUM2F0anZJUXluMm9VdXBHdmtWQnhqMUtyU1crdzFUekRx?=
 =?utf-8?B?T2x1S0FwdzlKczIxdXhvUHRHaFZucmxNbHZzSU5BVktGWDJ4Qk5pcS80OHFt?=
 =?utf-8?B?dzJZdVFaUXE3QXNCV2Q5eGpKK1RCaDdpbzAyMXU5QWJmeFUwMmNVRnUzcEMw?=
 =?utf-8?B?Z0tIcE55N3M3WHNodkRjYkJBVktDWGpGV0NGOTNwbWpUWXIzWFo5OUV3VEQr?=
 =?utf-8?B?WWRNbjNITWxibTJwbk9iNDMrN3JlYTdUUG9SUER0MERGNVZlbDd4cmhmaVp5?=
 =?utf-8?B?TVVrazZFODUxL1FaZE01Rkl5Y1RVUEhmNXZZTWU0WER5ZTV0ZXBmbmRIUlhQ?=
 =?utf-8?B?QldxaExJMjFnUlg2L09MQXhKc0ZhVjF3RzVWQlpZTGhCSVRJQjZGTUt3VW5q?=
 =?utf-8?B?T0d4VWFXWkhrMjB0bzRsU1ZlRnJHbmRmYklXRElHTG1GdjB6QlpxbHdjRHJD?=
 =?utf-8?B?TzRlVlZqb3krdEZzNkMyN3VhSG82cldteU9rK08wazFnMmMvMU1iUGFHTEJN?=
 =?utf-8?B?cDBoWUhvZmNsVkY3K3Y1Si83cEtwTG44MDNDU3pJTHhTbFN0VWlycU4yYmdF?=
 =?utf-8?B?ekhYWG9DT2Z3STQ1RU50aThlQVVXZER6ZWZuOUE4UzY0R0dZWURIUUxvckZD?=
 =?utf-8?B?a1Z1eVkxcDdCL3pRdytGd2Z1eC8xcTFLei94YTBUMGxzclZ1TWtuaHNoWDJI?=
 =?utf-8?B?UUYxelVxNUk2dmdqYlZZZU8waitsRU5vQmZCeW1mWGNqbkZCQnY2Y01tVmdM?=
 =?utf-8?B?VVlDbDhGcXpsdENRTUJYcTVWaXAwYVU5SU9YOWxJZ1h0M0NKejhwNURSZHN6?=
 =?utf-8?B?dDd1a0lIM1VuL05tUVltamVlZDhkZDF3R1pFKzhvOTlCMDVtQ1lISUlubW1S?=
 =?utf-8?B?Nk1WT0ZQSVdreXV1c2xjd3NhR3Rpd05RYnRHQVJlOStKUHJqbUx0akVxVGZE?=
 =?utf-8?B?VUcxdWRPdzNEL0E5OUJiQkhoREh6VXBjNW9DS2RHZU45dUZQOGgrcy8wR29O?=
 =?utf-8?B?Ry80TFBTMUdMUkZMTHJCTk9yZnJ4c1RIeUcxZnRGdks2a0hNTUhlKzVnS1BJ?=
 =?utf-8?B?aDUzb3BTaHZhR3QxSnZ5aU9tVlk4ZmZ5dW1IdWlOVHdBTjNsakcrNWs2WDNZ?=
 =?utf-8?B?M3RpODZIdjJpQ0hMMlBqS1hRZkRNbDMwd0FwRFM0RGp3N2N5eWM0VEVwQVFN?=
 =?utf-8?B?VjNYU3dlNHpNYURXWkRuUFgxZm12U01JSi8wNkhxS1o5aWFwTmVvVkUwbUFH?=
 =?utf-8?B?WldDaTQvVEp5YThBSUlwb2JadjZxcXN3VlkvZHJTazVoV3FKRm1yVzBSdWtG?=
 =?utf-8?B?eVRvUGlMMDR2OXVIWGoxOFNWU1ZOdWtkU2VhNk1CWG1tKzEvYmxPVTM1OFRt?=
 =?utf-8?B?bUNIdlhMTVVJbjlhWFlDUy8yQUxaa0w5cUJDWE5xSFFhd2ViOGV5bWJXUSt5?=
 =?utf-8?B?ZzhGMjEvdHQ5QUdKSS9IQmFOYnVTWG1ZUjFzK09ja00yVGNhVXM5N3piZTRo?=
 =?utf-8?B?bFNxRE0yY3g3TnErUjdvZ0U4SUowbzhUQ3ltUW5uZDZ6YjVCSzh2anJGejRh?=
 =?utf-8?B?TDc5R2tGN2NhNGhOK3A1N1QvR1hoTkl3c3VPU0hMUlplMllRQW5hVmtmU1Fw?=
 =?utf-8?B?Qm5jN0tJVGhJV0ZqR2M0b3BWRiswWGJsMEt4SFAwNThPeks0V2FzOW9pd2tC?=
 =?utf-8?B?STJPaytibTdvL2VieGF0NmNjN0lKSFNoNVNUOFpaK3lWRUdROEhPdTlVSEpp?=
 =?utf-8?B?dTZQMzNESzRMRGRld1ZTTno3Rkw4V2dOUmRHalNVUGdlYS8zZmxnQXd6TEp1?=
 =?utf-8?Q?JMATqmn7arvRSWks=3D?=
X-Exchange-RoutingPolicyChecked: H/n2g+w3OGuRdcz/U7xeu0TlLbyhVQXgzxGJfNVtcWj8pYE8iEGf32bfn58UW+0tcaR8Z/2lB25hp8VHTvFdniFl5T7XBVixXc1haK2YlRo96Q7bR3VX2xCwAEMVxCU+dDpr3R0YJHZPALnXtFqCDOiA2/Yi5Jcs5rX3e76XauEdeIV/Y3sTR9NBGQY2MfhaQvm0cIUpL1futXAXlRIfwueUyqTfEKp/Gwexqgb1bHhXokcCiArGpCuO9ye1FnihovBOarWHtayRsAN266E8OIrYPekEz4dwKzyoFAUsB4QCE23l+pk5izoBmgEx7/MiMEB6XQ4xsN6bfXVqWofNsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 828e044e-ed03-4a86-6b24-08de829aab06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 13:56:34.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKkzgJb4An4W9N5T3qsGEKurIwVqdSFfzIJhclqDGS26ul75B7XO1ukEsmRteb43GtDDbDFIBqNq2UQ3YKxS0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4609
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267906-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CE3C9290D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/03/2026 9:43, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Kohei Enju
>> Sent: Saturday, March 7, 2026 7:28 PM
>> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
>> <kohei@enjuk.jp>
>> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX
>> hardware timestamps in igc_build_skb()
>>
>> igc_construct_skb() sets RX hardware timestamps, but igc_build_skb()
>> does not. This has not been observable so far since igc currently does
>> not enable the build_skb RX path.
>>
>> Set RX hardware timestamps in igc_build_skb() as well so that both skb
>> construction paths provide the same behavior.
Thank you for this patch, it is nice to have consistent behavior in both 
paths. :)

>>
>> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index ebd831a4ff53..3a4c1ebe4faa 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -1964,13 +1964,16 @@ static void igc_add_rx_frag(struct igc_ring
>> *rx_ring,
>>
>>   static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>>   				     struct igc_rx_buffer *rx_buffer,
>> -				     struct xdp_buff *xdp)
>> +				     struct igc_xdp_buff *ctx)
>>   {
>> -	unsigned int size = xdp->data_end - xdp->data;
>> -	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring,
>> size);
>> -	unsigned int metasize = xdp->data - xdp->data_meta;
>> +	unsigned int size, truesize, metasize;
>> +	struct xdp_buff *xdp = &ctx->xdp;
>>   	struct sk_buff *skb;
>>
>> +	size = xdp->data_end - xdp->data;
>> +	truesize = igc_get_rx_frame_truesize(rx_ring, size);
>> +	metasize = xdp->data - xdp->data_meta;
>> +
In the spirit of consistency, would it be possible to restructure the 
variable initialization to match that of igc_construct_skb()? Initialize 
xdp first, and then all the size variable inits can stay as they are. It 
would make the net change smaller.

>>   	/* prefetch first cache line of first page */
>>   	net_prefetch(xdp->data_meta);
>>
>> @@ -1979,6 +1982,11 @@ static struct sk_buff *igc_build_skb(struct
>> igc_ring *rx_ring,
>>   	if (unlikely(!skb))
>>   		return NULL;
>>
>> +	if (ctx->rx_ts) {
>> +		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
>> +		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
>> +	}
>> +
>>   	/* update pointers within the skb to store the data */
>>   	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>>   	__skb_put(skb, size);
>> @@ -2681,7 +2689,7 @@ static int igc_clean_rx_irq(struct igc_q_vector
>> *q_vector, const int budget)
>>   		} else if (skb)
>>   			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
>>   		else if (ring_uses_build_skb(rx_ring))
>> -			skb = igc_build_skb(rx_ring, rx_buffer,
>> &ctx.xdp);
>> +			skb = igc_build_skb(rx_ring, rx_buffer, &ctx);
>>   		else
>>   			skb = igc_construct_skb(rx_ring, rx_buffer,
>> &ctx);
>>
>> --
>> 2.51.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


