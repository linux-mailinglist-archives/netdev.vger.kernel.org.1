Return-Path: <netdev+bounces-219459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1CB41617
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD58548162
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3AA2D8399;
	Wed,  3 Sep 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoZDKFLd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D972D7DF1
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883893; cv=fail; b=KU91PZMhtUaAZ9J9dRZOupDNgZrXJaT88dHAmjfHAYaKiB9xQoUGkkbJzCgEnZMks8Ioes3qyVCYos4l7+r3iGFX6CmSxp+McR6eJEl6I0EkizzR/7aPzilACkk6BO0UiCn2tzVQNk69ae1um1NjHtMylvSTEP+dmXKuLvine4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883893; c=relaxed/simple;
	bh=HpcQcLzXVbW1vzt09yMQMl/xpry8SOdIlYuyiQwJ0K0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMczFGB5eBHQUh5LI2/kYCefhPhFd253i9ztTyGNoDUHEk0dV/TN+hn7bf5CCcearya5xJ19ShPg8uK1tBQupGJy3/NHFp7xENr3d7DxT12o/L1fXqnipBKOn4Ir6MbpUNNu53bXJi1iwZ6Yx3K0g3Dmc/GM7SabkVAoMu5L4hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoZDKFLd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756883891; x=1788419891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HpcQcLzXVbW1vzt09yMQMl/xpry8SOdIlYuyiQwJ0K0=;
  b=hoZDKFLdv0StMbH2MMXpGr5vf4/rGkJWCcHB/NY19OYMcZ3WHVIjcBfO
   L7SRFtPcZdl0oxO8WHatU+f94XkvOoh4TNg5qd0ZUQUANkNgeCcxpHf7j
   qu+8g97aWRuWz4ih9GPQmQTwFjoKYtcv/SPFxHlyEOdYGx5r7alcl17sU
   5s1VU8NgZda/oL/zJJI67TeUwf5V0+dLmq6VISulo5VgDfodV2Vem/UeW
   lgrkEmn6jD6lYhXHbElohaWLt425yGO5jGDo43wV2D20xaD1TQQkj7LLG
   TSZZ99xzxQvV+aCvpmR+R0AarHjHUHuY2rFyCKKtjizaGFZNqG0amie81
   w==;
X-CSE-ConnectionGUID: 4fUMvgI2SN+PN1uocYUr3A==
X-CSE-MsgGUID: I4elJ2lESkOe+gRGCFBapg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59044156"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="59044156"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:18:11 -0700
X-CSE-ConnectionGUID: usW0MexEQAGEO8+5iSoYRQ==
X-CSE-MsgGUID: wSmu522dToGrVCC1Kz5rEg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:18:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:18:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 00:18:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMJ5ysCATDhKrS+mLKlZKtVy1GPEi9nfEfgBp8QDRzSUWid7e6jP3PDW1xrmiHcQC7gVDMZsLeaEvaP1zOSXn3jFnxBXLpiUN/cDpXyCFs8XTxt1ICkBdBWZ6oARiGB7QMy9EnA+4B/ZR7rhCPb/0vaO16q5FX+Twdtx2+bsZjh5ycCx8w8QDV0Voq+c4P4FAurF/oeFOTqwyqOXydWeQl+632AnZqImyUvdg68y8t2b19UsNB6MWShBT1m0KFTVIzEv3NgZ8rNrCSMeQzR/7KcIs5wpXuIs6Vrsor76pcG7Cv6MkjMotPnmKRBZ4RRZsiFWd8fVv73KTl2mHM5RsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqXdlNEjKjUMhRUDjM5oK62uCfGNIoFAyqM49bO8GFM=;
 b=WIpQcOcvHJcN23AQ3uXaFnPJNZChNHfrfcruIL0qOX5RdEpGCsLWVoU8+9lsy/JtGmfAttZaDo41zXI7++a0Od/VatNOY1R1UXwLlZ6f1TsOrZZx5D0Uc73vvaQSF0wWO/1jy6ZMpYhTLWx5QUuh0+U30597y0oCP/ImPMCmYJJI+Wsk2Eisytu/sv7gvGcmrFI1GrS7bxBStW3dssmHA3z0q329Awz5iOP1ph2gVZYghLKvFlu9hr3VMOlvEV92BpwwNwPAsa6iRWKYz3HWRBpauJdSi8U/EqAeq7KiCBTT4ztBAwY9gv72AtTslWf+VGJ/KMoP4jd9WfIVYFo6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by PH7PR11MB6697.namprd11.prod.outlook.com
 (2603:10b6:510:1ab::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 07:18:05 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%7]) with mapi id 15.20.9052.021; Wed, 3 Sep 2025
 07:18:05 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan-bounces@osuosl.org" <intel-wired-lan-bounces@osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"(Meetup2) MTR-FM1-AVLAB1" <fm1avlab1@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: drop page
 splitting and recycling
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: drop page
 splitting and recycling
Thread-Index: AQHcCH0wIKVwiQnJSUel9OyxNh24HLR/f+UAgAANGoCAAaZeUA==
Date: Wed, 3 Sep 2025 07:18:05 +0000
Message-ID: <PH3PPF67C992ECC42A31833C78908719A7A9101A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-3-michal.kubiak@intel.com>
 <PH0PR11MB501328DFC538260A11368B499606A@PH0PR11MB5013.namprd11.prod.outlook.com>
 <PH3PPF67C992ECC2AD31E5DB372B564E20A9106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
In-Reply-To: <PH3PPF67C992ECC2AD31E5DB372B564E20A9106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|PH7PR11MB6697:EE_
x-ms-office365-filtering-correlation-id: ab39301c-7a82-453f-6f08-08ddeaba06ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iqffR+2/Rjc9Wh6MGG1bhfKz814mYZMI6WQo1eMQkj2ON2QXV9Z1QMLRmrAF?=
 =?us-ascii?Q?WVLvjqO77OZJD7EiIJwjiUp1laX19eIp2adbXkN39lAhbgXZQRPuCuinIA4P?=
 =?us-ascii?Q?trE9xMGT7DzQRJ2DoNtJH/g+PK4piWXw+Bh902Hv+rVYMlCneRwha+js+1bT?=
 =?us-ascii?Q?332TWoDy+h976ltsOvRQLapddbsAB9ZbIH5JNza+Qsi6ZptcCYK6vYLsSdvv?=
 =?us-ascii?Q?pyyp++XsbNcp5NwTU9UzKIaft3lzeOF2VpQaO+xc7aUJMAANrN6EsQtl4jRy?=
 =?us-ascii?Q?wrzfzztJNph6hhNqMVlw+Z2YkuMSiNCzkWt5hFS3EcTGeYa1+0UfcrHqtyC2?=
 =?us-ascii?Q?KLnA9h6+L8vs6MWaQW9hgTKdvU5Zp/aL5tv25/ACduEdQxWV2Em8TEeK/BCI?=
 =?us-ascii?Q?EfAMWqyX9To3PpntVxfudSlGYl7CeBYrGMxVQzhUsDQjUzOXFeFnxVkmKgWQ?=
 =?us-ascii?Q?c0lXOUsHxamp0DWIFSo7yD4/R48CGKjRUZXEqQfhLXo7bVF1dzWGMj3Ay+qR?=
 =?us-ascii?Q?12j1BIVONw08acarzPqY28HrDjyYPa4NmVIQ462yWpFlJ6QXOKZmj4I+CiQh?=
 =?us-ascii?Q?471r6quLw9FlvympR78TwUuLhj3KzrfWx6dcxdoDRh9ilmF/UkTuOCstkytd?=
 =?us-ascii?Q?rbiACWB+3WkKW0lFjWyknkl76QOheYPaylQrQQB5XAK2RpmuAAVll1EkKr8V?=
 =?us-ascii?Q?1YGPZNIjy+KfRd3RQIuFQLB4C2F0qz8JJBojXylXGxRWL8aiDujlLRn+jqWe?=
 =?us-ascii?Q?SstCnzOgMr8DHsTwp7APzYNqDcvouufzSyhEKaJHXAF+T7hXXZC89+KoMBhv?=
 =?us-ascii?Q?aOUxZdPJyj5iEoz1UAKjXGhy2ubScKENQlHQ8Cs0DGBoSUhH5V+oLhS5u8su?=
 =?us-ascii?Q?BDD20DL1gV0aT664CLf7YGT0qTWGJ3vjaJaF7B41c04Yic+wGQUSJRTnKByn?=
 =?us-ascii?Q?vjHYfCvF9hF2700KYsqL6xCMJFqD7ibCvPKsnN/x+dZjptQE/QMBGUBxyHPn?=
 =?us-ascii?Q?xzCiu/qduBG9iziy08EYlons/eaT/JRaFUhNe8/gQh/cS6iNjCwZjUbewo87?=
 =?us-ascii?Q?tN35wSGD0MsPkqOG7dXkyLdXmNKAbYD5dkNaXWcEETpXvBSTJZZAYvASZ7Ox?=
 =?us-ascii?Q?fxVk2/OyCt9I6tW+y0KIMx24AOrmc+UiSQcNFkZMdHj12cO4msnpD0BRIF4k?=
 =?us-ascii?Q?QFmeZBhZK69g5kRU0rTCNxSkyhidv2LVzmKqRrmvxbJLjuDNYnCax1L7XlYl?=
 =?us-ascii?Q?Wma0/a7oNbnsXPLI6l1QRd/ylTJXkY9C/qpO4qTKnR1aax5V9PMYJiA7yFy1?=
 =?us-ascii?Q?02djcEIOd2ui2efmJkYUjX+hLZ+aTYdPXzFypbMpGE24m4C5+RMUFUgM3bBw?=
 =?us-ascii?Q?LA/OlBKX3kWnZgWjJ4gjhhrKrJCzxrRHqvm2AFx9cgj0XfvmGV35hTsdvk/u?=
 =?us-ascii?Q?iJAzR+/XxpPBYTRzohvWAyzXqTZRForrVD28IH4hLcGM51EGQyvFOvGqQzEs?=
 =?us-ascii?Q?2iyMVmcg7lN8PlQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GHqAuXsBW2C2WPCkD/fv3tzqa5/ohJ//chmGEfIE5eHHaTmG+h226izpwXRt?=
 =?us-ascii?Q?WPxq9R2+X1zVY8LZy6fcERaAZX6ka6Vc96iENda3u2g1+rTGbFPNH0v4kp7/?=
 =?us-ascii?Q?ZK+10aqu+VsaCAHqayO3Pyu3N4nyVLKIYOXPwiYtXLRzs7sNQGfHW1/Hb0eC?=
 =?us-ascii?Q?PFCW3+w8KYfnNv14zZNfMIvCklMw9JqYXfpdIDtVOGYWQ7EVLrghTCW/sk2l?=
 =?us-ascii?Q?mUEfHo1HE8j8RwlbyQC1LzRZrDW5u9FV3S2fM5lDFUFGUwUM49zyhzyRxqfa?=
 =?us-ascii?Q?YPlGFqrUPGZBO7pmpuRbJSN7ALackeRAuNpk2PtpUVoBFMQi9G0L78GmBVFW?=
 =?us-ascii?Q?f7YbtO/SYXqQNizW8fbGRvuUtyq5zL9fly+v3ZxpIV/xA4yHGBNtMsQ3X7lF?=
 =?us-ascii?Q?PAQ4A3ycIyf9U7TUJPtG+U3DoC79KouNvYFF3RorasFRW2S7n3HJ7DjWKLOl?=
 =?us-ascii?Q?XsWPDBbRc/pTSBIdzLiPaNHR0YKk6bu6hs2DYtuGfjFmI7ZAyddX/c0Ylh4x?=
 =?us-ascii?Q?4kKUdN+geBU+WMPwbCilLjuqjnmx9aGB3kk5ylpwt3j9F0AawC8I3N8zdIty?=
 =?us-ascii?Q?d16QYt8mB5Tsh3wqN5VtahzRCR7Qr+ySlNauBgYzEUxV4aiqkrnIo/LDtrs5?=
 =?us-ascii?Q?Gr1zRLFrvIFU/gEGAhRVsetMCV7tWE3V52FMOtAJstkb9vqc31uXGwCt35Kh?=
 =?us-ascii?Q?BKaJT/p3dY1N09Q7AvT5yW3cfMc/5vTq1lD60GWkQdM2MZz7Jq4Gjl+XbkCv?=
 =?us-ascii?Q?MDXwKqYgs+DfAUEx5KkwW2WfKnLp4nkFo50jANXnU91bG5D6RwXkJxPuZeFg?=
 =?us-ascii?Q?gNL9AuqhHbMBnMQTZbGP6wI13EsWtvzc8WtBD026NhkTaBj164Kdo4sGGPgl?=
 =?us-ascii?Q?TSoQ6YjBqUdGM5cM0W5cyQIvyOYWefJu6DnmE4YEbe7212K7KQtQSmoKSBnf?=
 =?us-ascii?Q?YfQKN7OzhIAX7fzfLBlw4NxMq6DG4g+aiu/snK3A+aBAg6vK7RM1iCj0k93f?=
 =?us-ascii?Q?I/AniDCRsN7WURL6mBkHsVT0ZQsT0JDgecCr2ZjPqd7aaupLRSnYf+M2e7LF?=
 =?us-ascii?Q?D/yzYEDNjSCuuT1EHBeMJXaPfLXgMrghi+U+5rwCPsfncSHL/aNUXpD7GZ2l?=
 =?us-ascii?Q?iT6CHKjobS+g23fC4LIlvlDV1O3neAcNJWLOeLSptDT0fbq4zf63DRCIXDbE?=
 =?us-ascii?Q?hHUf04qZla2qQz+rl/iVvTRTlrAsyROU7fYIlC/cbtwHZs0UsJrO/VJXOYa2?=
 =?us-ascii?Q?OGwPExfw8POVYFbUxrYocud18tRaQjBZLnMkX1BWDqOsXAoHmJVBxjgiijid?=
 =?us-ascii?Q?9uVLdo0QG1UFuPHhf/YPaGHo2JU/Hmd2Sd+p+kV3YC2OR5aA0hBebDIZV/hH?=
 =?us-ascii?Q?zuvwtKDlfsNjVjnsC3ueObrPMncmgWjNiP7tgfx2WHx5u4kXeLeQUchyRFT5?=
 =?us-ascii?Q?Atdr+J6h17IECm/ws0Nj0VXoZpDD/FR5eYmbv6bd4Rz0Hr+CYhcNrB9k5bro?=
 =?us-ascii?Q?9vy4xyANjX7ZfU4fMh+Z5cSmULOJEJ0mAd/90i6ONbhjY3l4lHgaWZ9Nr53m?=
 =?us-ascii?Q?xGR18o41PgDrxDIls5E8ZE+cbeJN0h6gecLclniH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab39301c-7a82-453f-6f08-08ddeaba06ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:18:05.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/MSq1ldcKv+pCoRg9/7Bo1Owba9a1NYvNxVRtWCeYDXTHAmfFg5XDTccpBdFrew9i45c94Ap/nfkvxmZLznqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6697
X-OriginatorOrg: intel.com

> As part of the transition toward Page Pool integration, remove the
> legacy page splitting and recycling logic from the ice driver. This
> mirrors the approach taken in commit 920d86f3c552 ("iavf: drop page
> splitting and recycling").
>=20
> The previous model attempted to reuse partially consumed pages by
> splitting them and tracking their usage across descriptors. While this
> was once a memory optimization, it introduced significant complexity
> and overhead in the Rx path, including:
> - Manual refcount management and page reuse heuristics;
> - Per-descriptor buffer shuffling, which could involve moving dozens
>    of `ice_rx_buf` structures per NAPI cycle;
> - Increased branching and cache pressure in the hotpath.
>=20
> This change simplifies the Rx logic by always allocating fresh pages
> and letting the networking stack handle their lifecycle. Although this
> may temporarily reduce performance (up to ~98% in some XDP cases), it
> greatly improves maintainability and paves the way for Page Pool,
> which will restore and exceed previous performance levels.
>=20
> The `ice_rx_buf` array is retained for now to minimize diffstat and
> ease future replacement with a shared buffer abstraction.
>=20
> Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
>  ---
>   drivers/net/ethernet/intel/ice/ice.h          |   2 +
>   drivers/net/ethernet/intel/ice/ice_base.c     | 26 ++--
>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 136 ++----------------
> drivers/net/ethernet/intel/ice/ice_txrx.h     |   8 --
> drivers/net/ethernet/intel/ice/ice_virtchnl.c |   5 +-
> 5 files changed, 25 insertions(+), 152 deletions(-)
=20
Tested-by: Priya Singh <priyax.singh@intel.com>

