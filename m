Return-Path: <netdev+bounces-276185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA8IMoR+1Wmy6wcAu9opvQ
	(envelope-from <netdev+bounces-276185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:00:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 284143B52CD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BABFA300B9E0
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8D824679C;
	Tue,  7 Apr 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKhO4XoO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16C1D5ADE
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599233; cv=fail; b=AjCHgdkPmiqQ+i7bKdlMPH6OZmFjVVmu4zwUBLBZiL66eOaNcFQ1wWa+e/b1Za9BBwoyv0cJ/62MauWi8d4DGt5h4bW3cTa/Hi39PwVAIMVHano9MAfRewJe7BEkFbZ1I1Shc8cIgouy/RwnU5gNVBFDwi45kzF17/8uYcbgH04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599233; c=relaxed/simple;
	bh=ahEY3nZmAwT+pAL8T3HHQJZ8cnkHXxdvXSiQOTblJ+A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYcSuPSJrRx8HtiTKHUCUJvTFepynbV3+JITN5oe2YvTepAtvq22BAJAyJDKMUpBTJRMZf7k40O7NH5B95G1LP8R7n+Fil1w8qGZeAMgoa79ldlS1oMkun+zerwpYWsyb00g9JQq3Dc3QhC2z5KKbNvmNzzM0Bqc7AwHxEa29Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKhO4XoO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775599232; x=1807135232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ahEY3nZmAwT+pAL8T3HHQJZ8cnkHXxdvXSiQOTblJ+A=;
  b=YKhO4XoOEqfUVagOzQePRa8szgdVoshwTE6LndScibzkSec3pozmPzSa
   Cgxzbwe53GiJKcawkdxTUQPn4Ozw+B0/ajJ0fMUv0S0+EGSRXGiwCycTo
   zmE++S7rY49fpkKfV9SQnW/l54PaYmJhJtYHyDsdo+K/pnPggxBGSNjJC
   okZekmft3pouv/O+DtNL8LeOccj1NpxX7teNOURvqOt0sX7YuA+88zGYM
   XqYM6wLWOZCwywfOG6ld9sxiFTUnrmez14nLj/RRMbETpLractLKZ2O+1
   Hnzs6m417VEBvK6gBIfEKai+yaU9Dq4xm6PynG0AVlz8GAdHW/tySt1WE
   g==;
X-CSE-ConnectionGUID: R1CWRVrsThyKf4xoDHQSIw==
X-CSE-MsgGUID: a8PrRv1NTmav0jb+Xq5qCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76646031"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="76646031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:00:32 -0700
X-CSE-ConnectionGUID: /s62sk68QuyAWR7IBTdYXg==
X-CSE-MsgGUID: rlnAYhUwRBuGFMGpH+a8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="227272342"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 15:00:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 15:00:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 15:00:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 15:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhArOKtvU4YvB37iSrE1MxfjJVgk59ZJWdxjT2Fq+pO0KCQkZalFqq2dFMqe1R+8XRNINOaEqUhGuaHjfXtQFIQcpQ1zJ9P1lflTxmz3ck0jVG/FoOQQsXJ7ohItJbqJVAVaM/hzLRKGiGdtPN+QzEk1VOwTe7ljljvKyDmNiKU3c7HBYjm4tu/rhlP9s6c7xUuG8Q2kV63FITGQNKOJyzzXEnufPCswH3yM1gcfVnoE/21Sccmbyh7QIFZ2V5i1gHsSEeEc2WsC4jcYjfselkWCbAn/kkEnymN2pH8AbJqYVlNnmGOzwBy0ysBRPBZhhihRKpZMK/AsQV7JFJrrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceNxUauz/W4hl1LKUub1qkKswkL00MGvfSchkphdGFs=;
 b=ZF21COd/V9SyOaXLq8x5AKmmTQ8N5uU/tnhjQv7qWP2kMCjG1g+WlSIExxZBfir38z9r/1x4SlF80ZtV2sNgifHGXuhT8H2wJnVXoFPg04On+cHoi+nZYEi1rEeGVQ2kLsxI4M4M/4OvhsZ6iIpQWadsYnuCokK5OjYti3+ZhiiqZfsyh5ohiblvkiRBY+qv2qItaP7LVwz/w7txTRENi0WnUjOiZU87ighHQmAto3sZm6Lplg1vCXLol4akrRVcc8CRFEzVv1mQm+JQ8hwsyODIEnm2e7yFgzqiDS9QEOHxRLiWe9eRsEMms32g+hngL16DW7oIn6pq9ffIvS4zOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 22:00:26 +0000
Received: from CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee]) by CH0PR11MB8168.namprd11.prod.outlook.com
 ([fe80::9549:c8e9:6748:12ee%5]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 22:00:26 +0000
Message-ID: <626f3619-499d-458e-8536-2cc30984656d@intel.com>
Date: Tue, 7 Apr 2026 15:00:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix read_dev_clk_lock
 spinlock init in idpf_ptp_init()
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <aleksandr.loktionov@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <milena.olech@intel.com>,
	<jacob.e.keller@intel.com>, <konstantin.ilichev@intel.com>
References: <20260403153538.11516-1-emil.s.tantilov@intel.com>
 <20260407160241.470945-3-horms@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20260407160241.470945-3-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:303:85::29) To CH0PR11MB8168.namprd11.prod.outlook.com
 (2603:10b6:610:186::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8168:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f9aa69-49b8-4729-273f-08de94f11364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CfCrcWZuqym7NehE3EgANWV1OJemLSe5m7VLUbJBZyFUbkwlqH0N4vlrvqPac6WM6SgYtuavS29z5R4RLnMYYw9h8JF5OOblJI5k67k5p+755+rG9u7W0UKUK1abRUS+6GH797SRlNH8kJLwy1RgNcGZX+eHY9F5LKPt1Q3G75XVr2PrQb+vVdYntyv2BZQAvBDOTG5hA/jZWQm4XpNheaYbvf8p9Gjv+ZVtTRjtRtNp6GHj+uS7HmCThnLEdjiOgsRUf24aeMj54HWZNi2NZqJ3bk8IVtH6CEYcsQ72Ecuak8Z/JKfHckHgliCTYMscwKm+fFQAWFVFQaIH1IuX3PTxpUmNRVbTR5+0LZCxKJy8DWaO9rMQcF72mYCPrO4iakqZbC0Q1UcQRWM1k3xSFfybaAjfEPFitlNLvsvLXQEoIbn8dGtKUGNSewTUl0RlnEVJtUIIib66Jhnn/dLZ11ex6aiq08mswTlbWVtU/6UcEn5XJRM2R6GGoNIuq3E101DTOwHuwSeWx5KXBXE2sw1hB3CRNLvMH7oJKG5emWWS7RxTNqULjXQzLa5wzMayDGsyF0ocnZUhQpfSTkCSlIgc/xbOO/SGTM/JNyhf64IGkD6m81bkmDfFblu6Qj5DHDHo+XArtgcjwhamFu/K+STLnjkFjumanW0cwGXAZw0qlq+gZx+EV1/YoRQXPfYy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8168.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWVVdEdtVEpYOWtTNkVKaUVrQWcwbjIwVDNmdE8ySmtkNEdodTN6WitMUVpw?=
 =?utf-8?B?UjRvNC8xeE9QeWhmQ0lYWHJ1ZWNYR05jUHo1V2d4QjJzdjE4djFEdHJ6TDkx?=
 =?utf-8?B?eGszVTJsWExvT3orcmRyOC9JVmVOSHQ3UUlrWVgzVHlLMk9EOFYvNksrU0l3?=
 =?utf-8?B?WCtYc25JYkQyY2o5eUxCMWRNSTZVb01wYnBvRFhaRVE3dmFtUHh6SWpQTEoz?=
 =?utf-8?B?emwvTFM4SU1hSW54SmdUZ0hPTzlaaDQzUmRQZTZYWktvOWZjK0gvQVhyNFky?=
 =?utf-8?B?NTk1QklzenJGeEx2ZGlFSlZFdzVYNVB3aG5sNTRUL1RvQlBCeVJoYTY1RkF4?=
 =?utf-8?B?OENuU1gxK3RPTFYwd2E5Q1lUb1hTWC9WSGZxOWduU0tlcUE3RjNQWk55NERp?=
 =?utf-8?B?SWQ0V0dGaWFTb01OeE1ncWtUZVhKTnBQalJ5Qng1Z2c5Z0ZWcXE5UXpEOU1t?=
 =?utf-8?B?d1hpejNhdC9XS3QvcUdLeHVrTkZrQlY0eXBPTTNlbkxCVjJKL3pGN0lWdzJk?=
 =?utf-8?B?MGg0UUlKYXkxT3p6L2NQUzkxNzBRdWRDWkZUQ0JuUmRxU0JvV1lCZ2NVWkZZ?=
 =?utf-8?B?V1M2TWcySnl1WUhmMUhhYXF2QmV5MXFzSmxJUGdFNG96T2YwWG8weGFZOGJH?=
 =?utf-8?B?SVFIYWd3VmZRbkxHNHAycFdyQTEzc3NuT3pTU3labnpjMHM1V0JnQkZuRVRF?=
 =?utf-8?B?THNlb29EM3N4dXI2OWxRaVAxdnlRd1JRRFpKYmVDV0ZBWEpXSm9xam8zOVlr?=
 =?utf-8?B?M0VBK1VXblJhbkNRRkkvZm9lbUV0d3RRVEhHTnRVbk9uYzQ5Z2pZNjlzc2pR?=
 =?utf-8?B?cFVuaVVwMSt6K0wwamNJQ282MWFmT3dneEhTTzk3bXFNb3h1Zk9kYXJDQWdJ?=
 =?utf-8?B?S1lZWnZ1TEJEbmI1SDJGQXFCeitXY29FZDdaV3I0RU1xOUtYNU13NWtxM3Bw?=
 =?utf-8?B?ZFREWUJUZEs5d25KWFU5enhmZld4bE90YkdLWjdBeE9mc0RVaUhOSnoyV2ZZ?=
 =?utf-8?B?Rlp5QnRHOGE3ZlcvcUU4TXdSVDNQTlFUSGd3ZnFGMzRYdzFHMlJzbE54Z3py?=
 =?utf-8?B?Nlp0bk9OdzJTT3RPaW52MXIvMGdZYnoySTNDREtwWEJtenl3Z0IxT0R0NmQ0?=
 =?utf-8?B?Y0hyUExqTk52WmU5Ly9icklyMUszQkhWcXpBd1poNWdRTFdTTWN0eWlwYTNS?=
 =?utf-8?B?dHJXTXFaWFpaNWp5ZHVDY2J2OFZTaVdBdGdiTnhpTEM2YUxlcytkb1dISlBm?=
 =?utf-8?B?YU5JT2Z0ai9mdkdVVXN6TUtObTlnby9lajh3ZzF3MThyUlpnblpIK1BaZnRO?=
 =?utf-8?B?Ti9YWnI5WVo1UlBQNVhEN2Z6RmM4Y1pMc3JzUk83VURvcTY4b0RyS2J6QjFM?=
 =?utf-8?B?amJLNTNjRU1GM25wR1FyaTlsTkdzTGt3aG1BWS95OGNSaTZ1bDI5VWJqdnpZ?=
 =?utf-8?B?NWZXN0JYN3gyM2Y4ZzNxOW45a2ZtWmdXTmtBV1F0a29GbUF3NnpJeUE4b2V1?=
 =?utf-8?B?UEVYamxndnJWb1dlRERMOTdRaENGdExMbkR5T3NOQ085S1V3NjRMb29IYTBJ?=
 =?utf-8?B?L0pqaHpOVXY5RXVZeEJHTDRwdDdvQ296dy8rVVZzcWxTSHoyaS9nd2VTL1Zv?=
 =?utf-8?B?aC9WRTFEVGJRSlVPWGRBZVR5UU5QMjc5bXFNRExiOGJkUEVRUHllcEdjbHVG?=
 =?utf-8?B?Y29hcExMYmdVV3ErSFZvcUVPbi9KbGNJd0EzYVE5OFY1K00ydTNSM2ZYTmFT?=
 =?utf-8?B?MXNVb2pSNWtZZDVjN2M0YXI1ZnZGVVZHSHZDeVBPZmZSc3M5ZWlJb0tCWmpN?=
 =?utf-8?B?YnBUKzhtM1RJVUo2VzN1cENadUpmcGRZSDVjbzEyMEoxR2w3Tm9Bbit0NWh0?=
 =?utf-8?B?T2YwUFdNK2RUMGlIaDBsMU1PZDhINnVQQUFQZzlaSUJudmpQbWhyQVQ2RXNY?=
 =?utf-8?B?bEU5bXNWNlFzaGRVUUpuU01aWHBzSDA3Z3hWSFFvOEhwVTJDYm00RmZEdlAz?=
 =?utf-8?B?U0poZ1gwOVU2dU9pdHRWS0hLcllTdFZrUU0wK25YYVdzK0orUTF2MzRUOUJ2?=
 =?utf-8?B?QXFYdGR0enNQZ1l0NTFqOUxwSS9YOTlKdDBySSszbEVCZ2hwWDBKdStrbGhJ?=
 =?utf-8?B?SWp0V0doUjh3WDl2NUk1Y1JaeTlnS2NKWXVLR09WS2NNU0tvK1c5RWx4aGJR?=
 =?utf-8?B?clN4RGdqT2ZQS0lsU0U5cXBFMy9US0hhK0VJOVVnbHplTW51d1Q2VHF1NFRD?=
 =?utf-8?B?Ny9VNHI1MUFuelVJSFcrQW9obXl4Tkh6RCtQdEtOMkRGL0h6YU53TlhSSXBQ?=
 =?utf-8?B?aUVENzBiS25zVTl2ZUVmNHVyaEwvV1o3dExKbkNVWDVKRXRKSXZPWFVRUVla?=
 =?utf-8?Q?KqiyzSqo/nHirkIs=3D?=
X-Exchange-RoutingPolicyChecked: DCAEMo/cz/VcNGav0hRLjCQHsO/K05cq3B7+uRkemG9/OdJ87te+ReO8/nr7EaF5iD26/VE2HDJmeWFYKueyR5DF2TMrxSb+rLy9pJxvFpuGhp9wSpXf8qdiOE5+eCBSTtXiOEF/CnOBVVsI2FmDx0GoILVJDfeoAO57JS2rNleZxYON+egAyyj98hrgAG+vkRCv0d2O7cgSaYoqxas7Uq8CCzsBOetlAgWL+J62uO2UDlsj738G0si8gHiFX0Inxy70/lHNtCvwVb56gnJp6Z8fD34DLcSY81ZvIHxeQcgQhhCBv1xQwkHvbfu/xqRbw1l6eVnJS4QNcaeu+UQiWQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f9aa69-49b8-4729-273f-08de94f11364
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8168.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 22:00:26.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMage3fET9TlSrAoQxkJEg2eVMeQMxrTlSmSLmfUq2VtRWRVoAhOadOX7zwqOmrTptKROujcYn+HNKsVVNsGhDTkvWUKlNbuiYvhXwaSjyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276185-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 284143B52CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/7/2026 9:02 AM, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> 
> Simon says: I don't agree with the regression characterisation made by
> the AI review - I think this patch is good. But I do think the issues
> flagged by the AI review warrant investigation.

The point of the change is to resolve the use of uninitialized spinlock. 
The questions below appear to be generated around that code, which would
be out of scope for this patch, but I will address them anyway ...

> 
> ---
> idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
> 
> This commit moves the initialization of read_dev_clk_lock earlier in
> idpf_ptp_init() to ensure it is initialized before the PTP auxiliary
> worker is scheduled.
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>> index eec91c4f0a75a..4a51d2727547d 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
>> @@ -952,6 +952,8 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
>>   		goto free_ptp;
>>   	}
>>   
>> +	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
>> +
>>   	err = idpf_ptp_create_clock(adapter);
> 
> This patch moves the lock initialization to prevent the worker from accessing
> an uninitialized lock. However, idpf_ptp_create_clock() registers the PTP
> device, and shortly after, ptp_schedule_worker() is called. Both happen
> before the hardware clock baseline and initial time are set later in
> idpf_ptp_init().
> 
> Could this introduce a regression where userspace opens the PTP device and
> interacts with an uninitialized clock, or has its settings overwritten by
> the driver's delayed idpf_ptp_settime64() call?

If such an issue existed it would not be because of this change (see my
point above). There is a check in idpf_ptp_settime64() that should 
protect against this case:
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tree/drivers/net/ethernet/intel/idpf/idpf_ptp.c?h=dev-queue#n424

	access = adapter->ptp->set_dev_clk_time_access;
	if (access != IDPF_PTP_MAILBOX)
		return -EOPNOTSUPP;

basically, the initial time write will only happen when the capability
is actually set.

> 
> Additionally, could the scheduled worker read the uninitialized zero-time
> and overwrite the software cache after the main thread sets the real time?
> 
> Moving the device registration and worker scheduling to the very end of
> idpf_ptp_init() might resolve these races and naturally fix the lock
> initialization ordering.

I think this is a valid observation, but I am not sure it would be a
problem in practice, because the vport queues are not receiving at that
point. I can take a look in more details, but if a fix is needed, it 
will not be part of this patch.

> 
> Also, since this code manages worker synchronization, is there a regression
> when updating cached_phc_time and cached_phc_jiffies?
> 
> In idpf_ptp_update_cached_phctime(), these variables are updated
> sequentially using the WRITE_ONCE() macro.
> 
> Because this function can be executed concurrently by the PTP worker
> thread and ioctls, thread interleaving could result in an inconsistent
> state where one variable is from one thread and the other from another.
> 
> Readers like idpf_ptp_extend_ts() load these variables using plain C
> accesses without mutual exclusion or a seqlock.
> 
> Could this cause valid timestamps to be extended using an incorrect or
> outdated baseline, silently corrupting network timestamps?

Not sure why the AI went on the "regression" tangent here. I think it is
obvious none of these cases are regressions caused by the patch. That 
being said, I think this looks like a valid concern, but again, will be
addressed via separate patch if needed.

Thanks,
Emil

> 
> [ ... ]


