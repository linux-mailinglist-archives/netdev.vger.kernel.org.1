Return-Path: <netdev+bounces-12310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E0D73712D
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F08281322
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB71773F;
	Tue, 20 Jun 2023 16:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AAD101F3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:07:44 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A588210C1
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687277263; x=1718813263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jcif6sYEzPYkXvbIsUE7p7/L+UIPel2ulgStdK3lvSs=;
  b=DnOYIv/I+UTY4N5PEYI+Jr5HMYvxy/TFfOqROXDD96k5173iLSLNlmUJ
   OTXK+OSFF4vTk/qzy/JD0E5/tt7N9TF5KbneBuvvCj7/Wu0vFvq+qN5LD
   qLWR2qmsF7UGpT5d/khytRwDmctpcfVRHHc42tO2HxkMzrap3JYUYu3MX
   ibwIG2SE/+x8mesLkgfwpNw762lvS0O91rI314P8zSowUCo7kNSnWvRLm
   ts4QoILfp8RQQzR0TalFxT1yu/sQzFyWzMiktziHy3dpdR1/Yl+K/s1/7
   nDmeA4BD2cXIKFiBGxFU8WPnnFJEPWFifquS+6RzW08iMIFCLA0P62JFh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344646003"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="344646003"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="858634985"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="858634985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2023 09:07:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:07:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:07:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 09:07:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 09:07:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DttUS/zUBP7yRD3Reh8UFKZJewUEib/Ss/pMrPexWQoTB0lgElcBEDE2P499OII1ttB5aUpzwDntW07GGZhmojVKEA5vkYvI2SLdLNKKC61JyvBsAU0LVo70KQsybDiDH7jaXV3zzyuQPxQQzatv5uGgLFSQ02y4KhMoKBPwGxcaj/N64Jgej3yfRHYf/qXCJ4nPdnisEfL4Mq5mK/kw1rpNIXVWWEHqt2U/YzEwOM5yun9ZA91t9I9G+62kQSgrOA8BD5nzRs670DgwKA6cdXo7+HbrJdc+9T+/0AHSskXztfXVdayQTr9DuXwZcCyfF4HxL87wghrXhbFnDnW1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcif6sYEzPYkXvbIsUE7p7/L+UIPel2ulgStdK3lvSs=;
 b=Ms3b6S/2C8Xi3zw68t4GNs1FmSERaK0cE07azETeGzkS7+YKsboCN6yBpJy1dTlvED5Ls4FOCU2rq9LLQO+AypmRaoP8zMDbA4izSRiJarZyPdW+YpWQmBRASl9jx70AxYcfWt4z5s03Yn56ZLnchGpPMd43dgJE45eG/svi67GJZaD/7IE4P+ZJbF7ScPGOsocxLauQMDopcnGLHepnCx7t9idKE+LVNxBFXnnFZtWJqhErlaskfz/W0QK0Rg75J5N5RHhLyjBUhLjAd1Y1zii9LT9BX7tBoK/WNgCDq4nVu60r9TW0UWDRLKGoDTNB9LPUJLe8ki0WjfFg0zCh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 16:07:34 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::5e37:38f7:33d2:137a%7]) with mapi id 15.20.6500.031; Tue, 20 Jun 2023
 16:07:34 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bcreeley@amd.com"
	<bcreeley@amd.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 05/10] ice: process events
 created by lag netdev event handler
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 05/10] ice: process events
 created by lag netdev event handler
Thread-Index: AQHZn6anK+ryCN5cMUGAyaz+Sr7Z4q+N6FwAgAX63mA=
Date: Tue, 20 Jun 2023 16:07:34 +0000
Message-ID: <MW5PR11MB58114B2885360C1718DCC62ADD5CA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20230615162932.762756-1-david.m.ertman@intel.com>
 <20230615162932.762756-6-david.m.ertman@intel.com>
 <ce07a11a-20eb-dcb9-22e8-489333a0799c@intel.com>
In-Reply-To: <ce07a11a-20eb-dcb9-22e8-489333a0799c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|IA1PR11MB6441:EE_
x-ms-office365-filtering-correlation-id: 698da8ad-c250-4449-2490-08db71a875d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2imN4iSSZ0jeVpMIK/Q9SeX/WXVL2wZ85OkGEEQxCHkQfyiIqpbji4oNDRRmmGHqc/h6GdIQr4DLsHDBxC0iGz+gnaejvd25+w0Gfr5adcbBY52WA7WwsOMDGc1/P3efGnIBuXcqoDED4DnCPYiA9yEbJ0eSdcUBZb99cECWC6Tvt2ct6hA6ZIvr+0nstGe5xCKH1ZSlfggpEYhuXbFuRUnt7KdcL4rI+u0lPsDn+F8wRCXXgd2JSjiWPtEG+E1jft7XFQmKuepZMPb9gFShE2uwfvVqGNskoQjsjNFjW09ZrGiTOhFd6RFAQhONRomY9ZJmtmowwHSb2Q+qF13gcG5Ej8ozuKjC+xekAR1ELbAEmjvyklS++Ga+oifZp2cmxSWO/Bw+IYFBd/NP0/2HY19HbkOm0K/+zm2IqKRKMK6UUKQic72QjsB6Tv3aGtzSu3otZ3NFLfVKPrXYhmxMLC4G6k1AQyAR9m3P9qA7HnRk3G+/pxT8zkkKBeZ2a4cLtCJUVfhPGeKnXFriBaMAkk8QpGuFXXJRJ4YGUc8TYEQ1QZ9R3snA6Vg842bvBqoeYutSlnB7J8StW3dcGwwTnlZQE8N3QBHV8qIB80vPME/yJmrIShpbZhIa0UUbMyeA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(52536014)(82960400001)(33656002)(122000001)(38100700002)(83380400001)(86362001)(41300700001)(8936002)(38070700005)(8676002)(5660300002)(66476007)(66446008)(316002)(64756008)(66946007)(66556008)(6506007)(53546011)(9686003)(26005)(55016003)(186003)(478600001)(7696005)(54906003)(110136005)(4326008)(71200400001)(76116006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmZYVE5NT28zUzVQUzhsUktJY3BDY05LZ015K0VFQ2VmSmVQdHVyRHFJaDJS?=
 =?utf-8?B?QmU2dEg3NG1YY0xDcmp0bzZKTnNVbjJUTmFseHEvbTY1QlZEU0RuMlVkU25W?=
 =?utf-8?B?eWxhMktLM0FRbkFGR2lwbG5LRVYyeHdkSkZTME5NMzBGMVFWLzVvUFB3QzJt?=
 =?utf-8?B?dTh2VGhCR010dkN3QzFuM3NEQUNJM0IxaE9MVmNMaDM1VE05QXlIcnJCOUhR?=
 =?utf-8?B?M3VIVmRLREw1YXZsV2NLd2x2S2tYZmdVVThoTnk0RU5rejh5UTBlQ1BWcmxH?=
 =?utf-8?B?WkhNbU9IRC9iTlFjbll0b0lwYXpnNjBYUS85eVdtL09kOFoxbGYrTGJLZVRj?=
 =?utf-8?B?MkN0d1ViV2R4VkNDRnh1d29HZjc1dG5TVTJQOW5pVmovdTdqRXAwNkthT1FF?=
 =?utf-8?B?a1FDNGxueUhEb3NDNFQvbTFUWlhlcVA0L1d1QkF2YWtjTXhvUFBRYlZXdU9S?=
 =?utf-8?B?OGlqUnhpV3lYSmhJcFdDMUdSSFhEbVZCT1AwZTBRSUdzUUcxSFNyTEZDdmNp?=
 =?utf-8?B?SFhUK213bUQvMWhCUkRTTHMwSEt2WjgydHk0YTRoRXJTMWNoRTRqb3ZsMXBu?=
 =?utf-8?B?T0QvQ0E1VlBmS04reUVkdGlRa25sNXprdnhHMjh0VVdYSllidyt4TkJ0K2R1?=
 =?utf-8?B?RkxPbk5zdWFKVXYyOVZsaGE4QW5tUVpuWkdNdXIyNTkzenZueGo0MVZORE1G?=
 =?utf-8?B?SVlwRzFZYVQvdStPcE5zZFUwMCsxQm9lY1NxTGkwMDliYTZGWjRJbmtSNjI1?=
 =?utf-8?B?aG1uWENCRGFJY25jL2pJZ1oxemN1VVBWdmhXc05XOGRPWi9ackxMV2gyMlBa?=
 =?utf-8?B?ZUppWldHQ1pKdzk5YmJuRWloUjRJQmhRdUxNQWtOaHF1a3F0YTdINllYMEUr?=
 =?utf-8?B?elVpWkhIWm1KM0Y2RW9PanJ4SVdpOWV1YWIwZTh0K0lVUERYK1JqcElzVnZ6?=
 =?utf-8?B?UDRhRWVMWWRzZE5JaWhobytKSVV0U1paV20razd0Y21lMllsNEJKN2hjY0lB?=
 =?utf-8?B?ZWVBdzhTazc0b1ZiL1dDTy9JL01Ia09nb2oydjBDTzRnTElwaTAvck00SmFv?=
 =?utf-8?B?cXVTR0hYajQ0MHREQThxSElaZEdwMVhnM29KQVMwTGRPeTU1RXo5N0o3dTZL?=
 =?utf-8?B?cmVJQUhRTTBiUFRoUGJJSkxxZnQ1Y1ErK0dod3l5K0pCcTllWFBPNUpaeWg2?=
 =?utf-8?B?VHFVTHNZazFJdyt4UWFXNTRVcVV4ZVJMYjJ1bCtOWHg2SXgvbXdKMWx1MkFv?=
 =?utf-8?B?NXRWamdNbGpiSXVzS1ZOL2tNTDNPRTVqWTNyM0dXaEhpSFNJc3VzMEpBVU42?=
 =?utf-8?B?cmhrZzZYZ3AxazVTc3p4Sno1WnJtTFF5dXc5ajBkbU1ITjVkSDNtOEFJZ0tR?=
 =?utf-8?B?aVBheXJuUTQ2Snl2bExhN2UrbkttbFl1N2JRZ2ZjRzhiRHluMitHdEpRa2dk?=
 =?utf-8?B?UGlDNVljdWhVa0tycUlJeWZFQVZXSzVEc3hOMXFOYWI5dVd0VWc3bkRCb0l1?=
 =?utf-8?B?ZkU3S2VFbm9lT3RQVEdMam5SVzZCUVZxbEJmVURmZEcyOHNnY1R3TStBUmxr?=
 =?utf-8?B?SkRnU3JaSi9QK1I1ZHlraTgyUjJhVXdKTVp2N0U4aEU3clUvRkNWeGxEM1Jv?=
 =?utf-8?B?d1BndlV3eC82cFA5enlza3ZrS0JBK05POEhkUU0wTENVWS9ENm9IZWtCQlUw?=
 =?utf-8?B?Vzk1TVR4VVdvdnpLOTNoS2RITVczTzlpdEF5b1BGbUk3dkZIK2dtbDRZeFlm?=
 =?utf-8?B?T29iV1JlRE91VVlYeWE4ZmE5amVMZWh5eXlFTE5SVHRVWmtwTjhzcEFxeWV1?=
 =?utf-8?B?UEQwcGpCVnZQeHp3RWJ0ZTUvRXV3ODk2WlFjc0poV24yMiswMWh4WEY3U1l0?=
 =?utf-8?B?M1lIU1ZQdENEWDI3aU10S0RyYnRDcHFxcm14M3V6WXUyOHA2UFA0SFJDWHBj?=
 =?utf-8?B?bHV6dUVheGNXcmEwUzFNVjhpZnhxUkprdFVzU0VwdUdxOExDbmxQcFpidWZI?=
 =?utf-8?B?T3oxUkdJeHRJUzIyYnA5Um9acnI0bnFhYTlzbFB4VmFXUWk5NjJ1aURUSHVU?=
 =?utf-8?B?R08rQm9EZzVFMHU1SkxxcXZXU29WMTdUTERkLzl3eVl3OGxiNTcrb29aWFhW?=
 =?utf-8?Q?RHKDd7MC3eUgcPRDYm3MF0U5P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 698da8ad-c250-4449-2490-08db71a875d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 16:07:34.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gq4lhwEHfwGJDnnBKBGzkdTtkrCVAi38Ixoy/Lsb12WahX1yWtD44uM/Bjqv4SLofaSPQc0lLXJ/o1dDDjIVjqjk56S+ZkC2BA1yQWJwF5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxNiwgMjAy
MyAxOjQ4IFBNDQo+IFRvOiBFcnRtYW4sIERhdmlkIE0gPGRhdmlkLm0uZXJ0bWFuQGludGVsLmNv
bT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgYmNyZWVsZXlAYW1kLmNvbTsNCj4gZGFuaWVsLm1hY2hvbkBtaWNyb2No
aXAuY29tOyBzaW1vbi5ob3JtYW5AY29yaWdpbmUuY29tDQo+IFN1YmplY3Q6IFJlOiBbSW50ZWwt
d2lyZWQtbGFuXSBbUEFUQ0ggaXdsLW5leHQgdjUgMDUvMTBdIGljZTogcHJvY2VzcyBldmVudHMN
Cj4gY3JlYXRlZCBieSBsYWcgbmV0ZGV2IGV2ZW50IGhhbmRsZXINCj4gDQo+IE9uIDYvMTUvMjAy
MyA5OjI5IEFNLCBEYXZlIEVydG1hbiB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGlj
IHZvaWQNCj4gPiAraWNlX2xhZ19tb25pdG9yX3JkbWEoc3RydWN0IGljZV9sYWcgKmxhZywgdm9p
ZCAqcHRyKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbmV0ZGV2X25vdGlmaWVyX2NoYW5nZXVwcGVy
X2luZm8gKmluZm87DQo+ID4gKwlzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2Ow0KPiA+ICsJc3Ry
dWN0IGljZV9wZiAqcGY7DQo+ID4gKw0KPiA+ICsJaW5mbyA9IHB0cjsNCj4gPiArCW5ldGRldiA9
IG5ldGRldl9ub3RpZmllcl9pbmZvX3RvX2RldihwdHIpOw0KPiA+ICsNCj4gPiArCWlmIChuZXRk
ZXYgIT0gbGFnLT5uZXRkZXYpDQo+ID4gICAJCXJldHVybjsNCj4gPiAtCX0NCj4gPg0KPiA+ICAg
CWlmIChpbmZvLT5saW5raW5nKQ0KPiA+IC0JCWljZV9sYWdfbGluayhsYWcsIGluZm8pOw0KPiA+
ICsJCWljZV9jbGVhcl9yZG1hX2NhcChwZik7DQo+ID4gICAJZWxzZQ0KPiA+IC0JCWljZV9sYWdf
dW5saW5rKGxhZywgaW5mbyk7DQo+ID4gLQ0KPiA+IC0JaWNlX2Rpc3BsYXlfbGFnX2luZm8obGFn
KTsNCj4gPiArCQlpY2Vfc2V0X3JkbWFfY2FwKHBmKTsNCj4gDQo+IHBmIGlzbid0IGJlaW5nIGFz
c2lnbmVkLiBDbGFuZyByZXBvcnRzOg0KDQpGaXhlZCAtIGNoYW5nZXMgb3V0IGluIHY2DQoNCj4g
DQo+ICsuLi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xhZy5jOjY1NzoyMjog
d2FybmluZzogdmFyaWFibGUNCj4gJ3BmJyBpcyB1bmluaXRpYWxpemVkIHdoZW4gdXNlZCBoZXJl
IFstV3VuaW5pdGlhbGl6ZWRdDQo+ICsgICAgICAgICAgICAgICAgaWNlX2NsZWFyX3JkbWFfY2Fw
KHBmKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCj4gKy4uL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfbGFnLmM6NjQ4OjE5OiBub3RlOiBpbml0
aWFsaXplDQo+IHRoZSB2YXJpYWJsZSAncGYnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nDQo+ICsg
ICAgICAgIHN0cnVjdCBpY2VfcGYgKnBmOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIF4N
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgPSBOVUxMDQo+ICsxIHdhcm5pbmcgZ2VuZXJh
dGVkLg0KPiANCj4gPiAgIH0NCj4gPg0KPiA+ICAgLyoqDQoNCg==

