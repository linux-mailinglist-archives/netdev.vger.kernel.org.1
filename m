Return-Path: <netdev+bounces-46876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581DD7E6E2B
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1301C209D2
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A4208BE;
	Thu,  9 Nov 2023 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lggm6e18"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519220312
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:04:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D6A19A5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699545845; x=1731081845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A8WK+mbqJu+tB4n/93jSZ4RnRIw3bNFJ4pAtjRnnDkw=;
  b=Lggm6e18tnsN35UDCwSugNFW7YBUqS3Z3Zr0S77go+DC02nnf+I2dicr
   KRBOWD/diaCyT+bNmlqpjozw8kOBS6mdoahnp+mJFqNlw9RV9COt5Vbmg
   5NiNcHrB2IbVZXDuJt/uyayXRRW4t4BCnYQStFQwao4R4TXI0FlUDhYXW
   uQhMv/M0kWXF4bn7BBPdutJYbOsm8rAo5ohh/JARIDC2Rmk/ExnE0czD4
   fWhi0+tscg9q2EBGoABpCXS45SCs52Is5Z5apdjcVIIVj8nYR8HyEcEgS
   /PWTbcfm6hjO6wqiF5J1rPwWf8M7Zsfxc33ZLQht81/7kM/522Xmahjgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="2983005"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2983005"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 08:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="798347915"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="798347915"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 08:02:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 08:02:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 08:02:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 08:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CegDAeqINKpm0O6q0rGlfJfPh+5a9ml78w2S/FNm2gD9I60PS5TodJS/kklRqEAbiQQ6nnMHHh285/7q0Z5hxEY2K3PELRr9Ydg0HmOxp/9Y064n+ufUdZ6h6wO4aT/jO/18fLrAwuae+SqwChJdsguamoiJdKgXiMYs99wZ0fokLQ+PDLO2wtJT0kZa+2oGpC4R3ltCn+9QIcIWHFCHmhJL3fSbXxFadOZpi5dYfnPBnPBKgwYCSZSjzDDdccq29VkUMpPqr8WFCpUUedVkEoA/yA0AAj06UwwPiSmHg/ueq7nUDwT63kNCDXnOHGlAQg7fAP4B+5GJ0YObZf6e5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8WK+mbqJu+tB4n/93jSZ4RnRIw3bNFJ4pAtjRnnDkw=;
 b=C2ijHgVa4/OwLPZU8PKJRIU/JSGA9PiUWGNk9utm40kZjXK2NqiAWVZJ0Z1r3jq9cUAdXGLZ01hSPGBWNrw9NQgZLi7kocJBglXpDC6MQzwtFQyMqF1nLLAtFg8eA5oHwL81RM+5bIF6Srz63M+hWVpn6alxfhj/NdmgV1pE+JWuephms3yLtnbYQXYE4U51X7fnpPQvvLUMkhAbOG7Qo67TENi2BaDd+r8kXuP+DQF0dmdgGqIYClBaiNtngsVpG6YH/mlcps6FNMtL+4vQ7dahA9SGjfIOB1RDot6s3AWtPzFG/qphkTjrMZMWGbO7yGu6yifqfHKleIKsOq1SPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 16:02:49 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::fe1c:922f:987:85ab%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 16:02:48 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Michalik, Michal"
	<michal.michalik@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Topic: [PATCH net 3/3] dpll: fix register pin with unregistered parent
 pin
Thread-Index: AQHaEi9R20w3ZLh/s0yEUYAIdOH3G7BwhkSAgAE6GCCAABIKAIAAOifw
Date: Thu, 9 Nov 2023 16:02:48 +0000
Message-ID: <DM6PR11MB4657C6C1B094DD7B429A22469BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20231108103226.1168500-1-arkadiusz.kubalewski@intel.com>
 <20231108103226.1168500-4-arkadiusz.kubalewski@intel.com>
 <ZUukPbTCww26jltC@nanopsycho>
 <DM6PR11MB46572BD8C43DACA0FF15C2CF9BAFA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
In-Reply-To: <8b6e3211-3f03-4c17-b0cb-26175bf42213@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SN7PR11MB7589:EE_
x-ms-office365-filtering-correlation-id: 422f1cc6-28b9-457d-6f9e-08dbe13d5215
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1jxNjwR/lZ7WhbGEugicM10pgk13iCVyzEHJVrlMtRRqN2qmtjBUzReE4NKFLl6zCOS/0cbLMJo6BkCw4YacKN0bDvkPg4RrovJsBmUR2ktiE3bnmsGKPtsC0dXsgM86mCms34A8hhk/UTsS3EzUSPofhqgKGi4I4UO7Vnqrh5bVj+vHQEIGYa7Ei0iFLWeV8eIYA+rrkfyPkrFBzohCfwM3WbXuuw+f+dO7VFtrQ4rgLlYgK+cVgZSWAM563k/Dfgl4+8s+nI1dCfIKRiwSf1UM5lNOML5Qg9NzTA2M8/AuE2atYHUo+CvA6aw91U5tYDeASMukE4anQDpEXIegT8uZGBm9P6yIt70TjhwH7SFKfvrWYMHYcjroVIafvMbYoKP3h6kddLUc9id3adIoXA0GZ9+mQChFWZ9TjTB+dQG57z7H4ypATrcyMzKKh0z/992g3uEkM7VDjoHi2zF7Po56e0LfRH01dJLLWHSR+IiApSK6H7ugpy0wizCuhKZiRi+d4j2oXrOsk6n+jQDwY9vk7h15MWdbp/CUlzGAyIhDjnNU8f5wZnsNEhBj1EXZZRsZL6F9MwtpEf/rftG2wNwkt4g8K8jdKnSHyvlpHgttEw/hV3F+1g6En0ieCu1m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(71200400001)(478600001)(7696005)(6506007)(9686003)(26005)(41300700001)(5660300002)(66476007)(2906002)(8936002)(76116006)(54906003)(66556008)(66946007)(64756008)(66446008)(316002)(4326008)(8676002)(52536014)(38070700009)(83380400001)(110136005)(82960400001)(38100700002)(33656002)(86362001)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJEbDlFNkFBK2l1K1hKeFFZcHhXRUl3T2EzbDVDSzI3Z0RhY0dZdzhLMGRY?=
 =?utf-8?B?M21zeVFUYjFHTHdXSVdYSkRhQ2Q3cFM3YUdMM083T3dEMzc0aDlkeUtwNERv?=
 =?utf-8?B?cXUrMldXdEdlZk5aQlJUQU8xaWFBRnZobjFZMDdRSXVXVytwRCs2MmpUWGZw?=
 =?utf-8?B?c0Z5TzFUSTlIT2tRUm15Sk9JVUUzVXh2bkZGcXdxUlF1RVlDUHY4R1Bxd0V5?=
 =?utf-8?B?NFhZRmZrdUwwQkczRnZJSG1mbTN1WDN5S1dSK2NzbFhhczY2M3ZySWVIMzR2?=
 =?utf-8?B?YTZsLzNqampsVEZrbGRsL0FSelRjKzlXYm93YTJMa2NlR2VEUTA2QUM0aGxy?=
 =?utf-8?B?cXY3aFpLZjc3ZFFaOUtSQ2p4dmNHRDRnUU1zeno1T2pEc2lMSnBqN3U2bzI1?=
 =?utf-8?B?QmRXUk1jUis5YmhRZ0RCRk03N0FhdzVyT1JkZnJpZFpDUnhqekRVb3pIUVEw?=
 =?utf-8?B?eERYK1lmRUZmNDZ2ZFBpdEx5MXMzeTM2WHNwVU9ldHRpMDErMWZ4Zmd0cVFm?=
 =?utf-8?B?dkpUWDF6QUlLZU4xMHZiRnZUVTlBeFozNmdmdlp6Tzd3dWlMRTlxdnBrNXFW?=
 =?utf-8?B?Y0ZJbEhGMkhSMmY4b3BKdjkzK1Y1VjhoNmhzWmFlTmViYWhPWStsdURmd0xG?=
 =?utf-8?B?RDlqbk1USWg0eWlleEtmbk1PakRxSFYyN3l4QWI2ZjZvZVJNSFBsekxWd3VM?=
 =?utf-8?B?Z0tqTUtnUDJHRVRrR1ZkWWdZV25qY0E5RVNVZ0pkYkQ3SnNTaFQxQUlPemlO?=
 =?utf-8?B?QlBkNHZPTlZpSWFmRUo2eXVyYnJRR2txZWQ0VmhyQjB3TzNxZzRmSU1qNktQ?=
 =?utf-8?B?Mld5TWsvMkJMM0JnTUw3M1BXekVBOVc0aFVUSzBxMmpEaThOUTVTcVlWSktr?=
 =?utf-8?B?am1GdmpxRlBjV24zQmFRaDY4ZzRKempjVUlzcGEzWjdwem1iMXFsbUFYYlM4?=
 =?utf-8?B?a1BFeVcrKzNQRS9PVUo4T1NhQVVxM2ZEQlIzR1RDNUdYSC9BMHREN2NRdWw0?=
 =?utf-8?B?bE9HZmhuNGhKSjg2a2xERW8wNElDb2lJcHpWUStONlVpYVZTYmdLZUFkd0tp?=
 =?utf-8?B?NG45VjdCeVlBcFpyMlRvYmhnTTVMT1N5ZVU4d0NkeVd6eTZhcFhLV1JUakpP?=
 =?utf-8?B?NzVyTUhtbVhJYk1hSWpHWXprWGRFbmtOSDNnTHJLOHBVQTZTZkQ2ai9oVjVr?=
 =?utf-8?B?TkxzL0ZMR2VCZWpxVkZFVmo3dS9ESjd6OTNPNDBObzlLVlZWOEo4WUw4Umtj?=
 =?utf-8?B?UXZiU3hhb0xBRWhGa0dQZUdjTG5GTGxUb1hxemVjZm5pOGV2U1BIWk14YnVF?=
 =?utf-8?B?alZqVVNvS2tERWZkL3V4MndVQkU4N2FVZ0QxWml2T0RVVFExS3N0NDdDaXVq?=
 =?utf-8?B?N3J6d3BacHdtYlhMR2x6TW1JZUpDMkhiL2tRdXN5UUNkVkx1SmFlc2NURWJ2?=
 =?utf-8?B?b2hma2NZVjB2bGNwUUZGVEMwK0xPWDIra1JzZSt5TW4yemErMlExdGxmZVFZ?=
 =?utf-8?B?VmFTRWRUU1ErSlZsbHNkTWNMdTZHV0hSUHlXc256Q05QMFByalM1OHl5V3da?=
 =?utf-8?B?YXp4VDVkUmlyaGVUL0RJTmJNcWVFdWZ0b2dBTFdPUzBsQkZmR1pQNDlzRzFB?=
 =?utf-8?B?anZDNE1UT3FOL2pBcGlValE2Wkk0VXorZFh2U21aeCsxemNKYzgrNDhpd1NW?=
 =?utf-8?B?R0x1WkQ0YUdqMFBYSVQySTA2bUowQTdOYW0vODhuUHdVd0FuN0ZDN2lxN0VM?=
 =?utf-8?B?RlZ5WC8rUEVORktlRVQvWkFybUdYaGVLU2hRWTlFcnNtZVdZNjFHNUtvMGxw?=
 =?utf-8?B?OEh3TnNMUHZObG5kNjdUeHdNaDQ3Zmwyc25IaFFXdWl2L0NPNTlKYlNjVnQv?=
 =?utf-8?B?a3lLV1dCSm41dWpLQU13eGZWTjVqcHBsQWM0d3MzVUxEUG04TjlMOGczcXg3?=
 =?utf-8?B?TmFpM0pjOW5aem00YXN6S1NXckFzL2txelk3REdCVit1U2lFOHlFTVZVUWc3?=
 =?utf-8?B?Q0JHSzVGNk9ydzFsNnVwK0ZITE9pdjNZMmZEL1ZsdzVTRFBkckttMGQrbTVi?=
 =?utf-8?B?RkRDbGtUTHEvbU8ydEErb09HUkQrR1pzc2pRdWJENUpLSGFpRDdQTE4yN3FQ?=
 =?utf-8?B?M2VYRXRSSXQxdlhwRFFTVGlRQnNVcnhYaDZyU1ZZdzhOR0N1VTdMWlZTZ3Zq?=
 =?utf-8?B?MHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 422f1cc6-28b9-457d-6f9e-08dbe13d5215
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 16:02:48.8979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 817NzHkDCPLVS29TA2uLanhBJkfVSiLZ7nEIW+X9k7w9LYhece2nbASO5DVVnx7Yu5wt6xlVYlLjzs7Xw8XGKQrhywm+i9F31LeWeWiLpIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
X-OriginatorOrg: intel.com

PkZyb206IFZhZGltIEZlZG9yZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj5TZW50
OiBUaHVyc2RheSwgTm92ZW1iZXIgOSwgMjAyMyAxMTo1NiBBTQ0KPlRvOiBLdWJhbGV3c2tpLCBB
cmthZGl1c3ogPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbT47IEppcmkgUGlya28NCj4N
Cj5PbiAwOS8xMS8yMDIzIDA5OjU5LCBLdWJhbGV3c2tpLCBBcmthZGl1c3ogd3JvdGU6DQo+Pj4g
RnJvbTogSmlyaSBQaXJrbyA8amlyaUByZXNudWxsaS51cz4NCj4+PiBTZW50OiBXZWRuZXNkYXks
IE5vdmVtYmVyIDgsIDIwMjMgNDowOCBQTQ0KPj4+DQo+Pj4gV2VkLCBOb3YgMDgsIDIwMjMgYXQg
MTE6MzI6MjZBTSBDRVQsIGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVsLmNvbQ0KPj4+IHdyb3Rl
Og0KPj4+PiBJbiBjYXNlIG9mIG11bHRpcGxlIGtlcm5lbCBtb2R1bGUgaW5zdGFuY2VzIHVzaW5n
IHRoZSBzYW1lIGRwbGwgZGV2aWNlOg0KPj4+PiBpZiBvbmx5IG9uZSByZWdpc3RlcnMgZHBsbCBk
ZXZpY2UsIHRoZW4gb25seSB0aGF0IG9uZSBjYW4gcmVnaXN0ZXINCj4+Pg0KPj4+IFRoZXkgd2h5
IHlvdSBkb24ndCByZWdpc3RlciBpbiBtdWx0aXBsZSBpbnN0YW5jZXM/IFNlZSBtbHg1IGZvciBh
DQo+Pj4gcmVmZXJlbmNlLg0KPj4+DQo+Pg0KPj4gRXZlcnkgcmVnaXN0cmF0aW9uIHJlcXVpcmVz
IG9wcywgYnV0IGZvciBvdXIgY2FzZSBvbmx5IFBGMCBpcyBhYmxlIHRvDQo+PiBjb250cm9sIGRw
bGwgcGlucyBhbmQgZGV2aWNlLCB0aHVzIG9ubHkgdGhpcyBjYW4gcHJvdmlkZSBvcHMuDQo+PiBC
YXNpY2FsbHkgd2l0aG91dCBQRjAsIGRwbGwgaXMgbm90IGFibGUgdG8gYmUgY29udHJvbGxlZCwg
YXMgd2VsbA0KPj4gYXMgZGlyZWN0bHkgY29ubmVjdGVkIHBpbnMuDQo+Pg0KPkJ1dCB3aHkgZG8g
eW91IG5lZWQgb3RoZXIgcGlucyB0aGVuLCBpZiBGUDAgZG9lc24ndCBleGlzdD8NCj4NCg0KSW4g
Z2VuZXJhbCB3ZSBkb24ndCBuZWVkIHRoZW0gYXQgdGhhdCBwb2ludCwgYnV0IHRoaXMgaXMgYSBj
b3JuZXIgY2FzZSwNCndoZXJlIHVzZXJzIGZvciBzb21lIHJlYXNvbiBkZWNpZGVkIHRvIHVuYmlu
ZCBQRiAwLCBhbmQgSSB0cmVhdCB0aGlzIHN0YXRlDQphcyB0ZW1wb3JhcnksIHdoZXJlIGRwbGwv
cGlucyBjb250cm9sbGFiaWxpdHkgaXMgdGVtcG9yYXJpbHkgYnJva2VuLg0KDQpUaGUgZHBsbCBh
dCB0aGF0IHBvaW50IGlzIG5vdCByZWdpc3RlcmVkLCBhbGwgdGhlIGRpcmVjdCBwaW5zIGFyZSBh
bHNvDQpub3QgcmVnaXN0ZXJlZCwgdGh1cyBub3QgYXZhaWxhYmxlIHRvIHRoZSB1c2Vycy4NCg0K
V2hlbiBJIGRvIGR1bXAgYXQgdGhhdCBwb2ludCB0aGVyZSBhcmUgc3RpbGwgMyBwaW5zIHByZXNl
bnQsIG9uZSBmb3IgZWFjaA0KUEYsIGFsdGhvdWdoIHRoZXkgYXJlIGFsbCB6b21iaWVzIC0gbm8g
cGFyZW50cyBhcyB0aGVpciBwYXJlbnQgcGlucyBhcmUgbm90DQpyZWdpc3RlcmVkIChhcyB0aGUg
b3RoZXIgcGF0Y2ggWzEvM10gcHJldmVudHMgZHVtcCBvZiBwaW4gcGFyZW50IGlmIHRoZQ0KcGFy
ZW50IGlzIG5vdCByZWdpc3RlcmVkKS4gTWF5YmUgd2UgY2FuIHJlbW92ZSB0aGUgUkVHSVNURVJF
RCBtYXJrIGZvciBhbGwNCnRoZSBtdXhlZCBwaW5zLCBpZiBhbGwgdGhlaXIgcGFyZW50cyBoYXZl
IGJlZW4gdW5yZWdpc3RlcmVkLCBzbyB0aGV5IHdvbid0DQpiZSB2aXNpYmxlIHRvIHRoZSB1c2Vy
IGF0IGFsbC4gV2lsbCB0cnkgdG8gUE9DIHRoYXQuDQoNCj4+Pg0KPj4+PiBkaXJlY3RseSBjb25u
ZWN0ZWQgcGlucyB3aXRoIGEgZHBsbCBkZXZpY2UuIElmIHVucmVnaXN0ZXJlZCBwYXJlbnQNCj4+
Pj4gZGV0ZXJtaW5lcyBpZiB0aGUgbXV4ZWQgcGluIGNhbiBiZSByZWdpc3RlciB3aXRoIGl0IG9y
IG5vdCwgaXQgZm9yY2VzDQo+Pj4+IHNlcmlhbGl6ZWQgZHJpdmVyIGxvYWQgb3JkZXIgLSBmaXJz
dCB0aGUgZHJpdmVyIGluc3RhbmNlIHdoaWNoDQo+Pj4+IHJlZ2lzdGVycyB0aGUgZGlyZWN0IHBp
bnMgbmVlZHMgdG8gYmUgbG9hZGVkLCB0aGVuIHRoZSBvdGhlciBpbnN0YW5jZXMNCj4+Pj4gY291
bGQgcmVnaXN0ZXIgbXV4ZWQgdHlwZSBwaW5zLg0KPj4+Pg0KPj4+PiBBbGxvdyByZWdpc3RyYXRp
b24gb2YgYSBwaW4gd2l0aCBhIHBhcmVudCBldmVuIGlmIHRoZSBwYXJlbnQgd2FzIG5vdA0KPj4+
PiB5ZXQgcmVnaXN0ZXJlZCwgdGh1cyBhbGxvdyBhYmlsaXR5IGZvciB1bnNlcmlhbGl6ZWQgZHJp
dmVyIGluc3RhbmNlDQo+Pj4NCj4+PiBXZWlyZC4NCj4+Pg0KPj4NCj4+IFllYWgsIHRoaXMgaXMg
aXNzdWUgb25seSBmb3IgTVVYL3BhcmVudCBwaW4gcGFydCwgY291bGRuJ3QgZmluZCBiZXR0ZXIN
Cj4+IHdheSwgYnV0IGl0IGRvZXNuJ3Qgc2VlbSB0byBicmVhayB0aGluZ3MgYXJvdW5kLi4NCj4+
DQo+DQo+SSBqdXN0IHdvbmRlciBob3cgZG8geW91IHNlZSB0aGUgcmVnaXN0cmF0aW9uIHByb2Nl
ZHVyZT8gSG93IGNhbiBwYXJlbnQNCj5waW4gZXhpc3QgaWYgaXQncyBub3QgcmVnaXN0ZXJlZD8g
SSBiZWxpZXZlIHlvdSBjYW5ub3QgZ2V0IGl0IHRocm91Z2gNCj5EUExMIEFQSSwgdGhlbiB0aGUg
b25seSBwb3NzaWJsZSB3YXkgaXMgdG8gY3JlYXRlIGl0IHdpdGhpbiB0aGUgc2FtZQ0KPmRyaXZl
ciBjb2RlLCB3aGljaCBjYW4gYmUgc2ltcGx5IHJlLWFycmFuZ2VkLiBBbSBJIHdyb25nIGhlcmU/
DQo+DQoNCkJ5ICJwYXJlbnQgZXhpc3QiIEkgbWVhbiB0aGUgcGFyZW50IHBpbiBleGlzdCBpbiB0
aGUgZHBsbCBzdWJzeXN0ZW0NCihhbGxvY2F0ZWQgb24gcGlucyB4YSksIGJ1dCBpdCBkb2Vzbid0
IG1lYW4gaXQgaXMgYXZhaWxhYmxlIHRvIHRoZSB1c2VycywNCmFzIGl0IG1pZ2h0IG5vdCBiZSBy
ZWdpc3RlcmVkIHdpdGggYSBkcGxsIGRldmljZS4NCg0KV2UgaGF2ZSB0aGlzIDIgc3RlcCBpbml0
IGFwcHJvYWNoOg0KMS4gZHBsbF9waW5fZ2V0KC4uKSAtPiBhbGxvY2F0ZSBuZXcgcGluIG9yIGlu
Y3JlYXNlIHJlZmVyZW5jZSBpZiBleGlzdA0KMi4xLiBkcGxsX3Bpbl9yZWdpc3RlciguLikgLT4g
cmVnaXN0ZXIgd2l0aCBhIGRwbGwgZGV2aWNlDQoyLjIuIGRwbGxfcGluX29uX3Bpbl9yZWdpc3Rl
ciAtPiByZWdpc3RlciB3aXRoIGEgcGFyZW50IHBpbg0KDQpCYXNpY2FsbHk6DQotIFBGIDAgZG9l
cyAxICYgMi4xIGZvciBhbGwgdGhlIGRpcmVjdCBpbnB1dHMsIGFuZCBzdGVwczogMSAmIDIuMiBm
b3IgaXRzDQogIHJlY292ZXJ5IGNsb2NrIHBpbiwNCi0gb3RoZXIgUEYncyBvbmx5IGRvIHN0ZXAg
MSBmb3IgdGhlIGRpcmVjdCBpbnB1dCBwaW5zIChhcyB0aGV5IG11c3QgZ2V0DQogIHJlZmVyZW5j
ZSB0byB0aG9zZSBpbiBvcmRlciB0byByZWdpc3RlciByZWNvdmVyeSBjbG9jayBwaW4gd2l0aCB0
aGVtKSwNCiAgYW5kIHN0ZXBzOiAxICYgMi4yIGZvciB0aGVpciByZWNvdmVyeSBjbG9jayBwaW4u
DQoNCg0KVGhhbmsgeW91IQ0KQXJrYWRpdXN6DQoNCj4+IFRoYW5rIHlvdSENCj4+IEFya2FkaXVz
eg0KPj4NCj4+Pg0KPj4+PiBsb2FkIG9yZGVyLg0KPj4+PiBEbyBub3QgV0FSTl9PTiBub3RpZmlj
YXRpb24gZm9yIHVucmVnaXN0ZXJlZCBwaW4sIHdoaWNoIGNhbiBiZSBpbnZva2VkDQo+Pj4+IGZv
ciBkZXNjcmliZWQgY2FzZSwgaW5zdGVhZCBqdXN0IHJldHVybiBlcnJvci4NCj4+Pj4NCj4+Pj4g
Rml4ZXM6IDk0MzEwNjNhZDMyMyAoImRwbGw6IGNvcmU6IEFkZCBEUExMIGZyYW1ld29yayBiYXNl
IGZ1bmN0aW9ucyIpDQo+Pj4+IEZpeGVzOiA5ZDcxYjU0YjY1YjEgKCJkcGxsOiBuZXRsaW5rOiBB
ZGQgRFBMTCBmcmFtZXdvcmsgYmFzZQ0KPj4+PiBmdW5jdGlvbnMiKQ0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBBcmthZGl1c3ogS3ViYWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gZHJpdmVycy9kcGxsL2RwbGxfY29yZS5jICAgIHwgNCAtLS0tDQo+
Pj4+IGRyaXZlcnMvZHBsbC9kcGxsX25ldGxpbmsuYyB8IDIgKy0NCj4+Pj4gMiBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZHBsbC9kcGxsX2NvcmUuYyBiL2RyaXZlcnMvZHBsbC9kcGxsX2NvcmUuYyBp
bmRleA0KPj4+PiA0MDc3YjU2MmJhM2IuLmFlODg0YjkyZDY4YyAxMDA2NDQNCj4+Pj4gLS0tIGEv
ZHJpdmVycy9kcGxsL2RwbGxfY29yZS5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZHBsbC9kcGxsX2Nv
cmUuYw0KPj4+PiBAQCAtMjgsOCArMjgsNiBAQCBzdGF0aWMgdTMyIGRwbGxfeGFfaWQ7DQo+Pj4+
IAlXQVJOX09OX09OQ0UoIXhhX2dldF9tYXJrKCZkcGxsX2RldmljZV94YSwgKGQpLT5pZCwgRFBM
TF9SRUdJU1RFUkVEKSkNCj4+Pj4gI2RlZmluZSBBU1NFUlRfRFBMTF9OT1RfUkVHSVNURVJFRChk
KQlcDQo+Pj4+IAlXQVJOX09OX09OQ0UoeGFfZ2V0X21hcmsoJmRwbGxfZGV2aWNlX3hhLCAoZCkt
PmlkLCBEUExMX1JFR0lTVEVSRUQpKQ0KPj4+PiAtI2RlZmluZSBBU1NFUlRfUElOX1JFR0lTVEVS
RUQocCkJXA0KPj4+PiAtCVdBUk5fT05fT05DRSgheGFfZ2V0X21hcmsoJmRwbGxfcGluX3hhLCAo
cCktPmlkLCBEUExMX1JFR0lTVEVSRUQpKQ0KPj4+Pg0KPj4+PiBzdHJ1Y3QgZHBsbF9kZXZpY2Vf
cmVnaXN0cmF0aW9uIHsNCj4+Pj4gCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCj4+Pj4gQEAgLTY0
MSw4ICs2MzksNiBAQCBpbnQgZHBsbF9waW5fb25fcGluX3JlZ2lzdGVyKHN0cnVjdCBkcGxsX3Bp
bg0KPj4+PipwYXJlbnQsDQo+Pj4gc3RydWN0IGRwbGxfcGluICpwaW4sDQo+Pj4+IAkgICAgV0FS
Tl9PTighb3BzLT5zdGF0ZV9vbl9waW5fZ2V0KSB8fA0KPj4+PiAJICAgIFdBUk5fT04oIW9wcy0+
ZGlyZWN0aW9uX2dldCkpDQo+Pj4+IAkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4+IC0JaWYgKEFTU0VS
VF9QSU5fUkVHSVNURVJFRChwYXJlbnQpKQ0KPj4+PiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4+Pj4N
Cj4+Pj4gCW11dGV4X2xvY2soJmRwbGxfbG9jayk7DQo+Pj4+IAlyZXQgPSBkcGxsX3hhX3JlZl9w
aW5fYWRkKCZwaW4tPnBhcmVudF9yZWZzLCBwYXJlbnQsIG9wcywgcHJpdik7IGRpZmYNCj4+Pj4g
LS1naXQgYS9kcml2ZXJzL2RwbGwvZHBsbF9uZXRsaW5rLmMgYi9kcml2ZXJzL2RwbGwvZHBsbF9u
ZXRsaW5rLmMgaW5kZXgNCj4+Pj4gOTYzYmJiYmU2NjYwLi5mZjQzMGY0MzMwNGYgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2RyaXZlcnMvZHBsbC9kcGxsX25ldGxpbmsuYw0KPj4+PiArKysgYi9kcml2ZXJz
L2RwbGwvZHBsbF9uZXRsaW5rLmMNCj4+Pj4gQEAgLTU1OCw3ICs1NTgsNyBAQCBkcGxsX3Bpbl9l
dmVudF9zZW5kKGVudW0gZHBsbF9jbWQgZXZlbnQsIHN0cnVjdA0KPj4+IGRwbGxfcGluICpwaW4p
DQo+Pj4+IAlpbnQgcmV0ID0gLUVOT01FTTsNCj4+Pj4gCXZvaWQgKmhkcjsNCj4+Pj4NCj4+Pj4g
LQlpZiAoV0FSTl9PTigheGFfZ2V0X21hcmsoJmRwbGxfcGluX3hhLCBwaW4tPmlkLCBEUExMX1JF
R0lTVEVSRUQpKSkNCj4+Pj4gKwlpZiAoIXhhX2dldF9tYXJrKCZkcGxsX3Bpbl94YSwgcGluLT5p
ZCwgRFBMTF9SRUdJU1RFUkVEKSkNCj4+Pj4gCQlyZXR1cm4gLUVOT0RFVjsNCj4+Pj4NCj4+Pj4g
CW1zZyA9IGdlbmxtc2dfbmV3KE5MTVNHX0dPT0RTSVpFLCBHRlBfS0VSTkVMKTsNCj4+Pj4gLS0N
Cj4+Pj4gMi4zOC4xDQo+Pj4+DQo+DQoNCg==

