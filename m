Return-Path: <netdev+bounces-291772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHzmFz/MFWq6bwcAu9opvQ
	(envelope-from <netdev+bounces-291772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:37:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E395D9CEC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7217B30A7167
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563438C2D4;
	Tue, 26 May 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8wlWRPD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C738BF61
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810549; cv=fail; b=OWCO09ZoYH9MGnTgq1L6aSfcjtnSINtadZxPZjlWF3RI/UGijZyZqRCsmSWXLgm3yaccvDtnZKF8RkGbgv/dmGUPeJQ4Fs43GzBLUN3rqDnrK8uHP8c3Slz/x3r2+XXqc8KTvyfmSW3C8FthaW1zvz8ren18HY0rXeI/JGVFAno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810549; c=relaxed/simple;
	bh=kJVTAgGGU6BqI8HHBoM2haHgWXJo5IN5hXJ9ilbihw8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnrQYIXrkD7eMuMF6lobveArKPrX0ZmKjSc3lhL3WLLdLoby9kbFjUozjBsAomNjvMQtAOmcG2NDEaIWOXhnMJ4Hxreb2QFCk6iazfRbiKrEO8wRBGqAM4QiswMWonm9hgoRZrZGBJKgoAcne32nAHrDnkhBMq9F3Bn/zM4NcoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8wlWRPD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779810547; x=1811346547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kJVTAgGGU6BqI8HHBoM2haHgWXJo5IN5hXJ9ilbihw8=;
  b=T8wlWRPD00yW5r8N55NrZQFE1zFYJk6YErq2YFsrypaJIgwryBAO3Owc
   Z+BGuKnU+pqLh8oLlGTKjWRJMXIlJRxvcINCPD8hH9mZ5UyiFWEPFjfit
   m6LMn/dh9f1RFMObXaRovtsGlleJ54ISGC25SDdi2jSXFNqN7Jmi9hglx
   BVGAmkfvSmELNwZzwDqFG1OLyMA+DsymTcuKEwaa21oEAQZ0TMPcuDOgd
   fnS6CI6G8BYKLqBcavnPgZ0Fhp3ds/9wepdVYNs/3zaWyFdIko+Mbd/+q
   othHfoJRxMwThj0pBsBbp6g4zZwBoAD6WXDFGF7OHOF5sN20Db92ZfFue
   w==;
X-CSE-ConnectionGUID: +DcbpBm/T1SeYqU1PULbWA==
X-CSE-MsgGUID: iSuCptCeSnSnw0L/6Kn6wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106085090"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="106085090"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:49:07 -0700
X-CSE-ConnectionGUID: TwEOhWyaTraU1c5mxbDLug==
X-CSE-MsgGUID: tKY5BciMTr6IvKBsLcPvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="240904566"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:49:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:49:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 08:49:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 08:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQNvP4IeQz8w4Id0B5K/Er0169JKwXjhXaXnLwNs/yk360sHh6fdq8t3gkt7TPJp2QdRDFJiTz7m7uTuLNIq3oCi4ovjRNtbOlrOsyoucDEVnh1uZDcnoD5hv3yKX4jjiLyjoeQ8mFEQF5r4X1zmtgSD7Bl6xC4f+yTzS/HJeKG2J92b78a2MJ1cRnbxnRSBD2i+K5BvFAR48a5o40yqpxWLEoP1T30iKw4z3hSw9IrsWFrW/GXIAVxsD1lEB8Y+O8hm90ldNMZRnIHkJcgNiU2VwW4l39bcVpJH1fR+7XI/byhqLdFzfu+FoExaGDOoXZkya4S3RnlmjLBCSw/PFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDh0bh174lw5wXCniRtYXcsNsrHtO7gFtPN4kN/eAtA=;
 b=gpxQfovzdj6ZDqeuMENgPuv7+dXod0yuKwrd0lVB5F8djIDv8WL+AUoUOwGAzXgwnt6Cqscld/xKzkQ34FMgJIGI0KARp1/Pci1Wolq9yfXlyZ5eW9WDJ7wc630GVrQ6iEMZ3+Ikj9wE1XEFvPvP1IwccYr0PTCRW+h0m1w0mAxvLYnkItzI2qyc68w3kfYY++IyKfgpn+wOKcpC7rSaBiWOXVECiBBX6DGVEU6EJCqOMHqwULpym6H7UL+URRZtlAN/u31/lrDjFzSngQbNn8eaGAAG7A5ze2WaVpq/EhX4fP4Kc3P65rL8YK/3zMODuOtexjTV5BCntIcbaCg1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8318.namprd11.prod.outlook.com (2603:10b6:806:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 15:49:04 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 15:49:04 +0000
Message-ID: <2b2704e6-389d-43ac-be90-bbb4785582d7@intel.com>
Date: Tue, 26 May 2026 17:48:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfc: digital: clamp sensf_res memcpy to
 NFC_SENSF_RES_MAXSIZE
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: <oe-linux-nfc@lists.linux.dev>, <security@kernel.org>,
	<netdev@vger.kernel.org>
References: <20260526093112.22614-1-doruk@0sec.ai>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260526093112.22614-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0261.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::34) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 74435ee8-4e25-4ccf-ce58-08debb3e4ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|83080400003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4sir6espb30AEWsPzXpewsZCr/jKYHvDzOq1VTpN50ij5XUQMhDP7kDzWc0hdrGRN6dvxtuP5nkEcTwNl+I62wxCPqN7VC5URe504NgpHhlznG+TbZK6+awoGZ/w/xxZTysp6BqYasBCG+7+fm+x7ZrrNUyD5bT59cXACHT93eZzS1ZcpQYPyKKacUX9rSgZFwc9ESIo7o4jePF55sPeCnWvjHZxvWHr9buiVcUwT0dVgHhAHxuNDfpN490Mhe8r/KI9X+OSLnZYrUS122atpp73WTnDpPF8ZQSYpAcpgaNKRDQRTDLsEl/QnYoOKApzXgCpXGgYQ1ejVnLpZmUUq9qJf0U6DQyUrKHDoueGkW+fahjnh0wNOdhDiOS6fJPyjK4t08SHcF5hiMLyDcAAQA/gqOpIOZlUTrS3rFu7YwdVZDAa+FQoSvjC2AzIMzuBHiN8lC0WCnPYnERydO14ey0iCgRC8I3qpDFP/DGkVgY8G1aadSmzczxtk1Q5Z13NK1pO+xDcgfsW+ty1pOLmnOm79/M9Ev0hAMw9jPMKlVX7bMH+lCNWofgW54aNKRyZtTyfStdIz8YTf7KTu8jJEYrCRL8yMeWMHF9OoRg7lmvNKyEQpnOO51MiuIZmO4XR/kb26bjcxJr7ICAuqtZ8hvf0A/KFmq2KmLeLX1F5TetldUo++jcjP3rgVaWiisq0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(83080400003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlvcnpqQW8rbmttcE9xZjVad0xzbC9kMTRwQndxRytUeEhtMDBnN1AyVE9o?=
 =?utf-8?B?eS8zMTBNNmlaZlFNMHFXdlVrNmlCdFRsYVYxS3RpVWJ4d3hMVk9SUElYR0tW?=
 =?utf-8?B?MlhHSkJsdHY1T3VlMnpCeHIrOFdTSElqRHlEV0xHYjNVdVkyRTNPTEg0YUt0?=
 =?utf-8?B?WWxwSzZQZ3VWVlJhV1I1SnNzT0xmR251aUVxY0MyWENkN2JGaFJHTy91TVhp?=
 =?utf-8?B?Q05MaHZ0cTJBUFB4RmFRWDE1U1RDbHpsTlNwMXQ5Z095cTBLOW10TWtUL0Zv?=
 =?utf-8?B?N0VRKzhpeEtzQ2h0bFV0ZCs3aUtXQVdnc3ZnNllGT1BlbS8xemxRKytiYkxk?=
 =?utf-8?B?ZTFocmpuY1VmOWRPQWhiNkhYeW1uSGQ0MU5vVDdJd2dCN1lKWmhmQ3VDQVI3?=
 =?utf-8?B?RmZLRlNmRVZvYjhFaXdjYVY5dk1OQVpxQXhwRUwrNnluTU1obC8zdjFxbito?=
 =?utf-8?B?Ym9FUjJMWm1nTDM2ZUFGeFUwWVRhLzZPRThYdmNleUduV3JldW9zYVJJaXZq?=
 =?utf-8?B?UURuMnJNSlhpTzZFVUplVFFIUG56TmtCYzJ3Wkh1TE9GQ3hFMkIyb2NjN0VM?=
 =?utf-8?B?cGlyTDRhaXRPVXdRYVNvZFlCRzRpcHpFL21tZjZONTdlMGliSVEzUDBYaTZm?=
 =?utf-8?B?V2Y1dXNqeEduazdxZmc1WElXTThYYVdnTHJ3cUE1U2NUOGhCMGhoNTlvNlds?=
 =?utf-8?B?eUdQYTB6RXpIZGNxVXRPRUEvSGg5ZWhXN3VBdDdvSWVqMUYvQWZKdFdQUmR4?=
 =?utf-8?B?QXQyMldHekpjM2FmUzdEWTI2Q2JrdGVKcTl1dW9udk8waG9QN3RWMFRjanQx?=
 =?utf-8?B?ZE41QU1aQXVxOUZBa3NUend0dExEbHhPSVR1Z0F1SkdQSnRMRllhWXA0MzNk?=
 =?utf-8?B?dGV2UllxY1NoNjZ4SEtTVTBvTTM3cXU3bURaeFJKcmQ1QytJb1pmWW1rbkdK?=
 =?utf-8?B?eHlvYlQ2U0xJUE85eGtOeE83b1V5eGVMUytBdEpOV3NYaGRVSEhKdW5yUGpS?=
 =?utf-8?B?N1Zqd0UyTWV2MksvY3FXYXJvZ21BejhJWldTTiswZi92WnJHV0tBemhjYWty?=
 =?utf-8?B?NzdmVTA0bllmQWNHR2U3QkV5azVWOVJESHBrN1VLRzAxOW9HRVJvUmo3cUtW?=
 =?utf-8?B?RE9MZ28ra0paRmZYWHRjbyttVVFrYzg5eGMyeFd2LzF3RUc5SThqaUczT3Yz?=
 =?utf-8?B?ZmxlOGsrK1pzVDlNR1VEOTBGcWZlelc3ZEJCWDJzT2lkWWxBaFVLQzFNNFFS?=
 =?utf-8?B?RnpDK0M5cVhYMjRVM29TMDA4ZjFPaGpDMi9wZGw2dmtVNnNkd2xaMU5mQis1?=
 =?utf-8?B?ajBteU82dDRhbzh3SEJWWkE5a1Q2YzhZcVNWLzlDdlM4K0UrdDZFYXNscnIz?=
 =?utf-8?B?QkgvNXlKdkFZb2RnZS9hRkNNVVlSbXNUSUFvN1ZtNE9yTlV0alVscEo2ejJG?=
 =?utf-8?B?NHVzY3dtbE9sc05FSDFiakh0dzZQbE1TTGFMYmQ4emVpU0VjKy9MYk82ME80?=
 =?utf-8?B?aSt4UDVoa21Hbm5HMERvU0VzOFR1c1RXa01BRVpkN1JoYlREN2pianJDUjJs?=
 =?utf-8?B?MFJDWEFCaFdOa0p6UzlEVTdBb013T0FNdlQ0T3ZaZHV3eTNzblZ4V0JXeHpB?=
 =?utf-8?B?VVVwRnc4YUswbG90aW82SnJTbmlUNWdoNVBHNFU1SVh3NklYSkNWSVZaTHl1?=
 =?utf-8?B?T05jbHR1SWdrS0JGS096WVdiNmh1eWVVdVVKMENqc1Frc3R4YnpXNWNPa2dF?=
 =?utf-8?B?OGJCL2dSQkhOdXVLMUNWbWkwVG1FajRuSjkvN3NPVlhvT2I2UjZrb3g2eGhu?=
 =?utf-8?B?NHVnaVhmeWhjRm5UWjRtZnJrNkJVczhxNE9RNVpTck9hTVJwV0dXR2krcnM0?=
 =?utf-8?B?bXhGMy9BZlAxSVZIQktvK2hqZDB6bk5RaytaMlpOeVlrSU5ZVlZmOEhWalFl?=
 =?utf-8?B?eFA0ZlVHSUx6cTlNWXlnbDRUcXR2RGFsekVyUVg2OTF1N3ZKQkpBWno5bGor?=
 =?utf-8?B?N2VEQ2FUNVB3ZUJXRlVweWNXN0gyVFhxcEVzckVHZ3VzU3g2VkY4OWFDbVcz?=
 =?utf-8?B?TkQraVdtZzROS3FGd0NJcjFhTzVCS2FFZjBha2dRSG9LTHY0MFVEM1JrWDhi?=
 =?utf-8?B?YWNsMEZNNnlLZksvK3lZa2EraU5Sd2tCTjBBTDlYa3VwNXRvSnRQeGRsNFFu?=
 =?utf-8?B?bEJvNHVRM2VvSy9XT0NxRnZMOHlZd1VyY000WDU4YzhaVWlMUXRmeUJlWTJT?=
 =?utf-8?B?VFVuZE9vcnprVitsL2JMblBNejlEeWdPQlc5VGx5WisxcGNhN2FueFVOUCtP?=
 =?utf-8?B?SWpVcDJmSm4rS1M4dmErN3l5M1lRcU1idFNIcEMzelk5dUpzcGJsUkhFUkxI?=
 =?utf-8?Q?SUNj12qyxh+naW4E=3D?=
X-Exchange-RoutingPolicyChecked: ATmVI5GtEZW11ii3pRSoQ7JEP9yiptrJ7iydIR7brfr3MXMXP/6yezpOYiiHz6G1WKuMd9ddytGaW5JyMt+Zu3fCAIhJY3RRCGGUT20i6O76aveHCDL63gr2F46W6VFb6Re9g9xuypo5AV7ebZ4sP38H4JbZGbWEHWDWhFjxx140cFgVWBb9wexGFSav75zic6e250ti+HGDhJaywe2z4tarGEI5zIibXQYgcVr1YKLSlMt2wF9fba2kUne9L7dTC/rERVm/WE9oZcxWg/f7xtcTi4KLk3MnrfE4jXxsbE16t5X6u9ytznmjibzOilJJsxh0P7yStmmVBXb+JwUl1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 74435ee8-4e25-4ccf-ce58-08debb3e4ffd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:49:04.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKwQlJxfrufKbeJVKamDWIdipJE5lSnLQgSyP9U6TvzRDcQJoN9kipCceT+vc77BSApchCyG6VuxTfz+eiITnKMSL1uBZMSmASxbnT5Xk2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8318
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291772-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,0sec.ai:url,0sec.ai:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B8E395D9CEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Tue, 26 May 2026 11:31:12 +0200

> [PATCH] nfc: digital: clamp sensf_res memcpy to NFC_SENSF_RES_MAXSIZE

This should be marked as "PATCH net-next" or "PATCH net". This is a fix
I believe, so most likely the latter.

> digital_in_recv_sensf_res() copies resp->len bytes from a remote
> NFC-F device response into target.sensf_res without checking that
> the length fits in the 18-byte destination buffer
> (NFC_SENSF_RES_MAXSIZE).
> 
> A nearby malicious NFC-F device can send an oversized SENSF_RES
> response to overflow the stack-local struct nfc_target, potentially
> overwriting saved registers and the return address.
> 
> Fix by clamping the copy length to NFC_SENSF_RES_MAXSIZE.
> 
> Found by pwnkit (https://github.com/0sec-labs/pwnkit), an automated
> kernel source review tool by 0sec (https://0sec.ai).

If this is a fix, it should contain a "Fixes:" tag pointing to the
commit which introduced this vulnerability.

If the original commit landed a long ago, you might want to add
"Cc: stable@vger.kernel.org" to mark it as a candidate for backporting
to the LTSes.

> 
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  net/nfc/digital_technology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev,
>  
>  	sensf_res = resp->data;
> +	if (resp->len > NFC_SENSF_RES_MAXSIZE)
> +		resp->len = NFC_SENSF_RES_MAXSIZE;

Alternatively:

	resp->len = min(resp->len, NFC_SENSF_RES_MAXSIZE);

A matter of taste anyway.

You can also leave a comment above this line saying that it's necessary
to validate the value and make sure it doesn't overflow.

>  	memcpy(target.sensf_res, sensf_res, resp->len);

Thanks,
Olek

