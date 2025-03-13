Return-Path: <netdev+bounces-174551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAEA5F23C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E3117E51D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1F26659C;
	Thu, 13 Mar 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIdRDqys"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF40266593
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864855; cv=fail; b=Aoup6plJY86Qv9h4o1U43iqlT4EYxZcAhw7Gkv94tx7EdLXGFoTh+bfvxUT47y+gOxAixtGkCseLKTQBtrCaPzDrBWHr/WQF6LII3+mJJ3Nf0BsRJeIKtEPILwf+B0dPfmeCPtHDzbHmN33sAU7NUOTYZfgX8LV6Rq6hQ4r8C0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864855; c=relaxed/simple;
	bh=sn6z7wgXi8csXwD1KHBaxt9h5qocV5bHB0CIC+wI2bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fXL+pz2x+CHEeQkwv5OSWeEZx2DYQh292RxrUfbpX4r8jUvA5gf+DoFJwdnAzd6h85LGoBVUYHNn6Ew2ZRfoOh3JiD5hYL5Mf3lFXFTjmQsRXM8KHBUy1TwMu3NNrwdA73hIaH4ASjv98d98SjOvn6CrfODqp7RuN3zt/dukN8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIdRDqys; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741864853; x=1773400853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sn6z7wgXi8csXwD1KHBaxt9h5qocV5bHB0CIC+wI2bo=;
  b=bIdRDqysj3w5WFY7ALfeJHlNM9LH2gKK/JLITkSacsq7isRCwUvMLnKv
   nVY3MAv2epimRkAcIPCGIl4O0/hjkRlkX5vyVKAqTPWRDkfQ6QVQBq3ZY
   KRe1G0WGMt35vBLoWPIfLfigFIYEK9PpKwdc+dp0qy+vS2Fyxb6CtoHnf
   joE59sRhO2ogvgjKuPcvO/SU7NduCBQhgQ7rQPVOc559PXT+FvJpqhQNP
   XoEtIFhTFlLCltPRR7cVZQQcTAAoRiDPfhYu0JMruuAa0oRJL6kXTHsz8
   QYc4zG12ALqcVfpN76hL95dEDiwF711ocysJvAT62DSrX2Hkynk0bxo9y
   A==;
X-CSE-ConnectionGUID: Uz+JYafKS4OWmV3fCMY4CQ==
X-CSE-MsgGUID: iVs9bjy7SNWb1GQmUFLR1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42837829"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42837829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 04:20:53 -0700
X-CSE-ConnectionGUID: BIzdCyC4SBCL7kUZoZCwKw==
X-CSE-MsgGUID: 8Av6PamsTOeTCfGuMq8PQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="125998761"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 04:20:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 04:20:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 04:20:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 04:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKlu5jiQMQg4NOUv/3u3H2SBxpkq7AwoaglU9RXsA86LEJ1XkaTOlSFsW0LaXTErqIgDPqX6mG5KbbpS5Yhya8wzGjKNiW7ReeVNhL6tKjibq4vEbSdz59NyjtQHzYcBjFN3Lo9ZpkuVUcxJPpX5GE6k8m5NnLiOMytCoM9uuQ7V1xextwg5X3RLVFRhpqAyIVgqI9PskGtWvfHAW75XSKbVW3IRSprBYTUTgkd92r3f8GuQsVPmRLjlPVHo9nm52NMbvO/ochKadGzHTJV0HBbF1UwG3kYoP5FhYHINv1Y6ZriNo/IoCosLO20F248LqEJFDR84DAeqLjC0US6a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOCqOKKgTu8Tvg+6AotFIYaKpBM/54BlzUdxwP+LRI=;
 b=gWyplpKw6UC/WwU/YQ9WsQf3Ba+x4T8JVyl4I02VLKcBYr7hQMUC6Gt5/LvGPHufzC38RauUWGNGUwY1WG0SaQZdNgo/MkrP1z7CDA8p19ooAskug9HzD5Iegrxv1Upa/lytvzvXaRN5HKUx7rNrr+IzSlNXBL4g1FZdfRzh1pFjlCeOm5tBVkMy0xoqyquTwhqelhaIMpNrnvhiuU3HVST3UjRpmT1HuLGdMWTGzDoTohMkfn1OV9rD5aYMF0IOI1I4W3/521S9o1DmX/J3LA3pU27hKAq4D/h466MAnZwgFuJbShySrZO3mG3LUZgusbw8F4jpeg5GTuEUi/YlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7785.namprd11.prod.outlook.com (2603:10b6:8:f1::8) by
 MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 11:20:35 +0000
Received: from DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18]) by DS0PR11MB7785.namprd11.prod.outlook.com
 ([fe80::7a4d:ceff:b32a:ed18%6]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 11:20:35 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"R, Bharath" <bharath.r@intel.com>, "Mrozowicz, SlawomirX"
	<slawomirx.mrozowicz@intel.com>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Wegrzyn, Stefan" <stefan.wegrzyn@intel.com>
Subject: RE: [PATCH iwl-next v7 11/15] ixgbe: add device flash update via
 devlink
Thread-Topic: [PATCH iwl-next v7 11/15] ixgbe: add device flash update via
 devlink
Thread-Index: AQHbk1CQRKQJSyhTKUitpDaK+mHQLrNvlvcAgAFVKIA=
Date: Thu, 13 Mar 2025 11:20:35 +0000
Message-ID: <DS0PR11MB77858E6458594CB34A19B0D2F0D32@DS0PR11MB7785.namprd11.prod.outlook.com>
References: <20250312125843.347191-1-jedrzej.jagielski@intel.com>
 <20250312125843.347191-12-jedrzej.jagielski@intel.com>
 <20250312145530.GU4159220@kernel.org>
In-Reply-To: <20250312145530.GU4159220@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7785:EE_|MW6PR11MB8440:EE_
x-ms-office365-filtering-correlation-id: 5394b381-4466-4714-193d-08dd62211376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BCMdvjLxhKmisuro9j/F6C8AlC2JUpd8w4MLaPE7F9bxk4BGb0J7g1hqzt42?=
 =?us-ascii?Q?lp3cJ8tOBhJaFGP+J0v9uDv0qKD0nHbffkpz20FL5DgKu6g4pDQ/KkeNw2us?=
 =?us-ascii?Q?8jzev+p0FRHHb1V/nKiS4MxnzYwNOpoFX54eVxNn0LZzLYXwJpQEA1KR1SNn?=
 =?us-ascii?Q?muoBsz67GoRDTvIYMPvPkNHQkl306HkJUXDJgeJdMXS6DobZgKNMyktnfuOd?=
 =?us-ascii?Q?hvdmTnF3doqLydyy2L4VDmuqbq0zPI5T4L+hjwevHktD46elZYIYe9HmybDt?=
 =?us-ascii?Q?gP/dUkrwB05f4xO88UWzzcYSS7c6ilgymMT54UxBQ+W2zBunXTzM6ABWUvl7?=
 =?us-ascii?Q?1AO7ZOe3sKxrfZoyRu9xAmeOZd1jiiauBR74ejKAND046mrDfIs0czz6DcrA?=
 =?us-ascii?Q?ROG5u2aOUQTwDd0YcRK1emYhEIsIZcjcqLDoH0272+cKCF54YrfxtpAIWQgP?=
 =?us-ascii?Q?+/0q2Z94n9LeBq2FLYPuO+y4gnl7UQww+4ipxi3i5dti2EnT59V02K2RjU2P?=
 =?us-ascii?Q?JiavZETyybBUQlWvyflpeN8L9VYL2bhCvT6VFvKXYbe0rb5Rg7Sz8K6pCO0A?=
 =?us-ascii?Q?atoOwRN80ZWCtEFAYez0kAEfHN3hqiBJl2kM16xr47wK8xR9+1boX14LTPGr?=
 =?us-ascii?Q?nvpeNGH1FXAaCyUFxdCqZSH4IUyczsBKL8vFZxNZEA3M8/7CfvUHwreLIe4S?=
 =?us-ascii?Q?+YX/Xc4uRdVlYJPw/AbiNvwkHNxK/HZVOttBVSoOKfOZL4N/al+YR80QzVzj?=
 =?us-ascii?Q?a9JXFW7L8ZVjLhUTQYjrPT9IHdJkf6aNahb7czA2pDwP2F6Z9t386TCEGFNh?=
 =?us-ascii?Q?luPyTQmUpIDXrH7MkuWh2Xm71OcAKQMfBk7+fXFqJypNKbS03Re8UcSoqA15?=
 =?us-ascii?Q?A3GSm4lkyrOokg06MB4g+AmNFTjlp/wk/JYXnXWj0k8TBu5MHo5ElbI1Lt7K?=
 =?us-ascii?Q?T23b8JlrrtTXrm5WF+H3hYoWSQGkYKE/BbU7PvECEoEUHYlP/mF98/mUz0qi?=
 =?us-ascii?Q?cQMzDx9jcvs0cf2CPEz+B/lvdUMYHy5IQ04rIaLWKxy69yI1wvkn07FkTm70?=
 =?us-ascii?Q?tLq82y5lPIWckOXTkn8ECcWRLHD+F72illL6i9SYAVk8t0368ipdclZ3zydo?=
 =?us-ascii?Q?zSx+dKeYz7AjcNZ/Y6RygZ3cHvpgdotCSyfnftbm4tGbiYhKFX2zA7JMgnYr?=
 =?us-ascii?Q?dH2tjl8nJQtNLlA+cH/tC+G09PVCL18P+H4ClsO0XJx3uEhL20xDAuwFqeDX?=
 =?us-ascii?Q?YwZi3W9PPjJpA6inwUfUiRgqN/MTuxU0iadKDI6FyPGSC8hm7iV3ek3y4p46?=
 =?us-ascii?Q?5ZylXYarBALj90OfGmHrtpJJ5HNscL7i+C2tJrEx6ZmpolVYyWGsSirlVhMb?=
 =?us-ascii?Q?mevnacogCizO5K8fK5vF0od1ZQTe9MxdIdAarGjE9hQfjWgAQL3B3YzlzCbZ?=
 =?us-ascii?Q?MhroAtbH4AcEsalxbmAw4wGm9OSKi1eB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7785.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MLIBwJi24n+aM7ms1doUGno/HQ1ruhYg3LSBigOJeR7hWxxqiNDMNzemN8Fl?=
 =?us-ascii?Q?TjrcSZ87v03YjjgiwhkTiGZYSCqnxGaBGHC9B9eJC+EC0BI7r5HZNqi+lpi4?=
 =?us-ascii?Q?Jqiepn4ChdUHkjnVe0D0H5mIlClH3JXv7Y5yQcq89VncH6uUXcGoKtTNO2Ut?=
 =?us-ascii?Q?x3TvbD1QyX6sZeI5UY0uZk0iN6ZsKA8Oh27ji5bcaw45ykD5OTyLkmYDIFMg?=
 =?us-ascii?Q?Tv6fRGwp7sQk1uwZ1VJzvhoIOqunnfOXJ/JJB0QQvASghQ/8LtKHmFhStUbd?=
 =?us-ascii?Q?DTFG2DecbuqObPuw/K+ztg4JYMqSNsQGoZPn4lH5ZR75PddRVjpk7KpQQwfz?=
 =?us-ascii?Q?V+TiJrHzo2/D+800u5PEuW1bIbdWqi77CzmpOucWPfiEL16UCAY8Di1dFHMA?=
 =?us-ascii?Q?RCLTsH7d593C9dmROkPNZqk5UAm9HWgeEK4kprVef/KJ/L9CiAILsfhX8gM0?=
 =?us-ascii?Q?PbbA4gE5yQCF/o81MX7ekks+SUzOho74geFMNnFQy8AIFRrpCkk1eDQXU52J?=
 =?us-ascii?Q?zQ3qODnohJHBDkkwAdrjQv0e+qi5QXZ7F6OsghDMm09n3kBWxI4MXZBG6mdJ?=
 =?us-ascii?Q?M3HQLo7RODOl0yF66qG/SzQfCHVl008WEkaAhUiqGNB3/0e5hXWp/9Exsmxl?=
 =?us-ascii?Q?866DLbsTbbogbSltNiCyYuTNCxlrae6iFsbeeCoYdBAMSkDRRG4kRWKvKUkM?=
 =?us-ascii?Q?TKyRxvhSMiEJXh+32yEWO5DURnS0QtJiLAZzZg+ZzNraNW9tebYeAdptIN7k?=
 =?us-ascii?Q?zV9FFHaSeHuNxPrbFWWgvPp9Ro3RDYZ2t/USJzfd4cw9YswhwaE8Ov7U6inq?=
 =?us-ascii?Q?kPRQ5kU6fNbLA1BMGgjVoEE1oCxTQ/qSmYzFaXoUHV3hdpaqNNa+ZqX4phaJ?=
 =?us-ascii?Q?Hr1T5QH4GDu0rOAz4BqPgJO7NPBWxacKu53aaBYD13uFH8YEa/T6c/BdsPDF?=
 =?us-ascii?Q?JqXwDjIuhYEGAdgkLTZV7Su1g6LglLpuIvDR2wPSgpMH7Nf0INcDHJNVCytK?=
 =?us-ascii?Q?2kvygNwBPL5vGK7gdwqrgWhfYAfWkxQikNUSiEZtqxZAYzutqBAD/rEBH2mT?=
 =?us-ascii?Q?ZYfvmpCaqwlBzIlI/Ep1NWzrtuh4gCsm8N9JiJj1VREaldcBNVyt3ctE2WNO?=
 =?us-ascii?Q?D9WYMX6Rdxe0lR75IrgCCR0l73jZ7IFkI4wyAjqg3Y7lWHxl2Zwz3XPSF+vT?=
 =?us-ascii?Q?uTsWkKLbfjQuUmJRrsl/mdCyM/MfBa9eaLdqXdeI8K+UFWmBQeiihHokP31k?=
 =?us-ascii?Q?KkvjHu2gU9I71bej0KU61QTmixW3Gxmv9G7VvG3FGg9wWTPXsy9OPIGN1HF/?=
 =?us-ascii?Q?FtwPWNlqFxMI/NKiKgXPymuXQq+k1Antvt2GREWUoooReNgO9ludbFPpEEXY?=
 =?us-ascii?Q?RTQgroNofEtAx4q7gNV46E5hKg/UOffRUY2JnDlmTxpYVXu/QCZDW4l9QszG?=
 =?us-ascii?Q?T5g/46TFXsTPW7mvxRBRWWi6asyAe2zDEmRh6YGXHnFkT7QvTHkbJv//uSrF?=
 =?us-ascii?Q?iKXYsAXLRb0IgFhwQZjzKnlRoj5bQ8r1MGbRzEQdFbBC5T4rDGHYxMaijf2o?=
 =?us-ascii?Q?6e4+FdaiSeozLbVJl1ZSCsPeGPmo0/o3rGkzjz5o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5394b381-4466-4714-193d-08dd62211376
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 11:20:35.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgIUJb+VqmVydWJXVnfGbRLWXW4SDaeO38zon7Gg0FF1zOrZOosturoMyTdB88WX+xKT5UNlbYM6JGF6WXn/0xpOr41bzfdCKHC8KFDMCFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>=20
Sent: Wednesday, March 12, 2025 3:56 PM

>On Wed, Mar 12, 2025 at 01:58:39PM +0100, Jedrzej Jagielski wrote:
>
>...
>
>> diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/=
networking/devlink/ixgbe.rst
>> index a41073a62776..41aedf4b8017 100644
>> --- a/Documentation/networking/devlink/ixgbe.rst
>> +++ b/Documentation/networking/devlink/ixgbe.rst
>> @@ -64,3 +64,27 @@ The ``ixgbe`` driver reports the following versions
>>        - running
>>        - 0xee16ced7
>>        - The first 4 bytes of the hash of the netlist module contents.
>> +
>> +Flash Update
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +The ``ixgbe`` driver implements support for flash update using the
>> +``devlink-flash`` interface. It supports updating the device flash usin=
g a
>> +combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
>> +``fw.netlist`` components.
>> +.. list-table:: List of supported overwrite modes
>> +   :widths: 5 95
>
>Hi Jedrzej,
>
>make htmldocs flags two warnings, which I believe can be resolved by
>adding a blank line here.
>
>  .../ixgbe.rst:75: ERROR: Unexpected indentation.
>  .../ixgbe.rst:76: WARNING: Field list ends without a blank line; unexpec=
ted unindent.

Hello Simon

thanks for finding these.

I will fix it and resend it later today probably.

>
>> +   * - Bits
>> +     - Behavior
>> +   * - ``DEVLINK_FLASH_OVERWRITE_SETTINGS``
>> +     - Do not preserve settings stored in the flash components being
>> +       updated. This includes overwriting the port configuration that
>> +       determines the number of physical functions the device will
>> +       initialize with.
>> +   * - ``DEVLINK_FLASH_OVERWRITE_SETTINGS`` and ``DEVLINK_FLASH_OVERWRI=
TE_IDENTIFIERS``
>> +     - Do not preserve either settings or identifiers. Overwrite everyt=
hing
>> +       in the flash with the contents from the provided image, without
>> +       performing any preservation. This includes overwriting device
>> +       identifying fields such as the MAC address, Vital product Data (=
VPD) area,
>> +       and device serial number. It is expected that this combination b=
e used with an
>> +       image customized for the specific device.
>> +
>
>...

