Return-Path: <netdev+bounces-174809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF7A60A1A
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999BC3BC1BF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421D158870;
	Fri, 14 Mar 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmCRWeGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08C13B592
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937626; cv=fail; b=eAopfKT7RNj3POMNgEaZKpExI/hHdvM6jNt/p/xMvkmLlPi/nzUXmlOqbrDiaMuAcJtd9B4ayX4o3ZU574bIbwN7Kxbc1T+xeOo6+xWEB1bXKwDM5PE0xrTsK31+pmePR+2/VsASlD8vZjNx4y0U8lvvXWWSVoSPo0774SodZlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937626; c=relaxed/simple;
	bh=H+htUednCoo19JLayf/fdGUj/OZk0hieB/W28VoYt+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dT7VGiFzq/aaE0um38RkpgLhGNbEf5Yi9fsalRBeo7XlTIAgs8lJySybxieS5VyZQQJgtuLoUZ1j6/tNX2XX0KIaG1In6+5cuV1JDId53cGKJY499hoJFeV87XALH2xU7kVFrHxjGEM41AGZSSAzgjRFdcS6LE1Qa4B2YPgkbz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmCRWeGQ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741937624; x=1773473624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+htUednCoo19JLayf/fdGUj/OZk0hieB/W28VoYt+0=;
  b=HmCRWeGQGBd41+yEgKz0PSuTISeIm2WafoEoO8i0HowHq3bpADKKl/sJ
   penCtfzmq2vXR7dfOFuHEx98or63at6l4c0r9RWOR54JrxwlBopVHENIc
   4calkFDHcrUMEDYCzPx4+xSarbcvrApHLPd6PKF0kSym2KMqnmPNla0ia
   eDM/oB+etztrDFtX3nwoibHpw3WnjhnDMDmK2GvmpY+gTMmQmwD9dgkaS
   iV+uH/8YyYioIG6dXpnu3CdKKhxbqn1BqNBV9XJCcrAoSx1XxqAxQ635q
   uIJ8PbAy41tLxg/NNrMD1tYQYgMVP8jKvqBSnCLgdWFbGTETS1oofVlyt
   A==;
X-CSE-ConnectionGUID: YsitRS0LS76ep7jenuh5jQ==
X-CSE-MsgGUID: KnQRcxs9TqaxgS/fQe6rSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43288937"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43288937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 00:33:42 -0700
X-CSE-ConnectionGUID: Ff0YqsK2QxmSPSIgymdEoA==
X-CSE-MsgGUID: B5wo0F6XT2COn0FaOKT5GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121394665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 00:33:39 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 00:33:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 00:33:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 00:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMuPkNoGJGgJrv+5At9Ko+lfyWXr8CvAHXjhjusasrLOCYncTeYIO8tW/bAeYmQGq6/Jlft4L9meyG0oqPKkfSOLhpbUvzbhMNKx0XaYHFvsPOFDFgnjGZXlRCjGdQ4nmoecaHJud7rFS3ASI0Y0uPO5jU4l1SEsudA6ydlmZM7JMz/5aAl6W0kCqjnwbStM6/+rW+UdxYrsZ120LzTX5SzaBtAUrVw0RYCT72q2MNjp7oT6U4z50VwQOI28aKen52SqmHowfpHvsjvsfBuFKBFLSdq2oondtIBQRIUnfv1tZJGKFqWBAONfpJ/k/w2vtWuaWkoGr3ctNZZpOFdYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wBGDVRXDIZAbvD1O+TslTWbJtA71M9wOn356vQfIpA=;
 b=mXBWxSHlg0QpiV0aOZTbB/Av++jHCWOA45kACwueY1UpjnbJqtUc9+Sl0ZRyOWcXLUH5C2lGHWAF56GDeIC5Xe2gl4D3uQDIJdvgK5OUvLAzdtu99Ry4LnXqTTqKFUUaZSwBY5uJWeNLFbgmhi3HBmFhyaHoc8D0wplvsN7o+9wFrD+GqHNKsd3wHmZxlhoMoO4ohScy9sLVbCSWXnvY399oPUJONiVZjKYReH0bpMdTJMa3zIGVPlwLe+PdaXNoGdpbBJm8cvW5dH9ETxYbcZltDbhjiUbJY9GjjZ4jklooxGRqP1dhuY8zUGd+KcTDHeg13/8p/4iA5Mu4aXA3xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20)
 by MN0PR11MB6183.namprd11.prod.outlook.com (2603:10b6:208:3c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 07:33:28 +0000
Received: from SJ2PR11MB7518.namprd11.prod.outlook.com
 ([fe80::81f9:67e4:b75:88ce]) by SJ2PR11MB7518.namprd11.prod.outlook.com
 ([fe80::81f9:67e4:b75:88ce%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 07:33:27 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Knitter, Konrad"
	<konrad.knitter@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, Jiri Slaby
	<jirislaby@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: health.c: fix
 compilation on gcc 7.5
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: health.c: fix
 compilation on gcc 7.5
Thread-Index: AQHbeObpXvVMwL1vMUyLFT7Xzm7AprNydEEQ
Date: Fri, 14 Mar 2025 07:33:27 +0000
Message-ID: <SJ2PR11MB751841C63A37996E16B8A0A5A0D22@SJ2PR11MB7518.namprd11.prod.outlook.com>
References: <20250206223101.6469-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250206223101.6469-2-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7518:EE_|MN0PR11MB6183:EE_
x-ms-office365-filtering-correlation-id: 428e78f6-2bbc-4291-a948-08dd62ca830d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?t1RpBgXfXaoG3iPUToZJdk3u0EqVPfRVqnISgvaJ/ukb+op7bv823szXkbZH?=
 =?us-ascii?Q?N9/LhWMdQL0MDrUglK2wF+SKa0OmpjHnEODwS61067Q1Bes/dc+GIYFInaAW?=
 =?us-ascii?Q?qjVNOUbqbTycnWpyPgkDeI1WxxHaMyMLSoorTBzIEti422bIsJmAa97lPw6u?=
 =?us-ascii?Q?7awG8QJ0vJqLc7u/VmEBzklnbYXBRyHzGSaYnlnGymEM/YmiMEgaOOxReZio?=
 =?us-ascii?Q?NdJiBzisWc0vmzS2zllyHzZClm5xESQT+ePBbezeLk9RsxRM29IDdD+SzmCP?=
 =?us-ascii?Q?N/talc2Say96Yile6hWE07RmdjOYLcXVIRvSxuY6xQ10eVnOncgqRc3dIU1u?=
 =?us-ascii?Q?CnArEyh9xqLgzNBs8vfwzdT9THfJMEViG+jahZBnh5Yev+1CMu4DiwWa7K/t?=
 =?us-ascii?Q?zVywHz65/9VpUBi/o8nzzqVqBraZkJzYOQomFTYUwaUTDppUsqfkQEg2XUpP?=
 =?us-ascii?Q?/p065xpz1iPWPkIkeTaOINIV7Q0ZfnkkNgXR2FXDQfAAFFXiYuPUGPbPZpjm?=
 =?us-ascii?Q?Kk2ZqdipculcRcGLhkT5JkYWg/2eRCvTbCfQ3C2GywfP/K0/MzMS5CxGTjy9?=
 =?us-ascii?Q?r7DWNqdwo5gy6ALnJPeyWLOgifEYib3ycRU/nnrqldQQZrLOqnBh3NleJDHy?=
 =?us-ascii?Q?udfCzwYckxtZXjGBUYgXYuBRw/ttJ6PEGJLCWRpJHkQAoIp0x/DFZ+gdMXIQ?=
 =?us-ascii?Q?DdewvE1/AwyBUeLSILMaQhj/DnZciPZfwkgOI1INASVJ+Yav7isXVNrZITc4?=
 =?us-ascii?Q?Z8GtBnJiEpYIvavG8HN5Brk8/J9oA0QyVAQzHtd7JDe4bKlm/9Uj9sqorUtk?=
 =?us-ascii?Q?94W+vI6Kcuzo0BUlofv0teud7cXv8KQFPVi4wz6Nk9vGKGyffoL2XX16ww1V?=
 =?us-ascii?Q?hjpro30hQ13Hm5ZnSykexsAQjIdeIQ2WaAYcUKe13s4itFmfpBUZP8DzQ3U4?=
 =?us-ascii?Q?KgJ89WTn/yHkEJt07cLnEEsAzT+Bk2InaMj4j42VaVsFZKOYY3BT/3FhUhh2?=
 =?us-ascii?Q?sd30ULwn6ZWlpA/UdkJxA4SSNVPzWwm+C4auLxdpk/JfKZb8S6eMODe/LOAB?=
 =?us-ascii?Q?JvmjCcs+mEP4lRsD3HvKz2jRdM3CIbkakYoOBb3bk89VWiE6jW8CpW0Ux9Mi?=
 =?us-ascii?Q?/rNFSDCGcJ5EztH+OrpvTHkS6Sl6KwxX/7V9T1hVj3+ZLbq8t/chZze2qYb9?=
 =?us-ascii?Q?JX5bujuNnHOCjNHa6NlbQX0giSPx70QHbwPlVyI+Gc0e5Ju0CS22yyqGOl1c?=
 =?us-ascii?Q?uKE1185rbrVZYpc3gGMjyhF1Dc2Kbfx+kWo1dyQumvYeRvalOH0Qkw4cok62?=
 =?us-ascii?Q?hIBV1IyY2JaG0pc+hNfDYH0DkGZqcdRahyvpYdc9uCu4CufZBN0MhuNjAhT0?=
 =?us-ascii?Q?Uyz8nCIBWs0Dyn9SNm3Ur/zksPep2fIVsoMfx9MLD8V903gW3ltxcMUhWHZJ?=
 =?us-ascii?Q?t/az+HEAlTXepyKNaE6NlUQmhA0im0Ae?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7518.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R5TbtVZBpJRb+HTsDEGsP3GD5FtYiLdv0NJFptf6rV487Y+6x0BwipMztzgf?=
 =?us-ascii?Q?TQ4eLnMyqdKMTzjefX63Cg3xFJecbz9Dw4pU4y/P0NWrHDuWoVT8TUcg63EF?=
 =?us-ascii?Q?Q8XF4O4ooNlO+rEfQUCXZNP+32JIZN5H3RqusBw5USbgjeOSEYqQJJx9xM0C?=
 =?us-ascii?Q?wamxin4IdtOVDpNbor1WrDJlyVzt9LCXh6V8Kzv0QFLHalRNncFmrv4tNLE4?=
 =?us-ascii?Q?rFKmrc6PDymNdFtgm80wrJr1MvxyXC/GfM6lmdm9X0+LBdsaDS/qhYKTUFMm?=
 =?us-ascii?Q?oQOsstrsJiRIzK5SIbtKAbrB1/ZokrWvJ8c19kNRP2AgCr2kgzNzWQ3a8jX8?=
 =?us-ascii?Q?nQs/CqmBj2gsW2dvliZdZiWaf8eVD3oJLBLZjTyhhYhuy/OTv58OQEPs9Q48?=
 =?us-ascii?Q?V9PiM12guh8Gj/wH6jDu/qjsvEwWpAM4AfylC+Q2nenTyDCdlt7Bom/3ocH0?=
 =?us-ascii?Q?LQhFoxNx5EVUYrNEzPNP1DfqECnNZdT3/d3V5fFQ65UsbMvRRMghAhmYCcyj?=
 =?us-ascii?Q?dBmezCzNDKPhtoDajBWwJgvk9OTYFNowFSAIl5nlvWZ+L+I9A6iUVXSl+MG6?=
 =?us-ascii?Q?P1axO8lbDZrtDG7HkoGO35/Sgy8P70Kc2txm+exVtAPczpQ3I9OOcypCuknP?=
 =?us-ascii?Q?eJiuz0tE0HyKrR4TxV6elDAzGYRM8kUXYo4B+wTDZG+8T7Tyyyocv0ln+7fF?=
 =?us-ascii?Q?YiYgzH71/N0P9Kc08gHWzT/fZcQJPtYDBFD8LMymLBjnufMBvmuRzKyj2eqD?=
 =?us-ascii?Q?5piw75RlMRnSr1Wclrj+b03+DCN5NRolr2jCF9ZW0Yk3nlyFIqsOrxqhBXMX?=
 =?us-ascii?Q?1qcKquQdpNIJlYJc8MbW1LXdaFRxg6yVMi9MMfUYQ1uuaEt9lzihCFv3xRp0?=
 =?us-ascii?Q?kvKGfhfqGXAREOuVTRIyJbO7i+ZTQgSw1FrZzgmVQevCqF9NhGDP+5ZYiLOz?=
 =?us-ascii?Q?6rW4tTsiingGuPVE8ePuFs/1gHx0v2gHWEPVDuHMlzq9Yi2kTl+d3cQqQob9?=
 =?us-ascii?Q?yu2dMRxVCdTD5Wr3glyp9w7QAQtwaec+G/MioFwA2iP994Y9/hfuXTKlktpc?=
 =?us-ascii?Q?I7wckv8cAcjh1QJ7FEkzrP1tZSiLLK3nqYcH93atBdRmjZiFyieivjx6e6IW?=
 =?us-ascii?Q?dWduYBfBBpF7uQHZSlWQ9HbmXbSZuBQZ4AVmJHmN2wdF5SI9X0NBIYitRs09?=
 =?us-ascii?Q?RgMF15T0awSDyVspkNM30ZAQnoHaE1vi/DpyVKrEXo38uSr33JZMLbTpWnBC?=
 =?us-ascii?Q?CtOBUvvRARtntZMVDuYVjtmr/idY6npAkO5GVLd2KElByvMYakkVlQI538yy?=
 =?us-ascii?Q?8jyR3dPY9ubSIFH6r4L2ea9IanHabLnqpDAFlkJzhkb+Ef4c+e2KoBp19KRg?=
 =?us-ascii?Q?taHxxVJJkc0e+fe21nckLaENuJCROsN4b22XbXKemeylE+NlkVAvk3/XF8AC?=
 =?us-ascii?Q?JR2Io6jowTukRDljT/kXriKOrvIDTfcQDMRV+fouW/HMDpsRRUp/xob0XeKE?=
 =?us-ascii?Q?w312tbJqMxSKn1MRoisvps6w5SuW6L0nwIuoc+VBPy1I4pUyOSECnNERWrbT?=
 =?us-ascii?Q?4MvMB4wJMDXsqUewwInoil5PLqc1GrCBeWr8Y95kPZWZJ8LzCNNUficppxXn?=
 =?us-ascii?Q?KA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7518.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428e78f6-2bbc-4291-a948-08dd62ca830d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 07:33:27.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2SWvfqQAlz76SLJRj6aJZrUMR4v6aliLVWdEhbb3v00DeFScxw0HPgOLt+lUYwKVnYejlg+KHCsgGnrIagO+nx+aaQ9V+86+PxpoPjiDbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6183
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Thursday, February 6, 2025 2:30 PM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>
> Cc: netdev@vger.kernel.org; Knitter, Konrad <konrad.knitter@intel.com>; K=
itszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Zhuo, Qiuxu <qiuxu.zhuo@=
intel.com>; Michal Swiatkowski >  <michal.swiatkowski@linux.intel.com>; Sim=
on Horman <horms@kernel.org>; Kees Cook <kees@kernel.org>; Jiri Slaby <jiri=
slaby@kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: health.c: fix compilat=
ion on gcc 7.5
>
> GCC 7 is not as good as GCC 8+ in telling what is a compile-time
> const, and thus could be used for static storage.
> Fortunately keeping strings as const arrays is enough to make old
> gcc happy.
>
> Excerpt from the report:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
>
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer =
element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initial=
ization for 'ice_health_status_lookup[0].solution')
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer=
 element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>                                ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initia=
lization for 'ice_health_status_lookup[0].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer=
 element is not constant
>    "Change or replace the module or cable.", {ice_port_number_label}},
>                                               ^~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initia=
lization for 'ice_health_status_lookup[1].data_label[0]')
> drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer =
element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A98=
9F72@CY8PR11MB7134.namprd11.prod.outlook.com
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: use static const char[] instead of #define - Simon
>     +added RB tag from Michal, but not adding TB tag from Qiuxu
>
> v1:
>  https://lore.kernel.org/netdev/20250205104252.30464-2-przemyslaw.kitszel=
@intel.com
>
> CC: Kees Cook <kees@kernel.org>
> CC: Jiri Slaby <jirislaby@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/devlink/health.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)

