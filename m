Return-Path: <netdev+bounces-21625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394427640F9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620941C213BA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DD91BF03;
	Wed, 26 Jul 2023 21:11:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3071BEF1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:11:51 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F88C1BE2;
	Wed, 26 Jul 2023 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690405910; x=1721941910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FiEs0ld4n+y2Qn5Be/OnLGtKzZ5gKq0AaxYUbdCQwEY=;
  b=aZe3Wd9azoi7YR7eTLqZMwqakulFpaxx5i+h19ARok+tnTVseOSEAWuG
   9VLtbKCXp5xsJLi5YmmWqhukDQ8QYJO0MojeChMBvTDEwKOnEHfUFb8OF
   7LuLxDGSc9IYhGAqwlgKe4rrKllTfHhelPkE09jQp82asydAoYC1nlJgy
   pSyINwgq2DuIwivwIfH/OpkZPYUPq+st/FxiMhSDqByYYXn4GmAxw2zXg
   F6N2elRdVLXkq9yvDwYQNhRAFHVGm23KrJctbX53Qc2JShiuxTPz8pycF
   JSZzWXpDrnKjNewXGsnYbL1CcDLw3aTJmtn3SV7C8XlI/DMOFTp0sO+Rn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399070325"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="399070325"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 14:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="796720456"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="796720456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jul 2023 14:11:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:11:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 14:11:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 14:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvU46XsrFmv81AUR+AIBj4nrWYX7yHwkVd604bTmwlqNd2BtfhflnXCtJQmZwktOWXOr2W5RtHoI+wFTKExvQ9GCvie/p3otR/p4BNj+CgmvE0MUY3DOcD1NMDC2ZQanMDsT9NBuheN67k/88RM/eoKJFXKA8AyojwAy9elreDhAZYKDOs8eEZ+uUluPH7ZQ7Jl9dBNgaCq6j6V4jJF0L9m13JFcswQLImNDIK8ShQtogvI96Jw+7D3Hbi0BJxjQwJ96Y/ySDd+lxJiZXks+vt5nx8f+J9tB9v5z/ay+PL6hbwrNsrrHNwwY6BxDK9Luv8r9NAkOCgBLbz9mQfAFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wC5Tdl/VJ8maLDMJvh7Z9PA5AFc40bTMx3YaDtNEaKU=;
 b=P42c1p6wevbo9ANcFm7Exwlyz8lbtK4wW7xP7OQz45ZkBH0f5CFf3FTjhFvCvhzxBNcAskw/PKMvLoirAVwPzZDVl+uNPDTjdF4vDcG1BNUaJIWOjMsgz9eGf9S/Hvpbq4WV6BCtNM7DzAZlnM7l79nUYFsxm61oZFffZ5lrZ/Kfc+4vwSn0TVQjkIEtfd7PhXDtKaP8MCPJ6/VezA2MjBBiZ+piZuCADKqw3M9otpPJ2ogI5AAHakGHu6ZYCEJem1MR+5kjZqOhQKnNYE/RuyoiFF2+RsEZrUznkDyrETw1iHIWvj+eElnYIB1a9m+GFiZ801u5zesfKDPSDaN07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Wed, 26 Jul 2023 21:11:40 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 21:11:40 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCAAA2wkIAAMNUAgAA4eDCAAMCPAIADo+2ggAErQoCAACfLUIABUpiAgADz3gA=
Date: Wed, 26 Jul 2023 21:11:40 +0000
Message-ID: <DM6PR11MB46576A241EA1519BC559B5C09B00A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
 <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLqoMhxHq3m4dp1u@nanopsycho>
 <DM6PR11MB46571D843FB903AC050E2F129B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLt5GPRls7UL4zGx@nanopsycho>
 <DM6PR11MB465713389A234771BD29DF149B02A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZL+B48Om/cf61/Vq@nanopsycho>
 <DM6PR11MB465734F6AD226A39DE8574419B03A@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZMC/TRSYqMQ57Rf7@nanopsycho>
In-Reply-To: <ZMC/TRSYqMQ57Rf7@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH0PR11MB8088:EE_
x-ms-office365-filtering-correlation-id: b939ac9f-6b20-413c-34e2-08db8e1ce7cf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBxdIegceScyKJEcQd4xJz5VkLYx5bhCPK/APQeIUpqXpbLyh2dzXZ/bf21AntCuYsAZ072KsENf/nyJj/0+HviW6Ue8Mxsu7lKpA82xl7Bv99l61EhcJYZLjZJW8F0KriTdYABwX9A85YyPWdBofP+rJj8MKcgvNBv9Vp+mkngN7336uJLkKKdFwXB09iMrE6dhBlvNa3/hV9zFcc3zbaKU0tjx3rD5/pfOHM3C4OBjNROKOsdqMXeixriCVD2Iits2MSXR5vbHN9OOxftXwWhtWFdIXJPTPGY4KVR4Uh7BdClPt78M17lLPEFOe2jcieEpVB6YrelXFq9mhn7U+5Nn0zKVvP6cbJZbJWm4YW/OkOS8aRTwVj9OorMsWN3zcxX2Ms9Z5m5/3zJ4fjsYXQ64EFFmqEfDC2B4w9ZJzw+5wiVrARMJfPq0RcnZD+iJe3kaUoFNzhJ9ysRYtx1c7cnlY5wojDhrgkmPW3B1IFtNF2w1KtJiI+bhoG44CkQ28CGLdP8P4OJ9IQBuG0INRfzCQmYyBT10zr0l8WEJJRk2E0FiReZ4CL6MvAXFeWHcZlg1q2ATFoLgGxKvmRcQB8N/FnGr10gyEpLqMA/CI1JyhwxTBSHhf3d6tPNN27Bz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(2906002)(71200400001)(186003)(6506007)(26005)(4326008)(38100700002)(122000001)(316002)(52536014)(41300700001)(33656002)(83380400001)(66556008)(66946007)(5660300002)(76116006)(66446008)(66476007)(6916009)(8676002)(8936002)(7416002)(38070700005)(86362001)(55016003)(64756008)(82960400001)(54906003)(478600001)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jyjNWRDJf+sfkEAV2I6WjO4uFKz27vuNJfwt2ptcYgKMnp5Anv4MfraWvSN8?=
 =?us-ascii?Q?giZ8+4RhNpSLDeECh8FhImUSAyvQ4SgpHLrCVRx1KKueAqAJo54g/DIA0Nyp?=
 =?us-ascii?Q?9I2ojl+Is+kWbqC14Kr3qf6MUBhkeXEV4wA5bItM7+hSr/A37Ug/aTR+wSvO?=
 =?us-ascii?Q?Ex2yUfYkzFIvWjqmGGzBf2k83Kd2U4QeeYul6//ynBIKHedL3LH2fQx+quUX?=
 =?us-ascii?Q?ImK8hYVKi1Mh6RiU69qexk1bZNyxrG+03xGA763R5dVnIAF05tWY29kZXhCS?=
 =?us-ascii?Q?n5GFlO64TD/PTg3YIxm2Iq8d9XIFdQUhUy6eBZT+VStZYfaMILDFeJDVaypk?=
 =?us-ascii?Q?7WXDQRmejRxYm367PKt/XItATdzdtiOPu6ySVX5RHlrpD+b0u4fCQHQaIrV1?=
 =?us-ascii?Q?Q/LAE/6f8MW7B9090Kfd8hRJoUCLQ40Vy9UohyPqgH3DIxAKYynKTlsOt+iX?=
 =?us-ascii?Q?7w9sli8tPoeAPawM2pZOtSkfHOMmyIPsolnKjpqzSFqCuIs5w0f5ZPtYJ2HV?=
 =?us-ascii?Q?V9cEhw84xw+2wY5VkyfQZNTfOIxrt9hxW/GbGKd8Xrtfhq6hzDzsLx8fcE8B?=
 =?us-ascii?Q?w6JEBuOkpL8lZgTpEwIhZ/BnsbPFCXiKCVrXvMO0ZRmS4JVmlit6B+9CAs/r?=
 =?us-ascii?Q?ZleGmbsPikoBySBcWvoixvznDBQbgspefbMycpf6r22OVKLR84w9wNR2G+Zh?=
 =?us-ascii?Q?gr9RB7ScQ5EyEBHQKPV4Mu0UTrfshvFMtBd2T5eukLh885ra0GDyO4R8D2rt?=
 =?us-ascii?Q?WGLKGfj1d/DZZsmaOUmOLBT5GcstslrD+uyAUQ3lmIgLs3NG1HfpuGRGdDSK?=
 =?us-ascii?Q?CdFM/Iy3FUsuWbry2KflUbqY/Pb4HQI+Id9zPgDnnWh1BhFo1ygNrd+rNq40?=
 =?us-ascii?Q?P/6UTJkEpGTIdrw8BYu6eUeXUA7hrJc91gox0PXcvuhO/zNAM7vv49y856+H?=
 =?us-ascii?Q?tpT2j945Hfr7BrzScu3q+73cr00UQ+22UL7AyOk+2rl1JdN+RRwZdoia/U3j?=
 =?us-ascii?Q?9tmQOc67CStw9Wi6y8QjhXMGsMH4rod75nFiE3DiGmxZLJDC8lh4gver0a84?=
 =?us-ascii?Q?K1rCc4j8hVMU3c9Abb1pubusVoWQ7/Vi6oTxRKkvx1BMCInwILLZgOxnOxdy?=
 =?us-ascii?Q?yR9YkRvvr/NyqDhkbwdri3UjKe2ucM0AK7Ry6ZOTgQh7o8UCncbICvTGUbkB?=
 =?us-ascii?Q?pfE1squCdaUOXtfDzgiHDHM/eYU8ghWcQyjIOxEm06Q3IFeRLxEbf7VG+U5h?=
 =?us-ascii?Q?7YGaAI3uQU65PpmuSigwcBrDxEhqc4bl1oTuxg9Fce/20AGRc7ONIOi4KsLu?=
 =?us-ascii?Q?KEbKgq9AxT/C6xogZNbDzM6ye1M5vqfxjB+mTRgSMLOJCCI32w/CbLuH3gV2?=
 =?us-ascii?Q?SjmKnf+wQQMjiIeKqou5hvTDBHYxJlV4d23n3igZ4F/wYLk8hnc9DhIv1U3o?=
 =?us-ascii?Q?RGLiVtCKiawGdbjeka18ruWRYZrr7Ih5xcPw6fpHgT9zguW/AcBPSpTpugGO?=
 =?us-ascii?Q?50qBuW8nGuPOXPcVRJqkkr7vK6EcljPEWC68OYeXGT2WtA/a8wgkJTG5Guro?=
 =?us-ascii?Q?w0K7Au1dcnGZOqLaCESkGF4QnQBJdJRFwrjVODfJhoVJAfSQGQEB4mz941jY?=
 =?us-ascii?Q?ig=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b939ac9f-6b20-413c-34e2-08db8e1ce7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 21:11:40.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FemUduJeewmjaAQREhanVB72GD9NwkgSCAV1R7n6HkaMk7rlcbAPU7osQUnxtaqlT9KLL3bV/i1SvrOM69YjIio639FoTACF+jnr1mn37PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, July 26, 2023 8:38 AM
>

[...]
=20
>>>>>>
>>>>>>Just to make it clear:
>>>>>>
>>>>>>AUTOMATIC:
>>>>>>- inputs monitored, validated, phase measurements available
>>>>>>- possible states: unlocked, locked, locked-ho-acq, holdover
>>>>>>
>>>>>>FREERUN:
>>>>>>- inputs not monitored, not validated, no phase measurements availabl=
e
>>>>>>- possible states: unlocked
>>>>>
>>>>>This is your implementation of DPLL. Others may have it done
>>>>>differently. But the fact the input is monitored or not, does not make
>>>>>any difference from user perspective.
>>>>>
>>>>>When he has automatic mode and does:
>>>>>1) disconnect all pins
>>>>>2) reset state    (however you implement it in the driver is totaly up
>>>>>		   to the device, you may go to your freerun dpll mode
>>>>>		   internally and to automatic back, up to you)
>>>>> -> state will go to unlocked
>>>>>
>>>>>The behaviour is exactly the same, without any special mode.
>>>>
>>>>In this case there is special reset button, which doesn't exist in
>>>>reality, actually your suggestion to go into FREERUN and back to AUTOMA=
TIC
>>>>to pretend the some kind of reset has happened, where in reality dpll w=
ent
>>>>to
>>>>FREERUN and AUTOMATIC.
>>>
>>>There are 3 pin states:
>>>disconnected
>>>connected
>>>selectable
>>>
>>>When the last source disconnects, go to your internal freerun.
>>>When some source gets selectable or connected, go to your internal
>>>automatic mode.
>>>
>>
>>This would make the driver to check if all the sources are disconnected
>>each time someone disconnects a source. Which in first place is not
>>efficient, but also dpll design already allows different driver instances
>>to
>>control separated sources, which in this case would force a driver to
>>implement
>>additional communication between the instances just to allow such hidden
>>FREERUN mode.
>>Which seems another argument not to do this in the way you are proposing:
>>inefficient and unnecessarily complicated.
>>
>>We know that you could also implement FREERUN mode by disconnecting all
>>the
>>sources, even if HW doesn't support it explicitly.
>>
>>>From user perspactive, the mode didn't change.
>>>
>>
>>The user didn't change the mode, the mode shall not change.
>>You wrote to do it silently, so user didn't change the mode but it would
>have
>>changed, and we would have pretended the different working mode of DPLL
>doesn't
>>exist.
>>
>>>From user perepective, this is exacly the behaviour he requested.
>>>
>>
>>IMHO this is wrong and comes from the definition of pin state DISCONNECTE=
D,
>>which is not sharp, for our HW means that the input will not be considere=
d
>>as valid input, but is not disconnecting anything, as input is still
>>monitored and measured.
>>Shall we have additional mode like PIN_STATE_NOT_SELECTABLE? As it is not
>>possible to actually disconnect a pin..
>>
>>>
>>>>For me it seems it seems like unnecessary complication of user's life.
>>>>The idea of FREERUN mode is to run dpll on its system clock, so all the
>>>>"external" dpll sources shall be disconnected when dpll is in FREERUN.
>>>
>>>Yes, that is when you set all pins to disconnect. no mode change needed.
>>>
>>
>>We don't disconnect anything, we used a pin state DISCONNECTED as this
>>seemed
>>most appropriate.
>>
>>>
>>>>Let's assume your HW doesn't have a FREERUN, can't you just create it b=
y
>>>>disconnecting all the sources?
>>>
>>>Yep, that's what we do.
>>>
>>
>>No, you were saying that the mode doesn't exist and that your hardware
>>doesn't
>>support it. At the same time it can be achieved by manually disconnecting
>>all
>>the sources.
>>
>>>
>>>>BTW, what chip are you using on mlx5 for this?
>>>>I don't understand why the user would have to mangle state of all the p=
ins
>>>>just
>>>>to stop dpll's work if he could just go into FREERUN and voila. Also wh=
at
>>>>if
>>>>user doesn't want change the configuration of the pins at all, and he j=
ust
>>>>want
>>>>to desynchronize it's dpll for i.e. testing reason.
>>>
>>>I tried to explain multiple times. Let the user have clean an abstracted
>>>api, with clear semantics. Simple as that. Your internal freerun mode is
>>>just something to abstract out, it is not needed to expose it.
>>>
>>
>>Our hardware can support in total 4 modes, and 2 are now supported in ice=
.
>>I don't get the idea for abstraction of hardware switches, modes or
>>capabilities, and having those somehow achievable through different
>>functionalities.
>>
>>I think we already discussed this long enough to make a decision..
>>Though I am not convinced by your arguments, and you are not convinced by
>>mine.
>>
>>Perhaps someone else could step in and cut the rope, so we could go furth=
er
>>with this?
>
>Or, even better, please drop this for the initial patchset and have this
>as a follow-up. Thanks!
>
>

On the responses from Jakub and Paolo, they supported the idea of having
such mode.

Although Jakub have asked if there could be better name then FREERUN, also
suggested DETACHED and STANDALONE.
For me DETACHED seems pretty good, STANDALONE a bit too far..
I am biased by the FREERUN from chip docs and don't have strong opinion
on any of those..

Any suggestions?

Thank you!
Arkadiusz

[...]

