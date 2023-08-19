Return-Path: <netdev+bounces-29096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE97819AF
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 15:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92577281A38
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53B6123;
	Sat, 19 Aug 2023 13:24:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B35667
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 13:24:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ADF4202
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692451383; x=1723987383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9UDTmuQnTIceil00IPlQrM6tOnlyngz9QzeGHrHvfL8=;
  b=Z5F9fh/8BpEdPWW+1JfI0L0po9QwNQwDWuUH+U32ksCS6l4y6rlufheZ
   hTxA3VfZkrE+kNeSgpHnNhpmexw3CjXYLXyd/LwJWIBNkmMdJWK1B3SfP
   cOJsuvQtFrOp8ElFHgbbhvnHbA2fmtPSpHLyTh58DN6Ppi5aQ8EtagzK1
   2FkdZ3+FOmOHswIwGJhIQVdQerCurXUyDS3EskhVcRWQKnKp4Ei/HrtsU
   U1O/+Y3Gu+rU6Un+Wjz6JklmxXSJu20zGnhuZECiac7PSCPVYjQyqcTD5
   HcNOYVmOxpHHhMwwK0Wz4LAbRf9QiSF8SGgOm0OtXeL1AoSM4SA/xavS/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="377048238"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="377048238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 06:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10807"; a="981969795"
X-IronPort-AV: E=Sophos;i="6.01,186,1684825200"; 
   d="scan'208";a="981969795"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2023 06:23:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 19 Aug 2023 06:23:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 19 Aug 2023 06:23:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 19 Aug 2023 06:23:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 19 Aug 2023 06:23:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF6hDzAW7Eh3+iE6PFpcCey8QmvovieIQbQi+iSQg6d2SSpfK2Yqj9yTzvdg72LoL2o16uCe83s3BXFpiUX005HVZVSlb87Ieo4OyMifdyo2CjUUYgNttFH7p2EdmAFFCyvuiYohmIqKKPDndvea1FGS84bdo5jTFD6MZvf6J5DPAFgF64pTvHUAQ8vQnYaK3wNZYhTEwVx3160PMjbu7dnPXAP+zo9qxWK5OlPk7GD7OeBN6hPuxc+6jisrQtn7Lyjt7v8Bwh8Qv0TC0dXWFCulb2jOjY7gARWCjuTQxwyd3fx2XDyORh3Q+GWSin1Y4qrL5oGIMrTPuA5NlhUjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UDTmuQnTIceil00IPlQrM6tOnlyngz9QzeGHrHvfL8=;
 b=MbebCPEN8aWYeVDECViOQPdW/ntQ+PYh8vwrp7TemzEQFnVouYq0UOx1XMnx2sI+cVMMiCQoUXJSPuFBlP8uS2ri2s26u7fEDBI0wpmKmbR+oucN/rRiAAd29Ljn3W4VdbZa7FRa8RcaHZHNMN7CwJR0EXjnVN/lQYJxMAvKtaW9VR800lkAqx+fe4RcFyT3ftUel68Dy4qanLqPtl8tYGlTE0XXIVk4wAxylqF/Qa8aFO1A7pvMz+RD7dA+v8mj3aeCGUIJNdwLOXvSzSl5u9O8uSCZ2FwovLQImE7/kzSVUngib8i2/wpN9X66ZBK+pme0cxchSdl2Fw6mkDcc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 13:22:59 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 13:22:58 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Brett Creeley <bcreeley@amd.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Neftin, Sasha" <sasha.neftin@intel.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net v2 0/2][pull request] igc: Enhance the tx-usecs
 coalesce setting implementation
Thread-Topic: [PATCH net v2 0/2][pull request] igc: Enhance the tx-usecs
 coalesce setting implementation
Thread-Index: AQHZxJ5eMiOaQ66wOk+qzm29CDT0U6/VwDUAgBv20XA=
Date: Sat, 19 Aug 2023 13:22:58 +0000
Message-ID: <SJ1PR11MB6180AD89C5D842A5805F360DB818A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230801172742.3625719-1-anthony.l.nguyen@intel.com>
 <a88ef5bd-a437-00ef-026a-dd971ed27209@amd.com>
In-Reply-To: <a88ef5bd-a437-00ef-026a-dd971ed27209@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|PH7PR11MB5943:EE_
x-ms-office365-filtering-correlation-id: f0522ce8-5e3b-4353-fa5d-08dba0b7681e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tj2y4tLwF14QunHrvUlbL17SXfHb36dA8fFWgC//TaEkufAHL/yUmDj8jfShdQTN2SqZ3Do97JTokcrjE/paWp3Q+eDuXSMm20JjGRXSf+cGHBSCiR4aL8W1harJkXcZNyuqt0KhuEmuoTmvONLOeS0Oz4fVFvIecuPAE/OWtS6cQDHFYisfSTKI2SZ1ZwelXUTsOHXKD7HxJZHBvv4Kg9PX3EggtL1cUxpL+pTwpJ+DUUF/WADILKH6B/C23Kzvwlnhjf9uzC+1qPC4hbgkdoAho6kPFYH4qgY8WBrPyoT+mVpuscNb/NpwGEkipg2YWpe0NHaYH3DdghKrsIJ04lcethdJ1F5mmlgprr9UB8FRPZ3S6cM18yZoypFmqSTey2LpPiWY5uJ84RyBxJ5npQUOv71VZgUOkVuo0W1m/vJT5UJtUwV6BzI24vobCmW1yTElGUVKhyLOr9QBVjOK9OyF5nQCX3G0i9Dmc0LEtiiuYSDAv0rqMlqFdn3MgpWaC6M8XQaothgJkFJCgD07dpkY8eY84JBO4ed5zGdZgrycCapJZaWrZCqwqXnb6P63K4G/tm2XaaqI0uew4tvxL99KhmDrIA6aigv1CyJZMrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(54906003)(76116006)(66556008)(66946007)(316002)(9686003)(82960400001)(110136005)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(966005)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(53546011)(6506007)(2906002)(83380400001)(86362001)(5660300002)(33656002)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3FwZmFGbG5oU2U5aHNsOVRWNkFrSHAwbWkxRVRFeURvSnRxREJyS3ZnNGp5?=
 =?utf-8?B?UlRzdDV6TWhtVm42V1dZa1kwOUhLNjVUeVdwejF4akI5T2YwdEpvaENOQnNS?=
 =?utf-8?B?Y3N0dGhrbWJpQUVIRzNYaGZtekdheHlRN1pqMGtURkZCc1lpaEZBUGFHN2ty?=
 =?utf-8?B?eDVHMUpCYVlWdHVyTHZrMWtBcHVvcVlWQXhHVDJjSXZSNUQ5MjhlN0c3Ylhu?=
 =?utf-8?B?REFqU00rSWFwWHlnRGxGRnRldldMNEl3WEZiMkJtVkdUSjZaTncvKzJMdk9B?=
 =?utf-8?B?VDV3QkE3UlJSNHhZZS9raTdHVGxubksrbmNEV2xrYndjU2pEOWdSSDBJTXRC?=
 =?utf-8?B?amR5R0QwMFBXLzdySW1DYk5YT2FEWWgyMVd6N1dIZ05KYTdEUldDeG1RdmFZ?=
 =?utf-8?B?ZHVlVlByUW9mYWx3NFczVURtQzdYVkFWRHVRMWZySUF2OVlwV3NoQW1abUEr?=
 =?utf-8?B?czY3THQ3OTR1SjAxMEY4VFA4QXB1TVFNZHJ4V0p3dGhFSGh6RFBFUzVCNlRs?=
 =?utf-8?B?VXRneVlETS9LNUYzTzlNbXRoMHgwZUVUNnBrSjFDWWFpUEZWVXVrRnhucUxp?=
 =?utf-8?B?cHBmcjRjMldPWGE0azlmWVNFNWtaWmRaYkJRTWg5OHc5UmRZQUFjNVR4U3ZG?=
 =?utf-8?B?cWlEVHRiUHNFdG8vTUIyZUZRTmtyU3VYaWUzQUZwNlF5T2ZqaldYQ2IxYW9U?=
 =?utf-8?B?K09lUGY5Y2FiUkFGM3FNdFpXQmRITmZ0eFFqMTNmVkd0eDI4UHhZT0V3SUdo?=
 =?utf-8?B?N0JhbUkvalZEUVlQUTczSXgrUDRGSGFyNlB1S0Y0UENVdUZNRG8rTEQ3akd0?=
 =?utf-8?B?Q043N1YzMktKKzZmUWxaTnF5WGhmbTh1QnF4b2JlVjIrNk4yVWwxYnpyVmhQ?=
 =?utf-8?B?UXNyNENVcHRjM1VWaE8wclJmN0tzRXpLY3UyeEFnanMybm01VHVWSEN1bzNB?=
 =?utf-8?B?Zlk2WTJtcXNnMEowV1pNb29yU0cxdEVLcFZKY2Z0bGFDYysvRENoMlV0WGYz?=
 =?utf-8?B?NkZiS2xGcEdpYXVpUlNGblFZS1RQVkZ5SlVjc1R4dkduVURWeHA2dzVrUjJS?=
 =?utf-8?B?UTQyN2EraUlsTmQ4QVl3SHo2ellxeTRLeUtvbjloYS9KVkY0YmZtSGthdHpF?=
 =?utf-8?B?RXZGNjhBcEtjRzEzRjJSZzFERHRiRXZ1eWR4b0owaGM3VHFYa0w4dlgzRzFK?=
 =?utf-8?B?Y09vRGs2dFZjMG9mdlM4bDFvVVRVVDFwVFhFaEhWdTNoRElGSVpBSW9OVU1D?=
 =?utf-8?B?VHpidGJ2V09JRFZNQmE2T1o1amxxUEZ5enl0dEFZaGF2elpYWVhlMkhOay96?=
 =?utf-8?B?MWFUdE84ZjJtcTNDZUJLNXFhWUN3MXdRcGJpQ0xJZm96SklLTDlobHE3ZlJN?=
 =?utf-8?B?MW1ORWh3bmlSU0c2ZGt2RU9sOEh5aVUxdGFtQkNTeTl2TEpIL0lCNTVKL29O?=
 =?utf-8?B?VGM5ekdQejhMby9BazNDdXpvWFFJREJtV2RTdlQ3N2xnb3RVZFFGWlJZMzFi?=
 =?utf-8?B?QlJtSGVUNHRULzlzSjZTNUhUWkgvYjluSVBBVXY1dlVMRk5vVGltbFFjQy9X?=
 =?utf-8?B?eCs1T1Z1WGZ6V0F3M3BlSitjVnJUZ3haRVhzbkRob3RIeFhQNlJPL05SdjJU?=
 =?utf-8?B?SWNJclVZd2RPV29HbXpNZnFxbTF3Q3ZPQjk1dUNJQlFSNnc2Rlo1TlI0U2Qx?=
 =?utf-8?B?YXNlZXJpQUpTRk5oWUNxMHNBVE02bTlOSkhVUHdhUXhLMjBJUjN1V1J1ZERX?=
 =?utf-8?B?M0ZrSUExaVd1aWZkeXV0bVFoOEl3VDYvK2cyWmlCZFRieUxtYVcyVWZlYVhY?=
 =?utf-8?B?QXZXaXY2WHp2U1hhbzYyQVNFTjBXQi8yMTYrY0Z5dC9PTUxsdDVOZk5SVFN6?=
 =?utf-8?B?bG1FM0RhQ0crYkN3YUVQVDBCa0o0ckdVYm03QlNSSUo1K2pvSG1TU0h4RnFN?=
 =?utf-8?B?Z2IxdEd4TXdDcjJHYzRYemNFNUNmdFh6UUlkVGJBNjdIVFUwbDVEaGdNTlAv?=
 =?utf-8?B?OW9BbGpFOXMyUmFKVDR6T1F4UVN6Nk1jK3NKRHg1ZzdNTHYvaEd0Wk5PNFY5?=
 =?utf-8?B?UnJvNURxWjhOMXkra1BKdDNFSFhaY0dnRGRxNG1YZkMzZGo0ZTVJVHduUkhW?=
 =?utf-8?B?NXV0c2Y4S3BSNHp5cnBtYnBSL1RuSm4yc1ZFMDVuOE5qMW5jZTVMb1FjcUl3?=
 =?utf-8?Q?A6BQ3CZhoxs10QQgOGH8vvo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f0522ce8-5e3b-4353-fa5d-08dba0b7681e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 13:22:58.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtcmB3EfS9JrRT+d26eKNCbmhCfKlIinAc5xX5nkiWR8khzUPj/0bEda4nBPwwLaOtSAlZxVq9RURw807G6lKy+9+vN/VK06jmBal5WipOdykGNXCgU68dxjiH0IJ2XG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmV0dCBDcmVlbGV5IDxiY3Jl
ZWxleUBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDIgQXVndXN0LCAyMDIzIDI6MjAgQU0N
Cj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47DQo+
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207
DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFp1
bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVs
LmNvbT47DQo+IE5lZnRpbiwgU2FzaGEgPHNhc2hhLm5lZnRpbkBpbnRlbC5jb20+OyBob3Jtc0Br
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IHYyIDAvMl1bcHVsbCByZXF1ZXN0
XSBpZ2M6IEVuaGFuY2UgdGhlIHR4LXVzZWNzDQo+IGNvYWxlc2NlIHNldHRpbmcgaW1wbGVtZW50
YXRpb24NCj4gDQo+IE9uIDgvMS8yMDIzIDEwOjI3IEFNLCBUb255IE5ndXllbiB3cm90ZToNCj4g
PiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJj
ZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4NCj4gPg0KPiA+IE11aGFtbWFkIEh1c2Fpbmkg
WnVsa2lmbGkgc2F5czoNCj4gPg0KPiA+IFRoZSBjdXJyZW50IHR4LXVzZWNzIGNvYWxlc2NlIHNl
dHRpbmcgaW1wbGVtZW50YXRpb24gaW4gdGhlIGRyaXZlcg0KPiA+IGNvZGUgaXMgaW1wcm92ZWQg
YnkgdGhpcyBwYXRjaCBzZXJpZXMuIFRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUNCj4gPiBjdXJy
ZW50IGRyaXZlciBjb2RlIG1heSBoYXZlIHByZXZpb3VzbHkgYmVlbiBhIGNvcHkgb2YgdGhlIGxl
Z2FjeSBjb2RlDQo+IGkyMTAuDQo+ID4NCj4gPiBQYXRjaCAxOg0KPiA+IEFsbG93IHRoZSB1c2Vy
IHRvIHNlZSB0aGUgdHgtdXNlY3MgY29sZWFzZSBzZXR0aW5nJ3MgY3VycmVudCB2YWx1ZQ0KPiA+
IHdoZW4gdXNpbmcNCj4gDQo+IG5pdCwgcy9jb2xlYXNlL2NvYWxlc2NlDQoNClN1cmUuIFdpbGwg
Zml4IHRoaXMgdHlwb3MuDQoNCj4gDQo+ID4gdGhlIGV0aHRvb2wgY29tbWFuZC4gVGhlIHByZXZp
b3VzIHZhbHVlIHdhcyAwLg0KPiA+DQo+ID4gUGF0Y2ggMjoNCj4gPiBHaXZlIHRoZSB1c2VyIHRo
ZSBhYmlsaXR5IHRvIG1vZGlmeSB0aGUgdHgtdXNlY3MgY29sZWFzZSBzZXR0aW5nJ3MgdmFsdWUu
DQo+IA0KPiBuaXQsIHMvY29sZWFzZS9jb2FsZXNjZQ0KDQpOb3RlZC4gDQoNCj4gDQo+ID4gUHJl
dmlvdXNseSwgaXQgd2FzIHJlc3RyaWN0ZWQgdG8gcngtdXNlY3MuDQo+ID4gLS0tDQo+ID4gdjI6
DQo+ID4gLSBSZWZhY3RvciB0aGUgY29kZSwgYXMgU2ltb24gc3VnZ2VzdGVkLCB0byBtYWtlIGl0
IG1vcmUgcmVhZGFibGUuDQo+ID4NCj4gPiB2MToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvMjAyMzA3MjgxNzA5NTQuMjQ0NTU5Mi0xLWFudGhvbnkubC5uZ3V5DQo+ID4gZW5A
aW50ZWwuY29tLw0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBhcmUgY2hhbmdlcyBzaW5jZSBjb21t
aXQNCj4gMTNkMjYxOGI0OGYxNTk2NmQxYWRmZTFmZjZhMTk4NWY1ZWVmNDBiYToNCj4gPiAgICBi
cGY6IHNvY2ttYXA6IFJlbW92ZSBwcmVlbXB0X2Rpc2FibGUgaW4gc29ja19tYXBfc2tfYWNxdWly
ZSBhbmQgYXJlDQo+ID4gYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9yeSBhdDoNCj4gPiAg
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG5ndXkvbmV0
LXF1ZXVlIDFHYkUNCj4gPg0KPiA+IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkgKDIpOg0KPiA+
ICAgIGlnYzogRXhwb3NlIHR4LXVzZWNzIGNvYWxlc2NlIHNldHRpbmcgdG8gdXNlcg0KPiA+ICAg
IGlnYzogTW9kaWZ5IHRoZSB0eC11c2VjcyBjb2FsZXNjZSBzZXR0aW5nDQo+ID4NCj4gPiAgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jIHwgNjIgKysrKysrKysr
KysrKy0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyMSBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi4zOC4xDQo+ID4NCj4gPg0K

