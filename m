Return-Path: <netdev+bounces-100754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ED78FBDDE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F311C24D4B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718414C582;
	Tue,  4 Jun 2024 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA9Nj3Ak"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010914BF99
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535563; cv=fail; b=OsWPv4PNKeDcFJ5EUss1020MIasCVXaZwxH2d2aTTYJ3Xuoyj7wn7dztPtToh9lO0FWJrDKRICm19czm9Nlbx9InlWboQf/aS0EZwP5G0pB3JVhAH+++Q06Yq1qY0YOLFqmms4Lv9PZyyVMlSutjhve+UJoLwCWSzKAh7z2RfB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535563; c=relaxed/simple;
	bh=p34QtGO12W83idbqxtCakJSy7Nug/IrNeUWB6RJfais=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EowE7WEm/hGrQGlyM7olbjq11FDj9M2IHF54Bf4bjaPvBwrvwIhRUi44EeG8xlRTALYjYuI2+ymEocp/kOdBxbl5QD0PEXpXMBDfafPvCL+6nAHBk2UBon/Ias2ZR0tdpGnzLkCYKSIl8OaU+Jg9nXNPBt6VECQJGmyFEYWH1Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA9Nj3Ak; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717535562; x=1749071562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p34QtGO12W83idbqxtCakJSy7Nug/IrNeUWB6RJfais=;
  b=AA9Nj3Akouec13uqdmDueIwK0wmqoiRnO0xIw6AQVEdkW3uAHpKCK9K0
   NWgKsr2HfUHg64hCJPXVgd+gbRF5D0BP0Jg9el4HQwXWYCzOP1xkQtAXi
   HJQXsWZS+PlR1RkcGZAJxJjyvPMPlCNQ5V0CnWhJil1WSNvCfCoiE1kvi
   Of+R6w5lKRhRc4CiXGO84zqgWpt5z93P26aK1yv8fDfufOr4P9JPmJ+NM
   f15fsCA4p4xHwzyp8LvylcooXXs7//2CaglVMmJAaGSHlkAzUzVMC0Mha
   cGSpwpvsD/gJftEubxPJq3BT4QA3MP0cpmFvASQd1YQt3D2T2TP/yDqSy
   A==;
X-CSE-ConnectionGUID: vZQvY6ADReGKL1fc854Mag==
X-CSE-MsgGUID: uVb98MRWQrWG9NbwDTxzNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31651445"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="31651445"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 14:12:40 -0700
X-CSE-ConnectionGUID: pp81fA3uSNSZrHda1WPZaw==
X-CSE-MsgGUID: SeWpxo98QFCnszeTu7Caaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="60559835"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 14:12:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 14:12:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 14:12:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 14:12:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 14:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILLfBqRjUjwj0gsNNrPXIPcIV3CAJZJ6eBKvYNNnCvbyrMxavv1/WZIDfUttebzcbBGJ40ctnM10m+G8wQN0DIhjCSXKXjdJbOWBcKnmtTjmqvzHOTzfyPJgoLiUh8skTPKdNp8X4XqU0hDHOjN/EZW5BnPKZ+UQyU11C660j+ijYkaKs+oMC3JjE+mQBiP4FwBP8npwRqy+79evl3I4qivyq9v4lOgRUrKIhfF7+TSqlb9C0HJm9OwKbuTZcsP235Z1evHu19NUt7KFiSGl61VyC1hz/dVDiTUA3hyNbnxpAfS70IJ8VVNHJoo5HpsiAZ2VBzt3gyfvJI1irrCIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKa2W4u/Nfmqs1EBxoLed7aef0DmhjWt35YJ5HyVlXM=;
 b=SkmnEDxVX6B/9pmdBiwOZ0zBzr48xIi5wQgmSEkSn745pUxTC/jQTh5CjtGg5uvi4fSKMwmUQxTbGVTuOlNVdkZyFE8eW2tXFYh23ncjI48iYxtfLiSvYUE5zqLYdQhiH6cUGyp/8kJYciRGEhgtL4dOkKYUs/kc+wAJ0TtXHF8WoLjdDgdDUMStuih1y5Z/qVJb4Sl/MOfZCj6zuLs0UPhswFEv4kdbD66xqHAB1KQ+9E/v/WGzVr+861pHh8wQELcabIEeWdxUXtmHPCl8pZ5NOIuU28R0mjaGVdwJWcGmrCvXR5+BPCJrgs8mK16GsU4g+q0JGAMJderbTrVQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 21:12:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:12:33 +0000
Message-ID: <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>
Date: Tue, 4 Jun 2024 14:12:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Vitaly Lifshits <vitaly.lifshits@intel.com>
CC: Menachem Fogel <menachem.fogel@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
 <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d748ccc-c13b-42a0-9f2d-08dc84db0cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3A0Q0YxNWw4V2dSRld3S0hGektEaFlnODhYRklVamxOeTI3bElEbTNua0x3?=
 =?utf-8?B?TTRneVI1ZTRmMG5sUytZYm1mMytZdWRveTdnWlIvcExBTUFoN1kyZzR2VDJa?=
 =?utf-8?B?U214aHFDQkhHREt1QUozdjJDOFBITmw3MWxKS2tMWVcvQU16N2picWVTbnRv?=
 =?utf-8?B?dWRtMXk2OE8zbHNWMk10QWZLOWIxd1F5OW1UcXIwamhyeWM1bFVXdVBvYk1x?=
 =?utf-8?B?SnRBRkNFd090V0NhbWZDajZDT1VGQUZWeHF6ZkRCSFBXa1ZvYzhQRDNkT1k3?=
 =?utf-8?B?NGFTa3N4Sk9XSjlCbXF0MFl6eTVzK1F2alF3cDlUTkdUT1Q2bFZtSWZmQVBH?=
 =?utf-8?B?YWJGTzYwL05YV1ROOGNqbWtQdjIrN2EzSU5OK3lIRlpRcEtXVzV4U3o5b1Zx?=
 =?utf-8?B?VER4QUF2VVB3dTRRR29DMks1UTRLZk1hQVVpMHJFRXd4bXJPQ0tQTy9GUjh1?=
 =?utf-8?B?R2MxYTloVkQzenVRL3BtZXpDU0x4UCtJNlVGRk1oTTQreUVXeHhxUEl6bzhI?=
 =?utf-8?B?WkRsVkxwNlhlQ0dXZ3R0bVlhOWFOcHNXMk9vaytMMTYzSjNEamxXZjdrNVlv?=
 =?utf-8?B?T3NaSE1aNTB4N0RQMHhUdEhDZmVUYWROWWdUSGg2VWZxNElndXA5dkdOZkZQ?=
 =?utf-8?B?SC9kVzdxcndhM2pGbEFBYkdNcXJrTTk3NlJ2T0hQMFhGK2FLTElWRm1RVFg2?=
 =?utf-8?B?WXdqbm83aTJDOWNyRDZBWUUzamhRMkJVRlhGOCtWeWtNQ3VTdUM3cjFxdEpX?=
 =?utf-8?B?Zy8zcFpaRXpXNWZlMFJKQUd5d1JvSGRubHQxZ0JBYVdnY2NsRnVYUUcwM1N3?=
 =?utf-8?B?K0hLb2d5YzFDb0V3cGs5RzZOaG53WUdWTU1kS24vUDdkU2tRSUREQnFiYXR1?=
 =?utf-8?B?TnV1WlBVOUl5cXFXbHBYWnd2alhWeHg2Q3VIYmVqVkxSdzh0TVRabXNicmdQ?=
 =?utf-8?B?cUd1SG0vVXMyYjB2aW5IdTZtbGxyS3lCTm1RWUFRcVVNRnFGNklOeXkySG1z?=
 =?utf-8?B?bGNlRFVsV2h1eW9YY2FtZVBEV0kzSWFsSUtwcURndHhqZEdFZ1oxNFM3TktW?=
 =?utf-8?B?RWtXYXpsNkE4OGJNemZSM3pHaDErYzduZkZGSnp2NnFveHlDcjJLdktwWkpD?=
 =?utf-8?B?VFNFZXhwYmwvaTcxR3Z1QVcwTC8wdDJUK0FlRnR1T0cwdVNCemd4UVRSbmhM?=
 =?utf-8?B?NnBKOTNZb0k1RkQ5SU1OOG9ZQzg3ekY5bG54Kzl0aGRnMFZieUtxOW1JdW9v?=
 =?utf-8?B?cUFIT1lqeGxGZStvRFJYRFlKRW8zQlA2SnlFeFBicFcxOFVoOGRORE5sR3Qz?=
 =?utf-8?B?MXVPVzlsMFdIU1ExWVNNM2M5aHpIMHZFMTBMSUx0RXhnSi81SGFwWkNpNm5R?=
 =?utf-8?B?WFkvN3dMakpBY1Z1M0JjbzJYRDB2M0o3TTZiVC9icDFFQ1JCNXNTQkxiUzh5?=
 =?utf-8?B?ZVJ0VWdISlpJMkFvWEFaTEtwblpUUzRNWDRHYzFVcTM3aDE3SlRjODE5VEhn?=
 =?utf-8?B?eVBTcEpVRWlhOGpWNTVxUW9LbGY2WkpPTHUyeXVnSTBQNHo2MlVMazlJTE9U?=
 =?utf-8?B?MnUwMFN0MmxuaDdJN29HUzJyZVBDL0FuYURRa2pkeGtITmI1ck5oa1hyWHF5?=
 =?utf-8?B?YmhTY3U1bWdSQzBob3ZOSEJwUHVxR3FhVjViOU1odkhPYjNtSDF6U3ZuTXJv?=
 =?utf-8?B?TGc0NjdKNWM3dFZobW4zKy9WWkV5VXJDVTNBY2dYdDFtL0RrZy8xSzdrZm5G?=
 =?utf-8?Q?JhNr/Ydt7KJIwU948pFNqkserSsvKWpGx3Bxwyi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b21SY291K0pyamw2Mm5FNFpQZ1dzZ2pmU1NKeitEWGdSY2FBa3duTUFad2kz?=
 =?utf-8?B?Nk5TaVpGRkN3aEQ4VVljK0V4QjlPTHpERjRJTW5MV0ZEaFJlSzdyakFLbi8x?=
 =?utf-8?B?TnluVGNidWNBRkg5a2tUZVhPTVFxU2FuNkd6WWpLNHVodHdwMmtrQkhIZE56?=
 =?utf-8?B?Y3Awbkd5dnI5czhVaEpvTFA2V0V4UDlKMHBQcFlWOW9WeXFjUTdJRXROcVR5?=
 =?utf-8?B?Wjl2OW82OXd4bEV6TFIyaXN0cytVNW5hVnRrZ2xRT0RVYXdVWjR0dHZtR2Ru?=
 =?utf-8?B?bjhNSFhScXA1RFFmSG5zQTJkdEdkR1RYR3I4YUh0VWw5NWpPZVFDcHhPclRJ?=
 =?utf-8?B?VG41dGdhNGZXQ0tvUFRyak4rMEFCdWtyTElkU3BaYXFFQlozSU5wcEhNZ3hm?=
 =?utf-8?B?ejM4NGcvM1ZuRDJBNFlhaTgvSkV5bEU0UUYwdlU1Q2FXYkIrVE1UME1TV1NS?=
 =?utf-8?B?VEtSb2pPWUlqNGRoazhGRGZlZ2Y5dWZmY3hhZnZCYmQ1Vlp4MlJ0TkYzMG1K?=
 =?utf-8?B?QWJZN2IxbXh4NnFhNEs4VlBzOUtCM283T2pPNlBMdmJWMjJqc09HWFJlNXN1?=
 =?utf-8?B?WURUZW5lVDR1Y2lDS25BcjBnU0JGN3JoblJ3QVVPd242Z2JBRTZtWVl0bXdq?=
 =?utf-8?B?U2hkNUNUYTdCR2tDWkYyWklOUGhKY0VkcGl1UmpjZG1xU0JGVHhVdUxRQ3Nu?=
 =?utf-8?B?cWRCbVlnUXRIUWl3NWhWelJnZFVCVDlsVjNncGtVSnhaUGdOSFhEVDNFU25y?=
 =?utf-8?B?L2pFdGJhSUV6dHQweGI0OEphRDNRRlJ2WlpLdkF0ZDNBc1RFd2VLWFRDYVR1?=
 =?utf-8?B?T0dSblFuNlIydW9tV09IQW10bkZXNXMxbXdEVmZtdjFwcGhoeG1oWnM5Ykdq?=
 =?utf-8?B?UEQveHMxc0JjVEhoMFl2Q0hxRXlBMzZQOEFHMmpmV0VaSVByU2ZabDdQMWFZ?=
 =?utf-8?B?a0ZoN3d5TmxiWnROQkplaHFoWUdlMEVEai9idllhWktsWlE3VDJxdU9KM2Zj?=
 =?utf-8?B?VDVmMit1dVhnZVZQcXIrTWJJVlY3UGNDb3FPa1pLQkxlS2s1UitZaER6WHJG?=
 =?utf-8?B?Wld5VWp6WFNqc3FVNUh1NisyRkc3Q015LzJtdWpKcHYxS1ZkbkJySUxhZWpo?=
 =?utf-8?B?YlBpTko5Vy9KblM1cU9HdmNFcmpDdjEyRk9rMG85YUV6UFh5cEhRKzVtS3ZS?=
 =?utf-8?B?RmtIQWRzTUxtVndpMHNwTXpVMERvZ1lqTFlUTmVRZUhoRlZWa05zd1hVZDM1?=
 =?utf-8?B?Z01yWlV1OG95ZEZ5czBJL1VGNmxpVkFjRk5YWTFUK1JJTHBHYWJlY3lxMzNr?=
 =?utf-8?B?NXY1MzNoUlhWcFViYkthOFJVd3FMblJRUlNsenIzQWg5QkZ6YStBTnM5NkNt?=
 =?utf-8?B?UUZsaVFqYjdKRC9XdVRkOEJKQm5uWUkrNWU0MEtWQlhuT2N5dGxWOFo3ejJN?=
 =?utf-8?B?TXlQWEVFUjhlK0s4R2pnSXFLWEdiZzNxZlV3MjNmR2RiZUhCS09VdzBxWnNX?=
 =?utf-8?B?U2hsUFFtaFlLeXFLQlBlSHBwSHNvUWRpSzYvaVlCM2NpVWNPN3BvMWovc1I0?=
 =?utf-8?B?RHR2cUJteXpjL3NKOXF3YWRNeHh6Q2N2d280K0pVdkR6aTFYbVNtSTJ0Qk1B?=
 =?utf-8?B?RU5tMW9QQjJGdllBQVhDanNuSmNQMXBEam5oeDdHSS9XZEs2akw1VkFPRFVj?=
 =?utf-8?B?UHFxdjRGRkl1M25PclgzTUh1V254TVQvQnFQUGlFYXJYbzJheG8wMWV0NGNM?=
 =?utf-8?B?RCtzak9Da0ZseFNpQXN1NFFjclF4YUo4TVA2YUNtNDhFZDNsZGRoanhJU3BR?=
 =?utf-8?B?b2lNV1Q4MVRyMHl1eUFpYlVqc2paOFh6TnVJdU5ESkRWNlRyNC9SMDJvWGdw?=
 =?utf-8?B?ZnlWQjcweDB1UkRPUlpkeEFuNnRCNDNaSmRLaHN0SWFZWWpNRTZxT2dPVjBR?=
 =?utf-8?B?Y2g5ckYvNXVQcmM1QVZxTVpSYkVJSjkyeDYrcnEzdmkxbFFqMC82NWF6YWVo?=
 =?utf-8?B?SXVQOEZ2UUpqTlNUVnQveXNhaExrdXFuQU1ydW1LOW9BcnQ2L014dDNXTjdH?=
 =?utf-8?B?VUF1VDVaQTFZdGZGNkcwK29CanBJL1h1cEYwQ2Q2ZVFHRXhPTEZHbUo3aXZm?=
 =?utf-8?B?bE91bXdhaCtjR3NlV3BWanNCNUJEdlFrV0x4OThES1ljY05aRXk2QTFYSFFx?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d748ccc-c13b-42a0-9f2d-08dc84db0cf4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:12:33.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G+CN/mk3VLGwklKqaOckYqiT0hT6jF8pAjj5ktGcZhlzf57CyIq1hsPg/lC5bv7OFqzL2+UBhCRVRu++V72wM5tI2VTxa3KEb5fjJjgjhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com



On 6/3/2024 5:12 PM, Nelson, Shannon wrote:
> On 6/3/2024 3:38 PM, Jacob Keller wrote:
>>
>> From: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>
>> Add support for ethtool.set_phys_id callback to initiate LED blinking
>> and stopping them by the ethtool interface.
>> This is done by storing the initial LEDCTL register value and restoring
>> it when LED blinking is terminated.
>>
>> In addition, moved IGC_LEDCTL related defines from igc_leds.c to
>> igc_defines.h where they can be included by all of the igc module
>> files.
>>
>> Co-developed-by: Menachem Fogel <menachem.fogel@intel.com>
>> Signed-off-by: Menachem Fogel <menachem.fogel@intel.com>
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_defines.h | 22 +++++++++++++++++++
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 32 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/intel/igc/igc_hw.h      |  2 ++
>>   drivers/net/ethernet/intel/igc/igc_leds.c    | 21 +-----------------
>>   drivers/net/ethernet/intel/igc/igc_main.c    |  2 ++
>>   5 files changed, 59 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
>> index 5f92b3c7c3d4..664d49f10427 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -686,4 +686,26 @@
>>   #define IGC_LTRMAXV_LSNP_REQ           0x00008000 /* LTR Snoop Requirement */
>>   #define IGC_LTRMAXV_SCALE_SHIFT                10
>>
>> +/* LED ctrl defines */
>> +#define IGC_NUM_LEDS                   3
>> +
>> +#define IGC_LEDCTL_GLOBAL_BLINK_MODE   BIT(5)
>> +#define IGC_LEDCTL_LED0_MODE_SHIFT     0
>> +#define IGC_LEDCTL_LED0_MODE_MASK      GENMASK(3, 0)
>> +#define IGC_LEDCTL_LED0_BLINK          BIT(7)
>> +#define IGC_LEDCTL_LED1_MODE_SHIFT     8
>> +#define IGC_LEDCTL_LED1_MODE_MASK      GENMASK(11, 8)
>> +#define IGC_LEDCTL_LED1_BLINK          BIT(15)
>> +#define IGC_LEDCTL_LED2_MODE_SHIFT     16
>> +#define IGC_LEDCTL_LED2_MODE_MASK      GENMASK(19, 16)
>> +#define IGC_LEDCTL_LED2_BLINK          BIT(23)
>> +
>> +#define IGC_LEDCTL_MODE_ON             0x00
>> +#define IGC_LEDCTL_MODE_OFF            0x01
>> +#define IGC_LEDCTL_MODE_LINK_10                0x05
>> +#define IGC_LEDCTL_MODE_LINK_100       0x06
>> +#define IGC_LEDCTL_MODE_LINK_1000      0x07
>> +#define IGC_LEDCTL_MODE_LINK_2500      0x08
>> +#define IGC_LEDCTL_MODE_ACTIVITY       0x0b
>> +
>>   #endif /* _IGC_DEFINES_H_ */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index f2c4f1966bb0..82ece5f95f1e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -1975,6 +1975,37 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
>>          msleep_interruptible(4 * 1000);
>>   }
>>
>> +static int igc_ethtool_set_phys_id(struct net_device *netdev,
>> +                                  enum ethtool_phys_id_state state)
>> +{
>> +       struct igc_adapter *adapter = netdev_priv(netdev);
>> +       struct igc_hw *hw = &adapter->hw;
>> +       u32 ledctl;
>> +
>> +       switch (state) {
>> +       case ETHTOOL_ID_ACTIVE:
>> +               ledctl = rd32(IGC_LEDCTL);
>> +
>> +               /* initiate LED1 blinking */
>> +               ledctl &= ~(IGC_LEDCTL_GLOBAL_BLINK_MODE |
>> +                          IGC_LEDCTL_LED1_MODE_MASK |
>> +                          IGC_LEDCTL_LED2_MODE_MASK);
>> +               ledctl |= IGC_LEDCTL_LED1_BLINK;
>> +               wr32(IGC_LEDCTL, ledctl);
>> +               break;
>> +
>> +       case ETHTOOL_ID_INACTIVE:
>> +               /* restore LEDCTL default value */
>> +               wr32(IGC_LEDCTL, hw->mac.ledctl_default);
>> +               break;
>> +
>> +       default:
>> +               break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct ethtool_ops igc_ethtool_ops = {
>>          .supported_coalesce_params = ETHTOOL_COALESCE_USECS,
>>          .get_drvinfo            = igc_ethtool_get_drvinfo,
>> @@ -2013,6 +2044,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
>>          .get_link_ksettings     = igc_ethtool_get_link_ksettings,
>>          .set_link_ksettings     = igc_ethtool_set_link_ksettings,
>>          .self_test              = igc_ethtool_diag_test,
>> +       .set_phys_id            = igc_ethtool_set_phys_id,
>>   };
>>
>>   void igc_ethtool_set_ops(struct net_device *netdev)
>> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
>> index e1c572e0d4ef..45b68695bdb7 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
>> @@ -95,6 +95,8 @@ struct igc_mac_info {
>>          bool autoneg;
>>          bool autoneg_failed;
>>          bool get_link_status;
>> +
>> +       u32 ledctl_default;
>>   };
>>
>>   struct igc_nvm_operations {
>> diff --git a/drivers/net/ethernet/intel/igc/igc_leds.c b/drivers/net/ethernet/intel/igc/igc_leds.c
>> index 3929b25b6ae6..e5eeef240802 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_leds.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_leds.c
>> @@ -8,26 +8,7 @@
>>   #include <uapi/linux/uleds.h>
>>
>>   #include "igc.h"
>> -
>> -#define IGC_NUM_LEDS                   3
>> -
>> -#define IGC_LEDCTL_LED0_MODE_SHIFT     0
>> -#define IGC_LEDCTL_LED0_MODE_MASK      GENMASK(3, 0)
>> -#define IGC_LEDCTL_LED0_BLINK          BIT(7)
>> -#define IGC_LEDCTL_LED1_MODE_SHIFT     8
>> -#define IGC_LEDCTL_LED1_MODE_MASK      GENMASK(11, 8)
>> -#define IGC_LEDCTL_LED1_BLINK          BIT(15)
>> -#define IGC_LEDCTL_LED2_MODE_SHIFT     16
>> -#define IGC_LEDCTL_LED2_MODE_MASK      GENMASK(19, 16)
>> -#define IGC_LEDCTL_LED2_BLINK          BIT(23)
>> -
>> -#define IGC_LEDCTL_MODE_ON             0x00
>> -#define IGC_LEDCTL_MODE_OFF            0x01
>> -#define IGC_LEDCTL_MODE_LINK_10                0x05
>> -#define IGC_LEDCTL_MODE_LINK_100       0x06
>> -#define IGC_LEDCTL_MODE_LINK_1000      0x07
>> -#define IGC_LEDCTL_MODE_LINK_2500      0x08
>> -#define IGC_LEDCTL_MODE_ACTIVITY       0x0b
>> +#include "igc_defines.h"
>>
>>   #define IGC_SUPPORTED_MODES                                             \
>>          (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK_1000) | \
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 12f004f46082..d0db302aa3eb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -7070,6 +7070,8 @@ static int igc_probe(struct pci_dev *pdev,
>>                          goto err_register;
>>          }
>>
>> +       hw->mac.ledctl_default = rd32(IGC_LEDCTL);
>> +
>>          return 0;
> 
> Is this the only time the driver should read the register?  Are there 
> any other reasons/times that the LED register value might change while 
> the driver is loaded that shouldn't get lost?
> 
> If someone leaves the LED blinking then unloads the driver, is the LED 
> left blinking?  Should igc_remove() restore the default value?
> 
> Thanks,
> sln
> 

Good questions. Seems like to me that it would make more sense to
initialize IGC_LEDCTL during probe to a known value, and possibly to
ensure its cleared back to the normal state on driver remove.


@Vitaly, any thoughts?

