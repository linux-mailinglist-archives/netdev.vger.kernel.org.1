Return-Path: <netdev+bounces-268043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICixKQ2zt2nUUQEAu9opvQ
	(envelope-from <netdev+bounces-268043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:36:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEEC295B75
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 08:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5553032652
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4534FF76;
	Mon, 16 Mar 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnbXaTcW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EA34EF12;
	Mon, 16 Mar 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646467; cv=fail; b=I2QJFbdNfKaZZ0wET1GnVp25bW4QGB/QhOAldVRSqJKwUwd2Fp1UKbK499dQEQlYhId7lk6w2D57+GvyXy7kOXrG9JTxiYueltmHLZG3HZa93bsqeM7G8CoKzWUlI25wSRNKX4zaMLjR7OzcSoRXIkQDkwJ9xlnC9JerK91xm8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646467; c=relaxed/simple;
	bh=QRbCnF8P4WR5h4u6nvL48DuXzvxBdAAi6fHczkRiMRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1VfTDCO9yHsO/XTUsAG6P7+wgkbs01bxq4fzFJdP6mZIptzrd/+uFKPtfoZBzcA9zCp3USUj/34+slKnRpxyQsv7iXN7GaufnwdOlBSRPr9PQ9tVDRVraR7X4GIZscLqA6ha8zBQxHOdLgCJurde8mfkejBHBAel8dE8ZDM0Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnbXaTcW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773646467; x=1805182467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QRbCnF8P4WR5h4u6nvL48DuXzvxBdAAi6fHczkRiMRc=;
  b=TnbXaTcWb1DO4gPsLkV59J0wEFuYYDw2JbR17Se0l1Px9Fmq7GHkuPld
   15ymDiC0piF2HcwNPLRCm8ewib2DRMEJ8YUWJZgFp8kPGfVorFEwLCR/h
   FRKUnvolBucuRVeqpdPdm7XOjPvXJh7sbMW3UItO2zC9yQ/Va7FOwJpds
   bQ4dJYy8PVDkIoJtyhfw2pLe3szM1tAJxlJQfz5UPM/0ci+QCf87lUbEH
   1pKUYfIgjGoJ1jzuxL3Dz3W8OibgBSiW9C5RdQ55Z53laq+l06LvPHZFb
   9vRqyyLX6S8vFGVz+NMjvVmB0Q8UyhIfQyMD/HuTdc/scuqnfsYRvvf7q
   Q==;
X-CSE-ConnectionGUID: Jfg0m4d5T+amhzo9GelKGg==
X-CSE-MsgGUID: XUR0SpisSaWQ6oKOByyKGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92039989"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92039989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:34:26 -0700
X-CSE-ConnectionGUID: GP76yM0STp6U+fs1ZXm0Wg==
X-CSE-MsgGUID: ono9v3lHTfiVl1//GqMI3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="259730581"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 00:34:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:34:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 00:34:25 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 00:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJST3LCMNb6dEzEsAr8qZVXldq+WVp2tyIO2TbOEEqtzExj4kUR01KAhW/MNTFX8DMcUtmACCgMfYXlzz8SGvOi11A7CL5vxpCawDPwaim/FKC6ZqefaKdKfc/42rSVlj/l8mmGIf9tkjVEGaHalKmz4hZZ37V+5kpnOHKosiY/DzIPKdMYKaNEj251zuuhqHbbW5W4RkIewnuqDvOvySHaJ2UyYWvAEmswpsW0puhtltJuri36q4SabIfsa72rUTZn0FHAi6+psSRgCXt/sJ5QZhC2jn1UYKVB69vSoEGSCWPWxNm8E8jrlQAabNSQCq6dHXow+7s/SbuLLDF3APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQDNwHhkWZ/l8X1BI6/5m7ACCcCnq9JWHvbYMnh2Q2s=;
 b=dNlEXjhDVJA7qmRFxP43gLojpT2MgRwAnS7++w9RVYaxMO6pfekibumMvImFnxSt33ALJqgdqClkfF2t6/M4a/RqGQSEI8vQd+fbw3J+gHNBnchtJtEkISIHn5vwzamJ6VzGNWXgOVWeLaAjq1vMlYM/CPwirQW8KH/Ha7glHyuMpL643S5sj7ZcsaI6Tc16sDImtliDGzM+eaf0ESi+KEeNwDCa/w28FYMzXMYd60oe2E6rWe3Fri7PWYUotIoqlcNz1LGWdvxLJPqBElKfz9y8ntJIWmrJmeTh6WUeAJ4qlx/4ylEqVaam4nJDvzGdIdLiiL4SkPGIapAMlAZKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF263E38237.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:34:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9723.006; Mon, 16 Mar 2026
 07:34:21 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: I Viswanath <viswanathiyyappan@gmail.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "ronak.doshi@broadcom.com"
	<ronak.doshi@broadcom.com>, "pcnet32@frontier.com" <pcnet32@frontier.com>
CC: "bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 5/7] 8139cp: Implement
 ndo_set_rx_mode_async callback
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 5/7] 8139cp: Implement
 ndo_set_rx_mode_async callback
Thread-Index: AQHcs+CHc0X1DQd7Z02aCI3themySbWwxlZw
Date: Mon, 16 Mar 2026 07:34:21 +0000
Message-ID: <IA3PR11MB8986856F0C1BC5A02F29B32EE540A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260314182809.362808-1-viswanathiyyappan@gmail.com>
 <20260314182809.362808-6-viswanathiyyappan@gmail.com>
In-Reply-To: <20260314182809.362808-6-viswanathiyyappan@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF263E38237:EE_
x-ms-office365-filtering-correlation-id: 8cec44a4-8b5f-4105-192f-08de832e70c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: D9bapEh1VuiVbvktrAufG9EHsAfoTJiHDjt5ghgRUkVmYI81OF0tBq7MTu1X9bxOgytQQvzttnZtNVbo9NQ5/bFBbx7NkQtKmni9NyHAqNpVbOTcp+WeYJiBe5KhUWh4icHbB+kGlsBuznheZzKkpH6PdAt76gkpZ2ePWt3m+98gDyO2wBBDTRq5arncdVT06vbGIeZXZ7Wdr+AhskwzA+Gr6ye+FXp+s0ulG1j+dAgnY7LfHCibNDNnr0WP7c5hf5JIPFoad6QhlVzn1aRXOYRMcvBa2ORU5cm9cnkV2heJquzjLUi8c7n2qPXcYTzkfZDMpR/Esfx+AXyKYL/U8BzbGWQKLX9EX8iaYJoKsco5uHPmPQT/hJyV1wNOpa7spoztiNrjC03RbhgKlyRWdVC3fDKETUydey+rb4FH1/vGKZRN5zamFIDNp8wagZOOrLV/1AZ4/l4+ns/7fY0yLxuy9EoGKz4Ht+n2AVY2+hYfnD//mUd9Xo9KrJvF6mcBtBxyM50Lren9aaCPlokHulTBd7Pcihnuc+KuTzRQpieM2QWDvsJfjq7KgVFjKX4B9gUxHjUnFfnJiLfdwYTDEvX2wtxoZis/e++HlL32Cv/adDcGbc3m39SX7JoV2Ntb+zt/oyj90gQewx4SMvFHOe4d66F0LYSTHmQ/0eU797aV+iVkFJhPESzaAOEzw+xZL8ke1SdkG1JWFDgn4RINVsbruEv/agPil5DhoMNeYj2JR4LNes/5jabZQBV11EI8TXIzJNFmcOqppmz3nS9G/UfeEhHcI0y6Hk6rVt3bWbJ1Wr7mSFZozveo5FWr0L8N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQiGzVsC2SpMsUBXDJKmZLwnQ+hv5AxFEeZMRPJe+J53O2Ye1vg2RrldBOmL?=
 =?us-ascii?Q?z1fHjlKcF/19YeNXj2+qgW+fYDSJPaj1Hs6ARJYCLN9/fwf+rBlgOZvb/cpg?=
 =?us-ascii?Q?mCYCOunBJnP+oNwQrAEXnD2Yj2cO1YvWCOq+Hzz84PHdSDWCMXizuu16N5rE?=
 =?us-ascii?Q?jxNk1DPEhTreIGHiPTBZnyGnayE9+bagUFzS5tK4u2urTC5X+z72ehk6yObi?=
 =?us-ascii?Q?UaB4Cou03Fe2kPmGuq00XbBaZ/DpIKBTLGXt54tI/vwSXBFO8H8aKL91jK68?=
 =?us-ascii?Q?LrwU5kF0PH4AF3xpIupPgKrALesFnPtv60Uv0ckHXuXWB+sUsW+jwM9frMQs?=
 =?us-ascii?Q?r18DcdodEx54/gITDZwhSEsj5xOOIUxndCOvMuRuaz5xGZb+aoAlLl88QOOO?=
 =?us-ascii?Q?9E0TPm6hrWf2GDfResEjyVa1uOnbI8CKOC8rgOQfRUKUitR//TlXYGQfSihH?=
 =?us-ascii?Q?dE/avetHW2ge+j7c+/1OW4eDvBJ4FNuB4sl69VOfMYesxJMTti3oY8PAoO90?=
 =?us-ascii?Q?jz+XlL6cbHrHxlnpounzxkmg7HchS5ZfAYDL4PeIraVfzbZgq8vbATlHnxYg?=
 =?us-ascii?Q?UB/LmtdQOtPKHGYajAkVf4DY8v9qC6k3j6f8BOcN7bpZmIyPZauIXcY3DqKo?=
 =?us-ascii?Q?sk/NftDoAiTrocmwzJE0ZWNWKyRxKPNJALK5hF2KG9KTTTAhHkKIFPt1SKZy?=
 =?us-ascii?Q?74YtVg8NVV1IDv7EqsSEHSjXTFxtB4ODyz4EFt/mgu+kBOaahSja3PWeIoMD?=
 =?us-ascii?Q?PrO/pQX85gkPDe0qfJND+gXqmsiXTXbPJsco0otmLfO1BVsZ9FZLB5JuKiBU?=
 =?us-ascii?Q?/FIurcveydshyeQJL/ACK3V6139ag7bSv/wMDHj5QVOc3eR86CerVIIAL7Up?=
 =?us-ascii?Q?LIy/07Qg5JhOlZNaTG9ACteH/LRkTUA9xpJfIYrMAXtpGg30Oi7O1biG1sW7?=
 =?us-ascii?Q?dZA7CmQDpXhVWou+9wJs7s/OSl28jv1UsUP824SH+lo29tksewoTdTJWQ23a?=
 =?us-ascii?Q?cnpu7R/OIN2vf/YEIY94lfpDss5HfOe5IVeEpZwOvoWdtOpe1IFu3q9IWAwT?=
 =?us-ascii?Q?x+tT94pXNo9Maz8RmFviLvZHOnPNXzCProE/6wmZLjiWXrVt0EpIc3QGPGU5?=
 =?us-ascii?Q?xDIA5+h968xg5u6c4hpmmE0fCm8mBwchYvQsvlJOpRhgr5nF08rZMoXUZ9Ir?=
 =?us-ascii?Q?RjI+C0nKqxyC0KjSCLzvd3x8G4ZX0AQVUcdv03R63YdbB6aZ5C5fMWHI0K7e?=
 =?us-ascii?Q?plP15PAJI5aIN6506arZLISVuiNQmONBgelsfFfcA93o8SChc7TlxOlO3N3g?=
 =?us-ascii?Q?z66JiO8Z5HhFUFS0srFWQmTZ7y52MAkPacBk7+puoylDGK7fSuDrM61ajhT/?=
 =?us-ascii?Q?jzd8zaqBK7lQnZuj+fWN5XcBqEpF1O4TBXHrL22ZqTGZeIJkKG6PTF7e77Ks?=
 =?us-ascii?Q?D/gkobYJVuG2pcF5f/FWgWSeD0yQdu0FNvxRx8+2xhY27kJ8T8l4Txz1/GeW?=
 =?us-ascii?Q?8DDQ9a5KcmoJ6d248CQdxAWR8smnnS6peDEun3rs/cQj3qSG4iR2wqJp7hKr?=
 =?us-ascii?Q?bxKFYDjKLpmjo6aJz59aY+09dlQc/+yz55fsKtnxTMu+lV+31+IPwtYBNp4p?=
 =?us-ascii?Q?5JoE7V4BgIvSYivx5srizEaok3TPu836MXBh5ihkucFjk3nofbpVWRDvE70h?=
 =?us-ascii?Q?DEDhFuaVNb2Od6k/66igvDv4ac7oh/UF7xTDf5RQpiF7Kh2vptcpK9ivpVLP?=
 =?us-ascii?Q?g+qsa2YTn3E/yFI3omyGjsCne3YvHkk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZmFtl9Vn/+ZK8T9rz1uHzzgE4++WXO2sMfT3jAV9awIelmtZxqsRKHQaaAZttikQdUxZ3V0RhQHPTXpzaAZs5DkUE0QTGmbzVQjPFWlioqjX17rMcZ1xO/r8sUJUd0/EdRAOOOTEqDrd0sGI2I0CZXOKAE9LvV3cPjbNDOGa9ceWIb6ZVoyAhuPuguUHKiAs4jM93RzObu+4QBphG9j56RuqqxglZQzGBpJPNrE5HMT8w5Y+BOxyLIGiGosQ5odOGkip3H1p6ECAO1VDaX5jQBa6rgvPLhDjkHpxaHnSImT7AUQEdEVMw+rrU6qPWaloWukijpTF+Z4GbVdCxTq7Gg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cec44a4-8b5f-4105-192f-08de832e70c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:34:21.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKENA8tNz3xHXNlQQwVJ+AzGEAmg2FY02jNl1n3/ZwrAwRgobal62Ag0Dv15wv26I6a+1h+L+1diQAk0OR/DPuEwGv4XE1Ce3j5vPsP/3Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF263E38237
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268043-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,linux.alibaba.com,intel.com,broadcom.com,frontier.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0FEEC295B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of I Viswanath
> Sent: Saturday, March 14, 2026 7:28 PM
> To: stfomichev@gmail.com; horms@kernel.org; edumazet@google.com;
> pabeni@redhat.com; andrew+netdev@lunn.ch; kuba@kernel.org;
> davem@davemloft.net; eperezma@redhat.com; xuanzhuo@linux.alibaba.com;
> jasowang@redhat.com; mst@redhat.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; ronak.doshi@broadcom.com;
> pcnet32@frontier.com
> Cc: bcm-kernel-feedback-list@broadcom.com; netdev@vger.kernel.org;
> virtualization@lists.linux.dev; intel-wired-lan@lists.osuosl.org;
> linux-kernel@vger.kernel.org; I Viswanath
> <viswanathiyyappan@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net-next v9 5/7] 8139cp: Implement
> ndo_set_rx_mode_async callback
>=20
> Implement the ndo_set_rx_mode_async callback and update the driver to
> use the snapshot/commit model for RX mode update.
>=20
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---
>=20
> Call paths involving netif_set_rx_mode in 8139cp
>=20
> netif_set_rx_mode
> |-- cp_init_hw
> |   |-- cp_open (ndo_open, takes lock)
> |   |   `-- cp_change_mtu (ndo_change_mtu, takes lock)
> |   |
> |   `-- cp_resume (lock added)
> |
> `-- cp_tx_timeout (ndo_tx_timeout, takes lock)
>=20
>  drivers/net/ethernet/realtek/8139cp.c | 49 ++++++++++++++++++--------
> -
>  1 file changed, 33 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/8139cp.c
> b/drivers/net/ethernet/realtek/8139cp.c
> index 5652da8a178c..9651a0d9d8f0 100644
> --- a/drivers/net/ethernet/realtek/8139cp.c
> +++ b/drivers/net/ethernet/realtek/8139cp.c
> @@ -372,7 +372,6 @@ struct cp_private {
>  	} while (0)

...

>  static void __cp_get_stats(struct cp_private *cp) @@ -1040,7 +1042,7
> @@ static void cp_init_hw (struct cp_private *cp)
>  	cp_start_hw(cp);
>  	cpw8(TxThresh, 0x06); /* XXX convert magic num to a constant */
>=20
> -	__cp_set_rx_mode(dev);
> +	netif_set_rx_mode(dev);
>  	cpw32_f (TxConfig, IFG | (TX_DMA_BURST << TxDMAShift));
>=20
>  	cpw8(Config1, cpr8(Config1) | DriverLoaded | PMEnable); @@ -
> 1262,7 +1264,7 @@ static void cp_tx_timeout(struct net_device *dev,
> unsigned int txqueue)
>  	cp_clean_rings(cp);
>  	cp_init_rings(cp);
>  	cp_start_hw(cp);
> -	__cp_set_rx_mode(dev);
> +	netif_set_rx_mode(dev);
I'm afraid netif_set_rx_mode() in async mode expects netdev ops lock contex=
t.
Driver lock !=3D netdev ops lock by definition.
If this path does not hold the required ops lock, lockdep/WARN can trigger.

>  	cpw16_f(IntrMask, cp_norx_intr_mask);
>=20
>  	netif_wake_queue(dev);
> @@ -1870,6 +1872,7 @@ static const struct net_device_ops cp_netdev_ops
> =3D {
>  	.ndo_validate_addr	=3D eth_validate_addr,
>  	.ndo_set_mac_address 	=3D cp_set_mac_address,
>  	.ndo_set_rx_mode	=3D cp_set_rx_mode,
> +	.ndo_set_rx_mode_async	=3D cp_set_rx_mode_async,
>  	.ndo_get_stats		=3D cp_get_stats,
>  	.ndo_eth_ioctl		=3D cp_ioctl,
>  	.ndo_start_xmit		=3D cp_start_xmit,
> @@ -2071,7 +2074,7 @@ static int __maybe_unused cp_suspend(struct

...

