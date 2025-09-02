Return-Path: <netdev+bounces-218998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28EB3F4FD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F943B5BE4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7312DF13B;
	Tue,  2 Sep 2025 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPkdqdwC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA617555
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793169; cv=fail; b=nQdUP4bLhE/X55Jo8DVWVTPjQZ0JRjv6UZsj0dspHB6onRyTTAnqiTSopfv0FL2kTj+PS/eSD3UeDWr1EXVD6yYhGiqeYYRXY0y9rD9Cju5iPlqsizC7QGE8BxuKkJSVKbhCk9PHgevWLfrtY9NaRju7u7hywEC+PPk7XkXglSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793169; c=relaxed/simple;
	bh=GARRUBHKthAma4qOQ+t4NPDZU12xT48tzBnsEVjjxMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+XNrSgwYTCASvYCglpVzidu3YOxZ/MBPbAWNFjezZqnex4/V44RBAojstiPDLKvTa550NsUkfEoOyTAHl1JRUHKP313rIebWU0apNa/KX+2gCgkirmlMri7t2HH/czx/q+tncsUdsiZwQd+l3Uc61pOLj6Crpw02SttgQ+fDe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPkdqdwC; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756793167; x=1788329167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GARRUBHKthAma4qOQ+t4NPDZU12xT48tzBnsEVjjxMg=;
  b=NPkdqdwCiHJ1xUhzA2ugG6q222CKP/X7wlj9fozj8uFh1eHcRhdzb9vu
   Ps4VWIxMUkgTY6xbuJT9J+TYE+8sRffy+Vhz0fo7ouwY+zLvI6xKqAaKU
   cTlf7jcl9z71p7kFeexyh7dT1tw3oyfSdDh0Y3qzLiQhxCr2/iNcY8aer
   hZGfxAAZyMn5V5UaA479HjPcSfhODp+quLzrrdOvpVWUgroYD+d0Ls7xg
   q8kT/gpJiHBlggaKwn6aExK8lpWEBIJYjKeoUreAbhgSJLmaAR9NotLBr
   5mHXFure18KcQF6MeKtkqmUGB/I+NRrlB3mb4LAL/Xdi0C4D8CJibohDh
   w==;
X-CSE-ConnectionGUID: knTNw5aASuica2Ogd0/1dg==
X-CSE-MsgGUID: oll7MZ9YR92royegHXR0vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="58905887"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58905887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:06:06 -0700
X-CSE-ConnectionGUID: oIcSdgYnQXWgy3OSMQjw1A==
X-CSE-MsgGUID: BRM68M2qRIm6hC7x+ZyYjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175550873"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:06:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:06:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 23:06:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.85)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 23:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQz8K0bbWBjnDY4rHgd1CAjYjZPYqfxHioTXw/0Ef8tYZcNmdZdaotJsKnRA8DC57LFk9T6FpW8sG4v5Z377FLm2i8+axoRXb59giUH3xmcqS16vg/oGnEOVl9EAfeAfEh0M7+QZ/MQ49a+ZNzapiv3nXbguFzgC0VaIFtqNK04FqguYGmUiaBhVgMuJDyet8wiDkBeFIuaTUSdXdF7taC8QLwSXlYGVe/3TgSi67fYeNhFjawW1TevhpZunn6H38ofVE9dTMHChjL1+SZOcCaieLgXVM6aZLdTGgXg19G2aw7RybZYsFmtP3thQG/7U5gcv7HoGPk5Y3p53Sa5h8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFlBzYzeRdIHDDYYGts1F6bGXaZbvySILgcp4vtaSlQ=;
 b=pAtAv4HNO3zghghkptabB6j0nCRh8lqpGNDbcbvxvgfL52CwYUaSiB+F4/NJ5+1kvFKIVnlmA0QRnofu+mH3HIgbZRDeSJpjGDNFELutEV2MmORV9m4yVznC6xndbdBIDvQfM+NaCNtxcdGKQRSTA1EtidqQSRR+m7KHryW7pSKWvYQyGk1FnaCWaXxA2AOlefp01vXb+YNREnZpuLGgnww5+WcyYBQgVgl+dLOr4xhu0l2euuTdF6sGxQZiotTnuFadnGvOZ1XTyUM2MP83nTTqW0X17awEbm3mGqzjn012M9OlOUhBW9vPNaB9nR4LYyI805ifokYHUh0n6juR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by SA2PR11MB5115.namprd11.prod.outlook.com
 (2603:10b6:806:118::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:06:03 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%7]) with mapi id 15.20.9052.021; Tue, 2 Sep 2025
 06:06:02 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan-bounces@osuosl.org" <intel-wired-lan-bounces@osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"(Meetup2) MTR-FM1-AVLAB1" <fm1avlab1@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	"Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: drop page
 splitting and recycling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: drop page
 splitting and recycling
Thread-Index: AQHcCH0wIKVwiQnJSUel9OyxNh24HLR/f+UAgAANGoA=
Date: Tue, 2 Sep 2025 06:06:02 +0000
Message-ID: <PH3PPF67C992ECC2AD31E5DB372B564E20A9106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-3-michal.kubiak@intel.com>
 <PH0PR11MB501328DFC538260A11368B499606A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB501328DFC538260A11368B499606A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|SA2PR11MB5115:EE_
x-ms-office365-filtering-correlation-id: ae3690b6-28c6-4f8c-51cd-08dde9e6cb93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0aiqOEevwpeSeJWLcplBnfNF8ZFfxCJlohroOMYg9uQOdzecyaZIrvYkN7gU?=
 =?us-ascii?Q?U/UeqtZGJe7RlKrZIhcQNYMjf5yLtjCFaKqNbUGQ+hDImEbpaooTHoMFTQVD?=
 =?us-ascii?Q?a0cE3eqU+TdtzI0HvQhXuEUOlYBrcypJyL3gfRZRyDXM55GMe8nSzzMKNKqH?=
 =?us-ascii?Q?ch+RSIg2p67c2VrYmvkyz4OdhJZzQsveQTBQvEbc/EwRrhHxnFgBVemFph4/?=
 =?us-ascii?Q?xLTgNs6LyaW9dKnsNxwlrAGv+QjTdEiyWPgj7ewYOSfT9e+voLt99z389Asg?=
 =?us-ascii?Q?vlHGMmD8bznG3Mh2nVCrkugit6BuLMqfCeuiW17eSK2sPevZcSTli+NfvpkA?=
 =?us-ascii?Q?7reW3kjPdmlAgVG8obTUmiooREDZxl/w/k7ZMPRstMD4a6gwdsUshdWKNiBT?=
 =?us-ascii?Q?uc5jNYnH9Nszl/fm+vC4DJm+Qhsl5Ypt65xylZi4Qozb0BM1Pcb8b0rORYI0?=
 =?us-ascii?Q?VeB9geoHcaKTdMYwWNDGESr5ciOElp3d0x7a7Mk8a+QrUT1Gc2pr44ySipdl?=
 =?us-ascii?Q?Ya3AWBKaxZeQLPZZUHiSe6MMHHl/kn/MS0lMs7JFsP2g2L+ytMeBD9hsKsJ7?=
 =?us-ascii?Q?Zly/LxYDERBjGulRborFCxYvzIrRHAySd7rZ1FUGtqPhQL66ekiVt/jkKPNR?=
 =?us-ascii?Q?blnZ5mJ4awwHWwCRBq8yDjoAtzz0g6TaG2hUyeE8kJN2CyUMryL5GknLB2BU?=
 =?us-ascii?Q?msEkqRe4zSE64N76PEs59qKu7otQ9JFqL+XthwUlypQ6wCYOMPFa6F3BQe2q?=
 =?us-ascii?Q?lFXGwyucqLYL9B1s7goOZIQNRL7us6qBzB37sBPUZL+OvrJ2wWOd/xNGcsXR?=
 =?us-ascii?Q?NJa+h4jyVXXwTkohLIxYtvci9l9vb1qs93t3kb4xX1gRrrh+eIdE4oy7ZU08?=
 =?us-ascii?Q?1MAhNosM+dbdUUFKs9Bku1lLWDDUsxcKf1KcTIm4c9vji3WjOfxYvnofi+MR?=
 =?us-ascii?Q?M8nv9Ycrj8rUE2NzbFE7BGEx4eCqVQPcLfQZNWc+6Oq2/nezoGdET9gRGgeO?=
 =?us-ascii?Q?xphLaDTQVsmu+9joPw08s1y2twOb9bprASDa3iyTyqkUnkc2wgpHux9cHhzh?=
 =?us-ascii?Q?5VsVWUEp7CRS7OkLO7dO+96snpmDDceOSQ1gM1JeXsjNjqAIGBYaY7h+fW2G?=
 =?us-ascii?Q?s7YfQsNCLUOdBh/L/Hs5tnsqsCWnPEcWTHaIyd8GXh0Gclq2snFbuDfmXa7T?=
 =?us-ascii?Q?LY/GXWtK38gczj3c9i3ZX0Q7hdjk1DASW6tpwVF+VwyoyxF8TIh7vXCaspY/?=
 =?us-ascii?Q?fq0ctnR4x0pCktPnwFucJSdTuzlrp4tbTuXNm4pFiMvWsFq/f2JnV/PDxndb?=
 =?us-ascii?Q?n7RMBqhKTFhzeVY8Q4uwNi3Sh25hQYQxjkq5zVsP0iNW8kEUct4kGFn+ozyp?=
 =?us-ascii?Q?VyxbtHMKAhlRAKkVQZYcdHmIv8AAQJxndw5nTldo42Flt930fovmNVejpxRp?=
 =?us-ascii?Q?tuffzV4jE5RPuFB0HJYQqs8rvIN1Cv61Msiq9s/ubtSlG5Yb9rxbQ7MfSoTt?=
 =?us-ascii?Q?eouAA483XGv7EFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XvKhUZtbQP915BBf3JFQHCjVEYWWlrOmTCnJgOIiiv84Ide1mhXjONPVrpm3?=
 =?us-ascii?Q?JxM0EsiVyHq98cxIPxDa902RnobMdR38TVGxpFLkqWJMVLNn8X1uuxYIaTtK?=
 =?us-ascii?Q?W/hfHbKkSNo4/s57GwtwOWimclUrtapEvPEPq+JCxJU11EYZYx90OTIALT+5?=
 =?us-ascii?Q?hJGDHgaUjoGImxBDjR7A0v9FUwb468E3FKUsKBa2Q9Buao9PE5abpjT42USj?=
 =?us-ascii?Q?hTKvoMggnVfhGlz1drZ03NVSnEmp6bN/Q2nVHA7CpbTzxltH2oXcvzazo7dU?=
 =?us-ascii?Q?L7uyPU5a0TFonyXw4mUbdx1cjzoobLX+jO6oqr4UWEST8RjrJc1UqbBqbw36?=
 =?us-ascii?Q?/anivxpAQo5fHllbojzIa9pftivJPz9nQRkc2TpoEnZoCHxcieVhXw7pqVMz?=
 =?us-ascii?Q?KGvjWr+RC9CsIP2zKtney5265HqP2Ck5eQANCY7ny3r7EZmbmvWyUmmmA2KB?=
 =?us-ascii?Q?UrrmsfmIS3nB7K6BQjszg4kA5NFg02do5F1KQmElWdBkeOghcWTpN83THdEf?=
 =?us-ascii?Q?bCF84iL66yZ8WQwzMIagI/Je55A+R/Sw0Lr4C/rjWUP/VYkFACvR4V2tMpTu?=
 =?us-ascii?Q?6lKgcxzE3A2JQAJ9JZYC7AiLBb3LTaKE0d35sZU09ya0cM69QxNf8v/ZYASO?=
 =?us-ascii?Q?EgL81j6HOy3KnLqC2ir65m/iRhaX9lmthUE6XlZtGTqaT+TgsQMW9/rTaSM1?=
 =?us-ascii?Q?dhQkyj4rqR4lS43uefrZ3XnnejuhlOjVoesExPOz5D63JiXVcw/5E6yW1rO2?=
 =?us-ascii?Q?YtxJvgENheNkxL6Bxq4afSLKpLMj0TpMGsk9gFjDSPJAFFG4zx/TWnNZU0UQ?=
 =?us-ascii?Q?SAiHY6E2ek3JNs65+T6L64SbeR5bdpC+TmqEQNCBqKYlaH36gxULRhVo3wcp?=
 =?us-ascii?Q?yYb+YMco94uxR7zIoec4n7CHRyM6ZGT4Hz3bSV5jtqjYzD/U3dX2BM+6wyXP?=
 =?us-ascii?Q?C9A4IDlyD3lQzmccOaFddYPwWiiCLm0lU38CiXtaVnCq7txlzJTNDqu7uEDB?=
 =?us-ascii?Q?O8560Uh0KXNfCxYfyKT37JnxBf9T6UjeZFnJTiLqTQlEE9cJxmIDliqzkUVs?=
 =?us-ascii?Q?RshVckoAFuhJAha7TTryVBdgCK7j3oDA7QJwUxBU4yeyNdJL+0Hck1gqYRuy?=
 =?us-ascii?Q?s+Kl+Ol6/qPYkcWsQPPP6CHbokSIaKSnT/gnYSeuEqQJQPAwnkOXOMc77R4W?=
 =?us-ascii?Q?b2R/pDETLEiWIeSYonCdksmi5TsAiEWpqwoj+mONPflpV3KfLjV7eKmuvSxq?=
 =?us-ascii?Q?rROyXXFUjacGtiDloeNsO8O2USXonGszkuuioqZzWWyfo7r3jWpsXfFjU6ij?=
 =?us-ascii?Q?q0RpvTv/VmB6WDC8BsB/f0KIA7XwhuSlqTKGQr9ypIAc+06raveKn7mFcjz/?=
 =?us-ascii?Q?k8COgSVsnQYkwJkAlq6BlYdAUcDNUQxraxuxs/wUCDAxCAk+cbznHGhRlL3G?=
 =?us-ascii?Q?HqBN6jsyAKKimI8d6JAEM/qojWEDExeaUM38xQmjEikQ49bAeE6q8XptmN74?=
 =?us-ascii?Q?gSNCNL3uha76FBCkzlCu9G7CrmuStDzjX7mQqI0PvlS+dRzNacPmg0Kz4EEc?=
 =?us-ascii?Q?7ngmzH76DIaoArLnbodUgr1mn4EuxUFVZZr6RRcC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3690b6-28c6-4f8c-51cd-08dde9e6cb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:06:02.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9GibZuqRiY1toy4o1qzZhatv+SDUmDqZXOJu/UhWfUGICi0n4SWfgSI1ksWdCZr9AGl9v713n/9T6dv1108QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

> As part of the transition toward Page Pool integration, remove the legacy=
 page
> splitting and recycling logic from the ice driver. This mirrors the appro=
ach
> taken in commit 920d86f3c552 ("iavf: drop page splitting and recycling").
>=20
> The previous model attempted to reuse partially consumed pages by splitti=
ng
> them and tracking their usage across descriptors. While this was once a
> memory optimization, it introduced significant complexity and overhead in
> the Rx path, including:
> - Manual refcount management and page reuse heuristics;
> - Per-descriptor buffer shuffling, which could involve moving dozens
>   of `ice_rx_buf` structures per NAPI cycle;
> - Increased branching and cache pressure in the hotpath.
>=20
> This change simplifies the Rx logic by always allocating fresh pages and =
letting
> the networking stack handle their lifecycle. Although this may temporaril=
y
> reduce performance (up to ~98% in some XDP cases), it greatly improves
> maintainability and paves the way for Page Pool, which will restore and
> exceed previous performance levels.
>=20
> The `ice_rx_buf` array is retained for now to minimize diffstat and ease =
future
> replacement with a shared buffer abstraction.
>=20
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |  26 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 136 ++----------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   8 --
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |   5 +-
>  5 files changed, 25 insertions(+), 152 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index d67dc2f02acf..bf37c8420828 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -369,6 +369,8 @@ struct ice_vsi {
>  	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
>  	atomic_t *arfs_last_fltr_id;
>=20
> +	u16 max_frame;
> +
>  	struct ice_aqc_vsi_props info;	 /* VSI properties */
>  	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored
> */
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c
> b/drivers/net/ethernet/intel/ice/ice_base.c
> index db2fa4a6bc67..aa75425d92e6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -391,7 +391,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	/* Receive Packet Data Buffer Size.
>  	 * The Packet Data Buffer Size is defined in 128 byte units.
>  	 */
> -	rlan_ctx.dbuf =3D DIV_ROUND_UP(ring->rx_buf_len,
> +	rlan_ctx.dbuf =3D DIV_ROUND_UP(ICE_RXBUF_3072,
>  				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
>=20
>  	/* use 32 byte descriptors */
> @@ -432,8 +432,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  	/* Max packet size for this queue - must not be set to a larger value
>  	 * than 5 x DBUF
>  	 */
> -	rlan_ctx.rxmax =3D min_t(u32, ring->max_frame,
> -			       ICE_MAX_CHAINED_RX_BUFS * ring-
> >rx_buf_len);
> +	rlan_ctx.rxmax =3D min_t(u32, vsi->max_frame,
> +			       ICE_MAX_CHAINED_RX_BUFS *
> ICE_RXBUF_3072);
>=20
>  	/* Rx queue threshold in units of 64 */
>  	rlan_ctx.lrxqthresh =3D 1;
> @@ -504,7 +504,7 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ri=
ng
> *rx_ring)  #if (PAGE_SIZE >=3D 8192)
>  	frame_sz =3D rx_ring->rx_buf_len;
>  #else
> -	frame_sz =3D ice_rx_pg_size(rx_ring) / 2;
> +	frame_sz =3D PAGE_SIZE / 2;
>  #endif
>=20
>  	return frame_sz;
> @@ -520,6 +520,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring) =
 {
>  	struct device *dev =3D ice_pf_to_dev(ring->vsi->back);
>  	u32 num_bufs =3D ICE_RX_DESC_UNUSED(ring);
> +	u32 rx_buf_len;
>  	int err;
>=20
>  	if (ring->vsi->type =3D=3D ICE_VSI_PF || ring->vsi->type =3D=3D ICE_VSI=
_SF) {
> @@ -527,7 +528,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  			err =3D __xdp_rxq_info_reg(&ring->xdp_rxq, ring-
> >netdev,
>  						 ring->q_index,
>  						 ring->q_vector-
> >napi.napi_id,
> -						 ring->rx_buf_len);
> +						 ICE_RXBUF_3072);
>  			if (err)
>  				return err;
>  		}
> @@ -536,12 +537,12 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring=
)
>  		if (ring->xsk_pool) {
>  			xdp_rxq_info_unreg(&ring->xdp_rxq);
>=20
> -			ring->rx_buf_len =3D
> +			rx_buf_len =3D
>  				xsk_pool_get_rx_frame_size(ring->xsk_pool);
>  			err =3D __xdp_rxq_info_reg(&ring->xdp_rxq, ring-
> >netdev,
>  						 ring->q_index,
>  						 ring->q_vector-
> >napi.napi_id,
> -						 ring->rx_buf_len);
> +						 rx_buf_len);
>  			if (err)
>  				return err;
>  			err =3D xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> @@ -559,7 +560,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
>  				err =3D __xdp_rxq_info_reg(&ring->xdp_rxq,
> ring->netdev,
>  							 ring->q_index,
>  							 ring->q_vector-
> >napi.napi_id,
> -							 ring->rx_buf_len);
> +							 ICE_RXBUF_3072);
>  				if (err)
>  					return err;
>  			}
> @@ -631,17 +632,14 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16
> q_idx)  static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ic=
e_rx_ring
> *ring)  {
>  	if (!vsi->netdev) {
> -		ring->max_frame =3D ICE_MAX_FRAME_LEGACY_RX;
> -		ring->rx_buf_len =3D ICE_RXBUF_1664;
> +		vsi->max_frame =3D ICE_MAX_FRAME_LEGACY_RX;
>  #if (PAGE_SIZE < 8192)
>  	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
>  		   (vsi->netdev->mtu <=3D ETH_DATA_LEN)) {
> -		ring->max_frame =3D ICE_RXBUF_1536 - NET_IP_ALIGN;
> -		ring->rx_buf_len =3D ICE_RXBUF_1536 - NET_IP_ALIGN;
> +		vsi->max_frame =3D ICE_RXBUF_1536 - NET_IP_ALIGN;
>  #endif
>  	} else {
> -		ring->max_frame =3D ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
> -		ring->rx_buf_len =3D ICE_RXBUF_3072;
> +		vsi->max_frame =3D ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
>  	}
>  }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index fb1d14bd20d1..b640c131b6bd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -412,13 +412,13 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
>  		 */
>  		dma_sync_single_range_for_cpu(dev, rx_buf->dma,
>  					      rx_buf->page_offset,
> -					      rx_ring->rx_buf_len,
> +					      ICE_RXBUF_3072,
>  					      DMA_FROM_DEVICE);
>=20
>  		/* free resources associated with mapping */
> -		dma_unmap_page_attrs(dev, rx_buf->dma,
> ice_rx_pg_size(rx_ring),
> +		dma_unmap_page_attrs(dev, rx_buf->dma, PAGE_SIZE,
>  				     DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
> -		__page_frag_cache_drain(rx_buf->page, rx_buf-
> >pagecnt_bias);
> +		__free_page(rx_buf->page);
>=20
>  		rx_buf->page =3D NULL;
>  		rx_buf->page_offset =3D 0;
> @@ -672,10 +672,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring,
> struct ice_rx_buf *bi)
>  	struct page *page =3D bi->page;
>  	dma_addr_t dma;
>=20
> -	/* since we are recycling buffers we should seldom need to alloc */
> -	if (likely(page))
> -		return true;
> -
>  	/* alloc new page for storage */
>  	page =3D dev_alloc_pages(ice_rx_pg_order(rx_ring));
>  	if (unlikely(!page)) {
> @@ -684,7 +680,7 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring,
> struct ice_rx_buf *bi)
>  	}
>=20
>  	/* map page for use */
> -	dma =3D dma_map_page_attrs(rx_ring->dev, page, 0,
> ice_rx_pg_size(rx_ring),
> +	dma =3D dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
>  				 DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
>=20
>  	/* if mapping failed free memory back to system since @@ -700,7
> +696,6 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct
> ice_rx_buf *bi)
>  	bi->page =3D page;
>  	bi->page_offset =3D rx_ring->rx_offset;
>  	page_ref_add(page, USHRT_MAX - 1);
> -	bi->pagecnt_bias =3D USHRT_MAX;
>=20
>  	return true;
>  }
> @@ -771,7 +766,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring,
> unsigned int cleaned_count)
>  		/* sync the buffer for use by the device */
>  		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
>  						 bi->page_offset,
> -						 rx_ring->rx_buf_len,
> +						 ICE_RXBUF_3072,
>  						 DMA_FROM_DEVICE);
>=20
>  		/* Refresh the desc even if buffer_addrs didn't change @@ -
> 800,69 +795,6 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring,
> unsigned int cleaned_count)
>  	return !!cleaned_count;
>  }
>=20
> -/**
> - * ice_rx_buf_adjust_pg_offset - Prepare Rx buffer for reuse
> - * @rx_buf: Rx buffer to adjust
> - * @size: Size of adjustment
> - *
> - * Update the offset within page so that Rx buf will be ready to be reus=
ed.
> - * For systems with PAGE_SIZE < 8192 this function will flip the page of=
fset
> - * so the second half of page assigned to Rx buffer will be used, otherw=
ise
> - * the offset is moved by "size" bytes
> - */
> -static void
> -ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size=
) -{ -
> #if (PAGE_SIZE < 8192)
> -	/* flip page offset to other buffer */
> -	rx_buf->page_offset ^=3D size;
> -#else
> -	/* move offset up to the next cache line */
> -	rx_buf->page_offset +=3D size;
> -#endif
> -}
> -
> -/**
> - * ice_can_reuse_rx_page - Determine if page can be reused for another R=
x
> - * @rx_buf: buffer containing the page
> - *
> - * If page is reusable, we have a green light for calling ice_reuse_rx_p=
age,
> - * which will assign the current buffer to the buffer that next_to_alloc=
 is
> - * pointing to; otherwise, the DMA mapping needs to be destroyed and
> - * page freed
> - */
> -static bool
> -ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf) -{
> -	unsigned int pagecnt_bias =3D rx_buf->pagecnt_bias;
> -	struct page *page =3D rx_buf->page;
> -
> -	/* avoid re-using remote and pfmemalloc pages */
> -	if (!dev_page_is_reusable(page))
> -		return false;
> -
> -	/* if we are only owner of page we can reuse it */
> -	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
> -		return false;
> -#if (PAGE_SIZE >=3D 8192)
> -#define ICE_LAST_OFFSET \
> -	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
> -	if (rx_buf->page_offset > ICE_LAST_OFFSET)
> -		return false;
> -#endif /* PAGE_SIZE >=3D 8192) */
> -
> -	/* If we have drained the page fragment pool we need to update
> -	 * the pagecnt_bias and page count so that we fully restock the
> -	 * number of references the driver holds.
> -	 */
> -	if (unlikely(pagecnt_bias =3D=3D 1)) {
> -		page_ref_add(page, USHRT_MAX - 1);
> -		rx_buf->pagecnt_bias =3D USHRT_MAX;
> -	}
> -
> -	return true;
> -}
> -
>  /**
>   * ice_add_xdp_frag - Add contents of Rx buffer to xdp buf as a frag
>   * @rx_ring: Rx descriptor ring to transact packets on @@ -901,35 +833,6
> @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
>  	return 0;
>  }
>=20
> -/**
> - * ice_reuse_rx_page - page flip buffer and store it back on the ring
> - * @rx_ring: Rx descriptor ring to store buffers on
> - * @old_buf: donor buffer to have page reused
> - *
> - * Synchronizes page for reuse by the adapter
> - */
> -static void
> -ice_reuse_rx_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *old_bu=
f) -{
> -	u16 nta =3D rx_ring->next_to_alloc;
> -	struct ice_rx_buf *new_buf;
> -
> -	new_buf =3D &rx_ring->rx_buf[nta];
> -
> -	/* update, and store next to alloc */
> -	nta++;
> -	rx_ring->next_to_alloc =3D (nta < rx_ring->count) ? nta : 0;
> -
> -	/* Transfer page from old buffer to new buffer.
> -	 * Move each member individually to avoid possible store
> -	 * forwarding stalls and unnecessary copy of skb.
> -	 */
> -	new_buf->dma =3D old_buf->dma;
> -	new_buf->page =3D old_buf->page;
> -	new_buf->page_offset =3D old_buf->page_offset;
> -	new_buf->pagecnt_bias =3D old_buf->pagecnt_bias;
> -}
> -
>  /**
>   * ice_get_rx_buf - Fetch Rx buffer and synchronize data for use
>   * @rx_ring: Rx descriptor ring to transact packets on @@ -955,9 +858,6 =
@@
> ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
>  				      rx_buf->page_offset, size,
>  				      DMA_FROM_DEVICE);
>=20
> -	/* We have pulled a buffer for use, so decrement pagecnt_bias */
> -	rx_buf->pagecnt_bias--;
> -
>  	return rx_buf;
>  }
>=20
> @@ -1053,16 +953,10 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct
> ice_rx_buf *rx_buf)
>  	if (!rx_buf)
>  		return;
>=20
> -	if (ice_can_reuse_rx_page(rx_buf)) {
> -		/* hand second half of page back to the ring */
> -		ice_reuse_rx_page(rx_ring, rx_buf);
> -	} else {
> -		/* we are not reusing the buffer so unmap it */
> -		dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
> -				     ice_rx_pg_size(rx_ring),
> DMA_FROM_DEVICE,
> -				     ICE_RX_DMA_ATTR);
> -		__page_frag_cache_drain(rx_buf->page, rx_buf-
> >pagecnt_bias);
> -	}
> +	/* we are not reusing the buffer so unmap it */
> +	dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
> +			     PAGE_SIZE, DMA_FROM_DEVICE,
> +			     ICE_RX_DMA_ATTR);
>=20
>  	/* clear contents of buffer_info */
>  	rx_buf->page =3D NULL;
> @@ -1085,27 +979,15 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct
> ice_rx_buf *rx_buf)  static void ice_put_rx_mbuf(struct ice_rx_ring *rx_r=
ing,
> struct xdp_buff *xdp,
>  			    u32 ntc, u32 verdict)
>  {
> -	u32 nr_frags =3D xdp_get_shared_info_from_buff(xdp)->nr_frags;
>  	u32 idx =3D rx_ring->first_desc;
>  	u32 cnt =3D rx_ring->count;
>  	struct ice_rx_buf *buf;
> -	int i =3D 0;
>=20
>  	while (idx !=3D ntc) {
>  		buf =3D &rx_ring->rx_buf[idx];
>  		if (++idx =3D=3D cnt)
>  			idx =3D 0;
>=20
> -		/* An XDP program could release fragments from the end of
> the
> -		 * buffer. For these, we need to keep the pagecnt_bias as-is.
> -		 * To do this, only adjust pagecnt_bias for fragments up to
> -		 * the total remaining after the XDP program has run.
> -		 */
> -		if (verdict !=3D ICE_XDP_CONSUMED)
> -			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -		else if (i++ <=3D nr_frags)
> -			buf->pagecnt_bias++;
> -
>  		ice_put_rx_buf(rx_ring, buf);
>  	}
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h
> b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 2fd8e78178a2..7c696f7c598b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -202,7 +202,6 @@ struct ice_rx_buf {
>  	struct page *page;
>  	unsigned int page_offset;
>  	unsigned int pgcnt;
> -	unsigned int pagecnt_bias;
>  };
>=20
>  struct ice_q_stats {
> @@ -358,7 +357,6 @@ struct ice_rx_ring {
>  	struct ice_tx_ring *xdp_ring;
>  	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
>  	struct xsk_buff_pool *xsk_pool;
> -	u16 max_frame;
>  	u16 rx_buf_len;
>  	dma_addr_t dma;			/* physical address of ring */
>  	u8 dcb_tc;			/* Traffic class of ring */
> @@ -479,15 +477,9 @@ struct ice_coalesce_stored {
>=20
>  static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)  { =
-#if
> (PAGE_SIZE < 8192)
> -	if (ring->rx_buf_len > (PAGE_SIZE / 2))
> -		return 1;
> -#endif
>  	return 0;
>  }
>=20
> -#define ice_rx_pg_size(_ring) (PAGE_SIZE << ice_rx_pg_order(_ring))
> -
>  union ice_32b_rx_flex_desc;
>=20
>  void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);=
 diff -
> -git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index 257967273079..0090099917ea 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -2086,18 +2086,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u=
8
> *msg)
>  			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
>  			     qpi->rxq.databuffer_size < 1024))
>  				goto error_param;
> -			ring->rx_buf_len =3D qpi->rxq.databuffer_size;
>  			if (qpi->rxq.max_pkt_size > max_frame_size ||
>  			    qpi->rxq.max_pkt_size < 64)
>  				goto error_param;
>=20
> -			ring->max_frame =3D qpi->rxq.max_pkt_size;
> +			vsi->max_frame =3D qpi->rxq.max_pkt_size;
>  			/* add space for the port VLAN since the VF driver is
>  			 * not expected to account for it in the MTU
>  			 * calculation
>  			 */
>  			if (ice_vf_is_port_vlan_ena(vf))
> -				ring->max_frame +=3D VLAN_HLEN;
> +				vsi->max_frame +=3D VLAN_HLEN;
>=20
>  			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
>  				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to
> configure RX queue %d\n",
> --
> 2.45.2

Tested-by: Priya Singh <priyax.singh@intel.com>

