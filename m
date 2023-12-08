Return-Path: <netdev+bounces-55472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B780AF9D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390A21C20B01
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF059B67;
	Fri,  8 Dec 2023 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cceP6iAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD310E0
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702074250; x=1733610250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tVDwgFAWOIpFyH3AMgxt+kKN5Vibby4NmstqYkxvOWc=;
  b=cceP6iAZKxWn2K1E81tyHLlVwhRxbdBiAhXov7vWVvAEZDuT91NkJQz9
   wzdLD4BSuHOSEtD/p1dA/MQy4NctZhh4p+gSCUYu/u5ivnCPjTPiaK+40
   XPwyalFbwaWTUq8A9RZJCIGhJ/ztheI7gWIBI+a8sW8tPNO8OMjXuqni+
   JqVvMRPwjJnRQI20dPlztIlqrQei0Bvg8Wv422Dn56d4j+mD2t5l2KTJg
   1heBhBK7rjOO7zhNRIR02l3Vlr+2UDl1OdBrRgTl0SOwtl6tvL6Iyu4HL
   ctuOSWmBwmczksUCisS5eHUYS3j2Gp2UCaK/y8S69WfgndtHJWy13Oclq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397263186"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="397263186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 14:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838273026"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="838273026"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 14:24:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 14:24:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 14:24:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 14:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rxfec1NdHu8j8PINxyBi5c/U95O10QfmBzH9GDxcOv5i3jhJnSdsA06C7+oYjpI8LdLs1cA/HKCf298sqmaUSf3/k5xlD0jb3QwySZ0+OSE8D/r9MWOjiGZoVNsRjeUhCHL0Cb22OCSs7Gv/CY9ioI3dNDpWsumjVNrz7GlmXWzVcrm60NAgPAHS6DfbNFCQag3KVSEk8M7QiAxg6+BlOtFDv+8NZw1CqLJPCHGNydEfGle81wwqT6VHGaqlXByP05zjUG9Q3Dd9DcIrfVsciRW/FF875bp3NZvnPuZ6q+1rfv5Bq9asyKyPkc3WKhQIPV88nXdlpkTEUpsLH+mQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVDwgFAWOIpFyH3AMgxt+kKN5Vibby4NmstqYkxvOWc=;
 b=gNlJnH6wlAP/dlYdu6/ScClhpoZL7LhKJv/ftXLFI2Li3O4mOGJJVcxMJX0JGGAQxDlvD4rDF171JzQekoU3Su1ptyq4FueNFD/tPQ3tNyFPYEjIfCQrv8FM00wA1pUN2YjMKeMjE1NDqwWpt7wwa8+WcMYvq3ipDeG5V7TNtAA4fHdkAUWa2e8rKxHBm9D1LKePSkZyxD9mp9wyFnYggQU9emo6USFqHn7BE1ZxZN2U953PHPimeCRaqyn+6T6vx1KCeD5cD05PRaQEOEesEU8+dWcLlzcT5Lx/qY6en2ZeRconLO4vPVbTcifZIO0n5HzZljMi7i8Wxj1+sgfbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:24:07 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:24:07 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [PATCH iwl-next] ice: alter feature support check for SRIOV and
 LAG
Thread-Topic: [PATCH iwl-next] ice: alter feature support check for SRIOV and
 LAG
Thread-Index: AQHaKToUXVlzIDYaGEyh4eN8rXhk7rCf5awAgAAR/LA=
Date: Fri, 8 Dec 2023 22:24:06 +0000
Message-ID: <MW5PR11MB581150E2535B00AD04A37913DD8AA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231207182158.2199799-1-david.m.ertman@intel.com>
 <bca6d80f-21de-f6dd-7b86-3daa867323e1@intel.com>
In-Reply-To: <bca6d80f-21de-f6dd-7b86-3daa867323e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|BN9PR11MB5548:EE_
x-ms-office365-filtering-correlation-id: f64dc960-638a-4195-09f5-08dbf83c6478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fE1tNCk5coWTu1ciyIPOvOFSEbMHhV8XdJuUPVYz3fJwc6XoHg0lj5YZ25TOyLmRFDbzlY20onsA79LR34RyOhyUr8AWJxnA0tRqYauEmAYXUoFwm3iyo8LIRIJi4BS249kzwSn4PW7j/0EoXYEU0DdGmhWc4M7wA8FT+jfuNl4xw4LeAeZtq0VuT/arnH3MmXF/FYYtcbVNPIxf8vr/VKvYZl9FsD49iM/W/4Y3+Aid7/IPwiPmH5l3oWQJCLrUWe6GG09CApklKxKJfMJVfHkzOllzFSBJjnT9UknQRU/uF3xxTx7Fy8OR3CQJj2iwOHZNSj3+UwOKhrr4ADKyNsQCxx8F2ZSp+4YNBzG5JXuhC09v9JGIuJWaYvsuzQJ0GAbZtxAb5fZa2QQuZdJbE0ECTC4wxsjck1k2o3u6yVHFYKbGSxxpyph96PE8rnaZ+U8qFjrxvhiCXV1xRkRer7Lz9PyJW6zDmdRIVfLXSSpUEkqVpb8o3Hi2bMlOi2nIud4RDxYIkIpzUQ/mACvB1Dw2BypAowYCNza5lBzMOWcekcO8XfH10naOA7tvZH8jDJ+O37BSlvzj14zx2GvbKZaERzrdDHwdcxWcPMc26tTUuwAIYyxzgcEu9pNbou6M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(53546011)(478600001)(9686003)(38070700009)(107886003)(38100700002)(7696005)(26005)(5660300002)(52536014)(122000001)(86362001)(316002)(66476007)(54906003)(66946007)(64756008)(76116006)(66446008)(110136005)(66556008)(71200400001)(4326008)(8676002)(55016003)(8936002)(33656002)(2906002)(83380400001)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVcwNXNMYXdkQ2Z0QnZEWVlIVG82MTVKbGcyZEZLUm0zZ0hLeGlKeEsrRzZN?=
 =?utf-8?B?a0NXR2tVMFlKQzR1Tm8rSjJrRkNvc29YaGYvdUgyT1czemhTVXRGd1orZFBT?=
 =?utf-8?B?djA3TDBjYmpEalQrT0FQSTc5OHN3Y3FBZUo0QVkyS2NQdVlFODkvejBLZVg0?=
 =?utf-8?B?ZUZGOFFjWEJ0bG5xd1lXNVhnVi9pb042L3FBb3htTjd4TVRCRG5XelNJSUp2?=
 =?utf-8?B?Yyt2c3ZteERTT3IweWVoaDlVeGpuamdnY3NzeFpKYVQ3KzZySW5UU0NxYTZM?=
 =?utf-8?B?VnErUHBYL2JOT1JTUzBOWGQ1c2JmdDBhUHA2Wmxmc1NCOG1nanN4VWlSMk9R?=
 =?utf-8?B?eUQ1Z1U3eDN4MFNXMEFyMUp3TVQ2Vm9hbXkxRHAxTWhWNDQvYnY2SXFIa1Zp?=
 =?utf-8?B?RFduVnBtc3Z6TDIzUHkwdG52NUVsU01pYytRKzQwZURUMkIyQVAwMjB6OFFT?=
 =?utf-8?B?MmZSV2NPRUlmSXBUeTlINTl1MDVlOVR5S1BKbVZZeURDdHRIWkduekJVL3N6?=
 =?utf-8?B?QTFvZEQ3RHZla2FNM1JxdVVSd21FY2djUktvSnVjc2RZZWdBUHRWS0gwTzNy?=
 =?utf-8?B?RDM4VUY0Z1VNK1Z4QUg2dDRCSXZSUXNDaThMdFJFMjFQZ2VpRW90bi9zcHE5?=
 =?utf-8?B?Mmc1Q2ZoVlNFYTUvTi8yOUhSVEZ2bzU0T3pPSHVPckJOSEtCV2JRazRSYjlQ?=
 =?utf-8?B?YjNpY2xOLzR4NEF2ZEVJVGIvL3VOOFdmNXUvY1Q4VW0wTVYvWmpqbGpOY2py?=
 =?utf-8?B?dlFsWjlKT3VzWFhlVlpLNVZtNFhQd3Nyaks3RE9JclNTOXNhaFhiTnk1YTZE?=
 =?utf-8?B?dFIxT3ZKL1Y0NzNBQmZSblczTEUrcUFVT0hlUTh1ekw1R3pMdjZEcHVPaHlz?=
 =?utf-8?B?dkhBdHlCKzdrM0Q3Q1pqR1ovemd2UXZHMjNDRlAza0dRRkNodTBHa2FOTm5M?=
 =?utf-8?B?YUpqWGRvL081ZWNJNEpmWlpXOXJoSWlQczFtQjIzMTl2S01HZ3IyaWlmZ2gw?=
 =?utf-8?B?MjRkMkFWYkJGanF3bGdyNUowTHQvQzBta3dmMDBsMGdHbGhhQTZrM1NWYnA2?=
 =?utf-8?B?MUt5dzMySS83MUtXbnZUWEZVM3RhbndRd2V3WDdaazREaGltMHdjWjk2dmUw?=
 =?utf-8?B?MFJuMUQ2cWFMN0NMTWdnbkVCUHB3WXRMcktkaXFBeDYvQW1ITk04VXVzOWhN?=
 =?utf-8?B?RnFXL3BKK3ErMEpTUVlZMnpzcms2N3MvNmdncGpHeUxPeWlaQlM1UDR2UExM?=
 =?utf-8?B?cVV6TFZHUE1kN0pidFJEU0dla1B5eGdlYmpRRlBSUitud0JhQnlkaFM2MmFU?=
 =?utf-8?B?TmpjV3VGbkZHYWRwaktNdFhoSUZCclhtalBIUkM4d0NtSEdIUThZV1dKK04w?=
 =?utf-8?B?NU5nYzc2VmRuN0FoQ09ZdzNqS2duZlBBZ2J5MVpXd3hDT3Bqb2RDVEVnZ1Fu?=
 =?utf-8?B?WGxZNlliWEhaTnoxclZIRmIyOXhYRjJidTlrR0ZWN2k0VmcxYyt5TkdLZWp2?=
 =?utf-8?B?OW1MRlNpbENaN1ZNU1BDUjVzUUdXVmo4S0FGcCtYU0lZWmpjMDBvSVNLci83?=
 =?utf-8?B?U3RJSGZ6bkM1YWtuai9IZlc5S0xJdytGT3lVSlFKMzZSMFNEZEkzZlhYMmdz?=
 =?utf-8?B?K2xULzE4MCs3a3JPRCtJU1VPaTRwNStHenlhdlZSb0RBK1lVRTdNWjZxcFJi?=
 =?utf-8?B?WFdjWjFPZktET1hiS2Q4TndyMU5TaXhFaEhKUU9IT3UrR0pSemQxOFZKLzJI?=
 =?utf-8?B?MFgwSThwL2hBamxEK1NyU0hXWUNPdGtNSGxxQms2UzMwNVIvUys4NExVWnBN?=
 =?utf-8?B?QkVWQ1RsNm5CMGJzNTlsUllML01pYU1MZ2NtaFpmdVdEajFuaklHM0p3NS9D?=
 =?utf-8?B?dUxIUEZQZktJSjU1V0lDU1Z6WnpoWVBQRU9aQ1l5WUYxVXZONVptcmxIczF3?=
 =?utf-8?B?bzlQdXc3amFWMVBEL3FwQ2xzcDkxNmxuY2dNUENRODNMSnp4UXpFbDQxaEFi?=
 =?utf-8?B?Zm9Wb1MxZFZnZEVISWx2N3JZSFZDT2d0MjFtVFJNc3FXUlFMSC9LUC9vTTlX?=
 =?utf-8?B?aE9OS0lGRjRPYUNobTlXbTMvekdBQkRRUFRTTFZpeDdRazEyaUh6MjIzTDND?=
 =?utf-8?Q?pZYxkvvkAjlgYjTFneGKpJfsE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5811.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64dc960-638a-4195-09f5-08dbf83c6478
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 22:24:07.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0InVXSBlN/TWZC2SLalLqBwxFs1xOlpDG3WttaLVWCn10iFPouYS9FOX1iJui1SRw54BEAv2Hx2X7jJklHtAFaVlHTA6MZUZQmGdYLzjEEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgOCwg
MjAyMyAxOjE4IFBNDQo+IFRvOiBFcnRtYW4sIERhdmlkIE0gPGRhdmlkLm0uZXJ0bWFuQGludGVs
LmNvbT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgQnJhbmRlYnVyZywgSmVzc2UNCj4gPGplc3NlLmJyYW5kZWJ1cmdA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIGl3bC1uZXh0XSBpY2U6IGFsdGVyIGZl
YXR1cmUgc3VwcG9ydCBjaGVjayBmb3IgU1JJT1YgYW5kDQo+IExBRw0KPiANCj4gDQo+IA0KPiBP
biAxMi83LzIwMjMgMTA6MjEgQU0sIERhdmUgRXJ0bWFuIHdyb3RlOg0KPiA+IFByZXZpb3VzbHks
IHRoZSBpY2UgZHJpdmVyIGhhZCBzdXBwb3J0IGZvciB1c2luZyBhIGhhbmxkbGVyIGZvciBib25k
aW5nDQo+ID4gbmV0ZGV2IGV2ZW50cyB0byBlbnN1cmUgdGhhdCBjb25mbGljdGluZyBmZWF0dXJl
cyB3ZXJlIG5vdCBhbGxvd2VkIHRvIGJlDQo+ID4gYWN0aXZhdGVkIGF0IHRoZSBzYW1lIHRpbWUu
ICBXaGlsZSB0aGlzIHdhcyBzdGlsbCBpbiBwbGFjZSwgYWRkaXRpb25hbA0KPiA+IHN1cHBvcnQg
d2FzIGFkZGVkIHRvIHNwZWNpZmljYWxseSBzdXBwb3J0IFNSSU9WIGFuZCBMQUcgdG9nZXRoZXIu
ICBUaGVzZQ0KPiA+IGJvdGggdXRpbGl6ZWQgdGhlIG5ldGRldiBldmVudCBoYW5kbGVyLCBidXQg
dGhlIFNSSU9WIGFuZCBMQUcgZmVhdHVyZSB3YXMNCj4gPiBiZWhpbmQgYSBjYXBhYmlsaXRpZXMg
ZmVhdHVyZSBjaGVjayB0byBtYWtlIHN1cmUgdGhlIGN1cnJlbnQgTlZNIGhhcw0KPiA+IHN1cHBv
cnQuDQo+ID4NCj4gPiBUaGUgZXhjbHVzaW9uIHBhcnQgb2YgdGhlIGV2ZW50IGhhbmRsZXIgc2hv
dWxkIGJlIHJlbW92ZWQgc2luY2UgdGhlcmUgYXJlDQo+ID4gdXNlcnMgd2hvIGhhdmUgY3VzdG9t
IG1hZGUgc29sdXRpb25zIHRoYXQgZGVwZW5kIG9uIHRoZSBub24tZXhjbHVzaW9uDQo+IG9mDQo+
ID4gZmVhdHVyZXMuDQo+ID4NCj4gPiBXcmFwIHRoZSBjcmVhdGlvbi9yZWdpc3RyYXRpb24gYW5k
IGNsZWFudXAgb2YgdGhlIGV2ZW50IGhhbmRsZXIgYW5kDQo+ID4gYXNzb2NpYXRlZCBzdHJ1Y3Rz
IGluIHRoZSBwcm9iZSBmbG93IHdpdGggYSBmZWF0dXJlIGNoZWNrIHNvIHRoYXQgdGhlDQo+ID4g
b25seSBzeXN0ZW1zIHRoYXQgc3VwcG9ydCB0aGUgZnVsbCBpbXBsZW1lbnRhdGlvbiBvZiBMQUcg
ZmVhdHVyZXMgd2lsbA0KPiA+IGluaXRpYWxpemUgc3VwcG9ydC4gIFRoaXMgd2lsbCBsZWF2ZSBv
dGhlciBzeXN0ZW1zIHVuaGluZGVyZWQgd2l0aA0KPiA+IGZ1bmN0aW9uYWxpdHkgYXMgaXQgZXhp
c3RlZCBiZWZvcmUgYW55IExBRyBjb2RlIHdhcyBhZGRlZC4NCj4gDQo+IFRoaXMgc291bmRzIGxp
a2UgYSBidWcgZml4PyBTaG91bGQgaXQgYmUgZm9yIGl3bC1uZXQ/DQo+DQoNClRvIG15IGtub3ds
ZWRnZSwgdGhpcyBpc3N1ZSBoYXMgbm90IGJlZW4gcmVwb3J0ZWQgYnkgYW55IHVzZXJzIGFuZCB3
YXMgZm91bmQNCnRocm91Z2ggY29kZSBpbnNwZWN0aW9uLiAgV291bGQgeW91IHN0aWxsIHJlY29t
bWVuZCBpd2wtbmV0Pw0KDQpEYXZlRQ0KIA0KPiA+IFJldmlld2VkLWJ5OiBKZXNzZSBCcmFuZGVi
dXJnIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZl
IEVydG1hbiA8ZGF2aWQubS5lcnRtYW5AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9sYWcuYyB8IDIgKysNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xhZy5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWNlL2ljZV9sYWcuYw0KPiA+IGluZGV4IDI4MDk5NGVlNTkzMy4uYjQ3Y2Q0M2FlODcx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGFn
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xhZy5jDQo+
ID4gQEAgLTE5ODEsNiArMTk4MSw4IEBAIGludCBpY2VfaW5pdF9sYWcoc3RydWN0IGljZV9wZiAq
cGYpDQo+ID4gICAJaW50IG4sIGVycjsNCj4gPg0KPiA+ICAgCWljZV9sYWdfaW5pdF9mZWF0dXJl
X3N1cHBvcnRfZmxhZyhwZik7DQo+ID4gKwlpZiAoIWljZV9pc19mZWF0dXJlX3N1cHBvcnRlZChw
ZiwgSUNFX0ZfU1JJT1ZfTEFHKSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPg0KPiA+ICAgCXBmLT5s
YWcgPSBremFsbG9jKHNpemVvZigqbGFnKSwgR0ZQX0tFUk5FTCk7DQo+ID4gICAJaWYgKCFwZi0+
bGFnKQ0K

