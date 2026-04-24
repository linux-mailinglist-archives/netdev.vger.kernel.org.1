Return-Path: <netdev+bounces-280975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKhrEA9I62mWKgAAu9opvQ
	(envelope-from <netdev+bounces-280975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:38:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053F45D35E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A893013703
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058A3845AA;
	Fri, 24 Apr 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv5ppao4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA0385515
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027082; cv=fail; b=kkJVqkzMrcFCCuPvpLVNj4e/WnAseidMNIIe5s83+1yhs6jhcCZmNyNwG416/nLOfj9cSkcaVKfxxCBtoIXy8OOiC1Q86hFh3ftfqSxgLX67GfbsKsldaxejMuzD4E5b3Eo/8gNMjNYCkjL3XHp1HvEV+S+4kd1WX2udKf7xSTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027082; c=relaxed/simple;
	bh=viexRPkEMzzAsgxEiY54QT4qmUYtZ08d79C5mi5J9cw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cfzJpVDvDze/e8th9XtNUh1uyx0baGMLLbNe9j8Fxv3SeA4SfHDdsKmvdLOsxkPBRSmSdkIkiZcu9vvkFgbKIAKJsf47RDnrJWVhmf/5IHOd9lk8kQ7rgMYwmsUC8M022Bl8aG3peNI7VzSqZzFZnsv3To1KPFd0/BDJdsCTi5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv5ppao4; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777027081; x=1808563081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=viexRPkEMzzAsgxEiY54QT4qmUYtZ08d79C5mi5J9cw=;
  b=Tv5ppao4qmaLhQtSE1QeDqb2241+azt56Q3jEc/HZQpx9XyZ6dLG6eX2
   80a5GElj3BBOm32JnUiaTthz/zSUN4EFdh8vmACYXsjE98FK5kTdvyohD
   h0u+I6Qtse72X6J6LMfTAIGGs6l3sL0ov2GBHxscKZ1ffoazyM3Yf+6a1
   3TQ72oKCSLqG8ad/x0XT9rMu7QMr+5jl5IqdpWsYmjjjL1WXd1rHB3H1F
   x63Qzv4sdiFZaGdyI3FxPvIO9ba+ih9kbSMpoLDuswMZx+XNxAMLxMOE2
   knOoZ6nd50xn8ZIMjnC8Qox6ch1St2ktTgYPXJpjsnh2O7pwYhfCvZ2Y5
   w==;
X-CSE-ConnectionGUID: uMukGPvYTUStYoYTlQ4oTA==
X-CSE-MsgGUID: eEuhvqVxS5ikw2X1kdHkeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88313977"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88313977"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:38:01 -0700
X-CSE-ConnectionGUID: sDWvKO7TRKSiuwtMZMwyxg==
X-CSE-MsgGUID: OMAtQWBzT4KLUUwPY7KXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="237976089"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 03:38:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 03:38:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 03:38:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 03:37:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDM+wOz8DcANprKGZPAAPKdlW+5rpLtjyI6+iK98V8tFJrp0yNg7dcSdDLSBL29PwqtXhl6tGa1iyvuPaHgTnm8abfyNXBOn5S0jtDvZO1cy38XiDSOFljs614A0hMtFgZNi4ZjS82r/2P1merom8CJycgt7IRItGoW6+BlAJh8CNkoSWskHP7CLma+Pez/AoMQpjmxjqnC4mDroEkAu5aff0mnPIClszXs63RO+ZPWqNmuL79RsmLzBQSWIk3soahNo2FODPZ6OSEJaeXXa222V7yxtFZ4xRsNG/76Lwy/oYxpbPAvJXTOyRRPa3T2NaiBkKGy5c3VSL0+TPmCkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO1sYbcn/msW/Ul7ce3AFMDMBhI6wYUhUo/j2L9C2H0=;
 b=UVI7h592z7VvMMJmJiUE9xzH+MbwFwuR+w0KKAOPm2tJKg88vULkkO4ixzaVqSjeo5jAyC+q0FTlJrJaZ5AxFOeIWfBVcMiAONJdF252WOR+U4CcSnEdbvMyTKGWEpcmTeCLxfkqeL3YIRF36x1nMSZ7dlP7SgqTFuTpROkvJjXXt01lbX5WYe+WG72XJJ0W+xoxKB5CK4khXYB8R2aCYJUOCyo6ZVBHCuM8+gUnEOY/M3imsDqHgpzwFomCiS4Kzmhl5xeAwMtqCE5Z8+qzP0JtQq4c2cnzzcU56TBJgf1LYb73jqwXx7kzoyc8ThjSgH4S+zVxdhmg4KLTr7M3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7611.namprd11.prod.outlook.com (2603:10b6:806:304::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:37:56 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:37:56 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "jesse.brandeburg@intel.com"
	<jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting
 trust
Thread-Topic: [PATCH net v4 4/4] ice: skip unnecessary VF reset when setting
 trust
Thread-Index: AQHc0yHPL3usVtJTakKErPoC2Bf5x7XsoCewgAFk54CAAADToA==
Date: Fri, 24 Apr 2026 10:37:56 +0000
Message-ID: <IA3PR11MB89861630A18B1BE712F14E68E52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <IA3PR11MB89862412A9F682D59474841DE52A2@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260424103233.622318-1-jtornosm@redhat.com>
In-Reply-To: <20260424103233.622318-1-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7611:EE_
x-ms-office365-filtering-correlation-id: eb756e35-0379-4165-d5ed-08dea1ed8c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: vWvzTTc7WlUvHATo91tglhVivkgTierlakRFX5GUtZaU/fBJegKvsbWP+KtoTbdehFTlhhAnrhkFdam75Ej4E9QV1egLZIArvvM+gUF9vZUMU/KoQn9rNReFDOFk8P/THoe2VPYhx+jgxZ03ooBAyapjzJ7jQppiA+LXAatPdGAV3DtMg8jfk3UEJNHKbD9nLGJTSsGe8RYRZw/P4LoKv3eQOkVkon3jGoQmqbI+jr0jznMqKDJStJQySXZH/GUNk581pSXWDtZxw7+3/VzQpvQwmv8ErTbF/r03nXFMl/PG4neXXNc5V+WBbpkevhsdvjjmd4m7EYBjZQRZzk9p8uH3tgeavlAXUF97uVCPkc6GOm7nwbNcw0KyUqx5CJUiUo+co/dOFpBA1jQYP+CYRfpmI3YoX1mDK8v/O1AN+cn4X6HjrOYjmU74lQnkJkTCdwoN8AK7BVhXsthXuXhUSb9/QxaGDpQrCMuMp3zRX8MzM2hh2AhdB6m3dvbQKhNyj4uXQEuydFailORfiXBug3gLsSa1ucColDhANm2+5znDC/pIYOibF1+ZZW5wcqQlvCfSqTKrdDfNIZ11jXvpmBnClBGXQa9JCz5yjoayF7JY3A4W+dTprSHaL7BBWHpOpUXymD0QuMV7bkYryrP2jrOlaSVCaD0D/dOGNbkSvDwHHi1gBU+/PG5LToD1zaS8NdkfRmLkPQlgFTjSCp8UHNjTvwKqL5CLvuK8bhPSV2OgpBSw4cK/XcXY5xwf1i5amH0RZn/JiTMxI/M6d7fKVXSh8m45MZ2Z9G2D82g+xmc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j7ofIKbbnzaP/rHIsPVte0Ou0rLqNMURSzT4PJmDcZxT/nekmcQaavl/YCG6?=
 =?us-ascii?Q?TA68aGIrGAjw0k+R1JE+Os2OyfCEIVIBMKKzqmRa4t2HIz1qwwUvfuQBLW/P?=
 =?us-ascii?Q?xxPw2ra33EEDf1Qp5kN+FqrGY5AIp6zm4pH9XoyKlPEvhIgVlCcNIRClu8QE?=
 =?us-ascii?Q?mt+P9j6+EHKhKxUYFR+HZ1wiCfrjoqXdRQKfuQoRMnE/VzxMJbDfQ0v4iRTn?=
 =?us-ascii?Q?uIP9ZUxJB/qYtlcXMPpB+Wv60qqdUZyj1KZJzD7t81/s22qtFfTV6nqiSU+K?=
 =?us-ascii?Q?5M8tS3tBE9KNThAs+cArJOn5jtZZmCmKdZqlqWRqyGgX8qKLx0nkJn79b0CM?=
 =?us-ascii?Q?LdXBbCCgTayKt9yOBIQdHYfBoo1ksZTSLFruKHpN3LDm5/UWHhzkOJwUWbDR?=
 =?us-ascii?Q?BuIEC8PkR7Rj16dmZa7MUxA4LXHKqq+idtiyRGkPfbTyZZyWYPgWlc68NYEt?=
 =?us-ascii?Q?TcNb4DTPXhyYzYijnR9nM/9sz9Y0vy7eIWv/M3B5m99YWMyaSe63PAUQItHR?=
 =?us-ascii?Q?jEojVlW4re6H6Daif9IfsF8JLboozoVykM3wdEUFHA849uo/NxR0Bh36sToJ?=
 =?us-ascii?Q?F9KQq8BnhLtBF5giNEuDCOq/GzwhNAC5e7uaS8NlndLB2I3P+RT/MeMGFPBY?=
 =?us-ascii?Q?SV0C8ZbuSvyOvCOcv8cZwi0zDLRlNi4UYRmSQ7gyM91NsGljcuk527Im57W5?=
 =?us-ascii?Q?gKWi+8J0LgbmYGIAzF2ClPGdmJ+BFz/WNrXSpSGU4bvwnOm6RGCFsg2n7lR0?=
 =?us-ascii?Q?oDzHhU9fgOlU2epz0sFDBlMkMSvJYPWNf3IH6UYiGsrhllMpnacOz8wn8wqq?=
 =?us-ascii?Q?H2vSKH3ci08k/N0mtR1Q+fVUgtQxfqHQ2n7djCOSD1fS1pgxewoNnJg4eiwT?=
 =?us-ascii?Q?VbPcgpd+lz9idOVTQNHJGr2C2lcqJV9KI9TObDcfZyy6aNzSarHyasatewlD?=
 =?us-ascii?Q?Aca71vHnGehZGY/o9QyS4gF/ntNYj6hBwuVQO6PLxHMIamHvcPEOmO9H5hNW?=
 =?us-ascii?Q?eXrVaG27o6uHoUw08vnDgf95h0ef8frHdPMdOhP4ompx1H66LFGmlv24m3II?=
 =?us-ascii?Q?tG/zipxdjVegrsml68NlrkS6K4N6nBG13cdV0tuwAVStrrBpwkX4ISPSPqtY?=
 =?us-ascii?Q?AbvKbQ7oujYael+jWC8wCo7BdRx8rLzExHSvLbfokmB5hUENbJ3uTkXOnLm1?=
 =?us-ascii?Q?MTXG82RshKf6FqQtxtpaX9p4DxMcg8tJC0fET8+2nzvFmK/ToT8oY6L68anr?=
 =?us-ascii?Q?C5O1L0ShGQwq1Nj/vjnVgTM9gYBlUrOGbjf2lKpQpLAQM9emtQ1t8wz8SsdD?=
 =?us-ascii?Q?EUFMC/mA6xAi/rzBOP13OzSgdUYTZlzvynL8trBTitkf7AIlZBSDh90MmpQY?=
 =?us-ascii?Q?2Ek+zFtOjvyHVA80cetxZWyhNsm0UKydoEo7Z2k0cFhysS3tm8UrNiPFU5zf?=
 =?us-ascii?Q?QhuKWfrRnDr2ydKVWOox++xkn+H5hR7l2CssxQX7V/C8RAR494v5FyW6xmuQ?=
 =?us-ascii?Q?owP6zkMQhtsTeWXrJen8LU4C739DNVhboF55NVgR0wMUftYdziGKeRYWnvQG?=
 =?us-ascii?Q?4wz7be4ydD5/+Yme0c4tDBIIUbp8FDo9B71azRXf6TmL9bugbu2guWkxaGar?=
 =?us-ascii?Q?HsLJQ6i1naIWVGu/00iUoabPf5GZKJpaue/hrz8fQ/7qt1zIcY7LmkEDZ4Ly?=
 =?us-ascii?Q?DScQTXXA1ubfOLfYWW7cXpS7VYnVxC9dbITo2mx1Iw6ZQXFXhmSrAwWczVLg?=
 =?us-ascii?Q?LQ3ygv8qFMMZDLPANE30ERSYCSv9fLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qvcQiX7KSDuR/H583uNpfIWkdCWiN2z/cc19MrtiKa8QRVMD44Uv2dTncn2bQs8WudYUkOb8CUnMPOOgYYIkTBBapAndIShmmmx+qh3vyinILM+huZZxfthCfCCXU4qdjP89tQqrFI7rNmqgwXeTjAGkQ2Gz3M/O8wV7vTGcMwB/c+Wh0ioUtfoXJz4/K0a/a8EFj8VnIqbr+XQ4ut0+XH7Cg3fZPSMnRmfotiGlyOMIwetUpzxMokvC+0CGF5AinU+1YtWrIeg7ZLN852hFAtaZspXNuG8wHrZ0PMi8bvl69iRqhuN/KO1Nkbfm/JkeX4iRdclnuvz9S+HcLPQkRQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb756e35-0379-4165-d5ed-08dea1ed8c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 10:37:56.1531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0T20kNMTqNlR/Q5YcZjDK2yQ4lPYrUgEY+JeSRUbMdKtJH9DOel2bNlVSbJEaHwtsWfR3c84se339seGkWSDOEBibfHEBDTf/n2UKHJTqNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7611
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9053F45D35E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280975-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,osuosl.org:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Sent: Friday, April 24, 2026 12:33 PM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; horms@kernel.org; intel-
> wired-lan@lists.osuosl.org; Keller, Jacob E
> <jacob.e.keller@intel.com>; jesse.brandeburg@intel.com;
> jtornosm@redhat.com; kuba@kernel.org; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: RE: [PATCH net v4 4/4] ice: skip unnecessary VF reset when
> setting trust
>=20
> Hello Aleksandr,
>=20
> > For me it looks like  cc: stable@vger.kernel.org must be added
> I am not sure about that, because the bugs fixed  here (vf->trusted
> ordering and race condition) only trigger when MAC LLDP filters exist,
> which is an uncommon scenario.
> And most users will benefit from the performance improvement that is
> an optimization rather than the bug fixes.
> I mean, I included the commit fixed as a reference but due to
> optimization as the main reason, I didn't dare to request this for
> older versions.
Ok I see your point. As it's optimization, you are right.


>=20
> > You declare ice_vf_clear_all_promisc_modes() returning int, but
> ignore
> > the return value.
> > Looks suspicious isn't it?
> Well, it is used like that when the funciton is called locally (the
> function is not modifiedi, just made public), and really my intention
> was to clean as much as possible (so error checking is not necessary).
> In my opinion it would be enough to warn about the possible problems
> (already done in the existing function).
Can you go extra mile and add error code handling?
Or at least document it in the code why you don't do it?

>=20
> Anyway, if, despite the reasons I have tried to explain, you still
> think the same way, please let me know so I can adjust them (if you
> don't mind, I would wait for more reviews to include them in a next
> version).
>=20
> Thanks
>=20
> Best regards
> Jose Ignacio

Thank you
Alex

