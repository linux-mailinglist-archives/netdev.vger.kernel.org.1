Return-Path: <netdev+bounces-293180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB5PFw7TGWodzQgAu9opvQ
	(envelope-from <netdev+bounces-293180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:55:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125A606E55
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F6ED300BCB5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF61390990;
	Fri, 29 May 2026 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0oqMV5f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92C390222
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076511; cv=fail; b=iFs6a2kQzesRlLwc8I7ZfycsEhwCVffLdYeAVahmJSbNpjNrxRJ8WxBDsPV+qR6gejjaO/L3ZUl0BLXwL5IApPUB118vpU5LE6rGXaDKsKddp8yTX7gVJwzBL/FdwKT7mXwjyPFlGBgs7Y4DyK7cD+fp3ubQ91D0pMRo6kng8Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076511; c=relaxed/simple;
	bh=zhQ4ssFnbmWnYLRdsWcC6DYgWOr2RrACUNUNJ7X6TSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSB2jrz3Py+oOYnEiLttmdw+g19GKTE8osm9RWgedW0UGWacOWBLAE6Kxev925Vl+VyBRO1whTgSsJlGMrXxXc4A3fhJhTMSRTNBJdP0EM5So882tPMwF67qO3kdMzcMIERs0QRYEj/WqpccvaY9k5OkUrgJmd1a78JGzvsKxec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0oqMV5f; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780076510; x=1811612510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zhQ4ssFnbmWnYLRdsWcC6DYgWOr2RrACUNUNJ7X6TSw=;
  b=m0oqMV5f7lqJ+ifnHgsUGiCBKpbXio+Gp7GlpUZLq0mQbMSTQlaHyOx4
   kEMZITFu6FZG2GXtK2daXHM2clfXg9XBq/Dnxfn28uFKT/YfjwPLzifJB
   x4lmtLxiRy6fGsHZnhErbm22Zs5h3oZqk8VdgIlmOV3e3RhQ4olb+ts23
   Upj1iCqvGqrGsLYi/MyTd4rudZAtlhiStHPSCuiLU5asP+xzUgb8ouRur
   DFkr/2engiIE3IKI743aMOlY/NycSrl6NTVkd/zLUyZIiOyA8h208e8Zo
   IhAKvjI57CYDRyt4ugHV91WuA0+FN66QFaeQaRVE+ySTUQR1hTV2XNDy+
   w==;
X-CSE-ConnectionGUID: 5Z31Ad7/RTWCMqSprNzA9g==
X-CSE-MsgGUID: SecDNvcbRf2fdowmuHMJag==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91506607"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="91506607"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:41:50 -0700
X-CSE-ConnectionGUID: 6NzjDmG7QOqY0Eg3tgw9jA==
X-CSE-MsgGUID: XCzHO5HsSd+CKp/wjeUvFg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 10:41:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:41:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 10:41:48 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 10:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4FgGrgDBawroL0jyAi5iYCkXsNnZ2VyThb5TGg5A0p3iIKvNhKwpjvwAHhXQPoWJlhxQEIXTovpdLAm+Gei3Lt8OQp6JxdCl/zoc+DYNJJ7qif+nFIptVsjVMlnm+8NYCeK5Lu4bIRE5OE7WgZmO1WiMzsnTjx6oTVdTQvRyd2RFH18h5HuKowAt7ILlfbnSJW4+gRolYkaY7C8GQULMnxLoRUJqT7U5yXzNORLcvl4+0947DsTAjUrIk+tvyPOCZpCcv9BNAPuKBLst2lYTGxqVqzFNiN51oUqyq4ihGrB+kc0q0QwJ/DBliKGz0ggOu+pyDK51u7h5tJCGJBVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IvHbfp4mbBWs1hnRcip+/fnh4Fc9U4QUv4wkkmoE3c=;
 b=tEPmgCaABmrx2cL+lS1sHyLjqx1QlhRBmG0cvTWWQgmxJTt2l17ZEQkF8sknmUtJdT3FwZuB1zb/qznIlfVVAElwGPw+Bp9m3AeYJbIL0tDuitDQSsMRoFJApnXUUbxLM2dJduS/KRcKuyt8KhbDPfZASpxt1WiFg6G7oJDmE0UIfWt7/hZaE7K8CZh53rHt04++sVdUgx1of1qBEGCwa87i4yNpbKx2EOZw6F+idPe2QwmzM3O+GkCRLDLkYciQdZgKKKLB/inAEG7LLVUb3j44bzPtL1rVbKhEtecu9TZ7SVuhj1C3C5c2n7ekXwB4Ig4xramDTz9AwxHURwO8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by EAYPR11MB9561.namprd11.prod.outlook.com (2603:10b6:303:2be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 17:41:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:41:46 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Cao, Chinh T"
	<chinh.t.cao@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 03/10] ice: initialize ACL
 scenario
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 03/10] ice: initialize ACL
 scenario
Thread-Index: AQHc6SB03xVJT+Ia8EC+sdH+swqeNrYlUlYQ
Date: Fri, 29 May 2026 17:41:46 +0000
Message-ID: <LV1PR11MB87906728B0D2C0134EE67E9E90162@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
 <20260521115000.4637-4-marcin.szycik@linux.intel.com>
In-Reply-To: <20260521115000.4637-4-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|EAYPR11MB9561:EE_
x-ms-office365-filtering-correlation-id: 96253554-77e2-41ca-dba0-08debda98e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|38070700021|18002099003|22082099003|6133799003|11063799006|56012099006;
x-microsoft-antispam-message-info: vIF3+FXHEdPiqgZ+zvt2gdg4U9tfMAgpJyWqJ6i+w0hFgMGrN2w+u+nGbeqPeyqTZvNacH2srZwh3IR2sp4tfEmMyoPGdSdNb0Ar1w/rXJ+q9lbO+QeFRxD2inTSmw9vMbyIsNORKqcYiVuefHyv5N9dCegWV8yYw+UYRI1zj035UpJ4MXxpmR24iMHTq/Ay1CbxP777+8ZLFiPyRIoZWbvTGuwddqLICBNGV3nkE0MjtqlUo+8kKjc4y10cc42g9BMT9fHylCkjemUf2veigAeAju6WFwnSNn6+sw4Va9+z8+kE8MwVKz0GnxGlRTzmKJ1DtbFLV5KfDvdb9fHscZmhyCH7vktNOUEY6efsSNX3FcM5/D303K5kBq49jwEbW3P2yOFn4W8ZlD9sDyjYMXNe+mFlekyC2ySZELBnM6KdKVKjnzFXiQT+ImD5IlDXcKdDzcdPfNhOD300Crm1QOVV8lz+n3XF2iItiKHCJxCd+jg6XT6l/JyUvNtOdzacUjH/P4TWYMumit2lSO/sL/UJOy+fRSDaUKiTP4Bbt8C7LMrCvHsZAQwwvQgH5+f63858MApwwWhEE42AHCZmeLei2M6VSqQ9q2TLlO5RHhjRrHNLPMrkHv32ND6dBNpcSXI/1K1tmH/i2W91PxrqBK26mIhOZogGZycxCMvRbou10wFiwE8grx1tHqckyTJ6fYv8ORWiQ+mwjiT4e5iwQ3fXiCdzxlsX4/uH36/hqaQi7yvNz+B1TYuZsRq1jAve
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(38070700021)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hCepmaHK1MF28JIzjaIH79vVABiBg+/Ju1MhmbUZnNsK5DCYD2OR+Y0bEvPj?=
 =?us-ascii?Q?hqvsIAOI+J4PCb1rodcUovY+nA7vJitsaVy1XnqPE6vG1mutz+UxtvWfVwmH?=
 =?us-ascii?Q?926H+K5cBeKMRWfkBrOhHgWYzTLiDYnAeq8Mh9z2yNh8xd0cznulaRLx2uOd?=
 =?us-ascii?Q?TxrLAAB1PGNZG6MTn8qqve7JnCkU2+nb25RtOAe+Gk4UgLgZMqPKuCC1MROR?=
 =?us-ascii?Q?1oGDCKWy5uyPkzanBpPvZDO2HXP+Wt7g5YJeVJmiLM++ab7lKRuhzVFpbjJB?=
 =?us-ascii?Q?EKFl1AYC4TECMChyJv1pm3wwB2WHik407KLarTKZgbkwIvzaKxarQ7sfNsZ3?=
 =?us-ascii?Q?n3uLteA7lWaHXQEatAw6u6Qdtzuh3G/5C60XUAHsBTrTXj5O/BxQnCa07BjW?=
 =?us-ascii?Q?eiWPYWcCqY+q+g0LQIitDS9KijgSFGToBRMqlvBCgkxfTKAjN/QYvC4FjYEy?=
 =?us-ascii?Q?HUR8tQ2eeUt5WEi12L3G/WnzP2vU604aFXUdIZz3UG+fBn1hwuZs2eJ8dIRf?=
 =?us-ascii?Q?4dKqjtd3/buuu9z+GOjondvwX6gA1khVjNCJwnarun0XfBJaBv6fVqfNIREJ?=
 =?us-ascii?Q?RrGzon3li1u5WiuHk0g+TZm4lzu/KnTI3Tkg+Z/DtdTlQ1K9XdqDN6xLO3UF?=
 =?us-ascii?Q?QO53h+3vTWtFpJgq9XsC6F9leP3aev3wRPoF4OO7aiQA7RHQvFmq0y8v/UD3?=
 =?us-ascii?Q?rDeLcljal4bMlqx7sc2KG9zIjTbnT+AF2j4urrpFhUW29FFNg0qsyz76Uoj3?=
 =?us-ascii?Q?/JYr7IdOMtUgNJn7yFao0XbZgo+qWUZ5/r8dg3DfSV7aIVAKBMz1WxNMcL1B?=
 =?us-ascii?Q?yK9EX9MfAGQex9UKBUh46psmC+TSslI0W9oHLf+ge/0Ei3PGpZ/Rox3Ascum?=
 =?us-ascii?Q?sRdMhSoeTnB10OoAlDxNvbx2aEG1VDx/lSx7gb7x/ZMpisv/hwXuepgAkRhJ?=
 =?us-ascii?Q?XJNXmhMDrA0+JUVDQPUmHEa4iMbWY/MgS6+SKt6o9g5VuIlKIX4ub8AbOW6J?=
 =?us-ascii?Q?nRbOTUqALyehQUpd8zIoaygwwbnkAO+U+KOW1hyaI8DY/KsOKWrRbt0h6Uzu?=
 =?us-ascii?Q?eFWtnzjS6RlY/N4mTj4UlErnr4/3FNvUzCXQzvWN5fGj7zbPmrLrtdyPtScy?=
 =?us-ascii?Q?ZRTN3m0L0hIZicMFMX9ucrlws30ty9xjA+5a/NLVDlf0WDuBWZ3GaOxO16M4?=
 =?us-ascii?Q?dGjpvlrhadLcWpPNiz64bMKX9158eIHSiqMcaICD4kdB5ohRYcYDWM29Jl2c?=
 =?us-ascii?Q?udukzSV9DbeL3jeJ3w17lLMp8CtCWMZuBLlosF+MQbqyT4lHF5r09HCbndkw?=
 =?us-ascii?Q?nxgwIywdsLe/jnXFBaeprR5hWUP9l7SJQU1E7qbY7t/ib/ia81zeJcCvY7ZU?=
 =?us-ascii?Q?1LqwFkFumC2jp+CZrjEOBo0ULEwEqAxagqk3JHHqQ7wD8Ma/P8YAJLIFsH2m?=
 =?us-ascii?Q?z/Dn2SjInQmHu3G4niqgigh/4wP4SUOvBuzZqwc8SQHO3CoJKocljZJfxmzY?=
 =?us-ascii?Q?YP7SeJFGwzh/4xfhHLGkET877gTosU0VpbIZoLN6TAvak/4I8eqD2Y74QY2f?=
 =?us-ascii?Q?itOAZf2dydttqrR65M/ql2DXVV7+XoV9tDyhJYAYEqTZI0+rTGaOInveK/GV?=
 =?us-ascii?Q?TcWcM+76MO5fbcBQGdyOZuSXYZHyUaqLOs1O3Dy0XPBXfQ66z3grJIaaYR+8?=
 =?us-ascii?Q?bJAjfzuVl3UwKrYxdtE1uWgxLKr193pBN7w5YdEgN2rdRDps6xsbpwp/ZXRR?=
 =?us-ascii?Q?OJIgZhjxYg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KCm/cHyu+n12yVEAzccDeWnDp/8tHEaRSUn/Ns49xc+lDIH8DmP6HOUkpcWmpms/3BW5oiFgJSzEj/q6ebFgx98MoFwRnjBPQf94EG1cU4dALCQrnpkocwzF/gKoi6FL9t03Qb65DjGqdkWNaIq/1/baOBYcC9til2auTjV98UPDKYboKvaWcDG551igfFT1gf9u0hSnCf63FkZfytPrMtgWiQ1siZpEx+j7FjhvwylA+xqAqINr7l8sGrGaTjVRFs/QocqcgeLzUTAlMMEwjh9WhnPGLaNCaQONLqrVwfJ8FsUslA4auo0d9oIycoSOjXPgLCm2L/3o/+OXJuE3jw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96253554-77e2-41ca-dba0-08debda98e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 17:41:46.3770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/aeIKFOWSAnEUyD578w54gWMmRCt1Fn9XNIaZUOwXfz6djuEdSh+dtNtH7u24+fCkeXF4TAj+D9tuxBbJHO9i6/ShJIlxJkMdkxZU8vER8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9561
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-293180-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV1PR11MB8790.namprd11.prod.outlook.com:mid,osuosl.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 6125A606E55
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
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 03/10] ice: initialize ACL =
scenario
>=20
> From: Real Valiquette <real.valiquette@intel.com>
>=20
> Complete initialization of the ACL table by programming the table with an=
 initial scenario. The scenario stores the data for the filtering rules.
> Adjust reporting of ntuple filters to include ACL filters.
>=20
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v4:
> * Introduce struct ice_acl_hw_prof in place of using struct
>   ice_fd_hw_prof for ACL. It didn't make very much sense, because most
>   members were actually unsed, in addition to it being very confusing.
> * Now, ice_fdir_rem_flow() won't be able to remove ACL profiles (because
>   ice_fdir_get_hw_prof() no longer returns them, as it should logically
>   be). Instead, create a new function: ice_acl_rem_flows(). It's simpler
>   than the previously used ice_fdir_rem_flow(), because it doesn't need
>   to iterate over any arrays. It also doesn't need to call some
>   functions - it should all be handled by ice_acl_rem_flow()
> v3:
> * ice_acl_create_scen(): add check against max match width
>   (ICE_ACL_MAX_WIDTH_BYTES)
> * ice_acl_alloc_partition(): change `row` type to int, throw errors if
>   subtractions underflows
> * ice_acl_destroy_scen(): add a call to ice_acl_commit_partition() to
>   clear availability bits. We don't actually destroy scenarios outside
>   of driver deinit, so this doesn't currently matter, but should be done
>   to futureproof the code
> * ice_fdir_update_cntrs(): remove `flow` and `acl_fltr` args, pass the
>   whole fltr and read those values from it. This prevents passing
>   literal value as acl_fltr, ensuring the correct counter will be
>   modified (previously there were some hardcoded calls)
> v2:
> * Add unroll in ice_init_acl() in case of ice_acl_create_scen() failure
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  drivers/net/ethernet/intel/ice/ice_acl.h      |   8 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  31 +
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   7 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   7 +
>  drivers/net/ethernet/intel/ice/ice_acl.c      | 116 ++++
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 573 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +-
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  68 ++-
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  14 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  17 +-
>  12 files changed, 835 insertions(+), 17 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

