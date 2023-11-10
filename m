Return-Path: <netdev+bounces-47107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C0D7E7CE0
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 15:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39399281025
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5019BDC;
	Fri, 10 Nov 2023 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKnpTRdv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02601B27B
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 14:11:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F038225
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 06:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699625500; x=1731161500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eKdiEp3kXvFpszDcJiLruTp6G5Aj/SRWey39SXXzTOY=;
  b=fKnpTRdvPc4/k73A7qKXPcSqI9EAc8xw6KF5xgnDyS2e5BigP2JGwbHU
   VMyornbRhnngo6dNZ3NUqo4lFoqvf03t3m6hNrDstrpTLnjy+MGMYNUmn
   j3Ywmba8DguWSkv2Z3G36VivvZD9ktj9trdDysi7wiwjBY7lOl5lKcRVF
   D3RhR+a0+3yJUeszleEdipiN+TYL6hjgmMj7iXL8JAamW6ArHRKZOJArE
   LYsPuhtoEX959jWch25PJg+EGOcEynJukrSATCG5Dxg+6gTlTzqxOvXid
   s76PM41aEwbWA16HmK63A0+a6YV0QQmofg2idOygFh9toqFdYV2QtxxsG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="370391179"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="370391179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 06:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="792863621"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792863621"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 06:11:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 06:11:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 06:11:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 06:11:37 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 06:11:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhgYmXRuv258e1Wi540MgETgVunS5xgCNuy020+lS1zrzz+uS/qY7c8emOETaUbyGW+Fs6qttJFmoUgFKy/AVd09EOQkfODzYuyDQaVj9XGurI1muRUPwQfjlpeM1VRnpopkB3CYWnWns5g7JHilq8zPMXWGISMH0n3/K0whswGLL2zSo6sYCmWVSMQa/KmDo+qSR6co38/KenH2ltqGSA4Pg4Dbj6ZttQk37rX1pQ8J3DDQM+sXFxb3ZeWwo9s7+1WEpeDbk/Ur7V/ljs+v8ZNufjKBBDVQHY5piz4vJBJXeCk2G7S3qfSV2MD8zAJIw1u7IVwNx2a7LZyAhvZMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyZyRvsjti1g2mMhx+7iQ7swTvKeTR7UlAl1EmA5ed8=;
 b=W3nGVptMxXIEjd0+l0eFqx5vfjABU+U8e4umcimxqKI2Kz5oyXWYlet8jHpqENhez3+PA+uYrC1EJ2XFrySF2wEh2XU82QjI/ujgGgckIRPuKEWbEGvtUcKBpu4urjrA5q8E/fAkuVd6Gx7/5EzwfxWRe8bYJmejg97PRqfnsgd+kmvenPcc4QFZrxW+xEh0b1jAPxCMezuG7NS7tIPgFOhUBLKmNNare7pNcPSgiWrrlasZ1wdReWUAcwjyergaYhbhHXSZYShQbN8IsaJ2doN0xT4AD3Vh5o3YBaLztMPsBN6DbHtlpWr9DfafqcI3YSxikdpcZ5ppSKBlYZRkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 14:11:35 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Fri, 10 Nov 2023
 14:11:34 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net 2/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaEi9PNvCIepF1tEu7KRNf+M25RbBwe78AgAFGpmCAADfgAIAAMUJwgAAe7ICAAFgbsIAAfB6AgAAjAGCAABUUAIAAEkyQgAAJKQCAABVwYA==
Date: Fri, 10 Nov 2023 14:11:33 +0000
Message-ID: <DM6PR11MB4657840F3E1D0B0ED9D48DC59BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <ZUubagu6B+vbfBqm@nanopsycho>
 <DM6PR11MB465752FE337EB962B147EB579BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZUzcTBmSPxIs5iH3@nanopsycho>
 <DM6PR11MB46571D4C776B0B1888F943569BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU0fj5y9mAvVzXuf@nanopsycho>
 <DM6PR11MB4657DAC525E05B5DB72145119BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU3RlSmInnoXufxf@nanopsycho>
 <DM6PR11MB4657B61E86D5DFFAF83BC1E59BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU4AoNqxo6j5zy+V@nanopsycho>
 <DM6PR11MB46578574D6DA2F311FB97CF09BAEA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZU4XqBtl0CXwvh5n@nanopsycho>
In-Reply-To: <ZU4XqBtl0CXwvh5n@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ1PR11MB6298:EE_
x-ms-office365-filtering-correlation-id: f3cec668-661d-439b-509b-08dbe1f6f1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZp9Zr5cNuKtS5GDRinR7xGnIsYD0A4l70spmugit+pF7uUdr7s0R6TWL0YU7s24HJ4WOGqDfYkgM/zqwNbTkhDXHlvnwYqTJSOe3rLCf08wUQyoHXZdmIDg75MhutV2ut4RVRAwIc9W4t7o5xy3rIkTQiNg1TlU5/hyfGnWx53hq95FyNirDvEw9e6+97PJ1QIGSHA8EQNRY1vjmdy2a8F+HuvmxyrcxOnCJXiSGJDPjE2E/Rhz/kkJy/TJD1bAtq60Nwsd1r7pX3SfQbFdwLNepA5C/BjO3O7AMcyuBuXn6NxkxINq0JGw5ns/mlBwq6ywoJ8XAhNoUFiCZJreHBLViFPZ3ks8k9VSKwroFDqwM28KN1TzNTsCw5ucPEBQ54F3Jt0Owo1j9Tj+mDxxHz7XDp0BupwZbK5e75mjyA2BB0Ql4gqFKIxQYVXGkYmDAr2GZ6qXyZvkfc59rG4ifBcHd7LMoeKNgiYPzAR1+BsnSVT6DKA91BRRHrBeTuK2C7ePzLkGm4Mk87JPz3MLRvRQm2BKzPo3+7leCrOopvTDLI86+TvkKGG8ePbM2UjItBONivtRJ/rnHawDvaS56i+QtbNMtcxgGJ3ZmIM9u+MDScpaieWbgGyxFmPi109g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(30864003)(55016003)(66899024)(38100700002)(82960400001)(83380400001)(2906002)(122000001)(33656002)(86362001)(8676002)(4326008)(8936002)(52536014)(7696005)(6506007)(9686003)(316002)(6916009)(66476007)(64756008)(71200400001)(76116006)(66946007)(66446008)(66556008)(54906003)(41300700001)(478600001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?66tppKIbqOjEdA7GA1nXJwrlqUFdDC4dCi+Uc3kNAbYzlpJ4+BNrFzsFK2Or?=
 =?us-ascii?Q?4BB2vHDHIKbrP8N9LFxkVmeDhnRbYd91iqWqShpSMOLShtFoXq/I5AvRsq6K?=
 =?us-ascii?Q?5GiEugMd7FZ8d2y4FEQ0qLXORqWE5GfZnS23lalfwJep7GFfrLC2jD+JvPzB?=
 =?us-ascii?Q?vauNBnCuyzGElyDbm2EK17QESbkbbR9ANRUeKZcI6qke/zt7opuboZenmZVa?=
 =?us-ascii?Q?+c94/zrRPKaeI8Zu9maEY4obgvSvUGi4rR1srC94B35IvaDmgDoPiFAqRoCK?=
 =?us-ascii?Q?7UgpZX4pT33ijndoI4/nAEdh448nodff6B76l6plAV36buXGEB7oePNH+SXo?=
 =?us-ascii?Q?b9ddyrwRp7p0gx715HXdSfyVYLgHm9mwsZSvA1+AREDqAvAREpbH+QAqBZSq?=
 =?us-ascii?Q?vUO/JmF7XCqAY89HE60/Jf8Lj6LXKX2mtFeRhe8oWKLVWCxOaIceJxHl2ZNj?=
 =?us-ascii?Q?eAT5UFQ1boWL04J18JZUIg+pdI0cEJFLLi4WfGKyqdpn5+3d3lA4aIr75HcJ?=
 =?us-ascii?Q?QD4BW+BHfwbMVkOqV+l7H7Ngqm0qX4d/2O1zZi5vvecb9YCc3ilJySSFszND?=
 =?us-ascii?Q?w2HxtAmGcMkoqnxqbv+J+mQvMMdSqGI8FGlh0r3AWmUKkrMSIih5XSZLF80a?=
 =?us-ascii?Q?dLyK7wU2Yqo+OZNVWdpTc72ydojZcXCMVtUUJlTZJcb3HaXI08T6TscBNwsF?=
 =?us-ascii?Q?f1nHcLJOXYn6datb9AAGGbza8EH7BqtpW2izj+bAp4tp58z5qjkhfW+94h1I?=
 =?us-ascii?Q?9DxQbEBKvvX9lEvpwSwWtK8Xo04mrMO/Ye1eqM2KM4MFopQRXeMxBy4GxL1B?=
 =?us-ascii?Q?+lknXgzfm8KJaWM75NBT+45oBCfH71DXIT3cKqOVlQ7JdL0rdiT6aZMxjfim?=
 =?us-ascii?Q?LLhaVzlUaCvjXSlaeFgediJpFVtww7fb/fsD7y3Sa1oX9OLLdKWhE962wM9S?=
 =?us-ascii?Q?QWFZkoV5ki6lm9o7BFde4IDWmg/nsggIn4O1FxHeAS1MAJ1d5JwTVzq4ebY4?=
 =?us-ascii?Q?wZC+NVyujJ+dChafSnh+Lr4ijqfdcI6FIkw5bx4TMVAuTyDWArmNeUhQnDIc?=
 =?us-ascii?Q?ApnjsJFtNAHO9bNQAbLYvJpCwJ1EuY9bpGiymye6JeC5zFmNFd9Xr1QAMNlt?=
 =?us-ascii?Q?EijALGHJqHvXOT8ri/SRzbKtL9JPeZJQCI6fcX5rvhnyFgibgQPdRi1By8LX?=
 =?us-ascii?Q?10S2SqqagYjizX/LTLqnILyb4UHkjZ3fxzeooXaiv+A7JRjNfpeIdHDvfs7s?=
 =?us-ascii?Q?ykH4lEwBeJKUqD0ArMVqYFcxs0QZX2Qx6ZGU/oonRZWPjY6d7ERbFGDO5vSf?=
 =?us-ascii?Q?oKqax28kSmCpo3J+A8T/oVktLqfBuip+DRF2APdQwNB4htT2KE7rGRisYWqf?=
 =?us-ascii?Q?1Kv7GkBncaglUD6KJxhYAae+x5HoNuLq+7j9YSYy3YJjCHNMQvCVtjXxfB8O?=
 =?us-ascii?Q?rcxJff9Q7xX0ABHjmo75l1P3sza2JCl976g5+lsOZyr2NAbqLJ2Vi8re7pXN?=
 =?us-ascii?Q?8+bZo0Q3LLcFIYJbMOwHz8ViH8W5EBXmaBaW3xLbfYNpWZhf7T7E14KlzrAA?=
 =?us-ascii?Q?fL0ueLMLRIqtp+45Ea3fgwYBrU0AXcFk5/NBEHPPfYEOMa/80DXNOP4lh9TH?=
 =?us-ascii?Q?Cw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cec668-661d-439b-509b-08dbe1f6f1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 14:11:33.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8KlLmHRlUj5fT2F3vZV1sA43hfsFl5b7Ze3su14s9QTHSnvuztMJMzsZcETo1q3ecXiUQoLPER6p3woUHd/cmc4u5lRk/LdfrH0zztvWTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, November 10, 2023 12:45 PM
>
>Fri, Nov 10, 2023 at 12:18:51PM CET, arkadiusz.kubalewski@intel.com wrote:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, November 10, 2023 11:06 AM
>>>
>>>Fri, Nov 10, 2023 at 10:01:50AM CET, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Friday, November 10, 2023 7:46 AM
>>>>>
>>>>>Fri, Nov 10, 2023 at 12:32:21AM CET, arkadiusz.kubalewski@intel.com
>>>>>wrote:
>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>Sent: Thursday, November 9, 2023 7:06 PM
>>>>>>>
>>>>>>>Thu, Nov 09, 2023 at 05:30:20PM CET, arkadiusz.kubalewski@intel.com
>>>>>>>wrote:
>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>Sent: Thursday, November 9, 2023 2:19 PM
>>>>>>>>>
>>>>>>>>>Thu, Nov 09, 2023 at 01:20:48PM CET, arkadiusz.kubalewski@intel.co=
m
>>>>>>>>>wrote:
>>>>>>>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>>>>>>>Sent: Wednesday, November 8, 2023 3:30 PM
>>>>>>>>>>>
>>>>>>>>>>>Wed, Nov 08, 2023 at 11:32:25AM CET,
>>>>>>>>>>>arkadiusz.kubalewski@intel.com
>>>>>>>>>>>wrote:
>>>>>>>>>>>>When a kernel module is unbound but the pin resources were not
>>>>>>>>>>>>entirely
>>>>>>>>>>>>freed (other kernel module instance have had kept the reference
>>>>>>>>>>>>to
>>>>>>>>>>>>that
>>>>>>>>>>>>pin), and kernel module is again bound, the pin properties woul=
d
>>>>>>>>>>>>not
>>>>>>>>>>>>be
>>>>>>>>>>>>updated (the properties are only assigned when memory for the
>>>>>>>>>>>>pin
>>>>>>>>>>>>is
>>>>>>>>>>>>allocated), prop pointer still points to the kernel module
>>>>>>>>>>>>memory
>>>>>>>>>>>>of
>>>>>>>>>>>>the kernel module which was deallocated on the unbind.
>>>>>>>>>>>>
>>>>>>>>>>>>If the pin dump is invoked in this state, the result is a kerne=
l
>>>>>>>>>>>>crash.
>>>>>>>>>>>>Prevent the crash by storing persistent pin properties in dpll
>>>>>>>>>>>>subsystem,
>>>>>>>>>>>>copy the content from the kernel module when pin is allocated,
>>>>>>>>>>>>instead
>>>>>>>>>>>>of
>>>>>>>>>>>>using memory of the kernel module.
>>>>>>>>>>>>
>>>>>>>>>>>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base
>>>>>>>>>>>>functions")
>>>>>>>>>>>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base
>>>>>>>>>>>>functions")
>>>>>>>>>>>>Signed-off-by: Arkadiusz Kubalewski
>>>>>>>>>>>><arkadiusz.kubalewski@intel.com>
>>>>>>>>>>>>---
>>>>>>>>>>>> drivers/dpll/dpll_core.c    |  4 ++--
>>>>>>>>>>>> drivers/dpll/dpll_core.h    |  4 ++--
>>>>>>>>>>>> drivers/dpll/dpll_netlink.c | 28 ++++++++++++++--------------
>>>>>>>>>>>> 3 files changed, 18 insertions(+), 18 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.=
c
>>>>>>>>>>>>index 3568149b9562..4077b562ba3b 100644
>>>>>>>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>>>>>>>@@ -442,7 +442,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx,
>>>>>>>>>>>>struct
>>>>>>>>>>>>module *module,
>>>>>>>>>>>> 		ret =3D -EINVAL;
>>>>>>>>>>>> 		goto err;
>>>>>>>>>>>> 	}
>>>>>>>>>>>>-	pin->prop =3D prop;
>>>>>>>>>>>>+	memcpy(&pin->prop, prop, sizeof(pin->prop));
>>>>>>>>>>>
>>>>>>>>>>>Odd, you don't care about the pointer within this structure?
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Well, true. Need a fix.
>>>>>>>>>>Wondering if copying idea is better than just assigning prop
>>>>>>>>>>pointer
>>>>>>>>>>on
>>>>>>>>>>each call to dpll_pin_get(..) function (when pin already exists)?
>>>>>>>>>
>>>>>>>>>Not sure what do you mean. Examples please.
>>>>>>>>>
>>>>>>>>
>>>>>>>>Sure,
>>>>>>>>
>>>>>>>>Basically this change:
>>>>>>>>
>>>>>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>>>>>index ae884b92d68c..06b72d5877c3 100644
>>>>>>>>--- a/drivers/dpll/dpll_core.c
>>>>>>>>+++ b/drivers/dpll/dpll_core.c
>>>>>>>>@@ -483,6 +483,7 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct
>>>>>>>>module
>>>>>>>>*module,
>>>>>>>>                    pos->pin_idx =3D=3D pin_idx &&
>>>>>>>>                    pos->module =3D=3D module) {
>>>>>>>>                        ret =3D pos;
>>>>>>>>+                       pos->prop =3D prop;
>>>>>>>>                        refcount_inc(&ret->refcount);
>>>>>>>>                        break;
>>>>>>>>                }
>>>>>>>>
>>>>>>>>would replace whole of this patch changes, although seems a bit
>>>>>>>hacky.
>>>>>>>
>>>>>>>Or event better, as I suggested in the other patch reply, resolve
>>>>>>>this
>>>>>>>internally in the driver registering things only when they are valid=
.
>>>>>>>Much better then to hack anything in dpll core.
>>>>>>>
>>>>>>
>>>>>>This approach seemed to me hacky, that is why started with coping the
>>>>>>data.
>>>>>>It is not about registering, rather about unregistering on driver
>>>>>>unbind, which brakes things, and currently cannot be recovered in
>>>>>>described case.
>>>>>
>>>>>Sure it can. PF0 unbind-> internal notification-> PF1 unregisters all
>>>>>related object. Very clean and simple.
>>>>>
>>>>
>>>>What you are suggesting is:
>>>>- special purpose bus in the driver,
>>>
>>>No, it is a simple notificator. Very common infra over the whole
>>>kernel code.
>>>
>>
>>No difference if this is simple or not, it is special purpose.
>>
>>>
>>>>- dpll-related,
>>>
>>>Is this the only thing that PF0 is special with? Perhaps you can
>>>utilize this for other features as well, since your fw design is like
>>>this.
>>>
>>
>>None api user is allowed to the unordered driver bind when there are muxe=
d
>>pins involved.
>>This requires a fix in the api not in the driver.
>>
>>>
>>>>- not needed,
>>>>- prone for errors.
>>>>
>>>>The dpll subsystem is here to make driver life easier.
>>>
>>>No, the subsystem is never here to handle device specific issues. And
>>>your PF0 dependency is very clearly something device specific. Don't
>>>pollute the dpll subsystem with workaround to handle specific device
>>>needs. create/register the dplls objects from your driver only when it
>>>is valid to do so. Make sure the lifetime of such object stays in
>>>the scope of validity. Handle that in the driver. Very clear and simple.
>>>
>>
>>In our case this is PF0 but this is broader issue. The muxed pins
>>infrastructure in now slightly broken and I am fixing it.
>>From the beginning it was designed to allow separated driver instances
>>to create a device and connect their pins with it.
>
>That is true. That's exacly what we have implemented in mlx5. Each
>instance registers dpll device and the pin related to the instance. No
>problem.
>

I read this: "mlx5 is done correctly, you need to follow", funny again.

>The fact that you do register only in PF0 is a limitation in your
>driver. Fix it there.
>

A limitation when comparing to your design, makes it not the limitation at =
all.
Different design is just different.

According to documentation there is no such thing like a correct order of
registering/unregistering pins.
So a driver can register a parent pin, register a pin with that parent, and
remove the parent first. It shall not crash. Right now it is broken. The
dpll needs to handle such cases. I am fixing it. Simple.

Thank you!
Arkadiusz

>
>>Any driver which would use it would face this issue. What you are trying
>>to imply is that it is better to put traffic lights on each car instead
>>of putting them on crossroads.
>>
>>>Thanks!
>>>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>>
>>>>>>Thank you!
>>>>>>Arkadiusz
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>Thank you!
>>>>>>>>Arkadiusz
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>Thank you!
>>>>>>>>>>Arkadiusz
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> 	refcount_set(&pin->refcount, 1);
>>>>>>>>>>>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>>>>>>>>>>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>>>>>>>>>>>@@ -634,7 +634,7 @@ int dpll_pin_on_pin_register(struct dpll_pi=
n
>>>>>>>>>>>>*parent,
>>>>>>>>>>>>struct dpll_pin *pin,
>>>>>>>>>>>> 	unsigned long i, stop;
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>>>>>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>>>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>>>>
>>>>>>>>>>>> 	if (WARN_ON(!ops) ||
>>>>>>>>>>>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.=
h
>>>>>>>>>>>>index 5585873c5c1b..717f715015c7 100644
>>>>>>>>>>>>--- a/drivers/dpll/dpll_core.h
>>>>>>>>>>>>+++ b/drivers/dpll/dpll_core.h
>>>>>>>>>>>>@@ -44,7 +44,7 @@ struct dpll_device {
>>>>>>>>>>>>  * @module:		module of creator
>>>>>>>>>>>>  * @dpll_refs:		hold referencees to dplls pin was
>>>>>>>>>>>>registered
>>>>>>>>>>>>with
>>>>>>>>>>>>  * @parent_refs:	hold references to parent pins pin was
>>>>>>>>>>>>registered
>>>>>>>>>>>>with
>>>>>>>>>>>>- * @prop:		pointer to pin properties given by registerer
>>>>>>>>>>>>+ * @prop:		pin properties copied from the registerer
>>>>>>>>>>>>  * @rclk_dev_name:	holds name of device when pin can
>>>>>>>>>>>>recover
>>>>>>>>>>>>clock
>>>>>>>>>>>>from it
>>>>>>>>>>>>  * @refcount:		refcount
>>>>>>>>>>>>  **/
>>>>>>>>>>>>@@ -55,7 +55,7 @@ struct dpll_pin {
>>>>>>>>>>>> 	struct module *module;
>>>>>>>>>>>> 	struct xarray dpll_refs;
>>>>>>>>>>>> 	struct xarray parent_refs;
>>>>>>>>>>>>-	const struct dpll_pin_properties *prop;
>>>>>>>>>>>>+	struct dpll_pin_properties prop;
>>>>>>>>>>>> 	refcount_t refcount;
>>>>>>>>>>>> };
>>>>>>>>>>>>
>>>>>>>>>>>>diff --git a/drivers/dpll/dpll_netlink.c
>>>>>>>>>>>>b/drivers/dpll/dpll_netlink.c
>>>>>>>>>>>>index 93fc6c4b8a78..963bbbbe6660 100644
>>>>>>>>>>>>--- a/drivers/dpll/dpll_netlink.c
>>>>>>>>>>>>+++ b/drivers/dpll/dpll_netlink.c
>>>>>>>>>>>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg=
,
>>>>>>>>>>>>struct
>>>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>>>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY,
>>>>>>>>>>>>sizeof(freq),
>>>>>>>>>>>>&freq,
>>>>>>>>>>>> 			  DPLL_A_PIN_PAD))
>>>>>>>>>>>> 		return -EMSGSIZE;
>>>>>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>>>>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>>>>>>>>>>>> 		nest =3D nla_nest_start(msg,
>>>>>>>>>>>>DPLL_A_PIN_FREQUENCY_SUPPORTED);
>>>>>>>>>>>> 		if (!nest)
>>>>>>>>>>>> 			return -EMSGSIZE;
>>>>>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].min;
>>>>>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].min;
>>>>>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN,
>>>>>>>>>>>>sizeof(freq),
>>>>>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>>>>>> 			return -EMSGSIZE;
>>>>>>>>>>>> 		}
>>>>>>>>>>>>-		freq =3D pin->prop->freq_supported[fs].max;
>>>>>>>>>>>>+		freq =3D pin->prop.freq_supported[fs].max;
>>>>>>>>>>>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX,
>>>>>>>>>>>>sizeof(freq),
>>>>>>>>>>>> 				  &freq, DPLL_A_PIN_PAD)) {
>>>>>>>>>>>> 			nla_nest_cancel(msg, nest);
>>>>>>>>>>>>@@ -304,9 +304,9 @@ static bool
>>>>>>>>>>>>dpll_pin_is_freq_supported(struct
>>>>>>>>>>>>dpll_pin
>>>>>>>>>>>>*pin, u32 freq)
>>>>>>>>>>>> {
>>>>>>>>>>>> 	int fs;
>>>>>>>>>>>>
>>>>>>>>>>>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>>>>>>>>>>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>>>>>>>>>>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>>>>>>>>>>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>>>>>>>>>>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>>>>>>>>>>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>>>>>>>>>>>> 			return true;
>>>>>>>>>>>> 	return false;
>>>>>>>>>>>> }
>>>>>>>>>>>>@@ -403,7 +403,7 @@ static int
>>>>>>>>>>>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin=
,
>>>>>>>>>>>> 		     struct netlink_ext_ack *extack)
>>>>>>>>>>>> {
>>>>>>>>>>>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>>>>>>>>>>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>>>>>>>>>>>> 	struct dpll_pin_ref *ref;
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>>@@ -696,7 +696,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin
>>>>>>>>>>>>*pin,
>>>>>>>>>>>>u32
>>>>>>>>>>>>parent_idx,
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not
>>>>>>>>>>>>allowed");
>>>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>>>> 	}
>>>>>>>>>>>>@@ -732,7 +732,7 @@ dpll_pin_state_set(struct dpll_device *dpll=
,
>>>>>>>>>>>>struct
>>>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "state changing is not
>>>>>>>>>>>>allowed");
>>>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>>>> 	}
>>>>>>>>>>>>@@ -759,7 +759,7 @@ dpll_pin_prio_set(struct dpll_device *dpll,
>>>>>>>>>>>>struct
>>>>>>>>>>>>dpll_pin *pin,
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "prio changing is not
>>>>>>>>>>>>allowed");
>>>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>>>> 	}
>>>>>>>>>>>>@@ -787,7 +787,7 @@ dpll_pin_direction_set(struct dpll_pin *pin=
,
>>>>>>>>>>>>struct
>>>>>>>>>>>>dpll_device *dpll,
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>>>>>>>>>>>-	      pin->prop->capabilities)) {
>>>>>>>>>>>>+	      pin->prop.capabilities)) {
>>>>>>>>>>>> 		NL_SET_ERR_MSG(extack, "direction changing is not
>>>>>>>>>>>>allowed");
>>>>>>>>>>>> 		return -EOPNOTSUPP;
>>>>>>>>>>>> 	}
>>>>>>>>>>>>@@ -817,8 +817,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin=
,
>>>>>>>>>>>>struct
>>>>>>>>>>>>nlattr *phase_adj_attr,
>>>>>>>>>>>> 	int ret;
>>>>>>>>>>>>
>>>>>>>>>>>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>>>>>>>>>>>-	if (phase_adj > pin->prop->phase_range.max ||
>>>>>>>>>>>>-	    phase_adj < pin->prop->phase_range.min) {
>>>>>>>>>>>>+	if (phase_adj > pin->prop.phase_range.max ||
>>>>>>>>>>>>+	    phase_adj < pin->prop.phase_range.min) {
>>>>>>>>>>>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>>>>>>>>>>>> 				    "phase adjust value not
>>>>>>>>>>>>supported");
>>>>>>>>>>>> 		return -EINVAL;
>>>>>>>>>>>>@@ -999,7 +999,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>>>>>>>>>>>*mod_name_attr,
>>>>>>>>>>>> 	unsigned long i;
>>>>>>>>>>>>
>>>>>>>>>>>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED)
>>>>>>>>>>>>{
>>>>>>>>>>>>-		prop =3D pin->prop;
>>>>>>>>>>>>+		prop =3D &pin->prop;
>>>>>>>>>>>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id :
>>>>>>>>>>>>true;
>>>>>>>>>>>> 		mod_match =3D mod_name_attr && module_name(pin-
>>>>>>>>>>>>module) ?
>>>>>>>>>>>> 			!nla_strcmp(mod_name_attr,
>>>>>>>>>>>>--
>>>>>>>>>>>>2.38.1
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>

