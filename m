Return-Path: <netdev+bounces-273973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIw5LITRzGlFWwYAu9opvQ
	(envelope-from <netdev+bounces-273973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:04:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88737673C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED3A3192FD7
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1038F630;
	Wed,  1 Apr 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oF55hfiM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312438E10D;
	Wed,  1 Apr 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775030016; cv=fail; b=Pb72XlN3I/+vJHynCHCF0LYSzu27jeYCn6PpKmrY5pF3l0qsJ9OLSJTHlxZI2ON8gLynyYR2BB+p0tql4ubj07GjleygCw9uXbeVdCszqRzGBLgFLZTT08NzT5ikaNJO9PQTEWI1ANDjQSs+oYawznBpjTdCqFDKp2/Wds9jVKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775030016; c=relaxed/simple;
	bh=mSIs1CUnKPlbGATqzcnnC9vep5SsY3kysVQVu6H/DLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKYog+oUMo6WKwcDfTUaF3dOecpx4evN+jrB1+cYS1bPJZ3GTphtN08sOMmWJtV30NyNMYU7+LGezblJVso2dWu5uRbeL9u57Rit0VuXeJaZ++w6v6YrZ2a5yKNNrA87d1naQ7jpVlnzkvQPB+hGApIRCo1oVu7099PytoXeAYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oF55hfiM; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775030016; x=1806566016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mSIs1CUnKPlbGATqzcnnC9vep5SsY3kysVQVu6H/DLc=;
  b=oF55hfiMrJa46u9pVinRn/0PemluGsNSqV+FbTxTBxKVQWUKpyTozeYg
   UBHL0uIr/+vSWg/3/2RHJsbBLcM5/LBEM12/xcTq6HMuVOkxRN8Zei03y
   iW0lJFK/bpKNcNXiIlzf3GUrKrXKTBwvRoUgfTY0pgy/QAHTi3+lTCfQ0
   Nu6r17ESbieOZTj7nmY84EQNlsVNe2IM6G7zRzGL6ECjHv5tEBmrw+x63
   wqAChTUp2DdDzFlD6zJBaIiqnYUaajHhrkoRSQXqzQhTPbr4bzcvUQn9D
   BSEQtO7VhAdaMonfqWfDfPHZiadaJoz1CwVtdn+3QJBruZpqhHFyD1K+Y
   Q==;
X-CSE-ConnectionGUID: ADl6ydm5SBC1NHMn65Umuw==
X-CSE-MsgGUID: nuT3/3juTAyiUNPLL9YZQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="79664601"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79664601"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:53:35 -0700
X-CSE-ConnectionGUID: fJrkKUeqSlmW9qp7mQ0ivA==
X-CSE-MsgGUID: 8ga69ydqTVy0N/66rXmkGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221746375"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:53:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:53:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 00:53:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:53:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsan7mstElWznlzSUFTMd9zuaSyhagyGWVaic2I36iGgfvaxwlinlNbabHwsUtSvHdnGC8OHCl+9p5P0S4+Snr250w5yupobzOPcwr3PKaGeE6s+1F5lez7k76VEQfdF+6kxhAA2ZhYP/mg5c78v41W2ncR4dAhAy4hW/Kh1hmgP8H/4mKxTyO5fC7PIlXrbQ9Wa3IuDxPC2e7V/6PwjlKXv9gRaL/lMiXdFlXcRKqZyMJcmGNK99pibL2O2EWuG3KUQIZ2YeBPTsF1hKXbM4vzPUefQTLddctEYLDdGQrosQNlP3Xw4Eb8H+1xBs/UsJON/CWuPcuQIwMHsHfXWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW2jozUG2ebdvL2lDd5GrFnp+pLaP0e38TWL7dpC9Vg=;
 b=Dp00MZN1K/PhBjBKOkSD+hZyhoayxe3OEfK3W0jBEyI5F6twMdkjU/XmEYb11YTBu5yM1YZApK/EpXFz79rtrrxhAsV3fbt3IX3hcpQY6xuwLprf8motOjHrgsWZjcGGvBrnqSs5LOVjg6JjBK6U7d7SL+CfVnf/xXaoKYkPq1nD+RK3MBSdhv8CeoAp9U4LKfQPZ/V+8ReJeq7wc+8SmdY3XqeFMjE8W3TlQtB+PUsmWVQOxg/jqVzyegGsEOQKXk9WX8KAveShXGuKLD5aOpWRj6JN/QR7qUuaFIlKMlWnfnxdqCoq94gj+6vNapkKmU1Xbi/gBQNR16C4WpLl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:53:27 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 1 Apr 2026
 07:53:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Daiki Harada <daiky0325@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kohei Enju
	<kohei@enjuk.jp>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Index: AQHcwSMhgqQgBkjY7E6FR0J6/y/W8bXJ1ueA
Date: Wed, 1 Apr 2026 07:53:27 +0000
Message-ID: <IA3PR11MB89865406A4D4891BF48F2D47E550A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260331103924.36422-1-daiky0325@gmail.com>
 <20260331103924.36422-3-daiky0325@gmail.com>
In-Reply-To: <20260331103924.36422-3-daiky0325@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8556:EE_
x-ms-office365-filtering-correlation-id: c4255163-aafd-4ea3-a905-08de8fc3c270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 02rcKj9qa0Zb6BEfQckMGrv49jqC7zVD4N8yA2ot1LVxAJRryNJ2pVEIsjgc7LUF3PHU+n+m8NnvFNN12W81kB0TSzKGH276Z07DWIcuQ3CU5WDb6KwLTeiaBQzNZLMZqygaINIjNhsB7/WNDWc43Hs0u65pF02AgSkV8uS8LmIHFEIsV2Pbldb6Hl86DDcPDA4qiVVdXQI06wS35rlTp+isJr60JDpqV0zO6RKWcBfOiFIak2d3pYwqvrydMPTs0SvWwPg/Ld9ydXnQELbMvax7m69SBzMLoRGabOw9Y2JvPCnfxfeVmWz1LSDzSBPgHROAEOOcrbqtF5J1hceHPc11RqNaPqZwQeuaXWqpN0bxv8qU9iW5Xqm9YoHQuVUCruM4MzrUY0Opl3F0FN7aL4uEZayN/RbfySYNLptnPjcfxV4M0GH//F04pGldO5Xjnpa8IdToaoeH/gN7PBRP1MoTDqedGhVlOBFFmSD77LHIF228qvvon/FWuSvfaplg7bAkJXDM1LVpxx7fGjMPBaQtE+RbpAkaEi9ttJ/3wK8f5V/rm5d1FMDB9+zy5ycGiSufS1y1vHs1MP7TECCMDkrKSu4KSNV96xk68KzO3vJB9KJ7nIfxw91rZR73Do6eoW8ng3IL7e+XP6rRtV52rVs8bdt/fwrWV8TxrmmmyRMQMqlSAbdsTzoGg8sK007sF/grGfjgxyZpylGckds4eMcVwdn+VrPfsCT8YG4ZCOA8KorhfTL4kJ3/dlCaokaGMxSH2u/w3qz/ZOJG8jtOQljhi4lESKLdd46PA1n4suA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+bk702m0EoSbottCvNk5RTuCVEpvBvm07WiCSf65ftPJHwwC7srKg6Y48GhD?=
 =?us-ascii?Q?IsFoPcYXm/Ak6FZlbRDuu6CklFGhXwn84lJ6gwYDXg9d8TdujCyZ5CmIopb4?=
 =?us-ascii?Q?JCJ1KnLkf8crksaBu1k7KfYuoyXb31jVNpV8SkaLj/NQDi7h3QtFbBYp2aLk?=
 =?us-ascii?Q?w73+09loe8jpo1GCXMozgLCrxSAPJDWUmG1j2wM+DNnNwTnPqMorUWaKG+KE?=
 =?us-ascii?Q?3WqLCrhI5oksFqKYmBUhXa6XfjgK2jnGFJWUwyi68tSUuwKx5s/eUAp8uOoi?=
 =?us-ascii?Q?nj24exWSu5ofd9siGRpDg9tE84nYMQKZKqgRef7Ns6kFRIqfZowVxmxY56CP?=
 =?us-ascii?Q?KBAoHu/ovFGF3SMYydrd3OUISepmlvr1BzDoqnY0Rni3kT2hcUdFjimzE8rx?=
 =?us-ascii?Q?y93C5oNUfS6Vwv7ZaZRDFZy3AHPUZjT9gWENHaltY0ISW8gEB/A5N/A1OvkC?=
 =?us-ascii?Q?Y/QBTvZizkmKSm9OAfp3UHqpN2Ayof62DHOesHWfmJ+mZvYSKGmosqzFM+mh?=
 =?us-ascii?Q?D06GpDUD3GdgkFe3cGGWqitAO71D8rzhLPj+l3UbJHcgZ/wJcj5t5xsY9o7O?=
 =?us-ascii?Q?epSicNSXh3K1GrKSasb48qqbtGjEYo9Wg2VLjHy3CPEyetKrlarnVGKCpiEy?=
 =?us-ascii?Q?FLR0BRmf+xeoH061Cb0U8iH01ya3OAicCrdSlFg+0iZrvfzcOJuCdFWQBIVR?=
 =?us-ascii?Q?wjxVh+dPgqN+Bqxyj/OfsK5nPZUwfbNTAOXHtPnqsLjOMt27VRpCFntf9uOt?=
 =?us-ascii?Q?CMxDRP8apkRFTVo4mNNktKf5/2u7MAlVM5hF3jFzOe32D3xUj/LL92a4ZgSA?=
 =?us-ascii?Q?uQpHQUk7hSUzDUf1BZdv3UP/6sH2KPV2bdeA1i5oYo+CteopCnZLxeslN3jB?=
 =?us-ascii?Q?sATMdpuS543RSVp7eSOYk6+Uk0LjzAy6Vi6Jba3OANYMNf3dTahaP2amy7AB?=
 =?us-ascii?Q?r8uy+y6xVeud+Gdd+ibOHoEB1A2lAPLWHDCMr85MrbBJLBa8Smjnv/cu2LMQ?=
 =?us-ascii?Q?5ZiE09f5i8rCfLd4l94GIGTNTVXR81jeYoMnc/ya4oDirEWLfRjoFP46jDVK?=
 =?us-ascii?Q?HYpWg/XACg5+Rs5IOqyEt5SFSX5jTRSH7hkoF56TgBvFkYQi1Qo1pWw6MpW6?=
 =?us-ascii?Q?2/npjZRnPvvlaOmWMIb5bJQOIkNLvmSFX/Vjfz8JBKBYj6TO3zAAd4wrbTCr?=
 =?us-ascii?Q?tADOG3x4KFIPHClIHwHhoCbHe9ZvZg+EF/YPp1JCjV0Mwu87Wfz34olL5kPe?=
 =?us-ascii?Q?4m3AIDoYhQNtqt2O8qhiUJ7qF8Oej9R9Rp5VUQldHdygd4GAeeSnbs2HJ54L?=
 =?us-ascii?Q?KjXX22E5I6Pek95LLxW+Hc0xoKSXeqA+2uDDsK4+XRU6j0uRaPIVumuFUPS0?=
 =?us-ascii?Q?4O4I/1uvboiIR9yqz/y8FtPSuMWIeWmoe1bZhC8rpDGz+7B6cP2D2c5uRZoH?=
 =?us-ascii?Q?LsHh1VL0wvi5drpQnbX8OxaqP84EmoSyOf6XHRltBOjE8IZbesif+2gx96o5?=
 =?us-ascii?Q?CUmkxUOPkS6bF2eZvXAgM+85xct9e+X4S+Vh45FOgReKrlVJY3xC1U2afB+d?=
 =?us-ascii?Q?38qQRpomufypcpE5xCeOlg2V282g3ubLss2mdzqza5M9oXjOmF7Wq2ZpVBbp?=
 =?us-ascii?Q?UBdxg41u7cGV9tIfNubzs0i5rwt0dq/Tj6k1/mLqOn3pwoU/yVLnQKXWE63y?=
 =?us-ascii?Q?PX4HoFdK3X7DCjsrq4t4VvVSYz6b9Y7SBeOKlSP0dMYEMyZuN1MQkc06f0c+?=
 =?us-ascii?Q?5WmybDeKXGUeiaSPqIc4pdR3vsucGns=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mWSBpuo/6Wr7zLHNILnlIWldMTftMUySLAd8a5OQqih8Ynwu8jBiZ3ZvZqGib2SdC+EHr+nF8xOS0OhczBMzcOGBnYrqxDMJ3C8CWap+EpPrTrH6fUgsn1l9Ta2yrU2TnZguEPsc+dvZWBv0FyZF6vjnn2w1RNvK5vRpArBHLv/GJvi7SUcij+oVs/YxI3w2tFpAoYAGFzLQHTi/HfwQZgBObviAsjvADFpvutRf3KFvCcBwlpRNxds+f1hE6Ods0WIuPI0ulOJJfVuH1UNE3+gEl2QTACDUuI/iE7HMcc0IuapuXUDEBN2RvEyh3TAa7r1zZyyCC49Lv3+CD2Gs8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4255163-aafd-4ea3-a905-08de8fc3c270
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 07:53:27.6333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlnRJIiSsvDcs5iH7I8tRNKNCkjTCj4x8dpl+RBPbxPJcbsroPuMGLpZmikkJJZfXSHQZ9cler+6l0YDBl/EmsM0YKkrOqXicWbT/kcUn/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273973-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,osuosl.org:email,enjuk.jp:email,intel.com:dkim,intel.com:email,lunn.ch:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6E88737673C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Daiki Harada
> Sent: Tuesday, March 31, 2026 12:39 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Daiki Harada <daiky0325@gmail.com>; Kohei
> Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 2/2] igc: use
> napi_schedule_irqoff() instead of napi_schedule()
>=20
> Replace napi_schedule() with napi_schedule_irqoff() in the interrupt
> handler path in igc driver Tested on Intel Corporation Ethernet
> Controller I226-V.
>=20
> Suggested-by: Kohei Enju <kohei@enjuk.jp>
> Signed-off-by: Daiki Harada <daiky0325@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 72bc5128d8b8..712605886104 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5688,7 +5688,7 @@ static irqreturn_t igc_msix_ring(int irq, void
> *data)
>  	/* Write the ITR value calculated from the previous interrupt.
> */
>  	igc_write_itr(q_vector);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -6059,7 +6059,7 @@ static irqreturn_t igc_intr_msi(int irq, void
> *data)
>  	if (icr & IGC_ICR_TS)
>  		igc_tsync_interrupt(adapter);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> @@ -6105,7 +6105,7 @@ static irqreturn_t igc_intr(int irq, void *data)
>  	if (icr & IGC_ICR_TS)
>  		igc_tsync_interrupt(adapter);
>=20
> -	napi_schedule(&q_vector->napi);
> +	napi_schedule_irqoff(&q_vector->napi);
>=20
>  	return IRQ_HANDLED;
>  }
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


