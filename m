Return-Path: <netdev+bounces-210226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDEB126F8
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A4A3B581A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ADA23C4F1;
	Fri, 25 Jul 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgfqcbEa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727F8248C;
	Fri, 25 Jul 2025 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483285; cv=fail; b=JJyJGDV4whc2XYpsAcYQM+hAef8DwLGTmnYtDZmNUajXodY1Gyff0AdpWAh0kBMQPpzCJC0mtae1oCM6YxlET0ASNRgVeQWfQ71zSkRhgQzHftXinMmfznF4H/uTsw7gxO0fEA0jzdtvz1cZwV1g3bs9iKDAqj6dIaFqSD9ilD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483285; c=relaxed/simple;
	bh=lxUvigRZCyl2+qvQuTjWpDwbD6BCKFvbv+v9YYn/kkI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=cBkiFaAIx5s/V52Egz9jEqH+/G7wkb8VKchwtGktcoyqyln+VDL2VBPObPHzrF0BnfuZNQNodeZWqQtG1W3Oy0pXdIHfDdT5tR74aXZtwBKTORCMQaBuK8pq0nzMqQ0JNsw+qkYwopegUfJacA1XXhrbhB+HhrAwNo6PwVFZrNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgfqcbEa; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753483283; x=1785019283;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=lxUvigRZCyl2+qvQuTjWpDwbD6BCKFvbv+v9YYn/kkI=;
  b=fgfqcbEaaWnh9xQpMXRh2Y2duzU71+6rWH/qqoUoY3t8tafV7P2VFSV/
   4CLzIfTB/YhXwpNw3Mzv+U4x51FC55NR4+UJRV6GoIOTzOKyrT2J10m+v
   LYQ6sOV+SaPUnCFijiAR8ZFWxoB/6V+VRuidSkBVdJKLJBXc/Rko2rnR8
   ZHkHl4nyW+wFuBUFVhmSQe0mzTgbA/OTKr8KP1HRF13TT8Cwxg2q2d8vB
   JuJqWIOenpgMiP3CTBGdnrIbvFKknoOZgmUx2GeSm10FXt7CXvUMhkqK7
   dC+NPotRXiCgz5kAk+i9olVMYesxSN9yEzZu/KPTYIghZ3LrnI9xgcTgJ
   Q==;
X-CSE-ConnectionGUID: HHkoBcsGRR20LI1DBC9MsA==
X-CSE-MsgGUID: E4NbdbPdSvqTzdfnR31AuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59624140"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59624140"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:41:22 -0700
X-CSE-ConnectionGUID: +8Hg9I3eRlC01dyZwBaPQg==
X-CSE-MsgGUID: m2/tkygmQaCcv7C4i++7Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="160500145"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 15:41:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:41:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 15:41:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 15:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgenE9g15tQGGvNIA/XOxv1fQ2fwUJLsJQZbqaAA8+dklQHvwFIemrzbPtKCtTCnhYrJDBWZLmFhAc1EdnmEFpvk2uravfBkw+2lWR0iI7rnyKcgkvdtCwf3tiToqK5TJuQUox7FEK4+Y8b+stEYCdq+YJn5IAs7/Roq9j5Gc8VAWA9WlJ7TuSCHZYBnF2pr7T2C+yfmMkYbxCnBQTuSwV1S+SMHpVaMVQHi6gAQKweEEvbkolDhqUduDFpVPiZKyigVRfrqgpLLSTKp0QTuA0QXD/Is3g8DAoAcpWol3sw+XTt83QQtsHKwp/GcVhnBxZ6bc674dE8ENhFRTl20fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZz4eoZAYkTECBNEmKZTzznKap5ClFmlu85SK8qtyWw=;
 b=AITEHBBvM97c+thb0ff5ieeT3o/034bY1s2/F/LYSK6xqzCIvi1CX398Di4YIYpB48lrWeGJie3YXFfg/5hnH2mAqFlaTBpgLTtvDKPcgCwPvGPEMQi+n8sbOmmEVDKTcOjCY8ZxZtX5wMhiGLBmIh+aXZ7gtPzQg4b3fhMcXr0yzxeMzF+IDp+ADp1mT+B24j9U8Hy//bkNchZTCQaSD/LZQi/NjbJV7nbE0rRWre9HecRMN45c5fjXTSbtryfKyDPzEMsFiYgp2/MrTuMWkFmz7mtHwQ6JSLDLfk88fvwuYjyAg/YaV/gThXMCfNltolw/boZljI9dYmb8S2AtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.24; Fri, 25 Jul 2025 22:41:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8964.019; Fri, 25 Jul 2025
 22:41:18 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 25 Jul 2025 15:41:15 -0700
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Message-ID: <6884080b24add_134cc7100c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250624141355.269056-4-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-4-alejandro.lucero-palau@amd.com>
Subject: Re: [PATCH v17 03/22] cxl: Move pci generic code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6d8bb8-8513-4c92-fb5c-08ddcbcc5ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXpqM1BqMmFwWDJpM2dsRDlrTWsvdE9PQmg0Q3RjWklIQklZdmN2eDNrSllP?=
 =?utf-8?B?cVJnMFZtV2F2c2pBVUpyeXMvL25IS051Wko4cDZnQlZqK1dBZjF0NytGdE5o?=
 =?utf-8?B?K3hBV0xZa3orREdMUGdGSlpVKzhuZFZUOGVGcS9yeWw2ZHVQLzF5ZW8rMUR2?=
 =?utf-8?B?TjN3MTl1QVQzdmYwV0RPOTRvMjM5cC9aQjRBdkxIOVMwQ1ZJK1k0N0p4alFC?=
 =?utf-8?B?R0RQQzZBUnhIU3VzWk1TdGpJVHB6c2s5R0Q0ZlgzOUFYRnc0UHA3ak5rN3ZL?=
 =?utf-8?B?b2duZVFVQmVYZHlTeXA3LzBKRWFCcmVncjlWU3Jpc0tHZ2g2cit6b0Jmcjg5?=
 =?utf-8?B?aEJ2MzgwWC9aRU9VNmNYY0g5UE1ncGJGNEVNeHljbFhzNnE4Qk5FVEMrSTUr?=
 =?utf-8?B?YldWWENIaERHRGZVTlF5SlNPb3RLTERSTFpoSExoTkFWYm8zVzlXOG16ZTc2?=
 =?utf-8?B?OGV4R0NOdTI2dXRiUS9IVFdjOWltMlNzNDdJVVlnNys5TDdSQ29EdHhqdmRK?=
 =?utf-8?B?UlVvWlB3YWVDZnNyMzR2SS9EMjlqT2x5dmVXYjQrVjNXaGxzU1NwQVNqZzhG?=
 =?utf-8?B?akxhTGFrYVpiZXk1c1hHNWpnQ1VKZk1IWUVCNmVtTUd6Unhjdkx1UGhvOEpI?=
 =?utf-8?B?YTZQaHZWSDRBM2FWMWk3dHdSVjJIZXBKcyszOE1XSlBYdXQ1OFVwMWszcXI3?=
 =?utf-8?B?QWE0T0M2ZStLTWRkVDhlb0ZQSnEzamlDNFVLY3Znd25TbGJJRDJ4MHdNZ1Iy?=
 =?utf-8?B?Z2hsZGozSmcxUnkrb3NFMTlRVHlEdmFQYnpDZEFRL0IzZmwrWnR6MWlDOXhW?=
 =?utf-8?B?T1g4ZXVGd0tvVy9ra1dadmVxK1Z3a2U5Z2JvMTBhMkUwbTNlUWp1WSt6YnlF?=
 =?utf-8?B?MVVvaGxMcEliUUZpa1BZdzlCMzZZREZHOVR4M1I4Ulkwd0k3eUh6T21Rd0h2?=
 =?utf-8?B?RHl4NGRTZ2tkazlFKzArSndGUkNmZ0VSd0w3V1ozQ0Q3UTBTd1c2RmZiMzR4?=
 =?utf-8?B?RWpGc1A5eFN6V3lnRzRkSi9ob1lBQTFTYkNZZmFUL0I2UHJxdVF1cWxxNmF0?=
 =?utf-8?B?dXRyYW9mMURTVDFmZllIRU4yd2M4eTBTdVhmeUUrc2dXVGRlRng2ck5xSnlt?=
 =?utf-8?B?c3J6T3ZnKy9pUm9kL1owQ2dFaVQ0aTJEcVcvMXZMRWs5cVFoQ2pLd0NxZldS?=
 =?utf-8?B?NTd5R2UxNzFnZ0FqeFE4cEt2R3ZjN0FtM0VjMTBXbE5qTzlsTWFRSC91blJ6?=
 =?utf-8?B?KzVKcWY3S2tLR2s3aENKeGVFbWlOSUZVLzVOcllSZ0oxMXpta1B5cGg1Q2gx?=
 =?utf-8?B?NDh3WisyQmZQNWU0bmxrMDh5ajJwNDVJaVBsTFQ5amdvS21zMXNJTDVBZDRE?=
 =?utf-8?B?VzUyUzM2YXk3bVl5OXRtcFlKNnQ4M1JuODB0Ky9ubUtvakVKUHFkb1NPZXph?=
 =?utf-8?B?dnZPOXpYeFhuTjlRWVRFaHNhWVRXRm1zc0trRlpZVzRQaE0rVFp2anlrSXdF?=
 =?utf-8?B?dnhTOTNyQnY4b1VnZjRWT1ExRTBkYnhZbGFSZ0FZT1BpNEZreWRGRElXdXNw?=
 =?utf-8?B?VlpXRW9DNGpZSnhBY25YZ0tMYld0WWZFaG9FT3B2YW82R0srMHRQbFBOSU56?=
 =?utf-8?B?YXhVNmNaVGpFVGFNTkRMYVd4V0NkNHl4aUpFTE9pS0NRMm5OMjRGQ0wwNHhJ?=
 =?utf-8?B?NHFvMktoM1JSMTNvV3l6WVBZZEZvM3NvTkNCeEFJdk4vbVBLblk4Z1ZxVFBv?=
 =?utf-8?B?SnptRkh1dzc5Q3REODdxdXVGZFZIbnNTZldTK2J2RUM2ZGdSTTRCMHZoTmJj?=
 =?utf-8?B?eGNERElGT2pVV0M3UTNLMkd1WUNlT2RaZTRHdXl2blRXUlZmc1NIdzFhVFYr?=
 =?utf-8?B?bEl2ekcyR293S1pONk53dXZjMkFMdElUTGdWT21PWDRTTTFZZnpqTFgrc0Ft?=
 =?utf-8?B?M25TZWhYaDFqZG5BSFlpc1lpQUJPQW1pYzFnSmI4aWYyTHZBREZBQ1E2S1Np?=
 =?utf-8?B?bForQnJuUXNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHA2a1lnRVZvcFY4WUN6WFY0YnNPalU0VGI0Tk9vZHM4bDI2QkxoajFJckdo?=
 =?utf-8?B?b1NKWlRPdkZIaTJKY3RHekdIeWJpUklCKzBBcmJ2TlQycWw1K1cvWVRZdkxY?=
 =?utf-8?B?VkZZWElBVjVGaFU5Njc4SlRtY3Nibmszc1E3NVMwMVU2NHNyRkoyN1lqVzVy?=
 =?utf-8?B?VjNBbHpTUnh1RktkMXJ4a0Q0UjlkM1d2VGlTZTZNRCs4QXFvbzcza0lyUGhG?=
 =?utf-8?B?aGI4bEVjbHp1SnRPZ1FkSzZXbElmcFhKZVZtQWVrUTlRZytJZlNQRlg1TEpj?=
 =?utf-8?B?NjhMN1U0TWVQZHdJMUpUVTVudnhiWGlqYWtHL0FYT2tqRFZmWTlNSWhPc3lU?=
 =?utf-8?B?bENLR24wT2VXWWRjS1ZCTXBNNlF5bXROQVJUTk01SGlsRVU0d0pFOE9jQUJG?=
 =?utf-8?B?UGFjNkV1R2pERW4vdFRsWGM1SEtTQTRvUXc1T05ZdFB0aG9kVjBmYUIwbE8r?=
 =?utf-8?B?dVNkLzNncGFVa2lZM3RWdTJMMy9GSWpMcFRwaGpGOERab2N3ZmxXMTF1QTJs?=
 =?utf-8?B?TFZsMG5GbjF2ZExoejZpWWlMblFCblB4eW5RanVDOGQrUlZTT3lrTGpQMGl1?=
 =?utf-8?B?UFFxS1ZZc3crb2RZejJQTFltd2h3eGxBY25QMU5RL2VYNXFEWmRaeUt2Z1Fm?=
 =?utf-8?B?ZTd1VDhMUGZZUmovSHJLZFNadVNWVVg4a05xOGxVQVFUZDhwdXg4ajhqM0pU?=
 =?utf-8?B?aDBZK3VRMkRCN2NsaCsyVmNBdkNrYTNYUG1nR1ppdk50VGJPRENTcjB3amNj?=
 =?utf-8?B?VzZqbTlIZTNnYmZhbDRPRzZsdG8xbTcyWkNCZFl0WGNHcFVHR2R3QURHeUZ6?=
 =?utf-8?B?a3ZTcFR5QlZiU1NVOUx1SjEwUUp6RksyUytSelRmSlM3UWRBQVptaFliRDQr?=
 =?utf-8?B?Y0lCWFZMK0ttcDdtd2NlTlBwUXJVWllodmRaVEd5MkhrSGE3OXVKdUhyOEZW?=
 =?utf-8?B?MHBQaGF4cm1WR2RFdzF3Qkd2cjlRY3k3L1IwdnpHRHRKa3dLYnNTb2Rjemsr?=
 =?utf-8?B?NWJzRVFaWHF3Y0RZbmpLSk4vcDl2VWVUbS9oZFZKZDdwbGFnd1FxZThiUFYw?=
 =?utf-8?B?MzVYSEoydVdPSDR5NkVwNksvbDJtZGR1UWlVMlhGb0U3azg1aWduR1ZFUTB5?=
 =?utf-8?B?NTc4bURqMERMUTZ5b1M3L1BRN3pjOUNWWDRQeUxJRklLam05UTkyaGl5dHVz?=
 =?utf-8?B?aEplcTFWNWhwaHdmNnpuZXliRFpWTDFGY1l0bjlOdXVqK0pRWmNYNzdZOWNE?=
 =?utf-8?B?MTlsbTFFMFozaGszSFFKMjdLMFpqYThTV0p4Rk40YjlDZDYyd0lzZVZNNG5G?=
 =?utf-8?B?K1phOUlVcDRCZ0tQUlp4RUlqZHpGNWhNeHlkL3JFbDlHZkNKT0t6aWJ1T3Y5?=
 =?utf-8?B?WktzaURTT1Bydlc4L3dRZVlqcTJWR25CVjlzcDVqYUZuK2I4ZDFYekllbjNu?=
 =?utf-8?B?MklmVDNhN1VYZ09TaURQa1dyVFZkQnpadEh6alRkSFlQcEx6QUFaYWdyVllw?=
 =?utf-8?B?UG1vTFZlNHMvbEF4eTlJMmZVMjlKempBN2R0cXZBdmRXOUw4S01VRHJVTFhJ?=
 =?utf-8?B?bWt6NnhJNUdtL2xqdTU2SUtOTTJ2NE40RnYrejZGaFJwSWIxdHlPMzVHTkZN?=
 =?utf-8?B?cmdoL2xzeW90TGQ1L3dLQUFNRU8rcVdrSDZzSzFNYndTQWhwZVhKOFROZURs?=
 =?utf-8?B?RU9TQXltaXAxQS9lUzA2dWFLSXlCMjVoZUl2aGF0dzBibWJhaUhWN05qT2FC?=
 =?utf-8?B?SzJxWVNIZWJQOVVJbWVvZndSdFRqa2s1cFdXZGNJSHdCMlp6ZWdZR0l5ZzFL?=
 =?utf-8?B?MVVlL0sySkhmL1B0dk1zdU9acHFNVE1XZlZ3V0tGd0ZlbHVQZkZDSG1wUW1l?=
 =?utf-8?B?bzBHY0hlTzJJTm13L3NWSS9tOWs3MnB6T2l1bGszSVc3TjhlVWttTk1hR0Ft?=
 =?utf-8?B?YWxPV3UvQ3dVdUh6NXMxN29WZndmSlRRZ3FHY01IS1NReko1UWNudU5tbHYw?=
 =?utf-8?B?Wk80MmdtRDllQTdVZHgwU04zK0F5YXRyQjlCekFwTVdwT003WElFY2VHcjRY?=
 =?utf-8?B?ejBOVXorU1hnU0gxSGRKNXZDdWYrVTlPOWltV2wwc2g4bWpyZndQZFZlSThI?=
 =?utf-8?B?Q2ZHeDJnTE1KVUFBTTRuS3dSVGl5SVNBa0FvQkVHakgybCtpWUE1Nko0a2JZ?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6d8bb8-8513-4c92-fb5c-08ddcbcc5ef6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 22:41:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDVxNjlgkSfIiD3Hc9cemXSMJS4vBUCXqfNcHJAOaOjNSsf9QRRTEYlKkwefg2EsF51MGmLVHG0s6KIgqaFhzj8UdxSQRILm2OodxvWOWSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
> meanwhile cxl/pci.c implements the functionality for a Type3 device
> initialization.
> 
> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
> exported and shared with CXL Type2 device initialization.
> 
> Fix cxl mock tests affected by the code move.

Next time would be nice to have a bit more color commentary on "fixes".
In this case the code was just deleted to address a compilation problem,
but that deletion is ok because this function stopped being called back
in commit 733b57f262b0 ("cxl/pci: Early setup RCH dport component
registers from RCRB").

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by still stands, but I question why is_cxl_restricted() needs
to be promoted to a global scope function. Are there going to be RCD
type-2 devices that will have Linux drivers?

