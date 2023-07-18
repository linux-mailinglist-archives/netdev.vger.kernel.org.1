Return-Path: <netdev+bounces-18648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11D758329
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B1A1C20D43
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23210797;
	Tue, 18 Jul 2023 17:01:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C5C2C4
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:01:04 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A4211F
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689699642; x=1721235642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EVKqLx+gx4zborydf6ks+xloLdhUeDN7ImtH5n8tT8s=;
  b=AL+ejYBhCCDPIIEAEyUlWPX1dwNMB1EoMcmlJIqjkZp0NdFQMJ7OBBQ3
   e8djGMKTahIU3Y7eBRXJEA99O4+cfO0CvgbOhYGOKK6WLFl+UHPbCJZ6F
   3smOJlF10BobYh/pOVMY3de/QPfHj6ZM1EJE1AQ7ZSpYMKHXh0fY53B6T
   eRQEQTVEIGJ06ozCdbZdA3jNCehp+ZPZ1qsdJqjoSOqWA5fXVLtGU8EXB
   blh7GeuxFwFIil3zho+H+9IFyTpFulYATTWj6DGoWUyvJ56EyKIgR70Az
   8/tnYx0pTr+epljdbBVx6rJNrlpoPfH8suU55V8+uzw7EhzZCq+JxIguQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346556965"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="346556965"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="970310686"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="970310686"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2023 09:56:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 09:56:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 09:56:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 09:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+bjmbrGojURU5vsLsYA4ZFAlriDQ1BtjEynbV8Zst2jJM6xJQzeA0KCMiCHGxGueYEVzsz6I6NcTvKOkuo01uHkcN65FuuvFLCRaGoSMUcmwDHaVZroTDLSpDqR9UVL6LzjDWlULCjK2gtKjBzw2s61mDcCsH9D3ZBZMGjkJgdZL2iVHUh/4cWj4eailySyLU7BOmkUKNIxZuybkw0/+oAGlKOJUVfPm7J2bxd5DPLySYltaLJgCowXqK8QkvjPIm8Y2wNBzjvpnTS0wV5+KC9oiIbGLxQkYwnuC6UljZCdFMDG2jA9+S1xcU4Kq8fmYP1pn0l0A9Bsa4SixMApBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynHatWkg0UHRhld0svoIbMzFonUcuu6h5qM80uodWlg=;
 b=nt/RqSfbopU75qFdvahtLzpBV+PkBG2aDTdCfOAUgxB1Zj1sBXGCxDRo5cL1PS+/cdQf2XBUA9WQ/w48W3Cck1NbFb500t1uDyz8YaOhaSIaJrqC97/yHxKW+UhVhF76CfsQhwRUZkluPmYxUv826si3ihJkSkqHeEbml/b5SklJR+/cVd1yocV3tV3ZlpKzzZBCqrFjq/J3Vvt/B+pPAWGGWtvhZrggRkAYIhTSZLYxgW74/lyQQMiabOxBjJ3uurfo8+VWScMeUa/+OxeHrhPA4O+70taFvLdbsjiYYB00W3Yp8lDhj/8jhqK6ou97M138xQdwpriD1gocfgYRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 16:56:28 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::c3cd:b8d0:5231:33a8%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 16:56:28 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next 2/2 v2] tools: ynl-gen: fix parse multi-attr enum
 attribute
Thread-Topic: [PATCH net-next 2/2 v2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Thread-Index: AQHZtWmK/0NmrKW8oUWxQVMAHqasPq+33bsAgAfhwfA=
Date: Tue, 18 Jul 2023 16:56:28 +0000
Message-ID: <DM6PR11MB4657185674862C8771D984759B38A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230713090550.132858-1-arkadiusz.kubalewski@intel.com>
	<20230713090550.132858-3-arkadiusz.kubalewski@intel.com>
 <20230713090836.13c946bb@kernel.org>
In-Reply-To: <20230713090836.13c946bb@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB6455:EE_
x-ms-office365-filtering-correlation-id: c1581790-6c68-47df-556d-08db87afede9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XbYmL9Axn4T8yp3br8H68LzvzAZ1Zi8Gp6MqDFkiY/rBUmR+CYzOqW07sJ5xJLVkn8E+YZocy09syu3RVkWtSZGIBPyxUfVCDvK0MX0NsyTitiregE0+PeNvV0lXTYmbJ4e042h65xw5T4Wu2kIuMjMv1vDGN+aKZSJo5bPp2GIztlisScxfTJdMP08v2k4mfH3vRPI/+y02djQFwL+/C1WCxS1Wlh8DbggvUzXjSVayC47Agvgrs97MdRBS+qzKFyiOxhM1KJkEKl1uNbcrA12gLtaptZDpFZC45JF+2QgPOWfp6xNzceFwX5gyiHTsG8TV631XjbhZFhbRJRYkS3R9TAMuZPf80wJAwUSSxuccx/si43QgqZ/udGP4/qvoZOGeyunXR3a86aZkvnccbqrbQurcFSUS7/wcrt+KFLxOCsaIElkyA8YkrFPqk5WEvl98afODEGa/nq1fvPI1QmPh61dBZCFV+q+tiR72GqDz4QKSbQCJKPqmBtliC+IcAgtYy4TLcRh1aDb+Uc2OD3SkEwYf1DpeC0V8bq8fkbNQCZdgRaNwqJAL0X7Rw6MwEf1AEjqZUYgEbOLdiGXvbE2SHHS376RDZ+xZ9lRWepeedvq/nX75SBQZ9W6kobXA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(2906002)(54906003)(7696005)(478600001)(71200400001)(64756008)(66946007)(316002)(8676002)(76116006)(41300700001)(66446008)(66556008)(110136005)(66476007)(4326008)(4744005)(82960400001)(38100700002)(86362001)(8936002)(55016003)(52536014)(122000001)(9686003)(33656002)(5660300002)(186003)(26005)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jcyrr05nplfz5KUs0IuQAxJCNL4UeFvrWKMeGCdWYvIwj6b2IqIqWqiv1tj2?=
 =?us-ascii?Q?KWNAvyBNoM0+STatAKm4U0Hunr+H+d/7Iywwg0Zg2NZzXMTouZv3nzNGJ3io?=
 =?us-ascii?Q?sV/YVdkY3GkGsxV1nQX1Z3/4Xn3hXbfhkfDGRAeProbOudkyvgIjh7B5O1e9?=
 =?us-ascii?Q?fPTWUrXRRJiUGdckkWZFEIJ96r1lnbKIDcvZa9GnpV651mC3n8tAtfNL5Pyi?=
 =?us-ascii?Q?MfKC/ERhRDIIcKIVJKt7g2H6oX1qxFDZqzdZVtoEHzNyivW+ScGjYF1DKNQg?=
 =?us-ascii?Q?/I3zAcT04Wv5tEptDiEYkN1Bs3InulLGKQvhij9dDNjugrm+lTa9lNIxyvD7?=
 =?us-ascii?Q?l+TXgrkDIXFeuRH+7SuShAYJ7m+LS43QcR3GbtCPHvSKEqM8EK37jAphOpEU?=
 =?us-ascii?Q?2wgcYcLRRpae6z1Xaoii8sUb3xm4eV74ZRrZuoy5uJ8UGYEsEVW/GH6wNENf?=
 =?us-ascii?Q?1/2XXbWRT5ybr4v3oVViQtBbPgqcaDuUpVNWELMl1NUBjewSRvzgcE+biMq4?=
 =?us-ascii?Q?OML7QxygI2Oxif7Td+k+JLm8gggDQWn94owIz82KhXxUGESdc8r2ehUzf5/w?=
 =?us-ascii?Q?J5FA3kUs2YGf+bS89KBkjlufQr09lGgfrOb0/Y+jBbyu1b4UeVLXL0GxICZW?=
 =?us-ascii?Q?eOUyLlawdL08OpVV26J4vDnMx/XnWAgZsv44FHQPEpf7cF1Aco2cdnViFoh0?=
 =?us-ascii?Q?eDW32y+2rx+OVkEDl1QYqHEQH/azJygyxyojNb2o5vEuiWke5QQZVmVjGNDG?=
 =?us-ascii?Q?CN+Mvp8/9hASGnLBIy6jpcnSRx5DaavOf83Ob+n/PS5RaeOc5aRXnwnS3Ome?=
 =?us-ascii?Q?7y/agZjFHrFfoXmkkDQ3PGk7ucShLP6cbHiCUGTQk5kBkV1KaFADeFTMRa6o?=
 =?us-ascii?Q?Ls8dISf5qn+P0OnK7RA1Xoa3UmiZIj0CR8BBsivJ4GB1VfkP7FkjgEb8wx1r?=
 =?us-ascii?Q?6vkf2RtIryByIqWQxQLpcBecr3UO11ul+SqU6m3rZnPmWEpVROqXPjulDZLm?=
 =?us-ascii?Q?Ou6P+tTlSppMw060eUilGBsm3Rx+WAAqWUBqWFKG5ytneoon9qXRs8e3gUwY?=
 =?us-ascii?Q?yz3TknhaNMUOvmMK7lAngFjREe87WTxVsywhPmm2s/iItlM1rv/zl8tCa2Ho?=
 =?us-ascii?Q?kcRrQqMSaaAeYozKnV3bSTLRibMEyu5Yl9KhsPdLVkZ9Fl4HBWpX3iQzSk6L?=
 =?us-ascii?Q?7DokumnnjVjrGeOC8wsGEQNG4RaTldHkGuLD9zL2/dgDAYkoA2wv/+Ht9r1a?=
 =?us-ascii?Q?qr26hW2sGlDVou0l/ivSIGd9JSjHCcqg3pD2wNtPTOuOLUD0u5VFACIcYvEf?=
 =?us-ascii?Q?nEsA6VYiQG7BOr3hmPrgA29nsjWwk3Vu2Ly+J6aL/K5LI78H5XHa+05u1x4p?=
 =?us-ascii?Q?wgvlL2X9/cD7u5FaCbHJKVMTxYFE9OjJWs0qAd2Zi7DC2QY07AahfrJcsibO?=
 =?us-ascii?Q?6dZTnSXk0/NzoAqNsuHWoJ30sMUAxTrWTJICdUxY4N3AQ2x1mzEWTnDmZMzM?=
 =?us-ascii?Q?NEJbbVzIQXNVpBYK7pHrOqPaXC7FmQbJs8uCFw0AqvrmFEElsHvj63INc+57?=
 =?us-ascii?Q?pX5/Q9kYdG9Tv6kHE6s5IXk/JxFnPP0CQkFIW0W+v+JqxUO/V4tl8wzufaXE?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1581790-6c68-47df-556d-08db87afede9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 16:56:28.3028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2n8WQ0t0xg0dA0Iq4mGgk8zBd4i5tziAeRtcyj1pcpm6z7g/hftyqUbFlpyoQyG3P6/qkYsoVDqN60q9LMBUz7Csfk/3zbKc888lJp69NMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Thursday, July 13, 2023 6:09 PM
>
>On Thu, 13 Jul 2023 11:05:50 +0200 Arkadiusz Kubalewski wrote:
>> @@ -436,7 +435,7 @@ class YnlFamily(SpecFamily):
>>              decoded =3D attr.as_struct(members)
>>              for m in members:
>>                  if m.enum:
>> -                    self._decode_enum(decoded, m)
>> +                    decoded[m] =3D self._decode_enum(decoded[m], m)
>
>Yeah, not sure this is right.
>
>Adding Donald, dropping Chuck and LMKL (please use this CC list for v3).
>
>Given the code before the change we can assume that m is a complex type
>describing the member so decoded[m] is likely going to explode.
>
>I think you should move the enum decoding into as_struct(), transforming
>the code into similar fashion as you did for responses (changing the
>@decoded value before "value[m.name] =3D decoded").

Tried to improve in v3, please take a look, although not sure if passing
attr_spec from _decode_binary() further to as_struct() and _decode_enum()
is sufficient for us..

Thank you!
Arkadiusz

