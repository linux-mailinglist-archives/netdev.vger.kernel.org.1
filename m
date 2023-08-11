Return-Path: <netdev+bounces-26783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57477778EF1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F23281A22
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5711CB3;
	Fri, 11 Aug 2023 12:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0811C9C
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:16:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1F3588;
	Fri, 11 Aug 2023 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691756178; x=1723292178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5FiS+vIrmRITBlDJeDH8FT21OagDOvA0h1tMHk6/nwM=;
  b=nB3K3aN6QUe5Wds8qj50s+WfZG0xW4R+Rz7VTh0RzaQ6zz+lngyGfBW7
   TO4LCFnvouAQ7j/OJnE/SPT+I0qlqphY16LRheBdLJgmXdmZhk3sw4TaW
   5eHyDMWLrKsGW7WsTS2hWK5lmDfGPtQ0djhR5OK1uFNiIUTCPIsJUfBa8
   XK8hsopq26TQj/Uvtan4YaV23/wsUNzc/05zpiFFgGOe+qeis89FRucZE
   /7ZJBeZK6gJ4XmreVzdT+zv/QnsMS4IumIV+4hCP5re0lf6rShUqG+T25
   ND0TIDuJLg5AP0SzC3XIQ9U5IRigWA0xN+tbnd64oWDMfXRgHdLQyiJzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="356623836"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="356623836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 05:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1063304004"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1063304004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 05:16:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 05:16:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 05:16:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 05:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbpXGAJIhGYR/E8slWqIY4ezk4Yxsl4fpR19DvvDVhDCDNUqUHyvHzbQzHs9oFT8mj7RTCLDftuGgspgNWSUkgdu2UTHODM3FvXv5F8vr12ENSkf7+Yn4sYts5q18JJvkhE2dkhVxus9jWpKyieAbm2VTXY8nb2izdEdJXoTtI/joJ3QqkR6KtaWxdnO2lQwDo9LbqR31hBcfBrobJhA54jzx8ia9DER5o0Uy9BTSnG0geePOQ8aXSnoXIboko3EK1qpPvUpO6cB8xIvKyXbhUTX8WSZLWray/eA9m3zDt5PDKpZQfaHmCpOilBjwiFukN2MxyfdbIcFkWfZz8KXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FiS+vIrmRITBlDJeDH8FT21OagDOvA0h1tMHk6/nwM=;
 b=V5zXYiLzGW3KX2taABX3T8pWBA3Jy8XZc6LXaWbpqMhjJeUmS0tCE9f05H+QxYOHhwPQkOVSAv6p7un0tY06UUGTRTiyglHHobiKTK9fy6ZULufdk8hdRY2dAxCX/hz4BWEgmz7/EFMRyELKvIeAQIABkNOmidm5JGxvU+bufGwQ1vNm4NTT7bJbE4Tar/HUVQfUv8XL3zHXSFVpinGyhMOLcaXij4X8LguPxG0OLOgLWZMJwUaOqfWylj1ERyJdKnZYpa3T4wg9oOhlviAM9JwOBTteP5iou1RlsKBltcoAyeKbilyWUEh48Ooc+If9c17txm6/iOQfifiZQwYWGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 12:16:01 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 12:16:01 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
	<kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>,
	"Michalik, Michal" <michal.michalik@intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
	<mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH net-next v3 6/9] ice: add admin commands to access cgu
 configuration
Thread-Topic: [PATCH net-next v3 6/9] ice: add admin commands to access cgu
 configuration
Thread-Index: AQHZywpuDwdiCNcDy0Whc5QLgHa0j6/kXt0AgAB4DYCAAC28YA==
Date: Fri, 11 Aug 2023 12:16:01 +0000
Message-ID: <DM6PR11MB46578D7F73BDA4D6EE7E0E239B10A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230809214027.556192-1-vadim.fedorenko@linux.dev>
 <20230809214027.556192-7-vadim.fedorenko@linux.dev>
 <20230810192102.2932d58f@kernel.org>
 <8d52ab61-e532-0ef8-4227-ea1ab469f4cb@linux.dev>
In-Reply-To: <8d52ab61-e532-0ef8-4227-ea1ab469f4cb@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ2PR11MB7501:EE_
x-ms-office365-filtering-correlation-id: 00b67078-37be-478f-05bc-08db9a64ba1a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GWuZN9P7GBIdw1uFgyJDtu5auXjc1XvlnBBMvjE734DEtd8QROeT2bCdx+9gyE1ddhIIBmHzD3RzJUNbLu+zCdPBWC2XqBcVj3rRUP8gAKENMjQFkHWvhyZPKhtlZwizLgzdQU3jP11zzZ8NDTcu5XpugGFQYyl/3WeN/l4PfsKx1amugVivRDjr7x6AJPyw+QE/ScA0S1T7jOW79pyObiAPfOkiZT75bY+Kk3pd8DSki76K2upjq8NwlLi233qePE239k1ti7t4g1B0Ux0XWMJEZs0ffhkTX356oeaudrVk8EFcrCbyzEEakN+aJ1//jPFhxD2gCCy3sN6uT1RDIIfmkH8ylACPhiBY5Y2Qopu6ic10z/YT5raGlAq3h+njX4PD/dEGzeg2wSRaErdvwu0yV8pggbybbz8MDfGntxyk0MJsMBXb1/FTYtdKNrKRPHhRvUmDmFrqCxIUbNDrpX93039ggh9IPFmxFfsbMmlo59C9oyHhN9KveSzjID1dZlsD4FnHEyXFFUmSp7SJaxOHIl4Dh2HuHNwvb7IvY9yZn+LiR5L1T6k4bDPJOPOl6J4CpIKub/W2MHjFVXU3gkbLeRswfwLoZ/tP7FFBYUt2NG3In2wdMjj0CbDDY9pO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(1800799006)(451199021)(186006)(8676002)(6506007)(26005)(41300700001)(8936002)(33656002)(2906002)(38100700002)(83380400001)(4744005)(122000001)(82960400001)(38070700005)(86362001)(7416002)(55016003)(52536014)(66946007)(64756008)(66476007)(66446008)(66556008)(76116006)(54906003)(9686003)(4326008)(71200400001)(110136005)(7696005)(478600001)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZ3ckMwcS9BTDZReHgvbEhqcmdXTVVHRGpXbzJhQ3I3QTMzTXl0MGpkTDNk?=
 =?utf-8?B?NCtBNEVrbVhQWTBVRnptbm4rWnpNRE5aaUZhaDQ5c2czZUlGYXdSV0RZcTlq?=
 =?utf-8?B?NnArblpUVGpZVjhKeXRmNXNSNnpsNVF2eXU1OGR4QzByOUpINWN6M0Z0Qk9R?=
 =?utf-8?B?eURxdzFWbW81NWRXTHVaeUZRa1JZeEhBY21ZWTdLWWpjNXc1aVYxVkJoRjNF?=
 =?utf-8?B?RFF0ZlNBK2k3aVZuWmFINWdSMUVkZU9xUE9FKzJHaE5ReDExQVNNWFFJeUFF?=
 =?utf-8?B?aXRjV04wUEFWUVNQYkVwQml3cGpHZEpYU2cvM3ErL3cveUFxWXFwUGsxU3NH?=
 =?utf-8?B?MXVNY01xdTFvV21IbEcwZGQ1RlZBS2w4N3ZaOVhxYjd6S29RSER0WnRBU2Rh?=
 =?utf-8?B?TnVrU3lTRkE2QUJpNkx5ald6UmxvSmdaczFneFhUZ0k3blJjNXRXTUp6K1Fo?=
 =?utf-8?B?SWRFTEJkRS93WWRtYUlrMjlxWExUS3pIZUR2cHkwTnk3bDVLdVpLcHkxblEx?=
 =?utf-8?B?R2RCdXUvdW94UU1HUWZvSjJQRGd1dUI5VUdtWldzemtQMUNzeTVoUjdjS1Zj?=
 =?utf-8?B?L0lHYVg5RjJyTGFXYmpqSkdCSUNVVFNYYVdLM1ZzbjkwbmRpRFN3RVIwS2Q1?=
 =?utf-8?B?Yk5CYjJUaW0wS2JpVklSYTBRT3VTakVHU0lReDVEcGJTYm1SamQvVEhFdkNS?=
 =?utf-8?B?V1lCdElUNXF4YTlnOUp3M0ZydnBCb0l6dTlEUlI1RWlhc1loZDhKbjBkNkhD?=
 =?utf-8?B?YUlia05rTWlzL01mbEZMbnppVDd5SkJTemJzMkNnL2JZTkJxT0NhNVYvOWhz?=
 =?utf-8?B?RHdxcGtuM3lZRm9SeU9TS3FhTTRDN1hTUnRkYWZXOVI0U1R5N3ZxaGxKRHRM?=
 =?utf-8?B?MzlJbHN3S1ZnSndUS01qT1duR3V6ZzIxMzhKS3B4VllxSm1sZW94NGR2ejNR?=
 =?utf-8?B?eS90VWdybnUzczFhWlZ4MUFNenFoWitvRGdEMElLVmt1Z0pqRWV1ajVjR0dq?=
 =?utf-8?B?OERHVnN6ZitTdWFtWnl5TTI5MUhPSjZHUG41UlJrMGhTbXJGWlRmdG1qVXAv?=
 =?utf-8?B?d2U1R0JzNER5cEhSY3RHNWg1NWRiVG41WG1XT1FLcUJtYmhpeVlkWUhadkl5?=
 =?utf-8?B?Nmd5RkVVRTNJTnlyR3NtMmFONmNRZWZQYlg1L0VBcGlYRWVzcHoxTHhUSm5o?=
 =?utf-8?B?NzRwNGZhTDZlRnViNmlWNXBRVEJtZVVwazlkTGQ4VXk5aEdUOXlSMllEYUo2?=
 =?utf-8?B?N0ZKcGpheTN1NVliVU1meVg0ckZjOG80bWFCc0w1VVU3V0MxRk01SXVNdlBV?=
 =?utf-8?B?WFpNdGdxSXdqdUY5MGJ3enN3dWRQQUJWazQ4bzdQV2lDWTB0ekJOSzFrK0FV?=
 =?utf-8?B?Uk9oenpHZlM3Z044WW9WaWhtZnZ0RkkwWGdlUXFOdTlra25OTTdla1Vnb1FP?=
 =?utf-8?B?SzFHaGdIWWRLNTNHV1hweHpYczNIU1E5RUIrb0Vna29MMWVQNUh4UjlZQk5Z?=
 =?utf-8?B?ZGk3dm9jcEFGbzd0OUZGT2o4RlZkWVdTZkZuZ1V2VFpLcjhWSEtaeHhLK1JG?=
 =?utf-8?B?NkE3RDEvTXFBZDhGUys3dWFnWmdHM3lDRytHUEJvaERhdGF6QnhYYzkwZ3cx?=
 =?utf-8?B?M2pIR21OajNyOXY1c20rK0NBZzNqcHp2eGpucGFqcVB2OWhaMFM3QzNURG1j?=
 =?utf-8?B?TlNRSFJnM0NzL0laSVhFOXB0ZEY2dGgwOEg3T2dWSVRBcG5oZkhFNHM5aStn?=
 =?utf-8?B?Ly93NmxkRUlFWk15SWdjNU9oQjRwRkk0WC9BUDdPUm84UXp2VUlnL1ZZbEFJ?=
 =?utf-8?B?cUJPTmpMTFk2QTVOdm9Yby8yTWZpVkdhTnpvVnUyWEdsbUUyL016bml0WHpP?=
 =?utf-8?B?MW1lcU1MTC9rKzZSL2dWekd2eGI5RzRlQVBiVy94OXVEUjhFbGZkZkxXRFJB?=
 =?utf-8?B?VjZXL0kwNEduT0QvRUQrR3g5UzhwYzdoQjR4UXBqWThuK0ROby9hN0phTklo?=
 =?utf-8?B?eXVhMEtJYVJDc25jMVJnRWFMNWxpMzF0c2ZGVWtJTEdtSXdJV0pmUUhDTC84?=
 =?utf-8?B?bHNWbTlvN1dqMG5ka2RWZ084cEthYXRqZkFDZjdQVTUxcHNMZGs5bEJsdzFH?=
 =?utf-8?B?WWZ3emlEaWFuc0haOVdLS3pyZDRSZ1ZNUzA0MER3WmMzQ1RPRkI1TnZsWTNa?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b67078-37be-478f-05bc-08db9a64ba1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 12:16:01.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWi3Wsdzp29FlAehWARN3AvpFJZZ/iNeCPtto2BtT88bK4wrTRC4QwKSQ2a6jaXHUBAZjOFbI0+zc0wFM1dAgytC0EWrEDq6jHRMSe9BEeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PkZyb206IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj5TZW50
OiBGcmlkYXksIEF1Z3VzdCAxMSwgMjAyMyAxMTozMSBBTQ0KPg0KPk9uIDExLzA4LzIwMjMgMDM6
MjEsIEpha3ViIEtpY2luc2tpIHdyb3RlOg0KPj4gT24gV2VkLCAgOSBBdWcgMjAyMyAyMjo0MDoy
NCArMDEwMCBWYWRpbSBGZWRvcmVua28gd3JvdGU6DQo+Pj4gRnJvbTogQXJrYWRpdXN6IEt1YmFs
ZXdza2kgPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT4NCj4+Pg0KPj4+IEFkZCBmaXJt
d2FyZSBhZG1pbiBjb21tYW5kIHRvIGFjY2VzcyBjbG9jayBnZW5lcmF0aW9uIHVuaXQNCj4+PiBj
b25maWd1cmF0aW9uLCBpdCBpcyByZXF1aXJlZCB0byBlbmFibGUgRXh0ZW5kZWQgUFRQIGFuZCBT
eW5jRSBmZWF0dXJlcw0KPj4+IGluIHRoZSBkcml2ZXIuDQo+Pj4gQWRkIGRlZmluaXRpb25zIG9m
IHBvc3NpYmxlIGhhcmR3YXJlIHZhcmlhdGlvbnMgb2YgaW5wdXQgYW5kIG91dHB1dCBwaW5zDQo+
Pj4gcmVsYXRlZCB0byBjbG9jayBnZW5lcmF0aW9uIHVuaXQgYW5kIGZ1bmN0aW9ucyB0byBhY2Nl
c3MgdGhlIGRhdGEuDQo+Pg0KPj4gRG9lc24ndCBidWlsZCwgYnV0IGhvbGQgb2ZmIGEgbGl0dGxl
IHdpdGggcmVwb3N0aW5nLCBwbGVhc2UgaG9wZWZ1bGx5DQo+PiBJJ2xsIGhhdmUgbW9yZSB0aW1l
IHRvbW9ycm93IHRvIHJldmlldy4NCj4NCj5ZZWFoLCB3ZSd2ZSBmb3VuZCB0aGUgaXNzdWUgYWxy
ZWFkeSBhbmQgQXJrYWRpdXN6IGhhcyBwcmVwYXJlZCBhIHBhdGNoDQo+dG8gZml4IGl0LiBJIGNh
biBkbyB0aGUgcmVwb3N0IG9uY2UgeW91IGFyZSBvayB0byByZXZpZXcuDQoNClRoYW5rcyBWYWRp
bSwNCg0KSnVzdCByZWFsaXplZCB5b3UgaGF2ZSBhbHJlYWR5IHJlcGxpZWQgb24gdGhpcy4uDQpP
aywgc28gSSBndWVzcyB2NCBhZnRlciBhbGwuDQoNClRoYW5rIHlvdSENCkFya2FkaXVzeg0K

