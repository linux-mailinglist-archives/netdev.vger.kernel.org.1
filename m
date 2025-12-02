Return-Path: <netdev+bounces-243146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B24C9A0BE
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 05:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEE664E1769
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B52F690C;
	Tue,  2 Dec 2025 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsLVNalz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEBF2F658E;
	Tue,  2 Dec 2025 04:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764651535; cv=fail; b=eVqSMMcwEZSwJ/eomI2HGRKsjZXqNWfz+RF57xB2ApBOTwx4JdiIeC0SVQqzO5eYCUXLlYK1wx7FOE2deMPqwvaSZc1VLGJZ14Pf+/xpilY/nUZLzZjODEgccFBrbElBW8rPU+ACMzfd7tSsKZFtE9B/dJnGavv8CMxFLOD1SII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764651535; c=relaxed/simple;
	bh=hsL1pwMZOzsN8Xn4ImL/O4igH4ShLZixMCo3+TYSfa8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=dFH5iXKw580GhyM9WmBEE38sJhU3MnAxeJhVdsq/pTqur8avliWEgCLVIedYWQg7ZljZQ6N1EVI1Z2JZqPLUWcpo1vYmF6HqVdis13E61MhdAQv1QuV8raprsRkiOwZcuBmM8CYuL9cbQ+wGMtabI2d799TxD+obY+pHt7b6/G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsLVNalz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764651534; x=1796187534;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hsL1pwMZOzsN8Xn4ImL/O4igH4ShLZixMCo3+TYSfa8=;
  b=DsLVNalzrc52uZWqhvebT+qDOrU0AXh/P63mrRYBi7KcFumaZHudDn6N
   7ombC9mv8GbLwQnO1Nuya4+f3Mc5l3+NUWcZMoIe0X+y0Ko/TPTfqTObF
   sY1Rb4uvgYZSgbHhRAMh2EMHQv4FvxvA0qzf162dVDex8qKK7w2KjThf7
   sR7IJRmNCqzIWwaJfHsBrLQAhcTd3XH+wepaPK8U7mD+MLa9aWUIYQUOO
   OuERsoc/l7qsN6sjAJFbcLRCRe82pSycMrbSDBya660Vs7lJSZQvoox5+
   jBDX+q8RySyCtHyWxUAWZSYFNMckI8kLwBjq/Qq+44ddK6eplZZ3Jf7BM
   A==;
X-CSE-ConnectionGUID: YrOd3CrfRIO+nAmJosaF9A==
X-CSE-MsgGUID: BFnXZ1w/QMOCZ3TEvbpDCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77706898"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="77706898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 20:58:52 -0800
X-CSE-ConnectionGUID: O4neNQayT+eMPjv4tFl3tw==
X-CSE-MsgGUID: 33eBLRCZREaq0ViKkuHVYg==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 20:58:52 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 20:58:50 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 20:58:50 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 20:58:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVO7hcNbeTuk1/Y0QFb6xtTpD+29DTVP6o01XTUOJ52DTcy9+MYlGQw0AihkRhNNhE1n0alN8nmIOwr0248RnFRyx6jSY/DOPMM1fgi6798Ws8wEMA6495dC7lTLR6w8qAmgkTQRm0M/tbjdVy2S+P95m35sl2WM+UZBOS6Y4xMfr18jFMu83eQ6P2kwJLYVnwok+Tta20zmfU18GxqUeTps6t7SbhIwalLNB/Sk8ghEJj047bCGqWqd3cCSNmcdfDncPBicaMSQIv05UhwKl/oqdO3alMVCIUbX7UkY+hrG9o4DCAoWy1lZ8wmufRY1ncJrII4akPxW7XmdjqXTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZo+k+b5OZlUyqqWpMnq83mhfsiSl/7/Y/i3otT7LBA=;
 b=pbod9sxOfEVM9K2/cDH6V/fJjNcX5CJk+AtrcciDslRKLSW6SLuSAMp8e3yWTAoaESlrmkj/4ThVI0duWqnpbuVmohzyloXhT3eJVPbggGtxAGPA+wFOUaxUEV48ZAUcV2CIBASeq7Pq6xBeiUYrtIcgxYHTGGHfB7IcxhPrry+uTk/2Otp/KdH3FupzwtW4HFA1QO6TvjwfWOMwyoojYyfP0cB9Uy5IUzLqQvhwnWqfpj1sTNqfUnF4DYSij2ppIr3uNpkgTxPlr1yO+CTlY5VRFZ/8ZtIUq2xUp8Ho7TyJnHeIiCwiJTc0N+eG3Oh8qdnSCAhaGIeN+bwUdGVT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Tue, 2 Dec
 2025 04:58:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 04:58:43 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 1 Dec 2025 20:58:41 -0800
To: <dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Message-ID: <692e7201b9ba6_261c1100b3@dwillia2-mobl4.notmuch>
In-Reply-To: <692e54808af8d_261c11001@dwillia2-mobl4.notmuch>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
 <692e54808af8d_261c11001@dwillia2-mobl4.notmuch>
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 09765821-c99b-45d9-fa6c-08de315f7786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ui90KzJMczE2a3VsUkNOYVl0dlhma2txSEJyY3BPRTFTQmkzRGhTeXFaakRo?=
 =?utf-8?B?aHNUUDIranRBalNpTWYrNGZWVVBKdkZLOHJBY2wycmdrbStwT1FKWUdlTUJL?=
 =?utf-8?B?aFdYZ1M1b0djTXRHa0NqeW16aDhVMXlSc2ZvNXZhZEgzcTJKT1FhQytlZmZX?=
 =?utf-8?B?R21JbkdhdXBhaGJpb3hDUStzWUl3aFAvR3B5TWdUdC9nWmVDbUFTNWw1bWtN?=
 =?utf-8?B?bnppSmVoYW5ucnJIOWRLWS9NUmRQL1VRQkRiK3VlK3J2Qit3NXYyNUhTZG1D?=
 =?utf-8?B?TURURWxiSWxHZXBuMW9zNDB1ZWxCbGtBa3g4UGZDYmtFVmFZOXB1WHppek11?=
 =?utf-8?B?YzF2RnpjWVZ3V2tZRzl2aUtKTGhaZUZjMW1hWDk0djhKb044SDhiWmR1ZkN3?=
 =?utf-8?B?Q1lWeWRLdWxBRDNwdnJ2TFhDTXhqQ0F2RUpZY2xSdkx4RXpxekdFenBVK08v?=
 =?utf-8?B?MVV3NWlZdGd3eXhhV1NITERzVEZTRWh4dmgwY0MrNFFNQWREUmhadll4aFZY?=
 =?utf-8?B?dVZITHZQV3FkaDFidGJhZ0R2MnFyYmtkanlNRTFnakNKQkM3Q0YwOVl6ajhB?=
 =?utf-8?B?R1lKWGd5SGdKY0dwOXJPTUZHZ3o4SkFMd2xmKzZyTzV6ZCthK1hUVFE2eUY0?=
 =?utf-8?B?aExKSjRoL3oxUkRjVElDdnhlWFZFRjFrOEdaQUJ4R1JIdVo5eEltOFpoamE0?=
 =?utf-8?B?RlNONVhsT2ljdG45ME9LZXFsYVVQeC95SnhpeitWcmlTUFNNNERCbmlKaWtY?=
 =?utf-8?B?eUV5RU1rZVZ6ZlR0Mm9saFFaQklnV09RNklNRHhsa25KSUR4V1hqZWNwVEE0?=
 =?utf-8?B?VDJvL2w4blpsaUxWRXRaanN2MFdqemlPSEd0dWNYbnVubDNyKzBZcS9BWEhJ?=
 =?utf-8?B?Z09PYUs5TFN1RkIrc1lBZEJ0cDMyaFBLQUE1NDlGSWwyL1NnMnplRWZyUkdS?=
 =?utf-8?B?RDR3QUNVTk80R04yT29DQ1NaWkQrWmpQMGgzTWp1MlpCdUJBZ0tpVC9CQXkv?=
 =?utf-8?B?VzVjRk1ibFdrQjlWUnlvdXlLb3NKVkxsNTVYRHJ2Wkd4TmduUW9jazVtTnlW?=
 =?utf-8?B?ZnNVQmltL3JrVEZ6Qms3cFFFNlcyQWJYVlltazlzOHRGREpFK2kxTGRMUlo5?=
 =?utf-8?B?S1c3SHBKTnZZUTIwcXRjTzZ4MnQ2OHRmaXNVb3F2SDJnZ0l4cDRoRkZxU0p0?=
 =?utf-8?B?YWFoMWZycFd3TzRuTDhUU2hoZnB0bWN4VlZjaUQxdDl6YmJaanNtUkxZY29i?=
 =?utf-8?B?SUZOUVloVjJ6ZjRBMGlkQzVLWldCbGx0cGhWTWlKNUZ3d09VRE1SNFJnUERJ?=
 =?utf-8?B?aDZEZ3RsaGs3WDVrbXlLVGNkU2NSc0lDMzFHL3NvcWwwN2ZWK014TXRNRVEv?=
 =?utf-8?B?b0tmWUQ3YXVZTkJydmNMWXJEbUFIamR0NkcwejI2Sm5sWHpHb3EwSk9yeG1Z?=
 =?utf-8?B?UUkxMkhROUpJNDRqaUs4MUZNTlprTURPenhMVVVnelVzK1BmWjRPTFl6cEtP?=
 =?utf-8?B?b3RON0dZK1NvbG5NWDVWc2FqaTF3ZCtrSG9kUE5DWTFkNmlpTkQ1Nng2dUtO?=
 =?utf-8?B?b0hEcCtpdUdLVEViZ3l2dzhORkpna2IwUVc3UHppbUJvdzB1WHpmZVZ5UDYv?=
 =?utf-8?B?UGpEcFVVLzROS1ZaOGZWWW5rWENsYjcyMGd1K0RNYk9QcDk0VUZqdGtqblpv?=
 =?utf-8?B?V2lZWGorQWkvWmdRR0dPVDVqejNieEtBVXM0Q2ZiWW1vUHdPWk0wV056Wncr?=
 =?utf-8?B?VFRqbTlmVVFPN1RsWjl2ZXlqaC9mem9aVCt1RDRXMXQvVytyTXFOUlBuOUF5?=
 =?utf-8?B?cGY4ZEh4MlFZVDRBeW5YWXNiakVFUkkyL1N6b05PSEdpSG9Ld1FPZGNVMjha?=
 =?utf-8?B?d2VCUFo0WEFhc1YwWlNLV25PMmk5NURuK1RLZ2xzdUVkMXoyVmdPMGNXWmNs?=
 =?utf-8?B?U1VxVEh4elRIWFJ1cXBiL2NkQlpwUDNQaUZyM2JSNGQ5am0yT1NzVW8yaG5Y?=
 =?utf-8?B?OVN1d28vZVdOdFh6ZVR2NUFla0ZlUTVUY243YUIzOWN1RGRudlJtaFU5Skh6?=
 =?utf-8?Q?eZjS8e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5sNzF3dXU0alRzNURNVDdyL1BPcEszVGM1bk10b3Z6TFFvNy84VFNvT1dt?=
 =?utf-8?B?NWFkMzJBU2MvRDBudkxBZVh4QnFrN241dWtMY3RxSmlDZVhXWUdLWlpGeDlm?=
 =?utf-8?B?akVPOGl6WCtuR01BWGxoaTZ6WU1hbkg1S1ZDVXRvSWJnR21QRm9xRy9hckpO?=
 =?utf-8?B?RUUwbHcvbGpGYkk3OW41Z1VJOUEwM1EyOXFYc3RVWGJhSUVoOWF6V2JEcFdv?=
 =?utf-8?B?V1dwZCsvaCtLR1VPZE9qWFlGNGFTWEJLVVVTK0R1QmdpMGpUS3ZMbks3ckI3?=
 =?utf-8?B?cFRQM01GTUtOZ1lwc25vUjJQWnJxNEFHMUYxMlpjMUp5OVQzV05uS2x1d0Ry?=
 =?utf-8?B?YXlYOEllUXFhNUdrdlZpVHNiRy8rL21VY3QrZUN2Z3FJYUhYakZGd3ljQzc4?=
 =?utf-8?B?dEFyYlVhcndIaS80ZTRYYVpQTGhyL0RpNHBwQVljN2hlT01YTTFFbTRuSW5K?=
 =?utf-8?B?YnhnbWcwL3lrYUxrYXc5aStqdGpWWTlUUDF0UEE5VDFudFU1U25yV3pTRVl3?=
 =?utf-8?B?SHZsRndBWmZDbGJIU3NZN0oyM2xRODhlVXZJaURSUklpZkRPbEJTV1QyNmgr?=
 =?utf-8?B?RXFabTNnMnBQdk1IOFZuM0pldmRsb1YvTERSS01MQjJUODZEb1lhZzJ6Yk5v?=
 =?utf-8?B?WHdlWkJPNDd2MW5IcUJDeGpkekdpOWFMalZuMjAzZ29sWS82S0I1S3p0bkM5?=
 =?utf-8?B?VnVvc01xZ3JueTIvZVlSSkppZ29sQ2VGRVdGYkplQjd0TlRyUCt3Z085STVK?=
 =?utf-8?B?UkxONzNuUDBlSndCZXdVWnFtNVhsckNTUnQxOHRNMHRycUQzVEhOODdBNDN0?=
 =?utf-8?B?c1lUTThjK1YvdzcwVUdMcjF2NmR0aWo4RkFZR1BwOFlyTTlOUEhJenpGWHZT?=
 =?utf-8?B?SWV5RHVKZjMzNGZYRU5vZ0M1eTMrSTNZWkF0RkRIbnFUQkJvdVB4UGl3Z2xC?=
 =?utf-8?B?SUFZNU44YjdjQUpLUW9MMjF5UWpqa3grT2wrL3pxZjRQMWQzcjcyQUJST2J0?=
 =?utf-8?B?WmRKVUc3dUZQMUhja1lrVENUWXdOM0cxclZnN2c4VCtRNDc1U05OVGpvTUNk?=
 =?utf-8?B?aUMrVGlXU1hhZ01WemNuYm1yZFVBTkgrbVh5Skw2VzFVSHg4WnFrc2VyRkF2?=
 =?utf-8?B?T1M0NnczbTFVR20xejlpTDIzR2VYalJEeWlwS0ZoLzZ1TlVjeTdCeXN3RUdN?=
 =?utf-8?B?RGxScmlyR3VYT3cxblJObDFLT1hpTUhoSEZUQ1RCV2t0cXAzTHdZcmtDcW9i?=
 =?utf-8?B?YXBJc3poeXhLM0JuTngvR1NYS09mUmF2VWxHSERobEhVQTZPR0V2MXlYRUw0?=
 =?utf-8?B?TFUxei9wWk5aOE42MExrcnoyMW14Mmo2WWpiYTMxSVlxUGVBV2t1YyszbDNr?=
 =?utf-8?B?d2pObTltdDZYMktvSkIzQXNNRGJYZHlUWGZWR3J6UjVsbDhCNERWV1R1WW5S?=
 =?utf-8?B?cktVZzYzWTlIMmNPSHlFRHRwUEpyVzVpM0FWUUppTEZKaXFJcEJrK2VJMk1L?=
 =?utf-8?B?aDUvcmIzQ2d6ZTZVU3A4WTAwMjh1LzhwdkZUTWRYdS9JcEVHL1dBWXNXQity?=
 =?utf-8?B?NlRyODM3dWNVL1dpcDMwMTJCRGZQMitEOWhYbTZpM2RpcC9jazBySDRNU1Uw?=
 =?utf-8?B?NktWKzBKeHo0Uy81KzRydXRXWTIxR0h0RWtqY3ZKMGhTKzhERHQxa3hIWkZ3?=
 =?utf-8?B?bHg1VUFEMld3czZnSVMvaml3dm92VjZURUxMK1l4ZGQvL09aaWVHbzJKaWpJ?=
 =?utf-8?B?aHorbDBxN3NRdEhYSGRBYmFka3dLa3ZZV1cwQVVwQVNTVXhMZHpCdWNJK1Ux?=
 =?utf-8?B?dnFlMHNqaC9tMUxreWQ5ZWg2ckhTWUJCczhKV2NaVkV4bzMvamlkbGNjR0Zj?=
 =?utf-8?B?Q2dSU2N1Nmg2eTlVMkg5TG9WMEJiUXVVR0lJUTBXbUN3TDR5SVR1VDJZZUY2?=
 =?utf-8?B?WFUwMmxoWDNzVitDRVU2SjRZOWk2VEViaTRYdXRoaGxyTVBXV2NBdkJFNEU2?=
 =?utf-8?B?UVhBREQ5MFlVNEpFY1pzTVdpVGd5aUY4cDN1YkQwN211N3RtMUZ1M2ptMFZo?=
 =?utf-8?B?QW9kb2tGaVNkYlplaGZKcXgyb3MwSVNjb0ZnNC9kbHNieTZZT2RITGxIRDhC?=
 =?utf-8?B?WG1Jclo1Sk1UNEoydThZOGhiaHZXMkV3L1lzdE9jallTZE1NYkJlcGlPL25L?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09765821-c99b-45d9-fa6c-08de315f7786
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 04:58:43.1701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GjQp7rXrMfiyVT93wQxPk+STbrhpyOIy0P8Mm4QzPd6dJC42WjeXpLkO1gdnRIB6WwSoT10QbwxxZajwEbS472ObcUJMbxrikDISyRL+U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
X-OriginatorOrg: intel.com

dan.j.williams@ wrote:
[..]
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index e370d733e440..8de19807ac7b 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/pci.h>
> >  #include <cxlmem.h>
> > +#include "private.h"
> >  #include "trace.h"
> >  #include "core.h"
> >  
> > @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
> >  
> >  static struct lock_class_key cxl_memdev_key;
> >  
> > -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> > -					   const struct file_operations *fops)
> > +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
> 
> Can you say more why Type-2 drivers need an "_or_reset()" export? If a
> Type-2 driver is calling devm_cxl_add_memdev() from its ->probe()
> routine, then just return on failure. Confused.

Oh is this replacing my "cxl/mem: Arrange for always-synchronous memdev
attach"? I see an _or_reset method in there too. So the description in
my changelog, that did not get carried over to this replacement patch,
is a Type-2 driver may want to fallback PCIe only operation and not rely
on probe failure to cleanup the aborted memdev setup.

...but really that quick and dirty patch from me was poor quality and
introduced bugs. Here is a much smaller version that achieves the same
result and drops the opportunity for new bugs. I will send this out
after rebasing that whole probe-order branch.

-- >8 --
From c41c535392ed3fcf203d754b8468a5ca91d83438 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 31 Jul 2025 14:15:05 -0700
Subject: [PATCH] cxl/mem: Arrange for always-synchronous memdev attach

In preparation for CXL accelerator drivers that have a hard dependency on
CXL capability initialization, arrange for the endpoint probe result to be
conveyed to the caller of devm_cxl_add_memdev().

As it stands cxl_pci does not care about the attach state of the cxl_memdev
because all generic memory expansion functionality can be handled by the
cxl_core. For accelerators, that driver needs to know perform driver
specific initialization if CXL is available, or exectute a fallback to PCIe
only operation.

By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
loading as one reason that a memdev may not be attached upon return from
devm_cxl_add_memdev().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig       |  2 +-
 drivers/cxl/cxlmem.h      |  2 ++
 drivers/cxl/core/memdev.c | 10 +++++++---
 drivers/cxl/mem.c         | 17 +++++++++++++++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..f1361ed6a0d4 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -22,6 +22,7 @@ if CXL_BUS
 config CXL_PCI
 	tristate "PCI manageability"
 	default CXL_BUS
+	select CXL_MEM
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
 	  PCI "memory controller" base class of devices. Device's identified by
@@ -89,7 +90,6 @@ config CXL_PMEM
 
 config CXL_MEM
 	tristate "CXL: Memory Expansion"
-	depends on CXL_PCI
 	default CXL_BUS
 	help
 	  The CXL.mem protocol allows a device to act as a provider of "System
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c12ab4fc9512..012e68acad34 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -95,6 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }
 
+struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
+					 struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 4dff7f44d908..7a4153e1c6a7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1050,8 +1050,12 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
-				       struct cxl_dev_state *cxlds)
+/*
+ * Core helper for devm_cxl_add_memdev() that wants to both create a device and
+ * assert to the caller that upon return cxl_mem::probe() has been invoked.
+ */
+struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
+					 struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
@@ -1093,7 +1097,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	put_device(dev);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
 
 static void sanitize_teardown_notifier(void *data)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..55883797ab2d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -201,6 +201,22 @@ static int cxl_mem_probe(struct device *dev)
 	return devm_add_action_or_reset(dev, enable_suspend, NULL);
 }
 
+/**
+ * devm_cxl_add_memdev - Add a CXL memory device
+ * @host: devres alloc/release context and parent for the memdev
+ * @cxlds: CXL device state to associate with the memdev
+ *
+ * Upon return the device will have had a chance to attach to the
+ * cxl_mem driver, but may fail if the CXL topology is not ready
+ * (hardware CXL link down, or software platform CXL root not attached)
+ */
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds)
+{
+	return __devm_cxl_add_memdev(host, cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
+
 static ssize_t trigger_poison_list_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t len)
@@ -248,6 +264,7 @@ static struct cxl_driver cxl_mem_driver = {
 	.probe = cxl_mem_probe,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_mem_groups,
 	},
 };
-- 
2.51.1

