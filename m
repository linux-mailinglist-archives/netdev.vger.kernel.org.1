Return-Path: <netdev+bounces-123323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06896488A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7409281A43
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED81B011C;
	Thu, 29 Aug 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRqQThy0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C21591E8
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942006; cv=fail; b=Lbpab+xnA91m1lWkXnc1pdeS62lVu/FAUDZrmfKkqWSGio6S21p9j3bL0QeT8b20UDm+GXUvCbyO2TrPErU87j8+S5jksG35jOqjFCMaO1WMBv6nrGexbYOgk0EOeGddysPu+41L3VOL3VG8FD+3yrz6T+ArEBCfTLq4jN9EBGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942006; c=relaxed/simple;
	bh=erBSd2hBvdwts9igT1/6Dm7/xVmrZZ7QS7/Ecugm/dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZkSYusqpjx1NsP6cAYjvry94aWHqQ2ILUDWp2ToA3pVUgZvMUeyTP7OgQ2Utf556RlUO7/S8cZsHcP+tPKkLtjYxRNqBcsGGtOCYrTIZTCW15ab7TULVvmnBW8W7QFb/O2wvZdG5JT/DWsRpfWdh7pOKNvjb9FfA1LrhpMX+Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRqQThy0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724942005; x=1756478005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=erBSd2hBvdwts9igT1/6Dm7/xVmrZZ7QS7/Ecugm/dk=;
  b=nRqQThy0CBC5rJSIsxKHRNKEAQYNIlZes+/E7bJbPAitSOFCWDxNRf3O
   Huj7YM84T0QM1qmAy44ww6KzJiWzZSrp4DnoWjMTAXX2lRnZaGLf44aFL
   hPaxuk+S88F2N2TmFFrzt//IJiJw1J7MHhf5qJ6DqEqEoemBVRb3OZYQ4
   EMTOEddRwxOHdfa4WjErB1D5gP8igDepMhp6+f22djbsLGZzPLFYhe/G9
   yGTiUea9MDUwAfFf2d1nyscEGy6ELR//FBVYP0b2LzJnWZld1gL2LkfQf
   A2NKU8XGxEk/GIRhvszMjdVRxZTc+FTOfaDoXrillB+BVz0DUZhdrkKUf
   Q==;
X-CSE-ConnectionGUID: CQXpnPjuRqmldkRJiam7pQ==
X-CSE-MsgGUID: 7vlxB5uoQ8qO3TGM3KhFow==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="13281710"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="13281710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 07:33:24 -0700
X-CSE-ConnectionGUID: lRXYAr1QSXWC+TwNcKbcaw==
X-CSE-MsgGUID: 2kDXnKlAQ9G3nj6HVyez1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68411769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 07:33:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 07:33:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 07:33:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 07:33:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 07:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp8n7kC1ugDYrs6HzQ3wVy1s5sEeOQMR8n9YYN4FCntlLI9DZyq7GLgog4iH/jflyTKEJNU0x8dx6J3kB2UC1/swfOMMwJILVggTwYfubp5jYDxnS2ofCM6ZOUPmC5xWNLIydkAc3OlqfYdiJAou7a0CtiJQSFJMUEu+9EnMN1lyLPkg5aYt+5OVaOvlPRM2EpcuLGcGx8DL/8v0dJEvgOnLgJFbfQidvINdrGgrmDK/ShlOQTPZsy2X0ev2XoYzUP/Ym68n4EpaeAKiZJBjgYzccjGDXEWetmOxw2H8oxMzC0RjL2oZfwBbcgogT1ssOB2qz1ck76kjM6fYRu+XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzeCW0/pq6QswHxzjuG5N/KbfRLw5V9JV8OISbtVvKE=;
 b=GOj0VdlSu+Ykpq1r9slqkCUv00AHQR6KKevAAyEWP4d/yfpnTzYezXI6rgGAK2ojgWxO04iLPkJ7C+UCOiuaISSPD/7R6wAZs98p1qmMnKI8a8KqLanOsx7Lr98kP7hOhZWIt6IvaTykJ1qAYe5l4E5WCOr3aIseCzSiz4gF2AF5mPmFT+ZEEGuIjWftwoAcoeTFmoK5Yn9IAWeKkutOqVymWf0epTWxvKWqTc38s1xvP2zSmVsgWer1xPmvEwconRGu9dZG08rY04V82L2oSBgqQeBFxsaK+7VRHZqEhP1ejMy853R81bLjseC2ToGLp6+WAyNoEYpyzYc+bLGuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH7PR11MB6450.namprd11.prod.outlook.com (2603:10b6:510:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 14:33:19 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 14:33:19 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Jiri
 Pirko" <jiri@resnulli.us>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "willemb@google.com"
	<willemb@google.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Bagnucki, Igor" <igor.bagnucki@intel.com>,
	"joe@perches.com" <joe@perches.com>, Eric Dumazet <edumazet@google.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "apw@canonical.com" <apw@canonical.com>, "NEX SW NCIS OSDT
 ITP Upstreaming" <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 4/6] ice: add Tx hang
 devlink health reporter
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 4/6] ice: add Tx hang
 devlink health reporter
Thread-Index: AQHa889l6cTaE7t4a06xWgqyXFGF6LI+WNpg
Date: Thu, 29 Aug 2024 14:33:19 +0000
Message-ID: <CYYPR11MB8429BA7B2A5169EA992F5BCFBD962@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
 <20240821133714.61417-5-przemyslaw.kitszel@intel.com>
In-Reply-To: <20240821133714.61417-5-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH7PR11MB6450:EE_
x-ms-office365-filtering-correlation-id: cdb1c26f-598c-485b-5ed6-08dcc837871c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nx2xzdkLFqs41BpsitJVjXw/pC5c617S2zrne5IKfMwqWWOhyo4uT/y2/U3m?=
 =?us-ascii?Q?kbXGID5DcouIXKQSAUlPRZ+T1tBPZtBG/2E5CQxpocH7OndYBsaRbOC5uIYy?=
 =?us-ascii?Q?gdF8TmpLZlc4lMC7BTiHdJvWPLv4e0SOZHfWPp768jjHtmqrxypruJHFh1Tq?=
 =?us-ascii?Q?3q/F+ZNJPmXbWOr9L4YV3yMlRgSiwyTOvhiaSxt+oBRS0r8DvV4MXIzec1S5?=
 =?us-ascii?Q?f3gR76DCms+jEl5msk3bLHC3GCHT0R+vZl7b3VSCt3Ya1hBRYLL5ScoP3cyO?=
 =?us-ascii?Q?PfjlysJv6HLDIaP5SsbdQmskKVtAhqBJQztYELWs5YSfdO/QUXFInKbpCLi+?=
 =?us-ascii?Q?dd9H+QdRD1fNmXrLbHEqJ+B5FY6Q8dADm9zMM36JSAcMyWYnccyVy5gc9vVL?=
 =?us-ascii?Q?FXeS3jjL/+aUQ2Vu8wslPkhFlbIxxne4YVTAIiwM9Mjd9RZ5UHwbMy/SSpXi?=
 =?us-ascii?Q?4FhRm4+/qtST4leoS+QkXBbNIC++vFfU2drKBXWVpLH/YIMRPxsCUoW3BBIX?=
 =?us-ascii?Q?RfxGKGK5ht35C6HW7halyE5jyfv284o/mVPGUHvzbJhHjb6RDfBDFoJwurNn?=
 =?us-ascii?Q?KqzzKtxDB0EUk/w6Rgnth42rruk1zrTDndrpeIpToi56Gmv1IoH90+bmNYtE?=
 =?us-ascii?Q?whyq8rkaAFawBeYnsoRDzwv8zjEAT84U6vicMhlDrau/EiurUWo4DeOamsoQ?=
 =?us-ascii?Q?RyOn7Z16/DPY+qTtAOy6jkaxUEN0z7dFKUrQe6u7yNoxhwe9knlcQTah+ARi?=
 =?us-ascii?Q?4ZJ95XrruilWcpD1hnDpK/Dgy50YqA6zz7R+8nkKimh0eWJ744FAotIn5/d/?=
 =?us-ascii?Q?XsaiIdg9lRNbMFa46Hg/816DEx+XkUw4AB+6YyEF5NFjq1AZj+io2xX4VhwK?=
 =?us-ascii?Q?VoaZQBso9LYU+8Ih7mEmpaa8rKxOZCJuBIVE/oHXOEyxSxTt9U4DVgSKnkIX?=
 =?us-ascii?Q?CdbJWF4dFLZaVrQTmuEBadCE4xuCdSUk59BmpFrSE1eIizjXv/qzUOp0VS7b?=
 =?us-ascii?Q?LxotuyPcDkb9xTixYU2jNXlG1wbRr7BSNba+hfKm1tpxvDes7xvVH/gp0YxD?=
 =?us-ascii?Q?/ksWU5ceCOC+uxtpj+26Dt0bvuF2I/+/avKq4o6/vlHXg/aLVR5/dqLDGgxf?=
 =?us-ascii?Q?4gfLkek2rMsCML5gP51by+9MpGGmU4AdPz4eWqcwKvmzWtXCJw6QcjcvZ8IR?=
 =?us-ascii?Q?Wmh8nzRkfZw+PZd1SihiA7Dg5N36rYhPou7RaKDsSw2xU+quKI20Yu/vN0P9?=
 =?us-ascii?Q?HDd9J7XgCRQLZKnsKT5aoyVqVzEJiv1APRSS3t3nqdddGrzXfr124CsjPMMM?=
 =?us-ascii?Q?jyxNfOnC+Mt3YN+zojIz0nVhFLLy7hkfjEKEihO3z52or0Jy22FDBfvkErFK?=
 =?us-ascii?Q?0NJBs7Sn2hMChLJ8mIqM1A3AyYSz/MJOEv3PiRI01a2iDbTwaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2aAb5dns1L9GkdkzqelBr4cXha1BboU8N+1IBLLWrG/WCr5pp0iItohHDEL?=
 =?us-ascii?Q?dVzD+VhCnpYI5SDinSYoupH0cjFwbz1FOS3gIlKoXdkLr4NBYAsigWY4XKiR?=
 =?us-ascii?Q?pi+gS6qUmnsnqls0sGfsx8tRWDt10KWpcv05fFkDVSEwRnhzAqcJPL+PoSoR?=
 =?us-ascii?Q?S4Cw9nLS/SVAPXwFmsWVIZ+E7AB+YNj1MYGEg9r4l5fkveX2pu/puRUOseph?=
 =?us-ascii?Q?nQ+2G9PJPesm5g0a2prDrOhs23KdlOQfnk4PbptAT6MC4QSXfu407xmc0d3c?=
 =?us-ascii?Q?N4BaFG33MMnJTZVbwh2p2Y1CO7xZWYEx/1GW7fmS/KipFXvJ057i4qCGcjbs?=
 =?us-ascii?Q?GIdITgmuJOAnPoEzj+lPWZjuYPhIJJIFMNAlYQ7z9n7j6fVl/xHqd+eDC1rk?=
 =?us-ascii?Q?7qIaKB0f2wp+yW/DcBGIowDVVKTqKMp8nRhAL+inrgjxg/kWlk1vHXE6ag6c?=
 =?us-ascii?Q?cq+qYdGHoHT5I36TVC7SYyFXtID7fbhD/M3vjdgsggcv9VF4/tfGrwmlzM29?=
 =?us-ascii?Q?IYQfiPORsuyADEIPD0SapyU2GKzQnzaMtjcyy0SHDE8jNzCZANQEFdaUG03V?=
 =?us-ascii?Q?Ee4sw7pCCmM4Ppq+JXZCXCJIeLgmG86NfXb4DeW6PF5GqMet5Kus1m+KDddK?=
 =?us-ascii?Q?veZyL49kk2iduunFxLt3e+0VEiiG02WBog2l3p0Aeqqs65jn1e8bW1FZiwdp?=
 =?us-ascii?Q?fN84CbbpZzil1GNpE3ynB0dSkWgdHB0tqyfCx6AFeLGiyvs9IP2M1HHHP6ch?=
 =?us-ascii?Q?ZO3OktYo8yn6cUNMcq5hbOVoRj7CegOaJqiuBMjU6462NYco+CCpcdctR3t2?=
 =?us-ascii?Q?Ral7rHvXvbDZtVwjgqn3JZUDocSwLE5kUR1EYb/Jk8gk1jeUUQXKY/IRe+ti?=
 =?us-ascii?Q?rmxNykcc4+6efn/uhpI7mqyYT+Zq6gP++/1MnbSkh25Sw176j+VWJkjQMMYV?=
 =?us-ascii?Q?Ke3y4XfzCnklQ8Bvers0U8Cs4mt5Zu8PyG3m74s85ARgbSnttxXEwDz7SU18?=
 =?us-ascii?Q?1CK9eDhGkuvD+Vx8INlHlWDNOdkKVWfQeV1Cfciej8smEih3evUrpI8s9RQr?=
 =?us-ascii?Q?p6QuSS5b4tmy64pBTLCuYlgJQtFc+5bxmNpnXFoXd5aOEZPHAazsBP0v6r2Z?=
 =?us-ascii?Q?qxBRKzONDjSpm7UqcID8Dt0TJFclNHcnBPkQq1jrQ3NNZYg7HzhgYiV0LeQx?=
 =?us-ascii?Q?Fu2oBwuTJXsnoIGFMb00NOpyhwTQR78SwRdaVS7zyuTHXRTX0V7ycPOzVTKG?=
 =?us-ascii?Q?6duTFLJeFv/Ph9NqnxyYeMgtKc1p/ocrUmEiSAsOGkFf0R8cF+WitdIxf/Rj?=
 =?us-ascii?Q?zwopDfWiYK9qAWSmepgrRAmIsQJWpAkbFn+r0wjkeT64lIrGycL/gn/pyqC8?=
 =?us-ascii?Q?eHZ2Ivk16USwY1mjs8bIsIOsKJrOdo+Vdft6YNvSnATgmFpTXxdUyDWhPhox?=
 =?us-ascii?Q?Tb0wC1NJ7mTROciblcJ2/UiQyFE0buNjh/ZusMjWfCGGrb+DB9NtaY0/k3Ou?=
 =?us-ascii?Q?YOUCIqCQ+5JOmlO/mi0P4U+twfZWfc8g9pRaN6phBujZ0+HQHSLh/Yv+8AAl?=
 =?us-ascii?Q?40vl35zuQjNkhkrtpUPQ486ZmPyZSp7XhArD0QTht0rvSu5id/s18GRU07tQ?=
 =?us-ascii?Q?hA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb1c26f-598c-485b-5ed6-08dcc837871c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 14:33:19.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfSnNWco5rL7HJbCc0m1gt0CoGlwP/s9PrDE4TDPEj+M+N2/KrTPdZ5rS1lpMtYt2n553o5dVlO3Wg2sS0j04uoehwD06o618hBRWedqoxm6YSYkCdhzvWERRlkJeuCI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6450
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
rzemek Kitszel
> Sent: Wednesday, August 21, 2024 7:07 PM
> To: intel-wired-lan@lists.osuosl.org; Jiri Pirko <jiri@resnulli.us>; Nguy=
en, Anthony L <anthony.l.nguyen@intel.com>
> Cc: lukas.bulwahn@gmail.com; willemb@google.com; Drewek, Wojciech <wojcie=
ch.drewek@intel.com>; dwaipayanray1@gmail.com; netdev@vger.kernel.org; Polc=
hlopek, Mateusz <mateusz.polchlopek@intel.com>; Bagnucki, Igor <igor.bagnuc=
ki@intel.com>; joe@perches.com; Eric Dumazet <edumazet@google.com>; Kitszel=
, Przemyslaw <przemyslaw.kitszel@intel.com>; Jakub Kicinski <kuba@kernel.or=
g>; apw@canonical.com; NEX SW NCIS OSDT ITP Upstreaming <nex.sw.ncis.osdt.i=
tp.upstreaming@intel.com>; akpm@linux-foundation.org; Paolo Abeni <pabeni@r=
edhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 4/6] ice: add Tx hang devli=
nk health reporter
>
> Add Tx hang devlink health reporter, see struct ice_tx_hang_event to see =
what is reported.
>
> Subsequent commits will extend it by more info, for now it dumps descript=
ors with little metadata.
>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   1 +
>  .../intel/ice/devlink/devlink_health.h        |  48 +++++
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  .../intel/ice/devlink/devlink_health.c        | 188 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
>  5 files changed, 252 insertions(+), 5 deletions(-)  create mode 100644 d=
rivers/net/ethernet/intel/ice/devlink/devlink_health.h
>  create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health=
.c
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


