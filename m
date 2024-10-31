Return-Path: <netdev+bounces-140664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD829B779B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F31F2122B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFB1953BB;
	Thu, 31 Oct 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QC7j1WBj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8F198E70
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367281; cv=fail; b=qwM6oxuJKhhYvz5nhOWnTk9xMbzK7y7HOkw4qR/bpRVYoRsDwW2/6TVjK3GMuerNFYlOfDdRiifDXErslDaH6MF5XiFJ1I5CHVAc87AyiF2PDZHMWsCH4M+1lUf7YbC+1hsGkgzzqaj8aDzXH4OMB2oCGbdbLc5OrwWgOFiSZFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367281; c=relaxed/simple;
	bh=UWWoJiV0NAJZGUYhyI0J7rsQCdG5NSFMt6BAXWiNng8=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=WhGlKCrLhhO1LGrzNnc/DrijrZ/HCTv5eQ7Y5LZq0uWkFosbVLLM4cCAM+G3yiz54+Hs06kov4KEEx//yGpPGc4gRG/3MmZRPoNLs+RYye/eEEoJEDc222CMI8L0fmUQLQGiWG6ns5nAMr7eHMxhoUHNvxRlG4iPp3zQiMDsdWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QC7j1WBj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730367279; x=1761903279;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UWWoJiV0NAJZGUYhyI0J7rsQCdG5NSFMt6BAXWiNng8=;
  b=QC7j1WBjaVxF8AWUqXkxHbg1pYr5Zmx2klbkNqRzgoExd2jSdYqlW2T8
   ZUpayXQDnhiB4kC3EOsRrBJg+IR6PvBP7U2iIm1MNfGOLDpUIY48ZxlLA
   ICYHrwqr9y3JAEMTsu31HTMxuSlZFlWyJLTeccFm8ROfxc9Zl0cjAfajf
   AroQ/WPw8CKPPf0VUTUG430JNdLUE9wSSqEFl8mqLxQ1ppNT1QXqGSHzy
   pJJZAxlZ9c1mnViJpg74i9Z4rKYZiiWquUOtI6r+zgqv7h6Kufwu9PL0R
   gAmL++qz5TsoJTPgk7oo2AUs04936reFwkffQeqw3iRVUX2TkZ7HDMUqE
   Q==;
X-CSE-ConnectionGUID: /1S4pfyyQgOpqBMGJeiW2Q==
X-CSE-MsgGUID: 4ExKf/AURL+rvIhjJkteTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="34026394"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="34026394"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 02:34:38 -0700
X-CSE-ConnectionGUID: QnyWkhgnR8q2KYJyE+mYqQ==
X-CSE-MsgGUID: UMbfGdwvQkuANTKN1B040g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82231759"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 02:34:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 02:34:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 02:34:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 02:34:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL93H1Ot2q+r809PM+bVc5WASSH6qOuwiVuDvqq7q2j6kfy86/vd7XrKIqN1gVaPE4i6IUMoZumtLvzdgSoUnYjf2ie22v+WAmIgV/YnqvJ9TeCN97ARQehkO+OsPdoyTDkWiyVnHXEIpCnmLK6izmYKU30AXaVZ0J5bNQ3aJKbVCGTYbAMKvhRc4I1IxZnS+eR3OWKo2EnEhprKoFIw/xtvFNDL+jU7U5TOIdGYE4LI9Xp/KDczH4OsgemJfewJ67tn7rKMgRMiHMEwhkZHvE4xNQ08xk9D0e+zB0joZtTn06r1j/xX2PzCKp19puR4c910gHJKh4jJ+in5C6tApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/edV4V6yHVN1APXbvSHPSuA0YZWIHuxQBFtRz42vww=;
 b=THNMtpatnP9NWnY6aaIiB+HaBK2jEZEsJeR0XRpSNgRSBQFXBWwgIqVeH2E25U+tnTSJF1WgSvBVl4iJnM8AWG++E6apseTg3lBRh6iU77++BECVU/RIl8mXwTVUarfDGb1TRcz7wPVWeYbsGiSmTHQN97iGvEs0pr4H1l6WwHpGdMT5QgtAcms+b5TMpS/FUym+Lo8wrzRsCrqEoLD5CCKpgmS2deAW54NuwPmnQvvs8joxd1G/22isDh8IC/V+w0De+j6V+svf/MjFX98+IoWpO/D2R1KYWwetBuMCdsmZy1SQr+vaa8CtvDzUVqKLe7uKA47gagdV1XDgM76qPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 09:34:35 +0000
Received: from BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61]) by BY5PR11MB4194.namprd11.prod.outlook.com
 ([fe80::9d17:67a6:4f83:ef61%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 09:34:34 +0000
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/4] igc: Ensure the PTM
 cycle is reliably triggered
To: Chris H <christopher.s.hall@intel.com>, <intel-wired-lan@lists.osuosl.org>
CC: <david.zage@intel.com>, <vinicius.gomes@intel.com>,
	<netdev@vger.kernel.org>, <rodrigo.cadore@l-acoustics.com>,
	<vinschen@redhat.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
 <20241023023040.111429-2-christopher.s.hall@intel.com>
From: Avigail Dahan <Avigailx.dahan@intel.com>
Message-ID: <705210ab-f868-9248-ed6f-945e5708fbbb@intel.com>
Date: Thu, 31 Oct 2024 11:34:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20241023023040.111429-2-christopher.s.hall@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To BY5PR11MB4194.namprd11.prod.outlook.com (2603:10b6:a03:1c0::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4194:EE_|SA1PR11MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ed7878-6ad5-4803-dcc7-08dcf98f3ae8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW1Fb0VwNXBwclcvN2g1ZFZncUhDTnluVTdORjY1ZTBKWTFZajJRLzNvRHNp?=
 =?utf-8?B?N014RkZ1M3IvZVB2elB4RXZ5UTdnTWwybkx2Zm15NzVtb0VrbG1vUGYzOWtS?=
 =?utf-8?B?ZTlzcEpFOFVnbG1raDB2SDBJOTVsNFpHbUQ4V0NPNEZWNmU0MXNoaDJ6TU9U?=
 =?utf-8?B?ZkEvNXRtMWFtU3padW1DdzI4aVlEMFJyQVZDYzlndDNkQmFqRUZiMUZ2Tmp1?=
 =?utf-8?B?Lzh6M0ZwTThnZkxrMmJQb2x3ZEtQRG5xRm10MFRURFluTzNMUi9qSlorV3Y5?=
 =?utf-8?B?OU1kaUVGK0pMd1Rna1JXNzFOM1ZCRHI4a2xVUDZtU0toN1gvYlNoTzJBeEtU?=
 =?utf-8?B?ODlkNXg1QjFEQmUrNUxuQVJ6a3lYMFRuZ2J3dTQxajk1aFprN3h0WnRiUFlK?=
 =?utf-8?B?UVJtaWhmSVplU2Z1a2dCOEcwMnVrbU80YS9JU0pjOHlLKy9hbVhFN3p3eC96?=
 =?utf-8?B?TDJnSDAzcEFBV084Tnd5TVpEdktpT0NwK3FXajQ5T1BldStORHpiOHpOT0NJ?=
 =?utf-8?B?MlpQK0wwZDltbjlvZHlrMTlvZEU5ZVhNK0ZJQ1RkaFRhL2RFMmtRdFdUamRl?=
 =?utf-8?B?TGhmeWRFLzAyem1uN29teG5WUDE1aFZwNStGdWRjR1ZRM1lyZElnWklpQkFt?=
 =?utf-8?B?TkgrMDFocDlzdmRvbVZORjhlT1Z1SzVldlFyakJKU09QRElUNlFpM25mTDgr?=
 =?utf-8?B?TURaR2c4RThNNXkrWHRLL3NnMDdKTEpPbi9rVFBsMmduUCtVamhZb1Foalhu?=
 =?utf-8?B?RGpvbUJHaGZ5MkhBdjlXT0JCdWRrclVzWVFLb0xjVkZybEx4U0NLYXR1SWxS?=
 =?utf-8?B?eDRucE5BQ2VpbUVHdW1Ja01SK205dmQzQ1VOR252MHZHVExZY1UyOWIxOXp5?=
 =?utf-8?B?YnRoT3h4TnVaVzZUalgrTjdEdnc3NlFpVkZFMVJBRVVIbWs1VnU5bDVSVjMz?=
 =?utf-8?B?clU4a2h0QUp3NHA0Z3BZeHVEQnBFSFFRT2s0Rk4rVGV4emZIUENKUFQ2YndL?=
 =?utf-8?B?cmpyZzdZMzFjNUdYbHQxTE92c1Rtc3hGTHNucHFiWWg2Y0JzaG9oYWQ0Qys1?=
 =?utf-8?B?YkZCSGlGbFhlWXJCQXc3Mmlvc1V1cDgwNGswcUlUVFpsYXhTRTk0Z1JzcDNv?=
 =?utf-8?B?emZCcFJRT1BwWW03VWRobzQyb1FUWTFJSWxxRmxKa3BoRE5PVUlIU2Nlbjh5?=
 =?utf-8?B?RlhPSlNNWlJKeDhrNDFZK3dXeTlncEFCS0ljdytkNkVyLzZtRnFMbTBJZXVV?=
 =?utf-8?B?aWxyK0llcEY5RXpwQnJhOEEyUXNRenRFcHFLdW9rU1UrZjlJbDF1UE9VOFFN?=
 =?utf-8?B?SHRKNDRaRFhiZjlhY2NOcyt4Y1dUR3A0UEdNWm5tZXQzRml3cXoxR3pqR2Va?=
 =?utf-8?B?UzNueGpaOGZjRUFjbHd2QVRYazVuV0lFVFpuaU5OQUVZajQ2ZDlsZ3RrcGVO?=
 =?utf-8?B?a3FNYk9ickN4QmdsRE1YS1pUQ2M2WWNBMUZ6ZDVPaU00ZEx6YS9PbTlYNUpE?=
 =?utf-8?B?WnZob2lwUTA5OUs5WHpRMVYySmxXdGlYSWE3WWRxc2IyRjZ5Mk1hZ2o4YnJx?=
 =?utf-8?B?amU3KzNxZjZ0a0YxeVpGUDIwekdwRWc3bmFIaGlreXJSRU5icFVEK0szcWNF?=
 =?utf-8?B?UjZKaFZVQzlZT1JzZlBWT1JmQTB5MGZYMUhsN0lpQVRiTXNIdFlFbU1kSUl3?=
 =?utf-8?B?dCtIOVJoaW93eWI4Vi9SNllYYUxESFZzTFloZitRQkV5bEdJclhQajV3TUww?=
 =?utf-8?Q?Ke1WMIvrAqknboQimZTKAnCi0ytRZRIepvoKztv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4194.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGFYQ3JxU0lHaDl4U3gzU2Q5NWFHdmNLdHIwbmJMRE9xVk1Sa3V2VUNXMmM1?=
 =?utf-8?B?SXMzd3E2UWtwU2t3cFlUWDdJNzJDRzhxYlYrSnBUSDNWT0JYTzZSZGlONHd0?=
 =?utf-8?B?KzQrZGhXOXBVbkRld0NVR1cwT01UU0ZtaVVBQTFuSmpnajZ0YUtQNStVWWdW?=
 =?utf-8?B?R2pubUl5N05iUW5qMXI3WE5qRWEyUEFFRWdXaUNrb1NlL2lCZ3J1Q1c2Q0JY?=
 =?utf-8?B?dkRuV0NIQ0YwSUN4NVUvQjBqZG53eHdneUZJeC9OM0N2dmJ3bHg4Q2VhVE13?=
 =?utf-8?B?aEp6a083bjNrRGVEMDVHaUdRVDlVV25CSmFYSERiOGQ2a1RPQUNVdUo3WVlk?=
 =?utf-8?B?SWdScTR5c05RUTJzOHVDVll3NXdmS0dObVRxdm5YTDJCYUxkV0pScEMrWlRH?=
 =?utf-8?B?WXdWbTM4VURlbFozQml6a2h3QnRiNTY2TFl0cnVySm5ib2ZGem10Q3NKb3pp?=
 =?utf-8?B?bDFLMFhNZSt5NzVtQ2VWNGVkMFZFSGJPeGhWcjUxNVlhUXMxaURSZmZwSkdr?=
 =?utf-8?B?Szc2TGdmdlBPUERPaFBQOGxEcWRpMHBLdW10QlFOeGVhZHdRNGxobkd3VytE?=
 =?utf-8?B?UHhPMHlrV2FjaVdleTl1RWhSbjZZUFZSNTArZWg1cnlsdnVEclFWMlUwVm5m?=
 =?utf-8?B?aHE3M3JZaDVBcGN1REtraVFxV2hvalBDMXdZSGREWC9Dd2ZpVTV2K2w1RGZx?=
 =?utf-8?B?SW5uS0pJVjJlbFB0TzZGZnkrYmZIOUF0QWtHZ2EwQVpqQ3VPcHRFaGtTRlRN?=
 =?utf-8?B?b2REZlZXSk1wQ05ZVXY5d20xL3IzclR5ZzBsdmhNY2NxNDFXdERLQ012aVFW?=
 =?utf-8?B?YzFSQ2tzOVRkTFg5V0I4Qm5hTUtmdWJqR3ZveGNKNUZMVmR0eEM4WXVROU54?=
 =?utf-8?B?eEdNblJkTGdBUFY3cFVZNklUTTNIY3FDWmhYOTBpRUNqTUNGOHprVUY3ZHNi?=
 =?utf-8?B?WndPS0dVTWpMb2ViVTBzblEvVXlUZXBxUE42cTJ4cjh1ZTNoMGs4blNQUTVZ?=
 =?utf-8?B?bllDTFhnSk05dzRONnhSRnZQU2dpVE9wRzdzUTJOV0lmQmZmbW5kNmRTVzJW?=
 =?utf-8?B?WWgxb05uYW1PaUlxaERvcGcxUWlMRjRXcUJYUkNzY21IbHVKNllidnVjanla?=
 =?utf-8?B?UFI1bGNnaXRKenBTb1pvdm9yVlgxRzFyMXc2NHAzOHF6YVdyazZrck1sTFQ5?=
 =?utf-8?B?MVdmZ0h3bUJwWmtySUtHRytXbXpJYXBGd0ZEZkExbldya0Zsa29TZHlsRzVM?=
 =?utf-8?B?eHFtc01UV2RHdHlTUldpQzVwOVQ2aElQYTFyM1RHUEFYd3F6NzZtTzEzUXl6?=
 =?utf-8?B?RVlGVVlOZlNSakhTWUQ1a3ViQlFFUXhqdTRZaVlNdHgzYzRQSTIzTXZsK1hz?=
 =?utf-8?B?ZmROOEFUenR4R1NaNFJzZ29ZTFJLSHJ3YVM1VVA1N3lBeXRhcFZxUjJQUTl6?=
 =?utf-8?B?blY3b1ptY1gxZEswYkc1bVBjaTJYZGZyQjVBL0dZcFNFNEcrWm92YXJXMlZE?=
 =?utf-8?B?dFIwbmJWSW41Z3p2R3VZblFTd25SRy9JM2VWU1cwUE85S0lIclVCVDJQRm1Q?=
 =?utf-8?B?UzJUZHlEcGJ1TTJielNnZnNWT29EMzVQREo3U3RFanJYSHJhbkQvbTZ4VTBZ?=
 =?utf-8?B?VVdjR3RCaEU2SWh3MXlDVFo1a3V1cngveHRoajJCUVN6Zy9uejNCQ0dkZk5G?=
 =?utf-8?B?a1paQWVrUE54VkZRdmx2bk9nRWl2TXNaN3hpNWlRK2hTTFRDcHM5ZTdNUFp1?=
 =?utf-8?B?YkN6amxQWTlsUjZyZTJXanAvUkphK08vdkV4VkIrM3FkSVExNERQbUpqZU9z?=
 =?utf-8?B?Y0tiM2lramdnd0dpYnBsZHY2QTRGTXQrdENhUGZNeGhSYkJ4SG90RDZNb0M5?=
 =?utf-8?B?R1ZoanFOZitKNmtNNytHa0xvOGhJMkRWQTdTbDVEbUIrQlkxRDB3QWM5aGJF?=
 =?utf-8?B?ZzIycDBEY1BnQSs0UWpPb1E2SXFrREhTU3VBZVZlOERpQ2hyQzJzWVlOVE0w?=
 =?utf-8?B?Mm5wemw3TlRHWlJLbnVvZk9iM2lLNWFreGp4SkZzREdBZmNobWdlaW9Ubis3?=
 =?utf-8?B?ejhuWk1lUjUwYVMyT0RoYTJVQXY1NlhYZXoraUI0cmpORks0QUkwNTlkZlgw?=
 =?utf-8?B?dTNyeTQ3Wk9KT2ZMUy9tc0MwdzBmanFRV0VTUTFtbEtWUGV6NUNXYWVUbG1X?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ed7878-6ad5-4803-dcc7-08dcf98f3ae8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4194.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:34:34.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vzEt/3PetSjhUfOp5Gi6FITiEWRS4E4n63dakXsOiYHSZ9l68M/xs7RXgYmwciGkMBYOQm1mVfuq6zxpAkwVyH29wUr7yX+s/L95Ec/9+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com



On 23/10/2024 5:30, Chris H wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Writing to clear the PTM status 'valid' bit while the PTM cycle is
> triggered results in unreliable PTM operation. To fix this, clear the
> PTM 'trigger' and status after each PTM transaction.
> 
> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>    fails
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>   drivers/net/ethernet/intel/igc/igc_ptp.c     | 70 ++++++++++++--------
>   2 files changed, 42 insertions(+), 29 deletions(-)
> 
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>

