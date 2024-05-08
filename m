Return-Path: <netdev+bounces-94512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836AB8BFBB5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6AB51C215AB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3A081ABF;
	Wed,  8 May 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVFBvdB+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281A81752;
	Wed,  8 May 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167025; cv=fail; b=Lt98CmoVA+AyQKQpOQYDaOowB3NhdONnZdVVfYSvi52rv/iRrR5XBjlfTI/1Y2fzRU61Y0WBtfIrMLXtGMIe+JzinW/uL/54GaldbAPrkEoZT7ZbdqqEKA6IyAKtCWhZvy9cehZ12rRU6m+D6Nh784lfvxGO197GntUYHT6LfjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167025; c=relaxed/simple;
	bh=DAEkG+4bk7P1A0LQd6h+mWlg1rAokGwqb7E5Sf3JPAg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KMKhEpjECQZzzAiaDWblNV+p3ccndYHlx/jchIMkH0hRFBRrjfoqJHz+vxF6hJYL1f2RSGZrz9aunHiusOPjQEBaROroZDtGVHHOoREOM6c68iO43zcbb+0gjbKZtxEBdrwMVVeMmU7H1ylZht0BxD07elmIkSvvlEP+4fp4u34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVFBvdB+; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715167024; x=1746703024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DAEkG+4bk7P1A0LQd6h+mWlg1rAokGwqb7E5Sf3JPAg=;
  b=iVFBvdB+ExrVW37GeZxJebj/bl6+qWTpjF4dJWT+qpeGvs8fEOOD3DLg
   yLrK90KfXsH9OC816kuPhUbIfNE3XUmj7njDjBR1eoHQRW1amRLN9HRfK
   Igf+8cSPbwjr5r3xJzLe7AGj6gtEg1QvImQn1W/OHeKZdLxRxIy+IkvFn
   SFyrEK2WlhMqbfrGsls1QQtIBkIpqNBvirheLtMD2Xa4ENCgz8+MsqVy5
   KlUgUQP/fek5R3d19Nt+S0jYCBEgYNPX5+Z3Sw906J3QcEComGmfvvTcW
   NQ6Ik8/JD7GM8f51f97ypszjmrKvZ1bXA1tYswCoW6l8Rdxq0dE3d9pma
   g==;
X-CSE-ConnectionGUID: 8oAzdZPSRfmbcDdy7CbfYQ==
X-CSE-MsgGUID: Vlic8bfDQCy8Sh6aKXcR5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11143762"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11143762"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 04:17:03 -0700
X-CSE-ConnectionGUID: LJ1WIciRS2aY3+F/48LE6w==
X-CSE-MsgGUID: R1Oql4nmSdukCYQ3vn6zLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29254785"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 04:17:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 04:17:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 04:17:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 04:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG0tkkvqX+xUWv2GItZ7M36TnqruU+arIkqFGqo+yFwxZc6XK3JjzZ3Ih2ABVtAD4wLbkzSLUyGNLBnEpKggUDD8QSi23r9fTd9vDdGtjXWTtmnOhoklKWrOuGFDAqAP4lWTFCdkgZqJ2iAJYL3V4L9nuv9l9O5H6GgrX964F5rvzgkXomPcEVQwSJeRxJBkTOkr0YmwqteuBeiCVHmh5cyv1IryRt0amADm9JpBTO7JAzQSBHUdbOMQLc/SE/9uZpdm0LXyf7JT4KXCnaUdOuYvzClTmgcsjpi+bC9Uqq7DgmLSEETZo1oqQgR9UX6r8ftZEtgtHvjpWrlMXO2JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAEkG+4bk7P1A0LQd6h+mWlg1rAokGwqb7E5Sf3JPAg=;
 b=oGrHTKA80DsMT8ogvnxdzqTI5kDUICYfsRnZqRLBZye2AiKB30UMtRQDRsK9ej+nI+pocYRfsFYKqD59tEUKPwS1NNG+GZB66SiBNfTw33jdYs+2vPToCjge4DC+V4ASjFbLYu0+PX52Y8FuFMj4jVGR5TgFq3Xb2ce2VyVRIdJfOz7SHqFxUZDu99T9A2R+HQna1k5g+yL3S4XQ8wM1IYPGqUFmtTrg0VdkL+YiZr9RzpVtPbPAaDkMQzAu/yG9VBQaT/DlM2EA1uUJCt9DPqmhYxk3x/jNVbp3lGRBUvVyazH9QMg8IjuqfHn5bEXkX1lFr4hNajVOBQ2FdIENTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA3PR11MB8075.namprd11.prod.outlook.com (2603:10b6:806:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 11:17:00 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::1c54:1589:8882:d22b%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:17:00 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] iavf: flower: validate control
 flags
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] iavf: flower: validate
 control flags
Thread-Index: AQHakA4MjiZvoVMaDUCrpkkDdlp28bGNUlDg
Date: Wed, 8 May 2024 11:16:59 +0000
Message-ID: <PH0PR11MB5013D059255D170B1FB2670D96E52@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240416144325.15319-1-ast@fiberby.net>
In-Reply-To: <20240416144325.15319-1-ast@fiberby.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA3PR11MB8075:EE_
x-ms-office365-filtering-correlation-id: af29173b-19df-4f50-0b01-08dc6f50614a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?djk3akhrZWZmbVRhYzJ3OXhXTVRrd09oNjRoaDNnS1Ureit3RStLUTJvWVAy?=
 =?utf-8?B?dGlJY01aNE50NGlIekRoN2tISUxtWE9VZDZVMlAzZVIzdHpmY0UrOTMvVW5n?=
 =?utf-8?B?RFptUjRBQ1M1bTBheFdVNEpNWTlaN2UrUDRTdW9FT2dRdTMwR3Z0OWlBREpO?=
 =?utf-8?B?eU83SkJCYk1ObUd2UGhKS01zaTU5bFZpQUg3d0NkMUFlbm9Tcy9ESVpQSzZV?=
 =?utf-8?B?d3l4SjRIMW04ZnlucFpHUUJBU0JhdmFLQlM5MTRjMnY5L2RUT25XblQ4eHAy?=
 =?utf-8?B?czBvWDJGbXliYnZDaWZNbnNUeXFpL3NIdGtWZWs5RTlBa3Jwc3ZOR3VOdXlG?=
 =?utf-8?B?UmdjTmlQclZCU2FKUlhZL0lqN3BRTS9HT1B2UllvSE9RbW5KL2h0b3BoNzVW?=
 =?utf-8?B?MjA0ejdjNWI2VzBJbUVtMnJWVmJIZXpFTU5MTm83eWd4NmJQZHNyWkozV2Fn?=
 =?utf-8?B?bFhJazdYRVVGcFBNSXo4Wms4V1NrcTZYdWJUS3JzNDdrYUlFZWo0ZEpLSWpK?=
 =?utf-8?B?eEliYWRreDkvaXNEcEt6Q3I3NW1EUHZIYnczbGtESWpqZFlrNm5QQVFrMUFV?=
 =?utf-8?B?K016VzI2NDQwdGsvVWtMaW5oaTlram5IZGl3d1R0Z2pGSkdIcFgrODVrS3Nj?=
 =?utf-8?B?UUE5YWdZU3hKWVVRVXEzcC9YSVBWZUd4RFFadWtEUTFOdGhSdU04QnhWVXo5?=
 =?utf-8?B?T2lQZlEwV2ZNVGo2d2hEU0FTYjZKSEs4Sm81U0NzZU54U1BwaUN3NGE1T0k5?=
 =?utf-8?B?d2U2OW81aFhnN3lGNTdndnUxTVU2UUNtZWxTdXpLVzFJeCtqSllyWlpOU1hR?=
 =?utf-8?B?a0djc1M3ZElqc2NjS3FnK1N3QzBTMFVucnRwcXRpSTNyOGp6N0UrS1JPbUtJ?=
 =?utf-8?B?RDY4ZlZHd0dlWUNrdnNQbGJsYzV6NUh5Tm1Cc0VPREZTZFlvU2lrY1p1dWlZ?=
 =?utf-8?B?NXdXSHh3aWhBUitYT3Q0S2tmTjlIMTkzSXN4NGVSWVNWeEFXWHpWWVdmV0tm?=
 =?utf-8?B?by9ybmFYR0QrOER2a1pXZG1JWTVIV3FRYXlTYXpwc3JNRzNzdHpHUHQ2M2M3?=
 =?utf-8?B?bVk1cDIxNGhkMWxsbFFuN1JyQWF0QWppa1dwcHNMWFhQWjAwYXRCaDlaN24z?=
 =?utf-8?B?Nm50bG5oSnIzcmZRUExlM0FyMnZTOWJiLzRleU80eGQwRG0rOWdmVmN3Njlh?=
 =?utf-8?B?UmJXbmc2a1JHd1krVGs3NU1OMHlSaGFnc1dmdTA5WnBDN2tta3QrMHdRUDhv?=
 =?utf-8?B?dUc2RzVTQ3UxVHFkOFFlbXJVUU9hUUltUXF4WTN5ajlYdUhMcEZ0cDVNa2g1?=
 =?utf-8?B?QmZOcTRFZm5LUm5sSzN5Mms1WEROZHpXZWJjQ2hhaVhuV1VnWE1KU0ljejlN?=
 =?utf-8?B?R3Z1aDJFcm8vcUk4VXRvREhqRDZGWDBWci9yVjU2T0YzRlZ4OW1BeXpjWWFy?=
 =?utf-8?B?Y1p4azRTMVd1VkNuTUcveVYxOXRMUjdXMldZa0F2L1FMSWhHbVBVZlBXeGZh?=
 =?utf-8?B?MWVydTNsVyt5QWNnbzRNa0Nqd3BFdk9IUGxNSjc1akRRd1VEMnd6OXhnOGNn?=
 =?utf-8?B?eTBaU0daRWZ4YTE3OXVzRzBmdnN5MVZUcStHRU1SNDJ6Smxaa1l1bHZvMW5S?=
 =?utf-8?B?N1V4aExxN3lUQ0FVRG5WaVRlYlQzekdJdHNmTkNnVzNZUEcwdUNmNjc4M3Z6?=
 =?utf-8?B?ZjE4R2FNZkZOVHo3cmRzTk9Ba3hRME1DdVlWSmVRSllXeVlqUFNGenI1c3Vn?=
 =?utf-8?B?bHk4MlZUemc1RFBSS1kwWUNxczI3YkFSL0czUnlLVVhQdGtNZUovYUl6ODhh?=
 =?utf-8?B?V0FvS1FINm1kZHJLQ3d5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHd6T1BtNkRaOTBDTE5UMmZlSzVzcFhrYnVCWlhNcFRzRTdQS3pWVDZ4VGFF?=
 =?utf-8?B?VlFnTjNsRnN4ZVNyUkJVMWZlSkxTaFRDM2doZHJLNWFCK0VPN3M5bENDK09v?=
 =?utf-8?B?aEhVQXY5di9jMU1qN0d6WG1oTnBJWFVHTFBKRjZPTG4zNDBPODBFL1lMaTNh?=
 =?utf-8?B?QTFvQ3ozclZpeDNFWEJOZ3h6ZU9HeGVMMm5mTGFISUh2NlhVTmdFK1FUSmNh?=
 =?utf-8?B?RzF6aXRFVktDSW53MlB5NmlLenl3Uzc5WThDMzFHZng2L3Y4SGY0NGE5WGIx?=
 =?utf-8?B?TmVZR0theVM3UjB0c1RzUXRwVSt6N2lLaVNVQlZnSEh5dmltSldZZGxCMjlF?=
 =?utf-8?B?cENacUx5SDRHWnpucnU2b1VHSk80ZVgrVmMzMU5QWm83NVYyUURvYnJmSDVP?=
 =?utf-8?B?MGtnRkpsUWFkcjgrTFhTUXBjcDBiQnU1RWhVMVJEcUJBUW9MbnQzdHpCZktj?=
 =?utf-8?B?QVNnU2Q2TmVUNnBGaWYxaVVMb2sxM0NOa3NWQUk4SllsY28zNzYwK2lCa1RD?=
 =?utf-8?B?OTdtOW52RnU0UTluMTQ4cWQrTUg0b2dNVjU5RXRSbEM2VjVmdTJmL2RFMFI0?=
 =?utf-8?B?bHVkTlFzZnJSTmFSL3h4RWQ2ckx4a3VJMThWcUYySllyNW11VGtRTnF1NUNj?=
 =?utf-8?B?R2lYVEpHVFFnemRRNm5JLytLRkdCai81ejE2bmN6bjhvd1Rzd0JZMFFCOURy?=
 =?utf-8?B?aHJBTndrOHhwd0hJYTdUYnVEZmlCQTlzd0J2RVY5YThKNHVMT1FYWnh0L0x6?=
 =?utf-8?B?aUh6RTUxUWx5QmVTczlWaXFQSkFaWmxaRXpnaEthbUZhZmlWbnhxSjFETHA1?=
 =?utf-8?B?aW9XTUZDQXcwMVR3Vnh1L3Nka2x3RDQrdVprQlViZUNNWVJORDhXdjk4Uit1?=
 =?utf-8?B?ZThaTjljeE8xazkyZll5U0JTMWdNcStUQy9DM1dNTzd1dnlyc2xGVDB6K0xt?=
 =?utf-8?B?bElscmRtK1VwS0dhN0xEcEhzaGE3S2dTRHVUVXpoZlpySHlOKy94ZDdUbEtq?=
 =?utf-8?B?eFVNWmtrakpXV1d5WEo1bUVpS2lXYmhVdXJhL2xRNGc5UndMSnNFdEc0MytM?=
 =?utf-8?B?YzN2SFIyNmI3enZscVRVYWF1SG9WNGhUZFhUR2tnWE54eEJqektJUmFxV2dK?=
 =?utf-8?B?S1o4MjhKdXhtcFV5MzJsWHRyWGVSclpadGtLWVNkdFpNQlBKY3NxeVZTQ0ZG?=
 =?utf-8?B?dUN3dlgvOVAwU1hkRFluOU1jN0tzOXBjY29jTnl4T0lGRCtadmpKQ0xRY1F2?=
 =?utf-8?B?WFZQVGpyVzF1OHV6Yy9hSThSMkpJZWtkSXZ0RTdUM3NqN0I2RFlyb2ZnZExt?=
 =?utf-8?B?U0NyM3FPS1M1MEJNZlEwQldDNUdxZmk3S2djd3hXTlY5MitLRUJkSjlvMStT?=
 =?utf-8?B?UFpUcXRGb1hIdjAwTjV0LzhBZ3FGMS9rWDN6empTcFkzb0JoZ2x5SHp3aVly?=
 =?utf-8?B?ZUc1OURKWHlRSk9xYUNqZW1lNUNHMzVKaUcvVW5hcGY4TVNSY2oyZW5FWDNM?=
 =?utf-8?B?dXNvUEppK3pjWGEzY2RHVUozNmtFT054NkdZaWZKVWFYMm52dXFCRk1RSDdT?=
 =?utf-8?B?ZE9MVnRGVThlcWRxdEdTOERiUTRoZEE4WS9GVk5jV2lMdGxWMDRwVk00TnZm?=
 =?utf-8?B?OURkbFY1N3BKUGY2NVp4UmQ1T3gzRzU5Tm9hWXE1QzhvVlFoUWxTdnNWOTFi?=
 =?utf-8?B?bU84VnZYVlhyUFRpSHhjYTZpR3VXRWkwcmp3T0FxZHdBeEZFRCs1YW1tU2ZH?=
 =?utf-8?B?eG5KZVg4bW9QVTVIb0VGYjJObmd4R1hPVEZIdmYxS3lUVDVpaUk2MDFpeEV0?=
 =?utf-8?B?a1Q2bVQ1MTlaRCtrakE4S01HNUdJNm5qZXV2aUlnUDErNURZaXF5eXNhRDI2?=
 =?utf-8?B?VE1wbjNTclV5Y3lOWkNNQmoxZEJpSDl0TGtpN2NLNHNPMW0rZUFwOHBHeGRJ?=
 =?utf-8?B?eWx3emMweG9CdDQranhmSHlvTU4yUnJWZXZPMmRxclhOOFlpU05HZ2xtUGl5?=
 =?utf-8?B?VFhiVUIzcWZuN0U4Vm4xd2VPYVlqeXB0VUVURkh1VVJUZ1R0NWNrM0hJV1FL?=
 =?utf-8?B?N0pwczJ1OVByU2F0UFI4c2JCdEZxdUpkR3BnR3hsWGc0NENSTTh6dEQ4V0lI?=
 =?utf-8?B?dFBGdmhscDFiSlZZYVYvSWVNQy9kMC9YWDIxUlFhQ3R2aXJTMkR2aFdYOE1V?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af29173b-19df-4f50-0b01-08dc6f50614a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 11:16:59.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/xb9ytkRvPyNf8VBKR5wksd6X2wKcf305PTiafo79zSBBmxU9VLRkMQRZdBTkteCvdklyGua0Lz7FGvWxilQ9281HWNR56Vxj9lTw8ANeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8075
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBBc2Jqw7hy
biBTbG90aCBUw7hubmVzZW4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTYsIDIwMjQgODoxMyBQ
TQ0KPiBUbzogaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9zbC5vcmcNCj4gQ2M6IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEVyaWMgRHVtYXpl
dA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255
Lmwubmd1eWVuQGludGVsLmNvbT47IEFzYmrDuHJuIFNsb3RoIFTDuG5uZXNlbiA8YXN0QGZpYmVy
YnkubmV0PjsNCj4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5p
IDxwYWJlbmlAcmVkaGF0LmNvbT47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0
Lm5ldD4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIGl3bC1uZXh0XSBpYXZm
OiBmbG93ZXI6IHZhbGlkYXRlIGNvbnRyb2wgZmxhZ3MNCj4gDQo+IFRoaXMgZHJpdmVyIGN1cnJl
bnRseSBkb2Vzbid0IHN1cHBvcnQgYW55IGNvbnRyb2wgZmxhZ3MuDQo+IA0KPiBVc2UgZmxvd19y
dWxlX2hhc19jb250cm9sX2ZsYWdzKCkgdG8gY2hlY2sgZm9yIGNvbnRyb2wgZmxhZ3MsIHN1Y2gg
YXMgY2FuIGJlDQo+IHNldCB0aHJvdWdoIGB0YyBmbG93ZXIgLi4uIGlwX2ZsYWdzIGZyYWdgLg0K
PiANCj4gSW4gY2FzZSBhbnkgY29udHJvbCBmbGFncyBhcmUgbWFza2VkLCBmbG93X3J1bGVfaGFz
X2NvbnRyb2xfZmxhZ3MoKSBzZXRzIGEgTkwNCj4gZXh0ZW5kZWQgZXJyb3IgbWVzc2FnZSwgYW5k
IHdlIHJldHVybiAtRU9QTk9UU1VQUC4NCj4gDQo+IE9ubHkgY29tcGlsZS10ZXN0ZWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBc2Jqw7hybiBTbG90aCBUw7hubmVzZW4gPGFzdEBmaWJlcmJ5Lm5l
dD4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pYXZmL2lhdmZfbWFpbi5j
IHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KVGVzdGVk
LWJ5OiBTdWphaSBCdXZhbmVzd2FyYW4gPHN1amFpLmJ1dmFuZXN3YXJhbkBpbnRlbC5jb20+DQo=

