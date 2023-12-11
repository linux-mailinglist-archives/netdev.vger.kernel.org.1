Return-Path: <netdev+bounces-56086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E199480DCC0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A9B216D4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340CB54BF5;
	Mon, 11 Dec 2023 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMw4hgMm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D0D0
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702329354; x=1733865354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hb2Sp4Tp7QoSiKN1sh+kZwsb/U7uqHmLMNXDxzP7gRM=;
  b=LMw4hgMmH8IyDnNr828mYUG7nk5jFg58ZXWDWQ1xTM+4japIPM64/OzZ
   +ocrD36Rsks13VqAze0q+ToDElvAfgOsgjb6EeJiRPYNusLElnmWe2TTV
   NfgB2h0J2g+SGmo6dQCkHEeYqx/ULHj3hiNvAHdn0XG7Na3zuUFnQ/rB1
   k4Kvc2/TGJ6GHl7RyArMQ1gPI9IFIbdrf0HCG9FMyAIZ787p/uhCWGzMy
   CesikTSeE4lC9KiPHar04/sBLZLMaj+41Noi07aUlWDvjngNGYWgjneCj
   UB6Vxb3brbGY9+v6GzUIJ539n12aC415VUF3uHYfMAM28ezuiBxiVA6dm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="398559308"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="398559308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 13:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="891310761"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="891310761"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 13:15:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 13:15:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 13:15:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 13:15:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv2YotBk+65YWVK7Ha3mSv61kMXkQoQ8Qg1i5NeTUmudRRYWCZKzkInj6JwgLUzkJAkyhisOFRG5lqkYpkOlxhUoEVoTW68hjsUFX8WZEG5pVWOWXoQoGcufp78zySIjKBmU5d2M2kjdLeruOVeLEUBqDsts1rJoffuM28JltkGf4jThIcbrAWQvaAnjf4HObiooxXZXh4UKBfRkc/i8Hz20vHP6L0hRMtc17jK28mIILjqI1H/Nuhc8zn0/+jzqR9qaZibM2/snrDqMYm9I32PKgz7n/XxKtdrJaqEByzpev1hLg/ApmACeqtlCv1KnbKosnYOav60g6w/EiYN+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hb2Sp4Tp7QoSiKN1sh+kZwsb/U7uqHmLMNXDxzP7gRM=;
 b=OQ0d9h0Xx0QggTeNzTEWScz2FP74buJevTvN3BZz7oQXA5mHUszqVK38B2xuiRU3AnpvA/63zMeLib0XvHLHxYziwOTVQ8CaiHFoVsfyWCOpOXZJ/GVZdnS+D6RZQc0Rcpn2fJnU7DJoBpkjTmmgpacqLSFDwBIOpwgeskvJoukUgmxqIga/t79Q9YWKj/ndxGMZqMtNh63YoNRHoGXx91mV7Q8BWICWBNbQ2RhsyJaXB8fYagwcuJ45VEt7OA5udv2HDDTO1IdFlVDprpr1TSI+CERoPdofuWTP9RKhTQpNn6y16NIt7MtB7PD6oibxtJ18aaGEuvM24cYqsqxefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5811.namprd11.prod.outlook.com (2603:10b6:303:198::18)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 21:15:10 +0000
Received: from MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de]) by MW5PR11MB5811.namprd11.prod.outlook.com
 ([fe80::f6f9:943e:b38e:70de%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:15:09 +0000
From: "Ertman, David M" <david.m.ertman@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, Jay Vosburgh
	<jay.vosburgh@canonical.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Robert Malz <robert.malz@canonical.com>, Heitor
 Alves de Siqueira <heitor.de.siqueira@canonical.com>
Subject: RE: [PATCH iwl-next] ice: alter feature support check for SRIOV and
 LAG
Thread-Topic: [PATCH iwl-next] ice: alter feature support check for SRIOV and
 LAG
Thread-Index: AQHaKToUXVlzIDYaGEyh4eN8rXhk7rCf5awAgAAR/LCAABMQAIAAA/nwgASMUwCAAACNIA==
Date: Mon, 11 Dec 2023 21:15:09 +0000
Message-ID: <MW5PR11MB5811AD59A4135F5783AB9E93DD8FA@MW5PR11MB5811.namprd11.prod.outlook.com>
References: <20231207182158.2199799-1-david.m.ertman@intel.com>
 <bca6d80f-21de-f6dd-7b86-3daa867323e1@intel.com>
 <MW5PR11MB581150E2535B00AD04A37913DD8AA@MW5PR11MB5811.namprd11.prod.outlook.com>
 <21390.1702078254@famine>
 <MW5PR11MB58115CC6EA72622E87CF586EDD8AA@MW5PR11MB5811.namprd11.prod.outlook.com>
 <c74dd960-7fbf-2c05-5ee3-7e9839b238a9@intel.com>
In-Reply-To: <c74dd960-7fbf-2c05-5ee3-7e9839b238a9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5811:EE_|CH3PR11MB8153:EE_
x-ms-office365-filtering-correlation-id: dff0eeab-d33f-483b-ca0e-08dbfa8e41cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRKPYYOiq6Syq7PyvO1V+g7C0QD9VymSxcqCV2LVoSy4Sr8+NiT8hJ8d8RMqekl72BcgXfy0JzRHta8DCISAl8flO7vn+iLWGa2nVq8wE7XCYCX/w68aDyILnCBvDuUmKXLDd7o/AUEkr4ZTvy6IZjcAQ9+CMit1xxuSKPKOKSZe5K46zbK4UePonJis1NzfCCip2RgTUwYMIzGHkd5H7riwo5m9koPxdSNxDbGquo7KhdT/a6E0HFal9mybF/7nIqgEvXk56PJ/c4iACHgJlsatCaEiJs6/rFwZ4L5dqQZxV20uFjq0d2emeh7LYBEINug42Hjy8wfwPNuxuhWk5K08lz8N2KPpxAvvBwh7+eL3Du5UqAf4I8PfHRgi+NmtdK4SbUJszR9IEt2cl7zPdgaLKYhmyeQ2NrXwNB/KVn4plFoof2eQV7LEM5WY+Z2Pv5COjCIHIwIfuA+qODNoWAPqQXj6qvcTo/BmZXo1wt1r3dB+I7tO9KFfJN1Tr0uN2eKcf0oLp5BqMqdp/hiCog8F1vzKmWgh1TOVX2Y/80kzo9HULoosQjjBPnZSRJ+XlOtwqljHKYiqQfbhp6Ogr5BM0kZdwgCKBtXmJRYOeX2FE133+V8iV2vRIf/3c+dp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5811.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(9686003)(52536014)(53546011)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(4744005)(66946007)(64756008)(66476007)(66556008)(76116006)(54906003)(66446008)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8936002)(8676002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R25ITTdCMS9pTERXaHIvZ0NxOEd3WWxOOTIyY21uM3M3V2xlUTUvWDI5NC9n?=
 =?utf-8?B?OVpOaDByUzNsTlN6Si9ScStNUmhkcGRpYTRsT3JBOTNEUldDNTk5V0UzRUhR?=
 =?utf-8?B?UGV6VGNSK2oxdEpMUzRGNGR3b2pmYXkwalZiMHBCaW9ZQzU3SkZtcnlaeUtR?=
 =?utf-8?B?eWQxckYzU1pvRHRlbjFmdTFKek9WRHlUMEdLYVBtblByd3YrcEU2RFhTZTQ0?=
 =?utf-8?B?ZVMxYllFMHpYclF6UHY3ZG9XSlFlWmtjU0lZZjhKbFRMN1MvZ1ViaUZTNm9M?=
 =?utf-8?B?SkEvczNCZ2lFYkxnQjZ5UUZERTBoQzQ1Q09WdDVuZUhtMnhkSmhGbzlQZHd4?=
 =?utf-8?B?eHpQWWlVWC9RLzkwajd3ZThGL3NyOHR5Zjl3c1J1TmhTMEFaa3hYWHZ1VjI1?=
 =?utf-8?B?c0srbEp2QWZ0Q21SQ0tjQmRSdHdhSnJKL0V3NGxTTXYyTnUyUSswL0xjdENj?=
 =?utf-8?B?YWw1a0ZwSEcyZFFWb0tuODRsZDV1R0tDazRsYjZBZU5rZDdSWDRFTjBhNGZJ?=
 =?utf-8?B?WUVkVzNXRUxHNHdobWZpTFJVR3VxN29hYjVDclJJZjAzWkVMZituUmc3UFRj?=
 =?utf-8?B?ZnJtRFk2d3JDSDNKUFV3Q1p4QzdBTU9sMXNoY1NJZStjdmc1Y0cycnhYZ092?=
 =?utf-8?B?cTZRaGJ1U3VMbFl3RmRSZlpWRDBGVHVuTDV6U21KSnE1UVJuTmx4SmZVVzc0?=
 =?utf-8?B?RzJicGZzUURiakNsMGg2UGlsdGIvL3h0TGxZTmQ3cSsyZEVhaWxQakRDckdo?=
 =?utf-8?B?KzVTNmQ5Y1lmWDRScnFNRXJnZmpsVGhkc1BMVFZOSHFIczFTNmllYU1OQ1hT?=
 =?utf-8?B?bWtJemhyT2swT09ic25JSGQwcnZYbFV0c3QzeFJUQU9RUHExdzBlaytqRFhY?=
 =?utf-8?B?aHlJK0ZNMzRucXNGdE92UjNnQWJaTWVNZ1hMUEhOOFNQcExDOGVRck5CYVZC?=
 =?utf-8?B?NGs3c1B2T28xN2U1cUNFalhmTmtSUXhtMWtCcUg2WDNOOHUvRDhCOGphUUtD?=
 =?utf-8?B?QTRFR3g4dXRLY2lCcUtzQXF4MXVaUVRhS3hXWFJrSENOMkthNXhYWHh2ZjhC?=
 =?utf-8?B?VDYvM1VpYXdZYWt6L3JaMmNBQjQ2TlgwbWxWZk1Pay9ZeDI2dVMvbmFyTmhY?=
 =?utf-8?B?UjJoU0FnekxkbHVWL3BvVkRNZjM3TGprNHFjZnl0NFpVMjFpVFdwZG5BSlNJ?=
 =?utf-8?B?UnNmU0QzeVBKOEpPR0pBdDlONnpuK1l4T3RkOTZsa0RsaTRrR0w0YnNIWHZi?=
 =?utf-8?B?c3U0ZjI4ZUtkWk9qL1RwT0x6RUJRYjZ1Wlg5cWZ4RDJZMjNla3NkaDB4RWVp?=
 =?utf-8?B?Q0FSY0tPTDJQZjJQYkpjbi91T2t5S3UxOFVsV2JJbGhvenR3ei9NNlFYV29n?=
 =?utf-8?B?SFRlc2RNRkpkbUcrKytLNDBzY3BYMzFLK0Y5N0Y2d2o0ZzN2VkZ0R2pwenkv?=
 =?utf-8?B?elp0RFlHdzZCSkIxcE1RcGJheDNqOHFFeW95Mmx4Y2kyczkzNjFUM0ErK3ls?=
 =?utf-8?B?emNxa3B2VGRGUmlWalo5bW9SUW5vdXQ2Mzd0NHFUeVlpNi9HMDArWmZ3bE9h?=
 =?utf-8?B?cCtPZVU4bGlBMVNjVEhaTnBOZklHdk9zdEphQkN4bDNJWnhZbjgyWWNXejFB?=
 =?utf-8?B?V0hsaUgvNldtN3EveTdrckt2Zyt4aXRvVWE4RTZQQncxUFFPZi9nNWtmWldV?=
 =?utf-8?B?TWVBZGh3UHdVMExVaTV3VHM1dXNQK3E3dndLRXU2cUd0MFhaY0pneEFEWlVP?=
 =?utf-8?B?M0hXbGVVaFNGL3QwOFRpWm9SRVAvRk1DTThWMTJOTUpJNXBnUHFMQkFWYTZG?=
 =?utf-8?B?cFQ1cXJlVXRQL2haU2QxeS9CWVc0WGk5cS8zdHpFMzk1bFhJRE5rYWF0N2px?=
 =?utf-8?B?Q2hhM0dBUHNOb2VoUE1qNk5sRjY2cGlBVlFJdmxoK0JGalFPWDdzZWhzQ1F5?=
 =?utf-8?B?VGxtT1d5ZTdHeTFWMVlFTjVQTy9GM2QzNGhCODFuNlp6eDhwWGl6cUk3eGVS?=
 =?utf-8?B?b2JHcVYyTmNpM0lpbWFMRVlVbGl1TWtNQk5vVE9Fa2hXWElGMExScmZXNUQ1?=
 =?utf-8?B?SWR0WjhLZkxwaWtqM0dFUDNvUTJZSDBBcE4xV09Kc1ZpRmFseDRRYm5VZFYy?=
 =?utf-8?Q?TSwBJXTnq46NB51w/7Rls63Qs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dff0eeab-d33f-483b-ca0e-08dbfa8e41cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 21:15:09.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPehNnkI7aoMTfYyHtuIy9BjkCJ8o+TXBX57qU1yVgfB0RrDIzhwHl3IMDHGadZ89Y6ZGr49DdjR+YJRXW8lg10TNA1PtaKYn9e9d0+SQDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZ3V5ZW4sIEFudGhvbnkgTCA8
YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTEs
IDIwMjMgMToxMiBQTQ0KPiBUbzogRXJ0bWFuLCBEYXZpZCBNIDxkYXZpZC5tLmVydG1hbkBpbnRl
bC5jb20+OyBKYXkgVm9zYnVyZ2gNCj4gPGpheS52b3NidXJnaEBjYW5vbmljYWwuY29tPg0KPiBD
YzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmc7IEJyYW5kZWJ1cmcsDQo+IEplc3NlIDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT47IFJv
YmVydCBNYWx6DQo+IDxyb2JlcnQubWFsekBjYW5vbmljYWwuY29tPjsgSGVpdG9yIEFsdmVzIGRl
IFNpcXVlaXJhDQo+IDxoZWl0b3IuZGUuc2lxdWVpcmFAY2Fub25pY2FsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBpd2wtbmV4dF0gaWNlOiBhbHRlciBmZWF0dXJlIHN1cHBvcnQgY2hlY2sg
Zm9yIFNSSU9WIGFuZA0KPiBMQUcNCj4gDQo+IE9uIDEyLzgvMjAyMyAzOjQ2IFBNLCBFcnRtYW4s
IERhdmlkIE0gd3JvdGU6DQo+ID4NCj4gPiAgRnJvbSB5b3VyIGRlc2NyaXB0aW9uLCBpdCBpcyBw
bGF1c2libHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLiAgTG9va3MgbGlrZSB3ZQ0KPiBzaG91bGQg
YWxzbw0KPiA+IHNlbmQgdGhpcyB0byBpd2wtbmV0Lg0KPiA+DQo+ID4gVG9ueSwgZG8geW91IG5l
ZWQgbWUgdG8gZG8gYW55dGhpbmcgdG8gZmFjaWxpdGF0ZSB0aGlzPw0KPiANCj4gVGhpcyBhcHBs
aWVzIG9rIHRvIGl3bC1uZXQgc28gd2UncmUgb2sgaW4gdGhhdCByZWdhcmRzLiBJIGRvIG5lZWQg
YW4NCj4gYWNjb21wYW55aW5nIEZpeGVzIGZvciBuZXQgdGhvdWdoOyBJIGJlbGlldmUgaXQncyBi
YjUyZjQyYWNlZjYgKCJpY2U6DQo+IEFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgZmlybXdhcmUgY2hh
bmdlcyBmb3IgTEFHIik/DQo+IA0KPiBUaGFua3MsDQo+IFRvbnkNCg0KU2VuZGluZyBvdXQgdjIg
LSB0aGFua3MgZm9yIHRoZSBoZWxwIFRvbnkhDQoNCkRhdmVFDQo=

