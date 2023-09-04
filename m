Return-Path: <netdev+bounces-31857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57257790F6D
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5E3280A9A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 00:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974B382;
	Mon,  4 Sep 2023 00:59:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3417381
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 00:59:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AB90
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693789186; x=1725325186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLU9U4Tt8y19QHKPMcnGXspoiTKoNkqNfnmp5ne7Nuc=;
  b=dJbU25JQuOJls6YoUCnmOE+8ava/sqfKcx+XCVX7aOhzQcSabyyvJBRr
   a1cPMyQCqKoK2kwvaT3hSjmk69L5JQqmRx188EkELWm6IZn81zhLMLjFA
   CYU3CPBF+O+hTGBq0UnyfvEnBQRyGlPubdctW6HpgMnb6oP5bEuA7hKSD
   ftle8c75ddh8CcjtRrNJlNJe/mDUiR1t+FrQY0zRaTvzrr/ik1xLlXuEB
   8IBUdUFeRa96756dCUyRzbnoqprw4gB0dTTvTj5M60D75NULowRBLirR3
   mgZSk7thYwroid6JQifRgM52NqPKFHPdlsNH9SnqhtBm9vwhHFSCE0/dY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380284677"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380284677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 17:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="914328494"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="914328494"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 17:59:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:59:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:59:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 17:59:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 17:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYu4hCIPFQJ+IXdlDcW2g19VfBRDPSBqyZi4UM21huum7QmppRKorgIbGggiKDuwmLShWwIBk49MFM+8bJsve/BnhqsNqZAAUONcQFQg2zmJCL1jGpJ2uYaqg1uq2UKxmyZqAZWX/ET8mxzuCHLoJmPnIt67gNiKeI7/zdoKt/p8/h5d1wFmH3l7VjMfT7vG3qzqUngT0tpZGiBg9K8rxrqQyaaoPo8U3DDZy5zQSEOsYBwA8qSdRjxdO66kL5xX6HwRBYWrO1CSqkQ9T8Ma+8BcFVxQiIkAk9jAsgDkXSlZ/U0SQF/ZQng4iiK+t2hTSaB+FHHb7dOhB2wSqvJicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLU9U4Tt8y19QHKPMcnGXspoiTKoNkqNfnmp5ne7Nuc=;
 b=BZth7bTo6HwZDAPKn6GwYe/LbN4rfotG99tRGRdr+Cgng+zOxrcOh6f+9mXz1nEEJKQDZQsB9wcvI05OeHVrNW09wboMp3EZw69IPPJUbfev39ShZ5YK1GZ+SZ31kD6uA3qT/YlnicGUQ96NAvQUk9sDMoRNRfoLZ2Xbd7I6loHn/hrjqEUqDhIS5b8CDoQcaBUzbzB2MCjhuoBGtrqDki5vq2kIadV4cMGwEsHuEqO5BtdEJNUh5zdLykxJV+KD411FeS1L5+sft1TOz4qmi1luv++b4e2+oT5iLq7oMJAvro/MY6j8j5DbckWShauOmZknOHYCrzHl2jejOqo7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 00:59:40 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 00:59:40 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com" <bcreeley@amd.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: RE: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZ1UdLBr55a0cOOkC26dNjnXpg9K/4uEIAgAFVHMCAABZcAIAAPQoQgAFe04CADiGKkA==
Date: Mon, 4 Sep 2023 00:59:40 +0000
Message-ID: <SJ1PR11MB6180F2DBE9F6296E35451B3CB8E9A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
	<20230824170022.5a055c55@kernel.org>
	<SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20230825173429.2a2d0d9f@kernel.org>
In-Reply-To: <20230825173429.2a2d0d9f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|DM4PR11MB6096:EE_
x-ms-office365-filtering-correlation-id: ff5f665e-4479-4b5f-9830-08dbace237f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T7ECNAfubhQpzNl+vCl33pWueTY1oO2ESheURtC4pAklySXnOZ9Vrdov5cv7CUNWcsEYJgh5f//yXRRNv95ugKlsiZJcnZGnvEmnuq5tl1al+VfZ9lVf1CBiL5bXhZTWDV+iveET7dYBd71PJU6DNgiUUv5urPi+WKbm4HgMlbUuBohhmaWHQo9zl1Jvs3SQDwDNutyv7hyk4v42jK+Yq+ENSTd/+GLOKNosMGriW+kPUi7SFu0FIrUS1+LuF5lus8Bel+NF6LWLkITiScfQnc5RiF5CUhA1k178q2Y8+y1gtI+fi+m3fL2TTvpE4lj1ueN2ArR8NWhnVBnd05yghzV63SvhZTVEdRNBRnpM3J1swcdmiq1IAdsfRJ3QQHrSF/ol1gH87zXjZ+/9VlDLhdgiopGA4NiDfoVWnh65TkXH/IAFyOrTcZVqwGcphrZPSzDZBDPrD4QO+zlPrZCC2H4vqYXr6Uv5If7us0j0p46x22giYQy711pU0hl1MkB553yMMk/GJgcUDVAkht+gKhh4rTuTiZf9xLi+zWLmynv53TjMDTTFEAsKfAqlB+gsFCXv+mY7gdLSq+2F/HhQ/x59X6ySYv7v3HlQS/Cvvd4nk2T5pgLP+65jrROFaWJzRZOdNvQyqrpK8UxdFtDJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(82960400001)(122000001)(38070700005)(38100700002)(71200400001)(33656002)(86362001)(966005)(478600001)(83380400001)(26005)(9686003)(7696005)(6506007)(55016003)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(2906002)(54906003)(6916009)(316002)(8936002)(8676002)(5660300002)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NityUXYxVDVLWWtMdGw3MWdDNkRYeU93ODYzdVRwY0M0clNPdy8vUmlWRlgw?=
 =?utf-8?B?U1FsQ1JJQS96OGx5VG9hT2x0QTJsMTk3MnZvNEpGd0Z2UXlmcWw3ZjkrSlhq?=
 =?utf-8?B?Tm9abUo5NTAzM29DN1RSNFp6c1B1Q3UyWGR5enlRQjNNYnVQM1ppRXYyandM?=
 =?utf-8?B?QW95UUN5cG5kTVZGczhoMnM1QzJZTmM1TWpnV29taGJmamNVZGNDUElobjVh?=
 =?utf-8?B?WW5xZTdISVM5L25HbU4zTlF6L3R2R2VsVGVyRDdkY0l3UE1BWFhRZTZWNWgr?=
 =?utf-8?B?dGxoYUxsMmlmb2h0bERhZEZSLzkxWEpIQVZ2L2U5OGQ4L0JiZVdJRDFjdHAv?=
 =?utf-8?B?RUtUcDhPUmRZaFhRcHlvWm05Zy9xejVEakVaY2UxQVVsdkZFUEw2T3UzY3dZ?=
 =?utf-8?B?V252bkJqdU5pOUVCT0w3YzQ2QWFXbDBTcjlTVU1hd01QL3BlNGFLZ3BUR09R?=
 =?utf-8?B?ZjFwR20xd0Y1MkNkRlZEbjF5WHd3OEt4ZWFlNTQzdFBubC9URmloMkcrNlRN?=
 =?utf-8?B?M0ljMTloQU5CMXFHOUZvV2h1aWdzK2pZd1RsLzFMa3VYbFJSWXQxUGtUcDdP?=
 =?utf-8?B?SlZzTVRkVjdSbSttNmVzTmdvTzZYdnRYdWUxbE0zMnRZQ29SM2U1MlQzZmN3?=
 =?utf-8?B?ZnRCWmliVzhlN2NLZWxMWWRJd3lVN29Fb2JETm5DMXpoK3d1S3VSdVZVdTNJ?=
 =?utf-8?B?d3ZYaUJBTzZtVy9qV0tVZFpBcDh1OStaWDRSSXVwdDNkK1U2dVZIOEpoMDBH?=
 =?utf-8?B?dWZUUVYvYW5wQjVMczF6WmFqaGs2SGFnR2FUdno0UUtoWm9yeVpGVXZSMncr?=
 =?utf-8?B?TXNEaEJUczlkd0o0ZzRyQXc1WFlGd3ViTUhXRWRnVWRBZVVRay9lUnQwU2hu?=
 =?utf-8?B?d2wrU3YzWnJBbGs5Um9oOTlKaUcyUE10SmgrQnVROVNhQStHNTNPOW90VlI1?=
 =?utf-8?B?dk5OODczN1ZhMzNEUHlDdmtGdmk5T292SHhwcVFjdFkyamhTcXZnbVJKcXFy?=
 =?utf-8?B?OThaNURvRlNEOXBIdVlRamtRMmxieUQ3MW4rcFlNWHhuQWkvMnE0ZmoxdmdP?=
 =?utf-8?B?RnMwM1hEelRQeVl4M1FGQzZYbEpGcHVXcUk3UlVEQ0tPM3Y0MjlPUGtmSmUr?=
 =?utf-8?B?ak4xTkhzbCtIS2FUQW1oVkFJUmNvNFlpbEtpRFl6bnhPZGNWMDV5dzBpaVht?=
 =?utf-8?B?MjNDc3loNjd4RmFCL2NTSmFpejZwdWV5dmswQTViL0Z2KzJObWdjZVcrTEdF?=
 =?utf-8?B?aFVxVythTjZadHRMbURoQzRTS0JKMEJaZlV5K0JZZUxLUC9CbHNsMmFjVm1M?=
 =?utf-8?B?aW5KUkF1aEtCalBYdDJpZEFMWjNaOGs3MURBUnd0SUpoRWYxdkxJeno4cjNE?=
 =?utf-8?B?ZVl6ZTVCSE1XV082VVRiV3Vkbm9jcU1vUGFsQnVQSEhFTGxBVUZmK3lRMzMy?=
 =?utf-8?B?OHpkMWNSbUd1S24xTlRBN0hLbjVOMVNhYXM1dStrNGorNmJRcmxaWkw5YlY5?=
 =?utf-8?B?emd1SnQrVDVtbUY0QVM4RnZFWGlSOFl5cGdxc29TRFo4ZWFSUC93OXQrbzh3?=
 =?utf-8?B?MkhUbHVBVHk1U2phYTg2OFExaWRSUG5JQzVQeGFyMCtHeVVsSXdoK05HTk5O?=
 =?utf-8?B?MFFnblpmVlNaYXQvVDVtZ3RqQjZYMDRLc3RVdFJHc0pEQmlqViszT2kzdTNO?=
 =?utf-8?B?Z1JQQnhXeDlBR3lwcnBIZWlrbGc2bVpudXpQeG5BaDd0OEgyYWNDUC9zL3M0?=
 =?utf-8?B?WlZvUkZmVkwvR3I4QVUvalZsMlMxNEtudEtpMTZoWWkvcTJwKzlCT1FzKzZV?=
 =?utf-8?B?bzBDL2s2VTRjcEJaWm9GcSthMlhHVGovQnoyYlZPZmtzbk9tUlNYTElZZFZt?=
 =?utf-8?B?QVBQSnhKNkZCN2ZIOHlKZDV1MTBjUzFlSXJtTzVYaDlCb1JWWmE0aC9wbjZx?=
 =?utf-8?B?TS9IaU9vN3k0MVZ4c2FKQmhXQVRrR2xhNmRvemZHeHdwR0RJbDU4TjEySFZj?=
 =?utf-8?B?OTRDYWM3OWg3U21tNWF3VTE3SWJwdXpzRWVjeVFWVThpYWdIVXZlU0dKRmts?=
 =?utf-8?B?NDBzcU15d1hoZnNBcDFDb0JPSjFRbFl3NjdKa1dMTGVicEt6UUhYWUpsZUMz?=
 =?utf-8?B?eHdSWStTT2tuTlB0aUpDRUFZd0JkRDFmaWdMUThqcDVaVm94VVhaVVprUHZD?=
 =?utf-8?Q?AfOKnJqErsbTnBoUERTTqfA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f665e-4479-4b5f-9830-08dbace237f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 00:59:40.4427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RX7j2VY+K9K0Nuu1YWKG+pGcBCKbvoW9kiYXLvZljhxmlCDdn5wWy1zdfrp9FtuLRNQ8v9LDah5onG88xoKRq3cRMwx8ex7eLRuPrTgplrvF3AZn+QHNaw86klLSoysg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldCB2MyAyLzJdIGlnYzogTW9kaWZ5IHRoZSB0eC11c2Vj
cyBjb2FsZXNjZSBzZXR0aW5nDQo+IA0KPiBPbiBGcmksIDI1IEF1ZyAyMDIzIDAzOjQ0OjM1ICsw
MDAwIFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIHdyb3RlOg0KPiA+ID4gSSBzZWUuIE1heWJl
IGl0J3MgYmV0dGVyIHRvIGNvbWJpbmUgdGhlIHBhdGNoZXMsIHRoZXkgYXJlIGEgYml0IGhhcmQN
Cj4gPiA+IHRvIHJldmlldyBpbiBzZXBhcmF0aW9uLg0KPiA+DQo+ID4gSU1ITywgSSB3b3VsZCBs
aWtlIHRvIHNlcGFyYXRlIGdldCBhbmQgc2V0IGZ1bmN0aW9uIGluIGRpZmZlcmVudCBwYXRjaC4N
Cj4gPiBNYXliZSBJIGNhbiBhZGQgbW9yZSBkZXRhaWxzIGluIGNvbW1pdCBtZXNzYWdlLiBJcyBp
dCBva2F5Pw0KPiANCj4gVGhhdCdzIGV4YWN0bHkgd2hhdCBjb25mdXNlZCBtZS4gWW91IG1hZGUg
aXQgc291bmQgbGlrZSBmaXJzdCBwYXRjaCBpcyBvbmx5IGFib3V0DQo+IEdFVCBidXQgaXQgYWN0
dWFsbHkgYWxzbyBjaGFuZ2VzIFNFVC4NCg0KSSBhbSBva2F5IHRvIHNxdWFzaCBpdCB0b2dldGhl
ci4gTW9yZSBleHBsYW5hdGlvbiBiZWxvdy4NCg0KPiANCj4gPiA+IEkgd2FzIGp1c3QgdGhpbmtp
bmcgb2Ygc29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyBvZjoNCj4gPiA+DQo+ID4gPiBpZiAoYWRh
cHRlci0+ZmxhZ3MgJiBJR0NfRkxBR19RVUVVRV9QQUlSUyAmJg0KPiA+ID4gICAgIGFkYXB0ZXIt
PnR4X2l0cl9zZXR0aW5nICE9IGFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nKQ0KPiA+ID4gICAgLi4u
IGVycm9yIC4uLg0KPiA+ID4NCj4gPiA+IHdvdWxkIHRoYXQgd29yaz8NCj4gPg0KPiA+IFRoYW5r
IHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24sIGJ1dCBpdCBhcHBlYXJzIHRoYXQgYWRkaXRpb25hbCBj
aGVja2luZyBpcw0KPiByZXF1aXJlZC4NCj4gPiBJIHRlc3RlZCBpdCB3aXRoIHRoZSBjb2RlIGJl
bG93LCBhbmQgaXQgYXBwZWFycyB0byB3b3JrLg0KPiA+DQo+ID4gCQkvKiBjb252ZXJ0IHRvIHJh
dGUgb2YgaXJxJ3MgcGVyIHNlY29uZCAqLw0KPiA+IAkJaWYgKChvbGRfdHhfaXRyICE9IGVjLT50
eF9jb2FsZXNjZV91c2VjcykgJiYgKG9sZF9yeF9pdHIgPT0gZWMtDQo+ID5yeF9jb2FsZXNjZV91
c2VjcykpIHsNCj4gPiAJCQlhZGFwdGVyLT50eF9pdHJfc2V0dGluZyA9DQo+ID4gCQkJCWlnY19l
dGh0b29sX2NvYWxlc2NlX3RvX2l0cl9zZXR0aW5nKGVjLQ0KPiA+dHhfY29hbGVzY2VfdXNlY3Mp
Ow0KPiA+IAkJCWFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0gYWRhcHRlci0+dHhfaXRyX3NldHRp
bmc7DQo+ID4gCQl9IGVsc2UgaWYgKChvbGRfcnhfaXRyICE9IGVjLT5yeF9jb2FsZXNjZV91c2Vj
cykgJiYgKG9sZF90eF9pdHIgPT0NCj4gZWMtPnR4X2NvYWxlc2NlX3VzZWNzKSkgew0KPiA+IAkJ
CWFkYXB0ZXItPnJ4X2l0cl9zZXR0aW5nID0NCj4gPiAJCQkJaWdjX2V0aHRvb2xfY29hbGVzY2Vf
dG9faXRyX3NldHRpbmcoZWMtDQo+ID5yeF9jb2FsZXNjZV91c2Vjcyk7DQo+ID4gCQkJYWRhcHRl
ci0+dHhfaXRyX3NldHRpbmcgPSBhZGFwdGVyLT5yeF9pdHJfc2V0dGluZzsNCj4gPiAJCX0gZWxz
ZSB7DQo+ID4gCQkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIlVuYWJsZSB0byBzZXQgYm90
aA0KPiBUWCBhbmQgUlggZHVlIHRvIFF1ZXVlIFBhaXJzIEZsYWciKTsNCj4gPiAJCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiAJCX0NCj4gDQo+IFdoYXQgaWYgdXNlciBzcGFjZSBkb2VzOg0KPiANCj4g
ICBjbWQgPSAiZXRodG9vbCAtQyBldGgwICINCj4gICBpZiByeF9taXNtYXRjaDoNCj4gICAgIGNt
ZCArPSAicngtdXNlY3MgIiArIHJ4dSArICIgIg0KPiAgIGlmIHR4X21pc21hdGNoOg0KPiAgICAg
Y21kICs9ICJ0eC11c2VjcyAiICsgdHh1ICsgIiAiDQo+ICAgc3lzdGVtKGNtZCkNCj4gDQo+IFdo
eSBkbyB5b3UgdGhpbmsgdGhhdCB0aGUgYXV0by11cGRhdGUgb2YgdGhlIG90aGVyIHZhbHVlIG1h
dHRlcnMgc28gbXVjaD8NCj4gV2l0aCBhIGNsZWFyIHdhcm5pbmcgdXNlciBzaG91bGQgYmUgYWJs
ZSB0byBmaWd1cmUgb3V0IHRoYXQgdGhleSBuZWVkIHRvIHNldCB0aGUNCj4gdmFsdWVzIGlkZW50
aWNhbGx5Lg0KPiANCj4gSWYgeW91IHdhbnQgdG8gYXV0by11cGRhdGUgbWF5YmUgb25seSBhbGxv
dyByeC11c2VjcyBjaGFuZ2VzPw0KDQpUaGUgb3JpZ2luYWwgY29kZSBkb2VzIHRoaXMgYWN0aW9u
LiBPbmx5IGNoYW5nZWQgInJ4LXVzZWNzIiBpcyBhbGxvd2VkLg0KSG93ZXZlciwgbXkgaW50ZW50
aW9uIGlzIHRvIGluZm9ybSB0aGUgdXNlciBvZiB0aGUgdHgtdXNlY3MgdmFsdWUgd2hlbiB0aGV5
IGV4ZWN1dGUgdGhlICJldGh0b29sIC1jIGludGVyZmFjZT4iIGNvbW1hbmQuDQpQcmV2aW91c2x5
LCB3aGVuIHdlIHJhbiB0aGUgcHJldmlvdXMgY29tbWFuZCwgdGhlIHZhbHVlIG9mIHR4LXVzZWNz
IHdhcyBhbHdheXMgMC4NCk15IHBsYW4gaXMgdG8gZGlzcGxheSB0aGUgc2FtZSB0eC11c2VjcyB2
YWx1ZSBhcyByeC11c2Vjcywgb3IgdmljZSB2ZXJzYS4NCg0KQW5kLi4gaXQgbmVlZCBzb21lIGNo
YW5nZXMgb24gb3JpZ2luYWwgY29kZSBiZWxvdzoNCg0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdj
X2V0aHRvb2wuYyNMODgzIA0KUmVtb3ZpbmcgdGhpcyB3aWxsIGFsbG93IHR4LXVzZWNzIHRvIGhh
dmUgdGhlIHZhbHVlIGJ1dCBpdCB3aWxsIGNhdXNlIHNvbWUgYnVnIGZvciBjaGFuZ2VzIGluIEw5
MTMgYmVsb3cuIA0KDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291
cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfZXRodG9vbC5jI0w5MTMNClRv
IHNldCB0aGUgcngtdXNlY3MvdHgtdXNlY3MsIHRoaXMgbGluZSBtdXN0IGJlIHJlbW92ZWQvbW9k
aWZ5OyBvdGhlcndpc2UgdHgtdXNlY3Mgd2lsbCBhbHdheXMgaGF2ZSBhIHZhbHVlIHdoZW5ldmVy
IHRoZSBjYWxsYmFjayBpcyBpbiwgd2hpY2ggaXMgdGhlIHJlYXNvbi4NClByZXZpb3VzbHkgd2l0
aG91dCByZW1vdmluZyB0aGlzLCB3ZSBub3QgYWJsZSB0byBzZXQgcngtdXNlY3MuDQoNCj4gQmFz
aWNhbGx5Og0KPiANCj4gICBpZiAob2xkX3R4ICE9IGVjLT50eF9jb2FsZXNjZV91c2Vjcykgew0K
PiAgICAgTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIlF1ZXVlIFBhaXIgbW9kZSBlbmFibGVk
LCBib3RoIFJ4IGFuZCBUeA0KPiBjb2FsZXNjaW5nIGNvbnRyb2xsZWQgYnkgcngtdXNlY3MiKTsN
Cj4gICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgfQ0KPiAgIHJ4X2l0ciA9IHR4X2l0ciA9IGxvZ2lj
KGVjLT50eF9jb2FsZXNjZV91c2Vjcyk7DQoNClllYWgsIHdlIGNhbiBhbHNvIGp1c3QgbW9kaWZ5
IGF0IHRoZSBsaW5lIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3Vy
Y2UvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19ldGh0b29sLmMjTDkxMyBzaW1p
bGFyIHRvIHdoYXQgeW91IHByb3Bvc2VkOg0KDQoJaWYgKChhZGFwdGVyLT5mbGFncyAmIElHQ19G
TEFHX1FVRVVFX1BBSVJTKSAmJg0KCQllYy0+dHhfY29hbGVzY2VfdXNlY3MgIT0gaWdjX2V0aHRv
b2xfZ2V0X3ByZXZpb3VzX3R4X2NvYWxlc2NlKGFkYXB0ZXIpKSB7DQoJCU5MX1NFVF9FUlJfTVNH
X01PRChleHRhY2ssICJRdWV1ZSBQYWlyIG1vZGUgZW5hYmxlZCwgYm90aCBSeCBhbmQgVHggY29h
bGVzY2luZyBjb250cm9sbGVkIGJ5IHJ4LXVzZWNzIik7DQoJCXJldHVybiAtRUlOVkFMOw0KCX0N
Cg0KSG93ZXZlciwgaWYgdGhlIHVzZXIgZW50ZXJzIHRoZSBzYW1lIHZhbHVlIGZvciB0aGUgdHgt
dXNlY3MgYW5kIGEgZGlmZmVyZW50IHZhbHVlIGZvciB0aGUgcngtdXNlY3MsIHRoZSBjb21tYW5k
IHdpbGwgc3VjY2VlZC4gLiBBcmUgeW91IG9rIHdpdGggaXQ/DQpJIGFtIG5vdCBzdXJlIHdobyBp
cyBnb2luZyB0byBkbyBsaWtlIHRoaXMgYnV0IHllYWguLi4uLi4uIFVubGVzcyB3ZSBibG9ja2lu
ZyAyIGlucHV0cyBhcmd1bWVudA0KDQpyeC11c2VjczogMTMNCnJ4LWZyYW1lczogbi9hDQpyeC11
c2Vjcy1pcnE6IG4vYQ0KcngtZnJhbWVzLWlycTogbi9hDQoNCnR4LXVzZWNzOiAxMw0KdHgtZnJh
bWVzOiBuL2ENCnR4LXVzZWNzLWlycTogbi9hDQp0eC1mcmFtZXMtaXJxOiBuL2ENCg0KcngtdXNl
Y3MtbG93OiBuL2ENCnJ4LWZyYW1lLWxvdzogbi9hDQp0eC11c2Vjcy1sb3c6IG4vYQ0KdHgtZnJh
bWUtbG93OiBuL2ENCg0KcngtdXNlY3MtaGlnaDogbi9hDQpyeC1mcmFtZS1oaWdoOiBuL2ENCnR4
LXVzZWNzLWhpZ2g6IG4vYQ0KdHgtZnJhbWUtaGlnaDogbi9hDQoNCkNRRSBtb2RlIFJYOiBuL2Eg
IFRYOiBuL2ENCg0Kcm9vdEBQMTJEWUhVU0FJTkk6fiMgZXRodG9vbCAtQyBlbnAxczAgcngtdXNl
Y3MgMTQgdHgtdXNlY3MgMTMNCnJvb3RAUDEyRFlIVVNBSU5JOn4jDQoNCj4gDQo+IA0KPiBJIGhh
dGUgdGhlc2UgYXV0by1tYWdpYyBjaGFuZ2VzLCBiZWNhdXNlIEkgaGFkIHRvIGVtYWlsIHN1cHBv
cnQgLyB2ZW5kb3JzIGluDQo+IHRoZSBwYXN0IGFza2luZyB0aGVtICJ3aGF0IGRvZXMgdGhlIGRl
dmljZSBfYWN0dWFsbHlfIGRvIiAvICJ3aGF0IGlzIHRoZSBkZXZpY2UNCj4gY2FwYWJsZSBvZiIg
ZHVlIHRvIHRoZSBkcml2ZXIgZG9pbmcgbWFnaWMuDQo+IFRoZSBBUEkgaXMgZmFpcmx5IGNsZWFy
LiBJZiB1c2VyIHdhbnRzIHJ4IGFuZCB0eCB0byBiZSBkaWZmZXJlbnQsIGFuZCB0aGUgZGV2aWNl
IGRvZXMNCj4gbm90IHN1cHBvcnQgdGhhdCAtLSBlcnJvci4NCg0KWWVhaCBsZXQncyBtYWtlIGl0
IHNpbXBsZSDwn5iKDQo=

