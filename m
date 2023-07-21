Return-Path: <netdev+bounces-19797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D624C75C5C4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33211C21644
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910F1D2F3;
	Fri, 21 Jul 2023 11:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948281D2ED
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 11:18:24 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B8D1715;
	Fri, 21 Jul 2023 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689938302; x=1721474302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hxG3tVFjv/Nhsp7P39L1i5rMJ9SvHoi4/izc5W/TGqI=;
  b=ASn/FJWUn2iPryBFbuN5xCioxIsfAvCuuiEFl2p0EMw+C/uRQWFeWwOW
   jxg/CLNpYqML6EgAzYgV2jm+8wJXCW6IO9/0pFzQ8qLfc1/k9oFdcGl/r
   lLtmANZWwGyqnH535PvUsNbQfElKCS4oo6fQNw+O3de/dcZtCVNjDp/aP
   GpVp6BSTv5hYthYY5vMYdIPQh9XCwzdAbbIRRIiibQNZeECdKrvIkmOAZ
   nuSJinDSEvT5GKv5HlQdABpvru/vbz8eyQnVHTvlynUHg0vDfuCTNNbjM
   s/6DnuLt/ZUDjxW1YybhjDnYpub6XCiRRvDdA2AbioVw5mBwDeE6Ng2Dc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346594704"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346594704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 04:18:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838517696"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="838517696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2023 04:18:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:18:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 04:18:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 04:18:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 04:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYk3rMk91kyf8WOMvVpoALB7oYcNu+cS0mcow67fQMUdXHz27gi9NhdzeQHmk8kFjoct2AUImuGgLk3At82F+d8PSAiAzcQ6n6zeHGjI5NZZHFHdBDWlbJYgwhpoywWmz+qZQKRHqPU1UWYtZ+GaYqklTYJeWBm+AbNY0Qp4oVZkCOL9qZzC8Eluv6Kc36MNh1K8VG/Y21akfrr6/EEPd0+44d6TMobCCcXt1FJPMCKX9YbZw+NJoDajgX06Qa30Uh+rd3bHwx1/mGEanaRxPOffMEkzgXbXTlzALsLyvulAs8HrIPD37PhAhznlNEMizLbK5yeWH+icJgL+LID2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saWLfU6d6fzFC0hm8WL/844U5M2GJ1sAsQS6DNeV4zM=;
 b=LTfn7ZGTPUmWEoq+rovJcjVpps7zyEfY1a+gzdUN8R8kNwBNh4HSA1jI0rGZoH2BWgnB1SszNQIkD/InG+PLfrj0BGpvsey99Isb7WgKvvojyY448IARnR0JuD9OQpRjLqUnnr8t01N/uFjDYfNgDD73lvTYIo1sPmba7wYh19ub3AZpAWxYJ20sqE+ISUq8UqqUfLXQnoIzNalFSjPjwVzazQeobZvoLswZtHM5HiqplJgc12jE7zShLwkopZhUwx/BKWqv/Kz3bU4IMH0ccOtNzV3psXGD8Yi/DSu7yb/Wj1552K0D6yhRia8aFF3SJpj5+NFRuJDijTw55tOCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM6PR11MB4673.namprd11.prod.outlook.com (2603:10b6:5:2a4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24; Fri, 21 Jul 2023 11:18:00 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 11:18:00 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "kuba@kernel.org" <kuba@kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "Olech, Milena"
	<milena.olech@intel.com>, "Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: RE: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Topic: [PATCH 09/11] ice: implement dpll interface to control cgu
Thread-Index: AQHZuut81WSQCKaWlUanjhbbmuUufa/CsZmAgAARQbCAARKGAIAAIjuQ
Date: Fri, 21 Jul 2023 11:17:59 +0000
Message-ID: <DM6PR11MB46576153E0E28BA4C283A30A9B3FA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230720091903.297066-1-vadim.fedorenko@linux.dev>
 <20230720091903.297066-10-vadim.fedorenko@linux.dev>
 <ZLk/9zwbBHgs+rlb@nanopsycho>
 <DM6PR11MB46572F438AADB5801E58227A9B3EA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZLo0ujuLMF2NrMog@nanopsycho>
In-Reply-To: <ZLo0ujuLMF2NrMog@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM6PR11MB4673:EE_
x-ms-office365-filtering-correlation-id: e87f8839-ab13-4db1-25a3-08db89dc244d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpm7Vm6By0+3VxgEmRxE7kDO7PsJxZP6H8PP7g8Bgc8ybMzWNPWYMRgmcCY1CZo2XKXsPDOrbiT0li9vRX3xh/RJdUY5EK8TD2LmSKDuRkpR7ePzoADni1IzwNIlkV/k2fCUbrduErG0nzfjZse8yn8x5/BA2fCZwYxiGgRb7q5xFDYGFjwP+bRa0BhEJ8uZn4BK8se2QaFx2VX3nAXPlX6qCBPPVily5po9p86VrxRmM9+yAY1d9FeHp06qrLmfkb7pxyxJVdKPmOJtVvJh0AFbnHTW+5CchG5000VuKQYpWR9b+lQYJjg68EVRCRbMGuyJ0X6kLcXtyVCUeIw/2a74vIIGqe+sojcMvW7nIe/bdec/jdzIQ0umc0BbLYCn+64QPfyImZTPAN16Dohq1ILHgWfwRdOYG6ugcAgKGbN2B8XEOnpJFFmIQtZNkh5x/Dpd8JaB0zQSVPqIoXlPZLVMWPFnOp1UHwSSFz30jHyP+I9z7gTRLEZjWk6U1/HFSnTmu/qLXqhO4CUxlcBlgS0TrsbhWWjNPriy+dgjwLRBLmdugnXyPb6euKJCVdErxwNO0x0wEMviwWTh9K3HQ5GsvgLEkTjJ5JsA/efeuo31QbrVh8dxr0Z8g/RejvjH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(38070700005)(83380400001)(2906002)(82960400001)(122000001)(38100700002)(55016003)(66446008)(71200400001)(76116006)(66556008)(316002)(66946007)(478600001)(64756008)(41300700001)(4326008)(6506007)(26005)(186003)(66476007)(33656002)(9686003)(110136005)(54906003)(5660300002)(8936002)(8676002)(86362001)(7696005)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NnTJmDNywnQ+oR3S/NY/bMHND8hgWvdbZxLzSSwWY9/eb12xSC016qeDKkUe?=
 =?us-ascii?Q?ciWfqeWMnvj/R69gVFPKuWxovG4LnY9aLAKLlM9q8FBVUsIFurFL2xMJMyKa?=
 =?us-ascii?Q?7rZlUfHw2a2i8ffJX2pbeJFGAeW7AwMdQm560KvkWQb77gAeD3a4qefOSgLA?=
 =?us-ascii?Q?leE5sclmVr/u8eT3Lp97AdtPk7b3mEhqry3TuacWX5kQJH9nlNAMuzo+6OeV?=
 =?us-ascii?Q?aaYrUDx65Bm+7aa+0N4ESVgFfNOJksEn/si+MqdGODQyEVr1blsEh0wNLGdp?=
 =?us-ascii?Q?6qoo8W5KzcKB1CHygUubeVAAjJ1+EJAXbF5gOXZAZnI3c4Yrfw4d29+jagdm?=
 =?us-ascii?Q?XgNQV8uSMTp/zYdT8PNe2VOaGatggZOYj+AvAlorAT1EYaj6agId7PCw4Cmg?=
 =?us-ascii?Q?uxyaePSb6NKUUv3n2Qq984WlvZ4YCs1Wx42YsBEEurtcnRZZy3hy4xLCCj3+?=
 =?us-ascii?Q?ybCTT5GtiDOqRgaCRxWeqF4nbAO5iaW+Fgwb+zLSDtQmkaV0xv8MINVWmzo1?=
 =?us-ascii?Q?Dh9Dn4oC2Kn2PDTj9RvSBOq4MQ+pUP5WVofe3hGNiFWmHLtt4U2yLB+2oCSZ?=
 =?us-ascii?Q?wURAxngJTkXHS8wA3mK7mYuaLi+TcHj5pOMI9JKcILIK4fZqPsUFaeHMrqOh?=
 =?us-ascii?Q?2tyH1PEQ00/AGXLIKF63sBXrAw7Zdb0Dr5fjcr9URpmFIvZNCIis79ElcaMH?=
 =?us-ascii?Q?jBU7Fpf62XL0/Xc6zLkCseKQHMPhJP6joslHxHUhwZGWbpoHm/6LiT5hTglv?=
 =?us-ascii?Q?CTmMOOReDO7T+bCJS0wFLi0xS+IpQcwr6ykwc6FkSwQqInBNELe3stpgmgk4?=
 =?us-ascii?Q?j8Y3RnsQJpY5gTvH2q0CU2rwHqdj0M+Cra1p5wiT5v3cK6MAVO9OYf7sHTud?=
 =?us-ascii?Q?Sz1KhxVtM1z0RGPRR7GSbSNN07iuPu/siUeb5vDz/ZzfEFYSi7q8s435Vmu2?=
 =?us-ascii?Q?Depeg+m5I4NV6K1NVw27jx68bfLgQnO1PVkTL8rEVuUemKdcMZ3qzHOCceAE?=
 =?us-ascii?Q?ZqacQQU2ZyfZ1/Z/SqncgvwrJWYkoeraPfEmi/V3DFTi4Bh3lpA7YRjJhPiJ?=
 =?us-ascii?Q?WH0a91WoOvibXX9QqNce6RNfunOBGZ1tHL1SePe7DKj2+sqI1o/trK/dPU45?=
 =?us-ascii?Q?8snk6NTn/iHSq3WYFIWCmGmyQPAItqRbknDmO8L9s7PMyem6g/RZKINHXqFZ?=
 =?us-ascii?Q?1QzEbP/OCXzoDhr79vCCfhQ1CDCIrrDconvizR/ny6rblZCqSjn86aoxja3S?=
 =?us-ascii?Q?8G4OSPXoQqpisSzA8/TxD6/iTwpH2buQsZCOPW4cQ3R1sVaFV7I5T252Wx8Q?=
 =?us-ascii?Q?kHkDUkfu/TgYcUyjFzrE69iVzGkwxNUCppTQOhgYdPCzoSGlkNomKJ1PagAy?=
 =?us-ascii?Q?pJzi8KK49nlBZY+Xfvyd9js2dxdV+AO0N7S0uqwup0qdiAIGzPOCVdXsVPgq?=
 =?us-ascii?Q?tprwKnwQfplhPahdFZZknbw5Zr2uMiytOPVoDIzr19lo2G+QIvp/bqF7C2AA?=
 =?us-ascii?Q?J9fbIErUAOi3eEWkk713p2WqtkOWE9qadzH51rt1CAIN6owJYxevWYbu5rzT?=
 =?us-ascii?Q?xROtAGYqyPF4YgMMRxLuVpmSYhv3Ut8ixNhulbCwGgulixdhdxdK6rnIvOfD?=
 =?us-ascii?Q?Bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e87f8839-ab13-4db1-25a3-08db89dc244d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 11:17:59.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvFSE9xbWqLxXLHsClnejYtVIwzNwAMtC+eVAheoqmqOwd/6FObDYtkOQv0fChHcrPlVGbigcGtOK36XLft/PfhjAk0+AJTG4354Ub+qFAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4673
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Friday, July 21, 2023 9:33 AM
>
>Thu, Jul 20, 2023 at 07:31:14PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Thursday, July 20, 2023 4:09 PM
>>>
>>>Thu, Jul 20, 2023 at 11:19:01AM CEST, vadim.fedorenko@linux.dev wrote:
>>>>From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>
>>>[...]
>>>
>>>
>>>>+/**
>>>>+ * ice_dpll_pin_enable - enable a pin on dplls
>>>>+ * @hw: board private hw structure
>>>>+ * @pin: pointer to a pin
>>>>+ * @pin_type: type of pin being enabled
>>>>+ * @extack: error reporting
>>>>+ *
>>>>+ * Enable a pin on both dplls. Store current state in pin->flags.
>>>>+ *
>>>>+ * Context: Called under pf->dplls.lock
>>>>+ * Return:
>>>>+ * * 0 - OK
>>>>+ * * negative - error
>>>>+ */
>>>>+static int
>>>>+ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
>>>>+		    enum ice_dpll_pin_type pin_type,
>>>>+		    struct netlink_ext_ack *extack)
>>>>+{
>>>>+	u8 flags =3D 0;
>>>>+	int ret;
>>>>+
>>>
>>>
>>>
>>>I don't follow. Howcome you don't check if the mode is freerun here or
>>>not? Is it valid to enable a pin when freerun mode? What happens?
>>>
>>
>>Because you are probably still thinking the modes are somehow connected
>>to the state of the pin, but it is the other way around.
>>The dpll device mode is a state of DPLL before pins are even considered.
>>If the dpll is in mode FREERUN, it shall not try to synchronize or monito=
r
>>any of the pins.
>>
>>>Also, I am probably slow, but I still don't see anywhere in this
>>>patchset any description about why we need the freerun mode. What is
>>>diffrerent between:
>>>1) freerun mode
>>>2) automatic mode & all pins disabled?
>>
>>The difference:
>>Case I:
>>1. set dpll to FREERUN and configure the source as if it would be in
>>AUTOMATIC
>>2. switch to AUTOMATIC
>>3. connecting to the valid source takes ~50 seconds
>>
>>Case II:
>>1. set dpll to AUTOMATIC, set all the source to disconnected
>>2. switch one valid source to SELECTABLE
>>3. connecting to the valid source takes ~10 seconds
>>
>>Basically in AUTOMATIC mode the sources are still monitored even when the=
y
>>are not in SELECTABLE state, while in FREERUN there is no such monitoring=
,
>>so in the end process of synchronizing with the source takes much longer =
as
>>dpll need to start the process from scratch.
>
>I believe this is implementation detail of your HW. How you do it is up
>to you. User does not have any visibility to this behaviour, therefore
>makes no sense to expose UAPI that is considering it. Please drop it at
>least for the initial patchset version. If you really need it later on
>(which I honestly doubt), you can send it as a follow-up patchset.
>

And we will have the same discussion later.. But implementation is already
there.
As said in our previous discussion, without mode_set there is no point to h=
ave
command DEVICE_SET at all, and there you said that you are ok with having t=
he
command as a placeholder, which doesn't make sense, since it is not used.=20

Also this is not HW implementation detail but a synchronizer chip feature,
once dpll is in FREERUN mode, the measurements like phase offset between th=
e
input and dpll's output won't be available.

For the user there is a difference..
Enabling the FREERUN mode is a reset button on the dpll's state machine,
where disconnecting sources is not, as they are still used, monitored and
measured.
So probably most important fact that you are missing here: assuming the use=
r
disconnects the pin that dpll was locked with, our dpll doesn't go into UNL=
OCKED
state but into HOLDOVER.

>
>
>>
>>>
>>>Isn't the behaviour of 1) and 2) exactly the same? If no, why? This
>>>needs to be documented, please.
>>>
>>
>>Sure will add the description of FREERUN to the docs.
>
>No, please drop it from this patchset. I have no clue why you readded
>it in the first place in the last patchset version.
>

mode_set was there from the very beginning.. now implemented in ice driver
as it should.

>
>>
>>>
>>>
>>>Another question, I asked the last time as well, but was not heard:
>>>Consider example where you have 2 netdevices, eth0 and eth1, each
>>>connected with a single DPLL pin:
>>>eth0 - DPLL pin 10 (DPLL device id 2)
>>>eth1 - DPLL pin 11 (DPLL device id 2)
>>>
>>>You have a SyncE daemon running on top eth0 and eth1.
>>>
>>>Could you please describe following 2 flows?
>>>
>>>1) SyncE daemon selects eth0 as a source of clock
>>>2) SyncE daemon selects eth1 as a source of clock
>>>
>>>
>>>For mlx5 it goes like:
>>>
>>>DPLL device mode is MANUAL.
>>>1)
>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth0
>>>    -> pin_id: 10
>>> SenceE daemon will use PIN_GET with pin_id 10 to get DPLL device id
>>>    -> device_id: 2
>>
>>Not sure if it needs to obtain the dpll id in this step, but it doesn't
>>relate to the dpll interface..
>
>Sure it has to. The PIN_SET accepts pin_id and device_id attrs as input.
>You need to set the state on a pin on a certain DPLL device.
>

The thing is pin can be connected to multiple dplls and SyncE daemon shall
know already something about the dpll it is managing.
Not saying it is not needed, I am saying this is not a moment the SyncE dae=
mon
learns it.
But let's park it, as this is not really relevant.

>
>>
>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>>>CONNECTED
>>>
>>>2)
>>> SynceE daemon uses RTNetlink to obtain DPLL pin number of eth1
>>>    -> pin_id: 11
>>> SenceE daemon will use PIN_GET with pin_id 11 to get DPLL device id
>>>    -> device_id: 2
>>> SynceE daemon does PIN_SET cmd on pin_id 10, device_id 2 -> state =3D
>>>CONNECTED
>>> (that will in HW disconnect previously connected pin 10, there will be
>>>  notification of pin_id 10, device_id -> state DISCONNECT)
>>>
>>
>>This flow is similar for ice, but there are some differences, although
>>they come from the fact, the ice is using AUTOMATIC mode and recovered
>>clock pins which are not directly connected to a dpll (connected through
>>the MUX pin).
>>
>>1)
>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>pin_id: 13
>>b) SyncE daemon uses PIN_GET to find a parent MUX type pin -> pin_id: 2
>>   (in case of dpll_id is needed, would be find in this response also)
>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all=
 the
>>   other pins shall be lower prio i.e. pin-prio:1)
>
>Yeah, for this you need pin_id 2 and device_id. Because you are setting
>state on DPLL device.
>
>
>>d) SyncE daemon uses PIN_SET to set state of pin_id:13 to CONNECTED with
>>   parent pin (pin-id:2)
>
>For this you need pin_id and pin_parent_id because you set the state on
>a parent pin.
>
>
>Yeah, this is exactly why I initially was in favour of hiding all the
>muxes and magic around it hidden from the user. Now every userspace app
>working with this has to implement a logic of tracking pin and the mux
>parents (possibly multiple levels) and configure everything. But it just
>need a simple thing: "select this pin as a source" :/
>
>
>Jakub, isn't this sort of unnecessary HW-details complexicity exposure
>in UAPI you were against in the past? Am I missing something?
>

Multiple level of muxes possibly could be hidden in the driver, but the fac=
t
they exist is not possible to be hidden from the user if the DPLL is in
AUTOMATIC mode.
For MANUAL mode dpll the muxes could be also hidden.
Yeah, we have in ice most complicated scenario of AUTOMATIC mode + MUXED ty=
pe
pin.

Thank you!
Arkadiusz

>
>
>>
>>2) (basically the same, only eth1 would get different pin_id.)
>>a) SyncE daemon uses RTNetlink to obtain DPLL pin number of eth0 ->
>>pin_id: 14
>>b) SyncE daemon uses PIN_GET to find parent MUX type pin -> pin_id: 2
>>c) SyncE daemon uses PIN_SET to set parent MUX type pin (pin_id: 2) to
>>   pin-state: SELECTABLE and highest priority (i.e. pin-prio:0, while all=
 the
>>   other pins shall be lower prio i.e. pin-prio:1)
>>d) SyncE daemon uses PIN_SET to set state of pin_id:14 to CONNECTED with
>>   parent pin (pin-id:2)
>>
>>Where step c) is required due to AUTOMATIC mode, and step d) required due=
 to
>>phy recovery clock pin being connected through the MUX type pin.
>>
>>Thank you!
>>Arkadiusz
>>
>>>
>>>Thanks!
>>>
>>>
>>>[...]


