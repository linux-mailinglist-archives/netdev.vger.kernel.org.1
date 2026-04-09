Return-Path: <netdev+bounces-276837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP8dCHAh12npKwgAu9opvQ
	(envelope-from <netdev+bounces-276837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:48:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD03C6141
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABAB300D16B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233AB2641CA;
	Thu,  9 Apr 2026 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g34YEb1K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7E175A97
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706477; cv=fail; b=iUv0qgfU1uQPs001/ZPogvuTDak5q6VOnXm2HYEQTUi66KJ+a73PoK8ZDPIyzy+o/xaqeTZEQrjs+neFmwR6sZWtQtxf76fszYBjpf9/TZKeeQz8+cpTzAmBNFdaNPIbnQRmVJ11Bgbldu9EANCCgSksTAT8I56E9vZgZBYEAa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706477; c=relaxed/simple;
	bh=AUplrJCXv7dtrUhq15ArzstwBO5Elle1lqW91XU2jXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AM+ZAHSqhaYK45LfwlDW7h90vDHmMwbztvXgRU4L/0oLQMKsFRRbkw/3dBuDqGDlKEjUhQtmRgOdBFGccb2tfZExZWzRztFpmRbuX3yH6DerFU3xZaWnqrdDd+HtHupSCMJh+5NFrW44WR0rYha0fzjt1Ee/XUI6Tx2XwwDyN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g34YEb1K; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775706475; x=1807242475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUplrJCXv7dtrUhq15ArzstwBO5Elle1lqW91XU2jXM=;
  b=g34YEb1KmgtYrnekCIttCrSN4dGURkZa6Ppmc7h3OAJRJM1+u6Ivo5CR
   CpZI1FQT87wuKLe2K7kg/kFpLbKUlilQTEjRYcP7CB7QjW1gvEYYLJ5qO
   w+d3ROw79udKTVFqZWz6SjEOyZfL0oOSkZkvV9dMg/n3TWqsyL+CLq+Er
   5Ngwd7008cjc3yXxbZxLvg+sp2V7SB7JoKo2YsaTiS5oyWrMo9tynvKNJ
   848DG2TY/093Isysejoba3df7xr8dd348qDfa4Nopeb9p3zkSUsjqIMnR
   MX09SBYdTFFrekH3S0JrKRt4PkpE/KPUg5rYG8fAbwQe0dUPSTrNGLVEd
   g==;
X-CSE-ConnectionGUID: 4aHOICSyTSG+8dpFjeYziA==
X-CSE-MsgGUID: v6ywCN/rTkCIaycFqw4Mcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76774550"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="76774550"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:47:55 -0700
X-CSE-ConnectionGUID: todwbISsQWOhRjGQf+LAlQ==
X-CSE-MsgGUID: UrejNz6TRGyY2PVlWkZ/ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223899565"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 20:47:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:47:54 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 20:47:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 20:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deTiQVogYlaSwPIz/zjusMHdR9B9rCXYC3mMOVNtIbIkuMkK5DG2DhYBvlBdrr1uLiVp4C72YPMCcHEywIk5r56pjHi0tfqeMOt0lsE5r5CbjztZGIMRz44Cojbinpuk/qyDN/tUea3IrpaLppJwrzj6CXF4SUdKf7ci85ib+UHecxg7Wha5nk/KFFHBWak3B9c94jLMuvonzLQrdvvjv5IFUoJpymCYubAvatldDGobxUmiJgvQq5X0GXxHiHxOndaus6fSbbpFlQyoFliEK7GtSZIy4w05K8sAR9nWeC3ruHRIwLBIB6p9pFPi4shps/kGIORmlqK+G2rcag82lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLuqq2c/RwxVD8YjILK+d1b1C4YbbSNwMDhbK1EDhSE=;
 b=D7mqr8lew09+nMnEM8M6vjxHgu54DZYZjSsdE12jXR8xMBnli+8JuQoPQbvKuGlOjiqsU9pnM6VCun55w6xKln9V8BCp1e4DFrQFjJGIa6/zvYZUSvRF82gcfGZY+lg8kuVDZP7CO6tq/4nQj12u1AJOlu3/R7lWG8XKCVm0Y542BKyv63axkYoyXvxIfow2Eg0GxxpUzJPB8CQUFwnpjOKIBrRuas6XsrPV7sCGu3dnBp6soLCWKDirxvOK5tWRMZYmJGEwMqN4ItyABLvyxNO3+jV6cCIveQC4YZkzNWGEkEJPr1zypdVA4keLKHzk/vZIx3X6XlQ91Z3ZlCot2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 03:45:44 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 03:45:44 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Alice Michael
	<alice.michael@intel.com>, "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v1 iwl-net] ice: fix potential NULL
 pointer deref in error path of ice_set_ringparam()
Thread-Topic: [Intel-wired-lan] [PATCH v1 iwl-net] ice: fix potential NULL
 pointer deref in error path of ice_set_ringparam()
Thread-Index: AQHcopiFqIhUxjzJeESVUXroisa3/LXU64jg
Date: Thu, 9 Apr 2026 03:45:43 +0000
Message-ID: <IA1PR11MB62412B7B0C1193BB6C6038FB8B582@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260220184031.60113-1-kohei@enjuk.jp>
In-Reply-To: <20260220184031.60113-1-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM3PPFCBDC4B878:EE_
x-ms-office365-filtering-correlation-id: 82b03b8c-2a8a-4c19-5b01-08de95ea7a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 0swGyW86nT8RCSkCYo2V7QGd/bBWQr1Ki8jGKopmcWtXqJ9cBg8EKmMfAd8hfbqsIjsAd516J5SPWrq6ErolqgkixrBgZDVdxVj/SnGRQ2Hau4RFIpfvwIWJTPKA+Ktg+0L1TwrkNaYrus6LhfixEaeUoYgfEEmbO3AovMygm2dDrcHhjOqDBBqhntfUXby5RIwkRvXB41Ldc8KqUEJQL2NS5ZqmbIxFctQFZfTPs/4P1E0Hl/n5MwTu6IvJI58NSN2HO51jHGOonUWT7mIlQRzYLLNIDyYLrvwpG2BjmWxE/+8dfwwEaJjp+G5m/K8wqi/fvEfXpvzFWVtw5j8RjoE1kn0uziB5WKnhlB6BScDB5wJJQXiadI1U59f4KoGAvRPGeNVIUhoMJ9kNsw0pCPsQ4PN1kRfxyCVjY9LpTrb6Rm+SZ4UMkOOVivACaz4lvgo9iPXevVY5gK5Vqh4f0PBRSpE4AVkewUGJ7Cesug6oyUqJWxOTh98S4iQYOdjT2jvGxpwVuldYbiPYy5P8TZIYUnsrnxBuyWkAxXcA5du5HP+BvW6epUonu0JnLLh0DzkoUEQ2T93qBs6vVKhwSHT0OJ8Nmw3gOussASV3lIbg3oC77xGOiRVEigVDteQsInBQYi6f07Ml5vX5x9h4h9EAWAx6fBR0g4YVcUyOef5IWdfQykH74a0wCSEs58OmNdBv4yjPqmL6CwQRzVyCgFtS6oDBWfbuaEFUwvcEf/BRI3IYnMStja34rFIyh1SCQmkNyIlXyBLsS+0VYS/DTOLVQE6BrS1BFXRF+ed0St0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mRSs0kKmklnLWI3kuDg2mxNNJ5XBg7lbkfDi15d8Te5xh+HjkFmWJBbBy/CH?=
 =?us-ascii?Q?MiCpgx3PwTziCxT+yBiVRFdzkqekAv9d9iyKLtX87ZqaogzQ1niwwoVcQSLS?=
 =?us-ascii?Q?zzYBssyhQr5rcYRSxkWZMzfCuYy3LuYHT34ve/a4vHolgX3aGKSXb5Xxb5Jh?=
 =?us-ascii?Q?I2rRbwz1EutFX8gW1MDerYOd6T+8oeJNbG9PfvUXaxuJI0qDwMS2MQhmqtHM?=
 =?us-ascii?Q?kGPZrEYqGTSLdTGwKEqbA8JJbDlt8KEk9Kw7Ypj5DZMCf+J0/p31tSMLt9OI?=
 =?us-ascii?Q?HgYu2LiI2pVAT2hwNS2cs7g8dLW2/PbZn2AP6aYfNSCwUwee/60Teor3L88h?=
 =?us-ascii?Q?Pz+byUuRhvSASWP30of6w6o/F8gW3DMi1FyY6ePy2C80AHLW6mXybe33qAEa?=
 =?us-ascii?Q?+ZLeQVNzkSRjdFI/bURzwM+KMbGexB8oWQk8E1hhjnCYXt7xePqlc4Lq1pl6?=
 =?us-ascii?Q?H8UbvyH0UyDKPBSsJwI6dGQEfDHP9428ekVjjS/ehmn5roCUg2/mMU19Jn4p?=
 =?us-ascii?Q?5NsoFr0hKHAMBOCqMHdnrX7mx+sSLI0waZlUDxN+GiDWSflknZKco46JpD48?=
 =?us-ascii?Q?6qfZUBRVlGuucV1xgHoey9lgUF6CiKabC/N+4z8Io75/7cE9V1X6cUHOW4xT?=
 =?us-ascii?Q?6Vn3CSvWOcDfCylIQgZiETln8fr26sxSMxTI4E8wrwp/sIDh3lbrvbBHddhH?=
 =?us-ascii?Q?66WJ32OMk7h4PKEgDa1zUmkXdLT0w3xARFhPx4ByeCHnSA93OW/FKLhMKkAS?=
 =?us-ascii?Q?M+7XAqG06CmgXpTAY3byKOkUODrAvLtK14JZ3W3fBjoVnjmc5rqe4BgncL0K?=
 =?us-ascii?Q?5yRqt5hQDJ72xL4hMnUx4gmzQOfAy3GA1RuuuTVDmSromaFxqAAX6PYAZTa0?=
 =?us-ascii?Q?N6zWMclfKBp7lfUXl+5oWZrbPHgcWtbGiGmlGVdYLqDHbiZ1gtY4T2qLKcDL?=
 =?us-ascii?Q?ER+PuQGpw0oFjj/LATzntAXa4nTjYPm4wtXUIORTCUbq+tfVGY+X7TsBTVYZ?=
 =?us-ascii?Q?E8FascK/+dBpjJJxuovyPsrp4qoYXwnmB+awfBnlcLNUdkyLGaWvKURFp1pD?=
 =?us-ascii?Q?5VK/8KTQkWKPEMV64az2wlnq59DRxDzaky6sGTO1Y2qbVpVjXHg+yLsIzwCm?=
 =?us-ascii?Q?4ogS5LzTBaQK4zAJqlEfpiBCp5s9DJyX9gLCP5Beqn6eSn+uCC9Sb41yCH+Q?=
 =?us-ascii?Q?dy6TiFVE2xVGRdyfx5g4+dUDlNJKTY+mMSfOT3BHGiw7DusbAfk7sopikRcO?=
 =?us-ascii?Q?EJweM2UituIFu3GY4iST20ZImqH0bFpZRT+W6hkEhFtxvPI0AIMrLmtCQpdt?=
 =?us-ascii?Q?8tdJWRpHn62zXz5d2rMhgk7c+kK9Af1kLjI0ZP9G/gUdUU2qerDOXemO/VFh?=
 =?us-ascii?Q?ZB10wuVBuLpiKAjcV98cKg0GkEq1n6yNuaxS5tfU7i6+sZ8BJug2/a9inFvQ?=
 =?us-ascii?Q?O+0x7L8UpTn+rBFtSbQ0/KjJV73wW/AzL8IO4AMBBkAjwMzRxX8ilc7GTUlg?=
 =?us-ascii?Q?0gtpVODLiDDtsLQStNv7Sg0HGDdtcmjUz4k0feEprd8BTD+C/XdPIChr3CEB?=
 =?us-ascii?Q?rUIvwXWbTA9VmRTJeGu2jjj3AWaLldpliHRUjtLXvVL+GnxpZe23rKYVtdJv?=
 =?us-ascii?Q?rpgbbTX65ZbPfXeufPpLcxlQhw7XB5lOc9TnInQhOmCnl+yUyg1b+uenlcxU?=
 =?us-ascii?Q?uvgasMGa89dwOfltyCg25LnjzRPfWohj3U814cTqcKPd5VzD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: duvP+78cwGS9VjI7OlCULZBVSj7nKBuAj0DOQpeQ10oW2g85lyiMgMd7Cipvs4San33sW2qAn88r0IA/spJjELf7s6d1pfh0kpTC7mHmhxWM2/CTbmBYBd3aLELj2+dP68y4codF00n3qkJ5FiNVTZwmEMT+cjH372kwUlKqbvLKZAQzhsM4+ttu9D+FZnvOn+Zuea2FkrvPHkWsNcWYiMqzxtEPX0LkSQuMQvOHJ3YEC1kvGgjWY/6VqYZeGUISDZ1jmpqywizWLxE+TzjAwplu2kgJVsfL8un66r9rTh9ASxc+iQYVEnjjpChnScMIIv2u+JOli/vFFKOT/mring==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b03b8c-2a8a-4c19-5b01-08de95ea7a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 03:45:44.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAplCHtXOE7IYALPvxM/75/lIO4SyQjkXrzf1oHs1XJfFAjr6VwcJCVzBf1xg0NykotMW9fskqI5HmCaPJcg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276837-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6FFD03C6141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
ohei Enju
> Sent: 21 February 2026 00:10
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; Alice Michael <alice.michael@intel.c=
om>; Greenwalt, Paul <paul.greenwalt@intel.com>; Fijalkowski, Maciej <macie=
j.fijalkowski@intel.com>; kohei.enju@gmail.com; Kohei Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH v1 iwl-net] ice: fix potential NULL poi=
nter deref in error path of ice_set_ringparam()
>
> ice_set_ringparam nullifies tstamp_ring of temporary tx_rings, without cl=
earing ICE_TX_RING_FLAGS_TXTIME bit.
> When ICE_TX_RING_FLAGS_TXTIME is set and the subsequent
> ice_setup_tx_ring() call fails, a NULL pointer dereference could happen i=
n the unwinding sequence:
>
> ice_clean_tx_ring()
> -> ice_is_txtime_cfg() =3D=3D true (ICE_TX_RING_FLAGS_TXTIME is set)
> -> ice_free_tx_tstamp_ring()
>  -> ice_free_tstamp_ring()
>    -> tstamp_ring->desc (NULL deref)
>
> Clear ICE_TX_RING_FLAGS_TXTIME bit to avoid the potential issue.
>
> Note that this potential issue is found by manual code review.
> Compile test only since unfortunately I don't have E830 devices.
>
> Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support=
")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
> 1 file changed, 1 insertion(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

