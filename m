Return-Path: <netdev+bounces-185650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28C2A9B333
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1A17D7BC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF827F73B;
	Thu, 24 Apr 2025 15:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I05D2dL/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83527C150
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510397; cv=fail; b=tkjrbD8zjxfNERzE5fKYXJ0AqIkESapWmSUyPMtmtW+qAbEGWjhAhXsK+6PYminzS3zcQjsjjE1EdUw4ObXwhGY9rEdR4scI08UPS3yPEgnvudsvHPEUCBwvX9bYysDY/OiDAHfcNE7Bc5cn6/HdBwPMCH2VSyd5psJG2c4jhOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510397; c=relaxed/simple;
	bh=A+mTg88YIiY/U3CS31SSsB/ouWrFagE8KjlxoC06oA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=usF+42Z03KSrMeUDGex7p8lSaL1VW2FJmx3MryyiAlrUC0CaGJwMTe7Q8DJAx1v97GwjDzq6LFP1i7XcxHucJ/m8SUgIKy1CJVe1lLgrWINSEf8yUQt8Woe3yX9DUu74/p2hpwzxSh5UEVCm0LlUW/ZcnEahtOmL5Zs8vhVGuRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I05D2dL/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510395; x=1777046395;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A+mTg88YIiY/U3CS31SSsB/ouWrFagE8KjlxoC06oA8=;
  b=I05D2dL/B5rYlJ05+yzbCTtotFrB2kDCgxgDImpXRluuY1fJf8pMHMg+
   NwBWaoIu5N81ehFH6O3ixHCnNOOlu/SVEsqEzvBPst3SXC8gN0OYtyExD
   jyBexwJjRHI4O9TRqMcrnGhvHHShnnANVAJ+VSiMKxOTBqSDWEd2Po/5/
   VPAePpYYpjgW1Za0jscYLlkP7CGjlB9l27kp1J6byDGNJFZWPlenTg/JE
   iHP4L+vGkpSEQ1bFrTffklArfTdeFDAMyXLfJTNgoHZ1KOuXJVccZeCU0
   VxmIh3U/iFeV8HrEq/4YoQiuB1RLGpN01to57r/7oszo8+ORluDmEgShF
   A==;
X-CSE-ConnectionGUID: UHMT1CfwQPq0UUni1StcYA==
X-CSE-MsgGUID: Cdowk7itSzmnP63XkLTAdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47028519"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47028519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:59:55 -0700
X-CSE-ConnectionGUID: 8dcXrTATRBCAPMy05KPYrw==
X-CSE-MsgGUID: i1YgLRDDR+2yONwFreORbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132570502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:59:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:59:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:59:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVUppc3yfEAI4p6JhDp1MqL6dff3m+2hR9b+5Qi7UHqWeoMrBnhYH58WZ3Tsp11g2y+H1supcxMf2okPtRlLlheTeS0DYxFyrE7qc2JTHFUCRVjzwDvACZ9I8ebcZM7/qkeZm9md5IUAS8ovmlWg4GGKU6fMOb+T0/O3ri2/FEyYjIPJLINk0PNNaocQaVMd7tGVY1wWZaRDMZgiTx8cPEa7qtDdRh7QRzMjiaRlwVUEs6pMQ82Jdq4SN/gA9Y0qqAjHD9WOn+PYxlRyPenWxUDDaQfdcWCeHQBw7dUgmhdw7OrLW3o3Bp0tCEI/XhePKKAMZyzVQJYDU1wlMUb95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVzHc5fVOYm2zB/tdrTpPvGNcJeSfno/hzCmmPXqG/w=;
 b=UbChyh0N6pNrjQrEpiqWv3XFxUKghpOn+xHF+G2SJJaQyBdsfUCc7ktgsbHVHj7nvUP1r8m3JZtNg6WcS5d1/AW323x2m6C10l4kNFPMJfyk3eVQoMuyGHKFSjyAWOvQ4+hnDcSm0n3LsrOlQRaylMKadRmFO4CNuEAsduANw1UttTF95JNxgLkhLKDgHXKocqX+79Bru1HKNDjhttojperhO4Zx8Ps5za/FxExDvllMwq5DdXwbLpeIpf0jwx+n9NWrFLMHYE5/HRWvLtzZTVnDFwWTaOtwn1+cTscLfA+hA9mNAkLo17fuP1PoIHsScP+QXsYiqlk/wj7CWmhDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH0PR11MB7448.namprd11.prod.outlook.com (2603:10b6:510:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 15:59:48 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:59:48 +0000
Message-ID: <4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com>
Date: Thu, 24 Apr 2025 08:59:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] tools: ynl-gen: don't init enum checks for
 classic netlink
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-12-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-12-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:303:16d::9) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|PH0PR11MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6b64c0-436d-4575-d643-08dd834909d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnBYOHNHUGMwWGRmdzZWRFVqNnJYMHdlQ1pQOTlacFpzK09namRyV0hJbXo3?=
 =?utf-8?B?elpUdk9qaHhLRzhPcElNVUtUbS9HcGNVMG96S0lmRjhWMXBEb3k2UTJTOWJq?=
 =?utf-8?B?TUVmYXdzSmxFek04SFVpa0ZpcmU5Yk5NUkRzWXBCZVlaTWE4VTJGM2hLdW5w?=
 =?utf-8?B?N0lyN2lWdzM1S01QUGs1bjJmcllnRGRVV2VMWWxhbGR5UFRoMWJpSkFUK3dI?=
 =?utf-8?B?eFNvWGpWWVdrOHI5YVRraUJxd2lhNXNPSEFtekNnZzlSL2pDYjNxMVJaWDFu?=
 =?utf-8?B?cUd4S0I1YW52QWZ6Zm5PelJHUjFUMUQ4UmFoMmpsalEvR0ttekFuaVJ2MWd5?=
 =?utf-8?B?b2h3U1hnREhIcWxiOVNLQ1pwcWdpYzZUb1pLOXlQakU5K1NZOFNvcFY2WTFk?=
 =?utf-8?B?eHhrZXd0S1g5d1pvNm1wWVRSRm1GeWJaa1hvTldJaVJEQ1Jydm0vdjhJN2M5?=
 =?utf-8?B?UE1NNkl2akJMM2ZPM2QrMitYdUZ0aDUyZWV5d1lQcm1EOSt1TVFaU2hoR2Jw?=
 =?utf-8?B?ZTMxVUJQYUpUL2VrVlljaHFicEpPdjAwZUladERMRzR4dXZITytwWTEza1pi?=
 =?utf-8?B?ZSsyZFBHYml4VG5YT2NpK21mSno2OVhWYVE1SU1uQWQzVW14K0FyTFdhYWI4?=
 =?utf-8?B?M0txOW1ZQ0FhNk5YbDNBOUR2TUlsRXphZ1IzVXMyZm5DMHFwZlgrLzJ1REVD?=
 =?utf-8?B?dktvdU92Zk9BL3piZXNoOVBMWWRERkZTVEZzYk5jZVdYM1RPRDJzNk5lWGpG?=
 =?utf-8?B?cmVUZW90dGVCT0hkUUUyVDRRenVlZVRnZGtmSFBxdE9OWkhjcGFEUTVOeEhj?=
 =?utf-8?B?QWhEVWhMd0ZkYXFaUHJNQ29xM0JsK1JYNCtkbEVpNDhybWNsZS9PY2xGdVM0?=
 =?utf-8?B?NGtxMlp0b21SMk9Weit3YjJhUFhNVnd3bFp4M2VxVUZ2cHIzcUVBYW9PUVhm?=
 =?utf-8?B?UjB2WitFMmFZMnkrMDFDdE1KUVNMV2NxTzFVSXozQ0NiS2dlUXZxNXlBSURk?=
 =?utf-8?B?R1FOUm9tNVJVZGNES3ljZ2J3UFNLMGdCNitVNk1nVEw1NFUvempJYzJydWJU?=
 =?utf-8?B?TEd2SlpORjNRcXd0MnYrbWV4Tk9HY0lhTUw0WmVsSDIxMG43a2d6eTJuN0JK?=
 =?utf-8?B?MDBjN2FuVy94eWFYaUc0N0FOUXdRVEt1djQ2NVd3ZzN4WDVZam1HZXJqQnhG?=
 =?utf-8?B?alpBUHRuZjlXYUduUkNhN1V6N3VvWnVFdkpRVm8xd01RcDI5SkNtRVIrdEpN?=
 =?utf-8?B?aGtGdHN1WG4vUHJjZ3Yxd1NURHJZUjVua3JWTHBwSFdueTlyb0czS2oxUHZz?=
 =?utf-8?B?RGR3dmhRNGYvVGdMTmcydlFJNGk0Ui93dHhlZkE3by90RkpFVEo3aVdYTTJH?=
 =?utf-8?B?alFsYXVsMkUySmJuOWpaQnlZTHFSYkZqM1N3TDUwd1VHaENXd2p5NGlFRlVi?=
 =?utf-8?B?NzJ5Rm5PcE13S3hNYWhMR2JncjlON2NrMnJzbUdBQ0N1blVxbEprbm1qQmVw?=
 =?utf-8?B?L1lhakJnTzZ4QnlMazBaNTdrZ25UMFF3aW00bUJxZ3VDQUk1WENMY3p2NHN3?=
 =?utf-8?B?ajdUR2RuR0xOSXU2OXIzR0ppMEZXUnNPOXFoVlV1NjRYaWplNG9BRzhCY0J3?=
 =?utf-8?B?MzBtYVkvVjBsbUtGb21obVI5NW1mUHcvV1Q1bU5qL1ljbzExQ0owaG9xRWQ4?=
 =?utf-8?B?U2gxZzNwRVo1Ny9la0p0NG96aDVxbThsRDJKUzA2bVUrYWRnQTJOdW0rY09k?=
 =?utf-8?B?NFIxbTQrMkd2YVJEdUlyNzhIZ2pGVkdUSmN2aGhrdEQrUDZJQ3dlbTJwbVdP?=
 =?utf-8?B?S3NhenZKeUxYYURKQ0J1Z3ZwMS83Y1U1Z21FbU1mUGg2dkxreDVsVWFndk50?=
 =?utf-8?B?czFhSFpQK2NUeXd5c2lmYnhDNjFFbGp5cVlwTnhWQUdWc3V5eHkvUTE4QnV3?=
 =?utf-8?Q?8V+aQKDf0eM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkpSdGJUMWcxQ2c1SkRzMVVuODFKOFI5SXo3SHdQWlBkRHNacDlERkRkZVJv?=
 =?utf-8?B?SHRYRE1ETFBXbW9SUG43MmtzVkM0RUdMNEtRSW1kVVNJVnViWXhzZXUvVEtN?=
 =?utf-8?B?NTN0TzR4dDBYa04yMnB2T0J6aWd3ajI2WFZPMlltZjR0YjB6Q29MT0poSHQv?=
 =?utf-8?B?RjRxbE1rRC9Db0toS1VNSjRvL3pXOE4veGpwaTNEK2Z4elJINDVwK1kvZlFY?=
 =?utf-8?B?OVRLc3I1L3htWUxNSmZEWEljcHN1ZEswSW44NStNUk9wMEdTZEttVFBXcU82?=
 =?utf-8?B?c0pha2JmUU5VSjRoWDRma1hHRjd6cXlvbDlkZUhZcEVFaXZnWGpjVTgvRVdQ?=
 =?utf-8?B?UzNTT1M3S0VVMFFjVVJYclpSeEVlU2J6QmZsdktUOVRhVEw4djZOTFFESjFB?=
 =?utf-8?B?RE9qUmpvdndacXNTWVJtaWU2N1F4ZUVVblQwcUUvVExWUXZUZStDMldWUTEv?=
 =?utf-8?B?THF5Y1FOMFM0UVoraWkvQzNhZFFZZXl4anU0dWVkeUswZjVNbUVpSEdsb1FU?=
 =?utf-8?B?WlJGOWRjaHVMeUZXTk8rRXQ3RG81MWwzKzZyUXBWRzBEV2xJb1pEZ0JTQjN5?=
 =?utf-8?B?aThOR09BUFNueTdRTWRkU0VlTGwza3BwdE41a09xSCs4SkRrdFZNeHEvNVNz?=
 =?utf-8?B?ekdLWTBrUWswRHFjYytZR25LRERrM05pRkJXVGQvS0NBaFl6WE56YkdMRGx2?=
 =?utf-8?B?ekFodUt4dnhZWDJzWVRxbTB1djdMOGN2QWNQQi9iS0J6NmlXSXhwQXNjUHJS?=
 =?utf-8?B?UEZaNzU2M2ptTkl3VTdBeWU2NWVueU9WTk9wTUIwajN3K2ZJYUhXUm9Rc3dN?=
 =?utf-8?B?YkZBS0RLVVFydzhzYVU2RC9XV3lOcnFIekM0L1I2NThEZnVSdmJrVURLbU5x?=
 =?utf-8?B?azkyb1J5dUYybGlWUWl2SjFKY1hVUGgyY2gyRG03aHlBa2NNUzBla2FKRUVs?=
 =?utf-8?B?bGJKSzR4WTBZc3hMUUlNTlZ1OWFHaS9QS0VRNDNzTkF5WEs0eTR0VmVxRGUx?=
 =?utf-8?B?S3MvRllDellLeVN1WWpLandFWmRoZ3daV1VObTdkUXFFRmtldGVJMG1ESWNQ?=
 =?utf-8?B?M1djQ1dXcFFSWU1hSVB5clpEeWxkWVlsUDJ1TDRSVlhXcUtyQjNGbkRpL2pU?=
 =?utf-8?B?S2EzaWhlMUd1RVpLTFFTdzV6NjdBYkFEWXNOL2djZ3UyV2VkbXdINEZ2T3lt?=
 =?utf-8?B?dmZxM1FYYSttZHRPSm5tUUVyNWJUSXdMWlk3dzRYWFVGYjlMRURKdllSdjUv?=
 =?utf-8?B?V0VIdlliVmh3U0dpd1huRmlCQXp4TmJvcWErakt3ZURJeXBzM2RSSU9CaG15?=
 =?utf-8?B?UUMxbWs2SXJiaHlJbzRFZUNBSm1nMVRyOUMwVEtqOXJOYUFnZHFMTFN4QXhZ?=
 =?utf-8?B?M0dmN3hyYlFleDlBL3NGR05KbEpTN3kyM2N6dzlFR241NEJTK3pPeGtjVnBE?=
 =?utf-8?B?WHFIclVkZWVyQkFlTG5jdVVnN1lUUVdlMnRsRWtTd21RRU10UUZ4SllqaTN6?=
 =?utf-8?B?NEF0eFFZSGRmZVlYb1dtQkVOelVVREEzMVN2Vm5WT2VWMFpKTTVWMTF6TzZW?=
 =?utf-8?B?V0lkeWlMZStpUkVybXlBdUlrWDVFWFlJQzM5RFVZeFkzUEcxQWN6TEVwNGRF?=
 =?utf-8?B?TWp4bnVJanJqMFFiVjU0SW1zd05rMjFMMmNVYytaamhlYk9vWUcxK3Fxa3lz?=
 =?utf-8?B?c2NsaGdHK2lyeHlReWxpNXFMcXByZy8zVTdVdHladDdjVUR5blZiTm85OFVZ?=
 =?utf-8?B?UUpnNTVVTnd3NmdrRzM0OUVkbUs1M0UrdU9waFd5Ujl3am1XdW1ZWktJdlRa?=
 =?utf-8?B?QmNTNzVFM0RURTVSaEUxclJTZ09GcklYK0YwREFadW9vd1FyRWlqM0tyOGdi?=
 =?utf-8?B?cCtQUENLR3hiai9MVmFLd3pkTnJlOWw4RHFNc3FjUkg3U2ovVmNIeHhOOGxD?=
 =?utf-8?B?MDdFOVAzTFQ0RmtMVXNZK3NHM29ZbGJLVnNJZDBET0NZQlRKRWtnM3g1V3ZU?=
 =?utf-8?B?all4SG1NNlpEZGVmaWc4cGZucXdXcjhIdExybWYvakJhb1dyck9hV1dGRWo1?=
 =?utf-8?B?MTlQNTEvZWIzZ2V2b00vYlBKRzY3cXY2ZGNlUnhoUzVkT2k4eklLYUZ4b2VJ?=
 =?utf-8?B?V2ZhRFFQNHpuOGRJbU0wVjZOeE1mbXVVdStRWVpObjdYeFd0amY1WlAwcTFk?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6b64c0-436d-4575-d643-08dd834909d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:59:48.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQfYpAVptjhX1C1z+olwDgzNudT0SbozdoJ+BkO5RcWcN/CoZrGPlVI7zhoq9DBMXdS6dJ2Psg45zobiwLsroHeHbqLIM0r/rMBn4YKaJL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7448
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> -        if 'enum' in self.attr:
> -            enum = self.family.consts[self.attr['enum']]
> -            low, high = enum.value_range()
> -            if 'min' not in self.checks:
> -                if low != 0 or self.type[0] == 's':
> -                    self.checks['min'] = low
> -            if 'max' not in self.checks:
> -                self.checks['max'] = high
> -
> -        if 'min' in self.checks and 'max' in self.checks:
> -            if self.get_limit('min') > self.get_limit('max'):
> -                raise Exception(f'Invalid limit for "{self.name}" min: {self.get_limit("min")} max: {self.get_limit("max")}')
> -            self.checks['range'] = True
> -
> -        low = min(self.get_limit('min', 0), self.get_limit('max', 0))
> -        high = max(self.get_limit('min', 0), self.get_limit('max', 0))
> -        if low < 0 and self.type[0] == 'u':
> -            raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
> -        if low < -32768 or high > 32767:
> -            self.checks['full-range'] = True
> +        if not family.is_classic():
> +            # Classic families have some funny enums, don't bother
> +            # computing checks we only need them for policy
> +            self._init_checks()
>  

I feel like having the comment inside the if block was a bit misleading
since its talking about skipping the checks, but this is the control
flow where we *don't* skip the checks. I guess thats a bit of taste as
to whether this makes sense to go before the if check or not.

