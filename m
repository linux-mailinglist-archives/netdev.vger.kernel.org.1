Return-Path: <netdev+bounces-29273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B67782652
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91CF01C2048D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11918442C;
	Mon, 21 Aug 2023 09:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C862F50
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 09:33:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE93A1;
	Mon, 21 Aug 2023 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692610387; x=1724146387;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f70E1BzAei4Vd7QCd9/A1DILafprLD6f3wAC3RvRd5g=;
  b=Unfcbvr3xIYqIVhDApml62iF8Q3fac8SX+M7oxZMZ+E7Jd2L1xuO6Kmi
   vdWhJRgWwh/HQg8IOqrlFGNwWf7jiZ/2edmwDvOFRrsVTrdjY5sRNkz0d
   b0gpmZD2SKS3iOdFNrIQNlS7eG1ZewdfysCrsYuG1lood6oX0Ck77C1Tt
   83QPwfS4dGI1M9hZd+NrgiIDbm8z+Aj75B6oLtij2xlm0XTb04E/ZSMUA
   FncL5J55xV14cLhJPf0s1WSsPmycgreZS2NuGF/+8vOYV2TvkwQiyVqFy
   oRHD1N4NgNcTvYvnvLsUh5OzgWSdveAVO2Z1zqAtQFea0MvREZ8GAQs78
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373513354"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373513354"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738834863"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="738834863"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 02:33:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 02:33:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 02:33:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 02:33:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 02:33:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb/oNZ1NcZOJr0TaC2n9IWfsJc3HN+g99Au09D1fnP1eZPOpiKKfvlTsweR5mSRtxAJtPPHAT13cCR5ofSTPNVUWo1sCbsVLrhlP+GnnVtI4sHRqXTzmzQpwpDZLv2t9gS3wfTp5Kx/2kZi26psB+lbntWZn2VLILrRV18b3M12a5Q6YA8lPSUlXngZLnGxvakOb0WjODGTZDJQhx4+TGMc2V/+wn/c/j/F6mAEF2BKCUVg3ZyS9cRDWMmY9I0FHsqHEMEv/n8ifGi1XgBjUo3AHiv9eKw/T1K8mwiAqmaYftkYaZ82LH9Qz57QGGLBgkybqJLCw2PGnxtkY782Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xZ2EmLWT3waBb7y9YdHU3MZ1RspqcJ7B8hH4racO1w=;
 b=D6TgoW3TP+we/7BjHq1iLF1sNtcV4/IRp7/5pCgWcGLngfFuHEb951CJHqwRKH94Q7dnF3uueNNtU89M5eOMtrTr6nfTPS5tYqiR8h4smwQu3vzRVMUGVdl+SrF5fHwFDtLOeKb56+4FkN791tIxMeQ7IJzydyfhINgiGUv0jIPcSqM0iXEJLRmupQpn3fCN8k/6Z4DP+7+NrbO4uFLAtoceB0dWXfhVc5UZIs0xIS3ti47JT5bu4XZytsK+6KvI9NcN4zDO0yR0NSkFdETElQUWOtDvVZaEsGRd723kFgcKH7V1y5T1tdbGtq5Ir2LyaW1ox+LpjEgrP4kDwssvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 09:32:57 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed67:3510:8326:d4d5%2]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:32:57 +0000
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
Thread-Index: AQHZ0R7y+sClUTv/akmAx/gH3L3jSa/wjecAgAP0HyA=
Date: Mon, 21 Aug 2023 09:32:56 +0000
Message-ID: <CH3PR11MB84141E0EDA588B84F7E10F71E31EA@CH3PR11MB8414.namprd11.prod.outlook.com>
References: <20230817152209.23868-1-michal.michalik@intel.com>
	<20230817152209.23868-3-michal.michalik@intel.com>
 <20230818140802.063aae1f@kernel.org>
In-Reply-To: <20230818140802.063aae1f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8414:EE_|SJ2PR11MB7454:EE_
x-ms-office365-filtering-correlation-id: 0802ddc0-9d82-41df-d75c-08dba2299a5e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3lK7K/M7i8BkphkxD1T3Bv+GOxL+P7Y2PVCF1VQu7GaoBligRMX4yD2yY6OCa+AmerEyEN+tr3edLsmG+fs79fehiFr/mglvTcDrBW6aFoqHzRFT5d/Kk/NYiqHE2QmmdvXRKXQApg1J6Vz7D/JbI8Pd1UipTcgfeaaX+jH9qhIaMWK+FR9rVsk/vb94ADirVbrXimwMBqjmUrdniETvZT3HgWmYpjpVKboP5Ydwpmd9jigqt3mi9gq8frN24tGzZ0cMDVqHJeueNRQBeaLDr2Dfgjz77ZhjFbMtDzghvqBth3V3W+VTmsd39bCUUJCCnNV/QbkpRq4VkGFNGxwsGPBDyi1BDu8pNDbDiBsfNqxw5YaAxqSzpMjoDEGPoE6zWArKHsMvqJDgTqwUrKXLg+xm1RErGyfnzZ606C1ZEwAZQkebEMoY82BoYL2+T80f3R3FhnKyolsF6Z31/4imzvI0E0gdtOA1dCsrRy58U8Ohrdl1vjnjLAT0zs4FXEH4TQ/6V9YD30VMLp48y5PCs4pOnQ/fGdC1zAv3iGwS8cjESs+uKDGjfL5pqhs/UXDo/C35+KmRRMyEz3bAfr0THjlzYqr33lGaqLAh/StdtQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(84040400005)(451199024)(186009)(1800799009)(2906002)(7416002)(83380400001)(53546011)(7696005)(38100700002)(38070700005)(6506007)(5660300002)(52536014)(33656002)(26005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(6916009)(54906003)(66446008)(66556008)(76116006)(66476007)(82960400001)(966005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHpDQdsfSWB0KSCnkeO9R0LgW9ukRl6qHEEy6kGyg/NfKDNat9Vj+LOSYrt1?=
 =?us-ascii?Q?Vq9hnUMByHnP86m1mwEWkui6GLFhTIrGMDSVIO0KprMpW/j4h2V0Kb0I6BFi?=
 =?us-ascii?Q?cj3yeMOMgTqSL+o3DRR1SlQHWWaCAzNlk/lgR3y2q5yZXQpRLh3OnOwszip4?=
 =?us-ascii?Q?OnlOYgvdj2XL7XoHb06+jEPKtfU7wS0Jq94x5eosElYRwH2K3f/MYvPZTrQZ?=
 =?us-ascii?Q?MYQou28oTKIoO3Neg1dDcKDKj/KZHmFd0e7S96dIvELOdXZ46ZBxHUA2eR2d?=
 =?us-ascii?Q?U5x8wGDbFQHRKvaSTL9CcdRNcwrbdBsfQzOk6mM7sldRxhq0rSJ58aT3vzxE?=
 =?us-ascii?Q?7m2jPJ0y/SdEThOJ4Q4JUEf/N1XUGw2788ow+6n5Obv9svWB1mUu+qhWnU7Q?=
 =?us-ascii?Q?0y81LSL4wByOkxWt83lKnbknWYjf4PnW50DLRe/qGHP6P0t/oU5HBIkFBr85?=
 =?us-ascii?Q?srBMWYBLOery+TVSA2nef6INRQe73kuTOH9/cejc6KL4Mb77zMFTcc7jDhWM?=
 =?us-ascii?Q?Opk0DWJKIX84VOVZL+YNSde3srFZSB1OfEAVp8QuoyFOXdFvS3AvRzh1NpUr?=
 =?us-ascii?Q?y62eJEwi5QrLOnBoFz40JobMvFDGQ2BxP+V0Kj9DMS++k6h+4hk74kkgPG92?=
 =?us-ascii?Q?52BrEWzOMAja++bnPY17Zm4Wjqp4z/rUEd924OUM0uY62XQaLNKNSZfjp4S2?=
 =?us-ascii?Q?kMbfBCt3W+Uk7XZmJazSEwAuGsvh6Q0hKxBBjnaTUpyKx1uLKcLn6oarLpUG?=
 =?us-ascii?Q?GRbTzZSV6T17ac1H5rMCET58bGy5nRNDz+BYXUO1nzAWlUNxGClQzUWKFjgz?=
 =?us-ascii?Q?ouWV6zlXyOm7I7lDL35EVrtRDtDJpcWToYLZ06hkpsN01ttdarrxze56fqql?=
 =?us-ascii?Q?do8xKs2ja9Pet4l+RKk4220sIVPy43F1dKxu20Rh2gxaRKUCSWpVkLusT9Bl?=
 =?us-ascii?Q?WHOxuzr9eekMdhaladiDMPwp1TqudU482FdH1MRD6X6eAoJAELjqphMuNQkV?=
 =?us-ascii?Q?6iVFTVAbM14544j0TnAAhGrCWCvzOHZibJN78orZyqwKpgbYf+1OPAx6E3hu?=
 =?us-ascii?Q?4u9vOC6QGwevbnLcW0p57eEqoOKryd5u7Lk82SlW/YU019+wKN/GhyJP48XS?=
 =?us-ascii?Q?ya2Va1MuyTMAVxEr5IYjPKixMo5dT2twXHeIlNOsv4CaRb8s+kjshrgsSlQH?=
 =?us-ascii?Q?zB13tG/Mlte3dAA7KRRgDO0gkzjeZlLXgRMKHMnkAQpf38IpVR/biKFRQ6Wu?=
 =?us-ascii?Q?Vfkr4wyxWyX8h6K9L+mnuAAAZdtyG4Lh1eq71CSZUGsZUwCdNikcyRj/GjKV?=
 =?us-ascii?Q?8NTUsRNWtwjk2EzKjpEG7vBDf/n0hX1e2BgfDEzjKrMFlIzgC/Y/HG4AqRT6?=
 =?us-ascii?Q?9YTM/EP5spJ7XcudP1htAHpUVEXQ0gSbHo3JX6dmBEyTiclqt6R8rIGSKq4/?=
 =?us-ascii?Q?uBor36ptchBALLx9PBwjEGhj2u09ryt/MHubFnJ/nd04eBywumV8tfXQ2Zrb?=
 =?us-ascii?Q?MRCN8sWimIMk+bSNd21GtsqIyeGRxNXNiKYSoXaYniqrZHia/q4aERMEtPvw?=
 =?us-ascii?Q?8envFFZQTEafK0s5l2rMrxGzvkKz6pe+ovy0KSyD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0802ddc0-9d82-41df-d75c-08dba2299a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 09:32:56.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpF/jFNvRmqqOp/sE5u3K1EOhXAMme3aswztQuPN1w+xc07H3BhJeobeOTqw0+41E1zrIikLD+k/KWSPhQ1BQHw2voZ6w16dC2Eah+FFIds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18 August 2023 11:08 PM CEST, Jakub Kicinski wrote:
>=20
> On Thu, 17 Aug 2023 17:22:09 +0200 Michal Michalik wrote:
>> High level flow of DPLL subsystem integration selftests:
>> (after running run_dpll_tests.sh or 'make -C tools/testing/selftests')
>> 1) check if Python in correct version is installed,
>> 2) create temporary Python virtual environment,
>> 3) install all the required libraries,
>> 4) run the tests,
>> 5) do cleanup.
>=20
> How fragile do you reckon this setup will be?
> I mean will it work reliably across distros and various VM setups?
> I have tried writing tests based on ynl.py and the C codegen, and
> I can't decide whether the python stuff is easy enough to deploy.
> Much easier to scp over to the test host a binary based on the=20
> C code. But typing tests in python is generally quicker...
> What are your thoughts?
>=20
> Thanks for posting the tests!

Hi Jakub,

First of all - everything I'll write is just my opinion. While having
quite a bit Python experience, I can't speak confidently about the
target systems and hardware (architectures) it would be ran against and
what might be possible problems around that. I need your help here.

From my point of view, all we need is a Python 3.7 and access to PyPI
repositories. This version of Python is 5 years old, but if we need
support of even older versions I can rewrite the code not to use
dataclasses[1] so we could go with even older version. Do you think it
is required to support platforms with no Python at all?

Another requirement is the toolchain for building the module, but I
assume if Python is not there in some embedded system - the build tools
are also not there...

I've seen other Python pytest code in the kernel repo - that is why I
thought it might be a good idea to propose something like that. Your
idea is also cool - binary is always superior. I am a strong advocate of
taking into consideration not only deployment ease, but also maintenance
and ease of read which might encourage community to help. I also see a
benefit of showing the sample implementation (my tested "dummy module").

My deployment is automatic and does not leave any garbage in the system
after tests (packages are installed into temporary virtual environment).
In case any of the requirements are not met - tests are skipped. I've
tested it both on real HW with some E810T cards installed and on fresh
VM - seems to work fine. But that of course require further verification.
Till now only Arek Kubalewski sucessfully gave those tests a shot.

The biggest concern for me is the requirement of selftests[2]:
  "Don't take too long;"
This approach is reloading the modules few times to check few scenarios.
Also, the DPLL subsystem is being tested against multiple requests - so
it takes some time to finish (not too long but is definitely not instant).

If you asked me, I would consider those tests to be part of the kernel.
I am not sure if they should be a part of selftests, though. Maybe a
reasonable approach would be to have have my tests being a "thorough
integration tests" and at the same time some limited tests shipped as a
selftests binary? I can also parametrically limit the scope of my tests
to run faster in selftests (e.g. only one scenario) and having possibility
to run extensive tests on demand?

Thanks,
M^2

[1] https://docs.python.org/3/library/dataclasses.html
[2] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html

