Return-Path: <netdev+bounces-272498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMrVMz1fxmm+JAUAu9opvQ
	(envelope-from <netdev+bounces-272498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:43:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 497C9342C29
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2187A30CE809
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8B3DFC87;
	Fri, 27 Mar 2026 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWVh0dtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCB3DEAE8;
	Fri, 27 Mar 2026 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774607861; cv=fail; b=r71RqO9rkELjbVQdAb9nTLxtQRf0lA2NR2VcgUYwrYS7l0mnEYiJGN4Vcaaa+pfwwglzRTzxpK28xFn48Sn5+6vvZDaxFXlCnCSq8VK9lzwuKhrYcEwMcZytm//8/oSIAd4bzEcgV6IrbABDiV0JuXZyulqSzICUnElqaXbfmRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774607861; c=relaxed/simple;
	bh=cJuzKl0+ar/wseQsimOk/vi4H8JNYz9OUVu+RmlNoMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L9Q6BqrNIrtUvYNKgpsnDDqkNpDhN2UIy8vHba7NCE+OV7g9SAtuB/JxwtoXHk/qyIxk7HAzAlrqZS9SpjilCrGhSnRL4FlzOMFx4ZTJDqi2jYDKEK0CTxK2M5In9GBCmUvSpVdhCSe7qqWy7pL6Wm9wj6Z1pnq7iTGGtf+Ldn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWVh0dtQ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774607855; x=1806143855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cJuzKl0+ar/wseQsimOk/vi4H8JNYz9OUVu+RmlNoMA=;
  b=RWVh0dtQI9/Ex5JuZusw6KMLzdzsoFsG8uyKIv+smEefm6ZvNAkKTvBa
   J+ijqdB2gOJFpbQ3vzWN83elJxr40RTDV41xcMHlIviQ5c/wlTviMdpq1
   KI2Ti+ohVz5Udd6cMvzRD0X0It3eUz9kd+LBQMvjXQ2XEeiwDLVPsNnht
   wUMUfkg6HJKwNWU0Ek48sNwIckPMi81STcCg96+cVR9T3QsbOuvqcacBy
   5Eh/M3ejBmtkQAZ77HC86gfgpWbJvx1H0EqcCWovT99AAUoPEGwExAcnZ
   Son2qaMNDzGPoQ/avwACc2C/nFRPuk7mX2vjYW1nFEmZz0JBaS5bC9Dje
   Q==;
X-CSE-ConnectionGUID: 7k9mMqjWQhakIkzAkZenIw==
X-CSE-MsgGUID: V8YdL9U2Q5yNags9gda5Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="93260097"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="93260097"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:37:32 -0700
X-CSE-ConnectionGUID: 7aAlPfJQT2iOhqa5UlgxWQ==
X-CSE-MsgGUID: hF+h7UHEQnGiOic8oo2tkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="263220149"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:37:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 03:37:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 03:37:29 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 03:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khN2jXhSHmXvIyIFEUZeUoAbeZIa8JyezgBVrsBvUosG3G1VkjpLsLmTFQiGcnFNPISoHNozVJl0wrc8qb1pteoZv2qBXhUeh3v1RAxJRZopwHs9LOdGsIfEnTpFDzWm2v6nAml8wMT1DW/+Ony+UVZcY1i4Bd6rBoAa1owgOp8DOc7GTW/Brwb1QuqJclpfl+rF6j5o2reR3+A7nrWV/Sr7UtzfYpr8AW7nlRtWQ59BL6BlsBkil52PKhXv7wHXQWvng7RFRFJbAbBpNivp+fv3t09dYH8ze0fpTECTFQlyIYXSkr2PtJK4o+K25FQAXFGQlYPcDMSVfCPo1UPn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAjTLOLgJOw7s+GLhKvyawS6rx4EGrpQ+QcVxzU6YHw=;
 b=CKdtKl+qsJE7xSe0PZPi3OCBktHIh4L0CmDfGmzrUjBJhHcBgSu/AQc6TPXsb9mEwIpvUlHnjEpVBf9ymEVLiemFEENm6ysF9Xv//0K3YXPKZpo0bkbUN0Mj2k+2W3L3OkltjWHzqiprmRiyr0yg6mZXDa1uk7tL3vfyKH63SNy8W2bVOGHT+A0A3VzkuApQ3URq0TyPdHbfwfWHd0ZalP9PALq+23aulr8Y0trdPYFGXSFR6EHp5t8Dsh6kpZ0romdYBMsyNloLX6HJp760DMBGYq4eVEGEUZOK9KYPNhNp41ufu/Y1fRP0uxLLHlLOHKmzfcrTh9BCC9RrV8U/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by PH3PPFCE69B97EC.namprd11.prod.outlook.com (2603:10b6:518:1::d4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 10:37:24 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9745.012; Fri, 27 Mar 2026
 10:37:24 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Yury Norov
	<ynorov@nvidia.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David
 S. Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Thomas_Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Brost,
 Matthew" <matthew.brost@intel.com>, Paolo Abeni <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Yury Norov
	<yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Simon Horman <horms@kernel.org>, David Laight
	<david.laight.linux@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 3/4] ice: use bitmap_empty() in
 ice_vf_has_no_qs_ena
Thread-Topic: [Intel-wired-lan] [PATCH v2 3/4] ice: use bitmap_empty() in
 ice_vf_has_no_qs_ena
Thread-Index: AQHcqeGn7rJVzSnEMEiMvYocEfzYx7Wa1JKAgCeC+hA=
Date: Fri, 27 Mar 2026 10:37:24 +0000
Message-ID: <IA3PR11MB89858BFD62FDC8DAF0B548658F57A@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260302011159.61778-1-ynorov@nvidia.com>
 <20260302011159.61778-4-ynorov@nvidia.com>
 <IA3PR11MB8986F3692384856A06EACA7DE57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986F3692384856A06EACA7DE57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|PH3PPFCE69B97EC:EE_
x-ms-office365-filtering-correlation-id: 44bf339b-f3b9-4cee-4327-08de8becd58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: PoovDwqz8RgfF7zPkGysteea0/Wu9rc3bIS0aWAkmNoqMM84kVTL4DzF4x5ab74Dnt/A19XfwOHDa/v1nV1ihvUpKznIKIpsLKXRa61zDpMSECKIMe+mT+CQkoFBfeWIcQW4SdFydKeqGIdHrLzT8PxR19mpob6pCPjGGA8yGyEsilsSdUfcHpf3Jr/BgkxnIJjiK36yotA8jXR062Ja2oTmO4wr8TTIKO5l3nprCQYsvHSlzb/2/QNCw0l3w/flOy4MJB3nqXEgED0905OGaPpdNVNMoKi9alyKoBqmE9vWVryK9eEm8CRLE3RVnBitO80aS2+rQUNe2i8ynjJENVOjolpm+wbaQLmwY39qaTFx78l5h10iUQrO7Ct13DRXS5EvzRehOvzfqOkzZrgmlAfRyfwsJ1vYyUY7Aw57ttAwp7fYxtnq0CfRsopCfuSJF2iD8r9rAEJAJOBttOw5d0ASTJ6/dgMcMalQIyOZl6O9ac3+flSuwtQ5Or/EsfK+9f/+xs6UVCxqsdkgl9My4yDfNOT+vVuNFU4PVreEgQUHnrF0G1QYh346zzvwjdbSItQNS4C3rdZOcDsBi0kFOiKU9kOfTmcv482Qg//IPQ9ADOg0qtqQ9Nv5R3Hq4dJHi1V4j3TZ7ZpTDqNCYtpnPCFR5RTC1DrIDy5ABmC9DEwIAhgY/czYiykxEhk/KoctUCrI8MSQA/PUm+lNuM29f+SFgFv4Gl0TZMk3zl+PkLp3R69IE5tcHK47oB+d+gXEtNfIvBvR2a6LtGUo9j30CECFrFK31jmDI+2KdNeN3iVACHVUiVYghgk5ghndr5fH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e5K7U0rOQGysBDs54qLlpMl8PKyR2Cufp8rAjUywtBuiF0WhlwkyLKLW/P?=
 =?iso-8859-1?Q?Rn+vYSkXGWZP3ztVRW4tETKM1iOfUeaJw0WSTWCDhob37c2PE3ay2kUGuC?=
 =?iso-8859-1?Q?FSuxyZzabp3nBE98LQMHSijkX6h4/BSVVf0Az/JTNZvF6UBZf/k+Zu7Bzo?=
 =?iso-8859-1?Q?SIdI9W2miCYJCDtJ9KSlU4dltT1YbZDwsIYa/BloBeL3mofepVNny/sBdy?=
 =?iso-8859-1?Q?KHjNjvY7ylY4qRjWv0YnwSRwKt+pSab9LWRCi1pDDtlylRGhYBCT1gF0ZU?=
 =?iso-8859-1?Q?S5V9FTi2T/JwNG+qMqtkYpyiETYqCCMgj+uFQCTUlbtXqRlh21xDKbxj89?=
 =?iso-8859-1?Q?34w2t4eE/A63r2uLg+2o7k4z2Evsrb6ZqgWmPbnOD9FPuPU4OjaOI87LXm?=
 =?iso-8859-1?Q?1MnXfeBQWU3UhfnUrcc7wJoLAf257cbYKmhIqi6pLzpgBZO1RlKE8nDCm2?=
 =?iso-8859-1?Q?5pOAD5gWfBeQy7CelIxKnV/7iGitHl0C0emdtKihGit774Ogg6kH3zAbRS?=
 =?iso-8859-1?Q?oVv7+v1W6RPszkg+Tm1ao8PX8Bk9+Gzy0E3Q7zsCxYrJokqfR/nHMQf6dW?=
 =?iso-8859-1?Q?aWaZTE/yt61tNahqiAA5GoLXwPmY2ymyxpePsWxHwLmcJTjYmdJvmcSSXY?=
 =?iso-8859-1?Q?M5muXmv3BWlzOMZ8SeCaD5koUNsw8V6AJTDPbbGL0HWnGtKZuHZ3b/qPTX?=
 =?iso-8859-1?Q?Gr1J/loHsYHDLpo64UgBwnDC+cn4iD34DA0Pf1OqWT0DVUUDnn3NJ5i0ll?=
 =?iso-8859-1?Q?MRg51ReuXUzFoqS9MlxKHDIVGafJ6PWRMOqqH3Czys0B/nlxSM5wTOjHkH?=
 =?iso-8859-1?Q?6MahEN0U3O++n2kFHqJulfo4SZKvurQLYb20eUfTGag7CnGVsZce7bxv3C?=
 =?iso-8859-1?Q?mrMhOoW/Bd5vl1sF+Ser7mDhGp5mOFjNe40GjNa9zeTejUU3QCehXGRbnp?=
 =?iso-8859-1?Q?4Qy4Vl8pcrRtgvMpEqNch0YODTLcmhH9Yn6X+qf+jVRO4Jo6vrwgN6RYb5?=
 =?iso-8859-1?Q?nI0MgqK3WcioChO50PK6g5l1al5p06UlKbVqBEaKriKC+JySqfrbr4BM4h?=
 =?iso-8859-1?Q?gbeTqCqButQnQkgzUVnISxXRkjtSVniuTLs6WguUApdlxyNVLl/1eSLik+?=
 =?iso-8859-1?Q?lBT6knF/nnzZw1qI+nqHhdDI+QacrUXxzuCZ9LvEhqFFzbizkLONEK5tPp?=
 =?iso-8859-1?Q?fXQiF5n5N1BMlxSH+axZSvHOzraIvGmOmQGHH7HLyGquijn7OcymgcN3hl?=
 =?iso-8859-1?Q?9GF/htAg5hdVvOBpk4VcRoFverbqkm14ukAzNRjfDzZvPXFMtoHX1r9VQV?=
 =?iso-8859-1?Q?wXoDQk+LfoiQG1bnHc9sFlB7NDmpxY0YVmaO4DELjPpF93uZtrHgKUS/Gx?=
 =?iso-8859-1?Q?IwKpwNtbQL9QrYJtfO+Xvdvi/QrCXHORTnXc9N7d9L8W+7m2V5RxIYqhqP?=
 =?iso-8859-1?Q?DE2xpKYJLMrQs2/w/umwmJt4y6una2BJsaK6EIVnvDgAcNbwf31oglEE6n?=
 =?iso-8859-1?Q?yVL3KXx8RpRbiTyTe7fThE9x1bdAPossikZ6eH9CakoEWMiz+/x2E4BJlX?=
 =?iso-8859-1?Q?a6FPIK9jU/QD3nsVfq/yvQO6vxAn88ngs8GiRvR02Rs/YGsGYx9QG+ubC7?=
 =?iso-8859-1?Q?NE6BzwEIzRDw8MuqN7s92fTLzD1brOeq/cDDb3hNDgBr8q+khUdcXsUEWG?=
 =?iso-8859-1?Q?Abvbzezzc+pqWsn+iBHMnoQ4kWCUILmGUup0TtZdfthvAEyBGhAvZXA3Wm?=
 =?iso-8859-1?Q?7upNHSnfCX7q6j/CVl7mGUjEhMmsqDGHGE6Mbs3d3Vq82Oxg/X0HgJZ7Bh?=
 =?iso-8859-1?Q?FB9UR+xMoQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vMSVc6ItyDJZLZJQ1qCZwRrw4T72tMdtKvW7Rq+bYIjvFjlrAY+0itGaIqUAHPbbRNKZ2Oo+4RsTYum3/vLJLkdrHNaGaY5/SFm7KbtEm/YCUjSrn3eQwCqoSKaHB+e1vLCxB4QWKSCoiBHQtlDxIgvsbCex76ogc4RvEZC0d6n4efpSYJZxI8+hqeXIzzzpJe/mRYKCL+iVOTbfHHzngDtaEqnDB8OvnP6Ta5g268Zyblqzgm0iK2zq4CdIKnTVyZheRUJFvdk4IIeQR8srCAwZA3sGFyioDF+DaGgE5ui7x5A8pX39gtKSBTYa1oqbyRRbXtwYypJS8vfo0YjplA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bf339b-f3b9-4cee-4327-08de8becd58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 10:37:24.4322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEb5yRsNleaGke42Zg7NzKWdr8JPLyycKzlGzZf+DLA3cVqrXFvMTOrLb7+arf/QGV31IHYhPCA0UhPg7y76whiD+SuqKnoRBFL0BoXuByI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCE69B97EC
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
	TAGGED_FROM(0.00)[bounces-272498-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,nvidia.com,davemloft.net,linux.intel.com,lunn.ch,linux-foundation.org,gmail.com,google.com,kernel.org,redhat.com,ffwll.ch,rasmusvillemoes.dk,lists.freedesktop.org,vger.kernel.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 497C9342C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Monday, March 2, 2026 8:14 AM
> To: Yury Norov <ynorov@nvidia.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; Andrew Morton <akpm@linux-foundation.org>;
> David Airlie <airlied@gmail.com>; Eric Dumazet <edumazet@google.com>; Jak=
ub
> Kicinski <kuba@kernel.org>; Brost, Matthew <matthew.brost@intel.com>; Pao=
lo
> Abeni <pabeni@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; S=
imona
> Vetter <simona@ffwll.ch>; Yury Norov <yury.norov@gmail.com>; Rasmus
> Villemoes <linux@rasmusvillemoes.dk>; dri-devel@lists.freedesktop.org; in=
tel-
> xe@lists.freedesktop.org; linux-kernel@vger.kernel.org; netdev@vger.kerne=
l.org;
> intel-wired-lan@lists.osuosl.org
> Cc: Simon Horman <horms@kernel.org>; David Laight
> <david.laight.linux@gmail.com>
> Subject: Re: [Intel-wired-lan] [PATCH v2 3/4] ice: use bitmap_empty() in
> ice_vf_has_no_qs_ena
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Yury Norov via Intel-wired-lan
> > Sent: Monday, March 2, 2026 2:12 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
> > <davem@davemloft.net>; Thomas Hellstr=F6m
> > <thomas.hellstrom@linux.intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; Andrew Morton <akpm@linux-foundation.org>;
> > David Airlie <airlied@gmail.com>; Eric Dumazet <edumazet@google.com>;
> > Jakub Kicinski <kuba@kernel.org>; Brost, Matthew
> > <matthew.brost@intel.com>; Paolo Abeni <pabeni@redhat.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Vivi, Rodrigo
> > <rodrigo.vivi@intel.com>; Simona Vetter <simona@ffwll.ch>; Yury Norov
> > <yury.norov@gmail.com>; Rasmus Villemoes <linux@rasmusvillemoes.dk>;
> > dri-devel@lists.freedesktop.org; intel-xe@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org; netdev@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org
> > Cc: Yury Norov <ynorov@nvidia.com>; Simon Horman <horms@kernel.org>;
> > David Laight <david.laight.linux@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH v2 3/4] ice: use bitmap_empty() in
> > ice_vf_has_no_qs_ena
> >
> > bitmap_empty() is more verbose and efficient, as it stops traversing
> > {r,t}xq_ena as soon as the 1st set bit found.
> >
> > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > index c8bc952f05cd..772f6b07340d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > @@ -1210,8 +1210,8 @@ bool ice_is_vf_trusted(struct ice_vf *vf)
> >   */
> >  bool ice_vf_has_no_qs_ena(struct ice_vf *vf)  {
> > -	return (!bitmap_weight(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
> > -		!bitmap_weight(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF));
> > +	return bitmap_empty(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF) &&
> > +		bitmap_empty(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
> >  }
> >
> >  /**
> > --
> > 2.43.0
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


