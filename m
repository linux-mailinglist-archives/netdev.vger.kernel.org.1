Return-Path: <netdev+bounces-302676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jS1GA0yCQmo+8wkAu9opvQ
	(envelope-from <netdev+bounces-302676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513046DC17E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CPDCnihh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302676-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302676-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D799930CD521
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA486403AF8;
	Mon, 29 Jun 2026 14:10:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51B3D8915
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:10:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742220; cv=fail; b=X2gC/rQk7Ar89EwYO7EVei9V2dl7SL5eFyjoFTf9oHTPj05ZMgVSx1R2eI/xUNl8ok7L/ir+ySyllVitJMQ5XSeEbIUYUfa9MiIkFiwpiQpz7tEyx1kyKj0ygdPPMRmClfj4FQxgBmWpfDFYp4M0yj3EK8UM/nEC06a6oUoPy6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742220; c=relaxed/simple;
	bh=TJkhiUOJCQoMooJJZUeQP4oxux5wcDO3ycx8ihsTuHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X2hRcPtzmbf59IBilAmqky85hqONRRDRg0mv3Qw9Uiv0ghm3Fcw16vDYfa3ebVdLvFAA74KESN3gKkttrD4zYf5qpaCMJlQUGFZVn7qHU+Sgno/xpy1r2BcxMYNvBUKYUQVA3ALe/AronXggU1ZkADDxSVJnaS1i4aNb2VpO5rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPDCnihh; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782742215; x=1814278215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TJkhiUOJCQoMooJJZUeQP4oxux5wcDO3ycx8ihsTuHs=;
  b=CPDCnihhajNqUFJDQLyNRhOgRtBcXzoubmNlYD/HoCij2fMDIeE6mOHy
   1D1NYnj5Y65ASedMgo7g1nLc0yMh5qfi/roYNUlCXBxF2LFBXnZAjSrny
   1WJGtAMPfcLXpX/B8+h0gg6S7Z/Holwn6HvyYRhVpwwzezacgqtzLcOdj
   vZ6pNhi2s+M9plcMAGYS2V8kT3figVo7g6HsbXwGXC894YaPQ+36lt1QV
   8rcsO2yv90TCLrhHmOKuF3x4X+BobVsbyFPvByT5h4Ml/I5EgcL7SBvYz
   bwMu4Jbjtpu7glhz5HmH52SOR2jTdJR3nx/XggEr8Yi5QdQaoKaXOxx1X
   Q==;
X-CSE-ConnectionGUID: EMEYzysDTemofOZG9ZtrNQ==
X-CSE-MsgGUID: E4aKeRlTS96Lm/5XCmGQOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83201999"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83201999"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:10:12 -0700
X-CSE-ConnectionGUID: 9eaM5TtJQEWa5bWRvJue6A==
X-CSE-MsgGUID: XESO3vheTWykqDeiEcGooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290092092"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 07:10:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 07:10:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 07:10:12 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 07:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAUG73Be/+9EQMfzHTZR8Kd6BywI3EeXBC0+oAK5qp2nvaLqNn2HUQ2ayakB5uCMKHWgeA7Wk0VMCNsLuDRsmHMTGgryjMBtsl4ic19dmNrJVAhgnCcxY2KlEmtUW4tUX9H17XSTya72BvtTR/1ChoyxaJLBkCjAQ9nE4vJ4oDaDbuhf1onXWpRejjXoEQgJUdO6bk4wOjMzzbywljCbXYCz8xiNkd9Seq56gBxw9liVWXHkxz5+S82BLdVdLBd+hFEYLJayqEuBhnI4w3T+hbaA+l7Ax6+0rCodCjCn/R1l7iFWm+6BySgY3VHZ32l1h3lq5JBDcAnnOmJoChV5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4+w0qmH/IM0n3hkW7g2zFAx8CFHbPQ2MBwEazwTTAA=;
 b=dM4TOi04G05BkHVi+jE12/xgARUi5FsuEBQ3mCF8fztAvsLAYNfPM3wFWoQapa18gOpUgUdUdDRV2xmNoTQlRDl9wUBsgKI9RKp1Hmt5kZ4b9uEk3vF5WyH3zD86c0eT02Vi6LI3bIZNXFvhZ0UmVaBVQpBDL9vYqSjvo8np/Uhor2VcsBzuEwha7vx/WB18NhT9fVCM6KOk6fmVVv982i775gq2NvffaHVFLKLMpB87BYyWaFJbvXlBnW++Xx49Ht/XnbKNC4e7tfkk8kVUyF3q/BYHGmVGWlTStY6Piu+MW24/jUz3wPx9Tmr1waoAC/0diaItkRYeiNiB1KmDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:08 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:08 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
 configuration
Thread-Topic: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
 configuration
Thread-Index: AQHdBS9NkgM1dvCiXkGRLLUlDdZa5rZRa1QAgAQr7GA=
Date: Mon, 29 Jun 2026 14:10:08 +0000
Message-ID: <IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
	<20260626054730.1126969-3-aleksandr.loktionov@intel.com>
 <20260626152636.1e48330f@kernel.org>
In-Reply-To: <20260626152636.1e48330f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: c42ae235-3b87-44ad-a21b-08ded5e82076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|56012099006|18002099003|6133799003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: xwYL7dCxvzjyPzYMfGJXwUeKhTbcTc5qSbaWZjPoWEDUXVlV6V4H8n1VAHegKba1AR0y/QO+U5h0RF//bhJsVpJIFf7gtWhn/gAC3lIcito3rIlddYQghxr3tlzeMwpPWd/GHt9B0Qj5BEaUvDk3QhIZcxiTd65p5JCoc5QMPlQGA0AGJCNBX8/IVLhmNjnRRs2Ai809yNKPsN/Pzt3WPlHAKnAnvCyE1p40g1A7+3Fozredvu0UNtbtHOaIHf3FEAM9E1ATJq6XqchKs+qJZODVghj0W/BY69ldFpk0s4gc/wA5NodbEL3/exX+BbKELUgJezV5C3PuMhN67NpozUMbiqyYccyvGLHMTcTH3WE57Im7wESa6Wh/Xdozaqnx3R4f8aDE+NbxBCY79v8x8rD2nr+BsZ3jvLFzT6fqH9ZmMHaCjW4WJIlshKiqSLG2fWojVsMY7jZ9ZzFpvO1ZJDdwHTWHcjE+Tvlf87BgObzPzh0cC3eJz9CKQ6hbyHjjR3bOXpL6kTraLbvKvgqZj9OpHleP/wprjO65PaX9YwBYipB+LXJOAgdw2SVa2+4pePs+AsfXxSIlG32fKdqkkaEaqgXu/qv9HrHpG7EE4XSzueEM4x0gujf6upAT8tRrlDdO8RssyMsXEf1avsKZBiT4i4hCRV8xq1LoDCnKDkrAQNlJgw3JQ03EqhPYmKTt0E8lr+z5NXiImxEbF5dpvp1du9pW3Eu+H6LbvIwIVGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(56012099006)(18002099003)(6133799003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H0VSdMKBvO5Km4Qykt5gbPgkEMTRm/nkf2zxLDB1qqQq369x9I/hbkifj8RO?=
 =?us-ascii?Q?YJqxv0olINNf0IUXV6KPgZZ5Sd+OJE5Paim8wi9+kbybxeF9vFI891F+3nD4?=
 =?us-ascii?Q?L8sCjImABeacN8yo5NVyW+8uRh0udZdyvVD7ip/7IfWvPaqaWoA6YBfTFdwv?=
 =?us-ascii?Q?U31gRJkG2tpZqN6Uam9G15wPaTodlQYrAq+0vTwaDDeI7VNWmzB4VRPv07ZT?=
 =?us-ascii?Q?oc/9EDLgNRyRfCP57nCvZY3jM7uqCsvmsrMf08tx3MxIO/JDMMpfQlA39kED?=
 =?us-ascii?Q?DD53ZGtfmmUZ30JO7n4bZhkvdffjBnBaMC7toXjfTD57xcSj6ylxouI93SOZ?=
 =?us-ascii?Q?I6yAnk7uuZBdGC2+RsQrA7fReIR6P3tPtiIPNKdtWmAXTNgHar4ONDbPTmR7?=
 =?us-ascii?Q?lXYkz4YTRns8WpfN0NHnjuj4aDNXYqBHIH8l2EOypbiZmyUiqIDTUckWzJtx?=
 =?us-ascii?Q?qbJKSXpYr96mdQFmiPt8MpzpfQIKTScXJ4bgY2CQ28bMj+s+myM5yVGb+TP6?=
 =?us-ascii?Q?Zty7qFm4P3hXh8VKh/GV+U3nlGr24FVxVb9NY84bX6XGdSqLM0WChFuf84Xd?=
 =?us-ascii?Q?iyeZGbmDpYsd/FJldAwVzNNlK1Hz8zd0x0KI1ci7nl8gwsgwDBUC/tXRe+d3?=
 =?us-ascii?Q?qOkBbk3hnl/hGN26LDdWiByrq9p6nOqfh70tM82UVFyw17mVRUCxsVogxQ+v?=
 =?us-ascii?Q?/DyBCVdimGgwc6EgbiEXcTiISZVvUgIQtwJxuLsSMieUBtXBBgu6jmRBUWCN?=
 =?us-ascii?Q?+x4PtrPldUhad9XrP3U47JitqLobBhTOQMCnatcbC08FwK09C14h+08pBUuG?=
 =?us-ascii?Q?f4l7orWPr+qCfxOGgt7qhHNMHnUCLJvzox9r3XgGAV+zHDpGPgiQMY84ZnIf?=
 =?us-ascii?Q?2Cr471R70n+I2oCpBjffCruU5Ggopd3G2dRJZqRb3K83wUSCuK6poCzBa1ZG?=
 =?us-ascii?Q?g0Gg7WcE+Dkzxpm7WtwVNId0PQPnIplLtG0hh8v/CgwI1T6XOcToKtOMEKJu?=
 =?us-ascii?Q?8P1UKHDBpglQd/NK/daZk7DL8GtjZsJUV/criLqBt/875f6BxgLOXUVbVDc8?=
 =?us-ascii?Q?ma9KwsGQts1iAwu5AX8NkLyy37LmwqGg4uHmFOIvM1HCCE7w+fTt+BTeVIKP?=
 =?us-ascii?Q?z2ZwwgZWJc04ZvqGc1a5VVhD60ty+6Sx5BUCCa830flxfwX0OCEcI61lWM7q?=
 =?us-ascii?Q?DiA++BOMlSybtkD+TuLfkjr/kyw0JnTG8KLNUN1/F6H4YEL02eciOyPKU8mJ?=
 =?us-ascii?Q?AQs6q1UW95drkUEoyZ5IGi6N3XkTs7Kr19K08kPKc1KK/7VClLhUYq97RfrZ?=
 =?us-ascii?Q?cXDmbKRscLyeXjjfJFX+Pmn02rPSu9rM8qmNnh54P/qV59jnM7ncEo4dMOIs?=
 =?us-ascii?Q?osHUgTP2LR3//5xk2nlzC5vQS2VX5tmHMynQpSw1BF8gAzWLNJz9y+2jEWDm?=
 =?us-ascii?Q?mB30MlVtKZRhkFel7c7CQvKOJ+7ZT708cdsYtLrk7R7kok7qrmZnjN8S1fz2?=
 =?us-ascii?Q?mMD7goPkQ4kSPZ/Q5hOOvC635x6VuyJ2EuhJYsBFIj+Vm4lzPLy4RoEsTpk/?=
 =?us-ascii?Q?eLJKUceE+2FiIDicIMUX4BBUoNXFVXSSCNi2Zka2+57o4BA1750NGYdDFE5C?=
 =?us-ascii?Q?0y5mhxMHwvslYv5csy1u93YVougUsnBHXJHaiRdLl/ealqQJ5zUpJBbe1+52?=
 =?us-ascii?Q?1IiN/y3VHSKgyDiKq3oDUsJsqc2XZC7ELckNlsmbLl+uqzteVSefLvH8cVeD?=
 =?us-ascii?Q?rkGW5xcRaWokhrsfoREUg4OYPvlbewk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tQZa5LGVvvjdPAkGmtoBpyMORV1CI+mMiz54XDwe2WVdmcZBRLWLHd6SWbiBgXKqVjTwnTDFTVeJ64GEbgwIhm+wXsR8zaASLGmQ7SoUs26oV7QRJpFRBWpONFWMCH4gG3h6CMAsQMyitnW3iidoYzb/GmOw2Z57kp2QAP0b22lwEVbMjqfF9758ecACszOfUjRXvBmVOQrr2+TdkpoX+zZscvCfKjZJhNkqmPNfUUV50uAjmQzYtLblwewk9JovvWYoc+TFgKCJF0Ejp4d+uKAlmCofzzsqLWfHKfqdVDoSV9MtG3bZmUspDJIYT98tMtJh2vm1tVlfd62pbNq0EA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42ae235-3b87-44ad-a21b-08ded5e82076
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 14:10:08.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sU/emfIUeklNGRwxSA46vRitTYkPckQoXZAu1DVKxJqlcFfB3NccsuU3xhC4EqgkanDU+yiETS+Np7Cs43gb2OL8QiNztuUa02RR0aUGePc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302676-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 513046DC17E



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, June 27, 2026 12:27 AM
> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> Subject: Re: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
> configuration
>=20
> On Fri, 26 Jun 2026 07:47:30 +0200 Aleksandr Loktionov wrote:
> > -	/* Update the VSI's hash function */
> > -	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> > -		hfunc =3D ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> > +	/* Handle RSS symmetric hash transformation */
> > +	if (rxfh->input_xfrm !=3D RXH_XFRM_NO_CHANGE) {
> > +		u8 new_hfunc;
>=20
> I think this is the very bad part. Please extract it out and send it
> as a fix to net. Looks like any changes to RSS confing on ice randomly
> enable xfrm sym. I isolated it to the ntuple.py test which just
> changes the indir table, and the driver says:
>=20
>   ice 0000:e1:00.0 ens1f0np0: Hash function set to: Symmetric Toeplitz
>=20

Good day, Jakub

I understood on TEID; I will drop the ethtool core patch.

One question before respinning the ice feature patch: ice GTP RSS profiles
include TEID in the hardware hash fields. Since TEID is not generally
symmetric across UL/DL, should the driver:

  1. report RXH_GTP_TEID honestly and let the core reject symmetric-xor
     when GTP flow types are part of the preflight check;

  2. hide RXH_GTP_TEID while symmetric-xor is enabled, even though that
     misrepresents the hardware hash input;

  3. reject symmetric-xor for configurations where GTP profiles include
     TEID; or

  4. change/program the ice GTP profile, if possible, to exclude TEID
     under symmetric-xor?

My preference is (1) or (3), but I do not want to encode the wrong uAPI
semantics.

> Which we never asked for. I drafted this before seeing your reply:
>=20
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3692,10 +3692,10 @@ ice_set_rxfh(struct net_device *netdev, struct
> ethtool_rxfh_param *rxfh,
>              struct netlink_ext_ack *extack)  {
>         struct ice_netdev_priv *np =3D netdev_priv(netdev);
> -       u8 hfunc =3D ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>         struct ice_vsi *vsi =3D np->vsi;
>         struct ice_pf *pf =3D vsi->back;
>         struct device *dev;
> +       u8 hfunc;
>         int err;
>=20
>         dev =3D ice_pf_to_dev(pf);
> @@ -3714,9 +3714,12 @@ ice_set_rxfh(struct net_device *netdev, struct
> ethtool_rxfh_param *rxfh,
>                 return -EOPNOTSUPP;
>         }
>=20
> -       /* Update the VSI's hash function */
> -       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> +       if (rxfh->input_xfrm =3D=3D RXH_XFRM_NO_CHANGE)
> +               hfunc =3D vsi->rss_hfunc;
> +       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
>                 hfunc =3D ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> +       else /* input_xfrm =3D=3D 0; core rejects any other value */
> +               hfunc =3D ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>=20
>         err =3D ice_set_rss_hfunc(vsi, hfunc);

