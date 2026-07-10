Return-Path: <netdev+bounces-306492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1XDWOYzAUGo54gIAu9opvQ
	(envelope-from <netdev+bounces-306492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DBB73944B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:51:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IVbEhNuH;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306492-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306492-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83DEE302796C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11483F9277;
	Fri, 10 Jul 2026 09:46:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CA3DC4A4;
	Fri, 10 Jul 2026 09:46:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676818; cv=fail; b=OJEZlA+9DBVrngp2kz5Z83x4a4DhAAtC4DgjAOTBepo2Z8mXvyjQ9CI9nbDwtAOEqpYgS0xwOcmnHlGnWbTgcJDKo5jgs2e/fh4/m5AFzjYM21iI2x0HE6376Oss8Srpx+KjC6XfGdduyjeMCsXhww+tFdxpJB59mkaFiIWlG1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676818; c=relaxed/simple;
	bh=giac76IWZnKz6n+5fHE/5yeW0kcPc8wateuIit7Y6pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIUgl8QKckDbJRRuqAOOuO6pgk6J8MEtR4wWF7gAXC54bFw5YE9deXTH7iqoWGoVZJJ2bgJcx7sTh7XZVmPmM154YU02fFJNVf8i/OyDdyrP4V2yImWyVo/rzlkmaWs5EwECzAZFLEG5zTEorKnA4JJlsI0gdMUUu3Hr9o2+jmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVbEhNuH; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676817; x=1815212817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=giac76IWZnKz6n+5fHE/5yeW0kcPc8wateuIit7Y6pE=;
  b=IVbEhNuH5k5sw5+LRZKXOPyg0D6z4Kw8J2CgI46zDGS9xUaNtx0qHJeC
   YpQg9FceU3tyuKQQhr0TsVtsx1pCdb2F0hUvJpLCcq1KTJTBJhulnzGRB
   BkRL2GMO//IzCCV+eKAttLWnl5FTVQy768q93641dvXaC1J5qJpKjy7Zl
   XFe6O27qCMFaq9oDuhc30ye9Mn7/vYzYMHb8tnXGvQnN+pIfumso9Y+9S
   d1tpINZMsKWVSbfgmFppFCM6sO7/OqjmT97hVuR2qFG/sTUNxD1AP+tiy
   QxZhAHndN6pxSoODE57YdNGnVdV0zP2RNfvoF+a3369CrITiNHqnVVcIH
   A==;
X-CSE-ConnectionGUID: 6ePuk0AaQrCAozUtWD5u1w==
X-CSE-MsgGUID: bO9fpCQxQqquRoXHGPZB+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84565610"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84565610"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:46:57 -0700
X-CSE-ConnectionGUID: FdOMsiO0SMih1/n0LEm0jw==
X-CSE-MsgGUID: +M1ifHIPS4+c7FFP4uslHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255495729"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:46:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:46:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 02:46:56 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 02:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/26HlMjwzGtlD/ic/6lb+nEztqpL9kQe+Ha+Dn9lEWzigwu9tKLnNsp2+KSNp3ByG2xxXm0QqkFs6i1c8Liy+C6mMdF1Pd5l9qe77vbXVr6WdZa61F984aDfdAewsjdHJEeQYTwGlPdqgAuAuHd7acD4jafgnmD+MnmTjivxIEXyff17AT2KcT30u8copdjXsrKFTuMTB3vNbbprhHRypiX5u1uMTbFEVV+5aZFJOoSMCeWUazvueECWJghv1EuYQQEYyG+mg4aNbrLVOMOnzg1VR2BpDL5ieRvLObKRyxMwLnSb3Tocm2k22JmR7GI2XIISgA4wnoHjPt9o4M/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZgJ3xjbZJQG/hppkqGNDSynMOBIDF5jDBY4DScVkRs=;
 b=o1mR9IHzvlztK8OxeGOKwweHSl8A0U5nBsWj1ef85UHojWXYtHFuA6GnZ9Alo9qn2npabHv66Hqn7BPMHPkPUB0e7dC0Hd+1V6NsnF27KNE+e8562f12SfywXqG+j/6krGJjOTM9xFZ3yZFkyE911JRgq2RVJ6bB8d3DFCm4dFjhqD+F8vB5WyxOQaaUkQ1D9S4Lb4sMWt3R59fnr60ZLs86BMHUmqqfCcudEnuba7WK7aVPPiXOBuGyVftto57RscxarVXVA16MV0w1UjttjBE7Y+Y9nfZS2DAi4/3gRu9Ev88Wom/16FmSdQVRSpp58Lqu0gsCsdLP9L15XbIA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by LV3PR11MB8676.namprd11.prod.outlook.com (2603:10b6:408:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 09:46:53 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 09:46:52 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Harshaka Narayana <harshaka.narayana@broadcom.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"guolin.yang@broadcom.com" <guolin.yang@broadcom.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ronak.doshi@broadcom.com" <ronak.doshi@broadcom.com>,
	"sankararaman.jayaraman@broadcom.com" <sankararaman.jayaraman@broadcom.com>
Subject: RE: [PATCH net v2] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
Thread-Topic: [PATCH net v2] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for
 Geneve packets
Thread-Index: AQHdD97yq1dBV2m9vk6AHJtlqZeQ7LZmgaLw
Date: Fri, 10 Jul 2026 09:46:52 +0000
Message-ID: <PH0PR11MB59029F0AAB15737D10DBEE07F0FD2@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
 <20260709194703.3678075-1-harshaka.narayana@broadcom.com>
In-Reply-To: <20260709194703.3678075-1-harshaka.narayana@broadcom.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|LV3PR11MB8676:EE_
x-ms-office365-filtering-correlation-id: d1607676-9f40-4c4d-9528-08dede682ba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|7416014|38070700021|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info: 0zraOzTHJU6LMoUCtuk1qWRGwWlZdJzgUrj3kxjw6f8PX7NqRFIihyWgvhYpzxwAXXZTYxNj9h9Mv4hg/6yiFWdmZyrZ0ziGQ3y0n3Ho+e6/OLOZz3AHvN3kelludt/bwgx/CeQ2tAz5JhfoFJ4PnCB4vE8T8m7XJZ5e/A8X7+v2Qlj92xUgmUkr8k6/SUFQhxLmKS4lgv4xfjuh2DHc3U/6/86e4s9Ttt8oJ2zfK9L5g+jKg64KOyNw5abw5JFRY2bJvV4IEGCx9Lssgb2zyJTjVB6wgsBuSRe03cYToYdscWa7yiOY1IZfVbOsq8LT6rBc4Jeefbh+7omWES5ZFvTZuKHabmz7Ibz/y4qSxi68mcaoQe/sheizuizEtWCRppG3Kb/w3oBQEeU1KgEJ4iiABrR/qEFIoxADOayPwpup5lIhx/kazgORkGnZj72Ece1pKYEeO2NGzgjDSlqH7SrKTZ14aXoKC3IJaZVLyUPrM6YRtjrtuZYaq7h/OpnHg+QKjEHTEJFFfiNWt+loyJ0O+DeuLg/zWpIg+22UibWTIMoQReBhIKvnNpQbJuKqgR9qljoiyCytTg+SHbhnrIyVvx+nQ0AjhXh2CdoTriZ4ERWd2pzGzvS1oPnZxAkx+O7cv5Pkoe6sHtDHoA4E1kz0S81oC1qTrwFBmScUNoK+Q90zph1mz3124DTAOg8731yqBp2eD+n0/lxccWHnbd1GgjseWvyFs8zUh5VcI58=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cfHb1TyvNTUsQdnqE7ax1AxrDvU7YBPSswAtc8DL4lji4xJYImTUnytR4Uj9?=
 =?us-ascii?Q?+08CWJt5eA7U4khZb3+kcRR8rkXdkFGi7L2bfYa7h6cPDeq/XhQ56P+nIFiC?=
 =?us-ascii?Q?MlPxEl2VrW2l/gHvgbetDwh/hzY3a4RAH5hWpaebzc5Y9Fm5t+kNsfvHmMxY?=
 =?us-ascii?Q?z2CizdlozyJ+GaunNa3zxkvbLtG3OOkVd/cpz2G+oI50gIidDv9yHEHsOjXy?=
 =?us-ascii?Q?QTahN7EcRfJhtLYDFeoJK6799DTrKjHQJKGFYJZ73LO8qN1OhASKLn4PMBd0?=
 =?us-ascii?Q?y6Sr8DX1m9O0GqFr4vFs81aIWVJ7ksh+LCsBqsXUvyKJDmUfjyEyyDG3cGQI?=
 =?us-ascii?Q?Pa93jGf+Eiin3j2F6sHBoa0W9QPEP0k9Yu3ysvb37/DRW++UaE09RoI5+Htb?=
 =?us-ascii?Q?656ZHVBMFNY4P5AHOsKGpR/QCOV8BWfadfIin1cAffM887TraXR63vbyIzYY?=
 =?us-ascii?Q?XjDfeZpPYM78XkLOyXBPH6M5HVTLcBt6neDBrGHjI0xEO2Stmyc5o70e3SlV?=
 =?us-ascii?Q?iSSkUpKyXKwDlGlDGweG9kYlz4T0qR89dm3UioCE4w2un85T5pIAuyIXjoGe?=
 =?us-ascii?Q?BSRseI6EDJf/UimkDOKJicWM133RZI3IAdx3QNLq4//uZHjSx26ZFFTrx9zY?=
 =?us-ascii?Q?1KgFWwyHD/AZCjZIDJYhaniW0ZfbW/jF/wtrE/HCf3/kZADJlBvaFkvEqMq3?=
 =?us-ascii?Q?+JgGVO2J0PbLEHAqslELiByRQUfRhrWi7ZpJZ2/mcPs+d4O+vhuq4cgh3m8r?=
 =?us-ascii?Q?sI2x/sA/LvT0cJNsab+voOXUEPhJVbIja8BQVo53kwnFcnEdBlD9BDpQ5LSG?=
 =?us-ascii?Q?G0uWTveQtixlv15gzHI4h5GjXD1nQfROFJO27Nu5p4UQRjxUFiGbn6VaxSSO?=
 =?us-ascii?Q?RGdSULfv2Vcvzs+UEWwFBZD8lcdjdvA4MUPWnKyst7TbifhKih0abxYc2gbX?=
 =?us-ascii?Q?cTqWCvQn6rFg3XUwfvdI/Er3dYPNF2iLCgcOBlfEBYOcvxkVEmotu3Mo37bX?=
 =?us-ascii?Q?Twyuyf5J4XVAdUTP3G+75CcfljfQ5mgfIRoLenYKuLq39dQ2B0MWC6guVqY8?=
 =?us-ascii?Q?9Ysxa5+euwojqFQDR+B38Hm08FR80ktKepaTzZVzrMZm5QACYhR+ADKH06k2?=
 =?us-ascii?Q?7vIPsh7KgiXmcSCDP7rwrpl6PX/MXzbqdiHqFNJEQu6fk4k8IEmwHqv1IQT6?=
 =?us-ascii?Q?oR/OenKGdH7Ah195K65ZCMBBvGLYjiEvh/6EiR6ZjtvtCz1xLzD5tOBMsTil?=
 =?us-ascii?Q?NTlE1S4A7OTDjEytEB1QIQXiSPyZGVKFVb/egGFor/hXl7raZcNFE6uMBuFb?=
 =?us-ascii?Q?+ZEpfj+h8/sj7Pq81wiQWNclgQJZ4/XIKECnlrammfrjmAfzs7TbSES4ENdq?=
 =?us-ascii?Q?TAcbu7iRTRt2InKfGEeGy1bw6LFEuf0h13fuAMi9jg1sdl7yog/qHxdRdxNX?=
 =?us-ascii?Q?oyoK5eo8SBjeY9lc1dDLG5q1S71L8GVBdG6YPeTLjM31h8Uxe3YYX8BDyFln?=
 =?us-ascii?Q?F+5nROaNqfMgF6bqBz7dHLbmohccIoeJ8pil1hGAbVTWw8eAiR0i0Ktg2tUl?=
 =?us-ascii?Q?En6vZRLV1GyYHSeOJtH6ElC5/TGr9Ygr3zskwARC1KllpFLVun6f4rZWhaev?=
 =?us-ascii?Q?4JR/65fOUb5hn914Ye85k5n5+iCns4V92mIqkFA9sC6ExkXsleHTcijUJXq4?=
 =?us-ascii?Q?l1mbdHBbsF2lNcMmd7omkCiKdDlV85T5juY0oynUYn7Jj3BxRlO8/NGuR0TT?=
 =?us-ascii?Q?clAAEuLlYQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DJ+KrPygmjnAuflOM3X0zqwmWfWjvUBS2Ignw6Y/+NJ6bO7oXexaJeNT1wEdfgoxrus3+3qbsOJnzF2UY0CG7PYU2K+CKkvS+qZ4I3JLT4PaUa4HLJnEVHtm5lPs5/9Bl9fkVVLJC/KhJLKMhdkG6I8TabJzc6WSTShNN/8O61qx+7YjWK1A9dnOGTxF6h08ANOXqIBCMvrxYU8E28aa8IoWsKSR6eXFjNJdOd108KQvKWR3+OWr8U9EMzMLQn0emk91dKg9xKE3o1Ut0ADH3RQXWAg7UpNGoCs2FZ6PsjarpY5G+daBseJVdbfa3135RCzi+cUueq7n2QgYyheLSg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1607676-9f40-4c4d-9528-08dede682ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 09:46:52.3187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGbpoyGWL2n24zCLzfo3dj4zwS+eMQrk6ECuvwkqX0UGO1zhCfy/cs9L7/70sYs+3IX3AASdNmF40DB56oKbRcz8HwP/4E9AWc4mRaaJtec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8676
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306492-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:harshaka.narayana@broadcom.com,m:andrew+netdev@lunn.ch,m:bcm-kernel-feedback-list@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:guolin.yang@broadcom.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ronak.doshi@broadcom.com,m:sankararaman.jayaraman@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:dkim,vger.kernel.org:from_smtp,broadcom.com:email,PH0PR11MB5902.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37DBB73944B

From: Harshaka Narayana <harshaka.narayana@broadcom.com>=20
Sent: Thursday, July 9, 2026 9:47 PM

>vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
>outer header, but for a Geneve-encapsulated packet the device can set
>them based on the inner header instead, signalled by the
>VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
>function never skips the outer encapsulation, this mismatch triggers:
>
>- BUG_ON(hdr.ipv4->protocol !=3D IPPROTO_TCP), because the outer
>  protocol is UDP (Geneve), not TCP.
>- BUG_ON(hdr.eth->h_proto !=3D ...), when the tunnel's outer and inner
>  IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).
>
>Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
>function cannot locate the inner header it would need to parse. Also
>convert the remaining BUG_ON()s in this function to return 0
>defensively.
>
>Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)=
")
>Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
>Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
>Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com=
>
>---
>v2:
>  - Check VMXNET3_RCD_HDR_INNER_SHIFT up front to catch the Geneve
>    inner-header case directly, and convert the remaining
>    BUG_ON(hdr.eth->h_proto !=3D ...) checks to return 0
>  - Reworded commit message to describe the root cause via
>    VMXNET3_RCD_HDR_INNER_SHIFT
>v1: https://lore.kernel.org/netdev/20260707165248.1859188-1-harshaka.naray=
ana@broadcom.com/
>---

now i see that i replayed on v1 but v2 is already there

when sending patches to netdev the rule is to wait at least
24h between submit ions - please be aware

