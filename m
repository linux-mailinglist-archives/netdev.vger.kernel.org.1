Return-Path: <netdev+bounces-227971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BBFBBE44A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F18F4E3701
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688C1A9B58;
	Mon,  6 Oct 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVgGkkpU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7E1C701F
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759335; cv=fail; b=kJOQhC/4eCS2T5QFcGS0bsivK9artwEH1saXbtdO3lBc6wUmpd3TRwdknyedHT2qw8E86e110jdTeZhnJkmVzyHhHBWWzxsia4J3IaPgr66Rhm7PWe/6mFKojcDMcH6fu4N8bo4641nnzk/Wtb5NgekxJZREKaoTJRuLLoRa1vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759335; c=relaxed/simple;
	bh=32DiuU90JzIR79Gy5DhOLPKMyqOAq24bwFS2yoarGoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fo7uQOu65wFz69qAuOhUGpsXXyCHmWYUpmVNaqBALj+6nrsRhVuUxfm4scwfNYXzWeVw+hW3rvW3Q5ufV23Bz8wctOn8win0NobtVNxTmH8TA8IP5vg+RhXxJPasW+Bh34Nx6sKawJK4QjcRNvRLjat70Wm2lEV7G0CEufFeu8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVgGkkpU; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759759334; x=1791295334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=32DiuU90JzIR79Gy5DhOLPKMyqOAq24bwFS2yoarGoQ=;
  b=UVgGkkpUhfRsx+FzlgRF0yZxsbv8WxztCucERf5xAbw9HfRjSyYd6+zQ
   EE6UXo+RuWrRMncGvBHG87EQ2Tp0//1QNhUd3Zm98vaTn1wsG0Ap48qte
   yVwdAXCvJWOLO+qGNCI8SjCw+f44AfD6qYq4BJyB/qmQLBvoauksNZ3eA
   iaIK6fIctwnW8QBL81Nc/GXJfVZoStIxC2LacjpArB3xjeIBMt9cyYLct
   HAmJ3EXR+2tDvojUywS4a2GZqFywdjFOxt0ojTJmuVGy/3mWq053DPp9M
   Uf0M8cGJwfSO0sUOyAYuyoGD7OFlk1Ff6ddicRixZuKOlfF0rlr+qpdpu
   Q==;
X-CSE-ConnectionGUID: dFgbQtP5Q1iKEBJDoSUrOA==
X-CSE-MsgGUID: 2IOAk0DsT3mvI4yJVJs/ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61816956"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="61816956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:02:11 -0700
X-CSE-ConnectionGUID: bDGqV/KGR5qtZhhQOctEgw==
X-CSE-MsgGUID: hHloXyncTfOBpJMzT7WSYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="183910294"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 07:02:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:02:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 07:02:10 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 07:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srx7oGoiClPQ/JvTHp8Clnb1A/eWNgURNj9Dv1aOe2vz5jNnW3IKiOBHB7QjSAo7YRI890uwdPNG/9PaPwjdF6YnTPHZGKa+ok5aK2EQtW1+fiYuw0f0RqTJEUQYdqTg1USN2prDDjQKSrzuHToroozeeO3LYkxF4ZJ+lZ979gii7OUhzzmrVFDIdXTLsn2PiFh9kyHj/QGTYS7HPVyJZHrUTHfNtYeTm3l4RXo0WNiAKxywoqpDGUN5S7CdQu4tLUye6XD8KWQPgYr8UW2BDWmhb1xVRmqSGkRvzj/nqgjrjoce9zxCkD1+1nvSR3GL6tJFXZnVWMLGh4n6rsULvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7/d8zTu3I5mwOZu+b8CGF/y6DQBv8AJas7fNQdlxUw=;
 b=SOlmtD11Lw2vsJhmWEt4dgiqZUm/s5XlBFFciVQtlTefjQeoLbUXXWj101kZBU3jas2xV6wKPzOyOIWBcqOJRLMhZPVHY5gKlJHc5ayw2BpH9/M8wccS0LzxfjP8LTMsda2w64pN4eISR+mbuY6B3hEj1Dh7gZIrGHiBIM+XeZSplSPIia02iLVNYIFmRt+CxbEAlcR+kCRp90AR9H+nzYebiiYvCPOImPjSM2FUJVyE+mGK+PuacXNp9Vi7szH4cAZxi0K1oYvU0Jz4EgzBn8/m902nkDBaDqeZ2klVQirYfvR+tcz5zJqVznIkFb1YtOdfHjPue+TnAu0ZwqtRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MW4PR11MB7007.namprd11.prod.outlook.com (2603:10b6:303:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:02:03 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9137.018; Mon, 6 Oct 2025
 14:02:03 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Kohei Enju <enjuk@amazon.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Auke Kok
	<auke-jan.h.kok@intel.com>, Jeff Garzik <jgarzik@redhat.com>, Sasha Neftin
	<sasha.neftin@intel.com>, Richard Cochran <richardcochran@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "kohei.enju@gmail.com"
	<kohei.enju@gmail.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1 1/3] igb: use EOPNOTSUPP
 instead of ENOTSUPP in igb_get_sset_count()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1 1/3] igb: use EOPNOTSUPP
 instead of ENOTSUPP in igb_get_sset_count()
Thread-Index: AQHcNr4oc0CezRLzxUmlxBzK2fFiC7S1Jg+w
Date: Mon, 6 Oct 2025 14:02:03 +0000
Message-ID: <IA3PR11MB89863491481C4E13B08B26FAE5E3A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251006123741.43462-1-enjuk@amazon.com>
 <20251006123741.43462-2-enjuk@amazon.com>
In-Reply-To: <20251006123741.43462-2-enjuk@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MW4PR11MB7007:EE_
x-ms-office365-filtering-correlation-id: 8756c5ac-b0a3-4e23-3b8b-08de04e0ed81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1NvJv8jUhd/ZiFBmtgEwYYR4tko0X0s9BehMEttOpm2nvWiHlphQSznxcOaO?=
 =?us-ascii?Q?NvkK/B/g1LoQAejtPwS0130T42OLSsPEGiMQUS6HZxqI+EzPDdQXOB4pJJYf?=
 =?us-ascii?Q?LPw9Ua9J+Iw9m3edCGXoF208GobBL8oX0V2RUq0RzrT+X4UEjsRbGEivT6yt?=
 =?us-ascii?Q?Mn9hsN1aitGbzrvAk7YK3E46uTM99o1JYosjZxZ48Y5VNRhx/pJkFz1BBBKs?=
 =?us-ascii?Q?oEK1wP/A/yN7Oo0XoLa7Aw3cXGpu6gH007d0kyLd7BpZ9zFLDsSQNniKLDuC?=
 =?us-ascii?Q?4IkeIkiNVmCipsSwTco0d1Ufx6GogNeBMpEKhUsdXQWSQnrediiLYcefYAgU?=
 =?us-ascii?Q?XI/MT+TlOYQ5piPCBwS7nj03y78WHFXWYhaL31nHvJuUFug5ISJ8M8td5ITS?=
 =?us-ascii?Q?5mzBVdPR63Fxvpfj+4FuP4JQky8KvKMfmB65NGKXyMi+XwSAjAZUbyRbksHo?=
 =?us-ascii?Q?s7sV75lReA/Uok+TwC6Tzwyq+rFkutzcHuxNcmvDV5/zfsgL6TnomPNQG3L/?=
 =?us-ascii?Q?tC8BHQgHPT7nRJt6MOXADpA6ftIUMQm512jqybmLDWLcsHkDt3l9/bgDqzp/?=
 =?us-ascii?Q?ynvdGnAP78hZdJkoPQRLXCMD+ATSZYCfBxtagJbuXWQ5fixCI95SuMd88P5R?=
 =?us-ascii?Q?ivEIkPKy08TwIC9P4lowoAQyiSWKIP3HxsVCEjPGGp9P5O7H6nzdX0jiCQ2b?=
 =?us-ascii?Q?EXe4yGSLEmDXcsLWy9qxxvYKNIaW9zjm2MF8OBOcS1uw8HeldSMo5DNW/Uke?=
 =?us-ascii?Q?uQaUfELAANsWshnJj3ZhjdNBjdNvQ9FPXJPRTSDYyoBuc+78zNeBnomRcGfJ?=
 =?us-ascii?Q?vx5JurckwUfwK8BSiQ/fQuuQzFBFA8iwQH0WAjjZC3LR9YCMl2jjxCDbURzN?=
 =?us-ascii?Q?xz8W7hQSJZs4cRQvQLa64a9reUuTo8edoQGiWRFdfvNh8D9tb6YZmQj8igMR?=
 =?us-ascii?Q?eLkFx64oxadn+h2gVQs1YYaQZywZzBFzpwihM5/7LLfMOnBdj6SSPhukfpiR?=
 =?us-ascii?Q?OjAWLVJInnhyTa2lTDmkAew3MKUDrhSVkHG7MEAO5J7NBb2GNwqFfCkjZV1u?=
 =?us-ascii?Q?usabaf7GYSKSEiLP4Y3zjeWxdfTRZe/EJxLCXWYwsx2Cg9i+872IY/VpOrMs?=
 =?us-ascii?Q?FYwHjAuWke6/vNirk8wxMsoVltF5Oc/+86xtStZiwqnMpGFDnutE3X9CFwTz?=
 =?us-ascii?Q?LIntuUtfvd6x1GusnB+eD30iaqFinXRdKUyeOSSv2gYVdK8bfk1OhgguAYR5?=
 =?us-ascii?Q?eRuwMfNS2k6Sx4kvdf6ZRFNZN43leyz43Pfpoel3HKLi7kjEGNxo/DQe8B0k?=
 =?us-ascii?Q?BWEbKsLh4By2x15/7Q3fP69siKIBVYRChSw9B34Sh9WZ3o3J3my535Jp2ghV?=
 =?us-ascii?Q?dHA9ELP9L6QasGsPucrksi/TGvkR/GMueU4qZaL2BYYznqAwW+HVzTixBZmh?=
 =?us-ascii?Q?Tt4ty5U5iJMDQ60iGkqE3onUct4qJBaHh3zptmH4POjNnfBF/TZ39kEDBnYn?=
 =?us-ascii?Q?kwwcrw5w4JFt3M7BmBm/jMYuNM6D1U9MfVDz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fkk0ZGzEH/RkhNMhS/m+sspLLtbBxaSBEzluGJaBRAupsgDJ57VELzUYjQih?=
 =?us-ascii?Q?qmZAoEUg6tagCEfILyn7++SRb2HGmIzS866uKlyOUDlixnDDGRXqG1lmMvL1?=
 =?us-ascii?Q?wiMYbbjxBKoZSptsrxcwDaM0PJcDFWzglX8CDPrEMAxMg2vs8PP074Tg7MCb?=
 =?us-ascii?Q?/UPDCqIPFogWKt3wWpS3QMOiSLa0t/FZ45kMixLrig+6aXsUTh3BA1MR1XsM?=
 =?us-ascii?Q?+yJ5m7mAHfZcPTFAWWWbxLpYnsiyHNnRHRKnhQEXbUoweYH2Uht+xGDnkUmG?=
 =?us-ascii?Q?JJ+nGqs+4dqWuz7VPJEsuYU/xA0JGrUDPshod9N6/RCMl2v3K0f0RVSGTQvA?=
 =?us-ascii?Q?+Qy97Casl2/x9zaJU6cwdTAvJ9umDUOrDbNOkUudJC6RdiLFMcBma5ZpI9yq?=
 =?us-ascii?Q?bJ1dAPNhKqPC9P4TEM5ZdXf741rjjFFzm6Hl5qXXtNDDnzSbNbNkfcn56Ubc?=
 =?us-ascii?Q?gbSOpawt1BjJ2AafaUv5/+VpaZtDZDIGrNPNRb7SXWpicV6rrCaGMIcKHhp8?=
 =?us-ascii?Q?wLoptRmum80gcaCkFYYgdAFqnb2IMaH/UJyc390Lk4kljN/xLKVkn8KizYUF?=
 =?us-ascii?Q?5Lqb6NA+SgCGoKlv4m0NBXN3UIKfWzR12foi+9TnR0jQTzRiyD6qvmjSsQ2W?=
 =?us-ascii?Q?vDC8sUf4LLFwiUUTnzneBz3x4EXHzZG82XMFisaaJYLG74IIYuk1UaIrHHb+?=
 =?us-ascii?Q?GCjwVh8ZaE/SZGAuTL1p8nUTSgf7YJqXH2OapyOK3PCXXsvD3gJgcHHAJ7Ot?=
 =?us-ascii?Q?32YelZHBpEkUFEy3f5/KvXSePKIDYqxbwNcWm8t68s9vola0xR6Zw43/upbr?=
 =?us-ascii?Q?aDDTe8yH3cKoNon4KxiUgebPvQfr5sQ0D8+RrVmhedUqrJrDQMHeiZuJap8c?=
 =?us-ascii?Q?2MWK/d4jHQVmegxreiO3Z5O+5/r5cRbMQ+fXVLQ/gyAx5GPWVkgTy7Q3wW11?=
 =?us-ascii?Q?xpZj82FMtuLl0a7Lx2LkyslGsprwPyCK+OEuBCYhr9sRop4PrGuSsyDQKeFf?=
 =?us-ascii?Q?td5qHAPI1tufaGUaEaeFqVQoNaYYrd9m8U3ywT3M8ojbaOdjZM04y59tWf2u?=
 =?us-ascii?Q?Zc8GEehDfiy78MRvD4E6eIVVZoOavCgiYO6TNEyZYQbjYUkoFr7bRjVQJo7h?=
 =?us-ascii?Q?PQg4gTjkBoBdEkGBlgQ5hC28yWwfB6kqBJzk3XM+FiwodySPtorRnUwksjtf?=
 =?us-ascii?Q?f42Ykx/hqOTkYxfVAs78X7omnP94O/MK4BDWjp57IZwQktSgw4oea37xHsRF?=
 =?us-ascii?Q?Myfi9FlBsYZj7k6qSBDsmNrq/kxf+TDZUUOauFWRP3doY5+9jGa+gMN9X1qP?=
 =?us-ascii?Q?yqJumbJPvU+8oOqJeRV7gl/6ODn22cFnBX8C0i0CzxFE8ajJekKvFvpfKOgg?=
 =?us-ascii?Q?0zIUoMy1cnVwggZvm1eW+NEjwWFAW+wI7+KwaTz9x2os29RmsF58+ujOac7n?=
 =?us-ascii?Q?80yHq9c5n4XQ/X3txQfvNahxBhxq2V1jTfU8xQIRGGdqCAJqNzdJLrxZjyaw?=
 =?us-ascii?Q?9LRdEMPVmT3Yd6VcZeHpEbJrxYg/5HNZadNZ3putnggg1OduItgk5AFoLC8C?=
 =?us-ascii?Q?HCf01tUJMZ+4mr8jTk35A3ZIS0GjfuFVn5c1rG3TOlzNxW+AbX+TQiO9nr1P?=
 =?us-ascii?Q?lQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8756c5ac-b0a3-4e23-3b8b-08de04e0ed81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 14:02:03.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrRtbz0F/vKQNOkEjkXh+xBnViqOI9/JNlEtgYjwFNhy5MSxVvy61fdL1/4mJHIMoMLlYcjYCaWrhHnzQxhcEOk3B1CtjAKG7e5ElJXeSEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7007
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Kohei Enju
> Sent: Monday, October 6, 2025 2:35 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Auke Kok <auke-jan.h.kok@intel.com>; Jeff
> Garzik <jgarzik@redhat.com>; Sasha Neftin <sasha.neftin@intel.com>;
> Richard Cochran <richardcochran@gmail.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; kohei.enju@gmail.com; Kohei Enju
> <enjuk@amazon.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/3] igb: use EOPNOTSUPP
> instead of ENOTSUPP in igb_get_sset_count()
>=20
> igb_get_sset_count() returns -ENOTSUPP when a given stringset is not
> supported, causing userland programs to get "Unknown error 524".
>=20
> Since EOPNOTSUPP should be used when error is propagated to userland,
> return -EOPNOTSUPP instead of -ENOTSUPP.
>=20
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index f8a208c84f15..10e2445e0ded 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2281,7 +2281,7 @@ static int igb_get_sset_count(struct net_device
> *netdev, int sset)
>  	case ETH_SS_PRIV_FLAGS:
>  		return IGB_PRIV_FLAGS_STR_LEN;
>  	default:
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  	}
>  }
>=20
> --
> 2.48.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

