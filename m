Return-Path: <netdev+bounces-291959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG23LgcbFmqEhgcAu9opvQ
	(envelope-from <netdev+bounces-291959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:13:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543485DD201
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DA2C3013B9E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771C35BDC7;
	Tue, 26 May 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcF+PKkV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02333C5827
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833604; cv=fail; b=Mvn1MbYHVE9Q6amMeOBZSIwJkBpT337nWYD1BwaMMNcGNz/1IQ87yf0PQoBj6xwbJ8WoSHgwlIy+pgATTTOzZe2zmGXB2eTsuxL2dM7ifeTuvBt9SyHrmoeJEtGAVgE/i/5kE9KdTHJn2coiuA6iMhYpqxxQq4dmqh0mUrumCXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833604; c=relaxed/simple;
	bh=pg9e4jRjOhff/W9BcGyvcOUeEySHOQwU3ZinEn8JzHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwhYy8ELyEsVHC9ttXrxBm40x1sLcviuwr5v1aFZrF/zky3BvWePQmxcP6ScA/orzg85BhQ4HmrB9Yo34zzsOrU/csyqH77KH7wrxIbBMqm1g4qL469Tyg8duDot5/AzvwatzXlDmTc/v9ej95EfCuE++OMlIaxf6H5Zv3skuik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcF+PKkV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779833601; x=1811369601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pg9e4jRjOhff/W9BcGyvcOUeEySHOQwU3ZinEn8JzHs=;
  b=IcF+PKkVEdwkGqZXAOPG7A9+qX9Bnq6nG9R5srPA/HQ+uEpf171tcDOg
   Faqfcb5nF5o3wDfFwmAbYtYG/v+LQ1Db+/XOKtP26WJIDuTu71NvLHgbr
   n5/Ta0Sx4OoimQAhqIoPTDt2kJwfr82zvmtzJg46i8HZerlnvFTjVivir
   WSYc3+EghzyoZZ+kafN+uVb0v0ydJxNIjRrtiws3jdOWg5o984cKqC+5N
   X/cTJtRFqkn7RAS+iggUSvlltx9dezwPExv23jLjYmEUxSnBENnY8/OCm
   RigH2Kc9EQ1vZEwkqk1ghdplJ0R/xI7IdWTWG+AlIwsVtfQWA7p7oPTBE
   w==;
X-CSE-ConnectionGUID: UYYkELEqQrKbzX0pU+F/Eg==
X-CSE-MsgGUID: AomblVFhSn+04QDUiFzV/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="91767180"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="91767180"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:13:21 -0700
X-CSE-ConnectionGUID: Y99D3DesTim0zDsNpEDgxA==
X-CSE-MsgGUID: wnNTkIOLSdatQo+E7ToKDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="246304983"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 15:13:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 15:13:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 15:13:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 15:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQnJOevesKJ6NXWCKaENkbZZaGat292TKL398SDHml78srgwxjpgjFwNe7SZblfHon8gmmWt3H4keC/IYME4JQhfEF4BAw9IDKtN+1RiLPQ15zT8bj3d7czfiY7F5irUC/NnY5Y6MELoJPffsRmCacUVubQP4XBGCQ/QP2prg2YxZ+0c167o+MLD2witZvDwwlZdLS8qFtOJl5UThgvDGqTLCGfDdYZMX1Q+4CZ6Prq66+gytR65N3rabJUaOhjtmVEmxL9g1KZrYkRKjdl8kQtHA3FG/c8TdhYFUqMdMTjpLQszfdagaio/VrA/ADHXD8nhw15RTO3+Ar08aAmwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76Gg0aXzjIk4NaRioiKpBLWQsptzglH8UmBgMZ3msHs=;
 b=ey1yVgc+3/6dHlQ8WDEh9x8LFa5tu//r7wxBIzFyfBBncAGAqvTnhaTm10yOUwYfhbxo/1Zx59p8r1lxQCAe12ToTVlRX1lj3VYKPKB4YRr6ejirwPW8IVDLsJ51eVKAXFhrZdVLZxcBMZ5TX5Z9VonSWhQARbTYYJ6cyX+3Gxzt4uioifkUGo8nQsZxPUafYj1doA1ho3Gu34LRa8SUwbYZfCjHdwvWP1gCvIlUdzkLL7LfCBINKT6WrztzuB2We8oLXhqrpNryhI0QpeGr1Sn+FJ1+Mz+M0NdvRW9h74GXFu+vJhOuAHSwRVTvfe1NF8TA6tkWcZiwZVl/iw+Tww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 22:13:17 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 22:13:16 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] ixgbe: fix X550 AQ PHY
 identification returning ixgbe_phy_unknown
Thread-Topic: [Intel-wired-lan] [PATCH net] ixgbe: fix X550 AQ PHY
 identification returning ixgbe_phy_unknown
Thread-Index: AQHc2J1l8Eql5+0RJUyWZYl8U72kNbYhB+Xw
Date: Tue, 26 May 2026 22:13:16 +0000
Message-ID: <LV1PR11MB879089D01949E1CE02619EB8900B2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260430123154.132072-1-aleksandr.loktionov@intel.com>
In-Reply-To: <20260430123154.132072-1-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH7PR11MB6859:EE_
x-ms-office365-filtering-correlation-id: 1e40dc06-9d79-4a67-3e64-08debb73fcbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info: aiOKTTVlUqwfK4KUeLOFQw2mY44GUql+UZB1kpgSbWq59m+i9Kyj1tBKT8gERp5GL6SE1wgHRkj1SGotVxpadfvwnIZX3taVDCRMQgyA43VOYIputVMbNFvNAbFBP1Jr7jkDklinhPMo77Asy8ybqUY4XwIWGNOTwsERcLvpmv3xW4PxTcQjF70GIWtpF+V5rHuQp3YZbR69h5gawT/4UEskez11exilWB6nT8PQDFs5uwfbSZeu1qnY97pBj+bMRMrgVC2xm9K848kn80AhCCAMW/A+1cxeTPCTdRqexguvdFEr2K74nI57LixGcuGcpysEVG/SLaNDsfoxh0nm40vsOJWJlA0kb8K0FgEy4QiHa+s2HqCB9a8sbhesPdFrjG8KD66/LtEMz7TwnTY59cR/lSYyhhMB796bSK8z0KU8zzjDadP/OPGP+pFEv6709fZGwgxNO5OlThOqRZIMP5Es/A77lRkMmtS80cWePMqe/A0DgQhyScTqUGcmvbKh9d7TKXFkxqQNULQ5i+mnOT+yMZQVz2Zo8xFBNYckla42DISFDzHWbHBgebn2dPN5WtDoGfT0LKme4VA50MktXd8PmdYyYLVKQIsHaoxiheSlI0NEZZrbZD2nb/H93G5+aEpQuFnUaHeMpYmsFTVDgGssFXAhqxWb61sVN1UwqvR91y7IwXqt0yMUCGZErwJT/SVT7pgyvE+Gtnsa8YGn56vMBUPMvqVcy68c1c6H1FKDWMwmV1Jl3OIvEuQu8YNU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bl/QqwHoTPDWfIwQBpx0d2EsTA2xOIVUM8nsw0lsZCgOVA8kpDvwLcw66aj7?=
 =?us-ascii?Q?SyD5ZA4+gzijuMGTRKgPzbT8FE95Bqa0JW/Y7QLj0qK2T/O/oc7MD3yfXGri?=
 =?us-ascii?Q?QDxKopW0Vk8K+3sKPGLeW5EpaROEc2U0tnulnf9mvLruoJ4u1kMjZQYWgOS5?=
 =?us-ascii?Q?LAw+yPPKgyT+9xgxXmrTbOSbgYZcwGUZwItvcrWs/KTdVwzU4eVP0zeyUN8B?=
 =?us-ascii?Q?WdkPYaKDYGJSyoidItPXVNdBTG6yfZ49cSicMs37EVh+b5R6yeeAoKx3F0gx?=
 =?us-ascii?Q?J5IYt1M0vrCo/G47tT6qXh/CitdQk0Inb4jmgvo4SJJx+VGh4Yeuj77ZMQpS?=
 =?us-ascii?Q?03JElGasnliQxMi8z6LnP4CuUM6km9Sdzpzkc9XumHzkTBe56Hj/iPUpjarK?=
 =?us-ascii?Q?OBWLUzRijLaQo5muUYH0yAiPvuItFDVpZfmZOb3ijQYPuWv/QLl67Sx4fCik?=
 =?us-ascii?Q?dXIcij96GLd1h8RsgnNowzeC48IECuUFKgDs65JERo/nSkVde+906LPvSzx8?=
 =?us-ascii?Q?bAnOLzp6ZO7DXPikale8dEsuE2jRln9v1vzuEhrqICWBgrHdsOaiqAAy1std?=
 =?us-ascii?Q?BuTNaNi3q5Vh3fLFS0FEeGsX6/qKRTwuMRiArKav4CK6OJCDkWM3ic0HkS57?=
 =?us-ascii?Q?5HCYGpLwrSgPPsDMJI+gknVcvwFoQmmzTC+eGk96znjo+3rLdDWDzpVpTB9V?=
 =?us-ascii?Q?E5nT6SQXkg+6nfC88sDqDHhgkg+VXFkApQ3XieM8p+PxTy2f+N+/6NHDwO5g?=
 =?us-ascii?Q?8kFwOGZ/R+9pVsnd7oWNZ5FQe2r3g8mEgIEfp+o1R9LEdS/hhfP2bIW7EybX?=
 =?us-ascii?Q?Nee63fuTMEAUSEvZ5Tf/TarWvk0FhbDN9V+U0Ocla1RAsz87f6SyAnNGxEeb?=
 =?us-ascii?Q?XSjYevdUkf45a0Y/fIoc6DWDg23aKFoK3E6InE44ZaMbxUsOXI87xcEbNopO?=
 =?us-ascii?Q?NUdfE5Z+AYJLaf5ajt9xS0ViSimzgYliKPFA4QnQcx0qENJKd+5cmPb+E/Sh?=
 =?us-ascii?Q?NgNtZbouv0fv3KzDsYarWr8pO1mT497ecQSz3BfbCNJrLN15jdYuPFeIhPMe?=
 =?us-ascii?Q?6+oyCWMwmKc7xtfpfdKulswvwcxJunvfoaadcCMsw2D+Te9p9yKBNxrk+F8c?=
 =?us-ascii?Q?RyzoKjy4iTiDS7a7/tySoGb2QlQum/kRZtcrq4awI6N7TnQeDLocaXIeDF8E?=
 =?us-ascii?Q?sjX5t4CdOCLhZ+ud9ze1Kup9MZIRtZYWDHBnVV5epAMsnXSCZqw2VGZwOmW8?=
 =?us-ascii?Q?hH3CAze8lJ978Zjc/w3XX5bgcy+yjOWjrgV4E7hB1hcO02X6Edk9E+COpSd7?=
 =?us-ascii?Q?41o5p/jGzlOXZxncLRht8nhJ4Q9A0S1xWUrlCLIU361UVx0Sm8IOYr6tAsxi?=
 =?us-ascii?Q?ziViS0mexstTAAz6PXcF64yg21ti+aW3eOYrJ2kjixpcHPAz0NP1suzukw3/?=
 =?us-ascii?Q?UYMm41G1FvZu9BVMRNsX8m1VxzcpS+nbmtTRa0AdF0HvjPtTKbMbTO/21Pa+?=
 =?us-ascii?Q?fxMgw19xHb5eurFCVwafoh/byi3Ss/7TJo/gdXAoTJBOvthFMsIpwBwzRla9?=
 =?us-ascii?Q?xL6mE3pF+Zl2cMnj6/qT5tkCQCzZ2mJ981gT+1LcPbGsXZPb93nwTHvOOupS?=
 =?us-ascii?Q?NZytLKDm7kfAVt17ZmZk94IqoWjeUe5wlo23Mapp8uKftqluviPpCyrrt+Kv?=
 =?us-ascii?Q?XmAFP0JY/FZ6rl3zDidmCNAU89eB7SSq/6McF2X7ePmocCAksvS1q5LTn9xt?=
 =?us-ascii?Q?eCxqloV4XQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YifqypswzddJ64Yew7o/9JQcgh5jHXpz7BvL8EG11wFp7SJLmxzIOxqzLgWZIkQsrPeXHqeMvc+NpD17Z78eXLrZokGJ7eSRqAq4rqTpYZ9hT2KdQdyYJRiYkx9G4OcAWSksXwILoyXk8ADOx0ghZnPpDpJ0kHbBqJm9/vzJWsOX6hKRzLmOy5JRuvErSkATHwdjeDDZlECgaGPAZY1QjyWXuz+7khsPuxcDcyeun4CCTtilrQejvzLYxw0k7Ct67nOdZfLPBeEgw6RdIU8t/QtXK3GZQyX/q73Of2oeiHucS207AnUpz2D1W42h4b1KoPp8OrPZTRhRKr16zofQpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e40dc06-9d79-4a67-3e64-08debb73fcbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 22:13:16.7576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbeQfYr7YLzvqniEOFSzfSuIWRsk4EsTSBj8Bc2xot5X5m3H2KO7tZ9JgFJ3uI8gADIlhdZ27Me5+toJNi0NEDhgDB3m7x9b6g2LsnDBJXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6859
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291959-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 543485DD201
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Thursday, April 30, 2026 5:32 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov,=20
> Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix X550 AQ PHY identificat=
ion returning=20
> ixgbe_phy_unknown
>=20
> ixgbe_get_phy_id() reads the two MII_PHYSID registers and combines them i=
nto hw->phy.id with the=20
> lower 4 revision bits masked out by IXGBE_PHY_REVISION_MASK (0xFFFFFFF0).
>=20
> Commit 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID") replaced X550_PHY_ID (=
0x01540220) with=20
> X550_PHY_ID2 (0x01540223) and
> X550_PHY_ID3 (0x01540221).  These are the raw values read directly off ha=
rdware, but after revision-bit > masking both reduce to 0x01540220.
> The switch cases in ixgbe_get_phy_type_from_id() therefore never match, a=
nd X550 AQ PHY devices=20
> always fall through to ixgbe_phy_unknown.  A wrong PHY type means the wro=
ng ops vector is selected, > resulting in failed PHY initialization and no =
link.
>=20
> Restore X550_PHY_ID (0x01540220) as the match value -- the revision-strip=
ped ID that the driver=20
> actually stores.  Keep X550_PHY_ID2 and X550_PHY_ID3 as documentation of =
the hardware-reported=20
> values.
>=20
> Fixes: 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 3 +--  drivers/net/ether=
net/intel/ixgbe/ixgbe_type.h | 1 > +
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

