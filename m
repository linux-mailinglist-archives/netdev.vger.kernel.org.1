Return-Path: <netdev+bounces-274266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N1OGfuUzWklfAYAu9opvQ
	(envelope-from <netdev+bounces-274266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:58:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8918380C88
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975363050EFF
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8980639EF3F;
	Wed,  1 Apr 2026 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ays9mPag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D13909B5;
	Wed,  1 Apr 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080430; cv=fail; b=oc0EO7VXSmqpAw7v6glxxlK1aKYExY0DjeUb+80m8aMBj/A1i+CM3abZ1c8jB2cyqlF0i4YiaXz5o160aBVfHSYCWd7pk0D5dlWJJp1wRMT19gTONHawrKyPuvbLOFQb+oVJWccydl5MSpucoDscSBagJnRLsvWjCQ4TgGt+9KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080430; c=relaxed/simple;
	bh=B7IXhwsB9qMHf3SvY9/xbjg06MBF2CoqalrwWGqu++U=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Vg4sRZaT0Ur0HimU2D+u118aBqxBstjXq3cSUeL8eAOgaoS6MFOK30A+faspuZRuBPnYK81YITDvCtK3mplz1hXIVJzlr0DVyX8CHYcyf5ntUIgjXoObu/cmSPcfuF0MQDt9jS4gIhR2h6tQ31gh2dwoe6IXMR7OeR8B81UzEKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ays9mPag; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775080429; x=1806616429;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=B7IXhwsB9qMHf3SvY9/xbjg06MBF2CoqalrwWGqu++U=;
  b=ays9mPagf0tyZqKlg/ztD2Dep1Gluq0pc9L74EUDQL5qQf7V75W8GLwT
   bMcinDPChyyMOuENIyVjGkQQZsJX/K4fwZcqmWzfCYsTi7g1/KHeQxIJn
   OsIwH1Z1bSNsNSEhCj9eqtVrW8z1IoSKIg1/mdkzAO2SPPFCgBAzML5ee
   8XZ4spLcfXd9jMKC+RkmLpM43ZKtyRAK9faGUCi4Wr8l+i48LFVVPxZ1s
   blhZdr48aO+0yT7pbEy6c7BUWNWkVFR8Y3InBT1uz5HB1VPd5EE+aLOWQ
   bf3KiJIerwymoWiuYwVcoS541XYXMuRmO6SbDwLf2E7H1pXkX+vYv6A/E
   w==;
X-CSE-ConnectionGUID: cQZ7uFB4RwiS7TsH7ywpdw==
X-CSE-MsgGUID: sP6cUGeqROO1+6BVa62S/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75850473"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="75850473"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 14:53:49 -0700
X-CSE-ConnectionGUID: sPhJ7jfgQbirJDy89cDdqA==
X-CSE-MsgGUID: +VSpus0tTY6G69lw61Ci9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="222435901"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 14:53:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 14:53:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 14:53:47 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 14:53:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPYbffN8FxzMJagl+4p7YG1evZ+dvTlSgqSEeT4GOQyEobpdUq3bcwo53tWPRUbglYBcMSM88ErzQhFAesVB4F36EbAMZF9QL3ZzKwLEy3INldv4WvColQaajNfEWyZQX9dZ/eVn2qLsxM9C2C/qJsCnwKyOXKN+QO2VKB+QTlhkXzLUsqYIIcxezWDGsPBl8T82pEihWRx5l7/IjzHp6V16dTZO7UWl0oOVWnm6GlwEOEMnbDkLeYCez6Dv3/2RldrYqkl+5qct48WSIMp7CmUYupehwxu8WDBaUy40Y75Qm6ZQMQpUbfIsEUUJq+iTn/OHGgDzmpxHEgH8i5I0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X9GwyRlS3in4h+GdYxMZveYKsJvwgs+CEQMbh47h5A=;
 b=iuw0z9pBcm+PdWdvRJPichYPViZ/mjcSlHBTxW95i9kww1uDiZ7waIeMqzykzLE/38RQf6DPAU/ecWXgSho0FRIaNzsXax8RyxrG08CPDfTWDpRGU8mFrR0qn+TRmjs6EqMQxR1ULRfZl9/UPjW+j46A+nsSEhY5rn23GXxPf+IoTz7wQJA0wU5m/+ZI+t/FTMi6Lqurm2Vr5Ogt+RYe0l2LkTaW7UpKeCt2OtUTsmFt4Nlnduyklv5ax2WEdHcMI0a2ChBtoROO8qJlyzz9sgXfj7ErNoIxZkY2iklvQ+fq1Jn2qDk8gImQt36DpdJ6ofYYK+nqM4yiLzW9zhWAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Wed, 1 Apr 2026 21:53:43 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 21:53:43 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2026 14:53:39 -0700
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Fan Ni <fan.ni@samsung.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Message-ID: <69cd93e334c11_1b0cc6100fc@dwillia2-mobl4.notmuch>
In-Reply-To: <f0f5a510-4073-444c-9f05-7153d0b2087b@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
 <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
 <69ccaa8448da1_1b0cc61009c@dwillia2-mobl4.notmuch>
 <f0f5a510-4073-444c-9f05-7153d0b2087b@amd.com>
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e88c67-766a-4382-d4a1-08de90392490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: gzNVfZMhYoVRrYzPHw/WBeMUQ0ac7Q8VZcMdnoG2uQg+SG4hJ8gOMtFYHCMKwm5oO/7tblAa+jm4kUOFpVBc3UlcUqHY93lkkqSkvx2q33NENfOiOsC62GsNzfg+eVjTwKS/9ibIP+nhOK4Ix0i9hwqkQX2L7EmpRi5ozjWe2srDWj+8fGbo/dmi9oPYWBhFQ8Co9UK1iey20hxlWCwKofbyztH67jpbzt41x4a4gveFOxjcp4X53vvCAz24UJXvrEM6UAEhYN39Qx/HC/YxFjinXXGieTqo3obHaXVDO1/52hP685OFICGr9gmXJConfSi91l2SFt5m+QU2+2XGygjK722Lu1t6U6qwC21drjBPc6dAisu10pVlmo8WOxru8pExzB9G30eQFATKaaD4bLB1DS3+PsYuaO+9uXeRuovZVkeeFLGhs8eq/ioFT2Q69rK1qNZV5Uw5zs2wJ6K9II9EL2iA90/1hp/3kvH5SepXfuPtr5cil4NRXjLiQ3c8iAHaelEfXCDoaXft736AWtdNT/8shxNVIuCruLsP69UfrhqMWlQwGxQeG37Y0PreMzp+S8FrzfZLJyf6wGqEfK/Z8xq01oXOAe6gZJhQAHOOr8XyFL7us1fnua+lFtGt8i0PPYx7XZrRjETDNwmrvz3V5aE+Ou18vbiuEDaBQ1p4xExOsS+dO7A0i+1REGwSTeNmTcWFHVt09y53g+FaV9hmv92THd0q/d+BuwQbmsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1wckhUSjBDWWNFTk1IbFpLc3FnMWlZTVhNeVBoWEo0enZOSXBpaHg3eXVV?=
 =?utf-8?B?azVjdHJ1OVp3bDRWNTFzTk04T1JYTkJET3phblliZWE3dThXUXlGTHNveFhX?=
 =?utf-8?B?TmU1biszT1JYSVpuZkYyZDd4bkp2dVZGYXBFMkE1Z0Qzd1lOQm1oOEJkMUdV?=
 =?utf-8?B?aFJnZE9KY09QMGhSaDVaQ21UbU9tSVRBdGh2bHo4YzdFbmxkZjRxNElQRzlm?=
 =?utf-8?B?dS9Jem1wZHIwVDl4akgzaktNM3RacFlIN0dSQ2RMcFE2Z1lhTFY0S3UzNVh4?=
 =?utf-8?B?bFdiQnh3Ylk2QUdvOFNNMnplYnloKzBscVpnc2lNUzdhaFdYTlR3OWxiV2tT?=
 =?utf-8?B?a2FNYXVZRzIvTnhSblVnZmJiRU4rRGNqUzN2TG1Wd1RPQ0t5MmkwRUxkc1FZ?=
 =?utf-8?B?ZWx6VXI2NnhDWWVzVEJyWFNzWkZZZFRZa3VJZTgvQkRUUWZyUHdLY0JkWURq?=
 =?utf-8?B?WjFtdDB5cGxCWlJVemJnTVZPZ0xFMDhaZkhETlUwMi9CRERySi9Rck1PZDE4?=
 =?utf-8?B?T050clVWVHpaZ1NCNXhMNk9DZFc2d2hQSzRTNmpOYUJncmtHK0wrLzdSM0Zx?=
 =?utf-8?B?U1d5cmxBQUhxWmVHQ0J6ZkZIbTNXVmJ2dzFOWjJOOUdnNWZSVmNzRmp6UkVt?=
 =?utf-8?B?L09sR1ZJU3B0TmZ5dmVYWUxoalhuM0kwZTV1MHEyWE9iZkoyQ01HaG4yZ1BD?=
 =?utf-8?B?MjVtRmlpazVpaHhlTmNNbU4zV3czQXpVa09zZ01qL2J3RlZMN3VOMnR0QmQw?=
 =?utf-8?B?aWh6YmtpcmY0S2NLMVZsVlE2cm1wUEt5TVQ3SnNpeWk1blpiSGV0QVVjZGNO?=
 =?utf-8?B?Tko4ZGVpSisreUNsczhQVFIrQUNmUFNoQlpFTHhNWHQ1dGxKenF3Q2lGc2h6?=
 =?utf-8?B?RzZmbXJTSDJOSEZBYXdyQlJVSHF3ZU1uMExxNjJ6K29hUm5TL2V5TGxuVlU1?=
 =?utf-8?B?UjM0SXE4V1pYZ09hd3FPbFZqSnIwcG5BcUhiOHZVTGRIc3EvQlpPRTBzcUlk?=
 =?utf-8?B?SC9MdnJLdmJ4bjB2M3EwUUFVMlhzZmtpSWVDbGRVWkt2REFiQmNScjltc1ds?=
 =?utf-8?B?aFV5WlVKTGlUcTZiOEI4R0FOcHowNVUya2xqeStRRFBTZ2taRW9sOUUzUTR3?=
 =?utf-8?B?ZjhVQS9WN21PV0JmNEdYNlNwckc1dko1ay9ibkd6TFcxOGtsd0xwZW0xZkZS?=
 =?utf-8?B?NXN1VHJadDhXWll1TjRqdlBCclN2eW94YmdsczIza2RsN2JGSE9ZM05qUnow?=
 =?utf-8?B?R1htaC9mOW9wS3ROa3RSQ1h4dmxla2RUeFZkbXI4SUNXQWtPZXZmV0kwcnlx?=
 =?utf-8?B?TnZ6Y3BjZkw5MlJYdkhOQTJFSnUzb1lNdEVWNUVzTDhQVnY3SzhFQ1hNV1V1?=
 =?utf-8?B?L2dVdjc1UUpoOEdYaWdnWEhaaDJnbjFMWUtVdm9NZTV5U3FYSjdjOXhzU2o5?=
 =?utf-8?B?ZW0yZUl4b2M2dFZCckp5dzNVWERmc0htSGllaU1MY1dxKzQwTEFXamVmMWUz?=
 =?utf-8?B?Nko2WTFFSURrZjFnV0lVVmJ0VG9uWWN2aE9pSkFiQk8zSC94bGt1NkhJNEc4?=
 =?utf-8?B?R3QzcXJKNnVuWnhxVmN1RFJOUnVvZGoxT2wxUkZRMTR0YnM1WW9UUjM2L0Vk?=
 =?utf-8?B?ZW1HTDVpZHFTbTlnc1FTQmNiM3FodVdBR1VBUHVnanNCdmZsWUJoazZsWGdm?=
 =?utf-8?B?d1QyNmlMeVJ0YlRkYW5oVTVMK2FES25ha1pEK3lRNjhhWFpEenJoVFRWejNt?=
 =?utf-8?B?aVhyN25VNXo5STRlbnphaUd1OE9XUGVsU2dpOTliWm9JeW1PVjVUY3lhU3cw?=
 =?utf-8?B?QS9jQjNFRVlKeU5DbDFuU3ovcFc3YloyeUNOWkp3Z1lBVUhFdndIVTgwOVox?=
 =?utf-8?B?TWlRaElKVUhUd09TaFRReUM2OERZMjZzUWlzTEZ1VHp3aVZqb09kZ1YyZ0M0?=
 =?utf-8?B?c1BmK2tleEZhVit4cVNzbERLQ1lVNlYvcGtlQkFPLzhlMDg3Nmh3KzNGLzN5?=
 =?utf-8?B?Nmp3S3QwaWx0T2FRRHlBL2VTNndIdkVVY1RiQm9PQ2hubS9ZdTRrNEtzOXhr?=
 =?utf-8?B?bVpQWWpEa2Y5dDc2Wk0wV2h1SDl4YTlyblMwazI4NlRGeXp0Y210K2JHU1NQ?=
 =?utf-8?B?VEFlNW5ZMHo0cm1OTFExUGRDTUFaY1dWNWZjbmFyV3FDc1J0WjF5aEVhc1lk?=
 =?utf-8?B?cVA2cnVvK1pGNGdQblBieTIrYUs2blEvQytEZFZVSG9lNEcycHRuSHE4dThT?=
 =?utf-8?B?THBla2cyQnJMbVVlUytzUGhxOWxtVHNDTkEzSEhsVU1GQnRmSDlXb2xucnM0?=
 =?utf-8?B?N3NuV0tEZ0wxWEJEZFErRHY1YSs1MnF2ZFNZZDJzQXhVVytXaS9YUmQvL3NQ?=
 =?utf-8?Q?BV/uI2MClJSUxXBg=3D?=
X-Exchange-RoutingPolicyChecked: fRrlZsP/rdSds7UpEb61KI66nBxrcXu0Yv224AD3NNBTvku/iYt+1TnTT1Cw/y6b77uDu+3G3hGpRwzME6SVG7yJL6BW04x4IomwN9+eHIJbcgxVGwaDXi6FFYfbEu6G2ocjYq9moPDyEZGEu6lODWE5oP5r/yoPwt/QEivO3mVPdvy1BFPjbz96IPfC9v5tg4Mkotng+NsfBlDDjgsxwhR3rhQgETBmT2kZ9u+YxR2Nj7JbvTRv39jm3N7F2+j3flnWoZ1Q5QhheABCosmkWqipjbSud2DKVuxx7dS4X64UEgriWkq7EdGxQ5xNIH6nQ5DKmwz3UDocpsmaXCmOzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e88c67-766a-4382-d4a1-08de90392490
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 21:53:43.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92wDEnV+QLQEiHXLPV2n48xAidBqCkrShMmDUMLnnU48VGs5XnWGP66H62OlL5uGKUw4fqT9XLX25UF0zpiWCk3nEHTrA1O4ORGtoXSMQ9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-274266-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,dwillia2-mobl4.notmuch:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C8918380C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alejandro Lucero Palau wrote:
> 
> On 4/1/26 06:17, Dan Williams wrote:
> > alejandro.lucero-palau@ wrote:
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Use cxl API for creating a cxl memory device using the type2
> >> cxl_dev_state struct.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> >> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> >> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   drivers/net/ethernet/sfc/efx_cxl.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> index 6619084a77d8..63e6f277ae9f 100644
> >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -75,6 +75,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   		return -ENODEV;
> >>   	}
> >>   
> >> +	cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
> > Did this forget about:
> >
> > 29317f8dc6ed cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
> >
> > ?
> 
> 
> I did not. The idea behind attach does not make sense for sfc, so I do 
> not use that option. I did discuss this with you at LPC and based on 
> previous comments which had not replies (case 1 in here):
> 
> 
> https://lore.kernel.org/linux-cxl/836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com/
> 
> 
>  From our conversation at LPC, there is no reason for a CXL device 
> connected to the CXL Root Bridge not having its memdev properly 
> initialized.

The cxl_core can not make assumptions about attachment topology. It has
always been the case that the cxl_core needs to be prepared to handle
everything that the firmware did not. Error handling and kexec also lead to
situations where the boot configuration gets invalidated and needs
recovery.

> I did ask you specifically about this, and you mentioned links on CXL
> switches not ready, but as I said then and repeat now, this is not
> what sfc driver expects at all. Only a port from a CXL Root Bridge
> makes sense due to the latencies involved with more complex CXL
> topologies.
> 
> 
> So, from that list I wrote in that old thread where I tried to summarize 
> the problems and clarify the confusion behind different concerns, the 
> only issue is someone removing cxl_acpi. I do not think that should be 
> possible at all,

...but it *is* possible to remove cxl_acpi, it *is* possible to invoke
'cxl disable-port'. The fact that it is possible contributes to
complexity, but it also supports flexibility and is a building block for
error handling / recovery.

> so something should be added for other modules depending on it
> avoiding its removal. I would say any CXL port created is (in X86)
> dependent on cxl_acpi, so something at port creation invoking a
> exported cxl_acpi function could do it, like a cxl_acpi_users counter.
> This could also help for visibility to user space about its usage.

There are two choices, fail removal or handle removal. There are some
degrees of freedom that can be pared back, but outright blocking removal
is not one of them.

> Therefore, I do not like the changes you propose here. But, if this 
> proposal is the only way

It is not a matter of like or dislike, it is a matter of functional
correctness relative to the state of the subsystem today. Simply put,
one proposal handles the locking and lifetime concerns, the other does
not.

