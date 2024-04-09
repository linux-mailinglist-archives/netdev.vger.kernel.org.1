Return-Path: <netdev+bounces-86318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A889E626
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58B2B22E81
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E953158DC8;
	Tue,  9 Apr 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezAIbxCD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59A158DB3
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705808; cv=fail; b=E3aAw9Ex7C8FAVgnoVByCwGsdUljFUBhjc/PHDgXNtQ1xUDfes5FM/5tpkqPJE3YOiWzBLxp1JAgZzSz2bj/mpwv0wMeLOHIkrnDlQ0+NmykZ6W+V9Cqg14JnRzn+8lVvDeoT0/mKlUYAnkArm4ZU6yeHT3ZYwoOtsISnZlgxcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705808; c=relaxed/simple;
	bh=vJv4E/pxWWelYG8bznXKtmobVRJ4eZp2HNyhkr+NXXA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrV1qTeVdl7WEr81paKL2l/3YnOgtFYZ9QHZR3bJLRogrmP/OT89lz00Nc5gtswB+Egkb7pV/Q6R+qVeL9OOPsgptFa7JSlYiI2Ayn9AKcqEKNusJtoqAkgWDFxU9cHnerLNgRcsznoSm9Ghg89ifoxtgw1NOC2jq/T1B9VWxEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezAIbxCD; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712705807; x=1744241807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vJv4E/pxWWelYG8bznXKtmobVRJ4eZp2HNyhkr+NXXA=;
  b=ezAIbxCDCwdT5ZnanSEStwdxMzaOrjlRQKC6da5RGaKuBa8o+LG/tjrT
   6/zrB0doF2ogCSjJ2EbI58J3qu8tio5M0Vura9s7PfJEeWbf+aafgyHnh
   EIZX4KQ6vr5CVoLE7d/vVYEdl2lT/aOl2irOxcEUFRXmrf5nGCr+6HIbV
   X0/ropZdQhZB43B+1gj4Fk4xy2KZhb+PyP5nnbAPHf2+NxMChx4ERn2MF
   SLb36aU+QK0caHC6Ac9/oJqsJE655qBeEL75h6jMuBaR7m9axtiq/wMgW
   F72n94JToLdE6aZbOAx+GHp1zkk+q4LDbh+lecWH43HFUaEjgrO00Nz2A
   w==;
X-CSE-ConnectionGUID: 41NnpyTfSaWQ/uU0h5DYCQ==
X-CSE-MsgGUID: fiDOAcLlSoKSiWn90rNeYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7907981"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7907981"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:36:46 -0700
X-CSE-ConnectionGUID: A/zAg3K+TXKFgNzpdZ4JKQ==
X-CSE-MsgGUID: goifev8/SoqGkvM4DZ3ZDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20944561"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:36:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:36:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:36:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:36:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmk1YW/OhltM7/9qWhLaokdZInUwA+3QBf/9nmRDznt1hyq9xQsao5X4oa7/XeUAfoWBWCVM0MLjfDLhQ3ujZMQtl2BxZw5WtTPGY6bghUSTQRwcERWWJFaoW8ybP3+4pPgWvLl5qua5F+e+x88Ly6VnD6SHwe7DYsfogxs7134cVoCnEaaNeYq+sF6lPoghbwq37GBJEh/D/lRTuqWUPdaRY/BqDEnla3eN2ULCh7IBiQR74rIQ8q5NV2nvdtS6Pno2wi+C9hCgfVGOxlzbIvqD2isT3jU5oy3vIIBTw8oz3EJG7EPtnwQA68WqGjJV51bXsTSAOqPVEv2squlpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FuWJkDo3qnLlx3cAzYQaPrJJKBT1GI8LUyhq8kVpeA=;
 b=G+f6eaCYc2FeGD2y0q2eBRwjJL/nWoX61+1azRYUNLHLNkLd4L7sxF39U6ODVx9+uQTMYI548tc8FYyJMBBkioDgqx6iK7nJXhgc01HKYzDyHBfhR1DrFvoByfm2vELvgee9n1sg3CdK6G9J9tVGz2wuEBTFV+/Ha5I2yGPbyyLAwrW61oIdviEjj3+JBLrCWtR9usuUdt2UUEnWU2bg/iOXB06H2t6TubiEf7drqq7LZeOK42t3xmctTNknLTaVDZr6Udd978vcNAKI5QZjmdSY0w9NM5IVIlrLRfzpXedkKcB6S/Fti7pgSlGKIrhkCwJ6KMTE60o0H+gBGRr6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:36:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:36:38 +0000
Message-ID: <9d0b7e36-a8df-4553-8606-a51314a32b25@intel.com>
Date: Tue, 9 Apr 2024 16:36:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/7] bnxt_en: Remove unneeded MSIX base structure
 fields and code
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-4-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-4-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:907:1::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 927SYQHo3f1DIYrVqAd0nySL0RYMaKIP8HPcwz0deoBT80jCwjt7tkZQSFkljDWthFzVBxVS8p1+07clYQhw2Na69I7d73g3xDT55l/9LuEkBfAG5h4tBS2fg/c4Hg5bK9wJBrs3OsPZvIIvJcAJtY4fe5rDEimTOCs9VPG6jjNppFZVyv4/9Jcx1yf2sfy+Ul+9F+sWZGyURMqiComgkKxlGs3tqwt08DSRiOXaxXnY1bnpL7orA8cF2YvV0+5Hr8bpLfPOzu7nQXXrHeRRtg8icGivA5QCbXqkW3LswZLQIDaszGGWhk8DxQBb1g91RFXUfn+4jX8Lbpgi7uIpvydvcUNW6ElSAXEJGL3E1VsFJd1w6DR7hYX0NpEhVmixcYBbJH/fSYU/1ORtjpi5SwJqc2sioeCGg10WM/XsQ4Z6rRMpscDa3yTtc3oJa7XgbwDtaRs9rgCuBP82GTYuNWqiRHJpWj9K88sBt8c2AQ+ylcMhZ/OhNLr64vCPxa7APJSZBeGgeVE0de8lqezZ6Q+6z/kmmv3z9zCyo5jnCztjb6g5hTwWraV7QJ+A3WVgLZcxSoocO+NdTMkB1ZBWxZnkZ35zlpL2zajeT5xKJTRVew9Jo7qnR8cYhNAgGJF0am+zuS6+2ukffSLZMMuYTfniTlcV9zk+dLAXc/QX4LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpvZS84dmt0RXhOdTZudy9kbVRFeXE1Y1NxWlZPdmU1ZnlGcStGNW1CbkhM?=
 =?utf-8?B?bEp2NE51MnVtVDZHRkdIMTQvb3NjcitVcEttM01ad2lCbVN4OWQvSjk4L2Uz?=
 =?utf-8?B?YTdGcjlzaDhjU0kvRUhheWdkam5YeGp3Um9qcUZPTHo4SjZWWjhlcEhWK0ZR?=
 =?utf-8?B?L3BaVUZyUEdUS2FHQlMzOUhQWHZtTkNGaHlJcTRaeFVSSXJWQ0RRbk5STzBq?=
 =?utf-8?B?eVE0SncrbjV4a0JkZE9yNVpobXNoVnF3Nk03b2s5cU41OGtRY0FSNGNtLzNP?=
 =?utf-8?B?Z24wK1EwcXkvVUEzUG1mOHYwakhWdE1odTdFZDlQVG5na1ZvNGI5QTlOT0ts?=
 =?utf-8?B?VHFhVjkwWk5LdmJvMlkyMXZvV3ExZ1NWbWFNSG1TLy8rSS9QamFaeEJqc3BL?=
 =?utf-8?B?Q0l6SkcwREwwaHRhQ1phYkd0RzJqRmI3R1hZOE5aMzBGUFRRa0pReDFhaHRE?=
 =?utf-8?B?RUtJNkJUT0FCcnBkZ3JtSHNlWWZBNDJaaWJiL2liSHhmdFFIQmRvWDNiUUth?=
 =?utf-8?B?bC9mOVJHcXZleXo5eXRVVG4wOUdPNkZOMnk1dTNFaHpSOWZBZFpvKy9xdHUr?=
 =?utf-8?B?RGhOMjFlOTgwOFNxbDBTejFERmNScmtlQkNIUmQ2WmhJN1YrMHBVS0ZtMzFN?=
 =?utf-8?B?TStVaTNWQUYvNkxKMFZJM0FaemdodmozdGRRbXFJSG5PS3A0TE1wOGRqSmRS?=
 =?utf-8?B?akZVYkd6N3FiOW5QeTJZaE5VZFFzYWdUOEpZWlNsR3duWWxITHFQRzZvSUtS?=
 =?utf-8?B?L2ZhNFlua1FTd1I2SFQzRnJkaEcyVDZSUFRrNE5GVTdEU0VjMzIvYUI1QW5a?=
 =?utf-8?B?WTZJVVlNd1JiSEhUOTNudnRqUGhhVmNQTVNveDY3T1pyQUNWVGYraHdhcGxl?=
 =?utf-8?B?ZUx2VTVsbFVjQytxbCtzeStzRHpmdE9DcXUrODZIZE9OMnQ4RTRTM2ZERi9a?=
 =?utf-8?B?TXdPc0w1djl2OXNQRU1UWjZBQXo0T1V0enFBeUZDQnNvUGkrcjVvK3NpaW1C?=
 =?utf-8?B?aGU2dEhnMTFtang2SnhJaFRiYWxmbXZXSXNRY3ZyeEc4V21vV3V6cmhRN0cv?=
 =?utf-8?B?V1JFRDc2NU95RjFKY2xsUXZ2Y1RkeVVaaDNpdlpiTUZHZmtHb0ZzMGY5ei83?=
 =?utf-8?B?bWZrNklwU2w1Z0FsM1VEb0FkMjhqOWRkakIybnE5T21iSzY1U251UE1iZkp5?=
 =?utf-8?B?ZGZPUEc4VnhiQ1hBa3lza281VGk5MzZnQ2FtazlTNXl0bWlhL0R5bFk1aVZS?=
 =?utf-8?B?aGdLNHQ4SHZDeWkvNHJDMlpEblJjN0xnYWdrNFB5eTZTMHVZNURpUmcyNUVa?=
 =?utf-8?B?UlJjL2hQR01NbFZBcW9BOGQyUTZTdDRCaFdDV1V1cTQ4STQ4SkZuOU40UDZL?=
 =?utf-8?B?U1YzK0V2WjBmRTczTGE1VGJ4Vm8rZmNyOHEyQnFEcFY5Mk9jQU1zUU1lUGJP?=
 =?utf-8?B?dGlUNC8weE8xbEY4bVB1QTg3eGpVeGMvRmIzZGN0a2FFTEQ3RDJTMlk5cVV1?=
 =?utf-8?B?MzQyWUFVSWpZdmt4QlBwUXVxdkYxRGJrVCt5WmtISitjdXMwU0JaOWl5YS9G?=
 =?utf-8?B?clV6bW5VdUxjSzlwNW9hNVBZQWIwaFFRQXhCOUtRL2p2RzNmQ0doQlpzcFVN?=
 =?utf-8?B?bkpaSlE3b01KUFBRK05pWitPckF5RHA2OGdHVHFJNnlsYWVCUGYySU5CeFNa?=
 =?utf-8?B?eFhyeDIrei9iY054SlhrdkZtdXJlNjNFMzFZc285N2hJQU1OdFE3SzliZzRo?=
 =?utf-8?B?eXVuVUJCandvUnNycmw0eTh3cnJySVQ3T0tqQVVpa0VqV2xqV1ViU2hpNmY2?=
 =?utf-8?B?b3FrNmhVREUrUFJkdzFicUx3SXVFSEEyM2JEbk1haFlIU1ZRMEM5elZhbGNT?=
 =?utf-8?B?M1hseU9CUkFoZTFGNkZEazd0a3VJS3ByalhKNlJLc2tYSzhjVWJzVks0aDhD?=
 =?utf-8?B?eVMvSmo2KytKOVBaY2dFTllycjNiSFplTnM3V252Nkx1SzNUTUVITm9nWFVv?=
 =?utf-8?B?cURxSTBGZWRBam41dVVDK0xlcmJqcGw0bnV5Yll4aU1kNmRwRm1jdi80eC9J?=
 =?utf-8?B?Q3RQRXNJd0k1bEVFREQreXlBMXBQOHdtSjVoZlVGZy9qZFNaNExNWU5WWGVo?=
 =?utf-8?B?bDdvUGpoTm1ZQk1KZXhyUDV0RUtDTVNjSW5MMjdIem1DbUtJNWQ5V203ajRp?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0cb632e-8d28-466b-f779-08dc58ede6be
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:36:38.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6cccCOAAadxAawFmgzoXm4Ti9rWy4b9FP4P2+sgkzLLL/Lg249CLXjFShhSDGkDHYahrYVYtCYccDsRilqxIfpw/Fu/BkCeBRcrhmgBqJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> Ever since commit:
> 
> 303432211324 ("bnxt_en: Remove runtime interrupt vector allocation")
> 
> The MSIX base vector is effectively always 0.  Remove all unneeded
> structure fields and code referencing the MSIX base.
> 
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Nice simplification.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

