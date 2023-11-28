Return-Path: <netdev+bounces-51814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BF7FC522
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4126C282D5E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0540C14;
	Tue, 28 Nov 2023 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFktkhas"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FEC83;
	Tue, 28 Nov 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202752; x=1732738752;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zdGzrG68bIlkrtS+wBqudpyd9R2eXddNO8r7RyNxSU8=;
  b=GFktkhas0OrhngcegOlN/55JqDzHJ/1X7lfo8h1YzhAzCkEnFGSAsZ6g
   0xRfTn4c41xq65rXLF1evsawBq9/WUN3AqboXY+j9vPBfiZzXJObmTJhf
   HiFxXKdGW6Xe4paaGI0+hZyUIyy1VP1fHnXzIFH74WwmlsLPEEm7XimjR
   /Ta3yoPP4NW74KR+afsX/Fy3iLiM5V3d2cyGTbdTBD5UQQQzsfgy0GDAV
   miOmaLFcVej7uKZCyPB8sSpsNtsae8m+OR/KjGfo6ULJ1naeSnjJgBa71
   s0CS2EiB7LpczXvmojJw8MxsbauFQdXGtIoJVoP3+BjB1Pj//kSbSGxfe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390173790"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="390173790"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:19:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016033937"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016033937"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 12:19:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 12:19:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 12:19:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 12:19:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJG0ZgJ4xZj/0oacT30gjo6eQipSKCjC2bvFA/dgqODQ6RyFBY1j/tdxw/ZEasM3XvLEt0mL3rWd4KzydySEnUqg8Aiim3XLw/ztJyGC28Z03KwACh494mney3XuFPg8/nC2kSEHLHYkB3kuuOw9xOj3b1Tq/FmuWVagx8wYf3Wmn8oYdTWW3hHBmKiLL3ORfj1zkcBrZuib78Fzey2OFilZBRzGOmHfYyqJLy+8wVMHQAMacYZpPQqhbHSv+iVdUKjZW/NUOqj52MGtoxPUnwMO3+j3/U9GmMGsbSC/Gn3Ng8C+0uzOEDNh1X6OdyMnSInYaV/dnXS1sUh6X9DolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdGzrG68bIlkrtS+wBqudpyd9R2eXddNO8r7RyNxSU8=;
 b=fY/qYF2r99xo4y7IXsgIrCmZkHjPtxEmnqVjVN6r4ocdlGtgZC/cwigi3lkSuVjLgHNdPtXhti4tL27jJA4DMQQaSHt9g37RfwnUbypXG4jaawn238EfrMpmll7zj6IIvpHVKqj7oOLCJAGxq3eh4Z0ZK3Dek2j2ZX8KYemUH1tKf8ihhkgBFn/Tlr78C+5UM7iEHRmTRmClq1yip38J2F5kTa7o7uMTeyljArpt/a6qTbNOchBUmw+u1QE5Mnw/BI3Jt0yFaqFdpX81bCU3VuJEbDnf2KMpvdQoBHPG8LbIGGwWayg/JdCJSakSMSkWP+eyO0obrhsCIBIZLgaBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB6026.namprd11.prod.outlook.com (2603:10b6:208:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 20:19:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 20:19:05 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Zaki, Ahmed" <ahmed.zaki@intel.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "gal@nvidia.com" <gal@nvidia.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Thread-Topic: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
Thread-Index: AQHaG/QP185W+Ikg/kG7KHZafeRsILCFbSEAgAjTIoCAAffJEA==
Date: Tue, 28 Nov 2023 20:19:05 +0000
Message-ID: <CO1PR11MB508922EA06C6A1BD14FF0A3CD6BCA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
 <20231121152906.2dd5f487@kernel.org>
 <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
In-Reply-To: <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|BL1PR11MB6026:EE_
x-ms-office365-filtering-correlation-id: bae1a484-45ba-47c4-946b-08dbf04f452a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eysw1Q7Xhr5oHoQOYcPm53vaEUkH35vm7vqjCU+qm7/EMtdOXKjBT4OhTGZc/ZwJJ0SjrK41WxFii7S/ILNRlK5+cV1LUgxqUPGAmba5AiIwpoliLGP94U92CpmdAaxliJ7RoHnCKjm4l913QUbTlz+p1CsjerehuN0jAU++j6tYCxazur5i6CPVOz2w1qgAFgq/3kI6Cu5wwwzItXtgDnRgW/aKrpjJdXcDaZe79iPzX2W81NI7JahkIZFlCD/Q8FTLY6TiQgVBeLyXSzz6hAZpFC7SAZkuTDIEfWyJIQn600yhGUtL6kPWMkNalCgPUiUVZk4RXjhDWx+CMQdNUA7EonKDD8TsZHXOeK+jrGF0oC4ChfoMAdiuMx2yfEmaDUth2ZOh2zx6O+V+r5eo3NAPIamAWJnQdWqlOugAwbjA5FmW0PWxCR8swss+1DeQ8pxG57BURW6vWKSU8EzcMv3hHpnm+0PRXWNL24keaY1JilyHl7Yey7pnFqBA8hHU8EaGtYYL8wkDHayIKv5j0kualAwmmPQL3Ct0RTbC7IpdTXF6xwtq19dBXXkmL0YHc9dczkybeW065fP7lFmJinqBYvXp5W3LOzx0JpbsuMhMdeyTN4gTAphnFy4qSpvo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(4001150100001)(33656002)(86362001)(38100700002)(38070700009)(122000001)(55016003)(83380400001)(82960400001)(5660300002)(7416002)(26005)(107886003)(2906002)(9686003)(7696005)(6506007)(53546011)(52536014)(4326008)(8676002)(71200400001)(8936002)(478600001)(66556008)(66476007)(66446008)(66946007)(76116006)(110136005)(54906003)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amZjdkVNYmZXdmpVYk9xSUM2WFlZdlUvaTJhblRCVDUyMWkrazVuMXdGQ3BP?=
 =?utf-8?B?RFZMeis2TktvSDliREV5SjZPY2o4eEdxRmRjVmVOcW56U3NIcllZNDAzanA0?=
 =?utf-8?B?L0JCUmFySnBBOVpOMVB6RkZuWE9YbVQ1THVSalR3NjBIMWpEWi9GeWpEbi9B?=
 =?utf-8?B?SzlmSE1Ua3VGRk9VV2ErWmdkbGlSUko1SDZZZDdaUitxSHg0OGpXWGNnVnQw?=
 =?utf-8?B?cjd6MzBpNUt3RUxaVy9oYXBoNDFBUXJsQVdOcmpNd0djUW03aGt4dVlabEd5?=
 =?utf-8?B?cDFleGtxY0NUWDlPUW1ILzFqbk1RS0hlY3grVHMrSVlGdlNpY3liYm5YcWZM?=
 =?utf-8?B?QTY1OXVVVzh6RWFsREdrRVVqTWlRRW85ZkhxSjVYTGNMSzdzQkpCZVB0cFlq?=
 =?utf-8?B?em95UDczVTUxV3FIU3poR0ZvR0Vyam4rcjY5emZFMFkxZkFMZXlFc0NDakRv?=
 =?utf-8?B?REdRUG1yeW15bkwrS1IxTno3UzlJODRrem45WGpIR2kwV2tWK0twZDNpUU1P?=
 =?utf-8?B?QkhFQTBBZGRoS3o2OE0xSFVxRzk2NXd2ckQyQWErWitHWGlCaXYzQmhDWFNx?=
 =?utf-8?B?RkpqNWpmYzh3RDFwWWxHTEg0Q25MTWVxN3diWVV1QjQrMDV4UFU2TE1Gc3E5?=
 =?utf-8?B?dDlmZDgreW82TE81c1FjYnF1bFNHWVdLdU0wTWZrc2pmQThGVlN1ZnBKUTZv?=
 =?utf-8?B?L0tkdk9jRGdJSWh4Z1hCMXdBNmJ6TWxuUy9pbnB0L2ZlYldrUk5VMm5hNC82?=
 =?utf-8?B?NGxjSGJjNmJDcjhUZDJ6Z2xRdUdUbENHdG0rVEVEUW9uaTZYd1dHdVRGZC9F?=
 =?utf-8?B?SklBZEdXc2ZjQThLUkV4azBzQkowUEtBaWNDOGI1Sm5xMlpiR2YrV3VJdWg5?=
 =?utf-8?B?NDVEdEorV09MbDlETTNrWjFGaVZZSTVCYUM4czZCV2xHdVhMMUJ0ZGtLMVpP?=
 =?utf-8?B?elZuZ2JhL0hhd0V2bFNSQitvaklidDhCb3h3bm9VUmZrc2s2THkyMXJJQXNL?=
 =?utf-8?B?VEc1SHhRUVpiK1hSMHFELzN3NmhnMHZaWDJ2ZFVPM3ZrSHVNUjdqRnhpWjdT?=
 =?utf-8?B?RUZGUy9TQzZIVDl6Q0tkbjd1blI1cnBOQTdZU1h0NkJleXdtSlV6aTE4Rno3?=
 =?utf-8?B?MkxOU2ZhakFlTGtjY29TcWJWQVdTbzVKUm9jMGpNNXR6MUtnZDFNOWVzSERx?=
 =?utf-8?B?UHFDRE16THQ0QlNWRGNQYkNaelNHUUUwWngybFFsNkR4NjVWbGU1M3gyU1dH?=
 =?utf-8?B?TkFmUWg5UlRXK2VJRUJOQjA1eDlJQmc2LzRXZnNNdWN2SUNCeUxyMERxMzhV?=
 =?utf-8?B?QXlWUEdLdEhLM2s0cjJudjgyUXd6SG1yb3E0SkdocS9iWExTaC84ZzVmVTFQ?=
 =?utf-8?B?YXBTSElUSjVlUjRCS091UGhvK3VFa2VIUThCRVVYYmtDRXJXclQ5RGRUWGkz?=
 =?utf-8?B?OXFOU1AwYlpHT1Y2bm1weVNpa1dhRU5NM3FwTFZmUndjTWNVSzBnbkhiYXFM?=
 =?utf-8?B?S1FXQjUxTHBBNXJYdmdaSk01VGErRmVTYVhZNGNHRS9ZRjl3V01ldklmYjc1?=
 =?utf-8?B?SFIrM3BNcm1MZWtHRTFIMDlJcEZuZksyeDI0SGc1eGdlcUNROC9zbWk3MGMz?=
 =?utf-8?B?dkpiQ0hGTVl3Uk0xbHowVjdVdEJyd0dmUDBuUUQzeEVZWmZJVkJIZk11VUJC?=
 =?utf-8?B?RThvRmZlYmVNbnhQTnMxcmVMWXpUTW1NYm9rNFV5a3QxMkJTQTYxL3FDL1M2?=
 =?utf-8?B?VDVrcFJQQmhnM0NMbTRaUEJGV2huMzBqYVhSY2Y5UXB6YkpIQVFReVRaLy9R?=
 =?utf-8?B?WEdwWmdkMHgwSFBrRDJ3bzVscTd0OHYwTFErS1JHWHU4ZWVWcHhyVVVhek42?=
 =?utf-8?B?ZThlR094cVcyU0R4c2dFTm42cStlTnoxbzRNVU1JRC8va2dFSnhvYVJMVzZS?=
 =?utf-8?B?V3hubnBZSlQ4RVhzdHB6SE1TeGxTY3ljNGd1T3RkRFZjanFBN29aK0ZhRldw?=
 =?utf-8?B?MHlKWk9xU3l6WEdBSWE2OEdXY3B6QjAyRGJpdUlWTXdIcTRPQ25qZGhWczRU?=
 =?utf-8?B?dWplZ2JsU1BEUlpjNEFBY011TEVZOFd2MjRRSXZ5aTFJcGlhcjc0MjRSQ2lQ?=
 =?utf-8?Q?rPd0ujym/GVtps3fEHnC8Lwov?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae1a484-45ba-47c4-946b-08dbf04f452a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 20:19:05.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwHSo305feoimrC4duqdQtM8wAHLTz90UbfkRsx45pflGjFBpRInISOd9BloG9ssLr2qx6H88EBXToAQBESYWKvgfZSFQ7Uxpfx6w6huMwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6026
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmFraSwgQWhtZWQgPGFo
bWVkLnpha2lAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI3LCAyMDIzIDY6
MTUgQU0NCj4gVG86IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgY29y
YmV0QGx3bi5uZXQ7DQo+IEJyYW5kZWJ1cmcsIEplc3NlIDxqZXNzZS5icmFuZGVidXJnQGludGVs
LmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IHBhYmVuaUByZWRo
YXQuY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsgYW5kcmV3QGx1bm4uY2g7DQo+IGhvcm1z
QGtlcm5lbC5vcmc7IG1rdWJlY2VrQHN1c2UuY3o7IHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFp
bC5jb207DQo+IGdhbEBudmlkaWEuY29tOyBhbGV4YW5kZXIuZHV5Y2tAZ21haWwuY29tOyBsaW51
eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPiBCYWdudWNraSwgSWdvciA8aWdvci5iYWdudWNraUBp
bnRlbC5jb20+OyBLZWxsZXIsIEphY29iIEUNCj4gPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2NiAxLzddIG5ldDogZXRodG9vbDogcGFz
cyBldGh0b29sX3J4ZmggdG8NCj4gZ2V0L3NldF9yeGZoIGV0aHRvb2wgb3BzDQo+IA0KPiANCj4g
DQo+IE9uIDIwMjMtMTEtMjEgMTY6MjksIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAgTm92IDIwMjMgMTM6NTY6MDggLTA3MDAgQWhtZWQgWmFraSB3cm90ZToNCj4gPj4gICAJ
dTMyCSgqZ2V0X3J4Zmhfa2V5X3NpemUpKHN0cnVjdCBuZXRfZGV2aWNlICopOw0KPiA+PiAgIAl1
MzIJKCpnZXRfcnhmaF9pbmRpcl9zaXplKShzdHJ1Y3QgbmV0X2RldmljZSAqKTsNCj4gPj4gLQlp
bnQJKCpnZXRfcnhmaCkoc3RydWN0IG5ldF9kZXZpY2UgKiwgdTMyICppbmRpciwgdTggKmtleSwN
Cj4gPj4gLQkJCSAgICB1OCAqaGZ1bmMpOw0KPiA+PiAtCWludAkoKnNldF9yeGZoKShzdHJ1Y3Qg
bmV0X2RldmljZSAqLCBjb25zdCB1MzIgKmluZGlyLA0KPiA+PiAtCQkJICAgIGNvbnN0IHU4ICpr
ZXksIGNvbnN0IHU4IGhmdW5jKTsNCj4gPj4gKwlpbnQJKCpnZXRfcnhmaCkoc3RydWN0IG5ldF9k
ZXZpY2UgKiwgc3RydWN0IGV0aHRvb2xfcnhmaCAqLA0KPiA+PiArCQkJICAgIHUzMiAqaW5kaXIs
IHU4ICprZXkpOw0KPiA+PiArCWludAkoKnNldF9yeGZoKShzdHJ1Y3QgbmV0X2RldmljZSAqLCBz
dHJ1Y3QgZXRodG9vbF9yeGZoICosDQo+ID4+ICsJCQkgICAgY29uc3QgdTMyICppbmRpciwgY29u
c3QgdTggKmtleSk7DQo+ID4+ICAgCWludAkoKmdldF9yeGZoX2NvbnRleHQpKHN0cnVjdCBuZXRf
ZGV2aWNlICosIHUzMiAqaW5kaXIsIHU4ICprZXksDQo+ID4+ICAgCQkJCSAgICB1OCAqaGZ1bmMs
IHUzMiByc3NfY29udGV4dCk7DQo+ID4+ICAgCWludAkoKnNldF9yeGZoX2NvbnRleHQpKHN0cnVj
dCBuZXRfZGV2aWNlICosIGNvbnN0IHUzMiAqaW5kaXIsDQo+ID4NCj4gPiBUaGlzIGNvbnZlcnNp
b24gbG9va3MgMS80dGggZG9uZS4gWW91IHNob3VsZCBkbyB0aGUgZm9sbG93aW5nOg0KPiA+DQo+
ID4gICAtIEZpcnN0IHNpbXBsaWZ5IHRoZSBjb2RlIGJ5IGFsd2F5cyBwcm92aWRpbmcgYSBwb2lu
dGVyIHRvIGFsbCBwYXJhbXMNCj4gPiAgICAgKGluZGlyLCBrZXkgYW5kIGZ1bmMpOyB0aGUgZmFj
dCB0aGF0IHNvbWUgb2YgdGhlbSBtYXkgYmUgTlVMTCBzZWVtcw0KPiA+ICAgICBsaWtlIGEgd2Vp
cmQgaGlzdG9yaWMgdGhpbmcgb3IgYSBwcmVtYXR1cmUgb3B0aW1pemF0aW9uLg0KPiA+ICAgICBJ
dCB3aWxsIHNpbXBsaWZ5IHRoZSBkcml2ZXJzIGlmIGFsbCBwb2ludGVycyBhcmUgYWx3YXlzIHBy
ZXNlbnQuDQo+ID4gICAgIFlvdSBkb24ndCBoYXZlIHRvIHJlbW92ZSB0aGUgaWYgKCkgY2hlY2tz
IGluIHRoZSBleGlzdGluZyBkcml2ZXJzLg0KPiA+DQo+ID4gICAtIFRoZW4gbWFrZSB0aGUgZnVu
Y3Rpb25zIHRha2UgYSBkZXYgcG9pbnRlciwgYW5kIGEgcG9pbnRlciB0byBhDQo+ID4gICAgIHNp
bmdsZSBzdHJ1Y3Qgd3JhcHBpbmcgYWxsIGFyZ3VtZW50cy4gVGhlIHNldF8qIHNob3VsZCBhbHNv
IHRha2UNCj4gPiAgICAgYW4gZXh0YWNrLg0KPiANCj4gQ2FuIHdlIHNraXAgdGhlICJleHRhY2si
IHBhcnQgZm9yIHRoaXMgc2VyaWVzPyBUaGVyZSBpcyBubw0KPiAiRVRIVE9PTF9NU0dfUlNTX1NF
VCIgbmV0bGluayBtZXNzYWdlLCB3aGljaCBpcyBuZWVkZWQgZm9yIHVzZXItc3BhY2UgdG8NCj4g
Z2V0IHRoZSBBQ0sgYW5kIGFkZGluZyBhbGwgdGhlIG5ldGxpbmsgc3R1ZmYgc2VlbXMgYSBiaXQg
b3V0IG9mIHNjb3BlLg0KPiANCj4gSSB3aWxsIGRvIHRoZSByZXN0IGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNClBsZWFzZSBpbmNsdWRlIHRoZSBleHRhY2sgbm93IGV2ZW4gaWYgdGhlcmUgaXNuJ3Qg
YW4gaW1tZWRpYXRlIHVzZXIuIEEgTlVMTCB2YWx1ZSBpcyBhY2NlcHRhYmxlIHRvIHBhc3MgZm9y
ICJ0aGVyZSBpcyBubyBleHRlbmRlZCBBQ0sgYXZhaWxhYmxlIiwgYnV0IHRoaXMgd2F5IHdlIGRv
bid0IGhhdmUgdG8gbW9kaWZ5IHRoZSBkcml2ZXJzICphZ2Fpbiogd2hlbiB0aGUgZXh0YWNrIGlz
IGF2YWlsYWJsZSBpZiB3ZSBhZGQgYSBuZXRsaW5rIG9wIGluIHRoZSBmdXR1cmUuDQoNClRoYW5r
cywNCkpha2UNCg0K

