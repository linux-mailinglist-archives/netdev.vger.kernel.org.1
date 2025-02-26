Return-Path: <netdev+bounces-169710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A136A4554B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DC03A6478
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAF21C9F9;
	Wed, 26 Feb 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ry9ruN5K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1B33997
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550147; cv=fail; b=HjFjPE0WIWhkWHr/k/wCN0cn0JM0BKZNB1rQQOw9T1Lfig2qt6JMpLJ33mJhCDCYsAqNhxcnf+iVrGpg0VTs4jI20t0STYkG60IEIfmd2ULmcTH6+kxwGJh48f5shNqPK2iVPEXL/d71QDnA2IXkUmbOc/ythwWFhH0nQWj2z/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550147; c=relaxed/simple;
	bh=v/Y5b1wIgyGLOAsFWxUg4BvLWh2odBvZqKG+IACJEkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SLjJKrI7imy8ATRLFQn4IvNIdhIg8QiMiSVCZq18vOhXq/FZKC8gumpjADBVq04F9ZJixt3NnYYPVfOQDipGX3BsCKVlbiuD09WCq9gE86LIKtIItpBleFdi7XuimI2CZxOV+goqavUCQ+Z4D5hjtCRLQfWfwrl0YCburChxgOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ry9ruN5K; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740550146; x=1772086146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v/Y5b1wIgyGLOAsFWxUg4BvLWh2odBvZqKG+IACJEkw=;
  b=Ry9ruN5KfZOWMW0gAUQcaSw9L7bdL97iKWt24IXRxlJHaGv2y1MJF4C7
   rz7dNOQNlaItzUnU48EJnTSPyfGieMOqpCfjlDf+cfOkL7DAHk++odweI
   yiEzY8YjkEM5ooXDLJ0QHbOOncw1BQ0dv0YM9g5sDymCnnKXYxXlTJkv8
   wrfgTtjOdkagOCMaBeg5tDsEKJV4ypEtZVqyPZiKYyHmrU/ZbWjCsN7SJ
   EamIad7Hc9RF1/J30QpVoltmz5ddHqEVaoKTFmhjcRRLdCS7JEbd5A00b
   xz76ruVHxdl0lnKD6CkIpxuqp16zSb7frDVrLZQTqDJm44A/4+iE3k04F
   Q==;
X-CSE-ConnectionGUID: Odl6yNjtTXaC/U96ZZfHuA==
X-CSE-MsgGUID: zDwr+f3NSf62SfmTSnMykw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="40618025"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="40618025"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 22:09:05 -0800
X-CSE-ConnectionGUID: hKyhTualQheYG2gxzafE0Q==
X-CSE-MsgGUID: jlJwdfSOQ/yPgr3xp2xYMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121546806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 22:09:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 22:09:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 22:09:04 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 22:09:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5xdYcRbjpo0v3qrqAM+ZGaVjBnueDzZpgARfz9qFPYdo9Xrr0UYrKkhio8MyZk2Ytz3muLiDdlfzIwB2YiuzURUFd1H4Wq9vC/ENV3n8QQdHwVYRGmHUwKOlkdZ3qRPYykRyxSw8trMDQMSRDmhEn0fZIl6E3PtRVXaUUQuR+q5MxrCUXvDgJ1oUt4pr1utyFKnhIFKv0rCsGe7ZyrusLtz/yUT+C7j6m9OlK2XeAFezz6/L0L1tJ92nBiAtLNNsWKLB8N9RSQiL83vapsyIU5HMMToPJ+V/gpkzjnoFq+o/CmUPFqgoaOONpeKTVUF+JBCDsG4YKONMwi4DLOOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWQd60kUXpkmw/R1M1Uw+ilTkBS/L+Uz7Y4Uj+K1qGY=;
 b=nVdI0C96wRr3bW+i1Dasot8KIGcVM5fAZveikCJ9mFrKrxV7qQvxjKgf8Z0CzpGwzLEljdjKjbBj4Mp1N9IXHgR89JQab1GNZbHIKjskgoT+2+dC1u6i8ALdwcZIe8a2aReK4jl7qWJYc4gXQLR6vpMcNCP3K6Z41jbIdGTnMpqRrFCowXAPPGyHIO333PMRTNKM4Amv+GjuqSgivREDKxzKKkFFe3xKOqS/ToA+xQgQ9PS/8/9LrTl3qG73aewclz0mcHn+HSaBLQp+msewHnPf9ZKq7hFnNEu5ze1TW5WVFkshme15+VFbrg10BfuxYB6eBKctnkGYa2tvQYCmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 06:09:00 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%4]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:09:00 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: Refactor E825C PHY
 registers info struct
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: Refactor E825C
 PHY registers info struct
Thread-Index: AQHbe8ZDTmTy0glbUEmcIST0xbppybNXqDJw
Date: Wed, 26 Feb 2025 06:09:00 +0000
Message-ID: <IA1PR11MB62414A96217091A553E889828BC22@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
 <20250210141112.3445723-3-grzegorz.nitka@intel.com>
In-Reply-To: <20250210141112.3445723-3-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB6245:EE_
x-ms-office365-filtering-correlation-id: 523193fe-e30a-4e55-c125-08dd562c1026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?mIRgTjqittqFN0rt9tZrK3ncc66gGJg5yMtDRQ5Q6+Zlq7ySH9qyZ7jf5fJh?=
 =?us-ascii?Q?3eCt/I3sXfPQhnKOIA7H885HwpOg1BVInfkcQwprPh7MK+T+t79iuxLCG7NW?=
 =?us-ascii?Q?9GRSJ/xoTjX8u+2zl6RshF9Q97tE/orXJgEpUUNwlPbgiZTUOk8iIGe1MFZq?=
 =?us-ascii?Q?s4rrUQAAvE0EFbvW06xV4C6E1x29eyquG0hhqIR0J8GNBwBotCYfdCCqU/ql?=
 =?us-ascii?Q?ENf0NN9MIwNCkQFi64SvdOCvPUHJDttDCZO2e0f6XMGTwgCVlul2bwLaPd9A?=
 =?us-ascii?Q?UukArsncBo50/S/iqehs9BW+niK2QH9IeuQjmW88q+d/tw3W5W86ReMtVHlS?=
 =?us-ascii?Q?nJ4scaayiE8DbGNoZZs/18so/F7LTMkQpsckaDNMVaehBnqcZvP+qahbMCGT?=
 =?us-ascii?Q?wo98jwRT4bx+VDbW6GckI+WgZNY6MyW16N6KxrEF1km/m7WLr6LWs4B4c4VU?=
 =?us-ascii?Q?rY04qR/D2Oi8tqkEWAzR+p6UAZktip7q8DtuO1wcezsV1jHFcRK0ky8xC7lW?=
 =?us-ascii?Q?77CSgOi3bkhImcp6IPATflumxymsGCs4kGABU5bxWwPUhOxLUJcaWOD87+Bd?=
 =?us-ascii?Q?yTtCQ0K1EiXUyC66vmcUPJt/miu7kz7/iIl4IOpEw3TjyhzPgYZI96XQYh8m?=
 =?us-ascii?Q?ApFsYULqZ5ZUGpqoOySaBAOhIcfeCnvKMw7iGkkQZWY+jNOK9ztMadgvKspC?=
 =?us-ascii?Q?hwndPO6/02Xax9jJQfksZK0CfIXNb9kWA+DGCOn5tOIzEfYrCJqiLR6IqmE8?=
 =?us-ascii?Q?uBWJyAymPBvq0/kEbrvyJ32cfs9nV6nkIah44//gR1gcFWnmwQ7nf5IaNc3M?=
 =?us-ascii?Q?Tz+BEtXrsk6yj6/C2rNlpV3tGqhNr+UGHX6PhgQzoCdFhivds07KXi1J17a8?=
 =?us-ascii?Q?BI1ERiRPlG625iREWToFcpm2qXCa+/z9b/1j9Ad1gYkKNmAca41jthIDUfmf?=
 =?us-ascii?Q?7PceOoKQcIs8Pkks+ehDMB1Aus/Kp40ZJiVQzFeqAOv3aXHt8lQmkw7mGOCr?=
 =?us-ascii?Q?zYlAd7STLUif6m5sLCwQNdBumrvvJinIsdZSQfMfuXpjYq5ymYTVkCCXj/P2?=
 =?us-ascii?Q?5NsKzuvMgV/DjQJSPfj3CT/i8XBCkbPTKWgIXdypamjqg7sbdvTcHzX1tUmn?=
 =?us-ascii?Q?py+bAPrsqcAvniMfYPC+Dlk9T4T8AEhxcujuBO4E8VESZzp7hsjV0Q+VxAo7?=
 =?us-ascii?Q?0RRCfJi+8/Z7v0PC9p+C40V3fV0ireR968GyZLS3U7cNAPt237/uDkoYWWSX?=
 =?us-ascii?Q?M61+So2irY4D9wpC3qwW5n0BjVq5Z9fWkIXdKf9OnoIOWTna9uIotqGut7w8?=
 =?us-ascii?Q?9qCooFrj4BPQfWa2+xnhJ+t03WzbqYoS8n+alwxafk/rq5KbCjZEn976O+YM?=
 =?us-ascii?Q?LzgT60qWYoYLdbQgnKWRrgXPVrRgEfqS6TUX0VWuiiGLhvvBIK+Oy14XOxl4?=
 =?us-ascii?Q?sZVdKpC2iSL0pR+0Io2Y3OdheiIQixDd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hG6h8DlTGda+Kyo7yk8zQEmH06+5aPBLKZFQsWEWLkHxwwj5tFi82XSjw1R0?=
 =?us-ascii?Q?7Sojsg8md685SqR+/mCbd2iYfA+wPRpbTksBp+A5q31wig7trX1RciaYFm+h?=
 =?us-ascii?Q?f3f+dcVNqPAWt9KlpC23aML6mEzmPllzdVdFSTk49VUFGIhveH+3tISFWm4U?=
 =?us-ascii?Q?eQIRFjrPVmzr/wcPwGL16bw8p0Coj5XXwT1p4jAJWSN32c8nf4TwSCPqoTrJ?=
 =?us-ascii?Q?EHL0OlIu3yHF+v2SYW/YbOW4Sxofdx9zliYe85WJ4zY9pPg90+52/GlysJsx?=
 =?us-ascii?Q?DYuejuH/cmtFrs7rCsWUEzSpQQPnygOQfJtjhbooCPEbL7AzyHHFq+B0bGxI?=
 =?us-ascii?Q?tZAHC11s7tiGVmrn0CMkg8soPp8Z4IjK/9/yOyiUnUZ+EDoo+t7zMKHHlXjL?=
 =?us-ascii?Q?aiFvtb5Bs5orunxQ7SyTbYAJ3UYlF2O4Z5VeqlLtGJ6SBeyE1NFu1jxb0zm2?=
 =?us-ascii?Q?W1yxXp2JD6TC6/4edmBujsEV8sSJYH6qoyPKjDqx1H/bOlm2GxC5Yz+YcAr8?=
 =?us-ascii?Q?PIODP0EJ4+Wl0tZT6TSpsdt3sB26k6adfl3DxSV8C6f/po42GCYPdE8EovkO?=
 =?us-ascii?Q?xvb46DPN/YEvpZbZk8iYSXPAFnUPn0YbX3DOTBjPPIsP9GzHckAr4VVD726c?=
 =?us-ascii?Q?eHl+MtlC5O2iz5TXxeVTV1bCoK9Pz9FZeTXWCGL0dfoWY1+XjXD4ZItdAwr/?=
 =?us-ascii?Q?yuolGuscPRwvamItsfBaTaDKqwzioEy1UMjLu8VL5MZQTKszacHd4GgIOuOr?=
 =?us-ascii?Q?bFJshwYuLLarSeER2LBCoXFzIFrqJS1VFR/vc+lhM2FNNbV0tYH8BUO/dLlc?=
 =?us-ascii?Q?4xFJNbbZ5SA3zNobUZOgf+q62HwTG77mJWMbwu2hIsnb0IdFm0gtDA6RbMPv?=
 =?us-ascii?Q?8GPp8xEdwB0LsJYIwWh2yY0dN0p67jU9QCjpFxoPv1ozNSK/Oi0g4RKIB47H?=
 =?us-ascii?Q?z8TgmNzNgSsAfQ8w6ywb/xGe4cQE4bFfDzgYuwg8YWq0lX7OegJsHXxk5L8U?=
 =?us-ascii?Q?um0ocVUESthvHi8ZePnPvatWRyXrsYtbyKaqvv1ImCTN29YTvToS8sErNr3w?=
 =?us-ascii?Q?RVgZynAfWUVrdnB5x8tYourQaT+ILxajBsRRxU/VX50/K7MpT1gQpzg4bU6k?=
 =?us-ascii?Q?qPLy+dk1c1Y0SkVKSw4P+HzIV5nPUfR9UyLsomXdHjbqI8tfjlHRNRIhtd/L?=
 =?us-ascii?Q?KJdsqGxpukSGvHplPWcbi57FFlaDSYYVWe2aXJA6Esh2dit6jzdq/1zEFAfp?=
 =?us-ascii?Q?2snkUMdUNVDf0LuMJ1bTCleedQPNYJpwGBOgTkNQHZdJ3UfPlDih2JpmVw8L?=
 =?us-ascii?Q?hkv+UeOdvI8eussDPxT+mp1+jVEDIJHphVl8cW1qeHKGAa8ix2tmZxy49Uob?=
 =?us-ascii?Q?lt1Mf2a95UFvaCey/9RtKCTlKc7szsr1S42uguKVLe6k+Dl9/c6snK52/bqI?=
 =?us-ascii?Q?W0knBcHtWFhOwnSYSZoGPCEN8FxQqZ0F6zKgQW9ndaAL3iV89sjgQDLeCLuT?=
 =?us-ascii?Q?7i1Fc85JLJKyrrKCCLYTF/6AGX8UJNt13AHoM6Nm4c+EaxW7nr7vkqCcUPIM?=
 =?us-ascii?Q?eCVtZ932sYaJIfsxdU8D1+3Gj0JnPuihRCfcNVoI8IxpLDA1VkAbR315IBod?=
 =?us-ascii?Q?kWPfHtH25ftoH2dPAunsBPHXT5M1zF9KGlWxJOWIqz+4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523193fe-e30a-4e55-c125-08dd562c1026
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:09:00.5515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF8QENu+NYqo0DnA24+mNKd8VEocrR/yNOt21YW0UEH/FRLKzmQqsGn7tcz98tD72ohUqMz5K3Fr4Oeu8sxNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 10 February 2025 19:41
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; horms@kernel.org; Kitsze=
l, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 2/3] ice: Refactor E825C PH=
Y registers info struct
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> Simplify ice_phy_reg_info_eth56g struct definition to include base addres=
s for the very first quad. Use base address info and 'step'
value to determine address for specific PHY quad.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  6 +-
> drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  4 +-
> 3 files changed, 20 insertions(+), 65 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

