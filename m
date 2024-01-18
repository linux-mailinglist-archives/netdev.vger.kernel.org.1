Return-Path: <netdev+bounces-64199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE8831B64
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5E1B2147B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81200375;
	Thu, 18 Jan 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmO5ZN3h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267C370
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588434; cv=fail; b=P4IVc1G9YhKuHKa7ru38JfuKKzWapPk7CORdNIKrqVgVxXZztqaCc8lj9qqZEjkB6HB2PV8Yn/PhA6CZGQMVQQMjML6xmn+cbVKACitPGTx0VpJx2NolQL0b2pRnCj7a443G2Cvzm/VB8oHRu2nTXzswt1Xjf8S5bbGj7KnjAXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588434; c=relaxed/simple;
	bh=uIqfXBJXZ6pJHeOpwO37weDDuAYLMPOSiy7oRMiH96c=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=csOPQrcEm2vFc4/90FD3utvSbg2RRXI+uyUn1JyycnZjKo6myH3Xwtmza40X+tUinIYKmaKcJ+GgUnUCBIdpxgIXb+6p7DTD33w/EeuVtUX9XxRETUVoK+p3IpEEi525BkYBHJw8alT2hI0lj80jZIZC7ms3v1YRBKVV4H6zM7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmO5ZN3h; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705588431; x=1737124431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uIqfXBJXZ6pJHeOpwO37weDDuAYLMPOSiy7oRMiH96c=;
  b=HmO5ZN3hTcdA9jsiyJA+iLEI9zrcdNGJ43zr1XDPu+LaObbzv+PJk+Nm
   yMeU15sxwv+sb3+f/2QdL8uamsHhYzPSxm61rDAzkcSD0n8Q1aym6ThIt
   IfLpU5Mmd810aVyAn6H6yxJjh/4wMtoa0KXXIVdXPd/+zBr1MmjHuemDv
   0FjYophC7IP9cX/vYyph0+gw6KO/mLe3f2T6Fft85dsnYiR5oP+SoKs0t
   G2JKtnROufiSe4/SMWQkvIVnCtg447lMkPagiJTqBm+kA+oABjl5+m2+P
   RznJQtb7/UvllPBDeVX8vlybGt/cZR53wFNqKEXOJWcbOdU/V1Pk9qOL8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="353320"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="353320"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 06:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="760877490"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="760877490"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 06:33:51 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 06:33:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 06:33:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 06:33:49 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 06:33:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMtIyfFatVSiPi0eW6wGVYw9xHsRsB90HRXxK2HEupksM7XbxHiXEuNS2AH2SRAcZpGX1GCxKJbvJ/oARGaCWbE55ZJOLelbM1Y+SdPpt+6YqxUylENzi/POhDqvwxJCju2VxeTcpL0roVjuTA+TcYkWcbpAh7IraJCIRIx2wt3B/XNXp9cclclftErTorVBgFRyfipAkZsK/HH6wZmJLzsCWqZZDMV+Z6h9WBZ4TMNrjdJsNYFMHfKqbXtu0i318258/tD/tqWZNzFicGm8ME0rnmiLxQNe7aTQKrnloWh0Av2tyNNpTmzmxSo9ih9PlPN88W1nDs0NLyB1rUiT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P36DuwbJoenK94gB6lvdrQpc7VJF4F4bPz4b39m/r4=;
 b=ZFPb1Xx9GnXJqdtFT+lA1NvLncANJD8isPuyLaHb0tZqY0zu8fCXY9rz00ODx5LnBtkFJQ0HVc8Ek0Lg/pLmp5fq7PJ3bt3SiLd+H3GLM3Q8ukJxJklBNochggN41Lo84O0Kq93+SUYzlFvUJ50ZW4HsdukqY7Fn56Rsz3rCjXn1CKsJYi56VDdEtIPe/9VbCXEYkrfMj7VfgElRu/99j7sHPSXzyTJXU/XnIgPsphzOxiVFtGssGB7MM6DF/d4MKk03rmPmnKF6Ny3tsTakkRkvftF9Arcf4l72lceCfeaoCZRlUPhngwELFn+U6hbD/YrfS93aVNqYhaGStNZj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB6868.namprd11.prod.outlook.com (2603:10b6:930:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:33:43 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:33:43 +0000
Message-ID: <b88cb347-9133-42f2-b41c-62f53666c488@intel.com>
Date: Thu, 18 Jan 2024 15:33:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
Content-Language: en-US
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-3-jedrzej.jagielski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240118134332.470907-3-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1099c5ef-43be-44ad-c5a8-08dc183278e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4M8wF/vvspxUsIEVD268MP7bP9T0PFWIopVvSqaYHrcF3aa9Ucv4NJUgbb+DTqyhsgSlyMg7cmtTKRQfkyUHED8v8pbqiI9a4ILw3lSXucim5O/az0ROAJ50ndzsYyMn5RchXrMBtOgx8Xm+HOyuAbv8ttrFPlSbcjZJlBjdtgXZy1w8DfRguRp//YpnxEzonOktzDT6xivcBk4KmdUaKat1/cHbCYvMCJAMfWsJGhm7TGpCzzuiXXxghTnh3PiRG8MrTGKNO8NFvbqxvhMhgPMl0HBHSxnpqPJ0xR2efIIbe0t0x5nZLZYal7eDcsyEDZewUZPfvyKuSbM9AkcXQn/tf+5zGdP4gy8Ulh68O5XviyvnJfHIKGOhAqBBR/Wo2pqZPqBca5/v5N/gkorLPE/x/i6NjOKAajDrF/x4M6iYzG4hwrXteSs1KvczmJMiKfzleTDOks85igPHCOAyl2nSoBVJCbMIzKoY3cQk0bk/rTxMOu4l2BUzquU+hluwSVauPQuw2BFQW6nT573lwzVorQyiSxA1lMprIoALwGtFdnBBL1As4Ifykj487DdPRHSRYmg/5Zfw0l6U3IjHwWRLRw2RKN2vMpwsZHqqj2myMwPWei4QHduy4LIjAtv6ITONz/Ee5Hq6VTCDx1WCvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(8936002)(8676002)(38100700002)(82960400001)(36756003)(2906002)(86362001)(31696002)(41300700001)(4744005)(5660300002)(53546011)(6506007)(26005)(6486002)(478600001)(6666004)(83380400001)(2616005)(66946007)(66476007)(66556008)(316002)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FPYUFveU5pS2puZVErZk5rWVhpY0RjakkvU1VsZ3ppbHJRVFQwMm1ycmpa?=
 =?utf-8?B?blVKcGZILytDTzhOWGRwUklEZEJBTXBQWCtkdkxBeHJFak44UVhVcThnMElr?=
 =?utf-8?B?TDh2QW5yN2ZEaGxiWlpWUWFCa2IvalRicUhCWXhwR3BDVTMxVHcyamYxeWhV?=
 =?utf-8?B?NitybmpQcnpOdHYzVjdsR0dzVGNqakR2SGRSMUFaWjFXQ0lGMEl4eXZvb2Jv?=
 =?utf-8?B?eWVlREVhZXVKaUFRWThPTU12NDllZDdrR1p6eld5U3IwQmMwcjFGdVpNaUQw?=
 =?utf-8?B?R2ZIZzl2eVJUeFJoQ3RORjUrZ2NQS252OTlNcXpqOWNEYUhXQzFvSjErN1Bu?=
 =?utf-8?B?VDZzVzlJZ3Z4a1FxbHMyTHNSa0kydXVQYzFLalFkbjQ5d01sazV1Yk5ZTUZv?=
 =?utf-8?B?aGpwVUZGbGxtUk45alJVLzVISGlTNUQ2U2VJVmFEekYrbExFZ05ZdHdpNGhj?=
 =?utf-8?B?MElrWnRSSUtKbTZQMTQxVFJGTWtMSnkycllRUHpFMTNLbk16dWpUbWxLdmV5?=
 =?utf-8?B?c3gxdkdVMXJwbHBMVys3YzBIL0Z2Vk80TWFHTnJPY1RRU3JJUFpubDZVbG55?=
 =?utf-8?B?SUlOODI0L2JPZHZkQlhQYytVR1BrOTBpUTJnSGVoZ29MdVhod21mR1RyMC85?=
 =?utf-8?B?NFozd0lWbmNZQkpvTVBveW1ibmp6dU1IekFNV0NoS254QnJtZncwZHA3TjJE?=
 =?utf-8?B?Ukxlckc3d2RkQWpwR0loUjBLWmhvRXRQejRyNzEvb3pEY1VpQkRpaU1jV2Ns?=
 =?utf-8?B?cmJyS01HWmVNeGZ3WG1kc0NQaHU1bzcwaDhxUG1MQjhWRy9SSDJYYno2bVlX?=
 =?utf-8?B?Qnd3SFJaWGhhSWNtU2JmUlUzVHI2Nk9UQUQ5Q2dRZDk5RWlXNlRXeDRxajBS?=
 =?utf-8?B?bjJwa0lzOHEva2V5NkNaWUNwMkxHM3NNZUJhKzBsYm05VFM4ZnJwVVUvOEkw?=
 =?utf-8?B?bTh3ZCtkeVlXQkZlMXUwUUlpYmxMU1RPTVd6QXhYQmcyZDNmQUZDVzc5dU9x?=
 =?utf-8?B?Vy9hNTgxNUZKODlJTndRczFlNUlycUhTOTVFUzZTZ3JzN1ZSV1JGZ1lhdk91?=
 =?utf-8?B?L01iWUc0bXBRaVRmZTgvUE1MVFp3V2o2UERzSXlISEYvNnpOYUNwM1B6QjY4?=
 =?utf-8?B?YndTckRGT2c3REtDVkpOOE1aWUJBNTVYa2I1aE5aNkxjbEFidVJTOHhCYWMv?=
 =?utf-8?B?cmJ1UG5FVFB2SXlZWlROV0JyOVhtdGVpd2FUUFovQzNaSkgxQ0gyQy9OejFj?=
 =?utf-8?B?aDNRaHJBN1dHNFd3ZHVkTjBTakNCeFp3WjlyQ0l2b0ROZHZLOHNVdDMzeHpu?=
 =?utf-8?B?WXhUaEZmay9MRGk2ZkE5Z3R6WjBzbml1V1hTL0htc0NDRlpheG8rdzBNeFJC?=
 =?utf-8?B?Y1ppclBsN1FWTnd3cGhZSjRmL2VQZXkzSU1oblc0SkJSSGRxR3JuUnZ2NUFx?=
 =?utf-8?B?eWJzTHFzNjFsRlV0d1dtbmMxaVl6NEdHSWtTQllKaktEeXAxcTRKbHcya3BX?=
 =?utf-8?B?b1k2L201c1JublRKTk1kbk02S3dlRVRHc1ZtMWpSeFZWK3pYTkd6UGEzRHNG?=
 =?utf-8?B?SUFrc3RZYUI0dnA3ZVRRZFJLTFc4VXdBZjBCZmdyeVhiOGo5TGFzOGJwOEJs?=
 =?utf-8?B?a2Z0RWZtZFludEdIcnBYcGYwUkY2OXl3UWhwMEhUNHFDQnhuaGpXTFZYWmRW?=
 =?utf-8?B?T0RTbFloZ1RVVmlRSytVQ09qdGIxWmhVazlUaHdaWEV3L2duUmk5V1lCbVZ4?=
 =?utf-8?B?d01ZNXZhbmsxekJzODRCcU54MWhDRXQ3Ry81cTJLQWNuZDVIM2k2WVRpQWlX?=
 =?utf-8?B?ZzJIajNkUzRVNFFydTVCdGh0UHBpTU5uN0FLMnk4ZG10elhYOEwxUjhwd0kw?=
 =?utf-8?B?UDBzLzZUZklmV1NpTjkwUllzZ29lcGRFbEJQUks2czcvRFF6RHRjZ1d1STRD?=
 =?utf-8?B?SGtzQU0wRytwQWNaTjRXdDc1b2dWWjVGUlZ0ZEZQend2Kzk2ZWdvM1o2YmJw?=
 =?utf-8?B?N0MxVmZhM0t4ZkZ3MmlFYmx5WUcwUWlRNWJBWGtTYVptdkZySC91QkhScko1?=
 =?utf-8?B?YWxyT3RkWUV4ZWMyL2QzR21nOERYZ2doTThWbTdBM2w2UnFaTjdPeDhpOVJY?=
 =?utf-8?B?a056YkRCMndVeGNxckJnekJ4QXpxei9LZHpkQjhIVHNxNkF1ZmNFMFZKNkFl?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1099c5ef-43be-44ad-c5a8-08dc183278e7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:33:43.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNfzGBQnTlaOw83stXmIZHSmUzBfb2VPwgD9XvyZwJ2vy66edGigCCqLAyAOvyHrHfH8lJkw2vhscwLbUOBcYtYQufxyWCtvUA84S+mUp5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6868
X-OriginatorOrg: intel.com

On 1/18/24 14:43, Jedrzej Jagielski wrote:
> Clean up code where touched during type convertion by the patch
> 8035560dbfaf. Rearrange to fix reverse Christmas tree
I don't see this SHA in my copy, please fix it.

> 
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   .../net/ethernet/intel/ixgbe/ixgbe_82598.c    | 14 ++--
>   .../net/ethernet/intel/ixgbe/ixgbe_82599.c    | 40 +++++------
>   .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 66 +++++++++----------
>   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 54 +++++++--------
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 12 ++--
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 50 +++++++-------
>   7 files changed, 119 insertions(+), 119 deletions(-)
> 

code changes are fine,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

