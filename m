Return-Path: <netdev+bounces-270498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKQEMm8qwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694CC2F17DE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 864A23009889
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE16399359;
	Mon, 23 Mar 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+YNDUg7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4328397E6E;
	Mon, 23 Mar 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266988; cv=fail; b=oc61pB7xUzY7Tj5F64XXC1LZvzF60fx+L6hwIAVip/tbvoaaJP+UKKlxbP6Wws43KP6HXbJJLp7kXwvPCyGyaTTiIGl2k6LZa3y/lp1k3R44s1gszVLy66D/RxbCoY730A+hrD1MUWe60S0RRgRTX8qvQogT1KXct2aVclO/N/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266988; c=relaxed/simple;
	bh=uSrcjAAXNcoHk99wZU9+xmzf7YQ2j5rJCWbBqn3R2rM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H14eSW+BJKDLOTi0EYrDvoxLd8WVdd/MMC+obCcc0rRuyfJ0jCJgNwFnT2kEEVIwG8Dkabo6dGbcKmx0Z2pBRHfvBuD+LK5cbavlWFaNqYbMCSpjSlmRJ97ms/ivt3Et3p2iriVeCoDGuxeipiMr9ySm3Z/xlqkPgkexTaseBjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+YNDUg7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774266985; x=1805802985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uSrcjAAXNcoHk99wZU9+xmzf7YQ2j5rJCWbBqn3R2rM=;
  b=G+YNDUg7bLSlQZlZg7ntt45pREY4f6WimyiefK8XgUDxPtEytLye4Iv/
   SyqDOz18AHLvTPcdPX8vLWf1Ptk2sNV3PRlDASxNPgKUH82oOqYeL1j1V
   QrfoyoMGHu++PgqBeP9fFevE7C9yuw7v1cPDKTK6PBsz8rSA6G9h/JbwK
   fnoGH4LgBIaYY4vk5XtnTxpclpoOuq4xESLaj2VJrwlzNFJlWlExXg15W
   itrF+m2J6krB20qt8PoYlkOIqWctV5VbA/0nWMGICVrjjxy3NMylJlEF7
   mjK/6i+4V85shgl1/2q1eK4gcxwLcieXrWkyyDBTY78M0Gp+6Dr/rPbnJ
   g==;
X-CSE-ConnectionGUID: XQCxEcztRIy1cKiykACdvw==
X-CSE-MsgGUID: VqOsdpzcSQ2ldTNUyL+2zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97881830"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="97881830"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:56:24 -0700
X-CSE-ConnectionGUID: nwqcOwMmRwGp134AsEryqQ==
X-CSE-MsgGUID: SVkI97MHQYqHLcc3wcKTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223077288"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:56:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:56:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 04:56:22 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 04:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXL9aDZoSzgspiIhy7lEYFqQOTBZ5T1G3XfvJVzJ6V6rjzC0yMvt5uQQg3ZAdSxz6CBByzktyqJNZ70mey+oOGkWsterovwmnMrphuZEVZxw2lIT5SkPfazTAwGamOJQYdQT6fZRxmkHGddeT6tKQetU7rbpbfZCFmNc/0PuEM3q4eg4HnxFKYZIIHNAJ52d/MBe5A64A4rxu/7a9/+mDHgtC6d/bOVD9/KCkb7Hy5ffPnFKY2stpQmQksG4thczAYhVK16/LjhmPVfAqMDnDL0zPe8DHgEGPF3UHoakisu9PnvXLAuB3UUHD4vaBR+/WkSWIHwoJ1ovHtKnVNDNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uz1VQRX7z8Z311vbk4bvUcBQuE2ilzktPkAViEMf0Y=;
 b=SYVVT7QP2fabvdjPGIBv2QVXs6zEpDv6udE54/aBni4Vr1PskBULsejmctP9NeZvVvITFRPACs5VkL3hVLIPOZGkdfoKeSWCHjkga5RaD7d0mkPY0y6n66Ca8/v1s5u2bSHdrSRjcxE9aa42v/+Rpcd5AJyeNmX7dH0XlQ58F+mpqzVG2sPfPG+yw1JUeLXqti8qWzxCU5gan5F/AX5q1lKDAEsfg1nQxHKYEWixonEYidS6+Tj1TUWoT7pbcMUVgS1iSspp5NnHZEi1B9LOQrV/un+hWcdBeGBk+fS20U5q4G7pyh2c4ofmLKYjCR6hylNRx/Zu0N8GH+BZ8lRNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV3PR11MB8530.namprd11.prod.outlook.com (2603:10b6:408:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:56:18 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 11:56:18 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Eric Dumazet <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix wrong VLAN mask
 for legacy Rx descriptors L2TAG2
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix wrong VLAN mask
 for legacy Rx descriptors L2TAG2
Thread-Index: AQHcuq4mc5PAVG76qkic8lInrYAQXrW8ArFQ
Date: Mon, 23 Mar 2026 11:56:18 +0000
Message-ID: <IA3PR11MB8986767A1329ED35121D6E62E54BA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260323101558.1477593-1-poros@redhat.com>
In-Reply-To: <20260323101558.1477593-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV3PR11MB8530:EE_
x-ms-office365-filtering-correlation-id: 3a2db3ea-d992-48a7-b872-08de88d33175
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: vFnUcEfuIC55tdie4sg0b8iczJpbkRrb0TpSKMvKIL7mywaug93nbDLRM9+ApxxEHWkllY7b93H7q7UqPMX/korkjv2H+YjNfIx6pPnBRVc2EuKiNRyyyoNGXCzvh/s54rGkB7vd6KZqlM+gN+C2P3w0zMN3/0tWiqUKgXwrVGVh3PtbDoivpMjIrS/BuVYPcH4t/T4ZbMlVzrQsm/OyHb9BKka0b5gptAWC7X6mVcv7QAKCa+xDx7e94sX/MBoyHEJsd9Dxcvs2yfqvXhfUCAZwItiK8G/Q0FKbSRlxYj2yPgWIbbLvn0ygSLCYpCtzArFcybXMQFid+G9oidRREfygdg30rq95tpjGynktdDhTwYj3EVmp8tSoNTwLGjRu1ud3RBdwmfgUt8zuB177oJHbBmL3HMOQQ+lJrU0FR7cHxeadj61eGfoOBPteFOiKtQAqXYRcgUMJ7OScQlEtXZPs2G7G6MgMERlbBbbivu1gRAd9QQPysupUt2eGFoifi9iGBHteQwMZ8MCAbGHPuaK6XgLZcXp2NW1LmjnV7hnnsyRHtVgnm7C5V7Q8S6EYHCSFP9dvwRO329ppV/5YkP/LTe1quifhEWlFfhxcwpBv9zDpOm+weORgVpOV6tvXAkW7Uh2FPMrwccrGVUE743hS0LSDCvSARoQr1veKtTZXRmcyBj+dSNkvl3CfGjtowRSlQejUiIfPiQzPDdf3mslcoitYSnI2R3Pg8uehesx4uKmhQarGbkRfFZJoRvLEVD+H+JehLpdwWkeO038MtZhurfBoYZ1aFayTy3lhNfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQ2NF1hbljqUwvKv9L/nIxAQiio4opFE08kGPa4QtabniJd0o64S1HLKfBzn?=
 =?us-ascii?Q?Z0dfRKwDF21+nGIXCkEKDQ4QaCFQdfNwrvgKUUQkhu3n3ScYUexlgGuKKXUr?=
 =?us-ascii?Q?Ke2bEqwedf5XCG0akpeuNhfXwM2EgAi2WKqY9UfnmjRGJlwrlEBEBJdNDAJX?=
 =?us-ascii?Q?MlZaGJ+7lRKNClE+AaUqKaxCrihowU9gV2NmZnHPd91V88QXx+k8BzLz4rZ1?=
 =?us-ascii?Q?oHy9u6TMRkYi966LK6zlFmz1zGrcpMvnqMKAT8DnVoi6Gw22McR8+CXC+fhC?=
 =?us-ascii?Q?ud528ryMAtnlDHQto7bH/pWvfA6xLGY6cGuJxt5CWzVLJQThjIyJrx0mYa5v?=
 =?us-ascii?Q?njo99s/UdFAfm7SDNzfk3PSFuGEWm6kWD+mc7FKTSO9z8Fxr6jkN0ZH341UE?=
 =?us-ascii?Q?/hPf12zeS2ab1lpN1qB7am49smeZMYID0TfxHFoBmIwOmyI5dpW8ZTBp4zO+?=
 =?us-ascii?Q?qP9l+1jP8ulY9ejK4B08yp8i7Qc43Wq3ytjTjfA3wcwuShIc2oyVxfNOtNhC?=
 =?us-ascii?Q?dHkrIWqzd+tarX+iR7CodnwtF/uqUOZ8hcNIkdlWxXTtMNE1rifVuJPCxTcY?=
 =?us-ascii?Q?fnGngQB1MTUxlGHpcW8FPokKBP6Z1TrFHbwF2J6LPpAbf3LnqXSC9M3fubGR?=
 =?us-ascii?Q?mkCfFfXreJFKQcoF1Kjq7YTL7rjA59qtvbmYfjS5qqdA2MAxpAG7w8fI2A5b?=
 =?us-ascii?Q?BnNvJY2fAAgbfhupGx3lzRdm/N0PUZBBogq+xkjbfHziRrmBJK4h++jBkTjS?=
 =?us-ascii?Q?n3pZI3FafTp/8PxveUVrzc8sBXxnMq+uqbUyYu+71SHI0ru1Ja0OnazvknEA?=
 =?us-ascii?Q?en15Ybz4JhM1MlXwonOoe9K5zLDmvq/7PKB6LgzeYHUOcHzd+KDFSBEAlJ41?=
 =?us-ascii?Q?r5F8q7nx0K3YWs2y4X71B2bOHKbQ1qq30en1CcfS0dHvTNYWzgeao1A2TV18?=
 =?us-ascii?Q?FpflJ5vaBaw+HJhTBU+YZmfKg7M97h4BLJYu9Xj0cgDsNJ1BvkGytCY15zLN?=
 =?us-ascii?Q?6IsKGsaipBvrg5/fpbyw2+uIfM8C3fcXi3WoBiPCuseWVE6kGj7ArCV6ODyj?=
 =?us-ascii?Q?09UTbCyluiEkcLvymJdqw0uKYIuAa40t0MFUvpGsFBuwyO2PutOsllbJlcP0?=
 =?us-ascii?Q?AjHVCFdMrNeeikmUrBFKxjPurd+9CQrT0s4Tx4TCBhmq6l2lPQJN7pRwt8wv?=
 =?us-ascii?Q?y7fxhMfrn7RY7Gtsgc0/rpfv/LiGzBPyj0BBXDNOZ356zsmidXeMfqynXc2e?=
 =?us-ascii?Q?dEcJhEy9HEdYEDEkx7i6L2HD7bj5g11N+iQBOfKtL5QrJPUSbT4LPxy0AkoH?=
 =?us-ascii?Q?6jNSz86Bek5lpxiRbpU8DjskvSB48dMAieHIGTdcSHevj+TXapL9Ti3M0RYb?=
 =?us-ascii?Q?m+APc+QZ5ceHzzkL/KiBQMk7oI6TnovRPUbVw/W2y5CS/sGzmVROijS7LfRt?=
 =?us-ascii?Q?REd7EU6H3n/hdzfpWiGV35Psqu6Xj0qBS1ulFD6mB4ehDWI3bL0aNVnoR3Xv?=
 =?us-ascii?Q?k+Ynmxn43iWbHO4PZC6ZyBbnYGe+snxlpO+uI6/cA+OhOVWD9SEsWWbNlqW0?=
 =?us-ascii?Q?M8959sWOH28BvMuBsNQCesJj370qqPqcFnQVTXcLCctnm/Gt7x52DoBNeZWa?=
 =?us-ascii?Q?TYeaO8aJzcJIEl2i+Sth8oyZmF1m/lf1nGwmohl0cUfRvbsVwmdL8b6p17iH?=
 =?us-ascii?Q?fpHlh5YQzedEDRZs9Aybz2U+Q07nGuoaAlfjERaA/C4Y8EUS/SIo/Wn8eotp?=
 =?us-ascii?Q?xFltnW9nIhtrgrjZy7GOWMWB9Zv/N0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GdolC37oO6GXMlA7qRQ2wGqY1q/ammYqfUIUWq+n3/9gdc+qUUt39HX1e8hqN0fDKjWCJJS6lRyynGWMh+XyrpFGrDH4Bg+w2aX+nSynlfAZViWeUJZzv2o1rp9EAFawi7CT5D83dqPKTkIuyIvrjsXdX59TLPLgG0otZHHT+Lkocwn/aDJrGAORXejDsUYNgh0yuiPnO8ghud5YrMLbj4kknwOUeKcuigFF/VemSAA/yRg01ttykie85FSvwaW4JGrtlSGdpHsu/XRKJpJJkoF5lK809PF/E/QlJYhgOkeK1JASoQR8GzNUl+mpyH4OX6HQq3lMj5Slx4dfx720DA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2db3ea-d992-48a7-b872-08de88d33175
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 11:56:18.2375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19gElGld+e7DoeQAa/nyDJJpNBzhn+9EvhZlTNvAC7x/kaTaNHc+M/d4AEOvluglku/1KsNHjcd9n1/gxNk+4NbWOya8HT77eBByVsHBFx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8530
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270498-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 694CC2F17DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Monday, March 23, 2026 11:16 AM
> To: netdev@vger.kernel.org
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Eric Dumazet <edumazet@google.com>;
> linux-kernel@vger.kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Mateusz Polchlopek
> <mateusz.polchlopek@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>;
> intel-wired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] iavf: fix wrong VLAN
> mask for legacy Rx descriptors L2TAG2
>=20
> The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
> GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the 16-bit
> VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2 (VLAN
> tag) occupies bits 63:48 of qw2, not 63:32.
>=20
> The oversized mask causes FIELD_GET to return a 32-bit value where the
> actual VLAN tag sits in bits 31:16. When this value is passed to
> iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
> 16 bits (which contain the 1st L2TAG2, typically zero). As a result,
> __vlan_hwaccel_put_tag() is never called and software VLAN interfaces
> on VFs receive no traffic.
>=20
> This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
> advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
> used.
>=20
> The flex descriptor path already uses the correct mask
> (IAVF_RXD_FLEX_L2TAG2_2_M =3D GENMASK_ULL(63, 48)).
>=20
> Reproducer:
>  1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)  2. Disable
> spoofchk on both VFs  3. Move each VF into a separate network
> namespace  4. On each VF: create VLAN interface (e.g. vlan 198),
> assign IP,
>     bring up
>  5. Set rx-vlan-offload OFF on both VFs
>  6. Ping between VLAN interfaces -> expect PASS
>     (VLAN tag stays in packet data, kernel matches in-band)  7. Set
> rx-vlan-offload ON on both VFs  8. Ping between VLAN interfaces ->
> expect FAIL if bug present
>     (HW strips VLAN tag into descriptor L2TAG2 field, wrong mask
>     extracts bits 47:32 instead of 63:48, truncated to u16 -> zero,
>     __vlan_hwaccel_put_tag() never called, packet delivered to parent
>     interface, not VLAN interface)
>=20
> The reproducer requires legacy Rx descriptors. On modern ice + iavf
> with full PTP support, flex descriptors are always negotiated and the
> buggy legacy path is never reached. Flex descriptors require all of:
>  - CONFIG_PTP_1588_CLOCK enabled
>  - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
>  - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
>  - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
>  - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile
>=20
> If any condition is not met, iavf_select_rx_desc_format() falls back
> to legacy descriptors (RXDID=3D1) and the wrong L2TAG2 mask is hit.
>=20
> Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support
> legacy and flex descriptors")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: added reproducer steps and flex descriptor requirements to commit
>     message (Paul)
> ---
>  drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h
> b/drivers/net/ethernet/intel/iavf/iavf_type.h
> index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_type.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
> @@ -277,7 +277,7 @@ struct iavf_rx_desc {
>  /* L2 Tag 2 Presence */
>  #define IAVF_RXD_LEGACY_L2TAG2P_M		BIT(0)
>  /* Stripped S-TAG VLAN from the receive packet */
> -#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 32)
> +#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 48)
>  /* Stripped S-TAG VLAN from the receive packet */
>  #define IAVF_RXD_FLEX_L2TAG2_2_M		GENMASK_ULL(63, 48)
>  /* The packet is a UDP tunneled packet */
> --
> 2.52.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

