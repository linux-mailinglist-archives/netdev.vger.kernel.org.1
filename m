Return-Path: <netdev+bounces-199789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A8AE1C90
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719B51887A47
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806228B51F;
	Fri, 20 Jun 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klMLmIbG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40315231824;
	Fri, 20 Jun 2025 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427221; cv=fail; b=qrwUDqCby8gl/tMpjoe3leVUq47CE9brGpk7W8fBPid4DHCIj3C0gG+h7jjjJu1J2mnrkbOasCN5caMHAyBlBbXiEoOTgT3ZYKcyYdrr+ViLB6HLv1bhO6XYKLneH+8//QM3n4R/WM6sUdKOTld1OwrwjQ8fl446jeVGJHufHOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427221; c=relaxed/simple;
	bh=xe2hP2s58bX8ZsyLbI/onhaWauvh4ZP26w8f40mI/94=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K30OqYTTfmnbtG5Bc4T4hYg05t+RajTogLoqXcYDjx9QKn+atyvdJR32DgfNmvbPf3S6/XfsvPtKW+gKHldL4NMBHZyU3RmQWIVLIS+V9jrUldj0hDlgcNp6GTv30sqhcD1jac1d5k0OZHO8aleTGj+gmlyQyNyrQiKx0xSOxgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klMLmIbG; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427219; x=1781963219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xe2hP2s58bX8ZsyLbI/onhaWauvh4ZP26w8f40mI/94=;
  b=klMLmIbGI635+q2inPwUabL+XETajUnbtCuu2qSaYbs+TiN7q8VZgVQ9
   0rajX5uni0W5QqGJ92zd2PGkC3lA41IXQrWCsrerdq8jOdaiQ8d1oKiuB
   oiXzhozqAkE0aSAkLMcPQquW4XbMqHiIgHka+xgtxrHI73TymYr3TIXf8
   hXYLeKEzg1vNhvLyudspoqhWTk+7y3FjbjSUlCAjFc75kVR6PPqexxTIK
   YO9Oq5iZ4masWCLX59lrx5dsVbudGiuiJG4PP0Re2/x+SQ5wSet9rnwMB
   s+FUNcFS5O+LaEm6EdphmB4OHblZteNkQlcC4uC+eHplne66gp3dPIEjJ
   A==;
X-CSE-ConnectionGUID: K5GglH0LRySaYD7K1FvvRw==
X-CSE-MsgGUID: Kw7QpnoFTfi0zv2YNV2olA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52836989"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52836989"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:46:58 -0700
X-CSE-ConnectionGUID: Sj7/GUW3Qr6kmLv8bEXZ3g==
X-CSE-MsgGUID: md0oC4MvRiWL3GxZTHpfZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151605134"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:46:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 06:46:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 06:46:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 06:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c36cu+EhOJq6wS3SgJlmdq7W7FA7c55vnn298INZUkqZ1PR01PkwakMg1cR8/LGQetZenucLz2+/BEhrnSpZdvKSHKQDs6CHzqRhduyO2D+fYBmCOIluHu/fwXX/DYV6ojAcKJuMy9v1GX0Chp+JUa4ukgobO0b1ma4N1olr3gd1amrjCYlAEHoHC+q7/WHH0BoltKS2beqD9d0nzSskLLKrYk8IRAeW4wW5MlLOA3quXOnemMH24qtSKLMWOns68OXsYb8Q762DLI2y1kX3nawS8/f9HMb/L4Ly8h4b5CHkNuA6ZTVQYnpwallJ8Te3MGwohoKPLpgRWiNvpm+Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byzsH2VE9+YKpbc+/ZwuxCvR/78GrdVl3iaifoJHMcQ=;
 b=rqEC3kCrAQ3pcNnizEqxhPWiPRiJG92FKkLxCSOI2/+xq6DheLYEd20ma/IGHzVWz3tMyx8LBAIs8tvDpmEujTb4lLTzRUumYE78iFPH0h0tzMzNhPSm6n+WJZHVE/vcbES9UwxlhEt+8I5TaccAEG8kfNHB+btThEsa+qGs3IcRLLD/dpQkW10HtFZrG2t/vUxjAjemcJ5TKyiV+tFUj6myzTS0xkHxbS92HX9wtGUveqlLtSubGcmDMEiwp+40bOdStrL2RjRApEkGxm3F9u6iBAzq6eAqwd64EahAJjxcEZkSYDNgPG3zy3WdWliY6aNZ6t+NnyL+jeOMFLEGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4622.namprd11.prod.outlook.com (2603:10b6:806:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 13:46:55 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 13:46:55 +0000
Message-ID: <b1a1979a-424a-4590-9f44-236d4f9a2f58@intel.com>
Date: Fri, 20 Jun 2025 15:46:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ethernet: intel: fix building with
 large NR_CPUS
To: Arnd Bergmann <arnd@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, "Simon
 Horman" <horms@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250620111141.3365031-1-arnd@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250620111141.3365031-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: 4600f7db-c485-4e55-4bd8-08ddb000eb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUc5NHdBaFIxWTV4WVkrZngwWm9mNDNiNllnNUo2M0xWVWJYMEJMZG8wcDRR?=
 =?utf-8?B?Yi96Tmx2ZDhxZURESFZHK29VNUlPdzVMZjV6Q1dNK0cwVEVKRW9FVklyUHVG?=
 =?utf-8?B?SjZaa25ZRmVSWmRjREFRcjMyWENnd1cwMUZheWF2dVdOcCsvSFQ5Y0FhaHJ2?=
 =?utf-8?B?dEw5ZmlKalJZOEQxVVZQVUgwcGVjT1VEdkEvd2ZGZytta1FOY2IxbUN3RFhk?=
 =?utf-8?B?Z3hEWkptWlIxUFBMSzQrNDJmM0dScmVJWWNKSzBJbjFHUmpUTE9wR1E3Ty9i?=
 =?utf-8?B?dkJURElYcE9RZUFoUmVYOXVhOEJOVkd3VWw4eExPOTVVelJFWWh5Z1VJblhq?=
 =?utf-8?B?bUppOHhDQnUybmhob3JiQjNpTFBqWUFXT2liWisxckx1K0NkZFZjMytEaE80?=
 =?utf-8?B?RTR3b1VPeFc1UzV2ZVJjL0xHV2xXazlEWTZaV0owOGlXYjZ0MFUzcEF6eHVi?=
 =?utf-8?B?M2NQRi9TT3l3TEtVMzlQZWpyTHBsTG1hSElCUHowcDkvUXFiTlpNT0p5OUxo?=
 =?utf-8?B?SGx6ZzgxYmRwRkJJSjlZV2wzNEsxRThTeUxMTmQwQy8zVS83b21tSWpqU1JY?=
 =?utf-8?B?a0o4ekc2a0kzQjFYTUpPbWlmRTBCUjhFYno0UFBvUWJ3WWF2Ti9Wcmt6TWpN?=
 =?utf-8?B?VkxtSCt1dzhKWmdJazR4eWM1T3BRdG5mcGlDSGxkME5OaURSZFJuK3M0bndI?=
 =?utf-8?B?NnIzNUlhdWllZ25VUTZoOVF5bmd0dXFYeXFMV05yN3p6RzhjWW9QSXZaUEg1?=
 =?utf-8?B?UEFrVnA4Um9zeFR0ZzlNcFlFWlJLQlV5K1lvMjV0TGlOWSszQi9DVmFmbzJ0?=
 =?utf-8?B?RWFsUXR0bGhPUXhwN2VDbTVGblhVNUZ4MUpNaDFpM05WblFFNTkxWGdXMEFG?=
 =?utf-8?B?OW9tRzI1NngvWDd5SUV2dTNLTTcyY0ZiVHpkVkx3MjJIOEpMY1ZHcTJCWE01?=
 =?utf-8?B?cGE2ZFYrT1E1VjFyd3gxV1k5SzVJRGg1MVM3SHAzZGJ6bU9qb0N6M1d3VzJN?=
 =?utf-8?B?ZVlRdVRkOUU2OEkyc0lSWDV4OEdTWjcyZTI4WkV5SUhLUWozQmNoWlU4MFl3?=
 =?utf-8?B?ZU9ST1k2cHFnNVMxTFdLVW5HQVE3TmIvdTZmUGdQMzVMNlNMYmk5NHRLR3hW?=
 =?utf-8?B?M0dZc3hJVCtGdEN1bVJ2SFpzTGFGWGphdnFTSm1PYTRKZFYzN1l5WCtCYklV?=
 =?utf-8?B?ZlJQT0ZGQnA1MjErME5nOVhZMnluNFMySy95NC9LZFJiYTJsOFZXRTZrRFgv?=
 =?utf-8?B?Y1Y4WitmejBFZjJpMDVBL1JiUCtFVUpyOHlQTjg4L1p1UjdPTUJBVEN6T1ZL?=
 =?utf-8?B?UjBxQmtrQUtPc0JXTktKRjFkQW1tMXhtbmxvb1V4TkpKTkxMbGhBWVo0K21i?=
 =?utf-8?B?UGdJR043YUdsNFU0YmEwbk9IOHhMQkR3enlZYTRoQkdXZlZSQ2lpdlE4M1hl?=
 =?utf-8?B?THRHWlNwTkFFMkZvMzY2SDR4ZzNmU2pVWHlZZnJQRmdKWnhrc2VvcytmQXFl?=
 =?utf-8?B?cDZWNkViaUhsRmI0QzNsN1FJa0Q2UWdRZEN3SEJMcXh3c3Q5djhoR3hOMlhM?=
 =?utf-8?B?LzZtL2NURkNNcG1lNy80UnhFNHlpUXF5c1Z6ekUvREQrMVZuKzZmejJYdGM0?=
 =?utf-8?B?S3RxaTh1MmgxNkdkQ1dpbUMvQ2picnNDRFg5R1BsQ280dExHNGY3bmVpWkJk?=
 =?utf-8?B?VDVIYnNoTEkreFZUcmhubkpwcDdrSVJlZ2VlRnVnWEI2VHJTRlg0M0hXMDB6?=
 =?utf-8?B?VnROYmNtdHZXTVdCQVRGYXhoTTVrcllmL0VLYlgyTXlHVEYwTjhkT1dQbjdW?=
 =?utf-8?B?SENMNlUzMnFpNUlYOHZST1dGOC9VdXZGUDkyNnJHN3VSRytpWEJHSUFWVm5n?=
 =?utf-8?B?dXVjdVp5Z1lBdkNoN1FOenF2M0tVc3lqUXNRZ2doT1k3WW1vWStEMUQrU1dS?=
 =?utf-8?Q?1Y8zAN7Bw8w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VHWCtySFFVREhoeHFZeXVVZUpUZU1Fa2gyVlVyZVlPcFdIb29oaG0reFdT?=
 =?utf-8?B?R2FKSlhlR3hlZDY1OTZiRlVncGRaTlF1SFc0b3EzY3lXZ3NMNHh5L25xZ0Z2?=
 =?utf-8?B?cEZCT2ZkWlc4em5Gdkk5cWFDK0w0NDdXamJrVFZmZ3NCa2RFYWhVendUSThj?=
 =?utf-8?B?bjZnOFVDNlJ1Znd0UTBzcjlOZGh3S3VJV0g0SWxSamlNUi8zV1RrK1IxWXhT?=
 =?utf-8?B?UzVDYW1IQkVzdUEwVG5DUXdFSHViVjVUSVVndUJDRDlUdmNIVHNJc0pmeGQx?=
 =?utf-8?B?V2lMZ0ttMnFSYmN6T0JWNytUSWJ6RE8wbVVhQnhoVVdzWm0zOUdrd3RQTFJT?=
 =?utf-8?B?c1VwN29pUGoyV0lXRmVDS1pxK3IxTWozM3h4WHYyeHNBSGV0elBBWUVtZWZP?=
 =?utf-8?B?VW84b1JOalZQRVQxMlgwN0VlQjFQU2U1eGw3L0xwc0drTHlvWjBGK2xFeTZL?=
 =?utf-8?B?VUlnaDF1cTZaSWpzT045SXhQQ1lkTlNhVCtWRXZvVm5HeEdqTGt2ZmlLcnc5?=
 =?utf-8?B?SmdoL3BKeUJmODlHNVBDRm5EN1BISE1lL1VDaHgwQUNLejVtZC80VXEvVHJT?=
 =?utf-8?B?ZWNRMGVWdmpJZnZaTjFXc1VQUjJVV3dTZ0R4TFVCK3hwTS9tUlJGT2tUR1lG?=
 =?utf-8?B?NXg4Skt6RWJKaUZ5QW02RmdGajNDZUtvZXQ2b2xPOG83dVdaUitrQnFDaDFa?=
 =?utf-8?B?eDl2cmtBQlNiQ29DaXcreldiajlRT0VaYjV1UVdLSkJnOTlwbitmY2RrYy83?=
 =?utf-8?B?N0N2K3ZwR1VKT0MvYjl4YWwvMkdxS2lMZ1ovbGRRUTNUV3pqUXViYy9yc3RH?=
 =?utf-8?B?MGJqT0NnaVJJRlpIY1J3Z1dTUHJhOEZKR2l2UFJZNEN1QlZobFRhMFF4dHBB?=
 =?utf-8?B?eE92ZytyUHNnKzROTFo1dktYUTA0VSs1OVVnUFNnUklqc2lDdlRyNEhwclN3?=
 =?utf-8?B?bEkvSWNaVzRYQVljeHBWUHkrWDBhU01TcmNPbWNyNjNVV1d3VjFvRjZWSk1F?=
 =?utf-8?B?TkVMTmxqcnVoM2dPaFNPQkQ2QVRlOWw0Q0UweEVqeGxjcnl6Y09pMWt5cEFv?=
 =?utf-8?B?d0U0cXdGVytKKzNvaTFDWmJDS3BDaGJ4RFk0cS9JcmdOUGQxajZOaE9hdXp0?=
 =?utf-8?B?cTFpNXhQZG9rTkRPaEFJYUU1QjUzZkVlU2Z3ckpIYUVVNDM5Wk5YNHl4K1VX?=
 =?utf-8?B?VmpDY24yNWpGTkZia0RoUThXdzBiVUkxdUhUTWh6U01MYXV5cG96NVh6TitD?=
 =?utf-8?B?TGFYVkNXVC9DS3NNdXAxUGZoQ3F4aHNYRThhQkxaaXRKdExva2RUeWc0MTV1?=
 =?utf-8?B?ZnR0eHd4b3IyYUthMDdFaGFHOUdVaWI1NEl2SXlQNTVEZ1RydnpvRVd6cWF2?=
 =?utf-8?B?b0hEZFdoRFBZYXpIQWkyMkE2anBXNy85NDZLLzZtaHBlMEpPUjMrckFiY05a?=
 =?utf-8?B?OFJvQzlxdjFtVnFBTTJMc2x4RXJSTTU0NWNaOUxheFZJVWV0K2RrelJaYU9j?=
 =?utf-8?B?MUZubTBzR2RacjZtYnE1eWMwWjE5cGxZTkRwQnMyenozQzNDKzJzL0pvMHZC?=
 =?utf-8?B?SWgrbDFpU1dYVUFJS1NRWTF6WWNRcGxnTVArN0kwRXFEV2k4Mmp6MWdwVUxV?=
 =?utf-8?B?RVdyUVIzK1kwWEd4U3pQNXBlek1aVHp3ejltOTRldzd5NlNmOC9QaHFJMVpJ?=
 =?utf-8?B?eTYwcHdTc1M1WjZJRE9OVzJLYm1WVkxzUFFoblN6T1BTczNiTHpkVUZjeXMy?=
 =?utf-8?B?TlgwS0oramlsdVlDMVFKaCtnNGlaNjMzdHhRNXo5Q1FTUk9iWDQ5MmJETjNw?=
 =?utf-8?B?UXE0S0pDdGY5VG1BNnkvZjA3K1U3Q2hxR3NpWHllMXBKWkxndVpqQWRGdytp?=
 =?utf-8?B?SUVhQXkyMmVjVnd5U3hjWVZobzQ2RWdPem9hRk9TbVIxMVI2TUpxa0VveGlI?=
 =?utf-8?B?NjlDZ3pScnNhbXdZVHAvbTVZaUtuQnVXWDJyL0l4YzRmR2dsVUVScjAxN2FB?=
 =?utf-8?B?azdTTXZENy9LR2ZiUlAvd3pGS0l0SjJ1NDJKMUZqdWVwdE5aWjRwTytPY2hQ?=
 =?utf-8?B?K2RtdGkxZFlvSVZPQXZ5aWp2cUtiUkRkdnFoa1pWRlZlYUtlQTEzdS9BZFpV?=
 =?utf-8?B?RVR5U1o4dXNZV1ZkM09lZmJIYmlEZHRPNkVTMTMxRDduWk9PZzNzYUZqQm5G?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4600f7db-c485-4e55-4bd8-08ddb000eb5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:46:55.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY965ZvLymKBvsgv2vS21hGFhJst/0hLxNAq6eMH0k12OB21Nm7RCoWe7CuetpsYexCW1nBn3UtdqI/wndhP5I1q26C54fkcvx4V7CI/eo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4622
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 20 Jun 2025 13:11:17 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> With large values of CONFIG_NR_CPUS, three Intel ethernet drivers fail to
> compile like:
> 
> In function ‘i40e_free_q_vector’,
>     inlined from ‘i40e_vsi_alloc_q_vectors’ at drivers/net/ethernet/intel/i40e/i40e_main.c:12112:3:
>   571 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> include/linux/rcupdate.h:1084:17: note: in expansion of macro ‘BUILD_BUG_ON’
>  1084 |                 BUILD_BUG_ON(offsetof(typeof(*(ptr)), rhf) >= 4096);    \
> drivers/net/ethernet/intel/i40e/i40e_main.c:5113:9: note: in expansion of macro ‘kfree_rcu’
>  5113 |         kfree_rcu(q_vector, rcu);
>       |         ^~~~~~~~~
> 
> The problem is that the 'rcu' member in 'q_vector' is too far from the start
> of the structure. Move this member before the CPU mask instead, in all three
> drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k.h | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e.h   | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
> index 6119a4108838..757a6fd81b7b 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> @@ -187,6 +187,7 @@ struct fm10k_q_vector {
>  	u32 __iomem *itr;	/* pointer to ITR register for this vector */
>  	u16 v_idx;		/* index of q_vector within interface array */
>  	struct fm10k_ring_container rx, tx;
> +	struct rcu_head rcu;	/* to avoid race with update stats on free */
>  
>  	struct napi_struct napi;

I'd place it *after* ::napi as the latter is hot and better to still be
near rx/tx etc.

Same for the rest of the drivers.

Thanks,
Olek

