Return-Path: <netdev+bounces-126808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31997295B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA41F221F8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66A24B29;
	Tue, 10 Sep 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caD+nzTm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9557C20B04;
	Tue, 10 Sep 2024 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948947; cv=fail; b=Tfg6i20supgKdyy7Zhlar3V81nMjSPuFlSICDeFfyqB7tBkMA5k1/kKZ8yVmsOEHaAiHkSJMdMUgSe+PFuB6leUNqPeCOQAPuUBJAZ5gGeZOSXkg7zcnndN0SxoSIssb+r30NZCQfEM4FkBlspKhxWh23GUB2fXn/3q+ok79a7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948947; c=relaxed/simple;
	bh=hK5z4qoS1BR8y6ivyJHnbswHf8Cg/0FA540opozZA5o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9BFfvnBdFgf07y3uKkDTHPppX3UZWXzHyrvZNX/ZFKcD/PRb8eKEnyZsp2lD5F16/1fikY8zGY6Fxp7+i4FnPBoC59Es67eqLTswVPYy2yXKWVadCS4owHT3E0TbgzOxkz7C7oBrVCE6zi9KxIO2edeZpcl9fxk2P90LNEwxeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caD+nzTm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725948945; x=1757484945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hK5z4qoS1BR8y6ivyJHnbswHf8Cg/0FA540opozZA5o=;
  b=caD+nzTmYfQZ83SJ8aR2YkxwghF81VFYPgdJjbnE9OfAgvR0OeXmI5As
   1JCTGKv2U9dZyj5e51FQmOtvcycpYpaAaAizjzIeRzuT7tbJcO8FJid7V
   /571lV2RjJkEyTiNjk3/5lk4w8OtVUuFw0BXmRU6KD5y9RaISo4B3rdj5
   mAkxSON39ZFJkpGFVP+KVwQqTaFhftCJWf2QXTX25/OTuIn6RKzc0NoCM
   cOzqYchez0MXVvFL3oHTsb8db0unz4dA0sIpaKkuGtH9c9iBXE4r7oEzo
   iKGCJGO7g60rg1oS9KuMNvQjX1AxoRzVuF4M2Wwc7/gGPHQDnLsDFnKDc
   g==;
X-CSE-ConnectionGUID: cIJPOsEVTs6e9n3iSPK2sw==
X-CSE-MsgGUID: azPUMRasThe8NpE3hD95XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24784268"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24784268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:15:45 -0700
X-CSE-ConnectionGUID: q8UGutY/Te+uOb4Iux48Og==
X-CSE-MsgGUID: /OoX0xw5Thmy4GQKCsNXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66871315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 23:15:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:15:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 23:15:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 23:15:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 23:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3HzKKwRL7zxfgnX2kk/z0s6M6utD4IvWz8VCQ1bJd1272TkXog6TDhYrsv/hFDODxP+CZf1Ey+BBKYZ3H3Gq6pDMtF65cmLPeAS/R+KlawBYVhVtm5jL4GdESmD22BPCtEN1gG1qQLUoxSaFz+EX7Z7wXlK5KPOYLZm/KaJGev4p3ZXDfYOFabT3rym7fYgTFPLy+yfdUdpbLdDJOPvC6/IySqvvaIsrjTjs2dQnS6yn3d+E/mK9s9H6/JEhtNmAGK36KLg8e1AjhXSb2anhase03XjCqoIPocBTmaf6kCgwRnuh986PqAvrHZvPJqfoA51yQcYRo539KwdDNCfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHB7laMB5gHxJ4Wu7Fs3F3jvI4JPuAJJhVom1cesXco=;
 b=wkHNRwTUsygSSO4xyxDSeSXLx31fhOxpF9k+LucOuPv3KkT44vhyMt2YMIeQc2cdM6L+8SQmNV1f2BnBFwteWuxrbkuejrJr6916z4Uunnan+JHaA8Qu0X2OcIYxxPz5W5pFNi8Kdy5J51zF3i5Y3b7+2qR4Or7r7qfRpOCOR57BHRY2n40+FmTGxK2uvTEPDmYw5YHNvvoNzH/C0FfkYkJytAKvFzsYRxMnr1AdOHrCUF+2ABo65x8b0lIhBvdK+8IpNokJNPmcXr6xj98HM47w6DMQbJwubkOJzUtXyfZI+PrbtxQICX4VywiWvACp+aES+pC3Fro6N8x000PLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:15:41 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 06:15:41 +0000
Message-ID: <6315c924-1d1d-4417-ac6f-a9b200c41f8f@intel.com>
Date: Tue, 10 Sep 2024 14:15:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] cxl: add functions for resource request/release
 by a driver
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240907081836.5801-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9257d9-6703-4467-dc9c-08dcd15ffef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFgzcG1ENEtLdmxjL2tPc2F2L1RNNUNNWjdZTkZPRkFNVkNzM1l0QUZONDFR?=
 =?utf-8?B?OHp3dDdrVXdtUnR2NGVYMnphako4S3h0cFRzL1lJNDZxakFHZmdkNzFhRnYx?=
 =?utf-8?B?MDVhR0VaUDBmUXRmQXE3ektGa2ZCc2tRWnJZZ0FmcXJoUWVVQU83aVd4ZXZW?=
 =?utf-8?B?VlZnZUNIQWsxS0hucGM3M1FSaEdZbWdVOU1nb29Id2NUZnVoUWVDelZYMllN?=
 =?utf-8?B?VTRhK01iY2pqOUxVV0YvQ0IzYlNCUGFiQVNJdTNHOElIK01POVpVMUN5cEhD?=
 =?utf-8?B?WGdJZzNNWHRkYlQ0RWxhQ2p0MDhYcGpuTFU0NUZNWnNsVnlRUzdZc1VpQ2No?=
 =?utf-8?B?ODZnZ2Uxb0JWNlJUTG9TUUtHMnlxVnpGWjFBaHdIclZvTUtwbkMvRXFsek13?=
 =?utf-8?B?ZlQ4WjdtcVpzZmIwdmVxaFdROE40bnZXbE10eWJPK0NrangvV3hiUHBIajNp?=
 =?utf-8?B?bVVGY0p6OTRING9ZbGxvZnQwZnM4YTcyU2lNMmx0RUp2d0ZqbmlmbGYvZm9h?=
 =?utf-8?B?WHk4OEJWZ2xPZ1pDaFE5d1BtRjBydk5ONSsrOFAzbDB1MG9TeHVtSUVvQkVx?=
 =?utf-8?B?dDN5QWxGM3VmRUZadTF0ZVc2NS9zdVBieUJha2dwUFBhZ3pvdlorU05GVWVL?=
 =?utf-8?B?cHNUWUUxR1QreS9lRTR1UDdwb2FjVXdQb2kwMEZYaEdhYTlFRGV4aTBOUklX?=
 =?utf-8?B?NGh3TEJhS3YxejB4bGhOTnJsY0E0aWc0a1JoRUc1VWtWQzdLcldmTFl4dC9x?=
 =?utf-8?B?WUk0cWx0S2ovQjJkOU1NSVYzTnp3NmZmeE1NRk8wK0JHcTY0R0Y0WEd3Yk90?=
 =?utf-8?B?VDE5VStuVTRVMVNqQldtWThPUjJBWGJoYlplQmxBMlI1QUI2N0NPZFRJTXpm?=
 =?utf-8?B?MFVaWEp3eWZqb0JZZGwyckltQzdSMDJ5QkJtYkdpSFdyU2pMdkx3dUNlSGx0?=
 =?utf-8?B?aU15RFIzZEM3YXowc3hhOGh2enNMWHFKWkU2K3ExclZBTXRuWVhwZEoyUzVl?=
 =?utf-8?B?VEtNNnFQb3M5RjAwdkpXcWhpaDhQMEM5aHYzR2NVUExWc0l3dFBIWUZNLzJC?=
 =?utf-8?B?OE1zKzlXUzJkS1N1YkVqS1V6anQySitDS0J6SS9ka2ZWNnNndmJWMW1haXFk?=
 =?utf-8?B?NHV4czlIc2NtdFMxWGVUaHNiOVFxVE9oNnFCUkxEMGhHSmhuZXRmaGdoWG0x?=
 =?utf-8?B?Y0VNS1RrZTlqb0drdHBUdnk1MWplWWxGR3BVN004ZEowMytMYjBUZVU5aW9U?=
 =?utf-8?B?MTFMTTd3SEhFdzBoNVVZQmVSeExjUGhWajZkVGw0U1FKKysrZlFxcEJ1MmdJ?=
 =?utf-8?B?bGFDNkU3b1gzWmNYdTZaejg1aG1BYXVxUmtNWkg3RUk3YVlIM1Jmb29wS3Y4?=
 =?utf-8?B?TUpFR05QeWt5UlpudU5xeWdJOHdpYUhCd1YvQTV5UDI5cnhMY3JDSjFsYVJJ?=
 =?utf-8?B?Z3BmY3FTMGFXWmpzOVpxN1dObTlmcU8wcDhJUmhXamw3OEtoSnZjUU1CRlhK?=
 =?utf-8?B?T1ZudmpXd3E2R3FJL2ZXU1czVml3LzVZWkltemtXb0ovTzg1aVhFMDFseWVw?=
 =?utf-8?B?UVREOWgzdlA0akd2VDlFLzdrVjFPT3JOOGQybU5HdWc5VWZiNlg4dUtGZnJx?=
 =?utf-8?B?QnpBejl6dE9yZUxrSCtidCtNSEhLSXBVRXRrYkRybHRVbHQ3TWFPOXhUVkla?=
 =?utf-8?B?eDNrak9FT1VoVm5yc01aQjB0VXlNYzYxQnBsQktTMjdBbVBFNzFaSGI0UEJI?=
 =?utf-8?B?OTExeHlnNVhwU0xaZjJ0TG9RTkFaNGtzNzBDNUJCb3ZWYVBtSkdxOEhWL3NL?=
 =?utf-8?B?aHpDeHBhK0JXcCsxRW9rYkFIY0RkdzA0L0d0M2l4KzB3bzhOem55OEtHWWV5?=
 =?utf-8?Q?TS1bzRX0dTlFI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhUTEVRUVVNYUZtNVltSzFBbm8yTnJBWmhiQXdqWml6aThnTENyY2pma091?=
 =?utf-8?B?YUFjY092cTkvdGdCcW16d3lkK0RVeTJzdUVvaVpxdy81RTlwTG1ESG1vYzB3?=
 =?utf-8?B?S1ZjVE1oUXg5RXJlSG92cDZaMUIyZHpPSkpIVUpmRGV4V21KMWZueWJoNmVV?=
 =?utf-8?B?WTJaNUlRMEtQVzlxZFRuVlRlcVM3RGNidVQ0UHhyUndCMHNodmJFUjZaRG5B?=
 =?utf-8?B?SUY3ZTh6Vjl5K0FUTXRiV2Q5dklXNFVQK3RPOEVWUFRiK3EzTFRTb29mTXZw?=
 =?utf-8?B?WUswVzFsWUxUTFhhdW9OajNxenpyN2dFRThhR1ZzeHUrQjV2Y2pEdXgvaVoz?=
 =?utf-8?B?OTJKR1B6TzV1UW9TUExOYXBHcmpaRE02RE1IQmxEd0ljbTlIaXNLT3FxQjBJ?=
 =?utf-8?B?MHc3eUJrZU83Z3RPakVzbUNUaWNoT0xCaWRtcGRVcFpRZkFuNEhtME5HT00x?=
 =?utf-8?B?ZTJYTnRCUEVoVHFQSmQ0VVNoajByU2lxYlRtYngxZUE5ZXMzK09WMU1FZXht?=
 =?utf-8?B?TENLL1g2ZEtGWGJDN25jaVBJUGpGQ0tiSnBkZ1NFbk1Hc1RCb0YvZE05WWE2?=
 =?utf-8?B?TXpNWjF3K2ZwbzlBWW1aUHI0QnhrdzVaT2t5RWVacDdVbmlpemh0NlRoNkRO?=
 =?utf-8?B?aHBaaUg3RFptSHk1RkxJdVZyODU3UXYwYVlseEg0dGZsejRNU0pjSWNudnhB?=
 =?utf-8?B?b3BRVDg2SHhvV2VrbUhYK2tMY0w4TTBaZThiSU5qaWl2UWcrdDZXRW11T2RS?=
 =?utf-8?B?Nk91ZjdRODJJVDRuR0ErYTA3VGViazZtSDB2S3dJdEFBMU5lTStqYTBqVzBt?=
 =?utf-8?B?TWxSYUZuT1VUVmQxc2xsNTJSaU5oaTBUdWtrdmkvU2FzT3RwM0NaekRKVGRL?=
 =?utf-8?B?TnBBMHJSL2QxVWhRMzZKOVUzNG9MMDNjZEFHZGdFUFd4NXlBeDhRY3l2SDBM?=
 =?utf-8?B?QTB0QzBseDNmVlhaUEFzb3N5Nyt1M3RMVUZSS2ZYSWJzTlBOcGhLNEYxNHVZ?=
 =?utf-8?B?VGhCcThNR2FjRUZmTzlOZkpOZHN5U2dHeXBvMUg2Q29zZDJhQUZybmRoRlNJ?=
 =?utf-8?B?dGhEdXNuSmVxRjRyL0QxdnNHVkw0bzBkcmRiSzFyM3hIbk5HNnJqM21JU1Zi?=
 =?utf-8?B?K0Q4OWdEOFRER081QlRlb3RqaS9KNTRMaXZPU2w4ZXBEc1JiZ1owV3FYODE0?=
 =?utf-8?B?bHdUOUFBRzUwWE5CVldvYXByQ0pNSE95ZVdUMUkrZUxjejVwaE5ka3EzYk0r?=
 =?utf-8?B?eUdVSkY2STQvN2pwbFhyUXhFdGJXOGpOZjNJMnZHcm0rMFVYZjFBRUxoc3Nz?=
 =?utf-8?B?REdzS2ZFR3ZPZGhYWm9XRU85VEFvSmZONkZqQ3VMcG9rV3dNMk8rSEtrMXlt?=
 =?utf-8?B?NGJKUG1sdWJ6aXhzWTRiOU5zZkdCK1MxMDVVSy9sUituTnNRQVN2Mjh0NTlR?=
 =?utf-8?B?UkVQbmlHS0pRa3FCN1JVeDhLZ21HYVhIWStoMU5ZUytybFM0NUVRb0VZbnU2?=
 =?utf-8?B?M1VIQnVKbFZjb3NYSUwvcGZXdFVPT2ZHOWZCbXhYbUgreXU1dmJvSEQ1aFRV?=
 =?utf-8?B?WUNBSzdIeWlDeHowTUpiY3FEU0dzL0NSYnFVNE1meVRxdERiczFXQkFQWXc4?=
 =?utf-8?B?Z3dCOGNFejFpdjVxT01aRTk1S1BsVVdER0ZROUFRS3cvZ1phb3NKamNiK1BI?=
 =?utf-8?B?SE85SGVpSlhDTVdNU0FTOXhQUHBoQU1HempxSnp2ZE5VcVFTUmpxNTNQQXNa?=
 =?utf-8?B?OTlaaTcyS0d3QnJvb3o2cjFIV1RINURjVzVPWkU5L1cxYVc4RjBXL2RxS3Fz?=
 =?utf-8?B?a0xIcEUwWjdqMzlqL0pEOTdQZGhsdksyN2RuRjhCaEVoeDNSNzlzeFJoTkRu?=
 =?utf-8?B?c2lLdUYvS1c4Nm41c0pPZi9LZDRDSkNuR0toeUFOci9WcmNsbWRLZlJWMCs3?=
 =?utf-8?B?UFdqWUFrMjJBbktDd3Zodm9FMGVuVURzZGhQcU9qTUQzRjE2OVpMVWNYTXl4?=
 =?utf-8?B?b3Q5Mmxlb2NWOGxwQVBUTE1TTElsMzhsa2NrOGhPY0pEVGVJMzY2NnN4ZEVh?=
 =?utf-8?B?bis5RHk0d2JVQStIWFBWSUYzNGpHNUxOTEVUVGg4NE5aZGtZTDVLY25KR29G?=
 =?utf-8?Q?Hf4kqt0r/3OpHHDmeF1sqJ8ce?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9257d9-6703-4467-dc9c-08dcd15ffef6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:15:41.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pFMokJ+5sfEFQ3Lza7p2Wy13l5iQwaGI4nSisCUHp2d4FPMEpGRZq9fEcRjH9IJcB5ZU4d16skkHQHsH8Eqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com

On 9/7/2024 4:18 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Create accessors for an accel driver requesting and
> releaseing a resource.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 40 ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++
>  include/linux/cxl/cxl.h            |  2 ++
>  3 files changed, 49 insertions(+)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 10c0a6990f9a..a7d8daf4a59b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,46 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_ACCEL_RES_RAM:
Should check ram_res size before request_resource().
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +		break;
> +	case CXL_ACCEL_RES_PMEM:
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
Same as above. Checking the size of pmem_res.
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_ACCEL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
> +		break;
> +	case CXL_ACCEL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index fee143e94c1f..80259c8317fd 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -72,6 +72,12 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err;
>  	}
>  
> +	rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL request resource failed");
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	kfree(cxl->cxlds);
> @@ -84,6 +90,7 @@ int efx_cxl_init(struct efx_nic *efx)
>  void efx_cxl_exit(struct efx_nic *efx)
>  {
>  	if (efx->cxl) {
> +		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
>  		kfree(efx->cxl->cxlds);
>  		kfree(efx->cxl);
>  	}
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index f2dcba6cdc22..22912b2d9bb2 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -52,4 +52,6 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, u32 expected_caps,
>  			u32 *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif



