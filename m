Return-Path: <netdev+bounces-283814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PLaF72P+GkVwgIAu9opvQ
	(envelope-from <netdev+bounces-283814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C56C4BCD9E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81A1C3004C88
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21E3CF666;
	Mon,  4 May 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+AfTB9g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D83C3422;
	Mon,  4 May 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897400; cv=fail; b=lldfqbCxgA9iEsQCjolUaZV8NAyHJo6303jjuTjanREIIp/mCVGUsj37haXFXYMpSeSs17lGo+/1j+Ti6+MsCneV4kJbVLNStZ5nTXdxT7LgpD7WthfzGQZaz6tEj4ETmxe/xreFJJXPEkiwo2D/E07ieCgmnUiWayqEgU5veRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897400; c=relaxed/simple;
	bh=uk7vdYAzl+4Lpz9sB+wYHi9VLOHhwYtNcG5kB04R3mg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L+XQlhia8G8jYlcPmSjmGJpYGRQoJ2YiGnN62gDcA183cmYgem1GiVB7WhEFZzkRI32mqZ6HRgzOP/7ke7SozbrRZ5q9itTVIrB3HaN0FoF3T1jWuVn63hphsO3W8wPE+BmVxtIr22VacctTz7Mp8ezfXaCMM468wQQkjzPXZIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+AfTB9g; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777897398; x=1809433398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uk7vdYAzl+4Lpz9sB+wYHi9VLOHhwYtNcG5kB04R3mg=;
  b=I+AfTB9gigtW0AddaeXaf3Gg7aZ7tPW6zMNrfo9jlCwmJKkKXhXpj5It
   mj5G7hc0rNzOp/+jH6fLEzZkLNr7zMsAaOqbuP6RLRZPMKtFCfX5tKikX
   bm/BKBNjOGgd98fC8QojPLW2xLLl4XF2PQREbiMBo9p7ZKJgr4bKnY0XF
   eHY82HLVfbUkbIjXPedGcI8W4X1sWJ/hitBr5+hMwfV62pHdldJeCBxYt
   LvENFGKukuBGtPyDu0Ny5Ki9EHj/URrCZxla5M2bAVlRMOMvuKrHjKVh1
   A6jHzMLMiUq6LdNuUhHy2vyFVwUBNDNMCwZ/ToTNkvQbw5MjVoEu8yGXA
   g==;
X-CSE-ConnectionGUID: E8nsQ1flT9CPEK30S5E0uw==
X-CSE-MsgGUID: /XzfZiQcTZidjM9fJfoBAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89443640"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89443640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 05:23:17 -0700
X-CSE-ConnectionGUID: g7xZVwHwTOiEc9myt8wjeQ==
X-CSE-MsgGUID: rPSm9tmCRJWCBAyT3RI7Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234640170"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 05:23:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 05:23:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 05:23:16 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 05:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLjn7iUTk0IhcbB+NPValRDf36Z2SJC+fzRHjveQzE0zIqbPOVAOGklJi9s+Az3Nrvy76PV4zkLzkDSVITz2GI3IpkaHWXkC3x6EqeDSHcy/MkCDXtkmrSqTMcwQY09/OVDp8WduoRjBYQhitbFit7BHTk/OmPrLO/2fF/qaTNa2Ov1AMFLJVAf5+ES9FfsVPU2bA5PhIfa1fMs61/SeLV1Kd63hAcYFHalcRAbLO8KS/cC6pzB56AJvZtDwWPcpK7d3fUTl2agBV3lIwu4BdT1pGpYHf2RIXlE8hcyw9Y+c0K1MLczKbnj59SiJyCIxFE5VCW4YFAdbRYQMoKod/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R90VSjTo+ZVfrLMRRG7HBrjh3rr3bHfeOZLWeSsYaA=;
 b=MHlj9Y1KCuANOnFnslQvpCFJx2YVoGwFfiGEb8cI4ODZ1jcOl1R9jdxRJ4RzwMcCBpsM+e3YVu6kzxdXTDGGhgcmG7C/EmP8nU7FLwx1fZ6hhHxJAM62LcfthK0H8pybKQQZPsGjEeUPr+GIRTd4PUykDvvnlU66tRqZ3Vob1YmAk2y4CSQg6Jm98kD2oC/w5CU/IREUSbHdP8wTvRUpcIen8fjEwSes/kCdpFz0MNy4xoabqhC+uXcHlv5C7egX3MC/ndM/x1c+qr3fAwyUJ8FU/fmL9tZ7NcHnhn/odosIIRKCagns8OWw8/4Vm2lVqb+kPzWwZBFpJ9ILApbW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8659.namprd11.prod.outlook.com (2603:10b6:610:1cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:23:10 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:23:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Simon Horman
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing priority
 callbacks for U.FL DPLL pins
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing priority
 callbacks for U.FL DPLL pins
Thread-Index: AQHc27/uh4kEqoy2jUGhegVbuLh9lrX9yedA
Date: Mon, 4 May 2026 12:23:10 +0000
Message-ID: <IA3PR11MB8986DC1FCB29448CDDEDF045E5312@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260504121603.1702674-1-poros@redhat.com>
In-Reply-To: <20260504121603.1702674-1-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8659:EE_
x-ms-office365-filtering-correlation-id: a5207d6d-cbd4-4dec-292b-08dea9d7e7af
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: VkZYNwrbsHbtNWUHULlMzf6varNkpsHJllDvGbauTRJqmyUqWy3/jSflYoNPT6u8XORbX6lp+lsFxkj7E5Ymw9eoylYsgYPyhjhtB6ZBvmrfjviu/TD0M6P5JFfBRXWEFIbtDZY3tT1XeHL4JYxVq/3RkvH2IruzT2bon4n81EN+LuvatCj/UdCfiBsj2jcCcM6nY7N/e78RsXJzuoLpzKaYmESjzN6rhVaWACGldnx0y+i93DS6pSqqP77/s+jqUt8H0ptPtOV5txors6XG5q4wPQbIlORi3TwPM6m9cJIx0zVC1E4OtlGUZq6cD/2GwKjbRSEueoNCJSQqF+3OdjdzEs2yh0PK365V8HlaJFnr/rktnkdESyxs8HF4PlvOC0EQkP63QUyMjcsEuvQ1qj7OtpL0i04yPjU2K4uSrOBz0bzCv6nYU64PEDV0UB/rWymxBz0t0heA6Rfyv3M20tWCL2563ahLQPFE8U5+JQ3fEwhkI4jZ82ub02QTDsyIBEiOkOaBUehrWF70v1I9QAjvOcsKtHxnYgEvPK44Hj1ikV/cpknoJVVH+hNPvf3veIY9gcBcrUNLJXEDMR9abgOGfGsOeZAVaJaq1bswecevn0Ir0KWQn+BNONjiwS79V5nPuW6FT8eBjelscJkAGajzOx2zkRrlAwHHkhB+ZKtDbt5i0w9P/k944jTc3GoeXZivWy1IOHNqCmMISC5p8LWlqkkjZXrKh/9yO85Icrh2WkqKhXL4QPCB3t/qA+ua
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/G226JAgRfYCDJfReYSwCDrpIuFAyYTLF43U3v1kBCgURyPGNp/mTbjfxZIB?=
 =?us-ascii?Q?0Vrzr5/t9MUSdAREiiQSsjKBIpUxdmqwYmSR7UeAdynQwmPM3JodaMAuNpsl?=
 =?us-ascii?Q?5+ZtHVshM/WvosZqZZFhdcDbpCNz2JFeJO0mYpW1hohskqIUQg3/h6dUB13o?=
 =?us-ascii?Q?XrJwTUHEsPpKqeFmulKAhpFyygkzeG5wa63utSJNOPK/Tj6Zsa8mqzFWsXqo?=
 =?us-ascii?Q?0R99uLBY8PwImZWz13drJ46oypXsC37eqF2pvfQnwBx1sEIrUBlcpKkvBVU8?=
 =?us-ascii?Q?owsA8QA9Xf++30sTKlKcRdBhS/QmKABcp/Yb7vgoWKqfolFhqLJ/jWQhGqse?=
 =?us-ascii?Q?O5+roeDETm3rHu8IqECy5BK5K6m9eZSFsD10afI54NOtfKEYZqGhCW2bewxw?=
 =?us-ascii?Q?B0FDicX6oorwZN10LVkQUqfoBC3RKF1oDr1g29pfJSNJcAC9AFiUDnW107uw?=
 =?us-ascii?Q?kbbbdCM7r1bK3qFh/ycHA2dmRLP+3rO+EriyaU0hI8wETTXIbmOzD2u8wZBO?=
 =?us-ascii?Q?FleewvmTLIotbUWPm2wCLl/dCTXj5+jnO6HkurlV93dp687LHrYcGKrNQn+0?=
 =?us-ascii?Q?3KzaniE6hxoATlkyfEimNaibZN+MbsjSzRq0nMta0/tQrSvivfEZGPIVHE3B?=
 =?us-ascii?Q?ZZiEH0qECKk3U5hXyBGwjFn/SqDYFX7p8FlOiFwB7Udo77J8n/gv2FJkqutt?=
 =?us-ascii?Q?pkwGMbth4AA5D4H9jM2bVLNgKVbnNjjYrnw37tX2FHKqrP/P8A5i8XgzE39P?=
 =?us-ascii?Q?zqNzB/5OQ7BPhnYggRk8rc+kHUb71Itn/hsIv3lBhEXSZg9uMG/hmaouk5z/?=
 =?us-ascii?Q?iHyWqkpuQoVeXi9tdXuh1KatU9O5Cf5ND0hk7zMw7CcR+H18hB8tqmovMNmm?=
 =?us-ascii?Q?SitLVoOS4UdxcEjKEA/I1d6L5nYfNLih11I3T9no4t3IcxwwOSMlvPI77jBR?=
 =?us-ascii?Q?mJgOofvSIY3ZQgZTviJci7NMEWSWwjdb3P6AViD+KDftwX5PAY+kDmqjL8E9?=
 =?us-ascii?Q?sBKolugZR7w2EBD0h2ScmWPt5GBMLLOlRgWPHZ0BPCUc+Wym+SNP2XKplyAV?=
 =?us-ascii?Q?7SYdRbpP+xnsT8Z/A31UN0CkYRLnbWqa0yCpkD1mkLPVuPmLz3zME2EbVUi9?=
 =?us-ascii?Q?zENAhSEiJVEsSjSTo2FfsRVu49wx/YOC7DgBzz9nI2k6T1d1utfQnvn4Qylt?=
 =?us-ascii?Q?9c1IolXVibZ+8C+6n62j0CyrCmyfFC9SsJXZWELN9xBsMq7pg3T15J3WMFlv?=
 =?us-ascii?Q?nrTTJ0jYY9Dm0fhQ9BelfyW8T2d06Qc595Ga6UcjtXlFD8y7+4x7/pM1HCA+?=
 =?us-ascii?Q?f5neyyiZkLZX22PVvCdDdZkoGdo6iiZcljVXiO0jJzLWaL3d51NdfmqdVxL2?=
 =?us-ascii?Q?j9U9RShKpLXc7P15frznXO633CP6NtMo9kM6w3T8WDnCFNbSNSl3pS8fTwnk?=
 =?us-ascii?Q?77uQjo7q2yJJYtNQdXxkirCyuLd3gmQ2l1c4XB82ujGMlhl3yHvRqJ5w+6O6?=
 =?us-ascii?Q?Ia3AoFZm9ITg3QCr7eYcToZjFkQXPH4PQAjXOIPM6mXTzTOZiWYAXsC/Vj+P?=
 =?us-ascii?Q?MQjyP4/B/Pj64bg174I8iaesW7yawetfjg4dfbbfMKTHWrbwpzRAOnFDcV16?=
 =?us-ascii?Q?g6U/u5QBkYVh0XGkpOacTW5a/i9nkB5Mat9vhT0ox7jydaUZLBLehF8ZAc7m?=
 =?us-ascii?Q?Rew9qpvadKcPEwfT4lHizv7wh3B56j7GAfW8yvBesYMfg7lmlssf1p97yRcf?=
 =?us-ascii?Q?Payp0Air0oWkZLB9QC62imW2EFcz01I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iz1rW+bS9X31TODxbtTgMh8f0TdhiaJ9ItZepqGfEkrw14Odhu2xJZItQpdvLVV40UxlJwq8LWCvUXiGTem2x3W7zxAQYfdE6tFLcra26dzG+vaZ5hMtbiXpk34Noj493xnqySFKFkbrMJIU6vfIrhLR7tsuM5lZWA44jjX4zdPcgN4X6IT9fJJEFgI/eMJ1h6a0zM8FTwydRQktNEkapQovcdAP/aSSCXuuDgzHWnGc49K+ss3SNGo23fcqFTd6WiHyTLnsfTPTvlcs/PS52j3JBFWIhL6Do94oRsgoXkyl2cPN+yD3j/8vSlcsYdkbhG43EboTyE0T1RCBiYpQzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5207d6d-cbd4-4dec-292b-08dea9d7e7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 12:23:10.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYiF96DumvMxaa2J+RQIhSG9hECHzgQ2Np3/dXZD3CMwyP0n2sy4B+QgRgCDcrzi6wokmgegs0UVfunHf1/L66seesGFUkP9TgRc/oniDMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8659
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 6C56C4BCD9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283814-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Petr Oros
> Sent: Monday, May 4, 2026 2:16 PM
> To: netdev@vger.kernel.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Eric Dumazet
> <edumazet@google.com>; Kubalewski, Arkadiusz
> <arkadiusz.kubalewski@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Simon Horman
> <horms@kernel.org>; intel-wired-lan@lists.osuosl.org; Jakub Kicinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net] ice: fix missing priority
> callbacks for U.FL DPLL pins
>=20
> The U.FL2 input pin advertises
> DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
> in its capability mask, but ice_dpll_pin_ufl_ops does not provide
> .prio_get and .prio_set callbacks. As a result the DPLL subsystem
> cannot report or accept priority for U.FL pins: pin-get omits the prio
> field on U.FL2 and pin-set with prio is rejected as invalid, even
> though the capability is present. This prevents user space from using
> priority to select or disable U.FL2 as a DPLL input source.
>=20
> Add the missing .prio_get and .prio_set callbacks to
> ice_dpll_pin_ufl_ops, reusing ice_dpll_sw_input_prio_{get,set}. The
> same ops struct is shared by U.FL1 and U.FL2: U.FL2 (input) delegates
> to the backing hardware input pin, while U.FL1 (output) does not
> advertise DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE so the dpll core
> capability gate never invokes the callback for it. The reused helpers
> also guard on p->direction !=3D DPLL_PIN_DIRECTION_INPUT and !p->input
> as defense in depth.
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 27b460926baced..be72a076f7a15c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -2628,6 +2628,8 @@ static const struct dpll_pin_ops
> ice_dpll_pin_ufl_ops =3D {
>  	.state_on_dpll_set =3D ice_dpll_ufl_pin_state_set,
>  	.state_on_dpll_get =3D ice_dpll_sw_pin_state_get,
>  	.direction_get =3D ice_dpll_pin_sw_direction_get,
> +	.prio_get =3D ice_dpll_sw_input_prio_get,
> +	.prio_set =3D ice_dpll_sw_input_prio_set,
>  	.frequency_get =3D ice_dpll_sw_pin_frequency_get,
>  	.frequency_set =3D ice_dpll_sw_pin_frequency_set,
>  	.esync_set =3D ice_dpll_sw_esync_set,
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


