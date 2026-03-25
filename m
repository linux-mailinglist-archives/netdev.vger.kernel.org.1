Return-Path: <netdev+bounces-271445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDcSNAeTw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6C9320E64
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE18304B4CE
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B238AC98;
	Wed, 25 Mar 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei8NxYf/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A038C2BE
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424806; cv=fail; b=GNHuGvKkUvdUt+xId4uKnc/Oj24cR0FJSjWdHc2q9QcHIfwiE0f8y2bX/XDJbgNlRVLcuTd4s/KEaWIISLDM1R+0JacziRrF1XxX/1rpiqXenCeZDpXtIIZS1zHdCCeTiun9o16zFQzZAnxz0a7duyk9VPyKmmhvEyzh+Tgml04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424806; c=relaxed/simple;
	bh=JRtVlqrpt2OCbTGlME+kW3daAgHhRqWFQwJ8sO42VIU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlhlY3Aqdsmt3vo0fVaK10aC5UR1J9G+1IwbHGGFkKenHPsTEc/BDiW+rgqQ8nOrJEHl+QXnfZi1fSwIUVD5S6mrI9YliAjrAeGPi6pxxCudIbPS448DkUkzCsJfiCV9DfWjxYBiAsYvteFsuH9mK799TsQlYp1r+7SgKU3hzEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei8NxYf/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774424802; x=1805960802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JRtVlqrpt2OCbTGlME+kW3daAgHhRqWFQwJ8sO42VIU=;
  b=Ei8NxYf/NHL/fo16fzvvB/2F+nL1226TDa40TyypxKkI3d33jzNsKhWR
   FSFwVtCuycWuKbvrwHX8Jc9D9kvpW8SMyBINkf26khiXFTbLs12IMJIKZ
   rrM/6z8UKMV6rq60mfkTHnQUEEDb9gG5PD66vSJAMMJurYfYRwOwpTQ3S
   xqZkXMEOfAJzXK0mga0+joofptSo2hjQ3VX2YUKqjv8/2i6GHvlq27ai9
   Ep/h9mMTb5Bxt492PskkmnwpvBjJ8k5yg5UV3gfF3JvGWSPvs55vkXwlH
   vZmx3d0O9eCzkl5lnytWiZJp6XsoH+wnfvlROLTBL8KaBBubuRSX7MPDH
   w==;
X-CSE-ConnectionGUID: Yt7NalgaQBi1dPqUjNsJJA==
X-CSE-MsgGUID: cCDtrU1fQaC2lh2LbSf/jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="92837048"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="92837048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:46:32 -0700
X-CSE-ConnectionGUID: K/mLK1euTpayJ1TcgPt3mw==
X-CSE-MsgGUID: ISnwdHZ+ScmJFiXyDneDoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="221273018"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:46:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 00:46:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 00:46:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 00:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiJBPW2KzmtcqSaZIaOGx52Wi/8/J13+nHCiUWcHg7LTRAN8/hJ0he3DPXbqB/bNrNOPghFTWTBuot39tajnlTHgKEZz7A5IPcauKJkjiGW/52ZX2iUz7f4woRFqFk/9F6M/HdCps1rLpQrAhyvLtvYgBZRGoMJpIwbiSdF1sglB99362IsoCj89xbkTkRba1SI/ITOW9psModShiL6JPFgerSgleibRduDTaY0npxmZ/knPk3dwNs4xSaD1BtqjUW7rKaWzIRsyooyX63mPbKOJBFH6bXTaLMDmj/EmfA2yqAMFalTPuxsaOd+JjVPfHs3X2AhiMoGmGCe5fel2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoLVsdlTHFpXkwSjtQgOem9JtgKg707LHD9jcr9zN3I=;
 b=MG1ziuWdm+z2eMkX7uZ6whxjEt6YcwMkRgSuZCSCFtduG2gajcWI95YPPLA3ZgtHxNHaMo5CkcRLUROKrhgGPorYymdg/10K+4i/zcF/u0wtSxDokDjgQ15MbAbLt29w5dwY3QgtVTq2rMDmlgH3xFe3AbhvkspcKJjEsX+Aw3rasLiEkLWZfoqyBdg+w4zCSBjgWi/EUT4EU9tDO3wUw3+0bzHg8efko6zjUp9H4RlFabxvRPLcoA7YtzmiCfoPasF9aeXTwaUm3aWfTXzjrIeiHs+b5kPzxMy22xY+ehVEwrDfFzQIYZak14Pr3acd6Y7hkd2aoug2l/HsLv73eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 07:46:28 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 07:46:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "Schmidt, Michal"
	<mschmidt@redhat.com>
Subject: RE: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Thread-Topic: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv() into
 devlink_priv()
Thread-Index: AQHcvCEaCWUEh9ebtUqidtbjkX0KX7W+3djg
Date: Wed, 25 Mar 2026 07:46:28 +0000
Message-ID: <IA3PR11MB8986E7BC738215D7C5069556E549A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260325063143.261806-2-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: 123c0140-4b49-4337-f2fa-08de8a429f82
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: q4fw4i6EsLqHvMtJWO8NfnNrEqniyDjTTEl0WWMUn1yXy05mIDvx5ybzJwg+JCdopScljGPneYsuuIO0gYV3Y3nBAGtQJIBODVGlR1OFLYw9TwX1wFm4HxrV5NJubwuNheoKm3fLP0EHQOKJBw51DEIUkl1WfaOo9yUFat2R/XVA3sNozTQeU8zY8Zfzbp4RVV4XSlb55yjtywLc0MnKSYdf8sPkWIJCZZqkZpcBP0hd+dbyjZRGQ0yz25Jv5jCzyj0xjskrNa3bCbnsW5x8rqd348Tqoo7B2Z+CtD1PL1tOUDqxnZKw3x01D3QnJH5YpBryTgU7PWFcNPFNBL10eQ78dVC0rN5OoHQydmzkStwOtckjkRRQwRPDX4uSihtY8xKt5cxWAhuqGgLRb2pzRxT29CFkH0c9kK9jHH0PqY6SzIBSxqiyHEojwtvRWEFmfpKOGcn37OJ1zMeD/8IkzF+nevCYAvZrwfSi2lR+0BJL/UZURT6xsggYVSMMzrRs/kWCronoZOQzKBw0ey9l9Mps1l0Jx4VR/QxpqvYbuZjkjyE2QmyTZ7qStbdcILLGnYNe0EMZYpcBCR6NsfBlRQkW/8dH29R/eKa7jn8ZUjPJM+e3vFBt8uImvemENItojf19Ck/WlGsOQ5wUFRDYKx/c9kEpLTZnoREXrRQKv7+JgyfzKxzr5kKIrB0R/aVN51Tlk0tTmXDFbYmoo/QAmGwYOg6zOCe/WxbXMkVwPI9PzpJvR9VMf81p21gCFFBIvF2t08kvVdeNuDbfKV7Fb9EiBPrdUceZOOWM8KERGmzDrW5IUL/sljdgDWbOWuiA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGd4EBZbmxTO6N2LqfaSdllnj5h1/UsG/udH3ybiwgOOc/M5Pj+vxIlHp9wL?=
 =?us-ascii?Q?+EgOMi2Zzeao6veZjCBiCOCB00UMXaU7eklfMNmCNHFGaZMXMDaYExHWFEoq?=
 =?us-ascii?Q?L8okOHmEnUkKKnVe5QTdXpPW7Dh+7UiYfgABm+iQiFeDgFKndq26hJRHRP/a?=
 =?us-ascii?Q?pUPKJo7f0S6lIAdwld+yTKdHilElXWIp0mzt3b8p1ZeunLVxYuE1JIYgNOTe?=
 =?us-ascii?Q?Px3g+E69Yr3wAdbGZgBB0dGeaU3HQ/e2x54i7sH8xnU0iffjq0Bl3/ayMZgw?=
 =?us-ascii?Q?05sFEcAwfC0hv4CIuIFQZzjaG+llvFitPBeKJY8byLeWHG+rsEdVSmU7KFyR?=
 =?us-ascii?Q?gN0wp+6Xobq63zz40DN7xR7t0xCYWf+UYUkgR+QdbYX6xi0v3xthR2k4jeSE?=
 =?us-ascii?Q?wElk/ycnTq6CA3fFuPSQ5Ceu1h7J0r7lq1DzLiuSqgS+SK0fcQnA8I02bTYL?=
 =?us-ascii?Q?/VVbHCowRx9C1JkrE6foyLZyGVuVgyLdcbfQbTfVvKVlaoo5V8pjBhyHhVai?=
 =?us-ascii?Q?mr/M2MloqPtKIgwEMqXi9GlTAHwv0sjJa2JqB8DFH1ViG14Sowc4TpYiNaSh?=
 =?us-ascii?Q?rroPebCni+AGjIzhD+5IjSzse03hFzTT/n+/EqM1sJdeP1ftf9XmPtz6Zh0U?=
 =?us-ascii?Q?7wTCwjqlAP0XbdCZrJirpv36ojlxN1+Qj+TfSNDNsf5kNDH0rGOHAs3K9yTM?=
 =?us-ascii?Q?3mIbbinE/e0q9F9eMvE7hF0T54r4VUOU6Zw8oB5wx4KB7m5g8BOtQAMByXn8?=
 =?us-ascii?Q?leANKgEW8b3EDQ1sTm/qCmke4lwnDk/6DauzoDgDtkeH+wGoC0SLTU5Y3Qld?=
 =?us-ascii?Q?s5pjqkYl/w+AsCKlBVaznd+EID2orYeFnAEgjihgkfRuM26FHqZiVZaloD3i?=
 =?us-ascii?Q?/hX9Py/htugPFyrucfLI3ery7JA6orPNghFPGnoCXgB0tO3wMwF8s3qzffmq?=
 =?us-ascii?Q?HSbirWQe6hqU32p5TdJeBHqH5DnEpTwDUFzITq5emPNHHVyj7UmOTEX7LJhb?=
 =?us-ascii?Q?qoXPgLWnLzmpskT1Quxg0UOPndq6mP1hKAQeGgqyolIT+n7i+EDi7mXW5Oxk?=
 =?us-ascii?Q?ykx+A1dsM6vjrjs0ER/hebfvBccqIOOVmUBtgEPt00brg/e0zRusnMQ5grs9?=
 =?us-ascii?Q?fcpWa1r7HzmKB27Z5XWNXymvtewa8JQXuqXtG9McWXmhqZjtbxSNCDGPKLlz?=
 =?us-ascii?Q?OeIVVJo1Pm89oMjlwQzo2Teg//q3mDvxOYKHDAhZwpZgg9f8y7yMUfT5HnzG?=
 =?us-ascii?Q?0hhC9pnTbuM4peMcu6i6bpoduEd8+pGMBFpPxtcpJqzC8c78oO+aTXy+SF4H?=
 =?us-ascii?Q?JR1DzSVXFwKanYI6Wn9X+hB3aGC2/Hk6yaNVMVa8HC2GJHB/ZbOAPLitb8ba?=
 =?us-ascii?Q?PJwJn2drlvkqpubiawQFIN2Kd6nKb3I3HE/lmKrZujdHvS3Tduwe4z7cmdUD?=
 =?us-ascii?Q?jfm5ynq0hAgUWPVoHq11brlF62lq+1iW9UYnTkakLsj0aKqNvTN7KYyBtG62?=
 =?us-ascii?Q?ooHn+KP5agZr6QNZee0YSbfpEDaTP4WNWaqBYxxoaL70HDDgwiMgSX00ZbBb?=
 =?us-ascii?Q?GvgBsrExmgry9jGewjgIHmNcn2hVmgHn3nJRZMGeuAirANyj3lNv5eXG3RW1?=
 =?us-ascii?Q?OkC+0RmRnmXNaecnU34A2I9QcFZMl2f0Z65WaL1jg/LpohpzR74T2MVjwmST?=
 =?us-ascii?Q?Aj83C8F0pWe7yDjdfQrM8UuVoDLDDhxlfyr6hYuV9a3gbFkjMsAGjWWtvQm4?=
 =?us-ascii?Q?u1o2kYoKHK02uDpbpXgvhGU67eD6Yuo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ofua6vxMEdpuisWPR3D88wHcyo7vy50CyVgdnlQyEfkmMhgZTj94bUhm4Fw68LuPJX6wQfJStO1alq/Bxy6oyyCIpnWEwmKq9fxxPFxyCBxuU0NcillXdZPUwgfOPuqnBYUyLLFwnl6pSp2VvZyimrQ8szilirRB4qLC52dlGnjYZJmwmZTFltMtLDvq/XLWblGSTtdxDxW+cUvfKb86wLqi0AMBaj7XPpVn1t7EZsobXPa7vB4ThKwtwqQ9lAEyktP0kaGS+J0nAPeXGrHnwdksjxuA3naQVdLZkO1EFvstBhhn6fdpPtO5ZpG3Qc1ww8J1ATanZfprPKGWCZSvxw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c0140-4b49-4337-f2fa-08de8a429f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 07:46:28.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iSB4qMzjIxIJ+XQcE7mXD54N/nMByG+cpw2O6SENNvV/DUcDCSAYA4RzqTLNEw3GQmwm+yi7WXtrHtZqCFx3XWJ7HFv2Q1AgFj/v+Jq2ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271445-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,resnulli.us:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,davemloft.net:email,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3C6C9320E64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Wednesday, March 25, 2026 7:27 AM
> To: Jiri Pirko <jiri@resnulli.us>; netdev@vger.kernel.org; Jakub
> Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan@lists.osuosl.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; edumazet@google.com;
> horms@kernel.org; pabeni@redhat.com; davem@davemloft.net; Schmidt,
> Michal <mschmidt@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net-next 1/2] devlink: unify devlink_shd_get_priv()
> into devlink_priv()
>=20
> Unify access API to shared devlink priv data with normal devlink.
>=20
> Thanks to Jiri Pirko, we now have ability to create shared devlink
> instances [1]. Introduction series have added usage of those for mlx,
> but without priv data attached to the shared devlink.
>=20
> Current API makes it possible to access shared devlink instance's priv
> data:
>=20
> 	void *devlink_shd_get_priv(struct devlink *devlink);
>=20
> but it is easy to forget (especially during rebase from "before shared
> devlinks" era) and call:
>=20
> 	void *devlink_priv(struct devlink *devlink);
>=20
> which even has the same signature, so it's hard to catch the error.
>=20
> New proposed API unifies both calls into one, without any increase in
> the observed struct size. (Alternative could be to store additional
> pointer, set during devlink_alloc).
>=20
> Unexport the less convenient API call.
>=20
> [1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-
> devlink-instance-for-pfs-on-same-chip'")
> [1] https://lore.kernel.org/all/20260312100407.551173-1-
> jiri@resnulli.us
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v1:
> https://lore.kernel.org/netdev/20260323132136.13191-1-
> przemyslaw.kitszel@intel.com
>=20
> v2:
> - fix typos (Alex, Jiri)
> - fix infinite recurrence (Alex)
> - add __devlink_priv(), which is more general than v1's
> devlink_to_shd()
>   (Jiri)
> ---
>  net/devlink/devl_internal.h |  7 +++++++
>  net/devlink/core.c          | 10 +++++++++-
>  net/devlink/sh_dev.c        |  8 ++++----
>  3 files changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
> index 7dfb7cdd2d23..0a57318d92f8 100644
> --- a/net/devlink/devl_internal.h
> +++ b/net/devlink/devl_internal.h
> @@ -58,6 +58,7 @@ struct devlink {
>  	struct mutex lock;
>  	struct lock_class_key lock_key;
>  	u8 reload_failed:1;
> +	u8 is_shd:1;
>  	refcount_t refcount;
>  	struct rcu_work rwork;
>  	struct devlink_rel *rel;
> @@ -72,6 +73,12 @@ struct devlink *__devlink_alloc(const struct
> devlink_ops *ops, size_t priv_size,
>  				struct net *net, struct device *dev,
>  				const struct device_driver *dev_driver);
>=20
> +/* Get priv allocated for struct devlink */ void
> *__devlink_priv(struct
> +devlink *devlink);
> +
> +/* Get private data from shared devlink instance */ void
> +*devlink_shd_get_priv(struct devlink *devlink);
> +
>  #define devl_warn(devlink, format, args...)				\
>  	do {								\
>  		if ((devlink)->dev)					\
> diff --git a/net/devlink/core.c b/net/devlink/core.c index
> eeb6a71f5f56..a242be203fe8 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -230,10 +230,18 @@ int devlink_rel_devlink_handle_put(struct
> sk_buff *msg, struct devlink *devlink,
>  	return err;
>  }
>=20
> -void *devlink_priv(struct devlink *devlink)
> +void *__devlink_priv(struct devlink *devlink)
>  {
>  	return &devlink->priv;
>  }
> +
> +void *devlink_priv(struct devlink *devlink) {
> +	if (devlink->is_shd)
> +		return devlink_shd_get_priv(devlink);
> +
> +	return __devlink_priv(devlink);
> +}
>  EXPORT_SYMBOL_GPL(devlink_priv);
>=20
>  struct devlink *priv_to_devlink(void *priv) diff --git
I'm worried about priv_to_devlink(), if someone passes the result of devlin=
k_priv(shared_dl) as priv,
container_of computes garbage - because the pointer came from shd->priv, NO=
T from &devlink->priv.


...


>=20
>  	return shd->priv;
>  }
> -EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
> --
> 2.51.1


