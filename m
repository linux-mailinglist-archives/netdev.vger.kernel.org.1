Return-Path: <netdev+bounces-284993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMlABQCK+2mWcQMAu9opvQ
	(envelope-from <netdev+bounces-284993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA664DF62B
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 20:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 225A33004DF9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C654B8DF1;
	Wed,  6 May 2026 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7mRAbXT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8048C8DF
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092540; cv=fail; b=qeB/+iDJEUXCErNqe5pPjb7rqStvNE6wdiBPBfhIL2OHmIZ+tMwynbcUXG3pVTr9SzsBQNqXuFJlCSLdyxVeeWFA7N8hRArt130TW/Wn39u8owjVQsplYDHHwJ98NbI2bW/wZZXK/JrcEupvTXWlNykbWEAFcnWEGRH9+l/j6Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092540; c=relaxed/simple;
	bh=roga35vfsTiHE2bvc/eJrUeL5vAk6Jn89QsaEIsdlhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IaJLFWuxHxsM6TDo3Hxa+fuM+N2tga9YYhhP7PvLSFcibDI9eRTAJeEZ3N0buuzR6IHwzcwmUDQJivvO/E3LvMZ6BvKsk3cloDm32aS3hJ5axfTcw3nniFcQFS5EsVvICMKwlQ/VLvZnJi9aezheFytv+CGqcm6EXFkXwZDVXMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7mRAbXT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778092539; x=1809628539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=roga35vfsTiHE2bvc/eJrUeL5vAk6Jn89QsaEIsdlhc=;
  b=n7mRAbXTvEw2ZC4O1vlyzQFrowV/Cx9uicMIVhB642FgIH+sYjry9TT5
   rIrp6bAbQCoAWZIfwpmViyUwhaAVmq/4wS9Zzy96LtgekQ+RfV6LDhrZq
   WmxJ1Gsy7c6znKnfW4lAlrZcTU8Ad17H8lDyiwIo5W1lvGpkAPXpW3MGb
   mEevbCNLOeGoPevYETKa+xN1g8CoJPh69PGrd7jTcCZNK+8SVPlLYcCk/
   ODCNXjskMVLLP2bbL5LPqOgzWjTeOxp4eD4UaIl4ZmM3cbPdN2lwwv6AV
   m8+N3T1SM2Lhs0szMbaORw5KVB/CRg0XDucPVtLbcHGxUHhHMphcZRLhV
   A==;
X-CSE-ConnectionGUID: GhbbvaNHRgWxjBEoBcp4ng==
X-CSE-MsgGUID: /iYrKngkThidMN0jIkMXDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78061167"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78061167"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:35:38 -0700
X-CSE-ConnectionGUID: UQp2lNJ9TteHVIzAZG9D3w==
X-CSE-MsgGUID: 34bMVAVMRn6OksXT7L10AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="229831867"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 11:35:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:35:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 11:35:38 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 11:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOnaZldBE8arCRQ4aEaQa9MvoMiQu6QG26/9oXna34IrkDZ0YWqmEor/0I65jGBq+EA2IhyDA5lPTXbqVVKtrMJl126ufID5B+WN0bpqI5sUqGFU/y6icYCGuleSvwj7QizqDGbLJZmJ1cgpUvnUPcAk2Knmo12uCvBDRHjsfcWereqFUPWoxtuTy2RXAbTrdfauIet83brpv++0sVPWd2GrqEAA8Id0znQW62fZ/SA32/5ND+TfuZuxXz/WB823PbzBgDC6A37+ivVhuX+KdMtLSwDl6RGr5ETm2IicgwDwJtMvum2BAs0JkqRSI0Zfb+tTq1/TBzN9K8uvuSTmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIjy7wvW2OWFSj5bDSpbZpuaVcigx6Chh+iVndpaeUE=;
 b=Dlnvyb7DmLDwMr1WMWNqpaVz13e9rSFdttJiyL845CkKyMs7lnfsinkb5lqcUbgZHdsgahJeVl6HepWc/Sz9Cdorh4j6EseBI1swwDqY+xQPqpoxxpMQLEPi2SCiWyaoHwMfCJrtRKCfCVFQYetykqp0Ent/3vPJb18sdnxMu5/+85bpkfwt7Imtm9vxkWWf9xQeHVZY5AT3qW5y0dN+fttAeiBUL7ILuifXdSYdc1PpBDOxNWsufvpMjlq2nbdYgqqnZGMLJ0or2c+Ew0EUHvqEUGfoKFWWi8tjv/kmm5TCTmajXIW0ot3kcoqQT2qGJKysEyZBFw3pM/PJWoQnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 18:35:36 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:35:36 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Cao, Chinh T"
	<chinh.t.cao@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 03/10] ice: initialize ACL
 scenario
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 03/10] ice: initialize ACL
 scenario
Thread-Index: AQHcyCELbTPbHGlf706GaVF68UHaTrYBfdBg
Date: Wed, 6 May 2026 18:35:36 +0000
Message-ID: <LV1PR11MB87902C4F454626985EBB9375903F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260409120003.2719-1-marcin.szycik@linux.intel.com>
 <20260409120003.2719-4-marcin.szycik@linux.intel.com>
In-Reply-To: <20260409120003.2719-4-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SA0PR11MB4752:EE_
x-ms-office365-filtering-correlation-id: de450c61-52b1-48b6-c6cb-08deab9e439f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: O5cBkjGIIopndcKUFHO7VJo6RkKAH+OWSQEyg6WpMRL9eq12hRwMvIjlPUN9qLiKBJIgll9mdzDRY9jLNhUjzaVTgplvkOH8V/DLhexnQcYLqbyUzsPiRxXReKHRmidN1BmRSz5IwxKM+KiMNSiQKssNqFzTTAUcGV9yNmtxp+CPyZglUAbPZnblWdEuvnEqpDeDynUZRjxSXBq1cANwzg6Rp05YWOuQQlOehrgF4NdkJrtZUqTIyVF9xqkbYHZBtrNJyCLyufAe/heJOyCBvpP5eQ+MO+C7gwWoHFUO5X4059GsDi6mdQ39/VXOKpVXO4i4jDRd3vi7bmItSZif5hx28tPDni6YG3YDUMqwobxomDJs8zqQWTpNXt6CHkNa8KqJvTMxEfFFYy63d9Z+nrxsyYLwONatjuRyV7kCcDVu45uIYDOwtsUvwRMojynyVRatMJ3fwZy997YsfZl2/OiVSNpVuzM9we8i9ZT+tiM9pGBjRv540tv7p7ipkAW35RmgYjsl/OSgZqR7PI+cY45gHXy3oBOtBXlsw+1llCw1W2taKb/XSMDB8L8pNGblnDHdSD7iZwUruUrIIkYT4wjFgG7FuL6l8X8heKOB7mDpPwiR9oJdQncYJkcQmDfO+OR64oiHgdA8mHfUObEM8OX7tseV7Y2Ct938yMEf5m4XmpDF0VqJiHAL9ptsipAGmIVkRIkf7VK90ll2JhG8m9CHD+2dzAuCaAngNpJLbhPrmnUVj0qmw/e1isGDBLvk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zZIUSSQDnhW7hujaBQ+fcSwoV5u4934GdaPGUt4Az6uiYcowQH4cjTsovJEN?=
 =?us-ascii?Q?KDC6jSeu1nZqTn0DbUT/reMK2tFRAeHO7T8D9Bjr6Qh/dvEeRAmqUqCztk6Z?=
 =?us-ascii?Q?XtUiUV4Cs1aQ+3ilTXIzNOnj/mKo3Mf7ihfWXcOgdy+S7sgA0GRQS9UMKrLO?=
 =?us-ascii?Q?Jn2qzNJtBNTWzJqFPUlYTthzqig/jBvF3VPzZfHqtXvqwD9K2IdcMFfuiAF0?=
 =?us-ascii?Q?NHVdOpZyJvelMgoIVWZnQ0/R87o/0+UxCjvOi/8yrOkkWgESKvCNTB1O84py?=
 =?us-ascii?Q?nDdmAgEtf91pa4Hl9Njcvc8uHB7eCHWCRO6knrQWzMgDUSKPYmFML4KyK86F?=
 =?us-ascii?Q?uVDN/mL9oE0hxvvTTx0Y3IwNgA5sx3aQ3f5K6352xIxNP1tAyAzJXUxJWW6+?=
 =?us-ascii?Q?vUe0mov/NSdq+bf/B6VrVhKjTeO6hLdBIoEUA9d3TUi+1tW/5l2+MY8bQmPC?=
 =?us-ascii?Q?hi8GSxN6FDGDwlYMcKHqlyfxY/GMkPSimb3g6lOLHhqj7w2vUkNBzr6FrstU?=
 =?us-ascii?Q?T4SYLbJMaZ0gNWyRswirrspdMye4XczQnusbNTTg/jbugxxDOo7vsHTOFgyD?=
 =?us-ascii?Q?5AfmBc07e3CChfHATnkhBsexXnTgFGYlJZuA7a406HXYPfeU9TzkozF8iRky?=
 =?us-ascii?Q?Zn0780YHG15eiTNLqI60khoiU20yOme+RGQl+BRWGyJYG86U9U+edkX7X5jj?=
 =?us-ascii?Q?c5z7Ir1GKPnXH2CUTstXEG9xfZlPFUlLWTIYECcSd9suzLa9dweaQBNPm7FS?=
 =?us-ascii?Q?hSMeFQIwtbqRsl08oZgE2UWwYbz4YP7lHH4mWPdGD3gRqNhHUSm6k+T/e2AA?=
 =?us-ascii?Q?Pquc0KqV12NEJHNfiJAIJHt3pNHHTwIkuzhJDvPfv8pAG9R/kPiERT/5cidq?=
 =?us-ascii?Q?Jlcz1nP+4o5N782V7m/drQK5MxrkEYC07HeLldvowSO4HbOTgmWXwXmUw3nc?=
 =?us-ascii?Q?lkwgPp10OkGldn4eU2VUe1l9BrK5cSCObC6WGo1huT181g8MrD0zxvyEoUkf?=
 =?us-ascii?Q?n41kBGQa4gTHWBPe1W7cxofpRQGRqC6xghAXq/fYfo7wjskb0MT4LQ5CHY42?=
 =?us-ascii?Q?tnVb2ld0ZseRR8Dgj7jW35yVV8CXNIgBCxsGRX2cxKTuezw3ZsQvxcxoIQJJ?=
 =?us-ascii?Q?UW5Qwm3ThX3oXsi6fG+Z6QaIk0e6E09hKAyDSZ5FBxqLvcpxneiWr8AhLBBQ?=
 =?us-ascii?Q?YEInS0XjJ8YMy1VYyFeJU6zSuNOOgJFwRbiIhZVd7sHmQ0fp98A2qF24oiSe?=
 =?us-ascii?Q?Lwo9qhDDHp0Swu/I/jw6cVwhjr1D9z9lT1JKtX83MoMi+vZPqbAQhvsCyYAw?=
 =?us-ascii?Q?WJHGB94t7szbFHr3SknCObFZfC8dvouo1nHZ3uGtJIQm5AShIuMNvVu+lCMK?=
 =?us-ascii?Q?s5x5MQvZqXmjS9BlXIlXNsKfQN6zjkGJbgKBe/n2DMAZu/zlHsFyNMDCUC25?=
 =?us-ascii?Q?Dt926yaDh8QwCsFdw/KjDUiBi0U0roE902PQwzkjpaqayg/6jWSF4dPk/PFS?=
 =?us-ascii?Q?v+hd6zW73X0CtnnU4L2finEdfEnMmdSYWBHj3TeHDlSnQBlnqp8yTcRL6TaZ?=
 =?us-ascii?Q?k2XKb+UTRkkNz+czVGXC5yektWHQSxAtXnve2WXI6mc9irN5DN5aU7KdJe6J?=
 =?us-ascii?Q?AeElHPeuE3fkRKkDP16MyWVat835uue9IqWYUAa1J0F6DB3HYcSwUrG2lLCC?=
 =?us-ascii?Q?ldOBMTOIY7MvmkzRCpQjOvaKB5l9quhOv2uJ5WWTl9gWN8h0tlx1GegbeEEN?=
 =?us-ascii?Q?CWTk+km7Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s1jrQA4JE5zyvuCsV9CRcz6eMkYdomMFmnu2hA+vEKXKX0nQ9GuwsQrtPkHa+X5cPZUK1B8IPNwoiEpldixngxOI4zJ1S50UmpkcwxM/9aoxB/Uoqt8RAqS2nxDoDH5/3u/qpguxnA1G3LGXnRrQlVNMjzFPYQoCw6WKBbNCLUpVs1LK12vB1pAcw4Ub3DEyLnyYnCO1ajFsv8wmvlb2hmNVP8xe0RYYMD+CzJuy7PIBISHV0wnvMzfrP3RnC6NzTqRiECXmqnJ1+a4XZRKrt9uaDeZCpBStS4oD90Hbry6CUAMXWDtlsAuSDcXGuQJXcJXv9GzLCVctEighp1g5vQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de450c61-52b1-48b6-c6cb-08deab9e439f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:35:36.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWW2y1G8CpMycqxyjDgFnrVumcDdbTkWEfx4sxCLGW4s9fp7aHWWMvkS5OfXJU7/lPsNmtxoQBfGvoY2+wHcc3B/lku9GYCY0NEEEWJcv20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: AAA664DF62B
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,osuosl.org:email,LV1PR11MB8790.namprd11.prod.outlook.com:mid];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[intel.com:s=Intel];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[alexander.nowlin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	NEURAL_SPAM(0.00)[0.543];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Spam: Yes

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: Thursday, April 9, 2026 5:00 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Marci=
n Szycik <marcin.szycik@linux.intel.com>; Cao,=20
> Chinh T <chinh.t.cao@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@inte=
l.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 03/10] ice: initialize ACL =
scenario
>=20
> From: Real Valiquette <real.valiquette@intel.com>
>=20
> Complete initialization of the ACL table by programming the table with an=
 initial scenario. The scenario stores the data for the filtering rules.
> Adjust reporting of ntuple filters to include ACL filters.
>=20
> Co-developed-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
> Signed-off-by: Real Valiquette <real.valiquette@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2:
> * Add unroll in ice_init_acl() in case of ice_acl_create_scen() failure
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  drivers/net/ethernet/intel/ice/ice_acl.h      |   8 +
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  29 +
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   7 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
>  drivers/net/ethernet/intel/ice/ice_acl.c      | 116 ++++
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 558 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   4 +-
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   |  45 +-
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  12 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  17 +-
>  12 files changed, 789 insertions(+), 16 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>

