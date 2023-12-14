Return-Path: <netdev+bounces-57675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C504D813D15
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 23:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D0C1C21C47
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A3671FB;
	Thu, 14 Dec 2023 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcAEiV2g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373F671F8
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702591987; x=1734127987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkhJrrf8171SuKKz4xBv0+VTVubgQKW1zPZrZrfr1UA=;
  b=IcAEiV2gLgl53PHRs5ikfdzVUVneXZV2oRgUJSKv4rZcm0J6SEhr0DQe
   +1alxjt2UcflWb33hriWZTHUzZJqvvhl3fLthU6ZA4M1kvzMVGe5n4984
   wawq8E7E5WJTkFyabu7UMMNkkMrFlaXAtY4c5KWt13Xs7mhtE+0wP3kAq
   0YXZsG8a9ptubiqHHekJR1Pu6WSnfVs0o+/yzSiBgw+P19Dx5LuqUj4dm
   Qk71oeDL4LKwDWtzt5oi/KBzpP/n9GCYg7Q24TlSaX6nEJwhv5sEljHYd
   z4K6fZ2H9J6PO6qFmidaRaxr8t8x2yiKDjUkaeBXm22eRgpo5ITXwzh0V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="461657918"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="461657918"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778049015"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="778049015"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 14:13:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 14:13:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 14:13:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 14:13:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 14:12:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiKMXRP0SNNfYzA9cjbEX4zyNr56q6F/uIZL4dM7TeRn4G7dya4cO9O5rqVsgTqhXVeTmr0sjjGkmI1u3tVmaxe5SiWGIusEeyAJSdHoo9RcVvq7Vh7rnVL66UYoB2BWXoOer0772/6gTV4I94wClcB06/uwRkLzhizaeEjdbYYe0yrbJGIr21r4vnReFP/L9qYnvAcW7f001xabR6j9OPPf5nRBlPtiOhEo3ErqEPGyXui5HxOKnvMnEtDi2se4mYJ1u2XukfbemkgTOgTi3JkU0b1h5oU7hAbg1Tbxx2M9yjJIryM7R4IKXPYRi4Ye5ems6r0w3aqpBzsS9xn1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbiM8kLgf/a3zNG5PC6Hr+dStNcdrwjChahD5IYWomo=;
 b=LoG64ZqQ4jAIEyUiZC8KbIWFV0+qe0JChnHdLE0KfO86YwSed9oVY/AL8IXCvIo1tsdZDEkhp9LvLgtbUsSJYCWkzhxQV5+UBgtbSN5SFMM7ZN7DMk1KHwWCUQpZILHactsadbJdN33qctbajQ1scbIRpQsRri6PjVKe/7EJU4Cuk0hdFrLtVIInOn1vO6tnB+uxG3MjROaO9ZbYam5ooAAypGzaIgArQWvP4+iL3Ox1Mn/d7e/hX5wBTWHH989Eon2OUoGJ6AUrNnxYN3INKPTphoJSdP5dPgOD+LpXV2ltb8m06Ngr+IYdIfsdcZ9vyBBJmjV98J8/sChqpLinDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM8PR11MB5638.namprd11.prod.outlook.com (2603:10b6:8:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:12:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:12:56 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Stillwell Jr, Paul M" <paul.m.stillwell.jr@intel.com>, "Tipireddy,
 Vaishnavi" <vaishnavi.tipireddy@intel.com>, "horms@kernel.org"
	<horms@kernel.org>, "leon@kernel.org" <leon@kernel.org>, "Pucha, HimasekharX
 Reddy" <himasekharx.reddy.pucha@intel.com>
Subject: RE: [PATCH net-next v6 4/5] ice: add ability to read and configure FW
 log data
Thread-Topic: [PATCH net-next v6 4/5] ice: add ability to read and configure
 FW log data
Thread-Index: AQHaLsWSQktFpRHi6UKfO2Vq/h1eBbCpV06Q
Date: Thu, 14 Dec 2023 22:12:56 +0000
Message-ID: <CO1PR11MB508924EA519BF7AEA912FCADD68CA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
 <20231214194042.2141361-5-anthony.l.nguyen@intel.com>
In-Reply-To: <20231214194042.2141361-5-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|DM8PR11MB5638:EE_
x-ms-office365-filtering-correlation-id: cf41bd58-6194-4f9d-81a9-08dbfcf1d38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXdBByDm48yc448/Tlp2Jge+2zvsS9F42KGQh/cPCc2QZdpvPeXWnOvigZiZWh5r5G7gsJ97Ek92BAbRuMc7KsR41Lj1rlioofTyKPwU6sNsJVuMHd4A47wapYgsMoqKAos5LqM+COQ8utw8h0I5LAnpeoBCclnpIxJ11znUj8SUeAZm5brRSqxSQRIiynNyQM6nWS5T03O9C7jEXp9kmmYSsofYBSa4IhW5lTssNfyl8N0n+yJtkqyfUohnHfShNeoU3oxj671HJ6zdIpjWQ4npzaQPFO+2tuWoJzEzsNFbAPqsv7ev0fg/lF84f3ytX5JIn4Tumzp85zvfG/77RFOCZ/uG7hG6FUMkwe4ZV6b2wI8fPjxVhcirMEavCoqSVE0s8l5vG7Uk6b+TErVdPYMOUTAGlrTRdQNnTNYgL/o4GwQtHd99lWzMdlGHGATw62QI7/T5wWy8AbPlsI5BQDO7nuApnOyjM84JLeOrVJhqwPJLkgrF7BScNMZaVEWdTMK7JK+xONHZfhfZ1xM2sKL/VTEJdGKCGi3JxAQlC2qE80YguZuXmn1v5Kv9sMo3pn5CVTbCA/77fbj9i1yAQQjaZKzMKuKx7zNabcym+CQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(52536014)(478600001)(9686003)(26005)(76116006)(66446008)(122000001)(64756008)(54906003)(66476007)(66946007)(66556008)(110136005)(38100700002)(82960400001)(55016003)(107886003)(71200400001)(7696005)(83380400001)(53546011)(6506007)(316002)(8676002)(4326008)(8936002)(86362001)(2906002)(4744005)(33656002)(41300700001)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sX/3WNdb2IUp1peWuJTeVGll/GlS5uxclqZmzcICg7sgiCvS+/AkvOpHOjHr?=
 =?us-ascii?Q?RzTvGYLjc6H686q+1a/LeRmRQ+iIaiY3iLSIbhXv/IWGc1oo2dmTdv8vI0hi?=
 =?us-ascii?Q?DHqWzcLoexQQ/bjtaO7p3IsfGcfksHFjQ53az5WKGeDn99EMCUFoGirfo60L?=
 =?us-ascii?Q?30I6kPFAkMvTSz2YaC2uMvUUEQGri5puCQvDR6Q2jq1w9NK3QNlttFyW3PrK?=
 =?us-ascii?Q?S41RQxAEfFU5gvxY1XJmrLkvO+ZP45aSmrsB15zdrK5XRBisFakcl9WW490W?=
 =?us-ascii?Q?c01vh5gwVZp7vTcVsj65+aexyQS7KtLGNugLyNVBL4nL8/yRBI+WWbruoN8l?=
 =?us-ascii?Q?ghuz+u3/X3OEOrzSA4q68BbwsE0BP/quJNIggI5NaPyXFb8TwLDCllFjawma?=
 =?us-ascii?Q?nDyF9RAJ1cN+4+YGs2rvaT2nTYnv+lU1bUZu1hDYlSnTIzY8rpuPWYXhGv71?=
 =?us-ascii?Q?hNZ23G77ZjYSLPO6IswuZLrhvbuySlyuMtClVonMd2atKoJe9/zWqZ45WzjH?=
 =?us-ascii?Q?FYIpfYvem1WUIe6cjzpya/FNdMujZwl31bt+iEea3WRZzmOWdM72z1qcHvC+?=
 =?us-ascii?Q?pbmCW42eLP+iRSwLH8z9MbPFFndVTVapWW5dyZduZiBZEbRq7CoA86ArG3uh?=
 =?us-ascii?Q?viluB6oOYHwrdSJmsyhNNfwP3XIOOpQJf0qfagxkbBuoB5CJjBYSZnvRcWGW?=
 =?us-ascii?Q?4telSuPMaKAnxJT3kXUAvqv6By2W5RJwyI1tHBuUslxesLgd7kt49dtzm2vM?=
 =?us-ascii?Q?aTE3ZHMNb+nqd7D9Epj0aVHeH9mWWeWWOusJ4DOGSJZNnRfcjC9pS7JWpymB?=
 =?us-ascii?Q?heGBCLBqQ42moXVVb0zM4eyhPtUiQQBs9UxOcFc9Kwntve+eW0rfeNXX7P+2?=
 =?us-ascii?Q?ZlLe7Viv6j+ZINF+gtOVQ4itl8WkceRbbTKZHrrJzRFhLKVN3r59BJZ35bFP?=
 =?us-ascii?Q?xKft0282dsq/JqWy0ehS0QoY2KS0nYontlp/zscjulSiO7af9bk0Cg2DeM1x?=
 =?us-ascii?Q?/RQW6AFCU+0mVGmyTTtfZ/1SLmmt4z9QBves/FrFOUEKzbitoourufiRK3sk?=
 =?us-ascii?Q?fROM1Z/qvPoaT+CUu+pfB/SmXG64qnn7HE3n9EcUcW8RpTzN24lEVZQINxBt?=
 =?us-ascii?Q?OwGL5QLIj5f0RhANzfJ1mWd/TF6NGfexEoxxxn0kUHBkg133Z9ZDv9anVgWk?=
 =?us-ascii?Q?WY1RmQUFSFSCyDwKUKMYxzggo/t1IcNglWhe9vrnv6DlcXw1zRA/bSVRU74j?=
 =?us-ascii?Q?Fg4PyqKFW2oBJ/Rgm6KU1ABDJ5rlblcGCk8C3MtXB3a/e88TMIPaVt8OJlPh?=
 =?us-ascii?Q?NGhp6GJXW1JTSzrqEHyKzf0Bc/vGCqic8MIY2tV9RDhk19r8FcuhinDwX1CO?=
 =?us-ascii?Q?ew05Ui08iVYiqo4OjHYQz/hA5Fy/y/YdQHctIJyITy3vE1bld/Ju4OdwPr8Y?=
 =?us-ascii?Q?ohYysh0Tt5K3mKcb3b74sCVk7ekbjtPfF8QWeZCWt0t1OdtZPHDGBVFD8yHl?=
 =?us-ascii?Q?2UV1zU7a4ooy4nu+d3hqjoaME1ZAWDjXY4J3oMRnfAanCAQmUCj+SYwCO2N7?=
 =?us-ascii?Q?1+7iOCkusbD9aBsdM74tArSgBV4yIFAd+YYXPVHF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf41bd58-6194-4f9d-81a9-08dbfcf1d38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 22:12:56.9307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3on2E3JpqKKcskQQzD/SCcIz6J1qkWC1GsnmQ4xT0CDmp/6bBCeexb0la5g8r4lqz1AZWApeG/n2UQBqUlnq3XEtX4BL935+Di2/XRbpCjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5638
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Thursday, December 14, 2023 11:41 AM
> To: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; netdev@vger.kernel.org
> Cc: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>; Nguyen, Anthony=
 L
> <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> Tipireddy, Vaishnavi <vaishnavi.tipireddy@intel.com>; horms@kernel.org;
> leon@kernel.org; Pucha, HimasekharX Reddy
> <himasekharx.reddy.pucha@intel.com>
> Subject: [PATCH net-next v6 4/5] ice: add ability to read and configure F=
W log data
...

> +/* the order in this array is important. it matches the ordering of the
> + * values in the FW so the index is the same value as in ice_fwlog_level
> + */
> +static const char * const ice_fwlog_log_size[] =3D {
> +	"128K",
> +	"256K",
> +	"512K",
> +	"1M",
> +	"2M",
> +};

The comment feels like a copy paste. The size should only matter for softwa=
re and shouldn't have anything to do with he firmware as this is just the s=
ize of the buffer we'll allocate to store into?

Thanks,
Jake

