Return-Path: <netdev+bounces-150877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3F9EBEA5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3731883697
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D02080F6;
	Tue, 10 Dec 2024 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlmcKeqw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EB21126D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871211; cv=fail; b=hguY54Kn0ghv2Fw/J40dp15R9CRtDU7GWqTVP2SGgrKV9WvM+wDS482wpBXYg74/L3VtC2u7TnoRUZJGlhVsXeOVz0ja/79ze7kQjJWdfZxI506ZPScnj/Z2jskS3rGUS5pkYMWHJg/LACn/6pjh5OFEipphOEsdnrXuRxhtEBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871211; c=relaxed/simple;
	bh=HxDuQxS+lKUlFa0aC8ZoxVBUxGlaQgRGYtdzlyZ3Bww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L8DjFdhcpoOM3RpnP7OCYcr6arQmr65CxbwXuQG2UdxtsL5S4PEIcOmajBDRYHPLbiFKjM5Wp+CSzVQITPNToBa1IxLHuMjab0pkyT0Sxt9ADyeal1vHzBt5oYF8FQYWiws+qdbEXzFCAP0CdNvAGFur3MnXRudXYADCdQ/sAus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlmcKeqw; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733871210; x=1765407210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HxDuQxS+lKUlFa0aC8ZoxVBUxGlaQgRGYtdzlyZ3Bww=;
  b=jlmcKeqwngC+wZOu5PopYznMNYHYrGMhc3pMZtXRIXjkb6nMXPPWU4zn
   fHiUsBlUzm/6An9DttRPbip9qUCqLyRdqPkzMuQQrw88f0t12XGur/4sk
   FKuT+f1yB+JqpQqebzA7DRprX0hyNw/hwGEPUmXU7149Txvt+3jaVRyue
   JvF5VxjMC3RHP7zJQi6B4m/wys33gJwCxtekufInnVC7vVLFB+UqdsLp/
   1EoquvqPFFlj+CAQbkyCHX/psX3rfb5KaeRACRBAYl9bzF2xOvEfaoWKI
   1+7rQjEMNJbHddKPRJjlV20xwxE0VEE57WcRItgeq1AVjiSlCcrD6ImHd
   g==;
X-CSE-ConnectionGUID: 15jpJLMaRkqSsCQQluRwwQ==
X-CSE-MsgGUID: D0q1/axqRTeoRvuYNgWXMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38018484"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="38018484"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 14:53:29 -0800
X-CSE-ConnectionGUID: vypgsPcIQ8m8+fnFQQg0/w==
X-CSE-MsgGUID: WiLnG/ELTPiEqHXnX5JEHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95625146"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 14:53:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 14:53:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 14:53:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 14:53:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj6jYUGxraZpQ6M7zKvBKtt3PE0BOYd2DnFYwdIGyylsHuzcEFbZiCzjTTeT1FhaboXipXW+taABkOVTfIVZHOBnVgf6uwEpPk9+CGL6OdekZRdL7jSAYAtLKzkQSngvhWlV2ZMSrjHPDwkFbwwYTwXx3kXq3t/lhO/3z9x/xf8B5ci2fJo1RoWoaraAcJqitfRSfq9AOpHhKqLZMdGwFhHXJCTeJACXG8izq0MhmukvgcXM/TYPVMlKl4BWypCXH5Z5+U+vUQUgUdGeiqGExwO88oEiu9ZF+ha9Fj7m2w2FsXHZeHE+lzSMw0OpNsjEjBUMSRg7jZW/fRcPhAvfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egHtzBfmwkh2Rb/bTa8onKrd/syu+44vepePEHrZfcE=;
 b=B3gpLSVvi3HASNxTU7ks6loRxw9F09Ggd3MpC/xHMUaEPuZUgREPG0lZew5suCYmjycx1ycyN0EQVFa1roXzKaz4+Hwv674W1E1GDm3jWXCmeVR3yTOn1DIK5XGaDliHr0BLuk23DbNR5jChnKgzoTaxxQooghWTdaO2YChUHoAU8dkwxd/HuZADbotoAI8aimYHiRQQivEtCqnRj0e3BnfIfKg7LyD5pjPxlHq1C0iuJ1EOGN48vn/jvoIaojRi10SILf8eECS3DvxBot3kJwb6aYVwnVLPUn2+WAT/+tKcc7ZBX9virN1peubk/gi3mlmR3f4QE3ORaX7OhZPHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 22:53:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:53:20 +0000
Message-ID: <4acaaf9e-211f-4bc3-9886-a05cd5d0e7c8@intel.com>
Date: Tue, 10 Dec 2024 14:53:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] ionic: add speed defines for 200G and 400G
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-5-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210183045.67878-5-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd028e2-a355-4b27-b8f0-08dd196d714b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXYvemg5Y25WUmkrekg5VitTbm1XYzhoa2lHK2g2MVRrWVRLVnBhWEpWNTNx?=
 =?utf-8?B?VmJpQml0QjcyVjVYVXRsRWFWY1NhWitSaG9Yd013MkNsa1hKUU5ObkpST1Vi?=
 =?utf-8?B?OHBNRVM4UlI4WXhlWjhnVEo0bXpuS25uN1ZjVVlPUHJ6UWI2Nm1sMzc4UmRp?=
 =?utf-8?B?L0dHMTNRSzE4UlpwaDlQRjczcmZYL0xsaHdLV1JPYUp5ZDdaNFpXUkRRY3Fk?=
 =?utf-8?B?UktsNG90SkJBSWZYdXZ1aHZNakE2c2NrM0JMREtXS0dSSnVkZy9JeTg1dm5i?=
 =?utf-8?B?WWFHYkUxSERTYUFUWHptQWVZNlRFZlRrdW5pdWdFa1FtS1pGNlRtd3V2Y0Mw?=
 =?utf-8?B?Q1NtMUhIaXJVRDgwRmlHdEkwSnVlSUJhbE9QdXNYQTlqWDh5WVI5c0lUMFhF?=
 =?utf-8?B?NzFiSmhkSktra29RK25zNXVzK21wa2pQNksvSmtvRWpOU2RoMHlsRmZaOUJC?=
 =?utf-8?B?dHpCL0JCUlRsZ0duZlB0b2NPY2FWcWIxcWN3SDVNanh3UTlZeXZqalY5cTFB?=
 =?utf-8?B?Y0lRQ1RpSlBNNVh0N0VEcy84SlFFb1JJTUdMSEhhdk14ZG9TenE1Qml0UWp0?=
 =?utf-8?B?Z2w4S2twZmxHb3BHQXZackt0ZHV1VTJwaitNRDJGdFNyUjNDUjIwbmsvYVZs?=
 =?utf-8?B?Tk90STg1YVA0U1UweHErdzBpY0xuSTZJeDlDd0pzV1YwaVBSSE5YR3EwTlNH?=
 =?utf-8?B?bHBLeEdKSFlvclQwbUFvYUlIUFQ2b1k1ZUgybE5LSzMxR0VhLzA3a3hCY20v?=
 =?utf-8?B?Y0lva1gvZWVhM0czR2FYWWYyUXkvOVFRRHp5MncvUW1uYWVVUTF5c3NXZFBp?=
 =?utf-8?B?YjAvdHZWTVMxUGJjZWFJK21VODNLZTJPYlVJOElZVWR0NnVrTWxob0FOcERM?=
 =?utf-8?B?WmJkd0ZRR1FzTGFjVVZ5Z2JFMW5vbXR1cFRzT1Foc0NJMDBQSWdFV3lXTWxp?=
 =?utf-8?B?NG9QK3dlUTIwSUtGYVhqVkhmbjZUVzhUT28zK1JPbzBXYzV6dVFpaW9lMEFL?=
 =?utf-8?B?QVh5Sm9KaEN5MmcxZWxnOFdjcXBOeTkwMU80QVJvbUNsUSthMHdpakJYbFl4?=
 =?utf-8?B?MWRnWmpCTEljN1BvUzg5c3dLSjFpNzhqdGpaUEhHSitxYXAxR1dPUTBSUlVR?=
 =?utf-8?B?NTlBL0diaFBlbXVGTnlpemsyRnp2dHp0S0VUWEFwSmgwZSs0LzFqOVNjN0dG?=
 =?utf-8?B?KzdncVA2b3hKWjdXMk1jUWUyOG5oSGpjUmhVMEk1WEVRVS9NbklKbFFSOWx3?=
 =?utf-8?B?SzdMWlFlV1lsU1Q1OVdrVHhWNXBoUVMzZXZvWGRteEgwZ3E3aGliL09KaXB4?=
 =?utf-8?B?SFNNb0Q4STJKdEJTNDJjbnJGbHRHTG83NkxhNHRUWHd5NmpaL2puaXB3WUps?=
 =?utf-8?B?SG5FRXlvOStzdUxlVzRHQXBObXhhbUhERk13QUFUZXBMWU51ZkV0bG5nTUIv?=
 =?utf-8?B?aStHMENEaEprQ3g3TnRLZGlrTGtRQ0doZjM1aU1ITzcvekx3MGtMUFlYSm1o?=
 =?utf-8?B?b2FjV3plZlN4ekozL0F2cmJIaDN1ZEJhVTVnMTFGajhYMjVFUUMwRHdXZTRI?=
 =?utf-8?B?Vm5GcE1SLzlYcG1mZkhjeVZheHNNY1ozamdhZHBDeEx0TDJYZEl0ejZGRm9m?=
 =?utf-8?B?YkQxdnBLTy9oWm1vcnpWd1BYSjdUbnVSR1RDVVdOTkREVnVVRndYWFZaY2dW?=
 =?utf-8?B?TjUvNXQ1TTk0TmU5SGNWUGpnRk1DaWkrRmd6dHRYWkczbEtzaXFzVXUyWmU4?=
 =?utf-8?B?QXZnUUczSUFOZHF1eG0vMmVVNTRBRHorZEhITGpnOGpidTRtMjkySzNLeFdE?=
 =?utf-8?B?eWEvVDdIWWxHYmg5NVNBdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmQ3Y0NhZS9uN3F5WHNYREw0RmhpYndxWlNIVGdvZERXMGNqcHg1S2QzWGds?=
 =?utf-8?B?L1FSWExqWDBVTDNvOHNTVFVUanZaa0VCRE4xWWxCMHF1NVFXN3JtbW1iU3ZS?=
 =?utf-8?B?b0pnRVRRNHJ5UGdKUnhxMGNBZWVjU3R6aG1wVlh0TGxsTXFOWnVqSTVPb29J?=
 =?utf-8?B?d2xDWkZVVlFtRStqWnBGems1Z1FnZDBXNkdNVkVKSUNkcHc5ZkdUaVN5WUQw?=
 =?utf-8?B?YzVkUnZpQVdISTZqZU9SclA1U2pjem1Ud3lVaHgyQVRYMEpVYVBoQ1F5WWVO?=
 =?utf-8?B?cnNyYTY0MXZCckUvV3FOMzhlL1NuVmRXYUtCUjA4a0FuYTR5ckdNb1NRRDFk?=
 =?utf-8?B?ajRKV0RXNGdJdklzaHpmVHZ5b3I1QXdlTC9SbFl3KzNoL2xnalEyWUVWenYv?=
 =?utf-8?B?eXdjRWVrVHZWTU1idjdCaElONFlIcVdYQ1NDT0NaQUhBbHhISVYrbmJhRkVy?=
 =?utf-8?B?K1Y0aTZFYStaRjRhbGthQk9uVmI0RXhXK1NlcE1CV0V4UUFmYjNkSlVuOXNR?=
 =?utf-8?B?TGxPS2o1V0MrRGdwUmdGc0JrTlIwM2x5MG1kTnU0cEw2VVpjcEY5aW5MQVJD?=
 =?utf-8?B?ZHh1RkRzS2hxVGFFNzVYZEtGNzNxdk9GZERmWTZsTXBkdkxuSmxmcWF4bkxU?=
 =?utf-8?B?MzZHcW9MVGpSVEpjWmJvT3pLRG52VnpQVzQvemN0empEOTVPTmNCck9qTVZN?=
 =?utf-8?B?U08rM2FRNTd2N3dGTzFkNW5CZzY2VjdPNTNXTzZWYzdBUWVpV1UzaUY0Rjhu?=
 =?utf-8?B?TVA3NTRFcVBhZDZiWVE0bzQ0ekJnZmVtV3l4UFpLMWZ4OWs2eTBFd1dUbTc0?=
 =?utf-8?B?ZUx3YkZNQWtDSjJ4NzlWMGlUNUVrVmtGOUh1MFI5ejlENm9nZmFPS0hSbzFR?=
 =?utf-8?B?L3hJYnBjSzNtQ0pyOXdxTGs5bkhQelh4N1hrMzVqQTZRSGMwdUNJVHY5Mkxw?=
 =?utf-8?B?YVdoOTB5OUVoVkJEMExmNmFBaTZnS1hqOFArTkRBeFhYTjQvSHIvQUczM2Jt?=
 =?utf-8?B?OTByL2pHMUdadEV0RHF3dW9vR1NHdDJ4QmxLS05WOTJrR2JRNUtCZ1FLa0Jq?=
 =?utf-8?B?SmtlM0F4K2FrckdZOFI3V2dHVkFlUUY3U2RSb1V2VUUvdGo0aGJZdzlxWVc5?=
 =?utf-8?B?U3Vrc0tPL3hBQVpCa1VEc0diSXRhNnQrbXJzZXNSdUdqN1hvTjVQcjUxRWs0?=
 =?utf-8?B?b29nclVSRjZpVHozT05ZdWZQQ0VDQ0k5U2hpRmFQcU95bUhQd2M1TGtyZk9a?=
 =?utf-8?B?cUxUMWhXK09jaTQ1ZUhTLzhtN3dQQW03TXJYVmt2MjhXcFpYNjlzVkhzdzFM?=
 =?utf-8?B?TlFva1FMTzRyV2EyRmY4cUtJeUZucEloR1VHcThnMTRNQ0VqYTdqRnEvU3Jy?=
 =?utf-8?B?OHVnU1lYQkxnVy8wT0ZFRldBdEtyZE1vVlBkYmNxSWkwU3M4K1BCUlg1Rkkx?=
 =?utf-8?B?a1BjTHVmTHlLaDZzekY2a2g3aVNZR09qbnc2Z29mVEVkWENYMzhSTWt5LzZD?=
 =?utf-8?B?SnNWdTlKV3VZNTE0VjdxdFdsRkVJOFlFeEtYSEpyWE5XM0VpMmZKOEpsTkJ3?=
 =?utf-8?B?VzRKRDdnZjhVWTg2RFdEUTM1Zjc4ODJFWUNZQmJaSVRZVjRtajJmYXhnRHdm?=
 =?utf-8?B?cGs3N3hKak5sTmJ0STFKTzZ6RXVDaG5xTWdIb0grV3JqQTZtRWdvSUtiSzlU?=
 =?utf-8?B?MWNDYXN3aTNtcTFGekMzeUpWVFkxeE1mVE9pWktBTHlkb1VOdHd1RlRJM2xI?=
 =?utf-8?B?R3d1azNCUXZ0dTh4RVVwckRZbWpaSHl2dGd5Nys5TDZwM1FWbHdTc05JKzFw?=
 =?utf-8?B?OXVkRllMRFBHVGdHU0pPa1JYYi9EOUplbm8ydnBDYWFsdnZVVVpwNVNLMS92?=
 =?utf-8?B?clk1V3dvN0tmZ2xZdTVoRVlhZHRBNVN5TG1TQ1o2YXhSYVJvREpqYjVxdFNO?=
 =?utf-8?B?RzQvTStaNzZOMU9iSWdBUVdmakFTN2swd2JUc1hTUWxaTmJUbnVTUEVZMFpY?=
 =?utf-8?B?YkZwdW1nZlF4RHNxNDI0dGZ1d21XbG01aUx5ZkNHKzBST1piZnhMZXd5SVl4?=
 =?utf-8?B?bVRaaVlWNjZ6ZU9ZYXNPZ3Zlb1ppbUk1aW9tdnJsaVlveUpraEtIZWlnQTFB?=
 =?utf-8?B?TGtPajdTSC9hcnpxK3lnUW0rMWlmMTlIbk1qWDBSR0Zsd0FQbHRMUVFmeGJN?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd028e2-a355-4b27-b8f0-08dd196d714b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:53:20.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDgThZg79cdqiYM2xRLtJWfXZaAnzUS+az0GTcTzT4qrK5KkJRWgdHkUI2VjBB/5nE6LQIXOdFJ5fEKlsICNP/H1EoOgOyKFxzh/xIXLhG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com



On 12/10/2024 10:30 AM, Shannon Nelson wrote:
> Add higher speed defines to the ionic_if.h API and decode them
> in the ethtool get_link_ksettings callback.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

You might consider refactoring the ionic driver to use the
ethtool_forced_speed_maps_init interface at some point. See 26c5334d344d
("ethtool: Add forced speed to supported link modes maps"), with
982b0192db45 ("ice: Refactor finding advertised link speed") and
1d4e4ecccb11 ("qede: populate supported link modes maps on module init")
(though it looks like the latter hasn't moved to the ethtool function).

This saves a bunch of text size on the module.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


>  .../ethernet/pensando/ionic/ionic_ethtool.c   | 39 +++++++++++++++++++
>  .../net/ethernet/pensando/ionic/ionic_if.h    | 16 +++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index dda22fa4448c..272317048cb9 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -158,6 +158,20 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
>  						     25000baseCR_Full);
>  		copper_seen++;
>  		break;
> +	case IONIC_XCVR_PID_QSFP_50G_CR2_FC:
> +	case IONIC_XCVR_PID_QSFP_50G_CR2:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     50000baseCR2_Full);
> +		copper_seen++;
> +		break;
> +	case IONIC_XCVR_PID_QSFP_200G_CR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported, 200000baseCR4_Full);
> +		copper_seen++;
> +		break;
> +	case IONIC_XCVR_PID_QSFP_400G_CR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported, 400000baseCR4_Full);
> +		copper_seen++;
> +		break;
>  	case IONIC_XCVR_PID_SFP_10GBASE_AOC:
>  	case IONIC_XCVR_PID_SFP_10GBASE_CU:
>  		ethtool_link_ksettings_add_link_mode(ks, supported,
> @@ -196,6 +210,31 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
>  		ethtool_link_ksettings_add_link_mode(ks, supported,
>  						     25000baseSR_Full);
>  		break;
> +	case IONIC_XCVR_PID_QSFP_200G_AOC:
> +	case IONIC_XCVR_PID_QSFP_200G_SR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     200000baseSR4_Full);
> +		break;
> +	case IONIC_XCVR_PID_QSFP_200G_FR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     200000baseLR4_ER4_FR4_Full);
> +		break;
> +	case IONIC_XCVR_PID_QSFP_200G_DR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     200000baseDR4_Full);
> +		break;
> +	case IONIC_XCVR_PID_QSFP_400G_FR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     400000baseLR4_ER4_FR4_Full);
> +		break;
> +	case IONIC_XCVR_PID_QSFP_400G_DR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     400000baseDR4_Full);
> +		break;
> +	case IONIC_XCVR_PID_QSFP_400G_SR4:
> +		ethtool_link_ksettings_add_link_mode(ks, supported,
> +						     400000baseSR4_Full);
> +		break;
>  	case IONIC_XCVR_PID_SFP_10GBASE_SR:
>  		ethtool_link_ksettings_add_link_mode(ks, supported,
>  						     10000baseSR_Full);
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
> index 6ea190f1a706..830c8adbfbee 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
> @@ -1277,7 +1277,10 @@ enum ionic_xcvr_pid {
>  	IONIC_XCVR_PID_SFP_25GBASE_CR_S  = 3,
>  	IONIC_XCVR_PID_SFP_25GBASE_CR_L  = 4,
>  	IONIC_XCVR_PID_SFP_25GBASE_CR_N  = 5,
> -
> +	IONIC_XCVR_PID_QSFP_50G_CR2_FC   = 6,
> +	IONIC_XCVR_PID_QSFP_50G_CR2      = 7,
> +	IONIC_XCVR_PID_QSFP_200G_CR4     = 8,
> +	IONIC_XCVR_PID_QSFP_400G_CR4     = 9,
>  	/* Fiber */
>  	IONIC_XCVR_PID_QSFP_100G_AOC    = 50,
>  	IONIC_XCVR_PID_QSFP_100G_ACC    = 51,
> @@ -1303,6 +1306,15 @@ enum ionic_xcvr_pid {
>  	IONIC_XCVR_PID_SFP_25GBASE_ACC  = 71,
>  	IONIC_XCVR_PID_SFP_10GBASE_T    = 72,
>  	IONIC_XCVR_PID_SFP_1000BASE_T   = 73,
> +	IONIC_XCVR_PID_QSFP_200G_AOC    = 74,
> +	IONIC_XCVR_PID_QSFP_200G_FR4    = 75,
> +	IONIC_XCVR_PID_QSFP_200G_DR4    = 76,
> +	IONIC_XCVR_PID_QSFP_200G_SR4    = 77,
> +	IONIC_XCVR_PID_QSFP_200G_ACC    = 78,
> +	IONIC_XCVR_PID_QSFP_400G_FR4    = 79,
> +	IONIC_XCVR_PID_QSFP_400G_DR4    = 80,
> +	IONIC_XCVR_PID_QSFP_400G_SR4    = 81,
> +	IONIC_XCVR_PID_QSFP_400G_VR4    = 82,
>  };
>  
>  /**
> @@ -1404,6 +1416,8 @@ struct ionic_xcvr_status {
>   */
>  union ionic_port_config {
>  	struct {
> +#define IONIC_SPEED_400G	400000	/* 400G in Mbps */
> +#define IONIC_SPEED_200G	200000	/* 200G in Mbps */
>  #define IONIC_SPEED_100G	100000	/* 100G in Mbps */
>  #define IONIC_SPEED_50G		50000	/* 50G in Mbps */
>  #define IONIC_SPEED_40G		40000	/* 40G in Mbps */


