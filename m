Return-Path: <netdev+bounces-198291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F3ADBCC9
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD783B46C6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD6220F47;
	Mon, 16 Jun 2025 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoQ1ttak"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C503219A9E
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112575; cv=fail; b=Ezqw0FDDqQdFd7cB80+qZc3npH7kH5zBRGZEJwQorJPXqoHoP6ZUH2jFgZNenrQt0kDQfaYEKQ8YZBAk8/5pa1DkBFGkKo96B9fcfygMKcVwFspfaLbpFpo7wU9X6uz8QW++d8C/lGccNN/35onidjEZahtXCiuKNOWW9kVvcO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112575; c=relaxed/simple;
	bh=SPhUuHJ0ikMwiz6Bq7TH059qQwi/5uq5DUUnpeVsCKE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ea5D2oz4L+RjuMSNtPLlM49qrwQi1ealVMuWNX3xST3ktbCkfkEoKx2UmvBMCFQS7mAhJGtGGGGjlkjEo720nB//+/bmeC1BGvUDv3oZbGPPTUCi8d1rHe2POfEs7BN1GEEiOfq8akjMMOKl1cz7YYhNf59RmlOHf4BKBqOU/R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoQ1ttak; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750112574; x=1781648574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SPhUuHJ0ikMwiz6Bq7TH059qQwi/5uq5DUUnpeVsCKE=;
  b=BoQ1ttakjh8eXG7hhy/F5dBqf9Y0jKx5WNfgDXYWpPnTsjZXKfZSL8uX
   zOs3sxu828kuZrJkvONoVF1paijcbohGLyk8CwwUzhKQ2lXTA1w8ETpis
   q2AD1C3QQw1crUfo7o11lq1yxMuGTqz2DmxpQqoTIX5KKS1QpAQ2yToKF
   s6GGZH3MUU9svAucICDteZjA9oAutst/qIFfkHv1U/gh8XSowbU8b8GT8
   K3tFt1KBiYXKyt0SCPZf1VwPaDFZN9iFmFoxD/z32fxylZQ6GjwH27Q8L
   b3tB6RgHeFDjZIaX80eGtiNPNpr3a/pQZQjdps58y/hKq80vjo+raTONy
   g==;
X-CSE-ConnectionGUID: l6GX0ZEARR2iPvaxBwlm5Q==
X-CSE-MsgGUID: 72vrsPH8TJSMTU85SyJKig==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="77663365"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="77663365"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:22:53 -0700
X-CSE-ConnectionGUID: uZlHOzqGStCG7KSfHSO5kA==
X-CSE-MsgGUID: AYqjH8uQSoCuMR/JTQP9Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="179467005"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:22:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:22:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:22:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzecU5ESiGksrH4DLmwn7wwhLZyREkYaXnUI8xMzcPeAG+zTcV0kec4NPTxmx5cBFGv/BkQS0PG44YXsfupF4NniITDTLucvOGMLjOCLBMDaKer9JCdlIVlqYbNY8gCEei5bRGxxfGWF9N29EGZjwjxIIZS7UB9D44zOqGKKO9hnJzY6ZAnTb0FSsuWbRJgqF4+a8ioa8sgBtEQHdQO9rze9a3fcIUChx7gVTd7GHZX+p66yeK078NeDPthCTmjzcvWR8Es+Gk5r4EPMCNd/VJ7hbTp3rvQx4kwZ2rWRcn7bOInPcaHWCZGqx7vnwSEepn2zkvMZ0i7twpetCsKPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6sJTLeIvVTM2h9Lrz4gHeh9EUVc62DM2iVlh/5J7M8=;
 b=L+M1a8+owrU5cMNzss4q+VkitMkARWVNfcrrEcZBES/ClkXnlfOKFU/HhXtuRV55HD6kmiWeRVtqNFJHIyiBaCX9+fzv3ByMR3i4aI4gBCiQDb+sQrACQ6dSVjSqaBGh6p4RfZniRhPod70H34eoKWUmix2ODjKlPSJGiTB+D8XpwN7xC3gP17XqbWQ6p7W1XdRc23kssCaviA1HLKtJ6ALop+hnNAOwsOK+f3eR0n9GkAVl/ZaHnHjSMbt1OqPlVp8YB4655wMujUDBwbQa9FLeX8WNYcTgqP/ceK97y+Q7SrSiPsnzga/3KWroX77ceK1CTZLBy5ejEpU8MWjq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:22:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:22:21 +0000
Message-ID: <ca35f416-d8fd-4b5a-af4a-ed221f68d152@intel.com>
Date: Mon, 16 Jun 2025 15:22:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, <netdev@vger.kernel.org>
CC: <Rengarajan.S@microchip.com>, Bryan Whitehead
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>, "Raju
 Lakkaraju" <Raju.Lakkaraju@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 3568ba71-1dd8-47e5-142c-08ddad2442da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmNvYUx2bUExVWJmQkxOYkY3YTR1ZTZHLzhZdXRNRTVHRnhZaHdvcXIrRWg5?=
 =?utf-8?B?REJ4R1c5bU5yRlhWZUlKU1BDZHk3SGN2c0Zib0pYMU5xcnBJY3U4L1NzZmJ3?=
 =?utf-8?B?L0twdHQrNHpSdE8xdm0xaTJBL1kweGc2a3FuNW1ORFF3Uk9LeTBHOXhzbSt1?=
 =?utf-8?B?R2ZSOVRvWXAvS1NNVE9nNVI5REJhZldXaWNZS1lIWDZtZGE4WnMwbVh5MnhI?=
 =?utf-8?B?SStjTnJpL0xSSWhyM2pZZW5WTmJXazhpNHAyZEUzUTczOU55VW44bXJHSTlE?=
 =?utf-8?B?bDZnMVdZcnN6Z3MxMktLa1o3RWZvamhKcWZTUjVyT0VQem5lYlEvL21FZ0tI?=
 =?utf-8?B?TVJqc29UUWtoNGg4VGRwcmpPRjBxMGlXNTNqdCtEWGxPWlJJS1lhbUlXWU55?=
 =?utf-8?B?dUNOZHhQZjlYRVBYR01Tc1F1VjZEU2ZtRGhHVUQ0RWZpb3RwbDNXamN5bUE2?=
 =?utf-8?B?Z25YN3VYQi9ld1ZOUWJiM1lOVzhOVW0vd3pVcjBFMEp6RGxUL1JhWWUwbWQx?=
 =?utf-8?B?MTRhMkZySUVFd2pQVVcvbWNGeGtpemtPVC9aVnVYZEtKbnJVM1lTaitpT3lV?=
 =?utf-8?B?MEhwL1c0U2NVZ1NpcnBJdGdQVmFXaGxrTzRmQ2ZoWXhUbmxBUlZvQ0lxc2FW?=
 =?utf-8?B?V3NjUHYvSnFKRUo4aVZCVmVFcGp3MXhtTVhlRHhPWWxQc0pjZ2JuRVdUbmFO?=
 =?utf-8?B?VkdUOWk5WFBldEFBRHRCa2JYbjBFUTlRdWlvSXV0OENtemIxOGxxbVB6ekxT?=
 =?utf-8?B?MFA5ek4wWlRhczlSQUd1NCtIQVM2dEdtMlVybHZDQUFnSm9mRGZGZnJyMkdo?=
 =?utf-8?B?UklGMzJjR1l4WjY5Z2ZBNGxNeC8vbU1sTHRESHRHdTMyMndJdG9xVHlRaE5u?=
 =?utf-8?B?OEx5NnNMUytVQjNYeVdBR1N3M1gyQm43QUpXVTIrcElsWGFZcVB1SERvYzdm?=
 =?utf-8?B?eWpPWVRlSkpNVjlKN01CUThPbDBGQ0tYVUlXREJwRHB6Y0dsclpPSmt2MU9G?=
 =?utf-8?B?eWs1Tk56aVc1ZU9Wb04yVk1aNjQvY1pjNFgycG1HeDRZY2YxRFFEWVYySE8w?=
 =?utf-8?B?M3diWXVYdFRtNFpsZUo2TWl5YUFmV0dZeXlxZFNiT1pFUmJjQkVuZ0IrU08v?=
 =?utf-8?B?a0lqbG9mQVhtTjQ3cDNBS0k1Tmd3dE5FNTlmTjdiWHAyRTJzb1E2cElwVkZR?=
 =?utf-8?B?RjVkMUptQUladjhGVmRiY0NtcHgySzdOU2p1N2lYZitQOGkva0JPakwwTy9T?=
 =?utf-8?B?cWk2MmFUUWcybm5Pa2g5eHpHYXFVc1FZd0pNUlpwWUJoNUtkbEdHcU5JWTUx?=
 =?utf-8?B?TVBOTnZ5eDBIdGZ1VEEwSFRyTnZ3T1pydDhFWXJoT1M4Tjh4VXlHSXE5WFBM?=
 =?utf-8?B?ZmhKd2c3VkR1UURBVFFLRklWenp5Z3c5TVg3WG5CbWNQZ2U5VE1ubG1tWnl1?=
 =?utf-8?B?VGdEckdZOXNWV0o1OE5mVXBxVFQwR056NEt1eHpQN3I2cTU2WSt5czJLMUpz?=
 =?utf-8?B?L2JIWTJsbmVqaUZNbDJucTdBZ3RVREZnckEvVTFuTjhCR1paNy9yQVNXQkgr?=
 =?utf-8?B?bExQZVd6L2VURWkyUW1ac1lobzV2NEZaZUsyc3oyVWFja3Jwc2plK3BiR25l?=
 =?utf-8?B?N0tqQ1oxdVV6MGNLMFBaVGgxakJob0x2dEZIOWFGQzcyaWg2VFRHa09QWnBv?=
 =?utf-8?B?dkFwdzA2R1YwbUowZ2dnVzdGM3dKWkd4cFZBNEo4akNkU2xCTU5DcWxlcEg5?=
 =?utf-8?B?QjhLZkVpdzRGUnU3MHZlRitROTVYTFJETXJFeUhWaHBDTzgrR3F1WGlTS0lo?=
 =?utf-8?B?ZXNBWXVBVmQrL1U1Q3BhdTBabUVROVM5MnBDM0tJUXRHU0lCaUY3WnUwRXM0?=
 =?utf-8?B?SGNjVjVnNUNiQ3B6NlVsekxWd2c0ZUVHS1V3cE54YkVKVGszRm9kMVVSdFBZ?=
 =?utf-8?Q?qK8KIpVumi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1ESTFXUDVrV3E4SDdYL3pMeTdXR1JkVWUvYm9ZUXBlQ2VZUStYQ2t0SSs0?=
 =?utf-8?B?UVBKNDlmWDV6ZXhyeUZpRFQwTmpJQ1RwdlozZGttL2JMYmJPN0ZOQ1BRR0FL?=
 =?utf-8?B?RGdsNFFQd0ZENjRtaEt1UkhaeStWb0pmR2lmQi8xUW12Rkx1K2syNGE1eVRy?=
 =?utf-8?B?QnNCcjRuMTRQcWhhRWNZaXRiOE5GTGJ4VUtkRUdKa2RZOEJ2UlFBbXRXd0hB?=
 =?utf-8?B?ekd0ZEp4MGlWaTlGd2NSTm5lemJiNlVCbjUwNUhDc1ZvdzRwZjZZYnZHRUJk?=
 =?utf-8?B?NGM2SmNGbUpwV25VWm45bG5ZNEsxM2ZwTGNoRUxKVFgvWWpJVnVlMno3elFw?=
 =?utf-8?B?VExNTWROY2RnRXNEQXFzVTllMDY0L1VJbHJFcS9RbjhVcHhKZWpGSWp0b0lT?=
 =?utf-8?B?MmJIR1EwUWFHaGh5bUZ2NE5DNGw5djg3R3phOWFDWSs1NXU4T0t3czBLNTZo?=
 =?utf-8?B?RXFMd1hkVGZPWTZRZnIrNHNUMUc5VXZweW5nU3Z2bmhQZU9CN3VPcWhVaTRZ?=
 =?utf-8?B?Zkp6YkFwdHd5L0hON0dHQnNjZSt4UTFLNENJOU1wYzFGT2ZlU0Rna3B4UUU3?=
 =?utf-8?B?Q1pSYm0wTXdSWFNuU3lJQUtJQk1oWTJpc0JUYjFDRWhZZ1ptaFdFWG1BVXpW?=
 =?utf-8?B?MW1RcUNxcUdTcE03a2RUMGFTRE9XWG9ER1hoRlc3WnVqZ1BZY1ZWS1NScE52?=
 =?utf-8?B?V3hDeUJKTUw2R0hXWFFJKzByR0NYZENmZExnT1ZnenJSTEFuVmFxd1AramlJ?=
 =?utf-8?B?c3lzZ1ZOekV4ODNVWGVmY25ESjFMczFTSG5FVHFCSng1dUJQdHBjME0wYUlR?=
 =?utf-8?B?Y0RWaDdWRVFlUVhlWXhZOGNGOHBPR1lIdUtJQVpaaVNEeDBKc3c5dHdSam8z?=
 =?utf-8?B?MUErai9kMGRyM2pwVTFTM3F3NGM5SmFKSFVReTNLb2Nualh2dVpBV0l1VTQ0?=
 =?utf-8?B?NmZPTm9rZ2p2Q0ZnRnhmZjJaRDV4R1J2dUFuQVM5RElHbkhsR01WdlI1MEYx?=
 =?utf-8?B?L1o1ZjAzeEtmS3pxWkV0dWdWUnVxME1XajkyM09UMDZPYUtCVCtRaHJ5dGpl?=
 =?utf-8?B?d2t2M0hlODBoRXUwbWlqT1NGNVROdW1Ram90eE8wVGZ4L2R6SU9OT1NZV2g1?=
 =?utf-8?B?Vy85TDYxVHNEdU1vWnRUb3RKYzNYVm0zTFYyeDJCRzdxS21oYW5HenVTeEcx?=
 =?utf-8?B?dXhMK3lUYVQ4cTBnSkxkS2F4NzJkSVFDakJ3RTJ1bTRzWllsVlgyN2xkQUdW?=
 =?utf-8?B?UVh6OHF3aHc4aVFqOHhKckY0WTd4RGlweXJBSC8yd1NEUjRVZnZtVDFUZkg1?=
 =?utf-8?B?dDA0RWVtZTJwN3grNzJqOU1IdmQ3MjZ2QWlRZTVWeXAxVFNEZ1E0STR4Tm5l?=
 =?utf-8?B?Z1ljdnpNZnU2QkIxTmc4RVZqTUZpclU0TTZwaGh3cEhETGNkbFN4YXZsQXJl?=
 =?utf-8?B?TStpQ2V1b2V1SzZQOStXK0RZWTJ6b0VOVngyRVhWa1VyU2lqYXk5Q1VDZ1E1?=
 =?utf-8?B?R2lrNmJFYWROZWFWUFlwbUp6TFRZZ2VBNmlHYVkxTXRNQnVzZHlZMGZ0bzd4?=
 =?utf-8?B?eGlnMUNoZFg3ZFlQT2pBNDB1Um5lMWg4aVNFUlVncG8wY3o5OFZ5am1OVENT?=
 =?utf-8?B?Z2tCdkxWMlNWc2lVWGNpaEZpWElXM1ovS3p0aUplUERHSm95SEJIN1Joamk3?=
 =?utf-8?B?bWpKZjI1d2RubmxKUGhmYVMwWThHdWV4ekxSd1pzUzJ3QkgrN3NwalRJUmVy?=
 =?utf-8?B?STJBK29BbzVPb1FVZkhrbkpnSGRvNlI1azdVT3lrOGFGUVR3U0dlQUZGNmxW?=
 =?utf-8?B?M0txUkh2MVlXYWlEa1NPZXRyYTdZSWJ5MVpuYUx3akFhTEVCVzdNcldMS0Y2?=
 =?utf-8?B?amVSc3ZwdndqY2xqQStjeWZnOWZtYzhmQ2NwQWZ1U3oxRE9VMDhtWTFVVDNn?=
 =?utf-8?B?cDBpYTdpU05hL1B0a3Zha0h4LzZ5OE1pSjV0NmQzaFBid3JQQTNobWZIVDB5?=
 =?utf-8?B?Z3RUdHFrRnUzRElMZ0FHWVplRGtEVUJ2c2xIdEtwci9zZjJ6aXBKV3BoN2xD?=
 =?utf-8?B?NHlYRWkyQktqdXNuL3N1ckJrcVhDaXBNTGFwRCswaEZnSE4vbEt4R3grVVVk?=
 =?utf-8?B?dWkyTmlHNE4zNS9STTFuZzlKWS9iTTZDejA3TjRiblMxTDUvQnFZaG1WSEtG?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3568ba71-1dd8-47e5-142c-08ddad2442da
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:22:21.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCwK8aPah31eQX7VHu8P4uJXDIi/xr8Svy5t+NQsFwOeyEyXHnnWXuNyfeJHhMFdOvvNMbqXYXgaD+CD+b5X1QLXEetKmH3zWn2GNTeyJXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com



On 6/16/2025 4:37 AM, Alexey Kodanev wrote:
> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
> is checked against the maximum value of PCI11X1X_PTP_IO_MAX_CHANNELS(8).
> This seems correct and aligns with the PTP interrupt status register
> (PTP_INT_STS) specifications.
> 
> However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
> only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:
> 
>     lan743x_ptp_io_event_clock_get(..., u8 channel,...)
>     {
>         ...
>         /* Update Local timestamp */
>         extts = &ptp->extts[channel];
>         extts->ts.tv_sec = sec;
>         ...
>     }
> 
> To avoid an out-of-bounds write and utilize all the supported GPIO
> inputs, set LAN743X_PTP_N_EXTTS to 8.
> 
> Detected using the static analysis tool - Svace.
> Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event Input External Timestamp (extts)")
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
> 
> v2: Increase LAN743X_PTP_N_EXTTS to 8
> 
>  drivers/net/ethernet/microchip/lan743x_ptp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
> index e8d073bfa2ca..f33dc83c5700 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.h
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
> @@ -18,9 +18,9 @@
>   */
>  #define LAN743X_PTP_N_EVENT_CHAN	2
>  #define LAN743X_PTP_N_PEROUT		LAN743X_PTP_N_EVENT_CHAN
> -#define LAN743X_PTP_N_EXTTS		4
> -#define LAN743X_PTP_N_PPS		0
>  #define PCI11X1X_PTP_IO_MAX_CHANNELS	8
> +#define LAN743X_PTP_N_EXTTS		PCI11X1X_PTP_IO_MAX_CHANNELS
> +#define LAN743X_PTP_N_PPS		0
>  #define PTP_CMD_CTL_TIMEOUT_CNT		50
>  
>  struct lan743x_adapter;

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

