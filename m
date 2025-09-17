Return-Path: <netdev+bounces-223976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F75B7C623
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B731BC39D2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A152356B9;
	Wed, 17 Sep 2025 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlBLOFzS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC302F3617;
	Wed, 17 Sep 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108170; cv=fail; b=Ym0UMu4p+UzIT5QmQ3D5MLlWap5cYCL9btRxOQWaEYdxS6SSsYrQXSuKebFoJwRHEnkFvZr8QaWgNLBjeaZbUNIJSjUOFkujNfIRQfVZeEzGtY5BJoAIQFrFgx0+ssKIi8MroLdhsMO/D7Lr5MLrLQmCwO1s079jxX6hJSwNTbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108170; c=relaxed/simple;
	bh=johX9C7ivAgtdKw2Uu15BJPwdheltOB87X3uBK1e/YI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UoFw5qz7iPlJKdC1t5PXAlIpFBWfStd/8XAICEAWQJDm6Ijc5pQA6g79juZT12Noo+v5xJIanyS/3vc4rpJ+Z+uVCIE3B63c9wr3L9gbIDawK1skCQYNEzFJQzQikmvTtMD7OnmS0lkQa9aJw8EjlVbAnpcG+HtvFmFWGbZLk4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlBLOFzS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758108169; x=1789644169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=johX9C7ivAgtdKw2Uu15BJPwdheltOB87X3uBK1e/YI=;
  b=FlBLOFzSpD4wyzL+uENrTZyQKA4ZLkyblvFb65xGv3EEZvGtWhiryMvI
   9LHbKYOlktury8RnheAdIF6/qOVNsUYDhDXteAyHFPjbKV9Yg1/2l5TtO
   WpT9xADG3RyWMGm2RNZzaZSGrgietZ9lVIWXNOCFJgc8wBTv+okCz5iaP
   jfDjFrBRtFSTpoEeRYTxnGF1AGOtGxiiYfOQowHKTgamd9pgnQhO978GU
   adKuj5J+4qAYLbiXU5MVeOQb+zMagEhEsX6dd05rwVKd/X+WUrXwIPXRy
   jNeZU3ugA0oLL93zWBrsq6o0EywL3sxkWWuM2DAbeYAzUgX/HUfOYHzfS
   A==;
X-CSE-ConnectionGUID: YuPmiqutR/Gf5Rxt+KXxsQ==
X-CSE-MsgGUID: 8bmsRp83RwCsS3Zh6IQQKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59630118"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="59630118"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:22:46 -0700
X-CSE-ConnectionGUID: gyp2AoYUST+5Y6azK8q4Jg==
X-CSE-MsgGUID: B1XeK6dWQxWkzjso99Bvdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="212368753"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:22:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:22:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 04:22:44 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA+GPgEHGd/zh1zf9K58MIPywbspxR0BAlt+3UGQjccEvS+Qu1QmGBBscVlOxhZ+zYwRLLNGB/fAqKMdRmf0tSV1w/ButqbWBp5XAJhEubw8/DNDGE8E5IA+L5cifQ2u6Dw6R3CIk9HBZh9/PXyRVUNvUHuesMJ/JAnCIwmOTDIgysk8q292D165uzjEV8sdl9SFqIJThxbWzIxvRzLurtqDKiINzs/kloYpX8TI9bLSCMl7Ir10YJnVLNXah1ExE3uvAC0pgFjte+xmP3tGL+dtRQ37zjMDgylfYlIE/hONJG2ZlzGkIA3bFvb3ZtdG98efCZrRC65I5FOvWEQbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=johX9C7ivAgtdKw2Uu15BJPwdheltOB87X3uBK1e/YI=;
 b=eyewq3jkY9Ghj1WED5f1FxvPyxhMnvHF/4Kymr9drHDTktXxgRFpnh0Tst5r9FaDkmtp80Qu4QSAQTf60nvzDVfcuQ49/rzncqiVfRK6b0o37IHIBwEhvSdXEU3vfSCl1Z1iZ9uHSyrcc8g+cdUpQXAfBI2lPZt7TlB1A/gDyKehIYY0ILk+OxinLyYt5m+rbJHXp5Hou0vdo1xL6FpknbPQpKic83pJGohg5ItbYwUU8mQmX7sSawUW9Crb+BGOkbJxjhOdXB9P+6qg6WFAkOnv5xCvSzw0QeL4ggAcdThLVGBY+8JB78sh7adeJ6/TUQ0uvGhm4p1roIHqp2O1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB6062.namprd11.prod.outlook.com (2603:10b6:8:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 11:22:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 11:22:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Brandeburg, Jesse"
	<jbrandeburg@cloudflare.com>, Jakub Kicinski <kuba@kernel.org>, "Hariprasad
 Kelam" <hkelam@marvell.com>, Simon Horman <horms@kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "Keller, Jacob E" <jacob.e.keller@intel.com>
CC: "Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: add tracking of
 good transmit timestamps
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: add tracking of
 good transmit timestamps
Thread-Index: AQHcJz6KxCcb+qheFkWeywRg0fJwlbSXPCqw
Date: Wed, 17 Sep 2025 11:22:40 +0000
Message-ID: <IA3PR11MB8986B6F34BA729C5E86FE675E517A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250916-resend-jbrandeb-ice-standard-stats-v4-0-ec198614c738@intel.com>
 <20250916-resend-jbrandeb-ice-standard-stats-v4-3-ec198614c738@intel.com>
In-Reply-To: <20250916-resend-jbrandeb-ice-standard-stats-v4-3-ec198614c738@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB6062:EE_
x-ms-office365-filtering-correlation-id: a13186f3-e29c-4776-ff5b-08ddf5dc83c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZFlRWEU5RFgrcmJPVU9Fb0pwTkFMQlpZRW5GZE9KQ1NkSXppTVAvbzFVVEtt?=
 =?utf-8?B?Q1BGbW9UUndNRlRENE1xc0lNYkdkdkFCY3VTMHRlSFNqN2JDRnU0TTVTNm4r?=
 =?utf-8?B?QjljR28xYSt1NjRVU1NvbHdhVmVUVFFPR3E2c242ZVJuc1VjTVEvbkI5Wmtz?=
 =?utf-8?B?NUpYWkswWjZ1M1RBWDZoNWg1RkRJMzVZVVVhYkR6RUlkdlBQam5oKzVpb2dt?=
 =?utf-8?B?SjJQM1NWdGRlWWt5UWJLdEVOcXdqZjNLT2h4ZzVlSnpNd3gvK1FzQVpwTTRZ?=
 =?utf-8?B?M1lIUGI1WlhpY1puTEc4SGFoRHFsV2RkRDQ1UFZCM1FTVkNFOGxrL0RuZGxy?=
 =?utf-8?B?OVFXVWNreXFtNmxEQmwwT0htNmpZclZZYjhmUU5TZzU4bVJIUzZGZTh5K1ND?=
 =?utf-8?B?YndQVThqS051cmRSUlJVcTI2UjdGSERGOUhJK1k3VGtTTGRGWnBmQmFSK0No?=
 =?utf-8?B?U29Nb0VEZnVaanQ0Vkc5THIxYklyNjhUZkFWSHhwRmN5U3ZIS0FBbmV4SWJ1?=
 =?utf-8?B?em1JTnBRa3hqSG8xSTJOVzJPUEN4QjBiQjU4QVFiYml3aS85UVdiSnZ4ejRv?=
 =?utf-8?B?Rm16cXpkU3llS3lzNXdUZDBkd2lzWkFTeEFsKzNBY21qR0lPbFdXQzdNNzFI?=
 =?utf-8?B?UDV6aW5xM0hrZXB5Vk1LNTBWalJxL0Y3bzFwcUJyNXI3ZFZVT1V1aDhxYlZk?=
 =?utf-8?B?QWZuNUV0cnpIaEF2YU5vckNGQzI2bXAzNUpYeFFWQnJDUTFFQkJtQ2dDVWpC?=
 =?utf-8?B?THZWU0JiV0V1Z2xxRThYY3ZiVklvb1c4bTk5M3ViSlBwbGM0SXhpRDhvZU9L?=
 =?utf-8?B?RW5hNVl0UnhjRWJBb2ZaM0twOHIzM2M3d2pJN0JFZUZLQ0pBZlFGSEh5RkNy?=
 =?utf-8?B?blY3cTdKaGJwTVdYUjdma0lUdHpHbFhsS0ROU3VKV0MyMlQ1dzFqSTRzMUtw?=
 =?utf-8?B?TE95L0tLNWRQNjFiSFBsak1Za0t1cW5adWNsK0FvTU1xQ2UzaUlFQlNJQnp1?=
 =?utf-8?B?UUJTNTk0S1NaTTVKa3FDMGhqNU5DaHRDQ1YwaHNIb0dEUjk1bEc3Wkw5QThx?=
 =?utf-8?B?djE4SHVkNU9EUlpFbFlaZ3lFUHF3VVRqMVhZUW9mWk1zT0RNbndhc2gzZThJ?=
 =?utf-8?B?bDc3d2dMQ0QzTWo0V0plVTBFV04vcUJ0Y3JqVlpkM0FkZ2wzVFNSelpYdkQv?=
 =?utf-8?B?Yi9md241VGdCNDdvYWgwbnRtR3UzTUJzRS9LNS9CMlRKTkdsOU1kamlxYTQy?=
 =?utf-8?B?TDBQM0c3a2dON29OWloySGFEOFlTVFZOeFR6ell4WWdxeGswTkxvaFZnaHd0?=
 =?utf-8?B?U0xPN25MYytUcVBTOEovUW1PbXVacm9DdWVDOEpyVHRKWUJhWnlVNTU5Ullq?=
 =?utf-8?B?bnlhbXQwUUNsdmw4ZHl3OVp5WVpaSDdZT1I2eU9NeU80QzhYbHNKYm45T3c3?=
 =?utf-8?B?R2xpUm4wN0xHZmtDVklGbHRqZkpBbFppRm13QkhDRTBXNDQxemJaN3UwaVRo?=
 =?utf-8?B?c1Yzb1NYbWZGTXVUQzV1aG1tamJHSXNJSms4bUVacytKRFM1b0t4Q1hHTkN4?=
 =?utf-8?B?N3pOOGRTZldyVU5jZlN6M0s3ZWx4eUVMdGI3aSszVDNzLzVGUnVzZEc5UUp3?=
 =?utf-8?B?cXBmTWorY29UM2ZKaklvNlk3M2RkUlljL04zQmhsTW5xYUMwOEpyVTc1RFF2?=
 =?utf-8?B?NnlEVVJMSkl6bU10dTBYbStKd2hjS0dzaWxYeFR6UWptdFBDaDFsLzk3SDhE?=
 =?utf-8?B?SXNnT2QzNHhUMTNFWTdKVXhlODFPYWJncXdheXcxYkhwZGh1aThxSlBCTUhE?=
 =?utf-8?B?R0xGU3M3QW5remZrNFRkY29KTEMzT3BkVzU3WmY4bENwTnhBQXNYUVhRMmQ5?=
 =?utf-8?B?cUc5aG8zYmk4eVVIQ1o3SDNRNkZoUTFKZkhoM25MY1ppYUpCdHd4VEhoMUxI?=
 =?utf-8?B?UndqaDVZMjBySlpiWURxTWZqb1lMWVF4dkNNMlRnaTIrVFNzck9Fc1N3eUV4?=
 =?utf-8?Q?ki2KL+RoGh+QgD6XUWyjcLxyf9Jvi0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emNHTGRzWkZBL3pKSkZiMDdZT0g0WEc3QndiaHU2TU9qU1ZGdTdnWEpIeTVD?=
 =?utf-8?B?TkgxN1JId3BCa2RkY0Q4UFNzVHJoNHJCRHZuZ0RSc1BpTWJxQmhHZTU5Vng0?=
 =?utf-8?B?eVNUbDVIdEJUTVhDMzRSQ3pwK2NZaXFySHhCbm0zMzgrWGQyZmpBcFp0YnBz?=
 =?utf-8?B?ZjVZRjUxVUFycEhFNGtXb1hxMFBrQ1Z3emg2enpqQ09ndFVBdnBmMFAyaHEx?=
 =?utf-8?B?eHVieDM1WTQxREVSMUsrZTlBODF4TWJ6SGVhbC8rMFl5Q0JSNngvcXlORmV4?=
 =?utf-8?B?aHQralMwaUVjWnlSby9IdkFlQVAxK1JpVmFXRVlLTytvR2haZ3VucWlhWFpp?=
 =?utf-8?B?Z0RwVEhoZkM3OTY3NEVITENOeU5xZUNmdWdpZ3YwdkF1T256azN1bDFpYzJ5?=
 =?utf-8?B?NEpNL0I0cEFQM0VjVjVTMDFRUnFVaFRsallaOFlJVUIxS0FLc2dDKzE5OTNm?=
 =?utf-8?B?UU1LcTk2Y0dWd0wyUWpCekwxdnhWaHFFQWoxa0hHdUlzSUFsSk5HUkFJOXNw?=
 =?utf-8?B?eXp0eTlLZkxXSGhjYTVNcDZmajZCTHdBcGplLzFEZy8xT3JKT0Uxa05GZksy?=
 =?utf-8?B?M29KeWpicWVnKy9jQ0RFL3RzMit1NFJSUlFHV1NPWDF3UzdYOGtlVjBOSU5h?=
 =?utf-8?B?OUh0SitKbm9ZbmpHeWdNemx2bXZabTJyeWRkeWZieS8zVXhwOWZJelE2Y01J?=
 =?utf-8?B?YnZKay91TDdSR1lwWUpFK0N0N0tES1ZZSklueDBvVG1LdkdCQ1NaNDR2Zkk5?=
 =?utf-8?B?dU5ZZ2xNNU1YU1lrY2tVMlJSSTNoMzh2M2cySlBOSFE5UFJyZG94ejZEOE5W?=
 =?utf-8?B?dHQ5ZnZONHozdnowcEc1TnhuYVhsMy90KzNCY2N6aTlQZnMxc0RQYlIxeHFl?=
 =?utf-8?B?ZUNvdzNjTWtNVkpEeUwxSUU4dkQyaTV4U2lQK1VEcDRGbWRnMkljdmhyaEh0?=
 =?utf-8?B?SFJGOEU2TWJxN05xNm0wSFRxeVJlUitPL0ZYdjZLMGh5R0U0eTZzR2ZGRVhN?=
 =?utf-8?B?WlRKY1lYOVE0c0cvVXpucWVxNHZNTk13elR3c0ZhclZ5eEowMDBZSUZ5VzEz?=
 =?utf-8?B?TmQxZXk4b3F4UjNjMnRwem5rcURSNDdGMTVxVForV1BXYXRrOHVVcFpwRSts?=
 =?utf-8?B?ZC84VnFaRHlvczBJcUZ1YmVLU29DMGtaME4vN09xVWRYbmFNRWJGVTRVcGxw?=
 =?utf-8?B?WGdlVFJIMmtBT2tYUzI1bGJnbFlmdXhZSUZmNXU2L2t3dWFjUXp1a1Rpa1NW?=
 =?utf-8?B?UlY5aERDanNyMXJKem9CcCtqMWdNYjluaXBFUHVYK1hyMTc0aE5CZzZQWU5s?=
 =?utf-8?B?b0RUYkZrb2ZvZW5LSkdrQXluZnZrMHlOV1JZWWtOMzVORlVJeVdMSThYalFP?=
 =?utf-8?B?L2Z4YlpJdjdsK1RGZ2VyYnNVVkRIek5GaWVWUkF0TEhmcFJHZXZIc3ZuK0hz?=
 =?utf-8?B?NWFjSEpBOExmV0g5MS9peHllcEdxekNtOE5leU1MMjlQL1dxNEZ2M0J5bnJS?=
 =?utf-8?B?N3FZYXd6c2VHVE5rOVY5RmtuZzdETTBWVEFTM3lOT1NuSUlsU05xNmU3eFlH?=
 =?utf-8?B?Q2VPQ3VSakQrYVJ5blVLMGQvc3M5ZjY1R2MybzZvWTBDRVNVZyttUE5haEFz?=
 =?utf-8?B?cndGVTlMTXBoZm50S29Wc0pBeERxMWo0ZUZnVHUzZDJWT1lCbVN6VU1PL2dv?=
 =?utf-8?B?QkpGeEJSOERxQzZ6Wnh4dHk3U3QrY0pQTmYvenNWNWhKNUlEMTJ5QzhrYUhC?=
 =?utf-8?B?Y2lhVGRabHFzNXFEcGFsN1I3STQyZDcrc2lMcG1DUTNWa2JVNjRyamlaRmVh?=
 =?utf-8?B?RDVNZ1Z1OWtCdWZHYTlISktTRTdHVDAvbm9pTnpWWWNMWElMaUx5bXRNc3FB?=
 =?utf-8?B?RGJmYU83MGtkbXI5bHhPMHhTY1ZJQ3J1M052elNrL2wyWUp4aDUvZytqaWh4?=
 =?utf-8?B?VndnZmc2aTF4RU9hTlJOVHh2d1RvVHhsYU1HaHlvZ0E4VjBOUWhQTHI0T0RE?=
 =?utf-8?B?YTA0NXdnWmF1bUJ0cUhBS2oyTUorOFNjMDBJYmZ5Rld1Y1dteko3dG5PMHN1?=
 =?utf-8?B?RlU3WmExQkRPMjcyNHYxYW1WNnd1NG5wWHpXWGk1eHdsbzVoNWdUS2ZzZDVW?=
 =?utf-8?B?NlQyYnZsTlM4aFZuWmZ3MzREa2ZNbG5WUXFaanlrRFFFWDRMWGZZcXFBRm43?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13186f3-e29c-4776-ff5b-08ddf5dc83c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 11:22:40.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyCpUxsfxXZczDpnOF48ZcNZ8kCFHGQyoKjFg49O+bPDHVua/zc6aV1qRvdd5/BwpBs79JTBC70Qzze0B2PqS/u7i9WEKoLnAZuIQ1HGEAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6062
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgSmFj
b2IgS2VsbGVyDQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSA5OjE1IFBNDQo+
IFRvOiBCcmFuZGVidXJnLCBKZXNzZSA8amJyYW5kZWJ1cmdAY2xvdWRmbGFyZS5jb20+OyBKYWt1
YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgSGFyaXByYXNhZCBLZWxhbSA8aGtlbGFt
QG1hcnZlbGwuY29tPjsgU2ltb24gSG9ybWFuDQo+IDxob3Jtc0BrZXJuZWwub3JnPjsgTWFyY2lu
IFN6eWNpayA8bWFyY2luLnN6eWNpa0BsaW51eC5pbnRlbC5jb20+Ow0KPiBSYWh1bCBSYW1lc2hi
YWJ1IDxycmFtZXNoYmFidUBudmlkaWEuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
aW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmc7DQo+IGNvcmJldEBsd24ubmV0OyBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGlu
dGVsLmNvbT4NCj4gQ2M6IEJyYW5kZWJ1cmcsIEplc3NlIDxqYnJhbmRlYnVyZ0BjbG91ZGZsYXJl
LmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0IHY0IDMv
NV0gaWNlOiBhZGQgdHJhY2tpbmcNCj4gb2YgZ29vZCB0cmFuc21pdCB0aW1lc3RhbXBzDQo+IA0K
PiBGcm9tOiBKZXNzZSBCcmFuZGVidXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4g
DQo+IEFzIGEgcHJlLXJlcXVpc2l0ZSB0byBpbXBsZW1lbnRpbmcgdGltZXN0YW1wIHN0YXRpc3Rp
Y3MsIHN0YXJ0DQo+IHRyYWNraW5nIHN1Y2Nlc3NmdWwgUFRQIHRpbWVzdGFtcHMuIFRoZXJlIGFs
cmVhZHkgZXhpc3RlZCBhIHRyYWNlDQo+IGV2ZW50LCBidXQgYWRkIGEgY291bnRlciBhcyB3ZWxs
IHNvIGl0IGNhbiBiZSBkaXNwbGF5ZWQgYnkgdGhlIG5leHQNCj4gcGF0Y2guDQo+IA0KPiBHb29k
IGNvdW50IGlzIGEgdTY0IGFzIGl0IGlzIG11Y2ggbW9yZSBsaWtlbHkgdG8gYmUgaW5jcmVtZW50
ZWQuIFRoZQ0KPiBleGlzdGluZyBlcnJvciBzdGF0cyBhcmUgYWxsIHUzMiBhcyBiZWZvcmUsIGFu
ZCBhcmUgbGVzcyBsaWtlbHkgc28NCj4gd2lsbCB3cmFwIGxlc3MuDQo+IA0KPiBSZXZpZXdlZC1i
eTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5
OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogU2ltb24g
SG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBCcmFuZGVi
dXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmFjb2Ig
S2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGVrc2Fu
ZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gLS0tDQouLi4g
DQo+IC0tDQo+IDIuNTEuMC5yYzEuMTk3Lmc2ZDk3NWU5NWM5ZDcNCg0K

