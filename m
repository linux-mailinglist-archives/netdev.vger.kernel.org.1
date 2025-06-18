Return-Path: <netdev+bounces-199114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C109BADEFE4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4787A1E2E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC322EB5AD;
	Wed, 18 Jun 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MitnSZMU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8C2DFF3C;
	Wed, 18 Jun 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257687; cv=fail; b=YIHHCDcUQEShJP9u7w+NolIlHNcDXCoX83YLDI2kUcvZz3R4OhfJilJ0s98Zbr+xBXNZzhH2UUiq2V8CSd9HfwZvih1d7zd5Gt/YKL84TEmsWn9EIp6lIGEK3kIrYlOjdfRiD9YLMyB7Dt4BGUw/17EadWp1wjy9Bn6imQ9O+ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257687; c=relaxed/simple;
	bh=qISxV3M8CPUmkXgTspked5Ua1xKBZ/y6F9l//lRwjTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YAn8sOorrzM9TUREJODv1bT1WatqD+s4sRaJLDmfZBKsCI/ygtMMK83eL1R094KjK760Zkjv6PLklfGS47bknSrkCUMc3FCtWp+8PaW5wulItb/u1GB8cUJw1x/K4HsWldvc0mt4kBzorhtWlooAZYzKxVipq7XO8qffJFs3y4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MitnSZMU; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750257685; x=1781793685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qISxV3M8CPUmkXgTspked5Ua1xKBZ/y6F9l//lRwjTw=;
  b=MitnSZMULwwTQyb9fjGVf24i/CoE9Wuwfh2bQdhRyXkSSkLi8CS8kjWQ
   YmZwB7EWNcVrK2sHLBBsB5o27ToiIbN6DZQUpBuTC8JcVCWzWskJlQ46h
   b5duZrx+SCBw7U8nSMQtktalIN0GkJ+N9CHZumNcokVkuk7UVtA3JNsUb
   O1Y30jX1yVgAKhQ34uLGaHm30w3VxgjCmp0j11AcVBzHHhDNwH6UVI3Mb
   Teo6/vb5/eWoiHd88NgyLhWMTXGUwLEIQWnpjqJoaIJhf8YhrIK6neVkQ
   UbE/NOhfNZCGKyEbeXmorcS4RkOYZaN4MjsDqjVUIKw4xXY8jLvl1uTR9
   A==;
X-CSE-ConnectionGUID: eahrMfnnR2iy3PFL0jI7+g==
X-CSE-MsgGUID: cxTg303lQCea7mgKlI+QdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63519667"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="63519667"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:40:17 -0700
X-CSE-ConnectionGUID: bjQTWve1ROii1n26lA6+3A==
X-CSE-MsgGUID: 5diuPcb0TsCu1ZUPQSysdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150142193"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 07:40:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 07:40:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 07:40:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 07:40:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk5WYKgXJAN5z6V9KJ8kerLbckUxPh7CVkSYtl4AD4pCHnm5KZCW5t6DQtE/vxDzn1lJ2U2ESm1liKGkgLDLNhVkHa1Tx0qban+1ih7sWeV5a1z9bfovjr5dftlsMBJpljakMvmiFV5ZVmlE+Slgr9ySbPIRuxLG1i747ibD4u9nyiliRZkNVomWvi35fgoOgdfkCqDMdlrrfFOrrP4cBEoAdYX4yN7264Cx7sC3gPoT+51I4CcsRCii6fckgpNv4dcwmwzOqlKIUMQ6JFcaJqTswyl7FxtsiWojIIvh29NdtDpNQEv82unZMEyLJDdQCLDUeND5yMWRjVDt/uiIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx6V+mw2qLOjvHsIM9+KSBhMUbq5xtJ5pm7ctffM7h8=;
 b=UE1oKkryVw/rIq0ckoKirH32utAL6yGrnRQaGRVYUugosTSu4nJgfEpwQ+Xk0pLxE9lTCSrkfZO/U9VNO4rZDIfOK9Gs/7BkLMx8iP2THy7hNwGSQbhmgGbUGvNiuXuXcBdjoiVvOMSZr/3w699NRi1j3zxxNzS6NF/UAy3G0evlN+5/OdJmWDDrUV8cfoLhX4QektlWxuEmbqVpIWajyzDW5P0D+XxIjktQsQMKoPg4joL7t0yjRJ6vFBN39jvSH1rBAJuykkHOMWVH0NDHaSF4vd8HnhRzvmFkJjcDjmtjYV2CHbR3vq0AbKYJRsKYQ8IH0mhMRNOwiWet6bC3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by MW5PR11MB5931.namprd11.prod.outlook.com (2603:10b6:303:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 14:40:12 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:40:12 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "oneukum@suse.com"
	<oneukum@suse.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"qiang.zhang@linux.dev" <qiang.zhang@linux.dev>
Subject: RE: [PATCH v5] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Topic: [PATCH v5] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
Thread-Index: AQHb3/dSNL4k8wih8kq9+NAK8pJv6rQIxWaAgAA3cfA=
Date: Wed, 18 Jun 2025 14:40:12 +0000
Message-ID: <PH7PR11MB84550A961ACC295FC5F1DFBE9A72A@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250618050559.64974-1-jun.miao@intel.com>
 <aFKgb-Stl-rIJH6g@de6bfc3b068f>
In-Reply-To: <aFKgb-Stl-rIJH6g@de6bfc3b068f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|MW5PR11MB5931:EE_
x-ms-office365-filtering-correlation-id: 97a3f806-9595-403b-aa6a-08ddae760834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VbiOFglaTYxy8uNBJbahtlVKsj9lwKtTMj2ZMcQw4kKB0sZCXYInMJoahESn?=
 =?us-ascii?Q?Mrw1WPk9vzEWFfFt+GT6ME1v3qslHaI+sybqzy3cx9oo9wrgqFCVpLs/wY5x?=
 =?us-ascii?Q?SGAUxYZKB85PUt6/pS68QIG/waz5pWB856OUxjxdcPvydGILBnMeypQts4VG?=
 =?us-ascii?Q?qqfbL0ACU2YxL+rHwDO1CQemAa2LgLZ5u+GT8JP/+NQTc/XtdBNBu186rspW?=
 =?us-ascii?Q?4uF/GIdni3T311XK1RYetmqsbnTBAfLTc2iiyTeCO1LEBEdhPUIsImTPXzMm?=
 =?us-ascii?Q?aVnC6A0NNpqUaXZq+4XWq8wySDU4iGMFzlQS3afMsdItZqUdzrZ2LRwgy4x7?=
 =?us-ascii?Q?dFaOD03xuzrkBDCpmqB/99Tz+UFHJ7JnTzJNi6gcYO8MggG+lDn0Xt7c4S99?=
 =?us-ascii?Q?t9nz+RBbwrXTG/Vrc7K+ITlLR4OXoNBdAzPyenuGvfRMcjwkGeZpmyMsiUtB?=
 =?us-ascii?Q?X0fnRs//qxioHmOkeQXQOG9I/STyWqKDqBRAac4N9Dr6Uggm6kGnaueq+1XW?=
 =?us-ascii?Q?K+dyxe0SdFu0vfHPJblGB8pXWhkFI+mCpAvUZIH9Q1Hq6w7J5FmqXdeA8lYm?=
 =?us-ascii?Q?RDs9asiQigf1OXYKWIoB6EHVQuBtEd5wdHRxirTkzVrjDO+aD3/0UYbPqH8y?=
 =?us-ascii?Q?dpCz6edShTSLGEuoCeF/Q8wKzbmH4Yt0avTcjginfktoigcZNHfVrnNfbGbN?=
 =?us-ascii?Q?/n6/+KY7rvh3j78NyPvKILjJUuEjt0dfvqxVZ8bBCYWL5Uw1HmlY2kR9waOY?=
 =?us-ascii?Q?92hTGnhzZuLTFtqS7iR8iPWENd9ma5UolLjqRvhA+DWQuv49R7acwkj2i78V?=
 =?us-ascii?Q?6P1cJXkfVL8av7n3RkeW8KbxJvN01P4QhIwKIWKvjqD6eSSnC11Q8q0u4Hjt?=
 =?us-ascii?Q?g4TFifHxa50EM74eWh4xLrNYrDvdai3KifTO+AUPPcls5KrPZOx4/xjdH6Qt?=
 =?us-ascii?Q?1Nv8wP0D0cZZm8NTzmkBWyXeeiEMvQUTwgxsnrCzGceL12WioHD8P5CBB6hy?=
 =?us-ascii?Q?IVvFQzzfSDGthppO5f/a/VcsAiyt7AzGzyKgkOkbDxxYNr4cKcgqV0DUqeLD?=
 =?us-ascii?Q?X+NmO+qs83PE2LEhYxDQw1rObeeYeBb4MxkuXdxc2jZkcPzgUOD7UYe+E03H?=
 =?us-ascii?Q?hcaFEk84k3s3MUrSOXHrTt90YxsA+aP7Rn2f3MISW6nA9mKJxsdBt4wewUFG?=
 =?us-ascii?Q?20EMzFDSweRUr+mHo374QGPAiH7kr9G4NJhh3DzQZOfWB/NNFiYaNUGNO0x/?=
 =?us-ascii?Q?QzoudqrhYCM9lehbMIQ5BYr90C8iILCcPSaQWvpNEkTw1XwEhAuuDc2T7jdm?=
 =?us-ascii?Q?VfgVXxLmABxX5Z/C7s4PuU4mf4R6dvnM6pMC/T5dILYZByjyc46boM7pKqxH?=
 =?us-ascii?Q?jdNjEYqBBCzuL7Fk2i+uAKYRMa6auboQwi7TwIrlExu5YuIglLT19tT8biEB?=
 =?us-ascii?Q?pJapFODETFPDpFp92D3jSfEl7MGo1gAt2Yeock5GIjOjbdhlTZg9JA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ou33dqqesWE1nTPz9LtlnrttnU2B5baZCu1BDsOR1yJFIS2cENMNYa6VKr5k?=
 =?us-ascii?Q?S6hRTWBWlowodNQBRgdRK2v0HxoaqNhMG9eld/PxNaYFLWWLto0Vh0D8zWSv?=
 =?us-ascii?Q?UGVWMESmD3z81OGHmN+Xd7hhmbVJ97gz3JGUwQY13PDCUDPbvs9RZK1wmUlk?=
 =?us-ascii?Q?ka/dUDD+DE9DsVoelaJ9D9s2xTQcr3kBhnoQGu1Koym0y+uPgo9zeHIIfBGm?=
 =?us-ascii?Q?rIH+92/MvUIgLnbAnzVW2eGVdx4HlSur0VjS+6NW0d6fphSscrIrG9rnBpvg?=
 =?us-ascii?Q?szsOgbwv2Oq2Xg5l0S6h5wkCfs9HpCsJByRx61mtCbP59oF1f4+VbBDro88e?=
 =?us-ascii?Q?BeI5uEjsz3Gceo856KwqQz0+334hC+gyRmxlJ5n47RJHbXAbsz2ChN2b9458?=
 =?us-ascii?Q?9IwXzqGZvBfSSeJ0E/ZSaA3guuykJ43Q1HsavNI47/5PIMON2IQEaNXqeBTD?=
 =?us-ascii?Q?SX02Oxp12f1YIR0f/cFybtDRzZFGTccLAO/aAIC+VmGn1G5HNzOeWSfWpw7A?=
 =?us-ascii?Q?NF6dBJJZbdXhfgpP37gpof6TJesbE0Pgkmits0Q0Mjim4Cfjz3Zga30DRkfo?=
 =?us-ascii?Q?TqaayydozODlz3UuXanCxHapE0AujkehR9BBdOnCVaAZ58LVyYZW4zI+vj5u?=
 =?us-ascii?Q?pKcuvLrR3+f04ijtxwHtuihCNjuHh+Ii5zGSeX9ed40Y2m+a2UIFb7yrXcAS?=
 =?us-ascii?Q?gNTuzCTlEeWMVPgAdIFMybwLEDdCa1+5Eg/C1EGqzJIToD2P+UY0QUYocGm9?=
 =?us-ascii?Q?NYT9BMNlVN4dOS6VrwI6A/w8+n7ldsTC68/5ENBXMMmwdAhlvpARe7aVZ8q2?=
 =?us-ascii?Q?LZ/UA7LpdtVEIxLRPPAfxRc8aHgy1W4xohaaQx16KqpdnuCltaf4ic5z5xE5?=
 =?us-ascii?Q?CyMsp1aG5V6/Rm7Mis84oEuqzRftzOV+DbEqKOiExmCaJ89q/kdHQPJ31egQ?=
 =?us-ascii?Q?jAHaCfUnu2lnXsSIrOQ4Uk/Ktz8X1SkxF1aueF5sSNP3355zp5gFSngVZFUb?=
 =?us-ascii?Q?r8EV/Ug+tZvsUG7umkOnQZtbbukNM3vbYrQGP1VZhcrbIJ3XfbbdgoSK+Tka?=
 =?us-ascii?Q?N4fX77ILT28/LqKEAvtPvJ4U/T12r6RUCAJa+tyNsR3z2Dq3S3G6qkodgaEw?=
 =?us-ascii?Q?xzaDNh0Tkcqit5NRL3yrtkAvwjfrm7hFXcXFFDdQ4P6MO01Zb7aIO/wefZlk?=
 =?us-ascii?Q?tNbwJe+O9XwK4NGdI1nX+WetCsHdlEr2BLMUqMCNk/9tBE1CeDqfMTRwsVd+?=
 =?us-ascii?Q?uI+hpD2V8F62quA8NqFELooIKD/bxZeflUDhsgjxvEuyQPCobewXT3vsRRVM?=
 =?us-ascii?Q?syYNmR+7pN1YYkfmcqxbpnK+y1i4uIDaTTtLaVEQMZg7PABrCIBod4mQ5axw?=
 =?us-ascii?Q?n0L0uWP+lqPhaw6t83KC0woU+2jwxvv6hFJnaTDfBL07eGl24Z5U3tSfNh6e?=
 =?us-ascii?Q?2DeQXLQbqkVvp5dpf1/8b2TUU9Eh+GsuMtZOzXSeO5MdzHlGI9FBe4tbT+V4?=
 =?us-ascii?Q?Zm+XIjJEpbQcu2N8GxVwYv69et6VACim7tXFJDB9+p/4s1O7eQzQpzSHvT1N?=
 =?us-ascii?Q?IKoYvDk37JZnU4delpNtHQ2XwRyRTs/pgMm5nLNw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a3f806-9595-403b-aa6a-08ddae760834
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 14:40:12.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ig6qXcf/hssGxlkENNvWC0LawQtK/U1XWQm8PkAuhW4eIGL3eLWl42hBEZpVDMJv2swQGfT6WryUme726mVQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5931
X-OriginatorOrg: intel.com

>
>On 2025-06-18 at 05:05:59, Jun Miao (jun.miao@intel.com) wrote:
>> Migrate tasklet APIs to the new bottom half workqueue mechanism. It
>> replaces all occurrences of tasklet usage with the appropriate
>> workqueue APIs throughout the usbnet driver. This transition ensures
>> compatibility with the latest design and enhances performance.
>>
>> As suggested by Jakub, we have used the system workqueue to schedule
>> on (system_bh_wq), so the action performed is usbnet_bh_work() instead
>> of
>> usbnet_bh_workqueue() to replace the usbnet_bh_tasklet().
>
>No need to write review comments in commit message.
>Patch LGTM.
>

Thank you for your kindly review again. I will delete this paragraph in com=
mit log at V6.=20
Jun Miao

>Thanks,
>Sundeep
>>
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
>> ---
>> v1->v2:
>>     Check patch warning, delete the more spaces.
>> v2->v3:
>>     Fix the kernel test robot noticed the following build errors:
>>     >> drivers/net/usb/usbnet.c:1974:47: error: 'struct usbnet' has no m=
ember
>named 'bh'
>> v3->v4:
>> 	Keep "GFP_ATOMIC" flag as it is.
>> 	If someone want to change the flags (which Im not sure is correct) it
>should be a separate commit.
>>
>> v4->v5:
>> 	As suggested by Jakub, we have used the system workqueue to schedule
>on(system_bh_wq),
>> 	replace the workqueue with work in usbnet_bh_workqueue() and the
>comments.
>> ---
>>  drivers/net/usb/usbnet.c   | 36 ++++++++++++++++++------------------
>>  include/linux/usb/usbnet.h |  2 +-
>>  2 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c index
>> c39dfa17813a..234d47bbfec8 100644
>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -461,7 +461,7 @@ static enum skb_state defer_bh(struct usbnet *dev,
>> struct sk_buff *skb,
>>
>>  	__skb_queue_tail(&dev->done, skb);
>>  	if (dev->done.qlen =3D=3D 1)
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	spin_unlock(&dev->done.lock);
>>  	spin_unlock_irqrestore(&list->lock, flags);
>>  	return old_state;
>> @@ -549,7 +549,7 @@ static int rx_submit (struct usbnet *dev, struct urb=
 *urb,
>gfp_t flags)
>>  		default:
>>  			netif_dbg(dev, rx_err, dev->net,
>>  				  "rx submit, %d\n", retval);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  			break;
>>  		case 0:
>>  			__usbnet_queue_skb(&dev->rxq, skb, rx_start); @@ -
>709,7 +709,7 @@
>> void usbnet_resume_rx(struct usbnet *dev)
>>  		num++;
>>  	}
>>
>> -	tasklet_schedule(&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>
>>  	netif_dbg(dev, rx_status, dev->net,
>>  		  "paused rx queue disabled, %d skbs requeued\n", num); @@ -
>778,7
>> +778,7 @@ void usbnet_unlink_rx_urbs(struct usbnet *dev)  {
>>  	if (netif_running(dev->net)) {
>>  		(void) unlink_urbs (dev, &dev->rxq);
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(usbnet_unlink_rx_urbs);
>> @@ -861,14 +861,14 @@ int usbnet_stop (struct net_device *net)
>>  	/* deferred work (timer, softirq, task) must also stop */
>>  	dev->flags =3D 0;
>>  	timer_delete_sync(&dev->delay);
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	cancel_work_sync(&dev->kevent);
>>
>>  	/* We have cyclic dependencies. Those calls are needed
>>  	 * to break a cycle. We cannot fall into the gaps because
>>  	 * we have a flag
>>  	 */
>> -	tasklet_kill(&dev->bh);
>> +	disable_work_sync(&dev->bh_work);
>>  	timer_delete_sync(&dev->delay);
>>  	cancel_work_sync(&dev->kevent);
>>
>> @@ -955,7 +955,7 @@ int usbnet_open (struct net_device *net)
>>  	clear_bit(EVENT_RX_KILL, &dev->flags);
>>
>>  	// delay posting reads until we're fully open
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	if (info->manage_power) {
>>  		retval =3D info->manage_power(dev, 1);
>>  		if (retval < 0) {
>> @@ -1123,7 +1123,7 @@ static void __handle_link_change(struct usbnet *de=
v)
>>  		 */
>>  	} else {
>>  		/* submitting URBs for reading packets */
>> -		tasklet_schedule(&dev->bh);
>> +		queue_work(system_bh_wq, &dev->bh_work);
>>  	}
>>
>>  	/* hard_mtu or rx_urb_size may change during link change */ @@
>> -1198,11 +1198,11 @@ usbnet_deferred_kevent (struct work_struct *work)
>>  		} else {
>>  			clear_bit (EVENT_RX_HALT, &dev->flags);
>>  			if (!usbnet_going_away(dev))
>> -				tasklet_schedule(&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> -	/* tasklet could resubmit itself forever if memory is tight */
>> +	/* work could resubmit itself forever if memory is tight */
>>  	if (test_bit (EVENT_RX_MEMORY, &dev->flags)) {
>>  		struct urb	*urb =3D NULL;
>>  		int resched =3D 1;
>> @@ -1224,7 +1224,7 @@ usbnet_deferred_kevent (struct work_struct
>> *work)
>>  fail_lowmem:
>>  			if (resched)
>>  				if (!usbnet_going_away(dev))
>> -					tasklet_schedule(&dev->bh);
>> +					queue_work(system_bh_wq, &dev-
>>bh_work);
>>  		}
>>  	}
>>
>> @@ -1325,7 +1325,7 @@ void usbnet_tx_timeout (struct net_device *net,
>unsigned int txqueue)
>>  	struct usbnet		*dev =3D netdev_priv(net);
>>
>>  	unlink_urbs (dev, &dev->txq);
>> -	tasklet_schedule (&dev->bh);
>> +	queue_work(system_bh_wq, &dev->bh_work);
>>  	/* this needs to be handled individually because the generic layer
>>  	 * doesn't know what is sufficient and could not restore private
>>  	 * information if a remedy of an unconditional reset were used.
>> @@ -1547,7 +1547,7 @@ static inline void usb_free_skb(struct sk_buff
>> *skb)
>>
>>
>> /*--------------------------------------------------------------------
>> -----*/
>>
>> -// tasklet (work deferred from completions, in_irq) or timer
>> +// work (work deferred from completions, in_irq) or timer
>>
>>  static void usbnet_bh (struct timer_list *t)  { @@ -1601,16 +1601,16
>> @@ static void usbnet_bh (struct timer_list *t)
>>  					  "rxqlen %d --> %d\n",
>>  					  temp, dev->rxq.qlen);
>>  			if (dev->rxq.qlen < RX_QLEN(dev))
>> -				tasklet_schedule (&dev->bh);
>> +				queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  		if (dev->txq.qlen < TX_QLEN (dev))
>>  			netif_wake_queue (dev->net);
>>  	}
>>  }
>>
>> -static void usbnet_bh_tasklet(struct tasklet_struct *t)
>> +static void usbnet_bh_work(struct work_struct *work)
>>  {
>> -	struct usbnet *dev =3D from_tasklet(dev, t, bh);
>> +	struct usbnet *dev =3D from_work(dev, work, bh_work);
>>
>>  	usbnet_bh(&dev->delay);
>>  }
>> @@ -1742,7 +1742,7 @@ usbnet_probe (struct usb_interface *udev, const
>struct usb_device_id *prod)
>>  	skb_queue_head_init (&dev->txq);
>>  	skb_queue_head_init (&dev->done);
>>  	skb_queue_head_init(&dev->rxq_pause);
>> -	tasklet_setup(&dev->bh, usbnet_bh_tasklet);
>> +	INIT_WORK(&dev->bh_work, usbnet_bh_work);
>>  	INIT_WORK (&dev->kevent, usbnet_deferred_kevent);
>>  	init_usb_anchor(&dev->deferred);
>>  	timer_setup(&dev->delay, usbnet_bh, 0); @@ -1971,7 +1971,7 @@ int
>> usbnet_resume (struct usb_interface *intf)
>>
>>  			if (!(dev->txq.qlen >=3D TX_QLEN(dev)))
>>  				netif_tx_wake_all_queues(dev->net);
>> -			tasklet_schedule (&dev->bh);
>> +			queue_work(system_bh_wq, &dev->bh_work);
>>  		}
>>  	}
>>
>> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
>> index 0b9f1e598e3a..208682f77179 100644
>> --- a/include/linux/usb/usbnet.h
>> +++ b/include/linux/usb/usbnet.h
>> @@ -58,7 +58,7 @@ struct usbnet {
>>  	unsigned		interrupt_count;
>>  	struct mutex		interrupt_mutex;
>>  	struct usb_anchor	deferred;
>> -	struct tasklet_struct	bh;
>> +	struct work_struct	bh_work;
>>
>>  	struct work_struct	kevent;
>>  	unsigned long		flags;
>> --
>> 2.43.0
>>

