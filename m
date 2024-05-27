Return-Path: <netdev+bounces-98182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0868CFF61
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D3D1C20E92
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BD315DBA8;
	Mon, 27 May 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdQf5QqL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A313AA31;
	Mon, 27 May 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810793; cv=fail; b=TPN2fd6TVZ9fB8bKp4Vgw0SccLiLDfYMa7iWo/EQ2YP6mw956TtLTP3Ir+LxF1yoHY4uWLo2OcfhfNwTfPh+BG7HHtly3jwu1xIa2zhBxKJYY7MPfmd6sQfSe9YylV1ugOuewgzsDcQNmlbT24O3xOoSj8JXPDekoXi9Ct7DP40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810793; c=relaxed/simple;
	bh=/JR7+Bx7jnsTLYeBfg6vaHNLxWn2Pl8OKwugs7wK7o0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZHWF4+bzpyz2cKYihNxje5ZxhQrcc0HVZio2jpwPPt/tS0Zz8CYgIH+jZjxJzCZvCh3BI+Uei1NHF19eOHf7uscEcwZK86M8ggTehonxbeLwS58hM85EsoLcYJ3I1lJj0KkKSl7aGClUg/W+9KxLeL9YndkeQon/d0tQ81t4ed4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdQf5QqL; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716810791; x=1748346791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/JR7+Bx7jnsTLYeBfg6vaHNLxWn2Pl8OKwugs7wK7o0=;
  b=WdQf5QqL2gEg2juzl3CY63jm9Q/kjqs27s38iQUOBn2hivWKPsJxEBLv
   0Z21FVLfZqPzvtjk0AugOiPrc1G0m5yj7Oblmo+VeBuTqeVhXGko4xydj
   sEtZWq5/wwf6G7gzdE1PHWE3B/IE1kb8cUZWz1DW3y1a7Zjk+w478cONE
   pbrsomumbN3xPj1hQHLc+usxKxKELlDoePTIOkZGVbSWI+qfcrC7HE6yf
   Vwj8fhfMSu0vrVAMUv9o6AT60xqW31/K+7o0Ye9xxj6jyyPlRSYCdT4QA
   jRTAreW0P6Zf5KeEcVRabZXL61iM38NgLiwvbIwXt0qCgRPTu9FdG6Xfu
   g==;
X-CSE-ConnectionGUID: GTEzVP4qRMukpikpcaexrA==
X-CSE-MsgGUID: ERecs7btQsiDVq/XNnXkOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23790148"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="23790148"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 04:53:10 -0700
X-CSE-ConnectionGUID: X4MbWd6FQfy5Txs1QwZk4w==
X-CSE-MsgGUID: PRFFZEkeTsiKEFVtxrzpoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="35236403"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 04:53:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 04:53:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 04:53:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 04:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9/2K0HFtRInlm01Yy0Xq1Nm7sWYIh/K6Spu+3AyaYbknQUDHvUwmFQELvCEU5D5RJP4AMBF0h/iBoog8tS5mgvko5nIZ+pfEeGxlvsAMF6TTFtkwpAGtc7wQVjNFCERNWwzeTNWcrQWTnCAur+8+kT71O3YvISFf/Dz6uMiwMobu8ppVsiLDk/C39KtcUMN/mBEwagDQz0TD6TOhHFC1m919R6dmsIJE33/5fKNDxZai8DpHRDqJtk3WtocAD++8SaBIl1JXIQP7tKXnsEBddphmpP4BoWre0APPDGr1RMM8nBQhf+ZgQBNC2aXpw24pnns+3V+YJOPuWrF7HTK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNKC5k4sCi+wFsctrTQC8s/HvJnTo90rbLdN6jUIqBw=;
 b=N4wm91GcJzz6rplTWZlGfoP+rh1NnyCCrBBeoSfSQFjS3yBFtP4T8+D3rDBu8Sdj95Fh6q53PRJanPSs/5ZfrHndD+Jd3ZtoB8EBKFJaKcB4C/0mPGWRXI6+WzhlX3UrUf/YJNCYc4qlDzsg9BMNIBbDsHLgWzUbhzwq633xZptVuM6u6H7EPV8KRgPaZMBD3nx+1xg+90QUB2u/qh6aSmEsjsZ/W9L7v2/tXeIQKFTV06gBDnrN97FZozqDWkXQJ+RqLBVtAFoRkIkwq1RXgkg/JdjTc3GX+7qkNpRZKZTq0rm3i6uS3fgwGdvOF9MrBkxVYUgd7HOcOdCbEScnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 11:53:07 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1fe:535e:7c0e:1d67]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1fe:535e:7c0e:1d67%3]) with mapi id 15.20.7587.035; Mon, 27 May 2024
 11:53:07 +0000
From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "jstultz@google.com"
	<jstultz@google.com>, "giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Dong,
 Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "peter.hilber@opensynergy.com"
	<peter.hilber@opensynergy.com>, "N, Pandith" <pandith.n@intel.com>, "Mohan,
 Subramanian" <subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
	<thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel TIO
Thread-Topic: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel TIO
Thread-Index: AQHapSHftciQrHJMUU6CnGvp27mHHbGVBWCAgBYIJWA=
Date: Mon, 27 May 2024 11:53:07 +0000
Message-ID: <CY8PR11MB7364A367739AA57107DBBE6AC4F02@CY8PR11MB7364.namprd11.prod.outlook.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-13-lakshmi.sowjanya.d@intel.com>
 <ZkH37Sc9LU4zmcGB@smile.fi.intel.com>
In-Reply-To: <ZkH37Sc9LU4zmcGB@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7364:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: 2fef775e-9fa3-44de-c5dd-08dc7e439319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?QUdS4hDCtgBepvqr73DuVYW1Re8Mp0PHPW4BEWH+YQIex3woY3cj50/Efy7M?=
 =?us-ascii?Q?jtzmHmzVs66YAv83bcxbM2M5hep39qTvgy4Z6jXMwIsEuF9fhktDIPVcJE7U?=
 =?us-ascii?Q?kFtJmwAVngiHS3OVVrsvSZVQUq6KVuzEHSwueglzpVp/MMt3JzsIJffw5Cd3?=
 =?us-ascii?Q?7N6Fr+Bgp9iabcPobMQKsiC3GkLub/UKzyLQoLO6SY8WojdMLGjwnVMOa78r?=
 =?us-ascii?Q?ih5n8IbR85d7SDk6EF2XXWrVUyHRqgRLP4KPC6gfUmFI0bg7Bp6HYnrBhvGZ?=
 =?us-ascii?Q?qSWd+X//v+LLgxcgewq1igA+/KF9YGH3mGvRX6YlaPWsg5BDtwuN/4xExoQ9?=
 =?us-ascii?Q?4r9rATJBurwYrSGkC4C3m3NWeb4G/22xnFfcKIvONx+uiR+eRu+sthCI0XpR?=
 =?us-ascii?Q?bvAbgCsSafVW6DLWGsJnAHmHx9fvrFGsb5ddk+VUt746ZbHpkt8tbONMSpeW?=
 =?us-ascii?Q?KNqqKAl4W0neIP9nhyEeWIjSnkY8XGqHauWZLfRgCUKOLurCg0pR1YJdrJHB?=
 =?us-ascii?Q?tTUBRD00rNT8GymnHkIYU4lEgKn+cj6L/8RMyA6noAWiTENskMzCH5kc5/xi?=
 =?us-ascii?Q?hTgLWQA7pTPT4vyMmlj/yGTKFLHP0A31tDqRbg/r6VxSX5qSkxR/SvIQfJJD?=
 =?us-ascii?Q?dlClffhtVngdrZtZFDCPNq8XVIt2ouZtew02EZTnoAcuuBs5ieC0fppG6S0H?=
 =?us-ascii?Q?mEukDAa3SFl3THmRpq4nFEmYT3xIJTraeVmgp/Hzd6T6+JcBbw+vJ5l89rw2?=
 =?us-ascii?Q?ePcXbte2QuUecKP06nX4vzZFi1woueL2e7OiEL83xoNmRWPZesYub/kjtErZ?=
 =?us-ascii?Q?83POZ6qixwi3V0i8KjQBcVdpA/3os4Jywj8UZuCzzDEJN1Rrv4eVJE7xzx54?=
 =?us-ascii?Q?uzhCm7yasrAYNa8D4xoEvNzo8vnb9ABvTFowailpzDguFUlGmznwutw71qvG?=
 =?us-ascii?Q?iNSMuv8mEfYxmgqDf/tv9wyBK7zsRfPQsEIrsxnc3W8SC2IuOvQqQl7ZVGD2?=
 =?us-ascii?Q?GOCTKj4D8FSsgx3KzUbApsTi8H273nR1/0HkM7zbevpcJBMFYhckbZ/Ef80U?=
 =?us-ascii?Q?2Ps2MR3YrzX4MZ8hJ2OoMhkUlWnfzNPYEpVomGOQ6+d9QYW4W5Wo624uVjAu?=
 =?us-ascii?Q?xgChpfBQg6foheXiMqzYG9mOW9Aih6v6BnydaFpxL5LBo8ILuBvP1HwSg6ah?=
 =?us-ascii?Q?zj0juEzQKDPgtjpob/Hz2vy/hT2IAu7H2zBT9GQHh+kVqECmldQ9gFfB9wSY?=
 =?us-ascii?Q?BwTd2oAYel9nu7cNzc3nrHK/bseChH9M6eJQfQUSOWu561ZoJSXT5imKWe0Q?=
 =?us-ascii?Q?9NtmcsawUTw/qvysOv0sPrKVCyZ2TyDJjF8AE3/jlpRnEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?acPSxxeoM0ZrnCBeCOrxhRNvW90FmWTSc27iHNmhuvZc2Te/c0Aj47UhTsEJ?=
 =?us-ascii?Q?8taGkDjJWphiNWCWoTltXH8EhIk6JNiKOYgOQbQlOeoQVW1C0hv6aXclZvk4?=
 =?us-ascii?Q?g3cqmEuXzqo9GYyFvuRclmupO2+iGOXBM+58P9MPyZcMnXrPSkofNFmwJ0ZQ?=
 =?us-ascii?Q?o+X/1ayxh+rKdeaS9cSQSRgrApd3QyCExLIat+i/R01p3q9Qj86lQuW/BbLF?=
 =?us-ascii?Q?n5nW9PB/snVp0w2iCdihQ7xmguOQR5r84U5YNoJRZg3GRwRDQtkzM+OfkY58?=
 =?us-ascii?Q?XbVRfCIIufgHmsekZNo4/1p/Tb8Fl60BN4E2bgB7v5qOvomQm0IagwRQV7Wb?=
 =?us-ascii?Q?EgH3jWjRw6gR+soKW7IbJVilAe8RYGsFwfAVCSvm4LFrSJ1iINS+MBzz4yfn?=
 =?us-ascii?Q?RqZteeeLfcTm+ZXZhPubsfUoIu9U5iUGpEtoYNpqAowXaAxJFKFXAOwm06Dv?=
 =?us-ascii?Q?d1Yw9ffmNnMhJAeZ3GW9OKRcleMxHOIAc4ZuVEQTEIFc3gtW1sfeTPPcXnMj?=
 =?us-ascii?Q?i+lqySzJfH0v93t0jf/Vt5j6OF6Lv+R+yp/U/rTeyC2Uw5pxpZL9dAqlbik3?=
 =?us-ascii?Q?9+vgIGwRSpQgdHV2qF+N92pPttYP96X8NMYA7tIw8TeFQpuDau/RBkH1T7Sx?=
 =?us-ascii?Q?wrpMibsMSTezT2Ied5ajERlyAe0FNDlae7y7oVU6zr0SG1eFXwiRzoeSaCDy?=
 =?us-ascii?Q?EgjM1qSWa42dzcQt2ylD2T7JCSgX+udRLZfMarq46X1Sj2Du68l88vqT+qJS?=
 =?us-ascii?Q?HIWLkFMl/6oNsk2ki8Bi8g0zY2ec4a+6kNykSndGfGTldxgVdB88fhblwAfq?=
 =?us-ascii?Q?XNWQng6gWP03Yg9f/qA13nta0DqFK+hHYEC35AiccEbWmxrMTWVOUzN+3i3v?=
 =?us-ascii?Q?W89KZdhWhN3ira9aENquliiCzcRRW4seT7B7cVQmcKpxn+AwZ8RdsiPo6eDP?=
 =?us-ascii?Q?RaNSqVs4GhLIFljJqUwOvjpQUXw1FOBeBBzVbXCuU+ZnIsuzx87LPY3TtjVj?=
 =?us-ascii?Q?0qEgZddfuprK1ndedHFBt/pfB+HDBP4x6EF9rg1+imFSYvqpilZ77ASsjykz?=
 =?us-ascii?Q?jbXw+8KtkGPgRCKtvG5a796L3aOyYqRXenyP9ZdUd8aH7x5PvQM8/7MdUizx?=
 =?us-ascii?Q?Cfo6sZvOXRB75/Jp2h4yN7VEiG5hS+lN1g8NmgzFMGlRuCKRCypnFX2ikncC?=
 =?us-ascii?Q?FNCJMmWX7dJP8CAemL2RR3ziD8TqyZx1jmUTkdoV5UkneHiRHX0vtAyyjzK5?=
 =?us-ascii?Q?15n+/qL61nikHJ/CvLk36xc5wr29/P2HNGmgsRtlGvW5WkgIbJcFJ8F42CKn?=
 =?us-ascii?Q?Is54YMPZ1VrXLmSDpfuFJ/cS23XyVBOQOYh0VHJQIUVSVZVf7NxVZc9wIxk0?=
 =?us-ascii?Q?JqA4pPyfbyaXPzrWU0EcXjfKIjYXm7KU/VMJIzhQ9j8BolKgI2MAZAJYggFf?=
 =?us-ascii?Q?9U1Pqt4wLUfiEE4ksKbtEdJtOaM8/fcog/XThutCRf7GJLWipGXdhy4jQmdf?=
 =?us-ascii?Q?qSyD4xvCc6WBQ7ui82uLn86J2a2NlRXtd7ufbCWRwthdkWVw9IjhI3NJaxvO?=
 =?us-ascii?Q?emkItLsGEbzolhqnhibQ3GpUaIIPWpTMPyR1i0eZq3C9PQ6MtDH+QcWssk6z?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fef775e-9fa3-44de-c5dd-08dc7e439319
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 11:53:07.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xB3XCznU2JCsMMojnumYEDHCCo2uG7yd5cscuT0wfkFHZtwtUfljPLJsuvNr6MpyK66SFmI4FD0m1mYmJ13xfkIMR7sLCaEbrDkqMBU+gAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, May 13, 2024 4:52 PM
> To: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
> Cc: tglx@linutronix.de; jstultz@google.com; giometti@enneenne.com;
> corbet@lwn.net; linux-kernel@vger.kernel.org; x86@kernel.org;
> netdev@vger.kernel.org; linux-doc@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Dong, Eddie <eddie.dong@intel.com>; Hall, Christoph=
er
> S <christopher.s.hall@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; davem@davemloft.net;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; perex@perex.cz; linux-
> sound@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> peter.hilber@opensynergy.com; N, Pandith <pandith.n@intel.com>; Mohan,
> Subramanian <subramanian.mohan@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>
> Subject: Re: [PATCH v8 12/12] ABI: pps: Add ABI documentation for Intel T=
IO
>=20
> On Mon, May 13, 2024 at 04:08:13PM +0530, lakshmi.sowjanya.d@intel.com
> wrote:
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > Document sysfs interface for Intel Timed I/O PPS driver.
>=20
> ...
>=20
> > +Date:		June 2024
>=20
> Is this checked by phb?
>=20
> "the v6.11 kernel predictions: merge window closes on Sunday, 2024-08-04
> and  release on Sunday, 2024-09-29"

I have taken from phb but my understanding is that any probable month befor=
e merge window should be added.
=20
I want to know if it should be the month when the merge window closes? (i.e=
 in this case August)?

>=20
> > +KernelVersion:	6.11
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Regards,
Lakshmi Sowjanya

