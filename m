Return-Path: <netdev+bounces-100827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82B88FC2E0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A40285275
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76D139D1A;
	Wed,  5 Jun 2024 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yd3b18in"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06A61FCC
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 05:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717563802; cv=fail; b=qtoDvAUV76KinGL0PFoWf6I4GsnkRaW0I1NKgxVYsxmoNIVMlTG/E8gvJ0viF172FY1DY7KHT1RnhyN59FoTCoGX4F7m93C23pyzYoYThv7cPPsCArkmzDm/E/jz09hpttvoxFgRrCm8FuRuNdNwquBt4XpwXjLlTcHLPqfkedA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717563802; c=relaxed/simple;
	bh=8Ab22NUqlwzMCXRMHleVaa0hJ7AHLwDGMrV/Xicfac4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpbYz/QfiXFcIUfxeCU+NaEjJfpIPoxvdQ0ClgvXv1VHmtpNmNaIbff9qWm5A2AIYogM+/lW6MQ2jvEmJeRWMcKbRjEprY+HEUSPKLIbvSCr1vtbgqrR15JSJiKueN2ouIIM/gfKutSqzqVKrE5w+kjDMWLe1MXGMcksg1l7hwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yd3b18in; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717563800; x=1749099800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Ab22NUqlwzMCXRMHleVaa0hJ7AHLwDGMrV/Xicfac4=;
  b=Yd3b18ine3FgQ5Iv0NCyIsuJtwIRtAteapQsa4Q6+vgzrz9beFWZWiGj
   PPTKHxrDr2UhhKUh13YO7G/K0bcP0yTnT5im/a6oka47viDlknAbmfkpP
   8JLcx3CtkQUCg3Oa84jXRxjRQ/PAV08txPivzcwMcDtzoTj5I0EpZElFX
   Ezprq+r33zVqvnmw1KoH99vs5gYJ1rGS8z3L0GtFg0sLKtPiACSBkIal3
   pHRmWe/lyw+iOql3ZoWLv6jU/jBnFhMmhZ4jR0PvmTLs8bqfkOlvxJkSp
   uOHtS2KP0kEk7fe+Wmj2p82whQax5G9ACh8UMZ6b3v8OUPmmbtf8sydPQ
   g==;
X-CSE-ConnectionGUID: +3UNHaLLSoqnA0ZmUgiJTA==
X-CSE-MsgGUID: zEEOixDyQBC+8HUQVpiMsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13986170"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13986170"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:03:20 -0700
X-CSE-ConnectionGUID: /j/rD4CNQza3PQQ19ALZaw==
X-CSE-MsgGUID: A1pG3jfhQ5+M3NqoIFq+rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37390866"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 22:03:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 22:03:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 22:03:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 22:03:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 22:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNhPuH6RodLJEkpx1JMcbzLBD8J9Js79f4/jZDVdbGpcGDCeHYdu0qTSLnH0P5YgLDrLX7qyv+4hdAi5E1E9VkdSoFNuTfXPyrLmHt4Sw59ZqbFM/kfSWAf9+wzjVKmfAxXTIqyeJJuPgaReSDQjnSsYgPzVboLz3VGJIk2epnfgoWkpgUho1PqP80s+gQGztsywM+h2eVrEzsX9uYbtOib14fiqTAQXXxzM4EEuN2FBp1fT5eL8UX4sd10IX76T/+kSd71Q3DqY6v+soM346SixM3DInRzLfR9ZTyv3YvW/uyzTk0cjV4oK9SwRL7mSn4fq+QxDLrZCgnE7ogZGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4A+SYVK3+wi5HdAyi7BlAnLjGujftb+FD95Hy4fTYs=;
 b=cc+Iq+/zmcgk+bYJrOVQsqGcmmea+PbT97eOmlSxcYNFyY1WMLXIYadkSeAXG+1vbkGdPzUo7xETtBsy6+9KdSOUe+8QjjvC9kfWYhTOKWiJHvZtOU0o7IJPBqG7phC5ndlWttn/KAHIp0+VhXKFnnz8gjAg8tY2sZZA4T6VuE98yDVB+njgBTsX0vI3ZRtCuBlUxIBQIfRW1YP4QRyWDQwgBHxVpwpD/aEyv5OiEHlcgsIJomFANTm8MiMESfEvYIsGDyOOQx1F9t8oJekdVCUmW9LdxwEyZZ7YQjzwmMr5fQZ6dD2s3/zew0NJwyMVCGttLDSw1hrrP6PwKAPJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 05:03:16 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7633.018; Wed, 5 Jun 2024
 05:03:16 +0000
Message-ID: <74b2aab0-25a5-4bb0-ab98-a70fb25f7c54@intel.com>
Date: Wed, 5 Jun 2024 07:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/6] net: libwx: Add malibox api for wangxun
 pf drivers
To: Mengyuan Lou <mengyuanlou@net-swift.com>, <netdev@vger.kernel.org>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <F7B60244A9D27356+20240604155850.51983-2-mengyuanlou@net-swift.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <F7B60244A9D27356+20240604155850.51983-2-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0025.eurprd05.prod.outlook.com
 (2603:10a6:803:1::38) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: c24e8874-94b4-4bfd-0b48-08dc851ccf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxENjluREZDZDcra25xc1BBdysySnZveDFGZy9BdDczQnNQNVI0U25Mb28z?=
 =?utf-8?B?dkJ3bmFERUk5YUhHcUxnZW12Um80Mkcrd2laK0hXUFpkR3BrakhQNG9DY2pj?=
 =?utf-8?B?L0ZnMFcyeHh6QXBVQmVkRThHQmRGQzJVMnpOenVSaWJWUHhtakZPQUVmVWNx?=
 =?utf-8?B?eVExWVU3WTJtSUhvZVhVQlhXbkNzYVg0ZEZZS09tZkFJbFRWdTlZZjR0cUdi?=
 =?utf-8?B?Z2lVSUFnUk84ZWRIOHQ3SVVyMmgrT0c4NkhpYzJKMXpBQzdLL29zNEZ5bkJQ?=
 =?utf-8?B?QmpLWjdVaFpEd2JsVXE2dXVnUUNlNlU1akZNZmFZUmpKUTdJaG9QUmVsVmdV?=
 =?utf-8?B?SVcwdEY3WmlYUUlFT1hITzZYTzM1dHVtNnp0amljMmlKL0NNMTh1L0tPNEpI?=
 =?utf-8?B?T21rMnBLSWdsTGxDVHFGQUE5a2lpMWIvWmdldE1EOHQ5NmtwcFlVb3k1N0NH?=
 =?utf-8?B?ZmFYVXI4a0w2RDZhYTBIN2JjNjFjQktLNUNCTnFzWXZHWGV4Z3AxY0NOb3Bw?=
 =?utf-8?B?dDBRaWRIWHNGOGZMRnRVVVVUZ1I0b2ZaWXl3Vk5icmxMUFpVb2UzeFU4S2Ev?=
 =?utf-8?B?c00xc0E3ZCtiWE5YV05MSHNOZkF0WXlXY2FOL0RyK1JGQTh0MEFmWm9xL2xi?=
 =?utf-8?B?YS91MzV1cVZHRzZnY1VUZDBrNjFYVytMYVV0Qnl6UWxhWDJCYWo5WHVzM2Z2?=
 =?utf-8?B?Q3o3YlllS3EyVmZERWRqTXoyRkZvT0l0QXJFeThtWGxGMlozc3JIQWZoZ3Fz?=
 =?utf-8?B?VlZOdVNXeFFpOXI0TC95UUpValJiMDdVWVc4T3I5VHc1bmV1aVArVkFDaDU5?=
 =?utf-8?B?c1JvQnBzY3c5clo5cDFZdThlN3g3c0YvWVEzRnpyVjJkcmpHMnlWQnllM3pF?=
 =?utf-8?B?RXlRRW5Bc0sxK0tFWlZML3dZbnF1Mk13UkFaZnVyK2pXNWNWbW0zY2psbWlx?=
 =?utf-8?B?d291cjZNM20wVGFaUWUzb2lWajh0cHQ0QkU5ZkVHQkZKVUhYM1hYL1UwVWVQ?=
 =?utf-8?B?bWdiUFFSU3JoWFZxZHVTR2F2cHNyNytkbnh0RC9adEhTakdRWnROQndMbnhs?=
 =?utf-8?B?NVhjV3hYZkkvYXBjUE4rWFZwTFFVdFBITXBvbGJoa2k0ZStOTUhIM3NUbVNs?=
 =?utf-8?B?OFVkY2VhYlNVV2ZuMCtCeFVSbTMxeW9mbzI1Ync1eWxDNnZuejNLaHpqQzNv?=
 =?utf-8?B?L1dJbzVOdjRIUjBQc29iL2NYbVZ6ZTZzTVkyQ1VxSWRYYmR3R3FNZWhjWjVy?=
 =?utf-8?B?b1l5emdtN0o3bXExaXF2VGJWSWxNMVVSTDA1SVIvWGI2S1pHVWloaFZCMWEv?=
 =?utf-8?B?VU1lQXc4MVhDWTlsM20yR3k0TkYwSGhvL3VvNXEvQ29yZXJoMXM3aGp1NjI5?=
 =?utf-8?B?L05sMlB2NEZ2RGJza0U3UUl3MmUzZVNudEJsaXNzZHJZNWlleDFrZzBZcThq?=
 =?utf-8?B?VG1FUGl1WXJkcXlvaE5NdTVwWnZoUnM4a0NsSVRwTndOdVNlSGZUck9Qem1y?=
 =?utf-8?B?UkNyWTJ1TlpwMFlHT1VzMHlydUtPU2x4L0kwZjdQbFhnOS94VEE0b0hidGtO?=
 =?utf-8?B?ckxUK1lVNjE1UG81S2xzNnFjTkJ4UHpNa0dJMlFwcjFYK2p4SVdsdUJ1MGZP?=
 =?utf-8?B?S1lod25NeFBqdjl3Ty9WeDNYd0k0Y0RGYzd4d1JSWmlFTmxhSDhuSEJMZFBt?=
 =?utf-8?B?bzd3cjFNVUlpdWhocmJoV01kWHdmVlgwQTZMRjRlcnBFOHBBaFRWR1FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2JPRjVoUkJEOW9JSVBqcEMvSDUxSGJSZk5saXVBOHBEUzlHOGphUXpZNDhn?=
 =?utf-8?B?dy9ZOGpRb3U4UVFINHFKWlI3S0hBNlVmbElhOWVnZWZtZkt5a1RmSStxK1B6?=
 =?utf-8?B?V0VsTllTKzlzdlpWUm1JSHVoSFBHTmtqWDNra2ZoZkFFM2txaTk5eDNVK01L?=
 =?utf-8?B?NHNhcGNvMG0xTlcxTG1rYlFMU29mQzNKSE1ScytqRkhlbW5QYXh4KzNRaENp?=
 =?utf-8?B?MFNqZFFsdXR1SFJQUnZVaThyTlhXVkM5c2pYTmdSdXFYbktUSUdTbks0c3hu?=
 =?utf-8?B?RmxoaTV2RlROWkZZUXh0TDR6V2ZJOEtueU1XUDl1ZEkzd2RrY2hVekpKRlU1?=
 =?utf-8?B?MzF1WWtoKzNzTXZLRkoxUWYreUJzQ0JnY3VUTWFXa0Z5L2puRmQ0YXI2V3VV?=
 =?utf-8?B?cG5iaHdDTmxZamVHeVhUc1RBR1k0OEVwNi9RMFBqVE11QmJKVllrTWljZ3Zm?=
 =?utf-8?B?NHNzYjFseTA2YmZSNnEwMWZ6UWRXRXR5enptTS9NZDBvUmx1WGptSVVaZXJo?=
 =?utf-8?B?T2c1aTEzYUV5Q0hsdEliTDl2VTRldnZTTlNMTGl5dldQc01HWEREZW45ZFlQ?=
 =?utf-8?B?Y3RaOEpwZnk5ZkJ4TFRRQ0F2cGdPTXFTME1oUmtGR0VnZXJCdWhxcDE0M0x0?=
 =?utf-8?B?ZTJaNis5QXBRelJVZjVvYzZ2UFNtZXhRMjZKdlYvMzJSNGZHU3pSUmxXRXRm?=
 =?utf-8?B?TC96KytrZFh1N2RHbCtXcFVDL2ZpTmRRWGs0L08xNWhTR2drUW5nMHFlS09p?=
 =?utf-8?B?SVBOY1VwSDhKQXROcHdvdEd6UnVqSDZNV2pMdDU2QVROdG1HVzVmcU12RUxO?=
 =?utf-8?B?a0NjVTcwOWZFbS9PZWc3WmVHL1dQWE5zTy9sOEppakNaY0R5clRnN3labEZB?=
 =?utf-8?B?R2Via0pJRjZwZDBkSmIyQmN2eUFubWlGQTNYRlpmRXBkejgzL2tEdE1YdHlo?=
 =?utf-8?B?YUtKcWFTV0FTbVR1VUhsM2E2bm5QaUlEYVdFaHJOQXVZaEtJRXVRc2JUL1l1?=
 =?utf-8?B?RlI1VzlCdFgxVmVEMWFzOFBqWllTb2ZKMnREazZWTTdqeVBOVGpqR2M4dGx2?=
 =?utf-8?B?MWFzcllsTy9FZmtsWDJwRk0yb2dUUDR5cEphRlEvdXdQOHRBd2pUeTBhMldq?=
 =?utf-8?B?NEoxRHNIU3VHa2Q3NjlQUkllTll2WXZ0bWl6QUhLdElPM3NDRWlJMzZtdk82?=
 =?utf-8?B?VnA4MDNlaDczeVZkN0NUdGJhWEszY3dwaGZ2NGhjcGNMc3cwQStOa1p5eEpN?=
 =?utf-8?B?V0c4VmlKcjRxcWhuYTFlK0E2TTZTNnppcXJ3YzRMazJpdTh2RE90RjNxTFFj?=
 =?utf-8?B?Wlp5YUJkKzRpSXp1RWFKVG5vSUttT0RLblZObkxIYUVZNTVOQ2Z6NTQyU3Va?=
 =?utf-8?B?V2NDMGZ0bWxMQUxIeXUyZDZpQjVNNzAybjBDTWEwbHlPRGlmcDFiUVFBVWpV?=
 =?utf-8?B?S0hYL1ZEc01DVXR1VUJLV1RLanpPaEwrdGFXL09tR1RPUk9JRnhBblB6WWpO?=
 =?utf-8?B?RUFWV0FFNmxiV0RsQVdTVGw4WGNyaDc3UzhFNE1mazh1cUZIM0Fwek1icHQ3?=
 =?utf-8?B?bmtWUUxBeU9CZUk4QVJLV21WUzhmc2E1MG1EeHg2Zm9UR0p6NkNoV09VUGVT?=
 =?utf-8?B?M0ZzYUhzR2RYemhDTEgwcGtSeFlPOW9YWXl2NVBwTzJqUUpVTXI3WmxFUTl5?=
 =?utf-8?B?NS9PbFR6OGZqMXplWktMaXpWT0MzNWswbUFJaGpnZmV0Y0Q3N2tGL1pHNElT?=
 =?utf-8?B?U3NtQzlSY25Ra0ZFamdaaXc4cjg0U25BMWNUOWRSb3IwZmRxamo1RmlhaytM?=
 =?utf-8?B?T1ZXNmtMTXNYUmk3NzAwd3U4aUp2aHJxcytCSWpNYlIwYnNsZ01KQndpL0RS?=
 =?utf-8?B?RkJIRnBQdmJHQmQwVVRvcW95cUpVUXMvQnN6UXIyd0JsK1BMaEJNQW9KeDhS?=
 =?utf-8?B?QWdvNHcwS1ZVT3NGakpXc3ZiaTZmTXViaWJvL2lQcTMvNUY1THhYNFZ2Q1Nt?=
 =?utf-8?B?QVF6ZS9YeVY2Tm01WitodFJRbHUxTVJ0U0hVK05TMUZnaE5OTmFLSmR0ak5r?=
 =?utf-8?B?NkdFdmIzeTBQTjJ6TjRsb0o5a0I4Z2lHcFZFdTBPcTAzcng5Y2Qvdm9JYXVx?=
 =?utf-8?B?QThZOHZHK3ZlYnJXTkZOQWtKWVFFS1JpSkJkSllKZXhhcTRoakxNWHEwQUJa?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c24e8874-94b4-4bfd-0b48-08dc851ccf36
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 05:03:16.4059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwBzPNKgxB2fLZYreIX89UqHLxg1u2cStXsef7meM9xo76O3hPCgq4xGenvQca0c2pYJcDTt6x2namRleQvjHukpscp8mAbDn0CKpG/1isE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com

On 6/4/24 17:57, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/Makefile  |   2 +-
>   drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 189 +++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  32 ++++
>   drivers/net/ethernet/wangxun/libwx/wx_type.h |   5 +
>   4 files changed, 227 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>   create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> 

Please change your future submissions to have cover letter message-id
linked with actual patches, instead of two separate threads. Please also
post URLs to previous versions.

> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index 42ccd6e4052e..913a978c9032 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,4 +4,4 @@
>   
>   obj-$(CONFIG_LIBWX) += libwx.o
>   
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> new file mode 100644
> index 000000000000..e7d7178a1f13
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#include <linux/pci.h>
> +#include "wx_type.h"
> +#include "wx_mbx.h"
> +
> +/**
> + *  wx_obtain_mbx_lock_pf - obtain mailbox lock
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if we obtained the mailbox lock
> + **/
> +static int wx_obtain_mbx_lock_pf(struct wx *wx, u16 vf)
> +{
> +	int ret = -EBUSY;
> +	int count = 5;
> +	u32 mailbox;
> +
> +	while (count--) {
> +		/* Take ownership of the buffer */
> +		wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_PFU);
> +
> +		/* reserve mailbox for vf use */
> +		mailbox = rd32(wx, WX_PXMAILBOX(vf));
> +		if (mailbox & WX_PXMAILBOX_PFU) {
> +			ret = 0;
> +			break;
> +		}
> +		udelay(10);

not needed delay on the last loop step

> +	}
> +
> +	if (ret)
> +		wx_err(wx, "Failed to obtain mailbox lock for PF%d", vf);
> +
> +	return ret;
> +}
> +
> +static int wx_check_for_bit_pf(struct wx *wx, u32 mask, int index)
> +{
> +	u32 mbvficr = rd32(wx, WX_MBVFICR(index));
> +	int ret = -EBUSY;

please invert the flow (and use this as general rule), so you will have:
	if (err) {
		error_handling();
		return -ESTH;
	}
	normal_code();
	return 0;

> +
> +	if (mbvficr & mask) {
> +		ret = 0;
> +		wr32(wx, WX_MBVFICR(index), mask);

you are checking if any bit of mask is set, then writing
this value into the register; not an error per-se, but also not an 
obvious thing

> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + *  wx_check_for_ack_pf - checks to see if the VF has ACKed
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_ack_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFACK_MASK, BIT(vf_bit)),
> +				   index);
> +}
> +EXPORT_SYMBOL(wx_check_for_ack_pf);
> +
> +/**
> + *  wx_check_for_msg_pf - checks to see if the VF has sent mail
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_msg_pf(struct wx *wx, u16 vf)
> +{
> +	u32 index = vf / 16, vf_bit = vf % 16;
> +
> +	return wx_check_for_bit_pf(wx,
> +				   FIELD_PREP(WX_MBVFICR_VFREQ_MASK, BIT(vf_bit)),
> +				   index);
> +}
> +EXPORT_SYMBOL(wx_check_for_msg_pf);
> +
> +/**
> + *  wx_write_mbx_pf - Places a message in the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if it successfully copied message into the buffer

s/return:/Return:/
s/SUCCESS/0/ ;)

> + **/
> +int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret, i;
> +
> +	if (size > mbx->size) {
> +		wx_err(wx, "Invalid mailbox message size %d", size);
> +		ret = -EINVAL;
> +		goto out_no_write;
> +	}
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		goto out_no_write;
> +
> +	/* flush msg and acks as we are overwriting the message buffer */

how many messages does fit into mbox?

> +	wx_check_for_msg_pf(wx, vf);
> +	wx_check_for_ack_pf(wx, vf);
> +
> +	/* copy the caller specified message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		wr32a(wx, WX_PXMBMEM(vf), i, msg[i]);
> +
> +	/* Interrupt VF to tell it a message has been sent and release buffer*/
> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_STS);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_STS);
> +
> +out_no_write:
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_write_mbx_pf);
> +
> +/**
> + *  wx_read_mbx_pf - Read a message from the mailbox
> + *  @wx: pointer to the HW structure
> + *  @msg: The message buffer
> + *  @size: Length of buffer
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if VF copy a message from the mailbox buffer.
> + **/
> +int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf)
> +{
> +	struct wx_mbx_info *mbx = &wx->mbx;
> +	int ret;
> +	u16 i;
> +
> +	/* limit read to size of mailbox */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	/* lock the mailbox to prevent pf/vf race condition */
> +	ret = wx_obtain_mbx_lock_pf(wx, vf);
> +	if (ret)
> +		goto out_no_read;
> +
> +	/* copy the message to the mailbox memory buffer */
> +	for (i = 0; i < size; i++)
> +		msg[i] = rd32a(wx, WX_PXMBMEM(vf), i);
> +
> +	/* Acknowledge the message and release buffer */
> +	/* set mirrored mailbox flags */
> +	wr32a(wx, WX_PXMBMEM(vf), WX_VXMAILBOX_SIZE, WX_PXMAILBOX_ACK);
> +	wr32(wx, WX_PXMAILBOX(vf), WX_PXMAILBOX_ACK);
> +out_no_read:
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_read_mbx_pf);
> +
> +/**
> + *  wx_check_for_rst_pf - checks to see if the VF has reset
> + *  @wx: pointer to the HW structure
> + *  @vf: the VF index
> + *
> + *  return: return SUCCESS if the VF has set the Status bit or else -EBUSY
> + **/
> +int wx_check_for_rst_pf(struct wx *wx, u16 vf)
> +{
> +	u32 reg_offset = vf / 32;
> +	u32 vf_shift = vf % 32;
> +	int ret = -EBUSY;
> +	u32 vflre = 0;
> +
> +	vflre = rd32(wx, WX_VFLRE(reg_offset));
> +
> +	if (vflre & BIT(vf_shift)) {

ditto error vs normal flow, please apply to whole series

> +		ret = 0;
> +		wr32(wx, WX_VFLREC(reg_offset), BIT(vf_shift));
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(wx_check_for_rst_pf);
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> new file mode 100644
> index 000000000000..1579096fb6ad
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
> +#ifndef _WX_MBX_H_
> +#define _WX_MBX_H_
> +
> +#define WX_VXMAILBOX_SIZE    15
> +
> +/* PF Registers */
> +#define WX_PXMAILBOX(i)      (0x600 + (4 * (i))) /* i=[0,63] */
> +#define WX_PXMAILBOX_STS     BIT(0) /* Initiate message send to VF */
> +#define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
> +#define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
> +
> +#define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=[0,63] */
> +
> +#define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=[0,1] */
> +#define WX_VFLREC(i)         (0x4A8 + (4 * (i))) /* i=[0,1] */
> +
> +/* SR-IOV specific macros */
> +#define WX_MBVFICR(i)         (0x480 + (4 * (i))) /* i=[0,3] */
> +#define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
> +#define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
> +
> +#define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
> +
> +int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
> +int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
> +int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
> +int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
> +int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
> +
> +#endif /* _WX_MBX_H_ */
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 5aaf7b1fa2db..caa2f4157834 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -674,6 +674,10 @@ struct wx_bus_info {
>   	u16 device;
>   };
>   
> +struct wx_mbx_info {
> +	u16 size;
> +};
> +
>   struct wx_thermal_sensor_data {
>   	s16 temp;
>   	s16 alarm_thresh;
> @@ -995,6 +999,7 @@ struct wx {
>   	struct pci_dev *pdev;
>   	struct net_device *netdev;
>   	struct wx_bus_info bus;
> +	struct wx_mbx_info mbx;
>   	struct wx_mac_info mac;
>   	enum em_mac_type mac_type;
>   	enum sp_media_type media_type;


