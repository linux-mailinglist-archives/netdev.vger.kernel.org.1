Return-Path: <netdev+bounces-163654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD488A2B266
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3370716A8B1
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E961A8F84;
	Thu,  6 Feb 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzLf5Awg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7D1A9B24;
	Thu,  6 Feb 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870663; cv=fail; b=cNrKYEqjb85tLg7nnTQyyR+EZDf5l7ZVvRvyEbEHDQnhP9KizFXmrGfzR5LLp/2nu0IWdAdbuFbOmq/qOXBjQaV0RKC1eKUecYnVvQG13g8uXbHOQ00/sjqf+aA/R/pxOR1vqoHcYrERx5nziznsWldzyVfNwxu1zk50sx5JsbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870663; c=relaxed/simple;
	bh=JOdZLxF/XW0u5Mj/Qy3/WyV3CdIiLgQl0h/YwJXTqvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tj4GZSVr/Ll6cIDCSrnNXKUJZQkMQq6f0dPq3SitJ+sVu4hBHGZUw83ygmw52UMPLUaDm6BrcAXlxIZHmrAfUsxe0JqR94I2f9NpXXlzdQnBpt9/vYJuxGFP8Bd6tElj4N2nrH99Xf595bryXHfUqsWAE0mP0/daj+lI7pEgkKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzLf5Awg; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738870662; x=1770406662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JOdZLxF/XW0u5Mj/Qy3/WyV3CdIiLgQl0h/YwJXTqvI=;
  b=YzLf5Awg4KuN+RPFSZANXgWwbWhv8HUiuxw+uWRUO1saMUZnDOcQJY/o
   tqs1XS06bFsQIPa6l+owBe6/Au+pvWj/Z8e3FJiuiCHQ2zMwzo7C1kJ7Z
   QzSyATxoOtrI7WURTo6GxLc6vgQ4/W8mezHGTJwAKfHKCfSTPCtlLZorP
   FmeU0r40YMXgOzV4xZFWmgIFQVSX8PmcUnzBXMkeRfeJ1hFSyOaNp5cUi
   rsHFSuIfmE1Gl8wv/wLiVjkeag+rOPpNvjg1KPO2bb+g77i/h2UelfQVs
   9m9rbokPmF5Qgiqdy5blauDDWFCK54CaI1rYVVcdRh31osQooTI5/GZ8/
   A==;
X-CSE-ConnectionGUID: tQPdkITHTzeSM2mPTWXN8g==
X-CSE-MsgGUID: Qp31n07nQxyj3WUxp8xQ/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42333841"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="42333841"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:37:41 -0800
X-CSE-ConnectionGUID: wCPEIV5UT1CL+JKZ8RzNaQ==
X-CSE-MsgGUID: SEsVFzjsTFOaxUYE6YHbAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111080506"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:37:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:37:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:37:40 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:37:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4B9RjqjA377iqPwVGct3X+OS4+ip6eh22UzVkOcMKliEA2OWFaDSe6l7rcv3br8YoPzTqge6pTSdSrL9N8S2PKgpUPUDdXku9TmyC+meI1dEBGC43gvj2XNf4re414FX0a5Pqyniph4hM6hwkTgvUpdc1RA921PY2F8vn1bDM6SwUZg0LA6fyRiV1nej/+4Wktt0RINCQAIjETD3vtjfukCf1Mf/ikAkNGOmmwKdm1yFXinEvwKRwEDJ+hBw4n+MRsAsU7ataobmV2dU9XaTHmz8qsqdjWP3PCIuBrk6FS+zffnQaW1NGHKl558ljrxNNqGa+HKovLKHAKLjfz6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fk8fPdlxWIqybVbwAsZzzyIj/zqhohJF3LBUV6PJOQQ=;
 b=YjzFlbImjpucNEbk/FVU4bYNUMeWlu/lCaaka0V/a6g3T77ni+C3L0YFMRe0I2HmPLB/gE5nFfHrwQ4ylE1migqQRTgXAzSc3W3xYRyIthsEvZ+nRdlC9SufqoT6UnLcQJk++1ofSgEMk8NlmAhWq7dh9Rgjn6o4N10JvRHjZtTIKnhc3h8Ty0X1aWhK3+hROz2hl1KtlNUe8KKkv+XhS0E2PEUA0AdNGdpzE5Hu8Q1Qkf7cEfiVOIrhKmVRrODfM+Iod4VcNzpVVAVIQEeDkM59zxg31pxbI4wQ99cZ7ZNRwUvtcw1a6ugljnVxETmr3gZothPrhnvRxt5xFVmDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8130.namprd11.prod.outlook.com (2603:10b6:8:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 19:37:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 19:37:37 +0000
Date: Thu, 6 Feb 2025 11:37:35 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Message-ID: <67a50f7fbdfb_2d2c29447@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-2-alucerop@amd.com>
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d815ad-585d-4705-8056-08dd46e5b64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IdEIWdf2qPye6kM1ji6VH9+fwgHkWEnYN6RzJr8pDWMWhz6MeYi6vuqhgwDw?=
 =?us-ascii?Q?8YdJvGdvdj2+b4x05RjWv16IFvEYcW59UT6eiHH6Mi0WaNPYbhc7AKX9H5FK?=
 =?us-ascii?Q?L0LbBxnTMKlFV2Cj2vlhZ/f7xUpjkPohvwHjqTyr5OIDUpITwUK6kNcbfA1O?=
 =?us-ascii?Q?k4WG/wnXsBTVeR1aXmCm6nlBTuiqlXvnnKd4Jm3BBWJHaqNMDYo8QqDaDMOn?=
 =?us-ascii?Q?2C+EN6fTbRZtvxTGBbLWX7OQUGdF0vCQCylIjL3DqTKMfpYOgeUeEMHpJIZe?=
 =?us-ascii?Q?WiBfIc1YzRmauPNod0adZox/Sz+5gEArsXBP97nBzhLEixlToUPw2nGqojLD?=
 =?us-ascii?Q?n0JHccz/50m2UUTMGbXcWVnztNMkyx2xZ/BW4UocFG3Sx4rOVdOweRqP+Hro?=
 =?us-ascii?Q?HWIoxy6G/XLpQa9yBx8hjikMIqIdM05WLNhakAqFZth0jXOKNhcg+utT7gsG?=
 =?us-ascii?Q?i0Vn3Js+jQIXL8wJ+gIgouO0pZETQXQqao4A0FwGmh3SN+M59GzQ0g0O2Arm?=
 =?us-ascii?Q?MXaS6bUjvoGLjr3XP3c9pGcrOZQC0A7Ae0IHKhU8Q8+NqlbkYy8cltvteaiL?=
 =?us-ascii?Q?aTYbDrbmJJuOWM6c+6iIw/LOkKi3UTT6m/tHEZvesT+FEm/dIlP2k0xbQ2/t?=
 =?us-ascii?Q?GUTqeQNHYXuX9C+yzM97inQm2ucKitiQ7b9IfO5v9uD2hl7SNhL/StscLV7Q?=
 =?us-ascii?Q?l8vC6qRh+upN1ps/HJDCJs8IIBSkFIDOvOj4X+plsqUIb5nmY6s3Hv0fr/K+?=
 =?us-ascii?Q?yrFT9JzY81fmsImXiPJfLHs7oKypC6Dt1lEqe98NWsu+FTB2KqLJDCh0rWPj?=
 =?us-ascii?Q?jPhH+Q77YBRZrX5MDOJdjbBGndCXnqvX6kKfvUlJEj0/Bzmw6uZZpSWK2NLN?=
 =?us-ascii?Q?xo/YiXOjSUC9R0F2PZFdBcnJu7mpFGmlfwNtKFdQjXLDpzAYR+eBR5nK8RPr?=
 =?us-ascii?Q?hVRwNVHjlmR7gQ8QZYOQYIVqwH5ZpWoZHZhUY5+2J3m5j/MhKfTBL1/DbKpz?=
 =?us-ascii?Q?rD31UfWWQ2wTF09gRYnmFY3+UdJx3yKUR2dePzjw07TowyGOBnVcYV/jWCLb?=
 =?us-ascii?Q?1+BHGDGkkv5gWNfDUbc0lULXrhJbVWk6MjQsev+C3UUekLFyOoYlWbl2KF+r?=
 =?us-ascii?Q?5jqoM2TJoAKEoRz3YWFebwmIFCk6BLWOehqefNbFQ/e1AuF8iE5p2/XtTiB+?=
 =?us-ascii?Q?HGuXosNGhLsh0q7Dup14JRtlFCtLlbUZ5i+/jsIj5ZJu9mwTOMXUmvK3nE81?=
 =?us-ascii?Q?OUjuLc8U3emADW8aj0ECMV9fA/i+qoC1t3piSe7s8bX1RiZNHOr2EcltX0HC?=
 =?us-ascii?Q?WyBl0F4rgN5srMAKhzSp1s2E5o0pEha57MXx9FxeVeQcaAckVkllaOq66jnC?=
 =?us-ascii?Q?ellBJ4Mvv4DSzykztvi/NdDRLYTylud5XxzAjkBtlb48QzgKxkLCyzDvr+m+?=
 =?us-ascii?Q?dmZq6ya0qtg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9dQqk3u5MmdDStBmHZmK0jkBN7h8JNrPKFLKZyPH8dTEoGXtbO5xA4LN91F?=
 =?us-ascii?Q?uzA7eLG8bZTKCA1APTnSLT+dHeeZFY+eqERp1GW8OZMrQt3GnlwL/7paiKPZ?=
 =?us-ascii?Q?Hbu2icAYHBM7vDHrzUa60QsBu34FK2XANrMXisQP+pyQgoQ9Cckx3Qr2Bctz?=
 =?us-ascii?Q?wADP1dsgWfePkQBXGg+bkToWjKZTIbZXLUA6eOiw+VtUZRuRdXmIakjrveDn?=
 =?us-ascii?Q?jjsIzhewKqbpsWjEGlELWSs/YhJ1mT71gs2ZbivVCAB2WQtCn+dPo1UNE40U?=
 =?us-ascii?Q?Dh4zYlbLDdQXa3G3zUnCjkSQw/1ThaGmF7iXVNaJaocjRtxJGvUx9s5dXfYs?=
 =?us-ascii?Q?Ih1mCzPYSvoiNNjh3lmDOTuOQw4lKDkngipF8Jmo0sjxJKVfpyaXG6wROenD?=
 =?us-ascii?Q?1kAQGmcQJ+rJhkxM92AOtDiUAW0IUvLoHEmwMjOrlDa4Y1jaNDR//XK1iIKN?=
 =?us-ascii?Q?uz4cp37Nd4ipBZhbann1Tr0yMTJugV84IqjfUkfxUsCgfp6ht4XnD3ig/KBi?=
 =?us-ascii?Q?l39t6ZimFLv9ZdkqhYN4N7GXZKGUDyYps9uqGgwYvaeXd5zQuKvEmuGWZrES?=
 =?us-ascii?Q?fzV/leN6lHuqlTd7+uOvTPILamQrzXqEuoBgPAadY4QFhL3OnyrV4XRWqNe5?=
 =?us-ascii?Q?w1MMP+ldydVb646BGUbUNbykT/ihYNOCJkLhT0X07/EEbrpOVd7YCw1QxTuK?=
 =?us-ascii?Q?HpGNgWg+Rul/GRg+bLPCPBae2w9Hw8lqrC+WMqB4lk7FUiKm01Jcj9ZHTjT0?=
 =?us-ascii?Q?kH5DQii31ZUshUsujgvBi1QFFvQe6PDuMzihZaH6i6GLDTBszwJj7nnBW8+n?=
 =?us-ascii?Q?7E1Lv2pZTHUg5P/Glb8kqxQOM742sXi2gE/PbsFkjvmh+0swd/sd0COv1Xf2?=
 =?us-ascii?Q?FFyv+RwINl3nY9CFPNGmw0FPbzcpv/Hd/cYYiQZfdl+2t7qAIJWVOjX7KQGY?=
 =?us-ascii?Q?TGJGIhsvKuWksrDUMFTUoUfzpCTz/JMo8ouuPgN48p1hsz3hZxCyk23aqR7O?=
 =?us-ascii?Q?fl3xkUW8mf4m3POrVZmnjevOja9VmxjEWE8NrYBUUy7NLLbfHwQKev5eNikI?=
 =?us-ascii?Q?zVJ0D+ghw1HR062tsCKt7nt/njUOwQeWk2xBKTHs2w16OSKLZ4Zrg7I1SyM5?=
 =?us-ascii?Q?kHcOoaOH04Hbxgm+MKTrExFM4K+GMOp3eSew7kYuff8rQxlveuBduEhNHfZ7?=
 =?us-ascii?Q?89TEvxmI+n3om/kglnBgqOH5X0HeqB+ecHYN98uUqebh56eJugB6fzdnDqu5?=
 =?us-ascii?Q?1nRBj0thc3J148kNJhl616TLq4mfLMUmzW1hG3CPK7a2PwrlRy3X7/qJRqFs?=
 =?us-ascii?Q?MqWFTMkrzy2K/f6sBdTe/mjQnIj9LQHiIzHJjP/R8eBHk7ZvnomfWFsEOukX?=
 =?us-ascii?Q?Nn6iwwFqlCHFM4cVO8X8Ap9r2FH39zg/5i45M9tNO17XGtx5/0oo36jn0yna?=
 =?us-ascii?Q?hl3DaM4bomGJPC4rQJqueZFgq4JsOcpZzwXDxsjk8YW2N04+CoGZBt69JURl?=
 =?us-ascii?Q?l3Ru4Jt0x7XtBef1RgbluQ/AHzaiy0cjKqc0drvrvAOTThiuHzo9DxjSfYav?=
 =?us-ascii?Q?oo39fXiwG0KFNto5z2FZiDwsqPvNxcR8T1xGV6FgIulj4VzF10Nl+3MpLXww?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d815ad-585d-4705-8056-08dd46e5b64f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:37:37.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9G1815zlONzUt1OoojMrFYdTkRCRX1gPlDfVuKBVMMZh/uOAURtv3a7gvjfspD8k4XH7Cnlh8kz/YDAeCMKepCWoolbLtMLA1d0xt+YKMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8130
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 support, change memdev creation making
> type based on argument.
> 
> Integrate initialization of dvsec and serial fields in the related
> cxl_dev_state within same function creating the memdev.
> 
> Move the code from mbox file to memdev file.
> 
> Add new header files with type2 required definitions for memdev
> state creation.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   | 20 --------------------
>  drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      | 18 +++---------------
>  drivers/cxl/cxlpci.h      | 17 +----------------
>  drivers/cxl/pci.c         | 16 +++++++++-------
>  include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
>  include/cxl/pci.h         | 23 +++++++++++++++++++++++
>  7 files changed, 85 insertions(+), 58 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4d22bb731177..96155b8af535 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> -{
> -	struct cxl_memdev_state *mds;
> -
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> -	if (!mds) {
> -		dev_err(dev, "No memory available\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -
> -	return mds;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> -
>  void __init cxl_mbox_init(void)
>  {
>  	struct dentry *mbox_debugfs;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 63c6c681125d..456d505f1bc8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec, enum cxl_devtype type)
> +{
> +	struct cxl_memdev_state *mds;
> +
> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	if (!mds) {
> +		dev_err(dev, "No memory available\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	mutex_init(&mds->event.log_lock);
> +	mds->cxlds.dev = dev;
> +	mds->cxlds.reg_map.host = dev;
> +	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> +	mds->cxlds.cxl_dvsec = dvsec;
> +	mds->cxlds.serial = serial;
> +	mds->cxlds.type = type;
> +
> +	return mds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");

I was envisioning that accelerators only consider 'struct cxl_dev_state'
and that 'struct cxl_memdev_state' is exclusively for
CXL_DEVTYPE_CLASSMEM memory expander use case. Something roughly like
the below. Note, this borrows from the fwctl_alloc_device() example
which captures the spirit of registering a core object wrapped by an end
driver provided structure).

#define cxl_dev_state_create(parent, serial, dvsec, type, drv_struct, member)  \
        ({                                                                     \
                static_assert(__same_type(struct cxl_dev_state,                \
                                          ((drv_struct *)NULL)->member));      \
                static_assert(offsetof(drv_struct, member) == 0);              \
                (drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,     \
                                                    type, sizeof(drv_struct)); \
        })

struct cxl_memdev_state *cxl_memdev_state_create(parent, serial, dvsec)
{
        struct cxl_memdev_state *mds = cxl_dev_state_create(
                parent, serial, dvsec, CXL_DEVTYPE_CLASSMEM,
                struct cxl_memdev_state, cxlds);

        if (IS_ERR(mds))
                return mds;
        
        mutex_init(&mds->event.log_lock);
        mds->cxlds.dev = dev;
        mds->cxlds.reg_map.host = dev;
        mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
        mds->cxlds.cxl_dvsec = dvsec;
        mds->cxlds.serial = serial;
        mds->cxlds.type = type;

        return mds;
}

If an accelerator wants to share infrastructure that is currently housed
in 'struct cxl_memdev_state', then that functionality should first move
to 'struct cxl_dev_state'.

