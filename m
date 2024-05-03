Return-Path: <netdev+bounces-93338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AEE8BB353
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B621C20A3B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4DC22339;
	Fri,  3 May 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doxGNtnA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81D57CAD
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761440; cv=fail; b=m6lhJwa1kEWeDCFyOD+7T+kXJmUZCmswYRKCVEKiGCdU2mbIgRtHqPeDMDTcnl/lZALq22wRV14EHrHm+VpbJ0pSCorNvQAhTPM4LPZWLr26svKCQQJpvDwJykjCQnvSWd9bzJNPbpLyRN9S2MSeBBCkXyU2Xih1OuJWFrtLkts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761440; c=relaxed/simple;
	bh=gKposcBL4YOls8PKPrx9cVrnjxUD/9WIv3PpwvMXOz0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSWRqlhQ3AV8Ownig0ku4KSABjKBDwmy5M5SjZ6gxvq1zvDuWzYj3f6p6LDP+7/RnYS6Jeq09MBYTAxpmwPzWU+3FKk2DbgHUG2eD+PtNxoMYL2KIzxw15bwRBEhcg1StSF8ViPT/OiXERmtQhxlFNTec95bELdPwL2o61N3pFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doxGNtnA; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714761438; x=1746297438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKposcBL4YOls8PKPrx9cVrnjxUD/9WIv3PpwvMXOz0=;
  b=doxGNtnA4dlQlnmB6QUGV8rx3Kbwe6zfPwzekeljB4MXWuX3c71pL53T
   o90aMELAMpGmQnG6Pq4/8lFF898pdlE55N53Y2fEwEoJADTd0EvIRKxvI
   jym05qP4LzZuAXxwKj2QpMMvy3HMVur7j7HliKA9+mHlC67aZgLU4dsA/
   O8yqFyeE2ER0l6NaRbVl9dDD7RySgNBmUkkZVUy+ZpZitZ7BHeLvcuT2w
   lxgidNt74UiB9LhzwJLaQzSm93wDy9vovxLJu6nZbABizYgOdlxe8CfIt
   Z1N819j3lN6AP7gjVzuyPAiA0gXEyLKuphDQpibmlImiTn8qXoyDzqXYR
   w==;
X-CSE-ConnectionGUID: quRkbmezTvaPx9JVCAdUsw==
X-CSE-MsgGUID: ByQla7eZQWKsoqbffSTFtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10458033"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10458033"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:37:18 -0700
X-CSE-ConnectionGUID: tKVXfmJoQ5+eQg7D8Vgklg==
X-CSE-MsgGUID: jMFPmUOkT0ax7LnctTlOsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58730945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:37:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:37:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:37:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:37:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqvFtZPRqA/Y3gPxlzftQwnyWqCE/ubYmuIF5iFREUFbDm3D9vJxgUMRzHoZPdkVB4R4CCOPaKclEBVBAIU9ALzP4+vOLVQl1JodaIxaqr4OP7qnaxmu9icB3Kw8LbTHGMNr+TlDKzPjj/VQiZY9pK5YLRxKIXo1IuV4EN9TeiMrVeVSxCZvYtBd/hMj0EXbbZ3MFDiFphFE18OkGTo2WiJGQkS6NWOFACF147DzadJgQUzXK2qtoQMCJoB1AQkmQXRpf/PY2tA/WxD8fIz5xL0XNOo7MoYcnCukU2YknrCExeNwZVqY/RLntmKpKvO6i/vh+ghdZhVyPuzwEFuinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcyLFk5rtB/MmC7a6q67mnTDXYfTrqT9yU6zFb9pLPo=;
 b=IdJtdL4rWxMj8Bb0lx+Bk3EiOcnZAnxWHbaCR9Osk+pRnGYkKXu6FRGwchXN9gfwEzQYvhT0GuwFHzamSXD3lMFoDQXcreJxNjIYBI3dMc7yJ5xC7F3hCWMgvIrVhg42VS8ee2dvRUNwmKLRA2xDjskLBXlsJomCtCDnnvKKG3YZgQ4nGGWk73dYJCUsrsBhvvRSoeO7L0d5apvbQhLsNWUMUaI3soONBmB6hwJDRaJNYer36ILULbS5Yp+SSxP+cY/9g4b82KIYgqbBzo8qMZz7nb7eunsSqFrN+xoLRoEsi20ILDgPnQRwFw4InGsJ1Vwpw3agkSsWuEusF2yaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 18:37:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 18:37:11 +0000
Message-ID: <cbe874db-9ac9-42b8-afa0-88ea910e1e99@intel.com>
Date: Fri, 3 May 2024 11:37:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Non-functional ixgbe driver between Intel X553 chipset and Cisco
 switch via kernel >=6.1 under Debian
To: <kernel.org-fo5k2w@ycharbi.fr>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: abd6834a-ea24-4d8a-2b7b-08dc6ba00bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVIrc0VDY1ZMREhtSHpPeVA3bDRqSW5rUEVNdHBSVHlhaGJIandaS3NYbGhl?=
 =?utf-8?B?eXF3elRaUkJpRjJ1cXhkOEJBMElxaWdrZmg4V1IzMEIxN0RKRmI1dlppV0Ez?=
 =?utf-8?B?RjAyOW9QeTBKaEVNTDlhb2Q4UmxmSUVvRWlneDYxQW5oMXI4bldvWDhhMlB4?=
 =?utf-8?B?cFo5ZWREZzRSUG9RY2xyZ1VyQ2xlcFpub1FwT0R6SWR3Vi9tZ0N3UHd5WTZV?=
 =?utf-8?B?bGZzUm5zTXlYTkhOcmV2Z1Bmb1M0R05zSzllWHFvNUlyZzZaRUk0bWNHKzYw?=
 =?utf-8?B?WE1wTC81bm9QTTFrK2Q1U3o1bWRLbjN5M0VsR3ZZMVVTbUVaQzJiYjJJR0ZZ?=
 =?utf-8?B?cER6ZklidFpvRVJFOWhsYTU0cTBrNHdtamtZTWZrQjFuZ0M0cWpBZFl2eGYv?=
 =?utf-8?B?U2RSTU1yeHcydTBUK0lhNThsdndlQ05aQ1J6TnJWVURVKzlZb2VRa05Ma3JG?=
 =?utf-8?B?dzBiUXY4ODlKV0hyZE1WSk9kRW5jdTBodWdCR3NST1FnSEw3M0VXSkxQSlRW?=
 =?utf-8?B?YXovWTNJRVI0SHRzdHNNOVlhejdTV3ZYTFVJMko5ZlNjRi80MmY0SFlCV2VM?=
 =?utf-8?B?S295ZmlhVkY4TUQ1Zkk0ZmtaNWlGZGRQTVd0THdiTStwNTN6elROQ1JqamVV?=
 =?utf-8?B?d0RXeTJROEtvRE5DdFVvYU54MnRjV2FuV3pSekpPYUtNWnRPNDdtVkR5ZHdR?=
 =?utf-8?B?cy9MYjVzU0lJenJDT2FuK0tKUlpBbzM3OWNraitYZEw2d2pJbStyY2JiMzZL?=
 =?utf-8?B?TlR1VnpMQUZsb2lhZkVRKy9XK2E4a0NveThQWXFTVHhlRVR3a3hQRXZDUyt3?=
 =?utf-8?B?a3RtbXhvbEx5QW8wa05uaTErb0h2cGF5Vng1VTBCSFViZjdGQ2ZMV2pUVUR1?=
 =?utf-8?B?dXZRVmNySGQ2WlEvWHdnOTJjM1BWSDhkRUVhUUNyVndPR09VWDBJZEF2cUY2?=
 =?utf-8?B?bEd2MEY0MTd4RzF2N3hhV2FrM2laeVNodjg3QWJxQWNLa1U0Z1hzYm0xWEI2?=
 =?utf-8?B?Sk1hcUt1WXo3K0RBd0hmb3orM0ZzeUJZUXpNQXRsZEtMYXYzakRXNU4xWFdX?=
 =?utf-8?B?WGtvK1E3OGwrTHhWR0MrZFJqTlBFZldTc1RRYldheXloNkxudmV5UVRWcXVj?=
 =?utf-8?B?TUduR1JmUTFzUTFsd0NhaktkQmpOamJheDdiQUZPWUdnbytWYVZGcUtFaW5I?=
 =?utf-8?B?VzR5MGU4bzZwaEU5VzNLd1h1dm56cXluUjNnYUlQbS9pSXJvcE5ZYTJJVmNJ?=
 =?utf-8?B?K21ub014YWVycmJUOHRpSHVxY090M2VVRWNrYVlWbXB6VXh6cW9zZXQwUmpn?=
 =?utf-8?B?a2ZxS2lyZjdTcElHc3AwWlNyczBDWDUxS3hqYmFLRzJ1b2VScHQ5YWhBaU1Y?=
 =?utf-8?B?b0ZDOC9HK2g2RFBnVkJnWmNlVzBndjJzMHhIUE9oZkFpK2trTXF5dk1kall4?=
 =?utf-8?B?V005WWtma3l1UHN5dWVmL29XN0JIanVMQjhpZ24zaWtIQlh5aDQ4ZSs2Snpo?=
 =?utf-8?B?VEhHblpEM2dwcnZLa0ZiYkhGcFFMaCtscmRQZVdhbmhESmdyUXd2RTFRRE43?=
 =?utf-8?B?d0tSRmk4N1RxR1BLdFQvMnYvSEQwWSsrOHphZUhFMDlwVHRYWVh6K2RQU3kr?=
 =?utf-8?Q?ooNJrd1amfojbI5Qrg5d36HsegBO433y8X4VQB234Rh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdNWW12Q0lXMmxMNUdmZldDVS92NkhnZjA0TSsrakdONzRSL2d1TmRUeDlQ?=
 =?utf-8?B?UWJ5WDM0dUN4NHAyVkF0dUh4SXVTNTg3b3MrRGoxZEJrMlBMYjlyWW9VZ0s2?=
 =?utf-8?B?azhGM0FTSk1MNFJxUjZ4bDdKa25BTFBicFZtTkdqbk4yZndPeHRtN3BQRnRK?=
 =?utf-8?B?RzVHZ1dpNk0yK05YNVJXWGxKNytnNTVtUHV6QkphL3RBcnpKWXRzQXhaNEhU?=
 =?utf-8?B?WGdmV0RMczFJWmZMb2xlcEhvZ1dKWHdFM3V0S0R2MTEwNWJmK2NHdm8vN0Rr?=
 =?utf-8?B?KzNIcU5SRFl0ajlJZGRSNUxlQUludEpRQTg1aTBuVDdKRU5CN2RSaG5DL2FT?=
 =?utf-8?B?ZnVjZmxqOTVsTERtQTFoRDJlcmlOZEtQcmNDKzlmckZJQTRZbUx5eCt6Z3ZY?=
 =?utf-8?B?bHFFL0YvaGRZcDV5NjVGY1pIQ3VJQTI3ME9COW54SS9MKzJ5LzFjWHRyS0Jr?=
 =?utf-8?B?NGhzVTRETGFZcXdNS090VnRNNUlUdmhkaTN1WjRIL1JkT0ZFNXdwWVBDdW9S?=
 =?utf-8?B?WWo0ZlVqcklwWDY4YnVQZ0RDSXUvQTF6d1JBS2pDOHBSS1JIVGczVmZMYjdD?=
 =?utf-8?B?aStkdHBGQ09vdXg5SktOYmVEN0xqS3NWSTVxemxTNVQzSFJYWjRDdm9HekJG?=
 =?utf-8?B?Y1FOMTA2MXRrTTdMZ3VMWUU2T0xIalhKR0NhVC8wZXFqemFnMXV1b2swVXVx?=
 =?utf-8?B?Q005MnVmKzQzKzdKd0ZYWVk2RC9kUXhRZmVPNGlwaTRLcHBUeE9TNVNFZ0FG?=
 =?utf-8?B?a2tRSlhqTFIvSHRHaytqWndMVll1Q1E4ZTYwalVTMVRacEhPYVE3bEUxV3V4?=
 =?utf-8?B?UkhxUWNZekNhQ1ljZTVtZVAwZ2x0aWpiWnFZWU9PbzJNWDNnclhSNFpmRHlC?=
 =?utf-8?B?SDhCQXhDK0NlanVIeWtsYUZTM25ud1R4RzhRV3BBQVYyM1lEUm0xZ0VzNjFS?=
 =?utf-8?B?a0FmeHdsU2xwbDZoSVJ5Y2JqTTlQQksxVCtnTm16QlR5NmJqZVhUWDg2NlUr?=
 =?utf-8?B?c3F4ZlNuOEVqWkY2VkE3aVdRY3I3K2FQeHNQZUtPaU9ONkY0L3FDN0wyZEx2?=
 =?utf-8?B?R1dVbWcyTGVZM2srTnIxTlFkcU5QbVRtUDVCUE9CN0ZzS2xOMWliSHJmWGNK?=
 =?utf-8?B?OFJYMDBKa3E5QVBoZnU1YlRQN1VVeFFsblFHaEkwbUVicWczUzI1Y1hJTlli?=
 =?utf-8?B?dll0L3pPbWFFYUU1d1JpcEhvdWc5aFVpM2J2TGxkeEJPLzBzNWRWdlBicDgy?=
 =?utf-8?B?bjJ0d0Yrby9SWHBndVUyYkRJR21idUY5MTA3ZzBpdHFjRlRUMk95eWpwWmNj?=
 =?utf-8?B?WDg5ekpzWHZ3SzkzeDJsQW1xL0xObTVjQUZuNDNlQ081MkdXbGRnRkdFeEE1?=
 =?utf-8?B?R2ZvTW9XQzJacjFib3lKUjVzL0thalV4eUpyZEsrakxqa0x6YnYyRkg2R2Zp?=
 =?utf-8?B?ZmlnZGlrdU0wZWx4MDdocEloRTU4WC84a1dGOHRUcnRQYUhJU1JjbnBjcDBD?=
 =?utf-8?B?OFFNb3RRVjN2eVJDQVhFUFRwWE85YnV3NjhmWEJmblpCOUREaDQvQklJRGRO?=
 =?utf-8?B?bmh2OUtFV1Q5NVpickRNaGdzdHhMQ2dVU1lFYzY5bUlSK1hOR1BDWGx2V2ZN?=
 =?utf-8?B?d3FreitycDhPSnB3K0hpd2owU2k1TE81a0ZwdTQ4L3N1MUFLRGVtOUFhWUNV?=
 =?utf-8?B?TlIybGVUdzZ4Q3BvbnlhZW96cTlxZWNYdlpmUXFYcnNUMUJSN3FlVlhaRXRE?=
 =?utf-8?B?R3dDUHdYWFVuTE4rSG9vV2oxNnA5M3Y3eXoweFdWZzAvelhHOHQvVmJlRXhF?=
 =?utf-8?B?dFIrcmVIK1RrMVduWXNzYTh4WUxleHBEMUlMWXN6cWRBS0N1V3dwSW9obFhM?=
 =?utf-8?B?YmxpUGNJaUN6ZklHejFqa3pRMEF1MEg2VXZjdjBSYWZsTy9HYzNXa28yMDZt?=
 =?utf-8?B?dGVQSFZKZ2M1NzBoTVN4amphc2lGc3QwYm9xT2VDYkIwRjY2UlBvZ3Z0a0w2?=
 =?utf-8?B?ZDN3cmFFekgxZDdOb3JSblRsYkxiaGhuL0VyUjZpT290UUlkMDl1L0Y3NmhD?=
 =?utf-8?B?ckh5Ri9nc2hpNzlPUnpRT2dnMkhCcURVQ3BKNi9HbTNvMGtsRG5UZlJtb3Yx?=
 =?utf-8?B?ZlhuWnpTb2RpL25BWStiSGtrUzNUaFNBRDFlV1NBbC9KK045c0Fha1d0K2lv?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abd6834a-ea24-4d8a-2b7b-08dc6ba00bd3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:37:11.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgnXLjmCBC7ZQHH/mTxCXMo7KJI8Fjz0PxUMhRihGl9F2Av0OUs3ZtfIpyJh5+gsPkPrf4Alaursu/wJ58T6ZPF89AQY9aFseRUWj7qJ4oA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com



On 2/15/2024 3:02 AM, kernel.org-fo5k2w@ycharbi.fr wrote:
> Hello,
> 
> (Please note that I don't speak English, sorry if the traction is not faithful to your language)
> 

Hi,

I haven't touched the ixgbe driver and hardware in many years, but I'll
try to see what I can do to help.

> Following Bjorn Helgaas's advice (https://bugzilla.kernel.org/show_bug.cgi?id=218050#c14), I'm coming to you in the hope of finding a solution to a problem encountered by several users of the ixgbe driver. The subject has been discussed in the messages and comments on the following pages:
> https://marc.info/?l=linux-netdev&m=170118007007901&w=2
> https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8.135129/
> https://www.servethehome.com/the-everything-fanless-home-server-firewall-router-and-nas-appliance-qotom-qnap-teamgroup/
> https://www.servethehome.com/intel-x553-networking-and-proxmox-ve-8-1-3/?unapproved=518173&moderation-hash=e57a05288058d3ff253ceb42e9ada905
> https://forum.proxmox.com/threads/proxmox-8-kernel-6-2-16-4-pve-ixgbe-driver-fails-to-load-due-to-pci-device-probing-failure.131203/
> https://bugzilla.kernel.org/show_bug.cgi?id=218491
> https://bugzilla.kernel.org/show_bug.cgi?id=218050
> 
> Having myself decided to purchase a Qotom Q20332G9-S10 machine with X553 chipset for testing purposes, I can see the effectiveness of the connection problem between the PC's X553 SFP+ and a Cisco switch SFP+. For my part, this happens under GNU/Linux Debian 12 - kernel 6.1.76 and Sid - kernel 6.6.13. So it's not specific to Proxmox.
> I should point out that under GNU/Linux Debian 11 - kernel 5.10, the network card (X553 via ixgbe) works without problems. So this is a relatively "recent" bug.
> 
> Here's my test environment:
> - 1 Qotom Q20332G9-S10 (I used a 16GB Intel Optane M10 M.2 SSD with a fresh GNU/Linux Debian 12)
> - 1 Cisco DAC cable (tested with a 1M and a 3M)
> - 1 PC with Mellanox Connectx-3 2x SFP+ network card (running GNU/Linux Debian SID installed several years ago)
> - 1 Cisco 3560CX-12PD-S switch (2 SFP+ ports) with IOS 15.2(7)E2
> 
> Connecting the Qotom Q20332G9-S10 (X553) to the Mellanox Connectx-3 works without a hitch and without any special handling (the linux-image-6.1.0-17-amd64 ixgbe driver works in this configuration). Full 10gbps speeds between the two with an "iperf".
> 

So everything works when connected back to back with the Connectx-3. Ok.

> At this stage, I've ruled out a hardware incompatibility (OSI level 1) since the DAC works with the X553. So there's no need to use compatibility tricks as suggested in the link comments with the "allow_unsupported_sfp=1" parameter. This will be useless in the following tests (I've checked).
> 

To confirm, you use the same cable in both cases?

> Where it gets tricky is when you connect it (the Qotom) to the Cisco switch.
> Before an "ip link eno1 up", the Cisco raises the link on its side, but the Debian doesn't (link DOWN). After the "ip link eno1 up", the link drops and never comes back. There does seem to be a driver problem in recent kernels (GNU/Linux Debian Stable and Sid).
> 

But on the switch, the link is reported up until we bring the interface
up in ixgbe, and then link drops and stays down indefinitely?

> After compiling the driver manually (https://downloadmirror.intel.com/812532/ixgbe-5.19.9.tar.gz) following the documentation already shared by others (https://www.xmodulo.com/download-install-ixgbe-driver-ubuntu-debian.html), it works with the Cisco (after a "shut/no shut" of the latter's 10gbe port).
> 
> So we end up with a working machine (I even configured and used the SR-IOV successfully right afterwards).
> 

But if you use the out-of-tree ixgbe driver everything works. Hmm.

> PS: I also tested with Debian Sid
> 
> I've finally tried the commands you were giving Skyler without any result (rmmod ixgbe; modprobe ixgbe; ethtool -S eno1 | grep fault).
> 
> For the moment, the Qotom machine is dedicated to testing, so I'm available to carry out any manipulations you may wish to make to advance the subject.
> Can we work on diagnosing this problem so that the next stable release of Debian is fully functional with this Intel network card?
> 
> Best regards.

I tried checking the out-of-tree versions to see if there were any
obvious fixes. I didn't find anything. The code between the in-kernel
and out-of-tree is so different that it is hard to track down. At first
I wondered if this might be a regression due to recent changes to
support new hardware, but it appears that v6.1 is from before a lot of
that work went in.

It may be helpful if you could provide some more information from the
system in the Cisco switch case:

1. The kernel message logs from when you bring up the interface. You can
get this from dmesg or journalctl -k if you have systemd.

2. "ethtool eno1" after you bring the interface up to see what it
reports about link

3. "ethtool -S eno1" to see if any other stats are reported that might
help us isolate whats going on.


Do you happen to know if any particular in-kernel driver version worked?
It would help limit the search for regressing commits. Ideally, if you
could use git bisect on the setup that could efficiently locate what
regressed the behavior.

Regards,
Jake

> 
> ⢀⣴⠾⠻⢶⣦⠀
> ⣾⠁⢠⠒⠀⣿⡁ Yohan Charbi
> ⢿⡄⠘⠷⠚⠋⠀ Cordialement
> ⠈⠳⣄⠀
> 

