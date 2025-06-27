Return-Path: <netdev+bounces-201946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1EFAEB889
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7E01673BE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5A2D97A8;
	Fri, 27 Jun 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hchnVeuB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849DE2D97A3
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751029861; cv=fail; b=LrbgsvZMmmiB/WrGqyNNiIP8OuFm9eDurKmLhzcjAkPsdxKRhVm6In2WVvoxqo/QPMrYCkI5dQNAEtVOIz29mvNpa0SQRYNZPxwoqPA4NjlfDngKnMsEh/vH3jru/wFhSehSFY3UIZOLB/284AHTRf7Y7i2KABmx8PoM0app/KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751029861; c=relaxed/simple;
	bh=l5JOf6jOea+BZ1MDEIlTfRDOldwfFeR3TEA5a0YAsbE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LW1DKwP7BLrwe9vF8ca8DxX+5OKc+CEW1HFPQCT31KTjW83BZgeskHgZ3ovmB/2XkyPkvT1b8iBXRAOkcPwMQIGnikJQTgsVmH+VsswhE3CL1F55crm2D762d0RFfvIG9H+iRvGiZfIPQiI9wx5QvJ6cciJ/hU6xKs3ywzsikgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hchnVeuB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751029859; x=1782565859;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l5JOf6jOea+BZ1MDEIlTfRDOldwfFeR3TEA5a0YAsbE=;
  b=hchnVeuBqO6vhQJewCGJgmWqOZI9vRyHT1u22zcMOf5YGO5jkr8kUa2q
   +QGMzdEpg+PafHwUwB3SFes/HShA6fboOr2KfDv3lUwm13d304pW2xqZc
   3ImyiVmCN6Ralnxq4b+/KtBLue/OeNswUV8lkDYPJg8Pg6eLNcqORf3wy
   mQiMMfN1KnnYQHAhPUBoqcWbml4xCM6ulbu1fzOUYlwI/Xz0daGyL2Eh3
   g2RaJ5ZLkS8si2+zUNqxC6x68Xox9XyNeV4hxewsoD4IHcfZm6w1qLF9K
   i3GFLWXQ/pOEme9imJXpppXkXeKcONFol1fIoXuhU9AhhD2jXfD36Hhp/
   A==;
X-CSE-ConnectionGUID: el/xr/07T3mHs9+j3W1LGw==
X-CSE-MsgGUID: 3Vl0pAMISv6Q1fHEHXtWAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70774697"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="70774697"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 06:10:59 -0700
X-CSE-ConnectionGUID: wP4T/NqRRaWF5bKvu2jSPw==
X-CSE-MsgGUID: CYnpLfupS6WF5J3R9YYDrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="183838268"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 06:10:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 06:10:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 06:10:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.77) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 06:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqHEG0r6tTWm29+I6wVDHwLPJVf/lTRExxwxDBX2GiYs7+fbnUed4TAeTPQ/Ab8Go/hGXprhTiOeolp2sALbJ/H6khRgGLtfrjv6+LkV3q1/K50tlQThBxpcacGlQG5Q6a+QKLFscJJ7CbwQXtOHuhpk0O3i2IUf9qQQKpy85IYsqoxLzI4AA2m9D3dUbxN0hSWIrxBexqzEnyswPn0oa/IgWzWeIoPLHN33/ksBfQ76uQfz0h3rLCrRojbIdCvyobRQOl3ehZQ/sPzsRjsp2KEKrUWBiUgxVa9FdX9jg826xswlcsdGvMf9csMpix9QYMFWQBRQF6+r/1Rj7SVvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDODUuBygbjKvf2slUG4BdvXSBh4m8I/qUfI2H2oiN8=;
 b=D9gKyvpof2ApqwCHRUjTU0hMqSwurXZywg0YcL/XcwOUBk0ch5ToKDNAVYDKmhXGGleRmzY3YldxWpsP9N+34a6GjFlcnoc/oGJ7NGvOBQjQ85vxVBm79z/NLBGuLVA/tRYLUIZ2E/8vjj+VO7EpBmyTFdhA9LhXjNp+rB+puVqVv2f0CwxiVVgyyZxTxSf7oLxnv9ia0QWZurX6EnCrGVYgTZwL/BRC6RwpM2XJuUR3Q+of7smytm8m3Uji0OoW2ujUOU7wuy6QIdr4z5rp1DznbkzKlvaIEP8HVyToSRQA/Q1L1+iWiICTd44AD57RnC5EPVLEW9vc0dgmLxe/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 27 Jun
 2025 13:10:26 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 13:10:26 +0000
Message-ID: <cb1ef2d3-4750-40d0-85f9-df6a8ed3ec22@intel.com>
Date: Fri, 27 Jun 2025 15:10:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net 3/5] idpf: replace flow scheduling
 buffer ring with buffer pool
To: Joshua Hay <joshua.a.hay@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Luigi Rizzo
	<lrizzo@google.com>, Brian Vazquez <brianvv@google.com>, Madhu Chittim
	<madhu.chittim@intel.com>
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
 <20250625161156.338777-4-joshua.a.hay@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250625161156.338777-4-joshua.a.hay@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b81c7e9-1b05-4731-e595-08ddb57bfbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDlFbllBTzAvQVp1RldFZEJSL3ZkMXdIeXp4QlpBS3l1WFJDR041Y3NEQ1lW?=
 =?utf-8?B?ZU5JK01uTEhDTzJIZERKV0ovckxsVWF4cHJlaTliVzNIMENnZitXdHFqRjZW?=
 =?utf-8?B?SFAwcG9NaGwrNDdzcGRnWFNiTmNyWldwR25wcVQrN0N0a0FEQlg1MFkxYjRp?=
 =?utf-8?B?UEd5Y2Exb2dJQm1LdVNsUExqUVJGWGl3VEg0bTIrb2t2QVNHQnNBKzl1amxO?=
 =?utf-8?B?ck9qZTYxbHBzRDNtNDZFdDZxWmkrek5PMDV4K21aK2ZNNFpteEJJRzRkK0ww?=
 =?utf-8?B?Qkkrb1Z5MUwyVG91RDZLUmJ6dFRsY291NG1GT3NvWlFRa2NtczZVYXpmNU5Q?=
 =?utf-8?B?ZjU0NGJuUzZBQ254dWtpMzlYZzkvd1JaZXRtbkpjNEdRTnZmNXZlYkxUKzlZ?=
 =?utf-8?B?NmZGMVcvRTd2STUwbmloc0xFOStuUVc3ekVITUllNHQ0M1NDV1ZBb1NIR1JE?=
 =?utf-8?B?ZjN4bnNEZW1nMjIwTVdCSzU4Z0d2KzEwOUVMM0wycytHTWVuMjExWnNhcU0z?=
 =?utf-8?B?VEU2MjdKcDhrOFA5cDZXdXVWNzNqTmRvYXNmcUxxVXRDL21oOExxTENnbEkz?=
 =?utf-8?B?aXArSGd5blFXWnVEL0dyRHg4OWRlZjdINHhYTEFiNFYzdnhEVWpYUElEZXVD?=
 =?utf-8?B?TXJncFZNUm5jVWFId1MzZXRkK1FHeEg5OWpyUjFDOFZrTnV2T3ZoTHM3REls?=
 =?utf-8?B?QWFCQXM3NUY1OTYySk84N2l1cHBpbjhNVVpkREUrU2hNTWwrcmVWNXAvK3dn?=
 =?utf-8?B?ZVV4REJVZFBQU0k3OXJVQ0Y4b2wrNGU3NzVmUXZ1L0NPT3dVNUEvRnFpb0lH?=
 =?utf-8?B?K25qZlE1ekdFa21YQXlObE5EQVFPTWxhY0oyNnZxODF1NkhRemV1bkN6enpW?=
 =?utf-8?B?cFgreTVZczdCUDRvV1J0aFRPeXlHMWk0dVpxN0JjZFFtRlVPaVdqVHQ1Z1do?=
 =?utf-8?B?WG1IRnZHQy9vc3U3bDRDWDdmOWFRSTNLTFNnUk9vS01UV2FJTFhGTUQvaWxm?=
 =?utf-8?B?bm5HcGZ5OEhUS1RGa3ZsKzVlNndoOWt1YldqRVlFZ3Ywa1ZCbVFTaDBVSHQv?=
 =?utf-8?B?NmR5MkZLUE9qVC9oTi80enZ2ZGFRVjVGRm1GRkUvMHlIM29hbHZ3MWpDQ2Vk?=
 =?utf-8?B?cHdheEFaaTdGbWFucjZob0VNaUNBM2dPdTZyc21hbXRiWXFTMWxzWnU1QkZZ?=
 =?utf-8?B?QjJoTC92bGZjcDdpYXc4V2plKzBkYW1hbDBGTkVXdTBMc0tSVXhsSzMvUDJH?=
 =?utf-8?B?cVRzS2ZaeFpMcStBRXFUK2wwT1JOUm9WMWdNcDRXZDhUK0hVbnJLZUdpdjdV?=
 =?utf-8?B?V3Z2cW9lVkcwMmxhanYwWE1pa2FKSjVQWkpyRCt2UnQ0T0ZjeGZWc3J3Uzds?=
 =?utf-8?B?Vjg0VzRwdmZZRGhJRExpZ2hZZ1Bsb2o2VHlXd3pzWlF0NzVyVlpFMm9YK1Jo?=
 =?utf-8?B?dTFSYXVxUnN0dWt5OUNvZ0Zpc1V0eVgrck9oL21DSVlDZmlabXFpR1lyelhh?=
 =?utf-8?B?V0FlNDBLM3lTVkRjZmNHSkxoMXZxS1VKQVlNRmtaRjk5di95NlF6czY3aGZr?=
 =?utf-8?B?eWxmYjFGMjcrb1pmMnBUdnBtL25JWVhkeFNobjJBaUJZeFRheEVZUlh3ZmNq?=
 =?utf-8?B?SXpjN2NtSGFzMDBlVmVKQy9XSGpNQVQ5ekI5Y1R5c2tGMXZMcE9pZ0tZMThR?=
 =?utf-8?B?SlJKK3ZJSGZ0K3BtK1ROWGYzcklBdDZCK3RTVS93L3dUQzB1U0phdGFnZzh0?=
 =?utf-8?B?VDlaUHdMcGF5ZW1XT1A4YzhZTFd1WDJJOUpnQzZMSnNMa3lnOEdXSTllWFRS?=
 =?utf-8?B?QWJIZWtiRTVtTWNFRXpDNE9GVGoxYzhMNjQzb2VPa3NsY0lsWUZjTmJjOXl0?=
 =?utf-8?B?SldIb0VwdnZ6OUtwcWxabVF1VnV0WVNPNkx4MnE1aEk2c005NEFiN2Z3dGdM?=
 =?utf-8?Q?f6U4Ia0tgo4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkU4L0dHOGRGTVVPNm1CU0xRem9scmlRcmdMS1hIT21IalhVSUYrTlJHY3pN?=
 =?utf-8?B?aitQZWJWNFZYOEdxTTNwSlc1V3ZQZDBFQkpKbDBRYjRHcnZJTVRpWkVMR0l2?=
 =?utf-8?B?S1Q2c3lQdCtMRVpiUTFLODhMbUlFN3crRTBZbmZxZ1ZzRlRXNU5waUZRVndn?=
 =?utf-8?B?OFdvaHMvQ1o0cHVCZnIxZG9ob0p1YVNSU0QwT1BaRFRlVy9aNGFmSzhLMWht?=
 =?utf-8?B?MlNybzNHYng3MmR0MFZ5UmxlT3ErUTQrWXNzbTU2bURJWWtHcCtuYUJLYnNy?=
 =?utf-8?B?ai90L2l6Y2JudVJRbUdQS0pudzFrakpDaXFOamdEV2hvQVlqNkF0M2N0bDho?=
 =?utf-8?B?WEQ4Y2pzSkhEczVkZmZtbXdWYS91RnhwVUFDdjdkQTY4NkRjV21PZjlwUmlC?=
 =?utf-8?B?YjUrdEl4dmNQRi9hcUVXR08xVG1rUXNEYktCSk91d1M2VWQwOXh5RVMxRGpn?=
 =?utf-8?B?NGlIS09MUlNodFB6RmZkZDFVWUJtWUR3NnNxYk53T1l6QjgzcUp0aE1LY05C?=
 =?utf-8?B?YWRjMWdJZkdVZWRHUDFGNW05U1JCMjlCeGViUW5jcWZsN010MmVBRUFlNnU0?=
 =?utf-8?B?RFh0UkRUdmVVdE4xSTFueHFhK0lMckY0ekIxdlJaLzFJM3h6QUp5KzVYSUI1?=
 =?utf-8?B?RlAzZGdZRVlLYlRZVFFWNXF2dGE1RG1nZktYNlZCcUpUSU55R3VyYU92UXJ4?=
 =?utf-8?B?K09oVG4yRyt0OGRIbWtaVDIzWExhdFJsc00reHdWUFZzbFJvNmV2MHBWUlFx?=
 =?utf-8?B?b25QL0NPdXpUNUcvd2ZDZzdudGU4ZHI2RjJjSGNydHpzVmE3OXpaLzdNcDNE?=
 =?utf-8?B?M2RuNWF5b2ZZRHExT2NCdUo0NFNyV0xIL0Y3aHNvRDhZQmEvdS8zVGdySjU2?=
 =?utf-8?B?U3dFRXBmZlIvUncvcTF2OUdvd3hPdlR0V2FqcE5RZUhwRVRiZXhsQlVIM3J3?=
 =?utf-8?B?cithMkxLcFFEVXo5SkVRdUFqN2NDaHk3dWNTUG4vcnMzbS8zeVh1V2YzUkNV?=
 =?utf-8?B?NTlDNFZpOTVSTEFsSGJuaDFEMzd4VEtUQ3MvV0Z0Z1lrNzVCWjlMT3YweEJ1?=
 =?utf-8?B?MmtGZTE3cFFhb1Z2eEs2cm5CM053Y2l0N1BQelNMOXVJMTc2bzFHT0NNUjlW?=
 =?utf-8?B?eHRYS2dVSmxZaWl3UmdqZDZNRXpwZVRHVXgrWEpUc1R3OG9MY3JROUc2ZHJZ?=
 =?utf-8?B?TEJDRmpmRlpwNHBJSDhjTGp0eUNCZHJaSHg2bGV4RURMMUJKcGV6aS9hOHY2?=
 =?utf-8?B?QjludllRYTJSRGNnQUQyYXFOM2puWUEyRVlRLzRpcGorTDFYYWZoc0xHR05N?=
 =?utf-8?B?cnNDeEg4SkJTV3pVZmRmaUJtU1lObVJGbW1xQzFxZ0Jqb0wyUmFXU0k2YVY1?=
 =?utf-8?B?eUhGQUhqenRubmtjM2RnSlNMVEFqNThaZi80Z3ZCTTN2ZXlNNTdPTmJ5amdU?=
 =?utf-8?B?OFdDOXBVNmVkUnJWOXdGamVBckRPZjRiRlFQM2lHL3oyUEdhbnRhTnUzcHd4?=
 =?utf-8?B?ajhZWkJSejdkZ2RoY1IwNHE3NkRiYm85T2tFL2hwOExQK25CM3U0VWJUSEdX?=
 =?utf-8?B?Y3pZUDRjeDdXZFdublQ1ZEtUSnJLeGNKZi9YWjRPdmRPNXRxNlIvWk1nNUky?=
 =?utf-8?B?VjZwdXlhTTNyRDc2SVBzOXBaRjFpSkpENUY1SFQxNGd5eXFxcGtoLzg5REdy?=
 =?utf-8?B?S1hXZUxDY0FuSUdHcFFETlVrNGgxL1hxZ01XekMxU0VkTGtiYzc2NVI4OWRP?=
 =?utf-8?B?ZGlMWFcxVGJpR21YSkx3U2dVWUhkOTh1NHdvWXE3NGxnZFRsakVKZWk5a2Uy?=
 =?utf-8?B?ZVFRVlZsdmN5QXh2VmxZb3J5d3NXQlhzMWNtcjdZWEwrc0ZzUS9PRmU0UWFz?=
 =?utf-8?B?MEg3ZnhnMmJXVXpLdCtXQ3BYYXhsL3JIdE9Pc3kyUTZwUDVjeDZuS1JJTDlC?=
 =?utf-8?B?T3FRbFhMMWZuLytKNGhqeWMzWFRSR3d1eitqTVlaRFVYZ3lwU0Y2dGZlN2hF?=
 =?utf-8?B?ek9JTzZGVUFpNURzUVdnekFWRHJWbHloS1lYbGREa3NKS2JnZUNIZk50TW9J?=
 =?utf-8?B?cFhhb2YyOUxhL3JCM1l0N0VsK2lGN2tBYkxvUVQ0dUsxYWZBREtzM2I4OXBX?=
 =?utf-8?B?Ri9lZkY2S1pwSXE5b2JuUFh2VFEzVnA5QThEU0RLSzcySmVUNXR2eTZrZEIx?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b81c7e9-1b05-4731-e595-08ddb57bfbb6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 13:10:26.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/gx1uw4DvjMG6eOjFY0B5y5fHpc+aziIZ/3INI4TKvzMfuTwRh0OOvbgZb32YGl2LfdHUlnwQrVp+AvF6gkVsekOybuHa9uXbX995YDP+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 25 Jun 2025 09:11:54 -0700

> Replace the TxQ buffer ring with one large pool/array of buffers (only
> for flow scheduling). The completion tag passed to HW through the

[...]

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index cdecf558d7ec..25eea632a966 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -13,6 +13,7 @@ struct idpf_tx_stash {
>  	struct libeth_sqe buf;
>  };
>  
> +#define idpf_tx_buf_next(buf)  (*(u32 *)&(buf)->priv)

Align it to the next line, i.e. 2 tabs instead of 2 spaces.

>  #define idpf_tx_buf_compl_tag(buf)	(*(u32 *)&(buf)->priv)
>  LIBETH_SQE_CHECK_PRIV(u32);
>  
> @@ -91,7 +92,7 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
>  		return;
>  
>  	/* Free all the Tx buffer sk_buffs */
> -	for (i = 0; i < txq->desc_count; i++)
> +	for (i = 0; i < txq->buf_pool_size; i++)
>  		libeth_tx_complete(&txq->tx_buf[i], &cp);
>  
>  	kfree(txq->tx_buf);
> @@ -205,7 +206,11 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
>  	/* Allocate book keeping buffers only. Buffers to be supplied to HW
>  	 * are allocated by kernel network stack and received as part of skb
>  	 */
> -	buf_size = sizeof(struct idpf_tx_buf) * tx_q->desc_count;
> +	if (idpf_queue_has(FLOW_SCH_EN, tx_q))
> +		tx_q->buf_pool_size = U16_MAX;

3.2 Mb per queue... OTOH 1 Rx queue with 512 descriptors eats 2.1 Mb,
not that bad.

> +	else
> +		tx_q->buf_pool_size = tx_q->desc_count;
> +	buf_size = sizeof(struct idpf_tx_buf) * tx_q->buf_pool_size;

array_size() if you really want, but the proper way would be to replace
the kzalloc() below with kcalloc().

>  	tx_q->tx_buf = kzalloc(buf_size, GFP_KERNEL);
>  	if (!tx_q->tx_buf)
>  		return -ENOMEM;

[...]

> +static bool idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u16 buf_id,

Just use u32 when it comes to function arguments and onstack variables.

> +			       struct libeth_sq_napi_stats *cleaned,
> +			       int budget)
>  {
> -	u16 idx = compl_tag & txq->compl_tag_bufid_m;
> +	u16 idx = buf_id & txq->compl_tag_bufid_m;
>  	struct idpf_tx_buf *tx_buf = NULL;
>  	struct libeth_cq_pp cp = {
>  		.dev	= txq->dev,

[...]

>  	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
>  		if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
>  						      &tx_params.compl_tag)))
>  			return idpf_tx_drop_skb(tx_q, skb);
> +		buf_id = tx_params.compl_tag;

So this field in tx_params needs to be renamed as it no longer reflects
its purpose.

>  
>  		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
>  		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;

Thanks,
Olek

