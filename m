Return-Path: <netdev+bounces-30273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7792786AE7
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003291C20DED
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7DD2FF;
	Thu, 24 Aug 2023 09:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C2CA7A
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:00:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66D198E;
	Thu, 24 Aug 2023 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692867603; x=1724403603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N9NqFv9HCg+ILqOx82a155s5nN53YC3+TS+KD2Guth0=;
  b=miUJ3KJsNzvBmt+g7U+nwZFRpsXJM2f+3C61bx51HlrmhXIwnSizVLjO
   W0u4w9OwQl9PPZEFvWoqDqL1TiCLX95N3ENl0PAHn8hZ3iXvLab5cxqHY
   AqOeT/E7HY9XPyjDp1hX9/+sFlgVIhhXxDSmmZoP8x0UW8bLyPXYeX8Ir
   p3B9mKmTZY/bOORBZJICPBQPl0zgtI7tpq0VTDvgox3ATXWHZLw3t2T5E
   4hMqTicih6SUWssCMVS9F608Qe0KH/dCYgDirXyfA/SivxjJdN6RqqmD+
   QtXDKqmveSHaNgIjdc4FGokkD9vOQ4NWufwirzioBGWwk1dk6h3xU7wo6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="353927763"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="353927763"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 02:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067748332"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067748332"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 01:59:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 01:59:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 01:59:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 01:59:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh2cl1ZfpKw1mh2XobZdHbkjTpLrmFT/jFAF2rht50M2Bkv8HP+xt+Bz5sMtOO3NDTosEmSGGIZIyqHjhostbxTsH+8JnWg8zZGWIbUb5a8fTQLriannFKy7yig6uY+O0vM54RaUthlb+mNS8spSU4ts+oiMYsOlvhiRXSArAilSj6dV0aFSikhQqR4L6QtrLT9reifUC2reKdnHmozECx+bYEkaV752XFDRX+4oYGk6NkGdfBvdEaL9Q4ROorLU0qynC6BS3U9REj4Xna5du2uPMKBGH02S2/icCvTjHXgfvl4SSWDADjXjch7t11h3i+fClZ8C18dvKPd+QxyciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh9jIEvb9ENDslQDt5zl8VIzag5BCEeJl6R1k+sz0xM=;
 b=RaCwxEjh3oN2SpmfMjPlrwUqBZdPtbqGQO7fX04XjPV4wBCMBorfaw6Hpl9HsrWdBt+GAAwOUB/onNdfcFe9RA6iyDE5Kv3C6yWUTNuZWcy7oY+lPujMieoEINqnoD2D+gdGmeeLZXROItfkBsCVXrVBm6wvmEev1efGkvMq+IJHHuWnYkWm1skKZ0UTAiAl8c3npHB3p/3EJJryg89YNMnYnx9KkivDDBArPf5QUZLhc4UUTkkT6lnztq7i4fprsX2LFs0C76dWqzFJewzmo2s6KXFi+fST2AM9i23J8nZYd7aZy7Ml5jaqcXFI8bpQzFVFcMMm4S7DV93wsRIoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:59:54 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5%2]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 08:59:53 +0000
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
Thread-Index: AQHZ0R7y+sClUTv/akmAx/gH3L3jSa/wjecAgAP0HyCAAMRjgIAD48hA
Date: Thu, 24 Aug 2023 08:59:53 +0000
Message-ID: <CH3PR11MB84149ADA77B4A6FBD4F0C230E31DA@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20230817152209.23868-1-michal.michalik@intel.com>
	<20230817152209.23868-3-michal.michalik@intel.com>
	<20230818140802.063aae1f@kernel.org>
	<CH3PR11MB84141E0EDA588B84F7E10F71E31EA@CH3PR11MB8414.namprd11.prod.outlook.com>
 <20230821141327.1ae35b2e@kernel.org>
In-Reply-To: <20230821141327.1ae35b2e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|DM4PR11MB6335:EE_
x-ms-office365-filtering-correlation-id: df50eb06-fcbe-4bfd-4eda-08dba4807b87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L5VxV4/MT5QGdL8LbE1HowaOjN/fHVVn8LpVVJaaQg+ztFYLie81qMY5ZHeluOenRFdSb9zghmpEeqKyatarB7nvwe6bnTmTyefYgk5u3m9zgrzNzx2fqLydgWw4LSWOwZLbZM6n2flrPRb8PE7E/SbOam4KbtzSeCO1ia9gmleOrbJsgdT1yZGWPj2ckYx90g17hAyX2jJrrShlptoehYJ5eZRhe1f+R/SOypAdwzSUH1AghfMF/GdhgaZ6G2cc4ajHsPAxt1ZA+/tsjxm4EbQt3d32tzoVr2iyAWyBvHLxhiy+tXuEFWcjmeLUPxj9dxdvsJ9H+JjYEAVFICW/XokyQ+NgiL7fA9QpJFbNKoPjl15QZNXRNpaVLEepWkEBg06SOz9FtzWLiSLQbU6FzXKFI/PTZPz2WbwKsvik0TgtK/ko8vh7+XF9DEOJRUtRzc0R5MVwr0s0Go31Zfhb2Yonq8DwwZX/SyB1OplRCpa+ahJUSNRnwCqG8R/mHdCTszuunEZONF9/7ZJLsH/dN3qxKCXt462mlvJu0gHUxLN9c0g+8Pm5Sm4WZVj1rAE9E69hc+1Cnk9lTPUwNhlN9xQcfc5o0aaMzCYn0MPP01fIVu9rOULiN4A8jV67XO73+mXLTyzKngvVM1HRqg4MGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(84040400005)(451199024)(186009)(1800799009)(64756008)(54906003)(66446008)(66946007)(76116006)(66476007)(66556008)(316002)(6916009)(82960400001)(122000001)(478600001)(55016003)(26005)(38100700002)(38070700005)(71200400001)(41300700001)(86362001)(7696005)(9686003)(6506007)(2906002)(53546011)(966005)(4326008)(8676002)(8936002)(52536014)(5660300002)(7416002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7BngSOGOS6e+HsKD/X36XzdOciFsWFLuUy+Qo5c4AL5g4j6uVeY4qqgEEzNY?=
 =?us-ascii?Q?csmeat6q3MEVMPYbvKc5kZ0scCCytfQyOI6RbaH4idAmAH1RdAiiXSpF0qUs?=
 =?us-ascii?Q?Lz0DL5RHwZJA6UE3npxajrFR/h8RhzSGq27pMalIMl5EalPP5MToA0Ixf9X2?=
 =?us-ascii?Q?TI05/XBrZxjKtZ0fdjVyf5A5S9rfC28bdxD7eqmMRg803ZCosS/VRBrNQOgS?=
 =?us-ascii?Q?5PjBhUPlm7MqDZVY5V+axUUYWeOpe/B0zT6bOEAbrXNEJ7QJEzbjq5QVFSfF?=
 =?us-ascii?Q?Qo6/zAVrA9O/pegPqmPvQ5Zx+2+K0ieT8dJcmaUwiBvMV08cNglLsFp95JC1?=
 =?us-ascii?Q?BgnnuO9gj847tBs/msKGdB/7/Rx8q191MBRWivOmoUi9fO4WpXJld4b5fgnf?=
 =?us-ascii?Q?sodV8YWtH77ChfAM6M+E5iTXNFXHDpyEo2hA7gckEBAXO5tsOIL+It3YyYZb?=
 =?us-ascii?Q?+E4dFTPd/cV0h/7HuvAqk3MM84CwAy7AzJDxOyDylLJHIx+dW9RHSYuzPCyw?=
 =?us-ascii?Q?2JfBuWdLvqPvVMEp7x4xly+SC5fYx4TF5tyrU4Qiw2ta5sHw8DGs+Pla3Tth?=
 =?us-ascii?Q?0NZiD2mWAk/+1NFQkoSq6t3MLzUxJ6btDgPLK3nCim/eAkzEhjcJpcsWTMFH?=
 =?us-ascii?Q?oGXUh7UpP5aUk/hBLY94Cexr0ajKIH2SUzylkelEPfy2i7+ZPCFlmiZj9U+Q?=
 =?us-ascii?Q?YgcG2yD0c9UscjpyLeRKMloM8z8u+M0qMSLny/UO1HjeQ4rwLMBi0OBBMt0E?=
 =?us-ascii?Q?/ZJL00Q5owF9/uR7KEeBZnUoOXdCfh+1kGR0k6KB5oDf6QxhvJ9kKWYsMSkR?=
 =?us-ascii?Q?Qwgb3FgUL/gZI3tHsBkEozmZyNIEOLum8gLb+qI7ui2zm++uMTLDLtHnWQ6X?=
 =?us-ascii?Q?Ft2WFOa/KYKQCUFysNvxvYV0SLymeeYr+w/Gp4ZOgwcvp0WhhTSZHfRjVOhf?=
 =?us-ascii?Q?YC1ZAWErzlcDJHEBOqfZ8yRt0gp4nuOwQS+mBEJPKpzr03mnQMmrD70deDqP?=
 =?us-ascii?Q?rJIL4wLHoxaMxJ1zIH2gtYogo9a/Bu05SFJGsq7Ar1p8iYJud948p2kkWK5U?=
 =?us-ascii?Q?TWclfrDP5C2jRejO4jBKcMppU91i9eDM/njwokxBWlU5zQNDwbhCcfu1YO15?=
 =?us-ascii?Q?YypBYIcCGY8p+KCcYJEMllImllRQ2NCFt+DPu1CCO4kCsmxUuPuT7Qcq1Bhm?=
 =?us-ascii?Q?tfKZ3NG7+YrLAGdbGKGpi7nIxbiVUunwIKD0ypQ5xzHDs6ItdHZDIKzOO5y7?=
 =?us-ascii?Q?T9133yvYeaWH2MPhIes0/DnVxcmJZYZdzhfyZTVxmagog8VBpzmhugnAPpEO?=
 =?us-ascii?Q?DT0Y97mBvd6tMjQF2ZecIHMhHdMBHSxZjLmWC7EgxnY2GmMOt1IN0VKEO3/J?=
 =?us-ascii?Q?gKs0wZULtv4cu7U+agzI81M+ASZLha7pOio+e73Dm35UEZGLPRFGbmOpm54J?=
 =?us-ascii?Q?+qlh4JFsgxILp7z4OZ2e7lrgrWhiuiFgSHP+1W/gx0nEalkOO6AZj2eI1UqQ?=
 =?us-ascii?Q?oNP59JC77KGeXHRl/LUxxN7zRw97wktdQTJD9iTcIA7UrTkU/HsVyiyWw0fE?=
 =?us-ascii?Q?XKqIvyGTo+VdcpXvr2GijviVJGX+nLTiFH1BlKEV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df50eb06-fcbe-4bfd-4eda-08dba4807b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 08:59:53.7765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybkKrH3zC2Y6T8mSWgSSwlo5d6xav2p4kmPd12+KbfWBaf/UDCZxdHeNyOVffWKzIWxkAXD5SXLfXejnykSwye7T9YtSDzjUkVgQpRn2MxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21 August 2023 11:13 PM CEST, Jakub Kicinski wrote:
>=20
> On Mon, 21 Aug 2023 09:32:56 +0000 Michalik, Michal wrote:
>> On 18 August 2023 11:08 PM CEST, Jakub Kicinski wrote:
>> > How fragile do you reckon this setup will be?
>> > I mean will it work reliably across distros and various VM setups?
>> > I have tried writing tests based on ynl.py and the C codegen, and
>> > I can't decide whether the python stuff is easy enough to deploy.
>> > Much easier to scp over to the test host a binary based on the=20
>> > C code. But typing tests in python is generally quicker...
>> > What are your thoughts?
>> >=20
>> > Thanks for posting the tests! =20
>>=20
>> Hi Jakub,
>>=20
>> First of all - everything I'll write is just my opinion. While having
>> quite a bit Python experience, I can't speak confidently about the
>> target systems and hardware (architectures) it would be ran against and
>> what might be possible problems around that. I need your help here.
>>=20
>> From my point of view, all we need is a Python 3.7 and access to PyPI
>> repositories. This version of Python is 5 years old, but if we need
>> support of even older versions I can rewrite the code not to use
>> dataclasses[1] so we could go with even older version. Do you think it
>> is required to support platforms with no Python at all?
>>=20
>> Another requirement is the toolchain for building the module, but I
>> assume if Python is not there in some embedded system - the build tools
>> are also not there...
>=20
> I think the module would need to be merged with netdevsim or some such.
> The usual process is for module to be part of the normal kernel build
> and then require appropriate CONFIG_* options to be set.

That is really interesting idea - I was not aware about netdevsim, I need t=
o
investigate that possibility. It seems more clean. I've seen other modules =
in
tools/testing like test-cipher.c, nfit.c, ndtest.c, cxl.c or bpf_testmod.c =
so I
thought it's not too bad to have a separate, clean DPLL module directly in =
here.

>=20
> I wonder about Python availability. If anyone who works on embedded
> knows of Linux platforms which don't have Python - please shout.
> Hopefully we're good on that side.
>=20
> PyPI is a bigger concern, I think pure SW tests are often run in VMs
> without external connectivity.

Those tests are the DPLL subsystem tests, they are not meant to be deployed
on every production platform in my humble opinion. Tests which are "availab=
le on
most platfroms" are better than no tests at all "on all platforms".

>=20
>> I've seen other Python pytest code in the kernel repo - that is why I
>> thought it might be a good idea to propose something like that. Your
>> idea is also cool - binary is always superior. I am a strong advocate of
>> taking into consideration not only deployment ease, but also maintenance
>> and ease of read which might encourage community to help. I also see a
>> benefit of showing the sample implementation (my tested "dummy module").
>>=20
>> My deployment is automatic and does not leave any garbage in the system
>> after tests (packages are installed into temporary virtual environment).
>> In case any of the requirements are not met - tests are skipped. I've
>> tested it both on real HW with some E810T cards installed and on fresh
>> VM - seems to work fine. But that of course require further verification=
.
>> Till now only Arek Kubalewski sucessfully gave those tests a shot.
>=20
> Does it work on a read-only file system? People may mount the kernel
> sources over read-only 9p or nfs.
>=20

Since it builds a module and creates a temporary virtual environment in /tm=
p I
don't think it works for read-only file systems.

>> The biggest concern for me is the requirement of selftests[2]:
>>   "Don't take too long;"
>> This approach is reloading the modules few times to check few scenarios.
>> Also, the DPLL subsystem is being tested against multiple requests - so
>> it takes some time to finish (not too long but is definitely not instant=
).
>=20
> I think the time constraints are more of a question of practicality.
> A developer should be able to run the tests as part of their workflow.
>=20

That makes sense - agree. So Jakub, if I understand correctly we have a few
different problems to solve here:
1) how to deploy the module:
 - now it's separated, we should consider e.g. netdevsim
2) if we should have those tests a part of selftests
 - I would remove it from selftests and move it to ./tools/testing
3) if we should use Python at all:
 - fast to develop and easy to maintain
 - might be problematic to deploy (no Python, VMs, embedded, no network etc=
.)
=20
Do I understand our current outcome of the discussion correctly?

>> If you asked me, I would consider those tests to be part of the kernel.
>> I am not sure if they should be a part of selftests, though. Maybe a
>> reasonable approach would be to have have my tests being a "thorough
>> integration tests" and at the same time some limited tests shipped as a
>> selftests binary? I can also parametrically limit the scope of my tests
>> to run faster in selftests (e.g. only one scenario) and having possibili=
ty
>> to run extensive tests on demand?
>>=20
>> Thanks,
>> M^2
>>=20
>> [1] https://docs.python.org/3/library/dataclasses.html
>> [2] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html
>

