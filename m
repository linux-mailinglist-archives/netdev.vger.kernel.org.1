Return-Path: <netdev+bounces-47087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED27E7BCB
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 12:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52B41C20897
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AECA14AAE;
	Fri, 10 Nov 2023 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgVGLqhZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB015493
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 11:22:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006052F351
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 03:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699615357; x=1731151357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+UiiRiIftKj6ch+LRYYEkUD/Nl+HH6Lqgqxt+LsXSak=;
  b=dgVGLqhZpkadRjXZ6RjHm0gEpDA0D8RC2yG+Evi/2PWF6lOx+rYuuhoq
   7dTEjVQlFCXwx/E1c8g2CyCIgWOFb6H/DeGFdfKNcpE/SSIksYncwM/Jv
   FeYnRvBTkN5Vxm2JscwgoBPt65CNKsEmBRo0Z++iczDr9iFeYO0y1xtZj
   ThxcSMv4KwEC5kOvATZ3WkUnebLaBwYKXwW6gZsZafnp+Nit8O5wxtBgD
   FCeUTRFuel0SmGj/WdwCq3iBA6Qo3x9SE0fXpRPQ9ORbNNMdLK9SIupJr
   HKVEOYOAbwIBL6CEZfGtovdi8le7x/xT/U4AO/3jWCiJ6fhyp5UBnE5Oo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387334022"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="387334022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 03:22:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792839965"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792839965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 03:22:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 03:22:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 03:22:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 03:22:36 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 03:22:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPXhjRV4kt+jGnA/DkycjvTAleTl+hgTZfdJVzc3swXaU+eWxAirxW63sDF7+od4uJ3YL9ewky83SoLV/FgYBOvHBjduIfrOmwaUx4wK0ZkyhFnIdVgupFDG1kLYykzOqoUuuxM/WYYaeH3Y0hrchsrdgQDdM3MKygfkO7T5r6uUjhL2hIDOoxf1qrFeEyt8A8bDQeZ2IdgLHPWeWjq/jF0HsAU56mBBAtWzh6H+j5BAIyXnEpkGbkDnnOzeWo4Z4sQKXDnJ/lCKWnzGDKTaXvO+w6xZTmmaVniSyJMgA0L6naXNCOFR/ZkAhbhSjUUgUJ266qvqWUrLncc0IdaP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TunoZpsSwBy7+DGqwtIBbgCkoklpOvTE8DBBkOBw6g0=;
 b=UbLO0bEysjs6DUAIpEN+9WY/wbnMvT7wzXycG0hM/IIBeEmtDPs3JhxTQX4p99CSx/8KdrVvw0e3jt5pBem5t66mnhQohmKyjSsWPgHPmvTd/aHYy6fiTQD939RqAZGwzE2kYVwq+DtdX0huyz1PXexSa8Xn8wPH3UYvDRdAXqTv22+69Sq8PKCHOh4Tpn7/CYxEJrel0GDR5ZuCWFVUfeYbSanQrNwcTfHKUTTH3bp/vHLBvN+kjPfm9ATJ3n1ubpQIGYTtZK50O6kAKNrPzAbUhikUsFXMC2DY4VuZ8MChgr5awTaqAXXUHR57DT6tlPzFjZv0cWEaCkDsXCYTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 11:22:33 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 11:22:33 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer issues
Thread-Topic: [PATCH net 0/3] dpll: fix unordered unbind/bind registerer
 issues
Thread-Index: AQHaEi9OB4zvczpCGUaIr1usLpOLxrBx0M4AgABky0CAABUngIAAWuQQgAB53QCAACV4EIAAEp+AgAAGB8A=
Date: Fri, 10 Nov 2023 11:22:33 +0000
Message-ID: <DM6PR11MB46576CAE2015D34789DA45AF9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <4c251905-308b-4709-8e08-39cda85678f9@linux.dev>
 <DM6PR11MB465721130A49C22D77E42A799BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fzzmmxjnsNW0n@nanopsycho>
 <DM6PR11MB4657209FFC300E207E600F3F9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SSClU6Ijn3M7B@nanopsycho>
 <DM6PR11MB4657DE812ADB8C5079705DC99BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU4BVdPvAwKer+3v@nanopsycho>
In-Reply-To: <ZU4BVdPvAwKer+3v@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW4PR11MB5871:EE_
x-ms-office365-filtering-correlation-id: 57c530c5-ef6b-48b0-d458-08dbe1df55bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbeg5gbOZnWjcmis6Kb4dv/eB6zKTV7U7AQ4QaCl+QeQ4cFwMLZTDhDvg2iwlYd+F6JKdv/f0zEH28VOeUnwj9ieOfvbJT9GkUo8Cn/Opg+37x8iqQmzw0eotDjJcTHjkVw2FPdf3fhSlNJaCLr5GsxYbF9F9Z/g5AtbW1dBPkG3O/BAry7HGlOz6XBDuVU4m2UyXJuU3PWp+9JMqjYsGK1ErabVmu2OdEtcKgOB3ISwRDBpQ3h1XUfNPUI7iZhgQkMY2moUkrrnO2EhP8rz1TQUIQ5Uu3jp5GbKDb5tKZ93h2MRzw3cnCDzssd3JNLI2ue0JU54TKJoBfPVtzkAkQiiMaRJ6xMNBL5iKPEylQ7iNZrGyzEs3x0k+5UWMHVeQ+mXwDw9MGLM0IYUD6POdKtj5/aSKwAng8wstKSzyXGUqb4dVEbKaUfDVQaZ8OkgHwlw+NX1E6j758SXQIE3yfxewuYbDSXLPVA22kfWdPCkZc8vcnfLUGQysGSy38loOR3CT6aNMSVS69DWESgcqryMgGC36HtJdVWVa7eJLRF5qZhnTSWFMVv+mQvez0a9SytOz2MF/IGX4QR9Gz+rH6MjDT6+FBdCf1v+HA80FGzgKjJSpiwy+hraPIQ6+rh3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(45080400002)(86362001)(71200400001)(66946007)(41300700001)(54906003)(26005)(7696005)(6506007)(76116006)(9686003)(8936002)(6916009)(8676002)(4326008)(316002)(66556008)(5660300002)(66476007)(66446008)(64756008)(52536014)(2906002)(33656002)(38100700002)(38070700009)(83380400001)(82960400001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3fpO2ZOKKAg5IM/hF6oqH7hIjoRVYIpBcTeMfbDOuRflDQp6bBTXBnuj+Iog?=
 =?us-ascii?Q?kf6gRhYa0Ok/pLMavKFywqfXses1MFHO36q+A8iUUB9FdIPH6yq29JPOtifU?=
 =?us-ascii?Q?4WdA6ZB8VP0XLeJm3x10DtCHD/mOf4NEH/0XNFFde1i3UBWyMyoA3jailDcI?=
 =?us-ascii?Q?pdKsUQD04NYPPVgvREzMxaP99fbtRAXESQAQOe846S6jikOZSjhsKL+Nz5xT?=
 =?us-ascii?Q?wLyZBpLYAvzvIgPjBlQsrax8KsSUkoqBZh0voyGpCe5t7qYgqoVrEvFUEPNf?=
 =?us-ascii?Q?IppGVxYM1NT+YqI9x3QplpOMW8Oa0WA2xB0bpv0BOj5zSZCnvARdSi3QJBf2?=
 =?us-ascii?Q?JQXtdfB0pE3NZyPiJuRLsuvmJPmNcUuTnGbRtwfDMawD9NPoahm5nCrMPU6u?=
 =?us-ascii?Q?X9vjP/+krpW/1T8qsanv2JrDvLsshMwdXm773I85I/cPQogWGh53FyD0iOCR?=
 =?us-ascii?Q?cox4w5TNQsyMOCGSvwwsGe/GR0COkPRwsKAjTYTOpiOz4QUAxbZtLNsibRMy?=
 =?us-ascii?Q?Tzw5ydOJ1YaAiTu/m9XTBqtARJorGFXMbA0hNCIzAYO/3S8CwA1g6nj+Anot?=
 =?us-ascii?Q?4FVQ+ne+Ah38dMRrxAp4aIoJoJK1940NsEl/1CAYrcthfByXawDXCfcSQpue?=
 =?us-ascii?Q?pkVcZAyQeB/tKv2/wPTIpS338RkPP494OeDH8gW0v6WwIO9zWHl2Bac3c2dW?=
 =?us-ascii?Q?rDL9TwqutpekxWMCbLSB7u9yTfk5jMfwSU6ST9rMYE/ol58vICixiP4fnDLD?=
 =?us-ascii?Q?stuZDz7HAAkyhGStd3DC/4Aqr0pR8PxWzHiews7aHU9rAuQNmsUrUHZpgd9z?=
 =?us-ascii?Q?R8cLadGbZ8vYCkb1KzV2baacThbPeHk4dpjPA6CY8MuzIRhA2633De5k11yg?=
 =?us-ascii?Q?b26hBeIW0cvDmoV79gMjo9E8k5YdxCRP0vz/mxaB2zH+Opt2ZgB2BK+6icdT?=
 =?us-ascii?Q?EH8cfinpByY5dELN3m2TUI1xTobymzaJCvErCadKDeZ/GaUVZjecNYgcAbJM?=
 =?us-ascii?Q?HwU/finye0aPsEPwRo9F83Bd3TNuHgJYran7lqRoWgNzf79KmUemGWSVIjnu?=
 =?us-ascii?Q?u0CbQktAyTYnKabqNENR0jKAQd+2t1XSV3xoEXsmx1sz2ladf5pKOYWIKTBe?=
 =?us-ascii?Q?J/NFbt38Xy4W1mCoJePk1qEWgIFihfGMJEy03C/qO6GgZGz67Y84d3Ae8SOH?=
 =?us-ascii?Q?j6b6u4dMi+OsVjWDUdq3ArtwQQxJTZSS2UY53xzRcACd9q1ApTkyK/AqODMK?=
 =?us-ascii?Q?Ru0+TbfP9h1hA1Ckd7AkGlV08yeyN9Ey1tKsLqGIJfvq9CmUx+CPzsKQAQVC?=
 =?us-ascii?Q?zo7JxwLTA+TikMaOiRn38LGe4RY/aNw3crQwtdYdI0ymub2zal62YXU8zG8v?=
 =?us-ascii?Q?AUSTiR8ug7BQhalrP7bOO711qzXzHtES3BVaFy7aEue0vQ1CL+r7FG6g04s2?=
 =?us-ascii?Q?B/L0HIFA/cQ3cz1ZSv2xipqJcC/jy7wC4Wo8gXjVCL/8ZPQxchxFPkNz1brH?=
 =?us-ascii?Q?UvNN1Cnfy0swjwcCz5cyieJrYTZrQcBizzfM0bqWtF7AA4fQthZEZTao778r?=
 =?us-ascii?Q?7OvCQ6TnIzs/ukknGT8tQ9zzSn0hA6aPKxCQyf4V/CiQV4OKTlsKKOCz9okv?=
 =?us-ascii?Q?og=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c530c5-ef6b-48b0-d458-08dbe1df55bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 11:22:33.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3kG7OIUlmTYjXnqxDccOGuIiHVymC3BFHF1w3i0QpJzeehR44mTQZ+Wl+pkMv6IVzGJjFY9ZPndCdvLcAI5sGjH3xMuCP1iy7AlX/oIt8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 11:09 AM
>
>Fri, Nov 10, 2023 at 10:06:59AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, November 10, 2023 7:49 AM
>>>
>>>Fri, Nov 10, 2023 at 12:35:43AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, November 9, 2023 7:07 PM
>>>>>
>>>>>Thu, Nov 09, 2023 at 06:20:14PM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>>>Sent: Thursday, November 9, 2023 11:51 AM
>>>>>>>
>>>>>>>On 08/11/2023 10:32, Arkadiusz Kubalewski wrote:
>>>>>>>> Fix issues when performing unordered unbind/bind of a kernel
>>>>>>>>modules
>>>>>>>> which are using a dpll device with DPLL_PIN_TYPE_MUX pins.
>>>>>>>> Currently only serialized bind/unbind of such use case works, fix
>>>>>>>> the issues and allow for unserialized kernel module bind order.
>>>>>>>>
>>>>>>>> The issues are observed on the ice driver, i.e.,
>>>>>>>>
>>>>>>>> $ echo 0000:af:00.0 > /sys/bus/pci/drivers/ice/unbind
>>>>>>>> $ echo 0000:af:00.1 > /sys/bus/pci/drivers/ice/unbind
>>>>>>>>
>>>>>>>> results in:
>>>>>>>>
>>>>>>>> ice 0000:af:00.0: Removed PTP clock
>>>>>>>> BUG: kernel NULL pointer dereference, address: 0000000000000010
>>>>>>>> PF: supervisor read access in kernel mode
>>>>>>>> PF: error_code(0x0000) - not-present page
>>>>>>>> PGD 0 P4D 0
>>>>>>>> Oops: 0000 [#1] PREEMPT SMP PTI
>>>>>>>> CPU: 7 PID: 71848 Comm: bash Kdump: loaded Not tainted 6.6.0-
>>>>>>>>rc5_next-
>>>>>>>>queue_19th-Oct-2023-01625-g039e5d15e451 #1
>>>>>>>> Hardware name: Intel Corporation S2600STB/S2600STB, BIOS
>>>>>>>>SE5C620.86B.02.01.0008.031920191559 03/19/2019
>>>>>>>> RIP: 0010:ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>>>> Code: 41 57 4d 89 cf 41 56 41 55 4d 89 c5 41 54 55 48 89 f5 53 4c
>>>>>>>>8b
>>>>>>>>66
>>>>>>>>08 48 89 cb 4d 8d b4 24 f0 49 00 00 4c 89 f7 e8 71 ec 1f c5 <0f> b6
>>>>>>>>5b
>>>>>>>>10
>>>>>>>>41 0f b6 84 24 30 4b 00 00 29 c3 41 0f b6 84 24 28 4b
>>>>>>>> RSP: 0018:ffffc902b179fb60 EFLAGS: 00010246
>>>>>>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>>>>>>> RDX: ffff8882c1398000 RSI: ffff888c7435cc60 RDI: ffff888c7435cb90
>>>>>>>> RBP: ffff888c7435cc60 R08: ffffc902b179fbb0 R09: 0000000000000000
>>>>>>>> R10: ffff888ef1fc8050 R11: fffffffffff82700 R12: ffff888c743581a0
>>>>>>>> R13: ffffc902b179fbb0 R14: ffff888c7435cb90 R15: 0000000000000000
>>>>>>>> FS:  00007fdc7dae0740(0000) GS:ffff888c105c0000(0000)
>>>>>>>>knlGS:0000000000000000
>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>> CR2: 0000000000000010 CR3: 0000000132c24002 CR4: 00000000007706e0
>>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>> PKRU: 55555554
>>>>>>>> Call Trace:
>>>>>>>>   <TASK>
>>>>>>>>   ? __die+0x20/0x70
>>>>>>>>   ? page_fault_oops+0x76/0x170
>>>>>>>>   ? exc_page_fault+0x65/0x150
>>>>>>>>   ? asm_exc_page_fault+0x22/0x30
>>>>>>>>   ? ice_dpll_rclk_state_on_pin_get+0x2f/0x90 [ice]
>>>>>>>>   ? __pfx_ice_dpll_rclk_state_on_pin_get+0x10/0x10 [ice]
>>>>>>>>   dpll_msg_add_pin_parents+0x142/0x1d0
>>>>>>>>   dpll_pin_event_send+0x7d/0x150
>>>>>>>>   dpll_pin_on_pin_unregister+0x3f/0x100
>>>>>>>>   ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>>>>>>>   ice_dpll_deinit+0x29/0xe0 [ice]
>>>>>>>>   ice_remove+0xcd/0x200 [ice]
>>>>>>>>   pci_device_remove+0x33/0xa0
>>>>>>>>   device_release_driver_internal+0x193/0x200
>>>>>>>>   unbind_store+0x9d/0xb0
>>>>>>>>   kernfs_fop_write_iter+0x128/0x1c0
>>>>>>>>   vfs_write+0x2bb/0x3e0
>>>>>>>>   ksys_write+0x5f/0xe0
>>>>>>>>   do_syscall_64+0x59/0x90
>>>>>>>>   ? filp_close+0x1b/0x30
>>>>>>>>   ? do_dup2+0x7d/0xd0
>>>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>>>   ? syscall_exit_work+0x103/0x130
>>>>>>>>   ? syscall_exit_to_user_mode+0x22/0x40
>>>>>>>>   ? do_syscall_64+0x69/0x90
>>>>>>>>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>>>>>> RIP: 0033:0x7fdc7d93eb97
>>>>>>>> Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3
>>>>>>>>0f
>>>>>>>>1e
>>>>>>>>fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d
>>>>>>>>00
>>>>>>>>f0
>>>>>>>>ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>>>>>>> RSP: 002b:00007fff2aa91028 EFLAGS: 00000246 ORIG_RAX:
>>>>>>>>0000000000000001
>>>>>>>> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fdc7d93eb97
>>>>>>>> RDX: 000000000000000d RSI: 00005644814ec9b0 RDI: 0000000000000001
>>>>>>>> RBP: 00005644814ec9b0 R08: 0000000000000000 R09: 00007fdc7d9b14e0
>>>>>>>> R10: 00007fdc7d9b13e0 R11: 0000000000000246 R12: 000000000000000d
>>>>>>>> R13: 00007fdc7d9fb780 R14: 000000000000000d R15: 00007fdc7d9f69e0
>>>>>>>>   </TASK>
>>>>>>>> Modules linked in: uinput vfio_pci vfio_pci_core vfio_iommu_type1
>>>>>>>>vfio
>>>>>>>>irqbypass ixgbevf snd_seq_dummy snd_hrtimer snd_seq snd_timer
>>>>>>>>snd_seq_device snd soundcore overlay qrtr rfkill vfat fat xfs
>>>>>>>>libcrc32c
>>>>>>>>rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod
>>>>>>>>target_core_mod
>>>>>>>>ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm
>>>>>>>>intel_rapl_msr
>>>>>>>>intel_rapl_common intel_uncore_frequency
>>>>>>>>intel_uncore_frequency_common
>>>>>>>>isst_if_common skx_edac nfit libnvdimm ipmi_ssif
>>>>>>>>x86_pkg_temp_thermal
>>>>>>>>intel_powerclamp coretemp irdma rapl intel_cstate ib_uverbs iTCO_wd=
t
>>>>>>>>iTCO_vendor_support acpi_ipmi intel_uncore mei_me ipmi_si pcspkr
>>>>>>>>i2c_i801
>>>>>>>>ib_core mei ipmi_devintf intel_pch_thermal ioatdma i2c_smbus
>>>>>>>>ipmi_msghandler lpc_ich joydev acpi_power_meter acpi_pad ext4
>>>>>>>>mbcache
>>>>>>>>jbd2
>>>>>>>>sd_mod t10_pi sg ast i2c_algo_bit drm_shmem_helper drm_kms_helper
>>>>>>>>ice
>>>>>>>>crct10dif_pclmul ixgbe crc32_pclmul drm crc32c_intel ahci i40e
>>>>>>>>libahci
>>>>>>>>ghash_clmulni_intel libata mdio dca gnss wmi fuse [last unloaded:
>>>>>>>>iavf]
>>>>>>>> CR2: 0000000000000010
>>>>>>>>
>>>>>>>> Arkadiusz Kubalewski (3):
>>>>>>>>    dpll: fix pin dump crash after module unbind
>>>>>>>>    dpll: fix pin dump crash for rebound module
>>>>>>>>    dpll: fix register pin with unregistered parent pin
>>>>>>>>
>>>>>>>>   drivers/dpll/dpll_core.c    |  8 ++------
>>>>>>>>   drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>>>   drivers/dpll/dpll_netlink.c | 37 ++++++++++++++++++++++---------=
-
>>>>>>>>--
>>>>>>>>--
>>>>>>>>-
>>>>>>>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>I still don't get how can we end up with unregistered pin. And
>>>>>>>shouldn't
>>>>>>>drivers do unregister of dpll/pin during release procedure? I though=
t
>>>>>>>it
>>>>>>>was kind of agreement we reached while developing the subsystem.
>>>>>>>
>>>>>>
>>>>>>It's definitely not about ending up with unregistered pins.
>>>>>>
>>>>>>Usually the driver is loaded for PF0, PF1, PF2, PF3 and unloaded in
>>>>>>opposite
>>>>>>order: PF3, PF2, PF1, PF0. And this is working without any issues.
>>>>>
>>>>>Please fix this in the driver.
>>>>>
>>>>
>>>>Thanks for your feedback, but this is already wrong advice.
>>>>
>>>>Our HW/FW is designed in different way than yours, it doesn't mean it i=
s
>>>>wrong.
>>>>As you might recall from our sync meetings, the dpll subsystem is to
>>>>unify
>>>>approaches and reduce the code in the drivers, where your advice is
>>>>exactly
>>>>opposite, suggested fix would require to implement extra synchronizatio=
n
>>>>of the
>>>>dpll and pin registration state between driver instances, most probably
>>>>with
>>>>use of additional modules like aux-bus or something similar, which was
>>>>from the
>>>>very beginning something we tried to avoid.
>>>>Only ice uses the infrastructure of muxed pins, and this is broken as i=
t
>>>>doesn't allow unbind the driver which have registered dpll and pins
>>>>without
>>>>crashing the kernel, so a fix is required in dpll subsystem, not in the
>>>>driver.
>>>
>>>I replied in the other patch thread.
>>>
>>
>>Yes, so did I.
>>But what is the reason you have moved the discussion from the other threa=
d
>>into this one?
>
>I didn't, not sure why you say so. I just wanted to make sure you
>follow.
>

Funny thing, you said you did not, and just after explained why.

Thank you!
Arkadiusz

>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>Above crash is caused because of unordered driver unload, where dpll
>>>>>>subsystem
>>>>>>tries to notify muxed pin was deleted, but at that time the parent is
>>>>>>already
>>>>>>gone, thus data points to memory which is no longer available, thus
>>>>>>crash
>>>>>>happens when trying to dump pin parents.
>>>>>>
>>>>>>This series fixes all issues I could find connected to the situation
>>>>>>where
>>>>>>muxed-pins are trying to access their parents, when parent registerer
>>>>>>was
>>>>>>removed
>>>>>>in the meantime.
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz

