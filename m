Return-Path: <netdev+bounces-296926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BtAAEcK3J2ow1AIAu9opvQ
	(envelope-from <netdev+bounces-296926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02465CF12
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 08:50:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=KodwjyLp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296926-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296926-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82CC73009E0A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCE3D3499;
	Tue,  9 Jun 2026 06:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA093C455C;
	Tue,  9 Jun 2026 06:50:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987826; cv=fail; b=Up26LzpVuJOTrpcuRbnEw6kGnXh4gx/MxYK56Mbc8WDVA8ggosKe878J4VgobXfypM/wsKcHVR0ePdC5vE9OSj5pQhv2qM10JtwqdVIrYngrV/fBNpsMo3Qn8VfexydYaslDUdDd5Pib4ttzCjp/rVM3Kgxdp8gqDYsZlW1MVgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987826; c=relaxed/simple;
	bh=zbb7WPIdyMADOTAOluMsXwKqB06yXIegDUE3A1uVeRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNk5tua0pidnI8rpxQPV1nNF1bdn3azRJjUXveTVajp0t7I+AgJ2nA+2NfsOvRbrm1oFEfJjpPeJ4zn+dsc5bj+Gp3cTlNLxuKUd0xBp6Oz+reGTxM9Nonu5v3p45R8ThOHohVYWI3EovIXg+l9wIDFuUFQ60dv9Lj6XwAUbE6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KodwjyLp; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780987825; x=1812523825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zbb7WPIdyMADOTAOluMsXwKqB06yXIegDUE3A1uVeRk=;
  b=KodwjyLpsasD2f1GwsIfEjThyPE8rbFiKDFF48F8bfe9xHPbxM+oID8l
   km8lDrxN/WMqYrNzn3ouliscThMYxHGabulaMzC89ZrsiVjmGJa9fYY3T
   Kv8UQEUiTZjiCE4eKEHnYCBgxd7/cICZJTK7CQq6HhI6dqCKvFxovdeAK
   og+x6AkDN7raLJUb/cIlXBP4LsmGUeyGKGifGqnXvHH2oVUH0q7c2EG/p
   Cyrp60xJWrWxmixKqtkUH0eX8V03EqDV85BqpuE/xRbRsxzoEA85BkUfZ
   f4ZbxoQlCzxLorFRT7v3hrWBw9g87Ee8PG/pVRbqHIh21+ABG7e8GGXP/
   g==;
X-CSE-ConnectionGUID: HwsiSKnCTRiH7EBzVsxfhg==
X-CSE-MsgGUID: 0kBUOkdoRA+tryzRT03Qxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="104403555"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="104403555"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:50:25 -0700
X-CSE-ConnectionGUID: nLdTh4WNQrKfUVyFPpEE+g==
X-CSE-MsgGUID: nArJDJhlSWS/AVpd49x6bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244629412"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:50:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 23:50:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 23:50:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 23:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9LWOsUiGgHEYeYH6cq4RcSBzY6J1GpvkZp8sDFr7SRmH77lBxrCFjYvw72HtaoST96vp1bfDZ/Dzc9ZLtuG1SzdNhKon7PhK1UHELnLXIThkgoV7QV+YUX8O3DPEr+X07mtOU1n8KrrGohfyGZCkZMjrAnhvXtl7JrYzqqqA2DD4I6VQsUnFCmLI7RQNwTV9HUjmD/sYSoXkdFpgzz4QNsQeZA1VCY2+zmFi9jlJO/EJszhSPa5kYAyWZwqIvoqOLCMNZzwxFkv926M9xzdO3/xKnMs+P1mwh0bBPFT92lPYJzA5xP91bZ2P/C9UKphDMHXsfceSHOCdNJcCVz4Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv+LiUXmqtShpvgWIw+obOPt62bZ/ucjszIVpMqKIVI=;
 b=cVJAdfZXq9y887OwmkCGeRCYFgJfWbZg/iEx6qApyIQnI1dElbyld0D7rDM2PNhPAvjkiwqskAOCiOlgZ2YyJqdyBP7hbqxcwouYPOKRnzdhiR62UGXdCn4Xe8/tf8xYHzcSjyhe/E2ZMsxpYnVpVcU1xEx6HS3cToCy+U4yRBNVZsaOKg8hRC+0h4ic9bL2WBxKF3hgzRjms1RNpRb1QhfQlN2yN24gpCHIabHD2QxoBaqiND0AXAkoDC9IRNQUUGLB9nEL+hs4t37rmwZca83wSY8DbcwPfmUt/s4Kio1eHqujeVN6dqBPr0gNdEzVTNZgdtjw8zJXrqWWmkYmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by SJ5PPF4DC104A0B.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::827) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 06:50:18 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 06:50:18 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Thread-Topic: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
Thread-Index: AQHc9qxzOSWGh7NPvUubHfjHiXtPNrY04KmAgADnqVA=
Date: Tue, 9 Jun 2026 06:50:18 +0000
Message-ID: <IA1PR11MB6219E01DFFE6B3BF4E2E551A921D2@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
 <CH0PR11MB5394EFF74E33AAD8C9B014389B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB5394EFF74E33AAD8C9B014389B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|SJ5PPF4DC104A0B:EE_
x-ms-office365-filtering-correlation-id: 721c5793-f793-4e28-04d4-08dec5f35e7e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: f28wjPifW73+voaMSE5KdiPyzfyIe2SarZwptwCiclFS0SA6d9TMiYh1H82RzJxBcXmCtrflZkNTJZvfsYgZjkHA5uHTDzgp1Bv2IBEJ4oI0lf9wdszFPOhmUjeQCMIVTA6slsH4DchNPjskjKZaExrofCjoyKrTdWUP/n4JCZ6gO/F9LcBqO+7D9nEBMy62bd5T3s67vB4vvcgjkbjH2R9uYDRGopYcBjG7cTzrH1+XZUpwQArD1vcsbI+FABilsfZaRxI7dKLEdJACLhLAbhy7BNsM8gs1OjNFaZ0xpOi/7LrDnfjc0Ae5NE+Nk2uUTZUMUDiOrIVWmo1Z5B29FQY0AeFi4ysICGPtMMHFLF/JcNq7aVbJ4GLh09IzKnk4S9t0WsUsP+UY5/S7DsnYSg7cz9M96srbNHkqykuQ6rNQghB/YFwPln2Yr6tsQkYHC2vNNzQERPECapTSSDKm7z2Cjvdu0K+gcVuyE9hB6M9Fu1joRUt3Ceg5sZwcC/tjfjZvC17+wv+3/1BtxNwaXMmOZGwFkv13MmaDRNfUiMgJuHWPIPrRaMxDM27Zu/hqVRy0SBdEOmJVbVRWWYf+ZgY3ZW9gRfdk+Kn7r52GNAyO2Zd2uu0EcyB0YAeFgs/V0r0QPIH+/uc74OF7yUEsbc72yZYVuvhYO7soE7TSjzpi13aAF51NUnQWSKx31CctGV6mIXwOr0zzTFCbGy9HblccK+TXi6ezCOotygkRjgz1v4/TkwEu586rAfRsTPJi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nP7f6Q68uHqXMw4xNjU0B8LP6sgBmTXWZ0QAC2axGPs8ToJgwNEAln3J+3cq?=
 =?us-ascii?Q?bPVbT7tzhSG40FXAbCUcWUN1hFMZE5o3yJRelFJwr/WiaBAiT+YckZ1whWQU?=
 =?us-ascii?Q?8vIkBKW/fTtErXw0l7+s68X1m9LzgaD3mmY7BYLs7nhFgIsBgxbrPHNACKQe?=
 =?us-ascii?Q?adjQlcUNhVRgY0pWVyA0mMg4GHY8jabhI/Z7qmDwQAin3IjrPKcN17sUVfyW?=
 =?us-ascii?Q?dsbd3v33fpSMrh59NlykH+HEDe4wKOTNh49APN3WpRMdE6LTeE+cY5/XRo4M?=
 =?us-ascii?Q?nrdMn9acB9zE2DS7eQSyjuMpIjhI6HUu6TMOBHA/Iaue5XmC/xdp5ZVGp6lT?=
 =?us-ascii?Q?NmLO+S3W6/f/3SkkZlir1zhbU6GFKgYwDHnZSUe48eHivm6cl2q8Eu45RtgH?=
 =?us-ascii?Q?kPdi9H5toVBT961qfrlXEkEpVNCo0ii6J02ZhtlCMl22KP47Rue6kFUZK/Aj?=
 =?us-ascii?Q?CLcxWY7ZVC87ZThWrk8I9pZcWQtkLxP3W6NQRbw5WDl7r3NIet0PfwvA9GET?=
 =?us-ascii?Q?P8NEfCE9Rvhi9o0G4L/4EedAe943u7yaI+g2jcluVZM9WMmgoiG9aGTp9wFG?=
 =?us-ascii?Q?+Oa36MQT5NGbZzf4cM6xOffVrJ/+gmc0WZpyor3PkwPy+/x3x/YBJS5e7aTT?=
 =?us-ascii?Q?N6z+hl4+pw9C3opGesAKKHigIBia1rV2SrgCB8qD0bDGu5LNEuCVsrp8BLZd?=
 =?us-ascii?Q?K0/aqymq23mPxIf9PkyBGFbhIRS5wckH/XV+0SGe7wHEaZmrThb+4hSq/H7l?=
 =?us-ascii?Q?Uws0SPrRZz51YeKXJVeVqhf+y9FK1d0ave0EHYMPsyGzthc7kIskBX9mmQ9V?=
 =?us-ascii?Q?96PCGti5uKd+DMCK8CxWDS2j13KKESNZi3+vzRIoAtx99A7rHovYTtUj36pD?=
 =?us-ascii?Q?CkJm4473oktIbLgg7fnefhfALRYrjsER7gAK7brZ0mnqU/LyAZoHFb1nRVjs?=
 =?us-ascii?Q?AbGQFP9u9Ev4jCoyouLhQPvs3FC7mrCEOO0nGS930jKcmQSnqNT2QLrsEkke?=
 =?us-ascii?Q?4WLR3pX3ywG2WP3L2XIs+IB3v/Zo2GdDXsG0+y3NsKfrw4ydooAD0j16cysY?=
 =?us-ascii?Q?RsAafq+E35uScDnIE+M0nbiINGK+2fWVWO0faHV1q3dqWRCqP+4+RNV+3CmE?=
 =?us-ascii?Q?STyQKWdGR8AfTgPJB5ltV1+n0eGMnHyL9p9Fc3XowOo+llBfLGYYT7fZLera?=
 =?us-ascii?Q?cIhpAmEdhGFMWXArQMUKvD6KmFITZpXlsVO7vZpPmW+bPwG2v9+A0yNUyC7/?=
 =?us-ascii?Q?yxFzx2BFNsCIfrrOtmqaO58/XYHjZLSjxzjG9TN7wJJmVNTRAC/yoKcP6gxc?=
 =?us-ascii?Q?jqgIfqciGDREwrUuyLFn7ei1evnoxuCCE4o8dPpuLcCXWpkoTSaKFIRHetwi?=
 =?us-ascii?Q?Yk2cAKOmOUAyrjQhwTETvb/QkxfO+d4hipbIbx4FxLQ8uv0c7TPvasB94POm?=
 =?us-ascii?Q?9ZCRx+yGrLf56IbdRh41W/FbFygl+uWr3O8UCv5UTyjalnJVQXo0tuq0JIvw?=
 =?us-ascii?Q?A9gFQ28tFIaJR0YHecWFN1MZWAuNkqur5K6h4EBEGvwKxLLT6Yk4nXmua9Y8?=
 =?us-ascii?Q?78gEaw6MfFlUVdw5ezB7uFnapAspETf9CqLDsLZapazjC3k4lhRo+zxS4WIG?=
 =?us-ascii?Q?RLBFaSVJ/xsFRiSmvMKCBLyfgHBGHfpN5w5LUmE/T00U4d0YPYGwCValKsyQ?=
 =?us-ascii?Q?2gNUCui3gVX8s8ei9npunpD+xokeDJ2zK370hzrq4YzHbgxZNY6I0Gxa1fYY?=
 =?us-ascii?Q?AEd1QuFK2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZJNHodYgFDd8+pwfFNj+Rv1XnW02uzfUNqYPJBONbunQ6GeUf403giJ/hzjcpa56V6Cw4jv0gClKqII7poBnHzyYjxWZR4OWHtz11QtEeLA7YwuDAbu0B5u+C9e0kXFVRQpSNq4oQ+J/clYnjc/ZJcAj53Cc8Rx+C4LSlrtMWNXWTEV8sHwy7kJWB7pJ5qywKayBYYtuQ8vJATe+g2HlDnIlV4Slw6Q5ouqwa9WkAQAHdXSZg1DMOYVKxnRX4YycuIsGFZw7glcaIOkMmjC4Kc6XURefCiL2S/ibzO8ZM9dzg62Crfkx6+mqEb1d8PPayMJkA4Ud9O15JbJvTNiZbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721c5793-f793-4e28-04d4-08dec5f35e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 06:50:18.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foMYE2vNVyx+RRAYb/4xHDuUeNK0gEmMqPXzoJ2P6RT2sYg55ypx/wQJVOCU78leHrBZbWmS0dVVdojoH9nHCqZ7fNseU4gd7UITg4MRceU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4DC104A0B
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arkadiusz.kubalewski@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B02465CF12


> -----Original Message-----
> From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Sent: Monday, June 8, 2026 6:51 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; Oros,=
 Petr
> <poros@redhat.com>; richardcochran@gmail.com; andrew+netdev@lunn.ch;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; jiri@resnulli.us; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> kuba@kernel.org; davem@davemloft.net; edumazet@google.com
> Subject: RE: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
> dpll_pin_on_pin_unregister()
>=20
> >From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> >Sent: Sunday, June 7, 2026 8:31 PM
> >
> >Neither parent->dpll_refs nor pin->dpll_refs on its own is a correct
> >iteration target at unregister time:
> >
> >  - pin->dpll_refs includes DPLLs the child was registered against
> >    via a different parent or directly; blind unregister WARNs on
> >    the cookie miss in dpll_xa_ref_pin_del().
> >  - parent->dpll_refs reflects the parent's current attachments, not
> >    those at child-register time. Another driver may have (un)reg'd
> >    the parent against additional DPLLs in the meantime, so we miss
> >    registrations that exist and visit DPLLs that have none.
> >
> >Walk pin->dpll_refs and use dpll_pin_registration_find() to filter
> >to entries whose cookie is this parent. Symmetric with
> >dpll_pin_on_pin_register(), correct under any subsequent change to
> >parent->dpll_refs.
> >
> >Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> >Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> >---
> > drivers/dpll/dpll_core.c | 7 ++++++-
> > 1 file changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> >index 6dc7e93ece75..cea7e2be2cbc 100644
> >--- a/drivers/dpll/dpll_core.c
> >+++ b/drivers/dpll/dpll_core.c
> >@@ -1031,14 +1031,19 @@
> EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
> > void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pi=
n
> >*pin,
> > 				const struct dpll_pin_ops *ops, void *priv)
> > {
> >+	struct dpll_pin_registration *reg;
> > 	struct dpll_pin_ref *ref;
> > 	unsigned long i;
> >
> > 	mutex_lock(&dpll_lock);
> > 	dpll_pin_delete_ntf(pin);
>=20
> Hey Grzegorz,
>=20
> This line is redundant after 7/13?
>=20

Hi Arek,
Yes, in general.=20
The reason for which I put it as separate patches (applies to all new 'Fixe=
s' patches) is:
- to identify atomic changes and
- to make it easy to backport to other branches ('old' ones) if the call is=
 to backport it

Regards

Grzegorz

> > 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> >-	xa_for_each(&pin->dpll_refs, i, ref)
> >+	xa_for_each(&pin->dpll_refs, i, ref) {
> >+		reg =3D dpll_pin_registration_find(ref, ops, priv, parent);
> >+		if (!reg)
> >+			continue;
> > 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
> >+	}
> > 	mutex_unlock(&dpll_lock);
> > }
> > EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
> >--
> >2.39.3


