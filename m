Return-Path: <netdev+bounces-306538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eOypKZzhUGp87AIAu9opvQ
	(envelope-from <netdev+bounces-306538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E673A956
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Le1A8xuD;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306538-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306538-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19A723139821
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072941611E;
	Fri, 10 Jul 2026 12:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E3B14D0
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:00:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684813; cv=fail; b=EzzcY4Z0J1YKI3DbS7GgzIeQ6q7x2iZiVolvMmWRV7jbwnQRHsKUmlu348ZTaoe49ZtBe7OgNK7IJIUxuU97JyfAR0S/NHJbeHydoDpy9UcqvO39Kf3PtTbW2NmBgirZPdoP+cHRcHeGj3faYoBL1CSMEpLaFp9RdBDYRnvaLyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684813; c=relaxed/simple;
	bh=Dlr15F7vGlODEFRRmSlBLYf3yzCUAfAkFIZxBq+GXMs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ea5SfCTvCzvbcD4fWbN7uLzWDHd1ROBnQp1iKq77FAsU//bxiuKROPoYdlsD1Jau1U9qSmGH8IkIak6n5STr/mVJjUmReI5hRn/gVa9hGW1LCHg7p/0EdiCxS7DSgNpxDiYVlhfdUfKHpydPEmR3jXS3Jh69dAC+7YSAq73Jm+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Le1A8xuD; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783684809; x=1815220809;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dlr15F7vGlODEFRRmSlBLYf3yzCUAfAkFIZxBq+GXMs=;
  b=Le1A8xuDiAmHi+mRbF5G2KOKrKTfqfziw71bhUIdpArmhiEoyoq242FG
   HFol+zkZtfnboU4xz1HYaNp8GztTy339hlOVTX2o1RW+Ta8DYLL54gtgY
   0Q2IK+hJMwmvm9syELR05+TQVkcxN6YwMzDu8LKZgtoALC/2B+USm/lKV
   pYy2fu6DgxrodNNWG5zXx0YE5JhOQhfdGgneryzzeU6nSjG63hxFW3x7X
   c430D8T0qBG+2w134MJicwSmC9Y82W0XKRdvY+8ZnbTpIcdvnwI5Pi4p2
   /EBoXS+C6UjVFyY22lVsK075VBuQ7uPrGmipXrFHaCm2xZfp+0mo87xIl
   g==;
X-CSE-ConnectionGUID: z2HsQre3QmGg5yXidzoK7g==
X-CSE-MsgGUID: ad/fKNLZSGSHuCZvwd44Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83359147"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83359147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:00:07 -0700
X-CSE-ConnectionGUID: gtxcDAhcSUSrvCar4/ELNQ==
X-CSE-MsgGUID: Cmf51Ne7RuSrlMkDNK25SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255518846"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 05:00:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 05:00:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 05:00:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 05:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYsqEnITCEJ/W4mbjmhdzqa6v60eDhh7xTYfcKisitomAAW4fTzaSDuni39/IplMbP1EsJi6813zDmjTjqqiPfO6hBgDkeU3juDU2cE7diSW2oBHBF0DFXs7PY4MzrSGCroKOEFgYZxpB0qBa0QKffYA72io3Ie+UTQt9rPdHs1ApNVMGC/8op9VRi68kGCmQic4U5wWhsR0QKiYwdmvtjOvsc9vOMAb5QquzpS55FmS0Jyx5bdFAxy4Ugv0C1B+8mrstKJHgx2CYhEtQYwy+pMc0JD0/x1eHld1w0ohwBQZwQoEZwP/rw2WB5iKm7MhAOnkdyT4dD3fxQb2E+b7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih1o4voIW1n2p2T6bQrDPEbwwaqEPl5Ei9ZY/He+/uY=;
 b=G3MOp2fRFyhdQ+YDOz7pTuTgYPzFoRpV5b4EknThN0woItVkR/X5tko8x0trEu5WZgAocx+FpGt6TaaNECWM3G6LZEOmQdqAZBXyZOia6Tup4iLNn5uGC5rWUIIjtn+1q60o6Hhnr/9/4LBR9gnzcztUe34Rd/7ef8IgN6vXNv4m/JKWj/AIKBDWdWoJsXm7JnnChsM2ye8FLlpGv2w8jubACWzPTCEuPH73rS2iYEYtCdxt2NxlTi4YCcWdKlrddhoDedT+O7zU8xGvnTaZ8tuM2jQHoJnF5br/NTK+KHSoYYPZmAqlT3BJDvEgGq2806ld04QPZsv1qKwhT6QKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18)
 by MW4PR11MB5870.namprd11.prod.outlook.com (2603:10b6:303:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 11:59:57 +0000
Received: from MW4PR11MB5890.namprd11.prod.outlook.com
 ([fe80::b3b8:941:41d9:9d77]) by MW4PR11MB5890.namprd11.prod.outlook.com
 ([fe80::b3b8:941:41d9:9d77%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 11:59:57 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: Simon Horman <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC
 address runtime refresh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC
 address runtime refresh
Thread-Index: AQHdCgYiWmanBfClLkOeQCRi/Q496bZj4wGAgAEV4OCAAZg1AIAAIYBw
Date: Fri, 10 Jul 2026 11:59:57 +0000
Message-ID: <MW4PR11MB5890685F934F8FEAABD7B7E8F0FD2@MW4PR11MB5890.namprd11.prod.outlook.com>
References: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
 <20260708170223.1514429-1-horms@kernel.org>
 <PH0PR11MB59029D8B78557F03143546D3F0FE2@PH0PR11MB5902.namprd11.prod.outlook.com>
 <alDCHrOYHvS1EdHE@boxer>
In-Reply-To: <alDCHrOYHvS1EdHE@boxer>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5890:EE_|MW4PR11MB5870:EE_
x-ms-office365-filtering-correlation-id: d88a0b68-1056-4f89-1103-08dede7ac338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003|6133799003|5023799004;
x-microsoft-antispam-message-info: A5uVUtsKd/+SwQsBsD4evsg4nx638NYFvwi5H0Z4V0AnXztOBLTMNsL2DdX8P5s3QaHgMmPe/8iI11qI2LTB95GcX4UYnpWLMMj9QJAoBa0/MfV7/62zd4bztpnBHfwd9HZjLVB6VUZPCrC5XNCgDbbxDjUAt5pvQqNNhiXrYMbz486BPrCQ94/U8+vENHhTyX/oQ9ZWvnwhPW/AKytnEGZWePdzv1KFjdmuaFomBQPFVdDHZSVncRTY4XU8/CL+WCnJXNPCweRslVeLdJBAkTYmCLhSE9OsKSkFt6kiWo7u4Mue0abNvM+u50oZFE01r87UwwlXloVItT557JavD1bCaIpcHeuOAK+nroiikzQ5LDTkUIqOM3A9Budl4AEu/a1TOgGLxHc7p6iQEvu5wdsgn4quMM9tlEvQOA576EM+lj2R0DNibm4skaVDTC+O6xoRTtOQEbwRABegtd37Pt1YbhO1YDnRh4NK0SC1L0XeKGpfMZHwytyzCqoz/Vf0QM8gDMPdkyVB4sa6lP3dlM2NQrJka2FyBaEC8qAw72x3orvoE10FJ6iT5R6eiKXnfux/kzwmGShuS7nb3o4f27xfdvr3xrcPyAQAX/vJUdnIa/XqRC0/5NToIJo0aImyyCiiJfWC+PDLUccUBNRjQXA9dWS4xTnEYtu1krzcFco=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5890.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003)(6133799003)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGjgSU4PswnS1DQzVCnk3qwEPZq4xY42/bMzYC9SAMZ71WxS2fr15Jl/EYfs?=
 =?us-ascii?Q?RauS7F3wAZaO+VVacTom9iGjEnnqsOZ7RMkYLe6mpnP24Yaw/aVneVFhezOF?=
 =?us-ascii?Q?DcNkva3J19V9mzewQvTIp5FdXFGUUskXs7T3KvolGQJchKaEJW8rsPNFpLfn?=
 =?us-ascii?Q?g2tq+PwmYJH7+83SJDJqGKicgcVNmCNXOidBXDW8Fn/inIzT5Fj/lWzBWRlZ?=
 =?us-ascii?Q?nT3IjNm50TqE/qk1dMMXpk6TmpdMcTSFABTco1KnJZ1aq/OT95JrdCg326Zx?=
 =?us-ascii?Q?mh7EaR4SJS+/241O14HzoRdpEYcYI/qgkABg4X6HEj0Y0v6StuWjT7e8ev/r?=
 =?us-ascii?Q?jBU8k1ZqmeVL+RtEVVYyBEivrX7W5Pr/BVK9y5eIXE70jAy4mjOslldwQU2Q?=
 =?us-ascii?Q?R9kKV38qGTB3w9tVgzwZUA6F22eayuqmHiTc4fVEjQaVEjtWYdj71IVpFmCS?=
 =?us-ascii?Q?6+RYMxp6H2KTr38TK2jZPeiJPGuA72c2TEqc5ZVTE/0iPoetTA4VeFsq8FuD?=
 =?us-ascii?Q?nLkXpWmo3/pXK4qJCx2fyaaY8t/pcS15FUgkM3gLfKg46KeE5AvvoU8dofkw?=
 =?us-ascii?Q?jHCuGOcym0aF5sDEdb4cQHcSrCnVkS0eP9cGH48KvPCxTiiUcujGvA8rT5GW?=
 =?us-ascii?Q?QGAddwaGWP9JQhMxELiRvYqeK6ZpojUWqaB6UyYkq/ZcHUPv4EpCcbm+HruR?=
 =?us-ascii?Q?7TXOQdU/UfGq9KEOyB9jwA7EeS7cpIzD26T158+VJ54fTud5JT2eOSSX+1Sk?=
 =?us-ascii?Q?Ft7F/Vk09N83GNd65RNjnUqHK685p69856HZmKsd0f/6sbZ6n6NdUp2chnzx?=
 =?us-ascii?Q?Wp6+A7gtwBMzgk3DZVr33KGknjcFczMBA+BFloVC/rP0t2zo5Pbmr+YF59ib?=
 =?us-ascii?Q?6mrsgIkF7fQTw3dEAscBbN65K8TFkkjmIyze04R6v528zXeurdilUq+bLywB?=
 =?us-ascii?Q?QiYmf+0Asci3r+4GPNsRMir9NPQctTZVUKeB+mUgbBjSMUU82Cx6KLbQv7A9?=
 =?us-ascii?Q?a2xDWNdK72kTU7mBbhwpZV/MGsNb2JKm4ecBtHtCizd2KKs2Qocc0QmH+xVz?=
 =?us-ascii?Q?AW1s1utZ8PSQvgUE8pEXYeLMSw58vULNGzCa9Tu+duxQLpqnqnzEghN9Q4ie?=
 =?us-ascii?Q?ZP+fZbTYYFAdJP55xOgpk/2K3gaMvbkJO3l4P75PpT0um+yA9dbLp/7z7bXp?=
 =?us-ascii?Q?Mtn+T9J8QRw9jsN4QEUsLiKTSaG9pDM2A+kfzd0hd+CmffhkygaTynLs7s66?=
 =?us-ascii?Q?rHqmDcr3AKlPQUnNpK0RRJo3bkEQa7eH0ZS038OwOLrIs8bxYm6+8QfCzllz?=
 =?us-ascii?Q?mIPw4NfOoQCRZ3wFOEXVyDPykBww8xfucnIGB9cCv/VDqf9cQqmeSpIq8O7t?=
 =?us-ascii?Q?lvbPWHOlXmjUgMfAiex88ud2BqEu7hufPQg5aEEq4t+Ad+dbcwHyNdRoLWp8?=
 =?us-ascii?Q?kTCDpYda+r31khlpHvY2WT8BqwmHFrpJ2g9tJmxLqUkk3aec8iZ+4xz5ONUr?=
 =?us-ascii?Q?wUnAn+q9ZZfZJz5J6XIuv/w6cEdAlDHITrR6Z1pHquGW6hHdSReJjYkSrzUB?=
 =?us-ascii?Q?oWS/CwhTWMJ4OoO5v1XPEhBh6oaqTJGXTW60KPjrYulq0YcBPvWzGaxOV93d?=
 =?us-ascii?Q?uQbrBGVUMoCRly7P/B7ah5Vt8WAHjvSO8SHf/2ulITZLBU1Jd2u/8qUJolin?=
 =?us-ascii?Q?NTmhZqeZJh+yzQAWbH2npJMQrhSUU/1pJgzwrrbQzZUdeqR7Cx9TjafPRU0U?=
 =?us-ascii?Q?AbudyrsAdQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZpnhyUlZ7ayoF3Wvel6315tUHtxZFEZ+cXsYvy8jTzLZ9eKZlF+DTe7TIYAtIHlAVYomzoUc0cXmsA2eJM0ezOdazIQireKi1ezIihnoM0qgRif4O9J0zHacdb5/YfqBGHWtD8g88POncu9ddMDQVapdHoiYx+7zr9P+hCqXRDHHEYpGjI3yBpNk2JmxihWnIMnI/vOvadUqXOkfZUswcNxaWHQSOiOrpgSeLGeTtGuoiMx+vtcZYiZ10d4n/UjpQEPGRlmqPZh6xWrzEnWHeO+DwAWqZA1PiTuANc818/a8Cb4gjkUOlXIiX1FCobMCuE7sGIIONtwLLppou7SwDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5890.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88a0b68-1056-4f89-1103-08dede7ac338
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 11:59:57.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVe24513SI2Sax3qZ4K6GbfCEFFI28echvCBM1UBbCm22RMEc25MUtI7mZIdQ9BRj3Zb7xTz6w1ovn7+w8iGRCXeyga/EbgwhGCNHiL6JT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5870
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,linux.dev:url,MW4PR11MB5890.namprd11.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 098E673A956

From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>=20
Sent: Friday, July 10, 2026 11:58 AM

>On Thu, Jul 09, 2026 at 09:37:27AM +0000, Jagielski, Jedrzej wrote:
>> From: Simon Horman <horms@kernel.org>=20
>> Sent: Wednesday, July 8, 2026 7:02 PM
>>=20
>> >This is an AI-generated review of your patch. The human sending this
>> >email has considered the AI review valid, or at least plausible.
>> >Full review at: https://netdev-ai.bots.linux.dev/sashiko/
>> >---
>> >ixgbe: E610: add MAC address runtime refresh
>> >
>> >This change polls RAR0 each service-task cycle on E610 and updates
>> >netdev->dev_addr, hw->mac.addr and mac_table[0].addr when firmware has
>> >altered the MAC.  A refresh is also invoked from ixgbe_reset() so the
>> >address survives RAR0 clearing during init_hw().
>
>[...]
>
>> >[Medium]
>> >Would it make sense to hoist the E610 gating out of
>> >ixgbe_mac_addr_refresh() and skip the rtnl_lock()/rtnl_unlock()
>> >entirely for non-E610 devices?
>> >
>> >The type check lives inside the helper:
>> >
>> >    static void ixgbe_mac_addr_refresh(struct ixgbe_adapter *adapter)
>> >    {
>> >        ...
>> >        if (hw->mac.type !=3D ixgbe_mac_e610)
>> >            return;
>> >        ...
>> >    }
>> >
>> >so 82598, 82599, X540 and X550 adapters (which comprise most of the
>> >ixgbe device family) acquire the global rtnl_mutex every service-task
>> >cycle only to return immediately.  Something like:
>> >
>> >    if (adapter->hw.mac.type =3D=3D ixgbe_mac_e610) {
>> >        rtnl_lock();
>> >        ixgbe_mac_addr_refresh(adapter);
>> >        rtnl_unlock();
>> >    }
>>=20
>> Cannot introduce rtnl locking into ixgbe_mac_addr_refresh() as this
>> can be already called within rtnl-locked path
>
>i40e does a lot of dancing for cases like this. rtnl lock is handled via
>boolean provided as function arg:
>
>static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquir=
ed)
>...
>	/* Release the RTNL lock before we start resetting VFs */
>	if (!lock_acquired)
>		rtnl_unlock();
>
>...
>
>end_unlock:
>	if (!lock_acquired)
>		rtnl_unlock();

yeah, not the prettiest solution but, agree, should work :)
will redesign it, thanks!

>>=20
>> >
>> >would avoid the rtnl_mutex contention on non-E610 hardware.
>> >
>> >>  	ixgbe_reset_subtask(adapter);
>> >>  	ixgbe_phy_interrupt_subtask(adapter);
>> >>  	ixgbe_sfp_detection_subtask(adapter)

