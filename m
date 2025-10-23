Return-Path: <netdev+bounces-231973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29616BFF43F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2EC73523D8
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA81531C1;
	Thu, 23 Oct 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cw9j7+X6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08818E20
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198145; cv=fail; b=WpeGosCOCobCVKRFn65q+MP+d0CukbsHyRjkkx+4r4O3WtYhtI4OMDBYgpgZ6EXPaY/GUyZgVM1epKPXFDon4Iti45GCWVEklrQ6IUkAvsgAoOYsNLEu7mlVP7fDi7h3NDepnZRQu8Wvm53otDYSSJ/SMTs/W4eoMZmZ5GG3Bj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198145; c=relaxed/simple;
	bh=IU6bmPfq+sRN2liKNP7tzuzjc92IlLqn1W2djfvB/ko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMbkNK3RQVkdNB7Mz1/6leocCEjG3bl+0Kw82Ulunmi0Tf1CHfx4ySoiUs2ArrEqzBmSFwwsRt9rrv+/WNmZwIPlUyl1Y2tfanrdr2Czh3bDXWqioYuaqCA3b3p2hcdZ4FSqAqSmqrvJMfYFPmGO1i9YFHzMf5rJmdEVx8CGY+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cw9j7+X6; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761198143; x=1792734143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IU6bmPfq+sRN2liKNP7tzuzjc92IlLqn1W2djfvB/ko=;
  b=Cw9j7+X686s3JqiA8kmrNzbTGEwRee7fBatIw7Qx16x2fpk2+dIRA4Z4
   4ogqxWlTfUQotwVUgKhRrRSV61+D6rPv02j7eK8eY5BFC7fjWJsDsm71e
   2m3mGU/+ux/RxWfWDQkrQVB63vCiB4FrRlrJ8bdEcQkCoDPdlhRjSG+3k
   uXp/WFbkssFvCf0huwS+pLSK3SIDK6x2SGUkiBZhb4Gy/vOTJPf/xA8/7
   PyDuaNFT41NuopDEPhHK40Tuek/QW/bgCv8uxb5cfGyEHt2iAkUQNqdWC
   D6sRxHV1uc2o+xvHL3Zbrop+pbVzVd5AOodFUNHhpHy/6BysVsPk8asdt
   Q==;
X-CSE-ConnectionGUID: pkCB9ExHRju56OtnrU3nCQ==
X-CSE-MsgGUID: yChAgVTuSmG1iPr8S9ZRXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67193497"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67193497"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:42:23 -0700
X-CSE-ConnectionGUID: bXhQB3kHQAOpNnida/sGdw==
X-CSE-MsgGUID: 8Hr7oMLBTo2wzwHm+YkjCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="184457677"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:42:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 22:42:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 22:42:22 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 22:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aId5l0fhbDmPJnHxE6GxRxhgpDyauVwCeZyVJqNHYngcO8cVuKzd04KW6Y+UYooTUQ3/pHZTHbtXHR0mRfYtbKtzbpqEP8qtZfUt4HD3XNxn6myvjMAhEEMFoniJuIN0n2VvijfcPWCyc/IFoD+8iXooh4Kv0bZEPWJlRE9YRZEVvwxBdbZ4gR8SdNnohpo7OL7q0iagD4O+XOXIz4yx3DXn6mbC1vwpFD0n7kkH2yFtjwH2/+iIB3/grGsM8vGvL7NU/nEj1Tlcr6Q+wzdY+3J0tOEwy8sASbErOorxAYcw6SIUzyAUYQTUqnJdh9YavhvJ7S8Iw0a/Mf8G7MLhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s6SI4fIaJ/X9CSgQCe4cIcqZpJvWtdM04iHa40pirQ=;
 b=IyNgB48O8MhKfY7cjKbSutO6h63l9R0tPRIb0VtXzoBFwv1J6k3c94hhNXEAEBJ+g9dqVank7N60X13BCR9nFoTcfTiPBuuTDhqXuK/xuleLg9LrGwAyi+TSMgS4r9nzQpwtIE0kqFYXtXtJz3DHMW5uVP7Ik81x98RIhWdB/ylV/QfjySfrmZJBHwCSUcIpTRmC1OJbso0rqx32XCYJZUd1M3ZVC9Snh06ku6Acoq4tBWLjvkf+GRcgxj7DVEjLglG2uPVX0yQHiCSD93v4W9prOtjLKiIXeBnYc7/eo3gMByyEluUfBF+vV8jCytqZ9Baej0d6Uea6O3L+FL7uOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB8795.namprd11.prod.outlook.com (2603:10b6:806:468::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 05:42:19 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 05:42:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Robert Malz <robert.malz@canonical.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Jamie
 Bainbridge" <jamie.bainbridge@gmail.com>, Jay Vosburgh
	<jay.vosburgh@canonical.com>, Dennis Chen <dechen@redhat.com>, "Keller, Jacob
 E" <jacob.e.keller@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: RE: [PATCH v2] i40e: avoid redundant VF link state updates
Thread-Topic: [PATCH v2] i40e: avoid redundant VF link state updates
Thread-Index: AQHcQ26esxSsKoJB+U+cywONh2pAlLTPOI2g
Date: Thu, 23 Oct 2025 05:42:19 +0000
Message-ID: <IA3PR11MB8986EE20BE3F16C98658B292E5F0A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251022161143.370040-1-robert.malz@canonical.com>
In-Reply-To: <20251022161143.370040-1-robert.malz@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB8795:EE_
x-ms-office365-filtering-correlation-id: 25484501-148a-4b81-f1d9-08de11f6ee6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?SHmGfTOQ/AEyqbubDjtoYwmdn006J3CQyagJTIdQ4YbfKqCrCJn7m3hoYmGb?=
 =?us-ascii?Q?GOZd40N29m1H+THYt0R+IS4yYueqRV0eFv73SQ7yRn7XKiKCRIufZVJhl5vv?=
 =?us-ascii?Q?+AaK+z0HaDyUWDZi0ZOZTA66TTNqpHiHcTgzxiJaSLKH6cd2LDDPn2vPT1yT?=
 =?us-ascii?Q?vnUR/NpfkOoq5iGwq4WiwFPLuMTIRtrPSR2Ngd4hCpj4rpuZC3mewjatKyMu?=
 =?us-ascii?Q?FfNIEnu+jG6Y30r38iQbbcyGs2J6oeTUM9J72rOo2g9BQO2XIDxNY5g/gp15?=
 =?us-ascii?Q?N8pWkXZrSgkXzZL14tRJE7ZcVBIhHTe+vqpq1tKTZ6Lv4kFfzigBjh1WddqX?=
 =?us-ascii?Q?y1pkFSObCkmXOr9CXSkj++7mOz8QoRmOGqJCC9W9jV7x36RCVRfrGS+pfMlD?=
 =?us-ascii?Q?TTeetKcf66Q16/OAsr42di/Z5VOf29tMEe++9NfVNv7yhk7EsOildTJHkCuw?=
 =?us-ascii?Q?tbR4lpeq7wEP1opaFl91gi5anEqW3EIXVa12HyZ4fJxF6RIQnk9k13n5FzSK?=
 =?us-ascii?Q?Kr1WWbybj3iU5e0KWcPLi3nH0uKpZHuwFFvAglZogSdcRFfuQI16evjezdzo?=
 =?us-ascii?Q?UICFET2XWzL3N8+NY7eiWdfiG3e/AplF9zL3pG/3/t+uVu3vA/5HH7SbIkmy?=
 =?us-ascii?Q?GqJI5qd5STc8XktWO9zFloVV0XRnyb7m15Qw8nIxddWrYazmm8r207aZVsDt?=
 =?us-ascii?Q?SFs8zixhIvvpYWS/RoKIVcCPINAmGMbtTMI5gqb9vAXZlgEC0y0C/G9+MPvd?=
 =?us-ascii?Q?9pWdxGL0ccD8jEC9V5Cg0xUwo7BgUZdwyYmyzIaFJ7SoWDCOW6d+JmyqVV+I?=
 =?us-ascii?Q?RQeRnoLMzCudkkCilha9SCK4s/22CXDvydAdHr5raiD7wYSwXiOsikfzxEU4?=
 =?us-ascii?Q?J54JNVlyBkB7tt6c1bQlFeVjwmTF7jF3Ga+yn6KzIkQ/17WfR9/SUL0C67xd?=
 =?us-ascii?Q?JTd+IfWbl2Bc2Zlty8Smdlx2amVUYYrCOI7yt6EKdTdwd+hIMKTBAF/lTNom?=
 =?us-ascii?Q?geYhCL/l+Uso15O7FMnszja6mh6MrwemCmx6rdM2dV/SGMT9w0YJXVrkZLC6?=
 =?us-ascii?Q?2+LZU2rdLtdlalsyXJIUCvq3D0EFftGnILY52CfmpLLVZxU0XBymDu2FNQO8?=
 =?us-ascii?Q?QZEspOWnbGcYXksZteapptj3XMy4DPVmjloo4oUOq1SVHC4fnC7zG848QaOW?=
 =?us-ascii?Q?OvYDn98buJL4rL74vcHiWdHpTpP3xuf+k4z9gFKf6AKtFOBCHkL4yqhGaEeM?=
 =?us-ascii?Q?0KEsWjxH66skO5ViugCrw75WM6Il8D3kfDAuMhHCi/RAzHXwkCUtXgBRRCpi?=
 =?us-ascii?Q?BOc8IogIZVEcuKwk4xPG/VHJIL/+PnwKd/TZ0vRTrQnhwmsXOKm5285KgF/7?=
 =?us-ascii?Q?Y2PzOmE/ctV21TRZNABMbauMNHA5mGr79ALIjORwYFJIQpa1/Ncyry8ZoDyt?=
 =?us-ascii?Q?k4mkUH4hCU9r/bj0d/MZw9njoSOmbF2KnCHD2IxUA92g2Bt6MIyjs0+/Ad7Z?=
 =?us-ascii?Q?DJAjeXhKSk20AbbmkxuHD/X4d6V8Oy0xLbaA?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+T7b+D6IF9FeKw5CLrHDtzK+bMrxCI6EQ9WBymDE7U9avO1LRZdUXsoNInrv?=
 =?us-ascii?Q?JPM+nmYobpQzp3uIwQTwmRSA222wZ2Ujh1Zvbtdybt0E6w/81ToP0pfXJo8h?=
 =?us-ascii?Q?+H24o6oKwbFX8D/Fag6+xXR4HxBkxaHVuyH6iTLZYpl6XWcxC2qeEtBzxWgn?=
 =?us-ascii?Q?JKR6aLQ7wC45haq1HX9cmE6NzyJFTHxzk4djTZx0qLByIGrsGhbuZEGJztoy?=
 =?us-ascii?Q?RrV/VmtA4+Rbh+4QaYQTp4WztHMZTYYrdrAc0Cuf8ATLdfgDRlNKFbn9mmdH?=
 =?us-ascii?Q?x40DWjPQBGU8fxskVa/Ot4pL1CeBFep+MkH8c1Kx9ZK/s6/6VZxbVIP9d3cQ?=
 =?us-ascii?Q?qaq8uMwbWPeLpFw9O37E9aKp7r8//lRbqcTOD0gapcDGki8FoON+9iAgtURe?=
 =?us-ascii?Q?zMjQHb91UJbudOMcgmxN8zMSTqOUcB8fFqiXhnkKSRmCQjsD4nLZetBzn07R?=
 =?us-ascii?Q?fbprRlnmiFEaF6ch1BYdj0CCnNTmVreKvIXOFm4RkwG9pjA+qIFm8eAywBD1?=
 =?us-ascii?Q?yWJ25neVyquBwP86g+OQCIxOmSEc7ZBGl+f4wEg9bePCxV6ZO6Ht/cjXD0ZP?=
 =?us-ascii?Q?Bqy2p/ZzTe4vGP8njFqPP9kVveuQm4VOj4Mg1Ll9mjoik8NFbFP+QUkR+N/f?=
 =?us-ascii?Q?0VFll5h8FrkeoG/JFMXxH3LtRr+LxkkTF8A+O3TA+2C9BPxM8G08Obj5Y2v+?=
 =?us-ascii?Q?O7Ddxl1MpjjA3UlC1xeFEUwr7gbCEBV/DMJXqMG3T6Bp5cv1QJsJ1kqIGhyi?=
 =?us-ascii?Q?qIjsIbELi3MPS1xBY+OAW4KJGmEgTYQoqcRwYFdn44k4IXEIdhJonaqiN/tb?=
 =?us-ascii?Q?28k1Da1uVUbRp/HI2JaStwaqS55Z8yxrv7xN3nzejgMSgPLUrE10uDwjINuW?=
 =?us-ascii?Q?DnF86I5kJapb5cJklOnVLjEXENO4BmeaH4bAz3mfvQpMTAEbmiFZ7jngGUJ1?=
 =?us-ascii?Q?qKv/jWmz8gPXVedbRqaFEumEyruLrGaRZlI48JGrfoNiCTCqH9BXuTrRdI0+?=
 =?us-ascii?Q?dYeHMk0spo6IvB7GHpAxUz3i+qNmohZgD3HzfgjBQj5sN9gjPwbFLQrEysAl?=
 =?us-ascii?Q?v5dzhYzuzEmA4grGYTXdp473sezb7qXRrntmypd6MDYfk32kgDH6pCGIt6G6?=
 =?us-ascii?Q?UDfS19X8PG+WxrcQLWPfPKlRu60f+h+03NMPuHmRUCiCzGRGZZFTHL3wTKG2?=
 =?us-ascii?Q?3T5BIhHZhJtnmLFBZff6zGvDyUPuHpyINZ/HOiSJN0b66Ivj5wd5RopMZZm/?=
 =?us-ascii?Q?wlBe0xW90UcHVpLO4NV+33mxSCxQIH/p3BwfD/bTbISjPQndVtl/M4Gij2z0?=
 =?us-ascii?Q?HAuOmqdtlaPT6v8cTl+aCUIow0rum3RIbzc5yhEFBM6gk8rds+837Im3PXq+?=
 =?us-ascii?Q?x/GLBfs/AL5foXuwB1gYk4BqHgIxDTqevbuKK8BMKuU5k4wowc8IbyyV6qGN?=
 =?us-ascii?Q?7OwrHar4eAsDc3SreWzXQTDxF1pyvNcalkauEsPStyf/yHuqjxgnZdclEf6k?=
 =?us-ascii?Q?R2qXrUgYD6Q9GBQrtF+BK1Zo0PL/Yip9Qk1/Yyh2O+e76u2QZ7+Uli7Z/2ZN?=
 =?us-ascii?Q?90HOniak9kN+WCuYxWvDs7j7lI2F3FaqMV8hinWbdPSqGVhaBfzuPWt5mhFl?=
 =?us-ascii?Q?Tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25484501-148a-4b81-f1d9-08de11f6ee6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 05:42:19.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JqXejx0GqgDuwqdU2KsbJDPnCcHJE8SIDdHozZ3ET4SiaoOhleiuCJRqx03TgG7XWNPuyCYkPQgA0MhBI8noediot70gCL/7sCNJRoQYrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8795
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Robert Malz <robert.malz@canonical.com>
> Sent: Wednesday, October 22, 2025 6:12 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Czapnik, Lukasz
> <lukasz.czapnik@intel.com>; Robert Malz <robert.malz@canonical.com>;
> Jamie Bainbridge <jamie.bainbridge@gmail.com>; Jay Vosburgh
> <jay.vosburgh@canonical.com>; Dennis Chen <dechen@redhat.com>; Keller,
> Jacob E <jacob.e.keller@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH v2] i40e: avoid redundant VF link state updates
>=20
> From: Jay Vosburgh <jay.vosburgh@canonical.com>
>=20
> Multiple sources can request VF link state changes with identical
> parameters. For example, OpenStack Neutron may request to set the VF
> link state to IFLA_VF_LINK_STATE_AUTO during every initialization or
> user can
> issue: `ip link set <ifname> vf 0 state auto` multiple times.
> Currently, the i40e driver processes each of these requests, even if
> the requested state is the same as the current one. This leads to
> unnecessary VF resets and can cause performance degradation or
> instability in the VF driver, particularly in environment using Data
> Plane Development Kit (DPDK).
>=20
> With this patch i40e will skip VF link state change requests when the
> desired link state matches the current configuration. This prevents
> unnecessary VF resets and reduces PF-VF communication overhead.
>=20
> To reproduce the problem run following command multiple times on the
> same interface: 'ip link set <ifname> vf 0 state auto'
> Every time command is executed, PF driver will trigger VF reset.
>=20
> Co-developed-by: Robert Malz <robert.malz@canonical.com>
> Signed-off-by: Robert Malz <robert.malz@canonical.com>
> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>=20
> ---
> V1 -> V2: updated commit message, added information how to reproduce
>=20
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 081a4526a2f0..0fe0d52c796b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -4788,6 +4788,7 @@ int i40e_ndo_set_vf_link_state(struct net_device
> *netdev, int vf_id, int link)
>  	unsigned long q_map;
>  	struct i40e_vf *vf;
>  	int abs_vf_id;
> +	int old_link;
>  	int ret =3D 0;
>  	int tmp;
>=20
> @@ -4806,6 +4807,17 @@ int i40e_ndo_set_vf_link_state(struct
> net_device *netdev, int vf_id, int link)
>  	vf =3D &pf->vf[vf_id];
>  	abs_vf_id =3D vf->vf_id + hw->func_caps.vf_base_id;
>=20
> +	/* skip VF link state change if requested state is already set
> */
> +	if (!vf->link_forced)
> +		old_link =3D IFLA_VF_LINK_STATE_AUTO;
> +	else if (vf->link_up)
> +		old_link =3D IFLA_VF_LINK_STATE_ENABLE;
> +	else
> +		old_link =3D IFLA_VF_LINK_STATE_DISABLE;
> +
> +	if (link =3D=3D old_link)
> +		goto error_out;
> +
>  	pfe.event =3D VIRTCHNL_EVENT_LINK_CHANGE;
>  	pfe.severity =3D PF_EVENT_SEVERITY_INFO;
>=20
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

