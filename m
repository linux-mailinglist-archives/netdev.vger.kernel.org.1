Return-Path: <netdev+bounces-158003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834FA1011C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F323A76D2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285B23278D;
	Tue, 14 Jan 2025 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b532ZG/t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E2225412;
	Tue, 14 Jan 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838103; cv=fail; b=tVGxar4FoTjwVjpCccDK+WE+XcO5e3mnKh9SafHyYaL/oq2JOuXEq9Vttmr1c+CxnFAHx0T+BuFMNxx90LXdMgTFizybFfrjXrS16lFNsodD4y2uwU4gjUpBzdn35ixSoiuJZfVI2j6mmjH/TTuaTgCobo6FE2k41R3rIpvZtV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838103; c=relaxed/simple;
	bh=KDhpDpBtexbrSm3W4kuDuxllA+zuEJyh+1sOGOSKbhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5CPS+EPDCo9qA2bnajss0jauUkkdsUdx+ZtLKqV9OXnOSPxMa8vm5Fd5+dGUSNBUIXmvaUVfBLYuCC+Xx0nCmTQdU2w1du5qHaSxLPTL6fbG8Fpsi6BcvEcR7BycwZFA7J7N9+5AzNSJT3Z2XtJZTJmRolxByuGLWUEWWXRhhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b532ZG/t; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736838101; x=1768374101;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KDhpDpBtexbrSm3W4kuDuxllA+zuEJyh+1sOGOSKbhg=;
  b=b532ZG/tIZro5sWgRJRBne4Xluut82qPS7yH1Sx3b7x6t/rH55gOdxOT
   fZempxsHqZ/WxS1iJdDCVIsIYYhg6/4+fZNeFxqElVH/cHIG5hLDmKtCT
   pajFZua5eJF913VCW/rXio+vSIs+mZ4Z2OM0p0TL3RvHaW5FQYUKrulGO
   Q/DADIZj7ZerGEEBeQNTPYS2WNRnIaSi+d6Gaore9+ahl1AsZ7U+M7qpD
   6Nz30rUwDQ9MFoHETfAcYYaDvG7nCymG64O+W77IbFpQQyUsUE+tgB1eL
   INW1cNbQdvRyXExL/mwgMK92EBWY7nfx7POHZ0EJSTDdWw58V669OTW0d
   Q==;
X-CSE-ConnectionGUID: +3CarzvKSZ2RYLsyJR/3Cw==
X-CSE-MsgGUID: FbIgMBbhTZ+XpO570nW4gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39931599"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="39931599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 23:01:40 -0800
X-CSE-ConnectionGUID: GRDbCoXDR3ib4GbtA3rQYA==
X-CSE-MsgGUID: 1FnC64QwQMCiLOuDRs6eXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="109709304"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 23:01:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 23:01:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 23:01:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 23:01:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfe+LdN7OYZYDRwUbjtGDdDpPqGIpxRofTQ7WdunXGBq6WdTUGQcUVI6Zj88omWON3TJEKaWzTdUrTfuWZGUyXcEbO+Vq4pzstKS5zrf2JxBfor6GUjjtO0UWW9byKozYqpyloP2pBBvVSGmJMlWTNVOA/YNjr8QU1LKfis6Vxr9GRwpw29i8bDkmupWBZPovQyqLhWjKl9PIOseQhcmoeQsR/G0CKnfZdt+fyaHvzhQ/d/DrJMesuK2PTc5HeBdTC0OeuRX0yL61zsfiOg7+6DS58tK7e4GZIrjJbcoRnEQCLzSVhXc+CzBSiBzPal7qu27OGCkUlNf+69XMm7bhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDhpDpBtexbrSm3W4kuDuxllA+zuEJyh+1sOGOSKbhg=;
 b=nDVoTI/jSuN9qDIhVR1CRjgYPUEDfP7HMDbpPWvErQxBY591HRJvgZe8thBHuS1Cn0XPQqir6pALP7L7om3ih9SKkA8Xg/X8ARznFKKJs+X67Tunl43bOTCGtCzNooDHlpisyyDg+kGDpW+1/7kDmNWDoy/VKDJaBGYNGYHeNlhm9tD/+UxxtZzD0LSppl1FKHGf8IiYNjrXVQ5KhmFTiWxqU77ocFD2BnWu2dASkdSIScyibb4mlHJ2mmYpuklTr1Y5rfoEomdnsbrHuFZjyg2ohVP1WR3NQ875gECLb9LS9tqNptC8+u8b9pi0N1DKZKDP9sZ4KSu1sZSqjFyTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:00:49 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%6]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:00:49 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: Brian Vazquez <brianvv@google.com>, Brian Vazquez
	<brianvv.kernel@gmail.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Tantilov, Emil S" <emil.s.tantilov@intel.com>,
	Manoj Vishwanathan <manojvishy@google.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [Intel-wired-lan] [iwl-next PATCH v4 3/3] idpf: add more info
 during virtchnl transaction timeout/salt mismatch
Thread-Topic: [Intel-wired-lan] [iwl-next PATCH v4 3/3] idpf: add more info
 during virtchnl transaction timeout/salt mismatch
Thread-Index: AQHbT9eOZT4UzKRkI02hNs90qIeFzrMWBFIg
Date: Tue, 14 Jan 2025 07:00:49 +0000
Message-ID: <MW4PR11MB5911A301510B5390162C8DFDBA182@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241216162735.2047544-1-brianvv@google.com>
 <20241216162735.2047544-4-brianvv@google.com>
In-Reply-To: <20241216162735.2047544-4-brianvv@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|DM4PR11MB8178:EE_
x-ms-office365-filtering-correlation-id: 99b3b0d1-7011-4398-0719-08dd34692d52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?endLcTN3YS9tV1o3N1pYYUNlNDFDS1NnSGVsaXc1eE56Slh5NHd2Q1ZycDYx?=
 =?utf-8?B?eTI5V0lKcWlLNEYxaktnMkVzNEpnVkZreW5ncnYwb3BjZE41KzMwbGI2d0hZ?=
 =?utf-8?B?RC9QWER4UG9wMk13ZFdsUHZaTlkyRytpVWcyN0hkdTJPbjRrVmJQd24vOHk1?=
 =?utf-8?B?MEljY3dTbUNkZGhrRnNQWjllcHhQNUlvMHJ3K2laV0QrZDNWSWYxSFY2TWpF?=
 =?utf-8?B?eTI1T28wTXg5NmY1dEVXYlQ5LzV4OHEybis3emJIVjhHc0NSSEtJdlc3NGdH?=
 =?utf-8?B?RmlqSFJZNXZ5NjZ2S0JsYk1oTzZiUG5xQWxZUGRVSjJOVE9WemlXTUVxWVlG?=
 =?utf-8?B?OWFCZEgrdE50cHh6UjVwMUpCc21qa1JrQTZIM3dGUFcyVFdBbU5VQTlWMlBl?=
 =?utf-8?B?YlR5eUFsYWJnYThPbkw3cGxpSGVsd1dLcnRLbEpkaWxLd1NtdHQyNm9oY3hG?=
 =?utf-8?B?SWp2WVpiU0FmazVkZUJiLzdUU042aGd4WGRDME8rSXlPbFZTQkJxSGJlNVVz?=
 =?utf-8?B?MFFFVGw4U1FXVStMOFB2ZmEzVG42STg1Y05qTnZOQmJndlh3aWsxdnpHQnhI?=
 =?utf-8?B?SmdxclB1Q2lqcWhDZnhETTRHMmhXdElrSWFaVWJTemRoUG5ZOEhWRjFiNUY4?=
 =?utf-8?B?aUlkL0hQdnBSYURGQlEzeUU0a0NMeFdYamlVQks3bjZMWTFsdFpvZ2o4OEFz?=
 =?utf-8?B?VzVyL2ZVbkVWUHU4UHYyR0ZPeFdlUzBjL000MHIwdi85d3dKY21QUXV3RkNK?=
 =?utf-8?B?QmJGSWlaYS9PZ0ZENCt1emFGRmNLYnc1WVdYWm1ZaU9PUHZiT2IrejQ0UXBt?=
 =?utf-8?B?aWxLbU5uY2lSbVkvMkx1WGxPdVJTVXNBSjFnbWp1cjlQRzk3N0pSeFhpVFI4?=
 =?utf-8?B?WUlnUUpyc0I5SUg2eEZGdXg2aFVOazBoQ1YycGxOcmpRbllqQWRZTVhJaWhI?=
 =?utf-8?B?YlhHUGJrOThFTUkwa3c2c2M0eGMxeklHRVNwK1QyUUNVZUxod0I2RzRnNnVm?=
 =?utf-8?B?VHRkREowem80ZWRoMEVpUVVnazY4cW9CVi9jUW1NRE5jUnNrdHg0ZUFGZ0Ux?=
 =?utf-8?B?VExUUWJkOG1RRVQzQ3IyV1RvWnFKZWN6REZLZ3FwNzJTQ2c5TFBRYnY1SGxO?=
 =?utf-8?B?eWtJS3VNSC9aLzRVSFNHVERNT0lZNWd6QmZaYmVwOVBWRDQranZkcW5JaXJm?=
 =?utf-8?B?VEIwV0FYcmtsdllESUdSdUFKOUhwYnJwdWlXRmRJZitjM2xkQkU4MXZOa0lp?=
 =?utf-8?B?YlYvWm1ZZm9xeDU5aDA1TnlYN25nQ3NOa0tmeFd4VVdMeWVPUEM0aUI5all1?=
 =?utf-8?B?c0FEckE5cXQ5K1VNVmxSd2FSdlhsV3ZnVGdBZGxhU0t2cWVDeEkrMmNUeERJ?=
 =?utf-8?B?RTNLR2VpNWFGZVI3MW5YYXdCbkhrVVM2b2JTVEt4MXN0dHBrU2xOY2sydmtq?=
 =?utf-8?B?VVJjRG1aVFl3VnFIS3RTY2RoVy9IYWh4bldGZTdKaU9nZXplQW53ZHBDaEI5?=
 =?utf-8?B?YnRseUc0QjZVYi9jNUdheVYyTWxMelY2dFRqMTlTaEt2NWVsbWZXYmVQM0lF?=
 =?utf-8?B?SjhBeVNDZ2pnZjJaekZDVk5Lbmgydm9OTGxURWlwd3R1RUVRYmIrMHVPd29H?=
 =?utf-8?B?Z1UxaFdrNW9kTjdIaGMrZnFTZjBxRTcyc3o0bTA2Q0dnYU9kWHNuZWVQempo?=
 =?utf-8?B?THhkK0RMQ1V1em45TlFZOElZODJnM09oOTZNWFF1OGhpUHQyRGdnUml1TTJq?=
 =?utf-8?B?bFRmUCtBNkR3eXhtcmRnMG8zSnVQbW9WaDhzN3J1Q3daeGJzMURaS1dvRHI1?=
 =?utf-8?B?d3dSNmtJV2M0QU5UYWxvMTY1aGVLdUpTU2tkZGR6OWxLei9ZMS9BM0NzQXBh?=
 =?utf-8?B?QmxvcHVmUlV3emRtVm9oVVhaeUV6dUZuc2Z5aDFCUFN5b3pxQmZ1UG9vRGE4?=
 =?utf-8?B?SzVxYmJLRVE1bGpiZzJDdVVWSzdPK2p5UDhlRjBHaVkxYWNWaDVoZGJnM0xy?=
 =?utf-8?B?Yk9zV3oxUStRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1pxbDNjbTJMcTVkTFptRFFzaXdKK1VNdjh3WGc5eVl0dSt2ZkgzSjE5djVn?=
 =?utf-8?B?YllxRmd4bkJTakcwWExSUTh1ZzhVZjJCcmh2c0ppSWY1Q0JOZ2hnQjdCL0RQ?=
 =?utf-8?B?UHYzcTNhcEpTaDRMaWlSeFNNT3RQa2t0SENFZjYwbjZtZTZSYWV4UW5NS3Jr?=
 =?utf-8?B?VGpTOWxqblFhVGxxT2w5aVRHemtvekU3N3RYaHpERnJIVnlOQlVORjhKeEJV?=
 =?utf-8?B?Tm45TEZ0aFQ2cDhSeGxxd0NxZFlqL0RTV2QvcnFLeVRSMWdBZythcXd1dW9u?=
 =?utf-8?B?RFE0cEJEcUxaaHA2c0FqNlkxdDh4SzdyaWR3VXpIeElNdEU5TFJvWjFVaVpo?=
 =?utf-8?B?TWt5MlYrbElNcFc3UktNRG93NWxxQWlDcnBOcFZ6bnFOUFJMNnBjNkpiWHJ3?=
 =?utf-8?B?OGVwSTdHcGh6MVJQWmtjOUFjL05YZkVEWmxkVUpEcDI2akJwYTVhbitET09p?=
 =?utf-8?B?MHp2UmRQY2NSdmROVEllc1VXMXlWeGdnTlZXWmRoaFFVak9EVkxwcVR4bDNz?=
 =?utf-8?B?M3YyQzJucm1rdEc4akR1cloyYVBWeVFlMHZjZDVjQktlY2lXQjI3RFQ1Z2pP?=
 =?utf-8?B?eGNqei9NbWlyNkQrWW54N2lDaHlFWis2V3VQVmVscVJOcUhQaks3Q2RNYm1E?=
 =?utf-8?B?clRCUTNoT3IyZlJIZzlFK2hnVWtLbDJJUkFIZEl2WWhqV3pEWEF3azR3NWxK?=
 =?utf-8?B?b3ZCczdNTFdDV1ZjdUhweTFzRnVzYkZNd1UzRnJMK2VaZ250Sjd3MXpqV3hV?=
 =?utf-8?B?RjdwR3Q0VFFuVGZtWjhCZjFsS0sxQk1XcTVUdDZvL2dXT1B6R2xERlZDdklY?=
 =?utf-8?B?UTY2NE5vK2RtSTJVQ1lKN2toR2VwcWN6aG5WNktIaC9CZjVkdmozQWNzSm1v?=
 =?utf-8?B?YVFmaldrSGVUSHZOdFV6d2UyNDg5T1hFY2RqR0JURHp3NUJGMURRcDFoeENu?=
 =?utf-8?B?V0tmdVdDcHNwNjM1VHI1dDFacWppUXIyUVo3RHk2WkRvM1VJSFA0UXBwc3Br?=
 =?utf-8?B?cTczOUNKdjNrTmlNM0ZrMDNEeXlEQ1BkakxDQ2QzeWYyeXR1cUw1c2pwVWNE?=
 =?utf-8?B?MW5zN254OFh2Wk13a2ptZUpyZnhURGowcG9JbWpSdkhRQmxjMm8zc1A1YTNl?=
 =?utf-8?B?VkR3dWlaR2dXMDNFOUp1ekVMMi94MmtrVnprQzMwbUViaElWaDZCWjNtRWF3?=
 =?utf-8?B?K05JeUVMRERqd1pGT1gwYWc1STBKcC9weFZ6MVhlTzdPTjU5Y1AvaEZDOGI5?=
 =?utf-8?B?bG50dmRwRnZuVEZWbVhaL3ppOHV4RElieThqdHpvTFJiRUxidkFlaXRrRnJL?=
 =?utf-8?B?bUNvd1c1NStWUm1hTEthVjBqQWZlZ3YrUk5XTS9ER2F2TTNvdGZ2d0pZSG9t?=
 =?utf-8?B?RE5reVVhSTRFM2ZFY2JUMVJBYkdRZlpyeWdSOFpUZ2tlTmlGSXZ1UURxYVR3?=
 =?utf-8?B?akZrd0t1b2lHUk15TThMVDFlTGJRdkxkWENuUFpPcnZkTUx4T0hoYTNqcHE3?=
 =?utf-8?B?SDNIOCtEdnQzNnpweVd2ak1YL3hWelBuWjFYSXhtSStJU1JJS1FMdk5lRFRz?=
 =?utf-8?B?RDV3S2ZuVEtVdkw5bXpPUEtrMFJvQXpjMCtWNi9WaHZCT05rblRadG9PV25a?=
 =?utf-8?B?UlIvZkw0bzJrVStYcDFNaFhZSlVqRXNnWngwY09JR2ZhL1lDTjZqY0RyTjEz?=
 =?utf-8?B?UllkV2ZaMElWSGRMMnpZWjV2ekVoRFNyaGNRR2FCZzR6alpLWCtCTzFCWVZI?=
 =?utf-8?B?K1VPaUZoZFVvTUx3Yk82UDZmazVBb05hSjhFTGVKS05VK0Z6SURoK1JlYWdG?=
 =?utf-8?B?TERwSGRwaWJVQXZQUDdhVDgrOWEyTjFkbUJXd2JJY3hzM3dLekh5cmY2d1R1?=
 =?utf-8?B?RVZYcFQxWWFQdjN5SHBoL1kvK2ZiWVM3bXNjYis1K0xLR0JDZFgxZ0U0WDQ2?=
 =?utf-8?B?T3FMNnNQUEh0RUI2ODNDSFh2R1JnNDY1RG1tdVVEMXRDaGJoS1pnb3RHUGp6?=
 =?utf-8?B?Q3FMWEsvQnJMY2lKWkRyME0vUEhCcXFKN25ENTFlWkt4eEpCZnMyNURzQUpV?=
 =?utf-8?B?V3plVzNNQlBHUHZrNGswTjZNWkM4UCtyRGtBYXU3UEpOMHQrTWtOTUVvc083?=
 =?utf-8?B?Q3RHaTZxdlJYSzBJM2EzNzdaY05xYWRFRTI0UHllNWhCY2lHdHhkclhkUmNV?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b3b0d1-7011-4398-0719-08dd34692d52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 07:00:49.2658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jWNFqoJCmpxErS+AqiZ+Tq/w9XD41JGPvSaeXwe/If4nNf9YhyYBmTH2MqoEffD3YVxf/ZVQ6z8bj2HgpZQ3zCa23Ioov0RFhvjap0N6kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEludGVsLXdpcmVkLWxhbiA8
aW50ZWwtd2lyZWQtbGFuLWJvdW5jZXNAb3N1b3NsLm9yZz4gT24gQmVoYWxmIE9mDQo+IEJyaWFu
IFZhenF1ZXoNCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAxNiwgMjAyNCA4OjI4IEFNDQo+IFRv
OiBCcmlhbiBWYXpxdWV6IDxicmlhbnZ2Lmtlcm5lbEBnbWFpbC5jb20+OyBOZ3V5ZW4sIEFudGhv
bnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3
DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZl
bUBkYXZlbWxvZnQubmV0PjsNCj4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsg
SmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlA
cmVkaGF0LmNvbT47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBEYXZp
ZCBEZWNvdGlnbnkgPGRlY290QGdvb2dsZS5jb20+OyBWaXZlayBLdW1hcg0KPiA8dml2ZWttckBn
b29nbGUuY29tPjsgU2luZ2hhaSwgQW5qYWxpIDxhbmphbGkuc2luZ2hhaUBpbnRlbC5jb20+Ow0K
PiBTYW11ZHJhbGEsIFNyaWRoYXIgPHNyaWRoYXIuc2FtdWRyYWxhQGludGVsLmNvbT47IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBUYW50
aWxvdiwgRW1pbCBTDQo+IDxlbWlsLnMudGFudGlsb3ZAaW50ZWwuY29tPjsgTWFub2ogVmlzaHdh
bmF0aGFuDQo+IDxtYW5vanZpc2h5QGdvb2dsZS5jb20+OyBCcmlhbiBWYXpxdWV6IDxicmlhbnZ2
QGdvb2dsZS5jb20+OyBLZWxsZXIsDQo+IEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNv
bT47IExpbmdhLCBQYXZhbiBLdW1hcg0KPiA8cGF2YW4ua3VtYXIubGluZ2FAaW50ZWwuY29tPjsg
UGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU3ViamVjdDogW0ludGVsLXdp
cmVkLWxhbl0gW2l3bC1uZXh0IFBBVENIIHY0IDMvM10gaWRwZjogYWRkIG1vcmUgaW5mbyBkdXJp
bmcNCj4gdmlydGNobmwgdHJhbnNhY3Rpb24gdGltZW91dC9zYWx0IG1pc21hdGNoDQo+IA0KPiBG
cm9tOiBNYW5vaiBWaXNod2FuYXRoYW4gPG1hbm9qdmlzaHlAZ29vZ2xlLmNvbT4NCj4gDQo+IEFk
ZCBtb3JlIGluZm9ybWF0aW9uIHJlbGF0ZWQgdG8gdGhlIHRyYW5zYWN0aW9uIGxpa2UgY29va2ll
LCB2Y19vcCwNCj4gc2FsdCB3aGVuIHRyYW5zYWN0aW9uIHRpbWVzIG91dCBhbmQgaW5jbHVkZSBz
aW1pbGFyIGluZm9ybWF0aW9uDQo+IHdoZW4gdHJhbnNhY3Rpb24gc2FsdCBkb2VzIG5vdCBtYXRj
aC4NCj4gDQo+IEluZm8gb3V0cHV0IGZvciB0cmFuc2FjdGlvbiB0aW1lb3V0Og0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IChvcDo1MDE1IGNvb2tpZTo0NWZlIHZjX29wOjUwMTUgc2FsdDo0NSB0
aW1lb3V0OjYwMDAwbXMpDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IGJlZm9yZSBpdCB3
YXM6DQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+IChvcCA1MDE1LCA2MDAwMG1zKQ0KPiAt
LS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYW5vaiBWaXNod2FuYXRo
YW4gPG1hbm9qdmlzaHlAZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQnJpYW4gVmF6cXVl
eiA8YnJpYW52dkBnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFjb2IgS2VsbGVyIDxqYWNv
Yi5lLmtlbGxlckBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBQYXZhbiBLdW1hciBMaW5nYSA8
cGF2YW4ua3VtYXIubGluZ2FAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogUGF1bCBNZW56ZWwg
PHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZHBmL2lkcGZfdmlydGNobmwuYyB8IDExICsrKysrKystLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg0KVGVzdGVkLWJ5OiBL
cmlzaG5laWwgU2luZ2ggPGtyaXNobmVpbC5rLnNpbmdoQGludGVsLmNvbT4NCg0KDQo=

