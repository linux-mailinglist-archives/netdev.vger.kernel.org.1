Return-Path: <netdev+bounces-113457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F209E93E776
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210321C21261
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8260454BD8;
	Sun, 28 Jul 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNBq3ZXt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5461B86E7
	for <netdev@vger.kernel.org>; Sun, 28 Jul 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182715; cv=fail; b=XLhHEQEXDN+qmPb9o8MMdYj6b3UAEVArdkgPqS7Y5+XXGx74ajdA8POsWeZC4H4B7r2pO4Fnedt4oZIY6KdYF9JlpWZ7jgEbt+HkCCgQ9UBLgE857HlnYhMbu8TsnOqFa0dcGKAAoELkGhu01+3v5Zl9ZkpOHJ3lo+mBjDWB+4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182715; c=relaxed/simple;
	bh=wIhNjHBxUmxz1T8X1YNoPjkz0I4m6vaO9vnjCvgZU/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAAk6jZeiEhTtVyuwTUd7MnGDUd1bYQ0zQgVfH1ksZdgHDDs1exawpvq9wn+OMGVkOugAq0eUQ94/vtg4zbEMwFlWrBTtq7TBr+eVFPmrctXdqRAp1l4y1cXP0eYXY7X0PSQ8CcQwTRg4mPUc+HPYWsUBeAAEMnFzhBLrt72A7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNBq3ZXt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722182713; x=1753718713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wIhNjHBxUmxz1T8X1YNoPjkz0I4m6vaO9vnjCvgZU/Y=;
  b=LNBq3ZXtgW6DwyNUNQVx+J3lSH99oPSh41PNrWr4T1CCNgcBDlmc1ImD
   V2p+scz0Rlqi48zVWA6hilBONECdn9pruti6uDRZj+2VO22G/Ym8iHHlx
   ppai+gog3Pr+5pW9HqtFnLnbqZuW3muonRor4m39XbxWJ6m3BAKo3jWez
   uZXCdEOT0Xih9UzQDUKnnBZgj0m1ygY1jQ919vuvY6gI5/rPtGpheQ/SR
   R5IBj5SvvD7Wzi2aheogRYtbpYvNjkKHlFm8vVmsboDpyq7pH41EvXGxv
   apd6RVnkbLDtzPQZ+YOn4R7wsrdjd/n/VzQvrU4U2FJSBDYdaoGlL/hMy
   Q==;
X-CSE-ConnectionGUID: NcTAQkTNS1KIfQb+VNyqew==
X-CSE-MsgGUID: awmz6+CTRzS2wydCoaAkmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20108664"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="20108664"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 09:05:13 -0700
X-CSE-ConnectionGUID: I+SoxLzBTmeC192j5et50w==
X-CSE-MsgGUID: LGRXegzjT2aGf+vBQC4ZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="53963879"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 09:05:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 09:05:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 09:05:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 09:05:12 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV8PR11MB8533.namprd11.prod.outlook.com (2603:10b6:408:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Sun, 28 Jul
 2024 16:05:10 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7807.023; Sun, 28 Jul 2024
 16:05:10 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: Skip PTP HW writes
 during PTP reset procedure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: Skip PTP HW writes
 during PTP reset procedure
Thread-Index: AQHa1s1tzL3EkGa9a0e2dNQA/D1iq7IMYeqw
Date: Sun, 28 Jul 2024 16:05:10 +0000
Message-ID: <CYYPR11MB8429F25FD3701D71F2B75417BDB62@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
 <20240715153911.53208-3-sergey.temerkhanov@intel.com>
In-Reply-To: <20240715153911.53208-3-sergey.temerkhanov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV8PR11MB8533:EE_
x-ms-office365-filtering-correlation-id: 1f20f5d2-ff79-4914-e4a3-08dcaf1f0e8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lHgqrpyjDH3LDcwgpLPRHohE98RvZS2pcSaFJcT3dkBm3vmOaIlaMNW7KS57?=
 =?us-ascii?Q?g9Fghc+HaTNrql2ngQg9PBHvE61VxqRyucN59x6RBh+jrxGx7PdHPfpdBdAz?=
 =?us-ascii?Q?eYilOzGi4zldBztTp3xh6g5Gi0a4sl7jxPfhAbvm2+h5czq29AJN1aNGsYsc?=
 =?us-ascii?Q?M3KMoFAJziZowNFlNK1AOQNI78qMhWRma03h9ACCGiCbKI+Can0cCydTq+xD?=
 =?us-ascii?Q?LeWv9vVatvaWoApTiM97dh/vjkRBT7h5cRbrtYnmEjgPY5QdsGCWewWoyI9q?=
 =?us-ascii?Q?vKnjryRxTgXDypqiuELgmHVbJ2aHXBpTfCladM3toVzrnxqNtlKviK/9tjUY?=
 =?us-ascii?Q?0i/gmWAKiWG+mp33JdWXBU1JBA8L4snIwNKX8+2TYRdUbVR+MFPvSJ0Ws5Dp?=
 =?us-ascii?Q?y1XfOZgrdK6uOWAobpHKFHczYqKk1MH3rMieN+7tROe9scOvCRCIMBFPt4vv?=
 =?us-ascii?Q?tUWNQwqdUGKCWNMgVddE32k6Ivlxu/8fUNMGf0O8Q+ocjxeC2aVKKxwkOUG3?=
 =?us-ascii?Q?2NrRruzEaXE1UZt8GF47iQqnUH+YOA1CTNn5bPH3n86YTCyO6B+hCA6bhQsc?=
 =?us-ascii?Q?1QVcLmtUYwkZ2h8BAYvI9IEr1l9AiyNrP8cTl7M/Grs+qN+0+VGKoUVPe6Mo?=
 =?us-ascii?Q?bG3FxNxVrGLmrvHLfv//oREYdrIKqsb73L7SE7PblPShji1xjxwnro94P+wJ?=
 =?us-ascii?Q?vReeT0eyezZpvFr5wT7dwh5OE/soDJkMxygr9zVBGAd3yQPOzin2cXiuh2Lg?=
 =?us-ascii?Q?+tYMyHY2yeyApgV9qTF2nVKD/TBNLKEGHzu8rwRAYI0bf3zdRuNnkhTEqtam?=
 =?us-ascii?Q?v8Z0JB25uFMmGqTu8hfQx2EI5MBnSKKl0Fw+7hylK1OHA3Ecr+Qc2FOIQAbV?=
 =?us-ascii?Q?qz1wrqGHvOAqmYS3rs9YYwLLNqxQGWGutMDb/EeRiKx00W+3Ch85hwcoUdAZ?=
 =?us-ascii?Q?fnDauO2mmWg9f5by4dbD1dJ6HVVRZuuriT/+eFMyBvkE4Zu+dMugfDTk9qir?=
 =?us-ascii?Q?vlz3dc04b7PMUBRX9QUTlbu8f9vdN8XXc64fhzHEtMGOkMXJPDgipO+oUPEr?=
 =?us-ascii?Q?Qt5uwyJ0xdeMp0w4LiBRFArIb/6QMl+Pyxz3/P87KlBnxMWV9K54nAcmQZKW?=
 =?us-ascii?Q?EyYHEDipz08hHI7knnizxNtVHetGIQnKAUkMIgEnj6VT62fpjwLsK7xL3Ih2?=
 =?us-ascii?Q?DnouCdDMTxJceoOPwzVfBnOjnGR1iOrY7AAId9ARtjSsnBFboRZG+v7e+tep?=
 =?us-ascii?Q?zV3DnpP9dyacdKdrXK8mHEevUcOY8qeW+C2/o+V5GDgi9YyDXWsBHrXXO3Wa?=
 =?us-ascii?Q?oyVvQ4W0yiAa5P8Dl4Y007qGPWa2/atOBLUrX36YmJ5BjFAt2dZMpUdtONrB?=
 =?us-ascii?Q?m7q4Y9cvtZ46DDz44ejEbHo5LHzR4x+jyhuTModpgSBBedZwTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XczSHaGxrFsGthbsD6TN+kPbRJ7eriUeLa4rMNaMI3deiWouzlaZnCH3KCpb?=
 =?us-ascii?Q?nKRMzMBYjex4XOOEdMIiOmPTZ4b8EWObkylzZMhZg8HbpJsfpdzP+15ZL8rf?=
 =?us-ascii?Q?EeQzel3shrRvGvz0wasyaGxPn9MdsUtNrzRUHiNFpyXPY8E52CKm9PmOtggT?=
 =?us-ascii?Q?c1/LES88IaFvw+FXfa67plK2evCnn5uMpj0BzGyqDj/vIFAlkBdCmhgAlCB/?=
 =?us-ascii?Q?TmUnpEXKDefObS5UG7jctXVaqSwtZBI/S5tIj6QvNdYjX9luZNwhDP3NB52K?=
 =?us-ascii?Q?olqyjmIPrRDgMQeU8lh9f96GCoONbzKgSwOr75VpqqewqAbELDCPaNTR005W?=
 =?us-ascii?Q?LZl0uEakTsJDduscnE81ZEJLF1hwBpuQDJFfm33m2PFXdIAJkm5ys7uAZ71i?=
 =?us-ascii?Q?xQfI6nUqVTCWWwMNVRLXpwuUUetq5sugrBIr/tO8M153HGpiXS/XRTTUdnND?=
 =?us-ascii?Q?8vX1LdzROybqETQKl0cMjIE3faFEE1K8k5w85lWFtpqxx532essu6AIfh6by?=
 =?us-ascii?Q?jHYTMrXLwxnHrn52WpA1PSKpJ1r6ZeIovs9AoOhM6v/uj5lEEPs3IAbrOwrx?=
 =?us-ascii?Q?xqECyuLjZRsQ9MDvBrK1WansuhH+1RRmPhqtnQWIf3jgTNd7NsnJ4QTvsG61?=
 =?us-ascii?Q?GdnqQEeEOEHhZp1H7USrXNNGhk1Y93IKsF+ejWGFlyIVHqVSNhsbz1bHTpSJ?=
 =?us-ascii?Q?rkGgY635kfxObZkBiPd95qaaNfx8b//px2oOkLUsM5KgQRgQJ8IOzq20RZC4?=
 =?us-ascii?Q?4lpBVlLr+rQOuG3ZWdXQD1ce8SAXR/YFAVVAkSLOQaVvfGxQ56TGRxh2Zz8j?=
 =?us-ascii?Q?5SThrfHTCR9aVn9DLK49cOQZ6HO2tfNksgAPQvB5/ui7oa9yH8qleU8eTp1O?=
 =?us-ascii?Q?pSDaafRYxNx75/nJkDG1AXauC9A17oxlJiWGltobGcfSrud+GvVq3JdljT8J?=
 =?us-ascii?Q?JRkkMFYDJm9b6dlAzf4xHaMlNeNN2wZSVmf5xr48/PBNBFZXEWUBIbx/RWu9?=
 =?us-ascii?Q?56SZr4Es+8iTHO5C8/WW1mIXMB7e7tkFuoOi6XYITvwMZ3yBCyKXzoWkOdQ0?=
 =?us-ascii?Q?kagv2yctupHlObAtyAm5APuSP0nUNhtBSjeNixUxvCSCsEyW9Wb6Dy+j7ZWP?=
 =?us-ascii?Q?lvBdI2hTEIXeTDLwutM7R1aNPYUDy1AjPtfqC35GzHsr+jxwuZnHo1kNEndT?=
 =?us-ascii?Q?Zn4EPv4dGR8PkXQE7/ooae6fdBOqhdhEOB0LCVZkz3oJSsUIBQOSK2EiRPZ9?=
 =?us-ascii?Q?yla30ukSFSE/UkSOeMT5a7FnMWFq0RgXhBDI6kgzhs8ak9+kYxNf7u32uMMT?=
 =?us-ascii?Q?3rURMdu2pjmWfQGhKY4j0IS3ECwXt/TmWlR1f9zjTXkwcLlI3YA3hQSC30AU?=
 =?us-ascii?Q?5O8rey2eTWgnlePlKEuqAOA2KCDbO8bDn0JLMPzgssoxyo0pi6V5XTOWy7IX?=
 =?us-ascii?Q?jLDX5eyFyrPpY0M8N97R4x3XrLCDRep85iLTMYs7GEMN52Owhr3vK2h8U71w?=
 =?us-ascii?Q?Wxt4x3ogyRPRhCiZQPrrBj80jGZOQE+pXf5NZgZn+ifBu0zz7jYyvjZExg4G?=
 =?us-ascii?Q?Qr1fL6XbPY+sjVEEHVNnQT3vrsRRh9PO89fBbwhvVpQFuc9TXUyAVRY9gR6R?=
 =?us-ascii?Q?mw=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT+3ZQnKzckf9bBYCoBWbNzRxVeWQBZEQ8VdqVP5EEpM8W4jX2zxfDD4TwhG7sW7J574lNHX2tvYKXyWXJae1aEtNa3AjpJCsxI2/dlHkgM7OKUccK2v/d65Q2GI0DGj+sPXIkjP32yfkrahhAB+d5XsFjBeViSHmmzN7sErLSRu0BtpJ08EDYyV+DJYmtjwqKLQQTFUAQtywSg8nkUSgN5nWYHdu9oy8I9gT30WbwCgE0jvb7PSvvz4OyS9+SiR2ndZaN7KEjarql//KikqeljH0VWfcBjD8/G8ZZksNy7w+St4HyfP1tO76Y/R47JToRMmwJr2pRzyNQB5CbDc+g==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4kmmxYzLfUWzJEqJAckhN3BBCorxxxeY208XzODDDI=;
 b=fZsphdikEwPAEocs/Fy8EI66frV7jJlI6nMt8g0yxtteRihBXm4kD9CTuZCNa2uzjKmtGMis+XO41ehClp9CITWrCdKWPr7rnbchES3p1jN64gX0krKZJgMXaPQIj12VyX0UclY3zlqYoIiSHoU5QcIv4ug8nJUnwfmhfg7B5lsdVLacSwZ1/UdjmxsLh2bYhBscFjdxnftB41GdB/CU5w6eYmlpEqAnhwfbsefckkOB4LS2cGm5b1IdHIyI1EM69IJsg8zqjsKqciFwKNhosH2EiUPYYUxroG6iBESk2eZ1QZjSBq9oIN+JDFr6bjxlUJAE81JLKe4Jv1ku+RC6ng==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1f20f5d2-ff79-4914-e4a3-08dcaf1f0e8e
x-ms-exchange-crosstenant-originalarrivaltime: 28 Jul 2024 16:05:10.2623 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: GPxHN5w00vKALJ2RHwTw+JAn8CXRNfmHm6LSTr6hhQHM55gN9PlJ8IQPI5Tz4Fiuw2TLHXpPyPLzqdC1q627TgVlo6horqBuAJqVmE9bknFwdnAG+9Vm7Ydpu74qK4D/
x-ms-exchange-transport-crosstenantheadersstamped: LV8PR11MB8533
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
ergey Temerkhanov
> Sent: Monday, July 15, 2024 9:09 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>; netdev@vger.kerne=
l.org; Kolacinski, Karol <karol.kolacinski@intel.com>; Kitszel, Przemyslaw =
<przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/2] ice: Skip PTP HW writes=
 during PTP reset procedure
>
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> Block HW write access for the driver while the device is in reset to avoi=
d potential race condition and access to the PTP HW in non-nominal state wh=
ich could lead to undesired effects
>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)



