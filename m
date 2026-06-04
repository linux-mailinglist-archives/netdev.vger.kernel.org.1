Return-Path: <netdev+bounces-295414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ezNGIZXbIWr4PgEAu9opvQ
	(envelope-from <netdev+bounces-295414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:09:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE0F643199
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 22:09:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AnUowIBi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295414-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295414-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98A73011BDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 20:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04F3D9024;
	Thu,  4 Jun 2026 20:06:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFF3D8915;
	Thu,  4 Jun 2026 20:06:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603566; cv=fail; b=swt2tteYge5TUNPOSyHhc1WkQvqZ7HI2fSvXOepoTkDMa9HPEvDupj7ScIqaK3Y8brYQ4bwF42uCS/fwSQp66EespJH9gADcxHlgQXk8K/wTyAdUvESdjQi7t9IDyYPvV3xR8y2VqQKWOTVhShzIHHAm+aL9Up4DEcCla/6Se8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603566; c=relaxed/simple;
	bh=R49bCwwbYTTjqJYcjjbakBcfc1x/ljrFthOz+fxNJTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KCC5eeCvRsxP0O5QxNl3264OMePwOq+9AM8wltMbzNiLk8zK2D9ShcutvaNI5KpUss1k5RGE6l/l8IufmRBRu2McgkrEoMlP/ONkAR6UG0tUCTJ5jS7uGMKV/KwKpnH6gLULzSmU84kfflPUafhKfMuEbvvbfHmyrHvQMqRAY5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnUowIBi; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780603561; x=1812139561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R49bCwwbYTTjqJYcjjbakBcfc1x/ljrFthOz+fxNJTU=;
  b=AnUowIBivUs8QDERfpt8UXZihEFoYOkJKM3w92ycRWUB7QJVv5enjx/V
   qAhWEungUhT6L93bpL1hYCe5RVJuFz3jpfvKi82VJP4m22Fj567zP8bZE
   E7hnVd+br/pKEw8NKbjsHsbh5BRPUr53pHxtuTOhG424nmAfUTz5VxImJ
   p8z8hgf9mATZon/N2tIC6WXJyH7CYjaNnsZk+rkl5UxEYWyJb9Qi5H8Is
   X4VJ0VLFxzwb5W9IeBd8SFxST8aRK0g3PA467KAio9WyIWa2Pv3C9ljxm
   aA+DrvcXSanY6+eAOj8+WXy0/1q/dn/ylNDY3YoJ5Tt9hMS+s7Q0CNKYG
   g==;
X-CSE-ConnectionGUID: TnKlfrW6SViM6a0Vd+zCwQ==
X-CSE-MsgGUID: k5obUDdVR/GF9p5bA18WjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85063204"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="85063204"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:06:01 -0700
X-CSE-ConnectionGUID: V+1L50/zRN2ijiSsGyZ8fw==
X-CSE-MsgGUID: ICu+kyHfThqIuVQEzP8gXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="249567469"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 13:05:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 13:05:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 13:05:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 13:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC7CEWiz5KjMQgR86kRMK/Ho4zFRdZ7UJE1Ba2LbTBqfIkLRz9Sc8ObkeAYy0aEO6XrfgiVU2dqEV28NguIJ3cuEcylTxRA1dh9GRsPQN+xTHazptqsJG4zZY1ljQD5LstB5WdJDstxKkyWLom4pN0/zQTpbAC0hAl67eDLL607uB72aZ57+DSNV2GCBbSB2uAAWG8+OfcrXo5enIsQqZRnSm85wO4NEWNknMZKfEzZi5XF1qUtXL0eoT9W/QX1vfApkvffMD6UccBviN/377uyCC35czXxpbQyKAElyC0rdmr1++PoI+CTABWNtc2hYO37lDltxgQzjYyllEJY9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vipo0cvSJULuw+IIG1ODvEXu0b9O/mMv9UbsgmG0S8=;
 b=v/8RZO6CjWlfAVuHtklInakZrODp6F0NkbCmll20mfavIcjLKf+5kwVYf18QVUZx6TEuyvIcwxUBeppkMkXUsxxOYjqBCHSh7G9efNwNzymp1R7ms4iSs3X33kW0EZ4XN7gm9eQ6ejc2nWlqwETQn2LwrGyLVg2KBQc009AfihvkXla59B01I+DNXhp0ucw5829w+0q+APe4Efz9G5eO/ztRdXpyjKOnA1kTaCYOXr+2/Q3k0f1L07PQGFUUjL99tNnQOlEPT2GTqcdhV+Zo7in0Zh99vrmyPaaeZrgsqmISOLnOtRr2vSGCI/XQ/dOi9KFBylTO7DiRsZrt5STxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 20:05:55 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:05:54 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and full
 TX reference clock control for E825
Thread-Topic: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and
 full TX reference clock control for E825
Thread-Index: AQHc73fbuuwofGiUWEqM+0MeGgr+dbYtpIwAgAEzHgA=
Date: Thu, 4 Jun 2026 20:05:54 +0000
Message-ID: <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
 <20260603183036.7c4762d2@kernel.org>
In-Reply-To: <20260603183036.7c4762d2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: 329ff594-ec8a-4703-6392-08dec274af73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003|5023799004;
x-microsoft-antispam-message-info: LrtCNVMvoWuorRZumVADAlRk0w9XYqOcASV5xMOMBMK2m9uqkhsF/RSpJPhPZybMpphJ45lMzknfYz/of+pRn9Ktu/bDJ8ls3EOkEsHnG5KkF1fVbbYHjFMcZpG+SAv1C4+9bEeGPqJralq36KslSI+Cxon2stx49lfyYP2gPP0ROH3EKvtb9OqH018jKEwDm23vK1PireA4x8WpxFHhhx9+h5RbwiK1xaJORlDu+raoGNvJGeReA3+gDXBQmLrewyMxDydYw/IvMep96MtcO7M3V79EcjynL6DgVv5zFNcg83DEt4WZx1Pl2qHF1d0ATLtJTz/HHDp9YE6TUMGL/KZfAJVv+wtNJcGMXSvEr7o0/ZOn8kBRrRCRxKqgDDP8OIiEfzPZc/8ysoe2W0TZKwiW2HSjCmgNblbzaYJxCDKmOdW9ea1pmM3Ndb+luhwbhNDyI9+GX2Wkq8RGT7TByS1XCIC+QytD6oXQLfSuJHM+++yuvEqBdNW5og5WziOfUnXqjSMYxKMyv9viWH1CJMrzNqXW0zKpt6y3uRgwDlBRKOwl7/NTCtXiJrDIZMg/8cwIN2tW6R3wkG3Q2NvVaxaA5UL5CWT8CdQ1J7tFfoRjnEb1zctUSiNdDPS+cKz4zDu6QfcB5oWT9dSgFdlj+Ez/lSi/H1yBRCeTxpxqTT0gRh4u0VWyIKuDnW3hHIFB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KcLwINz4KOnaP0Tvz6ArOzxbWKCGoNtdK7KyEYNEoUnd0svP33oE66fahYFg?=
 =?us-ascii?Q?m9Q+WhplCTgH1Rn+4coxbCChX5GM7Xc66XBrl012ixPkCuzkE5/IVlPlcn/l?=
 =?us-ascii?Q?+rmgwF7c7GdE6mqk4C4NX+bJgm+YU7meCV9TmFJCNzW/sWxzXdMx+R2a1L06?=
 =?us-ascii?Q?qzrZODq8VDRGjp+73JpfHbqrhJ8YDTEfKZSaQ6X7msKeC819bPLbLxB1bI8k?=
 =?us-ascii?Q?es3sZsYGp4xeLTw7jEoscocgmUmirE1xlDgMsLf/7fN0bDfWm8AHcYPkMPvV?=
 =?us-ascii?Q?dVskYoucyg8H8pVzs33XqAUELGBpsFGH3UVDGu4EmFvwPA9EqOk1w+rYGHeT?=
 =?us-ascii?Q?WdI1cUa6g7yEVZRpUaD949odLG0l70KWff0ubZd207eUHjFZnFwCQwMBPRcJ?=
 =?us-ascii?Q?J1A2xyR+iGMkLOKkbeSefJqyynVfLxskyhJrkE80t/aZFM9HOQ4EwlZEWI5n?=
 =?us-ascii?Q?YLdP44zIIbbO5znuqijRGS3U6W/UkYLuisCAxGmboZ+o1ujmSPy29a4NmU9P?=
 =?us-ascii?Q?OFpN6GDSIK5t68xsBHtTek/b75jtomEITUq+igSj0vjv0vmANnhgW5GICyyF?=
 =?us-ascii?Q?JK3YujdvatmmVCVMWE9mxlMsiBQxgSlITgInSKRhWRVMP5txgLKJx12xC3TT?=
 =?us-ascii?Q?/gnEJ0hZiPU772alv+djm0OSG2ma9nBhsh0cuPn9mzj00TxEvIHZ5eflhdS/?=
 =?us-ascii?Q?HAwuxAfcqObyGOHFZ7q0Wdytj9jfPvx1YqMQbPHmw1Fjn2oYVL6rnG7Mjjwq?=
 =?us-ascii?Q?hwg20dC+J86Nj72zmDranGeF3/2rQrtISmQ/I8eqY0kopXmXE/BYHIe3/Nqe?=
 =?us-ascii?Q?YTa097+qML/PzAcJsRTPYdKAwNAaV5vOWknFbCBkodUBGvA4rsx/JU47xCzZ?=
 =?us-ascii?Q?J947nwwKX180MiRZNNkVhzrhmTMqSVKaJinPGd9NbpeqPfRmrrexyLiuK6GH?=
 =?us-ascii?Q?+ZqkZKSwKdibpd6TRMXdMPrDtKKUi22638wL2VUk6cjT2M1jsqKc+tbY6pCn?=
 =?us-ascii?Q?6z+PteBFSCGikO3RyHloE6qzQqEy8DAHI1eEEtITKaUjaumMm7fWiTwR89DC?=
 =?us-ascii?Q?HmtkdY6gBuX5D3OsL4tvEC2MFGB/v5PbIPklwnXGKM74uKc63dXbEa9K/zmh?=
 =?us-ascii?Q?cDSjgyFbREWgCIQAmHtdOBYgCYR4uZJQogHl07O20Y2DcTHZFzj0AUvRWoyw?=
 =?us-ascii?Q?3V5HrRFYCFrh+e8WSSlo4yq+mw1x/9Ao+rdJIACs+nHIw4PMxmcZ6/fVkCds?=
 =?us-ascii?Q?qFEa7dOBX1T92W9Rd2AVYXkKVIuVHpB0S1nmdXnrrib9koPUH6N8L4jnkT/5?=
 =?us-ascii?Q?wrrWdAysD1oYhraslql5R2T7Qzvd6g1LBt/ZZVmRfe+A0q1N9PZRr9EOEMm3?=
 =?us-ascii?Q?5XDlDyhYw+gaBVjTr1irdPOvFIfSmEFkRR6/iymdbAAfQGEpck9PyS3CZmGi?=
 =?us-ascii?Q?LPbTCwBqRsgYaMJj5tTiUKhZzQaqQwMhcgVekJE1v8O98UIAKfAwigVQgMxx?=
 =?us-ascii?Q?Qwyy3vZEUAaADPHqa10J3l/reyD6xj+k//Dp4+q/kyGRyOSlAegMqC9eR58v?=
 =?us-ascii?Q?Hyfy5MnDD1IQrfkL/1Fwr+ejFcr9KFVNkd1spqVBVHOiUKXKsuSsRqt444iM?=
 =?us-ascii?Q?m47ZLu5scBomaI1SJZSw6VKWhM4QugBdEldYw6IZfyPNzYtvvksZeI+ZnBys?=
 =?us-ascii?Q?Cm68xE8AdYqfSWe74wuGzMJuIRaOrfF6Fi7cWut8j0kjl+ZyCzzKeORAE7Cs?=
 =?us-ascii?Q?or2PC506yQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ayu/wYPlx6qUFMBvtj+X2MeeWZO3gQzqZLm53+475KbFDKqIhbsJWVtszY2P1B37XaZheXURKPgOfK7wQDkIHcBxEOxMlZJr7rYMzwP/a2iTzlIh6KfLcdNOZZTHzl7Cnf2so/EzB06vSjQ34DsQptBUrObqn7ddcmgEar2qhEIZtxpwzW/iRRDrBPEf7xaEm92p9xKKl7fOB4whhnQnM0tGfxjn9yhTAnm7VVDZPTVDP4Mr/dU9T+OItmXLCE+ssmTJqDqqq+f6sXNO3zSh5gdRpIV6FzZueIfsQTu3O/+cY8ihv28kKYZ86STryAHJI5ffJfTQ+brxM8zC9TU38w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329ff594-ec8a-4703-6392-08dec274af73
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 20:05:54.8410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enESsyxxLXBwd03Lplzy/A26PO+/6vjgIKP6npTEC+OHwWwXtGg1Xg3Ixk/y56TpntrNM0w6lOCbf7kwqOtiArF+Ad21r2w1BmLICOGDFAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEE0F643199


> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, June 4, 2026 3:31 AM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; edumazet@google.com
> Subject: Re: [PATCH v12 net-next 0/8] dpll/ice: Add generic DPLL type and=
 full
> TX reference clock control for E825
>=20
> On Fri, 29 May 2026 16:26:20 +0200 Grzegorz Nitka wrote:
> > NOTE: This series is intentionally submitted on net-next (not
> > intel-wired-lan) as early feedback of DPLL subsystem changes is
> > welcomed. In the past possible approaches were discussed in [1].
>=20
> I dug into 3 of the issues reported by Claude here and I think all
> are really preexisting. But I don't see why we wouldn't fix those
> first, and have a clean AI scan. Please send the fixes ASAP if you
> have them, if they are trivial they may make it for tomorrow's PR.

Thanks for your feedback.
I'm not sure if I can identify exact 3 issues you mentioned above.
I see couple pre-existing issues reported in
https://sashiko.dev/#/patchset/20260529142628.1678955-1-grzegorz.nitka%40in=
tel.com
  - 3 issues reported in [PATCH v12 net-next 3/8] dpll: extend pin notifier=
 with notification source ID
  - 2 issues reported in [PATCH v12 net-next 5/8] ice: introduce TXC DPLL d=
evice and TX ref clock pin framework for E825
    The first one is false positive in my opinion.

Did you mean those from patch 3/8?
It should be rather simple ones. Shall I submit it as a part of this series=
?
Or a new patch/patchset? (against next or net?)

Regards

Grzegorz

> --
> pw-bot: cr

