Return-Path: <netdev+bounces-66732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF6B8406BE
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD76A28C781
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1962A05;
	Mon, 29 Jan 2024 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9FeGSUb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8762A02
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534650; cv=fail; b=ZJ+A7wGTtYJmOR0fh5dR/2TypBpcpWnfwbp2k9i/CC4D1IrckfC1BXe+3Jpm+pnmVg9a2c95lhpgJFLK0IlHWWu1JM8+S4mTpxOPV4pPtjjAeoxihD6U2A18frn19y1ZUUrce25k+Gt6WFslBPAVxPoIqHgVgpBaMo+TEcFZww4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534650; c=relaxed/simple;
	bh=cWUei4Yf/fJ2EqR+07cNVP+qSDrBX832gAsViuHR/bg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUhnJTBGx27rMzd+mkr4fwsgiiCidl9kewoH3qkGph28SRGlKrYsQT09jwHEQJRTMAloRwHhOulnji1ogc1i0ixVU8+jkCvTiSQufFzNv60AczwiMvVpVxEeaMe0zvPifI/9REz88N0Y2IFoYRbG1fKq7rkWjOBvcx0DjqXpW+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9FeGSUb; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706534649; x=1738070649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWUei4Yf/fJ2EqR+07cNVP+qSDrBX832gAsViuHR/bg=;
  b=L9FeGSUbbbeY0SESQYhXA25tOI1Nn9J974COIGZ78rRr5x52O2jWEruC
   84YOtXtb916jPNSk7REoej5tS/YuP60CFWATf5s2RcUg5NYhcaw7zjs73
   MSWF2iTMexQUUmRBx/Q1ryi505o6lg2AkI/okCsnfXi8NCKb9VwbHS4hp
   sJUIIV2bnS9UXjXplk/k+OVfyG6Q65QQ6aoyLHgmgmfjAVKjw4YJn0p9N
   YLuVViRVa2i5cjmF5BUDTBPrq+OQdh0VDZEelnEDJGMOBzgm9biFuuOOT
   1uF/rPQWFiIvFEnbb8xPa80LpiLgT655Dz/5IkfhvVYIa4urf5vXUScrk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10330357"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10330357"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:24:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="858093536"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="858093536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 05:24:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 05:24:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 05:24:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 05:24:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VELOEPk1hEHWWYXOr9LY4NcykdByd69bqwTKl5mutMVcUtXpGe2pWrjsQuwkrpejBbmgEEBdkBswk1FgWeTooATkNo7YPIMG8hjUEgcsmoa6l+Nq3F1VARpK+3LjJi14hFlFe73rYysBKfgaVBU6PiBYEKKrY5Q2KaRqvVystNqV2olQG/Ekk1u7vubPjP0v7xCuNk/zx7fiGnXiExuakrQA0qfCAhOTabPkrdKp+/taysT7Du6vZWctI0eE8cnTn6XeTbBaPpO4VLbV2u+94oSJVRUQYrz8J0V0j0EeZfI9bicjwjtWAvBtFG3EIcrMl4byvtpwYxEd9BdzxC1sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz1JoZAH91KFu5TgIHZ29oERPgPi6SCC4HjwCyvVspM=;
 b=FtKZtnF8BSC/pk5QEjQ+V6y0SLZJ6vknCQ4EvxmWkC22Dbwi8fkAUkat9Woe4aR9WF/HkRigAlPdilGVMR6NenOtapB4ZztiPPW3KdpCs3ynPbBxLs9mPIY2BoUSmKma+CCncrfC8ofYlriWC6QOheyiir97p/FtV2Vw/kX7YaAmGrlWH9n00ApT/G0frsnml3DzZljiFURlgGhSm08YFrc0R1O3O4eEm9/q44d6WkZJmd3dgJrY72Ck6ZqEcUkspe6BUhLxPT1OdREJqWgE4/MQwQ4JAD5eAv+7iTy+/PiKXGsApJBc+lUC/qnlF751L4rxZHX9xx1ChgUMIj10sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 13:24:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:24:04 +0000
Message-ID: <41774365-e247-4e32-9e96-d256acfcc129@intel.com>
Date: Mon, 29 Jan 2024 14:23:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 0/7 iwl-next] idpf: refactor virtchnl
 messages
Content-Language: en-US
To: Alan Brady <alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <igor.bagnucki@intel.com>,
	<przemyslaw.kitszel@intel.com>
References: <20240126054747.960172-1-alan.brady@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240126054747.960172-1-alan.brady@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:208:23e::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV8PR11MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b3a76f-5fe2-4e44-baf4-08dc20cd9051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIQgBZZvn8LTp3Ffw8sauufjKLWAuuUuaHIjJq0Xr16Mt+oHvXLvwLXjEGPyMA2yy9Ik7RabLyIXHaWsy0eWoleIlipbIj3JnzQx63x/ZxxugDsCvxmyxL5hdIsvEmA0+gRm7ql8N+WW/26bFjxXH+nxcmg1rb/KkFXXqS/srP7TqNs5uYMEnolo9zLla+Z7XC1URVSg929NRmKGcBSTuC6BVkemvt7Pyyx0dYAeisQL7HBC/mipbqNDYMbMC+qHYXzqD+1+6KF04QCyp0UTqz4ncWzDctmMor5UetzMAHbB+IE4m/LnNE9dIyfJdqUwH8MQfwZ8lCYONu2ZKtm0WghxIsDIDu6/UOkpm9J3Bt7OX7f3BRfByveHE4PhH79hdTHYsnKymjMa269nfAvzlHqKRz15wDOlpykr9woGnoV+2Cais9Id8UrMzymTr0TqWIjFm0cxQrDk5RNG+WX9gR/IR8MY5PZDiNdQnUb6nrV3ZVgwumMdao5gMbcG1vNj1hcfj2z/wGCgqv+RXgDvBeWGTowK6MufZ2uj9g0vhn0V/O1AIbooQk69ohWQYZRfRnSAkWLHPeKHdmrBklw+Iv2325QjN4xFkBtXmZNsRD6BDUenxfhSeskQSqOgGc6F56/+ZkD+qvbQX+c275x7NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(82960400001)(31686004)(38100700002)(6506007)(86362001)(66556008)(37006003)(316002)(6636002)(66946007)(66476007)(6486002)(8676002)(8936002)(2616005)(5660300002)(6512007)(15650500001)(26005)(6862004)(478600001)(6666004)(2906002)(107886003)(4326008)(31696002)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lnODhKUllYOFhDZ2MrR28ybmdnTXY0ZjhxeHZqOGNvYnZNTmVqNTBGTkE3?=
 =?utf-8?B?eEs1OVR6L2RFZ0hiVWREaTB2RkQ0YUFJVnlQQ2JLclhKeThkeVM5NEZxWXA0?=
 =?utf-8?B?U2pjS25pbFVLRUtzd1M1ei9sWDM0aFYrQzRONkVMSDVLUnNoVWJ5S3RrMjNj?=
 =?utf-8?B?Z3Rmb1NiZUdJT3Azb200cHVRYmM3aHFWU0p6RlV0WkJHWkdQTGpGOHRTakpN?=
 =?utf-8?B?N0FTRml0azg2VTJia3M4di9vRWl6cDZUeXc2LzMyTXNrQVk2NzQyTzAxYldh?=
 =?utf-8?B?VmRweGNNc0hXblhXUjl6RE03Q0VVTVBlTHVUZ0pXK0d3dUc1UVRxdk1OV2pQ?=
 =?utf-8?B?ODBmR2VES2laTkZpbjYwZDRiQTdFRGhMMlV4S05NRFQ4dGozU1FmTksvT0w3?=
 =?utf-8?B?S0JWOFJIUzVKSFBqUnJJS3Q3R3VrYm9FOVMrdHJEQlBKd0RrR0tVUTQxMTJs?=
 =?utf-8?B?RHYrWnFPdUZLMVNYb1J3THFhR2ZIV2VsdUxpOUJvL21obmMvUmphOWl4SWhx?=
 =?utf-8?B?VC81REI1akJxRXY3cWNPNVFhTEdOcGtHTnFKNmc5SEJtaHo3c04zOGg3eXBQ?=
 =?utf-8?B?ZFRja0FZMWdxTkx3dnN6L0ttd1VNemZVNkFGN3A5SElDZkF1dGZTczNXR2Nu?=
 =?utf-8?B?dTI4Z2hBSHFsZjBCUUpYU1ZmcktHR095UTZrMC92L2lFVWJxdjd3TDZESGRJ?=
 =?utf-8?B?aVpRT29vVXZHanovbWNMOXMvSjlhRUtMcTF0eVI5L0QvTjN3aUVoQVlUdUNm?=
 =?utf-8?B?Y1NpMmJhYUxiUEY0WktORlkzbWhPOE1hbkhXZVljNVdaNU1SSmNlVnJZSkEx?=
 =?utf-8?B?Z0Vyczg5YTI1bFh3REJGUmN2TnA2MklaQkhaTTRvVmpROWFYTEZ1OWxmOGEv?=
 =?utf-8?B?QU9oak5SeVlGRDM5Mm56ajV3Y09IY2wzWjRXemdkL0wrY2tRTWFzdzhOdHRT?=
 =?utf-8?B?d0RZNGluN3cvNzlQdlIwL2cvaVEyVXpEVGpsTDI0a25BMHBHNzk1ZURDSWxQ?=
 =?utf-8?B?ZU5LQ2d2Wms0T28zTXNyNm5lWFl2dnZEbUwzbWRPek1Yd1U2ZlNNL0lyUHEx?=
 =?utf-8?B?VG9KNFpDQUhYbmFJSmp6Mit1bUErZDZqcXZDc3grd1dXZjlMVGRrZHYwSlZM?=
 =?utf-8?B?Mi94aFovNGRLeGhjVHZkTWVqdHNvSmltZE1qTnhGa285TjJ5eWp5a0UxNVA4?=
 =?utf-8?B?U1VrOXJGN1REUEh0Nlg4U2dublJOeGhJTmRlSGhLVmV2OVgxbTUzWXhVSnlX?=
 =?utf-8?B?L1laVDhzbWdiMFE5NXhDaHc4SlV1RVhEdGVkSnA1clYwaTJQVjBYUWhycnlw?=
 =?utf-8?B?bVExZVBQRkVMajROdGFTM3hid0h1SXMveG1HcVJIejlKRWhkc0k1R0poNWVo?=
 =?utf-8?B?OW15N3dkTlI2MmhzRjl0SmxBY0l0WWxkTkV5UWtPRjF5M2xSRmVWMW84TWVw?=
 =?utf-8?B?YldQQzduOXo2em9SYlJaWWVhT2QwSlIzN1M3U0hEUytaVEpsRnNkaEwxTnR6?=
 =?utf-8?B?cU9nbzNTV2c4MmhYUHZOczQyWHlyTmhJVHJMTmNJUEZNQldIbXhQamNyc21O?=
 =?utf-8?B?OGZDUDZVM2ZkRWk4ektYQTk0YnFCNytuS0ZCWThxYUtMVjhaMzVEY0ZkeFpR?=
 =?utf-8?B?VmZVbmlzeWVlRTFiWUduUXIvMVY1Tit0cUNuM2lITEJXZFpoN2cvVUVFWlpR?=
 =?utf-8?B?ZDlnUEgyQ0tmdSsrVkppMzRFRzVvdmM4bmttQjRUeE5mYi9xL0x0MmlhRnlE?=
 =?utf-8?B?RmsrK1d3QUxiS2wvdDVYSW1hSklDS2NGNGV5NmhEVUdZU2YvakVPMmFGY3FJ?=
 =?utf-8?B?MzhYRTMwMkpQY200RTdCOEVsbDRpYkkvKzhRMEtyYjlUUEp1RFpZVnVVb1Qz?=
 =?utf-8?B?T1c1d3RxOVNXc3M3L0FVZTNPYXZIaDUwN2NBYlFwNnhYSDRaZ1JXWSttT2JP?=
 =?utf-8?B?b01sNWVOYUk0b0JiV3I1NzMwM3VqZ3FMNVlIeWZpQ0l5TEFITG9XblNwV2Vi?=
 =?utf-8?B?amF5YWN0UDdDYkZXWlFLRXZVN0NKVkdsVUN3QzJoMW9QUmpqODRiK2xGeHdm?=
 =?utf-8?B?RnJ3WkVqYjJveVVBRXNKSWluRWxxM2pGU1psdnExMTM2OWxacGRaU0lPa3lD?=
 =?utf-8?B?QjNWdXZOeUZDdU83ZTlDY3dFZERlMWFqUWV1VkxFY1lXZTRCRk4zSmVMYnBq?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b3a76f-5fe2-4e44-baf4-08dc20cd9051
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:24:04.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8Q8ETKwWj8X69eIk9WlHexNR0J3ySb9nmLrCanWugTmiW5TzHLDkXH/NZF95ogTvZG7Rq3s1/vYdv1NwlZcbjuo9IPny9Dtd+1YSfgi0qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 25 Jan 2024 21:47:40 -0800

> The motivation for this series has two primary goals. We want to enable
> support of multiple simultaneous messages and make the channel more
> robust. The way it works right now, the driver can only send and receive
> a single message at a time and if something goes really wrong, it can
> lead to data corruption and strange bugs.

[...]

There are a fistful of functions in this series and IDPF's virtchnl code
in general that allocate a memory chunk via kzalloc() family and then
free it at the end of the function, i.e. the lifetime of those buffers
are the lifetime of the function.
Since recently, we have auto-variables in the kernel, so that the pieces
I described could be converted to:

	struct x *ptr __free(kfree) = NULL;

	ptr = kzalloc(sizeof(*x), GPF_KERNEL);

	// some code

	return 0; // kfree() is not needed anymore

err:
	return err; // here as well

That would allow to simplify the code and reduce its size.
I'd like you to convert such functions to use auto-variables.

Thanks,
Olek

