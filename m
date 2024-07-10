Return-Path: <netdev+bounces-110581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7992D3BD
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2811F21DEE
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162F193454;
	Wed, 10 Jul 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkVpYoBt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EE194153;
	Wed, 10 Jul 2024 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620138; cv=fail; b=iNTpNMw2vG3eJrT/btTBL+LDF9/PyXddqRRKODS+dXCwdght9UWksOObXDiX+7lvdCN7s+QL2IeAzxUx8kEzP8GNsQK5Gh8CCKKH73i+PTjAxI1cxwRqv97xJeowCue2bN1ekFS71BV4+IQmXTTcm0Qo2HMGXInPMvfzTLzPtQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620138; c=relaxed/simple;
	bh=LAb+PHFAEBaM3wgcoUxVd7X9/Ar5gctkyajsR6bqfg4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JY+Gnnkn/MejN+nx10AL0ChLNAcHsp7CQsIwacbGBPnmMkwll05xu3gwC2K/QQ9ks3kc+NoaynsotA1IJz1Rc6PK/sxZTMfXUxQ91e7Z19MnSeILVQAr7LIX1QEkrGr6ldOAOHNK3MWWdld8oeD7XSDmrD6Mm4npM/gbbEn3Udg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkVpYoBt; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720620135; x=1752156135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LAb+PHFAEBaM3wgcoUxVd7X9/Ar5gctkyajsR6bqfg4=;
  b=HkVpYoBtXd49I09jh97YRXfNlxvvEDKQmiRDWMppaiCwh8k96ERIsaWi
   enKJ1twCL9A+kQpxVE+pafGmcgSzoMCST0vWOvgISTsIUVVx8GXti6Zsr
   qk0BOrmOmoPa4rB+7/KJircqglFHNbtsZ5+YVfC9GZ282ORGk9znqalhw
   LYK9VR4gjnKdI4ZRhSHg84JixTzqpufc4pmIVouG2HMQrn/l7DHHivEhS
   yqsIPbcrakbIQOy9HlZQBH0IXV/d+0oOquisoC5crJ3fhpPl5Gzr499BL
   y6d4Wen9Zj6ZupfWcWgehxas+beIXp0MepZ0H/g4+NtKl2OPG5Zl0f0xz
   g==;
X-CSE-ConnectionGUID: 4GjsEW2ERN6JU6kVRL/O5A==
X-CSE-MsgGUID: YYN+MX0MQASN94MOXDQZHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21756985"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="21756985"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:01:55 -0700
X-CSE-ConnectionGUID: DvT0CtUXSdGWW7iZVfUJwg==
X-CSE-MsgGUID: b/ka6HmvR4WqDak5y7Cgow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48670732"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 07:01:55 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 07:01:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 07:01:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 07:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNXuFg/ayuzyni04rqqtNEduiZ/mWFg0U+zUfI9WVhRrTqh0qIBG45+WkvdEKKqY5KgCglvDdqIup0n3aXPzhqH+0iqQT/VzslpnPI89gChDWNw6t3eH7NiiSjlhQ0UZyn0lhzx6bZfFriZr4lArJzjWHLYCcygk3jPwsPtmNfra3mA/k5/cFGYpGJCkPK6jhAv5juEYjAsSPUUVJP9wC95Oi1v1E1zoYAh3enHlGqS2Z1ZKwi0x9KPF0bcsrLrWhEsGshlVJRuXsehs7XEbLLDKRjPqFhMVvTbpJ77oJEa5nhL97d59tjEgYJWxeKiJtlJwCBHMKtSOVAHMZtYljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUfvYw+MWZjImf+ZxqdwrSpLLyv/7NcR0ZUCA+cWCog=;
 b=Szg9Pa9uZax9Tpws846DMz5PSw3yUfO3BbGwhdN8fxNorrfPc2+yaE7VCwDMYmwGTgkapcYU+7cwZ1n1sEfCyjaKNpDJQZmkwoou6ui0kR0vNn7irnP6/kF6lR3uy3yHNXNg2sqSreXnOcyaViY3QAKErS47r6TPpCDnJXcBBCWfCiWmTzIhqIWZoWw01CC4MIHZMaZMmjPhJLU+Z3WtiLw4EjwxSRcbxrYA6wE5GQqblXPlieIzxcnl3AwX+V41p1ppvDBoGQ2wG5C50/MSMWOwBO7VAappuWnMlHZx7sD7gPKlKjyx9enTj/ItML8tiV5Xr6cMyKoyyXyVBPycKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Wed, 10 Jul
 2024 14:01:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7762.020; Wed, 10 Jul 2024
 14:01:44 +0000
Message-ID: <0664910d-026d-49b8-8b70-a5c881888761@intel.com>
Date: Wed, 10 Jul 2024 16:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] netdevice: define and allocate &net_device
 _properly_
To: Breno Leitao <leitao@debian.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <keescook@chromium.org>, <horms@kernel.org>,
	<linux-hardening@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Daniel Borkmann
	<daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg
	<johannes.berg@intel.com>, "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240710113036.2125584-1-leitao@debian.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240710113036.2125584-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: da47c148-2c27-48f7-fb84-08dca0e8d486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjRwYlN0REFSUitPR0FvK1FlUEZ2MVZEeHNYbHQzcWVRUXJpRjMwRUxobDJL?=
 =?utf-8?B?M3JFK0RLY20yUm5vVjd0VHE0VHAzeGRUOTczV0QxdjdUcS9MWlEzRk5EQlQz?=
 =?utf-8?B?bEI5eVMvSUwrQmVQTGFlK1podU5Rd1dlOW5sR1Z5MlRiVmVDazY5ZDYwTzlu?=
 =?utf-8?B?UFhzZERvRWI1OFlpV21iTTdCSEtoaHdra0VJdUJ6ckxOeFFtbU51KytYS3dC?=
 =?utf-8?B?UDFveGN6QWs1ZGU5dWl2UVpMVzcwczZwMEdlSlhMV08rSklDZEhELys1ZStw?=
 =?utf-8?B?WlhJbVdHNzdZZFFMMW9GdmZlMUVrVm5CVmxQMldNanVHc25oT1pqS3o4Z0E0?=
 =?utf-8?B?QWJOV3dGWmF2QUYxMitKSUVWMGdaTkh4WnBXTWVPN05EMXdBR25NUUJXUSth?=
 =?utf-8?B?Q2dmMlJweS93VnpycXBiSmZDSDBPeU1Bc3o0YmdtN1lReDNFeitBLzNkMlpX?=
 =?utf-8?B?N0drNXM5Rkh6eVA5VmFoL2dSZHlEWWhaN002UGRLWXZkMzVqcHMwb0hZM3VS?=
 =?utf-8?B?RjJwdXdaNW5MWHQrNmJWdWNUWVRUeklFNVdlcW5uR2pneGZveXJWNkNYZ1gv?=
 =?utf-8?B?bU1Db2RsSy9WOVppcGpQeXk3YlZnM1phVllkMUU0cGdtTFBweU84NXJFNUQ2?=
 =?utf-8?B?cEVEa2VnZm4xWGFDcTNqT2lMMHY4dVoxWldBVytHVkpFbTZkb3dVUGczVElv?=
 =?utf-8?B?YXNELzQyd29HSVNnckhFbGlGeFpwZGl0NDJEUWFqRjRHRC9pQlliRTlGdi9i?=
 =?utf-8?B?VUo5SDkzTURlckZUZzFGT2hWR1Zwb01qWTZHdnZEN3hLam1ZbmFUSjVaZzhw?=
 =?utf-8?B?U2dhK0tGKzdxdWFKRlA1OG5pdkc4STdCblc3Rmt0MHJoZFZJWjFzaFdCcmhx?=
 =?utf-8?B?VUNtZkJlZXVGWGU0ZjJnL0cybURlQUR0bmFXQnFPdzhMcnRncFVUSC9SRCtQ?=
 =?utf-8?B?OFdvV0dyVFg3SWNma0oweHAwWU51ekRraTlEV1pGTGZJZ3NnSkNaTnFXUmJJ?=
 =?utf-8?B?dFAxMi90ZzZORG8zUGdhOGNkaEpoejh1Yms3WVoxbklDZC9wOGVjMU9EdU1w?=
 =?utf-8?B?d2VlMTg3OXd0WEx4L01NcHJTckhnRkwwb2JweEFPVkNFelJ5ajJVcUZqWXp3?=
 =?utf-8?B?a3pyNVNWdmtwMmR5dlQzcVVWL3BkRHZ1bkNFaUFIK0xlMFlieGlpRW9kRTNU?=
 =?utf-8?B?UnNqUnhLbVFCeUYxRmJYbjFET3Azb1FzTGtENVZIcm96eUpuZlFWeGFDYXRr?=
 =?utf-8?B?bUEvNHJ1Sk5USjRQUTZzYjFtUXlEMzFwU0pQTlBOOEhRNkIyL3VqTGVuQ1ll?=
 =?utf-8?B?c1VUQ3FoOXNFM2R1RkZjSEhjYTVod2srdTNMYTUvTmdnNE5nZUM1T2puMEQx?=
 =?utf-8?B?cVpoUTE4bzZaZE5sL1JSUXNabklwaU9TWVlwVVdPaWFlUzFSUzg0enRVYWhy?=
 =?utf-8?B?bmlHcXJPUG1EZVNqNXg4WWZiWFMzMG1rVnNuUGNkeWcyMVE3L2pJNUcrQmU0?=
 =?utf-8?B?RWRuNnU1R0NFQ3I4SUVTUTJBblY0R1NHWnlkem81UlBsNHZNVWdjRkRzVmRD?=
 =?utf-8?B?MUhjYjlXRVM2TDRMWDEvT1MwbGhCVHdjbGVUT1YrYTlhLzUyMDhBeXZ1S1R4?=
 =?utf-8?B?MFFtYWUxZGdFQTBNdElYQXlLS3FGTFlySGNnY0hiQ3Jtak40b2wweEhFaEFQ?=
 =?utf-8?B?c3RkQTFmVG5rajZ6OGdtOWh5SzRMMWM5aXRIK2JPVkt6a1Ftb3FIYVE3Mngx?=
 =?utf-8?B?TVpKTVFpeFREUVQyeVhBa0JPbktKS1BrRXNCUFAvNlhTcWxYY2djcm5iRXpP?=
 =?utf-8?B?NWZqdVpqaGJuTnNiMGRjUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWN1czZXeHhsZkhaSTlpdXE4WUtCQnBEbkVVZXIxb2JSZzRxZ1JmcjlLOW5z?=
 =?utf-8?B?L0VOb3NYV3k4Y2NqbzFXeWNWK0o1Zk5TM3NZa1A4UUdKTUhGUmUxdEdjTDVG?=
 =?utf-8?B?cUJ4V1J4bytRdVVnV3VudWVzc1NzV0c5QTBQc2lsb3l1cG5DdU5KYTE4NmV4?=
 =?utf-8?B?NUJmVnlUUXgxY05YaFpTejhhWndZMUFhSEIxTStnVnVQNm91c3lLR1BxWVpC?=
 =?utf-8?B?OUVBNnNrZ1Y0SThBVjh6cmRMS21oM1E0cHYrOGpmai9kVy9QaWtOb28rRWsz?=
 =?utf-8?B?RXdOTlF1K1ZFMVE4dGhVeFgrMm5NY1gyS2VvaC9GOVlucHJ5OFZPL0JCakZr?=
 =?utf-8?B?VS9MYlQrVnFpeEJmNGlMdjZyYkNHZE5JRWxzUFhic0I0SnZMR2gxK2xqQlBo?=
 =?utf-8?B?Q05SUk1LUUZlcjA5VXVzNjZ3UXlkeGlsNUhOMFh5TnBOUmQvT0ZXMXFMMjk2?=
 =?utf-8?B?SnkyNmQ5cHM3VHJQM3NyeHNsTmlxWnFnZVc1RWtFSzJjemViRU1VYldUeW9q?=
 =?utf-8?B?WGF5T0dGbjU1RjEybmVwUll6bmFvMG5JbXBtN3M0anJVN0x3eEI1WE50dW9p?=
 =?utf-8?B?cUZCeDljSG5kU0dXczNmdVV2RkdEYWpaaGo1ZTlqUGhZb1VLeDIwdDJtYjJh?=
 =?utf-8?B?OTJzdVNMcWZQcy80LzJKanlQcGNad2p1WmtwWXQrcDJWTXUybjZxR01tMm93?=
 =?utf-8?B?ZzJWUmFhUi8wR28xakF5aTFTbTRzK1NzZ1AyZEFzcmxjMGF6UmdtY1ZQS1A2?=
 =?utf-8?B?N24vWm5IUXJ0SkZiVmwrTm9kUzVHZlphT3FzVHo1b2JEUndYU3lqb0JET1ox?=
 =?utf-8?B?T2hqNk5jLzB0alpqeUpYTnRZallXa3lySjJ5RGgzamRWZi9URVBlY3ZUNjEy?=
 =?utf-8?B?UDdoRk9pSEQ3VzJPN0VNd2k1TFh5SEowWkVMazB3QjlySGh0bFRDeDZiTjJt?=
 =?utf-8?B?eVk5MnFrcnRnLzFHQlIrK1laZEx3R3VIbVF0OXpnc083Y3ZwUiszTlhUdlha?=
 =?utf-8?B?T1ZJYVJqR2tGWnJacWJFQnZuaTYwK1hYdTljUFF6N3RwQmhWR085RHRYRDVr?=
 =?utf-8?B?V2ZUalNVMGlVZWduUUJHQzc4bnk3WWxjeklxLzJWU0xycmFudGdSTWlPek5p?=
 =?utf-8?B?YnMyZUdZNWlNODZUbFNoUFhsUWJJY3JrYTZ5OS9RZHJMZFkxRXNRdWUvZ2k4?=
 =?utf-8?B?bHFNeHNudVZVQjE5YnpiNm1qRE1NUkcrRllza0d1WjZYZVBFSWNhZVNqNkg2?=
 =?utf-8?B?elRiWitsT2x6M1VYUHgzajFyTEREZEFnQ2JvZnd5amF0c1FuN0hIY0hZNXV2?=
 =?utf-8?B?VGlGemhLc1Jkb2pENk8wMVp2Rk1OSFlsUllBSFJYKzBOTEExSEUwdEJ1ME5h?=
 =?utf-8?B?NEhJT3JWUzJ1ZWREb3FWcVdITDVFb21NZTltZW4rajVHeFNVUTFDdnNTQVBL?=
 =?utf-8?B?SU1kQUpVK0thT0w4ZmU4R3F6akw4bkx0NU9QMExkN1hxb1daNWxSa0FnM05t?=
 =?utf-8?B?RnF6cWJZRUlnSEo4ZFlXVFEvMWJpbmNiY0pGdEVtbnVwTVlRMlhIOTF1TUlz?=
 =?utf-8?B?NlpsTHRET2xIQmIxby9PWXVZTzBMWkhVWUx1c0VXbW4vL3hDVks3ZDF0ZUll?=
 =?utf-8?B?YmxqaVd3WVB4aXRVV3BWYy9KZ2NqcytoQ1ZaSTh0Y2pNL210VW9iN1czdnJJ?=
 =?utf-8?B?S0J1ZVlMV2tBam5lbUtNa2ova1RjbzJWdGNxYlVCNkM5ZzlUdlVIWGgxTUNl?=
 =?utf-8?B?ZXhKZXFhTkZkVDAwbDZjQmhtNTgwNFRPaEpGV2pjTHovVzlOTmpBbG1HZTJn?=
 =?utf-8?B?ZmNXLzNxVnhYTDh1WVJSWktTQ1BEY2FndDBPY2ZhblBBN1FxWnVHK2wzQ1Ay?=
 =?utf-8?B?U0NuMzUwZ1VGRFIrQTB5NVZFbXBhMi9aWW9ULzFBZ2lTTFFOM2IxN0xTNzB1?=
 =?utf-8?B?V1ZkTnJEU2wxQktKcFVkVzNqcHczdGZ1U1hKbmhTdXJXQkp5bVl4L29YOS9Q?=
 =?utf-8?B?Z0Z5Nzc0ZWZRWDAvc3MvYUZyWkFnOTM5clBtc3ZLWmUyR3FXSUM5WHBGdDc5?=
 =?utf-8?B?dkpUckVkOWNJVVRXaWhEV0loMEVFdHFobzJLTkEzU0J2ODJCTHZSZktYamQw?=
 =?utf-8?B?ZnVEOFVHWFVHeUFjeW4wOVZ5bGRrZEkvdWw4STVTWGs2RTJKeW5pR3l6S0lz?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da47c148-2c27-48f7-fb84-08dca0e8d486
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:01:43.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5Z7HnXNKlzc02RY9X7duUv/82OiYjKG9Qv11ls3SGZZoPJAKUcWTH479RVAtGO/t21dN9fiqJS15YkZ0WME1MGEyXHTgQ4l4IOjI3O28+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com

From: Breno Leitao <leitao@debian.org>
Date: Wed, 10 Jul 2024 04:30:28 -0700

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> bloat-o-meter for vmlinux:
> 
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
> 
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kees Cook <kees@kernel.org>

You did a great job converting embedded &net_devices, thanks a lot!

I hope SLUB won't return you a non-cacheline-aligned pointer after that
you removed SMP_CACHE_ALIGN(sizeof_priv), right?

Olek

