Return-Path: <netdev+bounces-229590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09EBDEA72
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD423BAABC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7532A3DA;
	Wed, 15 Oct 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrhoHyx2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CF32A3DE
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533708; cv=fail; b=uiTXOXpsCeGgxzANpNMhxNGod1+QupnpCYz1HVz9NPn+DeACnoDLvODIKp9hUjUeS7x3geTmm/KVPKzaC2J+jhvvfNPxMkxqO3gKQ63e9C4ycq9uZya+TnfDvYEk/NjqN3bzlY1IaQ9JFw5aH3X0y0Vd8pqdRdrR20yiDGVh0hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533708; c=relaxed/simple;
	bh=3QlDE181CVS7qRdjdQ2lzywlSs4V6k5WLTFZRWVmkVs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGDxA/Fm1nZcQUl6kfQtz5hnJmpn4MRzHID9w9hqZViB+y+E+Ng4QeUdevFyNcsnctq/ewBObPDqVYHLcxkMfYIRY52lKIDlYbBEvRdLV8E/cdAMB1UsPLhiHBJppln2mEe525FXrklfut85KAhxRIS5qdetFm34ZRQR/qf1qgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrhoHyx2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760533706; x=1792069706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3QlDE181CVS7qRdjdQ2lzywlSs4V6k5WLTFZRWVmkVs=;
  b=LrhoHyx21AJLyD+10+w9S4Hg0YwZYWm3/4estH7Ph92XuW/n5T8dWsEb
   C1FNygRNBtyqYAW4wrz1B7jtLzGgoU8H3wA4bSayjy7V/HlPUUkFKBdrL
   SyUotwUbOVTRxy2oiZHl19OZaQCCuHl9xDouYcpYWhmYMZigiOlBrI9/k
   bu5rot1IQM6IxkjQvWCUiTu8Xbk9xfH02JCalCcTjO+0qRJeCXUj8scPh
   8z7prrRnNPHGIpxV85Csly3Gpd3KqbrixypAdDg+EcqFzUvsWxW3lRAdG
   6+LcNQO4SnJhPvQRfHX5AL9ZznDTv7FI4QGXiAzp3hl0d6wUR7SCh09cT
   Q==;
X-CSE-ConnectionGUID: ZR/zXjhxSjmOp96fkHrttA==
X-CSE-MsgGUID: ZYuCX7BvRmmSOFMDkuXPKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="61737959"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="61737959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:08:25 -0700
X-CSE-ConnectionGUID: FJQnGjUVRDKpCZ8/E6IcmA==
X-CSE-MsgGUID: MrhmZtlxS5i+j52VlIYe6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="181844685"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:08:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 06:08:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 06:08:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 06:08:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS/xQf4nFbZzw9p1TyEMl3mgmx8LC+n5Rns7UkqCB9EcbQ84N4Ej7kep/c1VmubcU1nwp3FuiVCufmwTZRGMzCOG8shHcIeO3f+bim6BlNqbH8EANa05DQzTZfyOeCfwSUODrCliJkWCo6hTFaM06qF4AWnobFw3f7SpAB1y5VBEJzlBgahIlYli15RMi8A/RKMgNLPthk7QeYEAdBIvFpIFbxB6qmUc0dA0bPYz4rhoWImMpbIuoKaN7Ff2p0g2kxFPXQnFOXEWQh5lepHG8YLmhqJrnonJlkSIZov3YlvFSIRfgzPFqbRJGW3SQ7I117rTBl27LY6itUGDiHIXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsKvugs0xY4YnPAqfP5fQX1lhta/QpXkmaMB3yImB9M=;
 b=TX9/NL6SoUIgcaBTUvVyMTs/ndMSgtK6pJmuWLWFTJWFrN3hzllw+HbuMHQBhYh7pIKn8Js84tFTcsK7/oBOIsDSyUDL7clcLJ5Y/xBsFntGbLkImL533bT3FotaRfp0APtcj1dQDwQiI3M4z1PRRR0EYgUoq1qjd3rc40HqLfBzWILR9XIMycBd38tWxCfy774yrcOl4InV5/XGpU4Db94R1lhVSDpZfHqcIr9RibcLBBgL0NjYcAznP1IL7Cs+1ixfH39P7htoDhZ7LM1TV3YxUXwqC7PzNvNUlkK5nqsEVR1bkX3M3MpNcW960AMHXQMAWuLb975DkPfoc+HTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 13:08:12 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 13:08:12 +0000
Message-ID: <c09e552f-883a-4e23-aaf0-5626071524bc@intel.com>
Date: Wed, 15 Oct 2025 15:08:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in
 skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima
	<kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
	<netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251014171907.3554413-1-edumazet@google.com>
 <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
 <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com>
 <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
 <9539f480-380b-4a29-afc5-025c3bf0973d@intel.com>
 <CANn89iLVxzmJrxhyEXYp26V9SZy5D66PS4ywf=vZ7piK99Hdww@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CANn89iLVxzmJrxhyEXYp26V9SZy5D66PS4ywf=vZ7piK99Hdww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZP191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::18) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e812751-37d2-477a-fc4a-08de0bebe3f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm1QZkNLVEk0ZzYxUzVvdzVKakl3RE9QS3lkajJscHl2SG9UZDNOTExCN2t3?=
 =?utf-8?B?YnFQOVF1aTZpVGtiTEgzRjEvU2RCSVUrdWR0NSt5N1RnZXZDd0NSZElyTmxx?=
 =?utf-8?B?c2szcXM1NmpCc251M0JTNkxDMEhHUkx5LzNaeUdoUGF5MFJiYUlIdjdleDdk?=
 =?utf-8?B?NlFUdE9YWERydjlSQndjU0NrcTRXM0JYWm5WdU9pVkdKZmkvY2VBdGwxQ3Ex?=
 =?utf-8?B?NmttV1dNRE1YOVk4WGJaSGx6dGdCNUcxRjRoWThmNFdJMzZIa3BVMnBzL3ZQ?=
 =?utf-8?B?TnZLa3ZDNGFGa2dRZzlrMDRtbFl3R0kxc0J2UFJVMVhHSHNsM3NUUVJuMzVM?=
 =?utf-8?B?ck5xRHNkNEFWOFBjWlQrRkxhckZQNmlrejd2cm5NdlVFdXhJZXhPbnJCT3Er?=
 =?utf-8?B?TE1Yc3hZL1dNd3FlZWtxdHZIenIyOStTcWlRTHZoVXJMcFQvODZvbEorNmFa?=
 =?utf-8?B?V1cvWnFneForY2R6cjEydE1na1pRdENvSjAzSHRCbC9scVM3cXhyTWZudG16?=
 =?utf-8?B?czU5RGVpbVpYdTllMCtjanh2Sm1EMm5sYllXR216N3drQkQvMmRyWjRWcllT?=
 =?utf-8?B?UmNSd2hmT0huVmhQNkdWcjd3N3hpVFAxczh0MmhabkV3SlQrR0hwUGNqQW5I?=
 =?utf-8?B?ZzRoYnZ0RjduOHIvZzkwR1U0TU5iSWRyamV6a20wbjB5ZmpZbnYzelFHZkhC?=
 =?utf-8?B?VlNOdzRLd2JHOHozR0VyellXWDlSUDBCdFBkUGp0WXFvaEtOOTRoUlZCMGFZ?=
 =?utf-8?B?aXFDcHRGTmRWOFY5eFdja2RQSXFJbXJZN3g0d0xzOTNqWm56a1hEQTNXQ0k5?=
 =?utf-8?B?dk1hWHpLY0F0M0FKTGkxbkZjcjlIaFJLbGdRTmVQNFVWUk1rc3BjcklySUg5?=
 =?utf-8?B?WjhBelNrYWdlWVI1cWFiRWFHY3Vwc1JkemtpQStzYnA1ZDVJZVoyanJ4UlQy?=
 =?utf-8?B?ZnREWU1aOEJzSmQ1VHFYMUtVY2dGRHJITnU4Nk9iQjFUTks3amIweGRQZFVK?=
 =?utf-8?B?bU9BVThlS0lTZVN0YWM4V1FhTlBSQUY1QXRlLzQrSEE4QzYxVW1EclY1bWRU?=
 =?utf-8?B?ZTVuZDhmMzJ4NWpzNlBPVFJPc1R5VitxSFdhRHhyQ0d5MUVWN0N5c1F4NXBV?=
 =?utf-8?B?MTVxdFFLZFh3cFFTOFlsYjJHK1dEZTVSUG1SRHFMZ0wwZElKczhucUdJN04v?=
 =?utf-8?B?ajQ0Qi81UXpTS2w2eWhzR0hXcU1iUmVLL3JpZWNya0FrN1NIaWkwWC95aVRZ?=
 =?utf-8?B?eGdncmhJVlE3THcwQ2tIR0VPV3RRSUdMRzd6a2JLUXRUblJYc2crUDN5Q1FB?=
 =?utf-8?B?UG5VTG5aWDlDYmM1R2hsT1p1UEdmTDNoQzhpVi9wdFJydEszQUZ0ZTNCaDdt?=
 =?utf-8?B?Tnlmc0c0NVVrbXV6YUlXVHdCdWJ0YjJHcDRpeklPZHlaWjVkZ0dBNDVrakNl?=
 =?utf-8?B?SUI3OU1JUHpnMXcrZDhCN3VKeGxBNTduQWtUalVlbnlYVC9IY2xvWmFEYWFk?=
 =?utf-8?B?cGIxdEhsQWJmTkMyemlWU0FoT04rUmlBQkZJQi9NSmlzS1BaWklOTlNJd0lq?=
 =?utf-8?B?TDFnUzY3NVlvNFFza2RHaW1qNm1wNVMvU25jM3RMOHYwR24rL0xGM3UrdTln?=
 =?utf-8?B?b3JmRGU5dmpOOVNiY21MdEtPeHNLbEU1aGp5cG1HZE1JelB5QzFrOEw3R0N0?=
 =?utf-8?B?QWVOeHNYNXBvaGZrZDJycjF3bG1Za1k0dkRUNzYrcy9SbG04cEpnLzd3ZnFS?=
 =?utf-8?B?dWZjL0NpM2IyT2huRFkyem9NVGNqVmFNdGh0RXlXOWEwbGdRMUlTL2UvMnU3?=
 =?utf-8?B?MElGUWt0U3Zlc3Znb2VDRk13U0hBR2JBMWRmclFxSk5BSFQwK3VrVGEzbWRM?=
 =?utf-8?B?WGRFSi9JOUhrNGJicUE0N2U0SzBjcXZ4Rm9GQ09tZ1d5dThjVlpFNWN1R3dM?=
 =?utf-8?Q?5S2MpJwJ1OZ58Xu8BJ8oJX9YZdCN2JKX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0t6QWJVUlU0ZWR0NlZvK0lkZW82Q0dUVXUvQ2VOSUU1V3dMUTl2Z09SeEpi?=
 =?utf-8?B?aEdtY0xvQ1AyWEFPdlpzbVUyY3FadDk0dk1FUjZHSzRtVUxRTDlyd1FnMEpC?=
 =?utf-8?B?aWMyUEtyUkpscyt4em9LbHBmcVVZMW1IY0EreS9oZXFyMlNLQTFFdGVSSllC?=
 =?utf-8?B?cHFCU2w0MEpxNDV1NlJiWEcweHo3OWFhUGw4RGh6Vk9OUlpoZkV0MFV4eFlE?=
 =?utf-8?B?b2VTSSsxMmR5QWJNdEk4U0Z2YW1YVnFmQlB5VGlIbjYzUVYzQm8wTEQ2MmFm?=
 =?utf-8?B?TzYxWGtrdHpsdXV6VDU4dzdpbXFEd0h2bTBwTUNrd2ZPTVFNTGF3RnJpMFlZ?=
 =?utf-8?B?c0kvYk9ISENzM3l0VDJtZTFRdytkQ241SFYzaldJMUhtbldVeWdnN0VzUHht?=
 =?utf-8?B?aitMNU5TeHNVMmU0TnA0WnV2V3g4enFtSCtraWovbzg0eHpZaFVYd0s2bHZX?=
 =?utf-8?B?dWZNc3diemcxelBLd3BlbmVDcWkzNWNDTzhDQWZwNlZva1g0WFovK1VUOU1S?=
 =?utf-8?B?OVJZYzB3Y1RLWlJ3M3NlbTA0Qkc0ZHN3ck9iUldFTUNQSkhMdWViOEo5WGkw?=
 =?utf-8?B?eG11YjUraGxTYU85YXgwL2hWMzNmYmR6eHFwYkowN1d5VCtxL0VEQkFESmhu?=
 =?utf-8?B?TW5vc2VCdXlkNngrWUladDdsZUt3dkd3Z0E0bVVSWVlOWWU5UVBTdVJUVng1?=
 =?utf-8?B?cHJtc0hkdHRiaFc1TjgvZWdhZlRZMGM2RWxNdEppZzlYOW1rbXVBWTZOOU5Q?=
 =?utf-8?B?bkNtc2ozNDhHVkRHK21CU2c5ZEQ2ekhrSE91bWpHcmY1OGVocmY2VjF1QXU2?=
 =?utf-8?B?cUFuWFFRVS81VjRlUWZ3QkJhM2JGSHFnVTZaVWw1YjcwMXlLRGk5c2JJa1Vj?=
 =?utf-8?B?MXBWRDduZ3ZadHppQmtUeHU1Q0Q4SjFhME1FbzlJUFE2MWRyMGs4d3RVT1RI?=
 =?utf-8?B?YlFWeG51eXZ6TG9uM2k0M3IxWE9wRlJQdDlYdDVNN1Z6b043QjQveU8yZ1Vp?=
 =?utf-8?B?bTE4TldTNkJNR2hWQU1mN2hLY1BPTWhvSC9XU096UXRYS0pDOUtqVW1Rd3ho?=
 =?utf-8?B?SFdxUDdTeHZUWEFBd3U3T29SWGM1YkQzdTlGeGEyWW5rMDRHKzZnU21ucVQv?=
 =?utf-8?B?RTV5M0htM2QwOUtNVWhqN0NMOXNhOS9GYjBzQlJvcWtqQVZXU2loSWJzNjZE?=
 =?utf-8?B?ZUFWaEptcUJsMmtFbUg2ZE9UbytPUHVURGhIM05GTDBpVFZiWFRWajhVVnNh?=
 =?utf-8?B?L0hNUGptbENSYzhiYzVncE9wNVJnYnJ5ZXNVK3QwMFRxTjcvbWlrR1dackFv?=
 =?utf-8?B?RkErai9ITC9uZU53VUh6akdKU2cvNGdnL1krVGZnRXBHZ3Q5MUJmR1BhMjJ0?=
 =?utf-8?B?WUFZbTZNVUk0YTNsZGZVRkFyL2k3cENIRGRTNFpJenZpV1VoQkhabUQwQkxu?=
 =?utf-8?B?R1RaTFV3TnZiZXZmaFlBbXhkWjVrVkkrTDJ1SUtzYWdacUF0OG12dGZkSkpi?=
 =?utf-8?B?RXYrcXR6RDdPRC9KK2J4VlFXYWtJOUFWV2E2NUM4ZXc0SVE5emo2K0VRQlY0?=
 =?utf-8?B?YnB1cnBZS0cvYTd2L282NHliRGtWcnRGMVJ3RTRpdmo0ZDB2TzdpZENtWkxD?=
 =?utf-8?B?STdaTVBVQTNTd3Zvb3hlaTBtMEw2UzFNUEsweFFBRG51L2s5QmRBS1ZTSXdR?=
 =?utf-8?B?MkhLR0xJT2Rmc1k0aEwvMUdjNGZIYW1OYzNBOFgyTkxybWhGSzBSb2tjSGhN?=
 =?utf-8?B?VkgvWlZWbDQ5T29Jd3kyNVR1d01ZcUM1aEEwaFpWMWdOK0hXcjBZYUJFeVcx?=
 =?utf-8?B?dm1uOWFveHRZYU9sTTVLQWwrSUtsZzI3M2lBcE55ekdJdmZzWEdGWUswVzRp?=
 =?utf-8?B?cGt2dytheHVXVUJweWpuM3dmOEdvWlVQQ3JOaHhpeXNMSTlycVFCY2IyeHZi?=
 =?utf-8?B?NFVvd1AxS25XYTVuL2lIdzhmM1hieUlSQjZwRXRzU3VjUEd4WnlJTEQ5YU56?=
 =?utf-8?B?RkUwUGo1djNUNWNXUVpEK2JDZmc5SkpEWWdSVnJFZjdSSCt1c2MzSFpETmZj?=
 =?utf-8?B?Y0daVjFGTW8vNFJJalhKeTJqNzVMTUlCOXY2a2I3QXVXZ3dLcjJLS1ZUTWtx?=
 =?utf-8?B?dkVQaE94N2JBUkxiNkFtaVJ4cVpjK3ViVEovRVYzM3JXblRnNnpiSWQxMUFT?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e812751-37d2-477a-fc4a-08de0bebe3f8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 13:08:12.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuP2QNG732myKOlGz71NG11bEQDovjWA789jcMYws3gYBIKbnjJ3orUyRmAnKpMJQflHnsaSnT0Go3NGfF3aYOXELCK6i2qQk/V1eaybrG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 06:01:40 -0700

> On Wed, Oct 15, 2025 at 5:54 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> 
>> You asked *me* to show the difference, in the orig discussion there's a
>> patch, there are tests and there is difference... :D
> 
> I am afraid I have not seen this.
> 
> The only thing I found was :
> 
> <quote>
> Not sure, but maybe we could add generic XSk skb destructor here as
> well? Or it's not that important as generic XSk is not the best way to
> use XDP sockets?
> 
> Maciej, what do you think?
> </quote>
> 
> No numbers.

From [0]:

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Oct 2025 16:37:56 +0800

> On Wed, Oct 8, 2025 at 3:42 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
>>

[...]

>>> Not sure, but maybe we could add generic XSk skb destructor here as
>>> well?
>
> I added the following snippet[1] and only saw a stable ~1% improvement
> when sending 64 size packets with xdpsock.
>
> I'm not so sure it deserves a follow-up patch to Eric's series. Better
> than nothing? Any ideas on this one?
>
> [1]
> INDIRECT_CALL_4(skb->destructor, tcp_wfree, __sock_wfree, sock_wfree,
> xsk_destruct_skb, skb);
>
>>>  Or it's not that important as generic XSk is not the best way to
>>> use XDP sockets?
>
> Yes, it surely matters. At least, virtio_net and veth need this copy
> mode. And I've been working on batch xmit to ramp up the generic path.
>
>>>
>>> Maciej, what do you think?
>>
>> I would appreciate it as there has been various attempts to optmize
>> xsk generic xmit path.
>
> So do I!
>
> Thanks,
> Jason

[0]
https://lore.kernel.org/netdev/CAL+tcoBN9puWX-sTGvTiBN0Hg5oXKR3mjv783YXeR4Bsovuxkw@mail.gmail.com

Thanks,
Olek

