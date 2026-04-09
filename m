Return-Path: <netdev+bounces-276926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EFyHH5712mXOggAu9opvQ
	(envelope-from <netdev+bounces-276926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A523C9043
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64C5A3002E4F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA439DBFC;
	Thu,  9 Apr 2026 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E82CloA3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BA39527A;
	Thu,  9 Apr 2026 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729530; cv=fail; b=en1A4k2mHOMLipiQqUVhbDX/17aQewCay7mbbQvZpo+SQNH3EZNinpAvshe5SgsQJGPdcnOuL/o8F6455KagUCDAi0pq7l0UljRSZ2pKgP5B/Oszyk4VF0NL5d6IAk8dLRLdncWzKiCrswYXjNvYE/ZWCPm11jw/0FRROyt0aXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729530; c=relaxed/simple;
	bh=hWtdltm6pUoKyqFoxB/Y/sO2Qg7JB1B9x2VIcYfdl4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FWACNt01b5hOoewD0gT5sHX0s5wk9AvVQhokzyGOy7xQLMx7RTroBmPIJpsQ4HM8NjC7yuAQYH9vevfZ8tWzJkTSscWEuAuYme1hvJv3R6KLLpgufsBAQ3/dSbEE6YZKugXCVOlSPy4c3sgMmdKH08wPy5YgoPtzpIz9c0QfeUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E82CloA3; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775729528; x=1807265528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hWtdltm6pUoKyqFoxB/Y/sO2Qg7JB1B9x2VIcYfdl4Y=;
  b=E82CloA3HdThpLL2ixtraDvjV0wxxP1xLLbP19FCjd49du6kcZ/Tp9/w
   56MDkDiu+tFfC4IahCGzCl3ly1I5E1OtIWswPIHDHhYfPlXSaJSmc9DO3
   oxS556fKwDi6lUu9Dfp5IvGiGKTPWosT3MiZPvtq678AZbyCypvkHXzO5
   o3z2vjHmXSGeWUmoQG/tqKTdx14ea7KrSJI3/JzdKFL60yp9b4AlaCeXk
   jpYiGo71Rc99CSI9yBTZ+XLFYJhlDcGdIw++BOGTkpQ+1463oIFeWlryC
   eTBm7ZPyMvZpFwmCrpzRDxbWrts4K7w7rt2Khuxf4PcWmP9C2L58lYDJ3
   A==;
X-CSE-ConnectionGUID: UU8KC/4CSk6imK9cT0UiVw==
X-CSE-MsgGUID: NeQtJjsUTwSFgBl4bQhHuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80591134"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="80591134"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:12:08 -0700
X-CSE-ConnectionGUID: yI/+ycPeT6iD/oN8OPpRig==
X-CSE-MsgGUID: 8lWZS3WcSOu6Vo3FpdfCCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="223980064"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 03:12:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:12:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 03:12:07 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:12:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwyHXcEEyEik9u6bTbPVnvEpmXuFs2hP7gb3qwHZU6GkJoZbEklUyZtbgQK98sSu7lGEgeM9i9odORtVoV6Rt2qbmjJEOvoJ2xPSQvKivG9OUKP/hSFBkqEgVcwYDtx/KbctUuD6wtQkPIdBfK1OecZ7/XGF0M3MWEvH6VmQv6G6sSaamM7ytP6J/YWEvpSKlEuR0SVa+0AJw5IuaWe8JES977Lyg19XEapAjVzH/IwPNTq4cHe+3SkuK+HmbVUKM9M/6jwJCs86O+GvUObZ4m34iK/0lfv3AxK2ayIQaB8Fvb7SQt5odYTYaZMoC2aN1b0WN2/hocupowijZ4Zp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy7Q3iU2d27ZFz8vUToqnfTLdGHQIFdANh7qHDoksww=;
 b=PD9JzBMUvwgqevBRTdowBSXKE7N9LayccsuhCy2bMJltk4bQS9tY3BwMH/N6Eyrok44KegYLHZQU9NgMe6HE2hoy5ieyBkmRf2FWHhxLt5EPPfTDZ31Td7UuIEDEaA0ZYCZaSR3e+kbEdslChsWEdJ9Ajm9MFGPey/plzrVLK/p6r3sSFFtAb1rizpzjbiVmBXuySPsRbLPaLgTVkAGtjzos5U1a1ZznVrYC3fKb4QmddOUtmtPYtGoQkgrS0eGH+oEH9tzKUva1OHf7S2xsHbVzg/jzZGZwuGw9WUN/d2SyP58jiMkgT49tljv8STW8uhOZHR3IGedr5v0Or9iGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by DM4PR11MB7184.namprd11.prod.outlook.com (2603:10b6:8:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 10:12:04 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%5]) with mapi id 15.20.9745.012; Thu, 9 Apr 2026
 10:12:04 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Oros, Petr"
	<poros@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN filter
 state machine race handling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN filter
 state machine race handling
Thread-Index: AQHctTGrgfMEwRLfuUOlql1xGlfG+7WxCDEAgCWf7jA=
Date: Thu, 9 Apr 2026 10:12:04 +0000
Message-ID: <IA3PR11MB898586931B2303B8D7CB7E668F582@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260316104209.1285962-1-poros@redhat.com>
 <20260316104209.1285962-5-poros@redhat.com>
 <IA3PR11MB8986FA7536046A7AE5C98D96E540A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986FA7536046A7AE5C98D96E540A@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|DM4PR11MB7184:EE_
x-ms-office365-filtering-correlation-id: 7bc9852c-dc35-4a5a-66f9-08de962072b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: dz/hvwr7bubP4JzX2uerbbRFQN0b8lsrKFoX5OU4ol/SCQw1Sj7VpHK6dyah60wafKJLJYi0Gtua724kHyUgyNhfPvQixrvlFDtWkz7JNeAeyAXN8j3FJIOm+hrqzVKpQw5oI3xmwB1RCWHxysUmi0KPOgqYLMM7+rxS7grhpAbdEuE4om0IL0m3htb2vxo3emOXHgRYTXP4H1/1uwfFcYumj61qgVczUuR1GKT+Oy3Psj9A5eGxlCNl2sP3Ms5lNBjLNksCcxTTwItYq8ylhDavtxg2nXHg/Wc9fkR2fm3dljvGYxYzrHl6PPbFXyRG+Nuq0Vy4gQRW2cXvBxswlgO4BrRygMTdAS2UeFi2Z8O6hRUS/rDtwQJlpPu/Hqv0eF/ZX/qHUCGYg568mvaas7v0+aLy8Cjzi1ZixigyKTDzuLVpL/VrLfLAbwViLISeeHIdOedHy9BwOwho5+9Pc4Zivd/0tqn6G2GXjEFBtMWVPQmQxb/Pdy5GmVjtN8RiGNtzfeJ6EBoF0PwTiqosQbA68cPdfVCFCY051JRspQfJioa8c5yCVElV0CLkSLkEYmkC2bu/xi1ME0qIGYEuUOXygIWaHycTw4mnJz+7nPz5J+MClzfqTMSSizRkGq9rgbq90jCax1m25ZZxdMvFuWSvYX8iG+sK9JpPg+DmiIWTTgTXCKgklRx6pvoJXAuaue9afRybzMMd00FliXjuIyyUdOOTXjJMPZX9TnTrg7/TqYs3w18lB7H49GfHb5aEhueXZ+OxYMNOxZwNHiswnYmN/4p5gss5wZAzIpjGuWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QT5MtDiH5zb2WPIIdZFYGAJrJCG1Eop+IPcte1ht9f+RRzDlzu3igUxRlHE7?=
 =?us-ascii?Q?Yk9joyu/Oyms6RX/VJ7ccFeOOY68HjNZS8vbmXlbyJiHVfWIB9ZzUrJWFUMl?=
 =?us-ascii?Q?JR/AtA7qr7xofB6kq9+B/QgYayaBjJH6g/rm3UJ8gPZwZryPOMy2AeNaWS0A?=
 =?us-ascii?Q?qK8l9CvMnsJ8lCkfH3M6KqeP72K936JGZBMZW09ZyrfWhGtkGa2Z4OxmGRMF?=
 =?us-ascii?Q?59PzINamMEXLK6sYvYO2ZYLaS7nDse6rhuNBmTRo+vlaRrKpcMRBGvno9oy2?=
 =?us-ascii?Q?Zeqz4De6ZhVMPBKUlxnCyB8tCV/LN4gQvK/PE6YQP8M6ddAPRRmtiFGrBWXk?=
 =?us-ascii?Q?1TcKVNGw8opUXhb6sN0Iy9HzZAzJDtiYqFsOTyz4tRmwkD4/xmvyiRIo/6Gh?=
 =?us-ascii?Q?ma5XtHuJG9y1lyTTMOhxncVbsvIfOQ8fQn1mrwB5/WInhsXacdPjngQ88WpK?=
 =?us-ascii?Q?afErBoG276Wba3Y44phYME+O2vMUOWZhW05kTMc57lztJ9DM1hjRIMbxGF3U?=
 =?us-ascii?Q?1fJ36RFv/dWyhl96YteNDrhcfwvNa1k1BQyXmr7H7BBR3hTd70hLVikP04q3?=
 =?us-ascii?Q?qDJpJ8dUGMMb1kEp+fDfxdnLN3ZHhCnzGqGMmb2yfmUygttlxzpMcLXFmHP0?=
 =?us-ascii?Q?2WCTRleaaJ1oYu5yALOdWjDN815PWL47rIIdpiVczUihsL3Jfcr8iS/kgGPJ?=
 =?us-ascii?Q?eiN5TgaB1Bl3xff5tOTZimQcc+WzyJ+BvN2BSFvd7ItaZSrIEpzeZ65F4g5m?=
 =?us-ascii?Q?2nf6ISiwnwKhTcZ3SgNy6q5WB3+y1PDPLim+fPr826g9/I/Gj2ybd4JrJQxZ?=
 =?us-ascii?Q?nxs1lgw4bp4mEpfBh8B2UntHOqOLYq4ycu/aMhLwnhOJ32BZU9aLaLYdjRlB?=
 =?us-ascii?Q?ls/KZ3SaYmZ93ky/9ndm6Ih3d9oY1wbE5HhfQ4FuhqxAqm5q5tOWugMo3aWi?=
 =?us-ascii?Q?Qk5OJNZd3H86uFz+EfMgFh85n1fdgI+uryNbE4HMhr/BAZiV7Zcj8PKHgK1X?=
 =?us-ascii?Q?77WAxb9k4R6kEoeZAsHTWVJReXyoMS4Bi/131u5i25ZXU+TWQsBB81MH79JA?=
 =?us-ascii?Q?ql1QDgH9TnNh5CAgx6X3HU+qa1llV28L9th+TMwTEvduISB1gvxLLeEVYHA6?=
 =?us-ascii?Q?+d32bc42VpTSLPisuoPlKPdUPcpA703j1j+rbaWM4gyZStOUQ04xYx8GbWUf?=
 =?us-ascii?Q?/GkI8JnZSu8MX7BweaF23s+LFaEv7BWDL0M4k5+5Hx2enfa51hOAYJDCv18E?=
 =?us-ascii?Q?sXHQpbtjOvhwcV6KItboep9OyZxUARofvM2DYii2ENYI/TffRzmpSP70nGGn?=
 =?us-ascii?Q?mDzedgau4NBL2FLhl7CgL5LN73xI0eibcu+5AZJq/pYFk2ziyFjZRzn36S6D?=
 =?us-ascii?Q?5RNnTObQfMy/zf2KeCQQrPVi45mzhAasMxc23P2ON0ciIAR/cLb2fS2dY2zc?=
 =?us-ascii?Q?ebm/JQIMf1rmrd8Bvv8pR/BdL48sbLadM3S0obZcLm9INxviHFFc4grLlyXj?=
 =?us-ascii?Q?fOQsazloFOEJLuc+GnyI/kmcjk3axREamFvMcdQKXtl1/vD87w7dMSLnyF3t?=
 =?us-ascii?Q?WU2VMjbbu+4GweTiJXD96zFqdJBgrtX9isil+qf45jU39+YQn+NtTRQUlrDS?=
 =?us-ascii?Q?SAgf2wQLkyrSol2Pu3K85wBChIX97qngQU+vUOW8rAkviaBy2I3PV/aLD4FX?=
 =?us-ascii?Q?dHqkonRVAwEEioC9amzYzbtBh+LtouLlKvmXH84vSaPt4l72zGi99WIuo3vz?=
 =?us-ascii?Q?cscJukEzeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h6kh4pxBqLne6BAFLgYCNUo1HBIQJCBsggmQuGYfMrgzJO6h+83YRmGHGBy9GNvcEl06ldlbrby/g+2S3ldCz1X+qmQ/rX7I7M+a+oggJ1tMs17SEjm9wyzqGEocZyVhs83lQBrZZ2/oujhAWVkUlklbZVrmG3XZT46aJhwLhzOgEGskSzEUWqeZChn6evIiCuIJ96Nah3tApfXzIMbYetPI0WUSJ37PhjYx+dyAvSbeQ6SDzsWQgAZl808hwgsUWyjlquCKLQLM2Ypzuwc0vt4JxqJcdVyUEKaobEYiSzH2W9QrB5qWVX7Eg5iu01DxQgq9hrygCHzuMtjC3sIdYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc9852c-dc35-4a5a-66f9-08de962072b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 10:12:04.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gCHRu3+uNBfscqU1Ys1XWGlX08kL/giUM//izUg1Koior3jzDGn3f5yqjFmiGFUX110y/a4cWh+VgVQKMsSvHmWFu3Ytx6ja3v5ZZfR4Da4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7184
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276926-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[IA3PR11MB8985.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,davemloft.net:email,osuosl.org:email,intel.com:dkim,intel.com:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E5A523C9043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Loktionov, Aleksandr
> Sent: Monday, March 16, 2026 12:38 PM
> To: Oros, Petr <poros@redhat.com>; netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> intel-wired-lan@lists.osuosl.org; Keller, Jacob E <jacob.e.keller@intel.c=
om>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David =
S.
> Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN fil=
ter state
> machine race handling
>=20
>=20
>=20
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Petr Oros
> > Sent: Monday, March 16, 2026 11:42 AM
> > To: netdev@vger.kernel.org
> > Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> > <edumazet@google.com>; linux-kernel@vger.kernel.org; Andrew Lunn
> > <andrew+netdev@lunn.ch>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; intel-wired-lan@lists.osuosl.org;
> > Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski
> > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> > <davem@davemloft.net>
> > Subject: [Intel-wired-lan] [PATCH iwl-next 4/4] iavf: harden VLAN
> > filter state machine race handling
> >
> > Address remaining race windows in the VLAN filter state machine that
> > were identified during cross-state analysis of ADD and DEL paths.
> >
> > 1. Add VIRTCHNL_OP_ADD_VLAN to the success completion handler.
> >
> >    The V1 ADD_VLAN opcode had no success handler -- filters sent via
> > V1
> >    stayed in ADDING state permanently.  Add a fallthrough case so V1
> >    filters also transition ADDING -> ACTIVE on PF confirmation.
> >
> >    Critically, add an `if (v_retval) break` guard: the error switch
> >    in iavf_virtchnl_completion() does NOT return after handling
> > errors,
> >    it falls through to the success switch.  Without this guard, a
> >    PF-rejected ADD would incorrectly mark ADDING filters as ACTIVE,
> >    creating a driver/HW mismatch where the driver believes the filter
> >    is installed but the PF never accepted it.
> >
> >    For V2, this is harmless: iavf_vlan_add_reject() in the error
> >    block already kfree'd all ADDING filters, so the success handler
> >    finds nothing to transition.
> >
> > 2. Skip DEL on filters already in REMOVING state.
> >
> >    In iavf_del_vlan(), if a filter is in IAVF_VLAN_REMOVING (DEL
> >    already sent to PF, waiting for response), do not overwrite to
> >    REMOVE and schedule a redundant DEL.  The pending DEL's
> >    completion handler will either kfree the filter (PF confirms)
> >    or revert to ACTIVE (PF rejects).
> >
> >    Without this, the sequence DEL(pending) -> user-del -> second DEL
> >    could result in PF returning an error for the second DEL (filter
> >    already gone), causing the completion handler to incorrectly revert
> >    a deleted filter back to ACTIVE.
> >
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c     | 5 ++++-
> >  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 89e5aae20d5573..1ffc0ce3f35602 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -816,11 +816,14 @@ static void iavf_del_vlan(struct iavf_adapter


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


