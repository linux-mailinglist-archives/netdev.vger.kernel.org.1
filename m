Return-Path: <netdev+bounces-280892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCf7Odmx6mkWCgAAu9opvQ
	(envelope-from <netdev+bounces-280892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDF458786
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F9B53001FD6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E2378815;
	Thu, 23 Apr 2026 23:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zoh9NtyH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEE1C5F13;
	Thu, 23 Apr 2026 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988629; cv=fail; b=LkHFiu4uD/ZWoIAjbOgivz0a6fuouvDF17hsv5ljAEY4Am+G0dbsSUEfmvy7k8yhllYjwn9Kpq03AQqPEzmtoehZyBrS9Q2XjUOrHehOMWZWutWfvouEnUyOSp5A+uEMHQah4MHZMqGNGJ+Dm7zpcQ1TsG4V9DS+rExFa9jPQc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988629; c=relaxed/simple;
	bh=xdg7tbOOnsTlLeGlAEftZvASN20dzT/Gxrj0gnb1ir8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWyTc+63PNB3Eahgq51mBt4aROYGGEVELup0sSpzZuG1O6SrgJdQ7Wsi1zat8YYSqpH8rX6h8a71lBwMRL1Hi96u1Wbme8FSQEdkzcBXeylD4YrknEE4/S0R9SwyPq/rgKqEweTSFR+0Jzh1/b3IWysF5lPh7zg//U8xrRJukpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zoh9NtyH; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776988628; x=1808524628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdg7tbOOnsTlLeGlAEftZvASN20dzT/Gxrj0gnb1ir8=;
  b=Zoh9NtyHkAcf1/VT33PbpycfGBrizVkgj/I7LvSFnm70IqE1Bb4le0A6
   kAtOCcexN1MqZf1WdctzUZm93HWejn+EnYTde9n1BYlX+oSkQoZ7bd2Hh
   1NOVp9/rASfDjnE+xQuT6zslZho9p+nBIIht4Kut0IdIucy+ClJf/FixT
   IQiYuxeBgsfJAKvVKUcUl4ZzvqKQ45jTjbyik6fl4Zu0ZtnnIB90Nh5iF
   I0UMl2FY80R89/RLEDBsvZSN4P4cAfbGY9sQLVdbT/0cfMkouoSZYjrtG
   cZULn9ZBo9J0LoriZV5I1GdGUEnDg+T9EnR5ROH/ODR0WlmU9CrHdWtO4
   Q==;
X-CSE-ConnectionGUID: lj4m+EGZQ9S/gc8d8ZXj0w==
X-CSE-MsgGUID: 2L/DZTOVTF+VcRAlTMLLsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78084080"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="78084080"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 16:57:07 -0700
X-CSE-ConnectionGUID: wOVw9XySRJCunbpmhVq7Yg==
X-CSE-MsgGUID: bJ2sVLWIQKqtKYv1Q+ceoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="226264197"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 16:57:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 16:57:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 23 Apr 2026 16:57:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.14) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 23 Apr 2026 16:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9BJUNO4kWw5kAWVuwLZGumZItZu0enpV7klQecYLoEVE7/i1q32+xfNswZRuyXmx3qBXOAtal4HCrn40MHHP7ErJNwNN54Lh15mZYkzP/TTcwqc6khRxhp9btJMAuaR5/X1/rOrDzP4nGthJ8PKFjuQwLS/CszD7HJ495atIZTNJMRQldARDo12dynM4AZFX3+Yfeond4DB4u6uINGECiPHzBmr3N5iAyX9cFqw6rPXWGs0zs6d+ndWo1WMIMKc2/eEc0IRDUe8epXCDzSanS7M6S9geJOYYWeORAH+6oEIMRo2q/8VAYLK5vYGq+xQirD5kdnV4SQR9SuKAXYxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+okCoVX975svVxKp0ytHNb6U2BjInLQcpexD7tsm32E=;
 b=XHvaFhPVEKji/sUWhh7Epalpeb0KdB4RlxvQlTqmGok1Xuk2scBfq7ZcXGauM+p/lat323Alu27cPcwymgstu8p/uVMST3pIs8cvrdBptBd0EP+QIDTyKmBAY/TPH1oyQiI1zpyFWkyxegUvDnhtaD2xdA3MRjC2+IPSdzFO0GN/w+xnqSdN8faoKvRnf2hAVYXQ/2GeqF3DD97APIC13gvHqiI5KspTQOld3lJw9vugu1utopoWBlCkp5JwK4JN3HLb2Cw+VC7pIPCWnrNjIrh2+te63EAK0SIvFFkkgXcUW5j3t0rw1rrFEGt7cT4v497xzdu7D8O0NB3wQaGhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Thu, 23 Apr
 2026 23:57:03 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9846.011; Thu, 23 Apr 2026
 23:57:03 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, Eric Dumazet <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Ertman, David M" <david.m.ertman@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion in
 ice_cfg_tx_topo via ice_init_dev_hw
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion in
 ice_cfg_tx_topo via ice_init_dev_hw
Thread-Index: AQHcy3nXcql7iZkcaE+pcQ3qZQ19orXtYa3A
Date: Thu, 23 Apr 2026 23:57:02 +0000
Message-ID: <LV1PR11MB87901A00E2BF508A97772277902A2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260413191420.3524013-1-poros@redhat.com>
In-Reply-To: <20260413191420.3524013-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|LV3PR11MB8603:EE_
x-ms-office365-filtering-correlation-id: b5245865-7ed0-4d1c-2796-08dea1940431
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Yq/Ngrz9pVGnq9ZikbEtltRJT+wA5svqXhQqxLSHdDNTXP9HoFV0omtDVG4+wcl02Gb9kL0ZZhZLx0mzOo9F0RoYUpFRn6Va6haILc1y+M0Ff8s+Z3trywxdp4DArvwoorgT6cCdfogjDv1EyBmVfNl1+dOHUMc9o3S/Rxy5u73bedRD4KURwqnUnzwZ/FYKEn8AULkdFC4/u8u41mUVHtQPY7tdoa3F789n01rcnw8TVOX9lriaxNN4oyndq1Wab3tBu5/yBEHizXl2WCT4dwzOGdCQ6e7qbNTvQhv3zNMzqiuwGDf9eyRAXM6jS/jycEgLKS6Nc0Kp2acE9fejUvOWsobct7VBlQFpShVhNh5O6q6GxYmynFQb5rL3Ba2mRiJOyWWzT0sVSEiAUr/n671dY5x00iwUyhUez3IVLqoXk3RLYNxCNcgyy1A6/f/2GMj1fPsj2tZjNhNAgvjRHzF68ChjxQwaWCGI9x7K0Je01cvsM7MbfXOqux74Rt9QqlbxwXlned3v9OEAqFcvf5HKRSuBiPR7HBt+ohmeX8MEOpO5DdPHLx0awD6AhylcLTjj0WMFZ4c+SdSrBnwoFBtiJ4nUl0DnmXICzCuZMFoVxXDjs2w4x2m6vbKpdakDpeZJoZO9qwMbIc2269PK8jXFFRtIBiSVSumQ/2FYxsDgYVkTyx4g8Mogm9+e1ULeyyPrLdPyF9XwUEg0UwceewmsrXxgchd905vclH7YbLUZo9AJTtjeRO1zSYxaX7c/Ah9RimwNAkSvQSWLyoJje7dawFcyQr/Fwm15hI+XQlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?anKRWARrDtLOkRlcuNnHQPfvZLxkMKvnZPdPAKPfnNP2hyb6peTxrNdmtlwC?=
 =?us-ascii?Q?q0ZTvMZa1rZaJGVjuEMRMO8BgZO4TuctXy9fMGxE8OVd/LyIWoJYxekfs72/?=
 =?us-ascii?Q?HJ62Rj7qpB8DTDMJoxdjslgvuoeBRjFQPnWamMx5WkCEsXXyNna33A5y5FLX?=
 =?us-ascii?Q?+3YiaLY3LczCDu3cFv+bGRuzi+w7g35o6+4tyypkSmV1oGUvKJoxyqXfSpa6?=
 =?us-ascii?Q?vrZj1a4n+xTka3hiawMOyoq2qiXENFQJqNtMyh9akho7mjhPlxK3ttBayM+w?=
 =?us-ascii?Q?KmUmyvAXekCwv12vB6WKfubpf8yQu0gCLXFgAMjO2E0rrlPrpYiYzhYunwCp?=
 =?us-ascii?Q?Ryu8T8IMl2HlzFEAUyratDHJyX8sBHwl4F/vTgUyO9ivYdvMxEQdIyElfjIu?=
 =?us-ascii?Q?M82Su9Mo5yHXWvJkK1zUkjNHECLQ+uUend8Uo2WJg0V2Snj2vk8uXulNwdLg?=
 =?us-ascii?Q?GWXXyrArvQjrzGKgyyAop/3x11EScOhjZjOcowxrPSQ6w9DdByQXRAs7YGTO?=
 =?us-ascii?Q?kYJl1Yk253CgWsFZGp86s3NvuXEd32h+NcCl4Vm4v3IdynrcV8OEOoOI5Zb2?=
 =?us-ascii?Q?frtrfjQlvdfo//8kZL28BSZRH2vPkW/BoLNZvzcwjFPdLGib9m/qiRuVVCqc?=
 =?us-ascii?Q?1wNVGRwVysyYKpZt9AR5R5POlJOhlZuLpTm9ofOz2+IwIQFLsSoFGZudN6WT?=
 =?us-ascii?Q?HUoCfm1IaZy7fSnKyyo3KZ5FxuBPhy31WELwi75YV03ptOQuohyRiVr7EVSf?=
 =?us-ascii?Q?XKzR2nTws5dSuAAL9l/pWaPz9Qw/ojXkgSyJrStDpMzgIvzwCsiD34SOFtrL?=
 =?us-ascii?Q?XcCfShO/UzzkHocE84AdvZVlx3bwwVAS1WHmX/fxmvWAwyF1YD5GVeeWPhKm?=
 =?us-ascii?Q?EWk3DNdfYTXqeAT5FReMJ+uFYnX1iVOgmRsQNh97SXh/FHZlzPCsXfgDqUAL?=
 =?us-ascii?Q?njB4dWbeDj+gs3GseiKJds0e1AEzsofEDOdJcgacGjlMTVNNkh34r4lHt9gk?=
 =?us-ascii?Q?cvMQWCyUS5EKf8NZ2nQQeO9IdhqpE54xXj1KvEWYdvo1jgB1Y3hBStYVNOvc?=
 =?us-ascii?Q?/fQDvSSbBU5KGLKlbZujcHbYNLAC1b6LbVALv2lmE6b/EMBb27XWZIxtZ+l/?=
 =?us-ascii?Q?fQbX8Y7jeKqDlaOPkyiR15QdEud1pKo1K7VvI5aggDJ4PwQPblWmOOhwA2X6?=
 =?us-ascii?Q?dUGbRcQ1AhU3f/a5SPOI9vqnZQErJXlDavy17kbqCF/8Vvmy6cY6L9vFsA6z?=
 =?us-ascii?Q?Eo1TuzRk/3cJAdykIXWi0C0Z1IF2QYYmk6nT3xGuucooQqfQ7mKw0thZENdn?=
 =?us-ascii?Q?D8kTX2XeJEkErZgjf+y4rH0ep+PyHBfZgeqcYET3xjCtD19KIB537UlmK27/?=
 =?us-ascii?Q?DHD9hjFmRHHLEk+YI4IEDGXs9cdnRQk8B/gEOhjIJgRZXTxLO4I0yPYHVdmo?=
 =?us-ascii?Q?JOP8XD/b0kwZ0jZxipMCO6M+VChg0nNM8EqD6vgeyOe5sQaPTE9TlKrtSW+W?=
 =?us-ascii?Q?1Zl41YufvOKwk/jrq13Hpb/kcPKTgmoKLcVmusoJvASCHwa6s2EpzbhuRVQ1?=
 =?us-ascii?Q?ueFENr1BP7AnUmoQG51J7VsP9NOZxsr/TrJpif2VITALjBJIZYUfruGSEgPJ?=
 =?us-ascii?Q?PwNZUPhPBfta+W6cbmX7PbirQOLvPadadH8kmpIOIGps5v3uMC8ViGji7nhF?=
 =?us-ascii?Q?j0c9YE/LzxKrMukoZpwxLcKMHU5ceOkLoPPYJdlukm9TyZmPgC9Ftbq8AOlW?=
 =?us-ascii?Q?FZlPam/8Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ewx4b6mfG4kL5fL4kM11bLtxau/ZBXTnz0Y6UIuKOrMZ1oXXWOS/ACuupUptw9pnDTnzOjPgBPBqm4kQwQz4utE1vHYiWTJG8MHHTGqr8/PDiWGndF7XaN/i+0V5m1/qe5M8w9UZZVpwm2kyDaMUoW7WQ51mFbUNF4SkOZIACIYDi8e41wpdKcMcIfKel1UXdSRXqK13BdEdhQ6TVGyuhobJDhztJbzQ7T4z4RHzjIosnKAdH3oqLjPDlbsZzvVFFXrWyj2IRcW1+J4z0KBv+QcU6Tb0rA3CzAgK+XNo8fV8EOZhIbr5MdMc+7zEsphRGzGADEM8fhcjG8a8/4DQIA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5245865-7ed0-4d1c-2796-08dea1940431
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 23:57:03.0501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0+vRlkICUQtzh2pj/hlCeeXHUAGxjsAFv7p2IJ2PM3NwaGdhlTtkE9WJQNa48vCuF0g+ciQrey7rSUUWkp11bnKFnSIkyrTU16pqg1xKKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 8BDDF458786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280892-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,gmail.com,blackwall.org,google.com,vger.kernel.org,lunn.ch,kernel.org,redhat.com,davemloft.net,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
etr Oros
> Sent: Monday, April 13, 2026 12:14 PM
> To: netdev@vger.kernel.org
> Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>; Greenwalt, P=
aul <paul.greenwalt@intel.com>; Daniel Zahka <daniel.zahka@gmail.com>; Kits=
zel, Przemyslaw <przemyslaw.kitszel@intel.com>; Nikolay Aleksandrov <razor@=
blackwall.org>; Eric Dumazet <edumazet@google.com>; linux-
> kernel@vger.kernel.org; Loktionov, Aleksandr <aleksandr.loktionov@intel.c=
om>; Andrew Lunn <andrew+netdev@lunn.ch>; Nguyen, Anthony L <anthony.l.nguy=
en@intel.com>; Ertman, David M <david.m.ertman@intel.com>; Keller, Jacob E =
<jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo=20
> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; intel-w=
ired-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix infinite recursion in=
 ice_cfg_tx_topo via ice_init_dev_hw
>=20
> On certain E810 configurations where firmware supports Tx scheduler topol=
ogy switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo() may need to a=
pply a new 5-layer or 9-layer topology from the DDP package. If the AQ comm=
and to set the topology fails (e.g. due to invalid DDP data or firmware=20
> limitations), the global configuration lock must still be cleared via a C=
ORER reset.
>=20
> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx schedu=
ler config fails") correctly fixed this by refactoring
> ice_cfg_tx_topo() to always trigger CORER after acquiring the global lock=
 and re-initialize hardware via ice_init_hw() afterwards.
>=20
> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of d=
einit paths") later moved ice_init_dev_hw() into ice_init_hw(), breaking th=
e reinit path introduced by 86aae43f21cf. This creates an infinite recursiv=
e call chain:
>=20
>   ice_init_hw()
>     ice_init_dev_hw()
>       ice_cfg_tx_topo()         # topology change needed
>         ice_deinit_hw()
>         ice_init_hw()           # reinit after CORER
>           ice_init_dev_hw()     # recurse
>             ice_cfg_tx_topo()
>               ...               # stack overflow
>=20
> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling it =
explicitly from ice_probe() and ice_devlink_reinit_up(). The third caller, =
ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw() during its=
 reinit, it only needs the core HW reinitialization. This breaks the recurs=
ion cleanly without=20
> adding flags or guards.
>=20
> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod are =
preserved, only the init-side placement of ice_init_dev_hw() is reverted.

> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit pat=
hs")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/devlink/devlink.c | 2 ++
>  drivers/net/ethernet/intel/ice/ice_common.c      | 2 --
>  drivers/net/ethernet/intel/ice/ice_main.c        | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

