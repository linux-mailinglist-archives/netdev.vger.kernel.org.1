Return-Path: <netdev+bounces-285934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GByJC5IV/mkTmwAAu9opvQ
	(envelope-from <netdev+bounces-285934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:55:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 827964F9A03
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2C1B30088B3
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6653EF0C8;
	Fri,  8 May 2026 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5PxN94F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0F382368
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259342; cv=fail; b=GVE0OJQd9MaAEUC4aydjEMYNgEQOCzZ7rAPlQmXjHggcqsHBDsdpU74xSxS62fK3w2dN45Rx+bsjogHovy+2nsgUEG1yJv+26k0rCNl08CmBcwfZccjIMF30yHZtSR9WkYW9B+NIgwZu6UU+FikUZw2oCpXyzfMZj/Ji77vwhxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259342; c=relaxed/simple;
	bh=sk/liaNHrwid2WCPtRCM5k0KeJDWvwZtD539f7OMogo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ieup7J3ip4zjlp2m1jdCFhKtUW6PYdW/SnOJTFu21YmcbT9zSDvaSkLnNvTEzvJs0W3jNRN6MZdjw65o3i14jOcudnUCUzP4i7AVq+ObFkfMyZpDFHV3xGlCd6WgTaXpFP0YeLCiZY9iAzhP1ZtpErtQBF+ADg7gidqSM+Rf/qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5PxN94F; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778259342; x=1809795342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sk/liaNHrwid2WCPtRCM5k0KeJDWvwZtD539f7OMogo=;
  b=F5PxN94FvRMxnjiAnkrEHZTA3MvlaGkBKAx1CJoDLt/SBfD7Huhwjudv
   cimd4x6035gSrx8XW0qM9LEZmm9HLQUsHV8SHQsZNjMmWFhk8onMdkZbl
   SowCDPBgCk2uMMpzq3/fha6bDvb2evXBnNjGNAm33lhntS9F5+oYmpr53
   K8OMBDJYyfD6bgJ37z6S1TTBKIInORWISfW532q2F+xZf/pLhN2jkSfFu
   1xp2wtcxoE8Kr8S8JcFRa1Dthf5N+h0hhR9DDMIGgE6aTCFxSUMIT1K+v
   1wX7GEttpD/quUoNp72lVhLOA/6ssigfoxVnHIYw+EnOCFajktFlA1zbE
   Q==;
X-CSE-ConnectionGUID: DMhvgtgQTW6LqJFVFej1uA==
X-CSE-MsgGUID: foHr0uq7TSaxCawIvx/bVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="96657494"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96657494"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 09:55:41 -0700
X-CSE-ConnectionGUID: 7Xkz3x/URGyu76hcL2+iPw==
X-CSE-MsgGUID: KWmJw9AeRsaGF2xfOg1Hwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241775406"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 09:55:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 09:55:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 09:55:38 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 09:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYJrh4gbjpD8Jc99WHOlMazNPxkWyn4OMsKbYblp7jI1hL6Z/vLT2cG+Qr/LbbhY4FTgWLK2EYpWjpEKlyanUDld8tVfZufeuZJZb2HUNI95Odf6rMOJeg1QdJB3tpZig7Q2r31qb+QsLwq/o3T7UjLzILEH/V5rMdazI39cqQy8GosTefNVdplBeBZ5WavLUh/9h3h6Ty/ql3rPe0aP28FvqGtgrEQxNNue3bcSNt47TCb6GNB7I2VCpRKA285HzXKae8QoWOTXOFGpgFPEYIhFOfL/01GYeHmtbo/QpKCbfJX6X2Y22Rcvvb8KhFB4MJUuG1Hv6lsE2mPqh5VtqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc1dSUSpUrzD+uxhPna88lz8R8yAGYXUk2mEn/MERPI=;
 b=cZWgshCYRm5jlHYPqXIeHIVkObiDbD8EVI4GPlPQ2+4RePurYH3sLxObNlbirN7MKESFqItOGBhJ0/FAyrfDZVS7/n4FMlxa03K4MTAc/vs/dHRtMLCMbwx1bE0XdRL9B5VWCN+B2YdU+NQZa3/2yH827yPDb1PuoUWh27IH9EhSuPHuK/W8MP5Zlz/qX0pu2dy3331iiC+zlamum6sDWzog6oEI+eVNrBOIcR4TiZpqTXehe2ixlWkMrkehoY4hn1JpUpWRDYRYkd3H2ZlOrto+hVP+XHWSJxsbmNBSaNbCX3pWvrlOBRqzc+4GNJ5UZVc+ePbxijDYyyJk0nf1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 16:55:34 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:55:34 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Schmidt, Michal" <mschmidt@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, "Richardson, Bruce"
	<bruce.richardson@intel.com>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Connolly, Padraig J"
	<padraig.j.connolly@intel.com>, "S, Ananth" <ananth.s@intel.com>, "Miskell,
 Timothy" <timothy.miskell@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: RE: [PATCH iwl-next v1 12/15] ice: introduce handling of virtchnl
 LARGE VF opcodes
Thread-Topic: [PATCH iwl-next v1 12/15] ice: introduce handling of virtchnl
 LARGE VF opcodes
Thread-Index: AQHc3uqfgwAn7IdDEUe0FOxwcM4JfLYEV+bA
Date: Fri, 8 May 2026 16:55:34 +0000
Message-ID: <IA3PR11MB8986A9CD58E2977B0E79B8D3E53D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-13-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260508124208.11622-13-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB7942:EE_
x-ms-office365-filtering-correlation-id: 2f55de1c-57c9-406c-8178-08dead229f5f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 8QMD0cgRDiiG2hnUjPNMCtiYzCcAJfS2NOiS0gFjcob3yD5lh0mrHazwGSlsDdjAH4cdHaCibG/LuVY71M1DAHvTlotxyf+2yINspwhc8oW3HLpuuQUzwm7SQCzSk/0EENOj6s4nKHdgCGUJVjkom5f/wQtAXuArS6iRpWtAj+mooZtmwzWqbKIN+cmNvz8o8oinCQepIUKqPveEg4DoyMXSBudim5yf1h4nIw+NAyMlJs+wa64tt5HzNRoj6K9WoSh0odb1ShryPTPDJZobYyke/BYy7Qc2+lKd9v9x/IvjVlhEQSFK0oxb82azfHH+jroJ4VTK8A0ACynfJ8m1tOGHQCXpKD/Gx4JimBfg+/ncFv1zzJl3BVo+jZN9GmlBL3eWPbCv8g6W7zF/a0bnqk6Ak4wljU5/AzpSajX8frLRtBhW/BcGt3VnUn8/BamvEBEiokG7/ygAzRFdsjMPkylTMtkBIyGXDC2YUxvPwcYUiDzdnPOfHmk6VC6y/91yBOccipJKt7j8bCdlanxtdMl/pHK7yF9laqkiaIfNC8+v0sG6d05lZWvQVJVUw0hBR7Cn53Nualx4CvAgDCXQYHH/YbNgvfwlPWYN0YusfU1en8N2IatcoUGt/qQJwd8K3twCbgHf2hjLNpDEJKl2hh+LYLBaKOt2nPgn8YBkk15ZAQ0WxtEZ19INDRxL2oj/JR59A9sYIGYiH2PHSjRV7ylgYZmVbQWi5CIcLo65+quQMRHEgE//zlBk+Yb4ic33
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nv1rXkq5LPM893BgfxgSBtOZ3NyTa+HhoJ/u/6I+RIiL/ztMpp4r/8+qvNKZ?=
 =?us-ascii?Q?zVu9Kj1K13ggwpkbVuWqa72c3HgNBgTaHUleWqCIzWA/AMBPX1IoN/KZV7CW?=
 =?us-ascii?Q?3V8U65qWscMr6ODZZrI7FOx+8OJ5L0cNoDgNWhycln3L79VNyugVdijURI5G?=
 =?us-ascii?Q?6h45z3lNiHS8jVWWRcBQO4dccES2fvry8OtRgg61iXo8OY8N1x9PSSS/cTL1?=
 =?us-ascii?Q?IMBlMYszBG7QjLxT9icIbCezu0w4goprA1mBKiNRhWp8EJE++xzyu+urlvDR?=
 =?us-ascii?Q?O9qPsuz2d3aC5c65lyB6EFHLSZXKLmy+Gbnvcsie65IIM4gmBjMHiOf/rGb+?=
 =?us-ascii?Q?nVX2dAaJo40i+S4LrV/4qdjNlaZqLBPIrC6StAGDa0mpq/BaAJiEsrC4Tgps?=
 =?us-ascii?Q?OpfyGr6mH+DXNCDw1OcH5snQAhI0s4TVtreWKrmo4JLWR2RG48R9WsEkNbDX?=
 =?us-ascii?Q?s+ayaBiQK32oQ+HMZQeCV39z5rEz+aozJqUul0ir6O2UYAkOTiOSk2xhHfKQ?=
 =?us-ascii?Q?YeBNV2r1/0VWORERDaCHH5PgpPxjZjjEg6uS5S99a5pyBCLjuBMjn36h/f3r?=
 =?us-ascii?Q?HhrwVTYB3r37fNvNXKLNSJ57WrYrwHzTG3ETWkNBZeJ609BAoEw9zix3n/3L?=
 =?us-ascii?Q?7gW0hu35DYA296t6MOPdub6ytS8kfxEiR6AhrU8rUnoB2eo7uyqJ4QtzQbWu?=
 =?us-ascii?Q?iXGoIyeWnPQJSACTouFzhwwaxqTUQMC0rYjznCKyB2ND/6L4gKvTz87+Oc7j?=
 =?us-ascii?Q?kM0zKmXRCQLI3Pftry3FOmGUK7VpRMBewKW70A3LjWUY0f+u8kbFqCIPV2s4?=
 =?us-ascii?Q?BChMWtkxZnPYiud276t0cbN4p4M3BzXmc/kAd+ZMeYYSBpb7rH9b7tI8eZL4?=
 =?us-ascii?Q?lYAdvigeegJEDZ0K8wxYrz1+a8/NDfxwK8FWa3np7p0Pl0HpJ0bQT8Ex38NM?=
 =?us-ascii?Q?EBlQ2cm/JD6iGS/F9c5jsA5SIlENuuKk7OYQYjlPGv3/qoyiNeDMPvmetXPP?=
 =?us-ascii?Q?n1iKL0Lt4Yhkra7/3u2MX5a6X6YBqDY0Ki8SyUO9RLtfd7I+qcqzkylncU80?=
 =?us-ascii?Q?W1piZPapuSW/JzMcFBzXVDdk7nv98DZA8AcHVTwFfWv9sLgeyRCCJgTknQOQ?=
 =?us-ascii?Q?KDUZu4gQ9GBzjXW9I+zQzFv93swRqjYdCh3337uFnznE1HbWSRbczgGf+Mv8?=
 =?us-ascii?Q?J1a7Uv9W3dQYz4raDevtGkIWxjYBqH6VPw5O7f7i2aAeFPLZ52HW3RKH2KZF?=
 =?us-ascii?Q?5E8DQROEV+XQhK7szwlMe6gqJ9kwS890JkJAaC3fZ+e0T7udcDO6RNNmUFkI?=
 =?us-ascii?Q?25/CX7gSPX9skHQiiXR5zCXlpO1oL0uY4qcewl3gtGScqaAWiPqcQ1PDb5Id?=
 =?us-ascii?Q?l1YSdsEN5m7G9x9J/yHOWORM5bN8dX3Tc1FEU9ypGJVfduy9AHmJWL1u56t0?=
 =?us-ascii?Q?gw2ozLlxRFTnz1AfsbsZKq1kuXR9GWdA4bNEC48nC6M2XUPm4UeN1pBfQ7Xz?=
 =?us-ascii?Q?JOK+bGVN7zLh/Wh+hli9csyM9RrKsTPAbLKzsF2Ji/YJnj06UlhUrSAkLYqv?=
 =?us-ascii?Q?pnPBRAdxFEJ58TXERFGMSzsZadXh6bkgCmHI4uZj2/fYa671k34+i/IaJh0R?=
 =?us-ascii?Q?4Ef3SVtvBEmwwNYJu+A7gsj93YKrNNZEqnN4zKJtcFiL+2kXfFH40kVyuhRo?=
 =?us-ascii?Q?CVj0Y8qTiyUty7i4SYxpPaqAed+ggJ9BmOUrBY9K9vBQ2c+4jxMwTlRZBGxt?=
 =?us-ascii?Q?auehCgpPvgx68oufy2YeGdnxYxy0uLI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vQQ9sxIvXnjEtb5y32BJAN+MUXbbeqZxy3Eo9bYO1RMOW2TDUCb/iW7tKyIbiWEAKw8jcfXRCnJ5KGdi//mP2wJLmSJu4rmkFCbJewMGI3+FJl8iNY4FQGZLfjskyc7IhtS1Vu/o7el5W2CkCZXuQGn4I11Qf6x2cUK/vojd8DoMI2qGTrNVBOYygDeFunM+7LBYeTJXeQ4HjrN6AI5tz1frI++bjhj84Ftzuq1f4ShzyPinbWzp5eBtwNXu/IgiuGlxs4k+LsZAbd3msJAOysEkcnZHZX5UnJx9sct9kVia8NDH1qr8UuAjgdKbb3r05WdX2rkIYRXLcyJQBAoLrA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f55de1c-57c9-406c-8178-08dead229f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 16:55:34.7363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bf4RqOXP7SKmO5Th1LhnISKSxGW5+dzthB/U4sbFQr4kcKlijBOGStTir+GXgovXQt81CU6J2cPS2obZXsHoU4nVzlB2id/ZQufSN+FnUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 827964F9A03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285934-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Friday, May 8, 2026 2:42 PM
> To: intel-wired-lan@lists.osuosl.org; Schmidt, Michal
> <mschmidt@redhat.com>; Jakub Kicinski <kuba@kernel.org>; Jiri Pirko
> <jiri@resnulli.us>
> Cc: netdev@vger.kernel.org; Simon Horman <horms@kernel.org>; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Richardson, Bruce
> <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Connolly, Padraig J
> <padraig.j.connolly@intel.com>; S, Ananth <ananth.s@intel.com>;
> Miskell, Timothy <timothy.miskell@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Saeed Mahameed
> <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Tariq Toukan
> <tariqt@nvidia.com>; Mark Bloch <mbloch@nvidia.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next v1 12/15] ice: introduce handling of virtchnl
> LARGE VF opcodes
>=20
> From: Brett Creeley <brett.creeley@intel.com>
>=20
> With new virtchnl offload/capability VFs are able to make use of more
> than
> 16 queues. But to old opcodes were designed with a max of 16 queues,
> so new ones were added (by iavf/virtchnl commit of this series):
> VIRTCHNL_OP_GET_MAX_RSS_QREGION, VIRTCHNL_OP_ENABLE_QUEUES_V2,
> VIRTCHNL_OP_DISABLE_QUEUES_V2, VIRTCHNL_OP_MAP_QUEUE_VECTOR.
>=20
> If a VF wishes to request >16 queues it should first make sure that
> the PF supports the VIRTCHNL_VF_LARGE_NUM_QPAIRS capability.
>=20
> Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com> #
> msglen val
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   1 +
>  drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
>  .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
>  drivers/net/ethernet/intel/ice/virt/queues.c  | 324
> ++++++++++++++++++
>  4 files changed, 336 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> index 1b56f7150eb7..5411eaa1761c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
> @@ -125,6 +125,7 @@ struct ice_vf_ops {
>  	void (*clear_reset_trigger)(struct ice_vf *vf);
>  	void (*irq_close)(struct ice_vf *vf);
>  	void (*post_vsi_rebuild)(struct ice_vf *vf);

...

> +/**
> + * ice_vc_map_q_vector_msg - message handling for
> +VIRTCHNL_OP_MAP_QUEUE_VECTOR
> + * @vf: source of the request
> + * @msg: message to handle
> + * @msglen: length of @msg
> + *
> + * Return: 0 on success or negative on error  */ int
> +ice_vc_map_q_vector_msg(struct ice_vf *vf, u8 *msg, u16 msglen) {
> +	enum virtchnl_status_code v_ret =3D VIRTCHNL_STATUS_SUCCESS;
> +	struct virtchnl_queue_vector_maps *qv_maps;
> +	struct ice_vsi *vsi;
> +
> +	qv_maps =3D (struct virtchnl_queue_vector_maps *)msg;
> +
> +	if (!ice_vc_validate_qv_maps(vf, qv_maps, msglen)) {
> +		v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +		goto error_param;
> +	}
> +
> +	for (int i =3D 0; i < qv_maps->num_qv_maps; i++) {
> +		struct virtchnl_queue_vector *qv_map =3D &qv_maps-
> >qv_maps[i];
> +		struct ice_q_vector *q_vector;
> +		u16 vector_id;
> +		int vsi_q_id;
> +
> +		vsi =3D ice_get_vf_vsi(vf);
> +		vsi_q_id =3D qv_map->queue_id;
> +		vector_id =3D qv_map->vector_id;
> +
> +		if (!vsi) {
> +			v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +			goto error_param;
> +		}
> +
> +		q_vector =3D vf->vf_ops->get_q_vector(vsi, vector_id);
> +
> +		if (!q_vector) {
> +			v_ret =3D VIRTCHNL_STATUS_ERR_PARAM;
> +			goto error_param;
> +		}
> +
> +		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
This function declared as returning linux errno, not enum.
And in this case there is no reply to VF (goto error_param), couldn't it le=
ad to VF stall?

> +			return VIRTCHNL_STATUS_ERR_PARAM;
> +
> +		if (qv_map->queue_type =3D=3D VIRTCHNL_QUEUE_TYPE_RX)
> +			ice_cfg_rxq_interrupt(vsi, vsi_q_id,
> +					      q_vector->vf_reg_idx,
> +					      qv_map->itr_idx);
> +		else if (qv_map->queue_type =3D=3D VIRTCHNL_QUEUE_TYPE_TX)
> +			ice_cfg_txq_interrupt(vsi, vsi_q_id,
> +					      q_vector->vf_reg_idx,
> +					      qv_map->itr_idx);
> +	}
> +
> +error_param:
> +	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_MAP_QUEUE_VECTOR,
> +				     v_ret, NULL, 0);
> +}
> --
> 2.39.3


