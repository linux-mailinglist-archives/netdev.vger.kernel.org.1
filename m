Return-Path: <netdev+bounces-106005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A687914301
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBA1C2279A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348D2E646;
	Mon, 24 Jun 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI1L61k8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2782E636
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719211857; cv=fail; b=kBlcuxuwoLiBBCGf9kJlH7FeQvumNjv+mwsjtmDwhjS702k+IQd+pvksBf57fGBdVGBLWYoUbqOhYkUpi0PosFILU3trzwYYDWBcljFu+GRLo3YHK0iA5z615I00URgjq0o7rNBB6xK0mYJ/26wzAlseQrUl8zS2VlhXwaI/oYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719211857; c=relaxed/simple;
	bh=z+U85ThuqcShkkII4rXueqzo5Q58QEzwFCPnVkH1cBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lZQvoT/Pq3qGfwpBoa7egRpNVgUfOrvyusAv6ygFGfnBIzTbRRqBvHjkDeeTbVQDsiy2Qtcd6LE9KycpEvNa3kpPD1uMgknhnsjtxcYVPRB1LmrMWmHqK6/76t01o+yjV9NPHAAUcO/nZ/NNsSGRSROp+GaToKHKRRO9qfjjKxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI1L61k8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719211855; x=1750747855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z+U85ThuqcShkkII4rXueqzo5Q58QEzwFCPnVkH1cBI=;
  b=jI1L61k8v3K1oYnNwR2aYfwOogI58LqqytYjMDkFvXsmT3Svr10ZBSmp
   O+bZXBupQjseesKEw7Nm58AMc03BKBJF3RLyRrqH1b8F/jfBI09OKW1WN
   V7CHPAS1Y1GF7kQkRJEI6N01qEUovVl+33vzPzGQcfRq7PFIW5J2okr7O
   9wiF/dho+fNOW5ORVZG7vj1gT4WOXfZjhWbFi3G459dj7kO9IMObiZSlV
   lRmH4Q+WyXg04zmarmuIvN37r47ldwgOCMIanfMI+Or0woMPq/RstKyTY
   a97tIstID3tzdT6U/GZu1vKxhUk1jmAZuP9kZpberD05M6dzsFqul1vlZ
   g==;
X-CSE-ConnectionGUID: lkpkaJjWQsaPI0P3lgTb4g==
X-CSE-MsgGUID: zEMW1zmHR5+SSHOUwtnCfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33709220"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33709220"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:50:53 -0700
X-CSE-ConnectionGUID: FA5uK9DTSa2ax27S6EIkQQ==
X-CSE-MsgGUID: iry2ilTVTMWawkNh2yaz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43074555"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jun 2024 23:50:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 23:50:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 23 Jun 2024 23:50:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 23 Jun 2024 23:50:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 23 Jun 2024 23:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiXohqlybv1ZDa9juPIi09/7HWZoKAF2d41CkFfn3ABEyo0ZHEX1p7KzS5+BzTxDsEM0AUTmal81nVVrbJZJth6OKAme3iMStb6hVDfg0nMZxx6vxbpuvtDQTPGxBl/+z5c2e24z2ywMfKh7OnR/ssVcFqpQL5LE99ohjqNt4YKb8fPv8v3yCIlYfBpyWxmB+1c4uv8rtrLMlWUHO1zZ+nv2t7p/u3iajLoGbF11kmg39g4G5ZPIH4jQQcxWU5y7CV9ZSk1Nnq/hstI5A7o3pksHkDW/ZH11BCheY2fvOVA8LzqcYTkAxX6LRJOSjexY2maLvejmllHHxK5/vUDOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOJsxoBeuLF1CQkAA+gJuJ+aObNIbNVVMwlu19QoBL4=;
 b=CbjcBKGqi2I0N+MLbD4vK0embd+izsIppvHvl6sFJCkV+5smIwTg3obXnIOzFfTeWSFMec7o8W8DUeOYRbKLer0LyjMopdYj/tVNXxkdA6QX+USbiDqy56K/sEeFue33Mlb+992+rDPSQckiWrCPdDYbHDFMJ3VHjWGFtei1lIyniytLVK4H1cO60nJNeZ0NI/QSx1xIWTahm5Ra1Th+2c5GsY3eyv1JnFfciQj/knND49xcAhU9RqwsHCH9QtEzg9cLedbrL3Sj/uyZLiWZwhLtAbsw/IhWWyitFhKbcdS3YFecMOSnkImDnMVoeqN6d79tDqZ3zbiJAdgL9zsV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 06:50:48 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 06:50:48 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: Jiri Pirko <jiri@resnulli.us>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] ice: do not init struct
 ice_adapter more times than needed
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] ice: do not init struct
 ice_adapter more times than needed
Thread-Index: AQHawLnbWy/BoaT8kECQbiAIa5YNhrHWg/aQ
Date: Mon, 24 Jun 2024 06:50:47 +0000
Message-ID: <CYYPR11MB842920993D02D3B82AF69D8DBDD42@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240617132407.107292-1-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|IA1PR11MB7385:EE_
x-ms-office365-filtering-correlation-id: 0d753c97-bc67-4514-a85e-08dc9419faa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?H5UelPgCth5PlxWj/9E0hNwYh8UDcU1mVPtMSF5Yj+/XnZ3rQ2GlYqssa20B?=
 =?us-ascii?Q?L+CTVCROHyQLErIWG/bvGf6vxX0AUhwupbUzj5DajSuNlDWvmWP9c9uRLgth?=
 =?us-ascii?Q?wIaWFF7/zU55ircKlkZnxUTHt3+cOvQm8FUc99IS+FZtkaTChQaYgZnkvvLw?=
 =?us-ascii?Q?vSZkXsJq6nIiAB6NxbsXOusuUCHAroY/OQgpBahhdZPISldBRps2fBuALk7q?=
 =?us-ascii?Q?VaD17g7ZLv6vyQFzjvVQ3038n79wvFdiglVtgMtsLGG8LbluQpJTIIwk9UfY?=
 =?us-ascii?Q?9wKpm01R1uwqdXSe84W++izH+mRggLjODXdlOQmjBSeplhFafkDL+FuoLfhl?=
 =?us-ascii?Q?xSItkg2fcZv87ZiMWAhG8HJISknOafRV0eWRseiBJzol0/u8UPaVR9EBe9Mc?=
 =?us-ascii?Q?qfGEWZ+7hcOPIKJqAxLWtwtiUjw4wL32fm7zlSPgaWSTTvJZqMbznCVm7ziR?=
 =?us-ascii?Q?pPoE584vC+7DUbKbiUAd/XUZENqdScsCjO4qydeDZxsEg1WKNsL6qp1QZ5/+?=
 =?us-ascii?Q?1t5468R2xvn4fwCsDZg9cyc/HHGqlbpsQksP0JMc+zQQpCuN6ma+n2Dd2MU0?=
 =?us-ascii?Q?kney1tIMQqWH9UCbvOpxcu7gAOG0Pg0QIeXEZa4uT35HLBUK2XQKY+JL1vk/?=
 =?us-ascii?Q?qLqr4B4Shp1Ji/rZJ2IaMQxPDHRNX40cZqY+6zuTL+FtUlclqmFMy8agucf0?=
 =?us-ascii?Q?FKDXzmREPIAXJRo8+JoQhRooSySsyrAah6n1T/tNGcmI3XRjEyZANsPlK/ni?=
 =?us-ascii?Q?EeCXtCno5hZBI1bD7RSWSmeYRNHswZCPyVbnhNwK/IbQbZoPOzRi83gj/MPk?=
 =?us-ascii?Q?uQW0e5PtTaCJ0AQC9kLsB/efQwAtYorU2WrDG0RgiF7LJZA78wVL6/cg2rMZ?=
 =?us-ascii?Q?TVgx4u3rdAJdIQhFHLdrYzlFyJ5ycV+txlaPDDgeW8SLYVC4geU2XdNOkAt8?=
 =?us-ascii?Q?Hl6tdooO7wvveUBj0081aYwC7vKFctiAUZtRvo2RtiUxU698zKLx8aW2YBPB?=
 =?us-ascii?Q?3G4AQl90VB3Qv/PGtaMK073BHZ1W1fv/B5IsXTFLhfSF0J7ZiJjbzycR/kMS?=
 =?us-ascii?Q?TKUmuj946o4YVpxm/xXQgHx9Q7B7c7O1G1ut/ANqzwI27eYzT3uLeY3I6oih?=
 =?us-ascii?Q?biRtRHmdiT+N3tfhRfKFgAvGRsubgAo49dFC44PIKZ+Rtz5oJQjzRmp0aNpM?=
 =?us-ascii?Q?CJmekyj6mKPmxW3bxBYgg2Yd1Y634tK43TEmhB9jOPIQqd+yar/jCC4sda3H?=
 =?us-ascii?Q?H4ALc2OBjox+NCQgVG8X0yc9feFZ5OwGwoHKLA0oUKdfLBEnsyqmQBdgmNDN?=
 =?us-ascii?Q?2CCJxVwVmJYwSUiA9lsAM51PZ+vwmFRp8uCQ5CLYq56CZSThT8EZsc8dMTnK?=
 =?us-ascii?Q?bO+MTao=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3NnFe+FFgSF00UKPDT1ZNr9QgYUjMQLiKqdIHbRjC6GL55B57cvtbhwYp6wl?=
 =?us-ascii?Q?PsJlLVs5DNIf6qOLtu/H4anvyMDVyurFF0s83px8abr+jJxLKfzyK6tQqM3x?=
 =?us-ascii?Q?k5l1d+4DsO+W4Z883tyP2f2xXEIQNKIb706ZE8XkrrTMq4tm13bak4BkEl70?=
 =?us-ascii?Q?nOPa9XGJxSAVeZSKKQGzEPqFp8ni93SsWwxEWrzC/mqsE8PslYj5uZ/M56zf?=
 =?us-ascii?Q?vJ0iZskk0Bu77knORcqRNRcZhX9aKQUYOCqL2M9JA/ijmFt8fSYF6RpD0ChB?=
 =?us-ascii?Q?y3LbY0qa3VNSzN6H8RgzcfrXpCszqG4zqwVHAVWiPgH6n47teGoYS6hzxTmw?=
 =?us-ascii?Q?7Lq44ykwUcCPphylaFa2txtEq6hJbN/vO3XM9M9nrgjHKNKKeTwFXJd1C7o8?=
 =?us-ascii?Q?IzhxyUWIt0O82VBx64kv3XSSOp49xZI/yzFaqdJL/Q9qNLVRLVvpWZ7mnJ1w?=
 =?us-ascii?Q?2RmivNivlvTGFAloh87O0tSsgquk3+6zQChh+rBrKxEvTSEoUq/cWDV9khU4?=
 =?us-ascii?Q?c2PgcoU22+LZsabnHxUoQ7YIL6H+hDg+LW0ePQlilf0kGWz3lnSz541ERLGM?=
 =?us-ascii?Q?TU5FXQ3dp3oAUM070iIiUQuEO43+eikS918Tf+Y5kVlzoxLzKtYXG88nh2Q0?=
 =?us-ascii?Q?VmF7SvMv9dfSDbO3olupaZrzZvLaBcaROOuO+i177+sRJA2Qd/jV1kQp0YK+?=
 =?us-ascii?Q?SHYkM8OF9huwPeriw16L9Wme4ZPQIUyxX/t8s4ucl9DXApbGg4AjPG9fNf/J?=
 =?us-ascii?Q?+CIo4J5AvpI3nMcVi3QIkW3EDnROEgU/FQ1+eJRjyF6FydPVT5ZO7J+75IVx?=
 =?us-ascii?Q?idWH7DA03CjU2RLx9SfTWD3UwogglRZKoPuUlAhGrM9Qk9oVsKXjcd+5jYc6?=
 =?us-ascii?Q?OtNZiJQcXUnBWoiIbJMEhU10uPLJOHCnlYhamy8ZnBcsaSUpLwp0mlgA7EHa?=
 =?us-ascii?Q?EVFy7FpxONnCgGRksYmatlED9rW7NzMFaMBpVX6Ak7bNGVeNJd3L77zuqYwI?=
 =?us-ascii?Q?1ItzyzHZIczgRCO86dj4L5X9CTli55zVborjNRVGn52gzFrPsIHqWqWYsK0I?=
 =?us-ascii?Q?ANlfq89TXP+Vz0SWDLLc/Z0iJopLB3yqxEd/Rl7FqsNJxuTlJmlXHgpltJO7?=
 =?us-ascii?Q?RHeSPr0xMOshEWNb4EuLBatBB9OFwMoV9vcLK4MUUNAKYmk4PTExtxiDX5ts?=
 =?us-ascii?Q?6LHDS+WnM+CvbHrm86nB4sjIcOk/BlXpnLnkphwqJ/vVhkIbJJGau7UWBJgR?=
 =?us-ascii?Q?uA708DSu/OuQebinnTkJ23Y0bT3HmuiWG73cbZe53yxC920AsviYuPVk0NBN?=
 =?us-ascii?Q?yP0wCJ+8OspjfRPZH9XKQBgVQQu3nPpDx6tIj34xOcnmdZFQekyyngKHLa/i?=
 =?us-ascii?Q?Q722CFzoeR256lv8LpaOPRC8eoOBOrUjhW3o6mcmr2a8z7kRegnRLMceD1vo?=
 =?us-ascii?Q?+PYk1QQO3J9wnIKWLNrdVkv6dBDL0Dv2NinPBFtQbykSaoQ1ydsQr0aDjqpE?=
 =?us-ascii?Q?t+ci8mVmtspql8/2FgQBiIZXDzRDfE7Qz7vekxAm6OsfMmJxRgjUBwdHaHnI?=
 =?us-ascii?Q?HO8cGvMrT7eZc4VBHZKJ1H9WVDzIbso/oFQcjPFcDSWR4nVukR+id3H69/a+?=
 =?us-ascii?Q?Gw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d753c97-bc67-4514-a85e-08dc9419faa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 06:50:47.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQ9zIFM7BmrriNVFS4coHpSuNTD9avB9OFNlJ/ZM9mSM/6GbNW7ygZBHlzxulhuDHHKV9WiHOsP3yedo7XDsaXFD6LBTsBrnDIjzkKaaYmgonRiyqi7LUZpaGM4q5nff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
>Sent: Monday, June 17, 2024 6:54 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Jiri Pirko <jiri@resnulli.us>; Temerkhanov, Sergey <sergey.temerkhano=
v@intel.com>; netdev@vger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel=
.com>; Drewek, Wojciech <wojciech.drewek@intel.com>; Nguyen, Anthony L <ant=
hony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com=
>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.=
org>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1] ice: do not init struct ic=
e_adapter more times than needed
>
> Allocate and initialize struct ice_adapter object only once per physical =
card instead of once per port. This is not a big deal by now, but we want t=
o extend this struct more and more in the near future. Our plans include PT=
P stuff and a devlink instance representing whole-device/physical card.
>
> Transactions requiring to be sleep-able (like those doing user (here ice)=
 memory allocation) must be performed with an additional (on top of xarray)=
 mutex. Adding it here removes need to xa_lock() manually.
>
> Since this commit is a reimplementation of ice_adapter_get(), a rather ne=
w
> scoped_guard() wrapper for locking is used to simplify the logic.
>
> It's worth to mention that xa_insert() use gives us both slot reservation
> and checks if it is already filled, what simplifies code a tiny	bit.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 60 +++++++++-----------
>  1 file changed, 28 insertions(+), 32 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


