Return-Path: <netdev+bounces-106360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493EE915FA3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85201F21F03
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F2514A4E1;
	Tue, 25 Jun 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFKcptBU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32D1494C5
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299299; cv=fail; b=QElVruMKQwnu6jVXNG8rDSsAW0EfwqK0uUU/nNVitFK9xvn3hLtM+OY8akMkH2lMlPKl6z/du24fV5N3jeDmmdAFVxJbK+KVGu/ruOF0BJ2frNHROHBJWNRpbfxZO+/IQpmUrAYy0gMFlBQBKDiTTee/RoJ8aDp2zbexEHkT0NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299299; c=relaxed/simple;
	bh=5HVaTYUNj7lONqR48hpjtSf55m21D+4BHagBAZpTjWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tN99IXZ6GEpnMu0NyWje/ezG1Zp7a0hXrAmHZxnKQTe8SGXh383XVowgDVaPQdItPbRk4PjVvXY0M0hKAMF0nu28PeNEV67ZlAvRZVvmyQBxUZhK2SWoxZBsb3YJEMqjiXR8MMc4EcvSJXQgrDf7lB0UVu/sFOTQ/1jChzZfkLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFKcptBU; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719299298; x=1750835298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5HVaTYUNj7lONqR48hpjtSf55m21D+4BHagBAZpTjWk=;
  b=bFKcptBUWtHwgBDoecKnUsivEXSXbCh7IwE+hG8Tga3LXGJfdeHzVV99
   DHbKDVlND2PJW16jYhT+WNvxhgLdyTJHgaws2ylXB8KdtEWhRPms72pll
   41AsqE84UOcHbDSUi/KhoC6fGXsWpApSOHJcKPSLwIsQkv7DJutYNdMOR
   d/RSODHoPPsY6PdXULLh0UmR0U61GjHyDh8MAv9m9A8iFVUdg9fgp1hH/
   mcL7Ik0AfJolg46DCbhxSNcyg86CGrTnpQvsIsrFRLWq5VnVSTsiJ/y1v
   bIfdAsVJyQ5HejVysZM35NHIgLx69H4Sizt3wLaUQAbSbPnvpX5DhZsAt
   g==;
X-CSE-ConnectionGUID: aaoeNAp+TjKSOF8E7ZrDog==
X-CSE-MsgGUID: 9FkY08sXSWeUgcbpccWweA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20177258"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20177258"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 00:08:16 -0700
X-CSE-ConnectionGUID: MdVNWDxMQa6b31m+ejEygg==
X-CSE-MsgGUID: Pm0bWVQrQtOlDZbB1J2b8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43537481"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 00:08:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 00:08:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 00:08:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 00:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBemFrPbk+4gRcEECm0LmuloJsrR5xuhsPmAL4WZIclRkXz25Dtl2bkoxRL055ibDjNCnrDc7qEd5XvpeBcKeoYhGmaTTrGS6rMZDud0x/fgnVJtBe4tbSh23NeDUJstR0QbqaHJXUgVWo7d+dse/sbtX0UxFUVhcXEtlJ/1EAVCcFbHoVfeBsQB4lMrBqo1R/x/0k1DZUwLwJ/qE20fBW3p4DzKnqlMwoi3LsiE2yX7+cPcSCdWH5V5bChhtZqW71yrBiRT5sLq1OkaiheFFfpwHSN/o6k1mceqLpxP+RWQtRxxznsUs/E80zsqW5T3Ha9Y0FLSTcWYm1nlYNrzVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UctCKYbdCjXneW2oNnPxWbDLzvhbCxnehvh2VLLHOgk=;
 b=DsrpzhlQE+T7hb0crsimmi511+jBvjjWB82luZkeW6DvbNsp6FIDcLYOUTFw+7Vgh34UoGrXkNSZHtMNyNilZi7ns/HxJt5nl5v3u2tSkTlxqD8C/IjG2IYuIWbqVd0lohRGoQ06JXgCmCEksRNpwXBSHmFfc/DXv+PJnUjWnA+kM/JkwYRh7CAfyz0/4sr6EPn1W/wNayftnbchPTjzPjfRXBbg2MSIe9nTi2ZStwS4yRDw6dbHAqoeR6ohJLVRMMX0+jM/vPpf1YKa2RQ60crF53tnULU8d/05jNp6nLGVYaaY0tpC7g8nSIJAXFAgk4S0vN+00QqtwU9D+acatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by LV3PR11MB8482.namprd11.prod.outlook.com (2603:10b6:408:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 07:08:08 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:08:08 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v2 iwl-net 3/3] ice: Reject pin requests
 with unsupported flags
Thread-Topic: [Intel-wired-lan] [PATCH v2 iwl-net 3/3] ice: Reject pin
 requests with unsupported flags
Thread-Index: AQHaww3zekHYv6pLokSdyQKyErvmMrHYCkiw
Date: Tue, 25 Jun 2024 07:08:08 +0000
Message-ID: <CYYPR11MB842940B278050637DD27B892BDD52@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240620123141.1582255-1-karol.kolacinski@intel.com>
 <20240620123141.1582255-4-karol.kolacinski@intel.com>
In-Reply-To: <20240620123141.1582255-4-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|LV3PR11MB8482:EE_
x-ms-office365-filtering-correlation-id: fc68584c-fd5a-4628-06e4-08dc94e59157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?/wzi/ZHezTT8x7ONeCCIuesI1OdW8OsRBWzT2wVpNTVhheoOJ2aRRLgCoAwU?=
 =?us-ascii?Q?HYM0LfJGFvWSnIQ630tsQajVTUBHJiZeLgFZX/OAXAnslVn0g/OcS/obVGvI?=
 =?us-ascii?Q?Vn09RUREafFlnfRv5DNXlRvpFJW2pyESLFcdCZU2gF2CgCW3LU27+lCQjTnf?=
 =?us-ascii?Q?YhQyo2CritDBuarpWYXNXxADycQ3HTIO5bXPVHEwHWji2hko5ibU7/OZUmJS?=
 =?us-ascii?Q?4gHmnJwQByFRC1RA5l/hZ3McknieeeuQ2StyJ7qf46TAMo6Oz+yO2fNWIj0C?=
 =?us-ascii?Q?UzR6rwdTK3C+XhLdrgPb51tzpSfEntHRJP+g6xERL/SsJbuuuCdJxEzc93ox?=
 =?us-ascii?Q?1Ef11ewUpq92Z7bl+8LNvh/J18ceV/5ln77fk9j53ap7uOe480BhPfI6tqr7?=
 =?us-ascii?Q?0LEpnYEAf9CqmdcRaLHAZwPVolalgYLH+5e6jxDVJb2EnNWjavIdAWhxrxep?=
 =?us-ascii?Q?UWy54hRN+xXyz6I+LTLJUynqWS3uzhi+eQaOpHIH2bWkgxCTjfWRWzKMyqxu?=
 =?us-ascii?Q?KqLrnq2+Jz+agU3y5f0EPw2tFMXR6TU4akBfdONH9bHq9HKf15yLk7QKnCS7?=
 =?us-ascii?Q?8RynYH19jzKesZwH+H+5YzfZ75YXJYCF3kqc07U7ai39+2q+tq+1GsAEp92G?=
 =?us-ascii?Q?7sUgFu1IE9/YUFgmU8gdoSVFFSW+Z9ePcCB2wMY+vSSMk6qxnWB5XuJgBYcQ?=
 =?us-ascii?Q?91OYVphEZ2xq30rjFHzhQQeplazZH6HJFpOzMt2wIMhwZGlIRqLimByMkz63?=
 =?us-ascii?Q?XeS+LnZ3Yi7glKJcdV1VAxnHX7zyrZlVz7P9mTQPlYkoBnO2uDusd3mXWEfx?=
 =?us-ascii?Q?Z4sYAhvxHC1D3rZ/H0OKAcW37Jl04OLUW9+QNIaQfFhgk/5B/Q+fhULYVczX?=
 =?us-ascii?Q?vsGdl5P0a2XvM5jalhZC6Lon5lYDoiB1J5Psf9d2cDg2GiFYqtEhGmyoClCD?=
 =?us-ascii?Q?/AVZNP2VAx4NikPdr4sL32P+4I/6owDzs5EHpYdzkI+5nTi/8GfC38BUC/8l?=
 =?us-ascii?Q?BBPL9erzjMHUlpDl4hFiUVLxbT76dTO1VE9gYsap/koqObR5aEXBW8aLyBPN?=
 =?us-ascii?Q?R+Dia+g1TvUnNNTdOAsxkbjKYGSRo1UTsRNf10R+nRp+2Lclv2Bj+DdMhgWV?=
 =?us-ascii?Q?RVuT95gQBOuI2S0WFrZdDJefClZoM070R0PcMczqYzEKK9JdkSzk/HmZ/7GN?=
 =?us-ascii?Q?/XCCMt9xFNp9cmT4FizKkKSfFi4Y7U8UlTLlnOf4me4H+QRKQd+9YYqbWJDq?=
 =?us-ascii?Q?TQM0LzIJ2gSpEyQ9j7gZag1ZCAFYVeXe/KrdhQWh29V6HUk/GboSa0wG0a1X?=
 =?us-ascii?Q?vGUziXCyxb++PIzAEe3i55kgXwFuxX2spRflQqlp/CQxhAjZ5T/kFwYRaqZF?=
 =?us-ascii?Q?+KeNBy4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LaTJahkrRSX2Jw+Sf5zlWet9FHl5vZWqwuS6PxoMJYxZM7xr1kUYquYyCnew?=
 =?us-ascii?Q?pk1lrnYnm7I19iEDrU358nywPhImHECfvBwBRGBPRtirTD+Z22qctwP4w2mO?=
 =?us-ascii?Q?E2fjq7LTxJRMlRUxEhnBrobO7sA3v2WonO9TbS1gRdG208FNcf5vCKTOdp0O?=
 =?us-ascii?Q?NbxJQm9qLu93sWhoHkfP0cZHKzLI0hQJID8Laji4YEfhvUNIHv1dPhuN/kaF?=
 =?us-ascii?Q?HGnPa+mQ7QsYllf4R7PMqgJPZ9mqgp5zhLA9HdF9SG0We52xQSP65R4yOHny?=
 =?us-ascii?Q?Gpc9Az75BAbqDxZHcXZQrM8eybR53l6v3IPW7X4gqmLstM8G96cx6EasFl9M?=
 =?us-ascii?Q?tMuaAsD/LmrmGVad6fOqj5+NHYFNu7P3efT7EeaKGEsIsYTjAo7klmuI/FSf?=
 =?us-ascii?Q?0AvTmQWQsCLH7vuZodBnNuTX1ZDVffOovecQZh9gwX2h9LUd8p2K+VPC51XZ?=
 =?us-ascii?Q?/5FQY1wyVRmBDl6QlbDNyH6eJzmxz3RiN0HX/JSYHbtp6yv/bYK/DTUrbLYk?=
 =?us-ascii?Q?iI/qwgOU1KjmCXWbEW5qCQhWnY91Z7PX5X4PxbddxdiS1uCX+hQ1qn+FBiEO?=
 =?us-ascii?Q?yAjHQ+eWBIUpXA2pTwx5MjcMP1BnlEVMrs3e+5gesAG4Oxf0vyAHJzLOD/lD?=
 =?us-ascii?Q?0Fan9IXdOkSi5ZzCdFI9/5sKRkXUj2QYD/qB2BrW7Gt8SRsgvdFJOLVxM261?=
 =?us-ascii?Q?KzZlH7Bn1npnTGn1veb5ePHg0g1NDmh/HIyrPAdubMVll7Lnb0NXmz2dkicE?=
 =?us-ascii?Q?enI0eAz4jmn0LLtL0NK7Gl0S+xyl+0JVJt6e/9eyh8a5TXsSsk56sGjRwVIL?=
 =?us-ascii?Q?XmGd5Cov5OYR4pzPxGjDBugTgS+MvHlbZW5evqFibVKWqXabV/ngZJ9FpT1Z?=
 =?us-ascii?Q?A+bU03WytbeT/kOD7gRm+IDbuviQSBwvxsXxitNnAp3NoT5l7RDY10mumBwR?=
 =?us-ascii?Q?jXgL6GEgOyhXC3QRwPcmJQiyAiPNN5qbT0xyEayK85W3W+2hTagzkWNe9bB4?=
 =?us-ascii?Q?k/sNldRo/5FB/l0rv0FwtzdE5BBbed1SNgKLOVlwrNS505VjlfkN7y3tD2M4?=
 =?us-ascii?Q?Y3EPR8EtfA9/DVu/r9+OEGU+zW3gpzqhuFsrqrZGdoCJodj6F4/iIj3mkB/5?=
 =?us-ascii?Q?IQMQL7sJkDlJsUeJ23vcCLQGZDv+Y1DpkNJpB4hVSO2TFowrx/n5WT5PPI9y?=
 =?us-ascii?Q?m0j4V/2f2lk4cwkKKQ12jH5g8MMKoqf8i5SpxsE4MtKsUc8TDXOFiAodtqqx?=
 =?us-ascii?Q?vr1FJ0nDJlBFcGcOwIReJI7tK+2NkjUArgmHnlwmc4Qpav+LNWh0KtD++6Gq?=
 =?us-ascii?Q?hEzUbeUmrIF93xTxjGkPtIxtfBQmTFakI46vGS6AjcRiG1Rm3F4ZGChbctw+?=
 =?us-ascii?Q?u3RsbtbddV6PaAS8b4931Pp47qBgYDJkA+nsPDvIAcNdDKHWkCs35rtsGRO3?=
 =?us-ascii?Q?BTEG+fP0UM3NS1lXA0ajUY/g4vVtTAgCPdZz+tiZtwetaB7J+zWsj61j3yng?=
 =?us-ascii?Q?bscefpysqtjn8YIDUzZTGheHFna02ta+NSw6DE4ADnNoHmYeIsBHTY18WuB7?=
 =?us-ascii?Q?uCMyBrVZbj2WzvG9BcpuJYmx6CYVBUYU6EITbE1/uQ4w13S03GxY9JdpO9gq?=
 =?us-ascii?Q?6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc68584c-fd5a-4628-06e4-08dc94e59157
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 07:08:08.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rA/VmMWWPYH2UfI6/6P6z/QDvDaYH+aSUIF0wpNw/BmMwG9HD8iqxC6kXHQt9vuCuDGYMJsIRLmFvHKRLlWPAGziUXec5iOCzmS+DUjTQ1Cy+lav4tsLYGyMsStM4YeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8482
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Thursday, June 20, 2024 5:57 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 iwl-net 3/3] ice: Reject pin request=
s with unsupported flags
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> The driver receives requests for configuring pins via the .enable callbac=
k of the PTP clock object. These requests come into the driver with flags w=
hich modify the requested behavior from userspace. Current implementation i=
n ice does not reject flags that it doesn't support.
> This causes the driver to incorrectly apply requests with such flags as P=
TP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it is n=
ot yet aware of.
>
> Fix this by properly validating flags in both ice_ptp_cfg_perout and ice_=
ptp_cfg_extts. Ensure that we check by bit-wise negating supported flags ra=
ther than just checking and rejecting known un-supported flags.
> This is preferable, as it ensures better compatibility with future kernel=
s.
>
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V1 -> V2: adjusted indentation and added NULL config pointer check
>
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 38 ++++++++++++++----------  =
drivers/net/ethernet/intel/ice/ice_ptp.h |  1 +
>  2 files changed, 23 insertions(+), 16 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


