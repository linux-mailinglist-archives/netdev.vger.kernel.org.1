Return-Path: <netdev+bounces-122265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FE9608C1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6081C22471
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEB1A0718;
	Tue, 27 Aug 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zd5awQsA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D51A01BD
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758387; cv=fail; b=Qb/WziMIlAHu2nc0wq/B6Jss2RPuDtvB4IYBSW0TuiMC26HRvIIsMkw1FkJT/mgZQw482CplqNRrloGpTTtTNR51XNOIAKZ6LYZz8J7tJ05FjjDQ1uKSU/Oee/30gR/HevuN4iELX2hhPI3wA3/VRoZggcU5bbgoDocIjG1t3Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758387; c=relaxed/simple;
	bh=jT1Ej2sjFCxWZl01hgCcSKArKKES5Yt4iflO63YZXRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wmq9ZHiPl4X6QAhzH+fBCugpEAvcNGusURNybsjhmuml36qpxne1QSV5ypd6fqq1Lm+LViwXxVmdVxTeqJ6YWcKhGhEdvXoWWCrNKJiJD3xW3N1BhuSh4ndPxEQPDGrTyiyCWuvkZTycekRa/GUTpbPSnPmI7T7wVfhrdBS5vMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zd5awQsA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724758386; x=1756294386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jT1Ej2sjFCxWZl01hgCcSKArKKES5Yt4iflO63YZXRs=;
  b=Zd5awQsA/O/pP5goaz2JVsizE3fjNtdTxVpOZtieKaInjAXXdxQKuGI7
   iaVr02CDvC5XMo8Kry7IepQuFokjL3nRzyTC3bXNShme6+azl5PTyi2m/
   d6XlVcW0BsItVIH3w+FpzRqJw1vord/ugOdXWVDtDv0A99N5zj7YVigGx
   FDzgYjYM/DUNmLES+3i9KV1bqRu3IS9RQdIh8zB57/XeRN4kiLH0Dtmf7
   83SnlwR5Ng/yc3R/bUKE/Z1Ge30IFdSkcgrpNOAgVLXzG/u/npKiRX1dh
   +px7GpVjDOxvbbFkiwM2Ef+XNtAXzVGqnsvCxYyEjngeB06SlKyhmrcej
   g==;
X-CSE-ConnectionGUID: mYR26i/VTASKrTic8994Sw==
X-CSE-MsgGUID: qRPXAblfRl2Ntrtm1P+gLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23354397"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23354397"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 04:33:06 -0700
X-CSE-ConnectionGUID: Le4fatXbRO22lEJl6c62lw==
X-CSE-MsgGUID: WpmzRf7qTLOw89BZ3+GhIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67662223"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 04:33:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 04:33:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 04:33:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sww/y6+J5h7JHbhsj7Ms9h3ndUzrglRMGXqHYQi/nnpOTh6lWMuLmCq/EKImI0EnwF+8wE1kTLqi3SlymKIhXAX5OoKFVTFEA3CvNzMEMpLMVWnBoDt/k7Fw1gfF9dW4zb0JMqzE7NT8tF+QEGs90WxEJGWjXXoFV01GOKSlqRWCl2mJaumxlR0owYXHvaWYy1E69dyBnV8wpYAls9rL7ATzX+svz0SxXwCyosZyjgOLVwmykiZNl555Ud5ldAEjsN2jWiQk6uG3UwWmHeNLIdUy08eRpAc2Pbw8sdnFRMa2dngGta8aUWwG0PgrXfEcvxQcVmlng/AMZfBotQIlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT1Ej2sjFCxWZl01hgCcSKArKKES5Yt4iflO63YZXRs=;
 b=RAPiGbFGsSQLWacVt8oUl90LqRr6R9Fw82hIAa9QrCrMxAW7tY3B3Mba1OcQkg771ERmcKyzx7KSH3CMZqqkv1J6IaRq2zyCkilQ9Q4lya4lDjGGK9VtHC81SSDWZKtqeEOhH29WElWiVI5ZzmfvaPRaT1vLtm3C9Sp2ETo4wHTq2QiPsL8leZLREs21XOhXVu80qTljOJoupvHsSHOPCoTCBwX5AUAwC5py2HoduMbPwlvMhqebcmcY16M/bV5MGVE3KGMbfXOhUKVYgc8qA4x3N3U5Bh+RZzjCBLjNxjyDqdou2lcodEay7fzNvcUpiSSJ28paw2oMRR4fYhCICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:33:00 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::8227:fa7e:8d8d:df1f]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::8227:fa7e:8d8d:df1f%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:32:58 +0000
From: "Kolacinski, Karol" <karol.kolacinski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH v7 iwl-next 1/6] ice: Remove unncecessary ice_is_e8xx()
 functions
Thread-Topic: [PATCH v7 iwl-next 1/6] ice: Remove unncecessary ice_is_e8xx()
 functions
Thread-Index: AQHa8usv7u03+LgF2UenbRHWVOOJlbI1THKAgAW0xVk=
Date: Tue, 27 Aug 2024 11:32:58 +0000
Message-ID: <IA0PR11MB838047BDBD2DE7C379A6A3C686942@IA0PR11MB8380.namprd11.prod.outlook.com>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
 <20240820102402.576985-9-karol.kolacinski@intel.com>
 <20240823201505.GE2164@kernel.org>
In-Reply-To: <20240823201505.GE2164@kernel.org>
Accept-Language: en-GB, pl-PL, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8380:EE_|CO1PR11MB4804:EE_
x-ms-office365-filtering-correlation-id: e535fb14-b9ed-4bf6-0ff4-08dcc68c0097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JkVaLben0DacPKNpjoovDC6O6BeYEmV5EcDm2febeewcLF1EZe84obq2i5?=
 =?iso-8859-1?Q?CJNIbDS89/cWkYxhM/B4pxb4pjiI8GCMX0nAhEarqt2GUDx3KEbSGALubm?=
 =?iso-8859-1?Q?YEDihTlbQpj8JvM6l2MbzymCy/WHFR/KEF0ALHQtFsILO9ZBmKRCUOdx2C?=
 =?iso-8859-1?Q?P37BAji+djO3Qy0LrvT4+VAW/PMw7f4pLVBNEoqS1t4dghh0eTIR56XXFy?=
 =?iso-8859-1?Q?YzNnMJdV4FpmprOCGlcF2SgPbJ+998cOlOv1LnWFALfWHzZNQtBnUaaApc?=
 =?iso-8859-1?Q?zCabo3M/GY9u6Ymxm25JrZ4l6KTbwAmh15NP1FS9AfQur89TYuQ9HS4wqh?=
 =?iso-8859-1?Q?aBIC/Q8hxjP2AjZt920VSzL9mEC2srpWu5KqN5a087F2pV49f8tje0DtgE?=
 =?iso-8859-1?Q?B0DxssP9NAjoAUHK/9Xku3C/xEDPp0D2aNdlKdKpdTQz6iTiFz0MsasIlZ?=
 =?iso-8859-1?Q?AUF2ZCCztzQQdK2+XOlzUXXCIKj6olAm4Xd9fYvauCC7gvetYPlQZl2zwM?=
 =?iso-8859-1?Q?oJ4fkJoHC7s7JkZV4DdqWL3mDivoV6NYAURKfq8uppms2oGxiC1D51KnAb?=
 =?iso-8859-1?Q?upIvHaqP4MtTjoww1+BxITDz8t6Wyg2sBaXqgvkE8Lscavdz7zd33YNxdA?=
 =?iso-8859-1?Q?hN+/aKXQ/iW75bjooe8jYOPhx6Kd3ZAH23wlAr8eFMKwv1flrbPkDj0UWP?=
 =?iso-8859-1?Q?WvX4BSXo/NR+HIZchyhskKVdcJnkpRqLs4ilLIYm06BXwXqFIy0c6Js3mI?=
 =?iso-8859-1?Q?RqHydAZo/DOsFFFDFnS62AImPpUgaLvKM9uxOsmTIJUXpSDPqplRmGaGiV?=
 =?iso-8859-1?Q?TgMaqbzm0yuTCq1m0XJHpnw50PiSTEbetkyFAvZJwVu4YLYwFej3Bw5Jzu?=
 =?iso-8859-1?Q?EJX6DPzLm/DLlFxKwFGOAa/5ObSF1S8L1HEiefIlysyqSA34cPWrkuPb9e?=
 =?iso-8859-1?Q?GOfXZv6wiI3YoK6JE9CSJM+FOrV7VP507OiFyAVl7K4gKTDZQUiOwvHe0J?=
 =?iso-8859-1?Q?6hFdXnh2x3mwmDqvXh+OeJApYVtzQaPq3Wm6KPoe/Ji8ys8FCC/6VjiObT?=
 =?iso-8859-1?Q?g9tFiz2o5A5WmxPzkKAoCoZRAqQghZsHyJGM9TFKcRx0oRNNR1s+8t8qYw?=
 =?iso-8859-1?Q?e/vcr+TlbgrfXFF4eXoUy4v7wEinBEhPmSqEC4u6cp1bXU05V+YrnkdmPI?=
 =?iso-8859-1?Q?4s0R7xVIL7Fv3570OfWI215JlI7QG21jVwupRWTylNFV4TavcVOKFPZFFl?=
 =?iso-8859-1?Q?LePBhPacUazm8WlLV66kHVIyB2g3YiV0P95PJr+kmnZ27GgWurmIosjiMU?=
 =?iso-8859-1?Q?HCQ6ez57KGQ13JTne+x8lA79ZNGb+GsQRKhlSYjtxMDVOkAtR2BmkDSAdd?=
 =?iso-8859-1?Q?axFrtsn7aP1s3Nz5ybbQJwjLaI+p3NmKUfkgwjxaoEmbtoh0w9zZn2te42?=
 =?iso-8859-1?Q?ccLw0lsFdrz4GEQwAfzCjERpWyOO0z4RoKf3BA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9W59jsAH691GWRva1CjDFEai11os/yNaTvByBQFz2figZfgCmQRpaMaqe8?=
 =?iso-8859-1?Q?/6Od4iMMUvqulUlUPoPF3zpOFR89+EDQAWZejDqiw1fVeEHpmYjuKMOq66?=
 =?iso-8859-1?Q?OiYJ4nbxZI3QA6cFjNjSwOlB6Aeoo9G67Hv6+LxGDxCdG4GUIyMMENbLxJ?=
 =?iso-8859-1?Q?c8rHkNT/LuAp5tp10nzT7K965u+peVIPNA8qfyJ8S+3kRQAiRieDKLvIC3?=
 =?iso-8859-1?Q?sCMJ0ztDyWbHTM9GtiBUB0IOrTqSvHdOzQx/lTJStGMXhN/tiuxzrK3ISe?=
 =?iso-8859-1?Q?MgpTnm6EcrC5K/oZl24Z8dKc38+kA9jUwJjbecc4hYilZLhH2Y9ZMpljQx?=
 =?iso-8859-1?Q?kdbs31HvS3KPsIpYe1NJeykFZw1FomvALTReVV/duQO/a97sxPHt6oQpsX?=
 =?iso-8859-1?Q?HUV8FAQ3F47NVi5MQDgmSoL40LuORS/rTx0gMsIUcHu3PLpMnc9gmJDICx?=
 =?iso-8859-1?Q?uaMwEQEFe8AVuJWAAdntB6Ko3wCq7cmUqrABhxoMvJtdRF8eZzSmUC8Qz7?=
 =?iso-8859-1?Q?PbgWfLacl4hc0ZxZDUgU2fftbIkGXFDziGAZUEF4x0FpHVkvwX7dTLbUmC?=
 =?iso-8859-1?Q?LNeVZ8MCn+J/3Dw/WvkumZLVZqWHjBYqU0nT+Mc0APgDngEs6ZCkOKMvqr?=
 =?iso-8859-1?Q?NMWO8wsbpqVvjVXGO0sbIQy9ssFA4oLFnK9DTOPaK0uBzR7zanCNiEodRb?=
 =?iso-8859-1?Q?LXqz4vJnY7ov9WMoDI94zxKBy0S+BuJvc+/0g0ReWIkv24PLBxK30/F3nR?=
 =?iso-8859-1?Q?kSfYR9cpo4pzzQmAoPmpeGjGh9TI6nIYD2PCmWaZv4cUr/8o4H5Na9AGqO?=
 =?iso-8859-1?Q?djOllmf3OYLGM/6ov4vqn6ddhtePch80hWRDC2I2t3//jqUFXADU/zeZ8S?=
 =?iso-8859-1?Q?s7JVs0bNsgj+Nrzdz7wB1h6mwwaJbvAVG8ykeO7iH/M0FFqw/5JVZsXA3Y?=
 =?iso-8859-1?Q?NmUg2YlHZzcPLy57RmjhqTjAN1YS5vFWugrWeNK9j+x/9VJXKW34z3EosB?=
 =?iso-8859-1?Q?hbnWio0H8EYINc9UXNrs+Rc1zsIMAHclxFyrh9IxH7WSn95Pft0IpTjWF3?=
 =?iso-8859-1?Q?FCCvr8E/cYtHbH9LMkxzkXoo/2aPzyKMfd7F+AbsQBaMMq7WPGavkql0QT?=
 =?iso-8859-1?Q?ywX0DPUFKDK66Sbi4uavpo3NSrQmAbxN8B+kHSGmUacqE92zM9Ix/a4moR?=
 =?iso-8859-1?Q?AsBpgTlyiokAJZcuePaAMvWD6KwdFyXN4T3ckVIxGH/ZTPhwXa9jT+cdf/?=
 =?iso-8859-1?Q?wM0o/4qGHo5SnFoh4gfm857HHckGQI3QKMsva5M0Q6u8uwM33SFXX3t5KP?=
 =?iso-8859-1?Q?Os/B48Tnss65qFUf4hOspvwpVmEeaVXjrDRUOj2Ze70L2V0IO6yfY58vqR?=
 =?iso-8859-1?Q?lVqPG2CHpc6LJYqL4TN9HmrjWRxgXSOoGpIbz2r2SDfkhnZaxvyp5VL+xk?=
 =?iso-8859-1?Q?7CmvS1XiIzrE5mTJAQyENEXdc3+I7+GpAj3PaqcATi7kJ5GKQwuDDy2zeY?=
 =?iso-8859-1?Q?7PUf2392yE6AVdFB+9DhthhZDRqwjyjUikQN0Tyit3iuHCfEo/VXAMpUlW?=
 =?iso-8859-1?Q?TpWhbmLaUtZdXEGUtQXGx2MrjAuZmOyPNkLB/DlabtAvFZNI+15mQ3FpFZ?=
 =?iso-8859-1?Q?L1odSUqVOTOa1rwa/Bh1LSf5JPMRan6hzdhtbxeg/hlrJ+/QToREmEQQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e535fb14-b9ed-4bf6-0ff4-08dcc68c0097
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 11:32:58.6943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InK5K9cfeMy5MfiqRjzQSwBGSpIEwguVMG3wVI0zwmxAjB5mPIeek+uqbzft0k3X26zIZ9xv3+X+UkwwIW3Z42QRMlNFcz7LXLzL+2qj5Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
X-OriginatorOrg: intel.com

On Fri, Aug 23, 2024 at 10:15PM +0200, Simon Horman wrote:=0A=
>> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/eth=
ernet/intel/ice/ice_gnss.c=0A=
>> index f02e8ca55375..dd65b2db9856 100644=0A=
>> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c=0A=
>> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c=0A=
>> @@ -386,27 +386,22 @@ void ice_gnss_exit(struct ice_pf *pf)=0A=
>>=A0=A0 */=0A=
>>=A0 bool ice_gnss_is_gps_present(struct ice_hw *hw)=0A=
>>=A0 {=0A=
>> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)=0A=
>> +=A0=A0=A0=A0 int err;=0A=
>> +=A0=A0=A0=A0 u8 data;=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!hw->func_caps.ts_func_info.src_tmr_owned)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>>=A0=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!ice_is_gps_in_netlist(hw))=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>>=A0=0A=
>> -#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)=0A=
>> -=A0=A0=A0=A0 if (ice_is_e810t(hw)) {=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int err;=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u8 data;=0A=
>> -=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D ice_read_pca9575_reg(hw, I=
CE_PCA9575_P0_IN, &data);=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (err || !!(data & ICE_P0_GNSS_P=
RSNT_N))=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return fal=
se;=0A=
>> -=A0=A0=A0=A0 } else {=0A=
>> +=A0=A0=A0=A0 err =3D ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data)=
;=0A=
>> +=A0=A0=A0=A0 if (err || !!(data & ICE_P0_GNSS_PRSNT_N))=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>> -=A0=A0=A0=A0 }=0A=
>> -#else=0A=
>> -=A0=A0=A0=A0 if (!ice_is_e810t(hw))=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
>> -#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */=0A=
>>=A0=0A=
>>=A0=A0=A0=A0=A0=A0=A0 return true;=0A=
>> +#else=0A=
>> +=A0=A0=A0=A0 return false;=0A=
>> +#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */=0A=
>>=A0 }=0A=
> =0A=
> I understand that the above relates to the patch description in the sense=
=0A=
> that it removes calls to ice_is_e810t(), a function that is removed=0A=
> entirely by this patch. But the above is not a simple substitution of one=
=0A=
> check for E810T for another. Indeed, it seems far more complex than that.=
=0A=
> =0A=
> I think that warrants an explanation, e.g. why is it ok to always return=
=0A=
> false if CONFIG_PTP_1588_CLOCK. Perhaps a separate patch is appropriate f=
or=0A=
> this change.=0A=
=0A=
Sure, I'll separate GNSS change from the rest of the patch.=0A=
=0A=
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethe=
rnet/intel/ice/ice_ptp.c=0A=
> =0A=
> ...=0A=
> =0A=
>> @@ -2759,7 +2766,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(str=
uct ice_pf *pf)=0A=
>>=A0=A0=A0=A0=A0=A0=A0 bool trigger_oicr =3D false;=0A=
>>=A0=A0=A0=A0=A0=A0=A0 unsigned int i;=0A=
>>=A0=0A=
>> -=A0=A0=A0=A0 if (ice_is_e810(hw))=0A=
>> +=A0=A0=A0=A0 if (!pf->ptp.port.tx.has_ready_bitmap)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;=0A=
>>=A0=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!ice_pf_src_tmr_owned(pf))=0A=
> =0A=
> Likewise, this doesn't really match the patch description.=0A=
> Sure it is a simple change. And yes, after scanning the code,=0A=
> I agree that has_ready_bitmap is set other than for E810.=0A=
> But it is not a check against the MAC type as described in the patch=0A=
> description.=0A=
> =0A=
> A separate patch would be nice. Or, if not, an enhanced patch description=
.=0A=
=0A=
I'll add patch description for this one-liner.=0A=
=0A=
>> @@ -2898,14 +2905,12 @@ static int ice_ptp_rebuild_owner(struct ice_pf *=
pf)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
>>=A0=A0=A0=A0=A0=A0=A0 ice_ptp_flush_all_tx_tracker(pf);=0A=
>>=A0=0A=
>> -=A0=A0=A0=A0 if (!ice_is_e810(hw)) {=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Enable quad interrupts */=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 err =3D ice_ptp_cfg_phy_interrupt(=
pf, true, 1);=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err=
;=0A=
>> +=A0=A0=A0=A0 /* Enable quad interrupts */=0A=
>> +=A0=A0=A0=A0 err =3D ice_ptp_cfg_phy_interrupt(pf, true, 1);=0A=
>> +=A0=A0=A0=A0 if (err)=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
>>=A0=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ice_ptp_restart_all_phy(pf);=0A=
>> -=A0=A0=A0=A0 }=0A=
>> +=A0=A0=A0=A0 ice_ptp_restart_all_phy(pf);=0A=
>>=A0=0A=
>>=A0=A0=A0=A0=A0=A0=A0 /* Re-enable all periodic outputs and external time=
stamp events */=0A=
>>=A0=A0=A0=A0=A0=A0=A0 ice_ptp_enable_all_perout(pf);=0A=
> =0A=
> Here too. Why is it ok to unconditionally enable quad interrupts?=0A=
=0A=
All functions called in ice_ptp_cfg_phy_interrupt() check the MAC type=0A=
anyway, so there's no need to check it here.=0A=
=0A=
Thanks,=0A=
Karol=

