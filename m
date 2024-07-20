Return-Path: <netdev+bounces-112281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE16937FE5
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 10:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD3B1C20C3B
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC862207A;
	Sat, 20 Jul 2024 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPXBQXmV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0A22F14;
	Sat, 20 Jul 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721462525; cv=fail; b=Xk0jplhX12ACauDdcr0QsWLGINbN/wUUesb8AWhLeKxA0VBUdrMn1maXO0XrpsvZPHPktGyPoLhVFrFcIm99tmN4o7KzyM56SZuqwhjL4Qh29sA005FPKEJ67hUNMPI9ZAJ/txOYX/DO5XrsiANZRmn3zu1DkFkw1DvSbv1Cz6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721462525; c=relaxed/simple;
	bh=KwEGVdclA3wVbiAvBUooW0OWq8X8pxtJWfwEP27j+Ag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ESapMYCJhJhC8Z/hx9Te5Yx6hlL/iCS8kMAWoBg4lfNPyz3s8XyBSfXvDtJ4mUKBqotIS/31xP6dvpJGobFywqIkyksifbgHEsUYKsQc2ZCyHEWsaWoyxcRFGI+CFJwa1xurIO/XYZ4GGAi4pp2OaFBWpbZcMdPhlj47F5j2e3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPXBQXmV; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721462522; x=1752998522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KwEGVdclA3wVbiAvBUooW0OWq8X8pxtJWfwEP27j+Ag=;
  b=LPXBQXmVURAWWeg/6Fq5icsbo8wnn7sgN/xu1gVy1Zhd4WrGD62ER6Bc
   FWtR+Vrb/vE+3r12CvII7n2cXbGJJvO8y8kr20+Sf7r30wabJ/oLPm21K
   prSKuROiG0dHVncfXwWMOXlQ0RPY/wBHE4LqdvBd06WdxoHBBWFOwseZf
   aicOeSFWkI9HKV6njMkW3HZmUo5sGEAgUDmMnX9d1LGmwjFKHU/DkeJt2
   qxaTvw3iIbDyJWnQOHtecOLaKzDIeS6zhtSy9a5roAIXBNzZaedUSsbaC
   IaHMxNT2KlOywab8DyKZLAsP5KFXgL2aH7yLk8YzrKdi1ISozGHcghFGj
   Q==;
X-CSE-ConnectionGUID: D5rrf76IQ7CezV4Q7udMiA==
X-CSE-MsgGUID: ItICf4o+TiyMpa48AjkD2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="22899192"
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="22899192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 01:02:02 -0700
X-CSE-ConnectionGUID: xJZOdx4VQMu7hLTQ0TSJdg==
X-CSE-MsgGUID: v2VvHlk7RZO7u4istg4FZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,223,1716274800"; 
   d="scan'208";a="51418280"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jul 2024 01:02:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 20 Jul 2024 01:02:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 20 Jul 2024 01:02:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 01:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQ6bfvYhUXEK3YrR0Q/93RNlqU6EZUo9oJh/h+mRNX+pOxoSxqciSj80hDJQ5ZGz79zo6apF1GWuiW9KOlAI75D6L2VOvG7cPS5bgsbf50404vDfyaqktOuo9gbfAnmWapd3JDaLfYD3I2O0KvvRgCHFqFz9iOMO3I7+xc4aO9+Gb7v9BdKj7KaJ/ejVu7aOwWIR6arPje86VTzES/EfBQN6Ln4VCyR5aN0k7SRbwMskTQja4YQsoOWbygtZIk0lTZ+It2SNo5HbjHFFUympdEX3KP7SFShRkclOuDyonGXX3h8SUeAP/KQu55BGOJxSyqKjOoZRwisvgDpGctWOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkjUf6249kuWBwrlbHdLfhziTzl6sBT/A3jUmbrCQwo=;
 b=ZjepvfPhbsNN6TRQond0oMPYMMJw63z9YXwjGE7aALfbbg3aBTxEkadB/PBPgalxKesSOvgog3mPUZosrEeHnO5US/uF9ZoAe1neB7unIsWijugRU5IlM9np1B1X1BDSGC82752ruCqUJzMF0zqzAqdN60jvya2qEzNq55gbJdgkV3O7nzeCEr+ywA8t7r9FfUHjvyl4yzok3fvP0O5/rzEPjMZ5dOWrYZM2gwwIGvpAezOKa+6CoG8Wf8XVT1K0DicXWWLSlEoPQy3DaZHRy9Zej/AKyC4OvLbv2soscDsy1dvZhhS5X3lcML9g6ZCYMZxwFVB1Cy3X/tQ0WE5oeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB8092.namprd11.prod.outlook.com (2603:10b6:8:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 08:01:54 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 08:01:54 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Aleksandr Mishin <amishin@t-argos.ru>, Anirudh Venkataramanan
	<anirudh.venkataramanan@intel.com>
CC: "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4] ice: Adjust over allocation
 of memory in ice_sched_add_root_node() and ice_sched_add_node()
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4] ice: Adjust over
 allocation of memory in ice_sched_add_root_node() and ice_sched_add_node()
Thread-Index: AQHa0sa8i6uX/YsfH02UmtprG5Oz07H/T1ug
Date: Sat, 20 Jul 2024 08:01:54 +0000
Message-ID: <CYYPR11MB8429AE0FF075C4BCA5CE1C15BDAE2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240710123949.9265-1-amishin@t-argos.ru>
In-Reply-To: <20240710123949.9265-1-amishin@t-argos.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB8092:EE_
x-ms-office365-filtering-correlation-id: 6f492d48-24c6-4b6b-7094-08dca892384c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0ruBMRXT2KwVqYbW/ch7SEbCAOJWbZSR8AqU4Mm+TEoJAmEZw33BPZv5rfRP?=
 =?us-ascii?Q?AFCnTL+kSPsYWSAlFwJg2VqySoiv9q2+I9oX5+1MZlOhcF5ONOU8xXTsGI5q?=
 =?us-ascii?Q?uM5H6uPb7Fnyf5z/0M+FKDQ0fqiLiOwMSy20SwjUWgxxikZREQZNIyCVPzHQ?=
 =?us-ascii?Q?dnU1Sg5E2fIoRz99qPYwECRfenNXCFC6pdWMnaeUfwcgCGx5486dUMSg6vxs?=
 =?us-ascii?Q?r3FW6H7oVWdVgZhOMq7akHNStyAJRHpOxjdm58Lm6N3qBc1gN/ZkaEJ66cdY?=
 =?us-ascii?Q?xONYQzkDEyPY1O9kE/nR3cCZwNlg58LUazntu8yARiMN7rGWflCK0dujsDvC?=
 =?us-ascii?Q?VR7PPYnprld4if/zDd25CNZ0PLhdqdRyUElHGR6nNfBDfOdoeDwtTqflV/zj?=
 =?us-ascii?Q?R66ANLFhuy8F4G9ZaGRqreXuuzsMC9r4VGYPiN/NIyl8CCP4e00GXjgME4Iu?=
 =?us-ascii?Q?4wTfXAPK738Icu1SZ/dRaK0AhFZidnXuLEvlPOrzeWRS9clPbo944hU4GSqy?=
 =?us-ascii?Q?TogaQBkUf3eye+lcIm4q+OkduXuVvOoBcqJHqmy0i7AtSLCJktjT6MPJg+pk?=
 =?us-ascii?Q?8geMJbwYWSIsDAtRIO4C6NYjqOkxLsRNdICirWCuL6orDBpVburure2C+a3t?=
 =?us-ascii?Q?3BwjaKnwNvobF0XrfvWpGuAGK6q5nkcfKI3zWRu+BjSyxKcCgXv195fqdr81?=
 =?us-ascii?Q?He0Xdp9Ut9CGl9MQH3sFF6LtFcQLuDEHEpFEpoQhxYW7MCHkF1JuMtHX1N5s?=
 =?us-ascii?Q?PCVKRBglIIJUQn3IMEsTgfnR6ckxxhDfT37K4wbSK1H5LwaZQh3N7udJhre9?=
 =?us-ascii?Q?I9iW3kjYhu9I/9yr2l67Gsu+yjr+6QxiWVOV2jx2U3GCdrvQeQ7WrGh10NCz?=
 =?us-ascii?Q?jHuRp7j+NbZQvRn5+1PwOp9Rks8ggwDuKsBnO+Zq2C6WrlMkf4K+vwyhPNUu?=
 =?us-ascii?Q?PYAXrCA/vFd4InP8tX3umboexsnwtHVBkEzkpH3zfcQTGspN5aVie7yvPW1M?=
 =?us-ascii?Q?g9a2UX1M70z8gXU5I+TOs2nNPzOEtVl1VNEgMBc2TProbuDqDvyc+fV+cYGg?=
 =?us-ascii?Q?9v5RiA0z+QA8s7ohOmmESeOQZH+/H2yFh+Pz9te0EReVFXeAPjiHgRtJWZQW?=
 =?us-ascii?Q?IGbB57KIBcjUgjEUqBiBxSjoO9ZCmjTalPfVwErksxsnp8iQDQTfJxzpOL3H?=
 =?us-ascii?Q?BSXeouBozot5N7oQUsyeRNgSBEC6+nZsXiEk4iuxnFhverY3wD9qgD0XYDYD?=
 =?us-ascii?Q?fSLkJsSY7M0+a7QiWZDDhYivqNbWAlMEgSla2ZKo1ynwhKlgqM6xP/IUtzF7?=
 =?us-ascii?Q?U3LluU0+NfZzss8TfwhzgCELB4SHARDxXyNX8WPrHSjZac7GnIB6N/6SBhCy?=
 =?us-ascii?Q?puUOh8g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4mChf5IDOQvvKHPMy73/OI69KXaGIt5Lsf+1C3JdEBkoYBue+mFF6J1s43JI?=
 =?us-ascii?Q?jDJZIt6hXM/Pm7Uv52bAAtqiPnss9fHKQElX8vs2lcgQe2Leggw3/fGL9BZO?=
 =?us-ascii?Q?SFA4H8wXLrLMF+HHIZkT3x8SQdhG54tlz8+oc5GgrBBUsoLSX3/qwOK8pFZj?=
 =?us-ascii?Q?zulzXPMmlcuDTFvtN8ZHPuy/tlESb1Nw9hIvRFoeLZfcgiClV7c/sNeFnWNU?=
 =?us-ascii?Q?GWFY+DE2xTwsf4xWFJivCCSXjlhs7T5VFbVxixKjO1jV9h0PRuX4KfJMIwEt?=
 =?us-ascii?Q?F79AVoGlhbPTJNgDb+OZK9sWYcy5gWwtqXg/+swFjVGWEhRs9tOEO6IrlC0/?=
 =?us-ascii?Q?XtFY207oYrZA4p+Dma/9XJ8IfRFvA/rOeTg2rqyKg8AkpfoE2iMBc0grl3e6?=
 =?us-ascii?Q?l8q6rOo5wU7GeO/V5r/XyOQrW42Mc+h6v2ldTWUECX3X1s9yJIzINYgVc0Pr?=
 =?us-ascii?Q?gsA/yrgtHgaW17dy8EHdoZsE8Pa0pm9le12n+tgcrb69/S6dIb5aCY6x/Arh?=
 =?us-ascii?Q?iTnDpup0kerr+w6mUSC72rr/RVmaSie5JGiODWtA6knc3PPU/mmiJzKWdRb6?=
 =?us-ascii?Q?wQ4y7riGwQlyYZNFyBcQmu2JXS8ECUS5Z9vSv0dB0mGjfp4gooEztSBLs7vH?=
 =?us-ascii?Q?jqRToK19j/I5PGrltY6ibyWjQH1KTJbTlCsOM81bnhcadHfKxF7moUE0V96A?=
 =?us-ascii?Q?nuuWXshfAiPj+BUL9rDr9a1berjku+gMUT61JEUnnltKIbMkGNNfNH3qG6eF?=
 =?us-ascii?Q?QgNgyg9m5FO+Og1GjTorGyhW1BMAdOH14ltZxjNVCEi2+3dMT5hyBrVE2auY?=
 =?us-ascii?Q?KfMr6iPmeLEotoC3pyClcv/dUiSdE1E8XWngd1UQpfddp9w8hRzXzrBYH43X?=
 =?us-ascii?Q?cZut5srVRFXs60L3JVZo0Y0qe5AISXYbgnsGFl1AO9jq567YsqYiBi8SSzTT?=
 =?us-ascii?Q?NI5SqEZk0skx5IJ4JXqp8KjNM50rGRAEshOLX+ulS0WxgsF+5is9Rs7Ivfva?=
 =?us-ascii?Q?TO006wUsEjw357xezrM8LYFmLSrcArBV8yB1sON6C8Z86iJj50RG1kD0kigl?=
 =?us-ascii?Q?b/stviGE4762IGwyN1Dpa37OgRJrF8dCw5gWoPawYyaPdKEvH7qSELIHYw/v?=
 =?us-ascii?Q?bxgHu7E/Ce6Io+OXGP1l6rMcTXvWkpB+9YOMBCBQAcXmUuJYmTbkSuaZaXxG?=
 =?us-ascii?Q?RObcjI/FYUOwaT15zQ4wrjXOgXapX/Lrt3wHLBOSO97RewyaxB1NNMKub8Ui?=
 =?us-ascii?Q?fi+SevQuHfTx2E2IHR4t4FPWlCZnWoeseazsOjg2O7mja4mPOKiTVR4guHGm?=
 =?us-ascii?Q?ZnsBvIRjvKLlVEa/VMIFdac8WWLQB8aWskID9wwOGEaEtPOirS+Y5cLQcyMs?=
 =?us-ascii?Q?R4M4tueTTEmJi0Sctc6bIqOm6NA3iTSG3gPrZSAVDnZkZNOfJzR8Dy/Fgu/d?=
 =?us-ascii?Q?JBur8tkplXibKoSmRlGajgEeq1Qkuxpi0ImeZjevC0mgsEbmOewA/u7b+26s?=
 =?us-ascii?Q?XAhK7MmS5TtoD1fXF9BlFFoa5qP5J1pGa92xw3nKGwT2yfOoLLcOB5rXspI8?=
 =?us-ascii?Q?f8PG4XAR+sX4VtX7UUf7mXJkRI9B3tFyyFyIQAhYfb3XIgUIXb/KGmN9+ysf?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f492d48-24c6-4b6b-7094-08dca892384c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2024 08:01:54.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syYLADc425Koz/59WoK4s426C4V4a7AuPLVO61ELko7z038TdUrMUruH4OLtsNvu9jQXRSWhzm8xYm0YztrOhxB9Dc7SCnIOvbjSR+sHAzRm/VqjQtDYCa1a4JSKZTQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8092
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Mishin
> Sent: Wednesday, July 10, 2024 6:10 PM
> To: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> Cc: lvc-project@linuxtesting.org; intel-wired-lan@lists.osuosl.org; linux=
-kernel@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>=
; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony.l.nguyen@i=
ntel.com>; Aleksandr Mishin <amishin@t-argos.ru>; netdev@vger.kernel.org; J=
akub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. =
Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net-next v4] ice: Adjust over allocatio=
n of memory in ice_sched_add_root_node() and ice_sched_add_node()
>
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to 'ice_=
sched_node' structure. But incorrect types are used as sizeof() arguments i=
n these calls (structures instead of pointers) which leads to over allocati=
on of memory.
>
> Adjust over allocation of memory by correcting types in devm_kcalloc()
> sizeof() arguments.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v4:
>   - Remove Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>   - Add Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>     (https://lore.kernel.org/all/6d8ac0cf-b954-4c12-8b5b-e172c850e529@int=
el.com/)
> v3: https://lore.kernel.org/all/20240708182736.8514-1-amishin@t-argos.ru/
>   - Update comment and use the correct entities as suggested by Przemek
> v2: https://lore.kernel.org/all/20240706140518.9214-1-amishin@t-argos.ru/
>   - Update comment, remove 'Fixes' tag and change the tree from 'net' to
>     'net-next' as suggested by Simon
>     (https://lore.kernel.org/all/20240706095258.GB1481495@kernel.org/)
> v1: https://lore.kernel.org/all/20240705163620.12429-1-amishin@t-argos.ru=
/
>
>  drivers/net/ethernet/intel/ice/ice_sched.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


