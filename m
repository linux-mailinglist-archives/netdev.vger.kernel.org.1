Return-Path: <netdev+bounces-119549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15A7956249
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 06:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F251C212F2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8411581EA;
	Mon, 19 Aug 2024 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwFfyijI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8641C6E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039903; cv=fail; b=LAKngKJ+aJwC3h2pms9z17hTXSMHOW838w+QgwUeFmNXkhkx5UU7JgS3njK7FaIxL24iGYTnqSBdFq/f0+OaFyuAJp1EidQWK3TgytulctyRyVmtyUYtHlNu0gENiYUoC4vXWHbkAtKntoqDJNi6ZwKMheQ/oc74aelvGpwsbn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039903; c=relaxed/simple;
	bh=KlK7MnNjTzTOKko9QCrDoYIN+fCGrpqB8uY9ur9skJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCyhAWxqtRy7Odze47L57N7bvzRTkHvQquP5DTaRcrAWLwG/keO5rs25NZEtrvDkXx2XvbvowG4zVZtpG2jls4MD/JcAU06bQGX+P9IsGlkwp9gsJXM+eaDlakmppOtsfjnQDH+HKOct/HWVkGg67okNjT+azHxoxjTYf+SWhII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwFfyijI; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724039902; x=1755575902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KlK7MnNjTzTOKko9QCrDoYIN+fCGrpqB8uY9ur9skJQ=;
  b=dwFfyijI72x/MWDnUvG3u4t8xKkUfL9QaP+jKNAcV2v8ykKc6oJaKwtX
   WDN8sotwTBMalkLzJtHEIwOZ0+aVciAlRebwJZ3/GlRQL9UR8I+3as4sf
   zqvZJlqqc+aEjNmcNvWfYDaUDfu6JHF9PXG2lZXWmNKYVxGVcwnGFGgd+
   TbGktOb/cswFJzEfU4sQnY6X43+MgBakTgLllRfKgKGza/yEJ8SuwuPya
   GRQLL5mrr0TGLTGY/x+DZS74nDXcO+0WeYmQNY1TlJY5PFdqRw7XMnAEO
   7lzxu6p03H/tY+hlPfr5owWhqGiGV5hfTBpKx2qoP8uh4+CfE/tEQTCuz
   Q==;
X-CSE-ConnectionGUID: UeIRKG4TSNCv7JXV6aO1jg==
X-CSE-MsgGUID: YMc1P6BZTpaR4p2aRr7tlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33413796"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33413796"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:58:22 -0700
X-CSE-ConnectionGUID: izNDgH2pSOeliSK7XZT8Bw==
X-CSE-MsgGUID: kplRY1T0Soubafis7HFcpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60523847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:58:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:58:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:58:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebQmunJLq6JGwsAny4PTgHl5Vb6KsC08qHuqNYfnX1PTnLaIutAp55FdLqgKkMZqwiiBgodIqjgz5YL7O7xYD+mSA0JzmmZmbIMla1mZCWJ2+813Na7wzuFZo50TBWvyR4MRuED8gPh5vmcHLA0f0vv+U2t+pHlC/H9DJ8LvTemYJy78vCbJLQW6A0HYPZSbAC5Ey41z+PBAmh5X3KLgJJPy/WzBOIL3eig8lO+ksqDG9QPewklC+jPpKmXfLsnI09KVj3YhOo+y300KQk7UYDVJ+ayksJ0fX237S+0dU4VJGhZ3CHkCyppJ0lkxyhfwPCpEiz7quhK0bZr8salKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q+xQMPB7Tt1dXcW0Xgfx3G8clLdFC0ikZShS8OvGEs=;
 b=u/g6Ow76+MNbE4TpKy5iSiZaiQjmvwRI8/dJe2ftCcuKtggmtENnGGghSkvT2CiMgDgEW90IvboB98/pX4GpQNIB9O5yiV9rSI8LcEfqO+eb98lBmj+X55EHTLlXlIM94dudJLwrLsxVJE8cE8+bXXCTFpHBB5vmzJIk3rwYyy37TKkqgN/ly9FvN0dI+aCNm7wxtYAb5D/9Enxi5yZ7OTk2kHRYV/SYAZ3bG5zfO24qSWupBLwRfN6tBRiRq8woWsI86Cd5c+btsLmEoa6lpjzyRfCRevgpyruSbK6ItvL7bHojnLBR6LIEKCBuLGF7klKK1zWYkKyd6yIkmVukcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Mon, 19 Aug
 2024 03:58:18 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:58:18 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-next 3/7] ice: Align E810T GPIO
 to other products
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-next 3/7] ice: Align E810T GPIO
 to other products
Thread-Index: AQHazIYsWMaIenJJ8kGMcC/sUTsV37IuPR4w
Date: Mon, 19 Aug 2024 03:58:18 +0000
Message-ID: <CYYPR11MB8429235C7F22ED8ED713B410BD8C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
 <20240702134448.132374-12-karol.kolacinski@intel.com>
In-Reply-To: <20240702134448.132374-12-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6792:EE_
x-ms-office365-filtering-correlation-id: 3c517e49-6a40-486f-702c-08dcc00328e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YAIWtfhrhrV/iBHnoEw9Z0aGupy5TtONWkrqtlPC29oY2kypgrtpMDv1jG1p?=
 =?us-ascii?Q?FREQmMcVyQ+TCZzmbkPlHLdHz2rTPFSw8mIWt2XFwGjALczMUHQB345BOKUL?=
 =?us-ascii?Q?raif+0rV3zjKwRkeitIg9ytAb6ogskvAvmp+9is7/KPU16if4qXCJCCFjNbC?=
 =?us-ascii?Q?qVUqK8cQoeIPzcLFcr6JitrZdog8R1ywjfl1KgCnBLD4VXFs1U9HbdSYHE+S?=
 =?us-ascii?Q?FryGU4LcMgGJN6WGJGGfaOsyZilGHkJnxC6eHLByrdgKcTwGWYx+ECypCNR1?=
 =?us-ascii?Q?aMP+gOm+k8eCpUXeqI+34aWPVVnXzMtQwKCY6a9hHLjffH4OiJqlU5iBocVp?=
 =?us-ascii?Q?TQFtIFN5yFa28rnYzFhKyAUfJY+j56TfsJzMpwVcwAOkFg96lX+kJT1c247W?=
 =?us-ascii?Q?HX0gLr/30F6owUGdJFVD3mED0mG4/1ejL+Nu1ssbhniIlM59hnKTRYNvyWbR?=
 =?us-ascii?Q?sqTHvzsTxrxS6b/Wu4fQ4m0BbisSYZnqzv99lF2gPcYJiF4ye+OktW5r/VDi?=
 =?us-ascii?Q?j6gF189w0tNR0ndeB6fJhpWqI1Z4SdaDh92SzggWm4G8DOWwYpDE/WDirCME?=
 =?us-ascii?Q?TyzzOekg8gA485FX0Lq8acQKZnAxUMDy34FafXZ3/PL79SgXi57nUt1mMCHQ?=
 =?us-ascii?Q?VUIv9l7kaFRumE2aX0dfHGgtjWl+XTHrKGm9syJZkSYMeX7aZi14K0koFoqi?=
 =?us-ascii?Q?xFXxMwon+BVM2zypKEQ7QtKgpXnEIhRoLqdy61Llq1vwDd8x6zWQlhFpJZAM?=
 =?us-ascii?Q?vDGcmLPlrlPJYctU+s+zTexXH7KAND93RUOE8Yv0LcJM1azvAEhu0EKUGTwz?=
 =?us-ascii?Q?ZA4SMCc+C6peXekXD4DegpasumTYbKjPbfSc2mOuX60qZIi3XuyFKR2IFYa8?=
 =?us-ascii?Q?f1IZq6/0DcVIGTjIWXRLOn59q+6/rU2gUowgX1gbEbQSjFPxD9wXOPW9onJs?=
 =?us-ascii?Q?w08kXb+DBINLtu5U7ILscWf3x/1DWinV8+oilOu96IyBFsLIcQ0z7QxC98dy?=
 =?us-ascii?Q?qP/yahP7cWqz3U2CtPodCZkw4EyWk7yEeoEb6miSkCwiXfRS7C83UWedIjdU?=
 =?us-ascii?Q?h8YcjRFc79d7CAPi1aom4NmW25apVzZcLpxT91VblnEJTtFdt2A+p6vRxd2X?=
 =?us-ascii?Q?zp41Z+ljbfy1EtAkOCXBQBjXnPBB7COz9GhdX2EpWLz5V2fK+UycLimOGSta?=
 =?us-ascii?Q?9DDqbudauDWVSkj8j5h4xCTw2VhV85ldwOsYTqUovtsLS681n7oejwXVqsXe?=
 =?us-ascii?Q?Xa0zYGV8BVBUJFc/Z0zuEi48bhRCLJfWcGAFLxtQfOMYkRSpjFgFKOG5C5GQ?=
 =?us-ascii?Q?cPgbmU89Nc71CbqClTXltNWyIyIqJl3Fn2L1yZYKCfFHeNd17qtFmBVE4ARq?=
 =?us-ascii?Q?SxmKUNPShCKibnh6h30QPhNKDIlf0DAPy5KY0hczjjKBRyzJhQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YV8+oTWqCmDJGtNTk0HWdwypkYVh+0xR3+oGhr0nO7xPmreJwXjV5fl9Pfr?=
 =?us-ascii?Q?1APPblr/sEaM2QfCTncSC2d0qWpUoqgT0A9jkEpfHkfztn/2usazrRWsstfz?=
 =?us-ascii?Q?LtNAZDQ7tFyZNdZvBrGNft+0ejJ/r1d2JiT6F1LfQ8q+bFoZq/regQIIPO3a?=
 =?us-ascii?Q?2BDMOlZ9o7kihQj8f4NZ6UlOw7DYGq6j29Iqt9ceUFBl03btlcdEKQnq1nlg?=
 =?us-ascii?Q?aNicaxyQEUnsZTVcn2jUhnLn28kJ6DOa0V1HxH4XOnaK9GrVseLvcNTYWQtK?=
 =?us-ascii?Q?3LP1H0l30jZc8OovrMlq8AHU1F6hR1l3LDzN5FTLfooxFeIvl4yen2+DlY6a?=
 =?us-ascii?Q?9/3rOecE2XjR1PfJxe04yX5SNIb723AvDlWlyZDZpIfIBPofhSWTsT2c+knV?=
 =?us-ascii?Q?olvKepE71SP45uL4jzqjwnhhMHk/v2tTiK0GF9o4e3+DTNtiNSQ+Q7nCMiox?=
 =?us-ascii?Q?UO6YiDx5YBfhT2mBehwAqdJ4oQ7iDVPS/PdCp9vas60101xFRZmm7r39u310?=
 =?us-ascii?Q?TUpeAK62k2Rw6p5JEcDCDWL/6RgdjF2EP7rNUf5m7VBC8kM/8BErS1QOPPWW?=
 =?us-ascii?Q?3aGYPtKP8d6yvlgYhPTvEhso/skLSAcOdYsPsLgb4WEjqjD8u0OtFT/i1XeD?=
 =?us-ascii?Q?mJEIv9P/T1hJsIcGEOyiplYdUzkgEsabiYm52mW/ZfyxD+nEzblF8+5CK7e+?=
 =?us-ascii?Q?zfQE17DEvHZZCrDSLwjR2ydMnV3HgIkhpPh8Aktotij8buhC/Wd3rD/+DfLJ?=
 =?us-ascii?Q?g5jKIvHDRKMMiOuJkUTHENh08rVkJfrsqsh3OjIPfNQua57WkBlKUSDO+DYJ?=
 =?us-ascii?Q?KrPGLQusgrpP7vaTgEbog5iER4DQJjTfF/SmJeFf+WIW19FICPV5ZCzo7Gr5?=
 =?us-ascii?Q?XZs4VEvWS/JiEQlzTVHKrkPW7Vm8zFWIBONZBlXw0oGbCvn6NPkQQw/JQpLR?=
 =?us-ascii?Q?n1X89Z984hxTlg6M500gcSM6KbUjs1JriSw1xLdkQraHlrUyXbQlI70vxdiW?=
 =?us-ascii?Q?IlXjlZNZHn+Mbe6vxEMdx7Szame/1WWhtAnLiJPAn2beMA8Aso6axNaTzEeY?=
 =?us-ascii?Q?V76ZZlJEHy/VOqzOiAcKkTjeV11S9PSxpGBsZCj+mQXN7y8gC4i0nMMWIwZT?=
 =?us-ascii?Q?e3YvvtLQACvuyhk10pUOG2cLjwU/lneU4Fx7aDowUCM/ZtXtSgPcRm2dcCV6?=
 =?us-ascii?Q?mc+Xhb+3YjeRyQpGW4jfdSdteGEWpuem4P+MdarADbxQT3lUv1Alr/jrhMN7?=
 =?us-ascii?Q?VxluLkizfBi5gS6u8zjtDwNcyXmwzx+gT5qabi9odWc7PEJDP5Ez7cDCbM4A?=
 =?us-ascii?Q?2JMY+JJ03X+2R+vQzLede7GN90QAjTY8j4v0TltO5pJ0V9DpdRQtzdsrFiPp?=
 =?us-ascii?Q?tDYzM2mcQftcEu7jX7DTA81WSXBVzlwFatt6a/N6INZ3erQsSdzb6jNgHq4z?=
 =?us-ascii?Q?H3l+MTNTLXfcwpSAay4pRFqm4GaeP/yPVpM1ZF0thMkdcBURv5UowGh9Fca2?=
 =?us-ascii?Q?SPZzhN1YugU6LQiII5b8YnaV0zqsU8T344N4LhBPum+FrkRUi1SncLG2leDJ?=
 =?us-ascii?Q?HjIfBilI0nnl3I7dWtNUPTyhdGplBbeU/WHL9+i1ZeFZmr1PQ7P6GhhPbdTP?=
 =?us-ascii?Q?Xg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c517e49-6a40-486f-702c-08dcc00328e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 03:58:18.3189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxtifVzuvdslq5AAnLgDEeg/+GoTIS5V0vrvTS+oUs0CsZ+d7tNHRERrFj6IBG6Zh/v+yerdmJ4rAvhn7zYfAPFafd2YKB02u6cltPS4tV5wJKu6xJMtKnEP+SU+Tkn5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Tuesday, July 2, 2024 7:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Nguyen, Anthony =
L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-next 3/7] ice: Align E810T GPIO =
to other products
>
> Instead of having separate PTP GPIO implementation for E810T, use existin=
g one from all other products.
>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: restored blank line and moved enable and verify assignment
>
>  drivers/net/ethernet/intel/ice/ice_gnss.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c    | 464 +++++---------------
>  drivers/net/ethernet/intel/ice/ice_ptp.h    |  29 +-
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  20 +-  drivers/net/ethern=
et/intel/ice/ice_ptp_hw.h |  43 +-
>  5 files changed, 155 insertions(+), 405 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


