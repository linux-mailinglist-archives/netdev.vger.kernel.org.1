Return-Path: <netdev+bounces-208648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B46B0C873
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 18:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F046C5164
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5502E03E0;
	Mon, 21 Jul 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJUk0H7O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C660283FC3;
	Mon, 21 Jul 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114416; cv=fail; b=ZwlTjMwkGu48nM8tjGf3sL+QAaAcDp8LAb+Jm7OOF4OK/v0KCpjTPHwG8MTDJZyGgGtatgUAQBnJPOWzkG863sVQs+rO23yASkOQLEBZhHpDd9Yx7UTXEziWTFpl+HS9SkhKs72RO6QjqU5sOR805mZJzF9O0fAWiPy148LihVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114416; c=relaxed/simple;
	bh=iKxdJMdUJkqzXzEY1TOJmCGhmTmYV4NP2rF1MmtTnkw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjDtXE94Syf19LstSQcuRY0vxGM7yueVimtwEjMQtQICIOgBOMaZ48WR9m8QSobvEN6SiI1u9nJ03zgdHc/ZHwus1L8hy9Tq8jchdm+ZR+UXfEMIZrAI8Fccif2bbe04cLnbgK6aravbBDGZ49ZzwBBg9YK2VVZG25yA1EiEZfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJUk0H7O; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753114414; x=1784650414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iKxdJMdUJkqzXzEY1TOJmCGhmTmYV4NP2rF1MmtTnkw=;
  b=LJUk0H7OIwEg+cQ4MJ8KcJUD0RjqMWXxRJVf1aJYw7s/nMZUB5EUyL7o
   z4pEZzmwTF+bh9/o9Qv+76iEp7uPCqu5bm0MYWFkPlzYYIqUCYoyZbf79
   NGyjmyyBQgZqMN9iwAcWxBGidwJ7T77nCqfUETRs79zULWPschy2CULPn
   8UFJFIUZEOsGQUj7RX/1UyCzz2M6CDUs8f+mW9qgec7RqY4Os7N8qlna9
   PEsnob4CrQF4dQS1LOKDm9sPvL5+b0i05fd/9e4p4TF0P4x42SXykmVBu
   14VxxAdWTNCQyVbNOJ8zNLU+/8MctDqpdSRYY3kBjKoIy0ZnFNO9I5n2D
   Q==;
X-CSE-ConnectionGUID: Bm+r+QlhRiuS/6CDLqdtgQ==
X-CSE-MsgGUID: pUodruMpT3KpypLh1onI1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="54549629"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="54549629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:13:31 -0700
X-CSE-ConnectionGUID: MaDLknIJT8uc4co9XnTIgQ==
X-CSE-MsgGUID: USCcqzFSTYqL9S5z3cpSew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158936542"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 09:13:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:13:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 09:13:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 09:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NstuzTcn4HLWWAILL06EBgS1lRKUjVz8hggvHcot/4Fzb430wYRL1B7o6h7cKeOCGv/rY7yFzObIEbJnw3gXsORNwkBQjYWVi9GHCAC6lBuR1258H623Jb/mOJ+ejaEDph8Cxiv6DfLjBK4uKx7c26myfUZQbI7uoTN4/704vTZM4meiIGQ5wtchOzGymP8NhAvgC6IECjW083BSg86Bdq9MloP9MlNsUfvGoXA1BjJWD9/xUoO/oDjnX+4HUsgsDQbXMlSQ1F+IllqImpqRQzK+iKNA3raQFi4I58lKNJEueXnkvQg+xlA1Kilw2zKWcTRcfNZomIDWpOz8haHG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Juc1fFjnAm7bj6Mf1qTuvzRvftXufolXSCYp81JgUrw=;
 b=uRCDlCjE/trgPIg6TZfl80NKgL55GosxXleq/LCHdWbjNSZgR3hjleW5NEWxMTvzvVjaSGkpWZQ/qz2HRqnhNnHmlPIVMj0m8+q4AKRAQD/SIuPFIdNLLkz89nzE8jJxTDgjfGW7+W7TSL0/953szS5xoq/mBYPL9K6EGO2rah6uNQXj0mkHzNjGY//xIiVbb4+lPSSvq3GDCU1SnU9KNC1rjvKbHLB1BXcdV7xcJrmesxoICl3cwkkH5CXQzwByn4WHULFbZ6pzLzT9LGnhGyimUQUcdGOfvzCzU7CsFZmhmawpU/G3XpB/Dt/fezZvlbJSciUZJbc7V7rykBn2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:12:58 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::24ab:bc69:995b:e21%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 16:12:58 +0000
Message-ID: <771a5d37-68e5-458f-91a1-c9adce337f72@intel.com>
Date: Mon, 21 Jul 2025 09:12:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove unused
 fields from struct ixgbevf_adapter
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Yuto Ohnuki
	<ytohnuki@amazon.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250717084609.28436-1-ytohnuki@amazon.com>
 <IA3PR11MB8986F59CEDE4BF3B7994241EE551A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <d4144828-f266-4a57-a78c-55a3b20b8cf7@intel.com>
 <IA3PR11MB89861BE40BCCFED551B067D5E55DA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <IA3PR11MB89861BE40BCCFED551B067D5E55DA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL3PR11MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 4332d6be-312e-4774-d73c-08ddc8717531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amJnd2RrRDRLeUkwcDMvdStqaktRejVOcWljd2VJRGl4NmVybXh4YXhnZks3?=
 =?utf-8?B?cDNjTG1DSVFpOGlGWWhvQTc2bnFicTU4MktSNksrKytjT05pbE5XWWNKcWdw?=
 =?utf-8?B?djdWMWozb0RSYlBvMWNyeGhpMjNvNjNpVFYwa2Y2TWJ5YXNPaG9RNU8xOHpp?=
 =?utf-8?B?bW5OV2NRSEFVUHZzazRYVC9HNWYzMk5GNUU1dzBCdnVNN2tnQWRlcjFMckpr?=
 =?utf-8?B?RG9pSklyV1AxVFE2MXIxTWQzY0ZQVVV4VzVXU2k2WjBRQ0lxaFhOOFJ4NXky?=
 =?utf-8?B?amNIVHFZaFUxYUVLdWwvTFdrUHdBb3d1NUpIT28vamQzOTEzOVlweVc3ZmEz?=
 =?utf-8?B?QUxOd09jNFVPRndKMEdDd3RMSHVUenY5VllleGVPcGlvZVN4NjVIcXIwcDFl?=
 =?utf-8?B?bXVLR05zVzBVME53S0ZyVTJLOFQzT2wxVDlGRG14OEpaNlU0djBTZ3huazlx?=
 =?utf-8?B?dnN4czc4MDdaM0xsMmVJdlRzOVV6ZkdZb1VVQk5MZndmR05GMzVHS1oxZUR5?=
 =?utf-8?B?WmswTG9oUEpBRWJUbCt1NFBxTmVJZWlNKzZZQUpiQ0d5QlZSeERqT3V0OTFW?=
 =?utf-8?B?MmU5MTh2dXRTNlg0dm81ZFNjZGh5QmRxUE43RTlmNUd4cHIyeGJ4bmQ1UC8z?=
 =?utf-8?B?bnUvbkZTbnJqaVV6NDJ0TEFCOE5sVytsbU55eWU4WnNwdDRocjhlbkZoYURG?=
 =?utf-8?B?aEllajRDc1E1UjlKNmZFK294RHJvVVpNWjJQZ0JzZzN3SFJyS09UTzdHaXhQ?=
 =?utf-8?B?bHgraFMvdklwNndkU3VkYW9UeHh6VitsLytKYTZrbEd0YmxLRjdLSm5LZUY2?=
 =?utf-8?B?Q0dxTjVwOGhOZ21rN2tJaXdRZWZRY3A2TFV1SFpLdUJWWmpGT1NGZ2NpTHd0?=
 =?utf-8?B?aDhCanU5dVZ0Q05kU0k4dG9BTjd5bzB6MmNRYVdZY2RCeTlXV1h3VXdrRjI1?=
 =?utf-8?B?dzllRmZrUGp4OVdkdEVjY1gvSVNqbWlUek1FbVhKcXlENEpQRWNrOHgwMFRD?=
 =?utf-8?B?QTl6SG55Q2NaR2llL1hJVGNVZXVuQXlINUQwVW1ZODh0NzJDQmVCNXpGZE9R?=
 =?utf-8?B?OTd6TU05VnRFWFNtYmdJNlpiUy9TT1kwSkhnWnl5ZkorakNWTlJ6Y1Z6OVQv?=
 =?utf-8?B?Z0tHQXpUVG5GS052VVlyNTE3WVdxbGZRUXRJNXljc21hakJRbk14NGpTOStV?=
 =?utf-8?B?TnJyMS9aZDNLYWFmdW8xNE5Nc1A1M2dVZkdiS0hkQVdKLzRhbEFRQW43cWN2?=
 =?utf-8?B?OGJvUlN3b1V4bUZWOFNzbC82QStSdG84Smk5R0FxL00zL0srQlhnZzBjVFIv?=
 =?utf-8?B?T2MzSjBQZnRwR2hWeGdEMVFLQ2t4akFWQ2dyY2xDOHFYOUIrV3BKSHl2REEx?=
 =?utf-8?B?Vlo1QUp1cy9zV0ZSdzZsaS9uT081NnB0amJacWE3WkNhY3dRd1FrZFJnUUtU?=
 =?utf-8?B?cEJDcGlwWFhMQTZuZlg0eHBPNHZiUnpXelBoK2xlNU9hUXNtQk1XMTZ4c0Vv?=
 =?utf-8?B?cExkTWJTYUVMdElsWC8rWkplZTFsRGhMdUxWRG5XbjFjUWdFQTN5QSt2Skoz?=
 =?utf-8?B?NXc3eUtYNDRUWXVLTlJIQ3BBSDhrck9ya0NqNlJCMnZIZkpla0NWU0Rrdlh4?=
 =?utf-8?B?K2srVDQyTHBuTWQxS0dYK1g3U3dua1ZJWEpicktxTERtREJjODJUS2oxWTJz?=
 =?utf-8?B?UEhSSE5BWG9BekFpK3pJek9KQU96Z3p2UTBPVmRjQ1FhVmlIUTJNNW5qZ2M2?=
 =?utf-8?B?aTRlam8wTS9XekdUVmd1cU5SSDM1eFN0SDdOTG5CMUZhRE9Sdm9MUmVPYjk4?=
 =?utf-8?B?OWd4Z3FZaThGMG1CR3lVMEFZcktPVnhYaFlRUVJGUktMMTlDRVkvbzlybHNn?=
 =?utf-8?B?dHN0eXJ3RERqYWh3TzRBL3gwTkI3VjZIYnovS3FyZzBES1JMa2JVWDVJZ1R6?=
 =?utf-8?Q?AqTLjrmDGQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlLNEtzUHFZSllrVTlCLy9aRjBjQTcrWTJWVVZVZHcwanNmMjRnSUpCaEpI?=
 =?utf-8?B?TG5ucE5KSkd1WnpxaG5iVDBZaVRTTjJCTFF0OGNLdXVPdkhBTGI3NG5nd0xQ?=
 =?utf-8?B?dTRaZ3lwdVJ1S0JlSHhoK3RqUldsNUtDdTB5RDFyNHVvMEhtL0UyVDEwS3pz?=
 =?utf-8?B?ZzkraWdic2MwWlM3VTAreGU5YjdPSy9kVk5HcVR2aWhZVU15dVpsb3FvS0Iw?=
 =?utf-8?B?anJOZEcwMm9Ec3d0M2MvZnplSHN3YzlrRlpYSm1IcXZVWFlmcTNqRVRpSUVE?=
 =?utf-8?B?UXlKRzhrSEJHRHV6UnYwK3Nnay8xQ1dzUTE0SDlZVWpuaUJkbnh5TURYTHpS?=
 =?utf-8?B?SHl4dzFwL24rZ2xhOERqMGc3bkhOQk1vU3d3K0oyQlBMOTA0LzV4eGtiZ1JW?=
 =?utf-8?B?UVFjbnBPVWpMeDc5bVNoT0FFdGtWdWh6M2c2d205WnY0YnVYVCtNMVRFR0Uy?=
 =?utf-8?B?L2F1ZzdhQ0pvVUl0ZW16MWlkdVdXeTduaWJJU01ENHVBOUZ4N05VL1lKSGRh?=
 =?utf-8?B?cVRwcUF0bmlTQzlzaWVzZUR2OFlQaDVEQlBPYXV3SlU0bWVmOWVHdVlKeFdn?=
 =?utf-8?B?bUYxbUxVWVVFQ2NvM2RDZ0lCdlNsQlhaeW9NN29zUHdjcVRPdTBDZ3pieGNw?=
 =?utf-8?B?L0dYZ2tST3M5ZEd5ejVYMlJwQURtQThiODZKN0E3NHJqN2tCUTVOaE1SZjU5?=
 =?utf-8?B?VU1mWnpuTWphQVI4aWNodmxJMWV5a1Q4T3JhSnRTY0Y5RldPTHRaWjFVcmxP?=
 =?utf-8?B?Y0tZWWNJb0daaUpqYmFucWsyUnlVZEtpMzdlbHhXTGdVQitIVUowUUg2SGpq?=
 =?utf-8?B?MWdrTW9mRjlOd2JwQUFDQjZwd09xb2U0T2pHZjlBQmRUTkxEaU5GZ1B6dUlr?=
 =?utf-8?B?NDFjZ2pocHpodW9aL0RkMkR3c0hNN3BiS0h5T25QNHNMbGE4ZXg1eGRnbnBj?=
 =?utf-8?B?cXdja2htUUZTYXdWakRPNEZoT1BIMDNuK0hyZ2FoSXhYTWhjSXV0c2IrVERX?=
 =?utf-8?B?YVdROWxXR1FOWUlpdUZZTS9DSnowRmZRWS95TXpibXpwTGI0Y1M4OTl2RVFT?=
 =?utf-8?B?Q3I1ZXpCREQxV3RWNnU0cy9DVUxZQ2w5OE5RS0pPRTdhbXVPZ2lPTGs0NC9X?=
 =?utf-8?B?Z2pmcWUwbWV4TlErSmlnZXlWdFRsc29BeGh1bVpnL1ZTRkFNS2U5UjZTcGNz?=
 =?utf-8?B?V29mcW4yVzRIeUpZZ0lsSzBVa1lFMGhrc2I2bURQU1JKZGdYK3ltVWJMcG0y?=
 =?utf-8?B?dVg0VUdOdWZyZC8zMEFUTjE2emQwWkkzVkZqSnJmaXNWbkpzN0tsazlLUjdH?=
 =?utf-8?B?Ni9sOGZ4R0dEcHd1SUQ0akFTU1E3K2RuV1FoZTNZSXJiajhNeGhTWGNTRDZm?=
 =?utf-8?B?UkNPY084THU1TVNzR0FzQzN3ZUpxTHUycCtTa2YvbXJ2RXc3ZHo0OXVsWGJ0?=
 =?utf-8?B?dkpwblhjcHBSb2YrNVNxemEybURPTXNLSnVCYThwQzJTakhNREJNd0I5TnAz?=
 =?utf-8?B?WWg3SG9FZk1XNXhUNWhHbGdjMGc3dWV1eTcxU0JXRWRUZHB4bFpoc0piNFhr?=
 =?utf-8?B?cUN1aDBZL3RBcnROeGJRL1V2Ui9ic2FEQytIaXZSQXBZbWNCa3ByRVpzTENy?=
 =?utf-8?B?NTRBRE1HYUpST1kzUGdTUUlYWGRJMGdVRGRSK3FiOTRxTVhtMEMrSDZGUEZq?=
 =?utf-8?B?ZnEzaW1ZMUczMTBNMXBiT3V0eUk5di9XZ3BxaHdycEl6d3JQK2d3azVPSWsy?=
 =?utf-8?B?NmJaTUVlSzVJZzZSR3l2djBvK1phNVF2ekRyK0w0cjYwVks4QUJkeitnanp1?=
 =?utf-8?B?MjFNTDBFWnVTM0lNMmpteTJ1RDhaY1VXZnBoOEJjUXNzcjVRSHQwMlpOVUpv?=
 =?utf-8?B?Z2VLd1FjZitPemZSUDg4OGhzSHVWM0JhOXRsdjJhekp5bCtMUEl1OXMyRUxj?=
 =?utf-8?B?bWNqaVR6V0VtK0lRbWRIbXRSTGIyWmZFSDBOSUtGMGNFM1NNdi80YlJjS1lu?=
 =?utf-8?B?eVliOTc5dHpEWmF3QXoxRzE0RU1WaTA0M1hxdmdJNGVLRWsvQzYxR2xSMVlt?=
 =?utf-8?B?aUR4ektaVkhiM1dod0tSY1oyZTlITTZORm9IL01vTUZ2aXFRalpzMkJwOUdS?=
 =?utf-8?B?QlNsMlpscmVSM3VKRk5Eby9PMjZOME44aGxmSHRaUmZBa3lsZWFDSEloNzhX?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4332d6be-312e-4774-d73c-08ddc8717531
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:12:58.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9J5AUKR+rhF81Q+ETfkir5odbucDzWwdcIcmLyj70g7jidXF/VBkH7knelV+c9HAiV8Y/LpN+aHSrNZGqjieWSvs8VofNQxoNts6kLqrQyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com



On 7/21/2025 4:47 AM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>> Sent: Thursday, July 17, 2025 10:08 PM
>> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Yuto Ohnuki
>> <ytohnuki@amazon.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
>> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove
>> unused fields from struct ixgbevf_adapter
>>
>>
>>
>> On 7/17/2025 2:33 AM, Loktionov, Aleksandr wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
>> Behalf
>>>> Of Yuto Ohnuki
>>>> Sent: Thursday, July 17, 2025 10:46 AM
>>>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>>>> Przemyslaw <przemyslaw.kitszel@intel.com>
>>>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
>>>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>>>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
>>>> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; Yuto Ohnuki <ytohnuki@amazon.com>
>>>> Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: remove
>> unused
>>>> fields from struct ixgbevf_adapter
>>>>
>>>> Remove hw_rx_no_dma_resources and eitr_param fields from struct
>>>> ixgbevf_adapter since these fields are never referenced in the
>> driver.
>>>>
>>>> Note that the interrupt throttle rate is controlled by the
>>>> rx_itr_setting and tx_itr_setting variables.
>>>>
>>>> This change simplifies the ixgbevf driver by removing unused
>> fields,
>>>> which improves maintainability.
>>>>
>>>> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
>>> Can you add 'Fixes:' or 'Cleanup:' tag ?
>>
>> As there's no user bug, I don't believe this warrants a Fixes: tag.
>>
>> I'm not familiar with a Cleanup: tag; on quick browse of git log, I'm
>> not seeing one being used(?)
>>
>> Thanks,
>> Tony
>>
> Good day, Tony
> Examples of the tag could be get: git log --grep="^Cleanup:" --oneline
> ff9fb2e Merge tag 'samsung-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/soc
> 15b5b76 Merge tag 'samsung-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/drivers
> 566d336 mm: warn on deleting redirtied only if accounted
> 35189b8 kernel/acct.c: use #elif instead of #end and #elif
> 0bbe4ce iommu/amd: Fix the overwritten field in IVMD header
> 521ec1c Merge tag 'renesas-dt-bindings-for-v4.18' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt
> 878e917 Merge tag 'renesas-dt2-for-v4.13' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt
> c3acc32 Merge tag 'renesas-arm64-dt2-for-v4.12' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt64
> 8855e14 Merge tag 'renesas-dt-for-v4.12' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt
> 5344df6 Merge tag 'renesas-arm64-dt-for-v4.12' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt64
> 837a90e netfilter: ipset: Regroup ip_set_put_extensions and add extern
> ...
 From what I saw all the 'Merge tags' are using this as part of the pull 
request to categorize the 'Cleanup:' patches. The other patches are 
using this line in the commit message to explain the cleanup that is 
being done. I'm not opposed to the latter, but it seems the commit 
message gives a reasonable explanation already and I don't think it's 
worth respinning this to repeat, or reformat, what's already there.

Thanks,
Tony

