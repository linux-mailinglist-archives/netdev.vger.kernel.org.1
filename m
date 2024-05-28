Return-Path: <netdev+bounces-98411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242C8D153E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50B41C21A08
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD673164;
	Tue, 28 May 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlotWg/v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C64F201;
	Tue, 28 May 2024 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880915; cv=fail; b=nZtU99WEMCQWaajQ33phpAJ+Si3GGm3tK5rQYa9g3pi7j3YIXykVdX754dRm/uVoJmzvHgfq9JXztGH1bXqVfG/T7ylOEK7IdIAhYWunGXTnuflyf4tXJFlsL9VaFnXDsJhpoP7b0OtWVGWVEYLYXi+2Q9cSd2L8e+lhE7mbxRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880915; c=relaxed/simple;
	bh=7mYJ0lCStVMQ/05jKsDPLkhl2H2jDTVfn2Otsg/PQsY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Grk+n67wx3/oOc0of3Vwnp7NqRM4zC9TOuBNO8DtGFj/b+lvIGCGIPrKv12X6cVLptMAseSugdPQY4MiEg7RGSIBMCCDK0+6L26g+JLaRp32J8eKNJ3SDdlE6Q2nnIXz8IJHbvLYFVVG3K+66YVYJueYsP5tv5HswU4LcHcRRvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlotWg/v; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716880913; x=1748416913;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7mYJ0lCStVMQ/05jKsDPLkhl2H2jDTVfn2Otsg/PQsY=;
  b=DlotWg/vjIO7vSfcxuMJKKxH0fWKLZA9QVpPzCF3r2fUyU+FPrTE9xJV
   NtbxLEz2rDkfQbLHrclt88bPWdkJZLEsPp/aBdNsBeLOj62J21ZXmhChR
   u2lEdQZbC0yUDB2RWhNUvQ2Q2TpcofQcO+ibCqASehZNo+C3zP/jWWtyz
   O2ksINukwis5mvwTVgjgBEFU7CUGYTt+/Cjm0tRtxSsj0MggLcWYxupF6
   sPvyw7yBXDmhYmGyoQdTQO3q0gdexTYnH2SswrQTGeo6v6OxjrojEWgtm
   /xLdkTeUrlrIXcNz5cpHrT9uRc6rBA4yeZoeM4Bi1gXc8TxsDyfczEhBo
   Q==;
X-CSE-ConnectionGUID: eXfJoyLoTdSSdhncGXH/VQ==
X-CSE-MsgGUID: YFO5j3i7QIS0/9SH911Z7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23873316"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="23873316"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 00:21:52 -0700
X-CSE-ConnectionGUID: zhjeNWyLQ0ytZ4JEfMs+EQ==
X-CSE-MsgGUID: KhF1aZiiQnqOGKfI70S/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35574657"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 00:21:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:21:50 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:21:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 00:21:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 00:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2DBnP20N3xY4fprpxEvkFmmjZ7RpNfr6GuShhmKmgypKmlaUmBLuEDZDQ6LKl79pkUtjpDDmERUUFj65gZ9R7rjPgpQ79d8dUzjyf4dYWxOOMqd+AZ+bvoFlAOQ7vuyNArTbYkSAeG8Yg9Ue98ho7wAH1WIDx3pWs+0/U+tb7GHYN/43fjI9BiyJKndz4AUQZej3lBMNtXHGjxUdAgFzDf1/gahDwJwB1V/3I6lqdljswOKqazeHpr9l8Twwp6f2Lzk8BgJK5awTKCJYMnWUYnDHkW4XmuMnOcC2qv6/9xqgWZpnQ2dXEKSIDBsY9HL7NSBb5uFE6D7/km6+dvmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2xGGOx4FSedDXKSi8AGU/iPZsXgbiwh0yRglmqkODM=;
 b=LGsASlcmJXzg7XrKRLtL5Vjslby84cuUgGORDTz17rId3oi0+2wrCs+bKPwkjUzsXC6aeCMNGpRPdHpEDh36/SL+hsKO6y4GGhz0MOw9OhDZP8R0YlnBwogFRMUeziSgOBwfyr+087Cnwwyu9mkFbJShtqDcIN6uRSJunKKEw0afwiqqxv16m0HpaJy16kL0z23kS0sZF97c0Bn0inDcnGFcc6JYwPHR/yCLRGHrATipuLvVxEN/eIa4aNPuR6iiUFQ5gIOFOguCDkv9O7/Fi8fv0Pf1IBrWT67F+z8yT6ovbhmH3CMCcSMlCglK7vmEn0UTF0kZMrxd8jnpxsuvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:21:47 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 07:21:47 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>, "Looi, Hong Aun"
	<hong.aun.looi@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Thread-Index: AQHasM89szK8kSaG/E2tzqRYe3FnP7GsPSPA
Date: Tue, 28 May 2024 07:21:47 +0000
Message-ID: <DM8PR11MB57515E89D10F06644155DA11C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <BY3PR18MB47372537A64134BCE2A4F589C6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751CE01703FFF7CB62DAF9BC1F02@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737DAE0AD482B9660676F6BC6F02@BY3PR18MB4737.namprd18.prod.outlook.com>
 <DM8PR11MB5751118297FB966DA95F55DFC1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
 <BY3PR18MB4737D071F3F747B6ECB15BF2C6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
In-Reply-To: <BY3PR18MB4737D071F3F747B6ECB15BF2C6F12@BY3PR18MB4737.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|IA0PR11MB7816:EE_
x-ms-office365-filtering-correlation-id: 44c47c0a-a79c-42ff-7e45-08dc7ee6d5bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?4R8B0Rh6QYVlptglIvpy0KmEYlll22uULpuT2JxyEOAZ4sUv+E5SS9yVio6X?=
 =?us-ascii?Q?gfbJoslxg7v5+jelDF2H1m6mW9Vqrdg7hG5u9wcUKYujY5G+votZXsXHHus/?=
 =?us-ascii?Q?8CPArlCFHlobxAY429cehZoxQUqyLLUKyjuwkL7ehs4MhA+wji3Qx8FNbNgw?=
 =?us-ascii?Q?BIklp1m2D13LUkCfB4kiorAVfsJjDvR5ckJB+aiAdsvXKmKgBxcJkATZ7E34?=
 =?us-ascii?Q?riOoQId59EU6RiF5yt/iZid/3egwi5c+z1pgOSXpPU03sqm2FOIeEx7W2c9v?=
 =?us-ascii?Q?kqaotKq3Hm/dc4wZzubBX0lRYuecz+haAXDY02ZqJ+2tgl6uvxPEPKShVX0V?=
 =?us-ascii?Q?LkAX1SLf2L1eAzgcBe7vtdr7wXUVyoCyy+6swsKCug3ML4V14aQC35CR+9QR?=
 =?us-ascii?Q?jzutGzhDfpU0M+h80MUbrzscdodHAVMyIg8pjrxw0q2xJbEQhTlMHqJJzLcb?=
 =?us-ascii?Q?J6D1BWllpmcdjBY9AntObcqkSy+Gf2TwK+d0EBxt8F23UgGKqKlzBOepA1Sv?=
 =?us-ascii?Q?tpozA/C93KSbA+F+uJsyOYZ+piTjsXfq0kCfoJVpguugKd2q8U6q5IEJLtTZ?=
 =?us-ascii?Q?BU21p9KKV5fbOvXODaa8m26i3I6kXONVYhmyt4h0guL5PwtjgHFTX/xLRduq?=
 =?us-ascii?Q?CyCAU7ita/4dyPRnbwfHfd+Q8tUwyHn/Zrb6TA2GtqelAhFspz+JB6ANt9+o?=
 =?us-ascii?Q?HmM6EsBfAy75Ylm2VaegDf6xHfEP12qUZljyx1bTjLxOeOJuYa3LHHFvjxjz?=
 =?us-ascii?Q?UsKkwEr/Ir1sWwLuNFg6kKri6GHtiRHR1JFIqPFBhIOI+sM8vSfmEXhIMDQY?=
 =?us-ascii?Q?krrHgG3Y0L8SnN5N5Bo7OLheQxo1b04rtF9uFMJYA8k/fJtjfhOnBcnB7jn3?=
 =?us-ascii?Q?UT2XbGmBlMdE8g6lEftJu/QO5ovmylGP9BslSO+0i5RMdEADbRR+q8KleU7E?=
 =?us-ascii?Q?Ejzx9JsE80JT/6mGQqSjZlyn728UVIo1p271D1UCQ/DElBvr1SmmZmS9dV0e?=
 =?us-ascii?Q?SbLLWnasIW89oy6U3yqqlwI73FcEXWeAt0gOAm/kiMQUt8pbNvgtJV5+IotE?=
 =?us-ascii?Q?y6evXaQ7G4LSmAQVpiQ4rs265MpcmH7NJ65m/wC9L1DGG7C/oZEy4OXoeGD+?=
 =?us-ascii?Q?3YRVImmOmfGBTei4OTHxDJ7Kr7bYQ2jYfHTFwfRAYLagWgkt6ZMUA0Fpjvh8?=
 =?us-ascii?Q?5dSVEhweUF77kncVy+QkMjB4jMTy0PZ+fJclmPOr/pmThRQ0xMJPfWabt6wW?=
 =?us-ascii?Q?Fk0oQvs7jnkAigkVuO9Jg1KBLXpyuXdezqYcSuBsDG/d/xcNDWWW35NirL5y?=
 =?us-ascii?Q?c2E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z/5ubaTpGq5iB9UsgdjrJUP+zW3URAvgX2+8DO4rAdN7VP7DdMEzyO+XASYN?=
 =?us-ascii?Q?SYMBMToeHJhQP5AF4QT+wjnAFm/9DQVrEPBn/vPM1UeAvWrhFzVjZVinwW5q?=
 =?us-ascii?Q?NSWyGTf7tHJ2HZCPIrRvHeiqSCU1vbBIWPUmoUX6pYs5HLE5mi5qUzpPbIRU?=
 =?us-ascii?Q?HNZh3OZOP/nBUM5kUThDq0vyUhN1imxZnqiglD/ITvmteuXLSEm9CyZMfctg?=
 =?us-ascii?Q?iCIEz+iULbrp42mdphBiLimEtwcZomkN1ogVKDMZAHAAkwxJ797A7CreDoRh?=
 =?us-ascii?Q?qmQnMFw5Jryxg7IvQhF3KJL2QWyZJkBTgt/y5emI1ozXzSejo9X+6PTRskMU?=
 =?us-ascii?Q?HZmVqWJ5E1SV0kTdjML9Hbsv1ouw1xKCJL57XrZAL5KbbISn1LHcmqaeCcU4?=
 =?us-ascii?Q?t1iCTV/oeGSQXUFMTDbf6PJZCoKjoCbBdOHqNS1n/TXfdiSoM7KER6TRDoaZ?=
 =?us-ascii?Q?aUDBJ0VtD80NE2dbbi26FfyldtBErLiwCdesAYbwpejb9/a0e9ghj8a5VQun?=
 =?us-ascii?Q?7dtFu6UlQqShgQl1k1ZAnQAt0qTIhiDMMnTFqpjZfBZpJKBE+iNkzhuDOUjO?=
 =?us-ascii?Q?SoLF1OjtPSfm+KjC49nNZDxmDLcbGSX43eeCB79FIXywaj8nkuu6RcCT/EOk?=
 =?us-ascii?Q?1RjGpew/wf7dv4jhirHcAWGpWYu5Lfe/FI4qwk5JTkNnwPoo+qKoxbM8G7Gn?=
 =?us-ascii?Q?B3WMSbd/VRSlKEfME8Xw15pbcQuSKxJmOywAzBKtNXL0gtTtvBFWnAWyyPnY?=
 =?us-ascii?Q?79aRxrsOmZsEnUWoHru4iYQ87y0YF+jNRaUBpaMZq2R+wdogby9wj+ZBTYMx?=
 =?us-ascii?Q?CqOD6ORrSlFuO9Jsp9OVl2/Fe6WfIrpyMouTkf/2FgbBi3dKpunfOh8bIIu3?=
 =?us-ascii?Q?1L92dJAt+RK5Ci/uOsSG6LdP7zp/bfRKblR7U7vkEDQs+4KUrOUK6sHErWRV?=
 =?us-ascii?Q?nuEe1nErZAaUpeFXSfQL+8/rYZKsBaZbQRG6WSDWkhvrxJYpvr/a8xAK5jUc?=
 =?us-ascii?Q?GrueR36PjTu8uXH+TmCBno3ZFq3P5x5QPB5EuU30K9UB9rr5ayvOWwCvnHW8?=
 =?us-ascii?Q?MIod3+VTn71Wdh/6BkCGdDJuz6k0cupL/nKjyra2bTIdfghRk/YPLGCT3G7h?=
 =?us-ascii?Q?eixtArraeTImf9j7x5sYs/ZAoe3ltw5kD4YbNd4fK9QwRmJrKxeaLzKWNwze?=
 =?us-ascii?Q?PzvVo6pc5+lUMIi2VWB9BK9hQ42TGKWV1glSpXUxbDyBwKXHh+ZsAzXKHdx2?=
 =?us-ascii?Q?VgAkWNw+qSuc95x7Igb8bRyoLJrgX+PoQSOcf8/1/BF6npR5kl3z8M1HLu0/?=
 =?us-ascii?Q?1Bsp3961DvBNrcSz3rcxmVvJFfL985KZsD3wePetz1+heQAm8AgnrsHlYN3L?=
 =?us-ascii?Q?cpFZr8kvyZ9v3NzP3sDpnilKahp+ribqjGMnkOvYWC0okx4jKHtuxdno894S?=
 =?us-ascii?Q?iIlsGOaHKoS110OamKHVxdMzfEUoMhcP1y6fQOmF2DqPa0VwhEpQGIXebxqX?=
 =?us-ascii?Q?mf6Gsb4Pxp7xjRsNThYw2ZkOpANLQR0HCmYORybUwUgK7C+3Eu0psy3Sg8gi?=
 =?us-ascii?Q?aB1UnZ07noZ8650U9WxBi243+d9M5ToXiQmjadvh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c47c0a-a79c-42ff-7e45-08dc7ee6d5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 07:21:47.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgjwRK2gNoqx2oacu0azwtnTnygD5BXw//q1AzwQnekQTLKs98cotTxy2hBrfIRZGX3k+884VdOHXv661N5Pfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Sent: Tuesday, May 28, 2024 3:18 PM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Ang,
> Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> <ilpo.jarvinen@linux.intel.com>
> Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
> stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
>=20
>=20
>=20
> > -----Original Message-----
> > From: Ng, Boon Khai <boon.khai.ng@intel.com>
> > Sent: Tuesday, May 28, 2024 7:37 AM
> > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre Torgue
> > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>;
> > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > linux- arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > Ang, Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> > <rohan.g.thomas@intel.com>; Looi, Hong Aun <hong.aun.looi@intel.com>;
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > <ilpo.jarvinen@linux.intel.com>
> > Subject: RE:  [Enable Designware XGMAC VLAN Stripping Feature
> > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > Stripping
> >
> > > -----Original Message-----
> > > From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> > > Sent: Monday, May 27, 2024 11:36 PM
> > > To: Ng, Boon Khai <boon.khai.ng@intel.com>; Alexandre Torgue
> > > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni
> > > <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>;
> > > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > > Ang, Tien Sung <tien.sung.ang@intel.com>; G Thomas, Rohan
> > > <rohan.g.thomas@intel.com>; Looi, Hong Aun
> > > <hong.aun.looi@intel.com>; Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > > <ilpo.jarvinen@linux.intel.com>
> > > Subject: RE: [EXTERNAL] [Enable Designware XGMAC VLAN Stripping
> > > Feature
> > > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN
> > > Stripping
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Ng, Boon Khai <boon.khai.ng@intel.com>
> > > > Sent: Monday, May 27, 2024 6:58 PM
> > > > To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Alexandre
> Torgue
> > > > <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>;
> > > > David S . Miller <davem@davemloft.net>; Eric Dumazet
> > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > > > Abeni <pabeni@redhat.com>; Maxime Coquelin
> > > <mcoquelin.stm32@gmail.com>;
> > > > netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com;
> > > > linux- arm-kernel@lists.infradead.org;
> > > > linux-kernel@vger.kernel.org; Ang, Tien Sung
> > > > <tien.sung.ang@intel.com>; G Thomas, Rohan
> > > > <rohan.g.thomas@intel.com>; Looi, Hong Aun
> > > > <hong.aun.looi@intel.com>; Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com>; Ilpo Jarvinen
> > > > <ilpo.jarvinen@linux.intel.com>
> > > > Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature
> > > > v2 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated
> VLAN
> > > > Stripping
> > > >
> > > ..........
> > >
> > > > > > 1/1] net: stmmac: dwxgmac2: Add support for HW-accelerated
> > > > > > VLAN Stripping
> > > > > >
> > > > >
> > > > > New features should be submitted against 'net-next' instead of 'n=
et'.
> > > >
> > > > Hi Sunil, I was cloning the repo from net-next, but how to choose
> > > > the destination as 'net-next'?
> > >
> > > While creating patch you can add appropriate prefix .. like below
> > > git
> > > format- patch --subject-prefix=3D"net-next PATCH"
> > > git format-patch --subject-prefix=3D"net PATCH"
> > >
> >
> > Okay will update that in the next version.
> >
> > > >
> > > > > Also 'net-next' is currently closed.
> > > >
> > > > I see, may I know when the next opening period is? Thanks
> > >
> > > Please track
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > 3A__patchwork.hopto.o
> > > rg_net-
> >
> 2Dnext.html&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Dq3VKxXQKiboRw_
> > F
> > >
> >
> 01ggTzHuhwawxR1P9_tMCN2FODU4&m=3Da48jwcbUStFRUDMUfXcfGEXhkW
> > 3Pe9T0oNLv7B3
> > > myIrV1geS5aBPZyougPLQZ3vy&s=3DoO5Em8PF8w6U6a1xROdgg-
> > C0TRXsRmdFWku-FZQpH1
> > > E&e=3D
> >
> > Checked the link it is just a photo saying "come in we're open" is
> > that mean the net-next is currently open now?
> >
> >
> >
> Yes, it's open now.

Hi Sunil, thanks for confirming, should I straight away submit another chan=
ge,
with the correct subject prefix on "net-next"? Or I should wait for others =
to
comments, and fix them all in v3?

