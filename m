Return-Path: <netdev+bounces-231544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3460FBFA475
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A74858418A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 06:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105432EF64C;
	Wed, 22 Oct 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzA/GBm9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072A2EC09C
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115395; cv=fail; b=au4ATIvbwu68vgdERtTWyTID3CvqytQqZgZtJ2FTEwWMoBXjA7S1FDjI/TmXe52xMv4E79GDrzFgzCc9HQLxU6J4X+e2yGrocH+WO0Jf+ByMD59OaCnvNTOHWCDiB+TDsFfuG63k7vPvKRXOvePRCFJ84bFMOdAWNGZcE9SGQaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115395; c=relaxed/simple;
	bh=Zxi64JVxmvYdMBfrykNyAZob3vpvBTvJPxtZQYt5CT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YS4AecgzfuWyAu4pfp1J0iowy57qpmU5gY/jMcOtfTSWJIQ7GIzvhLsWHtFF2REK2AuIuKu3uoJDddCp7yVyyoS5pt2s4xZ5bXbMzcRHg7JTjFuJyiktS2cLWkdjDmOz2Y53iI9QoAj2TfCNhlYqQTqEetlAzb0QuwQF76jizuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzA/GBm9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761115394; x=1792651394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zxi64JVxmvYdMBfrykNyAZob3vpvBTvJPxtZQYt5CT0=;
  b=QzA/GBm9rvkrvfWZOPf1xQA9niivs75VrXov6zJysCwfaLb1VhE6MPN1
   bvtYZmn/hzpGgoJd8JLLpDzes/1mMrbdx7HQ+0e1ufRT9IyM74PDUCv3a
   tAGDrsAbxCq7gE3mcfgNOcXGqTXYzcM1Ntaay41b5MlXIgTzXAzjVZLQj
   VIVJzPjwT/89DiU9yjlF82RUs6dRGZGt+LCVKbmSryn6BpYCk6Yzu10Xf
   ajafShvZBySzImkUcSOPVKDc/yw75dcnUy/cw6/mejo1Q9V/3QO0U3IQN
   BatCNdHZzO5vwvvcvWi/duWabXDucdOr0jalXfRD8BVGZNUkWskeyIw1Q
   w==;
X-CSE-ConnectionGUID: l1Sc9UC4SOSX5K53cMmtgQ==
X-CSE-MsgGUID: nPLi2FRiQm2gI+BXnJWEUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74691693"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74691693"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:43:14 -0700
X-CSE-ConnectionGUID: wCG47qXvTPW4PSN85OcFRA==
X-CSE-MsgGUID: 5Fzs6mZQR4WuzOU9WKnKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183823942"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:43:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:43:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 23:43:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 23:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpcZIeJiSlOoAcYYmaGFShsW6BJdoNW6NIM00VAAtcxtZOFIQBMD3MWePHgkJw6X/Q4GDYClbMfXyJbLsgsoyvFYAD3WuYrz4e4MxwWEPYNGZw126UjNslxEImUK5F7dOxOiuX5OLZF0Jx2CK8yl2ssfPrcydo9vCDg2SIThXGz2zvI4Fe6s47f3THmk9ZCI6cUTtO++jzX1qMrSw1xbnHWqWCeEmYHz1WRMrcoHGXES0WRLpTmGwDGOdkV0DTXMNhh1HGX0hpVRJ0QqgOszQtSdFpe4LfAaw4XcVx9n21L3Khdh6NtMM+5F+K+uiDnutn9POFF7OT+3awb4otVxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/GQzRiBWwxlgYqBTj6fCYQTQEThOEZzNYgkWQLLtgM=;
 b=unbNGP4zZnu9y3ZqkhpMMl2xfHeU7C/whxPH8SWE9MJx5bsvFhypeuiMItVys2HP6HUaLOXKdtsTZ2wP8mPBQUSF/3Tu9dA3uJgN1/vnpzIOiwPMIZv7KDcuVT4Vi5ZbTKtcHpRcBnTbl2+DXi/GBRE8Hs0B02C6BaCzySvC6XmjM5onoTc0AHPNy5Khc64ysIRYiQtQ20REvXdjPkNeCLHrtpEH8N+nrM+9XGvB9T71u8XcSR572VuCrxNfxQXzmuWRSGYjuQfaKs1HZzOf4gMT3vcoblsPDQsRJ9BK/AkZ/ZNpdFKSlvs57526rOwsLnMyfgYlRIvHgEk+0SBbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:43:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9228.015; Wed, 22 Oct 2025
 06:43:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v9 06/10] idpf: add rss_data
 field to RSS function parameters
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v9 06/10] idpf: add rss_data
 field to RSS function parameters
Thread-Index: AQHcQuFapV/ppGpbRUW0ZO2DvPEMf7TNuFRQ
Date: Wed, 22 Oct 2025 06:43:03 +0000
Message-ID: <IA3PR11MB898639E6E3103A1DE513E155E5F3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251021233056.1320108-1-joshua.a.hay@intel.com>
 <20251021233056.1320108-7-joshua.a.hay@intel.com>
In-Reply-To: <20251021233056.1320108-7-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ1PR11MB6155:EE_
x-ms-office365-filtering-correlation-id: 5bc6ce5c-b6c6-4577-4d94-08de1136402f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?0pHPOvNwS+QfJUcNZBsHA3d6PIiYBBAcqYH2bxznOUnhZOtIegM6ySNxyXbU?=
 =?us-ascii?Q?SOOQEcjs/crPGBHYGg/uxU8RrzpcgetF/863h1AtNK/BoEt4nfMdHtOf6GfL?=
 =?us-ascii?Q?ezkvSJWxxjzDp8R9PWkgldo/F+kL8UlhqcYkRzXbds7w1vfn7FIFr/c+FgPI?=
 =?us-ascii?Q?2W8U04oamgewyrIrVKJSmatvhgeJOF1v9lezw/vjW/he1gXp/veAlvgHplGS?=
 =?us-ascii?Q?z7fdBrR0oCWKYhjYOdNgl+meGU5DjMO4T4iQACfRCZnUtzeObGhEKaX0Jo7o?=
 =?us-ascii?Q?IaZmyJQTV97YbO8upO8txTROqd+qKRIYjFEbOi/BUv/fXkouI/3utl0s9NEW?=
 =?us-ascii?Q?u2GJ2+VaTM2Xoy4c+LRO1q/miA9hPHgKcU7Hlnm3ghNVnbRiuNytzBhXAk6L?=
 =?us-ascii?Q?5qNG+ufYxgpaYoU9MISHjL8dxOKMow1q9B40upwIThFLZxDSh1Ui5xcgVtjI?=
 =?us-ascii?Q?0O3NX2J94Ni2kdWQBZXZvBe2/mcv98fj1gL/l0cutwzJOG6g0ow4I7nxvA60?=
 =?us-ascii?Q?esLm8ww1NmeLYmDV3ERiC+aWqcRCqwDFL+dGfA6QjpRvVOWnSxT38YXGcB7M?=
 =?us-ascii?Q?q01cKEJUACeXruj9HwnVbVVt/rYJnpqtwkVilOqDYNbEc8TBTaj9uB//fdg2?=
 =?us-ascii?Q?QhmOktl0a3fri8BeailxpgbEvFdcbSSpOykyB5TnwZqg9TcIGhFLrberrQpr?=
 =?us-ascii?Q?ksR6P/CgDbPKB8PlvIVKnZpU4RzpIbObPL8xPpY/9Zs05rbnHmOuqmht0eAG?=
 =?us-ascii?Q?M2GGBKchrJguqHcP++pmlI+jpAp+oP22myeZw+9JeW+MvHLTlZlclvsHv/PR?=
 =?us-ascii?Q?0I+EvSUFIjLhq1NF/t997R54T4tv2ve/7+4DTv6QjHdmc7XXdTvSnpOxq/V+?=
 =?us-ascii?Q?xKX/gT58GVIn2Q8WxODjXLbgBs6U67o/pz9+cay/E9fwVsqibLBygm5b659j?=
 =?us-ascii?Q?DBtyygd8PTwAOTYtEBfV05nLMP9ZTmScclTA7B4fa9Tbf+svEcXhtxlAhbKD?=
 =?us-ascii?Q?Mwwyi87eYMAZOsAYBZt525qVhHuPYilp5Taf4HKmxM8L5K2BwxUa7Nk0yLUb?=
 =?us-ascii?Q?ySv5WcvEuMhzLUn4103CHroAhqpPrrWOJ2pAF/Mqm2V+2uFxk5j2G+3GiJ0j?=
 =?us-ascii?Q?Qm8bGHrErxlpEBW1cLBmVBPejEnaEJa2IWiQzeMUX5MCp5xrLeihMddR/uso?=
 =?us-ascii?Q?MiaruL1PGNhY2hAKkVUTxmMniHw1YbBqbr3PK9n/8Cww2C2sdo4RrgLdmU/S?=
 =?us-ascii?Q?hTUzYCWAfOjlGJo1o/UyOUiXdDuRWH6olWK7tMWhaCst5Pl19ZN1Y1qgfkvX?=
 =?us-ascii?Q?JcCyu8lhSgi/uGXCsd12Lc1aaGK0LpvEL2HKh/yN/yDP7ToR+axxhgY0PN3w?=
 =?us-ascii?Q?1QvMZxFKBDJyYfiLQH7MYcczaXVy0fYOMNtLjyQpkuWlT2gRWV/5vRgaoDNh?=
 =?us-ascii?Q?3/z2DAdl+CNK0fbCB/gUlhBdvAXzpYhrQXDOQEUbaCUo74Xe968mRM4DQg/p?=
 =?us-ascii?Q?UaG1zdj2mVezr+6/mUCtjWSAycZPfvrsSQKb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NUFYWbEap1kTBwQmAsMHhu9Om5KFprPRx5m7DADOHcph70NhZBctX3kpghqy?=
 =?us-ascii?Q?B3AGFV+9atU8mq+bKjFTaorIYD2KCbppnPQF+QZBwLP4lE3O8T7UeeItacub?=
 =?us-ascii?Q?6U5VJFAaC9UNKZX/LBaAA8MV1CxgmSE3XvKXXWfBTyKX8zqpd2GCVvVVNOdr?=
 =?us-ascii?Q?rGIj0lhk5dByOODCb8Gl4vJnvYNfEwzox4YPjZmtP5UMGox0XIh9ECHZaFZh?=
 =?us-ascii?Q?gm5PXPm2ygqkVFKzPWcHtw0lVjmY0cCRAfIA+l1oGLzqquWsumb+qFSiOTP9?=
 =?us-ascii?Q?Uc92C6GTPAfWyPC8xd1eQKTpuEvnQbOpJMXIqPQgxKwZixQnKqEsii/wVM/+?=
 =?us-ascii?Q?mcx2C4lJgVVmpOWFU/H8x4ZQJY673oULjuUWSdkxSCpBp5L/8HKpCVFuyERx?=
 =?us-ascii?Q?05bxlH4inatLbHKi3YpTbo74l2Z/alYoy1Nb5CitvD/kfaAUb6VptH9YZ+Qm?=
 =?us-ascii?Q?vqRR7RyvopAIHRIW/jQZjTIJRj8pxXeNrNbq31Q6NS5CahGFzeg6G0cgTHbW?=
 =?us-ascii?Q?XH0J+mzwwHiJVvk7ORaqD13lvN/4SCQkpJ+FMbEI76qeIfMii0b9NP1XqrxH?=
 =?us-ascii?Q?YhJwv74Kvm7ISA3Sfw9MGzwhn4Wzn/XCJJlNrEs4wqJ/Kc33s7e14MrO3rGi?=
 =?us-ascii?Q?2swF4yeDaL8YJ312e8NZX5aQgltpN69qKnrdi3xc8DC9dUw0SJVSNeHcCJun?=
 =?us-ascii?Q?ffbqOESFS3HAfu2bB9Q89+3kod7yM9mkx6Iw9aeArz0ED7YS8QHRSSJKFAif?=
 =?us-ascii?Q?4+zFCmmQLSp8PdcE5p9oJ+08n/qGLhHK3xHbzbHIbO9kPaOAQvbeteArT9KM?=
 =?us-ascii?Q?3F3AUvKJHnUHqL3XtQglAM/WPWCufWVTPf3OPoZRHCh4DZFM/NnivWwTf6cH?=
 =?us-ascii?Q?tJVGRmcyOA7bhNlxDOzoHg5iB8mESsSVkjK8WkBfbSBNdb0bDQrtGoG0aurc?=
 =?us-ascii?Q?k61LIXb5lMTvzLrFzPV7KTHeJhk8odZT/7lJ58i4PR5ceeNVJRVAwJoB2E6X?=
 =?us-ascii?Q?9441W2z/opUvQQSLbECHKxecL3jyTTXrclTqSrfBRpB0k7gj4vopsJFH0iNk?=
 =?us-ascii?Q?8rLd1bvJr/tK4ePKhgdvufRxwTSdQFuYmnTF5P8bxf4bUM8nVqJtGerHh2vS?=
 =?us-ascii?Q?uuXm09ZROtWL6qb1tw7nqvyYt32JwT+b1M+XZYXP8Dfrssaf2m/KQSnQ3N0v?=
 =?us-ascii?Q?3sS/SSU2Phjj1HBVFU9x1u3/AypI+mJQxwextHiMwzMeNXfy9wrgTIp3eZpR?=
 =?us-ascii?Q?96eOjNqTkB/8uzVNBdApr+xY2KVdBOCyH/x0ALbqfa5p9FhiAIjy2ff/ge1J?=
 =?us-ascii?Q?kS74HltEFDOya9UAkM811h5es5kpl3UOiYaKSvkfkkTGFP3DMWo0X2dP3QK7?=
 =?us-ascii?Q?X1yj7swdJZvB7sHqMcL4YwQQRiohrZWuUVDMTRzePjBDdXjldnE9fhg9gyrl?=
 =?us-ascii?Q?Q351UzdUfKgZ9s9ntOyAeqP6NADLjoMHQyN+yhxq/9JR8jWQoY+BVTcrj4OM?=
 =?us-ascii?Q?4c53gT9QHckVufnqysHvHuw1Y2vhpvcgCGxm/R5T9Y4cYKbovsDNbParXjax?=
 =?us-ascii?Q?ExnSrKtRAFuDxwz+SMKmWiFpBZbZG5LS+wz8sBqZT0LoSgr3FzOiKjO7kb5K?=
 =?us-ascii?Q?uA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc6ce5c-b6c6-4577-4d94-08de1136402f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:43:03.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUo84FLvLD3KBaHJSbU+f58bcQ9g9vc3EbmmmpXh7VqNu+3EubtenRu0hyNeMCmpffxngmXkl9utvLoOAK84dGEHmaw/iUd9UCEBf0mpjuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Joshua Hay
> Sent: Wednesday, October 22, 2025 1:31 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v9 06/10] idpf: add
> rss_data field to RSS function parameters
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Retrieve rss_data field of vport just once and pass it to RSS related
> functions instead of retrieving it in each function.
>=20
> While at it, update s/rss/RSS in the RSS function doc comments.
>=20
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> ---
> v8: rebase on AF_XDP series
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        |  1 +
>  .../net/ethernet/intel/idpf/idpf_ethtool.c    |  2 +-
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    | 16 +++++----
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 34 +++++++-----------
> -
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  6 ++--
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 24 ++++++-------
>  .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  8 +++--
>  7 files changed, 45 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 40f1ce901500..03df59829296 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

...

> --
> 2.39.2

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

