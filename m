Return-Path: <netdev+bounces-50185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE17F4D70
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490432813B0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA83FB1B;
	Wed, 22 Nov 2023 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Li+f1+Sw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971949F;
	Wed, 22 Nov 2023 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700672043; x=1732208043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cX3HfomjxsRxIlkiX+LwL/jltYcuaW2ActaENLWjON0=;
  b=Li+f1+SwiKiIuYXG8lNkhoFxqfBuiFfjoPkhamzg57ZPlm5VPV0sc3tT
   GTqgq2XtudDzYp/JJM2AQHgY9011fajxmjv8+pZLAdHTTqnX244zItNdl
   xHhByEZqGNWU5LtT/kemDmU5e2VUdFDahItbiWcEIVl6PF1TlJhePrZ2U
   yrTJ713HkEIMJYaJnCO78UdiCo0cXiCZ8Z6Mv6TwOWSkf2kfuVvxZglob
   X5dZAl9JIda8FSI4TG2TKewJzWy5Xt+AzxBSIH+1Ak/zDnF+pG+4kclDb
   hRxWELJT6iJdbjjERd9XuB19xKEJ/BUZTsyNXvXYpRcrA7st+jm7mc0bM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5234390"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="5234390"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 08:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833090549"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="833090549"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 08:54:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 08:53:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 08:53:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 08:53:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQPJPzsTk7bNk1DlgchuK6wREXC5l1mo3ccshWGk5I1vuRFp3wkYNiLM4Rwc6i04RcaX4uYP85GmlD36iNlO6Q31cfNZEviQ2D/+CFNtI9ZT/j/aV/h+o2lF5H3Rkec3GSvArGm5NppUUGQuPXsWrXkkQRLD7j2wwfpdPqb9dSzAOI8I9MJ/83Z1nPiTKM5XSaA7go+5kfqqk1qWIhagBQwZ5zDHY/CYGusPalITQ69eS9uplx25+ZmZc+WqXhbrD1EYz3JBLjP/Bl/4A0b1lm6oyN8PwjfB5ai5HrkMxq+ifGTQJNAtQIuRkfGZ3il6BNLavbZdIBpZ+TwNEknPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEwLNbKYoAuguinNrGAIam2ohvAa4XW/ivJ+mkFnIBE=;
 b=F/nTrCVlWUtW8tX+kADoKV/DzVPvb3mex0SOlMtMBBEtd5IOPKrmonvh5Yyfr5eFDqUZR1ram/Vo3HrHmC4VrGkxXK9NwleBvhXCoUvPfzCaTC1diKfnmiuPmOaf0kvxvcpJ17sSmFLE57slbewincgYPL1rxOo8zRLA9vN3CljVgzDa2+0sOofSl/pb3iBbjo7qx4UNIR5WALvXi+ZRcH2VR05iZyzMxXcQ3Yk0ZM4V/xFSbFFgBBzACseC7BVZ8D4Oh9AAc/0GQAL1/Jr2Zc9R7KpGTw7uszeZBVOvjctf1G13HG6zrECw3vWfDxVt5VeylQN8SH4Kz2tQ4vk1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 16:53:35 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 16:53:35 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH RFC net-next v3 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Topic: [PATCH RFC net-next v3 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Index: AQHaGYkMNiEGZsKoiUO6A662YG6+A7CDd4mAgAMdvtA=
Date: Wed, 22 Nov 2023 16:53:35 +0000
Message-ID: <CH3PR11MB841445E7B1064EE4CE961CF6E3BAA@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231117190505.7819-1-michal.michalik@intel.com>
 <20231117190505.7819-3-michal.michalik@intel.com>
 <20231120171631.GB245676@kernel.org>
In-Reply-To: <20231120171631.GB245676@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|MW6PR11MB8337:EE_
x-ms-office365-filtering-correlation-id: 4b5b20a2-eac6-4503-ff57-08dbeb7b912b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NRgYeApiAFl1RZtHwOg386CziMLFapuOtCb9WqHH1MVaTtPFmbUAVthl7DLUKTw1TlDtCbjr3mp/FPiTk09PL1qbEQTsq66XfTry+v8WwT58iJWQo/lC5arO5dDpYH4POtEGnGGkGsmFu5VTz9WfwJfV3gAtHGC+Uywr+0U89WnodSl0J9w8b9UmVvmtFIA9qVYcIbyvOSEEfnvhlC/ZI7YYm9SuT0ZZs0MgkGIW7JD+m9ieqI9bQhVlo1OtB+jj4XNTZ2JjUVCjXyOZcJc8Q9SyIqsTVKgOQVPNKf1TvC9l7WqjTDif5fI0eo6f6H0O1PfvTSAuVTcLFoULYlO/URzh/oJnhAjvFRDwgn9zaqGmznQrQ5VrHc4tJHKu4d5WPMQTgnhhMw9nO2Ezp4BVclv+vCL97PqxvHU7bdvoJleWujUOBa8SndCisRKhEMqCXhYfKK8CdclU02eIGQdxKw1ZGLP3YWVe8YgmSxgMcBo5iZfl9Dzf5jdZIn3nbcw+XWYhD6gdYIorJuJdFoylfAox31znaBsh41X/N3a8AbvoG2ZtNbShnj/7l5gJms6pjLvJbvpMWwM80Nobn/mXLgeUilC3+ihrLPY42nEWc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(122000001)(38100700002)(82960400001)(33656002)(86362001)(38070700009)(6916009)(54906003)(316002)(8676002)(4326008)(8936002)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(55016003)(41300700001)(52536014)(5660300002)(7416002)(2906002)(53546011)(6506007)(7696005)(71200400001)(9686003)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YCkQOy1pIpGtvgYVPCveGnyRyryeyQJdsK5wEoyF+lSFLRypmFBdUjda1NUt?=
 =?us-ascii?Q?gPmladtZya6V2ec8par00ubwQk7hYRbm/bCuMHObsMdGAK9IVjqV07uRAo1q?=
 =?us-ascii?Q?NFuKRjfM1/IvnWuaildO3j6caU9QmG1wDrCe0JQzm/Elw8oDZ6jApkC+b53T?=
 =?us-ascii?Q?xiJX2hkh2FYZzWaHk+qgpa9WASTIQvqrFO8cyeElnZfbU7Q0UuxFKnf1dWoM?=
 =?us-ascii?Q?Crc5+8f4mQjcIJIVJxDegMcxEjF24GQkWlp2UNB7ZafMK1yHjQgzv2XLVq9e?=
 =?us-ascii?Q?unlKLKk/wN8EYm01JeyvTvEFm3bqtBbny2K6jq6tM+e0jcilSFu0bAgA+95U?=
 =?us-ascii?Q?28LEKNNoZcVd9k2wOYPd3f/VxKeyNX/48F9VenEgB4J/W25zZxz8AM8VxS1n?=
 =?us-ascii?Q?WJy5+aWY8fb9wpDXRQTvKP6ausbw4E9I6wDiSL1gGxL7dbcEGDT3xSmDxiyf?=
 =?us-ascii?Q?Yge8CI6L7gGUt2JTfJZA6aJcnwwsQ7tmxAXXf+1kUia3xnOFmaq3txXI2jGm?=
 =?us-ascii?Q?MQUP6XR73CQ49R5FMcXkbvE4uvWW0hyx6qOECjyBUiDQVy9FdZZoA10CelMn?=
 =?us-ascii?Q?rQE0CGn3an8EFwyxh1Z4TlScKdVG4am9/6M6jylVAq3cUV7nTVs++piCCbQU?=
 =?us-ascii?Q?PPp8h/WyFs1j4jpomOIoFLESOCo8uPY8rxb5+7VMvbnevatu2GKTQt8zvmK9?=
 =?us-ascii?Q?sLdS5nIOrxgRzo49uGha+XzQeFjdJzArA5eHxWGb3h0ZqWNI6inwsEQqRx0v?=
 =?us-ascii?Q?f4Ce/4rLUkVnJImnETxAnqsVNUG4Te7LriwGuEhh/pDU020c7p8SCjGrbv3j?=
 =?us-ascii?Q?lCTyED8mNsSCQepNVw8i2DdIa4lzX7Y9mwwbgrRQXX08Fjby6vZL6Bxh+izk?=
 =?us-ascii?Q?jj5lqZ2SfyBcAwXhqXNfqTXR7z/iXpjDZvPLxIMHNB/EIKmqOkvHoCmKcuIN?=
 =?us-ascii?Q?hjJYjjgQC1O7fOXck+aLjI7Dh6HGQ3vaZNYlhfm0WXgHg3pA3ZKU99LHpYz1?=
 =?us-ascii?Q?GEc2Md5ieB/dGS182GFYkG8/BQyJQ10MEiYobAp637Dx9gumwIjtazXbm0Hg?=
 =?us-ascii?Q?udHe7P5r7aiTI7cqjOcr2o5aVmiBe/+IVlaJHbr+I9ufljEfcbFAL5wrr6Hs?=
 =?us-ascii?Q?UBH4zWdSXHLqhZKERSRy/E7D7UFawFErTcNoI7LCnToW6IllatuwYPLGUJxV?=
 =?us-ascii?Q?bhn+w3DNiVRDp0qgVanPpGAVOquS+zRFT03TLdStITHQNCHk5SJ4GSiWvMCf?=
 =?us-ascii?Q?3XiSTLTEpcJFNyhcVTIcERr/o98r34qJxeYJw150RLdbkKSv0wC3R7KUWNFZ?=
 =?us-ascii?Q?cNEuT8kfrpv23yGIjSOcgK0922jSocbfbavAizzSa3haq/Rgk2EC1FU+emW5?=
 =?us-ascii?Q?MK2606jmRI+w/oWp1EGi1DC72B05huckuE7Uou0AtihMKvzfKRST7fJHk2KR?=
 =?us-ascii?Q?1PNGceH3v1O4UNVsbdzNUzvXvQjzcYVE5tia6xIfopYTyKkg7smITtJ0sZXZ?=
 =?us-ascii?Q?4W19HBF6A23vdKvS4NJqqzrYLFFpV4amb9+GOCPSgr8c7R5e27kXzUAY+XI5?=
 =?us-ascii?Q?d7qD7qmwTiGdfwSUPqSn7QuSFjDTyA/aZ4KDfXjx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5b20a2-eac6-4503-ff57-08dbeb7b912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 16:53:35.1767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfLJBg/vMY6JEF505lLvYKk51xtLRQTQKHt+akOtqr+26eU2qInzx3FRQKeEAmiP3cUcAPbBF7wQOrjpT65wufTM5VwuFqIONXa/DyfPHsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com

On 20 November 2023 6:17 PM CET, Simon Horman wrote:
>=20
> On Fri, Nov 17, 2023 at 08:05:05PM +0100, Michal Michalik wrote:
>> The tests are written in Python3 (3.7+) and pytest testing framework.
>> Framework is basing on the ynl library available in the kernel tree
>> at: tools/net/ynl
>>=20
>> High level flow of DPLL subsystem integration selftests:
>> (after running run_dpll_tests.sh or 'make -C tools/testing/selftests')
>> 1) check if Python in correct version is installed,
>> 2) create temporary Python virtual environment,
>> 3) install all the required libraries,
>> 4) run the tests,
>> 5) do cleanup.
>>=20
>> The DPLL system integration tests are meant to be part of selftests, so
>> they can be build and run using command:
>>   make -C tools/testing/selftests
>>=20
>> Alternatively, they can be run using single command [1]:
>>   make kselftest
>>=20
>> If we want to run only DPLL tests, we should set the TARGETS variable:
>>   make -C tools/testing/selftests TARGETS=3Ddrivers/net/netdevsim/dpll
>>=20
>> They can also be run standalone using starter script:
>>   ./run_dpll_tests.sh
>>=20
>> There is a possibliy to set optional PYTEST_PARAMS environment variable
>> to set the pytest options, like tests filtering ("-k <filter>") or
>> verbose output ("-v").
>>=20
>> [1] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html
>>=20
>> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>=20
> ...
>=20
>> diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll=
_tests.sh b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tes=
ts.sh
>> new file mode 100755
>> index 0000000..3bed221
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.=
sh
>> @@ -0,0 +1,75 @@
>> +#!/usr/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Wraper script for running the DPLL system integration tests.
>=20
> nit: Wrapper
>=20
>      Also elsewhere in this patch.
>=20
> ...

Ohh - thanks, will fix this spelling error.

