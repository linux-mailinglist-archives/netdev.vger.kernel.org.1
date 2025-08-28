Return-Path: <netdev+bounces-217903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F2B3A63F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E95C984F76
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395B322A38;
	Thu, 28 Aug 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVxKFNL2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B652236F0;
	Thu, 28 Aug 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398520; cv=fail; b=BG0uD4tVWGGiAi4urXcm+UaGaTBXl2Xn5bH1A6R4d4ap8OOThhQfO4w/v8LePwcR6ltlqFSVQr4/i+o7Vzi/2uQXEzOcm4GwTnnUVxw0AbTuDi3u45kUgcYQ3AGOdjt2mM8n5WIyDJT1lH2SHTd/4691F98W4Otd/p84G2cJJp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398520; c=relaxed/simple;
	bh=7WYeOP5ntnihjVMEe9xniwvqn0A2hifnKzG1a3rSCWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DCxZPevPxEUy/EdursQa9YkCZtZ8SkgTJMSg12XjFqi48edpZfvTvwCHJdeAuehrk+JHXykGEccp8P4ssaAT2RAtNTVdki/wnRdVQP0pX12nD3aB6CgYDc+tePTZz+9MKsxl4VZJ5bvqBk5k2emmF3oIvDnFpqoV6U5y5EqxxdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVxKFNL2; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398518; x=1787934518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7WYeOP5ntnihjVMEe9xniwvqn0A2hifnKzG1a3rSCWo=;
  b=FVxKFNL2n1/og6Ft7ohiQ53MXkwTghee02we3RLOAzTu7IkRA4h8e3kS
   h0w8UwMjCokA8VG5XfbLSKdHoAbL8pYZHZ6TjuguXoWanPHN5xv6MyOsf
   apn2994GvoQFoJwjlN2jayApaGorUFHTJTEtJgrtAqkn7xRZxTgSEStfJ
   MeXXQuO6Sl7+5+ohJeFj5juJDiiMZwiWG+HjxSWKcTVERZOEswe8tsIE7
   SavfPvITB5IvzlhBQ7YR8lsQFFIjfYiEkNPktxG4fAYYqnzQP1pqUffIY
   iUpVO/gy2D1PCx8E0VxsI9BgERucG4CLv8eq2l8gpnviU1rV6cD4eGlNk
   g==;
X-CSE-ConnectionGUID: M7ZvW2JpR0u1Bh4Lzjr5dQ==
X-CSE-MsgGUID: rV3uK/ngT4CYaS5dhRArRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="68950043"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="68950043"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:28:35 -0700
X-CSE-ConnectionGUID: YMU4u7VtRU6pgI6BHC48Zg==
X-CSE-MsgGUID: nCD6ECwyT1uQo5lnv0XVmw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:28:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 09:28:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 09:28:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 09:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6D3TblZzWZmV2+nBDyWG59Q7tAFlh8ISWIKKvXixlJj3OPoXUAmhULICKjmArfIJ3XHUcVdifGGZxYfLbs6ovOcBnL0NzH0NVb9lMGgepgmunVO16xrU/vCdsLhEPOdxEF+J27aQb51nJe1YqEcLUhQeGDouzO4VtELz9Oy/UTmurpwPjrCwU/nWmPz4Ht1e4b4Ar3pvoQHdybnqGlergay55YYuXJFlaAJPTH3Djmrhwt+IQ+auXcUc5m4hh2CDfBWbnown1tsxqpLp9GaCmI4unTxQvjwRUbXz9lBNrcErtnzv0kAOx9sng0L0u3M12zSct3RHQK7bWItYsQSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kZqMRehLm0ZnyjEqa6ahvHHnwvSrV0vWaQxnud6CeY=;
 b=SDiTOhyBde2IZRa3ec5QgLJqVfqW24ZqG/L5zB/pUXBfdgEJxBwGks8YeIiJGaB8eDmxyVhUnzIZJYWaq2b7pWHKXLWUVtZyBnf+jW4UcQWTtkyeDduXoewPc7X9RLTQU+ez1fkEoSvkPVehWQNVDaRuKgspab2Js7FsM7zHUwTse5FLekLm9a8dG9YdcuRN2JGZshk3Af/pmzUVGDsHSYlgQU4GVSnvebDZyc/yD/eVaGkLpLLAoZGK4Z/wzC50zPAqXMaunjxyHdo/E9u/11iX499pGSi1vwiQW6PR1V4Dq/sCRCvNUeRCZahd7ljt/iTy78xK+c+dYQuoP4+TEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 16:28:27 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 16:28:27 +0000
Message-ID: <c3d549db-bc7d-4b89-bc30-7fd4ec6f20e1@intel.com>
Date: Thu, 28 Aug 2025 18:28:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] amd-xgbe: Add PPS periodic output support
To: Raju Rangoju <Raju.Rangoju@amd.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>
References: <20250828092900.365990-1-Raju.Rangoju@amd.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250828092900.365990-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::29) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: ba13b344-9509-4801-33e8-08dde64feaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWJMTFM5UzBKS2JTbEp5bzFtbXRKYU5oT0ZQYmNycUM1dTlGZTRISFlPS0pJ?=
 =?utf-8?B?Y0NsY24xcklmUFJzNG5KNENRZDhDaTlaSEtlZEgxY2RZUEhYRTJ1UERoR2tx?=
 =?utf-8?B?aXpmNXZtOHhqMGZKU1FwaW1UZjdNZExoVE5tN0dLNTYyVFRlQmdKSGF6WUVK?=
 =?utf-8?B?RDhvWGhmTjVMTXRpb1Znc1FyTE5ZeHc2ZGV4TlpIMFIxMkkxWTZ4VldLMkc5?=
 =?utf-8?B?NTV2RlBMUXgxc2ZkaTNIbjBuVkJGR3p2WkJnRHdjT291V0ZDb3U4ZnJqeVQ3?=
 =?utf-8?B?bWRpZDRFeUFsMW0zNHAxY3hpc3poWFRXSXlrazFIK3pjZ1c3cHZyWWkzR0ZQ?=
 =?utf-8?B?ZEc5enIraXNOcnRpNzNuNUxNMjB5VW1vNTNGeTBiamczaG5KSmdVdnMwVjhC?=
 =?utf-8?B?SjFzUmsyRXVrQ2Vqdzc0OE5Palc0bVgxZ2EvSFQ3Uk43dWdEbGEzWUlONXIv?=
 =?utf-8?B?MGNGNWNpQXNDV1MzUlNaVW1FTy9vbjdNMnp1d1dDS3BTSlFKV21RNWR2RFdr?=
 =?utf-8?B?VHo1b3N4S3dvYUZLek5JNzBHektJSWpXa2NkejZJa3JLOE91V3JyOFdKc1Rs?=
 =?utf-8?B?cnNFTS9xcXZXRkF3THR0NlNSNkhoZ1k2aGtPK21yMkNKeDhIRWFFNWd1REp2?=
 =?utf-8?B?akRwLzZ2ODZDRjV5aC92eldjaUttTERZQko5TWJleURrRmV2K3F0Y1BvMzh2?=
 =?utf-8?B?Yi9HakFjSmowUGFhTWxwVG5zZ2RFNEQrVUk2TVFLeU1vM3BpbHJOdG1oRk8x?=
 =?utf-8?B?Z3NhZk9LZ1FLbWNienZldWFNNjRVQWV6OE5sSTFTOTMvSFhkTUhuT0Exdkwx?=
 =?utf-8?B?a3QrYzlENC92T0dQVC9qbS92YkFZSHdPQW5WemNYWnM0QnBPUGdsRzA0YWZy?=
 =?utf-8?B?T2Rhb1hFRVRGTDZDZ08rcGxYNllqV3podDFjcUhzaWo3ZGRRZ1FxQTlnRVU1?=
 =?utf-8?B?YWVWeFI5dzlxcE8yNU53QXVrN1RaUUd4Uk15QW0wcEQrZTZ5VVZ2YnBEZFN2?=
 =?utf-8?B?R2dHbnRUV3BiUkdvcVlqTWpNWUtwQ3RIOWtNMDg2dnlaUFdYZlpWVjNJR1Z1?=
 =?utf-8?B?WTBZUDU5VlBPMkhOTm1VOXZmaHNST2kwem1Ra21XWFVXUHlPK3Z5bkJYWURB?=
 =?utf-8?B?VkhNM1NacnoyWVRJdnlKV1BObGprZ2hid3dXWHYxNXF1NU02Wmp1OG01c1Y2?=
 =?utf-8?B?T0VVWkJIZ0RKRWNWaThUU003SW1OZC9yK3FUSms4ekU4MXgyT0JiZTRvcUMw?=
 =?utf-8?B?OW11NmR1bk1pRGcvTXdjN2srV1hVMzJ3S3RmelBOOEVNZ2MwN0tCQW93aGww?=
 =?utf-8?B?WXQzdHpSOVI3cmdTRlpMUlhUTGxRRWkzS2w4N01yZDJKbEkwcXNLdVdtZVJ2?=
 =?utf-8?B?YzczU0xaVHBDdExRZGs5ZDNtUFVqNklZVnkrR2ZRQmR6NjVRcjRHdUQ5R3BR?=
 =?utf-8?B?QXFrcSs2eVk3TDc5YnJLdWpaSG1TOU43WUNFck94bkQ1Wi80WEJoR0dTajhs?=
 =?utf-8?B?V1FkNlQ5bTBXYld2STBvOHZzL3k0Y2Z1d0U5eDJJSWd1ck9jK1lUS1ExdWZU?=
 =?utf-8?B?TEVKbys4Vm8zdE5aeC9WUHJGaFFHa3hGZXcwWHduRmdYUGcxaGo4UG9KMGRG?=
 =?utf-8?B?Q3I1YVJ3Q3hvcnMwQUUyS2RWSDB5UmtEaUc5SmJtTTdua05GWTljNjJXdmhC?=
 =?utf-8?B?eWJzR0QzOW9lazhSS0pUWXNMcFBOUTQ4ZjNqRlcxZWZHL3krVyswRTk4L3pV?=
 =?utf-8?B?ZTROWGNGb0VudkNmMk5PUnRKeXIxUVkvSGZDWU43eWE3cUVhVWhCNHR4elIw?=
 =?utf-8?B?ZGxmbXoxcG90NmN1YmdETGlHN1RIRTZlamErd0Q4SDZzeDhWalZQamZBMHho?=
 =?utf-8?B?UGFxQkJGQWh1aUlnVVQ1MWNuR3cvenBuYUlKaG1yaG9vRVVnSis1ODhKT1JF?=
 =?utf-8?Q?olsTo+26de0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R21sdm9oa2ZWenMrdG5ycE1iMkJvdnFSaTlwclFnOWlmR3lDLzJhajkzTnZP?=
 =?utf-8?B?QU9xaGpXeUE5ek1sTzZzeGJKU0E3RUhxUTF5Vk95UHV6aWUwV3dsWWVVR1ZU?=
 =?utf-8?B?cE03ZlRra1hocVF0OHkraDlwZkMzdWV4QTY2bW53UEh4Zjh1VitJYldVVkp5?=
 =?utf-8?B?b3FnSVBsTHl5Q1huRVYrNkw1S0lseHpvTVF0M21XNkZHaElwbS9BV1phU1Fy?=
 =?utf-8?B?Q3o1NG5hMjFsZm92QXNXZE0zZ0hGdFRNZTZadSsyM0x2SmxjMlMxekhKS1J0?=
 =?utf-8?B?SzhhNWY1UkVnZk9hWmJxMTJ2cnhRb1FGME9xUlZKMkRFWVh6QXQ5MTNFSUpz?=
 =?utf-8?B?Y2JMSkJ6MnJYWEVhWS90Z2s2TGYrMXhaRVp0U3l3WEMwenFYbHRzWnBnclNx?=
 =?utf-8?B?VllOT2V6QTlVUjBJRVRBeVNEU1VOYjNNZjJCa2JtTkMvb1R4NkY0anZHelpV?=
 =?utf-8?B?RmJmTDZEU0hVaHZ0M0p5UGlUcjJkekFqeFZWcy9nS1lJUlQ4c1VNbGRPbVJt?=
 =?utf-8?B?MURZM01Ma1h6UVhBRlZ0Tm9aT1Y0c1ViaTROc3p4ZUhjZGtkUjVXdERxOTR5?=
 =?utf-8?B?YkhDL3pqaUNDRU9EMmJoQVd6THZPVUZ3bENCT2EyZHE5WEkrTElRR0pJY0tK?=
 =?utf-8?B?dGd4R3ppS0pBVmN3Q3UwMlFkd1hqL00rNXRIUFlGWGRHcFdtandBR0RHWTI4?=
 =?utf-8?B?YjdTcmVSU2g5NkpycVQ0MmlzRWJQWDhvN2hUYmZncFZTYWtMS0QybC9qaCts?=
 =?utf-8?B?T1F0L05sSW5YbHNHUTlhYmhHNHdaQktlN1c2d25qOHBqYzEzaFBxY0x0M0hZ?=
 =?utf-8?B?ZzNQaGkycGpTUFI0bkVKQTNwdmVJblhYdnBEMVlmZ3RlM2dDSUdCbGtnMTJF?=
 =?utf-8?B?eG5aczBtdWV5dHpUZU9nU2MxT01pWVlkRHpYN3pVWkpQUFVuL3VjaG1BZ0xp?=
 =?utf-8?B?NmwyTld1dFNhM0hOb2FsUlgrVFhjZTdLdEtodm9lQ09kTjVSUU9pd05IZHBJ?=
 =?utf-8?B?Q3hVWGhjWjRLOGhoUTRYeE5hY1RBR1FSeUtTRjNvWGtHK3ZOUkM3aTBRTnlm?=
 =?utf-8?B?NGVsa3ZhSkR6citKTGFhNXB3akdqY1IxbXlNL1E5bFhkM2Nsdkpwd3dwRFVs?=
 =?utf-8?B?Uml0MlVGZFhaSzRaMlJQYWJEdDJpK29IaGhwNTJRQTdNL0dWUUlma2M1QzAx?=
 =?utf-8?B?UkxyVXJKcWtIdkNCN1pQdk9Bb2RzNmNQK1g0K0R2WkdJN0xQNjFCellza0E5?=
 =?utf-8?B?WG91dDBFSjN4VHYzRlc2UW50VkR5aVcyUGdzeVJNODlsOFd2RFBpWHpGYTgy?=
 =?utf-8?B?Q2ZMb0F6MXpFUXdtSFZrdlNKNTZRcDVZWkNiaUdYemJOQzFTaHp3aWRzejAr?=
 =?utf-8?B?M09lYndhekNwSHZzbGM1Tms0QzdNR3E3cEF3ZFozY0tRSUpVbmF3djhHNkF1?=
 =?utf-8?B?UVEycGhYNTd4Mk9JbVFnaE1LUExKRTBhVzRpRDZRdEduMU9sNUxZVzVJVE8y?=
 =?utf-8?B?TDVhYnZiOEJyK3c0QW5mNmI1SXgvR0pxbzZWZmFlY2k2MzYzeXFmQ05lc2Fl?=
 =?utf-8?B?NHU4SHloaWpRckxGZndvZmErQTU2c3NjZitjYkowc043OHBrZHFOallFclhx?=
 =?utf-8?B?blB4SkIrcmZ2OWxBVFN5Kzdia3VzRXJWdTN2eklCSUlPcTMvZEpIN0hjMnl0?=
 =?utf-8?B?Z0RleDV6T1V4ODdlTDRVZWpEZjk1cHBtTEZDa01FS1F5blJxYnBoeDBuOVQz?=
 =?utf-8?B?YWdoVDk5V3lvcW9GTUZiSFNrVWFSaFVqN1JkTVZRdmE0dnU3Z1ZJRDd1NVVB?=
 =?utf-8?B?RzF1QW5HdmZBNnkwOUt0Q3Y4SXIva09XUFc5RWNmbitsS3oxZ1E4WVgrNHFm?=
 =?utf-8?B?SEhDTGRVbEpxeXpkTzYxMXo0S1JYOEhZZ2M2dm5Pd0R4Y2MrOFV2QXp4K0Fq?=
 =?utf-8?B?RUYwQW5ESG9GdEQ5VStsdFNBdzJkNjlMQ2RWaDZQOEd3RWUzbitnU1hqM21C?=
 =?utf-8?B?SjFKZkw3RTJJcHZPeWFwSXlibVFQWk9pZ1pMMEpGRGpYZmRzT3RvSmZ5S0x3?=
 =?utf-8?B?eGJ6ekxhYUJydmdLQXhpZlBIS1BRNFNvQjNPbDhyL00yT0wrbHJnMmwrdmIx?=
 =?utf-8?B?akhYbDVHZGI2MmRXaVZaRTBEL1VtcmpweHY4MzJONHpIbThIYWNHVk5oMXdF?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba13b344-9509-4801-33e8-08dde64feaec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 16:28:27.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xa3Nixf3ER+dJRxb917+5rzgSJaSMld5oVdEqvcqGU/qAal5TUQ7uo67cWCacw+LXMJoHzjREusvFFbl3k66ts521p7lvuw+QVv1rYfYZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-OriginatorOrg: intel.com

From: Raju Rangoju <Raju.Rangoju@amd.com>
Date: Thu, 28 Aug 2025 14:59:00 +0530

> Add support for hardware PPS (Pulse Per Second) output to the
> AMD XGBE driver. The implementation enables flexible periodic
> output mode, exposing it via the PTP per_out interface.
> 
> The driver supports configuring PPS output using the standard
> PTP subsystem, allowing precise periodic signal generation for
> time synchronization applications.
> 
> The feature has been verified using the testptp tool and
> oscilloscope.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v2:
>  - avoid redundant checks in xgbe_enable()
>  - simplify the mask calculation
> 
> Changes since v1:
>  - add sanity check to prevent pps_out_num and aux_snap_num exceeding the limit
> 
>  drivers/net/ethernet/amd/xgbe/Makefile      |  2 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h | 46 ++++++++++++-
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 15 +++++
>  drivers/net/ethernet/amd/xgbe/xgbe-pps.c    | 73 +++++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe-ptp.c    | 26 +++++++-
>  drivers/net/ethernet/amd/xgbe/xgbe.h        | 16 +++++
>  6 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-pps.c

[...]

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 2e9b95a94f89..f0989aa01855 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -691,6 +691,21 @@ void xgbe_get_all_hw_features(struct xgbe_prv_data *pdata)
>  	hw_feat->pps_out_num  = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, PPSOUTNUM);
>  	hw_feat->aux_snap_num = XGMAC_GET_BITS(mac_hfr2, MAC_HWF2R, AUXSNAPNUM);
>  
> +	/* Sanity check and warn if hardware reports more than supported */
> +	if (hw_feat->pps_out_num > XGBE_MAX_PPS_OUT) {
> +		dev_warn(pdata->dev,

1. How often can this function be called? Don't you need the _ratelimit
   version here?
2. netdev_ variant instead of dev_?

> +			 "Hardware reports %u PPS outputs, limiting to %u\n",
> +			 hw_feat->pps_out_num, XGBE_MAX_PPS_OUT);
> +		hw_feat->pps_out_num = XGBE_MAX_PPS_OUT;
> +	}
> +
> +	if (hw_feat->aux_snap_num > XGBE_MAX_AUX_SNAP) {
> +		dev_warn(pdata->dev,

(same)

> +			 "Hardware reports %u aux snapshot inputs, limiting to %u\n",
> +			 hw_feat->aux_snap_num, XGBE_MAX_AUX_SNAP);

BTW, these messages are not very meaningful, maybe you should print both
min and max and say that the actual HW output is out of range?

> +		hw_feat->aux_snap_num = XGBE_MAX_AUX_SNAP;
> +	}
> +
>  	/* Translate the Hash Table size into actual number */
>  	switch (hw_feat->hash_table_size) {
>  	case 0:
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pps.c b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
> new file mode 100644
> index 000000000000..b5704fbbc5be
> --- /dev/null
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pps.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
> + * Copyright (c) 2014, Synopsys, Inc.
> + * All rights reserved
> + *
> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
> + */
> +
> +#include "xgbe.h"
> +#include "xgbe-common.h"
> +
> +static inline u32 PPSx_MASK(unsigned int x)
> +{
> +	return GENMASK(PPS_MAXIDX(x), PPS_MINIDX(x));
> +}
> +
> +static inline u32 PPSCMDx(unsigned int x, u32 val)
> +{
> +	return ((val & GENMASK(3, 0)) << PPS_MINIDX(x));

Redundant outer ()s.

> +}
> +
> +static inline u32 TRGTMODSELx(unsigned int x, u32 val)
> +{
> +	return ((val & GENMASK(1, 0)) << (PPS_MAXIDX(x) - 2));

Same here.

> +}

I believe you shouldn't name these functions that way, also pls no
inlines in .c files.
Either give them proper names and remove `inline` or make macros from them.

> +
> +int xgbe_pps_config(struct xgbe_prv_data *pdata,
> +		    struct xgbe_pps_config *cfg, int index, int on)

@on can be bool?

> +{
> +	unsigned int value = 0;
> +	unsigned int tnsec;
> +	u64 period;
> +
> +	tnsec = XGMAC_IOREAD(pdata, MAC_PPSx_TTNSR(index));
> +	if (XGMAC_GET_BITS(tnsec, MAC_PPSx_TTNSR, TRGTBUSY0))
> +		return -EBUSY;
> +
> +	value = XGMAC_IOREAD(pdata, MAC_PPSCR);
> +
> +	value &= ~PPSx_MASK(index);

I'd remove that NL between these two or even squash them into 1 line if
it fits into 80 chars.

> +
> +	if (!on) {
> +		value |= PPSCMDx(index, 0x5);
> +		value |= PPSEN0;
> +		XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
> +		return 0;

Newline before the return.

> +	}
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTSR(index), cfg->start.tv_sec);
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_TTNSR(index), cfg->start.tv_nsec);
> +
> +	period = cfg->period.tv_sec * NSEC_PER_SEC;
> +	period += cfg->period.tv_nsec;
> +	do_div(period, XGBE_V2_TSTAMP_SSINC);
> +
> +	if (period <= 1)
> +		return -EINVAL;
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_INTERVAL(index), period - 1);
> +	period >>= 1;
> +	if (period <= 1)
> +		return -EINVAL;
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSx_WIDTH(index), period - 1);
> +
> +	value |= PPSCMDx(index, 0x2);
> +	value |= TRGTMODSELx(index, 0x2);
> +	value |= PPSEN0;
> +
> +	XGMAC_IOWRITE(pdata, MAC_PPSCR, value);
> +	return 0;

Same here.

> +}
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> index 3658afc7801d..0e0b8ec3b504 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
> @@ -106,7 +106,29 @@ static int xgbe_settime(struct ptp_clock_info *info,
>  static int xgbe_enable(struct ptp_clock_info *info,
>  		       struct ptp_clock_request *request, int on)
>  {
> -	return -EOPNOTSUPP;
> +	struct xgbe_prv_data *pdata = container_of(info, struct xgbe_prv_data,
> +						   ptp_clock_info);
> +	struct xgbe_pps_config *pps_cfg;
> +	unsigned long flags;
> +	int ret;
> +
> +	dev_dbg(pdata->dev, "rq->type %d on %d\n", request->type, on);
> +
> +	if (request->type != PTP_CLK_REQ_PEROUT)
> +		return -EOPNOTSUPP;
> +
> +	pps_cfg = &pdata->pps[request->perout.index];
> +
> +	pps_cfg->start.tv_sec = request->perout.start.sec;
> +	pps_cfg->start.tv_nsec = request->perout.start.nsec;
> +	pps_cfg->period.tv_sec = request->perout.period.sec;
> +	pps_cfg->period.tv_nsec = request->perout.period.nsec;
> +
> +	spin_lock_irqsave(&pdata->tstamp_lock, flags);
> +	ret = xgbe_pps_config(pdata, pps_cfg, request->perout.index, on);
> +	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);

Are you sure you need to protect the whole xgbe_pps_config() from
interrupts? It's quite large and I don't think you need that lock
(and IRQ protection) for its entire runtime.

> +
> +	return ret;
>  }
>  
>  void xgbe_ptp_register(struct xgbe_prv_data *pdata)

Thanks,
Olek

