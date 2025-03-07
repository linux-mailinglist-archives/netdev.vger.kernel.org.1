Return-Path: <netdev+bounces-172959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E7A56A72
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944423A26A1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590921B8F5;
	Fri,  7 Mar 2025 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lk2l1msa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838871547C0
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358037; cv=fail; b=hOXc+VCzqvZXz7WorCOVeSOECbo1cUC3Ej3B/eH8sjpQA0b+/bZ5gnkm1oYvVpHBJJakUTXInGwZlwwzWU/kWZ4FOE0r6AS/tG9thK73WVGIMhY4zXqnZ6KXqRZnOpJtU406ppTwT38893AnBVJnULxB2C4N8UcZZvkDx/qn34w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358037; c=relaxed/simple;
	bh=4hpvCKTgDRzEEEm8Ojo4HDg6mV21mSkfqVSxTdRrYc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qIc0mQwbwMmbEBAt8q6fz2FwPBMm/6PYLdBjig8bs1zj+UN2042kEfRwcwe4OaWK89O77eIiVXj/IBsAJwb3CplCV06AInkEL9lMUUVfwGve7FGpsgbcjba9ctJPJCBQIcgi38LIUP6w7SIPK8EHklD+Dccp+XJM9AohOf28xJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lk2l1msa; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741358036; x=1772894036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4hpvCKTgDRzEEEm8Ojo4HDg6mV21mSkfqVSxTdRrYc4=;
  b=lk2l1msaHYrbP3QiuHrrL42Kjl421bEN648aLJ6URYAb+mvQCGcEna9i
   4U5QAEPpHwSdu6kyj+gol3HpDSiN7+ADkHcPeD13UqVigbLTVqDq0Qhzl
   e3TXuBnHDlCwrUMsa3BB489fRIENoaxh1sb33U7LN6M2F+vux1rJsQUPf
   lYoYaedmx4Ffe4CkyFPu92j50hiInmb1TyFN+5X8xrGiaJlz5Cig/u2dC
   QddaQLCiTFvjZBrcUh3cCddaG/rwD2Bz/xNqnR2Hb1eEEdVIHq5aQrVQW
   oc/jAN5CSHePjzz9RIX3rKOipztg3h6Txb7SlZBq+gQW6H6NMbAG+CsRA
   A==;
X-CSE-ConnectionGUID: SuLDsVRGRnKbycQIG/zd5A==
X-CSE-MsgGUID: bnfjqiOYQCqXiUcI239GtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52613605"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="52613605"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:33:55 -0800
X-CSE-ConnectionGUID: jpUTbppdSd+hmkdr/9i8XA==
X-CSE-MsgGUID: 9c9MiUi1QLKUfo5VhCWsAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119165004"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:33:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Mar 2025 06:33:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Mar 2025 06:33:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 06:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRcPnYQeuQq4jM/PI0lyUCLWmTHEjKqzcl02s+gMr/48m1NO1ESoJUvf/s7HYmJXzIKg9LBXeyj+2eS5TH1oUh271YLOghDFJ/P9hZL7IuFXVYR654DM5HB8Jy0CCt07+xQbnv/o27uP4Ki3w64zdbsSjZ2V0Hz2Aaer0Qr+toB07+Iq9M8dTgVSBVTtDU7vf9PxfFpLeehiQ5g0wD3coeDOgUc3o1WaVDAH0x7JgSbfOmXgSyZSSDCHUECxUX5fLMpACM1VXfm84+DNG+UaB9lHNaUGWYzV7RW3Hamd5LvOHQCpWPH0hj/9h/JSIdViYDKDMOVmb6/REpYe+yOxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1gv1CbYVK/9OxFnKqsDF0ZfEsNds3hLvpIgl/Dpank=;
 b=XDKUd+/tkWohq6PO3Y2DmuFnSiv+QS7f7IYQROUAmQmPDTpi7hscyqw79fANm4MAu+BEt7Gp0gvmK1rivnh5+NKgS6rNwK/OOAn6LJq9OydTgxvOqoiOpKKW6SPaH2T5WG18CMrVdgHMNPcZZJRmZzLnBdILvgnNRqJKe8+0FZdtHFe0LIq1MCS3Uo7ZS5JMgmDZJtXezdZvbvbX4cd8uJo8GV/d5btBgqQ48Psc+hUvNGMKEyJFB7ZXfPD5apuc3kyoiDAihiQF4SQmr7KLVCnZg/Qsag4I03/qptiFjMFoaY28Z+J41LfDTZZ9ymxLX5dpT3L0LKjoriTEZO0qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by SJ2PR11MB7669.namprd11.prod.outlook.com (2603:10b6:a03:4c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 14:32:32 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 14:32:32 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 1/4] ixgbe: create E610
 specific ethtool_ops structure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 1/4] ixgbe: create E610
 specific ethtool_ops structure
Thread-Index: AQHbjDay+eXvfaF+/EqyiO5yUaQFzLNnwscQ
Date: Fri, 7 Mar 2025 14:32:32 +0000
Message-ID: <PH8PR11MB796533DF89DDA533B73A1D63F7D52@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250303120630.226353-1-jedrzej.jagielski@intel.com>
 <20250303120630.226353-2-jedrzej.jagielski@intel.com>
In-Reply-To: <20250303120630.226353-2-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|SJ2PR11MB7669:EE_
x-ms-office365-filtering-correlation-id: ff121128-7d93-410e-50f2-08dd5d84e568
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1ipAm6A07huIDu5tyihT0Kru2firuCSHjNkQ2MYjldZ5LdiGBav+EJbX1qVa?=
 =?us-ascii?Q?DJaEHaRff25jqHsqH0/9VM4ELZGoUmWTj6ZzFgBQCHefRqIDTarGkszLQB41?=
 =?us-ascii?Q?Xjpa54fVEWeMcKNcTnVmbljm+ovSQ4Wq3Xe8a/uPtm3CoVQyaTpFSAKmAGG0?=
 =?us-ascii?Q?30HDseOz1R6c9wGNFDJVLvQdAhfTdwIeCZK/QoXxuumA8eNszG/9Xuo9qhdT?=
 =?us-ascii?Q?90VL08ZDlW8bor6YNz4gMNLb+L4Ik2KrzXRrfWBV3C0+nvTP6qBJ73yR9SxH?=
 =?us-ascii?Q?PEnaob1UUPACflNrA+8DEgOrUA8tZvqBJFNv+Q5FKqZ4t79+lvVMViNOAAyI?=
 =?us-ascii?Q?AcCaNeDYKvU6GmA0WtqQ6WwZ7R38xMwGEPRJzTSeLuDRUbDDUPrvKnKb3Vh+?=
 =?us-ascii?Q?xm+wL+fLRvDvthfFgUtKOwF+RyHWDa8bqFVaCWnJrmQa4dZuGv3NyQn5gPH+?=
 =?us-ascii?Q?U6aNo5FmnKEDwTg9Jn95bGy/jCnbWIiMSEGc8VVgrC8Vbi6j5gaLMcMfXO+E?=
 =?us-ascii?Q?YcrybmgzC7e386nbMSMvCKhDtQ9sKzP5bPhA9HS4pfgmsiINa7Eox2iORwDq?=
 =?us-ascii?Q?B9SPGiQVC3w0NJrafgu7v2Hx+AfjGm27Q8/MEI0G0w3kSm2Tbgo9Hl/fBgrz?=
 =?us-ascii?Q?UD/IOvVzRxd7zGUl/milkyAN+MbRmdDQfPbGQbP3ImEY9iLNP0MRnxccSZ79?=
 =?us-ascii?Q?yBU474S5g2hKFIZmZhlYTIMrhhvTp4cNbowrKxwG8f3jiguIPYwVc/DMCUe7?=
 =?us-ascii?Q?SN5srIvW4fM7psotaFrHLBF7DQOGwUU1DRPzzzOmJ7kjgPmFWH0Lq+8UTyZ6?=
 =?us-ascii?Q?B202n4c/tPBqDIJajOrIiMPvZVLm85vjjPfpxzCYVnXwmK+IyRBsVmvnvvN7?=
 =?us-ascii?Q?vt6RqjD6x/FVTCi+FL6oynuEaczsP8z6P8+jhvmEzrsLPDBYiFVYil4GrOm4?=
 =?us-ascii?Q?4jdSog2KmVIVN1gILoGDOsD6kI+Zja2zZpUcqndc67ZJbDwI6Mj4VdfELOOl?=
 =?us-ascii?Q?RcySG9ppoAYDGz7287wHStB0fJ2b/fUYzl+5YE6/+uBVluCpo9K7fn6wttQT?=
 =?us-ascii?Q?q6PoHQTqq8k2dOOBfI/kiBq5FfufXkh3fQrTYIxOyvrsGt/qt/ZCGTlLX6V8?=
 =?us-ascii?Q?iklZP/QA6lfk2dMsz0aijW+l2Q7OQijBabX2grUdG0CmnoWkH3aVjn6OawRl?=
 =?us-ascii?Q?uz8X4SGi5OkDKP2xJJgn83WsdCDft4e60U5YvR+T+91QQ1TQFZ5kxerJqQei?=
 =?us-ascii?Q?CxQKtu4GSbiH7U0FWcGl268beX2AVjH7sCkBDWbAvo+5HDbsB6gp+gYMvkfa?=
 =?us-ascii?Q?CIiZdlF1E8YAjEsiiPLWMn7C+533//5laxqT9lS1/VhiS0FQakVD/0Gf/KVQ?=
 =?us-ascii?Q?1u4JMeNPUHeMkxACh+IS/7daCMNxzkVqW2FPAjvMzbSfL1gkysDZoYqN17Vc?=
 =?us-ascii?Q?73OQ9QCESDUd/KQSINaaHojPgzCxkVEJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nrMKKAB65Y85wTuLwOF/eUa/Br7oEoVvIjh5FqCZM0gNnw6r0LMuPtpxGvTa?=
 =?us-ascii?Q?J1VBoCyjL4ZLPkP9QFeCCQxmjMOkz2oe8+64mZ5S9nCSYw6rFdaJ6PC2bdgd?=
 =?us-ascii?Q?O8Bu7TZEoLWsq2m0iHKe1Ys41hN9Ux0MzNrrscLJOOVTKl5mJTFW7P+UDSmb?=
 =?us-ascii?Q?SUms52FkiwRi53aAk8zosxBrCMlx3wtb24wFVpyobdh1K6KxKtHS2v6raREJ?=
 =?us-ascii?Q?0aGvK+ztHNmUJtAlqOOAvpUYGYdEUHdM6dv0Bke1u1cyZX+ojv/5Am1KkRcL?=
 =?us-ascii?Q?+O/YawDa5iI4xmPRmoXYFRIjA1xay/9bMr6RbVqJQ4v5Ew+ktN14M3ztutrH?=
 =?us-ascii?Q?K5PBKF527alBYA615xvgoHi34qZdDt0LcwI67Qn4bYymtYfP1t1fCFyorYiP?=
 =?us-ascii?Q?p8UZXpYtCrplP9PPs4+9o+WoD0qJU9jri9Rf380ZcpAACY9F2gbrYcDdT4mz?=
 =?us-ascii?Q?TZfSKmKJ1cYokIMKBT6GTZxR2iRd9oid/XPIG1ZvAR6Q1E+brhgt+WcGB3qk?=
 =?us-ascii?Q?9/QToAMOWSw544oc5a511hNfdgakw/WyoiVJg/55gkvYfOlGyo+CrOm+rytr?=
 =?us-ascii?Q?K4cd/G7RZxPSTVGzVvf7YeUsqXJjVoR7qG2W+D335c/N6/Hdt/W8PaqNoc4Q?=
 =?us-ascii?Q?guAZgVjsvu8IP5Bp4ZwTWMl15Ytd9LaIaaPobwbfxZbKC7xsD4JyKj+pWSk5?=
 =?us-ascii?Q?T4kbdpsZFh/Wuu2WRcLYyf1JcFi5Q6EMsZdubL/DUgww8ID16RYwX17/N7ty?=
 =?us-ascii?Q?nvk+01hsIgOF3qMZQ2qi0YdLPbTAYyVbllPl/Z6MpIzfKSIDVDTSUSoO5ePh?=
 =?us-ascii?Q?edE6FyYjuPumKMSxpJy+XcHc2aSDGdriGURGSef6lNjvWNEw2uTMbdIvVtYN?=
 =?us-ascii?Q?RFtVmqgH0gP3ww90jMw9Cn3/278SMEUAcdMAEP7s7iIdJWMzzVQK2EiGcBML?=
 =?us-ascii?Q?URdw36NOKiQIF1h3iAtaFe0l81p11jNRSY6kLk4L/uUQxuE0rmL231/LV51A?=
 =?us-ascii?Q?2YGVwAQtFPr0BOzW7L35Unkygh8OAxgPru+0gb4rHIqTgYvMNWKZl/gw5956?=
 =?us-ascii?Q?U6F6La7/cojiEoUolHhp0d9ZbvMSqw4eNWEV/DE8fBM+actmVkscehSPvY8H?=
 =?us-ascii?Q?7WnjlAcHqvHJtaQ/bZyFMrQseOnGFpU9WS8lg5fv7iXZJANZ1OBn/eSXkSbk?=
 =?us-ascii?Q?KBwfbD842ZsGvz7bBqvQOKZfVokF/meNYFnYGhuSDXt03Cc3HEQvmKRLQL7v?=
 =?us-ascii?Q?cUZP4RaCAYQ1EmrY88kIUE+K2yJBCV5A2U10WZV+gzG+aboNozWFw+m51AYW?=
 =?us-ascii?Q?QwiGfIEgVW67Gco4Z7Ql5QZ5jZDG7IrXEvXV2E0vNSRo+edmUVWdh2gQSW/W?=
 =?us-ascii?Q?1I/2SxT14ORaDbjhaKqG180B/CBQ/jCJlAUKF2TeKFuaHibpcXwzAderLDfb?=
 =?us-ascii?Q?j0LOr53c6BNEpVfmQmdqapm8/DX9U9xYIynMJVS5USwbRO/l+X/80dc9JeiJ?=
 =?us-ascii?Q?fMWHOf2VXVob9giLuj1yqoNyoSfCPAPTE1m7juQZf6Y0DSgwlhO6hoP+APWj?=
 =?us-ascii?Q?yYneiDoNpitVgg5iElY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff121128-7d93-410e-50f2-08dd5d84e568
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 14:32:32.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfrX72rxtYab12HCCVEWuBY4Q/jfdUlh5JrLjQWkbyPOajZtBZCKDU6IjBENScXTOyHfDuNaz/VxFGiCT3LLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7669
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Monday, March 3, 2025 5:36 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; andrew@lunn.ch; pmenzel@molgen.mpg.de;
> Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 1/4] ixgbe: create E610 spe=
cific
> ethtool_ops structure
>=20
> E610's implementation of various ethtool ops is different than the ones
> corresponding to ixgbe legacy products. Therefore create separate E610
> ethtool_ops struct which will be filled out in the forthcoming patches.
>=20
> Add adequate ops struct basing on MAC type. This step requires changing a=
 bit
> the flow of probing by placing ixgbe_set_ethtool_ops after hw.mac.type is
> assigned. So move the whole netdev assignment block after hw.mac.type is
> known. This step doesn't have any additional impact on probing sequence.
>=20
> Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v3: correct the commit msg
> ---
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 52 ++++++++++++++++++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
>  2 files changed, 56 insertions(+), 6 deletions(-)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

