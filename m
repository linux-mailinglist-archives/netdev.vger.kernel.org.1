Return-Path: <netdev+bounces-105531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABBC911954
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAD35B21C89
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3F12BF3A;
	Fri, 21 Jun 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQv/0KrW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000441272A7
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718944035; cv=fail; b=ougEG7V8nMRzRjVeZn7pMsGp+asyo2rl+E1FUlLvF50y8VCtzN60zRwBHR0VxCtHZLvOsZ6GwRyXon45WtLIUlQx418R8ytbLo1P06imULCDmMJe/yNi6VIFP9TYwPXRMzlGM0Y9IIvUbSaxKE3tGhVMkL2Ho2Z04m+Ivzep2t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718944035; c=relaxed/simple;
	bh=2xBcv+P1jmwpLA6rqvd8i/rA3Tmo7EY2hsvMYOOtRgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0gRPTvndaT9l48OErRJ+CWe+zQVhUVA/kkRKrDkvjBpq3hfrh5bMiDgQ0sP0Z0wgL2p+wqyQznLzfhbyDni+CxRe8Tw6svuMP9gUP0sgtSxpfODEZ+19rQh8k7l0JFX77C21PeOH/DbUkE0zdOETvqU2++Jbc9TGZHTIDMryXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQv/0KrW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718944034; x=1750480034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2xBcv+P1jmwpLA6rqvd8i/rA3Tmo7EY2hsvMYOOtRgk=;
  b=VQv/0KrWq/tLqF55lDdqtVMXlsxUwKcxWxgoUTstXqeA0PVZhV3kyoPG
   tjMHUWkYeSNAlFEUwkYnaj5iM4mbN6kJkCmHlQjTHfFo9mvKiHPJ+wiJ2
   9j4CA/UTNqAPwLP/MWS1VvX6wRWV5aGKk4gYP7WuHc7PzjIalNRWM9BAi
   I80n9mQoqg5iQ4ByQp3kSzLpvknYfCMJ/j/hTasLY8nWjYGHbXrL/EIJx
   bZs92H8OCnE6+WB0Q1bbfh3R8H+gAFswzF7f9WfWdjEonK8n4vPfLlbkE
   1eCgee8tIfIXUNrOGjBF+DR75s/s6G4uufuIoJkzaelEZA8AI48utSl7T
   w==;
X-CSE-ConnectionGUID: j8zsLts0Q3ibxVHaaPsZbQ==
X-CSE-MsgGUID: HiwMV6B5QqiNzf57Ev1R7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27383048"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="27383048"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:27:14 -0700
X-CSE-ConnectionGUID: UloQI2pVQkC6qUszBDNw/w==
X-CSE-MsgGUID: 90/pfVGxTq+hfeZn1Vs6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="42916757"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 21:27:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 21:27:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 21:27:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 21:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLiNDvkIoEOtjMPijKmiDti6gI0hfL9nMcqrCkbggGduBua82/2/b5LsxIZT0bQkLw57XU4JF4bZnEVZEaGRni2H0ank36BuwtNuXtLwACf5GPoLun5bH92+lIUfHjyBOKHSxbLubZVwmC+yyljqtQ8wjVPxRbACv0uxwGkeS9pwKazgHLgxUaol/FcqSsUJkiJmPO8bcAbWG0fWcypRQsB/htBmVQ1quMZx+jQC3ZnBMaDbv06Evi1IZAKdlCKJDK1lJCX/SpcRe9LdbHawF/jpxRq0wAIEa5TKZ2iZrs1mw7v/8NrbZrqFi2nwospa/ewFbHSiZ6Z3PI0IDPlHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wemwrZPW4R1DPJHrvB/9C1R65464DDqN2gcQyo73PUo=;
 b=KvlwmFkKEwloQg4TYJ+FSTbGRxbG9VpZHCm4FbMSmrTGk3QiU/tTXzEzv9z3WD8KPzUstnq1tplGZUFffY668xFenbHd3tMuEw+8rBIEzupOgK5pROGA53ft2ZV4Z1S5nsz2v8krq+M2bpW7AlsT6rDOaS4ThBx9Jte7dDzTLwwmqP3GeIxmRx6pyYc3gsgjusGVgbqQcPSLUUQzSJq86820BleqC4o7cMviNurujkE9mp4+f8Y2CgyMJKcdxFu/aqrk95RWYgeHcTODaKHbyxxMTIFzc+amGDI5EQJf8p3ECVEbV3MEChNn+zjcHen86EK+ZjNnQMiNXORUv/x5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB5913.namprd11.prod.outlook.com (2603:10b6:510:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 04:27:07 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 04:27:07 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Gardocki, PiotrX" <piotrx.gardocki@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Zaki, Ahmed" <ahmed.zaki@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: Distinguish driver reset
 and removal for AQ shutdown
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: Distinguish driver reset
 and removal for AQ shutdown
Thread-Index: AQHavka3Ts/3f5m3P0ekEzFnnAk1z7HRqbjA
Date: Fri, 21 Jun 2024 04:27:07 +0000
Message-ID: <CYYPR11MB84299EF992E6B3885DF77DD2BDC92@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240614103811.1178779-1-marcin.szycik@linux.intel.com>
In-Reply-To: <20240614103811.1178779-1-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB5913:EE_
x-ms-office365-filtering-correlation-id: ec3d8080-8e52-4f23-d958-08dc91aa693b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?y9bBkMyAtJui2rWaxQebn11Hn/KaFCsCxTmHLHcSLWIUzV8Z7fhifH/HH6Jj?=
 =?us-ascii?Q?sb31mPtKDqFM/8WWwThG6yayk13w7ezOrRp0joIZwxvaxB7Dvyv+F20d3PZf?=
 =?us-ascii?Q?nOTbMQa5T83De6I61iUU6A+L/POZo7fE1CZC4L1aWmoCpR9+MQdX5hIAZbmJ?=
 =?us-ascii?Q?Ff3l2XmrtaGJyHUuGl+RlAKeGMqle8xopHH+z6yshhvnVouAt2MVG/pffpn9?=
 =?us-ascii?Q?m+AK7N2nQNKEw0Yj48TdNzm/GqFFrU/wmB/iQkqZEmX5E9ZYJ8+Y9ipnzA0M?=
 =?us-ascii?Q?GdBMqAQMN+gQDysYjgxjPwRyY2aX60437H7UCq0UPF4u6DUQA8L73ILR7TRb?=
 =?us-ascii?Q?zPSKLHyaiy4s/m5YDunR8i0ej64PMxJOxPMHNHdzF8018zGl5JdlbzVNz+uN?=
 =?us-ascii?Q?WGmIdQgw4Jg+niP9zwMEsme/HLo1YfqbXfgg5mZ1Be/B7y0x+fqho9MxgrnS?=
 =?us-ascii?Q?K6yyG+aIj5ZaPX9MLA5hbjnjfdb5E2ibj8cz/BTm28rIIngKGUiqsM+VZrwI?=
 =?us-ascii?Q?iqs11SuUHJy2a5yiY0wuO3KpKvRwc8CgdOIl/5jrpDcGH1uAx7U/7yFz6cq/?=
 =?us-ascii?Q?8vcX5NFSFuiNQb5df714ySW3ofK7Sq5pDWDzDB8bBvbuPAtdeEQiezRzyybN?=
 =?us-ascii?Q?yMq7dfXA1n2apitEtnOge15dq+nkxlRgHyCQOJuvl0jNAqTHuUglgSH+IwSY?=
 =?us-ascii?Q?7GCaUZRyBI4w5b7mEDHBr5CEAZDplF/xFbAETLNfcru4cCcyAOlSGQImhL3n?=
 =?us-ascii?Q?IS8RpL7oDyaPjvchoXxQntptG0dVDugl3De/1D9eu0KmDU87xxaH+le9eJ0Y?=
 =?us-ascii?Q?qGp4+YY67Cn69LGuGaV4hzlpq4zapNZBBU31tsW79Bs2tQbD4DDv2F1yYDgm?=
 =?us-ascii?Q?gKK1Aop8w/z/UqjD/UJ5PFvjmG4cg41+v5bmXxFJmqmXZbuOhHfYxUB6min6?=
 =?us-ascii?Q?hJuPDoCDMF5FC8J+px4ZJYFcdXr9hT+1pGI97Lo/OTxjn9SxxiGP+mQaJpcs?=
 =?us-ascii?Q?CItidpBZB3S3GkNQPxrAbRQsN/mstZuobMutCXEyHe/iyC2SCsCX947d5mn4?=
 =?us-ascii?Q?65fEzLHIC9rlnvgS85d0sTQWKYuacttrc/sjFLvR30mEc8i5Ohy7N/b+LuJK?=
 =?us-ascii?Q?FiCTccHq+mJAdNKBVN6OquSrhoOrOkaNDyNFLdYoJKPIF5EdFaAgIYaCYOCR?=
 =?us-ascii?Q?aO+nNHvg34HFm1ulSXPKRf6sx4v6mJk9r9sa2POcZek4EYDvTtAT1kxaJi9b?=
 =?us-ascii?Q?nPbBIweHlPXpqxmPeNf/yGdNpageOrkq2i0G/NXcof1IUyOfU5WSZTrjGyYF?=
 =?us-ascii?Q?H/iBaZuTlDuMisqlAw/BVkXA13csIrV8CDJjmJyX0UYJILtB9/y8yybkWpWb?=
 =?us-ascii?Q?5ZjJX/A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fcrxUAlUAgIE0gXgrbyt0KhLGnYDo/f/L1M8HM8qDws+H43iC0SUPtagSHrR?=
 =?us-ascii?Q?Zy+FrCzODZIj2b/VJaxvlUNCbD45iZtc7jQVoBtXQmZn5fkdSYi3yoMpOiJ1?=
 =?us-ascii?Q?SSIFAErfPvB+2QLQorSaCANvNn9kWIq3RqbjsBu++SZ/PxeiOFa5ARoVnXsr?=
 =?us-ascii?Q?c+WMFjDjXOshJx2myapmTgmorkMRGQYdz0SH71R+yhPCw1B2pkcZzR5iNuf0?=
 =?us-ascii?Q?LvfCxJDwz/v8gTkVH41fz7yrDOeRLrLIYpo/3XPZUO/E5H6mr6Qp1ooz9cHB?=
 =?us-ascii?Q?sZzDuHtAyurMZ5UskbBrBgozF10s3M7f3P3TTjKsdx+RBUo/n7RvoCXtbz/m?=
 =?us-ascii?Q?RHPkqsVQ958NXF4dAE4QhtUGKhEdLOH71nFE0vjl3WJ6+6eHPDv5CvUgVvwo?=
 =?us-ascii?Q?Too76cGLIZ3SEIvWrP15dElbFPFTnicPD29PzV3mSissq94t+U6xOdTY8hsA?=
 =?us-ascii?Q?rsP6GbK//eb+vT/urZ3Ql/8IW08XGM8FPzwWM8N3UVgcYuFAEgqFqcS53WmU?=
 =?us-ascii?Q?3Pb/IA1SSoB5UegPsVsgBwjoDaA4eeefqBcV3TH5ljtPl26DRguIhfT68ECO?=
 =?us-ascii?Q?B12ryXT/Mo13xAle63MfmJiTbyRDdIQv1IJLUX5QEfcXpadXwR6F3tRneFX5?=
 =?us-ascii?Q?SQ0wadfIDuxG0eELGtX1uZ6ayXf/sjowrAmj/5APhtS0fpKyO20DUt0jkLpT?=
 =?us-ascii?Q?x55oKsCUquJ1+mL7eLMhslKjgOwfT3+HC6w63rAKkpkl77w+B3eUlrlgK2oW?=
 =?us-ascii?Q?F6gHqFUD9V/5Ya0LeJTp00+mQm1KCvxhIHT6U3tbuNvBhcvvwlbJHxvrv8mx?=
 =?us-ascii?Q?8pF/A8iMp2OHztslt4Tkb6QizRVM+16R8uDSzNtN1vVYgc9w7tpmBfuqM6eO?=
 =?us-ascii?Q?CC4DB0TJzUOFIc/DtCT9TIQpmBdkFpqq0AUvzKPRpy5Iaq/h/KPtcKm4/ubM?=
 =?us-ascii?Q?Yh2vFo9TzzLWT9YGY2uArqOQ3M1vSYioLzgoaOzRWwl50EUvUF/EHCrt+3i4?=
 =?us-ascii?Q?JUlvtH6VHmBtb7N+Jn5VXFpseOcq21PwXTK08hcHK1jc47j9RWgLKcFtMtE+?=
 =?us-ascii?Q?THijJxx4UCS7bBZLcQapykPG4G5zpnEQo1EednrvB64iHKHuKNlUw8T0IskU?=
 =?us-ascii?Q?60DmSRLmWX8v6q/ItGnk7zRygBk4yOwDhcd+A/T3Aa3dRsNLVFYSPmMTn1Ud?=
 =?us-ascii?Q?TxBhBGoEfs1+WoogXVWwRVfN6hMgGG8+C3uOTv1hfMxM5Wqu8FjkiaviXyB4?=
 =?us-ascii?Q?z11vnUopZS9z7hIkY7ARAh3V/7GOq2QSkcZZTxUm/VzsUBpakBtr2/WH+vNM?=
 =?us-ascii?Q?NF2jn1wODLMF1XvVaIDTJsH+sk6izI6tt+mTzK7CD+XuStK5I8MlT4hi5xYx?=
 =?us-ascii?Q?Q5LiJ4btJyb6PXNwIaQkbhM8/KWIvp9tIa6PrJVxfQ5V1rheAqqmb4tQRD0G?=
 =?us-ascii?Q?dJXuaTyo8tHwD3bUZSgydQjKYgAH+4qfKiDP6XqRW1mRIyexjVtBqOfwO4Vq?=
 =?us-ascii?Q?vSj4mcyPwLp8ez4CgYQQi6lkQSS/iZc41TAn391pPPqfo117VpecRYRXpl6l?=
 =?us-ascii?Q?lCgWxhPh6XNx+g2yyHjUHJHc0pXiGz23vgmDPWCq5Qsu+vnx/lWrfnl6MKRB?=
 =?us-ascii?Q?eQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3d8080-8e52-4f23-d958-08dc91aa693b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 04:27:07.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYStI2+ypRAMGCBoRJ/Xrbtr4cQETYV85UTA0I/r5dH+DI3QKeyufB+cA+y6JDVHOPbQ88B8T1eNBr06BIWU4yCtKtUB1CPyRAZkzFeiYKiFAFjYxragPpGMJ0T51SU2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5913
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Friday, June 14, 2024 4:08 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Gardocki, PiotrX <piotrx.gardocki@intel.com>; netdev@vger.kernel.org;=
 Marcin Szycik <marcin.szycik@linux.intel.com>; Zaki, Ahmed <ahmed.zaki@int=
el.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Distinguish driver reset=
 and removal for AQ shutdown
>
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
>
> Admin queue command for shutdown AQ contains a flag to indicate driver un=
load. However, the flag is always set in the driver, even for resets. It ca=
n cause the firmware to consider driver as unloaded once the PF reset is tr=
iggered on all ports of device, which could lead to unexpected results.
>
> Add an additional function parameter to functions that shutdown AQ, indic=
ating whether the driver is actually unloading.
>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.h   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 19 +++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_main.c     |  6 +++---
>  3 files changed, 15 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



