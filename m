Return-Path: <netdev+bounces-266672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEsoHdiEsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA875265FE5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 623D53092AFC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11893C7E11;
	Wed, 11 Mar 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yrwxj7UX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CF2BEFED
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241244; cv=fail; b=FndpdBKx0tKMQde/hvdcbgd4h8xfUV++teAJaVBJVi6nSmKxoYEhsWXcnQSUSjHZsB1eSZtTeX8qQlKLMQZBl+NduLeTkHNcMcHf7QvL+zYqHGutHUHlSPQoQ2Dh9BpKfDidFnFu3cmHQrMVXiIR58eZg7DGZfZlGrL5LB8Y4YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241244; c=relaxed/simple;
	bh=F/WrVtmWKw1yVWiZvBRh4sEa96R1LbY0oVCLmqRBzv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3XS2UDUhHDyJLtCbjhyh4GSrr6PSEFjtOnim2oPLiQiPY8YU2jiz2wQ4E83jgHJ8vu+e3G2KoNhNqmiIphDjn/XYI3BnGWzX7iB7qP1Gu9K9Szf7Hok6qQ6OXUft/QreKINk1M7T1cmqxS02ASHgSuDdCya4kha7k4GdxEeRRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yrwxj7UX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773241243; x=1804777243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F/WrVtmWKw1yVWiZvBRh4sEa96R1LbY0oVCLmqRBzv4=;
  b=Yrwxj7UXwESjqFF4KdHU72xs7zIAh37mSD7gCCE33H/HnDfNb8mUnIOk
   LSjITQOhB4xH9Kj+a/EugJ2PfJw6HjA91pRcLpQ2srx/hx+vEGkPxxFQA
   K4BAWIoN3YEtvD5omewTFaKKqkIy33LG/QtLm2RpWOkcRy3hpyG73URfc
   5XOW/4r5bW4Jo5hLc/D1uA5z4jMQ4FDB9se2MTrXuqkNomZFiXflfUqvl
   YIojmec0F+pNFv9V9OPWOB0qTVOEZQEo0L8Cx4LwwbMeCc79oCmMRnqMI
   uJTDKU/X2qDd6IwsuPF++1rTuxn25vAMPkiMDAFZ+HbJrHmo0iY4y8hqh
   A==;
X-CSE-ConnectionGUID: PMj3kTabQFGqdClZ0w244w==
X-CSE-MsgGUID: M1WP8Mx1QZSxs6T3tk5vyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74281585"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74281585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:00:35 -0700
X-CSE-ConnectionGUID: lo8/ZRfkRZqL8LRRNjGglw==
X-CSE-MsgGUID: aGhbVGQFSAChjlNnoFBdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="220667514"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 08:00:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 08:00:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 08:00:21 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 08:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dag+PvwQSp2hDUBbNosZ7WztGNfmawmBlcPwauJMp+bGJsTX7fpjh/NfYn6xR84KbQEPXcgjPSo5DNwSm9vVdmsOE3f7WsRl0Fyv7K/USEantVxv5Tl4Xvoww+P3vFkvPiJoHEvZ5ujgzKW8qrCObGHN905HRVarTmQyopdCflLA8SJmhDZc1y42z8PEuBysODTKKYKce4vsICSA6IROW2X+yGqk8r7AdM+2ctoTHR2WOQ8fy1ZL7Yd1XyLDEviSRyhWEEqPRVr8ocTvwlTNB7ARb3mrt6i2PVCOBKjNsHETv37wD+gFJ5PV8ViZgXIi/r5FfONsCyZdABDEgRZsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBamMDl9jMB7qnYzzfjp8uYaTg+zwNt47tBWNlWwV74=;
 b=YMar3F419eL1ZyMcXEv5fThRMeiZwPeuhu2W7Jgdm/ZY20TPCIq7gz+1LuoaKyD/ixoUhQClttREjeWSRtC15lzEefYfCp5pdSkGd/2/jgYrGJjOcanNc5k9ymsr7vh0Ol7VYkRuj6ubtg4cW+79eao4ufnGGtbLNUnOE8qydwzLoygzCAxzOjwEEL9aoo6TOKVF0DcoGZhkLUa/EgdtHW23S3J060rr9mREGIPG3OPxd7tWI0mdz/jwwEbMS6IA1PanHSD1ROHmtUu8PwgD8/A6NmujmRQUtM+n3yw7D50WFK4y95DCeQKPIDGi41h5/C1+NAMPDrvsHvmBROxU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA0PR11MB4768.namprd11.prod.outlook.com (2603:10b6:806:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 15:00:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 15:00:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] i40e: PTP: set supported
 flags in ptp_clock_info
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] i40e: PTP: set supported
 flags in ptp_clock_info
Thread-Index: AQHcsVfsf1YRvazuaUiQQ0bF7j+IPrWpbMhg
Date: Wed, 11 Mar 2026 15:00:18 +0000
Message-ID: <IA3PR11MB8986ADF15C55A1F5D5572220E547A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260311130743.353632-1-przemyslaw.korba@intel.com>
In-Reply-To: <20260311130743.353632-1-przemyslaw.korba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA0PR11MB4768:EE_
x-ms-office365-filtering-correlation-id: b68ac134-69da-4b1d-ee80-08de7f7ee8ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: SOxI6bpZiV6C4jVjxTL48Q94fGam3nn+yKbNYYo8D1mqIjmVjXq7CE+wmKONLjwXIpeHtyFFpOrfRuLeEsP+QfSQPlsXIM9hOqTHeMs3KQTfg9xtaEwVv0CKcoQi5pq8suO1z7BCM5AiKJ0TL0+YzwwnhIj34l6XEYMUezORr/mT/HD1S20/s7B7JGvvcICXRLBC1gl+BX4INhJb6KTSnu4TENHf8u7uCdrx6UTFB+jBcNlgaSbRqItPXkMiLPqi/BJ8n0UwVyRYjeIxncvZ7VKVlTOwFxYhWX6pstCOnGZhIO6IENZkFysrqZDvbZb0VVl6A2V1LmBXhMsOqgrYD88K+pn7QNQDNG0MqK6GQvuptQx7QOqdo0z67XlAh4zvNYHcbcR1yQ3qrQyVgNrqNFaSqm8Lnu//xabf/0593twQn3mSJXHQek1x3yqCDWsTk+yJx1Sy0qrJEAipQNSASf93Ib1fJsbmObncKaktubXcClQdTaQ634e15DTqm0PbTbpSeUPR+Ygh6L0rHk9UkDRipRguKoQLb3RYNle8ecFQM3ggIhau5PDg9aPCPwxXpyQP+WJDP6cngUUlZb1REr6onqAQ4w5boDrK+/r9anU320622BdUn8I/87hGF9MTM/rN7yG9cgNHezKu3nbDjws+yLVHDd3j4qdF+xWmI1VPY116V9xpqD0hz6MWwJtoCSvbDfjsxTkFaPG4vqV7/1oY75n4k/zfgjG2wGOdXE0UzLcLp3vy3uFqVeOuFtwK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wfqRW+MxWuZm+V/JAb8JjlvLIP0zijFyU/lTp9botZrLaHuYHjHzLRSQBvV?=
 =?us-ascii?Q?kqe3qt9NHv8klGuGfL+U+ycDC/N8Y16YgJvsgksozkUGrGiaPOnjZhiFUwic?=
 =?us-ascii?Q?dOq08PUj7IoTsh7StVUEOPYuIHoqJs7J+/SopnpdVFBeAb05khxjXaHH3dCZ?=
 =?us-ascii?Q?jFShsXqCOoo8JYfOifSwBDkHg2+DJ5CNyG/wWibrQzFX3FdeSW+N1E8hXkgW?=
 =?us-ascii?Q?P8hJ/rojGDGpmZIULR1pEa9FEjHEAYbpFDPS+GuyWoxV5DUKDkFBQRW8+zCV?=
 =?us-ascii?Q?PSPOROE3zvd9ESJGOjAWbMKHWREUe89oTMvCtLiK29LzVqmZgGKjaSs0cLLT?=
 =?us-ascii?Q?MPT2uBPZZKzyniOxM71Eo7IhbpRO937U5rvQ7K1hPV+1zBXanfMQnJVDSHX/?=
 =?us-ascii?Q?XgjfcV4q6M/ra+I+a6iibXgrihDLlNHYj6mb0qhH26vguJuzqOki5cDw9fpl?=
 =?us-ascii?Q?ROO9mEmz2mheVDRhXVH55+hnE4npzT3iPlvqJhWofrNaom0xg5BVbJ2rp+r4?=
 =?us-ascii?Q?dfy7Wf6ExBBcXaX25ROLVS2xZYTkmZcR1mPlcDPe7Zwt8d6mTJYyBSafyf8o?=
 =?us-ascii?Q?OpmyLd5BvJXpS97GgvqLWI2hu0K1qmCxcjdpxidMQgofcU4ESU6EiJtc6NDF?=
 =?us-ascii?Q?F2QckDumvrQhlr4l0YgI/UySlfixxrnBnwlXAQsz7muT5xsAx1VY2aVOi3km?=
 =?us-ascii?Q?lxBkzYtxCTL3QsQzqMddqgSJdFoXzFP2TDp+R/IFQT4zMU4Ogw5tohjblT5W?=
 =?us-ascii?Q?GG+QA1e41PUaNRrZR63oaaDgHedI4uROiSblNGRz32nbIqF5ZQaD2YAMd3R/?=
 =?us-ascii?Q?0bwlnSpWOswhipTWrId4BnyJFa/ZEN5FGbgsaNtBqxa5TNRBV5A9fvDijwyt?=
 =?us-ascii?Q?yvSlpnhnH/7/bZ7hC/MswOsrZHi0itGFDfYuSs8WgBSQz+qof52nDYu7aS3r?=
 =?us-ascii?Q?np3zdq8w2IX7MOgVL4ExgIEyFSUOO89aIRjWFQIP8XP5KUhMenGOj0hR3rar?=
 =?us-ascii?Q?RfmUy7gw6KRZryUZhogDuaUT24zni51dGWWdJDolcOpU86rVwtHEZTExZMSY?=
 =?us-ascii?Q?LHbbAT4oJg7NdfUzSo1wCbv3pILprgQjkOyILSjCk62x1FhjIYicziPU2fuF?=
 =?us-ascii?Q?2BoJvwDZEZClVtqoE8TOoIlL3oHtcNjVDafU23/tCfmlBcD8nMn5zpG6VrhS?=
 =?us-ascii?Q?0vDL66fovvDgA1sj+P9VF33jC689I9mkbpFNpKouE8vMolRQKyqWU+o2Us9e?=
 =?us-ascii?Q?XC3B+phHGuSkTjeYf2ts2y2LhHC0g0HZDguYOSM32m+VBTdr/5Ml8T8sJj/V?=
 =?us-ascii?Q?+9vpoUneDm6cHzvSh1CJHhTLBfBVESlup/uV/+E7Vp5gtKrs+FVVgwlGCEME?=
 =?us-ascii?Q?fQB1n/K+7mRfSVKP9mcJxL3Em5vtGLKnPysoSDkHU9SCwUGuFOaayfyw3+AA?=
 =?us-ascii?Q?wJwWpD8utnNcXJZFZ2LDHzOMlfeNPHDARHpD6su9ceHI66MgjhZF4h8CvTpH?=
 =?us-ascii?Q?BCxt25L08Ws/akcJdLIylpotWy02rxkiilmBKz4xQrBgMdOuF3DyKi4TIoGk?=
 =?us-ascii?Q?sfRswhKpp/+V1wHHEZAU8OLzD/H4OaaQD4UNQAxAuyCxUh7X1kcqKkNFukWN?=
 =?us-ascii?Q?gQ19L2oKceSolgRwwb4I4L2Y8GUwQoCsdSP9pq8bnPliO7eGbBT1YQEYNMi5?=
 =?us-ascii?Q?E6nW8WZeXxHNUyoDGi9RCLDXK8vihTW+SHrCPUcpjU45DnqOfF0UBN1SvTwL?=
 =?us-ascii?Q?Dq+nd3iA02UTH/+6gturp3dBf1VVGjo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LF+0hxN94DVj4kIpWtfjJzFwHk/yqJZMXNT8wTFBDfg7QO9aiG2cKAe7Qo5Auvc/b6Ykjn1wqbHpnOIQcMZEosJo1fNA3WJW739ej45aBF5hsOpkzCWDUqeDxQ8gfJfMOE+178WE85FfZ+TKlZwwtZQTekJVMJsDYojFKSk2RkO7fZz/my3kl+aNlpTlYwO5rJ/Relr135g6gz9dAHwfrjBY3D/m5HPNAOFbrm35uWWkQjKvLOxmLXYc36jBd/YCU0sA2DKLivCZKLxQMpvKvK/NeZ9pKPo7bgdS+sX77Gr4TpjiNYVai8SO8P+BSRY7iP66c4BmwQ1lOYBJ0+9cpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68ac134-69da-4b1d-ee80-08de7f7ee8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 15:00:18.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xj/JIEIbaSwBnoXCk1/XMXcanopMW1ELWMV+g5in/fo4MIQwNgZK0/jENjTVMmf5f0zK/eUJD8NaCvVAek0bQL2k3XEBLroPePsgUPLykZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4768
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266672-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BA875265FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Przemyslaw Korba
> Sent: Wednesday, March 11, 2026 2:06 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Korba, Przemyslaw
> <przemyslaw.korba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] i40e: PTP: set
> supported flags in ptp_clock_info
>=20
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d
> ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core
> now requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the
> additional flags will be rejected by the kernel automatically.
>=20
> i40e does not support perout flags, so reject any request with perout
> flags.
>=20
> Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to
> ptp_clock_info")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v2:
> - add fixes tag
> - remove old TODO comment
> v1: https://lore.kernel.org/intel-wired-lan/20260309141220.343224-1-
> przemyslaw.korba@intel.com/
>=20
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..41ae6d78aacb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -598,13 +598,20 @@ static int i40e_ptp_feature_enable(struct
> ptp_clock_info *ptp,
>  	enum ptp_pin_function func;
>  	unsigned int chan;
>=20
> -	/* TODO: Implement flags handling for EXTTS and PEROUT */
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_EXTTS:
> +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> +					PTP_RISING_EDGE |
> +					PTP_FALLING_EDGE |
> +					PTP_STRICT_FLAGS))
> +			return -EOPNOTSUPP;
> +
>  		func =3D PTP_PF_EXTTS;
>  		chan =3D rq->extts.index;
>  		break;
>  	case PTP_CLK_REQ_PEROUT:
> +		if (rq->perout.flags)
> +			return -EOPNOTSUPP;
>  		func =3D PTP_PF_PEROUT;
>  		chan =3D rq->perout.index;
>  		break;
> @@ -1340,7 +1347,9 @@ static int i40e_init_pin_config(struct i40e_pf
> *pf)
>  	pf->ptp_caps.n_ext_ts =3D 2;
>  	pf->ptp_caps.pps =3D 1;
>  	pf->ptp_caps.n_per_out =3D 2;
> -
> +	pf->ptp_caps.supported_extts_flags =3D PTP_RISING_EDGE |
> +					     PTP_FALLING_EDGE |
> +					     PTP_STRICT_FLAGS;
>  	pf->ptp_caps.pin_config =3D kzalloc_objs(*pf-
> >ptp_caps.pin_config,
>  					       pf->ptp_caps.n_pins);
>  	if (!pf->ptp_caps.pin_config)
>=20
> base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

