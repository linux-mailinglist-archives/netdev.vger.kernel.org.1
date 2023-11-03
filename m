Return-Path: <netdev+bounces-45947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41977E07BB
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3F31C20A43
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136620B20;
	Fri,  3 Nov 2023 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXxJ6HUq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCC20B16
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:45:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D51BD;
	Fri,  3 Nov 2023 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699033541; x=1730569541;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xsw2vXlp77ncI649gDOzmKdONNyO1zy6GAVXOnJGzU0=;
  b=YXxJ6HUq4aG/KOonYZafEO746bfmsAmQJn6xbIa+T7arZ5Tm0fk/bl13
   bnsa9vDSdmm2bB9hVmB45scHHY98xZgfWbKEyGVIWE9YNG3C9rhUOsyay
   Rp7R3ujEGSYzVCKnQKNCajIPVLFSha/bAzhrrvEN4ZI9W8r5JqUJaQbXw
   ThrBSCalyoq3SBRt9pHQUA13Xl0IGwNaPf1npQwP6ap20lQ+n/oin2xkF
   0/sXFAZS6Y4HUAT/qUmPqKi84DB2hhMBu88D242+qo3BsK7dG+Wq4TfOA
   7Qfbq/7OA4G0M6hFl8mAoilLcLyIRZ7oqXbXAu4FaS7uJDofG07Dyo9uQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10526039"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="10526039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="885270295"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="885270295"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 10:45:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 10:45:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 10:45:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 10:45:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 10:45:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2uQ3NUa2QbljXNuXypH/guUZFCDgZzxyVHIhxh7cPMqYM6wagsFpWrcb2ROW5qLk6LCU/OBz5Vi5FLKWUdDwqSAJnrcBrPGpEqgObZss9Hrucq2ZuCHoeXHkEWb0paE1gWeIrQsvrS9tWw0ye99BIi6m+PaMvf8kQOzC4x4XLvoFcKnisXYOUwhbLgSyEO88TcKhbUh8c83uum/aLg1QMuTuZkcA39Ai1Ct9LOV5DfF8SPOw7uJMx0f8NwHWgHw834/KDK4AuBGU6ezaLln+bCs16atCOviuSzbH99za/x8QqiSCkJDX+7WkQMzG1h90ZIgpy6iavcoshOuollcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU9XJVWjuH2PIHAPFltveAEWcPn53+peumhpJt6C9Sw=;
 b=DVewG4ZMS303xaqrrFA/uIm9CEoV44tDzc2FelRu4KbHsIjJOgagvJABpu0LZRp3xbYGReOVtjaFNJlm7lp6VaEqxTCDu/oGZBiuHnrEgilMYym75n0fmuyAuzAf1p0vjXbgDGT6jildjc9nOf92UOqwByIzwyAiy+7s/Fkouu19Bt8+QRwizlErmC4otSXsI0VYxiP+9v2kRo3BxFkh7amEyoUGWgvMiy81eVGdV1V54+DZ1wgUsgWpgpx7zlTG47fIbw2Jm4t5Hh2Oyd7VCJQkTLncjRsHMeBZql1qAaPVxJodYVoxCX3oIYKOe5+I/7RVOlxJp9l8dGH7cClVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MW4PR11MB6619.namprd11.prod.outlook.com (2603:10b6:303:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 17:45:26 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::750d:a434:bc26:3a94]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::750d:a434:bc26:3a94%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 17:45:25 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH RFC net-next v2 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Topic: [PATCH RFC net-next v2 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Index: AQHaC1Gz+kgIdJTazESpUMVVoqcgHbBjvBkAgAN/aAA=
Date: Fri, 3 Nov 2023 17:45:25 +0000
Message-ID: <CH3PR11MB8414DADABE61FF215E7F984CE3A5A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231030165326.24453-1-michal.michalik@intel.com>
 <20231030165326.24453-2-michal.michalik@intel.com>
 <ZUDeJiafjggGvLU/@nanopsycho>
In-Reply-To: <ZUDeJiafjggGvLU/@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|MW4PR11MB6619:EE_
x-ms-office365-filtering-correlation-id: cc5ddff1-c2b0-424e-afab-08dbdc94a972
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvbVj420jmWMNQpls8RomPqR0sZL3pyHIz9jt/ocgozNprf511ZV3DqPTctYrxZvHjwXzJCUV7x/gZ9dkxmnuZNJLMAFt1h5o3oJY3pKXp4LXi9yKuwYwXjDuUag93EF2ekWLj+hZHUlmTrRRxMzrsAWAYrSiNciASZEFvBNY/itn8lbrFAHjsF83/NR/l+k38ao1Q/5hWDJJgAlSobLo0rS2jHr32NDr2bfs9YB3gd+ZMvjwmnd72tshilBCeT6mzWzdZVztuvX0ImAZiaOEjbjcpYLd3Kt5hzxDbu0ubxaGdu7WnDFQyMunHv4c75c+LFaHrrzKqKBLES+N6OXIUmVRcXPdFh35vOBhZE9xTdpw20wYTr59C3tLuhGhAyiLhX9F+vtbP5pQhm+bcdqh73dVWC0/lI62CqZZo4uPtogIoMYxhWwUYkbsFR5BwA9HkMUJhr8yLv4h55IlGjlb1cUb+G8CaJE3IX/9HhoaIRNlYisdjzFNM0X6NpipKEfaSsetxPJYcOJLAgWsuHqWiORgMqc4ECNS/1ebyLvMuCdCJ5y7o1TOoFrA+gv1QtaPdrep2rdboCuSUzipfMQVh+7QPLyGoNggCcXS/C4bAmGFq+4zK2wv4UTgP1jJOk/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(122000001)(38100700002)(316002)(6916009)(26005)(55016003)(71200400001)(83380400001)(38070700009)(86362001)(7696005)(6506007)(53546011)(33656002)(9686003)(478600001)(2906002)(7416002)(30864003)(8936002)(8676002)(4326008)(82960400001)(41300700001)(52536014)(5660300002)(54906003)(66476007)(66446008)(66946007)(66556008)(64756008)(76116006)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f8f6YfkGQ7c52BUv2PDIrJzsq4yU1N72sW/p2szwEsEU6uWvLlgxwHsdEZFo?=
 =?us-ascii?Q?LxS2o21G+VNwhJ7fakiof1UeqkPhVgt129AWZIBmlexs/UPbZ4p+ePQXltiD?=
 =?us-ascii?Q?Ap9OL5arU7D5z8S9OnW+s38pmcBw1zGkheMmezksUUiJHqXabcE29mn7NwQJ?=
 =?us-ascii?Q?PS4PAax1sl5nkJ5r+IyyzgK8BU7ihdYw+/CaXqc+AfFg50+tJWF2GUVTJ1WK?=
 =?us-ascii?Q?PtR5g1IiN1LDbQ+JCjrT25Rwmuf/oZgsH/fJk3FLKOqFPdT0doW2cdJaQ/rE?=
 =?us-ascii?Q?cLAG6qyKm4sLY+SyU9ucKH6RuDZQVFh68P2E7+i5hPAd0LfiCDm56t2wefFJ?=
 =?us-ascii?Q?XTDXm965JIq34bz7jgRbO44vyYz11bDwrglO0+AToNYfZXeVolFwb/q67Z2u?=
 =?us-ascii?Q?T5AsO1GBQtvF4sHzjHZ95ijHWK3kudx2nIExqAppPcv1S3yCmub18y4txL68?=
 =?us-ascii?Q?Ag93+q3r6NwVVRZIJBbAKodYj9EqX557NgP+E8ReIoGwuVGDMsDfUwPACo9r?=
 =?us-ascii?Q?Ov4h0f7Cy4fxKcJz/8mL8eny6w/+JaI0lkCf+aEhOvjlkVIFI9o7gdDPqP45?=
 =?us-ascii?Q?jIeA7niXKItWi3/9f5iFgB4EadKcLbL+EdavsWH3D89uUKU7H8r6Hn+O9PYE?=
 =?us-ascii?Q?nerKxHqWzScujnZr63cIa1spnmWQm52FevIG5hDay+bT7T3eRGJ2XVaHYyRf?=
 =?us-ascii?Q?YKDBzN15NMNYyxZJwz0KOaoQsr/9vHwrxODvzTCV8ucD5bKmU0DFHTlOZLXH?=
 =?us-ascii?Q?s+xDxJ8JkDaVUAzrhIj4Llj0nhUBbZUkQLu0UGIpRzRSWrVOC19N76025E+N?=
 =?us-ascii?Q?2ahQs1sAkcLI+lx45PYjAnl5K36sSPSvwbheHVtqb9Wb/JiM3mUcWg/OhrHn?=
 =?us-ascii?Q?I9MWE612V5S0Hq/JxWbxAlUJR1A/u+6fP4ZobBLpkE0Th9RBVUHis5IISWDe?=
 =?us-ascii?Q?GkzTWtb49KsW/8JvKZyFSSGiWkmt4VtR8C7nWsSjrlGo/mUmw1gtiPGS4MC9?=
 =?us-ascii?Q?z6/qdAKd3OFiwWwoHhJosC7BTPuek19mxcHV8CktnstJQMnzkygIsbZVJ3/E?=
 =?us-ascii?Q?Ybxvzx+Ek2+sy/P7UYEY8DlIe06IUmrD2zdEyCAvFJA3USDfnA4K8oTAUfma?=
 =?us-ascii?Q?BC0IVBZOJ2w7mxDYq8h7YJTgpMUHwPzUC1ngYLzHAuMkAfnQyB1HbTTwYEHH?=
 =?us-ascii?Q?DNaR4zKLGrPB1LzHa2G49d6Lars4CUs45y8MhlS3u2W9OcATeMilUWfhd51Y?=
 =?us-ascii?Q?WQ8zsaNxvgmudMAyzuxtEA0HkDyDIH32TGTuITIy4TDcMCnrVI9K46Ssa/h7?=
 =?us-ascii?Q?5VyF818GJr0eLO1aYsT7eIcu2MRrNOxa9N99RR2LVG7z8DVDyc8N1n9/ulO6?=
 =?us-ascii?Q?56o5WIGLm3cv1u1Oy186neB41b6PihGb5xXxF3ReOZR04nqLqheeQImW4diZ?=
 =?us-ascii?Q?blFRBTdcJT87CQXgg/7gZgFFIrIP+FDLS1AJMb6DRR6+4AcvV0LdvK5SieZz?=
 =?us-ascii?Q?9HjbWpIDdiybdJris9APG8v3hPLPGcXPs91j3ccjrdAjQQh5ilvAs1Ol/vHB?=
 =?us-ascii?Q?ag9Oz3St1psS/lfgyp63CksM9IOl0GpEosjP7Xcq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5ddff1-c2b0-424e-afab-08dbdc94a972
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 17:45:25.8661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvRtUkr1uV4ZTIWs0f6Z3FbzYeNcffRN1SFLt6AbGSJMFx56upkM+HqnZ5kHWbTLYeFTY3fMIyPd5FORx+7yRxFkBuYLOh56RrcOSPrRAzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6619
X-OriginatorOrg: intel.com

On 31 October 2023 12:00 PM CET, Jiri Pirko wrote:
>=20
> Mon, Oct 30, 2023 at 05:53:25PM CET, michal.michalik@intel.com wrote:
>>DPLL subsystem integration tests require a module which mimics the
>>behavior of real driver which supports DPLL hardware. To fully test the
>>subsystem the netdevsim is amended with DPLL implementation.
>>
>>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>>---
>> drivers/net/Kconfig               |   1 +
>> drivers/net/netdevsim/Makefile    |   2 +-
>> drivers/net/netdevsim/dpll.c      | 438 ++++++++++++++++++++++++++++++++=
++++++
>> drivers/net/netdevsim/dpll.h      |  81 +++++++
>> drivers/net/netdevsim/netdev.c    |  20 ++
>> drivers/net/netdevsim/netdevsim.h |   4 +
>> 6 files changed, 545 insertions(+), 1 deletion(-)
>> create mode 100644 drivers/net/netdevsim/dpll.c
>> create mode 100644 drivers/net/netdevsim/dpll.h
>>
>>diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>index af0da4b..633ec89 100644
>>--- a/drivers/net/Kconfig
>>+++ b/drivers/net/Kconfig
>>@@ -626,6 +626,7 @@ config NETDEVSIM
>> 	depends on PSAMPLE || PSAMPLE=3Dn
>> 	depends on PTP_1588_CLOCK_MOCK || PTP_1588_CLOCK_MOCK=3Dn
>> 	select NET_DEVLINK
>>+	select DPLL
>> 	help
>> 	  This driver is a developer testing tool and software model that can
>> 	  be used to test various control path networking APIs, especially
>>diff --git a/drivers/net/netdevsim/Makefile b/drivers/net/netdevsim/Makef=
ile
>>index f8de93b..f338ffb 100644
>>--- a/drivers/net/netdevsim/Makefile
>>+++ b/drivers/net/netdevsim/Makefile
>>@@ -3,7 +3,7 @@
>> obj-$(CONFIG_NETDEVSIM) +=3D netdevsim.o
>>=20
>> netdevsim-objs :=3D \
>>-	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o
>>+	netdev.o dev.o ethtool.o fib.o bus.o health.o hwstats.o udp_tunnels.o d=
pll.o
>>=20
>> ifeq ($(CONFIG_BPF_SYSCALL),y)
>> netdevsim-objs +=3D \
>>diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
>>new file mode 100644
>>index 0000000..050f68e
>>--- /dev/null
>>+++ b/drivers/net/netdevsim/dpll.c
>>@@ -0,0 +1,438 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ * Copyright (c) 2023, Intel Corporation.
>>+ * Author: Michal Michalik <michal.michalik@intel.com>
>>+ */
>>+#include "dpll.h"
>>+
>>+static struct dpll_pin_properties *
>>+create_pin_properties(const char *label, enum dpll_pin_type type,
>=20
> Please make sure to follow the namespace prefix notation in your patch
> everywhere, functions, structs, defines.
> "nsim_"
>=20

Thanks - I overlooked that, will change.

>>+		      unsigned long caps, u32 freq_supp_num, u64 fmin, u64 fmax)
>>+{
>>+	struct dpll_pin_frequency *freq_supp;
>>+	struct dpll_pin_properties *pp;
>>+
>>+	pp =3D kzalloc(sizeof(*pp), GFP_KERNEL);
>>+	if (!pp)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	freq_supp =3D kzalloc(sizeof(*freq_supp), GFP_KERNEL);
>>+	if (!freq_supp)
>>+		goto err;
>>+	*freq_supp =3D
>>+		(struct dpll_pin_frequency)DPLL_PIN_FREQUENCY_RANGE(fmin, fmax);
>=20
> Drop the cast.
>=20

Without the cast it does not compile.

>>+
>>+	pp->board_label =3D kasprintf(GFP_KERNEL, "%s_brd", label);
>>+	pp->panel_label =3D kasprintf(GFP_KERNEL, "%s_pnl", label);
>>+	pp->package_label =3D kasprintf(GFP_KERNEL, "%s_pcg", label);
>>+	pp->freq_supported_num =3D freq_supp_num;
>>+	pp->freq_supported =3D freq_supp;
>>+	pp->capabilities =3D caps;
>>+	pp->type =3D type;
>>+
>>+	return pp;
>>+err:
>>+	kfree(pp);
>>+	return ERR_PTR(-ENOMEM);
>>+}
>>+
>>+static struct dpll_pd *create_dpll_pd(int temperature, enum dpll_mode mo=
de)
>>+{
>>+	struct dpll_pd *pd;
>>+
>>+	pd =3D kzalloc(sizeof(*pd), GFP_KERNEL);
>>+	if (!pd)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	pd->temperature =3D temperature;
>>+	pd->mode =3D mode;
>>+
>>+	return pd;
>>+}
>>+
>>+static struct pin_pd *create_pin_pd(u64 frequency, u32 prio,
>>+				    enum dpll_pin_direction direction)
>>+{
>>+	struct pin_pd *pd;
>>+
>>+	pd =3D kzalloc(sizeof(*pd), GFP_KERNEL);
>>+	if (!pd)
>>+		return ERR_PTR(-ENOMEM);
>>+
>>+	pd->state_dpll =3D DPLL_PIN_STATE_DISCONNECTED;
>>+	pd->state_pin =3D DPLL_PIN_STATE_DISCONNECTED;
>>+	pd->frequency =3D frequency;
>>+	pd->direction =3D direction;
>>+	pd->prio =3D prio;
>>+
>>+	return pd;
>>+}
>>+
>>+static int
>>+dds_ops_mode_get(const struct dpll_device *dpll, void *dpll_priv,
>>+		 enum dpll_mode *mode, struct netlink_ext_ack *extack)
>>+{
>>+	*mode =3D ((struct dpll_pd *)(dpll_priv))->mode;
>=20
> Please have variable assigned by dpll_priv instead of this.
> Also, fix in the rest of the code.
>=20

Please excuse me, I don't think I understand what you mean. Do you mean I s=
hould
create a local variable struct dpll_pd and use it for assignment like that?
	```
	struct dpll_pd *pd =3D dpll_priv;
	*mode =3D pd->mode;
	```

>>+	return 0;
>>+};
>>+
>>+static bool
>>+dds_ops_mode_supported(const struct dpll_device *dpll, void *dpll_priv,
>>+		       const enum dpll_mode mode,
>>+		       struct netlink_ext_ack *extack)
>>+{
>>+	return true;
>>+};
>>+
>>+static int
>>+dds_ops_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
>>+			enum dpll_lock_status *status,
>>+			struct netlink_ext_ack *extack)
>>+{
>>+	if (((struct dpll_pd *)dpll_priv)->mode =3D=3D DPLL_MODE_MANUAL)
>>+		*status =3D DPLL_LOCK_STATUS_LOCKED;
>>+	else
>>+		*status =3D DPLL_LOCK_STATUS_UNLOCKED;
>=20
> I don't understand the logic of this function. According to mode you
> return if status is locked or not? For this, you should expose a debugfs
> knob so the user can emulate changes of the HW.
>=20

Assumption was, we are testing the API not trying to simulate the actual DP=
LL HW
behavior. I was going for, the "simpler the better" principle. But since
somebody else might want to use it differently and test more complex scenar=
ios,
I will add debugfs entries for this interaction.

>>+	return 0;
>>+};
>>+
>>+static int
>>+dds_ops_temp_get(const struct dpll_device *dpll, void *dpll_priv, s32 *t=
emp,
>>+		 struct netlink_ext_ack *extack)
>>+{
>>+	*temp =3D ((struct dpll_pd *)dpll_priv)->temperature;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_frequency_set(const struct dpll_pin *pin, void *pin_priv,
>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>+		  const u64 frequency, struct netlink_ext_ack *extack)
>>+{
>>+	((struct pin_pd *)pin_priv)->frequency =3D frequency;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_frequency_get(const struct dpll_pin *pin, void *pin_priv,
>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>+		  u64 *frequency, struct netlink_ext_ack *extack)
>>+{
>>+	*frequency =3D ((struct pin_pd *)pin_priv)->frequency;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_direction_set(const struct dpll_pin *pin, void *pin_priv,
>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>+		  const enum dpll_pin_direction direction,
>>+		  struct netlink_ext_ack *extack)
>>+{
>>+	((struct pin_pd *)pin_priv)->direction =3D direction;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_direction_get(const struct dpll_pin *pin, void *pin_priv,
>>+		  const struct dpll_device *dpll, void *dpll_priv,
>>+		  enum dpll_pin_direction *direction,
>>+		  struct netlink_ext_ack *extack)
>>+{
>>+	*direction =3D ((struct pin_pd *)pin_priv)->direction;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
>>+		     const struct dpll_pin *parent_pin, void *parent_priv,
>>+		     enum dpll_pin_state *state,
>>+		     struct netlink_ext_ack *extack)
>>+{
>>+	*state =3D ((struct pin_pd *)pin_priv)->state_pin;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_state_on_dpll_get(const struct dpll_pin *pin, void *pin_priv,
>>+		      const struct dpll_device *dpll, void *dpll_priv,
>>+		      enum dpll_pin_state *state,
>>+		      struct netlink_ext_ack *extack)
>>+{
>>+	*state =3D ((struct pin_pd *)pin_priv)->state_dpll;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
>>+		     const struct dpll_pin *parent_pin, void *parent_priv,
>>+		     const enum dpll_pin_state state,
>>+		     struct netlink_ext_ack *extack)
>>+{
>>+	((struct pin_pd *)pin_priv)->state_pin =3D state;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>>+		      const struct dpll_device *dpll, void *dpll_priv,
>>+		      const enum dpll_pin_state state,
>>+		      struct netlink_ext_ack *extack)
>>+{
>>+	((struct pin_pd *)pin_priv)->state_dpll =3D state;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
>>+	     const struct dpll_device *dpll, void *dpll_priv,
>>+	     u32 *prio, struct netlink_ext_ack *extack)
>>+{
>>+	*prio =3D ((struct pin_pd *)pin_priv)->prio;
>>+	return 0;
>>+};
>>+
>>+static int
>>+pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>>+	     const struct dpll_device *dpll, void *dpll_priv,
>>+	     const u32 prio, struct netlink_ext_ack *extack)
>>+{
>>+	((struct pin_pd *)pin_priv)->prio =3D prio;
>>+	return 0;
>>+};
>>+
>>+static void
>>+free_pin_properties(struct dpll_pin_properties *pp)
>>+{
>>+	if (pp) {
>=20
> How exactly pp could be null?
>=20

In normal circumstances it seems it cannot, I will remove the check.

>>+		kfree(pp->board_label);
>>+		kfree(pp->panel_label);
>>+		kfree(pp->package_label);
>>+		kfree(pp->freq_supported);
>>+		kfree(pp);
>>+	}
>>+}
>>+
>>+static struct dpll_device_ops dds_ops =3D {
>>+	.mode_get =3D dds_ops_mode_get,
>>+	.mode_supported =3D dds_ops_mode_supported,
>>+	.lock_status_get =3D dds_ops_lock_status_get,
>>+	.temp_get =3D dds_ops_temp_get,
>>+};
>>+
>>+static struct dpll_pin_ops pin_ops =3D {
>>+	.frequency_set =3D pin_frequency_set,
>>+	.frequency_get =3D pin_frequency_get,
>>+	.direction_set =3D pin_direction_set,
>>+	.direction_get =3D pin_direction_get,
>>+	.state_on_pin_get =3D pin_state_on_pin_get,
>>+	.state_on_dpll_get =3D pin_state_on_dpll_get,
>>+	.state_on_pin_set =3D pin_state_on_pin_set,
>>+	.state_on_dpll_set =3D pin_state_on_dpll_set,
>>+	.prio_get =3D pin_prio_get,
>>+	.prio_set =3D pin_prio_set,
>>+};
>>+
>>+int nsim_dpll_init_owner(struct nsim_dpll_info *dpll, int devid)
>>+{
>>+	/* Create EEC DPLL */
>>+	dpll->dpll_e =3D dpll_device_get(DPLLS_CLOCK_ID + devid, EEC_DPLL_DEV,
>=20
> "#define DPLLS_CLOCK_ID 234"
>=20
> You guys always come up with some funky way of making up ids and names.
> Why this can't be randomly generated u64?
>=20

As mentioned, "the simpler the better". Having it randomly generated implie=
s
need of exposing this randomly generated number to tests. Test need to be a=
ble
unambiguously get this clock. But since I will be adding debugfs entries to
change the lock state, I can also add one for returning clock id. I need th=
at
because I'm using more devices per one netdevsim module.

>>+				       THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_e))
>>+		goto dpll_e;
>>+	dpll->dpll_e_pd =3D create_dpll_pd(EEC_DPLL_TEMPERATURE,
>>+					 DPLL_MODE_AUTOMATIC);
>>+	if (IS_ERR(dpll->dpll_e))
>>+		goto dpll_e_pd;
>>+	if (dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &dds_ops,
>>+				 (void *)dpll->dpll_e_pd))
>=20
> Please avoid pointless casts. (void *) cast for arg of type (void *) are
> especially pointless. Please make sure to fix this in the rest of the
> code as well.
>=20

Thanks, will do.

>>+		goto e_reg;
>>+
>>+	/* Create PPS DPLL */
>>+	dpll->dpll_p =3D dpll_device_get(DPLLS_CLOCK_ID + devid, PPS_DPLL_DEV,
>>+				       THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_p))
>>+		goto dpll_p;
>>+	dpll->dpll_p_pd =3D create_dpll_pd(PPS_DPLL_TEMPERATURE,
>>+					 DPLL_MODE_MANUAL);
>>+	if (IS_ERR(dpll->dpll_p_pd))
>>+		goto dpll_p_pd;
>>+	if (dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &dds_ops,
>=20
> You always use "int err" to store the return value of function calls
> returning 0/-EXXX like this one.
>=20

Lesson learned, will fix.

>>+				 (void *)dpll->dpll_p_pd))
>>+		goto p_reg;
>>+
>>+	/* Create first pin (GNSS) */
>>+	dpll->pp_gnss =3D create_pin_properties("GNSS", DPLL_PIN_TYPE_GNSS,
>>+					      PIN_GNSS_CAPABILITIES,
>>+					      1, DPLL_PIN_FREQUENCY_1_HZ,
>>+					      DPLL_PIN_FREQUENCY_1_HZ);
>>+	if (IS_ERR(dpll->pp_gnss))
>>+		goto pp_gnss;
>>+	dpll->p_gnss =3D dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_GNSS,
>>+				    THIS_MODULE,
>>+				    dpll->pp_gnss);
>>+	if (IS_ERR(dpll->p_gnss))
>>+		goto p_gnss;
>>+	dpll->p_gnss_pd =3D create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ,
>>+					PIN_GNSS_PRIORITY,
>>+					DPLL_PIN_DIRECTION_INPUT);
>>+	if (IS_ERR(dpll->p_gnss_pd))
>>+		goto p_gnss_pd;
>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>+			      (void *)dpll->p_gnss_pd))
>>+		goto e_gnss_reg;
>>+
>>+	/* Create second pin (PPS) */
>>+	dpll->pp_pps =3D create_pin_properties("PPS", DPLL_PIN_TYPE_EXT,
>>+					     PIN_PPS_CAPABILITIES,
>>+					     1, DPLL_PIN_FREQUENCY_1_HZ,
>>+					     DPLL_PIN_FREQUENCY_1_HZ);
>>+	if (IS_ERR(dpll->pp_pps))
>>+		goto pp_pps;
>>+	dpll->p_pps =3D dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_PPS, THIS_MODU=
LE,
>>+				   dpll->pp_pps);
>>+	if (IS_ERR(dpll->p_pps))
>>+		goto p_pps;
>>+	dpll->p_pps_pd =3D create_pin_pd(DPLL_PIN_FREQUENCY_1_HZ,
>>+				       PIN_PPS_PRIORITY,
>>+				       DPLL_PIN_DIRECTION_INPUT);
>>+	if (IS_ERR(dpll->p_pps_pd))
>>+		goto p_pps_pd;
>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>+			      (void *)dpll->p_pps_pd))
>>+		goto e_pps_reg;
>>+	if (dpll_pin_register(dpll->dpll_p, dpll->p_pps, &pin_ops,
>>+			      (void *)dpll->p_pps_pd))
>>+		goto p_pps_reg;
>>+
>>+	return 0;
>>+
>>+p_pps_reg:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>+			    (void *)dpll->p_pps_pd);
>>+e_pps_reg:
>>+	kfree(dpll->p_pps_pd);
>>+p_pps_pd:
>>+	dpll_pin_put(dpll->p_pps);
>>+p_pps:
>>+	free_pin_properties(dpll->pp_pps);
>>+pp_pps:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>+			    (void *)dpll->p_gnss_pd);
>>+e_gnss_reg:
>>+	kfree(dpll->p_gnss_pd);
>>+p_gnss_pd:
>>+	dpll_pin_put(dpll->p_gnss);
>>+p_gnss:
>>+	free_pin_properties(dpll->pp_gnss);
>>+pp_gnss:
>>+	dpll_device_unregister(dpll->dpll_p, &dds_ops, (void *)dpll->dpll_p_pd)=
;
>>+p_reg:
>>+	kfree(dpll->dpll_p_pd);
>>+dpll_p_pd:
>>+	dpll_device_put(dpll->dpll_p);
>>+dpll_p:
>>+	dpll_device_unregister(dpll->dpll_e, &dds_ops, (void *)dpll->dpll_e_pd)=
;
>>+e_reg:
>>+	kfree(dpll->dpll_e_pd);
>>+dpll_e_pd:
>>+	dpll_device_put(dpll->dpll_e);
>>+dpll_e:
>>+	return -1;
>>+}
>>+
>>+void nsim_dpll_free_owner(struct nsim_dpll_info *dpll)
>>+{
>>+	/* Free GNSS pin */
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &pin_ops,
>>+			    (void *)dpll->p_gnss_pd);
>>+	dpll_pin_put(dpll->p_gnss);
>>+	free_pin_properties(dpll->pp_gnss);
>>+	kfree(dpll->p_gnss_pd);
>>+
>>+	/* Free PPS pin */
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &pin_ops,
>>+			    (void *)dpll->p_pps_pd);
>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_pps, &pin_ops,
>>+			    (void *)dpll->p_pps_pd);
>>+	dpll_pin_put(dpll->p_pps);
>>+	free_pin_properties(dpll->pp_pps);
>>+	kfree(dpll->p_pps_pd);
>>+
>>+	/* Free DPLL EEC */
>>+	dpll_device_unregister(dpll->dpll_e, &dds_ops, (void *)dpll->dpll_e_pd)=
;
>>+	dpll_device_put(dpll->dpll_e);
>>+	kfree(dpll->dpll_e_pd);
>>+
>>+	/* Free DPLL PPS */
>>+	dpll_device_unregister(dpll->dpll_p, &dds_ops, (void *)dpll->dpll_p_pd)=
;
>>+	dpll_device_put(dpll->dpll_p);
>>+	kfree(dpll->dpll_p_pd);
>>+}
>>+
>>+int nsim_rclk_init(struct nsim_dpll_info *dpll, int devid, unsigned int =
index)
>>+{
>>+	char *name =3D kasprintf(GFP_KERNEL, "RCLK_%i", index);
>>+
>>+	/* Get EEC DPLL */
>>+	dpll->dpll_e =3D dpll_device_get(DPLLS_CLOCK_ID + devid, EEC_DPLL_DEV,
>>+				       THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_e))
>>+		goto dpll;
>>+
>>+	/* Get PPS DPLL */
>>+	dpll->dpll_p =3D dpll_device_get(DPLLS_CLOCK_ID + devid, PPS_DPLL_DEV,
>>+				       THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_p))
>>+		goto dpll;
>>+
>>+	/* Create Recovered clock pin (RCLK) */
>>+	dpll->pp_rclk =3D create_pin_properties(name,
>>+					      DPLL_PIN_TYPE_SYNCE_ETH_PORT,
>>+					      PIN_RCLK_CAPABILITIES, 1, 1e6,
>>+					      125e6);
>>+	if (IS_ERR(dpll->pp_rclk))
>>+		goto dpll;
>>+	dpll->p_rclk =3D dpll_pin_get(DPLLS_CLOCK_ID + devid, PIN_RCLK + index,
>>+				    THIS_MODULE, dpll->pp_rclk);
>>+	if (IS_ERR(dpll->p_rclk))
>>+		goto p_rclk;
>>+	dpll->p_rclk_pd =3D create_pin_pd(DPLL_PIN_FREQUENCY_10_MHZ,
>>+					PIN_RCLK_PRIORITY,
>>+					DPLL_PIN_DIRECTION_INPUT);
>>+	if (IS_ERR(dpll->p_rclk_pd))
>>+		goto p_rclk_pd;
>>+	if (dpll_pin_register(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>+			      (void *)dpll->p_rclk_pd))
>>+		goto dpll_e_reg;
>>+	if (dpll_pin_register(dpll->dpll_p, dpll->p_rclk, &pin_ops,
>>+			      (void *)dpll->p_rclk_pd))
>>+		goto dpll_p_reg;
>>+
>>+	return 0;
>>+
>>+dpll_p_reg:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>+			    (void *)dpll->p_rclk_pd);
>>+dpll_e_reg:
>>+	kfree(dpll->p_rclk_pd);
>>+p_rclk_pd:
>>+	dpll_pin_put(dpll->p_rclk);
>>+p_rclk:
>>+	free_pin_properties(dpll->pp_rclk);
>>+dpll:
>>+	return -1;
>>+}
>>+
>>+void nsim_rclk_free(struct nsim_dpll_info *dpll)
>>+{
>>+	/* Free RCLK pin */
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk, &pin_ops,
>>+			    (void *)dpll->p_rclk_pd);
>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_rclk, &pin_ops,
>>+			    (void *)dpll->p_rclk_pd);
>>+	dpll_pin_put(dpll->p_rclk);
>>+	free_pin_properties(dpll->pp_rclk);
>>+	kfree(dpll->p_rclk_pd);
>>+	dpll_device_put(dpll->dpll_e);
>>+	dpll_device_put(dpll->dpll_p);
>>+}
>>diff --git a/drivers/net/netdevsim/dpll.h b/drivers/net/netdevsim/dpll.h
>>new file mode 100644
>>index 0000000..17db7f7
>>--- /dev/null
>>+++ b/drivers/net/netdevsim/dpll.h
>>@@ -0,0 +1,81 @@
>>+/* SPDX-License-Identifier: GPL-2.0 */
>>+/*
>>+ * Copyright (c) 2023, Intel Corporation.
>>+ * Author: Michal Michalik <michal.michalik@intel.com>
>>+ */
>>+
>>+#ifndef NSIM_DPLL_H
>>+#define NSIM_DPLL_H
>=20
> Why you need a separate header for this? Just put necessary parts in
> netdevsim.h and leave the rest in the .c file.
>=20

Good idea, thanks.

>>+
>>+#include <linux/types.h>
>>+#include <linux/netlink.h>
>>+
>>+#include <linux/dpll.h>
>>+#include <uapi/linux/dpll.h>
>=20
> Why exactly do you need to include uapi header directly?
>=20

You are right - will refactor that.

>>+
>>+#define EEC_DPLL_DEV 0
>>+#define EEC_DPLL_TEMPERATURE 20
>>+#define PPS_DPLL_DEV 1
>>+#define PPS_DPLL_TEMPERATURE 30
>>+#define DPLLS_CLOCK_ID 234
>>+
>>+#define PIN_GNSS 0
>>+#define PIN_GNSS_CAPABILITIES 2 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE */
>>+#define PIN_GNSS_PRIORITY 5
>>+
>>+#define PIN_PPS 1
>>+#define PIN_PPS_CAPABILITIES 7 /* DPLL_PIN_CAPS_DIRECTION_CAN_CHANGE
>>+				* || DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
>>+				* || DPLL_PIN_CAPS_STATE_CAN_CHANGE
>=20
> You are kidding, correct? :)
>=20

Not really, it's written directly because the tests are able to read the va=
lue
from here (they don't understand DPLL subsystem defines). Since we are chan=
ging
most of the code I will try to make the tests access this data differently =
(e.g.
via debugfs).

>>+				*/
>>+#define PIN_PPS_PRIORITY 6
>>+
>>+#define PIN_RCLK 2
>>+#define PIN_RCLK_CAPABILITIES 6 /* DPLL_PIN_CAPS_PRIORITY_CAN_CHANGE
>>+				 * || DPLL_PIN_CAPS_STATE_CAN_CHANGE
>>+				 */
>>+#define PIN_RCLK_PRIORITY 7
>>+
>>+#define EEC_PINS_NUMBER 3
>>+#define PPS_PINS_NUMBER 2
>>+
>>+struct dpll_pd {
>=20
> Have not clue what do you mean by "pd".
>=20

I meant "private data", will change this to something more meaningful.

>>+	enum dpll_mode mode;
>>+	int temperature;
>>+};
>>+
>>+struct pin_pd {
>>+	u64 frequency;
>>+	enum dpll_pin_direction direction;
>>+	enum dpll_pin_state state_pin;
>>+	enum dpll_pin_state state_dpll;
>>+	u32 prio;
>>+};
>>+
>>+struct nsim_dpll_info {
>=20
> Drop "info".
>=20

OK.

>>+	bool owner;
>>+
>>+	struct dpll_device *dpll_e;
>>+	struct dpll_pd *dpll_e_pd;
>>+	struct dpll_device *dpll_p;
>>+	struct dpll_pd *dpll_p_pd;
>>+
>>+	struct dpll_pin_properties *pp_gnss;
>=20
> Why pointer? Just embed the properties struct, no?
>=20

I can change both private data and properties to be embeded.

>>+	struct dpll_pin *p_gnss;
>>+	struct pin_pd *p_gnss_pd;
>>+
>>+	struct dpll_pin_properties *pp_pps;
>>+	struct dpll_pin *p_pps;
>>+	struct pin_pd *p_pps_pd;
>>+
>>+	struct dpll_pin_properties *pp_rclk;
>>+	struct dpll_pin *p_rclk;
>>+	struct pin_pd *p_rclk_pd;
>>+};
>>+
>>+int nsim_dpll_init_owner(struct nsim_dpll_info *dpll, int devid);
>>+void nsim_dpll_free_owner(struct nsim_dpll_info *dpll);
>>+int nsim_rclk_init(struct nsim_dpll_info *dpll, int devid, unsigned int =
index);
>>+void nsim_rclk_free(struct nsim_dpll_info *dpll);
>>+
>>+#endif /* NSIM_DPLL_H */
>>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
>>index aecaf5f..78a936f 100644
>>--- a/drivers/net/netdevsim/netdev.c
>>+++ b/drivers/net/netdevsim/netdev.c
>>@@ -25,6 +25,7 @@
>> #include <net/udp_tunnel.h>
>>=20
>> #include "netdevsim.h"
>>+#include "dpll.h"
>>=20
>> static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_devic=
e *dev)
>> {
>>@@ -344,6 +345,20 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>> 	if (err)
>> 		goto err_ipsec_teardown;
>> 	rtnl_unlock();
>>+
>>+	if (ns->nsim_dev_port->port_index =3D=3D 0) {
>=20
> Does not make any sense to treat port 0 any different.
>=20
> Please, move the init of dpll device to drivers/net/netdevsim/dev.c
> probably somewhere in nsim_drv_probe().
>=20

Great idea - I will do it.

>>+		err =3D nsim_dpll_init_owner(&ns->dpll,
>>+					   ns->nsim_dev->nsim_bus_dev->dev.id);
>>+		if (err)
>>+			goto err_ipsec_teardown;
>>+	}
>>+
>>+	err =3D nsim_rclk_init(&ns->dpll, ns->nsim_dev->nsim_bus_dev->dev.id,
>>+			     ns->nsim_dev_port->port_index);
>=20
> This is not related to netdev directly. Please move the pin init into
> drivers/net/netdevsim/dev.c, probably somewhere inside
> __nsim_dev_port_add()
>=20
> Also, you don't call netdev_dpll_pin_set() and netdev_dpll_pin_clear().
> That is actually what you should call here in netdev initialization.
>=20

Good catch - I will move to dev.c and use netdev_dpll_pin_set/clear()

>>+
>>+	if (err)
>>+		goto err_ipsec_teardown;
>>+
>> 	return 0;
>>=20
>> err_ipsec_teardown:
>>@@ -419,6 +434,11 @@ void nsim_destroy(struct netdevsim *ns)
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
>> 		nsim_udp_tunnels_info_destroy(dev);
>> 	mock_phc_destroy(ns->phc);
>>+
>>+	nsim_rclk_free(&ns->dpll);
>>+	if (ns->nsim_dev_port->port_index =3D=3D 0)
>>+		nsim_dpll_free_owner(&ns->dpll);
>>+
>> 	free_netdev(dev);
>> }
>>=20
>>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/ne=
tdevsim.h
>>index 028c825..3d0138a 100644
>>--- a/drivers/net/netdevsim/netdevsim.h
>>+++ b/drivers/net/netdevsim/netdevsim.h
>>@@ -26,6 +26,8 @@
>> #include <net/xdp.h>
>> #include <net/macsec.h>
>>=20
>>+#include "dpll.h"
>>+
>> #define DRV_NAME	"netdevsim"
>>=20
>> #define NSIM_XDP_MAX_MTU	4000
>>@@ -125,6 +127,8 @@ struct netdevsim {
>> 	} udp_ports;
>>=20
>> 	struct nsim_ethtool ethtool;
>>+
>>+	struct nsim_dpll_info dpll;
>> };
>>=20
>> struct netdevsim *
>>--=20
>>2.9.5
>>


