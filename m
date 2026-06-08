Return-Path: <netdev+bounces-296770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NHpOmpKJ2rJuQIAu9opvQ
	(envelope-from <netdev+bounces-296770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:04:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3DA65B1D9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:04:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=H3E7Qoef;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296770-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5B630087AD
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6F2EEE67;
	Mon,  8 Jun 2026 23:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DC17B418
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:01:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959705; cv=fail; b=NnCWrByynpwNfAS6zi/0WLeT71cm6weFgxK2KnbjBLXuw1LKRTNfOboISQVHh7Q/PE2fj541fNHusjL1wxuVDWfFK+YrCrhIB9/P58WZicrvM6Bzyxu2KHBMjICLSTbQLM8idOpwn8Yv7gDcYBIeYHAiCYBMkvcmFaXJnN/2Aig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959705; c=relaxed/simple;
	bh=+KYLDxNkb5isiC2UbEArpTBXY18FuXrNBlFmtY35txw=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kJrnz7Lm46gqdmCR752bz4KzeWVn13dnnFaYOZAo/aYJERnameyfADWtdYNvY9rPu56wvlQp8ytC8qzjR+udLh5YPTi9VTeZYHRH4ZaSmkK9JRRTJL+vhmSJwIXqpdSpfFTf/EvUnXx7GPTzEauNngFbev+tUgDJDoc0atrcdfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3E7Qoef; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780959704; x=1812495704;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+KYLDxNkb5isiC2UbEArpTBXY18FuXrNBlFmtY35txw=;
  b=H3E7QoefeMAAenGFy8VIvNxBTs3s3QKhPy/CpM+z89jK5O2oljeMoWZe
   m3Sdz8d0alikS7CuM3oShazNveCpl6HzpfJQmIfsYC3eRXuIx1fxAlPkZ
   677oBfQ7H3QwHOkMlxiVIhJhzor2hqbt7swM0EIS5gwFNOicZHjIcX0ld
   CAEEMv+/rk/oBmuqgGHdDJMObFG0M2U9r6c3qLbYVszF+AZiBpG1KzbbV
   NZjMHx58c08lymUWQyRMZ0q4xazXUy+Tb3yurps+MeJ6oXDTx54/VOqJq
   eSyxoJGc533D6Cn1kjZUMXCQ7gJLcWpVS6uaPDxU/fdahy/7APrrkVR0J
   g==;
X-CSE-ConnectionGUID: BZCbf2qoTk6ct8C1k86hFg==
X-CSE-MsgGUID: AiDxCzwnQmW8G96OfSl8WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81457587"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81457587"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 16:01:43 -0700
X-CSE-ConnectionGUID: f82oH18vTvCflWl1JLQb7g==
X-CSE-MsgGUID: IoUwgHXiT0KPoBgJ/eXO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="244552743"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 16:01:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 16:01:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 16:01:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 16:01:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePwcpv/ZyVoOqtXtFtAkVB0653RwRG6s51AjSZAOC6Vjbc0D+J+zbjYLkJJDBirJg75UH9LVGgB0rHci7Ignf624MGt7aLSY+cGgHOzri6fjjmGrhKLk9jFg8xyg3lbzk4ZWp9X9tMNn0rbaeZuXQ4Nkl8lCJnAM4GPRYEx5HOGefU7jMQ4Zg3BDkWa8ULFM4zxBV3N82SYPqU3Z7M6prurxBEevJ7eUz+t9Aq1A5BvmUwrle2IJT4ijgU8uCVAUK+kUzyltxbICBJo/ZZEWp2UWs/QWc4wHJanWfrCojSrQA/1j3Wb6YT/vhqClhBI96NsvdBRdOwSkga9HOWabWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0I8qDkatRjdpPFwXUcMuedYYAvtqfM/iXgR6yxF0m4=;
 b=pNk7F5sJ/VvSKJEswOYs6V0YKQNkCLrGYFk9UzMVijCRtXDpaWFwsaMicCSC21whLxfYMRBuZCmn8eTFv6EneRGZE04GVpcylMiSeF6iK3w3PR0FKwTHWYY1B75vup4e791GvDQLVW0mWCiYWNc+40rsIsjpyeV8wdJrRHee7tLu72f5T8X2up9n3ZSYH4ztQy4K3o7YqmC59lnx2jvt36WVxuPocXPYXj198oPlq8WS4tPvJWNtY0pIDV38jSfIlrw9wcnSlGwWx3TyEST8B33WQj0NTKwweuGmMQjMfgn2jI+8pLI8rPdZlbK0ZMMq3QxBxrfAosWM1XjMrk66sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 23:01:37 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 23:01:37 +0000
Message-ID: <abceffa3-3544-4da3-83ea-e23b64b3c0a7@intel.com>
Date: Mon, 8 Jun 2026 16:01:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>, Anthony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <michael.chan@broadcom.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<joshwash@google.com>, <tariqt@nvidia.com>, <alexanderduyck@fb.com>,
	<willemb@google.com>, <kory.maincent@bootlin.com>, <sdf.kernel@gmail.com>,
	<jakub@cloudflare.com>, <nb@tipi-net.de>
References: <20260605002912.3456868-1-kuba@kernel.org>
 <9c013ab0-e96e-4670-932c-bcd1e30a85b0@intel.com>
Content-Language: en-US
In-Reply-To: <9c013ab0-e96e-4670-932c-bcd1e30a85b0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: d561a91d-15c1-4a62-b232-08dec5b1e48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003|3122999024;
X-Microsoft-Antispam-Message-Info: XVrbYL7A07TS9WTeKqoXcmF/24V21DOoHNmz5ew6kuZtx+RHq/H0hfMW2GcrVoKSdxVC3liM7iYjTL51Ps7js0WlP9m+yvcFyQPi+5/Ay0WN6tQvaQbTKKaHlYG5dS+q5AL2Tv0I+9g81j67pve2uweR3Meh0DfRUb6NSYJpjjjXsd7mx//hSXsEYg7dpXb1vr3st1rlZGA3FSYDW9sMfC+YGrPDIT6z2oZplwLoM65fGSLLtJtkIq/AdBzLBsjoNjkQGI/7iMMkAIbqM2CQ/eUz3wvTpoXznVfS3YnbWxtHg5Ei1LqQjVhi5+lg4ecVMm2FgMHwFLVpf8nzYPNvQmvnT0WY1xeOtcHol8dCLfY/j0+SgdMB7TLqc/1aujHEfYXJDKtBUokam2Xo7PH+ZlbJ/o9bYnkDIAKdIAlLXqlYODGwaenTh60NA8LxekghJEYE/6wjomzbvddvMe43y8oV9s1hHE3YBg8yp7S4Ln65Vct2qunnrXoDLSoJzIdKMPN8pju3L9vZEY3r25uqk2IqkgLLm/gkjopMq8xD5NV8+oJkQaLZUYQj0THwlhLQMrv662qZbtdg/A61zuuhIIxLmXfppve6KxYqkvkUTpkaNBR4QJYWelvbbfRefaUHz1WDNfhkYGJI4Q5pogeha6pmzhDtC6W+rAuJJ5WxFHORSowdeyAaxoH5xpP3wgFA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNCclI4QUJsLzZyY3VUeTQvQXBsUWVybUowV2VBSUdsc2xFS3M2Q1FQR2Y4?=
 =?utf-8?B?L3ZGRStRY0grdnc2Sm95aFNCc1ZqU094b21UZEx6UE5XbzlkSEREdDFlVkZ6?=
 =?utf-8?B?MHErSXB2NURCOFdxTm5rTmVkcjVJRVUyTTA2Y0wycTNEODkrc2Q5ZktZR3dW?=
 =?utf-8?B?d0xTM2hTZ3E2UktabzdZV0dMUWtxdXFvMmx2ZmVLU3cxblcwOGVvaTdyRnVI?=
 =?utf-8?B?SU96eTRJbzNVQmxuSjdjM1RwYlRMQnpGL2xFRUFZaWd3aWZ3TTVocTVJbVRN?=
 =?utf-8?B?a2tHVnRSQUtkS1ZjcCtiVURIVFRmRUdmdW5XTmFrbldZRWRFamFTM3E5bmRm?=
 =?utf-8?B?RjVOVGdwaGpuWmwwRnBwNUJtZkxjVEFLaldQRXZnS2M4UnhtMXpkT010aGN5?=
 =?utf-8?B?dGpmU3VOZmEvejBSTGI2Qmx0bHB2Z0lQUWIzS0ovNXcySURhdjkvZjVLYUVG?=
 =?utf-8?B?UnFoWWZOVkVqemtBeGhPa1dqaGNJcW10YUVEWDRYdVNyaXFEUWFyTzArZnov?=
 =?utf-8?B?azd4ODFiZmtNQVVqUDRWZXZ3R0E0V2xSaEF5U1dCb1NPdkhubW5JbjBYNkM5?=
 =?utf-8?B?WXdWSGJDeG9LenBLNGp0NGlyV0VvNTAvd0Y5eCttVEVWTnk4Q1lsRlVEbUQ1?=
 =?utf-8?B?cUhWNi9JNXdNLzBmUy9xQm1kSkdCYVhQbHRMR3Z2azROcG1kWXRjQjA0TFI3?=
 =?utf-8?B?V3Vkek5uUndxZ1V3dFFVSmZmN05wZ3BiR3B1ZVZSYm95TnFaKzhsLzRYU05m?=
 =?utf-8?B?V1dTOXEydm5ncVJOaDBYSG9tMkRsR0ZLNTFiS3hvdE1NV2dqL0NPVmRXNmpm?=
 =?utf-8?B?d3VLczlOQUY5dHJrWXFGWVBSRlJaMngray9RbmVPc294TnlQWlZ5QWJUMFBJ?=
 =?utf-8?B?aDk1YkIzbk5tZ04rdFNwYXJ0aE1kQWZNb1ltTG00ajh1YXdPcmxTZG9KUUJO?=
 =?utf-8?B?Z2JkRnlZSDVtNmZzd3VCaXM2M2FaMHhyQjArWFBlM1dxMDJ5YWRVbmZIK2N3?=
 =?utf-8?B?WlU3S1N6dlVtVCt2cG13WXVRR1ZXVFBwMDJkdElyUWxlMVFUeFNhd210QW42?=
 =?utf-8?B?dG1adktwV0RpbEdFSGgyVG5uUnJlMUxSeVFaeiswcThNZlQzYWRGOXJJTFdS?=
 =?utf-8?B?Tnc3c3R0NjdrOU5WNlhRSmRUOFJnR1RveUdGNzJCc3FFYnp6L3RYQ1RGR1Rz?=
 =?utf-8?B?d1c5a3FKM2RwNVFsd0x4c0JEYTFIZmx2UGhPdW04T1dyR1JySk9Xc2VPbG9U?=
 =?utf-8?B?Uk5ndmFtd0c5TlcxUW1CT3htTy96QnZDdDI2RGM5bGg4VXhoVGZsWldWUEkw?=
 =?utf-8?B?V3Y0bXZkVkhKbHpWRmJ3TmNnUmIrSFFocDAvN0xiMEl3TmptM2NrNllEbHZq?=
 =?utf-8?B?SUwxbTg1bnFKY1k1TUMvU1FMUVVPR1JUa05zK25NSm1hNTRuSGxPZE9xVU5j?=
 =?utf-8?B?d1FIRHVIbXd6UktYb0dRbFYxcGxPSmd3Tk1OMzF2WHYwZzR0UDNmNExGWG1q?=
 =?utf-8?B?eVJxVkRuMi9YclBxNEV0R2ZaZDMvdmxNb1ZVYTU3UDMxMUpaZzlTQ2xweGRv?=
 =?utf-8?B?TTUvb3ZxNGROdkRRSTRyWmtVY1JSN09SanBWZHVSRERzMm5WR2hpMkh6SWl3?=
 =?utf-8?B?L2tRdFFFM0lnejlmOS9RZTF1QTNzZWtQM3RnOEVUdUFKeGZXOHNzdTZYNE9q?=
 =?utf-8?B?UkFyWVRkN2dJcTI2YStndGliMExVM3lUQVdEM2JSckxsakIraFZEc0tHNFRS?=
 =?utf-8?B?Q05Ebng3Q1pXV0w3RlNvdnRPdUdhNHMvdXhJQ0lwL09aY3RrL2ZoYUJSVG5s?=
 =?utf-8?B?Yk1HeEZ1NGZLRSttMFR2RG0yZGk1bFZUY1NFZDkzV3ByVGZRU1NPTXFITG5F?=
 =?utf-8?B?TlJvL3gxN25hMWM2ZGM3Z2VhVEFMdklRS0o2ekVIcSsxR1puNEp0REdWUTdX?=
 =?utf-8?B?TzRNcFVmWGNzUW5saW9CTDRvVmd6aVFxcXlZYjFoWk1QMGtTSDVRalhGcUU2?=
 =?utf-8?B?SFFjaFA2Q2NNQStCaVlMcWpIelJIK0NVNFBrUjcxOFZqTUFsS2hEV0ZGMC9U?=
 =?utf-8?B?eDhocUpCZzhRNTBLTGlZMGJaVEtWTDZDN2RjcHlWdW0zck0xL2xxL1VlV2Zt?=
 =?utf-8?B?VHp1ZzhFZS9zYms3RUN2RFV2dmdWV3pFK1AyUklkOTlUK1VIN2hSVENkc0E5?=
 =?utf-8?B?YlkwRnZpTDhqNXBBY0Y1NXVpQmsxM3dLVkQvbk9FQVlFS2h6L3p0S3pSYzdl?=
 =?utf-8?B?akpOR09EYlVENjNZQ0ZqU000RXZDU2lyZkZOdy9xSFQ2YXZERTJWQnh1bmht?=
 =?utf-8?B?UTNKbE1neER3UmxyZXJKVzRpZVFaREhaWnZhdFNZaHg3M3ZZbDlFUT09?=
X-Exchange-RoutingPolicyChecked: CS1Vl+5C7AHYhmd1klZnWZ2+gKWk8sn4WV66AWXICXz5I2iTonMyNHQKoPE6D7jFa+eOeJWa43WEVnYgy8nLVkynPdw29GxPXLIvOBtE5tHJT3vyJaBrW20n9wCLzq5+U+vvGWWeY281TTxQB1ybuNnr82XMKLcscmT0IkhfuC44dCkcJPLPlsJbwK6B9eMVYkyNlZ5kssjbMdpRpejtNrzy1PuhQvB7hT2imLYG7QC6ymm6loVukBIS/fjxyZFmGCYHkR40DBFCFRM+HcT8OFmQTVp7jHBpOb5DQ/CS0Xf3ZY0Vp54F58VRMS7v3T8enGLYHV99Mofh3v0ViYWj7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d561a91d-15c1-4a62-b232-08dec5b1e48a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 23:01:36.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EztURIZZ/7g7j7tNU+r9ZcDsbVV6Q7dGym5CqFNnCfv73dovO3uOxs7AlK2WPfNspvetHw+LOLpb6TIkXsyY4b73czAAoI7zyjpsETKDKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296770-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,cloudflare.com,tipi-net.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D3DA65B1D9

On 6/8/2026 3:31 PM, Jacob Keller wrote:
> On 6/4/2026 5:29 PM, Jakub Kicinski wrote:
>> With the ethtool_get_link_ksettings() situation hopefully ironed out
>> the previous series (commit 6a5d837f0ce2) let's return to the main
>> part of the series.
>>
>> We have been slowly moving towards removing the rtnl_lock dependency
>> in driver ops since the concept of "ops-locked" drivers have been
>> introduced last year. Since last year will take the netdev instance
>> lock before invoking any ndo or ethtool op of "ops-locked" drivers.
>>
>> We dipped our toes into rtnl_lock-less ops with the queue binding API.
>> Queue stats, NAPI, and other netdev-netlink objects are also queried
>> without holding rtnl_lock already. It's time to take the next logical
>> step and lift the requirement from ethtool ops.
>>
>> The direct motivation for this patchset is that ethtool ops often
>> involve communicating with device FW, and may take a long time
>> to complete. Aggressive polling of device state on machines
>> with 10+ NICs have been shown to significantly increase rtnl_lock
>> pressure.
>>
>> There's a handful of areas which still need rtnl_lock (see below).
>> I decided to convert everything to rtnl_lock-less by default, and
>> add a set of flags which let the drivers request rtnl_lock to still
>> be taken. I don't love this, but I'm worried that opt-in would be
>> even more confusing.
>>
> 
> Agreed. It might be nicer to opt-out first, and then opt-in the drivers
> that don't do the update_features.. That would make it easier to prevent
> buggy drivers slipping in as easily... But that would result in the
> following messy situation:
> 
> ethtool ops for ops-locked drivers don't hold RTNL lock, *except* some
> which do because they might call update_features.. *except* those which
> opt-out of RTNL because they know their driver implementation doesn't
> call update_features...
> 
> Yea. I think that is too messy. This approach requires slightly more
> vigilance on the part of reviewers to ensure that ops-locked drivers
> don't make a mistake here. However, the checks to see if features
> changed while the RTNL wasn't held should be enough to help catch most
> cases. Ok.
> 
>> Known issues / exclusions:
>>  - qdiscs - qdisc configuration currently assumes rtnl_lock, this
>>    is mostly impacting set_channels callback. qdisc config is probably
>>    the easiest one of the exclusions to tackle, it's fairly self-contained.
>>  - features - even tho feature changes are (correctly) plumbed to
>>    the driver thru ndos they are part of ethtool uAPI. ethtool itself
>>    calls netdev_features_change() if it has spotted device feature change
>>    before vs after to the callback. Some drivers also call
>>    netdev_features_change() directly in response to various changes,
>>    e.g. setting priv flags.
>>    Since features have to propagate to upper and lower devices anything
>>    that touches features is quite hard to move from under rtnl_lock.
>>  - phylink - phylink and SFP depend on rtnl_lock today, I suspect
>>    that this is purely for historic reasons. I started poking at
>>    it and don't really see a need for a global lock. But accessing
>>    the netdev instance lock from the SFP entry points will require
>>    some attention from the phylink folks.
>>  - phydev - similar to phylink, looks quite doable. But no ops-locked
>>    driver currently has a phydev (fbnic only uses phylink) so phydev
>>    related paths retain a ASSERT_RTNL() for now.
>>
> 
> Makes sense. Taking some steps towards the end goal is better than
> trying to wait until every piece here is done.
> 
> Whole series looks good to me. I had one minor nit about one patch
> adding a bit flag at BIT(1) and then later changing that to BIT(5) but
> its ultimately harmless and should not force a respin of this important
> work.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
>> Tested on mlx5, bnxt and fbnic.
>>
> 
> I think currently only iAVF is ops-locked for Intel. Tony, would it make
> sense to see if our virtualization validation folks have cycles to give
> this a quick pass on iAVF? (Regardless of whether it merges before or
> after, it would be beneficial to make sure we don't have any lingering
> issues there).

Just to clarify, I'm not suggesting a delay on merging and am 100% fine
with merging this before such testing completes. I just want to make
sure we (Intel) do double check the iavf code so that development team
can try to fix any lurking bugs within the kernel cycle before they
become wide spread.

