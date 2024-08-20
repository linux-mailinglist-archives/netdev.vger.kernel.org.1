Return-Path: <netdev+bounces-120336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFC958FDB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323411F22855
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB491154C10;
	Tue, 20 Aug 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oc9Zcn9z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985A1C579D
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190195; cv=fail; b=Y/fcrQM8prM+3aCUkM3uJxS24+WfveXfhcEiLsJjGTWAPtWTqln5pTtgmEQyxd6Qle5kP487c8cr17T0UmdFQoSYsoPq/ibGZJ5VF1Ri4UpoAeAa7mX9xB0udMI09h2Bs1rQYmhh1MO7ZQP5sBxpzWg2fh4yVbVoWOd/dqUVz14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190195; c=relaxed/simple;
	bh=d+0z8B4ddpp8m2FiRRoltOOU1O5TwV9/oRcha2EQ+Us=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvrF3CCqjDXfyS8mbN7CNNcAdD4Fzf5EmwSaloWtLT00QDp0LZAka91JrhgJFC+aFF0tcB7lsnkrhd76upBBLOi3dZNcuD/0SroJ/QbYqiFY9fn1PzrdJXpzCQRNLFZaTLGGE4PE3dsR3qykW9Pdik6F9Hk23kLT3D3/4yqElCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oc9Zcn9z; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190194; x=1755726194;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d+0z8B4ddpp8m2FiRRoltOOU1O5TwV9/oRcha2EQ+Us=;
  b=Oc9Zcn9zxg19fkPtijaSn3YmoF1J+x1mewWzFUtGXhRYAeYZ6h+CKcXD
   xGMREorux7FnqAyn5zqT68i8Wbh2wZ7s+gCqLLkxufs8rWtewrknOk0tx
   XKpuQuL32Qw8ROafu6Edcpb3anUpeOb+Zuw/eSWmjE5p5myDNzFXs1KyD
   9A+5u0VsZ9VRw0o9Q/MXkECx7phuFyQdwedtT1nSbhWqKOHHwdYr1TBug
   JgD6xV6vjWYmRDKS+IqP67TvPQTnrJzdsmaWXAb+w5ah12P0cMkiqd+DU
   IX1yB5I6cniskW8uACKAY2QsVJ8n62PZHt2z2rBMVuRR89X6TMrHhkL5P
   Q==;
X-CSE-ConnectionGUID: iDda9jtCRpK5aHVi83XSJQ==
X-CSE-MsgGUID: FqAPgw3dTCCwZGs1i+odYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="25420176"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="25420176"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:43:12 -0700
X-CSE-ConnectionGUID: Hd2hR8wfRqm4/c7J+EW9DA==
X-CSE-MsgGUID: kP+tOAsgQvWZJY6fI8a+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="61188897"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:43:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:43:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:43:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:43:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4Gslf0ENoouL0b8EYXNvQuTA3WZ6JTHxcdyYvVU1BCbrtGECuh40/J8fCevN4Wdn5M6+I4XAKjH0ab+0/pF+cdx6C/T0SXnR2jPMQnEJMDVPyONPwJky9oxCdBuF6Qjg1e+UdFjQw6Meb1u6wNuQDhuk1DvEfolvnMvPARLzaCwN86Pw0ma1fEckPNdv1mXmAJt7br5jDX/xr69mP8eu5cWyY9DHfpXf1LgAnDDUlddhuxzzLOAbKCUE0uMbz8WOrHo7PnAdTw3r4y6BGZ77XoHbql0LJYXz+G8yczhIger93gAHo6xjq/BDjZrw75FVckOQIn6P44aIJjmess+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWKqqSlE21JHegU6nmvPBCH6AAIBk1+2CcADaSGeYHU=;
 b=BgHBcqwHx0+JEYrPFvkAZSOHipDUipqkUvIG+odiluBXJBcNJWEP6P9Q83dvqV3/SI2UO4pSkewheytbbFN6qenqMWsyEmKIyHXt7Tzb9tRQ39GaYsQ79tTUltdHN6v2Xu1SXWOMb30+Ue/JfkXN82SF2m09OmELKYnpsozxtEAerfU7aUrLq+Lfcgj1T3sNsM+4Sn4hp1AAicQTdwRcbpyje9c9YN5PciZUdpDB17f3Hi8z4Jlf5J54oP0SgnQ/WbcuuJI74N+1p/E8XyALJ57sLk4/HuS15ugBfYuGpp0cuWBka7KwPah2YS8cJspHju9IiZbf/tx3B124pORj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:43:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:43:07 +0000
Message-ID: <5eeea66c-97c2-414b-8c14-ed8182adc238@intel.com>
Date: Tue, 20 Aug 2024 14:43:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: airoha: configure hw mac address according
 to the port id
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, "Sean
 Wang" <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
	<lorenzo.bianconi83@gmail.com>
References: <20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:907:1::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ca79ba-00cd-4bad-89c5-08dcc1611454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zmw5ZG9RV25PTU5FdVQzVWpDR1gvWUFJV0ZFU2pESXFIRmptcEhVNm1CWFYr?=
 =?utf-8?B?Wk1jUUk2ei8rUEYzY0htV2IwbXV0dkppM0U0Z1FYdVQ1UXJrNWFVdlo1UnR3?=
 =?utf-8?B?ZW1xaFpDSmNRV2hCbE9yT3poQ2ZQWTlSc3FQM0I0SHNHNUJScFNHMCtmdnJp?=
 =?utf-8?B?Rzl0R0txcE01dmVadVIyVmhUSlZNN3hvcDdpbzhxMjVCZlI4bkRTZ1M0RnEy?=
 =?utf-8?B?OW1YKzhlN1RzNjJ2MGtqZ21IZDE3TzlmTldHbkQ3V2NmSzQzRHRIZUJIZzVM?=
 =?utf-8?B?R202STZHSytQNm1zVnZBMmhKUnlBcnNKaU9ETWJUaEd3UnVYOVIwaUM0TWl6?=
 =?utf-8?B?eWpLMUhEa1FpVnRjZnJsZS9TK2svNUt1bDFhTlBXWUl1ampQbFF2ZU9IbStm?=
 =?utf-8?B?YU52a2dZOVp4VGRqU0NlUXJPdGMweng0N2hpT1QxSGRDdTJiQng4TzBtNnZs?=
 =?utf-8?B?S1V6dW5mQ3ZpWGhyWDZKYXJzeWZodTk5bERpMThvQkZxc01KN2lQajRrV00x?=
 =?utf-8?B?VlJ5Q1hXbytPYnMyUXhiWmdiYlVod0crbXVsVWsydk1sS0dJOTBNdDJ4YVd0?=
 =?utf-8?B?dmxPSy9nZ1haK1JCK2xXQ1lLbUhOTS9Tc0VZcmdad3NKazgycmFObUNtRmVo?=
 =?utf-8?B?UDFtR3k4YTQwMkZtUFBmanZmR2J2TnYzYkNpb2dCMGlBNnRhQm8zbUZoeTMr?=
 =?utf-8?B?dkZyaURjb01VV0ZienNGQWpJMTlvbS9iWE5vc3kwWkd4OFlTM0pDQ3Y3MDl1?=
 =?utf-8?B?RzdMVEUyQlpQQmlaQm5oUG11ajZ3eE9aZEdyUWRweVBhREtoVGkzZzFHZENE?=
 =?utf-8?B?WTVPcXZ2MGRLSS84WGRzOWp6REJEdVZIQmFqYlpnR29rVTdSS2loRWFRRyt2?=
 =?utf-8?B?Unk4UGptdXBBcUlac3d2dVNkdlVxWVk3TVoxZFpkSVRIUjY3K0VkSkdiUXB0?=
 =?utf-8?B?Z1hHbkhGc3NTdk5ic2p6QnI2RTVGSlUwUUtJTk5kV0pwYndiZ2VyekVjQzRL?=
 =?utf-8?B?MFNtckNFU3hFaWNtZDNIQm9UZm9NRXNUTmxONk4xd1pVb3JJVEdFWE5tVU1y?=
 =?utf-8?B?YVNxK2RBUUVKUEJzZzlhQnNMQStMUVNxOTI0VzMwejg2aTkrbUFtN2VtbUsv?=
 =?utf-8?B?WmhSWjNPUjZjT0hVekIyazRsdVRDOGhWQ1hHdXF1RGJ1Wi9BelFaVE82RlVu?=
 =?utf-8?B?eHQzVUo0VTBhMU9KRWxEbEhSb2JuTVFKYzFuSEx1eDZ0aEJXdzQ1TWdVd2VL?=
 =?utf-8?B?VzJWaGRzVnZJNGF6NXVxVkNkNnVBSEpxNERYcHdQKzV2dUFIc1ljWjJpN0hJ?=
 =?utf-8?B?ekljd3RPNXdEdzluVVJaM1BEaG5hNTNXd2RPVS95UnhNN1JPOExyQ2hNTkZM?=
 =?utf-8?B?eWZxeHQvVlhVUEhDWXFqOWcyU2tlYnFqRmtJYThhUXhsd014dllYY2o1UDVQ?=
 =?utf-8?B?QzVlTXhTYUR1TEZ4cEZqSGN3eWpJSHByaDBpeUFuR1JnUkVPS0w1UnFBUXFi?=
 =?utf-8?B?MEFEUU43Qmh4Q0hZUGpDSSt0RFpCSXUxaFlXSHJLUERmYWNnbjZEajlLZ3J6?=
 =?utf-8?B?Y2h3dVcwTzUwd0pVeURza1kvQlk5UU5tZkpHNTBXYnV6UFY5N2JoVmVaNjM0?=
 =?utf-8?B?WS9aSzFoOUFEemp6NEJHcjlLU1hFNHJmWnpMWld5LzdPUkx3ZThYNGRCWEhQ?=
 =?utf-8?B?VUJOS2d0M1hLZjhPMCs1ZDBma2hHYXRlWlhBZldyWncvVjFaS1pOMVhIWHVI?=
 =?utf-8?B?VjlqTjRhSTVzOXlBY2ZocTR2b3puZmVkVU9rWjBpNElXeDJrbk5yOVhqNWJr?=
 =?utf-8?B?ekt4RzA1WE9iQlBaakcrNnJlaEhIQWNQRXZpS2doTThHeEh2RVJrVXdFd2hO?=
 =?utf-8?Q?7yoQaKOS4AtRT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVZ4S2VzRzRrVHdLZ2I1cnRTdGdJUTltWm5pNWtha0NJV1J5NHFTR1BFbmV4?=
 =?utf-8?B?Zzc1V1JrcitzYWx5K2hBamNVN0xFVUxQakYzY21vRmdUNUJTL2tVN3RsYXpZ?=
 =?utf-8?B?bjgrZm12dnJ4bVJKdStSeE96eFU0NERpYzl6RTBEVVE1U0t3bHl1MVBHT3Nk?=
 =?utf-8?B?TUlRcU1icmJyOHl2Y00ySFlYY21VWm1NeW14aXB4c2NvTm55SjNydzd3RXhZ?=
 =?utf-8?B?T2VRa0J4a2VxZXNpRG1Qd2lLK3poVzROSHZ4UENwekpXVkJtdWZ0am52bU9y?=
 =?utf-8?B?L1BIVk84KzVrVzFsS3VubkVHVGsvdWE4Z1AzSEpuYmxETGNHWEdQUDJYbHhj?=
 =?utf-8?B?WnFHVng0NDVqK1hWOWpBNW9BOXR6b3ZEVy80VEljL3NjTkdTVWFSY3luUmNF?=
 =?utf-8?B?WTd3N0pTdFg3Q0VKMlk2ODlDdVIzRDJ4ZmJ4VEVjOEJYWHRCRndPYWhSbW4z?=
 =?utf-8?B?bjcrV1JPZTRWTXlLUHhPTlhPQysxMnM2UlpvUEpSSXRHTDl4cVJuWXp5RG9C?=
 =?utf-8?B?L3FqbStVb2JjZUZHdHBrZlFkeWcwRExZWkZhUEtSUmdmODExOFhjZzU2eW1Z?=
 =?utf-8?B?dUN4NjBHZzQ0MzF1MExOUVhIOHRkT1N2L09Cblk0NnJ5ekZlWDJVT3dpUUx3?=
 =?utf-8?B?SkFCdEpFWTlodmxaMVVVelg5bFhWYzkvMjYra1YvYzU2SGtZYkdwNWdWcXJo?=
 =?utf-8?B?NEtjRHUzUlFRTHVnc2NSRVgvb2R1THNLaTdpSVJYN1h5bktLUzc0b1dTd2J6?=
 =?utf-8?B?SGRoK3owaHMwSEVDeWluNlUwb0xzNm1PcnFXWXVCbzN6NmhLUk82bm1GNHI1?=
 =?utf-8?B?dEZTV0ZQOXhoWUkrKzBkZ0Y4eUN3bjFOZ1MrbC9TK2hRTHJ4RldCdzZ2Y2Y2?=
 =?utf-8?B?WXNEUEQ5ZUY1NnBHTkhDUUZiS1cvWFZkZjFLYnRNbW0vcUZQT3lsTmh2Zm1O?=
 =?utf-8?B?WUt6amdpU2Fzb3U0ZERHdzhLOHE1RzJ3b1ZlZWcxM3ovS1FBbVpEMCtKSFY4?=
 =?utf-8?B?UGo1dTJZVGhCcG15ZTNnODVRWktDZFVEZlQ5Vm9mbEdCSEpUZTBBV0gwNmtK?=
 =?utf-8?B?L1JvTytqT2U3M2RGOUpGaGU5WnhIMnpuSk5yc1NTYUtmMjF0QWdURU1lRFBo?=
 =?utf-8?B?ck43WTJlbkJvQ0twYXZGTXl0TGNEL1FsZnBGVEg4MjFtbUZIdytOTVJNekdx?=
 =?utf-8?B?UVJPcFp4UnU3UmtYb3JZU1ZpYnIrNjNjVjV0QkZvblFPelloQTZmcUloNFo0?=
 =?utf-8?B?YTgzUUxmN2djMHpNbmhZYnRTYTU3SkZJWmp1dnZEYXo1TW04N1FLV2lMcSt1?=
 =?utf-8?B?UUFMRjg4blAvcGxZNlJpS3NJUHArcERlb0pudnhtQy9WVWNJb0tYbWN1eTRu?=
 =?utf-8?B?a3UxeUdpc3kzWWt5azhQQmVOeXNJdmQxNVErUy9NalRiRXpYUnJIZWNkMUEz?=
 =?utf-8?B?MmNtRWg3K283UWFjTVduUlJ0LzFJTzFLODd2YXludUN5ZjdRU29rR0hwbmlW?=
 =?utf-8?B?QWFhbTJ2QmlUb2QyN2YwQmVEMUhheHFGazNWOGFqWlcwVlFqellFc1RHUkND?=
 =?utf-8?B?aTF0cGVrWU5iVDVvMHRMU01ZTTBuU1hVZmVlTUY4THg2YTEvaGNFQUFJYkQy?=
 =?utf-8?B?bUJDRS9WWnluK1N4N041WGpzcEFsREs4bHZ5cEVRNjVaUHpXeG9XNXJqeFp6?=
 =?utf-8?B?N3pqTDdQdktlUnpMbzg5S3oyWG1pcVplc2tCZFlUZVBRY0pheTF5RjN0Y1JE?=
 =?utf-8?B?NkpPYWkvN25OSGZaQ3NQamw0REZGbDJQT2s3VUtSeUdBSzN0amNtbzEvU280?=
 =?utf-8?B?cUhOYVpzQ0UvT3EvVGxnNEJrR01FUmtmSjgvZVFOTXRBY3k1L2E4ckVnYlVv?=
 =?utf-8?B?YVRhdTJBSDNWZ1I3ZmxhdXVsY25WOVhETlVaQnZjQ3MvR3lNbjVQT1VJbzVU?=
 =?utf-8?B?c2dsQnBZUDUrWUlBeVdEUlJvbG9CcXpQV0FCcTk3d0lXeWRVWlowK1RjNC9K?=
 =?utf-8?B?SmpmcHgxd3c5UURJNHpBVmF1UmtZRXE3M3pkRkp6cit1TmhaQVkrWXJlRncx?=
 =?utf-8?B?SGFEOG9Bdlp6ckMwcXRuV1FvMEN1YlhRdXpEaUFpWHA2dzRZZDJ4UTlSbDVK?=
 =?utf-8?B?V09iUnJSMnpXa1k0azZzZDZRVm83dWJNK25QUXAwS21SeTdGNktlUFBoYXRT?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ca79ba-00cd-4bad-89c5-08dcc1611454
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:43:07.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 016pTHjaGcDtXxmx40qbFZ8kutTZ3O/gh3D0nIC7RHj30nyRV/RYOyl3CelUPXYh7y5e5+wemnuLVXR1nnMP8a1LJRMuJUWproDEB90Ov+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com



On 8/19/2024 4:10 AM, Lorenzo Bianconi wrote:
> GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> GDM{2,3,4} can be used as wan port connected to an external
> phy module. Configure hw mac address registers according to the port id.
> 
> ---
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

