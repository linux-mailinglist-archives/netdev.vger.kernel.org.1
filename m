Return-Path: <netdev+bounces-17276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97202750FE5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E70C1C21195
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98220FA3;
	Wed, 12 Jul 2023 17:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31F20F88
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 17:45:10 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D22D1FEC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183902; x=1720719902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hU3g0+pRc62X8WVrPgFJmPUkda9VBFo8OZyfT3tvxzw=;
  b=HjRqCu7nSq6KW8hG3gyfqjVNUclSLttTIC9o8p0svZaia+kDgad/fbvv
   xQwsNliqnbMX6nZBWBBVQWJi+h60lB/7Z/HRoslFR91n8hIPHqraAnU2Q
   6T3YbNL3HrVBJeyPH114ZWAucVAWJUApC37CFfEAbfhu+3WwPtJ1r9cfV
   cxEv0Th14mFx0Mx4lWVWEL9gwO/78bu64yE3Ng9kebmIbGCnp/6amwtgw
   VMM6TmjFRXLWGp/Tb0vm3mltxIzO7In8WXTGk2AbhMyuU/iIAuU06hVwc
   AMD2xm8izNR8Tp9XqVFVVgUpMZNyk/0dz46yRdQJhk/APQMaf5x+43rkr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354873450"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="354873450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="698943244"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="698943244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2023 10:45:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 10:45:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 10:45:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 10:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2i0eekthO1yqcckhvqJ0b4BXSpdD7KJETw5iV8dtxsaMJirL2EpBsvQf97sLWwrRBPrKQEtv2dEcQ1XnYtbkBmO62Sw0W+HHbjYP9b9C/KWUXwaUpei+7Uz8rWgyHxUM6Z8a6MajusNpHtU8BrlsR3eqLsd9xvKK09OaCzbiK7JxPhz6H/MdcIO+KTHseMvrX3sPMb8IUYV0PmHLxmBTsVljNTbjt3htJwx9qoyrbi6DBjfEm27ydICPD7Gimk/GuIbEgofAe9ZtzLZEcA9Wg61dedz5riQdoQLEyghIMUHF4CdkW6uqpA+ePVdSl/Cm8HHc3v8BQY6jvnCO6H7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU3g0+pRc62X8WVrPgFJmPUkda9VBFo8OZyfT3tvxzw=;
 b=S4M6/BAnbOMjCFJHUUPm9BwZIzLvhEfGj6lAPzCMU6U7SbdZNCHpi79rw3iKx1tJg1HgY9zgmpXMUfouIUGIv/sub1bDVyneE0tjJtPGk0sZqxLkh0YjReZNu3g+ZFB6bX0HcbTnvcXgUB8XxQlCgMvlxxwtYrC5QQuS9jZ7mMynMHTYyHSETFjWtbNU7fJa9LpDRi6mKuGlWt+oqg407WWm6iu9SrHdQrmgbuH+aUTzwUoms1wz3WDAhszuAkCSPvWYJTvsW81WuqAoWlAuricbVQ4c+B2aB0nJQgsQ33sbvRhKzXcT/3tcz6IgL/q5g3F4t+2t8P7JausH4s0dkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 17:44:55 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::d03f:87c5:d0b2:5860]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::d03f:87c5:d0b2:5860%6]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 17:44:55 +0000
From: "Wang, Haiyue" <haiyue.wang@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC: "Guo, Junfeng" <junfeng.guo@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jeroendb@google.com" <jeroendb@google.com>,
	"pkaligineedi@google.com" <pkaligineedi@google.com>, "shailend@google.com"
	<shailend@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"awogbemila@google.com" <awogbemila@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yangchun@google.com" <yangchun@google.com>, "edumazet@google.com"
	<edumazet@google.com>, "csully@google.com" <csully@google.com>
Subject: RE: [PATCH net] gve: unify driver name usage
Thread-Topic: [PATCH net] gve: unify driver name usage
Thread-Index: AQHZtOHCDtFOs6z4Z0qE0aH5KdEg9q+2ZgvA
Date: Wed, 12 Jul 2023 17:44:55 +0000
Message-ID: <BYAPR11MB34952904711B92E42EAF3A9CF736A@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <b3e340ea-3cce-6364-5250-7423cb230099@intel.com>
 <BYAPR11MB34956FC76E48D37CF146A657F731A@BYAPR11MB3495.namprd11.prod.outlook.com>
 <8f71d459-85bb-87c2-940e-aa1c36308a11@intel.com>
In-Reply-To: <8f71d459-85bb-87c2-940e-aa1c36308a11@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: b35a5cac-86b4-4e1a-1824-08db82ffb434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YWHOrx/UiWC4/Evu+JWNa34l9/cjIdVlOxfRq04YveCWVXCA4Xf6zUEihPxwXbBfMPZ6ldbvo0Lt5BKteeYNPzso4MTdPww7aWWsBm1P19cJg9zzAz1WAlMjRGbqg+2IqWPxqUobTbPTUKZiz5AXleW+L8H4z/Am+I5wAAIY/fhLNpMUTJqOyMiGMo541fG+jfTBUakotbYOAIcT2UzQkNLp0An4/R7bcceI0qxT9ISUCYnNRTLtHk/5bmTshlGJazRDfO6TvSuZjX1kKPrEYrlAC1aBwjvRFfHbEHypBUsML6h3TU0edDfv64AUZedqYuZPpLCMEItySOcQUHKPI8wqDmg9a5UNmYtoBIV8aKRtw0f4ycUY+KupCDjnwpasui5B7TdjJ7J1OEaNHUAxPDNeZ8EpQx9w712ntGbePhlU5ZYQsgBR7e3igsbFIcfYZKO4UvHU75e1+pIIO1V+6TyoMk5FKNu1XYVOUQTxVt/J+Fxv9+sqMzo3m+l0DbGT0Li1Z1aHQ++VcErz4iuLaLEgIdba6bEKKbDYrWcuUHthYwo89JbGArE/SWEyyiFtI5uQuCKCNOk26SJIt+HP5pI6u2Crd3++ep/xkJtXq8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(9686003)(6862004)(41300700001)(316002)(966005)(8936002)(8676002)(478600001)(54906003)(6636002)(7696005)(4326008)(76116006)(66446008)(66946007)(66556008)(66476007)(64756008)(83380400001)(6506007)(53546011)(7416002)(71200400001)(84970400001)(82960400001)(122000001)(38100700002)(33656002)(38070700005)(86362001)(55016003)(52536014)(26005)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVo3VEk1bEcvc3RrM2VvMm1nb05uWUpHMjU3OXdWbHd3blZSUitDZ0wzVUVV?=
 =?utf-8?B?Mk9DcnJHZ1IraXNYalM4T3ZZcytpdGZzMGpOWHNlQ1Z1TllzUll4YVlsaFVh?=
 =?utf-8?B?RTZqRlZlbStva1huaE56a1gyaDk3eTkrQXBMYW9RK0crY051N291amVVdEI1?=
 =?utf-8?B?Qy92TVVVdk9NOE9pUGdxQUtlemZXbnUrTjdJWFcycTZSeW05ajkvQjBJblBI?=
 =?utf-8?B?RmRENFdIblA2TjdKWDl0NllDeEIxd204TjNEdStKb1hXa1dkT1p0azFwa08x?=
 =?utf-8?B?RDBwTnY1ZjB0TEtoZjV4RURQTTgxdXZONjdVZTc4ZkNwMEFtc25MN2dFZVZ4?=
 =?utf-8?B?ZkJaNmp0SXR5cFpXYWMxT3VyMlRqWFRVRXhKRmJOZ1hKT2lSazFlMDhEU0VY?=
 =?utf-8?B?NFkySmFYanJkY0VzVjIwR0ZCWGFvejZvb3AxN1FoZy9CWFV3MUE1WFkwZGp1?=
 =?utf-8?B?Q3orNUc2cXFWVUtkRVVYQnpjM0NXMkYwd3RCaU90R2dnOVk1ZDVsU1NiSU9H?=
 =?utf-8?B?NzAyMEtyVWJWWitHK0VmdUU5bmdEd1JwVkRkSXNPMmhFcGtWaUhmOWxVQkkz?=
 =?utf-8?B?enlWOFFSSFo4SUVqd2ZXZUxuL2hyYVorY3R2WksvR2dpZWJlVllDeTZHUXN4?=
 =?utf-8?B?RStkY1gyOVJ3V0Z5OFBOR0JlTER0R2Q4V3lvMXBuTXNjRFlYN0JJeG90RXZR?=
 =?utf-8?B?bnpTbVZVdCtpNjZSbWNxSjhTYXEwWWlBdXZBTDlZNkdmNHAxSFgxWWk0UFNI?=
 =?utf-8?B?bkdUWTdrWHdDQ0p4SkpLTDZoK2RJeCtqblBxM2FkTDJzaTl6aHlkaTdUVDZT?=
 =?utf-8?B?ck9ZNm9zT2NIZldQc3drVkdmaGpXS3JwWTgvbnA4Y2daWFNwbiszQ3VZOVB4?=
 =?utf-8?B?WFdWcVJlQmRVRE1yUnZyVTc2RzZmR3B6VlMwZDU4K2I0ZG5XbmtRUFZCdGN3?=
 =?utf-8?B?eUIvc3hJWFNIdkJuZTJXTkhyOEt0bmwwbHhmSVMrZDdRSjFMeGZSRldEVUo1?=
 =?utf-8?B?S1krVDlOeUxSVXlsTDR1WjRtUXc3UG5NVGNoSWJTM3BiT2p4ZURZeHZqWFVB?=
 =?utf-8?B?dTZWU0gwTkIyZ2FLQ3RVblVybTRORE1Bbll4dkJaZmZTTmgxZndGWVNmNW00?=
 =?utf-8?B?RmJrWit2NklwOEt0VFNRNlZ0dVZRMlUrRVlnQXBCMzc5MEFzV2JEdzZUWFh1?=
 =?utf-8?B?MW5CeDBUUmRXT0ZSczM4YUJWcTRnalI0aE94ZDUwMHRoNGFEYXlESFlsUVdu?=
 =?utf-8?B?bnVROWxZellaVzN2R2lrU2RVZC84ZTRKdnFtOVRGTFFGUzVvZGdQM2tFZkUw?=
 =?utf-8?B?QURkRkJyTGE1MkpraGl1NGZOcTM1Yi9uMEw5ZGIwWVByT2NiVTVXL0lRcjhB?=
 =?utf-8?B?NFlIMjBRcmJPKzVUbk9lSDMvYlYrOVdBQy94MHJUbFFZZHNWMitXdmc2aFlI?=
 =?utf-8?B?c1oycFBVaUhkSS9oQXhPT2ZxUU1uMGFBaU5VZmtWRTQ2RVFOengzeFVVcTBn?=
 =?utf-8?B?enN6VXV6T0MyZW9paituNHhoaGs1bHF5SzA1WURhQU5wSHRxNXBhUXdHczRG?=
 =?utf-8?B?ajk4c2Q3L29FY0pHdGpKdEJJVVZLdDllYnpJNEcxZUEzZ0lULzhjUUhrRVlW?=
 =?utf-8?B?SzhXekJqeXNTMXRieUYrQU9JZ3N0KzFPVHJMODVvTk42Q244VzhzRjRzc3BW?=
 =?utf-8?B?YlQ1N0V4bW9jT0Z6eE5VdzhSQU92SVlzR3dxcVd2eXhRbHQxT0JHRmxTcFZz?=
 =?utf-8?B?YkRxcjg1bXRZRktRc2lUUXVOaXhwamdrbVdkWXdjTmp2OU4weWR5WWtJaGhw?=
 =?utf-8?B?Z2RLS1ZWU1piTzc0OTg0VU53Q2pqQ2NFOXFNS3FOTEZnd3lCTXc4TzY3VnVP?=
 =?utf-8?B?T3ZuZ0JUQk5ZTWNMRDhPcUNLVXJyczJyT2pNc3N1REp3REtXK2M4VGU3cG00?=
 =?utf-8?B?Z0x5dUtEV0JROGdEWDBHbVRTZjZZakxwald1SXhkRmxWMHJST1pYSXI0Nmdu?=
 =?utf-8?B?dFlPejBuS0tneHZMY3NoY284TWwwRUdueHNpVTNKUFlRZG5CTERlMDBhK3pq?=
 =?utf-8?B?MzI3NStlbjVERmRFem1LcGhlbTk1c2Ftc0NKL2t6dzY3YnIraVVIS0tRa2pG?=
 =?utf-8?Q?HiDL9kj7RO916jsa8N0wMGjOv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35a5cac-86b4-4e1a-1824-08db82ffb434
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 17:44:55.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HPJ2aNhX2pZvg05bbFbiRX88vQO8cx3mBqIIz11Hiyfu+0+TZ+dqfF4w1B6rvkWcdW+Yq6Yu0kG3QOgK17A8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2Jha2luLCBBbGVrc2FuZGVy
IDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAx
MywgMjAyMyAwMDo1NQ0KPiBUbzogV2FuZywgSGFpeXVlIDxoYWl5dWUud2FuZ0BpbnRlbC5jb20+
DQo+IENjOiBHdW8sIEp1bmZlbmcgPGp1bmZlbmcuZ3VvQGludGVsLmNvbT47IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGplcm9lbmRiQGdvb2dsZS5jb207DQo+IHBrYWxpZ2luZWVkaUBnb29nbGUu
Y29tOyBzaGFpbGVuZEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IGF3b2diZW1pbGFAZ29v
Z2xlLmNvbTsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhhdC5jb207IHlhbmdj
aHVuQGdvb2dsZS5jb207IGVkdW1hemV0QGdvb2dsZS5jb207IGNzdWxseUBnb29nbGUuY29tDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBndmU6IHVuaWZ5IGRyaXZlciBuYW1lIHVzYWdlDQo+
IA0KPiBGcm9tOiBXYW5nLCBIYWl5dWUgPGhhaXl1ZS53YW5nQGludGVsLmNvbT4NCj4gRGF0ZTog
VHVlLCAxMSBKdWwgMjAyMyAxOToyNDozNiArMDIwMA0KPiANCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3NhbmRlci5s
b2Jha2luQGludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVseSAxMSwgMjAyMyAyMTox
NA0KPiA+PiBUbzogR3VvLCBKdW5mZW5nIDxqdW5mZW5nLmd1b0BpbnRlbC5jb20+DQo+ID4+IENj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBqZXJvZW5kYkBnb29nbGUuY29tOyBwa2FsaWdpbmVl
ZGlAZ29vZ2xlLmNvbTsgc2hhaWxlbmRAZ29vZ2xlLmNvbTsgV2FuZywNCj4gPj4gSGFpeXVlIDxo
YWl5dWUud2FuZ0BpbnRlbC5jb20+OyBrdWJhQGtlcm5lbC5vcmc7IGF3b2diZW1pbGFAZ29vZ2xl
LmNvbTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gPj4gcGFiZW5pQHJlZGhhdC5jb207IHlhbmdj
aHVuQGdvb2dsZS5jb207IGVkdW1hemV0QGdvb2dsZS5jb207IGNzdWxseUBnb29nbGUuY29tDQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0XSBndmU6IHVuaWZ5IGRyaXZlciBuYW1lIHVzYWdl
DQo+ID4+DQo+ID4+IEZyb206IEp1bmZlbmcgR3VvIDxqdW5mZW5nLmd1b0BpbnRlbC5jb20+DQo+
ID4+IERhdGU6IEZyaSwgIDcgSnVsIDIwMjMgMTg6Mzc6MTAgKzA4MDANCj4gPj4NCj4gPj4+IEN1
cnJlbnQgY29kZWJhc2UgY29udGFpbmVkIHRoZSB1c2FnZSBvZiB0d28gZGlmZmVyZW50IG5hbWVz
IGZvciB0aGlzDQo+ID4+PiBkcml2ZXIgKGkuZS4sIGBndm5pY2AgYW5kIGBndmVgKSwgd2hpY2gg
aXMgcXVpdGUgdW5mcmllbmRseSBmb3IgdXNlcnMNCj4gPj4+IHRvIHVzZSwgZXNwZWNpYWxseSB3
aGVuIHRyeWluZyB0byBiaW5kIG9yIHVuYmluZCB0aGUgZHJpdmVyIG1hbnVhbGx5Lg0KPiA+Pj4g
VGhlIGNvcnJlc3BvbmRpbmcga2VybmVsIG1vZHVsZSBpcyByZWdpc3RlcmVkIHdpdGggdGhlIG5h
bWUgb2YgYGd2ZWAuDQo+ID4+PiBJdCdzIG1vcmUgcmVhc29uYWJsZSB0byBhbGlnbiB0aGUgbmFt
ZSBvZiB0aGUgZHJpdmVyIHdpdGggdGhlIG1vZHVsZS4NCj4gPj4NCj4gPj4gWy4uLl0NCj4gPj4N
Cj4gPj4+IEBAIC0yMjAwLDcgKzIyMDEsNyBAQCBzdGF0aWMgaW50IGd2ZV9wcm9iZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4gPj4+ICAJ
aWYgKGVycikNCj4gPj4+ICAJCXJldHVybiBlcnI7DQo+ID4+Pg0KPiA+Pj4gLQllcnIgPSBwY2lf
cmVxdWVzdF9yZWdpb25zKHBkZXYsICJndm5pYy1jZmciKTsNCj4gPj4+ICsJZXJyID0gcGNpX3Jl
cXVlc3RfcmVnaW9ucyhwZGV2LCBndmVfZHJpdmVyX25hbWUpOw0KPiA+Pg0KPiA+PiBJIHdvbid0
IHJlcGVhdCBvdGhlcnMnIGNvbW1lbnRzLCBidXQgd2lsbCBjb21tZW50IG9uIHRoaXMuDQo+ID4+
IFBhc3NpbmcganVzdCBkcml2ZXIgbmFtZSB3aXRoIG5vIHVuaXF1ZSBpZGVudGlmaWVycyBtYWtl
cyBpdCB2ZXJ5DQo+ID4+IGNvbmZ1c2luZyB0byByZWFkIC9wcm9jL2lvbWVtIGV0IGFsLg0KPiA+
PiBJbWFnaW5lIHlvdSBoYXZlIDIgTklDcyBpbiB5b3VyIHN5c3RlbS4gVGhlbiwgaW4gL3Byb2Mv
aW9tZW0geW91IHdpbGwgaGF2ZToNCj4gPj4NCj4gPj4gZ3ZlIDB4MDAwMDEwMDAtMHgwMDAwMjAw
MA0KPiA+PiBndmUgMHgwMDAwNDAwMC0weDAwMDA1MDAwDQo+ID4+DQo+ID4NCj4gPiBMb29rcyBs
aWtlLCBpbiByZWFsIHdvcmxkLCBpdCBpcyBQQ0kgQkFSIHRyZWUgbGF5ZXJzLCB0YWtlIEludGVs
IGljZSBhcyBhbiBleGFtcGxlOg0KPiA+DQo+ID4gZXJyID0gcGNpbV9pb21hcF9yZWdpb25zKHBk
ZXYsIEJJVChJQ0VfQkFSMCksIGRldl9kcml2ZXJfc3RyaW5nKGRldikpOw0KPiA+DQo+ID4gM2I0
MDAwMDAwMDAwLTNiN2ZmZmZmZmZmZiA6IFBDSSBCdXMgMDAwMDpiNw0KPiA+ICAgM2I3ZmZhMDAw
MDAwLTNiN2ZmZTRmZmZmZiA6IFBDSSBCdXMgMDAwMDpiOA0KPiA+ICAgICAzYjdmZmEwMDAwMDAt
M2I3ZmZiZmZmZmZmIDogMDAwMDpiODowMC4wICAgPC0tLSBEaWZmZXJlbnQgTklDLCBoYXMgZGlm
ZmVyZW50IEJERg0KPiA+ICAgICAgIDNiN2ZmYTAwMDAwMC0zYjdmZmJmZmZmZmYgOiBpY2UgICAg
ICAgICAgPC0tLSBUaGUgcmVnaW9uIG5hbWUgaXMgZHJpdmVyIG5hbWUuDQo+IA0KPiBJIGRpZG4n
dCBzYXkgSW50ZWwgZHJpdmVycyBkbyB0aGF0IGJldHRlciDCr1xfKOODhClfL8KvDQo+IA0KPiBX
aHkgcmVseSBvbiB0aGF0IHRoZSBrZXJuZWwgb3Igc29tZXRoaW5nIGVsc2Ugd2lsbCBiZWF1dGlm
eSB0aGUgb3V0cHV0DQo+IGZvciB5b3Ugb3IgdGhhdCB0aGUgdXNlciB3b24ndCBkbyBgZ3JlcCA8
ZHJ2bmFtZT4gL3Byb2MvaW9tZW1gIG9yDQo+IHNvbWV0aGluZyBlbHNlPyBPciBkbyB0aGF0IGp1
c3QgYmVjYXVzZSAibG9vaywgaXQncyBkb25lIHRoZSBzYW1lIHdheSBpbg0KPiBvdGhlciBkcml2
ZXJzIiwgd2hpY2ggd2VyZSB0YWtlbiBpbnRvIHRoZSB0cmVlIHllYXJzIGFnbyBhbmQgc29tZXRp
bWVzDQo+IHdpdGggbm8gZGV0YWlsZWQgcmV2aWV3Pw0KPiBUaGVyZSBhcmUgZWZmb3J0c1swXSB0
aW1lIHRvIHRpbWVbMV0gdG8gY29udmVydCBwcmVjaXNlbHkgd2hhdCB5b3UgYXJlDQo+IGRvaW5n
IGludG8gd2hhdCBJJ20gYXNraW5nIGZvci4gRG8gdGhleSBleGlzdCBieSBtaXN0YWtlIG9yLi4u
Pw0KPiANCj4gKHRoZSBzZWNvbmQgbGluayBhbHNvIHNob3dzIHRoYXQgZXZlbiBwY2lfbmFtZSgp
IGlzIG5vdCBlbm91Z2ggd2hlbiB5b3UNCj4gIG1hcCBzZXZlcmFsIEJBUnMgb2YgdGhlIHNhbWUg
ZGV2aWNlLCBidXQgdGhhdCdzIG5vdCB0aGUgY2FzZSB0aGlzIHRpbWUpDQo+IA0KDQo+ID4+DQo+
ID4+IFRoYW5rcywNCj4gPj4gT2xlaw0KPiANCj4gWzBdDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtDQo+IG5leHQuZ2l0L2NvbW1p
dC8/aWQ9MGFmNmUyMWVlZDI3NzhlNjgxMzk5NDEzODk0NjBlMmEwMGQ2ZWY4ZQ0KPiBbMV0NCj4g
aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51
eC0NCj4gbmV4dC5naXQvY29tbWl0Lz9pZD0zNWJkOGMwN2RiMmNlOGZkMjgzNGVmODY2MjQwNjEz
YTRlZjk4MmU3DQoNCkkgc2VlLCB5ZXMsIG1ha2luZyBzZW5zZSB0byBiZWF1dGlmeSB0aGUgb3V0
cHV0LCBhbmQgaXMgbmljZSBmb3IgJ2dyZXAgLi4nDQp0byBkZWJ1ZyBxdWlja2x5LCB0aGFua3Mg
Zm9yIHNoYXJpbmcgbW9yZSBleHBlcmllbmNlLiA6LSkNCg0KPiBUaGFua3MsDQo+IE9sZWsNCg==

