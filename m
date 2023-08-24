Return-Path: <netdev+bounces-30531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A3787BAB
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB4281701
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1170BA38;
	Thu, 24 Aug 2023 22:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC07E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 22:50:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B1CCB
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692917439; x=1724453439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9Osecag248QBNIWjXeqJvlhPpfPZR8+WdV3pF64eoU=;
  b=O8yTHhwWp7B0Q8gUdiuUY8ToN0bN6oo3MuFGkRm8lQqDJ5ttHIBwbc4k
   nyQFHPzUC4TtwpaCJmXujlfOlKOdwsY89zpG7uZupJ1w/FltfqaX1zUq8
   LpdMCOGP+OSdtPjIXf6MgGdkwiPWAjdG6UzKxmdy79SbIlGSri/xQM9yJ
   UHQCQCAjNibABATxbji2Bi0YvGrY3TVRhGY6Rf9pjJKV0S4X7weFXAYpb
   PaAOZBb/ZJjH72Ni46nFQOnK+/QmU4FTXg+4UmOdeMeCx0YELRZ3ffFwm
   53lR2Rd/YRBCGA+vrLPrX+8Yl3C3MwoSMDWE2PYZmKUyLfJTLFUGXPwkE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="373451646"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373451646"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 15:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="772267457"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="772267457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2023 15:50:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:50:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:50:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 15:50:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 15:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9YMAFXeJeOzngAcJhoWPctx94OMdYW9IgAJqUCpgTZMQ9NSQHYYemf9JsbCudFynScX1KhgymF7XHspzmeJ/D7eyID9RsX6h19Q9wJyDUhV9FJoIHfKqWwR35SGk6OR9JPH91vvmUoR6FefBfksjnJQHG/azT/GgMZ9Yq++Lpjvxer1HEvFwGlMoqLxl+HEGA9GmCm4Vhf67baEb4YQmMeKAse+W4JrSfScSbcwXN6tDFKAJdUCQbZviHJ4PglsjtLncd2Uiz8EMhzO0yRLG8wLvR2kK3CXffad0kueU9vyHJR2SYjmnnb8dYvXDRhpX9cBxAzimEV+TR1dRqXIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Osecag248QBNIWjXeqJvlhPpfPZR8+WdV3pF64eoU=;
 b=Gg621uajh+sn7lUvMOaFM7UI37fOn/PqjRmx+9SwUoaR/aYABgc63h3oQlsfwPkeqGBp4BosF1mpvjYYPwKFa/uT/X+oV118WLIqyMK9/17HgTONFAxC9xA5jPqcH2yVIfb+ZF1NwyYADC/soBoOeI1TP/all7atqzIsPI5yoTffv5tP6JlUcxmDY0v4i3sz6pIpLrczDoeV7zSPsZx93coabT7j35rMZjVeNOFoqh4gxqP5UCyFZHp1QyrxZwM4mQQYCH3Jg2RfNJfVw2uKty+vowKiwv3nGrYEm6BeCSIFgByUTiiEDADbTGzdNlQ9HEMybTi3bedHKPs9ZhtK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:50:34 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:50:34 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Neftin, Sasha"
	<sasha.neftin@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"bcreeley@amd.com" <bcreeley@amd.com>, Naama Meir
	<naamax.meir@linux.intel.com>
Subject: RE: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZ1UdLBr55a0cOOkC26dNjnXpg9K/4uEIAgAFVHMA=
Date: Thu, 24 Aug 2023 22:50:34 +0000
Message-ID: <SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
 <20230823191928.1a32aed7@kernel.org>
In-Reply-To: <20230823191928.1a32aed7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|MN0PR11MB6159:EE_
x-ms-office365-filtering-correlation-id: 1c0e759c-7d2b-46c9-deeb-08dba4f486d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pw0arGFom3E5DrGKDQO6YEZc3T/dsyS1F6bXpD7m4WfdJPxmHbmUMomZlHlzNMdvGCfzMLCFJFXuI6JvAxlMjV6JuBqqoGCoVNz7Av8C4/BSLxE4rn0apamLKflhZoYVJRvBb5l5/L8GcQvTiHc0uusgcDsooX+7gYqoeW8G8OGts9fR/Z8ffVBDutFwqPseuHknFjpk2vxGqOqhpersew4HAoPbXa7DCJmMvxc9pbMrDI43Ab/ZY8VSCxcGab8wINgV6CCzfEJgKJkE7WMynDm6FFNvYvKAhTJDU5aSSUUJMIcx7upRft1gh1UbssTNE3mbHeQhJsDh1pBb0p3Jvb8X0Yl9ETvV22rn6M3YJXZ2fa6qEsMl7EsL+csmtCk0omW0ckNBzFyR4VoTKLHKk/hqdYxb7i7vgotQ9IolzBDXd9ddYQNZu4Y4wLj7VDHP8MAQ8T9eFwQY7oxEa/Vm5jjv01WbNB6EuO+Yl4JLjsxUcDJx9nDy1YR34Nsd3JzEHm11Lz+28j+393yYiq8IJJQlEdRy7sGUKb8PP9zTCW7DJGS1K2I0234s8inzHzCcetw/lpvONJg9ocq4wXRGr+HlkqWKduSLOWqI2fsCr1j6s5msfRoN79fSzT+7HJn4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(1800799009)(186009)(451199024)(52536014)(4326008)(8676002)(8936002)(83380400001)(5660300002)(26005)(55016003)(33656002)(71200400001)(38100700002)(38070700005)(82960400001)(122000001)(66946007)(66556008)(76116006)(64756008)(66446008)(54906003)(66476007)(6636002)(316002)(110136005)(478600001)(41300700001)(2906002)(9686003)(53546011)(86362001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tzc5VzFRYjhuMXpSdjk3b2RjLyt4YWZBTTZZenJ4VHM1S0V0MDJyUlZleWo5?=
 =?utf-8?B?K0d6OVh3NTQwQlNnWGtEdmE3ZlNpK09uSVJnZmxIY3p0M3A0S3c3MVVkSFNQ?=
 =?utf-8?B?dUkxdTIxeTZJNXJQSVcyRS9qOHBybjltRHIrMWVhZ0tTaWx2OFRsNFpnT3pU?=
 =?utf-8?B?T2UrL1gwOEtaN051VXR4RzZhc0tTZVk5MXlmZlRBUlhIS21XaStLRHE2aXFG?=
 =?utf-8?B?enREL2Qwb0hsTkJ4Z29DK2VseXptd3lUM2o2cFE4cnMxQ3Vxekh3Y05pOU5u?=
 =?utf-8?B?QTRFRjU5YnlwZVMrRTZncktJREpDMTRScmtTaFZZamJjUWpoNzhMWTZEMzV1?=
 =?utf-8?B?YVhaWEo2N09kV2k3U1ZDRDd0RkdJbHZsL2htNWlTMnRkOHRWOE8xd05SQm1p?=
 =?utf-8?B?Sm1CK2FHTzVjd1pZUzduSTQrdWJVVk0rbnhrNGgvVVJQdWNlczRNVVpzd2R1?=
 =?utf-8?B?anY5SktYRVdYU0gxY3J4QkNPZlhzUmx6bzRJWTcyVXF6NW5KTmt5SFFXZzV1?=
 =?utf-8?B?VzFTc2JXYVFQUiszb0JTM2F0cGpCTHN0NE1saGlXWnV3bTIrQmg3MTk1ZHll?=
 =?utf-8?B?UzZLU1NjNEhJZnVKeHliaGRIZ2syeXRMTXJGUHpHZVhwSzJpT3ZWVm01VTJN?=
 =?utf-8?B?MnRmTmdleHpkdzRvTWpDZzdJQXdEL1VuU3F1VHZWaU1jN1BqLy83dTF2eFdO?=
 =?utf-8?B?aVlHZ1c2MEx5MWZHaTN3cmlUMXZjRnh4S3hSc09KZ25ieWlMVW5vN1pTU1N0?=
 =?utf-8?B?ZWtFRXNNZk9iN1p1eGVCWFRBL3QyZGxGSVRmVzByRmM1SmFNbE8vbDVheUF0?=
 =?utf-8?B?dGJYeXpWRzRTVk50SkY4RlpoMkd6RFNxTTYrdVVqNzdIc0F2NHA3b0t1Zzgv?=
 =?utf-8?B?VTFvVURHRzEyaUVFRzhIVitFZGVMQkxUUHNDSWN5bnlnRkw5TjJjelJ4OVJh?=
 =?utf-8?B?c3NVdmJ5TGprWlg1b1lkT0lEVmVzVGYzVWpFQWRnNGNqZERzZ2QrQmNoQXRM?=
 =?utf-8?B?MXk4RFc1NTRsSFI4eUowMHNFREpkQ3pad3RKOUlmR0ZKdS9tSHdqcEhGVUpY?=
 =?utf-8?B?S3R3WTFzVGZJSU9nVmxyaVV0cjZIQjJVNURFREtNamJQYWFkNldzclpQUlUy?=
 =?utf-8?B?MjExK3BhM0tvUUdUdU93bzhVcnlabVdnbkl2TU9kRnRDUVZhVWpPcnEvbWF2?=
 =?utf-8?B?aXFGRjZkanpWV3gzMkhhMWl4V0VlRjZqUmZhNGcySk4rV3IrVkJiV1Z3UEp0?=
 =?utf-8?B?RUo2d0RSV0EyYktMN00xam9lZ0tSaVlqNi9OR2pNT1pOS1RURUV2eFo3U3I3?=
 =?utf-8?B?ZWZUK1h2V1YxN3JOVlpUR1M2bEwzNERmWXRLdzJKKzlnRjJQbkJITjRsZm0w?=
 =?utf-8?B?UTJNeWJTVVdWYjYwbkZPanAxME9PQ2l2L0k1MnlQWjJEcEt3aHZ1MU96b0F6?=
 =?utf-8?B?eHQ3YjNJWVpxTFZjNmJESVVFNHZLdUJIVzNRYWFXK0FCRUhLNi9SWjNjak02?=
 =?utf-8?B?bUFRb2FtVFMzaTUvYloyQWFacUZxVmxRQUtMVDZNbm5VcFpsdTlxYWk3aEZz?=
 =?utf-8?B?M0dmcTlyL2laQjZFVDlZT0NGdjM3YXdBNUo1NmNnbEUyOU5MS0srV3o3MEpL?=
 =?utf-8?B?STluUXBVYk11dk5rWnNBdEx6V1VqSWlwZUlqU1FPSU1ibzIweU5NZnZXMWQ5?=
 =?utf-8?B?TDNWNHJKZXJSdTR5bXY4cUxVdHhHa2FZMVZOT2Z5Y0tGc2ZJQWQwaW9hcUs2?=
 =?utf-8?B?Wm54bWV0VExhbU5KWHJEVlhvaktJdzJBd2VIdFgreGEzWUpuNDNERzQ1Y3hZ?=
 =?utf-8?B?OW1KcUZhV0p3OFpBdkc4OUc4WXVJZDEzRWoxR2lZV0JPWkNYYjRJaDBBQUpo?=
 =?utf-8?B?NUVUQXEvK1g0N2orc2E2cTM3NmZIMGd2RWo5bEJZMGFlWXJnWWkyN3pPai9K?=
 =?utf-8?B?M3UxZ1FEekhxdUpVVVRnUmRvUUQyRDZjWDV4QWcvQzFsejdUeVkrRCt4cUd6?=
 =?utf-8?B?aTJ1MHlXZm11dzhicW9kTWMrYXJvcXZjcmh2aXdXcTBlSGEyS05Cd3pwN3Jm?=
 =?utf-8?B?bkQ5VVVzZFpFS1NOQ0VOWjVtU3dIZVBkTnM2QlpTdWdnOUkydGl0eTJPUXRo?=
 =?utf-8?B?c0s1STh4a3hoUUJZeU5GblJTRkpYd2w2NndndUlUYW1Eb0orU09rZ3padVRQ?=
 =?utf-8?Q?tLvZ7/spx53lNOAfsvHWlQI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0e759c-7d2b-46c9-deeb-08dba4f486d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 22:50:34.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vudROrRparnSkHG9bd1mS3pdLCUv83sVk7f7QCD84qJlOTc1WCpl/5BFIg3WBGkyRNfQAE+bLqnssr504PjNLljG+iPGCM54bRsdnomKj/GHMP7HGTYFcIyJQ0b6IQio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RGVhciBKYWt1YiwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcg8J+Yig0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCAyNCBBdWd1c3QsIDIwMjMgMTA6MTkgQU0NCj4gVG86IE5ndXll
biwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT4NCj4gQ2M6IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IHBhYmVuaUByZWRoYXQuY29tOyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaQ0KPiA8bXVo
YW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+OyBOZWZ0aW4sIFNhc2hhDQo+IDxzYXNo
YS5uZWZ0aW5AaW50ZWwuY29tPjsgaG9ybXNAa2VybmVsLm9yZzsgYmNyZWVsZXlAYW1kLmNvbTsg
TmFhbWENCj4gTWVpciA8bmFhbWF4Lm1laXJAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldCB2MyAyLzJdIGlnYzogTW9kaWZ5IHRoZSB0eC11c2VjcyBjb2FsZXNjZSBz
ZXR0aW5nDQo+IA0KPiBPbiBUdWUsIDIyIEF1ZyAyMDIzIDE1OjE2OjIwIC0wNzAwIFRvbnkgTmd1
eWVuIHdyb3RlOg0KPiA+IHJvb3RAUDEyRFlIVVNBSU5JOn4jIGV0aHRvb2wgLUMgZW5wMTcwczAg
dHgtdXNlY3MgMTAgbmV0bGluayBlcnJvcjoNCj4gPiBJbnZhbGlkIGFyZ3VtZW50DQo+IA0KPiBX
aHkgd2FzIGl0IHJldHVybmluZyBhbiBlcnJvciBwcmV2aW91c2x5PyBJdCdzIG5vdCBjbGVhciBm
cm9tIGp1c3QgdGhpcyBwYXRjaC4NCg0KSW4gcGF0Y2ggMS8yLCB0aGUgcmV0dXJuZWQgZXJyb3Ig
d2FzIHJlbW92ZWQuIFRoZSBwcmV2aW91cyBlcnJvciB3aWxsIHByZXZlbnQgdGhlIHVzZXIgZnJv
bSBlbnRlcmluZyANCnRoZSB0eC11c2VjcyB2YWx1ZTsgaW5zdGVhZCwgdGhlIHVzZXIgY2FuIG9u
bHkgY2hhbmdlIHRoZSByeC11c2VjcyB2YWx1ZS4NCg0KPiANCj4gPiAtCS8qIGNvbnZlcnQgdG8g
cmF0ZSBvZiBpcnEncyBwZXIgc2Vjb25kICovDQo+ID4gLQlpZiAoZWMtPnJ4X2NvYWxlc2NlX3Vz
ZWNzICYmIGVjLT5yeF9jb2FsZXNjZV91c2VjcyA8PSAzKQ0KPiA+IC0JCWFkYXB0ZXItPnJ4X2l0
cl9zZXR0aW5nID0gZWMtPnJ4X2NvYWxlc2NlX3VzZWNzOw0KPiA+IC0JZWxzZQ0KPiA+IC0JCWFk
YXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0gZWMtPnJ4X2NvYWxlc2NlX3VzZWNzIDw8IDI7DQo+ID4g
KwlpZiAoYWRhcHRlci0+ZmxhZ3MgJiBJR0NfRkxBR19RVUVVRV9QQUlSUykgew0KPiA+ICsJCXUz
MiBvbGRfdHhfaXRyLCBvbGRfcnhfaXRyOw0KPiA+ICsNCj4gPiArCQkvKiBUaGlzIGlzIHRvIGdl
dCBiYWNrIHRoZSBvcmlnaW5hbCB2YWx1ZSBiZWZvcmUgYnl0ZSBzaGlmdGluZyAqLw0KPiA+ICsJ
CW9sZF90eF9pdHIgPSAoYWRhcHRlci0+dHhfaXRyX3NldHRpbmcgPD0gMykgPw0KPiA+ICsJCQkg
ICAgICBhZGFwdGVyLT50eF9pdHJfc2V0dGluZyA6IGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nDQo+
ID4+IDI7DQo+ID4gKw0KPiA+ICsJCW9sZF9yeF9pdHIgPSAoYWRhcHRlci0+cnhfaXRyX3NldHRp
bmcgPD0gMykgPw0KPiA+ICsJCQkgICAgICBhZGFwdGVyLT5yeF9pdHJfc2V0dGluZyA6IGFkYXB0
ZXItPnJ4X2l0cl9zZXR0aW5nDQo+ID4+IDI7DQo+ID4gKw0KPiA+ICsJCS8qIGNvbnZlcnQgdG8g
cmF0ZSBvZiBpcnEncyBwZXIgc2Vjb25kICovDQo+ID4gKwkJaWYgKG9sZF90eF9pdHIgIT0gZWMt
PnR4X2NvYWxlc2NlX3VzZWNzKSB7DQo+ID4gKwkJCWFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nID0N
Cj4gPiArCQkJCWlnY19ldGh0b29sX2NvYWxlc2NlX3RvX2l0cl9zZXR0aW5nKGVjLQ0KPiA+dHhf
Y29hbGVzY2VfdXNlY3MpOw0KPiA+ICsJCQlhZGFwdGVyLT5yeF9pdHJfc2V0dGluZyA9IGFkYXB0
ZXItPnR4X2l0cl9zZXR0aW5nOw0KPiA+ICsJCX0gZWxzZSBpZiAob2xkX3J4X2l0ciAhPSBlYy0+
cnhfY29hbGVzY2VfdXNlY3MpIHsNCj4gPiArCQkJYWRhcHRlci0+cnhfaXRyX3NldHRpbmcgPQ0K
PiA+ICsJCQkJaWdjX2V0aHRvb2xfY29hbGVzY2VfdG9faXRyX3NldHRpbmcoZWMtDQo+ID5yeF9j
b2FsZXNjZV91c2Vjcyk7DQo+ID4gKwkJCWFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nID0gYWRhcHRl
ci0+cnhfaXRyX3NldHRpbmc7DQo+ID4gKwkJfQ0KPiANCj4gSSdtIG5vdCBzdXJlIGFib3V0IHRo
aXMgZml4LiBTeXN0ZW1zIHdoaWNoIHRyeSB0byBjb252ZXJnZSBjb25maWd1cmF0aW9uIGxpa2UN
Cj4gY2hlZiB3aWxsIGtlZXAgaXNzdWluZzoNCj4gDQo+IGV0aHRvb2wgLUMgZW5wMTcwczAgdHgt
dXNlY3MgMjAgcngtdXNlY3MgMTANCj4gDQo+IGFuZCBBRkFJQ1QgdGhlIHZhbHVlcyB3aWxsIGZs
aXAgYmFjayBhbmQgZnJvdGggYmV0d2VlbiAxMCBhbmQgMjAsIGFuZCBuZXZlcg0KPiBzdGFiaWxp
emUuIFJldHVybmluZyBhbiBlcnJvciBmb3IgdW5zdXBwb3J0ZWQgY29uZmlnIHNvdW5kcyByaWdo
dCB0byBtZS4gVGhpcw0KPiBmdW5jdGlvbiB0YWtlcyBleHRhY2ssIHlvdSBjYW4gdGVsbCB0aGUg
dXNlciB3aGF0IHRoZSBwcm9ibGVtIGlzLg0KDQpZZWFoLiBJbiBteSB0ZXN0cywgSSBtaXNzZWQg
dG8gc2V0IHRoZSB0eC11c2VjcyBhbmQgcngtdXNlY3MgdG9nZXRoZXIuIFRoYW5rIHlvdSBmb3Ig
c3BvdHRpbmcgdGhhdC4NCldlIGNhbiBhZGQgdGhlIE5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ss
Li4uKSBhbmQgcmV0dXJuaW5nIGVycm9yIGZvciB1bnN1cHBvcnRlZCBjb25maWcuDQpJZiBJIHJl
Y2FsbCBldmVuIGlmIHdlIG9ubHkgc2V0IG9uZSBvZiB0aGUgdHggb3IgcnggdXNlY3MsIHRoaXMg
Wy5zZXRfY29hbGVzY2VdIGNhbGxiYWNrIHdpbGwgc3RpbGwgcHJvdmlkZSANCnRoZSB2YWx1ZSBv
ZiBib3RoIHR4LXVzZWNzIGFuZCByeC11c2Vjcy4gU2VlbXMgbGlrZSBtb3JlIGNoZWNraW5nIGFy
ZSBuZWVkZWQgaGVyZS4NCkRvIHlvdSBoYXZlIGFueSBwYXJ0aWN1bGFyIHRob3VnaHRzIHdoYXQg
c2hvdWxkIGJlIHRoZSBiZXN0IGNhc2UgY29uZGl0aW9uIGhlcmU/DQoNClRoYW5rcywNCkh1c2Fp
bmkNCg0KPiAtLQ0KPiBwdy1ib3Q6IGNyDQo=

