Return-Path: <netdev+bounces-188438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C175CAACD74
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3767A5D0F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31193221708;
	Tue,  6 May 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQdZHu/a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3771CAA4
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557127; cv=fail; b=EWTJYGZvGOqOlkA9cFDlJ8nalglhn0vfpy6YcnXlgQtff+I28RieYkbPZoxbkdPJL82AhWOe+PJxFEGhT/nIiMsNPNEuAvBXl+IHCK35F4QqK8gHi/A8kP0iOd1QM7LEyOPLltr9fuyNIcvE3x+tWwhSqcKjecMxuvxNYp3s7as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557127; c=relaxed/simple;
	bh=ITPVev6lu8zZlJ7S2qX95yQharBqF3cg9AedGcFGMO8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ywws/4xSBegQpQFxguDrJFyeUNpY2U8O32PChvvw0sjbTDyJy2/f6dce7g+pgbPNJFhUFHskpHmSw99eTZfSXzfwbrkm/b19VgNgnhJJVZ0biEswcIGo1ZYog82LwOwx5Wj5cMu8BLPHGQtCo6VnMNKXUcli2lTUH/ZQJ3FJDvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQdZHu/a; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746557125; x=1778093125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ITPVev6lu8zZlJ7S2qX95yQharBqF3cg9AedGcFGMO8=;
  b=bQdZHu/aF9RYztjcrFhVACsBUyoOC+iVrggz1IHTGPo3t1APlMK7fHQz
   ELMzKFbaI7el67Sl/eitMo8OTPcewfRqdQ4mafqpdvbg+o/yqBD3CF6m/
   WnIqgojacLkSjfBA+n//xuZaUPv95rPMBuap4ZmcMeMvoSgxVb3s8F0Gn
   C6UyFxlXaSzs1M6zoh9iAuC46iba5YpiDefC9sIkchgvOaDD0lkO2NZUz
   mrFssFxCtgcUWlBpZ7t7q2m/P6rd4yyX4ERFGSQT19NlGcEQesl0TQN9x
   zr3z2D+pMJ8bWB9gUsNZwJapB1tIbQAuAdSDckFKe0DQUS4GrsX9lfBvm
   A==;
X-CSE-ConnectionGUID: 1bh4QRC6SRKUr4lkgxffOw==
X-CSE-MsgGUID: WQPTqX2DQjSvxLP66fc6TQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59608854"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="59608854"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:45:24 -0700
X-CSE-ConnectionGUID: zfVDnDefS4inryeQvRFuqQ==
X-CSE-MsgGUID: NKf7wDSSToKlaGT9ngUitA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="166751253"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 11:45:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 11:45:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 11:45:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 11:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP4osCKmzhukiQLXZoVg/L58mGKv8+euZ6qWhG5xKtie62b8s2bBZf2wc/zhF3bCVLZg8TqmPpCdeeCwi2cmhItBScit5FPPQC3BBM71pY3WGBWPJeuJ8J3OYE374zM3378QbZ96Xr12ssnI6JqzVus5P+nuN/EbXS3GgIHbSk3HaQsZcXx5XwRQxUNxfkvGhQxh1XtinfpexLQNEn+m6ltPRt17auxTRrplcmhfJExVzHtPLCgLk4dXp2zfBuDEDNeTGvpW26czfV4I52BnG92Tf8n7ZpZMyq3CVH0CbAYvWprCnoSWh26BQfASf/VNUz8RltGXljpUbBHF+bjhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDUzX/55uMW8gPBFdwPeM4JljBlwQadykdnoEuB8ZPY=;
 b=vGsyPcM3V63bq9olF2HREkdOswahyZkTnvI8H5evu0XCXj+WupPhk+3nkr5x2x07Zo6gbuWOZfn2V8ZfRYnTNkUaC3S8KGSYQpTIz3PI+u1/F4uh33VFBhfAwFnkmoXqU0a50kADRZiY7smrk5JzhJ3YtJfrSLR/eHHSYnkvzYYlqoyBdQK/8MRIPFLTOTaSziF+7XW3AQ5cDDNDmbDjQJjRDj6iIVq98AkjaA72YeBqYs4GfVQZP4YNqwJH37dbUjfid3CvHViIYq94nRntvsPeQ4LJqazFdo3a77/fmReihtp8rsmgwQua03SkHka0BFFo6iOfpCzcU2mm6I6Ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 18:45:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 18:45:16 +0000
Message-ID: <56e10559-9532-496c-af79-1ab4c8a8c8cc@intel.com>
Date: Tue, 6 May 2025 11:45:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2 2/8] fbnic: Gate AXI read/write enabling on FW
 mailbox
To: Alexander Duyck <alexander.duyck@gmail.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
References: <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
 <174654718623.499179.7445197308109347982.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <174654718623.499179.7445197308109347982.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a4a07c5-8941-477d-4f3f-08dd8cce24d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ry9Ed1YwdklMRVA3Y0w2MmpSMmtHanRXN05FNG05V0d1a3ROWk0xaGlkaVdu?=
 =?utf-8?B?QVdVYzJhblZDOUd6dE5tUXVSUXlLNEdMTkdKdTJ0dzgvVzYwY24zb3ZxMXpr?=
 =?utf-8?B?bTJXNGVuZk5TeHl6T1dBK0lLa1lZcWRhOUNnOTdBQnpQMFRQUTN4MmdrS1gy?=
 =?utf-8?B?VU5kcW0xT29IUEpIb3VpZW04M01oR0Y0dkU4R1VTOERqOFZSU013OFhmTkhJ?=
 =?utf-8?B?emt6Vm0yWTRVdGgzSEpXWEI5SzdvRnZ0VUhSWHJndjBWdnBSVUowQlhoTXJD?=
 =?utf-8?B?R2RlVkFlaVV2M25UWE5Sblcya1FZalAwYmowZ2c1Nll1TDFCODQ2cUZmdk51?=
 =?utf-8?B?WWtuQ0YyRExhTGgwYmtqc3ZPSWo3Qk1BVmVQdllhS1hJMkVSRzEyeDBYNjlK?=
 =?utf-8?B?NnNJOEdCZXVTZFl4REF2WHJ6a01NVTd0UTlJajhrblFpZHhQd3Y5MUM4SHI2?=
 =?utf-8?B?NkJUZURnUUNucFh5WkV0QTFOWDBPdHNSMldFelNXZlBBRTJ6a1lZQjczQzdP?=
 =?utf-8?B?Ri9BYlNEaFBWdDV6V1FiUm1qcm1VcVZ1Uk50eFhTVWJ1allvTDhYNWhUK1ov?=
 =?utf-8?B?VlF3THVXRGxJN2hLbjByN1d3L2F5S1RaRWRHVFRDQ2R0cklvWnMwdmN4MXV3?=
 =?utf-8?B?eUxTbzFyN0RLZXhOYUtkclBWVEI2dmRXRXNNejY2SXZ0UlBIaktwM3VDa2xZ?=
 =?utf-8?B?SjhpTUFhTmV6emFGM0FqZW9zaDFpL2F3bEFIWnY1Z1NFTjU5U01zNGhnNTJX?=
 =?utf-8?B?SWdSeWtoMGdUbkdEV0RRczJZMUpiekZBTkdTZEQxZkM2K2RZakdoNGNRSkRj?=
 =?utf-8?B?WmVQaUJ3NFFwbi9tRnp3cTE3OXlFQnFnUW1QaVFrT2hBOUE0VFRqM2VpTWh1?=
 =?utf-8?B?eWlYanVlUUtoRHBMM0Q2VHBmZVozTXphUW5GY2k3clVIbGVsQ0NCc1Y4cHB5?=
 =?utf-8?B?TWcyTXZqWlhCNEtWbFRhQlNEMEV6cmZ5MTFlaklrdUhGejNjSDBtdTZrMzNF?=
 =?utf-8?B?WCs5RXlrc3RyaFVYNmI0VHdnYmNvNVZ2aCtXdmZzUnQ4T2VjMXA4V2FVTUpY?=
 =?utf-8?B?bG96T29nT21haU1MblFHNjU1aGxTR09KRjFIN0xiK1M0NWpOOUxBSzNwSFBT?=
 =?utf-8?B?RG53NnZrNW9tM1J5dzdFc2pXMStQWXVXNGRkOU9tcUR1SWZuRGJMbHFQeVEr?=
 =?utf-8?B?dWcxakFyUHl4TGxBUStGVFAwR2VnRmQwT3hUaTlvOG9lZ1pzTEdaS2NybDAy?=
 =?utf-8?B?MWxJSEFKTUl6cm1Ba0ZyWXVyTmFzeGFndWhYQk94cW9wQ0h2bUhKRkgzREF5?=
 =?utf-8?B?S0hLcGEvUUkxMVRPQkppbmxERWt3S3RMKzMyNk9jc3grR0pJT2U3Vy96NlIz?=
 =?utf-8?B?bk5vZnNWNDI2b3FWY29LOUFZUE5NVytvZ01MUU5KTjBuUEdhUUJqZkVBaVZq?=
 =?utf-8?B?TmtZb0V4WEpFMm9qamVTTFFybkV2NjBYVVIyYzkwWG1tN0hJVHlUM1IvTzln?=
 =?utf-8?B?aG5VSTVoelpjRWdRSDBSMGE4Q3hWNjJ4bjVOK2VZQ0FEaUpqbEpRRCtvaTJF?=
 =?utf-8?B?Ri9MV25vN3NSREdSS2xXRUo0QWRSL0Y0MnhWeFczYk1iTkN4TnpQejNOWVdW?=
 =?utf-8?B?SStlVW5ETjhHUk9adU04MCtQYkNDTzJaeVNBNFEvYmVGYlFtSUNERUp3aGFZ?=
 =?utf-8?B?WU1xcWFZeEZ0U3VlcWJpUTVHVjJzVHg5cDAvSjVlaHBZRUg3OXgyWXdkT3Vq?=
 =?utf-8?B?dlFSTTBSMEZVNjN6amE0WUYxRW0wbC9NVyswdEw3ZjVmcWRRaE9JR29UNzNy?=
 =?utf-8?B?TFhkMVVuMmZCZnpyYkFaUWxOZUF0d2VOTE9pRmtHRkFDZ3FEWkNETTFaNFRM?=
 =?utf-8?B?TEMxdzhKSWkyZTZJb20xYVgxY1l2VW0zNnlrNTg5SHhWUEsvT1d3bTVudWZO?=
 =?utf-8?Q?fRRlXowJ3pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWpsQ0NtL055ZnRQWDYvME5nREg1QzY5bWNaVndDdFRZWFR4L2dybjd3S0po?=
 =?utf-8?B?SG92bkdHRlNvTEIwbjFyVzFxWVdlVGF2dllHd2NXZmJqSWJ3TEpvYWl3K3VW?=
 =?utf-8?B?ejhhYmRXVDBteHJidlBPRzlwSWFHNlJaZUhSYTd4YlUzSjBUeFdWazFQNklh?=
 =?utf-8?B?NVBRMmp0QVRCN2hMSld1RldvaHV3WW03N25UbTg5MmVKQjZydnRESXE1ZVNB?=
 =?utf-8?B?N0w3Nk1OY1c1M3kyVERlSWE1TUd0VWx1d3B2OEMxeXNITUxvam5rd2hwZjNy?=
 =?utf-8?B?UTFXbzBLN3pLbGdPbGlESjJOd1A0L3piT1VkYWc1N1VpS3dXakJwN08yRG1t?=
 =?utf-8?B?N3lldjJsZ3c3ZXV3NkhiRDBVSjVuQi9HUWhQM3Q3Wk9KRnFUeTQyd2cwaWRJ?=
 =?utf-8?B?ZW5Sc2Faaks4MGQzbFI4a2x4V21JSktCb3VQOXRoQnJsOWRoZnl1Ynk3ejNn?=
 =?utf-8?B?TTdPd3hlRzNiN0dGdXhiOFMzTFJFZXY1RnV6QklqTVlia25tZGt2R0RlV3Zz?=
 =?utf-8?B?QUlEWjhtYkEzVWt2cHlUelpSbjJDRVNGTzZKK3BhQjZjamlRb0pSZU5Sdk51?=
 =?utf-8?B?cnpYNHpta2ZvSlcrWHpXSzdtMmU5NnF2UW9XZGptR1lwYlRRUGUzK0Zkb2RW?=
 =?utf-8?B?bVM4OFhSdWFOY29yTmlFLzJqZEtqQkJwdy80akdBM08wdnZaZjlwcTlMWjdN?=
 =?utf-8?B?ODVtWkFua0g0aHhuQzJMOVJkNnpOUEtsZnpGdmdZUk83NUhjS3RDOWc1dnZX?=
 =?utf-8?B?NVFncmpEQjVIK2c4Z0FvT2ZNeWsvcmpsUjNHSHBsK0JVY1JmMk8ybTMweTB3?=
 =?utf-8?B?aUd1cmdFSGNqaWpEUEZ4NGZ2NjI3dkJ3VmJnUFV6dTJMZHZjdmlORlUzd3NZ?=
 =?utf-8?B?cCtpeUpVVzM0d3ZRWG1IU2tlcWlxdG83bDJpMUJwd3JZYU8zdTAxSno3dnB4?=
 =?utf-8?B?RWpIeHhKNnhQZEJ4Rkxyb05TRlk1N1Z2UVZjRk5JMmEzcE9leStoSFZiTmo1?=
 =?utf-8?B?N2Q0UzRQQ2RVSHN2TldscGxOenVYWTlESFJTLzYxM2NGMXdIZ0Fxa2Q4STRZ?=
 =?utf-8?B?YXhSRm5SVkZsYktXSWEyNkNxWVZMdGU1SVJyZVVVcWphenhQdWtKem9WQjBD?=
 =?utf-8?B?b0xNSUNxMlVtYzFFalY1eUpoTmhCRncyYXg0amQ2MmdXTXZHWno3UzFHNUFJ?=
 =?utf-8?B?UHFaWUdLUG5mQ1h1VlpVcXFDZEhZMTRPc0xKRlRBekE1TXB5ZkR6UzJiTFVO?=
 =?utf-8?B?a29NYmFFNkdrMy9BR2VWbGlVYnRmYnhRZitVWGVwTXJJUWxsK0NrLzNuc25C?=
 =?utf-8?B?b1hjN3ZkRnpqenJOemlRZU5GbUNVTWRvT0IzdTc0aGZsckQxZnI1SCsxK056?=
 =?utf-8?B?Wm8vaVlnalBkdVBJUTBMOUo3eXYwUkRtbjNBeENvYVEyTVVaRlVva012YUtp?=
 =?utf-8?B?K1QyRXNkNHNwZnM4MVFWUlI5dWdDZVkwNHZrZHp1dzVlemUzOU1SWDRhNzZU?=
 =?utf-8?B?U1JBNVNOZXVkaWdEakNWQ1EwdjQ4UTF5RlNRL2RnWk5IOUVMUzBuQUxRQ3JH?=
 =?utf-8?B?aHRqT3RxU21YYUFaMXBlL0Q5UzNaa0d5eTlvMTN6SlBoRkZldjB4S0xyRTlT?=
 =?utf-8?B?T01kakl3bHRYVzRBRmo4RTJraHB2V0F2bm92dFlkc1hkUW94UkNlVmpBazNo?=
 =?utf-8?B?SkUyTTFqRkNVVVVVaG9ZeHdpSGlVZjVjdWR4dTRmbkxsOEd3V0R4SDZjaFov?=
 =?utf-8?B?WmZ5amtvaHJDS20wWDlzdzNMYzJvNXN0ZjI2TklkR1VWSEk5WU5la0hhaVBy?=
 =?utf-8?B?Rmdtb0FoSnFiUE5udGs5RW5XaGxQMlFHQTFKR0JjOEZKOGFJQVdLNFdLNnJy?=
 =?utf-8?B?TDQ2TVFUVnY2V21wVktBV2VvZ1FGSENQY3hKSFBDelhpMmgrV0FnbDJMaUN6?=
 =?utf-8?B?NnlMV2tjM2taMVBMamhBNTk3MzRMdEYyTXFBT2YzYy82NEhuVFo5blcreVBv?=
 =?utf-8?B?cUxWblFUQ1UzQ3QvK0hGKzlVdEVaUmZ4cFZkd3NrN2FzV3NYUVQ4WWxEcVM4?=
 =?utf-8?B?ZGlzSWo3aGx6dGJnaVpTUHhMSlByTnNaNzI2bFYxNTZBV05PVnlRaUR1Nnlq?=
 =?utf-8?B?UkdSZ2VHZzJUTWNsaGFPUmFxa05WNHpQdmd4bGxpR0ZXLzZOU1BnMFllOXhJ?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4a07c5-8941-477d-4f3f-08dd8cce24d1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 18:45:16.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NJA+DtUIj7NhsUT3Wk1sJcZR83ykQJGPMo7AY58mT4H15Ivt6ST8IgosU9FBwzZi6AGeKqIw6Elba3QacJpfFbSrLEdxg3Q4Ludf+xmgz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com



On 5/6/2025 8:59 AM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> In order to prevent the device from throwing spurious writes and/or reads
> at us we need to gate the AXI fabric interface to the PCIe until such time
> as we know the FW is in a known good state.
> 
> To accomplish this we use the mailbox as a mechanism for us to recognize
> that the FW has acknowledged our presence and is no longer sending any
> stale message data to us.
> 
> We start in fbnic_mbx_init by calling fbnic_mbx_reset_desc_ring function,
> disabling the DMA in both directions, and then invalidating all the
> descriptors in each ring.
> 
> We then poll the mailbox in fbnic_mbx_poll_tx_ready and when the interrupt
> is set by the FW we pick it up and mark the mailboxes as ready, while also
> enabling the DMA.
> 
> Once we have completed all the transactions and need to shut down we call
> into fbnic_mbx_clean which will in turn call fbnic_mbx_reset_desc_ring for
> each ring and shut down the DMA and once again invalidate the descriptors.
> 
> Fixes: 3646153161f1 ("eth: fbnic: Add register init to set PCIe/Ethernet device config")
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

