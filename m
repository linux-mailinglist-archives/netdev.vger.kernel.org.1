Return-Path: <netdev+bounces-112569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173AD939FA7
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D561C21C8D
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26814E2FB;
	Tue, 23 Jul 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVFBsEn+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8514A4DA
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733679; cv=fail; b=m/BVhhyA257uKX/8d2VosxRudSif4okeHJZQBuy8XQBTfBag1foohO7Up01JFWv1hjuWJYLFylcuJi7QC5pur6VaKZ7Cweasqg8Xi2EUASM9mqXpOXOeeuMtAhrC/xvZS9+LW9PQfkT1JHcdqqaLaU5kiDcwSdecPq+TZIoXMR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733679; c=relaxed/simple;
	bh=amX0EmkXEd64ij/6tPWgqooLWw/j/ue1NP8IxvEqHEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bBjzd4hbv7ck0owrmaymnM/i2bA3jwzpbeIXRsef66CLlTE5kvRu9EVX7zG05Q/mH10ypQrB5Mq5DjFbkhc973V1YLdESVaeOgXMqUqeKxo8+5gZ/wXO3DXI1XBEbRMV4DhbTE87DE98Y5e+SnUJJ6+NOiY7whJZUdmNRJqiN+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVFBsEn+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721733678; x=1753269678;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=amX0EmkXEd64ij/6tPWgqooLWw/j/ue1NP8IxvEqHEA=;
  b=UVFBsEn+IVBJDhS7tgOi2006Qc50TMM2BcpSXieFtGURd6AH32QhXA+6
   QBX0o5AY1+t6DYNXGuhOYv5Uis9z99Ehbl5GC2+SogV1oPpCQVj1pojrl
   842ksSrTlzJBprI3gwKe7pprnGU+nXX7ROWu6AcAibbPSsispe2WcazPr
   mbMXq/X16nlVFz3h/2bhWJwBVqW+Hc3HfpqOOVu+wqIIEzEWrDqVU6bls
   TaU6kNhIKmHiwkDdjs3kJ+KdbkTaI1Mt1VkW3ObeQ0KYJN5WLlDs8LDWG
   aG3ekmwM+Qoyw/zmvJ4qiU3+oU3d6tLhdmKr2CV1dcfveGqrVI+Pbp3G2
   w==;
X-CSE-ConnectionGUID: mwxSxOFiS+Oo1V93GCZ1Xw==
X-CSE-MsgGUID: HQ3RUUH8Qpi39X/ZgJbbuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="18964978"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="18964978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 04:21:17 -0700
X-CSE-ConnectionGUID: N5Gz1du9Tm+KlHWy9aGU3A==
X-CSE-MsgGUID: 9wkoJIFfRnWuSA+PdMm/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="51871056"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 04:21:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:21:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 04:21:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 04:21:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 04:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHS90AzMjP3sfuvAWT9sbvMhQYi6SlrJk9ejaq9DVdr4rMQby2/I5V6VFBphCn0r6NML1qQp0nP4zFNeNd717nkl3f2HR3aSzUW6VfEl2/lDVtCftmUDfDZizGwlmn/l6vnTklPSwDQA3mN8a4JQKjV5MEAJgJ2Zuj1Ew5bbhx5vjW59Ug7Ry9pkUkYoH1GOIfvqPs9LqqQg4nWpPQzg8OJS3d3FyiwQbebevz7MT90iPmUIdaBwrdrayBc4LWrpc3c1KzVWGl3+yLD9YgP2tXyjKIkd7SLuRLafekLuet8DmwESvqMSGltn/1OJ/rVRfOQwkmrgMq/nG5CW9Kbikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Peq+AZNHQN85vqT4WHF4nmow2HNeAxxyFrLQgaGbeb0=;
 b=c0tCpSOlJ//JYWgRWo7BqoO6j6Xjwz7by0dvcgQfshLB++Hqc+o9zwsXaOvQa/iN1uPty8B4Yk1TchraaGeKsU5DXraXa0o4ri+lrGHJw3InjLaEHUEXhujpLNUElMZJvPE5WhpQlS+ekFoFumDEA5HkruorT5r4w8Ea/N43ZoAmlj4Z9STUtk2x09S+FI7a/IrmmtrnP7VkhjniIui5HSe4qSaN1TkjzUTfKhv5hy9P6iG8jRyxRui3+Ite197HQJZHwkLqG1Au4GSzdtK9FAQy9SeYtmgHw2vGsYoMYVu0sn43tT0H47vmebAWlTNkuGsemLQlL9tYJKNFlcJz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 23 Jul
 2024 11:21:13 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 11:21:13 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "shayd@nvidia.com" <shayd@nvidia.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@nvidia.com" <jiri@nvidia.com>,
	"kalesh-anakkur.purayil@broadcom.com" <kalesh-anakkur.purayil@broadcom.com>,
	"Kubiak, Michal" <michal.kubiak@intel.com>, "pio.raczynski@gmail.com"
	<pio.raczynski@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-next v5 08/15] ice: make representor code
 generic
Thread-Topic: [Intel-wired-lan] [iwl-next v5 08/15] ice: make representor code
 generic
Thread-Index: AQHauAOoUtzjiWq3k0yjEubO5EL+qLIEdMCw
Date: Tue, 23 Jul 2024 11:21:13 +0000
Message-ID: <SJ0PR11MB5865AB5FF3A7F04093A191608FA92@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-9-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240606112503.1939759-9-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DM6PR11MB4611:EE_
x-ms-office365-filtering-correlation-id: 76633c35-8f2a-4a45-08ef-08dcab098fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iFYgjq7Dqr68LCF0FKU9fRjwR1iEaZc8qa9A71BBzdd69NAjYkY9DsZnxsKt?=
 =?us-ascii?Q?/6un3Ga6PXVJA8q4CX0qyxDAb9WfdNSHtFVAc9W4i0vB9acsUQJvHTTzXZZQ?=
 =?us-ascii?Q?5LHCsDtgHWOFH+mmsE20CTYGyQpBOBxIu+KfonyWU5LIA9LuMxPIhUIMS4Lb?=
 =?us-ascii?Q?G1tN1dMvWgkDaM9T2tE91T+qyssZlqfJ6A6Mj0z7m+mu3iOPWH9Fr8Trtrh2?=
 =?us-ascii?Q?4R4NAAkgDBLLnMGAwiw+G9ODleHowCqzs+iOAtlXrDWcAENXwisc0TTytlzC?=
 =?us-ascii?Q?TzwmTihGG35/FIJ8lfel7marepk/7bZEfDNHiyBkp6WA8mjf98LiRg/m8mSV?=
 =?us-ascii?Q?dnA2abT99KWQ0kr/HiyO9Y90z5IDmmVLKZSmkM9GbtNRj8+l66x6MMx3EU+9?=
 =?us-ascii?Q?C76QNF8IgcFrcbmdWtlXvLeuOACyknC+QWKYh3Zw1sVBFBlQ6YfnLkY8Ay/I?=
 =?us-ascii?Q?0c/OWlm4R1n6b7CEODWfuBPq5kNfYZotNnAcFBGxjUXUidxQfSejGpHYBOi4?=
 =?us-ascii?Q?0x0Aesk1B7K7SKlE3Yd/2W0vCohXDDvAw5WtxIsg1baq+ghxrr67JKlUmRcr?=
 =?us-ascii?Q?3oNhwKYAMMdW8qdjKG/LSCujnBnK/oEgyv4Unwl7uow81Rcdy0I9S3Vxrvur?=
 =?us-ascii?Q?SMs0xnxgC7rHVevQT0+6U+jjfVDje3pS63WGZR/Nv4PqlokZBgyzx1aagoqq?=
 =?us-ascii?Q?rkRYY+fDtNchGa0KiKf8yyYetWvFrJ6Je5xOQy6E2Vk3p8cQ7CDl4g2ohxHM?=
 =?us-ascii?Q?LkqgeYaAx9lMZpzktPGfffrj7OvfkyLbhnJk2s8b8V1pJHO2dfiaiPDXfBuH?=
 =?us-ascii?Q?ZWxjzXc3u9cTl7M9OPkpP1iz7S9AdNWqRD75T3KEtVRwz/HrHGXtxlPllxWR?=
 =?us-ascii?Q?LUK2rKDBfjGrdQlc1g2XPxYDReorm4AEvsTiSzxtCgQ7ADohA/EY1BPXgnpH?=
 =?us-ascii?Q?PT8Ed1f2ZcKpJHFRvv5dQ9LFS6SWeUOqU9kO5OgGbv3eaDLKyyg+SMcjga+4?=
 =?us-ascii?Q?mjL3Blg5UpLW3Yoi7hCQNWnpQXydExHxjqzIQTea09eZeS8ynj0kWtRHAI6L?=
 =?us-ascii?Q?E4Y0LbmSlbcLcQi0hC2MMmd2MHshfpbsHYKr7VX8bx8h1WKIPzFKVkn8HAcO?=
 =?us-ascii?Q?ioGDXt2rNTTTZmxNT9uD6ZPRsA8AHIQ1KqGErR5dty58+CB+1jYX28WKm4Av?=
 =?us-ascii?Q?b+PEWwAaxMzkqs+H+RAJm/RHUymi9g6TIMFI7p5Q4j+ydIgRwXxI01WGfmzi?=
 =?us-ascii?Q?ZQzbo4fZgSo9EpT9uSb4okrVSq9BRjvzy7UrC2/7fTArHvFk/nIL7KERT1Mb?=
 =?us-ascii?Q?C3raEkHu86u7En0IHXXwunb7z5VwPmbDv8EP9i1SyqEWjO7EoXvpGGECgVxs?=
 =?us-ascii?Q?rVWBOWjiiM0cq0yc8fMoQopit0FrbTt5TLmSnkccHaD1Mtx1YQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PbF/DNtjjhI4EYKjBCa/n2BVyQJxLf618U/JxN7uNvgMxJnGNz6sJQ0vvKed?=
 =?us-ascii?Q?fFToRHEVwYhinvmlUsw3k/HPaZG56+ztgnjJdIelMcTpJ3m2QIsYxG6Sp9cu?=
 =?us-ascii?Q?m8KdEXGpRSEGoxIksPzx/EGx9X/i2IPPDqPtYMeyxm3kIKC6QZr5QhbDF4ys?=
 =?us-ascii?Q?f36IOaNkhMfAQWXEEpQqqUoHWB4tyz1XX7ib7LmPU0bGHuZ8Oty/L8f6gedj?=
 =?us-ascii?Q?TVxXvTB0MhaHfDqXsbJRTAeTe9mRwSMta8nGurMDLdnfFJNH7hgp9RVrmM0p?=
 =?us-ascii?Q?CTDf2Cph0/Fusg11ZDY+BQfVvfVN37L0gRYkt4Vq6o2FUDX+kauDf0t120Ak?=
 =?us-ascii?Q?ejWJhg+fJDZEO4vziaADFdaLs/kZFPwV0v2nGYyXEJWdo1ZWOc4gOI4BGhtt?=
 =?us-ascii?Q?TgMiL/Je/ILS1rsF2GDVEVE68bE1/pi0ZvMpi0jZ7w9Xi55jCCEX1Q+bQiOn?=
 =?us-ascii?Q?8JWHmkqElh0r8Gc7tZwK45OSzhnJ733tyQ8WHS31Z5AaLgxkcZpQkPNumoE4?=
 =?us-ascii?Q?9poyNG7Q9b6YJKMDJoICc9Jl9UTvJm4Pd2TRPr5tMu2augjmmz/kH+XCAZu1?=
 =?us-ascii?Q?BsojelLThbRxAvC2AEiImKJMQ5hLEUrH96M7zB/okscEclSQkYnAyxe9mhMO?=
 =?us-ascii?Q?jhfO8S5VtO6oNzSOR6E/O28pymlxL/H6o7XyuRv03gtp1t5SbrUVgaSxBd4r?=
 =?us-ascii?Q?o92FugToP5EGw/ADcGUpvH68sftzd/A3JQhCZoZUKwTj3bC7no6xT+QUTU4Q?=
 =?us-ascii?Q?SEtn+/E+pKwD+WeDaHBQ6A1awUF5Dx1RBq4sz1vH45voPSFtPBUHN9nAkPvO?=
 =?us-ascii?Q?dr/RCmC1xswguxIzTXOmSWWr/zm8QgAJWS5vKpBkeFYkTnBfL9uZnMzhzCdu?=
 =?us-ascii?Q?q5uqBKjU2FZGIY/w8n3sfY+YObdtNSbPjm90WpCU2H+IgjWbBeMyKeBQvaqO?=
 =?us-ascii?Q?XI21SPJ7crrCjzDyyIHuwpcJhXFVapbpCCSpbfMN+rYRINWDr40WypQD9mkT?=
 =?us-ascii?Q?SzoXcrGwqRTIKYwL2abVjZFloTc0YK+jYQAeAoCzAaXR/pxyhLLSA8KPl8K4?=
 =?us-ascii?Q?rFhyzdTd3uxDgwjae5Mc5pZV7GARll9bw1xVfWrFslRQ24BDFpwVARjTl2ST?=
 =?us-ascii?Q?96mJybeXC/nks3AuJsZoiHKpzjwm4EICbHqanA/QmX0C+GMmqVt9J/pTRalb?=
 =?us-ascii?Q?9l8ptIoD2V+Q9TIj7j8jTpBPnIMKxacbglGynzZ0B7RUIB3cZKD2F8UOPBcQ?=
 =?us-ascii?Q?zrjSRkeCJbRHIpQzte3Jm+yxCs3jCJx+uZDhZrxGZrOyZyRqvkWF+WSFV8qY?=
 =?us-ascii?Q?RUKaRjuqZpfuG1bjbY+HU76fhQ8IfMixNSQ8Dpsz5suTp26YK1+bad08ccrO?=
 =?us-ascii?Q?D4xxFEpaya+teKx1Rm5x8lR3ZAOVEPsfBVDm+ePo+sONGtHtcarLFyiiBM80?=
 =?us-ascii?Q?ygZu5+QKo6tDWPIsVjVCzLVNric/E1fSsfv1HPCMGR2hhnbK7VZYdW201yMY?=
 =?us-ascii?Q?owDBCTbfgQIa86bdZK59nk5n6K0XIKT0IPyvYldJk7+JJsMHWeL2oVxJZLb6?=
 =?us-ascii?Q?vK4yQ860k5+BO7/ZakMnNi+QBsyP/2y7TLdHY0mxbZ5oK/4QBmfVyKvureHZ?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76633c35-8f2a-4a45-08ef-08dcab098fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 11:21:13.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dke05K0cbpECznsiBTveaOYV7B+Cch8JlJtsirXGhYdLwKyWDF/N8Vv4zSp9J/Ltp8sQqpj7MEGztqmtB2WTb86b26ECZ43zFAL0/B7b7U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Swiatkowski
> Sent: Thursday, June 6, 2024 1:25 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: shayd@nvidia.com; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>;
> horms@kernel.org; Samudrala, Sridhar <sridhar.samudrala@intel.com>;
> Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@vger.kernel.or=
g;
> jiri@nvidia.com; kalesh-anakkur.purayil@broadcom.com; Kubiak, Michal
> <michal.kubiak@intel.com>; pio.raczynski@gmail.com; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com=
>;
> Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [iwl-next v5 08/15] ice: make representor code=
 generic
>=20
> Keep the same flow of port representor creation, but instead of general a=
ttach
> function create helpers for specific representor type.
>=20
> Store function pointer for add and remove representor.
>=20
> Type of port representor can be also known based on VSI type, but it is m=
ore
> clean to have it directly saved in port representor structure.
>=20
> Add devlink lock for whole port representor creation and destruction.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  .../ethernet/intel/ice/devlink/devlink_port.h |  2 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 74 +++++++++++-----
> drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 +--
>  drivers/net/ethernet/intel/ice/ice_repr.c     | 88 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_repr.h     | 16 +++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  4 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  4 +-
>  7 files changed, 122 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> index 97b21b58c300..479d2b976745 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> @@ -14,6 +14,7 @@

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



