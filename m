Return-Path: <netdev+bounces-139618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833369B393B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75621C2157A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB61DF96C;
	Mon, 28 Oct 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5hX+z6k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18896175D25
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140494; cv=fail; b=NYRr1YgL11nWvT2rTHVniPqgCRFIPFOGnZkY6QoJFhxE6kZ/KQg4aUb7A7SeN4RIHaaUoyA1v8vBYJ/m3gDknjBBxClj+P36eGqs0C8PrEBULSDu4z961/GpdVYTNFCx18KwSfHMHQn8wmq1GA32ng7h4eouGQoJVrUrRoWyJYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140494; c=relaxed/simple;
	bh=E1CMkQdfyEvV/dG+CNTS4X3FpTbF5+GTVEh/+tUjUsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mhON/fSDIVClq6WVnu0+1rl5mIkcP0PIaVNxoZfK8yH62bk4chhnU0IuS7m3tO1kNt72GZ1hDqqP4GR7SFTlcYKNnZb/gBtJapb2fNPNWd2P7IIjnYNtFgL6WQpxxuSM8ji47RdP60mZ9lBXKoFyPv7K2i6dl5dRICLY2yl8ni8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5hX+z6k; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730140492; x=1761676492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E1CMkQdfyEvV/dG+CNTS4X3FpTbF5+GTVEh/+tUjUsU=;
  b=D5hX+z6k8zo/m0OPonYR45KTexZ4QBpZYFKah9jTq3jkBVwCvuQnvlFK
   7i082NZJeD6Y6jGcWsdJ81NKCs9VDXHOZXE8Q1lidtUADy5mNkSZ8hBC7
   0loxq00u+F4PHPWVi3UKfXfyGCDXIfVtk5m+g/VPjUFxhlhcAiEmpzI6F
   zK/Inary9w//r7Qk+kk7MyXrhxr8ZS9Ir8CG0oCwPTM3cfQrlrM3iDHOT
   rb6wIGVPTviKMZ9IOQpknPxCgLGJUO2tM3XdtlIaCefljpjuke+YA/xDM
   T+WcyveKY6wOu17rcXcVybZ5P7qDtTR/te0QS/YFC4DqGy0gJRmSt+Rwh
   w==;
X-CSE-ConnectionGUID: F3E5FdJWTVKNkrMnCGxxfw==
X-CSE-MsgGUID: 9WoohfMHRxm2SK+efqgnhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29181394"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29181394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:34:51 -0700
X-CSE-ConnectionGUID: qjjwfRvLQYiByEMwikgbew==
X-CSE-MsgGUID: us0pj/FCR1Od5yTaJjn5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112520506"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 11:34:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 11:34:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 11:34:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 11:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKMMuARS7nR/yN51201kpZZJb414E56jSB4zgz5nmFdxMYhRx8WhHI7FgdOdXCWJK0VWhm4zGsmqThoIEawduDM2mwEwsfNLkWJDpF9/Uh0pOoKJtyYCJhIOxQ7U7ESmt8JTdD4oICL5vWVfbjyJhpOnsZkscsx9V6+wdCXE+kTmCBmdhkICyedrR9t/qw+zX19y5WUeaJ5jwHbYFmprUeYnIY6rrp5AUNOjKUCAGSLXvkFnCa8CC4RIhkudWPYfIhs1gJpfDcd/pQX3yHp6CGZ93RTOWI0cz2Au2J+BLLdPELPLsgAIvb1IxkLoucIvxfRWqJzl6DteALyn1HKGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVAgHUtiOj3YV8SJf942aH5lGMarweskRV5quaqkKGQ=;
 b=uiRbfwcxorD9K+MLvWl53ytiFCGR7IQUt3ODt2osM+KUV51AlMzRkQ8Him8MfwpmzbOnSqnbFC7Io2+L+TelmLAHyLQ5/alSUWe5gV0cerxHjqVSnRigxmVDN10uuGgUg9V0GVt0fxKZe9dyHagtfXC6XL8RdIlEVbF06H4ATTMFuhaAgFl5aWiOsfRTqFQAuDGdqBlZMqamGtKOKPOTCHvlYiglHaU8GKS2JGpGV6UzErpZBL8dSj30nsc6dE2YDxVCcOXaAMZJXTthUj+7bLIaMXHpJC8Wc3Imob/wnn8b5WbYLvz3NQzLIKeJjyJARFeKH5iPJzBo0vP6xlH2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 18:34:48 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 18:34:48 +0000
Message-ID: <9341c65c-89bb-4fb2-aa5a-d6f1506b2431@intel.com>
Date: Mon, 28 Oct 2024 11:34:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ethernet: ftgmac100: fix NULL phy usage on
 device remove
To: Jeremy Kerr <jk@codeconstruct.com.au>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Joel Stanley <joel@jms.id.au>, Jacky Chou
	<jacky_chou@aspeedtech.com>
CC: <netdev@vger.kernel.org>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
 <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241028-ftgmac-fixes-v1-2-b334a507be6c@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ea15be-f284-450e-2169-08dcf77f33ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVY5NHVQbGt4VExHNGtxQUFoVko4QmJkQkdPN2tCdUNpcGNITWIxS3B6Skl1?=
 =?utf-8?B?OXQ5Um5hc3laeG9mVDBaSGcwZGlyMU0rcmhvdVM3UHNxQk42akxXR0t5Nkds?=
 =?utf-8?B?bU5NeHJ0K3RxYWhSd1NEVXpZVWdDZ0d3Rm4rVkZFOWRtL0dneE02NDFuQ0x6?=
 =?utf-8?B?ekcwcXNEZmRnemxZNHY3dE1ZcFIyazlhaUJ4Yk1ZaEl3U3dLaFNjRTJGbWVF?=
 =?utf-8?B?RmVuSHFXMFh6N2RFWlRtd3kzUndmdjQ0bWd0WUg0SXkxVW13NFo0Y1R6N3FI?=
 =?utf-8?B?dmpJL2VVdmFVZFRJa1hHN1R4Q0REcGgzUXVTamhIK2dDKzNkNlZKRnpJWkpY?=
 =?utf-8?B?R0FzLytRdWJlTkdwTk9NQ3VwbUlGWGFUTlVmV05jdEo2aTRyVGRWMjVtVThk?=
 =?utf-8?B?VG1HeHRKUWM1V0FhUEVCRWJabEdQUlpDYXpWL3RaNnljejBmRnFPbjZuaWFz?=
 =?utf-8?B?TWZIbWhlMVhvRFZxbDdsMDNVQkZjMmZkMmxRcmY2VEdWZFVTRk56dzJpN016?=
 =?utf-8?B?OEY5RHdRamNrT1M3TzkzVEt6WTRZRjJ6eUZvRGZmQnNjSk05VjdqcTZiREpE?=
 =?utf-8?B?cHRvUXpKT05GVHQrZzJ4QVJzK1JuSmFoWmRycWcvNituZjRlL24xajdEYTNy?=
 =?utf-8?B?SHhyQ0VXVGlrYmc5NkptdzFBblRxU2ZvSTEzRHM1N2g5TWNQd3EzZlRKYm84?=
 =?utf-8?B?ZFdWVytBanoxYlJLK2ZVbSt6UGN3bWpwQnlyZjJvei9iL0ZaS3V4aFRDbU50?=
 =?utf-8?B?dG5wdDlJTktnclNMTVJRZTVxbktkaGN5V3JKT3hZanFpWmc0WmJlRmtzVzdC?=
 =?utf-8?B?SkprS3I3c1FDQloxYXVtbjFwdTIwR2ZNcUZNQjlWWlU0Z0pZSmNpdTF2djVp?=
 =?utf-8?B?KytXYjM2OEoxanozMGdPSnpyMGtKYVVidFBFK0Y5NTJTcG5iemRWT1JTS3Vh?=
 =?utf-8?B?aHFQdEQvWFRsdnlNQThXcHY5VzlBYS8vaWNxUDh2WENLdk85NXk5bUxHNEVD?=
 =?utf-8?B?SmtoNFFZY2VhRlJ0emtLcVdYOUt4OTVSK0s0NUl3R2loYTdrdnVHWHJTL29s?=
 =?utf-8?B?ajRvcExyRnRseStnOGF3emZSVmJOdXM3RG9yT2c3UFdPZENhejZNaDZad3Ra?=
 =?utf-8?B?TTA2T1ZTcjFRaFJkUloyOG1YdzA2SENBZXFqajRSeW5XSmltOWttc2h3ZTkz?=
 =?utf-8?B?ZmRaNXlGZ2RHUmRGeFEyNUJwbk5WcnRMVDFkTXlGQTgxMlFHWFNzT3pQMk0z?=
 =?utf-8?B?R0Y3RVlVdWhPUE83NGowSVJkYjJGSE9uMWFHYU9pOVdQZ3V5OGFVRHlUTE5F?=
 =?utf-8?B?STJIMmFXTDdGdzhybmhmSUdBRW5SdEpWLytrK2cxQUtwdmNrNDBuOFZsQi9L?=
 =?utf-8?B?bVVodklFSGV0a1VYd3ozS214a05qUXd1eThyY1kwenp1TGlnZFVJT3AxTzds?=
 =?utf-8?B?NUE2TEl3eTlxMWtveUhObHRQNHN1WTU1aDZhQjVidHA3RG1oTUdweEFWWTZR?=
 =?utf-8?B?bEg3cTZwSThCMzM4VTdydzdWdUROZDladjFLVi9MblNyaXo5bFZicXAzdTZE?=
 =?utf-8?B?cnhzUUV2cE1iNTIrUml0ZmFIL0I1SlE4MDlkbkM3aXBiWWl1UWRXaXR6MitB?=
 =?utf-8?B?cGpJOS91STZWajRRUTZOT1Nhb1BNVnF4YXhCcWJoOHdpbnhiRGNtNE4reE4w?=
 =?utf-8?B?emtUUmZrbmlIamczNnhic21SOE5sUkZqbWhOUFhUZG5tc0lsU0dQZFEySzRk?=
 =?utf-8?Q?Bka4OPAlyu3iTzXJ+3bGOOVyUxrgJjjde6o9PNe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNaaW1vRTdqYjhhQStPa0ozY0thUHhaVmF1OU9pbFo1eUxrQmx5SVZ4bjhT?=
 =?utf-8?B?c013U2lIYldaRkMvR2Qrako2bldnTU5EWldQNGJlcG5rWUtHN0ZGZGdYN2dS?=
 =?utf-8?B?bDRYS3VnWUx1Z2ZsNnhmUkhpa0xjSVJDK09Cc24xd0c2T3BLbkd4YTBXa3Bj?=
 =?utf-8?B?eUhWR1k5ZUdQVWZBSHlpYUM2Znd4UlE0TEtuZ0EwNWJIaEdqeHVWOFQxTHV2?=
 =?utf-8?B?OHJEam1FUjZNNExGUGF1ZGpwRDUzMDJyZExGaU5tUUdBU3JnWiswQ3VQbnhi?=
 =?utf-8?B?V1FyWnBoWnd1RzdmME1lYkl1bHRpYjFldmtBM1doRXRGU2cxbGswaXh0WkxQ?=
 =?utf-8?B?NEs2SmxRS25HLzMveEk5VWRoeHlmMVp2SGlkTTVTMVgyUWsvMVU5eHlSMURv?=
 =?utf-8?B?QnRkeHducG0ydlF5ODJxbzRvejBFdkxUUHY2anQ1R1FlT09CNVNPZExmQ29N?=
 =?utf-8?B?dVhuMlIxeDV3VmtMais0clVOWXluM0hxamdDeE5yY1V0SVNMWXRmSTN6TTBy?=
 =?utf-8?B?dUxyMTJSa3N3c1AyZ2Z3ZmNIc2c4NmR6b3lpd2xsR2doOXBNSUpCNFlaQUJh?=
 =?utf-8?B?aDl2RjFZU09nNnJmZXkwem9JOXgyZVROUVVoNUR4Z2NaNWJvZ0M3OG0xbERu?=
 =?utf-8?B?b2hwbzdIRjJsNElxL0NtRFY1M3pZRk93MEhkSklkV2RqNHlmeG9rYWk4VWNn?=
 =?utf-8?B?dzJxeUxHM3FMdUc0ZXhMNjBtUXZsQyszek8wdmxKKzFxMnk0RVQ1K3RrRHVR?=
 =?utf-8?B?d0lDRWtYTVVzV0NJNlBYMWNDTEVXQlROUFZDYmdoVjEyeWRjVDJvaVNCKy9L?=
 =?utf-8?B?NlRiQ1laUUdCR2lJQU1pMFY2ZmZaTTVBeXBmRmxuWVd2SEtCbDQ2Y2cybDBs?=
 =?utf-8?B?VDdVY3FFWmwyT1NDRVpFeHhRR1g4Q3FUN2dva2hDSVVSQitpeGM4RnVzYkNB?=
 =?utf-8?B?dHZHY0JsaUh0SlVYZVF5U2prSWhJdkZzbGpPWHJXamQ5eUhvNTNkbk5lQXpU?=
 =?utf-8?B?MkFINExxMG1VUzQxcUF0U2htZjJnL09rSW5MSHE2cktVUW9MYThHaytUS0Uz?=
 =?utf-8?B?aUVnZmFKVHZZMTNEeUkvSVdKZ3liRVpWOHhDUDRGWDg4NTlqUGFUd3BndzhH?=
 =?utf-8?B?SGlyNjMwdytNeko1UVpjYzJCVzZyU1dHTk1jcWxyeHplZlpQdjg1MVdOWC9Q?=
 =?utf-8?B?MmFCTCtVd0tScE5qUHp4YWVlY1NrODE5eWRQTU1GNUY5RHJabHpQVWhrY3hJ?=
 =?utf-8?B?QVBRblNBUVMwK0lCZGprOFF0cXJ6aUIrSzRwN0cya0JNYzJ4V2JZTlVaOXcw?=
 =?utf-8?B?blNlelVVSC9TdEZWWUtvb3JEREs1SjZZcjRmUXlBWmNBU1ArZkQxYi9KSDJ5?=
 =?utf-8?B?dWdFR2JCa0lqcGFxbXJIN1grbW9nMUNXZmh5aUdwMnE5NytzQkY4RHhJWlAy?=
 =?utf-8?B?VHRqWndSK0lPR2xiWE9KczUwMzRSLzZHSzM5Z0VQUUFveEdQVUc5R3FSUm1a?=
 =?utf-8?B?L0FtUWZmdFl6WGhuaWx5elRFVWNCVURleVJvYVV0SUJyRENXcno0cUd3QTBz?=
 =?utf-8?B?MFMzYzlXU2RDd3FyMmtYRjZMbmJmM0VJMm91QnJPU3V6RG1QWVRXQjVaQm1W?=
 =?utf-8?B?K1FJUlM2V0pueTdqbmxLSnVpVzJRQXVBeGFUR05ZU1hLVnB4ejNQS2RjTGty?=
 =?utf-8?B?MnYwanl6eUZ3b1VnWVgwYVR0WjNkREZuU2RFWm54N2dSSVIwNU9oVzhXU3V2?=
 =?utf-8?B?SWlvazRLelZDZXFWYzlaWWViLzlUWko0Ym1jdFQxVXVkNHlSTEhRaUZlMkk0?=
 =?utf-8?B?MzJTN2FjcllWS3JHU3F1YlVQRXAyTDhENDR6VSs1OWRnTUJwSEcxS1pTODds?=
 =?utf-8?B?cVIwdzY2T3pYVzJjZzc2YmNoRndyQkhtRTRFejFnZnltZWlGL1VaZDcwL3Fl?=
 =?utf-8?B?cUFJMVlDdG5tUklWL2V6Y01VSkwySkpCTlBZNG1YSE13NTNYNXhMYTN1azhK?=
 =?utf-8?B?bTBBYVFSM0dZMHo4RW9lZ0xDTzd5VFJHeDR5R0NucmVLSlJydTFKcHhLdEc3?=
 =?utf-8?B?NFBtRXJDK0t1ckNHWFowSDlaZVIzZGdQQ1d3Qk4wc3dYQUhDMGFxUEl2UlJq?=
 =?utf-8?B?aWdORW5CcXJGazh1a1VHenZBSHZkUVp2T2haczlOZUZ5bWdQOFFQSGFGQlAw?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ea15be-f284-450e-2169-08dcf77f33ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:34:48.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFpsjUb/XRUcYAMoHs1v04iZXUR9ZdoyUwlqztyk+2RNdxpURnE6rKbD2+IvXjMnCJ+Hoof350Ravq6vgXvPoegX64OxxqGT6ArJ3OHNL3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com



On 10/27/2024 9:54 PM, Jeremy Kerr wrote:
> Commit e24a6c874601 ("net: ftgmac100: Get link speed and duplex for
> NC-SI") introduced a fixed phydev attached to the ftgmac netdev for ncsi
> configurations, cleaned up on remove as:
> 
>     phy_disconnect(netdev->phydev);
> 
>     /* ... */
> 
>     if (priv->use_ncsi)
>         fixed_phy_unregister(netdev->phydev);
> 
> However, phy_disconnect() will clear the netdev's ->phydev pointer, so
> the fixed_phy_unregister() will always be invoked with a null pointer.
> 
> Use a temporary for the phydev, rather than expecting the netdev->phydev
> point to be valid over the phy_disconnect().
> 
> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

