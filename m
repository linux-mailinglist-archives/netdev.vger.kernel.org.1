Return-Path: <netdev+bounces-180043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D2A7F3D7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D014A1898A00
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43D1CAA89;
	Tue,  8 Apr 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fts+rp4z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF718BC36
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088151; cv=fail; b=mf7/PKokqqtoQQQuEN1SapvCmhJx7jsPEpBRi1N0dhLOS5U1tio0yx0b9ZKMBWOTzOGXkxpSw9WQaJuXjD1UvW7Z8dJA99ZwyS2WunhAjHpO2QaZhpGw+mBky+e4OSwNczLaNDGT3eoEDZufgUSvYjcJlWSqMAw77iBgYB68KC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088151; c=relaxed/simple;
	bh=gnC1agaE+r+wdKAc5FgOeFOncb3vVpEQf9YCx6o7lk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBMD4PMUWFr0YcELUDzTFwV87/kUKodMkJT2dzA00pu2bQSKAtwdR+IfAE7ObWlqFcq8VyoR3Y0NNTBp1HVRDfRDxRaar8KBWpg4waExEV/ZB2+QRKsRsCYNioL0NcBKnHgyf9xX/++AnNlKpxDXRnroSUgg7CFLDSGE3Z4aE+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fts+rp4z; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744088148; x=1775624148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gnC1agaE+r+wdKAc5FgOeFOncb3vVpEQf9YCx6o7lk0=;
  b=Fts+rp4zOfyPwSjIeTL5A701GFSePTKNHyLfsBAJgctUCVUaheXYudye
   IKobKryEEJzDxVY5FbjJIkEJH+Wf2O4CIigxXZr0s6iH5F3j5ncc8Ys5v
   N44IJYkPAs0JioAtSD+zw6rYBQzshvXUIAsmuNnbfgoxvzYoY7NASrUS+
   Ed2VRP4wtRUNutsWQWiRP4HqPeHTYUv+WePmqz47Niqveqe6DqbaHWT68
   zgBC4wdj19fkDaCtElZ4oh4AaWac1neNBu2+eba18xO3ACV+ZCRuB29ZW
   xgZTkxgF3/GbO1bEo11e/OlCFm+5HniDhEeKszjHiYn/I1H7MxjPst4ii
   w==;
X-CSE-ConnectionGUID: jr8cBd+sRrCXg2wje/dhyQ==
X-CSE-MsgGUID: QWc924lEQ+WfZk/hp/W0/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62903270"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="62903270"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 21:55:48 -0700
X-CSE-ConnectionGUID: DNyvs0I0SeSRkWoJf9jpuQ==
X-CSE-MsgGUID: IEqm6LdHQDOgD0bWblgtZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="133309802"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2025 21:55:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Apr 2025 21:55:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 21:55:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 21:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKmDxMm0kJCqamfFSQg2pl4kK3xKBOALCGYOvQAbGqP7Vvek5ajROWgtNRx3FolLZVDG8ujaBvU8Gt5hfKX14RnxRTgnb1r8JxAnd4EyBZq4u8lNErXOtaURb7PqYkO0TwNrMPIngdVzoXMAjdTY7oUxyGvXo2R8NuJniFXz/0cgDaWVA66g8RXgrTZ3EskHAzU46mB8th0tWCUzwrddJpQlMnNf7O0iUyol8ZEKzjsdpo8codpHATGItM2MscOASX0Z6r/zdYq51K38EFtGW4m++6BuAsZhJYYmbhGmVBs528QBM7zQN4LHWHzTmAsGLQSd3Oqgvuv3nL+NMP5PcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osHq3uBmrrO/JSKYLNE6W+07PD/t//6trMG6MF1J4yA=;
 b=FuAb4hbjCShG+UITGLLHoaDaZU0V6C5JbYCbpq5fbzi8/Yx7zGrVfo1ROC2MnJ8JKmPUfa4p3YV0fd5fV2VAj6iStK/Hbr2RbIK/yfIGFpuONLNY1+eQDPI8qWHOW8vHpLpeakmfp4F3vNf3LJAku3QSl8B6hyIL/f4q0V6GxLFKBnjnx+jOgSl/aYlSJDbD1g9Vn9npnP9pURRNaceL0af5+UnnV0udLP4IkG3QaLq1dbictimZxjBPCYb+LFxKIq9OeuFyDpIniP+IutLG4y/HWWs8UjkxLgB1LMVi6/1Yb8WWzVuwWPIDceROXht9uXAQOGznPg/tszFONMAQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 04:55:14 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 04:55:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jesse Brandeburg <jbrandeb@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Dumazet, Eric" <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Richard
 Cochran" <richardcochran@gmail.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH intel-next v1] ice: be consistent around
 PTP de-registration
Thread-Topic: [Intel-wired-lan] [PATCH intel-next v1] ice: be consistent
 around PTP de-registration
Thread-Index: AQHbqBO7essJg8d+s0OhQYezwOT1PbOZNImw
Date: Tue, 8 Apr 2025 04:55:14 +0000
Message-ID: <SJ0PR11MB5866428A3D9E154AFA71AD7CE5B52@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250407232017.46180-1-jbrandeb@kernel.org>
In-Reply-To: <20250407232017.46180-1-jbrandeb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: f7816134-8f8e-4297-778f-08dd76598cc1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3HDmY8tYRVvNgRvGp6W3R9uciQTlPXLBnsxo49CnG+3ahXU5I9Kq7hj6BgB/?=
 =?us-ascii?Q?loM8aEZm18JNNdl1daw3vfRBSYIuyTnOdOwf4X5AD/xfDb742Bm+4gsp3rYI?=
 =?us-ascii?Q?ckOegmMM1tYLHNAPlYiX0X1VT7e8jLEc7QIyl4O9g76psFd1KP+VtvG+iPb6?=
 =?us-ascii?Q?uhj5avXqSCkL+z6kI1zhoDkRg6fCkIdboHHMj5U7LUGj7Nfhk11y7ONql/bF?=
 =?us-ascii?Q?TdDY5DPWObqADOgIr9oqqbfCg08D1GDi6YGY8yoNTcaWbMTWvdCaETGWeynV?=
 =?us-ascii?Q?IjzGKKG+W/0BDsYs/uzykZNF9oYAKp9zkl6gb431m9McA6LNXfQdrXWn/T5U?=
 =?us-ascii?Q?EyDX8IlP5v+2QTdNSW/AkMfOj5jF8ofHsl+D+aItD3clnw1SFQl7Y7YJlXvi?=
 =?us-ascii?Q?3EIK57ftqZ67svCe9vn9rYf38rZCNfnxmR/jQsYVnw8oG8H6RV1Xl3Yi5OHW?=
 =?us-ascii?Q?B0K2y7RhvNN+PyOe6SJUZE37MbUsSY5U5utsELPKwB4oPN/KRNDBAcvGDtva?=
 =?us-ascii?Q?toNVhtLdLKgm28EwxHlDbrzPwc0jm9js1DNqpNW6qOrGblviWzNsxNusBhJ3?=
 =?us-ascii?Q?/a8eUN8l9dmCYEIJ7n64INMHWwIr875WnrqJumbmTK4Nx2SgpFTVrMLU9mQH?=
 =?us-ascii?Q?c5ahJHHuTYt1aSw3Glh+0CwPcXbKcXfkh/Hfpv9hmoygeuRhTLzGEhCU+WTH?=
 =?us-ascii?Q?BYnayQDtWp/PVaDQkbjHEXnd7buNPKHyP6YTbdbDEU8OffDEYRqr1qElm1GJ?=
 =?us-ascii?Q?i9iTU5DjZT5O/sNwDoJ/3fn1BZ/5PTWSulZ5ywLE75tqnvCU45f47eziNZBS?=
 =?us-ascii?Q?4D91VtXDBkk6pyyFph5qfSrH4RYhuq555E8JER66bFzBn3ARWe/vb79lhN8q?=
 =?us-ascii?Q?zObdRQNTprHm6HEANLjmdVLTZHhKB1TZnJIi+evyJ/Sr6bBYyBE8wo7aUw1r?=
 =?us-ascii?Q?g1FQ3TdWSTjeMuc4Z2T5NENIBPFJEqn6nq73XE1TZKn1/j+xnY4Z3UZ9KwGg?=
 =?us-ascii?Q?fLaMUXYFUQkianSRoktvIKKCZSyRe1OAub17B4z78BOmijBIZCagInVAE92K?=
 =?us-ascii?Q?+4rpoGZr/8v5jffateEOEQdUmu00DcvJMjjM3SC1VmD95Jjdpxv774R+qim1?=
 =?us-ascii?Q?c4BLG0wwQ6bDHbdOWjJ6f6ci93CQIt9AcApIbxIyjSY4J4Krw2SYRGdNbKf/?=
 =?us-ascii?Q?HkrTGMws2WYkK0idLILdSF7VHWu8Ydb4plrO6EqgzMGhM1hFDyaJAkOo6wn0?=
 =?us-ascii?Q?26kT1DdYVDHf0Y0UthUQxMciM+b5ZZigqAf3TP2rtdW7i7g/5n/qt6BwLNDz?=
 =?us-ascii?Q?e8lHE1+PhdNKgRrcFlw0pObPXiqEKljlOpiHhanEVp65gnNPW3EzHOzgpJr/?=
 =?us-ascii?Q?/18oP4upUAD/lgDe//MULLxWLdzEYfHe9xVp5bD8JeIaNw7Qx9io67nt+Ygc?=
 =?us-ascii?Q?0UANlHbcjSaB/3RImnMGXXkG6B5pwJCcJlJOr9rUPO7WKozERj5GtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+85F+0NWqbPq1Sm2BTGudE8oFONNIaoc0pVxal3YV7Hn0xf5o3x7jkYuJZ3v?=
 =?us-ascii?Q?mobIt3cVp2DeVv764IRwvAS3WyxOqQMZ4H7OyZs8GTkYlzwgYyUfnPy6MJXr?=
 =?us-ascii?Q?LjST1nfG5hpOFvFqpYSMu1PeOTSJ+OU0MvdMUhduTAyH55DblfDDXn1rY/St?=
 =?us-ascii?Q?hbtOuD9eF8F8KyvivqeHeQkEfLtsqdZqnm31s7gEG6m76DKaB2R6NlF1YeSs?=
 =?us-ascii?Q?HlBzuwtEZBkFQ93eYcNvY+YvJYW7+eUMKhwGGAiKDMjiJ2Le+HggCRrB/lka?=
 =?us-ascii?Q?c1NsHnIyxDczWSlQ/zhDiCeBCxXYdkSbPp3FT+Q4NKoE1QwFRdykfdpATdAF?=
 =?us-ascii?Q?i6ylTG3QEEwGpsI1yezZ+3I2nic9d+aXB9L5lwXimfSsR8B7sgUgd0PFBQ0b?=
 =?us-ascii?Q?Lqyb+lfDbzdp73LMCzb1aHN7k2Ld9xgn7dAWYWyO1haQVyilZsnsSBaQgjON?=
 =?us-ascii?Q?joZ8a4S9++p9khSbfb28ujECRKrqFGaMHn76a/8/36OR4TNL45Q5/AVDRZ4H?=
 =?us-ascii?Q?KCBEid0Zwzn1PQOylJx2kGl4bMj4wAM8tpY82sxPJtSOTrk/Yt3GWJ40OgIF?=
 =?us-ascii?Q?AA42Rr28tVUS8scp5vGq67t6HP+rE1r39lbAKdYTyH0X7f2SnX3PTaUKCJZ8?=
 =?us-ascii?Q?4kBSYtlpuAxMSXGjUuNeiMns/FXlo+qhTTinHK3XT2sppl2TfJuC984QzDmn?=
 =?us-ascii?Q?edWmYEXlkSbUYOjlS7S2ydfhIuXiPcuKUXkp9vcMXEbkiL4h0YGLS97IY5eg?=
 =?us-ascii?Q?P61pFPAjQacG1wr2isjyvBsW0nb/ThQ3YGWAlF6DSs6oaX33H3ln0GR4sGUY?=
 =?us-ascii?Q?yWt2y0s3yrtpeDWIR+cxEOUjRIsVFlvh3Nmt1xPj9bdOp/h796kIpkXGtqR4?=
 =?us-ascii?Q?aZPhd/tUFHNEtN+y1ottcxK+1Umx2ztw83hMVcfSP8PUgM7AQT0bHJuQxvM9?=
 =?us-ascii?Q?JpxVspG5+HJa47J0f0JohJ2Ou/NltWIp4O9sPjAbANzGDe2eWQxfy/+2f0rc?=
 =?us-ascii?Q?nWTFX6urOSnkmJGaF+uLEWB0ra3CoiWp1i5b7bZBJ6e3+4AYBIuBWOUbG5Ar?=
 =?us-ascii?Q?xMMTZfAkI+w72gbfGbd4y/dZ+ArVBjUeS2L7+KfXQdCOnm3/UdkIjaokoOd0?=
 =?us-ascii?Q?9gvHwRh3wjeusAoFnVDLfsCxW7Nws2ON7KbIXyuJpioHk2F4sAaHvuabkfpL?=
 =?us-ascii?Q?c6R0Q/k4jtvsZBDa6WAhfsqL7dwGV33ZMqQc+d5GJt1MKSSG5solYtTMAwoB?=
 =?us-ascii?Q?RJG17qi11ooaaOA9Y0TYMAkM/8rQCBuJJiNsxGwtd/Eu97gaJSkShlBLu7Jm?=
 =?us-ascii?Q?pDscLWH7DXEuNLouEN5eNI8DfiiQ/1ORR4nbtgSFs58PFUNXN/lDhxKJ4QF0?=
 =?us-ascii?Q?pTaMh7g5KSsh2tr2UA5NLeeIgzX1FhaiRgXBqqrrToyKHZoynK2Xne+YKNrx?=
 =?us-ascii?Q?x8/S+O+nPxlHpOZ52qAIMyhuJ1QlrUNhWXXiUbAxknrOSOpfQNgDYA7BqQsq?=
 =?us-ascii?Q?a+FCdDi8hElkX44TbmK48zmcjxyiVQRVPbdQZdCr5WR6yGnbkozwefDuRAvN?=
 =?us-ascii?Q?s+hDSe6ArCDk+TRc8v0CZEr5ja4082m+0eN4CWMiiZfl1znndWtrgi9rwINz?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7816134-8f8e-4297-778f-08dd76598cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 04:55:14.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGyzvrYU8M/RTdZDkXm4sY2r/7+PukAv6a07ufOdOTP3gVe2Th7LcB6NiYFyx1KldudF9gdGYGLmVciuY12Chs6ndJ9r5uEW5XHiMTXppUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Tuesday, April 8, 2025 1:20 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Dumazet, Eric
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>;
> Brandeburg, Jesse <jbrandeburg@cloudflare.com>
> Subject: [Intel-wired-lan] [PATCH intel-next v1] ice: be consistent aroun=
d PTP
> de-registration
>=20
> From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
>=20
> The driver was being inconsistent when de-registering its PTP clock. Make=
 sure
> to NULL out the pointer once it is freed in all cases. The driver was mos=
tly
> already doing so, but a couple spots were missed.
>=20
> Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> NOTE: we saw some odd behavior on one or two machines where the ports
> completed init, PTP completed init, then port 0 was "hot removed" via sys=
fs,
> and later panics on ptp->index being 1 while being called by ethtool. Thi=
s
> caused me to look over this area and see this inconsistency.
> I wasn't able to confirm any for-sure bug.
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
> drivers/net/ethernet/intel/ice/ice_ptp.c  | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 049edeb60104..8c1b496e84ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3968,8 +3968,11 @@ static void ice_deinit_pf(struct ice_pf *pf)
>  		pf->avail_rxqs =3D NULL;
>  	}
>=20
> -	if (pf->ptp.clock)
> +	if (pf->ptp.clock) {
>  		ptp_clock_unregister(pf->ptp.clock);
> +		pf->ptp.clock =3D NULL;
> +	}
> +	pf->ptp.state =3D ICE_PTP_UNINIT;
>=20
>  	xa_destroy(&pf->dyn_ports);
>  	xa_destroy(&pf->sf_nums);
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
> b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 1fd1ae03eb90..d7a5c3fb7948 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -3407,9 +3407,9 @@ void ice_ptp_init(struct ice_pf *pf)
>=20
>  err_exit:
>  	/* If we registered a PTP clock, release it */
> -	if (pf->ptp.clock) {
> +	if (ptp->clock) {
>  		ptp_clock_unregister(ptp->clock);
> -		pf->ptp.clock =3D NULL;
> +		ptp->clock =3D NULL;
>  	}
>  	ptp->state =3D ICE_PTP_ERROR;
>  	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
> --
> 2.43.0


