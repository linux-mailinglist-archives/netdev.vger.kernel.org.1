Return-Path: <netdev+bounces-201859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F42AEB352
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B8D7AA9EB
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1204295D87;
	Fri, 27 Jun 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyYZlQJa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E21293C76
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017751; cv=fail; b=WEGSjUBin6ZUxIHQeCCRJeFyOWFsMaPvilSeulLuYBg8nTNVZO8uaU+cox1OxR/9UJjdNHXC9/DDOE+LHX7lvStYM6SvIhq5NSmmTgauHFRX8n43ZAU/UuKnVp70jVX8vHOlHuTjFwM6CShpHUufGbGP2GJj2g1Ib6LYg7KNKJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017751; c=relaxed/simple;
	bh=RKOQ1zYdTXB6gB0DjMVb7jRRubiTRarrVBtlzZrbv0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhodFG/XKvC3QCIVAcFj/LgLk4HkErinR28WbwtqyNUgeWHFtaOUcRtFANXM+sTlLotOxTxR9YLbTipHXoHZmXXoxKuBWKhtB7ae4nWm4cZtY3CKJdm7tV0fPLvSsQNVUFO/q6Wtmrpn3/AfKoM9XVDPWoNBfQwzki+xYTLwp7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyYZlQJa; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751017750; x=1782553750;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKOQ1zYdTXB6gB0DjMVb7jRRubiTRarrVBtlzZrbv0Q=;
  b=jyYZlQJasImuOXnXoxuFf2IQc7ugUzpKhPIA3gzYsVkwi9iuxTy1dw8e
   P79WEmbNugThXd79ArA5SA+94pbRby7/IHQRDulxS0r77I7C5UT6Ccom8
   fzG2hgCMKS/0ltafOuUPbMnpumupLlRF69q0Ku2IMQPnUIfuo8mphHzxn
   3jCwo8PdtQtzfrjA8etUD1W8oez0nHAlzPk/3YqNZ1zua5lwBCbo6A1vq
   FD2REGjoQUubPASVyMY4X9/yO0o/dgnrEXKtdcEvSH0Xi4hkMzlBx9C5D
   SFePSix2NXkPUbErSCWyMKsBid427GNfrJp9Z+PsVT4934L+NOOZeRilc
   g==;
X-CSE-ConnectionGUID: CPoCRej1TiucY06M8qR74g==
X-CSE-MsgGUID: YUPm5/UlT0WYcCC9j7WHEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57007140"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="57007140"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 02:49:09 -0700
X-CSE-ConnectionGUID: FqsYmo0IQF6rs/W3qROoJg==
X-CSE-MsgGUID: +1R+QcgTS+yxEjIWUKsguw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="153256170"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 02:49:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:49:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 02:49:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM18ZRp/ItFBgFlkDA12lWx0C5qyMxWcb2tunqB9k3Jt3s1kT7ia9XDJyLUCpiHqqiuNHBvLBJmSAdKULgAW4ET+QX3oeSugaZqW14VHp422XD63qvYvXl8nrGYAt9X5Q2nePotefENye7ZtnXG2G0yiSCmI26qQ1nwhAh7pPlh/saRXGBvjZbcR7Her4pmCUsebjgSdh3Frydz5NmKoUAiUqB9o9KWOu4o1mKuAlr7/Dw7IQkOtLXIZopxJ+oNaCkINSzFRLzUyRSkE2crj5Q4CbevbTTGK2fpEjfxAQ5PQu6PscMeS4Anw932jV4gDlXS6BOXJB/S4Q+XEw+oxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKOQ1zYdTXB6gB0DjMVb7jRRubiTRarrVBtlzZrbv0Q=;
 b=DrASomZ2YouLSBL3t193bmmRJw5oiprs4YJHfU6IsbZNkSlljEmPhVlpBhpNbr5SLmHhdYge0AVpcqPBI0T2DieBY+Qv5139x6uJn61+3+En7bd1v03+L+lnXK20W8UZdRwvyqMU5aUzxE0k+0JgEAFw0LrMLEsYvYd2TYIspHi76kjvKP+ayarocFXVGjSLv7SgeRZ9Zzwlhx4dUd0gxF3FMQN1uVpph9qmzigNUtaPCyi7s97SDA+7bd/DGmQojQnVkjqzwhxSmcZd4biKWmtu0FViEm309SpPGLtq53PqQJdt5mbQ27iL5exYpfPHB2VEZ5iWDzMgpGvw2TnO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7A0031045.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::33) by PH7PR11MB8527.namprd11.prod.outlook.com
 (2603:10b6:510:2ff::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Fri, 27 Jun
 2025 09:49:01 +0000
Received: from DS4PPF7A0031045.namprd11.prod.outlook.com
 ([fe80::def5:6c8a:d610:7ce6]) by DS4PPF7A0031045.namprd11.prod.outlook.com
 ([fe80::def5:6c8a:d610:7ce6%6]) with mapi id 15.20.8835.026; Fri, 27 Jun 2025
 09:49:01 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Simon Horman <horms@kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"marcin.szycik@linux.intel.com" <marcin.szycik@linux.intel.com>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Osuchowski, Dawid"
	<dawid.osuchowski@intel.com>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [iwl-next v3 3/4] ixgbe: add Tx hang detection
 unhandled MDD
Thread-Topic: [Intel-wired-lan] [iwl-next v3 3/4] ixgbe: add Tx hang detection
 unhandled MDD
Thread-Index: AQHbgRtWOy5w8kpfc0+g+gjWMigBTrNNdq0AgMoYeOA=
Date: Fri, 27 Jun 2025 09:49:01 +0000
Message-ID: <DS4PPF7A003104525715E850768908902A58F45A@DS4PPF7A0031045.namprd11.prod.outlook.com>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-4-michal.swiatkowski@linux.intel.com>
 <20250218193646.GJ1615191@kernel.org>
In-Reply-To: <20250218193646.GJ1615191@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7A0031045:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: 6dec87c6-bea2-45b8-04ef-08ddb55fd83a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GGN7Lk2rwrWSLxKqiWJiFtG0V3uvZKVtDUD5Z5EgobuVCw0gX8+Synd3dOMn?=
 =?us-ascii?Q?j8UT6sQOr8a/lldnHn3VUveNJmhR9a3TnKykm9sjVs44EfZu86vJl+wvDKLC?=
 =?us-ascii?Q?oSngp4PMkXPCz31Q2qVKK6l0EbyafGoousQKo0bKscKT5jLsjkOvEIPCoagI?=
 =?us-ascii?Q?GSnPYilBKUiNfoJig0wudLVGr/By576cXq2VcNsaQWvP2a6VMDiNTG+DuaZC?=
 =?us-ascii?Q?QzqFJrNp9N6hu1E6oTGf02HxaaDvnENUdGPgB1mF4QgSIu2TM6MH0o/I0r1h?=
 =?us-ascii?Q?azNfeauycAAkaRljNzHy+2SzhPGTIYwdJDKBlTgc3ARqHEiLHrcv/du+e2/V?=
 =?us-ascii?Q?zzf840Q1w/gv6Ggv2GhPuNkSke+bzsxIb9Ax/rtZmgdyOFZLAN8UJb/5Icp8?=
 =?us-ascii?Q?qToD1fsOyUs5v6NI0sKkTSMwDQtkSMgBTemJEnYKKQakA80V/MGDheIVEJuD?=
 =?us-ascii?Q?g6597s1Ni0rMPDk1MMtn/1VEXX5j9JTGMIhpE6JrcEMwFczb8jtGtKbaUi9n?=
 =?us-ascii?Q?FTO2ZjKInlsSuyijZNny+oyw67kj4A30ZOTVYR9tEs/H/dw9jx54VlkW6waS?=
 =?us-ascii?Q?yBx6spwWkk+AW4AIZauM1CJ+wx+HVd9+i5mlZlzEDOu5/ykWIxDX4rHuyDEE?=
 =?us-ascii?Q?Q2idKGZvtBEdqHekFxpiK6zyrZ9zPlcinx2Is3WM8k0EKQlGXTOvEzlRz9tx?=
 =?us-ascii?Q?Q1VFQB6wlOoNPUje6+qvV/yqJ75DEEOQGEg4pVxhG03/MMUWKx0hKw1IQDf9?=
 =?us-ascii?Q?Ny5GKsqLEHmIbJA62kv2I3qYZgpFmTNt++EYCGe3OlEMNMgHRQM0BUKNCBff?=
 =?us-ascii?Q?gj2hwggWdQCMm4qVQ59pU5voZ+2cfVXfbVCvHnZ+L1aN0KTYq+fFhlfk5Egu?=
 =?us-ascii?Q?MG5kfGEuz//EScU+JP6dItF73ZwI4OXvyOw4jD2s0H7WqQW1oX3HOtI7Okyc?=
 =?us-ascii?Q?A58z9FRX9Pw2T2OaiLiX5uxLBRt8OEcYXysK+RkC+lrhXSEADM5tkbyE9X/G?=
 =?us-ascii?Q?WUqeMqDiRROc37opXZiNdKBs+n7+CDB8sek6Uy3ZuSC8+y01LZ9EUfwf17ZL?=
 =?us-ascii?Q?gP31fJsgZIM+jsHPkySKsEmhsrc6MXbQkjfrS7UacdJbEe5SFfzfU/BKk/Q1?=
 =?us-ascii?Q?ywjOLDYGx+d6ifLsY1NBpP97+xGbK4SV7XFxM4ENf4v1XhIBwnvszIDNPrek?=
 =?us-ascii?Q?NkPTVS1XM4b7tIfl0wGE4fpJHhd8K111Nu6KkL+jQBCrTwLsqCg0BOikFmok?=
 =?us-ascii?Q?hrVdbTZ0Ir2FygXvsbFJLIPHt+lDeXN8YYYreRdK+KLRGrM655mB0cd5DF3v?=
 =?us-ascii?Q?PTN0gHCBE5KXsT0QRWkv5MGnkkBUYTsMKcfeb7o4rBkJZzRVvntKMNLBEVfO?=
 =?us-ascii?Q?EDVdcphMbfw1jPXh0fn+N23Ig2YFDYiuJ+8tMoQrsUSUHIgH3IpAp8nt/LL8?=
 =?us-ascii?Q?S/whEAzR+kgHu6g4FExW/xdCBNOCh1wYT/i203qm6oaYMRKOIy1JQQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7A0031045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7/wGDCYLwciSBhlfX6PgtgArxzVlg2+rznWyYVRKM9Kn3x3pLEU2Y77M4bVV?=
 =?us-ascii?Q?rfsZac4Tu82Ldb8SMml+a57TwjzF1iPeU84MfDu8M+bufkHFfvpK8hn6yake?=
 =?us-ascii?Q?nczLsNRlUY4HjRJZdhOW9dmCqjjTSG8Sh9YK3uzNIYLapZAmDtJWBgatxYLj?=
 =?us-ascii?Q?U6ZX25iaYxFc8TJAFzaJCxQZOrAOuM2uXn/1JB8v5Lmxuh4JU1BZ6FNe0t9t?=
 =?us-ascii?Q?JaRHJ4zB+ebienxn6wim4r0cIPHwuokjF4xqtFfRIYWPPvCmMHuFWCFxjpsf?=
 =?us-ascii?Q?xIXohJ6DbYUXcYDDLHKRFKbGnPbg4UQj8k78S4uIh4lcJnqs/dY/3ANcldoT?=
 =?us-ascii?Q?x3f+6dE5Um2ED0cZtnHMtNEfSIXYqn1WbHCfoHB6+AEQjyJj6hOlfi6k0Xc0?=
 =?us-ascii?Q?b5gc1RSFEcmzX6r4q8/eh8oXmT3VICqGJPm/LMqjmEK+xvbjsGsyG4lONm0c?=
 =?us-ascii?Q?NzPZqId3vOeMmnL8BPMtGnrDiZW2sDknhqRnYK81e6uuratcKgtQBxgMFKy4?=
 =?us-ascii?Q?LNdApFCbcVfmkaqASvbWXhjj+yZEi6eTPvQ9WIR8BwBtWgCjqtjp8FkiyZEg?=
 =?us-ascii?Q?A837JV1uKt7H1BjsfYaxUgDY3isWxOgocylzRYpdjPB2TqMldydTAjCN/vYo?=
 =?us-ascii?Q?anHEUyns8akQlFSfApU8zRo31NdtUJDEVyh9ROZzK+ml6k8jJlwBw/jSljB9?=
 =?us-ascii?Q?UouXNj7jVS/MxaKMbJWA9OLqE2R4bRQ+w9pkZfrXykm3TgNJDgrD6N77mGyS?=
 =?us-ascii?Q?z0UHBXFWoYurCRgr9vePQnPySHOJfZjzfyDG2lHxT6rPZixqVmWICly1HQ0H?=
 =?us-ascii?Q?hhgQAzzMM7F8ghp+iWKhDVtx4vAoyRgyC2teAvGjGUrovCr7Ge8fAw4Y3SlK?=
 =?us-ascii?Q?WHs402zOfXDP1m8LaGyBD1phNyww6f+SUzwrqhtZ/2voL0N6c+122AMwEk00?=
 =?us-ascii?Q?7jiHhX9JI/29yCqcdbnGg1imw1lFuOCyt3SVVs9lI0DIt14cC2DiPFYdzUvG?=
 =?us-ascii?Q?zhJh1AaHyaIgtArf4Ply/zL+6s2XBIXLUdGO1TL5AyoDx4CHmM0EEMS5+5Sw?=
 =?us-ascii?Q?LVwxv7mExdULMLgLfC2y2WWxARG0dlfsmjnpuq8RjY35UK0fFGdXavuVRiYW?=
 =?us-ascii?Q?FaKQaYN1n6JR+paXMVCVeJnK13KweBvK6UR6DGsooa6PEYCH6ES5Dim08yGR?=
 =?us-ascii?Q?y/FoEzh6qKSMenl2xa0oQ18h7poAPbC15O3SIXPMzvK/sFOX7rRj+oYYndlt?=
 =?us-ascii?Q?ewcQx6p6yANKFneTA39ralWse54YSLzAiVX23pOYDfiuAZ/2ymcUj1IXh6W7?=
 =?us-ascii?Q?DFdSVxeEUj+VaymIrd2mNNeMBymaeH9wMYtcAn3ZAV1SnW6eANI8Be90zR5n?=
 =?us-ascii?Q?gvGQtzuCZlcuUeoANBaCuuRE4jADMKNRaAAjpQmZa1X1/ApKCKdSV6mywUUi?=
 =?us-ascii?Q?Q9Pk0a+9pkk3NHY6lOlZicg8lnsAzu90y8WK7LX+fTsMIgTJeuugCkXw47YA?=
 =?us-ascii?Q?HOm2a1UkApVxajNf6SoRjJHicx4t+anyX60jB+gd/lvUFlzme6GIYULwm1Hf?=
 =?us-ascii?Q?sby/qDIhJn3PbchCm4ddey0160/1VsU7Xz32jb56QR1XgY+4SoZ67Lsa+oNB?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7A0031045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dec87c6-bea2-45b8-04ef-08ddb55fd83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 09:49:01.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpxHgUjllI0kk6LHtxufBLGXXUMxcNC0TiJocwnSveI32nbPAsgFKRQ4KPK3LUPhPTgvScTdwoLcUOrvWaJ9S8X942ljy9aGHqSudb/IvdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of S=
imon
> Horman
> Sent: Tuesday, February 18, 2025 8:37 PM
> To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> marcin.szycik@linux.intel.com; Jagielski, Jedrzej <jedrzej.jagielski@inte=
l.com>;
> Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Kwapulinski, Piotr
> <piotr.kwapulinski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Osuchowski, Dawid
> <dawid.osuchowski@intel.com>; pmenzel@molgen.mpg.de
> Subject: Re: [Intel-wired-lan] [iwl-next v3 3/4] ixgbe: add Tx hang detec=
tion
> unhandled MDD
>=20
> On Mon, Feb 17, 2025 at 10:06:35AM +0100, Michal Swiatkowski wrote:
> > From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> >
> > Add Tx Hang detection due to an unhandled MDD Event.
> >
> > Previously, a malicious VF could disable the entire port causing TX to
> > hang on the E610 card.
> > Those events that caused PF to freeze were not detected as an MDD
> > event and usually required a Tx Hang watchdog timer to catch the
> > suspension, and perform a physical function reset.
> >
> > Implement flows in the affected PF driver in such a way to check the
> > cause of the hang, detect it as an MDD event and log an entry of the
> > malicious VF that caused the Hang.
> >
> > The PF blocks the malicious VF, if it continues to be the source of
> > several MDD events.
> >
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> > Co-developed-by: Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



