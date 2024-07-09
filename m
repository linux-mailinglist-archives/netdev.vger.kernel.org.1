Return-Path: <netdev+bounces-110127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E092B10A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5331C20D49
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B413AA4D;
	Tue,  9 Jul 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW4xT6cO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522113A27D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510126; cv=fail; b=B8PKmAopCHpuklDiPUJF7dInzsz5M3Z3/6W4prCEN13ygSl6Uw0si18emAEoi2XEBGWLSiulCx9Zu1XT/WNvRUbqBsa3toHrD/W9GyzCVyL2qt57wsTdhlLjguF8m1iuCNWgXly43WDkl53sFw9afYnmUojwneMpgrBQQTxNoJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510126; c=relaxed/simple;
	bh=9cRcP6m5mtkYIqsm1I4UCGGJH+v+x/D18JNrrXyZhCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cEqsPvfanRmLV7aCWvJGPTqOEGHAMP4/00oennOqIGKHFLcVh6t+N0yUzBVScXDTVi7Jdo8lxMYrQxDRLku+N7eqbST2muExVYTm1tv+fbrc+m/AmfhTp3D0HGbuo/45/+0KfH5ruD6116mUa532SW0VyPX8F0l28/AWFYl3SRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gW4xT6cO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720510125; x=1752046125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9cRcP6m5mtkYIqsm1I4UCGGJH+v+x/D18JNrrXyZhCA=;
  b=gW4xT6cOHFA+vWor31roEEHn0TZ8b3j0lb5NTSivrnpXx4Umn+ZOmscY
   XYBpktG7Qq840oB1w9U/zElsYjdvfLynyNbCph9N1/q6lxV8ucZjtZMgk
   9rEV3XUoUeIeLLlpkb3botYyTOvy/dyna0l75Ej/VTJDlcmW41soz9u4a
   xX3MXzlEwfAD+ce5Il8IeJxpaVht0kXF+R2Pu+w0Q6lvf/Av0fXcl7tCo
   6ynoSmCTZIeul8RoayAIUNNTViMg0f4qzrDtAwkVJghF5RF3sXWtnqrTW
   BREih1dMYrxtylYgojfnXXbfLmLT39JQK35vL4GmLGsnX+q0nQrgXG5Gu
   Q==;
X-CSE-ConnectionGUID: UnUAtOhvTumbvNP95IL0MA==
X-CSE-MsgGUID: su6rmYYBQdeOl6josuWm0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="20646108"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="20646108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 00:28:44 -0700
X-CSE-ConnectionGUID: LGJR5NosQruRfPsSXxBc+A==
X-CSE-MsgGUID: 2pjmo+YAQ6qMGdXXFDVbyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47865797"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 00:28:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:28:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 00:28:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 00:28:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 00:28:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8jwIN/SpAnSqPlLZFP/oelTTWiZHYy14I3cbsAjguYy+na5Bg2isy1E3QdzTt7/dmQiBnrfoCv4doNSUbeJzIbFl5cutTFh+FQmL40Rj5FDoVNtfyUlJe4tv1ecuIltz23FOj1iMWP27lVv3MQiSOAcoudC11VnMRyyAB7umRoQvUbqggE4z0txzC5qNVSojn3QsG9Vq58eNfxX/RRc0lj5Pu6v3k5sL4Op1Zml/XGLtQFjnUsOLbhQIXRl9DUw8s+DdAVhc9pJN2kgdjoUuE2/SpA46aK19cLbuaRejVDDCqfcL+f1CrAsaS8TkOqOoaBgg7ptAImk0vwC6vrYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVBbJDW7ZhQSXaLvYlxXEXRWhiF00oddc5M8CN78twU=;
 b=bxR+GmXlpGyPKP9IGKcSLIeOHWvsFi8/RYJs1azcLxOf34UeHXoh08Q7Hk5uG16+TMsRcNxANyr2VfDcuBGBT2VPn8pvGlkumDz/GD8AqldTnt0Wv7+kNfXjFblJz0yGGvR1tWi4WHzRhdBtCCiwY4xQ0ufaWSsK6mmItbDv673z/ceXfOfoO+PJTPiiomn42LAZl45Ujl5TAGJ/u/Tavu63Bqi6xvWry9dRSv2gg1svkyGoyO9K0ykOue9DzaVvbLlg7SM9HMe5laaiUYudkHGQVPGOU+OO4EywP75l/RpbcM3uU2i5Z08eU/YMrP3K0H8PCES1r2D3iiZfP+S41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:28:40 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:28:40 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v1] ice: remove eswitch rebuild
Thread-Topic: [Intel-wired-lan] [iwl-next v1] ice: remove eswitch rebuild
Thread-Index: AQHaxgx+Ip5c15CHfEaSL4WZ63/AU7HuFw1g
Date: Tue, 9 Jul 2024 07:28:40 +0000
Message-ID: <PH0PR11MB5013679EEB4235A85701405F96DB2@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|DM4PR11MB7350:EE_
x-ms-office365-filtering-correlation-id: 9746660d-3d97-4da7-7c70-08dc9fe8c190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B52Nt88AUFSdmswXYofryKQmdc5v/BsHFTNOugsL6d1CiwgSE60CzAFOXSKb?=
 =?us-ascii?Q?L+5D7vXg1/UjsaEr2cEB4Vq3kIH0EAm3KsDGjPDhiVqPsFQmQVa2VYJeb8IJ?=
 =?us-ascii?Q?21QMJFZIDBSwNiAPn5Bh1VKFvcpJZbQQelOCrOGnD30Xpx7N46Z0G0KwCyfM?=
 =?us-ascii?Q?tsAYMbL6m+9M/EtrBo4uC9CF9S/aPhfZ2wM/ycFaTbNlNX6SCoc6gTCWB7oW?=
 =?us-ascii?Q?NyLBedA1DEunXNjO6NFFZTsgrGShzZAwO9NBjXQrnarWoWpKRF0L/dxRwyLS?=
 =?us-ascii?Q?z4YO6bdGtK0i6Zks1+bnDGgpSuSHYou03YawUtMmFvRIt0XxS+IYqodjl/AT?=
 =?us-ascii?Q?GUG5zscCJqPrnqidsBNplc/AX4HvkLLKD/zEb6T8trMJj/4ilCGPr98V35X/?=
 =?us-ascii?Q?GcKLqHzPbrLONwBEzcYec1jg8TQ6nV2WH/U6T/Tp+UFsCHVzKDvgjy2hQu5w?=
 =?us-ascii?Q?a9rJradeGl88alDWAIwyGVpbtBtGJw4FkY/l1E0LeZRDFNMKE46dRJrEyUb/?=
 =?us-ascii?Q?clk1VjGa/tntRL2fE0LJ3op3uPsrepkwq0zkhsOZMVzZ/GrsxlK4tkz5qpJB?=
 =?us-ascii?Q?oBHzU0PS9LW2Buih7q9GmbgCkcdgOAYVfstnOSVT6QvUaNhUJPdo80moZ3hL?=
 =?us-ascii?Q?L9jK2tTEkqV8469y2uP9J0FeiDDyALuwAhE38MOpOSPVmzgcoTYMx5jg0weA?=
 =?us-ascii?Q?J9CmgBSZHy/H+u8WENQ5WqwbGV7QTAEuEvRG0YChebfA/RxwnQwsEJkarrsG?=
 =?us-ascii?Q?sIhLf15FXRm2M5qFJUHXJC5WSHF0elNjbV3umThCe1CE1uKmiCN/Yu2T/yGP?=
 =?us-ascii?Q?mlGIUwCW9SYAnhOrKC2ltCRUEz6pa+uMzX8AKT2zd+mrLgZ13R4KJYBJToxk?=
 =?us-ascii?Q?Clq4YUMQCv2VjO/wUyc5eP/iI3MeU6esW+YrRtoFcsOA9PIwv7nUFHxzz4Zw?=
 =?us-ascii?Q?sBznmds/MbieyVazxUNBHDQCpebtmSqrnPe56nkx/tpW9QheBdP2Q3NS6hDr?=
 =?us-ascii?Q?9f0pr0s7J/d7/fhgfLJDMN6jvW8gXLLWMEnRJBAqxXLpla3NkaseUvh0RXZs?=
 =?us-ascii?Q?at8/hmM/Mzpf3RuUYxoMG+0QyJeX4d+Fx6WGIsbjDETfxtDlol1tY1GhV4Pl?=
 =?us-ascii?Q?ZFps2UY4zNfesih012GeocUfkk+qFbBB8OvDIOL7mylho9HPi6PNk6Lrl8sH?=
 =?us-ascii?Q?zA5C1o/zQPu3xZ75MgRpj9RsEkdLpogyHQEgFLRe48yEcJoj2RsqwXtIz4lV?=
 =?us-ascii?Q?PfQdjkaz5mg+tR3sGXTmRupPUcAWxed8w8tL4WDQmwvNqTdhhOHst3qoyQ7r?=
 =?us-ascii?Q?zheqVB9Yvlj9FQrWLZk0MggjnxJdaOfVsveVlxLhEUacpaxbiUUQZ+bbhwMp?=
 =?us-ascii?Q?FikVUlkDOAuFt459t5a6b0yGsLsZJC/kjMDCf1R5pdd8k80a5w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mfH+fstujMMPEPv8nWJWS+u+qr26/bJ8EOTG6wKDpxbCZE2WCLZdaOSnpozW?=
 =?us-ascii?Q?nBP5QQnNhh1K0RlFXZ8XiQoklneHbPMtSdfv0Z5YfmpsWWKBlh1rwvxheyow?=
 =?us-ascii?Q?wJaM9dvZTyk1gMUU9o2MERF7Nihy3jH3WRwS5FdmbVvG/0cC3wr5Lzpd0F9G?=
 =?us-ascii?Q?pqfDz8oy0MOzXLTMcQS0gjwMIxtBybLEsZewLnZBWD+r34m2u/zgEiWY39Ns?=
 =?us-ascii?Q?J7IQ+Jv1wOtHucrPbmyUWWl3a8A6zP0wcGEbLD5ARgXP34GhuXsmTKv4wkbl?=
 =?us-ascii?Q?rdiZ7wsg2/pgFSLZxyujNo5yx63EvM/awW4AvD7hsYEdNZK2YFfwhPLT3SmQ?=
 =?us-ascii?Q?/d1xWOWKfVcVgRrz6cbgKiIzl5YxK16L5ZXtKv8NOMU/ZcXa2Q73Bqh5DTpr?=
 =?us-ascii?Q?l2JNV4bfQLnwbFktRhJuxtw3AqPS2dL+2ipoOn3ziV/I3gZGfa1Gzcyw1781?=
 =?us-ascii?Q?LY3r3C4w6l2e9gJFGiMUQXY/mRZdp4vMu7jNAnDSCga42+YYrUXRRUIa2R9a?=
 =?us-ascii?Q?fI66obYAOwEnbDCLAHL7NuGBUSVDN9BPAj6N/Pazk26qpje7M2KaZo/llVdo?=
 =?us-ascii?Q?EWYlINui3WneKqTGlR6lFqCpdKvCwdUj0dCqP38z/eiUtRN8kx80NYX83jCC?=
 =?us-ascii?Q?qzYV2sWSAHAoDhHM5uBRW8offZ+DWXOQdlc6WOPBPW1JqE9RzUNqJzuHdEpg?=
 =?us-ascii?Q?zZK+gGjaEzrOTpbx0qAfE7IBoynW9S05XshCgyo8odP4KaQZ0SzPUoQ+NVpW?=
 =?us-ascii?Q?pd/CubNFKePrRuyUWTJUcLapfPkLThT6taP825L/YXvgQM+rxNgsHo25EWQJ?=
 =?us-ascii?Q?tObIb8UV6y0hBzoKkiTgBknjSn+O/kxZuY4+PgKRpV5EOQyr4TZwShoafdIF?=
 =?us-ascii?Q?d8Zg9UXEBfdDH7WbdBerru32XHS66RrYmhiZER1+pDo6kYPWuJ6C9ffRahju?=
 =?us-ascii?Q?wLv1B9lRwr1uKT0PJw/N4hdo7/meiS8E1BYGpkJpGy4b5Q7Xb7oUyvST7jBX?=
 =?us-ascii?Q?oZGiouHB1RiffdQ287sqQhnFR3cGlMu+74yYgAt/az9yqpbe2GW4Fm02Rf7V?=
 =?us-ascii?Q?Ktspi8z1DSf+nqRwtAP2DI8oRb1cg09fbBTj/8zot6HKRtjvEWJKF9YfInkV?=
 =?us-ascii?Q?wMv9JY7Q6AEVlTcJF7D0CbvNy1QtnBaIqZd/l/19U+HWc/hxlpUm5AbVpxRi?=
 =?us-ascii?Q?9e2jJr3zzgrQ0FjK8ub16ZB2PMXjwA+PJThlvXtKs4X4JsHR/1KfSP6C0z52?=
 =?us-ascii?Q?4W4HH+gvIQsF2evSRbz5UK/f2HPTnkApHGu9wtFRpJQu538bMljoKko8J+1T?=
 =?us-ascii?Q?bcTgl2Jse6lOhii+oPTXz7ZojjoTiYYJsbc4ptVt24oJVLtiIHQaV0FFcJcd?=
 =?us-ascii?Q?OcLU5ozS1mmx1A9Z0tsvMO7kHuqkPRFGjV7nHAcwjVLeZEP6p0ih6RLYit04?=
 =?us-ascii?Q?XLYylLnjqUrdRHxGwiGseDfkzQiETW+tt7Su8qjpX7Nmlv7CCZ6ipi7q+Glo?=
 =?us-ascii?Q?FNxFf25+E3Zoq1NNSWm7sFHWilwoG9SIVPQKGW9DG6qCVvtVdZ+aPMfdLRaM?=
 =?us-ascii?Q?mewIrYypjKgqbYLfBmSo54d1yytUfovHKTBvthyjjgQpyiqCCXhh/mDLlK90?=
 =?us-ascii?Q?gQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9746660d-3d97-4da7-7c70-08dc9fe8c190
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:28:40.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cI1RqadJsadGVCisAXAQrewTcFHbxbyMjIoD3yUmA7pQ1b8nmDzA47H29J/eR0b/ekklSTnKHS65JxNh3kFEFVTj3vkiwVX8QZpfv0OiLno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Monday, June 24, 2024 1:35 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Drewek, Wojciech
> <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v1] ice: remove eswitch rebuild
>=20
> Since the port representors are added one by one there is no need to do
> eswitch rebuild. Each port representor is detached and attached in VF res=
et
> path.
>=20
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 16 ----------------
> drivers/net/ethernet/intel/ice/ice_eswitch.h |  6 ------
>  drivers/net/ethernet/intel/ice/ice_main.c    |  2 --
>  3 files changed, 24 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

