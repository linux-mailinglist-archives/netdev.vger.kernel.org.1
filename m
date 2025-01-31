Return-Path: <netdev+bounces-161784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128FA23F50
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023181889F5D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13891C1F13;
	Fri, 31 Jan 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgDQRm4V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADBEAC6
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738335453; cv=fail; b=tjRu/pigKfi/Xu68aBwm5P3SticJd0JfasNeeIiRdSPOJYPc/PL0ZQOHwIJVksoPyAQWVcg9QFbQcN48R7gY7Kku2B7qao3KUAAY87ptn6JX9MSK1rOI34ogll99eH/UM20Atpd5myPbAauNuXSDxILGkyFKYJ+VYOhI37ajO2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738335453; c=relaxed/simple;
	bh=SjTJ9aHo/MOJO4LOmUyM6d3xh/e8StONBI5HfIuO6hQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZRBpOCUSIPpopx4+fQO4MMFLRlZQata6hK5CcbQlmMNqFm3JbVxQ1Vx4P3AE35Jf1Ol+IP9VKik4ztJxq7vSTDYm843lNjVP8SiU6h7kJmaMdqBTZ98Ig0HCIpoxREm7zS2E9NzUpx7KOtVfemxqzUGDOKrnNeHhLG2/viMCPcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgDQRm4V; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738335452; x=1769871452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SjTJ9aHo/MOJO4LOmUyM6d3xh/e8StONBI5HfIuO6hQ=;
  b=hgDQRm4V86B7icpIye0AtuERmzFM/gZPlA5bTqrsAUvg3X4/lHYQgo+N
   icbDhjSQ9MXttXPenkD9uIc0EzztHmr9sQcwBpqanxYTflv+m5b6qDIXv
   xY02+/WpHYMaXhIy/rwgq25NQj9nXIumYVDgl4KucWeJNMDIwlxSynGBH
   UtfmUWylDOSTnTt7D066seP0rOt++B3MHwyj2YSBh3r/dUeOPNH08WAEU
   s81ygWBbcJJbvcInEpqJ75jM607sdTJKx2rAmDvwDdIr4UIWlzj3DHHbS
   OGU6ak8MS5lVZJ6U8YeAm5n4Vwi2fX9l2wgylk0Hd/0w3jE7SuhqSZ9un
   g==;
X-CSE-ConnectionGUID: EFBH8vbaQJmI3OAQ9laZ8Q==
X-CSE-MsgGUID: XE+ynfrXQlylQKlnBrGlCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="42653018"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="42653018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 06:57:31 -0800
X-CSE-ConnectionGUID: OhRqITlyR2CFL4MtFoxy8A==
X-CSE-MsgGUID: MDzeBI3eR6GDECyafzpVPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="109425956"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 06:57:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 06:57:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 06:57:30 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 06:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMmgOBoC5DjWEtFiIPxVRLQc8xYdPR1eet5FqRDWOC5H28PVPWkrIokqhToCJ1cI4KfXwE1I0qyX9Ux8rA3CBoWYOGRjeJsB+znSt89i2My9yqlsQK6paXyGWV5xEE+1ALvNiMtloYDn5Fo1oUqZ+yjjFxCWvNEprGdINeiFUh/ikkqwIlyMTC0Hku/EYEQ6puvJ6vLazZqGxJqGhwd6XtFt9IOGzdnBzdQNgIVs2sOIwtTujVAnGcOEgV6Dvj51yAg/c1vy2jjOz27qnn8NqVK70IUgLsU5D5a6RLHrrMkG/n8HCtkaRBAFb+3uGBF8HJiuOaJvQr1zWQ2mSRPnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdOu1CWhkxkuSm+C1q4WS0NrQZe8roIl4qjgjKBuRHQ=;
 b=lI6BcukxmlQcldl2g6gn16/wk5Ihs9yiPfIwd9bO2ciomZjBaZ+R5G8+xWljruJi2vBZeDjrop/KBylDPs8Cs1ZA+QVENmYjaQn74LrjWcdMANYQcttcRDokJgcVweAVuSmP4utV8gGCGLN1qzvm5amtNrzAQ0QCEz0XTb5sSolXXtIKq43vghgo26NI9QjaQ+fvW75AENVHcj1oo356zWkajD+vc8LZcsw7iAX1bC1sbk4Q9LYnih9bkkvtKdXljaEVSVIZSX/QhMgOvKNnjXkx9e9vCEvDBOzeK48YN/lbD813AaIlSmtRD5XNC0Wcb095QrRzKP6BQUK7QTtH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 14:57:22 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::ec3c:2931:b0e8:c5b5%4]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 14:57:21 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Topic: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Thread-Index: AQHbcnzIjUJuMNncQ0eitKAUk2d4urMuHwuAgAF3r7CAACVAAIABPoZA
Date: Fri, 31 Jan 2025 14:57:21 +0000
Message-ID: <IA1PR11MB62895A8DCF184E77462FC59989E82@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
 <fa054892-b501-4e98-a8a5-6fc9acc68be5@lunn.ch>
 <IA1PR11MB628928A8735D0B5BDBEBB05489E92@IA1PR11MB6289.namprd11.prod.outlook.com>
 <6f9865c7-830a-4f4d-949a-ea073ead994f@lunn.ch>
In-Reply-To: <6f9865c7-830a-4f4d-949a-ea073ead994f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|PH7PR11MB5958:EE_
x-ms-office365-filtering-correlation-id: c4549bcd-a31f-415c-4ab5-08dd420790cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kBccTnvsP8zdSU5CnXP24HPv+LDUf8rBe6SUmFAuRiCEe3zgExtexDx12FAd?=
 =?us-ascii?Q?Ec7wSaAO68CPPlxaUWWsv/lYB+E4Imt2AzOUYtyJ2L5uien5c8oIWExQlpyr?=
 =?us-ascii?Q?5sRTYHiIHpv3Vn0WKdVXrhvRgCyLZpV0ljIwKBICAOIjOAfeZg3zbFCzucfg?=
 =?us-ascii?Q?RFGKFyEuzLhi3DdXVxtNhvM09Ah3+864HPtmJxO7y1Ky8Gb00aIaJ1buK3Ck?=
 =?us-ascii?Q?wPhVmZSDZLWZLVQpb9YpyulXeG/yDAJmeoGaBXBc1Z+FyJ+kPwkhe6Bz5WIv?=
 =?us-ascii?Q?IbdWz/b8ytmN0Yy8jG96q7nkhod3MnX6zfoaMQzeL78tmhDfFH4NNqNRyWbM?=
 =?us-ascii?Q?bUuliAtieUcnTDTh1LRXhSROGomx+e3CqBcpfAIFf1tDWt3/GINDE+/+CNtc?=
 =?us-ascii?Q?/pY3CnORT/oo+0RJC1AQK6fDeGYZzUHhcyZAB+E78DImCIBkzXBAH3N7UVCj?=
 =?us-ascii?Q?pvXPZuQj3r0FD68KkrtZSIaXsWFMO5wsHPDx8x2v/Di9O3zq2Cum7WKtUA8F?=
 =?us-ascii?Q?0jxJhRRCO2Sdu5HcgkPxZ5LZZjc0t9j4ko80slkB8eDN7af/2Otl2edglShC?=
 =?us-ascii?Q?vPwLvxusg+xgnUHd7K2E3av0BrFIYG83o45/AVqdQI+PGx7tXo9WDa5Zbm7v?=
 =?us-ascii?Q?yEGcK7ufrODAZeL/457vuM6n99ghhwgwxJY4FGpe+a/MwxVjdcCdEbTXCfA3?=
 =?us-ascii?Q?2cHQzuQXonwOktx0xNpAIYca3Tinx5j+6qofBgUgaEVO5rDKTRvFsrnxU5Z9?=
 =?us-ascii?Q?k6IlhGHL2VWLDTk9pmXQl/hRuiYfUze+zK2e5T8nNrLYyKFdKl7wcl2/EvLX?=
 =?us-ascii?Q?heXGjmhMs3A24Vlg7bQy2bN3Uve2GX4uGDpc1HsNfzRBbmH492AntNkYwsIj?=
 =?us-ascii?Q?4WkgURI9oZb0O7xGU/jvTKXnSQTUdQWWZo1QBRyyQiGseDOcB2vBj3Ts9rKn?=
 =?us-ascii?Q?yF/V6IeHnV4QSvt1S+uW4vjTfFe8kiGMLyUwL3W42Wh1YXu51NwsbGPoDtcz?=
 =?us-ascii?Q?OZP72RktPzs1V18Mjo+2z+fsRE3xeRDNnoy+Yl5TQinAxtFuZWvovcZbStlG?=
 =?us-ascii?Q?6JZVYb7g9UWELMRgQU6ADDHZsZ6BA2lxTHt9J5lSAAwA24RxfvnQ0q68serw?=
 =?us-ascii?Q?59otXPJfmUf+H7tabiEjlYKtDdLTJGx7Lys+N0b+adGFitzYMO9cIoXEiFyx?=
 =?us-ascii?Q?RQevF/Okgw2oUhVJHDW//k2dlgNAQqfBWUV/K7Il+DfNPu8CR9ALu4tLcOiQ?=
 =?us-ascii?Q?AbPG3NauUnZK82tNyGsAYld2tMcAf17vCDGyzBW/+KlrWidx1GD+0SfRPFWR?=
 =?us-ascii?Q?z6jFS3sgFeDE234a4ofzDTEZUdVXghsn7EAGjCGiLzTUGS2KPZ3+Ot19O0in?=
 =?us-ascii?Q?o+YykCb4tTBO1fFBgUcPXE2CIlEBYn4issHMP+4Ot3Oa05T8yXWArv0uSFzo?=
 =?us-ascii?Q?olGORy6urmquOjsvdhefIDae1igf49zJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kWNJ17UwViouZUXVr3rhqafZRMXHdXVn10TTdXfcGqfLljiiXgof1JH7IB5a?=
 =?us-ascii?Q?lY/Tl93aBWyJmQVZsds5HZtb42Cn+HliI8QFjXZhtKriG+oGL7S6nNk6/jxi?=
 =?us-ascii?Q?+DOUiqFCuJ+RPgN9RVLhbf/m1rXzzUuCI5Q99i0VUZzSTgAtrgC7YHmQIb9C?=
 =?us-ascii?Q?PHZvSLbNO8qdF+SHbDm5FWzaTdS+5PJw4IarLnlwTDmHWWQY2Ms7MherQpDO?=
 =?us-ascii?Q?nAcvWdvCX1gzDKv7LwfsUP9niCQj87rJUpUwKeifjMC7Ytsm1lx4StWqvOO5?=
 =?us-ascii?Q?XCJYAvlrSlKn/kd2WO/tOum9+c4UwKeEEBuMLZUVaOrHkHdPIdAfpNMnJNP+?=
 =?us-ascii?Q?W/vUxhob9x7aVTluO2fMLVt+u1p6xMKe51fbAWkf9MHb3cBKsXqSr6bx46hN?=
 =?us-ascii?Q?vTSLJEPR7P7gikp2KybmAl7/FuftxwqwdgN7lblQjrayKZVjCYKAqJ9vX5b2?=
 =?us-ascii?Q?G0lfzAw3rKNXEN1LkK2aEsnQm3r5FBeAUTsk+A2NG8oZBDGQEbvqq/afvefe?=
 =?us-ascii?Q?kKQWM5gn/2U5nqUn/5qLN/7OxYUUVV0XpAaUhL/ij9WeACSGRTLPSCEEYHME?=
 =?us-ascii?Q?RboKf7wNkorcooTnaVFX9WV8q4bzqWS48x6Ph4Q6lPGakd1jdxlPjFSWyj49?=
 =?us-ascii?Q?kMTfYl9sZRaDe4LYaxM8KzO097D0VmxEQvXWwABdsiZaQLMY1+w4XAopftj3?=
 =?us-ascii?Q?QH1GBzU45gkvK0BLWTxF5obo4tP6wXHO2bFijSu9WXBT+qc04SvUuKkJSuCc?=
 =?us-ascii?Q?qQ3VHsUtqyUPqwUUJR4MYU060kqnI9f/gjktMY1FmSiWueSFxwWX47ZKlsza?=
 =?us-ascii?Q?mR+OtolLxeHDzrILP7QVnJUC1z2tiND2qc04rxZSQFiRLOkcHr3b7PBrVqM5?=
 =?us-ascii?Q?z7WRnDQCT0A6fglGp2l2LzPNVP7R3sHD3OlwUGfO1TEnDl9neuwb+NjSRyPM?=
 =?us-ascii?Q?zS6um3t0Md6un1VJnmubZ5jJKt8+9ucdWYtQQpK1sBFHJxPG1CdufEOaWu9B?=
 =?us-ascii?Q?TYuwNld7xLpXiHRZuftjzFQg7eDQIBS1rJiz7R1aIhxaEYxH6nt9j6TsQOM4?=
 =?us-ascii?Q?TwI6N6gqzSCgyUr94fnpzAZtSwtZHgWLLOM9ta+jrQsNd/CjascAdZHhByTG?=
 =?us-ascii?Q?JPLW1jmBuiVQRMwok8DZoz8frsrn0wNfzUTPmmgN1oTht7FRSVppMX00z8Px?=
 =?us-ascii?Q?d+gNHcso/DSabeTC92teju7y1sp21sfbNy3lqQaXKwFGmuf+OPDDzkXOP1LW?=
 =?us-ascii?Q?WT2hwgrNoIIGsLbmHqUT0+tqTETGP4dJCZd5G8J2/sjZVk+wctpAlkGycgbb?=
 =?us-ascii?Q?4LRwRgkW3ph50BIDgOVASQz2yDTq0DjMEY3uWJvXhd0YnbN3QbVca42jquHz?=
 =?us-ascii?Q?tjdA3asEPY56WREqCZGwmdoy6imRCCYSg5f+MasKX9nqA3pkKqVo0GoFm38j?=
 =?us-ascii?Q?nXZ7ezCEDaznFAXPLw5xQHU+h7Th3oEgDlnPNSgycbRrawgg7OZVMmavpRHy?=
 =?us-ascii?Q?9zPMyK9WMVAy0/23YnX/ssoEVDzgae8rMCzWMtA8HEe2P03U1ouCLQFN909A?=
 =?us-ascii?Q?SX2dKhYWqeninPMrrab2BMhXzC8MQFA3WJ+FSTXv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4549bcd-a31f-415c-4ab5-08dd420790cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 14:57:21.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQXkXfgMKCo3WLmhSpeno+fFRaER3u0QzDSfmqQLqyaPnMaffqG01IJAkeuo30sCM8j/Iu7rUDIVOgNmeUyjIlkK2ECkhYvO3hdQ2qYjcRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5958
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, January 30, 2025 2:52 PM
> To: Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Cc: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>; hkallweit1@gmail.com; =
linux@armlinux.org.uk; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org
> Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct=
()
>=20
> On Thu, Jan 30, 2025 at 07:10:49PM +0000, Joshi, Sreedevi wrote:
> >
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Wednesday, January 29, 2025 2:14 PM
> > > To: sreedevi.joshi <joshisre@ecsmtp.an.intel.com>
> > > Cc: hkallweit1@gmail.com; linux@armlinux.org.uk; edumazet@google.com;=
 kuba@kernel.org; pabeni@redhat.com;
> > > netdev@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>
> > > Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_di=
rect()
> > >
> > > On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> > > > From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> > > >
> > > > When attaching a fixed phy to devices like veth
> > >
> > > Humm. Zoom out. What is the big picture? Why would a veth need a PHY?
> > >
> > > 	Andrew
> > []
> > This issue was encountered when working on a POC to demo the mii_timest=
amper timestamp
> > callback hooks mechanism. We are using veth pairs as we don't have the =
HW yet. In this demo,
> > we connect a fixed PHY to veth and attach mii_timestamper hooks that wa=
y. However, as veth device
> > (like any other virtual interfaces) does not have a parent, it causes K=
ernel Oops and on our system
> > it needs a reboot to recover the system. With this check in place,
> > we could connect fixed PHY and mii_timestamper hooks successfully. I un=
derstand
> > it is not a common practice to attach a PHY to a virtual interface. How=
ever, having a check for NULL
> > before accessing the member will be good to avoid issues.
>=20
> Well, there is a flip side to this. You are doing something which does
> not make sense. Getting an Opps is a good indication you are doing
> something you should not. And the Opps makes it easy to
> debug. Silently ignoring the problem makes it a lot harder to find.
>=20
Ok. makes sense.

> Is there a legitimate use case for a physical network device without a
> parent device? It looks like phy_attach_direct() has been referencing
> the parent since December 2016, so given its history i'm not sure
> there is a legitimate use case.
>=20
> I assume when you get real hardware you will have both a parent and a
> PHY?
>=20
> 	Andrew

Yes. This solution is a POC and with real HW we will attach hooks on an int=
erface
that has real PHY.

Thank you for taking time to review the patch and for providing feedback!

Sreedevi

