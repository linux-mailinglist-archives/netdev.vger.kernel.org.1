Return-Path: <netdev+bounces-52637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB57FF8BE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A70C1C21214
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B898584DC;
	Thu, 30 Nov 2023 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+Hk/HR2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94CC172A;
	Thu, 30 Nov 2023 09:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701366424; x=1732902424;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgIe70wvT3E7grvxoZAfd8HuO33jxNZMF+MbF3clgr0=;
  b=W+Hk/HR2FG0YtvEszCW7H2Za3BljUV/oCnLLHij7AbPytytfXrOz8sk4
   2JFM4mzLCQZOv/DV88KOms6bENe8aB0WoJUkq0YVH7fV3eajdy3AxLsft
   ovEo04OIoW0A9PH50CK+jUXeHWVfbvCce6jBjnrhEhM1jY+o5fUBlqOTO
   QxRImRa3m09TS3+JWqBZC1KUrcd8H2RiYZC6mORsqT1MpwiPJeLkcukKz
   gjEvKlmjM3QczchCX6VrXD11vrulHSguYrZghkb0ai72SgUc+G/OX71h4
   d5YnCioVLEeT1S8cSYtG67FGzn8pe5ElR9e5zZXKyy+BZ72H1+FI95t1o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392229932"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392229932"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="745716845"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="745716845"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 09:46:42 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 09:46:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 09:46:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 09:46:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyYPu+mw5uo5RQQYbBM5egRUMlw+22E0R+b7KY1Ceuq1Gdwx1EymEXmlo9wHONJRE9QMlhGmkCXWaCkHXb6yP4fCIvb6vdVqim4m7H0qXsIwZeyUAfJ0Z/qcjK4RcLwLoiTWkXljJ3CMmk/Eh9PfIxCIVb4zvUNcfPSTHjNUw2G5guqj6uCpgXxsddXTXWIBIzSA2uwiCS+Z8TD/o2FMWExHnicwMZPBIjbghpyFrAVZn3CV3lkH6fPZ5qhT4A2FfF8Xby2z0DKy7eORGiotM/73+GHxjA8Mm4nlcjH4BqMgMAy82UcioZWFVhnBIja28jMnjhJXcNVeT8GU5ZgZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZjckXLDkVXEuPzA/XL0ONfUfF6PTcA2v0IB7v4kOk4=;
 b=MzIquSb3+9cfPdDk07Xw/XEbPGhdTzSlCMm1B3sc7KbnegIj4EfXUujSRnBXbnM4j04m7vPJrU7n4x3XTBCH0EXUejnz/DwUPfY6LfsdMp2mVHtj/gsuUGISkljfPfkYw3tGKC1c+bN5NO+CWZ50Z8wf2c1oMgG3YADWTd7prdWe+ERWqkhXWJw41euCikfbyWxux3EJtJPt78lRgnbB+lXAJb17g2yyn1s5Qzy5155h5I/bzS8+ZQT6TJ9/1XYMWrrnRKu1t2PlMsIfiLhl2RZMY+nHuI6K8R0uzE2qweSeIIsjyfiq+yxQ3NbsDCo8lyBDtFcSFhnBdOwffpU4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 17:46:38 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 17:46:37 +0000
From: "Michalik, Michal" <michal.michalik@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>, poros
	<poros@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, mschmidt
	<mschmidt@redhat.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Topic: [PATCH RFC net-next v4 2/2] selftests/dpll: add DPLL system
 integration selftests
Thread-Index: AQHaHftDqogcp+ihbE618Bc81MIRXbCRmiWAgAGOCXA=
Date: Thu, 30 Nov 2023 17:46:37 +0000
Message-ID: <CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
 <20231129093951.3be1bd8b@kernel.org>
In-Reply-To: <20231129093951.3be1bd8b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|SA0PR11MB4717:EE_
x-ms-office365-filtering-correlation-id: b5ff72ef-0d1d-4ff9-1142-08dbf1cc4d40
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cV1t0AL31NvW41JilLto9aQQtJdE6NTl1Tj/Ev1G6JRHb3bkpELn9NqzP066bDKrlXuAtoNLNplQ2Pv8O2nhUCOLhq2rhfOV5MOA5mGr86NVkJqvo4kDlkpl+Lqzga3hucheT+igKUBcWSQoN2CcRba1pDIbrncqBXuS75Ry377vJ+JrUqOyLfj8bHsbTu9srT7EaimxP61M7YoJ6hysb222M/8B8OEXfbUMIYVgbswwwlcZL4oaXsGqecOhugtrvHXpMd6mpguRnX8Aaocv9R6jRrpzx5drNNxtjWRAQXZly2OBlBOknPkRsTFwIS8HD2/keXvQqemIQojSoSN6GqAoR7PeyTbfZoNehHghuDtIChZjFnotKkUsXeaRf1nGkjj4qhyH1xVNOQJkIY7z/tKjxSJ7K73PVbrx/2e/6w/Xv31Ot1AEgIzhwKBGoX5aaoouZx4s2cx8zYCks+RbTwbv0cZq1J4k2cEl/shqdLFMZhVdn4AEGqAclsIXSgATkR73pK+7016+QoUj2naTEy1ay8kQMW0jXH84o9t6fmQ0NMWv8Nupxd5csky/5C1oxMf7o2uZ/P2ZPL0fvOQoKxzXKwS77zqy3o0n5cqfT+1CiFGRd5UfX2Mz5e2o5fp9YJxKpaeFrRdeBzr8W32Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(86362001)(66946007)(76116006)(66446008)(66476007)(64756008)(6916009)(71200400001)(54906003)(82960400001)(33656002)(38100700002)(122000001)(26005)(6506007)(9686003)(7696005)(53546011)(966005)(2906002)(316002)(66556008)(8676002)(5660300002)(4326008)(478600001)(7416002)(52536014)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eNFkakzFxrU0utlNcvM+FHBcqrIhrE5Kq9szHya/nbsCJ+iAOx7pjI9ALuhZ?=
 =?us-ascii?Q?Qmf7S9uTJY74dxAGjtJK74T1G+cXKLSXeeFYaDAUe1EtS1L5asCiIz/60XZM?=
 =?us-ascii?Q?UtKO6dgsdJQPOCoDQsDNuFb5mh0kvoW463EBgfQ5xlvoxSVCenz/NIAqsNNZ?=
 =?us-ascii?Q?dVekg6muwWSAkWx+ijtGxYouE1L2xp3aYoqLSnpr+xjj0XJAM82fXt8FObGa?=
 =?us-ascii?Q?o00usWuXDbX90KWEyNgce/wwz4Dcbg0MJZeYTryerfpSXujeE4MeSVMQEts5?=
 =?us-ascii?Q?lRcYwO5V8ezoK4LCHNS8VRWV7lPIsvLIPe5EQHBbrRHDBR6NY5chlubc6ggK?=
 =?us-ascii?Q?Oz5TMYijHLnioPAvYJpjJKvaRahs9yBajIxqxdVyjFKVyFfS5q4e9iwk5WbT?=
 =?us-ascii?Q?+04SS1L2eXHahZpCNa4vgYCSx5zHhiM7BFlUtN7bgpuP0021IfmRkt88S5+Z?=
 =?us-ascii?Q?cdLVcBmtilMWBPN6JzXPUhrzuPDN/b9303n6+qYyjk11+4WM7qkfJ+M0tm+K?=
 =?us-ascii?Q?hUP6gYBDhUxAt0FgG7UWThUmNEJh2YMc8Cp0kEgyJv9SAHZDMwE4+QOK4ZqE?=
 =?us-ascii?Q?rjjFUSXGaAE3mJXK2seJC0JReg6bfmdwJDyghYTqStGfKEapMiKM+Qy0Bfro?=
 =?us-ascii?Q?R3BJl9HW8ZXmPbXDCD233NHFDvmcHKKCLfDuekJvJ+B2NT5jSnKHyTeLlilz?=
 =?us-ascii?Q?D5x/X4eyLq+QKMzfcbqellyJKQiyKc/NZEr7WKzmmqg9IkjqcDeDPiw2Ay/3?=
 =?us-ascii?Q?TOHhltmMXkQltckkQCWRmJPD9XLdEitlk1eIFEbswnIKoUzJURHrhPYeJwEW?=
 =?us-ascii?Q?T7sa2cawV8CUmClJLm3WCG/CNOonjBD6ri2dmp3+PfM/fPEwic2tlI8MaoWe?=
 =?us-ascii?Q?EXHUlU5t3mt+SEGde2NxKdxXUi5ikqDHOu4mHRcE0AF7nTkpXkpbFdYP5ssv?=
 =?us-ascii?Q?eF8j2AopPNWVg9/g+I8JzlC2e7oECMj7ze1l8CPlWG/5CiSkug3+2dBPHHpA?=
 =?us-ascii?Q?qHpU7NHPqPBmVjYId8INmDI/M4LStr28jLCtCeK96gMdGSkrD3JsBKV19CkX?=
 =?us-ascii?Q?myiloVbYkZf5T5Ygv4I4aOvSI1ztZK3u9yXKWmnIHY/HnLEWe8QDa4sDL6UJ?=
 =?us-ascii?Q?Itpo5NgL+Y+dKuj0el0NG45e9aVAKHUYi77CC4UHTii7LMKELeFoRNgAxCvn?=
 =?us-ascii?Q?pqMvEzuUUGJuFwWmbAtlxUPzFXGJU+ExnTiaIueJw7swV8Nc0XRzNQ2MSn2B?=
 =?us-ascii?Q?M6qFZQqYkrgWMo6O6lXzFgsfrtIuhhEQ5Pi5n88vCr8LWNDfdOc0W9At02Vv?=
 =?us-ascii?Q?D9z2kU2s8Gv4OmCaYVysEBZg4xyZkAUxStjLrfIGSq4AOffHSA0I7ouepw75?=
 =?us-ascii?Q?ual9zMHus7qWXx0sEkvYYMqwGBBSDbgBwtCRH5jJjDanJ+3OqulYsIHCQTxq?=
 =?us-ascii?Q?otta9TN9auIOX0keGJx2fyF3zA9sqXKx7ZAEIemPfhhot6FEAu0ggcv/xT5z?=
 =?us-ascii?Q?K3X0NSsofoLNuLExyckt6ckcrfXoLI0zXpm3qi9iwrMIwVwlOMd2KKhRJrA1?=
 =?us-ascii?Q?kHbLXQAJ4W9T5jHAald0Tt7zaSZX3/zM7zvVbXI2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff72ef-0d1d-4ff9-1142-08dbf1cc4d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 17:46:37.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIL77seRZBUwuglBvECbyaocp6CAIbPmv39RNciw3QBLnKvIsv+1I+ANtX2nDuAjTHnymsofei6QH1pujoXSeilsBqxwV3aGyMbVYjSN9eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com

 On 29 November 2023 6:40 PM CET, Jakub Kicinski wrote:
>=20
> On Thu, 23 Nov 2023 05:52:43 -0500 Michal Michalik wrote:
>> The tests are written in Python3 (3.7+) and pytest testing framework.
>> Framework is basing on the ynl library available in the kernel tree
>> at: tools/net/ynl
>=20
> LGTM!
>=20
> Somewhat tangential question, a nit, and a comment..
> =20
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
>=20
> nit: s/v5.0/v6.6/ ? Or /v5.0/latest/

Ohh - yeah, definitely will change that. Thanks!

>=20
> Did you try to run it in vmtest or virtme-ng?
> https://www.youtube.com/watch?v=3DNT-325hgXjY
> https://lpc.events/event/17/contributions/1506/attachments/1143/2441/virt=
me-ng.pdf
>=20
> I'm thinking of using those for continuous testing, curious all=20
> the Python setup works okay with them.

Very interesting idea, I didn't try to use those - will get familiar with t=
hat and
see if I can make any improvements to go with vmtest/virtme-ng before I wil=
l send
out the RFC v5.

>=20
>> +@pytest.fixture(scope=3D"class", params=3D((0,), (1, 0), (0, 1)))
>=20
> We have both uses of pytest and unittest in the kernel:
>=20
> $ git grep --files-with-matches '^import .*unittest'
> scripts/rust_is_available_test.py
> tools/crypto/ccp/test_dbc.py
> tools/perf/pmu-events/metric_test.py
> tools/testing/kunit/kunit_tool_test.py
> tools/testing/selftests/bpf/test_bpftool.py
> tools/testing/selftests/tpm2/tpm2.py
> tools/testing/selftests/tpm2/tpm2_tests.py
>=20
> $ git grep --files-with-matches '^import .*pytest'
> scripts/kconfig/tests/conftest.py
> tools/testing/selftests/drivers/sdsi/sdsi.sh
> tools/testing/selftests/drivers/sdsi/sdsi_test.py
> tools/testing/selftests/hid/tests/base.py
> tools/testing/selftests/hid/tests/conftest.py
> tools/testing/selftests/hid/tests/test_gamepad.py
> tools/testing/selftests/hid/tests/test_mouse.py
> tools/testing/selftests/hid/tests/test_multitouch.py
> tools/testing/selftests/hid/tests/test_sony.py
> tools/testing/selftests/hid/tests/test_tablet.py
> tools/testing/selftests/hid/tests/test_usb_crash.py
> tools/testing/selftests/hid/tests/test_wacom_generic.py
>=20
> unittest seems a bit more popular but pytest does seem like
> a better fit indeed.

Yeah, even official Python documentation points to pytest as a good alterna=
tive
with lighter syntax comparing to their built-in library in "see also" secti=
on:
https://docs.python.org/3/library/unittest.html

>=20
> Did you see what the sdsi test does? It seems to assume everything=20
> is installed locally, without the venv. I wonder if that may be simpler
> to get going with vmtest?

To be honest I did not see that. I agree that this is a simpler solution, b=
ut I am
not sure if that is not "too simple". What I mean, I'm not sure who wrote t=
he sdsi
tests, but maybe they were not aware about the Python best practices? Pytho=
n used
to be my first language, and I would vote for using the venvs if you asked =
me.
I understand that it haven't been done before, but we are here to try to im=
prove
the things, yes? Of course if you outvote me, I won't act as Tadeusz Rejtan=
 in
Matejko's painting "The Fall of Poland" and just remove the virtual environ=
ments. :)

Thanks,
M^2

