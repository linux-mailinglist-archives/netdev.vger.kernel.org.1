Return-Path: <netdev+bounces-296640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IlyKEb70JmrVogIAu9opvQ
	(envelope-from <netdev+bounces-296640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B88659009
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:58:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nrHSnT9o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296640-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6B5372B447
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493B343D66;
	Mon,  8 Jun 2026 15:17:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C363451B3;
	Mon,  8 Jun 2026 15:17:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931830; cv=fail; b=lKdOuZXfDRztuitOxXWkmeefaWbikLHEqcH5lOe7t4Mb4GTPESNpZ1K9uXT2UIdvgjfus9brAVflg+vsZAK3yLxH/QpDhlBhIEbolg+R/iqRSo7C1beY9kp5nRVEqb9B/SSn1YcOuVtqm91IJUfi8eY+KwqyzAOxGhuff9Hj9Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931830; c=relaxed/simple;
	bh=k87A8Aa6v2RWcHqhzEFTMaftIYpU8PFUNlrDcai8OM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d2aa1OmCGx6ji0v8gUQbEsYVS28JxPwr2227Rm7KbPliVzDIsXrarTPMFaurZ23irUnLBy+T0mNfcpZakA+qZqAMLYGMdHdj7TA4Etv/GfFbZFvVAfQrzUqAkiUsS/wFNDcDikblzUWj0yXAhe8iEYzIFYELxPLnGfJoUHXBQaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrHSnT9o; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780931827; x=1812467827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k87A8Aa6v2RWcHqhzEFTMaftIYpU8PFUNlrDcai8OM8=;
  b=nrHSnT9owT+sBbAiXB/SAEsPmSiDmsolDpj/g4OfML3hKLytcLxediY5
   hvpnWpX/4tpp3VezwQGgjmZwUZphsUnrOf+RirTJbsegBKOQxfdYa6SuX
   4B50PyqMnN5oWmWvg+Fo+dz3PqvLXB/+Z+fowIp8wUETOOf4OljbmlyUD
   rnsnKVgF8ln4JfBNImGVdbB3KCOFNpS/40dI7hDI7regNKGH/cjSxVpwe
   2OW4cGuq3dEdwcbbAC7RB830bEQMFSBW7pqI1eiKo7GtgJ20uYkAuqPnV
   VQ/V8e5VcrhkGZjQE0c42joQwNUU92+YIM0iox2wIxxArX6PXQgFE0oGM
   Q==;
X-CSE-ConnectionGUID: SPD7cjuEQeWa95yVqCdgHQ==
X-CSE-MsgGUID: 6ChR+HH9RaiwG7bIv8CMfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="91994931"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="91994931"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:17:07 -0700
X-CSE-ConnectionGUID: ceW6ZNcoTrKVrfMUiDFm5g==
X-CSE-MsgGUID: Y0C+gAr7Q6eijEYNusv14A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="283661441"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:17:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:17:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 08:17:06 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 08:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQx86JZE5Lmawo011wOkno94dA5U6giAJChX5JDpmcNeEEjeI1KN/SSroJi54GOHOXh6urxhAQJrJfr6KSpP5BlI6suL2gHRpu0gbqe8P71brFm4cOsql+RfhxUR8NlQ8Jl1fPurfI/FA4dK/a5XFt5qzBJBpaspoxR26+QtYx1lmaHVKUPoeGqn2Raomvu++7o95gSCNbbOW0HL2ItY5R+Q4n8BG84Uig9N28CvuL9YO8mrNtS6lTYxnbWUS60hCS4FirL9nsKmRTmqPUNxKtb2AKLhuyqR8Hd3IFPPpSjSP4QgXsVEvzYfxp5u+xT6a7d3qQJjZLNLNKUpfFBcvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo6bfxd9fXo8M0SEI29QQ2uOgkJtvXcJmGiAlRgZ1zc=;
 b=c8eq8NdwSCk+Qb6/tT6wb1mUtTO+GkauPdH/aUdGZqKtC9Ql2OYOYI7hI/liKDGiph8+gVQ+j1zdSoJrqrsCOP0Lc+oHcqGH53uujY3wY8CBhLc0JHTl65m+6ZWc0jUWdU4O0u4RDZ/sxCoK4ZjTWCmG80oQPuAlGLCuK+nbb86ZNJiV6X6FLjezVjN+jYCz4d9kWU550TBgz/de6w2h4vhHh+h12sVk8TGqb3zoa1AJcz6tzDN4PDykLsitPnb8pQM/auuUYDjt55oqp6aZ9iJxyhGTeDEC65TaFmNPupZjIXdYF2ErThANwznspabs5FdibOVZ/dMfrZsxtoxyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8811.namprd11.prod.outlook.com (2603:10b6:806:467::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:16:57 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 15:16:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Salin,
 Samuel" <samuel.salin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v8 08/15] idpf: refactor idpf
 to use libie_pci APIs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v8 08/15] idpf: refactor idpf
 to use libie_pci APIs
Thread-Index: AQHc91UMBFEvrd0V3Ui4XoyTyo0a+LY0xIbA
Date: Mon, 8 Jun 2026 15:16:57 +0000
Message-ID: <IA3PR11MB898641BC991D8EAB20EEA185E51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
 <20260608144127.2751230-9-larysa.zaremba@intel.com>
In-Reply-To: <20260608144127.2751230-9-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8811:EE_
x-ms-office365-filtering-correlation-id: d61554c4-41cf-4d8a-b9f9-08dec570fb0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: gkO/W3QwVjBZxqB0oxvtWQ1qz2uuaYsz0LCk0sx9ms9ZWiAql4kOKKRv2fCmKUlM8iBfEl6R/LVUphEVVB/FV//HwD90YWot1h3l1RMjrJzSq1JjQrSem8r47xopH1LeI03sLMLCrVhqG987lAn+gK205eDqoXKyAevkiTMg2b/gNduuFU7RKiv0dXcCxyY25hNoZhEEnVm+QFlX7d4XszNG8zXKCDqoxGNzq4Oydie5cfChfE6E2G8M9LPGItQq4yWfMK3Wh2AmYblGXPqPaoXofm3Lvp095i/bwl1150cjQ9tsulAMS2PQFHVVrxTN+gDs93Z9LOmWMz4e5mCruxDo3cP3QHgZTBMUE+J3pNrl8xmrYdVCMzw+C3s0tHvc2IGVxdeX96ko0O+5/NEMkXk+qKoK8nFPEYT7dzPVV6fhpswHr2pZThRXXcZ9Mo5kbq2I3myV9nePsPMKfcaE8kBSj8533qYZFXRls1EGJbVRNJtnGan6Z3WDO/J+NHCFkxlF9A5AOPbE1reQRxwSae+LQbae40q7iEUPWWY5y8nkG8dywQ3rF01CkeM5+ZXypzjXHvikh+d7vCt3gMrJtwv4+TFWWNcG+CJGYpUalCt+wvV+8iDFT0sc0NXpZ5FKVFoyzkJhUhngMgpFE67zL8KpQiRbN8LVWnFXktWp2XfDVwvNx3nKpYUFFIL+IMBebJgCvPe354xyRae0E5UdqQPcEfQ6MIVkASkMBojaNUA1+/RO2td5WiqbrmbS9miP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBQksBRAiJRpamtYiwcfWF/heSsvVXkYFUJrE/fGcEx8I/YYRKwgGyCUmKmO?=
 =?us-ascii?Q?Sc/QBPM0dTKNNi3Ykl2uUoo50EJZtgfWWJTxADRHfQ/763Iz9K1L9FfdqlEs?=
 =?us-ascii?Q?rwGZcxKg/oa+ou777EAwq8rE7LjdhslaeZOlECpgflACaR1qquZ6pYeHq42F?=
 =?us-ascii?Q?ortpR8H3TqBFq598+uaGSDIzBMeWYJLoqqgNLevlNuik06Sq4rcA6tG1AEoj?=
 =?us-ascii?Q?oT9M6hGqi3+G0LA5+kWs3NVzlJEHnz25MK6C606FMGoXUtoj3aQV64D5ouzf?=
 =?us-ascii?Q?smS0jx5sTuHWnQb/zU4yzMvT8gIU457/O97kYqO04WEbn5EwDqAlADyi74c1?=
 =?us-ascii?Q?MvfzT56VocgMyAm4FP64h7xNSstQt/kTGcsjiCY1bK2ienQTIgZaImVd3EGg?=
 =?us-ascii?Q?C9djolS/tVaiNYSHkXMgz2dTppl6pAwVCZUZuUcbc1DPWR1iYFPw4HEqCUB8?=
 =?us-ascii?Q?iBlWacps+p0g04PxiyOKdSIardQ7b6wQ6t4p9AYsGEGeoBpXw13Zr+rtYY39?=
 =?us-ascii?Q?i9vjKgW041thRNX3zA1HC9LiXjMTWypcjqxwYCBo1oDsXR6yigOczaztaGNL?=
 =?us-ascii?Q?Ybk0de9NoSDL8ExwZ47GJz1x8A8Z3OFO6sX6f/CIKzVEbFo+r6XKh0EhQUis?=
 =?us-ascii?Q?1G3fdK5gzvBHNFc5pHrYKkyQH9ZLShEYOwHkUPjcB4EGYj3GGCH5qrKfuL0D?=
 =?us-ascii?Q?xScmobeLBHFQ373NvqdJJhtNn7qBYQUWObJh1Fo9ISNsoFoRcR9+M8s+I6Kc?=
 =?us-ascii?Q?4Rud0JlpSZCbhvsWAgBfAL2dpNVD7olwZSQ9RGGpvkFyJm35qlUoiuP1bNGH?=
 =?us-ascii?Q?o/gkNXykyQDQvk2ui/FQCgV7U9euT9ZUe4OqLB+8lRSTjsSw/5Wu027P6zOx?=
 =?us-ascii?Q?fBar9GrS4A3kWTyiFLqK4R1nXaCfpD7GovTGDe3uScSHAkNgnWjDf9rK0rbW?=
 =?us-ascii?Q?BEBWHM0NQNtyT+Mu6hi5SQ/BjdG/mDDoRRrNnasnPWQ6x3Z+TTe8JsQ/0Urc?=
 =?us-ascii?Q?vMFZP01N1EgFl7by/yzMhhpqq/Fk+u8SD0NI8KGhlqMB6cdmZYe+FeyLzEKj?=
 =?us-ascii?Q?wEFXZddiN8JyynRwYu6M4wx34mw64Dzwyihf4MkWm79dEeI3fDWAWcERVgH0?=
 =?us-ascii?Q?me5CCmIwz85/hCviWD9+HBWrf0tJwH788oGOGOYHBKSrOQCvzMqmbfMa3eHq?=
 =?us-ascii?Q?lgCbCOr0hiSheLD0uUXeUWf2Yu9WRVNF8mg5ncNLsU6mJkWoncrUtTpZeMc5?=
 =?us-ascii?Q?qixtMysOAPB6l44jVG+1YlVLQzYCAMZ+1mQtjV3BkKKR8hk6egjvbeaz5VuS?=
 =?us-ascii?Q?ujAPWgAtzokrRIhrQYHZAYDTxEKWYrYFJrLW5I8o0JEiOGSmAK6oSFx0opqV?=
 =?us-ascii?Q?cblo266iz4fydnwbJcKn7qjA9JxpXMKFLNToanFWXkJp+gTH1KQBNSyEBLL5?=
 =?us-ascii?Q?Px68KB8J/szv2BTgnTiYdo1iP+5aXaYtyjAJxTyVtz2wwcZoyVxPcrSb8Zcp?=
 =?us-ascii?Q?XAFEmb3jntpPBzC5/0LRpR9h0+m4KgD7ihUDBBQ33cJ5F9+wEDBDgGaKl4n0?=
 =?us-ascii?Q?6qJTvOH/jgjyN7LJ+7vShJOOoA34CSNmp1kQMztZJMsvqFsI2TlvFhCJ2BOJ?=
 =?us-ascii?Q?7GhCbb5uRv0cH6MVqbzqvwqwhgAH1oV1gY4eKtpNPRxkNO/bn3zMUF/qpDUx?=
 =?us-ascii?Q?Honx9r4ZlxS3CnqFidIaVk6UA9PoPyQ1H7//8I0ewTF42DdfvlYamzsGJJPa?=
 =?us-ascii?Q?zZ3vI0JSOGwWb0ehQg7wvOVdP0Ozsqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SJUbipMAXUvCp3ShRglr456HW7iMsRHZY1mjSOj7zOWDl34LJQxcdtxhY9a42m79fpCQaVEfNRj+1hmolk1R3cxMFpmyWO7eV8z2kWhHErwhUkWiGfXyMOsxqkGl431OLf1SyxwEzq0bbd6yLb44RJV8AQY2BclaKHuJVFmJIDpQnXjSazrtfKx6qXhD+9Bb4UA8r9y59asIR4Iud81mk//jGk9ikctv6LV3lmRmGH17v3oX7MfjioYNSbIkZJOgXIzrog1rkS3GDUCvxKFUHc4cfCZcxceV4puMtHVp3N9+0FPiSToDUEwMctxzYi0wmeI8VNGeEq6Ue5CCYSEkNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61554c4-41cf-4d8a-b9f9-08dec570fb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 15:16:57.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOni89BdRigA4sS+rkpEPLypk05H1+qVTzfm1Mb+msk+RQZ0eOEC1qrh2g0Czt3o8OpJr/oVpy/rA+d7S8QLHTDzwI+sdgQ8orZG23e0ssw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8811
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:larysa.zaremba@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98B88659009



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Monday, June 8, 2026 4:41 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Salin, Samuel
> <samuel.salin@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v8 08/15] idpf: refactor
> idpf to use libie_pci APIs
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Use libie_pci init and MMIO APIs where possible, struct idpf_hw cannot
> be deleted for now as it also houses control queues that will be
> refactored later. Use libie_cp header for libie_ctlq_ctx that contains
> mmio info from the start in order to not increase the diff later.
>=20
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Tested-by: Samuel Salin <Samuel.salin@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
>  drivers/net/ethernet/intel/idpf/idpf.h        |  70 +-------
>  .../net/ethernet/intel/idpf/idpf_controlq.c   |  26 ++-
>  .../net/ethernet/intel/idpf/idpf_controlq.h   |   2 -
>  drivers/net/ethernet/intel/idpf/idpf_dev.c    |  61 ++++---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c    |  38 ++--
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   7 +-
>  drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++------
>  drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  57 +++---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 169 +++++++++--------
> -
>  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  58 +++---
>  11 files changed, 288 insertions(+), 315 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig
> b/drivers/net/ethernet/intel/idpf/Kconfig
> index adab2154125b..586df3a4afe9 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -6,6 +6,7 @@ config IDPF
>  	depends on PCI_MSI
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select DIMLIB

...

> +56,14 @@ static void idpf_ctlq_reg_init(struct idpf_adapter *adapter,
>   */
>  static void idpf_mb_intr_reg_init(struct idpf_adapter *adapter)  {
> +	struct libie_mmio_info *mmio =3D &adapter->ctlq_ctx.mmio_info;
>  	struct idpf_intr_reg *intr =3D &adapter->mb_vector.intr_reg;
>  	u32 dyn_ctl =3D le32_to_cpu(adapter->caps.mailbox_dyn_ctl);
>=20
> -	intr->dyn_ctl =3D idpf_get_reg_addr(adapter, dyn_ctl);
> +	intr->dyn_ctl =3D libie_pci_get_mmio_addr(mmio, dyn_ctl);
Probable NULL dereference: libie_pci_get_mmio_addr(mmio, dyn_ctl) can retur=
n NULL.
It looks like no checks were made.

>  	intr->dyn_ctl_intena_m =3D PF_GLINT_DYN_CTL_INTENA_M;
>  	intr->dyn_ctl_itridx_m =3D PF_GLINT_DYN_CTL_ITR_INDX_M;

...

>=20
>  	return 0;
>  }
> --
> 2.47.0


