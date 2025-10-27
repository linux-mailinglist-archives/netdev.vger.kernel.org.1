Return-Path: <netdev+bounces-233107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C08C0C775
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7DC84F4AFF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891312F691E;
	Mon, 27 Oct 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcsVkXgV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F52F28F5
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554735; cv=fail; b=VDHgOY0bLi1iRS6kvcmUeOEteCxc59xClMhcQpU1lgwkKadn+Uz3h/qDnS01PHQ8tdAThvIfyUiQO1tivjsG0Syt9iUs8sJOpCwNPd7VaWXlZO2uoOg3sv9Gk6lbcXPAM2MZcX/Rw2YP1UhA5ZAdIBkDSxrBb5V3sQF03R4nPEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554735; c=relaxed/simple;
	bh=lZa/V5oKMtko/O4RriM938w4TghEFwO1JFYKUzUwa7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gS6RWczOxVWL3xERjlSWBqfZNHbZUvjRSIVy0/Hcqmd5uHHXN5f9xCrf4nf4AYjjVtOaaJn7FyhN0trM2Y+IqUp0ZhOS0QL8m2vzN+3aV2V6RKSy+AccVvl69yC+nmF+algEASA/YzPeann9UYwZ0ajQJgaQH67UvS+irQ7JG7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcsVkXgV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761554734; x=1793090734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lZa/V5oKMtko/O4RriM938w4TghEFwO1JFYKUzUwa7s=;
  b=KcsVkXgVZ/1yIxaSiZ1mwbzAXxhI/6ljdzC+XornRlP8rEMmh19lXbaV
   Uo4V8R4I+lkyW9nx7fTP94ZRe4gcKeTYxFjcze0IGTGp5irMZswuzdQNs
   QQSlINbuuZsHlHIV//ThKFb5AEYhyxfK7GfudaPFigv74K6sP6LBnUEGz
   7TcLQ0BlE1TToLGPsThE4ZylWWpxwpyqOG1BHKCkG4ivYUKAnjahJL/rY
   kfhw/a3+F9ZTY46jHd+UKkzgdLYXt3pqTyodynWE58GAqno94bjh7SI3n
   MP9p2T1ZZ11QEDEmaf5kPMjCyl9qFSxDGpkQzyJxxPpa6FK7B7eoikuSP
   g==;
X-CSE-ConnectionGUID: esB/lm4VQu+6QEIvQn1WkQ==
X-CSE-MsgGUID: MlJRjUtgSuSdSxzS127JMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66244189"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66244189"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:45:31 -0700
X-CSE-ConnectionGUID: 7wKJPKRaRaueYo6ohHurnQ==
X-CSE-MsgGUID: II9K/Cv1QWioYlEodlDv/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="189361218"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:45:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 01:45:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 01:45:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 01:45:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvJo9m663E2xitL0Ulwsqje8Dnl6MjHXbrRbdNOGHH4bfw0oq9r2oSqQ0S2VHo7Rx89oF6JAIxEdxvmo2jiOIeCqyt3b2cD8GR1nC/uj7n8UhE9tln3yDA4Hc3rIyodSlrdlwLpHDTffb7p7spEOWz7EBnc5k+ltLnUQkYccDFKWOM8MFwoA/w5zRu5VXvjAxEDpTyVID8bA9EkIfEWU+0QQRK0xypqOjyFfVV683OMj1NxLEIvj5lwRaC8YPcwBr52gQwytYCCDB2PNN/x8ER7xy47FLzxlJZWkrTsEBtS3gwZW/kF0GcE3pohLabOrsZvC1EREuXYtZdOGzFjbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg/jiLfzZY9xUbSZIZWdkuYpoY6bqI2UoPIeI/eJ4g0=;
 b=gJnMRHjuLVdsjeG3dtexXm0TVxlxD78CXVl8Y0dJzxNe70w0liL2kdacbpQ9Px+0vZn1gdJwXFQiEAFTfa7QQWUX17Fm3oyhG1bMxuWrenMePh2dPs5nDur+/C57uzOCx3siUx8/iOMjxIaPthVzusAo2uySo9IrtthzCMnbZmgF2Cx10Ir3HO0zrRb1oZT4m/qQYKGTTmKSfR5LC1+0mx6DcsbKqfaWubBXodGrGlcn/p3KptLCoEJRPFs3o7A6cdQZQurmpvJKBbqomRe0K3aH8Z48Bulv783RP0S2Jv8ZY6aYMT7dWlc1dF8BC72z3l+B3JIc+f2/wA7I7M2LMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ1PR11MB6105.namprd11.prod.outlook.com (2603:10b6:a03:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:45:23 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:45:23 +0000
Message-ID: <47f8c95c-bac4-471f-8e58-9155c6e58cb5@intel.com>
Date: Mon, 27 Oct 2025 09:45:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] iavf: fix incorrect warning message in
 iavf_del_vlans()
To: Alok Tiwari <alok.a.tiwari@oracle.com>, <horms@kernel.org>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
CC: <alok.a.tiwarilinux@gmail.com>, <anthony.l.nguyen@intel.com>,
	<andrew+netdev@lunn.ch>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<aleksander.lobakin@intel.com>
References: <20251024134636.1464666-1-alok.a.tiwari@oracle.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20251024134636.1464666-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ1PR11MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 006266e0-bed5-4ace-60c5-08de15352b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjBiUWNPbW5iclVFc3dLU3VjWFFKRk1EOG41cktLRFJUUzZ6NU13VkxpUmY2?=
 =?utf-8?B?S016Y3V2aCsvSFZla3pBTEtZK2Y3U3RVa25JZEE0d21EQWVNMENMRXZxOUlO?=
 =?utf-8?B?OTg5eTNlNkxEazJNTmNJZ2NoZHVINFFZanVDaEdkdmVnQnVuVUl1b00wVEhL?=
 =?utf-8?B?eklLemhYczFJb3RwcmFKNHFIS21YL0R5bkxCYVBXeHNIdHBsanMzN0NuOFBw?=
 =?utf-8?B?eXhwVHY5MDVteUNtTlhGTDZRM3FLQkpkWG9tYXowWkFFYXpnU1pHUUJUcVh3?=
 =?utf-8?B?NUtwUTdhZkhCOFpFZk5YeDJTM1pybGRpdXF3MlhaRU1yOWNlamYxYzQ3cVVv?=
 =?utf-8?B?dkpOb1U0K3QrMWdDMjhwQ09vODY5bXlwR1R1ZEdLZ0hVbmNqRmZ6S2dBbzE4?=
 =?utf-8?B?eEg0T3JUOHJOajluZDBtWXN4OHJGSjZ2cENWd1FnNjQyc0swWGFlZkN1Vm5N?=
 =?utf-8?B?R1JVeForQnlQeHBBbCtnM1Q1b3RYNTZnZ0tlTlFKNjQrbVduVEtnODNsWXdj?=
 =?utf-8?B?dms2YnpCTXpmQit2UEJXYzV0YjYrdUJIL1gwN0tOMUR0RENMT0xxOTRqVUdo?=
 =?utf-8?B?a0Q4RmFyTHRZbDdJVDhhWndibVQ5WWRiakpXcHJmRTZyUk9XOTNhaTFkTnpB?=
 =?utf-8?B?TUtzRENTVWhVYW00dzZmbjc1dW11SHE2S1U3YnVLeG92eHNhV1BxWEJGTTBQ?=
 =?utf-8?B?WkkxeDE0SWU4VUx2b1dKWmdUOGprcnlBU2IrSm95bUc3eGZ5YjdlUXhYVGlm?=
 =?utf-8?B?VC9sUGp0eld4cmM0Q2dmVVhtUHBQNCtMKzh4ZFlpcVkyeHZod29MS1I5aFRB?=
 =?utf-8?B?ZkhiMWtIRXVEdkQyQU9NZHZsQzd2V3Z0MGJrWklmaW1QMGZSc2RzRGtkKzRS?=
 =?utf-8?B?c1FEYm0xWE5YK1pBV0ZMb3F2cXlJQUVZY3NnSW5Kb3JzcHZ0OG1QWksyK25U?=
 =?utf-8?B?OEk4eGF1bWpaMWh2MjA0aUZxN2FJZ0JqU1R6SVQ5Qmo0TXhoS0svbVBnZlps?=
 =?utf-8?B?ZXVVcDhCSHdVL3B5Tk03WTZZK21JOG4xWXRWNlJwWTE2UzVCWkw3N0wzYnoz?=
 =?utf-8?B?MmsyUzg3L2UwbVpQUUxjY0M2KzQzZlVNWDFqblRtbE9TQzI1c1BHSElaMkw3?=
 =?utf-8?B?R2s2amIrWGpKdzM5RkZNbVVGb1kyT2JHUFRWL01RSjN3Y2hqUDRxempDRFh4?=
 =?utf-8?B?Z2hjSFhXQWVqSHBOZGhVUDdMdmJYbDcvQnN2UVhkb2J0YnJ2aG1idmtyaDRN?=
 =?utf-8?B?RnduNW9sOXl1NkxvWjJVV3dRSXA0Z0I0N2Q0dmNSS1FidEhnRWF6ZUtPeHBB?=
 =?utf-8?B?RlBpYXg4eUx6bmxwRndvZ0ZyUjl1NDV0S2F1Z0szQUtpcmVqK2ZrdG5yOXRj?=
 =?utf-8?B?UHpaaGR2K1REa0pPMS9pMEduREpiZU5aOTQyZ0lrR1JoQjZBVzgwTWFCQjdB?=
 =?utf-8?B?U1JBc0k3V0R2bWVMbzhBR0xBOHdFR0hmVkVnZzZURncxdVAvYitqVFdQTENi?=
 =?utf-8?B?QVNYTTFLOTFPTldMa3I4RWVVVUlvSEZ4cmdLVFdKdHRRdGlYQ3I2YkJBOUxo?=
 =?utf-8?B?bjBIeXhIYmlUV0JVZ0hWdjMxaE9DK3dlSDBOcEFzS052cFJoWmpXSEpkb0pr?=
 =?utf-8?B?MHB1eWR3OWdNek90c1owYUxsQmpCYWdsMTYzUWlab28yY1N1NGxGU3NjT215?=
 =?utf-8?B?QTFEQ2dkYTdnN3BQcXRRTk5UbFFCYmdEa0dZZnpkOWJuRVhkN3RESHZVWVNu?=
 =?utf-8?B?Y3BNcGFxSzlWUk11Q0huK0RyNzROeDJ2ZDBUTEkwaEFDY1hXNVJFaGpNL2JU?=
 =?utf-8?B?bitGcEhQMGtVTksrRHRXOVFheUF6SGt0ekpiaUk0eitUK0pNekpUMUVMeE05?=
 =?utf-8?B?NmI4Qm0wdCtpZlF5VW5yZEhYQzhTTy80YnRIRmc2c3NLMHhpOUt1R1RFT3c1?=
 =?utf-8?Q?YVcaucKKDNlzK7lR8z8cTFV8mBCiDpqy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hDWkpXWW1vekQ1cmMzSCtsR3N2cDMwRUJDNGlhM09lc2pEQS8rNkV5VXY2?=
 =?utf-8?B?djkyNE9kSG1vWTVWcFBpMUNIeVBkcmIzTWx0VXFjK2YvbkQxM2R2QzRCL1hK?=
 =?utf-8?B?TVJxM0lXRnFOUmp1RUhrTUpnNWNlSXB6SkRDTkZ1VTdRbkY1SWtBU1RkanB4?=
 =?utf-8?B?RVVlRlY3WGh1QmU1VkZWbUVFZWZVaE9hSFpQR3hjNnZLc2NmWDgzQmlHamE3?=
 =?utf-8?B?TW9yaStpaFR5Z2c0WDAzL1JvcFdrQThpdnl6M2RaSG93T3c3aVczdkRYYXpL?=
 =?utf-8?B?RHhPTnFhQ0JnVTc3RFM3V01kR3E4eFVySU85eG44R3FSa2FNd205dytGbksw?=
 =?utf-8?B?aS94ZHJ4MERUSnMva3lUUkdDN3dLL1ZZV0VLSGxRU2FhMnVUeEVQc1p1MmZm?=
 =?utf-8?B?aXBmY00rRWVoaSswVWltQVdEdEt0R05rL3FpbVdSR0xGcEJJeWpLQy9YNVRp?=
 =?utf-8?B?a3JRcWZ0Y3FRWVdqNHJPN1B6MHpYTkcrWjk0OTA4Y1J0N3l0Ykt6OGg2MVhh?=
 =?utf-8?B?NjBzN01wYU8vMlJGS3VyWEVtZ3pkYWd1c3d6ZjBGRWRGL0VjeGxycjZROEtX?=
 =?utf-8?B?ZzBTV2FFZnNVSnE1SWZML0dWN3U1VXBZLzIrakxCays2Qml2UnErMXd5RmJ3?=
 =?utf-8?B?MkcvSm1VNzRqUmVSQnl0S3BMZkRhMkg0S0U3R0FxemxCY3AwQ2xhbnJMbnp6?=
 =?utf-8?B?NkRUblNrODJwRGdkVmNiMGlHZ051cGl1aVNkTDBLZWltbGtaM2JoYWxIRUZY?=
 =?utf-8?B?ZmszckQ4NUsvUjh5Z3pyR3EraUxteURrTU9ucnVQY0s3amhrSCtEUzFXNHgr?=
 =?utf-8?B?c1psMEFaYkJoWStDRUhXZktMYXFQcU5mMzA4K25RbXg4VEZjYVR4TDRIdE5q?=
 =?utf-8?B?MTRIaldTMFpoQTM4cjkvK2ZzVGRrOUVwL1hJQ2dzRy8rWnRMc1QxRTB6NXNQ?=
 =?utf-8?B?RHBlbit0RVc3MjdDSnJtU2VidjFEN2NTaHVEY05ac2w0d3BrNjM0bDVReG5P?=
 =?utf-8?B?cUpWK1JtcFdJOHJuRGpDWlNrWDRoUVVjRVlSN1VBSGJqVTdzUmFRMGJiYlZJ?=
 =?utf-8?B?ZitEanRKY25uWXFlSW94d3lLZlFCb3hvbTV6UUdYeTA1TW5VeVF4Sys5Q0d3?=
 =?utf-8?B?N2VwdisrcVhzYkxxdHBzbWdsUFR6U0RNRGJ2bThoZGJQdWNMZHAxWTZKWkZv?=
 =?utf-8?B?MFJ1MTliUzNmaERRYmRURTNPcjJGc2hVMnJUQ3p1S0pkdGNZd2txd0VKajV3?=
 =?utf-8?B?T250UFpwNkR1VE9Ta1RlM1VRdVZZbWtwYmhmY0JvTUVSVWlNWnZneTJzdkg3?=
 =?utf-8?B?NHM3Um1zQjdZcVV1N0NOQ2lwbWpaZFVRMlBwSXkzYzh2emhQZ3VDQUdRb09n?=
 =?utf-8?B?TFhSUFVUSGt2SDhXNkdvQVMzL3hsMUJvN0hWMThheXdnWGdCbHFzUWsxL2Zu?=
 =?utf-8?B?dkxxZ0RpbXZLcVFxeVd6L2luWTloVW5uYlVLUGk2eXRUZ3NJYnZjYVNrcWdu?=
 =?utf-8?B?amhpay93MXpxOWZvMm54THM0ZE5JTk54SHN2ZERaVHpzSm01UW9KSXY2Y3l5?=
 =?utf-8?B?T09zbmVYN242MWc0a0JwZmJyN1NLc2M0OW4xdElWampwT3Jkd0pOWXlremhk?=
 =?utf-8?B?eTFmVjVoTGNvNktrM0d5MUthc2FkV2s0OTJGNDhXZU1aMENva0w1TlNUUFlE?=
 =?utf-8?B?ZHAzRXcrSURxK3ZYWExoUlFIT2JTSEkxNktGeEc0SG9yOE5JWlp3bldlRG5s?=
 =?utf-8?B?SFpDZTJrTkpoSFQyQXJ1ZHhpKzU5cmI1L2NWSWNMNGErZ0hJdnBULzg5Q2Zj?=
 =?utf-8?B?cnhhTzdEUWFzSTQ4MmFJU0xEVm9Wc3p6cmVIYkFCRC9XZVpjVTgyZW8yejl0?=
 =?utf-8?B?Y0dYejBWcG5sb0lldXdydWg0Ly9maW96VUMyQ3p6N3labWZZdmZGeXB1Vmdn?=
 =?utf-8?B?RXczRVB2MmM1K0t0NWhzV1FPTWlkWkNocXVPTWhPOXFlcDBXUUdKbnJYNVYr?=
 =?utf-8?B?OW55bWs0c0doOHV0bHlqU1pTam1NRzBHWG4xaTg1T0ttNnF4WnlTQ0UxVWgw?=
 =?utf-8?B?U2JjckJQMVNmMmtwR2ZnekU0bkdpb0pqQzBrMHJaeEJ0TldLMllLQ2FKT1Nl?=
 =?utf-8?B?Q3l4SUF2VmpXZHNNa2RzUnlLVGF4UDVmMDl0NTNuaytmeU9HcDJISk0yRmNy?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 006266e0-bed5-4ace-60c5-08de15352b02
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:45:23.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FG4ss11H/CLrVYTnJV6uNg2QUygwt/hmst8SFs49oK6AqCe1XEXVjYciXasSBtt+ikuAcIB8jMXJGLOpr6I/YhE57WEmK68Sc5ULW48tttQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6105
X-OriginatorOrg: intel.com

On 10/24/25 15:46, Alok Tiwari wrote:
> The warning message refers to "add VLAN changes" instead of
> "delete VLAN changes". Update the log string to use the correct text.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 34a422a4a29c..6ad91db027d3 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -987,7 +987,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
>   
>   		len = virtchnl_struct_size(vvfl_v2, filters, count);
>   		if (len > IAVF_MAX_AQ_BUF_SIZE) {
> -			dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
> +			dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
>   			while (len > IAVF_MAX_AQ_BUF_SIZE)
>   				len = virtchnl_struct_size(vvfl_v2, filters,
>   							   --count);

As Simon said this is a clear copy-paste error.

But the message itself is not great:
there is too many VLAN DEL requests to fit into 4k of memory, so what?
driver will just split into multiple virtchnl messages (with the "loop"
for splitting is put multiple call layers above from iavf_del_vlans()),
and everything is expected to work fine (despite the fact that this is
likely not tested frequently ;))

I would suggest to also lover the log message level to info, and
rephrase as "Too many VLAN delete changes requested, splitting into 
multiple messages to PF",
or similar. And the same for ADD requests, the same for v1 message
(so 4 cases total).

with that there will be no eyebrow raised for the dmesg reader

