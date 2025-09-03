Return-Path: <netdev+bounces-219432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36920B414AF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0401BA2772
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D812D73A0;
	Wed,  3 Sep 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2Ty5WZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273C28368A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879691; cv=fail; b=dxOhOePw11P1zvmO+12VIH/kVOAsYzT2ehc97sUGjQa6jnH26MVUWzXb3NTH9oQB+//V/aCe93yTcyp2GuMxPORnW916QlIoHl1QMqz6zzYwo47GAmKU5e4zdRmTrmtcjIePrrz0W9mu4jXcJ6oPbWbTuCwUOiA1uE+fpPWl50k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879691; c=relaxed/simple;
	bh=lPHpiBIrHUcPzz7O0Xzfp3Vz/UYscKufik3KsZ+GRgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcXtgoQDIdWKiTonSrF71PwmiS6/rmrBcI70mfXZVE3JNXMB60kuKP6HaQHfi63esA9OP3TaR9lz5krrST4KPlTOw5DLCJ2PaVML3qlDgy5ulphM4uOR8SQLby0Dv++4Y5czFvZ5eolbOs+ZpaRWU7xo8wkhRtI3/39XBYpZor0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2Ty5WZ9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756879689; x=1788415689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lPHpiBIrHUcPzz7O0Xzfp3Vz/UYscKufik3KsZ+GRgk=;
  b=S2Ty5WZ9Mrh/LTvEWghNYTPdciw3aEj4DSbB9B7Db/+7tDELannsVARZ
   fzBdkF2lExUd022l/G7VHsRpfXt4j4jUmY63+/RwRZNSu2BCqMwgReK+F
   NmbNNEWeAKMa4lShKtkANKYdrF0zJnMB/gx1j0G/KC7Jwicta1XPGZq64
   jdC4C3zOfOZtaH17iVU/HWFXpgSL/4/tQgOS2QpHVDlROtuo8ThFboJsR
   hxFlclx/+LZToYBt3cg8M8nGqctQSsJqm81putuER0/DwiNK1qbLXh3KG
   1MTuHzHCRYBLA34PexVfQmURBSzEqLD109l1FHAaJBNyeJaujgrz3TvmN
   Q==;
X-CSE-ConnectionGUID: MBLPKXXOQR2Xu1qYi8k3ow==
X-CSE-MsgGUID: vrI8Y9T5RJ6hbPbUONbWbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70610802"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70610802"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:08:07 -0700
X-CSE-ConnectionGUID: JazVWK3MSvusjC8A8ZuKAA==
X-CSE-MsgGUID: CL1Qlcn8Ta+M8BWQYMq1Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="172313218"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 23:08:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:08:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 23:08:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.85) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+sciwxp2QkaohBA69swzhRxoofoyjXF0C2mNfK4yBVhzwN94ze0hHKOuzwXa9FdTTCRsBFrQiYpf0goxVqykXWQDtWuEN0vxS7US4byzU3oQL0zqioMrP5oCUO6tJ1ETk8eJchi/280PmUZLtPDzie9hb/0/4UibaYnpQGYmc06nP34gNutGs0Iy2i80nSffgf18LXicBpjQmu7DpA6giJ7C6YN0orbUblTTmUFygXK1vRzdQOUPXYTWsxPhL5mQX/E6OYnZCXrjTv//qdr6aOV0z3kl+9UvQ6qLNFhC02Y7azdyBO8MP9yptBOy2rXJ4Klz+kR3qxHetM4iH7yuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGZTTTae4ac1qWTbPX9/bYu2S7Qv4ReKdJ4qWNVzYi4=;
 b=g6LbIRwXsK2Nj7iX0B0R6dTKH55agYbKpH2r64hL4/NvzE+xBOMJ0VIGOpefR7D2l9u9lew5mwaUbGrIlxKr3T8zdNBEZnSTQSjiPhlE32xoE4mcDeepbSbcThS7mhAJuJSDTKSugHmohvytFqFoAr8MGTTdad7Rs55Pd1S5EJjM1NMMXwSR7rPXQ8Ga1WluiBqQWAxDcOXW9H1vpMpDI7kqOlu/0L+I/rXhn2HC2C/CTJD6XKXp1wstMFrX1OmNIxq/wwu68TJR8x6tsxLS/5ycXUSGy6JbmUVb4ELWGvURnxGsYjYOpbVvX0NRax+AgZvTwMmQiZF4y7YkZP3d4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH2PR11MB8834.namprd11.prod.outlook.com (2603:10b6:610:284::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 06:08:02 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%4]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 06:08:02 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Brahmajit Das <listout@listout.xyz>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2] net: intel: fm10k: Fix parameter idx
 set but not used
Thread-Topic: [Intel-wired-lan] [PATCH v2] net: intel: fm10k: Fix parameter
 idx set but not used
Thread-Index: AQHcHBq3FK4xPYtfpEWHVTltoaj/+7SA+a+A
Date: Wed, 3 Sep 2025 06:08:01 +0000
Message-ID: <IA3PR11MB8986925DD6DBF282C160AADBE501A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <e13abc99-fb35-4bc4-b110-9ddfa8cdb442@linux.dev>
 <20250902072422.603237-1-listout@listout.xyz>
In-Reply-To: <20250902072422.603237-1-listout@listout.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH2PR11MB8834:EE_
x-ms-office365-filtering-correlation-id: d656bdeb-121c-4697-5d36-08ddeab03d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y3x1fZrjPNFPT22PPuWzK9M7ZdlOUoaHPQ/uo9jbqzB/m/NbvVwxlBuFjIaU?=
 =?us-ascii?Q?FI9B081/Pd160AEX0qqghckZ3DFkayl+Tl9dCyySIVgzmLbNh6IcclsJSV3Y?=
 =?us-ascii?Q?RFLv16ds6oqkNoZc/n9N+y/Sbi2NKRC8Q1MLFMoaHDcOiXgjJf1YpGKH4q+d?=
 =?us-ascii?Q?lPUc6qHxmr4jAkzIHEZoTxYX3jta/KfoyNPVQFlwcvp2C72ak7ftQdzUDkww?=
 =?us-ascii?Q?WXvQgZHOLvKnlXp7+ayRfPmHtcNKgdWa5pPrvUdz28sZfMw6cDLy2W4iJxFK?=
 =?us-ascii?Q?CRUvHt6kFVAMJuvDuhH5DPeax4dSZNpmeSXo+3PQWYRK9SGO2d8jYaAE6arm?=
 =?us-ascii?Q?w1aCsRx9sqAIdCxpNFcqCILlScAoeC4he+ZYiuaB4TO6p0/jTVxJSvRKE3HQ?=
 =?us-ascii?Q?V6j9SftYuc5cLDIiYq99RyfJp6VIMR8xTr88a5iKptNldqfqAr6vLLbjG7ai?=
 =?us-ascii?Q?3JHoa52M6sCgXgwXq0CNvvdTa5E0pE+tz61IKG/mAfKCW7+cnBkRdzfHgPic?=
 =?us-ascii?Q?X89/aQLZrlTUVOlpnG6P2gFvHVpK5NJgr099Z1VRmVkyJBC5YVs+NDpeJccS?=
 =?us-ascii?Q?Htow/88+6hXnZmuf2SKJhgnreHOw3hKk1nxtSYprVDYGAGC5pwLfIrPSc9w1?=
 =?us-ascii?Q?KrDlta7CLylABEfDG3dmkzo91KWEx92CZA1XY3EWaqPblbzRI6F+cYi2W2te?=
 =?us-ascii?Q?As19zptiApVmQBZTqP9jw8SU8oBjVHOFoBLS5cdpkVFEJrsbvkE/LGrnOsBx?=
 =?us-ascii?Q?dLR9lMFB01DRt2HglipuA6UR5h0T7spQFF/kchGXd2cQGi+vWfvoI6dBmuCQ?=
 =?us-ascii?Q?QN2JY1iVzHKrP5HnIY8Ki0L9YFdCeZ4SxbWYbI4ZPDGlk5yQ3G0ksXsixzs6?=
 =?us-ascii?Q?voIzrkc8J7/sqt16yIJGM0LO41wITVDZvQ6gUdZbmI8XDGKOOsy6wkTkujqw?=
 =?us-ascii?Q?Hfc7mC/N2qZfQhzNDfL4EzZKdwueunIXcJO/NIn8UwbuGDuzTb+MZh8cukjX?=
 =?us-ascii?Q?hhtqjbqkw3XxO0ELCp1z5Z80YRDtaqzz5WjpTWdZmrD+aq6GtnrHbuTenW0m?=
 =?us-ascii?Q?7FpcJNdzOR2wgULh8ow+ID/6NsrcZZwfwIw/k4awPTM+wr2M40k6Y9e+BMuX?=
 =?us-ascii?Q?pi15iesV+JNcdakBWxKmNNmjVFuunHdBgx8UUCcMKUSnhCZawrzID0adLdMM?=
 =?us-ascii?Q?J52ci2Mjr+GdbDSEBltULyqIbnKfzSLDJuDBFWufVkr5dI1uDfIjZAXhepz4?=
 =?us-ascii?Q?zgQlbByp0a42ApCmOoKTtNtWnh03aMbb2ZadrMFx5j3sofv1K2srrnTp6G59?=
 =?us-ascii?Q?X7XYeA588rppeXsUG5wRJquqz5S6+h8URQ1nwDFFEO+XeqUJZtpDHnM3xm1/?=
 =?us-ascii?Q?FHSmM4BCVWpFHoumlO63lYTs0XrK4SE0H6jKBWhw3GjoU6HoFlSpSCfhQm1r?=
 =?us-ascii?Q?QeaVYzyKs7ghFqCe+jcg4Br/u7Hm9iiiz+1QRXP9ifVaDo7EhSIWWw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L1LmVtD+CgC+g+Zxc4xbZeRICaNPSY++JR+/Wxc/C7bYzKXEdhgKkeTVCVHh?=
 =?us-ascii?Q?gkBI+o7lvc+uT/s27pwibOIS5TdBXE84iHoQid9J1BSJi1BsBfkLIcjnRtKW?=
 =?us-ascii?Q?d/CBCwveto5IeSwtJDRQjIBRMsvkPOKPzLmhOKdN50hIaw636JRVue4UcU5a?=
 =?us-ascii?Q?DmdSFeT2JOzTEJhG83u1w9acNzzDLfiO4J53Lb6dQbzNuAaSE743ClfmqPKc?=
 =?us-ascii?Q?qXx5gAQiJ8hxAb3Et8JeGn/mk3qzPp1jWnu6YA17TkMSbYpiOQeJEoZ7EUEL?=
 =?us-ascii?Q?6w66+HYD0rIRY/jn3++rqdBwlweflEA0ZBwk+taV4Bfym6TkB7wfT3/D883H?=
 =?us-ascii?Q?xiAXv/W1WBrxok+Y7yUmYLDWva8jZpQF5t8AJjywR1UyLWSyTE00zOQ9LQhe?=
 =?us-ascii?Q?py3wpl+xiNl9RsBZP8qX2tMznOcYzbbMZuGfTthdYPtbwe0rRFxyHkTeUyVP?=
 =?us-ascii?Q?13DhDyy5iIrPSkuqutM0DlEuMOTjoTGt7nHUlxieJrNibpqexaXZ6WjcOvoT?=
 =?us-ascii?Q?yLX03Ip/OkM8OApO9yXPzu0Tr9oHtALBwfASLMWL0fH+1mqW/eePnma+IAgH?=
 =?us-ascii?Q?2Hw9hWtQQlK0K5kbmsnhnUysNgeerPExLCha8Ur+Mk1Azv5qs0vDnoxBii2Q?=
 =?us-ascii?Q?oMP0ytDEjRBFmO876jl5/+gur1LxFPq5/gChmHgwFaTaYZxSLkT4OWcCPK8S?=
 =?us-ascii?Q?HGRvaeNGHKlweiwemk25UHjBGEbytgNKZBOf6lEyxpcL8Nv/UZ2s8H22PhfH?=
 =?us-ascii?Q?Y+oeVhZ84/jCek2P+3H3o+swlbMUN4IYvdmOPjozlQfWb06C7XWVw+fUxILG?=
 =?us-ascii?Q?KMhRMc3gndgSBd3zzwe2y8vbJzJKzb9kWxLvTJlzjmCEZAPYREfN9CWhZvs5?=
 =?us-ascii?Q?NvKQRHAiTu727BDL+jSuszYqusKZafIgWVt3Ty6ABlN8jiGvgBuIJw44EoUL?=
 =?us-ascii?Q?wTBakxvdrF1WRQxvz6qjt9nT+5FZwEo3YzdbOScdpO04L4Zl7surjDalhFx6?=
 =?us-ascii?Q?DhfY8sm8iSkOaHUcQis0hkZPq9IwUMgC80NPLhQTB1lBG6WNRI79DTpvvuyh?=
 =?us-ascii?Q?dhLhHjMIfro/w1a51zr8gBex7NYZMQUs5UUTiJ2X6wAm7nQtVtudjJVSgZS1?=
 =?us-ascii?Q?uPPlu5L8M6FMvCsh0afs2ypoeyRosOxpYvt8p+OmiNzSqTM9VACkOJ3A/+2H?=
 =?us-ascii?Q?lfU7rJcB6eFzpy1GJANOxgLw3wC4X8bxp6/aB5hkRNngm1AFraIxLNUeUeSv?=
 =?us-ascii?Q?KN8m3WemxFVUAn+q0rYw2jv8H6/mXkmJXwcPiMuBqM6bX2YP9JrhhGobl+18?=
 =?us-ascii?Q?CNid15AO6BEu206Y1ftV+HjbcRle3tJ20rwuFoES1+eThuLpBHBih0b8z/45?=
 =?us-ascii?Q?gA0YQ15HC56yjodT23Z5IgjPNqAbnTPMj7aMziN+LRJfh6k7Heb6MyYVMJoq?=
 =?us-ascii?Q?6bSAnoEpeM1wpIB3Ef4X8myEA4gZX5WMxATc3/Rr+jFvpl7oflUU/bsVeTIE?=
 =?us-ascii?Q?4fXUtD80vvAnn1I1IZPEgxk5e5CljKEPZnbeRRdy+/KL425bDWQ3AvAC6zuf?=
 =?us-ascii?Q?wvdcU6pZVaDqZnsR1Cqn9D9GMUy7WFv++DBHmD564Vs9m9ubiB9f/0Q1WArF?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d656bdeb-121c-4697-5d36-08ddeab03d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 06:08:02.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6of4MvVynBSJEPixoJ8KKudFUzaWvO0QN3kyhGRVqUTBUBm+SXNaM1GlvXHG9Kg5KRM78TkBnunuehV2mHPLkUWv6OVf36rM6N1tG80/ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8834
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Brahmajit Das
> Sent: Tuesday, September 2, 2025 9:24 AM
> To: vadim.fedorenko@linux.dev
> Cc: andrew+netdev@lunn.ch; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem@davemloft.net; intel-wired-
> lan@lists.osuosl.org; kuba@kernel.org; listout@listout.xyz;
> netdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2] net: intel: fm10k: Fix parameter
> idx set but not used
>=20
> Variable idx is set in the loop, but is never used resulting in dead
> code. Building with GCC 16, which enables
> -Werror=3Dunused-but-set-parameter=3D by default results in build error.
> This patch removes the idx parameter, since all the callers of the
> fm10k_unbind_hw_stats_q as 0 as idx anyways.
>=20
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
> changes in v2:
> 	- Removed the idx parameter, since all callers of
> 	fm10k_unbind_hw_stats_q passes idx as 0 anyways.
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_common.c | 5 ++---
>  drivers/net/ethernet/intel/fm10k/fm10k_common.h | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c     | 2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c     | 2 +-
>  4 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> index f51a63fca513..1f919a50c765 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
> @@ -447,17 +447,16 @@ void fm10k_update_hw_stats_q(struct fm10k_hw
> *hw, struct fm10k_hw_stats_q *q,
>  /**
>   *  fm10k_unbind_hw_stats_q - Unbind the queue counters from their
> queues
>   *  @q: pointer to the ring of hardware statistics queue
> - *  @idx: index pointing to the start of the ring iteration
>   *  @count: number of queues to iterate over
>   *
>   *  Function invalidates the index values for the queues so any
> updates that
>   *  may have happened are ignored and the base for the queue stats is
> reset.
>   **/
The kernel-doc comment still mentions @idx.
Everything else if fine.
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


> -void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32
> count)
> +void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 count)
>  {
>  	u32 i;
>=20
> -	for (i =3D 0; i < count; i++, idx++, q++) {
> +	for (i =3D 0; i < count; i++, q++) {
>  		q->rx_stats_idx =3D 0;
>  		q->tx_stats_idx =3D 0;
>  	}

...

