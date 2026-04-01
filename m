Return-Path: <netdev+bounces-273885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PfCfN62izGluUwYAu9opvQ
	(envelope-from <netdev+bounces-273885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9D6374B3C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6095302E337
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B061332EAD;
	Wed,  1 Apr 2026 04:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiLY4z6g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCB1D7E5C;
	Wed,  1 Apr 2026 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775018666; cv=fail; b=gszR6WmClnLzGnnTOmawlmfx435En3q5sFKzSSl+zoxqAaU6kPGVsEip2J47V5hX7V7hMfgeDkuTSJlwOvmIPk5V11JgJCeDn0fu8MhG7EBdy1d5XAfNIuu5WxG7YB+u8H0SZHgWxy1Wg4GdaFYFgoY6cd9qvXXIl1jAz5xNq7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775018666; c=relaxed/simple;
	bh=ZQvJWmwXK2JYhZYF9S/1ynbzrjOhUD/HKoKP1hsNNw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGmBYAmFk67Rg5S7rDMeawi1BYytU0GjzQDu+Fxbp0CZmGPLZO0iCVwQLjS1sukg5U2QA4t37+PcxjWJQ+pHHSIOruJ4E6WV2ZL9XE99HhFP6mQje8Kuqv33bmJyKcnXBYdbbfX1TKdY+w2yT+gQTlrKJfAun+OuMKNm7yyLuDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiLY4z6g; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775018664; x=1806554664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZQvJWmwXK2JYhZYF9S/1ynbzrjOhUD/HKoKP1hsNNw4=;
  b=hiLY4z6gdhKa6rT1tJ35ZTy9mx0Cd2WHxHUdjp6THjegQYvFmwZYQ4/N
   tOmBbzMIfOJVBbRbWzQgsv/3DN5b0EEVIIQuBR+FmeDJ77Ca1knS0ISZU
   gg8BLbn5Nu/ClCw9VAEAngWLo28cNcyTQDMl43VCdTbhTEEJ/HHEjnIZy
   h+WgDp9GwVnWAkrz9YMfKVxec99zedERRn4Kg5H52bbWJwawhkF43MAA8
   Z8yO7HjYczGt3OuGtHKSnfdRlTFFANAho/cfgt23lM0gkTSp+2xamIykH
   PGslmvdX59ISxiJTjdlcHUzykGQp0FABT7fW6aQ0A/3wiiW0ZqbTufqYZ
   w==;
X-CSE-ConnectionGUID: u37Tj72qRTiHyZWEftCBEg==
X-CSE-MsgGUID: vMZuy88+SaSZfDQfC61I1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87123203"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="87123203"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 21:44:23 -0700
X-CSE-ConnectionGUID: nIv8ggKWQ+m9R4jyP6BqcA==
X-CSE-MsgGUID: gONm1g0DT4SPftm5GfuIqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="223261208"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 21:44:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 21:44:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 21:44:21 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 21:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oA73uLRZMjcB+boNAPLKjef1yy8fLOb+2kPeRKcAVb68xdUtVVi7Oc/5d+ClBvP0spspw83wmS9z+q7bWFMiRGONPEHuLWBQozQHXe1H42nplcaIeGxvjuF3MF8EwvDTnMcx5OVU7Vyj80hJYizourV7vuKxYLc2txlZnQRMaao93J/3Vb2TjbDJqhGK2TVKNih/vK1wVXkDyzJP85zSJFl52eHz4vKYH/5W6bqwr6NAhg3NMRxSdAm8cGVUa3bw5pFCBvTPPEUcsV1klW5z4Yjww97WinNr/EylIeSy290LQmAJpDT+o45hPwBijXqu11svrzCANIbZMWtCWUkpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQvJWmwXK2JYhZYF9S/1ynbzrjOhUD/HKoKP1hsNNw4=;
 b=fU/B5r+c93RLQsUUj/xy4HXqsYWB7bUUn6UuvC/VipG68x0uV2/r4+cjiIvwiUqHrfJxBzhuFwXcoOsqgGwRus7TV6r50A1gEq4UIlUuzRutg4+wb41MDGOVVTUghREnJ4qlm/3cp5Alwf3vNHSfYQXuPPtl5d2EFlvFgJ5BFxNkur1U29lmD4KXS7QTD7TfQdkPV1w8AXgExJ5EGOwQ/XwG2bbHcXxOp3N2+3cJQ+6QOI2HAEzqeW9L3FfPdnnwePfQ0SWqEsM3+qpRW4NCYOdA2QBJcD8tEN318TZ//sF6wuFeqSiudud57DLG6QjNIiFGaKI4Ad7MN8vZURKSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SN7PR11MB6656.namprd11.prod.outlook.com (2603:10b6:806:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 04:44:15 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 04:44:15 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Byungchul Park <byungchul@sk.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>, "harry.yoo@oracle.com"
	<harry.yoo@oracle.com>, "david@redhat.com" <david@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>, "toke@redhat.com"
	<toke@redhat.com>, "asml.silence@gmail.com" <asml.silence@gmail.com>,
	"almasrymina@google.com" <almasrymina@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
Thread-Topic: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through
 netmem_desc instead of page
Thread-Index: AQHcpVGfjTc3p2xHFU+C1gel+Wqq1LXJ2VuQ
Date: Wed, 1 Apr 2026 04:44:15 +0000
Message-ID: <IA1PR11MB6241186B685C824372611ED08B50A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260224053546.62757-1-byungchul@sk.com>
In-Reply-To: <20260224053546.62757-1-byungchul@sk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SN7PR11MB6656:EE_
x-ms-office365-filtering-correlation-id: e50f8604-8097-4662-91c2-08de8fa953cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: zBB0ZLOLDlBI9OZ7Rf8m2JdGgC03oyhcA4FMPtRCmjr4RfzaGQhd4fx37szZY0BtrCdVWvTMQ7YHcOgTy400hO9/F8hqijw7DVCz8iZGFy8/kfemxxaLUf4mQLNyKm8ye2L4ELpwo1VQw4VuTiv/WPpXHTOf9PmGdsAf4+Ci4zU2xSmCMc0qXEIPD9tOOrjo5OIJ9spd83REV1EM/ADm7dTqdupDi1155wTD/yfWTpnPy/L0/4sWKEdfC26bP/NsTYEaz8m88N4RD6OWIPFLaRoCoHvnkeWgl7gIyrpDkgzgfnVjGtdY007RG47ecOa74cVc7rbuY0oO1kAeXlFN19nTUJoxHJXqCK5VyaMjYA9vHMf5NOWvrnFE9BWQM9Oq7mAJ+zDBrcDry8D0Lwtqzdd06VYG9U4UDNXUVRbtfpAuca7aLG2fJdoA0jWYXPqI0Tho8z3MkFF2d8kkx0PMD4SLA2VXmn5+scxHR08O2T6thTv4JSoNGYgvNLu3T4O17lSRPAmbHGUKvDH9d0h/puM1azVn41/ZjBxLiUb7264xmrqasbiE3SFdQES91CNbh7yu+Q9C5c+KTvvUDnzpsXRMgJQnNoS9YVRFomYSwb8XIcNGbEv3tjsD62AAGzn26U4UroQSTW8e9Qcn5OEyDlH3BM8C6ZMMiqRdNk5ddVPRVQE9c16hvtQXhhqvGvZ++l6+9Kcvn1rLFiRiXS+7TPgUjuvULLv9Ivt1xFaAOlGg8nWA+OwcXaVh4gd5DD7lJN5lDDJiOaLP5YyEwZiXBoQBkmDz9H/j8yn3P7HM0W8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MJZRAM9HNJI+XQsHZGPLbRK+XAByfXCoGgomiioNeQgNdWLUXjuqpHGmPAB9?=
 =?us-ascii?Q?5NrlWNL1eAE3As74iUvbAVeI+d5Fza5s7r82UQi0tOlBN9KGGE6D3rwgv1M6?=
 =?us-ascii?Q?KETGIeQL/LqdUDoTFkYZWiMRVcSZzNnzOlFrI39vadiVgVvT9S/GQPjlkhls?=
 =?us-ascii?Q?+Y8/wN1pH+nzMtS6XOvFGn8BNlXSlcq0Azs39VimWOM73H+mTv+uTISFU4+7?=
 =?us-ascii?Q?LQgrSM2iZW4CbE/s9imUK8kV/zTF/gXIKlkChzjlb8ZwJqzSlNE4geX3IZf5?=
 =?us-ascii?Q?o8p9G8o1xM6opYIMqNXAnNvuZl6oNmEI6JBgS7HNq6bCkl8FGNOPTriVklHE?=
 =?us-ascii?Q?hR5NFtFBQ6cvS6sNwISdWbF4UHYtDDOzNxdeCn0RnwVp79xgB471aolzkEmo?=
 =?us-ascii?Q?HPZpL05rW8nlaiLIBRKzppoNwj08cy53Jol4u/2OPT1Z9zXFlWh+sjyu6R2l?=
 =?us-ascii?Q?ur1l7tJkMZ8lJXO+TzKBPrvEaw3tlvcLWx20VoaT/7cWrFPmEuKH3K9+VBxx?=
 =?us-ascii?Q?a1iBnggDCm8eZFZd/Y3rkuVsS76LUm7SJU99a18lif+eF3e5MbFwBqRQxT2N?=
 =?us-ascii?Q?rIq5ldE/TjoKU5DOvLa6vhEgeg8dSNJ9g8czH/kT22wU9xlGgvlIjhdcqWdr?=
 =?us-ascii?Q?PtGE+Rm3YGpMQGum4F1JcpjGCgeLLyCGqpZv92EEMNONi7hnHqBkbY4HGyBF?=
 =?us-ascii?Q?D/WrwmlUqxOiaFGC3m3ZanqdAMaVktr0/nK/ipHdvzZMNeNH6xZJqTZqT2lD?=
 =?us-ascii?Q?VC55TbwURrV5V8e8WOHKV4KGPkdUxQSUHhkXMHsWZstzzlYc4q8MOdAkByop?=
 =?us-ascii?Q?sc1Gc8/Dr3FyUjvJqtcGoTaUEkbYfrUEC8mdcFf2+M1Yz+B4GTmxnFNc0r7z?=
 =?us-ascii?Q?w515wrC94MSBFVuYx9lCaiiCPqMhuKhp7PCZpRJw5iM/l+3dltkhsuSC4d2C?=
 =?us-ascii?Q?kWRWF63C08L0fBcdNlNzijMaZjj99YojQybgbxo1zogiswR0snQXwC1sK5AX?=
 =?us-ascii?Q?cY+ELBhdtvyhc/kNwtdqA7B3zOCDX0gA9ITV/DM8ga1MDr4yI5qC8+4K2uhP?=
 =?us-ascii?Q?sFDS5LgmQRMIDbAyfZmkrHgE+sSnDZp6QZ5AP7386DakqWjRYONhRYkIZub+?=
 =?us-ascii?Q?xGklv/Yx4ZH8tgxK12xawvXoKr9SoxU+RJUss2MVZwx1Kng9QjM0NjB0vOgK?=
 =?us-ascii?Q?igu4KERK0GmU3tP3RJ0Kl71fsWcyJBlUe/g3VxrQ/fvmI52gYW8BHUmiY3sh?=
 =?us-ascii?Q?vmsuavcIos+YIWzGY0fdFTMRmomNcUWcBOfa/nHqBa0rhXy5rjZtXtNAzqMa?=
 =?us-ascii?Q?E5rupmN9B+rEttTXhXdG5PIgIgHTIITCJYA7GYUmsHpVggkJOammHAb0bUDQ?=
 =?us-ascii?Q?YjYgGlbjPeYMsjJLccoau9l309YeGw6PvXAkDhnuzG++WVaWAbLIYsb5hbWa?=
 =?us-ascii?Q?1i9QJ6zj1OJHe2gmm8tJpTb2NzwljWslnbRJ+PzI0lIpEiAVKWqDPHMvwS2G?=
 =?us-ascii?Q?ApQM0mfZQWMrzg+vQPpAmCuw8m5Yre2wyocY5QjJTF5jFVxZ/rxkOJtORRjZ?=
 =?us-ascii?Q?RS+1EtDzL5e7Ff76PV2rDxiXcxgPH66kpPYcnBh+x4PoHmb8la0/WPr8xwfs?=
 =?us-ascii?Q?ENpS0E/68B6B5EyGXRRsMKMbBE0e3GKY6+etLwwVTod/1kGdRBuLyEEg/+2j?=
 =?us-ascii?Q?2SQU7XayDY/9hRrPzIunntTOFkVhNAG2C/6wEkW57Odt17po?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XKX5ZpZaJbx87Y2Zv90bmx7lb+lMZV7Fi8SM64Ptx+7zVcZeC44zga6aqC0/shXQNA4M+JG7We++ABYCG8EajhNFc5Fun6xL61avJWpprKIS3xl0bun/GwWlTEJmgX5i+VMP+JwvKt6Lglegvs5u8/DrIaqT/IPhvICIf0Cg1mboAQv5sWwpen7lhS9GNZzQdB8ARADZ4BkqsZV9dSqHwL9oHUJ6p03ugTgcyKR0C3TvMWVDQPh/ycQCIsrDlwZQE9t/DE7fBz5/LSKnfLBnrMV9t2zuNCTGfZuLWLUNS/eKKExpY1bD1gPjudoGa3Sa8oUwK9Zjv/SO5ep+XSjbmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50f8604-8097-4662-91c2-08de8fa953cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 04:44:15.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0cS2uWTW5lUP0/CIIX/Dqw7yu8VlbOaYwEpmGdCydbsbzF7eBTIGbNGJ/9egWD1R3MD6h5xX4kZo/4+yiwhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6656
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273885-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,oracle.com,redhat.com,infradead.org,gmail.com,google.com,intel.com,lunn.ch,davemloft.net,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2B9D6374B3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of B=
yungchul Park
> Sent: 24 February 2026 11:06
> To: netdev@vger.kernel.org; kuba@kernel.org
> Cc: linux-kernel@vger.kernel.org; kernel_team@skhynix.com; harry.yoo@orac=
le.com; david@redhat.com; willy@infradead.org; toke@redhat.com; asml.silenc=
e@gmail.com; almasrymina@google.com; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev=
@lunn.ch; davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; inte=
l-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [RESEND PATCH] ice: access @pp through netmem_=
desc instead of page
>
> To eliminate the use of struct page in page pool, the page pool users sho=
uld use netmem descriptor and APIs instead.
>
> Make ice driver access @pp through netmem_desc instead of page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

