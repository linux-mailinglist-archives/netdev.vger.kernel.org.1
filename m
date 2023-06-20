Return-Path: <netdev+bounces-12311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D573712F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D05C281392
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66A17742;
	Tue, 20 Jun 2023 16:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266401773F
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:08:03 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17ED1AC
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687277281; x=1718813281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=La1SxwM6LYM73YaxHcl4QA2M5x4fOXzAeNlvPKENBMA=;
  b=nBlSYkbWQ/Ni+mDDldoqpMdN1eLKd4Hh2dBh9hAzAxQ3eI5pU4BGRQvz
   ZaU+wWdRluR8c4JSMhZZxi4ycwXS6qG18/y77obYqU1VlaqhUM9ZOFck6
   zCyrZAf/EXhtjF6NVSWqGjKKLuIG8SzHWWYakesL34CtZdJC0HXXO7tbG
   M/xPVRvVAsucgDsC4Li+PuewgconcD+PUi8/o9B0PDYFhhEr6gRXnIN/v
   EqrfVqaK1KZMl7YshB8FOCHTQZg0EZn7az7ZvzlUrXiil5MS9vHpwwXqr
   feXuuz2hOsEm5Z9DTgXBuv6VpO4hGFMYniBtmi2ccQomwsm6n23Wn6eKF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="425857825"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="425857825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804008249"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="804008249"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 09:08:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:08:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 09:08:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 09:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpzzdQ7D+q7uOfgV4RMs8Tw24xVaU56fRaOQcV1OeamR7Ub+izLEJ0b/gY6HeaZfu3RzXrLJlw86YHOs7pysFCo03bpr9WD5g/a49iHpepBq1y7axcQLdlqHlm+ZOofXnpQy6Au8LOs88dTd1NQwiPK7TGh390VHY3tG0kRTOdwowKPJ26ZtHjzRJK6BlNjh+f3mvCuUPP0nxL+dIUCFCdH7WKgXkLE6lkT+5428pm4DDqpGdMsznIMneA6DHflmdsK5VI6hiTGc7dSWbCRs9+zspC+XFr/COrA95ku8B1Qj/zzMFyyeNYuGqcRsZEHAiWYesRAm0x/fVXFVQ2G3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La1SxwM6LYM73YaxHcl4QA2M5x4fOXzAeNlvPKENBMA=;
 b=B2TkFUBIJyWHCSfawJdBt3gfb0dLRIg8RMmnYqAXC/F9fl/ewqnJ4Ammvo8ynFcmQe5fo5YQPwSTHov7UffkpX/60QcnWJyuh9NHmCwzcaoD56Ocb7BRIUI+mi1SfHafLkTgIKVCYULeGbayYzSFTE6p8jerqdZkA/ZPsoMLEP1bqmhpT/LJIv8GWSTyGhP6PXDMhCXCD+zAbVWkt9qnxF+drWq7gu2kztr9SdVg6zRDZZXNKWAnGjpvNzf9zmye5GFipnUDzYHz3dDsg1FV8rhzCLwyMBpXT1QPv64RKLuEnDV7jXVIycar+YEsmnqC2ocYSZ0s6o0LdqzjDpX2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by IA1PR11MB7344.namprd11.prod.outlook.com (2603:10b6:208:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 16:07:56 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 16:07:55 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 06/10] ice: Flesh out
 implementation of support for SRIOV on bonded interface
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 06/10] ice: Flesh out
 implementation of support for SRIOV on bonded interface
Thread-Index: AQHZn6acZZ4dkU/i6UihVFwfoODJwa+N6q2AgAX4sBA=
Date: Tue, 20 Jun 2023 16:07:55 +0000
Message-ID: <MW5PR11MB58118605A1284B8E08A783D9DD5CA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20230615162932.762756-1-david.m.ertman@intel.com>
 <20230615162932.762756-7-david.m.ertman@intel.com>
 <d34b0e13-1365-07db-d6bb-694625c8f82c@intel.com>
In-Reply-To: <d34b0e13-1365-07db-d6bb-694625c8f82c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|IA1PR11MB7344:EE_
x-ms-office365-filtering-correlation-id: b985cda9-4544-4281-0097-08db71a8824e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41uAtkAWPPWS7wKRwOBSi3dUJtgbFWjMfq4Q9ZegHo8yR8B8yA7CR7vW6O09bE1p82iKHv6KKwYxPe6bFQtNOptufU86skL6klJXkA64UEBhRXjoOr7cbjdpQL78M71rpjZZFFR5L/7Q8plpyY6s4VNB/zfyBsOxR20igeiq3jM1wqZH/6DKe/wzLB67kbDSJX6L5gDzdwpU7SfGPb6SogoQPJKj6/SUfSXy2gFOTh/CKMRwY83RvKZvbmV2C8fRGAdRY9Re6hc428gvUDG2mWhX0MboV8IHsHe9OOei0VbqnEC+JIZOHNk8/8Ko2NGhu8MMhLu6h8bp2tTUO4tmhB7A7BElSDJKtVNmdWhhRaf6x/cOW1OEg8wBUVczZVRvm7dKqQjkyVgdpNn0iDZDSmGM83AEDsYxia7pBsL53C8/8/5CoqHzbOM0xohV7GMhiL7lhiClcRnTvC7XPaIyjg9tjWDNj//m44iRhQ2P8swzWDcjuTjNXahEsiWUOyTiZuVPRRgcNWnSaK+l97EozS5pvg1NPewyKrUB8koXWAisQkoet+b9mMwTjdxaCLfstqK9GQs92kbASyO0DBreK1GrEn4BtSYwVYzgihpnZvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(5660300002)(2906002)(76116006)(66556008)(52536014)(9686003)(54906003)(316002)(4326008)(66476007)(110136005)(66446008)(66946007)(64756008)(41300700001)(186003)(478600001)(71200400001)(7696005)(26005)(8936002)(8676002)(53546011)(6506007)(83380400001)(82960400001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkRsS1RyNzhCOG1ka1NGdzBIZlJJL0NPNWcvUGFucXQwV3pKcXYrcG5VQnBy?=
 =?utf-8?B?SVMzL3d3d2Y5dDFPaUdBeHpuVTNwZUlTd1VuN3ZlWHlOeTkyU2dDc1hjQklU?=
 =?utf-8?B?S2tBdWdNYjBOQW5odWtoRlZ0WU42SHp3Y1Q3MisxK3BqRDA4YmVPQlNDSXBR?=
 =?utf-8?B?TmczYmE5cVhJTThod2d0NlFXejNySG1TLzdNbjcydDRLMlVSQndQdG9LcjJ0?=
 =?utf-8?B?cm1CcldWNmNpZi8zcnFsUnZvMGdWc1o5Vm1QTkp3RjB3REVGMUxIUGl4aFBw?=
 =?utf-8?B?REVJQ0JHZlp2VFErN0JrbmJFRXdZajkyNjRhazBZRHhBbjdXeXVld05pRWNP?=
 =?utf-8?B?Sk9aUnNuN3JlbGtjb3V5MGJIWXpRT0FGaEQyUFBvUmMyZ2FNaHppelQveTZQ?=
 =?utf-8?B?eWhUV1ZORmdMbVVCVXREdjErSy9BdUFMaGhOMExCT2FMSExMRkxCQSsrUnBY?=
 =?utf-8?B?VDkyc3YwcForQnFqWGlaTEVTd1JoTGlrei96bndmTnpGakl0SGVXbXFDbVUw?=
 =?utf-8?B?L2xMeGlrLzZPZGJKL2djbzNvRjlybzZTTm83R1UxUmRlVjZob2lwK1d1M3hi?=
 =?utf-8?B?Z2orL0J6c1FGWjVZb01rVUtRenZCTUZOY3NjWUhHWHJlYnhwbU5HWkZoeUN2?=
 =?utf-8?B?R0s1MWRxQllWU0hwOXp3WTNndzVZUFhMRVMybUI0RkZYaGxhRis5Z3BacEhE?=
 =?utf-8?B?SWdJNHJQdzVZeWRPLzI3SE56eE44ckpOYldJamhFMHprclptTjZqMW9tK3Na?=
 =?utf-8?B?d2JGcE9OdVJUcm0vMVVOdDNheXNpVzlDMG44eXhzeU83VUdCRVcyVU9VcVZz?=
 =?utf-8?B?VkdHWGFkOTRKbGttVitOZUVSVHRCMjRCbWFZRzZLcDNwNGxGbUl2R1JDNFFo?=
 =?utf-8?B?Y1c1aHdvemRveVVwaGNpcUV5UUE1R0lhYXVzWWc2VHFFOHppaTBwdnRhUW16?=
 =?utf-8?B?aXlTNUJyV3hWRmRKSUlZT3Y3bWszdXRNOHA5VHNQbkhNZGFJb3VGbWNxWnN4?=
 =?utf-8?B?bkx6MGJKUnhqQ0FIRzA0clV2UUg1eDdHR0Z6RWx6M2xad2ZCaHVEUHZsMlR0?=
 =?utf-8?B?L25EZXFHbGxLdGdMd2xyWTBjNi9ha2h1SXBra3F2UGRKTlh3RVlNZE5XWllJ?=
 =?utf-8?B?TzNNZk9yWHgyQ1NpNUpFZ1BSS2o0b0hPNHV3TERJdE5lZ1h6dkRCbmtodUdV?=
 =?utf-8?B?UXNXN3RWL1lsTEdTb3YwTm9kS05XSnJVVkZzZUhjNGtxbWxCbTgxM3I3ajFs?=
 =?utf-8?B?OEhEaUNOK1V4NUNWUnVDN1ZObTk0QlZQR3BuUW9WY3FTaWNNcHFDT0Z5UWE3?=
 =?utf-8?B?S0hmZzFUODlIWm91ai9jc09PeEdtc09WV051TCtic3VYcCtkSUV1QXNyMktN?=
 =?utf-8?B?TkxGSGxpQjdVNHRJMkd4MUpWY2hCQ0JRQnVyWmtQcEJDUFVwcUlsSmhHZUpH?=
 =?utf-8?B?TGkvZk56YW1BN2ZoU2x5bzVISUdSeW5tb2xrZ3crSzF5RnlER0k3ZUdaMGRX?=
 =?utf-8?B?azRhUUJXUzk3ckFZcFZFVGxVMWVma2R3MUJTYlN1ZFBqeWc3T2h5cGYwd0ty?=
 =?utf-8?B?NzNSR1dGdE5qd0p6bFQzUllpTkpuVEpIKys2VHZna0Q3TTdxdVRNZzRNRFVW?=
 =?utf-8?B?QTM0NTBQN0NpZ3g4bkV2bXNzUlUvQzhiamo4cXg0dWt5R253U1lpKzh2NVZu?=
 =?utf-8?B?RytCYkxhR3c3QzgyQlJySG52K0tjZHZWeURwOW1SRzE2UFBGZ1hMaE5ldUpa?=
 =?utf-8?B?a2xzVVVPbkNjbGp4aGJlWTJjOS9kZWxKdEhzYlE0VE1JRmhtOVhwTGZqaUQx?=
 =?utf-8?B?S3crT3h1bStseVhpRDVaSkhvSWUxSGtFS2xJaEltVmMxSzdaOHd2Z3dwTGxt?=
 =?utf-8?B?QlZMMTY4dlBEV0VIUjl3dUI1VlJpWXhDa3ptQUhNMmdoRGpPNE5FR1FKVW8w?=
 =?utf-8?B?TmZmYlFjVVpDSG1jMkNBc1pnL1Y2RE9QUTZlNzlQbG5hVm4vUDNVTzNQLzhk?=
 =?utf-8?B?M3V4SEF3cUR0OWEyYno1dGZYdXZXWGVwRkU0ZFd3dEtMZElHTU5BOW42Mlht?=
 =?utf-8?B?RnlJOHdIUkU0NTJheFdUM3BqbjIyT3hTaFpyUm5GcmJ6enhGQXNhNVM2YU9a?=
 =?utf-8?Q?/o+lV5TZ60MFfJFApZERh3Zzf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b985cda9-4544-4281-0097-08db71a8824e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 16:07:55.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HLSWIzPkEyv7myKVlPUXnb1iOkjdrfquMmJGMPHiUsCYOp2Y8GlCrByVe+pfVMnYhm7SBSomy4jtXjamGOllsgP/ErarPJrKypz52GlGRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7344
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxNiwgMjAy
MyAxOjU2IFBNDQo+IFRvOiBFcnRtYW4sIERhdmlkIE0gPGRhdmlkLm0uZXJ0bWFuQGludGVsLmNv
bT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgYmNyZWVsZXlAYW1kLmNvbTsNCj4gZGFuaWVsLm1hY2hvbkBtaWNyb2No
aXAuY29tOyBzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjUgMDYvMTBdIGljZTogRmxlc2ggb3V0DQo+IGlt
cGxlbWVudGF0aW9uIG9mIHN1cHBvcnQgZm9yIFNSSU9WIG9uIGJvbmRlZCBpbnRlcmZhY2UNCj4g
DQo+IE9uIDYvMTUvMjAyMyA5OjI5IEFNLCBEYXZlIEVydG1hbiB3cm90ZToNCj4gDQo+IC4uLg0K
PiANCj4gPiAgIC8qKg0KPiA+IEBAIC02MjIsNiArMTMyNCw2OSBAQCBzdGF0aWMgdm9pZCBpY2Vf
bGFnX21vbml0b3JfYWN0aXZlKHN0cnVjdCBpY2VfbGFnDQo+ICpsYWcsIHZvaWQgKnB0cikNCj4g
PiAgIHN0YXRpYyBib29sDQo+ID4gICBpY2VfbGFnX2Noa19jb21wKHN0cnVjdCBpY2VfbGFnICps
YWcsIHZvaWQgKnB0cikNCj4gPiAgIHsNCj4gPiArCXN0cnVjdCBuZXRfZGV2aWNlICpldmVudF9u
ZXRkZXYsICpldmVudF91cHBlcjsNCj4gPiArCXN0cnVjdCBuZXRkZXZfbm90aWZpZXJfYm9uZGlu
Z19pbmZvICppbmZvOw0KPiA+ICsJc3RydWN0IG5ldGRldl9ib25kaW5nX2luZm8gKmJvbmRpbmdf
aW5mbzsNCj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgKnRtcDsNCj4gPiArCWludCBjb3VudCA9IDA7
DQo+ID4gKw0KPiA+ICsJaWYgKCFsYWctPnByaW1hcnkpDQo+ID4gKwkJcmV0dXJuIHRydWU7DQo+
ID4gKw0KPiA+ICsJZXZlbnRfbmV0ZGV2ID0gbmV0ZGV2X25vdGlmaWVyX2luZm9fdG9fZGV2KHB0
cik7DQo+ID4gKwlyY3VfcmVhZF9sb2NrKCk7DQo+ID4gKwlldmVudF91cHBlciA9DQo+IG5ldGRl
dl9tYXN0ZXJfdXBwZXJfZGV2X2dldF9yY3UoZXZlbnRfbmV0ZGV2KTsNCj4gPiArCXJjdV9yZWFk
X3VubG9jaygpOw0KPiA+ICsJaWYgKGV2ZW50X3VwcGVyICE9IGxhZy0+dXBwZXJfbmV0ZGV2KQ0K
PiA+ICsJCXJldHVybiB0cnVlOw0KPiA+ICsNCj4gPiArCWluZm8gPSAoc3RydWN0IG5ldGRldl9u
b3RpZmllcl9ib25kaW5nX2luZm8gKilwdHI7DQo+ID4gKwlib25kaW5nX2luZm8gPSAmaW5mby0+
Ym9uZGluZ19pbmZvOw0KPiA+ICsJbGFnLT5ib25kX21vZGUgPSBib25kaW5nX2luZm8tPm1hc3Rl
ci5ib25kX21vZGU7DQo+ID4gKwlpZiAobGFnLT5ib25kX21vZGUgIT0gQk9ORF9NT0RFX0FDVElW
RUJBQ0tVUCkgew0KPiA+ICsJCW5ldGRldl9pbmZvKGxhZy0+bmV0ZGV2LCAiQm9uZCBNb2RlIG5v
dCBBQ1RJVkUtDQo+IEJBQ0tVUFxuIik7DQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWxpc3RfZm9yX2VhY2godG1wLCBsYWctPm5ldGRldl9oZWFkKSB7DQo+ID4g
KwkJc3RydWN0IGljZV9kY2J4X2NmZyAqZGNiX2NmZywgKnBlZXJfZGNiX2NmZzsNCj4gPiArCQlz
dHJ1Y3QgaWNlX2xhZ19uZXRkZXZfbGlzdCAqZW50cnk7DQo+ID4gKwkJc3RydWN0IGljZV9uZXRk
ZXZfcHJpdiAqcGVlcl9ucDsNCj4gPiArCQlzdHJ1Y3QgbmV0X2RldmljZSAqcGVlcl9uZXRkZXY7
DQo+ID4gKwkJc3RydWN0IGljZV92c2kgKnZzaSwgKnBlZXJfdnNpOw0KPiA+ICsNCj4gPiArCQll
bnRyeSA9IGxpc3RfZW50cnkodG1wLCBzdHJ1Y3QgaWNlX2xhZ19uZXRkZXZfbGlzdCwgbm9kZSk7
DQo+ID4gKwkJcGVlcl9uZXRkZXYgPSBlbnRyeS0+bmV0ZGV2Ow0KPiA+ICsJCWlmICghbmV0aWZf
aXNfaWNlKHBlZXJfbmV0ZGV2KSkgew0KPiA+ICsJCQluZXRkZXZfaW5mbyhsYWctPm5ldGRldiwg
IkZvdW5kIG5vbi1pY2UgbmV0ZGV2IGluDQo+IExBR1xuIik7DQo+ID4gKwkJCXJldHVybiBmYWxz
ZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWNvdW50Kys7DQo+ID4gKwkJaWYgKGNvdW50ID4g
Mikgew0KPiA+ICsJCQluZXRkZXZfaW5mbyhsYWctPm5ldGRldiwgIkZvdW5kIG1vcmUgdGhhbiB0
d28NCj4gbmV0ZGV2cyBpbiBMQUdcbiIpOw0KPiA+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwkJ
fQ0KPiA+ICsNCj4gPiArCQlwZWVyX25wID0gbmV0ZGV2X3ByaXYocGVlcl9uZXRkZXYpOw0KPiA+
ICsJCXZzaSA9IGljZV9nZXRfbWFpbl92c2kobGFnLT5wZik7DQo+ID4gKwkJcGVlcl92c2kgPSBw
ZWVyX25wLT52c2k7DQo+ID4gKwkJaWYgKGxhZy0+cGYtPnBkZXYtPmJ1cyAhPSBwZWVyX3ZzaS0+
YmFjay0+cGRldi0+YnVzIHx8DQo+ID4gKwkJICAgIGxhZy0+cGYtPnBkZXYtPnNsb3QgIT0gcGVl
cl92c2ktPmJhY2stPnBkZXYtPnNsb3QpIHsNCj4gPiArCQkJbmV0ZGV2X2luZm8obGFnLT5uZXRk
ZXYsICJGb3VuZCBuZXRkZXYgb24NCj4gZGlmZmVyZW50IGRldmljZSBpbiBMQUdcbiIpOw0KPiA+
ICsJCQlyZXR1cm4gZmFsc2U7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlkY2JfY2ZnID0gJnZz
aS0+cG9ydF9pbmZvLT5xb3NfY2ZnLmxvY2FsX2RjYnhfY2ZnOw0KPiA+ICsJCXBlZXJfZGNiX2Nm
ZyA9ICZwZWVyX3ZzaS0+cG9ydF9pbmZvLQ0KPiA+cW9zX2NmZy5sb2NhbF9kY2J4X2NmZzsNCj4g
PiArCQlpZiAobWVtY21wKGRjYl9jZmcsIHBlZXJfZGNiX2NmZywNCj4gPiArCQkJICAgc2l6ZW9m
KHN0cnVjdCBpY2VfZGNieF9jZmcpKSkgew0KPiA+ICsJCQluZXRkZXZfaW5mbyhsYWctPm5ldGRl
diwgIkZvdW5kIG5ldGRldiB3aXRoDQo+IGRpZmZlcmVudCBEQ0IgY29uZmlnIGluIExBR1xuIik7
DQo+ID4gKwkJCXJldHVybiBmYWxzZTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJfQ0KPiANCj4g
QXMgeW91IGhhdmUgdG8gcmVzcGluIGFueXdheXMuLi4NCj4gDQo+IENIRUNLOiBCbGFuayBsaW5l
cyBhcmVuJ3QgbmVjZXNzYXJ5IGJlZm9yZSBhIGNsb3NlIGJyYWNlICd9Jw0KPiAjODkzOiBGSUxF
OiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xhZy5jOjEzODg6DQoNCkZpeGVk
DQoNCj4gKw0KPiArICAgICAgIH0NCg0K

