Return-Path: <netdev+bounces-186684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96958AA053E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6332D177F52
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949D27A12B;
	Tue, 29 Apr 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xk9RtDNY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF52777ED
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914464; cv=fail; b=QRSpPEHJ0JFGfvi5t/l4VVkLrO8jC/TsXufSb3nFb8ARI8iM+NHSBFdD43CFZHxBdYQWbnIJftk3w4Dfv/YXW3FL3tM7Fvm5nKt7AuasN9gkC00OWQPjCgnoIswJWl45+34N/Vw6q4jbsSJFVRmXbZD5LcHZomloLPxbjVY/5pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914464; c=relaxed/simple;
	bh=VfTB8JrAGiyr6dQ9GSyEq53UUw/DFwi/YqklN5X0tDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9qoDPYTSYxMkNlK806x7fzEWtbqzVfizzw55OtWz2CtQ1SSC9mGTNgrVTbZ6xnXhKr85CkDANyg3cSTRzP4iXwkisz/CUqRJtuHZr0LZT/BgR23xCPA0h7VVjnvg6FvXEsPFzlTznfr4s1Vs+LhOOlyOul0omtmzix6b9t84iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xk9RtDNY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745914463; x=1777450463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfTB8JrAGiyr6dQ9GSyEq53UUw/DFwi/YqklN5X0tDc=;
  b=Xk9RtDNYSgi3h1Nw29MXFjYt6XF7C3ClJh/Cp23yz6dwfDNvmFdRVo9U
   8A6xjKnmhArhn4N7v6dYAw7RyqqcphiPWWTv8xeMmSoAnKVjmoOtxdj1i
   ekUEmYK557N9zS/AGZUTcrqCbhEDMWAsnvOYwtaYQ1DwiflCCe9M3oreI
   ekN04fHntSzcDB7E2XCozGqr74ryN1oyF2IBcXG0vzWjHb60gahl6Nvc4
   7zTLQ90VIhW1jKWz/Gy8912EqxA+by6YDHu0OH6uqhQrNUPRVeQ02FjOP
   L2FBGq3TLSMIaYOuXBhHpoAqfYqCsy7bYbs+yRgerm1BOCSfrKe5mskLR
   Q==;
X-CSE-ConnectionGUID: i/pzM1/TRm+Kdv8yE1zSRQ==
X-CSE-MsgGUID: 66hzTycGS1mkwwSPCHoYqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47538328"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="47538328"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 01:14:22 -0700
X-CSE-ConnectionGUID: BW19rc3vQ5u0cIgzaA15DQ==
X-CSE-MsgGUID: KUCLPzGORp2QEa1JF0vLzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="156981036"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 01:14:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 01:14:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 01:14:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 01:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn6JWP4LX4pLUeKPwQBlKJuQWOdcAew6WiwOHXarBkGTTfeRGctX8T1QtZ4wBlsMdA0R3baqNYCTtBb8rYmEhqs1o0JGdOhrM0Lyowi3OsQYP4oZqL3U39GKcuxBV+1mc51OD1FN7ihZIGfePO9ZhrJI0b8Ue/Q1Qbb0SRcS7aakyTDFBTPBAMYm6K5mQB7WmoYMSO/Ry+jiX5aECUfJQumOrjC63hu7M01A2O/Z7Xe91lXoWLo5IL6BuNMyI+rRKGQmnz1ZXvFM2qa1WBh/N9qjq7+u9taGBaUQAQUuoZZp0GkR9XC1Ja3CXiLr94NtwAnyPs5ld8Bg78qXnq4KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHDiy6x0jztAkKwbPAQ8SF7FZna01r1jl27if0lOylA=;
 b=Hm6FbGHr/s255twkEY7qmj6pkUu3/wO4HOthaSIrvwCjgMUkP9jRut448KrLPbojPMS4RpDT+4ypegb+X+F/O4WdlIVQfEmQXKoCjvQ4p1VvL365CW5+TXzSW94/teraOVd8rzC55titp5srlkwZSnw3HcRrYKChFlBBYGyrdfpf0DJ+5xG+xZFsP8zktrJ+6xNSwvB24XOsBojdIoJDtQE8/Ua30mtZ+Gc/StFTAiC2YQBpvhKvWbfScUxcMtx+uC97cGz08f61f3tT7Q4uXWectYDNoOTFi4xlP7IUlWH8f4xewZ3crQ13TIXPPl46fmODdiZ3BQi0GdcUmtcDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Tue, 29 Apr 2025 08:13:34 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 08:13:34 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Mrozowicz, SlawomirX"
	<slawomirx.mrozowicz@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: devlink: add devlink
 region support for E610
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: devlink: add
 devlink region support for E610
Thread-Index: AQHbquSwjiLODcUmb0mUaNp3GTgfa7O6Zv7Q
Date: Tue, 29 Apr 2025 08:13:33 +0000
Message-ID: <PH8PR11MB79653A235586EFFB5655F6F4F7802@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20250411130626.535291-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20250411130626.535291-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DS0PR11MB7785:EE_
x-ms-office365-filtering-correlation-id: 31511406-7e7e-4001-ecc1-08dd86f5bc3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cc6x9lheItHmvk3KmR647LUD2t62fwZPMeebyORqUdORQNPGE+c62O3nCaCI?=
 =?us-ascii?Q?vAWvU3loMpo801F8hnA8nd5jelaP+sQ6frP6t1RWPp8Er7utHycTrepddTei?=
 =?us-ascii?Q?bzZhnelFZO3VOFnr+XSvU3eFV3Z9ojPcwB52MpazEUvBiUrkiz0DvEkJKRFR?=
 =?us-ascii?Q?sR2DcpzL8Pn8TtKw0g3uuZJ9d/elAyZ8nBxwlCby8zWs+yR9fS+nvfPywBjS?=
 =?us-ascii?Q?r5nRSqQrEFjXwtwcQBYbgke2wEvY9Lpc0ZyoCjsiolYrbvfRSbd+t73q4JHH?=
 =?us-ascii?Q?HoWpB2T/yE1uMbFvdeGOH9w1PatczNfh+mN/t/rXoktnKWXor7GBc5Nfj9/d?=
 =?us-ascii?Q?/NM5zMIxci3VpxINUOL1ggJFOca6odmlVhZJXnqoVi32W3R7FvDuu0yTvZAm?=
 =?us-ascii?Q?jsDWXEaGhfNd4662qK2Y1BU5iSa0qdINKUL+5f+vYt8ckS2uuQ+jyuDXJ3Af?=
 =?us-ascii?Q?V173tPDhwGYbneQMGEKbAB02hMSpQrqx1AcGdA5WIsRDaRYo0VsgymgUpoDx?=
 =?us-ascii?Q?wjTZhgJZ//mPIF+y5wywOrHUCrVUu90ml5RnQKahrMWZ7Vrw59fXHsJuqPgd?=
 =?us-ascii?Q?15RZz/uBqIPtSMOM8TRdTta2aXr7hTTzRHsjzorUwvDS4hImHSR2v3j51BsB?=
 =?us-ascii?Q?dlD/OFsaZ/5Fi0LE5oc+SpbjQqTffD9tMuT8F4G0Lowi7ERF1Wl+UT69WFht?=
 =?us-ascii?Q?HIlZ6IxUDxGOT/dKqIMsKwFLsn946eqjhAoQeJgADpkbHp2hon93WsnEtq8j?=
 =?us-ascii?Q?oWQCmmy0Vv0VSNxL0pqemN+yH6tQiW1YA5Epk5xcjESp5gBj7SQszrpR3tDs?=
 =?us-ascii?Q?Wlpb8e/UaV2Z2R5+jTg8aRHaz1oqz/GV6q3evi8Shbtj64FEv/Uq4Yr3mupJ?=
 =?us-ascii?Q?Qyn/Nfjv8wVS7Q3TCcr5r4uUY8hVySm+ph014BILI4fj4C3enP+1342KfIcN?=
 =?us-ascii?Q?AFSXNYOsOO+bBdRbZSAKjoB5mJrJg3DRcdWXZ2OqYUIoYl5+InxKRBo1aeJv?=
 =?us-ascii?Q?iCRJgqxv94IxWENNNYiJpbEl24+uwh7sQia8cRyzIv/iDOjrqf03pmalj1r/?=
 =?us-ascii?Q?RMq1wV2mzJpeA26ydh0w48N4r8Kh33Cu5KMy9/qYu0cnNMcaTgQ/yuDG0LnX?=
 =?us-ascii?Q?SuyFdycI9YXCN6urRf0DQp6NXkQhvLeCta01CcGQFf3cFri6Bj4/8hyvjDDy?=
 =?us-ascii?Q?ovN/U1M4LbDU0URwlXhQrM4io+PHXJPIWph6WC2LfmjuTtnwXlScCVHsK5GX?=
 =?us-ascii?Q?vAmbHhN1DD3KRD2fyh9QileftVz81+Palz7+xeI6oqpdPnY948DVVqLJP4eJ?=
 =?us-ascii?Q?OoJZuVHLbalSfRgfUQqBWtxyg9Fm1OfFzhDWqyrnkZv8Lsmvn93Kd7UtiidB?=
 =?us-ascii?Q?acNybQdCXkSPeUeWVaqqes7JlrEDryY0omYLQ1eS/bvfSarwEHlh24EaZGL2?=
 =?us-ascii?Q?9gIOz8/lqYPyXIthBJTY25TKui8+f8hC8ERq1ynhf5WTX8zZS737LJfrfMCn?=
 =?us-ascii?Q?R6j4wN9UGv2uGMI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pJ0F4HYLZT7qhLCKLTvb5G8C0xF2KKslCPRjQi1CCEfBmp1HvzE+o1GBluj0?=
 =?us-ascii?Q?rZbE74afiXUqlSvbxoYfklQA+y49p5DZUd9QXLuueUHizHJT/oSa58+R7BH9?=
 =?us-ascii?Q?dUzbX5BDi5e6T/MUQyNrMUTCd7ZDGzz3XxevNTArjvu7PXQ99Jwc0oinm5KX?=
 =?us-ascii?Q?ftFJyDt9U9WeJath66bgK5utPk+/CbJQLWDDmTqUTBzDZe80Gzm992HO7fSc?=
 =?us-ascii?Q?5xhv1Cm9VzCY9z9UGE+RAHbjwXNMHPQBJ0K/leTBRTUM0wW5mK4qKkiXs8jr?=
 =?us-ascii?Q?RH+7S0hk81I/SpUN0hjgktlgTKakFT4UmW4ljvqhRfpxXyXa19Qg5UVmZOZa?=
 =?us-ascii?Q?R/zzxnXy0RO0ENSV7qV9bLICa72Nk99LY5TK+1KzohlfWXSSNHPclHGE9gu6?=
 =?us-ascii?Q?qvhxfb8mPQbgNrsUjOPz2auhS75PlaK0va+MVdAocwQNdq4EWYgX2N6AtcRy?=
 =?us-ascii?Q?YXtRZvdOBEPWFZXjaXr0KZBjVX8MEBTCifKxcoO8An6DRTWbV7E9/djoPjac?=
 =?us-ascii?Q?jBrmz+mrMUy4wGPa4eiBJOOt/okNmpWRpXTvrcZzN2bqePKoVqNjZhaUeaDD?=
 =?us-ascii?Q?Y4QsA19prin1UUSDFLfneFzCmaLUGZu9dHt/vztWPyEYzvoRO/mVp1doi29A?=
 =?us-ascii?Q?2WgsXRqQX0oB5y/wC6t7sPfG4w0QUG8fSxWAPk+oFRaHnA2OODiO3pJA1BwA?=
 =?us-ascii?Q?5PqJvmRusP1KSf0NP0pyHq1WYyRkCGqnFsGm5LRYgnvIEZwewGUOXa/5BPVq?=
 =?us-ascii?Q?d/M/0vR5RYMdoXCK1TDzAQABF3hmS49lmPyLqPXAHtUXMAlIcbZkPLv3FX9o?=
 =?us-ascii?Q?3M9d9EyDAJSGUPTkcGs7EQewXv0wZ0OX8YHj1ZaVe3ONQPl96ZF6NA1OChmi?=
 =?us-ascii?Q?vLdLSdjRxj0hmLOcNdp/6DAcQlwoqrGnv+voBFGM/MmzxeIv44x1hB7Nr5aQ?=
 =?us-ascii?Q?VMKQPZcay6jUIi1DrLt6ckznNhEnhnsKr58JbbCFpVfS7el4y/QFj16l9oaN?=
 =?us-ascii?Q?niVP+AVtpvIFwmbaklpkI5Lpt7d3MpTlBPsn3KsLiYq736TO8nFauwUcxr5D?=
 =?us-ascii?Q?Cz3Q4AiDd+FhOZckuKgw74zD5HfIu19Z/A+OobDSO3BniebN1D7YtSrIykid?=
 =?us-ascii?Q?18866iRIpgYb+LI5KB0ZiNtORQx71Rv4JJ4+cFHWg4xuOQan6V5LsF4kFqpJ?=
 =?us-ascii?Q?q8tKDLuuZyFxwrtvFAeSSTZIjFHIfDIYFgBuq/H/C1JBIFq5d1L/zJ648jyT?=
 =?us-ascii?Q?LBdW/QdvOeqAW661FLZXl7a37wyF9W/GliNE66hikT0O46BbSAot4nLYXoqq?=
 =?us-ascii?Q?WBb/NhGMvN9wFkkzpWAwTVFbYQcux85dZGElRmMaVfkUuNRipjIJK/PZzlk6?=
 =?us-ascii?Q?eCiXOdoFbvW0f4m3s4L+RL9/g0ccYIo1DvA9ocHugPpi0MGXufzBDVJTBdmn?=
 =?us-ascii?Q?datjei3VAguSOU3r+OGWU08g9VV4318Ekp3/BlWdRxMIfsKK7PVf8pLryQG3?=
 =?us-ascii?Q?r4tJhv93sxRUNP/J6BxZ9p1N6AKjchYEo5cHKRZQCbV+qsJeDy1aQa7deowo?=
 =?us-ascii?Q?wGQZZdaROnkTUbD4beZUcU6gvYzLgD9x26O+8sP9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31511406-7e7e-4001-ecc1-08dd86f5bc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 08:13:33.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jPZY+9St4NQ8COV7BZ3kyrcr+ZYogDbfOTg0OgrxZD2X4dZDl/ajQ2aRLoAYwjvQWqUxJMfFtgV1sTPGqnjAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7785
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, April 11, 2025 6:36 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> netdev@vger.kernel.org; Mrozowicz, SlawomirX
> <slawomirx.mrozowicz@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: devlink: add devlin=
k
> region support for E610
>=20
> From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
>=20
> Provide support for the following devlink cmds:
>  -DEVLINK_CMD_REGION_GET
>  -DEVLINK_CMD_REGION_NEW
>  -DEVLINK_CMD_REGION_DEL
>  -DEVLINK_CMD_REGION_READ
>=20
> ixgbe devlink region implementation, similarly to the ice one, lets user =
to create
> snapshots of content of Non Volatile Memory, content of Shadow RAM, and
> capabilities of the device.
>=20
> For both NVM and SRAM regions provide .read() handler to let user read th=
eir
> contents without the need to create full snapshots.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  Documentation/networking/devlink/ixgbe.rst    |  49 +++
>  drivers/net/ethernet/intel/ixgbe/Makefile     |   3 +-
>  .../ethernet/intel/ixgbe/devlink/devlink.h    |   2 +
>  .../net/ethernet/intel/ixgbe/devlink/region.c | 290 ++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   3 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   3 +
>  6 files changed, 349 insertions(+), 1 deletion(-)  create mode 100644
>=20

Tested-by: Bharath R <bharath.r@intel.com>


