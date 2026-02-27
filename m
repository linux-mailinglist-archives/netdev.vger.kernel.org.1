Return-Path: <netdev+bounces-261805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePOrMyVqoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:55:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 710D91B5A16
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D12B43026326
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE823803F8;
	Fri, 27 Feb 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksyTKNei"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158C35A3AE
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186147; cv=fail; b=JyeO0wpZ+EgFFzRSRBt8D7mQH32ONrhBrdtWq8zj3Mh2N4+egmpaxlUg1inTmD4TKmjUBkRHyfMreYXrRT96crZV1VXh9/oSS7iq0XpMrF9dlZMgbC98dpziZtmBSy8Kpxd9RdXSYOsjD6xArz1yXEo+aGYpuudtG5kTELeH9KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186147; c=relaxed/simple;
	bh=HUKdyveMZ5UZgUcKEORZeb9bY80ZG5rzJ3uXaqDKTaY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AOaWQDK7ghmzwAfbmtbLhvflhpFSW4jy9NmP42QXfsjxDLk38+09pDHKtiGWu9BApmo/u5sXwChXBtET2uQ5cZuSClO/YaXb4YOstD9Z9cv2cSN+TzeAVn+dflRh+WgIUEbsTw2QagEt2AItlOdewHK2mQokb9fcA6D3+Y7anRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksyTKNei; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772186144; x=1803722144;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HUKdyveMZ5UZgUcKEORZeb9bY80ZG5rzJ3uXaqDKTaY=;
  b=ksyTKNeiFs+MoI/NPrdHkrVRqcYXHedbPJX0AkchZEkmGr8xeY5Dd4Nb
   CFwyX7sLJVKaoQxriVof9zXKduJMnIf3WbSpayclipYJ/yvlgNfIVZbGs
   WRO7tN43zVHj8mn6XEm7LV5DLb7PkFeo6qrxh1B9A8gt8ZW7+tS0LQDFx
   GLaeZqDuV6Yf7abE0UfOyIsCvbi4d4u99LFIQGSXG7e8wiwxaNgyMRmB0
   FCcEyqApHrnguBFWl3EzJUuPFia+NndaHpo3zEVf1WYdwTujZpG1MzzsO
   HXfPVIJ7f9dWq5iRv866GzhnNBZaVDAZBIwgjXnE2X2xSt0+LU9aTIn7z
   A==;
X-CSE-ConnectionGUID: xtvgMB3aSoyazFzAyorDWA==
X-CSE-MsgGUID: ezcKbbXuRZ+9ZMvbz05yJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73450237"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73450237"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:55:44 -0800
X-CSE-ConnectionGUID: NW/qXCCwSvG9t0FAA+r82A==
X-CSE-MsgGUID: wNVzM3aVRmS86a/3SOc1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="214292469"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 01:55:46 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:55:45 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Feb 2026 01:55:45 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Feb 2026 01:55:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLFQdNiLuXqsWVy9Z64Ep/PLQdEA684VkORX7PFA2nkqsCBXEwgX7R0qfxE+2NDjIaOhVwUZig0daeNKrPCjIoWpLdMgU5Iz1ozsyZe0yyUchmE0FL9GBGr/zYTu+DBeAQ8AXX/0DhZZOm6EFw8wSYYB7foox2kWwOg8icxYC2DY3oxtvSbA9NWJL5TOACWWIC0qVUFHwubeSbGb7BCkZ2WepucAFLwNNmuOnOtKN9WLcWAEBhWyEJlt+yc7IySwSI2cmsEA/MSw3sqPv2jtW4WSDEioKWUKkYazeMMLHFBhPYEF9U5SWs6H54Cte2C/zLT9VCxgWxSnyVen0tAzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUKdyveMZ5UZgUcKEORZeb9bY80ZG5rzJ3uXaqDKTaY=;
 b=eALFl+DUUK4WZOvhQigrzotSbFYH0fYPivNQgnKMiSmbkqvPtwAxITVAl171JLzSak1L5o+byPsHgYx4eDpnqMZ4RdhvFuYkBtHBoOQs9s9SdpKUvBBEEBJPGKMcvi7SL2sOK/uLzoiGlO73WFnxxVEUZTLprzeJwHRIT2hxiQp4qjZrk465hEPgYdlPkZOoSKKP3O+SwlfbYuvUCpIY8A+jELh+yio7mNH5ywuw6BSCbmyUz4Yeklb++2yShXd2QMwjBI9BuaFm2mMygEqM9Y8OhdM9kX6EHVj5KSYOFB7YMudooJ+Ie4qoZJQJr6E66A7xOQuhxZ4apeUYg9g2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 09:55:37 +0000
Received: from CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee]) by CY5PR11MB6258.namprd11.prod.outlook.com
 ([fe80::3aeb:4e49:6de6:9ee%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:55:37 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Takashi Kozu <takkozu@amazon.com>, "horms@kernel.org" <horms@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "pmenzel@molgen.mpg.de"
	<pmenzel@molgen.mpg.de>, "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"enjuk@amazon.com" <enjuk@amazon.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 3/3] igb: allow configuring
 RSS key via ethtool set_rxfh
Thread-Index: AQHclQx+q82AFEDfwEiX3adA/xRlxrWWarMg
Date: Fri, 27 Feb 2026 09:55:37 +0000
Message-ID: <CY5PR11MB625810BD6BA76352434032DF8B73A@CY5PR11MB6258.namprd11.prod.outlook.com>
References: <20260203125417.37285-5-takkozu@amazon.com>
 <20260203125417.37285-8-takkozu@amazon.com>
In-Reply-To: <20260203125417.37285-8-takkozu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6258:EE_|IA0PR11MB8333:EE_
x-ms-office365-filtering-correlation-id: c1954884-f117-46ed-05bb-08de75e65bbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: CPd+Z5Q2np/dmioQFWIvZ6iJJX+SYVe8kfZDCRJB25cUQH8i6LanQkMvKQV+t7OcZHjvZfvYJXDMYY2Rhhk9BUuqVojTdutUvht2ts5zRD2V4w6Yf52eNLrS+VDR8mBSoAbctCDMQvVY2KCAS0BCiTR6hcep1FEU57tef9g3zKnKbPttLUhOD3d8H/+jqGs/NX2blOCuuIp5GJ4oL/58ptZNxff8UmDV7NkmQsh0JxDVpDGl4ZOidwIP329pIRssPxGjpWk5F5RoC9VfBJ81xxtETA/+7/x+AFygYlFkExsSN0AZVmTRlp9rD+QuUlaO23nnRW+Dck2w9nBYJ72FxY0Yxsy3RPcv9nQs1mA73UnsBx+A3CbtAZ8Y9e2Jwmh37Bkqka31sWCe5bw+B3Scg3prB5JjgEvLWNoC6jN8h3DKdxgwVB7l22hserPXPzAo0MuijnncnbfwDIQ6ntu3kjtfjwIgNMT+UD9MLgajRATTUTx6jRif6ll9/+2DHLcKip3km16sBA8DNlEqCTBAIQXr7/Jb105tvRmi0L9cbs3OHYe5QlfCCrFpx384h6pO4QHxo5xSt3JfiQdGCIeq37g/xhBXhYOazh7K63sndTYWcfUf1WqJiVsd8jxDzkIS3x0fB0xIJNkK+5/VSzYdJYGp2mwhsLAzFmHhp3SK3gVNqYkfGP4gkyuevKGOXa7zkfiqIRWemaR+l8bckaEsPM6Bu1pso8/JFEBTJJaLH4FyAVMKXEL1zvNEMi2dGLB7q5rjdEvDzGSxL9q5ZGXRE1sIvCyojg8kF9huDHrHARk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6258.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a0K0sqR1a+yaVLWyJ6HwvEUP80EgFchfNDw5eWpg56byJ+S++Xgox/u4qEv2?=
 =?us-ascii?Q?a5wHun+OZQ68/fb0nlIK4y0RiMT9uZ7jWtxyJXfYzXP8W1R61qMPhrIIhOLz?=
 =?us-ascii?Q?SPV5Jw0do7ZFad2l9j8OoM2GDvUyBWXLYCA6jYCKnLxPjKdRTJxunWfXl+6x?=
 =?us-ascii?Q?5Bj7tCkMCTbK90eSxHCO7+Z+/MfypIWkFvU74YiAKNDAflm6bkt6M9p1qcE9?=
 =?us-ascii?Q?IoWV2t0kKCYu6rFUE/gxLHcG7EfhwwRlpxIy6T6ISc5Rb5w4iney69kS+xNP?=
 =?us-ascii?Q?seeDrwOdUDwEcsxGVAk4ynNc+02/bq3sm9GVofluf9zZmPpKHBL6jiFFD6pC?=
 =?us-ascii?Q?j70d8Dp8XmiIOICd4K7sRTBgtJQnRK4C1UfVDJNlAat92BTDY5Jf0bmehmx8?=
 =?us-ascii?Q?Zmzas2ipF2ojEYw17Jx6UFyWv9IvJqtixai9oT7IBUyvBkLxXYO1qxxcpMkh?=
 =?us-ascii?Q?ZketgZ+lTEgQC0Tt1DKX6GxdqoRjMcTYRuafnKDhIAdmiiFpOXICTz8Dpbsu?=
 =?us-ascii?Q?ddvGj2fbk6QofR7ajPm8s7b2w3mUrtMlZ8LVXKNbRyKk9SQHrbn3ioCdEHmn?=
 =?us-ascii?Q?7ZoIT3kBNbnfzqmWAJQ60eXBVvBU+rxJpcLsb5ksOkMTtyJbBA4Kkbfuoz30?=
 =?us-ascii?Q?ztjA3eXAH0C0+v5HW834G0DyzE9GhoHWYgiGA4y1BEuhIPXvCEIwuMYOBrOZ?=
 =?us-ascii?Q?LDYWKo+YaifIu3RDV98jpQvQGlTsQMFvHCY/YgdtYpaoyoUgiaktX729NFP/?=
 =?us-ascii?Q?xQcS9H1L7zGeyD5tUMQxNdJWQ8ByR16KggE0Y76tp1t5JTKLdS9MqCJ1srqo?=
 =?us-ascii?Q?00fcqu0djuVpIMKJsW3X0996vXc48IL3kWHOmU9Zf+S+V2CzoTl+3LVMMlzM?=
 =?us-ascii?Q?YTaf2cVknbBeP26j3NuCauMaWIlQpa7fkS/9aXBDaZKKIGTMcGIKMr0mwCwj?=
 =?us-ascii?Q?ZX3EwJ7v/FGxYTrbutOM1cDY2poj/+ziHsdV35kQ1WEIj1mWpAOxlpC1QV8U?=
 =?us-ascii?Q?dHuCAaWuliMedTCOAz3udc8Up5+2O0K9TGZOMh76iQPKDst+raVWQ2oyAOA7?=
 =?us-ascii?Q?Vv99zzrnJSMB/mhXS5LmuFC92rT+cRvpDJrmj0kPlpttz43WmxI29TvLRBbd?=
 =?us-ascii?Q?c7ST07QTFlBa4KOT30T5WX+xZUvjidj3v9MNQtSp1kjxR4cMsQzQsAt8zXUH?=
 =?us-ascii?Q?0fErT3zb59uaWnM4PQaBEIXAW/r8U2zMGhZ/fIHVIOpesB8qDFs+xWLUAj2K?=
 =?us-ascii?Q?XTy4ywdPGOeprFnZOEUqvGcAeX2Th8oCBumsUllXZz57T2ge8FbIGxpBIm0u?=
 =?us-ascii?Q?oNLUzXJ7j2EbGoj5K3xwVYxRf/aCj02uOWFQVXdsRkzhDJRbFnd/tv4MadkE?=
 =?us-ascii?Q?diAoYHY79iPe3sXJKHI9wyMPFDbaIs5FZgKXymmZa/glM2/ZTiu2kwGZDnw1?=
 =?us-ascii?Q?sTpoCanoqVW5iXStRq87o4rYDsOSAIWzFoz10nJnqaXLARLkr0/RICCZ+RNx?=
 =?us-ascii?Q?L4ChyRIJQoq07iil0nVBONWBsOnM30xb5G4sMEifZvnODQZBbG9rzzg9yV+8?=
 =?us-ascii?Q?XtrYhb/sHTml/HS436wQwt4YA9IbyXj0kLUHhnwtXZFaQFt4H2jQvZPJhnNb?=
 =?us-ascii?Q?jT7+8/rN1M7UQZQ/4CPk3AxHlnAbCHzta6fDwu4gTr//YaFj9Pp0sTj+Jf38?=
 =?us-ascii?Q?qdfeUvwwktlf9NZ612M0fugB0Ictm4+ySR2qxK3MZnu6mFtI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6258.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1954884-f117-46ed-05bb-08de75e65bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:55:37.4867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQZXJUks57YwTJcGkvaF89W835Y3P7R+1NKP+xCvC5H641L7u+c5QUVjSAWkIiby+pzCprhyibH/Fhh9krbcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261805-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 710D91B5A16
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
akashi Kozu
> Sent: 03 February 2026 18:24
> To: horms@kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@li=
sts.osuosl.org; netdev@vger.kernel.org; Loktionov, Aleksandr <aleksandr.lok=
tionov@intel.com>; pmenzel@molgen.mpg.de; Kwapulinski, Piotr <piotr.kwapuli=
nski@intel.com>; enjuk@amazon.com; Takashi Kozu <takkozu@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 3/3] igb: allow configuring=
 RSS key via ethtool set_rxfh
>
> Change igb_set_rxfh() to accept and save a userspace-provided RSS key. Wh=
en a key is provided, store it in the adapter and write the
> E1000 registers accordingly.
>
> This can be tested using `ethtool -X <dev> hkey <key>`.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Takashi Kozu <takkozu@amazon.com>
> ---
> drivers/net/ethernet/intel/igb/igb_ethtool.c | 48 +++++++++++---------
> 1 file changed, 26 insertions(+), 22 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

