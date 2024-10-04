Return-Path: <netdev+bounces-132108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F799071D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC681282116
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D88155A59;
	Fri,  4 Oct 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYzLtNR8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1791D9A60
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054317; cv=fail; b=YokCb4Fm3dS739Q6zEC3XU8GMokovykTJJ+KE48MyuweJZXlKIV5/Q8T4295yo7oZoNAx7fSAsJHeLR0uDFoQLxMQRaMRgNaBZ7WxzX6KSAw/e8V4skZHiOwde77zAuagCD8CeO7VTIVuYVH1Pc3WzzQuXnH4cIEomjf50HJ9kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054317; c=relaxed/simple;
	bh=ww27hX/80Hl9+psRqOTcHqrHOMZvmFIOWoYWbadVIYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dg+VFVe6C7lcZ5LX+ruJMvKuJC1wI91RnnDJQeCinQ/Zck9JGtgKbgGhirZofaz8YP0dn4FTTOQNaUUyEUvP4LOvu3BL02PMFBa/7oTsKaYbrer7jpnHAwHmkD111YeonbPt7FgFeHXHwYh6s/qh05tmSxMJymswS14e15XrHI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYzLtNR8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728054316; x=1759590316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ww27hX/80Hl9+psRqOTcHqrHOMZvmFIOWoYWbadVIYY=;
  b=PYzLtNR8sIWYZ3xTgTV7y5wg94tPPgxaRYKM669s6ygoHeSZuUzebh/V
   U/AYcQN88RhQUfqy5Lh8kd245x13XRQVaodxlCVdC00ykqmmvgAOXqafD
   B9nxsctuYnjiJlOZKvR1IxepOKnC+CyPzdVF5LCXvzE4engsv77XLr5Ul
   Wvq9Bli/gajFdrHaAVZpgh5PPHpeFrYgM3DYpuail/QvauGX9/QLhzcFB
   CLooOYqN6mAmI8s2op4J/OrUlnXy10shO7IdhvgCpRfEWmkcX3wMP+RHo
   3e2g7C2g7MRG3tSwLXdzZ8nOLd+scpTrGAzv4pHS4eUeXvT3zHtk1Rt2v
   A==;
X-CSE-ConnectionGUID: SRiQKZm1S0+s9U/qL62hJg==
X-CSE-MsgGUID: qkkEQdaQRlq1wWOSJ8mStQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27369986"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27369986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:05:07 -0700
X-CSE-ConnectionGUID: Z2CweQoWQ9+bf3HJ6oFsjw==
X-CSE-MsgGUID: ntK4ZNpaTe6jZq+vz42Ofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79302849"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2024 08:04:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 4 Oct 2024 08:04:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 4 Oct 2024 08:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DH40Ob8X9LXLPzTWuxCKLJQzjIag0kCRRCebNk8y2zNE6b5LnPFTqiR0DRGNJELqiqZZyjxqRuwu0MlXnoccEPr8Xxf5+LG2qH9ov0QcCn58ndJJlNvjb7ywnTjEnrEqoPYftc3A9OYUuE5exZDUT8oE9Z63rTIXoa/x7xlkizzx3s4jNsOnh4vWANtpvDVSNRW+h+GUq8MTmoU3O0EMqUoF99nc+DYJTghY0n7p3D7aeZAnbtLMWEnWM727oDjcazlt9hK6kyggFhTYiOTOg/h2Qu7cGptJvi/7PE3gxzBfGN+dnpYSohDAS9Z97Y4HvdQB8aNO0M03Nw/G0y29ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr0l8qA1Kgs8FZ2vScef6a5Xz8kX74YR+KXMeW8tlMg=;
 b=Hz/vmDjKzuI6bXCUE+nHBHECNYn0H2+LI9yGdPxQS2QNPKK2MvLJfiufyH/qmghE1DMicXpo/+xX6f+SJ5wLa8FocgV5YVMFnyFrWsL7HhX80fpK+FEUxCKad3USRshJiSwMC0v4qfGyAAeJJoqxNj843pftsSswh5Fd4IOFgyvLHwP27p9VSzpLVlLUWVZjZaKAzLlmf1gfrVFIm62Y3Jk0kWdakVuv1tT4DgBZsYSXrG5KFg4ESWmgTc36ZReaho+N2fgo0Ez/uw7LZIENUemrONszfoXZZLo6eMcGfXSUtSw5oTsq7ALLiv82hni2Ss0nzT8bJn4R5fkMfXtAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:04:56 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 15:04:56 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v12 iwl-next 2/7] ice: Remove
 unncecessary ice_is_e8xx() functions
Thread-Topic: [Intel-wired-lan] [PATCH v12 iwl-next 2/7] ice: Remove
 unncecessary ice_is_e8xx() functions
Thread-Index: AQHbEzKeyWOJ51m99U6YN3ICcCPwhbJ2s4Hg
Date: Fri, 4 Oct 2024 15:04:55 +0000
Message-ID: <CYYPR11MB84296AF0C6D895037E5FB53ABD722@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
 <20240930121610.679430-11-karol.kolacinski@intel.com>
In-Reply-To: <20240930121610.679430-11-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8771:EE_
x-ms-office365-filtering-correlation-id: 14da73b3-e4b7-4e11-b08f-08dce485e85d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?w1MHVQzUHXtXQh8bdYaxmDd5iFijEWmXuF6JUVxKyT4vs9foWx0tHg41PKm/?=
 =?us-ascii?Q?bARQ6hWu81cRP8/HFAcsLln5Q15xM29EA1ytB0luY/9PU5+c0tdHRCBTPsvk?=
 =?us-ascii?Q?KyWBQwKvgQXaMdnHdvRKWNtw0s56Zagcawrt9a8VGTl0SSyQkZgEV0fW0WuX?=
 =?us-ascii?Q?tOWCYEkalTbBUK/CCGAvI5nLZ3ZsS9ZZF0XX9vLoCDZsDrxXdI8bM6cbezI2?=
 =?us-ascii?Q?9Jy3BV3mLZuk3LHyV+/vCpdZpT3YjXrEVZM9VJBWwdGYPrY11fwPV4cNBTl3?=
 =?us-ascii?Q?t0XMH9ht6M67JGiA287Uv3tSVn+sa3QqzTFRqBQ10+I1Edf1HsKieiIs+T1c?=
 =?us-ascii?Q?DR+GqE/SyjaqLTYsb8KU10tL+lJ2X3ciHfVDoOnkVp//yGzWxQyks8TRVAOJ?=
 =?us-ascii?Q?7v8pHzw1ccabJd8hgGnfBSgkEr30k+o9gjC2KftLnk+e1EDM+ZlQFXs6Kmlc?=
 =?us-ascii?Q?0tfuLybbQTtKzEIz+Byi6AXpq15LDL1S7y+GqYfzja+RSpikacLLzUulq73J?=
 =?us-ascii?Q?VW3zxZv/UaHLunCL91tbSJQ0qzFZ9ut5Nm076/qudOb8wpIdaz2S769kNDt0?=
 =?us-ascii?Q?prQShxzMRfYEL3/c6w+igrZR8pRMMf+22ptkiuJ9S2lXeNaS17MOa4qVJP3a?=
 =?us-ascii?Q?KKo2KRwbxFW7CPnpwTDG0PMBMPhF0E8HSPu7Ha6nQMgc4VYC//kUhbGyN5S+?=
 =?us-ascii?Q?wTZCBTP3TGHAnDDhSGkeflsAi7Q8ZnAAyFDBImF1ZsZZEG13AEQbwLHJaHMk?=
 =?us-ascii?Q?e4UrweVBR0c1tMJ7a0LzK2+3ll9foMcyBDiBT0zdCVXR01IEEYvzgdTdZHmK?=
 =?us-ascii?Q?U3EWRszyWlJHT+rNzFnuGn7ykvrOilhtgiqp6O93ZtNWkyp7ivKyu0rxs+uc?=
 =?us-ascii?Q?ordM2tc0sBpWRdqOcLPUZM+JsMpbcdS5EyMUOe5tzQGi+jBL9Wb6bdneyTdQ?=
 =?us-ascii?Q?vENiAdACUUvGoiFZSpxy3lFYxusrT4B4WWVtNAF4A8iYoQU6MZex+o1uwwBF?=
 =?us-ascii?Q?UZt/FH/FNDzwlMxYwtuGZNtWd/xKgn/VEycsduTJMxvF0gCbiCpUcyMT30jc?=
 =?us-ascii?Q?723jfdkrsYeSkr1jlAnt+JgWPhUeh5mN1J2loAvkJeQfVwGPWiCZRmWKCA/m?=
 =?us-ascii?Q?1EZpAhtWLpM0I7SepM5USGzw2im9Xsx2gaCH+Bu/ZhHVP1BbO9XEAa2FkOtY?=
 =?us-ascii?Q?olxIJCBJ8uyH9yQzGSXE8qTpgaMNlAqpchQvd7HWILSXl6gRbyhJO64epG35?=
 =?us-ascii?Q?A0OA3EGZaiNuijEP2csqgDLyxhHuNeesiUFJLyp1sbXo9IpHau/uowF/YIX/?=
 =?us-ascii?Q?k00TdX7fxiqbjkINqna1hDASuWkmizvuotW3bgsJvb2X5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUh1ZnQ6kJZGth5Z/u9xa/gCAfFTYzuRnYsLQmO36VOADm0vBKPZk9W+hbDD?=
 =?us-ascii?Q?ilJ1kZUEnFmHMYA0Hn6jp9qhP3TwYZe/VZXNiQAdeo8EevqSqjQoaPkgTL0v?=
 =?us-ascii?Q?eHPx4j6KKCWrcXwTMV8tlK+MIl4z0NvMD3W/cmtUpKkkHmVm2ECgS5xtKYsH?=
 =?us-ascii?Q?W+cQOk/RQjABh58bKCYtpnJRrFInXjIECBoehNBE7D4YfA9bsgL9hT7ciS52?=
 =?us-ascii?Q?2SjWMwsR6E9FoJN9hJkgweMYT7gjvPYtamoHOtAd0xiwUpTaRvZ+CPryAqW2?=
 =?us-ascii?Q?HxAMrVgvZ7I7IadZyxbjA5Vtg1AhTFnChqk+FmfH443yeuTp6KIwPN52K6a7?=
 =?us-ascii?Q?KQYycMgUqXQek9k4Ulq+tY9Gi5AHgBg/034qUUG/NwKSieZY8Fy5bF7LkbkE?=
 =?us-ascii?Q?PAaQLWWHEVG6irMYmM/4Y1wAgG5lgBSV7/Jx7mY7az3WLyelwmtxRhpXKxKv?=
 =?us-ascii?Q?dlrBWvSO4g29aTjFjb+d689ygghex+9EBEB35u79hYgzhU6sj1JpS13Sz8Wv?=
 =?us-ascii?Q?gOVheZsYh+ro4C8Oiz+FDXBfvZO1SEFU7EAI5vGA6ZzTE6AE3c19jkbxWhGn?=
 =?us-ascii?Q?U3wFgLUJYy8EPJFQl6k31gt9ECxaPAB4K0qajLwfl33HPF7mhSgLIJmArVqo?=
 =?us-ascii?Q?T+JHJ4eIt7WZSDACODuHlZxfN9U4OfF3olZW0KQ5Vkas4gLGFvY20IAfKkBb?=
 =?us-ascii?Q?pSw+kc/xKvqHC/LZHmarHSIYTGwjMcTduapG3cUz1pr7tofXGXDy+cYCHFdN?=
 =?us-ascii?Q?Ol4dKCIzLfqO/V4BreJMH9aTqQxKfBFdhmOb2HyZemc8YH6YC7r502+6Oz9E?=
 =?us-ascii?Q?LeSWXciwpW9/r8pYkYHGToO1BBZFuGKmeNl/VZzCfF+hw5PUqFtNbcThiwdd?=
 =?us-ascii?Q?NGfFs+L8j1jS/twAEQcK4I8+huOKdaYbyFvIcvfcE11RJORZ15AKB61TG5Gh?=
 =?us-ascii?Q?Vmsag9fLnBj8F6QTKbFVdlUDjcxEoqkbM267gOQ9gSBZ+F9Nk7qsBqG5m2ka?=
 =?us-ascii?Q?SYjAi0y1yUZkpUjk4NaF4OFtxlPIwPyluGVGYYOMFOItL4nj3woVsbK6l/N+?=
 =?us-ascii?Q?V0mKtxXlwK0SWHCEZEiFVBDUpnod+5u9kiJPl+v5ncGztVYmzpvg+NOavQWa?=
 =?us-ascii?Q?E6Yz9EwIo3E2VEB8oQ4Az7BXaaVcLLgUdBVC9Ye6eX0DCF9r0vN5QjilRjUa?=
 =?us-ascii?Q?OPy4CqHjpj0rgNW6TZ9a+i28F2pNyzciQ2+xGw+ux3RBQMo5wj+tgJ8jH7Jx?=
 =?us-ascii?Q?cyY0hVW/5jh5mZa5JKceLES9TBWkdfPY2OnDglhMDZo2s2hm3O0JfpX65HOy?=
 =?us-ascii?Q?XqVN/+6w4zzl0lzBoh/29ciPYfEoGOt/vxrwqFlvHP31/7vUzHd3NVgU62G9?=
 =?us-ascii?Q?MWQlELhzSuxM1hochgaj2SCQjmgxDI67IrQTd+uuPHiIXuYRejuEmxp8EyUj?=
 =?us-ascii?Q?3tWGl5lIOvMY6SdBVh7hlOlfglxAyx2OBFbDZj3LyRq2QxClHQ8r5wpj2D9v?=
 =?us-ascii?Q?8jLSHokleZoCBkSO+8NSsAxBhsDA7K93+e+rg5g4wnl6p2S96cdG7bDZB51/?=
 =?us-ascii?Q?qYcvgOjRZZxzeR0IA3wRoDKaJ1qZ3CkRF3l+Vpt57rEoFw+SlLaiQIK2AbiO?=
 =?us-ascii?Q?MQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14da73b3-e4b7-4e11-b08f-08dce485e85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:04:55.9956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM3ESP6Ff5tyPJ2WSlvSmOLwyjggyeMtYmkKbIuR/13ajKj2LCTYd5OkWeqJFX/j+/M1y27hQjlEsLfrvBiizWRtIyIktRUTSh3Tj9JCD/Gb5OvB7ulqP0VLRJ7bio/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, September 30, 2024 5:43 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <prz=
emyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v12 iwl-next 2/7] ice: Remove unncecess=
ary ice_is_e8xx() functions
>
> Remove unnecessary ice_is_e8xx() functions and PHY model. Instead, use MA=
C type where applicable.
>
> Don't check device type in ice_ptp_maybe_trigger_tx_interrupt(), because =
in reality it depends on the ready bitmap, which only E810 does not have.
>
> Call ice_ptp_cfg_phy_interrupt() unconditionally, because all further fun=
ction calls check the MAC type anyway and this allows simpler code in the f=
uture with addition of the new MAC types.
>
> Reorder ICE_MAC_* cases in switches in ice_ptp* as in enum ice_mac_type.
>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V9 -> V10: Fixed E825C MAC condition in ice_parse_1588_func_caps()
> V8 -> V9: Fixed compilation issue after rebase
> V7 -> V8: Added reordering of ICE_MAC_* cases in switches and explained t=
he rest
>           of previous changes in the commit description
>
>  drivers/net/ethernet/intel/ice/ice.h        |   5 -
>  drivers/net/ethernet/intel/ice/ice_common.c | 120 +----------------
>  drivers/net/ethernet/intel/ice/ice_common.h |   5 -
>  drivers/net/ethernet/intel/ice/ice_ddp.c    |   4 +-
> drivers/net/ethernet/intel/ice/ice_ptp.c    | 137 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 138 ++++++++++----------  =
drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  20 +--
>  drivers/net/ethernet/intel/ice/ice_type.h   |   9 --
>  8 files changed, 155 insertions(+), 283 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

