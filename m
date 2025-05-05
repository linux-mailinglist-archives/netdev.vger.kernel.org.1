Return-Path: <netdev+bounces-187669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B4AA8B47
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 05:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED1A1891499
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 03:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77D26AC3;
	Mon,  5 May 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjd8ZtSB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D9224D7
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746415445; cv=fail; b=tpFZdbkMecRVz3gpOqNLcdword2c3Ta0Z5tKUXMs5OlTaT7KqQTa3tMlgAWMyLL/99RVt2p4Swu4wK9y5Rbww+RaHm5aEOFg8cZJSlLOeiUJDi9a6uZbw5p45CCjxNkEpVmHUgbGInCDoeqTyUJaoQm3kNOGUrXe2i+AMMSWtyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746415445; c=relaxed/simple;
	bh=1Z3sYkBc4TNOpvdqcl09E8XnXmwaGX2av84TeN/zD/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sftk9aqVnE6qgyfYW5RxnyBJpMGkpE/3XTr9iQaJYu1Mywv5leDbaSjhMyXjWidhjuU6hDcBpDj5Ykm+aU96M8rAQ82w+JwbbUoGjw9LxrKmJQOKeICtrC2Jd+8dh5OHV6jvuFlzOLANPhHl8FZ87rp5QkQAzr0Ts2g0iW2VIKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjd8ZtSB; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746415443; x=1777951443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1Z3sYkBc4TNOpvdqcl09E8XnXmwaGX2av84TeN/zD/U=;
  b=mjd8ZtSB97J1GjkegTKmGpxLbx1K/a3fCODBTftQd1two7vQa6CMlEDy
   CE1h33zytrmITXddpwo7N485lYRO29aMlihmOP8uWqjUvw9cdOiYtmr4T
   2P9hSrpPMha2DVDawq3KRiVsg+KHTjAzg6tWRBtaZyHULwNJUXIn8JPJv
   f/97iIxdmfKIAydd6S7ehSNasBTTudDif7NF0dJIFF6QAf0daSa2tVqG2
   8lUWrHsMGermbXvEtXCTuE5eFQFlAD8TJ2xy/f6q69KI7x0M9BBzeXMlU
   TYY+S5ua5g1/1KzP5ZG2fWYu/G+H959AePgBc0x1zKS3mT/ZvWVZJJ/wO
   A==;
X-CSE-ConnectionGUID: KTiBDqMNR/+XWm42KEuaWA==
X-CSE-MsgGUID: mHwXGWxUTGi5f7xK0u7M7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47896889"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47896889"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 20:24:03 -0700
X-CSE-ConnectionGUID: /K8fwN3NToCKtFm2dDMP1Q==
X-CSE-MsgGUID: ikFD9RNNQhewqgxA+IEE+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135029092"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 20:24:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 4 May 2025 20:24:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 4 May 2025 20:24:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 4 May 2025 20:24:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L88aiklzD+K1fFxTds3GkknDdm4jzFVv8u4lIfMmILFGGNwg30eGSojJoyIiROy/l43f7F+pbe9SxVJWtgvt6kpH8ssmBsZqChBQpn/MwP6GudwFFzac8If7Vcj/HutwE6P5tqyCHv1WcPmJyuE3EJdmxgsJZdJYidDjARN10V9zB4RxrUbv9Atq0vXMmW0syOx+uSkVl0bDcO4ZVxdVTGBW0RQryAkS8CS9esanwKBYpwJOCM/z+bCCyAyCCsSPfapCSinMw1aJQIBePg6wlVhfOI+4JlKtdI5QUNBANV9skGwpoOxKnENzJ1x+vmM/0EMiHgUbgs4elIcgSL1ZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xktPtV+GUFSoLkeM6KAksXLUPOykypbmi0LvhV7vkE=;
 b=x8Z22ecFEq2MbtbQ4K6GxCiVBloLiYVUPGNAQXn9uFrbF8ijnWRq3IKd/P0VoiycVdkwHog61k48VRuL5zE780eYNFC7OH79cyB7CkXRGnZxvHzkxDuvIhmxWAqV2vNqBHF9mhK2mHRh28iOxGexAQL2VWHX+cblT63TNyLQvTVLOCuPN4QPH6HDJfpu8z5420caxP6DS1IUXswQJciY6Q2RGtTYGx1eS8JpOoY4+RSZWWVfUTbN2+j+zs1C+CcZ9IZpyvU2gNv4o1/8zQFyWui6Kf+pkqlLNaZrcByYLYLSkCEA9i1nojAFZ1bHvWg1/8gIavMzWy54hwwdcJz6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 03:24:00 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 03:24:00 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: add
 link_down_events statistic
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: add
 link_down_events statistic
Thread-Index: AQHbrT2DOva4HzC+5ESZtlaWY7Nb3LPDfsyw
Date: Mon, 5 May 2025 03:23:59 +0000
Message-ID: <IA1PR11MB6241E6C33A6F3A4E661AD2E08B8E2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250414130007.366132-5-martyna.szapar-mudlaw@linux.intel.com>
In-Reply-To: <20250414130007.366132-5-martyna.szapar-mudlaw@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|MW3PR11MB4747:EE_
x-ms-office365-filtering-correlation-id: 64559906-6e20-4a71-be62-08dd8b844711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KkwtYGyYG8aMNWQNQ6tAHhDYfkCTnYuyniLggxRu0N+xC1HRkvQb9NYIlV3m?=
 =?us-ascii?Q?HxJ7/vaPIB0T+gBsNu4C+LJTvTW4QmdXkdKn+E7F3dIDnJjXIagLaeqHrqVg?=
 =?us-ascii?Q?a9IKDcBgFgkkctEuQkZM70/WRFq3wu6OKZ3HDpAZTkTWLvLaC4QvRzMIRoci?=
 =?us-ascii?Q?j0PFAIYqr8GdJByI4MGpheAA7188DgcH/hqBJx+cLNDmnZq+Zv0KGZQ6Y1ax?=
 =?us-ascii?Q?/7ctngEE/mvddtNRybDgT0rJjAbjG7REmoi9QqY9YQhkYYhfBuKsDtSUJb41?=
 =?us-ascii?Q?d0TKjymdQvFJlU9uzRcANApLmKaXZ3wMmbCr0+3GtjFZ/XlOYGo9L5DiPxYk?=
 =?us-ascii?Q?sbPK88HJQpEQ7S4Jbagd0XqxrffORklTTatEtdSHBpBWIUQLHQSSp4JoAzrI?=
 =?us-ascii?Q?RTSRiySu4a/k/OOAH/CtOt+7LtWwSHMjjed5I26QgC3DtiVYM/3DUfKsegYz?=
 =?us-ascii?Q?tk682lhSWAqo3X2jhS/P0ECYGKDpmUNJpJpBLsNTBbOJ9P74yO/fgWy56nKK?=
 =?us-ascii?Q?XFtA6THPUvdaP/tdLI9lmT2T32eaEN4GtKeZlKY17ouEcEqehZTBWjMc6h5R?=
 =?us-ascii?Q?mf36SqbliWiT5VMrRFGEzvn9pNIBQ9vJdxMlGnISL0tqW2Rv2kVLVzg6eMSa?=
 =?us-ascii?Q?5zAZhh5tzb5m52Of3x0eErY/mSX1MRAwFDzPKS/Vkb1AVCOMU5zaXA5l27EB?=
 =?us-ascii?Q?CAOqXgVySWIdfzt5vxOpOBt5KiZ7GkeY1q9J0wQWhui8+FwN05SUPeh+Iq0I?=
 =?us-ascii?Q?Nui082u9tSBKuzipYvy/ydmkYow6xbajSnDAA4Cyq7jAPqQPEV3k8acWBMCo?=
 =?us-ascii?Q?4zDJfcuyvrDlKVZ3RGLVpTPFIGDgmESAfD1UymAiQ9U7G04FPljZ9JBjEWLL?=
 =?us-ascii?Q?EpO/r4Qei6It0ckzBRN7Bgc/DxnC00c3mC+lRJ28+c1htvNWEv75YUBC5ynW?=
 =?us-ascii?Q?Qee+VcHw+v5frU10HAPDG+C+wOJ5zVZ8AUd8vbkVNUBKZRomrDFa7Z7D0mAI?=
 =?us-ascii?Q?iI3GdICqxN91fkTP6XaZSApopc0kF6gUiodmRCN9iLbzpBDOW967Z6bVAcsZ?=
 =?us-ascii?Q?GaxbCSzAtEkFAcqWN9U+mqeaqNye93jdkqu+VsU0LBIWJofRF/Wl+D/w/JPg?=
 =?us-ascii?Q?MUIGIBaFhF+cfANwTCBSx31cQAN5Oe0g3/Ghq3HPiFFJsoVU4wu5qFDpYhr0?=
 =?us-ascii?Q?RcNrs7KXERtGXBVGCQ8RHwgO1SLF73XngZTxNFS7HsuYsTctRIPWhVaS3BXG?=
 =?us-ascii?Q?VTp2PGPVm9/QScDOdXq+tMVsoBKet7B5OJGFvdXFhpbT92wg4wS4xrEkCgbj?=
 =?us-ascii?Q?iIqLsw18jXC0aqXck6gUcolxJNhib42jzcF7MbxR+9IYVnmW3L6DADEbIr4W?=
 =?us-ascii?Q?gohbjOLNLEZRRYbDQkvrUPy9De5cektdjRReghQqUWZbVuM7vXZX08I1kgLR?=
 =?us-ascii?Q?4jf8TdEt1oNIrMP+fQmHVx1XcwdMvTCaEwyyn3gqb7DlI5k0Wj/glw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kv/Qhmqav0wlGx9hCKue6sgn7vUGa3vl/ugf8lyPYJAnlBYZPfIczqoCiPmz?=
 =?us-ascii?Q?52SM8Hk3TL1WT2obI1VUNkJJPUXs99pwYnfUImao+oXInsxW3Y7h9hbF17dH?=
 =?us-ascii?Q?hPQ4KToBBx8zDTCW6q5Ubnf2ywGaLHfXe3sIrmuVGuEDdO3ZmXqBBZjtS1p6?=
 =?us-ascii?Q?OGU312kmP06MHww8BdRguFNEBGozIypZtc50QWkpz1m/eV7Uxa+c1VMmzWn6?=
 =?us-ascii?Q?DKWnK5awg0WikjbvDVlyevpYHXxLiNUBYV6Ido5IHRIPB2JEonmHzJ71njee?=
 =?us-ascii?Q?09Rep2dS9GEilS9NMdTEIgG08wzlxlbpjXO6IKttJz5USukrg9m0TsjE0BWb?=
 =?us-ascii?Q?CTllVWv/Rj3yWfaxlos5/an6uc4slJWavbiAXwCJf1JEzz4lCX+QO6lhsjak?=
 =?us-ascii?Q?C8HcccDdh4PkZhKNCJWSoVu4G5BcJ0xXh8k7jdbuNyio8D9dk3zbrCxydwvP?=
 =?us-ascii?Q?+/OEp580VbdzENL5Q1LBhQSnwrD3c6fd9ABk6kg58ix/oUgMx+GVqruCwOob?=
 =?us-ascii?Q?qnBxVsU+oN1STAMkD1rZyiwXhxT8M1RMtYIY8Kd+EqTC9ymKbgbPXB+yt74y?=
 =?us-ascii?Q?AsMg/rc/shvx3L0q6iqt2egJYuexiVdQMS7W+zXn6rJzSqy2hs7r0Iy+6++z?=
 =?us-ascii?Q?6KCPOkJ1TLWof6BssQl+XHkw53T7dHyk9HoPSVrbFE7kDK0r8ahOKs5bOrLJ?=
 =?us-ascii?Q?cj1QXh4HKswwCvKfMeF699TRq4zeTkdEFaNRBIKp6pmHVf7SuZbCxiKUQyuU?=
 =?us-ascii?Q?rlDr8oeD4iToMX/m6fNCZF1dUB/Ro9zCmxG0JPWtBg3pUoAEpd9iDHpGAdqP?=
 =?us-ascii?Q?tHaKZ/FVDEUSW8FwIW2bThspXi7n4OLaetHvEULO0ewESUfLydhsQ/g4gsjW?=
 =?us-ascii?Q?VYekD0No7Ytl/3BIU5bdbRuoNxt8zK4849eQvH/H83UQsZ02PBk3KztD1SNU?=
 =?us-ascii?Q?5dmXaqvbLgwldXTm9nKgRStpIgA9JnWemrOzs4XNCfB3D7JZQ9H0jWXNEztE?=
 =?us-ascii?Q?80b4LkMisdz3afmRB8wM9rCzRnKJSNwK/r5YiMdhd7gw62PDBJsfi+dti6M4?=
 =?us-ascii?Q?4b8uncogO3pQfY6kYxKHuOaZXeDiO3rqumpwxSFG7GWiwIbIOak9xNnTooLY?=
 =?us-ascii?Q?0QZUIm7vyG4eJwZwsgjQfXFqvCN9mGa5eIxL2z1o/jXmyFVbxjzvYCz1wyPI?=
 =?us-ascii?Q?d3982I/eQbvRAks3oHFdIY3vSVugeZlVeyqug2b3Qv86MZdnl8wHmZyT6RP+?=
 =?us-ascii?Q?whRJQyta7o0n43GFEERsDbCvcxC4VHADXXVzIXLo0gVCK6fGLs+JDywiiEjo?=
 =?us-ascii?Q?Nh156dWkgcIwvTPy1Gfp30+X0rRJ+hkgCFakqVn1XDAR7V+x3UvP9YSVwcH9?=
 =?us-ascii?Q?xrglULsOuBw685hf1jFKvMoX7W2dV8AtLP9ABSp9HQI3lJEFggdj7+8d2w4j?=
 =?us-ascii?Q?nFsPNV1M+cb3n3f8e8MdjDZ2aBG8LS8jj3v52x/qel4Q8iSjoYZ2SzbawLmg?=
 =?us-ascii?Q?c+9fsgdXirkRBHmxdM1DS529nyBEeivW7uPfkOiJ3DSObVGdgKmYfe8R1OqK?=
 =?us-ascii?Q?49oEypeUdKs9XPpmSZ5O+gTjLTlY1OmYeXIjZDJn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64559906-6e20-4a71-be62-08dd8b844711
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 03:24:00.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up+75oGJd2JPahzXFUYZO4lVRnxpdnu6R8D2F0wG902uF6Q4NT1hzoe2qIFQ4LRz1Ir+Ostae8OTYGyFK2njrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
artyna Szapar-Mudlaw
> Sent: 14 April 2025 18:30
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@=
linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/2] ice: add link_down_eve=
nts statistic
>
> Introduce a link_down_events counter to the ice driver, incremented each =
time the link transitions from up to down.
> This counter can help diagnose issues related to link stability, such as =
port flapping or unexpected link drops.
>
> The value is exposed via ethtool's get_link_ext_stats() interface.
>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.c=
om>
> ---
> drivers/net/ethernet/intel/ice/ice.h         |  1 +
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++++++++
> drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
> 3 files changed, 14 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

