Return-Path: <netdev+bounces-174983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57538A61C93
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BE3460488
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A2204840;
	Fri, 14 Mar 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeedq7KG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66480205E31
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983886; cv=fail; b=iTsHL+r9NCW+qMQN4vdg9PUoq0k4NVjjls6Lyik3pW1lKnWpMIL6ypTb/qAfjNNqcIW/UrsA+bXlF0KHsQEIZj+QXC95TKI9LS3eC7Gm0WvaCBTRxQGPeAnyd1bB41P4aVwvEH/eOW64+994tZUU9z7cprmDTg//hin0w9/vp14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983886; c=relaxed/simple;
	bh=1uNtKZIC8wN5vn0xSqWMM7oOBhEI1XJHTs7w842AVDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTnQFa2AnKzNuN/gJiygYTGlM6lunzijfhXtSh2sRh252OI4P54NoxGMgY7QV1BusY9mxP5RSaZLKtsWSiNkwAt323XgiAp9lvR/UpbVEzf8eIsmTsxozTXqQ9bVqz22Jqx57/DVylSxq/8tS32DXaNHvy0NGaj5+9BTC7TGv5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeedq7KG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741983884; x=1773519884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1uNtKZIC8wN5vn0xSqWMM7oOBhEI1XJHTs7w842AVDk=;
  b=aeedq7KG6YI5yzgB1U1nOku7tXT9VzT1tGYQ97uSFxWxT3U2Ht4m9HXy
   xz+CnYqrwJoD158EcYrH31iYIyVaAAjR08NJt8ejUN2fbGjUWrT3BTv7X
   FMm7YWuMOcWMtlZQTJ41iRZ+NqPzwnyIeIp2A6in9rO92TG1DVr8jvJU2
   AhhNPNsyDZF67y3lCmUqWazveL5Y+8BSf5zWEec9n0OTPJepe/0JsIL9k
   WoAV3M7C4rf2OkGegzojBa3RZWEtie5P6KA5lM5r6qG4x8IVOILDDeuc2
   +fvKXGOUWhzK6nva4XgySwrNF11TeEFZZFyHif/vZALXFZm2po/4+ru4k
   A==;
X-CSE-ConnectionGUID: orq4ua22Sn63wOBjUBSC7A==
X-CSE-MsgGUID: SsSimLKfRB6+p4AythgQmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54147706"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54147706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:43 -0700
X-CSE-ConnectionGUID: 0cyeubkGQ7G/EVfaTOaI7Q==
X-CSE-MsgGUID: FBrOXx/8TH6AU+TOvww7pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="126577734"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 13:24:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 13:24:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 13:24:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 13:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb8JbOoP6RvTeCxxsyM5CnQGgPv3EKg6ZN1+auWT0vA3QRcOWm07OVUGlYO6yQJEHX0Q7THN1soTdygtsm8RRnwwA0q155CUayyiPC7pvyt7AtkvNBrqEuaoq3sCNNWNnX+ExoRiF8spDDUqa4K4YnOOtsXSzLWmwoCt9BM/FBDa7B+OJm9MUL7lTCWS41QOuD7KAwYT/gKrSXbeXCDtKTkrAQa7hq75OPYJzZ6IzhlJEZFZSFVJGm/+/ekp8hto407bptTEZ+8PPqJ2RKE6ZPvc+QxBdBFWGn0hVj16+IJslCacH5Fr1UpGRDfhEJtjx/+wSFPUCZT2zjq1NcFiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uNtKZIC8wN5vn0xSqWMM7oOBhEI1XJHTs7w842AVDk=;
 b=ZNq3MCp5tJr+i9C4A567Q7VM4VGabkdts1s/nKlslL2R9CvMD6s2SQRa1aJIwbAz49H9FhEd4ZlGemCcyMYsjY580wwIOkG4eOarKqY3J9zpDicimmrqxuvpYMNg3VWO3B8kt6A69uZYzB0+0d6AQyYQzqsUfGDVlCcC8VcIwMOkudtDXrMSvMbbbbVBmidFVY7LNRUvM0uznwmy9qRWzYRW769pY+yjGIb54OvYtM9RXadr+/dF0cRdOKuuhpeg0HcEAtJyjt3VEQ3siEnmIVYOn6gwIwEq+ma+4GpIzyswbNggDpQlInqio7Tq1XJyI11ETUvMIsye7A7V05sd0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 20:24:11 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 20:24:10 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Olech, Milena" <milena.olech@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v9 iwl-next 10/10] idpf: change the
 method for mailbox workqueue allocation
Thread-Topic: [Intel-wired-lan] [PATCH v9 iwl-next 10/10] idpf: change the
 method for mailbox workqueue allocation
Thread-Index: AQHblEOumPU7lbfLsUWyKC4Q8hrBJbNzDj+Q
Date: Fri, 14 Mar 2025 20:24:10 +0000
Message-ID: <SJ1PR11MB6297E58B593D7B7E370238449BD22@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20250313180417.2348593-1-milena.olech@intel.com>
 <20250313180417.2348593-11-milena.olech@intel.com>
In-Reply-To: <20250313180417.2348593-11-milena.olech@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: 62a869f1-6560-4867-b0c0-08dd63362e14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?6qObtwKJ+18gmhz8MbWq0vwLeZ4iU4+gYTRRAjL92tlpPkei4tGw/fkA/tgj?=
 =?us-ascii?Q?+BeFtM4a7CPSoIR6U/ZEm+uz0x6Y1CTVixKpeMiKP7u1crhyTK6OdQK8rfsd?=
 =?us-ascii?Q?RTTR5O9eNYTxVRXoe4OrYwmfTU0baSrr3ZnXNjt7mZfR70t+Vepik9QUL0h+?=
 =?us-ascii?Q?8cAc2E9SXQHKIlDjFC/lPgI5jsWW33t/y6Lvxy2D7iH2B0y2vOTeFsV/VfE/?=
 =?us-ascii?Q?vsaiJ2R/VaK3tWPU9ED/Nf0AS593o9lSwDz3J2Sk9kboclPphhoxyYc24D28?=
 =?us-ascii?Q?S3IhdqkW/4jAo94/sYhJMMEa9Xrfp2piYzmNUWMjqqkDny8BbQ7AdAYzkHya?=
 =?us-ascii?Q?h24R6a147MH/Ld1BCRnkap8Rp3hTDtE44Pue9WJPXyLRX3ZwDaeHiAzQGrYw?=
 =?us-ascii?Q?8q9PWXXg2LX3qTimmuv1Uqit72kEXvEKs2J8iOtA+TqbUYqKs+uuzybOxk5U?=
 =?us-ascii?Q?FY4QkzFxl1DOJEpRDAurJUCvh9YdgkjyPH7mHyiVI0ibuDawBm9laljqNfys?=
 =?us-ascii?Q?D2TWV+tVPhQ/3RT13Q+cjDbllX/bzJawAG0qtHLeA1kVqr+yuiYIOCJpsm8b?=
 =?us-ascii?Q?yN/1moAOjBSLpJ8Iol0/X4YbCmNkgueFQmRvzfe43xnhHbgIoPwU7l+TK00J?=
 =?us-ascii?Q?N/jEB8ktBzC4hjdDDfao3RrrncaWNSAYDAker0RkTz1f+quaxop7JSLwDvAa?=
 =?us-ascii?Q?ntjgZSo/ILFObG0ZxNCNa6ujKlIwUHS6Y89mp+nIZE862ISQ3UkJ9CLK0jJy?=
 =?us-ascii?Q?Rn8/udQXc1o1sCJU9V+jucEd6wNYLaIQgg/jfmfh19tZJaThzhSJhACXc6TH?=
 =?us-ascii?Q?srz93QK4xGp3boIV2AnHN6+AhmCAhI4eEvx8tmecgMEpBYGQAtrnIfDMvHAN?=
 =?us-ascii?Q?lBATOuxI7k7ri74Ee3nCWUnRiy3cK6GgyIwQzDt5jFyX7KOofNN6+cVy/nUn?=
 =?us-ascii?Q?2UY/RwYbVPxr8W6MSCmFwz5egkamDWbQs6+kXlls86ByTzJTXrSK3zQnDA1w?=
 =?us-ascii?Q?t5XHaJbnMam03znZBQsp5toPT47Jdx7fvm7Q/VAWGb37SZmra9tL889yRc3S?=
 =?us-ascii?Q?MlDdjhjNTPwC5u4/WLrdmHqDCKpRASi8zSP1jXqWuR6+t3YVGyKtwskRVrCb?=
 =?us-ascii?Q?HPayCreM32+xVx25cRcYYSDX9s/rLzzSkU/NqMKscSC8v07t+5IN6W+fQuz0?=
 =?us-ascii?Q?0odMd7z+I3pMmh4Sab/Z2OfvhihwZiiF+5AxqLDKQGMMX4fHpWQHlEtOVt3L?=
 =?us-ascii?Q?OabRAY8sjnTWwE+OW68h7ztVTXaZuHNueTmWm9rhGNyZ0b0gQiKJnNVe3/OG?=
 =?us-ascii?Q?KJxIlSDzBRzRbwop2Gx2AbY3vqeWqTJqx2IFO8cD1pg9EZ1mEB1pZJN5AJQE?=
 =?us-ascii?Q?DPrCDIRqaUKEoFPh8HXe/qC7caXw8hIpr/ixjUR6qaCgXPpqFwEydb1v0JYq?=
 =?us-ascii?Q?cYpfZou4y1O2Z5QKN+CRbqAzBlTgbhlR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YYJ4XR3zuoHU194jrDKbBbIm6TF/9IZoGFXXbf9hqc01JSfCSPXfhzHmLBHu?=
 =?us-ascii?Q?dgin0JiI845MJyLQcDCQO7oWM/EsPOzBYpZsmY4pKnCd4laj6qQ7jcMTjoX8?=
 =?us-ascii?Q?/Gi/hCGYsyjCjJLf55A5lgFkxAeq2LyRtoS0+QLojESk/d2F9bGlVP/7ybCG?=
 =?us-ascii?Q?ANq77WYACPWtmhbB+jQiTtEaiQxld4kjqsU+Ypr70UWnr/j7tBXgOocj0cUs?=
 =?us-ascii?Q?/3np/7F4U1u7Z9NSCJ8G+SNnRwWz4UFRQYZRTuva8gTEji2YmSbx/uRg8SK1?=
 =?us-ascii?Q?XQJgY4crEFBZFZ6Ccm+W8MozV3UKw6qhCg0ACMOL7M8TvQkTuizz2jppYc1B?=
 =?us-ascii?Q?p/0fFiKSoF2ZQHqVKjJuGXQEe24eGVrchnZcRvUlAmrOXOWhsbGB4WgVCNFn?=
 =?us-ascii?Q?ggSByT77kXoHVEV/o9YQSsP1Py5RQBj5ZkhhLSH6/cxMPXFuYDgOlsA1HFBU?=
 =?us-ascii?Q?6a/cZYylAX3/7oo5ZlRArNxQBfveX8SQ8GTtPXtncL8UkTANFJVo1Gb2irVn?=
 =?us-ascii?Q?376/XvdUKEPFR3BcV9wDWyM7FxSvY9ncDdH0N+u39uO7x1g0Vapr6AQs7bEZ?=
 =?us-ascii?Q?OFrdzgSMWT9V2WpW9ksNTnVKMNjkRr8HV9DO41WL/f8JHDicBzPgeTb4oLYe?=
 =?us-ascii?Q?uA5EPg/iPqnqZ+cKLBE4qcC4L6kN9ZzvXpALLIFflqGkEpgGh9dMScNfU0Wo?=
 =?us-ascii?Q?eqFzGy2NqwpvNM+KrDEyfo3Vjau2HAaEcKlHt//tFfgJnv5lTd/HJEc8SZuL?=
 =?us-ascii?Q?+WA9/MQ5c/NyK1RhbohNtW//+8sE88B1HlHCNQOvx5jilrC1AAQ8oD7j6v3U?=
 =?us-ascii?Q?cU4h7rpPxvtf1x85kLwGsPu5OtYsqa5dAMmuZw1zspLYmyeQ51W7y8zYHoXt?=
 =?us-ascii?Q?sVvmVOb0/NO/gFnezJ6lc69PXaHrecbQehDjJqwEmV9mSCE2Kz7i1XknhG1i?=
 =?us-ascii?Q?oioNJFhERPkeyxdnAJindrqslaKu+DPccLtfbE6dJN71f2CAnBIGR6JMAGTx?=
 =?us-ascii?Q?HsMyFvBVidFZnjG3Dz6/lAWTNrjjTp+15kaNhieFMSEBoz27BODobnG+oB6k?=
 =?us-ascii?Q?RQAdNWO2SAvoebvb0P/UiucjP/3E2gxwHqw4+h4SLSpSs4gIvPT3BoIYM746?=
 =?us-ascii?Q?v03jndhhwScf89BekAULdlXQlt31WKOmy1YRZilU4BQtJNK+sSuMKdJaAdeA?=
 =?us-ascii?Q?Sps65b9Pp64oGouunAqIa/dLjPbz0TMnF13iwjG+znv38nj8Ta0VCorxMbif?=
 =?us-ascii?Q?bg+JhdCr/oFuWBSa3mFcchUZAb7OqqpRpN7LA33pdLa+Q/pWL+UcfAD6Wra7?=
 =?us-ascii?Q?Y3EUl7jaWI3n2EO7lUkfkXvIEKoyrZ3VuCvdyXtZiF+XB6+xpThHGNx+rKOd?=
 =?us-ascii?Q?TuvBhASDR5PESD79st9yJLNjdybJcPAOq8v8+Ks+xhAaGYPNcZe+MAjGzRYj?=
 =?us-ascii?Q?w3uzZFb5XK6+i/HMYHFqoCkv3ZEaw1Y7sdq0jvNAo4WBDYL0Ju4EQNJhD/fn?=
 =?us-ascii?Q?uRNkv1B4dkzUUEqVroKBkDvLfAHrKfJMrlpYH/itMVVx9LZf49JenDCnZhBi?=
 =?us-ascii?Q?/z9BbPIUBXgZaPPCckyfM4DoMaXcS0inrhEYG3K/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a869f1-6560-4867-b0c0-08dd63362e14
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 20:24:10.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgSKbSmzAfQLRiitZgYsAIcSPw4cH54mlQHNsNe97VpQLOZDCTJPwcF4ZUVtpRe44HrRv3AC2O7hnXdRGSmv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Milena Olech
> Sent: Thursday, March 13, 2025 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Olech, Milena <milena.olech@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Subject: [Intel-wired-lan] [PATCH v9 iwl-next 10/10] idpf: change the met=
hod
> for mailbox workqueue allocation
>=20
> Since workqueues are created per CPU, the works scheduled to this
> workqueues are run on the CPU they were assigned. It may result in
> overloaded CPU that is not able to handle virtchnl messages in relatively=
 short
> time. Allocating workqueue with WQ_UNBOUND and WQ_HIGHPRI flags
> allows scheduler to queue virtchl messages on less loaded CPUs, what
> eliminates delays.
>=20
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
> 2.31.1

Tested-by: Samuel Salin <Samuel.salin@intel.com>

