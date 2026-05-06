Return-Path: <netdev+bounces-284995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHc9MiKL+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:40:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB194DF74A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1B443002B41
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6EC4963D2;
	Wed,  6 May 2026 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAbqGcB7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10FA3DC4CB
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092715; cv=fail; b=tD/nzngf6OzrEQYaFiCdjIxY/QQPwGC+96G0lge/+nu1//5UUwn+GthR7tlS7nt8tYiGIDK/91stMW9INdI2/dj42/Gwd7tUCOi0iH0wu+viee82QU8dRnGwEKPeMpA1nObTmZmudLpEuTe+fBiztyrlUHDth/ZtKR4BGRSsdPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092715; c=relaxed/simple;
	bh=ICDqGk1aKkTYmv6GMGHAwBl+shpf6LKXWx2mTrB44Bc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mve5GDBG07kqIrsqkObueAgQKCnKXfYb4azebeyU3kZh4K4q4P2dE0hoJEvKuy4FlLsXjBc6Sghofk6zcAcDeOGhlu68BzzvMBmMZE5TtroeMf377iHWueLi7BqjYHjDwoK6BisXzFgtqjjqwHSgoYlCY7S8EIDT9FEmksg9RdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAbqGcB7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092714; x=1809628714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ICDqGk1aKkTYmv6GMGHAwBl+shpf6LKXWx2mTrB44Bc=;
  b=CAbqGcB7VHxiOzs2fZqW6aOy44FASiHRj+O9VlbfUsg3vf6NCoEL0s8Y
   KK3Q/QVMbt1SnRNjGTeNGU+OVqYnhS8yb7eUfOfwufN1ca11Bn+DvOGSX
   mgS54KwOFeLPXFgiIGjVxATzSSNfI8cvA1j9Qbs1yZFPUCuJIBAyvs95d
   52xEpdvzMvX6Kf3zWRinnmrAH7x7bp/lE2kK1DkOhoywawLDZ8Ptgk+lm
   pnDpCoh6TttVjN9WNe91aVhrgST0X14UtOTOrD4cP+eqeguWpgc4ywP6z
   vNzolPPdjgvIyWrujMQnOAQdLzSkiUdMG5XgrgX5t39PpaiXBld/RRvLT
   A==;
X-CSE-ConnectionGUID: 0BbMHv44Tl+DqlrNODBGaA==
X-CSE-MsgGUID: qYFlriVBQbyilJ1Iug/X2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="66565273"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="66565273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:38:33 -0700
X-CSE-ConnectionGUID: n7TYH02tRfuX7YYgEt/5IQ==
X-CSE-MsgGUID: qUBTeOt/Sf+bQwH7+IyG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231847568"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:38:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:38:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:38:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:38:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3csfntISjJDFDdyJR5wuREvUzC8TxIIoJIsWXFzsMf4CaCvcLWEXtqDiUTuTWGB8IelTIXnprnvXTJJl52b7QbarOvdb+MhBalS9CIUNdBv9U4yIPt+Pg9XO7rMvm0VoGn5Z9ReTbNESZiSDfjY9jIw+Ba+uNhlC5zcBFIVYjrqUuBbY2b2QL2CoIVR6mcJzKE3s+PvuEFKSv/wNbGEiy8cf/p0OPz7NAU0t1XacGdjCOohAWBb27q65vkFm3LkrAbdx0tapJNnln8V8n8a+fyw7ExZ6f+jGuv+AB0lEHTRSSTXL0/OYjpyr5mEYLsqD54RZ3asxOFFtGnKF9VGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIF/HsZgNLs4Qn6GC5GhZoh0kh2WWsbVIeZdqTi7ie8=;
 b=MVRZ++tpjbL5ptaexayxeDLZI2ls2B7ZjwRx5HVrSAtvMTApXvtw3HzpGLz8Wlwv073hW19IrDmpA7qVmmq49s7fpytefRoOZJBGlsRoLZ0ewWY3dv8fEDRHSXoYP9h9Y5hL9W9cg5Qo3w10do+NeiX5GXwzgcS9ZTKHdeN7jzNKV3hucCMa6OON87+sW7nNl1VvpntunuuhWBr5uy339XtnIDyEAB5AHnpsHsc5+MxmW/KZXTUx35/tm/Bssqv+PWnnoHTv4IoiTc5sXFQ99kpswH0KH4iWNqSwxjG8Zwy9L/cBrQAyPvyvUERfb0rij4y+5MCgny5oy2CFA3yT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 18:38:28 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:38:28 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 05/10] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 05/10] Revert "ice: remove
 unused ice_flow_entry fields"
Thread-Index: AQHcyCEKryzIT8M6PEG3ukuub8Z347YBfq/Q
Date: Wed, 6 May 2026 18:38:28 +0000
Message-ID: <LV1PR11MB8790736566FCD8815A48204B903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-6-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-6-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: df9105e0-058f-458a-19f8-08deab9eaa8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: twWnVSb0tuIVRES78+VKZK0PeBqMLkz2LImJMwbjnFYyBiS8+7rI9UPFBsuqz+UJIErqUEs8RVfoEALQ75h2BjLt5bv/4Nh07BzQt+ZE/Z7ymWQJQoaTl6Bmv6k5Mk8e+IJx2zZ5V0pkhqzeZH5REcVTPq47zm2HLbm+2+M02I3EPrkgs74mbBnxlKBvRKrDIRThdzOPrzfdgsr5buFPXZU7wVOXECssTqqVq0HxXdlqp+95CvJiIs8ipM1RHnrgrdKKXYuZFgGHTLpiUm1O/oPKbOrg+PxHyQkq3KidABP5wcZxHPlsGFuvY/jtaWnu2UYMcdcEDY6mPHHws4CWvUWEeklwmx6qJ++K+T9KQLRcJ3Q1SEAV2hzPdgq2zHs/cZqNc/ZtmrnFXVaz20KC7Fp5rxAIe/E86frb/hPMHWjbWKMuL5nR2f9Vq/lDKZZPt8kYOnOYVLHAi8RhKsBBBlB27KmF4RKzIr08DWQNaE03vGQyZY6DZCSlPDcltJ6pHvMSDmuxordgNVJLafz1t77G05Rt4dRDpbq5whNlPr+oyS219OKXQ/+z3l1e7HWTXuv3YT/yYZmSWz03/h2BswFrGUavD5EyZg16V6uljcW/fCtEABbDzD7g9exPKYC4FhpY2QtnjMg5dh7wNIpvNNTio0uaOwsqoxQCyq1qOxaFWXLN5TlhqcnP1bJr3DLibJNEALYmkcwaW0s4aQfSQfRCJ1qtoXHnRx7a26O9VOqiMuHRG1bNV1d4oTwUl4eZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qGmmLZ9gy7PQfWIVpONsAShpe6xygLfn1WG3cbQIWFXVGF9YkhZOlJGYpAet?=
 =?us-ascii?Q?Kexq5a+xCQM7XHgfEexv9ViCAFiXc+vfa0kAxpVOONXIBZbYcE++IS8lv6En?=
 =?us-ascii?Q?3CkV6aEUjqpnDkOSKEwNOsyjKQFulLjDw0aLKII5+m3CvAjf91aR+SpsXbIQ?=
 =?us-ascii?Q?sgrzgSbkJCqJBGVrVFTYMVhujGh8O0QWbyd0Wtju1palG14sQe3HLGPt9nWU?=
 =?us-ascii?Q?TFBeRbfEHxpIdlY6TxUl5PkmW66hE+H/qGrsjSUhjkdnfty48BGNt5r/JD8s?=
 =?us-ascii?Q?uIh3tJrv0NoAV8ZCltaTikkP33C0fvR+M2udacWXHFyGWmv4LgURg6n1b+B0?=
 =?us-ascii?Q?PqUvEnH2tJD2vK1Ay0CQZthzn5+0MWAGn+FCev8wbdE/Q9+4HPXaMW4FvCjn?=
 =?us-ascii?Q?1dR8j+ysZ9aWgLDHskaxiJ8MWDOw8MX07fDHZkRFBn7nVcnoA6KBIDvkdotR?=
 =?us-ascii?Q?qXT9Vl0gC253i5wnHmaTw+vxn1IMW56nJ9sL7RCfPj2NZDyTE0xuBZs+V/G+?=
 =?us-ascii?Q?zjYgBLz1QGLQgthec+/1lnLUF1sR4lp1riyDmTYV2GP77dw5ZuYfYaH3E4vF?=
 =?us-ascii?Q?sr8q+21AgMMbo/mXs+nyPjmlMR5/lkuUiEK/ikiijDeJHnCMBRjXikj8J/l9?=
 =?us-ascii?Q?iRN4jSauJ2dPvZf2GyNEN956nOyv8BMMYNyLdECT2nePKV5D0q1U5CpEZ/Zp?=
 =?us-ascii?Q?Ka3KF8xWwWuEkwX9/rhlUGL+ROC+mEO98yLGl7lu/J5Vs3vc4KW4SeBuRa/3?=
 =?us-ascii?Q?oALGoNgTs7+rYExcolW0ydxUtEk59vu6TRl+ULypDdnTHVTWzC3jSMRSlmn1?=
 =?us-ascii?Q?0pd0QU5Bm/VT/kodFUjO7oKaGDcPRzhAlsSCshT7WviGkXWDgFZfiBc/zb0y?=
 =?us-ascii?Q?sGdYALT5xhxqQ7jGQe4DYOqQj/A1eoe+SmFo8PFkU2VhuzRmtoefocUFQqP1?=
 =?us-ascii?Q?aBFAOqcF9j/yKFHn7K56aYfWHCeSWlmh9T7jVseUC1a30U8A1NtWRdiVtai6?=
 =?us-ascii?Q?PpbYXNvLOfpBh5Iu9W8qKoT6rZQM9L72FihgWdsd02axoaIXWua5MpsEOfYm?=
 =?us-ascii?Q?WCbTEw6tQrzM+7Gr36NAIvqADyqgvinkEnRz5DOIuFIxvuvkhiY4G7P5ZuEp?=
 =?us-ascii?Q?1AGWULCsBa10Ko34+4bDVSx+dyiBDLwomxxdVFXp5STmUVlzBFNFjh3a3qnq?=
 =?us-ascii?Q?aoB6htuSW307LkWD7CpG17roH4Uq8TehhvfqEGmb7zhpG1coHlF2r9O5W9SP?=
 =?us-ascii?Q?mWUPYIXhOXAcOgoNFTVi6MrGlQZ6NHS4WvFGdrbbRNxD+uV4WzIqF7bPE4lI?=
 =?us-ascii?Q?dgIebTV+XldcNCFTjQ3V+4allwfG6LTC4B2/aCbdu/DAXKsH8LY97dUIJI6B?=
 =?us-ascii?Q?4AWwmzHiRYrTSsv3K68dbByfhg5rN259gBJtT4b3t6sIUhgY7fbjY3PM3yZH?=
 =?us-ascii?Q?JFzjtqb20i1WhVOCiuHPTAIP95/BWjOjB56A4HhXdPhLAUCoEH4Y/NKqER5c?=
 =?us-ascii?Q?am2nZxrGIgGPvSOszt/FQ/Hh5bEl/4kzvd6yRPduWnVJWnuegi4AwxSdO7J3?=
 =?us-ascii?Q?ISXiCoq642uDVAaXxP9GJlCuGhujdQ6w6Ri1sASP/Qe/5xO4PsjECq/25XKH?=
 =?us-ascii?Q?caOACdg+qoX3nW1KDjogGTJXn2KmaBWLCwvig5bHkn7aVZorIbGyfd6oMbEk?=
 =?us-ascii?Q?snRUiUDwd9y6yeMMzL1sMS0c+iQNaI6BqE6hKLkNzlk9v0BWkPF89gR8HGWU?=
 =?us-ascii?Q?B1yUPeKdQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CLjnoIsVCJErXZnn7rFr6Sjtu8cd+rUoEKhg6tsQJmfPNCJ0/opGS1BydbWc8uRqgpTqFOrIGuwP/0xgQjBPbdL4389wZ/eHzLh6MHokOb5ekXxVudR1oFS70s7sV5msVjjHzre0TTvZI76Ki/KsCNe0NGBwxJzcaiUswYXj0M5p8BfEYtBlO8wb1C/c2QCDQipf1neCeq8R0OVDOEE/vSjnG92/yUXLIHA54qT0Ean0BlCwUpoST+RTNLqNZVpk93+4E4+dSsPPn71KkKKyOpgdpR5l3/FLtSbTCulY9OeIDJHsRcFql5OmbeNTOZIeyDwCAl7dgduH0t41IP687w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9105e0-058f-458a-19f8-08deab9eaa8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:38:28.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZXpYcwrFNJcYusw5hR9LPOdLd3SkDLOu0h0+TUL+NSuymxkG1cOv+8yFfQv7+onPq4EP4m/Almfjau6oKCdoNsCfKKt3J0IAJ+VsEQw9mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 2AB194DF74A
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,osuosl.org:email];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	NEURAL_SPAM(0.00)[0.537];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, April 9, 2026 5:00 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>;=20
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw=
 <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 05/10] Revert "ice: remove =
unused ice_flow_entry fields"
>=20
> This reverts commit 4cd7bc7144ec2c0bb27208c3bb1f153dfd44b1c7.
> These fields will be needed in the following commits.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2:
> * Add this patch
> ---
>  drivers/net/ethernet/intel/ice/ice_flow.h | 3 +++  drivers/net/ethernet/=
intel/ice/ice_flow.c | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

