Return-Path: <netdev+bounces-293914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I76GRIEHmpRggkAu9opvQ
	(envelope-from <netdev+bounces-293914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB2625CEB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D86E23008A70
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4553136D9EC;
	Mon,  1 Jun 2026 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aji12Dvv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CB1A6839;
	Mon,  1 Jun 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351793; cv=fail; b=sFiRv1Gy8yS/tPRUoBvB/68vE7yAVFk4BuUI6maZ3+yNTnwLVFu3geNCvE6KivziW59xP3vHv0NHrkGxCCsC/MZnVc8RQTp3AXeMu4UjadVYFb5mIJSz6dNqixl7bkjh6yXvE5ALY6wT/xwWPqgVUDBLMhg6b8Jw0htGSNG0KbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351793; c=relaxed/simple;
	bh=NbsnvFehEEMQK6HXQhu0y2cv3r+awhEacZvmLLTOqhM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b06oTRbJleoRb3Z5b689FUAc9c45H2mjZCUVzzpB09Mfu21/nR4Kx2FHmm1hF2X6oN87JDpJobA5bVEOVrd042RcS1j1993myRY+0tMZbSlOdcxYrzonqj5SAZindng6gc+FXDANi8NKA5MUbF00W/xRMhAJynV52ZsHCBzp2no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aji12Dvv; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780351792; x=1811887792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NbsnvFehEEMQK6HXQhu0y2cv3r+awhEacZvmLLTOqhM=;
  b=aji12Dvvhz8TLU6ier86amnlgvb2uSSt5eYDRb9Yt7rHvg1F/MRqFciE
   qY90EUhhX7rgvpbYp/nzVshAT2avuNFjduo8U5bJLfgntZP+mdlxH76xj
   75gEk2NClhCV8keajUYxotiNIh4xEpizjPBthTP/8S5GJn6WtTnedO9fM
   MNa1J5t/IZWFwJ3v1ZFJ8gw8cRwQgqOpRn7HOmjw99pXenbv7MFPhOp4g
   FlX3JGaVRnyAw4K3SWOUkmvL+oX3wFLNvm1hu7ASzHRxyhhzdInFXjpcE
   X9nqkWSmKmRoVtXJpQPLHT5Giddf0+1ekBEHs0EYtr3pr3OB73pFHWq6Z
   A==;
X-CSE-ConnectionGUID: BYz14MlBQdKsintmXHhlkg==
X-CSE-MsgGUID: O7SfBkZHSI6bC3XAdjrxSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81021548"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81021548"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 15:09:37 -0700
X-CSE-ConnectionGUID: 83+JAPxCTtC3JFLWqIbdpA==
X-CSE-MsgGUID: CB2ZJuXqRsOhy6AAd7HHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="247970830"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 15:09:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 15:09:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 15:09:35 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 15:09:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbnhuSWc7IBO05G0t6ovNA9JJUpxnTuZW/Yvg9BfDKIOy+1zfOBfciUNHffvkU3pIDOhW0KOQQzUH02Rhcsm1cHNe52bog0dsV73GLFtRgxb5cNFmC8WbzbW+WRJ0oFy7tiNfw43SI1kQjjcb/Cvrp4OP0VgaA3vVYnLBAt+FFzK5joZliUyKNOPacm7PbtequxjsueIqOb0s2qnMBCHAqZbS1jG5A9bAS919wMqT0WBZ+1Wc1R3mKccFi2p/hzOCWUIWl1oF1icnnG5CEH9+m5+Zx9t7Bs4Sm6+QkWOzXZjE62Bt+ZpifWmmms7RpGAFt1sTm+yFY+wHXHxHzpI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wHXCKzs6Y3lbd+MGKKzWSYxrd4KtSaF/KNKb2xu2v4=;
 b=bNvnui/2b2V0mVLapCHe6FsH+IOtveQQbEaUub26C7tVGAhU9JzWiWiUepmm6jyWPUMrcVasB3cvE4eEjFJ+ld18iRwhngsHlBOZHUtp5EnzRxrE01zZnXIe8lUHmkOUz9txsoFRPdKeI9odW8rhkZaS6DS20m51vGvIy7h5AiEDlrAX0YbJntHltbbSTLW4TAajaOAnB5tw+JIJoRPcWCnMvqqTw4lZKa0lmXJvdddRE87Dm3VDjP+7/uc3eSpTYQCVP8GQF4gqysWohLdbcjJXZKD6GIsB3Zck0HG+rxq/dsyKaqN+F0Nir4VJSgTmVj3iHClFgSmHrXQsdOutug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB9605.namprd11.prod.outlook.com (2603:10b6:510:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 22:09:32 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 22:09:32 +0000
Message-ID: <fb243964-54b6-4de0-bfbd-a748520d9297@intel.com>
Date: Mon, 1 Jun 2026 15:09:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ibm: emac: Reserve VLAN header in MJS limit
To: Paolo Abeni <pabeni@redhat.com>, Rosen Penev <rosenp@gmail.com>,
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260526202247.13823-1-rosenp@gmail.com>
 <625ecceb-3b0a-45a8-817d-337b37df7335@intel.com>
 <0b71d385-7504-4a5b-8e21-dcf7c692d456@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <0b71d385-7504-4a5b-8e21-dcf7c692d456@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7171ac9c-6834-4346-cbf2-08dec02a754e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099006|11063799006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info: rF3SEupSg0jvpADtqaLONJBMv3fkMvmOPXzOoUZwCcz8D0K/BABD1n5UyQ2oIDrqucNm7xJrrxE8YPAjxpfo9Kp78c6AYZNg7Lmj7+T1ifQlletQezIw01fPJdwyOLu8RLk8EJ1gy9dgSBJ0JybqrtxjxyKERw40dtQlIvigeExCygHPNp6WdeJxFpmTep0dudvW+/bSSg874/kfMHdgq2jaKkIOldiFf+J9kEAd3O5QYDkH+VlPcs5G709Pt6QQmQ7tW6j/I6n5qvSS9cy5xhUv6VG1Or8qnRJaKNw2GWYUiNTM5N/CUF/wSbY/1ZFVGvVAfbG0W8gfomWq7+vrp1GDkh3Xnb30jUGfCQ7ewZbt30D3uazKraa4zJb5ccIM4fAXW32jg2R2Il7jVqE+jNA5SS/kACxa94JOp9YOh5YVnKStIcFDu1z5qtyp193HIvB4vmjaOLlhk6kVWqo7bRae/YsQHos3Of/kMeP4l/zc+w4iTOlF/k/sTNeZlUKHA/SySASHlsqsUUOmoNMzvcY6E1oyWaF4zVQJy26SMuq1uYqyq+GmoY9bB/cguI9OHIe802B/AfmAP+igTbPZOstLZ+T3sbfGotWzdGc57t5YQ9WxPSvY8FLJmn1uHkHnWIIjcUUSu/Kuxom1RaeALoAoYfSHpg66emC0DJocNdnpLqgRnpKHZ4KTbsyFrFlu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBOWXhTMjAwM3FGUSt6MWI1eVhlcTN1TjhmLzJhY296ZGJBeG1XQkRadGw3?=
 =?utf-8?B?QVlxRlBUTUVCOEN3YzIzeEd0cEdKU1lCbVN2NXB4blNpK3VyVmFRNG5qMWlM?=
 =?utf-8?B?ZytyMlBmQlhxR2JwV2w0amsvYnBnS0FHRjNVd05tcUxGa0NEY2FSTDRvT0V4?=
 =?utf-8?B?M0N1WHlOQ1psUit1bDlKYmN1VSt4cERid25ISGJFaWIzUStvcDhJY0pHQ3Q5?=
 =?utf-8?B?Z2lNM0xUSU9OcVJlRVozdnpLc01MbXpCOHREVFJQNStWWFhzNzd3WVZkWEx0?=
 =?utf-8?B?MGtONGt4RmNNdW9Zb1pmbGZ4ZCtlbVNmaDNCbm9GdUpCeDZLR2lpTm1kOHRv?=
 =?utf-8?B?aVlYc3YycmVwREZFNDc0dzVubytGZHIvSlgzZmVrdjA3WGFvWTFINm9KNjYw?=
 =?utf-8?B?eDVkS1paQmtLVlBqQzZWNzRud1VIeDN1Nm0xU2xxSE5RSGdjazk0WXdKZVVs?=
 =?utf-8?B?VWtBZUJLRVlJZHBJblZnVmJqOUtTRGJwRmtubG1BNmVaYm1lZzBIQ0dEK1hh?=
 =?utf-8?B?bS9URWM1UStvT1BqaURBUHZ0Ym0zVDBHOVVUbHpuTFd2RzZnUjNzWGtQeW9D?=
 =?utf-8?B?czNzcGMwMkhxS3JJRVhoZUtGVGhXNS9QQ2ZJYTl3RVlEZzVrREFReTFKTzhS?=
 =?utf-8?B?UTBacHMvc0x0VzZTVkZtc1dtOUdkbGY4WlhVTDRjRUVsa3Axc1M2U2dDRUg1?=
 =?utf-8?B?N0FpUTliT0Z1QjVOU05DdjVBU0VLV0t3QjZNWko3dUl4a2RRVjZXZ3BBZWNy?=
 =?utf-8?B?UDZKSW80MnNvOG55ZXM2S1VjVnh6TU9YN3lOUy81UDd5UlQ3MUxIK1JDMy9Y?=
 =?utf-8?B?T1B6TlJlSXlDQkdDWFdVM1gzWkpGNGVCS2NPR216ZTZXd2ZkaGJLUjRBcGpY?=
 =?utf-8?B?cU5NeFNPajJPbWIwSEt2RVFNekI1ei80RFRMUmduYVZvdTZlRnFaWDQxdFdu?=
 =?utf-8?B?K0k5WWRiV0gzNHVDSkVGbkRFUEI2S3N1TXBSbzQ0UnlqeFlLTS9oc1RJbzlq?=
 =?utf-8?B?ZDlqdEdYUzlKVktFc1o5Sll4eUczRjNVZkc0OFhMTzlHSWg3bFhKblkrcW1Q?=
 =?utf-8?B?Vm9ON1FXdGFDM0owK1NDVHE5Q1QybjNKUEZmb0ZPdzRiY0l6bjlKZnJJTGRK?=
 =?utf-8?B?NEViZ0JuRElDMmVzaFpDOE16aytIV2pLVWZKS1hQSGRZbVpQNU0xRWptU0lF?=
 =?utf-8?B?ZDUvVDJNTE9BbWF1WDUwQnFKa3NvN0ZiSTA2Z09wd205Z3dKOVBESGhWcHZt?=
 =?utf-8?B?ZnlWeXFMaXJTNGVQVHd3dysxNmw1Y0pqTUdrd040SDluWC9YZTExRUs1Rmdw?=
 =?utf-8?B?VXZlT0NuekZ1VnptN2hIWER3bi91WFVZbmZzNXRUdXRvb3pSdloveFdEWjhF?=
 =?utf-8?B?N0NuSUhRN1ZXYlBTcklxR2VZWXc3d0k2VDlGMTV5ZHg0T2tid1NKUnROR2hy?=
 =?utf-8?B?bHVHVXUzYUw1ZGE3MHEySkNwZkd2SDNFZDhEZkVpTzB3NlBPODdzeVh1Q0dT?=
 =?utf-8?B?RWRKQW94RWJXT3RUbVJqWjNNTDFMbzBaWVpaVTA1QlZaY1ZyL2ZHTlE1UGNM?=
 =?utf-8?B?endKRVlRVUMzOUE1WHM0TjdqclpLTEg3RUU2V2tnMzZabHg3OGNiQmY5ZnJv?=
 =?utf-8?B?RGsvS3E0ZGxUVE0xbDh2WXJtRUpmT29wSEY5WkJKcjBKR0grOWxLVTd4SWMv?=
 =?utf-8?B?anN6TUo5TjdDdlo3SDczWHU4cXVkZThURGVQM3Vmc1VWNDVpV3I5am9mcE1m?=
 =?utf-8?B?UnlYWkh5YnFkaVY2K2crN0lmbDRSVmRZY3VtaHpWMEhFUVF4QzM5S0I2M1Zt?=
 =?utf-8?B?UE9GZ2pLSUJsQ2dCeHovcmR0ME9VSDZmVnVPM1BjZzMvbi9VUHhuVzlobUMy?=
 =?utf-8?B?ck1VaytUUjllNmlwQUkyS2VqSlVudTRNalBtdUJTcXZrRUdUbWo4L2FYZTRw?=
 =?utf-8?B?MHFJTUQ1ZzRjUkR6bWFBZkp4YkVYbTJXWVJaNVpBYTlFUzNhcUpRazB4Ry9r?=
 =?utf-8?B?SkxVVVRyMHFmZml0ak5lTUlUNGpwNFBkdWJYeG5GNFN2TVJiaXpNMFM3eCtT?=
 =?utf-8?B?Q0tPakViMWhucXJ0Q2xocVQ3bDFpNGJsVU5YQkN4cmFVdWlmLzlQcDFZZHBX?=
 =?utf-8?B?M3dZbGM2TVZNTlRPL2RnWHhWQzhoVnZ1eCtjK3R0cTNmUXJkMmtGOVRnOXc1?=
 =?utf-8?B?S2pwUVg5ZWJyNDg1bzNlN3lndGdpS2UvWTZqSG80VXRxSXNJYWhIb1gwMFla?=
 =?utf-8?B?WnJmVU05bTl4Q0JXbFZKZ01UUlR5QUFvWlJGeHZFUXJDSWFJNDh4eWZRV2NH?=
 =?utf-8?B?OVZoc2FYV0VZNno4NlZaQ1czZkYyekRhb1IzVU5NM1puMDczdjRJZz09?=
X-Exchange-RoutingPolicyChecked: ge9zSHMPrl61bz9mtxmTpk4tChZx9yisth4E0eAt4WHnXdcW1Hpe+z/OPxcRuxmUW9QS1bJiJFk1/4Uq4Y+yUE8Doc5lm5xreNPKOQUF5cRUo/BBN77AvbC3o1otOTfNWxmAoYVH+W55OdVjv5RhtxQhz8dIjNhan2iwhMIg/ygaKZcrvrnFzQ/efKDUKf6Kp5FY17VK8MWVQIkV4yx6zIpdlSpB3vqHfyehSS/J2t1eCizINotlgC964KDe3VGtNBMmlLmxv/x77RTi38TKFbrv3uIO2/s7sfymTH+QRmMU71UB5L/s8Qb+6x9mf9bJv451zOGkeoIqPS9OJLeKGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7171ac9c-6834-4346-cbf2-08dec02a754e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 22:09:32.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzIHwr7dFoDqM2jbE+05X/aqJilfPAOlTmn/GSrL+lWWZgmYBMZJvgCjy6ja2dlH95CEzo64XcjoKOqjeuzItA3hFounalE1IAli0hZLLYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9605
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293914-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E3AB2625CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/2026 6:35 AM, Paolo Abeni wrote:
> On 5/30/26 1:18 AM, Jacob Keller wrote:
>> On 5/26/2026 1:22 PM, Rosen Penev wrote:
>>> The IBM EMAC programs its Maximum Jumbo Size (MJS) drop
>>> threshold from ndev->mtu directly. The hardware sizes the threshold
>>> against the L2 frame minus the ethernet header, but does not
>>> discount the 802.1Q tag, so a frame carrying a VLAN tag and a full
>>> 1500-byte payload exceeds MJS by exactly 4 bytes and is dropped.
>>>
>>> This is normally hidden because JPSM (and therefore the MJS check)
>>> only engages when the MTU is raised above ETH_DATA_LEN.  With the
>>> qca8k DSA tagger the conduit MTU is bumped by QCA_HDR_LEN to 1502
>>> during dsa_conduit_setup(), which is enough to enable JPSM and
>>> expose the off-by-VLAN-tag in the limit.
>>>
>>> Pad MJS by VLAN_HLEN so a VLAN-tagged full-MTU frame passes.
>>>
>>> Reported on Meraki MX60 (qca8k switch): tagged VLAN
>>> traffic drops at 1500-byte payload, while 1496 bytes works
>>> and untagged 1500 bytes works.
>>>
>>> Assisted-by: Claude:Opus-4.7
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> If this results in dropped packets, that seems like a user visible bug..
>> Should this have a Fixes tag and target the net-next tree? I guess its
>> not a "regression" since the driver has always behaved this way, but it
>> still seems like a bug to me.
> 
> Given it never worked and we are trying to keep the amount of changes
> into net under control, I tend to consider this suitable for net-next
> i.e. enable DSA support.
> 
> /P
> 

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

