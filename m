Return-Path: <netdev+bounces-174093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A73A5D64E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6F8189AA9A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F51E4929;
	Wed, 12 Mar 2025 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIFFFXlT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6E1D7E26
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761207; cv=fail; b=JHRvDtCd25dK8guAjWYXGucEYAdQXcTnOT5SJrwmiGD+gJjv3pkv0onk2x1xQp2QVh8bqHdOl4fICVYgaUKxxWbUQOBZiF6rd6pd0sJjOP9ad8rDpgPjDCBJkqJKmLCv5Fe4xLn8D4LIoTNg2uwQ5dj6tlJGa5RujtuoJSJ6an8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761207; c=relaxed/simple;
	bh=jSRb0dHVcU+78LVCbYuXi0Yc4ygv2/h3JYtVy+Qbjwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttzVHPWxQsrpyjEyx6Vo3sz+OPfkGE2MO8XTDLK0yx9svNLFwb+FAIgCB1z3e/9oIcHtcW2CdUge1cqWiIEajNKYwImgqxQ91Obk/io1TbzowrQbSrpJF8qzqeggzLUehkkuxqaVJVZY2VxcuNJyTjyieKYhAix5hwdPTVEWavM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIFFFXlT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741761206; x=1773297206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jSRb0dHVcU+78LVCbYuXi0Yc4ygv2/h3JYtVy+Qbjwk=;
  b=nIFFFXlTgFtiDvxjQ22rT9J8F6WucmVd0G0t61E219FGzowt80QyVeRW
   b3mGk8DNrrZyBpnhaTjWdrgvZnRnuoifnF7Fh05szZiLLwzKt40FliIXE
   dENTt3p4B3kVLtFi37Bkii4BNI4U7Ao7YyTVNgbeYlceUu+Dcm2TqjQpw
   8doWAvkWyTX6QKilCdb4mPzDNupGVcje4GDLMMOh1PP6Q0c5yU9l7/OeK
   mf66C7FFU6ZgFSXngwmcFglcOX1nDKtGfApW7VO9RNWAvS/A6ml4y2hOi
   FVBzq3GvnmFYbX/zDj082TKu9WF3FZJ6sVofPX0PYkZ6dD5uZg8JnKgbL
   Q==;
X-CSE-ConnectionGUID: kDfeh76FQfK1ZXYx1q4ZCA==
X-CSE-MsgGUID: j/YmNLzeTVWpusY/vZ1zEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43030952"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="43030952"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:33:25 -0700
X-CSE-ConnectionGUID: MhIBYIVeSj6HlocEd1176g==
X-CSE-MsgGUID: 3hce/qKZTOu61fmmHbb+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120571831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 23:33:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 23:33:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 23:33:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 23:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef6P1TOGj9UjWNQVjSA3yklXGLx6tG0mYmUjs447crxj+vbgozNctGuYnh9Mlz0A2Cy2bj0uVxvnpzfMG7FxpAoDvvRwwNeaGfrcjYU58Yvc9vxUNexa5GsuxXDNAHpATTpnAqbbnhR8THbh9wkumPlkzSl21m8qpV+Smp1ceC1Kp/lOt48/9jn4ZjH7TPrRIP3JTBKqiiVhxi1BIHWxsU7QSUcObW7M0/oqkr1Nbitt8/y21WebbSvDd7rjLn5+f0pfYfE+PkqhUzQDsRfYrbT+quRAx31VyBoISdyToz4kvIvvAl4QnoQ/5imYBv+5ZTFIPd0suO7BP/Xgsr4riA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiQqqC9HAUEkMogCKhOhRyYOtV0ZE+Y9HqYR16FIRnA=;
 b=bf050u9cH8cYhVzgeOCKZLeiDZH6NRuk6WLIMgK8DcvVGmbKHD8fUuJXGU1LQJuv7Jiy2jhcx3ZCEgRnvXrUctn/sCC9l0c4G2ciTdpk6dgAncJUHK6Fu8Np/iThwzASEl1n5FQ6BbJeEYARyCznr8Ixww5PYuORp4eOPX4zBTpjg4xAzpaK3kv1cmY47gqi+orZDjedVHsG4byFGdu3oXwkXCY2lbftClqurEjCiwJ35WDNpWrqsdIzhf430F0fxftjRlWFM78mgtSX7eQzyhOLxmVLmDDgWAC42dbTx1Sd+zJkgjyE68j1/lzbeCWTIFdQYtoeFiL/ONOve0wrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:33:20 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:33:20 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"jiri@nvidia.com" <jiri@nvidia.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 04/15] ixgbe: add handler
 for devlink .info_get()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 04/15] ixgbe: add handler
 for devlink .info_get()
Thread-Index: AQHbj26wDzuBitLa4k64DLbEyNLMVrNvEjsw
Date: Wed, 12 Mar 2025 06:33:20 +0000
Message-ID: <PH8PR11MB7965A3566C18C303D3AC8185F7D02@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
 <20250307142419.314402-5-jedrzej.jagielski@intel.com>
In-Reply-To: <20250307142419.314402-5-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH7PR11MB7026:EE_
x-ms-office365-filtering-correlation-id: 6c23ed66-eda3-48fa-9854-08dd612fc7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gfVk+UI9gLB2jJZSi1t2GpsUrOWZQWKjvxo5tAtDZecW1x8oAV6amK+WFfOh?=
 =?us-ascii?Q?gHaaA7ycphamUF8tBuyIDXUe6+anab4bmlqGIvb2d2Y53kmVEb8PEf8Q/nSX?=
 =?us-ascii?Q?RSllDtxtwFyfoc00mh2oO3ZwOccn8Vb39qysbwYhRExuA20PDoDWl1VqrFHV?=
 =?us-ascii?Q?8bWGHPq3YtQ+zFSl1RhIXGLLRWWE/aVO1shPS+aOz/zGZFPhLoP8thQ1aHiX?=
 =?us-ascii?Q?FRD8U9YcuheodYH8VZlqUcrOmzL0/OjJwtVFVDzTQNIz5QnFWiZb9PXNkQCQ?=
 =?us-ascii?Q?Jkx5OEEfHQ6Y0HHPekXdQjA/ijfnlZfJzi69hcXxEy6XVjC/x2pqtDDE4fG4?=
 =?us-ascii?Q?vWrOz9fxHBupfOTicgFVUh8dwhYY1629HJdYudqFOLMfA/Ts692T1o9wdg+v?=
 =?us-ascii?Q?/alPGE+fAPQNOi47mvGxiwqOm1tFQ7+TdBe55ez9NRNr5k/nocrlN+IcnC6p?=
 =?us-ascii?Q?hS7kq1ZtUhve8E+94xDfr9ov/ehuUUPim2Qc6ebJGEx20+AYAf3WkG122v/T?=
 =?us-ascii?Q?RScwfN/1OQc81Sua4afF7mJmNyvb3eVxw2paIeW41/MamaHDUBADHvj2zsz8?=
 =?us-ascii?Q?/rRZZaZ4lEMHjqekCy+RLvLjcKo4lO/D+22cKnsQIO9w50Y0w05eEE/EcVKU?=
 =?us-ascii?Q?qlhss523eRsAqp8HHZXpjJl4FWxfAPmIW/eviQcJF19YV5Y3yBqeZa60TK0y?=
 =?us-ascii?Q?DMCGJi2sDOOQm9BeMdvMhs/GQdJU+RCYG+hlj+1SRDAgLgyi2c+wWNG3+iUM?=
 =?us-ascii?Q?2sE4n2sL8ho1M1kdzBogNrUXQqDpcSlM2O0QwKp406nlXHlIArwo7qxMfp9A?=
 =?us-ascii?Q?v+C18km0K55x1oBkOjqHHpxAzEbQG6AFy8aMC3XyA/H/Rqqix0jwebabeUwD?=
 =?us-ascii?Q?OOLxpiGGV8BDlZE2atoH3TJ9pZt5y0PnhzgpgU8gZD3gqxLNZR8yhy2T+/K0?=
 =?us-ascii?Q?0VjFay8S0NMi6Op0qmRMMPyeGJJdNeWvPVkXgWKnpPM4RADdnMSA7L4TGscu?=
 =?us-ascii?Q?tdFXS/S5mEvMUzYGp2+hPekaoE8LGuzuQ0JVtl14IlBAnhxQr7b1iacuX6M/?=
 =?us-ascii?Q?CN2Dx9kN4pUXD7Sqm7604Nm6WyqV9afXJdUJA1NEbWliXPXxExj6pPQWnRkH?=
 =?us-ascii?Q?n9OaievjCN4QymHCkl2Ic/c+0WVrzc2K4F7ZcFWv13EH3MEl4A8UbbQOCLO7?=
 =?us-ascii?Q?IueSnFEM7kNOlbDHWoM/Du1UHya2zfdoiy0KDGOXZ+WGJ6cksrUTDryMMF5V?=
 =?us-ascii?Q?2fxAI6i8ahd4eRs4QRBJ3lKYLIrG/iV5cfPIExfXU8Ch1GGAetQ9B/MNvdB9?=
 =?us-ascii?Q?u4+936ovcuYLrC3UBMAgIZJbEeovuT6L4LTECTqf2IIkfqap+dye14JpnWox?=
 =?us-ascii?Q?jKj82bE9LzFR9UT2M4a5RbstEKBYwiKYMGP9R7Q3XZuwh9a8+W9ndQbRcIbe?=
 =?us-ascii?Q?aZxWWghu4SGu1Ac52ksGnGdh50Ddn7hR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tp29z9Ksh4R590ECV/9aAPEyAudPcqEMlzLiM/OxKg28eZYU2PauG5vUu0yw?=
 =?us-ascii?Q?4u37Fw0ayBioXpOaahRR8YaJwIdaNvKA2MB0Cl5mkmiUjtlF1+lZGRl0CtSZ?=
 =?us-ascii?Q?1pCgdDingWJawLC1KSCtBXluvlgjwTrOlj9hK1Sl4wHO/K8YGu5IW4zirxDo?=
 =?us-ascii?Q?9grMZ0f99lqWCPqMF2PaCl+nDMJsdZZS0KKrMLkhkDxrDBcVV56bdGhQ1t9m?=
 =?us-ascii?Q?Rdf9vUbd1ADPepTvyxqZs3Jmh3Wy1mEoDZfj3QUb3LjUSPh7wMAQGUm2omV/?=
 =?us-ascii?Q?0z67tq9ZzvCeWsN/8kNr9IYh5jrb+0Q2T6IDL6NGuuF6eu0U16sD6U6ZR3hl?=
 =?us-ascii?Q?n5VJfvl2mNlGIGpPMwy4hbg6Q32jEIqRpbjSP0nk7f4Vd7FYGhG2kR118+Um?=
 =?us-ascii?Q?lbbXDr1Bt7eQ/hmFG0PiH19g1qb/Tv/5V9QTA0C050IXICHYPqy5IJnx4VnT?=
 =?us-ascii?Q?wj0bUD1XBx4ekXX0f3VvpVUHVDk0EiWWCKvvjRgZhcbCHp/BJAbMFPDnpO6c?=
 =?us-ascii?Q?8CO9daArqJaKL+PSogCkVo3K7CeDL5EYwmN/QFCnwdnUn4jncSXb7bWdKRWZ?=
 =?us-ascii?Q?pQpNZ4HkM3RiCruFPI9ICctCDyuX7Eic+rZRLO/R/ua7mEJyxPW41PK054l6?=
 =?us-ascii?Q?8N3v1PP2Kv6n2HOx0d2BKHZk7DdGb/Dm3Bm/XUlwKHVD+OkVU3+03v1lNbwE?=
 =?us-ascii?Q?SzMZ/xapaio36bxYmXE+Wv237gDZ6hgttfDUZcL0PLLqBkYAEtw0F6FCd0f9?=
 =?us-ascii?Q?wncCaRL6ujgUMR6X6xttPWc6KT7kDYqkwoo2RQTFIWxC0snBuYB9JLqzCyS3?=
 =?us-ascii?Q?UEVVf2Yezhi1xR5RZlTxMer/L6QD4eSvJ7om0jtGSZLoPb799KCz7LX9JXQO?=
 =?us-ascii?Q?637dTA2eZQ2Iyrn8zLhQoEto5J5Xxru/CyLM0RJSTkeQMc1/dQSpkVhX0QWu?=
 =?us-ascii?Q?SuoQx/TU4I5RFSrnQ08mn7y95l8LOF1FQMW5SbHXtPEUTw9Ivs8gr0v3tk90?=
 =?us-ascii?Q?FVOzMrkYS1ssnm3HzkqMYXRusf4MzV/CM9KgVy8jFVa4ynpjjoy8GvTd5Q00?=
 =?us-ascii?Q?5hkRPmOCj6D8qTUNfMaqcaQh61b2ol1SC1kQttSOB8aFf67xF10TEb1it/Ql?=
 =?us-ascii?Q?7VNa2suv5gdu9nd7cSlYbtEDdUsTP5B4Q0oKDVbCs7X4m2lwUldiUeVq2tQZ?=
 =?us-ascii?Q?dTIQTfSeUQcXtqwQEDaiwpvYFb/OdvQ+GNEPWGZuxcWypHSFZfr+yomTl25b?=
 =?us-ascii?Q?Wgne1AymnGpGVZFnDRJyzMyg/MU838ZjeecfR+d4EsHMTmFtb3DL8CLF23BU?=
 =?us-ascii?Q?p5fuRs9+AzCZNEut0Sfwjs2XLVS+e5WlPlCVIbEq0T/q7R7Gt41IfIleFIum?=
 =?us-ascii?Q?9bRlVNzeYASJDTLRqm0HM1TkTMc4IM1wojBVv98CgSl3Q6Yv34hYyGfAlvLF?=
 =?us-ascii?Q?vETTUoic0rP5P+AgtaWEuNiaHi3Qq2TBaocWojO6y5sVzT6RG69rl339QW5o?=
 =?us-ascii?Q?oiquBsZ3HEtm4fYeKd8aI5/fmUQYOGXrvioCQ5ulT19i+ysyOJmXrrF/dy14?=
 =?us-ascii?Q?+MglEUcI/Pifd+/kIN117ry4WNte8TOka3Kvany3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c23ed66-eda3-48fa-9854-08dd612fc7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 06:33:20.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KK+vw6JEycAoX4hYcs8oQket7YfLZFbd32Qb8K6/vrUP12dm3m7o5KO9rZn0xzZeky36MqOUo+p8uKH5pk34sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, March 7, 2025 7:54 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; horms@kernel.org; jiri@nvidia.com; Jagielski, Jed=
rzej
> <jedrzej.jagielski@intel.com>; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 04/15] ixgbe: add handler f=
or
> devlink .info_get()
>=20
> Provide devlink .info_get() callback implementation to allow the driver t=
o
> report detailed version information. The following info is reported:
>=20
>  "serial_number" -> The PCI DSN of the adapter  "fw.bundle_id" -> Unique
> identifier for the combined flash image  "fw.undi" -> Version of the Opti=
on
> ROM containing the UEFI driver  "board.id" -> The PBA ID string
>=20
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: zero the ctx buff when chance it won't be filled out
> v4: use devlink_priv()
> v6: fix devlink_*_put() labels
> ---
>  Documentation/networking/devlink/ixgbe.rst    |  32 ++++++
>  .../ethernet/intel/ixgbe/devlink/devlink.c    | 101 ++++++++++++++++++
>  2 files changed, 133 insertions(+)
>=20

Tested-by: Bharath R <bharath.r@intel.com>

