Return-Path: <netdev+bounces-244568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3ECB9F5B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 23:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14D13079A28
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31F1B87C0;
	Fri, 12 Dec 2025 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLDjdKTF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934563B2A0
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579064; cv=fail; b=boMBmSX1JCH8b9WGEz4sICymcV0HhppDweSHzTIqah4lWuSTJfoyjzlgWfA0mP6E353OwQHb3cDOf85621qqu6hgXChT1vqKjxjVySXwWWhZWQe2wSW4CvFhMnJo7V2WSB0NcCCKxfd7YmO5P0lgzZE5QiuKyJ9xB4AXKw163BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579064; c=relaxed/simple;
	bh=JDp6IC7kynuTzB/KdfnwMJ4FamkkdZZATwvtdO15D3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajBRbFpjhHjjyxlhmBVmnLxVodRpHIFbzbEyFFFZRMxUA+j/BlBi6PR2H94PDHrBbwDDCut5ZMyJSUhFm3iB1T1BB8MHUqx57DbodA+sSwK5TSE1uD4yPlG8PSw2VHwGRVHpd732MZ/ddYmKLYEi7GNU3cgDVLuHvu2Begh05MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLDjdKTF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765579063; x=1797115063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JDp6IC7kynuTzB/KdfnwMJ4FamkkdZZATwvtdO15D3g=;
  b=eLDjdKTFXi5Fs2K4mQtKXjMRn4ghaFC58g38dmYkfVjpRIhv6nG2ImtZ
   CC3z6VQrjqiygSVioTcStbSbnrGMXLWWTIOZLoYxt3EagdsVZxGmgYaY6
   LBzyHR3Xb87spHAG2nqRMPXQj9tlvqv76w+I1CXaYMmVC+mgYncNEtXlK
   bnBhLM3jvO3d4LRZdk/C7Pbz5d2GYK7tV3Y87a+FdAGyV+FruSqKtJX0z
   5A7CGPNhpLIwW6yh2LZDF+lh49DgmQ8/C0KlJ/cQmT4H+2nzyUcyxttMv
   Bx36mobYhPSAH1u+V1Bpeh3iUDK1JfM/pYCVfdY1t9o+lzE8aR47NZSV5
   w==;
X-CSE-ConnectionGUID: z3RRqp5dQnOQi4W/f6pxwA==
X-CSE-MsgGUID: 0QJIeOZnT6iMkV/jIoF7Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="71446757"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="71446757"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 14:37:43 -0800
X-CSE-ConnectionGUID: ocN57cNQTfSYWwlT2BIoGg==
X-CSE-MsgGUID: GRn47468RBuLGV1GzVNWPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="201378795"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 14:37:42 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 14:37:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 14:37:41 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 14:37:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1XGkzK9aHz6kKBRmdtHY83Itj+kP2VG3ApqDHBJWDD5s7JjAt/vdoAhFxTHV5xEb8OlhluP5FZR5qlS8eFxJcgZvrGgD2VzrnE5JMCjYfFKG8xna2/aYclfTh0MNOmFDBbKqYNFe4GWuNYTRg8v3slNXK6Gjeci6xzzOgO/GPm8j2UGsyUIXAyxyN6qj5QPBU2/uxzIxoG8bLrLH+kS2kf9tvkkBPQQE4k4I3C7GfaTeHAX5khKcvNg5XiNrhRzP+baoHnGrTqfSvbbF9jMAMv31dWKKy/JlqyBB31KsxqXm9uoWv8Wo7/ST4CUeJ76sQ/klfst+InLrmYLNNc4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDp6IC7kynuTzB/KdfnwMJ4FamkkdZZATwvtdO15D3g=;
 b=QPuswvSDsio5Q5mfsOIGAAC+N2uOngwklQXpjpmFvh3bz+0JI6CsNvS4rL7bhdWaDqZ3ASNdGQEhNGS8QuI9zzMaHWohmf2bwdOl9C8FLy/gyXUduLJRb/ZdRGZvrovfvqRYN0axbZkyFcFs4r3Sfgg8SJTUYJRU9MUCsG7hx2lcMTR8h2T808Kf4QZvoeGvB8qNhoBKyhFD/qHIp47obUBAEQNYcynA3rDw2quvC5Z7jYOmcBvaH0KSbbsDJNopO6YXMY8oRqBoCXIgedtUPE629brGohWGAtUqW7LTz6Z76WNh13ynh5v3si7VZfRK7FOM/+2jdemxxcv7HCExaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 22:37:32 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 22:37:32 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Simon Horman <horms@kernel.org>, "Joshi, Sreedevi"
	<sreedevi.joshi@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Chittim, Madhu"
	<madhu.chittim@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: Fix error handling in
 idpf_vport_open()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: Fix error handling in
 idpf_vport_open()
Thread-Index: AQHcY+FUAdOqLHJWMEyParC1VvvJarUQTByAgA5br0A=
Date: Fri, 12 Dec 2025 22:37:32 +0000
Message-ID: <SJ1PR11MB62979B75F424F758B262BB1E9BAEA@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251202231246.63157-1-sreedevi.joshi@intel.com>
 <aTCNk9wSxcNQmSSE@horms.kernel.org>
In-Reply-To: <aTCNk9wSxcNQmSSE@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|PH0PR11MB5031:EE_
x-ms-office365-filtering-correlation-id: 39b8f3ee-1ea7-4815-a3c9-08de39cf0a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?G8zSwv4yElYGJtveU0R4MQDtpQ3S7fUpxra9/P2zOnpAB+M5sm16t0vsURmy?=
 =?us-ascii?Q?JKuYeEXzHKN9nBEPXGFjkHWWf2j+91HVdbgVUiso11u9QG5VyyfoV4rCiUdr?=
 =?us-ascii?Q?8QX4iz+c+uc0IGHT8anHCAEU4C0E+0AIENAxPF6Wnt5xcIYSa1NatxZYrZbZ?=
 =?us-ascii?Q?MKrYSr3+14HvFNowZrZcn6jpqJ1l9CIpq/AyIDZ/SoFqJxEiBilMI7pAsKJZ?=
 =?us-ascii?Q?IQcKjjQfKDaU3Oy4p0Lknx+I3TDlb3bMs6DofLk3+pYKi9PvHjEZZjLwkyYG?=
 =?us-ascii?Q?rQwbwSfwZ2oUc/K+10XemQSKUqnniEBd052MInATFpFYS5ti4VJ7KJoLHZy1?=
 =?us-ascii?Q?hKL014GsdvKgkVM271sFVqZoHC6Qm4VgQKaKalIQDk9nBFhNazqqniSs+3uN?=
 =?us-ascii?Q?3tkH4Bp0gYyvd0IXzGa+1iyDl/npqcMmZuXNttSiPQezSb8rRBm0dCR0a7EU?=
 =?us-ascii?Q?OJb/DycSN7FXCnS/2lGPlrfk77kvJbfgeS/AvDBaFrAjKrrHFaR6hVv8S/pg?=
 =?us-ascii?Q?JUylV27zwVPSFxUt4g8SIhzb515VXb+YJAwZ1pzuuqCuTAwE+QC6BIoeeXsb?=
 =?us-ascii?Q?5CCwhJLIFU0RumPgsXwXZxukxEWPRcYedQKhytRda9Cetv4Iowey2nz7p21K?=
 =?us-ascii?Q?uLBUK6AXQyuDInjX0X5Wf/9jHhyR+zC1vsux0w8bYQjusJCduHjZcs94lnJI?=
 =?us-ascii?Q?sU7au+UO7CmXyufY0L6a/jtlgufnFz5BBMNR4A2aGuVT5x22CtDrNr7JHicI?=
 =?us-ascii?Q?i4wn5bOwHF+fR5zj4hsMbL70+ZuRRaBOWaaB0Y77Z6HYTzkXDIs02DhsLswy?=
 =?us-ascii?Q?6h6+9TRakAPCYJHI9Jql1m/JNkugzugom9IbnOdnQkmuxD/l0cTPVk3WkJHn?=
 =?us-ascii?Q?FmAVRvPzriZxG4ikBfYDqLNdqjTQ+YF5Agqn6iRDXPZWrfJ9C17rtMhqu/AA?=
 =?us-ascii?Q?MQmiyf2YE4LND0xGRXB2iPxtlgqIDQFR+TQ+g4FSKpdQbSwlnzyLC1U2Xfi2?=
 =?us-ascii?Q?2kWr7dbAE0XyX2t0DS/PKteTm4fxnIRT7QasnNaMR7Q63Cie5R/Pti2DQgoQ?=
 =?us-ascii?Q?LlO/TXSoA12y269wqUljjOdz2Fl0GwLTZLOXPSIwZ/Vp7oxjMhEKOWFHqUWF?=
 =?us-ascii?Q?vNNlXnUw1uBu8vtVww8DPi394Et1U+bglEsdx52oe8oSXQzISOHaUjPwjqwv?=
 =?us-ascii?Q?uHcc766FNCOldt1+/byTuA4U+bjHHdBTQfELFnk+y9i8uP0W+5qb53xYrxbe?=
 =?us-ascii?Q?aJnMe4xKpBV/q3xfLl8q9MMBMCBFGtzLJqYDpS7NjjwoppFDZMEt1MB8yDsf?=
 =?us-ascii?Q?z92nqePwFprb/pK8dMR6uqabI0DegeO2jrzmHn6vzM0HDcb0Yn32i+RIdNTj?=
 =?us-ascii?Q?/MKzKIpGklS9TBmklos4RmEIb13dxu3tZiNimYjdpcezfon1bbC8IpdKA0FF?=
 =?us-ascii?Q?wk0UKXnYdMcOvO7+Qa6R9i3u1wqaZ1cnFg9e2DT9wpDWJbDkQGfDjrT3DWQs?=
 =?us-ascii?Q?IBUgCC0qzFse19IPgWgNKaA9ukHvO/0+g0lr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sNftNBiNn3++TS9s01ZG8bfe1KhK6w5qAHbk0q1Y+DaZI4oayFO+Hr35gSk6?=
 =?us-ascii?Q?SC3svdhfJFcAPzet6/u6uzmQxRZB17spI6+m4EAjtlgiHnWafS5+gsc846Gk?=
 =?us-ascii?Q?k/s5mxNTUwMQ+r/tWcjOHmMfRqmU3M+LOOutTOtmXE1Bqfl66dgVRUzeOUWL?=
 =?us-ascii?Q?1VA0sj4e4n1nixzUPzdqJfNxTjS0vnsD6HQeUXyQVgW49tG5OoCzka2s17+9?=
 =?us-ascii?Q?kAE8QXmXD9nXEk4VaaRo5X1HIk2aNygMmd6hViKZJ3n7Hn8CsCEDnG25DC91?=
 =?us-ascii?Q?DIF0Snwocomfk0JiIlcZzE5Z1bLPlJ1Y4MvLeZ7lg+EdWhzu1pC1mYvHt6/a?=
 =?us-ascii?Q?81VLpHbN7DuZ9nGesU3Xgio866XvY56b7rE1PbMP8K/Y15Rgr8bIu6qS6PPq?=
 =?us-ascii?Q?ue95QCjztni+45C6dlMwUL4mE/ww++6a6CPeC1JlGMx9bdgVKa4f6sx8jBYx?=
 =?us-ascii?Q?TW1k7+FxEypcYXDMMhiu3aM2k7YAbil2F2Ep57gQyYyDWLrD3OcVx+el8fcf?=
 =?us-ascii?Q?3wpDSGEE9GY+Ew9+fF16SGrbggy9vR1io4w0vJllaIPEqVxq7GjQlGzYQAhK?=
 =?us-ascii?Q?LiivSLnI7tO6CCANGXebKLzohSreygT179Vd3Rvg0JfDV5QshODI0s8w/HTK?=
 =?us-ascii?Q?3OYPLQ6k/LNikVB6abewkZF5l5CJ1hyhqmAYY1GZCY2ckb69SqUSSKwnxD7L?=
 =?us-ascii?Q?PCqG1nT6mKNdRTkJIkzaA3fRmrDm9UkhusI5yXShGSim3UP4TmXc3MGFebt8?=
 =?us-ascii?Q?+dX2A6AIvqlAUguMyY36XPcW11fC4ZMcw1NmQLp/Ex+DboO5T8/8CWYJsa5y?=
 =?us-ascii?Q?8f8MQaDyoa85FwbExpADGz1JEJ2kIJ6+poPRfWJyLoSSiT9Azb41KhiUB9Fi?=
 =?us-ascii?Q?BDgczLrbg2j5TxjIu+ggbZelRuyDAfJPFGxiMo8Qvzpzm3F+JwLhqlMsyoHT?=
 =?us-ascii?Q?tMEhYpN41z5AbLHhmpvfulDSf/WVxlxcUZisugjdl5Cb4Nd6VM8tWJf+7CTw?=
 =?us-ascii?Q?060o8L6sBIjrxQWjYolM/aY49aqJHcMD4N50wMfxmVU8jFNc4tSdTtXKov6S?=
 =?us-ascii?Q?VRoSgjX77ZMo8pL6EUNY7i0cMkE5kErX4XZqRwOVDSeYQaKTezzZD/u7yRjK?=
 =?us-ascii?Q?HxA4eUWq1pAhOXs/Z4RLV6ySzmgrGNBxDrh6U6EjCKoXcsY+ptnGIyG90dnt?=
 =?us-ascii?Q?/evhcGmFHM7BDMJ81dsdWxh/1oiWy12699wFaVBH4Zx36uiT62KKxp4HvkHb?=
 =?us-ascii?Q?Ap7VzEkBsxvL7cerF4xjomE/BqUCh+5iGX7HtegmNQNVtvn3qKJ/q51zkHLf?=
 =?us-ascii?Q?O48cMxg5wJmbfGnVgeyDv6DHmjMw/8zVeaA+HinxX2t+0P6GdcLZofBwLdFY?=
 =?us-ascii?Q?0O9YdqKUmiHvmztCc+riicB2Jnd9KKnwd0KKMM21hY6BUMnvznTftuFJFksU?=
 =?us-ascii?Q?ADDG2P8OK+QhQfxeLn/ySyY28oA7KkOh3ef9mVpW0TA9CpI1CXyYNNXYCDlx?=
 =?us-ascii?Q?egwq+JG2ARZp+vRYYIPiYdBZpCcwxaevds0dL/HmAo4tOKCxx+ayAKzX40Do?=
 =?us-ascii?Q?ze8G1aBoFZX34GRaXx32CdFCOWKRMs4k2ftb7Vfb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b8f3ee-1ea7-4815-a3c9-08de39cf0a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 22:37:32.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdjPDk9+AU1om1arOSaV5+1dZy1eCOEWRZSLqZYc4OIDIvyDCJEa35gNpUmWrAqVVWoSqqKt0iK/5EIVEivHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Wednesday, December 3, 2025 11:21 AM
> To: Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Chittim, Ma=
dhu
> <madhu.chittim@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: Fix error handling i=
n
> idpf_vport_open()
>=20
> On Tue, Dec 02, 2025 at 05:12:46PM -0600, Sreedevi Joshi wrote:
> > Fix error handling to properly cleanup interrupts when
> > idpf_vport_queue_ids_init() or idpf_rx_bufs_init_all() fail. Jump to
> > 'intr_deinit' instead of 'queues_rel' to ensure interrupts are cleaned
> > up before releasing other resources.
> >
> > Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> > Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Samuel Salin <Samuel.salin@intel.com>

