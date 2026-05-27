Return-Path: <netdev+bounces-292389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHBWKmIeF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:40:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD215E7E5D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE4C300D716
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24FA3EB813;
	Wed, 27 May 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zia0oOJk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D543CEE4
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899949; cv=fail; b=WxlAqG9o9CmkUYIONGnNAZPHXxkkmccUt0/Nqzeodh4ZMfJadPz9I1qQ+OgZI/1mGfVgjGwJLuqYBT02wv/Q/y5wVtjZOpjtyqw8o7FaVtpFZsM5sSA1K8hCOwjbTfe/jMocwMaj8HAHbi3S5wkukzDXFxP+Qd7WGYmr6Slye44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899949; c=relaxed/simple;
	bh=2sf/KoEd1K03JpmXtUvOcyEE6YRH5tSLR7F0F7fOsDI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gS73WMoUkAU1q/dqscQuV7LI+112SfnQZ0VG0yNyVPgflmI0XJknyRuQegtYwyrV/tQbuS95cRVJ0qVWfHoRURuZxENq+4C8oUYSIxp3eby4/dxcleN1M17GuQ7BCyzFjiQYKK4c4wtAv6f94s1+aDWo+1ATH/9qdM7jetYwnCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zia0oOJk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779899947; x=1811435947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2sf/KoEd1K03JpmXtUvOcyEE6YRH5tSLR7F0F7fOsDI=;
  b=Zia0oOJkc2SvJBQUJOfw3PO4HyAzQnLBgcrH0Chxd6UMq/mFsd9eGe2l
   ntZShBNMeLoqu2Abf7nS5ysZK+C973Yg3h0i2zL7Xb7BAaG2FvBWpt48O
   dvVhv8u9SuA9aR1gKhMN/Vww3Hu7CN8AFeamsiFRw+8hsc8UvAjTKnOHu
   FUlHekOMq9+MPhHLHxHeUr6n/pPNbTClvePsmPblsrxE+fg2FxXSYowpy
   dUcicPaCsX7SvLXFTjixEXI9EEvmkcKkUxCho6z0rKGRa3hcDjsSXvhIr
   /qGzhe6AZpg4fbbam63EmQ1XItbRg1pti5P9ncLr5NzmQk8gxitGWNeN0
   g==;
X-CSE-ConnectionGUID: KbDsNMd/S2yPfb8BtFxR9g==
X-CSE-MsgGUID: JUHdg1u4S6CBvHFVl71edw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92122883"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92122883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:39:05 -0700
X-CSE-ConnectionGUID: Ia0oO9ukRQ6h4ObT5OSNmQ==
X-CSE-MsgGUID: 6FAIoaZ5T4+4Kg6N2vydEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="241248703"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 09:39:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:39:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 09:39:04 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 09:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl4/C1CQyzq2g8IjLrpXdNPabTbZ9vCW0ZTHbs5B291M2qT9apth+pMx9WNNGZ8iJlima3HhpRiL7PxC+ySoP2vIersK5gCfxVOZzM52fIbcoW93ukVs50SwOA3eQTWGd+3XipfGSSCvK0bnnx205yLe0w0v6kyUtvka2kONFX+yTJRMYko/CM8pHoJv/KFl8onFDk1OlHkknKOMWk5MWs7ZSk70G1gqXrK6C6mHANQUkxyNiLmmGSeznZxONUJEkcsKz79e1fDeH14DMPP4pmkcWApGFfMwIAoO5hnjzhcGWTYCXvt/17BeiwJqxza+wCe9Dnzk0WOdWCzCChxtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5DpGsLJfCrsYJeGg+a2wmD56ZEQ2WO7N754OUsjXUw=;
 b=Ghe1Zh7hulD0lBAPgscd6E5aSoBE90UBTzCCmuuzfPo/GpywoNthBIhDCW+wRs17c5N4wB4RJV/V6spQX8OOL13EhPN9Vj0AC0yDwQ5L2mQUdtleLfvpsYCLMW3qNWUj87EJMJfHM0ZGeqEypA3s0wRrfVeNXkhADuI5CJFwbPQD57H1ll+XILUswYoLFCNaiYhKV/4hzYvdG3hP2zwE0qIGkbhBObGwkpxC3FkjrmuPZOtvO8Dt4oVywKPiFtRXFOt4WlDq/HaF8rqdtY9OR0C2eigI1t2zqe+Epx50ENstOWNlD1WkRViNTh4bKrKb07ZAJyhklTIR8VlbCts1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA2PR11MB5100.namprd11.prod.outlook.com (2603:10b6:806:119::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:38:59 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%4]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 16:38:57 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 5/8] ixgbe: remove
 ixgbe_ping_all_vfs() from link state change handlers
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 5/8] ixgbe: remove
 ixgbe_ping_all_vfs() from link state change handlers
Thread-Index: AQHcx1luIwfUlbCAWkW2BDbiICK9xbYiX79Q
Date: Wed, 27 May 2026 16:38:57 +0000
Message-ID: <LV1PR11MB8790AB9B108EFB98905DD2CD90082@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-6-aleksandr.loktionov@intel.com>
In-Reply-To: <20260408131216.2662245-6-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA2PR11MB5100:EE_
x-ms-office365-filtering-correlation-id: 40301827-f98b-48d9-a19a-08debc0e7310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|3023799007|11063799006|4143699003|18002099003|22082099003|6133799003|56012099006;
x-microsoft-antispam-message-info: /s6pIacYfsn4BLGbYJ5gkg2ZPjM+5mhN+HpVkCLTbxfos4TRPW27hyDaPXchZiUmPH2WHie93Lh5dZ1eHvQibrf8pFAKVw1TrIa/D8sHRPkrXHWc7cEYOlkBlJXEjPf/aah1E4qf1lYJR5qWe7vxnn9YoszoronrR9O2MyGzKE2yPFUpegz7MWuabyIGnTL41po0PeWmZE0Tdjg2m9W0KAUzr/HiRHGNfJJEdU3IP12EfvOby+iRkZqunIp8eqpzFaky9Ig/cHU1TtfgiqggAS7AOTijbMNpP0NImOLUvOJRCo+ObcoDhe5YeZSRVns9uGNvkJQ0d6+kOtYit4ZcKugLMwbXsLfacP4AvRy8NjfEC+OF5qt908UUwSgezbgv23rRDGFP0MnHtQUWcIpDRrj05G5JC9VrMqCzMsDpbjXwgZN+rtIPOo655DYgfOU33GVW224WcuTWKiGSnQeGl09djCmExyuWVnXsJXJaU+z05L54Lkg0InCe43imUKIP6SyKJkSdDJbIGgdnroaeMdhmDY6I7JgqU+VSFn6KAVsNF+hOVnqUQg+8Am/KO2Vs4AfSNvINwwjZ+a7dCSpEsJXVnUB+OoQDwhg6cVbZTsZFVTi6Okignj3Klv6tpCzAKuFy21gnX7H3ea04JOXYP/YZxHBrENyqLxquEulgVwwpZlUIgGmNPjDaSAo2sXyNTj8pxEU1cfBrQYc8IHQujSd4aOroy4dutNFPS/tdBvBl8hy9grt7/vm1u5BXTvEy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Xd3bozSQL7j9nY3jmv61TBNsdNN+C6k8W0hm7uQ0w2Sia6mnhuoYKUR8Ftm?=
 =?us-ascii?Q?wfLEYKE3/gJU72LKOs8kAHwpPkUhBXy3o5XOS8Re96tBhlWCskxXqGmjL2ob?=
 =?us-ascii?Q?Nt3xaVQPGwx5n7BGc0YZMIzr/sMzkivEouoz30GeRB3Hrn8TcNkzYiEyUXqn?=
 =?us-ascii?Q?mmrPa3MBtLEa7EQIEk8xyuNd5YItpWau8y4rZ9m+IlxYk4Ouryn6WeH/3SDF?=
 =?us-ascii?Q?z/sDKnFxZCgT5nli+UsXUR0I0NCo61Chd4VY2OdNQQ3YJrK3BsLa6R/XAn2N?=
 =?us-ascii?Q?ryb+wgspyhltmY/pawOnvopxr7KNNPndJ1ChDK8D53E4Fu4CJNxSremU0wwR?=
 =?us-ascii?Q?0LpTThG/fdNjLm4dDiXQA15/RPM7W6TiWWFtrjq+8S1YYNOLdOkuVATn/Lzw?=
 =?us-ascii?Q?6NKV4WoWF2Urgi6TnBHV8b5qhhwiUPbZkXJpAbIgQ6YMjeL9IhhnbX8dNFDO?=
 =?us-ascii?Q?TQ11HIpERx2yxGz8Hiucr2W6cpH04KNNJpKsZgN71PCG+WrqpfMi41HveJnz?=
 =?us-ascii?Q?AU98kFNTHhJzSkOctzQkv8p9nEmjDCwH+SPpNPU3vP5iD1i84OkE3Y503ccg?=
 =?us-ascii?Q?RcqCVGquyze/CpizKZrNXwsXx9U98WT9jgPE6iwCfPhO1LM/yKs4h9WK7DtE?=
 =?us-ascii?Q?Qd7v1wK4ujZiixCa8vL71gWPJe0vBt+4uyxsX1bQwlxH+sjTluUly2Q/t4Tp?=
 =?us-ascii?Q?0JIFdmIy+VUHt5E68fhnD7bHLyRqlTrXCJuYmUtIcQEu/V16lr0bDcCraL6q?=
 =?us-ascii?Q?zfqsakzE/w2Ew/sbIzxrzkG7m4mW/knJWfbIaT7m2HIeVQX1oq/DpY/X6Afs?=
 =?us-ascii?Q?8AAfPfjSmEG7fDv4rLvz4+m7AlkVWzXQxi2Y5ISiMqTLZol52hWb0aF2F0u+?=
 =?us-ascii?Q?TBfmxTcJjWO2rfhQcxMw6GmmDKy86w9CQOgLTKc/4JsY5jjEyyKkuAHqrSvT?=
 =?us-ascii?Q?qsYpvniuqCrXn2zMPdR1Si+Qbqfeye12a1WxEVR7gl0VoBYFihRM1qHznGcK?=
 =?us-ascii?Q?K81G8L/Wqo8nxTkCZOyOCgt3CQEv8tcXBQ7XvVPNtraMvtlDrxp8jbtu+WvF?=
 =?us-ascii?Q?rE4e2GWN2JodxWNjR5gupfTK7dZvSdWXfsIMWB8UibBx6iVAHB26PvvXkHO2?=
 =?us-ascii?Q?7bGz6EkxNffbz9wTc0jxXuRLD9oimmxkJo8lfXkTy1JTQiKPyUrB3gM+Q+0L?=
 =?us-ascii?Q?9n4sH+KDLvMGYTLkN9T+Ojb4lqluOQUah8apECTWPL0iDxKr7FBARaxJVZYi?=
 =?us-ascii?Q?uzobUafqamXc5ewmNmfRq2sj9cz6FFNLecZedAX9BcSWEEA1y8Qm2QlmZ/1A?=
 =?us-ascii?Q?vYF4SRx18GwtFah+h54W7a5Jvyh+CoC3xjSrPgOR8Qu2L7fPKh8TBx7a6pEc?=
 =?us-ascii?Q?umRowOcPjpVmt4Sm6Fe8KFBc5BYWE+fzAr34abaxHaAZKnTr+KGYK+N50xgt?=
 =?us-ascii?Q?+GIHXNykNXyQimzXuKCyCwOUO64DyaBg5IWk1RcNTB7jVPup9nj11qprZLqc?=
 =?us-ascii?Q?HhLmhu7AsArPIDidI0vSVWdBvDYQJ1vzDmQgEpBvHYn6eGXAqIi5MaMCxRJL?=
 =?us-ascii?Q?E3FwdX6n0ZpK0cFDZ1ZsI22Wa2uRhPWdeiZy+Fw2aeu9IqrFUu1NhjBCaSBx?=
 =?us-ascii?Q?x0pdNNyuqg4LkWAEOEAnCYbva4fsYVfpqqdboYdmhP6oEkR53xRHAagkfy0k?=
 =?us-ascii?Q?sfXfH57CUuFE5AjMOQBdRnrgbfdZbi+EoGzWmjC0ZkVV36qkBcMQADlkETVN?=
 =?us-ascii?Q?blTTHNAJdg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kaznP0kWKb2PvNyLr/JazTBm2sfqp9hNj9G044U33MzOOkYuKDFoOS6TbLlv85+Pz/nAQ+5eQydnbC29/PAnLIckrt3BT7Aojur8jw1NwsYKxYyWqewECcc7+ppUq6kzL52p1Kjh43a4lq7M5h+Xx4WKD9QNfTCj+U2sPUwf0wj7PKqvlnZcUMJkq5joxG7O+nAV6pSP4rUsWXZpCCLm3Mr8bzIR9l5KVNXlwbZhyWpwA8V8TCb6y0tRdt8EvPgiIrNGr7FjgMZH2yc9EiMj4POduYXpPrckVZbmUpSqJHIexY+E2ih6wy091Nue06FtbrxTdSf6JD78mxp7dzTjYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40301827-f98b-48d9-a19a-08debc0e7310
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:38:57.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +RGvsVKbIY6+BXktqkyNa0FURmoB7k3SwxKHyGWJqc2udcTndKhloWuOe1nQHVBqT7LyMG4hVcmzhOEDTygMUziKryoSFCdxy3lmVeXhkkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5100
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292389-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,LV1PR11MB8790.namprd11.prod.outlook.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,osuosl.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2AD215E7E5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> ----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: Wednesday, April 8, 2026 6:12 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 5/8] ixgbe: remove ixgbe_pi=
ng_all_vfs() from link state change handlers
>=20
> When multiple VFs are brought up simultaneously, a VF can receive a CTS (=
Clear To Send) mailbox message instead of the expected RESET | (N)ACK respo=
nse, because the watchdog fires a gratuitous ping right as > the VF mailbox=
 transaction is in progress.
>=20
> Remove the ixgbe_ping_all_vfs() call from both ixgbe_watchdog_link_is_up(=
) and ixgbe_watchdog_link_is_down().  Both paths contain an identical call =
with the same race window during VF initialization: link-
> state changes (up or down) can arrive while VFs are mid-initialization, a=
nd the gratuitous ping from either direction collides with the VF mailbox s=
tate machine for the same reason.
>=20
> Link-state changes are already communicated to VFs through the normal mai=
lbox protocol; these extra pings are redundant on both paths.
>=20
> Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Extend fix to also remove ixgbe_ping_all_vfs() from
>    ixgbe_watchdog_link_is_down(), which carries the same race window;
>    justifies the asymmetry by eliminating it.
>=20
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

