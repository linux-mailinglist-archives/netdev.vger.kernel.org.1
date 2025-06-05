Return-Path: <netdev+bounces-195180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90260ACEBA3
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973453AC00D
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1C1FBC92;
	Thu,  5 Jun 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dp0GgCWy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060F1A316C
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111520; cv=fail; b=epBktCNruEOv7da18OCsoRBUasXsETHyzNjBnRjCWl5iIaZm9NXAYyNcf3JM3P+/AniyiF2dkU9aab/0iVUu+1LK0sDfAjIseEk9czUnRSPgCiz1ar4eCsThYXw0GXz0J1+qcc/ksDcBoq9+f1tJzFKIsSsgrbhBrMWYTTKIIlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111520; c=relaxed/simple;
	bh=Yvm/IMcc665uagv5UhQYkET0tt8MGa0ddirfefmjQdM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ksoPxBo8xLv5wN1HB1p1T5EJGB+zM24f+tmR2Qm5320XA0K21c+R4D8NlSLD8ALc6bczkoivEm7EL4QcRRkNCitTA2vy27KMt5K5sonu1Xl+RHCe5jbqT5FNd6OGs1xaYkAiz7Bw52dvHvpqAPYKfw8YYbOV1v3cjx/gVYNZ+hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dp0GgCWy; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749111519; x=1780647519;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yvm/IMcc665uagv5UhQYkET0tt8MGa0ddirfefmjQdM=;
  b=Dp0GgCWy9TWH6ODxOSUrdMVQP8qG3hHhHU6Z/yBNcuG7TimZi6ybjLXu
   FyvlsboO6QEvOCTQGAErpBecFqsKluTcrmpv3gOFH34svCC40xAjxr0+p
   Pkq39yjO34h8aVVSPd71q76URtBkjwRQqbVejr9/rAFptY0IAIZnWNUAG
   eDTAtwwBfJE2uO4lGaVKn8E6HQWDhQfr7SqwRDszNdC3bexYUcf9+Eo3M
   YwdGfMWCf05a3IMhRHC/phVO/l2W3pRVOOziKzIAFyrff9wrNetLEYv0M
   lnsrIew8SpZAqGEU31o0DQIb47BRaGZsVyCW8v27GNVI2K/CTlO3QpQv7
   g==;
X-CSE-ConnectionGUID: /uRvKkKhRiSvxddlegipcg==
X-CSE-MsgGUID: wknvmtQjRy2MWgBp5MekgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51364758"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51364758"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 01:18:38 -0700
X-CSE-ConnectionGUID: uDVlZPptSGG2zehTdPIcKA==
X-CSE-MsgGUID: FrAlxc25TDutjD7VGS/jOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150703684"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 01:18:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 01:18:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 01:18:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 01:18:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2hU1jWc4YBU9VspwzIsAatsUa8bKzmeK/thZYTivHGrPWw4DCqtltf4JE6txIxx1tRi5P2EK3leCcfnr1sEcGVd/OGHuawKvjGqJgMT9p0ybFD9FM3tkEP+SmBXh8iyPy8Ylq5cU44WWFQwmJy612h0AqCSimfGL0DCT36CIQQWL6RJcfjO+5A3fiqAo88ApOYffRy6gojxiot6fP/Bb1mO/DYfATSxSLmqxpFoJ9VheJ/S/fqZWDcU1J5nfMEv2aJW0MiBsqMrsBnZ1y1sQSa4UhjM8ixrkh25CAMcGkdagrZ/x4i8Gv4N/raPN0QdTdNATYccfUFw+vYV+KC1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yvm/IMcc665uagv5UhQYkET0tt8MGa0ddirfefmjQdM=;
 b=uK5LE493x19mSfA/oVR4yKkI1ej8pj1wyaFdSdRCteSjjRDksbQGIYGDaoncmHrpWdpZp+M3AuHEOnGsZdKdgxVXE/e2jThWVr4qXilqX5F9dmb5wXWClwQyhdZ1TPkKO46DHljyYkYFsTXKuTY8knO2PuS2jRRaV4IOSvti6znqYhPuQu+/lBoNDDIWuWirghZfrszvrHKA27b5FqPiGv7fdJuuZ1kndksuPsOYC3zwL02s5aOnocNqEwvoPvFkGuIuDU7XHdpQyQqkBGQNYlYe0/vZ5k/qscm2mwTGJfX7mMnBkQ8zaTG4mPlZgG9xOyFuVPAO4+1H56fShLJtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by IA1PR11MB6540.namprd11.prod.outlook.com (2603:10b6:208:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 5 Jun
 2025 08:18:30 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::4955:174:d3ce:10e6%6]) with mapi id 15.20.8769.022; Thu, 5 Jun 2025
 08:18:30 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Swiatkowski, Michal"
	<michal.swiatkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: add a separate Rx
 handler for flow director commands
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: add a separate Rx
 handler for flow director commands
Thread-Index: AQHbxM0lDZX8vcF00E+VX5cZJVDsarPSmgQAgADY8wCAIOgnIA==
Date: Thu, 5 Jun 2025 08:18:30 +0000
Message-ID: <IA3PR11MB898535863FD9575698F7565C8F6FA@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20250514123724.250750-1-michal.kubiak@intel.com>
 <c8daed51-5935-4070-8d8b-8994d348f746@intel.com>
 <aCW4DDk7kUsAqCJr@localhost.localdomain>
In-Reply-To: <aCW4DDk7kUsAqCJr@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|IA1PR11MB6540:EE_
x-ms-office365-filtering-correlation-id: 7a7fa5f4-fed8-4916-b4b6-08dda4098e43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?8pGRs8tlIE1IebY0j0dlhwqVvpgm/lfeC9304fC5knGnDHh9DWhtcfrozR3i?=
 =?us-ascii?Q?BiN11qPq6wnxes+7N7hMc9EOwrEbZLc1bhvDRv/VFnatisBoKBseDIHxat0t?=
 =?us-ascii?Q?uFeaUXVvcEgLsXre3i501notI1+rgUs/1VG5+VpELaejl7gCJChW7vTW5lLX?=
 =?us-ascii?Q?UchRgLVwtwbxF7uou+WhWwOF/+zAYi2aYSh+meBRAYS7pfguaEjQmt5rJueu?=
 =?us-ascii?Q?QM8IM0htIU3aCzFPnL54fFFpY419bpZlREPUtnLe86KK6BW5igq8Hc1Z7X5o?=
 =?us-ascii?Q?/ffpLiAZO9DZM4AWaFEozB1kIe6/VKOUKUpEz9bxad5cLG5ZavOYDNrgcQIX?=
 =?us-ascii?Q?yajzfJUGp6UttmVyuGzVprZ8sRBNYoLF0iB7+fEzB7EHnN7LJ3ksy/vtn1RA?=
 =?us-ascii?Q?bEoExjcJeVGmRA+kZCZ9siYOKwrwS7TuD5EjmzMuu3couehYvVzi7BW+W1nm?=
 =?us-ascii?Q?wYdq2maWzgs8NcGnNWjpGiJ/PWOSSRYUsGoDDAD2oX360YcL4J8T9280s+C0?=
 =?us-ascii?Q?tXpvZ+3a1gBJoAlFT4LuxSmy77LTixQpDwjzN9iJHOER8xheXbOGHSLzgQRs?=
 =?us-ascii?Q?uRMdkvHLdooyovsPaEAaN8dsa3dIOI5cqVd+B3fmUVjABQXGrzWdnICg4JYt?=
 =?us-ascii?Q?iHolVihtVtqpfu/A7UW40FhWCHJlb+Hr0LtkEL2bMcPhRe0coCsuyiKCZQq8?=
 =?us-ascii?Q?yZijZWykeEkXUdy2rYb+VA1C3HIwDHwG2YqWvTD8pcItNShg1D8hLTcGgNsn?=
 =?us-ascii?Q?XQxXiIekusY+vVkFAEuXYsFrfGH5FoJhGJuWZUFxDiV+tJf8yDbQ4rhsfZ/w?=
 =?us-ascii?Q?0uvXZfwxaJ1+8ejlzZLAOvSbHuzRsWH9IYaU7ez9mc+dEyaItCNw9+RVl9sz?=
 =?us-ascii?Q?K0KW/nhLvCYYT+XP4NtvLCQVLPYtN5cTBO5agGqi5lAF5os8terg2VT6RIiY?=
 =?us-ascii?Q?ulzqLjMdROccES735ym9K9fN2Lz+QXcj1n1lFECGR3wl5KS8SrTkbxLCz+fl?=
 =?us-ascii?Q?YHRgcej/9ImVtO4qgBJq0tSRu0a60BxEv7D7/rzKSSZYN7w61IArXy33tbFw?=
 =?us-ascii?Q?FoMWxtPbpGfbFZ9i/kIwjrBdIuW2ABMMQPvyhoF4IwlZVc+Zuo0mGmXggeSu?=
 =?us-ascii?Q?WYuf6cKj/iBqK2hTX+CsSF3W3UpKjQHConMi/tY0Jo/Lv20u5LpVwJaGs9GS?=
 =?us-ascii?Q?AH7vKHbpQZz2k71uvqiFhFI43L0RIp1SgjC7aaEvsZHgLVsELvbJqUJ5vXTQ?=
 =?us-ascii?Q?XIhVnP1/SJnweF9Eswh0fQrXrsUYML5m2hgiO0n+C7UCWLfU+KnmFAzDnYig?=
 =?us-ascii?Q?xXEBIodd3K8QwGM9nlQkNuOb6F56NEUMKWvzM4pAK45OSjxfQYXPq1AsbXGM?=
 =?us-ascii?Q?kp2BrIVHsDMdQ8SqsHFCUY6rx6koFgd1yqPCwst9XE6WYA1eXiLPykmSU7+z?=
 =?us-ascii?Q?xgzaUaLXXEY2hq2Nvo9KktSzHGjj45o4C1by+8BcQr3L5Un6liVOoMS+xm+Q?=
 =?us-ascii?Q?dK/u93Keg//xDUo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zlJ5rwphAATgGrrRiDZ2dnxhQVbZDuZXbGp6vpCfVF5fSBtROciUoxEefihq?=
 =?us-ascii?Q?EUHAFGur+HDwgXekkvm6dWsQaEaYav56r3y7EMWVOmCcKCB802C2DZaIN9mp?=
 =?us-ascii?Q?ef25mk6zQMJDGQaQYuvxnKAthZa/AFBFSoLLm8dwBk6ikVXrXWjHm8xwoc/D?=
 =?us-ascii?Q?r7jy8pVCF8Lw5R/lr3MAydr0Etka+AkgU9He2Ft+BsDURwNXFNMn7qZ4Y4q5?=
 =?us-ascii?Q?jaoLn4FetC4BTtZuEs15byw953iGEuwXoGgLaaJ1E2rN2Prd/2FdUt/322Oi?=
 =?us-ascii?Q?RtMBKCXfFYL60tBHuOT4xNFoGaG+dKtym6hWD6OVXKHZiRoO6G2Jr+XYYmsQ?=
 =?us-ascii?Q?Ez+t6KD4/P/J2Zxhc9PzKetazzfxEmDqv+gz91/hr+alRbHqb99NYylpYLXC?=
 =?us-ascii?Q?c34xwEOJaTQiOAf0SnPr69OH9ZvaMDOY7MRW/IoNJvmGbwkRwuqu0LFFoSLl?=
 =?us-ascii?Q?7zI3LdNWxj42tCmLmJ0FUQlooq6L+iyJQhNwE2Jv8K9Xj4JG8N+0tNBHgFhV?=
 =?us-ascii?Q?lXEDxisHycTuaxZEFV0E1RUCusBav+aNfqdRPwfdtT487kBpxIYXDPUWUdHw?=
 =?us-ascii?Q?NZ9dB3fayaBccmrYrpafAvniTFWSck1Kf6y14QnG88kXdfQcuu2OdqBLCmcX?=
 =?us-ascii?Q?8LC791RAUjuYtkFB9HqIHgBOOK0pinXzD/F9ctLbLUFKxj5gAR0y5sbj7bYj?=
 =?us-ascii?Q?zGnoQxFwPYCqk33SiIEtdIBv4GCT/uiY4rAA785aX0mIm2GN9lVhd63Itxg6?=
 =?us-ascii?Q?kh968ACOR48qcGQ2GUxAsjPdruTC8P5wHZNy5jlOyLU0s/2ihOKT/Vb/A80a?=
 =?us-ascii?Q?o87IGhXfLwWuGyyp2eFVzAEUWILCZ3E6TE270W2rLEHQr34iQ7P7A9KsSU9M?=
 =?us-ascii?Q?jPiUkGBVr8Flk1h+aEB62u36o1nHSL/mCURDDF8H86F2MD3BIhc6PKvfa6j6?=
 =?us-ascii?Q?xWQCKYvRHyqvZNn5tlYVk6AnspXunCbeOH1pyXXIt8oa+5IvtUFN56Eluj18?=
 =?us-ascii?Q?Nx6P9UzFJSGpfEfz9sGsjqQfhxUPgCXWMUxcb2wsz3jLtR3A47W6cL73ojWt?=
 =?us-ascii?Q?iszj3g3em+SmE1D9mvNHcRuQ79agzty6/uUlD4xW/yPBUcuPmBIKVacnxpCm?=
 =?us-ascii?Q?yBhKduf5S4Ctq8rCsTIDKCqEjmtqVALZKzq2qIEa5PgTzVOHl1PVy2h/lysT?=
 =?us-ascii?Q?Qhus1q8nbGhHM+NOQAAMuziOJ9ZVc5AagQ56fsZHHyQzMLCAiYy8FCQRwqWO?=
 =?us-ascii?Q?pKSsd3msZpF5IXoHMWNiFxLmg9Jd59TvYAE/PqTkbseltJQ5gEWHaPFUbt+z?=
 =?us-ascii?Q?m3HRm4oyWgPJyY4o7+4aEMRbViINK8VwVcs9m21V+UHI1Z7uo/K28cn4yyUp?=
 =?us-ascii?Q?JfbPX71oEvDE4uWMQxa3uq7KX5Bl945JjkJTfiIE7zsfF2gvKl3jBQKYZIBP?=
 =?us-ascii?Q?wu7sO3Nk9S80/p9oaZA9ubIQuVyHi38IEfgoZuS3q7zX7YXOYg8p3iYTEPTl?=
 =?us-ascii?Q?s5vHeBs0tCEUAMlR/tDciJvuEJ2JKgurjlC+Q71IbSkU3fZc60Or9JnYmQsh?=
 =?us-ascii?Q?fIYfhF1B619PdVQSOJoYDpWHT9QwgaKh+MBiqUmSi1ujJ/uq14h5qr6xhFCP?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7fa5f4-fed8-4916-b4b6-08dda4098e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:18:30.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4d27SySVMnxMhsb+sHRUY/07nPBteP8UPFUGFtRS3M7+pyvJyan4vLcLhnhfYpR1mzh4PnRWVrdQ7OvJM6xSAUL9fKRPRSf6Gy2jVA2S0fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6540
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal
> Kubiak
> Sent: Thursday, May 15, 2025 11:47 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; netdev@vger.kernel.org; Kitszel, Przemysl=
aw
> <przemyslaw.kitszel@intel.com>; horms@kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: add a separate Rx =
handler
> for flow director commands
>=20
> On Wed, May 14, 2025 at 01:50:22PM -0700, Jacob Keller wrote:
> >
> >
> > On 5/14/2025 5:37 AM, Michal Kubiak wrote:
> > > The "ice" driver implementation uses the control VSI to handle the
> > > flow director configuration for PFs and VFs.
> > >
> > > Unfortunately, although a separate VSI type was created to handle
> > > flow director queues, the Rx queue handler was shared between the
> > > flow director and a standard NAPI Rx handler.
> > >
> > > Such a design approach was not very flexible. First, it mixed
> > > hotpath and slowpath code, blocking their further optimization. It
> > > also created a huge overkill for the flow director command
> > > processing, which is descriptor-based only, so there is no need to al=
locate Rx
> data buffers.
> > >
> > > For the above reasons, implement a separate Rx handler for the
> > > control VSI. Also, remove from the NAPI handler the code dedicated
> > > to configuring the flow director rules on VFs.
> > > Do not allocate Rx data buffers to the flow director queues because
> > > their processing is descriptor-based only.
> > > Finally, allow Rx data queues to be allocated only for VSIs that
> > > have netdev assigned to them.


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



