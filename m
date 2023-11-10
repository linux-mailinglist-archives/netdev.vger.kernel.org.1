Return-Path: <netdev+bounces-47022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A947E7A48
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2003A1C20AD5
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324879FA;
	Fri, 10 Nov 2023 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jb/ljRCI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086479F9
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:50:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701EFA274
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699606244; x=1731142244;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWLDT7gHmqqOnjuwgeeYnxCgFIpH1JBikEkU6wNrnJI=;
  b=jb/ljRCIVng/faeH893ixnwbBBo6ACMbU5C+qlhTbuex/McESlt1rTjx
   OPr5nh+ax4X5dnbjkZqx9WTca7s4upzXt43j/Nzp/I7dDC1uq9kKBzQ6X
   qw3rwE7KqMHfTwZyPL9ohM+HQpFcV/5x0ukoIFXs0+Aq7qF9aiDg7PuLB
   gJHf4KdEtvjAiAMdBExJ1D/IyKalxOJKiFpnLJPtxmu4XgBcXJPX4awYg
   GgpZmEgouy64gkl0JZS3mNajfc376m9yJLMU+FylTGFou7cvHnLSnX5Oz
   EJci2rAe7zuIUAGfQUaKZZ3H5qjsu+4zZ+IMTGg6qWCMUf55g42NF5oxi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11703927"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11703927"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 00:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010905002"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1010905002"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 00:50:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 00:50:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 00:50:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 00:50:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 00:50:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD33jWyvH0crTmk5U/Quh68BW96Ut80IQD6JXTNIFidK0JBH0LFwnUcfaCdtUdqAeHSk0tz/OOhwYCft7rOKwTB6eK1DEDERd6VUJ8a6HAEavg/yXsQwcxTBIfiFB+J4mx+HmXnQfEkJf/1d/FCDOBovZdyK/jDLvMWuE0/beY23Is7pNyJWaaPBFLSb11byPoIbj5sccTt7LIeL6sY8DvvSzMRpIRKRwxoh5amWLImxBDIORdPLoWR34j7tlm1OMqXZmIRqJ5PaUGBHvvzdrHsT9yT114kiXealr2AP0mMJvPzLKeVAgMSZJCI1U2dAz+Qf92SoEuuhbKicuTJm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJMafCMesH6LGE0np5AY5mXabUDUjeAm/Bw/rGsQRGU=;
 b=bAMXC8ozwsm9DY0XbRUPPcUJM5qN887dDv9X8+Q2PzMLNMrfjFu/gjeIEUljylS9UUciFR4e/P68Gks1tQkPdhHn/MyHxQsg0aeGOA34dK8IFVmP9C31zmsY7buRRILTOuHWmiSC8mmldyJ1S5919VAXAp0/26QDcnM95lK0APDKPcd8UykT5xnqIOL/k30bGipQ8ohT6tFkh1pz3qtsvWBMXRBdYt1AgKbOU8jIfE46De+5yrnAR8x6XIWD9RJKcAGGSimvo0V1s1iwSsSuqaCt1m6TLWuEQrX1r8a9JWASQAa19QZJsOUfhDy1OmrH03A5QXDDDoeGsy7WYHNhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 08:50:34 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 08:50:34 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Michalik, Michal" <michal.michalik@intel.com>,
	"Olech, Milena" <milena.olech@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Topic: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCCAABIKAIAAOifwgAA9V4CAAFdrsIAAfgiAgAAfzpA=
Date: Fri, 10 Nov 2023 08:50:34 +0000
Message-ID: <DM6PR11MB465767D550C3DF2CE24E70EA9BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
 <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fFz+GTdqjA7RD@nanopsycho>
 <DM6PR11MB465763E8D261CEC6B215358C9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3SJdlOwoFOEavA@nanopsycho>
In-Reply-To: <ZU3SJdlOwoFOEavA@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MN2PR11MB4535:EE_
x-ms-office365-filtering-correlation-id: 51d01d6f-9b60-45f3-8dd2-08dbe1ca1a39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10mmeZOlKwl7llHaiutvf3O6ZbMkzoV6OcBx9qmAkBAzwMqJdKYkVKEjHaB+hnYh8ypd4wehR/SjdOp6+DaNpPn3eOe7dWRH4VPJc0NomcP7P3CY4kypHkH5GeB/AWMgE5RDUfLJqQElmlZilCLqHgROUb7HN1b9/HZfEwqTVc+yymqGwaQB3jYeydoFRnG15C4FYw54NrkXw/acBSMO+XlgfK5NRwIcTVK1moPyRrpRMWyNNkQf0480eRmsEwk1+WljZ19D/tRS4pmMyLHmOdAFVdHnv7e2lDRpkUyq5iYJAoQT3aPkLXgWJaYELebdiL85wlaczbgEsbAJWl5ZKlXXX5zEGDb/zQrGBjuBzjZtcvUHwq37GHDKM0n9o65UsOHDtM+ZUIV+njyS7XU7Nmweu+8+q+mMCGlEi6A/BxAAEs6mPgJh2XWBF6X2vf02CqwNNrN+278cwa7tCd6ejKAIE80QrYDxhibvTEDtl4CVcIQr3jrJCWNzV7QvKqZSdVs1LBFFBF1rBlrSzxpILFJ+aAGuAr5Mv17bnu6hopgKIOtVPnySfWxC69juzxu3hpYIC2ZRh2wg6JDRs1JYZdwTVPtgvjtIhTQc/qxjfuwIpVKe//lI180v6o9nJjos
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(7696005)(6506007)(83380400001)(8936002)(4326008)(8676002)(9686003)(54906003)(55016003)(66446008)(52536014)(64756008)(76116006)(26005)(6916009)(66946007)(66556008)(316002)(66476007)(478600001)(71200400001)(41300700001)(5660300002)(38100700002)(122000001)(82960400001)(2906002)(33656002)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T9KX5YUK8gnULOB0WRbti6F5X1mJflPX9l/dnDRnuzaDLKJ31/I9LyxFhpG9?=
 =?us-ascii?Q?BMR6jgIlVVapwtIULTQFsKKcl5pa5yiBoCcQYZLXXEHUx88Gx5QPyjmDkMgL?=
 =?us-ascii?Q?NmwxFm09RnPe1oA8Rx5WTeUhgZC3lN0keAz+/3CUDonZE0AZyz75iuEkvqm0?=
 =?us-ascii?Q?kyomOehq5rnD7hJhzd4Dk18wGOzz9g6PkHXwh/bnU+TpmLXAAg3Zefe3HroY?=
 =?us-ascii?Q?O4/YgiTUnk60Lj3BSyeR0++Wmm1Jc8WwFMAYd3q/rZC1dnlgR/piv5mrqcAM?=
 =?us-ascii?Q?S8i898aEU0ZmyrMeuYBlk8tj7A1EyR6mNtIQj1YztLxaIvt08R9IluCBcv0D?=
 =?us-ascii?Q?nuKgjKbauUDAENBpyNWR/KyWeJ3zcvHtOxhKN5/L3rzblR3n0EQMzYknoKCz?=
 =?us-ascii?Q?QjvQp9EJuZuIBKgQ2T8mDCXe2hF0qmdkUKrY/P2jLjiuO08pfKyyTBcrNhG8?=
 =?us-ascii?Q?jSMUWGIPJq16QcFni0nUUysvI3V9+UrLuGgSY5KWNzbTD9FFpY3XKevGOGds?=
 =?us-ascii?Q?JtiupEwmYlYpceLRbH/4Wsiqa14tlNEVM7vgWzzFwiXwk7YDYUZpMq4ZADdO?=
 =?us-ascii?Q?X2vCpFTuERCAOB0OKtA+1AFVlLXBodyz3EqtyRgi6Nf778GEcSA/Jn1pakRj?=
 =?us-ascii?Q?NRDfl7ivyoAXjQ6JYK6jL8xk87GODkV8P4O8fG9q0Qnx+lR8jkSOYncfIHS6?=
 =?us-ascii?Q?R2SrbYUJQo2ptD7/AHhlCCrjd5hWLhdbE5X2WmSVuoM35PyAofmWNipRABwU?=
 =?us-ascii?Q?+H0VRsMfURjwa2plKMF9D1+1Ka5ostE3e6azvw4xM7dK4cYMpHq6MMhmNN1y?=
 =?us-ascii?Q?R9qMKb3zY0kzY3VIDXzz7XWvaxCWCxKM1jPDT1zwVNLi6vxhE5wPLsaloq33?=
 =?us-ascii?Q?Otq+1nXrNndMP2YhvO+R4+fMHL58ZtHV3c5gNGAUKGFom7WnN4LSNq/n8P67?=
 =?us-ascii?Q?YnyOM0sQLRU727rsRSHZEP+y2zfN/Kxe2bpFtQBmCEjrmdCscLOW3aIEusdD?=
 =?us-ascii?Q?SpupdMxnuR/MSesF3D91L/yFUpNs6yCRcxrq3vYSrEBT2MlWbM+aGKzac03n?=
 =?us-ascii?Q?7LlDdESXQRehnTpVimORNT5Lnk0v7dPYQN3mNJx/BuGXRey/CHxqBiKWXNaU?=
 =?us-ascii?Q?BRPaYdoNNcwQ5/OKvmqbrtDjkkU6mq73tNSUwqUbMcw7YzSDXZ8Ryhcn9pI/?=
 =?us-ascii?Q?L+Ek6B8XBznz7vss1C1aiWxw5ned4qJnPnqewrJ9k2a9qYzlygbQG9llNKzE?=
 =?us-ascii?Q?pi/PPAEZFI4bLxpR54Dz5/AKJwtEz+5DuKWIRojjdDzBkkIJd4dtYN/IT+h9?=
 =?us-ascii?Q?IbKB9snjhFfEBsVNVQhcwro4euAGJnU0qbrbSZDk1K9nIzw32CooNzzWnFh+?=
 =?us-ascii?Q?25028qmb65q+r+QSOs8D3yJ/lnMujdhwP+roHgWwnbwZ+9mV8D6Vv5PBoK/v?=
 =?us-ascii?Q?2xtzLXDSTvV6fA+qIlxILrdzX3th1Zf195N5wh05qGOJ/ZSrqr5Z0dgzGpDB?=
 =?us-ascii?Q?czPs4rBPYaXfv/BjG1H+I2lGXjTf+wly7bF/JVY4lMfyb6soB0kH0urIDAUj?=
 =?us-ascii?Q?Z8kc3VyPhbG82U9SrPqji29UQcwEKTgpcIrM0fekzEk9OFi2ddsOCCbYTq6g?=
 =?us-ascii?Q?OQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d01d6f-9b60-45f3-8dd2-08dbe1ca1a39
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 08:50:34.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ds26qYtXx5OV2si0ZZnOwHILoAiY0xfKYlaR1ci2IXAK8bF0+77KjHwOAbZgSQisi84bq+Rbvd5qDJ1LsPsCXLy/yr4yIBMQv/BVUKdwO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 7:48 AM
>
>Fri, Nov 10, 2023 at 12:21:11AM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, November 9, 2023 7:04 PM
>>>
>>>Thu, Nov 09, 2023 at 05:02:48PM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>>>Sent: Thursday, November 9, 2023 11:56 AM
>>>>>To: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Jiri Pirko
>>>>>
>>>>>On 09/11/2023 09:59, Kubalewski, Arkadiusz wrote:
>>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>>> Sent: Wednesday, November 8, 2023 4:08 PM
>>>>>>>
>>>>>>> Wed, Nov 08, 2023 at 11:32:26AM CET, arkadiusz.kubalewski@intel.com
>>>>>>> wrote:
>>>>>>>> In case of multiple kernel module instances using the same dpll
>>>>>>>>device:
>>>>>>>> if only one registers dpll device, then only that one can register
>>>>>>>
>>>>>>> They why you don't register in multiple instances? See mlx5 for a
>>>>>>> reference.
>>>>>>>
>>>>>>
>>>>>> Every registration requires ops, but for our case only PF0 is able t=
o
>>>>>> control dpll pins and device, thus only this can provide ops.
>>>>>> Basically without PF0, dpll is not able to be controlled, as well
>>>>>> as directly connected pins.
>>>>>>
>>>>>But why do you need other pins then, if FP0 doesn't exist?
>>>>>
>>>>
>>>>In general we don't need them at that point, but this is a corner case,
>>>>where users for some reason decided to unbind PF 0, and I treat this
>>>>state
>>>>as temporary, where dpll/pins controllability is temporarily broken.
>>>
>>>So resolve this broken situation internally in the driver, registering
>>>things only in case PF0 is present. Some simple notification infra would
>>>do. Don't drag this into the subsystem internals.
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
>
>No. Your driver knows when what objects are valid or not. Of a pin of
>PF1 is not valid because the "master" PF0 is gone, it is responsibility
>of your driver to resolve that. Don't bring this internal dependencies
>to the dpll core please, does not make any sense to do so. Thanks!
>

No, a driver doesn't know it, those are separated instances, and you alread=
y
suggested to implement special notification bus in the driver.
This is not needed and prone for another errors. The dpll subsystem is here=
 to
make driver life easier.

Thank you!
Arkadiusz

>
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
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>The dpll at that point is not registered, all the direct pins are also
>>>>not registered, thus not available to the users.
>>>>
>>>>When I do dump at that point there are still 3 pins present, one for
>>>>each
>>>>PF, although they are all zombies - no parents as their parent pins are
>>>>not
>>>>registered (as the other patch [1/3] prevents dump of pin parent if the
>>>>parent is not registered). Maybe we can remove the REGISTERED mark for
>>>>all
>>>>the muxed pins, if all their parents have been unregistered, so they
>>>>won't
>>>>be visible to the user at all. Will try to POC that.
>>>>
>>>>>>>
>>>>>>>> directly connected pins with a dpll device. If unregistered parent
>>>>>>>> determines if the muxed pin can be register with it or not, it
>>>>>>>>forces
>>>>>>>> serialized driver load order - first the driver instance which
>>>>>>>> registers the direct pins needs to be loaded, then the other
>>>>>>>> instances
>>>>>>>> could register muxed type pins.
>>>>>>>>
>>>>>>>> Allow registration of a pin with a parent even if the parent was
>>>>>>>>not
>>>>>>>> yet registered, thus allow ability for unserialized driver instanc=
e
>>>>>>>
>>>>>>> Weird.
>>>>>>>
>>>>>>
>>>>>> Yeah, this is issue only for MUX/parent pin part, couldn't find
>>>>>>better
>>>>>> way, but it doesn't seem to break things around..
>>>>>>
>>>>>
>>>>>I just wonder how do you see the registration procedure? How can paren=
t
>>>>>pin exist if it's not registered? I believe you cannot get it through
>>>>>DPLL API, then the only possible way is to create it within the same
>>>>>driver code, which can be simply re-arranged. Am I wrong here?
>>>>>
>>>>
>>>>By "parent exist" I mean the parent pin exist in the dpll subsystem
>>>>(allocated on pins xa), but it doesn't mean it is available to the
>>>>users,
>>>>as it might not be registered with a dpll device.
>>>>
>>>>We have this 2 step init approach:
>>>>1. dpll_pin_get(..) -> allocate new pin or increase reference if exist
>>>>2.1. dpll_pin_register(..) -> register with a dpll device
>>>>2.2. dpll_pin_on_pin_register -> register with a parent pin
>>>>
>>>>Basically:
>>>>- PF 0 does 1 & 2.1 for all the direct inputs, and steps: 1 & 2.2 for
>>>>its
>>>>  recovery clock pin,
>>>>- other PF's only do step 1 for the direct input pins (as they must get
>>>>  reference to those in order to register recovery clock pin with them)=
,
>>>>  and steps: 1 & 2.2 for their recovery clock pin.
>>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>> Thank you!
>>>>>> Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>> load order.
>>>>>>>> Do not WARN_ON notification for unregistered pin, which can be
>>>>>>>> invoked
>>>>>>>> for described case, instead just return error.
>>>>>>>>
>>>>>>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>functions")
>>>>>>>> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>> functions")
>>>>>>>> Signed-off-by: Arkadiusz Kubalewski
>>>>>>>><arkadiusz.kubalewski@intel.com>
>>>>>>>> ---
>>>>>>>> drivers/dpll/dpll_core.c    | 4 ----
>>>>>>>> drivers/dpll/dpll_netlink.c | 2 +-
>>>>>>>> 2 files changed, 1 insertion(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>> index
>>>>>>>> 4077b562ba3b..ae884b92d68c 100644
>>>>>>>> --- a/drivers/dpll/dpll_core.c
>>>>>>>> +++ b/drivers/dpll/dpll_core.c
>>>>>>>> @@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>>>>>>>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>> DPLL_REGISTERED))
>>>>>>>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>>>>>>>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id,
>>>>>>>> DPLL_REGISTERED))
>>>>>>>> -#define ASSERT_PIN_REGISTERED(p)	\
>>>>>>>> -	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id,
>>>>>>>> DPLL_REGISTERED))
>>>>>>>>
>>>>>>>> struct dpll_device_registration {
>>>>>>>> 	struct list_head list;
>>>>>>>> @@ -641,8 +639,6 @@ int dpll_pin_on_pin_register(struct dpll_pin
>>>>>>>> *parent,
>>>>>>>> struct dpll_pin *pin,
>>>>>>>> 	    WARN_ON(!ops->state_on_pin_get) ||
>>>>>>>> 	    WARN_ON(!ops->direction_get))
>>>>>>>> 		return -EINVAL;
>>>>>>>> -	if (ASSERT_PIN_REGISTERED(parent))
>>>>>>>> -		return -EINVAL;
>>>>>>>>
>>>>>>>> 	mutex_lock(&dpll_lock);
>>>>>>>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops,
>>>>>>>> priv); diff
>>>>>>>> --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>>>>>>> index
>>>>>>>> 963bbbbe6660..ff430f43304f 100644
>>>>>>>> --- a/drivers/dpll/dpll_netlink.c
>>>>>>>> +++ b/drivers/dpll/dpll_netlink.c
>>>>>>>> @@ -558,7 +558,7 @@ dpll_pin_event_send(enum dpll_cmd event, struc=
t
>>>>>>>> dpll_pin *pin)
>>>>>>>> 	int ret =3D -ENOMEM;
>>>>>>>> 	void *hdr;
>>>>>>>>
>>>>>>>> -	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id,
>>>>>>>> DPLL_REGISTERED)))
>>>>>>>> +	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>>>>>>>> 		return -ENODEV;
>>>>>>>>
>>>>>>>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>>>>>>> --
>>>>>>>> 2.38.1
>>>>>>>>
>>>>>
>>>>

