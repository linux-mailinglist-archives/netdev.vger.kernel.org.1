Return-Path: <netdev+bounces-205267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B86AFDF44
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939B34E0EEE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182C26A1D9;
	Wed,  9 Jul 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVHkucZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2B1A23B9;
	Wed,  9 Jul 2025 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039142; cv=fail; b=TLsB0K+j7zYotrKdKEYNPJbcliBVaVG1J9M6ucKag7lml0QoVFtnfec3lMjG+hGjFuBJ827lBm7JcZRM/c2GTWwGYsH10c66yMFBDc/EdIPbuO3R+ZYYXvRI1PXvzzGD/OgNF9O2dsLpGtp0hE/EXASC5SJsviv8Cc0SIuePRVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039142; c=relaxed/simple;
	bh=0nKnnM6RAaVHwT2v8GFa2mgqjl1vJTzKkL/4ODz1gPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dg+ZHWd4+/a79GU7DE2l/or2vYLLuZQA3C5qzjtQ/5CXVYKxlWqoCFGQV4bH57B5MrOGgIapOdM7cNjrUnHqTvIUXfKlSjf91ot34f5n/7Ok3tTl9XFybfnLhqe0jaERM1BkQjEO2pQKtn5KywwBxzJNsNBWuJT4WUdfmEKAtQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVHkucZQ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752039140; x=1783575140;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0nKnnM6RAaVHwT2v8GFa2mgqjl1vJTzKkL/4ODz1gPE=;
  b=YVHkucZQNJmY1BHC5DacgN+ry/Ep1LmYTAOMjm2Pks0K51wpI4nw7c+L
   vKJhFxQalc6iVRWK1kPiM4zWFF9kqgJG4+DDopuXnsxPmhFshiuNkGJyN
   Ooe1/Y69ZJjT/iJ1/5yGsU+FrZC//len1GP4L2n/0G3CATMHWMUTfb9ps
   5848PWXcARlbclLvrz03dSbrvuiO+DYCh9+vYuSuGEHGUD85H2Co2m137
   ni7NO0GlcMdYUB1pgGaTnILsYrJOcqtRPbhdH3OyN5pNC3R5+4YOPIy7j
   10k8PJ04gJWz9LuqK92JtpVjbYrfE0cLR+ZEQmXZTmBjdHi+lrI8jC4yf
   g==;
X-CSE-ConnectionGUID: 2wegF7GfQz2FwP6qX2l9/Q==
X-CSE-MsgGUID: E5pfLa0iSRGgifLVE5daiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71870219"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71870219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:32:17 -0700
X-CSE-ConnectionGUID: b6ylhQRfQd2Hg22ytEO7Vw==
X-CSE-MsgGUID: navjt9fLQgKKiKElQXSXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161228281"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:32:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:32:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 22:32:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLSzqIPYGd6jBykeruPBL/qkyFLSi+VDpOwX5PmoGMDSwm2jzH4gXrd++2FDqcnFqvcAgnHfErT+FfU6k3fu0MlsFsoghH93hiIgeKKL7mTc4tluCHBZNYuq0sejy6Kf82N5LLUum3GZSeoafPa+SqChC++O1bDmWESh5G5oDPLfYM+qZtMuGPscHeAGM8084kni4HPA5echNVWrHxNnzPYFP/RZOkoI9tdQtMyYjToBpE4g2QPsSJMh/yBYEsIkJH23WeanznuV7PcBfRxeQYSZhwrrBmhMGR10R/0CdMGtcfhpojTda8dfO98/6AILWkoLfFFnyux+Z5TCOySHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nKnnM6RAaVHwT2v8GFa2mgqjl1vJTzKkL/4ODz1gPE=;
 b=DTvHUk0yISksnPLBtdSP8dKunH30QUWhNQoG8QMNB7a4hQUtVFwsFQGb7eZcxFQJ1eb2+1GdOO6QKQVmUumDaWbE10Q6EGddrLpgcuMhRp11eYAO1nL1NAjhW+mMe41ePRPLj1qpYWBZMBAB0R5ndvEOtLWInf5UFCkcbgOGARkX8UM3dcNTVvYAtAn9Ys3O+LKoriMFHqixDtPZ/7cYLybJ1Tcudmn/S3b0T3dPVrqgAZdENtZ0ffmvDpYfc8EuKrJQq5qGYUvxd2yY4OT6vtPshL0kLIU2KBLSwJ9Xq7EuVHztuSXCAHcVdCs4pqrFuJodB7a1ZMcicNQw5hLDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 05:31:51 +0000
Received: from PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f]) by PH7PR11MB8455.namprd11.prod.outlook.com
 ([fe80::e4c5:6a15:8e35:634f%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:31:51 +0000
From: "Miao, Jun" <jun.miao@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "kuba@kernel.org" <kuba@kernel.org>, "oneukum@suse.com"
	<oneukum@suse.com>, "qiang.zhang@linux.dev" <qiang.zhang@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: enable the work after stop usbnet by ip down/up
Thread-Topic: [PATCH] net: usb: enable the work after stop usbnet by ip
 down/up
Thread-Index: AQHb7+COXwHbePW5CkaRm1w9S2eLSrQpN+YAgAANMxA=
Date: Wed, 9 Jul 2025 05:31:51 +0000
Message-ID: <PH7PR11MB84555DDEF7FA8EBC6651AA649A49A@PH7PR11MB8455.namprd11.prod.outlook.com>
References: <20250708081653.307815-1-jun.miao@intel.com>
 <aG3zIMg_z2CpnG70@pengutronix.de>
In-Reply-To: <aG3zIMg_z2CpnG70@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8455:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: 16d80416-80b5-414a-c4d2-08ddbea9e856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dU5aTkhuZjNxdkhVYkdBb3UwNzBZMXdCYnlMYk5TSlBCY0daSDBaUDgvYndQ?=
 =?utf-8?B?WFYwNjdTa1dEajd1UjNBUEgrVHFndFVyZzY2MS9lbkVMZXhhRWZwaGs5djUv?=
 =?utf-8?B?VnN3QUhqLzdnZjV6T2g4cTV2aGN5anRJSTdDK0xwUHcreVFDTzdSQ3lkdC9z?=
 =?utf-8?B?NUdnRDlhTWVhbC8wTGJQRmNnUFptSDZtb3Qzc3FyYmQ5VjZJSitta3BSak1a?=
 =?utf-8?B?YXZhcGQyYVBzZk04TmxKN0ZNMmtMTlNHK0sxb01lOGVnSko3SUszTnREemd2?=
 =?utf-8?B?djRoN0tLQmVXYk96OFUvT0M1cHk4S1pFZVQwQWlvUVNQTWxOMWMwQlBFaENN?=
 =?utf-8?B?SjYvOWF6RExJQUtWc1lNL3AxSTJZcVZvRTlJYXJ4SU4rREl1VlRtYmVlWUNz?=
 =?utf-8?B?aXZoMFgwYkVUdVZnOWFKZkttSUg5V2F2NXl6MktuMklXenh5YzVrRHZHRlBo?=
 =?utf-8?B?MGVyN282VU10N1FFRE1DV1FDM0FwYkhld0M1RlJtNCt5bTFyOE1IVDFLb0FC?=
 =?utf-8?B?Z0EzNlJPV3AxUldtdnAycFNwU2tQZ2k3VWcrL3NQS2xKTkNDVzl2Y2w0bktI?=
 =?utf-8?B?dGxRcEVIR2ZvcG9WYVliQU5lZVZNb2xNV1Q0UzRjZU1KbVc3Q04xUk9mbDh1?=
 =?utf-8?B?Vm1LTUVPZm1TTkFQUlVUM1prRjBBVzJ4ajRBWjNRaE9sNEdYdytKdDJqT0FR?=
 =?utf-8?B?Q3JTcFZYYW1nbEZzbG4vdjEveVdkeVc2NDJlVnI1bzBsaEZNV0tadzhFUFpt?=
 =?utf-8?B?VjFtT1RZd25CUXNJSnhxRTFnVno4VWxPV3R2TDY0V1dlOE03TUxWM2RUTmt6?=
 =?utf-8?B?UUxqbHBZOUh5dVRocEs4WHNmT3BmdkIzQlZ6L1RxRTREQlN3YmhnVmhhZ1Ja?=
 =?utf-8?B?a2UzUW0rNjNXdFIzSFU1VFIyOHZ1MkRZa3NQSi9pWHAyRWxpS2xOUytzcUtz?=
 =?utf-8?B?Tlp5cWs1YWhvNlQ1YlFmSUYyQVRGbDFXeDZlU3Zmemt1RjZxV043bHZPZlBX?=
 =?utf-8?B?Snk2QkVKaFNGdDdlMm8rd2loMExyckxZMHg1VHFZVllJV1ZUazlHT2RUY1Vq?=
 =?utf-8?B?UktNV0g2N3g1TTJidUhkdVljM25maENiZkxKdWdqRWJ4U3k5YlJXbTZvUnF0?=
 =?utf-8?B?RExzOG1hV0RnS3g4TldXcjJBRVExekNaVm1sRUtMYmRIQkVId2RKM1dvM21v?=
 =?utf-8?B?eFdqakFsdmdRaWI5eTNrR3JwY0ZpenNFeG9uZjVGWWEybEk3REpxL1hlOWll?=
 =?utf-8?B?NnRZYzBxSnlReERXMUtLQS82K3hXMjZYMTJCRFo3VHZzaHYwSm5lQ2xsNzRE?=
 =?utf-8?B?WkhTWkRveEdrOEt1T245ekF1cFN0K1dSZVNKRnh5WjRKd0VDQUI0MkRjZ3Zt?=
 =?utf-8?B?UEtvaTM0YzNodUZlTEFCczZraXVac2NzeEhWNXZMTEhmb3pUZk54cFl4WG0v?=
 =?utf-8?B?VTNoL0FSWnlvNnNnS3hJQ3prQjc4NjZqSVNsYWR4ZXVlbUhlZjdoeE1vOGJu?=
 =?utf-8?B?SHJMV0tiZ2J6M1N1SHhTUVp4L1prdm9reS9ZU2JYSzhnVVdkK0d4TlJVMGpE?=
 =?utf-8?B?TUo5aEgxaHowU2JQTVo1bHQvNFBDZ0NVTGl5QnE5YWRCdEc0d2RaRzRnTUJZ?=
 =?utf-8?B?cEg3TnZhYU15UTVYWWIrR0FGdHJtOUM4aEJzQTBkNmZHTFlQbWtBbWh4aHBX?=
 =?utf-8?B?dFFDWnZTSTNUUEtPZU9SV3ZxT1AwY2ZGczhXNVJ2WG5scWluR2VOa3JySEts?=
 =?utf-8?B?WnBlVXE0ekpHNTg0cWMyc0VCcjZmbnd6bzZyWWdLTjZlMEc0a3ByMXBtVWNp?=
 =?utf-8?B?WE0rQUxrYkFrQ1VXc0F3M0l5L0QwMmVXZnB2dVVSd1lGUFpSMTRxSXJ4MURC?=
 =?utf-8?B?S3Y3Mk1pSGIwUTdEOWpzemNQbXpGMmsvb3lyWXdsZXVFMm1Fd2p5dmw2cVox?=
 =?utf-8?Q?pi6Sl+isPac=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8455.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUtWRnJrZTZCam1TUnFZaHdnbzk5Wit1ZGprVlJnYmw0ajNTVWk5ZWpoekxy?=
 =?utf-8?B?YmRQQ24zTUxOQmVjcWJLZCtaVUtwWlQ0S3dOZ3V3b0Jzd1VKb3pvRVhTQ2cv?=
 =?utf-8?B?ZXBJWk8zMXZza3NucWlScXM4c0VHNnpUU0JMYXFsTWlMMld1bkQvb01nMkpu?=
 =?utf-8?B?d0dMZHh1VnIrUEY3U2lYb1ZnRkswT2pTWHJEbm9rSzNjcy9XNjB0YzVhN1NE?=
 =?utf-8?B?MDIrWnNyVTJvRHZ2d0hzQkpqMVFSZGQxNWxJdXhBWU0xbFE1OGN1NFZZODE2?=
 =?utf-8?B?REVkbjhOcEprSWtmZ2lRY3pya2Y0Ykw1RTQzTXhGdGVVOThRbmFFQjBjaUR3?=
 =?utf-8?B?S1Y4Q2lxVSt1NFI2Z1pTUGZHQWFhTVE0cnBKaEZpUHNCWUg0SGl4MmNYWnAz?=
 =?utf-8?B?MUZBa3E5aXpwMVhuZXlUSTJNQnBsMWRFNVkxUm5rSnNDZ0c1WTRtbTgzNmtI?=
 =?utf-8?B?aDVDOW1nVlZiVHVnempGOXhKTy9scDBLWE9Vd0JUYmYrVUk2TC9YSW5BakEx?=
 =?utf-8?B?UFVPejZ0NE9UQjZvVXBkVThBNXRwWGhsVk54SXovVEsvbVg3ZnBGZ1BQV2JT?=
 =?utf-8?B?TkZGWU9yNUJxSHE3MHZwYkNyZmtySER6ODF1NlpvSGsvQnZld2dFN25ZSXd3?=
 =?utf-8?B?b3RXRktjdUFBc1N1WDAvNTUzVHY3VlVWdU80UTNxSGd3SmpWMGZtVGMxeVRu?=
 =?utf-8?B?R25XbFc4VmhUdXdMRlRKalFtMUpzZEdnQk5ucVFKK0FqV1g5L1BlWlBBZmZz?=
 =?utf-8?B?QjVrTnFwNGszbXdLbDlIbnZXY0x6QkgxR2tTS2FvR0FEMDFQejN2VTlyOWxL?=
 =?utf-8?B?L3ladG52ZGNPQUw5SXFqSmdhZHptSGg2dkRsUkpjOWNkR0FTVlJlMGlqRThR?=
 =?utf-8?B?TUVVL2F5MDJNTFVBRzZuSXBRb0hUYTBRQUdzT3JhSC9jZUZsVWZXOTE4cU9t?=
 =?utf-8?B?b3RJdjJFZ1dtMit2cUJXUEh4RXpSaHhpYjliVHpud2VLM3FlWElZNUxYbTJt?=
 =?utf-8?B?eVUyV0xUenBzUFFheWROdVRFemR2aWgwaCtUQXF1QkhzV1hhUmFNV2pVYUow?=
 =?utf-8?B?R09kR3ZQQUFDLzBqeTJZTkY0b1RnRk81QmxOQ0xjYS83N0pLeWhyWVVWT1lK?=
 =?utf-8?B?VHVKVk1ZdDkyUkFTYkhYQWlPZ0pWNmIwcG5pUXpOWnBHbHhkZG1MeFlzdjJr?=
 =?utf-8?B?UzZVNTViRlRMNHcvdEsxV1VOdTd1MHduQ0ZUa1RKNFF4anliNXoxbllzNUlV?=
 =?utf-8?B?MTJtN0pnSnZGL2t1VCt3K0NOdTJPL0lPNmtnV1hZQzBWQW9Nc0ZQcml0Z0hX?=
 =?utf-8?B?SEZPWU9abytDMHBheVAwVWVyS0pTckZlSFYzT3pJbVY3b2hJemNuZXpOTFFL?=
 =?utf-8?B?amdyYnpYWUR2ZHNad3p4RmlDZUdxdlZlbXVBckVMUmlHSkgzc0dwYkFLZUdC?=
 =?utf-8?B?SE5ySnRGcVppZjlxdnlCSTlOd3JkQU5XVHp0cEYyOXI4SEdiYUYxdVRyYVdE?=
 =?utf-8?B?Sm9MblhJbW9jdDF1Qk5ncERHN2Z3YkxBOHZsWi92dmIrejRoeXBNdFFVbFIy?=
 =?utf-8?B?SEFLdkJVbVBRZU41cHI2Slc4UnhDR1ZzaThFTzc4RzVXNG9YbVVUMWdBYzVJ?=
 =?utf-8?B?NHJESWZVYjh6ZlovMWUrTmZ0cFl4Yzl5UnE1T0lucTVLb2JMV0cxY1k2UzF0?=
 =?utf-8?B?UFM3YWhwcWZESmJ3QVVwVHU3NVUzL3l6RVJKb3NMNEp6aElqcW1OUGNyc1FP?=
 =?utf-8?B?VXFFSm5vcTBYSkVQV3NYeXpjRTRGWDRGZmNvTUtMWTVja1ZjYWovM0F0Y3NL?=
 =?utf-8?B?b0gxRk1ZWFpZNzJCUG9jdmJtYU52MlBaRVF2YWltZ0xWNkxBTmRwSnUvLzdY?=
 =?utf-8?B?YnQ2NzQrUXh1MkFvYVZJRlFGRDd5MjVnT3h1N1VrTUhwOVZpcmd1WkZEV0hQ?=
 =?utf-8?B?NWpIZWUyRjBNbnlid05HS1piVTNadjI0Y2dYSzBKNnJVM3Fia0REaEpMOXJF?=
 =?utf-8?B?VlZMNnVjeHJmTjlHNkV3VUp2dUhqMXd6TWFibUk1RW03Ti9vSjZJY3d0Zkgv?=
 =?utf-8?B?UmpaNG8remphV2RVTGY1S2pZSW1CbmMxcXl6MjR2K2JoOWtoWS8waTZIWjFL?=
 =?utf-8?Q?oFYPKW8El3rHWyoAK3yS/uZyJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8455.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d80416-80b5-414a-c4d2-08ddbea9e856
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:31:51.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmR0ABHV2v364AXn97QSqmVSpkEHubycc1WMz/Sp9Sjlf9zaI9Z/c/KxED953Xh5bz9levEZMnYieNvkOabyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

Pg0KPkhpIEp1biwNCj4NCj5wbGVhc2UgcmVzZW5kIHRoaXMgcGF0Y2ggd2l0aCB0aGUgbmFtZSBb
UEFUQ0ggbmV0LW5leHRdIGFuZCBhZGQgYWxsIHJlbGF0ZWQNCj5wZW9wbGUgc3VnZ2VzdGVkIGJ5
IHNjcmlwdHMvZ2V0X21haW50YWluZXIucGwuDQo+DQpPaywgSSB3aWxsIHJlc2VuZCBhZ2Fpbi4N
CklmIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBmb3IgcGF0Y2ggY29tbWl0cywgcGxlYXNlIHRl
bGwgbWUgPw0KDQpUaGFua3MgDQpKdW4uTWlhbw0KDQoNCg0KPi4vc2NyaXB0cy9nZXRfbWFpbnRh
aW5lci5wbCBkcml2ZXJzL25ldC91c2IvdXNibmV0LmMgT2xpdmVyIE5ldWt1bQ0KPjxvbmV1a3Vt
QHN1c2UuY29tPiAobWFpbnRhaW5lcjpVU0IgIlVTQk5FVCIgRFJJVkVSIEZSQU1FV09SSykNCj5B
bmRyZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPiAobWFpbnRhaW5lcjpORVRXT1JLSU5H
IERSSVZFUlMpDQo+IkRhdmlkIFMuIE1pbGxlciIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+IChtYWlu
dGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCj5FcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2ds
ZS5jb20+IChtYWludGFpbmVyOk5FVFdPUktJTkcgRFJJVkVSUykNCj5KYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPiAobWFpbnRhaW5lcjpORVRXT1JLSU5HIERSSVZFUlMpIFBhb2xvDQo+
QWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpORVRXT1JLSU5HIERSSVZFUlMp
DQo+bmV0ZGV2QHZnZXIua2VybmVsLm9yZyAob3BlbiBsaXN0OlVTQiAiVVNCTkVUIiBEUklWRVIg
RlJBTUVXT1JLKSBsaW51eC0NCj51c2JAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6VVNCIE5F
VFdPUktJTkcgRFJJVkVSUykgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZyAob3BlbiBs
aXN0KQ0KPg0KPkJlc3QgUmVnYXJkcywNCj5PbGVrc2lqDQo+DQo+T24gVHVlLCBKdWwgMDgsIDIw
MjUgYXQgMDQ6MTY6NTNQTSArMDgwMCwgSnVuIE1pYW8gd3JvdGU6DQo+PiBGcm9tOiBacWlhbmcg
PHFpYW5nLnpoYW5nQGxpbnV4LmRldj4NCj4+DQo+PiBPbGVrc2lqIHJlcG9ydGVkIHRoYXQ6DQo+
PiBUaGUgc21zYzk1eHggZHJpdmVyIGZhaWxzIGFmdGVyIG9uZSBkb3duL3VwIGN5Y2xlLCBsaWtl
IHRoaXM6DQo+PiAgJCBubWNsaSBkZXZpY2Ugc2V0IGVudTF1MSBtYW5hZ2VkIG5vDQo+PiAgJCBw
IGEgYSAxMC4xMC4xMC4xLzI0IGRldiBlbnUxdTENCj4+ICAkIHBpbmcgLWMgNCAxMC4xMC4xMC4z
DQo+PiAgJCBpcCBsIHMgZGV2IGVudTF1MSBkb3duDQo+PiAgJCBpcCBsIHMgZGV2IGVudTF1MSB1
cA0KPj4gICQgcGluZyAtYyA0IDEwLjEwLjEwLjMNCj4+IFRoZSBzZWNvbmQgcGluZyBkb2VzIG5v
dCByZWFjaCB0aGUgaG9zdC4gTmV0d29ya2luZyBhbHNvIGZhaWxzIG9uIG90aGVyDQo+aW50ZXJm
YWNlcy4NCj4+DQo+PiBFbmFibGUgdGhlIHdvcmsgYnkgcmVwbGFjaW5nIHRoZSBkaXNhYmxlX3dv
cmtfc3luYygpIHdpdGgNCj5jYW5jZWxfd29ya19zeW5jKCkuDQo+Pg0KPj4gW0p1biBNaWFvOiBj
b21wbGV0ZWx5IHdyaXRlIHRoZSBjb21taXQgY2hhbmdlbG9nXQ0KPj4NCj4+IEZpeGVzOiAyYzA0
ZDI3OWU4NTcgKCJuZXQ6IHVzYjogQ29udmVydCB0YXNrbGV0IEFQSSB0byBuZXcgYm90dG9tIGhh
bGYNCj4+IHdvcmtxdWV1ZSBtZWNoYW5pc20iKQ0KPj4gUmVwb3J0ZWQtYnk6IE9sZWtzaWogUmVt
cGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4+IFRlc3RlZC1ieTogT2xla3NpaiBSZW1w
ZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KPj4gU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxx
aWFuZy56aGFuZ0BsaW51eC5kZXY+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdW4gTWlhbyA8anVuLm1p
YW9AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jIHwgNCAr
Ky0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jIGIvZHJpdmVycy9u
ZXQvdXNiL3VzYm5ldC5jIGluZGV4DQo+PiA5NTY0NDc4YTc5Y2MuLjZhM2NjYTEwNGFmOSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYw0KPj4gKysrIGIvZHJpdmVycy9u
ZXQvdXNiL3VzYm5ldC5jDQo+PiBAQCAtODYxLDE0ICs4NjEsMTQgQEAgaW50IHVzYm5ldF9zdG9w
IChzdHJ1Y3QgbmV0X2RldmljZSAqbmV0KQ0KPj4gIAkvKiBkZWZlcnJlZCB3b3JrICh0aW1lciwg
c29mdGlycSwgdGFzaykgbXVzdCBhbHNvIHN0b3AgKi8NCj4+ICAJZGV2LT5mbGFncyA9IDA7DQo+
PiAgCXRpbWVyX2RlbGV0ZV9zeW5jKCZkZXYtPmRlbGF5KTsNCj4+IC0JZGlzYWJsZV93b3JrX3N5
bmMoJmRldi0+Ymhfd29yayk7DQo+PiArCWNhbmNlbF93b3JrX3N5bmMoJmRldi0+Ymhfd29yayk7
DQo+PiAgCWNhbmNlbF93b3JrX3N5bmMoJmRldi0+a2V2ZW50KTsNCj4+DQo+PiAgCS8qIFdlIGhh
dmUgY3ljbGljIGRlcGVuZGVuY2llcy4gVGhvc2UgY2FsbHMgYXJlIG5lZWRlZA0KPj4gIAkgKiB0
byBicmVhayBhIGN5Y2xlLiBXZSBjYW5ub3QgZmFsbCBpbnRvIHRoZSBnYXBzIGJlY2F1c2UNCj4+
ICAJICogd2UgaGF2ZSBhIGZsYWcNCj4+ICAJICovDQo+PiAtCWRpc2FibGVfd29ya19zeW5jKCZk
ZXYtPmJoX3dvcmspOw0KPj4gKwljYW5jZWxfd29ya19zeW5jKCZkZXYtPmJoX3dvcmspOw0KPj4g
IAl0aW1lcl9kZWxldGVfc3luYygmZGV2LT5kZWxheSk7DQo+PiAgCWNhbmNlbF93b3JrX3N5bmMo
JmRldi0+a2V2ZW50KTsNCj4+DQo+PiAtLQ0KPj4gMi4zMi4wDQo+Pg0KPj4NCj4NCj4tLQ0KPlBl
bmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8DQo+U3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAg
ICAgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZS8gIHwNCj4zMTEzNyBIaWxkZXNoZWltLCBH
ZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTAgICAgfA0K
PkFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZheDogICArNDkt
NTEyMS0yMDY5MTctNTU1NSB8DQo=

