Return-Path: <netdev+bounces-179771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B336A7E7FE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AA53BA0D3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF72153DA;
	Mon,  7 Apr 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGuUwqJa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21412153C6
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046140; cv=fail; b=dNIVJC9YLmP0KVl7Rw4mfRi58kO/gNQhcaRgn94GMuZ7S19p21LgO3ZT8BU+6SOf3rq+AAkxZIXvKitrFaWUAqg1/KxAhYmn0OuWnqCZjoS2L9NmWZtYzWJg7eV1DovshUv/RVnKYpdXwhvbcyiT4CEZuw+KRskY5ArafwAC9fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046140; c=relaxed/simple;
	bh=ozh90TewXcPRKbxreFCTh4yz2z9T6IqUa7J/cV1WMjI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tGd3u9BxwzEtfjMjZqsRmorYrZ/yZKpODjd7guPCWe031eVlYJHygM8Ltkou8TIaDpwB7X7NVgzygrFDJgK0QykMVBSpAYCazy78MWTebzPCD8ozuuHWK6tNJz3Xqz+6+cA307MIhSbjd+IzV9RJxAVGIm+h5DODNzBx1xMiA2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGuUwqJa; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744046139; x=1775582139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ozh90TewXcPRKbxreFCTh4yz2z9T6IqUa7J/cV1WMjI=;
  b=WGuUwqJaIihfYQvNdKg/Xzy9v5Say0wn50ba7M0s7blrpvMcCKs18GIG
   MMNXRd3SkJcLte/S0PwoGkZJ7WLuOotHY7vhTxG9fZA2p5i1OYsDYkQtR
   BBjeFK/T4aIf0MGCHocTgc+J6Ji4a+1aXzg5dXZHKr19jIm0NfVMRuJ87
   UR+qFHqKy5NkLLdbuvXrih4RGRjXcqfivsxholYPLVIhwrAjlAE/uMuYe
   /jnAnw+jWG7wmiVR6MDow1ga9JfZKOtJb2+Oigspmj16rV2Eo0Y8nSvlC
   KD4KOw9zmiU6Z/piTrIqFdwlR79TvjoUBx8HFVVwifbp4RU0nEldBEGfM
   g==;
X-CSE-ConnectionGUID: Te/0ZFbmR/iFteYVekbu1Q==
X-CSE-MsgGUID: IzZhijAGSEC/88n+AMmjXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56106995"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56106995"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:15:38 -0700
X-CSE-ConnectionGUID: ZSswhw1+RAKdHr5C3t+wVg==
X-CSE-MsgGUID: zTuBpQ+gQ2+OUJzo1mKPOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132865552"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 10:15:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 10:15:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 7 Apr 2025 10:15:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 7 Apr 2025 10:15:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APJUwWo2sr5ZGuiBacAx1FOInfXz/q5UIYZ6o+6KTjvKGRMTwF3t6RAcyyFMRffCC9k3mRIkpVTtMD0i0IvktQW4WQqmFgCGb+L00J/hPI3Fm4r3Np6j+vAppAwCexl1iTviTZ5Kh82qH+5w/ilO/pNx16EHx7NkUgt6g0RE9cR/5OyhL6AH9XoS+By9XcKEewLRMfuD1qngIyaUkIl69jmLSIiXhLheWGeG5L9CPlSWahIYNkvamWf8SaMeUid4WA6oDziULdlCpn88T4iAlJa+fcr0W4RKsyyD5ad4I81iV0LC53YawQ64hg4b0+RGWZ6cPnRGX7+gOXN7dEoo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VsQIjekYKMmhin/5adPbtjIX/r+gw2XDVV5kJRpuNM=;
 b=BXWgz6JJBJ3Pm9q5d9cR7TtBEhovr4fRgBhYHbgXm8vBIU4t3Fkew/TodUx1gKze9l1cKurGy/9M9/2rjHusCyRqI5oY8xpXf4xGDgGY9DV83wEFih+tgBN2eJADWg4NN9lShFbAI81Lyh11mBzfDKm8n2GZNpFNK5gak06cl0MK4iD46j8KzI/nJV7vsEBvxwsX1hpaGby6XnqvCN32uTQcBM4GR0sMgeJdFesCeeZQ2cS1vH1OUwgroi0fu8SbHeI40hhpCkAI8EQDe6KzOLUj6fQ9+ph8eJj2FNCYanYtSb9Npwuuro0CNwMfQWWKQO2rCjnQ9rGRui24EVhdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 7 Apr
 2025 17:15:31 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 17:15:31 +0000
Message-ID: <770a44c6-c808-4b31-aaa5-be8e57fbbf53@intel.com>
Date: Mon, 7 Apr 2025 10:15:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for
 ice_adapter index
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>, Grzegorz Nitka
	<grzegorz.nitka@intel.com>, Michal Schmidt <mschmidt@redhat.com>, "Sergey
 Temerkhanov" <sergey.temerkhanov@intel.com>
References: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
 <Z/O6HAm3GMWe/0aE@localhost.localdomain>
 <7f700a89-7058-4c16-b53a-2e84bbed8542@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <7f700a89-7058-4c16-b53a-2e84bbed8542@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:303:b6::10) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 107e97d4-5752-4755-3a05-08dd75f7cd1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnpWNWYyVGEvUFlOc09PQ0UzQ3hTNFBpVFFsVS9iNnQydGhydmdsTlhRc1A2?=
 =?utf-8?B?dnJCWU04WnpDZWFIN2t2UDlySmZHenFIZGNGNzUyM2dINXhjUm9MYmJTWXJF?=
 =?utf-8?B?VzJDL3JiY0VXeVphSTR5NFRNcjBlVEhNbFFxMVE4MUpnRDc4R3dIb1R1OGhW?=
 =?utf-8?B?MVV5M1VBRVZrQVNhNlY3MUNFUDEvd2Q5UGZ3SitmN3NvMkt2UWVwNE42Q3N2?=
 =?utf-8?B?YVU4Qm9wRWZNMXlQSEVoRnhNK3lEOGdYR2d3WENTcUdkdWhGckFBc3lGTVFs?=
 =?utf-8?B?OFNYWGZZTllPeDV1UEZFL3VhTWlIK1ZxMGtuNWdFWGlDcWdMM2RUZXhtV0F3?=
 =?utf-8?B?VVI1L2hSakpHZnpHOFl5clM3SmZrTGJZVmJ5UzZ4b1Z0WTlic1ZWMHJuQ2hi?=
 =?utf-8?B?VFdiS1RlM1ZabVlzMEhwV3lKSkVJWUYzZzNjMDd6ODBxcENMaFAzOXVBL1Jn?=
 =?utf-8?B?TmFuVWlVaVpueGU1ZDdZRkNxNXk5OGJTOFVwTXIxY1pNMzRVUS93b0psRnN0?=
 =?utf-8?B?b0pqT2lvVlJ1Rk1uV1o1YkVpVmpoOVZVcDBNZGdmWnRBck1PS2NsQ1BOeXNu?=
 =?utf-8?B?djc5ZytvTVdnOVZyUG9qQVo4TTU5TmY5VnZjQmgzbkpOWGh5bWpEazRMMkxa?=
 =?utf-8?B?Q0VqMjVzZ25EbGJBdi9JWTFIcTI4alhoTmE4eW84dFJqenlhbStOVTZ5UGhE?=
 =?utf-8?B?L1pQVmZNSjMxb1N2aWRjaS9KYzVxNnVhR29yYmdTblI5QlFHakMxQ0VQeGVy?=
 =?utf-8?B?aTZONG54cGcxVGp1ajVEcUNDNE81NjVibGx6Zk9GVEdEbXF6d2pDUk0xV3Zj?=
 =?utf-8?B?YkdCT0RTMTA1bldmNTd2VHVMbFBrd0lDYi9kR2tjMHFPeFljZDE0ekdyYXRa?=
 =?utf-8?B?Y1pQVUNPOHpLVjhJblpQcEkvS0RZQThFVThTek56Z29paUJXWFdUTWRNR1R5?=
 =?utf-8?B?cFVGcU5oRmt6SWF4QUVHVGFCemFxRkIxM3VLYXUwN2VDT0VlMlRpZmxQUCsw?=
 =?utf-8?B?UmtMOTJGbXRYb2xEMXNFTWJiWXJRbTJvd0JFSk5WSDZNRnFXcE44Wm9Ya3VC?=
 =?utf-8?B?NHVRcWJ4QThnV2hhUWJqeVRQREtaQzJJd1F2cExqYmZ3RnIwa0loUDE0ZElC?=
 =?utf-8?B?SG9FSXdwOUNIN0gyRnNTSGg3eU84TnJoMzdXbUgxclhhTVRlcDhqcFlRTmVv?=
 =?utf-8?B?MnlqNStQcXk1SmZyeHU2L2tiYms5WW1DWGxGUkhWWGpxY2NNZ1dWbFdTUW8v?=
 =?utf-8?B?ZVNNY2tJM2REQzNDd0g2THp3S1FobDN4UmFRa3pTU2ZQVlAzcWRxUThmOE1B?=
 =?utf-8?B?U1dPeVZSOXdRLzlVU29BNG9GMDk2Tk95ekZnTGt0VitRSEdZN2N3MTl6RFgx?=
 =?utf-8?B?cE1wQ1V6S2xYRWljV2FIM2ptQk9wUW9pWERoNnZDM01JL2h1SDE5TDJJQ3JF?=
 =?utf-8?B?cWdUNlZGdmNrL21UVnVXV1NFajZiR2R6ckpaMEcvZUxsQy9Lc0tQUnlEbUxr?=
 =?utf-8?B?Rk8rKzQ3eTBHZXc1dkdVNC9pbmxWQjYxV2J3RDZpcExoUHRiSHk4TjE2NS9X?=
 =?utf-8?B?UUw4V2I3ZGRVRWZVSmZlN0d5dTZZcW94R1JZaG03V2Rka3VrOGloOGI0ZmRZ?=
 =?utf-8?B?eURzMStoZXY4aFVBSDI5VnlYYUFZUXpCWk1RbEh3NzZmQlppd0t2SVBxSXEz?=
 =?utf-8?B?ekkxa2NlN2VYWmFpY2xWMmsvc1c5SWs2S3Ivb2VPZjBBQzhVVU1nOXJxRDhV?=
 =?utf-8?B?ajFNYlJIcEpGVGQvTkUwVFZ4OFgvRXZxcjZGTmRoYzZiOGRZYzJnRXAyQUp5?=
 =?utf-8?B?ZkY2QmU3UWtWdjljOTBmN1hjNlpCWW9pbmFIUGRKbHR0WUNESEJuK3hnNnRE?=
 =?utf-8?Q?7OLb1afe1jmS1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpFZVI1M044bXdHWkIxZ3NTSXBWZS84Y1B4V2I0ZmdiM0w5TEE4UDR3K0NG?=
 =?utf-8?B?UVJKTzMrQlFrKy83S2t4blRuVDZCa3pJZ0R0UUxYWEhaNnEvcjdDUGduUFFl?=
 =?utf-8?B?UGZra2dhTlkzOXFPczRKR0xvVy95MmpYUUVDRjRUdERVWDNROCs2R3JoNHNu?=
 =?utf-8?B?dGxsSnU1dFJQUk9qaHdYNEI1bzdhYWphNkRlMlFIa2pmNmF0TEFTQ1FLUTVT?=
 =?utf-8?B?TWZWempERHJ4OGF1Ti95djlXZHVMNmQrSGc2OHlaeDducjZOY3NCSC9DdlpM?=
 =?utf-8?B?RDIydUp2aUNtNExxaUpOblFGUkx1VDlqbDRFQTIvK3FnSGhNZVJ3eWpNVDU0?=
 =?utf-8?B?RWFQbnpIaUJRcVI3dDdMQmdhbWtVc0dNQWw2ZjNiUSs1QkhPM0JPbHlDNUV2?=
 =?utf-8?B?Um9qMEtyQTZkYmMrRlh6Mzl3V2cybjZQaGpMcy96RUJRbmdueVJoUStrMVM3?=
 =?utf-8?B?elBvNllVNzEzVUR4VkdrWE9GM1hyRTBUY09DS0lkdDFxVjNmcStLSS9FZVZI?=
 =?utf-8?B?YWptWWU1NmIzdHNpa0JwczRJMG50a3MzeE5BUFVEVjZaRU1USFdDNVp4ZkZ5?=
 =?utf-8?B?UTg3SE9DYjAyMm13NU9BRVBjVnRON2pzVFo0aGxjR2o3ZUt1SjRjak50ZGIy?=
 =?utf-8?B?a1pUMlhEb2E2dmhWemZZTGpVYTFJbGtEVyt3U0wwUWtCbEFubVFxUGZtMlZ0?=
 =?utf-8?B?MkN0d1I1VjhEU05NZjJWTFg1cmxNYlBTclJSMHdPU0ZxKzZ1OVpJZEh5MkJR?=
 =?utf-8?B?VWsvVWNIOWpXVnEzMEIvaHNxZXpxK1doYXJtdVB0WGYySEw5dFRTWGdKK1Nx?=
 =?utf-8?B?M256R2xPSnN2UEtPR3FpV1JuYklLK09kei9TNGlkOGJjNldyMjBSL1NNK0RV?=
 =?utf-8?B?cm0veVZVU0R5Y0Zvdm5Iamgzek5KMm4xOUdlcVZEeU1DWkVnY0VjUDMza3JB?=
 =?utf-8?B?QzQ4QkI2QTdJSEo2ZXZPcDc2Z1M3THpsc1E2ekh5Nm9IYjBiNWFFamdCOFpJ?=
 =?utf-8?B?aENNMmxLUUJwSHFPVGErMGlWYVQ3VU55K0RYVmc5R2lhazJQa1A0Ymp6SnNa?=
 =?utf-8?B?Y29RK2kyRVBXMjV2OXJBY2hBa0xoS2NMVEtOZGJBbGsxTm8yVkRFTnF6UEhz?=
 =?utf-8?B?eDV4Nk9zTXU5V1J5V045R3U5TVdNRDdFR1M2SUowQ2FObHhtMFg4TjI4S0lJ?=
 =?utf-8?B?U3dmczBmb2Nlb3FONHd0Tk53WW40YStoTG5oUnFqL0pmdXkxekNxaUlweDlR?=
 =?utf-8?B?cnZxaFp4MEl5ZURCbXpFL3JxVENCeFlXYUZ2NXJwM3NBaTZ1Y3ZaQUt4MzJ4?=
 =?utf-8?B?MExmTWthT0FhM00zSGR4NDhiaTZqVHdud1poSmpHSFFCVUNoc0RMUTNtUjlN?=
 =?utf-8?B?bi9Fc1dqbTJkRnArK2Vnc296ZkEwMXlkOXY3OFZha2NDU215blZYODNaakMr?=
 =?utf-8?B?MG9rYlZHMGJDYTBTQ2htam9OT3RmWTVGVUJ0NTNhMWNYMU9yeWpNVXRuVGpq?=
 =?utf-8?B?Y0NLalp4S2VHUkFaNnYxYkNDRXBnVjRoOXUxdUVSN2oxdlZ0WUFCWXl0RjN1?=
 =?utf-8?B?WGFJTTAxZmZ1R3h3azZlT0tCTTNtRExKNVBFT25JSUcvQWp1T0t6S0lwemUy?=
 =?utf-8?B?VXk1SDBiQ1k0S0xDQkJhL2hKTlNwNnZvQUF4akdyZVJVMHA0TW45Nm9KbU04?=
 =?utf-8?B?eENLZjNneGRjdjlZc0xHOHlNRUVyUFdubFR3NXJhSDk1WGFkNmZUYXF2VGtn?=
 =?utf-8?B?S09TYlp1QUhzL0N5YjQwdXZlb3BNeEtVOGc2V0VyODU1RWZPdVVhY1diVjEr?=
 =?utf-8?B?YllUQ2VaTXE4UkcrcUNZR0kwd3lDMFE3c1ZsUkZxbVpUTXJmUmU1amtTZlJr?=
 =?utf-8?B?RVJ1SVZEQkQrVFljNG9YS01EYWdvR1dtZi9XZnBjVE9iZVQzZ3N4TnB1ams1?=
 =?utf-8?B?YnZMc1gzNGYzS013SU1DQzZHcXBUUENnRU5HU0pBQ0tLSFJXTllzd0RKbmxU?=
 =?utf-8?B?bGJzc3hXamVkWndtREpXa2ovTXN1dU9kbGYyRkpsRDBkdjJsamRnYTNxdVV6?=
 =?utf-8?B?b0txOW43Y0pCaktqb3oyVXZpOE9UK20rQy8vUnVrU3RKOHA1NUpXN3NlZ1Bt?=
 =?utf-8?B?bERDd2JrYmxCNlEvQ0dvcncrdmY5eGg1d0tiUTVDM3ltMXJFaEFJV2RyeHZh?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 107e97d4-5752-4755-3a05-08dd75f7cd1d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:15:31.7655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXest/B47D/HiebhWScB2QdqaFz9yW81vdXeC6mDL2+Y5YoFDUCVf22F5NHJG5OPDCd+RyPpVkK3ixRYIV74uX0Kk4kbzxCOP5F+iZ8pn5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com



On 4/7/2025 6:30 AM, Przemek Kitszel wrote:
> On 4/7/25 13:42, Michal Kubiak wrote:
>> On Mon, Apr 07, 2025 at 01:20:05PM +0200, Przemek Kitszel wrote:
>>> Use Device Serial Number instead of PCI bus/device/function for
>>> index of struct ice_adapter.
>>> Functions on the same physical device should point to the very same
>>> ice_adapter instance.
>>>
>>> This is not only simplification, but also fixes things up when PF
>>> is passed to VM (and thus has a random BDF).
>>>
>>> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
>>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>> Suggested-by: Jiri Pirko <jiri@resnulli.us>
>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>> CC: Karol Kolacinski <karol.kolacinski@intel.com>
>>> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>> CC: Michal Schmidt <mschmidt@redhat.com>
>>> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>>>
>>> v2:
>>>   - target to -net (Jiri)
>>
>> Missing "Fixes" tag? (After retargetting to -net).
>>
>> Thanks,
>> Michal
> 
> oh, thanks, I wonder if our pw will pick the tag, if not, I will resend
> 
> Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on 
> the same NIC")

I don't believe it does, but I can add it in. No need to resend.

Thanks,
Tony


