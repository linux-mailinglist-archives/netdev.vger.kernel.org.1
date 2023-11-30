Return-Path: <netdev+bounces-52611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DC7FF757
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822EDB20CED
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B355793;
	Thu, 30 Nov 2023 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq7+Buzg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CC10F2;
	Thu, 30 Nov 2023 08:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701363345; x=1732899345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ASHYIuwfYTj5DPIMQRAW7h4uuAiH28bBmD80LNv1Xzc=;
  b=Eq7+BuzgPRNsNOqDNbq5A2v2sYgIxE7EZqJpqxwRq3+GUEUiiC1mgAKe
   uzFUXZTJT6YkJXWklWKMGSX/WGLcQKly9dMkjICDIPkSkS4U+qkm3cYi/
   nzoS5DqheQNRYQ8604V3gQljQuEcmd/MgQy/dasD7hBIy2Nbf1g4aSXc0
   EcqxNySPiWd38H2I22kusNHioqzZ15F7ifqZIUngxYvVvkimW+pz86kWK
   ytEtDPgm16Xvqg67EGpLJTSrX6ADvO1wTPGpmc6h7kgIU2pKq/Dyzcdsj
   T1pwOuqVmLb7skcYP8WyyuCJNaw6M0Fmi3irA4YMwmK59x0GUKolqvv+U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="349860"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="349860"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:55:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="892870707"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="892870707"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 08:55:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 08:55:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 08:55:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 08:55:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLW7HDkWZVAYzwb3IJIrWOy8YLIzEaWV50RRAIIl0kgpqo4r98j3WuNFIcOa3CpxYmDX2nHWW2YmCxpmZAL4yfJc/p34W0hF4+zI/MxEZl/4E54ngmR9Y2N5Hs47ILb6yXlGLzFGdOmG5Psza8fPnBwWRqS3anoIwusSrTBT1DC6j5KlYVlCBb04OVFhWynWDQySGdJEhbL1ht6PDDrccdaQy8JDwb8Kdqb80/RzdxMkq9THLiPLXVZkDLbAJOtkhYNZEOr5kMN+LhWDB4ZTiJVgsHWx8SU/7qoL73qaKhUbA8j8m8PUHMGpPu/Ij/1SbwvlFHJ0HsO4Bc6ZPoJPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6XWtUaw2QPrcJFpm8ljpXV/lPS00x/gRX0sCgSRm0g=;
 b=oMiDvhb8/UBOH5MGYf8yM+7UWPmnx32QC1xhMmMB++Ftq18al+bjN7uJMuYqJhVH+cVqAgtquXn8gmklnfk4vYA25Rg+kXdy+n0tt4VTmua4k/72sdyJXxLdllTkjtXRYopX7NA0Ib613n2xH5sqbXhYXGD7tJAHYZRKGaDZ6Yx1HSlZmkPmIrkYXWOII3DobaY4hqR7alhxdg2fn0SSf4jh9aJ+SosXphcnruma69ND/bpIhhR1K2Jue/GXCjt5GHSmlNpfuE3zqLkDWZbuSpokBifxb37gfu/HG0Mmk8POCvGIhlK8kFJXcI8pL1Lrmxh56YuKUkxXwlat8NoE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 16:55:38 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:55:38 +0000
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
Subject: RE: [PATCH RFC net-next v4 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Topic: [PATCH RFC net-next v4 1/2] netdevsim: implement DPLL for
 subsystem selftests
Thread-Index: AQHaHftBRwD08uivs06NIi2OZOmCZbCH1AMAgAmgijA=
Date: Thu, 30 Nov 2023 16:55:37 +0000
Message-ID: <CH3PR11MB841499311E30AD4DDBB2C4F8E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
 <20231123105243.7992-2-michal.michalik@intel.com>
 <ZV9EdiaRh3G7wv1J@nanopsycho>
In-Reply-To: <ZV9EdiaRh3G7wv1J@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|MN2PR11MB4679:EE_
x-ms-office365-filtering-correlation-id: 5b9fd9cb-a1c2-4254-b15d-08dbf1c52da0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4jqL2ZHYF6pLT8mlcx6KZbbE2NM9534ApLMRM/g1xrMEWNUDVC7tHpXLClFGZmgrChPl1nNfuGbqX0CBXd35Bd7u0zUMHeyswSbc8F3/nAuW0HIXZSFS13mQinTIBAVjd0dOOyAwM4XzQt20U8mac/lVlazhz1MDb9VQbpS2q7waTsHDIsTzV5/Dgv/HCYal81mVWBSOxX9NvGZ8oxyaXhp+HiDSO/Z/R2PyeCggrSqa/CdAG1epdxu2VlPbCTOKNux6whlvdZ1HahExPUD663kQx9gqyKGyXgDFviKC3/cVNCJw6qJu7w6gVXBMwXwU6wYm1yYFeq55R1AmoEs+q9egnoIlc22c6RwX9eNluVVvkeDGK0SkEr5MK+dwNPgApaNH2MT+glIr1S8n4esap8vICUGO6LM6DCTXE9US9SvwS9hmOhjoD4NJSxppucML+0RFmYgPTt3uhHpy6DXeHf7++K1KmOukCo5E8D8FxyGGU6Z56mohucGsu1DFAtKmbPalPkNE8DXTT+UBnbs6OB/KiAFDoOrx3Q/2+PJ+N94Uf/dlcf/gy6lvBGJYkgiFZGXgxtxCk/AiTvad2QU+b9453qAjVQyZzVGRIWRGYcET+tmJv/A3bNgaNUiqq81V6i6ricZB4e7DMr0Lokctny2KED5H+4bW6XdEbsfpbg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(7416002)(5660300002)(71200400001)(2906002)(30864003)(478600001)(4326008)(8676002)(86362001)(8936002)(66476007)(52536014)(64756008)(6506007)(6916009)(316002)(54906003)(66556008)(66446008)(66946007)(76116006)(26005)(55016003)(33656002)(83380400001)(82960400001)(122000001)(9686003)(7696005)(53546011)(38100700002)(41300700001)(38070700009)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ecmpzQ2STLqlUs+HUIH1Y7pQRAsIpsjUdoQbtNZg2l+LJFRj+ONQjGI/LW0C?=
 =?us-ascii?Q?58XS7LZy2H8ZAJ77D22ce/reId1wRzTDscb16l7qgB5ouRume4mVqzlV2E3N?=
 =?us-ascii?Q?LWnoT+H2o/Eg1SD23I/pWFt7J75EB/AK320bYw4TQeQ7lBYM+VPpGVs9aINN?=
 =?us-ascii?Q?Hj+BM31EW2zyuhRaTZ/CjElo/7xNq6+uWVOGQqxt/b9II6dV4EJ/dP2puf6/?=
 =?us-ascii?Q?UhZujX+DnCl4qV29p5Qe/3AGJy7NxvhAiNFOxTb8TTdbiI9/NG9LRq+gpn87?=
 =?us-ascii?Q?o+Ozx4mcH4NF5K3LSmLLRS2pEx5s2Ys7qPHXfDkiPN84vXOOZwyX+x6lKG0a?=
 =?us-ascii?Q?dzEj0frMeidcOyO0lkYhEb1Wban4oDw0Niz8BVyYq/3nFIodn61b8Cxu5R+z?=
 =?us-ascii?Q?1KX9s8VDptnN+PEVVS7AB+wzLwlJeNYejV71m0Vbxjcj0Rzel+Qp6NeFVeHA?=
 =?us-ascii?Q?/VjUGng9yxaIx9JnigSTLzzaUXiLEzGOKmYZLz+HGJ3ohkNsVGJU2wWbcPpr?=
 =?us-ascii?Q?w6WY+FpF9A4nUGqrLV67iSONapmfoXV9oQxLc2pXdJF/HWxaHa0bl8qmwZNP?=
 =?us-ascii?Q?IMyCXPUZeX3nvUdtWOHb3qrUj9o8Xqsv0hJEMbYlJvNB0F9MypGraKh6puie?=
 =?us-ascii?Q?QuwirBxinoj7TPBLBRyYduznszZoPJ6w+758MxjjJzZQz3z8ISVvsLTasyAt?=
 =?us-ascii?Q?2eM2mhGCcupRehh8czwY1/q4ozAcdCjTERoLPIXYk1aPdDVrRFUVXOqw8Bia?=
 =?us-ascii?Q?c2GeXTAJemU2thOXEVONgmvGuZxkGUvS9d22bgBI3S5jLhNLLJ86XSUjXlD3?=
 =?us-ascii?Q?ctoN65RTNsbB6hf8KnVixIwsP6Vhv/dH4JzGCArvS1RtL7qDt8pIS6P0R+B8?=
 =?us-ascii?Q?CHR55bOzyeJ3DpvNR28FRLtCHsL3ptzh9vRQB4N/bfckA4/nj0MNmGz0XKRG?=
 =?us-ascii?Q?tePyu0aspNPODmr0Y7W/qeerKkdSYwoD5mkCP80+awCyxa9/WZvW4K5HzwGh?=
 =?us-ascii?Q?P6B+p3k4X6x9mIbaH8ZlDcD5qIdgCKhKcAJsF6ZhIzS7zb2e/4D9kWmBsSe+?=
 =?us-ascii?Q?lqFhQxtNljNWyKPXoVbe+22xe6TCLN1cO5CmlTnhjTS8EPkPRDXFDsPp2bD3?=
 =?us-ascii?Q?+ajvQh2AJhQl9TkeplPQ0ne7jrGZFg4CN3dxhZg1wAow1sGmvoSPdy9o3h3y?=
 =?us-ascii?Q?agwq2yLvJIp+orYvOhJE2dFcAgqtWEARvHU2AKN6pexwg0s1R6YbNsyqLVcS?=
 =?us-ascii?Q?/vlnqWqHH9yLejhJw4FpT598cMm6iPR9GDJkRIyK2MhknCFKUipunOUyN0X5?=
 =?us-ascii?Q?bZ2MJMBlf0XjYrK1BCw8Hx7oHXuuCMvJnY6IMOL9npSeMoWHQ9N1KpW8v3q2?=
 =?us-ascii?Q?xXgV+6feJMV35NaeqHbj5e5nfIeI7/fPM0dL+DSgnrjjaGMCaJdeMrN0vOHy?=
 =?us-ascii?Q?UPgGw4y8rAaJVfgSvyXRwyQh/WTIHNd6Gt6BRVykwcVeDnRDeArf6mGKf074?=
 =?us-ascii?Q?0I8vouAG2b8KhBzc2Ibh7dUDGw7521/BLh0iOlyuNgNoL01jPbyUQN0DGqSw?=
 =?us-ascii?Q?ePfHnnIYhRb2HV/2tuhALy2wTRW38O9R5YdSKAZ6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9fd9cb-a1c2-4254-b15d-08dbf1c52da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 16:55:37.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xhfJ8SdypUGaayUCqsQzyqJcKyMfgVcCTlNFJYGmCUuek7i+K57Iz/AvnzzA2WXCka9IPWa3XK5UrUdr5puVm4CFwXDCaIpm7uIXsMyqt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com

On 23 November 2023 1:24 PM CET, Jiri Pirko wrote:
>=20
> Thu, Nov 23, 2023 at 11:52:42AM CET, michal.michalik@intel.com wrote:
>>DPLL subsystem integration tests require a module which mimics the
>>behavior of real driver which supports DPLL hardware. To fully test the
>>subsystem the netdevsim is amended with DPLL implementation.
>>
>>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>>---
>> drivers/net/Kconfig               |   1 +
>> drivers/net/netdevsim/Makefile    |   2 +-
>> drivers/net/netdevsim/dev.c       |  21 +-
>> drivers/net/netdevsim/dpll.c      | 489 ++++++++++++++++++++++++++++++
>> drivers/net/netdevsim/netdev.c    |  10 +
>> drivers/net/netdevsim/netdevsim.h |  44 +++
>> 6 files changed, 565 insertions(+), 2 deletions(-)
>> create mode 100644 drivers/net/netdevsim/dpll.c
>>
>>diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>index af0da4bb429b..633ec89881ef 100644
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
>>index f8de93bc5f5b..f338ffb34f16 100644
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
>>diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>>index b4d3b9cde8bd..76da4e8aa9af 100644
>>--- a/drivers/net/netdevsim/dev.c
>>+++ b/drivers/net/netdevsim/dev.c
>>@@ -342,6 +342,17 @@ static int nsim_dev_debugfs_init(struct nsim_dev *ns=
im_dev)
>> 	debugfs_create_file("max_vfs", 0600, nsim_dev->ddir,
>> 			    nsim_dev, &nsim_dev_max_vfs_fops);
>>=20
>>+	debugfs_create_u64("dpll_clock_id", 0600,
>=20
> Does not make sense to me to make this writeable. RO please.
> Maybe, this is not needed at all, since the clock id is exposed over
> dpll subsystem. Why do you need it?
>=20

I'll make it read only - that is a good catch.

I assume I'm testing mostly the DPLL netlink interface, so I need to know
exactly what I should expect for particular netdevsim device. In other word=
s,
for example - if I was testing if thermometer is giving good temperature
readings I would need a good reference to compare, possibly other thermomet=
er.
It would make not much sense to compare the readings to itself.
Does it make sense?

>>+			   nsim_dev->ddir, &nsim_dev->dpll.dpll_e_pd.clock_id);
>>+	debugfs_create_u32("dpll_e_status", 0600, nsim_dev->ddir,
>>+			   &nsim_dev->dpll.dpll_e_pd.status);
>>+	debugfs_create_u32("dpll_p_status", 0600, nsim_dev->ddir,
>>+			   &nsim_dev->dpll.dpll_p_pd.status);
>>+	debugfs_create_u32("dpll_e_temp", 0600, nsim_dev->ddir,
>>+			   &nsim_dev->dpll.dpll_e_pd.temperature);
>>+	debugfs_create_u32("dpll_p_temp", 0600, nsim_dev->ddir,
>>+			   &nsim_dev->dpll.dpll_p_pd.temperature);
>>+
>> 	nsim_dev->nodes_ddir =3D debugfs_create_dir("rate_nodes", nsim_dev->ddi=
r);
>> 	if (IS_ERR(nsim_dev->nodes_ddir)) {
>> 		err =3D PTR_ERR(nsim_dev->nodes_ddir);
>>@@ -1601,14 +1612,21 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_=
dev)
>> 	if (err)
>> 		goto err_psample_exit;
>>=20
>>-	err =3D nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
>>+	err =3D nsim_dpll_init_owner(&nsim_dev->dpll, nsim_bus_dev->port_count)=
;
>=20
> "owner" Why? Sounds silly.
>=20

Removing "owner".

>=20
>> 	if (err)
>> 		goto err_hwstats_exit;
>>=20
>>+	err =3D nsim_dev_port_add_all(nsim_dev, nsim_bus_dev->port_count);
>>+	if (err)
>>+		goto err_teardown_dpll;
>>+
>> 	nsim_dev->esw_mode =3D DEVLINK_ESWITCH_MODE_LEGACY;
>> 	devl_unlock(devlink);
>>+
>> 	return 0;
>>=20
>>+err_teardown_dpll:
>>+	nsim_dpll_free_owner(&nsim_dev->dpll);
>> err_hwstats_exit:
>> 	nsim_dev_hwstats_exit(nsim_dev);
>> err_psample_exit:
>>@@ -1656,6 +1674,7 @@ static void nsim_dev_reload_destroy(struct nsim_dev=
 *nsim_dev)
>> 	}
>>=20
>> 	nsim_dev_port_del_all(nsim_dev);
>>+	nsim_dpll_free_owner(&nsim_dev->dpll);
>> 	nsim_dev_hwstats_exit(nsim_dev);
>> 	nsim_dev_psample_exit(nsim_dev);
>> 	nsim_dev_health_exit(nsim_dev);
>>diff --git a/drivers/net/netdevsim/dpll.c b/drivers/net/netdevsim/dpll.c
>>new file mode 100644
>>index 000000000000..26a8b0f3be16
>>--- /dev/null
>>+++ b/drivers/net/netdevsim/dpll.c
>>@@ -0,0 +1,489 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ * Copyright (c) 2023, Intel Corporation.
>>+ * Author: Michal Michalik <michal.michalik@intel.com>
>>+ */
>>+#include "netdevsim.h"
>>+
>>+#define EEC_DPLL_DEV 0
>>+#define EEC_DPLL_TEMPERATURE 20
>>+#define PPS_DPLL_DEV 1
>>+#define PPS_DPLL_TEMPERATURE 30
>>+
>>+#define PIN_GNSS 0
>>+#define PIN_GNSS_CAPABILITIES DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
>>+#define PIN_GNSS_PRIORITY 5
>>+
>>+#define PIN_PPS 1
>>+#define PIN_PPS_CAPABILITIES                          \
>>+	(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE | \
>>+	 DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |  \
>>+	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
>>+#define PIN_PPS_PRIORITY 6
>>+
>>+#define PIN_RCLK 2
>>+#define PIN_RCLK_CAPABILITIES                        \
>>+	(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE | \
>>+	 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE)
>>+#define PIN_RCLK_PRIORITY 7
>>+
>>+#define EEC_PINS_NUMBER 3
>>+#define PPS_PINS_NUMBER 2
>=20
> Please maintain proper prefix for defines as well.
>=20

Ok - makes sense.

>=20
> Also, for functions and struct, make sure you have "nsim_dpll_" prefix.
>=20

Ok.

>=20
>>+
>>+static int nsim_fill_pin_properties(struct dpll_pin_properties *pp,
>>+				    const char *label, enum dpll_pin_type type,
>>+				    unsigned long caps, u32 freq_supp_num,
>>+				    u64 fmin, u64 fmax)
>>+{
>>+	struct dpll_pin_frequency *freq_supp;
>>+
>>+	freq_supp =3D kzalloc(sizeof(*freq_supp), GFP_KERNEL);
>>+	if (!freq_supp)
>>+		goto freq_supp;
>>+	freq_supp->min =3D fmin;
>>+	freq_supp->max =3D fmax;
>>+
>>+	pp->board_label =3D kasprintf(GFP_KERNEL, "%s_brd", label);
>>+	if (!pp->board_label)
>>+		goto board_label;
>>+	pp->panel_label =3D kasprintf(GFP_KERNEL, "%s_pnl", label);
>>+	if (!pp->panel_label)
>>+		goto panel_label;
>>+	pp->package_label =3D kasprintf(GFP_KERNEL, "%s_pcg", label);
>>+	if (!pp->package_label)
>>+		goto package_label;
>>+	pp->freq_supported_num =3D freq_supp_num;
>>+	pp->freq_supported =3D freq_supp;
>>+	pp->capabilities =3D caps;
>>+	pp->type =3D type;
>>+
>>+	return 0;
>>+
>>+package_label:
>>+	kfree(pp->panel_label);
>>+panel_label:
>>+	kfree(pp->board_label);
>>+board_label:
>>+	kfree(freq_supp);
>>+freq_supp:
>>+	return -ENOMEM;
>>+}
>>+
>>+static void nsim_fill_pin_pd(struct nsim_pin_priv_data *pd, u64 frequenc=
y,
>>+			     u32 prio, enum dpll_pin_direction direction)
>>+{
>>+	pd->state_dpll =3D DPLL_PIN_STATE_DISCONNECTED;
>>+	pd->state_pin =3D DPLL_PIN_STATE_DISCONNECTED;
>>+	pd->frequency =3D frequency;
>>+	pd->direction =3D direction;
>>+	pd->prio =3D prio;
>>+}
>>+
>>+static int nsim_dds_ops_mode_get(const struct dpll_device *dpll,
>>+				 void *dpll_priv, enum dpll_mode *mode,
>>+				 struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>>+	*mode =3D pd->mode;
>>+	return 0;
>>+};
>>+
>>+static bool nsim_dds_ops_mode_supported(const struct dpll_device *dpll,
>>+					void *dpll_priv,
>>+					const enum dpll_mode mode,
>>+					struct netlink_ext_ack *extack)
>>+{
>>+	return true;
>=20
> This should return true only for what is returned in mode_get.
> This op is a leftover, I will try to remove it soon.
>

I assumed all modes are supported - leaving it as is till removing by you.
=20
>
>>+};
>>+
>>+static int nsim_dds_ops_lock_status_get(const struct dpll_device *dpll,
>>+					void *dpll_priv,
>>+					enum dpll_lock_status *status,
>>+					struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>>+
>>+	*status =3D pd->status;
>>+	return 0;
>>+};
>>+
>>+static int nsim_dds_ops_temp_get(const struct dpll_device *dpll,
>>+				 void *dpll_priv, s32 *temp,
>>+				 struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_dpll_priv_data *pd =3D dpll_priv;
>>+
>>+	*temp =3D pd->temperature;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_frequency_set(const struct dpll_pin *pin, void *pin_=
priv,
>>+				  const struct dpll_device *dpll,
>>+				  void *dpll_priv, const u64 frequency,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	pd->frequency =3D frequency;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_frequency_get(const struct dpll_pin *pin, void *pin_=
priv,
>>+				  const struct dpll_device *dpll,
>>+				  void *dpll_priv, u64 *frequency,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	*frequency =3D pd->frequency;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_direction_set(const struct dpll_pin *pin, void *pin_=
priv,
>>+				  const struct dpll_device *dpll,
>>+				  void *dpll_priv,
>>+				  const enum dpll_pin_direction direction,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	pd->direction =3D direction;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_direction_get(const struct dpll_pin *pin, void *pin_=
priv,
>>+				  const struct dpll_device *dpll,
>>+				  void *dpll_priv,
>>+				  enum dpll_pin_direction *direction,
>>+				  struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	*direction =3D pd->direction;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_state_on_pin_get(const struct dpll_pin *pin, void *p=
in_priv,
>>+				     const struct dpll_pin *parent_pin,
>>+				     void *parent_priv,
>>+				     enum dpll_pin_state *state,
>>+				     struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	*state =3D pd->state_pin;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_state_on_dpll_get(const struct dpll_pin *pin,
>>+				      void *pin_priv,
>>+				      const struct dpll_device *dpll,
>>+				      void *dpll_priv,
>>+				      enum dpll_pin_state *state,
>>+				      struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	*state =3D pd->state_dpll;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_state_on_pin_set(const struct dpll_pin *pin, void *p=
in_priv,
>>+				     const struct dpll_pin *parent_pin,
>>+				     void *parent_priv,
>>+				     const enum dpll_pin_state state,
>>+				     struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	pd->state_pin =3D state;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_state_on_dpll_set(const struct dpll_pin *pin,
>>+				      void *pin_priv,
>>+				      const struct dpll_device *dpll,
>>+				      void *dpll_priv,
>>+				      const enum dpll_pin_state state,
>>+				      struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	pd->state_dpll =3D state;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
>>+			     const struct dpll_device *dpll, void *dpll_priv,
>>+			     u32 *prio, struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	*prio =3D pd->prio;
>>+	return 0;
>>+};
>>+
>>+static int nsim_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
>>+			     const struct dpll_device *dpll, void *dpll_priv,
>>+			     const u32 prio, struct netlink_ext_ack *extack)
>>+{
>>+	struct nsim_pin_priv_data *pd =3D pin_priv;
>>+
>>+	pd->prio =3D prio;
>>+	return 0;
>>+};
>>+
>>+static void nsim_free_pin_properties(struct dpll_pin_properties *pp)
>>+{
>>+	kfree(pp->board_label);
>>+	kfree(pp->panel_label);
>>+	kfree(pp->package_label);
>>+	kfree(pp->freq_supported);
>>+}
>>+
>>+static struct dpll_device_ops nsim_dds_ops =3D {
>=20
> const
>=20

Adding, thanks.

>=20
>>+	.mode_get =3D nsim_dds_ops_mode_get,
>>+	.mode_supported =3D nsim_dds_ops_mode_supported,
>>+	.lock_status_get =3D nsim_dds_ops_lock_status_get,
>>+	.temp_get =3D nsim_dds_ops_temp_get,
>>+};
>>+
>>+static struct dpll_pin_ops nsim_pin_ops =3D {
>=20
> const
>=20

Adding, thanks.

>=20
>>+	.frequency_set =3D nsim_pin_frequency_set,
>>+	.frequency_get =3D nsim_pin_frequency_get,
>>+	.direction_set =3D nsim_pin_direction_set,
>>+	.direction_get =3D nsim_pin_direction_get,
>>+	.state_on_pin_get =3D nsim_pin_state_on_pin_get,
>>+	.state_on_dpll_get =3D nsim_pin_state_on_dpll_get,
>>+	.state_on_pin_set =3D nsim_pin_state_on_pin_set,
>>+	.state_on_dpll_set =3D nsim_pin_state_on_dpll_set,
>>+	.prio_get =3D nsim_pin_prio_get,
>>+	.prio_set =3D nsim_pin_prio_set,
>>+};
>>+
>>+int nsim_dpll_init_owner(struct nsim_dpll *dpll, unsigned int ports_coun=
t)
>>+{
>>+	u64 clock_id;
>>+	int err;
>>+
>>+	get_random_bytes(&clock_id, sizeof(clock_id));
>>+
>>+	/* Create EEC DPLL */
>>+	dpll->dpll_e =3D dpll_device_get(clock_id, EEC_DPLL_DEV, THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_e))
>>+		return -EFAULT;
>>+
>>+	dpll->dpll_e_pd.temperature =3D EEC_DPLL_TEMPERATURE;
>>+	dpll->dpll_e_pd.mode =3D DPLL_MODE_AUTOMATIC;
>>+	dpll->dpll_e_pd.clock_id =3D clock_id;
>>+	dpll->dpll_e_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>>+
>>+	err =3D dpll_device_register(dpll->dpll_e, DPLL_TYPE_EEC, &nsim_dds_ops=
,
>>+				   &dpll->dpll_e_pd);
>>+	if (err)
>>+		goto e_reg;
>>+
>>+	/* Create PPS DPLL */
>>+	dpll->dpll_p =3D dpll_device_get(clock_id, PPS_DPLL_DEV, THIS_MODULE);
>>+	if (IS_ERR(dpll->dpll_p))
>>+		goto dpll_p;
>>+
>>+	dpll->dpll_p_pd.temperature =3D PPS_DPLL_TEMPERATURE;
>>+	dpll->dpll_p_pd.mode =3D DPLL_MODE_MANUAL;
>>+	dpll->dpll_p_pd.clock_id =3D clock_id;
>>+	dpll->dpll_p_pd.status =3D DPLL_LOCK_STATUS_UNLOCKED;
>>+
>>+	err =3D dpll_device_register(dpll->dpll_p, DPLL_TYPE_PPS, &nsim_dds_ops=
,
>>+				   &dpll->dpll_p_pd);
>>+	if (err)
>>+		goto p_reg;
>>+
>>+	/* Create first pin (GNSS) */
>>+	err =3D nsim_fill_pin_properties(&dpll->pp_gnss, "GNSS",
>=20
> It's of type GNSS. No need to provide redundant label. Please remove.
>

To be frank, I don't see anything bad with using the label. Removed package=
 and
panel labels, though. Left only board label for testing purposes.

>=20
>>+				       DPLL_PIN_TYPE_GNSS,
>>+				       PIN_GNSS_CAPABILITIES, 1,
>>+				       DPLL_PIN_FREQUENCY_1_HZ,
>>+				       DPLL_PIN_FREQUENCY_1_HZ);
>>+	if (err)
>>+		goto pp_gnss;
>>+	dpll->p_gnss =3D
>>+		dpll_pin_get(clock_id, PIN_GNSS, THIS_MODULE, &dpll->pp_gnss);
>>+	if (IS_ERR(dpll->p_gnss))
>>+		goto p_gnss;
>>+	nsim_fill_pin_pd(&dpll->p_gnss_pd, DPLL_PIN_FREQUENCY_1_HZ,
>>+			 PIN_GNSS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>>+	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>>+				&dpll->p_gnss_pd);
>>+	if (err)
>>+		goto e_gnss_reg;
>>+
>>+	/* Create second pin (PPS) */
>>+	err =3D nsim_fill_pin_properties(&dpll->pp_pps, "PPS", DPLL_PIN_TYPE_EX=
T,
>=20
> Label "pps"? That does not sound correct. Please fix.
>

Why do you think it does not sound correct? For me it's perfectly fine. Ext=
ernal
pulse per second pin set with only DPLL_PIN_FREQUENCY_1_HZ.

>=20
>>+				       PIN_PPS_CAPABILITIES, 1,
>>+				       DPLL_PIN_FREQUENCY_1_HZ,
>>+				       DPLL_PIN_FREQUENCY_1_HZ);
>>+	if (err)
>>+		goto pp_pps;
>>+	dpll->p_pps =3D
>>+		dpll_pin_get(clock_id, PIN_PPS, THIS_MODULE, &dpll->pp_pps);
>>+	if (IS_ERR(dpll->p_pps)) {
>>+		err =3D -EFAULT;
>>+		goto p_pps;
>>+	}
>>+	nsim_fill_pin_pd(&dpll->p_pps_pd, DPLL_PIN_FREQUENCY_1_HZ,
>>+			 PIN_PPS_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>>+	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>>+				&dpll->p_pps_pd);
>>+	if (err)
>>+		goto e_pps_reg;
>>+	err =3D dpll_pin_register(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
>>+				&dpll->p_pps_pd);
>>+	if (err)
>>+		goto p_pps_reg;
>>+
>>+	dpll->pp_rclk =3D
>>+		kcalloc(ports_count, sizeof(*dpll->pp_rclk), GFP_KERNEL);
>>+	dpll->p_rclk =3D kcalloc(ports_count, sizeof(*dpll->p_rclk), GFP_KERNEL=
);
>>+	dpll->p_rclk_pd =3D
>>+		kcalloc(ports_count, sizeof(*dpll->p_rclk_pd), GFP_KERNEL);
>>+
>>+	return 0;
>>+
>>+p_pps_reg:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>>+			    &dpll->p_pps_pd);
>>+e_pps_reg:
>>+	dpll_pin_put(dpll->p_pps);
>>+p_pps:
>>+	nsim_free_pin_properties(&dpll->pp_pps);
>>+pp_pps:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>>+			    &dpll->p_gnss_pd);
>>+e_gnss_reg:
>>+	dpll_pin_put(dpll->p_gnss);
>>+p_gnss:
>>+	nsim_free_pin_properties(&dpll->pp_gnss);
>>+pp_gnss:
>>+	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
>>+p_reg:
>>+	dpll_device_put(dpll->dpll_p);
>>+dpll_p:
>>+	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
>>+e_reg:
>=20
> Please have error labels named properly. See:
> git grep goto drivers/net/netdevsim/
>=20

Got it - will try to align to it more.

>=20
>>+	dpll_device_put(dpll->dpll_e);
>>+	return err;
>>+}
>>+
>>+void nsim_dpll_free_owner(struct nsim_dpll *dpll)
>>+{
>>+	/* Free GNSS pin */
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_gnss, &nsim_pin_ops,
>>+			    &dpll->p_gnss_pd);
>>+	dpll_pin_put(dpll->p_gnss);
>>+	nsim_free_pin_properties(&dpll->pp_gnss);
>>+
>>+	/* Free PPS pin */
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_pps, &nsim_pin_ops,
>>+			    &dpll->p_pps_pd);
>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_pps, &nsim_pin_ops,
>>+			    &dpll->p_pps_pd);
>>+	dpll_pin_put(dpll->p_pps);
>>+	nsim_free_pin_properties(&dpll->pp_pps);
>>+
>>+	/* Free DPLL EEC */
>>+	dpll_device_unregister(dpll->dpll_e, &nsim_dds_ops, &dpll->dpll_e_pd);
>>+	dpll_device_put(dpll->dpll_e);
>>+
>>+	/* Free DPLL PPS */
>>+	dpll_device_unregister(dpll->dpll_p, &nsim_dds_ops, &dpll->dpll_p_pd);
>>+	dpll_device_put(dpll->dpll_p);
>>+
>>+	kfree(dpll->pp_rclk);
>>+	kfree(dpll->p_rclk);
>>+	kfree(dpll->p_rclk_pd);
>>+}
>>+
>>+int nsim_rclk_init(struct netdevsim *ns)
>>+{
>>+	struct nsim_dpll *dpll;
>>+	unsigned int index;
>>+	char *name;
>>+	int err;
>>+
>>+	index =3D ns->nsim_dev_port->port_index;
>>+	dpll =3D &ns->nsim_dev->dpll;
>>+	err =3D -ENOMEM;
>>+
>>+	name =3D kasprintf(GFP_KERNEL, "RCLK_%i", index);
>=20
> Not good for anything. It is not really a label. The link from netdevice
> to this pin. Please remove this label entirely.
>

Not true, my intention is to test the DPLL netlink interface including filt=
ering
by label. Therefore I need it.

>=20
>>+	if (!name)
>>+		goto err;
>>+
>>+	/* Get EEC DPLL */
>>+	if (IS_ERR(dpll->dpll_e))
>>+		goto dpll;
>>+
>>+	/* Get PPS DPLL */
>>+	if (IS_ERR(dpll->dpll_p))
>>+		goto dpll;
>>+
>>+	/* Create Recovered clock pin (RCLK) */
>>+	nsim_fill_pin_properties(&dpll->pp_rclk[index], name,
>>+				 DPLL_PIN_TYPE_SYNCE_ETH_PORT,
>>+				 PIN_RCLK_CAPABILITIES, 1, 1e6, 125e6);
>>+	dpll->p_rclk[index] =3D dpll_pin_get(dpll->dpll_e_pd.clock_id,
>>+					   PIN_RCLK + index, THIS_MODULE,
>>+					   &dpll->pp_rclk[index]);
>>+	if (IS_ERR(dpll->p_rclk[index]))
>>+		goto p_rclk;
>>+	nsim_fill_pin_pd(&dpll->p_rclk_pd[index], DPLL_PIN_FREQUENCY_10_MHZ,
>>+			 PIN_RCLK_PRIORITY, DPLL_PIN_DIRECTION_INPUT);
>>+	err =3D dpll_pin_register(dpll->dpll_e, dpll->p_rclk[index],
>>+				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
>>+	if (err)
>>+		goto dpll_e_reg;
>>+	err =3D dpll_pin_register(dpll->dpll_p, dpll->p_rclk[index],
>>+				&nsim_pin_ops, &dpll->p_rclk_pd[index]);
>>+	if (err)
>>+		goto dpll_p_reg;
>>+
>>+	netdev_dpll_pin_set(ns->netdev, dpll->p_rclk[index]);
>>+
>>+	kfree(name);
>>+	return 0;
>>+
>>+dpll_p_reg:
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
>>+			    &dpll->p_rclk_pd[index]);
>>+dpll_e_reg:
>>+	dpll_pin_put(dpll->p_rclk[index]);
>>+p_rclk:
>>+	nsim_free_pin_properties(&dpll->pp_rclk[index]);
>>+dpll:
>>+	kfree(name);
>>+err:
>>+	return err;
>>+}
>>+
>>+void nsim_rclk_free(struct netdevsim *ns)
>>+{
>>+	struct nsim_dpll *dpll;
>>+	unsigned int index;
>>+
>>+	index =3D ns->nsim_dev_port->port_index;
>>+	dpll =3D &ns->nsim_dev->dpll;
>>+
>>+	if (IS_ERR(dpll->dpll_e))
>>+		return;
>>+
>>+	if (IS_ERR(dpll->dpll_p))
>>+		return;
>>+
>>+	/* Free RCLK pin */
>>+	netdev_dpll_pin_clear(ns->netdev);
>>+	dpll_pin_unregister(dpll->dpll_e, dpll->p_rclk[index], &nsim_pin_ops,
>>+			    &dpll->p_rclk_pd[index]);
>>+	dpll_pin_unregister(dpll->dpll_p, dpll->p_rclk[index], &nsim_pin_ops,
>>+			    &dpll->p_rclk_pd[index]);
>>+	dpll_pin_put(dpll->p_rclk[index]);
>>+	nsim_free_pin_properties(&dpll->pp_rclk[index]);
>>+}
>>diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netde=
v.c
>>index aecaf5f44374..3c604d8608a3 100644
>>--- a/drivers/net/netdevsim/netdev.c
>>+++ b/drivers/net/netdevsim/netdev.c
>>@@ -344,8 +344,15 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
>> 	if (err)
>> 		goto err_ipsec_teardown;
>> 	rtnl_unlock();
>>+
>>+	err =3D nsim_rclk_init(ns);
>>+	if (err)
>>+		goto err_netdevice_unregister;
>>+
>> 	return 0;
>>=20
>>+err_netdevice_unregister:
>>+	unregister_netdevice(ns->netdev);
>> err_ipsec_teardown:
>> 	nsim_ipsec_teardown(ns);
>> 	nsim_macsec_teardown(ns);
>>@@ -419,6 +426,9 @@ void nsim_destroy(struct netdevsim *ns)
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
>> 		nsim_udp_tunnels_info_destroy(dev);
>> 	mock_phc_destroy(ns->phc);
>>+
>>+	nsim_rclk_free(ns);
>>+
>> 	free_netdev(dev);
>> }
>>=20
>>diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/ne=
tdevsim.h
>>index 028c825b86db..bd798a4cf49f 100644
>>--- a/drivers/net/netdevsim/netdevsim.h
>>+++ b/drivers/net/netdevsim/netdevsim.h
>>@@ -25,6 +25,8 @@
>> #include <net/udp_tunnel.h>
>> #include <net/xdp.h>
>> #include <net/macsec.h>
>>+#include <linux/dpll.h>
>>+#include <linux/random.h>
>>=20
>> #define DRV_NAME	"netdevsim"
>>=20
>>@@ -90,6 +92,42 @@ struct nsim_ethtool {
>> 	struct ethtool_fecparam fec;
>> };
>>=20
>>+struct nsim_dpll_priv_data {
>>+	enum dpll_mode mode;
>>+	int temperature;
>>+	u64 clock_id;
>>+	enum dpll_lock_status status;
>>+};
>>+
>>+struct nsim_pin_priv_data {
>=20
> You are missing "dpll" here. Also the "priv_data" suffix looks silly.
> Please just have:
> struct nsim_dpll
> struct nsim_dpll_pin
> struct nsim_dpll_device
>=20

Seems logical, simplifying.

>=20
>>+	u64 frequency;
>>+	enum dpll_pin_direction direction;
>>+	enum dpll_pin_state state_pin;
>>+	enum dpll_pin_state state_dpll;
>>+	u32 prio;
>>+};
>>+
>>+struct nsim_dpll {
>>+	bool owner;
>=20
> Never used.
>=20

Removing.

>=20
>>+
>>+	struct dpll_device *dpll_e;
>>+	struct nsim_dpll_priv_data dpll_e_pd;
>>+	struct dpll_device *dpll_p;
>>+	struct nsim_dpll_priv_data dpll_p_pd;
>>+
>>+	struct dpll_pin_properties pp_gnss;
>>+	struct dpll_pin *p_gnss;
>>+	struct nsim_pin_priv_data p_gnss_pd;
>>+
>>+	struct dpll_pin_properties pp_pps;
>>+	struct dpll_pin *p_pps;
>>+	struct nsim_pin_priv_data p_pps_pd;
>>+
>>+	struct dpll_pin_properties *pp_rclk;
>>+	struct dpll_pin **p_rclk;
>>+	struct nsim_pin_priv_data *p_rclk_pd;
>>+};
>>+
>> struct netdevsim {
>> 	struct net_device *netdev;
>> 	struct nsim_dev *nsim_dev;
>>@@ -323,6 +361,7 @@ struct nsim_dev {
>> 	} udp_ports;
>> 	struct nsim_dev_psample *psample;
>> 	u16 esw_mode;
>>+	struct nsim_dpll dpll;
>> };
>>=20
>> static inline bool nsim_esw_mode_is_legacy(struct nsim_dev *nsim_dev)
>>@@ -415,5 +454,10 @@ struct nsim_bus_dev {
>> 	bool init;
>> };
>>=20
>>+int nsim_dpll_init_owner(struct nsim_dpll *dpll, unsigned int ports_coun=
t);
>>+void nsim_dpll_free_owner(struct nsim_dpll *dpll);
>>+int nsim_rclk_init(struct netdevsim *ns);
>>+void nsim_rclk_free(struct netdevsim *ns);
>=20
> _dpll_, please make the naming consitent for all dpll
> function/struct/define names
>=20

Added _dpll_ everywhere (I hope).

>=20
>>+
>> int nsim_bus_init(void);
>> void nsim_bus_exit(void);
>>--=20
>>2.39.3
>>
>>

