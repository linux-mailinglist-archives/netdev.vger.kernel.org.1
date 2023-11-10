Return-Path: <netdev+bounces-47028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85D37E7A71
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A689CB20DC4
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26BD26B;
	Fri, 10 Nov 2023 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYe+m+wl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BD1094C
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:07:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33EAFB5
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699607226; x=1731143226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uG3oy9+c/r3Qs1MGJ9FB/CjS1ojLtwcB4Z5JTPurAUk=;
  b=TYe+m+wlT4oJ5brG8/1FT1qoywcDZ3n3ORgdgQfAUxE79WOwASXml2vb
   WEPTdewQ4eUPPxW5rBlDD+LfFSJlwdOIJ+RK5cPGbk6MZe+CHZAd5yOTS
   WFBevXY9BccZ5zp/WtT3LZYr9qlyZRGccCwQJabyqmeHFkQnoeGtK+xb/
   StcXZ8akwd10BjseLAIHEqGAfuVSgvJ94LGVPA7U0klTW8t80vQiVrDIE
   sLbi355Lf/ubDD027dWEblvOkfATl8P0Yc9pyUrOGqTNS4LvktOWRjZma
   reD5AWQJsWaI6RcUqRAElR2g6G8dcnpgowThsW/g82A5tFueVc9g2HOYv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389016805"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="389016805"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 01:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="887310739"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="887310739"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 01:07:04 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:07:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 01:07:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 01:07:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 01:07:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzCGUblzSIeAZ46W7Mqjwv40ztR9DWizKzeClhPLFHu0tv+HhqxPd8UwFgoL0vTTYrOfWAUuj9VE3U+ZOz4ES+T4GkgcKtEeexHSyqWcnb0jg/C2MyZDMZYxhGWod83jb/m0iuXn5UMl+mQkb1mSiNjpAIpmdFWpCRIPjvg8QBHNI5K0IDTfd7gEkwzm8AYgnumA6Sqs8i+FRaVM6mmpm2rG/nVapEV4r/6s2CXgZI/s0sSP6VeB6Dx9Od4Cqyf6Zrtoh/Gf/T5XP2AqHGxq26SArfOMPabQTG5msoFuyS9vO1YAJjgs/kF67OaFPutyaIDuXuXaccBnG/EzshYH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZncLk3HFGUXKsCpEihrEwjxUHsrO+UjLnAEpdjxUv0=;
 b=X4mr+AWn8m9UV1DcUp61bvv0yU1bl08+huPK0fzaNnbMIcFV5C3H09HPHZR5i57sHXdBXSKcxrx2HJOn6v1Xj1jpV4Ksh8W3XLxjZ4UftKggpj/50TdEsLLTPGKzP4VWbW8nb8kbcUdRZFeQTBIR8yMbX5K4X+imo6W39lmR5RHmgrCWrfEjYS0WnXzt0kIegH5T+ezN13/BfgdmatEq9zZp0wJ+9U26ExXCL+lGuN6Sk7xUcgfCe0YrWMNirtIaWUBJICEmawm40nh6b0MkXSHmgpvSb7raBxBvnOqIQjGAcMiJVoxyCuCwX0tSuXPpjAC3Diz6PQ+p3lDkSlW0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Fri, 10 Nov 2023 09:07:00 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 09:07:00 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer issues
Thread-Topic: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer
 issues
Thread-Index: AQHaEi9OB4zvczpCGUaIr1usLpOLxrBx0M4AgABky0CAABUngIAAWuQQgAB53QCAACV4EA==
Date: Fri, 10 Nov 2023 09:06:59 +0000
Message-ID: <DM6PR11MB4657DE812ADB8C5079705DC99BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
 <DM6PR11MB465721130A49C22D77E42A799BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fzzmmxjnsNW0n@nanopsycho>
 <DM6PR11MB4657209FFC300E207E600F3F9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SSClU6Ijn3M7B@nanopsycho>
In-Reply-To: <ZU3SSClU6Ijn3M7B@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|PH7PR11MB7964:EE_
x-ms-office365-filtering-correlation-id: 6207832f-3d1f-42e4-c6ff-08dbe1cc6592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4Jeske7Dd0PAh3CbCKZvPOyGkkAQAKs4YUSuzDUBZwhV4a6hwxp/8RihRAKMUSMn/38TezkPEAL8smF/dqPdq5EDm76dX3QDZIrqHrGwdiBMEtfeZtpvqQP+dhldLzORULQKbpyImo0nVRW8Cb0l2JdkysnFSOneoLRx0QY6Spwnjml1UQiKDXFo/nV0pwR07e88pdcSV7Z3xGAbCj2Itd2eCmEA8vdNb5nKNuqDQVHiUl+daxBQ38GPjLIMyhgiRRdozdSicNqnxY+3YIDGSUgneeu1JYCYCgPsM23lZPTBarYv0VZwssWg6fn6tahufh8hs4IojpKixzAKWkXsfCTcnzV4jp44WbG+w/wVlHQM2v9eANJZ1XdzrNxM4duA23dYgB7cU7xxDMIrz3mZvgQiloRSFoZQBM+eRQ1t3WvMVY9MYFl6lo/4r61q6tX9FhCfp7qCWREfGl2xsTpee1SwQLxrYnGjsnNbkXGg+OiuxqHBcfvJOQZWuq2s77EE0WQ4H+gkRtt9V4FS+SxQ0Vq+fodfxccqeLJRYPdOZqxYI90fztWqlAIknwA6kbt2TiiZ8SPcOJekjE/dXc4feVcR2LsNaOBNyGtxQCG8qJqg83n4EopLG8rCPhXuXec
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(2906002)(38070700009)(4326008)(7696005)(6506007)(55016003)(9686003)(52536014)(38100700002)(122000001)(82960400001)(33656002)(45080400002)(54906003)(83380400001)(316002)(66476007)(8936002)(41300700001)(6916009)(64756008)(66446008)(26005)(8676002)(76116006)(66946007)(86362001)(5660300002)(71200400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YhHHgZMYX56z8tXqnDJKjh8lLocb7D7SaeW/s7mvS2bGG6uIpM/ZT0wFy8X+?=
 =?us-ascii?Q?8C0Y0fUhUtcRZWpFvEdrDH36XRsSOPBu6YtGrm5jWu64Oy7LfussfnEdXLcl?=
 =?us-ascii?Q?zvA99B5MVEmWfGmql0nYJ5If29A8YHKm/xaoDxBS8ir3IUH3n6XgPqAd6WwX?=
 =?us-ascii?Q?szEnLoOI0pkMJ945LE3h4O4kgV3v9q1TM73H0JodgUP75Ks8KY1VXa9lbxBg?=
 =?us-ascii?Q?xHiQmU5qvRziqoHyBZZaK34BeDsGu9XiC9FOHA5MGM9TB26wA6FizKiWGoTh?=
 =?us-ascii?Q?PzIJB171Q9p8guiDHsmvTpY9IGt5GGep7VVxPLjfdZ5QMAP4YemyumX4JyIo?=
 =?us-ascii?Q?otv8nGGs9lcj1zFSOd+LuE4MvAU+XZGgOr0z6ZT0WphoGyPYUO6ikUtl4sPg?=
 =?us-ascii?Q?7AW9zkZcUZRVS3Sjqbz+I8NoQdMYn8ynvkwcFpkv389/yOd0T5xebM8P2IHX?=
 =?us-ascii?Q?EOZ8/Jy7A1p/3oz4BU4uC2XG+wW9/oDrvuP/Tba3/ly/5zi5ImC3nIyoDmWU?=
 =?us-ascii?Q?Wi125M/SsX+UJy+kNDd+970uQKDEyTWKR7pxcpjEmEoO3ff3eyAxO6NWPKGA?=
 =?us-ascii?Q?df82qzgCQilakRZ+VtWTDDgGLpQ8nUhl6m9wCCX2xQKI83hAwOPImyNRdBCK?=
 =?us-ascii?Q?w6klx2LGsqSnaVr5JFW7boS7vKaFkumQMUiG0CIRQY6tnxD9VxOnFa7BJLaj?=
 =?us-ascii?Q?yqx7j1kaYfIFLC+BgkthGljiiY/xO1fvKErJ2UnWRjivSniTCGAGAqdXtwhK?=
 =?us-ascii?Q?JPX0/Y6s722rMMouRcPjp77TB1tgFRKRyiZtfhhdvxKokGhXjMg8pc+aRyY5?=
 =?us-ascii?Q?4Ap8uaFjkJyBNdfN+C0jW9GaQqMqyIVBYvhEKzCJ+JRMDWzGcVv8hkZlEabp?=
 =?us-ascii?Q?X/RPNVgijhX6Y6a3gXHLsqJubH5veDybqAip0mHz4xLfM7Vd+8YAU5LSJhHj?=
 =?us-ascii?Q?wn+Vykkcc+i+JoK3uDk8TbadUbxhUG3y2uRllYhiPOXoJ0M9GjQIfV6pg4Pf?=
 =?us-ascii?Q?PrwEPcPHvPqAZhIglJ4cN0Tk1z4QQZbm/DTvnT9klo4LphLDhXLJ3PIVrRHL?=
 =?us-ascii?Q?CydXtSlbPQDupLOvQYBOYMbFjZdFVa4n4fJkcI6FH06SlR0loEWX4N6h0ieq?=
 =?us-ascii?Q?9WF8lkwIf+GBUjeUeH5GTA9QV0ueGs+6F+SlbIe0+cj45hfJ9J99acQPJL7L?=
 =?us-ascii?Q?Ck7EPCVMhCWt8t5MGFHeJAXmZkQ1UIctYGBt745sMh5I72UW9oEUf4pqdNLW?=
 =?us-ascii?Q?VyRCRBdQElL2Vghf9Ibk4yByfw6feJgIeN0JM8SWhJhJhkKi/Fp1Tx9/ZiUT?=
 =?us-ascii?Q?kdp2VsMI2ZZlqeuQvDzw6m+sgmS3JflsjJz5rICeOT8t1Sp4tG4c4dN9vCPj?=
 =?us-ascii?Q?CNG/XHMmcM8O/TFnnV83opX0cdB1Gr4r8g2XTWmT6djmUH3+MFhqd+g1YMI3?=
 =?us-ascii?Q?XdfE43YjYHkncshThx/Bs6743bWDgmUzH29v0JmvGt+zUI1SM0MstxPfr88v?=
 =?us-ascii?Q?QIBBhhH5pP03qNrKUzDZQJCx9Y0Bkr/PIvg880k+uZzThcid/U5vAcX2jPhj?=
 =?us-ascii?Q?v5Lay/e4HigoOAVBboJy4/Jnr4UzXJIoutHiUkK/slq017w00c6DjTLtXyz9?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6207832f-3d1f-42e4-c6ff-08dbe1cc6592
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 09:06:59.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpPBqphURclkuyokq5t5/qPc8uGhu6WGDpkMkZAKa8Z6/JIgQkTXFw+wgA1HBdnfzbPiDgqPp0zSH/PDWrTYX1QiWOSZnyQbRNlZ1suO0Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 7:49 AM
>
>Fri, Nov 10, 2023 at 12:35:43AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, November 9, 2023 7:07 PM
>>>
>>>Thu, Nov 09, 2023 at 06:20:14PM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>Sent: Thursday, November 9, 2023 11:51 AM
>>>>>
>>>>>On 08/11/2023 10:32, Arkadiusz Kubalewski wrote:
>>>>>> Fix issues when performing unordered unbind/bind of a kernel modules
>>>>>> which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
>>>>>> Currently only serialized bind/unbind of such use case works, fix
>>>>>> the issues and allow for unserialized kernel module bind order.
>>>>>>
>>>>>> The issues are observed on the ice driver, i.e.,
>>>>>>
>>>>>> $ echo 0000:af:00.0 > /sys/bus/pci/drivers/ice/unbind
>>>>>> $ echo 0000:af:00.1 > /sys/bus/pci/drivers/ice/unbind
>>>>>>
>>>>>> results in:
>>>>>>
>>>>>> ice 0000:af:00.0: Removed PTP clock
>>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000010
>>>>>> PF: supervisor read access in kernel mode
>>>>>> PF: error_code(0x0000) - not-present page
>>>>>> PGD 0 P4D 0
>>>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>>>> CPU: 7 PID: 71848 Comm: bash Kdump: loaded Not tainted 6.6.0-
>>>>>>rc5_next-
>>>>>>queue_19th-Oct-2023-01625-g039e5d15e451 #1
>>>>>> Hardware name: Intel Corporation S2600STB/S2600STB, BIOS
>>>>>>SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>>>> RIP: 0010:ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>> Code: 41 57 4d 89 cf 41 56 41 55 4d 89 c5 41 54 55 48 89 f5 53 4c 8b
>>>>>>66
>>>>>>08 48 89 cb 4d 8d b4 24 f0 49 00 00 4c 89 f7 e8 71 ec 1f c5 <0f> b6 5=
b
>>>>>>10
>>>>>>41 0f b6 84 24 30 4b 00 00 29 c3 41 0f b6 84 24 28 4b
>>>>>> RSP: 0018:ffffc902b179fb60 EFLAGS: 00010246
>>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>>> RDX: ffff8882c1398000 RSI: ffff888c7435cc60 RDI: ffff888c7435cb90
>>>>>> RBP: ffff888c7435cc60 R08: ffffc902b179fbb0 R09: 0000000000000000
>>>>>> R10: ffff888ef1fc8050 R11: fffffffffff82700 R12: ffff888c743581a0
>>>>>> R13: ffffc902b179fbb0 R14: ffff888c7435cb90 R15: 0000000000000000
>>>>>> FS:  00007fdc7dae0740(0000) GS:ffff888c105c0000(0000)
>>>>>>knlGS:0000000000000000
>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> CR2: 0000000000000010 CR3: 0000000132c24002 CR4: 00000000007706e0
>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>> PKRU: 55555554
>>>>>> Call Trace:
>>>>>>   <TASK>
>>>>>>   ? __die+0x20/0x70
>>>>>>   ? page_fault_oops+0x76/0x170
>>>>>>   ? exc_page_fault+0x65/0x150
>>>>>>   ? asm_exc_page_fault+0x22/0x30
>>>>>>   ? ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>>   ? __pfx_ice_dpll_rclk_state_on_pin_get+0x10/0x10 [ice]
>>>>>>   dpll_msg_add_pin_parents+0x142/0x1d0
>>>>>>   dpll_pin_event_send+0x7d/0x150
>>>>>>   dpll_pin_on_pin_unregister+0x3f/0x100
>>>>>>   ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>>>>>   ice_dpll_deinit+0x29/0xe0 [ice]
>>>>>>   ice_remove+0xcd/0x200 [ice]
>>>>>>   pci_device_remove+0x33/0xa0
>>>>>>   device_release_driver_internal+0x193/0x200
>>>>>>   unbind_store+0x9d/0xb0
>>>>>>   kernfs_fop_write_iter+0x128/0x1c0
>>>>>>   vfs_write+0x2bb/0x3e0
>>>>>>   ksys_write+0x5f/0xe0
>>>>>>   do_syscall_64+0x59/0x90
>>>>>>   ? filp_close+0x1b/0x30
>>>>>>   ? do_dup2+0x7d/0xd0
>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>>>> RIP: 0033:0x7fdc7d93eb97
>>>>>> Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
>>>>>>1e
>>>>>>fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 0=
0
>>>>>>f0
>>>>>>ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>>>>> RSP: 002b:00007fff2aa91028 EFLAGS: 00000246 ORIG_RAX:
>>>>>>0000000000000001
>>>>>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc7d93eb97
>>>>>> RDX: 000000000000000d RSI: 00005644814ec9b0 RDI: 0000000000000001
>>>>>> RBP: 00005644814ec9b0 R08: 0000000000000000 R09: 00007fdc7d9b14e0
>>>>>> R10: 00007fdc7d9b13e0 R11: 0000000000000246 R12: 000000000000000d
>>>>>> R13: 00007fdc7d9fb780 R14: 000000000000000d R15: 00007fdc7d9f69e0
>>>>>>   </TASK>
>>>>>> Modules linked in: uinput vfio_pci vfio_pci_core vfio_iommu_type1
>>>>>>vfio
>>>>>>irqbypass ixgbevf snd_seq_dummy snd_hrtimer snd_seq snd_timer
>>>>>>snd_seq_device snd soundcore overlay qrtr rfkill vfat fat xfs
>>>>>>libcrc32c
>>>>>>rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod
>>>>>>target_core_mod
>>>>>>ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm
>>>>>>intel_rapl_msr
>>>>>>intel_rapl_common intel_uncore_frequency intel_uncore_frequency_commo=
n
>>>>>>isst_if_common skx_edac nfit libnvdimm ipmi_ssif x86_pkg_temp_thermal
>>>>>>intel_powerclamp coretemp irdma rapl intel_cstate ib_uverbs iTCO_wdt
>>>>>>iTCO_vendor_support acpi_ipmi intel_uncore mei_me ipmi_si pcspkr
>>>>>>i2c_i801
>>>>>>ib_core mei ipmi_devintf intel_pch_thermal ioatdma i2c_smbus
>>>>>>ipmi_msghandler lpc_ich joydev acpi_power_meter acpi_pad ext4 mbcache
>>>>>>jbd2
>>>>>>sd_mod t10_pi sg ast i2c_algo_bit drm_shmem_helper drm_kms_helper ice
>>>>>>crct10dif_pclmul ixgbe crc32_pclmul drm crc32c_intel ahci i40e libahc=
i
>>>>>>ghash_clmulni_intel libata mdio dca gnss wmi fuse [last unloaded:
>>>>>>iavf]
>>>>>> CR2: 0000000000000010
>>>>>>
>>>>>> Arkadiusz Kubalewski (3):
>>>>>>    dpll: fix pin dump crash after module unbind
>>>>>>    dpll: fix pin dump crash for rebound module
>>>>>>    dpll: fix register pin with unregistered parent pin
>>>>>>
>>>>>>   drivers/dpll/dpll_core.c    |  8 ++------
>>>>>>   drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>   drivers/dpll/dpll_netlink.c | 37 ++++++++++++++++++++++-----------=
-
>>>>>>--
>>>>>>-
>>>>>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>>>>>
>>>>>
>>>>>
>>>>>I still don't get how can we end up with unregistered pin. And
>>>>>shouldn't
>>>>>drivers do unregister of dpll/pin during release procedure? I thought
>>>>>it
>>>>>was kind of agreement we reached while developing the subsystem.
>>>>>
>>>>
>>>>It's definitely not about ending up with unregistered pins.
>>>>
>>>>Usually the driver is loaded for PF0, PF1, PF2, PF3 and unloaded in
>>>>opposite
>>>>order: PF3, PF2, PF1, PF0. And this is working without any issues.
>>>
>>>Please fix this in the driver.
>>>
>>
>>Thanks for your feedback, but this is already wrong advice.
>>
>>Our HW/FW is designed in different way than yours, it doesn't mean it is
>>wrong.
>>As you might recall from our sync meetings, the dpll subsystem is to unif=
y
>>approaches and reduce the code in the drivers, where your advice is
>>exactly
>>opposite, suggested fix would require to implement extra synchronization
>>of the
>>dpll and pin registration state between driver instances, most probably
>>with
>>use of additional modules like aux-bus or something similar, which was
>>from the
>>very beginning something we tried to avoid.
>>Only ice uses the infrastructure of muxed pins, and this is broken as it
>>doesn't allow unbind the driver which have registered dpll and pins
>>without
>>crashing the kernel, so a fix is required in dpll subsystem, not in the
>>driver.
>
>I replied in the other patch thread.
>

Yes, so did I.
But what is the reason you have moved the discussion from the other thread
into this one?

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Above crash is caused because of unordered driver unload, where dpll
>>>>subsystem
>>>>tries to notify muxed pin was deleted, but at that time the parent is
>>>>already
>>>>gone, thus data points to memory which is no longer available, thus
>>>>crash
>>>>happens when trying to dump pin parents.
>>>>
>>>>This series fixes all issues I could find connected to the situation
>>>>where
>>>>muxed-pins are trying to access their parents, when parent registerer
>>>>was
>>>>removed
>>>>in the meantime.
>>>>
>>>>Thank you!
>>>>Arkadiusz

