Return-Path: <netdev+bounces-228123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E765BC1EDE
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7323BFC39
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C92E62BF;
	Tue,  7 Oct 2025 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cld1+ciV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5862E1EE0
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850825; cv=fail; b=oNAGIhsqzQmY0EUr2A0L3Krdgz4//+uasIBxeCRXzyKMbuHNgyy8jAp6KXb/8oToyoUvGxTtGaXHn9AbLNWz/80agyuQuCTNJeAd3S1CsEVmAf2yX2HciD4sTDi9MS1ZjKDZx8bTO0CsmDXYzzqOgZU7jN0P7R0DrJlJWRB7bIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850825; c=relaxed/simple;
	bh=3im0AYPeMN2A5sbcvIA273TV9Vi5nZS/sgnTD7mLm38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHBEl2GDJiJj0xtAVFa8ull1csoQ/wRlGbh0KX2IuSCRPumJhsw9973t9qqrV7fHyc9oFVowTCF5foOVToQeS/rSTgYqJ6yl/fkCBYjDuAnDNA1zQ060hoxK3lnd/Xr+yAH23n2VHxhDW7legr06CK9+XLmznInS3ZICs9I2ctU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cld1+ciV; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759850824; x=1791386824;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3im0AYPeMN2A5sbcvIA273TV9Vi5nZS/sgnTD7mLm38=;
  b=Cld1+ciV7Rhp6BFsBk1VKwWdBtMnIBo/0WhBcs5DNFAx1xV0UzBuBcnT
   PK8LxU0iWeUS9n+kFrAQN+IQaOmByFiPBSHhkxRsRh2ioxSSpCVU73kGq
   FeJWA96atSbjk0xyqfUAigPVbrWWWeGBtTnFf6t50qpQ6WfCGftE8D1yn
   1A6Zc8iArlHoCPpiaWVyIxKB1jhRV37YtA3o+ZHkSHgN1nIQVEtwThYT0
   bw0dVg2/6MJFB1LhoHs0g4fS0oCy81XoWKcENaEjz0fg2dNLJyRa2cBl7
   KgfqLKnp6szHkipVBTpdDN5lk2gLTA6AWkZqQ3WEdoJOZeqLUIeTqXL/N
   A==;
X-CSE-ConnectionGUID: aAvsGNstQQawhpJcHCK0Sg==
X-CSE-MsgGUID: zCmjKWHWQHWOh6okztlaVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61982710"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61982710"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:27:01 -0700
X-CSE-ConnectionGUID: DBG3r0EmTV64CzCZ3+rtTQ==
X-CSE-MsgGUID: c9XSLK4ATriSTe68Ij/nRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="210842202"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 08:27:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:26:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:26:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT9eOpniySqVYSZ/YNy57W9YHDZz4VdKv/OvGBK1rIj2aRhGvlDm7sJdehbPBJthKKosi4FPtdHx+hAr077FZ0fbmq9T1XZMiCUNJB9ms/s8BZ6w8cM6kxmjK4u68KnF0KZ2MQc7GRBV1gyR7g7RONYsspXSRFfezRL/Fu8KTq9SFXa9TI7xCx34YcfH/0kylYKLFeitmnTR4C6KIwIytV+aS/aHfWOGbaiW+TXBhC7n+ZEIALwMEhNq+pwNxpOftOyylhoC4bm7g/qOLK29J58p51v49ZQJhpbNhio+qc8aqcR5I8EClA6NmCJms6WMvlmV/NkFoJyvDZ6gIPQVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akq66twWsZ3zwhyPoKWerv9P3nqZ4unLkoGWmyqqhE8=;
 b=wZ0vnOJ0e2IBqqBhNq0noWpULHKXE2OW/xrjzjEczSV5NylopsEK9Bdcb7RdXGxSj35QStULUdjqqJW18mII+defBGYXXhYVvU4FrpAM3V4BbGsW13XTalZ4Qb1ukzNN6D6+mngqZgvitF+93Iqx3f8aDTMNYZiFQE4LUN35nddIFkvJCAUrlJrxEV5O1jlU9m9shaZvXVA3tb8LbTRbQgER8M/8bCI7Urcg0lLKM1aBidfLmrE989dgpBwq6gzXcTCmg469HJSODRnKHc2PkCEutjFebbhzSGYL9x12SQb/QG+7MYcLkh05Peco/BDi7xkbFJPdH6Jx+xqc6O9UuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 15:26:51 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 15:26:51 +0000
Message-ID: <4e997355-1c76-429b-b67f-2c543fd0853a@intel.com>
Date: Tue, 7 Oct 2025 17:26:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/5] net: add add indirect call wrapper in
 skb_release_head_state()
To: Eric Dumazet <edumazet@google.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
	<willemb@google.com>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-2-edumazet@google.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251006193103.2684156-2-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::26) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3da3d9-f9ae-4658-eecb-08de05b5f03f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZwTEZ0UGlORHJFaTl2UzdvOFp0dkloV0U0UU5iZnJObXBHQnVxQkRSTENy?=
 =?utf-8?B?WUhoeFVpTEx3bW5XS25uTWNRQmZXSUpsbnpFWlI3UGRLZ0F2U3NXajM4TnJv?=
 =?utf-8?B?WFp0NmNkQkhidnBsaWVjSk5WWXBOVFRaT1NjTnVxMUNXREo2U0YrRU8vYXI5?=
 =?utf-8?B?MlVxV1U2NmhBQkpMVVplTnMxc1oyTGczQ29jcXJTaGZxVzVUT2E4TFAwOWla?=
 =?utf-8?B?SHkzbUVHbkZENW5pMUVLODNPOGtSREVhMlZvTWYvblNOS0MvaFJxaVZvRmtT?=
 =?utf-8?B?Mk9scXNJOTJ6UTFkRnphdldqMHgrOThTUzVkKzJjNGhIVFdxUXZ2MC9pcS9h?=
 =?utf-8?B?YXlHdHB6SDQ0Z1IzWSs3SjdzUnZ5YTY1L2dSQ3JXKzhZbU9HYnNlR1dKVHhu?=
 =?utf-8?B?SzlxZlNvYjE3R2NOYnMzU3hianV3a3RidGtuSXJRUkMzallMWjB0My9DUGtt?=
 =?utf-8?B?MEJnMk95eWZVaEtHSFM0T3lua0JIQ3FKL2M2bmlOWUVXQ1ZJeEc2K0hSdUxD?=
 =?utf-8?B?ZEV0djAyS0s1eGQxZnBSVzR1T00rR2F1RVYrUS82UStlU1FrcDZuZDN3ZE9v?=
 =?utf-8?B?WERReTB3NG1XdlBLM0NvUGUzZ0p1Q3BZT0Z0MndHeXcwcW5OOVY0d2NxSWhZ?=
 =?utf-8?B?WFlqUEFCckliTnlwWFowQ0lqbWFPb29HZW11R2sybjRQTlFLejBLbzltSmJr?=
 =?utf-8?B?bUc4OGN4dnAweDNIdThwSGtmMWdaK2JPWnhac05Cd3JtbzE4dnRSQjNOUmZt?=
 =?utf-8?B?QmVjdmNWSlRGSk9qS0tWckgvazdibmpwQjV1U1RUODk0OXhRNFdTakJsa0FO?=
 =?utf-8?B?RXFPdnBPZG44TXVlS0hITjRCRHkvZElYT3R2VkJqV2dobXRyY29HaWhaQ0h5?=
 =?utf-8?B?ZytnemQrQzdzMGJ3MnVUR28zT1ExL043dXdWQTRLZEFTRzd4dEU2SHdPQ1l2?=
 =?utf-8?B?ZTR4eWxkaXNrMTFsUDlaSjdQanlpZlpQV1dCOTlLTDA5UzJDVHYzNnZucHhJ?=
 =?utf-8?B?aVpxN0ludWFwdXNnNUJWYVpsWjJkc04vK0R6WUNrMk9ITzluc3ljRmxzcmRq?=
 =?utf-8?B?VlFsaXp0TDFvaGh2NjFXajZVSCtIdkxqZ1R1S2FUMjFaZFd1VDF0K2daZFVE?=
 =?utf-8?B?TXVqWmVVVmJqdDd3TXZjVnc0dHkxWGdyVDFmTWwyNnVaaXJJTlB3L0xFWEhR?=
 =?utf-8?B?dFZvOTZScmNKaThwVUN4SHBDMjZkVGJsOEFLUWtKb0tJU0hxNllmY1dBSnQ1?=
 =?utf-8?B?KzZEdXgrMm9DeEFUeDZyQTdrdXczZEhNWHFCYVRMSUFKZUtEaHJGcksxTVVn?=
 =?utf-8?B?UXVkWk1kWWhVZEtOR1JOdUpBMTNwQTVoRnZmN1hCVkNhandBQ2M2U29sbldO?=
 =?utf-8?B?MExiZmY3V2xObFkwS1J6UUdPUHZydkl1cCtMbVNCRVBEd2psblpCM0NISXR3?=
 =?utf-8?B?ODNndGsvdFNucDZrb1dra2ZnWDRCd2kzNUVSY3BVTmxvWFBHVkJnSElkQXN6?=
 =?utf-8?B?bFFvMmJ2M2hCTkw2ZVR1OW5tUjA0QnZqQTBLOGZFbGNYUkpZVWdWMjhjQ25i?=
 =?utf-8?B?UzdpTUZRRTlnUnkrUDhpS2dia2k0NUJYQkdKb2xQM2dNZllaeEF1UGY3Ykth?=
 =?utf-8?B?cVVoditJSnZ3bjBvZnE5b1FRQlNJRkgweEpiQ3VaR3k1em5VelJOaGZ5YWc2?=
 =?utf-8?B?NGR3QUN1SGw2ZFJNWlp4VVRWakxZTkp6YTFpYTR5VTd6VHZUQjNFMmpBelJ3?=
 =?utf-8?B?TFY0Myt6UXlMQVJFb0lqSEpWcGFBQnZMdVVmZ0RNZVNacEMvWGRITnNnR1N5?=
 =?utf-8?B?NnNNaVQxNzNpSEZockRxQ1F4KzUrdnNwT3QvaERrWXV4a3lWUG9tZWNlUmJN?=
 =?utf-8?B?YjhnbTNsV1VHaXFkV1ZiRFhnSnFaK1Q3eDM4bWp2eWtOQURTOUIzS2k5VnRV?=
 =?utf-8?Q?k1ZLVjtfDgTfdTEXsh5TALOfj+/EEaYA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YStJeXVGdFp4aVFqaTFZclVBY0xPSENMQ1FvQWZpRVlqN3dzbytIbDJCWDRB?=
 =?utf-8?B?UGFtTW9KUE5IbTYvM05CWHlLaU1yQUo0ZkZlbUdoak11SFhkNy9ZaVRHaW5K?=
 =?utf-8?B?Z0dna011bmM5Y2MxbCtUL0JmaE83YnlPQnVhS2hpcVhON21BU3ZFdm5PV3Nh?=
 =?utf-8?B?Z3hBNXlUNUE5TXZYTVgyZ0hCWXJhVGo2dkl0SDlKaGk0R1cvK29ZSjVZU0ww?=
 =?utf-8?B?TmkyaUUzcWFUQnhWb1BpWG5QMXZCckVtMkJqMWpwYmVhYTR4TFhQeTNiOUpB?=
 =?utf-8?B?VVFLWFpYSTFFZWxGRlk2dXI4enlxL2NFWU9FS1ByZnhaZkZSTTUwSjVQWGx4?=
 =?utf-8?B?MW9Ea213eEZWWUJGMDc3UHlNTHhBazYzaGUxYkViei9ESXpRUFdnVHRoa200?=
 =?utf-8?B?R0dUNEo0enBLMHZ4NzRlMXVXYWlsdGlsSFhmQzRjblV5MVQ4anpMMjA2ODJF?=
 =?utf-8?B?dm92YnJHaS9MTVUrMkFCQ2ZVV0ZWUk5LdHlHL3NuNytuZWx5RXMyWEg5cHBx?=
 =?utf-8?B?NlgzUHN2bWV1amVxeHZqTEIxMFlMekhiOFI2VFIyeExGWkdxZ0xycWVWSGdj?=
 =?utf-8?B?enh0bUJCNVVNWERubURtWlRrS29QTFJyYlBWY29HMlBSR29ZYkdYYU9qUE9X?=
 =?utf-8?B?eWl5QWJvYWs4NHJ2QStIUHJWZEcrUHIwUnBWRGVPSExzdHU3YTVlUTV2RXFU?=
 =?utf-8?B?VkVlT1hzQWhnVWlrMFV2VzIvUmp0ekpMRmk4cnBqVlJsSis0NzNkNGNxN0JC?=
 =?utf-8?B?R0dDbUxKcXJGeFd5bnovTVdWQ1piSTdUVHRoTkRFY0I0Vi9KN3RCdkZMdE1U?=
 =?utf-8?B?aFV5eklkeHJQQVdXNk5lSTRBZDQ2WTRoYjBlMzhoa0lrbHFsa0RCZkVSbkVF?=
 =?utf-8?B?S01DL2h2S2pnckttUjUySEQ5bTE0ZDUvQnNUVXI1cmZrbFQrUlgrQXV6OUdk?=
 =?utf-8?B?ZnpSdzE1L0Q0NnVNS0xIQ0J4NG5jMUhuZTJjdmV2QmVtcXR3VU1PY09Xa25K?=
 =?utf-8?B?NklBYmY4bXVSVTdtM0paa3FTUnlVeE52dVBvNGhQNXczNXNyNXpXLzFGT05B?=
 =?utf-8?B?dlVBQk5lVHVnUDdPU0dRQS9HZ2tMdDZVNHNYdithQmV0UXoyMG1JVk04VU9H?=
 =?utf-8?B?YjlVcHoxajNiY1lKbEVOTVFzWjJZSXNSZnlLUGNPdEtXUWw5K2h4K2kreGdn?=
 =?utf-8?B?anJMTHQwRmc4QVpEb0ZNWSs1VkljRVpWamxRVnY3MmROMThIK0FhY0g1MnNM?=
 =?utf-8?B?aURWR2kwZWU4aG1ieTB2SzNpWEpkWkgvdDA2MnZNOFk1ZFk5Y1pFb2tpWmx3?=
 =?utf-8?B?RXZ5cjVSR1JCL1FGQ0hEQmJGV0MwZlc4SEI2SEtrL0NnUEhKaDAybkdrMmYw?=
 =?utf-8?B?RE9PbFN3RWJFOXdFeTczd1hLd2RVTWdRcGFjNWFLZGtYZ0pOMithR3lDVkll?=
 =?utf-8?B?Ui9ITjBjTmN2VFhTZUJiVHYvSitua1ZTcFZYTk5kUVVtZVN1QzQ1K3RJNFlY?=
 =?utf-8?B?Y1pqU0FHS21SOFFsK3lpVk9wUWdYa1JISE8zTElkV1dyTFdkSlpNeDhmMDlM?=
 =?utf-8?B?eEgwUGt2UjBQN01wMHFodGdWZzlIU2tKZEdoRlpwRG9ZOUcxZDRGUVhwd2Fx?=
 =?utf-8?B?dEhGc09odXkwcGtrNndXNVl3elc0TklJYzNKVkFBbE12a1BuQXRUM0lFN0dL?=
 =?utf-8?B?QU5kekVVS3pNWVN2NDU5elN4Q2p6K0lPaXBLWkk5TmFiNjNPNjVscUhzUTRz?=
 =?utf-8?B?bVBBWVFxbU5NaWFTQnRvaEJHdS9CcUUvcGxFTmljNGRCbnF4NTFRZ1JhK2tn?=
 =?utf-8?B?bVVCZWhydVdXb090eTRhTitmZHBiNWRMWmlBNDdWeEpmY2VLUEZ6MEExVGZ0?=
 =?utf-8?B?MFFnMWFGNW9xZEo3ME5GUHlReWJzVDVKQ3JSUW9tRkZVVlNTRXRnTzhUeE5I?=
 =?utf-8?B?QlVxSnQ5YXk4UnN5NnRibHIxNGFQVnZGNEUvbDZiSVdaajl2QU9HM0cyeEVs?=
 =?utf-8?B?S2ZUZDV5aDlNTjhUcEEza2NGa1Y4Z0FMRnBtT2pqdS94UjBOdWNaRzFwT3Rx?=
 =?utf-8?B?K2hVbnp1a0RDN1RQMEtFZGdTbmxNbG9qYU9kdlJ2QThDNFhBU3hiTW5leXpN?=
 =?utf-8?B?dWJaRDV4QSsxaWtyV3BIZHhLZEdkK25KTXFoV3pGT3RDblF4T2VjWVRYWEd0?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3da3d9-f9ae-4658-eecb-08de05b5f03f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:26:51.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nasGTqC2Z37tOAhA9H3wMFYuiKKic98j9NRR9WfX5Xq9VXM1k6zLMQwlL6/xR5jQY0VA+0PWXTnU0+vx+un/LEZYm/GrZk+o0Pdre2rDSZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com

From: Eric Dumazet <edumazet@google.com>
Date: Mon,  6 Oct 2025 19:30:59 +0000

> While stress testing UDP senders on a host with expensive indirect
> calls, I found cpus processing TX completions where showing
> a very high cost (20%) in sock_wfree() due to
> CONFIG_MITIGATION_RETPOLINE=y.
> 
> Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0b5c0be99f8fb9d362b3730fa4eb0..c9c06f9a8d6085f8d0907b412e050a60c835a6e8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1136,7 +1136,9 @@ void skb_release_head_state(struct sk_buff *skb)
>  	skb_dst_drop(skb);
>  	if (skb->destructor) {
>  		DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> -		skb->destructor(skb);
> +		INDIRECT_CALL_3(skb->destructor,
> +				tcp_wfree, __sock_wfree, sock_wfree,
> +				skb);

Not sure, but maybe we could add generic XSk skb destructor here as
well? Or it's not that important as generic XSk is not the best way to
use XDP sockets?

Maciej, what do you think?

>  	}
>  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
>  	nf_conntrack_put(skb_nfct(skb));

Thanks,
Olek

