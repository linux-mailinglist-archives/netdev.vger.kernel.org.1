Return-Path: <netdev+bounces-283848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL2KGp2c+GmdxAIAu9opvQ
	(envelope-from <netdev+bounces-283848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E724BDBB2
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E911730D37C8
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904023D903B;
	Mon,  4 May 2026 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HiNiin/d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853693D567D;
	Mon,  4 May 2026 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900306; cv=fail; b=ennMPsAau9EeP4QsfSvjnfkRh0JSAymPjgM1OiKLYhbISRiSpVh2GVjGU5JfLmnwJ8Bgb5xNxSgBeIkFK0fBcfFEoC30rRX81AzvWkBLm2TvQH4bvvj8NP7TcnTQC7ihHa35286GIawFcce1yVXfpmx3fyAwUcR5r86cRc+vfEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900306; c=relaxed/simple;
	bh=GKx0v6ghzyiiyKL1b2aF4rlj7Oe/hjegscBz35C44sc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hP5YgmBq4XHFfvQYj8mJesHHkhff4YOBHSIEkoNsBPcR9uEzUxu+fcTRYOcYoYNkgKne/TdMjbfyUZYKDDiKfTYKZ9oyz/GWLxKkxOnyI6F3enmOXp2bd1/SWgN/wXL24gk86z8E1P6YOKxpRIo4bK+Ay3rKaCyZZ74t6Fgaulo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HiNiin/d; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777900304; x=1809436304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GKx0v6ghzyiiyKL1b2aF4rlj7Oe/hjegscBz35C44sc=;
  b=HiNiin/d03MTnB4f8gLFPftIjvbU3IrQcVL4COJJS970IhO1evy7QC73
   Fqu15NPe+1cHdqrXWei8+iFRqQIwe6byOUcm1PpdROJJFq7O84L1hGye9
   FHqs31j8uC61HpydD83hU1I2OdmFMj02Xy4jA/x+9M9WQe3O4NPz//wc+
   SlhC6hJIaZroJfhGW5SH1he60OVYDLnRejpWuoQiwZcKqIc8dih+QlSHj
   BLYhCHyvZolsp7EoxENw+h8FHW9cxH401OWKPf+DDyOsdHenLgqsEsamE
   L8d/1ZxLubNDcQ2encg00AryLeoOi04x4BjYnxYQl6SUhZIPX31Q7hU1U
   A==;
X-CSE-ConnectionGUID: Gz5wJjCrT8WJ9MF4k852DQ==
X-CSE-MsgGUID: W35S2AhBRqaEnW9fZnz4mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82366555"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82366555"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:11:43 -0700
X-CSE-ConnectionGUID: xnWSFZqeRYSUpg1FXLNh1Q==
X-CSE-MsgGUID: 06oFl7Y4TU2iJ1RSNBm8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234652069"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 06:11:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 06:11:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 06:11:43 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 06:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4yysZQG95rocaiy9DaD6gK2z9mdR2t9BPGr3rTucXRBCtvED/sjgOiCi4m554I598dmYYMHj1o1Aa9IMfOelQ3UeRlSOSabL4ZAPEo9XZ7fjYiCnOECLgmwFyYu0w8rnUaqe7ETIka6/omaTHwvxw8luNxa4/d1xvhZnXUOveJWj0pAryD4ucLGA0tMRTmE94sa49uWQ4warQ1gVIX4bHL63Cxr/LgAYOb853Gcam+qJzbfqfqdt2mOF3mEgA1EdpDIAP81NTtQsuFmXQWCBmxad5f6AtVXLTvZazMSCMJRcBwUrT7WmLhYbASRB6eyGs2i9ceNBv1sn2maHbyXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of6Fiaf/IpKk3XwG069heysr6eP3/97tbHcdfL1nUz8=;
 b=gol8DFBw6MzJjGvapmtS70C96zDa8rfh1rIb8KlvAp2D3fXeNMwlA7sSF92tzB1P1AJcOZBsMq6cr+niA3bk6ECWbSKjr6Ti/Uqrl/97zmFHTT//8xyVZ4X0z4iIm3gQXhBDUSY0Zz+wj43Rm7YufOci89WIZOTsIrJlxnJw40uhRWSgsO6rB4bOVcnpHq7kwjAgf0qEr0ZVIcsQdo3OrCSt4dTWKl9YMTu/F224lL0BrdwYpmCKKV2BP1xq9XgN+IAuvHASlNkBAzwJLCykPCP+sAAKSmwFRFRzqp72oKm8HkoO/Omojii+AirUCEd34kpn6NHTOadaFrgQGMVnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL3PR11MB6315.namprd11.prod.outlook.com (2603:10b6:208:3b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:11:06 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:11:05 +0000
Message-ID: <3bce6411-6d65-4f4d-b5db-53fffbb0b77d@intel.com>
Date: Mon, 4 May 2026 15:09:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix stats array overflow when VF requests more
 queues
To: Michal Schmidt <mschmidt@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Petr Oros
	<poros@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260427151827.43342-1-mschmidt@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260427151827.43342-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL3PR11MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: be91d9e4-8649-41f1-dc5d-08dea9de9917
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YlD6bht/uLnfWac9JCYPB/vLA+JCx8pWdu+9lRDRXoIFpJq0S4JefOxbqXQPGT05IV2cjuWcP4XIt0SDvnF1pEUlC3hqc8foihKvm73pukp9kBvXvbQGQHj+MBWIAzxPh/dt3s5ZljwBYbhxH9E0qd2scznVMQzutr7j3+z/GjMWSeVSdxI1eUwNcFAjkC/PHXEJVcV3VCR8Ir6POE5ed5wcI/V5GHedQdS+AegBLMPx3I6/SDUMxmNsZ1iDmDNNAp3HmIF7l4I2De6vuQto1DwL7ZR9Xtsj+WTUEOKVOf6wyK1cSz/T9tgn+NSZQ2nZT9xCj053jFzkrSH6vh0irt7fpOK8dQeHG22KWzGFA+4nAtz8fq/oib6d6Wi7lR/gZQpiormhPSO0jI/RcX7M0U55fLRtbFUt8EgSMS4HM3Z2ByKWLzoJoE3U7VNrLZ7JWzj/dBtmiiJCFgnLFrwmLaNQ4s43J3lwU+OxjB2vxvm57eD8qcR6EJ4t01xSQREOyd7HmdtMy4T5iiPF0FMcQQdNnq94wMZdooPvofF9HC7b8mu6+9DnXUQYc4Nlk0AtJ8aXvmgJh3FqkDuRlacFa2uFPZKDgVSNEeEmBNlrYt9zJ6qL8OlonI6nZeyDLj2NU5/y8H+UKAGrzL26lU5Uko4Z5PS5QtH/hMyZowMgAaw6mvCBQF23Ar0F/FwBXrOw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFMTGhSL3cxR0JkQXFxQUVvaGhwWWxnRkhLRjRFR0VjenlzQWUwMGhNcEdY?=
 =?utf-8?B?cjhmV1dMaGsyRUZwQXFTZXBVTEpHbVoxakZVZDBOLzZQSXk0SVo2Y29WLzRK?=
 =?utf-8?B?WXlxYXBEbkJrclYvVERLM2tjTHpoalEwUmpJSmt3R2pRb0hvZHprVHZEMllo?=
 =?utf-8?B?MVlFRWcvSVJOU3g4WXYzeUNOMm0vbG42MXVqRnFVOWUycXF5SHZnbjMzaVpT?=
 =?utf-8?B?UGxTR3lGODU4eStuYnkxN2w5djNqRXZzYWhUUmJQTHZJSmdyMUFGTHhCbDhM?=
 =?utf-8?B?MGlIUXhMbzBxL2FrcENybDk2Vy9CNXQremZMNGRqdG1JQTZXK1R2VTJjUjJH?=
 =?utf-8?B?N1llOFlQaXlQcTBodjU3OURDY2hrem9HUkNGaGpLZ29VTXQ4SkJ4NSswNUZV?=
 =?utf-8?B?Rzk4VnM3WXEvY20yQjU4S3RRSVZlL1BrN2I2Z2R5Lzg5bHFHczdMNm5uYkpB?=
 =?utf-8?B?cUVEaWY5aC8xNHg5bnViY3hUSVBJT1YxczlVK3hYbVo5alp3Tmh5ZzNsQVlR?=
 =?utf-8?B?bWtScVhoL1c2TXpKWUtLSktPRGRqVnBNS3NNcG1GZk80UENNTjdNM0hEVUFL?=
 =?utf-8?B?TTB2K0ZWUFEzU1BvQ01LRXFwUzcyaG1wUXl3Sm5jWUM5SERrRG1uMmY2ay9W?=
 =?utf-8?B?R0V6ZHdGS2QyMGpvTlFZclZ0U1BtNGY3MnhyS1RYdjVkUnJ2eXRPRlczT2tm?=
 =?utf-8?B?UjJ1Mk11MXAvVWF3NHZMWHdtQ09VcE1tNjdYd3JkODhDeEZNcDk0ZjhtLzFW?=
 =?utf-8?B?MjBkaWlMdE9PRitYN3lKZ1VmbnJKRE42TVZxd3NhSWd6S2dMMDhLTys1djk2?=
 =?utf-8?B?SHU1UHlEUC9vVHJtRVY1cVFLemhvZWg1ZjZKQzR5MXlQWlZ3ZFZjN25mdzVY?=
 =?utf-8?B?VDdkWXpXdGkycDJwbit0Rnp0QnUrT0FUek01TjBLVVVMT01oa2ZDR29SUVR5?=
 =?utf-8?B?b1VKbGFqazROcG5GblJuTDduTVByN3pIV29tMmVxOVFkV01Ua2pzSm92aEhB?=
 =?utf-8?B?VWZHVHZwL0ZuL3EyY0hTR1hSeTFIN3RwR1ZKdWQrR295SDVEV2tCWVBNZHh3?=
 =?utf-8?B?T3lSak9tMi9KY3R5WndoU0VWRXROUlFyR013UFJEbFpFeTd6K3RWWjVrcXkw?=
 =?utf-8?B?czVpbUZlZExlYVdQZWpadkcxMlNDUjl2ME5pZ3plbzJFWENiT3M2cEJwaUlM?=
 =?utf-8?B?Yk54VUV1N2pNbTVUM2xwNWcrOUIrTVBxTkpTaDI3b1NocytIU1BuYzF5UlJ4?=
 =?utf-8?B?VDRWS3l0c0FmZGpvY3d1S1dZdUdtaG1BRHFHMlhEMTR3SjJ5NFgxcnZQV0Nh?=
 =?utf-8?B?VGgxRFNGMmpCcE9JclFGRFpKbmZETUg1WE5EYnZaanR5RGYwNDJIY0dWNDZF?=
 =?utf-8?B?NHdad2FlOGxJK1Z1Vjd0WlVpSWJESExpWHA2V2NjLytucm5obzBrbHBVdUFv?=
 =?utf-8?B?UVNjUWc0Zk5mZW1jODZ4R2RtWFd6dmxKWEx5MjloUHFZZjFTM1FjL25JREg3?=
 =?utf-8?B?ZGdLQkZmZFVLUFE3N1dhY2hPSXpTQUMzRGthRnoxUnh3QlhOM0dTcUNPU0xU?=
 =?utf-8?B?cFN0QkNRbVFIZnBIS2diWlJRUXVGSTJkcXc4UjJoNm5WZEtuUi82ZWxQTVF2?=
 =?utf-8?B?T3dHaGJuOXR3N09GZlFVQzlMdTNocTFuK0pldS9OczBPemF6L2FRd2NjUlF0?=
 =?utf-8?B?Um9pMmM1R080bng2WTFwaDdUakduK0hld0laZGJyRHRmWlJrZW1IRTAzR2Fl?=
 =?utf-8?B?cnJNQW5PY1VqV2IrT0RWVktBMkJOUCtGTzBQVHlPd0dnSUtEcGZNUzAvb1Rj?=
 =?utf-8?B?Y1JYdWxTVGJ5eVQwMmo2bXM1cjdWWVRHcUZ1TFo4dzZUdHBuL2pGQnBuTVM5?=
 =?utf-8?B?NHRuRk84eUVjU0VmdGJsTzF1OXo3RXF4Q28yRWdrMW1QSnliKzRRM1VFWXpK?=
 =?utf-8?B?THFvSmtYeFhWYzUrdnNWTER1c2pqclpyMW5yNTBDZGtTRFFoQndTRHZOK0t5?=
 =?utf-8?B?bnJUNDdPRzhEeDhYU2htL3dYUGpnWWF0ZTBybG1wSGZoWFBycnpMT1BzbTJQ?=
 =?utf-8?B?S0x1Z3p6MXJiVWY5QllCeFk2TkUwa1ltTGtOUm5PeFcwQmMvU2ZiTTFpekhZ?=
 =?utf-8?B?QWNCMWtyK2Jja2ptdmRYRFBWNUxXTk5ZY2ZQUjFocFFyT1o0VGZWSW5FdnVD?=
 =?utf-8?B?T29BSE05TWdabG9WaTcxSnNJaHUwQnp1a01Oc0lRaE9jWFptRnVOamkzaTlQ?=
 =?utf-8?B?a1NCU0NWeVhxOFhCSTVMWXZwdmszTnZNQkFIaHZSa1RsOHdoMGtOOFEzL0Q3?=
 =?utf-8?B?R3B0ck84Qmthdm9GN3FQQ3FCMHJ6UEV6RlFDdGxBYWs5bytBTHJtanpHNGQ0?=
 =?utf-8?Q?ccjjeuW40KDjPO1o=3D?=
X-Exchange-RoutingPolicyChecked: a+fXiFOqsEaCE90G1zZYcbn+D1XoHC8jjOsLZjfnMzHaW3VOig0l1IhUbC3TY6ZScUBqtugmsrLuEUZZ9BBXhRAIZQc85yaNR0DPjB6NsjWQNlxbdSd/rWXpNxPhCcXc8UkBz3CUiqMs5plxFKSiQvD8VXj152wfczhUrsbidMB35gJbtSISjZ01JtqKAw2cnjXDTR+JLThgj23/w9ve1Qhjz7yBLSoFaRXfEWgJ00jbURWmbvzUh3d0c7yKrxkgnzLJdu2mngRgYQtX6rJXXhChOIjLEqe2Loc160lfRru9mJX0dqgp6yGcWwYL8sSZ089BuesameNpy2XxBNCXpw==
X-MS-Exchange-CrossTenant-Network-Message-Id: be91d9e4-8649-41f1-dc5d-08dea9de9917
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:11:05.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47MDRRNazBwvto6al72fUkUMg2inYY+94or/Q25kCtT6mwes2XatiCcN/UGFEvbZuDFdzHQ49LBkSBkNfZ3dDNwyErSJG/Q1Ny1OX1RW7nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6315
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: C3E724BDBB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-283848-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,atlassian.net:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/27/26 17:18, Michal Schmidt wrote:
> When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
> ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
> The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
> followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
> stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
> alloc_txq/alloc_rxq to the new larger value, but
> ice_vsi_alloc_stat_arrays() returns early because the stats already
> exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
> alloc_txq and writes beyond the bounds of the old, smaller
> tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
> metadata.
> 
> KASAN detects the bug:

[...]

> 
> ice_vsi_rebuild() handles this correctly by calling
> ice_vsi_realloc_stat_arrays() before reconfiguration, but
> ice_vf_reconfig_vsi() was missing this call.
> 
> Fix by calling ice_vsi_realloc_stat_arrays() in ice_vf_reconfig_vsi()
> before ice_vsi_decfg(), mirroring the ice_vsi_rebuild() pattern. Set
> vsi->req_txq/req_rxq from vf->num_req_qs so the realloc function knows
> the target array size.
> 
> See the linked RHEL Jira item for a reproducer.
> 
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

I have an unpublished fix for the same issue,
but your patch is smaller, and thus more suitable for net-

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

thank you

> Assisted-by: Claude:claude-opus-4-6 semcode
> ---
>   drivers/net/ethernet/intel/ice/ice_lib.c    | 2 +-
>   drivers/net/ethernet/intel/ice/ice_lib.h    | 1 +
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 837b71b7b2b7..fc78176a2a8d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3015,7 +3015,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
>    * ice_vsi_realloc_stat_arrays - Frees unused stat structures or alloc new ones
>    * @vsi: VSI pointer
>    */
> -static int
> +int
>   ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
>   {
>   	u16 req_txq = vsi->req_txq ? vsi->req_txq : vsi->alloc_txq;
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 49454d98dcfe..6f7da84384e5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -66,6 +66,7 @@ int ice_ena_vsi(struct ice_vsi *vsi, bool locked);
>   void ice_vsi_decfg(struct ice_vsi *vsi);
>   void ice_dis_vsi(struct ice_vsi *vsi, bool locked);
>   
> +int ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi);
>   int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags);
>   int ice_vsi_cfg(struct ice_vsi *vsi);
>   struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf);
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index 772f6b07340d..9edb2c14f553 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -268,6 +268,13 @@ static int ice_vf_reconfig_vsi(struct ice_vf *vf)
>   
>   	vsi->flags = ICE_VSI_FLAG_NO_INIT;
>   
> +	vsi->req_txq = vf->num_req_qs;
> +	vsi->req_rxq = vf->num_req_qs;
> +
> +	err = ice_vsi_realloc_stat_arrays(vsi);
> +	if (err)
> +		return err;
> +
>   	ice_vsi_decfg(vsi);
>   	ice_fltr_remove_all(vsi);
>   


