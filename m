Return-Path: <netdev+bounces-305475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eL2fIy4ETWohtgEAu9opvQ
	(envelope-from <netdev+bounces-305475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:50:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAC71C1EE
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:50:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DUWWY4W7;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305475-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305475-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CDB31DA29B
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01C41F7DE;
	Tue,  7 Jul 2026 13:38:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFC41A798
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:38:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431497; cv=fail; b=EaQbhXObamwrOdBKEYooNDJ9VAyNbQ2azPjDoGiC1+WpwFhegEXSwm3x9YUSs3oXM8XeVbZgRXe8QAqhmru7xLqeVs1VwX58dYsycOphSk+PcC3hgQJOvDcIblv+Bku+/XNe0VnlyIera6lYr6xp9Rca9xXfGyEuP0xBolgVmXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431497; c=relaxed/simple;
	bh=kzgIZr/WAEi67YIxaPBtK6i9rMqjwI/bTenE7OxjaEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gIiEmc50zrjzOodFFKNEatRK25W+Javj2neUndI4bXWlXgzoBm5nsJg8IJ2HvUbovO/tF/NUl28Bd6otE+ZsYwnRxFrcoauLC1OzWNu8Ck1FkkI7k4NRgb05w9xLk00OOAnj/6gX9sZZF2oy3xFnbZdWmkeMywLF58fVC67eSAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUWWY4W7; arc=fail smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783431496; x=1814967496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kzgIZr/WAEi67YIxaPBtK6i9rMqjwI/bTenE7OxjaEM=;
  b=DUWWY4W7GOVt8n2vHXVA85vDFuso8HGN4Z7xGiAGxNbP7hLcZHRDMUxE
   ICPuoDrTAUCRv3toWcY61YoDJRCazSezd/xHAIYtt5qdKnH1Y0AJg4BSO
   DRccOVznBkmGzUqZ0bPsscUcSxLg1DrpCazYAt3j86RhxqxbuQ8I5M+cO
   baHJ+Ua1VPvCffVEzmfkDfF8hswiAXimVVfWJ9mi+pgJeHt+rPKqptalw
   bskn/+qutLov295rkbzdD1QthgZ18Xm6ty8z4x4rdJ2A8BXQjDB0soxge
   V992IcecNs/ItWzvjlcTwvtjhpagqShKZJfE8qyCdgxE/9XT4wZgMG/ne
   g==;
X-CSE-ConnectionGUID: 7S0Bfrj6QaeL6UK+RbBcvw==
X-CSE-MsgGUID: 8+g/x3s8Tne6n06eTkJkBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83054380"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83054380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:38:15 -0700
X-CSE-ConnectionGUID: KrEyyGxKTRSKwC9AaksaCw==
X-CSE-MsgGUID: msPSzytYSHW+aqv2bGZtfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="251328812"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 06:38:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:38:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 06:38:14 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 06:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOdvpTO/0TMEPZCqBR3ql8OkwabwFrd0OEPLYlP9lCPAJgYjaPnLXuh316XAQ3d49kOHEwoJyXXqCaQX6z6refhR2MhAidNntUvaKMIeWf1mwBYFjKPbyFo2Fx65/GReOXCjdsIF2uczl/kjLJxW7fWT+MkAJ39ExDN0/s4XOa11QvQZgpEfabpVLoTFwTXXCqtqnNn+L8ZWRhdkDsc71Ij7CDmw6eGQkk9assMiM0yNJpraO1CqukosdLPAw6LUsU2PqHgs43sYMQ7QG1jnDwZC8i6CTPz+N/tBfGQg5tLbAvrH99dVFD4rjHWDAVh0d5SUeyo7ZmnsFH1HSeG1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYPEOzs8flc4mQ0p6kUDLqqpWLts/IGWmTUpu0C4feo=;
 b=a2L1InOL6/SSyNpLHHyPvQ5Jq3UXz4jTXjeOrsPDcRQiPdfDFL5dsiqsHf0oAJd6aB1/uJIkTJLhEAe2rK58X4cEHl5jiKlc9NX9DXBp88ETcp4CC5XOiThaSNvgxdvF24MeiFYTtbHDAlgnDlDpzm9k6ulFLm/DgUFktL3X+rzHtno4AZv+RVAtkNrfAiZWmGScuy16YGCsXYEbXMsWhq/3/aeCe5vx/z2rQGW2Yti2wyUtxUosGp5mwr44mQwGSFg7jEz/bH76qOewubNsb6nbviMf3jXVNWTDWugmOW9cae7GVAtbyrs6L4PIicY2JelzT/AV+hwA9Z4Ye8zQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:38:11 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 13:38:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when
 calling unregister_netdev()
Thread-Topic: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock when
 calling unregister_netdev()
Thread-Index: AQHdCVeXaTJG03bsDUaC0DdJQ7Vec7ZiGPMQ
Date: Tue, 7 Jul 2026 13:38:11 +0000
Message-ID: <IA3PR11MB89866DCF1D30B76369A15E6FE5F02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260701124524.13644-1-maciej.fijalkowski@intel.com>
 <20260701124524.13644-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20260701124524.13644-5-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS0PR11MB7804:EE_
x-ms-office365-filtering-correlation-id: 3f36f8ac-a511-4516-4f68-08dedc2cfd2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|22082099003|4143699003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: ouE4pgFqHh3Pxb5kAggicbyPXojVhvSHDIvjvMy+CXh4Oa8kTkZ3YoMFNec05mEBmK+uSh/U34MLxu2Tg7afkqwgSwGk2nq8ynaqtJ6Ff1p9RJAb33mRh4nMZk7r54vDfvTeG5hpnmdPpOFFi88UJSpffBfz5+KcX9OUVsvb9uSB4/SZ5dpbMB/YWjur7rsTpRBSviq3Wkbwvz3LHiXduMyOXss1uZp3cOjmFRGe/cqozGllfIQSP1T3wQM6OH9CcV2h7iXWtQYE4QqGb7G5D/DJr0ON4o1UZcIw74Cf6pMx0KRewX8+b1ol+0DaMdAqq20YnSNzZBRCXfp133wRHb+KiofkWsAzexexCoy4gF7JtplSxGcyVM77elElLXPRaOkieDz3y0Z8oc2xkaJN8k+mrrqDciHsTiWSylmDd/7xv8FMCcYEc1Ysn6MmOPuNYWZKMI2+rEArBNhmHmcijOT3xGA201TZRIgwTZUOQhXls50JBsAHyC2kYR/sFHFvAeGj9J30XcEbefcMTfkonjO6dEdLNBk0IM+yCYtoeopU/TFc9/lvzskBWol5+xT1NZyJ9XOz42qTdJl6LpTEQRJJ5XvEjlbHMe8n4xh0Jc4UayeYMeASu05d+C+ZlE5Lkcl22nbH1gZcsecCFnCnbHaCxh20shQgLa7xQQ0xYHcoefJrNWItFWVb5VaU2yBdsx5YOTn49LcPhUEUTG2ZHqKOgmNzX1fxD+dFprZofGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UWNWkb/WHXfaC0bTrEn2y0rpEW+OuCbYCOf9Ez3ZCcTbLu//oRfRirVGkA7L?=
 =?us-ascii?Q?jvBF1CzPXxmQd+53tGhezkaMzJecABZcvo4zQFao1pf1m8loyL471H/k8NFp?=
 =?us-ascii?Q?69TvgkaxDUJsQ878xUeuSLcJ/lTSjxm2BkzeMQG7grpLoQItaefgBOP96XRj?=
 =?us-ascii?Q?uQqv8i9cGmCZxTcK1/LSjpx9wq8Osrj9K2CY2Ws/GCqLTgxP9+XHdj5mjq9a?=
 =?us-ascii?Q?M84PgmNtKiCKzP/jJHfkEoSh6lZEAACLQ2IPjVjhDsZD6u/zc2AG55px+JQf?=
 =?us-ascii?Q?vuLZCvW7mJ95YSCau6yTzkUFFFCYxKkz+UpOYcng218ugfvbywtWBH3BjAaN?=
 =?us-ascii?Q?vv2jH3thopzg+6gi9OkBBvClcxWRxJ3rLvm/nZxUpD4iYx4mgZuEr2k1VnVg?=
 =?us-ascii?Q?GBr5lloag+MJ0V1Rq3B3z3bx4uVELWpMdImB/BfA0kYC8s80FL5rj9ZYOEIb?=
 =?us-ascii?Q?1KV7u5mH8/xW2pDpCHU2MaxEBUaOJZVxvWBwPUFqCkbw59xotSrVNHHrSOfg?=
 =?us-ascii?Q?1Y/1h2jMwfsGlcZt5lLhfVjvOfimkWslA+0lLmFvl+DBbpM7+IriZoDqD2V6?=
 =?us-ascii?Q?Yi5N/27OyjGkonvgwYo1uuZj6O91cFkJyEKV7vM5Dt3nrFoRcPIIgwWCgbHx?=
 =?us-ascii?Q?QYmNx349TPinCFAyDL4ehY/a0bG9exJS19OygNRwYVBpH4t6G6nmQlO1zM0p?=
 =?us-ascii?Q?w9o82ykFp8HwAuG/Ut1SgUgxFdI6y7TcZNvOsYmbezk0yTnYXDR5SuiUFK8P?=
 =?us-ascii?Q?xU7vNodZYU7TX48wPSwzFFLYVjIKk7wFzJzlNZJf93HJ5PycLiBEehZSKRfa?=
 =?us-ascii?Q?ELTMj4K9pvKmDfwt/7H1dXpYBp9lAKZSV6/PqqTjFzqpw4WDd/dMqeSGSmyS?=
 =?us-ascii?Q?dcN+XRuBeX+H87tt7dAkuEbWlAvZb7RWnhw3mac2XuGBep/d6Jfflbc4864d?=
 =?us-ascii?Q?kU+SZYAt958E/eY4JfemidnPvPS5Sxqvguu7E2F+cmjdQKhfeNdJ8n7bZVX/?=
 =?us-ascii?Q?WqRqS+2J8nao0g15sxJJ4L+xLOWpaZlmq7v2wae8ipNimdlPYAfkUYnnVkTL?=
 =?us-ascii?Q?Pm3i6/nVahxsO4m9c7W64+g8y/Zw/32cGD6bl8D+1bvn8dOextSK6G/l8pIc?=
 =?us-ascii?Q?FSoa/uz0ChqMzMXr5YydmwM8TMGSxlfRtnW/NllviRpUyorD7u4COM5dpnGd?=
 =?us-ascii?Q?uVVLBYXxPvFVKqFo/kAy9pJ4qM0wKa7lNv3bbpxntqJYDsdclLMqeYUvCrJr?=
 =?us-ascii?Q?0O9v8o5n/BoagzyS831NqddbZ1LXJtyTe3zBKEzF7KSgvB2VhRaSbKkEwGlf?=
 =?us-ascii?Q?uz28HnFrUj4kuef8GFn8rGPHBe6ee5DEu01iXk4op+alf3dDxMxGkhTh/Nvn?=
 =?us-ascii?Q?+AWkXcNHeysz6IR5vOCM7woUNjMln2sBd/LfVxYKYcjJJ5mnX9IedpbgQRyP?=
 =?us-ascii?Q?Wr44dbAOQYMnuwwdTe+5fmU2InoiuzIEl+mr/PFfFHqMMETzoaGRuEnhPVXI?=
 =?us-ascii?Q?uE7J+h8bOqewm3clNMlskxeWRJ6C0Y7y1gEli7+JJZIi5EcBdkuV1WnAjK2w?=
 =?us-ascii?Q?C1GBIZPZvXQ9WYDyUoimJDLqwsLNyg1tFu12w80b8BW7TUVqjHCy5mUKHpre?=
 =?us-ascii?Q?8nnfNXq6W0TfjTRkSIS03CgtTyuniJlTdv7Yrs1ls2Uo3+3B4gpIYS1pnYRH?=
 =?us-ascii?Q?3rpFzVtExw2J8ffcYA6ACPZ8oHoDM+LTlAYO9RzWMxwMN81D1lemBntGAule?=
 =?us-ascii?Q?DiixwQKUa0nKfoRO91DC56qb1k1OiDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TcMLnrBT6C3K4Typw43GtNHHhF/x9SAYMsVYEx02Y96PwErbREgx39v6EMY0vXIp3I2ooVmokrWk+4441939rmiMWdjMv7jU79y1QfPwePy/1o5I+lMSpqC4E86ANDvaphXTHOWH0n9bssFRY6SGSFntmAQA4nnnz3f6TGe9p3mg8Cr/Zjc45jCMZ6uCSE3zGPh7fnTKYikU5K2sgbywW6hgU49o4ncNo/0Du+9i8yiyrFfyP017cKQDri1LT9krzpAZNsTMtpzAdV3CzcPhMnTps7FyzQZGqa27kP0QmXaaoJaoDfJ52bCi73ruJGn1CfVU7XOtiBZ/6lTVSjDfig==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f36f8ac-a511-4516-4f68-08dedc2cfd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:38:11.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJALnQwaF6HS8f0G5urx6+LwtpZ3DPPRzfHFlzcHJOyiFg4IzYOGjSXonDKUnuiQXccrad/asetUAN/rYYW61OxLH6zi+Z+hm/GXATiwrZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-305475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71FAC71C1EE



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Maciej Fijalkowski
> Sent: Wednesday, July 1, 2026 2:45 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Sashiko AI Review <sashiko-
> bot@kernel.org>
> Subject: [Intel-wired-lan] [PATCH v5 net 4/7] i40e: avoid deadlock
> when calling unregister_netdev()
>=20
> Sashiko reports:
> ***
> > +err_netdev:
> >  	if (vsi->netdev_registered) {
> >  		vsi->netdev_registered =3D false;
> >  		unregister_netdev(vsi->netdev);
> Could this result in a deadlock when called during a device rebuild?
> Looking at i40e_rebuild(), it explicitly acquires the RTNL lock before
> proceeding:
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_rebuild() {
>     ...
> 	if (!lock_acquired)
> 		rtnl_lock();
> 	ret =3D i40e_setup_pf_switch(pf, reinit, true);
>     ...
> }
> If i40e_setup_pf_switch() calls i40e_vsi_reinit_setup() and takes this
> new err_netdev path, unregister_netdev() will unconditionally attempt
> to acquire rtnl_lock(), leading to a deadlock on the non-recursive
> mutex.
> ***
>=20
> Use unregister_netdevice() when the rebuild path already holds RTNL,
> and keep unregister_netdev() for callers that do not. This avoids both
> recursive RTNL locking and dropping RTNL in the middle of the VSI
> unwind path.
>=20
> Fixes: bc7d338fbb3f ("i40e: reinit flow for the main VSI")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a29a89192a7a..e88cf7cfbd84 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14257,7 +14257,8 @@ static int i40e_vsi_setup_vectors(struct
> i40e_vsi *vsi)
>   * Returns pointer to the successfully allocated and configured VSI
> sw struct
>   * on success, otherwise returns NULL on failure.
>   **/
> -static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
> +static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi,
> +					      bool lock_acquired)
>  {
>  	struct i40e_vsi *main_vsi;
>  	u16 alloc_queue_pairs;
> @@ -14314,7 +14315,10 @@ static struct i40e_vsi
> *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>  err_netdev:
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered =3D false;
> -		unregister_netdev(vsi->netdev);
> +		if (lock_acquired)
> +			unregister_netdevice(vsi->netdev);
> +		else
> +			unregister_netdev(vsi->netdev);
>  		free_netdev(vsi->netdev);
>  		vsi->netdev =3D NULL;
>  	}
> @@ -15036,7 +15040,7 @@ static int i40e_setup_pf_switch(struct i40e_pf
> *pf, bool reinit, bool lock_acqui
>  			main_vsi =3D i40e_vsi_setup(pf, I40E_VSI_MAIN,
>  						  uplink_seid, 0);
>  		else if (reinit)
> -			main_vsi =3D i40e_vsi_reinit_setup(main_vsi);
> +			main_vsi =3D i40e_vsi_reinit_setup(main_vsi,
> lock_acquired);
>  		if (!main_vsi) {
>  			dev_info(&pf->pdev->dev, "setup of MAIN VSI
> failed\n");
>  			i40e_cloud_filter_exit(pf);
> --
> 2.43.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

