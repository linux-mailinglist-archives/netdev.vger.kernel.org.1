Return-Path: <netdev+bounces-23469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BB76C136
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BE01C210FB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9112B8C;
	Tue,  1 Aug 2023 23:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38417AA8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 23:46:39 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB261B1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690933598; x=1722469598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvlp7OhC5lknEAGWo9crYCABQ2OwihZb8mQLGInu2Cs=;
  b=XlfebT4ZF32syRRHorSD5T9i5JrAvPY4Izn0r0NfnHD6HooVXeZEFy/E
   fgBbnKCn6KeY0XXLear1+GkA6SzvA64M2CRrK7GxGE+QvR/TMxpNS26wk
   tCT5491KG87219Y+aQa2AI3cKO8ExxnxoOK4i6u1blAXgXeo1kjrv0mb5
   SgNO1EWTLtim15WR3OGMz93RKsCN+khsLjlOH1i1NVjYIDIwGcJytE9Dj
   REfmK4IJffQ2x/cuDmakyGbzHtqUa1szAD9iH3grwEOXSEAOpw0Qp1FrY
   4ImaYCP4gL32BgYIO9X+dcAIW8Th4MNdVpptn06hwWuArVVMg27VAkwJ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359479030"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359479030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 16:46:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872254920"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2023 16:46:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 16:46:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 16:46:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 16:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhhKXeJxbIAilLyCFHj4KTrSKYnq7YvR6OpOOqQyCgpsb36cQV7iGx8UNv0KhmmA619Iw0thfRxfk53PHQqwSiuxKXxvw/5PHA4pte9/Rk8IcJPWZAaL4TZiH9JvhWJS0boPy9r6txXPh7xx6Sro/QIs8CNbkwnKZ2MJgQwS1HQSJGvk3IMvtYTiNgOWTYiJBvM3u15BNK/xekZXqHZDzhuV6KfX8qgWXy5ASLxVztYGksTv2qaHMY4//XIsPUyxCFjm/IC1QX7CZZX8pr8Hb6fySe6mdOvkuVobW5rIodnIPYkUIlitjICuW/lSjm19/Zu9yQqBK760vubpSA6/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvlp7OhC5lknEAGWo9crYCABQ2OwihZb8mQLGInu2Cs=;
 b=WtWp2R9PlCLnBaHHGQVCnh0CQ51hzYpQjx2H66PJPPpTplq2DD1Cv5lMyAN2tgkSmnudIdijK9CN5lAcKajGb6D31d1prUrFv7C62wKNLyEvwtVPv0oSRBfwDBB3b9+3TB2zcE7mt5LDFgcvSM5O4qpA09yIKaBuaBEoi9tPrtVAE04qZCgS8gnnU67ak5yqU3sG4bxt5HVHzZ+rjxpwLg7jQbmHUmCqTz2IBPA1wECcmCr8zKkPmJALLR7TQ7UVRz0bwA7KtIxv1nvgmeNdvYsmWkdolyRLiesUlV4ILD3xCqN+zBt6jHPyxpllgz1yaofmZZa3Gdk9BJ5UP0Lo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by BL1PR11MB5527.namprd11.prod.outlook.com (2603:10b6:208:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Tue, 1 Aug
 2023 23:46:33 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 23:46:32 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Brett Creeley <bcreeley@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v2 1/2] igc: Expose tx-usecs coalesce setting to user
Thread-Topic: [PATCH net v2 1/2] igc: Expose tx-usecs coalesce setting to user
Thread-Index: AQHZxJ5gY06oLk3cH0CA+YdBUviKnK/VwG4AgABaQaA=
Date: Tue, 1 Aug 2023 23:46:32 +0000
Message-ID: <SJ1PR11MB6180D8DC61608FAFAC535A9EB80AA@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
 <20230801172742.3625719-2-anthony.l.nguyen@intel.com>
 <30cb80f5-c771-f853-9d41-719fa378e4f5@amd.com>
In-Reply-To: <30cb80f5-c771-f853-9d41-719fa378e4f5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|BL1PR11MB5527:EE_
x-ms-office365-filtering-correlation-id: e3e9760f-7df8-47dd-1cca-08db92e98922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJG0XJ/N/MacW9L11OPVwEn8Ha0+7k2hdnqiNsjEoL66TMww9U7pWqG+oAXQblS7FDVV36moGmA/tF2Jy/RT2BYN4zWVeh6na+19t9thf/GZ9tGNPCCzKV5qZrQDFn98NmnyibeYIDfH9yf8znOBslSpZxiVk/+pJqSlC72PY1RgdO+VokCUt7IFZqA7QCN0o5E23N3DVyyzvD5u/koK8axq4fQE2rqQeNJ6Ci0Xx4zPWc46JEvNPhno0rSOdZQbomLMPn0CIpYFvEijbCWOR+LlUQxuWs/X2N0ju4x5hIFpQzcyPn8Kcdao1eEl+R3a4ToXZXBGCkH5Kc/SKAbEQXUtLi3xVCBpMJN5ziAF6j5njx9XBAyDZS3qxFVdQiLOI41ZEYrZWrxa5sJYrSM8IcWiw65wr47Ry4gAFb51ESqG2da8n8gOh+dATs0ocSIv4uWrorKHb3ySLGqOi/xsO3bmE/MXcwRDEOtFJHpTVwNLj6CiFBuafWEXH61fjrFTNdjfTZ/61L+x133yKgcylbo9w7sZHfAsRvBmnfjOPHUPK+7zDFqQTt7338RasTe7nyahIxIAQOq53ClMiPQilLMcPlIAghx5I7WkvNM9f+FBAUfTA/ZHOfIhgyKjr04O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(66946007)(2906002)(76116006)(64756008)(66476007)(66446008)(4326008)(66556008)(7696005)(33656002)(478600001)(71200400001)(86362001)(9686003)(83380400001)(186003)(82960400001)(122000001)(38070700005)(26005)(6506007)(38100700002)(53546011)(110136005)(54906003)(55016003)(41300700001)(52536014)(8676002)(8936002)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjVLMUlxRE01TmpxcTBCUSs4b0VNcy9qU1R5RE5JWXJ1MkQ1UVAvdzZ1OHdi?=
 =?utf-8?B?TXBPdmRmNHY1VGNmWUNkbjRpR0x5MG9kM1hRbmd5TkoweUUxMERQUm5sYUxp?=
 =?utf-8?B?cVd6MUc0QkRWUmZBVDVhV0FDZFBQSTFINk4rckJKek16S2djMGZaeDVKcTNE?=
 =?utf-8?B?dzBYcXJSSS9pZnJqMkl6T1Y2dnlJc0JIS2pUR3FiUEFWd0pPbnJlSXFxb3pX?=
 =?utf-8?B?UFNvZWZsTHNzTUJXUXpuZDFmK253c2tOWUZWR0VsaTRPVlRra0xLdEhkekl1?=
 =?utf-8?B?ODU3NkpCZ0VkcjZqaU5TWlFRajNzS1dlb0IyUEVyNnFKZmpiWlU1VDZNQlVk?=
 =?utf-8?B?c1B4YWFINEVzZEhYcXdoVUY1VktKTUppOW01QUJSd0IyNDBnbVJURzU3Ujky?=
 =?utf-8?B?NnZyZDdnUjdBNVhQWkxuMkwwTzB1ZkxaY0VnSEQrVit1VUs4TDQ2MHRzYjBV?=
 =?utf-8?B?YWVqTm4wcXo1S1kzK1h4d3dCZ0NDY1lQT1ViT3MvSkJZbDlTcnJOdk1xVUFS?=
 =?utf-8?B?Q2VnZkxOajU5QmZ4bk9OUTJ5a2phWTJRMEtNSEdnK2tCVk83QlVuamZzVGZN?=
 =?utf-8?B?MkoySnU5TXNMRGVQSTUxMFpLNXhWY0JIRmdzd0JrL0o0MkgzRTVDRFFGaFZr?=
 =?utf-8?B?YmJ5ZE9ZbCtSVWJjSzlRVVZpQyt0dXVlSGNLbnBNa0VtZzhpUzRRUndQK1RH?=
 =?utf-8?B?MEZZTmdBQlhLRTBmOEdoNG4zbGtXc0JGVlZxelp0Z200YjNxZTBmcGpBQ1Uy?=
 =?utf-8?B?bDRoRi9HQVJxVWVNWlA5VTNFNmp3MUd4cEhLeDRESjJwVzVsS296aFdRbklC?=
 =?utf-8?B?c05mVVFKRjE2Q3JaSTA4ckgyRUNBRHFwM1RrdFRybGdLc1pzVzdUVFJEb01C?=
 =?utf-8?B?WU11Uyt3OE9nZXh5ZFozMmRITWxJZUxXRDJGaEF0Zm5KQm9lSVF0MHFvK1B0?=
 =?utf-8?B?K25OUFVIa29oQ2pLUGkvUGlGdVNpRzM4NUE1NElXaUJWNW85VUhSOGE2NXFS?=
 =?utf-8?B?dTFnRG1sYUFxbjhGK2tVM2ZuOUc1dkt2RHZPQnhqaUc2d091OXR5WFpUV1ZG?=
 =?utf-8?B?VFUyTHllcGZCZHVuMDJuOE5JbUZvd0pjems4NTd2TlJHellxLytOUERkeWh1?=
 =?utf-8?B?NThPSXZvd2tiQjJ6Ti9vSlg4cDVaTkZ4RjdkcEhCK2l4SW1IQStqNGh0RGI1?=
 =?utf-8?B?eGd2RXNOdkd3R2V2V1RmSzE1NXZHVFdEYlZnSmxFVWRVQjZrSEtmK2pQdTEw?=
 =?utf-8?B?bGthUHpiUm93Uld5cWs5S1NIejdsTGZ4SXJSMFdZM1crS0RBNmI0Vnd4cld0?=
 =?utf-8?B?bWtDZ1NKVG5NdWZxbG4weHFoN2ladVNWV1k5L29OVmowcjQrNHhOMFZGMC80?=
 =?utf-8?B?SW91YjJFNjAxb0hBck9tekZTN3c3em9CTUphVERPMERZZjZKWDZaY1VNOGVC?=
 =?utf-8?B?am9UMFQvcjlpeGhHYXR2TzY0N2U4cmF6Z1lCMHBtRnd5VlVNUUErOXdQNVdn?=
 =?utf-8?B?S3ViYXk4ZGJ0SEFqelVqcXovanU0S0ZKZFFNS2NxaWR5WTVFZnE1UWtIaHBC?=
 =?utf-8?B?ajRzbHMzMUVKS2lqdE5PTjNBYW1wYVE3MTRNSVZVSkZGUUs4dTZKVGl6a3lv?=
 =?utf-8?B?MHpPSTZ5OVEzSTF4SzRaOUdaNXZCVitPT2JvZElxRWF1OXNJejdPdDlBYkJv?=
 =?utf-8?B?L1NveVJ2SDQ1aGhmTnhRL0EzQzBmcW1qOUwva0tIS1dHaVAyNWxBN2lKR0Vo?=
 =?utf-8?B?Qlo3Qi92Mk1XdytpODJjanJSRjBVTjFJbk5ieFRHNUpsSndYeWJTZk1pcmk5?=
 =?utf-8?B?UEg0QmxFKzhla2hwSlNaellJTjE2djBQaHIrQy9LWUhVNCtvT0RNZlh2UTRE?=
 =?utf-8?B?WnJjM2dhbU14RnFxV21aVkFMYnZqOHBzVUNqdE8zaGx6RG5SK1FBazVrUTBS?=
 =?utf-8?B?RmdsQ0szQ0IxcytTczBZamhhR211cjdTODFyTm9wKzRBdmZwbnNwZURCQ2M3?=
 =?utf-8?B?TFk0MzViUFhoR3FNVnlOYU9LT1BuVWhxbUxtSkhBVnBOVGFBbitUMjFQL21M?=
 =?utf-8?B?dG04VDBBcFdkajRQQVFCbVduWnFzc0lXZWJEc25hNGV1OGxqc21DQjhJejZY?=
 =?utf-8?B?UXg0SHhUZVNiMGRVOWxSV0JJQUJnMXNKNCtmbXZraUZiOW1FaHlKSTBBMmhQ?=
 =?utf-8?Q?eTsKLdX11oLHxG9kfL64u/E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e9760f-7df8-47dd-1cca-08db92e98922
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 23:46:32.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWiXN9GtiHuvwz9YriUyzDN43a/HfSZSkpn4xdy1E9iR2rWg/4T4okMWTaPcpL27rhks8U7LSWXn2rB1NWVcbyeSwjHp5a0gQMovGTUP8McSqv6GSNXsLlmjRq6ICfsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5527
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGkgQnJldHQsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmV0dCBDcmVlbGV5IDxiY3JlZWxleUBhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIDIgQXVndXN0LCAyMDIzIDI6MjAgQU0NCj4gVG86IE5ndXllbiwgQW50
aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
DQo+IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5j
b207DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFp1bGtpZmxpLCBNdWhhbW1hZCBI
dXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT47DQo+IE5lZnRpbiwg
U2FzaGEgPHNhc2hhLm5lZnRpbkBpbnRlbC5jb20+OyBOYWFtYSBNZWlyDQo+IDxuYWFtYXgubWVp
ckBsaW51eC5pbnRlbC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYyIDEvMl0gaWdjOiBFeHBvc2UgdHgtdXNlY3MgY29hbGVz
Y2Ugc2V0dGluZyB0byB1c2VyDQo+IA0KPiBPbiA4LzEvMjAyMyAxMDoyNyBBTSwgVG9ueSBOZ3V5
ZW4gd3JvdGU6DQo+ID4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBF
eHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNo
bWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+DQo+ID4NCj4gPiBGcm9t
OiBNdWhhbW1hZCBIdXNhaW5pIFp1bGtpZmxpIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGlu
dGVsLmNvbT4NCj4gPg0KPiA+IFdoZW4gdXNlcnMgYXR0ZW1wdCB0byBvYnRhaW4gdGhlIGNvYWxl
c2NlIHNldHRpbmcgdXNpbmcgdGhlIGV0aHRvb2wNCj4gPiBjb21tYW5kLCBjdXJyZW50IGNvZGUg
YWx3YXlzIHJldHVybnMgMCBmb3IgdHgtdXNlY3MuDQo+ID4gVGhpcyBpcyBiZWNhdXNlIEkyMjUv
NiBhbHdheXMgdXNlcyBhIHF1ZXVlIHBhaXIgc2V0dGluZywgaGVuY2UNCj4gPiB0eF9jb2FsZXNj
ZV91c2VjcyBkb2VzIG5vdCByZXR1cm4gYSB2YWx1ZSBkdXJpbmcgdGhlDQo+ID4gaWdjX2V0aHRv
b2xfZ2V0X2NvYWxlc2NlKCkgY2FsbGJhY2sgcHJvY2Vzcy4gVGhlIHBhaXIgcXVldWUgY29uZGl0
aW9uDQo+ID4gY2hlY2tpbmcgaW4gaWdjX2V0aHRvb2xfZ2V0X2NvYWxlc2NlKCkgaXMgcmVtb3Zl
ZCBieSB0aGlzIHBhdGNoIHNvDQo+ID4gdGhhdCB0aGUgdXNlciBnZXRzIGluZm9ybWF0aW9uIG9m
IHRoZSB2YWx1ZSBvZiB0eC11c2Vjcy4NCj4gPg0KPiA+IEV2ZW4gaWYgaTIyNS82IGlzIHVzaW5n
IHF1ZXVlIHBhaXIgc2V0dGluZywgdGhlcmUgaXMgbm8gaGFybSBpbg0KPiA+IG5vdGlmeWluZyB0
aGUgdXNlciBvZiB0aGUgdHgtdXNlY3MuIFRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgY3VycmVu
dA0KPiA+IGNvZGUgbWF5IGhhdmUgcHJldmlvdXNseSBiZWVuIGEgY29weSBvZiB0aGUgbGVnYWN5
IGNvZGUgaTIxMC4NCj4gPg0KPiA+IEhvdyB0byB0ZXN0Og0KPiA+IFVzZXIgY2FuIGdldCB0aGUg
Y29hbGVzY2UgdmFsdWUgdXNpbmcgZXRodG9vbCBjb21tYW5kLg0KPiA+DQo+ID4gRXhhbXBsZSBj
b21tYW5kOg0KPiA+IEdldDogZXRodG9vbCAtYyA8aW50ZXJmYWNlPg0KPiA+DQo+ID4gUHJldmlv
dXMgb3V0cHV0Og0KPiA+DQo+ID4gcngtdXNlY3M6IDMNCj4gPiByeC1mcmFtZXM6IG4vYQ0KPiA+
IHJ4LXVzZWNzLWlycTogbi9hDQo+ID4gcngtZnJhbWVzLWlycTogbi9hDQo+ID4NCj4gPiB0eC11
c2VjczogMA0KPiA+IHR4LWZyYW1lczogbi9hDQo+ID4gdHgtdXNlY3MtaXJxOiBuL2ENCj4gPiB0
eC1mcmFtZXMtaXJxOiBuL2ENCj4gPg0KPiA+IE5ldyBvdXRwdXQ6DQo+ID4NCj4gPiByeC11c2Vj
czogMw0KPiA+IHJ4LWZyYW1lczogbi9hDQo+ID4gcngtdXNlY3MtaXJxOiBuL2ENCj4gPiByeC1m
cmFtZXMtaXJxOiBuL2ENCj4gPg0KPiA+IHR4LXVzZWNzOiAzDQo+ID4gdHgtZnJhbWVzOiBuL2EN
Cj4gPiB0eC11c2Vjcy1pcnE6IG4vYQ0KPiA+IHR4LWZyYW1lcy1pcnE6IG4vYQ0KPiA+DQo+ID4g
Rml4ZXM6IDhjNWFkMGRhZTkzYyAoImlnYzogQWRkIGV0aHRvb2wgc3VwcG9ydCIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaQ0KPiA+IDxtdWhhbW1hZC5odXNh
aW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IE5hYW1hIE1laXIgPG5hYW1h
eC5tZWlyQGxpbnV4LmludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxo
b3Jtc0BrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbnkgTmd1eWVuIDxhbnRob255
Lmwubmd1eWVuQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jIHwgMTMgKysrKy0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2V0aHRvb2wuYw0KPiA+
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19ldGh0b29sLmMNCj4gPiBpbmRl
eCA5M2JjZTcyOWJlNzYuLjYyZDkyNWIyNmYyYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX2V0aHRvb2wuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jDQo+ID4gQEAgLTg4MCwxMiArODgwLDEw
IEBAIHN0YXRpYyBpbnQgaWdjX2V0aHRvb2xfZ2V0X2NvYWxlc2NlKHN0cnVjdA0KPiBuZXRfZGV2
aWNlICpuZXRkZXYsDQo+ID4gICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICAgZWMt
PnJ4X2NvYWxlc2NlX3VzZWNzID0gYWRhcHRlci0+cnhfaXRyX3NldHRpbmcgPj4gMjsNCj4gPg0K
PiA+IC0gICAgICAgaWYgKCEoYWRhcHRlci0+ZmxhZ3MgJiBJR0NfRkxBR19RVUVVRV9QQUlSUykp
IHsNCj4gPiAtICAgICAgICAgICAgICAgaWYgKGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nIDw9IDMp
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZWMtPnR4X2NvYWxlc2NlX3VzZWNzID0gYWRh
cHRlci0+dHhfaXRyX3NldHRpbmc7DQo+ID4gLSAgICAgICAgICAgICAgIGVsc2UNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICBlYy0+dHhfY29hbGVzY2VfdXNlY3MgPSBhZGFwdGVyLT50eF9p
dHJfc2V0dGluZyA+PiAyOw0KPiA+IC0gICAgICAgfQ0KPiA+ICsgICAgICAgaWYgKGFkYXB0ZXIt
PnR4X2l0cl9zZXR0aW5nIDw9IDMpDQo+ID4gKyAgICAgICAgICAgICAgIGVjLT50eF9jb2FsZXNj
ZV91c2VjcyA9IGFkYXB0ZXItPnR4X2l0cl9zZXR0aW5nOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+
ICsgICAgICAgICAgICAgICBlYy0+dHhfY29hbGVzY2VfdXNlY3MgPSBhZGFwdGVyLT50eF9pdHJf
c2V0dGluZyA+PiAyOw0KPiA+DQo+ID4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4g
QEAgLTkxMCw5ICs5MDgsNiBAQCBzdGF0aWMgaW50IGlnY19ldGh0b29sX3NldF9jb2FsZXNjZShz
dHJ1Y3QgbmV0X2RldmljZQ0KPiAqbmV0ZGV2LA0KPiA+ICAgICAgICAgICAgICBlYy0+dHhfY29h
bGVzY2VfdXNlY3MgPT0gMikNCj4gPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+DQo+ID4gLSAgICAgICBpZiAoKGFkYXB0ZXItPmZsYWdzICYgSUdDX0ZMQUdfUVVFVUVfUEFJ
UlMpICYmIGVjLQ0KPiA+dHhfY29hbGVzY2VfdXNlY3MpDQo+ID4gLSAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+IC0NCj4gDQo+IFNob3VsZCB0aGlzIGJlIHBhcnQgb2YgcGF0Y2gg
Mi8yIG9yIGlzIGl0IG5lY2Vzc2FyeSB0byByZW1vdmUgdGhpcyBmb3IgdGhlIGdldA0KPiBmbG93
Pw0KDQpJdCBzaG91bGQgYmUgcGFydCBvZiAxLzIuIA0KWW91IHdvbid0IGJlIGFibGUgdG8gc2V0
IHRoZSByeC11c2VjcyBpZiB3ZSBkb24ndCByZW1vdmUgdGhpcyBsaW5lIHNpbmNlIHRoZSB0eC11
c2VjIHdpbGwgDQpiZWdpbiB0byBoYXZlIHZhbHVlLg0KDQpUaGFua3MsDQpIdXNhaW5pDQoNCj4g
DQo+ID4gICAgICAgICAgLyogSWYgSVRSIGlzIGRpc2FibGVkLCBkaXNhYmxlIERNQUMgKi8NCj4g
PiAgICAgICAgICBpZiAoZWMtPnJ4X2NvYWxlc2NlX3VzZWNzID09IDApIHsNCj4gPiAgICAgICAg
ICAgICAgICAgIGlmIChhZGFwdGVyLT5mbGFncyAmIElHQ19GTEFHX0RNQUMpDQo+ID4gLS0NCj4g
PiAyLjM4LjENCj4gPg0KPiA+DQo=

