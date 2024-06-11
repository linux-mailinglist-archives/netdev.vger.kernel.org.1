Return-Path: <netdev+bounces-102482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211C903326
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BC4281751
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8461E16FF3D;
	Tue, 11 Jun 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKrG0kSz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B1B657;
	Tue, 11 Jun 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089276; cv=fail; b=W7t6wGfaw1K8jvsTWiQIIGJ4QPCeGnSjswD6ozAV6h4mf9sWnIYRkAelVSlySqixZhR8YMuKiN+le/q+r27iKJ0A5FfYe3IyHeDtKW9u6e4PMBWBjSILke4mMUdfKSbt4R+BKC6kquFcqm7L3IN+mG25havskn7AkDyhhlEd8l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089276; c=relaxed/simple;
	bh=7uQZWHzOBZxz5yoa9NzVq4dbnpGBNbyrKR0hk+DEPck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tc702j6HSgVHxcQzJMLUqvRObGd0mfntPMg+YFhArC93KMJ+y43iUAl9jddKZVtbIBxvjxhs2I+9ydnp5c3/w5Q1mz9tWHvchDSU8dqBCpVJsc7Gny2dEGitPg8ABDxXbaFvsvamt+RbYS3FjHQMTCbopB+AenTxnbACEN4hopA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKrG0kSz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718089275; x=1749625275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7uQZWHzOBZxz5yoa9NzVq4dbnpGBNbyrKR0hk+DEPck=;
  b=KKrG0kSza4+ko8fGpXlYkxhq7s5Bd1GHSZty3kgEcPJkMC+BcQIULVtJ
   supdBMYn6kZWIC+ef2HhdrQWoYnvoii+IveASE9tzQKuyUBQ0OCRspUI1
   oWU6E7PgKnSc5fmXElP7+j+f4P75+DpCS1tNCnCAnl87UMjJMu85hQuvC
   TJ1+K25FPs5Ji6vdgTPdJxvH4lrB2WPjQ4K2F5dNtPU9YzBqVsQDs084S
   AZqT4gXLtgGHVOuAs07ZtJTK5S0sTfCYNZJiNneXnVdNV7O/l/eT0S640
   wzxsQUIEhwy0YQO752m1EibOM2yxBvKZGwJk2Pw8aK0FMFTzLsFsQ6wqu
   Q==;
X-CSE-ConnectionGUID: 37bw25WGSuyGQehkDrGdSw==
X-CSE-MsgGUID: PDS0jZG8RcWRnCryImGV6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25443656"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25443656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 00:01:14 -0700
X-CSE-ConnectionGUID: t+PY02eVQ8KaUyMwzXeNhQ==
X-CSE-MsgGUID: bgBTcteAS16ecMlOXgzRJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="62498065"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 00:01:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 00:01:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 00:01:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 00:01:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 00:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLZ9OBHrDYDgrzM8S36tS4gd2tw+jhXGePbsP5XXW6YfYsouQwqxf+Y03k4fHjvhxyzcgR4dmkn8zTRi3oTWMZaNIffPu3r0rhC3rMUdfxc8a7ysJ7ihlOPLn64lsPqnce7x+OPNbz0M2eeVLW476iLOR3VM4hn2DljZKQykMIPrCvJgDObleah/oGhwG6NrZzsyYaVJD9G7E7QxQpqqQCNXKlQJb+8TRuZUDkuBjfkeR4DXwJ4A39l+SY+P04hVZsB9Q/cEULS+oW2oKuMve2m0g7AXzZH0IGgcO/0yUidnnSlrHCeBDn6AfDQ+x/crZo34Y0cx8TYe4Js4bGBPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uQZWHzOBZxz5yoa9NzVq4dbnpGBNbyrKR0hk+DEPck=;
 b=b+By2eCffmkQZmj8DnLPi0pHhyoJvAECHY6ydQVb92aSpQ86guiHjKeudx3ZD2dSemPgqM1FVahKTXMANb3UHgydwJD9Vx65/aN/qYN1GZuy+p5F4+nMoaoOPpUGSC59hlulAVRc3vOMeMXHDjgMy9MnaAcdx1VItmxxljAHVualqmMlnuBv+bORkpMX9KBKole/LttGCK5e0Yn07XxvV9Bng2gUyePMF06ghfM88XypPbuVpi/KlixAFcxSZqHw5T/kAou1X8c5N4ETukEfhy81Tu2l113IqhmX1J9pTqvYIChqq7GN2FJWpW0CqmV96iqX9iCRESAcdyGxgFJ3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 07:01:11 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 07:01:11 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "Tham, Mun Yew" <mun.yew.tham@intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasBkLCj07Z540QUGXqLg1tlacPLGrb/8AgAB3OtCAALcdgIACos0AgAA0dwCAB3I7sIABIjSAgAOj/ACABVXIAIABNUfA
Date: Tue, 11 Jun 2024 07:01:11 +0000
Message-ID: <DM8PR11MB5751B40B4FB8C1DA200D05FEC1C72@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
 <DM8PR11MB5751194374C75EC5D5889D6AC1F32@DM8PR11MB5751.namprd11.prod.outlook.com>
 <322d8745-7eae-4a68-4606-d9fdb19b4662@linux.intel.com>
 <BL3PR11MB57488DF9B08EACD88D938E2FC1F82@BL3PR11MB5748.namprd11.prod.outlook.com>
 <734c0d46-63f2-457d-85bf-d97159110583@lunn.ch>
 <DM8PR11MB5751CD3D8EF4DF0B138DEB7FC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
 <3c32c9b9-be77-41c8-97f7-371bd6f8fa16@lunn.ch>
In-Reply-To: <3c32c9b9-be77-41c8-97f7-371bd6f8fa16@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB7253:EE_
x-ms-office365-filtering-correlation-id: 1d227ad7-6c87-42b8-efac-08dc89e446c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zpvuM6K6aktmpNWT9mYBmv+5u6keJ+U06nvz6g1ULldTZLKhPjRrDki7a6?=
 =?iso-8859-1?Q?Trix790QLNbj5mbTDMWcEXns0LqUNZ/JVFU2bftc5FLxOOmYuLHxauRWVD?=
 =?iso-8859-1?Q?zo4qLcW9L+LmmSDFhmU/xPJVgmhLvXfhpGcCrCNzG2tj3iOsKhhS+vjGSH?=
 =?iso-8859-1?Q?hENyCK5Y0O1NUXyNI/pz67ZmtYp94360s34gSDEWYKl7pG4I2Eyy0017o1?=
 =?iso-8859-1?Q?CA5EvkeWyCK25y3tDQgmA9E1Og4M9BombD9mkBFaudUCEgV3hfT4C0oGEP?=
 =?iso-8859-1?Q?ne792Uh6Vake7Oifn2TDOn1eg6OzM5dqYbXjV2yc1wD1rWghBIoDYf73UP?=
 =?iso-8859-1?Q?TiYUrxqbDoajcCd8AtMwkCmCuhVStF4tHDXmP6HUBTEyXlFUMUm0COfszZ?=
 =?iso-8859-1?Q?8ryeeT2V4qCLlT5niGr1m6zuMocsRR4aRpBTBxbEJnLf6JkavV2ZjLwbO+?=
 =?iso-8859-1?Q?EzNZ2Yk0C58wYd0PmahZb+WUa+XSm0oLeTIIhYdqnAqlBEYge8l2sYrPST?=
 =?iso-8859-1?Q?doON4+vQKsXxEJ+hpFrxe77Mfm3WAAnCCzSdcKY1ZNhA2JR/n+ZIAN8fRY?=
 =?iso-8859-1?Q?d9n63K9afKAbf291CsKR1hlHx3D2kMSS7zPRahFPcXF72UYHh4njJEhdvv?=
 =?iso-8859-1?Q?9d/MD4/XIMWUFPC0dLwOE3AqIECjjnIjfOxzig5vHdkoRcJ7XbllM3Fb3A?=
 =?iso-8859-1?Q?FvqtWy8nQWDFnQq8VCKpDxkpqpsiChd5kbsjYrk2HmqOxdrIzaIEECdxnl?=
 =?iso-8859-1?Q?fPOg40mrBwQEx9kf2NuvTZZ6SL6BauTHV8fPaYbplQNsG/FBZnOT7vpNQg?=
 =?iso-8859-1?Q?jtfq54sEtZhQhG7t+nXUw+sJBtjnZ4/7SZJ00Dj9WjRrCPUIrcgtgZthby?=
 =?iso-8859-1?Q?g+o8Sjq6qDkckGWVEDElmuEaPO96Fc+m8XvbMcWr5fjADwjc5X9C8k1ypM?=
 =?iso-8859-1?Q?vQbJmiDlBIj8DrzAUJlMQZRIyVVhWVw+W8zNjBVfEJV7B2CdB1PBH1rcmt?=
 =?iso-8859-1?Q?Ov+E11SPLdVRG5sFJ2UxxCq1QWbA/jh/oHeQBzJf0Ut53pm7P5xy2gysfZ?=
 =?iso-8859-1?Q?EITZ6Oc8PYR3gb//a6LJmXlXxEXHSMEGyhl1uLi/y4VfjlBocH5eFt/7Fd?=
 =?iso-8859-1?Q?pLVrAP4Zeyk2ProLPYthZKF0NraXkpWO0+NBf+XTUGmVQiWbIOVjZxgT65?=
 =?iso-8859-1?Q?yysCyPjcL1fZX4fym6bMKtxvbJb/g4cNPTdWS/L63LEALWDXQnt8vbPMm/?=
 =?iso-8859-1?Q?5xAta4i5WSnVcRD62CTXTr8DoZ6SALiFq3rg+p/FkoJJgRCPcjkjG8mbtY?=
 =?iso-8859-1?Q?epQjuNK8taG7L7Yv9zZKXZEcQASva2DslGfSUuZM+lzASrXspmnwA4tCwu?=
 =?iso-8859-1?Q?qtS5KIZUZlq7MZjpCZiCu0RgyV18zd4QIjmaWQ+pCJ1JulW6s8nTk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6k13sxBkcRq6hxcbPYLnh2PQ0FZl3p8oMnXOoR8faOusNjhmYbFRv6A/X3?=
 =?iso-8859-1?Q?Dzwyask4U+bv5HS1ZfzR1lXZ3gb4jD6smpMooRO6y+IpCy/5tNbxW17v3c?=
 =?iso-8859-1?Q?gB/v2e5cyN/Qsif+qsS3oX9tD73G672CwToY0UIsIBAf62yGzvpWRruZYd?=
 =?iso-8859-1?Q?EVfeLtJvbz6JD3q2TLkz9DlKyRsl/vjx0Kc5i/dtd5fhA/Ypc3s/s4YLtz?=
 =?iso-8859-1?Q?d7ZhKutntMeii49F9SJ+6RDs/QGBpPUkl2gQdSyasXF9PKcB3oTRSdvyIP?=
 =?iso-8859-1?Q?RjhJv8ZdU2G/Z8cdhajnGRmgy9zISMSB7kwuJYWrQsnJJbUnEwzf3E0d+m?=
 =?iso-8859-1?Q?QP45SZiCmAaMgc83jMujm9l/RzbzEZLlh4LSQjY4jpuJeeMT/QOzog7JDt?=
 =?iso-8859-1?Q?iewHQEgPkRemVRJVr0Bp6lG0XSAjTlZT8seX1I1F+BreWgMzca90MTstKu?=
 =?iso-8859-1?Q?PhHDofikyw5e8e3YTHrvpQBsD4GShav6At9oLF2AIoiCHODLYe2hkgkPvP?=
 =?iso-8859-1?Q?vEhXadHY4ELUVhFdtBfQZ3p6d3Cbc6ykkoahIjDoaO8Fr3gq8uGLv+0iYe?=
 =?iso-8859-1?Q?MITRUjp2+NgGKEyt0pPcRjLZgiyLqv2enFznzw/mbqYMOdbVI+04nkpVk9?=
 =?iso-8859-1?Q?G6f1JkWKYVMuxL9ukQFIrjaznegohc/EeYusm2l7roAoBOwmN009mst42W?=
 =?iso-8859-1?Q?aH4YFRs2SVtCLW+t8jaFhj5ssy2+hsnqWETwTZVvg1DQD0YPCBJSpg6+sV?=
 =?iso-8859-1?Q?1RFXTymyPEJP83LGjLWch2gzxPP7ETRGkdlWwAw16Gy67r0rV4IhZ4N9RG?=
 =?iso-8859-1?Q?LKdrkbbJbr7FkbszrBe40S9pPpCR46YUB9z6OYPIJet86Af/2KwjhptK1X?=
 =?iso-8859-1?Q?qjpkJD1E8fXHe5m8AeV+AHUagxXjlX8LjNfCaq2rZzecV9AZutJTa3weGw?=
 =?iso-8859-1?Q?incTKb0WRaKWk1IZHBNnf/W70pTUKO4NyjQ7JxIl3MOg/asG0bT+IbXfON?=
 =?iso-8859-1?Q?qZGofJMTz463O5mTTwreJLN2g8wJBEvK0RfqLQeK40+8LlWNoM656Sn9El?=
 =?iso-8859-1?Q?FQtqsSpS00iqOS/aZ84D5rvCE/c9q2EV4uN+/G1RfytF5hlAC6l/youI0l?=
 =?iso-8859-1?Q?d9fEVFsoxu4p+9H/dZWYeAiy5YZe/gYkDL9g/iWrcMM9hDQ9+8KsG6xbDO?=
 =?iso-8859-1?Q?b7+YpkOX1U8fkIcEOj2cHAUDf5AqT2Pc1abi6vh2GZo836SaOpCKWg/zc3?=
 =?iso-8859-1?Q?cMXMbMchbPMz12fX9KBZenmJBNHy1jY/X8pK+toRCRH19aemFEy7tTt7Xe?=
 =?iso-8859-1?Q?XYR2yd4LdVdrAVLwcRJ4N+GeebsCfTVX9BsCuAf1HiAIaM4Tu6lUBuL88B?=
 =?iso-8859-1?Q?MWu/z+lzBB0vfoCPfEghVA9QD84ooUCSMnZtsmJTqVH4e2QocZvvmxuxHa?=
 =?iso-8859-1?Q?858lk9mtHAYoqCGd0Dx51Pb/qtULeKydYe8hhM4Xokk7MvZgkTShnQPNJK?=
 =?iso-8859-1?Q?/blLtBhmbLq0U6zjfESbVUBKk6WRZiwTI5J8/Hd//BiX3eIjApjQrV9L6H?=
 =?iso-8859-1?Q?nx8BKAFK7S20V1aKL7h8aSlQTPGPB+HW0GVCyT8kg0N7yE1p/kV3cx8wfp?=
 =?iso-8859-1?Q?7cPYcxxRU0oHPC2ArHBUfduQPGSXV0HSgL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d227ad7-6c87-42b8-efac-08dc89e446c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 07:01:11.2702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVg3oXmf1lVMHghukrRkh+Pxq2fKLYP3GSv38mt+lDqQWXgYeQP8bZqsFxy5cwhQ3h9izrX1SyW8FbYqdJFciA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com

> > it does have stmmac_est.c and stmmac_ptp.c to that support for both
> > dwmac4 and dwxgmac2, with that I think it is suitable for introducing
> > another file called stmmac_vlan?
>=20
> Yes, stmmac_vlan.c is O.K.

Thanks Andrew, I'll make an effort to consolidate the code into the
stmmac_vlan.c, wonder the next submission I should go into net or=20
net next?

Regards,
Boon Khai

