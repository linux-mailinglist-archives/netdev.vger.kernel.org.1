Return-Path: <netdev+bounces-30762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F26788F2C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 21:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313B51C20E26
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08318B16;
	Fri, 25 Aug 2023 19:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E82915
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 19:07:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD9272B;
	Fri, 25 Aug 2023 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692990420; x=1724526420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6UUfSj/UJmCbC5zGcO3AKCRignGGEY+ieIG/q9Qe/Fo=;
  b=aqbBDd7pvrEh7TPjxK/hLNEOjEHHWGs6Nd9/FBaJbYAxwPiASUwZuDKX
   VB8Q84VfMjxjOLgh1/oNQmxr8dEyP1muNMHGavENUhwrRARzbezJkeFXJ
   rLWJFXHvbAfVUWUClmQ9K2VccWsmjkDEMDjhAD2zznHWNBnOHRLyhMbY5
   LJOWafE1X6LewJ/VkhDqYROwwTwv0climdTqwtTlypLbM8UPRBjqnxXFt
   rWkc13JHqR1mwr8zI8zgJWO0BHcp97xQnA9AP3hsA3ujm4Ojt9GMG0BRt
   MIrQUkvF3+Ga29G1n757J21UWXxnU6xq55ExiI+ohLlCZsk6AiIKxSICY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359779847"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="359779847"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 12:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881242147"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 25 Aug 2023 12:07:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 12:06:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 12:06:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 12:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjhgGEV/uCY1tICfgv1uSUHlzr2L+CHYwgJYDryeS3i9UNjHb9zd53zbRypKUgYP1eaG9As3t0uf2RtBKkbKmsmwXBND/0zZ8NuvGsTRz742TKDO2jlPcsqdvX0ma0vY4WtdtxdY885XuPCfnUHipemuDwiKIXB1SplfWQomB4QdqXkFT9+PFLjAy2Dn9Umnp17g0pEJacCmTKe+NK/B7Mbu69Nw/JzE1evEXDYmMcN7z6SqH4GKamjoiI1wJWNqhSYX1UQq53CJS2CO4OayAB0BypweXoI6Pd8UhXzszjOJ9anMCz7K5TGpCQv8rUc0/kj5S/NyAmnIqeFw6ejedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wSZen0Tih98xDY5GlLblBiqDbeF8C4XBTM1Psystjk=;
 b=VhgRCjP4MsX/guSHsfYSqlTUcuDyxUIY5q32P75HlmxFPIhDEdayEjDVV0oMONK0hjZ6yiss+A40PfWU62JKTLb2WNIfExskHdMYDJCexSqr/X2X/KQc7w/E+DGB+fmIpg/8CjFzulbwYzFPgs7wYbk6bJnzLrJ9tz0Byqc6v5Ckly1E2/qTfeJwDJdjRowVIA9oOVP12azbB5oriKqrpUsjOISNfv+gmFEEnWElFW+GrzWqKfelQbtNePGc5UHnipGpHN8pOjVavIdNPq81w/K1lY8D89ykITGbneBP7WLC2jF8eY8775RyLWRvkAcDjX/1FEFVpk3kpbHmItr8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ0PR11MB4864.namprd11.prod.outlook.com (2603:10b6:a03:2d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:06:55 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 19:06:55 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, poros <poros@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, mschmidt <mschmidt@redhat.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "bvanassche@acm.org"
	<bvanassche@acm.org>
Subject: RE: [PATCH RFC net-next v1 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Topic: [PATCH RFC net-next v1 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Index: AQHZ0R7y+sClUTv/akmAx/gH3L3jSa/wjecAgAP0HyCAAMRjgIAD48hAgAB4uQCAAchgAA==
Date: Fri, 25 Aug 2023 19:06:55 +0000
Message-ID: <CH3PR11MB8414200922FA16348A4F36C9E3E3A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20230817152209.23868-1-michal.michalik@intel.com>
	<20230817152209.23868-3-michal.michalik@intel.com>
	<20230818140802.063aae1f@kernel.org>
	<CH3PR11MB84141E0EDA588B84F7E10F71E31EA@CH3PR11MB8414.namprd11.prod.outlook.com>
	<20230821141327.1ae35b2e@kernel.org>
	<CH3PR11MB84149ADA77B4A6FBD4F0C230E31DA@CH3PR11MB8414.namprd11.prod.outlook.com>
 <20230824084934.3b9b96ee@kernel.org>
In-Reply-To: <20230824084934.3b9b96ee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|SJ0PR11MB4864:EE_
x-ms-office365-filtering-correlation-id: 74132cf8-b020-4a18-1965-08dba59e72c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UJcBf0/tF2cYqNG3jZRNteC+6KO7m4bQTNhLtF9MxddyEEiMdnxtDWAE2xtkKDu77KXedFzABhpA4tb/J2WATD6UWNTr4/H7JCic3O5R/XmD83827Z8o+7Y9q3JuGPCU1rNU7/DdQYFngQZBmPRgGM/PIzi7NuNUXPc31Ks3V1XnVg0KO7CgvedtskEwUiy86XY1oiJcUjXVAOmzFC0UNWaJ6AHpjY0W79Wf/6ISlYtvHNwI1b9SJp0Jwrn45vMB2+STRVB2JoiSfPgD799OOQFDEQ6Q9vhylLxPGKD+880gWtNH8BGFiRMPd1eQJd7cdJtgYi9KikUHa0Cw9ZG+YCrCLM3HJgAiUrgrB/TQH9sNSQN4qtUdy9r0/TsU8tvEnAnutSDIbG5BNkpXlBgSvfHsjhcWfMezb2MkRdWbk769STFd6EwRUatkwZaYq7gT5P3W9Cfxydf3t1U4pORthabkKRQQI0Kw9LnJodTI5zi4TGG7Ioo0STICckuMBB3Wrfp2Rw4MoLwdFJ8hQqyJH1vecxm8z/4yf5W04DK9WO/8MP5H2jW595I6BH9v9YPTSTWejKJFwV5NbjMDGhGX4Z/tG30vKuA5GYvf9IHHJBPkFAWtQQurWRnFCjxg11Id
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(82960400001)(38100700002)(38070700005)(122000001)(8676002)(4326008)(8936002)(6506007)(64756008)(54906003)(41300700001)(66476007)(33656002)(53546011)(316002)(66446008)(66946007)(76116006)(6916009)(7696005)(86362001)(66556008)(71200400001)(9686003)(478600001)(26005)(55016003)(83380400001)(7416002)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2gqin3VwZkfvgs2hLQDFQlMMF4Y8mGbLYSzT6kORI42wzCMw6WHI2fyAQgx/?=
 =?us-ascii?Q?K0tfUi9CTXjWJK3OUOtzoJfd/qt/8RVYDXbuvqlFSLqod+2OeLw9iugZ2wr1?=
 =?us-ascii?Q?0h2nH+Eo21NFYfkJHpRiiCSxYYmWA9v3sWiATWBD8mqenYiRIvGM6Ox+C+9z?=
 =?us-ascii?Q?CLq+AEnjo3QdcOmolIieu8TZMlfmRfRJ3LTe208SmEsCQ9Oh3nvBdlMBV3/r?=
 =?us-ascii?Q?MixmzUv54wD2wWm2Htvjw2V+vRQk8IUxJ72qOt3HbinRLBdLbWYlkuUYCVvm?=
 =?us-ascii?Q?Dl3rRyx4olzx8JXqJzQR9lEEJhVqSUDUr3hcIjBoGQd7vSW4HEtZ4rK3Byrv?=
 =?us-ascii?Q?woCI8yluBBpratMcuSb3Io+r8WqWlvktn7+0XEJWMMahQHRjm3MMnKpYVN3y?=
 =?us-ascii?Q?iY1w1N7Yeytsn8kuEnEwDqWEm4hZp8U0bmgQMr2r14WL+uIUsBtEV5zA0bfU?=
 =?us-ascii?Q?vjuC7X4wcFD7VDBzkkzq1FTsdeOkA7lTQtGwy2fxNpModyCJF1+xKCchi9Kv?=
 =?us-ascii?Q?I9roZ2nYBxq1uZSxwYCe4+WrXAlB8FrrDZESHrYuQj2QKHSdNOmatWkKT/xU?=
 =?us-ascii?Q?76vWy4DCvImk01+ff5X40J7s4yNfvUriF94U2ZPUVEdd2aQRxyTDMqccekty?=
 =?us-ascii?Q?puSXZWpHrWcWogAsPHoq0+pDFW5A4fRmJl5+VHgTxAii1u1jhkXlNlZnyeXt?=
 =?us-ascii?Q?Zf2bnasf1mOcNtmMfQwQIB9IB2aiTov5wpPLK2fhBOmctb2eZ0ko58wUViDH?=
 =?us-ascii?Q?6ku/+e7bIc/PPMRbJ8G3bcTJuDDuEuj5QdgXI3J8/rE1Yyc+9dPXfOmA01l7?=
 =?us-ascii?Q?cl9iRQMi8IKBle+tJFzhO+VPLB/NCE35RX8xavfMujdt3C9C8LsSbvQlt8dF?=
 =?us-ascii?Q?je2PkszQsbYYrjGBiv37kiuCrf6d14kgqYKT+9gbXM9ZoLwvxk8uVn43ZT8U?=
 =?us-ascii?Q?AK67WlGBxJtl6Ce7cBetW5jFMVFQRu0b3iCaZfKDBvsEmSq8MUv7jQLTPBxS?=
 =?us-ascii?Q?uYTGcB+ucweifM4GVWki/z+9T66r17U4MymfdFuvuvhkITBa8yKS0e/D19u2?=
 =?us-ascii?Q?HSrs0TvbsoVYB9Y6z5EF1el4N5EhIj3gYRrbEGn0jnza+ya6fzyARNp/5eB4?=
 =?us-ascii?Q?xjFPcb51llULA6l7EQZhaEuEcv3Y/0Rf6tdafND2oFmA1w+rVjUWslz3hEMQ?=
 =?us-ascii?Q?J+V6vL1NDCzKVMgec2ywbKfD+zDClBPaLKzLLjbszdJPffPIoCpN3QxlpP10?=
 =?us-ascii?Q?mnHGIrvCtfVFWBQZSYtACNNwAEOxLq3a67W/S9PDFYHW92gAn7JFaucrh0wI?=
 =?us-ascii?Q?SUnda0u3fPB2t7YRdE4ncfE0rD3uD7343xlkvzIfsIL/i7nmcEDr+XPV2Vm7?=
 =?us-ascii?Q?dnGR2JIGinpQnflvdjrGgWmB+A6f5gYlh/TzMD2eva96tCpr6RSRhFp8Q44O?=
 =?us-ascii?Q?H0HAd4XjeeNpfe9d4yGs/dM9ZlGBwQ2Uf/h020+fHW3VouxzS0r0/04pFNFb?=
 =?us-ascii?Q?gceah6iJd6ngjV+N6eQVVCp+yYbb4MgBeekABEZQEmzV45wJViS+EzEJxx4Z?=
 =?us-ascii?Q?7WSFwvRejHeze3fagqQlUTaHY31tagSy5X78Ri3E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74132cf8-b020-4a18-1965-08dba59e72c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 19:06:55.1659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Ob/JTScGkCmi12Z2KZs+skxxTsRgeQrotKAgIJ8DcTKdBCmRJr9s9qUvt9ZJIyAPKTp8Ooo5BEH2P34XzsWKVBnSY0hYiu3f0Hkf8Euqys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4864
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24 August 2023 5:50 PM CEST, Jakub Kicinski wrote:
>=20
> On Thu, 24 Aug 2023 08:59:53 +0000 Michalik, Michal wrote:
>> >> The biggest concern for me is the requirement of selftests[2]:
>> >>   "Don't take too long;"
>> >> This approach is reloading the modules few times to check few scenari=
os.
>> >> Also, the DPLL subsystem is being tested against multiple requests - =
so
>> >> it takes some time to finish (not too long but is definitely not inst=
ant). =20
>> >=20
>> > I think the time constraints are more of a question of practicality.
>> > A developer should be able to run the tests as part of their workflow.
>>=20
>> That makes sense - agree. So Jakub, if I understand correctly we have a =
few
>> different problems to solve here:
>> 1) how to deploy the module:
>>  - now it's separated, we should consider e.g. netdevsim
>> 2) if we should have those tests a part of selftests
>>  - I would remove it from selftests and move it to ./tools/testing
>> 3) if we should use Python at all:
>>  - fast to develop and easy to maintain
>>  - might be problematic to deploy (no Python, VMs, embedded, no network =
etc.)
>> =20
>> Do I understand our current outcome of the discussion correctly?
>=20
> Yes, and on (3) unless someone objects let's stick to Python.

Please be kindly informed that I just start my 2 week vacations returning o=
n 11th Sep.
Excuse me for the upcoming delay in preparing the v2 of the RFC.

All the best,
M^2

