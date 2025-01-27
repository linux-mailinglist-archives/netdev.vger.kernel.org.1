Return-Path: <netdev+bounces-161195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D55A1DDA6
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC44716531E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F1199252;
	Mon, 27 Jan 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lb93YVlq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A01990C7
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011604; cv=fail; b=tDYAeGdBFyXH98d2KmnHdJme3HkLQIDqWvMKQLnDt1n3aP3rd30/THC0yiG1AYhvF0bJfUe6OSu6cgm1tYThAwk9/ZhYT4bO6lAYOHxGrfYyu4ROZ137phfWh3U5iVwAhAAl04sPp/ptoPg9BEPhsE4gC4+m0MsiblJZRSmhiLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011604; c=relaxed/simple;
	bh=mJZuK/xEQjHMcZQczUzoNN8Iv5jO7DD5u2y+SavX4TQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MIoXeH8e048dhGtNOiqP0oCDzB/8x+yE7ZvhzNfS8iS8Ay1cONdBgtpgJ99Iaa0Kn74W9NBaOE0ramZlR8iThS+0XXe0Qrj0AhxcAqSCjO3dNql/x+37dM4BxvzVX9qJQJToAf0sgwkHmsbHG2s8nfRHnhJzar4nbNbyIlLCgKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lb93YVlq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738011603; x=1769547603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mJZuK/xEQjHMcZQczUzoNN8Iv5jO7DD5u2y+SavX4TQ=;
  b=Lb93YVlqaJPok3f/nuD0T+EWZre4H8gmmNGkbxbVbhBFE/j7N5u8zgE/
   NG0zy/YkeRTJUTIdCVtcvrRXAnVMAwHU8LD98mrrVdO5AxvdcZHfXhDzm
   BTnp38iwNBsh2r0Wwb5Y4423KxCJ8ow0X7XsvNnu60ooucjuABbAzQfJZ
   BqrvhVP+xcgh5YBz8XtQRsmMYYihZKOXJsizovZaGEI5JvWMCbm9O8vvH
   7s2nuLEL8LBji8pF+a+NlRExskF7jmCf9D7eVBJ+6bkLp6SWMJPhYPMSq
   IzW+DPfQt76WQtfQzEiQw0cHApCbjEeyqw2VLpjloHBtYyny5xYBDv1Gw
   w==;
X-CSE-ConnectionGUID: 1793wPwKSP2kY1wvANb6/w==
X-CSE-MsgGUID: CXfNwk+fQjenb0Mu2z7ruw==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38370176"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="38370176"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 13:00:02 -0800
X-CSE-ConnectionGUID: BYN+vZg3T0yg2HhnpEa/tQ==
X-CSE-MsgGUID: 3U1ghDe7Q2+UBFM1S+2TxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="113555105"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 12:59:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 12:59:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 12:59:49 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 12:59:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylJlPwfEgU63z2zkKlyh92lxgaEHFBa+8YbRQUPD8H3eQL4m5pOHJKYS71w1vvLk/2MhNo6pmvZ7sf/iP/u85XgrhC+nyAyTns2G2m3t/t37peQg5tmrN6JMNnC4PSnACxoNVEutzdnmjtlZZJGONqyJu7TEv5eBUCRsit+RY/JAQyTZ3VwJ8MgLduLjvuAjrfd8yoNpjq8qq94kmTX3nR8hCD/oU1MIW5UpVfgPgX4YGTyjGJWQJdEapBpDge0rNsrrhKiOU7uILROWrSRiIgXPHkvy3hYD6f9KYAfQzJIAjUqPwuG+rV6sOo/78gFcRwEsuqWvcFI+xYy8A1F1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJZuK/xEQjHMcZQczUzoNN8Iv5jO7DD5u2y+SavX4TQ=;
 b=XDVYqMI9vS0avjXlJqpY3yJjgNkPkFmR0Lrkuin/pIQE2OZnnW/GaORIAL3HLBlojr3ydvjoWvOCaoacfh9gsNJaJt0AgfalXpfMxLqWTOYLgjt9z08TbRi7Yyvf2o7vmP89f0MVx5yXC56We/eVBoq9CoWZp1U01szUNcT/HhQI6MrfErQE81vXlf3hMnMqsxrTd7AEwixdTeJKWUAhPAU4i1mYgiy9RY2lmwhhP6u7pvwQZSXmSCLihQib8Ic/liAbTzv3Dt3ezR5sLdEKx2UA9QyMkPONvie0ayKtTznyqGTnlFEvWWFkk2RHekknpaUfNEd1YRvQqbSI+Agogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 20:59:46 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:59:46 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: fix handling rsc packet
 with a single segment
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: fix handling rsc packet
 with a single segment
Thread-Index: AQHbY7izNEdLTrbDd0uKFcqGErDNv7MrB5xg
Date: Mon, 27 Jan 2025 20:59:46 +0000
Message-ID: <SJ1PR11MB629722DDBB8E0977B90ED80B9BEC2@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250111002921.167301-2-sridhar.samudrala@intel.com>
In-Reply-To: <20250111002921.167301-2-sridhar.samudrala@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|CH3PR11MB8139:EE_
x-ms-office365-filtering-correlation-id: 4f8a3905-dd6d-46ff-55c6-08dd3f158827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WDVynqe1AxhA77ZHiB+OZw8IMzts0EoXtfn10te9XQOh7K6ZN4ZL7XvhbPKU?=
 =?us-ascii?Q?13JKq9gPBZHMd8boOKqFTqBA3uSY6XAx/aaezqFg1RxOlsMRFyrr3HE+o64l?=
 =?us-ascii?Q?0MGBVOx1HRNy+AbIcuboCbaFYwXNv2nKe18JchpKBr5Db5wNuX6e6MsajSis?=
 =?us-ascii?Q?Xi7ND2dcY4T8wAewzj8FqTo1G5XXw9kXC31NXuCWap3WDNbtrdjbsb0/ZV2p?=
 =?us-ascii?Q?JJXi5VOQJrJbzotv1PFgqVk3+muWHb3kk4EjkFJoES1v7NypXBz4cvYDWQsg?=
 =?us-ascii?Q?u7rHA70jWb3Mf6LTEJ7dp+PNAdxNAj+seysBxOUaTP7hrudGLMoie2L4qJ20?=
 =?us-ascii?Q?REjagIXikAKQqM+bwzRprfkmP9vHEjC8bii4kTAqkHvv3Fc/gujAbNxTKHVC?=
 =?us-ascii?Q?ZFyh6fDavyGbh0hng0ShemgsbQJf0vaI/ZMdCMV34F88wDF6UoKgN2AZP67o?=
 =?us-ascii?Q?DI/e01v4q4kIqxLdIKSii467u4aTuxvR0HD4V5tpqeyhjoZXws+dKyydOKpl?=
 =?us-ascii?Q?YP406c/aH63OGlFdPqzNOkdONbjhSzSkcaGe2xSWA25oUJccGaX7UhdXE+QH?=
 =?us-ascii?Q?D73ck09EUXECHC5yjI1mlZ6cVRm+B+kaqc6qRjoAmUGsbX04yKbJWGQEh9i7?=
 =?us-ascii?Q?G28J5fmJghO/yt2ZbNuB5CLi/soHuSMYgi+xKNWpOHFFwmOD1w0TjG1EU20t?=
 =?us-ascii?Q?7v8mhjyaujT5El+ck9LaP5nkin2P+3yGJpRa2LbBoMNcoch3ghsIEba4sZay?=
 =?us-ascii?Q?VgEQ0fd+xKZ/c4kY35tc3YA9dJpiZ05GGyfRhpIVA+a/2duJ4M4UH8cdW0mP?=
 =?us-ascii?Q?vToeUF6fImGKwEMbDqc2qWyDCeq4fSMzAAOo0qLBwX3fO8ea5C8V90TUEFC3?=
 =?us-ascii?Q?fQ94+4joomewwYaVdtwCim61f+NfXvXKxBqFrkD3D2naXK0W3r4+RD4CIIMw?=
 =?us-ascii?Q?nv/9NZZTT8XPTfe9nvwujLQFS2XWiAmltn/RQIwJZC2pYEZmTYNUNMtJESCq?=
 =?us-ascii?Q?ywxAawyrc80VlbSZgBUHS2G25tMMssWOxx7lz1CLzFIRNkFYMTlIB9uolN33?=
 =?us-ascii?Q?AgK2Vx7CBj790VsP8+s715TZ/wlLRCXyz0jjqgOEaKQ2EN7cYk00xZwqy237?=
 =?us-ascii?Q?EN+zL6yPnMyOVDIU4zVEjtgnFbryL8QHf0RG9raj9Zr/TzihkAt7+LFR7wKm?=
 =?us-ascii?Q?XTWgWRad2xno3KyxJAfc88muyM8JVZ1+FbNHs95BGC0SkcFNiyijVh8jyj8t?=
 =?us-ascii?Q?xlgVWilXD0Gglz0/i8wR8k96eh+oBX6yYZUoDDGeIwGgbVkJJLyMKYiECttA?=
 =?us-ascii?Q?mr88BnjmH+BwZeXz5vIiKON1hQPxeYJRMaU6lbQAteeDhd76Rs5kkx6e6N/w?=
 =?us-ascii?Q?sJsAnbMJ3iZyrqwWif5XgaJ3RXlj1oVVzwI1Jj5CwuvkFJoDElJbSNwBIJ+n?=
 =?us-ascii?Q?oUemaiqDAJuKN0hmVY3rkt0fItN+gJg6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SDB2ctKKyOxWFSaI8BMTyLPZwIohI4SlLaSFoMUmM6fUdAkD6KbkRCeqHVX8?=
 =?us-ascii?Q?LvsKfA5xbew68d9I4WbpWB5W4Tw03dNUHH3+Xog9LClgQ7Dfl6+d5BQMS6wg?=
 =?us-ascii?Q?SSAaknGjpFOWaF/KG+aOl0CA3jxw3fbwZsLs+P7lm8GggTZ0/vFk+x4+cier?=
 =?us-ascii?Q?NwuU4CeKAP4C5uHUtZiKH8cPe4BaS2N+hkCg9+RGtF+oK+LWP4036w5mkBZd?=
 =?us-ascii?Q?u/DmnMHq4fncTqM+wwz+sNg2529USSbEcgL5CLMT7ddVkq1R48urSBQJg/Ic?=
 =?us-ascii?Q?YqpIONI8iuj6KwTGjWDNX8+bbTrM8B4hlFtu+R9TMgx9eKriFoadZ4cFSEby?=
 =?us-ascii?Q?a6lkoYeLfErkYcaWNXWgOcTriRX6AtN5JRf87v1qnNrA44pDE20XrPiR9aqT?=
 =?us-ascii?Q?2Ue1ZtqWv/Ym7/ilZImEWWw5tywov6oAEZA8SHUhtJn495YhR558z6uSATBJ?=
 =?us-ascii?Q?+2wGHZXv7gWpQ9TB4t22rmWL+CbmDMLMQQS28jsApCnA9TRcKSHo5K22qZA0?=
 =?us-ascii?Q?oYDXa7HiPNlrAus45wPjSrM7UHET29AcDUMWaSWHJyH5DGJNQPDQYt7OM/zy?=
 =?us-ascii?Q?17vruSrdNm4rXdiCvgR1hR0Xe2Ge8d/BsY6s2B5lMyTI7GKhpJ+DJOxYIkDR?=
 =?us-ascii?Q?ElqUNRqrUfg0y3/4mZS6eOHAVtvdGMxtKX2hdp35zIDDXrgOZBe8gb3ICuhZ?=
 =?us-ascii?Q?MoATjo/uWIT0oiKo+YntbOQbqoEPmwMoqd4EaY2S8o7i8grG8xshFyRxHOC/?=
 =?us-ascii?Q?roxHobDexNNVtGoj6ExXKdBd3Lw+XQg2FC0azxTUtFob+m4yyySvVEpPfH6f?=
 =?us-ascii?Q?eHp95WTlvbReryozuSlUa9olyvQVasL+eicgIZPTW+AfX0baO/2W/7FE8A/k?=
 =?us-ascii?Q?SQCR5ZHmNJ1HkOsQAfPqHt83P+YgJaBPeAZqxXr/A9610Lr2RbK9afFbxJCZ?=
 =?us-ascii?Q?sQQD5te/pFN3otIstgcuMvgcknzBuhyu4VOYFfo/47WuSWWaGBZcxg+d6d/2?=
 =?us-ascii?Q?IlYrOed4VQ/XlbnWUdO4Vi6qACeTTar/b5hwq+wMALifkZVwcW5mlt48OwKU?=
 =?us-ascii?Q?FblhYw/PiHbsNs6hZ1CBfJA1HOVfV7ku8QcYIrxH5/FguoDLQ2yyuPkE2fBj?=
 =?us-ascii?Q?hCLQXxUCirM3SlyI3fOTXQxhBQv+SMuzXKWVc40PUBQjXvhvPhptYO41foNt?=
 =?us-ascii?Q?eJ7yR54ZSeC+4ItdKUiBmQPGECV2EDs1V1ZqXNFV50mBxIud4VDiMpruMaOZ?=
 =?us-ascii?Q?Vl3YMbuTHcXLM4+xvBrJ0izIANS5a5Resl2G9CnRA7PtPvuHDY1XHIe1OAIX?=
 =?us-ascii?Q?4TNMUOwR7fxiQXJBcRs2SAfMJpMyaSzB9qbmyoqh+E+tDWefnX3WP7dIA1ya?=
 =?us-ascii?Q?xUqdH0KxYLgDR27AJgnmj3OGPU6lni0v/1+MDrrKfbOdSddxNp73oAlAx6NR?=
 =?us-ascii?Q?NY4rmV2JmtaEQLNZoRsHZ4FauIeOPJWOrPeg5nOtOMnxeIlFJXRC54WiVFat?=
 =?us-ascii?Q?DkMUrTUHQwVvYEXNAflmeJdtbFO1oHezOg8tGAh8mBRnCNEJoqPHoTySDf9s?=
 =?us-ascii?Q?2kyN1XHJoVAvER4O4o3DqzKEVMrGPZBQ5z/5t91R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8a3905-dd6d-46ff-55c6-08dd3f158827
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 20:59:46.7187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9yf2alDB5Kl7XtGOw2FdEWCHQRRSkoJvff71DAURew+eEI5DKjV+9AWVuLDv0C3PPgxCktNuFnmWr95J7tL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Samudrala, Sridhar
> Sent: Friday, January 10, 2025 4:29 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Samudrala, Sridhar <sridhar.samudrala@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: fix handling rsc packet =
with a
> single segment
>=20
> Handle rsc packet with a single segment same as a multi segment rsc packe=
t so
> that CHECKSUM_PARTIAL is set in the
> skb->ip_summed field. The current code is passing CHECKSUM_NONE
> resulting in TCP GRO layer doing checksum in SW and hiding the issue. Thi=
s will
> fail when using dmabufs as payload buffers as skb frag would be unreadabl=
e.
>=20
> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

