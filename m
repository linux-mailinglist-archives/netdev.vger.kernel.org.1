Return-Path: <netdev+bounces-16466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBF74D602
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 14:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D540228106B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8710961;
	Mon, 10 Jul 2023 12:53:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885580C
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 12:53:48 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20EE5
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688993624; x=1720529624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=olVRqiLZvBl08odmZMqm8uO575lwtRWt5OKPd4210Ag=;
  b=jr6Lo1/iS4D3suvProNeR1d8wLA6SuCNaiXw/SapUbd+cpDj6lFsYWaH
   MHVH1lVjCPM1aSq1cSD13JHzQYk85Ycyi3JJk+uUesBQcaPU/qW2VjQTR
   GfdhyV4QLD+dkAkFX+qKWArvsGjBtbFhjNzE66czVkd+Hbmcd5FKj4EUr
   aMPTJYA+kyzQNpEJJX+zijy03ws+6i/B2PUujiiiRKQCV1bwaca+SQTUr
   tOBJdyriof+RfjEF9Ra8FU03YdMXJ/HtzhId3qOKDhCNblitWU4Sv586g
   4Bo+7LTCjjadCYXUZcY2ECCPsdDVqCxCvMO30SCMS0vKtGdbpR0bac299
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="366907348"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366907348"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 05:53:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834260119"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834260119"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2023 05:53:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 05:53:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 05:53:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 05:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUKEj41Suyr88kIWaezmGkKvMIG5yxG3frQtr+dNC6x1+44Wy1ZMz//BGJXJn0bjJixsrRFlFSgFRd/BRoaFECrGZDwW4MwnaqojozzFXs0+iF78aOjT57YJDbySe/47jmk/VEiZJJ6Y2bty+we2VZhHVf8fFllSkmPEcNr//eEIdnXbAjMFudXDvJ1+DGOMOdwXi80AowYvcSuzv9UWct5lIDYokckyQ3ZeFtbl8zcS0NIHPitc84n4f8bFPY1jpoQ1kqaLfrNo2nHn2OvAF0uVvNFW5X7AeSe1Yupdzyo6Yu7khRMMhPJ0YCsWRulc59gv8b3dK1j2EG49DeacKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olVRqiLZvBl08odmZMqm8uO575lwtRWt5OKPd4210Ag=;
 b=V0B8aPcUoUvfFypG2MRKeHdzyaiQunoL7+b3olSTrRXpNJbJhxppPREr9obmlQo1y5lT1gawkDcnDyPWA3jzcb8Cx03jf0aMV2vyJcOdSHA2+RNqpDgVoAS5ExGVo4btCxc/ry9hEchQqcbRLsn8NNjN9mHU9FzFXVlgl4ry0xbbdGi+N00l4hVLj//udqX/PbyAQKDcRufg8unj4vqjWqR7LeiI+RXFzh035QgGJ9H9rRQg/p1Kvwca3R8cSyzMo3tesZdaVdZzs3+g57Slj375U4s/IUicBfjagyleBVrxKcNlDMOMgR0aRqqoXXAAS51+oMk67+OdisjNF804iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2731.namprd11.prod.outlook.com (2603:10b6:5:c3::25) by
 PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 12:53:41 +0000
Received: from DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::43c6:1db:cf90:a994]) by DM6PR11MB2731.namprd11.prod.outlook.com
 ([fe80::43c6:1db:cf90:a994%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 12:53:41 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mschmidt
	<mschmidt@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-net v3] ice: Fix memory management in
 ice_ethtool_fdir.c
Thread-Topic: [PATCH iwl-net v3] ice: Fix memory management in
 ice_ethtool_fdir.c
Thread-Index: AQHZr+vhEndH1gdKJ0+JkM5AXYf9cq+ujWoAgARtl5A=
Date: Mon, 10 Jul 2023 12:53:41 +0000
Message-ID: <DM6PR11MB273133BC65028765D6739FB8F030A@DM6PR11MB2731.namprd11.prod.outlook.com>
References: <20230706091910.124498-1-jedrzej.jagielski@intel.com>
 <4359387f-297a-7057-d7ed-770dc021086f@intel.com>
In-Reply-To: <4359387f-297a-7057-d7ed-770dc021086f@intel.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2731:EE_|PH7PR11MB8570:EE_
x-ms-office365-filtering-correlation-id: aa5f4b62-c1a9-405c-eb0e-08db8144afdf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sR1vZ4WAWsNMCQ5p88vtfNfQYXRHxRqCF4OTg3qy9XAYRJEJbvq4F61AWGGU1bNqKspRSL06mmjwb6+DQSqq6TChBZI8p+EQtbuUmR3f9FVdHIkZwdtiGso3abVJKf/0zviXsMWqz8MWogcGlnlYNpoKCkzk59jbIGmXLRvdbE/QC0IBYprs1CCGl0Ar+1jEoAWS8r1D8K1bCRXJXZLEZFwUUB1m7CWdz0K7tGZ7ibFvAbj8Xpzio3p9LOiVL4w35fnD5cOhqsoR/If1/0fHscjG+0mAU4LsbekISjzWrYVrzttiivN874cxWsX34SJ+B6E/qS4GTC5FrYbUqwE/Zfgnr5vxkeZwn4WPvC8wjJtFzOTe5M5FIk+zfb0OvdIj+1JUy/d5wHd0KNRd46FaR9fFiaznTOvfyfihZcUCbeVDFQo38ecizioyqXpo2IN85D8zbICkK1KumYq4qrEKJzdX86SScrHiy0tayOspg5EmAJhrCp1nHLue8cocAuofWwWEcYKcris1SSpbGHPQDWNIHErcQM8sxGebbPyKO81GYzTOeAA1z4mJub3DWettXEqeNbLfOzM+x52SRoMI6Ll6nm1DUWmaHJ0TbphcaJc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2731.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(9686003)(26005)(6506007)(966005)(107886003)(83380400001)(41300700001)(4326008)(64756008)(66446008)(66476007)(2906002)(66556008)(52536014)(316002)(5660300002)(8936002)(8676002)(478600001)(66946007)(7696005)(76116006)(71200400001)(110136005)(54906003)(55016003)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1huR3ZkWnU4cGVSaTBvblBId25FTTVIdmZBWEQvSmxPVXhyV09vakloSG9k?=
 =?utf-8?B?RS9TZUhBMFd4M3FueGZ0d3BmV0QwdXBpRCtFdWxpRUFvb3J5NkhseEoxMzlH?=
 =?utf-8?B?Q0ZwTXYwQys1R3NvRC8vTnhVbWxoNFNuVlpWcGJ3VWNmTnhxNDJjWitQOS8r?=
 =?utf-8?B?NXc1d2ZwTUZyYk9SdkEvdEJ2QnNGa1VtWTFjc3BFTWQzUHU2c0xZVmtCOG51?=
 =?utf-8?B?cEt2QllSbmN2K0ZyWG1LV2U2VHhvcWZ2T0hkMXVsVERCMnBEU1pvd1N0c2Js?=
 =?utf-8?B?Y3hHRUc1MlpKanhIOGtZaUdUeElDajAxcWI3WTlBN3lIMVA3dmUxOXRxajRj?=
 =?utf-8?B?ZHVYUEZtZ0kyRjJ0WEx0ZUdIRUJXZzRBRnEzUTN3dEE4RjZjZXhWNk43cXZZ?=
 =?utf-8?B?NGhhbkpxQzdIQmJQTHNqRzB4Q01uTXEyS2QvMDZadmNPOFhoQjNIeFBXQmpn?=
 =?utf-8?B?ckZHbWVDcnp5WXQyYjc1Y2dOdFZsTDYvYXBkWjljcStSYkxVQVJRRmY4amJJ?=
 =?utf-8?B?RGVpN1hYTVE2TjI2QW10djV0L1JFT0hiekh1MXRCZTV6MmczTDFoUVpkV2Qy?=
 =?utf-8?B?U2tHOTl0QzAxaHU4Smh3ZVB2Zk51NEJkclZSTUw5dEJBN3dyWUdqNEs0VGc4?=
 =?utf-8?B?dTc2dDRpSTQxems2Qkp5TW0rYzZESlhuSGo3elVBRFFxSW9FckJudEVvdU5h?=
 =?utf-8?B?ZG44cWU0eE1ENkU5RE9aZy9HbDdmaXN5R0JIb3dmRVYvTmtVYnoybUJtRmZC?=
 =?utf-8?B?Rll0bzhBVkI3SVFER3Z4VE1nTjdmQnhKdEpxQzZYSUU1cWg5Nm9WWkFQK0px?=
 =?utf-8?B?VittcGRwcitMbGxwWnJYUU9Tcmw3WlMxRlQ1eUtXaGhxOWpFdDZ0VEpRMXI1?=
 =?utf-8?B?amRDeG5YUHliNENMNzNYaVYvYkRBdWR0a3FrSlJ0ZmRlWkl1UmhadnlodlB0?=
 =?utf-8?B?cGJydEtBdTZIQ09WcmU3VHhkK0lWUVcwVWhnbkpuRERCM2xUOVlJWUk2cVRV?=
 =?utf-8?B?NHV4R0pDNG1uM3dxRFRiU2R6emhjV1crdGhMeW1IR1lZOTlRdW03YWc2S1Yr?=
 =?utf-8?B?MTk2bEs5KzgrSVlUclJ5bzRHVnFzamxzVDJBR0lOR1ZvUUtpOThZRUc4WDVX?=
 =?utf-8?B?WTN0T2dtUG5YUEZGVm45TlNITnNmZmQyNVVHbUFJT1FPY0VRSk81cElYVUFV?=
 =?utf-8?B?T3IyWlVsbTlTUTZKWi8zbHRLZHZIY2dxZ3d5Uml1SWVxd1pSY3F1bWRqa3A1?=
 =?utf-8?B?SjJSZnB4V3RTRHRTODVwVTRGYlZvYm9Eb3RHeW40bENhV3gwTlNUOW1EcjJl?=
 =?utf-8?B?RkZ3OHJYaituWTJlQlVMSlA4TVp6TS9qZGEyTGQ0R0ZWaDh4Y3JjVW16RVUx?=
 =?utf-8?B?aWtTWEdLT01TZ1NOZERWMDJhSm5oMFhZVnRCcGMwZFo0SmFmZFBiYm1LTWpp?=
 =?utf-8?B?bEhkaUtITGZWazB6Z2I3MThYT1NqblE2UnF3blRuRlVaS05LT3JRZ3VmcTFJ?=
 =?utf-8?B?WHJqRWxMV1hvZEZOdG9TRmIzQVJpMGx0NDF2THJnS3lEODB1L2k4dXNhVmp1?=
 =?utf-8?B?c2lMTDdGaDdMOUg3U3hZOEUzV2FjMHNjRnJRN212MkF0bmEraXhPd2k4aCtM?=
 =?utf-8?B?OUoxUTAyT0Y4WHU2TUc0eElKNXdxM0k3RlEzNkREM2VvVm9sZWFUSnM5aXJD?=
 =?utf-8?B?enpiN1ZJWkRqeFhjMGN0V0xmbGp0ekhLdDF4S2E4clJreERid3ZUQ0dlWkJD?=
 =?utf-8?B?SGswdnU4aEhPdU1wNGN2TDIzWU9nbzhyRVVyQVRJM2hOVWhaK2NMOUJIeFRm?=
 =?utf-8?B?NWg3aHZhRVhVeDBUeUttNW4vRVFiWjJJaGg2VDJWQmU4NzJLVHI1YU1HSHR5?=
 =?utf-8?B?MXdkVG9CMnI3SGtTNFdBb3FLaFdFY090dGVDcVdzM29vUnZtU3BwTnFWdVNv?=
 =?utf-8?B?Mmx1Sk5STVBGUjhZTDBDbnY4SWdzSlIranhKejVSYjQ3ZEVvTVJ2dDBYMjFJ?=
 =?utf-8?B?OGNWb0djZEVxU25ZTWZ6dEdwU1MyMXlPZkN0bU14Q1JUMkJxZWRpbFBZTTZB?=
 =?utf-8?B?WHhMTG85TkFWS0txdysvcWVCRmpEY0N1MllkZHpEUjlSSWROeE9FdzJlYmVl?=
 =?utf-8?Q?slLnjmQhMslnOdmARVkQPRCo4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2731.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5f4b62-c1a9-405c-eb0e-08db8144afdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 12:53:41.0970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsmTgEEcwzCeEkBzDKnaycSmqDRb8MqDy8nhRLw8tsSx7biadzkx/8om6Z9RFlytNYRZPp7H2iwfe6Bu/mxCgqNH53PhLt0Ob7zC0aUrkIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPiANClNl
bnQ6IEZyaSwgNyBKdWx5IDIwMjMgMTk6MTYNCj5PbiA3LzYvMjAyMyAyOjE5IEFNLCBKZWRyemVq
IEphZ2llbHNraSB3cm90ZToNCj4+IEZpeCBldGh0b29sIEZESVIgbG9naWMgdG8gbm90IHVzZSBt
ZW1vcnkgYWZ0ZXIgaXRzIHJlbGVhc2UuDQo+PiBJbiB0aGUgaWNlX2V0aHRvb2xfZmRpci5jIGZp
bGUgdGhlcmUgYXJlIDIgc3BvdHMgd2hlcmUgY29kZSBjYW4gcmVmZXIgDQo+PiB0byBwb2ludGVy
cyB3aGljaCBtYXkgYmUgbWlzc2luZy4NCj4+IA0KPj4gSW4gdGhlIGljZV9jZmdfZmRpcl94dHJj
dF9zZXEoKSBmdW5jdGlvbiBzZWcgbWF5IGJlIGZyZWVkIGJ1dCBldmVuIA0KPj4gdGhlbiBtYXkg
YmUgc3RpbGwgdXNlZCBieSBtZW1jcHkoJnR1bl9zZWdbMV0sIHNlZywgc2l6ZW9mKCpzZWcpKS4N
Cj4+IA0KPj4gSW4gdGhlIGljZV9hZGRfZmRpcl9ldGh0b29sKCkgZnVuY3Rpb24gc3RydWN0IGlj
ZV9mZGlyX2ZsdHIgKmlucHV0IG1heSANCj4+IGZpcnN0IGZhaWwgdG8gYmUgYWRkZWQgdmlhIGlj
ZV9mZGlyX3VwZGF0ZV9saXN0X2VudHJ5KCkgYnV0IHRoZW4gbWF5IA0KPj4gYmUgZGVsZXRlZCBi
eSBpY2VfZmRpcl91cGRhdGVfbGlzdF9lbnRyeS4NCj4+IA0KPj4gVGVybWluYXRlIGluIGJvdGgg
Y2FzZXMgd2hlbiB0aGUgcmV0dXJuZWQgdmFsdWUgb2YgdGhlIHByZXZpb3VzIA0KPj4gb3BlcmF0
aW9uIGlzIG90aGVyIHRoYW4gMCwgZnJlZSBtZW1vcnkgYW5kIGRvbid0IHVzZSBpdCBhbnltb3Jl
Lg0KPj4gDQo+PiBSZXBsYWNlIG1hbmFnZWQgbWVtb3J5IGFsbG9jIHdpdGgga3phbGxvYy9rZnJl
ZSBpbg0KPj4gaWNlX2NmZ19mZGlyX3h0cmN0X3NlcSgpIHNpbmNlIHNlZy90dW5fc2VnIGFyZSB1
c2VkIG9ubHkgYnkgDQo+PiBpY2VfZmRpcl9zZXRfaHdfZmx0cl9ydWxlKCkuDQo+PiANCj4+IFJl
cG9ydGVkLWJ5OiBNaWNoYWwgU2NobWlkdCA8bXNjaG1pZHRAcmVkaGF0LmNvbT4NCj4+IExpbms6
IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjIwODQyMw0KPj4g
Rml4ZXM6IGNhYzJhMjdjZDlhYiAoImljZTogU3VwcG9ydCBJUHY0IEZsb3cgRGlyZWN0b3IgZmls
dGVycyIpDQo+PiBSZXZpZXdlZC1ieTogUHJ6ZW1layBLaXRzemVsIDxwcnplbXlzbGF3LmtpdHN6
ZWxAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSmVkcnplaiBKYWdpZWxza2kgPGplZHJ6
ZWouamFnaWVsc2tpQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjI6IGV4dGVuZCBDQyBsaXN0LCBm
aXggZnJlZWluZyBtZW1vcnkgYmVmb3JlIHJldHVybg0KPj4gdjM6IGNvcnJlY3QgdHlwb3MgaW4g
dGhlIGNvbW1pdCBtc2cNCj4+IC0tLQ0KPj4gICAuLi4vbmV0L2V0aGVybmV0L2ludGVsL2ljZS9p
Y2VfZXRodG9vbF9mZGlyLmMgfCA2MiArKysrKysrKystLS0tLS0tLS0tDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbF9mZGlyLmMg
DQo+PiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbF9mZGlyLmMN
Cj4+IGluZGV4IGVhZDZkNTBmYzBhZC4uNjE5YjMyZjRiYzUzIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sX2ZkaXIuYw0KPj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sX2ZkaXIuYw0KPj4gQEAg
LTEyMDQsMjEgKzEyMDQsMTYgQEAgaWNlX2NmZ19mZGlyX3h0cmN0X3NlcShzdHJ1Y3QgaWNlX3Bm
ICpwZiwgc3RydWN0IGV0aHRvb2xfcnhfZmxvd19zcGVjICpmc3AsDQo+PiAgIAkJICAgICAgIHN0
cnVjdCBpY2VfcnhfZmxvd191c2VyZGVmICp1c2VyKQ0KPj4gICB7DQo+PiAgIAlzdHJ1Y3QgaWNl
X2Zsb3dfc2VnX2luZm8gKnNlZywgKnR1bl9zZWc7DQo+PiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9
IGljZV9wZl90b19kZXYocGYpOw0KPj4gICAJZW51bSBpY2VfZmx0cl9wdHlwZSBmbHRyX2lkeDsN
Cj4+ICAgCXN0cnVjdCBpY2VfaHcgKmh3ID0gJnBmLT5odzsNCj4+ICAgCWJvb2wgcGVyZmVjdF9m
aWx0ZXI7DQo+PiAgIAlpbnQgcmV0Ow0KPj4gICANCj4+IC0Jc2VnID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpzZWcpLCBHRlBfS0VSTkVMKTsNCj4+IC0JaWYgKCFzZWcpDQo+PiAtCQlyZXR1
cm4gLUVOT01FTTsNCj4+IC0NCj4+IC0JdHVuX3NlZyA9IGRldm1fa2NhbGxvYyhkZXYsIElDRV9G
RF9IV19TRUdfTUFYLCBzaXplb2YoKnR1bl9zZWcpLA0KPj4gLQkJCSAgICAgICBHRlBfS0VSTkVM
KTsNCj4+IC0JaWYgKCF0dW5fc2VnKSB7DQo+PiAtCQlkZXZtX2tmcmVlKGRldiwgc2VnKTsNCj4+
IC0JCXJldHVybiAtRU5PTUVNOw0KPj4gKwlzZWcgPSBremFsbG9jKHNpemVvZigqc2VnKSwgR0ZQ
X0tFUk5FTCk7DQo+PiArCXR1bl9zZWcgPSBrY2FsbG9jKElDRV9GRF9IV19TRUdfTUFYLCBzaXpl
b2YoKnR1bl9zZWcpLCBHRlBfS0VSTkVMKTsNCj4+ICsJaWYgKCF0dW5fc2VnIHx8ICFzZWcpIHsN
Cj4+ICsJCXJldCA9IC1FTk9NRU07DQo+PiArCQlnb3RvIGV4aXQ7DQo+DQo+SUlSQyBpbmRpdmlk
dWFsIGNoZWNrcyBhbmQgZ290bydzIGFyZSBwcmVmZXJyZWQgb3ZlciBjb21iaW5pbmcgdGhlbS4N
Cg0KRm9yIGJvdGggY2FzZXMgdGhlcmUgaXMgdGhlIHNhbWUgYmVoYXZpb3Igc28gaXQgd2FzIGRv
bmUgZHVlIHRvIGxpbWl0DQp0aGUgbGluZSByZWR1bmRhbmN5LCBidXQgaWYgeW91IHRoaW5rIGl0
IGlzIGJldHRlciB0byBzcGxpdCB0aGVtIHVwIGkgDQpjYW4gZG8gdGhpcw0KDQo+DQo+PiAgIAl9
DQo+PiAgIA0KPj4gICAJc3dpdGNoIChmc3AtPmZsb3dfdHlwZSAmIH5GTE9XX0VYVCkgeyBAQCAt
MTI2NCw3ICsxMjU5LDcgQEAgDQo+PiBpY2VfY2ZnX2ZkaXJfeHRyY3Rfc2VxKHN0cnVjdCBpY2Vf
cGYgKnBmLCBzdHJ1Y3QgZXRodG9vbF9yeF9mbG93X3NwZWMgKmZzcCwNCj4+ICAgCQlyZXQgPSAt
RUlOVkFMOw0KPj4gICAJfQ0KPj4gICAJaWYgKHJldCkNCj4+IC0JCWdvdG8gZXJyX2V4aXQ7DQo+
PiArCQlnb3RvIGV4aXQ7DQo+PiAgIA0KPj4gICAJLyogdHVubmVsIHNlZ21lbnRzIGFyZSBzaGlm
dGVkIHVwIG9uZS4gKi8NCj4+ICAgCW1lbWNweSgmdHVuX3NlZ1sxXSwgc2VnLCBzaXplb2YoKnNl
ZykpOyBAQCAtMTI4MSw0MiArMTI3NiwzOSBAQCANCj4+IGljZV9jZmdfZmRpcl94dHJjdF9zZXEo
c3RydWN0IGljZV9wZiAqcGYsIHN0cnVjdCBldGh0b29sX3J4X2Zsb3dfc3BlYyAqZnNwLA0KPj4g
ICAJCQkJICAgICBJQ0VfRkxPV19GTERfT0ZGX0lOVkFMKTsNCj4+ICAgCX0NCj4+ICAgDQo+PiAt
CS8qIGFkZCBmaWx0ZXIgZm9yIG91dGVyIGhlYWRlcnMgKi8NCj4+ICAgCWZsdHJfaWR4ID0gaWNl
X2V0aHRvb2xfZmxvd190b19mbHRyKGZzcC0+Zmxvd190eXBlICYgfkZMT1dfRVhUKTsNCj4+ICsN
Cj4+ICsJaWYgKHBlcmZlY3RfZmlsdGVyKQ0KPj4gKwkJc2V0X2JpdChmbHRyX2lkeCwgaHctPmZk
aXJfcGVyZmVjdF9mbHRyKTsNCj4+ICsJZWxzZQ0KPj4gKwkJY2xlYXJfYml0KGZsdHJfaWR4LCBo
dy0+ZmRpcl9wZXJmZWN0X2ZsdHIpOw0KPj4gKw0KPj4gKwkvKiBhZGQgZmlsdGVyIGZvciBvdXRl
ciBoZWFkZXJzICovDQo+PiAgIAlyZXQgPSBpY2VfZmRpcl9zZXRfaHdfZmx0cl9ydWxlKHBmLCBz
ZWcsIGZsdHJfaWR4LA0KPj4gICAJCQkJCUlDRV9GRF9IV19TRUdfTk9OX1RVTik7DQo+PiAtCWlm
IChyZXQgPT0gLUVFWElTVCkNCj4+IC0JCS8qIFJ1bGUgYWxyZWFkeSBleGlzdHMsIGZyZWUgbWVt
b3J5IGFuZCBjb250aW51ZSAqLw0KPj4gLQkJZGV2bV9rZnJlZShkZXYsIHNlZyk7DQo+PiAtCWVs
c2UgaWYgKHJldCkNCj4+ICsJaWYgKHJldCA9PSAtRUVYSVNUKSB7DQo+PiArCQkvKiBSdWxlIGFs
cmVhZHkgZXhpc3RzLCBmcmVlIG1lbW9yeSBhbmQgY291bnQgYXMgc3VjY2VzcyAqLw0KPj4gKwkJ
cmV0ID0gMDsNCj4+ICsJCWdvdG8gZXhpdDsNCj4+ICsJfSBlbHNlIGlmIChyZXQpIHsNCj4+ICAg
CQkvKiBjb3VsZCBub3Qgd3JpdGUgZmlsdGVyLCBmcmVlIG1lbW9yeSAqLw0KPj4gLQkJZ290byBl
cnJfZXhpdDsNCj4+ICsJCXJldCA9IC1FT1BOT1RTVVBQOw0KPj4gKwkJZ290byBleGl0Ow0KPj4g
Kwl9DQo+PiAgIA0KPj4gICAJLyogbWFrZSB0dW5uZWxlZCBmaWx0ZXIgSFcgZW50cmllcyBpZiBw
b3NzaWJsZSAqLw0KPj4gICAJbWVtY3B5KCZ0dW5fc2VnWzFdLCBzZWcsIHNpemVvZigqc2VnKSk7
DQo+PiAgIAlyZXQgPSBpY2VfZmRpcl9zZXRfaHdfZmx0cl9ydWxlKHBmLCB0dW5fc2VnLCBmbHRy
X2lkeCwNCj4+ICAgCQkJCQlJQ0VfRkRfSFdfU0VHX1RVTik7DQo+PiAtCWlmIChyZXQgPT0gLUVF
WElTVCkgew0KPj4gKwlpZiAocmV0ID09IC1FRVhJU1QpDQo+PiAgIAkJLyogUnVsZSBhbHJlYWR5
IGV4aXN0cywgZnJlZSBtZW1vcnkgYW5kIGNvdW50IGFzIHN1Y2Nlc3MgKi8NCj4+IC0JCWRldm1f
a2ZyZWUoZGV2LCB0dW5fc2VnKTsNCj4+ICAgCQlyZXQgPSAwOw0KPj4gLQl9IGVsc2UgaWYgKHJl
dCkgew0KPj4gLQkJLyogY291bGQgbm90IHdyaXRlIHR1bm5lbCBmaWx0ZXIsIGJ1dCBvdXRlciBm
aWx0ZXIgZXhpc3RzICovDQo+PiAtCQlkZXZtX2tmcmVlKGRldiwgdHVuX3NlZyk7DQo+PiAtCX0N
Cj4+ICAgDQo+PiAtCWlmIChwZXJmZWN0X2ZpbHRlcikNCj4+IC0JCXNldF9iaXQoZmx0cl9pZHgs
IGh3LT5mZGlyX3BlcmZlY3RfZmx0cik7DQo+PiAtCWVsc2UNCj4+IC0JCWNsZWFyX2JpdChmbHRy
X2lkeCwgaHctPmZkaXJfcGVyZmVjdF9mbHRyKTsNCj4+ICtleGl0Og0KPj4gKwlrZnJlZSh0dW5f
c2VnKTsNCj4+ICsJa2ZyZWUoc2VnKTsNCj4NCj5QcmV2aW91c2x5LCBzdWNjZXNzIHdvdWxkIG5v
dCBmcmVlIHRoZXNlLiBUaGV5IGxvb2sgdG8gYmUgc2V0IGludG8gaHdfcHJvZiB2aWENCmljZV9m
ZGlyX3NldF9od19mbHRyX3J1bGUoKS4gSXMgaXQgc2FmZSB0byBiZSBmcmVlaW5nIHRoZW0gbm93
Pw0KDQpZZWFoLCBJIHdpbGwgcmVzdG9yZSB0aGUgcHJldmlvdXMgYXBwcm9hY2ggdG8gYXZvaWQg
Y29uZnVzaW9uDQoNCj4NCj4+ICAgCXJldHVybiByZXQ7DQo+PiAtDQo+PiAtZXJyX2V4aXQ6DQo+
PiAtCWRldm1fa2ZyZWUoZGV2LCB0dW5fc2VnKTsNCj4+IC0JZGV2bV9rZnJlZShkZXYsIHNlZyk7
DQo+PiAtDQo+PiAtCXJldHVybiAtRU9QTk9UU1VQUDsNCj4+ICAgfQ0KPj4gICANCj4+ICAgLyoq
DQo+PiBAQCAtMTkxNCw3ICsxOTA2LDkgQEAgaW50IGljZV9hZGRfZmRpcl9ldGh0b29sKHN0cnVj
dCBpY2VfdnNpICp2c2ksIHN0cnVjdCBldGh0b29sX3J4bmZjICpjbWQpDQo+PiAgIAlpbnB1dC0+
Y29tcF9yZXBvcnQgPSBJQ0VfRlhEX0ZMVFJfUVcwX0NPTVBfUkVQT1JUX1NXX0ZBSUw7DQo+PiAg
IA0KPj4gICAJLyogaW5wdXQgc3RydWN0IGlzIGFkZGVkIHRvIHRoZSBIVyBmaWx0ZXIgbGlzdCAq
Lw0KPj4gLQlpY2VfZmRpcl91cGRhdGVfbGlzdF9lbnRyeShwZiwgaW5wdXQsIGZzcC0+bG9jYXRp
b24pOw0KPj4gKwlyZXQgPSBpY2VfZmRpcl91cGRhdGVfbGlzdF9lbnRyeShwZiwgaW5wdXQsIGZz
cC0+bG9jYXRpb24pOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byByZWxlYXNlX2xvY2s7DQo+
PiAgIA0KPj4gICAJcmV0ID0gaWNlX2ZkaXJfd3JpdGVfYWxsX2ZsdHIocGYsIGlucHV0LCB0cnVl
KTsNCj4+ICAgCWlmIChyZXQpDQo=

