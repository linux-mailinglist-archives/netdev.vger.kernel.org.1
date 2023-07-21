Return-Path: <netdev+bounces-19816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCD75C7EC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B40C1C214B9
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC71DDC9;
	Fri, 21 Jul 2023 13:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702F1BE87
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:36:24 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615F910F5;
	Fri, 21 Jul 2023 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689946581; x=1721482581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qh/tkwGFLX+iLaedPieJDLsbcp00c8r8Lw604Xa9MVU=;
  b=GoiB7nmD/6Tm1ON67WOq0c5LcGOzDZKjn4PabYYS+xBNQEr5Xdc1pgVN
   uYOi7VlKM6IFuAuM8Vt4z8PXrtTm6OFj/+PnsQnZRUNC0ahOp9vncmKyN
   CZ1nSUL5zPua2l682o2ioK5lwQzUyQLp+bekdXS0TPzY5RGmQYr0hgXNX
   BaZ4Bo8y1ka6+4/qhjLWynIhKX9Kh/uJ3DuvlF2eFu7c/wTiPidj++rOW
   pPPTLjBkfCpRNUa71daPz6swbEH65cpAdaIGamRC12lu+ktnCxmC1Z7e/
   yEE/Ei7nAH6QaSq8Q8ueL5TDIWjbmdhGL5oGikqS1UGtRm2X+e/O9W+ht
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="433253210"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433253210"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="971449782"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971449782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2023 06:36:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 06:36:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 06:36:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 06:36:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 06:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Toh55nz8hVg4IgyZZ6AyB1P+ekHekR3cZqXFEOtkEn1b0skhSfPF5u0KAO5pvHGXquLMZJHwixLOfzlu+AQ6jJs1k9SS+Ph2VqCedkCdDocUj4VRtZkLPKioCyjZC2LiRo6HuIu6HBH8G9gNBTU3S69Q1XnaGdlwwoikFrps4YllfhXxcXGt6Y9dgk5AA0oh3qpXxB0OpNeTeKWHGSmTmiEhFLkRLuRVIaqZFWqv73ZBheu/mrrJ6zcVCkbhCMNe9siQrkouuXEMIeq7g9xcb39XJh4ODTYdFlNLcsxaH55SIq1Vjn7ZpyakDaaZ0118AJ5ETLjrp3DvJBuIs3vx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H16eGWFZt4gw0k6Gu8g79m6OpJUvBLs4HmKWso3KYbQ=;
 b=P3zuwo9AS+TmuZD8XCc1QnZd02gegfSqpbJ235SJ1UBFRe3EQrE001IBWUsQCV+0TAxK4uvEHXcDYInpkuE0FwxBpCHqVFVMFc8DruGP2n3gwWdfskVG1AG+kI2+IjwYBFsHV1ZvEMqq/pUE3IwzQ5oDuHflLqoZyyeQZR7qLy5Bfbgx87hM5fygi23yp+oB2+x/Jus7BXiSYQvHfQFBGj/AdhKfVluGbYVTS00YtcFrfoZDQKIbn97NkEgd0yh5FPJkIZjlwsVr2Ftmi3SbOkJBeYZXkz2w2MekiKWxkrM8VCI9Y9K4ktO3l6YqgHxgYZUMHeE3C+G7rrmsFDB0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 21 Jul 2023 13:36:17 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 13:36:17 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQgAAo5gCAAA2wkA==
Date: Fri, 21 Jul 2023 13:36:17 +0000
Message-ID: <DM6PR11MB46579CC7E6D314BFDE47E4EE9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
 <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLpzwMQrqp7mIMFF@nanopsycho>
In-Reply-To: <ZLpzwMQrqp7mIMFF@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|MW3PR11MB4555:EE_
x-ms-office365-filtering-correlation-id: 71a2e8ff-3bda-4986-4355-08db89ef7619
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8u5WH6kmHyx/HTccDVTO3Br0gyBBl1qss01pfrbB0q6DYHyFspJnysWwZWnFPeeqWPwqKqCQ3zgU1i3PgV3zokdnD3yYe1LY0wTDHOxQflWT1jyWWZGdn9ioanSmmP4w+pVcw60nNiPnKdSYn6CoEcwj/jDUXs4r53VLwRfbzIYnPHSTfC6UPxl6dKnAC1gALO7D+WtkBqYo3UicRhgR/rE/GmVEG4ydTDuC5loyxLvyc6UlkSApIxolCCGtvILoo2xjPJOdY1BXmz1uytwxK37q2qgW67TdGAgOgq8sD++TwiCU+U48QiYLUY5Qn8zasSyVkJ38MfGN9h0pJRRY/5sn5novrzj+iPPp9dNWcakW2Rb2OHQclvnOiKdJOMnWthvs8H5/AyyDPzLcqfSU4PwwjQvgRfYsSY/iTCOZcxG39xo1mvQ707O/0P0kZNG6wodBpdRobVeOQ9KeTQeUiKCPyKE9MEGPp0WU1G8d+unDuNE72n/iihDQrw0i4WOL3YXULWyw+KoNATd7TXL9CrVAp93B4NOgmcmEL2iNwSGCPD/QNKjPvrYIBZVRC6vRnA+Cvd+bZ/EGavPlydZ/H2dGPC05XQAc18RiYzVlusAFjmrurN1uNXB48vEQSnbv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(38100700002)(478600001)(54906003)(9686003)(7696005)(26005)(86362001)(33656002)(71200400001)(186003)(38070700005)(6506007)(55016003)(2906002)(30864003)(82960400001)(83380400001)(41300700001)(4326008)(316002)(122000001)(6916009)(8676002)(8936002)(7416002)(52536014)(5660300002)(66946007)(66446008)(66476007)(66556008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdAggTuOuLSel7agT7UzDTp6HOktG08RcWw/0cfR5qRimGa1LjcW9ejyK+9Z?=
 =?us-ascii?Q?CWleT+qMwe5BeV1qqiSFJamaBG+EHTdWsNKgzmVQpVU1YuzLhWiFumgMa8z8?=
 =?us-ascii?Q?ge8PaPagU6Jztanh5xaOPWE7pypC2o3nWFUUx/bg7JSJ/Yz+Jexm3zl01Pc+?=
 =?us-ascii?Q?YVFK7iGUfJKM4kMGP0QPMpHBuvGOqJ6m585KdaHoMdadGm3iHiqNQ2/hppZG?=
 =?us-ascii?Q?oyMbKaQQze7akLPQu1iqYDVnlgIxdVHucO0tvBQgJI49L0H7vm9Oc291RkO7?=
 =?us-ascii?Q?B2P0C4QQE3RuCowHllh8pyH4SIyXx2dJihl6V/ELwMAsR+HEuAk07IKPQhzA?=
 =?us-ascii?Q?R7viNIR6SKU1o3El2ogcG4ZsU74dc/5p7Xb/YUzWwSDFkYaoSL4xyJ6j3gcM?=
 =?us-ascii?Q?DMUl8iV7UOd9VdVm+l/xIanb0s6PpGvJfqHBppX9AQxxNaxrY7Di84KohFTO?=
 =?us-ascii?Q?ZqhiVTWwewF318cpZ+YVwIKBRFPKBtKXsXriDviVVUp6xWbd23nGkELeSaKd?=
 =?us-ascii?Q?HuUxDmFoJGap51R0G5XDXZUca30mZFJHHUl3ZuEnZhMXw4qdGYMR78M3zYSS?=
 =?us-ascii?Q?F2c654K9iJwYiNDXXiQFlnN25+SxmiENnDcQXrOJa1AdXflt1dhPvh3oDWeL?=
 =?us-ascii?Q?t2CEzCukpsLy3UjlczOhuPJWLT3BRVi+NsO7X6tZAU0OKdJzwSl5Tdzk6elZ?=
 =?us-ascii?Q?BKweA9dbgsaGfnMSDIbljqYNhupl/Wuo3HuB/hH0PlnDXzaGhcW1LBHMjHZZ?=
 =?us-ascii?Q?kkSiO9xIZYxGzOsio/ibH8/IeoCVmKOtx9FPQwUvkHKzX33vr4Oi7aw7Exkv?=
 =?us-ascii?Q?GFQMH6KDvF++4fR14jqtEQNJXmZK0I5x5OR+zvxqRdkVqDkILjfytRHoTpzh?=
 =?us-ascii?Q?L8NCaNNU8rybLHufV7V25ijbnQD8Ujd7XRWRoTi3SiSNBhkIMfkNAPzYgvl1?=
 =?us-ascii?Q?Yt3YS9mkXa28qOx5gdYZspdWA+Vz+JU831MyvvKNlVN6Pmdo/KusO4/MrMDI?=
 =?us-ascii?Q?Xtj6Ui/n5dj/BaHl9y/oW0ItzNs3yGJOmnnfHGqRkJ/apT22do0bWgfAQ8Eh?=
 =?us-ascii?Q?HgKgkAYNC9GOuGS7SVM3Zluup0oJt4D2U/NK1We3NWBk1FOnR5pREKppz4pk?=
 =?us-ascii?Q?ahTAK13PdOybYgcLp6OPBW1kWyh7z5QiL2Ef6gpwDTff0VXkdwmi58l2FWMV?=
 =?us-ascii?Q?WssVRYWDaaYVHbiPcUhoD4cWqL5/2bc6skyB3zTkU+oqEtMNDAQovpVW7GpB?=
 =?us-ascii?Q?prCJexu7bOuRnOojTNisXOV+RUJaM4OghPbeh+VWV91EBaSz2+1iF/mA3DZr?=
 =?us-ascii?Q?T45vkAX5tpGvXm8f2Iuexu77Z/jVciLC6qUUgu8kNNj0cTqW56tDWlhewFkN?=
 =?us-ascii?Q?WLrjLXd2GXFvTz57tATUjedkFyEwD/98Au6EfU3QE07pBqOuKehcZni2z4fn?=
 =?us-ascii?Q?bWxO9CMCKP5mP4JN5kYidCicUlHrT3SnzS8zeKmvKWKB3ZqsaRpTZ3tEeLVy?=
 =?us-ascii?Q?Sc4A5DiDhrVW/ROxhl36ioR0Cmq9BQRDzWbYOBmxIwIRJ5y58qCQuJHYY+u4?=
 =?us-ascii?Q?ODV2ihQVOG4ZP1r/Jok20cqOSG16brf/Nhxlpexkgh0/euilEByoqhPAC4oW?=
 =?us-ascii?Q?nA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a2e8ff-3bda-4986-4355-08db89ef7619
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 13:36:17.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5W6icyDWUP5BSAYvukBCC85qWRChw/wDn3VR/xO+6lh+dNxyvzhpldlKjcEGTPSiAvbgdwksJgYHSwRo8v7vFsEM20avsUI7ld7rPC7fVpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, July 21, 2023 2:02 PM
>
>Fri, Jul 21, 2023 at 01:17:59PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Friday, July 21, 2023 9:33 AM
>>>
>>>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com wro=
te:
>>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>>>
>>>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>>
>>>>>[...]
>>>>>
>>>>>
>>>>>>+/**
>>>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>>>+ * @hw: board private hw structure
>>>>>>+ * @pin: pointer to a pin
>>>>>>+ * @pin_type: type of pin being enabled
>>>>>>+ * @extack: error reporting
>>>>>>+ *
>>>>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>>>>+ *
>>>>>>+ * Context: Called under pf->dplls.lock
>>>>>>+ * Return:
>>>>>>+ * * 0 - OK
>>>>>>+ * * negative - error
>>>>>>+ */
>>>>>>+static int
>>>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>>>+		    struct netlink_ext_ack *extack)
>>>>>>+{
>>>>>>+	u8 flags =3D 0;
>>>>>>+	int ret;
>>>>>>+
>>>>>
>>>>>
>>>>>
>>>>>I don't follow. Howcome you don't check if the mode is freerun here or
>>>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>>>
>>>>
>>>>Because you are probably still thinking the modes are somehow connected
>>>>to the state of the pin, but it is the other way around.
>>>>The dpll device mode is a state of DPLL before pins are even considered=
.
>>>>If the dpll is in mode FREERUN, it shall not try to synchronize or moni=
tor
>>>>any of the pins.
>>>>
>>>>>Also, I am probably slow, but I still don't see anywhere in this
>>>>>patchset any description about why we need the freerun mode. What is
>>>>>diffrerent between:
>>>>>1) freerun mode
>>>>>2) automatic mode & all pins disabled?
>>>>
>>>>The difference:
>>>>Case I:
>>>>1. set dpll to FREERUN and configure the source as if it would be in
>>>>AUTOMATIC
>>>>2. switch to AUTOMATIC
>>>>3. connecting to the valid source takes ~50 seconds
>>>>
>>>>Case II:
>>>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>>>2. switch one valid source to SELECTABLE
>>>>3. connecting to the valid source takes ~10 seconds
>>>>
>>>>Basically in AUTOMATIC mode the sources are still monitored even when t=
hey
>>>>are not in SELECTABLE state, while in FREERUN there is no such monitori=
ng,
>>>>so in the end process of synchronizing with the source takes much longe=
r as
>>>>dpll need to start the process from scratch.
>>>
>>>I believe this is implementation detail of your HW. How you do it is up
>>>to you. User does not have any visibility to this behaviour, therefore
>>>makes no sense to expose UAPI that is considering it. Please drop it at
>>>least for the initial patchset version. If you really need it later on
>>>(which I honestly doubt), you can send it as a follow-up patchset.
>>>
>>
>>And we will have the same discussion later.. But implementation is alread=
y
>>there.
>
>Yeah, it wouldn't block the initial submission. I would like to see this
>merged, so anything which is blocking us and is totally optional (as
>this freerun mode) is better to be dropped.
>

It is not blocking anything. Most of it was defined and available for
long time already. Only ice implementing set_mode is a new part.
No clue what is the problem you are implying here.

>
>>As said in our previous discussion, without mode_set there is no point to
>>have
>>command DEVICE_SET at all, and there you said that you are ok with having
>>the
>>command as a placeholder, which doesn't make sense, since it is not used.
>
>I don't see any problem in having enum value reserved. But it does not
>need to be there at all. You can add it to the end of the list when
>needed. No problem. This is not an argument.
>

The argument is that I already implemented and tested, and have the need fo=
r the
existence to set_mode to configure DPLL, which is there to switch the mode
between AUTOMATIC and FREERUN.

>
>>
>>Also this is not HW implementation detail but a synchronizer chip feature=
,
>>once dpll is in FREERUN mode, the measurements like phase offset between
>>the
>>input and dpll's output won't be available.
>>
>>For the user there is a difference..
>>Enabling the FREERUN mode is a reset button on the dpll's state machine,
>>where disconnecting sources is not, as they are still used, monitored and
>>measured.
>
>So it is not a mode! Mode is either "automatic" or "manual". Then we
>have a state to indicate the state of the state machine (unlocked, locked,
>holdover, holdover-acq). So what you seek is a way for the user to
>expliticly set the state to "unlocked" and reset of the state machine.
>
>Please don't mix config and state. I think we untangled this in the past
>:/

I don't mix anything, this is the way dpll works, which means mode of dpll.

>
>Perhaps you just need an extra cmd like DPLL_CMD_DEVICE_STATE_RESET cmd
>to hit this button.
>

As already said there are measurement in place in AUTOMATIC, there are no s=
uch
thing in FREERUN. Going into FREERUN resets the state machine of dpll which
is a side effect of going to FREERUN.

>
>
>>So probably most important fact that you are missing here: assuming the u=
ser
>>disconnects the pin that dpll was locked with, our dpll doesn't go into
>>UNLOCKED
>>state but into HOLDOVER.
>>
>>>
>>>
>>>>
>>>>>
>>>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>>>>needs to be documented, please.
>>>>>
>>>>
>>>>Sure will add the description of FREERUN to the docs.
>>>
>>>No, please drop it from this patchset. I have no clue why you readded
>>>it in the first place in the last patchset version.
>>>
>>
>>mode_set was there from the very beginning.. now implemented in ice drive=
r
>>as it should.
>
>I don't understand the fixation on a callback to be implemented. Just
>remove it. It can be easily added when needed. No problem.
>

Well, I don't understand the fixation about removing it.
set_mode was there for a long time, now the callback is properly implemente=
d
and you are trying to imply that this is not needed.
We require it, as there is no other other way to stop AUTOMATIC mode dpll
to do its work.

>
>>
>>>
>>>>
>>>>>
>>>>>
>>>>>Another question, I asked the last time as well, but was not heard:
>>>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>>>connected with a single DPLL pin:
>>>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>>>
>>>>>You have a SyncE daemon running on top eth0 and eth1.
>>>>>
>>>>>Could you please describe following 2 flows?
>>>>>
>>>>>1) SyncE daemon selects eth0 as a source of clock
>>>>>2) SyncE daemon selects eth1 as a source of clock
>>>>>
>>>>>
>>>>>For mlx5 it goes like:
>>>>>
>>>>>DPLL device mode is MANUAL.
>>>>>1)
>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>>>    -> pin_id: 10
>>>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>>>>    -> device_id: 2
>>>>
>>>>Not sure if it needs to obtain the dpll id in this step, but it doesn't
>>>>relate to the dpll interface..
>>>
>>>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as input.
>>>You need to set the state on a pin on a certain DPLL device.
>>>
>>
>>The thing is pin can be connected to multiple dplls and SyncE daemon shal=
l
>>know already something about the dpll it is managing.
>>Not saying it is not needed, I am saying this is not a moment the SyncE
>>daemon
>>learns it.
>
>Moment or not, it is needed for the cmd, that is why I have it there.
>
>
>>But let's park it, as this is not really relevant.
>
>Agreed.
>
>
>>
>>>
>>>>
>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>>>>>CONNECTED
>>>>>
>>>>>2)
>>>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>>>    -> pin_id: 11
>>>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>>>>    -> device_id: 2
>>>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>>>>>CONNECTED
>>>>> (that will in HW disconnect previously connected pin 10, there will b=
e
>>>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>>>
>>>>
>>>>This flow is similar for ice, but there are some differences, although
>>>>they come from the fact, the ice is using AUTOMATIC mode and recovered
>>>>clock pins which are not directly connected to a dpll (connected throug=
h
>>>>the MUX pin).
>>>>
>>>>1)
>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>pin_id: 13
>>>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
>>>>   (in case of dpll_id is needed, would be find in this response also)
>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>all the
>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>
>>>Yeah, for this you need pin_id 2 and device_id. Because you are setting
>>>state on DPLL device.
>>>
>>>
>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED wit=
h
>>>>   parent pin (pin-id:2)
>>>
>>>For this you need pin_id and pin_parent_id because you set the state on
>>>a parent pin.
>>>
>>>
>>>Yeah, this is exactly why I initially was in favour of hiding all the
>>>muxes and magic around it hidden from the user. Now every userspace app
>>>working with this has to implement a logic of tracking pin and the mux
>>>parents (possibly multiple levels) and configure everything. But it just
>>>need a simple thing: "select this pin as a source" :/
>>>
>>>
>>>Jakub, isn't this sort of unnecessary HW-details complexicity exposure
>>>in UAPI you were against in the past? Am I missing something?
>>>
>>
>>Multiple level of muxes possibly could be hidden in the driver, but the f=
act
>>they exist is not possible to be hidden from the user if the DPLL is in
>>AUTOMATIC mode.
>>For MANUAL mode dpll the muxes could be also hidden.
>>Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MUXED =
type
>>pin.
>
>Sure, but does user care how complicated things are inside? The syncE
>daemon just cares for: "select netdev x as a source". However it is done
>internally is irrelevant to him. With the existing UAPI, the syncE
>daemon needs to learn individual device dpll/pin/mux topology and
>work with it.
>

This is dpll subsystem not SyncE one.

>Do we need a dpll library to do this magic?
>

IMHO rather SyncE library :)

Thank you!
Arkadiusz

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>
>>>>
>>>>2) (basically the same, only eth1 would get different pin_id.)
>>>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>>>pin_id: 14
>>>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>>>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while
>>>>all the
>>>>   other pins shall be lower prio i.e. pin-prio:1)
>>>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED wit=
h
>>>>   parent pin (pin-id:2)
>>>>
>>>>Where step c) is required due to AUTOMATIC mode, and step d) required
>>>>due to
>>>>phy recovery clock pin being connected through the MUX type pin.
>>>>
>>>>Thank you!
>>>>Arkadiusz
>>>>
>>>>>
>>>>>Thanks!
>>>>>
>>>>>
>>>>>[...]
>>

