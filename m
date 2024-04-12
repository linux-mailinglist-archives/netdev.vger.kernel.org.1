Return-Path: <netdev+bounces-87328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E278A2B64
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9783B1C20F88
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316CD51C28;
	Fri, 12 Apr 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZBZwdvb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A650A9D
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914910; cv=fail; b=Wn8sig8NWLfqdnvrSb3e9BF1UcyufkYsNinp2uHm4A0kS4rHLtpLU1TKQ66Dld/Jat8UdF7lwUpcerJ83MnY3Tv4ef7vPiVDGRjc+UkXcALHhqTtg0tIW6/dPA3fltaESVOX+YkucxBc0AC8++HlY5t1AI+8wilQoDL+2Xyn4qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914910; c=relaxed/simple;
	bh=41k+TNfeo6IyqXMVz6bUdw/6YBPKZvpWi1jZZ8LwJc8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+6ctyBFcJTvgr28wy36EGwGWb0Z+EPjm+5goIBbQ36NfXNZAJy6L83hb/oR87bARbfCFyv3WJKrbo5VakbAnCLYrBV52K+yYWLt/XKXihaqeiBWZpeZQz5kSq3FX/LuRYGvYGviEdR9LyDD9htW+41MfRiA9j4TGz2HMyh0ZJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZBZwdvb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712914909; x=1744450909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41k+TNfeo6IyqXMVz6bUdw/6YBPKZvpWi1jZZ8LwJc8=;
  b=eZBZwdvbal4YfFCeFgdJtZcEczShliyT/M/MbAejayOxTehRtRIcduti
   Cyvj9r2PsyVGii7pexgTdgwY4tS2zwcryY3ZmhHMVXLmMXDhxZIdysdNg
   L9ibXMXbE1OqfyPEV0Dwu9NyiKKOTv9K/zGNzbVcNGIdEi1m3X4Os0wJO
   9a5qOZknGt9eOyMc01KjlqbgupJAC92s2kX+rBfnmeBfq6seqa63Eh6MZ
   EqcvkQCCnrO0Df6Upupj1LV8C1NW+ZXZ5ojXj9GsmGIMZM0kq7EMKvk0V
   Os5QYiJ+zPz8pBWI0hveSZuRG0yUwveYzAUR/ESv9DvReJg607lS+C8Qy
   w==;
X-CSE-ConnectionGUID: ssbLvKq+QtuW18/Y6p8vSA==
X-CSE-MsgGUID: RNauzoiwTSSV2HA6Q2IZRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19760728"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19760728"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 02:41:48 -0700
X-CSE-ConnectionGUID: Cyddj2mpQ4ilWuT6kcloHg==
X-CSE-MsgGUID: pMBvVPzHQBiDzlbR+tjZwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="25632574"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 02:41:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:41:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 02:41:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 02:41:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 02:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ap0cWgd4vC6651am8idD45szuaE6uRhi4tTl0RchK6axBoy1W28Wc4vfRqvVO57CPQeMnMuPX1S63O+1d9JQcG/vgopgDC7bUUt2dxqplXieZo2iwIvZJKbmhiCn3Fyrf7AcLHhLPK0U7NEFaCcZ7QpMRfQv+upb8tAAC0uDjIxTcZMjGegKF//NWpci4Ln5b/7uAjBvUfHqDvERWl1IvWoVuu5nB5HtvI6Klnd2trJqy7o/uq60uOuUna3LEUmbtlrD3seVB1yTIIHhMyk2cocpB+FOKH8/dYbJ9HIfJ39Nzt8MHQWFn6xnX3IPDIiD6/ioFshAbdTWbmA/7gPbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcgK2Zv5AUs14teST/EqsrlU6pl20OSrKy0eIRbjgME=;
 b=IKzu9qTy2u92LuL2LtxagF6qkjqmuqyAGOcx45NXZ9k3/GsPTiXVThHwnzWzTQ2ackVEuRC5DBquLWSYDqxEAs/7JX1Y6iGUMLqKrryvSd+ut2r21YDCA6XTCn93aDjzV90vYzAXmxBrLhoZ8Hghk1HqPOPfsMYdcbtYqSxUUQ/21pu3WTYgTparlhh0hh2pLRT9Hp2Q0oWag6ziAofM0ztzQG13EjYxSVRXai4EoF5dyCGcYT31gWP0yoXJibg5ayfCff3COjG32jBcbNLDIHjbw/RkgCQQsxc1vNQ7el/6vS936m92+hb56Aau2N+qHogsHTfDJuTeawjX5O4Mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8464.namprd11.prod.outlook.com (2603:10b6:408:1e7::17)
 by SJ0PR11MB6814.namprd11.prod.outlook.com (2603:10b6:a03:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Fri, 12 Apr
 2024 09:41:44 +0000
Received: from LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::3500:4b79:7d0e:705d]) by LV8PR11MB8464.namprd11.prod.outlook.com
 ([fe80::3500:4b79:7d0e:705d%4]) with mapi id 15.20.7452.019; Fri, 12 Apr 2024
 09:41:44 +0000
Message-ID: <f0ed2d9e-99f2-4739-a2a7-62de488db35e@intel.com>
Date: Fri, 12 Apr 2024 11:41:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] ice: Implement 'flow-type ether' rules
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Jakub Buchocki <jakubx.buchocki@intel.com>, Mateusz
 Pacuszka <mateuszx.pacuszka@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Jakub Kicinski <kuba@kernel.org>
References: <20240411173846.157007-1-anthony.l.nguyen@intel.com>
 <20240411173846.157007-3-anthony.l.nguyen@intel.com>
 <20240411200608.2fcf7e36@kernel.org>
From: "Plachno, Lukasz" <lukasz.plachno@intel.com>
In-Reply-To: <20240411200608.2fcf7e36@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To LV8PR11MB8464.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8464:EE_|SJ0PR11MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 012e0e8f-aa81-4836-070a-08dc5ad4c3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7ROWCzmxPiLx6iib1H+1O17/T0Uv72xVNn4glxd/G4XosHjBnyx6Xzc7OZ83brQPJIEaZA0gDANKarKUPZSP0ZV9KqkgHG99UWr6FljD3TRg96G1NnOB98M2eZANZb4E9livLKFr66tiGoCkOO61pdWWPigshJ2f/GWk+lIy/7xYDJqb9ktU/BrVTqyIZvONHot2AMoU/Yo7O/MqIK3iiG+H94ivXxZveYkubBF6xwiepDlJQyqTo4prXvb0VTNBTSpcL667OYwvaopT7rRyZokbTD+1IjRSOr6IoAElHhM4NsfEFHAyO6r44MnMbjP3vEROHgp52PgOZJXofpfBlg2ZWdemQJ+7zIV0avnkvZpVIed4MgG4HkTZTy05ASTwYLHRH3PKuw6VlP9zerejEmn13zma+GdEDTetB9cBnS0SAgpP4NO9Sxm6I5kRhr1ehtAUTE3JPRGiQu4d55Q+iWedzr74IGY7Ovwsg/MQD9oiqQOA4f/ORg6fjbawsYxnWnFOUxpneDtXgD/csGP4b2dlPFTIfL43QNzhpJnONy562IfCU0LVhmBmwi9no62upqbwoCqqf4UKbtw4SKgBqkFzPyC+H+lnQNiOmEgvlhPkkTRE0JTm+36wKuu+qVpau7Rsz+LRUI+dbGQZ0CmH7su2YWsox91G63+jNSH1S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8464.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkI0dytwZ0pKUzJmMmNCMEtFQm5leE5hdlNYODJXWG9HSFhRTTBCNWJSakta?=
 =?utf-8?B?RE5HN2Z0UkJ5OHMvWm00OGZtT2JFU0FXZnlzemxTZ0w3ZmQ4NFR2c3BaaDZr?=
 =?utf-8?B?b3dHSVBuYVBKODZTV2pUNE1STEhUdTBPbi9DbHFObEgwVFJ1UlltckJFeVB0?=
 =?utf-8?B?MUs2QkRTTEpMV2V4dmtZRWMzNUFzTzRiNlBvckdTanRQendhMjhoWmhKN3Vu?=
 =?utf-8?B?MEROUjhmdmZIVG1UZW9taHZpOElJZVh0eThZODRFbUl4Wnl3bHd5WVVOTmRZ?=
 =?utf-8?B?ZTJub0xhL2NBamlOQStmWWp3dnlQRi9LQ3dLVTE4MS9RMEl5ZHhzOWhJZUE0?=
 =?utf-8?B?cjAyVURPaVBRQjhRZ3F2anNXL1dNWHRKclBBM001MlFtNi85Nzc3TUp3ZzJB?=
 =?utf-8?B?ZFhnNkNHL0hCWVFEWE50OWY0UXp5VGFxRE1hNHVsSlFyUDBkWFlhaHhObHJ0?=
 =?utf-8?B?NHlIem80QmlKMzIxSjdUQVhkQTZKNE9JcXRPU0Z1SFJQTVZST3VWWEV3Zyta?=
 =?utf-8?B?aldReUdMRWVpZjhBR2pxUGx3c3JVN2pEM0lsWHl4OGVpeU5Qd3pyTTh5b3JQ?=
 =?utf-8?B?ZHU0MGZlakxwWGJ2Tmc0TXpBV0RNbEZEN084RWdkTFIyMzBFTklmbEhLLzdW?=
 =?utf-8?B?aFRvVGtSWTN5YXVKUDcxVG1iYStzeWUvZzl3T2QvOHJ5MFF3dXliUzEzZDJs?=
 =?utf-8?B?UVJzSUgyZ25xUW85RmNwQzBqVGFSbEl5eTZKaVNvdFZMWDRFUndGQW9IU3Ra?=
 =?utf-8?B?Zkd6MzA2Mnl2NnVRdndDK21vUkpUUmlwS2NwL3hYNWJZTUFFazhOd3RuelJh?=
 =?utf-8?B?dWxXdnBoZ0U5ZDZCU2NkS3piNDlGck9DWjl5WnR3KytCeWNLbEtHcmE1S3JQ?=
 =?utf-8?B?eVZFQnd0TFBTWTd5K2N3QzZ5NDFlN0lpRnRBRmZrUUVuaDhheVdsazRlZWF4?=
 =?utf-8?B?UEM4WGlLVnN4cnpoYnN6VlVqdytpSHNNS3R5bmpuWFZUTjdhQTRyTHpoTFdp?=
 =?utf-8?B?cjBNQ0FhYVpmd0lTSTlIMjBxclJhdW9neTRjTGxldG5ocWplUG1GNXgxdzFR?=
 =?utf-8?B?MnprMVRSTjJwc0FBK0pucU82Mjk1VU9zTUF4aGljNzZZVXJqcGQ1ZHlzREJu?=
 =?utf-8?B?R2Q3MWw4aFYwSkZ0c2FrTFNrQ1N3YUw4dDJkWmpqL0JsUHVLcDZZTTRjRmI3?=
 =?utf-8?B?UE4vd0ZZYU8rU29jazdYYm5mempSN0dlUi9OUElEeXcxdFc4ZXlqdzRaaFFR?=
 =?utf-8?B?a1Izak9KVXlranIyV3JFNkt2STkzUDJjMEdPTkU3RllnblVISXF0b0lrcWor?=
 =?utf-8?B?a3FTUEpxRnJwdWxZbldtdVl2VTZBR213emR4ZVRWYTNoV0JVcFc3UWdoTUJC?=
 =?utf-8?B?a3NZVEFiZXNQZWVrRTVlQ1NYOS9iZFRvSnZ2TTUwUDNlVVJ5L1F4M0VIMDB2?=
 =?utf-8?B?U1dqcWxkN25pVzJVTTRkMFRQaVJ3R0U3dFE1RElOWi9ITkxNem5tY2x6Y3Z2?=
 =?utf-8?B?VnUrK0Q1QjN1Rlh0aTlxUGh1bk5oQ1VHMEhBRGhsU1FjK3UxclBWbHQ1cTY1?=
 =?utf-8?B?aWhyVjlObmFJOHFuUSszdURWWjM5c09qTWhPekRzWU0zSFVKUS96aXBhVDVL?=
 =?utf-8?B?MGwwWmtlTWVYSFNOS2lQa2dPSlRkd1F0MitrT0MwM3h6U2pxV05LV1dJT09h?=
 =?utf-8?B?eFFsbVNid1VURUh2czdLaFpXeHhlRHI3ZmJWRUljM2NlUVNobjFRRHFzRkM4?=
 =?utf-8?B?a2thK0VHNmRLYnFoakF0Mm5kT3BOalZSSEt3S2hmZUNRRUgyd2tDdUo1ZTVk?=
 =?utf-8?B?ZU9FLzgwcWgvWkJUUXpJalQ5UHVabGpSZlFyaUdQZDhoOGQ4b281bkJhRU9R?=
 =?utf-8?B?b1FGRVhwRUdFbkxXb0RTeUQyT3lIRXczalllbHNYb3piV2xuWDBSQzFTalJO?=
 =?utf-8?B?ckJBN0lyNDJ0Z0ZpZ0FRSjNPdkN5bEVmZDR5a3JjYi9lMFU2N1pZbGpqd2lP?=
 =?utf-8?B?VFJ5Z2x6dkNVajAzY0Rncm1xSXBqRVRvamFNV2duWi84QkZjL28xOHN0UVFo?=
 =?utf-8?B?NEoyRUkyR0xRQWlPM0gvVEZKK0FkTFhSb1dzZjNVU091enhZVkZCMk1KVE80?=
 =?utf-8?B?cktKeEZZWjFVQjM5eVErZjdpNWhiUm9LSmFVNnpFSUo0S3Noa1JObVBoVzY2?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 012e0e8f-aa81-4836-070a-08dc5ad4c3bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8464.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 09:41:44.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cPzc2EPldN8jNZElAeGI39S/Zjfn2cn+vq+yYOT5v8qs0SXT+RJtf2hkunKlT6asZcWYBP9FTxV4nQ/pZOrsYC82AsnC+Y8xZM3NGbL/tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6814
X-OriginatorOrg: intel.com

On 4/12/2024 5:06 AM, Jakub Kicinski wrote:
> On Thu, 11 Apr 2024 10:38:42 -0700 Tony Nguyen wrote:
>> +/**
>> + * ice_set_fdir_vlan_seg
>> + * @seg: flow segment for programming
>> + * @ext_masks: masks for additional RX flow fields
>> + */
> 
> kerne-doc is not on board (note that we started using the -Wall flag
> when running the script):
> 
> drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1285: warning: missing initial short description on line:
>   * ice_set_fdir_vlan_seg
> drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c:1292: warning: No description found for return value of 'ice_set_fdir_vlan_seg'

Tony,

Change below fixes the kernel-doc warnings in case it is okay to amend 
the commit in your tree.
If you prefer I will send V9 with fixed comments to list.

Thanks,
Łukasz

---
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c 
b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index ab3121aee412..e3cab8e98f52 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1228,7 +1228,7 @@ static bool ice_fdir_vlan_valid(struct device *dev,
  }

  /**
- * ice_set_ether_flow_seg
+ * ice_set_ether_flow_seg - set address and protocol segments for ether 
flow
   * @dev: network interface device structure
   * @seg: flow segment for programming
   * @eth_spec: mask data from ethtool
@@ -1282,9 +1282,11 @@ static int ice_set_ether_flow_seg(struct device *dev,
  }

  /**
- * ice_set_fdir_vlan_seg
+ * ice_set_fdir_vlan_seg - set vlan segments for ether flow
   * @seg: flow segment for programming
   * @ext_masks: masks for additional RX flow fields
+ *
+ * Return: 0 on success and errno in case of error.
   */
  static int
  ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
--
2.34.1

