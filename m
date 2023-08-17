Return-Path: <netdev+bounces-28574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DA77FE02
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AEF282044
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402C174C1;
	Thu, 17 Aug 2023 18:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38B168D6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:40:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22130DA;
	Thu, 17 Aug 2023 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692297606; x=1723833606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0e+hE/YOu77zg0GGxIY2TLWEP33CjX/bQsSZ7oNwaM8=;
  b=R08nI2uSVJcO4slVVDN/j929txNXVGanbTtYI/Dy7VEU/A8Kr1fVqWwC
   lY8sFR1ft45GuXmDquapl682H8P6j24H4EDTTpzW1OidLCAsPV4SXFv4A
   6ISKsMD4ALDA/exKEI+zVWhfHSHTGNvkX2ohSjmamsPgl4oh0kEwxNedI
   Hvt9O6gblj5aWxM/z5jFoxV3cXmiNwejCmSRvQjVrTPNnLXZlWUxKRLC0
   uypqJbLOVT3Upy/aaUJOxyOzEORNC338GgLwjjI6WAp7annyEUIXIje7C
   +Jn0UJttw8pmnblgk5KWujDgGM0u1YiNkxpx1riE0yLYRIzbXtPaurr14
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371801309"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371801309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 11:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800153545"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="800153545"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 11:40:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 11:40:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 11:40:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 11:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+leG9CuO78WLavX2+9lbYgEsl164Vvorj91skxhJtLrKFnnAYNU8DA73nKOXr6lOk0JTP0wSBfplS5c7+M2d7yzJnBiFhiY3g/WYNujSXtboeW3T6bad+UiZrHk12gFkR3Va28EydaEMd48U4TMhwoBNRrnu6Tugkhug69otzbs46tv7LY76U4nBYB80TTsV6CmhGHX535MkBZn1MN08l6EF9VYG+sBZeHRReyPL+2VMydXHhOxSTzoquK+ech3lQKVuQpUfp0MLliStaOdhoWEwoLM04A0ujg7aWCdi9hlpjRBjHxiCPD4R7N+BfqEpGChfeK1q5d6X61uRiIsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7WYn2Szd1yotq0/CW/21WjT8+mrrsudTYEH8jcqNjg=;
 b=TlNdEH+u4shdyW7AfSumjusgTawt0ov+GdrU0IhZjU9rj/lpLP2oau5urNWDYTtB5t2NMMrUcNmklYNlFvTrU//6kleaffGTWvKsrcu5d+Jbm/cAfys65LePcm2gmMiLOD/0aI0dq03ym74JwFAA/+bgsAwRc/a5+G4/iH/aLB0fOFZLiNiGjW5d/jNugfe239ua2+7gOMpCbEjsbQP3Nhvmgv/wqlD7fD5rz5QGIjmnzZnCCXpaWmHuVM5m+m5Wnh5qGOArMFhlTar0oaorft+xDI9oQhOLjHzKNEPwdxT4WpoRcEnvnBWdKBvET71oKSieoSBy83BwknUD8uraVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 18:40:01 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:40:01 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next v4 2/9] dpll: spec: Add Netlink spec in YAML
Thread-Topic: [PATCH net-next v4 2/9] dpll: spec: Add Netlink spec in YAML
Thread-Index: AQHZzI8RrqRf3aKbFEyIwXcwF38l0q/qq3UAgAQtf2A=
Date: Thu, 17 Aug 2023 18:40:00 +0000
Message-ID: <DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-3-vadim.fedorenko@linux.dev>
 <20230814194336.55642f34@kernel.org>
In-Reply-To: <20230814194336.55642f34@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB7755:EE_
x-ms-office365-filtering-correlation-id: 0daeac0c-97fc-44d7-051f-08db9f515d4b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7CJ6wIyJty9Z5tjJqOjWjZp7KzRbbuUxnsKaCJhPIvtN1WcAB/gXziTJTaQ+M+L1gSBEOit3zukQA/NPwb6bndNz+UbYkAjPLnVPv1B4lt3BpGT+eIOqgFTS5hqP4IokaoPRmGBJBb2Si6MxnVSXmgucJYkwKQcTb2YAoka9ca4xh+VNlmPtfl28W9p0DciFPtp5ER8jHzhSAYY8DLPpcQKyF1BmnRRYv6Jm/8qgsPSY+QrBY06Nfmb0E77fYXbX21Zd/ASd3cX6PiMCGKXuNPs0EjtwirdAq1Y3m6EAtjfIhhVdFufPuHfOsTxKRxaVGTy4MT+po/p/b6fvxbbO1lP4OFoySZ3Qkq43w552ZBssO0Spvh8uPA62tZJj2AQFhO4N663DsXAZGb1r2kcbeBgmLXzacil4pOEk0J0TsMxd9uQqeb5nuZNypB3/6P1MyfA83yz93rNgp8DRf6RKVau4weJI7m6+vb0kDubCjYuGJeKK9UauNpQz7oYz9KtMRs+XLlEXkGRPnhYXzyY+MwcJssvyUDIPTo1ohNadd1E5qG/fCPIMg3rFZQ0awU7mw4HIow19/8sLDqbz+bR5jWrnSVT1Ko4OfJLPNm0Jer0VKfkFyp4xhscR+7owOOmT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(316002)(54906003)(64756008)(76116006)(66476007)(66946007)(66556008)(110136005)(4326008)(8676002)(8936002)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EK/xle91pj4xwfnPwF1y9AF2UQS4t4Zf3UnoaaW4Qj2sUBvmXXDpJQT2Kvwk?=
 =?us-ascii?Q?GaED+cL8GD/R47EbgNh/xOC/CYxcj3R9cbbyNKcM7Q97rDxpMkcLncOsGO0x?=
 =?us-ascii?Q?WuoN1/KOPCBosAO+F4mLzbq15Adskai9AymACe0NIBWFCK4yxmraFSOeAQ6Q?=
 =?us-ascii?Q?61IQ3CJDevC9mfLdjBv5Kt9euSdhuuyWltD964Qcbe49BvcA/lUrgWWydBiH?=
 =?us-ascii?Q?22YD4nVVOldCJzI8SwM9a4it1DvR9KtkyW/Mlju8BcEM4hJPJW8uulOqxOzG?=
 =?us-ascii?Q?NqSFpB0IiYmTM27yrlY36WwIqZgwooe442hnnnvDcAep+sjuQ1W/2owtfgyA?=
 =?us-ascii?Q?6DTgp9rJ31R7LjJIQAvRxmQ/rdFZ3MSGgNET0nbha+G9HNTDgF8giIYUlIFk?=
 =?us-ascii?Q?KQJlshoLsmlARDjTyFqshLNCtdWEMHp9wlwX94R8UIlAb/mRypqsIuMHLsI0?=
 =?us-ascii?Q?J2JlBF5rrEtPDn4OeL8wKQkVDL22pLB45ib2kUVRtO1YZx3jwvCI+KbV0EZr?=
 =?us-ascii?Q?p7sEIbLb3XgZb5cdL/K4VlFuxqsnWufKMbdyBz6WoM0gkudg41oAEI2g0opW?=
 =?us-ascii?Q?F2Lda+iUYqtA7nZjnnR/gM51ztB+HYGPYw129MGbV8+N3+reQmLHp+b/jfdV?=
 =?us-ascii?Q?ehRmyT3Bpe7U7UBUmwSdIkfCIfokZLDRTGYI3xRvUBd8d8WCsQ4Pd/o9XrAX?=
 =?us-ascii?Q?BbjY7uXv2DXnCVR61T/44booTfOFj0vpJ9IUDnvSR67stenLjUhcxT9yV8Je?=
 =?us-ascii?Q?0nbB00XAYBCmqqx51Lcn8H3u87q8Jh3YHXYARwtrpvhb/3PCp6GqdR5ZKy9q?=
 =?us-ascii?Q?5r+z6f0v3Xb6uT/O1bg1rQpC22WJM1/W08uSy2t31w1UKfSUjA90HpdsVoYP?=
 =?us-ascii?Q?CqgSSvA/8LJSPMgnRt78J66Z6XRAYkArkEmYHfnwADtru+mHzq8Dy5xG7jut?=
 =?us-ascii?Q?eErYfFSvfV42yFLogz43DUItEHgSN7LsCikLC22g4gZYkioEkRmEnphqFPkS?=
 =?us-ascii?Q?lgTk6IUjnbS2RFYfhKiVfuDtT/ckeNJgfE+8cwA5Wp7gewWhX1DpznMAtjGd?=
 =?us-ascii?Q?CzN7DPBudHAr+DVp5s50/B5x4/fY2jlNUOMWHW5sWQU3lNZPan4wsDxy2DqC?=
 =?us-ascii?Q?f+xHmxjgdalZkXYSvu5vBGKLIxjn/+J+lsqGdrU0qKZLEPFtAODuvnQ0PHYu?=
 =?us-ascii?Q?cbYMsm2YkSgAexRT/crNrfJu4V44vLxKVRHHsI8jLpJyT9IxgV6+XXtnrDis?=
 =?us-ascii?Q?VmwigYksUiU1xkN0ZdJRWeNQYQNu1EPLTBl6dvipcYsH4yJTJK9+Q2uRKfyZ?=
 =?us-ascii?Q?GzwQLR8F5pBg4E+aBvReJEIW4B6MLb5b2uS0/10ubBX8+z0xYcSfASM8en+v?=
 =?us-ascii?Q?ofHZjDjIQ2HDo/z7o9ESlbAj+FEtnVIM11r8tWa9EzmJmpK44xTCebjc321i?=
 =?us-ascii?Q?EMXNxJfaf4E0qU17UNpgMJoxImSU40r94ay7FDkMNazvBTi9kqBiEmE0GWo6?=
 =?us-ascii?Q?3o6uj6XkSybomWSolgyjyr2jQ72cY2I+58gzVFu/pXSc9xNErDburEHe4BTB?=
 =?us-ascii?Q?jK0Y3AKVQKW2TKrGPC2aiVta24AYrDgfh5LR5/11BJUBN3TYhW7uOs/ECbZg?=
 =?us-ascii?Q?nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daeac0c-97fc-44d7-051f-08db9f515d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 18:40:00.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0QIVt2sXYw2G+6JKUyoHEVKHr0Oe9IhJUsjk8geHcU1OCarL3/4enlbmUAUT2r8vknRVwmkdT82t4YQYGIbwB7YnH6G7BUk/Js5Nd6F8kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, August 15, 2023 4:44 AM
>
>On Fri, 11 Aug 2023 21:03:33 +0100 Vadim Fedorenko wrote:
>> +attribute-sets:
>> +  -
>> +    name: dpll
>> +    enum-name: dpll_a
>> +    attributes:
>> +      -
>> +        name: id
>> +        type: u32
>> +        value: 1
>
>value: 1 is the default
>
>> +      -
>> +        name: module-name
>> +        type: string
>> +      -
>> +        name: clock-id
>> +        type: u64
>
>I don't see a pad, you have a u64 without a pad?
>
>> +      -
>> +        name: mode
>> +        type: u8
>
>It's an enum, should always be u32 or bigger at protocol level.
>Netlink pads to 4B, you're not saving any space.
>
>> +        enum: mode
>> +      -
>> +        name: mode-supported
>> +        type: u8
>
>Same.
>
>> +        enum: mode
>> +        multi-attr: true
>> +      -
>> +        name: lock-status
>> +        type: u8
>
>And here.
>
>> +        enum: lock-status
>> +      -
>> +        name: temp
>> +        type: s32
>> +      -
>> +        name: type
>> +        type: u8
>
>And here, etc.
>
>Why are all attributes in a single attr space? :(
>More than half of them are prefixed with a pin- does it really
>not scream to you that they belong to a different space?
>

I agree, but there is an issue with this, currently:

name: pin-parent-device
subset-of: dpll
attributes:
  -
    name: id
    type: u32
  -
    name: pin-direction
    type: u32
  -
    name: pin-prio
    type: u32
  -
    name: pin-state
    type: u32

Where "id" is a part of device space, rest attrs would be a pin space..
Shall we have another argument for device id in a pin space?

Thank you!
Arkadiusz


>> +operations:
>> +  enum-name: dpll_cmd
>> +  list:
>> +    -
>> +      name: device-id-get
>> +      doc: |
>> +        Get id of dpll device that matches given attributes
>> +      value: 1
>
>is the default
>--
>pw-bot: cr

