Return-Path: <netdev+bounces-305848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pwKcKN5bTmoDLQIAu9opvQ
	(envelope-from <netdev+bounces-305848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:17:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEBF72736A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:17:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eWizIhos;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305848-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305848-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE6F3022918
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72352F49FD;
	Wed,  8 Jul 2026 14:11:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C640BCDE
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 14:11:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519867; cv=fail; b=hV3L7TEbzXfFHJ1ZxB+dhNBEPkWgWr8zK3dHiwI4Sw62FKrLmnO/F+EWqnnE0u93Z3d3IYPEx1e4xEE2zDavIBi9tcW7/3CCoMuAZ3n7dqhflYbK1cSbJzOIXt7RagwvcQj96yc3nTmvfx4IQK4t3N3knCKhFOz8p/hp//X0MbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519867; c=relaxed/simple;
	bh=v3LM7bV1ropt6OrG2d/Dx7zSihV6kvQcvrWWaGBh+Cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JDx1E6zVFyrafAal9r8CSJDk722gCYgnSx/UkkwPNuDd6wFojM/qfqECRdQ6nnU7GW2jnGniTSsaBXxLQb0Q2BkaQF/qtxoLdtnKPU06c96Fy1g3gY/U7mzpsRpgIwP5IJZiyWozCFk7/nef9Pd4tdRNP0YA3c+O9fXpRA2j+x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWizIhos; arc=fail smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783519866; x=1815055866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v3LM7bV1ropt6OrG2d/Dx7zSihV6kvQcvrWWaGBh+Cg=;
  b=eWizIhosVFPhoU94RJZb4/bIQ5Vdy0L1HaXb32r49i6SYoZVYGNXM1To
   INjDLzFuE5UnpJZZwmG0S2Tlw3soRzS/dNJhnMc3v4dzBgpXs9ce/GddM
   r5O5WYhWuncWSsCmp6hWxAerTDAb5BZIugunCzygnMhMhKRBNFj1JgsPS
   M62elN8mouXOQQGjrrvFHN2mXrWVfBYhxVhRu7J+a5HVrv6dUWrvMcImd
   1OmB2Dd9LldpZXG2IlTNSc9toHCFAKAqzacFQQk0hgYSiw93XVe8HwOmM
   b+v02MFRfBTA5cr283sqmk6dAuflojZPXo7jgR5sWHGAAuhbE+JWynJbk
   A==;
X-CSE-ConnectionGUID: 4ggI3LtiTra+E4nKiQIdpQ==
X-CSE-MsgGUID: rSiWW3KHSiuM6RfRVFVimg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83294598"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83294598"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:11:05 -0700
X-CSE-ConnectionGUID: zz1m0G5TRZ6ZEKGga+OR1Q==
X-CSE-MsgGUID: qInFZP+TR/iB0QJ4Fqb/FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250941714"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 07:11:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 07:11:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 07:11:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 07:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGigl65MAVx6PMO2bYS9Ayxt3MOElFCQwi7Kaf1NPViO6KYrfZHazR0lyIh1564eWgbfkB9+F7IylmLjC7/nlIxF5N+3rzelIYnZ3m8SrNgeby+9VA+/VBp3i9T07SgLVz8cmiq4AW0xwpaeb3EydRkkoSE1Ahice0YHQm8guMCpVQ6XjjqitcPIMZygknCIvKB+B6ASkssYC7fKbJTdFKIAqProBIhxUZwfHwgOofAKGcPm9mxUdQY6g/CPtCYDccaDRP6iFK12QlHZ8bNs1oj9Gav8jqJVc6w6Fcbc4obLUo1jGoiT6Lug/CMG158fivu75eRL8yyy1/cmxkANug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h99VOwt9ULPkWQvpa/P9UpQpA4rnbWZ487YH9sr8glQ=;
 b=ys4dCOQGjCL6ZX1hce2SM+2wdpdie8KgPttyu7mm3HsIgCDFFAiqhv8zi1Qaz5bmmtgrPq3lLCTZeOi9X8lpT27OnP4l50v1B71V+j2xO1mTxMLr5fndoAVyQy3iAa9er0YwGSVN4ehtSqIBvcofGjaOD8VvVVK9z59RGDvwq7ArsjgRqUOqfmCzFSWtig6Ae7nuSMbCSwLFYc65N+5Un1NjHOZE0V25n3TMHgbV9MiCWWnq4R88zPLpYnbYXnb+/QhTyGbb9qUWVQIhHwv6ayyvX+a8Wua9okMKApXs05welbQhN4guLC5JzjcSsXixiVSb+KD5DSANcFgyAYFklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSVPR11MB9577.namprd11.prod.outlook.com (2603:10b6:8:388::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 14:11:01 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 14:11:01 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [PATCH iwl-net v2 1/2] ice: move ice_vsi_realloc_stat_arrays() up
Thread-Topic: [PATCH iwl-net v2 1/2] ice: move ice_vsi_realloc_stat_arrays()
 up
Thread-Index: AQHdDZuatrSYQyGKCkaWFw+OvX5slbZjq+pg
Date: Wed, 8 Jul 2026 14:11:01 +0000
Message-ID: <IA3PR11MB8986D3C36467475D7EA84F1BE5FF2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSVPR11MB9577:EE_
x-ms-office365-filtering-correlation-id: 02284a35-5334-4116-ba65-08dedcfabd83
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: vDxzApQeJ90PO2u+d1sdYwIwzljzi/TXsq32ywDpth7vsDthAx1O8f5SrXVBkbAedhki8SobZUwSF29k9BlwKo+oeqKRzpEMkyTYKrkWBKl3+FdPgPDZJVhX14SliKdeEb0BBhNouVza0/8KnTITXE/UQ4/OWSXIei6H5kiukQ74cX0Cj/r40iLxdlA2ddqHxyVANfuW7sM4lpgBazQeQcOgkogESlvRraFEm+AH9BCGbeabWibpIIWelDFBvPKJHYlM/65dFjwnlLt3RFPTvZmQ9qEz3PH9tnRP4rIIIShkgOWcO82tStY1m3EAyY+bv7ZzTw2BEYDvQP7acgvOYhHl+TkYqh0i4FEKoz8ZkfKpo8FsHPcKBgORKBZMMUu0k+eh3sBp0cyf7ivzqqMaRaTqCM6lOz7OQXNdTOYxUFiSxS6GTiS1s+SnrX+I9hKdYACc3y5geQd1E8uJmPe3+ZrsP3Tb1RSwpgNi+Frobdv+spDGQDcbQhIv8NcTBkE6pAZK6DA/oDsgRMys0TFAR+vF0pqmNjveXKFuOxCjyWjXncCoOL4M44ykn+y67YNN45/Uyk3y7ZiMFuWwvL9ChNe0utcblC9u9pBbWhgi2D3RsnPNheUfiJ6kSLCyBCuQgTJ1CpKg27lC9vsYbdoNI6yfkVNuSyjNwagKTNWSoktR5+YkDAQEsgD/4tTRT7nwATe78cvKaFVZo2q6lAkuNgz0Nsct/thUoEy1JN1HEU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9TQZ03tav3ypRgCxrOF8DNL3SStycIT74A7kwmZXwbeggzSTiCscJujyGPFp?=
 =?us-ascii?Q?Kir+JawbUyL7KNX191L4FdaYEyr9QTf2C5qQyCkFB9d+qkHyk6QqQ02wzzJj?=
 =?us-ascii?Q?IojOH8WAuEg0XSWjkQg4csXUsC4gxOBI43G6uNz343Ax344bg79dnXaEnopT?=
 =?us-ascii?Q?P1wgrFmCRXDRavDkbVrHMXfRtyRgSvlLwTJxaznYVnjzuREebrZoaXA8LZB1?=
 =?us-ascii?Q?ZUUvkSclIJDQcqfCGkBQb/EmQri8qpvBjUm/TvPzbztuUsRxmHJVnW+w5mm7?=
 =?us-ascii?Q?j6RE3XiwRmS1MzK285y5ZwmuGdWF8vfkrf6JvBBPcKf4Os6k+sRc5MKLq88E?=
 =?us-ascii?Q?NZZBeomRY2bUiswzqWmg++7lOe0i6SdmU7gDrad4htyGU3XdjPW1ODBTvfzn?=
 =?us-ascii?Q?7SJFn/yZ8bwJTtE920clbySTP4UHo6OjdbXFpCfc0fliVfg0IeNJsTb5BV+y?=
 =?us-ascii?Q?4pQv96tQJro/vJxg3SVXxCM00lCAsApsDjzeWl6MAIYZJF03NuBcFosDqe4D?=
 =?us-ascii?Q?XmHrAowPuKtzIB7kwOjaH13nyjAvccpiwwszHZaREOVOcY03dKi0dfKJOdKt?=
 =?us-ascii?Q?h7sFGyrnVXTxuTbfrdCiZX5iuUJGMbwuytLJ/RydKjRSv1XIt4W5KaA9JY4p?=
 =?us-ascii?Q?afx3k76SDqiI5y3TNrqFXDgT7oBCt+rEKhcX7TENmEcJWxk6RHFs8G6mVeGI?=
 =?us-ascii?Q?X6ujk5Q6qz1XAgX2oV8OSZQpR+G8INZMH13eAvIN7BjoW4ZybE6dBZQjajnT?=
 =?us-ascii?Q?1xjq/jyLVZl6fBwqhyZ2LMLsu3adcWV9x/vHU/0BhDnMv1BLd2M3NUbUJehE?=
 =?us-ascii?Q?2T2uUhYMP/UF4c0tVPMwuokhaKYxLNjqn9oOiSDPMsEOKd4NABDghQnILVRx?=
 =?us-ascii?Q?kHF5aJ7uOofPk8/iSK+JIdJKNo9PUgFcBUVTBHbddlOK8M1SaToN88Oaa+ty?=
 =?us-ascii?Q?ps61XpJXL8WOi6Ev0XSWThyw6o06s1F04g39Tau6h8HjQZnjdrocC8eQCje1?=
 =?us-ascii?Q?59kF4vd2N2XnUs2lSEBjxYgoy3/sT+a6e2VMkXpYTTXm85Nz6n5JPP9+CMVi?=
 =?us-ascii?Q?0Owz6CMbMVI+H+rAPvE8igyvgFRgArWFo6kwe7093OtAARWFO2Zy3/BHTFkl?=
 =?us-ascii?Q?DEb1HXFiK45i+OD1SnJD7rq7xjN4WwuuDnlEMqztDiX04CF8atHDA1h36gdD?=
 =?us-ascii?Q?7iaMTvOcwX99y3EalseHS0E5XlfHfHFXDH8trkvC6XL3fAmgqBkmzUiPhQyg?=
 =?us-ascii?Q?6svpsIDbRix3AG95bHJj0SX50moThC6SYmtnMtLTRRfCeve+KA49NP9QWWWq?=
 =?us-ascii?Q?IyIBZ17gAj91hL+CXRvGiPHiJ+w4tdKqA8TLrJZS5YkcYDVOT1UN6yv6HKAg?=
 =?us-ascii?Q?QgWaGg6Vo12tSbB96o8N3y9RRQE93ZDVJXIRvHXelleXxD2H/9CcoE8+8brh?=
 =?us-ascii?Q?g427G1D2692d8k/ufsff0LMFYYHhP7kVSnNWRR5pSOHRVY/1SNsycu0hzbLf?=
 =?us-ascii?Q?8tpDQRIQo8IBe6Kv85Q1k3qXxacoBIoo4YoXhNn8u+s5s7Q6S5fvar36UwFn?=
 =?us-ascii?Q?hnrdS/5qk1eSBXVdQuFlDpCwEEVWCU/B8JMPA65kKCf83u1oi6te4hc6Vs6g?=
 =?us-ascii?Q?V/dsjJQGAT00Cnn7FaqT3gvOR3q7YFKS2OOe8+jBJT8YXH5NF1UVNNqJcVzy?=
 =?us-ascii?Q?B2E9pWwlv6kzdPjfG02SIuR9Q+Xa4AgSrRimre7+ALuwqZcoM6G6a004FiQA?=
 =?us-ascii?Q?R3loVNhGGa9Va1wG3CIsT7SdBrgswgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OAW4xwHHaogwQWteC9cHm/tXZ6Lhveck+iheWGfQNICidYPPmUgYFuRI3wJhzDby5DAyQaGr0f0dsSwPMj5MmZhkZ4JbDG4+T89qCgNC3JqJyGGnwRXlc1fbC8jW/IKT0BWn9bjJDhjh92ynQKh490l5Dox+FmsvFLwrY5eRLw7hESiYPsgEcdXHuS6eU0C4thGXUrraplm2IhPglV7Zul2Jse6fIYTd/t8Bh32EaAm6pqAN1rAXRmectSoGWO/XPx3+Mt2jTOMVhcOCVVR88O7mmlaOiMnCuFKNbi3ZljGieYNfM3m3ICrSmlJMmyCiYssttSGo5ZFtqI7uqDcLJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02284a35-5334-4116-ba65-08dedcfabd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 14:11:01.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1uUk9Qu442yYYXIp253wkZC/Cx7yyTxcNYWdIcdNLGpTzeU6Luy9b4gau4ryDL/juuPoqxw1ztVfwdWD1GC9Xt8hIIMqqDGMQW2Ht6XAy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9577
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305848-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:mschmidt@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jedrzej.jagielski@intel.com,m:piotr.kwapulinski@intel.com,m:marcin.szycik@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EEBF72736A



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Tuesday, July 7, 2026 12:44 AM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [PATCH iwl-net v2 1/2] ice: move
> ice_vsi_realloc_stat_arrays() up
>=20
> Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
> ice_vsi_cfg_def() by the next commit.
>=20
> Fix kdoc for touched code. One line break removed, "int i" scope
> minimized to the loop, no changes otherwise.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: no changes
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 119 +++++++++++-----------
> -
>  1 file changed, 59 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8cdc4fda89e9..e48ee5940f17 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2303,6 +2303,65 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf
> *pf, struct ice_vsi *vsi)
>  	return 0;
>  }
>=20
> +/**
> + * ice_vsi_realloc_stat_arrays - Frees unused stat structures or
> alloc
> +new ones
> + * @vsi: VSI pointer
> + * Return: 0 on success or -ENOMEM on allocation failure.
> + */
> +static int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi) {
> +	u16 req_txq =3D vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> +	u16 req_rxq =3D vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
> +	struct ice_ring_stats **tx_ring_stats;
> +	struct ice_ring_stats **rx_ring_stats;
> +	struct ice_vsi_stats *vsi_stat;
> +	struct ice_pf *pf =3D vsi->back;
> +	u16 prev_txq =3D vsi->alloc_txq;
> +	u16 prev_rxq =3D vsi->alloc_rxq;
> +
> +	vsi_stat =3D pf->vsi_stats[vsi->idx];
> +
> +	if (req_txq < prev_txq) {
> +		for (int i =3D req_txq; i < prev_txq; i++) {
> +			if (vsi_stat->tx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->tx_ring_stats[i],
> NULL);
> +			}
> +		}
> +	}
> +
> +	tx_ring_stats =3D vsi_stat->tx_ring_stats;
> +	vsi_stat->tx_ring_stats =3D
> +		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
> +			       sizeof(*vsi_stat->tx_ring_stats),
> +			       GFP_KERNEL | __GFP_ZERO);
> +	if (!vsi_stat->tx_ring_stats) {
> +		vsi_stat->tx_ring_stats =3D tx_ring_stats;
> +		return -ENOMEM;
> +	}
> +
> +	if (req_rxq < prev_rxq) {
> +		for (int i =3D req_rxq; i < prev_rxq; i++) {
> +			if (vsi_stat->rx_ring_stats[i]) {
> +				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> +				WRITE_ONCE(vsi_stat->rx_ring_stats[i],
> NULL);
> +			}
> +		}
> +	}
> +
> +	rx_ring_stats =3D vsi_stat->rx_ring_stats;
> +	vsi_stat->rx_ring_stats =3D
> +		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
> +			       sizeof(*vsi_stat->rx_ring_stats),
> +			       GFP_KERNEL | __GFP_ZERO);
> +	if (!vsi_stat->rx_ring_stats) {
> +		vsi_stat->rx_ring_stats =3D rx_ring_stats;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_vsi_cfg_def - configure default VSI based on the type
>   * @vsi: pointer to VSI
> @@ -3011,66 +3070,6 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi
> *vsi,
>  	}
>  }
>=20
> -/**
> - * ice_vsi_realloc_stat_arrays - Frees unused stat structures or
> alloc new ones
> - * @vsi: VSI pointer
> - */
> -static int
> -ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi) -{
> -	u16 req_txq =3D vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> -	u16 req_rxq =3D vsi->req_rxq ? vsi->req_rxq : vsi->alloc_rxq;
> -	struct ice_ring_stats **tx_ring_stats;
> -	struct ice_ring_stats **rx_ring_stats;
> -	struct ice_vsi_stats *vsi_stat;
> -	struct ice_pf *pf =3D vsi->back;
> -	u16 prev_txq =3D vsi->alloc_txq;
> -	u16 prev_rxq =3D vsi->alloc_rxq;
> -	int i;
> -
> -	vsi_stat =3D pf->vsi_stats[vsi->idx];
> -
> -	if (req_txq < prev_txq) {
> -		for (i =3D req_txq; i < prev_txq; i++) {
> -			if (vsi_stat->tx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->tx_ring_stats[i],
> NULL);
> -			}
> -		}
> -	}
> -
> -	tx_ring_stats =3D vsi_stat->tx_ring_stats;
> -	vsi_stat->tx_ring_stats =3D
> -		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
> -			       sizeof(*vsi_stat->tx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->tx_ring_stats) {
> -		vsi_stat->tx_ring_stats =3D tx_ring_stats;
> -		return -ENOMEM;
> -	}
> -
> -	if (req_rxq < prev_rxq) {
> -		for (i =3D req_rxq; i < prev_rxq; i++) {
> -			if (vsi_stat->rx_ring_stats[i]) {
> -				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
> -				WRITE_ONCE(vsi_stat->rx_ring_stats[i],
> NULL);
> -			}
> -		}
> -	}
> -
> -	rx_ring_stats =3D vsi_stat->rx_ring_stats;
> -	vsi_stat->rx_ring_stats =3D
> -		krealloc_array(vsi_stat->rx_ring_stats, req_rxq,
> -			       sizeof(*vsi_stat->rx_ring_stats),
> -			       GFP_KERNEL | __GFP_ZERO);
> -	if (!vsi_stat->rx_ring_stats) {
> -		vsi_stat->rx_ring_stats =3D rx_ring_stats;
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * ice_vsi_rebuild - Rebuild VSI after reset
>   * @vsi: VSI to be rebuild
> --
> 2.54.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

