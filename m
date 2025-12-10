Return-Path: <netdev+bounces-244292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1FCB4247
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58B430528D0
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 22:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DB12472BA;
	Wed, 10 Dec 2025 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0lbk5m3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC3258CCC
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765405743; cv=fail; b=fqPPu4oNawgpp8rHEYFcJKz33fxzroUBm+4XDTsLR0NNx8kkJtvO0aVb0jxtAs9uAesjOeC8LZNcmiuscCq2ci7rGKrLJ07g1Qa18+8wtF51VkswSsaPSvpQkztx9Ut/KUh/H6A3q2QF6BouE+3WUMCL0VPb4fWgn75lUy3htwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765405743; c=relaxed/simple;
	bh=32wIx4M/qR3lXsudbPPEGbAhbiDRhfIc4ZgHpmciXbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqJVA8/HQEfaeYL05v/x1NUV4OJSPYcgtqkMIXA0ANQtnc8YtmW0fKLv0hxpHVXslvC+UDYnll/Yk7QyqeomEn6cbnDZi7ps8n1Zm8YvUUmZUlnZ+ZaYSeMjKIknbLbikYkdkAQz4QMNwykauzyBj3GSogGQCy8aLLzWWySGapw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0lbk5m3; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765405741; x=1796941741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=32wIx4M/qR3lXsudbPPEGbAhbiDRhfIc4ZgHpmciXbY=;
  b=C0lbk5m3drgPzDopbsHr7evAPfBIN4iuZGsPi1Ck+VxS8GdxSsk0V4xF
   ZBhXNJnGgMP6TJZ/JlIYlH9AU/wTsFGPPmqz9SHl2ZM8rwPF9Hr5qzo7z
   wuCqnm48VN9GCadz/VHhS30UPtal2FdyBtI+IqGTI4Ox5WT1wn5/bsabt
   0psjZojK5P1fcaiQ5pzmiFkfVSiqgOOuG5eAxN8FbZBaqTDm10h6UO4dv
   M6GCVNRYNOw1iXlkLQ1TEi1FCIHMYHap3BgdXflYxWEusg4q+QrFA0kF5
   nWIYgbSW9lWvk9wVOB4PnXVVhbUeNe3IaySSlxpZUHGEO75vHngRFJxKS
   A==;
X-CSE-ConnectionGUID: 88nRKMhJT5CUv9QEBX+8bQ==
X-CSE-MsgGUID: dbWHUPDfQDqR99EUADgCGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="66387406"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="66387406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 14:29:00 -0800
X-CSE-ConnectionGUID: AWB6Ka74S36/1wnZOr4DkQ==
X-CSE-MsgGUID: HlHrZqTGRfKO5h7m5YznHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="197437508"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 14:29:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 14:28:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 14:28:59 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 14:28:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7/S3JhrLbgyym/GZIL8br7DLZEOJNkt0zuAhIsRnshJwG9UHez+5uWfjn6Wt6bAZUImOJWfUlrjc/OOpW/88j6l86JB40jMwLkbJ4XIpnb6xjnrWB/ek3xKlAyZ2swiz7ICNr/kz2BLppMejADOSfUzScoKTbaf0kFDN6+nyeKpw2dP7GClZrCHcuymYoli3OILkVch8zyH74e94jP9qwjjM5myVtfTRJQZySTM+VbFvjys4hu/kGlfSSmHZVLVxiMelLz3v7q3ffurL8F27fkiNuyUa5/ryKCopfFrNtQ3FTmbYmK04QvqCvxMwpfcb63INbnV0lIMSaDN9PsXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8ohH2tlGefkt3JIjJgy+dftt7NmaERTSz5AjSF0VQc=;
 b=jsBrxKYarOe3jv7jA7wzf96ti1yTO4OG4pIvkt6oFa+d/9xdCouGjGvLazM0WKZ6DiuF6TI1TVWZTsXMC2IA3FEy3z9cQ+THBJ3SbMbkaK3lEKpLYYmW+MrV/9qfGkcnif222kry+mmLLqkrWCmO/EfJQlBQvs69Xo+j/bBhaaP3zC8KeSvftoPWokexVay8tiqH7HP8p+3t7QWEJu9y55Pur0a1Ps2C6jZ6lTCgAaC1eIS7ZaG0a/G2SclCAWFdzVmaeTUQYUBvYYlBsDgLKYqKMVInQTBWPF7tR9Cmg3LzdOrCMJEPiDe4EV/NhHVKbm0CDPfcYMs+GtVfzdsXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 22:28:56 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 22:28:56 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"decot@google.com" <decot@google.com>, "willemb@google.com"
	<willemb@google.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>, "Chittim,
 Madhu" <madhu.chittim@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"iamvivekkumar@google.com" <iamvivekkumar@google.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/5] idpf: keep the netdev
 when a reset fails
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/5] idpf: keep the netdev
 when a reset fails
Thread-Index: AQHcWnyFddXXHGiemkmRtg1x2KxqxrUbijlQ
Date: Wed, 10 Dec 2025 22:28:56 +0000
Message-ID: <SJ1PR11MB629772C23BAB21977ECFA1389BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251121001218.4565-1-emil.s.tantilov@intel.com>
 <20251121001218.4565-2-emil.s.tantilov@intel.com>
In-Reply-To: <20251121001218.4565-2-emil.s.tantilov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: 2efff89d-3331-4e23-4064-08de383b818b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?FQc0U8YmZUJ1WfteVFAOsPL41c61f/egQIHSwXSxvLvBlgcKa5vIY7dnbvod?=
 =?us-ascii?Q?d1FIz/Qwkm4UAD86McpOOZGB21ev8YuVNvwqvNuRTaRPOla3MipuRxUuPMKJ?=
 =?us-ascii?Q?abc6bxbGthDLihqgp5YFz4YS1hx6IPJQ/9MY0Kap1qfqQVtjURJjekacdPjW?=
 =?us-ascii?Q?B/YXxDl8X6Mxx1ar3kHQqAyLAeqpVqyFPgk6A1pxqQhgHINJf59p1EznOPTF?=
 =?us-ascii?Q?riCBQvttYauvgIox1fK+6doVPl7fZHjnA4sB749REiwdgg/atFPm5QypvoAm?=
 =?us-ascii?Q?/ExarPWoqwcJ7Vr0pLvIP74fTqfhFoV7c6ftPtYF3gbX/jYgy17xm21Pcrih?=
 =?us-ascii?Q?cXvzuPhOCbSkHKnHtlZ7jCfK0Vo7N+U9HJgBSi0ps6n3lR5H0F/nPHYbGKye?=
 =?us-ascii?Q?VEZ8i7cErFugsrp8god9U3Cgc+y4NgP3EHM3/MW90qoapjQ6zywW7DODn1/K?=
 =?us-ascii?Q?ioUkwxzPBrJ5pqG3tlXzR+3coREG+qtUuvLIIn98DulwH/Ho6TtmDt5wEv5V?=
 =?us-ascii?Q?Kgfih31eVibio/ZWuvEYBPY4pI0+3zTPzij0mTDDx4f6MjTUeNAwnCxhVBJe?=
 =?us-ascii?Q?GsG9SGPKHL0TRlo+uDfM+s/khhc4bOcXC0IYVbpC5/dxtIeFfZNWrYmOcMd8?=
 =?us-ascii?Q?sVxx3Wscp6A/lZpgp3Zs/4mHRWQSM5XQs+0Jyhsf+G+Z3AdFi8EfGD8ciEVI?=
 =?us-ascii?Q?DymHwudrzSVTBLERH4Wd7OnXVRloDqCEV5UtDxhy262bptbiMj+Uw2U2ucWK?=
 =?us-ascii?Q?2EW0P7RY3C67aKFPBJhQ6prKeLC9lV/CgUYT/Gqy0J5yfLVHGFpO5MLkynuK?=
 =?us-ascii?Q?R9LtPUqpoFHPojU6PuyinmL1lN+27hFgBFvWvjYyUcee3Xbfg8hBrOrplkYq?=
 =?us-ascii?Q?i6Fe2eWUUikGdrMXvQsgbSuih7JwD2yl7S4cE5liJVIvTZCa9cBH1Td+nl7p?=
 =?us-ascii?Q?agdYwwFlrkgQ9jygdA9iHdDiKgZ4WSFr5JOVjR3O5BrE62evuFVZz8MKHwpR?=
 =?us-ascii?Q?UioY9IOOBFqBYktFhv9zS2aG63UBUqke1W7UbsBm9hrPSv3s+0UXrOSVfAJS?=
 =?us-ascii?Q?aSSGQVJT0T2+qYLFBgQda+BCVucuGYBsAwT4WQoLc5bxISJdLVuxQqCdHhKr?=
 =?us-ascii?Q?gBYEZPQsbkt0oCoiubw4d9GnulJr8eXkoIVi3jATqpUk3q8R3hodI/NRrnuv?=
 =?us-ascii?Q?yE6QYMDFTNL1uONbXXdK536tcPMYQ0qW+FAPb+NOsJOz5+9fWhr2vJOBNm0N?=
 =?us-ascii?Q?aMERsHh6o4dIwHQ3bhht3q9fb+Iij5Ymen42Qx1LlUMomoFGCDXgAPSyOlDX?=
 =?us-ascii?Q?BTYZykUG2zWqFVKFPRnAUs58qQvWkcLkQDlYkh90HEI8Cn8Yq9zFTpBIbpal?=
 =?us-ascii?Q?j3CW+WdjRhDwHzeTV5ed4Uqiy/VGQbomxdRdBMWF6WxFRiEfuWNdmxxu3Vtf?=
 =?us-ascii?Q?49qqUDpSe1lmCQujaR+bVr0HtpLsmixUuCON3A1YvTb/Tue+l/AH7ZXiYsqU?=
 =?us-ascii?Q?t58ubk3AiGOFfuDVeEtB/2FASzqXiKgEg3vi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WuWgUPsU1vqHqJJwzZRuAthYDtyKph5470/kc/u2n7FBwdmKYgEEt7H5fFJS?=
 =?us-ascii?Q?TU19rrvBbxHNovfsHlrr5y4zLdkdOpNahsz0YKcoF+WUZavLlPgMuBAQa66i?=
 =?us-ascii?Q?Swhlf25vO4oMAql0sRYA9yK+Iz+uwhBAs+QB87KB/poHdmM9yPm+053eMyBB?=
 =?us-ascii?Q?DeFAjWEdi0Oe5TO3b+aiw4GjL5ZXamHlVZsWPK8W8b9CQio5aAap/fxYQerU?=
 =?us-ascii?Q?+ztiFyOCN+ItjCOpE6T4gn9FARbt7XBKsnni8QWd+8wbiGifpUelK+KGs9+J?=
 =?us-ascii?Q?uUNEjkZ02dn+BZphtuw7z6Q+eLXPRcgjBOn/OstNqQLZ18eW6MrbmcHnbQSc?=
 =?us-ascii?Q?DDJHXduiiOnICTncqIXDW/fCQbtfQlNpThaZUS5F4sv00y9IPUZaClHtVkrJ?=
 =?us-ascii?Q?G6AITHhptmmuNMzuNJfYpCo/mfgk2oIIAOyYnX2OMXeL1JFWzwbC0abGi+E0?=
 =?us-ascii?Q?cjw4tdKLlvfrMyP9n/lnWPj8GaKpnuIrnLaOH6vYt2O0kHkE1f7YNCw9oG/g?=
 =?us-ascii?Q?xYpRDbfRzMOWptzHpc9wNxTsp/awl9uN55DItlVvp2NMoWhR0cVuvCcIeY07?=
 =?us-ascii?Q?DjhuVV7m23rKTPX5UuWktpeXL/fvwSthJxoogQVqxYFzfT7zckvGlexGGCVi?=
 =?us-ascii?Q?3HJyXwoAMHJM1peBNjWxXkF3qje1ml4APthLrzJyuRPkAhB4lcuRR84q8Mty?=
 =?us-ascii?Q?yyQ06nAePz8aNSja7czirsWO5UJ5NaBUA7q/NCRvPRpwVGXt44co0JjuTb6T?=
 =?us-ascii?Q?k63G7R1RGfXDbdOLySPiogpvQ3fIDKBO90q7XaMzcxGFr2MZzi36opZdSwgA?=
 =?us-ascii?Q?ssYZ/3rNyYxxjJxySzGjhOg9mney9oyOJIPeCDiDaSLT8+tBtc4H7XwOasXN?=
 =?us-ascii?Q?gcABNeuOGBARAZxqxgqoMim12iJJOIDLKeGbsQbvRGptGcQQYwDcrVZdZazX?=
 =?us-ascii?Q?RJjabBzKFR0LtV1rToskuAnElcbvw7OXdFRVYLpf4Dh5Jxg/zD6V6Uk1ec0I?=
 =?us-ascii?Q?Ge0HzuIXd5LFC2NAGyOuC0s/UoUmEBZ0EA768dAj3XVBgqPDDqh1bFH8lzP5?=
 =?us-ascii?Q?DK5b0lS1OXjLfprmPUJ5EIq3rP9GdLJOxQRrhhu4pZb4H1a2fpO0jj6EhF2m?=
 =?us-ascii?Q?Z7IwyQjKGDz6NHp8fErjD/qKG+7uWPeYOUKoQqvtAOOQHWA0lejT1bqxd3/v?=
 =?us-ascii?Q?r+yv18E1b8L7nxGUE+zF7cv+nLWrl6hqJ9JZ/Rxo23CaFcAVKSSVl8c9v5iW?=
 =?us-ascii?Q?GAQUcKuYuUd+zOHe6ultfp0egFALkYZCYwD4b0oL9RNuovcJ3zI/LM4qH6ct?=
 =?us-ascii?Q?jozRXghiYyO9CzVW2+QYnJxcyfc4Z8f5ug/NtWS2d+2ImUVHr+w7YPxEVIKy?=
 =?us-ascii?Q?CAm92Ubv41l8KMIMdzFdIF9KO2ItdvVFIVQ5LECkuQQU83tagGfyMXYQHlP3?=
 =?us-ascii?Q?1v7k4t8YcI0aEspTKwkXzedRu7Agt4DemOo8wy42WK5N03NdnVSWi1nYe1gx?=
 =?us-ascii?Q?jmZfLVoD9JDOZJZIMIurN0BQZPRgETvTUP+4GiWmDeXp+fylHwNv0wZR7HIK?=
 =?us-ascii?Q?boX0ufxHDbRjqNrMGJ4c5JPYIK4bS0XxuG2rfUy5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efff89d-3331-4e23-4064-08de383b818b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 22:28:56.0590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0oHVr62rd7fs+Ng8CGrx+SciEFFQVURU6zuTD6WCx8sSwVvWVee+2caJ6pgPQIJSxad39GmZdTKG6hTcWtm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Emil Tantilov
> Sent: Thursday, November 20, 2025 4:12 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; decot@google.com; willemb@google.com; Hay, Joshua
> A <joshua.a.hay@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Lobakin, Aleksander <aleksander.lobakin@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; iamvivekkumar@google.com
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/5] idpf: keep the netdev w=
hen a
> reset fails
>=20
> During a successful reset the driver would re-allocate vport resources wh=
ile
> keeping the netdevs intact. However, in case of an error in the init task=
, the
> netdev of the failing vport will be unregistered, effectively removing th=
e
> network interface:
>=20
> [  121.211076] idpf 0000:83:00.0: enabling device (0100 -> 0102) [
> 121.221976] idpf 0000:83:00.0: Device HW Reset initiated [  124.161229]
> idpf 0000:83:00.0 ens801f0: renamed from eth0 [  124.163364] idpf
> 0000:83:00.0 ens801f0d1: renamed from eth1 [  125.934656] idpf
> 0000:83:00.0 ens801f0d2: renamed from eth2 [  128.218429] idpf
> 0000:83:00.0 ens801f0d3: renamed from eth3
>=20
> ip -br a
> ens801f0         UP
> ens801f0d1       UP
> ens801f0d2       UP
> ens801f0d3       UP
> echo 1 > /sys/class/net/ens801f0/device/reset
>=20
> [  145.885537] idpf 0000:83:00.0: resetting [  145.990280] idpf
> 0000:83:00.0: reset done [  146.284766] idpf 0000:83:00.0: HW reset
> detected [  146.296610] idpf 0000:83:00.0: Device HW Reset initiated [
> 211.556719] idpf 0000:83:00.0: Transaction timed-out (op:526 cookie:7700
> vc_op:526 salt:77 timeout:60000ms) [  272.996705] idpf 0000:83:00.0:
> Transaction timed-out (op:502 cookie:7800 vc_op:502 salt:78
> timeout:60000ms)
>=20
> ip -br a
> ens801f0d1       DOWN
> ens801f0d2       DOWN
> ens801f0d3       DOWN
>=20
> Re-shuffle the logic in the error path of the init task to make sure the =
netdevs
> remain intact. This will allow the driver to attempt recovery via subsequ=
ent
> resets, provided the FW is still functional.
>=20
> The main change is to make sure that idpf_decfg_netdev() is not called sh=
ould
> the init task fail during a reset. The error handling is consolidated und=
er
> unwind_vports, as the removed labels had the same cleanup logic split
> depending on the point of failure.
>=20
> Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> 2.37.3
Tested-by: Samuel Salin <Samuel.salin@intel.com>

