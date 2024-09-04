Return-Path: <netdev+bounces-124921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE296B621
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B31F25CC7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372731C871B;
	Wed,  4 Sep 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGVEu2UD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D671A727F
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441023; cv=fail; b=KqlvI7MjS9FgH/wirCJ1jk19HHVqs8wcTnEgA0iHu1t3rGrc+C3+c89EIxv+SuYSEnGwKdYWa6UGDo7QSAicTpNc2GcFe2NE8R5L+Z1QyyfX9Ygd0c7Qw855YSX4CUvT2MGTavwNijjZBcAwqR4+FtDAnrsB7f6zPRpNO1vYPfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441023; c=relaxed/simple;
	bh=SmHmTIYM7DK5W4CvBsnQGA0A3tafacV4zQppy9DUQwY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/er66iO7HPdx0/2oRsLW1pBO+SoO52wW5XZMATLgV9dyYjxJf9Uf/YcqBzyUzPkuu+QwhxyBRtHTJTLyKfjr+SnTWqLd9Tii4c+VM97l/2hpudZYhEl8IsRnMXIm2Ktu7NjkCytaC/WvrwKDdv3VElCzIPza96ZHPlfhJSYErs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGVEu2UD; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725441021; x=1756977021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SmHmTIYM7DK5W4CvBsnQGA0A3tafacV4zQppy9DUQwY=;
  b=DGVEu2UDWYH5jJEIb0hAjoixmMJ7HrMMKVZGt6dHNbDgJueLyC0p/4BB
   miR/t9MHPd0sc4hSojpDKkmMgP54eXvA/NgTX31YeuFheM0g3VlVMrXP7
   momW8JZn0KC6JSY1Idr5YRRxOxhd+SB997ekpsiCxdbyV7Vx9c5JJG9RX
   Hr7ZuPM7Cs0xB8rkSjvoJGrlw2md0QN7i9zpW+sKbJpR4onJTsDO/yPom
   uJmGuVmNNF2ebIVXT7eMoiqUTVzafznSzzSntSm0hkFJjTrC/vhr+imeW
   NhzougAG75ozY5LMiBzdmi07LJs41af62IK1Wm4rNjr/Ww9iDhjYpsW2m
   g==;
X-CSE-ConnectionGUID: DDVuEqJKRV6TvyGxJgx03Q==
X-CSE-MsgGUID: 7GJ0YoHXRZOuipCjqcmLpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27878366"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="27878366"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:10:19 -0700
X-CSE-ConnectionGUID: 7PAXUelmTqCeWI9uWRhWPg==
X-CSE-MsgGUID: FB3yjoO/Rrq7MXjFIVn0vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69607294"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 02:10:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 02:10:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 02:10:17 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 09:09:39 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 09:09:39 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 2/5] ice: Add
 ice_get_ctrl_ptp() wrapper to simplify the code
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 2/5] ice: Add
 ice_get_ctrl_ptp() wrapper to simplify the code
Thread-Index: AQHa88vCOUqR0ZbXpUyJ4mUg+9/Ej7JHRRgg
Date: Wed, 4 Sep 2024 09:09:39 +0000
Message-ID: <CYYPR11MB84299D886989E674034152D9BD9C2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821130957.55043-1-sergey.temerkhanov@intel.com>
 <20240821130957.55043-3-sergey.temerkhanov@intel.com>
In-Reply-To: <20240821130957.55043-3-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: f19f95f6-c726-41fe-1c05-08dcccc14e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WU/fDwsVa/ehrBj5G5grzXrILSs1TjFmBSObRbIqbTpFVmaVSpYUsgxn32bT?=
 =?us-ascii?Q?KSnuXVhDd4zfsaSCaKNm/bDfCaj/fXtzYUB4LPJ9mtReWcKdA06kBIaksUfj?=
 =?us-ascii?Q?pgXw1QdlWwOl4lFOgltYsQtTv+1jV/szQM7ZrCEQXg8+qgulxD6ZkMOb4s84?=
 =?us-ascii?Q?+SKx5QZ93F8MD0Rb51XeY8wmL9pM9vRpik3s++7gF0DNR4LjXY4YJOHODweF?=
 =?us-ascii?Q?TPOhnPvn/6wLN1jPrJnx+Inuuo1eaEcuqbAuXpGXnYZkaHb63uGq6xbMUkcJ?=
 =?us-ascii?Q?m23nex815Iv2Cg3ZKpML7YAXGj6pdkKTO4cZFnOnoLakTZbaGqPi95O/qi9g?=
 =?us-ascii?Q?HUesS2dO5Z1wdXMx/DMRwFHX9k/VIy7bD+VqUlKJUk8AizG4PKYlLmJiF0iC?=
 =?us-ascii?Q?sEvwSzyvG8ZMDzJFNB/rHXZjlNFqro1/bzVbMSayihiZPaCt97qRP281HKhv?=
 =?us-ascii?Q?pE+iBFGcwJf5ugPPEnSlq04pqmNDjXmURQgGNoObErTPEGnRLOtlDxfjQe6C?=
 =?us-ascii?Q?VZKD6Qcpk56U+3eVANdsrnbktl08/Q6qSuO8e5KTJe7MqCkJ8H+WVZvN5wDQ?=
 =?us-ascii?Q?niDrl7dNsRWYTBx6JczH4gUp4ulvpMwNrNPXYLrC1TWR128OgUATy3m+CZ1i?=
 =?us-ascii?Q?ObDvve8YbQlaSF3RL1qypDYn5U7RPaVAkeqNh7XogqvbEYpDthE6ZZw2M29M?=
 =?us-ascii?Q?kvAamr24NDYIH7Yt5xQwvUZaZcXk4/4sN2yMJMq4cP2ahlUMAdCCC+ubzSTd?=
 =?us-ascii?Q?NDxjOzvqvAlsMe1rV6az8lsH+gd07CxHgWHGVHVUCs1DPNCidntO1VdzkxZL?=
 =?us-ascii?Q?RCvf0RZrdEeoR0FcVxQerVLdkg7Aybuu3K5Jgm4iYgFIe4htBbsdz4AjzQ7i?=
 =?us-ascii?Q?I8ixb7IzLwWcA2UGNe+1/RAwQfHKpEL5JIns3uGSHzR8saDksdBFjiowP0Lz?=
 =?us-ascii?Q?jKbTZ2tiad5unfeGpLBrblp8VN5XGBwziYSoARTwx4BxU8eI/OjdDsLR8V27?=
 =?us-ascii?Q?A4zThcdcrw+cDBUglf51XNiXFrHHpTlTa4doRoh6pHOA9CFRJftzdD6gCfho?=
 =?us-ascii?Q?qZyAMN9wkrIRHXfN9OB9oCXtofTQ8COoTPJSjx4gvrfzvSNnlKWoNA/jIVmy?=
 =?us-ascii?Q?2X+Q6spb4WqtFFcRqm8v94RLfElb9VMCLsvSfJswEYaOrjJPBJVbLIE6V93h?=
 =?us-ascii?Q?Tkk3xiu+kI+rkHOGcjnxgeoV5YH0jDZCkK27NJJifjbKJ2HBkM5W7lJhsI1q?=
 =?us-ascii?Q?2ksBxq8jcb3wLeF2rUaJgKfERiCQ09Sx4An31OjsHIrKgNQA+gOdEaDfDAZp?=
 =?us-ascii?Q?nydm/OHjQzhqfwwr1HHqv9lDGkeYkti5tzkj6mJqdfbqmJ8yygDQFeZgzMqf?=
 =?us-ascii?Q?FT1nQbBPOEHpXZgxOrG7fx84VJIaOQV0iMvpuFxSEZ0KxjxEjQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k4KAkYljfu0d5vCHHv1m/atvWiZr6qKUEIesfbxDGjwYFcbCCbGNzJcyxJUv?=
 =?us-ascii?Q?P5XYIdjZqjd5q8Xj18GHYAKnTWKcjI3yLnRatLGJwQlFf8onWnd4+gszFGJ4?=
 =?us-ascii?Q?R3hJdlvcwuG2vM9MRimzDVvMGRmf3jvLe20oetfYKa6r4z5Cj6685Y/3wzoV?=
 =?us-ascii?Q?yvg+IDDlc5uvbUqyWMPReBbh9QFNZUvGoKvCfuzzVscabgFU7QvLzNkq0Uxx?=
 =?us-ascii?Q?XiNnD/fyrdXrzrUNQsvA6s0kFgCuexArUYbl3aPH46lKwgeFbxYDmEpIH8IP?=
 =?us-ascii?Q?bk4OPlqfAg8jUg1pLDOGrfZ9+0UNoA5CZ9HsKDCF7ovpHcK5amTnLT9iCWGd?=
 =?us-ascii?Q?3E9Xf8EVEwpxnevAi1fiZMdw7FihUyewXi0pZq4Dw12GOiObTlrFrfwCm3ha?=
 =?us-ascii?Q?P7rmJ0krWaJzOtjFWMfBErXj5p+oNW9ZxE++Bin9aGrZsUzyPZmROvg0JgpN?=
 =?us-ascii?Q?kBUaOSvFEQKfJCKS3GP+nAKQye1gKetjpGvkwfxBfsQBipXBEOqYKgnekrCT?=
 =?us-ascii?Q?DRnRsRyiukVrrnVPvJH1UUx+2XxsM4NOTbaRyov0ezgvRlmiAL8bxTfzqr3p?=
 =?us-ascii?Q?BpLSwGs000At+9eLnZpx1U0zDxAmNY+U/pQqTxFooqlmSwpbE15+X1WEbKrL?=
 =?us-ascii?Q?Xjhp+A7iUOeYV5iPqIRo2/FfnlqEX2GaxyiV9wmsVgFNpOLpB/Slx7WbI7WQ?=
 =?us-ascii?Q?phUUabZ+QXTDDhbS9W3S1XZo0p9ZasH7thFujWrp7MmogsmUGw91JDVsMdGc?=
 =?us-ascii?Q?qkRBkZusHK6BX9RvyL+Q2xFyy2c/aHGgx3CpDqW9NTx5DwtNzWXOmfm07FdV?=
 =?us-ascii?Q?njlnRu/NaT1dMiTobTw3rHSX30gwnQ2kIb42E9uPZCvozNAM/5Frefanx9mS?=
 =?us-ascii?Q?flBMzCMI7Q+Poch30mymvSm6W4oF88pXPG5Eqssz8hQVBJCfkTXKzWVAnU5W?=
 =?us-ascii?Q?LzuciO6AFba0nguv8ZrGyxx3QQnWgfOnmrLBColn4Hg+13Siol46HskpmaU5?=
 =?us-ascii?Q?FFFetmb4dbn6gFSMcDk5rtpEjK7v29u/QCUdfXfZ2UhotMYoErhSnScJIyp6?=
 =?us-ascii?Q?VwBe8ZOs3vUc8oBlhycDp6NjjYA0U9xeVrJxNrtkf8BE/2WOXtuyyxayrGEf?=
 =?us-ascii?Q?pmxNqf8+D9tRm8IRlBKvv44fiOVJzomD5P/jc6/0pDUKxvmTtebTfH4m7jHQ?=
 =?us-ascii?Q?iX3JhXZaCapA9NIjy3dXYZRKSXbcZwgCIsk+Gfu5L82EUa0jqXzWTyeRLo1F?=
 =?us-ascii?Q?bHYgSTkC2S6wfFtl5vvr5muOmdH9eguOcUNCtcFulZLHpbVCr4vTvhkY4s5s?=
 =?us-ascii?Q?mNGScdrrwh8SxgQYVRvFOsX0qn774Rpqg0hZiuwWPWHbsYkO5Q1C/joT2iL7?=
 =?us-ascii?Q?fAoIbpexceFhYD+1dsUV+th7ruLrYl+I8gfJdspuQyVNzX6kb5zuI6Xj3bkx?=
 =?us-ascii?Q?aeZEYzOtD6Ee0c0NFwd+LjbsNbxSVaHnKnbJ78Gw9f1RpFJYDz+xngIwB+Ro?=
 =?us-ascii?Q?QoPiuh+QOAvKTWQsJQDGZLqGtvSeKBbwjlAhtL7fu7Is+9neV2Snxe3ERL6d?=
 =?us-ascii?Q?ZegH5tX0FREroxQTxl63DFhyZKA/1hwLW1GaOqfHdZmpujMq1sif7VSXUqAx?=
 =?us-ascii?Q?SA=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls/DFXVxUMdYPf6cvnybiQTNiIFrUnZuP0EQjrBrLpQiEkJyquI1lJeJE4llk9C3KVoB1hkRm3mmqFKcKP3GRY9oYJkXiKkxyFlq1wkZMo3t3RNeAE29/l/PaATIVEL7OAK9c37YUN1+hEM5h2klUiSJxxCT4px5rqtVA8E42Jh/d+9g3HXMML7kzOo9lDSmF/gsWXE0irHWVC1NSi7Pr0BL2BKhS15oWeDgv2krn4Vfxc89xWXGEp6WxX5aCwvKQYpFhNjKU5pNNlVs/4C8L/Owg1C/78/Gc++Ng2F46rCFPRFZfQCyk8OJqpclK/WcyZb3TZ1ORPrxmBlB003FPg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kETxs8jwndaTAS41hBX4IvUQqV0GcbTEb49ovNmph3o=;
 b=q5Oe+scXc2g7teQpYurS2LKQ0q8zVBHaVCMd/D11C4rfmnf4QCaOsOQvZdTad8lWdb7+QuSy2KfIF/wlZKfBvKwLz0gyv65ahNlldaoVlvKXonTfZBGAQ3VeNXNQSlCxVyTXNUz1c95YBQsar4mPrf+jiokgM4K3YBsZHC2ysR0D4NG/jNBvxJfN2O1XZB1AfgROqr+BapNN/wd+PVKQQNOIyVHFWCDx8OB43gcoX461aqwgaJ7cKA6ExCA0HoryB9JfdMXC+OXw1K8mT5k+sxZXxqlGSwSL8M3isLSlYZAie320sZ7qKbWL5lLugqnpL4SJBw/suXhi+WY8rpSXPA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f19f95f6-c726-41fe-1c05-08dcccc14e64
x-ms-exchange-crosstenant-originalarrivaltime: 04 Sep 2024 09:09:39.5578 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: XywYNtwKeg9bgrzA/puiys2W3C1gLdipO1WawrpR70imEFkT8doRmoN/CDruiW8OhRmt9Zfjr3VBDhmC4nvnFNBgH9WYgcDc94k1ocIchphlDEZl82qAfU6FivZMit9G
x-ms-exchange-transport-crosstenantheadersstamped: PH0PR11MB5830
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Wednesday, August 21, 2024 6:40 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Simon Horman <horms@kernel.org>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 2/5] ice: Add ice_get_ctrl_=
ptp() wrapper to simplify the code
>
> Add ice_get_ctrl_ptp() wrapper to simplify the PTP support code in the fu=
nctions that do not use ctrl_pf directly.
> Add the control PF pointer to struct ice_adapter Rearrange fields in stru=
ct ice_adapter
>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.h |  5 ++++-
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



