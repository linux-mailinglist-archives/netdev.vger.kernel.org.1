Return-Path: <netdev+bounces-147583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD09DA5AF
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEFC286D92
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADA195FD1;
	Wed, 27 Nov 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLYu5lqv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A921191F99;
	Wed, 27 Nov 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703078; cv=fail; b=jmnoHGn/Y24e59GKdpc63iL1DuQwgTcdKLzQJMvxuCBVndkAfVALGffWHuRipeBGRkdF+z3N0BHoc8ND3cNZXNTKfmxOYPlwERJi+BGBXl0/FMpskjSvSBr+EJLUnd88VQet7i0kXhdd8GIkIhek1Ta1aKR3oXV2jN/OY42dFcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703078; c=relaxed/simple;
	bh=lcbIPh072MSe9LHJV8Kz7iRb4T9eilWIfPstTBCXavI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=juazOAHVCRWP2l+GcX6IKj5CpWjdCb3F9ttIn/wH8NfZcFadu1kVROFDqWWUROvScDNLODaHNhaIDUuAIEpJCuyrQeeYycMYMilJ3t5U7q9l3031BysMPFfcBPLTzfP9t2Nk/oNqEO9DwvHmKoLmhJvLpH8o0HAdfiZWAxjNBAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLYu5lqv; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732703077; x=1764239077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lcbIPh072MSe9LHJV8Kz7iRb4T9eilWIfPstTBCXavI=;
  b=PLYu5lqvgAvchTBgQA/qPb3WadVi4b94wy/7+mJ9/vjPHY2a1544z+YE
   Mg09ktaz/EGWgtFdv6+A/Eb7InxfR/e+c0gxgCBZBj+9U46LmKYaOAGHB
   H8j2HL0AT4G0CFMuhp3/eTPVN9Zv5tuEBvz7qgA7ZL2r1pTrSs+I9ZSmN
   Rg6hKMPjJvwc+OR+VlzMAFVl2RoT65z9oEjUicNPldD/PVfchCgh3VMOV
   /5+C2hHAbt4Ebn2jO7fB5RQ4WSgaGq5GBZzzyOJ0IIHn6kkK8LfBNPYbZ
   0onDaoVu46/Hf63juIPUaK/RxaDNpwpiCFYBA4FHes0Xjbs2dqz/JHLZE
   g==;
X-CSE-ConnectionGUID: oMmLkcuDQh27Fjju3CqpEQ==
X-CSE-MsgGUID: mvRc3UWiSzayRt9ItaB0PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36565559"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="36565559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 02:24:35 -0800
X-CSE-ConnectionGUID: hHAwU6GnS7yQwj00tJktyQ==
X-CSE-MsgGUID: ZbZ6N9uuQwaGdo8egcYwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="129414686"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2024 02:24:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 27 Nov 2024 02:24:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 27 Nov 2024 02:24:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 02:24:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T11Dyh4weFeUI6MHoVKVsCU8T1Mg9tplkrCoQywZoSbXzcr0DZSnz4zqa9/0mEEtf34AhfrRtGASrcpWkj2SMj2ZA/HMyH0h6Ft1GKpiIDj21DzU8Y2J/SeIc8WHty77crtAGn5mx/8UT1Opt/UWqOTGEq0U8zNNYMtJq5RuSaz7vbiot4t9kiU1QFPEJKyeD/CXECpGrgKVGX0kg6aj9pY+3qxkHRAk7SI4rbUr/iSDZVO4TEL+arCTQbRlK0HESPnqEa9dkFKFA/uh7pUevNKR2g19JFMkMd/KGvqwFpXh7Wwk3oqdyQM52ZSsbf7MxQ4cEjFp10c3/Dqu+jZdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n25DBGwIGNWy4vdGcIMmap6Aa4Kf5Cwbpzz3zVk/kW4=;
 b=NWeCNKogKsHFgT6zz1n0RS4FozONngYzJWntEvc7TzHv8NpqpPu4Fo8tAnSRHbGRVkdcOtbR552iCwxYryACf0NVPjjriBtEq5kepEAv91CW61m0No+AjHIOZW+C9kVMWg0KHEjtOH0ND8FrEFWapnbE+9C9yaR7wuf1OlAX6U1LZAyC6nmMMIpm5BKHAgKxMeweA+TaAYt69YIW3RM1F54aBYyYlibViuSYrjMimBI4XMNGXCaGFpxchSoOmdld8tXdY0CnLlr3NNYZBjOxggrV1CZJp4rvAGRl1uU5d3OJP1j3iLYB6PuGZjrDsa+5hFCTvrn9a1tsy1ww/9PVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by MN6PR11MB8242.namprd11.prod.outlook.com (2603:10b6:208:474::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 10:24:31 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 10:24:31 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Tore Amundsen <tore@amundsen.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "ernesto@castellotti.net" <ernesto@castellotti.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: Correct BASE-BX10
 compliance code
Thread-Topic: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: Correct BASE-BX10
 compliance code
Thread-Index: AQHbN2kziGFvLqbKKkS3g+bdK91aJLLK/efQ
Date: Wed, 27 Nov 2024 10:24:31 +0000
Message-ID: <CYYPR11MB84293DF5A2E2CA581D7B0C32BD282@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20241115141736.627079-1-tore@amundsen.org>
In-Reply-To: <20241115141736.627079-1-tore@amundsen.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|MN6PR11MB8242:EE_
x-ms-office365-filtering-correlation-id: b30df1a9-f794-4eff-211d-08dd0ecdae66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CnrfJPaDpG/22vOnTFP4tqJtWugBSnSBKbvoDZSKvftPTHg+ZpAHsfA571Ai?=
 =?us-ascii?Q?Wxz9dPRtM9wMUxr1cRDT7tD8sJmVR8Yl3FFAxgl3ONn8SQvfew3HNkp57uvx?=
 =?us-ascii?Q?O0UJ4syQfJ2eL8ApjanOMOx5tO7srGr6t9b4tK4iClg8irneiR4ZL8KJdGag?=
 =?us-ascii?Q?uJSdr3qAvqsCKqUt0vFHYM7XCvZaVQCIrKlOxCQyd3CmI7gqzQWGcclY5exc?=
 =?us-ascii?Q?PW3RiTeFVE3z6tN/vt/C/j8COh8ttTYa0YhCl5bEbwHweqmo3lj2e/2SDBfa?=
 =?us-ascii?Q?wf8aiAFpzMgLJwMsOCKGrdR2QR7HccZgRFgUpfBouQAlitUHV/rVbywm7gRq?=
 =?us-ascii?Q?2f5SML7duhzcDhED0YRSWrI6KnKPzNS2jqXJa4w5C3krm9kGlGuTUwn+5Lb1?=
 =?us-ascii?Q?KU1XgfGKNcTevEvxzLzXdEArGXb/gNw3ZdaZR98Vjo9DHpnQHQUc5ELmQGpn?=
 =?us-ascii?Q?EBUc89MF8Wi8/D62cW6Klw63lKZkfet4NAXmUS5eAnukbPQD88OSCb4dGvzL?=
 =?us-ascii?Q?bVH1UDDQPTKCntELfKY5acpeLeH0/alZRUdSIu+UvW3qXr48x7AMNdscEWvf?=
 =?us-ascii?Q?lRMJ2iFNC6IrBJLLFKovJ8Oofs4xdymZXffcIKsosfkTGqRpB8O8ER680UiP?=
 =?us-ascii?Q?t+eCsGDRG6cxlrZFSRmgml7FFqgE5OOsqanxgUrS/arpIREzXp5Wo+gkGAY8?=
 =?us-ascii?Q?yPMIAzKShHhTDZRJsDsQ8Mk/CisbzuDkAl2rz0vtrsCHdtRd53UQbziN6atV?=
 =?us-ascii?Q?1z9t3Hlg9ZSi74sLh2W1O8FPe+DM82Shxz2hWrYqFoFnpBx+huav6td4+tdk?=
 =?us-ascii?Q?Wokd1HY7jQ4zFvOixwV216hBCZbSv9YplBwLqxI7n0FwXQmFYc6JgpY5FzFX?=
 =?us-ascii?Q?rDh//iiR9Isn6ykYkcqCJwVIZwXzbxTImRWRdR9xIVjSGLtZJiqXTwWqZdEq?=
 =?us-ascii?Q?sxyxpTmEzQrCZ1QY9OLn0AOA3GgH6EGTJLgNVrXP33chL2R6WGVMUuLU/jRi?=
 =?us-ascii?Q?agexOjN/Iwjmo2Wdn/e05AwACXHtxxg29SwL5f2jKZ42xwZU/PsR54zSHP0e?=
 =?us-ascii?Q?gTt1pm6iJe+X+lPlFnPVCyzulMwdKoUBsZlNrjY9L/o+HWilkJGS70Y22JEi?=
 =?us-ascii?Q?ummfURpnPpqOdBHYCZlQZaj/Wtg7Kz0e/m2GGZNBRIe0RHKftFnyLc7FMha7?=
 =?us-ascii?Q?62hCR86kTS5BVmnrI+lLYCqf4pMKMP6aFM9Auy4avIrxzGFXPMxAhp8jy5ym?=
 =?us-ascii?Q?X7+/vkpbuPP/efEDk7x49NRAZGbQAYrYDpeILgw3vSEZaB63vd/8gqbJ7fEM?=
 =?us-ascii?Q?V0IKdAeZ+iYxZ7SJgAeUZrApKR9u/VmFMmw3b8fCJdg5z+b0EKywaT7Vfdjq?=
 =?us-ascii?Q?cYcfy0ByXVzfQ8m9aa6mGyy3t4otTVIo6ulARojs6uViqRpjGQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jmjlh2DsWNYbUQVsM5/sBnjDzs3f/GMI0/LmHmS5s43530vcJx9MJc5ADEsE?=
 =?us-ascii?Q?O+5tMDAKr1Jn5eD07xS6x1dto5bwRFoqUNnkg4A3dNVGA9dr9kpSC9XFOByZ?=
 =?us-ascii?Q?qBsI4Qe+weJhamGdJftooMxQ755/xxG2denTYGUB6+BILD9Lh9bDuR46D3Pn?=
 =?us-ascii?Q?9fvvllpdOXfwLNGsL7hjGl01ynh4Lft7AV1p0uYzaBNEETJis7Uy3QgCTjaH?=
 =?us-ascii?Q?BFtZz2FuGpHeKnaxUQfBUz5oJL2tcwZRlfW9OD7egjl8LrhqhXe3cwa4eUq7?=
 =?us-ascii?Q?bi2I92GKxEM+pCDccgnQ58AKPItbIaTyNqrwT0+l1UfF9mhZg2bwtpkuN1z+?=
 =?us-ascii?Q?m6SHGKOZhF6jvS8w/XX8apVIbzb2MHl4T3Fv6v/PI6ikbd+IJDr25Q4R0HEY?=
 =?us-ascii?Q?LQxPZvlCGoWZxJ7vAF5QMfk9Ep6JQioQ18SHgh1bH3LhbgJhe/zao81aXMK6?=
 =?us-ascii?Q?Pxjr/LgQII9v9vO0MhWZsNUbY42N5maJzkLDWNzwALsBZj+6ltgq++u+Dqa5?=
 =?us-ascii?Q?Yqc8ZbV1nrvawRxV/SSh932ZwVYEvzo79EaUF2gFUVOrXrf86FPmT+5L/fdE?=
 =?us-ascii?Q?nyVoaUMlxqhmw4zcxjUQZOVXsGWXpXul4ZZ+5xjWZCi3hlgZHALB32EHHq7j?=
 =?us-ascii?Q?ocE0a58DaryvFSQ1QhUvK9BZZNw99wdqtyPRCSL4Z33pYvk7CjJ9GviHuC8j?=
 =?us-ascii?Q?PTm2GSCCtcsuPXnXT8TxxzCTx2gd+jAXKcleL8kUS5myGgkDdGHvz6GTRrb0?=
 =?us-ascii?Q?96AI1i7P/anBmwh4M/9OWMa8yaUqEBLr4gZHUFVmSOeL5X1Qq9ZXELrGwCPM?=
 =?us-ascii?Q?CDBz+2MFXY1WvbkBOgfCyDGOLIZwaNSR5/0FuFBMPPT/rQ2VqrOmU0ojO85I?=
 =?us-ascii?Q?sYZ9dwEBp9SmXHyf8EvmkzMp6sFLQ60BmruFaochbk75dI/me1QKdFmSvPRQ?=
 =?us-ascii?Q?18yYjnRyntCdX2E+qyWZw5/4yvYXN5+dBgqLUyX4IYC6bHEdYI9dvlmV5UHn?=
 =?us-ascii?Q?CbxeeuXOiTNX4JYUPWDd/xy+itYonAb2GMsQ+x6rEhmNn1nmf7cOLP7KTgl6?=
 =?us-ascii?Q?351XeAu2yaYR29XNb8WDE5D+aqPBWgYX+zMGdntcInj3E9dpsPUtT/6Fzc3i?=
 =?us-ascii?Q?1LXl8FvvsPD1eVlMzfJ76cNtEDJ4s3I/jcYZ37rH9s5m7Y23JKfGw65hftIP?=
 =?us-ascii?Q?rzmWSqXRXHoDmJ1du6E83muMQXgG0VcNW/DLavuM3jm4/zov/ebzlI0SS63D?=
 =?us-ascii?Q?n3IKv+bj+K8QkwbyyJ9Qv9c/VEPEDeEsnzOJMhiZeeXJH3/nwtq/8FUYRJkC?=
 =?us-ascii?Q?37I2UXhGUXRULj6qvlT/21O4lDJKTBjxXKvl1DyqmaPYbnTVF3PP9u8BZIqZ?=
 =?us-ascii?Q?dAbAbCWqn1ilwu9dmgV0ZEPVkmXV7llrWJRHEON7+3GB9bEJc6X/Eq9hGzX6?=
 =?us-ascii?Q?2R8719J5vJG0+KHgUoPwjfcFKalgdVP8Rwkgy/AwjwrL0t/NH/K4HDignfob?=
 =?us-ascii?Q?S/+uDM87NgGqWrRj90W+hxPinfuwJjPVBiYQjhpbPLfNJ9gH12Xm81FSumoT?=
 =?us-ascii?Q?cpkgoWTpaOIeFVygHCFiWAe6+Oat4FS+WPmAgN9FSVhXPjLIbaubY/fKO1mP?=
 =?us-ascii?Q?UUEIOaTQ+5wvSV6LHYbz98Fra1nCqYWonRWS+fD5ZLDFXk09CwsT3XhqnX3F?=
 =?us-ascii?Q?geTf/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30df1a9-f794-4eff-211d-08dd0ecdae66
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 10:24:31.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMVQ2sXiOrSpNfBJa3s3xH7yMHQuzZOYr4vlmvl0rem2Gds3I3xs1gb0SFuDxMlOjbh8dV1zROYf6ik8LuhZwBIlBKKtLob36K133jTNhPeI0j44FyNHmHbc8HeQncis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8242
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
ore Amundsen
> Sent: 15 November 2024 19:48
> To: netdev@vger.kernel.org
> Cc: pmenzel@molgen.mpg.de; andrew+netdev@lunn.ch; Nguyen, Anthony L <anth=
ony.l.nguyen@intel.com>; davem@davemloft.net; edumazet@google.com; ernesto@=
castellotti.net; intel-wired-lan@lists.osuosl.org; kuba@kernel.org; linux-k=
ernel@vger.kernel.org; pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.k=
itszel@intel.com>; tore@amundsen.org
> Subject: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: Correct BASE-BX10 compli=
ance code
>
> SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as BASE=
-BX10. Bit 6 means a value of 0x40 (decimal 64).
>
> The current value in the source code is 0x64, which appears to be a mix-u=
p of hex and decimal values. A value of 0x64 (binary 01100100) incorrectly =
sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.
>
> Fixes: 1b43e0d20f2d ("ixgbe: Add 1000BASE-BX support")
> Signed-off-by: Tore Amundsen <tore@amundsen.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Ernesto Castellotti <ernesto@castellotti.net>
> ---
> v2: Added Fixes tag as requested by Paul Menzel.
> v3: Correct Fixes tag format and add Acked-By.
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


