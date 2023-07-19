Return-Path: <netdev+bounces-19241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1320C75A05A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E3E1C210B9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697871FB38;
	Wed, 19 Jul 2023 21:09:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8E41FB25
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:09:31 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEE11BF0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689800970; x=1721336970;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0yX9KcnEpZji4kVm3lkWprFp/aFc5xAtWOvXD0IY7w=;
  b=ca9EayHec2M4yCGbR97x6NhUIRrfn1i2MaURXBMl/z/lWhrqpjZe4aH/
   Sc/NV/e88Lu/wYonfLVIHK9GgS2CiQlmFWZXwnWDgA1IXks5tXnZLFosO
   V4X9ldNDGA5tkoB08bih107si1rOXNNt5pnxIk+OumNPsyilJEg4urMFC
   sDZ88O/QrLVqR0X5WmUzH5z+2YkooBwqKvCGxR2t9kipD2Y1424d9Gd1C
   g4ndHwa1hFtCaRTbw8hNV7Zn6jsCBy5AatSnmedA+0iRrvgffDdxRul44
   uxW5rcj7+2zZpMWyIoJUmICoHL//ibCvx2inlB79tum+7mHycLvMR4RHC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397434898"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397434898"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="759314123"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="759314123"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2023 14:09:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 14:09:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 14:09:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 14:09:28 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 14:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWl/pz3Bp/pu8oC6eNY3N1zyiIDD7pgGotDDOBCCFobXJYaW1C67ANefOj9qt6wlzC0800Eko44ECPMrySltliCGWNITNwijuDmGVzUk0JnRUVufaMe9q2r4rMAVPUtiSV3Fhaf0vrUiZ9EDIQrjf2GCmFtWxNqEeTnedUm2VYL3HI3TyMbXxAVi5gF/HsLS0vHc8MTOaXy5kBFoBSBjXhSG82HzWuveIbw6c6nlfkIrAuS91MfspcRVrIiSt0Mj96wVdkyQ7W3Hy5w/UzMmmp5YLHf7fl3N8iEUFzPYRNhUzQQIO8Q4YFH4vqNBb4qZz2Hrd9ONmpNUDVvUm3BhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UdhBpkf/JhlXtjoAewYRTcw2ZlBVrQ+J5XgWHzGIuU=;
 b=Ohw8TyLEV/cG12jtWwqO0iw9VlaMah8n+rXJF5FswnyLccdso1r+7g+g/zlu52eK8kjkPR3p13QqGVclPAHPga5aSs1JyXzMKB8qtFR6TytgGkC88mRNJVr9KUqOURaZUepL+/akC1vI9XZ/R4RlaTLbx+ULNWyUy8W60XdOm4peiOLjWBZTMXFaTriHBwmVjtsuZQGWK5bHMo8xCJ7BoB58w2Rh7V5o1RmpihSzHj8oZV1NmF1O/CJDzDEj4YIswt/3kK+G+yIuzD5XBgaBmZJUG0fRnZw/GblPwxTkATZKhtUz/qBQvRVi4GGch6FuDERNUfrdZ6Q3VjyWFGOOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 21:09:21 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 21:09:21 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Thread-Index: AQHZuZRc1E9x7V2otkOnab77FbmQka/AbGyAgAEq4TA=
Date: Wed, 19 Jul 2023 21:09:21 +0000
Message-ID: <DM6PR11MB46571D1C5B557A598E090B3E9B39A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
	<20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
 <20230718201913.632b6936@kernel.org>
In-Reply-To: <20230718201913.632b6936@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: b0c7d06c-470d-4765-ff3f-08db889c6c0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MDB5OFUE03PkSJ4GoyHbSX1LA0ncmxmbxMnRgfuZLRPBXb+pylfhNQRK0jwzj+n7kRpgAlHhn3aijU72LssDHBOCD1N1zc95t8AOYiY0BKHh4xhd02yPhWv+7SpdxiPhlLS3ii6W7u0yNTGdP+p2nFCs1ND41nc8eCFk/NHKYJJya6UjDX9d0y0kWDPgaKAg8pFar+GDwJFnq04mITCq4ste1xpk+DtwT9xjLScM4QsCiFqxUQBCzr7qipRCwHmuxXD1Y/7yiuKlZC4iJUd3SMW0s4RedxwAhqfq+dU3ZeP5QCjHemcgq05EOsAvQGsdv2zh1VGeQtcAuCpFL96q2A0fVXpJZfVDryFJ8LGIdH4GcUDi8fFfHiQCr4iQMGCPoPVFi4euzOpGg3Kb1JvkcDGr9csuYSzHGX69G9YMlK569TWVtyIszrifWt1McZ2+6gN1j94SvCT5OzxEv02iv6fHFcFpZqGi54+F205/4l/v6eQh/lghjS0Zb6uPpVrEJcSIGhuRG0zqe/BPpSjIfO7SsIfMOm4lMN8vFiRjGd3HlUNbG7EFUFnNzv5WDRIKQoi4/NYrSUNQZ/F25S1Ywk3nH4IbUJDBTPtQ747qfkunZ9BnrBi+4lf1DpSSa3yN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(7696005)(9686003)(33656002)(26005)(6506007)(186003)(71200400001)(55016003)(66446008)(76116006)(66946007)(64756008)(82960400001)(6916009)(4326008)(4744005)(316002)(2906002)(86362001)(8936002)(8676002)(38070700005)(52536014)(5660300002)(41300700001)(66476007)(66556008)(478600001)(122000001)(38100700002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ud6BYyNjCJldBCmx8dII9Ambam7EivifXQLjZ0Iyk5DI2jqmSxAb6VpUS8Dy?=
 =?us-ascii?Q?SluWMLNjd3KG6ESdNm8Ge1/lp5WPZQ6CG2eZJRWffDPr5bXk/BIhmvsQp5/+?=
 =?us-ascii?Q?Sk0siEQIlXWfW13PTnBapasy2k7bf/NCjSqELypbccNniZaIk8D06eMTM5s4?=
 =?us-ascii?Q?u1B0OyEhD+a0RauMje+TERYF8m4Kz+ooJbPIv6O5sVkPCXapl9EjKt1T5RYR?=
 =?us-ascii?Q?a2mrNewG9v0Mn3aD1ZWnDbElGlt1V0wE/4czD64qNVf+Jqn99LoRwex2Yeh8?=
 =?us-ascii?Q?bxTZfFSFVpS6qxXwcYZsESxAYlByD/SApomtF0QtbIV8dsjbzSKUlwRoxC69?=
 =?us-ascii?Q?ORIaLcccDER954+ElhTsF/VKghqL2DegfmGglelo8cP9rvIzrEr2i0jnYcnF?=
 =?us-ascii?Q?oQE8pvtvLOUoOX2F+Y1fHGltNuNZUbnJ/vN5Aff7SvQqgJy9ZW4UawVHJsxP?=
 =?us-ascii?Q?eDN7ASUxNJZw4e2189B4YQAerr9Mant1GH77cwA3IsC/DljCwKG85coq86Wt?=
 =?us-ascii?Q?rfGzBaClpWTKDGnt4DATcPvXe3y2fPKjO0cOdFXXb41oDZEnDbOMo3AW24MM?=
 =?us-ascii?Q?dGoRHYiwWTlfU8Voz0X19I79HfE1uhhEMKpNwGVQOP7lNpLTNlx/pKl4Lwmt?=
 =?us-ascii?Q?0Wkw4YDWpDU2cI1aA6Cj3BphcrJKpOtn5eBN/x0wEqu8CKweXkp1/OQdHAaQ?=
 =?us-ascii?Q?WmTpM/CZBrGKnmJxsg6A3VppjES/mF4Ct0gfnUFj0y2+dKj2D34dFvIQ7JIU?=
 =?us-ascii?Q?MqNZz4X4yZHD2rD1bw+IdZEkL8IJ99sgmtOCp+u6sgKe45znOZFjQgLKY8If?=
 =?us-ascii?Q?eU6Tt5rEvmDiRQtsH/SdFdAEMnt9CVTXYdlCpGLzjaCJxwQbWmhxIRv9WS9Y?=
 =?us-ascii?Q?NGcBbY98kEzGaoOT87Z5QY9DEuy8jXWZq/Azz1CrQmlIzSpUAe3GscZAFJWU?=
 =?us-ascii?Q?PLrOALEPvEOhASKwYpkMfitygeT/GNwZGVrHf9mEcGClBeu0YiRwBhKsY8hp?=
 =?us-ascii?Q?EYjeMn5lNGo1DwpEBoQ/x8py9S+so7Cc4m1Ch6QZl39SMAL40hBR3Ve3wmfp?=
 =?us-ascii?Q?Snt/4rNF/W1INOOTRruz7LeDm42YvtysNPmAe3S87OOlBAMRVYdQXt4nUeSU?=
 =?us-ascii?Q?DDEzERE5pEQ7j971pbbs5zXk34xWqYH0jeWa2N559jL/wUmaGvHVBAvjLDQe?=
 =?us-ascii?Q?v3yPhllELcpSjtfG32aVF/KNBFiXXW3ukDXGECGRxoWmhDlBS42NZcT4yGai?=
 =?us-ascii?Q?UwIQco1dLedA1RRAc/lxB7onOI20jwpkx4PVIBGvtWn45V9LwTdwz6ZOhl1/?=
 =?us-ascii?Q?zmnqsay43XqKb1WGxw+iiUVisl2msTO9is4zjlDLoE+AJZ1MYnAsFwyZbjhF?=
 =?us-ascii?Q?DQackX2EcD61xAJrVNsY+CQQJbUf/YGrr0P9Kv+G+vfHqA2m+iGOTYkKAidr?=
 =?us-ascii?Q?EnlU7iHbtHYS8tlpD00pZDstOIrrcb1qz4tb6Q46qFVH8ekJH8hINo16e4+W?=
 =?us-ascii?Q?3/9+TzUrqVwLTQWayOFcolOIq73mEi4hbZV49M3lezwHBUSxSwL+vluwE+0y?=
 =?us-ascii?Q?LBoGeB5w8NmGwHIP+Azz6IxSFovxl7rHnSX2v+WoPFWxF6snZVhVAQw8h1bN?=
 =?us-ascii?Q?oA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c7d06c-470d-4765-ff3f-08db889c6c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 21:09:21.1942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4V/ClPjxlXMlp5xyw3zMKgrpHFDWFw1grDqnt0enSKlIezdxaCTXNpqY3bfzCW47GRR4BlLSmkjfQWvuieue4tqoqShpLXfVeBIOOBZrH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, July 19, 2023 5:19 AM
>
>On Tue, 18 Jul 2023 18:22:25 +0200 Arkadiusz Kubalewski wrote:
>> +            if 'enum' in attr_spec:
>> +                decoded =3D self._decode_enum(int.from_bytes(attr.raw,
>"big"), attr_spec)
>
>why int.from_bytes(attr.raw, "big")?
>'decoded' already holds the integer at this point

Yes, will fix.

Thank you!
Arkadiusz

