Return-Path: <netdev+bounces-296401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XfNMEWFzJmrIWgIAu9opvQ
	(envelope-from <netdev+bounces-296401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:46:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2710653ADB
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 09:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hMyepBKi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296401-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296401-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5078A30054D2
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249938F945;
	Mon,  8 Jun 2026 07:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27B2E06EF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 07:46:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904797; cv=fail; b=Ab5gq62igO7NEAoTg3/lcIwa6S2oFGQVr1+FaTngLPylEi+WuQPLRGva9zU46EBWj6+2j9DAUs8AXKe22qq2P8Aj4ufTY9IoZQ72UQNZcpu07MVNfoyzOc/v4YAip0rH1/2mzEfzX6BOTRsqU8yPL1vzQfnuBAX4rrmnmhtCviE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904797; c=relaxed/simple;
	bh=2evcJZgX6cAqE05zd7C1GNcgnW+EgkOj1hNfT3RVGl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fjSl18Ft+X1gfWgSVInqt8IxffAfuJie2Od55cHNihy/ZwU5p6uEwRgsSvnIKKEc2wBQtiaBnBiaB8y4hj5PbwKuUx0gwu5sa0sUydh5MRbuTEnoEggzO6OiHTbJKg9Ips9GT/i2uf/eQ3OB/49gMVKdtMNQbX2KyoMRwvTThx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMyepBKi; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780904796; x=1812440796;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2evcJZgX6cAqE05zd7C1GNcgnW+EgkOj1hNfT3RVGl0=;
  b=hMyepBKiAohFOOVq4huGx10q4yVFy169Q5fHy8rO6B9A+xzrYB/8uYHK
   CQvh/u9wYdiWKtkCVgQiI4yTsmr+8E5eR6BRNum2EeMlR4Bj36zlte/1M
   thEOVXOlrEG+YGSwsAsSX/IO3L71WUsq31kqc1uwSTv5wJmpOVuQcWhp+
   Etqk42qNg53fl/AIKs42SyaxHrjNv9odwxbBYOuY122MtbpYVhvVr0LxZ
   dZfrDsTUlHWbJelql6kX+VO2Od0pj73YKwmYw1Bg96W+CfxBOkXe8KvSy
   Sj4g2HJABGTAqCiehbrY3YfWcwXrI+6O3UkGJTKyZ1Fwn5YcSWjzdJpNm
   Q==;
X-CSE-ConnectionGUID: pnSAxiONQd68vBao98x1Jw==
X-CSE-MsgGUID: q0AyqOQxRneooyxc2tJp8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80662846"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80662846"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:46:36 -0700
X-CSE-ConnectionGUID: EorvEzkMTHaYDgFxcdJRSA==
X-CSE-MsgGUID: Wds7eVfVTDWU+DVGyxKDxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="250577134"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 00:46:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:46:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 00:46:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 00:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD8/uETecruCCzgp+LRuYwDDwssNmNZRXU7qD2hduRfzsUxtDUK6eKuzULkhN8y6/j6Bw+AUdiS1TZI8MhmPheUKYW4Qp4Mb1k76sfdVUxh6qD9hc7mIhW2kEM40BO7PMK3yPJJrXtN41rBxhe6uiYDy2nAVN8/K8g8rr7wP6JV5Z++CEuWos8M65stI2R/cc4mAbt03/cQodmVB8xhCA33l9DQHDEliHf1EKLdfm0YceXPSqBTr2CjgnJRgrSYQgvddboBVUe92tir661IDIKTMDoUPxQMB73GyOS9gyhshvVpRr1tMJRFDbQNDqzxv6MYnBPDtpE6GFTGlOHKchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnUkyGhbWwCeOT7jV8qnuZ4U4u0PrvdRoNildMX7S/E=;
 b=SoDgB3HwoleJcU7w3Zdek+qjHsqRE75dCdIbry5NMOzvennNyHdDMIPLCxkqfBrgnmOqdIcMSHZ0FbpGVECbf5mRMhrdWw+JdU1wH8S1dTTF3fIss1KUrMNTbvISAXM+cqtmTUviU6KUsDYMGCsNcuOO2lacdgPaKlymawB8mw2goPdTZU5n08NSW4Gl9eold+bYDV2AlbJfH7PTXzaP1ALH8gkQNBM7qMxJnYZUtGN0w4sCPLcapUHzk4mply9t+W5qQ47sAMUqupgUyK9r1g0+4DtlIPcQ1B4eZhuK4pC/J3pcX2lFR6qQ+UrD3aLIwLoiLZ7fR9UvQtKPtdYwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL3PR11MB6507.namprd11.prod.outlook.com (2603:10b6:208:38e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:46:32 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:46:32 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"marcin.szycik@linux.intel.com" <marcin.szycik@linux.intel.com>,
	"Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>, "S, Ananth"
	<ananth.s@intel.com>, "alexander.duyck@gmail.com"
	<alexander.duyck@gmail.com>, "Nowlin, Alexander" <alexander.nowlin@intel.com>
Subject: RE: [PATCH net-next 10/10] ice: use ACL for ntuple rules that
 conflict with FDir
Thread-Topic: [PATCH net-next 10/10] ice: use ACL for ntuple rules that
 conflict with FDir
Thread-Index: AQHc86WOKyOyNmx8/UKybE5WDW7xMrY0TmkQ
Date: Mon, 8 Jun 2026 07:46:32 +0000
Message-ID: <IA3PR11MB898690962B5C31C8D20E43CCE51C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
 <20260603220828.829969-11-anthony.l.nguyen@intel.com>
In-Reply-To: <20260603220828.829969-11-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL3PR11MB6507:EE_
x-ms-office365-filtering-correlation-id: cedc460f-a43b-4808-2ea7-08dec5320ef2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: SwhKv15b+N28u4K3Q/tuIyr6Q1ct3DbvC7TdJe/xKEsgAm06NFTkdvtyW6CA3dTSYeVCS7JAuS/I7Vnw5dPSF94ZW6dTWVpniteKsnfsOR8SrljP1oLMUNdbMcYAB7eXgoUYCyD4cNXHIIAazixdSCC36NQVBbkvZUI6YP9gmQhcni9B/+/dnOj8bfxqrL7s3kKS9aWj50lx0z3+NL9vaf5DepveMYUun+NRnHgxtya5wjbfzuRY42sIzzdX4rSw6L60DmLfrAtK40MDleFCky703S4X+wMeGYEC0MgrosmAoq174V/CLQTSlL0EqQ6F24i/HhHJRc1JPSK4YtFTvP7DQJ8cqDXhhUUsaaI5auCidrT/MqqbjdEUSPC1alJZuO/XTMnfHfb9ngzjNjFoj3KtccQCOmVRlVbmZcl0mqQHuQ2gXXJZE72qNgqrUk4AJmzsORW9sYOrdWJJPkkZJAOtLC1tJzCaFkx88WUny+WEWRI0im4UIYBrsL6w/uLdhbI+yFPwQvJFRxIHgG9RtXYE9XJOuHt+As8FvbZFSWkEU8SW3SyhNdIHZJtV6ah68uPsMzWR+ss5mIV+R1ovPzgzDCAs6qm68JpyuLee8pEwrAhWAMB37GX4fjEY3L6EpSdGVE7mWk15/xaXCpwQnt23GwVIeYG4uPnd0RBuoSHFDQljYgfXMbHQLvTJ+5tsTOHdyw2BZ4+0Fb3RKt2sPj5KwE+Tu32zl5q4wpy7pcwrDxhOCOBRkpK7C7+fH2Vz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lkD2kD7MBImj2wYaNz/le1iAuAdowELBqLfMirFqatQ4USBrnVfDVarW8Ojg?=
 =?us-ascii?Q?eAhK/e2F4b4YnyNCYlFk/mUJ9F3cNcAmJTVTVntUptO0V3samC1qe41SnKYf?=
 =?us-ascii?Q?7BOOfgwwFk22GTMgdQWzao8l9zf4lO8c4XRry1dFIfjOfQ9BwQ1EML6e6200?=
 =?us-ascii?Q?cV7dMYBcX2Ltt1tS2QnNeZI/nOmMkfnU+zWejLXDHAk9yAKiN7kzHLhbT+jz?=
 =?us-ascii?Q?OFfMO+WPjkXNoRf5MxRr+jslYDbfOxd5MRZWJABPm1SYF4dPEYQpq1ihiTB6?=
 =?us-ascii?Q?udqsKNt/fxURe0Vv7XsRVwYvjPLC59GJdAvOso4ivEXlJ5EM2y9U1NUK/khn?=
 =?us-ascii?Q?Pj7obFL+9xYYUBOig3N6FAPQVidckq5Bzb2XU4q0dZLlaPlSqsf4B9NtqzrJ?=
 =?us-ascii?Q?YiSDUz4pWVv1FMS/T4MLP96kQ5KsEd1U2tHbFyCfibEWYjrsyH3bTsuE/HJB?=
 =?us-ascii?Q?ziAeVVNhdHi0lLgO2xrByp1OLmWoGc4x19MNploAmuAVBCLsFvybN3aXl5h2?=
 =?us-ascii?Q?bTudO2uC9pi+v2uZOJlttXi5jtRkheAdRfuKnkz5ytiwZQopA9ZbrvarBehW?=
 =?us-ascii?Q?z6rMRbbBBOxdkiQdJx9LbRO7CYwHVhC04RBtGKdFKVifG7Dga7kLLoeJy1MV?=
 =?us-ascii?Q?U6CGerudgtQwp+ks2XKozxkifD0hz8Zd6zZvkKbC5WUI16DNLDlz8MhQY2yv?=
 =?us-ascii?Q?c5DKMD08yTssV1vdvVta2f9pmw4hpcLRo65hVrmeCJwRBYV+mKr1IUh8jtIQ?=
 =?us-ascii?Q?5lOrVvjzEIcuussyUvU+tRKuexEv3qs5qRg9dCq3CIEUiykC1v8b68K0WxWN?=
 =?us-ascii?Q?/n6P1+WkEuRABmTbugWoih2TQ5vjMY9jRjJFZMvVNQBaXeLiPaDzd1yPNDvo?=
 =?us-ascii?Q?o/gVp61bixujUCZ0F4eaqtHqFcFn9S2jNmkYylTzK1NYsFHPTRxj0Rc4N+Bx?=
 =?us-ascii?Q?y89iERNoHfn/3E7AJvKAv1kMslScgHM9ND8UCEwhDEZf+1KbokJpMgzB3JIS?=
 =?us-ascii?Q?oWZhOMsrukTqofC14z/JrYDhIbWtqfRocCv7gjFDUGcr0eGrrnzEhER6jlJq?=
 =?us-ascii?Q?qOaf6BgOtC2fUMbWXv9XFapPtgornO2dV9x/cbVtnqkhyQ6ohowy6qim9KPw?=
 =?us-ascii?Q?/76iUMFECzt3lqfQ0yCpzZN3de6nJvk4R3MkvSXrGv5BHrS9IdAx9SOxRl/Z?=
 =?us-ascii?Q?s+XHkrNS9aubbPdxbVGml95vKDn2uy0sj43l4fWs67M3sbNdSeC2Jai3FEIb?=
 =?us-ascii?Q?RP33X46/C0dlGvRErp7mQcNnF3l4Oc5rd8E0iTfhke8QtQ5baZ33KASBgN5l?=
 =?us-ascii?Q?gMDeIfhFBkTSFOydbl+NSWfBUl6+eAIyULd7+XTOKGaW6+VinbkQj5636QDr?=
 =?us-ascii?Q?Nwxi2BTx0EI+G6rkSmDPi/CXLsMZF71ADq/wmvgesjKDN0sgXYG1j1Q8U1pj?=
 =?us-ascii?Q?Nj6dJ4srQcn6w1DG0j+EuQ2aerEtGb8VRhVNRBJPHf8Ga7v9yr6QwAshCYu7?=
 =?us-ascii?Q?5pUqdzI0gO5s+2oRdvdIkqWZ76HHeJBn3N+5jvRoI9IT0knbGx8s7P0QsN+R?=
 =?us-ascii?Q?iur7ImzSD3ytDXasp+TnzNwCgWddLveNI1k4M0gObtQABPheFFFyIuc9Vme+?=
 =?us-ascii?Q?NS8ZJNdxuSxYwuE8txq26KA7RRRpuN6aPav/0aBTNgp0SE+1P9snpb4T4Kr8?=
 =?us-ascii?Q?oFROoXBjp7VueC7dlc2RB/Xl4ZYNH4RV84+asnnR78GqiqGbnLlqngklIyGW?=
 =?us-ascii?Q?5ie1X9/wlwKJFpREjdBEGD0dhxqD5Lo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VsRAOY0KAZhdwHBOa/mN+h2Y7j7WPBA5S7zxhKM79sCBQYN+ZrxFpEgDE7WtRaAqBAiHJPkYcG7JxgbtcZWYoh9CTCvDnJdMZt5AZxLVmREySzNvyOuBld3kgttM/HL85RWlZjUdSTBB5EJSGJ/Z2S/EKCJzfipjeHZH8JdiJu0ZzAOKuxQHIle45fNJ6j2YbJzaR+UpsxuYS/8lGIcRndxLKUWtNJWqgv22qfLSxcLc/wxI6tHJm06dJaTymRqBu1TVlNXR/6r8VW6+OvJJo02P/R+TaD/r5JXSr6NGXHSGWaFtFhK60YbzowkdfjKNQq7ia4allgUBJQKV9eZRHw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedc460f-a43b-4808-2ea7-08dec5320ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 07:46:32.2850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddi4jGv1S4M5LWDgrZ3dDvrRZEgSc5QolnFhG1MeYsqxuDIPenhb8iMbIJTeuUWdW+WfgDoWSiX55nubH85LbMMmxVkiYn9PHM1clFeJITY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6507
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:lukasz.czapnik@intel.com,m:marcin.szycik@linux.intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2710653ADB



> -----Original Message-----
> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Thursday, June 4, 2026 12:08 AM
> To: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; andrew+netdev@lunn.ch; netdev@vger.kernel.org
> Cc: Czapnik, Lukasz <lukasz.czapnik@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; marcin.szycik@linux.intel.com;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Penigalapati,
> Sandeep <sandeep.penigalapati@intel.com>; S, Ananth
> <ananth.s@intel.com>; alexander.duyck@gmail.com; Nowlin, Alexander
> <alexander.nowlin@intel.com>
> Subject: [PATCH net-next 10/10] ice: use ACL for ntuple rules that
> conflict with FDir
>=20
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>=20
> Flow Director can keep only one input set per flow type. After ACL
> support was added for ethtool ntuple rules, the driver still only
> selected ACL for rules with partial masks.
>=20
> That leaves a gap for rules with full masks that still require a
> different input set than the one already programmed for Flow Director.
> Such rules go through the FDir path, build a different extraction
> sequence and then fail because the existing FDir profile cannot be
> reused.
>=20
> Detect this case before programming the rule. Build the candidate IP
> flow segment, compare it with the active non-tunneled FDir profile
> and, when the input sets differ, offload the rule through ACL if ACL
> is available.
>=20
> Refactor the IP flow segment setup into a helper so the same logic can
> be used both by the extraction-sequence configuration path and by the
> conflict check.
>=20
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 168 +++++++++++++----
> -
>  1 file changed, 121 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index de9f4fe51aa5..ad0732f15405 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -1453,6 +1453,115 @@ ice_set_fdir_vlan_seg(struct ice_flow_seg_info
> *seg,
>  	return 0;
>  }
>=20

...

>  	ret =3D ice_cfg_fdir_xtrct_seq(pf, fsp, &userdata);
>  	if (ret)
>  		return ret;
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

