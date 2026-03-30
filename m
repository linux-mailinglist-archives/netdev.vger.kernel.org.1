Return-Path: <netdev+bounces-273186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BNGMCV8ymnk9AUAu9opvQ
	(envelope-from <netdev+bounces-273186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21A35C124
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E043021992
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFE93BFE5C;
	Mon, 30 Mar 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHl5mDfT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484F3C872A;
	Mon, 30 Mar 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877109; cv=fail; b=PgG8erI0+FF79uNs/E8mF65BtaEoFn3uIhOcl3lQveRS+/eSaSdOVJr4HnJSjh6L5meoos9HBmQEzFqElffaMn/f36I2Nb6k9WWBqILYOWDh98AcG379G49xIwcYETJb5xi5rZPxTPhGIhqqR1I7yHOzWYQCly6YuRBN76BxSaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877109; c=relaxed/simple;
	bh=6QiThNCrbCcIuRVJBF8Y729i77HMTFotYmHc/H/JZig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVAtadrwWlPYn7GAH+VzFJw60UQyTvevbJpWSpus5K5JrOq1o7mhiwARZt5qYEkiHL5gnpAywYcwLCpRa3bVO1iB8FivvByAUzy/vW88VlESmR9bs9y68D/fwbOWYxyoLTQbtAEogYxd6ykegRE879phMQGBpg63Llp0TUE7DEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHl5mDfT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774877107; x=1806413107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6QiThNCrbCcIuRVJBF8Y729i77HMTFotYmHc/H/JZig=;
  b=NHl5mDfTCrdKG71jufU0BzV/UsxWZFDwGeYISEEEC2s/Jwm7YZwdOPpp
   mAD1sF7GAfjkm8t8UO0EcQfYc0jKdQCg/1g+xqZ7a9Qo7NWhqJ6EhONyL
   Y97quCY+2gK8aN9jCXaX2YwBQwrrrmBivSE0xvfPN2ZaSaWofeBRdFH9H
   oMxPjt8Uxk96itoD/fFarRPcM8zVpbumLN7iWta60furR4A2jL5Y9LNOe
   5URFM4vxB5mpGjAtF+PWLTqWN1f11N8frFeZK9HCNPy0KzmA7j5Lk7J/1
   UzpuPm/sxu3VdYNdIZ3OyKbxU4tsMXsMPcXNdr3ycbzujszankxQagyUX
   Q==;
X-CSE-ConnectionGUID: Vayo+hNvTgSPZY8Tvwkgvw==
X-CSE-MsgGUID: g6V68iUVSS6YBx73VK3KnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="74900529"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="74900529"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:25:07 -0700
X-CSE-ConnectionGUID: W1epLcYHShaIX6/CS3hNtg==
X-CSE-MsgGUID: scaBdPvQRCiCG9HEmLKWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="226312538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 06:25:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:25:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 06:25:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 06:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn8gY8jrcbDI2vk33MNx66dj61B32A0KU3K0TgoU7r0/NaIQuozOKspxhgWqXvKz8UzEb/eMnBBu1rRzvpkT3zs3E34+cnsD5CtdLfy6L9hAZ2DENun1rzVa7JsY+tkF4Ync4tDUD/W/rNFm788pZJFsWgmE7SewB5PTCQsBtDC++kgkytil2jUiPIN12+k2vLlO9Fj4x8tnAjuXawezHnd2YeR6l/as7tZFhbyPKajMnlwf3sEfUauANRlge2RM1NHttSjyEBG05ogF/qI3ZniL0SWbZSt9mUEngFpE92Eiq/3deCoNnuM+KOybzSb7bM6Znk2F3H7GB1r4vswrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIBDebk55Bs2/p3ZbHeNurP8v6TNoFGsSTENsHnBIBM=;
 b=gwCpFL667Tvgbu94pDS3Bx92gsOqXehlXSQ6JiWf5oJXNNyr2A+JvrtNS11QsDIwu6Jz2zx8ZPC6egwnpikkJ0ZERh4B++N6BhkCzY9tmvyDm82dqF+wXxh+Ua829qm3MuxKb7PwlFRoiTYEqe4SHWoDj+cQfe8Bah3U/Omo0d0drJ2rURSYReGchU8cN0ehu+efH80kh4ccCsbot1YF1Es9WL6WrcbaxyjcNmCuhnTDmKmo19Eh5OW9LeH7dCgyI88BcGpRAXPHsH3+dmgB72NUyKZ+sAEQHvRMM6siXRgdby5CE8pfFmIGmjnF6MD+i99hmnUcZHOkeR/aZdP73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:24:56 +0000
Received: from IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31]) by IA1PR11MB6219.namprd11.prod.outlook.com
 ([fe80::a2b9:8e8:c48b:ea31%5]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 13:24:56 +0000
From: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "horms@kernel.org"
	<horms@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH v4 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Thread-Topic: [PATCH v4 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Thread-Index: AQHcvT45y4yZpsVywkCFoFMqHqDESrXFYr+AgAGzSnA=
Date: Mon, 30 Mar 2026 13:24:56 +0000
Message-ID: <IA1PR11MB62196D389EDD6CF4C279D9359252A@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260326162832.3135857-1-grzegorz.nitka@intel.com>
 <20260326162832.3135857-4-grzegorz.nitka@intel.com>
 <y5rjyaqyvmnyfaj7o2fari2t6i2klegklpnwi7xw7ld6rmajqb@uovrzb76cjs5>
In-Reply-To: <y5rjyaqyvmnyfaj7o2fari2t6i2klegklpnwi7xw7ld6rmajqb@uovrzb76cjs5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6219:EE_|LV2PR11MB6072:EE_
x-ms-office365-filtering-correlation-id: dc4e8448-0f8b-4452-0ad9-08de8e5fbc39
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 7C4qssr5LdaiNLopdjkhu2c13BpTsoXuAWKbyXi/mZsygvbji/e7Fd2kBPN3hReqCFQ5slAB/9Banwzyv0mqVeE8okbOsvUu6yxJv57TttOD6WCJGkqDcnN5Et65HDZOtYqQcoO4VhRN+4Nz/CYEYcBPwRlrq2ZpHTrsJ+8XUwInNOGe4+VtTU7AmL1nBt0Il/myFHZ8YkUUHOjC0oJFxvw4OtLgRM33Ct75fVn8gbrqObiKZGMdkWuWCPxY0L3fdP3/MowWJ2/NEVWxCoKLYgzHeK3jNy5vR1pcvxiQynCKOSWneYrpftQ3vOOgFzO+BqJeAnbXEmLptuEsIrLb7CcetI0rl8ncnuB1FeX6fcr7SRUsT9IarW3rbLbJGiYNbezPRRVoyIWhD5aqVuUetO1yjhAFXF9G1Oj/m/GtUGoKU0UZ9hez6wUUp/o9HZlZradSQNWeL/J/A5D0VB9zpr+bZq7h11zxopTSdOIyvgOq75O92H+w3eKyam5ZgdC5/VX1EDvACbUvHjrraeOvY7EJcP72fgY3yr1MlaNjSyx5wcoWVbKi5UpjQAxdoVprGO48300IBFTHp3PLrl5goXePY1M5b2DlloQjGwWO/4FR69+1uHJjeulqthxczhyp1AofH3Qfm9EgEM0uvYMhVbQbLGHhP1QeyE1eelGbbaLprSvr0Nic4NGrbqleeCAI08ycJqDFDy+4vsQEZmyc5Amio/Lu+sVVeVG3lctepmm1ri59u1tS43KpBkTUd7R848lQbAwjbp8tcjFaP4dlBK0pOnJu1WFWy57/9o/we2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6219.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wTtEslTd55/5k0mTqr/puJgnvclrD3qhqQbTofVwuXS7+3P4jL+bDj35snpN?=
 =?us-ascii?Q?WV2qTp1t2Exvke5+8lQxABmTvk/BL/8O0OPknCAa5FfWb3p7hHq+Fuufq9me?=
 =?us-ascii?Q?XGa1j5PhZfFP4roe9v0QsksZ7WyGPiNEtjjNvZcw6aoD7hMzW4/2o5dX9R9c?=
 =?us-ascii?Q?IucEBmCf1HyUXhH3JCVG5XJQBwrYnL9rBR/KEZjAorhxKDXOQJMs0W6I9PPv?=
 =?us-ascii?Q?zaecLJlnFhGfRDYRQaEfHdZAQfB7qvL55y+eFpGmL6F5/KqHh6COFAEK9rd7?=
 =?us-ascii?Q?mZRufz/zoRLijgzcjMqCy6Wnv0yyr2yrcK9y8N+vXxZVguPxoi6tKqZebNj6?=
 =?us-ascii?Q?GdsqmJXuJwmDZILlL6iCGig9kGA6AnnbNJiFRzELnEwndbmtjaT7xuU6p1BI?=
 =?us-ascii?Q?Z+w3GfArvi/S+EY6fafXNnK5pbMsK37FWLfA/z0lZkeaQ58KsQNBZSvgQQjC?=
 =?us-ascii?Q?Js/ltvKYBHEJew2Yjr5D/ufV+MfSZ4DiGJE83QLbyddG+DAap9/DjS6jj5I5?=
 =?us-ascii?Q?e5/liqf/3FcP/YllfJVZpKsrIoUiBw6qtfVEChY3Kg9CS3ovni557ZAx1ZDn?=
 =?us-ascii?Q?zE4uXf2CPP2y2HGm6fkDq6ozdaVrsfUov/Qym5oQdy74m2Dt/tPd7HtCfZDm?=
 =?us-ascii?Q?p5dWFWGXATcPEb0odNcvNezHh88u6JbXY7+9HRSzEMIvaQIstkFEzeXY2k5g?=
 =?us-ascii?Q?p49xpRKkHxTq3EnwtmkbqSFeGi0ucTY62uqAzND6qv0SSsunB/T5H0moWPBj?=
 =?us-ascii?Q?N/YMLEatrxGIs+rWDWD4OSRLSShLJMYZukNZgjAreQvHfkRqyv0kys6Xu1T9?=
 =?us-ascii?Q?h1jf52qlC5XQPy2GUD3/3coWSETuETV/bPXL2uyKdq+YctzpzK+Qi+22zgwj?=
 =?us-ascii?Q?Ltiu+5h/j2ZLB9cYW15b+Ot4lXNdNR8b6QggueLBY/Y1Q3RJf8maodGlBk+m?=
 =?us-ascii?Q?PlmJyf8uMdokQ3E54po5l2dF0FkXiIWR8Yt1gyhGWvNGo2mELZfmlESYVJZq?=
 =?us-ascii?Q?G6iYLAlTqZAAP63uMVUpzBVQivLaN7BjfEEOKvwlBWlJvVEFS/ExBh35RYCa?=
 =?us-ascii?Q?gUTGvqf3Vzq6giN0FspMfWAG5r7c3at8Qx0yssvrHuXW3c56q1O4DHhF2YzC?=
 =?us-ascii?Q?luYjXMGW4PxRzmEpNcM1WcNZKI4YHpHzhv8Hpfkb+9ByBRZphw6B5lZNaBQh?=
 =?us-ascii?Q?RqtIMPdemq2i9TV5j5bYlTTudMZLYh48z2BJfO42X0ZdG7MqWJT/gUx9Usjd?=
 =?us-ascii?Q?h/cYgngNCXAjaGTDTP8KLQU5fwpBTiVxFEGQGyjX6ICgLnU8/V004kFhc/HW?=
 =?us-ascii?Q?j7KzEnLJkx8YoiYkAuuH+zsWmuvq+ULjiCIH/oSsbDHXSByIOMjt1vB8D2sW?=
 =?us-ascii?Q?qd48jTBIpbE4j4I5nVbDXkEJtIOzcJl/bjgJRsSefms/TsEQw6FiOH3dWdjx?=
 =?us-ascii?Q?nqo6oYByP93UyqskCqMVQl4AJuDO/AcfAW6AEsX4iRdC0W0SuMsT0kY+PCBg?=
 =?us-ascii?Q?ok8iOzTGEsVasGwUF8CTxV3D2B2FkDP5DDLRDeaEvlpaypXufipnC1KrNwjd?=
 =?us-ascii?Q?LOHuVG/ZxdGLdAIZWt8D8outDftYPaWrZru7x08vwu+NCY2bJtn+QpahGgwN?=
 =?us-ascii?Q?UNJjlQWLJJ9e4bTD+zjMIPphx9ITy4qgIbzx1SprV6rfCfnFc4c1PC8rUeja?=
 =?us-ascii?Q?7JKBByL2seY1mL0AmbktMCbKZxKXuqDRtEg9TriHZJYpzTVNNt3WGPnojTzA?=
 =?us-ascii?Q?707fff3hzw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HR4xnz6cZ5qkkNKwZpMisKvHHfsUdKPsPXmBFvG3/xweESIsNk2crxolQzvKOrxclIpSlSgW9eGTGDdB4Cj0RZW+G95VFEyuN0R5tt+4j5/BwzxFDALqtcubXrk4ioA9bgDGpjMb6D5Z7Jf2XsZDDDL/TX4gSLMN309G0VrD8tWCqmiyGNF5n5FyonIZ6j3YAwp8lvJRCXvc6cK2sBcOP333fU4xPM6/fueuviJie2RlDAGjbsskGi17Yw85Rc9iWTLkB3LvT1/NJlfVBkZMKUsD3IoDp8+XtSf2nundyvAR0ngU60SlYtDMsG8t3ESbZ/enATy9K/d4TNkwD8Zm+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6219.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4e8448-0f8b-4452-0ad9-08de8e5fbc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 13:24:56.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx9XEMp8LHAKDTFQQ4Ss0MxibD4LeiIGZvkpZDW/7KW9ch9tLF5YPMDLdNeMZE/YUHE3rstVhzfWr6MX0EBzJ/71YJFlsG++5SbrXJnJInQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273186-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2A21A35C124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Sunday, March 29, 2026 1:25 PM
> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; Oros, Petr <poros@redhat.com>;
> richardcochran@gmail.com; andrew+netdev@lunn.ch; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
> Ivan <ivecera@redhat.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
> donald.hunter@gmail.com; horms@kernel.org; pabeni@redhat.com;
> kuba@kernel.org; davem@davemloft.net; edumazet@google.com;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: Re: [PATCH v4 net-next 3/8] dpll: extend pin notifier and netlin=
k
> events with notification source ID
>=20
> Thu, Mar 26, 2026 at 05:28:27PM +0100, grzegorz.nitka@intel.com wrote:
> >Extend the DPLL pin notification API to include a source identifier
> >indicating where the notification originates. This allows notifier
> >consumers and netlink listeners to distinguish between notifications
> >coming from an associated DPLL instance, a parent pin, or the pin
> >itself.
> >
> >A new field, src_id, is added to struct dpll_pin_notifier_info and is
> >passed through all pin-related notification paths. Callers of
> >dpll_pin_notify() are updated to provide a meaningful source identifier
> >based on their context:
> >  - pin registration/unregistration uses the DPLL's clock_id,
> >  - pin-on-pin operations use the parent pin's clock_id,
> >  - pin changes use the pin's own clock_id.
> >
> >As introduced in the commit ("dpll: allow registering FW-identified pin
> >with a different DPLL"), it is possible to share the same physical pin
> >via firmware description (fwnode) with DPLL objects from different
> >kernel modules. This means that a given pin can be registered multiple
> >times.
> >
> >Driver such as ICE (E825 devices) rely on this mechanism when listening
> >for the event where a shared-fwnode pin appears, while avoiding reacting
> >to events triggered by their own registration logic.
> >
> >This change only extends the notification metadata and does not alter
> >existing semantics for drivers that do not use the new field.
> >
> >Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> >---
> > drivers/dpll/dpll_core.c    | 14 ++++++++------
> > drivers/dpll/dpll_core.h    |  2 +-
> > drivers/dpll/dpll_netlink.c | 10 +++++-----
> > drivers/dpll/dpll_netlink.h |  4 ++--
> > include/linux/dpll.h        |  1 +
> > 5 files changed, 17 insertions(+), 14 deletions(-)
> >
> >diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> >index 55ad03977d6d..c7fcae76c3f5 100644
> >--- a/drivers/dpll/dpll_core.c
> >+++ b/drivers/dpll/dpll_core.c
> >@@ -71,7 +71,8 @@ void dpll_device_notify(struct dpll_device *dpll,
> unsigned long action)
> > 	call_dpll_notifiers(action, &info);
> > }
> >
> >-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
> >+void dpll_pin_notify(struct dpll_pin *pin, u64 ntfy_src,
>=20
> I don't see the reason for "ntfy_" prefix here. Also. It's src_clock_id.
>=20
> Could you perhaps consistently name this "src_clock_id" here and in the
> info struct as well?
>=20
> Thanks!
>=20
> [..]

Sure, will update it. Most likely it came from very early development, when
I wasn't 100% sure it will be clock_id.
To be updated in the next iteration.

Thanks!

Grzegorz

