Return-Path: <netdev+bounces-254386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFwmKpNMemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:51:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E22A7393
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3FB9306CEDB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97D836EA9D;
	Wed, 28 Jan 2026 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="POZ3BJ8C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738E369995;
	Wed, 28 Jan 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622279; cv=fail; b=KjqRDbKCYNoHlKNMx2Ctw2nXNUtoxRsiUsLOmtWscqqawAJXsGuf8FhpfMHJLgkAJkDaqHSR+4b6RpprqXa1IQeoQq/Icoaw4jZv6geXfdOKZbqtOzwPSS2gbhi/RIgwgI5CZ+6OhuN1V2+8u6xIIFkEHsgoQM4mgxGSXU96IIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622279; c=relaxed/simple;
	bh=96Zz+RypvdFlCXegrH7xjN/0TLsXHK3TPi1hgU9/rA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VzZfvbLvcnlBesH37QLb8G97zq0uCZUfBKYb8kkyYkstjkQQ0pNJw+rVdn3/zyuEUe0rawTFZy4p/JskX0ld81jSHZPWv8TlZW7H130bwt0vKSBGo2Uty+nM27rTyBWnT511gdELLsVyJzgFq6UbOdE5axlBEeYUlr9NR69IsSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=POZ3BJ8C; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769622278; x=1801158278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96Zz+RypvdFlCXegrH7xjN/0TLsXHK3TPi1hgU9/rA0=;
  b=POZ3BJ8C+vuVWz2RC+49rF7q++PF7ROl9RDOTDRXP7lfZpwTFgY8Lc0I
   yHQD8f9igj+NgNGkB3i0E6/nsFybwbGjoH98C06GIA4BTK+9spWuYxLIB
   v+QhGLep6v2HwDamHlj3hmHqjeZI+kZXwdK3k3qM20p3Fn5yo9eRGRvW7
   zfFaHObCG/v4Sjb3cllc1wyPa05iO2+Hhk5AgfC8YZ9aWHVlPvNqn4hw3
   nd9Po0jAa/YVT5icMEkFwRz5GZXOL1U9s3Rg678ij6tDU5wMQp2wFfT1Y
   f7u/lnNmElJcMFo4PTdiv99ZvtEAS6Xx9NBRmQ1ieFe+U8to+VpYc18xy
   Q==;
X-CSE-ConnectionGUID: cNf7ZnK6SH2xOJ7TSuR4hg==
X-CSE-MsgGUID: pW83FOEKRkWrLaUQg0S42A==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70934026"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70934026"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:44:38 -0800
X-CSE-ConnectionGUID: qHUV+p+ZQiumJy///C6wQw==
X-CSE-MsgGUID: DX6z3SK5TE600lvapObTdA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:44:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:44:36 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 09:44:36 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 09:44:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5PXstnAPeHL3qQy/vvtfAmVR/wXqmbPqKY/3EylEEPvty7e0I92zVbTSlclmepRS6aOuVgPNk6Wn6qqJgSz/G2f7/D2Etme00AsI06loUdZr0Rtp77XFlysbTlzPgQQ6UjrjhQQ6wGgpZLwjaaY5HzY+G5BU9in1RINXSd6ull68dHuxp67MbiNatQdQJdqak85gATGNHZBj3OS97DT8lq/xBtJWDrX669u6QInEQ+pWSq/4AFtEiLyoWRF1APNjul0AyTXesemc+DpPl8VvMKFW2S0q2hFAxI6PpTiWaTt6BSni12suj7f8ivBwjOkRUmCqKwwO6iLM3CFgV0QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96Zz+RypvdFlCXegrH7xjN/0TLsXHK3TPi1hgU9/rA0=;
 b=vNfEeOVA1wvQ3P3P+1st+qoA0wMRizLAdJLDOPR2ET4GAnhg5cVIBM4MPXRxNiCkIqQ7mxjkmeRjgIvnynolfUejnALwrOq2RBjdZkfkFW5Z738DES9EJRVnRcoM/g4LdljqSLB5EjuBUCOiQTQO6/R2+jrrTZJs+zvGLgBlVX/8Eg71Fquy1lTl3/HcvSK0MBVdC3BoxK8/MT1uprq1xqMV9BD8CkahI24hsn8jh6P5mb++ZaVoL8+KxDjzhuHjsyxPA2FMJxNdYc/4A1loE627TuWWWX4M/YG2jqNKLwvI1wsXHOsjjedBucmpu9VtZvsIodLNxxwx5Jj97JiXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 17:44:33 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 17:44:33 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>
Subject: RE: [Intel-wired-lan] [PATCH v2 02/25] docs: kdoc_re: don't go past
 the end of a line
Thread-Topic: [Intel-wired-lan] [PATCH v2 02/25] docs: kdoc_re: don't go past
 the end of a line
Thread-Index: AQHckHZLBouFcPDrT06KiP/rbrreh7Vn2o+A
Date: Wed, 28 Jan 2026 17:44:33 +0000
Message-ID: <IA3PR11MB8986BFC6B235096EDB0C726DE591A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <1784349130a32df07aca486eb88711dd5d21c3b2.1769617841.git.mchehab+huawei@kernel.org>
In-Reply-To: <1784349130a32df07aca486eb88711dd5d21c3b2.1769617841.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH0PR11MB7561:EE_
x-ms-office365-filtering-correlation-id: 7775e702-8b7f-432c-e02c-08de5e94e569
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?S0QvcFhHa2FOQjBiQ1hXaHhXQWlVcWVwNHU4RTByY3FIZUVjMUd2M3NaTjJH?=
 =?utf-8?B?SVQ1YzB0d2ZWaFhua2NLUGo5WjVoQmFMYnpmbWlOOGMwQ0x1bWhYSUJvRytO?=
 =?utf-8?B?UDQxZ2FqM2J6YW5ieWpEa0UwaWdBVzZIVjhVbXFqSjZISlpVanUxQ2x4TFA4?=
 =?utf-8?B?U1VIWWZTQTdaZ2tnaWtvZi8vYmxCV0ZsaG9FS0wyRlVpUmxreXlZY0QwQ3Vm?=
 =?utf-8?B?MFQ5ditsbWVnWGhzeFM2eGJhMGFId1lGZUdNeEJVOXYyM3BaMHpCWGxpSitI?=
 =?utf-8?B?YVJ3WWZNQkZ0Nm9YNHRzblQ0RzFCblVlcjBCeGRKVEgyazc3aDc4cmtiVTZu?=
 =?utf-8?B?QXc1R3RYOUIrcEt2NmJaZmQwL0Fzbmg4ZCtaNDY5SFk2bHFod0VXbC9DQmZw?=
 =?utf-8?B?UGZQVHJsQXhLRU5BdVkraE9yNG1Ob1h5RlNmMzlhUUJ2QU1CQ0pwSDFQS1Fs?=
 =?utf-8?B?ekl3VzlPTFJwR0tYcW1HS1MySTB4R213WUJlZllsR3V2a2RSOEtEdzk5WkpX?=
 =?utf-8?B?VFpicURHSWxUYXZFbkJOc3IwUkV2cFhrVGZpVkpkaXVHRWxqUWlwdG5oemdI?=
 =?utf-8?B?Nm1zcm8rTlp0K3Z0RGJrTURIMWVzUnRCaCs4Y3J4VUZXL1JXNGhqUWxBdTVI?=
 =?utf-8?B?bFYzcWFwQVN6amJmMDJNbmZYYitILzdZbFNoMFllRE84WnBYaUVUSkJWSUU5?=
 =?utf-8?B?aHBnaUZmRHNGWG9KYkdmNkxlbzFUdDFvYVNuaVI1cjM1b3NIQzRvbjNiWVFP?=
 =?utf-8?B?V1U1dEdGemVUZitONmMwVG96MjRmanBnMnVYVUY2cmNvemMvbW9jZi9QNlVu?=
 =?utf-8?B?OUpaRXhLTk0wV3dXSjEyaTdyVjJEM2drQWJwMUtadFZJbDZnSU1HdVJZSUFh?=
 =?utf-8?B?bEVDVTNIcXRVeVBuWXdRTnI2R3JrSlplN3lCZEltMndqTWdXZy8zb2M4MHlV?=
 =?utf-8?B?bDZXODExaDVNdU5OZVUyWkptdm1DMUlNSXhoMFpUT3BCemFJQVVvL1BCb3ZZ?=
 =?utf-8?B?UzNrNGlSM1RBUURuM0xYM0tieHF1TG1IZEhjbkJDQStJNnBBOEFxdzhXSkJ4?=
 =?utf-8?B?bDJSb1E5bVVOLzMyckcwNGRtdllzbmtSRWxURnlPSkVHS3lyaStiTnhKaGR6?=
 =?utf-8?B?VVZPOHBIYUNlZG40eVVwZXljVllXWUxBd2dHbnAzOWN6SGNrbHk3cnJmVXph?=
 =?utf-8?B?TkxMTWluaG9CWEhLdkRqOGI4K0R1WnNtK1o1aGNhSmNjazd1RW96bi9ZYUMv?=
 =?utf-8?B?dlMxdDZyK1VkRmdoWitoMWJzT29HQ0d0QTd3RldsWGx3dzJoN3E0Z2J0TFFG?=
 =?utf-8?B?bit6ZlJTUzBHVW54cEJxdUlzb0lZQ2lFSVJ1Uk0yTWxJSWxQVnQ4NWxZNVR5?=
 =?utf-8?B?MHVZUk1ucTlKbWZFWlhoS0tkcmZOWitOUVhnNDhRaHV6aUdLNVBGMFFjeTkw?=
 =?utf-8?B?R3E5M2p6b1k3S0JiQS9UV0wwZkNoOWgxMU8xeUpaWGpwaVprS0NETGtUVDh0?=
 =?utf-8?B?VzJxMEh1UWxNQmt5YU9uZ0cvNG05VksxUTlFYzdXWWUxeldaMU5YZm1oNHF6?=
 =?utf-8?B?L25TdVpiOGc2NXgyeHN3YTg3a0VKQXlOc1hHOWoxRlNyY0RCL1FhYTJEdisy?=
 =?utf-8?B?MEliOGlwNFpSV1BFZW5Uakp5NFJMM2MvRGp4eDB6ZkczTVRHb3dDRUZPUWg4?=
 =?utf-8?B?Tk8yVUxGaHMzT0xoQklDc0FtWXRPMjNaQzJmcDdYT1dLdXFneDF5eFpBNGZz?=
 =?utf-8?B?S2NneExZY2I5a29Bdlo0KzY2OTk5cDVtbG1RU09IZXVjd3A2R3NqMmN5Z2l1?=
 =?utf-8?B?NVB1YVVxVGU1R0hJOUg3dFBzNWh4My81S2ExbzFNc3RYS2ZzQzBEUTFFNklp?=
 =?utf-8?B?QkgxRUxFam5GdG1OSGQ3QTZKNzdvVWk3ZFNkRk9WaktjSndFaW93NjJxZlhF?=
 =?utf-8?B?MitSM0lma0lLV0xKZjdOQXNFaUJPcUdnZlFBYTJlUjlEb2NyTkNzbG9EcG5V?=
 =?utf-8?B?RG14UGxZRjNlbmFON3ZIWE96ajBTeEYrK1d1ZnR2ZjVGWERaZUdmU0pzcVVt?=
 =?utf-8?B?VGliNUlsbkdiVFdVRFZzREQyYWwxTU9iZU54dExGTWI1VjY4NjZZMjRPNk1Y?=
 =?utf-8?B?ei9qMDFwVmc0RFBwZWFpc1Yvekp1OE9ZK0tlWDY5MFdBdzMwSmEyNDhrd2ls?=
 =?utf-8?Q?i+ew208BfdDGjCiDKsYYhx0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFdPd1M3Rm81L2NSaFM3QndkTm9yaXlYalVRSVhSZFlpSzMyZ3R2THdTM2RP?=
 =?utf-8?B?RStRUlc1NGtFb0VMdmVRY1BySjF1WFJHT2FiVm5GZXRVeVY4KzBHcTFNNE9V?=
 =?utf-8?B?K09ndlVhL1dCak9Ta3BYaDVSSlhrL1B4TEUrMCtCUUp4YWhYaHNkdkVYd2Na?=
 =?utf-8?B?bFdGZlBkYUY5WGdwVlpNY3pTbmlQZ3ZCeVFxNGJId2xydThNdUtETXZPZFB4?=
 =?utf-8?B?cW96VUFiUFRKbktsa20vZGRFcVE3eHprMTJ0RjV0aEI5Y0hWYzVvTlBiZW9U?=
 =?utf-8?B?REU2enoyd1ZGNWFlQkJ1NG82cUNnWWlkMkpOaXozbXIzTEYxTlNFdFdvT2pz?=
 =?utf-8?B?ZDVtb0hSdGU1T1VYZjR4dnpVQ1lwYU01OVZCQ00zM21PQmY2a3JQRHc2UDhk?=
 =?utf-8?B?MWVzMXY4c2JURXoyZ25oV29uYmFodzhLeGNCbkhBVFpIb25wcURNam5UU0p4?=
 =?utf-8?B?TnJSbm93VG5HZXVuL3R2Z3FMMi85YWJXRVdxZnl0T3VLQTZueTBrUE1NMXJa?=
 =?utf-8?B?ZmdpeFF0a252bk5tRWoyOEhqWGZaMkZ3YnFpR1BxalZYd0M4bHFhcmxGTGRU?=
 =?utf-8?B?aEdwRkZ4S3J2c2hNODZ6a2Y5MzhmN0pWWldwVHpYVjVkNkpFVDJEdlc2bE5F?=
 =?utf-8?B?TzJ2L0NnY2VOMTV2WG1rNlhWakJSVEd6bjQ0d0hCK3JoRXcrRklnZGZVWlFE?=
 =?utf-8?B?YWlGTWdTaUlGcU5zejdtZWZCZ3ZueXZNbWxHU2JxTVlrblptM3p2TzR3ZGlD?=
 =?utf-8?B?c1lHYzdza3dzTWd0Ti8wVlJXWDhpU1NxSEx2MHIxMXdhdDlGNjdGWHVYQWY5?=
 =?utf-8?B?TzdQU2Y5K05GMWlNR25YRVRSUzk5THNGL3JkMXZMWnNwVktyTUhRM3podlVC?=
 =?utf-8?B?NjZOZDg5WjJZWmhHNWJNOFh1cnYrWFJ4c3JlR1BYVm9JZ1ZqMjAyRXFOTFdl?=
 =?utf-8?B?UEEwRlUxRy8xakpJMWVjOXgyTnBjVnhHbDdtVlpBNWxpTXhRMjhabjRUVVQ3?=
 =?utf-8?B?STgxck5GcW9xRHRMVjVxU0RvMTJaSXNRbm8yNmhWTHl3dVc0dDdUaFY2bHV6?=
 =?utf-8?B?YUdzMzFTRnNNQ3Rkc3RTaTdZNm9XbWJPaDFJUXk2NGM0Tm5nbU44V0VPeGY2?=
 =?utf-8?B?dmdsWjRKcFBnWHBsRDZNQXJZem5ZYlFaTVN6ay8xczNGSEU4OVNOTVR6WXhx?=
 =?utf-8?B?Y01BWjdxVUhYU0lXUnhlNGRiNmJLVy9XNkRVS00yVUY3WFhpN2NXa3VlR3FO?=
 =?utf-8?B?TGxWSlhrdGplWkY3Z1hsaDg4cDBwSGFEMW0vcTJiSkJYdEdkZWFaQ2pJVnl1?=
 =?utf-8?B?dGMzYVAvUElSOU1iU3VuNU0yYS9yNU9LUU5zRFdnS0hHdE1jdkRUZ3ZBcTl5?=
 =?utf-8?B?M0ZXSDArNVVEaUtwVWR0Y0JpZHcyWUZFeGFaMnpJb0FkenVUQitEZm8xRDVR?=
 =?utf-8?B?bjQrY3ZhUWptWnlPT1RucmJDcGt5QjRpZWpOcWRzUVU1dTlFOGp0TkJTakt1?=
 =?utf-8?B?U1gwaFgyOGg3RjU2WkwwRDJkK0VhZ3czWWZDY3FrRkxiSTlWR080VDBOM09w?=
 =?utf-8?B?bjRGdUVLSXlCSE5oUjFzdUZHb1AxYnNrcml1dGh3T3hqV2dKbFdIWDd5YjE5?=
 =?utf-8?B?TnQ4TWNHUGpSVkhsY1h2UG9aaEhFeVNmL0dKWk9CblBnY3FYaFYzaFJ6QkM5?=
 =?utf-8?B?NzdROU9tc2FxbkYxQ3h1N2diWlNSQkFpT0VhZkZEYzY3TUFveTg2NFZoUHFE?=
 =?utf-8?B?U3NPc0NNNkljQmlwVjJ5d2M5ZlhXY0duaHV1QU10VkhvVU14WlZvV2NjRXN4?=
 =?utf-8?B?VnQyTmZpd1lvd1huZjJvVnlKRzNXYVJ2SDdNOVFNZ3AxdDAwS1NnOEhsQnQ4?=
 =?utf-8?B?aHhGVXVaT3lDMWw1QWVFVE00UGdSSmhRN3FuVXd4M05uSHF5Y2F0Q2ZZZmhJ?=
 =?utf-8?B?dis5WDlHWk5NVVRWajlaeFlyQ04vdUptdjJqWWpqOHl2QjlxUzFhVk9PdHpB?=
 =?utf-8?B?ZjZUZVgvdHJLKzAwZWhTM3grTG9VdlJMRmJENWZDejl6bzBlVEpkRWRUOVlz?=
 =?utf-8?B?ZXNyVEdwSWVCWDNSd0RuYXIyOG1rcm4zc0lJdHQ2ZmtsbXUvVkg1QzFLQlZx?=
 =?utf-8?B?Tjd6TmVHRkFLYXQxa2llZUYvcWE3SzhFQ3pzWk1pZS9hTGp1c3Q1d1psN2tq?=
 =?utf-8?B?TlhqSWg4bW1RVm16V0MvMGJnVWJrUDM1K0Q1Nk5LVUtFUjNkOUVSRXVIMTlG?=
 =?utf-8?B?M290ZXhVMFJINUROZUpPK0pvMzA5K0JnemJCVHdjWTFIUWJMUld0WHppaFRC?=
 =?utf-8?B?Q2ZPeFJMcVQ0TmJ6ZDRhVG1lZXVTR1E1YjVHNkVnRkVFSThGRUd3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7775e702-8b7f-432c-e02c-08de5e94e569
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 17:44:33.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhTdR22i42iYxw68Di9OCdtYeU4CpuGACGWpFeCcaQfHKoOYRWoZA8PnjdwPE+cYU9EZRrHkdGlQNBt+3Bk3zBcZpwyZfd1zcI2OoJXmACc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254386-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 17E22A7393
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgTWF1
cm8gQ2FydmFsaG8gQ2hlaGFiDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyOCwgMjAyNiA1
OjUwIFBNDQo+IFRvOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgTGludXggRG9j
IE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+Ow0KPiBicGZAdmdl
ci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IFBldGVyIFpp
amxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPjsgU3RlcGhlbg0KPiBSb3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+
DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2MiAwMi8yNV0gZG9jczoga2Rv
Y19yZTogZG9uJ3QgZ28NCj4gcGFzdCB0aGUgZW5kIG9mIGEgbGluZQ0KPiANCj4gVGhlIGxvZ2lj
IHdoaWNoIGNoZWNrcyBpZiB0aGUgbGluZSBlbmRzIHdpdGggIjsiIGlzIGN1cnJlbnRseQ0KPiBi
cm9rZW46IGl0IG1heSB0cnkgdG8gcmVhZCBwYXN0IHRoZSBidWZmZXIuDQo+IA0KPiBGaXggaXQg
YnkgY2hlY2tpbmcgYmVmb3JlIHRyeWluZyB0byBhY2Nlc3MgbGluZVtwb3NdLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwu
b3JnPg0KPiBBY2tlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+
IFRlc3RlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IC0tLQ0K
PiAgdG9vbHMvbGliL3B5dGhvbi9rZG9jL2tkb2NfcmUucHkgfCAyICstDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90
b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBiL3Rvb2xzL2xpYi9weXRob24va2Rv
Yy9rZG9jX3JlLnB5DQo+IGluZGV4IDE5ZTc3N2UyYzk3ZS4uYTA0MDJjMDY1ZDNhIDEwMDY0NA0K
PiAtLS0gYS90b29scy9saWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiArKysgYi90b29scy9s
aWIvcHl0aG9uL2tkb2Mva2RvY19yZS5weQ0KPiBAQCAtMjY1LDcgKzI2NSw3IEBAIGNsYXNzIE5l
c3RlZE1hdGNoOg0KPiAgICAgICAgICAgICAgb3V0ICs9IG5ld19zdWINCj4gDQo+ICAgICAgICAg
ICAgICAjIERyb3AgZW5kICc7JyBpZiBhbnkNCj4gLSAgICAgICAgICAgIGlmIGxpbmVbcG9zXSA9
PSAnOyc6DQo+ICsgICAgICAgICAgICBpZiBwb3MgPCBsZW4obGluZSkgYW5kIGxpbmVbcG9zXSA9
PSAnOyc6DQo+ICAgICAgICAgICAgICAgICAgcG9zICs9IDENCj4gDQo+ICAgICAgICAgICAgICBj
dXJfcG9zID0gcG9zDQo+IC0tDQo+IDIuNTIuMA0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0
aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0K

