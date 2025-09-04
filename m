Return-Path: <netdev+bounces-219802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FACB430C2
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BA47C0063
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E67F1E3DF8;
	Thu,  4 Sep 2025 04:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuRzkBR/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005513DBA0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958621; cv=fail; b=gNfkx6uQIdWB2/iGflmDeIYnQz3pAy95W7LgaivqFzupf0R4ob2FNW1fX9bvl4OMFsAViOmZEpvOicMQBGtWakrMVfeV6QRvaxp+MtspSgsr6CeWSzOFfL9Gxh1zdVdos5kPjQl3H/+It7ilwwB1nWhXaxOFMR59vhPTm6D0pY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958621; c=relaxed/simple;
	bh=/JAqIhwr+CJIouz/cmpWIXmqKitwxJWEGJFWcnb59WI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8vZhFIuv2r0GvHXc3MrK+e8dOsRSQOPpqR8VfQiALaIsESxt9gh9WfDsOXEmXlK0nDnbp4nmRZ4bAWA+7zm9Ga4Tmm6OD8Kr3IQEmTGSO+TBouirEANk3zN/pMA4/y5QLdHX1BE4Hfuyz32XF0dGyOfT7p7U2QJ6a2gsXy9n1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuRzkBR/; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756958620; x=1788494620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/JAqIhwr+CJIouz/cmpWIXmqKitwxJWEGJFWcnb59WI=;
  b=FuRzkBR/viTn14H9X+fy5o8awA2rsP59NyExRXpdr7UTjxL+sde+FQnn
   L4PByCMslfg+rlmfmQdpzgQF4r2a4jFOpYz7wnKi5FeN5s4a9aocdfXD4
   DNW5rgbl4h8MBwfZrcMxDxx9f1xFAPxiUR4zqYvhmmDZ4is7oDzxulAtJ
   dFsajdLrtKUAm87rOmPOPD9Eh7uUCdoeC9uVaRbHTpH7yTsFHFgKc04sN
   oOi3IurLiq2QCZ/nj6xi7zZbeZiNsqHeFCAAE+gW408I3IWBuio/gNG7S
   aaNiljEBXYKcJsh7mfYVlFU8l3Ph8Y0natjtERkfFSBYeIIhfobrRriJ4
   g==;
X-CSE-ConnectionGUID: 3gFF1EEdSpWzbhr4wUR3aQ==
X-CSE-MsgGUID: +6+sPy1kT4OjAcnGFSKRmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70660062"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="70660062"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:03:40 -0700
X-CSE-ConnectionGUID: /bYD4LFOS6WILUG/WUBeqQ==
X-CSE-MsgGUID: JIHaiELLRyediCInLQrkxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; 
   d="scan'208";a="172142783"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 21:03:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:03:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 21:03:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 21:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJUiuu+Dm4EuvaxvWc5pYb6v4FAYfx08AlHi3ohPHIYkGW26hIREJ+DrYvcybwWMIOptMPVTJ6OEo2eh0G1DF1Tse52NuqhmJrXPynguQBK8Pa2i987Lpo87kawfQ2PRyT+FWlT0JtA3nTNfuouLc00LfLWiOOoMVZGhikHE2hXcj98VSHLyOLsjaE1p5oKYbrj/9tZukNHiec7Pv0NBUbgoMmIZvxoD+0PeHT4myc4HR3DAQ6BFjAbVJMWa7mCp4dQgYDhdod32Nhrod8AsM2d1KJxnqO2on4aLJkfPsMB1XM42+bf5vFSX1yv/eOoG29cXrKsvKCBYYx0kuBkm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkKELIcglNqq9ti+eKAs3hrr7zkaWP5DJno+bUytAfo=;
 b=Fi7Fev4v9yqbeuqtMRKVsnQXYCmS7U3Ia2Gu9mZDHYqbt4u8RsAWej0r+fqvIHug80vUyjKqmCmYo9XKFRQcLf9ynoJNZb3cQFvGrVCHv3HNk6r6zOV6c1aT8CXLe5tzyzGW9Bp3b1FoVMaGKYOP9PmnbuMySNDQAIAOJG6grJnyS+0PeN2p3OOVsnx0thukHWAm1ptJBChINkTBwpQzf9s5kQcMvc8rjJZXmmIt3MIc73L9wAj6sHw/LQ7LQx9nWpLv3v8HYNtRk2WHnGAcZIsjxJvNsSvvIBFMnUL9xrMPDFLz+jTYlrl6xHea7JhTmw1ron8SlezwKMr6WEmCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH0PR11MB4774.namprd11.prod.outlook.com (2603:10b6:510:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 04:03:31 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 04:03:31 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "dawid.osuchowski@linux.intel.com"
	<dawid.osuchowski@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 08/15] ice: check for PF
 number outside the fwlog code
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 08/15] ice: check for PF
 number outside the fwlog code
Thread-Index: AQHcC0U+/IN7A59lNEaVmhgnh8lXu7SBCFjg
Date: Thu, 4 Sep 2025 04:03:31 +0000
Message-ID: <IA1PR11MB6241DF5EBF806C5DFD1134E18B00A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
 <20250812042337.1356907-9-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250812042337.1356907-9-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH0PR11MB4774:EE_
x-ms-office365-filtering-correlation-id: 4b7325aa-d954-4d5e-c07e-08ddeb6802f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dCEIVeoW+A7J7hskacHGnr82NhDTvfVw0CEQAopLrr486Hc5fULhmteP18No?=
 =?us-ascii?Q?Q0g/16LmAt63gak7+RbyYwmz98gKD6RYVHKYCl9mhyYBeZxfv2rhbJm3ZEVG?=
 =?us-ascii?Q?1i3BOze4UiYaLksSsvdNbDsGtwDZEAyxUuocokpjDWJeZvB8PdTYXgdtE+Yw?=
 =?us-ascii?Q?SIQuqQ9sxny+GVsjNfpsW6Sf0ND8PzPiN8lTRCj8CxvYlPVUE1BJ84bSKimJ?=
 =?us-ascii?Q?UVCGYxZIaYG18AivpHG//o/jwFUHKdOqW3kSaNm2nHyoXaXDrSuPn/BUifHD?=
 =?us-ascii?Q?th7sfgP/V0apL+N8IEt1JVhqvjZDaTZQmrSQj8XXwT5Ruc2WJnoVUML3EjsR?=
 =?us-ascii?Q?EduEYhr+/tAmJ+KRKbmL+AxflMDUKfzIgQvqa8EtIYMe7tcmaCE7n4WJdXNN?=
 =?us-ascii?Q?Jvu/q+FTyG8uRUt/YpCFVcdVDnIDEYcKUBIWwmzr3iQYAvCafLn59BKCJEAK?=
 =?us-ascii?Q?9YI+UWwOCf3Mqwje4FGOeU53NSElCgLseJkVYs5ekls517fpckjjP1PxjQSx?=
 =?us-ascii?Q?SnRgGnicPevFNF6yMPPeWMneeUihhg/cbCPxukHo8Ghoj03KCby5xhOYkT89?=
 =?us-ascii?Q?4vaCbaIMo7o5Pd1ggxJro7cgfIEVN4INKQIofhKaGgWvFy2O4lFEembM3HqU?=
 =?us-ascii?Q?nHSuQ98p5gjgr9X7eeHcyawZADR+rXhmNONCVTGVYRIbmWgVjlEZfP9WXofN?=
 =?us-ascii?Q?g1QeHFRnNS4ULJgd2Odamrdxz5RxJWsRdJRlsjSsSM0w8+b/8cf3kFQBE51u?=
 =?us-ascii?Q?nSZGAKjdU4yYD6zUU5RP8/Jliu+FrU9Yx3hUPWRecMU9NqXMaEHeg+2Av6/k?=
 =?us-ascii?Q?Em5PQUwj4Tcq49HXtJP3oVUBd3kDz1jKWSVvcLpDE3oyQK0pySgd9WLWjumv?=
 =?us-ascii?Q?NztDVtGTRvjOmYrdQXGdBR9yrRNVtfqmmbLlOQS6LI5DaWYgDC//bn/AZwu1?=
 =?us-ascii?Q?1/qmfisGZkdl1dc27yfMTKKQEbi0+a4rPeM8mjCdEhxTzESnEcdqOAcZC8A9?=
 =?us-ascii?Q?WJI4Hc1MGxIdWS+0udt/+QBRUzKE+Xq+f/2WiS2gkbBSiQCh0Zre4fvuWc3N?=
 =?us-ascii?Q?JYQMQR2IbVr4JSZ0xUgADymZVA4w2x+K0UWrAEYZ0U9FWq8NvtuwTOu1cdvO?=
 =?us-ascii?Q?CmZSoJX5bzbsK02TWx0U5+Xt9nHWWGMTR3+bfoyZRjE1fZP5hAK22AK+K9Ng?=
 =?us-ascii?Q?afI94BxSsd70VSDh+JAAfcbBCg8Bn9STaorIXOFyO4GKFusY3ika69DBDOa7?=
 =?us-ascii?Q?LIIpuEJg0b2CVJm73+blJTfDdAB3TT3jPpvUWjJS4XBOoQ06DO+rFY8efOY1?=
 =?us-ascii?Q?w7vSD71EDx6ExBwrfUhKmw5esQS9ZTUtBWUNiildVLZJ8Kfjr6jFMqsqH7Ff?=
 =?us-ascii?Q?G7afjL16VSP926wT/bV3rJjDmXrUM9cuXRkZWc/2NYyAbedmPSnYnnF5eelh?=
 =?us-ascii?Q?Z+jgKTgK5pYBw6KLhQmPZxFo1WK50tKEYJnUpnS57KJ8fC5r0dMMgg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JGSZGYeqtmZarLguJAiddGo0cn1cHOY/np3ayUfkdY6dRRtc2gCiiXYK52qV?=
 =?us-ascii?Q?gT/hvbLYVbr/1ls8/E5gW7BCeYS3zeBCBzf4hfesIsbVG/2sGpW/PJ3w/Toc?=
 =?us-ascii?Q?T8MyxZc/v4xvf7U9aKNA+mf4/3fnpy25bQlQUDQIQuPTzvHGqB4kPX21Y5E1?=
 =?us-ascii?Q?gi3D0AV+qktPm3vXPh/BVtw7mclkFxyGvKFdmhNaoiLGuBpyBfcBFFKV5kR0?=
 =?us-ascii?Q?FecE9hOJp2tqDzWOI75VA0nhCeIGhLHO1mPAAarnTPLp+J6z98fH0wE4ug9h?=
 =?us-ascii?Q?emE5YsNFR1KHsccScCIWaJZ2PHryUxFWpWfcOfbcM2+mxAbmiwnkxRafrZQV?=
 =?us-ascii?Q?zwLF624NrkbIESX2L7JD4spsX2jyLiANXCZiFdRqLVsRT/8rzwOuTgNuyf4R?=
 =?us-ascii?Q?XOx+LMyrx/enrbcP7eoCLo7s+j6mwfBMMMklDfoLQCfDErcMoK6fTMN6OTNM?=
 =?us-ascii?Q?BT+0aTdXVkn72v1DgU7C8Sd7Xl9U93vFovbmur+rRi90hn9XYIYfu+enAGup?=
 =?us-ascii?Q?OkGWhX+sWlEuCBYy9lN/BBqK32ByjlohEwTpAU49CddZO964cL+I+M3bBD4i?=
 =?us-ascii?Q?GJZ0er7CwvK/mLbhkFVBFN6NBaT911PYmO7+w4y+D13rskstQyerCXnct3Au?=
 =?us-ascii?Q?55ApmKtpvVc/VHC3hPDOIQIVb1bX7MqJpEr9QjsFHIhT/tbV0heTCvmV1r0x?=
 =?us-ascii?Q?wD19B1EHjMNgw1zZqbu4IKhUsXsyAhnXbz4uBcLuKIleAxLYAjnoNEmYMHeH?=
 =?us-ascii?Q?4XSoU30Rx72VuUXc0P8eS5BTH++nakebxoy7x8rK4eLUOZHBlWEk0WY5W6uO?=
 =?us-ascii?Q?y8uy8xBRXZV5JQYn/Gi7VSIcBbfwQq+Z7/6fCdq2YIsAJwGYbP3ABezOokUD?=
 =?us-ascii?Q?O18fjhESb3VG9SMUbHbqzTn9F1ipX7uYA8e+oZFnvPtxSRZ8Dd11EmFaSUDD?=
 =?us-ascii?Q?0mPxCjoFzPBSQV8AuZ1kIFiF0oVitr+NyCGQmFCWDOktdv7vDzTuU9ND+Ag/?=
 =?us-ascii?Q?UIie6P4dyiMNV3H+LeWTrUBI8QcRaAYawjd/D5hU7nFxVYcGn0dsUnhdX17s?=
 =?us-ascii?Q?C1kAvhTUi7vC3CjhNdYEkpG7fGjWGwBNyvIviHK4+owan8Kisn9FqpOZE3SD?=
 =?us-ascii?Q?qwUlDo2EYRP7ScgwMPhEBVWU3WUtM3uB2FshWqUKYGp7wz4qF05rIJl7A0Uc?=
 =?us-ascii?Q?b6yi0qeWkilUpNaeGzr3ZcSA8Vb/X1Rb8N3c/B8bEOskrD/CYqaFL5XZsEGo?=
 =?us-ascii?Q?tASVoMPcH6mCSwHBQ+kOjEFCsfky3nhztVQ9kgGFVP/DRQB/K9OJqwUnLj7z?=
 =?us-ascii?Q?HQu2Dk3nIPsfat512L/NL23jYyeNn3/ctGUVLqgfD4/3aJsfihi9lbr45ZlU?=
 =?us-ascii?Q?iAk9S8w+B6S612doJOpmWFYP1JzDn06/FZB2g0BBeswoRil0HTvzoxNDwqOE?=
 =?us-ascii?Q?GFzV5IhZazi5T4aCNvf5pNb0pMlccDkfzS8n3mJfDmnKSJlh8UpP50f7bb1d?=
 =?us-ascii?Q?Ln9k18oornQY1h80dkC+gozRw3X1b8G3qJ4MW/fyGooBS8fzsmZwUcW9QRBc?=
 =?us-ascii?Q?zS++XFsxMw/09G8efjupDxCglt/l9UjM44A0buYX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7325aa-d954-4d5e-c07e-08ddeb6802f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 04:03:31.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7PA4EtUE5Sq6XknVdexy33bWzzXQvQrydpuFNaFpLtwCJNmpq98M60ymY5+OQUQq9Ee6QGhe7ZMIYa8m2PIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4774
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 12 August 2025 09:53
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel=
.com>; dawid.osuchowski@linux.intel.com; horms@kernel.org; Michal Swiatkows=
ki <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 08/15] ice: check for PF nu=
mber outside the fwlog code
>
> Fwlog can be supported only on PF 0. Check this before calling init/deini=
t functions.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_common.c  | 8 ++++++++  drivers/net/et=
hernet/intel/ice/ice_debugfs.c | 4 ----
> drivers/net/ethernet/intel/ice/ice_fwlog.c   | 7 -------
> 3 files changed, 8 insertions(+), 11 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

