Return-Path: <netdev+bounces-174165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7CA5DAEE
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32ED1896597
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE623E349;
	Wed, 12 Mar 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPnT+X2J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B023E348
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776944; cv=fail; b=U0ewfbAmWJm54Fcu3VAihQ5MECc/wjnarBDk1KGvGg3DFVpoRC1GcDZVwokGhJ5uVqkJozMCa62oSt7WTX7ZQpstJAtcOiqUeu/foKNOkFXLHik0/EZDHq5H150pIbp4Su+wxImp/KGNa7jeHZaBJum4hYqQQZ43UPmgmA8MmXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776944; c=relaxed/simple;
	bh=7xl0nQPamqS12r5mNkc/JzEm5Yzg4JKqRoQHJj5VCzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhlrfU0eAnTtnWHLgtmB9t6Ntg9AeXy5FCuPpeEMWnl9d/zTNMkazNbzBiAuN2ns/Qk1f5XHzkyX1HaI/5I3g+G4Kl+f3rL5ij5Bopr5ubBJOkyofB9Zzt6ECb05wGsyOnNXYyX7RgeeRgv0o4/NyaC+rMqkobanDSFLP89gqu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPnT+X2J; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741776942; x=1773312942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7xl0nQPamqS12r5mNkc/JzEm5Yzg4JKqRoQHJj5VCzU=;
  b=bPnT+X2JMsaj7QH9X11hg4icZbY9bsGi2X5FIYhAsRYPezrwKS5vwl9l
   FX2VFM5wuF1cRGVvkcaWdCKM+zKGR9fBz4XYWtRdbp95cw/BTvjzZzYN0
   BtubkiDowax7Plag5rlUh5YTVGr/NiCoKRnBxiu00XCt0KCdSATlNnlEZ
   vbAN2EWqKgp6gXtV28KcNOTvymP56L3Rgsv28JOO8Y6L5abZDQcKJkSWb
   viBXLiaVR9CGukJIbJ49PvfwE+NRghByu4nr9ja2FxqKeCytFDRZWBBEd
   ArfvBGdDWqksfrjO2igUsNs6hrYkNvyoeGr62+vGUi7L+6ovjPsRLHkrW
   A==;
X-CSE-ConnectionGUID: rc1hFMtBR6mBUMJ83DIHPA==
X-CSE-MsgGUID: KowpkSdMT6u7GCq/sEUjtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42575356"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42575356"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:55:42 -0700
X-CSE-ConnectionGUID: NKYTPbdVTuW91Slea7lJoQ==
X-CSE-MsgGUID: qwrJvjGRQLOBQ10cBd9tLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="125651836"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 03:55:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 03:55:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 03:55:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 03:55:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGfS+6zwcB+0FafPScypXuA7HG11knkdopRDkvu9dFhhRBP3f5iOvYME77Dgn4Bz8fdru7Y7ZHM7P8xy7VgQnaVU4fbRIj0AOUypYU2Epfr5FIsH3otyLopKz3gRXGBgfiqbJA1HaIKZn95QKwyk/6cPEQ4kBzDAu8M5lodOL4ACcTniUuQclsQU8ytRTnTfTaOb4yV/jGxA7f/y1chzJGvJiQfB0FA1pnD9C/gmHje53tik5jCMu/w7KIQjqAeBD0unsq4Z8J8HU7a04FXnNinXp4KKi0RLIls3RyZM37tHoxmtnE01E4XNGQRCeR3Ni2YZzQjozLbarjDpIYpSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbg/fRTS++j/UBnIkzydC/meQnfnj/wi5+Tcj6J82uk=;
 b=qoXa3hAkqivLPBBbo7sIdB4ed98n0eZPfN8aEqq44ot9obMcEOGuB4un8xJ2prPUceoa4N7SzC28+T2cD2Xb4+kEtv7DRxY7zaamQRD6qUwr5KKmj2MUPLw44eDq/+ZN+FI/iKm1RvrpbbX22xpvrcLzc7zIg2xSAQ8wKq8id8FWH2vntKnwd/dDhQAcnKCBOCgscJ33aucHFXUzNTEYUpfre9b8ulTyUz71haonqRDsXUZLRAW4TKdYZ/FjBz/R8f3rYLBBUpF41JkuPrGhBnh3w1qp/ho01J3jwc6Q0On79ZaEPhBdkZ0miPWykCQLCwzv40MjEHB14kZkQx9GBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA0PR11MB4734.namprd11.prod.outlook.com (2603:10b6:806:99::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 10:55:37 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::1d5f:5927:4b71:853a%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 10:55:37 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "pierre@stackhpc.com"
	<pierre@stackhpc.com>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net v2 2/3] dpll: fix xa_alloc_cyclic() error handling
Thread-Topic: [PATCH net v2 2/3] dpll: fix xa_alloc_cyclic() error handling
Thread-Index: AQHbkzSTKO+DPcJ9dEmcsS8Cqc1karNvU9cg
Date: Wed, 12 Mar 2025 10:55:37 +0000
Message-ID: <DM6PR11MB46577F384A43509EB63A38819BD02@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA0PR11MB4734:EE_
x-ms-office365-filtering-correlation-id: c52c9031-4d22-4d41-5af0-08dd61546be9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4VNW/DE5Xp5cSnTJ14WZgexRHXz9ed9rbD7CtQ7rKH44gUf4C2jGbJNwhdb9?=
 =?us-ascii?Q?8ZJ9hLW9zeYC21O9d0ZHisUJXgC1vmLgEv1utfdWwchGPfuV1gAGCsPDjhX/?=
 =?us-ascii?Q?5At6k7LCWI6CByVKYs9XT74S2KUsPMKNXBeTZnYAENkVdIrA7woWlIAXML2G?=
 =?us-ascii?Q?6bzErcLKNZFbjZEgQQvR5/Jw0dYeYVcGIY0xdLk2RrwWKPirODU4Obj4m3ZN?=
 =?us-ascii?Q?wCsL3/54iZtoDS3B3a84qEoc0WmFkoZbXYWR1T5oxAGcGgzf95kPr423bA9a?=
 =?us-ascii?Q?hbAcTSv73ch+KE39wJNp9SwDCiYc3Cso+4SDCMcSxP4M00sZyk1BpflYDXtP?=
 =?us-ascii?Q?QxTKWof4c0RsEYEznGgWqoAXky5KtzUJroHYoSevZQhjjm8LmA+0XbMjuUXj?=
 =?us-ascii?Q?D6sCqh0EN9ynoIPPDvsM32qwrzR80lzLrcGAHW6EER1LeJNNiAA/c+HqmmNx?=
 =?us-ascii?Q?BkkqvAt6bljIZOQJIZTQp1q92cju3RcrWZau81SULQa3bM0Uw04PLa16upYv?=
 =?us-ascii?Q?F7Uow23Z4inkbk1GPsAU7/ZF4GONWYaMClcPCvhSaQTEay7Iee5/s/RDZnT+?=
 =?us-ascii?Q?o9cg9dpt2MILGeTHKnbOxGVSSaVga5RBAKckCKthZQZimCATSU8Bd+Iz99N3?=
 =?us-ascii?Q?ufRiUqv5D83YmOaWnwjKTt95E0La9qRM7aSZ/5EbgPBkP8Jvz1fJh8OiKWWx?=
 =?us-ascii?Q?hwNkIgg+XW/CU3cuw7AirhCPwsAUOfu+KnXp/g0+cUZ1snGhEe5yL3nDzfl4?=
 =?us-ascii?Q?nH6I6n3XEBt90GZJ64SlCVUHpxnW5+DX+RsNNhYDeuklWuN3LaZJaJlyqeJS?=
 =?us-ascii?Q?DD1T7W1t54ETKlQZNSxmnDXJbw82nmfmpnn9lLtULsC5slUZ46D6wQ9buLpl?=
 =?us-ascii?Q?m9CQe5rWvY6v3gHhrtrDgn8w5z9RgCnVr+9yJlWxCg63VrXCE3BpxuViixyb?=
 =?us-ascii?Q?iqFexm4wiqE/0jHAqNoItZm55W5vrg+qS2jwVGdDQKeAorz6JXVq5keRHorW?=
 =?us-ascii?Q?6y3vrhbl0CNW2XhYstOgZcw8LZqEgYSoavyMu4Hg5KC+rb90rhCqvfhLFySa?=
 =?us-ascii?Q?G5ueNh0AU1GVbIvoMX0tpdJrU54UBYFwizWxADVxtvf6KNbVgFxw4lZpW6bt?=
 =?us-ascii?Q?I/f9B5KWinf1ykE0VryNrZZM5V20W6+yD4O9lVOe993V3bKkpFgGpOlziIEC?=
 =?us-ascii?Q?pTwAWCasP6w66f+JXZLPoWrYBWQaF1pwVj9GrdbU55udPWBhHn0Xz8CPSkc+?=
 =?us-ascii?Q?c3hV4rnlO0PnCAKRzbXAl9qw/RrotA4hv+xVtwfCzCOlSUiBFK1rJrb6l/9i?=
 =?us-ascii?Q?TvM9mg6dYSFnwL46tlSm6nexjOKkXiOLPWVLLZaoJwgmyzWwppex+eLSdRQH?=
 =?us-ascii?Q?E82eaapJw6+g+gb1cQoT9f78os1TR3siKHqNzS7yvgcjcjCBVqsUlNKNNl8y?=
 =?us-ascii?Q?LZmz1AVNRSwYve/pinW5haPKr8oKlSbF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XmEh8bF3+32q2JHaQXXURLf3qIhJ5FoQxEzBb8CM3kdfof2r6oGm1l0KcFBO?=
 =?us-ascii?Q?wfKSCPFikRh3ESk2oq0oMII8vu37LyZ+bGwOSD4GTlh4GwdB6HNQ/Zn/YPNB?=
 =?us-ascii?Q?cur94ShnA49tt/AdImYimBWxrrDuvDhMaOyIAWNIuBq/s3Na0ICeAcT8jTM/?=
 =?us-ascii?Q?RHKRX4/iphjhb2n0VufmwCAO+KLSSrfYz5NNV+xhLyiIWI/Pc6s1fv2qnL91?=
 =?us-ascii?Q?k4Skw18ftHil3c+EJ/qV+eYQVAOXyOdqxos6wtN9BBTbxMC6mACbMK/sOE7x?=
 =?us-ascii?Q?vLpzY2Yn/2twlqyAlizqHmKlGAr1CZOXH6H5tl4E+nAot+J6TmTQW2NKdVaY?=
 =?us-ascii?Q?kmUwWSvjAgxaXc0HMGsxypayfc9Q7I6gkuvWGxIOGynlIckmGioMDF/2MGZx?=
 =?us-ascii?Q?mijBziDb1R6Ce9fGPFZ7+4tVhOSn6UDpTO7EhVRL2u0VnApAAcWb7BNECeOW?=
 =?us-ascii?Q?/oFQuYRHW7naO7hKu2D1OWvnRhXOJ8BUNh+38fnOFmcrchS1zs505jTpFeDE?=
 =?us-ascii?Q?Uc8gc4l2lTXfHCc4477BABw71BWrkR8WnD4Wy2v4dIJvpp5hJXUMAvLhCke3?=
 =?us-ascii?Q?itIdlTVyNZUD3rT8cmS201saK8799doLizdTiyhvzdmihdWit3DvmbxNJ+cU?=
 =?us-ascii?Q?umDYis4NqKMxha2TKOSXhCOP34rIQYtMLP2DneY5ZzvVZu5M179apAqCAK/B?=
 =?us-ascii?Q?CwYY36ID3kvs94ISYxyGB2Xcc+Zdeu0hNx/eNMJMMucbqa0pU/mesunCUsmk?=
 =?us-ascii?Q?thkr86slo4d1W7tQkdkB9EBezMz+CkL2w/iav3Mus8WVhpKfK3WwzRSyYzZR?=
 =?us-ascii?Q?v0qGMqtheIuztmX82qkhexbKntqn9LfKAkQ2pwA3fkKKnGSRXqAypiSm8Bi0?=
 =?us-ascii?Q?dvXuTUico+uKsH4RgNqHzLJ5HLydePmJQtNdfpdYl6D6+cHIHLDBCUgYAuRO?=
 =?us-ascii?Q?899OMYsg7dhjRjHshMUKzAz6x8RsIzR3lp+VDXhm7ISAdFcIxWt+L8IDq3Pp?=
 =?us-ascii?Q?4y/ngWU50Tw0J2s+uS2QYv4D9lxHB+KA4xXIyZJhHj5Hdz3eI26z6bcf/H8i?=
 =?us-ascii?Q?SJ3pvkXWY+le3yi9pM/I72WfJKWHgsNQvVM7/6K39y1jLHj8hmpZEmKMpWf6?=
 =?us-ascii?Q?kZUPRRZBHkNov7WZ9clxTghBNWG4CN8gABar+OcrK9fw8nMOkxGhxjF7Fka8?=
 =?us-ascii?Q?tebBeGNSuUvEO945KMfoViQZrmTmPnt446ZT/z5x/GfIWPzMS65yfeexgJkS?=
 =?us-ascii?Q?GSY+70MHW1M35DLZNQ4nWg5J4YEgOBjqBSQTiy0Pmh7lS/ThOnoCJ1RZ8zzO?=
 =?us-ascii?Q?sZWJWojYkQPel3a7HI7XS/ZDG3WzLEvi4jJPSnLtfdiy0FnQX+OcdfU1aStz?=
 =?us-ascii?Q?Gzp6x8FnlvTbkcIsCT0q4zTdn9A69ChbLbbRulo1XEx6oS68otY/b5BrKdR3?=
 =?us-ascii?Q?DuzF60tBHJE79OYeCBAAwiiMW1sacGk+YjqX9RYvmVyOQvW74n5Y7kT9KTaq?=
 =?us-ascii?Q?oCPm+MTWJlZhk24SnjSXrvuvnZyN8/IhEyMX18tV+eKBc0eriEQDbzNfBHNR?=
 =?us-ascii?Q?ZGgEpdtZs0q1ApWe965MCC9GqWao/ZCrqPPD4n6cw9JxOOHpSr2BH+Rs7Ait?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52c9031-4d22-4d41-5af0-08dd61546be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 10:55:37.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMC0KhmDfu0go7451oiMfHhI297MiEJ3IKJXTipM/OOI0mosl/Q9xLNP1As/7lKGN+tw/pPkIYfnkKL2s0GtdxI7uvIMjDF3uM6IUH9JTY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4734
X-OriginatorOrg: intel.com

>From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Sent: Wednesday, March 12, 2025 10:53 AM
>
>In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
>be returned, which will cause IS_ERR() to be false. Which can lead to
>dereference not allocated pointer (pin).
>
>Fix it by checking if err is lower than zero.
>
>This wasn't found in real usecase, only noticed. Credit to Pierre.
>
>Fixes: 97f265ef7f5b ("dpll: allocate pin ids in cycle")
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/dpll/dpll_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 32019dc33cca..1877201d1aa9 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -505,7 +505,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct modul=
e
>*module,
> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
> 	ret =3D xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
> 			      &dpll_pin_xa_id, GFP_KERNEL);
>-	if (ret)
>+	if (ret < 0)
> 		goto err_xa_alloc;
> 	return pin;
> err_xa_alloc:
>--
>2.42.0

LGTM,
Thanks!

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

