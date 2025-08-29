Return-Path: <netdev+bounces-218135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A49B3B3D1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345F1981819
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61408263C9E;
	Fri, 29 Aug 2025 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTidZQDT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5647263892;
	Fri, 29 Aug 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451164; cv=fail; b=JsdDBQGd0YBmH14PZlPYYUJA8V1wCBNkvqKZdMMses1taKV6uPivID7RPRBhZ6vROLdQjU3BqlxPxNzavlUWyIQLsVsJinJpmmVy5Xd3wAMDK5SjL/YxWcvJdK2XOM3B7Qe3EVlVvc2scXmfCzsDOBLSyn/E4HteKqZsyijlOEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451164; c=relaxed/simple;
	bh=4IcB/3HhMQwjoW8KwWxWuywsiECYI0No8bOMkaq5oV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F7mlIoC0eBIi+Gn0P+pywHGOsTt3tpfoATe9FJZVdZLusYJg4CA8j5WCpHaONd6jOupS0gHZBrybrKgiLTz/zXprW1mPQOCTq9ddYNSds4mXzInUKpwmpgWq+2uagXUT/rkaln3SpAFbJtqixZgHWaELLZbsr/t2V1SxsR/EwPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTidZQDT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756451163; x=1787987163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4IcB/3HhMQwjoW8KwWxWuywsiECYI0No8bOMkaq5oV8=;
  b=TTidZQDTx7YV9IGcWVCSHidXjAGbkGYO34jEV0ksRdv1FUQmuWo9KML5
   1oK12JfMM5LIhugVojW7cw+vcE+ZsbOCuQSkOyGKg1BeejWppfTFtFjxd
   m2fakgCkabLf7mM1cOsUZCEyCjQvQxv3om02Fg0xsrhjinHAjbMN042Dy
   +UK2Vuw0gezyzy1o524a1EwUv1MnptE/ki5l+0o2YmBendmgj2FPC8Cf7
   6nRqE7yHbotVHJlZt0ZPr5nrH2ht3FuLQCvKBGz5Lu+PcwAqISChT02my
   hX2VC4wOn25TAJfaN4UlV9b6vC+KCmVv82uuJHIQlo0doMnsbFhlUFu1w
   g==;
X-CSE-ConnectionGUID: UElKnRPHTpGpmVtJdyMxEg==
X-CSE-MsgGUID: QKzzCPVlQuWOd4Z/sY8UjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70172948"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70172948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:06:03 -0700
X-CSE-ConnectionGUID: m0zTKB/HQZK/TB8h2PEI+Q==
X-CSE-MsgGUID: Biis3FWhRzuna6hySic/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="207452648"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:06:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:06:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 00:06:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.79) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 00:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/N0nI0r0XWp9biuKNyjmur857e9IvT5HdIq+51UnQph/+D9M5TDUMgzRZdITPxIjHKL1Y/zwNuwBnCx6K+2Gdgx6tQDXKiIrHTgxZVF2zJBDiLvI5sz9GVF4SFwAVXvOoASoFmWUTmvP62sM8EXl44l5umcqzSx5024ti6zesDxaQrnrIgzGRW4rErdqYE95HcozeqYtmt9OJLoISV/pY8xVmTHlklLXACfg62ktZbyIZQoOs259eTPErgzd76JD1tGOrqmXUawe1uXyRq2T7alxwVOAhQ71i0uGJo5b1w7Lpe84yJ862qs8jkO2GlJbSiOt3R3RkE3NEoBcmwl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MDcto+c3uVrohCbr+ZQ0FN1NtSYm1t1mgCH1xKczJw=;
 b=dxVJAne0z8AKFirLZnSMzFWfCeJKgB+jbogVp14xJjLsnwgxgLzOioianYBsGJ1yMT3AHFAfLJ37NnpaqycQM4gNLNbOnx07QJ2F2g2YvmvkDYVEREPWgVUMIhVv2V+heLPq5wEQEH4g7bOTiR655VUJFJT+iW9/Wlr7aCCT38Y4/rvY0T3NwgDJuBNDffpddk205yubNvGeOGSioRxwGmgi7zN2wZ6dn5dpTHh7I5K6xdQmTBn+SG2EYcrL4zUVQwXIE66ULzFrhgCTu34QG3HmzHmDc+PurfmJMUvQpVpSwZHVKINMUSC1Uiac7u0dsJzI5ajFRSwLlOVpVNzTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by PH7PR11MB8477.namprd11.prod.outlook.com (2603:10b6:510:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 07:05:52 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%4]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 07:05:52 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"almasrymina@google.com" <almasrymina@google.com>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "leitao@debian.org" <leitao@debian.org>,
	"kuniyu@google.com" <kuniyu@google.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"Vecera, Ivan" <ivecera@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Topic: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Thread-Index: AQHcGDvl/LMwp05JjkKtLLSsBfpR/LR4S86AgADqNcA=
Date: Fri, 29 Aug 2025 07:05:52 +0000
Message-ID: <SJ2PR11MB8452BC7078EF68F086C1AED19B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <013d723e-ac62-4207-ae66-31126f890429@lunn.ch>
In-Reply-To: <013d723e-ac62-4207-ae66-31126f890429@lunn.ch>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|PH7PR11MB8477:EE_
x-ms-office365-filtering-correlation-id: 4878c1ca-1f55-400c-8d8c-08dde6ca7d9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1zVAkU1/5l0KD4WUR/1l3L1F76hHK1SeToylCFwP9QKnAghLdqdVbSo9vNuz?=
 =?us-ascii?Q?eVSYI3mFiTdZMuM2OB1iB2KssRsKh+OU7vJObIksAWuqsWOO//1e1xGy9I6t?=
 =?us-ascii?Q?NNohYhIhKqzN0fM5lNv4Tcvn97jc+7C4s5CXPnnR9SwVPePrVjQ9XOy0aZs9?=
 =?us-ascii?Q?7U6dojWLo1ZZIiJt+eieB1L/3bozFOmFUds3uvxU3rjQbICVePe34IM1r/rJ?=
 =?us-ascii?Q?yaXVOMv9jvTxvCGxMvOdsw4yRKBwZOp5laU7dOgxWc6E357kjCsO+81lG48o?=
 =?us-ascii?Q?i025IV6BKmMIGzwT5wI9sI6Cf+8GHs1LlzI2C1JQE9pvPTnv3HfxuQBoIsEJ?=
 =?us-ascii?Q?y6yxg0Wc6XZVjtXaAMpp6zd3PrSipynfkr8mSEj6hE5yd4AdXSpthdW1D3hp?=
 =?us-ascii?Q?139QfBZp207VeI7Lyj16zZQXArGQ8/6cWeari463Qd5HtjG6JEcjD4A0gytz?=
 =?us-ascii?Q?ejJ7KeWXIkgrvHbZUvvugAxzdjDd4iQmoTT29cnjrZbGCPAVMusGj15LEO9F?=
 =?us-ascii?Q?LlhDsn2rvur6oC7oOiD4ZSGGcIeZsm95Q81QyQT68X2CpGAJa5hGZVHZrOWH?=
 =?us-ascii?Q?XwlYxb2YDWSPtgRJj6qnMCV38qscEW93O+Yx4z3EwuBhK6rvm52p/Czejr/8?=
 =?us-ascii?Q?6UlG+cRBpKRkUg8ffxWfB7orbZt/P12xEyG/dqs5iW2HMpIO3M5iSnCrMBVM?=
 =?us-ascii?Q?DbTpZEsn0VVeb5z+QA4UQzAfS1pJKtOvRQR/w3xo8T99FDVW9XIz9WF86GoJ?=
 =?us-ascii?Q?wL1Opgs39P8jmr5pcwmsZ+ddEXzNT7WJVaDbM4B5/Y/rwLkmLoi5ULVX8O4E?=
 =?us-ascii?Q?A7Pl3SZ1g1W0sljbLXK9n/VyoiFwq3UUeIN7VHhllOx7/snFQhwK/3+eioQm?=
 =?us-ascii?Q?WWO8DV517dyRSjzprIWfd2Vs4CHViGos7UDjOijQQkmW3GMHAHf2E00/dKKK?=
 =?us-ascii?Q?1oL40waVEoi5aEwzVgI8ZD1qH2GkWLEF31zmvf1ws5YOyjH1cPtH9O/Ji11I?=
 =?us-ascii?Q?MPrPBbZyoyjfDnmqFrO9mYUitsfUk7Lncru2Eo5P1+FvCrFMBR6wW3sgvwMH?=
 =?us-ascii?Q?MgxsCN78ulN7YaGiWZMSHLBPFtkVl5mF7ku13S+Oumn4yhE+/zaumi2DqAxM?=
 =?us-ascii?Q?f659kD0mG0/GRGrz4qqh2OuTLtK50Zq2NFvV0Mg9KAIJnLJbjg4DlP2GUyyy?=
 =?us-ascii?Q?VEutXSlgaIQrzsaFktF9PKmJjzDbBTshrGd8ok8Yr7UDby8VP5hPKg43B9XP?=
 =?us-ascii?Q?KB6MODcJuJKaQaj8ZrpruKSNmD+NvZPnG7BEcfTyZ0ltHHVZ9dhezjVcYBWq?=
 =?us-ascii?Q?PgzvVk601IPW2q+eIEc+DYVZI4Fu7y/4uP65dJsnYKEBh/UdnZr2g9Y+yuqe?=
 =?us-ascii?Q?Fqu7oxm1GaaLYZW0dpCWtpndMtjiu7ZlPKkpUtqP7mipiKytQeCH/5fV2WeP?=
 =?us-ascii?Q?gMRozdbJMtvUFo8Y+y385A8zJST1q6Jy9TFBXXG4BuRe77CND+mNGg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vu+nl89nGwLWDdc8LDUaDf+eh5g9h7xo57X/OFGqBwtJd7/MSaUJxX69/PGR?=
 =?us-ascii?Q?gEPL9CkAF/4KlPsbZdwWW5I2LwxgsejGBJFaROHUbKYBee5kqCtr5z/OglE+?=
 =?us-ascii?Q?d3lxC5+qI5rubKq427UdpRZTb9taelOi1xlIWSYj6SI38pZabkwI3dLQDPOj?=
 =?us-ascii?Q?eRpB7fQ+Wde7/iW7vg7F70agInmmQEL9Qgynj28Oe1VGF380idGe2v13OXoU?=
 =?us-ascii?Q?IdJBnaGh8UgGcgT4ER4l1DOaXTSTvyw+oOT5/ULZx2j1QK8xEYIK//FGkBfi?=
 =?us-ascii?Q?HMXaPdiu2vH1cp3YwjP3ucTjkkyHZSdyBfGlqKStJEQVPMszOIAyKh0/Pr7W?=
 =?us-ascii?Q?B58dv88qvOCk7G4yueV6VEYelcrVAAnkPDMNj4THjRZa1qmJvwEj1bwwpyJy?=
 =?us-ascii?Q?3l6sMHemFjubLL+JiWaR84S6EttpTTIUJlxIrxlvVy5rlGLxDzHX3cVXk4Gd?=
 =?us-ascii?Q?K5qgdQYJYLax/c9LcSOUAB0g1L/nzDasU/ebdEzGFREoYaEX7pliCzHBCL09?=
 =?us-ascii?Q?EjVqAkKuEowPj9DWXn3+P/VysZ+W5bwcL0BhYReXUXczMAEe3lZjbGs7oq1T?=
 =?us-ascii?Q?SvYr25tspyuvgK14VVYaR1plijJO7k6b+BzKfmj1YPJAT9AHZ15wbho08hG3?=
 =?us-ascii?Q?RqrX46Fnr8Is8bNHgad7eq7V1IIJD2jGIFSJ2BvycShcuXV2ezNpz5JAvrp/?=
 =?us-ascii?Q?Yc8+Omv425H94bc/HZfUWWZROOghFGuJuHs+Bs3RG0cVR2t2QV3qAeswkN7E?=
 =?us-ascii?Q?hp8puIQNbayUwQjL+Go/gtEINhYRjTrbCiFYd34CrCMDWltIcekZRY6iYaQK?=
 =?us-ascii?Q?p6TaRgU3jz+oIZY/hfUTKincYmhE/VDtW4rx2TeTOuklUfUX3ig9YIIs8YhX?=
 =?us-ascii?Q?+yyrC5oJ2yToLG4edRMCrrBGlqGID2xB0/HYjIh7w97TtLEhLfdVIhKXdEGj?=
 =?us-ascii?Q?Jq6mQ0tko/cllW2Z4xhsak5SueTHCdE4qvrqb0Ch1H4DAjc+sevidyO1iO3V?=
 =?us-ascii?Q?7VeIg2CeKKV3E2bG4EJrnjxNwd+RX79dqdBI0IUauhuwbPJ0g3/V9DxhZsnL?=
 =?us-ascii?Q?RZyOk6bn8fWvijG3kTeFPuA2//Ir0Jy40MldXUc1i/ZN2PciFyoIGjLc5ef0?=
 =?us-ascii?Q?vu7XaNmobK2+T229VcKBMy87fnXHeEmmip2kax3Hxo0dYct/TSzLHZKR3Orz?=
 =?us-ascii?Q?4zJ2Tn2o3esVjwPD5gx/SrL+TJvJMMQt9lPJmeo22T9WHZwqBOi1RgYft7Fa?=
 =?us-ascii?Q?KH/itoaYVF05CgYbAIsTTCOTrpiGgbnbtE5kN9qDRM2XwlvWPNQzEAEpQkFn?=
 =?us-ascii?Q?NHhn717tqpVBWNvhJA8yovic2IC//eQ0eglRw8J5/y7IXJkHGFBfccjiExJO?=
 =?us-ascii?Q?Kjk8kB83njAaLKdea/CSf69PPYs3GqQsx9bmItlEGwzYK+iYlAk3xpwh1+J/?=
 =?us-ascii?Q?V+iGL6bwgx/KkWiyedJ7JFO5RrQgBul43YrSVjkbAtDKF7JK7wAM226yTgeo?=
 =?us-ascii?Q?o1UsYavcscnNpPdJISg04/SSxP7wZO/8H9ST0tpwXoO5lNQfOERb0fHqgntQ?=
 =?us-ascii?Q?CSqbBp4ZTk00HXcjWFbAPFiHtSf8Nz3mr78ZvYiBtqnhsGUjCZYKiMGXCija?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4878c1ca-1f55-400c-8d8c-08dde6ca7d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 07:05:52.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsyNXcYEYu5KQebrcHsXCey4eIvz/ZNazx7azErZ/6t2gZhzxzzO8R2sMUlbjZZ3jIg3v5UcIW12jEefLwDpTPQrbjZCDTSyaDXD/QPi+BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8477
X-OriginatorOrg: intel.com

>From: Andrew Lunn <andrew@lunn.ch>
>Sent: Thursday, August 28, 2025 7:07 PM
>
>> - use netlink instead of sysfs
>
>ethtool is netlink. Why is this not part of the ethtool API?
>
>	Andrew


Yes, sure, will extend for non-RFC submission.

Thank you!
Arkadiusz

