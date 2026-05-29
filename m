Return-Path: <netdev+bounces-293181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG71EH7SGWpCzQgAu9opvQ
	(envelope-from <netdev+bounces-293181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:53:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A8606DF6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E484E3281172
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976CE390CAE;
	Fri, 29 May 2026 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHGMQh6U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11153909BF
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076590; cv=fail; b=W3eMRL4xjXi6H1Jh7OTTKWk3h5l2qpRHn52UTrWXu1HsTvOFNEUKvI4iRAsYvkUVoj9SbMsqfXK79xWth8DkocfarP8gIzm8ifa3Mh8t9anKGcojfIqjO0zDBgHW/w+MEg9jOhKGdujHz/EahIjkipnYndSvZ+x38TbWrT+wgyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076590; c=relaxed/simple;
	bh=yP4BFsRNqJ4QPVjxoA7Yr91lANCGSBHFmEZWjHgUTwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E1LO2k/+Y/cIi3u6dcKTIzxA/E0tfnCdJY1PeYKndj3W+Lg6o+VfS5Y4R1C+v9xydvmFy83dJnZ6T4sazIHLMYUXqCbyevrM6AD3XL4i3v/8AHELZ7Fgr5qtf0TaSoCTQBGfmZQlGRm/hrG2y7TwAjjCEEYm3UiXH6c5s8JyWBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHGMQh6U; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076586; x=1811612586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yP4BFsRNqJ4QPVjxoA7Yr91lANCGSBHFmEZWjHgUTwY=;
  b=VHGMQh6U6zNErnq+dhRjUBjYb2etp+Z4krT5w5BleLdD3OQgUPhME7ma
   8KK+ji81r6HZpEVuntXWeTtfrxmUweVC4rj2yZaMHqUeK4V8UD9Imj2E8
   7GTPs1bxsNi6wrB5RiWdTQWMu0QC44k6vPuYo16Xckgucge8wAVjgboED
   ZRF0PlmD09WuIeaagmgALFBEsVgXYOSVD6bBi64votX2JQnmDXv5RRsy7
   RXvbiggqpCV5AKVGzuKon6nmFxgKI+yj475nbSGtE99fK6A5md/O708yM
   knqT1dzdGzNsuvlUSmxidaZ7xAAzemhUbSTZpZkAeqI7Ec3YI3xxzTSA6
   A==;
X-CSE-ConnectionGUID: m6GVH461R3GO2X/Rn65KiA==
X-CSE-MsgGUID: A8uJfUbeQIOYJXZRlCeGiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="106384283"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106384283"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:43:06 -0700
X-CSE-ConnectionGUID: SXB8TaxTRMqCCkDdrKdFow==
X-CSE-MsgGUID: 6GhzXvbKRyCkDm5pr3x3Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="247198459"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:43:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:43:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 10:43:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgqkW4+f+Cw+21jSk6SqP1fsjc4846YFesx2I6XxVeh2uK1bHSpLFEn/xNP/TRFvlnSI6yv/yorR+yJd78G5h1L3s62cUlN07EJPXOHeveT6qYmO+N1lbAuVQ1SJP7CrwA5G6u/FcvKR6UKso3SEpPvfO4lABlHVJ+KIfJFKGw9vEcJuB8SQvYPpKMK8VbAKgblfKp+Sr479bYa99Dja5mCvgJP41tWLZQwmXO0E1abMcxrxpvZaZ5yLLQ/QOeowOhWP01MOMfIzk0q2u/aZCnXm7qfi8MSjGIHB2vDrFuwf1eDv2lCMy6Ak4QJqdNuaiTmYqqxAmzuxIVwkJCwIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE5bxb67y5Lc9og80VTnuJG+rQmtsAjXi8VNFkGVh+k=;
 b=KGnBHDYrcPxVlrdhrqkuyfxMJQJbGgw7zQ/pZoet9WIFuMewTGEl4IcErnKm4a1UXrD9A0DbvigCvQIQV4GIwEQOmgCUy0XN5T8In7yMx4eOroSs+l4z4jcjtMLjchU6mTco6SLVgwNhMmCxZDghgXHycW5d8G0+YL6MkCBUDt1cG1blIZ/QrYc2Lj7XiUw7cwq3or1U+pI/K7MgPbXjzIxqygZll/k7koWKmPKs+gXEWXJ5H+hOT4lDh4TinhUQ1bA38W4Q0sH6e+vab/P1KGq3pUomD8LdVhx6P0wQCbfFc+xUc4KclAdvOyoGrJkAcZcydyjIRYXrre8RE9OTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA1PR11MB8173.namprd11.prod.outlook.com (2603:10b6:208:44e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 17:42:59 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:42:59 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Cao, Chinh T"
	<chinh.t.cao@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 04/10] ice: create flow
 profile
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 04/10] ice: create flow
 profile
Thread-Index: AQHc6SB+grudlOkHgE65/FrPVrtWarYlUppQ
Date: Fri, 29 May 2026 17:42:59 +0000
Message-ID: <LV1PR11MB8790363557772DC1C9C888BC90162@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
 <20260521115000.4637-5-marcin.szycik@linux.intel.com>
In-Reply-To: <20260521115000.4637-5-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA1PR11MB8173:EE_
x-ms-office365-filtering-correlation-id: b8a670ac-8669-4d8e-7c5b-08debda9b980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: 840A2i9yFHlZo6vS0dnV/cyIactxMSsZJf31UdM3illvwdbPGV9VDJBktOTfWuxzQSoCbn86LMTkp4zlovjJFxV+t8LGLvaOGUPxFC95bBkz8lSqqIU67P2R3f5kGYeYgYAm7sPEBTBAndvjh5D3rphg/ufb/zTz6LsEC5QVe9oFlVz0nmfDM360/Xz5I+GFgtM9fMv5jxy/e2iZfenqGUotZNZyiYRF9ZbLccVKhiMd+JMcWLiCsJ1lkHbz5dbkYFq+U8HzNON4r1M1VvRiRm/FryDEYhux+IkFodG1lnATp1nY50EjC3qLHgzVi1ykq5jHwsebMuWTTdINQLg4otNJpg86J2VPr7GGvL/HRQ3Qw2Vk00LmjOpezT4wyBb8llAxyGdLYUuUK5w0D5Ua3GG9LEI4zSoMvKCWP29rAL5/z3gzoIEjP7p9g3bk+46/jZ1GvUIE9aBSUB5CJ5yoAJgYtl3Dj0Mp2iWR6hpE42SWM/mN83AxrH1eqy+21TKJ1fC5OQqPQ/lqpEJzI40D+x6kz3q4GQ+DWKTamPEYQQOcZkor2YLLdXEP1ZUXswoFQRU4KOPHneBzTetZ1KS4rbTLALQNwJtoK13m7FKWGlCnS9oFfZ32I5uYrlTlO34IPOrZJPPpJ38mqzZcfueXVGKFK/75twc5iokAVu7cIBUI2qOpllYalI8fdejMPhBNvEcNDaPqmP3d1UHN8ZNbr9DWR3xAW0smgjhgO/oryvFqRA5nqWIqEE9gfnIJpVfP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0ncD0Hvbyv203DOvdVp9JKrLWjUhfMZJC0A3Bnav+Po9fG4fZ3qptwoFJ+C?=
 =?us-ascii?Q?pG/hNRUOMpeF3wL0ILTexKLL5nVDxQXihKFGUkQ7dZrDHlY7cxFypeC5qRPw?=
 =?us-ascii?Q?3yto0dCCjXWE4SMkntKXOI3y9qYU4cRngD4D0qzGGIkNbYTRvAMxQwD3A4no?=
 =?us-ascii?Q?rF+QeTCFuFIQnGM1VeEv93lO4+XFk0fRNpkFWSVe2D8fVG2gdt+B9yHqC5yC?=
 =?us-ascii?Q?INQUjbujhQm2CSL5zMsi5zVSUbzfBNY2AvROZGVis/4ihm6oaaRLwuHyrnsA?=
 =?us-ascii?Q?N9DrD/DrZQvFSXk8LkByZKThNLl+2UO85pIeYCEv1CN8jg+fwzyAtVrbdV5Z?=
 =?us-ascii?Q?OYlb2ErbLTrsGKYqZiU1tjTok4qg8jsMBOI67U/B6/fU0k6ljDH3aWeBadsm?=
 =?us-ascii?Q?OEyP7qQM0zpS43TpICbaNPHuMTxbLVB5NQCOb8RiGbknIXY6qO+5JkMuJX4w?=
 =?us-ascii?Q?5KnN/eJystnAOFTtmWguwWVYpEl2oc+MkvIXzXqUB1cg8xNHhpMASZ9g138I?=
 =?us-ascii?Q?I3J6Q9iho3W8RN6XX2MgdwuIAVHkpgh51on9nx58E+1bILjBGmwqJWBzSVfB?=
 =?us-ascii?Q?/YztK3/UTbOn2uh2IBS8xsmBLEpnHCvhRmRSJa0XJaAFVvfMysto9l0QvD66?=
 =?us-ascii?Q?A7Ceb9b8irWCG/8/sP1uIEI+0eRxIuq4onM9WbEXRXEvVydFTEv1yVWIkLhu?=
 =?us-ascii?Q?6nIDmFPOyZqXg1eT3TGKO4NsNlrmbZOsO0z4gXBkEaH75dywmKHAvQHW0CWi?=
 =?us-ascii?Q?nfJKhHM3fD0wUMPyUsJcu0EISIeGV31yoA/EBV5LqV+AZShXfXYYdLDmjZIw?=
 =?us-ascii?Q?E2t53+AdNs4sIcXmXAUjlDOViUU5Cn/kZchPoh8FnfnZ8oo+m5LmA1VT8p70?=
 =?us-ascii?Q?xi8SF+7qcTRRfHtIeOZO0ZAzGhyoaCy/n8TzXWzLXBr0di8tepNPJPv+mLKn?=
 =?us-ascii?Q?y7puLbooS2v2fz/XwJmf5mxVrMFlgg21UClNcBllkSJhXaEoaOruN3244MA+?=
 =?us-ascii?Q?XTeRGLucDm5dxANc/mUi9rutmiDE0qfhj5JgJ9FF5M+BQ0+YSfaZn1402LCk?=
 =?us-ascii?Q?lB5np/E7JyJtQSsgXLqlFiz9iucXGoRy+HgoaKOvCsWr07SVCDItejE8RPoa?=
 =?us-ascii?Q?QnHRNu+8mgL4CUAf0Jcd/MBP5MuEkVfKI2j0jgDvMmwCb62cWBGBSIEWnrwk?=
 =?us-ascii?Q?5q/CpUSwTlbFyS/PAwSKg23dK8tvxmz1AALOaW3HzesG2kC0YNDMa8rJ2llB?=
 =?us-ascii?Q?WvCGJjMfKLwRt0U2YGGCaWf/+VaqGvnGs7q5Vd45Ppz1ITtme2t9PJe5jrfU?=
 =?us-ascii?Q?y+9jnH32zO34G0GjqYapR1sjDH3EeIK/siZN175tHnoYuNA8WU2PLMls0eUK?=
 =?us-ascii?Q?Ax9cPhXOvDlINdgzWefd4bRIrGPWJcF2Bqf/c/ikG/XRfiM3ILpLDtWHcpqd?=
 =?us-ascii?Q?NRTM5nChM74vZ/suBj6+QciAlgMWIMaAyiHqtRX5+rMugUn2jiix6Jvq4a2A?=
 =?us-ascii?Q?at5XijQicPRnhcg+a50hgzUE86skgoM6Zd/aP+4C/QtgSBPiJvxuUqMJwBpN?=
 =?us-ascii?Q?jcwvHsH365yBIbcgqDcLFmktaR/e+tkXdGMGBY7Todl4r7Ps3Oxm+FQOzJ5A?=
 =?us-ascii?Q?Krv7Zri6VUNLES6eSkg7WbmjGU5fRpRCI8+Ol5lZFUhP4O9ckn5EiIvxbDRx?=
 =?us-ascii?Q?as0ZpQFNsWFPcCHjjMF8Zql6Ffgdu5MUE1+4BR8ebgsvAWXHB0+oKBM5Q1EE?=
 =?us-ascii?Q?Ux8owERNNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: izjYWYfhsULcuI9COTOrdjB1pjRIZnheQvewtrTPD5+20IIjCYYNlNx8RtwNHfYB+caXNRFU62FGTQDdB7qMeyAnUq1tjPf+yVRRL5O/+MP2crDA+U4f9QjU/UKhoiGZTQH339la+sGGaDZGSSgGqxfzjm8EcKTswl5pPHXZ86c7lWwCQX+jRD/Gzz7uv9xFvYX11Pc31BuhIfp/YqgPA75kxl0aO7A9Im/UjN5YyMiI+Vqp677vwgXy4pr254ouOHpO6EkyxAXI6SLu+D5WPdpudYey1jaRxilheSfcxZA4dH3CLKCO33EAElGODwwc4iTHerTcbsb1AWzLB/Tkbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a670ac-8669-4d8e-7c5b-08debda9b980
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 17:42:59.2100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy2N9HD5VKyLKYJZRsVXLRMdr6bhLysLYO5a4YQfmJVeEJ6qMrJvw2yFejmVsH34m9i7gGvLGuSD3438jFUqWhirzzxP32iEDxg7xdyHORk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8173
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293181-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: BC6A8606DF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, May 21, 2026 4:50 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Cao, Chinh=20
> T <chinh.t.cao@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>=
; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 04/10] ice: create flow pro=
file
>=20
> From: Real Valiquette <real.valiquette@intel.com>
>=20
> Implement the initial steps for creating an ACL filter to support ntuple =
masks. Create a flow profile based on a given mask rule and program it to t=
he hardware. Though the profile is written to hardware, no=20
> actions are associated with the profile yet.
>=20
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v4:
> * ice_acl_prof_add_ethtool(): add missing line
>   (hw_prof->prof_id =3D prof->id;). Without it, all flow entries are adde=
d
>   to profile 0, which wrongly uses old extraction sequence in case flow
>   type is different. To reproduce, add two filters with different input
>   sets and check if they forward to expected queues, e.g.:
>     ethtool -N $PF1 flow-type tcp4 src-port 1234 m 0x000f action 23
>     ethtool -N $PF1 flow-type udp4 src-port 1234 m 0x000f action 24
> * Adjust to using struct ice_acl_hw_prof instead of struct
>   ice_fd_hw_prof
> * ice_acl_prof_add_ethtool(): remove old_seg helper variable - after
>   above change, accessing old segment is straightforward, so it's not
>   needed
> v3:
> * ice_acl_prof_add_ethtool(): add a writeback to hw profile in error
>   path to prevent leaving a pointer to deallocated object
> * ice_deinit_acl(): exit early if hw->acl_prof is already NULL
> * ice_flow_acl_def_entry_frmt(): copy seg->match to variable instead of
>   reading it as unsigned long pointer in order to avoid potential type
>   mismatch
> v2:
> * Add ice_acl_main.h in order to not awkwardly add prototypes to ice.h.
>   This will also help avoid potential dependency issues for future
>   additions to ice_acl_main.c
> * Rename ice_acl_check_input_set() to a more fiting
>   ice_acl_prof_add_ethtool() as it adds a profile
> * Set hw->acl_prof =3D 0 in ice_acl_prof_add_ethtool() to avoid use after
>   free
> * Add ipv4 and port full mask defines in ice_ethtool_ntuple.c
> * Move hw->acl_prof allocation to ice_init_acl(). Previously, it was
>   being deallocated when hw->acl_prof[fltr_type] allocation failed,
>   possibly with already existing other elements. Extend array lifetime
>   to driver's lifetime
> * Change hw->acl_prof[fltr_type] alloc from devm_ to plain
> * Add hw->acl_prof[fltr_type] and hw->acl_prof deallocation in
>   ice_deinit_acl() - previously were only deallocated on failure
> * Tweak alloc/unroll logic in ice_acl_prof_add_ethtool()
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  drivers/net/ethernet/intel/ice/ice.h          |   6 +
>  drivers/net/ethernet/intel/ice/ice_acl_main.h |   9 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  39 +++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  17 +
>  drivers/net/ethernet/intel/ice/ice_acl_main.c | 228 +++++++++++++
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 299 +++++++++++++-----
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |   6 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 173 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  36 ++-
>  10 files changed, 733 insertions(+), 81 deletions(-)  create mode 100644=
 drivers/net/ethernet/intel/ice/ice_acl_main.h
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_acl_main.c

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

