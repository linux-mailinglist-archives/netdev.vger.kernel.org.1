Return-Path: <netdev+bounces-57577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B322813738
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34B7B212CC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC9463DD5;
	Thu, 14 Dec 2023 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKHfU3UF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90AA0
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702573534; x=1734109534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vA90DD2mRyueIbivYnWSNLXrgftLRiG4jITfsLshRM=;
  b=nKHfU3UFXVucd/Fs/P0KUrcPEA7pLiYHNHAidTMS4Uc+IunQQkIfRYMU
   xLYjTF0ShucpQNl7BlzGh9b89Aoh26AoP4pKLmXK4tqZvOHpAetHlPEX0
   hI04q7UzbxonrONKSGUXOB6OtE85nbx2wP1CjNTGqx/4VzBeqf5iblH7t
   T0E2F1mJD15k2tBsNdgGBU+aZbfw808w2uhKpUx/lGYPeVFZroxXwBpDz
   D1M/sE1VbS4sUoiq3rDm7fNk6GOfSwpr2c7hr0AElrWNem0p9oMo9/M4w
   CMxsbPYmQKHFkn5OYdGfdLqjUVflkBfD/1GFCBwXQ/m3ySXhuGz897gYQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="481341417"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="481341417"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897802005"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="897802005"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 09:05:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 09:05:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 09:05:33 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 09:05:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 09:05:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGuy6Pyua8115TDSazlxCnSTTib/fI58lwrjmzDjDH9A1xZ8TXJ2vr2Z46RPQ3UB8581xOR4REloERcmDmHQ1QsT6N+UQuWsr/ZdrU/AMq0VZuuXQI+ZGTTF65FkZVimkMSUk+DMEA0Ba/DSDq48KWGXOKuPyYU2SMuLbw1Alagu1q3hPP1Yt+w+jfZ5DtgYFlpldSYNJ9tcJuzRPhZ5pjeD7/583mysJ5cuAmacL2a8XmOoBOJ5Dk9ezKc7RYRzAajo7p7takr8NekP/nWImsll7bnSD+rl6p34Vf3CZavx4smkjj5zqhVYqEvSL3/Mp1iwlnhUbj5vB4tgjLx6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vA90DD2mRyueIbivYnWSNLXrgftLRiG4jITfsLshRM=;
 b=SEJO0qUiabE50G68rUfCc4kF/zNQqs0qxuasauiyJrwDZoOWtl2vQvjt5VkyaWYCsFhBrOQr739KiGNpa46EkgyGxZQyFk+Hg/T5eTskc4dn2Y+AaETjg4FmWCVPBeO63yv/J3Xb0RAYnmPBHwAZEGBFhjcTvkDCn1x9rV0+JwFsNsOqM4a6De4IMr268N7pOe+HyF/VJVCb6UDAjry/L5IO1dzqnJdX0qD52ztiUer2oYpPFAMe0/h2B2AtvsdRTHdA3CAZKPNcTONREP94kxIASUBPpgqC5/T6o6QIimWxEzHr4+kp9IRfjRHwW1ss1zhq++z2PxAxOdeJJekFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Thu, 14 Dec
 2023 17:05:28 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::a418:4b7b:4567:eba9]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::a418:4b7b:4567:eba9%7]) with mapi id 15.20.7091.030; Thu, 14 Dec 2023
 17:05:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] i40e: add trace events related
 to SFP module IOCTLs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] i40e: add trace events
 related to SFP module IOCTLs
Thread-Index: AQHaLpdF8v2kFFa/PE+8XBRQIzxqILCo1BYAgAAs5dA=
Date: Thu, 14 Dec 2023 17:05:28 +0000
Message-ID: <SJ0PR11MB5866232ACD93F2E2AF880F12E58CA@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20231214141012.224894-1-aleksandr.loktionov@intel.com>
 <ed0ebf46-1c24-45d1-a841-7733a3b70966@molgen.mpg.de>
In-Reply-To: <ed0ebf46-1c24-45d1-a841-7733a3b70966@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: 650fa8d7-f244-493f-90f6-08dbfcc6df92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98u0Bu7Z8TeV17GqT8kqDv/aOF0wOWmcNx7cnja7iW6wCElvO7e1mvwdbG5iBabgtKSQhiQxE7MWEUi9uE5pr7S8z7bkWtmgc1N1tGFNLaTDjYjMJi3hyL5f385QZmJ/I9IGO3tQF+ELyDdf2/gnp6uEvOCie+EPCffYF4cmXp3c9Mc7J2GIraS3K+5bPWxyLVdJYHBoQ279oecE0isB08EK70FJrNHUgZLod6exRKks5j+kT54+zNBKS+DvM+iFg9g0oM3++uMbIQJuHjZ1YY0JsZWIxbxi3tqkTgvkSAoIzFv4fl7WIYGL/yzzcthA+f+tWJqWbjIMRVx4jctcCSf5RHp3YArk/VmtKrT4zkFDWExlkRSxraySAhau5gKRdn8EY6AMdEiBkqjpubxix4/1FU8lr0eqVQt/PPATBRiey/QTnuzKX/TniCR0yrtw1qq8hyy2pwhWYZ4rejsXhKYewTPL1F3KVCIJZeLtfL5EtmCI1N6BHmMqHIIaVyEO3/XHVwvWBVTMlkDwtOBjtADcb74oh73p3NF3J7OSdvl4qKYVAx4EJk11r9Tckl5g3T99emsDS0RA5rPh2lq7hfiaVwLh2NP/hv4sWumDLzwRXeAOrOswK2Lcd8d8h8n9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(52536014)(86362001)(2906002)(4326008)(8676002)(5660300002)(38070700009)(41300700001)(33656002)(6506007)(7696005)(53546011)(26005)(122000001)(9686003)(71200400001)(8936002)(478600001)(38100700002)(83380400001)(55016003)(107886003)(76116006)(66946007)(66446008)(316002)(6916009)(54906003)(64756008)(66476007)(66556008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW9uYjBxbEFkZFRVdDhiODJGQzdoZmxkNjMrcnczODl0d3ozdUU5WjVlSEtu?=
 =?utf-8?B?K0hhVjVjOHlyejBiUXN4dlBQZyszY1Arc0tlYWRlRm9QbEFZdHkybElhR3NS?=
 =?utf-8?B?Vk1GeFJGMVkwMHZQMXhyRHRoODVuZ3lkVWQ3THlDTS9Ybmd6U3lCUTVSYzlr?=
 =?utf-8?B?d05IckhSTjFZN1hPSEpmTlAxY2xKdFBVcHlsbEZESEZFOW1keDdiSnNGMFd1?=
 =?utf-8?B?V3Y2UzBVSDFubno4QkRQdXhpaHNWQXFWdnZPMXRzSC81UzJ1VWtnZ2ErQi9l?=
 =?utf-8?B?MjIzR3czQy9EWTNsZDM2akJLN0F6WGNGbmMwS2R6amkzSEZiTzFsOWlqMzl2?=
 =?utf-8?B?Vit1UVdqWHVNK2ttN1pMLzRTZ3VoY0svS1R4U0xobUwzOVV3U2hnNEF6bVRT?=
 =?utf-8?B?S204cm5RZXZ0NndrSUFlTHltc0RNQ3Z4MTBHcWw0b2owYjdwT0ZIbXg5ZWoz?=
 =?utf-8?B?dFRCRkhoNERCajRjOHpEc0Q3TkIxbVZRVitnT0sxVHRVdTBBdzMvOUpYdm1Y?=
 =?utf-8?B?RFBmMFJBb3NESXN6azRjL3h1d0VPN2VvcE5teUZJVUZWVVpXMDhYT3lPcWF6?=
 =?utf-8?B?bHRVYXltSnhRaisybk9Nc2tYaXRtZ0FyRnlPbVd4bDd2VG1KVHFnblhwMmI5?=
 =?utf-8?B?dVNuMnhqWWo3Q0VDZWVDZGhzT3F6ZFFKNjRZamI2R1VIendkMEtzYTdWSk9o?=
 =?utf-8?B?cEVVZDl4RDBMTFJKcEhVUjQ2bGZlUFhKRThnUTlMYU9YSTJzdkxpbzlJNjZz?=
 =?utf-8?B?NEIvK2N5MENrVFQ1Wk56SkFMWE9OODE3YmRxdWNIQjRQaTl5T1BqUGdzL0VE?=
 =?utf-8?B?d204OUM3QXczYzdjZFR0elFMd3RQQUt2elFCRjFDdW91VDl1eVZDczEyN0dw?=
 =?utf-8?B?RzRZTmtHRzE5RW15ZmliNGI2ZVlON29VUDlwNlI2V2kxZkVVSXl1OVZvdHIv?=
 =?utf-8?B?RC9yM3VYTU5LZkZvdmY2aDU1N0lmRm9kWFc2QXBGTkY3U1FvQm4xc2N0VWpB?=
 =?utf-8?B?eHBEMG14U0d0ZEFiT2ZPRVBDNS9EVmtMOU1Gb2xGUkRaZWJFZnZGUGFCUTVL?=
 =?utf-8?B?VC9kN09aRzNjZW04SHhtWmtwdVVCcmFlTDJlTCtoQUlkaFZxVTk2NG81SlRH?=
 =?utf-8?B?aEhIT2FDZVRoaHlVWERwTXRDaDRMSG1ucU90R216ajdJbVFjYjU1MHNwU2RD?=
 =?utf-8?B?aDJhdldMQTBiZHNRNWFYWXNVeWIyL05TN3YzeVFJY29ZcFNvOUNEcVduWC9m?=
 =?utf-8?B?QSthc0FuQ1YvUUJ3QnJjQlRuaGs5bm5OUUl3UjFqaHBzQlM2SzZ6RXhjTkt3?=
 =?utf-8?B?YmJkUCtPeUZYdGt6aTdVYXBudWhZSHZXNWxOV2ZlclNUZk50ckdsTFFHSlhx?=
 =?utf-8?B?NnVRMnV4ZGVPcXB3eVJBM1dFTG1EcmI1bE51R0t4SHlvNEozTkRhTHJaQStl?=
 =?utf-8?B?M2VrekVZcTdxVHhhcUh2QUZPWFFkQ0FCK2R6QjRHbUw5ZlUxeGttVmdBQkhE?=
 =?utf-8?B?WHJ5Zk0vQnliKy9TcHBlK0hCdlJQd1A4K2JJYnhab3JTMFlWazZQOERqY2Jv?=
 =?utf-8?B?U29iSzEzbnpUNTdRRGZQOHlnb3VHUVduVFp0Y0djWWtwZ2x0Ri9ZSXdKWHJV?=
 =?utf-8?B?Q0dzMUlpVVJZenh4aVQ0WWZqNGJYbTJUd3R2UVNhc09HRXNCOGVjMTNDaWFp?=
 =?utf-8?B?dS95RXpLeTF1Ti9GcVNXdk5qdU04UXM3dVltRlZMMk80UXE2VTJNcEJxMmts?=
 =?utf-8?B?a3Qwd283aVI1N2hFVmV4dVVSaWtOWVlDLzEzRnljODAzUHpZK3R1ZzlvQjJT?=
 =?utf-8?B?b2R0eFF2ZHlCY1ZnYkJna2RVTm55QkwwMExJSTNCSTJRNENMR3AyQzNkeTFh?=
 =?utf-8?B?UHdzUE9Oa0UvWWtvWFFSQnZJamhnN1BKTFNqa3lONnBTZUFMbGFCcWwweTRh?=
 =?utf-8?B?T0tXRkR4Mk9IeC84Q3RIM3RMTHIxcC9EYnRqalJ3STNmSVJJMmlKQUNtQlov?=
 =?utf-8?B?ZjZ1cXdXZU5nM3VMMGw2NnpQdENIZmZqSndLK2tHSEdPQ3IzSi91TlcveW4z?=
 =?utf-8?B?SWFmclBrUW1hRjlEK25oaDk2K0dKVldjR2dhWXJxVkQ5c2MrbGtETjN0TWtO?=
 =?utf-8?B?R1UxY3V4Qmthb3NDZVRUQ0kyK21rUFZzNEExMDVDa1V1MlpyZ2RURTEwQmh2?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650fa8d7-f244-493f-90f6-08dbfcc6df92
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 17:05:28.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysgjQ+y7p3TlYPARhMNcXWuiaoQUGJBP36yixldvX1Zaqp7xmtsO656vu5ewWBKu2eJPG6XZQcwlZ9PEfenNII08zVuSH9+E6w5mGfQi6hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE0LCAyMDIz
IDM6MjAgUE0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2FuZHIubG9rdGlvbm92
QGludGVsLmNvbT4NCj4gQ2M6IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGlu
dGVsLmNvbT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVs
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCBpd2wt
bmV4dF0gaTQwZTogYWRkIHRyYWNlDQo+IGV2ZW50cyByZWxhdGVkIHRvIFNGUCBtb2R1bGUgSU9D
VExzDQo+IA0KPiBEZWFyIEFsZWtzYW5kciwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIg
cGF0Y2guDQo+IA0KPiANCj4gQW0gMTQuMTIuMjMgdW0gMTU6MTAgc2NocmllYiBBbGVrc2FuZHIg
TG9rdGlvbm92Og0KPiA+IEFkZCB0cmFjZSBldmVudHMgcmVsYXRlZCB0byBTRlAgbW9kdWxlIElP
Q1RMcyBmb3INCj4gdHJvdWJsZXNob290aW5nLg0KPiANCj4gTWF5YmUgbGlzdCB0aGUgdGhyZWUg
ZXZlbnRzPyBNYXliZSBldmVuIGEgdXNhZ2UgZXhhbXBsZS4NClRoZXJlIGlzIG5vdGhpbmcgZXNw
ZWNpYWwgYWJvdXQgc3RhcnQgdG8gdXNlIG5ldyBldmVudHMsIHRoZXkgc3RhcnQgdG8gYmUgdHJh
Y2VkIGlmIHlvdSB0cmFjZSBpb2N0bHMuDQoNCg0KPiANCj4gPiBSaWV3ZWQtYnk6IFByemVtZWsg
S2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkDQo+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YNCj4gPGFsZWtzYW5kci5s
b2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgc3JjL0NPUkUvaTQwZV9ldGh0b29s
LmMgfCAgNSArKysrKw0KPiA+ICAgc3JjL0NPUkUvaTQwZV90cmFjZS5oICAgfCAxOCArKysrKysr
KysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3NyYy9DT1JFL2k0MGVfZXRodG9vbC5jIGIvc3JjL0NPUkUvaTQw
ZV9ldGh0b29sLmMNCj4gaW5kZXgNCj4gPiAwODM4NTY2Li5lOWQ5ZDRiIDEwMDY0NA0KPiA+IC0t
LSBhL3NyYy9DT1JFL2k0MGVfZXRodG9vbC5jDQo+ID4gKysrIGIvc3JjL0NPUkUvaTQwZV9ldGh0
b29sLmMNCj4gPiBAQCAtMTA1Nyw2ICsxMDU3LDcgQEAgc3RhdGljIGludCBpNDBlX2dldF9saW5r
X2tzZXR0aW5ncyhzdHJ1Y3QNCj4gbmV0X2RldmljZSAqbmV0ZGV2LA0KPiA+ICAgCWV0aHRvb2xf
bGlua19rc2V0dGluZ3NfemVyb19saW5rX21vZGUoa3MsIHN1cHBvcnRlZCk7DQo+ID4gICAJZXRo
dG9vbF9saW5rX2tzZXR0aW5nc196ZXJvX2xpbmtfbW9kZShrcywgYWR2ZXJ0aXNpbmcpOw0KPiA+
DQo+ID4gKwlpNDBlX3RyYWNlKGlvY3RsX2dldF9saW5rX2tzZXR0aW5ncywgcGYsIGh3X2xpbmtf
aW5mby0NCj4gPmxpbmtfaW5mbyk7DQo+ID4gICAJaWYgKGxpbmtfdXApDQo+ID4gICAJCWk0MGVf
Z2V0X3NldHRpbmdzX2xpbmtfdXAoaHcsIGtzLCBuZXRkZXYsIHBmKTsNCj4gPiAgIAllbHNlDQo+
ID4gQEAgLTcyMTksOSArNzIyMCwxMiBAQCBzdGF0aWMgaW50IGk0MGVfZ2V0X21vZHVsZV9pbmZv
KHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ID4gICAJCW1vZGluZm8tPmVlcHJvbV9s
ZW4gPSBJNDBFX01PRFVMRV9RU0ZQX01BWF9MRU47DQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCWRl
ZmF1bHQ6DQo+ID4gKwkJaTQwZV90cmFjZShpb2N0bF9nZXRfbW9kdWxlX2luZm8sIHBmLCB+MFVM
KTsNCj4gPiAgIAkJbmV0ZGV2X2RiZyh2c2ktPm5ldGRldiwgIlNGUCBtb2R1bGUgdHlwZSB1bnJl
Y29nbml6ZWQNCj4gb3Igbm8gU0ZQDQo+ID4gY29ubmVjdG9yIHVzZWQuXG4iKTsNCj4gDQo+IElz
IGl0IHVzZWZ1bCwgaWYgdGhlcmUgaXMgYSBkZWJ1ZyBwcmludCBhbHJlYWR5Pw0KSW4gZmFjdCwg
dmVyeSB1c2VmdWwuIE9uIHNvbWUgcHJvZHVjdGlvbiBzeXN0ZW1zIGRlYnVnIHByaW50ayBpcyBk
aXNhYmxlZC4gVGhlIHBvaW50IHRvIHVzZSB0cmFjZSBpcyBub3QgdG8gc2xvd2Rvd24gcHJvZHVj
dGlvbiBhcyBhbGwgZGVidWcgcHJpbnRrLXMgc3RhcnQgdG8gZG8gYW5kIHN0YXJ0L3N0b3AgdHJh
Y2luZyBhdCBhbnkgbW9tZW50Lg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMsDQo+IA0KPiBQYXVsDQo+
IA0KPiANCj4gPiAgIAkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICAgCX0NCj4gPiArCWk0MGVf
dHJhY2UoaW9jdGxfZ2V0X21vZHVsZV9pbmZvLCBwZiwgKCgodTY0KW1vZGluZm8tPnR5cGUpDQo+
IDw8IDMyKSB8DQo+ID4gKwkJICAgbW9kaW5mby0+ZWVwcm9tX2xlbik7DQo+ID4gICAJcmV0dXJu
IDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtNzI0NCw2ICs3MjQ4LDcgQEAgc3RhdGljIGludCBp
NDBlX2dldF9tb2R1bGVfZWVwcm9tKHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZXRkZXYsDQo+ID4g
ICAJdTMyIHZhbHVlID0gMDsNCj4gPiAgIAlpbnQgaTsNCj4gPg0KPiA+ICsJaTQwZV90cmFjZShp
b2N0bF9nZXRfbW9kdWxlX2VlcHJvbSwgcGYsIGVlID8gZWUtPmxlbiA6IDBVKTsNCj4gPiAgIAlp
ZiAoIWVlIHx8ICFlZS0+bGVuIHx8ICFkYXRhKQ0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9zcmMvQ09SRS9pNDBlX3RyYWNlLmggYi9zcmMvQ09SRS9pNDBl
X3RyYWNlLmggaW5kZXgNCj4gPiBjYWMwZjdjLi5mNTRmYzM2IDEwMDY0NA0KPiA+IC0tLSBhL3Ny
Yy9DT1JFL2k0MGVfdHJhY2UuaA0KPiA+ICsrKyBiL3NyYy9DT1JFL2k0MGVfdHJhY2UuaA0KPiA+
IEBAIC00MjgsNiArNDI4LDI0IEBAIERFRklORV9FVkVOVCgNCj4gPg0KPiA+ICAgCVRQX0FSR1Mo
cGYsIHZhbCkpOw0KPiA+DQo+ID4gK0RFRklORV9FVkVOVCgNCj4gPiArCWk0MGVfaW9jdGxfdGVt
cGxhdGUsIGk0MGVfaW9jdGxfZ2V0X21vZHVsZV9pbmZvLA0KPiA+ICsJVFBfUFJPVE8oc3RydWN0
IGk0MGVfcGYgKnBmLCB1NjQgdmFsKSwNCj4gPiArDQo+ID4gKwlUUF9BUkdTKHBmLCB2YWwpKTsN
Cj4gPiArDQo+ID4gK0RFRklORV9FVkVOVCgNCj4gPiArCWk0MGVfaW9jdGxfdGVtcGxhdGUsIGk0
MGVfaW9jdGxfZ2V0X21vZHVsZV9lZXByb20sDQo+ID4gKwlUUF9QUk9UTyhzdHJ1Y3QgaTQwZV9w
ZiAqcGYsIHU2NCB2YWwpLA0KPiA+ICsNCj4gPiArCVRQX0FSR1MocGYsIHZhbCkpOw0KPiA+ICsN
Cj4gPiArREVGSU5FX0VWRU5UKA0KPiA+ICsJaTQwZV9pb2N0bF90ZW1wbGF0ZSwgaTQwZV9pb2N0
bF9nZXRfbGlua19rc2V0dGluZ3MsDQo+ID4gKwlUUF9QUk9UTyhzdHJ1Y3QgaTQwZV9wZiAqcGYs
IHU2NCB2YWwpLA0KPiA+ICsNCj4gPiArCVRQX0FSR1MocGYsIHZhbCkpOw0KPiA+ICsNCj4gPiAg
IERFQ0xBUkVfRVZFTlRfQ0xBU1MoDQo+ID4gICAJaTQwZV9udm11cGRfdGVtcGxhdGUsDQo=

