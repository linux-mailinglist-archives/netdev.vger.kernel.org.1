Return-Path: <netdev+bounces-61962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C8825635
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8228109E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA02D7B0;
	Fri,  5 Jan 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkhnZRFg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C092E623
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704466662; x=1736002662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uz4F9QznFEpxU+dTtJmWS6LLPxSjHNxwiM+IkJd2BN0=;
  b=bkhnZRFgrW6i9kFTaBwzU6/vu4zbA+uu+CDlYPp/Jw3rodiEt3nqA/WV
   KSxesNL+P2B49j/OCXYUcq3y2m5SS2NwgMJFpcp+QDKPjXfbOF+Fy3gUp
   aXn+Qoii8mHSOiXjRM8BjtOQiZdN4sWPeYkchfGYfWjGYjxq7nXdSrhcZ
   i0NRwx/XH8Ogasbhtful+q7R6XCkzu5D+3UAlylVYLP8LstF+1TaVbmVF
   COPOAeTku4BkA5V1qASF5gdsuSW0QABOTmMcRUBkRfFrcwbZ76zryJWBb
   gavbp3ScYt1NU7cWEmKQleQ0/XtuLL8VO5qgdt+jgKexJyCveVxlwhqS1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4282598"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="4282598"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 06:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="730487093"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="730487093"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jan 2024 06:57:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 06:57:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jan 2024 06:57:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jan 2024 06:57:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5zMeUM17mpcoWo5qhf4c4U9D6L6RLuiAKDn3ekeOZZ4aecXoHrtQE7Km9UswYTbdXyEJRkjJFiTtOpvLJwQtOMinKa+xRG4AUhfEFOaNJm27KCGTOykKx0OI8H4j+IUT+hQXqqJmxY9QcTIAsgP66S4nu2ORj8oQEXvMbJvs3l6ZzuZSrMIOh+B1MC5cm6HmciZXDpE2NzqzH63ZkdRbP2YqNR+cQnaPyeCccNrgH51WYhc+LvVCe8cc8wN9cZFNXbPqMMrVauG3NGNQmKk+OQYEiTpdo2xwKEE0zq4cnu3YQIYXGczlhuAwGFPnERHvJjosZDIIpVjAJjUkRpZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz4F9QznFEpxU+dTtJmWS6LLPxSjHNxwiM+IkJd2BN0=;
 b=YtAebkX2d2KCSPnHlxGGF2Uam9Dpav6enUOS66BfDj7SSLMnqkArLVfO9sVge1HFRwciHfidouFx+GQcb/GWBcuBwBPizEOMm3fpG/tSC5lhGP9vYMAOcDT56htwpFkGrEPT8iyP683Enq3c52VlqdeOsJi6AhxExWOPg0XsTXXmvkz0AUVwEb9KipaYjQ54HmsVB0/F5xmxa85lro0fsPrjMRFnhTdh+qKi0MnsgdjjE707yFk1m5/PBxuoGpvZpZ/P1x1o/aZEy0tyh2S+HnLyyWqlK89zIzaa+dH67TCx9OzJrWGZi7IkmOjAl/vEmBgH7a0HUbB5UakT+WW0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.16; Fri, 5 Jan 2024 14:57:38 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 14:57:38 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "M, Saeed" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "Michalik, Michal"
	<michal.michalik@intel.com>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>
Subject: RE: [patch net-next 1/3] dpll: expose fractional frequency offset
 value to user
Thread-Topic: [patch net-next 1/3] dpll: expose fractional frequency offset
 value to user
Thread-Index: AQHaPkjaiDPlYuBq0k2gBv76bCVBXLDLOQCwgAAPZYCAAAnjgA==
Date: Fri, 5 Jan 2024 14:57:38 +0000
Message-ID: <DM6PR11MB4657613774243D56CD8144409B662@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240103132838.1501801-1-jiri@resnulli.us>
	<20240103132838.1501801-2-jiri@resnulli.us>
	<DM6PR11MB46575D0FFEE161D2C32D26C99B662@DM6PR11MB4657.namprd11.prod.outlook.com>
 <20240105062133.17456a14@kernel.org>
In-Reply-To: <20240105062133.17456a14@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ1PR11MB6276:EE_
x-ms-office365-filtering-correlation-id: c52457cc-0ff3-484b-e44e-08dc0dfea8ef
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZcT2+S81K8irj+F4c5JmfUHAMCcoHUmMPLJNi2QoRfrjih66+U+qPiR7YefMuO84gafEZjnXIC0v6UvZKh4aMBalNZtFJXVmn0EY2wa8lR/NfyZZrKz+RGNFdd5tQUGCSrtLvPhCJP0sGB/tjM2Da+M2p1m7TG/S1YByZhocgaDtCinyBhGpskDJUPN76QzeSCvxY+L+iEF5kkNzv/+XU5daQqzVTvnO+5dfSHD6dmzNKZEs3sWCQ1W1J8++0m7ZBY3Wv+oNU8oNOws8NMzk7MEraeyqK+NFJj9939x3CDyMTsm6Xa5/UX4T1bFoweJ5meoA0MyfGSsz913mmEEvYM07zWWtpZo3LuzHl8RycCLYL5ZgWW4L8Pl6aXPTumtCkBWABRMRfT0OemCFfiZMJ5Q+ETeP7SJSWGwXEXHNIpH/xN+eUyxjBbujQCi5ucFwlJj8kXzQkykITJxSbdZRDD4magVxbVc7VcCf/w2KysAFFoXk/+Bkj5tLN/duYJGM3ltGtu+REXEkbW4hA3Jn71cWge8NTkuIB/5lDntVKHCeXCi3C/lr/6fgRUVrJ2JW9gSIJvO+JyNrs+z03Kg4/xXV0gK/Yos70nhrlcA+K2g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66476007)(7696005)(478600001)(71200400001)(9686003)(26005)(6506007)(4744005)(7416002)(5660300002)(6916009)(2906002)(41300700001)(66946007)(8676002)(316002)(54906003)(76116006)(66446008)(4326008)(66556008)(52536014)(8936002)(64756008)(86362001)(38100700002)(122000001)(33656002)(38070700009)(82960400001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1v/WqdmCvSHWm5uJ6KXprfx2NBA6eKUHmUHLvpMVwdz9MjjqIkoD9UhsokfM?=
 =?us-ascii?Q?JQc7ykKjITw2n0cctUUn84uKHJISIHxofVMCXOQZWQIjHTSqVh8a5C6L4YjA?=
 =?us-ascii?Q?MHE46/UnUOcdVh4zAEyKa8rmkiVuIa9VE4GgnVKygxVkQx9y3W+x03nEkVcl?=
 =?us-ascii?Q?N8aboKLEnGVUii7wsgaAJPUANt+MYYavMeaSljRYe+U/wnJxiBv5+dvAU6FM?=
 =?us-ascii?Q?AuhNCcAc0Ko87Gc7EL3LLRImWiWGYXqWojaFbvEf+ptGhflvRpW0PkicC95B?=
 =?us-ascii?Q?V2VIV25TUmUjGV3d2yY3KZCttZvc+7fCEa8DFqn9JsnsR/L2DgJf4sikoBHs?=
 =?us-ascii?Q?m9g+Ctp6AowYC23+v5634o88yeA5arsSLLp826+mUj63DLXN58w1+jefXMzK?=
 =?us-ascii?Q?9IKeFBpBmVGI30S+3onrw8604l/v5nyB8AZCvomatVPNmXIWqShmpK7RKk4z?=
 =?us-ascii?Q?ZGlY0HJgqYjRjTRRHAYPIZjJWxucKgyCR6NsOr5FCru4vXAJin44Tvex0YOl?=
 =?us-ascii?Q?TyL/DCL4Ph5i9IqyyFVR9mB69mUZxgMf1HVotsamr/XhPv6CbxsooUWbtXKw?=
 =?us-ascii?Q?KvtJg1YGgZ1Oex4j6Ser9awAZZYf6NCveX4F+rAO6Yu0yLmbY5L0Nj+P1uF9?=
 =?us-ascii?Q?moc+p18gJuOuHAAvezj1aPL/zPShARWrLT32TzFsLNmGzMHLsE/mZWORLqBr?=
 =?us-ascii?Q?EtsQwqJjmEXCMIlyXuyaLDJiLVZw1KVPdUviJSucY5oZE4yqrCEy/8BEc1xM?=
 =?us-ascii?Q?8SWhrWHXEEjp6FG2Z9ibdRj0g6eV3eyweuqaGNR6unHhzJXQ5l68DnAG4Cl+?=
 =?us-ascii?Q?PlqzrQEw8TpaSsskJBjxkoB6FFu4ahdxoN/hkomH28Uw3ST+RsHkdi2QBy+q?=
 =?us-ascii?Q?8C58nK4AMs2gc7GvH3WTGuFq+aRefrI3q8CJHoiTbzEEORhYxvYK1QYDkEFf?=
 =?us-ascii?Q?9W+23JYJ/Xcg42Zlg5lDovXw6T/T1aTQ1yLlIiw7qh8BGDOfhmZG4R4DjcCa?=
 =?us-ascii?Q?j8577RUCABAUWkQKbtnQlywRAUanoPRoypNwiJHBRdRWyHC8mB5VHGkTtFFp?=
 =?us-ascii?Q?IcouHyq5N3PsOaX5HNTKND2Dp+Ixq5CfskO8Ua9tf2wStJGktE0SKy4q0noJ?=
 =?us-ascii?Q?yl7ho7vp7O9TXfKSZHptmecLkwXY538PJXZp7KQnbdqImaW03YZf8nA+stNu?=
 =?us-ascii?Q?ij2RNg96mBNwyCZwDI7pGqWaA3uc38rKhAPijd0leCfl+W8FYQqT4J2YWWXf?=
 =?us-ascii?Q?SrCgSNFixnJ/kuccFggt0X4x4LQKpseCWNFJt2KJIv01NDDFgjXRZ6IewSaN?=
 =?us-ascii?Q?x71WamPTXCPMGbRm5AWnlBWzgv+HuF9fjH4YQRentZutML0yDWrUW25gj9M1?=
 =?us-ascii?Q?tlH/MnplKv844aIsPvepFSyVuad0W+L1bgxTEw1x34sPH2d8Tp0q6XgKvsgj?=
 =?us-ascii?Q?r9T1xtJ5JE6aeFP595GluQlrSoaK1HsN+/LTNC8fZxlYDTpV225k/GFTiKQP?=
 =?us-ascii?Q?1I2iQ3Os46oLLgpkC23d3IEzUutR5lYYiZ/4WYt5WzKp0rFMVNQXjBg5/NVy?=
 =?us-ascii?Q?AHLRdpkDd2/0JuJxKXk6RCYocZ3s2x1g3c9YqupQrIX4c3obpHeu3mIbkrZO?=
 =?us-ascii?Q?kQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c52457cc-0ff3-484b-e44e-08dc0dfea8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 14:57:38.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN99gEeElhz6jPPx/5XNxSnUIvbNU4pwsTi9iU+MireJae21BBMtJWK58/YgquYnFA6x6Ph/Aix4kBKp7i5Q50UhrMobjPyww2GXJhm+09M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Friday, January 5, 2024 3:22 PM
>
>On Fri, 5 Jan 2024 13:32:00 +0000 Kubalewski, Arkadiusz wrote:
>> But one thing, there is no update to Documentation/driver-api/dpll.rst
>> Why not mention this new netlink attribute and some explanation for
>> the userspace in the non-source-code documentation?
>
>Now that we generate web docs from the specs as well:
>https://docs.kernel.org/next/networking/netlink_spec/dpll.html
>I reckon documenting in the spec may be good enough?

Yes, that makes sense. Thanks!
Arkadiusz

