Return-Path: <netdev+bounces-41158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DF7C9FFD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707B5B20C03
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F314F7C;
	Mon, 16 Oct 2023 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0YKQ4K6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF351FD0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:56:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7EA97
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 23:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697439383; x=1728975383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jnzjfHwrqGFSUH4CbCVUws5A0M3Uc8dFW1LehihFUHo=;
  b=F0YKQ4K6rC3Po5DxggWuHOP9cfaimtxuNNohEhfLbKoLE/QFeC45RKUF
   aas8jLK0m9NFs53fRHdZmjpHtxsMxHWV3r8p6Omas5LlEAyabCpK3JbT7
   4ecsvsXw3ODLI/TB8gc8IsjuK+yAeoEBidAiRDtzJj+HT0gKv0OjsXXVZ
   mczajCkLWloMXSlOuB5B527X1JbB79njbFNl1K/kUJDMmUb3H6wyXoP3k
   hddIP/0WH69X/H42UXc1IJi4bc4ekA/8TnUUN4ijn30MFn6ChR2qeC9vn
   QKsBDiyu9773lDwKwZBx1EVSi/Z4MsOo0GOnC9qOn/sFKYSfOqSX1zEWQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="471691840"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="471691840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="871975129"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="871975129"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2023 23:56:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 15 Oct 2023 23:56:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 15 Oct 2023 23:56:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 15 Oct 2023 23:56:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=melXemrxnboBTFYNClaS9WarRfHxCBax2Gg61B5vNmv5Ji+eufGQc679dpFohMczSUP0IgnO2uzp2VkWQNqGORmWKSL18rxbFotrdovuk3GiJVW0DeENPfBLQKwyDcEPteny905xGLfUvPaO3m0SSt+Hc+5eZRE+mDW8waYKaJzpigkIZBDGPajBcC55UWmooUpxPwgVfOLmdwFkhrBRvcmtRgb2NAoPV0XFipZoSDC1tvwfJmP1gAjNme3ZvtmqufJDnH9k/LjQT0FeSOap6cy9gOd1MnrpXIrDL2dPTlWkYtJxhPTW5g+5fKzJA0Ipga5eaLCM4u4X0RBzBHZfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnzjfHwrqGFSUH4CbCVUws5A0M3Uc8dFW1LehihFUHo=;
 b=EGC7Sb9qRWZ3akwEmB7+bpA85sl36YzXsOPL0mHSaxygTHoe2maOE7uygQrg305ZcKGf64JEZtHNhsDipP3VQig1tkKFCdyNfATlALi4cVjgoxfRLrCMw9/D4m9CihQK7kF9neO+GqC1aUK6OczyAicEwgbqtsjED3FHnZqFlxVdl8xpbzgTtRhPFbhgQkdV5oSrNDAJF8mHXGFIVliVSllXHbdsU3dFoFJQ2HjdWJkHgjCRRoQlyW9XRo1EXrAIo9pzJO/oM3r1VZ7TkzVdEXqcWjqbAfsKwZA4HSrHBIKz7OCli2c0ALKthJLlM5EuSX8uyo4PiVeZcN2yPrRhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5859.namprd11.prod.outlook.com (2603:10b6:303:19e::9)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 06:56:19 +0000
Received: from MW5PR11MB5859.namprd11.prod.outlook.com
 ([fe80::4129:33d2:69ab:3dc3]) by MW5PR11MB5859.namprd11.prod.outlook.com
 ([fe80::4129:33d2:69ab:3dc3%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 06:56:19 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v5] i40e: add restore default speed when changed
 PHY doesn't support it
Thread-Topic: [PATCH iwl-next v5] i40e: add restore default speed when changed
 PHY doesn't support it
Thread-Index: AQHZ/cvOoXHC54wf+ki0oyRx56ClkrBHp9EAgARWdFA=
Date: Mon, 16 Oct 2023 06:56:19 +0000
Message-ID: <MW5PR11MB58598BE9AE5947A2D385ABA8E5D7A@MW5PR11MB5859.namprd11.prod.outlook.com>
References: <20231013115245.1517606-1-aleksandr.loktionov@intel.com>
 <b8f3eb2e-afaa-48c7-c830-300f888b1f1f@intel.com>
In-Reply-To: <b8f3eb2e-afaa-48c7-c830-300f888b1f1f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5859:EE_|SJ0PR11MB5088:EE_
x-ms-office365-filtering-correlation-id: 1fc89740-0c2e-4341-a3ca-08dbce14fff0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c7QcfA2U8XIf59sFrzNsbImwsz0glLLo9rzGZkoAO7zcVoTfc4rpXCIS7ztx9tElGNt7uXKhhupDwFOpL1XBf2UTZu9lLlOdIbYXbrn862jocZC/CG6/UZaGEuyL2L7zfoDr0RyyxnHDkmAAf7yNLeNV4XDRQcEgCP32ot921V1Cz2Pe0pAkTkji7Yhf4BynzFoAeyvAh6O/jIORnRPsJXWIySUCXG5SBk1nl3VkYjpyN2Lrk3RCe6qJ+ifnflnkhLahWp9YAQftONvy95sWdXQdrUSmkhHC+8mOoNr0ZA+6QB4rV1umZ3ayQVc4+BQ6l5koPFL1jkcCAM208+Eo4w3/VzH7xAZgGf1T7n+tqWoe8q6EY/1CKrUw1SqN5GmP6859EecZkXmDcsX9sWOX/5+4kVLg4ww6Q8KKld05AgoxNeI3zDfhfG8OwRUtzlsajway/05LeJduaXP3R0sHEkiewIuwoBS9HVtQ5EpHaem46rM4uW2B/NT9vzqdp5HfyZUvP3RWkFiv10PJFMNxSuzqZ4yKFNjTlxJWXQgD15Q6MMPSQP47cLPrpAg4FpL+RVAJLyuF3sqUPmxwK4BdaecAlxlUB8nmCwng0YHN1CsUu7gVoKZ1H6TcLUI51EaS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7696005)(6506007)(53546011)(83380400001)(26005)(55016003)(38100700002)(9686003)(52536014)(38070700005)(122000001)(33656002)(86362001)(66476007)(5660300002)(4326008)(8676002)(8936002)(2906002)(110136005)(71200400001)(316002)(64756008)(6636002)(41300700001)(66946007)(66446008)(76116006)(66556008)(82960400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0NORnQ3aEN2c3o2Uld2L3U0RUNwSm9Yai96YVBhc0lhNFRXLy9pbnZwUW83?=
 =?utf-8?B?YkY4YjRJc0N6OGR6QU5QaVdIdHg1Y2pXbDltbGtXOUJEN0JURTRVdGZGQXQx?=
 =?utf-8?B?dWFYK0JqM3MrQnVCUERRd1lyeHA3RlA2WXpadys2Sks4b1kyYkk0eVVHb3ha?=
 =?utf-8?B?V1AxNEtuL1dpaGdNU1NFWEc5TEVaNHVvSjNONktUMzRxSEF1MGFDcHl5dVZL?=
 =?utf-8?B?cmpDV2FXT3dWVTU1WWp1VVJ3RHlQdDcvTy9tVWlSNFJ5WFV6STZoMEVHaHNT?=
 =?utf-8?B?aEp1aDVwWjQ3MEZKcitocUdYZzQ3Z2pJMjdYNDErbEZLcFJzdUdxd0dDbEtN?=
 =?utf-8?B?QkRIaXYxNUZ0OUc0Y0xsOVI1RFQwQkVpeTdIZm4ybWxaaWNBNUdsQWlzUHdn?=
 =?utf-8?B?RTRlV0JOeW1BU1dQMExYbFpwZnFRRStVN2U3RndKTjdTUU5SU29DU3praHgx?=
 =?utf-8?B?N3ZReWE4RStZTmtLVUQwaVlrbDJmN2puSFN0SFBhbkdyNXdkQ1VOOG1ZWDhO?=
 =?utf-8?B?OUNZeEJWUTdwdTh4eXVUMWJHc242Zk1MWVRIVkx0SlFKcEJZc1JGdVIxaGVq?=
 =?utf-8?B?b2JyQTdlNFB6Y2phYzJUc0V2eTEyK1JnWDFIVk1PdmJQWUQrQ1NCa3JpRTRX?=
 =?utf-8?B?Vi9NSExXeVg3dlVsQ1NwalBiOWl5Vzc4UUd3a1R0M3J6SCs2aVFsY1RWQ2lh?=
 =?utf-8?B?aXhIc0wwRlpDOXZsM0RVeHlLMzQ3TnNCV25LaTZmT2s5YUtBd2o3K2ZCelYy?=
 =?utf-8?B?L0FvQjcxREhYZGlKSVhNOGxDNkR2c2kvRFJKTmZCNUY0QTJveG9SZnRzaUlS?=
 =?utf-8?B?MG9zNG02bjNmTGFoTDZKNDkxaE1WWXZBRkp3aXg0aWZwTldnQ0NZc0xTa3Q3?=
 =?utf-8?B?YTNUcVhhOGlBbWZkRytZNE95UW1yL09LYTdJQVR4Q3I4Ui94MWJ5WXE5d0pK?=
 =?utf-8?B?WmJuUFhTcElGMG1iMUJ5Q0x1TW1PYzBLS2EzVjI1cEFhYVowUUVGNERnbk5x?=
 =?utf-8?B?YjcyZXAxNGRSakRGK2I2bHgwK0gyUVJTQnZ1YW5EZUJZQitNTWdQbEJGQkRl?=
 =?utf-8?B?YUhDZGlhNG5DUXdwTSs1ejVoYlRNVTI4UEdObllsL3dncEF1RG90ZjcrWVpW?=
 =?utf-8?B?MXlsVTNSZDN5NFJEa0dVUlZKa0NyaVV0OFFnd1YyL2hTWWtBWjFVenFldzZl?=
 =?utf-8?B?Y3VubzJIVVJySWkyWTdTOUtld1llWXp2SjdRU0RBazd5Yk4wYk8rSzJNV1lP?=
 =?utf-8?B?SWptTTJqMC95dDJFTFRuVXVGbm9PV25QMnMzdWJlNC9lTndyZ2ZWZlZtNmVj?=
 =?utf-8?B?UlJ2eEhCQ3dqZmw2U3IrMExvS2czWjB3L25zZHpUWlJOWjBYaVY0T2wzNkJl?=
 =?utf-8?B?Nm0zVVRJWkxseDNxS1RVWlpKT2pYdER4WnVNZ3Q5cjBVckVIdDZybWNQMTNT?=
 =?utf-8?B?L0EzSURNbDdTM0tWK2xFMWd5TURFVG9mbjZRQXlXVlR5UkplSkJWd1hXbGpL?=
 =?utf-8?B?UUhXSklsaENNQkVrTFB3dnZLUnhZZnRpL1JWMlY4YTlGMzlxd1AzOGNoNkpx?=
 =?utf-8?B?aUJoY1lpZWtrVStZcXZZMzJTRUlFWTVIU1VpNGQ3NTBGQ2hUU0d6V0dTT0xn?=
 =?utf-8?B?VnJzYVJXNFl5MnFIQmMvbk1xcUVrRVZVdFMrcEZpWjBmaFRUZ3FxanFKdDlL?=
 =?utf-8?B?bkNuUk5aOGtNTW53MFI0N1dsdHNWVEk5Y0I1N1k3dUV0MUZpeHBROFJ6ZW9R?=
 =?utf-8?B?UWY4RVE0QWtvRGtrbW9keG51YVVQKzEvYXc1bEpGL1k1a2pERWVHckZVRXNp?=
 =?utf-8?B?MTBHY0ZUOVdTd0k1TXVRNWtTVEExQm5BcjNQVjlkb21wYUYvUkowK2R2dTFi?=
 =?utf-8?B?REh4b21BZk13SHpLZmJlZ25yRkJ5OGF4Yisyc1AvcnFWNVZzd3RNWSt2alUv?=
 =?utf-8?B?eVEybjlDZHJaR3NHNlVsS2MvU0FpQW5pMVR1VkFWUHlFVUc5YTlnZDlOSS9n?=
 =?utf-8?B?Ri9Hc0pqUUJLbTF3eHFNVnpkd0JuK3dRdWRHMFZOTCtJSFJjNjNFMW1mY210?=
 =?utf-8?B?ZG5RVGpyM0V1dzgxNVhlYUtOU1Y3Z0trR3liYmFlVjJOT0dzZE0xaVFrMWFK?=
 =?utf-8?B?Wk1WMWVFS0U1TDkrbm9sM0NHRCtva3htVzFSOExGSkRLYjFHOTRnUkt2T3M0?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc89740-0c2e-4341-a3ca-08dbce14fff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 06:56:19.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKtmfr/UvsJypR2AaxD1nP5I3xa4e/ZAuA5zByr1OeXvxlrEnCgVfRxJDGi3FRnl6jJwYxxqXrQEoahzyph62oHcnmI6NIUqMlhWV437pDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2l0c3plbCwgUHJ6ZW15
c2xhdyA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDEzLCAyMDIzIDI6MzUgUE0NCj4gVG86IExva3Rpb25vdiwgQWxla3NhbmRyIDxhbGVrc2Fu
ZHIubG9rdGlvbm92QGludGVsLmNvbT47IGludGVsLXdpcmVkLQ0KPiBsYW5AbGlzdHMub3N1b3Ns
Lm9yZzsgTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsNCj4g
SmFnaWVsc2tpLCBKZWRyemVqIDxqZWRyemVqLmphZ2llbHNraUBpbnRlbC5jb20+DQo+IENjOiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggaXdsLW5leHQgdjVd
IGk0MGU6IGFkZCByZXN0b3JlIGRlZmF1bHQgc3BlZWQgd2hlbiBjaGFuZ2VkDQo+IFBIWSBkb2Vz
bid0IHN1cHBvcnQgaXQNCj4gDQo+IE9uIDEwLzEzLzIzIDEzOjUyLCBBbGVrc2FuZHIgTG9rdGlv
bm92IHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgdGhlcmUgd2FzIG5vIGxpbmsgYWZ0ZXIgcGx1Z2dp
bmcgYSBkaWZmZXJlbnQgdHlwZSBvZiBQSFkNCj4gPiBtb2R1bGUgaWYgdXNlciBmb3JjZWQgcHJl
dmlvdXMgUEhZIHNwZWNpZmljIGxpbmsgdHlwZS9zcGVlZCBiZWZvcmUuDQo+ID4NCj4gPiBBZGQg
cmVzZXQgbGluayBzcGVlZCBzZXR0aW5ncyB0byB0aGUgZGVmYXVsdCB2YWx1ZXMgZm9yIFBIWSBt
b2R1bGUsIGlmDQo+ID4gZGlmZmVyZW50IFBIWSBtb2R1bGUgaXMgaW5zZXJ0ZWQgYW5kIGN1cnJl
bnRseSBkZWZpbmVkIHVzZXItc3BlY2lmaWVkDQo+ID4gc3BlZWQgaXMgbm90IGNvbXBhdGlibGUg
d2l0aCB0aGlzIG1vZHVsZS4NCj4gPg0KPiA+IENvLWRldmVsb3BlZC1ieTogUmFkb3NsYXcgVHls
IDxyYWRvc2xhd3gudHlsQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWRvc2xhdyBU
eWwgPHJhZG9zbGF3eC50eWxAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBKZWRyemVqIEph
Z2llbHNraSA8amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+IHYxLT52MiBmaXhlZCBSZXZpZXdlZC1ieSB0YWdzDQo+ID4gdjItPnYzIGZpeGVk
IGNvbW1pdCBtZXNzYWdlcyBhbmQgdGFncw0KPiA+IHYzLT52NCBmaXhlZCBjb21taXQgbWVzc2Fn
ZSB0eXBvDQo+ID4gdjQtPnY1IGNjIHRvIG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gDQo+IGdv
b2QgbW92ZSEsDQo+IG5vdyB5b3UgaGF2ZSB0byBmb2N1cyBvbiB0aGUgcnVsZXMgbW9yZSwgbGlr
ZSB0aG9zZToNCj4gZG8gbm90IHBvc3QgbmV4dCB2ZXJzaW9uIGJlZm9yZSAyNGggb2YgcHJldiBv
bmU7DQo+IA0KT2sNCg0KPiBtb3JlIG1ldGFkYXRhOg0KPiBJIHdvdWxkIHJlbW92ZSB0aGUgd29y
ZCAnYWRkJyBmcm9tIHRoZSBTdWJqZWN0IGxpbmU7IFlvdSBzdGlsbCBuZWVkIHRvIGNoYW5nZQ0K
SSBkb24ndCBhZ3JlZSwgYmVjYXVzZSBpdCdzIG5vdCBhIGZpeCBpdCdzIGEgbmV3IGZlYXR1cmUg
aW1wbGVtZW50YXRpb24gPT4gJ2FkZCcgZmVhdHVyZS4NCklmIHlvdSBoYXZlIGEgYmV0dGVyIGlk
ZWEgcGxlYXNlIHN1Z2dlc3QgYSBmdWxsIGNvbW1pdCB0aXRsZSB3aGljaCBmaXRzIDcyIGNoYXJz
LiBXaGF0IEkgaGF2ZSBub3cgaXQgbXkgYmVzdC4NCg0KPiBhdXRob3IgdG8gUmFkb3NsYXcuDQo+
IA0KVGhlIHBhdGNoIHdhcyBzZXJpb3VzbHkgbW9kaWZpZWQsIHNvIHdlIGFyZSBjby1hdXRob3Jz
Lg0KQW5kIEknZCBiZXR0ZXIgbGVhdmUgbXkgZS1tYWlsLCB3aGljaCBpcyBzdGlsbCBhbGl2ZSwg
b24gdG9wIGZvciBiZXR0ZXIgY29tbXVuaXR5IHN1cHBvcnQuDQoNCj4gPiAtLS0NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMgfCA2NSAr
KysrKysrKysrKysrKysrKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2k0MGUvaTQwZV9tYWluLmMNCj4gPiBpbmRleCBkMGQwMjE4Li42ODI5NzIwIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2k0MGUvaTQwZV9tYWluLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQo+
ID4gQEAgLTEwMDc2LDYgKzEwMDc2LDU1IEBAIHN0YXRpYyB2b2lkIGk0MGVfcmVzZXRfc3VidGFz
ayhzdHJ1Y3QgaTQwZV9wZg0KPiAqcGYpDQo+ID4gICAJcnRubF91bmxvY2soKTsNCj4gPiAgIH0N
Cj4gPg0KPiA+ICsvKioNCj4gPiArICogaTQwZV9yZXN0b3JlX3N1cHBvcnRlZF9waHlfbGlua19z
cGVlZCAtIFJlc3RvcmUgZGVmYXVsdCBQSFkgc3BlZWQNCj4gPiArICogQHBmOiBib2FyZCBwcml2
YXRlIHN0cnVjdHVyZQ0KPiA+ICsgKg0KPiA+ICsgKiBTZXQgUEhZIG1vZHVsZSBzcGVlZHMgYWNj
b3JkaW5nIHRvIHZhbHVlcyBnb3QgZnJvbQ0KPiA+ICsgKiBpbml0aWFsIGxpbmsgc3BlZWQgYWJp
bGl0ZXMuDQo+ID4gKyAqKi8NCj4gPiArc3RhdGljIGludCBpNDBlX3Jlc3RvcmVfc3VwcG9ydGVk
X3BoeV9saW5rX3NwZWVkKHN0cnVjdCBpNDBlX3BmICpwZikNCj4gPiArew0KPiA+ICsJc3RydWN0
IGk0MGVfYXFfZ2V0X3BoeV9hYmlsaXRpZXNfcmVzcCBhYmlsaXRpZXM7DQo+ID4gKwlzdHJ1Y3Qg
aTQwZV9hcV9zZXRfcGh5X2NvbmZpZyBjb25maWcgPSB7MH07DQo+IA0KPiBqdXN0IGA9IHt9O2AN
Cj4gDQo+ID4gKwlzdHJ1Y3QgaTQwZV9odyAqaHcgPSAmcGYtPmh3Ow0KPiA+ICsJaW50IGVycjsN
Cj4gPiArDQo+ID4gKwllcnIgPSBpNDBlX2FxX2dldF9waHlfY2FwYWJpbGl0aWVzKGh3LCBmYWxz
ZSwgZmFsc2UsICZhYmlsaXRpZXMsIE5VTEwpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWRl
dl9kYmcoJnBmLT5wZGV2LT5kZXYsICJmYWlsZWQgdG8gZ2V0IHBoeSBjYXAuLCByZXQgPSAgJWkN
Cj4gbGFzdF9zdGF0dXMgPSAgJXNcbiIsDQo+ID4gKwkJCWVyciwgaTQwZV9hcV9zdHIoJnBmLT5o
dywgcGYtPmh3LmFxLmFzcV9sYXN0X3N0YXR1cykpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4g
Kwl9DQo+ID4gKwljb25maWcuZWVlX2NhcGFiaWxpdHkgPSBhYmlsaXRpZXMuZWVlX2NhcGFiaWxp
dHk7DQo+ID4gKwljb25maWcucGh5X3R5cGVfZXh0ID0gYWJpbGl0aWVzLnBoeV90eXBlX2V4dDsN
Cj4gPiArCWNvbmZpZy5sb3dfcG93ZXJfY3RybCA9IGFiaWxpdGllcy5kM19scGFuOw0KPiA+ICsJ
Y29uZmlnLmFiaWxpdGllcyA9IGFiaWxpdGllcy5hYmlsaXRpZXM7DQo+ID4gKwljb25maWcuYWJp
bGl0aWVzIHw9IEk0MEVfQVFfUEhZX0VOQUJMRV9BTjsNCj4gPiArCWNvbmZpZy5waHlfdHlwZSA9
IGFiaWxpdGllcy5waHlfdHlwZTsNCj4gPiArCWNvbmZpZy5lZWVyID0gYWJpbGl0aWVzLmVlZXJf
dmFsOw0KPiA+ICsJY29uZmlnLmZlY19jb25maWcgPSBhYmlsaXRpZXMuZmVjX2NmZ19jdXJyX21v
ZF9leHRfaW5mbyAmDQo+ID4gKwkJCSAgICBJNDBFX0FRX1BIWV9GRUNfQ09ORklHX01BU0s7DQo+
ID4gKwllcnIgPSBpNDBlX2FxX2dldF9waHlfY2FwYWJpbGl0aWVzKGh3LCBmYWxzZSwgdHJ1ZSwg
JmFiaWxpdGllcywgTlVMTCk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2X2RiZygmcGYt
PnBkZXYtPmRldiwgImdldCBzdXBwb3J0ZWQgcGh5IHR5cGVzIHJldCA9ICAlaQ0KPiA+ICtsYXN0
X3N0YXR1cyA9ICAlc1xuIiwNCj4gDQo+IHMvICAvIC9nDQo+IA0KPiAoaW4gRW5nbGlzaDogcmVw
bGFjZSBkb3VibGUgc3BhY2VzIGJ5IHNpbmdsZSBvbmVzKQ0KPiANCj4gPiArCQkJZXJyLCBpNDBl
X2FxX3N0cigmcGYtPmh3LCBwZi0+aHcuYXEuYXNxX2xhc3Rfc3RhdHVzKSk7DQo+ID4gKwkJcmV0
dXJuIGVycjsNCj4gPiArCX0NCj4gPiArCWNvbmZpZy5saW5rX3NwZWVkID0gYWJpbGl0aWVzLmxp
bmtfc3BlZWQ7DQo+ID4gKw0KPiA+ICsJZXJyID0gaTQwZV9hcV9zZXRfcGh5X2NvbmZpZyhodywg
JmNvbmZpZywgTlVMTCk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4g
KwllcnIgPSBpNDBlX2FxX3NldF9saW5rX3Jlc3RhcnRfYW4oaHcsIHRydWUsIE5VTEwpOw0KPiA+
ICsJaWYgKGVycikNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCXBmLT5ody5waHku
bGlua19pbmZvLnJlcXVlc3RlZF9zcGVlZHMgPSBjb25maWcubGlua19zcGVlZDsNCj4gPiArDQo+
ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgLyoqDQo+ID4gICAgKiBpNDBl
X2hhbmRsZV9saW5rX2V2ZW50IC0gSGFuZGxlIGxpbmsgZXZlbnQNCj4gPiAgICAqIEBwZjogYm9h
cmQgcHJpdmF0ZSBzdHJ1Y3R1cmUNCj4gPiBAQCAtMTAwODYsNiArMTAxMzUsNyBAQCBzdGF0aWMg
dm9pZCBpNDBlX2hhbmRsZV9saW5rX2V2ZW50KHN0cnVjdA0KPiBpNDBlX3BmICpwZiwNCj4gPiAg
IHsNCj4gPiAgIAlzdHJ1Y3QgaTQwZV9hcWNfZ2V0X2xpbmtfc3RhdHVzICpzdGF0dXMgPQ0KPiA+
ICAgCQkoc3RydWN0IGk0MGVfYXFjX2dldF9saW5rX3N0YXR1cyAqKSZlLT5kZXNjLnBhcmFtcy5y
YXc7DQo+ID4gKwlpbnQgZXJyOw0KPiA+DQo+ID4gICAJLyogRG8gYSBuZXcgc3RhdHVzIHJlcXVl
c3QgdG8gcmUtZW5hYmxlIExTRSByZXBvcnRpbmcNCj4gPiAgIAkgKiBhbmQgbG9hZCBuZXcgc3Rh
dHVzIGluZm9ybWF0aW9uIGludG8gdGhlIGh3IHN0cnVjdCBAQCAtMTAxMDksMTANCj4gPiArMTAx
NTksMTcgQEAgc3RhdGljIHZvaWQgaTQwZV9oYW5kbGVfbGlua19ldmVudChzdHJ1Y3QgaTQwZV9w
ZiAqcGYsDQo+ID4gICAJCSAgICAoIShzdGF0dXMtPmFuX2luZm8gJiBJNDBFX0FRX1FVQUxJRklF
RF9NT0RVTEUpKSAmJg0KPiA+ICAgCQkgICAgKCEoc3RhdHVzLT5saW5rX2luZm8gJiBJNDBFX0FR
X0xJTktfVVApKSAmJg0KPiA+ICAgCQkgICAgKCEocGYtPmZsYWdzICYNCj4gSTQwRV9GTEFHX0xJ
TktfRE9XTl9PTl9DTE9TRV9FTkFCTEVEKSkpIHsNCj4gPiAtCQkJZGV2X2VycigmcGYtPnBkZXYt
PmRldiwNCj4gPiAtCQkJCSJSeC9UeCBpcyBkaXNhYmxlZCBvbiB0aGlzIGRldmljZSBiZWNhdXNl
IGFuDQo+IHVuc3VwcG9ydGVkIFNGUCBtb2R1bGUgdHlwZSB3YXMgZGV0ZWN0ZWQuXG4iKTsNCj4g
PiAtCQkJZGV2X2VycigmcGYtPnBkZXYtPmRldiwNCj4gPiAtCQkJCSJSZWZlciB0byB0aGUgSW50
ZWwoUikgRXRoZXJuZXQgQWRhcHRlcnMgYW5kDQo+IERldmljZXMgVXNlciBHdWlkZSBmb3IgYSBs
aXN0IG9mIHN1cHBvcnRlZCBtb2R1bGVzLlxuIik7DQo+ID4gKwkJCWVyciA9IGk0MGVfcmVzdG9y
ZV9zdXBwb3J0ZWRfcGh5X2xpbmtfc3BlZWQocGYpOw0KPiA+ICsJCQlpZiAoZXJyKSB7DQo+ID4g
KwkJCQlkZXZfZXJyKCZwZi0+cGRldi0+ZGV2LA0KPiA+ICsJCQkJCSJSeC9UeCBpcyBkaXNhYmxl
ZCBvbiB0aGlzIGRldmljZQ0KPiBiZWNhdXNlIGFuIHVuc3VwcG9ydGVkIFNGUCBtb2R1bGUgdHlw
ZSB3YXMgZGV0ZWN0ZWQuXG4iKTsNCj4gPiArCQkJCWRldl9lcnIoJnBmLT5wZGV2LT5kZXYsDQo+
ID4gKwkJCQkJIlJlZmVyIHRvIHRoZSBJbnRlbChSKSBFdGhlcm5ldA0KPiBBZGFwdGVycyBhbmQg
RGV2aWNlcyBVc2VyIEd1aWRlDQo+ID4gK2ZvciBhIGxpc3Qgb2Ygc3VwcG9ydGVkIG1vZHVsZXMu
XG4iKTsNCj4gPiArDQo+ID4gKwkJCQlyZXR1cm47DQo+ID4gKwkJCX0NCj4gPiArDQo+ID4gKwkJ
CWRldl9pbmZvKCZwZi0+cGRldi0+ZGV2LCAiVGhlIHNlbGVjdGVkIHNwZWVkIGlzDQo+IGluY29t
cGF0aWJsZSB3aXRoDQo+ID4gK3RoZSBjb25uZWN0ZWQgbWVkaWEgdHlwZS4gUmVzZXR0aW5nIHRv
IHRoZSBkZWZhdWx0IHNwZWVkIHNldHRpbmcgZm9yDQo+ID4gK3RoZSBtZWRpYSB0eXBlLiIpOw0K
PiA+ICAgCQl9DQo+ID4gICAJfQ0KPiA+ICAgfQ0KDQo=

