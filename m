Return-Path: <netdev+bounces-53073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90408012D4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BCC1C20B86
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A84EB46;
	Fri,  1 Dec 2023 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6TDjHab"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB08BD;
	Fri,  1 Dec 2023 10:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701455599; x=1732991599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7KIprL/qsWy/aViECoHH/MijcssvsM5JvL2+5r7i2DY=;
  b=h6TDjHabg4VMW4jt88KukeiPPYoCiKbhMfSLlSOU6G8K8H6tcjCaBf91
   3RPmrwxBmbc9buNIQM5MZKTYafmzeFRm6fJqzwgiaW9QnyIRkOZikGL4C
   9psbIPnBjZ6IBTPAMm28hDm4ASnFkCoDpe3XRkmwKeNPWlStjpkhkYQaO
   I8vKPpCwxzoL4ug4pEmwy1ZkoyKe2QcbepNpOK1I4IPtjRUYX6xCiTtTV
   5atB4/Qe4fiUzmsZqR/BxN+nBBA3KtmSJ8Cd+k6STXA2hpq70YbVLg7oJ
   l84oHBkGDnbK4POZygHuWgGGnESU0TgwmhXxGM0WTwSr1NF2pTwkaW8+P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="396333068"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="396333068"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="798815092"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="798815092"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 10:33:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 10:33:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 10:33:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 10:33:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4bODYNk39yCo7xJsOmln4Wil1qV7hq9+v49XV0MZGwo0niiGDt2B3iSJRXfRa5AfetAkdCz0Nk3aOQO3f/SbPhZ5als45kmqsTd/1UwoX+Ahiy6yaxKOE7dq8wUUa9oFRdbwkZzpFYR393pf4ZB0q6cMcrhWXPzj3h1PK5yMy5nP6JGsvW3wPsij/U9rfiu6iSaukzvxeFt89iQClHJrXzhTK0v6ImPMkA1vYYWHSjuipBuyeL8SB+SVJdFFNgPJQMaNFnYpQueOGmdAxL4v9BWPD43t54EJ/hdzM4g46DCXX4eARXbgN/ei7ABn47N5RnSN6coYHF75ml6lf3xIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aya8AQzC3es0fohJevzWELV9fJtQ54NndujDKoXq+xA=;
 b=YSblZTDZdiGcVfjjiYH0bWUqLrf4eqbJ336IQYyP/Y/a+ybLQwx5IYi9frOrEfXZvpewsWuxOalruUjqQss7UM+5ny1TPSgIu1DmeeArbtVdxja964HgUwnS6Qwba5wItR9CR5r0L+nYLdF8nCsTQoK1KXpq5bDbG7ECSuxOHDTNNXeZPxLQIc8jcmxqjtRiq0IKIvxqKArBPSWlWi9BbBPj98v6Ql44lKnuFXvROviWG0vi26+WikVriFC0LR3iQ0dCXnmYgU1xV/0qTbWqibay0oGA4b3z+WP/8Plgt1oUk9RzkFzfIbTiS2CD7EXMBLoBCCQz90mjf/WuUasJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 18:33:11 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::a0ff:c576:dd44:3f12%5]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 18:33:11 +0000
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
Thread-Index: AQHaHftDqogcp+ihbE618Bc81MIRXbCRmiWAgAGOCXCAAOF4gIAAvlGQ
Date: Fri, 1 Dec 2023 18:33:11 +0000
Message-ID: <CH3PR11MB84146024E32844E0931039ACE381A@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20231123105243.7992-1-michal.michalik@intel.com>
	<20231123105243.7992-3-michal.michalik@intel.com>
	<20231129093951.3be1bd8b@kernel.org>
	<CH3PR11MB84143BBDDE886E6479146365E382A@CH3PR11MB8414.namprd11.prod.outlook.com>
 <20231130225127.1b56ffca@kernel.org>
In-Reply-To: <20231130225127.1b56ffca@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|DM6PR11MB4691:EE_
x-ms-office365-filtering-correlation-id: 8bbc3408-6f0a-4cd1-ac8e-08dbf29bf901
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPxgmTE7ThWaHW5NpKy1FCqyaNZKN/OIqOWpNbCecSQeDTikzb1FmXHnvgVrH9OEUxPP60F5mks07G526PofPThex7xVY6//0gRQz0CsJqcHxpfMaCTWOnsA3SMn8x/7yzChquzIghTaIrWjaKTd02oOPJIRuIq/rQ0I8NUSmsol3n1MeovyEW3xFsGhg5ZJh8mEydSReqg5IpAoupPm7spWKr42xhNuiScqsboFspaZfCVKCY9pCNkmMrb2TmWlHP74T+Z4mvnmH/mAF5HbyyOWBZ2cCFys82PuG02r8wJZ/sj4OGiStkxtfqNZsnL5qz72/R4nzB8y3CQv6JSHjVJWp39o6P1haQJJLg/kw8KZc8uB3jeLeQuCydIe74OJn4uFocmQZkWvOYNo76gexB5wnxfNnnOAdh2CRa7nbfgluftXXFCQlOGdwV8B5hplmyAV4W4As9xFxQP1YoEXk6z/YgNh46exipmysaV/9P87L6+XS133kDD1m0K1Zg1Yn9Z9csJMKdj2B/5M53Yj72DF5taGPhpj7Jc/9N0tuPZ524tQ1hri4v3R+N0gYlDkN9uJFu83enCcqhf5MedRVP6xtm0PKzT9BLOdheXYNkQq3TNRun2d2X5QFfzw5fLnwGIx17XSc2xqdv8NCUPRXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(41300700001)(82960400001)(122000001)(55016003)(33656002)(9686003)(38070700009)(38100700002)(478600001)(966005)(316002)(7416002)(7696005)(6506007)(53546011)(5660300002)(86362001)(52536014)(76116006)(66946007)(6916009)(66556008)(66476007)(66446008)(64756008)(54906003)(2906002)(71200400001)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xMgsoti0mfIdYemlpxx0phdETbFtkQA6PZJR3LUg2OPmilaiiqskaOfqTeb2?=
 =?us-ascii?Q?m1MO3HdjXUQ05xmHLkExkbokbSq8+gjkhL5A8tH/hCt9QU2da6Y3DfGaS8s9?=
 =?us-ascii?Q?koQ7gxHToDBdDnNoAu/5YsIsAJhnqSevPtEk6UFLYnnRQXs+GM0jJeXYUV+J?=
 =?us-ascii?Q?tEytq12GuCa2A9MvGIpGUkaMoiJNbKBjPgxAToXLe0hjIbcrQrzk266EEkUu?=
 =?us-ascii?Q?pafY3TxZHtt2jdYo3nPaoToXCNMOvEl+GVKK4dhapyxprXY59KXQbW7PshbG?=
 =?us-ascii?Q?7/59yHPsOymWAeXUEKZMIOcupXlCmD9EXaXaoVBo51YbyRp0xV5FlgUcJ6jj?=
 =?us-ascii?Q?83DjvYGOcf+xiydSUxBQdZ++q8BBF0ezIQuROEVvaMulZh3ianb6YVik3euz?=
 =?us-ascii?Q?obpNa9a1VPaaeap0JA03ICVKLCnnQxr1W9lWhbQOQWKEbjNOZuIU+QfoHzMY?=
 =?us-ascii?Q?SerjuoB42iGn9L9IjTHd+XOV5hiJsw5CanYErWmh7kW310Knr3ZdeX3vrh+x?=
 =?us-ascii?Q?6aHOMk7hR5zeCAwhAXBWacOIVYwK/WZmZizglPJ1S0spxJ1CaXQ4jCSa+2Jq?=
 =?us-ascii?Q?kzJoDkHOrpoemxMgUjUrGW1UlQjEuNQxspzcmX3768XdCBpp3IRBYI6tePHi?=
 =?us-ascii?Q?62T+0/nUF61OBv3MZMuHlQgA2RfKxd90/V5+WOw8n5ZTYFtLLfJO/wsbWCm2?=
 =?us-ascii?Q?oZkfA5mXnVh0jZWwRf2s+U80mOrvbiD8ShTq1L8NRl5q/itvt748VRFvLSQ/?=
 =?us-ascii?Q?2oHP4TpCdUujmCActT/iHmtsjG4zKCiFvPPl8BMYDkhj5FAwo4jMj4YXSttK?=
 =?us-ascii?Q?BQADjtE8OyCqtsv03gLHYyBpCoPRj9ZeBgNXE8gjgd95uKRHGb6yYcR5PNFC?=
 =?us-ascii?Q?PJgiILU5ZMIJiTDNWtAq3c8YoRZQWqUUoBYUuFcWeC4YmzzPUyS5ZU/aVw6z?=
 =?us-ascii?Q?+vTB+tmLVkYCF7d+gOj6kCv6VP33/fgJkFw4z8QxgkiZ3kpbu1lysSnMto2X?=
 =?us-ascii?Q?68ghRK/pjJy3aBTyCkzr4u7rEXJvUmDwQCmCDcrLwNyPi00MImCguiqdiwi4?=
 =?us-ascii?Q?Z1npm/n0oYirPuYaDBQwHJT50xF1QyRWJbZdkmoZJY3+R5obMZjYllqk7Oih?=
 =?us-ascii?Q?P3FG0PivDtpA7/3K6jWS44uQYvRfZxU7TQv9y8nhS9ap5YDZW/tm/IZ5PELB?=
 =?us-ascii?Q?aztYUnlO6kEBzPt9Er+99raRzizkIKA3IfvTFV8J5sDhzT4DoA5lB6XYx13i?=
 =?us-ascii?Q?n7OGu3NdAMfuzXLAuRwhuKfaRwHYvrqgL8YgJTNKbgEECWMtv7fKGgMBaOXO?=
 =?us-ascii?Q?0j+XGhkxgGwQ3EJiKIEU2kcbjRrNTZ11s6P2prjWyA80lpmNe+fc1MgC6BlX?=
 =?us-ascii?Q?PYn1P/iThZIP7+8lPHxjJTwU8Uwj0b20IxZE2CODlSzM0M7T7SvtMQNa5Oit?=
 =?us-ascii?Q?18xBKfHBPf0f12dal9qNxfD8L1Sf+ImLtXayzdMfCCMogcmwxQxiqnunqqye?=
 =?us-ascii?Q?ICudhCo+W2zv5H3HlWKleKkAjVGCru0fGkH7sjvVcmY7opUd2rkGrOasDWVu?=
 =?us-ascii?Q?dgCOBxhRu11q1qTfhq2Z81faSwNY9i/gfQyEA7l2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbc3408-6f0a-4cd1-ac8e-08dbf29bf901
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 18:33:11.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69TIcPBHFjVL7zuy3k/QF1zjdWLTlQFoyl58MWylDpE05YaLgjO+RXcjnUJ7ddkNPmETWE5qdsaKB8uVnLimSve2wYCvHQMN1yMUP2qxKkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com

On 1 December 2023 7:51 AM CET, Jakub Kicinski wrote:
>=20
> On Thu, 30 Nov 2023 17:46:37 +0000 Michalik, Michal wrote:
>> > Did you try to run it in vmtest or virtme-ng?
>> > https://www.youtube.com/watch?v=3DNT-325hgXjY
>> > https://lpc.events/event/17/contributions/1506/attachments/1143/2441/v=
irtme-ng.pdf
>> >=20
>> > I'm thinking of using those for continuous testing, curious all=20
>> > the Python setup works okay with them. =20
>>=20
>> Very interesting idea, I didn't try to use those - will get familiar wit=
h that and
>> see if I can make any improvements to go with vmtest/virtme-ng before I =
will send
>> out the RFC v5.
>=20
> LMK how it goes. I tried using both today and they work fine if I let
> them build the kernel, but if I tried to use my own kernel build they
> just hang :(
>=20

That looks really promising - great idea. I tried only vmtest today, and my=
 tests
work kind of flawless with my own built kernel (nested VMs):
  $ vmtest -k /home/net-next/vmlinux "modprobe netdevsim && KSRC=3D/home/ne=
t-next/ pytest"
  =3D> vmlinux
  =3D=3D=3D> Booting
  =3D=3D=3D> Setting up VM
  =3D=3D=3D> Running command
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  platform linux -- Python 3.9.16, pytest-7.4.3, pluggy-1.3.0
  rootdir: /home/net-next/tools/testing/selftests/drivers/net/netdevsim/dpl=
l
  collected 91 items =20

  test_dpll.py ........................................................... =
[ 64%]
  ................................                                         =
[100%]

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D 91 passed in 10.54s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I will try to take a look at virtme-ng next week, but to be frank I already=
 like
the vmtest.

>> > Did you see what the sdsi test does? It seems to assume everything=20
>> > is installed locally, without the venv. I wonder if that may be simple=
r
>> > to get going with vmtest? =20
>>=20
>> To be honest I did not see that. I agree that this is a simpler solution=
, but I am
>> not sure if that is not "too simple". What I mean, I'm not sure who wrot=
e the sdsi
>> tests, but maybe they were not aware about the Python best practices? Py=
thon used
>> to be my first language, and I would vote for using the venvs if you ask=
ed me.
>> I understand that it haven't been done before, but we are here to try to=
 improve
>> the things, yes?=20
>=20
> I think I already asked how long the setup takes but my only concern=20
> is that the setup will be slower, and less useful during development.
>

I wanted for "run_dpll_test.sh" to be userfriendly even for people who does=
 not
have a clue how python/pytest works. If somebody is developing tests, I ass=
ume
he/she knows what she is doing and is using own environment either way, lik=
e
venvs with additional Python debug tools and direct pytest in tests directo=
ry:
  KSRC=3D<KERNEL SRC> pytest

I don't feel like it is slowing anybody down. But since vmtest looks promis=
ing,
maybe I can prepare a reverse logic. What I mean is I will prepare script w=
hich
helps prepare the environment, but the default will be to use "locally inst=
alled
stuff" when people just run "make -C tools/testing/selftests".

>> Of course if you outvote me, I won't act as Tadeusz Rejtan in
>> Matejko's painting "The Fall of Poland" and just remove the virtual envi=
ronments. :)
>=20
> :D
> The infallible strategy of showing a nipple.
> https://www.youtube.com/watch?v=3DlY0V65YWEIA&t=3D50s
>

Good one! :D

