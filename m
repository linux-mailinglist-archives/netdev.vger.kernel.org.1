Return-Path: <netdev+bounces-223417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF67B5910E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C501BC2E7F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF82877C2;
	Tue, 16 Sep 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYq1lqEC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1F27E070
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012226; cv=fail; b=VjRmT9Ixh1DafIoog07MKXJiYmwLOps07L+leJ9REBza7lKtmuk4pY7ABT/v7OU8hvxaWqUdegWTlUoGkrFI16VBsYEfaDaSQfFKROTybKAnBWUPMV0yXHXSbTm/ki5hjlET9neq6GmdbKwvYK1CdVsVtmohtz4bntKoqqvf6bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012226; c=relaxed/simple;
	bh=QW3EYS8AAnv+Lvox4aa7x4rN75oESQB3wNEbLNsLjKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1dPjLA84uYA8atz3DAB17u5rv+Rawa2prHdtvoG+GpLLk+umedKv9aosLZaaz4hMb1iP3G++sc2y/IuyLyCMbGG51s4+Kyqi4b9zn9Xar7DvqzyoH1iCMVKtV2vBkt6jCKJPW4ro7a1NwU/i+TpoEc9uDJ8QdhrJr8qWgOPtBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYq1lqEC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758012225; x=1789548225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QW3EYS8AAnv+Lvox4aa7x4rN75oESQB3wNEbLNsLjKw=;
  b=lYq1lqECx94DJRrv9lUWHk+4MfXH00eClERDZRVQ1eF/kR1EQDG3h6y7
   AkFhocTTxX/2WeTsan8H8Eyvh88KSKkDdjpw5sOKXV34q0TBSFVPZJ0Tl
   K7jjXLng24z4itm/PqVa1FjT0rwtF5ThVtaZKKIxYoj13DVFg1Ej+9HNz
   K3CwCKNLOrfIQfDW1HgMCoUPZPf8id38uk8XwZaiaWBLymVLi9LNtdc0Q
   BSnVruW9WlbrdTE+4P2VeEAxad+kZCk/bYinRAa5qIStJiJQtQxEQBkst
   EY9Mk6svN5KbTUoVWdBgEiNziU61ClqqoK4L0h+sFaNADnmHHtnd7L8vW
   A==;
X-CSE-ConnectionGUID: 3RWsrQvyT26xiPUm/p8mew==
X-CSE-MsgGUID: gzoCxEdfSVG5rHrOdkwh4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="71383141"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="71383141"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:43:44 -0700
X-CSE-ConnectionGUID: 668CZNOeR/Sx77cW98jwKA==
X-CSE-MsgGUID: YgtzgoeURrejcrNXmLKx2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="205846453"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 01:43:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 01:43:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 01:43:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 01:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKigtqcA3sxnG0pUp6auwbizhbDoHT3bDvoiVR1C5356bEyavk+hLN9LI7gDVDi+Sv857cuCzXJHnmJrqYAOSciHASNLKgTuSuIVAHQrgTybEmJ33KjcjkzGqPfjFdIMDYObwUvnu3yWI0wJEo6rK+fqtCaPWuE6e0PS3/iHw3LC+tzJQz4PtJdD0zQl+EHydFvprOvbzYWTgKYo6G3o5adnirWUQwWnuYie3rHjGbCkt7/yQH1dLwjqzoSh4p7puJp9HOLRnsF/KEU09WRTAlCTmpVDNnL1cJBoVEV2Sizr6ZiwzhvdXsW/7EfMoZUUVQCojSg81pKTSZ1F8Pz2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNdvOJEmh+8NQJ08sw4KJ0wpTNkPjI20WhSk7uLZNp0=;
 b=em0Tr9uOo+ITK4+YwXNiTqkSubFEjvzUs/8bFLRJ4U6Aucif0X2kojJJeKzr/XBRBQsGQft89rL+F7KtosuC1RS/cKCURasZXYzTXkyGjJyZ+wwqQVrN4ge0TIKk7z0e8A4/k/G3I4x97EFKZFz0q40jqBdNIXz2Hs5hgJm+SzYr7klya/9gh1d9cP/kqDBPkkV8nRSRmwSULQ4TOCJXSBVe9ILN5EPKC3VOQ0xqeq94w4FJNrG0pIcWOK/fwv5XwVDWX+UxU5HNhwoDt82FtZjuilhTaN/bU4pgy2xJBAr1kEWBT5P/TNRz3/p7D+ArECPDwp2TbrP5aLji1vRkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 08:43:36 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:43:36 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"jiri@resnulli.us" <jiri@resnulli.us>
Subject: RE: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
Thread-Topic: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
Thread-Index: AQHcJpqF1LkHyD6VSUi/iRIkz63xYLSVflKg
Date: Tue, 16 Sep 2025 08:43:35 +0000
Message-ID: <SJ2PR11MB8452ADD869DCD490B67B8BF29B14A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250915234255.1306612-1-kuba@kernel.org>
In-Reply-To: <20250915234255.1306612-1-kuba@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: 20685a7e-0ef5-46b9-83bb-08ddf4fd2027
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?T5vNk53Dosmo0nt3stvFAJuz65OnX2hJZP7A/1yulLQRgaq5mTudevniUQqE?=
 =?us-ascii?Q?mhfkNDgOGsF7YWIx0vBBaLP3/VzwHlWz/0SlKmrRWSFp4ynbVFLRmjAIcrWo?=
 =?us-ascii?Q?kR4+g5MNV27wWZMjWbwIHEN0Ag2v3w/vT4HLAYg1MICea4vuD4XGX+P52UKN?=
 =?us-ascii?Q?6gbIJAvXUWI6Wl3cQJeM6S6/b3vO4RG9eRNd60LPGG55RCQSFJhT274Q27fv?=
 =?us-ascii?Q?7bvJi6LQYWCNR161AJYxkCHSX1V9g9XNNDhRgxYvfsHoCb3eMqI19sqXKNwQ?=
 =?us-ascii?Q?UQ4DpICI5gef+pQ2B0jkCXXax1fNlylMWnPWlxwZQMUqU8+UO9Y2kqgBUEsK?=
 =?us-ascii?Q?heNcR+9IXpglCQGipvHHOV7Dxukwp3YCuJ5YQ0fPzBi9ZUCZvEVISjwxo0+Q?=
 =?us-ascii?Q?vc6akQPnQApAaNn9bnjGvnSo9IYNywOoM2N/zqc0kZE/4pRRAmsN/q2MrLh5?=
 =?us-ascii?Q?VDaZvKDbD66TZYOI5EFRWgUvqFWfPfcc8WUod9cLvZ83XAp82QcTxAXt7i7x?=
 =?us-ascii?Q?7JN6uc5GCc789XzQKfNcAPGsisMNh1YQzOANXOtxuS8OdZdsaZBxedejuWy8?=
 =?us-ascii?Q?jeqy4QFGi1nwYiMPda6A0HzzDpYEoNrKcAtpw7h8C7dd43vEnOf7z3+Nl6Aw?=
 =?us-ascii?Q?bYxskiMDGMiq8g2GyOUlOk+Ex+FxCd71c3B9mtjx34bXSzA6CX8sBYBnxLAT?=
 =?us-ascii?Q?nznY60xM3NI1AghggkZxgSdDNs6zerBUSHwCc6OZOupXO6HUmNRCEhRvgllE?=
 =?us-ascii?Q?MOkQARmqX6fneWuszK84nHmQVCkyfwpII7vgxp8yzY/bdAicgW9eUZ5mBubT?=
 =?us-ascii?Q?QrPO53X/kuYYcGDbr168K9aBs+rUGpZG256wFJfVEqA2YBLC0Fs4w1OqRrQc?=
 =?us-ascii?Q?e/bTBJHcP/GmndwKKTjTHj9g2ppcyCWSDQaUEOm8jLempv7+D5FShOdPthh2?=
 =?us-ascii?Q?Vang7Fz7Lmsd2YBrx+G+Fy+UpD43bMhoMESP7SVFDo+J3SYcxf0LQLS2k4C9?=
 =?us-ascii?Q?QEuM0lvbU/v62vyHG9YxadFHiY1cTf6XbPNgZywL4XdfaMOjB9xnZF37Sn9R?=
 =?us-ascii?Q?ioa2SmkQOHm8/UJFUjoEGxajDlCrpVR8JJN7A87fRzQuYL2UTNQ5nkze5grN?=
 =?us-ascii?Q?Rm4nnq+c3XP3WJAMFHLbBNHa284xAv8Iv9RrghSE1QlJfM3TONrPsM8GLkC+?=
 =?us-ascii?Q?1bAUdkvU7vUkdbYB8LQ3slus+k22HaNHeUTmWVTDaotWeMpkKDw2pokIY9qw?=
 =?us-ascii?Q?arDYkUcB2Q27ADvAbGbsmyuLMrgpPVtf2G6OUkTiHVWysqaoruzfHd+GuGN3?=
 =?us-ascii?Q?yePB2S00MqMydX62y/vnEdO1nIPe2KVx7fEWqwmbbf5DeRbMUGrnSvvm1MGa?=
 =?us-ascii?Q?8oJ/ZQxpXiTLLRHqyjvI4pZFOdrPSdkTqlRemCPO/otNmqTPuPKhqejgGYcX?=
 =?us-ascii?Q?AkjybRpYT1hN6C1U6GQEKTr/HGrl8z5zpGWmN90fh/t2n6/S+rQK0pPc7n1Y?=
 =?us-ascii?Q?I7z+rfQR3rwAPKs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z0LhXlXY6nVLV0036wgwIQ23F3WnPTQ4/0NNkLtLijxsG4GQ2uYWq+EDTCkP?=
 =?us-ascii?Q?a69XCaTGK2j6BXMTzUYJL1mUV+lRiRJnNzNFNP028i/b3TmzbBeM9yC9vuws?=
 =?us-ascii?Q?0eTpsUej5mFIYbLc4Wss+o4HFBqVjYnG5er6szqg/G8P1Op2jZRk/RYzlKp7?=
 =?us-ascii?Q?cMdbylZeUqbp303TJ68FgP8YaXKl8y3Vhqp7BThmIeFIOJYUbDbiHzqa7l4n?=
 =?us-ascii?Q?sttOoW6j1eeDS+m/iqRVMURCeeFnC0Z0QHYgHj/FTE7oLNrCw710Ro7i97LD?=
 =?us-ascii?Q?0YZE1KPuI+oPSj0Bt1ERMwRSioMF+lzm+kQwc7Aj5rjkv4xs76nTcDSEGnWN?=
 =?us-ascii?Q?sszMQddXyEHZLXvs9bizW79DknmMUBHM40udz1PzSmwAEx1D/SsBr8dGn+li?=
 =?us-ascii?Q?Ga89AM9wUaM/F8W++9mww3/MY1/1xoNLJ1BjRUgdLBUchBxRzlmIZgCiwUyc?=
 =?us-ascii?Q?+UaWQDF9GXpHORm2pnQwUq7M6tyWqRg9UPBNrPx+lhM7j4qVrzAgscYRE78Y?=
 =?us-ascii?Q?pKMmzeP2RNlXstWf96/M0XCfgiwDufk+UZfGyHrJb2hcEx5gXmylKcAJillR?=
 =?us-ascii?Q?rEgF0Y3eXvmaGiCpy2EJ+xP/C8/dd60sPb/ONjGi+cHXHFpbFAplaS4Zfb5C?=
 =?us-ascii?Q?1v7nGiRpzNx9ojLomywVDCa12yj/1YEsDb1U+26lV+y1Emx93Rw8UaDih7BR?=
 =?us-ascii?Q?T0hk2bEPAS/KxnU2kd+ZJE4GEeXAMB/VvgObND4ufyuk3l+IG6Te60iCIjy1?=
 =?us-ascii?Q?bzbF/0LDGBDbg3fYPrAiYQotn6g5s+DBaDleq30qogBn5z7uUC3CFbzDPlVH?=
 =?us-ascii?Q?d1uZ6cfkTYkcM33w3LqLcQK66TqgMyw/M4RG0+YCEouBQ8LQm7UiBi9RIBos?=
 =?us-ascii?Q?VmWAcXs4bI/ExidKolEz07mIzP3ujZ4aFk/Tb0yLQCT0v9InX3YABSCF++bx?=
 =?us-ascii?Q?PRcjq+C3b1h3Wwl0WUcVKUaUqB993mrRPapeAkr0+MQDOmwWET6BwELF+3Re?=
 =?us-ascii?Q?iAyJt4dL+WOpfxGdZsMVlLC6vvyJwRIvHWEORbmyxYGDThvM7Krx3AkpCk0w?=
 =?us-ascii?Q?nG0gIDEc//KwsmqmUKh97JT33tjquleuPbNqlR6jTfyb5ivNirjnpTnEcI+2?=
 =?us-ascii?Q?SwI49f6PAI+OnV8SG/0ld6lWuy9+7yHeu+VvSm+GSwYxDXe8iZQ5ELU0TVUR?=
 =?us-ascii?Q?RiIvQlbRhPcabo8GNrMf5ZcgfsDTOB/WidzP9znZD+0X2Y7Zn2/FxCOQw8Uy?=
 =?us-ascii?Q?tcCgA2El8cVMcEeZ8Kelc4kb5sPIOHiTtlKDI6V1NIodzjNbh2iG5URhuCpb?=
 =?us-ascii?Q?3C75Hdu4vW7QGCHr9QvLhK/Cd6w5T+yRKwVMpb0ZveGKtRuyKUBvvDe31iiu?=
 =?us-ascii?Q?NysQL2VupqbIaJeKQDmh/G6YjZhYGGW+YUYh+Yv38ZnzHYMloOYK9veW7KFt?=
 =?us-ascii?Q?VSCK7AWyUgHQ1IU313AMzREXcxlFbZWJTE7kYYzYtCI8EAzqbDNXdD/d0qJU?=
 =?us-ascii?Q?fs1QPQx0I2neU+/DO/B1qfOtRGxDHFkqrp/i4DIUFvWp5jrU0MkyCtbg8jTA?=
 =?us-ascii?Q?BLf8a3BVDGqNzPxT8o2N3nzLq6J4Cp3FgbS01GWgwKa2lQ2u+rRSj8P/kMkT?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20685a7e-0ef5-46b9-83bb-08ddf4fd2027
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:43:35.9734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuKSOhrj+VkJfUDBLTvRxazDu86PUIK4iB54O/JujimvLrM6oPNmCi/9c8ctDYiRqM1alrWrgxnHRlOSJBGgHyzVZM8eWBviQ2tDf5fJto8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, September 16, 2025 1:43 AM
>Subject: [PATCH net] MAINTAINERS: make the DPLL entry cover drivers
>
>DPLL maintainers should probably be CCed on driver patches, too.
>Remove the *, which makes the pattern only match files directly
>under drivers/dpll but not its sub-directories.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>CC: vadim.fedorenko@linux.dev
>CC: arkadiusz.kubalewski@intel.com
>CC: jiri@resnulli.us
>---
> MAINTAINERS | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 47bc35743f22..4b2ef595c764 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -7431,7 +7431,7 @@ S:	Supported
> F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
> F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> F:	Documentation/driver-api/dpll.rst
>-F:	drivers/dpll/*
>+F:	drivers/dpll/
> F:	include/linux/dpll.h
> F:	include/uapi/linux/dpll.h
>
>--
>2.51.0

Acked-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

