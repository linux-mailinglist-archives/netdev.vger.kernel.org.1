Return-Path: <netdev+bounces-132914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA43993B7C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E1DB23716
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984819994E;
	Mon,  7 Oct 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tjt8a0eo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAC192D99
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345504; cv=fail; b=RadaE8EpjzHa9FkkLAY5Ukgd6e725eegnthSh8PO/dnzWReL0KV7jzrZtjWS1kQ37sloME8LoY2s8BknpiPziTpipAKLHlbZaoyHlgMHxqiHdhy1cqEwRz0rH0+qH622/YcDMfhb0j6YB6LtQxJRcnJ8qt4tXR+S1RCgq2iaQbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345504; c=relaxed/simple;
	bh=WXeVTYDMAg3zpgXxTHCqi2Ck1kwF14sVJmsgvfC/hUA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I7a75vQSOYBd1e5gI0XLwiwMLDcKZYbTLLrukLweCv9oEIuFA32bjsNX8HrxlPWg47JNkha8ExY2xSKYw/MFzVP8EWpU9A1d8/DiQMbFQgVd1W9k/PrOHc3K4jgxMGgjB7moE4WkoTd1mVaK3OCINm1EmbB2qQo0hY+cQMBpbkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tjt8a0eo; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728345503; x=1759881503;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WXeVTYDMAg3zpgXxTHCqi2Ck1kwF14sVJmsgvfC/hUA=;
  b=Tjt8a0eo7S24ekDba9PRrNIq3SMd8kdZz889WB3qAKr7RJvt+wOLxvRW
   f6Ma5R9ZQAs/hSpbpTfyBIIOfuymSOMlRLPNVoT/9FSn3g/RpqNGmltS4
   horp0g2GCJwPwgSBr7QHI5Ky6o4hvddXpzrOedUdWiu2ikuJDnN/jUMIX
   uS82HMQdwajTo1t+jBKMCyN1/p0V23Cp+zSls+DEuiH4KP3tE7Eps3XYx
   zKo8IYW6Dh0ehtFLKrfg78TxQlxWSdgQdvzdTmtYjujdD/nXQmlSaQ0Cf
   MJoOcwGBRE4oNx5xA2MCCr+ueaH8No2Q0qxSALflK/mGgTIXi6hvSjM/9
   A==;
X-CSE-ConnectionGUID: beCtOX06Rla8arD3IZZo2Q==
X-CSE-MsgGUID: uZd1VG4xTT6c2T0gA06kOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38877873"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38877873"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:58:23 -0700
X-CSE-ConnectionGUID: RZJZeskuSk+csUmkEfsmbQ==
X-CSE-MsgGUID: XvUnl2cDR8iU0f/aJkGhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75199626"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 16:58:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:58:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 16:58:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 16:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ba4O+SgDNu6bpHeadKcl4QRTU/iaIk4alA1yQgBCHL39RTSBxEbiY5yZKYB3qIJe4RGVX44xODHfMKRxCSK/646XB7mumA7SFSnIFdXnSa9YeVnHRWt8naDyG8ThigraRinaUNlOEDsJMs9AmreI1Kc9rvkwD3XAcW5RZAoYapBC6UelVulEBKS0fLVqNHnnhIWbIU9GDL9CjXtIMNPnmXjX2HB4H3fifG9qxq2gqZstIHsJxzCOZ9JY2U653shEdaWNo9HgGQeEmNO0PMWi07GerNH2vHxudmnlg1+T+FKBvRjJr90sU0bCUqf3ATtgwnTGDsoEr4lr5WD8kqNufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQcJOL/OJBh1wllLH+W4Vd6s2tFIEln2BdLo2qkdabY=;
 b=MGYPBNX/JH9hAz6GBs4BAmiIgiJKEkeSA6hC9yTkCos2N3CCRcKtFWX8MQJK+TIpUUo1cwKwrcaQ18BUtnuXyth0JSI6h/dkm9tcu67gfobqjjUakNSDQ/ryXAAGsd33OFgm+y2Ag7XLZE/xmZ2XtQGWNyI+dxKx3raAHXp8l5SgThg4g68E0SxOherF/T2/ZasLM+5fqCYmbvZMP0s4uLFVQqWi5kRs/BnLxDNRvOPSDitI9BFnrT0B8ZSi+Ilkfsjkc9v+gEmlBnNPmn1XJ/w6W+WAx9CK8Qt736ZKhZHYaiXieW5a73PKOPxDqjV/IMnRfXyvNNrsfDmsUuRJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:57:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:57:32 +0000
Message-ID: <95fbd4ac-e7a3-4035-b78f-f71f06cbf519@intel.com>
Date: Mon, 7 Oct 2024 16:57:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] eth: fbnic: add initial PHC support
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
CC: Vadim Fedorenko <vadfed@meta.com>, David Ahern <dsahern@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	"Alexander Duyck" <alexanderduyck@fb.com>, <netdev@vger.kernel.org>, Richard
 Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-3-vadfed@meta.com>
 <9513f032-de89-4a6b-8e16-d142316b2fc9@intel.com>
 <e6f541f8-ac28-4180-989a-84ee4587e21c@linux.dev>
 <20241007160917.591c2d5d@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241007160917.591c2d5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 85270f29-041d-4617-e670-08dce72bcee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVh2dkhxL293eFFieHM3RlhUdDJHNTFUblNlOGhHQnNLakU5R2J5NXFvTmtX?=
 =?utf-8?B?aHNVUjYzWVRLQVF6SDdIL1lQV2wvcCt6OFVhS3ROQ1o3MTVwNGF0aURWNEhO?=
 =?utf-8?B?Z1I5b3JjdXV3c2dzenVRTERUT2VVWDkxcnFLNXdwTHZDdGUzVjMzUEVlc0dW?=
 =?utf-8?B?d1BkVkV6UG4rYXFQakVFR0RsVkF4emxJZkhZR280Sm5aOGI4eWcvSmREcGpF?=
 =?utf-8?B?SGphY0pJK2hhQWRiTmJPTXgrZk5xYVZQTHlPRjNUMVZCSXQwbUtkM2lOR1Yz?=
 =?utf-8?B?ZjQ1VEYwakRjU2N2cDc0dlZCY09VbDdlVFRZYnQ3Y01CYlhnR0ZQSXpuSW85?=
 =?utf-8?B?WHBSdW5tbUpZK0xaanhyTnowNXArcnZIOFAxUnZlSkdtNEhXb0dmcG90bWVk?=
 =?utf-8?B?V1JNbEJMeEdlQ1NNcTg5WDhwUlN5TTg3Z1ZHSmtIOUFjSFFVNlJLNDJqNEhr?=
 =?utf-8?B?Rm5aZUhTa0l5bFlNQXlmQWd2bW9MMHN6bDJ0a2RPazFKd2JlZEluTlpJV05u?=
 =?utf-8?B?L3NtWHQrNDJxelhDa1l2enNaYzFSUzlwVVBvNXY2WHFTVnFSMkkyZ1JrL0dj?=
 =?utf-8?B?elJtclc3SXM0WTc1cFJTWnpHbm5NOW1aREpTbVJNTTZPRVBkRjhTaGIzMlky?=
 =?utf-8?B?Nmh3QU51QUtRYWRYWHFaNTFHNU5qUUxqR1JtZ0M1Q1ZiVzc0aXUzSGNJajVY?=
 =?utf-8?B?YnpVaGpRd054YTdBUGVSVFVaYmhUaVMzaWJRcXpnZDZFTFp3RE5vSCtWT1hO?=
 =?utf-8?B?MXVvcDZMT0pqaWc0eWkwRFNkS3dNa2EvK3QzeTFQUFkzRERTci93bWdERWRp?=
 =?utf-8?B?cTUzNTYrNHFqdWpZcm83eTBMM3VQRXg3bU9KUHJGRTBmQm44Vmx2L2dDeW9E?=
 =?utf-8?B?OG11WFZOV013WkEwRjhYZlQ1bllHQUZXRGhGRlRobHZyaW04RHBtVm9PV1hm?=
 =?utf-8?B?N1pJK21TMGFFN213RGdOTDUvaFRKdFpuRS9jcmxwbTlXdHpuWEoyMEU3SGVl?=
 =?utf-8?B?S0lxMkZrUUp3UGVwZHQ1Vy9aN2VOSFpmKzVSRHJMQndkUE1YaFpVVGhseGNp?=
 =?utf-8?B?TFNXZ0RSUldLQmV6M3Z2QTd2KzI4c1RXQ01xb0l4bzRaRkUzVHQyeEs2M3l5?=
 =?utf-8?B?bEJtVUdROEdVT0JITUxNMHpEcytxWXVYWU1tMGttakJCeXkxQmNTLzYwa3dR?=
 =?utf-8?B?a0RQSVhUUjhVMFMwdGtvKzFiYVRwRFVrYzdkYkZTbnRCNU9lVGZrVDJYT3pw?=
 =?utf-8?B?NWt5dUZIbDN3d2UyRkRkcXRVUkdzYXBqMkpyelpXZ2taL0pwdlpKbzhNYzg0?=
 =?utf-8?B?RlNnV1F3QmtUMWZyM0tyVnhGRjI0NmpBc1R1djNtWXF3TzFadDgrV1hqZXow?=
 =?utf-8?B?VXNXRUV3OE9jb1VVZERuOFR5RzdLTlRNMExwMDNtRlZaN1hobUVKM3FwVTRB?=
 =?utf-8?B?eHRRVitiQnZCWGdNWWpqNEN2UktCR1p6QnMxNnFxREpGK0V0ZUloQVVPNHl2?=
 =?utf-8?B?QzhxV3VsazVvOXRXbHBlbGp5aEZsWnFBdGhSTkNPT2Ixdm9VaU1pMkdtSU1S?=
 =?utf-8?B?Z3A5RGVCbXJ0ZjNybjhDdzVER1o4cVVENlVwVkhFTUNvcTREN1kxS0pVcWhh?=
 =?utf-8?B?R29ueGY5bGw3VElFdmZJaWVXdEFpcjV3c2p0OWdJc3NNbFo5eU93QzZUK3JT?=
 =?utf-8?B?R2Y3cjVUd0VpS0FBYXdXMzg1T2xwQVNyT3lEN28xWDFxbWx1bEgyb2RBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG9ndEM0NFJGNGJWMmFLY3FvM1A5REpOYWE4VC9sYXhLQW1TMVhVbWZWOWRk?=
 =?utf-8?B?R0FhTjRjVjNMN0xwYjlqenlxZ2kwRzBKKzd5RG9aSkFzdjdVSU10azRzam9R?=
 =?utf-8?B?MmJNYVQveDgwSEdRcE9kTTQ4V2xVMUxKa2xMMVNSeHMzTThMaWJaYjRtVmVQ?=
 =?utf-8?B?a2h2UUxYN09FUHAvQldxc2Nzdk5IWTk0TmZVditsYnNINGR1SHVTRmFkRGJi?=
 =?utf-8?B?ZVprRFRUQlhOV0R3NTNoa0s3NU9jZmtuVjBPRS9ydlFSNmhWODJtZWZ6Szd1?=
 =?utf-8?B?NUo0d01EdGFEUnZwYW1USGhRaFF2ZndHMmt6ZVU4SWJucmwyUmtzWjMvcFFL?=
 =?utf-8?B?WDhnRVI0Y09VbWtJc0p0aWk1Z25zOE5pNnRkRFBEVkIzVjVsOE9kbHZibkty?=
 =?utf-8?B?STFhSmQ2Wk11c1Jmbmo4cmg2N1lOU3FndlltNHBlNUZudDR0cDRYNGFKWDhk?=
 =?utf-8?B?QTZaZUJ3K1F1TUFLeWd1SVMreGhVSUREZGwvME4vUzNobEhpejNUNTdNTXNW?=
 =?utf-8?B?cGNXMlNHT0M2WXg5dXN2VEtibmdDaVN3YVRNL0ZyeFdyRzh2MWI4RmdjWHFw?=
 =?utf-8?B?Z2w0dlFwKzRmNDFkalNhUmhtLzRram5GeHBUUktZOEF0cGFRaWFMdkdoMUpX?=
 =?utf-8?B?bklwZStsTHZncXMxQWJ1Y01xdFIyeWx1bllvTk5Ma2RHU21WbktVZGxyVGN1?=
 =?utf-8?B?akhOeFM0YWprWFFuMm9DZTRzdmJMN3lVZ3gxSXVDMVpITzJxOTA1bVJ3ak9K?=
 =?utf-8?B?aE54SDRPMXRpQzQvWFo2MjdzSDNmbEt6eWdHbEZac1FOZHAwYjVxMHl4NFpt?=
 =?utf-8?B?WkRhQmNpMzhyS2R2QlhaQS9sV3NCdWVpaWNjT241dGhQYy9qZzhTbHBhSktU?=
 =?utf-8?B?aVdaZ3dvc2pHTTFtU3BvNE9ocUhuamNZWHBqdnRVYW0veE5yK0krZ1ZaWnMr?=
 =?utf-8?B?SUFldS9MVjc2U3F5bDluRFM1Wm1UVDhLVWlQdUVDTDZMREpZcjBTenNjL3NH?=
 =?utf-8?B?Mmd2UEp6S08wanlxMmZ4bzhsZzE0Zk1RN2tpR3Nlbk9uYTRTaEhybjFWVnQ1?=
 =?utf-8?B?bjFHdUlyZ0lkTWF1eHN0YVhoZHB1SjFVcDNHTjdaYXdBTnZiZVBMUVoxVFJq?=
 =?utf-8?B?bVhOOExvU01zQmJpenVCL2hKakx5NTR6bGVHODUxK1FHSzJ1cUtvVnl4ZDUx?=
 =?utf-8?B?NVFpTmtTbUpIcnVaQ0lhU0JhMENnZDVIcHE2RVZDNmNReHAzMzlHRFZlNkZT?=
 =?utf-8?B?SHRMTWhzRi9McW9QWjM1emNQa0E0czgzWEsxUm95WmwxcEM4OVRqa0Jndlo5?=
 =?utf-8?B?aUs3QzhxSC92ekRyRVpjSmZVSVFLdVFsYWc5RGIxU3lCVlIyVXNackxZQlhE?=
 =?utf-8?B?KytoekN6SkFuRktKVG1KdUtaU0dyNWpnVGh3R0FQTklOMERXbTl2T1dUb2Rn?=
 =?utf-8?B?ZC96Z2xRMktqanJDRlQzN25TY2lLZ1NRaWZGbmVWdmlXQitTaVJBcXBidWJ2?=
 =?utf-8?B?Z1BrNnRvdGMzODVKZjJTaEZKVVFwbjk5Ni9YTkkvR3RIZ2U1QVdzWVdpWnhr?=
 =?utf-8?B?aXdUajJFOUZEZ1lnUUM0UG1CRlQyRGdyVkE0ME93NWM3MTJjUGdvTGdsYUUv?=
 =?utf-8?B?Ti92VVJIc05OQXN6RGJtb2gwdmVGWTRLSm81UXFXNGJ3NVdwYTJUYmp1OUEw?=
 =?utf-8?B?OWRxS05XZEhpTnIvYTY2cEs4RDJYTWU4bTE2U2o4enNTTjBJd080SzB0bHdO?=
 =?utf-8?B?dG0wUUFHSjU1azNrOUxKSVRYV3VsR3FMbkpBUzRYNVJ1aE0zWEVDQUE5TTU1?=
 =?utf-8?B?OTdtS3pxem14YmgvMWc2NnhxeThrTjM1ZWU4UVlWSzcwa3ViS1lJN2dzb0c5?=
 =?utf-8?B?UkdCT2VLQ1ViWkFqdlgwOW5lbzFvZVRPbk1JS2dGSWhYbSs2T1BKOFVFTUtS?=
 =?utf-8?B?UDV5OEVnbGZ3RVZFZGZRbHhBclFGeVFlYktPQm44N0xKaEpnYk5td0JRVEs5?=
 =?utf-8?B?L05hVllDelA3UEt1RW1HOWVNbHR3a1J5cDhpYUFDemtGY0tNelpuOEtxMFBy?=
 =?utf-8?B?SXFaTmZHWWNlUWk0R1kwNGUybDdIN1E2NXRTdC9ieTBlOEQ2VFY5MWdYanVk?=
 =?utf-8?B?R1d3eHZ3SHZIOHE5bUh2U2hRUmJNcER1OVB0a0xqWXpSc0MzUTBxdGhCc3Bo?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85270f29-041d-4617-e670-08dce72bcee2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:57:32.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOPOiXskG43k2x4TMLrfgXxdR5LNS+zXAoKSQkjsA79L/JYOl1KkrAUOUj0zPQMlDD4SuPY0+37+gMqMqJCEYKt/g5Wp0Hkkj65VStFxjuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com



On 10/7/2024 4:09 PM, Jakub Kicinski wrote:
>>> I think another way to implement this is to read lo, then hi, then lo
>>> again, and if lo2 is smaller than lo, you know hi overflowed and you can
>>> re-read hi  
>>
>> That's an option too, I'll think of it, thanks!
> 
> The triple read is less neat in case hi jumps by more than 1.
> 

Wouldn't that require the lower bits to accumulate more than an entire
cycle for that to happen?

