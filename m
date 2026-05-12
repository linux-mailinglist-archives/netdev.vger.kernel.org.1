Return-Path: <netdev+bounces-286964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP9gKuzFAmp7wQEAu9opvQ
	(envelope-from <netdev+bounces-286964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D1951AD3F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09E87301C032
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832044B696;
	Tue, 12 May 2026 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmH5pBKj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1754DB54F;
	Tue, 12 May 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566617; cv=fail; b=BcTfR2PGTEI2yBKODjs9DURRa37PuP3QLTiCnjlQRVYpBhr2tMq/bMtgz9MqVyPEVBNVk/r86QED3jyhc5mfi56YMVBSzR+aniEFCivZQXosRuUaigv6XXMcA0RrXo5WdR1/CNVXBZiS5Q5JIIxRW07hzqyh2krkWhT+9e615hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566617; c=relaxed/simple;
	bh=97OqqOCITFT0NXp4yHE4ptspB1Y/TNtAXr6ayLGzfak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aBc28gxlq6PJrBvCKeh8ZyqPFAwSpdO0Ac513pjmZhn7GnL/FMTgjtNvnU+50kkrnybXvdddJnmbawYmqlxhwoa6X9wUJz7BQcOLKTIEeos2rzc8zZhi5b65GHgUHpuMAIaiAP93RtJFYeFhK53fvX26q24dXWOtnW8+Q2jN8co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmH5pBKj; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778566606; x=1810102606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=97OqqOCITFT0NXp4yHE4ptspB1Y/TNtAXr6ayLGzfak=;
  b=JmH5pBKjOV0/xx6jA+YcwycoXFzAIIc1CISr3ZxRA10Db74zACfyeFA1
   /IFglJrKwqLOaLP18E3XDIsXPVyUZMCyqotFDTRt96y214CYf3EMBKk+m
   qhPVOzF8cM56YJW2fM6/tILlGGEoxrNG7ksug7k5u281AiwrXtWcMBeVs
   PfQ4NhFeoQ9l1p4F4ce8pPlWCKRLBSRZ+Nad6FWEbtgURO0P7kUs8jB2x
   rJ9mpMLq3k1srnN0VIH8mGWI5A9CIwirmYGTrmMw1q2MmQkxmEeKLWrcn
   9rCzvPPh8obPqhoywQInQetNz+cyFP2uP1EoFGFVuZZyeMyFaIoa8lrPT
   w==;
X-CSE-ConnectionGUID: kMYTm/wmQT2l3BTdnoRdSg==
X-CSE-MsgGUID: 5y5uIIDmSEKkdtFog4BMPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90567421"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90567421"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 23:16:43 -0700
X-CSE-ConnectionGUID: Ltv5M2QuSm2MjTCYOYkbRA==
X-CSE-MsgGUID: wfuN4plbSGyb/9pdML7HkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236688913"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 23:16:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 23:16:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 23:16:42 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.7) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 23:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFgkm66bACzu0EpmHtQrci9U8e1gz7gZ1YBauf0GmSVpavTUqqIx3lVI9P1j2gW2V0sgN9S443Z/gc2q3CBHU+c5K+dfJrQH5U8h0zCCGCgjOIMEV3IybpSzc0+yIivBERveo9QoZKXu6AoD7t0gXDCvA4OAl29ofeuq8AXmygPI02nGSOin2ljxhL822yAiwPxATOzIs7nRjaHbLqf647zhLIOuabuPE4KFFIvcaComCJzOsp/BtqAORtaw3eiK03HZDMb3Saw++gJhVk8iLBb78gq4N6R949OxHn/ucwiqTj1e7P5yQ9Yzk1sjpPO2O2DgZTWXQcqA5bgfRYP7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97OqqOCITFT0NXp4yHE4ptspB1Y/TNtAXr6ayLGzfak=;
 b=B8PFKKd9Upsi3dYQgUj0lQQpp70rAmCmaUVGuSHHcEjttZcsTgKXFnYE+DEr3EIK7yy2J4MXFPmSPjazjh8VcxIRM+T71/E0Am7JJMbw0qlpKDYuODxdZASG1MJN22TWbaNKQpjl1EXX8y6j2Y2LFD8DiJ3H/jBrdn8APdCAAeS+z4xn/69KyMf/XbdvG+cImFx//mhm2DHuifbf2UbzYOKu5ZwDLa44tUUI6pMV1u9FiKIuMjcIWXj6n/Z06hdKHv9NR39q7KKE41Q8r5ui51bxgEEY9YB4UhdxDcDRnwmR/YT+7JYLO59/RFAXqOIZXG5oK9p6F5F3JR10eG3b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS0PR11MB7877.namprd11.prod.outlook.com (2603:10b6:8:f4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Tue, 12 May 2026 06:16:38 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 06:16:38 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Daiki Harada <daiky0325@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kohei Enju
	<kohei@enjuk.jp>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use
 napi_schedule_irqoff() instead of napi_schedule()
Thread-Index: AQHcwSMg/qakifTA80madtnLoVQrdLYKKH5g
Date: Tue, 12 May 2026 06:16:38 +0000
Message-ID: <IA1PR11MB62415F3CAADAD6B857B135E98B392@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260331103924.36422-1-daiky0325@gmail.com>
 <20260331103924.36422-2-daiky0325@gmail.com>
In-Reply-To: <20260331103924.36422-2-daiky0325@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS0PR11MB7877:EE_
x-ms-office365-filtering-correlation-id: 7aa66962-2261-4a5b-e0e4-08deafee06ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: mWZVz1/YurFvQ+uB6CTeyvYwo7dp9Mi1JWRxvQCBUcDYvBquvUj2QmIIXbAhymgXZ6w2Ty6qzK24ouLLS+UkY6DMI1GE9Bq23uM2eSjVZ9FCZUqAiOqHimlD9WvECHVh8UxUxEaUqnjykIyHPDma1+F/icGA1sOJlm/hR/8UxlQZZow3EWPxM0YAttdGoB9sf98TGxX0p8Gd/JIvTRgqGULu5fjoUuittlHxpRorc+HFOX5Q0v+FAqTQJBSHdjisio+dY+NU1aSgTxI7vPqxMY0iTbzwrSSQsx2MCamN4LG6drX316qvRCXKkfbcq0HkBEs++ADJQt9M3XRn0Fl4EJPySydjt69Qcx0BMEkvgBZ/v7zl/QL8GIFAL192SgBGuESfOoY13Qei3tpQz514J8DGXKqpKDUWxVuav234/dyxPYqlhDTT0ZtAV2udQAW7yXNID3MGrbo96jhaN5DjnZz9kCBGmqyFpVLp1lUIYbZj0eYx3inLyQTn1Tr3Ww6+fCuIgSC0eYG5AQOP4BG5yrHrTOib+8Yq1OS1h/d8uB16mIZZdlFCTY1fAaoaOOeHXZJOW5P0YgfqVX4aOdav/6r3+NVfp1MJ5BAkGQ6FyfrZjHbnKFApHl1pztN+AZSWP2TzIK+pRRB8XGQohvaY/em4bw1UmJtK3+yx7g5LYAqkm5Dw/5JT0SEp28pzKtzOoAw+Vq2KDRxoXzzSBl3EJDNYt6izlBBg/uzv9ZimZ5qN4omS9CwXiOHSw6F0tJrp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?INjajWYW4ytgo578vxndgsH2Te7bbIDnPYwqtSNfwVBXSmfTHtYSo5dRrAFW?=
 =?us-ascii?Q?OxK0WpWV0hqMwZjE2FYl860HlcbDfnfgeLDVQFOM83yW9GBcklOsVvTdZpeV?=
 =?us-ascii?Q?PUcQlVO4uPa4ADmIuqbZnLXBTUriL4mL6vdUrW7k5e23z11D0pi04+uqk3i2?=
 =?us-ascii?Q?/QhI4DcvT5rHpN9oLRCtv8iGVb2A6+Tmt2PfNwWniDQ6gKR5Qqz8/PyLvxYv?=
 =?us-ascii?Q?WhGz7BccemX86bQJ29VEhInXlQAPv9/oKg9f6zrMavGw3qNgAk63Oj3ZEHPY?=
 =?us-ascii?Q?DjyRoaqpbuz+I1r9ymrVjkH72FM/De6kAf+mLrDnPwtnGB6guDCVX0FXaLZy?=
 =?us-ascii?Q?HJJPb5gQUq6lmTq1JlsGSBt+5CBIy1Bu/2XjRGXR7wKKrShZ5EmO0FNayY/Q?=
 =?us-ascii?Q?mUwny6jWAgst+61FNXOcjlxrkyVZKTbDm96fO6etZDDEIT5BmUA4yQPsIDyc?=
 =?us-ascii?Q?pkYxZOzBDVIW36rm6dEljmtc5dYxVZ7EikyE2ty1eUP/YIvoRTtHjBbP1m9k?=
 =?us-ascii?Q?qy+HEELffSzzQ8jXu3Ish2QFCGrV5YtTnBQpVLj2fivjf8yK+ov8ltTAfRTo?=
 =?us-ascii?Q?fqVg//U7s+bsp6ZWoRTxTtpSOngxdrtanASzrrpdT/HnzLA8GzgYjM/p4vYl?=
 =?us-ascii?Q?b6TricghJAdw3gZx2y5vR5J8CEDcs7r6fUD18ZAEzAIUBZLYBHhJc6mBMTZ6?=
 =?us-ascii?Q?ue5zad5Zu/Vbr5VnhPssDp2CwkhAEjEXrfyk3cAwp8ilSYdQA+B83BWTultY?=
 =?us-ascii?Q?Juu+tP9rr2HLOKDUYtoLMfPUsRUicus8NRXkCoywPlfkvu691dwmThwwG691?=
 =?us-ascii?Q?XXu9YQ/iuXe7NHctKB7x7/SygC0RHjk9HGJP4LteO2JpsLmIMQoi9JflyoSq?=
 =?us-ascii?Q?q9aCDYC4oo2RKPa5T2UEfEN4JK2IT0XWJV9F3wCWUWSPyEA+sG9aBfIHnNeO?=
 =?us-ascii?Q?/n6hxilkq+asuGfB3PJjL3mHRVNb/cPjzt3rmL0SR1WSKZNx8BY88WE/sNAH?=
 =?us-ascii?Q?u/TbYKm6S4/qNYrLeStRnI9Z3pd8EY3rjS60sfn8TXYnTC4MqEspOvG+xnhK?=
 =?us-ascii?Q?gHKnUBco/vpV1cX9OD0qrBdjj0TkNyhj8eBKxug/uMByw9CtAO94Fa8t69Ke?=
 =?us-ascii?Q?0rLWcuABMKkxdv4Nvz8+ryAo9U5pXzd1ZmPZE1Qicfvc1ED/Rhj1aAhjnq/e?=
 =?us-ascii?Q?ZvYCVwjZvCgxl0HFMiPmxNKcjWHzj4V6QqFZD+/iFj/aaATL27npu1lpd6Tm?=
 =?us-ascii?Q?zCPN312IbzNNazV/Yb95H2e2zvXzAueCqNW3rWawvXPsbxVIpABV9wGT364f?=
 =?us-ascii?Q?4GQQQA4AJRU+ZT2abT5fZR3LKUUolKKm+sE9J0sgmCS9VCH6r7MdP1FX7FIp?=
 =?us-ascii?Q?lj27HOKxoekgzRpcwfL54Ir5weq6P+iq15w7zbpxlmbPblleqgspJoc4mpJW?=
 =?us-ascii?Q?Uj521d7ZeKjgldAAKVlAgCEpJSXulmYB8KO+rag7En1C/Qt+QVEXTh0AdpMm?=
 =?us-ascii?Q?FdAanM+OZL32xgsNgz62sCdgY4kMirSCX+D8m03fggiQbe/5fEI5sEHyy38z?=
 =?us-ascii?Q?c9h6nQitjq4w6RKsTjWfIsmykyIGDK/UYQnsdq34aCQTWhB0sbFTZOqox5AX?=
 =?us-ascii?Q?E/yndjkfXLh1OXXYTIglDol+hpKSU8DYH3pHspZzRxciFrT+zR2DtiHZ1BMI?=
 =?us-ascii?Q?dCPMlz0bfI+kq2gatuIcnZDDFKgdMty8BNFZQWruQVkX+cXG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mldMmp6HddFQvRrGKtmGNyVSe1l3EEovfIDPbR4u+TCWIsFAMWpwbKpnpV26uiS6oVzKxmIf5Utch57/cJT1P5G/a2yhvBh4kWDhjDae/AOB8/bZUEeTyZaM0OWtQGbHuKX0Vo1BdcOMarQk5yij7Y/CUk5FcPMbRYx54WhO4gTotxQq86pRqjgSLHhjRfFmC32w68dEElq7Bxmmw8s9IwV/6LDbtrxqbbPwU36oHZL4nmVhpP/WpHw2G3SbkqwnbAtEBLGmhIzs0WgTbnqg8nsksPs7uq2fO8u4sqlEZY2/hhBoKvNcK36xSXhskh8irOzTW56c5YZGibAotrBUlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa66962-2261-4a5b-e0e4-08deafee06ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 06:16:38.2541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8P+4Ru5815+RuVI8cs3g33aPehVP1YKJqmDcNXM2jDCR9GgbvNeeEdlo49Nrv+0gFPPAnKSQLOle2cVsnHylKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7877
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 66D1951AD3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286964-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,intel.com:email,intel.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
aiki Harada
> Sent: 31 March 2026 16:09
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Daiki Harada <d=
aiky0325@gmail.com>; Kohei Enju <kohei@enjuk.jp>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igb: use napi_schedule=
_irqoff() instead of napi_schedule()
>
> Replace napi_schedule() with napi_schedule_irqoff() in the interrupt hand=
ler path in igb driver
>
> Tested on QEMU with igb NIC emulation (-nic user,model=3Digb)
>
> Suggested-by: Kohei Enju <kohei@enjuk.jp>
> Signed-off-by: Daiki Harada <daiky0325@gmail.com>
> ---
> drivers/net/ethernet/intel/igb/igb_main.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

