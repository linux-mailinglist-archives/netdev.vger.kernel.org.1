Return-Path: <netdev+bounces-98138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314728CFA92
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68161F2149C
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB1C224D6;
	Mon, 27 May 2024 07:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBaHz9lG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AA3C152
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796406; cv=fail; b=MZTWl0PXHyhmJZKXv0jbWOsC3QsRNbvZ/+vololQmO7ooMoMzgTe477Xe321UZf9q3yvJDgl4DXQWsVL4poBCnHW8rAV25PEhbshUk0ZzTNHKcZeJn8voONWeP/Ia6LRcvopRi+BSRSGvJ+xzi5nI0DrpJEEtRLutwmJ6jWXwPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796406; c=relaxed/simple;
	bh=ieKO1QuX/ookVW89CZ+DPHjEtAIMtZtc52m+xJAfiWg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qsUY2riB7mmd7bX4HqtojDISEim6OEh7/ijTloCX9wDkj3bGf50wX7x2qDKfXbMI6YtPJq7mwIOPjDEGaqSKRXy2CXe1KcxGQ3ZuD9+9MSYL/ZiX0ppSvJhjDRGegJAdTLh6mK/pTleMfKiNpDe7hgR714rGfDZOoPDYQGN+qTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBaHz9lG; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716796405; x=1748332405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ieKO1QuX/ookVW89CZ+DPHjEtAIMtZtc52m+xJAfiWg=;
  b=NBaHz9lGD+017fZH7PuCa/IAlBsCQt4HY3FQlCzDNpccKg14uJSIw1oU
   n7jAXCK5UXs0yKZn5HkTUAvA7G6BfNlteGy8EA+DjEkxFN1UBWsCc0YX4
   4gSOZu7nxTeLYRbVtE7YxFbDNUhlNgbJk/Xm06fdviUWyn25ispPLTWy7
   sprzkYTQhZet14LzDIA+bWpiQApCActD5YIbZmkH9cex0JAdz3l+SodUn
   61Kt3x7pc6RLbAKMI72bB0gWe6EyHMu3VrxcBHK0uPUKKElIj1iv0Pw4A
   UqC9ZgQ8YAKi6qnM3qArKuz+D5f1iKlrq2Gbb8ScVwhxlncAJgy1zwl0B
   g==;
X-CSE-ConnectionGUID: EGx5/TKmTP6lv4GIlrWiiw==
X-CSE-MsgGUID: ROUukZvASvOL39U2Hn/4ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="16924794"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="16924794"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 00:53:24 -0700
X-CSE-ConnectionGUID: rutZTrQ4SjeMO7+NbLGEmA==
X-CSE-MsgGUID: hpnOPnmVTKOMj8EqluHUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39646160"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 00:53:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 00:53:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 00:53:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 00:53:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRSr+QC+OBMjqF6AYn1Wx6yM8g7qWrR0+Xt0P0AJtdeB824SxGYqvp980MxrBpXhhZ6r0RNpllDxp78rd/WgcMPOaeU2IjisgDwmVfbL9QJOizmWHzVX35hruIK7UZS+aCAOiQv/vX24OVv27O5Kyvv2zY+Pnr0GP9vXtHdPSgUJ4mEFmoRhWg6nOihWZ+0DSBQYZcCfHBlm8yiXLFNxVSpUl5dpskf04zOj0MU64VGEXrXXgZZQyz3dvCiUSqBz5nAaIzmXSx8AIUziivnXE/RB9sCTBynat4Cns+4MedaFtHorOaIwOruF4DXtHe+n1sD250/pbZxRUSeHEQfYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmBm9tNXxwG+cdXIoift6k5IF2PRVtP9rrrpSp+Q9ec=;
 b=URBTV9qjJXKtnxSxhCbLUY3mtevYco84KWBZF06i7Wxwgv7ZJ3b3OW3Uvp8wVsSbm7IOth7jMsD9f1P6yuwmtMwT22WGVY000AGQ2VVGla1Xa5WgvjFXYjeYP42+yvqbK1HtlHWmJJj6Tq1DmUvZyXgMmfxs1SXTljRiKPpF/ulPvzZP3ApKMOJ0GBmisndUf1u3qREFEfbaeFPu31kIV3h6Uak3gRQi5M8zKm77ofQ/WfxYHtlxmvIGcQrYjwovwJaUI2G+/LiN/lcEIftXdjBcldaFmnbPy6qPxiqiqjNSxeAy1ygCxOBEMUtwKf16ONG4dvp5bndZeLnE3ivZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:53:16 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 07:53:16 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v10 iwl-next 04/12] ice: Add PHY
 OFFSET_READY register clearing
Thread-Topic: [Intel-wired-lan] [PATCH v10 iwl-next 04/12] ice: Add PHY
 OFFSET_READY register clearing
Thread-Index: AQHalkyul5Beoy+bkEWzmKILoZd0srGq6QdA
Date: Mon, 27 May 2024 07:53:16 +0000
Message-ID: <CYYPR11MB8429D1CFD9A16CBC9789E854BDF02@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240424133542.113933-16-karol.kolacinski@intel.com>
 <20240424133542.113933-19-karol.kolacinski@intel.com>
In-Reply-To: <20240424133542.113933-19-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH8PR11MB6976:EE_
x-ms-office365-filtering-correlation-id: 30eaeda6-26fa-4aa7-a99b-08dc7e22112b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4lyFWQXtxxBouvx7yC7l1SRdVCJCY0NAcorj5QZPUmkrLXCDkjNXw8lgCRxG?=
 =?us-ascii?Q?UFMvWdVJBjR4YROCTkrrCDlbgMXEC2tEoPb6tzSOkKD2QC583i3+AXxQUkLu?=
 =?us-ascii?Q?ytEXOHi1N4C0+aLIz2OA9RLQrlsE4zr1A/F5vxBsiRE/Tkv3eBQ5XKLhQMOd?=
 =?us-ascii?Q?gEX3Kyl3qsP+rz1y/SSz0Eaf4pCE5vETPAyQ07jcYxY2XqtMSzqX/6Ku/s9b?=
 =?us-ascii?Q?QPTwXF3Z0GJU359RkuNGVa4JrLlg0zT5v/D7KGng2vTQQBn7lyyjeetkcW8a?=
 =?us-ascii?Q?PZi0a0opjSOmsN/wiDxXwbvMpVcPA6mBtI7RCkVuN7cJJR9AaZ5Rj4Pg1+2E?=
 =?us-ascii?Q?W74rlXTf72jOnRuz+rfNDFf+w9z94g0YfIZNwgQ5zMyuYmfA9n5AlJOld5oV?=
 =?us-ascii?Q?tzBN8ie/4LRo3vIi4PZ0LEyEufZdlwUn2RHLSgj9kZmeOQlfUIjC0dq+/cPd?=
 =?us-ascii?Q?55+tMcQed0uRBp8CJNDDj+UiG5E0yj+o+zf1BnXf6yVY7GyerAmeChCcTKUk?=
 =?us-ascii?Q?xpOY0QnaWWwdARWVtcZwH5qD6YCqudcOQJnUPJdd7LI2O8XNvg9Y0vIrr79+?=
 =?us-ascii?Q?tLFnQ+zqmH/cyo/jnEXzFGwwyZBE07r8pDxDGVyKySSBt5tstdSnK3kPejAT?=
 =?us-ascii?Q?HwUiDC5vCLAYZWiJ7LNmQugYBc3IxHvKu50tHL1wVVGpjd2XLds6FrYvE/Kr?=
 =?us-ascii?Q?l2Djsovsd/EDX+cDPN3n2jhkdW3wbL4XQGFyhsTyVs+S6YHWdTBiOeh5PQcP?=
 =?us-ascii?Q?Srp3njvnLmWOs9oiJM+D9XTERmAJCxzAEs5cZlw4a6mxUxD8BBLderj2YfdQ?=
 =?us-ascii?Q?y7Z8w5lbQp65ZgdR4+1MkPdBCsybc9AEGc+X0LV5DTNmlxJ6gNIUjBJsvU5Q?=
 =?us-ascii?Q?IVOkF9oR5Gm5CRg/v5gjPYvVwojP0DaRDplH4CFBjeJBjI331PSKkxGLbMl8?=
 =?us-ascii?Q?nAZgXihgjHJlWfD+qOD2BEi5BHh+ArldS2JlOOmM80sBdseBT3wK285MWknA?=
 =?us-ascii?Q?65Y/RhmxDHBTstkryiFSwJZuYkwy/MQfYlHItDfyBWIfDmEzn2SQ7sY6/aXp?=
 =?us-ascii?Q?o1Cn1y8TYJOwpcnY5eq1Y0unz+95g+FKNvHq2kez12F/rnrVZClLSYzv18zi?=
 =?us-ascii?Q?HkKJt2M7TYeYxNXrs/059PQ4c5KkYgT4bXuQB44aK5EnPh0d1wVMdl3OpzW8?=
 =?us-ascii?Q?2lpxOoly7XePtiiqa4e9Om1l03atmv2PMcs+8IlcrPX7UVSMb0reqNhydSyd?=
 =?us-ascii?Q?j32/a+iI8iXN3ITEdFObMPLj6VHxuuydHkzlj3fF7DygmNNEPcZHAZ0D2s7I?=
 =?us-ascii?Q?IC9Y3H1PRVkOAsAWyCcAanU5/braFU4P2MdXIxwqL9LSyg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mjgpYuunvdL++gmmS1yiDzkpIJHWy/fMQOSUoLg9XU8u5VZAU5vI5fYK1WPp?=
 =?us-ascii?Q?yFKTQMMun4QUiHY7Layl9aNRgqmLGGVYHMkiY4hiVhkyS7myQMXp0aS0tr04?=
 =?us-ascii?Q?OZJhVcLpblOywnxGewp+qsJ502wKshXlcZH6RVywNalAFTy3xGF/6x7rxv3e?=
 =?us-ascii?Q?vyowPZVHplQdRSDvvF0XdFzQQO03heEh54KLjQmKHw9FbSQ9Xea2O6gQG2/a?=
 =?us-ascii?Q?p3wpXe0wklSbkU7+QOrPynJTZtuIGBY1S89LF0AVzTFnvs50RqKqt7T3bhsL?=
 =?us-ascii?Q?JbbjeF/5qpmBt4/hE5cX5x0CjhDXWyjq201v3ibRv6+xDZ4yR+71GWQzvPW4?=
 =?us-ascii?Q?Qr/FZGkKEQkulUBDLtCW584RPuwaOXTaUZ3EQhd+qEq4Zaq+HW7RPJfOLyQl?=
 =?us-ascii?Q?Abt4Hg7ig5rbZiW/JVbIYIlqIyvgmgoLFxAsgZzc/zy9xljfU1QwLJF8sZrP?=
 =?us-ascii?Q?5Q3+0c1ga6FVM2NbtwiJKI2ykVnrgkksubbK3Skyapjqy7whBMZqqVQS4WPq?=
 =?us-ascii?Q?thzvy79qRwn8i65k2hT+YzpiWZRwniXc2qyvkvi20A/7eMUlcJKDtUhZIy0/?=
 =?us-ascii?Q?N0FIyCBSoDWcizc7UC0phF/zJXVnNQuTLL8l0BokTCLonMYAA76NHbD+Zs//?=
 =?us-ascii?Q?GGrbBHdJnb4XiTjqipKyf1SJSnnLVlDBfZkY88QOyXtbfqei7ixoDWsKCg/Y?=
 =?us-ascii?Q?PWLpRIIpTNtBQsRl+pnQ3Pxq+PDm6sNILieJXnhqAgwc/IYuiEcJDEJtHIx3?=
 =?us-ascii?Q?/wBGEKA5jYu2gXxb2PqaibAxJJtkJ4pfMa49HAmR/Ryo/HOynMYNZ5d8/Z9/?=
 =?us-ascii?Q?WI++VskkNV2M8of1mnNGPCPomGmzw3PHEgmyVVabl5mIv4dGmfelyp+wAZ8f?=
 =?us-ascii?Q?vf9nZF2Dw1+/BQ24uQenFqsczwpuvbB3kpy9sF0y5C2cd2Wywq79dff6VoXe?=
 =?us-ascii?Q?DT8wWU+3XdWlJsbdF4fxTXh3Cd0fCz5ySxiQxWjrP04OoPoXZvwbj9cCYn0z?=
 =?us-ascii?Q?yJjfvcwdu0+nMkklgvvvjuerQUMw9GCe10YQwgcJT2PY4h/hOL8EPFJxZ8/+?=
 =?us-ascii?Q?BS1JOgAWA1QyKTQC5KzR2Ieq2K6vKgjuEKO2lfz8rDiXZpeWqY1MQM84y9+s?=
 =?us-ascii?Q?wfoYkT8LgF1WLROE6O3YA3z6Bffx1VC8pLqwbB044yDvZ90zvEQC58auwHjf?=
 =?us-ascii?Q?8ZXAdn9Frq7BaAV35ABaHZZWOS/S6ISrQSVX7PU5LKeq8T1XvpVoNTuOh76B?=
 =?us-ascii?Q?AHw7P/fiS24760Qztm/hgr4YuYTmM1ODLtiFxfA2EuC8wvLw+2ALy7TaLZvF?=
 =?us-ascii?Q?a8bHiJHHfG7XOesn/qJWE9VjOL3JLK2a83X1YT9GrAk8WOtDlwqG/k75vmJ8?=
 =?us-ascii?Q?kdaVu/7E+ZJgOzlyEE9o+DX1kEBikV3W6eCo2rBdDue/lEhz0C6X5h1U0p6+?=
 =?us-ascii?Q?D7RmS/wErnCwMTyQeH+oS9gZ00ketABpy2l80iwEnEytZiOsQ4gbNMJR4WDY?=
 =?us-ascii?Q?EvyHftP3IN1sZAHD2dXEOIhPCX6Mx+iyGZs4fuHXuObeZr2XkfiMaYtjKr+2?=
 =?us-ascii?Q?kQQ9gA9995MlmKL8vUqLrFy9wPdcq7r0bvceThhv/XaE+hgBrPo38kycS6iF?=
 =?us-ascii?Q?DQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eaeda6-26fa-4aa7-a99b-08dc7e22112b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 07:53:16.1193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDWYe4Ss+eRVBVJv02vGafo3czgYwWnv1zNHzZKkil5M1SNT9AmAg3O5avgK4ZQ6f/zw2H3TeaJB/HKThjRu0VCxo/JKGMixF/hL9vgERLCStkAs4tKTwvMc0+zKR+g/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Wednesday, April 24, 2024 7:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v10 iwl-next 04/12] ice: Add PHY OFFSET=
_READY register clearing
>
> Add a possibility to mark all transmitted/received timestamps as invalid =
by clearing PHY OFFSET_READY registers.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 ++++---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 34 +++++++++++++++++++++  =
drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
>  3 files changed, 42 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


