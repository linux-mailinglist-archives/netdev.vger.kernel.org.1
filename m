Return-Path: <netdev+bounces-269802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ItKOvDvvGme4gIAu9opvQ
	(envelope-from <netdev+bounces-269802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:57:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F72D6624
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B9183024A34
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89E355F21;
	Fri, 20 Mar 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Foo/mEN/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4178355F2C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773989869; cv=fail; b=ncNf7NEHOhhiLRDzj0JpnziIMbyfZNWzQNum3X2L/Okbwpx+WHcRQ3N9z9ZjJ5N4YbhZt0ee48Ombo/PBaIjHvQsJeEhvLbv6sPgpkqQcRNEHnI9X6gtXVEek6how6AlCNgAv7WQMc5IdQ+h2wLjdYhiOHsp4wtAH/c8NoUPGAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773989869; c=relaxed/simple;
	bh=/ngHH456VoXo2i1HvBilMjmPYQOSOs4Swd1FEdCUfcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KTl2KGYPQ+foKQj+GkY3ca8rvxxecRikjsVHFON9k6kNwujVZtHd7Lo+N8WPlzQwtbRhOv2dELf9++8Dqwb924iOu1mwfRUltr7Sw5gaWugoaRNKi2OjB9z9ntq7bYSCKejOyuM1P+CrEId6HiwA1gK4X+GEC3W9ma6XfL0YOrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Foo/mEN/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773989868; x=1805525868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ngHH456VoXo2i1HvBilMjmPYQOSOs4Swd1FEdCUfcI=;
  b=Foo/mEN/6H4ZYvrww/1r2FpstK0sejP9hhBgHw8cbFhLQQhCQyVy9Q1G
   fh5CEQ9UkWjVPkFuGx+WVCMgze7YipeLx6sHzgYA5+cAKr73N+o5M2g/z
   qT8cjC+fVxVFtokn2hzxONjVgOfHPVZXNPMayQk2oF9R0kAz6McTn5THd
   LZy9zeMy8SorAjeK5Joctr0RCiN+U1yxPe1x65tZzPbobk9zm0od13PUN
   rYBGL3l1dhGg7xSRb9i9h1Cgoct+BW5ueWLkifSu1X2CpYGj61AtpLOvh
   sAXBTnXZakzhXZETcc4sOyMX7iVExAN4cAMJ3z0B7cqj81mDhxijlF5yP
   Q==;
X-CSE-ConnectionGUID: Blo5LQ1XQcqKFgTtFUtLMA==
X-CSE-MsgGUID: Zw/180b/RfKG7sSEeOv/hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85772971"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="85772971"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:57:47 -0700
X-CSE-ConnectionGUID: D8aybhPvSEm8FVDhz0flkg==
X-CSE-MsgGUID: RCYgjY1qQduNjrKuWiF1xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227330031"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 23:57:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:57:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 23:57:46 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 23:57:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/byoJS/LZUUWbEp5Jsmq0i3qA8hGK8fQRxu6ddJ4GKY3DqZJrXc2yfIMdvtfcXsH6HsCvkgY5GU65uWq/8RfaRN94OAAwObZxYb99iBUg/tnoQ5fBLlYo0275Uk332BvFxxxWCwad6aQNw60fEMX035xskbFeAdmt2aJsoLnuTPYE25V/HNXCU0RRmp/U1l8E36dLWNC8aCTSWClQwthWapQnOjOrJOXX9sz34B9oss/8dGEsPcBppsgGr2B+Fk5fSInPGbhY2bYNAMBfSVfBij74dua9guatbjhuuMeMCWtFWvchYNLlbiJIn41ajyWgPY27lMNxeZq1x0bC2olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBK6TnaACClbjpedG5uZHT8KZNCtVvLyWzyXVaJRi3Q=;
 b=G826lU4Jz6XzsG/g8AA0Rvw3aHIfJRBBpVqxYkHmlXjg7BmMX0PBMGzYtKhCf8X5YSTM69wk/9CSOaABCrY0a3dJUJXFxi3ImqAyK/i/dTJ8ozg6XXVrPcFx1yX8XtYXcHlOzdy4rZE6SRxpw1ynApr91zkG9YmmJQ39aGa/H2CX1KKNbNuIbRnH8L6k+MIGihSKMfkLlocTVPw9aRyKw60quHTb9EX9hz/PKUi7ValJ2vZy+Ket4p/yz6/+uH1E+V2iNteTqm7yI1jjk0gGz1xgeP6kqb7c1B/pM/s7H3ENI8PgI1sQXbo33Jw8l1Paa4sYcHmgwqvSXfXDLteSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 06:57:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Fri, 20 Mar 2026
 06:57:42 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <kohei@enjuk.jp>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 3/3] i40e: add support for
 bpf_xdp_metadata_rx_vlan_tag()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 3/3] i40e: add support for
 bpf_xdp_metadata_rx_vlan_tag()
Thread-Index: AQHct8RSXm0tskQpQkmjPRS90/G1OrW2/hHg
Date: Fri, 20 Mar 2026 06:57:42 +0000
Message-ID: <IA3PR11MB89865073DDFC1987A6445DA7E54CA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260319171650.5815-1-kohei@enjuk.jp>
 <20260319171650.5815-4-kohei@enjuk.jp>
In-Reply-To: <20260319171650.5815-4-kohei@enjuk.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7409:EE_
x-ms-office365-filtering-correlation-id: 1f97714c-ef81-43e1-cdf1-08de864dfb6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: ay0dLXUH/pS0rsak3wcAp3wvyY5n7mOnkcZiPAdrSn7KqzTquyRLNXnvrTulpGzWr4Zs3et7QigmqakgmlPqtseN0qbhMYQKEif6TZuUFn5zvsxB43ZPgRCiLKjnSmlplefJNPX7eybjI5q4hgBmSc0MnhnsgWHFMc8KoM/LEPlKlfEYp6TRUVTsbspYskTooFDpeOt2O2Q59recAEoLAyw9MVZQAQ/We5TDcmzY4bWUHJUfX3DqTCiddq3Ebfe2jt602IPos3rO3BvtipmcbRSrwKC168Tjgorx5ZiKHBFmbfa6G2BCSoAS+zVn6z/k5BTn2BIErK7Sk+bh8XO33/efv5m1/eGNrRIbhH727OZKxFXaMAHgSOReaeBkGO+65C/5ErsS74SR4+owP9vmfyZHXeOhKhSmFnruWC3U5ev9Hq6lXtyeIdrqQBtmoCK8YYqofrwDUJh8as0gId5JPJOQMZwOEXQBlaq0KyqRKKLmrSDKWaZBG9p02au1yK8jn9h3vNdf4qapD+4+EJinIuIq5j1H/fVzEBqaaEuK/trhCbi2tdZI5ILYVASiSktatPneAqie8Ssfb4hhQJVa84Y0WSJUouAFwTO7ccRh/EW5en4yuFE4m+TYtBzvM/yVShTi2/VTsAj89NIyobhA+lS5YcsvK30+sGiALHObtfjJF2ky6j6cTnYhpjSG74YtFLhm+FLWruKs/OIiFePQBaXqwZCAkmgh3qnTMpqjo2lbZv9v8jx4IBlH86WiDTo2zImXwWZBkBIgk8EeN8ieHneDUApsRh5NeDZ1pTWAxPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKdYHJ/tR3WopUdvvP3eUHXOvpbMBALdxxZommyU5i4t0vGa1vugdTtjsSYw?=
 =?us-ascii?Q?ESZcEiNU5iZDGyAhsmqpCY6+uR37D/42b+Nh0oI3Y/7rtGDF9jjl+vJw/ozL?=
 =?us-ascii?Q?cL0O+vxTsoSNzAlVc7dla1VAyVA/6YB+IWKlKUhV704eiiHJZZ7xal318D9F?=
 =?us-ascii?Q?eQOnfvSd4ygnMz5mHmM1/jq0Fs91K7jhyX92WqOJv460jdFPamcp/cfUx4gf?=
 =?us-ascii?Q?0u9OWmtmBOfpoG0fP+pVoooad8uuFyrqvINei13uzfksEULT3Z4uQzyqKgB4?=
 =?us-ascii?Q?MNIQ6QiWKw4u8tXPfnWU0Mix/17nzNV056IFare4jOY0V8oDPSRsBxG02iFt?=
 =?us-ascii?Q?rD4/rWc1eGHDhmwj8hKsLWi0af63n3SeoFMO6q2mhYrlJ3ie3YeVZRTzJR7p?=
 =?us-ascii?Q?0Et2lfcvVWXuYGyH/uLXHmdi+Jws4Rky8//O3eyjmCjJrg+7Te9FhkfblhXW?=
 =?us-ascii?Q?kb8w4b1cqj0o2B9NNhz5OaUnJ8wxGcH9V333qGAMqj8bTvwR3ZF3lC5NAL2p?=
 =?us-ascii?Q?ZJuePW9yASP53Scgo52G07h7xRhHsEVrnPkTIE74SsSatCVcwzMpO8fREdQX?=
 =?us-ascii?Q?D8mmCcIvlIpLH6jZ/UUkO23d1S5t7/1XOgO6Lm3/KlvcAEJ5WIiMZeqyTbrY?=
 =?us-ascii?Q?xDOseADaWy4IuShTJd0kEY1iDZE0gwwDrUVeN2weHsB9cW+qam0W4jehOTQN?=
 =?us-ascii?Q?TU88nKVc166Gwdur+8rnIqoJB4tRtbDVSeFGHjD3/9Kun1fzokNrmBlIPE5l?=
 =?us-ascii?Q?3z/QIh4HmARO/llY+ZKhfAGnQDpFFXRE9IhOumbSSl2DS3r7EzshTOiFK/30?=
 =?us-ascii?Q?GfLYSV4SiNZ2p5hS0GC4mdTVZenrnbru9dt4UI5vIP7sHKqtJA1b+mfIoYU7?=
 =?us-ascii?Q?iGTrS1DaXjh03xgQ6Rc1vdLD0jPukIuSzOFCwSqJJ5zeQo3el4mdEQ2twIlH?=
 =?us-ascii?Q?ikWbldw+7Ol/5akBvV0uVV8uAf1z8DkKEsQSw7GM9qI2pYaM17muwCCawJ0i?=
 =?us-ascii?Q?pcnypzCAWfv4Nq8AGXjY3O0+tilfLRA7Pn/uk6oqYW/oUMk1fyiykyPq4LRe?=
 =?us-ascii?Q?ZrcFIdf0nxz2oaxlN4YRueXqwQYE6SBLH59Q1Dg4ZhcXjVvVXRIux4HRhW0G?=
 =?us-ascii?Q?InxFS7GXajpdNYSYFmZIAzlGARHz5N7xcdLmoy541Gee9O7SRnHGJodRv9d/?=
 =?us-ascii?Q?Y82lU0aeknHT/wm9i0D6TrWmagWKXUF1tiPeIbFtsXnZPZkCAXTHYy3QJkGE?=
 =?us-ascii?Q?o8vYkF6lJNiuheORPfsf9NmQkWeeHhRSc5nZF054i6rq0Nj8Gizc8ukytpzc?=
 =?us-ascii?Q?cYG+lgSPgF9pH6XekpxuDNC4+nlk9gJdLxx6G9jiAPInBeAe9jlNEw2ronf8?=
 =?us-ascii?Q?SbUcateY/I28s2AJ5DYjOWrojkDgGgVk/rv7NNB5sg2gcA9Ypl+3va+oTZ4q?=
 =?us-ascii?Q?Bea/CexOl2Nj7N/innhRurnF+eITTPNAdsnaHslShit7WqA2URIcJPOPypNb?=
 =?us-ascii?Q?eb6896TmIAhdWAOyePUPlw7ZVpviEz/h3Y4Nh+bLhXcWwSuJfAlPyaNEKAw9?=
 =?us-ascii?Q?3wkKJ/clSaDCtrbM0RGx6yki8Hhz4KF/RWjGxtSc25tXoUHGDYg/bL8KmQeN?=
 =?us-ascii?Q?0KUre2IM1VeqQ/1Sn6G5tNWy1krG59fNg1GmGMpOfET9ZSbrUWWHaPiq5/Xl?=
 =?us-ascii?Q?sY3UnxAmFVU+iVLscepKz27IZlc9PYpmm7hCukiKZf49kWv6qKEYunlVF5gc?=
 =?us-ascii?Q?8pG8TXguGYI9o8CXg0+ohxcOFYIPl+E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J/a4v+RfZzKk5JPEn7/CY8trlz8TRoEHo441yRaJRcCXo+BRgnZF36El+UJ+VBzA6TyiB+eWGAxjwVJ+ul/PGIL/wUUA3FXL4UBUqv+QdX1fpcTHos2ZRt+N1nS6CQvvuxnzLp35bVegCJx+0u4kcNVHemRbg+KihlSVVmrHUmhGQcJoQJE0PPnjLp6GzseFjf/vJLFhcaoMGuT7ee302wTSX0NPwgAUqlfNfbjquoyuZLnmyPLmCZzD3El+KCULnjuBKaXVj/BfYqT5Vk4inFFCXkTz0npSp81ouiH4vfNxGFbNsJQ5JAXDVxMQYFilCXN4rmYHUvZC/S6A32jDcQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f97714c-ef81-43e1-cdf1-08de864dfb6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 06:57:42.1470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZPeeqeLImfiwTdC8xGjEQ6wfEzKT/pcliuCzPymwcoRumhQWpw5MPStDHTIDIxJum9zGSsM275zyScI07FA3auhGZkDJ3IKcCBbMN3OxD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269802-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,osuosl.org:email,enjuk.jp:email,lunn.ch:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 644F72D6624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Thursday, March 19, 2026 6:17 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; kohei.enju@gmail.com; Kohei Enju
> <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 3/3] i40e: add support
> for bpf_xdp_metadata_rx_vlan_tag()
>=20
> Introduce i40e_xdp_rx_vlan_tag() which takes the same approach as
> i40e_process_skb_fields() to extract the VLAN tag from the RX
> descriptor.
>=20
> Tested with X710 adapter using xdp_hw_metadata, and confirmed that
> VLAN tags match between bpf_xdp_metadata_rx_vlan_tag() and
> skb->vlan_proto/vlan_tci.
>=20
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6b7e34b16a8d..3749f32ef95a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13610,8 +13610,27 @@ static int i40e_xdp_rx_hash(const struct
> xdp_md *_ctx, u32 *hash,
>  	return 0;
>  }
>=20
> +static int i40e_xdp_rx_vlan_tag(const struct xdp_md *_ctx, __be16
> *vlan_proto,
> +				u16 *vlan_tci)
> +{
> +	const struct i40e_xdp_buff *ctx =3D (const void *)_ctx;
> +	const union i40e_rx_desc *desc =3D ctx->desc;
> +	u64 status;
> +
> +	status =3D le64_to_cpu(desc->wb.qword1.status_error_len);
> +
> +	if (!(status & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)))
> +		return -ENODATA;
> +
> +	*vlan_proto =3D cpu_to_be16(ETH_P_8021Q);
> +	*vlan_tci =3D le16_to_cpu(desc->wb.qword0.lo_dword.l2tag1);
> +
> +	return 0;
> +}
> +
>  static const struct xdp_metadata_ops i40e_xdp_metadata_ops =3D {
>  	.xmo_rx_hash		=3D i40e_xdp_rx_hash,
> +	.xmo_rx_vlan_tag	=3D i40e_xdp_rx_vlan_tag,
>  };
>=20
>  static const struct net_device_ops i40e_netdev_ops =3D {
> --
> 2.51.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

