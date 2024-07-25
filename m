Return-Path: <netdev+bounces-113038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35893C733
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5A01C21FFA
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EA1991DC;
	Thu, 25 Jul 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIFXunXx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597611711
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721925107; cv=fail; b=eq+GJn9nsFOrjbSwxusuld/2lp4T0C8SJmO0xKwN9cH9Fj7Z//PepuywuyrkXleknF594+saOBXpRI5VJj2q0WTyl9d8zCuZCXhfX0i7uF5df52ZQwvVlYfrSll9PTv9Ak8KPTEOGK+1/aBWsuZxtNRvr+FYQwKtwj+aYNZdjOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721925107; c=relaxed/simple;
	bh=5w+lLvtCwOqZwG3Scgi+sI6uWkGt44CcOf7I03sNTtE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ls/ODsuJ/Ach7myNHEqIP7RAjFjEgnoNMe5IXL9tExOT12PoQxv/VNlNf+iSlDOHzkuhqIENCuJD0yWmibzwe/kyLNh03iXv+fhDWnE7WFznaEAcmb/3u7pV4ODXQ5X+9h6cSbZecQasfCNhcvbZvI75Si1L4zRmWURuchsA8M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIFXunXx; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721925105; x=1753461105;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5w+lLvtCwOqZwG3Scgi+sI6uWkGt44CcOf7I03sNTtE=;
  b=iIFXunXx7wdXe/x6md7W5nxpVJNgjpyoMxgLeTtjoSx0WxRPbuWEyTLB
   m45IU9jw3Ja/SMA7kkAcjXwWr0eqxeXLlEuxzlgy+3IOXEJUbOguu8qf9
   lpQhPzCNi/UuJgqjHBNiwYsh7YuAXif4FmQzANJgzOa4C56AVVxIm9EWW
   EIbfjSIW+hxJJoWnYHF50VNtlw1YQJUkRn0wFWW8XVXCm7ui7HYqefh0Q
   6bBz4uOoFc4ly3BBZVDVtPr2okR+CcOR46yeZRc3bReqFaeGwXyEWsBE+
   bxDHbFh5otOJtVPVVlu3DJsZtCbSkMgzaSDU2J4IuIR22gqpCMMNegsEw
   w==;
X-CSE-ConnectionGUID: +w03BMMJQsOxRMXub5vTRw==
X-CSE-MsgGUID: YWd2eNbmSKu6cQf1aieIeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19832962"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19832962"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 09:31:45 -0700
X-CSE-ConnectionGUID: +672OMJEQxasxGXksAoiXg==
X-CSE-MsgGUID: KWASmntqSrmFfaiMEJgchg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="76201195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 09:31:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 09:31:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 09:31:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 09:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEwhonc0efeu7eh46/uePLk1EEgb4weXP7+kVvTggdBkvC5xWzNHG/VLh2siSrDt73hc48vG4CeuRXsA31WpYjcyyDO40shVQ3NuDEDaPfZcTaT673HfcPORh9nNscAOELK6HIk6N31JqIl8w8k0Zmejgn2w2SrEg23Vv+DJ4area05OyzoVCfLPwD9+FVyKjZcd0sFWfFW8jV7dqPThRUpdEk2+Ot6IQTibQhHz8N5UunRWBxjHEIdNEwJwnxFk5VffillidxjawlcFCQd+nrCK7zYOqEB2rHeSpWGKOftXfOUe0lKJTd5XWvkdOCPLatkH/+n5GMeT5wqSzHxwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fvD5GGWsLE3Yda1bC0+PIB4QFzIvuxznc1FEAmcfI0=;
 b=NfmRyhVKR9IL5xYgrwBlUF9nelKfnbD+L7MrZXWYv9RzSk8ByRN34+l1wwJvaHN9zk7qcdv3CXzXKZoVJjZ1lDsrLAIOksOcLaq57IXEdPPnsepoLVccbCSR2EuhQULhfukaE8eSKaSYxuyBagIJ4WRHLUHU1Y0sZ37LFWOyhoj21KXse+geo/+hp1+/LLrFSWsXJS3ckhI6QBmdrEZLtwoofui14b1rCWJwy2eng1HjzQyTxvCh3PTsBjl2CIvOHvUgzNk/+sX9OydzWZGc21r5eh4qChyopq1I+YFq5uTKdM/dcbmfSgjUqTNEPabWZOlMHAmaBqgYQ43Pb+3XOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 16:31:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 16:31:33 +0000
Message-ID: <b60a8fef-3262-4921-a8ba-360465eb8832@intel.com>
Date: Thu, 25 Jul 2024 09:31:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iwl-next 4/4] ice: combine cross timestamp functions
 for E82x and E830
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>
References: <20240725093932.54856-6-karol.kolacinski@intel.com>
 <20240725093932.54856-10-karol.kolacinski@intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240725093932.54856-10-karol.kolacinski@intel.com>
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b22cad-113e-40ec-25cd-08dcacc73e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlFBMzVHT2dZU0dDRUlQc2NkYmUreVJlWTJrZHlUb2JjM2ttS01WVVhOY2dS?=
 =?utf-8?B?cEdmcFFNQ3FhbzdTVGZKcWF6aHI2VnlGRnRsR2hGKytYRU91REhHbW9kdUpm?=
 =?utf-8?B?Q3VtZUc3YlJpNkRiZThXaDhrcmZncXdUdUN5QUYzL3llbmVRb2VXL2t0S3l5?=
 =?utf-8?B?SUxWaGxQS3IybndyQ0gxNHRJc0oycXlHVnZoVzZvcWRTZ3ZqWFFzN2VmMHJ6?=
 =?utf-8?B?QjFWWW1GL1YzSkRMSHZDdFRCQ3hhd2lyakUrRnUvdm9FenBXSUlCUlNoam9t?=
 =?utf-8?B?aGVUSXcwYlpubVVPWVVqbW1QWit4TlRicUFqckk1V0F2SkhEUXdNY3NtNk8v?=
 =?utf-8?B?Q3JybHF3aiswdGJTb2lYaUszWUZkYWYxcTRaN0hsL25FTXkrbW0vWFEvSWtv?=
 =?utf-8?B?NmpBbm92MXZzWlUvTjNCcmxISGRKV1FGMmRWQVhaenpQcEF0NkZOeGtRa25C?=
 =?utf-8?B?eldXd0pjQTR4V2FlZGNMd3QxckNERllvbGZLcW4vd0V6bFdHaGhXZXNlSGwv?=
 =?utf-8?B?eWtKdGZhV1BuWVgwWUc5d3RBdVYzSzRvVmF0cld5ZHJmQjc4MGZhd0FlSXpw?=
 =?utf-8?B?ckpjTFNwTUpXZEQyNGxOTG45V0plcWR5R1NhNHVsWEtWTXYva1pDN0gzeXVi?=
 =?utf-8?B?ZjlpYTA3ZHplQlp3d3FlZW1LQTY1TlkzejZKY3NScXpHVlFsd3I0MmltSVgz?=
 =?utf-8?B?Q3lUVlhFOE55S3lLUzJ3V1dCZEVGRkQvQWlqSUhycXo3NTZ6VktERkhpZy81?=
 =?utf-8?B?YldZR0U3YTFWQ1BsQnBDTHE2cWR6NktZM0dNUmd3Q002UXRKVzhkMDZiK3hx?=
 =?utf-8?B?MVNpUHR1UmpiRHRCL0J4V1VadnVBNjNtTHhBZm83SE56TlZheGFKS1BEMWFm?=
 =?utf-8?B?Uk92clBONTVNSFRxcThMVDhObXdMeWRNNVdySGlNamMxUm8wZkNEYmJCUGdi?=
 =?utf-8?B?SHhDR29jSzFjLzlZL21YLzVNS0RpSXN2NzVjQlJjL1VnelNKenNSbXo0K0Vh?=
 =?utf-8?B?b3phdU1ValVoL3EvUE5wVlVZRFFYZnhsTlk3bXFwVVZUbjlZVnNOV2t4UUV0?=
 =?utf-8?B?MEFINFlNMVdRK1lWaFd2bi85dzdrbzdSMGs1amFIUTdUQVNOa0lsenVmcm5w?=
 =?utf-8?B?b2hoU2RsbzNxNWZHOHZWYnhRVXUrZHdRYWRDQlEyYUZwWk9nZlNtRGVjbW41?=
 =?utf-8?B?RWxRWnpkNUZJQ0RNckdQSVNXQW5EZWxIYkdwZ2dGejBXdUZhbVdwd28rWng1?=
 =?utf-8?B?bDRHZGJSWk5reitxKzNkSWR6QWtWaFJRNnRIQzJsYk9TSG5TRksrVVpKL09D?=
 =?utf-8?B?UG1zdldHT2Jhd2hKRXRrY3lsYllXV1ZaTitjWGl6c3JLNGhGK2NzZ2s5Tndx?=
 =?utf-8?B?TmdkTkVNSzQ2OUtIQnErYkgra1lJdTBjK0x3S0RwRWpKZlZtREpaN0F6YjNx?=
 =?utf-8?B?ZTg2ejYvSEhVL0VQbDUzZVdNZjl3Q29PNFFPSXBSbFgyMTJERUhlYy9XdlNT?=
 =?utf-8?B?Q3BlaE04Q3RMQ2RGazZXTXc0ei9hOTdRNmdtd3gvYU9PdE01dkE0SWJPQVdh?=
 =?utf-8?B?MVZtTHdqdmFHOHh6bkhjaVp0ZUVBRU9SWnhMcEV5SiswR3lCekZPbWI3eTBH?=
 =?utf-8?B?TjNGVUtwTUVMVlJleGhuczlQRnpVTzNzOXhJREQwNkkzZ2NjOWNRMVVLaUhD?=
 =?utf-8?B?N3dvcjY1THU0L0Ntek5sYmE1Ulc4RjE2OXBQOXdYaU5yQ3ExZzViMXJVQWM4?=
 =?utf-8?B?eHNoWE14UzhwRHRjVWl1RkdqV0ZCK3R2OEdIT1h3cXBNNTJnNUh1YXNVUFFi?=
 =?utf-8?B?YXBlOElvMVFiRGlCN2NUZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZSUFNRMjF3bXdleHJaNlpiZWZDU2IxaThPMUZyS1hTZ0doU25oSUVMR3pq?=
 =?utf-8?B?NkxjbFJwTStUME1mcTdLelJ5T1Q3Yk9GWUdGK3pManlVTHhiYVphQVNncElV?=
 =?utf-8?B?cnBnUUhUbFNLeS9zeS8vbjhmMGRKOXNodUhkOU0zWGxBK0t4allZelh5T1E4?=
 =?utf-8?B?MEl6K3ZJRHZHV1VnSy9hS1JiclFsaUg1dDJLMXRzM2VNa3VJeTZNSVEwYXpm?=
 =?utf-8?B?enpRUUJXS24zZFhmb2VvNVJwMTJSTzVQQ2ZBK2hoTFJrRDFwV2dFZjlaWnZi?=
 =?utf-8?B?S1RXemlXZk9STWZGQmxDTUpMZk9IbXlrRmU2ZmkwK2FSOVRDYU1lOUU5cXIy?=
 =?utf-8?B?OE1QZXA2YXQ2QnhXUks2WVA0dWZvaTlMQXdSREFJWkc4OURreGo1bUtUeUt3?=
 =?utf-8?B?ZHBYd1lWd0srN0hKK3AyNU1iTUtIS1U2RENzQ0dWVWpObGJHNUR4aElrUVIy?=
 =?utf-8?B?NHRhOFFySDIweGZxY3hxNjAvRXVXZUcyeXVSUzVhUTB0Z3VuUytObDdiSjZB?=
 =?utf-8?B?YU5qdVdTTEE4NUlkSHN6Ymkva0s4THU4NTVQcUtHWHl3TVpmTXpwOHFpVGpV?=
 =?utf-8?B?NEtCbCtzNGwrR0grM2plcFYvdmpvaHdDcDdrVklNQzNDSjAzMVBNWGRkalZq?=
 =?utf-8?B?aE5MbnRqTTZpcGhScCtJS0RPZm9VaElmRzdNRHllNU9ReW5icm1ZNWJETmNh?=
 =?utf-8?B?RkVlYmVPY0I3Sm8vYUhVdDhmVnpnUEJuRXpVU21BZjRWM1BBa0lhQ1RERXI0?=
 =?utf-8?B?dUNHaWtUb3F1c1dxanBHMmdjbUp4Z3ZWZ3VLdkFaNkt4Si9RV3NPOWo2U1hD?=
 =?utf-8?B?WDZsUHBtQmdmSjBmeGVqd3FaU29DcU1mNnRXVXpkMGwxZVNDbTgxem1KWG96?=
 =?utf-8?B?M25Gb05ZanN0Mm8zV29KSXBVMDVzQ3Nnb0o1UnRkalVhU1hxN0NsZVBGV0ND?=
 =?utf-8?B?QmF1YWg2STJRZUQxV2xZUVNMN2MydHRwejBjSnl2WkVuZ3RiSCt2aXdpelJt?=
 =?utf-8?B?eUtDa2NuSXcvdlpMcUFwLzM1M2trYkFDOUhIVGdzTEJKb1ZJR0ZhZUUyY3k0?=
 =?utf-8?B?dEZzbjI5SG1HWXBSTW1YNmlUNG5Ic21MMDZTcmFhNU5DTXN5L0FvclZDbU9z?=
 =?utf-8?B?TjlHMVJxUHR1UE9QLzNYeTkxWEc5ejBwd1h5c0ZCdWZoam54WG9ja2E4bU5I?=
 =?utf-8?B?WExjVUhTOUxWVTFmZUM4Qy8rekZ4cWpkQzhGdHBjUVd0Qm5temhCZGsvZjZ5?=
 =?utf-8?B?d3p5UDdOajZtRi8rMk1IQlRSb2RQcTZFTWRRR0tTbVBwcUF5OStnenRSRDBp?=
 =?utf-8?B?bzY1citrTFdNSElMVW1OU09EVGdaNW9NcnhMRy9tdVhQV1pha29DU2ZXRlNx?=
 =?utf-8?B?MXE0cDRqMFd2VDhGUDdzb1BPdndnU01QQ0NoRXIxZFdndy9BdHFxRFVBbDhU?=
 =?utf-8?B?TDhOODBqb0pEellmL1VsaWU1OWEyZ3BRTmpuN3FXODI3dVpDRFdiTmVCamVj?=
 =?utf-8?B?aERwdXlFVTZtS2pSQmRvRXB5eVlIS3plbGJYRUNmcy82ZDFCbXA1anllajE5?=
 =?utf-8?B?b1FtTEYvZlk0QUhHa3BXcHFLTnNPWHVtM0xoMy9GekZBT0E0UFNpV0gxYXlM?=
 =?utf-8?B?alA4cXdwaDY4VWNuZmE1SVJpbjBKMGhObkEyMTAvcjlhNXlXRXZzcEtDTktJ?=
 =?utf-8?B?YzlqSk9ybkExalpVTW4vMG5WY25MRm1kNWNOT0FDQnJtMTRmMU1aVXZhMlE4?=
 =?utf-8?B?c2hBWFFMbXZEZXppTUFnSDdYTGVYcjJXZ2hIZU5zaUZzM2txNmhPKzkvYTVn?=
 =?utf-8?B?ZjMzT2dabWlCR1c3WXdYL3ZhN1VLSytTTnBxSEhCL05nTXZncy9sRi9IQk80?=
 =?utf-8?B?NFNaWE4wbGRmeWg0bnM4cHdLMHRWVDJLT3JIM1R3eFBJMjdmcUFuc201bDND?=
 =?utf-8?B?T3VOMGM0cGpOakVlMFpKQmQxOEpmQ0Q3TGtoS3ZYc1ArYjR4K29mWldEKzJ3?=
 =?utf-8?B?TjZWNW9nZVdUbkhEWjA4TnBMWkYxbUV1c1RoTS9lSHlaT3I1WCtqSkpuR0xF?=
 =?utf-8?B?Wk9kWWc2NDZaUWFOZDJnWTVRMWc3QnlISGFkSXZORVJESjNOcWt4UEhvOU5h?=
 =?utf-8?B?aUlOOE9zT21RUGdFOWd2WHMzVG4zckhZdlNWUndueTIwWTdFWXRoajlYNWpy?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b22cad-113e-40ec-25cd-08dcacc73e78
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 16:31:33.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgwj5gn8L2a7CRhmWQMsv/OckBoT1pnzAzmjD7aKcOEwcQVSZKxdEhrq4VZXqMzXmI85d6rItIGDhT43E7Qus1ZvpBhG976p8XR4coPMs0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com



On 7/25/2024 2:34 AM, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The E830 and E82x devices use essentially the same logic for performing
> a crosstimestamp. The only difference is that E830 hardware has
> different offsets. Instead of having two implementations, combine them
> into a single ice_capture_crosststamp() function.
> 
> Also combine the wrapper functions which call
> get_device_system_crosststamp() into a single ice_ptp_getcrosststamp()
> function.
> 

The commit message could probably be updated since I think this is
referring to E830 code which is only in our internal branch. I guess you
must have squashed this together with the original E830 implementation
rather than sending that up and then this refactor/cleanup?

Not a huge deal, but it is somewhat confusing when reading the actual
patch code.

Thanks,
Jake

