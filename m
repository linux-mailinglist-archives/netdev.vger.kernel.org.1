Return-Path: <netdev+bounces-219474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF1BB41760
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DC93A4924
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A642DC354;
	Wed,  3 Sep 2025 07:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwkAkXlb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28C2D594A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886236; cv=fail; b=H1TcSfhm0tCK2dd9fjjW23YcSk5FaRAkwdZQYMXhk9Gppv2Nzv8L2bTU4N/C6Bt4k7BTyy8L71LnZkUONQV52C/ZACMe/6EE0cht3vaOyrX6fe/QBjVaN7s8NN24FUhiFjay2kGXN96bKmzA5rw2mny7TnL1pqX/8Ng2sC7jIMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886236; c=relaxed/simple;
	bh=ehXjlTNBELuUDM20EGwjROo2tRtP1PFhaNpj3FD5eMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2oTN0lull5c6j5ph7y6C3+ZNG1tFPqKx1+oTldekEDZXZCwukGGkVq5GyNWK5twPWEWryXdDSj6qpUwZFHtNo4bOIpD6LQgS/ox5tfjLM+qjuPAb9hK2EfjRfTNLPrYEz5uBUiXQtsLZNQgkIsqoaFjLGgXCWiLOQfh7vC1+ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwkAkXlb; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756886236; x=1788422236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ehXjlTNBELuUDM20EGwjROo2tRtP1PFhaNpj3FD5eMQ=;
  b=EwkAkXlbogoL0qbNd3Mmg4XY8sqvEQggaP5l9yvFs8/NloKLVxU/3e86
   YkyEdSqqSOSF/0hBC1Q0BFMrwudoGZtlpANSM/3UlFszPlLW9bHEz/fNQ
   5L0MPKyr9K04xy7CnpZr2e7wDhCkl5RNISIg4WgKcZ4LRKdOZzLBtbYGK
   GjpOkyWvzFeOanf8ziAqy1nSBTMZtd0Yv5QLjaSSJkuYkNTa67BRDIu4A
   2vI/OG6ePAdgT32Us2HCN9pLmRhLvYiumlTi7NeKMA5lfOGSTACRMldFW
   CKOvGfjvvQ6keksHmvuKyDLesCXhqY6ZPKF98wGBTg0rBeFxte8045OI0
   Q==;
X-CSE-ConnectionGUID: UXD9eSSbRmiSEz1evF9oFQ==
X-CSE-MsgGUID: ktl0BwyCStCm4wt4Nuwb1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="76632707"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="76632707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:57:15 -0700
X-CSE-ConnectionGUID: ROA5Y9s9QjCEHbw+eXsiEw==
X-CSE-MsgGUID: D2sO/YivQniXLEft1o9upg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171486121"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 00:57:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:57:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 00:57:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 00:57:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDPs4aLBlppKnmfv0hJzytKPM4vdh0xbmDc4+GXkFJEZZPbmk/KXBdsfezCIc9Mj9ttzrSngUq930YMi9QOBDwVkzXMaTAQ5Np9orHHBHyZRomzkoL/BPuGajJsAp69qwDfN/7K6ER5tAAfYJkgNYUMMX5EBH2nnA0mNY+uFERZrMg39Qi8c8tDwQP0l61VEq6p8xni2CWvp0qrZri6Aq9cDlLBR1HR18Y99eBHfAxaJjHTgV4lk6QY4XN6s5hkWIhFCxQIRBTYyLzpTk0jJJA1WuCGi28xQCGWo9qfVBJPc/aYvXTvKHWTWfxP92ghNp2sGPXnjBMCriigLXpwUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IubeMAOQlvvo6932rguK2DKDF+UVd9319PZoLARK2Uk=;
 b=NRkMiHKtjHs9zF8snZrWBK8WCNLKAlwrqPBtnhCM/QV03HzZGMneRLb+mnrdB9XeiNbADLjSqfQCas9KpLI/9T7snmcecDrhOBgEbZ0yn32rGjkDg8mJ9LkAXBDkVCZRoDoaZz8NEDl663SggUflNq+4pAPRX3dTFS1C7Hm0mNd6EOTN6DxH26oWiGV+A03JrzTf8vZvO+mVtw5ULrc+YpzJPN7zA1q/cLgr4sLa/cJDCZqiHvr7+DyvF0yH+wvjfahzgVNIpqpZPlFUPLnGfkNsPPqnGduyvMDpmt3UhYxV95NRYS/Ihwx4+u/YV22VBJNsmVaFDYbiP73VYdJVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 (2603:10b6:518:1::d28) by PH3PPF37A184CA6.namprd11.prod.outlook.com
 (2603:10b6:518:1::d15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Wed, 3 Sep
 2025 07:57:11 +0000
Received: from PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480]) by PH3PPF67C992ECC.namprd11.prod.outlook.com
 ([fe80::8435:3b39:7eee:480%7]) with mapi id 15.20.9052.021; Wed, 3 Sep 2025
 07:57:10 +0000
From: "Singh, PriyaX" <priyax.singh@intel.com>
To: "intel-wired-lan-bounces@osuosl.org" <intel-wired-lan-bounces@osuosl.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kubiak, Michal"
	<michal.kubiak@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 3/3] ice: switch to Page
 Pool
Thread-Index: AQHcCH01M/icgVqGGkGNwBWqS/igJLR/gCxwgAAOZKCAAab74IAACUsg
Date: Wed, 3 Sep 2025 07:57:10 +0000
Message-ID: <PH3PPF67C992ECCA7F11A37572A1EE1ED539101A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-4-michal.kubiak@intel.com>
 <PH0PR11MB50137E847BF9F0BF2FBF127D9606A@PH0PR11MB5013.namprd11.prod.outlook.com>
 <PH3PPF67C992ECC2B85C5436B969773E2759106A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
 <PH3PPF67C992ECC632806C8E123CB24D1489101A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
In-Reply-To: <PH3PPF67C992ECC632806C8E123CB24D1489101A@PH3PPF67C992ECC.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF67C992ECC:EE_|PH3PPF37A184CA6:EE_
x-ms-office365-filtering-correlation-id: 00aabf5f-021d-4f44-8b69-08ddeabf7cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0RXEEEs0OpD+upNwd5z8vP4KgosSoZqbUAUdnlUCjK4aQ+1uBSLXYeMdoAp8?=
 =?us-ascii?Q?BBi9skt3QYERwrAhkHd1HT0cNKzCNtdb+LN6QUr9COczegIwu7BRvYitlffe?=
 =?us-ascii?Q?PJMddVMkE80jRFlzmCN1fIIPGXDTMCEFcnHe8IoCdviCy2kBMflPYUvbuzm7?=
 =?us-ascii?Q?pmPylKjRvQirWhE/PQ4/1QNYCloZyDvfCuSfF6Scsa0DsSC4ygpf4fATUdf4?=
 =?us-ascii?Q?YSaskndwkq4XbK1uKnD+Azmfhg0H0r+rraE2mrz31un1HeuTvo1Qbo6zxvyx?=
 =?us-ascii?Q?rUC8mCoegA2bNbfHYaOe3uFEXL6uoIOQ3MGNcQEco2hHnpyIK4nzq522Qo7b?=
 =?us-ascii?Q?lm1y4lVkAdQ4riE/FbgIzHMQTMSFIpZkgWijHEgyVhTZlpP3S/ksfRR0X4fj?=
 =?us-ascii?Q?x6Uv4TBF6nDOgOk1tMlkimsL1cJG8VtUrASBzEFhFWz6Bli7Dzlg+M20heNY?=
 =?us-ascii?Q?OFBd9uyng733MVBiHxz3RI54tqmCVu2pjGkHw7cdB2FgsfZ7sGqxyOdxmmPO?=
 =?us-ascii?Q?Yol0Dxy8uSode3JMNDUWvQXqcqz08mSzVBR5yPEPWMZpYhQ+s/GlIy4/q7SK?=
 =?us-ascii?Q?MxB1uaEDkBx212s89Byux6Nzcrm47/qCoOfH4uJe+8D2dCblwnD2q6Ab5SEI?=
 =?us-ascii?Q?54OgFVMqOHPVZSJr+HhfdL1riF3bOZFmn92SlKBBPrxgmPenczZf+U/lsEBp?=
 =?us-ascii?Q?AjNWkfGzPddxgENQ+0FPIH/qfgUkjiZ0QkcL+bTJtulox4WFHIowKrz2EHoz?=
 =?us-ascii?Q?AzAOl5GQGYY98KWTqBSVz7lclwSfOwBBc1ZzPM/p6OPOv+s4ByT/PowWZLzw?=
 =?us-ascii?Q?yrMAU3CmGIkfXwbtRbt7d0XY3wkcLzAaVs26F/Wla5IpptW9jpZEYAXEP4oa?=
 =?us-ascii?Q?UP5hNXOv1NQxgpeDjWkoZgOauRnhQk7W+0oepH3503+W3b7eg0AjoSitH75r?=
 =?us-ascii?Q?5y70MDVuiExZy1f5Yi8dk/bsSOJngKyD+6BXioNMpdDc60Hi4aHZDmtN6vpm?=
 =?us-ascii?Q?lYS5BsAG4Y5UzzY02oduVdg7ikfgAlXLGwFeIBXhHj5no55jkIDIoCyCf0qd?=
 =?us-ascii?Q?Im3OjB6e9oJ3iEX8HY4zi+EnHh2zUDv+342h7GA+xClMRd4DHpwqpYm2zAvR?=
 =?us-ascii?Q?ktzzXR9VMWoqkwhVpUDcHv7DSqJI5ddnBBhc7+f8D2N9OItsF8k1nKlI2ZAX?=
 =?us-ascii?Q?AG08myMr6Y61o13roHI0yMaA7Kent/2IgM2bb5TPvKBwVSgGwFVt2jdWR1kH?=
 =?us-ascii?Q?/8JllaPIDPodEt/WlMBIIWcStcM/C7ryEGoVgdbdwvm8O1ZTyVZucaD3U+tg?=
 =?us-ascii?Q?2CqwAlxOu0W6W8l9HkBwuEIchlq2agC/Zp4IkpWaF9hXPo/xuWwQnDmlwXKz?=
 =?us-ascii?Q?gxR+uemDMWcVEsjjnHLm0TzxnWIwIHGSrSNbvQuQm29Y3rfiT2Qf5NCMSS0r?=
 =?us-ascii?Q?nYypPb7Bt8qqKp3uVHhVa7Uy1HF/1sXBwSzJOaj0Pem+xvE8vdL8Eg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF67C992ECC.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nq2kkH8HUTcJV2qsdvYeGdPviPXFa3ShO9WBUO6OGXmRJG8A6MVfP67G8xaG?=
 =?us-ascii?Q?86zqO8dNyTzgb9mzJNSLxNzIaeWaHYrPjeSkqEToRcH+l+UNHm0fNEpDsYqU?=
 =?us-ascii?Q?WZEE3RzTiyyN62hH4+7XeDS1R3QtyoGGFU/jTCDK9X6bztsUBHbGiFYgWjRI?=
 =?us-ascii?Q?gwMBvyY+60IH+7O6GBuWX69wiSNZAyK9c8bvQKmYuXETiYSWQH/W2b1MV6DU?=
 =?us-ascii?Q?mQ6C3XKCOMba7VDuStNAwLHewS+rFA60cec+CANIxiv1vFlyQ9z6S3KJUuLh?=
 =?us-ascii?Q?q9tXEGjiJv2/8W88MQd/ULt0ouyxn4Mp9VJ4mKJuvKOvLXWWG+K2etK0nVqh?=
 =?us-ascii?Q?Y4oCYiA4f47g97zjYB7majeP4cbhpNG/HkFKG3IDpXhPSurX0H+M0Fpc1iQN?=
 =?us-ascii?Q?hInaZy8db0ZsYluJm3i2NYC4LiKp56iHoYtkNy0XifZxtNqI/gqanvI8mV1e?=
 =?us-ascii?Q?qdN+GxrR3agqcP/WEw7onICncmzWBlWwNe++zg/cd/CGtWLp5BfZUoOrtOQC?=
 =?us-ascii?Q?QWDWUOLNY2v592pPK171bbeRx3ZWWG3+ezzDL62ETjDjQzC9yTRl9hMhufmr?=
 =?us-ascii?Q?lBAwnw61cqiaAkf2aFte7wgnPROQC+DTN2cEEEm0xiTw17cIBfLn6ckoYF/x?=
 =?us-ascii?Q?gRW05tEOJ3C9HFTu5rEuBdBBzmm/A4F7wVLoCfzc0B5rO5LGz6MlOiyW4mvd?=
 =?us-ascii?Q?0Hw8176A4zcKzlrOXW6cYtDe3yqa5PPn81s0UuHlKWtv7gaLdKlkcr7f28jQ?=
 =?us-ascii?Q?+PONiGT0Zw2v0bXwJflrhWD/WON1d8Gjvk8eSNFFEEFZLhAFV6PU/Q1dCVym?=
 =?us-ascii?Q?o8aN67dQ8xQSKXsqZT87aZ08BVsV8YHJqfDA1jGbn1eq/tIbbx8tPJFlgnUH?=
 =?us-ascii?Q?R1XHXaNAwc+JX9t+w66QiFsLJYoL++pDsDbUu6jOMF2ddgns7gCdVm26mmYW?=
 =?us-ascii?Q?Drp+O4DVmEjoigFm7RJn3XxO5HxMmZCGsGw6EozPY92UBgRSqydt+0lHQMtw?=
 =?us-ascii?Q?tXecJTneYS37b4MAtHlqwkJPiGlECKcvfppqzYiBmOUN8tXHFH95/MUvzF/q?=
 =?us-ascii?Q?nWCV774FQsHZNKSm/pjkGI8DBYF6lzG/EcBAYEfQDHIFiwYwC4NlyKLtDxN6?=
 =?us-ascii?Q?6xmV2IXS0tadyDg6HuU7Dad5P0KZTOIQ8eUsRjNbdoBX2iXN5Zfn50nJkj1P?=
 =?us-ascii?Q?nSMhorkVd/famI2fF6F3r45xfxxRbAyB/V8VRrLOss+7Gk9se2YYmwpA59s7?=
 =?us-ascii?Q?yCKQTjmVM+df+3lcr15i2ZyUhdkXmnwXS/mZrO34LBQPyiiyHwq3J4cQTgHl?=
 =?us-ascii?Q?fGDrHG+x5+GH0Equt/Zlyh05s5DMHUWhrxRYSQXC7zsMw2BYw93ICx+E6lQF?=
 =?us-ascii?Q?T24us3GiW5tueXPkGD0q6RyDD+Ndy1D7bCGLvwjmR6MBvfuJt6YME9ogKFlp?=
 =?us-ascii?Q?BLY5Inn06004pvoolCU8BUccJunPvumDzRRc5d/f/b7rp0D5DY1Q7OF05DJg?=
 =?us-ascii?Q?gXWn6nryPPs8GVxMtlFwq9Xreo4asLWh0/lIH1ch98V4aNoCjb4RWeyRUjUH?=
 =?us-ascii?Q?e6r5HiABfLghfL903V0U8IuC3WR/h1S+OGy8vjhQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF67C992ECC.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aabf5f-021d-4f44-8b69-08ddeabf7cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:57:10.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhhdYuBly3VxdkrNX5dCRTB2mF5f4Uehz+zRkuHZYubud1LWNZPAeq7LTQILXZaga7sb3Xv/ym/e7uUUFiqEdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37A184CA6
X-OriginatorOrg: intel.com

> This patch completes the transition of the ice driver to use the Page
> Pool and libeth APIs, following the same direction as commit
> 5fa4caff59f2
>  ("iavf: switch to Page Pool"). With the legacy page splitting and
> recycling logic already removed, the driver is now in a clean state to
> adopt the modern memory model.
>
> The Page Pool integration simplifies buffer management by offloading
> DMA mapping and recycling to the core infrastructure. This eliminates
> the need for driver-specific handling of headroom, buffer sizing, and
> page order. The libeth helper is used for CPU-side processing, while
> DMA-for-device is handled by the Page Pool core.
>
> Additionally, this patch extends the conversion to cover XDP support.
> The driver now uses libeth_xdp helpers for Rx buffer processing, and
> optimizes XDP_TX by skipping per-frame DMA mapping. Instead, all
> buffers are mapped as bi-directional up front, leveraging Page Pool's
> lifecycle management. This significantly reduces overhead in
> virtualized environments.
>
> Performance observations:
> - In typical scenarios (netperf, XDP_PASS, XDP_DROP), performance remains
>   on par with the previous implementation.
> - In XDP_TX mode:
>   * With IOMMU enabled, performance improves dramatically - over 5x
>   increase - due to reduced DMA mapping overhead and better memory
> reuse.
>   * With IOMMU disabled, performance remains comparable to the
> previous
>    implementation, with no significant changes observed.
>
> This change is also a step toward a more modular and unified XDP
> implementation across Intel Ethernet drivers, aligning with ongoing
> efforts to consolidate and streamline feature support.
>
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
> drivers/net/ethernet/intel/Kconfig            |   1 +
> drivers/net/ethernet/intel/ice/ice_base.c     |  85 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 +-
> drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
> drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
> drivers/net/ethernet/intel/ice/ice_txrx.c     | 443 +++---------------
> drivers/net/ethernet/intel/ice/ice_txrx.h     |  33 +-
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 ++-
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
> drivers/net/ethernet/intel/ice/ice_xsk.c      |  76 +--
> drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
> 11 files changed, 200 insertions(+), 546 deletions(-)
=20
Tested-by: Priya Singh <priyax.singh@intel.com>

