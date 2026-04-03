Return-Path: <netdev+bounces-275224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJgVCBYt0Glm4QYAu9opvQ
	(envelope-from <netdev+bounces-275224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BD3985DE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379F9302D0B0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299B34028F;
	Fri,  3 Apr 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7b19Ih2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400302BE7B6;
	Fri,  3 Apr 2026 21:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250706; cv=fail; b=N1vAJHjNT0j+ntjqc7lV0Yg0j55YieDJqn3CDnw1soqOyDVN1EQt0LOHkv8UNeu4S7vxsiSFo0eZDb+ludlA1OBrqb12ce6kegFqmvbcFb7pZkVLyjnSi48RGTGfck58SL8Mtq/j4c0U+0IG5n8Tk6RkONhFNOKfEUNPrBGtxoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250706; c=relaxed/simple;
	bh=U55dABdWYvkJT6MZE8MvR60+uNhr6ULs3zmg0uUs7rk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CD38+iMFgQz8t13chKIN7pl1OIN9sV3oiKDaqn6AzpakFjiI8cW4EbeGf8uTKcetHqpfVM+PIzsjoZ1GMIOrECWtchy6eUv0R9/7iWkD01l6O4F4gpJ2PC6gem/Ms+zl0jH9W/qbyO6fhgK5iyBiFsE3ysz4l1UhPRgw67c35eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7b19Ih2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775250705; x=1806786705;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U55dABdWYvkJT6MZE8MvR60+uNhr6ULs3zmg0uUs7rk=;
  b=K7b19Ih2sLT6nYXXi8DDMqn7wFDnL3JgMei4uYvHpTyMIK8GDgKCmRyG
   jPNl8rLjOfpejxEuas6eu8npVpJwjpvrUal503Mxh3n9KrVAf9r9kIaEC
   Le2VYUPLryBAFVguXIsQ4FeL+oIJnFJZ8WbGfYiyYPHddFFMwaQjDm6q7
   bzuNlVHk7Ui2gA5A2bTspOV9gmWaIDXML0TTVI+upcKgVo8Q6DYn3gzHu
   OIrrT4J6wyUllA4x7pczhQYzje5NvJwcd1yb0ymK+UIW760fcjuZpL1PT
   w/0cOsGmHIPbhrJFw3/BDDR/LCkcmqFYEKWy9x0AiiV3va+WGkwR5KE2v
   g==;
X-CSE-ConnectionGUID: J+rZ0D69QQ6qV00B4NM58Q==
X-CSE-MsgGUID: Rw5DmoAQQ8iO2LL2hOmfBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76198667"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76198667"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:11:45 -0700
X-CSE-ConnectionGUID: d7qzfdEXQkOXUaAGDDOdNQ==
X-CSE-MsgGUID: QJf8+3MQSGiE0s5CjBpNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="257816367"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 14:11:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:11:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 14:11:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 14:11:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkMmjd1hf0fyda4P3l4PzYy1Dedx2OA637uyExWOz4YLK9apOqm2xqQAniZdLIeO8Pez3pePrGO+HFgUJLG2REjJ39CxZ292U0H3rXxTokkX58a5XxoLX5yx/kwjG3bim7p8bja3bGeuxSvuKqFMm47roFtnD7UeH10v4IH2BatGI+fkHe/pRVXjZ7nLswrznE25l81DxllgmHZdz2QD8Y+CnTf7z2iNeeFjDl+tpW3lqMHm3VYEEEt58sEU6TA5Le8KrcZOyP1dwYpjHR1kcWnJ1bT4JzuhXzJwBxVGrq8VTexKKkFg0duyCKX9bwzzobmX6+nAEgAZXMo8otnFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBYWnRyprcNlSBZD0/nn1FzRZFVNXUaTdjjWsxu0+Es=;
 b=NlCF0dqUon1LmyrfkuyjZBpWTQfekF3+WhuILjxzIx7hKJBfAHTvh5gaKmfT2yK8nODNApfHPgixmzt06zjGI9Ha2Ooefpw+kR7lzRPpT3xZTAhXnOmCrUSRpAOeubanWeEHs3cRvh+wenJ5SBW3zgs05fPkOLZyScG7WsvNhJ5Q25EnG4BBnmWxoq0wjg0t7rqJoeBAoLOiVC+pxH94gqEN544DHDenTMLLmrNEcpF/tEcZdgGhNVI5RR4C5CdlsiqQkY3rksns3RITdcUEzKSgwQvg+U3CUFBPp4+OQWcgs/zkWKdunv1Nchpa3TpIrJ55NlXJ+PlFc765SHBRJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.12; Fri, 3 Apr 2026 21:11:34 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9769.020; Fri, 3 Apr 2026
 21:11:34 +0000
Message-ID: <1e3a815e-4fdf-4bf4-b298-42abeed67fcf@intel.com>
Date: Fri, 3 Apr 2026 14:11:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] gve: skip error logging for retryable
 AdminQ commands
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <willemb@google.com>, <nktgrg@google.com>,
	<jfraker@google.com>, <ziweixiao@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jordanrhee@google.com>, <jefrogers@google.com>,
	<alok.a.tiwari@oracle.com>, <yyd@google.com>, <linux-kernel@vger.kernel.org>
References: <20260403194427.1830609-1-hramamurthy@google.com>
 <20260403194427.1830609-2-hramamurthy@google.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260403194427.1830609-2-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::25) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: fc95099f-d4cf-42c6-9481-08de91c59602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: E+wSx7Xv2lAPgp5JTtQWC79R4OWeeWB7o5fqzRxywQ6RT48BbbqAXsGwPhP9g5BasdV7s9yFtARbTtaZdw61asMTDwxijOl1Y1ddSLRSeqdAgfAHcf6VyzijdJcGezCDGf58MMwYoVppQeIDhhqW1O+Km5XP5U8CIKy8Qt7/4da2naj2s88zL3hhdIe7PXbwHe2wJMfkZgEmUm6hFZveUQ2SBr5eiK4Ss2c04HVtn+toMX0t6miZJ9FN/P2QSrmOGjY3crxEYGKNpH8Hg1TE0rH2DOfv4f90WOHBjchJvs8Z0aZ5pTWqT4NAXqN+/NgkVP8w9MpcW2hiCaSv1TI6UaCycLn/47Ht6/1dknd8dkdExDEf8Oiw6Jg0YfgZfYvqvlhpnEVgvw9QSe/2fqQTXNBMIHVk0fvZmqtVMF9hbKdHxSg5rI4g0HBtHbQzdCWYhrvZ+PIncRUMBHuZX4rrK6PO2pWJpD1qPXesPCU0N+vsSsoVgPKDSBrDeg+h4abIhmYX8cVeCjoiXDfVZgucvZkuv5BHSOdAYKV6YuKfn0RQKL9Bo6aMHA6tmk8WvbiJ/769g/FepRRQ1+VtNkR168iKJGmcOQg6KIfcKxw+8GBw5GD3UK1r5GLp4snJNwp+rRCzFpPF0MyW1Mb2z2bvj2gKG8Sh5/6awjU8R+NKDUsjm563OHlmAtm+wfL75bVHpvH/Pk9zjTww7XNkj/B5/NRpnAI7cGyNx2khp2XsNsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0o3R3BlbEVWaFdhQWpTM0svN09Mb1UvMU05N1dYdWdEUnN0bjE0WWRacDYv?=
 =?utf-8?B?bDl2V1AwTnlaSWw3SmNWTU90N2MrMzdFelVlZlZ3MWRTTlZPQm5YS0ppWlFr?=
 =?utf-8?B?bjZRYmcrZWhhYW90VGRuUThKKzBrOVhPalZDTlFlZFJ1RC9paVBYREZ1bTAx?=
 =?utf-8?B?bFZRbzQ4WUZ4aGl5djRvUk55eVV5eDNBalFCK0xYaCs5bGlVbEpOR1djRVJi?=
 =?utf-8?B?eFBFbmNueXJkdmJmOGFETUNqQUp0aFVsQ0dhbVdjMUxaeGZRY0orbUZDTFpk?=
 =?utf-8?B?UEdsbEExQVVJQ2NEaEdSNGllM2gvTnhwVVl0WHRWTHJKV1EvTW5HdUJjOGlJ?=
 =?utf-8?B?T3RYWmp6WmIyY2hsWkdOZU1LTitXeEQ5eUg3c3pSTURtRTRUZkQ5OVIyaU8x?=
 =?utf-8?B?TFNvQnl3U1EyMnlkZEpKemN4NktKNTNaVlBtZjhYd2g1bFpyTFpodVhOSWNw?=
 =?utf-8?B?YW8zTUFxMDRUaGxNMkZPWEIvWitaYlRiSlRGdFhHZnRUMWFVekxBRFgxTHFh?=
 =?utf-8?B?K0dKRHNPV3dSeHVlR3RJTHl5NUw4Z2pzS3l6TXNrdzhBSDRhYVEwUmp3YUVN?=
 =?utf-8?B?UmIzajE3N2svSjdzNUZsNXdEUEI3ejN3ckJINFdqbkV0eHh4bUY4MjY5clMw?=
 =?utf-8?B?Um1sRDZRZnJ1WDEvZUZMZHF3U25IbFdLSVRGa0RucG0ybGhyMHdoSEJzeGlK?=
 =?utf-8?B?TVpwYmNkenZZZlRDeklMaTZwY2tYWmRRYmhyb0RtenBDZzRXUDhQbFU3U0F6?=
 =?utf-8?B?YU5CM1RaT20vQVRRREZUN24rSWRWTGxMcU4vb2JEQzFKV0cyWXk2bzZWMWtD?=
 =?utf-8?B?K3FhQkdNSHk1L291elY1VGEwSVZPUWd5QWhTV2dlMVBOVkFsbXlxYjlCUmF2?=
 =?utf-8?B?TVBUM0RGRnRVYTlvaXhyVWpydG92QXQyajFxRHFuOW15RDB5WEw4OE40Nmd4?=
 =?utf-8?B?ZHk5cXdCbHVqQ3o4SmE0bDgyQjhlWVdpY0plSW8zY24rSnpNeEw4UmJXTUV3?=
 =?utf-8?B?Nm9IaytzZ3hOVk5OOEVRMWhaWXFxZEwrcFpYL0NrMCtHNU14NU10YzhMMXox?=
 =?utf-8?B?cjFrS25HbGJVcmRId3Mya2IyUENFL1pYbFBTNEpQNE9ZVWpoSXIwZFR0QWxT?=
 =?utf-8?B?TlFDdmlXOGFLbTEzM2F3WkpZekl3NUcrbnk3bXFZdWN5MmVIa29Tbzd6TFl5?=
 =?utf-8?B?L1c5aUF2bUdZTlNNWTVzbzVEaEh4R3dpaHkwRmF4WnVxU24zWnNVclZEb0xV?=
 =?utf-8?B?Ymp0MUQ2U0Z2RlQzKzBxRjQwaDd6UWNneDVsRUVQNXZNMVNpcUhsM3hGVUNm?=
 =?utf-8?B?aFVIRVE4WmM1ZExEREpMWVBNc21JMXZ5eFMzRXZiNDU3clJqSERIdmpUZ3I4?=
 =?utf-8?B?ei91dGRkN3I0bXVZeXYvM3JRV2E2UXRRWWE5NVpHRDVnRE0wUTJuS3pSTUNw?=
 =?utf-8?B?SkczdkgzR1d4Q1h2Y0U4R1A3MkVST1IvRFFhTGxRNEJXcWNtZUVRWno2cXJX?=
 =?utf-8?B?OGtQREtIMUVsY1BLSS9mRy9oMXJBaHNxeW9SdS9Nb3ArZW1jY1RUeHlyOG9N?=
 =?utf-8?B?bkxadlZ3TUNXRWQzU01mY0hERUlEUDhRU0kwcU50ZVBuUkdvMzBybTFuZlI4?=
 =?utf-8?B?Wk84d1hicHNMNEVxSmpGOVFUdVRIZy9JMDVNVzlMaFJ4OU56ODZRUG5kRGh1?=
 =?utf-8?B?em1qN211dVVaVHF2M3gyZFJMRDdYWjRialJvWjdSY1ZpYm1ybmZ1bi9Ydi82?=
 =?utf-8?B?UXJDYWtXOUNqT1pGOXQvUXM5b0N0dnJQeC9kb2JLVWFyOHlNeWpTN1pBcmlN?=
 =?utf-8?B?eUhQSkRHT2RtRzNXZnVFVzFRaDZJZU5veWEvUDFveGFPd1JJZXdTSGRRRlZl?=
 =?utf-8?B?eFRnTC9CT0R1dXBYak9Dajd3cmpPSmFhd2lVMG9uRmc2dkdZQTVMV2d4djFC?=
 =?utf-8?B?ZTBsVlkvK1lkT0NkVVVtbURsYmMvMmE4VnlVdEdwR2ZmUEg3SnowbGllTDcy?=
 =?utf-8?B?d1l6RjBBcnhHUVJaK2RadGh6dytzSUcxekpVSGhmTkovemZ1VTYvQ1NZbmpu?=
 =?utf-8?B?by8xRmg3Q0RNcitCZ1BSZFBoRHd1QXkvbXpPWVVqdUxORGNpY1dFRVU2emNR?=
 =?utf-8?B?NzBJRk9McnIzVkVMYXY2aW9SQzUrTTE2Y2VHK21jQ1lKNlpZeThvTWZHU1JB?=
 =?utf-8?B?TTdYVEh1ZUxndEZxQ1JLbWJFZHBwY0l5MGRuOVZEcEJDTTJ1VTRUTCs2MkFy?=
 =?utf-8?B?Nmh3dlFDODV6Z2lOUDRRTGNSNDBwcHhObVNXc1lZRkNsVGJDcEdJUk5XSkNL?=
 =?utf-8?B?SE4xNnJQSmp2bUFpcjR4djVvWnBvRmxXZ20rak4yYVNnSDJyKzEvVnZHSUE5?=
 =?utf-8?Q?DcZ7Tc6lLRKDb95w=3D?=
X-Exchange-RoutingPolicyChecked: LKWIWyhqeH1prXnBmHmdzCGYMMTjtvIkn4eMzQdAbHzNh61ZTjZTyM1U7Sn52+jM6KuAPrjEE3fyuVRZKazetObxopWk50XdVpcsAOU0EXOzkUfnXLBP0roFbzGSkHGSOWaQQp44Hi/wuxXqMIkB7nlJgKGTPR5mx0DecedVvPJCF3ag5HOpxIsXM95R839510a3+XkY2pBhigmNP4xq8vsdBYouwqShJnp9pPv7bMprG7qJtDc8kGr/3ByWyFouO/JzV8VsrmTRtvGfso89AkfwCbR8fC96N+HHWM81RBSdaRhZWeT4d1hEi4fCBiw4am/sBut1tp7OzdDOtasJvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95099f-d4cf-42c6-9481-08de91c59602
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:11:34.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3ZKbUcRTD+3m3WJ6zQcsAViDVUJNIgFkVjhjIiTUtwVdSlXwVrqrcBKSCB6rCyeaPDZBJnMiIR4BhrYiZiaEGZrIOOi4gXLtFbO+nlNBYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275224-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,oracle.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 766BD3985DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/2026 12:44 PM, Harshitha Ramamurthy wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> AdminQ commands may return -EAGAIN under certain transient conditions.
> These commands are intended to be retried by the driver, so logging
> a formal error to the system log is misleading and creates
> unnecessary noise.
> 
> Modify the logging logic to skip the error message when the result
> is -EAGAIN.
> 

The implementation changes from using dev_err() to using
dev_err_ratelimited(). IMO that is a good change but it would be nice if
this was mentioned in the commit message.

Thanks,
Jake

> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_adminq.c | 26 +++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 08587bf40ed4..c7834614c5f0 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -416,11 +416,6 @@ static bool gve_adminq_wait_for_cmd(struct gve_priv *priv, u32 prod_cnt)
>  
>  static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  {
> -	if (status != GVE_ADMINQ_COMMAND_PASSED &&
> -	    status != GVE_ADMINQ_COMMAND_UNSET) {
> -		dev_err(&priv->pdev->dev, "AQ command failed with status %d\n", status);
> -		priv->adminq_cmd_fail++;
> -	}

You also now log every error regardless of what the status is since this
is no longer checked?

>  	switch (status) {
>  	case GVE_ADMINQ_COMMAND_PASSED:
>  		return 0;
> @@ -455,6 +450,16 @@ static int gve_adminq_parse_err(struct gve_priv *priv, u32 status)
>  	}
>  }
>  
> +static bool gve_adminq_is_retryable(enum gve_adminq_opcodes opcode)
> +{
> +	switch (opcode) {
> +	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /* Flushes all AQ commands currently queued and waits for them to complete.
>   * If there are failures, it will return the first error.
>   */
> @@ -482,9 +487,18 @@ static int gve_adminq_kick_and_wait(struct gve_priv *priv)
>  		cmd = &priv->adminq[i & priv->adminq_mask];
>  		status = be32_to_cpu(READ_ONCE(cmd->status));
>  		err = gve_adminq_parse_err(priv, status);
> -		if (err)
> +		if (err) {
> +			enum gve_adminq_opcodes opcode =
> +				be32_to_cpu(READ_ONCE(cmd->opcode));
> +			priv->adminq_cmd_fail++;
> +			if (!gve_adminq_is_retryable(opcode) || err != -EAGAIN)
> +				dev_err_ratelimited(&priv->pdev->dev,
> +						    "AQ command %d failed with status %d\n",
> +						    opcode, status);
> +
>  			// Return the first error if we failed.
>  			return err;
> +		}
>  	}
>  
>  	return 0;


