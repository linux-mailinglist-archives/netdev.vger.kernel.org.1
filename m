Return-Path: <netdev+bounces-285901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLV4Jr8D/mlYmAAAu9opvQ
	(envelope-from <netdev+bounces-285901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:39:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A784F8DF5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4DB530407F7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732693FCB1E;
	Fri,  8 May 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXqvVtvq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3040B6E1
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254458; cv=fail; b=MMTAygn0/SIhWJWWTpjeI+l1Zs2Igbn0DabJDBRyNjLFLlqfK66aZJ5uQVJth5EUvS3V4bBrA3tCrAUApWPY5ym4NRZ7/A9FPDGUC53QzIbYY9lb9OWBM/5N2LThbKO9h9++pCE9a0XaaPyKX16+Cq/Y+/pSqiErH0YSOSgxvH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254458; c=relaxed/simple;
	bh=rBqvOEnGwrtyMmLlymNijWb4r92Blcq+Z1k5iv+Fbac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tKxDc0tdipwOZ1+FdarRD++XI+pcyGU+R4cLP52Ic0gafgVtdA+bfsxv930/vH5OhjjOt4/ewyS4Wh2w9OQa3PPhlLHHuN5UkqvaDkTSxkTh8jQCJO2/CTfH9xfpnbq62Br8Ey9OHPW6ltAXcyjMuM4CNcyv6xaPH1gaFbkdo6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXqvVtvq; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778254457; x=1809790457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBqvOEnGwrtyMmLlymNijWb4r92Blcq+Z1k5iv+Fbac=;
  b=IXqvVtvqWOJp78SJbbWblsw8nZaVTb/p7fcEjvFlW2Oy0wgCBydKQ9yF
   iV0mmdkQTI04MdCUO26mJ75jgmjabbB0RSX2aQWgPm5XPisXpT7Tz4/Dh
   jJCiHLvJDTCI1Ba6mmSiVzYT7LLy0ErtwJTEDpIxNoMeNAGs+OEuqIfct
   Z3IEW7PV9uBxck27Wwp7eo8sQazsXv2ztP5otFT4CBfdQqCBDOa+qlV0u
   c8flRR37KB0QPshHGLZCqJhhvrh+nt7Cnl+oLX07m4Q5oQ618eLAFWpMf
   ZDYw9UQn4AcTyt0FdnqwUQAMBArCxFoBBMW+Drey/LScVXPSnlP1Rk1HM
   A==;
X-CSE-ConnectionGUID: 01FLJHjVQEmIcBsDcIVwGA==
X-CSE-MsgGUID: HWElbmaxSCGwvPglmQBqBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="81790974"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81790974"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:34:16 -0700
X-CSE-ConnectionGUID: YY5MNjjkQRSViGiPAGdzTA==
X-CSE-MsgGUID: 3YRK9pJhSfCuQGSnmVVdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260527676"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 08:33:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:33:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 08:33:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 08:33:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H97Vo9Iy2ugb1p991YMmYr4N+sQDgKdYTswowitErNSEJ8tV7MfXir1+Adjlj4/ShVeGTMsEPfcGw7HxZwP/19D7k3xnqkTE3GNVdsLm1tDZToWh4gS9zNdEgMrhv2rvkLR48NilpjSZs8GutaR/FUaNrZihaNjyBEgiDZ6WjD5qfxJbKDxZSMjQ+6gn2Ho2bV86DuDdTRbMgPcQrSmg0q7akp0jtZUWiTmhtU5twkGCMjmXBMncSPI2VvDHgLyLpxlusNdoG/XUtIrX1gur7TNdQ7ZhQtC+TMlJaZABYkgFEihWOEMcVTnx5Riyss2kWwzNqavnOG/Ht+HNKmJ8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTimNudfgpfUZzUCPiGpwISX/amu4XgmpAiCXjgOf44=;
 b=Oo4c8cnGt7HrfhpWWVghAhqc1cj4TCfjzMC9ssaNDnXDDWZDRtWMzomSTh3QUWuf1arH6njjkmO3w36wvlQT87sGey2dK0CywzdZesNcMpB+mSo0rKfZ4vXvwUfyGhdw4nCRWElh54F1/PHO5v6tg+hwA3pQerLSTLgGOjwYIbbm2M4K3DwDtan0gTPYggSn1R0B0b0GAro4K8j6FzdI4Mxif15JKsqfrrovqj9YUJwiXkMTMHTuDMjGuzX89usKmTmDeZzB72kvd3u8JHxZCxUx9/MiMdxfGY8RpYjURzQMM/7p4acBF1LqT6K2uVDnV1Yen+nulaWfqdaPZRFfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 15:33:39 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:33:39 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/10] ice: add PORT_AUI and
 PORT_NONE ethtool port type reporting
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/10] ice: add PORT_AUI and
 PORT_NONE ethtool port type reporting
Thread-Index: AQHcyL6jsWno3wyzSECIFrdvarOkXrYEbn5g
Date: Fri, 8 May 2026 15:33:39 +0000
Message-ID: <LV1PR11MB87900A75CD2B5ADFF2003C96903D2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-4-aleksandr.loktionov@intel.com>
In-Reply-To: <20260410074921.1254213-4-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA1PR11MB6781:EE_
x-ms-office365-filtering-correlation-id: 4a9d1ed7-fcc5-452b-796f-08dead172dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: zdQFKGx1917zDnLGBHpe6FffdL60c6Zt7ZKRXvtdWlu4DauY74vrh5ndis39/Xv89uNBwCysUKN/H0AMMdqXw/11VKc9YDwR0HK1lZZV6EkVB+JTtKy1nAYNdSmrlraOtedQ5JpJ0M9gAAvw8SHJbYUf6A7Di+uePehiT5lOBfSPDyvvZNZDNfTi48IOqQQbKSRPlZjpICiYOYRXs+cJTKlLkN33Zs8vVwuB3WTrmH5IalDe0d4uAwVunx7CuFYe6yvFZuocR5dX9SEQt/AtRQRJ64zaRWno9NXsrRWjruHXNUXmd0e34F4VbuEJeieU/nNnloJHi+tzDUrLF2q6YjPnmK1uK2kPWapYOX3zUJI4TIBge/Ro0zNR2Ahdr8rh1itulaO+Wf6UQ6LOFlcOlyKckLcpxIDx56MVtwAe1xwbysR65Z3FGSWJ5BiMBb56T+dUysrmFv2xUX4KoYsh14OL5lZRQYBnOeGDb1LA6yvIQRmLwp6zmYUC1YNb7oNNyxah1SQDCvhLqd28AAF/WjQZ5L1tH2vLNevLA1+FuhFfekziojEmvGUOpZ5xgoijMondQOzKvW+USyPaKCkQF2UWA0ojCRz2HkdtloAh3+0MgBBBcF6jygSoycZLgiG6uRAGDP77rDtoURYc1dNAiQ54dmgJyN+w4SP1exTTkBXhtQotmAdoSBAkyJzMDVPRsWs8M9KoYQDdYbrCSDYaZ6TLA56r3L2Xl9w1NeI8J7Hr2zACjf0y9SJoF+oI/E4D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xVwckEYxPhRhgtJ43WiMqUigWG2KVSV+WmowJEtXcHKJrDE1GZPC9aQ2bIYj?=
 =?us-ascii?Q?Q6upFMtmdOlHUeYx9kZKIQfa7cHSew2AuYqvltmaGLXaItIrTfXcsOV15v7t?=
 =?us-ascii?Q?GUotqb7fPSNaD8/hWA1y1eeqKymxsSAc7WrACUH1t8Bfp1IHv677sP6hD3av?=
 =?us-ascii?Q?24pzazr2xgzG36YPdRatre1EDNTqNCF7qfU1NXhNgRjnsw+HENLtjtLUrvW1?=
 =?us-ascii?Q?f8fH0u3yy4nOc5eluFFvt1/vGtYfBAk1QIVOJCm/eEy6U1HmVnHWkzomd3KV?=
 =?us-ascii?Q?eU75ETmPhUNFpDNYDFmKUus0meHwh2rku5+8XUG5kNFLUhFmtdh0+JHVXHXP?=
 =?us-ascii?Q?NEVqWxOFMw2jl5A9hTBTl19iyLEp/mlaby6jrrVPHog38XFC0068NfHk185H?=
 =?us-ascii?Q?83kmguoHfq8xMBJRo3Oe3JRCkhWNmm8i6Xo9Zx2EN9nqr9td/Mzcpcpqo1/i?=
 =?us-ascii?Q?trZkhrks23m0ovfJD1mgOMGYthTy3G2u83MuGYHNGTOCZTsBVT9bts3RSqaQ?=
 =?us-ascii?Q?B/0cwmnbjxyTNZv2L9v5Epy655o4ZdUGrGxAMzbi1NUSiQSQPUwAxniDB8lw?=
 =?us-ascii?Q?SsKe3fRFQWHSjDLG75E3GMzME+qE+k8qXXtJn0HS2OC8FSY0IafdbkT/179x?=
 =?us-ascii?Q?cY/gE8tIk1PIYmOM11H5QrlHrjB008ojMse5zqcWjVI9GWJjWv2hA5hFJMah?=
 =?us-ascii?Q?89DI1P/aN76AxjfS/bKmCOhD5JG55mLqUnj/uPw1QaLGV9nj8zoPu4wSOQKb?=
 =?us-ascii?Q?JEUBqPHvGE1fAzFRJfAjTrFlSSdKmAk5D/R9T5Qx/mQXbDiM2loDKMc2X+X5?=
 =?us-ascii?Q?SfLdEK/sMLC2+LrIbrBn43Jz9Mrhvnx//ppNRzqMMbqg1mS6RguiCezBrona?=
 =?us-ascii?Q?dR2cNFYOXlPM3qA9dyGEjZjiqQcUJZKNy+LPKPub1/fu5BHuRMusS3ufc+dY?=
 =?us-ascii?Q?2sfnAOEAyUMA3FWF/t0fQEDQsM6ApXK6g8Zlemc7S5e/3joeSz11kNog1E9F?=
 =?us-ascii?Q?Q3z45BytE8Jtydyw8OmshVzxBQ3+qgpW3+t/DNmFAEGYOfLcfKvL2OmoUrZH?=
 =?us-ascii?Q?jPalzHN+ZoUadnVGFRR4qEPK46YTAUPRZY/txRXQh2A+Y843PAiBlJKI6SuN?=
 =?us-ascii?Q?spImG5m+Ct74i8+KmbO3Em2Gv4wcZbmQ/TwuZgVi4ERLOVDUFgudWb/EJ46N?=
 =?us-ascii?Q?RjpTa6EJBdviX1VLVaNpFPBF9TrH1ki7iV2H8+quu9X7rHAZjF0/sxBVX73J?=
 =?us-ascii?Q?v+lEbB6y/+Sml8Qw6Y+Mo7IzRK2XWAZ1Js/IjpangE4CM6CyqOQWP4b5KeWK?=
 =?us-ascii?Q?f224jbKir+ad3NoTqBwvOhpmVSgpT97pV2nQXr7J5r/zgTmUtYy2gPGIcfyM?=
 =?us-ascii?Q?4RdRjoeR338EykRL0jmG/k3hiO9np9VQ6Gl12OO67c9K7UbTmK7J/JhDg/Qq?=
 =?us-ascii?Q?1mTg48dtqBJ6jfdZ+uiqUp+cUwgqJjJJCvCtIcBChQwqxn643ntog068b1xv?=
 =?us-ascii?Q?e76B1YP01eebwXfeuLNWsRWJUA2NJGbQncgFI4CLY4p3Pzd5RxQa9JSTuRUD?=
 =?us-ascii?Q?KqEpkcK7ALaVPgfqAzpPfNGLkOSoWrin4zXBp5SEkQ5cucZerLRkOwehZDeS?=
 =?us-ascii?Q?7ThBZ4Vs9y8vbTVvqLDoiylP7X9WFIvcAO4n/ax+mli8+H/R4FRr+KtHGRas?=
 =?us-ascii?Q?ZxlgcwmvPd/PjWkXxoKJAyPqS0T5O88x5Zuvsd4k6MSv/vzUkxGrZZSRRSF8?=
 =?us-ascii?Q?HSET4pcHWg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gd5fSXa0uJ7NBHld1tIgg38l6yPikKxH19Vs88v1UQkajMmUEd5Je4Vzragc7+yC+XAVkeTVdEC98ftuSvxgxV0kPQSwSYIMdEXKe8dBfTMjjiscZ1hfp2BBudd910gtPgsPrKSqv7v0/SenRA2S6q0wA/x43ZicAvIAKi7FJ/eL0xqc6OZa7rackLdxPHaxmQCpyfYkaSSyOKiTdy92sQxZGnZBmnMic0XAhhxPV6IaM1UyMunm0cKRCXiiCCllA5Dmq8xML2i3RKqGQ32EQmwQ9lwUDbaNB2EG4myjkOqHTbFmfHi4pl+/llwD7xofQnRcmm1bti83csmK096ZMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9d1ed7-fcc5-452b-796f-08dead172dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 15:33:39.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NRnOdm9Gy3guGOaB9D0iPT/KdqRg5LRSvh/0n1DXUoZ5UF/NK40k550uETK19OcDe3vaLE+Vp4WBRYrRoTdLHgYHASRlup3lqQ/cT5vezGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A3A784F8DF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285901-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Friday, April 10, 2026 12:49 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Greenwalt, Paul <paul.greenwalt@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/10] ice: add PORT_AUI and PO=
RT_NONE ethtool port type reporting
>=20
> Now that ICE_MEDIA_AUI and ICE_MEDIA_NONE enum values exist,
> ice_get_link_ksettings() reports PORT_OTHER for both of them because the =
switch falls through to the former default handler.
>=20
> Replace the catch-all default with an explicit ICE_MEDIA_UNKNOWN case for=
 PORT_OTHER, and add proper ICE_MEDIA_AUI -> PORT_AUI and ICE_MEDIA_NONE ->=
 PORT_NONE mappings.  The switch now=20
> covers every enum ice_media_type value.
>=20
> Suggested-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 +++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

