Return-Path: <netdev+bounces-183380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A90A9089D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4FC188E656
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210882080DC;
	Wed, 16 Apr 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALMNLKo5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A507FC0E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820415; cv=fail; b=jv3d/0yv0VbvDZyyTgkVmG/3BdRFfCJwc6+PFqhS/xRQ5cQ2DdPFhHc5exMYoEa+OPQJS61c7ZArmkXOVne246GdtQ5dwRLmL4PAiRbLXwSWK880MVJWABVbc2i7uyGm3mlAEKU4nU6raLx2Tq5w7qhxGFDZ9QoMB+d60SZpVeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820415; c=relaxed/simple;
	bh=fXsELPWQ0fEkVHesKnA3B5YFUtxiCXT8foMY+3eUC1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QTZf3rQfs80Y8lfsr76ceih0YpjmTuoez1BbtXisv2N85rTIRoccv7iYTt9x+GfemCtH9zjsIv4ZuxkZ30k1gRncyoADJuki565Jhi8lxP3h0W/M7fNV7aLdDEvmGXioOBY9Hu4FuYwS7lF2KTjk8g4Qqudn8b3+YF8jmz7phdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALMNLKo5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744820413; x=1776356413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fXsELPWQ0fEkVHesKnA3B5YFUtxiCXT8foMY+3eUC1g=;
  b=ALMNLKo55IQ2nM0vfyX8mV5G+UTnvHxFP80rM73pSk6icWArhjyqKYbt
   8DaC5+uqPdyZB2AAEyRDT/jyAziF/FA0PkUxwyFNOLYTYRa1E+AjMishZ
   CFZ9EcCYb9KklDmLZxo6atB+5bqPav6CoZOOro6oqIIEUkTTJGJIgUQYj
   jqIJTAJyW6q8NHGNHz5D2ziVHQwnfzZ3GBCaUXfgiRwmuJeUk/mPP6fYg
   l76lhT/ZU6bjhvpDHofyldc+ziNnZN5j+MwgNyabYTBze1DRCQ/y9ZYid
   kiMU0wwUIuOutqOHVDr4Cb3mgxaCcmQAP7jUKGUWKAgxIgh9BQotGkFXs
   w==;
X-CSE-ConnectionGUID: uKFHRpzBTrSEPj9HKirLsg==
X-CSE-MsgGUID: 04/8njiESaKL9z+q+TgZBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46544474"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46544474"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 09:20:12 -0700
X-CSE-ConnectionGUID: wECKhkr6RSKzQ2OEWRopsg==
X-CSE-MsgGUID: QxOSs8igR3iZ+FVXmAT3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="153719891"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 09:20:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 09:20:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 09:20:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 09:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwH6UYfzZ7xoC6XY3hMDEU3ZUrjco3prF7tGDt9+IzWK2bBeZ77GPx0qkJYAahTNokmlvOJKhZTuoGzITZKWfzpfg8jmLh6BCxKyL5RKKbLU9lXB1yBf+39zg31F4yxEpV/s4LhSD3c4BOtMI8cZN4xIOMSvhCQI5YWppNAcNasTLpcUfiS38S50EcljNE7qKdGfhsAFTqIXsCSQqs+L0FR3fVgFxOkA03HiV0DHPQwkU9ngWnlgHiX//56GXqenE7VDpEw720eBQ73G4uSYZUO+rq6Ht4FQM+rtyWyfBs1+9eLhL+7YiqUVPOh2BwysN4oEKvT9p0GI/HJp4BtqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umrPas03JBTGIg4m7WJvMhKD+LEYgpjuRxPAkqdPXnU=;
 b=zAcqoJYad8NcqQWhpstvHkFwY2BMLXBD1fow2KVSvpL05GjwPgIiMh2nI3xXVKuajKpTHe37d+NAuqfPhpCjNHGV/3vPtHeNDR3Eo640fNbu8EOR1zNNckZpfIUCuIoUDNeXIY/3AHPGgp28Xo3uScStFOqJ56Oq4oUB6trmYzvprK6ktbxIzfMpCcElsCfL9oozlOWnH4yH5mP/v2U7RcrsCaqAHvkLaJIY8vJrBKAvPBJhw4owDUe08c18pSw/DnYkneXMmyC/uq6L5VrHYYRGEXvmOZ+8e3hFLftTrsMTq+Sd+67LfYqv4YvAbHgXJfsnnRziEc2kQdxYmz9MSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 16:20:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 16:20:00 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "sdf@fomichev.me"
	<sdf@fomichev.me>
Subject: RE: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator in
 place
Thread-Topic: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator in
 place
Thread-Index: AQHbrYMDgiehJkDAyUe6hya1iJbWKbOmFrnVgAA5xYCAACq1YA==
Date: Wed, 16 Apr 2025 16:20:00 +0000
Message-ID: <CO1PR11MB5089214A5CF1D53B4B54CC00D6BD2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-2-kuba@kernel.org>	<m234e8mndc.fsf@gmail.com>
 <20250416064505.220f26e8@kernel.org>
In-Reply-To: <20250416064505.220f26e8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6180:EE_
x-ms-office365-filtering-correlation-id: cbefc7d5-50ad-4edb-5fa0-08dd7d028933
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?URBR2ALKJM6Q2sRIVgez5sT2WmBHZqF+1refBWFsQ2BNrfcbv8rtYhNKmAeV?=
 =?us-ascii?Q?SZAvsxs+x2IAnwQyJDn1OmwSnDoi0GhcmPRd/AC1wggEULpm9eWJGlgQr1Mw?=
 =?us-ascii?Q?djUsGkDa87Yiqf8AzXGY0x7fiBVNa8CyMh7YXdoxCaiRSdztHJo638nI1Mh9?=
 =?us-ascii?Q?uvGojp+6BZCBzc7U67mckV0ZQTHO0Q+RYAfrjjH72sjrCcsCyXPmtRAZLNPW?=
 =?us-ascii?Q?JJxseUKWzJzLNI28/c0O2BI/A/WSrI5YYCo3BNz6NGSn0MQTXgaSwrV9CTyG?=
 =?us-ascii?Q?Mkpt0rqP2KvZUyI2Ewt+yl4XGnMBcK9UP8moH3h3e+kqFXIOAXvRYEmv6VC8?=
 =?us-ascii?Q?PXRld0imXlDX8wNkECch8nDYGiHrGjOlZJXPmI+8/AuCAm8qzAd7aY09ssQU?=
 =?us-ascii?Q?RVxsRsl0ArDW/jL8lMq05HpKXLYNQbnZt5HRPIi1yoTzPq/lDD5EyIQZMXM3?=
 =?us-ascii?Q?v34pIBcosa5P1UuBx4yOamu6AlqijH1rA/UKf/qIcrcAY64lmhttrp/09t4Y?=
 =?us-ascii?Q?d141GnJefwdc74EYK7Wit5/SHoKhkPoKNqgfmCciR6uCjeC5d7hK8QnuVh4I?=
 =?us-ascii?Q?wabY3c4cC43ueZA7u3RFb8owCgedyoDNgfPU+TX1teVsixh06ZSScFVWfXWv?=
 =?us-ascii?Q?hmKl29XrAvjUjGw+EvL3p47nWcV9o6yx78QE8Qk0uLfv47q0FgG6srj27swB?=
 =?us-ascii?Q?VO9q1AmH2TxsG084idATirfIrbn1sEQtciHWSqhFmS0ctxVq1KI4Wj+O8nsP?=
 =?us-ascii?Q?qbEfoPFAyDO1Sf5V25VANxy0tckfiLt9nE3R3H0w+kjbEPfdwbTXrhdGcWQB?=
 =?us-ascii?Q?ketO/vhs6ZFT68l3p2FjxguO0WyT5VFKcoM0UWqWbLmRPvMVthZKNP0v1wWx?=
 =?us-ascii?Q?wdh2Bcyx2dfa3GRrA7NcqivSoGPbDr6rtLOzyYgOYQqH2R9INqHiVWxUQ+lQ?=
 =?us-ascii?Q?tH5pKSFwhnMHOTPdwzEQXlDDThHk1v1k5Z0uO/DvFln/hVXr8ETjSwoHBCmW?=
 =?us-ascii?Q?Km7DBkNRiEU4IB8LmfBmCwtrkWo8KbFBP2T7WZHKonxkkJ7fC8oHYjUsMXP7?=
 =?us-ascii?Q?Wj9r+wUr5qGBH8pXIfDPK5aMa5H/CdIDzYJF3Ug5+vEJOLNQUJ1CvJMBB/IB?=
 =?us-ascii?Q?Da/OfUfBpIP+BJ/krQStn3MuiBgZypwpiP+Za8xv0qcVXVvdM7+maM2mbQgk?=
 =?us-ascii?Q?y8LRfpRAjLTX+KDXgQlGqUKznLs0LxRs8NyTz/8zegmnrWIqdj2sOTgH2G72?=
 =?us-ascii?Q?eETmfRoeNp5OIXXwr9zJ322xDkeVp8xp9gGNxndnjJE7jt/iffZho6eWsJMP?=
 =?us-ascii?Q?Zlqr4IjnGtBbd18iGh4hOsRT3MkE4g8azAHJIdXQP/dB3ZoULrA1+8hUZHTh?=
 =?us-ascii?Q?tocMzkhQR6gsXav27eUCcoA1hUkV2IEWEvpsQOK5TIXaG/vq9/I5RQJ7mPRS?=
 =?us-ascii?Q?QdVtsPvQMEM2ZYLhs0inyxlvWhhu7X/TCDtR8jB3aCTMzVCDokMiQg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IlJ9534PjGyTV400kXc9rhE948dorQa40lpjGhXMtTUi52iAh7IKZgm4U7v6?=
 =?us-ascii?Q?Y0pQ9ZDCef9RAORs0pH6uFkaazDjbX0IexUC/YdfOmoiRusJR9/5joW39+kw?=
 =?us-ascii?Q?GLxXGRBul+icbpsnZctjVnnWesZvf5zZoss4dcvj7O6F/tdK1vNwMDJtknWr?=
 =?us-ascii?Q?cgeIU2tCXVg+f1Iu+05GY6Frit0LnttyMTbT1v+5Ix9GoSC5LygPCDcG6PbX?=
 =?us-ascii?Q?ofxetxQXR2AZ1D2CXHaFIxRi1Uhh36BM7Ot/6b5nRZtGbOarxSh/SCfAuk/1?=
 =?us-ascii?Q?gn4CJ4mcs/mh6G6V71Ch9p428a1XNuUzc3VaVlG0zNRG48FiQiKy/xTlWk2l?=
 =?us-ascii?Q?jw9phro53XHzmKTM7vsbr7NzeL2Rq9aw3JNUvxrQLHfDv9eQ5aVhCBCEqpmz?=
 =?us-ascii?Q?1MeA+jUMy5Nbb9hexl74K9u0bGexP1+V3Ww2tNRHmdjfNr4WZrOvUggGeAX1?=
 =?us-ascii?Q?iScFMHAU7U1DE7q31JIjIh+Rp8KDsd6PPn3RZU7sT5mYELVLLGpPb3HXGaLd?=
 =?us-ascii?Q?cTGaARRiXiCWcSHJwGzu+2T1lbDiS3QO6/WQzUHFhXYgetrkvJL9Exb/q1Hf?=
 =?us-ascii?Q?Vr497LTbFfKbBuX7Q2J3B1vTYtJ0ssnwuunyNgk5is2NxGNTXmN/Dc+UJq1g?=
 =?us-ascii?Q?J4KQ+iVt44oTTFjG1JSpHycxREPT0dAUjuw6lEBYuAW5zQ4/H11YjzzP1rlu?=
 =?us-ascii?Q?/zQgTPEA44xwlHhNg7K9BrXYpnD9hyLY1Ba3Hf2GcvOzP2dwXrYK9pDbJD9m?=
 =?us-ascii?Q?CC2z2nz7JPy9oG91gd0O1yxScLTxS+GxznzEEG61sQ1ANdnQkUzpaK9VndZz?=
 =?us-ascii?Q?GvaOPTPbyq3tsXofLea853rVN7sNLTs4TK4cjA97m4vTscI7A47ksAFF8ikG?=
 =?us-ascii?Q?njCglP7R93mWSg5kGIAkSDOSTWY8eE7uY3vAbh7YGDZxRV0p6ygn5hMihD45?=
 =?us-ascii?Q?6p4bcKxq8L6EzOb4lXqqnsFPcI1cCF+E0LoAOvsWWMKqiDzz+2bZtR+KNhPp?=
 =?us-ascii?Q?hYk10fCsLnyYpvvQhqYeyYLIUeU+hsokXnQ8bufbxad2g0Cqpy0rCAtQV7Lj?=
 =?us-ascii?Q?Yt3IAwA3ozU2ryB+btE8WMANopHt1Nrjv7z8v+OmKos/uHERy99T1PRmVLIG?=
 =?us-ascii?Q?A82mNISz7xc/HT14wyKKTciWUgqpoxvEhqd1aNmxIl6S19X/YqfIuTSTUKvQ?=
 =?us-ascii?Q?ePKEIxp6dk4s1pkkCCUzXffWPQT5xeIkvzjshvoh3GZL3oqUiq4Bshh+oclo?=
 =?us-ascii?Q?Nztno69lpLIP3o4K4mzjuVEf9PZDxUlT6SSt+8HuE4GCyuPME8ZELE7Sh0UM?=
 =?us-ascii?Q?wQ1A3oighWTtXCVBYpYY8MSj3iB6nOzRBbqvvQQqZKmlVBGioCQXq/6l/Bvc?=
 =?us-ascii?Q?Fq9uYwAbI2X7eNcyQIfheEdA8TbIr43LGktii8TK1tFJqXdF88n8jMWLdbXu?=
 =?us-ascii?Q?l0RcEEtVnoNWJAAdqxPG3BMRgn9JoZL8LshmcUPI+zJXcd/Qx+UizZ8EgDUp?=
 =?us-ascii?Q?gWS/PSYJiKfqYXusy+EbIejgCjkE13PRscDtUfuoQ9Mt7GpDyLhwZrUQgbwl?=
 =?us-ascii?Q?f+W3Oh1r/MBZxXXnV0qPUfT5oHSabeYcWABz/QT0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbefc7d5-50ad-4edb-5fa0-08dd7d028933
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:20:00.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKiIC3HLiM+L/cEYIQNCUrfX+eA2KCnnvDUnxHnvz/jtti8OiEZ9sEWQF5NXqrXM7Zkz6bPnafQHLUZKkpPmrLST4kzfm9DvD0F/zIE4VsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, April 16, 2025 6:45 AM
> To: Donald Hunter <donald.hunter@gmail.com>
> Cc: davem@davemloft.net; netdev@vger.kernel.org; Dumazet, Eric
> <edumazet@google.com>; pabeni@redhat.com; andrew+netdev@lunn.ch;
> horms@kernel.org; daniel@iogearbox.net; sdf@fomichev.me; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Subject: Re: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator =
in place
>=20
> On Wed, 16 Apr 2025 11:06:39 +0100 Donald Hunter wrote:
> > >  def put_req_nested(ri, struct):
> > > +    local_vars =3D []
> > > +    init_lines =3D []
> > > +
> > > +    local_vars.append('struct nlattr *nest;')
> > > +    init_lines.append("nest =3D ynl_attr_nest_start(nlh, attr_type);=
")
> >
> > Minor nit: the series uses +=3D ['...'] elsewhere, is it worth being
> > consistent?
>=20
> Agreed, it was annoying me too.. but in _multi_parse() I seem to have
> used .append() in the exact same scenario. Hard to define "consistent"
> in this code base :(

+=3D [ ... ] is more akin to joining two lists, which may technically be le=
ss efficient if you're just adding a single element. Of course that probabl=
y doesn't matter for something like this.

I'd say its fairly clear either way so not sure how much we gain from consi=
stency vs re-rolling.

Thanks,
Jake

