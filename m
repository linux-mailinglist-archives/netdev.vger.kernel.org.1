Return-Path: <netdev+bounces-216136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0448B32312
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A776162615A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A12D46C9;
	Fri, 22 Aug 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ey7vuVPO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB368F7D
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891741; cv=fail; b=V6KrkREUv1jzOjZ0GuRQpnM8WJtPGsz9x3fWIuSJEyGq1+owCoGQ221TOc4grQZMMkD9iKgFoGEO0Sf7S2hTfkF7vP+q15CcBqw2LWr9bp1Grpku3ux1Np7c5yO4nPR8B2oM9Zu5Qog0Ra1WjnbblbvspYJENZOR8mxOnZeIhUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891741; c=relaxed/simple;
	bh=gczd52JL4orV6dAj6aVReIDuSmrjHLTKNFes2HpFsqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ShTfk9wVHwz7AbdPI7pZmmaRhgLBAJYV5ha8Oag85AlqBSYYtz7BeCqVEJ8a3TwM94t8ZDaJOH82i1+ypA/z2F7Jr245rJvmeA/bCly6GbOJZT8k0fu5/dFIc8clBcQNwehd3IRWZ+SYSZWqZCG3ReW+cWiE+699OFFVd5mvl9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ey7vuVPO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755891739; x=1787427739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gczd52JL4orV6dAj6aVReIDuSmrjHLTKNFes2HpFsqg=;
  b=ey7vuVPOn4YykpqAUMszgeyndboGv+lHCCDBMXhYpuENSzOVOBuWBnfU
   GHvrooLm0hspDI8cq24b6iEH6U/jhHvuLSUd/tK3HQgAoNXsNvZFrsRcc
   cqCd8HzRckZl2+sbWxbUzYMYj/PskuVnYktn9rnQ5ETTOtzvCW05AxHsV
   qcAuWIr00I9pzGLy2F4lwVPvp6EzDL8t3hrcI+zy6XERrRmP1cYX3f7D4
   m6rWhS9kgCaogiY6gHu1Gi1mNdksebTq4RwW7dtnNpF+KDOBjawAXV09R
   Aj+7xsEublEUFgQgb9hdI8wbBAr1MUykWV+DwyXPJ7Hmown6Yns/fXpWl
   w==;
X-CSE-ConnectionGUID: VgZw59gRQOi/Firkzi7BDg==
X-CSE-MsgGUID: fYkb7JIjSCiWuVe2+fWPhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58273147"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58273147"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 12:42:18 -0700
X-CSE-ConnectionGUID: OPrLkg5aSCq54i2VKX7TMA==
X-CSE-MsgGUID: woQI5oHlRTelI/y7Hy2WIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173055219"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 12:42:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 12:42:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 12:42:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.79)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 12:42:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUrPmbusNr1ntwj6HskWcrOjBJ5eqQsXaYBswK8hVsIjT+FMm+M/9t0EIbp9TWFsWaUSHhl+U7qapVuiz4iyAYukOZ0A0lCIE+iip2bbh3POjGjsAIFD0Uzrr56nrZZ8UPFD770NPteH8XwLU16o96GgXyNIohEtUUC/kWCqS6992c6Z2xse9IC6QSb5jlS1YWEk4o8meihWKVRJ6/1fD59wgHyabG8k5LviN3Y7MZhzNrzznh+i3pbBQfn4yNpy3P1BUe2aQo6bg0dpmglBHkr+HHvfGmD+rBaH2pLlK9QzUqQynbMHb+QEy095P8TG6RF8g1Kee7bDzFraVwviAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sufVP98Ow8+Y7FzysrDUO1mKaiJ6fKcETn8hSrCWX84=;
 b=t1L9gUeAbBqWaPPuK6DZFOgcKeH4TGNeoWTgkxdUPs2PniAHyFLV6PBJBeIVhsVyDkz4Szg9XwV9fnQqOtcXIEW9DzwRM1VANA1sDTs5MRswcVIDFjyDmGJpOBPsWhbJs5XNAAW7pkZiLIYEQQI+a8EHV/0CJORWD8hRZeoM4Hd4jPiuGSa6yZbOWbTbSeiHLkSN8zKu3YeRFmOGNdoQfda3po8r0Dz5UwKu34BIDQf1+/n1VgNt++sJNvsfxoyiEcBFXTNHzyUvGlOCtGYU2YdDqqH6HdPPBITQp+rwJBPOf0a3+cG9Inm3vsfYTUVPkP7V7vgBr0a//W4Nx/YKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 19:42:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 19:42:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant memory
 barrier when cleaning Tx descs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant memory
 barrier when cleaning Tx descs
Thread-Index: AQHcE3fJff3Fkktgx0CVcN6fKZCE1rRvErXw
Date: Fri, 22 Aug 2025 19:42:15 +0000
Message-ID: <IA3PR11MB8986F22AAC964A8C8D085DA3E53DA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250822151617.2261094-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20250822151617.2261094-1-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: 9b4441de-04e8-44ba-1b13-08dde1b3ff80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?0+tCZZpKzLWRQNy3G7YJwpMV6AJXZlvuFIy3q3Q0mPLJ9Yk2HXGAHCdOssqs?=
 =?us-ascii?Q?O/t9wou3rf3IDMwy2A+mStazHVdbeKdhG6w5QgTN/Wyzjy2CpFOb6SNGOAuV?=
 =?us-ascii?Q?yr/zTpQXTKuJ9t8v37Jc1pGu9PgFjQR8AXSeJJ8sfhiUmG02Ohbr86a9faRs?=
 =?us-ascii?Q?s+4ZXAScNT3SjwNvErIn4gBsjuvSoAtuit84rCPOiqpiwbjP5d5WEzXGW/pm?=
 =?us-ascii?Q?/ksC9iKAk8Ev56LVxovSCmsn7iDBbBiDn2+LwZmTG73a3tY/KNc9YvESIHoR?=
 =?us-ascii?Q?zJOwQfuautfXjWphixZ74UOzpms8YEQumGGBxQBCvlp0QKDfiqd51NFOhI91?=
 =?us-ascii?Q?to7eOfHhABOvj+ieNaZomXrx5FGckIMu5/r4RRfvSl5oilnL0J3WAEkPIHlB?=
 =?us-ascii?Q?WB9WfIU7surG7/8f/TPtvirFqbE+YsdBv27tTk5xF3QF6YHlOF4hWhOwY77f?=
 =?us-ascii?Q?kMOecKY8P9fu2x/DyPZUm9wp6z1nERn+xaPIwbr/HEt9nihqAnwnXnxV7mr4?=
 =?us-ascii?Q?nILy8kBMxnkVbOay97pJLvygn9fttqiRj7HaBiPcmfS9ulsszUNLGvTmLFly?=
 =?us-ascii?Q?u549MPo3h9EQhHqeuLu1mjZF7YOf2fZCIOrqsRlmLwZKGDQs2O9aAffZSNaY?=
 =?us-ascii?Q?qRwvMbsjYrslf2/4GOIs2Ffl4gwVBuwEkBed6QZqBHFn7ZNNaBW2G9IcNOzb?=
 =?us-ascii?Q?Fer1DBcTpUhTKQ3qvnhOOa9/4E6K1v9B7hCNQBqZ+7wgD4YSh5Ylh1i1BK7v?=
 =?us-ascii?Q?ZHUVWaWox7RxlbPB4saNZLIaydLvMEPUlBQrrAwFNw63aE+mfWe1NPVljDrK?=
 =?us-ascii?Q?RDryWgiiNTepBA+vuRshjxS81TDA0Gx2CoINKKCTIgZuyRGKPnG1rqH5dGyg?=
 =?us-ascii?Q?J9oGqQkCdg0W6H4t7bj1iYdALOllHCrbwtDIR6KVQh/iWVfSAQmNXMsvADiU?=
 =?us-ascii?Q?mJL2UTHnUcOCUS+/GDkkUIXiGL55ILIbTAzMJBQBUleH3sOBFWpk+eiDMzto?=
 =?us-ascii?Q?o/le0qlyUGheHNFTgul3NefhsTHi2evJTTC63Yi3kgZvDNLoXHykbRIRoVMp?=
 =?us-ascii?Q?YPkvMYWZoDMQnYCSGhKGjIUkfsBgc82Uk+k2rJiZq6yzhdV5pkBmMdleGNsh?=
 =?us-ascii?Q?MOKlHz81ZJ2QhNAMNVG8TLzu3B6Bie+rIOxTfM0+XT8CUxVWGwLR36zNI2RT?=
 =?us-ascii?Q?qbLnztsYQlBDYD0zN0cA5f5erDl6SzEzaRrSB+CiR5osGZ9TFLhBuodotxO2?=
 =?us-ascii?Q?Gw1IpFmf6apGI6pfUJk1qZHiIa3sBUNsGyo78BIXUvA9yzg9rS8aWrW7HcKi?=
 =?us-ascii?Q?HAmhfMehV/FzdRoFKEpSW4w+c+z+c7etsswaGoNE3UCuVSSU2o8XojpepT+P?=
 =?us-ascii?Q?Jq3Xw8+trqnjpg0daoDOr2QV+n+Krwyk7QK+yULkFgpHvR9hrEjtLtVlzaiw?=
 =?us-ascii?Q?koSWqYSfgMwv7uCXZI0yi3jmmEBYj6mpPe8Zv+u4IzdlIeC4Bqxz0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JzZfkOt2DhIAa1bM7Xn15YAH81v/aLfMr0l1JyGTiYbhm4nnCAQJ9tj44Iek?=
 =?us-ascii?Q?KgS6X6QvLyKVml9JLDvTyxvfOn5wKFOd1iIyKNCovrSIEA58CZCDgsSekZ/n?=
 =?us-ascii?Q?BfVtjr8TfIen7SFpjt7GEi6KtHjqZgZBrLmX2y9tKxDZwm1AKTZztE4FzYAL?=
 =?us-ascii?Q?uiauITScT2cCcUxcGAQilu0j4ABhqUXLnmDWmLQC4cIqBfWyWV5p3T1Hec3b?=
 =?us-ascii?Q?n5VGH9CaOpvLzysn2gmFyhY9k62oG3Zv7kyneIhc6mym7BCmDFcEDixUuiNJ?=
 =?us-ascii?Q?CudCdw1ImdqzQlU9nC9Iw4rU8QrbIDEu3oaVLlJI1gaeZrtWUO7sro6pACDf?=
 =?us-ascii?Q?oUtcvGsek6d2va2RbOJUDM/XzSq9MZD3pdO5+hX2XJ06Eb6KUolLpmH6Mzxf?=
 =?us-ascii?Q?lDv1A1WYOyn7mPviVSCn9DP8LZaPXyyq3YkZfq1R4J9u9JFIQimdvqlSoiU6?=
 =?us-ascii?Q?+I3zrLcjCdOq7JFlOc1pZvxpbrlZsyKNcoIQSooJwIFjbM7CpeSFo77cE5VS?=
 =?us-ascii?Q?gRspLP0m59FjFLkE0coD7M1YV9Acb81S5Oyy2KrWuHhmJF4+7BknIotbvGA/?=
 =?us-ascii?Q?EExt+/5QH+EMaCgUck/PsQUV1tp59OuzeQHaExg579dciAdRujYpvapchOLD?=
 =?us-ascii?Q?hfj0ph/mwbW9n8i4HeAL6hLyL3fGD9IuXIuVq3AVAmG4vqYTcN3YjTJsFkUi?=
 =?us-ascii?Q?TBvFpz7mdZEZggwyJx82KjhncxKdMUIL9KTuGgLxXZ1ls2datz3/bMeHHiey?=
 =?us-ascii?Q?vhCIEUegXX7C1cjqCF1IZhrrAfKoVAsBXkxrL1WmLbhMEfSTADffEdW0/Ne0?=
 =?us-ascii?Q?v5DTbVaubGPjGkvs/ZVYNYKNQ2NTbHcJ+1izilNjmxNd8IS8/qCYBocDcheA?=
 =?us-ascii?Q?ispNX+edUz3QytQ94/B37PCBZ3hqXP4MY5dlEzivstRHNatnigkHfFdKDYYA?=
 =?us-ascii?Q?XDXBZXHf4jgJllx40/ZAwczGhnpPE5ofacyJiQPlgSecLROoKKEumDsr3CSx?=
 =?us-ascii?Q?TF7ymAyeUOoAu9Wd5YRrEl4NLuep395Gn/m8cCJ8KoUzhHoiqaz5N64cq2gm?=
 =?us-ascii?Q?/2C5fEjEnfkSwMA0lJNUrHc9B0Oa9Kt93TGy/dZU+8pBALEX6NeexnZLLnfu?=
 =?us-ascii?Q?4qwg3/IWGZLPXv9IgAUH9VNGUWV0zZrMNKJppRWONqohJDQMAqojRewObChz?=
 =?us-ascii?Q?J9YdssY4sZ52Jd1bceNzEKkg1qod93s8EIYaeIui49oJUHQQzllj6B2xq9h9?=
 =?us-ascii?Q?2rped7jWaJFUHYjOjcNPtBgwurB6XXAdLWI38av/3K0PIg5TZPHVQLC21fwf?=
 =?us-ascii?Q?JlEgEsKZ9acE7jkE8GZHNgwQpp1jjUNTcSthv+9Q0m+OF4IjPiDqqSTr/3LX?=
 =?us-ascii?Q?j5tE3kFYnE1KP66mDyB4k9As+KQg2Il2eoiioVX5N+1IY66Rcbo6Ch939aH+?=
 =?us-ascii?Q?vBVo6+MFqH5FavoBX8vr7t9JsXfcsb1bYyeHvbxLGk3qtNW6gOp29dLNH/fx?=
 =?us-ascii?Q?FxxYMofHE17T41fVmT43MkmNSyOMHexEYXN65yR/mkwtc3zmPk1+wo89bczC?=
 =?us-ascii?Q?XEPh/cHNimw5/oT1EPdhJik5LP0yWdGQAEW0v7gY+3VTpe28kgLmzNpKYyOv?=
 =?us-ascii?Q?qg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4441de-04e8-44ba-1b13-08dde1b3ff80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 19:42:15.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+Zjct/kM9pL+RHnKA5jxs82/hrfFTgBm52BuqPvXIYo0Po8kpnplGFGTaVs7VAqyPiNWjKPXuppMb0GY8+WZpkox3ikC2gXqlZ6SbxG4Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Maciej Fijalkowski
> Sent: Friday, August 22, 2025 5:16 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: remove redundant
> memory barrier when cleaning Tx descs
>=20
> i40e has a feature which writes to memory location last descriptor
> successfully sent. Memory barrier in i40e_clean_tx_irq() was used to
> avoid forward-reading descriptor fields in case DD bit was not set.
> Having mentioned feature in place implies that such situation will not
> happen as we know in advance how many descriptors HW has dealt with.
>=20
> Besides, this barrier placement was wrong. Idea is to have this
> protection *after* reading DD bit from HW descriptor, not before.
> Digging through git history showed me that indeed barrier was before
> DD bit check, anyways the commit introducing i40e_get_head() should
> have wiped it out altogether.
>=20
> Also, there was one commit doing s/read_barrier_depends/smp_rmb when
> get head feature was already in place, but it was only theoretical
> based on ixgbe experiences, which is different in these terms as that
> driver has to read DD bit from HW descriptor.
>=20
> Fixes: 1943d8ba9507 ("i40e/i40evf: enable hardware feature head write
> back")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 048c33039130..b194eae03208 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -948,9 +948,6 @@ static bool i40e_clean_tx_irq(struct i40e_vsi
> *vsi,
>  		if (!eop_desc)
>  			break;
>=20
> -		/* prevent any other reads prior to eop_desc */
> -		smp_rmb();
> -
>  		i40e_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
>  		/* we have caught up to head, no work left to do */
>  		if (tx_head =3D=3D tx_desc)
> --
> 2.34.1


