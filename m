Return-Path: <netdev+bounces-281004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBhgCx6M62lBNwAAu9opvQ
	(envelope-from <netdev+bounces-281004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751B460C63
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0981230028C1
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8063126D6;
	Fri, 24 Apr 2026 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKssQUgP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D43112AB;
	Fri, 24 Apr 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044503; cv=fail; b=LcTX5GvZDjR0f8dt9yrU9jUbi57StMFvXU587QuDJ4PVoo6PoFQuGD7JQn+tCkZoV91NbAbMTfoigBbKDOmaQ2Pmxv1nQgikXAJ26VqhQHPb9O6sYfejWRPiWwPJRikS1hE4oW6E5rbSV73zVFn5K4HKWdzLrehgyJq3+D7aN+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044503; c=relaxed/simple;
	bh=gShZ1CG4hNDUS7qdCPiJwJL44/SYxIHrsYlpXowRGo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M0hQfL3dOUnXqTG8vy0J1iVsImHN7UWPYfwlP6DKugKnxrVBwr+XqDavZvq8e9/9AJkHBNKMTIHNj7xaHPnYvaiXWh15AXFyPdATv3lzywwl7SJS7MJI7xH+JruGE3Z8UKGlc0IihavUCcnEPG6vasXgbmzBirzcvEBLMGiHiQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKssQUgP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777044502; x=1808580502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gShZ1CG4hNDUS7qdCPiJwJL44/SYxIHrsYlpXowRGo4=;
  b=TKssQUgPn0aNvWcwqaiUBAQCWGenv+d/j4mg+gnA7A+BN3OpdnBKSTao
   6HyiT+/Kgj4uoLCeTCevKpULZth7Tn/QFerNU5HQfBECYiJO1zktIWOdh
   y93LAl65JEadZ+s6Epmr4oFq1njXiVyZvPUavAMLQG9oTOGOEQpLJNJRk
   00Wyd/TJQ8xg6X2vKg5fpB1mq2FWuLIr/Kuwe9W4Y3B0r7zM5scBSl+0R
   WLkat6ZBF8g++yxZzVTDakZjww0eV7sHlGoXF4saHaIzUx4LoK39fkZ7n
   CEhdcypS/B0P2LXk0Me4xk6TtM6gpIa1hhMazojUkp+7KYfIGUqiHxFYD
   Q==;
X-CSE-ConnectionGUID: v6wZezmeT0auRw/e1pW+4Q==
X-CSE-MsgGUID: QdnEN8FZS+SEchTsYmT+9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="77729883"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77729883"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:28:21 -0700
X-CSE-ConnectionGUID: YZTaClByTHOCVpysyywoXg==
X-CSE-MsgGUID: Czbe7zOwQ6GNyd9TDE5tDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="229783526"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:28:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 08:28:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 08:28:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 08:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKGdf7ixJmejxy4C+fnOXjYoQWaulM3xDmKKrVOVU6P192eaBClOfub80U/pyofXzqSzK+Zz+HizxP3q6fSm+vnMG+t3bxJZTa4fF53azkfk+aqhT0H/hsyYSpn99HVRyGBNOYrRP/2RvtIh6k7lWOJCMN7y7YDpl7OCe4jjOcaxr7gIaRQ4j+6wWLy5iH9pLVrEJzMBeFcqra3Ga95IflfB4EIbAkRXTq0XWNPioXHxMS/sNmFR4r50fsV8cgxC9hwbODYTTDNduAKmeZ1h6Bl6IbgQNoNqkCldltKZr+ct4ORLFXwUcj21w46T8xBxO0hjK5wCt79SbrPO8w8MPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmaPLrh5o91JaIL1owRPWCP8yIVBKj3iGpS+YPo0m3k=;
 b=XnTMopS25Oy1cz+HTdVThzQPaAEbqekAIEInL7Cl1CQEyTeEc3ED19Fqnx4UYc7INZye37XBjEOeh1vz/ZCX4M/uDAI9h6keCpxTAtVxO4bLBAmi9z1XCJsTjbE979oWkQ1eqKiLqTEVDe1o59yG8wJcTe1JdNTiw4uFnxfUF4tuqVJ900RPtDQiI+dl9wo5f6lClRXyUtqCtjDV6TELS09zRlMtk/enS3hDBXcw7TwKOX/Vr5lcuPFl+a+zgdBDCdom3DOxRrmVpm6Mm7Ep/igwlAPDG9kuDg368GDjFbnX0rwyO/DGzbqmQXOproDFVFCaWTcQCxCYfuaFqSFLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 15:28:15 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 15:28:15 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Kohei Enju <kohei@enjuk.jp>
Subject: RE: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
Thread-Topic: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion in
 ice_resume()
Thread-Index: AQHc05cYFamrsyhmAUqqhnvuIXaSRbXuVqzg
Date: Fri, 24 Apr 2026 15:28:15 +0000
Message-ID: <IA3PR11MB8986413F786E0AB33890F497E52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260424030345.1140665-1-aaron.ma@canonical.com>
In-Reply-To: <20260424030345.1140665-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: b3906b7d-ce75-439d-dc86-08dea2161acf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|921020|38070700021|56012099003;
x-microsoft-antispam-message-info: 0aOiIlVSDqV7FSMFx1elBfPCCMnxu/rEx00rH536/Jo6P+Lqws0XtZzXJrPYKg0xNi/b8+eY2NWFd8Uo5ibORKEZR2KtQxpufhAQoA0qoPodBbXI5Bo8eVtmgcWr84XhPatb3Dtn/KuTAiJ5x1j/8wB7IEP91t1OdbAXWrWgzYRjL/oOAwbYyZ3iNKxPHlpTKeX1MNnU2CAySm2zeGh151/MHcpSN5lkHJuMVYMRxoF1oHs55Mvd8cTKc8Yq0dWir7B83h4Q2P/v1ZjbetvNMdSG3vIjerUkS9GLh3n2STVPG3MH1o4W+5yBxBht34XpDXYLD4uGT5jtmwKe+b0wW5yemH+4Elde7aY0bru2dr24B+x5yEkyiCRC2c/t/+nTlqFiR+IAhWWcQcpvYZUCe+MXzlapAkmVX2Mr2PHWD6uA1xO7pMMV5Kkv8t2/tEwVPEgoIQnUHi0IE+HcC6gd9RYL9ESXUiwgTo8ijW6/C4s/2EtqLJqm5+p43gnJyLhxy5lsuaSj2XiT3kZHFBJlLEvNk9kHPXJXhlH2id/RzkwsHt25CP4v0ogIWYUD3k7tfC6zgGwLCFmOSLc+PiLP9voR7F8o2H7XMmOWAvKS2wezjIJ4jK8uqSYfEcNK1KSSIUS19pgiS1gvSxiFzaKLGiCO7Zr2gWJUTKx9p+T5g07RXAJ1CcozfU6LrEWn8I18tsgdDyOc7/MlsMaln4gqbRQhiU9mwFhiqh2tFMITfyLl0IddDz3cJeZl7FDKQopaQWmVjA9KIXQzYTsh6Wcz7E+LROkeZIMIDrgMUNziCPqG5nPfWbPyEfIJ08ndiDuN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(921020)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cSCt4/ASQsjLYo/o+Y/SIwZbT6tBm8Zlo/P/EVj+ubV9osyo2N/jNJ1hQmCB?=
 =?us-ascii?Q?XGYDGS5aTh0Of8UYkZV5xDXCM2g8a9Ccm3UlAqNzXTl1fS0I/EY2fGAqKrvE?=
 =?us-ascii?Q?dhnoc5dgHMjxuyU3rOWIU0/CHZzma7/qvEMG5/Vrvk1Q6dFhKofNfJ4aSg6u?=
 =?us-ascii?Q?ecnWj/wpf78VkpCIExCzvG/fRT8Kmox3MqNkR5rJC0cfLD1SQk6vb1VMo5tb?=
 =?us-ascii?Q?hSNSUGufNAAnYoq3hyg4Zud3KxqECkqZ49j1MRwvR5glQ0fUTfm3oXmbJPoi?=
 =?us-ascii?Q?HJPuG170duqnvI7LoRKfjKARMxAEXJRinKFLgd5YP6mgP8D+LPzvM5zN+SqH?=
 =?us-ascii?Q?mH0Ana+363+8LoCnVpGfbeAog/75JuK053+CJVEAc/MeAkp3Nkt3gxTjBjoE?=
 =?us-ascii?Q?vK+hGhFWD4HVFUToxBIke9u6/UJTfueUTFmfA83FVLg4G8CpggoxqwBhAdVV?=
 =?us-ascii?Q?ffQh3usXLxuYWkpsO3XxZby4dgPRn71VuTKRUuYFyQe11t/P35QQEWCklBla?=
 =?us-ascii?Q?BUgZGVs6OSGJ7OOlMWFIqv0fFO23nTGqtVLBMk1owq1NcUlnGmQ/EgW/OUVN?=
 =?us-ascii?Q?BclFlgb0dagpxXUdEK72/qB6uGMXEaytgskOVMocsWDE9kXTRFv/67iauWPc?=
 =?us-ascii?Q?CdjyipeBDs1T+ut0WgDg7vYIkOzf3lcxvyOesOzRBoR6JHWiT+Bu8jIlbiDy?=
 =?us-ascii?Q?L3Re7AC3fYddkG8+iNtaeY2+FOSEG+1l8N1cBE/JFl1TkeHS6+G+V27XaEC+?=
 =?us-ascii?Q?F6DPUBUmXaxqRWRNKa0c70SuMEJTBpi0lCBbZ+16xI00VgHrVTnLiWucacB9?=
 =?us-ascii?Q?3itwno5uPZn+FGEjGez5pTChj4UM2CAfJeVQ6pPGLVieOZtKTw+IsaTzGemH?=
 =?us-ascii?Q?+PrXN20DVd+0BVoCWtYOF9zBm5qw+Wdnu7AT7jtoKV30y0dfH+qUh0BjPQR3?=
 =?us-ascii?Q?Uue6SWBWKb5V6Z/ekkNWzzuQm8or84hyJi0+vtZEufNfgsUbnhzlWNg9dBVi?=
 =?us-ascii?Q?fZBe3UjhqZgbkxYhWOOu9qiCIblFmdQDvWHAKEmRjcz+OSOEBo3YBk2kUVNc?=
 =?us-ascii?Q?77Qcxbol2g9a+42p1C4/BK5gcV32HDVZr2D99mzKx5U4pw8hsqXlT81FH5b0?=
 =?us-ascii?Q?/IZ+VLCSQ3KbFbpquVoSSaOA+bO+roH0iCU5KsECAund1+yYJaVNHVmnGi7t?=
 =?us-ascii?Q?36s0VbPqLIbmMdPWVjdX86iYwTP3iTuK6kH9Eg+rilh3qRfaRIWBIbz/mccW?=
 =?us-ascii?Q?eq9qTqine+LqUcL/atRVnpQEzP9QbBmEKIJL9EffrHzO1H4UR/da2CDmDIfB?=
 =?us-ascii?Q?HuReMx9U9kA1TyI7Kg0xB/oqQzaeLWOw+mLX2jKqr/SYfD2cc0ENV05iEc8Q?=
 =?us-ascii?Q?/Dgsme8yJJjI1xVCY0ozzxmpRy9Jf0J4YyMBu69Ve+wXa+CJNG/mzn8uUOJa?=
 =?us-ascii?Q?HRntNqL53XlWbCQ+4STytr5InZgkUX09e3yvUTLpA4AMto4MKOszyJZGKHz5?=
 =?us-ascii?Q?yO5uynuHGBMBoANZOeCPsBFIfKw3arXOF6HbqjHcNzQwPqGH4Qjs9IxpceEE?=
 =?us-ascii?Q?agkAX7l7M2g9xMgH1mJJ4UkpPOqS3gIZXWli4QE4lyk1HkNAjkBuM/jtBOTd?=
 =?us-ascii?Q?NEWNVnZa/PfxHvCbJY0zmvvfjHV7raGQWkfAH71JSTY1Y3cHWUpeTn+k/aPv?=
 =?us-ascii?Q?cwQ5kBqhzwHV4qWoZftUeJBIOmrf5r3ux2FNo5IPeEken3wrCbeJVfgZTorH?=
 =?us-ascii?Q?jxnFVS20J86RumuWgx7/9PHLRSH/J0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uvGL/e6QJZpjWP1oK4cmpy4pXPcJxzv53KUX6QChCtzHN6qWRHJT6fMOS4sxjF7OpXFtb3eJrdU8CYETUHZUjqtlRLjUPq8R7F46WLmzcbCZxj7+zoh7HJDYoD6LzqVMRzeaCSg0+cId8V23AaLHFC++xgDIligrUz6tE6LqJFOtKKCXWtuSYI7eV3iKLSej3/pTFrib6FE+MO6j9oKC9axq7KMIV5TDR35vWuj460U8LNDIA9L2vaGt5qB12yh+iJGcOr4l2tkvlckWSJucHg3nkifbFpV1FDObwIJoj2TFlMAFjskIzrbhoqMAfbOCcjvm+Flm+uTL0yYmvRjx5A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3906b7d-ce75-439d-dc86-08dea2161acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 15:28:15.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fUTvwpGXw2NupbcrFxwOAdFVd1UACAMTs49ZiL2DH7f37nGRq0PSHsjvA9YhArrlF+OvazGA3Wdd//c9iZGTuPDLAWzTKyNjGOTA21GBbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 1751B460C63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281004-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Aaron Ma via Intel-wired-lan
> Sent: Friday, April 24, 2026 5:04 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>; Jesse Brandeburg
> <jesse.brandeburg@intel.com>; intel-wired-lan@lists.osuosl.org; Kohei
> Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH v2] ice: wait for reset completion
> in ice_resume()
>=20
> ice_resume() schedules an asynchronous PF reset and returns
> immediately. The reset runs later in ice_service_task(). If userspace
> tries to bring up the net device before the reset finishes, ice_open()
> fails with -EBUSY:
>=20
>   ice_resume()
>     ice_schedule_reset()          # sets ICE_PFR_REQ, returns
>   ...
>   ice_open()
>     ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
>   ...
>   ice_service_task()
>     ice_do_reset()
>       ice_rebuild()               # clears ICE_PFR_REQ, too late
>=20
> Reproduced on E800 series NICs during suspend/resume with irdma
> enabled, where the aux device probe widens the race window.
>=20
> Wait for the reset to complete before returning from ice_resume().
>=20
> Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v2: reword comment to clarify best-effort semantics (Kohei Enju)
>=20
>  drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 5f92377d4dfc2..a81eb21ea87c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5635,6 +5635,15 @@ static int ice_resume(struct device *dev)
>  	/* Restart the service task */
>  	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf-
> >serv_tmr_period));
>=20
> +	/* Best-effort wait for the scheduled reset to finish so that
> the
> +	 * device is operational before returning. Without this,
> userspace
> +	 * (e.g. NetworkManager) may try to open the net device while
> the
> +	 * asynchronous reset is still in progress, hitting -EBUSY.
> +	 */
> +	ret =3D ice_wait_for_reset(pf, 10 * HZ);
> +	if (ret)
> +		dev_err(dev, "Wait for reset failed during resume:
> %d\n", ret);
> +
>  	return 0;
>  }
>=20
> --
> 2.43.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


