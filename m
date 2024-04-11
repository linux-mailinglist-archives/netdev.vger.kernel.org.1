Return-Path: <netdev+bounces-87009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02958A1428
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F311E1C21DA3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141B14B065;
	Thu, 11 Apr 2024 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neg5Pm9B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626014AD3F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837679; cv=fail; b=ePgNUHZ4dufhnjpYqqepskbEDcdoFerSzgRm43k1PklPYUVS7hPf2rMXrxH4cCudnxQtAjLV8agHUtx6Z99qx9jthc2TivQU+q0V9VG+CSTzq/u9MUP8+0CjYMx9Fxxks0U0K7ORKzdAmyRCsmVSmeMj0/rOPXQNh9dEJn0bEDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837679; c=relaxed/simple;
	bh=gsRwILQ8rILh721FP8h+hy93irC4psLuXw6x9UjlTsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rlLuOPD8cjaV9WeFjSCRs8qtthK0sYQKcyKeBHrbaltoB8ebZKuyJNaVuC/E/gwTyfeR1EuOiVhemKqt8xpGGpaGWEaxj1v05W0PaaRmuGVFXx+LMt0vfcGeVIj0AjYMvaWH5GHWFeaLtg4medMy8+O7re/B+C2iRuJNiCOT738=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neg5Pm9B; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837677; x=1744373677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gsRwILQ8rILh721FP8h+hy93irC4psLuXw6x9UjlTsw=;
  b=neg5Pm9BuAV7Bf4xQCFUF8Wbs4aUZci8OgFdYDWDWr04csfav57FjdXq
   2ElZEL1X9v0307fsineRMNcgPIwskQULtVjNxep/qFK8oieF2DfoJzhbi
   w+rH0n6mh/1J4NtW54mfReyEElEqK1vThKboYChYLNxhWfYUU/4NuQ9Pv
   DTwkdRB6hvBR7hCfZLgHCRhPMJxM2DLKR4x9Bu6a/SNPHSGL+kY399NuM
   yCoh8K75HaC+ZpT5T5xMKJZj+ipj8/oMXRSEmmSTcXMgLwGac9sSU4yj7
   Rf6iXfWTe1PjDgj/fsu3cYobNZJ3cTb4ZAdFw0CJdknRrzc3UdNJkrAt1
   g==;
X-CSE-ConnectionGUID: AXSoI2ekSvuxC1aLBh5+Hw==
X-CSE-MsgGUID: MoJF9FvTR2aiDV1PKHjSOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8417357"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8417357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:14:37 -0700
X-CSE-ConnectionGUID: 2balTKI8RHu6x5sMSGIJtA==
X-CSE-MsgGUID: XdkN6w2nQUq0K4Sk4FCayw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20887140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 05:14:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 05:14:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:36 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 12:14:34 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 12:14:34 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"Wilczynski, Michal" <michal.wilczynski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Raj,
 Victor" <victor.raj@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 3/6] ice: Adjust the
 VSI/Aggregator layers
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 3/6] ice: Adjust the
 VSI/Aggregator layers
Thread-Index: AQHahZu5L2SiD9xptE2vuM5LTowpI7FjA8ZA
Date: Thu, 11 Apr 2024 12:14:34 +0000
Message-ID: <CYYPR11MB84291E5D0504B3CB7A034916BD052@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
 <20240403074112.7758-4-mateusz.polchlopek@intel.com>
In-Reply-To: <20240403074112.7758-4-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: 6befde66-6c6d-4f73-19a1-08dc5a20f30e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLe189S0dAfs4GeWo/jI4lpKwINfGWgVJuWpqEmmKiiiybKBVeSc1aApsjl83yS4hpcYxvyje0FO4A22ZJTSqKUFprnWPOXU3nOwQxAzvHUpSQFCuF03t3rGEpsjmLsOM6fX86Ng7FCKFKJZKQKheyI95NQVS00qLI5M8Ptx98j5Brda5jTH64to2G7YnunO3h+cahHq5YX5DtpQuQDk2qYCP2v5RueQeSZQRmovcALoG8qN0+INaUY6TDSXtP6LdKnes9Jcnwcle30yw4daML70Wyv7ItK4vPH8uKadN6lR3LyrAtbxCpwXni3qEKGCVvOyBEVp+FVGzSryRwbNCNQdopt2DBe1hO5Dqp8dyMZTZJlcStEyu7ev2R3IpuqaVqVBdbgRj2KKLMlRZphVOy1ZTO8oMeqSXczZoDETvgME8wUSQeo9fzmtpPHdXL9fLI4+aSQR0bMIKuGw2bdmk2PcNjSfgz0LIMd6wZdUAx9o8TBEWXVEnYdrTNAfemLBx8PoN7qiJs3tP5XVglCfPV3YK+xQBr+pC5RsnT+i8BE3jRlG1fOQRMT7K0d1aHNaqxyJSrlP0iE6FulzWP7hzYOQym9IBZ1qE/qSO+93DA5i6242suLLHyUjtDwbIhVMKjuqR4I1uEkQZoB3aDJI2Y6ehbylEpAYFZ1DqZsMEsNLSMnghlgJ3d+KOhOorXStDcbYpSS27BhMOMQ5k8ou1mtwgyDHIMaE3aJWc+DA8lo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lRup89rk2IKPTcDcTzHks1It2iBXoEssGXSzkISwTOdlJEIks6C6p2hO93xw?=
 =?us-ascii?Q?RBRFocE3QvJWOJIyWifTFlUWrL6GxchnR60LAXQk7kp/bU/3sKHiQK+ahdRy?=
 =?us-ascii?Q?gLbYjoOrkwcA39GxIudu/B6uIa7OsA1arXT8X0XwJp5cj0dUQwfJ3W+WlrKB?=
 =?us-ascii?Q?IVz3I1sDdUhi+QFUtBcczWSoo6Kylb/mja2QQs1MJLKsDDXfWoi4ET8wz+ux?=
 =?us-ascii?Q?RHA0tX6cV5uPw+b8huLG0V5//q1w8Mo//+ykUWseHmVUMqZeLYJlwD6zut5c?=
 =?us-ascii?Q?ZdNKfBUVuFp4kLgw9RIFnGKEJKa72sadgzek79O+yqcLpb4aeppbIsH6HWx4?=
 =?us-ascii?Q?iIwmy1nRldCDSYawO9koefpuAslmT9El7lWjeQdFm/ih3A1KiCVUoCW7eCFV?=
 =?us-ascii?Q?2Edz2XAjDyp4emf9pGaZB3DF1X/amlYjU2m/YalzOx44BxNP38gk3XwACuuz?=
 =?us-ascii?Q?J5S+BE2oeEvCP8Yk2CDnqcKkZ3scCbFs/kAMyYCti5poU8CiqCK6A9NePI35?=
 =?us-ascii?Q?dxP6e1ybR+L5gOPhE72KqvuRq4Lq1BMehgese3A7FxKPEE+hQW8g0503BD0e?=
 =?us-ascii?Q?UZ7f7qQKF42CrggV96+WNzq3jfVD6GKQrgFuT3JxOY23tgi9E/L/xA3WJ6as?=
 =?us-ascii?Q?+aOIx5AQ4zua7q4Rx8nnTUEXEv04fgMEPxZxPtiiXGWjo+eM4TaWIBQpPzJ+?=
 =?us-ascii?Q?TSR3GRpOTJX95A8CUKZHrg1Do1fPsDD9ppHWJaFCA1OdXVwigmGpYaYqvBGM?=
 =?us-ascii?Q?XIuC39r+I9gd9JvOYw4k941bgEYxK+bq0HdSys9m9GeNWZXk0FKJG1vpPabX?=
 =?us-ascii?Q?YAyhM51Ic5VvZrmM76CaBTb0FKJWdLizwE5Ru9ZwYXOVySYhplNOBnXVZcx5?=
 =?us-ascii?Q?veCHNGLkloNRuFTGYO/xoeSv7EElOD4w0u8ZKql8cYYvhn4r9xPrgU5/Psru?=
 =?us-ascii?Q?5tb6jN9w4fALNS7bdJnWszle9MC+LWvlR6/yKq1gceC7TPvSYLJc1exEJHpG?=
 =?us-ascii?Q?+C3DAscSKD/lcxf+2VpunP6ijxeayvId07ZyNWqXcpjHHm3JsxZaRJYb3Wvb?=
 =?us-ascii?Q?IH45yzXe8vHEaXiEIdL99XVPldh8iNoedISzhnrVUuH81jEkAdSoMgHFsv71?=
 =?us-ascii?Q?SbJtc9I6VCkT0Es4SvLgel9OXALOIrO3qb/BZrvlMP4m9RlXedWG6Ne0kKTT?=
 =?us-ascii?Q?837omLIATQzuDCTnT5ySZcfDygXWOaegkkGk5Kwl33b/IKFNkB6AC1e3jiuA?=
 =?us-ascii?Q?XBUWbfaRpJgcHDsJwNEjUuAZg4gA0DMZm9d1WqZtcqiqTNr/ETVagEkT+VrH?=
 =?us-ascii?Q?ZO6rcDEGpAdzk9z4ZDye1l4qYfku0QHw9ViNQFadYiAd/Jsw12HxccbjRw0c?=
 =?us-ascii?Q?XulDOTOJ4q+QgG9BeCPdihFDKn6e8ZtRaEhgwsXP7ugs0i4bbibg/sMRcmPB?=
 =?us-ascii?Q?jK24/ArnsK6ZqW5PdfUIK2z4GRwrlcZiRbEWGP4BV1D8YyRp5P8gzEKwO7xa?=
 =?us-ascii?Q?msdku/fSJ3LRW196SiqL6yH7/c4Qzs+9umelwyAAWpvcuu0NxMhVVQtYS2dg?=
 =?us-ascii?Q?ve0roLDoRBSnilnJVoabDtf71LKc1Eh3CnskXTdTUdkuFeT0ZMGwyxj8UCjV?=
 =?us-ascii?Q?YA=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJmg1Pk+1fdkuh4AaxYQTRLlqkyUmV5YSpnuzEK4/zhmwVfEXkXWz0uMkyKxhkQ7MjOogU2JFlkaYNRVq5aFVPAoYo2OXzUMvFSI/Yg9HcgXafo//cpq+RagOAS/EBvOp/Gjke+kzijgUSXvHTrkBmbcECFtWNatb1GXlf7LtY/80P77JmL4ZT5SNGW/cH7U8TKgk12umEuNWIPihlNzJOE3Ew/e1dgUyCxYEicKV0HyzoLaVAQq5e41vuNxi7qgXFmDanqDUgPH08GPn/7+q1D4mRdwQtXhY5BcwF458+rU+aZ1Fb7w4LvkuOnfK1Azko/q1xvu/JZcgrUNlJu27g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X12+RVcYAQ+ph7dEHi5lD6+ybcXpJUdlj/smSpVh5Pg=;
 b=PDbK65VbY7NpNt8b+MY2KpOxMXAGbKbJEFqZmA6UHj4ipj/L/eOqoipw2ViKzTriVQVIpRc2BDXS8RLujfpTljonUSKBrmFWS8KPkKjRbnIKv7PtEsRNjo00qfCZPkty9sp9YXBYsJxSXkhUWUeeSt12oq4lTH8dRMJeN/BTA2NtGF+7nd45dZ608J/5JLjrSu7BT8GhtWe2ZmB36B70EepveRwkNGldSR2FfqyUR0FRl4f12R7eP0NjFnLQRrj3lyjAIayvEFo4f211/fYw8wNTiPRPp8uKkkoeI+LKEVLgWJzOWstCOazmPPNe1cuQ9Tj8m4g8KySw84yv9faqQQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 6befde66-6c6d-4f73-19a1-08dc5a20f30e
x-ms-exchange-crosstenant-originalarrivaltime: 11 Apr 2024 12:14:34.2396 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: aBRkva6byFLLWAyMYkBN7d4l77vg4JH4aIeM/uEEj5j858hBwPrAba9Q9Qg179AWX1sgsqctcU3x0fKYK/onjxo6GDMa0UbrpqTYWt3vaS9plE11u37xI2Y7W/lqyLFF
x-ms-exchange-transport-crosstenantheadersstamped: DM6PR11MB4657
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ateusz Polchlopek
> Sent: Wednesday, April 3, 2024 1:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; jiri@resnulli.us; Wilczynski, Michal <michal.wilczyns=
ki@intel.com>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@v=
ger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Raj, Victor <vi=
ctor.raj@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; horms@=
kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; kuba@kernel=
.org
> Subject: [Intel-wired-lan] [PATCH net-next v9 3/6] ice: Adjust the VSI/Ag=
gregator layers
>
> From: Raj Victor <victor.raj@intel.com>
>
> Adjust the VSI/Aggregator layers based on the number of logical layers su=
pported by the FW. Currently the VSI and Aggregator layers are fixed based =
on the 9 layer scheduler tree layout. Due to performance reasons the number=
 of layers of the scheduler tree is changing from
> 9 to 5. It requires a readjustment of these VSI/Aggregator layer values.
>
> Signed-off-by: Raj Victor <victor.raj@intel.com>
> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 37 +++++++++++-----------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


