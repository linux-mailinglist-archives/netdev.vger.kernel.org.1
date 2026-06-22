Return-Path: <netdev+bounces-301063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oYwvCg8aOWqJmwcAu9opvQ
	(envelope-from <netdev+bounces-301063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:18:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0D6AF004
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=oBG4730c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301063-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C24B300C0E4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED60394470;
	Mon, 22 Jun 2026 11:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A79363C6C
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:18:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127116; cv=fail; b=YKoolHChA2zODJsjJtIHdKpgMgNJ9N175Y2sMSvKo/oLlZT6yaz43v5/5T5+DjjaZTYcp8wAMV3TadDGseWKMBISvqHW0F0lbi91p2gT7z4UXevBc1r6AcpqZ3dv3THyzyMwbi9C+Ij/Lpu62eq+xhJjBAWu64vpUVlvUzyFyPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127116; c=relaxed/simple;
	bh=YPAbbSvQXocjMUpiHAJymvF221z4fS+SbwINVpvkyBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUhOWFHfffvHW2kMmnYn45MwLZM8sgwwxb54+h1MO22mpTiHLQC5zrdN4EkW0k6AKA3kE19aNEJr6+iRkpsg3GEsoEbAxKNrAcnP0QJGwUlbkW6B8oEgChtV2Ay+SxZb9XkvdBS3UKaHXv4z0dOe+6VqIoTgFQ7bbIYie3H+sAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBG4730c; arc=fail smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782127114; x=1813663114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YPAbbSvQXocjMUpiHAJymvF221z4fS+SbwINVpvkyBc=;
  b=oBG4730cKR+qY9FxYNM/Ub1kl5jVbiSknRC24dBjRoSjIaDqx2/IgDrU
   v+eNEnsxe5zsZzVLx1Tee3+26vFQU9GjYA+rKtdT7ox9xRSsc012J72ot
   K8nNW5KEwVVe85Lc43dIDX29h7ahAoQjRtGTGW4uxxjum9euRoWa6ZczV
   H1XAweyhCGW/YfzLvybTUc4FjmOq7vWE3rXnLfY+y/hTtaIoZaFwaPKW4
   d2xpu1weN3z4igxSweeJ913tIRo62aLka6FANtMuOEGwtjBWhPAcRY1K9
   cHroo5+obACK+MCDa+FEgTIrjJJcQS5DFdWf+NOfqE0HPxh4B4EsNTnoL
   Q==;
X-CSE-ConnectionGUID: 25um4rH6STK/l178JKOVkg==
X-CSE-MsgGUID: 6QgUNbt1QEuh7/I/ZV+Etg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86536086"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86536086"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:18:33 -0700
X-CSE-ConnectionGUID: URM6h4JJT3SIRrmTHTZJag==
X-CSE-MsgGUID: UgvbE59KQl6X1jkcEsATNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="248319869"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 04:18:34 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 04:18:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 04:18:33 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 04:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie/LQhsKCgeL7G4BQIKIAiNB2FFrPStRR5j7DT9nXwSqR3i8oF3FfDKmrD+82+dmkkOc2SFAZrzqWOD6ztT1iJK/mzVBiuc4idUR/B2EycRg8YmYsX3x8rDXpVJToXDAz3jR+GrO3acBJb+OD1QclNFmO1xI8+2Lxh2bomZKA1jb/U/Eqe+fjm7loFYKL6hfHM6kulh08xaVxb2duEpizZbJLDdLff1e7NLVGoRWGOplagXlPWp+JR42WtlLElHydu2SMClYsd0CVdZX0/BNY0KrEHnAS454sg+JC9u5LGSH3zS5GdjAmLGUA2/NxLggrEcSSHO/2OhG8v5MQSTzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/RyXoq1cohG7XzhiLmZCupKT36uwWtgz76/FbYqcrk=;
 b=MRPYW/42wlwNZk5H/4CYKKlN/GfAMSdbRO0SWTXvdy2U7Agd6cQ6rtmNP2Q61Y4jYbBnZiYp0OkNI19OF7ymqEOfFHaMYNowBRaepgZIidnX1PbU0jB5b5FQIs6SuqXIHSXx3YFq2OU4x8cq0IXQzd7Up8Jo0+F1zmdFtSxT5RyFVGwi4Gt7E0VejxTp6jJn22Df1x3DgoNeAa6apHb9WsqjwXASHAog87pVE/arFqaRDkDiUhOjn3HKyhaqWASiWqvUzVGmFKt8HiK9PThexaWbg6xmeudIr+c97g+QjfQtV121wPI6MTI1fGkSjeqRcbya9fVqKdhDGU3l6iXzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:18:29 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 11:18:29 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net v6 4/4] ice: skip unnecessary VF reset when setting
 trust
Thread-Topic: [PATCH net v6 4/4] ice: skip unnecessary VF reset when setting
 trust
Thread-Index: AQHc/7LceK/tTBsRgUK0XusOw5V7sLZKcjmA
Date: Mon, 22 Jun 2026 11:18:29 +0000
Message-ID: <IA3PR11MB8986D87F75BDB88CD302C78EE5EF2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260619061321.8554-1-jtornosm@redhat.com>
 <20260619061321.8554-5-jtornosm@redhat.com>
In-Reply-To: <20260619061321.8554-5-jtornosm@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB7332:EE_
x-ms-office365-filtering-correlation-id: fb1245ee-6ca9-4d4e-9f7d-08ded04ffcca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|18002099003|22082099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: ODONPwhUGO/4ydEKVGGyefxHpT5WnFKyUS1KcYhBCp6fwd4YsntrEUGj4YZiJdeSLAiZrj8FajvB5ZQaX5bEkN2vSam91ygi78yunxiq1n5QX2bnlep9DQioD9QwRp5Pv8ldNh6rL3XWX7q+KlP3aE0pFFe4IooUxyIUpUbETEBWe2a9LgmKlE/oEoDZGazdSdFJUmWGE71HZxsphvAQllI3zVcntLv2VW8M3hHWsmpZoMfqetw86WcosKswKh6viVZn4PZe86bqdp/6zTHJcwXnBYs9ShiYX4btM7laZPBxcJJEJgK///W2E9rzmujrCRkBXmP8u58EuKKO6t4QF/RHSPuLsJNOrxG0mszkeq2qU8Ly/WgqS8blfi8a3Q5/jFRTBWQ5EaQqVt8sKuonakvl9xBp9f9QI6qrgnCRYq2vL6bNwvojT9b5JQPte9PgEHkB1EI7mQiEdcUFawDuL+EkFJm+6k8uimG0Rw6sjCLHKLpSgoQoAcmDei9gKPfrBm9n7NDTxECppxNSm9BoEBt22AWTraKdJoMObc4QlSDxeT3pC2Y2yeYnn/DFHwNtFs7j8kaXgl+Or96JsLTHK4Qmq1ur3XVb03+TArDjg+gaF/vokpcYiIjM7RYt5Ad8GemHkCkvJKOYJWbZFGjviIlH+thqUzedGGWjPZQjuqJIAjfJR3Ki6EbJeelBhp3RWQznEvXRi93MohKFwxhrI4XR3xYBq6qyLH3psscgRAk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZipW5dR24o6rtVDrmxRHt5u17kJV6jYlgrM59Qq0oqrTFIr37Qll01RyS/zv?=
 =?us-ascii?Q?0NyrPluWoXSFeSD7ncS42L2dcDimBpUwioUumFtLJXCI4PPXCbJQE5YbwPd/?=
 =?us-ascii?Q?ekzFRpTwCYivtvvhxV0gTDEoqY1DQl8/rmmkOQ0BccqVTjo/967xamrmKwU9?=
 =?us-ascii?Q?gbt8pMd9hUnXDKsmOHHoJKGNdz+rF9dZhG0fvoscytLj52Hro8uWMh2wExnM?=
 =?us-ascii?Q?CQCo9mgY0TqKaEALTbVrfOX9lWh9LIOW4L1aeeNQr1qMz2BcTQ1KvylrShMI?=
 =?us-ascii?Q?XknydYr/raR+dD1jt9Spux0l8REvd+lNDM5Mi5/w3F9iacCC6Xkq8Oo29bmh?=
 =?us-ascii?Q?q9IGBdv/b/kU4Cyu7lvQOleWc29niAxUgS7LHtA3wJHE1hPN0gwdAydnrEKM?=
 =?us-ascii?Q?lLiNZT1jID4afWwBSdkDGt88UzfZmCF417EQWb1+DWVjRExAJmZDZwTC2IW1?=
 =?us-ascii?Q?GBilCHB5HY0zOFN9b9mFPlelk4HnBpX/8O+L+BDnj/ibI0AW9fp4tnXYqMay?=
 =?us-ascii?Q?PsvEj3fT8Z0NvYlv4JSwc7GGFcNNvZdpJykopz8uL6/HUKn6Oi50N8WqVdJy?=
 =?us-ascii?Q?fVPAkD/2pVSB1kA8bRzjtIWJJPm8lSu/50jcynzIkVyL5iAWPiLYob3enoxW?=
 =?us-ascii?Q?7bL1zpBQuU9/jfO3BXk9p1w+SxNuTWJibOMRtnETtNynuHDfhtMzzOtb6OAU?=
 =?us-ascii?Q?xnor110xT1Q6se/BSXYutVZztn0/niEF6rsofzIUW9SMQUnHG5LgzYpyoqjp?=
 =?us-ascii?Q?bbqjJQCym2yNR+H0PSmFB72jnvPQY7pxoKxrsuWFERPvZ/nsPeIdAZoeakfj?=
 =?us-ascii?Q?qqxXEewAS7j7rpD2SLjF0IBBcotvcH/VYErVGY1xQCDv+oM8KvRhR6T270pS?=
 =?us-ascii?Q?Rt1AbpYLVu1RZuOrpiRWO7wwnpAUEOgFZPko3B/ReYw1rZQSBtSpm46Wd50n?=
 =?us-ascii?Q?ezS60bW9Vn6z9dCrpT0YdpoxI7s9T6J5T3Q394WwQgTr6dM0lHczhVzK3544?=
 =?us-ascii?Q?l2Rmk8L2KA2i5qgZ5pucqSExy35CpkVK9AmB4s786mZF4k54TzX7YyJNwueJ?=
 =?us-ascii?Q?oHPtM3Otty3HIOaYEWnIqZCLaEgANb06xDw0KJlZuW8UmhbOWV8F3XOUM3ex?=
 =?us-ascii?Q?5y5z+KFnSbo+WmAu3msyonJrhhXsMnrQtOS//QNlfFOPoeBGRoVNN13csGnC?=
 =?us-ascii?Q?/DqFZhEmzBLfDCSJOa8Ic57wgAtCvjYTQpO4YTwC2n0nYBTntCbuQ+XloVDJ?=
 =?us-ascii?Q?TSvsgBC+VRfe2ncyK6NSW7dv9j8irHlkkGWfylnex1BnC6RPflcVT1rhTTg8?=
 =?us-ascii?Q?Q3OR9e4lo1J0TngUeFtsTNd90qVB1jRsiRz7M/p3L0YoShL8zvQCcvN16Cs0?=
 =?us-ascii?Q?DBtNDpqFMAvB4z3MZGj5yYBntcb4YuHObilMHNF5yKVNT2tW1BOhbwNtmtLW?=
 =?us-ascii?Q?1zRwKRpQ3D4Nm2/Wt8P9UKzPqrCByAhCT8ZIHF9Yhfl8+xElxtz4fnEnEwQ4?=
 =?us-ascii?Q?xFtMDskv4HXt9KXWH48IJtj9SMivhqN0Bs0mYx57d19PO0U/fv9ZXpojA0PV?=
 =?us-ascii?Q?O/sOxTL08hyWK7HgL9xkYpizUCow747NGL29l9k7lKw7YhRgQcHHykd50mqS?=
 =?us-ascii?Q?eGZG2l7rtSDtwF3crPJaWW6SkxJxdEYGzR0QIDnVnh8LR1g/LzG4sdK0kaxr?=
 =?us-ascii?Q?41bJwLvOruv2MraxtltsXUaZ6ertEqOooFzK9AkoHaybUBxJdzCuPMgmolFN?=
 =?us-ascii?Q?i4iUDeyGP1mItK82jw7F7Mx2TwIvCJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PHcSZHFgUpxTdhNCPkOSQAv/lEBvwlNMYmkEoGSqnBMWOIKHptWvX0HF4PTvqYXRzJn/iNz/lYyUwtg8/L4OQwo2gVXbK1tgEXRDTWt9+3UyGU3ioeE2whjv5dFEwfzDnDH5Q0Aw/x9Goynb5lP3yj4PJDwN5X9bRn8kLim5wylgO1Cxhs72XX56u/4Z2Jj7VndhOdSg4s3S1BmczoRUI0SUNXzqFhouUHZZMMu+8kwWhktBmYgleu0XoM4JBhW916enww+EenQ9JBp09YKnmBinLOplSm4FRRio3KifHMeTVfFCPLXXzMX2z9TYmWh8S+wyQVh7K4wF1vXxbiUZtQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1245ee-6ca9-4d4e-9f7d-08ded04ffcca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 11:18:29.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ut5th2TR4PAZqQkyvJ5B3ovE68L4qTsoiOHctjByf9PBHhGwGaCyQ9xvg/6FUryVZ9VVTj6AW9nYZNdV1dWLpfQ2VM+Y00MXivKwskNiV58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-301063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:netdev@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:horms@kernel.org,m:jesse.brandeburg@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F0D6AF004



> -----Original Message-----
> From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> Sent: Friday, June 19, 2026 8:13 AM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; horms@kernel.org;
> jesse.brandeburg@intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jose Ignacio
> Tornos Martinez <jtornosm@redhat.com>
> Subject: [PATCH net v6 4/4] ice: skip unnecessary VF reset when
> setting trust
>=20
> Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
> ice_reset_vf() when the trust setting changes. While the delay is
> smaller than i40e, this reset is still unnecessary in most cases.
>=20
> When granting trust, no reset is needed - we can just set the
> capability flag to allow privileged operations.
>=20
> When revoking trust, we only need to reset (conservative approach) if
> the VF has actually configured advanced features that require cleanup
> (MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
> safely change the trust setting without the disruptive reset.
>=20
> When we do reset, we maintain the original ice pattern that has been
> reliable in production: cleanup LLDP filters first, then set vf-
> >trusted, then reset. This ensures the privilege capability bit is
> handled correctly during reset rebuild.
>=20
> When we don't reset, we manually handle the capability flag via helper
> function, eliminating the delay.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v6: AI review identified issues with v5's reset-before-cleanup
> approach. Revert
>     to original reset procedure (cleanup before reset) which has
> proven reliable,
>     just adding the conditional check to skip reset when VF has no
> advanced
>     features configured.
> v5: https://lore.kernel.org/all/20260429102426.210750-5-
> jtornosm@redhat.com/
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++--
> -
>  1 file changed, 29 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..XXXXXXXXXXXXXXXX 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev,
> int vf_id, u8 *mac)
>  	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
> }
>=20
> +/**
> + * ice_setup_vf_trust - Enable/disable VF trust mode without reset
> + * @vf: VF to configure
> + * @setting: trust setting
> + *
> + * Update VF flags when changing trust without performing a VF reset.
> + * This is only called when it's safe to skip the reset (VF has no
> +advanced
> + * features configured that need cleanup).
> + */
> +static void ice_setup_vf_trust(struct ice_vf *vf, bool setting) {
> +	if (setting)
> +		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> +	else
> +		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
> }
> +
>  /**
>   * ice_set_vf_trust
>   * @netdev: network interface device structure @@ -1399,11 +1416,19
> @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool
> trusted)
>=20
>  	mutex_lock(&vf->cfg_lock);
>=20
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf),
> false);
> -
> +	/* Reset only if revoking trust and VF has advanced features
> configured */
> +	if (!trusted &&
> +	    (vf->num_mac_lldp > 0 ||
> +	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
> +	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf,
> ice_get_vf_vsi(vf), false);
> +		vf->trusted =3D trusted;
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	} else {
> +		vf->trusted =3D trusted;
> +		ice_setup_vf_trust(vf, trusted);
> +	}
> -	vf->trusted =3D trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


