Return-Path: <netdev+bounces-16934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C274F730
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 19:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522E41C20DCC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088671E507;
	Tue, 11 Jul 2023 17:25:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25B1DDF8
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:25:08 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0887F9
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689096306; x=1720632306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Cm4ergHlIAT2N3C0iEGfCZsIKohDIX/51d1TLRgn/E=;
  b=cblaNSuyK68y7BhMoypctd+CNDpPMJ9/JsQSXw9f1rX+mgyBlgzvBPPP
   Cu/na8rJ1dBEs+dGW7mCDRIZsy2ZrHi5Sfto983kwjv+jDNoxdVutzQd5
   eEIcIHv3I6pNifBTbxOC0CSDHNNrUInCTjA4uLsf1YXty2US/fgN8XU3k
   /ie6zKlbLdDUq9tmi3vFAIzMdhOG6SBn+NEsAsv2I1srA8zZtlCmxObP6
   RrZMnLmJlly4AskrsQD+q2cGP5nfB0llvyQ2fpBwVRmi77GpYVy6DYUBe
   /0NLej/k5ME2dZp6/euaA27NAviSCHrZ3n73WJ3WhuvnhMJ3VuAp9auOE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451047003"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="451047003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698502439"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="698502439"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2023 10:24:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 10:24:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 10:24:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 10:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJCXNnkiu6LeTW8tzHSnCGWfmBXbjlYjygAKb8BPC18mhIWc6gcbt/J8WLxMz2rSTLbB8wEKDfY3w7p2IeKQVLGk731CEwzBVXpionG7cS65YuPKU7w2t3ILTaBAYtQQz/OLN/J1mmC643TU3/fEvj2FI/3WZc148vZgiUH8i21WzfKHQEjAe3DFSwbaNLs7Acd0hjVUClEYnck7X3qDTsMzPccUnVKW+G039MQlL1ITZwdH7fLclG3J79lSDSdvPHBSWnyVMqQ/kqKPD+ALcfHaAuLbWG8TWMVKTY8JVuttc80fpw/iDgLx8LGUvzkU37JFZRMxZjkDkh+fQvidAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Cm4ergHlIAT2N3C0iEGfCZsIKohDIX/51d1TLRgn/E=;
 b=L8USoeOZcuU3dv8YqcNQWZ9Bc+INpCihok/TxYHAvwZtdwlLEeOxJw4/Pem5vjeA0ikVQX4CADc3V1UvgDGOWUXObNnFHXaEtzjm3abSXQ1K7AVCoSjqYjpnxWHvCg3/VFVLFpvc08WWSOloiUlK/7OblkSKUm1A1R+eKyeli3YywRyB9fvdpVpVEBjMmH4RApIuQbaFnshAxvSPzVs5/iw9e3dTssoJuL9GtaZRU1RUXaoxH5Z4MGwmyAIA14UCL6KP5eyWsgwLedaVZ0yQi27coU75qh5Ge+WlKdzwVbaQdvhErOyRWPxwH4rQqtdlFowyVkjMdg02TTsuLUEQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by CYYPR11MB8357.namprd11.prod.outlook.com (2603:10b6:930:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 17:24:37 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::d03f:87c5:d0b2:5860]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::d03f:87c5:d0b2:5860%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 17:24:36 +0000
From: "Wang, Haiyue" <haiyue.wang@intel.com>
To: "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Guo, Junfeng"
	<junfeng.guo@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jeroendb@google.com"
	<jeroendb@google.com>, "pkaligineedi@google.com" <pkaligineedi@google.com>,
	"shailend@google.com" <shailend@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "awogbemila@google.com" <awogbemila@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "yangchun@google.com" <yangchun@google.com>,
	"edumazet@google.com" <edumazet@google.com>, "csully@google.com"
	<csully@google.com>
Subject: RE: [PATCH net] gve: unify driver name usage
Thread-Topic: [PATCH net] gve: unify driver name usage
Thread-Index: AQHZs/miCw7G2w/uXEy0KhXsZbiALK+0zsEw
Date: Tue, 11 Jul 2023 17:24:36 +0000
Message-ID: <BYAPR11MB34956FC76E48D37CF146A657F731A@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <b3e340ea-3cce-6364-5250-7423cb230099@intel.com>
In-Reply-To: <b3e340ea-3cce-6364-5250-7423cb230099@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|CYYPR11MB8357:EE_
x-ms-office365-filtering-correlation-id: d023dba0-43e5-474f-93e0-08db8233b340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bHNyCsBaJwynSfECiJWVZtXuxHqcFCSleQl5qFnQiNRgyQ2IXL66hW5jj0Kz41RjSQcrp8I7WyKbpiDykna6zQstjD12JT622KQBgBTB1BaH7XbDd4fXfuUwOuFbnYbiyPHHwlVIuP4Bjktugsso6JG6FAw8NaLHG1wYxuS9oWnHCvbOHe7RD5eUZkwwCrbMoVLE2PR1PwW2KV/YjTWTXQIJ+r6ojeicQT3CnRXZdPsAdhlx9IlmimWsWIYym+Pw8cLIzKowDLwchSRR7KBX93/9jL0SBGio2ZV2bu0uW8ufaefhug/Jqv+d7+dnR5IcPkh91pxvRWb7m6eBRGQWM/A1S1SP9id373VSL9j0KFr8qHuANvZ64cmf2+WwIAg5R4p4OQCmNTqE/LHN6tZxMvbw6H0UCoUnGwDMGWoLhG1LrwuchA/p9PtVPcRCemi3BEy3R3NjFwMII7ACctTe0bYnarzn6RczUN4ukaRXMgwBZ4W/5sTdMkpPNeQ9fiSXpx5z1rSiAeGC15khG5RbdWj/bSD6f3++Okwq167yjvMSMueEuLon5effAGzveg/7buN2ORIFZg27yrtuBF6UTKy+Rgsx2U3A4IJs+i731qnlz/EQzrc6rOJjdlmjGvrpAbev8Z+mqnewjgFvZ0GGkpMWifXfy2WY+uFyAGFfwM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(38100700002)(82960400001)(38070700005)(86362001)(55016003)(71200400001)(7696005)(110136005)(54906003)(76116006)(66946007)(33656002)(122000001)(6506007)(26005)(186003)(9686003)(53546011)(7416002)(52536014)(2906002)(66476007)(5660300002)(478600001)(66446008)(4326008)(66556008)(8676002)(8936002)(6636002)(83380400001)(316002)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzBFZkR4bUt6aEIrWXRjUHFLVEdoOC9CbVFwZHFpWVZhVitEblR6WVdLb3Fo?=
 =?utf-8?B?U0FSc0wrR0s0a2VmTlZ4dGlRNXU5NGpHMk9yeFR2Y1laM2JPMFRJUjBmMVl0?=
 =?utf-8?B?OWVCSW1ETE9SVmVIUlQ3SEQvaWV2MjVFWmc0OUlGRkRDUWxxYlg0bHY4Tmls?=
 =?utf-8?B?Y29icUxPY05YYXNHWmZyVWJLelM2ZHZiSC96UzFHQ1hvUGw5UDlNQXNhaURw?=
 =?utf-8?B?b1dMRTRtV3BoV0lQbVIxcGd5dEZYa3cvbEhWbnNRM2NHVUtIQnRUa3ErZ0Rw?=
 =?utf-8?B?dTY5RkZ2RDhob3RaWk1nUnBrdTJqVTJzdTdteHNFU0ZVeGZsK05IVHBTNjBz?=
 =?utf-8?B?M2ZncWpnZlBaMnp1NXlpNjIyQS9PbzlkTnB0TDJ2VTZnZWNSelMzRUJLSDFX?=
 =?utf-8?B?SDZjdTFnRHJWcFlhSXRQMFdOMEdJWWNxSTN1c0tTY01NeHJKeW0xTFhiLzF3?=
 =?utf-8?B?TW5Wd2RRM1NHYWFwWjczSjF3bXBQTUxVNjdUU2E5cHdkSDFmMWlueDhQYkhi?=
 =?utf-8?B?WHplZml1Mk1yU3pMTDJoVU9IVTMvbFFEZnczekZRb1o0S1doVXlucEJYL3hF?=
 =?utf-8?B?Y0ZyVWhoMjJEaExHVnNvSjB2T2xiUnU4WFJwaUFKSFJlT3pLNWszci9pblo5?=
 =?utf-8?B?cnJRSHoxKzluOVM3RktzU284a1RFeVVaU1c2SVN6Z0ZXdXdVdTAyaG1xeVg0?=
 =?utf-8?B?RTdLYStrSzk5SWZVWjIzZTZ5YlVTa0l3VjF2eFdUakV4WUxyYXlGMUc2cHdw?=
 =?utf-8?B?NHkwbktjM2RmL1VsTFFUZ1YwK2tiMndTY04zZ3BNMkdRSm9oUUZCT3B6ZUh5?=
 =?utf-8?B?NTJDSmJGQUVsZmRtYy9TNmlWOW1PTHJSaUR4VElrdUd4aDRsUUp0bFRYMVVv?=
 =?utf-8?B?bnE1ZVV4VG1VK1BMSXM2dUNQNUpMb3F3OHpRNVVQZVZzbHJmZUgvRkYrZVpw?=
 =?utf-8?B?Zk1WNDJTajczb0FkejFqbVJYam9DcCtkUHorRmNDalg4LzhxMDNMaXhwNkow?=
 =?utf-8?B?ZEhtalNLZzkyYlJsd29pZjlPZGw3R1NKZGhsLzRoVVJLNFV2ZlozM0kxOTRZ?=
 =?utf-8?B?ZXJXUXoyUWxyUVBYd0dROXdmQXowTVZyQUhvS2RsZkllaGpsb2pLWHZNV2dC?=
 =?utf-8?B?bWl6SCtMeWU1ZWNrTWM4OFpkQ1JQNXdFYTFhVERoVU9vU0lud21Ib1VjdHp6?=
 =?utf-8?B?ZlRGdHhNL25kbUdmY1ZlTkEvVGo5K2lMWS9tNEhpVEdwdkpOSHpObW1XcWVB?=
 =?utf-8?B?a0RpMFFodjJxZzdjMWtnWnAzUCtDR0lvV04xVVcrTmx6RG5SM3FkYzkwY2JI?=
 =?utf-8?B?cWg3M2tLbEh5MitsQVZuM29lQ1ZVRTFvMWY0andkbUZGTFh5T2I0bnlJMXox?=
 =?utf-8?B?UGJsMVRmMDZRczhYZ29wMm5zK1RlQzlLUlk4SGFXSnF2M0xnYnNQOFJzbVNL?=
 =?utf-8?B?MnBvMmFzZHhlN1NjbmpEa1VoTzhWeVRSaWlWYmJzckpGdStFbC9NK0k3NTYx?=
 =?utf-8?B?VEV6UFpDRHhwMjRrU29FYnlyRXVxRzRmZmdiNWZnblNMZkpwdHV6M3NyVUV0?=
 =?utf-8?B?d2drMWY4Mk5icmdBSHNWdDc1cHNoYmhkcmRSZE9WV1ZZT3kvc0l3aUtmOU1G?=
 =?utf-8?B?SjVGVHFUNmllSnVsUVo5cmErUTRDN3FCMWp4N25BSHo2NlFHUnVNdzFiaHhu?=
 =?utf-8?B?MEwzTGxCanphZkF1aUc4WVNCMUVyYWMzZTNhVGRVK0dBU0hNSE1JRmpnRXE2?=
 =?utf-8?B?RGY5cFQ2eGh4cE4wQ1RZNWVoL3doL3J2TVNuUFkxMVVMRnJvUXdabTRydXBQ?=
 =?utf-8?B?OC9HQWZPN2dnVTZjYjN2WnJhU3VmU09oZHBhOVBnTFZiOGRON3dZTy9MQzhk?=
 =?utf-8?B?NG4walN3RXpmaEZ5WldSKy9hTVVZTm4vTlNwZ1Zqek9PUXBlTGRvT0RKM2g4?=
 =?utf-8?B?NFdERUdyUjllbGtLUHlIVTlpTjRLRDB2WkRvM1o0Qk9iY254U2JvazE4REFH?=
 =?utf-8?B?Z09FQUlHdlhZSFk2YUZ6bXMrblpua3lrN0Iwd3NNVmdWbHp1bUc2SWd3NUNL?=
 =?utf-8?B?dkIxcU9yVUFhSm5ZVisyTWtpOWR2M1J0bThJUGwxWGFhWHdobUt0NjlTQkFK?=
 =?utf-8?Q?Oh62hOxph3QjoslH+O0tnBxlD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d023dba0-43e5-474f-93e0-08db8233b340
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 17:24:36.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIeuwg+1DsPXVf6UIjdAvQtLvy8zsCo2+qNip9yzP6BRj1brHmK9HG9Cpo4D39+YkhmOibzX9CE1PZszo/0fCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8357
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb2Jha2luLCBBbGVrc2FuZGVy
IDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDEx
LCAyMDIzIDIxOjE0DQo+IFRvOiBHdW8sIEp1bmZlbmcgPGp1bmZlbmcuZ3VvQGludGVsLmNvbT4N
Cj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGplcm9lbmRiQGdvb2dsZS5jb207IHBrYWxp
Z2luZWVkaUBnb29nbGUuY29tOyBzaGFpbGVuZEBnb29nbGUuY29tOyBXYW5nLA0KPiBIYWl5dWUg
PGhhaXl1ZS53YW5nQGludGVsLmNvbT47IGt1YmFAa2VybmVsLm9yZzsgYXdvZ2JlbWlsYUBnb29n
bGUuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgeWFuZ2No
dW5AZ29vZ2xlLmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgY3N1bGx5QGdvb2dsZS5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBuZXRdIGd2ZTogdW5pZnkgZHJpdmVyIG5hbWUgdXNhZ2UNCj4g
DQo+IEZyb206IEp1bmZlbmcgR3VvIDxqdW5mZW5nLmd1b0BpbnRlbC5jb20+DQo+IERhdGU6IEZy
aSwgIDcgSnVsIDIwMjMgMTg6Mzc6MTAgKzA4MDANCj4gDQo+ID4gQ3VycmVudCBjb2RlYmFzZSBj
b250YWluZWQgdGhlIHVzYWdlIG9mIHR3byBkaWZmZXJlbnQgbmFtZXMgZm9yIHRoaXMNCj4gPiBk
cml2ZXIgKGkuZS4sIGBndm5pY2AgYW5kIGBndmVgKSwgd2hpY2ggaXMgcXVpdGUgdW5mcmllbmRs
eSBmb3IgdXNlcnMNCj4gPiB0byB1c2UsIGVzcGVjaWFsbHkgd2hlbiB0cnlpbmcgdG8gYmluZCBv
ciB1bmJpbmQgdGhlIGRyaXZlciBtYW51YWxseS4NCj4gPiBUaGUgY29ycmVzcG9uZGluZyBrZXJu
ZWwgbW9kdWxlIGlzIHJlZ2lzdGVyZWQgd2l0aCB0aGUgbmFtZSBvZiBgZ3ZlYC4NCj4gPiBJdCdz
IG1vcmUgcmVhc29uYWJsZSB0byBhbGlnbiB0aGUgbmFtZSBvZiB0aGUgZHJpdmVyIHdpdGggdGhl
IG1vZHVsZS4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBAIC0yMjAwLDcgKzIyMDEsNyBAQCBzdGF0
aWMgaW50IGd2ZV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9k
ZXZpY2VfaWQgKmVudCkNCj4gPiAgCWlmIChlcnIpDQo+ID4gIAkJcmV0dXJuIGVycjsNCj4gPg0K
PiA+IC0JZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCAiZ3ZuaWMtY2ZnIik7DQo+ID4g
KwllcnIgPSBwY2lfcmVxdWVzdF9yZWdpb25zKHBkZXYsIGd2ZV9kcml2ZXJfbmFtZSk7DQo+IA0K
PiBJIHdvbid0IHJlcGVhdCBvdGhlcnMnIGNvbW1lbnRzLCBidXQgd2lsbCBjb21tZW50IG9uIHRo
aXMuDQo+IFBhc3NpbmcganVzdCBkcml2ZXIgbmFtZSB3aXRoIG5vIHVuaXF1ZSBpZGVudGlmaWVy
cyBtYWtlcyBpdCB2ZXJ5DQo+IGNvbmZ1c2luZyB0byByZWFkIC9wcm9jL2lvbWVtIGV0IGFsLg0K
PiBJbWFnaW5lIHlvdSBoYXZlIDIgTklDcyBpbiB5b3VyIHN5c3RlbS4gVGhlbiwgaW4gL3Byb2Mv
aW9tZW0geW91IHdpbGwgaGF2ZToNCj4gDQo+IGd2ZSAweDAwMDAxMDAwLTB4MDAwMDIwMDANCj4g
Z3ZlIDB4MDAwMDQwMDAtMHgwMDAwNTAwMA0KPiANCg0KTG9va3MgbGlrZSwgaW4gcmVhbCB3b3Js
ZCwgaXQgaXMgUENJIEJBUiB0cmVlIGxheWVycywgdGFrZSBJbnRlbCBpY2UgYXMgYW4gZXhhbXBs
ZToNCg0KZXJyID0gcGNpbV9pb21hcF9yZWdpb25zKHBkZXYsIEJJVChJQ0VfQkFSMCksIGRldl9k
cml2ZXJfc3RyaW5nKGRldikpOw0KDQozYjQwMDAwMDAwMDAtM2I3ZmZmZmZmZmZmIDogUENJIEJ1
cyAwMDAwOmI3DQogIDNiN2ZmYTAwMDAwMC0zYjdmZmU0ZmZmZmYgOiBQQ0kgQnVzIDAwMDA6YjgN
CiAgICAzYjdmZmEwMDAwMDAtM2I3ZmZiZmZmZmZmIDogMDAwMDpiODowMC4wICAgPC0tLSBEaWZm
ZXJlbnQgTklDLCBoYXMgZGlmZmVyZW50IEJERg0KICAgICAgM2I3ZmZhMDAwMDAwLTNiN2ZmYmZm
ZmZmZiA6IGljZSAgICAgICAgICA8LS0tIFRoZSByZWdpb24gbmFtZSBpcyBkcml2ZXIgbmFtZS4N
CiAgICAzYjdmZmMwMDAwMDAtM2I3ZmZkZmZmZmZmIDogMDAwMDpiODowMC4wDQogICAgM2I3ZmZl
MDAwMDAwLTNiN2ZmZTAwZmZmZiA6IDAwMDA6Yjg6MDAuMA0KICAgIDNiN2ZmZTAxMDAwMC0zYjdm
ZmU0MGZmZmYgOiAwMDAwOmI4OjAwLjANCg0KZ29vZ2xlL2d2ZS9ndmVfbWFpbi5jOjIyMDM6ICAg
ICBlcnIgPSBwY2lfcmVxdWVzdF9yZWdpb25zKHBkZXYsICJndm5pYy1jZmciKTsNCmhpc2lsaWNv
bi9obnMzL2huczNwZi9oY2xnZV9tYWluLmM6MTEzNTA6ICAgICAgIHJldCA9IHBjaV9yZXF1ZXN0
X3JlZ2lvbnMocGRldiwgSENMR0VfRFJJVkVSX05BTUUpOw0KaGlzaWxpY29uL2huczMvaG5zM3Zm
L2hjbGdldmZfbWFpbi5jOjI1ODg6ICAgICAgcmV0ID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2
LCBIQ0xHRVZGX0RSSVZFUl9OQU1FKTsNCmh1YXdlaS9oaW5pYy9oaW5pY19tYWluLmM6MTM2Mjog
ZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBISU5JQ19EUlZfTkFNRSk7DQppbnRlbC9p
eGdiZXZmL2l4Z2JldmZfbWFpbi5jOjQ1NDQ6ICAgICAgZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9u
cyhwZGV2LCBpeGdiZXZmX2RyaXZlcl9uYW1lKTsNCmludGVsL2l4Z2JldmYvaXhnYmV2Zl9tYWlu
LmM6NDU0NjogICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgInBjaV9yZXF1ZXN0X3Jl
Z2lvbnMgZmFpbGVkIDB4JXhcbiIsIGVycik7DQppbnRlbC9lMTAwLmM6Mjg2NTogICAgICBpZiAo
KGVyciA9IHBjaV9yZXF1ZXN0X3JlZ2lvbnMocGRldiwgRFJWX05BTUUpKSkgew0KaW50ZWwvaWdi
dmYvbmV0ZGV2LmM6MjczMjogICAgICBlcnIgPSBwY2lfcmVxdWVzdF9yZWdpb25zKHBkZXYsIGln
YnZmX2RyaXZlcl9uYW1lKTsNCmludGVsL2lhdmYvaWF2Zl9tYWluLmM6NDg0OTogICAgZXJyID0g
cGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBpYXZmX2RyaXZlcl9uYW1lKTsNCmludGVsL2lhdmYv
aWF2Zl9tYWluLmM6NDg1MjogICAgICAgICAgICAgICAgICAgICJwY2lfcmVxdWVzdF9yZWdpb25z
IGZhaWxlZCAweCV4XG4iLCBlcnIpOw0Kam1lLmM6MjkzOTogICAgIHJjID0gcGNpX3JlcXVlc3Rf
cmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7DQptYXJ2ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml9wZi5j
OjI3OTM6ICAgZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7DQptYXJ2
ZWxsL29jdGVvbnR4Mi9uaWMvb3R4Ml92Zi5jOjUzNDogICAgZXJyID0gcGNpX3JlcXVlc3RfcmVn
aW9ucyhwZGV2LCBEUlZfTkFNRSk7DQptYXJ2ZWxsL29jdGVvbnR4Mi9hZi9tY3MuYzoxNTE2OiAg
ICAgICAgZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7DQptYXJ2ZWxs
L29jdGVvbnR4Mi9hZi9ydnUuYzozMjM4OiAgICAgICAgZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9u
cyhwZGV2LCBEUlZfTkFNRSk7DQptYXJ2ZWxsL29jdGVvbnR4Mi9hZi9jZ3guYzoxODMxOiAgICAg
ICAgZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2LCBEUlZfTkFNRSk7DQoNCg0KPiBDYW4g
eW91IHNheSB3aGljaCByZWdpb24gYmVsb25ncyB0byB3aGljaCBOSUM/IE5vcGUuDQo+IElmIHlv
dSByZWFsbHkgd2FudCB0byBtYWtlIHRoaXMgbW9yZSAidXNlciBmcmllbmRseSIsIHlvdSBzaG91
bGQgbWFrZSBpdA0KPiBwb3NzaWJsZSBmb3IgdXNlcnMgdG8gZGlzdGluZ3Vpc2ggZGlmZmVyZW50
IE5JQ3MgaW4geW91ciBzeXN0ZW0uIFRoZQ0KPiBlYXNpZXN0IHdheToNCj4gDQo+IAllcnIgPSBw
Y2lfcmVxdWVzdF9yZWdpb25zKHBkZXYsIHBjaV9uYW1lKHBkZXYpKTsNCj4gDQo+IEJ1dCB5b3Un
cmUgbm90IGxpbWl0ZWQgdG8gdGhpcy4gSnVzdCBtYWtlIGl0IHVuaXF1ZS4NCj4gDQo+IChhcyBh
IG5ldC1uZXh0IGNvbW1pdCBvYnYpDQo+IA0KPiA+ICAJaWYgKGVycikNCj4gPiAgCQlnb3RvIGFi
b3J0X3dpdGhfZW5hYmxlZDsNCj4gPg0KPiBbLi4uXQ0KPiANCj4gVGhhbmtzLA0KPiBPbGVrDQo=

