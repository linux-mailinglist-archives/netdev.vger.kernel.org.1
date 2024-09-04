Return-Path: <netdev+bounces-124919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EF96B61E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E4A1F25D03
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900541CCECA;
	Wed,  4 Sep 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I88hq7Cc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1468146D45
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441006; cv=fail; b=ey8gaQC7pY/qX9cEs2/lICsdctlxWQKo3z4qfal5vUzUnZw00bJz2NPzn5vEueRA9kR76Y7Z0892nlAidSSqhNzeL2XN72FVlc8THcYayqp1/RrUQFOiOkfwSsiFDwghuGFFtf7Fc77kJTlHNzrBBgY1Am4I6FzqrHWp74IvmJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441006; c=relaxed/simple;
	bh=k/qAR5a4u6dDGGOTuQo661gOA7o4GlbqHfoVs1VAHbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGwMMkdPqRI5PamuWgFMrRPyccwjEgg8JcWMkLs0RIBfOaCq12S8OfY4cWNguv5kVjI0d8IwqB/m5wN3ZCKlfGgcHwze4FTza7FAzD7En64mHIemgi62A7j3Qhfvl2EDd3kE1x4fV51S5CxZ4Cy6EeOA69fqocGZZQLKEQrE3wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I88hq7Cc; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441005; x=1756977005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/qAR5a4u6dDGGOTuQo661gOA7o4GlbqHfoVs1VAHbI=;
  b=I88hq7CcOHXc1Id0dum9naTe3KiduFTX6dpPS3N9Lfaz/eROuC5e2fQI
   ddv69ldTGR7ZbDcocEq54wO7jjAc3AAzzEA2Ddkhifou6rAnGqWBzy70q
   bQBk60edWXif5m3vkPiRxx2WuRxF1gyqNmx6tDYp4Vr/oLWPVHL07dtWV
   R3PLEuu81Bd2YPr9vGpp+CXTlXpauAueJxk5LhVDYvvdBxlmGSkRdSS5W
   B4yi4jxI2H4MoelH/1j1tms5q+rvKY+h0r3zin33k2Wz/blsr/p5IEDrU
   S3brv5j2RCqBUhfpg/CaSCcItfy9toLmjSeKNtlf4EfglXZ77G3AILgHm
   Q==;
X-CSE-ConnectionGUID: qlN2u91IRHGwuodWOzZNGw==
X-CSE-MsgGUID: fBWLj03NSguPXRXGx7Qgtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27878112"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="27878112"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:09:29 -0700
X-CSE-ConnectionGUID: lc0h794yQreq8eLmVY28tA==
X-CSE-MsgGUID: Qf1A5BwjS9y0I1I5h1nuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69606528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:09:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:09:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAxpT7mYcPC5LRPJYV2mb/gVLqHkvOju0T8C7qmOrRzW3Fu2Fp7KULD4vE4foPnc7xPaSzip6SED3s7vdC5wpAiM+M7psQNYdV2B9EdmsphxMnNLvFJqEQr/O3lXkR3p3QRnYmDgPtjFF47NM6ErFov9UaR8hKWPMfUziFMQA3RsbRhOteHAXqoYPPpP5X42imywz3k6VttiuJUxw81/ojT+zuo4+vFqZSn+v2VO8R12zzb+RE0vNpMohS0qO9QuOXfaFd0QfcYqynXynLWma8idfOLfciBUcIZxsEwVA6N2yyJrFBZtctPLVJp8pCS5k0OzTejykMLJiCHYlBkUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFvabwlLmKXTDxxV73KVeiCsCYcFbTtWDs//rr2zNdQ=;
 b=izYffUmEoblILyXSuP12S5k6ump7RNCFVIU0B14uM3/THpP/5+2sm5IvXBYSsv7mV2dHHpebmcFXD0OUF4uPkLgD+7rEWhO+IIPq+biJiwsh5vXT5jksoBB8pHWNmL6rIQwbCOSd4mENylUAdZN+Zb29HncHRyVW3I37nuQTj8YAFDFVojyqoV3UpLc5FbSsH4GNaxc2JmbpQLXH//PNeysQuTD9/aeunO2ZGz4wiuED4du+ys8VJhE/aUCWlW+8tJbaE7z6iGzmnUdOR+gRHHraalOr3O0CJfzx9mQE7dDpHgyMF214ANkhjdf+mkpxPFwCfCqOQtueFClhEelM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:26 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:26 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v4 iwl-next 3/7] ice: Align E810T GPIO
 to other products
Thread-Topic: [Intel-wired-lan] [PATCH v4 iwl-next 3/7] ice: Align E810T GPIO
 to other products
Thread-Index: AQHa+s1Tlv9DtVVze0itgJ+nXMpKILJHOdSw
Date: Wed, 4 Sep 2024 09:09:26 +0000
Message-ID: <CYYPR11MB842999BDF5E4F86C6177DFC5BD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240830111028.1112040-9-karol.kolacinski@intel.com>
 <20240830111028.1112040-12-karol.kolacinski@intel.com>
In-Reply-To: <20240830111028.1112040-12-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: 1a825725-93ed-49c1-2034-08dcccc14677
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?d6+Llx0c8v1EUwS5b//7B+YCB1BDyWbozzTIxyxxF8FGs1GUjdmoIwSGgxIM?=
 =?us-ascii?Q?LGqnHyUNdDwVwOzafberrqsMTsYMGb/VNWfj66Z3Da3TtVXmVaYVHtM66Us7?=
 =?us-ascii?Q?7MGx2gBxzflbZCJ4k1qSEh+8s3t9tBFq6qAu8v9DB6GBPd07o1TiyqGBSnAj?=
 =?us-ascii?Q?nhfLift4aTdGLFJ6J2Nr024M+SYcISb//WrOg/L/bpfOgga+wfqAq7jqxYIp?=
 =?us-ascii?Q?Gal+PHjbzSSr486GfqrMEzeNN4ElV9KVUT54z683y4spQmGdFCoBhwXcwHWh?=
 =?us-ascii?Q?U6XdP1P11TtYqsyCPhfNhnIrwQ+uwRpz+QXDHQ75rSvV7VVUJW9IYQTh4ne9?=
 =?us-ascii?Q?9b5+r2B49D0FCw601MVJyOO9mC0jTijn8huvSYGx3tS1tUOJwbrOkUWCyja2?=
 =?us-ascii?Q?MZm4YfLzNxYnHUEYazOqnJCPCKPBtjH9wPgG9EZs9QQMkjF+92aVPOATP5bC?=
 =?us-ascii?Q?ON3je7wjnQCSzzt5KyjJZ4ky3TnDi7GbiR9jxIsMVcBNGqo7+cRyYLBV6T7q?=
 =?us-ascii?Q?spfvPG0blPvCg9d0KqyNN87wgtpXvocflZjYLvLOYki7+uETzKcknQ71LeXZ?=
 =?us-ascii?Q?tXB3Atn4OYf55xNeRQocrRN3baDoysW8HQgxOpOxHJD8vVJB23DPDOAwPnIr?=
 =?us-ascii?Q?Zg9WjH7GcJxKzoQxi2N07RP7uVl4nJpeMY+ncejeXTQO0XfIBJQqkQipemcR?=
 =?us-ascii?Q?3tBDSAj8ejXF+4Mey0aNX5RjyLUIOMEVl2QPUwK5xFCzmuA1NEWg/dEKNbme?=
 =?us-ascii?Q?paURWmIAkLKTOQlubVJPG+zB9eUb3EVvyxEeDTXS/w5H3PHIZtjXDr9ldw0h?=
 =?us-ascii?Q?dOVmXJ7mp0WU3Pf2GoJz4rftVpir4ZjB518mAQ6/uiw94WM6EwDWkg/TL9GM?=
 =?us-ascii?Q?NWcB8UInlOdFTXSlLXp9sGiPKL862jGvqSl05ew6paarGJA/OEdqGNkp/NFp?=
 =?us-ascii?Q?YuZEAxR6YanBQmgjdrRmxrSFvZyRlUROoFtCgq6I23ZeNKbCHKq8ZsjLw3F1?=
 =?us-ascii?Q?4mpQHwM/P9RZ03czTP4NWrJO73N7aZu3CWlrJZZgo1XEh4HNrB15mTK+/qN+?=
 =?us-ascii?Q?+l1aMGbe5aVVGmu5TgdpHYC8kBHJK/rpjr8otgf6lW7ZomDbzbSEu3+/zkVU?=
 =?us-ascii?Q?4z4eXDyH3PfQshyR880Qm0A6vCl5WLaLitewneAKpWCSV4X9Yn6tA8/MPLki?=
 =?us-ascii?Q?x5Li+3TmV9kff50ZcPzrxd7fXpasLgVq8dp7LC/6IPLqgnIRWdFiTV99TW2P?=
 =?us-ascii?Q?HdUtrlLt9XCwDG0q0K58TFSdq0p/p+Ir135GR6EwcLz3VFu6emnWgPb3OH+N?=
 =?us-ascii?Q?SfIal1XMHXFWx+h+7s3CCNftPYqIgh0T1K287Jvmqbv79+DKvFEH7nzwpPBx?=
 =?us-ascii?Q?nzDmfoBBkKojfIHccy9jXYk+vmzvBge9fPGRLC3u874TgSFCnw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O9Qypn0wOxYcf5GORBF6Ck1EWnQ0lB6KrXnaNJRBrB425w+hdGkOpqmBvghf?=
 =?us-ascii?Q?bKqHnoGE/wnN7AX0w2DzNGo3g+/6xtD8b4AkNtxNsVGzpp2Fb0Dlbq4eYbwl?=
 =?us-ascii?Q?kbMqT7tdM2ov8M8AQq/pUPUhn90ZNjBilb503Hces+0zE7EPAW7xPRqh10sO?=
 =?us-ascii?Q?bE4uxLUaK2z0auL9vDCcV4+xNX/aphRIdZWJjkwy17WhqrhA+G0GNH/TOYe1?=
 =?us-ascii?Q?eKujeEfOXg/CFqTEToRtODXJhwgehJDJX0HYnpvseH5ohKgngPmTuHkYWxn0?=
 =?us-ascii?Q?+u24MKnrDEUWxQjtxHsbeBbIV4M13R647/Q5s2X19J84djoAK6hMUHAqB86u?=
 =?us-ascii?Q?wkcfJzCVeyLQ3TLJpt9pkwsdidiYYWQQUvy9dTswEjur+EyPA38KZif6PDQX?=
 =?us-ascii?Q?Y4X4D55seGVzXR3RFrkLbZwDU8HV9a+Np/XP5QbWrVZR2IYlGiUERpJZpZ8i?=
 =?us-ascii?Q?/Qd6pOiIVf/SFZOFgXfbOZ63z+G0TxbmAnkEd1sVZIoQz6oJy9mw2x56iV4L?=
 =?us-ascii?Q?pwmkm9UM4IMbb9RO7ovQbEnyX4CRU8+Bhd6YfUzIXrDwAq7j8UGRqwR0Te3r?=
 =?us-ascii?Q?IPuFDleICCaHhpXosFFQKIOQCeUUwpE6jHT9cMv5/sLIj8WHG+IOiKACcX9a?=
 =?us-ascii?Q?7V759Uc1hCLQT0zasRQiYQzCk8QxJAFW4Wy73pUqJoHLIaLsILK1UJ72J4NN?=
 =?us-ascii?Q?KeyqLna+jNRsB1o73gznRpzR1wFi8hobVDHIrNuTcY8Hk3xMZqy65/nvqvrX?=
 =?us-ascii?Q?CGaMfMwT0J0/jSp1eeAPsInGgrborto8xF2ja/OI//C2D6bczsc1jjGL0BG9?=
 =?us-ascii?Q?y/5WHC8ct43V2rOK9WkOkEHHp8pnlJANQtkkFJ3yT0aU3gnDze16KeyWiksE?=
 =?us-ascii?Q?oz83wAoV+I0Imprj+LgazLZfsQj9aMc3sP+B6vUQtZQ4kTu1OaH9kNk6Ju2I?=
 =?us-ascii?Q?w0jXV8FGL/OxbsV+fsHAXz8us6quvoKDAfGZJItmUV13RMveCDOt3qUooVbQ?=
 =?us-ascii?Q?trhS8Ry6QrDhrejiizsEvxu8OZaFRaDRYNYODxd2xPFHhAwPW9YuZ0tfpFoP?=
 =?us-ascii?Q?hbJoDbvgIpH6eIpAF54TmElWMJlLLYH3Vjvud54WCyjrrNBgCU0wMqrpCfDV?=
 =?us-ascii?Q?R6aIbxN6rpEkspqxgIfdzeWFTlCmOzkuceazANuLrZRABaWlzUHWvazyDM6q?=
 =?us-ascii?Q?JtN5eYkrFcR8uCKKo0XrvLSQOuQD5dPlaIejIMgBV9yS8q3jAhbONMQaePlR?=
 =?us-ascii?Q?zMIJGDWq1Yg63eQ/7eEN7X+yVImUob8QglEo1K3nBrOxwpKpoQG3sJCdsZgH?=
 =?us-ascii?Q?D9o6QsVZn+o2BGQBurvPwiWi5q74Q5nC6tSyN+7APO0c7Br4tstJcmbARsdO?=
 =?us-ascii?Q?XEaWybNEu2oteZfvhMr7i31tNxtGk+BxoK9mkkQUMn5ld9viTQsuYoxQWYUq?=
 =?us-ascii?Q?RrV5MLLkl/sf6WjwTBdV3r83FThyJ/POXjX+P44AoLSqwTxVgO0LZ9gkis+v?=
 =?us-ascii?Q?YQMlKgLHvtJVkrwtEBovb2YeOj1FA8VISsyMrK7O4LQyRCfrwcHNYGFCP9aw?=
 =?us-ascii?Q?k5ic3O+FN0AJU4mdJcQcs0rbOjpJxe1F9wBDVhINe+PL4MDSs6qTgEj651B5?=
 =?us-ascii?Q?nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a825725-93ed-49c1-2034-08dcccc14677
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 09:09:26.2117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkT3SQyj7kJ1ISvikH6gKO3298lnMwmcTh2Vd/E9ZCFzzAphQUk3ajELfuOdEdikV1E1iTHtcr7rHHQb26X2XsGobUJuxdAtGCA/ceaNhF4vnde9x6s4VRUirbNRwKex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Friday, August 30, 2024 4:37 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kubalewski, Arkadiusz <arkadiusz.kubalewski@i=
ntel.com>; Kolacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Simon Horman <horms@kernel.org>; Kitszel, P=
rzemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 iwl-next 3/7] ice: Align E810T GPIO =
to other products
>
> Instead of having separate PTP GPIO implementation for E810T, use existin=
g one from all other products.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> V1 -> V2: restored blank line and moved enable and verify assignment
>
>  drivers/net/ethernet/intel/ice/ice_gnss.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 464 +++++---------------
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |  29 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  20 +-  drivers/net/ethern=
et/intel/ice/ice_ptp_hw.h |  43 +-
>  5 files changed, 155 insertions(+), 405 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


