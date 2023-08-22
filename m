Return-Path: <netdev+bounces-29796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C068784B96
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 22:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE422810F4
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69CD1DDE3;
	Tue, 22 Aug 2023 20:44:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB502018C
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 20:44:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DE10D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692737093; x=1724273093;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uvvqNXFkJ+tAKZewkjjbHhtTyrIoPOvdYf5BZ6QR/9U=;
  b=EbGxIF32iYhyYGu2IWTUy7pbYi8mXusaYPpLtUJG8p6X73uXe5CIy70j
   Q2Z+O3c5FaCTMor1DIySltTWbSjcJqTwLJYBlbHhJF3jWOr2+yLuaoIgd
   VYbK4ZqkrIyPdPESgPGkAWHmmN1mbkmwvhTrf3zltc3qvc1JJ37tQZ05l
   BiwLvUS+QY+S4m5zaBvovxf+vkOXFHZNBh1TSaxeHhF3/4diBlEOoMsTd
   m+Kex7Nw4OCNvDB2DyA1U4Imn87zIxZRNLpbqjtc9FXb63OlOTRwd8agw
   SrYJVipuNbw8KJhu8ehtp+0bzfNQExGU0pV6GIM8IFw25D5ZN2DmaLPij
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460351826"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="460351826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 13:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729946876"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="729946876"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 22 Aug 2023 13:44:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 13:44:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 13:44:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 13:44:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTgoCq5Jzl92hz3kZ72CXkGH50OVBBR5QE0QQnxRActeI/OaKgGkSnIa5DwPBS+UFgJ/x7nkxove+ycVTXZK4EgBsxZSNZDS1p7TS1Y67R26yzbw/777QyH9GbDwhB2fdnoEgchC5JhrCt4/zHaOBxxOcI/9pUZkGLzHDwVsLLuXkzXbXHEO7eKbD9Kw7MZqs2Ll4pWPb2IQR1gXavAgxYp24B5krH3alL7mdHICCKQ3r1cGFr4YRcCNU5e9e0LpuCNmC6yko/jfc7q41SrBI22dqIgMYxsAxwDWaqLZ3b853yYkSKIUnpdL1T9Tb4f8ffSTU3Say+9gAfKwAbfQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvvqNXFkJ+tAKZewkjjbHhtTyrIoPOvdYf5BZ6QR/9U=;
 b=X9WdnVCvHB/rSQxRrrxymEov0bdGLBSNLeLHqld/BglDvpyFR0SqeZWiUss5RikIXbpioRpUQ+jP9v2+2Is3P6farxAwKqwvly5AjrMZkYJeXprQ4GlphcC8UjXZ7BmD1ZD1P8OJo8hLHIEduKVkda/2bFl6XdlAkdiIW6OIo9wK/ufFR1CaIHjp+Q5Y9IDO86gzv8QMCqraYvXqVdPEXk3EUJOISAVaIX9nwtB5dA+VeRC4XRvT8m1arGc8dWdeiQUSKmRecBuOsQoK9UnR0r7tDkmE6HjgLi3Sjtd9tIK+AXl7/0WMQ7KsCd7OdQQ73D+kudVrozGfR0bTTt2h4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 20:44:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 20:44:50 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Stillwell Jr, Paul M" <paul.m.stillwell.jr@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, Leon Romanovsky <leon@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "Pucha, HimasekharX Reddy"
	<himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net-next v3 2/5] ice: configure FW logging
Thread-Topic: [PATCH net-next v3 2/5] ice: configure FW logging
Thread-Index: AQHZz5qgpheICe1Uo0qEgXq8uM0hj6/rsEYAgANTOwCAAOaTgIAAFqIAgAVsWgCAAWZKgA==
Date: Tue, 22 Aug 2023 20:44:50 +0000
Message-ID: <CO1PR11MB5089C1ECBE60224BD7C0517FD61FA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
 <20230818111049.GY22185@unreal>
 <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
 <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
In-Reply-To: <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SA1PR11MB8326:EE_
x-ms-office365-filtering-correlation-id: 042d9428-6769-466a-2cb8-08dba350a183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mpDCt89j1WvD9CuijMNITP/leQwrjmb4RhMuiKdn4qk8Ex1Fec3gy0OL04Wz2W2FEzlnPZt24Q0TDbwGtq+tyKgUkXBP65it/1NEC++mNJAi4St71XIIcnydFrKQ8abOutBEcarSFSkAHzRgeY4aYNp4h0cirang/MZWnqdpydi5e5vlsOx54FtvNTNYyoqmrEDfnbarondZ/e+GJTVX3gvvUuEczo265CRDgVi7PEwPl0M7+WrgJLOy9vWxuSP7iS9x2ApTH+0WDsrbIh+YAbzQ94j65ZnR5ia5cbtNP0afjHnBE6s+/fSSKGQZKDO79UOxrdWBshBTvyrfDZVX0a2sy0TwaqTZH3nYS1SJxbTkffyYgrX6QylDUUCk9inF91Ea9YnYq761lgqJemG5crodzOg4/39pIu5RUx6Gh0R3+P0TNgRuE14uaaExAj99gpzOvomBgeLbZaTCatig8KebS/r6NjwvbXPXR6DEj6fQneMkQkiNEUR+Q5nJaQr7lO6kJg8ijLrpiE/QOLPACRPwKEBTxz881j421/3WFyCSRHyq//rSl/nH22TPvyibY5D2jPGqURJ57536RHxV7TduMwi7abe/JqXDbrqaCuPB75eFvxi3cAWqsPJ4qi+6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(38070700005)(38100700002)(6506007)(53546011)(83380400001)(5660300002)(26005)(33656002)(52536014)(86362001)(7696005)(8676002)(107886003)(8936002)(4326008)(316002)(66946007)(9686003)(64756008)(54906003)(76116006)(66556008)(66446008)(66476007)(110136005)(66899024)(82960400001)(478600001)(122000001)(71200400001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVDaElOcmp4MlprRldmU1U1U2YvVzhtRUNocGx1N0U4TU1rVmxlWEtPMlBE?=
 =?utf-8?B?b1o0NDVDcTUvUCtMN0lPdVpLdnpINmI1RzArS09xbnluU0l4Um8zTmo1ejBx?=
 =?utf-8?B?Yk9vNEdGalFSU3ptdkU4aVJkQzlySzU4MTBhRnpLWCtaRCtQeDFScmhPNm5l?=
 =?utf-8?B?RlFweHNJS3VCOU9xaExJTGE1RjBpdHIxVUFVNlAxNTZjeCsrdVY4Uzlub0V3?=
 =?utf-8?B?ZEFicDZtbTZ4WTVnZDFhMlFQOVg3NDV5c3Z4RUJydE9JOUtRbTBuelBWYUNs?=
 =?utf-8?B?Rkw4MTFENVpRMEhTanp6dzd4L3dWMnVXYkkwc2V4QlZYYkppNWpTYjBGLzJa?=
 =?utf-8?B?N013Nkc0MmU2MkJETlJja1kwUlBWZXhnTWhWMzRyVnVpc0dTZFBJcFQ3b0k3?=
 =?utf-8?B?a04wcm4xL2pCOUoyZ2h3c3VjYkk4bVFJcjdjaVhyZmhWSktITHlCUTh2YXFl?=
 =?utf-8?B?TGVLZzE0KzA2Yi90S0xDdUxERUg2UDZ6cHF3NG5Qa3ZLc3hCNmx3eVBEbDk0?=
 =?utf-8?B?NnliWFkzeFlpdlM2YmJzVjhMVEl0cHp3RFhQcllWWVQ3MjJURmYxQ0ZxMFlU?=
 =?utf-8?B?VmZrOTlISVlWd2NldC94VnlZOVRyYk9seFNjY1Ixc29DclJmcWFRVFEvNWZm?=
 =?utf-8?B?MlNxdkpxS2w0VENFZHVHblRWaGVieWl1QlhzeVptbUpNZEQ4ckhRUDk2TVVJ?=
 =?utf-8?B?UloyeEE3UHcxSTEzUXI0ZFl5bmJiQUhtbGk0N2g4K2tpRmYyZlRyZENOenhW?=
 =?utf-8?B?Vm5qNWdlMElaMkRTdDhMaTFpdTdSQnU2aFUva1gzamFlNTJMU3BTYlIrQ2g2?=
 =?utf-8?B?SEVRODNSc0JKcW5sL0FQRUFxeWZHZWM1NDdtV2RxNzU3Rk45THVDeGxlQ3hL?=
 =?utf-8?B?eEd0azFyNTBWWUgzZkdWdUdnT1dSNzU3MXJZYmdOYUdhY2ZEaGJLYzQvY3Fm?=
 =?utf-8?B?Nm1Yb3crdFZEWXNSN2dJVEY3YllvMVJCWnJ4bVFRVWVGcThsVHlQam10aHh6?=
 =?utf-8?B?OCtMQ3EyVnlxQ0lOdjRUMnJndkhEanBXNDFyMFg4YUN3N3FVclRObHhIeHNI?=
 =?utf-8?B?dG1iNnA0bk5zck14Snl6SS81VlRoTGpKVDlscG0vUTYxRXFxMlVKeHg2QTAy?=
 =?utf-8?B?aVU5NDMyaTkveTlpSU5RZGwzZ2xWUXJXUXdML3hESUFTbFJrWkNlRlFTUUFV?=
 =?utf-8?B?dlk0VXJySXJpOGMrNUpXZjFRaE1LWmZ2LzBGbkpieGZhOHJxNTVUeStBeE9J?=
 =?utf-8?B?WjBabzVvSFhVRFVKR0ZxUnJIUGYzMW1CQnFNdHZRME1NK3pseXE3bEUySlFD?=
 =?utf-8?B?UDJGMjdnVFgxQU5sWFVRQXpvNkgvQnFra3JjamtuSFpNUW4zaVhUVzlXc0pQ?=
 =?utf-8?B?NzYxbHJIRENuYldwYWVrekZzaDlSWmJWYkJjTHBxSFpwOFpGeUlBNXd0NXB4?=
 =?utf-8?B?aGUzWm5FczZUUTIxQnRHZUdNZkx0cWk1RTc3YmVqMU5SbHVrWmgreXdBeDNI?=
 =?utf-8?B?ejZzeVRZdWxxUStGSk81Tk91Nmp6TnpNVkxFcFYraTdWNWdLTHRTek5PaVdj?=
 =?utf-8?B?NXVxcXhQMmhzTCtQTTgvQ1JkTkdhQjZCZ0M3M0VwTWFFdGhyOGpCNVk3N0Vz?=
 =?utf-8?B?MUplR1NqREFTb2ZveGNTaXNVaUdYSlNjY0R4M0ZCN2FLWm9WbGtGd0N6dGN3?=
 =?utf-8?B?MjI5MWc1WGFpZDdaQk5YOVNIZjJXeU1JdXNmNWNsNDF0dlFhWHRHNmpHbEN2?=
 =?utf-8?B?TkdNby91enZPa3lxWXpuWGNiRXVxQVFIcUpMeU9KelZwOG1iaHFpMnVQWTBl?=
 =?utf-8?B?NUp1cVR0a1lXZ3d5MkMwMlJ2ay9WZzhhVHBrcVpPcGVNaWtMWXV5TWR2ZjFN?=
 =?utf-8?B?bnR5ckhJWWxGU2VhSFhxN2MwRWVycDliQUw1QkwxcW0zWkd6aENGMjdXWVBD?=
 =?utf-8?B?a3B4QStFTVVjK2Y2VzBGU0V1YkUzbzh2WkNwK2UyWFZiUCtpVFRxVnJJWXZj?=
 =?utf-8?B?RGtvcXpQbzJlZ0lFSHZyWlZsRWFzcjFPKzBKaVdEOE53cytUSW5XVnVIcUsr?=
 =?utf-8?B?QXJNeUhmMUszQTRTSzh2ZXd6dHNEMitIVmRZNXpBL3NIbEFpclpMQU5XUWNK?=
 =?utf-8?Q?c8d6Mu4b6olhqstXjjWeUCEU+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042d9428-6769-466a-2cb8-08dba350a183
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 20:44:50.5480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seeeJkGeZQMUTEXlPUGNbBP8CbxPTeY+VJ23VA+VMRasqK0E6nQ2bC+TJMUyLA4s3L7VuSh7eAdxumxkw2sEhgkih53fCj7fGquakk+NEXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RpbGx3ZWxsIEpyLCBQ
YXVsIE0gPHBhdWwubS5zdGlsbHdlbGwuanJAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyMSwgMjAyMyA0OjIxIFBNDQo+IFRvOiBLaXRzemVsLCBQcnplbXlzbGF3IDxwcnplbXlz
bGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgTGVvbiBSb21hbm92c2t5DQo+IDxsZW9uQGtlcm5lbC5v
cmc+DQo+IENjOiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+
OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQu
Y29tOyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBLZWxs
ZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT47DQo+IGhvcm1zQGtlcm5lbC5v
cmc7IFB1Y2hhLCBIaW1hc2VraGFyWCBSZWRkeQ0KPiA8aGltYXNla2hhcngucmVkZHkucHVjaGFA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYzIDIvNV0gaWNlOiBj
b25maWd1cmUgRlcgbG9nZ2luZw0KPiANCj4gT24gOC8xOC8yMDIzIDU6MzEgQU0sIFByemVtZWsg
S2l0c3plbCB3cm90ZToNCj4gPiBPbiA4LzE4LzIzIDEzOjEwLCBMZW9uIFJvbWFub3Zza3kgd3Jv
dGU6DQo+ID4+IE9uIFRodSwgQXVnIDE3LCAyMDIzIGF0IDAyOjI1OjM0UE0gLTA3MDAsIFBhdWwg
TSBTdGlsbHdlbGwgSnIgd3JvdGU6DQo+ID4+PiBPbiA4LzE1LzIwMjMgMTE6MzggQU0sIExlb24g
Um9tYW5vdnNreSB3cm90ZToNCj4gPj4+PiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAwOTo1Nzo0
N0FNIC0wNzAwLCBUb255IE5ndXllbiB3cm90ZToNCj4gPj4+Pj4gRnJvbTogUGF1bCBNIFN0aWxs
d2VsbCBKciA8cGF1bC5tLnN0aWxsd2VsbC5qckBpbnRlbC5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+
IFVzZXJzIHdhbnQgdGhlIGFiaWxpdHkgdG8gZGVidWcgRlcgaXNzdWVzIGJ5IHJldHJpZXZpbmcg
dGhlDQo+ID4+Pj4+IEZXIGxvZ3MgZnJvbSB0aGUgRTh4eCBkZXZpY2VzLiBVc2UgZGVidWdmcyB0
byBhbGxvdyB0aGUgdXNlciB0bw0KPiA+Pj4+PiByZWFkL3dyaXRlIHRoZSBGVyBsb2cgY29uZmln
dXJhdGlvbiBieSBhZGRpbmcgYSAnZndsb2cvbW9kdWxlcycgZmlsZS4NCj4gPj4+Pj4gUmVhZGlu
ZyB0aGUgZmlsZSB3aWxsIHNob3cgZWl0aGVyIHRoZSBjdXJyZW50bHkgcnVubmluZw0KPiA+Pj4+
PiBjb25maWd1cmF0aW9uIG9yDQo+ID4+Pj4+IHRoZSBuZXh0IGNvbmZpZ3VyYXRpb24gKGlmIHRo
ZSB1c2VyIGhhcyBjaGFuZ2VkIHRoZSBjb25maWd1cmF0aW9uKS4NCj4gPj4+Pj4gV3JpdGluZyB0
byB0aGUgZmlsZSB3aWxsIHVwZGF0ZSB0aGUgY29uZmlndXJhdGlvbiwgYnV0IE5PVCBlbmFibGUg
dGhlDQo+ID4+Pj4+IGNvbmZpZ3VyYXRpb24gKHRoYXQgaXMgYSBzZXBhcmF0ZSBjb21tYW5kKS4N
Cj4gPj4+Pj4NCj4gPj4+Pj4gVG8gc2VlIHRoZSBzdGF0dXMgb2YgRlcgbG9nZ2luZyB0aGVuIHJl
YWQgdGhlICdmd2xvZy9tb2R1bGVzJyBmaWxlDQo+ID4+Pj4+IGxpa2UNCj4gPj4+Pj4gdGhpczoN
Cj4gPj4+Pj4NCj4gPj4+Pj4gY2F0IC9zeXMva2VybmVsL2RlYnVnL2ljZS8wMDAwXDoxOFw6MDAu
MC9md2xvZy9tb2R1bGVzDQo+ID4+Pj4+DQo+ID4+Pj4+IFRvIGNoYW5nZSB0aGUgY29uZmlndXJh
dGlvbiBvZiBGVyBsb2dnaW5nIHRoZW4gd3JpdGUgdG8gdGhlDQo+ID4+Pj4+ICdmd2xvZy9tb2R1
bGVzJw0KPiA+Pj4+PiBmaWxlIGxpa2UgdGhpczoNCj4gPj4+Pj4NCj4gPj4+Pj4gZWNobyBEQ0Ig
Tk9STUFMID4NCj4gL3N5cy9rZXJuZWwvZGVidWcvaWNlLzAwMDBcOjE4XDowMC4wL2Z3bG9nL21v
ZHVsZXMNCj4gPj4+Pj4NCj4gPj4+Pj4gVGhlIGZvcm1hdCB0byBjaGFuZ2UgdGhlIGNvbmZpZ3Vy
YXRpb24gaXMNCj4gPj4+Pj4NCj4gPj4+Pj4gZWNobyA8Zndsb2dfbW9kdWxlPiA8Zndsb2dfbGV2
ZWw+ID4gL3N5cy9rZXJuZWwvZGVidWcvaWNlLzxwY2kgZGV2aWNlDQo+ID4+Pj4NCj4gPj4+PiBU
aGlzIGxpbmUgaXMgdHJ1bmNhdGVkLCBpdCBpcyBub3QgY2xlYXIgd2hlcmUgeW91IGFyZSB3cml0
aW5nLg0KPiA+Pj4NCj4gPj4+IEdvb2QgY2F0Y2gsIEkgZG9uJ3Qga25vdyBob3cgSSBtaXNzZWQg
dGhpcy4uLiBXaWxsIGZpeA0KPiA+Pj4NCj4gPj4+PiBBbmQgbW9yZSBnZW5lcmFsIHF1ZXN0aW9u
LCBhIGxvbmcgdGltZSBhZ28sIG5ldGRldiBoYWQgYSBwb2xpY3kgb2YNCj4gPj4+PiBub3QtYWxs
b3dpbmcgd3JpdGluZyB0byBkZWJ1Z2ZzLCB3YXMgaXQgY2hhbmdlZD8NCj4gPj4+Pg0KPiA+Pj4N
Cj4gPj4+IEkgaGFkIHRoaXMgc2FtZSB0aG91Z2h0IGFuZCBpdCBzZWVtcyBsaWtlIHRoZXJlIHdl
cmUgMiBjb25jZXJucyBpbg0KPiA+Pj4gdGhlIHBhc3QNCj4gPj4NCj4gPj4gTWF5YmUsIEknbSBu
b3QgZW5vdWdoIHRpbWUgaW4gbmV0ZGV2IHdvcmxkIHRvIGtub3cgdGhlIGhpc3RvcnkuDQo+ID4+
DQo+ID4+Pg0KPiA+Pj4gMS4gSGF2aW5nIGEgc2luZ2xlIGZpbGUgdGhhdCB3YXMgcmVhZC93cml0
ZSB3aXRoIGxvdHMgb2YgY29tbWFuZHMgZ29pbmcNCj4gPj4+IHRocm91Z2ggaXQNCj4gPj4+IDIu
IEhhdmluZyBjb2RlIGluIHRoZSBkcml2ZXIgdG8gcGFyc2UgdGhlIHRleHQgZnJvbSB0aGUgY29t
bWFuZHMgdGhhdA0KPiA+Pj4gd2FzDQo+ID4+PiBlcnJvci9zZWN1cml0eSBwcm9uZQ0KPiA+Pj4N
Cj4gPj4+IFdlIGhhdmUgYWRkcmVzc2VkIHRoaXMgaW4gMiB3YXlzOg0KPiA+Pj4gMS4gU3BsaXQg
dGhlIGNvbW1hbmRzIGludG8gbXVsdGlwbGUgZmlsZXMgdGhhdCBoYXZlIGEgc2luZ2xlIHB1cnBv
c2UNCj4gPj4+IDIuIFVzZSBrZXJuZWwgcGFyc2luZyBmdW5jdGlvbnMgZm9yIGFueXRoaW5nIHdo
ZXJlIHdlICpoYXZlKiB0byBwYXNzDQo+ID4+PiB0ZXh0IHRvDQo+ID4+PiBkZWNvZGUNCj4gPj4+
DQo+ID4+Pj4+DQo+ID4+Pj4+IHdoZXJlDQo+ID4+Pj4+DQo+ID4+Pj4+ICogZndsb2dfbGV2ZWwg
aXMgYSBuYW1lIGFzIGRlc2NyaWJlZCBiZWxvdy4gRWFjaCBsZXZlbCBpbmNsdWRlcyB0aGUNCj4g
Pj4+Pj4gwqDCoMKgIG1lc3NhZ2VzIGZyb20gdGhlIHByZXZpb3VzL2xvd2VyIGxldmVsDQo+ID4+
Pj4+DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICogTk9ORQ0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDC
oCAqwqDCoMKgIEVSUk9SDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgV0FSTklORw0K
PiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIE5PUk1BTA0KPiA+Pj4+PiDCoMKgwqDCoMKg
wqDCoCAqwqDCoMKgIFZFUkJPU0UNCj4gPj4+Pj4NCj4gPj4+Pj4gKiBmd2xvZ19ldmVudCBpcyBh
IG5hbWUgdGhhdCByZXByZXNlbnRzIHRoZSBtb2R1bGUgdG8gcmVjZWl2ZQ0KPiA+Pj4+PiBldmVu
dHMgZm9yLg0KPiA+Pj4+PiDCoMKgwqAgVGhlIG1vZHVsZSBuYW1lcyBhcmUNCj4gPj4+Pj4NCj4g
Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBHRU5FUkFMDQo+ID4+Pj4+IMKgwqDCoMKgwqDC
oMKgICrCoMKgwqAgQ1RSTA0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIExJTksNCj4g
Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBMSU5LX1RPUE8NCj4gPj4+Pj4gwqDCoMKgwqDC
oMKgwqAgKsKgwqDCoCBETkwNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBJMkMNCj4g
Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBTRFANCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAg
KsKgwqDCoCBNRElPDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgQURNSU5RDQo+ID4+
Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgSERNQQ0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAq
wqDCoMKgIExMRFANCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBEQ0JYDQo+ID4+Pj4+
IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgRENCDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKg
wqAgWExSDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgTlZNDQo+ID4+Pj4+IMKgwqDC
oMKgwqDCoMKgICrCoMKgwqAgQVVUSA0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIFZQ
RA0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIElPU0YNCj4gPj4+Pj4gwqDCoMKgwqDC
oMKgwqAgKsKgwqDCoCBQQVJTRVINCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBTVw0K
PiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIFNDSEVEVUxFUg0KPiA+Pj4+PiDCoMKgwqDC
oMKgwqDCoCAqwqDCoMKgIFRYUQ0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCAqwqDCoMKgIFJTVkQN
Cj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBQT1NUDQo+ID4+Pj4+IMKgwqDCoMKgwqDC
oMKgICrCoMKgwqAgV0FUQ0hET0cNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBUQVNL
X0RJU1BBVENIDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgTU5HDQo+ID4+Pj4+IMKg
wqDCoMKgwqDCoMKgICrCoMKgwqAgU1lOQ0UNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDC
oCBIRUFMVEgNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqAgKsKgwqDCoCBUU0RSVg0KPiA+Pj4+PiDC
oMKgwqDCoMKgwqDCoCAqwqDCoMKgIFBGUkVHDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKg
wqAgTURMVkVSDQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgICrCoMKgwqAgQUxMDQo+ID4+Pj4+DQo+
ID4+Pj4+IFRoZSBuYW1lIEFMTCBpcyBzcGVjaWFsIGFuZCBzcGVjaWZpZXMgc2V0dGluZyBhbGwg
b2YgdGhlIG1vZHVsZXMgdG8NCj4gPj4+Pj4gdGhlDQo+ID4+Pj4+IHNwZWNpZmllZCBmd2xvZ19s
ZXZlbC4NCj4gPj4+Pj4NCj4gPj4+Pj4gSWYgdGhlIE5WTSBzdXBwb3J0cyBGVyBsb2dnaW5nIHRo
ZW4gdGhlIGZpbGUgJ2Z3bG9nJyB3aWxsIGJlIGNyZWF0ZWQNCj4gPj4+Pj4gdW5kZXIgdGhlIFBD
SSBkZXZpY2UgSUQgZm9yIHRoZSBpY2UgZHJpdmVyLiBJZiB0aGUgZmlsZSBkb2VzIG5vdCBleGlz
dA0KPiA+Pj4+PiB0aGVuIGVpdGhlciB0aGUgTlZNIGRvZXNuJ3Qgc3VwcG9ydCBGVyBsb2dnaW5n
IG9yIGRlYnVnZnMgaXMgbm90DQo+ID4+Pj4+IGVuYWJsZWQNCj4gPj4+Pj4gb24gdGhlIHN5c3Rl
bS4NCj4gPj4+Pj4NCj4gPj4+Pj4gSW4gYWRkaXRpb24gdG8gY29uZmlndXJpbmcgdGhlIG1vZHVs
ZXMsIHRoZSB1c2VyIGNhbiBhbHNvIGNvbmZpZ3VyZQ0KPiA+Pj4+PiB0aGUNCj4gPj4+Pj4gbnVt
YmVyIG9mIGxvZyBtZXNzYWdlcyAocmVzb2x1dGlvbikgdG8gaW5jbHVkZSBpbiBhIHNpbmdsZSBB
ZG1pbg0KPiA+Pj4+PiBSZWNlaXZlDQo+ID4+Pj4+IFF1ZXVlIChBUlEpIGV2ZW50LlRoZSByYW5n
ZSBpcyAxLTEyOCAoMSBtZWFucyBwdXNoIGV2ZXJ5IGxvZw0KPiA+Pj4+PiBtZXNzYWdlLCAxMjgN
Cj4gPj4+Pj4gbWVhbnMgcHVzaCBvbmx5IHdoZW4gdGhlIG1heCBBUSBjb21tYW5kIGJ1ZmZlciBp
cyBmdWxsKS4gVGhlIHN1Z2dlc3RlZA0KPiA+Pj4+PiB2YWx1ZSBpcyAxMC4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gVG8gc2VlL2NoYW5nZSB0aGUgcmVzb2x1dGlvbiB0aGUgdXNlciBjYW4gcmVhZC93cml0
ZSB0aGUNCj4gPj4+Pj4gJ2Z3bG9nL3Jlc29sdXRpb24nIGZpbGUuIEFuIGV4YW1wbGUgY2hhbmdp
bmcgdGhlIHZhbHVlIHRvIDUwIGlzDQo+ID4+Pj4+DQo+ID4+Pj4+IGVjaG8gNTAgPiAvc3lzL2tl
cm5lbC9kZWJ1Zy9pY2UvMDAwMFw6MThcOjAwLjAvZndsb2cvcmVzb2x1dGlvbg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQYXVsIE0gU3RpbGx3ZWxsIEpyIDxwYXVsLm0uc3RpbGx3
ZWxsLmpyQGludGVsLmNvbT4NCj4gPj4+Pj4gVGVzdGVkLWJ5OiBQdWNoYSBIaW1hc2VraGFyIFJl
ZGR5DQo+ID4+Pj4+IDxoaW1hc2VraGFyeC5yZWRkeS5wdWNoYUBpbnRlbC5jb20+IChBIENvbnRp
bmdlbnQgd29ya2VyIGF0IEludGVsKQ0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUb255IE5ndXll
biA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiDCoMKg
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9NYWtlZmlsZcKgwqDCoMKgwqDCoCB8wqDC
oCA0ICstDQo+ID4+Pj4+IMKgwqAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZS5o
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxOCArDQo+ID4+Pj4+IMKgwqAgLi4uL25ldC9ldGhlcm5l
dC9pbnRlbC9pY2UvaWNlX2FkbWlucV9jbWQuaMKgwqAgfMKgIDgwICsrKysNCj4gPj4+Pj4gwqDC
oCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2NvbW1vbi5jwqDCoCB8wqDCoCA1
ICsNCj4gPj4+Pj4gwqDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2RlYnVn
ZnMuY8KgIHwgNDUwDQo+ID4+Pj4+ICsrKysrKysrKysrKysrKysrKw0KPiA+Pj4+PiDCoMKgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZndsb2cuY8KgwqDCoCB8IDIzMSArKysr
KysrKysNCj4gPj4+Pj4gwqDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2Z3
bG9nLmjCoMKgwqAgfMKgIDU1ICsrKw0KPiA+Pj4+PiDCoMKgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2ljZS9pY2VfbWFpbi5jwqDCoMKgwqAgfMKgIDIxICsNCj4gPj4+Pj4gwqDCoCBkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3R5cGUuaMKgwqDCoMKgIHzCoMKgIDQgKw0K
PiA+Pj4+PiDCoMKgIDkgZmlsZXMgY2hhbmdlZCwgODY3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9kZWJ1Z2ZzLmMNCj4gPj4+Pj4gwqDCoCBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9md2xvZy5jDQo+ID4+Pj4+IMKg
wqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vf
Zndsb2cuaA0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL01ha2VmaWxlDQo+ID4+Pj4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWNlL01ha2VmaWxlDQo+ID4+Pj4+IGluZGV4IDk2MDI3N2Q3OGUwOS4uZDQzYTU5ZTVmOGVl
IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvTWFr
ZWZpbGUNCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL01ha2Vm
aWxlDQo+ID4+Pj4+IEBAIC0zNCw3ICszNCw4IEBAIGljZS15IDo9IGljZV9tYWluLm/CoMKgwqAg
XA0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCBpY2VfbGFnLm/CoMKgwqAgXA0KPiA+Pj4+PiDCoMKg
wqDCoMKgwqDCoCBpY2VfZXRodG9vbC5vwqAgXA0KPiA+Pj4+PiDCoMKgwqDCoMKgwqDCoCBpY2Vf
cmVwci5vwqDCoMKgIFwNCj4gPj4+Pj4gLcKgwqDCoMKgIGljZV90Y19saWIubw0KPiA+Pj4+PiAr
wqDCoMKgwqAgaWNlX3RjX2xpYi5vwqDCoMKgIFwNCj4gPj4+Pj4gK8KgwqDCoMKgIGljZV9md2xv
Zy5vDQo+ID4+Pj4+IMKgwqAgaWNlLSQoQ09ORklHX1BDSV9JT1YpICs9wqDCoMKgIFwNCj4gPj4+
Pj4gwqDCoMKgwqDCoMKgIGljZV9zcmlvdi5vwqDCoMKgwqDCoMKgwqAgXA0KPiA+Pj4+PiDCoMKg
wqDCoMKgwqAgaWNlX3ZpcnRjaG5sLm/CoMKgwqDCoMKgwqDCoCBcDQo+ID4+Pj4+IEBAIC00OSwz
ICs1MCw0IEBAIGljZS0kKENPTkZJR19SRlNfQUNDRUwpICs9IGljZV9hcmZzLm8NCj4gPj4+Pj4g
wqDCoCBpY2UtJChDT05GSUdfWERQX1NPQ0tFVFMpICs9IGljZV94c2subw0KPiA+Pj4+PiDCoMKg
IGljZS0kKENPTkZJR19JQ0VfU1dJVENIREVWKSArPSBpY2VfZXN3aXRjaC5vIGljZV9lc3dpdGNo
X2JyLm8NCj4gPj4+Pj4gwqDCoCBpY2UtJChDT05GSUdfR05TUykgKz0gaWNlX2duc3Mubw0KPiA+
Pj4+PiAraWNlLSQoQ09ORklHX0RFQlVHX0ZTKSArPSBpY2VfZGVidWdmcy5vDQo+ID4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlLmgNCj4gPj4+Pj4g
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlLmgNCj4gPj4+Pj4gaW5kZXggNWFj
MGFkMTJmOWYxLi5lNmRkOWY2ZjllZWUgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2ludGVsL2ljZS9pY2UuaA0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlLmgNCj4gPj4+Pj4gQEAgLTU1Niw2ICs1NTYsOCBAQCBzdHJ1Y3Qg
aWNlX3BmIHsNCj4gPj4+Pj4gwqDCoMKgwqDCoMKgIHN0cnVjdCBpY2VfdnNpX3N0YXRzICoqdnNp
X3N0YXRzOw0KPiA+Pj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IGljZV9zdyAqZmlyc3Rfc3c7wqDC
oMKgIC8qIGZpcnN0IHN3aXRjaCBjcmVhdGVkIGJ5DQo+ID4+Pj4+IGZpcm13YXJlICovDQo+ID4+
Pj4+IMKgwqDCoMKgwqDCoCB1MTYgZXN3aXRjaF9tb2RlO8KgwqDCoMKgwqDCoMKgIC8qIGN1cnJl
bnQgbW9kZSBvZiBlc3dpdGNoICovDQo+ID4+Pj4+ICvCoMKgwqAgc3RydWN0IGRlbnRyeSAqaWNl
X2RlYnVnZnNfcGY7DQo+ID4+Pj4+ICvCoMKgwqAgc3RydWN0IGRlbnRyeSAqaWNlX2RlYnVnZnNf
cGZfZndsb2c7DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWNlX3ZmcyB2ZnM7DQo+ID4+
Pj4+IMKgwqDCoMKgwqDCoCBERUNMQVJFX0JJVE1BUChmZWF0dXJlcywgSUNFX0ZfTUFYKTsNCj4g
Pj4+Pj4gwqDCoMKgwqDCoMKgIERFQ0xBUkVfQklUTUFQKHN0YXRlLCBJQ0VfU1RBVEVfTkJJVFMp
Ow0KPiA+Pj4+PiBAQCAtODYxLDYgKzg2MywyMiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaWNlX2lz
X2FkcV9hY3RpdmUoc3RydWN0DQo+ID4+Pj4+IGljZV9wZiAqcGYpDQo+ID4+Pj4+IMKgwqDCoMKg
wqDCoCByZXR1cm4gZmFsc2U7DQo+ID4+Pj4+IMKgwqAgfQ0KPiA+Pj4+PiArI2lmZGVmIENPTkZJ
R19ERUJVR19GUw0KPiA+Pj4+DQo+ID4+Pj4gVGhlcmUgaXMgbm8gbmVlZCBpbiB0aGlzIENPTkZJ
R19ERUJVR19GUyBhbmQgY29kZSBzaG91bGQgYmUgd3JpdHRlbg0KPiA+Pj4+IHdpdGhvdXQgZGVi
dWdmcyBzdHVicy4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlz
IGNvbW1lbnQuLi4gSWYgdGhlIGtlcm5lbCBpcyBjb25maWd1cmVkICp3aXRob3V0Kg0KPiA+Pj4g
ZGVidWdmcywgd29uJ3QgdGhlIGtlcm5lbCBmYWlsIHRvIGNvbXBpbGUgZHVlIHRvIG1pc3Npbmcg
ZnVuY3Rpb25zIGlmIHdlDQo+ID4+PiBkb24ndCBkbyB0aGlzPw0KPiA+Pg0KPiA+PiBJdCB3aWxs
IHdvcmsgZmluZSwgc2VlIGluY2x1ZGUvbGludXgvZGVidWdmcy5oLg0KPiA+DQo+ID4gTmljZSwg
YXMtaXMgaW1wbCBvZiBpY2VfZGVidWdmc19md2xvZ19pbml0KCkgd291bGQganVzdCBmYWlsIG9u
IGZpcnN0DQo+ID4gZGVidWdmcyBBUEkgY2FsbC4NCj4gPg0KPiANCj4gSSd2ZSB0aG91Z2h0IGFi
b3V0IHRoaXMgc29tZSBtb3JlIGFuZCBJIGFtIGNvbmZ1c2VkIHdoYXQgdG8gZG8uIEluIHRoZQ0K
PiBNYWtlZmlsZSB0aGVyZSBpcyBhIGJpdCB0aGF0IHJlbW92ZXMgaWNlX2RlYnVnZnMubyBpZiBD
T05GSUdfREVCVUdfRlMgaXMNCj4gbm90IHNldC4gVGhpcyB3b3VsZCByZXN1bHQgaW4gdGhlIHN0
dWJzIGJlaW5nIG5lZWRlZCAoc2luY2UgdGhlDQo+IGZ1bmN0aW9ucyBhcmUgY2FsbGVkIGZyb20g
aWNlX2Z3bG9nLmMpLiBJbiB0aGlzIGNhc2UgdGhlIGNvZGUgd291bGQgbm90DQo+IGNvbXBpbGUg
KHNpbmNlIHRoZSBmdW5jdGlvbnMgd291bGQgYmUgbWlzc2luZykuIFNob3VsZCBJIHJlbW92ZSB0
aGUgY29kZQ0KPiBmcm9tIHRoZSBNYWtlZmlsZSB0aGF0IGRlYWxzIHdpdGggaWNlX2RlYnVnZnMu
byAod2hpY2ggZG9lc24ndCBtYWtlDQo+IHNlbnNlIHNpbmNlIHRoZW4gdGhlcmUgd2lsbCBiZSBj
b2RlIGluIHRoZSBkcml2ZXIgdGhhdCBkb2Vzbid0IGdldCB1c2VkKQ0KPiBvciBkbyBJIGxlYXZl
IHRoZSBzdHVicyBpbj8NCj4gDQoNClRoZXNlIHN0dWJzIGFyZSBmb3IgZnVuY3Rpb25zIHdlIGhh
dmUgaW4gaWNlX2RlYnVnZnMubz8gSXMgdGhlcmUgYW4gaWNlX2RlYnVnZnMuaD8gV2Ugc2hvdWxk
IGltcGxlbWVudCBzdHVicyBmb3IgdGhvc2UgZnVuY3Rpb25zIHRoZXJlIHNvIHdlIGRvbid0IGhh
dmUgdG8gY2hlY2sgQ09ORklHX0RFQlVHX0ZTLiBPciwgaWYgdGhleSBkb27igJl0JyByZWFsbHkg
YmVsb25nIHRoZXJlIG1vdmUgdGhlbSBpbnRvIGFub3RoZXIgZmlsZSB0aGF0IGlzbid0IHN0cmlw
cGVkIG91dCB3aXRoIENPTkZJR19ERUJVR19GUz1uLg0KDQoNCiANCg==

