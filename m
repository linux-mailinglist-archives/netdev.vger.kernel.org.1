Return-Path: <netdev+bounces-104783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7390E576
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D461C213F8
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2579950;
	Wed, 19 Jun 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2C58ulg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39778C91
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785537; cv=fail; b=idK+cTStikTiFl0kv73/ltRSWamnoWHenqZ7ld1ndkFfz8ApVYTmX9+Ffdj2Bja970NImr9kX7RwgHdHAMv9Bk9x0lMgHVuyIdOz29DjDIsbMNoUadPnxV5599Ea0jx0y5DkX8GLKmH+sqS9Dexic0Y8y4dyjSjFDZySI3LyrnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785537; c=relaxed/simple;
	bh=aQbHT/5911NdahMMb8/UqPJMaRnrMszLwt8t2KnVyZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UE2u+s8PL1FqijqKrmARjuHhgQ+P+k3IRGtWE58CApuB6rDdwRbQGRjpwGYvzffH6wVf2uNgZ6K2wXucK59GjpraiFUdhL2LA9KIIEz50KL/6gPc+CrJ7g25L7AorhK0s1YnREWEuche+c84KclewpEMrbiRU8ndSDMmQP/JEV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2C58ulg; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718785535; x=1750321535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQbHT/5911NdahMMb8/UqPJMaRnrMszLwt8t2KnVyZo=;
  b=F2C58ulgZ0+36m85ZVwbOtFXzUIYJCxowj7yV70/0WEfhiZ44F72qlLT
   EEbHNI0HijI0FFyad8iciqs3Od0I8fYvP9s3hv+MeSIPQG7op0YqK9jQC
   VPAl8zm8uNnigzdw+DS/ZOxzWvB4uonkMxY+7d8dmly1RABmZ9QsSoi84
   fUkunlbe62pNtP8iCdIyfa391EsRqTsmg/WFR6qsXo8FIpQHKRvhzse5o
   /SYGimg9sb/jvzsbkalish6j3BaHFB35hAhlHDJ9Cgp68SogpU08CrgTc
   snIjjwY3BDo5u/BfHIXtS5rSPKePtgsuGS5i7lMfG5TwT9CUvSgr3CGEf
   A==;
X-CSE-ConnectionGUID: DXHIJax9Tu2A4QzFXoOpJg==
X-CSE-MsgGUID: PiAspNz0Sd6THfqmk++sBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15676255"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="15676255"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 01:25:29 -0700
X-CSE-ConnectionGUID: 3Z0XMF/DRSOswTOzQSXBBg==
X-CSE-MsgGUID: sTelyJsQRuOre563cpte1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="79316616"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 01:25:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 01:25:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 01:25:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 01:25:28 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 01:25:27 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 08:25:18 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:25:18 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Ostrowska, Karen" <karen.ostrowska@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Ostrowska, Karen" <karen.ostrowska@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Sokolowski, Jan" <jan.sokolowski@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: Rebuild TC queues on
 VSI queue reconfiguration
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: Rebuild TC queues on
 VSI queue reconfiguration
Thread-Index: AQHashbOpfadZbzwMkiV15fgBiuMa7HO3+pA
Date: Wed, 19 Jun 2024 08:25:18 +0000
Message-ID: <CYYPR11MB8429EA7858A2666E619C9BA1BDCF2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240529071736.224973-1-karen.ostrowska@intel.com>
In-Reply-To: <20240529071736.224973-1-karen.ostrowska@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB7182:EE_
x-ms-office365-filtering-correlation-id: 52b62d3a-5548-44bf-1ddd-08dc90395a7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?r5zAvwuGOXFHY0s7ZKXle4dWrTIxeoLDBOYAzensr32fS0e0p8+WEOxC0VTf?=
 =?us-ascii?Q?QgYunxG2YJOxD+PsqlpfvJXfRlLWvpuQw+sKIcn8ZhoV2gVNoUmpFmWvlVlL?=
 =?us-ascii?Q?UHNgEOu4mxaYEuz6Vw6TswsjrxpCmhjGvHJAU1kG1XEeSvzEZcuckt5u4Y4W?=
 =?us-ascii?Q?B9hu0XSVY23+NbltHsRNJyyUejr9FSumqpCU8JzW+sLqGhiln8rMGbqIbhhW?=
 =?us-ascii?Q?IR/MX7PQOR4lKMf59szpBO77NCaXQbCttPBJm9oooTKF9FAYku1lnvMSyNBX?=
 =?us-ascii?Q?c7gIwlun95japfTfIBr2rYKCeXD9UB78h6kUMhWewBBxzIDGi7OEmzjBAy2O?=
 =?us-ascii?Q?VadhE3DH9Wtd3Edc9bgbWf4WNMYj3LRIaX09nXmPT9aVUOuXZhj81vTp7Yne?=
 =?us-ascii?Q?CAlH+9fKgYawTm2yj1X0IVYvzplNYeo87TRdhOzOc9aDaWeTBNaO0Xw9DWTd?=
 =?us-ascii?Q?BIW/A5GnqGqOCgBFWyftLET3DNttYAa8ApRO3M65wo2qtO4dg+xG9fqpCbVN?=
 =?us-ascii?Q?eqMG38t077inLdksgN6ei44XmLERSRxvLe8DnzIYS5vKD0bD1y69PjE/kNF9?=
 =?us-ascii?Q?93OxED3oShjxq8RPgni4LD2X5XlZeQC1YXxdVxnXkFggF0tfBAf41ovWQG9Z?=
 =?us-ascii?Q?vAITAV+Lk2V/8VtoRU1sNnQmqqXfrn1WBynI5X+7fC2DZELBMVapSNvymOD9?=
 =?us-ascii?Q?swHIDr9VwtOpanTThjHWwAU6Pqk7XUkoQcE2Zmd6h+CKJelaHFCsLl6eStnm?=
 =?us-ascii?Q?p2cAXYMzVcGxtBmcuUcnmViK1zTvf6VM+yF4vuRCHdfCK+MMJQ2e16CbgEkh?=
 =?us-ascii?Q?usp0rfavOixZpiXj30zM0WdWUNZIu5vGVQEEGLjSSgLVVBMl0b9GWBJZvZ01?=
 =?us-ascii?Q?I55zzI2lJ3xRWt/7v/gxcsmfeHPUZrw7nr+odNa3cyc4tMb85IKOXEzokGPG?=
 =?us-ascii?Q?P7/2dblaHCNPN7wp+jtXAOnJYvNp34L8/hBkVMdSU92bLadQEMgtV8tzYN/i?=
 =?us-ascii?Q?CQZufMDSlZFcLHrn1WZPpUCUZRLrzbYtsjEDM1eYc1CmHB5Lk+ir7El7EWcH?=
 =?us-ascii?Q?hepcokIEems9QcIoageXJ3QjIsVexnsrCWMv2lpRBsFa3KnLbD4xuBofXTTO?=
 =?us-ascii?Q?3zdn2x47aetFUkjMahQHcC8Lya0pWfmf/b7iseA650vT+Wxm1TkBK6yDdWUu?=
 =?us-ascii?Q?C1uW6QZ6xKxZ1JbagvKGY5xFPmYKeq2HMtw7O/G9XdEdVLqhxbETAv3ZzUUu?=
 =?us-ascii?Q?yHTnJIJRncQmlagdcKxbDIwpxuKGei67QVqV3ItAxlxK9S2B0IaoqB3dxBNp?=
 =?us-ascii?Q?3ogaSPwLv8wM14HVZAOVRpHvpCpk4P+iJOFgegFnrX5JG05abu0BKdeMm+i0?=
 =?us-ascii?Q?2UOv9UM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tfXLbefKWzUN6r7FxXFE0oUofO95NR9//3xnFNEBzdSPsqetEoVVAIKcH133?=
 =?us-ascii?Q?gyQO6j6GGK6ElZ+9afpwCw+IXTRDt8y/Se5tVfA21jbSneaRAolR5wdOQ3gw?=
 =?us-ascii?Q?PMdVG1dvAveJOg3XS2V/DylWsbV9dK4Y1U0Fy9tiEPfZ3dMnoUGg9An23Ry5?=
 =?us-ascii?Q?CZXUbi3fAtwQYF875qCgisQ40Yj+EE/kCdh4VBUj7IBt1HzMSOEtn4+JPKU8?=
 =?us-ascii?Q?VLhAKCmv0+bNN3abeTNmCVrqY/Qpa283KUCbz89I02WHrL0E7sXD8AuWIjEq?=
 =?us-ascii?Q?6XKckPNGoKWPH/vL9baUkg4qUd79r3mSmjtfkYeLfzyc3PjlXENKxDahnRfb?=
 =?us-ascii?Q?nmjMOhp2KAji1ZuiIKzYsXIOj40CSEzaGJ1xKueX751ZXRsRKfW5s/y/Vcl7?=
 =?us-ascii?Q?1htH/FZ0+SP/j3OG9x0OQgnvk/PfmEhLIRtuGlULMcNAJlKnKrS5y96r1/xi?=
 =?us-ascii?Q?BqgATwwPtWKE5LOu6DxhyGT4px4pvwDKtd8CJQCAIud2vPyra2MU849oZOE5?=
 =?us-ascii?Q?ZfT7h7E9oqCH2gM0T2FGhSRWyXE+TzhUd4wyJF5wsvt21e17xsvAMjBKTEyF?=
 =?us-ascii?Q?rAwr4s8FBr6sg6e3qcgSMWsLTwYsq+EBd04Rac4/sDblAmKJTLlHFVmpRwB2?=
 =?us-ascii?Q?2ZsCkPW6iXNoZfQm3VPvvx2Lti3ZjYIhBe9CoHX7foC3dtNN2RvZj0wgfrJh?=
 =?us-ascii?Q?lj0LBjv2XZF4sFGEVY/WvtvnCCafMJ7LjTc0HmnBdc/+1q769sjOvaqtdqAI?=
 =?us-ascii?Q?n6FtYPOT5D61U/mRWV371wf1ZLTHy7pVa0V7O0J1/bEpFP/66DO/6ynXQSsK?=
 =?us-ascii?Q?d000HOOc+xeEsBokRl2EzfScdFPvUqxtqvN4nQYQvyirfjLtqwZtuSw+WsAj?=
 =?us-ascii?Q?PDDsqep6vGYA+ipIeSCtWSlfuAFP7l3Lr0ek+th/G2CO/rJoD0+Sxj+81q6/?=
 =?us-ascii?Q?yM3XvlKpA2bYGRu1c75AZ8aCF/XDU1KcMTNu/AYcdZNLfwAqwMLUPhnUwYv5?=
 =?us-ascii?Q?QdTeXJ3hThN8fQYtYYBIx8Ph6MGHG+BAfRgQzwhoB/Vt9jnfkOnAkAbHofrZ?=
 =?us-ascii?Q?9xH+ST0uyhq9Xqc6hQHYJo2+L6jpdtcmP1wSXS1ORUS7ZYGwXlhB88DZyK7r?=
 =?us-ascii?Q?JG46ImbfsdcwJIiVvTl8XbWHcrrlZjGkzSkZRRD8U+fIqJysXY+4UZXaY1fu?=
 =?us-ascii?Q?1TNGWFuwFwpdDNCoqc8UYF6quRRbBRaB+2sE0AAgL2UrgCcq6Ac/5RC2w8l3?=
 =?us-ascii?Q?Otv+otGL/flcH1RuWTEJCZHr4QmcB8mT9RwMe8iejCKzhaEYyj34P1TqJIDe?=
 =?us-ascii?Q?S0Ab69Ra/HOmUpW73o/vW76mi1kBB0/OBh3p53TUhbkXO73dWaOFmv49YoeV?=
 =?us-ascii?Q?benkSJ9ODzMrTO3BOZSPPPrB1NlzmV5m12Qd7A18qludFBy2POGb4D+J6FY6?=
 =?us-ascii?Q?IGffavtokc/epsMQgl9sA7StMGdAb1bLEc2Jk0Jf63rPZiVFyebYS5nczkCH?=
 =?us-ascii?Q?+jahLCUOawrJwCXyr04cZ75EkcOqUZmDxfRKxoMbjMmf05e0tcJCyMoHAB8z?=
 =?us-ascii?Q?JHJHOcQ+AWmI+Rb+Ip2WODBuPSkaj+EpB8lDyLQeRb7c9Ar/ERX+aC1JXFFS?=
 =?us-ascii?Q?RQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzbL1CGiDeoJureDVm+LkCbg21lzWQ0TjKFH6yquiUcsALL5zMwVuNvSXYTsu2pwEaKXs+nxWmKwYOQpkoENKFkk9E/6L7O+pXRl/J+udtwjo1yonQ8VcJoYVc4q8xewfETZr7Gcwkk4M2Ffgiv+LLQVGC3+TqplWF8ufnrsi9dp9DQT0voppknHv49C7Jk1XuSImE9USczuC5UEWdN88ms2ebkTdYCySFu13uGHsk2ToVe7AdIPmjwL+Kc7ZhhTgv5J9X2FwxgfYLPaW4cJeYxXa9o3bzefxezfMA6JdIcj303lbOgFqh1kNbKCnHXk0srUq8Tmn6o5VQz/uRtXZA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Pz049BP5Le58ZvfhlvppnJ6apxXmRyWD9fDP7sxy8=;
 b=L8NSbasNRUYsJLrEmGoXtmo0goXXAJIxILW95qD2yVrSvX9skR0oVU2d2LYCNgNTqMVyi4XnKSvb6jq3niOnAO1qYTGcQw6qQb1R5GSxXoZW2Ct/0jC2rzo9bhgx0/n0SVGYz2dUgtW/E/jNe2xBcIkV3jEONcYGgZwmGtf/RILAUNisJoJk7HTKHZBv2/P9DfD4shJUFxd7uBU4hTNr1DHYUBSYY7XAzAabjPdJs0SQcN/h54pN13jJssgDCMQC9Aqkr4dMapKqHTzIFlR088B/UjAL1M3KnQ1oP7jFliV7/b07ST2yykcRqPyvC50Gh3f+vbHs7OlRH19UsZtxrA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 52b62d3a-5548-44bf-1ddd-08dc90395a7a
x-ms-exchange-crosstenant-originalarrivaltime: 19 Jun 2024 08:25:18.4891 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: CH6NF2irEEX2b5iezckdXVEnMQCY12D8/AePNEWD5YtL/fbeCNz1TYvBFjww6Xg7JHiaabKfRPY18rD0TVK0lFZlzgHR1uSPawIa1lzFIhoUbZaDxPuJKuHasdic18Eo
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR11MB7182
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
aren Ostrowska
> Sent: Wednesday, May 29, 2024 12:48 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Ostrowska, Karen <karen.ostrowska@intel.com>; netdev@vger.kernel.org;=
 Sokolowski, Jan <jan.sokolowski@intel.com>; Drewek, Wojciech <wojciech.dre=
wek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: Rebuild TC queues on V=
SI queue reconfiguration
>
> From: Jan Sokolowski <jan.sokolowski@intel.com>
>
> TC queues needs to be correctly updated when the number of queues on a VS=
I is reconfigured, so netdev's queue and TC settings will be dynamically ad=
justed and could accurately represent the underlying hardware state after c=
hanges to the VSI queue counts.
>
> Fixes: 0754d65bd4be ("ice: Add infrastructure for mqprio support via ndo_=
setup_tc")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


