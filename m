Return-Path: <netdev+bounces-37536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47637B5D80
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 12528281404
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CD2208B1;
	Mon,  2 Oct 2023 23:03:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1991376
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:03:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E45AC;
	Mon,  2 Oct 2023 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287785; x=1727823785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I98jjgGYr/CupxASmxpIZtTiM1+tx31NSxE7CEhUx30=;
  b=aBR/8xJ6pFtopg2GEn2Fb/7z5phMZC8gNJpVHI1O8z9cabPDy55wEv73
   qIaGn4Csm5/LQG48a2WIZp6srmQytC3cTxe/t4Mp5HL9WpSEC5rovy8vg
   v7AKMwVnAuiw1apeaAz4OfrYJd2ZYmDFUplicY1UXPd7uQ3T7ro/0K0jI
   KM9L+wB8Mfz7vZmEyqkzjp9l03Mkf77Ld4QdpzGGo/fqKyYEsBGCzlrmc
   U4bHIVOItUH+oFHBxIOD2kDIzRVE7nqFxtjp334GnYgYc4/jT5URpnHbU
   eW464wYG+Jy570+sN6kXNWeVsMceDGeoTzbrmw4is1Z89/XIQBL0mEVMl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469032131"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="469032131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 16:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727424271"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="727424271"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 16:03:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 16:03:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 16:03:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 16:03:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 16:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxwhgSgX+7gpjWHxbaY8fIvWv4j0J/Pa/hKF0yskvrraFJowui+JPR56pKReOM2xbi8A53m0FDFdtItkUJLGJpfL3vw1HMCP1zMqu1VORiA5W01EG8e81YHLRKgNjNVcWS5XxnzZeSN72chXwRNQTRrrP0ciXlYTpxIshsHreQdMYzGooSS+aJgjQYeqkGabFvVEcBdkmU3WPSvLJSEpxXLRuHdjjdfsfOS1+d/nDnOHrZM9QdvFcRoOABAuKbo9BFVJc1qHOhQKLlxnLluTRyNOhIp9h/esoh+F0q7okVDc51ci1rFrRb77iODiO+PBrf6p3ct4vru1uI+81drtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reaMD2Cb7bqH4kA5cvsFK1eAwSiBLVfUlQnIVTg8gKw=;
 b=kNx8G+vuegf1oKryYVJ3KGPzDLTiy0IxRaAsn8US5yG+Lw6IatX0vLerhEbO+0gpoBW0Va/NR+bNSRi7y1S8sMmElfiNUXRmKFH9OKy7LGmnrTG0LnP3yUUtW/cQQxW+VzvS4tOGMmUSQZEmFqt1C5XO7OsNT2ursZXBx6/677koJuC2LnOekVXEAkBV9V6bGhWPEpnl2g+Rv3aEQpKkc8ePk0Y7GdsbrsIPKw9UuiNZiDHj+Wis7GFF+PRINaZo7qJpTMtfJGq3wgu57Xc3QE76RlU0VPF+HcAhdD4U5fD3kFD1BKvmtTg7Cu5/OHwGXy6Q3vhf//+YL2Z9TRGqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.36; Mon, 2 Oct 2023 23:03:02 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::4c69:ab61:fea5:5a7f%3]) with mapi id 15.20.6813.035; Mon, 2 Oct 2023
 23:03:02 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Brandeburg,
 Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next 3/4] dpll: netlink/core: add support for pin-dpll
 signal phase offset/adjust
Thread-Topic: [PATCH net-next 3/4] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Thread-Index: AQHZ8STYBdXle/Bxd0eyxPCX/7DD6LAu+R+AgAebAaCAAA0FgIAAWKYA
Date: Mon, 2 Oct 2023 23:03:00 +0000
Message-ID: <DM6PR11MB4657C61104280788DF49F0E59BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZRrb87drG7aVrxsT@nanopsycho>
In-Reply-To: <ZRrb87drG7aVrxsT@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM6PR11MB4755:EE_
x-ms-office365-filtering-correlation-id: d24c3689-eefc-4bbe-32bb-08dbc39bb9e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cl0ifmj1j9ToHRWSXkYHTcXRbqJvbTnXO6z7S1G/e7ios4W9oBSwKlgpu7rM20F6PMW6qEF2HVlxB3a9YVBbiTSlVMg0xKkWvu+ig2SQFVdpNXN/iImH5eox7Wek4v7DYn1D70/jy0/NVLPmGOivaOr0UCK5UmhKMLIfLucm3EERDJ9LNK0fFpm66MLA/sckI4yJdQoWIxI8lroEH045hEnkoEQTk8SivVD03/O1aUtSXDCullZ0IoqGhgS0NgqqBKCQyYQQ5Twy0HaxxuwdKRH87+BVIy26RZynXq72ZTmhZX2qLilUnnmaLzqBnC0HlCLXuVPmzJC3fBz9wgGZbtSs2aqtdeL29tG8v9ufr443UiU3XMEecNg8yrOmMtMdSYAOSzYq2pIHRhDku30rhhj0JSLz2uqWO1EBYVui+oeakGjxHYYe8du0NRUrFaCOhlnbmK4hWcQapd5x/jTzQL6aIejchJh1R97x+wOHZUTypvs6tRihYqqUsvi4GEWSgc8cKKWYAl5iCKsqxYeTbPl9p2xVDepTPJLy5sZbXCHqyuZ7RXvDaffrQh8oEhEoZNKlTlfI9HRc1Qtc0WsNuPvD1LrnUtpeTQUEn38xIlnrY29q/YY3T0GiXMlcDo+z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(55016003)(6506007)(478600001)(7696005)(83380400001)(71200400001)(38070700005)(38100700002)(122000001)(86362001)(41300700001)(82960400001)(66476007)(6916009)(26005)(9686003)(66556008)(33656002)(8676002)(316002)(52536014)(66446008)(2906002)(8936002)(66946007)(4326008)(54906003)(76116006)(64756008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yiken9eRrMOPGxmKvJkaANSpwi97S0B8n2D/Z2LxIslrqWMBaGT79LKhPkUw?=
 =?us-ascii?Q?UUxEvYADTfgybdhEvBy5g222BSncxDTg23eXswpEepMGLSJgHgjr9YqOaHrt?=
 =?us-ascii?Q?K8V9zbAlhX+FfAWiPnW/TlJFemJvh0Mr04lWadt+QhbFVcCVb/Y6EiodZDu8?=
 =?us-ascii?Q?dOK5fqO/n/JaXQ0WqKiGfSlhR/hZK+90NGb0TfkhX4ZCw2/6Vj/SbjLrE2vh?=
 =?us-ascii?Q?uujaXf14KLiRI3BBfIgxLJriRVEWbhqIfvm5Vp1tMG+kKgzfkdQ3Ep26a0nx?=
 =?us-ascii?Q?/MtrWnwf9ZheaHb+ekiI8A2mcwKMJqRhWUQApzH0TRp+IQYPbDDPgTeso0Um?=
 =?us-ascii?Q?XTlfUuD0spGYnyEaxLUDY7XOXPwHjrpp6oqMn6cWe4e1ZVDrq06meXk9sW6N?=
 =?us-ascii?Q?g6d5+DpmsyNbex5SHkj4i6APDScXKVRySsgJPDElVeNXZ7K8s6TrWTzZuGqL?=
 =?us-ascii?Q?y5NK3tNouzTQf7D2z+b6lyEJIlhKI9NXnxjX44N39d+Xjvi8AMU40SI/KEFY?=
 =?us-ascii?Q?mhvGmAHCUSh+IJvKtDxnwAwXc42lb6HmXuIH858Sf/3klZIG4XIvAYA7Nnqk?=
 =?us-ascii?Q?bFU4rmyhT2L0pHak3WSpdDZ7c72zOasoyM4ZD4EbfGDvHc9snDWFcoSoKoC4?=
 =?us-ascii?Q?8BBrEResMXqkRPS+QrJgNJwITdBbhy6dCyck6YgxPlzdTRZbuhyfPpI6rFq/?=
 =?us-ascii?Q?2IaOV8akMjIx+VfdX3481x6ECatTw59KETqWsH/lUSpMmtA/TAv/dUOp77/+?=
 =?us-ascii?Q?Tr45boL/G+NK420p04OymRCsuzCfi0MLYEN4wEBOjh5rY2sR1+cHFIq0SkUv?=
 =?us-ascii?Q?zRaQbAOgF8jn/66tB9hcJdKmK63GEwhWxZHkBfam0rGEoTHRxtKJelaGHebq?=
 =?us-ascii?Q?3fAbYH5+18w5YcEKVDAW5DzTU5XqX6qCbhnLmZPjGKbyAgdqj90B8Phq5pO1?=
 =?us-ascii?Q?8HNIDwIEbe8wtjUkPbm04u8AuBRb1sB5XVeeaFgpHU8C5opLqY5ZLcCSnhk2?=
 =?us-ascii?Q?bfAyJkPDhv9yYU5hwxlpJrd87FHRBSlnaI2wN15l4j40WeItXIKQGW9bF6ap?=
 =?us-ascii?Q?h+25Fjg8LwGd6sm7GhH9roKyMt6yqXMfuTU87qFMmkEFcqujqbf6dDWbQvGH?=
 =?us-ascii?Q?ddKcMX3n6r/e3a08Hg2B0AdgF8gorRXojcb3ud9GBDm0dYuAtZfFybpHuzbm?=
 =?us-ascii?Q?Fou1s7xIXj9oBLi+RREQxGGNwJepyLPnkR3tRjF/nmgcwbv536Tqnz0JddMc?=
 =?us-ascii?Q?Tv+0I5VUk7xVCwpITXAa73U038ye+blsGaP6ZGDsIL3yMqzaL1mCuKWzd6Au?=
 =?us-ascii?Q?H5trYrxa2Ud5oI+KToXo493jDmWqDQXJ0tu64U0bFzEqW5wmYw0TFH6nmtOf?=
 =?us-ascii?Q?WktICwNrKyNm7NxVpQgWzoH9/DS+2dE2dCt2qBeiBCxoh9+Mrr40InK3dE0h?=
 =?us-ascii?Q?goF9QE8PR8CnUxtCYKI5rlrIB4bxG+Y2uz+FBNK+3hIiO/UpOe5/KAhxGkRL?=
 =?us-ascii?Q?Ksw2h/kKcPU39nbeJDbG9msykomPTOF5GuQgCIA8UEFo2e2yEt7FnGpBLF90?=
 =?us-ascii?Q?erAHLXf38ArCw90kO1qOhme79kjrhGVAO5skT+sBf4ZAuvmXrKrMjfB2myu6?=
 =?us-ascii?Q?Vw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d24c3689-eefc-4bbe-32bb-08dbc39bb9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 23:03:00.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QJ0Y6qEdZS1d4f619RXYWg2q1qOQy+GipNeDnKFHLpmkmy9Xt3KyEZtfcNENM4tGstxFpgGuBQwR91S9ri5jOTheFVrhmqcq/pGFoN+xWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, October 2, 2023 5:04 PM
>
>Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>Sent: Wednesday, September 27, 2023 8:09 PM
>>>
>>>On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>>> Add callback ops (get/set) for pin signal phase adjustment.
>>>> Add min and max phase adjustment values to pin proprties.
>>>> Invoke get callbacks when filling up the pin details to provide user
>>>> with phase related attribute values.
>>>> Invoke phase-adjust set callback when phase-adjust value is provided
>>>> for
>>>> pin-set request.
>>>>
>>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>
>>>[...]
>>>
>>>> +static int
>>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>>> *phase_adj_attr,
>>>> +		       struct netlink_ext_ack *extack)
>>>> +{
>>>> +	struct dpll_pin_ref *ref;
>>>> +	unsigned long i;
>>>> +	s32 phase_adj;
>>>> +	int ret;
>>>> +
>>>> +	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>>> +	    phase_adj < pin->prop->phase_range.min) {
>>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>>> +		const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
>>>> +		struct dpll_device *dpll =3D ref->dpll;
>>>> +
>>>> +		if (!ops->phase_adjust_set)
>>>> +			return -EOPNOTSUPP;
>>>
>>>I'm thinking about this part. We can potentially have dpll devices with
>>>different expectations on phase adjustments, right? And if one of them
>>>won't be able to adjust phase (or will fail in the next line), then
>>>netlink will return EOPNOTSUPP while _some_ of the devices will be
>>>adjusted. Doesn't look great. Can we think about different way to apply
>>>the change?
>>>
>>
>>Well makes sense to me.
>>
>>Does following makes sense as a fix?
>>We would call op for all devices which has been provided with the op.
>>If device has no op -> add extack error, continue
>
>Is it real to expect some of the device support this and others don't?
>Is it true for ice?
>If not, I would got for all-or-nothing here.
>

Let's step back a bit.
The op itself is introduced as per pin-dpll tuple.. did this intentionally,
to inform each dpll that the offset has been changed - in case dplls are
controlled by separated driver/firmware instances but still sharing the pin=
.
Same way a pin frequency is being set, from user perspective on a pin, but
callback is called for each dpll the pin was registered with.
Whatever we do here, it shall be probably done for frequency_set() callback=
 as
well.

The answers:
So far I don't know the device that might do it this way, it rather support=
s
phase_adjust or not. In theory we allow such behavior to be implemented, i.=
e.
pin is registered with 2 dplls, one has the callback, second not.
Current hardware of ice sets phase offset for a pin no matter on which dpll
device callback was invoked.
"all-or-nothing" - do you mean to check all callback returns and then decid=
e
if it was successful?

Thank you!
Arkadiusz

>
>>If device fails to set -> add extack error, continue
>>Function always returns 0.
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>> +		ret =3D ops->phase_adjust_set(pin,
>>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>>> +					    extack);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +	__dpll_pin_change_ntf(pin);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +


