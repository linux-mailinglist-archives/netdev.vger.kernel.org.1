Return-Path: <netdev+bounces-186839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57629AA1BCD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87E71B67D72
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0725A2DE;
	Tue, 29 Apr 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tcb3Dqxa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E925A2A5
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745957230; cv=fail; b=dIVhWz/fKYSl8BWYoEMxf36wqr+JD63+qhw+yz7+E4REd++XtvDgks/fzOQouu1RRWMf8/EgAf10NPINOdbx31AKEX3qs/UwHdTL5xrmCpwQFqC7KH8eQbLrG5vuzm7p3bO8ZMNJLN3quVyZOYTUUw1R9RhweY1dHeigm3XwHD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745957230; c=relaxed/simple;
	bh=aRIjT//mE37SDipbiGVetb/h1zLL8gc6NuMDFPu+fOg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRMqwyauV47fgAHQ08gvVVXl2n9zQHwjYdeTvu0/Gy1ofWKiXlt7QWgxrov9NkFMEZJisc3dY2jzWy/BzBDKHmLs1uZZsmI1t3iI+N5L9Vluq+b2JtgJGXyn+NE9hZJ+Jlky1vgb8CXLp5JnhGNj1O9AJpbVjuNO0Ij7aHfTEts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tcb3Dqxa; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745957228; x=1777493228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aRIjT//mE37SDipbiGVetb/h1zLL8gc6NuMDFPu+fOg=;
  b=Tcb3Dqxa0LYj/h5WHzM3fv8EPkwljRj1blNqPzfn4rPb4+CgSjXnPg1T
   PaWSrdKkz3wFUzjLq1ccrN0pLtHQVlckWtAOLMHsadOgd3cxbt/Mio57h
   B1bXiJslfz2UehwrRtEUeoXp86gvsddtTGA1BxqR9wv6vzqopgzMxtxsu
   ybFyhl8+ZnPMXzDpGF4R+gB1wVzn4oLb7S6JbVwMLVpMYEYTKyjDWrbdf
   aSD54EkAgwMj2+CsJqGcEgtb0twlRcxATjK/ZW15QIq22jmFcTIwZRKTi
   A+pm7kaJk/kJpYmtd+PD4Pbx9Af5p99F5M9TSaMEBPzlCPz1O8sNY8GvY
   Q==;
X-CSE-ConnectionGUID: j5fxP8D6R4qbk2CN+l63/A==
X-CSE-MsgGUID: pyQ9CMPITBuuwNciKmgKjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58974148"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58974148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:07:04 -0700
X-CSE-ConnectionGUID: px8837/RTfyW8QOttYdD9g==
X-CSE-MsgGUID: pFggPvARQjKa6mpEdfftMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="134874534"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 13:07:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 13:07:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 13:07:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 13:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj+2nTEpwSTRFALab7VfpMJ48W7ddlzM4HMYlL7TSriOEtFRuNsD92FvPv6ZAX6i/zcFUkjxb5/Re+rahSKpIjA3vGmR3CrSb8NX7GiDedsn/unh1QobCvj+cEx5QZC0ENtKqaAbLOhVnJhmFQEA+f7qjm/q6T38EFxjRseNnDw8/jJjP6n8BzK6BuG08fAc1j6lsla9P0ijJUOukpPQTyd9G/hShOtDIFWaPfdaTlnwmeURYdISAz8SZO0i678JVd47q7YzMxwLqHqwDYZBgwPJJHPpWksNe1VyG+I+suAptzjz6Q41xf82qaGqFjNHbEimIvI4mNgw1nM3Evsw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EjjFZV2yqaZLOPSQs6ltoLfDKtFgee4Elw4rDo9Wm0=;
 b=zO4VhOZGOwoGcPUrWx+YDKtJ9GZ7hzSmgyahR2UowBh40V+GKLqSQC7LtNnULvGQbs7p2Pt99fdhi80AuFOZR1VMb0eFcmKuIoj9t/J/aKQAqk0wcyDt5CSXiY6mK11PT6IbrbJ3H5HxBtkrxqa53pfkSapQoj/7WzS3DZMFlAhc7REYuakwWEzaOiFOnw8KnQoSODDx7lcuEAINOrgoipFTv2XmTezcsTrnchdDlNCBfrH9+nq97tLgpoztlLEELsGgFc49bhrCBv1F6LW5iREjxLZlbj4hQkihmsJ85sM0abvJsVLvWWuL5lIiEyrw3KpY4QKPCKc4/GhGxTol3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7039.namprd11.prod.outlook.com (2603:10b6:806:2b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 20:06:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 20:06:54 +0000
Message-ID: <40f89f87-0590-433c-b490-95ecc5f50435@intel.com>
Date: Tue, 29 Apr 2025 13:06:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Milena Olech
	<milena.olech@intel.com>, <przemyslaw.kitszel@intel.com>,
	<richardcochran@gmail.com>, Josh Hay <joshua.a.hay@intel.com>, Samuel Salin
	<Samuel.salin@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
 <20250425215227.3170837-11-anthony.l.nguyen@intel.com>
 <20250428173718.2f70e465@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250428173718.2f70e465@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3e72e9-a272-411d-0be3-08dd8759630e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEpNdDVUZjIrQitoL1orWDRYR01XSWdYVEZZckJqaXJxNkJGQkJGaWxPNzd0?=
 =?utf-8?B?WUo0WU1peGNmd0svREZmU0t4NDhJOXVXV09KN2JiZnNpL3B0RFBGUUE0Y1Vj?=
 =?utf-8?B?bjJ0OGpsNFV3TDBLSFk4QnZ1alV4YStqZ1NNRkRKcHE3OTdKYWxMY3Nyam9H?=
 =?utf-8?B?QkZZSFk5YU5JK2JaeHN6YzBNbXI5aTl6VDZDdkZBNytmSDhMTzQ2WjNkcVQw?=
 =?utf-8?B?V290L3o4alBCZnJxcGFQNnVyUW9IVkV4Q2xBNmNXRDRhWnJPNDAzTDh3a1pm?=
 =?utf-8?B?RVQzUUlwdzN3UEdCa0V0aW0reXV4WDNQcGtxWkYvajArRVV4QjNJSm5Uay9I?=
 =?utf-8?B?RkFvK2dRM1AyaGd4dkRqdVFwN1gyeEIzS0lnYU1GMG9IQVNkZDNwTUxYelBq?=
 =?utf-8?B?Y1VXTDZyd04vRWUzVW9RK3ltSi9KZDNEY093NlBTbW5qWE9QZ1l4NGlqNDI0?=
 =?utf-8?B?N2VUSFh4VExQNVlhdVQ1UlRUOGhiVVZBY3BFSzFheFBMS2c2WTVNUjZMbG5B?=
 =?utf-8?B?Zml2WFlmU2VDTlM4QmRFSGpFU0NyK0IvNE5BMktuMGx4TGtuTUFVQTJ4czZ3?=
 =?utf-8?B?STBGT1d4bXdLbGl6bUJhV1BKQk5ScWhmSm1PRWIzbDJIaWs1T203d0k1NnZR?=
 =?utf-8?B?eUFrTTlZaUIycG00T2Y4R2dNaDhUNmpCbHNGdUhnd0xzOHBMS3l3T3ZDZjUr?=
 =?utf-8?B?SDBIbEZacmVTT2NQSHJjbFJmTFpMTWRXSWtKR3pkY0NoVVFldGlvZW1ORU1W?=
 =?utf-8?B?aTdyYTBQT2xQU0k5ZzJHVS9CZVBPVjFPbVJUWVlEMENaUHlhem0zVW5laUdo?=
 =?utf-8?B?MENHYlNYcHJrV2d6M29peGIrZXliQys4cEtxSVpRRHUwQmovZ3VlQ21jNVhz?=
 =?utf-8?B?dXRMa1dObndhUkZuYXFjc3l2RGpJNU5CUnlSZTRCSWpWNXFEUEhnb0t6YkNC?=
 =?utf-8?B?cEJoWXR3SHJiSG9hZDNjUmtaTXNLd1Q4OVZ2aHpsOElKNUZPek1tcGNRK1RF?=
 =?utf-8?B?STQvSXhUNkxRVTBHQjZQYlNNbW5ZQlJSdGU1K0l1ZFk3T2h5M2JJaTlxNFZP?=
 =?utf-8?B?cStoL3lqSUNPZHpsMEViNy81OXNRQUNBcDVJekVlVFpvemxHUm95YXp5ekVB?=
 =?utf-8?B?ZG5sMVJiVGN0WGdTRWo4eHFqeXFvSUxzUm5BcFd2WG1obGtnQ1h5ZXZGWGVF?=
 =?utf-8?B?TFBNb0FEVmhpQmVFOGlnUUk3YzZrb1J5ODYvbm8xazluTHFXaDhJdGRKMEpo?=
 =?utf-8?B?WU9kZmgzZFcwN0NuSW00dGxNUWpHTm5SdVJzOWg1T1BCdkhFcm5VMVRRZEJY?=
 =?utf-8?B?eFBjRTFKZlhLNTRGVDJNeTcwNjUraW5Fa3BPRWttZFNZRG5aTGNnYVFJZlhX?=
 =?utf-8?B?WjRJY24rbzBDT3RlcktuRm9RMEVnK3p0R1RweW5TT0dyTmd4UnhkeVByZ00y?=
 =?utf-8?B?ZVh3Y0FJTXFKYkowYWpCSkhXQ2JwejVkYktiYTZVd044RTBRNUNhOXIrYnNC?=
 =?utf-8?B?Ung1N21KdEVralIwOGlTdHlJbU9OUGlaZCs5VmVzYmJ6YXQzWUdlclNjM3FI?=
 =?utf-8?B?Y3RrUXEwa1dWNWpienpTK1RuWmE2VXQ5RDl5RjdocE1hVjZOQXBMZWRiMVRT?=
 =?utf-8?B?YkVyUTJyZUxGRUpHNHRKUDk4QWJUcUZUT3MwS2dtNDhLd2lhY1lPcTE5OStV?=
 =?utf-8?B?UEc0b2JVOTRqdTEwSVpKNkZIT25TNGRwRDJ6bUJHSTJMM3RyOVhCcFYrRmY4?=
 =?utf-8?B?SGZwaU4yQXhmclI4NFk0ZzlBL1JVWTgxTUtPcXdnbVhySEVQbnZHY3NRN0Fj?=
 =?utf-8?B?TTE5aGI4V3hQc1g2SUg4SEhkVkgwdmF0NjlNaDdNMTRmZmRXeU50K2I1QVU4?=
 =?utf-8?B?Uk1DN0IyWmRxRkd4SW1jeG4xbGpUK0pnWFlmamU5M2JtNFA4UVN6dE9weUdk?=
 =?utf-8?Q?yeUVrcugZWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjAwK21rQUJWU1IrSzJqK2RGYTVpZ1ZZczNTZDd2QlIyUkQ5eGlZMkhNc1dY?=
 =?utf-8?B?VnRNMjZlTnBUdE01dCtINGlXRExWMlA2dFZ0ZTJuOHc5SC9Zd0ZKZEVsUWtn?=
 =?utf-8?B?SEhNekJZb3p0WjBJR2Fid0MvWWVsZTdWVE4wcGFHNDVFY25FeXB6eVdWcnho?=
 =?utf-8?B?d213K0FGallHZVZZWW1lVCs2cU1wSkpmRkRhSG5WYVRZbHZDOWNJdklsVHpw?=
 =?utf-8?B?SVRiS2ZxTTdrWjY3Ukg0N2FVMnFRdWN3amVqVVhMaVBlSUdqaFdNcFl0M0tn?=
 =?utf-8?B?NFIvT3I4bU9qZFBTY0pjVTJwenQrSHp4dEwrQ3J6R0l0Tkk0YTlRYjJFQU1r?=
 =?utf-8?B?THROcWJVQnd0ZEZJcFFyMkk5ZFpzblVuZmp1cnNoSXZuZzNiWDdIdWN1OGJH?=
 =?utf-8?B?OTRqeWNIdklzd3ZLeU5Bc2Z4a2JGeW1WaEU4bDBhb0o2bWU5RlRYS2lBZ0xE?=
 =?utf-8?B?cWlISWJVem5tQ0ZvYXQyYTREL2RPUlBsZ1U0RTI2NkRML0gvSnFvVjh3V3E4?=
 =?utf-8?B?bkpDOTduQXB6YmtydzB4L3U5ODZXTWFKKy9VZnRlME5HR1I2ck5odFk1VmRO?=
 =?utf-8?B?UktTLzRpa2g0QjFMVnNNL3hnYlRtRkpISk9RbmFFWENMdDNXUStvaXpWeUpR?=
 =?utf-8?B?aDcxRUZFWWczbkxENFZZK3FrMFZCc3dvaFZqditSWllGdXFUK3RQWG55NXVQ?=
 =?utf-8?B?bTRnNTJzMm9aQTlJRzlETHROYUdGZFp6K1lMY2dXcDVOOW15U1g0UjFNQU5K?=
 =?utf-8?B?VDhmYXBKOXRxYU9Bb2R1azd6Vml3TXdhOHJzdVVycnI2MGw2N0dhcWxkcS8z?=
 =?utf-8?B?VWVTYndpK0ZqVkVPY3pDTGpjOGdsWnU5bVZvWFpydkFJUVdqcGxzSVlEUUtS?=
 =?utf-8?B?bGNDMnNlZjVQK0ZWMjB5aTVHbmFoVjAza2ZRZ2l0czJyeUIvQUJqMnBxRmpZ?=
 =?utf-8?B?RXJnV2s2Z3QzY0d3V2dWSnhYd2owRCs0cHJxYWlXUG8yK3AwTWtsVWZzMGpk?=
 =?utf-8?B?Q3gyQ0p4czU4VlFZNHlsRWFyS2xMcFM1VGxHbHJ0S2wzOVFHN3NoVStXaTdE?=
 =?utf-8?B?Vmw2alNkM3VUNWt1OTFPMGlRRUxiWHdyd0wwTXZ5enJPN3NiZlpodE5VV1lZ?=
 =?utf-8?B?WHZJNCs3Z2s5TnF3KytsSU8zdFBEdlIyTUFiN0pVYi85dW80VWs2UERuVFdY?=
 =?utf-8?B?TDVGRmwxdUhZcDdCOVVkQmMxcDdZWWw1Z1RBUVVkbkoxU0FicXZDRGZNNjN1?=
 =?utf-8?B?RmtJYU4xdlo4NUZQTVBWVUtEMjM2SC90TGNiYVM3M3VISmR5bm5zMUplOHpJ?=
 =?utf-8?B?OFZCcWdUNUxoWlp3U0lKeWhMV3lsNkp4SUJaRlg2b0p2SW1uM2VHTkwyRzFo?=
 =?utf-8?B?R2JPRlVnVm01VTQ3ZUtlcW4zMkVHU3Y0djFDTVNJVmpsc0VPRlVibGJLc3o1?=
 =?utf-8?B?K3ZZVmlSVEJiTDBmWCthZHlYdGlpVi9DdmZIUEpLQXE0bzAyblZEaExpTlAy?=
 =?utf-8?B?WDZlTnlwK2ZVbVVDL01VU0hpV0xlYUsweWlENzFxbkc0VHFBOW1ERXNTQ2ov?=
 =?utf-8?B?Sk9wUUhiK1ZEYlcrWU5hUllEaHpuUU9NY1JBbzhCZk54YXEyb0gyU01PMmky?=
 =?utf-8?B?UEZQdDIzYUZaVGRsTXNickJSbkJITnM3MmdrT2YrOWlWRlovd0dSU1RyeVhx?=
 =?utf-8?B?QWZDSmNDN2E1aVpLOWZmSnY2WS82V3NacmVwWWpWQTczM3g1Yk9LRjYwM2tC?=
 =?utf-8?B?TjZqbnF2S3l2eDlKOFJLOHVibVRlQVduRFNWbEwrRFFWanArR00ycWNVVEkx?=
 =?utf-8?B?Rk5PUUQxSFZ3QTRIeVJvYkgxTnUvc2h3cDh4MWRwZE05SzhBeGQ4UWVYY1Zp?=
 =?utf-8?B?R3JrR1FaSFhsNzFYYWprcTI2V0RZMlhDZzVpU1V4MFVFMXpXUCs4eEU4d2FT?=
 =?utf-8?B?eXptVklZL2lXcGp3UG52dTBnS3JaSkZiU3RWSDlaZksxYWpKeHYzOTdtLytn?=
 =?utf-8?B?K0ZhMWllT1UwazRaeU1qUENadklzNlJwNFI1bmZ1R0NTbzJiRkhPVGxSSHJP?=
 =?utf-8?B?VGlQaFlGQU0zU3NSMXlIcXIvZStMZytzNEVMU08wcDJaUkRkZmRMZFhhN25C?=
 =?utf-8?B?Q0RRWE5jOGFFcDBkRkJ1T1FPNTAxMkRrelFnbWU3azlWNURCbEpmSFpZZS9o?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3e72e9-a272-411d-0be3-08dd8759630e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:06:54.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfGSQSaO6cXwK46iClZv1qsBpf20lR+z99118xeuxzKnw2X1Ce44wHE+8aPsPXNxmceKnAICZyQdwiaKp6p+9uifKCG9MSWeH7507ONWX+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7039
X-OriginatorOrg: intel.com



On 4/28/2025 5:37 PM, Jakub Kicinski wrote:
> On Fri, 25 Apr 2025 14:52:24 -0700 Tony Nguyen wrote:
>> @@ -479,6 +480,9 @@ static const struct idpf_stats idpf_gstrings_port_stats[] = {
>>  	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>>  	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
>>  	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
>> +	IDPF_PORT_STAT("tx-hwtstamp_skipped", port_stats.tx_hwtstamp_skipped),
>> +	IDPF_PORT_STAT("tx-hwtstamp_flushed", tstamp_stats.tx_hwtstamp_flushed),
>> +	IDPF_PORT_STAT("tx-hwtstamp_discarded", tstamp_stats.tx_hwtstamp_discarded),
>>  };
> 
> I don't see the implementation of the standard stats via get_ts_stats
> You must implement standard stats before exposing custom breakdown.

Good point. I missed that during my review.

Thanks,
Jake

