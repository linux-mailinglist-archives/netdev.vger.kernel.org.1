Return-Path: <netdev+bounces-296664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qqDwJjbyJmpFoQIAu9opvQ
	(envelope-from <netdev+bounces-296664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5B658E3C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HTG037m8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296664-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296664-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 123E730237DF
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D534575D;
	Mon,  8 Jun 2026 16:40:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F941F30BB;
	Mon,  8 Jun 2026 16:40:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936848; cv=fail; b=VbUHk+2pcyYlT6YTkZaRtcRoM6aQawC6CkCVkGDUGHATSZl9wSSZa/GgIYdigztT0Afoz36J3GhcxUI/WCnPfMRubpTWpK4FfHIpVbCrfhvtcdBe1p0Znx/KiHSDFy5Fydb8ahMI2ftuNuJhQOMnghEzaspovs2jNKwXbK7vuQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936848; c=relaxed/simple;
	bh=oxizEHSSBWsgP1ADDx//cJVe1w8cUceRf2bq2Eh8NiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usguKCFAH4hSdxw89F9/egpnze8sqxZzqxV4XXeR84nHjHprkjMBcwvPFp4AWBY33gp4LqORjiFJSAB7yWG/ol6pv5lsjYJepotTKDLaEsERZ7AD9hAJ5JpdKItCuTxGaJbj4coPsTfqkeUapyTGMZ6/fI6ilvlhPuqbSlwWYfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTG037m8; arc=fail smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780936847; x=1812472847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oxizEHSSBWsgP1ADDx//cJVe1w8cUceRf2bq2Eh8NiY=;
  b=HTG037m8nfowD4gTg2FZ4V3Gy9SBXDEy050sH9WZRH415B6qtBerQLwr
   uKlSNUF0oPnaaa+4pFD3UFXrdIQzyltYqB3cuGc4smx4dtN7Ui8QgawEy
   bTVOKvy4CmT7dLKywIiq/lDo3hX7a5I2nW7AJq572iCHm7fcd9cRK2Adq
   RoyBhIB4767Hi1H5pUaXxihpV5wRE8fTWL8cEPyPCtyQs8TwcjPQ/WfV5
   POi8Qh8kM/yNkE5K3zkIwWfpN9L8jnzivak1vY7A12zM7Bw2tFk+w03UE
   5RCFZuF50DqBGWQPEtZc0QLtSKAZzOnRvFKHkfoONkq8qGRN5d749BcAR
   w==;
X-CSE-ConnectionGUID: T4l9TWEgSj+zN2h1edobgQ==
X-CSE-MsgGUID: B/eLvUPCToC/wS26XXgTOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="107119717"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="107119717"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 09:40:46 -0700
X-CSE-ConnectionGUID: 8DgyInRiT0S/jVRNAwqY6w==
X-CSE-MsgGUID: zsTqDe9+SQiPIpBtkKAoDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="269602163"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 09:40:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:40:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 09:40:45 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 09:40:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkyIYhODybdfjf/wXKaTDqI0wtzcTNRl21rONx3AZ+LPg12Sb5OH/cizGAdhQEFJa6yU2xaZlwB2jL+iBrOgZkC6AMPH28vbL/rjosJ1eHAvSlyU0vsVQbYRvkY33jjU3nKmQROcMs+XwxhzAQVDVxcbBu7aC37H0fx3wODt63WncsyRG9CgDE6VLeC0QhPNDSP4e6ySt5htRJbJ/OfKGzoAN9SMHS73903UqDwzbrjhQnSpyBS+NmGKTOZmEeHpW40KQTee/3cHobD2HXMCpzhpIZu0if8SPuiJutgB+9BMwumpvsGy1KbAOisndPaeOGalba5z9ddB3mDEtFETfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAc7w8oIIzePALjotH5amsMnz10cPI0+FOoT+PbXMYQ=;
 b=DwHqgZwXC1H41DfEBoGi+5cmCZW6seo/v7knxb8jsWEMfR2kQG110UzGo/ZLCuMCjOpL5UeMh9CSmQdhxrFSSrxX/LNvCnaYrusMyJIl86AXE/Ltw/YuvZ96dYU6I5SHB2y9UyRfLaHIAIrTVGzp3lwFXVucYIpfc2dleLmqfE08n0vvRDoYBFO8G7WDrVnkv6T4IyGysq35CEB++mAremByc8+EfHSUmOIb2GmtRXka+9NHGwWkW02RtbWH0zxZhqnTKQJqSwSPZI2F1j7VdG0Ykmx/oZsL/1sN1PlZEaEI8kwMo8RpfffuGpvc1VTeCDR0WMpHDSDSAsuMbvqohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14)
 by DSVPR11MB972630.namprd11.prod.outlook.com (2603:10b6:8:382::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 16:40:43 +0000
Received: from CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968]) by CH0PR11MB5394.namprd11.prod.outlook.com
 ([fe80::fd22:b4:e353:a968%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 16:40:43 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Oros,
 Petr" <poros@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Prathosh.Satish@microchip.com"
	<Prathosh.Satish@microchip.com>, "Vecera, Ivan" <ivecera@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH v14 net-next 05/13] dpll: emit per-dpll delete
 notifications in dpll_pin_on_pin_unregister()
Thread-Topic: [PATCH v14 net-next 05/13] dpll: emit per-dpll delete
 notifications in dpll_pin_on_pin_unregister()
Thread-Index: AQHc9qx6ibnuXlT5lkuo7woo06VTW7Y03TAg
Date: Mon, 8 Jun 2026 16:40:43 +0000
Message-ID: <CH0PR11MB5394915AB8FFEF78351655F99B1C2@CH0PR11MB5394.namprd11.prod.outlook.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-6-grzegorz.nitka@intel.com>
In-Reply-To: <20260607183045.1213735-6-grzegorz.nitka@intel.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5394:EE_|DSVPR11MB972630:EE_
x-ms-office365-filtering-correlation-id: aef62405-1a08-4e94-5076-08dec57caed4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: oHPue7anPnyPO+F7o89ksa7tNM9jGbDViHgG7rDxIxAbl4K9Erkkoxkp+RYUt52TB8XA+P07yNOrD7msZS0UGBvrR6UnBMvchZYOHaGEVpnLvidvDxrBNhxGXw0ZNjFvsrmaQ7ovTRvy1/tJaCKeT2uGhrpfezMMwq8Cz+ZqnKhZ9g8W2n8QjnL3BN8rknHMXVqp9n7ElJ/Eg75tcvp4varI84KNfzbDhKYP3IOD+R/zj1FaMCHgk4hLbGrEPycuvt/5j0iYQMdrGi2mEr6UgH39jexwsjYeMuXme7ILqUMyOpv6bK36hKcfjKn5xjhjBFd8Nj+D21gVcRk1XlU3Den4KIrd06HR56aNIjEqondKicwUM+J4ymlSFyq7fGVophijxEEcBTGrvRRR4pOvqHLmG3sVlWvud9r5OWCFWaA0eC1KAXkibBnb72ro5N8VYM45pnprA9zMrvsjDF75nkRMeOBFlf2SSg9/oq/pAOsrb6o9+MJIz3Q9LtwB5dVLWUj9Ol8gleYUKPn53n9NKaOg6k2XO+zdWl+oMeQtuwcWLUzt+1v84KHyQqCpnt3YmhuYyM/u37dTlZDplIvhrHgcwFtahLFxDi6Ypz5au21hbmwczWyxqrRfaQVUJriyA3vYGNp2fnAMNlq6BszWptLkEdsov9THMvGu1p3CjefDtZmghiZqTq0nOCKOrchFqM7M4IZhFzpDA5qdbQWMarcrMahEuJ8RaDoPKqTsLFLk2hoKt5EEERaafY3jugZ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5394.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e3ghc6Zx0AzoYxjrM6xSzO7SoeXHr5BSOfzENYjjjucZ/p4XMLbPHOPlV1G6?=
 =?us-ascii?Q?X/7PaIRBROzTwwWavN09bcVjgrguzirSEulqE4Jhhn1UpMlKWRkVcfPwZybe?=
 =?us-ascii?Q?QzG8uOmpd/4u0lHsJGZADkMVl7TZjBQiZWcMCBdyEC0jfovoOik9LbdNh5N6?=
 =?us-ascii?Q?2VkUJnABAMvfO3PS+leDlGLAkqLbYfg51qzKvj9JcMxdgpyrb8UgkTv5fuTP?=
 =?us-ascii?Q?i7AK3uFpSgY4gksX8A5O4r9oJ0R5J2SIKnZ79a0phePq78DKXD7IBJK6+FNm?=
 =?us-ascii?Q?s58IrKU+UjK9jxynItNXzpM1myxhGzR0n0hdSBQI0SMh3INKfiLu6DbpHXTz?=
 =?us-ascii?Q?PcNjbXZvRV67+mYpIZJ72ygaKlIiCW774xrgrgPa+G5NYv7t6NibWmJH5bSy?=
 =?us-ascii?Q?jOF1QjT4HyevoXjiKfH6jilA6fnMWkepsWKPU6m7Jz0q23lcd1yk52Rxe7U6?=
 =?us-ascii?Q?HmsqGdeo71Zgl0+vV9fSg193yRAzUwHR98zN7EziZ36DI7SeqaIqRDFHh2NW?=
 =?us-ascii?Q?q27jHkOcQiqpp7jQMlAwXhKjjLF0w7Fr/gV6QU4ME3PMP+kZWq5N69gMrwDg?=
 =?us-ascii?Q?FbrHCv2/Lv+bZVxjsu3dR4bjjrpUwLBC0EgEEQCh2XMljJBkHSnYRtEa/mOR?=
 =?us-ascii?Q?g9a4e3XaeeemNzE6Z67PxnWf+d83G1j2yotDoTYPpKi4Eau4t0qqoweyD03A?=
 =?us-ascii?Q?bxB1W31QyTTsoOUItOQVzh2I6SAZbxkQL82ERcCj4YHhhQCqRhbhLzETtwii?=
 =?us-ascii?Q?vo+/iW0Eum+k32W9FXyRwB5LRuI+04PSTgrE42Rq2H7VccOY4otkvSJwuXdU?=
 =?us-ascii?Q?tnIxsgDtm8tLqVYteWR5WxWLCgd6JzpumpPimlFTte/m1TQx0RldKzJ2QoS9?=
 =?us-ascii?Q?Xg0ROgmsJWN5DvGYPs5LItWoQ0kpS4JQMDpMg/H2aSpPyJVpcvVjCM6gE9H7?=
 =?us-ascii?Q?fLy1xg0VSiJZOzlsOn9jxx4A6Kiy7Hd5DCutm2rsVW072Ri1zAhmYQmoDW5S?=
 =?us-ascii?Q?BD1buOIegaO4QSkDI54UgQT/UQ+M1nyEaEB4treiQkW0ZfKTnngX3E5N4JjI?=
 =?us-ascii?Q?BDcZJgOk1ov+vkchgEfuSQ2DQ6tyZF8CuT2HAK4/65gSQ3H0lJZMFhPQtIwN?=
 =?us-ascii?Q?5ge7eYgeLNXAZx2IOOJxFQFSyd68tJ8/HarifyjZRHNzY/dz6iiIwT8sEXJV?=
 =?us-ascii?Q?IMBTq5q9w51EWLXWPTfT8rlWXst2F7CZ4WaUGshH/ikgtKsx4hfHXpB+uSH5?=
 =?us-ascii?Q?v7hnS5jNsIYJ9NefgbmCgGnOyuNIOSlCGnRBGudOHL/mCgODPXNjTPyY9opu?=
 =?us-ascii?Q?Zh0loYIc65ZSyQOdBKT2IDy5RuaIAUEnzjHYY4Ku864CR+1H9D30e8BqK0uF?=
 =?us-ascii?Q?G0JDpaDSLzBGw5NcCUD8hYjADCMyYx+2jiRj+Un4lQ224PbbczWVL8lNplqz?=
 =?us-ascii?Q?6CpfZTahoImXB4lajkx7LDRvrMnk6JJhXkLTFf0aOxAlhHca7oVLXeMXqKrH?=
 =?us-ascii?Q?Gv1yPRcF7TkK0jr4UQS5R7ytLrqJIS3q0Mj9apevq1vuNHc3D1w/my0UwVA0?=
 =?us-ascii?Q?bdsq7bEgWdVzVaSksdqXwTWnM7j1iYhUyMBYdH7+EVNTksX6SWNSjfqy06Sc?=
 =?us-ascii?Q?p1zIOQw2v9TYdKCMEVmqcX7Cg9zBrMRt+aSWQDtJENkxVdzDw0AtdNnPWGIQ?=
 =?us-ascii?Q?/1RFc2W/8EHGggsdE7Bpg+YYk9aC/1TitBT/9xWSdlsc9XIjuD0+c7ZRo8+E?=
 =?us-ascii?Q?rp4CNUuy+pfyN1qJEZOsUMJsquH/YSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rhrdHNthSE6aLhpaVKPw4b8dlr0xxjbBGyFLh6AskGtuSrY5cQYihtUG1IZ0doCnwTNzYI+tW0C+83p5mEaT/T/8UhTU1/Oj/PyBZkaXDAoyWQedQzt//Ilt7/YqKHHiNcyAGGHqCmJu6mFZkl0JQSBA46KqfrbM6qmaDx7g+j55sREPArXvkZ6Af33r3E74LihaAiubcV4ARw9QMSIAftgIHrCK+6U+84arHBgxvAksFSlHlHCeJt9vMrD/zgduh19BgdgH0Nl0I2wgBtOm/9HgKhdQMMvziJa6Vd4akxwtF4tR5Q1H6u5DA+xd7IQa0FtmLAsg199hwoQ6O8aGdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5394.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef62405-1a08-4e94-5076-08dec57caed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 16:40:43.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRs0cO5rtjnwK7V/17B762uYbUjsuK+1r1+4fnOwSMXmcCJJXUN9E4/iz5wsll9le5hlj9bhq2JIDWs0pUlPMT9XfYFapYgInCPW3hQpUMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB972630
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296664-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:from_mime,CH0PR11MB5394.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arkadiusz.kubalewski@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12D5B658E3C

>From: Nitka, Grzegorz <grzegorz.nitka@intel.com>
>Sent: Sunday, June 7, 2026 8:31 PM
>
>dpll_pin_on_pin_register() emits a creation notification for every
>parent->dpll_refs entry, but dpll_pin_on_pin_unregister() emitted only
>one deletion notification outside the loop. When a pin is registered
>against multiple parent dplls, userspace sees N creates but a single
>delete and leaks per-dpll state.
>
>Move dpll_pin_delete_ntf() into the loop and call it before
>__dpll_pin_unregister() so the DPLL_REGISTERED mark is still set when
>dpll_pin_available() is consulted.
>
>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/dpll/dpll_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 80195f3a84f3..58034be07080 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -1036,14 +1036,14 @@ void dpll_pin_on_pin_unregister(struct dpll_pin
>*parent, struct dpll_pin *pin,
> 	unsigned long i;
>
> 	mutex_lock(&dpll_lock);
>-	dpll_pin_delete_ntf(pin);
>-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> 	xa_for_each(&pin->dpll_refs, i, ref) {
> 		reg =3D dpll_pin_registration_find(ref, ops, priv, parent);
> 		if (!reg)
> 			continue;
>+		dpll_pin_delete_ntf(pin);
> 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
> 	}
>+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
> 	mutex_unlock(&dpll_lock);
> }
> EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>--
>2.39.3


