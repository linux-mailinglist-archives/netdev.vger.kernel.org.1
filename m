Return-Path: <netdev+bounces-181271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB7A843AF
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B28A57BB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DD28153D;
	Thu, 10 Apr 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M36bjjT2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76301F1505;
	Thu, 10 Apr 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289404; cv=fail; b=cnEpU1vv7WgcDa3eqrCPihvHEsMtOiF/Q9wb7vRcopVIHxVmQagEOn9PzmwPcmSj2YdKo/g+AdDj3aih6ScLIMCryf8JSgqB5QK3Q+tjJdX48LZ24XAb7z+Z7DfBCE571yT8Qbwj4CkSFRGMVBLdX6VmHakXBZ6nB35yxQ0qV4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289404; c=relaxed/simple;
	bh=sDcl5qPeHl9ewaOfycTfH2rn0mmth07nUS3qZCD1ZO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FJgoysznjy+4Ev8oVbAAqgH8tWzzvGgXGAcSfJRG5DjKUw56Epr+l8pKwmgcnQJmnRQho3qLxY7vwybNRVAtYFn+GdwWDTjXqnXsbcjHtO0/KtK5jLvyvO+nFEPb55xTuAmdL/dXjQ/5X0olA3n/asUlbCKfjSoJQHeeXJqT6Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M36bjjT2; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744289403; x=1775825403;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sDcl5qPeHl9ewaOfycTfH2rn0mmth07nUS3qZCD1ZO0=;
  b=M36bjjT2AKTpi6ZjFkMaTdTJKR25fmXeg5taLov2gaQuoPJ4qWP5RVy7
   mu0DBmyUIMDjGOF1C7KFFRn4FWNSJ3jvUy9JAqEVqaBL6SX3GyKNBxlkg
   /Wh4KIZbkkC6PHu3jM/tG4NpgmR68zG/P1z9Mh3SzBERwd9yAPiEF6OS/
   poolzPjmc7Vq9DDTzMCyhw/nRGrMMt/QmlN1mLe7wzDoOplYStbHnYxD4
   jxjN8jy/4I0dXMdyJtLEBMSefpXYhQGdwPJLNRCXIGVnxPbCE+Q/WPZNM
   Bol72M6ERAQzJEAmsl4E+oCpXUHJrRkbJJqhI1tiT3goSALX2FQB5/IXu
   w==;
X-CSE-ConnectionGUID: iI+FfhzVRnWNtu1mq7cypA==
X-CSE-MsgGUID: ktV+Ts2vSDatx7x8SM3sYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="33416318"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="33416318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:02 -0700
X-CSE-ConnectionGUID: HKITun7ZTA2q/mT4DmeiGQ==
X-CSE-MsgGUID: fxnboQFuR2+pOh10pTaG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128810616"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 05:50:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 05:50:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 05:50:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 05:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu7ZTt7XWaHuib+uX1KouP9YGbdHTkYVb+Pi/YoyCBGLhcykzYKTJw2e+vaR+be/yZT8kue5fLgcMgMnUKkD/vx5qOlITVm0K1J9hfqw0kH594V/alDd+3jqSeAAbqO3AAV1uc3doraG6yz7Ctmvjp5x7hAUbi8CpTQqxzZEFmydjX9zTJ3lZrXbN+f7v5W9jqGqKGawl6vKVI3ibmsOhx/UEdaJW3ioo3w6l1WRdq60HNgTxyjtaysnTmvjDCV9EXX9hljyQcr41j0qgoiNmckF0IFdiW/0kOvtKrs+ClqPVuqG/3FtkJy46LxXkR3EvtbllKw5OCzwguhuNTA6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDcl5qPeHl9ewaOfycTfH2rn0mmth07nUS3qZCD1ZO0=;
 b=JXfWhWlVfspuVWAmBdQi2iAXsZUrdqfZiZGWrkcyir/gPr1KHDUfeoHFH++iDZdX30hbBhLuV1OMWdNuD1M2wZ1Dg1+Q52dH4jeG/EEfwJN5dPKQmX0b1Vp3eWVUKc9JYAOzuJ4cAnXxgT+jWonL7EWYJs5CtVB6geH8kJ6mz+1q3GzfQ5Ynx0n9PRqfnsax3dWlCiPm8ZTjyrmjsUgUqLcbN7YkXyWWGtR5IJADatpQYQQFx2Oo/a39oGoGcfSYIn29Z/SUNv1Rk259wTe12Nl9sncC5CtMSPEM41doA2VTaKTa28qBDeqRJFQRaVKAH00CmRxhzYOfVEUbFOchqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 SA2PR11MB5178.namprd11.prod.outlook.com (2603:10b6:806:fa::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 12:49:57 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 12:49:57 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet,
 Eric" <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Polchlopek,
 Mateusz" <mateusz.polchlopek@intel.com>, "R, Bharath" <bharath.r@intel.com>,
	"Mrozowicz, SlawomirX" <slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Thread-Topic: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored
 versions
Thread-Index: AQHbqAc/BanwLnYClUWuIGn9d5U5PLOanuoAgACH+OCAAEM1gIABcR6g
Date: Thu, 10 Apr 2025 12:49:57 +0000
Message-ID: <DS0PR11MB77855ABA47659A0D3829CB3FF0B72@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
	<20250407215122.609521-11-anthony.l.nguyen@intel.com>
	<20250408193124.37f37f7c@kernel.org>
	<DS0PR11MB778531031053B86BC5301CBBF0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
 <20250409073835.5d0e4018@kernel.org>
In-Reply-To: <20250409073835.5d0e4018@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|SA2PR11MB5178:EE_
x-ms-office365-filtering-correlation-id: 5359be02-5291-4295-9397-08dd782e3314
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EPs12++hlFEsnZLg0RwsgTOzCrfzC50Pz2VMg5WEbvGy38TYTiqgZdYV5ZzW?=
 =?us-ascii?Q?KuAimoKsUxioSYSTyW5JFYw3CxfbObYksIoyNdWV8Y2R2fv5PWapycqTvc2v?=
 =?us-ascii?Q?oXwAvuslsrSugop2tnAV6UJsmY5EpqQPPusOrHnfYOy4mgV2+YH/kVwud1Ji?=
 =?us-ascii?Q?qbg3g5qanuLUmORGli8rqAn3VogYs0gExRtgaQVikZoC82BPSf+Y6MrxfBiX?=
 =?us-ascii?Q?wmMq9tVJ0oIYcLDR00rfgU5A1W0HnPCA6TC8yE11OVm8A0zNcYdZ4XLs6gBC?=
 =?us-ascii?Q?c0VlA0y8ZGrq74HggrfPKvYsa56A7UEy2pQAIJ+P/gIDIAWisANurhTfOv+I?=
 =?us-ascii?Q?+2QlRYBsV+EDrjF5tBj9lESwFHULPjiwL+/omYTkMYs5pyXATsccoquVX0dt?=
 =?us-ascii?Q?O23EL7T2WJcH1IDoeixmOo1TOXzVp/ZAnoTWCJLzOMQqyL7q1ayITRAYVa8k?=
 =?us-ascii?Q?0nUXuRe97IUGGXR7or2H/OJ44XxxtWgPTyGN2aSdKAr98Q8qDWBmQSVv6ErP?=
 =?us-ascii?Q?D4t1IePEHW5GoxpBTouAG0MXCnSwl1RR5n8klOYp/Q8QmzEukaxMclZYqHfZ?=
 =?us-ascii?Q?GYYbUIZOwn+G/At5dEg3n0xdulFr+ASS8MvXM7zg7XGwilYOpTuqX5jxlGse?=
 =?us-ascii?Q?KvfUiRIFYtXbLzwQb3USMFmUD+m8BzWPsOUFAAgAgjqKwC4t+TKVd/ZUepBw?=
 =?us-ascii?Q?kaSZSvOqchdT361mgdyRd5itWiEekFybjNrSfD8/DuqC8/O8L/Jny2USoFsw?=
 =?us-ascii?Q?mtBHWOOMVHQPy/48EIlI/s00SrJiUSD7MCidblAepELOh4JtNruw8/efX5mP?=
 =?us-ascii?Q?bFVAMMJ8ABer/iPTsgnVAUVRu5NHSKWt4QU18h3oMCfHLApHwmsvB3d3B1ov?=
 =?us-ascii?Q?5zmwu7kji+R1a0lDjzfdyztgald1bw/WbG1EOwDIDCuZYbgtrpapkesdTj70?=
 =?us-ascii?Q?+i6itfTHS/mP98/Bj81Q4JY4bMIYmecEpyTaeH1uJZlDd3nAZpzEY0Be+Iin?=
 =?us-ascii?Q?WnKyiJFVK0HbULI0/WXph1TjHpUUd0PrD1racq1gylxFCmi9zFWg9obJz4AS?=
 =?us-ascii?Q?qreVmd8n1/3O2OuFqS2MMb8IEfwIlfJBuA5SqFmACF9+7WI/XlmOIaZSiLg3?=
 =?us-ascii?Q?HFDgX9tzfMfp1phm+KVtx0nxFjHnFaaO5Du5dgiJLNJyw6niDsXI+AazRa9P?=
 =?us-ascii?Q?yW2mad+dzk+YAYYShUU7lZ5yiv0mvwKXbzfDlxF0zvzFzMDzNqRPEciziCXv?=
 =?us-ascii?Q?IUiq6+sIS5keqmPlq/MZAdDjN9yzQFzs1x6kU2TQ/+S5KEVzql2l0UqkRSBj?=
 =?us-ascii?Q?8q4rxd8Fa98iPHaB2QghBrkUEQGs26vU685AZHPxTLX+tjwNTs+bhwyU1zTe?=
 =?us-ascii?Q?DKITpPazYsdWSd4iMK454pqpbYxPsK5gEkYSozpY783hDLXRkE4OE84ROt4y?=
 =?us-ascii?Q?SH5/Bk9YWkX7sQ+bWhJRI3NT/aie/E82?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UZb2YRYuxngzXa+fxToOzrByJ4hT0+UM5kZa7i1I64smi6/ZqIKlp1o7KeJA?=
 =?us-ascii?Q?8GFXVP62cf99WuGrOAwonqFAZFRjjXLvE38AQDuL1OZbmkXJlftyk14fDx9S?=
 =?us-ascii?Q?+x33RpxGHCwJ3EuHGVRJq3Gu+tUP33sBhGts0XLnH9MM0ZYlpPrqh1KTza2B?=
 =?us-ascii?Q?XFXphV7jdN3YhOnplqL/FeuPcnPhmXSJ7lxes5/1M5xuWEK/e7KLZbUnnqvB?=
 =?us-ascii?Q?aS3ryxr8cPOdZCpdO9U1PsbJ7dv1Jo+J2wsYaFQN7WvCTsYJpPz4W9r3cOeD?=
 =?us-ascii?Q?pdx6m+FFVeawnD2eSPo7J5CBV3CmoB5IZPF+5z7IEzlb/RbTGZabiVRfmoWk?=
 =?us-ascii?Q?JAmzYv/eRkGuYl7CUhCcMN/BqRiRURbKfsFtFdPxaEmhx+IwAAvc3JODBQAj?=
 =?us-ascii?Q?N1nXB2UX3Q/eNvwdo6GANlwzIgIqEU+ZsKmczbkY7r2qCE5mEHvneossn/0s?=
 =?us-ascii?Q?QqNctUpLE50E/9rOo467E5NhJXAbUpPd4jflOpvOZfx/NWvpMbnzUhJckjBE?=
 =?us-ascii?Q?vh20dc9JLGt0I/Wvmmb/j3J6MMNqfnPfnn6o++5N7O3Aur3mzcWYmJL3f9Kz?=
 =?us-ascii?Q?rapbNHPHlxZ8ANkD2wbVYpiXwubR+AkNU5Il61bgg+90bQioQM2S35iT3avX?=
 =?us-ascii?Q?0US21vSt9RQPWkQqmTQQAgAQwcBmyur5JeeVzsfehNU+BdqEjEr/4tYOXLWw?=
 =?us-ascii?Q?hrbmOzixsfb7wIx0Ysh56ZkPAPW9P9+P9XeYaIPNIfM2u+0CKIwu+WxapX03?=
 =?us-ascii?Q?qpF/1AjtqJYcXGjmZWxJyrRJcxE/71e5JtjcTZpr7xtp8vt2idZKbayma8F5?=
 =?us-ascii?Q?yKkz52pFq2NlCTSV7/ivE5vgm2t4DCUboqk0SZbQaclwYU2D0JMqOj/JJQIr?=
 =?us-ascii?Q?7pazwkRW3xrOjpMy6PuuA73c6HQguqU6ZOnKLBCZd71zEx7RuatQHHuqEpSZ?=
 =?us-ascii?Q?lk8ansNa3sR8rtIslJn//Vr2czZP++tQYX2wzhqTrF0Nom62TS6lrM+PkJJG?=
 =?us-ascii?Q?2QKYYf1YXqOZtLgKDzOmuIDnrmOy3M5XgDE6Z3Xa0zgjFLxY6HLn2Ssqq/OM?=
 =?us-ascii?Q?0+sLlfrP4hLP7nQL66c+foNvmvMRU/RISJnIlSrxyEX2lrapcJGdUxXI2qdM?=
 =?us-ascii?Q?jKtwWREBkgIfsRz9bZNtLMSataezhdJKG513hM1ROIvUVfSnMr4hYSHyRRXd?=
 =?us-ascii?Q?ZODwXTecmIwnT0InyAxqfNSRqkwNZOOFw1dbcnmW7PLPXHle3KVBgmKO60of?=
 =?us-ascii?Q?vQEN5Ne6b8RbAmbQnsnXmifNvGo/W73TC4yUYoqxS0sV7cOCGg0qVmZuysO1?=
 =?us-ascii?Q?uwdla+TT2DSwYCXfgNpYBhZZ0fEonXXznrwEvBweC1za5y0C3wHkqIW2dJIc?=
 =?us-ascii?Q?kz09NI8eI2C6dovRTnexxReIV4L/qrMCYhIWj1MWz+VP8alIrJ+llzoJu1Ec?=
 =?us-ascii?Q?4qa9yIpOxQgldlS+QZDH5cu+9yZ+keRT8NIZ3sqUNg6O+qGPS5K3MjSja8x4?=
 =?us-ascii?Q?d8tSfS9RavCRMM8jOl3LgsUzSdhFX9QLwHcEG+tslzrlEpudbC7NgvqnIJL2?=
 =?us-ascii?Q?FJkWlh6pjdaL7RP0WxwZWxBKfi25iDxCdeD8+hnX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7785.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5359be02-5291-4295-9397-08dd782e3314
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 12:49:57.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKg6AMRFc7WgQAgLDUWybW6375Z8k4RYBMY8un8ovSjhgNC27Kfjltrge1PN06AZkIxiA6OFYnpfBqVEzQEIt4KLkYlrvTT/AY3a7ppFurA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5178
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Wednesday, April 9, 2025 4:39 PM

>On Wed, 9 Apr 2025 10:50:34 +0000 Jagielski, Jedrzej wrote:
>> >Just to be crystal clear -- could you share the outputs for dev info:
>> > - before update
>> > - after update, before reboot/reload
>> > - after update, after activation (/reboot/reload)
>> >? =20
>>=20
>> OK so this looks this way:
>
>Not terrible, but FWIW my expectation (and how we use it at Meta [1])
>is that stored will always be present. If there is no update pending
>it will simply be equal to running. Otherwise it's unclear whether
>we're missing stored because it's not supported or because there is=20
>no pending update.
>
>But I guess it's not a huge deal if for some reason you can't achieve
>this behavior, just make sure to document it in the driver devlink doc.
>
>1:
>https://docs.kernel.org/networking/devlink/devlink-flash.html#firmware-ver=
sion-management
>

not a big deal, i'm fine with adapting to that approach, will be updated in=
 the
next revision

