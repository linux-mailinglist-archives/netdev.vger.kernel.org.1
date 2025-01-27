Return-Path: <netdev+bounces-161194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD8A1DD9D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6ED1885066
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 20:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303D198E7B;
	Mon, 27 Jan 2025 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMf3tjFb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383D4195FEC
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011346; cv=fail; b=cSN4qKxc35kqFIE5Os6Um+X+TThmlCxMjIgA8ymVq5y4HYD6H2bkpFXi2+ZFZiOKAVq5l7+LndVCzKkn+dvVkwXRHDFb7G1tyDdZIbyMz6aFfFwl6gCahmJPns8qXR5L450bWSUaH6us6jlpsFm4qZdbl132UKQ/WcdYBXyPEGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011346; c=relaxed/simple;
	bh=tQheUM1U0XaBKPP5Xs0MT098zDpmSH6K4Z7Dexl+Zwo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XUWTnJS9v/J9PJ4H0HpcCJQAidn/XytPbY/+o2g18PYorYw5pp5P3TmpOd/uXtqqqoWb0VLZWwHdoh6xnTDQdNie7E08RwZZHZf2WeDFITyejJFzsuXYHoipXjoIGuztdaGOCLp4YDE7LLAyjKUaQ0xUTes4ah0XPSQukEIZrG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMf3tjFb; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738011346; x=1769547346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tQheUM1U0XaBKPP5Xs0MT098zDpmSH6K4Z7Dexl+Zwo=;
  b=jMf3tjFbDC9wPmjg0NuO4NrEipduaMLz5B+zsTgX3RyMj3EwBLsCClp9
   48ZYA8JyfOUT54zwDRJdCQ5qNVuMjc2dEtpIEPe9kTZwGcv8DSGBgi6+0
   58DEwmBugAn77CjpJuu5/p/opTSVy7T/9kCKvYeZXsMjCJw82mwyfa/nK
   6xKrruxFdJlUyS8ZehgQ1qYaZHTvT7gH6iGVvSWgcp4Hwy7HNO51VDBqw
   smpXrKmBCIZ25e8MPx+eSHNG+x3lM30nNqjzJmi5YWhq4Fmnt7NRfhYdX
   jgwCLAXlyA9IIZYmWtKQWHhLr6MVt5EgZFUldPT4FERbpnOG1ZP8Gpt4e
   w==;
X-CSE-ConnectionGUID: Ynn8Mkb7S2mkXW1d9Ha53A==
X-CSE-MsgGUID: Mo74kQOpSNOWWzyuKRWvaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="38373967"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="38373967"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:55:44 -0800
X-CSE-ConnectionGUID: Uj6yya/0S4q9uIcFj46K2w==
X-CSE-MsgGUID: s8rF35Z2SDu5CYe/nyFGpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108995242"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 12:55:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 12:55:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 12:55:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 12:55:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9i0yrM2U3mdm0zuAQp7QlMO4/UfAWbdbdbKydu7TCdaESrj4DheZFZKogkxfdAV0YS+uF3NiJWPEKdxmyxgca0KfTEl/3JzMgi2p8XeXC7mbGw5MNR0L9KAQ2PoJI8gPwcHqT8JqK304bPr8xShOVP4hp6kgECYbwFpp0QjvbwBx7tGkFE/TcfCdduOiqL0wMLHgyE2vc5gUT5mEOczt1ucHTVgPbZu+PTe3aGDXc1Lx/1i8mOraAqPNlH9q+lhHlXMoZ6MbqoIcT7CXM+TduItz5sTt8Iokqj1sJENvbQQENPFA/39EdywTroATYgl1f8sDAiYITHP7lKr1L9gXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FwtXf7YHf7TJiY/EMlo8MkN3zhiaDmeMzYaa/i9zqk=;
 b=jepBziNAgBtHul7pwC/2j6BS9ovSZxoDDRNad07AcqcEdYVCs8pCJ8IzxqTF/6bcyp0rIyZnPYC/NZV5flg16L3MgXS9695vZkCuH719akvXAMHB1vbYNrzYr624J9w3vJYLc/0XN40Zvv770T5tYwUtCUllnbEFrfqMjOihxT9ZnvZO+0rYsDUgVQS1JtIvOPJqHJPulm+st+PrZ5mC3fv71UTLN01U27ozMyzbx9VT1Tq+U84kRtPFSIUnWuVKvPQloPuGaQWSsAN/0KcmTSzfC8KYBIB6N1mPtaO8XfhI8HKysJ8Mb5E5wL81Sjdgjxv3ZS4BM988JfQt6Dv0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 20:55:20 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:55:20 +0000
Message-ID: <405a6c43-de6b-47a8-ab55-de6cf286196e@intel.com>
Date: Mon, 27 Jan 2025 21:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v1 0/4] fix locking issue
To: Jakub Kicinski <kuba@kernel.org>
CC: "Singh, Krishneil K" <krishneil.k.singh@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Emil
 Tantilov" <emil.s.tantilov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Ahmed Zaki <ahmed.zaki@intel.com>
References: <20241105184859.741473-1-tarun.k.singh@intel.com>
 <MW4PR11MB5911F6BAECF5DAC79199B362BAEC2@MW4PR11MB5911.namprd11.prod.outlook.com>
 <95288bb1-8931-4d18-b8f6-25a4f6148afe@intel.com>
 <20250127094247.40b169a1@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250127094247.40b169a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0144.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f24ea2-e15e-48ab-b521-08dd3f14e903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elh0emlPNTB5NFZoY0Qxem0vaWVzNW5TT2FQamY2L3phZmJEMldpYVBoSHk4?=
 =?utf-8?B?SmdwTlVVUWIzTnA4c2pYMFVvc2pxQnd5WnhEK3I2MFBod09GeFQrdHhxdnpk?=
 =?utf-8?B?eXgwS0hCbDN1NVVLZFNsZmkzOU1tMVhncmFtVXc0c2JBb2NkbXJBZmVubE1R?=
 =?utf-8?B?YnU4OE1yWVRQSENTVFdBa284dFh5em9Zajk5TEtaWnBETmhkWWhYczlXdzVp?=
 =?utf-8?B?QWJkQzBmbTVGblZnWWkxV2xwaUxjdWxkOXpjYWpHVHpFNkxlOFEvUGdpdXJB?=
 =?utf-8?B?SXQ4V3kzY0EvQndaS3Y1UG5VUTF4czd6TC9FUjRnZHdZeklIcUhzUHVqUTdW?=
 =?utf-8?B?ZmhyNGlidlBNUm9nVTNQRE9MdERTdWVRVzBycDJJLzlyZ2VDWERTK2dqTU1B?=
 =?utf-8?B?WFZ5aTY4aCs2U2dVcmNxTXI2UFFNd1NsRGhWdW4xV2FJV0ZQaGtla2Y0Rk50?=
 =?utf-8?B?Rit6WWlTSUFXdWhBSHhBbGJPV20rUmduYkhRT3ZmZG45dlVNSW1vT2N2OVhM?=
 =?utf-8?B?VVJDRmdPb2wzbEpKMzBtQWZpVFJVUVlQSVlucWd2WFhOd2RKZjMycStaMFc0?=
 =?utf-8?B?aW1sWGhUZUJRcXRSdGg1MldFL200RmMxTzBYOVJZQXNqeHdMUDBET29YczB5?=
 =?utf-8?B?enNPQ1pPdDdpNGp0TnNGcWU0N3Z6U3AvOHptQXBWQ2dVeDkzYVA3MFkxZElr?=
 =?utf-8?B?Z1BZTDQ1b05TcFNsQms2YU9GcHJJbjlYTHJVOTNxWDNmalRWeGp0WFFKNjJp?=
 =?utf-8?B?ZVBxcmdRNXZPL2RicHkvYW9qZEppZGpMZjk4dVkwaDM2aEw3dVh3eURuZm5U?=
 =?utf-8?B?cWl4THVSVkpJU3dwYUNKU3RvelU0cmQreGd2b09Rb2ZGUzBDVlJFVXJRdEs0?=
 =?utf-8?B?V0xrd2xKVHkyOTFnWWFsSDJYVTJQbVVQYUc1UnI3MG56N3NjSUpQQys4eWFK?=
 =?utf-8?B?VnJxbjZpZk45RGxkbDFYTXNHMVVMUnBPaE5WOGVJMDQ2M0g1SktiOUtzV2tR?=
 =?utf-8?B?TzBiMHg0MWxqSFV5cVoraDJCTktxYW5NRFc1eW1vbEpXY0gwYlEzUUszUFBv?=
 =?utf-8?B?N0d6SDJWaUNDUDhrdCtOK2Y1VVpWY3loV1VzNjZoYWpEMUtIVUFNaC9KaEh0?=
 =?utf-8?B?andEb3BZblRzai9oWFJlbFN2eGUwQTQ5R2ZyQmhOVXkySElFVDBrRnd4Wm5i?=
 =?utf-8?B?NWY0eGJJYUFmU2RXYm8raUp1bzV5dUd3RjZ0RzhteGwrOExGbCtxWmcwcHFF?=
 =?utf-8?B?OGhjdy9Dc1lkNU91RVRHZVBUYzcrNU5sb3Zxc3ovK3E5MnFONGN3Z2lyU2lD?=
 =?utf-8?B?R0R0NkNJZE1kNVlmSWJzWk1WSWo3V1hhcW1wc0xxOXRMZFY0QTA3SU1NZGFu?=
 =?utf-8?B?bWRKVFNJZXAyUCszUTh3N1ZRMnc2Z3l1UUNNeFc5d0FlcURUY1FldnlDVXZh?=
 =?utf-8?B?Y0lzUmdsaUJpRE51MEpGYXRtYlFmTUhQZ1VqbXI1MUx5d3VpWk9HN0p0Rm1z?=
 =?utf-8?B?TUMrckp0S0h1MXo0aklFL01aYmhXb25jZ0YxRFFNVGMxMUZoZjNXcFNkdjFm?=
 =?utf-8?B?and5UjhrY1NVM1lsOHBMbFlpZmN3TzExMlp6U2FoaW4zSmdEUm1PVWtSZE9i?=
 =?utf-8?B?Ly9VMlh3cnpaZWxqS2NVcTVOT0R2czNqUHZwdk1la21kUFlqcGlBaVo4Rmxm?=
 =?utf-8?B?SWRkaVMvZDVMUlBHdyt2Nk8zbCtnU3MyRngzeis2VUpFajBmNGZXd0l6aWtE?=
 =?utf-8?B?MmxXMzdZSURUVFVqMVBHaEF5cmpnc2xWRXBSWVVGa0Mvc0FKMmFvR3cxT2l4?=
 =?utf-8?B?WWF6cm41WU43Q3U3UjFVdlMxb3JhR29pc1RIOTJ2L1JnQ0tlZExXOUZ4Tll5?=
 =?utf-8?Q?eFEI9skJqZCzT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VPUDV4bzJvNkhkVmh5eTMxRU00YjZORm93Z3dxTGJxNTN2M01SdkVBRzJF?=
 =?utf-8?B?L3ZhdVpsdEpZTXhrdmJnRWVQakc2VnVTWGlFU2c1d2Fjekp5YVlkQlRBeFJE?=
 =?utf-8?B?NWw4SWZSOWsrRXdPNWJOTGdhc2x3c0RCSThFQlV4U2VHWGxCN0VXY3c4OHpy?=
 =?utf-8?B?L3BCbzBxMkF5VWg3cm1oTmVQOGJhMFhSUDdtenhwWkkxNS9ycmQ1bXhick9k?=
 =?utf-8?B?RkpORUN6cHFIOVlYMWJFVGxrcnB2R3lsWUJqSkRVdThxc1FuWHRqYVArOUlW?=
 =?utf-8?B?WFN0aXFDUFppS0dYOFUrYzN2eWVqLzJaOG0ySThScXlub2VxdXZ5dU9QQU5k?=
 =?utf-8?B?b1lCemF2dHpzWmpCbHVoamRoa1M3bzVwMkhtT0k1SVdFQW1EeG1Qd285cW1M?=
 =?utf-8?B?V2x0eHBOQi80eldJNGs3WUhDZEFuOGhnK2FPOVpGNUNEanNoMi9jZzcyTXRH?=
 =?utf-8?B?bUpIRlppbWl2VDJRMXkvUURBU3VCR0RYR3VUcEQ2cytjZFFXOGxFc0dHdHpy?=
 =?utf-8?B?eE05QWFGMTBFTnFQYTlnRjI0ZHNjZmpRRDJDdjdVWDltU3FtaC9BK010a2Rq?=
 =?utf-8?B?ck5YQyt5V3pOa1JpS1V6YjcvNXFCVTVaVWx3Mm9mQVM3UGwzZGhXYm5rNmho?=
 =?utf-8?B?blBrOGJDMjBzbFI1cG1FL0hrdCtZMFFPNFlwQ3NqRGJEb2RvV3BqTzFKaS9W?=
 =?utf-8?B?V3owSGxnK3R5THI5U3JGaGdEaXc4QnZQbDZlRk9iMDlRVk4wM2FIdXdNb0tq?=
 =?utf-8?B?L0VNamNMYit6T2xPdy9Hc3JQc04rdStSV1BWNlE5L21OTGxsZUN4clRPbVJV?=
 =?utf-8?B?SzAyOFBTWUxHUlhDRVZ6MWVpZklKRlBHR3pEdWZtWHMrdVY2SHk5QzhCOFhm?=
 =?utf-8?B?cG8rQlJTU2RTREljSXMzUnlKYTNKUjV0SnRBTWFIaFZJbWdIR284bXlENEs1?=
 =?utf-8?B?Z01XbVNKU2ZHUFZGZXkrdTRwNmF5cHNTa2Mzb2xJNWk2cjFTQlBmbkQrVFJj?=
 =?utf-8?B?YkFWRlFlYXJ0ZTRXc0s0MThERGRvUjFRQXpoNks2QWl1MHZMZGZJckxDbUdK?=
 =?utf-8?B?cytWL2ZHOE1ucmVScFNYc25nY3hKM0ZHSWJSZ3dMTkQwOHJtajVLTHlqUmEy?=
 =?utf-8?B?U21UeXF1dmFsTXgxUUQwdFk4Q2ltZVY2bjFJU20zZW8yckZ0NEJRT2ZYQndS?=
 =?utf-8?B?cmlFUUM0SmdKcUYzYnhHZFVrZWtjS1JxeERROTJLVW9ZY3VyeXpvWkMreHVU?=
 =?utf-8?B?aS84bHNDdDI5a2ZsWkVkQW5QdmlyekNYcEpSY1FkNTNtSHpkUkV0Wll2cWNw?=
 =?utf-8?B?ZmYrK3BGVi93MmlYUVU2dWlyRlE5TG44c2dBWDBldVF5Y0M4Vlk1K3dIaDJk?=
 =?utf-8?B?S1VPMWRmcVdqWjZPWDlPNDZ0OVdwZWlJSVc5ckR2bEl2S09LK2VnN1B6dDNu?=
 =?utf-8?B?V1draG9rN3lRaTNtYkM1UkxLc1lIU1ZTNTViMjlIdjh0TG5pcmtoeW1DRzRx?=
 =?utf-8?B?QUY0R0x3NDNObEQzZlFkV09OYTFPQzRsZStwaExmalg1SHoyS0QrdjI0RjlL?=
 =?utf-8?B?STZpOU9IVW5LQUE0cGNEVG5saWZ2OFNHSm1uV0dBdkFCa0FsbEE3VmdTdk5G?=
 =?utf-8?B?OGkzcVJ1b1BIUmNNYTdDQjcrdDF2eFAxYllhUGowVTRkYjJJUjhvOUVvVFJ1?=
 =?utf-8?B?aFRNMTFteHViMTFxYTNpcFVwZmZFM1Z5UkRIMmJ6MDh6dFpORzcrelBpa3hO?=
 =?utf-8?B?VFQwNlBYdkdqb2l5OXA3VzhhU2lRL1hYQUlNWnkzQ0ZDWVh4RHgrSVJFUzNH?=
 =?utf-8?B?ZFBXcEszTzJvcFV0UzdTeEhTTFZKZjNLQ0VIcFRlVXJ4RjgwNnJsTWV5Y0dX?=
 =?utf-8?B?Tm1oY1ZUUGozQWhUclNQUUVDNXNNajN2MXUyaWtEVVIybHRmRUtrc2lIVG1T?=
 =?utf-8?B?NlFtMnJsaVJjUElHY0h6NmFMR01vUEJ4M1hUd3laeGVpYXhmREpsNXc0UzVw?=
 =?utf-8?B?RjV4aGNjUW5ZMWZZdkhSTXQ4R2NIam1yWUxCcVhlWHFpT0hZSGowUDZSSFNO?=
 =?utf-8?B?UU9Ib2lEOVVMRGJIbnd2eEV6ZktKZjhCS1psY1BiMFY0ZmtzNU1SbUJpZFRl?=
 =?utf-8?B?MnM1YmRtRFRRQzd0K2l0ZG5BNEFxRTJTM1RFRkN0UGhIU1pnd0lGZXlDejgr?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f24ea2-e15e-48ab-b521-08dd3f14e903
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 20:55:20.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Avj8kSL1wFkzwPUyrgt/2HOzIq61uhlf3q3ehKYBqzYZQy8/2HerQq+hUND6F12X4BYKpd1hotAQHaD31cu8nMs4MB/nudwbwOreldcjHrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-OriginatorOrg: intel.com

On 1/27/25 18:42, Jakub Kicinski wrote:
> On Mon, 27 Jan 2025 09:11:41 +0100 Przemek Kitszel wrote:
>> @netdev
>> I would like to consider adding "in reset" state for the netdev,
>> to prevent such behavior in more civilized way though.
> 
> Can you provide more context? We already have netif_device_detach()
> 

getting -ENODEV on the device/interface that will soon be up again feels
unoptimal, and with all the risks of "poor driver undoing user config"
during the disablement I would like to see better.

perhaps with Emil's patch there will be also more context

