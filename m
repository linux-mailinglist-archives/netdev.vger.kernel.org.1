Return-Path: <netdev+bounces-296931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FvxxOZa9J2qO1QIAu9opvQ
	(envelope-from <netdev+bounces-296931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:15:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0365D171
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:15:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QGCDbm9i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296931-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 074ED3008797
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE3A3D0BFB;
	Tue,  9 Jun 2026 07:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7D2C11E1;
	Tue,  9 Jun 2026 07:10:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989008; cv=fail; b=Hd2Wr/2GgrTGBSykECRkZYh4SytwADpClLktpZyAk+PW7Xc83ezLXEXEI3z+r4euGshxsGRG1zDwVIdXdFRX6eMq1oO5HwMDvcpOQFLV9nOz8FhoxyuALVDGIX4Dpv6INEF0P4xIAU9XJFQkWIoOxZHSUIv0qi/IH3RcCRO0EhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989008; c=relaxed/simple;
	bh=ZEZaVql9JrrUxFBvzXWxCrJtb/hsg2UD6V9o0jQdAec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTcpMEIcosRYZrlz8lc04q19jnrqIRLb6WedFkgstfekOjy2df20MNtGG7H4eD44wj45qByZ2MkapTm9qRlinPOJLFpbEwjhJo/xVzE12ucTlKSDhzOLrrVchEclLHc6pco8c6rXUfhK6C0UwQHmHCY/XJeVG8uiSPz1eQM3QH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGCDbm9i; arc=fail smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780989006; x=1812525006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZEZaVql9JrrUxFBvzXWxCrJtb/hsg2UD6V9o0jQdAec=;
  b=QGCDbm9iU5qsrmFeHbNAnmEuDaoMohV87DhLKvLtRQiaZie3FwMAFZib
   tspqr6VnBrT8LysHP0pNWgp9tdH7iJIyovlBoIF9ex7cjsX1nGiiiqthO
   Km35kqw0ULVKluTnmQRtFSgbeCJNkfs0P8aiUJEAPfAmnFnfm9PUtzIYI
   vHE86QEQZSZOOBnlJowBw7sUvlwZ2/sV1O4g5b77AiNlX26IawC8cpDgj
   4EWedWg9Dkf79ryPGvyGxzoZho+IgRQHuHCqRwNGVWT1t6IP/GGb7/cwn
   zKg0s0gR2HMVNt3vZx4HpNuoh2i9qZSY+SUbs36vKDaqEURFuDk9/+sZ+
   w==;
X-CSE-ConnectionGUID: P/LRzuaDQo6z5VIA0tz30A==
X-CSE-MsgGUID: ZEMDjieUS/aOTOmOnfJajg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81786388"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81786388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:10:06 -0700
X-CSE-ConnectionGUID: iEiMdagjSLunD3NixBrf+Q==
X-CSE-MsgGUID: +5kXydV7QNmgRAxSgejvQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245818975"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 00:10:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 00:10:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 00:10:04 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 00:10:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEdHItV//f/dJUizul81HkCq5KTIT8t2Y+RLfDzLPVVoL7mFDLDscDgzZubrHHMzAAv9QxTS1SK1egEv0ywQe/qauoz1xdni5dAm9dtXlRUNNN27xomMFwcOjwSHYZ9j6ywSLEJFIRDtC1fnO1LaIrbsu+S1LH1+RB7ECoraSKYT5Cvjlz3YcpvBeoaHj3M7NtJP+pyfYFilFUEauOzv/rABfWtP7P2Nx74yoj4oTcsaBmeQxE8HQOi+vJ3x/wap8EjZfB9yZtCrCeIdWBLuSQRXMEGWAK9juW9SKbBiFU7DItRp4XkLCWDA5aeBsNkQP1MkJ4KAIqFuIIw8FMM+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkMmVx70NGiyMI/ATWuuV44yhm0ZdcEAYs7yalIWHCI=;
 b=bhgpHWr1uCr82P3qFRIKeRGbA0T07FOBxl4fqwCbq39Qe0SfX3d03v2gqW8RnPVaI4ecQNYGhmyHSerjSK6UyMzqGD/8FypzUffLWjpJY3ytEYFA3Hpo/tuUv90Kni6b2v3Ces5E+kLGZ0lbY8tQ+0zOXOCA7lk7ZQZEwDT1fmuBClpmy+hcKlmnlLP5MCyL/BrIrRLKYKvJgFQRgM1FHxIKhrEK4Q4IVd7sq5RP1mXfKDN3+8O/rFZlCHh+0VGVfS9/zGlDcI7liEbLzG1yErw2UYNrIC2Ods0t8z85kBoLiE6cLI6X68nXxjim/oS6a3iwNYtzmKC8NzORKCcn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by PH7PR11MB7961.namprd11.prod.outlook.com (2603:10b6:510:244::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:09:57 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:09:57 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH v14 net-next 04/13] dpll: send delete notification before
 unregister in on-pin rollback
Thread-Topic: [PATCH v14 net-next 04/13] dpll: send delete notification before
 unregister in on-pin rollback
Thread-Index: AQHc9qx1WAOADYOsh0eBk268hx/sxrY03vWAgADwD5A=
Date: Tue, 9 Jun 2026 07:09:57 +0000
Message-ID: <IA1PR11MB621956E9C0B9EBBD32C8A332921D2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-5-grzegorz.nitka@intel.com>
 <CH0PR11MB539452AD940A13941ED1E6D69B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB539452AD940A13941ED1E6D69B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|PH7PR11MB7961:EE_
x-ms-office365-filtering-correlation-id: 6d19fbdf-4125-4d8b-b904-08dec5f61cfd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|6133799003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: T1n1DNyU2LcVPnYh0yRXMh7yVqLLnGVTROfJUEyX/Tp8FlMKL/UGzBeGzNEMpsO0Dps+vtN+HFGoTjKxFOz+hprrZUl4lHUM6TOj3ClGPj0p4GMQhgYNgG9igru2J40Zs3/4F9+0mk/VehGAJd848rf3/YV3uAvKj+irA8r7NWvfC4+zN8qdN3et8+8ePEs0iYZDcvH9qAg+Adcp+Gu5ccLfOrwCKRsOox2hNACodAY3y2gliiHuaT2OItDJ5GzdtjA3mKOmQWVcOx53PIM2R6zovjVp24oaSJpfG6N1FqRqf1DsCK3wISenum6IA8lsHuWDFhYDmHAIEZnVL2kIurK6zKdvUdTLlPES7QOSmdvVcD4ii++8vlWjOnDPHUJJeyzKI5WDS80SQ93c2Vs8veGrM8QxRutQfJ+dHolOgwI4QZW2ON+4spRzfaVwb9A0HMmiasBQCZidIN4XSwN9+WTUKgzvujRN/dilmOPIB6Bav8xUT6gcMnd3d+wUECxwG1DnIEjFV8Md/nZbogkmq86f9liyc0Gaa+IOAoQnT1uItiefvwQiD26HO6Qp4e7pu02e2QzYJmmHSMZqfuRarm7Vm9hrEMnm7fHvBYf9BgtoRPe3awjqSA1jb5zeYaQ3rHD8BxxjR79OU0EHRulLwj9jDBNd+wDkqv5rF/sDRmxcJtPmAkTOqbwEt6MzIwrG11gp3TRriRI7TxoR4G4yjE05ljogvDfYcmTxAQO5AinjOrAbepuV/W1j+WkXB3I7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4EbLpctMG0CyRTcaI+fQ5b17WeTYD+KKP33pHWYVjs68e3+2vwDqLhV2ivi?=
 =?us-ascii?Q?Eoc0IDU6gVlU1G/08hKQgODDW4QVJODsegxRENyNVVSALCIbiQkpQrXJUEhU?=
 =?us-ascii?Q?MtFysAgQQUyC3PcmT4De9WFgT+ZfPgHi0Us5ZM2bh+bLFq/js30neNnY3GNy?=
 =?us-ascii?Q?Lin3cc6sBk6pQ3Nbh54zEpvLPhfiRkiXCsW3/oD3SuEbBjhZm/PzwIFp2w/K?=
 =?us-ascii?Q?4JE/jN/r+e7QEi48VKIFxBEiM9V7Ms4CupmHtBWQIE1J5R/zbuwhQS1luoSQ?=
 =?us-ascii?Q?aug3EyqB89ysoJFnwv3n2AtfoKN/Jr2FZBJeC6bXjhc82JGF0SVou7WFW8IY?=
 =?us-ascii?Q?M+BBpVXTpEFFwNpqaXHT2/fNHvwpmptMoCM85bsInP6Lh1Tnx42S0+inisc7?=
 =?us-ascii?Q?XFTG5Guu3qo5PMA+XzqAA4d5svj0IkUxfYup4aYfwp3d5Fd7VP2VmfSReQmY?=
 =?us-ascii?Q?nEYp29gIals5KdxTFQlNXxSxq3X74NbbWGyYRJ79ZGgWneP3L4QGeRIRcD5D?=
 =?us-ascii?Q?PkmsVpTRp35JlYqzrN8MaU1NOo0dmWchummraoxEdxR6Ws1C0rOmtFOXED2c?=
 =?us-ascii?Q?+nvgcUSZ2IuFXtzQ2MFFlKFoMShcjfhFixEAGzPP8D2AMpVxY1GGaZuFtn0+?=
 =?us-ascii?Q?IwZ22c2xOj8NypV1MOLgTb4JZaUvKQJJU06xjU+oGUbwsaw9G5uJrc1Uc0cg?=
 =?us-ascii?Q?M2rYGnKY5+BKsL5NQLAMItVXOfQk1nwHaZRVKeics5f9Jj3ZuZ7wJlIaEIvZ?=
 =?us-ascii?Q?AZ4pNzq8Q/1jueTmCWmoDNxzkwWiPkn/RyPTbmWdy5rLU4GjxUtnS08xkFLX?=
 =?us-ascii?Q?q4D0CfuSBaHFZvjoXrW7MWtdlvXJCjdc7abKTJpkLRTFV2sYUIEpXUvIAjdl?=
 =?us-ascii?Q?LmDbJ18EXzIYJlEudUWaRGXjMR6Ey592G+Hc4RXmeK1hRyop1G7+f5Xs1Xl5?=
 =?us-ascii?Q?IVO8EbO2YyLBuWY28QpWq1ZPmDqzuk8ZQfO/6cnP6NuL7Vh9/oxlDJQdUZ8s?=
 =?us-ascii?Q?x5/oCBmG64zc2H6jP/HOYs4vWJEpLzpIhXGoAP1kTcn0dYTCEI/Tz8wi6BfS?=
 =?us-ascii?Q?NQcU9e1UAUWYNQUpzUGuM5Emnb06vDTgjUkCRbUm36r7osdMSSU2ypP9gqCH?=
 =?us-ascii?Q?IS/YI3UEFqL1dr/l2qLyA4EWPgCPdbRmiL13YcFDJNGae5dzdR6QMWebBkNz?=
 =?us-ascii?Q?mJkTA8gbmJH/kznOI9VZyIb+HZeaoyFHs7NF7spmRgz+iQWaN8bA+pZatglo?=
 =?us-ascii?Q?V/q5Vp1iT+w+kHocxucVOR/Fa+t4J1hmpXNKR62JpFSnfUBHpC5cLFRGYzLy?=
 =?us-ascii?Q?uAK3q9rJRdfwWdGZjUcmSQD8/V6iQE3bPi2MxHETUi9A2IUSoR0E+iNLoZvH?=
 =?us-ascii?Q?JZLiQM0fvycA+OOyXjD1lRWwuEnv68ScXOxpsclNYR2lK1z7tJEajYQ18l9r?=
 =?us-ascii?Q?y/+6Ep0VScs/EeWjBspKjJsw+MXwfB91Se1m31Pf9DnRokW+c3fcGByXZOJZ?=
 =?us-ascii?Q?yxfVTNzQQyxqhtEDjVEC56HlCwTFsqVmRdTkDpj+3kHS1Hk+lRl0GIjMSut5?=
 =?us-ascii?Q?g+FyY19OhRjKmoyIQzIzhSYRmhGYnM8ilqFSg7TndmKPzFzyFFWAgJBN2Jmt?=
 =?us-ascii?Q?GDDDKPCNegZykY1Eu5ZhiDWyvSSrk+79se7C72N+phk8XYpZdeGTFo6rAKns?=
 =?us-ascii?Q?HC9flRtAqU7g0y4NEo01LuIOfQea7LXnwbWHRHfdUxWTmVmwZNMP37Co6tFY?=
 =?us-ascii?Q?XXQu5M2UDA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q7hVWBsstzSZ6kyAMzCEJkyi+BxHgP+K6p4whj4oeTS0XtRGCuSen1EGFD2Thx1rH1yzTY0lVy5L4fRM3kc7hKNBR3QPICdYWo5T53UNgKZf/jiT9K8uSEwcvIA2vF8KmVb9P4znjR4ai9gKG1+DE2ZmIoLMboi7r3fpTVXticgYfJn7bU+71PLUXXEIhGM3/3mvhscKmRoFPhCaz6vPJNc2wxEUGJNjiBsYXdI+GYXt+emrJ5ntio1wkMWLqKFSCwsm1QX7Sc6yMHjRMIKCZpEUtD5cUGSML8TOBX6RE1Kdb9+42/SNSLDqMDjtKRuk/qY+iqwXmKyLa8WZtnznpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d19fbdf-4125-4d8b-b904-08dec5f61cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 07:09:57.1778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UN+c0JWczogKkaR5mX3y7x3HUOF+SI9Qwm/g6vj0nAwFSNqkayncQVNR63xJ0uOnSwIC/aU0WqGwjlx8k4xHckMmNBeskOPR0Exflq0UTE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7961
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4A0365D171



> -----Original Message-----
> From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Sent: Monday, June 8, 2026 6:45 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; Oros,=
 Petr
> <poros@redhat.com>; richardcochran@gmail.com; andrew+netdev@lunn.ch;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> kuba@kernel.org; davem@davemloft.net; edumazet@google.com
> Subject: RE: [PATCH v14 net-next 04/13] dpll: send delete notification be=
fore
> unregister in on-pin rollback
>=20
> >From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> >Sent: Sunday, June 7, 2026 8:31 PM
> >
> >The rollback path in dpll_pin_on_pin_register() called
> >__dpll_pin_unregister() before dpll_pin_delete_ntf(). When the
> >unregister dropped the pin's last DPLL reference it cleared the
> >DPLL_REGISTERED mark in dpll_pin_xa, so the subsequent
> >dpll_pin_event_send() failed dpll_pin_available() and aborted with
> >-ENODEV. As a result userspace was never notified of the rollback
> >deletion and remained out of sync with the kernel.
> >
> >Send the delete notification first, matching the order used by
> >dpll_pin_unregister() and dpll_pin_on_pin_unregister().
> >
> >Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> >Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> >---
> > drivers/dpll/dpll_core.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> >index cea7e2be2cbc..80195f3a84f3 100644
> >--- a/drivers/dpll/dpll_core.c
> >+++ b/drivers/dpll/dpll_core.c
> >@@ -1007,9 +1007,9 @@ int dpll_pin_on_pin_register(struct dpll_pin
> >*parent, struct dpll_pin *pin,
> > dpll_unregister:
> > 	xa_for_each(&parent->dpll_refs, i, ref)
> > 		if (i < stop) {
> >+			dpll_pin_delete_ntf(pin);
> > 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
> > 					      parent);
> >-			dpll_pin_delete_ntf(pin);
>=20
> Hey Grzegorz,
>=20
> Since patch 7/13 this is already part of __dpll_pin_unregister ?
> The call should be removed at all? Please make sure all calls to
> __dpll_pin_unregister(..) are aware of that, also maybe better to
> put this all related to one patch?
>=20

Yes, I think this patch is a good candidate to squash with 7/13 (with
proper commit message edit).
Same 'Fixes' tag and both touch notifications fix.

Thanks

Grzegorz
> > 		}
> > 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> > unlock:
> >--
> >2.39.3


