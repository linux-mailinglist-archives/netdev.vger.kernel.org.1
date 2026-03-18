Return-Path: <netdev+bounces-269083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEdWA5LIumm6bwIAu9opvQ
	(envelope-from <netdev+bounces-269083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 778002BE826
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C8C930B46BD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3E3321DE;
	Wed, 18 Mar 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkNy6bo8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73403A3E80;
	Wed, 18 Mar 2026 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848362; cv=fail; b=oywCxeER8rkqs/KNdyEQP+o60pHs9M7ucb2MlRzo56T+4T8/5Tfza+g6sRVABvTwEdQTX8xoqoqHBQYFsprN2S1ZH1MTcJxo4/PjhLVT2l8bS7hLv+Y0OYLT7pEOCGXEYucRrjyFjJnNk85Z4JVUL+4JLSLDj8rJKstXWl26Quk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848362; c=relaxed/simple;
	bh=LTwPFVtp7andKBlBRTdlgJ2G1uVirPwLGSam2lQDIxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7FZKYpf4AUAiQMqijJOxXYqZbNJ4DmT0fe67/fHHIKMQ6lV7jrzRrbyHcFrZXZZ9bUvhAZz8DHyki60cEgkbuTEiPGpKeJhNjHcCSUhTzT/KCd+PqOhVxacyWCoROnmTJkWu7UjotsRvir8YKUEz6yqpPd36AV+61W46UO1oqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkNy6bo8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848359; x=1805384359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LTwPFVtp7andKBlBRTdlgJ2G1uVirPwLGSam2lQDIxc=;
  b=PkNy6bo8WG34jEowN3FoEee2ptmUSOA556KAgEVq7gtmxwUQ6PUUELwj
   BeBo2a4jX0qIVOHXvS8ANVYIIiDnQhTHDTpAdg32w5A0ZdCv+Evv+Z7+U
   4CdevT6jnzZWafBr0vWy5/zwpgT/DTzRDYBc+YNzQtTRlmeQXAGeSxHCD
   ueW+N3n1enP5c0XLrcSQmKoYrt5Xa7ZANccoOo/grYEnt/qFuEdX5VXX0
   GvxkrkDnA30KiKT86QIgX5hyPboldGwWDORse5StDwVeAEbQn7n5aQtjk
   WVUHpuaUzx9wFhFAibLHawqUJ8i1b99UdiRclZxhSjypPbDeKn3BjRzHi
   Q==;
X-CSE-ConnectionGUID: RUjf94myRBu/SqFPW/FYEQ==
X-CSE-MsgGUID: 61EAgQadQfy7RYXof1OOsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74605891"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74605891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:19 -0700
X-CSE-ConnectionGUID: U4UC99ozTvCiIGIrqjYmQA==
X-CSE-MsgGUID: ErUGcMXfQQmTCe4GHaHXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="227352378"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:39:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 08:39:16 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 08:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2cZBnNtr4n7JshVKTIF6/HLf5V7Ar6eh0nx4yZu7DliYnq+9D/XkO7yKGGfU1++O6iKmBsetldsygWMwmPRFbMpClHgPvPGFwJODghMZyLcjLzoAMnPCM/H9XPSPGkJG76YlQ8gVB4LynvQAdOtoE3JkrTNKJ7twUdzIwOqXHXbXTyUxGqeAbJiEAl0ZZ0iw2/LdJNYxcvq4+nNhEN5LHudrjG8GShk+G0Fv9AlEWNNZfGw3L/zbct40BEbyqdWHLq+tNVm0rBD6mXHIrrjSFhmb1PfH/SrdfCXDUaUpVk0qfwEQ7p2qFeXOP43vbAJ+GsGrMycvPXu9wB0ArluZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4u/Dk/EeCAJOP/K+my4OugdEbogxJ86Cw8VH2bRas4=;
 b=lIQQCEd/j0yIw0U0WuMQPQIuVona/HFhy6GDPuQGAFcOFJMug9LUBtQLlbHDltJdDOtLzyhxtk41QTM7EBQOK7+51J7g7YXwIK3I/TsCAtwS634+dZHmmFxmeC+063FT7v8q6dVPJWr4Cboddwktb0Hplir/PmPxRMQrFLVlX1MEeA09fsyn1OhXMkBGim9j9sefpukhLpzkz4fwiOxwm0Dn5SjGF5AD97nzehNQsxIIyFoVGqBcmhj5iOfYgsYAU+Qb/ZZwj4HEhMci1s+N8YuZoXPJZoQ27ry4NLwc5JioJVIJbrcj7chcK6X+V8f1RxKInSrBihKnNRQTTUXnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 15:39:09 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Wed, 18 Mar 2026
 15:39:09 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Agalakov Daniil <ade@amicon.ru>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Daniil Iskhakov <dish@amicon.ru>, Roman Razov
	<rrv@amicon.ru>
Subject: RE: [Intel-wired-lan] [PATCH net 3/3] e1000e: fix endianness
 conversion of uninitialized words
Thread-Topic: [Intel-wired-lan] [PATCH net 3/3] e1000e: fix endianness
 conversion of uninitialized words
Thread-Index: AQHctupBq8dSCa/7OketGR9js+T5FbW0bN3Q
Date: Wed, 18 Mar 2026 15:39:09 +0000
Message-ID: <IA3PR11MB89866D0F0CAA8690D5548790E54EA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-4-ade@amicon.ru>
In-Reply-To: <20260318120512.687149-4-ade@amicon.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB6500:EE_
x-ms-office365-filtering-correlation-id: f4c1299f-cd4a-4b83-d2c7-08de85047f17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: HW+me4zjCSak5WKd+2q77zJNxPLVrfO3Nk5W+eHZvaAdu7ErKeL0zK8mogUe3ex+BLcGJBxhwM9W09Mw6TaXAvlFL1hi7wUUBA6f4vN+RMXmOYWu+1lLf0RS3a9SbqGB5r8wxd5iwVPaRYb8AvvWe/ZiFCdl+rZvHK7YWUi+hKhcBnkoIUcHVRIk9OYAQfeQQo0fXLlJbl91f/nITN+J4pMiQm0D+AP8vVLU3snA0k0C5dtnlqhartf/pyl6AuzyiFgDZDWEUFaOhGo49MAu/EBYQa19koMz1Lw4Fw8M/1pQrsAblIkDuL6wULlthdwVcv9EnlSh5fT5CssHReZoRjs3BQqOuxgLkfSSEmD8zq8bpEYbpQJ2n+3lGtPoidJyhZ/nLHLLZPEDPKXWXdzMIor7OkwFB41xHhbtfgD9pz6sQcmC7Nj+ed9UuO1+P1XKdlvxfZT5u/dzC1LtPAhWqWFYgfQWYiNws3cv09ukHX2yM0qwFKYEPu5PptEomk2rcDdAa9JdwLb2wLkACzgb/P+6/ORBCWg7/gOj/ki9fn1dMleYyX3xwSfgKZTsCA6jeuR0UHcxCvyvf9RlSK75npAUSWS3LsZBeqNuHH41HEj1WuQ5fvTf7gDq5owJukWFlDVmiY+1Mjr60FSjNj/o6XVsNqJgNlv82cdBut96rk7M2rV6brcL1cgzMXicWYZBTHi75ET2PT70r72ZuyRm64VMkD6zOnvzj0xR6vPKjnzdonPfZ2O1sLvB90Ggio4S8j84qpCfNRAFXOrvphDXL+8LqDdA9XTeugdCTs3vk7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4TH0e2sC3RcbVOnLeKdgdXzYXCITiIMUAcxHOb6ijzxT6EPCTMs7e+H9Z499?=
 =?us-ascii?Q?AlRlmMmhFMAFktr98EGZoJ97oeURtCSPtSBbrKKDRcffQjTdR8bKgiuNAV1P?=
 =?us-ascii?Q?w7TjndQiVlYlCjl41N0e4puRkPZcoYulXUYoXHhyjoq2iZFJBeBFve5Ato7b?=
 =?us-ascii?Q?juXMxTA8L9dQMJFIpHmTcYZnKtcuigMIU7ZuFyzyRsTG0IjJNgNF417sxqJo?=
 =?us-ascii?Q?aOaI2Ic0qh7PxLoPw3UQQQFSHP8FfWcvrwujwhDzWZkvaCzIzh1hkP3nMfCh?=
 =?us-ascii?Q?JpUrHht5O6eiKUhIt2Txr0EMaZjPeCdQby55o1j1gIwGe7+zRo+sGZZJfJ2T?=
 =?us-ascii?Q?dTyfMkK1CHIlIVfmbR2eJQZhmpN5WHjZNEr46Fr90RwmTRMIJPENakUCYQza?=
 =?us-ascii?Q?nEl0LkTMwRYIlTVF3LUwRnllD6fP9kOFb36YXT04ZTfXeHt6GTvkGOTKzRgK?=
 =?us-ascii?Q?OXROm4qF4Xv9nQMAb3LpqQcOWQmiGAMH7As49nUWhoF4+IBgXgLzAIMUudjx?=
 =?us-ascii?Q?FyvuR2cNuipVXx1Uvr8i4xjJBhTb5BSGH6D16jaeQojFKGiUHS4+v9t+1mIP?=
 =?us-ascii?Q?70VGttitrlVabqMqoqR4si+is6fLOdxQ1PTc/FippxzfhIDJByz99cEtfMRr?=
 =?us-ascii?Q?ZChzPg50W5tg91BGgSv1nvqAEbsH13N5f7pfk6d65p8nGC+TXKjQ0nOyVQzE?=
 =?us-ascii?Q?n9SzZnbjw0o9UCAT+WbM0Ov5zLWhaFoQ483K4jPoSHIp3vaYQ5Fs2f5T8ERQ?=
 =?us-ascii?Q?zutlcwhTvIoA6YnChFWzm1UADHe5XU+WeNc9rwNI0WNmRCUbpOug6F2Kqz+d?=
 =?us-ascii?Q?XPrJe48i2VK+AzTTmxjvC2/efhdPyu9WQDCpo84AgwKglmVe4kTleNUZnkgS?=
 =?us-ascii?Q?oy0dlcC2NctVcN6MTNs0ME1Vx+omxZvy3qQpMxkGyr/J4Sx5tg1nJDWhk3OG?=
 =?us-ascii?Q?th4Z5UhvkE4IZ+yHfKmNu4U4XcALlT33KBA4kZtolcBApi50+X66ziZmhrl+?=
 =?us-ascii?Q?2XwEQ+UXY9UpTYY3Q2VdHmqW1owyslCiqQrXZTZYVohfuIj3hXR6ld9S44D7?=
 =?us-ascii?Q?Le5US2/leNwjcmI5ui/vH/7w/fden3nNYGGKoMU3fnepjE2rX62Ubo2IkRTJ?=
 =?us-ascii?Q?LxK4L4Uggf0k3iY8fCRIZeRwHe7G+2rOSutiY/drZwNuQo5cEmkLAR8/SQZr?=
 =?us-ascii?Q?232fSIlYWhKexPdIjEXsrxQKyOGIL+OsMCeYrrRV/Ng//eUEVwt7JLr8GDeF?=
 =?us-ascii?Q?Rl6xSRQfwlJvD0vpC6OEaaTWiX84g+SYXfBkk0z/fHGRg6YiU5HTcSvQTazU?=
 =?us-ascii?Q?edXgj5MGK0CNkMyTKLwI26xSPrVbjUWIeVMb0VE1v8kRAJ1XGyHlVVAGiwcN?=
 =?us-ascii?Q?JNnw80bT3Y+LjI7Kn0DF417IClZPtlIL1hSE+GMeqcULZ///7uBTt0WN+nlL?=
 =?us-ascii?Q?/AbPuw667q2PMHf/ZbvvfzpOaCrBs5QPhi+QUu515x6I/OikqvIq4sSmJD2X?=
 =?us-ascii?Q?CPSTitgZt5tAELGt6fn2VuIIJ1YrYaM2Ll74CyWJ5hwRDhBBlwMmex1dgJG/?=
 =?us-ascii?Q?eym/RJ27EUzkhqqyNufI3NRQlgz80xoQ9TzaNLPGFDiBc2VZtAgtPk5x9Eqw?=
 =?us-ascii?Q?rvsChWHEoP8q2N7sCny5Gyoj4G5FfolbzmX/RMsrfuvhQSJvfiPywXsOTtvW?=
 =?us-ascii?Q?pZTBJjnJLRdjTwbWg9AkemSGWnKzcqlo4RG0JkgD/Rc/H8ORCLvOKcThuGj/?=
 =?us-ascii?Q?obZUJMVm2FkgvhYFmZMCTwtda8MbmDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X/eWl7wE/KZ/h9UEue2Lwu+aQMppAbqw8awC9xB2h9mdpafhP3Sa96Rbfbzi9cJFQfAk5+XcNEMRfLiQ6X8E2LND4UFkHAwLR40E5pDsktW4aa0LFTKrPSofpAgfMlM/92huRhnqrlOXt8u5SqgIP+FvVu8nxesNXA8ZULn4G8oYacfvsaCSEukX+9zhURet4YLLASuZtG4Nfpbap/tijeDyXE9oJM6cqsP/8ZvVzzyTwIZ+6q6C5YjkA/w09ztG7CTpRIyD/mfafsBQYQDayleR9rI4ZXjd83fxNphf7LndG8XLapIHFnawLj2Fa5zcDGo139aZOFA4qu7uoaILlA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c1299f-cd4a-4b83-d2c7-08de85047f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 15:39:09.1322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UN973+WpUrSiKf435qezZ8qoMmIBGsXiDrOLm9gk0C5pUtDBos9vVf6XU7Ety85xhXFvkrCy2N5OIrG7fX97VOrPlS3/yBE64riY0MX5b5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269083-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.960];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 778002BE826
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Agalakov Daniil
> Sent: Wednesday, March 18, 2026 1:05 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Agalakov Daniil <ade@amicon.ru>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-
> project@linuxtesting.org; Daniil Iskhakov <dish@amicon.ru>; Roman
> Razov <rrv@amicon.ru>
> Subject: [Intel-wired-lan] [PATCH net 3/3] e1000e: fix endianness
> conversion of uninitialized words
>=20
> [Why]
> In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> words. However, only the boundary words (the first and the last) are
> populated from the EEPROM if the write request is not word-aligned.
> The words in the middle of the buffer remain uninitialized because
> they are intended to be completely overwritten by the new data via
> memcpy().
>=20
> The previous implementation had a loop that performed le16_to_cpus()
> on the entire buffer. This resulted in endianness conversion being
> performed on uninitialized memory for all interior words.
>=20
> Fix this by converting the endianness only for the boundary words
> immediately after they are successfully read from the EEPROM.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
> Signed-off-by: Agalakov Daniil <ade@amicon.ru>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c
> b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index dbed30943ef4..a8b35ae41141 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -583,20 +583,25 @@ static int e1000_set_eeprom(struct net_device
> *netdev,
>  		/* need read/modify/write of first changed EEPROM word
> */
>  		/* only the second byte of the word is being modified */
>  		ret_val =3D e1000_read_nvm(hw, first_word, 1,
> &eeprom_buff[0]);
> +		if (ret_val)
> +			goto out;
> +
> +		/* Device's eeprom is always little-endian, word
> addressable */
> +		le16_to_cpus(&eeprom_buff[0]);
> +
>  		ptr++;
>  	}
> -	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val))
> +	if ((eeprom->offset + eeprom->len) & 1) {
>  		/* need read/modify/write of last changed EEPROM word */
>  		/* only the first byte of the word is being modified */
>  		ret_val =3D e1000_read_nvm(hw, last_word, 1,
>  					 &eeprom_buff[last_word -
> first_word]);
> +		if (ret_val)
> +			goto out;
>=20
> -	if (ret_val)
> -		goto out;
> -
> -	/* Device's eeprom is always little-endian, word addressable */
> -	for (i =3D 0; i < last_word - first_word + 1; i++)
> -		le16_to_cpus(&eeprom_buff[i]);
> +		/* Device's eeprom is always little-endian, word
> addressable */
> +		le16_to_cpus(&eeprom_buff[last_word - first_word]);
> +	}
>=20
>  	memcpy(ptr, bytes, eeprom->len);
>=20
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

