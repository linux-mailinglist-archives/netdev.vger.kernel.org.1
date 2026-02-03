Return-Path: <netdev+bounces-256040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIteCUBDgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 875EED30D3
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F4D304F367
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148B1E0B9C;
	Tue,  3 Feb 2026 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQq19mpe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30AEACD;
	Tue,  3 Feb 2026 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078878; cv=fail; b=rr0pfSq+Wxp9hGauaf8+i9obqEfNQiZlZ5ejwd9gTi7XMdbyo4FYn7ZEP4SJQ2gFn3WHZBf4g7G7pcsEWYlCUgxcFirzUgKHEqoxG1WbiJSKU/iqLl2wcPK9TSgPzdQfyheh4/Xi8/akSOrU7obSTEFdqiCuKfaCUTvCcDukNww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078878; c=relaxed/simple;
	bh=cEsqU7ibIyyrVfkHTAZ3wdMNKQPgPzMvwKDEquwLpo4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8X0LjHeyJL0bsWQf3E823KRaAwSw5N82lUWqpT0wz3xiB2nEAShU7fJM+KfH6gTP9LbxBjg56LNDQW95Qh4YrsKc+tUEvCmTh66Xo6eO9bSkM9sCJuTeGtEhAVZcQSASShLBG5zc55AfRpdOGYAVpWPqp+5KUGKgKaL1M3uftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQq19mpe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770078876; x=1801614876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cEsqU7ibIyyrVfkHTAZ3wdMNKQPgPzMvwKDEquwLpo4=;
  b=dQq19mpeniiladN7Ed42pn8+kBOu+2GZvn6m2Wc6pPpsGzevWGE+JIL1
   17N4W/YoWv4vLGpNCQcjd2tVDUpO/+w9TK2ibW/8ITHfsnF7EHBC8gNiF
   RuYb7dXJvhO80oNHundMVnBLGj2nFTGKWXxSRXSHLRFMbA4Koy/qjSx1x
   eORom3m6t2qTokCV/w4bcCDHc2CdON9q2j+1SspmlKRyIIn7e6yvzHTrA
   vu1JedioqP9CJ9v2RTrTZDNreStgZLlzMDXLDPjxNTcd+v3wMwBhgx9ER
   At8pFXoozUfM00+WZFb9nvGjt8VRrfCoMJ7fFYrJHHGDTyslAS0uB+10Z
   Q==;
X-CSE-ConnectionGUID: SWoIod2YSUO2MrMYqCTkSw==
X-CSE-MsgGUID: h5O3pRn0TMOtSrSuIPVz6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88821074"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="88821074"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:34:36 -0800
X-CSE-ConnectionGUID: HjcsNtjaTC2gMGRFfACftg==
X-CSE-MsgGUID: ZV4rNXtAS4iEhf8EeZj62w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209891701"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 16:34:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:34:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Feb 2026 16:34:35 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Feb 2026 16:34:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMnQ9yZ4/dtCJqdRpOGQsIbj3wBhdUksud/ELTZvWKNTvMfwp1u+wroML6PqE+TvCGr6ZxMYl8mJBJWping7IMzYgeLPIwGyW0wa9fapKwBIEbGg0GSNMtz5vCYE6wH6WPT6bHx0FTIfnX4Aaks089Tr15N35s2hCl9NrqiWfJIAwLKY5r+cEBJ7UUu3u9HEc8MEjHA2uXHw2kI4mtuesOVLLLTlecaQGurqVrsvtf4beP/1quZDuVldinga15RSEULzl7jtiPVMEWts/YG3rsbhaPowwoLKLzFIlj/BRpRiT5RNzfd0HIxTInPcAFg55OoqiD4sbIMdZkZkdKVsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juInd6lLbSxFKOalK84u1Q+5rWUvuCMlfgtsH9h2690=;
 b=j1NuHfh2pVSU57Lt1mGSJijNffpVGMafS9ZFz+l6hzdw0Hh1xLsSL9hBIBqbWOzzJxeR9N95WAVpxRKr2A6tHcTXSqndzNIVIMwmKnqzSS+vxnXtSi5vysnjHH2BPDe2EuCZl97oNiKyxgMTCZ0DtuedBeU06LjV5C0/KciWgBRI5e+F6t/pkwcQad5xiT8xH/x/1WNsaLTyjYsQTRupCkfBEuXPL4HH4n00bucQ10itROAlQ9aWYSEi2deUIITDpLZet167uW8Ymc3EgqVJSCb7q1grsdjXOMGkqpj25xbVUQd2S0sz7JDOHTsHU1yIUNmyL8R/LrRFrWgr5c0NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7340.namprd11.prod.outlook.com (2603:10b6:930:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 00:34:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9564.010; Tue, 3 Feb 2026
 00:34:32 +0000
Message-ID: <89011ab8-0ec2-431d-8842-f3738870db36@intel.com>
Date: Mon, 2 Feb 2026 16:34:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Anshumali Gaur <agaur@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <aYCCFw3cTeyA3p8R@ccs-coresight-hyd>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <aYCCFw3cTeyA3p8R@ccs-coresight-hyd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: cda27e00-1bbc-455e-8d1a-08de62bbffe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlJ0Mk9pREFUTDZJcnowUHo0b2RHOXdzaENvcWgwMll0dzNub2FhRjJNSWlo?=
 =?utf-8?B?clJSd2I2Q0NmOGt4dmY2RGRudzc0dGdKd1J3YXVDOTBPZHdQeXRDWXEyK1dQ?=
 =?utf-8?B?VHJBdXIvQ3BFVmRqNUFYWWN0YzN6UmViY0FwbjNjVjIyS0IrYXp0MDk3L3dF?=
 =?utf-8?B?T0loSE1nSlVOOTBiYzlLaUlxUGQ3MDE2WW5NMkRFQW1XQWRuV2g2Z0F0dklS?=
 =?utf-8?B?Slh6UXJmcDcyMzc4ZDV4dHh0N1FJck16bkg4TkFHOTZUTFhNUlNsL045V2t2?=
 =?utf-8?B?Q2MyVWpZVGwvYmdFSFlZZ1pKOTZBTDJWNlExK28xdk1BaHJMZlBlVm45T2Ro?=
 =?utf-8?B?bHR2ZE9yT210WHdqVFhoRVNlQ3F4K1FLUWMvbkVtTkM2V2x4dTMrSDJPeGtk?=
 =?utf-8?B?YnZxaDRCT29LUVFmeTZDNjR5ZDROVzBManMvcXZKb3RSMUxiaWwzbm9ORkk2?=
 =?utf-8?B?S1JadmtYTVJsOVh0L3ZWdWpxWjdQaWdOZ0U2MklDT2RyM1VvRWxrQlhocEI2?=
 =?utf-8?B?a3V1SDcxc3o2WXZSNGs5VFJuZGlsTDk1NDJHeDdKRFBacVh2bFVsOW5QZi9y?=
 =?utf-8?B?OVdwY3JlTjdpZExqeTc4YjF4VjRzNzd0R0tWN3JpditYbE1KSktWa2QrZ1M2?=
 =?utf-8?B?TGRuSDBiemZjRWg1MmcwbUZmRlA3L053a3lKUDRCWkd6NmRIZGwrdDFaYm1V?=
 =?utf-8?B?TGpoWTlCRG03N0xFUlczRGRCbkZrNGNPSGpNQjNiUkJsejVVbWMrL3VpaE1j?=
 =?utf-8?B?QTVDZ2NWeGpxQzc3NkRhdGhyTTE3UDhCdWIwdTR4aHF1UjIwTFRLMFNrVVBk?=
 =?utf-8?B?VGFSZ2tpakFlSU9nOXZHSmNTYVRrRGNmYTRDa1kyVldSdENqL1NMWm9oaGpt?=
 =?utf-8?B?Vndpd3c5ODVENTRmeDNvenM3TmRRU2RDRXRRKzBVRkwvK29qelVzU1FmT2pt?=
 =?utf-8?B?bURzMVdWd3RueEU3cFNDSGdxeWg5TS8rLytDUWJvZGYzeXhEWHRkRTM3clJC?=
 =?utf-8?B?emVwQnRQS0Y3cTdzRUh2TkJuS083bk1HKzZEZU1GTFNYRzU5eSsxdFJLcVdV?=
 =?utf-8?B?YkhHRys3djlhT0E5aUg4SGJnQjZBV1UveXJkWmE1cWM0cGNia2NOZ0dlREVG?=
 =?utf-8?B?YTlCVzZaWVpmNGhIOHlUMldWTzVFN0YwZy9jblJnNjVaOUVmNnNORnorcGpF?=
 =?utf-8?B?OEZWYXJGSjRvT1FHcWRWNFVKc0ZXYURvWWZQMk4vUk5sQW1CWCswc3F1RVpy?=
 =?utf-8?B?VUtPMVFZbXZuTGN4bnNNVzB2YytFT3kyN1UvL0pqM2FhM0NxbHJ6OFQ5YnNv?=
 =?utf-8?B?dFN0bVBGdi9zbkl4UzdQcDZISXFVaVdDQ3BVZXVWTnNBSVdCbG9mTXJtNjhG?=
 =?utf-8?B?TGlFZXYxa2FMMEVXakNzeUo2dUhoaEpGaFVoc21NVGdZMVQ1WkhESW9ZSkkr?=
 =?utf-8?B?OEp1d01IVTVYNUIwQW9Xb21VeVVEQW1LbEgreGxTY1ZqKzZxWnd0bVh2dlFE?=
 =?utf-8?B?V3k4UTQyR0JrL3psbWxBZ2x3QjFmaG5SS1luaHVZWndQem1OekNvRzlORjZV?=
 =?utf-8?B?VktjZjhza3owem0vOFpvYjhWdTBTdTQ3T2hjYzNOTUtUdW9ObnIzMm9hRTZJ?=
 =?utf-8?B?R0l4N3VjUDEybmpiUEd5SVhBYytlYzVVWDFXYjdpbmc3dGxWVnloNmk5NVhT?=
 =?utf-8?B?RjY1dElMWUVKbFBFVzQwRHQxVnh6R2xTalFhNHZwNWNVSlN3cWQzUFBhRFpL?=
 =?utf-8?B?dzhIV043VVZRQXZIMG9Qdis4QkZvcXFYWWRybksvdHkyZkx6L3l0dzZOdWJG?=
 =?utf-8?B?OTgrK1N4cVk2Q1lLc1RrWWJEUC9YQnB2dFloNkVwOXBPVEIyWTlTWDd5bVFT?=
 =?utf-8?B?MVg5VUlCcm1maDNSalF6eXJ5dDdEbXYrRjJrRkM2MVVZN2poaUNmSlRyN096?=
 =?utf-8?B?UkpVbzFCaktleEhtcjEydnh3RDA0aGkveE5Wb3FiU0FlTHFCSGtCQmwzaXFX?=
 =?utf-8?B?WVlqT1F5eUZSVU9MZHZhL2c1dUpBZmhYblpFMlUvU2gzaFhwNTErV3VTQzNr?=
 =?utf-8?B?UlFUZUwybWJKdmVXdHhpejREbVZRNHFWeVVQL2xKbTJDenhMRGdmZmFKWTly?=
 =?utf-8?Q?Bb4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5Rc0JwNndjOTg4N25WQStEZWdKVnMrNERaN3ZkYnFUaVliMnd0bnFCQWlZ?=
 =?utf-8?B?ZVAyUUROV29GV2ovZzJHQnhhbVQzTkM4UHhBa0dFbVhRdENuQXM4OERLZlow?=
 =?utf-8?B?UHlGbkR6dkF3dERyb1hmQ29BVHNMVFcyT0pWL3VpWlhGSmlGUXQ4TExBQmIv?=
 =?utf-8?B?aHp6R20ydkhZZ2E4ZlRDaHpubzF6elFJbnFtTTlkdXlSL3pCZlpzRGxZdUVG?=
 =?utf-8?B?YXdib2YrNGo2WGsvMHhWUzJYbUUzeVRZcVJUOTVnVFdMbXFTWUdzVGpmcnAw?=
 =?utf-8?B?NEJXN2xQcFZac1BNQ2lXNTdaN1BIVXJyZ3RCNFg3Zk5UdDNndGVYdGo1cFA2?=
 =?utf-8?B?TnJ2YXZybXh2ZlZ2NGl4cnhqUEVIYWxjbWhMTVQwMnZXMXBHcjR4NCttWnl3?=
 =?utf-8?B?cTc5T1J1dEhWQjA1am45Y0pvd0pWWlFHck5lZ0R2OUZ0K2pFekdTVTJzaU05?=
 =?utf-8?B?TXpZVXJHK0xLQ2I5c1Q0L1ByUDRQQlI1S1V0K2k1bnptWkZJc3ZRQTNMSm9B?=
 =?utf-8?B?dnMyaldwWVNQblFib0phSXN2UlBDemZ0WHdMeitJQmtJV0RlSzg4Zkd2Rjc0?=
 =?utf-8?B?YWlYcFVPcEpxdWdLU0lZbnRPQXNRbUJTMmt6cUhlVXU2R1h0ZVM5QzVZeGRl?=
 =?utf-8?B?LzdCYzJ0MGJ1SFRiM1FJT2pQenJvZmw0bHZSVG9aQ1dGY0ZxSlg0WjdQclU4?=
 =?utf-8?B?OXpzTTR6TE5nWE13ODV2NWJzUzhMWi9OZ2hiRWNEZTJlR0psOHZWZWsyZHF6?=
 =?utf-8?B?QVZKdFo3ZkFxSXpqbFlveXBkdlNjMUZDVFJiQ2pNUzI4eXI2NWpnZlBuVlpi?=
 =?utf-8?B?THlxQnFaa1JBcSt1NFMxSGpDUWNwbVlvdkFFamRGTVg3Tmp5WDlhdmZCNlli?=
 =?utf-8?B?NmRMRXN1Unhob0RmNW1Ea0Q2b3IrRkxWUWFxaUdJZFhNWFdUVWRpZXFiU3c1?=
 =?utf-8?B?RFlRckxoUWYzOUdrdFJhaThQL0YrMmt2cDRzczVBaXkyZ1Q0R1U2SEV2Z2Fr?=
 =?utf-8?B?RlIvQXZleTJQQ1FrM09vYWpENnRyYVNTZk03WitZeUhTdkVJWlEzUDg5dTJ2?=
 =?utf-8?B?ZnZSakpYT3QzdHhDdUF5R3FFbi9nSFI0d0NaMTZKcDJkS1MveU9rNkFuN3Qv?=
 =?utf-8?B?RDdsZHFScXVlVDY5UTY5eGJRZ0hWNTR3WFhPbmZMYllKVnRhMHlYejVOSXcw?=
 =?utf-8?B?RmtTZkFtSVRYY3Y1Yk1Wa3dyU3JWRHMxMFRIM1lTdmpXSUhwKzhvUE5zTDRq?=
 =?utf-8?B?cDBLQTFnTnlrZDdOMWttWnZkdlczVjJ0MGhaYmJkR0dIRVF2cjFMSzB2WkxQ?=
 =?utf-8?B?TzNrZW9QNmlxcFg0bjZkc0ZnaTZRNVBIR2pRTjlad2N5NE1KeGNKT203aXFu?=
 =?utf-8?B?S1FJS2dYNUp6RzVrVFpGWWJKak1kSTdtYTNNL0NiaTZvZE00bjB4YXVQeWYx?=
 =?utf-8?B?ZE11VmlKejBLWDMvQzg2amlpL0VqWUxYQ2ZndXBid1gwWGZQYTNCNm5WVHVi?=
 =?utf-8?B?eUdEQmt3VStac3RSZ3NkcWxYN0ZYV2hnZzlDT04vWFlEeFZLZ1gwaXlocWI1?=
 =?utf-8?B?R09zeW5uRDBNWDFtQ0lDeE9GV2NPeUx4WVM1WjdOQlJPU043dVlCT0o3bFhJ?=
 =?utf-8?B?c04vR3BNVWRQZGV2N2RLVnpoZUxHWUlpMUV3YUQyN1VwUEVlMnY1L2hhdXZD?=
 =?utf-8?B?aFRzbWY4M0U4SmtOOEZYS3QrT2RLWTVwZDI4NkNwdHYyZjBxOUEyTEtSK2t4?=
 =?utf-8?B?Ty9wSkVFSStLM2FBUzVyL0xORTg5WDVsc28xUVJCbVhJSFBUOU15RTlqT1hq?=
 =?utf-8?B?aUNCZEVjbEoyT2ZBdkdsaFIzc3craEJ3R2NnSXlKUWFnREdBQ1Q3Vmt0VXJE?=
 =?utf-8?B?RnlPeWlZN2ZibUVvTGRvUGlIZlM1eVhjanNHc3UweVRyakJlZ052NUJQczlM?=
 =?utf-8?B?WWQ3eFRnd1dwNVU1bHdmV09IbUx5aXNmSE0xKzY5U3Jqays0SnR1d0dVbWRW?=
 =?utf-8?B?c0xZMWQxdHdUS2g4b0k2eGV3ejZ1TW1WbzRSdWRJSTM5NzI4T2QwRXltT0xo?=
 =?utf-8?B?SVBwYU1KU2loTzhZNnVhZWtKZzlMV3h6OFVGTmtWa2xkcEx1cE04eDJOeDlK?=
 =?utf-8?B?RHlCaVgzV1E5cXI4Vmw4SVB1UkpHOGo5MnlHV3RPQ2FldkhlbDIyZll1dUVu?=
 =?utf-8?B?Yzk5UzhzNlM0b3liY01ZdXJrZ29lZ3E5YmdQWUM5UVMveHU4OWVKait5eU93?=
 =?utf-8?B?aHBtM055OGRkaithVk9ISTgwWFNEY09RV0hldzdMa2ZPSS9sUUxtY25vbUdD?=
 =?utf-8?B?Wm8wcXFLRk1oZVNTRnQ4YjRVclFCK1NJRWF0MW5kQk80ZFBrR2lWQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda27e00-1bbc-455e-8d1a-08de62bbffe7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 00:34:32.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WW5DjSG2Z4ALhKVkJ5RrPHM29wFBQKByU8ZkSb2VjZQrx2148oQ86xVNvacytnPyxfo9zutiVpibOp3WqH1CCt58qgWp9x8TsYQFthr/3HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7340
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-256040-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 875EED30D3
X-Rspamd-Action: no action



On 2/2/2026 2:53 AM, Anshumali Gaur wrote:
> On 2026-01-29 at 23:02:43, Jacob Keller (jacob.e.keller@intel.com) wrote:
>>
>>
>> On 1/29/2026 1:19 AM, Anshumali Gaur wrote:
>>> When both AF and PF drivers are built as modules, the PF driver in the
>>> kexec kernel may probe before the AF driver is ready. This leads to
>>> a crash due to uninitialized hardware state.
>>>
>>> This patch ensures the PF driver properly detects and waits for AF
>>> driver readiness before proceeding with initialization.
>>>
>>
>> To me, the patch description is not sufficient to describe the what and why
>> of this change.
>>
>> Could you please provide a better explanation of how the addition of the
>> provided shutdown handler fixes initialization?
>>
> Hi Jacob,
> The issue being addressed here is specific to kexec and persistent AF
> hardware state across kernel transitions. When both AF and PF drivers
> are built as modules and a kexec kernel is performed, the PF driver in
> the new kernel may probe before the AF driver has completed probing and
> reinitializing the RVU hardware. In this scenario, the hardware state
> left behind by the AF driver in the old kernel is still visible to the
> PF driver in the new kernel resulting in crash due to stale state.
>>> Fixes: 54494aa5d1e6 ("octeontx2-af: Add Marvell OcteonTX2 RVU AF driver")
>>> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
>>> ---
>>>    drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>>> index 747fbdf2a908..8530df8b3fda 100644
>>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
>>> @@ -3632,11 +3632,22 @@ static void rvu_remove(struct pci_dev *pdev)
>>>    	devm_kfree(&pdev->dev, rvu);
>>>    }
>>> +static void rvu_shutdown(struct pci_dev *pdev)
>>> +{
>>> +	struct rvu *rvu = pci_get_drvdata(pdev);
>>> +
>>> +	if (!rvu)
>>> +		return;
>>> +
>>> +	rvu_clear_rvum_blk_revid(rvu);
>>
>> Here, I guess you are clearing some data about the device status. Does that
>> mean that when you initialize later you will wait for the AF driver to
>> finish probing and configure this? It would be nice to explain how this
>> change fixes initialization.
>>
> The RVUM block revision field acts as an implicit indication that the AF
> driver has completed its initialization. If this value is left uncleared
> during kexec kernel booting, the PF driver may observe a non-zero/valid
> RVUM block revision and incorrectly assume that the AF is already
> initialized and ready, even though the AF driver in the kexec kernel has
> not yet probed. This leads to PF initialization proceeding against
> partially initialized hardware, resulting in a crash.

Makes sense. When shutting down you need to explicitly clear the stale 
data so that booting up (without a powercycle as in the kexec case) does 
not lead to stale data.

I'd appreciate a little more of this detail in the commit message 
personally. However, functionally it makes sense, so:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

