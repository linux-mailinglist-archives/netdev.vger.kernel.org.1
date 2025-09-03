Return-Path: <netdev+bounces-219433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D04B414B7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033FF560E1C
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3B2D7805;
	Wed,  3 Sep 2025 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnOkMruZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF55257851
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879797; cv=fail; b=YbaATYcfrYfG+fzKq3dH/aKQBbAmALCtokqFVoXu1+0x4t4524UHdVBEYmuXIpdIRueoAY1C2QofCr/2PxgRQ0ir8uTwONmRtCZs6IsN/GaeugUafX6/A9B223nlK+vvJZfxMaQMJ5SqRsK3OsRIrffRNKbWnMpGW4BEcnpKqVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879797; c=relaxed/simple;
	bh=T/RiQTUWPVuYuYHbYcJnA3+WjsoDiHZcuPPnQ866A5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lhPUrbB8S67RZSm6ECnNvMNdsjbLLejXC82Mtn8CggV1gJJ4keXIgYlU8y6NwSauujqjX8t4BIYF+y8E69c2cMKGH5YyK6OLkFUV2uO2jU9VREUWyjWXa5IMs9qsK5tgMk4SjPvNk8WCB/1yt2i90jLmEmYV1VNAtJPmmwksID8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnOkMruZ; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756879795; x=1788415795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/RiQTUWPVuYuYHbYcJnA3+WjsoDiHZcuPPnQ866A5A=;
  b=YnOkMruZelzzoG3wG6lN3RA1EVOOtZZ4BmBJEvZya6KsOm3uBXkPYT/W
   SZZcav4PVBL72l/ry1nAdMakdFm5iQSK2nU3P2EEjp5xfuRzpdEDC5p3d
   Ws8wZPs/dv4FpbONkUe3H1pPxebzotfSFhNcsIlXjBkoqZuuXgrKcxhWd
   Jj13ZSFwlNeW7JKDtETtV+WyQfzCJgURkdLtYmO9Xi8FAPqMddLIsxdK7
   wFGeDMvIXF/a8okm4gdoH/dv2C+mW4IY13D5nROP9zXva5NxHFi+GcqvY
   arDMUqA7lim3B32C//v4XmuMPXwdSkzF/ri6EAHayYhAFchHmWYMFyvyK
   w==;
X-CSE-ConnectionGUID: 1aqGTSHcSUy1h9zSNykvuA==
X-CSE-MsgGUID: G4UUkAzxQkCx+xLRw67Ysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70559485"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70559485"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:09:54 -0700
X-CSE-ConnectionGUID: FCWkNCV+QEaZJc52Em3kYg==
X-CSE-MsgGUID: Ac8n3u4oQBmNgotGdKKPKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175867464"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:09:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:09:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 23:09:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.40)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGbG6WiGi5zURZT0kWsqjkZex/AZRHeifkV6qKt7SHMxPjzyY/Z4MDGSBi08OXPVUxuiJ7J3ZcnDOBVJJeEaKREjGWRtVPjaDMcTInJ8z4nwSbwEdEvLegkbJmjFNIXVIVrWlqJYHwlC9WPNLwa3CDWGpwwBRZEgeT6PRHET10EBcI01WeeQStjS5koxuG9eFdcmQclmgok9D+yEPNKj6EjZShsKw9QaGVjsz4DCM8mQlc6x3FLVz87h4kn6t1rJKrS/bPCIQgB1v4UuIEwWOw6dILlMZbjGb9agvhXclVOa/Hcg5t06OqT+o2iZ4xSXYNIEqFHwTHdxFI3m3Qb9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+gwWaJo2XIvRt3o5WCxS0nUuFEVfBSToiC6wE3bFUw=;
 b=OYf/ofl3bCH6hO01eK79dUpuS/zPc5qbRclwkGxPbu0rsOG7pOsAqjRSc+DgfXAiYKaE0Sg8Fej3WEV+l+3CkTND0iSkGm+KR+m/E/chevBT8m/Rr07L81/W6wojjlB+1liS4ShVQtfi21jsVZPwu2iOBml80c7Nj9zTYla+N6CHLEUecUkhDbFCksva8aUA4HXfg3IBs1rxaEkUaqh99Thdj+G/Qb9y7p1QmaXig/8skNc6oK6DD3rAQgg8GJGnKWcgjaHGZ2nSM4hiRLTPs5yNMLl+nubWqgCANArTl4UoA/wRSWV7xcL8aPkREDKeiLTzBk9YrpdNF5opIXhN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 3 Sep
 2025 06:09:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 06:09:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Brahmajit Das <listout@listout.xyz>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] net: intel: fm10k: Fix parameter idx
 set but not used
Thread-Topic: [Intel-wired-lan] [PATCH] net: intel: fm10k: Fix parameter idx
 set but not used
Thread-Index: AQHcG4e1xkjDD5w7f06ueEKkcDl5/7SA+37A
Date: Wed, 3 Sep 2025 06:09:49 +0000
Message-ID: <IA3PR11MB89862D06204DB7141DADA5CAE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250901213100.3799820-1-listout@listout.xyz>
In-Reply-To: <20250901213100.3799820-1-listout@listout.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|BL1PR11MB5224:EE_
x-ms-office365-filtering-correlation-id: 6eeaceb7-b9b6-4934-355c-08ddeab07d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?2GyJtmUqM8FTf5CEdZXhUAPVWik/6z1BNn/wP6AnrqDKX+7QOuxgHhmEmbZP?=
 =?us-ascii?Q?6jAs0Sj+4CkPy1+1h4BF7crh+PbQcbwdM8wNvlpDZnxOECnYGwXEOjAUtGZN?=
 =?us-ascii?Q?sHJvkCp1XHdSKmvFllVd4BgnBwIjiKdECplcOjyB1GRi6FKFQ+4KnJpjNDc1?=
 =?us-ascii?Q?caH3iKBSD9iR1bX9bQNrm3RwO1BoUibSEIL7sWzx09W/X2cq0W8bHrYJ+AlI?=
 =?us-ascii?Q?nHHqfbCTtomGBB65kWNSeP0LsUY8DtfGnDUr8LIbTquRZ8zCrf9+BMot5jrw?=
 =?us-ascii?Q?E/1WUprz12qcwxXdRqakmICWOvgOp9TNOvIximWXU1maYAe+poR2nybYnbb5?=
 =?us-ascii?Q?GWGVMeSHW/abdxHJ7mw7UJjilwU+1DPK30zlGDfH3HO9FnEcVos86CO4kVEV?=
 =?us-ascii?Q?wtM+GHhgQYybs2IaoPYrztdY6CznZ+LmTbHMgiq19Wpfplzgg5p5R2zsAMDO?=
 =?us-ascii?Q?XPYKtYbYilY3Cs31xNH672koW+QNQaH/sA+bhSaQddJLYAxKFhn7+Me3TBrd?=
 =?us-ascii?Q?z8Vw4FKgxOd8vKPTFo5GcVX0u4zeMPMxx6avfXOW67NY8SxVcnlXOLJGZOsl?=
 =?us-ascii?Q?SdDeJ9IJokmVoz70oOLa1dOJMONSDaEMeKAabNb49nvwfQp5mhMLnOIuQ8wk?=
 =?us-ascii?Q?65FlgeAKmfWa9p9Xy50XVik7A1KV1rCUmeT+qfZQmotq34bPTK6in5UiIGOH?=
 =?us-ascii?Q?v+OweJ2XtsEtfZ2fWaWQ/m71kNdXOcvejxceHj1j3pjCPNk2VZglfTgDwjkX?=
 =?us-ascii?Q?RV0k2iQMX3SHKbLhEXT++0EqskRnM5+kZLt/wHOhUk3tFxYKGBVPXzjZLvoZ?=
 =?us-ascii?Q?N/pnIPVQHrMj6ynQOe8V/qnilGm8hhrAyWo2foVpgRKyopQbuwfEzjFhK/Hd?=
 =?us-ascii?Q?OzSPzuHha2auD7w6GTNKhyhkJK7cS+t+bZdaWLspi1ae7fkYvbMQGBZk/55l?=
 =?us-ascii?Q?A5eqqdtHtxIupgQazlJmZvewppPaHACBTli62uJk/RqK0fb5jqBtu08lCOBm?=
 =?us-ascii?Q?Qw7qH5uB+4dMOpofn06rTeXEkWAkLC5z/ZI1BenE4Si2AnMwf28Vt1diH5XR?=
 =?us-ascii?Q?BYhRmaESp3+cpCXPDivg/4oYeWVAKliJ/13n5Djh4iHv+mdL+uua9aJFkZcB?=
 =?us-ascii?Q?ZoLxvmcRqKxoARZYjjLiFjw/JfHzlAk+x0pzcdxW0ZsbGpPMCL98D+fJBIQH?=
 =?us-ascii?Q?MBeM1R3qe/kpOK74CWxlDdE69D0wmMLXwaVHV5JH8GPLUeHdk72GxwfvTIs6?=
 =?us-ascii?Q?iLBKZNY6PIZCayMFXFOopZbqLNo8il989xETDWovY0clvUTqN1JCMnsSHR7b?=
 =?us-ascii?Q?PwvN0h2lzSygtLT75x573vemf/GY1Dp5uSSpe7CGMfhe23kb3nM3rFvfzpNy?=
 =?us-ascii?Q?jhLbPbb8423IJbSiQ9ApXA7NPRhsev85ZyHRAaP3kh0bMpUXP3Tj8s+XQ8+t?=
 =?us-ascii?Q?1VdCQRE10yKTv7818iSo32afdomsRNunlixrzwkQEJKta145K+SUCw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vvJWNU9ciwr1+W7sjZrgYwvDt1UevuRilQwsuot8/BBxsboirllyiDfHH5W0?=
 =?us-ascii?Q?/ta5urpDPp86ULSteKb8AmfdZnK59/dpr4FB7U/nkLoMqRLmW1CrWIj0zyQS?=
 =?us-ascii?Q?4z6YXwFagLPiqbFZW8dsJ74aUBdz/Frxn72vCeDy1kg/EopmGolvMAnJHNci?=
 =?us-ascii?Q?IsYMuvJ+OfPgD2nnj06RE9016iIq3abOramaFlzCrNlMhnKTcN4V6ys0MFK1?=
 =?us-ascii?Q?1bJz0NrBS/+oJOq17s6HuHxKy9C5vA01KYi5YyR0ZDrHFZ68dW9n8weOKx+q?=
 =?us-ascii?Q?/Dn8+NgLT/Hpj5JrsceYxCFP2OAu34lgJemdU8saiALhvo4CxtRyoH9ums1A?=
 =?us-ascii?Q?xstLuzWFMzSyRan17LuNE1Qtcgu3O1LSSmNYcnFHQyHwnYOPOrl69pUsi+Y0?=
 =?us-ascii?Q?0jw1PYWEGle1e4LsnTzkqINaI3U8KB6ZC1EFUVkkLHJPzQWk2KnOP+POAPvO?=
 =?us-ascii?Q?CuwfKieu3Aj1CpEjMccdpjQx+Iw8SwJU0NXW2dqPzwF7wPr9j1BDYdCaTbPe?=
 =?us-ascii?Q?FI57fEZCeoTCblZC+ubrCR+PfkK1lh/5QjBxI5paiifkSEX/Fe00M/lvsMTP?=
 =?us-ascii?Q?7CBYHqU+ibMv0dxwxZRToyvJz2QuAv6VN64TBV46shmHGZ6FNr6z69z/R76K?=
 =?us-ascii?Q?nCT2z5oMejIQSoMODhrmg4HBOGFditxL95+wcm2HJ14Kh/SpAPRY2zDquKs5?=
 =?us-ascii?Q?XDG+MmvDorcLvqojBaraz51t6ReZnpR8GrfAb3ZQcYdi47sjEA/F8FCuZobz?=
 =?us-ascii?Q?zhJLj6pTSp6uheZZygvIFD56zfwt/816shD3jK3iMtaJRCPWpiKNZlbuO9l5?=
 =?us-ascii?Q?mdDtYCCJLxH6sYTMcV9K/wuR4zsd3gNA9KP40GBtuVEE/0OgcAAsxdR9HRDB?=
 =?us-ascii?Q?DkANIEhXI5V+4woJccxUWOjA/z7roMzVmGt3uLmLBjGUaKpI4vwXff5eu4O9?=
 =?us-ascii?Q?IzAgK9ALy1u72ASgHkxOgkga5Q09/QUGxrEoQdwQIG/QbTTdkYPeMv9d47XM?=
 =?us-ascii?Q?u0tsO9Cbmrj8jUvw7y1sd8fmpeBZZUsmiGVVJTnPc/QicSx5+P0deGw8pT1X?=
 =?us-ascii?Q?lyE0+8df+hHCEOAdHykibUfLA3iDDdK2kUT6MqrMIZuceVRAycHE7lNiJ1pA?=
 =?us-ascii?Q?CmlNRu9+Qhconniypwig1O8CMv3+JFWuxRBcAjMyPGJAnWZf1UpKYcz0uOVd?=
 =?us-ascii?Q?ut591C0S7I2b7hsz8xCcnM6kIZt0ZfZl92j8mUIbiAiDKV39dpQq9rISFTLe?=
 =?us-ascii?Q?Oi/rpXVp6QpKgmEyDYHuQE+jeQfEa6uSl5SDr+x46UZy7Vpngh6wpoISsLL3?=
 =?us-ascii?Q?eUALd2GAhfrxMChRXlwIZdeSjts7ftYCMsX4HJZpvLJ1l0Det2UqeukGpeeE?=
 =?us-ascii?Q?0NgK2DQcF8a8tEBBXM3RMWUR/fGZIpVX/VEPa3lInCjP5LsLOKpBtSe9G/0E?=
 =?us-ascii?Q?6H/4acmLwi68GwLJ6jSdqkA1vRKV9qD/9dn+OkEdkBre11z6mznCvF/Ht4i4?=
 =?us-ascii?Q?JThjaiAcvhVxz0I6h9Lc1G2Y9RF1PU83ds00QZvOSlvmkYCpP4wF7vKWM84Q?=
 =?us-ascii?Q?aouC27JJlIJX9WrxAThGcwsHO80tDpqrFXHWdiQYlfiF3uRUgI9pppQG5+cB?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eeaceb7-b9b6-4934-355c-08ddeab07d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 06:09:49.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEiK2VPmU3Q+MKGQdAz/RXTkNDvLStY0EW9Go1hpEgoNYBDYPPoNyOf5342fWGtCc7gz3kZey6qsJydgyM4E5F4uNdvSo9Po3c8FcBXhh6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Brahmajit Das
> Sent: Monday, September 1, 2025 11:31 PM
> To: netdev@vger.kernel.org; intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; kuba@kernel.org; listout@listout.xyz
> Subject: [Intel-wired-lan] [PATCH] net: intel: fm10k: Fix parameter
> idx set but not used
>=20
> Variable idx is set in the loop, but is never used resulting in dead
> code. Building with GCC 16, which enables
> -Werror=3Dunused-but-set-parameter=3D by default results in build error.
> This patch removes the dead code and fixes the build error.
>=20
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> index f51a63fca513..2fcbbd5accc2 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> @@ -457,7 +457,7 @@ void fm10k_unbind_hw_stats_q(struct
> fm10k_hw_stats_q *q, u32 idx, u32 count)
It looks for me that idx++ was removed, but idx is still passed as a parame=
ter and unused, am I wrong?

>  {
>  	u32 i;
>=20
> -	for (i =3D 0; i < count; i++, idx++, q++) {
> +	for (i =3D 0; i < count; i++, q++) {
>  		q->rx_stats_idx =3D 0;
>  		q->tx_stats_idx =3D 0;
>  	}
> --
> 2.51.0


