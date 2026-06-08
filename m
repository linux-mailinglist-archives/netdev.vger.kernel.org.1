Return-Path: <netdev+bounces-296622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IAh/D6bbJmrGlwIAu9opvQ
	(envelope-from <netdev+bounces-296622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFD657DF2
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dxUznlDp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296622-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296622-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7AC30EB328
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B83F5BE5;
	Mon,  8 Jun 2026 14:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1873EFFDE;
	Mon,  8 Jun 2026 14:43:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929804; cv=fail; b=S+r66ecm19qmlTnXuPKvAn7nANkulvTwqAI3fEQvE4qzj3/gjvQFB6B+BmINZQ6igxTzt6bq7+5fIvO/Q6lO1NP/lT74/wFjw5zKA0382Qr7MwhPrRYDmy2XlheU1wmhca5PvQdkyVz83Mx4Pvy+u8NHoxv1JtjKllEBxOcsqpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929804; c=relaxed/simple;
	bh=kMkqqRu0klChjzCixQp14tzM4lSK+q4/NNHY8UtuGWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=neZNmZitGL6DkeF2g8nHWeIAuPvrFVznuh+xhXeab9HTBssrBkuznba9fpgYHtpsopGpWyiDI7uuWmO6/Z4vkKfTIDGoCNti1VlgT/J1lfUnKlHUYxonVFildaAjR8es5KUwIge7BwrjCbBhHfAGl1dAR0CViVpUpa9IsniFpE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxUznlDp; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929798; x=1812465798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMkqqRu0klChjzCixQp14tzM4lSK+q4/NNHY8UtuGWA=;
  b=dxUznlDp3TF0QDXEPDvmtAkOTvyHKELCguExfoFZTOtYkNXfclwlaUZC
   DQyJPo3Cf/FVsXxBi0/iP20O1rX56WHw2NMN/czm51M9Co1ul90FCLiS1
   hrrX4sF/viKGdt4Ci4v+56DeIR7IOU9DOUDKsaM6Z2E3bg4gV+QHs4l06
   T2Ihd0RxuHTVS7pUCLgMD3Yf8/jMItlkDFbiS1icz+yPQ8K1kBddLg1Ex
   b2OCs9OO97Qlqu+38Y3ikvbP0W8XLXa7SMWoWF7SdLEtL9CnuzidyRCZg
   mOuBt15dqmOqSDwtd+HC5CPpNSu82YZey7WAJJEDQkGkvRl++lcEQT2dO
   A==;
X-CSE-ConnectionGUID: pvUl9iJzSWK6++69nqVXvw==
X-CSE-MsgGUID: /arzI5TVQjqZuCqxViV6Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107107955"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="107107955"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:43:17 -0700
X-CSE-ConnectionGUID: i1Lwe0T6Q6Cx4PymfuR8SA==
X-CSE-MsgGUID: xpwJvoMNSa2TYf+GiV69jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="244450255"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:43:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 07:43:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 07:43:16 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 07:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N76yzoSIj+WoiqAY8GkpfuHQbhnv0pjyveTpWlIvlziBGGEujXZSWIb0AMxcSomJGPvQ1qXo8JaiCuPl/mvol8bNvai+y4LaIvVFN5X32ni7GTdQP9NBNQYr8eb6H0+f3/6JAMB8/xi+UvoMtZvunQD4Bqd0myfFdK6bY+IQBIvoqnI4JZeFDl+z+dwEaUp7Buj48DYx+y8NLFz+ZDNmcWn5SqcIqK6EvDr29XhiMjzVPxbK6QdmnK4tyrmzetsNmJ1MgcAiHgQgC+IfrcJTNFIxAV5dYV5fqzPK2xCm+ciWQ/06GbqPK/GDXteb68CcUM22v/H3R1XBcmsPoE9A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w+o4h5ulj67AzWXhPSS0dZWvXrNjfn3hAnRNchuQRo=;
 b=y87HzfF6YIj6IUwsZxPs7gpDA/bNUhc3VfmaemW0/9o/6LYul/yB5KquL9CXcPaqNsBZaa8ipZFoqR7JCxPIkHL9+PGnqPD2+CPFPDUFVC64KWn8Y9R3nNYvnZt7V6U1HO7QP/FtJdfxI6xCecbYlm9d9XhoiDkDh4Q7ehlpQSOzS+bZDVRT7t58qYwW2Gar1IiqJ2cejXm5tP5pxxTsP2kWk8a61J8rrIjxmPUSUmStf5jdNYxC9vqujxSACByyuV6bxgWzUI6J2YT/rgLqgJJC5/PySa9dv38XyeTOqubyW7GKIUD6D5Ilo2NGdE+TJaBBnYeQMr2XaIMZvmGOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 14:43:12 +0000
Received: from CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968]) by CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 14:43:11 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Schmidt,
 Michal" <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, "Vaananen,
 Pasi" <pvaanane@redhat.com>, "Oros, Petr" <poros@redhat.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Topic: [PATCH net-next v5 1/4] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
Thread-Index: AQHc8TXy37RQpn6zaEaBmwzfbXb7M7Y0w/LQ
Date: Mon, 8 Jun 2026 14:43:11 +0000
Message-ID: <CH0PR11MB5394BA7DB19301ECD5F9B0139B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
References: <20260531194423.383366-1-ivecera@redhat.com>
 <20260531194423.383366-2-ivecera@redhat.com>
In-Reply-To: <20260531194423.383366-2-ivecera@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5394:EE_|DS0PR11MB7926:EE_
x-ms-office365-filtering-correlation-id: a4da65c1-a3e1-4249-75e7-08dec56c43dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|11063799006|4143699003|3023799007|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: MKpPWdb/dntjJbWSNc1mSu9WsPqV6oIGrEN82rUSbUhqATZtIWTxswCky1OO8n4CdedMxw+A3HMjow7HYjkO2xSXDtoGcFNjD77g7ekvFluBtX6+5ddNIL8+0vhRC754yY662tslOHZnw00Ch5qnj8T1J0mHfC8MA7wBjcUeT4NfVzVImqCVhaN8pCBnotRqxbEW6Iu6v/z6L3zWU8KSFoKlkBZq7S0kJ1wGuddtDQXFf/zNIrxe2fv4yM1Jno2fFo9yDgSAA9ftQtnr8/B4ihkWmEwaCUs35SRW0kBQLWFutOdywDfrgF4JjhVQbyGWu8sUyrjB2PdkjqDc3n19/5Bx6Zly+WOztHxbL+zAT6PJZR3xle+2sPVM1TmOp+54f9nIbDIWwdcJ1utvulQPL+oUgWx6BMcEr0XCYSGYCW66KoZfkFB2rlwhLKwSUvTi6hvC/g7OOdz9Z6bcfdpO4RVi8/NsHgmNsThDqSy00CwLaXfAXt9nlxJ8uZkIpCclLPrNhW4nguAYhdhEYX8pkSIlGcRWKwJ8/xByxRIeCKBiChCJX3T6PZEphPHGuSIfMU5Iarlygyvsl1hgLO9Mx6gcJonknVs8xlAInf7zzu6GTn9pJAfVnUF7kx5g7ZUAphrZofkFqvOI3AyLFxxEGii22yIMCItsnxShOGNabRXfaFpcSaIlfd9paf99Bi+3/rV8KE6I3pqJxjZdDXZBNcYUoG/4UNcMF0Ikx1bLjvJIQtXphjXroJYzbBGzX9hc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5394.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(11063799006)(4143699003)(3023799007)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SysI4Rr5UxCQNFBT41MI0YnIurhtCdSaJaoLrQejGDoPmwOZkjFOdlm4JjL4?=
 =?us-ascii?Q?kz/0asKlW/WLmnxD6NbJFLs/NzzgYqishea28oPkkoXsdE9edTXeYJOEf2gU?=
 =?us-ascii?Q?qPTUmKQMMoOoJN+8Kx/NExxQjkNsIdMB4GAxxSw8Qgb0EOJgEgDq5HuCblYx?=
 =?us-ascii?Q?b8H1BhdsWqoVUpTChwFh65Zz1CXDDh/atMlsvNfpt7XbLuvlll4XlGyENgzR?=
 =?us-ascii?Q?KLyfu+2VxlKtjc0+q4fz5d/cDpgLR6rn0ukItthMYYmtW8pRh7fH+8NZKebg?=
 =?us-ascii?Q?FzmTxxPR98FszWBwS2q3SAuqE5hc/21B7BVndocr2cTIMlYS7IUgxL/JDRZz?=
 =?us-ascii?Q?TJqnK4urrjO83FFaPx0eioD+EP9CTb/OS37F0FcDfodwGMOukazceO/zNDBX?=
 =?us-ascii?Q?dQWaJc0MEb3eK7lvmzSOlGAnp9cytrPkd+4cM5/Dup61zEzKAvat0+rW7fz8?=
 =?us-ascii?Q?LvDOurjmIWzuQ5MNDZHbXNSbNFuB6J+YndkfiZHV6zqF0cXysETbNSIMTVeM?=
 =?us-ascii?Q?pwv1MAmQcGhWWMxjg5riV6YRu46ju91QHe6R+GoaYAjMHWsgt/C88Tq4iyYQ?=
 =?us-ascii?Q?quWpQ1FK+wQhjYIiy3O3yjPi4VBDbfGVguVdq2pVX0dbqIVMZq9nzDqGC6wj?=
 =?us-ascii?Q?zD71fNBE66T2MHWuYCNnc9XvyLWoo6DVQ3cxAwUF2wgVFZyeLEX6IDPmo0vv?=
 =?us-ascii?Q?zbKkAQ71excOhPZBOApGBP9SXdk5imxpLYuKvOuzfnHGB/Xh0Rk6HlMMEGux?=
 =?us-ascii?Q?sxQx9I0JfbSNasZQWnQ2zb+TBllSNM/6NTi5bFs/sIF4L6EmMdzOadLyxxkm?=
 =?us-ascii?Q?CL11O+Xv0k0j0Zcvx6HIpmwNQnVP9/u+1WHnDHKj+pDZmfIfu9cyPnGDaigE?=
 =?us-ascii?Q?eiJc30Kw9A69VqUW5OLwUKMTGEHTBX/XvWG2LaWb9EBtF10GfaRcCcrIDicm?=
 =?us-ascii?Q?gDDM+j2FzvxJsPf3if8lhI9M32G1UmIuVddnZxzYWbTNJQn+9AERuorxxNXi?=
 =?us-ascii?Q?KbENQEJwpaj+i0O1REG5KWZ469/fGoRe9g/wvJH/RQbgSZu1Mut2IRO7KlJU?=
 =?us-ascii?Q?TEywcvgTpISrSgzhuvEHDlIcPd+OsosQmOQ3X6lh1RCWNGGVpcS+ox7wYH0s?=
 =?us-ascii?Q?Z8zF6ICsHQbi76pcz2zeLlBYZrEdStNbN6jHq9PVr9Rr5pMGEQH6TazcNAvz?=
 =?us-ascii?Q?oT381Inlao4AESSDlzBtPezPlF3n6TKz3I4PtcbrfUQc2kSmgFA9iQvvsfKl?=
 =?us-ascii?Q?npBLz+n9zqNBseOOmWlz/JsTBeYFr3QqhKcn6s875hl6FFu/PLGb8rrmY/rG?=
 =?us-ascii?Q?MqXsbwmAEnQY5m40/vH0IdlBVHCPwikglHHFqHWnviiMJcA5EaFJKNEkbFCn?=
 =?us-ascii?Q?Ts4bNNcWQx9tMrPFx7t6qWcxK9yMuFgrkyhxT1sPYrHOs1twNtFznBVaqcJN?=
 =?us-ascii?Q?xMU7jOgAHyWUbPqBhJuohVRFbE9BO6a4Mnp2MQhq8IaCN9E/arQpGocRx2BY?=
 =?us-ascii?Q?/dzk0Utz5qYZlofaxa7T5/b2t+WNH0uFa/M2iYJB+2LK1LATyxUAMbmtO5U3?=
 =?us-ascii?Q?b8kvD+jWeikr2tH14R+PfbE6pM01w5XNuJV0qh+ltp24mgIOA4a5FGPmZitn?=
 =?us-ascii?Q?MUd30ifBsepof/rEI0X7zJRirsvfO07bQ0YBc3p/2JIupjOK5b0T0jKgHpA/?=
 =?us-ascii?Q?EooY7u/ojIh2dIqgW3WQrL8sQwIeI6WAdY9EUM9Yh43tZ/MApeY0Ew/jYhcp?=
 =?us-ascii?Q?jW1N8XVsZZofJdzd/CR9CTLcpqn7XXY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CrdyY4vlXu9WLiXB8NGDREVZWP/Dv+SAyU/Z2uxPn15OA21e/KeZpywrg076Shyofb6xiG+fMCTwYg5TKBG29nfkCyLn0NnpO7BYepJ6W9bBFnT8Bfc054V2TQ7wnIk8I/GsNJ8z5Bx8IBnrY3FOhI19uhu8lfiVtEYaOneWoSSnwCb7VQ3VhYi2gBabL7nxho0RfKbLJ/r3vMa0Uz6JE97LbTQPjUeGUgPO1F0JYUdpDmMuo2M8Pf0ff+1Tpt9zbOp5FhmPPGI1evhw4xQHrJJ5RM7lIiVyD7WMTjUbRLmBVlE1iY/+QQHkWCMVoA1ZrMA/gvutVXemedMkZ9t58w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5394.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4da65c1-a3e1-4249-75e7-08dec56c43dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 14:43:11.8672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0r/g+MMZzT51LkHZ3o/6oj4B3W+KCUk8OZjlzT445mp41TuksNU4Z4CFF5TiaPAzN292fGmwrq5trRc07wUxueobtw2qsJ5kxJapXfglHBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:jiri@nvidia.com,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,microchip.com,linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97AFD657DF2

>From: Ivan Vecera <ivecera@redhat.com>
>Sent: Sunday, May 31, 2026 9:44 PM
>
>Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing the NCO
>mode of a DPLL. When connected as a DPLL input, the DPLL enters NCO mode
>where the output frequency is adjusted by the host via the PTP clock
>interface.
>
>Update the fractional-frequency-offset and fractional-frequency- offset-
>ppt attribute documentation to note that for INT_NCO pins these attributes
>represent the DPLL's current output frequency offset from its nominal
>frequency.
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>---
>v2:
>  - Clarify int-nco pin type documentation to describe frequency
>    control via the PTP clock interface instead of generic "controlled
>    by the host".
>  - Tighten FFO attribute documentation for INT_NCO pins to describe
>    the DPLL's output frequency offset from nominal frequency.
>  - Mention both fractional-frequency-offset (PPM) and
>    fractional-frequency-offset-ppt attributes in the commit message.
>---
> Documentation/netlink/specs/dpll.yaml | 13 +++++++++++++
> drivers/dpll/dpll_nl.c                |  2 +-
> include/uapi/linux/dpll.h             |  4 ++++
> 3 files changed, 18 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/netlink/specs/dpll.yaml
>b/Documentation/netlink/specs/dpll.yaml
>index 91a172617b3a9..5cdb93e8649a0 100644
>--- a/Documentation/netlink/specs/dpll.yaml
>+++ b/Documentation/netlink/specs/dpll.yaml
>@@ -162,6 +162,13 @@ definitions:
>       -
>         name: gnss
>         doc: GNSS recovered clock
>+      -
>+        name: int-nco
>+        doc: |
>+          Device internal numerically controlled oscillator.
>+          When connected as a DPLL input, the DPLL enters NCO mode
>+          where the output frequency is adjusted by the host via
>+          the PTP clock interface.

Hi Ivan!

How would you control this in case of automatic mode dpll?
Automatic mode DPLL shall be controlled on HW level, such pin brakes
that rule and requires some driver magic to show it is higher
priority then the rest of the pins?

Such NCO mode/pin is designed only for this single specific use case
where a timecard contains a DPLL and PHC?

Any diagram?

Is there any other use case for such pin? (NCO is rather a general
DPLL control mechanism?) Shouldn't it be called explicitly like
ptp-nco?

Thank you!
Arkadiusz

>     render-max: true
>   -
>     type: enum
>@@ -453,6 +460,9 @@ attribute-sets:
>           offset on the media associated with the pin. Inside
>           the pin-parent-device nest it represents the frequency
>           offset between the pin and its parent DPLL device.
>+          For pins of type PIN_TYPE_INT_NCO this represents
>+          the DPLL's current output frequency offset from its
>+          nominal frequency.
>           Value is in PPM (parts per million).
>           This is a lower-precision version of
>           fractional-frequency-offset-ppt.
>@@ -499,6 +509,9 @@ attribute-sets:
>           offset on the media associated with the pin. Inside
>           the pin-parent-device nest it represents the frequency
>           offset between the pin and its parent DPLL device.
>+          For pins of type PIN_TYPE_INT_NCO this represents
>+          the DPLL's current output frequency offset from its
>+          nominal frequency.
>           Value is in PPT (parts per trillion, 10^-12).
>           This is a higher-precision version of
>           fractional-frequency-offset.
>diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c index
>b1d9182c7802f..2dab99202764f 100644
>--- a/drivers/dpll/dpll_nl.c
>+++ b/drivers/dpll/dpll_nl.c
>@@ -61,7 +61,7 @@ static const struct nla_policy
>dpll_pin_id_get_nl_policy[DPLL_A_PIN_TYPE + 1] =3D
> 	[DPLL_A_PIN_BOARD_LABEL] =3D { .type =3D NLA_NUL_STRING, },
> 	[DPLL_A_PIN_PANEL_LABEL] =3D { .type =3D NLA_NUL_STRING, },
> 	[DPLL_A_PIN_PACKAGE_LABEL] =3D { .type =3D NLA_NUL_STRING, },
>-	[DPLL_A_PIN_TYPE] =3D NLA_POLICY_RANGE(NLA_U32, 1, 5),
>+	[DPLL_A_PIN_TYPE] =3D NLA_POLICY_RANGE(NLA_U32, 1, 6),
> };
>
> /* DPLL_CMD_PIN_GET - do */
>diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h index
>cb363cccf2e2a..9245827de3cfd 100644
>--- a/include/uapi/linux/dpll.h
>+++ b/include/uapi/linux/dpll.h
>@@ -127,6 +127,9 @@ enum dpll_type {
>  * @DPLL_PIN_TYPE_SYNCE_ETH_PORT: ethernet port PHY's recovered clock
>  * @DPLL_PIN_TYPE_INT_OSCILLATOR: device internal oscillator
>  * @DPLL_PIN_TYPE_GNSS: GNSS recovered clock
>+ * @DPLL_PIN_TYPE_INT_NCO: Device internal numerically controlled
>oscillator.
>+ *   When connected as a DPLL input, the DPLL enters NCO mode where the
>output
>+ *   frequency is adjusted by the host via the PTP clock interface.
>  */
> enum dpll_pin_type {
> 	DPLL_PIN_TYPE_MUX =3D 1,
>@@ -134,6 +137,7 @@ enum dpll_pin_type {
> 	DPLL_PIN_TYPE_SYNCE_ETH_PORT,
> 	DPLL_PIN_TYPE_INT_OSCILLATOR,
> 	DPLL_PIN_TYPE_GNSS,
>+	DPLL_PIN_TYPE_INT_NCO,
>
> 	/* private: */
> 	__DPLL_PIN_TYPE_MAX,
>--
>2.53.0


