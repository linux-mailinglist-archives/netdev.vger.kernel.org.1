Return-Path: <netdev+bounces-192181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FBDABEC6F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E97A801F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0E2367A5;
	Wed, 21 May 2025 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRh4N2Tl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031EF235062
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810075; cv=fail; b=tmL/5cFQv92AnYS2sg24e28lMlV/zrzp2Ekw1HooE0Ia0Pj0zusoZxUsbxW57YnrIBe3L86eJIODtTfNMSqeLnCJv7yngc7EBVoOtqPS+OqSrhcuEC3k0yUgdiJrbA/AesuvUgFFL9fAFaahRWFGO+sUJ8KKfboxG1DrMwMR/a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810075; c=relaxed/simple;
	bh=/O2o54lrFsYKx8y81k1TcKNnzkABDyw35SGbSBXP2iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nECEwGWj3eTmMmBhRnuq4BbFl9tdl6nsnWHmdKmJJj1f07MQdSmeO9LEFVfYMvntqH1h+oyo7FHuGf1zLw53hN/ISD2KZ1gmAJK2K3vClsbXtM6koww9sIiIUET4XW30AZZl1TXLZsS3u2HrxJWPZrSRrjL3GKPLKpcLug13OO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRh4N2Tl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747810074; x=1779346074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/O2o54lrFsYKx8y81k1TcKNnzkABDyw35SGbSBXP2iQ=;
  b=dRh4N2Tlcq7Q29K6zJdZh8Zj2VwIGxZ1L/Fb/arPNC9WKdg2JvHtQMRh
   ttaJUv77a3X43Stu1Vwh42ZI8sq0LrFUkz42e9UMFeCCCHQXwv+OBowhq
   8ch73olfmtdtzVTdt84KqKT1JpEWtQlnEudGLh0ZiGfE8q5ODVJWgx7UI
   F1XmTMs8xwbB566mqvmdsWbO0gSE4oKTC6zwbGkD1QYQa/W5M8Rag5SR0
   Y5W4pbJyA0A8HMMp5vSgg6TktERvwDN31xJn/rwFwCJE+OsxDoXn4ZlAK
   l050xMPIzhnltu51m3vRipvYKDu5dlsERJvgUthaA47NDgbGoGYvx/TCX
   A==;
X-CSE-ConnectionGUID: dxCra7HRQkypvkyDP8GHVQ==
X-CSE-MsgGUID: okHXWOshS9+7e5/BSkHvCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49908150"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49908150"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:47:51 -0700
X-CSE-ConnectionGUID: ZPzEZZu+QRKDM2FnFlpH/Q==
X-CSE-MsgGUID: FsyMHk9CTFKCUDDeyrmOOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139777962"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 23:47:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 23:47:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 23:47:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 23:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvnWIzxHE/hqa+bbIT2nyzHD0ZeFj5mXEEO38p0CtLd6A7ybgV6Qe+ktLFiFiC24+H635bz/HQJyLEBwyj6lDXqFkjtbWAM0CkSpOfm9l3wydFVXbFsr6ADFBG1oN74WFvGSPQLr2f7ca1Jdok3NPeXrXV1cS/pbvAwvpPB2rvOreif132sPaA4XH4yTWyIgOMa1T7Y8Q55FlUnTbg3IXdc4GNAprieSLRpnY4O10ZubJllcraR+JT983Ml0TJJb759aXGG5THy5C2sn9DuEZCnN5gFzVOlMz1LxH406In+90iTrnH08jhWSGd3bZ0XdYTp/tSl3GRukCmHFjsdQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0mQF6KfehLZeWbIrgA2OMu10IuRVYhMAxtLkDBxM9Q=;
 b=jHSR4z7gk9zm7AvY+wHEwGeOGrjQoUc/XZxiaCkwKvxKoSwY+xE1n4UtL/wIhCM9xhUWzyH8rBy/mpwKrnyKaQ0scUDp4Njnd2drKaJmacZHvA0QPe9ESNwdFU68pzfVkwCUz/GY+ydo0z1V77BEMSUosu8ZKdUm+NUlB0kcJYEQxckqOdO7EBt9+q+3SiwuYvpoAmaD0jyftyOY9HbyykiWSa/Gba3bS3uIIoB+/EMOwrcKf6asg1bzSivEjw8zOpRWaE4EW8dbWhJoLfsNnE4Q9fb50nqEx0yhVLLiJE207inNbCkv+q9I/7Pf/T02o4FVbH/PxAlbOCipsWoSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:47:34 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 06:47:34 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v3 6/8] ice: use libie_aq_str
Thread-Topic: [Intel-wired-lan] [iwl-next v3 6/8] ice: use libie_aq_str
Thread-Index: AQHbtaiFKf5MmX5Dw0GSMgJykRjlObPcykxw
Date: Wed, 21 May 2025 06:47:34 +0000
Message-ID: <IA1PR11MB624114A77C832B9B90148BC58B9EA@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
 <20250425060809.3966772-7-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20250425060809.3966772-7-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DM6PR11MB4529:EE_
x-ms-office365-filtering-correlation-id: 185eadf4-47e5-47f4-429e-08dd98335dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?izzbY8psvxmcErojCaW5BfTu2J5MV6KwiOtEjQ3+DddNNbgfJdyFmO57bkh4?=
 =?us-ascii?Q?tezzjv+IrlWSdzQ7YvI/O7d5Pcv9Vk1e1R9/dt8y/bgGIKXoWeQ27EHn+88g?=
 =?us-ascii?Q?mCvsHIswJwB0vZyUsTo2gvXEVd9UaAImVuBiT6NZ4FqYmyqKTkgQo7l0DbNx?=
 =?us-ascii?Q?j2Zs8RZg5gi9olZMWaSXKHKhvK0gnSE1jDX/HLyxqCO+c94KTbl0rplDzWjx?=
 =?us-ascii?Q?lz7u7iektnYxaPWBUf9/pERBTwKCy7HRcX8xEJqtc6y2qfkr830csEj55PkU?=
 =?us-ascii?Q?2J8RXGYmniCVHQjXjfVLyp11Pa9HX7kDrxiv/2pE30xHCHqgAVPDvDG2KiAD?=
 =?us-ascii?Q?si2dJRqgi4k1Hu9PHlSJcX/CTG8CJBGFxdGVh3zUNtNAvO/TQtcRowSHIWvj?=
 =?us-ascii?Q?Rr2EIEbqum7tde8CT16SgUk0upKjJz9Yfg5S3gZDjF2fqJ6WTsyY8xcHcbx1?=
 =?us-ascii?Q?JRNtHtDFwpecQE/slY7AWPREwq5GyIsw48AP+lYjNSEsiRfne8tIrCTBtgj7?=
 =?us-ascii?Q?3vp3A6fP0W81W0R/PmsvksOSfSVnGOhfp1WXZ1O0hW5fmcd6JjT/d9x17dCc?=
 =?us-ascii?Q?rL5qFEw7bMNO6sHTwNJ4pkfmhHNJ5s6h8iXQGxPMilMNYi7ZllsLPLhWXOoe?=
 =?us-ascii?Q?zSlWtNl9XuHc6kKuUz0us8e7V4s0g9JKXJzQ7/nQHR3t2NKFtIBMTYZae2HT?=
 =?us-ascii?Q?hfBHbiB6OkFHRisjaHyaGiKmYQqUpT2BtW2+N3tvFzF813FmrOpk90YhYXOq?=
 =?us-ascii?Q?Wz7IJWOc6qEcP3SZFglODaWIQENlJMzQONuM+igDSk7C7fVTH1p8PwPdcGe/?=
 =?us-ascii?Q?SITYq40wIFSddS4b73DUFJ4NIjfeJkqXqhBk+9ch4tqPsdh8YJFd9CZB4tES?=
 =?us-ascii?Q?CMkeOZfm5BvtD09Z8rHdtOfPdwqoqqX2B7ICTatupmqINwqbAtzuyn/y8KHj?=
 =?us-ascii?Q?aU2L8VPwouBToR2AShgpRFdSUfNoFX35N17O607WRyJGo9xfwocbdrYNNSkJ?=
 =?us-ascii?Q?5KONZY2SjZ2gqW+jpzGNJ7ToshcLYHN/sVOnlDy6fmS9dyyUz2Jyk5rpSJCk?=
 =?us-ascii?Q?4rMi4X4UboYLm+1b/U3+3TaSMUACf3g8+t2Ea0mcxFp4dwsBw75bsj1F7XAO?=
 =?us-ascii?Q?UEGWXF1py3S8SSwmD3lQ7DBXgJRgiSRSDtw0l6yoOgf3qtxN19sgBuhN3XVQ?=
 =?us-ascii?Q?dgsazPI+WUyRGAg2AeY2zTKD/LfafbiETusNW8evpUrnPDTwb6D3QytE4bHh?=
 =?us-ascii?Q?//0AVuQrxK5yFpc0RM7bj9Sydp5ajTJai9TLip7cnD2vqe9zfjzKK0R6n0fU?=
 =?us-ascii?Q?KWSwA461CaOVKZhxILOZQEt+on412/7p13dp6jjtRqN0y/3KGsvkrFWXT/5E?=
 =?us-ascii?Q?pkw8URI6uCMmpRF2GAH8+RZw1SAbFGSElUnSnnMCUEk/39N1K3tG4BHMcrVD?=
 =?us-ascii?Q?PvWWX0VqcChevLO9JiTT5VJEsEnkTsquksBlhbOvkZHGzKVKTILPdoc7xPr6?=
 =?us-ascii?Q?nBa2wuYQ1WXC7a4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P7HcgGsJGSBn98rzmrrynUc46TubEpXx1tYvuEm2KzTOQtTfkdYKFsLBQwR7?=
 =?us-ascii?Q?z2Oiulh7wRdoMMpWAtWk9k5nSYtKnzUbn5Y2G6P4jOxL4ffi503rShaBAUHU?=
 =?us-ascii?Q?W2MxtLLHXlL8vxNNY0257STV9k3Uk9z/QW/mfvsESaCOMQpNzy4+iLiAMIDH?=
 =?us-ascii?Q?m2iL7tAW2M9LxVMrUfNM+Z8si01ZsgMG2b4y1e6cMTioRmFv522pVE1TR+dG?=
 =?us-ascii?Q?eLKQB9T3AZix7T6XcicoUjXPjCI0k10BEhhimUaY3OzjdfuEV1TTMmVq4YW1?=
 =?us-ascii?Q?XpHtnLUui/1H6EUU7iS/AEQzeDEwrAjxjCLp8i+qzm5t06B5GpP9ygx6j9Eb?=
 =?us-ascii?Q?3AAw2ZrfYRMqNLT6v3bEDe/QNQAmDj7cfCaxXwf/tr3f/Yudr7b2EcOXwgbj?=
 =?us-ascii?Q?6Mh49oy/M42tXdOFuDWPeMdlJmrWygHmP1N6iuZzp26w+I1/CQL76HU2atlb?=
 =?us-ascii?Q?z4ll9t3Pth0QFDFFvNVk9mghD4KEh754h3laNPGPV/bM/hfSidwTGaqIc+Fl?=
 =?us-ascii?Q?BYgMgUVXcNrvj1hGJ8GhZiDiQhPAXtCOHL9HyJTQqZgr/0/y2lN7+CmohR5I?=
 =?us-ascii?Q?mbOy94vIdOVxp5T6ALOeCZGY+7hOFZGSyybN2HLTmPVYM67+QiLz+hPQHjBt?=
 =?us-ascii?Q?YmPQ33+NJoBZa9mNvHRyFbYFM0CwyEwpzWfPDs4TVr9AJr9r3OF0g9vikSMC?=
 =?us-ascii?Q?3eVfSVmaD0iOqTStH1sHdw/RTYBfZ5QjooPpzfLMBSM6edZzphTx7fxIUGFj?=
 =?us-ascii?Q?p35vJ1yTr3+V+LUkriNQ1wSaaK3qeFklHSTTQFxEuK5K+M6vUzoOFP9FKxOk?=
 =?us-ascii?Q?7z1AVnVEwkAKVCQRG2GNBHXiufFeCeKXLO2CdLIU4LHgyrdTkMXOvwWcRahl?=
 =?us-ascii?Q?ANNY9hxEOqWYg5kiMl7IRw7Psnb0Dc0L2XERgBB0/LeYTGMJnoDeR5V0hOHu?=
 =?us-ascii?Q?KJM32kpj3zb87w1IflU527A7ELRejLBzd1xj4VN8aMkv+IUAcHpY8WB/w4n9?=
 =?us-ascii?Q?P812vbKbcJA6sQM7mCn51PgT30Y/S2XnQPhRlwVnR/9c456cCt6SOU3FMJqU?=
 =?us-ascii?Q?PJIdrwhD3I1h9BhFY9a8NUZltN0F5+6Qj1NNE0AkIJ1a1YRef4TL5BkCpSvp?=
 =?us-ascii?Q?2ByEDF9+dMrSfjZ/mOYKagWRtss0JbA0iXuqFPuqGFAOKPffAaLkhRqQ2JA3?=
 =?us-ascii?Q?WgAeGJiNnVz0lAy0IfdObSRKgwKOWrifznQEHrXVyFdl347/FPsPNkKActZS?=
 =?us-ascii?Q?Nif+4EVSTTY1SYaQIR9JmqqKxNn+4rAz3rqXw4qgTWa1e0AkewElCGNsI4IN?=
 =?us-ascii?Q?EiR0nUce9btnoAVPFqsZBWORWEGp/7T0yCp2eBQrSXoV+9lqKeRi2jmLvDbz?=
 =?us-ascii?Q?qkDzDNMzhJJtDXt5YlIbBNPHMJVnpPC7MktbNTNizTZF3SMb6NcbSaLp1Pg+?=
 =?us-ascii?Q?WRG/HNMinC4HxXJkuXwWwGKqCxQB9JlOxGhdALLJ/ifd+Q8UCuzEqb+mgHYW?=
 =?us-ascii?Q?wuPNk15F+ifNjPS+6dsaAjFkvKH+kSFbLcmkqG0xqHAp0I9d7C7eaXB5uROo?=
 =?us-ascii?Q?6aodjvmQB/5PM2wbCaSRWeNjTDj96uan+zZqLYuV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185eadf4-47e5-47f4-429e-08dd98335dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 06:47:34.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbuyTjA8yLIvYKzbWqN+EYSZlcvHjUpDdlZ48rJvC/SE800vQIy7vvqUxbXp4Pe9QCrrWn/hMkwWXXQBwR1K1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Swiatkowski
> Sent: 25 April 2025 11:38
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander <aleksander.lobakin@intel=
.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Kwapulinski, Pio=
tr <piotr.kwapulinski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov=
@intel.com>; Jagielski, Jedrzej <jedrzej.jagielski@intel.com>; Zaremba, Lar=
ysa <larysa.zaremba@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.c=
om>
> Subject: [Intel-wired-lan] [iwl-next v3 6/8] ice: use libie_aq_str
>
> Simple:
> s/ice_aq_str/libie_aq_str
>
> Add libie_aminq module in ice Kconfig.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> drivers/net/ethernet/intel/Kconfig            |  1 +
> drivers/net/ethernet/intel/ice/ice.h          |  1 -
> .../net/ethernet/intel/ice/devlink/devlink.c  | 10 +--
> .../net/ethernet/intel/ice/devlink/health.c   |  2 +-
> drivers/net/ethernet/intel/ice/ice_dpll.c     | 20 +++---
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 12 ++--
> .../net/ethernet/intel/ice/ice_fw_update.c    | 20 +++---
> drivers/net/ethernet/intel/ice/ice_lib.c      |  4 +-
> drivers/net/ethernet/intel/ice/ice_main.c     | 69 +++----------------
> drivers/net/ethernet/intel/ice/ice_virtchnl.c |  4 +-  .../net/ethernet/i=
ntel/ice/ice_vsi_vlan_lib.c | 24 +++----
> 11 files changed, 59 insertions(+), 108 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)


