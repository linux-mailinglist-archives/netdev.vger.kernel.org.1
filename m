Return-Path: <netdev+bounces-227153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98929BA935B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413383A446F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC526F471;
	Mon, 29 Sep 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1QNk9dy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5CB67E
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149110; cv=fail; b=e49w9Xsh/gMXiAvzazxVgwZ+Ytx02/vEaOlMYgdkYZZQykCMTu0OjSMlz76UNEmGDXLs7WjkoeuAq9c32j/FjxV/9OFZZ/uLwbeg61Zwhvt/3Lb5465kv3vS6h/Snatluy4BLOFbuxh9EZIjV5tVWRxjvbSjr+oHNpLBx8/CV6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149110; c=relaxed/simple;
	bh=r7SoRCEulocO4ECuOrIBbjew4WaDXmlzdb3TQlVbK/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AO8bwpYmEcXgVXAzd176mz22ebgKhamcPkv6BRk8Ux95bWVCj9jp3tQTTd4/BmBZT+fb0AfXJ2610trheo5Tt0GnPpFCVAgeumUBq3zg2EyJNYvXMnRQhuhmIrajKGPe9UsjoqUXnQkVYW2eNNEAbhXk/JnY8KgSvi7rgvWpCRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1QNk9dy; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759149109; x=1790685109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r7SoRCEulocO4ECuOrIBbjew4WaDXmlzdb3TQlVbK/c=;
  b=g1QNk9dySyFZCSgH2OpsC6kOWrUTknWBCNdGUFDtdWUaoRfzg52sC7+S
   CKYv+1ZSgKHhVn++CgOoCYpAcRdBbHOLtl5Z3l9Fe+/ZJxUp/U6wMsk78
   ygFS+H9Jer11+coYxEX7wdlw22Udp9Kmveqjgupn9qaRJJM/2HbN28kHw
   C2TU8XS8PYeLq/pWbw5nRB5Y9AB5uTf0QsPk8BOWx6f/mGoBbj9AcLK7r
   t59triOgh4QwW859+HQ/lCEQENRanpv+57nqcolaoSwkT7vOMdBL+kUfE
   CUjZsSN1R1Vm7sODoaTBHoAwebWH0+97CN5eF2NeRWu+EGrdQC8sBuMAH
   A==;
X-CSE-ConnectionGUID: gEfWifjvSC+tEsxe2gXEZg==
X-CSE-MsgGUID: Hv/UboqbSuCsNse+IdrR9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72751200"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="72751200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:31:47 -0700
X-CSE-ConnectionGUID: I9gNotT+SO2PFu8jTKYEtA==
X-CSE-MsgGUID: 2yOX2pRiRryqkAg7cg9tlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182516179"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 05:31:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:31:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:31:46 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:31:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUtvCOdc29tezlJqTevS4p/e+TYqwtUXqhhJZaq7xUy7G1CF0kxdPtai0FknWtfRBsFM0NxwLQvt67A9HyFmlP5LW7RMPhEz/Az1K1pNf4s9oVm1ur3jciMq56opvW3qlZoEIRT/78v7C73shbCs1trbfM9YM/l4uN1qfqnBoApzAaOcNB4NiHwOfzCxy+w25VfGVmujgStq7S4e+4X8JTWsSAltf3u1cdARXil0Y3a4Y6pgqHDHIzhBLXXJPUD0OpczmxaAG/jCfVdRElubSDDkoGN3Lg6iUMbVM6iHYcu+3AMUEITGVUBjq8p/BjHt5yiqK7O7C7iwBkzzzo8qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rQjfjDMr6FfCYCTZVt2svj+ssdzab9LdGK9ChG+LiM=;
 b=k07NMSUseGQeXgLjAO9JzC9pjZfhDRFTzxtWb9MhDOM33vljhs+TGQcZ+XHrc29bT1gWb3K2w1ak3sYRc3aQC91VibmH4H3VGUkkq0gYJr+aIXxCfGCZcBrRrW8mZcyPwcjHfrrluoabagLDUm+fL3yjVe0Z3VXT0vZfYGtd0uX6Nk81e3PCMNPziv2en1+9gH70ENWiSjMBbAZkv5riRf7rfxwZQCAL7mpjruW4aYFv9I6odevItYjZ7XeHQoZhAZfbi6FZsCFAYcmJRNjE3CsQV0r9o72nQgQnIiU31OuOU7n8TZYDLCwVCTcpM0shZu/xLJwXTkFMJDm/o/mPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:31:43 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 12:31:43 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 8/9] ice: move ice_deinit_dev()
 to the end of deinit paths
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 8/9] ice: move
 ice_deinit_dev() to the end of deinit paths
Thread-Index: AQHcI+ejBK9y/QRttEeQejiulJBQYrSqJJtg
Date: Mon, 29 Sep 2025 12:31:43 +0000
Message-ID: <IA1PR11MB62418C27A495C3BAD5BB9D618B1BA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250912130627.5015-1-przemyslaw.kitszel@intel.com>
 <20250912130627.5015-9-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250912130627.5015-9-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|CYXPR11MB8729:EE_
x-ms-office365-filtering-correlation-id: ea5e66a6-38bd-4d4d-1378-08ddff5425f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?tiPnIiz+EOU11tF1fQ1HVc/p55jo7KwU+JzxD5sDa8buRvE5I+PSxzr0wwXz?=
 =?us-ascii?Q?tM3RyZRwbkKXpuxp4uc9jl0M7O83xqzd+1koHEvZOTZaAfxhaXIHYz+BjBrk?=
 =?us-ascii?Q?stRsy5sxKHdzzUhkgE+TDWODPm/3GcdG4Rwz7Dw593t4GX+tEeEM5j3+SWqm?=
 =?us-ascii?Q?Bela1WoiQFXaydYHyG41lTysfdntJpDX4vN2MB4DfxAgFtnw/Z/3i0R3pzAR?=
 =?us-ascii?Q?wwIYCa3f5H9nJI4yRaiTYCl0ddqQazNmXCIlKiyhSj0OIoKxw4Nq7QFdHmw0?=
 =?us-ascii?Q?erVSLqAgMuIi6pIshXTzvRTor76FADI/uVWv+U0KtNN4clHuiwEDV7GkQssq?=
 =?us-ascii?Q?YyrTCQk7PAkx2UcrzCZQp9p+HI45FnTcQ3lZzRfiK/dm3lGToO1SJfpTZ7P8?=
 =?us-ascii?Q?puBi7cSkiiuopmLdBAGYT4AidAIn70WDCXXoGCxm9pRDj9AgHwbjCaBbQDCA?=
 =?us-ascii?Q?LZAydVZsdI5f3OTkPd2Eq5OYPloZBa/9H+NYVABg7Xbl3RtBzsiNdyrbJ1aW?=
 =?us-ascii?Q?F5iYEbMeWNVL+HT0MbGG8qagu0SIuBNAODYwZ5H1+FquoPkgZJHtF6GZ2i2n?=
 =?us-ascii?Q?5Opxm2w30kMKvyEUBfSyvnpaOsrs4yRWhfkSAaVxXQL6LkxSlrIjcthFF8VO?=
 =?us-ascii?Q?tM5RY1dOtM/LnDDWyAy7frlnFvmmbz+eOmMdYHGO5OMc9KH5BFrK2CEFMnmG?=
 =?us-ascii?Q?zTOxfbY4IFNK0Y8fouD/RSIle7UfU9tGg5T6QPkHWgC8oT4MTmbqlUHeCZM6?=
 =?us-ascii?Q?SHBLko33OJOOWEux5rlHpIlFUG02VxFIPVBgOTuhO+dAiJ9LJbj9kca5hSn7?=
 =?us-ascii?Q?4QD30iLgGhJAan+g/rHCvz4felE8hWk1W7FsVN8eNwhUAN5rIwSyvUFpFZZw?=
 =?us-ascii?Q?FsU6EvdeEpbPgqop/jkoyCEOemNO+ED7XU84M20nNsIo22/nBDPz9Pr8DX0U?=
 =?us-ascii?Q?T5tUBBQQxQSyWBqLjWfUmawQOa/sZdP57orcNd5PQXTBGX2nUdXUKiwJyv9F?=
 =?us-ascii?Q?X5fr5ElY5zDChLo+VwWeZ3cDMIb/uKf7vtc0YWdV5pzfxAmAXPaLOgwPMjH4?=
 =?us-ascii?Q?5t16wJT6hfh6XU4ju8IDAkoYPU752QzNFdsuw/KRWyQbLW9SA0yTNvxZa7Yu?=
 =?us-ascii?Q?H3oJOjTClvkZiHz3uRLDU+RhMFSRByDJ6Mm8QuOn128FfIfU8/vSCCf88RgP?=
 =?us-ascii?Q?cStygtJLgioj4PthY4rQsBbCdlrhwkEgn/kmeycf4FfLqMtfAJ4uQb9CJGBZ?=
 =?us-ascii?Q?CpCOWDVeeL5c9njK0JdOwhgLJ/VWQ0IWenIMkIfLF70kx7g9e7vEKwbcrOKF?=
 =?us-ascii?Q?+z6OSe6WbMvU6rSvqJq7Z5Qc7yQK8EOWopXtV2468WiYrfb2HmkJ+D0OEYcP?=
 =?us-ascii?Q?mfPARHgmLJ1RP53FYjjZ+pqrGZ2Ejz1QkcHweoighWnsTNGH2iPlonqc0HPV?=
 =?us-ascii?Q?cdk56LnuyK4slo8IACv1WRj0mwfx8EQ6gUfdhad93lap3z3e8ndYsSlflXhI?=
 =?us-ascii?Q?Xk9/605Hb3/3iP19Yf3+z495tm9BI8X5gi3q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PGLd7RnIve5fomBnnILy+joD1qf0q83wRElXHNTqe+IgZ/PhMy52dFjEsXZr?=
 =?us-ascii?Q?/bCeNSOcmbWrDEu0B7m9xzhAzZoEjvvO39M1Pu1l+Qimawe2wMVprMWBdUdk?=
 =?us-ascii?Q?5e5ncqbPQzRyTa5NjrJ/v0vXiiz2NeF/CyhJNcj/KXCCSigZzdgW9e2BelGb?=
 =?us-ascii?Q?7rIVqq/Kjy3TSASH9WHLrYm4nHP3ZuTJOw3ttOxg32if5GdF2rRVSO0do/Pr?=
 =?us-ascii?Q?vd7wnrP+Oh+ApuIHDlz4HP6WitOTXUESkWpgFdhphcAS1Q9KlSWfvsKtYV49?=
 =?us-ascii?Q?JV/rSf6K7ij9NeK7wPvVn3JSl4ohnnyEgIDIGL3RHqZSTVZ3IwFXejLqFX3P?=
 =?us-ascii?Q?gR0yG27csiy3VFeC9g1Dx9lE1XPwBIGeMbMXZ+1+xnjOT697GKyewkRvjuJj?=
 =?us-ascii?Q?6rNTnNJND+aXHwVaEB3Vf9KhAum0Uf19W6MUm7W6Qqr32Jabd64esntadVOm?=
 =?us-ascii?Q?2m7WNYtuscK2j7/7SKzG2CjWwclIvnP/kERMp1pluC89pDfzA6T81sghxS1q?=
 =?us-ascii?Q?O0mnJr0zQltqiUvC0UPV+0knr/NkfGIHDvPUjfsmMOZE1FF8+/SrHt+P4BVI?=
 =?us-ascii?Q?Me6f8XpCkozuOjJ7yDUTES3JC/o5kspqaa4T5I1bMeFXsOjUE/G2WaoK+JoA?=
 =?us-ascii?Q?aTPq08ZDUKGaImdJyBjvEdjAE2+HlP9gPHwmD60+LiqUBdjMSAxacQQZWczY?=
 =?us-ascii?Q?LSxDgXyRu9TGVummtd+Z+WXSXowHC2EcLxAop7G8z11Ox8k/CHRPaTSgI8X3?=
 =?us-ascii?Q?CEcguXq3Ti6BF+ZuCck6lCX0TxNf3+0FnyuOzdTcSr1mAWQRShGsKnJvfFhv?=
 =?us-ascii?Q?pLSzh15nSptLDPIVgE38RLPsfAUzL/T4ssvvlKo/iorC9csBz6DS5Ufp5RP+?=
 =?us-ascii?Q?XFUBXHLeKmol5xNfVXA0bc+vaaaJigTb/DS9Zo+0tAvteDhNlktlS+H3BvW/?=
 =?us-ascii?Q?Gj5y25k5Cnw3CUjIaM6SU4vTBmvZ6050uIaK3IGzVTtkcXUGagyy9WxCEgOR?=
 =?us-ascii?Q?8gJ23jiOfC4JD+H41KiATfASFnCui/Cq9cqfUnuCSUCBhdOQT3MIuj/BELUz?=
 =?us-ascii?Q?9vr3v1KqcK5XkHWnSNsgdP+pqFO2oD9EGYzf6xsn/7mBtGfAQZ7vZ4yiHhsY?=
 =?us-ascii?Q?1l5Rq0xJx7uc9n/SQn1MuI4EQm7OIsX//IEaPOeLdnDttKP8XZxqbzf4EdLX?=
 =?us-ascii?Q?uGX9Eu7Pqu9IW+gJ0FLxFEj3TXYSvrj2x0YF/Z1wvgJfZvvRNJlVCXtOUSoz?=
 =?us-ascii?Q?OqmIE7cGtA7J5/lCMx8diibuJKjz3ktwd2DCTNNGJ0qv8FiV5nzNs7V/546I?=
 =?us-ascii?Q?lPll1sfEa+SH92/TEutNLYS6kdhT9hYy12rRru4q5Wo8LGVr+lGx9fhG3TPL?=
 =?us-ascii?Q?Tdm+4NRVedscJP1QzC3X9Am7w16xqAT0zlAWvMP6grGfFWOZavj5wTRMzd9v?=
 =?us-ascii?Q?RUVbHFhe9q5xUzYHhOuB/akR+ZioYUvQjtliDRSSZVX9cVWUu2L7hlZ91ayP?=
 =?us-ascii?Q?cmjQ+wvPim3mX843iEh9ugBn6p0s2XzfI3Nne+hjTJWR+DTOE3KI3plnYdy9?=
 =?us-ascii?Q?Q+vJ4+Wf3xPjLyPE93WrnAznwW/zPEu4lIEhUYyP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5e66a6-38bd-4d4d-1378-08ddff5425f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 12:31:43.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9k/ENx/+vaW0pNdiEzpn6vfpUhUP2DyglU1eNZo6fx43FuDbR7Kc2zLlUxdPtkt3pGt2ydXttyEO/pPZLT2PUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8729
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: 12 September 2025 18:36
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Kitszel, Prz=
emyslaw <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@int=
el.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next 8/9] ice: move ice_deinit_dev(=
) to the end of deinit paths
>
> ice_deinit_dev() takes care of turning off adminq processing, which is mu=
ch needed during driver teardown (remove, reset, error path). Move it to th=
e very end where applicable.
> For example, ice_deinit_hw() called after adminq deinit slows rmmod on my=
 two-card setup by about 60 seconds.
>
> ice_init_dev() and ice_deinit_dev() scopes were reduced by previous commi=
ts of the series, with a final touch of extracting ice_init_dev_hw() out no=
w (there is no deinit counterpart).
>
> Note that removed ice_service_task_stop() call from ice_remove() is place=
d in the ice_deinit_dev() (and stopping twice makes no sense).
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h          |  1 +
> .../net/ethernet/intel/ice/devlink/devlink.c  |  5 +++-
> drivers/net/ethernet/intel/ice/ice_common.c   |  3 +++
> drivers/net/ethernet/intel/ice/ice_main.c     | 23 ++++++++++++-------
> 4 files changed, 23 insertions(+), 9 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

