Return-Path: <netdev+bounces-184896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7BA979F1
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88924189FC17
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F8270563;
	Tue, 22 Apr 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUtNTzjw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F21FECD4;
	Tue, 22 Apr 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359527; cv=fail; b=sLkMG6DXEaSkmWY3ALP8L4cI1VeF/5+iv/SusxRvWHDsToou0nlNw0W2IbOSRa1ikRAu/tVmx1DH0zhZM0U4RIyDY3RXr03VwvaTZhE1ysCTI95xoLnXGdXIXlmtnCguGcUbd9tw5aYGNTkrmZM9VYAEqGb/I0fxEX6NleXVBas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359527; c=relaxed/simple;
	bh=diZ3CRp9wiBGhpv5o59R2TFe3bz4ClsGXetlZ3oiKeg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kPOFJkwHKlrzZjAFLLyn3dXQmeC/d33sh16UnR1Hpd1QVBbAuyDXy5+qN1LEwGJAoIj3vscxi4S59dq/vsv9Y83pkf4DJCSZy65CxR1RmAa99OMb8e4gnYeS7FqdbxkOC6klfzUK2F4d8n5j+HfzQjbmEET5VZy6+1bmMkfByjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUtNTzjw; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745359525; x=1776895525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=diZ3CRp9wiBGhpv5o59R2TFe3bz4ClsGXetlZ3oiKeg=;
  b=BUtNTzjwpY2iaov0O2ksR1dlBmW/GeD3eO+pDRY0yJJttCv9cSDZMfjX
   3pmQsWIlPnL6BEYKZCtjLoPFFunDg7N1kBurl6PG9gUysOb+9a0omYaPv
   tN7vkeZxjulyRwhQGAb4wmTWw7OSoP3PsJPNufBC1I6Okld6WTX5GqGd6
   Rn4TtvQOTjY0sAlVQJbESejrn3qEWcY6sCWpEvdX3Y6zDEt81pRkDLndd
   bk0cmwKYvOWzm0VnAfN054rfWwzEdeOI1Suu7F0Vsw8yVCEGPH5XfQuTW
   s8UmhEvnjqzKjOfBrxXMVEFiatoGH90E1gHpAaitkyuNm7F5J0xv5s28J
   g==;
X-CSE-ConnectionGUID: qkkA5r98SfGmRWPraMGfmg==
X-CSE-MsgGUID: aUrkor2qSeuN7QZRkglD6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46950596"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46950596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:05:24 -0700
X-CSE-ConnectionGUID: Hv1QaWNUSLO+zUU/URUMyw==
X-CSE-MsgGUID: SgWXpb69TrmoW0xwQ2lD6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="133077085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 15:05:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 15:05:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 15:05:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 15:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ8cO5iwbeyqyPKkjbjdbVPjzuUx+nmOussqxYb478vQioY5YKN7W/ZbMS0OM6xhwtASnMw3aL96SdG5SvJeSuYSHhDmSP9kGAcokALMAZmtOMnI0/eZoTECpe73VNphUKtWKp7ATEX80ZCdzUdR5hdKQGUooj79M5oetPceCl0/FvE7diQwMXiS+kU7rA7M+RoOe7LNf8d+S8EPiNp01zQWm5OHSxcwt2n+uj9qpgKv32oR6uIrAU8/pdkByHuq89bUeMo1ZAQ8dvl8LMsHpi3Zammae8sclfk0RQcP8eY0WTWQGH4MRkdsM2+NPzHkAX+4qCulXNcW3487JTnYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDER4+gmUba6B7bzYsTbB4Is+gDLtr4hkdZhkmSHvsw=;
 b=NVAs8P+pzESVp9v0UzNNUUbMMGQ03GEOMXKbrH8M6ApwMSk2IjMP3qNQwfBVF2+b7ZNvv1RHBe+EFs569ES3IHXWPXv9e5NFtYpi1WInQs+LlsIvS3rpkQ2n3KCWoc9oLXQtJTloQ4hIBUI8kATgh/moPPg1R5L3PZ4FzCJC+XbsB8/QLgYEiW8TCrqn1Hub9Caz+YAVnXCdkedzfNJoFe8WRaXVXGmL7cqE5kYW4P7HbKF9F3EKqL17btMCepGl834mkO81AkZeoqYBfP3QtN5mWZBz/e6sIyMed/tEAjj6d4O8b4x/rCbITU84X+h5ryZ1XbFh/jGzYJTLsAjkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6272.namprd11.prod.outlook.com (2603:10b6:8:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 22:05:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 22:05:20 +0000
Message-ID: <74650d5d-167c-4d04-8412-5ffb39d4fc6a@intel.com>
Date: Tue, 22 Apr 2025 15:05:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] octeontx2-af: Remove unused
 rvu_npc_enable_bcast_entry
To: <linux@treblig.org>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
	<gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
	<sbhatta@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250420225810.171852-1-linux@treblig.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250420225810.171852-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6020e484-24ea-4c7e-39c7-08dd81e9c5f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHBvNVRXRjhENmZZeU5pV1V1QmFLbUQrc2FYOWMxczJEYTJObjFBbkNNakJ1?=
 =?utf-8?B?YUxCdXNPdUU3WjRkc3BCVERxNTRBUnpWQkR6MjYzdlUzMTg2aE9UY3VVZjVM?=
 =?utf-8?B?ZkM4Z1V1U3Uxc00yZmhtcGNERmM0Q0k4VTFqNXMrWTA5dGptOHBGSE9zL3Rx?=
 =?utf-8?B?NUhDVk4ySS8wM2hMSVJ1d1lLZGVwYXloeHcvWTNDc012OTRmdG9UcFdhNnhB?=
 =?utf-8?B?aE05ZEpEVWhDVGJid0pmb0UwblREKzRXMVVHai90dFdCdDFCNTU2c2duSVpB?=
 =?utf-8?B?QnVBZjRUdEMvdjNEOWFkS1NwclB6NzV3NGxQMFI3MjRJWURmVXJ4ZURicWdK?=
 =?utf-8?B?dmliQzVCbkc0WTRiVmJTRDdzL2lVUGdPbThaNlBBRnBoQ0NyR1kxVVRvb1Fi?=
 =?utf-8?B?VEg2VlBGb1lLTjFtaW01UEJyZXY3cTVLUWU5eFZTNXM5c05HYlY3UlZoNkFJ?=
 =?utf-8?B?QmF3V1hFbXM1T0hkYURWVzNMQU5Fb3dkQU9ocUYxeFVUSVI2cWZ6aVZzeFVm?=
 =?utf-8?B?aW41L0lVbmtMcnh1Zy81L1FwTE03RWZvT2o2T0dUbC9WR1RrTXM4WjVJS1VQ?=
 =?utf-8?B?RlROeGxvNW1ZTjFudCtNcVpZRDV1THl4bjA5Z1NYVFJqSE42RUVxbFVlRTBF?=
 =?utf-8?B?K1ZWVlljRmV2S1dIUE5EVXNCdnVBOExYZEFzZjZwM3ZGVUZTNTZSNkRpeGQy?=
 =?utf-8?B?Z284MklMTEtabnNncXlXcDQ4clJjWEIxUEpXa3M1T1VxVHgrZGdTQk1oREsy?=
 =?utf-8?B?NXZjZnJYNEc1UWVuMHJ6QUVrWHVLUjh5c1J4N2M4VlRyYS9JSHpkMnhjU3JF?=
 =?utf-8?B?L3k4OWdQWHdyclA0UVFiOWtVV2czMUorOTJpVlg1emFQWEREZk1HZ2tBdmZL?=
 =?utf-8?B?ekVJQjhpU0UzWHVBM2UwOTBjaEkxbzY4S1RNRzNBa1lwalhWSzBXTzNOcDlO?=
 =?utf-8?B?NVVORzlkTFE0elFiSzd1V1ZEc3lpSVRTMGJmaE5OWEp0MUFoN3ZDV2luZE51?=
 =?utf-8?B?dXFjK1JqYWQzZVB1ZmprSElSaXllcGxMdTFnbUVlUUVkd1YzZjc2QTgvSDdJ?=
 =?utf-8?B?UzFzVGJ2SmlMUkwxejVPcFZOVVhQV0ZRSnpVMkNRd1R1UDlrS0RNZExlQjdr?=
 =?utf-8?B?TkxTazNoTXlNQjM4TWFaQ2FmM04xUEFxb3J2WHZQOGxpWkZtQWhmSjlOb1VN?=
 =?utf-8?B?UDhLOHJvcGRpb2kyekEwcFMwRVIzaTJhNTNTanVHa3J3b2NpeVZEcEtVTG9V?=
 =?utf-8?B?QTlXQXlNb0pNVExBRnlsY2wrdm5sUHRjRy9OQUozaTJwcWo4L0FZUVRPYllZ?=
 =?utf-8?B?eGEraHUyOS85ZklVaWwrLzZTVlkzTGx1elRxVVdTWGM2TmNBTFdsTlY3akty?=
 =?utf-8?B?d1JOSFhmbzN4cGR3enloRUthRUwvYWJLbG4rbWdZV1RzOWFleGQ3S0lVUVNu?=
 =?utf-8?B?b1ZCek9CbXJDTytKWEFkb3JBZkN6YXl0U3JGUS90cGxONGwxcXBZdG4vanUx?=
 =?utf-8?B?ZmQ4SGFaMnp5dzF2R1F5OHcybkpEbnVRQWhZSHlwMkxQSEVwMUV5Q0JaNkJy?=
 =?utf-8?B?MEZBK0Y3T2x2WGVXaWV0Y2w5ZWJwQXJ6em5Gd296NlpaOURIUkFnMEZ0b21P?=
 =?utf-8?B?cmVqOVk3NGZMUC80bUZIdStOVFY5V1RCNWQwdnF4OTVXQ2dHbXpBZllMaEhO?=
 =?utf-8?B?Y0t3Y09rc0hBQmsxdGxjUEc0WHdGY1hlWFVEaDV6T2RPemRxUDlBeFVNakZW?=
 =?utf-8?B?MCtoOGFMYWxxYk9yQWpUZzAwUDJMOVZIdkhnbGx5dnhkR0RWU2xXTFJXcWNI?=
 =?utf-8?B?c1hyajVxRDVkdHBZK2tMcVpKbWJKTmxYUjh0VkFNZ2VURmRiOWFqRnJoZElT?=
 =?utf-8?B?VURtWGdXNXZ5Yi9iSjFPNUlUZ0VNYVJrbHF5NDV4V2dYWWNmSDhPT1dUKzlt?=
 =?utf-8?B?ZHlkbXFRQjFOemdydVpaRTE5ZDB2RTVTN0pENndURW5jYlo2eGc1cUJxa1do?=
 =?utf-8?B?VGRDZEtONTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lkTTZKTkhTWjZ2a0JPSHp4WDVhajRsa2FqQ3ZSMjQrbjFxaFBYRlBydEFw?=
 =?utf-8?B?NTllSTV1dlNaa0FMMGlnNFp0ZmVLSStXSTR1cmlrdytuclZ3Vml2eTdkTTc1?=
 =?utf-8?B?bmQ2RlBpcEhuUXAzMDRwS0tzWWdvUS85WTcxRGtOSnU2K2JzaGl2dHBhcEZL?=
 =?utf-8?B?Z05qL05Wc2RSZStPN05DSmUwbjJQNk9tb2tWc2NaeFdFTjJXVW9zVk5LZlRU?=
 =?utf-8?B?OE5mRzU1a1hsa2s4ci8xdTNLTllPWnJSY3RKaVI4SmtWRUp2eFBmVmlLK3BZ?=
 =?utf-8?B?SVVTR0NQc0hIOVpycSs5RHUveWVHN3YzYjh5M1RMektDUG03Tjd3bE1mQm9u?=
 =?utf-8?B?OEhhQTdUMHJXNW9qTGthbm5xL2Vsbnh1V0FNY3BXM0xobTgrMkJtalZ0RkxI?=
 =?utf-8?B?dzlNTXlQL3htUFV2RkVtSXBCeVppajNUVHBheFA1cUVzNmJYaGNUV2p0bkY3?=
 =?utf-8?B?c2xieTRZTUQreFl2bnY1aEtGeUM2WU94VVY2blVab1hQZHhwL3BPbVBpUTJ5?=
 =?utf-8?B?aW9ET1ZBdElzcGJBZGIxOENiTHBpVnk0SzB6RWRsRVA0N09Lc2F1aTdWdTV6?=
 =?utf-8?B?V1ZwdDdmZmZCbXVDS1ptV0F4NVlsaTkxUW1GRURsWWZkNUhBc3gzZVp0SkpC?=
 =?utf-8?B?RDdNbkprYmN3aENETHg2ck90K01WM254bWRpcUJtSERTS1NlOWtMMVlkT2Y1?=
 =?utf-8?B?em9WbnBoR3RwNUpZbmJ5T1hsSllWMktkZVdDV0RGUFJGa0F1cWdqdXdrb2JF?=
 =?utf-8?B?TWdwRjdZbVEyRGxwRm9Ua3JlVTM2aXdmM05UM3poVjljNG9tQ1IvNGFOZC9W?=
 =?utf-8?B?VXlpYXdDNUJCTUh5QjhVeXlKTGt0SS94VE5vaGlsdkUrNFRNVWovQmVTZ3RF?=
 =?utf-8?B?QUZlR2hKZ2Y2bUlxNlNlOVcvc0NlTVpFZktKT1JUT3g4c3ZqYm1UNHNEeS9D?=
 =?utf-8?B?bWgvQUhGZ2tFd0N3R2VmTEh1dEJuT3Z2VDhZcXhHWjNDYnQvZzU0OHBYd3V0?=
 =?utf-8?B?MUlMaG5mQzBmcHBKTXkwejlrQWsyaVU0RHZsdHFzQUJua29IajRqdGU1SXVu?=
 =?utf-8?B?MWdYTlkxQkFJbTRNY29JNVRDUEZjMzROM0lKT21IZngvYUM3eDVkYkhlTUFs?=
 =?utf-8?B?WWxpZVQ2bHhoR3JHUGxrYlhKYk1jdWgzTGY0a1Bzcjc5aGxzU2djMFoxZEEr?=
 =?utf-8?B?WnhOazVFRUdzM2R0ejhDNHIzZnpBOUNKaUVQeGFuU0pjTWFaMmdyZnJQNDlP?=
 =?utf-8?B?cCszcWRGVU9OZFBzSW1CVHBTU3o1Q3VPOGphc3M5UUVJbTBjR0FZaTZ6cVQr?=
 =?utf-8?B?YlB5cXRabGVQSkVwRVNRYlpXM25VVWc4NC85OEFtQkhuVXNIZDM4UjRhcGtm?=
 =?utf-8?B?Z3JXZmduRzNwcGNLQnN3ejNjNHRpTVd4Vk9IYkJDOHJJRVlQVE9iUVM0aTY1?=
 =?utf-8?B?Qk1BSXdiK3Ezak9qMk1EdHMzRHRESkl4Wk84alo3RWxVS2xMNmxHdmFMYTAy?=
 =?utf-8?B?NThUSUlpK2x6RC94MjhZQXFING5WZ1FvWlhEWTlmQ3ovU0Y5ZTdSYnlZeU5p?=
 =?utf-8?B?RmZMZlBoMDZMc0JGR2UrS2RvZGhoQngyTG5kSHVMTWtLOHhJSzcrRFdUZ2JF?=
 =?utf-8?B?eGZjekkrbWZjM1Y4SjZRNlVnREEwSXpEWTNtOFBWZmhPYlBKRU02VXN0OU5i?=
 =?utf-8?B?cWl3UEhSYzhNbWxmVGpacm03bW9yeDhkazNRRlFDeHlHTmhJdFIyK1FvQnZR?=
 =?utf-8?B?UXQ4ZnZJejBOblFNNlVIRzhHTVdmTlluaGxWeHpTM1QrWjRNVStRYnhYUDF2?=
 =?utf-8?B?cFRmbEJSOXlOaDhUWGhtRWpCOVZoWVNvbE54MWhGL1M0ZG5hWEZJVVFuTXNY?=
 =?utf-8?B?Zmgwam5Rak1zckl3dW1DaVFmVHQzMG5qbmhWS0QxZjdmcysvVzRiWW1pMERr?=
 =?utf-8?B?THhhU3I5VThIUDR4NlZ2bFNyTWNUT2xQN0tGYVJrd3luYjA2VDF5bmJwVm01?=
 =?utf-8?B?NzJDVGFRNklOQU9LRzRxWWlsWXFFWUpkWngxckZpeE1IWnNCUGh3clhwVFpL?=
 =?utf-8?B?d1draVNscWNYbHFQTmhXbkZabjY1RGNZTXh1Y0MrbFNGbi9CNHMzK2s1RmhT?=
 =?utf-8?B?R0FTYXVqUFBXWFhIVTRDS1c5ejBPdW9Od0V4VWdhQXdRczhsc0hmVE5vYVMw?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6020e484-24ea-4c7e-39c7-08dd81e9c5f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 22:05:20.5943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlSrHiohyhuoRqcEDyH3NQbvBF+8/p0s25OCGp46w/LRIh9g3lvdp0aurgFSELjIGKiTwTHDVWeisUHD4CZ2mL97rA6I1JMQj+jGtxI9nyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6272
X-OriginatorOrg: intel.com



On 4/20/2025 3:58 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of rvu_npc_enable_bcast_entry() was removed in 2021 by
> commit 967db3529eca ("octeontx2-af: add support for multicast/promisc
> packet replication feature")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/marvell/octeontx2/af/rvu.h    |  2 --
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c    | 18 ------------------
>  2 files changed, 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 60f085b00a8c..147d7f5c1fcc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -969,8 +969,6 @@ void rvu_npc_enable_promisc_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>  				  bool enable);
>  void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
>  				       int nixlf, u64 chan);
> -void rvu_npc_enable_bcast_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
> -				bool enable);
>  void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>  				    u64 chan);
>  void rvu_npc_enable_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 821fe242f821..6296a3cdabbb 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -820,24 +820,6 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
>  	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
>  }
>  
> -void rvu_npc_enable_bcast_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
> -				bool enable)
> -{

Its a bit odd since that commit also updated the signature of this
function adding the nixlf parameter, but indeed it didn't add any
callers to the function.

> -	struct npc_mcam *mcam = &rvu->hw->mcam;
> -	int blkaddr, index;
> -
> -	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> -	if (blkaddr < 0)
> -		return;
> -
> -	/* Get 'pcifunc' of PF device */
> -	pcifunc = pcifunc & ~RVU_PFVF_FUNC_MASK;
> -
> -	index = npc_get_nixlf_mcam_index(mcam, pcifunc, nixlf,
> -					 NIXLF_BCAST_ENTRY);
> -	npc_enable_mcam_entry(rvu, mcam, blkaddr, index, enable);
> -}
> -
>  void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
>  				    u64 chan)
>  {


