Return-Path: <netdev+bounces-281737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF3WEBJ68GnyTwEAu9opvQ
	(envelope-from <netdev+bounces-281737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:12:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B71481063
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF8D2303E18A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E5C3DBD55;
	Tue, 28 Apr 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dah2IAxS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B193E3148;
	Tue, 28 Apr 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366445; cv=fail; b=e4l8+fgFAnphFwkmcgvl1tmPY4dBc0ijgA3njoBuuQRna4B6YMXQKJz2kUgLuwHCLKba7X2HCt411c6xAKYIP7/F40HnfqtdH5mftGhyEWHp+oO1dGGAxcISojYW0QanJmJF9jvNfLl8FyQCh8oNa75FJxH1jpzoEM1l9zKkLr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366445; c=relaxed/simple;
	bh=SZXX/ImguTg6GgqgT5teV0T+u9V1VtGxutpW+fwgi6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ap7W8qEKHVhtWkmVN41eMb01oJCQmXIebRhF8JQIRhTDnmEHtBJkdqQ/Hc8HDQVTU+ryxhsUJXSZwnd0I1yq51gKfAK1POU5K1AyBdo4IRqxfwzOfRMOJ+ygscZiauw9Lhw4M8B748wxDwc2S5ClzsFY20nqwGZtadfBWeozcQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dah2IAxS; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777366439; x=1808902439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SZXX/ImguTg6GgqgT5teV0T+u9V1VtGxutpW+fwgi6I=;
  b=Dah2IAxSM2SBV3d7P9N8BV2KNy05NYbCj3is6f1KzZ/aP8iTPz4JsUWZ
   Pvqy0JdjIm8YmtxuOxqskocwYoU/JbAhS7U0PZe+rsC2srdrgb+yi5cUJ
   kPzu1C3Z6YZMlwOzv4pjqU3FqN9dX5oeQXvwmA+vDn5X14FgM2LJ0vxJO
   Kyadn9VGiFnSg/6dmNVw2SnqtdXzIlrXirAaQc0RvKmglaLTSkINxrAQg
   +fyUjtpQFgTpY/impmMr5JZkG7GOiUYZxm2t9zDLds7TfPCxGagiMFqIF
   nIaBXENM3NWhG9v/eeZFuduLQ7pBVBhH4AuNJ976RK2oaDTd0yDJlJknL
   g==;
X-CSE-ConnectionGUID: W2cx7AxDRWy5djJlcQf4cQ==
X-CSE-MsgGUID: BLrVe2joR5qf5j0dhT8S6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89358208"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89358208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:53:58 -0700
X-CSE-ConnectionGUID: FCQZSLfFQye2qOhCjXs53w==
X-CSE-MsgGUID: +He1N9O3QteXEVaEwAoyPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229540028"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:53:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:53:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 01:53:57 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 01:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELp0ZW8RdWdy1KaKhLK/LrbTjtuppvfCPTPusqYedbr2ooUe6wicDBm0K4sppwtQsx3MWsHDbjyzDDLXAY0FeUWC/805uvogt7Dha/hpzVlcNPFZeKy+ELcTH+471ly15NqpET5qtYru2RAZ/9Iqno2hpd67VxvWXkhzSfmRszqrrBEkNg2r15tAsxNzUT2Vn0N4ejpLe055mAMhw0D1B6tVEeHL8h/94DZ1VpUMQY2cCM1J5aUasRPmHj6vGaVOM0YoAAxrjvs7FiyjpngEbiMhRoKTaaFQeG4ZfYrAtrMxe2my8IP9fsuIwOcRXWs3kVeFxxa1XeaOi6jMyCNKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWylkI5zzkghC0JRT+AI2SsUulQJqnPOi8aa81ejw9Q=;
 b=Vr6FuRq9SU0K6ezOOSDuYiD3KgcmBO283nztsPyDwJEdpnlIWak4sVRSkxIed7nowSOm4pGuCc8V/3v5yp9kX4Hnr9uU7lVdtwiQ3Ylo0C3jNRCqmdRAGZAR9ODo7+ZhfcMVG9ATqEr323DE6/h4NMWzTtzSp4EaXU+vizqsVo4xlL9ieneoLWSs0r6A0hR9+qMYK4wGKc5YLy69h54aHae1rQgX51l7bKGv4t0261MxE6g3t5dLKYB2oEa6K1C9WBk1PYfOh2xhV0g8oacgWP8F6fwjBOy0V68dOD4mZ5SyO8FikqHpXC7G/dqLAE/FvwOV531EqiKW0OHjpFILEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 08:53:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 08:53:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
CC: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Hay, Joshua A" <joshua.a.hay@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Shanmugam, Jayaprakash"
	<jayaprakash.shanmugam@intel.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Richard Cochran
	<richardcochran@gmail.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "R, Bharath"
	<bharath.r@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v7 14/14] ixd: add devlink
 support
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v7 14/14] ixd: add devlink
 support
Thread-Index: AQHc1ujvdSCdh+JozEiRAPC91rbLa7X0Krwg
Date: Tue, 28 Apr 2026 08:53:47 +0000
Message-ID: <IA3PR11MB8986407D74E9DE59F31B7AB5E5372@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260428082654.44364-1-larysa.zaremba@intel.com>
 <20260428082654.44364-15-larysa.zaremba@intel.com>
In-Reply-To: <20260428082654.44364-15-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SN7PR11MB6850:EE_
x-ms-office365-filtering-correlation-id: 672ced0b-925e-424f-8802-08dea503a914
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KYQWwBnG6IC7why/Qp/vzAkbO4asnTgYoC3CyP/V6NVu7u5tBoEl/pQVCV6MmR9uVVnelIx6IsDv1K6/Fi1kCD0ne4PX0iU5zHMI7zr9kKxEZ2wIXRqz2Dvmm6XscQhDQ2N4Xh/lh1dZa4jcyzv4bRFuIQCcax4tRv8hsF2Y7Lrt/knJ5BOtJrdmDSCHG9a6qnCAY/WafGfmRzFyj2iAu++MypF4Wx/URdPRx4RwnBQ4xy2Y9+b0suJJcTo6DDgVTmNoWgmUQaWOX1Fg8o+bEUAmoqaSAyaChL43sUDXmj9ubYjlljOv0yUEM0pHCJUKTPSv3kpxIHMaoSr7KT9lHuw70LMpz13y535ER3izDXlx9faoh+DIfrTG8cxhefdqhtiX0rcxQRhR7TtdOnWAspqLUVJ8uk0VR4m9pN+nJuw8xrcUOjcJX8WPAcBFXEfUqZ65Q4Eg2ZEZsZIY4e5lDwDMGaUn34hhqUB80LiwHjngRQOGeswD/qb1n8UfZ2VMl8m3FaokDYrion+vT92VGW2V8UlIRcoBybfHy745aUgZXwJikZ33H4JPMNUoFc51WIzyIS3HDl8cBTRYmf1PYLFX65A9ubwCDJmKZwe1vSvhkxeGNua3p5YsYR643Aqh+Tc5JUozaPQ/vVdn2/PCUBDRPaT6Y8gLH/seExtY5Q4dE016Pf9CgOY1IZr61VoaY7vCxNRs7/a0vreddwnomnuDypmPVRkPl6RUVwD9yimoAwQ4nV/Ps175jFU/jlHEXbAu260W0U5LdhR0GtTX7i6GsRSpsXWTzhWBCS89cAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+cMxzfMSHAwN+9Gc7jlD58MtmTx/6tiQ0qqBvA3G17dUvDxS74fmdq4XUFul?=
 =?us-ascii?Q?nrGUrG6liuhWBIifc0kHjIHkNEdjT+4J2ijdwjaZB9LpO+CjQrQrTrvdFsJd?=
 =?us-ascii?Q?vLET6YzjhRH/VPignrmWu6eGdydmlaC7S5goE0X1u4gnTAN+Ijrx6zzAFjia?=
 =?us-ascii?Q?sGh+T0zDrHaZlBwH9T2Y5Y8+VyCMor3kLqlGVdg+cMWFgtlbi8wfKWzZ/tr2?=
 =?us-ascii?Q?d+eXxOfAIr6aCmTLe/W96EmmKUEuNm75n/lT12+rTrMPZnkwkMOhveqeSVGY?=
 =?us-ascii?Q?2yf9cdGISS/SCdKa4xmrQWC1xhX3/4FScTXEGq0PxyTo9TNXMk9Z2lYfX86D?=
 =?us-ascii?Q?9L2qibx5ZYh10vK2ww5gAlTvbJq68rSHyODKUZnCJRYpyhLDLWFG+vD2QQBY?=
 =?us-ascii?Q?dAQfY7z0FKN5+bBzUhS8eCMzxncTwtyot6qTXmiOGzDm1tDu5znyLqcG+8wo?=
 =?us-ascii?Q?wrzSCLWH2lQRUT8OndvqMpmCk7iS0ikXprMWzbKBfjhMBeE1wtHW70ROc9ow?=
 =?us-ascii?Q?lB6zyOJWIrvsOT/O4oujJ82TCtB7XnOCiAj9BCqOtuBO8p60OH9621PWQevc?=
 =?us-ascii?Q?Cz7rCFC2gljkrkl0w322jlcWG7aKinlERvkCV3t03zr3yM3Dvd5nzlICgazZ?=
 =?us-ascii?Q?kZvtVVaLa8R61Iwt+84ol+hxUj5UNRVjsE5IqMdRrjMo0hckfWljiy4MR8Jb?=
 =?us-ascii?Q?ITgjiSqRgVmAZdhuYGurg9IhqrXWRAG6ICdSFjaLS8OjYngVDC26Mlc0kF2J?=
 =?us-ascii?Q?cFc9CGxWUqfvqHLLNEgUHqFHMegFfJPyRddCRO67e9hcOxnQBQ3quiqK3nWv?=
 =?us-ascii?Q?+7Le17udoK5aHSs1MOnvq7weXqi8Tgv9fkaoaqKyfCjwS7jNYjuajCRumYQk?=
 =?us-ascii?Q?pBtIoJ0ayK1rvzEPuFVKpCWEkg4XTkWhF6+i0O3cx5Ug3NWaEhWp5QAYbcR2?=
 =?us-ascii?Q?dmVOCN9b1qdhJfbSOO1fF/KWfe0ziu42DoG0Y4viiUq7YmN8Z30nAPDAttYB?=
 =?us-ascii?Q?d+FjxUVF5vKfzcvwB8TIExX/wlFcyTc5YrV2nMaKXwLsJNaPdhfj7xfF7+/+?=
 =?us-ascii?Q?OUghnMNA4ZAxsKfIzdPKTTXqCYTDjFdGjjFn8xiy6PUUCSWjVoMbqKYvXO56?=
 =?us-ascii?Q?QfQU5G7Xp40O8DiLCEIcmU05Y2/CE0eL01aQltvauxyKSxoJ3DGaqZdTh2yo?=
 =?us-ascii?Q?ZT+vGQYiRzO6aG7dxLSDc5c3G1q5M5V1vhCT5umGtms9wGSS1+IKUm4DOdA3?=
 =?us-ascii?Q?OhXWLvWS5L7EeTdE4VUbsyJIYCzy0rwQyKMh9CKAIev5iP/qQGm1t4WUJeGs?=
 =?us-ascii?Q?AUZtV37razoAN8w0m35OmtgsJ8nqHbTG6QsFlIO5xCIW2PS+OEcXSZepeh46?=
 =?us-ascii?Q?TAcLdtlqUSrrtCndWO1lSLIQ347WkUD2qhty7RnyOa/3o3T5fW9SCVQTqv/K?=
 =?us-ascii?Q?eXJ9hFoHER2lAfXcb2NZq0ffGW1KiYiHUogFtWPF8tbS26+UM+jBCf6m4dUT?=
 =?us-ascii?Q?3Qqnv5wrDZPqbve1NXcetvulWOXpCA3kPQ8xWov9yWk/fHzix1D5yDtX5yXb?=
 =?us-ascii?Q?tcrIECjs6Tkqqp388JDac0mM6PCUPDKZV80qTwArQ77RDqz4gyhotKNEpMKZ?=
 =?us-ascii?Q?mkeOCGIi/evR6dwWVievZPLZEYvC1d61j8V43XHQriydO/v+vl6fc6L02HBK?=
 =?us-ascii?Q?6Sm1f5CFdEZtf2Y2MnoUnxpIBv4NqfFoVOwo5A92QFKbK+rFeC/ijoKZcTGI?=
 =?us-ascii?Q?uEkaepaEbX8dhJXabDzm6D5yVr9qArg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ADKYaIiXHTLjacrg5wRTEEmMjIcTMPEMsIjj+YPJx2/de+1Q46zzd6Z0YJDyoaG6OH3avzgqQoCw6V8Kt/NCpsZ12VTD9IWJ/ER36U9lIMg343iJyqr0Y5AEHtDqIMwS+GtIpm//5KIgF+c3VN73Y3uy+yBqCuDfEt49LwirKJnvFf2R9tEoU0nieUoQOGjFaol8HDU1me5gWMTIT2YxM5IrUEHslmKGmD71omnHxUCO9aDCse54yiwBMOpaghm8PXAlHN/9m+kEgVFxuswGWeJO7mbfF+ttPd2viMpEbdZkVtIQRZ/8/mWT63NBbBwYfBFjPBHbpuTZfb4b+fBlMA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672ced0b-925e-424f-8802-08dea503a914
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 08:53:47.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXPZtXqfRebHs12r6ffvw7916e1V91DzxP18qLkbb5TAzWbApi8BxQxvTQg2Vx96xaPpxK4xOkxG2/k+qvlZQkswOgbJjFNB6QZe7F9QDSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 22B71481063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281737-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Larysa Zaremba
> Sent: Tuesday, April 28, 2026 10:27 AM
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Samudrala,
> Sridhar <sridhar.samudrala@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> Hay, Joshua A <joshua.a.hay@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Shanmugam, Jayaprakash
> <jayaprakash.shanmugam@intel.com>; Jiri Pirko <jiri@resnulli.us>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan Corbet
> <corbet@lwn.net>; Richard Cochran <richardcochran@gmail.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; netdev@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; R, Bharath
> <bharath.r@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v7 14/14] ixd: add devlink
> support
>=20
> From: Amritha Nambiar <amritha.nambiar@intel.com>
>=20
> Enable initial support for the devlink interface with the ixd driver.
> The ixd hardware is a single function PCIe device. So, the PCIe
> adapter gets its own devlink instance to manage device-wide resources
> or configuration.
>=20
> $ devlink dev show
> pci/0000:83:00.6
>=20
> $ devlink dev info pci/0000:83:00.6
> pci/0000:83:00.6:
>   driver ixd
>   serial_number 00-a0-c9-ff-ff-23-45-67
>   versions:
>       fixed:
>         device.type MEV
>       running:
>         virtchnl 2.0
>=20
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  Documentation/networking/devlink/index.rst   |  1 +
>  Documentation/networking/devlink/ixd.rst     | 30 ++++++
>  drivers/net/ethernet/intel/ixd/Kconfig       |  1 +
>  drivers/net/ethernet/intel/ixd/Makefile      |  1 +
>  drivers/net/ethernet/intel/ixd/ixd_devlink.c | 97
> ++++++++++++++++++++  drivers/net/ethernet/intel/ixd/ixd_devlink.h |
> 44 +++++++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c    | 16 +++-
>  7 files changed, 187 insertions(+), 3 deletions(-)  create mode
> 100644 Documentation/networking/devlink/ixd.rst
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h
>=20
> diff --git a/Documentation/networking/devlink/index.rst
> b/Documentation/networking/devlink/index.rst
> index f7ba7dcf477d..f0c077843fa7 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -88,6 +88,7 @@ parameters, info versions, and other features it
> supports.
>     ionic
>     iosm
>     ixgbe

...

> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025, Intel Corporation. */
> +
devlink.c  has:
> +// SPDX-License-Identifier: GPL-2.0
But devlink.h has:
> +/* SPDX-License-Identifier: GPL-2.0 */

Why?

> +#ifndef _IXD_DEVLINK_H_
> +#define _IXD_DEVLINK_H_
> +#include <net/devlink.h>

...

>  }
>=20
>  static const struct pci_device_id ixd_pci_tbl[] =3D {
> --
> 2.47.0


