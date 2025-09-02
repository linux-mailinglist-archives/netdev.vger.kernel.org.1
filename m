Return-Path: <netdev+bounces-219160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F081B401CE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD9E16551D
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28852D9796;
	Tue,  2 Sep 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m07mrhx8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D2D543D
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817807; cv=fail; b=afgBJAmNN90UPxMOT3m2KoMB7Ympxs4k50M1Ok8fXgcn0EdsxXBkr0bxk3vdCy4Su1nAX+5LuUVhzqis2oHu/nCDWPUh9kDmWXuwKLf2Kg1CBhwKr3eMLl5Gom6XCy2GozS5Qhj0lSUDNPSXObOGruKnKzZnhdljIoxqcfUMHDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817807; c=relaxed/simple;
	bh=KG6J5O7PgNmmRpCqsXqj6qHTx8PILH3d3boHCbg3FOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISpp0wf6xLSjmbE1DGSpTj5pQAG0ee++rhIFbRXo4ZszHXxHFDFBOyVxXwwYmv6qkDK9SAJAfY6GCOvD50KvAp5yrkJo7nmHYy39J+TD6XcUey3jnGZ/rlwtT5BPXp/6KmIQyt14my3289sjOihbaZko6Eki0eX6APdbRpfunPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m07mrhx8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756817806; x=1788353806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KG6J5O7PgNmmRpCqsXqj6qHTx8PILH3d3boHCbg3FOk=;
  b=m07mrhx8WdGPjka5ZOKg+jtRNQorFNFnORjfnFKtIxTFjCC0eRU1jwNv
   Zi8rETHJ2H7uDJDr8iluFfIxKT7P0Wfomjv3shNo3J2AzJxQkp93n2m8v
   B3wGIHgrYS82z4/Wruu4s850u/tS9TgFbLdhJ3FY/GR0Ux7taS3pRiWy1
   /FE5/IN0Ae/A6nesw+0BHi7bYaCVCX1sZ8516w6+59Fo3bUyP5qyiIbiA
   V0jSGeKQ8+YLOzefJTqocZrWiFs+G7rwCoXqi1ZFSmVqpr0VY+qYkrgY7
   8w1gFsPt8AqWgqOtxkF81hCsSR7nFBUKOY1sPp2UCjKMSDwKQa4AK5bLS
   Q==;
X-CSE-ConnectionGUID: UO71ALWXRxS4CDESJEMRtQ==
X-CSE-MsgGUID: 1yTqrQCqSZ2PQ+qC6ItRWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="46669882"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="46669882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:56:12 -0700
X-CSE-ConnectionGUID: w+JkRMtrTSulJv8uG1IVdA==
X-CSE-MsgGUID: aGNXGX00SqeOPQ/lEcQCXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="202198093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:56:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 05:56:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 05:56:11 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.85)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 05:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5sxkX7rUdzxFW9CrN0xPZDIgZUAquzvJL8B7RHt+hhd+WUUxPzkud47bg40t0l6vlDLj4VgdtEDzX1dyGOXe29twDnmQBnuWZslXaNWFej8UsPg8cK+g/tVXGk0fEwWMXHhdWo+B4SD1MAJ0PhDsnnBrIJKumPXKjb7LikJCAYe2gdbwley8o7vwu6Wq+9XuPlknnlEkETcqwV7Lbq77e+5PF0xgur4GBYHLtDWigVvyFQwwtRJYkQEcheJ4OZCZ7pAeAVlwFTIb3467pLQyDhcdulH9639gTGT/1qKZBRMaxcINGkQ86RNS2eXiQxKKuWBL2LuOspZQGhA5xdrfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG6J5O7PgNmmRpCqsXqj6qHTx8PILH3d3boHCbg3FOk=;
 b=HJPKV40sF0WP7WND7iiW5HX66L2VIRX7FQUiu8lKJfjhkCW0NR2F5VWKs0AZ+PwEYrhU7mrljMAH4sogb42bXdSHbES1wjYTk5utui6b2VRMfc/nUkR2C+VvRfadef9vLPUjUThdjDviROGN4zCBHloArTRCwkA9Tbk3gu3qZCTFbUc/tkwTv4sbLa3uoduuFUUedt8dRq6ww5V3nl9fVUkZ79Bw5U+elmUR+O8S9na/miXpqEszPatHUd0yh+ncVqtsEOdiQiCMevrt5mVl4uBNhsGqsI/ZaCmVnwvP3B3YwzwaGuzmSruoMKd5NAPW5F+DatUQD9kp1GK9iHaeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5582.namprd11.prod.outlook.com (2603:10b6:a03:3aa::9)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 12:56:09 +0000
Received: from SJ0PR11MB5582.namprd11.prod.outlook.com
 ([fe80::a534:22db:5d37:f389]) by SJ0PR11MB5582.namprd11.prod.outlook.com
 ([fe80::a534:22db:5d37:f389%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 12:56:09 +0000
From: "Kamakshi, NelloreX" <nellorex.kamakshi@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Kyle, Jeremiah" <jeremiah.kyle@intel.com>,
	"Pepiak, Leszek" <leszek.pepiak@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net 2/8] i40e: fix idx validation in
 i40e_validate_queue_map
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/8] i40e: fix idx validation
 in i40e_validate_queue_map
Thread-Index: AQHcDD+AWy6u47tjSkGp8iBk855VO7R/4UkwgAAYHrA=
Date: Tue, 2 Sep 2025 12:56:09 +0000
Message-ID: <SJ0PR11MB55824C5115BEC1595445235CF506A@SJ0PR11MB5582.namprd11.prod.outlook.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-3-przemyslaw.kitszel@intel.com>
 <PH0PR11MB5013AA7A01FEA5A0D5B172A59606A@PH0PR11MB5013.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5013AA7A01FEA5A0D5B172A59606A@PH0PR11MB5013.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5582:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: dd8de5d7-5e0b-4c36-670b-08ddea2016b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?plUrqJO5TBzUjr6uKiuopWg6rSo4v/cCeUOtS03xsntsItJaVWXhoorLAwpv?=
 =?us-ascii?Q?9NXKXybN+g3Ih5dMilWjlLEFbNka4WsiP/2lX2QMksS1JRBx9ojABz4qCLWc?=
 =?us-ascii?Q?kXq2Zek+KD1b36rlK6KcARh6YH+wiXx2bxEyI19YKEjVjgjxX5gyLjQbz18i?=
 =?us-ascii?Q?ylQ3f4FRfX32nojtJYEyJcAgfnNgV1mQa4JEdx3+PXxZ1wvoO8H90jiqL/15?=
 =?us-ascii?Q?X0LmF0oZEiBbPDUbxxaIcEANmLK+US3Y4P7fizKpEw8s4eesuwe9F5FYBv/c?=
 =?us-ascii?Q?56/Ne2gezuiFwkXGCMMkTEND4Kzx3tzHYPicqQXnN14KRV8HznLRIkDxvhoV?=
 =?us-ascii?Q?N+8QkttuH+gQoZt8fcXnWO4uH1G8Y33y7Tzv1mfepBHdcCLL45g5zMD2W9Cx?=
 =?us-ascii?Q?n8HxMbaeA93ExFNEf8tfTXys+R7eHhsPfSLy9XtRRWu0TH9P/ACe3fUDfnqk?=
 =?us-ascii?Q?B7PN9gJTmfSkcMenGfzdxAZi+uunGYqifhwoEVeranOhojhjvHMBpIKrPKPQ?=
 =?us-ascii?Q?DcHNaEJnKMOO5l7QFFpljluzW2FWX3MV7VYgXSocZq3WH38dFFdpIVp3fPs7?=
 =?us-ascii?Q?ZzFE+V1sUyBltpgXR4L8ewTFTWz6ZBmUl0GNna8tZ7gL2hwc9cuKUrfRV4LU?=
 =?us-ascii?Q?BEhscVPK37mFghsu9il3XRX8fJBWnhuKDFoBzQokv3zcqJBdoNCoh2KSjh5R?=
 =?us-ascii?Q?t0dK4YFk57hS13RxJGx01yd4kBJtwwpgCUEULRVfmXKHFYdcIqClrEb9Sbr/?=
 =?us-ascii?Q?c/tlVCtZk4XApsqDE73oXSKyrwPxeV6N60Tg5QTg9HoP8O5xc/Qxu3DBNkDW?=
 =?us-ascii?Q?4P8IyV0Us6HfUSuuOx/VS36XGxQBtEEG26maVBHzk5rPvvyVnIBJR6fiMOqb?=
 =?us-ascii?Q?TVDz1MiB/MdJhAKqFOgY0t1oU8uAuAQniNHwnzgEE8YNaLBcdSdGY53+DYVp?=
 =?us-ascii?Q?3oA+k4cijDfRlrBguT30jiWJWUC0DXzOdknJ5z//zVW38Wg0ppMwXdZtCj0a?=
 =?us-ascii?Q?ncJgvYI3jtNOz/pdkM10rQC3vshcc20QTwfUO+ASHv+aR2RQHTwklKhTwUE5?=
 =?us-ascii?Q?LfRHOijHcZnmuJlOaH9qPlmPoq0wcqumcH2M8IhHZf5L+ruoskS8UQ2kxpUq?=
 =?us-ascii?Q?P+abG2uW+5DRtn5wCPDV2N9WIX2jlCrQoE0khVu/1OYdKDW7f9WXTrDKuV85?=
 =?us-ascii?Q?gO5AahJV0gGDAYuZKTO9UALFQc4XavChnZ/47grAN/MUg/hMOHQ35Xm+wlKx?=
 =?us-ascii?Q?OQrFsrtybyA5BwCvLafQTn0RIV2ruYKhylo8xQPloDKWfGDYV4XO0mPce5R0?=
 =?us-ascii?Q?YNm8evY1Eogwqy+f0BA9matYmC/SWtmHZ1oX0NeIK3uqkfahCss1rBA29s3f?=
 =?us-ascii?Q?eOpEWxJZpFMvGZgWLInKCtYgt7xqe4rMJ5kVHop55pAMV3mgqRtbundVR6RX?=
 =?us-ascii?Q?dN+FjzfYI90QE00oUusq4Qi5Q7mvFhSNX19fS+Efz6s+7nTRKDCtIfA0D5G1?=
 =?us-ascii?Q?tQvzZdBavKXmksc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5582.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SPh6RQPrHvahWmJMk7j/56U4iAyI0nsAPhwM86bTONOPaHGgc1XFyjChZXYk?=
 =?us-ascii?Q?NWdAjBgQ9NHgJoTRxZZqfTjAp69hoLWt0F7c/06AvzzzFyKbP6YsMPvdFDd1?=
 =?us-ascii?Q?GKKlk9+ndQXiJktUIrZUGSh8q7aWiEl7AO34CtNZ19x8SIa06jFuxGAMneZg?=
 =?us-ascii?Q?qwiebKlrVdWBhRY/eO//lvgo+4HQo+OYLFly/8OLYa+djt5fVjD/Tu9rEEKi?=
 =?us-ascii?Q?QNadsah4GU8ry3gG8coZwyafShFm1PDH6z6IqwS0f9fW9Na7Ogw/wHyuljJC?=
 =?us-ascii?Q?QYsmb20Q4gJ+UGRY5Xe38P4U5o1MKgZ0ddBdNc2bFwyBF9rTps2LSCfzz4SM?=
 =?us-ascii?Q?WOhPJx1JNgLwwqOtW+IkGuMF8dO3iN/7MPku13k3GMfR3nRR39mEy6QBtmip?=
 =?us-ascii?Q?AT6Ch51/OEFLrNmguIdz2oXKbVWftxhmt3V7kV86BOLVhEpJnqMpNsOepZyi?=
 =?us-ascii?Q?gy/zalaupY1QB4FK5fvuZRAO6m8chc9GTL/ClkSRdUNrXFJN11omVdZooGAB?=
 =?us-ascii?Q?yRQ2t2zznfBLEVIemtOoCHxaiAZeaicIbW4cpHuAyz+ybdbDDGMncjG6BV09?=
 =?us-ascii?Q?InhhOF0+W7BEJIKWcs6Xz0yfmkSwvncren6Yt6tSvMuzyn53RAnxHGjb5gaY?=
 =?us-ascii?Q?gOlTym7WxqYYIpt65IxxdE2+k8f1WKMRorpyYRw0fjTSOhzOMcI25uJeihs1?=
 =?us-ascii?Q?P6tDVmhXHlMdGHVXnLVZPyHZBEz2UDbfJLzcKY6nai61v4dMesJ+Xe1vszTs?=
 =?us-ascii?Q?OYHEYeyQL6vUSv1XuflVoSg8v7Vpt8OCDqveMGd+m3fqU3AQEgQIjDvrYrKT?=
 =?us-ascii?Q?7jgT+SZfEl39Tcgl9aXvdmKlqDV7GFl/4vqdbAnb20cA6kAVoMas/tmoi66W?=
 =?us-ascii?Q?r8xtlQuS8uuTkI4WMIfgI/XnhSXi5VXHUK8iTadBi8QysZLiXHqYnCAZISlH?=
 =?us-ascii?Q?w6FX1jCisSBav7QAFihX944JfZpcvO1SB8BrRxGca94xsHR0XQ0pp+TlQfq0?=
 =?us-ascii?Q?Ys+wOHd9YGkR3e06jSYlbx5z3u8an+QUdCaz/BMYjuVIwYFNH2aShSGGrVJj?=
 =?us-ascii?Q?NgLCuCWHxHjTT4CZTSJec3kozNgjIqIy+39+KHW6sF94jeM8V9GIvBgzU031?=
 =?us-ascii?Q?yBfLRnvzWx2P/9LDbB1KSHhlZXu8mC9NMRcvjtYILZaOSE6SS0fnKGE3+J7I?=
 =?us-ascii?Q?6+7EQpsQ0emetlSx5eas1e8IpW/tY0I8cvg8BL6/Iub/q/5wPbbHa1XDlVpJ?=
 =?us-ascii?Q?i3hVV3gpfNsrbXs4FzLtiSGNwp6AKWFzsR62vR4acryMlicJ0z4KXbnsVQZQ?=
 =?us-ascii?Q?h102YkvGYbrDRl+yw0kdsM/+V3l0sEKPyKH5oqyQsYku1lMyGrQ/84s7b0V5?=
 =?us-ascii?Q?GmSAOvtV35/x3DBVXVRcqpBIpPy2JiOPhrvfecsspbARYaiO3rJoTGrk+syI?=
 =?us-ascii?Q?Kj5OR2nkYQgf7qy7aA4mhkLGKjiePzpU87vadXBhQnxo4tHjMjGxKHfiP8m2?=
 =?us-ascii?Q?Rpzwcm+tr//Mwbu2fgQsFxGzC62BFp1BcH3WDRKX/ukPLd3//yc1hS9lIsGE?=
 =?us-ascii?Q?fLRZ0Sf1H0UOijBehZUVYj9wAtW4jm3QWAoM8PoUQSwRq3DmTYQhcyzNkvE3?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5582.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8de5d7-5e0b-4c36-670b-08ddea2016b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 12:56:09.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeyO8SgnKRf7cwhSSUZZZKqBmbzdfGiEWCqhXEw8p6L7dbNRwqUtMHNiFFq0xdlHTDtGc68Oj/+R+/I5ItYDW3tLUJ9pr0csH+O+lKEFf1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Prz=
emek Kitszel
Sent: Wednesday, August 13, 2025 4:15 PM
To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen@i=
ntel.com>
Cc: netdev@vger.kernel.org; Greg KH <gregkh@linuxfoundation.org>; Kyle, Jer=
emiah <jeremiah.kyle@intel.com>; Pepiak, Leszek <leszek.pepiak@intel.com>; =
Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Czapnik, Lukasz <lukasz=
.czapnik@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net 2/8] i40e: fix idx validation in =
i40e_validate_queue_map

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Ensure idx is within range of active/initialized TCs when iterating over
vf->ch[idx] in i40e_validate_queue_map().

Fixes: c27eac48160d ("i40e: Enable ADq and create queue channel/s on VF")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
>

Tested-by: Kamakshi Nellore <nellorex.kamakshi@intel.com > (A Contingent Wo=
rker at Intel)

