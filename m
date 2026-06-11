Return-Path: <netdev+bounces-298162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iJXHFuzJKmohxAMAu9opvQ
	(envelope-from <netdev+bounces-298162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:45:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4A672CE8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:44:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=A2xF1I73;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298162-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A1433419477
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033A2C0F91;
	Thu, 11 Jun 2026 14:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738336A36D;
	Thu, 11 Jun 2026 14:43:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781189030; cv=fail; b=SeqcSL7kT4RcPH8/itMj0f7Tnqk0IKvpwxzA4gMEcCK1j6sWg+I1+29dYVHzzIB51kLjvGXQMjPCUfZ1gAHNrHYWKwEHb1E0cEn5hfmqulMXE7t0X/1B3XrgVG6EMGy65lPmzQD6/j8zOruBdgooHdMNZjN9JwMD7GMaQy0Q0s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781189030; c=relaxed/simple;
	bh=HTArS2+ldyybWheSawe2OifL4/R0FFna/UGl36WSkMw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uly1yk/p/JmjW7CvnzK5G0ebVJlIKvHo35t+YJqq+cmOn3o5aBGRjt8mdNb2TTGCk62queLXpYla0htM2XhSdDakejFdmRpG7WYLLtsWTBAQW5cZmIWh6+VDBqFoV5FTxOxGm+l1gbw16eFHEaMgqTov/60U/t0xPDkiuSx3OXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2xF1I73; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781189029; x=1812725029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HTArS2+ldyybWheSawe2OifL4/R0FFna/UGl36WSkMw=;
  b=A2xF1I73R/3ep2+wok5xxaVgF41oiRKToZQ6qbSueULYOPBACawlqpLF
   A+U9IqjWhULewzxpHJZwU+BVZ2+LsrqVTiXF+5/b3EtT4e/eFnurknWJn
   np5tGyUiE+XAwBkyyX/UOOuk0G1/PhivBW7glqTwfdBFWz4fP0lTUNa4X
   zXZSpoApr+ioD7rVQiWa2RT5JW4Q+1ECl8lREugQaESjhasVvYLgUC4qT
   svbTLYYqNzhV1i8b7y09WrvsUS9Uxfw1XfXhfW7VqRjK3S8G9byqiqwf/
   c8nleWcJ85nFJNnXH16lNe0Mmse5iilUpco59Ql1jU5UuX7uoPT2YqXDT
   w==;
X-CSE-ConnectionGUID: z+2nogQJSgmPqv+PP6G3ew==
X-CSE-MsgGUID: M5gH2oNJQWWuuxhJOuc6QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81910261"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81910261"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:43:48 -0700
X-CSE-ConnectionGUID: YJ/RTyXqQa6UeHWpznTTYA==
X-CSE-MsgGUID: rgfxVifNReeLwD2sdtNiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="244056916"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 07:43:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 07:43:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 07:43:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 07:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9u6OlsxD1FJ5cTvooRDe4IdZqNuJGDOVldMVgifpPTCXQmChipa1xuN1pJDSSswAisUIBMgnqsqnNYBupc3odmFjKq+0Hz9XoQvh+gHgmxNOX3VutRAxXjdlUuLW589PkHGqWW+0qlL0bymx4ryVBUaT/8kmhTQybIOiaStD4tNNpb/GvkKAwCc48W5fTBUOnw99V2zowKAivy2+eqslKVYVAzRz2bH45mgOYmQZwXpg52s3rJa+TN1WI5VdhKBGpa5wDuT9c7J55I3anGg5azMKSnv9gysmjunqQFQ1TAZczlBToaqVhDB9GNRtM5aTbM1l9Km0WGY2nfXI6tmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh4sTZjmEpe0A/7qidYtHitlMo0VSlpsa0b36lC9zfY=;
 b=kDvlseDrBGJ9LzEcKd4VdAr2T/KYvM+qtFEVcfSxaNB69F6abeWos2Hsjl+V3HSi/XLi+LUOAxkfry/UrSpFNCTCt7HwdaTH2bu9447ZhIXBrUBr5Q167WUL0iyT4JoRbTPr6ZVa8002S/XWGEk3Bb4QNKOkAaEUKV2ly5JwoRk9QsHPeWPVDwCFkRhW1HMI5XJ5//HwAeN1zWidqrLZCmU+W6aAS+gBLKFnLTt2vQcsAPXNJdRXkNUUzNAaM6NycqYIO0ss0OQlWeVo3v8NBV6oXvVoIS2QLzOebK/946gu1RyqpomZKSYa4o2rs689hC0TPSXzvyVb9Gke+nLfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7871.namprd11.prod.outlook.com (2603:10b6:208:3f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 14:43:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 14:43:43 +0000
Message-ID: <87970282-ba77-499b-a062-0ce8897a5a9e@intel.com>
Date: Thu, 11 Jun 2026 16:43:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: pfcp: allocate per-cpu tstats for PFCP
 netdevs
To: Samuel Moelius <sam.moelius@trailofbits.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	Simon Horman <horms@kernel.org>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260609232244.1602027.c569f6c530f6.pfcp-missing-tstats-link-create-oops@trailofbits.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260609232244.1602027.c569f6c530f6.pfcp-missing-tstats-link-create-oops@trailofbits.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::30) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 5666c2e6-07ca-4458-dac4-08dec7c7d605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: I/0D1LkF1rB0Mi8O3RiUKfvrEvvygugK9IU5/KRV9qrGh7MqXogAis0UPtyVM0MUk6/3ZbqP938ZJ9sEc70xVKz6/7nTMrBCj+Yzrb9DCJts6tx7273A2rh0Jg03pRthUAF3+/JJm2GUssg0pqtjiPBxDgqcUBJb2fKpUR97KYCsRP3zGuUhk3UQE4P8nt3AgGznDQcxN0A7HpgMEqzI4xf9OReE1zFoP3OE8Hk01HU5gpak4jneBv8ixV0spj4NNoeF7WWsJ0fdNZPajVdA6pem1dS0ZWOon+bUfXHFV59OUT12fOw0dqsIifBDXJKFwDqCOmmCSVxpTYP3FT5hYYr58WubVH9qbyP8ZfTzF2C+pgMDk4XzkPube2X8b7pTUNs69MvZ15g7MGowSpZfNQwmRO8A2UOd3q6kxpby8skffTtSydwMvojoIxed5idmlBvx0kaIkZk3vVhfE27yTThhy1p92LVV6wycJobVSHtpb1fQD/91/cbuLyjDryDIgs/KgaPAEBwRQkcE9BhgNuNK5L4w43+1jpXl7HGmxVYCJzZhxAKrW4/pErLRg4lTBhGhZRdDqQoD/D/+gumcgUTiRp9lY6Vnz+Tc/aT/K/UHuyou3dKU6RmKmhm8pIQjy4SeUVHHQaPwnHNH4Z7+u176WududeUtnjflBEB/u830c9/Vt/tlaq5nRUqSKLyt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODcwUVZpRlR3Ky9tdmhpbytFMEpLd3V3dXJBTTE5RDU3ZHBkMWorVmgzZ3FN?=
 =?utf-8?B?c1JrUXh3RjJ0d1RqUktlVm52K3FvaFB0V3ZkVTIyRnB4ekhKZXp0NDZRUEs5?=
 =?utf-8?B?ajR3NGVIOXZyQ3M4azhmS1RTR0s4RzdJbWhlcFJEbllSejZmbjVlOTF5TkdV?=
 =?utf-8?B?TWJBNXJ0b2Zyakx5M04wczdhZHYxSVlvWE45YmJjRlZITmxlYlJHeW1JZW5R?=
 =?utf-8?B?eCtkQmZaM0dsTUVOcjNhYjV0TWI3VEZnOElxcXV4cVlFZ3FXSmphWjZlelVx?=
 =?utf-8?B?YjNvVTFQcnc1a3ZlVlBsc3FCWEtQcVlVUUVCaFVZNVp2OTM0cTZxdGNMdEd5?=
 =?utf-8?B?d21JaTl2SmFkbzN1VjRodmkrNzlwNmhtTGdEbWdSNUtyUEZ2eEtsWVdtY29G?=
 =?utf-8?B?eTlmazUyb3QxeUd4NlVhY2N3Szc5dFhlRWlsK1BCKzU1ZmY4Y05EMVFiTXBx?=
 =?utf-8?B?ZjBQaGM0bVArcWVGbGxOdnpkK3ZqdzRpd2F3eUpsamZRSjFBTHQ3WmxnWTJm?=
 =?utf-8?B?RmIzekVYSVFXNERSc2JTRTFhTzZpbkkrSGREb3krOU9COVB0eVJDdnBmbkdz?=
 =?utf-8?B?YmRHWC9naWJTRFFWb2t2RytIZDN2S3o0d1FqQjhUMnpEaXVyNEVsSUYwTVlU?=
 =?utf-8?B?K1h2MmZIMDd2YmR1K2ZLY01GQ0lDR2lMT0gxUUlNd0dNRlZZdDBFYTBudEhE?=
 =?utf-8?B?WVZwUmlHdVIrYjBTUmZycWhESjNqcFFGK0JVNkxYTjlOUzlOWmxrcXpjTUda?=
 =?utf-8?B?UG1HMzZPTkluNjhkM3hlTUk2SEZxRlhaQWJhTDVLM0Y1dXNyMzVtdVJ3SWJ0?=
 =?utf-8?B?M3F6dGhKMzVDaHhzZWZmaDdnY1NOQW1yR0JOT2dVU1hZbks3Y2l2eVc0OWVp?=
 =?utf-8?B?bDRyWi9lY3pRSmdVNDdWN0Jzd0FBYlhYc3dQNTVMZWNMWmg1VEpPem1rb2xJ?=
 =?utf-8?B?NjFBYTdlTUpzYlR3cnlBS1VMYzFQSG9sYktSdzFwU0p4akhzVlA0dEZ3azE1?=
 =?utf-8?B?ZXpPa252ZzVpSDVCL2pxOHdRR29xVmsyVFEwR2xhclprL1hkZGZFaXMybkVW?=
 =?utf-8?B?SXpiOUVIdHUybUxkb09rMGcvYTduMUxEYnJkbjk3aEM2ZzNuR05HcU85MG44?=
 =?utf-8?B?eU84QW9TUHZLYkdnSUU1NGZiNWNGUEM1YmFkUytGcUM1ekllZW1DMTJWbmZ5?=
 =?utf-8?B?M0c1Y2YvRW9IRC80NXJvWVpnSEhXaFBNUHIwdldEcXFYbnM0bWNkclJzQWZj?=
 =?utf-8?B?cWN4MEViRTdVcENJY3llZkp4YytRV0M0Mm11QnZMcjhlQXAwdzdGVkFPeFhm?=
 =?utf-8?B?RGg2TzlkUGxSVDhCZkFSVHBDcEcvdWRtKzJOR1FkSmlBN0VpOGpYcG9GaXpi?=
 =?utf-8?B?Q1ZLZFBDcVdHeFp2QUIvZ1VYckgwakV2bmIrRi9NTmgrNWU5NXdBRDI0NnpQ?=
 =?utf-8?B?ZEQwQ0VEa0FtaUwxNFNnYlRvZWVxZy91cGtOUnJSTlZhSytkcVU5U0ZzQUVL?=
 =?utf-8?B?Ym16QnRMa0lEZmsvQXRibkVUaDBSNFptR1p2TlBWWWxVM0o1S0VUSFVrdXdw?=
 =?utf-8?B?ZkNERUd5aVpPTDBIbExRVE5IbU5IOFBhTjFIR3VSZGo0K0cvMzR3aE1Gd0hz?=
 =?utf-8?B?bXVlRzhQa1M3S1U3b2M4Q0F4ZUE5SU5zeVp6dzl6dnRNdDJPMDRCcytBNnpE?=
 =?utf-8?B?SWZZanlGZTNURUIzSkkwNWs1U1FVRVhmZUdhV3poRERlVnFvQUJJblBWdmdC?=
 =?utf-8?B?dzhNMVdkTkE5cFNsUWNURW44VWhLU0xnMHNxdjVFY29NejM4MVRxVjljcGh1?=
 =?utf-8?B?VmxmRXVOZUl5QkhoTk9DUUNHTE1leVVhdWxNVmUrWkxYTTZhdU14NTVtNG80?=
 =?utf-8?B?a3pBZFh5RDlZeHRxVGtCZU8rK3VlMWlmUEgrK1EwdXdmUFZyK3cxajU2YUM2?=
 =?utf-8?B?TTN1THNxeHBRMUJlNnUzeHExL0NEbkRzTjdwRGFPQXhWK1JuN3h3YTFZWWVG?=
 =?utf-8?B?cmRGclMzRFIvZVRhbzhoc1dya2lLRU5Oa21yeWNZYzgyU1hXNXRrUDV4YkVI?=
 =?utf-8?B?WGwwZldqM01qSVl3SFowaTB3eEZIdzhsZm5jamJFUUxGaldXM1ljcG5zR0RV?=
 =?utf-8?B?cE4vcWMrSE9CS1lkRWJyalk1MXJXV0xVbVVQQ2JWZ1c2MDMvQU41OWlsSGNt?=
 =?utf-8?B?ZXc4NnRscG1ObWtLN3NDWmE4aFZlcVkxYi9Gd0lPSk9HVXJJUDZOVGI5cFJ6?=
 =?utf-8?B?eitzK05YZWU5RTRBblFBQithMTZUWUxERFMvbjd4RE5xM21GWTB3UGtxQllv?=
 =?utf-8?B?R1BXbTBXYSt0RlM4OCs4Rk03dk1GZ3RnWjU4QVFmODZCaitiWGRUUWdtZVVW?=
 =?utf-8?Q?+kVpthaYO5P2t614=3D?=
X-Exchange-RoutingPolicyChecked: MhAdIAgZgoSaK9+vlqWqYTUuTpUeGVeL0hJRgMDkniOpt6zDcsH75NK06StjusAk5Rfv0Js+M9E03k/yKDxvH7xslCak20M4K2PjORxNEQWxlDicGN3Sk0/ucq2l8jvybcW+vPALEJpRGZPICBGgXjI6Xoee+QomuA6LayqU1m5fy6CKdFHX7HQH8J4DUJMrsRzZ0sabUSgcZnrg810wRrnC/DCMa9dOTzUNsjnXSh0/5JD1vGwsnx85SPOF25ZgUtYvHxxYkC54gE5prfP+8oOPt/PLtXEvKaY+/6XNn4Yy+Pc/bE5SFGkligowxEdKsBaGX3xBAbI/nm3h75N9aQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666c2e6-07ca-4458-dac4-08dec7c7d605
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:43:43.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fi/8ORRijY9a2yBrZNeK3iNsnPCqdXa0tvZm42JRAbEvmZuuZfmndGGP3WaGzAF5LsaSOITowUUy5pJzHobrndONgYQBCQD2ltBoNJ3Ucg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7871
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wojciech.drewek@intel.com,m:marcin.szycik@linux.intel.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298162-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trailofbits.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABF4A672CE8

From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue,  9 Jun 2026 23:22:45 +0000

> PFCP uses dev_get_tstats64() as its ndo_get_stats64 callback, but
> pfcp_link_setup() does not request NETDEV_PCPU_STAT_TSTATS.  The net
> core therefore leaves dev->tstats NULL for PFCP devices.
> 
> Creating a PFCP rtnetlink device can immediately ask the new netdev for
> stats while building the RTM_NEWLINK notification.  That reaches
> dev_get_tstats64() and dereferences the NULL dev->tstats pointer.
> 
> Set pcpu_stat_type to NETDEV_PCPU_STAT_TSTATS during PFCP link setup so
> the net core allocates the storage expected by dev_get_tstats64().
> 
> Fixes: 76c8764ef36a ("pfcp: add PFCP module")
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> Changes in v2:
>   - Added fixes tag
> 
>  drivers/net/pfcp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
> index 28e6bc4a1f14..a6aa30ae0af7 100644
> --- a/drivers/net/pfcp.c
> +++ b/drivers/net/pfcp.c
> @@ -148,6 +148,7 @@ static void pfcp_link_setup(struct net_device *dev)
>  	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
>  	dev->priv_flags |= IFF_NO_QUEUE;
>  
> +	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>  	netif_keep_dst(dev);
>  }

Thanks,
Olek

