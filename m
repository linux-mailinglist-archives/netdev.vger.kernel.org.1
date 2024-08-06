Return-Path: <netdev+bounces-116257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0939499E8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7971C1F22F5E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E115ECED;
	Tue,  6 Aug 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iA91uSPp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB371EB2A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722978819; cv=fail; b=XQc7IuZTO9HngfPs3IhgigQTgMFG+0BUBF8bEwncVKMD7qU+BUv2uT8AXv2xE2nX0sCV4nBWP53sUtbcikRyXkILmxNkqoGOg4sQmjilI59KlVVAziiWWg7A6jR/ICH83WJO438sXhX3hbFxtOU5CdvxwaTlguYPGu2d/xGRLpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722978819; c=relaxed/simple;
	bh=QDFJ+QulvHRDyOSznlvybfP8OfzUjFbMd8kdYxOV2/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qvKQKWL2UBojjpT3Hcc5WY44pk+RtvBwyJ+iGtX7iLcptMWKG7GTmzuWpySSygot5nECbMb9f8ZkR4gLXVmGH0p3YQQacY4rw8mgWZZjCePrGeSORiz7FEt/z9peyr7vfcW4d7ELi/iOC53CkrEnpfPx6eFKfX5NptInXDBCShs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iA91uSPp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722978817; x=1754514817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QDFJ+QulvHRDyOSznlvybfP8OfzUjFbMd8kdYxOV2/4=;
  b=iA91uSPpaubsl8ZmHyFPfmNcD/1YpLJDvsRpVkDm+mpzpkesSc8VcbOz
   VSbNjRGSBtfuk5hNPHJIGvQpurGfiekAgaJAxD0Co8gtYA23Lgiigg49Z
   cE3QB9KGjJI8RTmFw7xLcMUTiVDU1apT//2siXB6ztIwr7U/jpo6wfmYA
   5fH0x6A4L/PBwNrQnbkX4nsyfaTQjpUnNgCshwIs8DqjPrX5DEs5PQw5a
   pSSuHQugigcDbX9OXiQLRSEQXcYS5zo7w+oFejvwgD/mfP/3mhTGSBznC
   awp0ew5DFEy+WK76xEuJFvVcJxiM5ZONIO9Jb0XHR2mFUU5JZqO3QfoOu
   A==;
X-CSE-ConnectionGUID: R39CZ0HJQIGBqJSoyACuIQ==
X-CSE-MsgGUID: AXTNwTpeTNGbANYo8aoDBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31654773"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31654773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 14:13:36 -0700
X-CSE-ConnectionGUID: RMKmIfljT2aiXcs69i7NFQ==
X-CSE-MsgGUID: KdAkgsR0SNSCvyzIgZRUQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61015932"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 14:13:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 14:13:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 14:13:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 14:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HChEH3VZoUxjiTChUsttUFfPhZoKh3FdyJitz7Qsz8Y5uC+gRCo21F4pPPQWidx7Blpu9skakv0W9IV86JOxVJlSFiC9RHs0DALhAipu8mWf3ax8y77HNrHx6/Mufp6vDlNCZGVT6BN02kmSVb4Mv6KGUHoprL43jpjyJe5/7A1wehx1C+q9ppkptKKWwJ3RFcR4ifM2ISXP0IOyOhIJT+44xU+B28495IIzYrJF0P8yIojsu7E0f9Zjx7gqOx3fp2bzfpNJmSK3CsXO2Ixpz47x6BI77xjNwlYRIUvYHa2ttmLkLE+5sNw5R9jp6Nqk/VfZVDWE4cpNCkQa7b8lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BDVvxun/mTEGw1O+qLIZWX0HqcvKFyZAheCh3Lv/y4=;
 b=SHXkzaR1DqjCAoAWVpg6XIHqkRWGrFTOeztr4Yxklvpa21SeRHZXVgzwtwNmw1vbRHVYkNA9GaMknq8Hp9SSMcH+JgRxruYShxXt9yX0YVUzHVumjTTzWhwIYLwJ38lMYGdp6zxFN3n37xuHk8+CU2RhhbmO3bphiZ0S7P/BzmdyMrvz82eFXpGmua6kppx9DrAw2ipCpTL9q6/yuLTRabFACg+pcZrJlma/lWRLNwCYsLysZrXN7GaBV/a7VUpsjbFfEkdbxckVKaggtxgtVyJwWHpvgR0VIJxnBDkriRgJbjRGYxoUaxyvTNigDEY+ZU1UMxdidz5+e+bdJRfl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Tue, 6 Aug 2024 21:13:32 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 21:13:32 +0000
Message-ID: <1717b59f-2fc6-3eb6-9659-c950e3f9d3b2@intel.com>
Date: Tue, 6 Aug 2024 14:13:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 00/15][pull request] ice: support devlink
 subfunction
To: Jiri Pirko <jiri@resnulli.us>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <jiri@nvidia.com>,
	<shayd@nvidia.com>, <wojciech.drewek@intel.com>, <horms@kernel.org>,
	<sridhar.samudrala@intel.com>, <mateusz.polchlopek@intel.com>,
	<kalesh-anakkur.purayil@broadcom.com>, <michal.kubiak@intel.com>,
	<pio.raczynski@gmail.com>, <przemyslaw.kitszel@intel.com>,
	<jacob.e.keller@intel.com>, <maciej.fijalkowski@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
 <ZqucmBWrGM1KWUbX@nanopsycho.orion> <ZqxqlP2EQiTY+JFc@mev-dev.igk.intel.com>
 <ZqyDNU3H4LSgkrqR@nanopsycho.orion> <ZqyMQPNZQYXPgiQL@mev-dev.igk.intel.com>
 <6e5c9fd5-7d03-f56b-a3b9-3896fbb898ba@intel.com>
 <Zq3Td6KFXa1xNxo5@nanopsycho.orion>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <Zq3Td6KFXa1xNxo5@nanopsycho.orion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS0PR11MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c0e3fc-0a50-4eaa-e368-08dcb65ca064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SENIZzhCbGZkKzcrMlRsUVdYT2RMSEwvVW5zd3pOK0dxTlJQUVdaTlhLZCtN?=
 =?utf-8?B?NkNkUzBtdDgreXh5eVpsdVVtM3k0eFJQOGxOQ21zdnNZdUF3Qy9XcWMrbEg4?=
 =?utf-8?B?cnI1dlFJenpPRjM3cktVQjBLc1NOQXQvS3pRWlZZSnZFNzZvQjZRNk52bzQy?=
 =?utf-8?B?azBkbC9UN0FhR29pZmpmQmVoc3A1VkZLdXRsdlBVelUrMjhuUDFZb1gwdmJZ?=
 =?utf-8?B?MFpIamJYdFdNZmVzRWgrU0t2amI0UDMxV1oxS2YxNnhmUnlERWpQZEJWMW5S?=
 =?utf-8?B?U0V2OXNRQjE4SnhGaEhmZkljNVZoZjN4MXZqT3R1Q3I5OUxmNnB2K1hvSTM0?=
 =?utf-8?B?NkJMQzNZS0VZTWlYMU4vV2ZUaXBTUXkwWGZ6RnRuSVhaVlBNY25NV2M5RUU4?=
 =?utf-8?B?aUtVdTNzcHAvOXA4WjRhT3dlVS82MENNLzJpUHRSdmxQeUtGWjVPZy9yRm5J?=
 =?utf-8?B?WEZpY1o3L1oxOGJTR0JqL2t3clhiWlhlNDI5QVVHTzBOa1JLSjVKWHJoU3Ni?=
 =?utf-8?B?NWpMV09rS0dpK3phL3E3d0NVTXk3MjVxamg4WWtkVFFOaTI3ODBCc0lUZld2?=
 =?utf-8?B?a29hK1BWODhSS2x1WjNYTmdiMDdhRkJSdjExaXZaY1NTcy9LSnB2MSs0OVpm?=
 =?utf-8?B?NGU3QVNXSko2V1JsQ0NxdnFzV3Z1VkQ0V2FCZzlPODJoQTZydTVkU0hTWEpY?=
 =?utf-8?B?dnZDTXNDc1RLWjNnSXdsdVRoaUFEbHBPd1ZnOC9BSmJiZlRuN0hiWWJlMHRI?=
 =?utf-8?B?U0dGS0pRVlgxT1lCK2xiTFdYVm14TnI2ejdsSUpTSEY0b2NYcTRrSGZ1aUp0?=
 =?utf-8?B?WUVpY1lTMno3QWZtR2VQVUFQSHlNRkdNb0d4THM4cFh0dWVrbEw5emIwQzlz?=
 =?utf-8?B?RlIyQm5POUtSRmpLN3lscHMyU2ttUUtQNDNRdDFpV1JKU00xbUVOcEJRV3V2?=
 =?utf-8?B?ZTVnWDlIWEtWMEVCSXRFbm1Ua2FIY3crQ25IZFY2OXBKODRpTWdoelBOOGFo?=
 =?utf-8?B?VzE4aThXMkQ1NzVMOGxRR2c5VTMrZk81cmlqS1NsS2tYNkxRNHNscWhEVHNS?=
 =?utf-8?B?eXVzbTF1ejFvbUVOYjJyZTB1VU53ZEVFZXJiOHVvQlRKTVhzazByS2pyZURI?=
 =?utf-8?B?VS9OMlZtQTFWaHNWR2tEMHlHQ0ZrQktScCtrQzJjekdmbWlWMjdnemEvbFdK?=
 =?utf-8?B?dDVHRlRKWEQrSFFQTHhGL1ZYclVpVml3NDJzWExDVDFmYUZnUFpyWG9RZU5p?=
 =?utf-8?B?SDJiNCtINFZyaDJPMDFOK2MwV1JRdC81VlFldWxuUURQRXBDV3NlWHpKZHd6?=
 =?utf-8?B?MnhLVkxDbG5zRGVqcjJqeThWallFWnk3Nlp4Uk9IQy84cTJMQTk0OWpKN3dB?=
 =?utf-8?B?NkEvVnBOVnIzOHZTOUcyNXJWRjlPMzhOR000VWtuTWVZY3ZhMkdoSk5CdU9X?=
 =?utf-8?B?UE1GdjNEajFDRkRWWCtJVk02WnpvcTkydXhjdU81R295blFQckcyQzFKUXVD?=
 =?utf-8?B?Q1ZwUkdnRFFyNTdXcC9pMGIyZGV4L1BTRFZKQmFuSVB3Y3FxUVlRSzJ0d2Q0?=
 =?utf-8?B?WDVmMlU2bm9hNitUV2ZBakpoRDMyVEpqVFVpQ0FidDdyWGo5Vkl3RklicGFE?=
 =?utf-8?B?TUovdlhGNWU3ZVBHVHFGUHJTUDBCbEdrWkFCWTZzUlVQcTc3d0NNbmJwVDZU?=
 =?utf-8?B?QWF2ZC9ST0dhSHg0YW80SU02K2NtY2JqdGluMjdNNlJqTFd5bG1aZ1lQd2F6?=
 =?utf-8?Q?LcenTuQwlKXYWeK6HzGl3/CnZm78hQ2e/N91aaa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wllkb2pZUGtWcGZzb0FTSDR4MzJsK3o2bWdDWHU3ekZDVzYvVmUvREZrNWMz?=
 =?utf-8?B?dDFLUjZXMjdvaG05aTJyc2FRRm5YbjBXTVVsUTNJWGthdXJHajFSZzRtR1pm?=
 =?utf-8?B?akZtNEg5SmhmVHdyem1tTE1CTTRROG1UWDFjU0NNWU5oNUNXRDZYakhVcGZT?=
 =?utf-8?B?eW9jRzNpbjFpVHIzWXE2S1Y2dW5HeVcxeFl1clVkVHozQUhKTnpYeTZvb1RD?=
 =?utf-8?B?V0lFV0pKS2dINjd0L05TWFJJMmJVdDN6bVZ2QXhjYWU2b08rOUN6MDZwYWps?=
 =?utf-8?B?ZmZhblE4VUtlK0p6ZFRGUEwzNlFxREZDVDh4QStWZ2VmekdnVko4ZC95WTgr?=
 =?utf-8?B?dzFMdWRRQ0lqM08rbE1WOFN6cWk5blRjdEtIMk12bEdQOHAwdC9acEhqQkt4?=
 =?utf-8?B?R0FuY0hBbzFVbG5HVjJSUTlKTjBOaTViRmVDaUFtUHZGcXpGUnJsWTNZWUVE?=
 =?utf-8?B?cm8yUlhPZm9WRExSODNrdG5XRlNEZ0RZdDdXZHhKZktTRCtwcjdiVjByTzBO?=
 =?utf-8?B?emZiZU90NHdwV05VajJFRjcwQTluRGowWDBVWFkzemJkRUMxWlQ0L0xZcTIr?=
 =?utf-8?B?L0pKN2hoV2ZoVEJUdDZKK3p1RnVRV09SMVFqbTArWmtzNTRHUHlEeXBXSnFJ?=
 =?utf-8?B?d1BpdXNyaHFkODlaRFQ2Vi9HaWVoS2ptR1VmeUhMVmRjV0daRnJWdWpxY2VY?=
 =?utf-8?B?aDIvYzh1UlFUby91RExyUVFLQU9OdlRwTGFQZHFqRnJmWWZnQ01Fa2tvcnJw?=
 =?utf-8?B?K1QwMTFOUDZ1VzRPUmxqeG1oaXRpOW1ENFhPWXZxUFVlTVhITzRjNDRUeXJp?=
 =?utf-8?B?TDEzRzBJbjA3eWE5NUNkZGY4MndpektvNmJybUR5TkYycGhKQ2w4dzRtRWMv?=
 =?utf-8?B?M212czdvSmw0bS8vamQrNFlKTGQyQUhIc0srN2pNWjNQVWhxKy9IbUZkU1Z6?=
 =?utf-8?B?M2IxNlYvOVdZQzhZbVMxYmhSdG4zMDdJczRHLzdRd2s2OGtEemJqMTNaN2lO?=
 =?utf-8?B?T0RUbGNWL3dTQ1pmVHZFd0FZU0t0NzBoSzJyU0NTVnRET0dzMWYvNHhoWHlm?=
 =?utf-8?B?SGw3bS9uZjRab0pES3d0YXFSZWNDak5PdnRUbElDU1F3SmliaVB1Mmo2NHY0?=
 =?utf-8?B?LzRSbjBxZEltVTlJSGxYMmliWFBmR29GaXNnNEtUZVUyR05vSnpQd1pManB6?=
 =?utf-8?B?c3Y0WEdpWW51MEpxeTAyVVo1ZCtZL0x1T0RRVURzMFJYQXpOWnZZUWIzcEta?=
 =?utf-8?B?NDgwZjRMQkRuck95ZnFnZ2hsMFdxMTZvQ2EwanFJU3VsUzg3T3pTcFFMV2Zu?=
 =?utf-8?B?SVJzUXRNcnNvQWJ0b3NpM21UL0ZXc3pvTFpUZUJyeDhaUFAydjNnSm5LTk8r?=
 =?utf-8?B?WmdqaGU2c3JJZkFJTGRheWxqYnlucVg0anZxKzlIay9FL0s1RU1WY3pNc1ox?=
 =?utf-8?B?L05vUXRSaVZPMUZlVkdwQi9HdkdDcEF3RHRRU2VIM2R6M2V1ek1WemhlL0Nr?=
 =?utf-8?B?QVBETllSemJXdjNTaFBuOXhzemdzY1R4dms4NWVuRHRyaVkwSW1GcXZHNml0?=
 =?utf-8?B?Q3ZlellFRlFORUlwRkhyUUlJc0Z1L3ZQbWd4c2JQcjlQZ0xESW5lcjh6MTMv?=
 =?utf-8?B?bU5EQXVkL3kvWVBxWkpnTC9PWW8xMGhTb1ZNL293RzhrL3czUmdEbHJ5OFFq?=
 =?utf-8?B?TTNMN21tc1V2ZGNJOGs1RVNlV1M5VDBzY0xjYWJxRkVLMHVvNDJqUEkxMEYw?=
 =?utf-8?B?WkZLelhuVHVoMmxsQ21WZzNWSWJTSWx4aExsVDJDWDBYZ1NHL1o4RG0xcVVS?=
 =?utf-8?B?Q084V0I4blNmZnJ2L0M5S1ZaNWk3V0VlVHA2Zk1scytmRjlMTktvTlVWUGdD?=
 =?utf-8?B?UFY0ZVo5UEJMbUJ4NkYvRk9EelVueEJod2tmejVnVVFUTXNwQThYZVJkeWN2?=
 =?utf-8?B?NWtReEMxOHFjSW9NbHdrZzhwQWttM2tCWEErcUNHZUlSV0hRbndCdjV6T0JN?=
 =?utf-8?B?cmtTVEMweEpESnQxMWMzWElWVWJLUHk0NktpVmRFUFhjcjhWdU9hYlU1Y2ZJ?=
 =?utf-8?B?SDNxN29Lc00zamtZcmpVNVdtaWZUZGFGZ0hLaEFkdWRPbElMVW5vZ01YMGh6?=
 =?utf-8?B?RVg0MjZ0SU1GenBiOWgybVJZby9WaW5KbE1ML0JZZzR0RWw2bXU1ZFJacURx?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c0e3fc-0a50-4eaa-e368-08dcb65ca064
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 21:13:32.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41hEHYqd3qzVsTZXbdlHBgqXaM6DqrlGKHLGWwLBYWAkIlETPPs8NP+q43f/9T/m7kPl6HygW6yXkf1eDaQPxuHtuDPUhY6SxNZo2ibqT+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
X-OriginatorOrg: intel.com



On 8/2/2024 11:51 PM, Jiri Pirko wrote:
> Fri, Aug 02, 2024 at 07:38:34PM CEST, anthony.l.nguyen@intel.com wrote:
>>
>>
>> On 8/2/2024 12:35 AM, Michal Swiatkowski wrote:
>>> On Fri, Aug 02, 2024 at 08:56:53AM +0200, Jiri Pirko wrote:
>>>> Fri, Aug 02, 2024 at 07:11:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
>>>>> On Thu, Aug 01, 2024 at 04:32:56PM +0200, Jiri Pirko wrote:
>>>>>> Thu, Aug 01, 2024 at 12:10:11AM CEST, anthony.l.nguyen@intel.com wrote:
>>>>>>> Michal Swiatkowski says:
>>>>>>>
>>>>>>> Currently ice driver does not allow creating more than one networking
>>>>>>> device per physical function. The only way to have more hardware backed
>>>>>>> netdev is to use SR-IOV.
>>>>>>>
>>>>>>> Following patchset adds support for devlink port API. For each new
>>>>>>> pcisf type port, driver allocates new VSI, configures all resources
>>>>>>> needed, including dynamically MSIX vectors, program rules and registers
>>>>>>> new netdev.
>>>>>>>
>>>>>>> This series supports only one Tx/Rx queue pair per subfunction.
>>>>>>>
>>>>>>> Example commands:
>>>>>>> devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>>>>>>> devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>>>>>>> devlink port function set pci/0000:31:00.1/1 state active
>>>>>>> devlink port function del pci/0000:31:00.1/1
>>>>>>>
>>>>>>> Make the port representor and eswitch code generic to support
>>>>>>> subfunction representor type.
>>>>>>>
>>>>>>> VSI configuration is slightly different between VF and SF. It needs to
>>>>>>> be reflected in the code.
>>>>>>> ---
>>>>>>> v2:
>>>>>>> - Add more recipients
>>>>>>>
>>>>>>> v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/
>>>>>>
>>>>>> I'm confused a bit. This is certainly not v2. I replied to couple
>>>>>> versions before. There is no changelog. Hard to track changes :/
>>>>>
>>>>> You can see all changes here:
>>>>> https://lore.kernel.org/netdev/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/
>>>>>
>>>>> This is pull request from Tony, no changes between it and version from
>>>>> iwl.
>>>>
>>>> Why the changelog can't be here too? It's still the same patchset, isn't
>>>> it?
>>>>
>>>
>>> Correct it is the same patchset. I don't know, I though it is normal
>>> that PR is starting from v1, feels like it was always like that.
>>> Probably Tony is better person to ask about the process here.
>>
>> The previous patches were 'iwl-next', when we send to 'net-next' we reset the
>> versions since it's going to a new list.
> 
> I still see it in the same list. Same patchset.

While it happened for this pull request, this is not always the case. 
For situations like this, I can add a link back to the iwl-next version 
so that it can be easily tracked back.

Thanks,
Tony

