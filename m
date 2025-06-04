Return-Path: <netdev+bounces-195097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5048ACDF62
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808C51623F3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3D28ECE4;
	Wed,  4 Jun 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmuHMeui"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48F42A87
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044359; cv=fail; b=QWY9nPxfYojL9Fjj7KEqEl/ef1dLbOWzcAC73+0A3UStZ3Ob12yPwDQtCIcHV2IQdVIukM1iAs4GoLxaF6REr1rpSg05lsohhtaMWp7Ta/L1rYCvRkTlTU3SQ0LNicLQLey+f/9Zwdf8n6NzYE7tnLMGU+SRovy/J86GJqkbRJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044359; c=relaxed/simple;
	bh=T61YEMqSWpoFIX2ZuWMRfnioG/hR+4E10rQ8eXcigz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBiTPFXoocQj4JmEwsrSASOAVpKBU5NQ4hFIyMONPSMQmOtl4ixFhr7uMIlmck1LUUatmF2EznleI+nisTATjQQDVIuo/QdWUvCjKFEXJ2TgQOX8BX5fuGQTsLAxFJsEpLGJLqBjYv1ApoWePUyTjHCL9tZX++MDMK7wxZaOAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmuHMeui; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749044358; x=1780580358;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T61YEMqSWpoFIX2ZuWMRfnioG/hR+4E10rQ8eXcigz0=;
  b=VmuHMeuiuGyRE7U8PpNy6XhBZBHRslo6/nhNxZaVmbu/kmxZgebDOoy9
   FtJtjFDMCiclJsrVD4tswlXb8zgqug1tx32mb0dArh3jiaPGczEoCTex0
   wrs3VvcuoUjYBKHG7LlPGFKvGuqzDTqB23I7G3VsOSFw3jNLjltL4kjgH
   cEU79y1V530ZgdFkjbviN9IpB0V4KYxIuGJrKKqJDS24GsTggGTNe9cAc
   dW2etvaBO+yve2lyY2mJQDg16yE6fMqGiCt0WlsJfF8funfUWzy1z5x08
   1rsBx/Ct2bKxiUjKMy3rvKRf3dG7i8RPZ3WzmlBIVXY6j4hgPTIv8Rqyg
   g==;
X-CSE-ConnectionGUID: FDLjHgpgTEmhtr3+KK5qAA==
X-CSE-MsgGUID: Nk0eHwJ6S+uSJXuKpFjADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61391866"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="61391866"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:39:16 -0700
X-CSE-ConnectionGUID: 3+FdUX+VRLSPywnpqKdnIg==
X-CSE-MsgGUID: uPW8IzpPTBGaP8ll9GZ8TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150468272"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:39:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:39:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:39:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.78)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 06:39:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8lcN2sMwonTEVrLlE6HlMLyLB7kRTkaLBywRaNbfNJ+ymc5yUCSKrxW6XVYdD6JwWWi7Ps500GkcvAJ57ZMFD7u0Nx+1whgg+ZbDUFwn+8rgS5xRU+//e/qG+8N5QTYE+IEiSLh8g0Rmbybi9GvtytR8ovK2bkScHuCh09WXoYVPvjy15jj90BoL/BTeMHTn6lXlmCpfWSlKrxqbzXgrcQeV+aPkLe9MrsoVvwCTpwT6liLQS5HoM1VuYzv3AnshwZrsRLg5ibfGH7B/Q22FxObP/b36TpNAL8JEEV6pZxNPfY9JoilJXVHNB4OFRDgl0LQNdEiChucy2OaxQeeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcT/qQDCxEJiWZNRcirZTXdUwsF/DLTDh5D/bUs0CaU=;
 b=uW1QKlLMNayt6+W7EkWxHt/gO1+2s+7jniBH/nF9lMGW6hYyu9ikWzx6VdCTB6w4fU02tri0RcPvU55e3jPQqyVuVflMYibVOwJJ6X+6ZGaFAkw2xqqxA6lac37VrE2vN+4l1PqJEK5HnvAbrXsQV+18Dsb3uC5I/bLWf3JJ0HkxnH3IiLqoWmESR6aHBu8FWajwTgwTU2kf2m0KBcb9qriK7H3r+0bCE0EKLL9qgdvbI6wExr7LAoHem2mnzgPres8OJhBsBn823D+ZXyRB47znNv4nwNkbAjKMySgVLaIm6qeFSkgKErEzsRfDJ3UXA2EVuvY1F848kMZa/7zimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Wed, 4 Jun
 2025 13:39:12 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:39:11 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/5] ice: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/5] ice: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
Thread-Index: AQHbw++K4hDbVTKZl0y75V1dBZ0UNLPzI9Pw
Date: Wed, 4 Jun 2025 13:39:11 +0000
Message-ID: <IA1PR11MB624146644CE381FD9D8F3CDB8B6CA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-2-vladimir.oltean@nxp.com>
In-Reply-To: <20250513101132.328235-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB4968:EE_
x-ms-office365-filtering-correlation-id: 54860172-af09-4705-0360-08dda36d3096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?umF5hL0z7UbBUbYZgFnhaiS3mW9A1Zfu6jeku9NhaAkimXJIN9WZGyYQRTTl?=
 =?us-ascii?Q?ki2ATVHUh7DqdInc36qBJXoTZVuB6hjSjnm5Cx6pQ2DujaADbR/0Ho9lfF4S?=
 =?us-ascii?Q?ZkIM1ewn60TNwghTlfG55hQvw3MFZ0bnF0XYaU7N5SHvkpXE32lzdLAfYAOZ?=
 =?us-ascii?Q?tuTpFNWCQHsgIp6slS3QXqnsSwvvK26F/MBOuF52mZX/+G6KhZwdHloRtMRw?=
 =?us-ascii?Q?nhHxHFvkQpKcOAyay+zJoukj/spuGC94zfvHt8q57JDDda/kQYT/GLV1KO4T?=
 =?us-ascii?Q?hZqzxbvb+HmJ0y+uL2GxsBUkmiSzV/ya46rS1xtMkQ9jSEZOkCUMnYACNn4c?=
 =?us-ascii?Q?J3WjOt7wT6pqCzZdRZAJqar4CDdk2UW4cdv3gm8H8N6pF14uLECNsCRTyrXR?=
 =?us-ascii?Q?q1W+gdMDB6T/cZCpYh8RnSqNLy4sdeK3WVfG+FII79qVeb3wUmNZ97nIumbF?=
 =?us-ascii?Q?fbk0YqbWAQ4Z8nCWtLLJ75ROa/6VSWBed0OX9aqFlLq4jWQ1bomdvr5XiH4y?=
 =?us-ascii?Q?51sH/4hRarS5mExGeD5YrJQXfcBh+zqcGxKCTLdueST9q2QnC31QCU/1i1Tg?=
 =?us-ascii?Q?boc4N1BLEXTkZ3f0maLbgI9QbWdsFmzeCNi8/XO7Ytbh6QdvVDH6o2ICn+Bi?=
 =?us-ascii?Q?0YDFXoz87mZ1sZWzMNzxv3Z2X+aOyKHjpJ//+Lj0vyM42aVjm/3NJ0F+jPu2?=
 =?us-ascii?Q?2n6a6afb3VGXTn8Ix6AGdzUDUNnxkYRlNIxoSa23BWQa+RMNcZa4Uphoa6rH?=
 =?us-ascii?Q?Y8neUBINuhwYKO7sMEu6RlPCqCsADUp6rWxghabPr3HetlsnrHPVS5A8PKPT?=
 =?us-ascii?Q?UrKhphzwjb8HySc3IvvxQIWaTpFJiFeY6FguB6HnidKUDQIXppQxOLphH8+K?=
 =?us-ascii?Q?XhiF6emh1O9Ex2nHNE/hi/RgNzZ3wUWv9zbP4JGjrsBIc3nDvPp/Z1mGsC/X?=
 =?us-ascii?Q?a/Tl3KtdreMLrgy/Dpk/ZjbmMv5SeQNd7q1hu9NY0gCcmHxJt6Q8L12BUvQr?=
 =?us-ascii?Q?paocCsKQLkRWRwLxXHehABOBPuUgCojlkyK9KqUQRnGDXkFoEjGkrsdljY+A?=
 =?us-ascii?Q?Qlx2BhqHc2/giN50Zvh1Iu/U02sKOo5CZbrdEJVoP82TrD7bl5UPBlkgZe8m?=
 =?us-ascii?Q?cIwpBhc8Pqxv74ycOg96100o/dUG2QEszdAtn2mYMhIuY5J+GdsJqNs/WNdG?=
 =?us-ascii?Q?x9Unz/tDDIUAEmpLrWdtipQ0zPRcA0o6+5/eOtzmxqLbQGCBPdzJDQ333jF4?=
 =?us-ascii?Q?/vrlMt/VMVFHHJ3D1+Qw02YYNCeNnh9bvHuwfHaQALBYGeHz7SYb22vOgUWN?=
 =?us-ascii?Q?fpPIOdy7TIXJNlNvKP4bYfDUV6dOknIFlebbNSVqm7qml7RKADcTUkWDFM7B?=
 =?us-ascii?Q?/wx4oly3waLM/GuTAwrgs79zJfyXbBO0wdnG5Y23I8xxKaPX6Y7z5xuLSjdi?=
 =?us-ascii?Q?aoV+drAkTCfOHia7R9y0Wx6AnMC/xcvC3x9uitzKEa7H+lQFYDN9XChurPfG?=
 =?us-ascii?Q?cwg7z39vp+LeMks=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PkNaCwXznHytWPsQvI7EE8x7DHNzWkPDG4+pshGiRToJ25vKgYAk8SLedMsb?=
 =?us-ascii?Q?PS9dLwgIPXDIR05gg9r2kjRkVjHvLwyEKwVzXjfK/eF/MguUuCyUqSN1Pjkw?=
 =?us-ascii?Q?j9YBUesP9O+cSfPgBBAE+w6+6t6wN3ZhnCl4Dzj9Ty25wpk8rcj0eGsK6Gw4?=
 =?us-ascii?Q?Dynl3H3tm8PipkUokfITEDL/pHu0Kahnu49L8L2xXC3W4O3ENdln/Zgq7Xi1?=
 =?us-ascii?Q?wfGyQ4saVYf7izHRU5zDoezRQry+J+RJ6coYw1auzV4OMlym6wj0xSDroa4I?=
 =?us-ascii?Q?atdmSOGoL3ewxcDLJ5NJDErc9N2hBLQZlFCUOmUF32eShFj0cZ0+0k8A6MXH?=
 =?us-ascii?Q?XxSYGACAhkegx1hgL3xTJ2/nHrVDmsQ4E9p6rU/GysW9dN/3jNAFxRxWRHJp?=
 =?us-ascii?Q?KL1IBGgZyvpEbR1KhEfJCfPQG6v26MI1NHgLpvOtNS6dOX7HhLBnHPSwFD1f?=
 =?us-ascii?Q?iYzN4HJzcO2LEGkJAjoKwxTXIXZ1YjMGwVj3oIMpzDxPJanUb1TvBeiNCxwf?=
 =?us-ascii?Q?fdl6SfzM6BE3pMhiiFR2zz0DjSBbDvvMn6w2243j/czCX0GC+gPmXw59GQeI?=
 =?us-ascii?Q?bn56cpMY5RkN5HBFalOJYFozPVoIRi+Xc70bzg8bQNdB+gqbD+SbdF7U3HdO?=
 =?us-ascii?Q?rHJgpxyigtReuF9p3wTdAonnm4D3FIgNVsJK0WxeW2CpcZzDD6vWpa2q54H0?=
 =?us-ascii?Q?xbfDuYk7ywUsROuWmuUtSEFVL5i1zDbZN8oI1hJCiHq8zhoq3ST3sepu9XvD?=
 =?us-ascii?Q?pEOgoTZrl/77kJrCE9Pu1v2nbHZk1WD/JUCm5jL5NJeUYc/7pQ0w7p+tP8gi?=
 =?us-ascii?Q?2ztB5h1gvjVS6+9JcCuEJb6xqxqcdmuT4F6SelKxzge3LiYkb4h9K0V6qINT?=
 =?us-ascii?Q?mScf8IIqL+15axdJnuDn0YkQamocWErU38nL6pojoxIckWDnctesHL1HOjl0?=
 =?us-ascii?Q?RCzkUKIMsi72h0osNaxizwuqhP8dwKN33oHdgNEUFlPELYpx6X6mp2bskDA3?=
 =?us-ascii?Q?32B7ymkrAI/68vJOWd1kuLPuzCHeXh09hKTaSUiUBeurEWXDPxomrcfHqLe1?=
 =?us-ascii?Q?Xh3Eps8h4mTNbI27JAX98W6xrKI0MK28yJmbWFkEPcJe8fouocjdFMGwSqrg?=
 =?us-ascii?Q?LG3rinxNWV/LTshyhz8d5Li3oKQksrd1YUhE5+7IVX1EzOqXW16tBw7KRm2G?=
 =?us-ascii?Q?tms1LIBQ6ols6B/CHNM3l0lAmROnXsoar9sEASgV76L6ZVE9TCRJLv/L+7pF?=
 =?us-ascii?Q?dPEMmZtPJg3br3QaIN+lHYo9QxJdiFV4Yy8gWUXxWLp7F5mZdU0rllT7dHmm?=
 =?us-ascii?Q?Xyuk6+HO61PerySvdFmobW7rX2NXWg7/SaguRYoOl2LlXfWPUl5QQJxBzWbe?=
 =?us-ascii?Q?AVJH6qFZczJZQ6wWHu2D4VC4DjqatyZFGXxG3MIq9fHWxWKRKxIgR/fKUNNs?=
 =?us-ascii?Q?+P7FNi1o+V3xn+BIt4J0Mp/vUa8IdHKrABQ7xM4c6mnDjHwI0BVp3O+/+gKp?=
 =?us-ascii?Q?KTK2tmJRphWFNEOCN50BngemX+sBpWVGwLOLCCSAFUihiWsU+8PFW7POqlv0?=
 =?us-ascii?Q?74+pNP9JZGYc+3PSa+UPyClsg3aJ14Zd1NsOLc1I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54860172-af09-4705-0360-08dda36d3096
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 13:39:11.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uZ7QKYVGTLltpZB+xMjrfnZxqnsxeRECJhqeqp74VppA4+1U3jm3UZOQJoUV0O/dB+iCTrCEEQyY97uYHIOjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of V=
ladimir Oltean
> Sent: 13 May 2025 15:41
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Keller, Jacob E <jacob.e.keller@intel.com>; N=
guyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemys=
law.kitszel@intel.com>; Gomes, Vinicius <vinicius.gomes@intel.com>; Vadim F=
edorenko <vadim.fedorenko@linux.dev>; Richard Cochran <richardcochran@gmail=
.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/5] ice: convert to ndo_hwtst=
amp_get() and ndo_hwtstamp_set()
>
> New timestamping API was introduced in commit 66f7223039c0 ("net: add NDO=
s for configuring hardware timestamping") from kernel v6.6.
>
> It is time to convert the Intel ice driver to the new API, so that timest=
amping configuration can be removed from the ndo_eth_ioctl() path completel=
y.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Previously submitted as
https://patchwork.kernel.org/project/netdevbpf/patch/20250512160036.909434-=
1-vladimir.oltean@nxp.com/
>
> drivers/net/ethernet/intel/ice/ice_main.c | 24 +-----------  drivers/net/=
ethernet/intel/ice/ice_ptp.c  | 45 ++++++++++++-----------  drivers/net/eth=
ernet/intel/ice/ice_ptp.h  | 17 ++++++---
> 3 files changed, 37 insertions(+), 49 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

