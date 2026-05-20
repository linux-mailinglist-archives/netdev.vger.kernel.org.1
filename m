Return-Path: <netdev+bounces-289816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKh9Ln1sDWrgxAUAu9opvQ
	(envelope-from <netdev+bounces-289816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:10:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25153589721
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7084301FA42
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FC3A1E89;
	Wed, 20 May 2026 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIXEcMlD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1A31BCAE
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264270; cv=fail; b=KWjYbWT1MlRKOaQ4W10KFKV8/X/M3dXx12ImeMjz+mNcCQyXj+v3J0VocDOb/P7v8/qslyZRcGhO0jcIlS2KkUnU7G0CFYxTprmLD+DBjiH9oZP6Fyh2q3agV4NIaYIx0ukao/KhtnE70ayxC2yqJceD/4eSgAxxjFoPo4WM4bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264270; c=relaxed/simple;
	bh=u83jy/tc70DY/DlfkanXvKvGsU2sx1MSE/CX1G4UEtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kA1/syrww/KDLYpsNcfZNtEYf6XFqAPDKxpl39ba9IDGZE6plbH4y8Unvst48KvJCQL2f2ihBeWhgR/p0jdP92V2RQVsM+P2zWFgNfkkAm4nOcmoR922VjLoLzaV0+R2AIFppT87VN62agGKVqbsqi8EeJh5qHSnaW0Re5MFlug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIXEcMlD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779264269; x=1810800269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u83jy/tc70DY/DlfkanXvKvGsU2sx1MSE/CX1G4UEtI=;
  b=aIXEcMlD6BIdOzcT4X0BYBF84suhTaW3fB3EzIXFD+7f0UW7ASR0Cc7z
   vfO1H5xT2F62rGG0ChVQT0zbVB/32uUoA0wmovrV3sV9BBhDR7J2zR5Dm
   7SQhukaDVF7+/dF7niO1PnsQ18r9fIKlmNskGPabXCClXFoPEW1g1nPQH
   3nUnNAi7jesDtqvQD4vFqDabHkw7ljpdPcdWlGPeqN60hICQO4dMZMrgt
   4HpjEJnom7mpaF4KexGBDp7urtyCLLvgs0Iy/7+ctUBAMJrI90898nyfb
   RKzAGCsAX6BZe78XuCtGO6nMfcoHYwrPPtNopAuOeXjZ/mMepMS+te4ZY
   w==;
X-CSE-ConnectionGUID: VBKM2Qp7Qn+D9vV0iZsg5g==
X-CSE-MsgGUID: I4CYIhyDTBGyIifgibQdZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79302126"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79302126"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:04:28 -0700
X-CSE-ConnectionGUID: VHEWK4w4Qoy0eGiqCmyGLg==
X-CSE-MsgGUID: 7DK7GNV3TOuo24SLlTx7Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="245073690"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 01:04:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:04:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 01:04:27 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 01:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6R2cJz13FKt7OwpyNUDF1+OiLUSQByPVJVPuBATdZRUKrG9ka7Eu/46jIpgFs+TB5nJmqybIS3URe3dwibXjV2ZbzbaqNvzMIsavXfkK89osuw/7Vp4kQZM4F0R8cJlfn1Tcxco3bb/Urht40F3Aexejla2HCtCjc5roa+UurMBUuLcVBRGiQHcSopB4yqqgoT82pEQewRG4hy/QPZ3H81HsboWk8mi1PCkoHTSQhjOwXxqUJWbVj+Yv7zDe+vB0YX8V28gM+IcU03x4Pfag7ZP8ayZ5+VhOqX/wDIbudZOuTxrjvazGmzITsgJ3wBqcCrqx/856s/2j2O0KBZUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqhTAuJV+St6f09n0aTgSXClUCnccATj0MHk8XSFDR4=;
 b=ndfFrHUcXxzTjp+zNN8Vr/qpG6Z49CkdCkZzZbhviteCg5sW7HzCeuUSZWitwriv1lMTUVDv6aAmJZuLIrCCLn1cUQpmMrZlHCOt+/2+QCcEtG6rZJB+ycv4esEu6GlRZb49RtQSCDky6ZPiO1DiJX/31uYG8PWIEPWhkvIKZmnvweGogWY0G6mt6fzOWqSXSIBh88AMu6StBT/pc3jgJAI+YWM2xZCDZtgpAWmnVV50AFIClA14b+c8uMX8hL/tRlE/iMes7B0zWaiIGHY5XH/W1O4xmlTitNT6VShJkZRmIoDUjWIdomjfaYPMIiiiDMWCUuvpU3fptAYGGlEnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 08:04:18 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 08:04:18 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net v5 1/4] iavf: return EBUSY if reset
 in progress or not ready during MAC change
Thread-Topic: [Intel-wired-lan] [PATCH net v5 1/4] iavf: return EBUSY if reset
 in progress or not ready during MAC change
Thread-Index: AQHc18J+ozvmotoz4kmVLGw6rfdM7bYWrvIg
Date: Wed, 20 May 2026 08:04:18 +0000
Message-ID: <IA3PR11MB8985CC2F76815EA7C88DBE2B8F012@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20260429102426.210750-1-jtornosm@redhat.com>
 <20260429102426.210750-2-jtornosm@redhat.com>
In-Reply-To: <20260429102426.210750-2-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|SA1PR11MB6760:EE_
x-ms-office365-filtering-correlation-id: a13c55d1-3a65-43d9-4b6f-08deb64664c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|38070700021|11063799006|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 2aI8RLHCFgApRPdLm6kD/QEHYUvtFB57QVL5EOv63pXdALeA4tLf3ci2zDpBUHznwmOSjwb/hHpebQs17XL+kRFhOtPQx0bB8Bsiou6LulE0jDbL6AML9LIbsOS5J3vgfgXSPAdehzHJqWzYY38qk18kiWQBS5r6Vwv7TkZ/jFMk30iAa2OSl0IZ0UBgruZcfd698kCa9gRUeT0NxU1MePw4XOfkUtQZ2RJaJzR+Wm2E70qP8Ju/GehzG2rJSL1uo0EVDDIFa2MoBh/ZUDy2xxnlGi2WjtpWnz43Aqzl7Td8EJMfEe7bjvAE6PgbILC49qmyLYnvuGVUs3J0gFAMXVxy4cQAnTvJ+K/aL55kmHxpUMdLW11gZ+t2KHnMDF91T8W4CrxMlv7zRhxOznfgED1i7nwLVuLFBEeWsOwkkIhQ83kyh1QVKcBEm6U6e6i0A3DQBQoszZwZQkxHktKx/836MEwXr3tz0ya4LSdGUkhCEYghxED1X69tBIV9H+qmTm/ekfLkXYEVu6EdyxOuV3bCcGxkiIJ4g1gYI+MenxnrSbnDZ3/y0cMyTkXWTC/J/bi6BGvlpNF6nuzuPlwtqmU8DXVUihlyPGAjFUVeGR4i+vVJlXgNnoBVTOvZpa5h5hnYF1A16+wQtJ/lFn1THUy1LqtW/h5RcOlUk0dwtYDsu+Vjzu54IJitmxOIlTB3mWBRyNB7TgNu8ckv9ryibNZO0N3UxNcSSYpuDWFWwYQuleDxcBW8eXh3Cczm9xu4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(38070700021)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GaFWLCrQaUFurBnKCKeiGeIXW33KTJSEK16dqWdaKa1AA/oLYYX1BYEfPuym?=
 =?us-ascii?Q?lLZ20mHyiVVjnPAsQ3pxhn6Ja9RqVDdA0xf346lp4Vhje+4/aaWvn+oKG+yg?=
 =?us-ascii?Q?WSfxYhZQMbBEZzK8rcKEUuxrce38aGKtvb5bVL37qZzQgy6LOmBzxF5StCJB?=
 =?us-ascii?Q?wpnKgo6y+OcfLSsYYAbNOoWEsNEB0rOada5SM7xcqnzskhqSzbjdNFRKSKDZ?=
 =?us-ascii?Q?Y7JyiMRJuRFQkULXCzBeDeSxORerjn+ewQRmvsUuPZnAXcw3xFQtMVK2lvBQ?=
 =?us-ascii?Q?xKw22FOALoYtr8wxSaUk0bIAKovuaRwBlKhypWbsl6zmhirzCL8W/S9fqKf0?=
 =?us-ascii?Q?bzk2FHZ7m+iL3uNAGMRKg2/KtXm8I9kQGfJh6FdAX41yrBfY8QU19SxS7jmK?=
 =?us-ascii?Q?zpdEnQUflM2X4tkEmmvDFFcceTFEtTanv6xG0jbtqrxdJ+1PJb8jz6dV0C4c?=
 =?us-ascii?Q?pDWpUfAjOBjUNr7aihdLc4egZeB91bVV+UiLUvP8DYolTPTQI9t3coPwBoXK?=
 =?us-ascii?Q?ssROH5A4OcY9RGoEUeUso/Y0ng3NCwgtL0oMlzULkXnrUMI9smTUjMK0JzG7?=
 =?us-ascii?Q?V7FYALsqvjRhFC+sZ5LqhxiW1Cx6ibVwUvwrWM3ECjWLV9HxGX3ezf3YzZlk?=
 =?us-ascii?Q?Di0wVi6DMZwQARybl8ODQ76K+DUbgVeLcOtiuVxIsIMx5dhLlyejrEx+g55Y?=
 =?us-ascii?Q?nRULEqXhLoLtLXcYztQYM9vjamVcskq2RbFr0xtMBHmIbu/mQOqu5kjDf2Cz?=
 =?us-ascii?Q?WxvTgKAvJPje+20Y6AsysMqIwbzN16xkniElKVUA5bi3k8T+sBD2TSddCERD?=
 =?us-ascii?Q?q0OYYzS2Kd6BOLajKrYypgyvUm1G39cGXXOGsY2Y5pP7m6Z8F5fYNvNYQ8XR?=
 =?us-ascii?Q?XNL0JJ22UMkL8Ru9woLLnU6xcHoe2BxBfJvWVDAcrIrxG0i2qh/x1OEFQplz?=
 =?us-ascii?Q?Gn2SZeXquQbh9E2wqjL0dmjo2e2sStam0cOr3+g/CtntgYNCdTldrfyQh8L8?=
 =?us-ascii?Q?8Ab9sumkh9Pr9fO1G4rfRpkBZ7Wbt9zyEU20Kthu+VkpYQSf4VmVoIqxiMkE?=
 =?us-ascii?Q?2aGb6QIfgv25PQqaMg/qqKFL9vym8wNtoI6Ukm+TNS+wcJkHLEEkYz5ZI+oD?=
 =?us-ascii?Q?1rFtpFgVD+Q1oLTBVka7Pw/fsIKQXfd12KejgznO/e3XdBOo9+e63RMaclBu?=
 =?us-ascii?Q?Md8R+tzKQFOEBGFlkopbE8nWSNAoiIpy2v26okrZnYPEqPWjXFmijKYVCEjx?=
 =?us-ascii?Q?UYbcyRRbZ8rgApGIa2VNc0MM5vqmZGho0vdy67OFz/1Ixe4cLNG3c0W5r+Py?=
 =?us-ascii?Q?ypM9qM7URtLfKWh/I4LpxJD7zCTF7rVmPMdOxntw9olHx9swYCTAEAjDuUzK?=
 =?us-ascii?Q?mwRioMaD672ONaIC/xtXQTonf1Q7p5fbaZf8X9ayktcKOO1s/JJJG6C45iaF?=
 =?us-ascii?Q?UHvdFZEYPqaaud0vfWnUyiJPjHcCxLcL4GTqeBaHQuQTaQr0+uzUAKTnir2I?=
 =?us-ascii?Q?pqQmgYMWhfSaDV8nIF8QtFmjlwk4un7xZ8VMOt8ggk8psToZg00+lrLnsP74?=
 =?us-ascii?Q?/RnpLPk2wlaJVJzpHaVyLYL+ZQbzhbYhA3BQrAGey5B1IF8N2y/uH9wszsY7?=
 =?us-ascii?Q?LsPFhKrhf2AhGlRPH0sApiZpRH6yrYOQWGkc+rPl1+qGdzf0K09ch3DR+/yb?=
 =?us-ascii?Q?UyjyMzfpVc5cPWXrYDq7pfFfgrtMPEmN3LV5lQvYk7k6YXAryd1MGlkQ8+yr?=
 =?us-ascii?Q?BEWaTLKseA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Y+HTnZqiUmYmJ6CcvpH20ySsyL+CpiCxXo9M4YRL82Y70ZOUHtKeDMYn25nfYtNbNJW07UWp1jbjc2GTy8/oMpIvsOKlLtNmfZx+XikGrFKjS/SK6nA1aRO/7RA0DazfU3wFgrezrNbBPLo2cIPgdbBAQzwC9U9vTHjuhP8MRPmfdtkua3j49GDZqouJMLyagkvOscpmm4glUUeINzl1um8bNL3ZDwn+YgDZwgZaZTSyJmznkCoq81LxgA56juNB/KxMiLxiRNJnfsbD+9cpyfg/OSQkVhzGIe14WiBJgSelBFcPAaFgbgnjbQY79hbiZxJsLZYURYZVxOqVYXJ4eA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13c55d1-3a65-43d9-4b6f-08deb64664c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 08:04:18.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n312y2Xwi5bpXB0Jr1M2wL/zPKlz6INw6RRVu9YMiEAn9l0ENhnwbA8A+BhD9Wmr2TNbH8dvlo0c28OR6YiVeNyOUBwSByM0cbOPHNL5n4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6760
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafal.romanowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 25153589721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
ose
> Ignacio Tornos Martinez
> Sent: Wednesday, April 29, 2026 12:24 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> horms@kernel.org; jesse.brandeburg@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; Jose Ignacio Tornos Martinez
> <jtornosm@redhat.com>
> Subject: [Intel-wired-lan] [PATCH net v5 1/4] iavf: return EBUSY if reset=
 in
> progress or not ready during MAC change
>=20
> When a MAC address change is requested while the VF is resetting or still
> initializing, return -EBUSY immediately instead of attempting the operati=
on.
>=20
> Additionally, during early initialization states (before __IAVF_DOWN), th=
e PF may
> be slow to respond to MAC change requests, causing long delays. Only allo=
w MAC
> changes once the VF reaches __IAVF_DOWN state or later, when the watchdog=
 is
> running and the VF is ready for operations.
>=20
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), MAC changes are called with the netdev lock held, so we sho=
uld not
> wait with the lock held during reset or initialization. This allows the c=
aller to retry
> or handle the busy state appropriately without blocking other operations.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>=20
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001abc908..67aa14350b1b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1060,6 +1060,9 @@ static int iavf_set_mac(struct net_device *netdev, =
void
> *p)
>  	struct sockaddr *addr =3D p;
>  	int ret;
>=20
> +	if (iavf_is_reset_in_progress(adapter) || adapter->state <
> __IAVF_DOWN)
> +		return -EBUSY;
> +
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;
>=20
> --
> 2.53.0


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


